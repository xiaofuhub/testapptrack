$PBExportHeader$w_company.srw
$PBExportComments$PTDATA.     The company info window.
forward
global type w_company from window
end type
type cb_lanes from commandbutton within w_company
end type
type cb_details from commandbutton within w_company
end type
type cb_nofac from commandbutton within w_company
end type
type cb_makefac from commandbutton within w_company
end type
type cb_replace from commandbutton within w_company
end type
type dw_car_info from datawindow within w_company
end type
type st_2 from statictext within w_company
end type
type cb_delfac from commandbutton within w_company
end type
type cb_newfac from commandbutton within w_company
end type
type st_1 from statictext within w_company
end type
type dw_facility_list from datawindow within w_company
end type
type cb_selco from commandbutton within w_company
end type
type cb_delco from commandbutton within w_company
end type
type cb_delct from commandbutton within w_company
end type
type cb_newct from commandbutton within w_company
end type
type cb_newco from commandbutton within w_company
end type
type dw_co_info from datawindow within w_company
end type
type dw_facility_details from datawindow within w_company
end type
type dw_contacts from u_dw_companycontacts_list within w_company
end type
type cb_car_ct from commandbutton within w_company
end type
end forward

global type w_company from window
integer y = 160
integer width = 3630
integer height = 1900
boolean titlebar = true
string title = "Company Information"
string menuname = "m_company"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 12632256
event set_buttons pbm_custom04
event focus_response pbm_custom13
event show_pop pbm_custom16
event ue_payablessetup ( )
event ue_sendoutboundmessage ( )
event ue_companydetails ( )
event ue_edisetup ( )
event ue_edilog ( )
event ue_showaliaslist ( )
event ue_showallalerts ( )
event ue_documenttransfersetup ( )
event ue_invoicetransfersetup ( )
event ue_selectcompany ( string as_type )
event ue_newcompany ( string as_newname )
cb_lanes cb_lanes
cb_details cb_details
cb_nofac cb_nofac
cb_makefac cb_makefac
cb_replace cb_replace
dw_car_info dw_car_info
st_2 st_2
cb_delfac cb_delfac
cb_newfac cb_newfac
st_1 st_1
dw_facility_list dw_facility_list
cb_selco cb_selco
cb_delco cb_delco
cb_delct cb_delct
cb_newct cb_newct
cb_newco cb_newco
dw_co_info dw_co_info
dw_facility_details dw_facility_details
dw_contacts dw_contacts
cb_car_ct cb_car_ct
end type
global w_company w_company

type variables
public:
long co_to_display

protected:
integer mboxret, redraw_row
boolean winisclosing, abort_close
long il_pcmilerversion=11
String isa_Topic[]
n_cst_trip		inv_trip
n_cst_routing	inv_routing
boolean		ib_oldpcmilerversion
boolean		ib_pcmilerconnected
boolean		ib_pcmilerstreets
boolean		ib_canadianpostal
DataStore	ids_Contacts

Constant String	cs_Color_Disabled = "78682240"

end variables

forward prototypes
protected function integer change_response (datawindow dw_mod, long mod_row, dwobject mod_dwo, string mod_data)
protected function integer set_tz (datawindow dw_tz, long tz_row, string tz_state)
public subroutine save_request ()
protected function integer save ()
protected function integer retr ()
protected function boolean needs_update ()
protected function boolean check_tz (string state, integer tz)
protected subroutine wf_alter_company (string as_type)
protected function string of_getstreetlatlong (string as_address, string as_locater, ref string as_newaddress)
protected function integer of_checkstreetinzip (string as_street, string as_zip, ref string as_foundlocator)
protected function integer of_checkstreetincitystate (ref string as_street, string as_city, string as_state, ref string as_foundlocater)
protected function string of_streetsverification (ref string as_street, ref string as_city, ref string as_state)
public function integer wf_contactdetails (long al_contactid)
public function integer wf_newcontact ()
protected function integer wf_retrievecontacts ()
private function integer wf_initializecontacts ()
private function integer of_disableentryfields ()
end prototypes

event set_buttons;if co_to_display >= 0 then
	cb_delco.enabled = true
	cb_replace.enabled = true
	cb_makefac.enabled = true
	if dw_car_info.visible = true then
		cb_car_ct.text = "Hide &Carrier Info"
	elseif dw_car_info.rowcount() > 0 then
		cb_car_ct.text = "&Carrier Info"
		cb_lanes.Visible = TRUE
	else
		cb_lanes.Visible = FALSE
		cb_car_ct.text = "Make Co a &Carrier"
	end if
	
	cb_car_ct.enabled = true
	cb_newfac.enabled = true
	if dw_facility_list.getselectedrow(0) > 0 then
		cb_delfac.enabled = true
		cb_nofac.enabled = true
	else
		cb_delfac.enabled = false
		cb_nofac.enabled = false
	end if
	cb_newct.enabled = true
//	if ids_contacts.getselectedrow(0) > 0 then &
//		cb_delct.enabled = true else cb_delct.enabled = false
else
	cb_delco.enabled = false
	cb_replace.enabled = false
	cb_makefac.enabled = false
	cb_newfac.enabled = false
	cb_delfac.enabled = false
	cb_nofac.enabled = false
	cb_newct.enabled = false
	cb_delct.enabled = false
	cb_car_ct.text = "Make Co a &Carrier"
	cb_car_ct.enabled = false
	cb_lanes.Visible = FALSE
end if
end event

event focus_response;
/*
	I commented some select text below because they were not working in PB9 <<*>>
*/

integer which_dw, currow
which_dw = message.wordparm

datawindow dw_for_this
choose case which_dw
	case 1
		dw_for_this = dw_co_info
	case 2
		dw_for_this = dw_facility_details
	case 3
		dw_for_this = dw_contacts
	case else
		return
end choose

currow = dw_for_this.getrow()
if currow < 1 then return

string newcol
newcol = dw_for_this.getcolumnname()

if which_dw = 3 then
	dw_for_this.modify("ct_dirphone.edit.format = ''")
	dw_for_this.modify("ct_dirfax.edit.format = ''")
	choose case newcol
		case "ct_dirphone", "ct_dirfax"
			dw_for_this.modify(newcol + ".editmask.mask = '(###) ###-#### ~~x####'") 
			dw_for_this.settext(dw_for_this.getitemstring(currow, newcol))
			//dw_for_this.selecttext(1, 21) <<*>>
	end choose
	return
end if

dw_for_this.modify("co_phone1.edit.format = ''") //removes the mask and restores edit
dw_for_this.modify("co_phone2.edit.format = ''")
dw_for_this.modify("co_fax.edit.format = ''")
dw_for_this.modify("co_zip.edit.format = ''")
if which_dw = 1 then
	dw_for_this.modify("co_bill_phone1.edit.format = ''")
	dw_for_this.modify("co_bill_phone2.edit.format = ''")
	dw_for_this.modify("co_bill_fax.edit.format = ''")
	dw_for_this.modify("co_bill_zip.edit.format = ''")
end if

choose case newcol
	case "co_phone1", "co_phone2", "co_fax"
		if dw_for_this.getitemstring(currow, "co_usnon") = "U" then
			if dw_for_this.getitemstring(currow, "co_state") = "MX" then return
			dw_for_this.modify(newcol + ".editmask.mask = '(###) ###-#### ~~x####'") 
			dw_for_this.settext(dw_for_this.getitemstring(currow, newcol))
			//dw_for_this.selecttext(1, 21) <<*>>
		end if
	case "co_zip"
		if dw_for_this.getitemstring(currow, "co_usnon") = "U" then
			if pos("AB BC MB NL NB NF NT NS NU ON PE PQ QC SK YK YT MX", &
				dw_for_this.getitemstring(currow, "co_state")) > 0 then 
				dw_for_this.modify("co_zip.edit.case = 'UPPER'")
			else
				dw_for_this.modify("co_zip.editmask.mask = '#####-####'")
			end if			
		end if
		dw_for_this.post function settext(dw_for_this.getitemstring(currow, "co_zip"))
		dw_for_this.post function selecttext(1, 10)
	case "co_bill_phone1", "co_bill_phone2", "co_bill_fax"
		if dw_for_this.getitemstring(currow, "co_bill_usnon") = "U" then
			if dw_for_this.getitemstring(currow, "co_bill_state") = "MX" then return
			dw_for_this.modify(newcol + ".editmask.mask = '(###) ###-#### ~~x####'") 
			dw_for_this.settext(dw_for_this.getitemstring(currow, newcol))
			//dw_for_this.selecttext(1, 21) <<*>>
		end if
	case "co_bill_zip"
		if dw_for_this.getitemstring(currow, "co_bill_usnon") = "U" then
			if pos("AB BC MB NL NB NF NT NS NU ON PE PQ QC SK YK YT MX", &
				dw_for_this.getitemstring(currow, "co_bill_state")) > 0 then return
			dw_for_this.modify("co_bill_zip.editmask.mask = '#####-####'")
			dw_for_this.settext(dw_for_this.getitemstring(currow, "co_bill_zip"))
			dw_for_this.selecttext(1, 10)
		end if
end choose
end event

event show_pop;integer which_one
which_one = message.wordparm

datawindow dw_for_this
string oap, obname, obname2, lsa_parm_labels[], ls_selection
any laa_parm_values[]




choose case which_one
case 1
	dw_for_this = dw_co_info
case 2
	dw_for_this = dw_facility_list
case 3
	dw_for_this = dw_facility_details
case 4
	dw_for_this = dw_contacts
//case 5
//	dw_for_this = dw_ct_info
case else
	return
end choose

oap = dw_for_this.getobjectatpointer()

integer tabpos, clrow, markloop, response, approval
long ll_coid
tabpos = pos(oap, "~t", 1)

if tabpos < 1 then return

obname = left(oap, tabpos - 1)
obname2 = obname
clrow = integer(mid(oap, tabpos + 1))

choose case obname
case "co_name"
	obname2 = "co_id"
case "ct_sal", "ct_fn", "ct_mi", "ct_ln", "comp_comb_name", "txt_unspec"
	obname2 = "ct_id"
end choose

choose case obname2
case "co_id"
	ll_coid = dw_for_this.getitemnumber(clrow, obname2)
	
	if ll_coid < 1 then return
	
	lsa_parm_labels[1] = "ADD_ITEM"
	laa_parm_values[1] = "&Details"

	lsa_parm_labels[2] = "ADD_ITEM"
	laa_parm_values[2] = "-"

	lsa_parm_labels[3] = "ADD_ITEM"
	laa_parm_values[3] = "Add &Alert"
	
	ls_selection = f_pop_standard(lsa_parm_labels, laa_parm_values)

	choose case ls_selection
	case "DETAILS"

		n_cst_Msg	lnv_Msg
		s_Parm		lstr_Parm
		
		lstr_Parm.is_Label = "Source"
		lstr_Parm.ia_Value = dw_For_This		
		lnv_Msg.of_Add_Parm ( lstr_Parm )

		lstr_Parm.is_Label = "Row"
		lstr_Parm.ia_Value = clrow
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
		OpenWithParm ( w_CompanyDetail, lnv_Msg )
		
	CASE "ADD ALERT"
		n_cst_beo_Company	lnv_Company
		lnv_Company = CREATE n_cst_beo_Company
		
		lnv_Company.of_SetUseCache( TRUE )
		lnv_Company.of_SetSourceid( ll_coid )
		lnv_Company.of_Adduseralert( )
		
		DESTROY ( lnv_Company )
		
		
	end choose

//case "ct_id"
//	ll_coid = dw_for_this.getitemnumber(clrow, obname2)
//	if ll_coid < 1 then return
//	lsa_parm_labels[1] = "ADD_ITEM"
//	laa_parm_values[1] = "Co&mments"
//	choose case f_pop_standard(lsa_parm_labels, laa_parm_values)
//	case "COMMENTS"
//		mboxret = 1
//		openwithparm(w_text_edit, ll_coid * 100 + 3)
//	end choose
end choose
end event

event ue_payablessetup();Long	ll_CompanyId, &
		ll_EntityId
w_tv_AmountTemplates			lw_AmountTemplates  // new tree view window
//w_AmountTemplates			lw_AmountTemplates

n_cst_Privileges			lnv_Privileges
String	ls_MessageHeader = "Payables Setup"

ll_CompanyId = co_to_display

IF lnv_Privileges.of_Settlements_EntitySetup ( ) = TRUE AND ll_CompanyId > 0 THEN
	
	//User is authorized, and company is legit.
	
	CHOOSE CASE gnv_cst_Companies.of_GetEntity (ll_CompanyId, ll_EntityId, &
		TRUE /*AllowCreate*/, TRUE /*AskToCreate*/ )
	
	CASE 1

		//Entity Exists.  Display the Payables Setup window.
		SetPointer ( HourGlass! )
		OpenSheetWithParm ( lw_AmountTemplates, ll_EntityId, gnv_App.of_GetFrame ( ), 0, Layered! )
	
	CASE 0
	
		//Not found (and user chose not to create.)
	
	CASE ELSE //-1
	
		//Error
	
		MessageBox ( ls_MessageHeader, "Could not process request.  Request cancelled.", Exclamation! )
	
	END CHOOSE

ELSE
	//User is not authorized.  Display notification message.
	MessageBox ( ls_MessageHeader, lnv_Privileges.of_GetRestrictMessage ( ) )

END IF

end event

event ue_sendoutboundmessage;//////////////////////////////////////////////////////////////////////////////
//
//	Userevent:  of_SendOutboundMessages
//
//	Access:  public
//
//	Arguments:  ads_message by reference
//
//
//	Description:	Send the n_cst_constants.cs_ReportTopic_COMPANY to the
//						w_dataselection window to get the template folder.
//						Cache the company beo and pass to w_communication_outbound.
//						w_communication_outbound will round up the destination,
//						device, and template and launch the communication manager.
//					
//
// Written by: Norm LeBlanc & Rick Zacher
// 		Date: 11/17/00
//		Version: 3.0.4
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

String	ls_Folder, &
			ls_Topic, &
			lsa_DeviceList[], &
			ls_Device
			
n_cst_Msg	lnv_Msg
s_parm		lstr_Parm
S_BeoArrays	lstr_Beos
w_templateSelection lw_DataSelection
n_ds	lds_EventCache
Any					laa_Data[]
n_cst_Beo_Company	lnva_Company[]


Int	i
Long	ll_Row
Long	ll_CompanyID
Long	lla_EventIDs[], &
		ll_devicecount
		
//Boolean 	lb_OpenDlg = FALSE
		

isa_Topic[1] = n_cst_constants.cs_ReportTopic_COMPANY


lstr_Parm.is_Label = "TOPICARRAY"
lstr_Parm.ia_Value = isa_Topic
lnv_Msg.of_Add_Parm ( lstr_Parm )

ll_Row = dw_co_info.GetRow ()
ll_CompanyID = dw_Co_Info.GetItemNumber ( ll_Row, "co_id" )

IF ll_CompanyID > 0 THEN

	lnva_Company[1] = CREATE n_cst_beo_Company
	
	gnv_cst_Companies.of_Cache ( ll_CompanyID, TRUE )
	lnva_Company[1].of_SetUseCache ( TRUE )
	lnva_Company[1].of_SetSourceId ( ll_CompanyId )
	
	laa_Data = lnva_Company

	n_cst_bso_Communication_Manager lnv_Communication

	lnv_Communication = CREATE    n_cst_bso_Communication_Manager
	//
	IF IsValid ( lnv_Communication ) THEN
		ll_DeviceCount = lnv_Communication.of_GetLicensedDevices ( lsa_DeviceList ) 
		IF ll_DeviceCount > 0 AND UpperBound (lsa_DeviceList) > 0 THEN
			ls_Device = lsa_DeviceList[1]
		END IF
	END IF
	
	IF isValid  ( lnv_Communication ) THEN
		DESTROY lnv_Communication
	END IF
	
	lstr_Parm.is_Label = "DEVICE"
	lstr_Parm.ia_Value = ls_Device
	lnv_Msg.of_Add_Parm (lstr_Parm )
	
	lstr_Parm.is_Label = "TEMPLATEPATH"
	lstr_Parm.ia_Value = ls_FOLDER
	lnv_Msg.of_Add_Parm (lstr_Parm)
	
	// !!!! THIS SHOULD ALWAYS BE THE LAST PARM ADDED TO THE MESSAGE OBJECT
	// IT WILL NOT WORK IF ANYTHING IS ADDED AFTER IT. I DON"T KNOW WHY?
//	lstr_Beos.inva_Events = lnva_Events
	lstr_Beos.inva_Companies = lnva_Company

	lstr_Parm.is_Label = "BEOS"
	lstr_Parm.ia_Value = lstr_Beos
	lnv_Msg.of_Add_Parm ( lstr_Parm )	
	
//	lstr_Parm.is_Label = "DATA"
//	lstr_Parm.ia_Value = laa_Data
//	lnv_Msg.of_Add_Parm ( lstr_Parm )
			
	openWithParm  ( w_communication_outbound, lnv_Msg )
	
	DESTROY lnva_Company[1]			
				
END IF

end event

event ue_companydetails;n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm

SetPointer ( HOURGLASS! )

lstr_Parm.is_Label = "Source"

IF dw_Facility_Details.Visible THEN
	lstr_Parm.ia_Value = dw_Facility_Details
ELSE
	lstr_Parm.ia_Value = dw_Co_Info
END IF

lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "CONTACTS"
lstr_Parm.ia_Value = ids_Contacts
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "COMPANYID"
lstr_Parm.ia_Value = co_to_display
lnv_Msg.of_Add_Parm ( lstr_Parm )

OpenWithParm ( w_CompanyDetail, lnv_Msg )
end event

event ue_edisetup();w_EDIProfile	lw_EDIProfile
	
s_parm		lstr_parm
n_cst_msg	lnv_msg

n_cst_Privileges	lnv_Privileges

IF lnv_Privileges.of_HasAdministrativeRights ( ) THEN

	if co_to_display = 0 then
		messagebox('EDI Setup', 'You must save the company before you can enter the EDI setup.')
	else
		lstr_Parm.is_Label = "COMPANYID"
		lstr_Parm.ia_Value = co_to_display
		lnv_Msg.of_Add_Parm (lstr_Parm)
	
		openwithparm(lw_EDIProfile, lnv_Msg, gnv_App.of_GetFrame())
	end if
	
ELSE
	MessageBox ( "EDI Setup", lnv_Privileges.of_GetRestrictMessage ( ) )
END IF

end event

event ue_edilog();n_cst_msg	lnv_Msg
S_parm		lstr_Parm
w_edilog 	lw_log
IF co_to_display > 0 THEN
	lstr_Parm.ia_Value = co_to_display
	lstr_Parm.is_Label = "COMPANYID"
	lnv_Msg.of_Add_parm( lstr_Parm )
	
	OpenSheetWithParm ( lw_log  , lnv_Msg, gnv_App.of_GetFrame ( ) , 0 ,Layered! )
ELSE
	MessageBox ("EDI Log" , "Please save the company befor viewing the log." )
END IF
end event

event ue_showaliaslist();Long	ll_CoID

n_cst_msg	lnv_Msg
S_Parm		lstr_Parm


if dw_facility_details.visible THEN
	IF MessageBox ( "Alias List" , "If you continue you will be setting up an alias list for the facility since the details are open.", Information!, OKCANCEL! , 1 ) = 1  then
		ll_CoID = dw_Facility_details.GetItemnumber( dw_facility_details.GetRow ( ) , "co_id")
	END IF
ELSE
	ll_CoID = co_to_display
end IF

IF ll_CoID > 0 THEN
	
	lstr_Parm.is_Label = "PTCO"
	lstr_Parm.ia_Value = ll_CoID
	lnv_Msg.of_add_parm( lstr_Parm )
	
	OPENWithParm ( w_Companyalias , lnv_Msg )
END IF
end event

event ue_showallalerts();n_cst_alertManager	lnv_AlertManager
n_cst_beo_Company	lnva_List[]
n_cst_AnyArraysrv	lnv_Array

lnv_AlertManager = CREATE n_cst_Alertmanager

gnv_cst_companies.of_Getfacilities( co_to_display , lnva_List )
n_cst_beo_Company	lnv_Company
lnv_Company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache( TRUE )
lnv_Company.of_SetSourceid( co_to_display )

lnva_List[UpperBound ( lnva_List ) + 1 ] = lnv_Company
lnv_AlertManager.of_ShowAllAlerts( lnva_List )


DESTROY ( lnv_AlertManager )
lnv_Array.of_Destroy ( lnva_List )




end event

event ue_documenttransfersetup();
n_cst_Privileges	lnv_Privileges

IF lnv_Privileges.of_HasAdministrativeRights ( ) THEN

	if co_to_display = 0 then
		messagebox('Document Transfer Setup', 'You must save the company before you can enter the setup.')
	else
		openwithparm(w_companydocumenttransfersettings, co_to_display , gnv_App.of_GetFrame())
	end if
	
ELSE
	MessageBox ( "Document Transfer Setup", lnv_Privileges.of_GetRestrictMessage ( ) )
END IF

end event

event ue_invoicetransfersetup();n_cst_Privileges	lnv_Privileges

IF lnv_Privileges.of_HasAdministrativeRights ( ) THEN

	if co_to_display = 0 then
		MessageBox('Invoice Transfer Setup', 'You must save the company before you can enter the setup.')
	else
		OpenWithParm(w_CompanyInvoiceTransferSettings, co_to_display , gnv_App.of_GetFrame())
	end if
	
ELSE
	MessageBox ( "Document Transfer Setup", lnv_Privileges.of_GetRestrictMessage ( ) )
END IF
end event

event ue_selectcompany(string as_type);String	ls_Header

IF as_Type = "NEW!" THEN
	ls_Header = "Add New Company"
ELSE
	ls_Header = "Company Selection"
END IF
//begin modification goto statement by appeon  20070730
//if needs_update() = false then goto selection
//
//choose case messagebox(ls_Header, "Save changes to current company?", &
//	question!, yesnocancel!, 1)
//		case 2
//			goto selection
//		case 3
//			return
//end choose
//
//if save() = 1 then goto selection
//
//if messagebox(ls_Header, "Could not save changes to database.~n~nPress OK "+&
//	"to abandon changes and select another company, or Cancel to return to the current "+&
//	"company and preserve changes for now.", exclamation!, okcancel!, 2) = 2 then return
//
//selection:

integer li_re

if needs_update() then 
	li_re = messagebox(ls_Header, "Save changes to current company?", question!, yesnocancel!, 1)
	if li_re = 3 then
		return
	elseif li_re= 1 then
		li_re = save() 
		if li_re <> 1 then
			 if messagebox(ls_Header, "Could not save changes to database.~n~nPress OK "+&
	"to abandon changes and select another company, or Cancel to return to the current "+&
	"company and preserve changes for now.", exclamation!, okcancel!, 2) = 2  then return
			
		end if			
	end if		
end if	

//end modification goto statement by appeon  20070730

s_co_info	lstr_Company
Constant Boolean	lb_Search = FALSE
String	ls_Search = ""
Constant Boolean	lb_Validate = FALSE
Long		ll_ValidateId = 0
Boolean	lb_AllowNew = TRUE
Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE

//Suppress w_company_response window, we will deal with it here
Constant Boolean	lb_SuppressNewWindow = TRUE 

n_CsT_Privileges	lnv_Privs

lb_AllowNew = lnv_Privs.of_HasEntryrights( ) 


CHOOSE CASE gnv_cst_Companies.of_Select ( lstr_Company, as_Type, lb_Search, ls_Search, lb_Validate, ll_ValidateId, &
	lb_AllowHold, lb_Notify, lb_AllowNew, lb_SuppressNewWindow )
case 1
	if lstr_company.co_id = co_to_display or lstr_company.co_facility_of = co_to_display &
		then return
	co_to_display = lstr_company.co_id
	retr()
 case -2
	
	This.Event ue_NewCompany(lstr_Company.co_Name)
	
case else
	if isnull(co_to_display) then
		winisclosing = true
		close(this)
	end if
end choose
end event

event ue_newcompany(string as_newname);String	xon_1, xon_2

gf_coname_index(as_newname, xon_1, xon_2)

IF len(righttrim(xon_2)) > 0 THEN
	xon_2 = xon_2 
ELSE
	setnull(xon_2)
END IF

dw_facility_details.visible = false
dw_car_info.visible = false
dw_facility_details.reset()

dw_car_info.reset()
dw_co_info.reset()

dw_co_info.insertrow(0)
co_to_display = 0

This.wf_InitializeContacts ( )

dw_co_info.object.co_id[1] = co_to_display
dw_co_info.object.co_name[1] = as_newname
dw_co_info.object.co_xon_1[1] = xon_1
dw_co_info.object.co_xon_2[1] = xon_2

dw_co_info.SetColumn ( "co_addr1" )
dw_co_info.SetFocus ( )

This.postevent("set_buttons")
end event

protected function integer change_response (datawindow dw_mod, long mod_row, dwobject mod_dwo, string mod_data);setpointer(HourGlass!)
string	col_name, &
			pcm_val, &
			teststr1, &
			teststr2, &
			ls_enteredzip, &
			ls_address, &
			ls_locater, &
			ls_locatercity, &
			ls_pcm_address, &
			ls_newaddress, &
			ls_msg, &
			ls_foundpcm, &
			ls_latlong, &
			ls_holdlocater, &
			ls_zip, &
			ls_city, &
			ls_state

integer	li_ndx, &
			li_exactmatch, &
			li_partialmatch
			
long	ll_len, &
		ll_ndx

if mod_row < 1 then return 0
col_name = mod_dwo.name

boolean 	redraw_dw, &
			lb_validstreet, &
			lb_setlocater, &
			lb_userenteredzip, &
			lb_checkzip
			
integer	list_row, retnval
long		ll_pos, &
			ll_return=0

n_cst_string	lnv_string

choose case col_name
	case "co_name", "co_bill_name"
		string oldname, trimname, xon_1, xon_2
		oldname = mod_dwo.original[mod_row]
		trimname = trim(mod_data)
		if gf_coname_index(trimname, xon_1, xon_2) < 1 then
			//this tests the validity of co_bill_name, even though the xons won't be set
			mod_dwo.primary[mod_row] = oldname
			return 2
		end if
		if col_name = "co_name" then
			if len(righttrim(xon_2)) > 0 then oldname = oldname else setnull(xon_2)
			dw_mod.object.co_xon_1[mod_row] = xon_1
			dw_mod.object.co_xon_2[mod_row] = xon_2
//			if oldname = this.getitemstring(1, "co_bill_name") then &
//				parent.postevent("change_response", 1, changed_col)
//				** Drop for now due to losefocus problems
		end if
		if mod_data = trimname then
			trimname = trimname
		else
			mod_dwo.primary[mod_row] = trimname
			return 2
		end if

//	case "co_name"  **Drop for now due to losefocus problems
//		if which_dw = 1 then //should be
//			mboxret = 1
//			if messagebox("Edit Company Name", "Change Billing Name also?", question!, &
//				yesno!, 1) = 1 then dw_for_this.setitem(1, "co_bill_name", &
//					dw_for_this.getitemstring(1, changed_col))
//		end if

	case "co_addr1"
		
		if ib_pcmilerstreets then
			ls_city = trim(dw_mod.object.co_city[mod_row])
			ls_state = trim(dw_mod.object.co_state[mod_row])
			ls_address = trim(mod_data)
			setnull(ls_latlong)
			ls_latlong = this.of_streetsverification(ls_address, ls_city, ls_state )
			if isnull(ls_latlong) then
				//don't change anything
			else
				dw_mod.object.co_city[mod_row] = ls_city
				dw_mod.object.co_state[mod_row] = ls_state
				dw_mod.object.co_addr1[mod_row] = ls_address
				
				if trim(mod_data) <> ls_address then
					ll_len = len(ls_address)
					for ll_ndx = 1 to ll_len
						if isnumber(mid(ls_address,ll_ndx, 1) ) or  &
							(mid(ls_address,ll_ndx, 1) = "-" and +&
							isnumber(mid(ls_address,ll_ndx + 1, 1)) )then
							continue
						else
							ll_len = ll_ndx - 1
							exit
						end if
					next
					dw_mod.post function setcolumn("co_addr1")
					dw_mod.post function SelectText ( 1, ll_len )
				end if
				dw_mod.object.co_pcm[mod_row] = ls_latlong			
				ll_return = 2
			end if
		end if
		
	case "co_city", "co_state"
		dw_mod.object.co_pcm[mod_row] = null_str
		if inv_trip.of_isconnected() then
			if len(trim(mod_data)) > 0 then
				if col_name = "co_city" then
					ls_city = trim(mod_data)
					ls_state = dw_mod.object.co_state[mod_row]
					if ib_oldpcmilerversion then
						pcm_val = trim(mod_data) + " " + dw_mod.object.co_state[mod_row]
					else
						pcm_val = trim(mod_data) + ", " + dw_mod.object.co_state[mod_row]
					end if
				else
					ls_city = trim(dw_mod.object.co_city[mod_row])
					ls_state = trim(mod_data)
					if ib_oldpcmilerversion then
						pcm_val = trim(dw_mod.object.co_city[mod_row]) + " " + trim(mod_data)
					else
						pcm_val = trim(dw_mod.object.co_city[mod_row]) + ", " + trim(mod_data)
					end if
				end if
			end if
			
			if len(trim(pcm_val)) > (len(trim(mod_data)) + 2) then //add 2 for ", "
					
				//this implies co_usnon = "U", because there wouldn't be a state otherwise
				mboxret = 1
				/*	lookup city state to get zip code and automatically populate if a valiD
					one is found or validate entered one
				*/
				retnval = inv_routing.of_locationcheck(pcm_val, ls_foundpcm, true)
				mboxret = 0
				if retnval > 0 then
					
					teststr1 = dw_mod.object.co_zip[mod_row]
					if ib_CanadianPostal then
						if Match(left(ls_foundpcm,7), "^[A-Za-z][0-9][A-Za-z][ ][0-9][A-Za-z][0-9]$") then
							//canadian postal
							teststr2 = left(ls_foundpcm,7)
						end if
					elseif isnumber ( left ( ls_foundpcm, 5 ) )then
						teststr2 = trim(left(ls_foundpcm, 5))
					else
						setnull(teststr2)
					end if
					
					//the user already entered a zip, let's check it against pcmiler
					if len(trim(teststr1)) > 0 then
						lb_userenteredzip = true
						if ib_CanadianPostal then
							ls_enteredzip = left(teststr1,7)
						else
							ls_enteredzip = left (teststr1,5)
						end if
						if ls_enteredzip = teststr2 then
							//they match
						elseif len(teststr2) > 0 and retnval > 0 then
							mboxret = 1
							if messagebox("Location Verification", "Do you want to replace the current zip code " +&
									"with the one found by PC*Miler?", information!, yesno!) = 1 then
									dw_mod.object.co_zip[mod_row] = teststr2
							else
								goto tz_set
							end if
						else
							mboxret = 1
							if messagebox("Location Verification", "Do you want to clear the current zip code?", +&
									information!, yesno!) = 1 then
									dw_mod.object.co_zip[mod_row] = null_str
							else
								goto tz_set
							end if
						end if
						
					elseif len(teststr2) > 0 and retnval > 0 then
						lb_userenteredzip = false
						dw_mod.object.co_zip[mod_row] = teststr2
		
					end if
								
					teststr1 = inv_routing.of_getpartoflocater(ls_foundpcm, "CITY", true)
					teststr2 = trim(dw_mod.object.co_city[mod_row])
					if (col_name = "co_city" and teststr1 = trim(mod_data)) or &
						(col_name = "co_state" and teststr1 = teststr2) then
							//ok they match
							ll_return = 0
					else
						mboxret = 1
						if messagebox("Location Verification", "Do you want to replace "+&
						"the current city with " + teststr1 + ".", &
							question!, yesno!) = 1 then
								dw_mod.object.co_city[mod_row] = teststr1
								
								if col_name = "co_city" then return 2
						end if
					end if
	
					ls_city = teststr1
					if col_name = "co_state" then
						ls_state = trim(mod_data)
					else
						ls_state = trim(dw_mod.object.co_state[mod_row])
					end if
					ls_zip = trim(dw_mod.object.co_zip[mod_row])
					ls_address = trim(dw_mod.object.co_addr1[mod_row])

					if ib_pcmilerstreets then
						ls_address = dw_mod.object.co_addr1[mod_row]
						setnull(ls_latlong)
						if len(ls_address) = 0 or isnull(ls_address) then
							//do not create locator without street
						else
							ls_latlong = this.of_streetsverification(ls_address, ls_city, ls_state)
							if isnull(ls_latlong) then
								//don't change anything
//								ls_latlong = inv_routing.of_addresstolatlong(ls_foundpcm)
							else
								dw_mod.object.co_city[mod_row] = ls_city
								dw_mod.object.co_state[mod_row] = ls_state
								if dw_mod.object.co_addr1[mod_row] <> ls_address then
									ll_len = len(ls_address)
									for ll_ndx = 1 to ll_len
										if isnumber(mid(ls_address,ll_ndx, 1) ) or  &
											(mid(ls_address,ll_ndx, 1) = "-" and +&
											isnumber(mid(ls_address,ll_ndx + 1, 1)) )then
											continue
										else
											ll_len = ll_ndx - 1
											exit
										end if
									next
									dw_mod.object.co_addr1[mod_row] = ls_address
									dw_mod.post function setcolumn("co_addr1")
									dw_mod.post function SelectText ( 1, ll_len )
								end if			
								ll_return = 2
							end if
						end if
					end if

					// if all the fields have been populated then set the locater
					if ib_oldpcmilerversion then
						if len (ls_city) > 0 and len(ls_state) > 0 and len(ls_zip) > 0 then
							dw_mod.object.co_pcm[mod_row] = ls_foundpcm
						end if
					ELSE
						if ib_pcmilerstreets then
							//either null or valid locator
							dw_mod.object.co_pcm[mod_row] = ls_latlong
						else
							if len (ls_city) > 0 and len(ls_state) > 0 then
								//new format, remove county
								ls_locater = inv_routing.of_stripcounty(ls_foundpcm)
								ls_locatercity = inv_routing.of_getpartoflocater(ls_locater,'CITY',TRUE)
								ll_pos = pos(upper(ls_locater),ls_locatercity,1)
								if ll_pos > 0 then
									ls_locater = replace(ls_locater,ll_pos,len(ls_locatercity),left(ls_locatercity,15))
									dw_mod.object.co_pcm[mod_row] = ls_locater
								end if
							end if
						end if
					END IF			
					
					
				elseif retnval < 0 then
					mboxret = 1
					messagebox("Location Verification", ls_foundpcm)
	//				if focus_changing then dw_mod.post setcolumn(col_name)
	//				dw_mod.post setfocus()
				end if
			end if
		end if
		tz_set:
		if col_name = "co_state" then set_tz(dw_mod, mod_row, mod_data)
		
	case "co_zip"
		
		lb_setlocater = false
		ls_locater = dw_mod.object.co_pcm[mod_row]
		
		if isnull(ls_locater) or len(trim(ls_locater)) = 0 then 
			lb_setlocater = true
		else
			//already have a locator, don't change unless one of following conditions forces it
			//to be changed
			lb_setlocater = false
		end if

		if ib_CanadianPostal then
			if Match(left(mod_data,7), "^[A-Za-z][0-9][A-Za-z][ ][0-9][A-Za-z][0-9]$") then
				ls_enteredzip = left(mod_data,7)
			else
				ls_enteredzip = left(mod_data, 5)
			end if
		else
			ls_enteredzip = left(mod_data, 5)
		end if
		
		teststr1 = trim(dw_mod.object.co_city[mod_row])
		teststr2 = trim(dw_mod.object.co_state[mod_row])
		if len(trim(ls_enteredzip)) = 5 or len(trim(ls_enteredzip)) = 7 then
			//ok for search
		else
			if len(teststr1) > 0 and len(teststr2) > 0 then
				if lb_setlocater then
					//continue
				else
					//we have a city/state and a locater, don't validate the zip
					return 0
				end if
			else	
				//nothing entered, clear locater
				dw_mod.object.co_pcm[mod_row] = null_str
				return 0
			end if
		end if
		if inv_trip.of_isconnected() then
			mboxret = 1
			retnval = inv_routing.of_locationcheck(ls_enteredzip, ls_foundpcm, true)
			mboxret = 0
		else
			retnval = 0
		end if
		
		if retnval > 0 then
			//state
			if teststr2 = inv_routing.of_getpartoflocater(ls_foundpcm, "STATE", true) then
				//ok state matches
			else
				teststr2 = inv_routing.of_getpartoflocater(ls_foundpcm, "STATE", true)
				dw_mod.object.co_state[mod_row] = teststr2
				set_tz(dw_mod, mod_row, teststr2)
			end if
			teststr2 = inv_routing.of_getpartoflocater(ls_foundpcm, "CITY", true)
			//teststr1 = current city
			if len(teststr1) > 0 then
				if teststr1 = teststr2 then
					//ok city matches
					if ib_pcmilerstreets then
						ls_latlong = inv_routing.of_addresstolatlong(ls_foundpcm)
					else
						//added by nwl 1/21/04, Problem corrected for 3.8 - When zipcode was changed but
						//the state and city were the same then the locator was not being updated with
						//the new zipcode. By setting lb_locater=true this will go through the logic
						//that will update the locator
						lb_setlocater=true
					end if
				else
					mboxret = 1
					if messagebox("Location Verification", "Do you want to replace "+&
						"the current city with " + teststr2 + ".", &
						question!, yesno!) = 1 then
							dw_mod.object.co_city[mod_row] = teststr2
							lb_setlocater=true
					else
						//user didn't change city we need to give a message to give choice to accept 
						//new locator
						if ls_foundpcm <> dw_mod.object.co_pcm[mod_row] then
							choose case messagebox("Location Verification", "Do you want to assign " +&
									ls_foundpcm + " as the locator?"	, question!, yesno!)
								case 1
									lb_setlocater = true
								case else
									lb_setlocater = false
							end choose
							
					end if
		
					if lb_setlocater and ib_pcmilerstreets then
						//validate street against new pcm
							ls_city = trim(dw_mod.object.co_city[mod_row])
							ls_state = trim(dw_mod.object.co_state[mod_row])
							ls_address = trim(dw_mod.object.co_addr1[mod_row])
							if len(ls_address) = 0 or isnull(ls_address) then
								ls_latlong = inv_routing.of_addresstolatlong(ls_foundpcm)
							else
								ls_latlong = this.of_streetsverification(ls_address, ls_city, ls_state)
								if isnull(ls_latlong) then
									//don't change anything
									ls_latlong = inv_routing.of_addresstolatlong(ls_foundpcm)
								else
									if dw_mod.object.co_addr1[mod_row] <> ls_address then
										ll_len = len(ls_address)
										for ll_ndx = 1 to ll_len
											if isnumber(mid(ls_address,ll_ndx, 1) ) or  &
												(mid(ls_address,ll_ndx, 1) = "-" and +&
												isnumber(mid(ls_address,ll_ndx + 1, 1)) )then
												continue
											else
												ll_len = ll_ndx - 1
												exit
											end if
										next
										dw_mod.object.co_addr1[mod_row] = ls_address
										dw_mod.post function setcolumn("co_addr1")
										dw_mod.post function SelectText ( 1, ll_len )
									end if										
									ll_return = 2
								end if
							end if
						end if
					end if
				end if
				
				if lb_setlocater then
					//set locater
					ls_city = trim(dw_mod.object.co_city[mod_row])
					ls_state = trim(dw_mod.object.co_state[mod_row])
					ls_zip = ls_enteredzip
					if ib_oldpcmilerversion then
						if len (ls_city) > 0 and len(ls_state) > 0 and len(ls_zip) > 0 then
							dw_mod.object.co_pcm[mod_row] = ls_foundpcm
						end if
					ELSE
						if ib_pcmilerstreets then
							ls_address = trim(dw_mod.object.co_addr1[mod_row])
							setnull(ls_latlong)
							if len(ls_address) = 0 or isnull(ls_address) then
								//do not create locator without street
							else
								//nwl 3/16/04
//								ls_latlong = inv_routing.of_addresstolatlong(ls_foundpcm)
								ls_latlong = this.of_streetsverification(ls_address, ls_city, ls_state)
								if isnull(ls_latlong) then
									//don't change anything
									ls_latlong = inv_routing.of_addresstolatlong(ls_foundpcm)
								else
									dw_mod.object.co_city[mod_row] = ls_city
									dw_mod.object.co_state[mod_row] = ls_state
									dw_mod.object.co_addr1[mod_row] = ls_address
										if dw_mod.object.co_addr1[mod_row] <> ls_address then
											ll_len = len(ls_address)
											for ll_ndx = 1 to ll_len
												if isnumber(mid(ls_address,ll_ndx, 1) ) or  &
													(mid(ls_address,ll_ndx, 1) = "-" and +&
													isnumber(mid(ls_address,ll_ndx + 1, 1)) )then
													continue
												else
													ll_len = ll_ndx - 1
													exit
												end if
											next
											dw_mod.post function setcolumn("co_addr1")
											dw_mod.post function SelectText ( 1, ll_len )
										end if										
									end if
								//nwl 3/16/04
							end if
							dw_mod.object.co_pcm[mod_row] = ls_latlong
						else
							
							if len (ls_city) > 0 and len(ls_state) > 0 and len(ls_zip) > 0 then
								//new format, remove county
								ls_locater = inv_routing.of_stripcounty(ls_foundpcm)
								ls_locatercity = inv_routing.of_getpartoflocater(ls_locater,'CITY',TRUE)
								ll_pos = pos(upper(ls_locater),ls_locatercity,1)
								if ll_pos > 0 then
									ls_locater = replace(ls_locater,ll_pos,len(ls_locatercity),left(ls_locatercity,15))
									dw_mod.object.co_pcm[mod_row] = ls_locater
								end if
							end if
						end if
					END IF	
				end if
				
			else
				//city and state are being force populated from zip change with a valid locator
				//for zip
				
				dw_mod.object.co_city[mod_row] = teststr2
				
				if ib_pcmilerstreets then
					ls_city = trim(dw_mod.object.co_city[mod_row])
					ls_state = trim(dw_mod.object.co_state[mod_row])
					ls_address = trim(dw_mod.object.co_addr1[mod_row])
					if len(ls_address) = 0 or isnull(ls_address) then
						ls_latlong = inv_routing.of_addresstolatlong(ls_foundpcm)
					else
						ls_latlong = this.of_streetsverification(ls_address, ls_city, ls_state)
						if isnull(ls_latlong) then
							//don't change anything
							ls_latlong = inv_routing.of_addresstolatlong(ls_foundpcm)
						else
							dw_mod.object.co_city[mod_row] = ls_city
							dw_mod.object.co_state[mod_row] = ls_state
							dw_mod.object.co_addr1[mod_row] = ls_address
								if dw_mod.object.co_addr1[mod_row] <> ls_address then
									ll_len = len(ls_address)
									for ll_ndx = 1 to ll_len
										if isnumber(mid(ls_address,ll_ndx, 1) ) or  &
											(mid(ls_address,ll_ndx, 1) = "-" and +&
											isnumber(mid(ls_address,ll_ndx + 1, 1)) )then
											continue
										else
											ll_len = ll_ndx - 1
											exit
										end if
									next
									dw_mod.post function setcolumn("co_addr1")
									dw_mod.post function SelectText ( 1, ll_len )
								end if										
						
							dw_mod.object.co_pcm[mod_row] = ls_latlong	
//							ll_return = 2 nwl 3/16/04
						end if
					end if
				else
					if ib_oldpcmilerversion then
						dw_mod.object.co_pcm[mod_row] = ls_foundpcm
					ELSE
						//new format, remove county
						ls_locater = inv_routing.of_stripcounty(ls_foundpcm)
						ls_locatercity = inv_routing.of_getpartoflocater(ls_locater,'CITY',TRUE)
						ll_pos = pos(upper(ls_locater),ls_locatercity,1)
						if ll_pos > 0 then
							ls_locater = replace(ls_locater,ll_pos,len(ls_locatercity),left(ls_locatercity,15))
							dw_mod.object.co_pcm[mod_row] = ls_locater
						end if
					END IF		
				end if
			end if
		elseif retnval = 0 or  not ib_pcmilerconnected then
			//don't wipe out valid locator
//			dw_mod.object.co_pcm[mod_row] = null_str
			
		elseif retnval < 0 then
			
//			mboxret = 1
//			messagebox("Location Verification", ls_foundpcm)
			
//			dw_mod.object.co_pcm[mod_row] = null_str
			
		end if
			
	case "co_usnon"
		if mod_data = "N" then dw_mod.object.co_state[mod_row] = null_str
		redraw_dw = true
	case "co_bill_usnon"
		if mod_data = "N" then dw_mod.object.co_bill_state[mod_row] = null_str
		redraw_dw = true
	case "co_bill_same"
		if mod_data = "F" then
			dw_mod.object.co_bill_usnon[mod_row] = dw_mod.object.co_usnon[mod_row]
			dw_mod.object.co_bill_name[mod_row] = dw_mod.object.co_name[mod_row]
		else
			dw_mod.object.co_bill_name[mod_row] = null_str
			dw_mod.object.co_bill_addr1[mod_row] = null_str
			dw_mod.object.co_bill_addr2[mod_row] = null_str
			dw_mod.object.co_bill_city[mod_row] = null_str
			dw_mod.object.co_bill_state[mod_row] = null_str
			dw_mod.object.co_bill_zip[mod_row] = null_str
			dw_mod.object.co_bill_phone1[mod_row] = null_str
			dw_mod.object.co_bill_phone2[mod_row] = null_str
			dw_mod.object.co_bill_fax[mod_row] = null_str
			dw_mod.object.co_bill_usnon[mod_row] = null_str
		end if
		redraw_dw = true
	case "co_bill_attn"
		if mod_data = "N" then dw_mod.object.co_bill_attn_text[mod_row] = null_str
	case "co_phone1", "co_phone2", "co_fax", "co_zip", "co_bill_phone1", &
		"co_bill_phone2", "co_bill_fax", "co_bill_zip"
			if len(trim(mod_data)) < 1 then
				mod_dwo.primary[mod_row] = null_str
				return 2
			end if
	case "co_tz"
		ls_state = dw_mod.object.co_state[mod_row]
		if check_tz(ls_state, integer(mod_data)) = false then
			if len(ls_state) > 0 then
				ls_msg = "The time zone you have selected does not fall within the state " +&
					ls_state + "."
			else
				ls_msg = "You must specifiy a state location before you can select a "+&
					"time zone."
			end if
			ls_msg += "~n~nSelection cancelled."
			messagebox("Time Zone Selection", ls_msg, exclamation!)
			mod_dwo.primary[mod_row] = mod_dwo.primary[mod_row]
			return 2
		end if
end choose

if redraw_dw = true then dw_mod.setredraw(true)

return ll_return

end function

protected function integer set_tz (datawindow dw_tz, long tz_row, string tz_state);if tz_state = "??" then tz_state = dw_tz.object.co_state[tz_row]

tz_state = trim(tz_state)

choose case tz_state
	case "HI"
		dw_tz.object.co_tz[tz_row] = 0
//	case "AK"
//		dw_tz.object.co_tz[tz_row] = 1
	case "CA", "NV", "WA", "YK" //"OR", "BC"
		dw_tz.object.co_tz[tz_row] = 2
	case "AZ", "CO", "MT", "NM", "UT", "WY", "AB" //"ID", "NT"
		dw_tz.object.co_tz[tz_row] = 3
	case "AL", "AR", "IL", "IA", "LA", "MN", "MS", "MO", "OK", &
		"WI", "MB" //"KS", "NE", "ND", "SD", "TN", "TX", "SK", "MX"
		dw_tz.object.co_tz[tz_row] = 4
	case "CT", "DE", "DC", "GA", "ME", "MD", "MA", "NH", &
		"NJ", "NY", "NC", "OH", "PA", "RI", "SC", "VT", "VA", "WV", "PQ", "QC"
		//"FL", "IN", "KY", "MI", "ON"
		dw_tz.object.co_tz[tz_row] = 5
	case "NB", "NF", "NS", "PE"
		dw_tz.object.co_tz[tz_row] = 6
	case else
		dw_tz.object.co_tz[tz_row] = null_int
end choose

return 1
end function

public subroutine save_request ();if needs_update() = false then return

if save() = 1 then return

messagebox("Company Information", "Could not save changes to database.~n~nPlease retry.", &
	exclamation!)
end subroutine

protected function integer save ();boolean conew, facnew, ctnew
long cobase, coid, ctbase, ctid, facrows, facfilt, ctrows, bcrows, markloop
Long	ll_Null

SetNull ( ll_Null )
n_cst_numerical lnv_numerical

facrows = dw_facility_details.rowcount()
facfilt = dw_facility_details.filteredcount()
ctrows = ids_Contacts.rowcount()
bcrows = dw_car_info.rowcount()

if dw_co_info.object.co_id[1] = 0 then conew = true

if dw_facility_details.find("co_id = 0", 1, facrows) > 0 then facnew = true

if ids_Contacts.find("IsNull ( ct_id ) ", 1, ctrows) > 0 then ctnew = true

if conew or facnew then
	select max(co_id) into :cobase from companies ;
	if sqlca.sqlcode <> 0 then goto rollitback	
	if lnv_numerical.of_IsNullOrNotPos(cobase) then cobase = 0
	coid = cobase
end if

if ctnew then
	select max(ct_id) into :ctbase from contacts ;
	if sqlca.sqlcode <> 0 then goto rollitback
	if lnv_numerical.of_IsNullOrNotPos(ctbase) then ctbase = 0
	ctid = ctbase
end if

if conew then
	coid ++
	dw_co_info.object.co_id[1] = coid
	co_to_display = coid
	if facrows > 0 then
		for markloop = 1 to facrows
			dw_facility_details.object.co_facility_of[markloop] = coid
		next
	end if
	
	// this is set when the details window is opened
//	if ctrows > 0 then
//		for markloop = 1 to ctrows
//			ids_Contacts.object.ct_co[markloop] = coid
//		next
//	end if

	if bcrows > 0 then dw_car_info.object.bc_id[1] = coid
end if

if facnew then
	for markloop = 1 to facrows
		if dw_facility_details.object.co_id[markloop] = 0 then
			coid ++
			dw_facility_details.object.co_id[markloop] = coid
		end if
	next
end if

if ctnew then
	for markloop = 1 to ctrows
		if IsNull ( ids_Contacts.object.ct_id[markloop] )  then
			ctid ++
			ids_Contacts.object.ct_id[markloop] = ctid
		end if
	next
end if

dw_co_info.object.co_intsig[1] = dw_co_info.object.co_intsig[1] + 1

if dw_co_info.update(false, false) = -1 then goto rollitback

if dw_facility_details.update(false, false) = -1 then goto rollitback

if ids_Contacts.update(false, false) = -1 then goto rollitback

if dw_car_info.modifiedcount() > 0 then &
	dw_car_info.object.bc_lastupdt[1] = datetime(today(), now())

if dw_car_info.update(false, false) = -1 then goto rollitback

commit ;
if sqlca.sqlcode <> 0 then goto rollitback
//ids_Contacts
dw_co_info.resetupdate()
ids_Contacts.resetupdate()
dw_facility_details.resetupdate()
dw_car_info.resetupdate()

gnv_cst_companies.of_sync(dw_co_info)
gnv_cst_companies.of_sync(dw_facility_details)

if facfilt > 0 then dw_facility_details.rowsdiscard(1, facfilt, filter!)

THIS.wf_InitializeContacts ( )

return 1

rollitback:
rollback ;

if conew then
	dw_co_info.object.co_id[1] = 0
	co_to_display = 0
	if facrows > 0 then
		for markloop = 1 to facrows
			dw_facility_details.object.co_facility_of[markloop] = 0
		next
	end if
	if ctrows > 0 then
		for markloop = 1 to ctrows
			ids_Contacts.object.ct_co[markloop] = ll_Null
		next
	end if
	if bcrows > 0 then dw_car_info.object.bc_id[1] = 0
end if

if facnew then
	for markloop = 1 to facrows
		if dw_facility_details.object.co_id[markloop] > cobase then &
			dw_facility_details.object.co_id[markloop] = 0
	next
end if

if ctnew then
	for markloop = 1 to ctrows
		if ids_Contacts.object.ct_id[markloop] > ctbase then 
			ids_Contacts.object.ct_id[markloop] = ll_Null
		END IF
	next
end if

return -1
end function

protected function integer retr ();integer wherepos
long	ll_facility_of
char costat
string oldselstr, addselstr, selstr

SetPointer(HourGlass!)

dw_facility_details.visible = false
//dw_ct_info.visible = false

////////////////////////////////////////////////////////
//This section should be revised to use the service functions instead, with a 
//subsequent check of the status and facility info for the company actually retrieved

select co_status, co_facility_of into :costat, :ll_facility_of 
	from companies where co_id = :co_to_display ;

if sqlca.sqlcode <> 0 then goto rollitback

if ll_facility_of > 0 and costat <> "D" then
	co_to_display = ll_facility_of
	select co_status, co_facility_of into :costat, :ll_facility_of
		from companies where co_id = :co_to_display ;
	if sqlca.sqlcode <> 0 then goto rollitback
	if ll_facility_of > 0 then goto rollitback
end if
if costat = "D" then goto rollitback

////////////////////////////////////////////////////////

if dw_co_info.retrieve(co_to_display) <> 1 then goto rollitback


//if dw_ct_info.retrieve(co_to_display) = -1 then goto rollitback

if dw_car_info.retrieve(co_to_display) = -1 then goto rollitback

oldselstr = dw_facility_details.describe("datawindow.table.select")
addselstr = "WHERE co_facility_of = " + string(co_to_display) +&
	" AND co_status <> ~~'D~~'"
wherepos = pos(oldselstr, "WHERE")
selstr = left(oldselstr, wherepos - 1) + addselstr
dw_facility_details.modify("datawindow.table.select = '" + selstr + "'")

if dw_facility_details.retrieve(0) = -1 then goto rollitback

commit ;

//We're skipping this for now
//if dw_co_info.getitemstring(1, "co_usnon") = "N" then
//	dw_ct_info.setformat("ct_dirphone", "")
//	dw_ct_info.setformat("ct_dirfax", "")
//else
//	dw_ct_info.modify("ct_dirphone.format = '~"~" ~t if ( len ( righttrim ( ct_dirphone [0] ) ) > 10, ~"(@@@) @@@-@@@@ x @@@@~", ~"(@@@) @@@-@@@@~" )'")
//	dw_ct_info.modify("ct_dirfax.format = '~"~" ~t if ( len ( righttrim ( ct_dirfax [0] ) ) > 10, ~"(@@@) @@@-@@@@ x @@@@~", ~"(@@@) @@@-@@@@~" )'")
//end if

if dw_car_info.rowcount() > 0 then
	if dw_car_info.getitemstring(1, "bc_common") = "T" then
		dw_car_info.modify("bc_common_mc.editmask.mask = '###### (!!!)'")
	else
		dw_car_info.modify("bc_common_mc.edit.format = ''")
	end if
	if dw_car_info.getitemstring(1, "bc_broker") = "T" then
		dw_car_info.modify("bc_broker_mc.editmask.mask = '###### (!!!)'")
	else
		dw_car_info.modify("bc_broker_mc.edit.format = ''")
	end if
	if dw_car_info.getitemstring(1, "bc_contract") = "T" then
		dw_car_info.modify("bc_contract_mc.editmask.mask = '###### (!!!)'")
	else
		dw_car_info.modify("bc_contract_mc.edit.format = ''")
	end if
else
	dw_car_info.visible = false
end if

gnv_cst_companies.of_sync(dw_co_info)
gnv_cst_companies.of_sync(dw_facility_details)

dw_co_info.SetColumn ( "co_name" )
dw_co_info.SetFocus ( )

this.postevent("set_buttons")
THIS.wf_InitializeContacts ( )
////////// alerts
n_ds		lds_FacAlerts
Long		ll_FacCount
Long		ll_FacAlertCount
Long		lla_MsgIds[]
Long		lla_SourceIds[]
Long		ll_UserId
Long		i
n_cst_AlertManager	lnv_AlertManager
lnv_AlertManager = CREATE n_cst_AlertManager

lds_FacAlerts = Create n_ds
lds_FacAlerts.DataObject = "d_facilityalerts"
lds_FacAlerts.SetTransObject(SQLCA)

n_cst_beo_Company	lnva_List[]
n_cst_AnyArraysrv	lnv_Array

//current company alerts
n_cst_beo_Company	lnv_Company
lnv_Company = CREATE n_cst_beo_Company
lnv_Company.of_SetUseCache( TRUE )
lnv_Company.of_SetSourceid( co_to_display )

lnv_AlertManager.of_ShowAlerts( {lnv_Company} )

//facility alerts
gnv_cst_companies.of_Getfacilities( co_to_display , lnva_List )
ll_FacCount = UpperBound(lnva_List)

IF ll_FacCount > 0 THEN
	FOR i = 1 TO ll_FacCount
		lla_SourceIds[i] = lnva_List[i].of_GetSourceId()
	NEXT
	ll_UserId = gnv_App.of_GetNumericUserId()

	IF lds_FacAlerts.Retrieve(lla_SourceIds, "n_cst_beo_company", ll_UserId) = -1 THEN GOTO rollitback
	ll_FacAlertCount = lds_FacAlerts.RowCount()
	IF ll_FacAlertCount > 0 THEN
		lla_MsgIds = lds_FacAlerts.Object.useralerts_id.Primary
		IF ll_FacAlertCount <= 10 THEN
			lnv_AlertManager.of_ShowAlerts( lla_MsgIds )
		ELSE
			lnv_AlertManager.of_ShowAlertsForCurrentUser(lla_MsgIds, "This is a list of alerts for facilities.")
		END IF
	END IF
END IF

Destroy ( lnv_AlertManager )
Destroy(lds_FacAlerts)
Destroy(lnv_Company)
lnv_Array.of_Destroy ( lnva_List )

//////// end of alerts

//THIS.wf_RetrieveContacts ( )

return 1

rollitback:
rollback ;
messagebox("Company Information", "Could not retrieve requested information.~n~nWindow "+&
	"will close.", exclamation!)
winisclosing = true
close(this)
return -1
end function

protected function boolean needs_update ();if isnull(co_to_display) then return false

integer comod, ctmod, facmod, carmod
comod = abs(dw_co_info.modifiedcount())
ctmod = abs(ids_Contacts.modifiedcount()) + abs(ids_Contacts.deletedcount())
facmod = abs(dw_facility_details.modifiedcount()) + abs(dw_facility_details.filteredcount())
//Deleted facilities are not really deleted: their status is changed, and they are filtered
carmod = abs(dw_car_info.modifiedcount())

if comod + ctmod + facmod + carmod = 0 then return false

return true
end function

protected function boolean check_tz (string state, integer tz);choose case tz
	case 0
		choose case state
			case "HI", "AK"
				return true
		end choose
	case 1
		choose case state
			case "AK"
				return true
		end choose
	case 2
		choose case state
			case "CA", "NV", "OR", "WA", "BC", "YK", "ID", "MX"
				return true
		end choose
	case 3
		choose case state
			case "AZ", "CO", "ID", "MT", "NM", "UT", "WY", "AB", "NT", "KS", "NE", "ND", &
				"OR", "SD", "TX", "BC", "SK", "MX"
				return true
		end choose
	case 4
		choose case state
			case "AL", "AR", "IL", "IA", "KS", "LA", "MN", "MS", "MO", "NE", "ND", "OK", &
				"SD", "TN", "TX", "WI", "MB", "SK", "MX", "FL", "IN", "KY", "MI", "NT", "ON"
				return true
		end choose
	case 5
		choose case state
			case "CT", "DE", "DC", "FL", "GA", "IN", "KY", "ME", "MD", "MA", "MI", "NH", &
				"NJ", "NY", "NC", "OH", "PA", "RI", "SC", "VT", "VA", "WV", "ON", "PQ", "QC", &
				"TN", "NT"
				return true
		end choose
	case 6
		choose case state
			case "NB", "NF", "NS", "PE", "NT"
				return true
		end choose
end choose

return false
end function

protected subroutine wf_alter_company (string as_type);long ll_test, ll_markloop, ll_affected[]
integer li_facility_count, li_contact_count
s_co_info lstr_target, lstr_targpar
boolean lb_cur_is_car, lb_targ_is_car
string ls_message, ls_message_header, ls_work
n_cst_Privileges	lnv_Privileges

if dw_car_info.rowcount() > 0 then lb_cur_is_car = true

choose case as_type
case "REPLACE!"
	ls_message_header = "Replace Company"
case "MAKE_FACILITY!"
	ls_message_header = "Make Company a Facility"
	if lb_cur_is_car then
		messagebox(ls_message_header, "You cannot make a carrier a facility.~n~n"+&
			"Request cancelled.")
		return
	end if
case else
	messagebox("Company Info", "Could not process request.", exclamation!)
	return
end choose

IF lnv_Privileges.of_HasAdministrativeRights ( ) = FALSE THEN
	MessageBox ( ls_message_header, lnv_Privileges.of_GetRestrictMessage ( ) )
	RETURN
END IF

if needs_update() then
	if messagebox(ls_message_header, "You must either save or clear your changes before "+&
	"performing this procedure.~n~nOK to save changes and proceed?", question!, okcancel!) &
		= 2 then return
	if save() = -1 then
		messagebox("Save Changes", "Could not save changes to database.~n~n"+&
			"Process cancelled.", exclamation!)
		return
	end if
end if

li_facility_count = dw_facility_details.rowcount()
li_contact_count = ids_Contacts.rowcount()


if not gnv_cst_companies.of_select(lstr_target, "ANY!", false, "", false, 0, &
	 true, true) = 1 then return
if isnull(lstr_target.co_id) then return //This is in basically as a precaution.
//If an "allow null = false" restriction were added to of_select, this could be dropped.

if lstr_target.co_id = co_to_display then
	messagebox(ls_message_header, "You selected the same company you currently have "+&
		"displayed.~n~nRequest cancelled.")
	return
end if

//If we add a force refresh option to of_select and use it above, this can be eliminated.
if not gnv_cst_companies.of_get_info(lstr_target.co_id, lstr_target, true) = 1 then
	messagebox(ls_message_header, "Could not verify target company information.~n~n" +&
		"Request cancelled.", exclamation!)
	return
end if

choose case as_type
case "REPLACE!"
	if lstr_target.co_facility_of = co_to_display then
		messagebox(ls_message_header, "Cannot replace a company with one of its own "+&
			"facilities.~n~nRequest cancelled.")
		return
	end if

	select bc_id into :ll_test from brok_carriers where bc_id = :lstr_target.co_id ;
	choose case sqlca.sqlcode
	case 0
		commit ;
		lb_targ_is_car = true
	case 100
		commit ;
	case else
		goto rollitback
	end choose
	
	if lb_cur_is_car and lstr_target.co_facility_of > 0 then
		messagebox(ls_message_header, "A facility cannot be used to replace a carrier."+&
			"~n~nRequest cancelled.")
		return
	end if
	
	ls_message = "You have requested that " + lstr_target.co_name
	if len(trim(lstr_target.co_city)) > 0 then
		ls_message += " (" + trim(lstr_target.co_city)
		if len(lstr_target.co_state) > 0 then ls_message += ", " + lstr_target.co_state
		ls_message += ")"
	end if
	ls_message += " be used to replace all references the current company, " +&
		dw_co_info.object.co_name[1] + "."
	
	if lstr_target.co_facility_of > 0 then
		if gnv_cst_companies.of_get_info(lstr_target.co_facility_of, lstr_targpar, true) = 1 then
			ls_message += "  Since " + lstr_target.co_name + " is a facility, its parent company, "+&
				lstr_targpar.co_name
			if len(trim(lstr_targpar.co_city)) > 0 then
				ls_message += " (" + trim(lstr_targpar.co_city)
				if len(lstr_targpar.co_state) > 0 then ls_message += ", " + lstr_targpar.co_state
				ls_message += ")"
			end if
			ls_message += ", will be substituted in any cases where the current company is used as "+&
				"the billto."
		else
			messagebox(ls_message_header, "Could not verify target company information.~n~n" +&
				"Request cancelled.", exclamation!)
			return
		end if
	else
		lstr_targpar = lstr_target
	end if
	
	if lb_cur_is_car and lb_targ_is_car then
		ls_message += "~n~nBoth the current company and the one that will replace it have been "+&
			"set up as carriers.  The carrier information for the current company will be "+&
			"lost."
	elseif lb_cur_is_car then
		ls_message += "~n~nThe current company has been set up as a carrier, but the one that "+&
			"will replace it has not.  The carrier information for the current company will "+&
			"be transferred to the one replacing it."
	end if
	
	if li_facility_count > 0 or li_contact_count > 0 then
		ls_message += "~n~nThe "
		if li_facility_count > 0 then ls_message += "facilities"
		if li_facility_count > 0 and li_contact_count > 0 then ls_message += " and "
		if li_contact_count > 0 then ls_message += "contacts"
		ls_message += " associated with the current company will be transferred to the one " +&
			"replacing it."
	end if 
	
	ls_message += "~n~nOK to proceed?"
	
	if messagebox(ls_message_header, ls_message, question!, okcancel!) = 2 then return
	
	for ll_markloop = 1 to li_facility_count
		dw_facility_details.object.co_facility_of[ll_markloop] = lstr_targpar.co_id
	next
	
	for ll_markloop = 1 to li_contact_count
		ids_Contacts.object.ct_co[ll_markloop] = lstr_targpar.co_id
	next
	
	if lb_cur_is_car and not lb_targ_is_car then
		dw_car_info.object.bc_id[1] = lstr_targpar.co_id
		dw_car_info.setitemstatus(1, 0, primary!, newmodified!)
	end if
	
	dw_co_info.object.co_status[1] = "D"
	dw_co_info.object.co_code_name[1] = null_str
	dw_co_info.object.co_bill_acctcode[1] = null_str
	dw_co_info.object.co_allow_billing[1] = "F"
	dw_co_info.object.co_intsig[1] = dw_co_info.object.co_intsig[1] + 1
	
	if dw_co_info.update(false, false) = -1 then goto rollitback
	
	if dw_facility_details.update(false, false) = -1 then goto rollitback
	
	if ids_Contacts.update(false, false) = -1 then goto rollitback
	
	if dw_car_info.update(false, false) = -1 then goto rollitback
	
	update outside_equip set oe_from = :lstr_target.co_id where oe_from = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback
	
	update outside_equip set oe_for = :lstr_target.co_id where oe_for = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback

	update outside_equip set OriginationSite = :lstr_target.co_id where OriginationSite = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback

	update outside_equip set TerminationSite = :lstr_target.co_id where TerminationSite = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback

	update brok_trips set bt_origin_id = :lstr_target.co_id, bt_intsig = bt_intsig + 1 where bt_origin_id = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback
	
	update brok_trips set bt_findest_id = :lstr_target.co_id, bt_intsig = bt_intsig + 1 where bt_findest_id = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback
	
	update brok_trips set bt_carrier_id = :lstr_target.co_id, bt_intsig = bt_intsig + 1 where bt_carrier_id = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback
	
	update disp_ship set ds_origin_id = :lstr_target.co_id, ds_intsig = ds_intsig + 1 where ds_origin_id = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback
	
	update disp_ship set ds_findest_id = :lstr_target.co_id, ds_intsig = ds_intsig + 1 where ds_findest_id = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback

	//commented out because co_to_display was changed to long  and ds_pay1_id is 
	//small int and not being used
	
//	update disp_ship set ds_pay1_id = :lstr_target.co_id, ds_intsig = ds_intsig + 1 where ds_pay1_id = :co_to_display ;
//	if sqlca.sqlcode = -1 then goto rollitback
	
	update disp_ship set ds_billto_id = :lstr_targpar.co_id, ds_intsig = ds_intsig + 1 where ds_billto_id = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback
	
	update disp_ship set Forwarder = :lstr_targpar.co_id, ds_intsig = ds_intsig + 1 where Forwarder = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback
	
	update disp_ship set agent = :lstr_targpar.co_id, ds_intsig = ds_intsig + 1 where agent = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback
	
	update disp_events set de_site = :lstr_target.co_id, de_intsig = de_intsig + 1 where de_site = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback
	
//getting rid of systemsettings for the replaced company
	DELETE FROM system_settings WHERE ss_uid = :co_to_display AND ss_id < 1000 ;
	if sqlca.sqlcode = -1 then goto rollitback
	
	commit ;
	if sqlca.sqlcode <> 0 then goto rollitback

case "MAKE_FACILITY!"
	if lstr_target.co_facility_of > 0 then
		messagebox(ls_message_header, "You selected a facility, which cannot become "+&
			"the parent of another facility.~n~nRequest cancelled.")
		return
	end if

	ls_message = "You have requested that the current company, " + dw_co_info.object.co_name[1] +&
		", become a facility of " + lstr_target.co_name
	if len(trim(lstr_target.co_city)) > 0 then
		ls_message += " (" + trim(lstr_target.co_city)
		if len(lstr_target.co_state) > 0 then ls_message += ", " + lstr_target.co_state
		ls_message += ")"
	end if
	ls_message += ".~n~nThe new parent company will be substituted in any cases where the current "+&
		"company is used as the billto."
	
	if li_facility_count > 0 or li_contact_count > 0 then
		ls_message += "~n~nThe "
		if li_facility_count > 0 then ls_message += "facilities"
		if li_facility_count > 0 and li_contact_count > 0 then ls_message += " and "
		if li_contact_count > 0 then ls_message += "contacts"
		ls_message += " associated with the current company will also become associated with the parent."
	end if 
	
	ls_message += "~n~nOK to proceed?"
	
	if messagebox(ls_message_header, ls_message, question!, okcancel!) = 2 then return
	
	for ll_markloop = 1 to li_facility_count
		dw_facility_details.object.co_facility_of[ll_markloop] = lstr_target.co_id
		dw_facility_details.object.co_status[ll_markloop] = lstr_target.co_status
	next
	
	for ll_markloop = 1 to li_contact_count
		ids_Contacts.object.ct_co[ll_markloop] = lstr_target.co_id
	next
	
	dw_co_info.setredraw(false)
	
	dw_co_info.object.co_facility_of[1] = lstr_target.co_id
	dw_co_info.object.co_bill_same[1] = "T"
	dw_co_info.object.co_bill_name[1] = null_str
	dw_co_info.object.co_bill_addr1[1] = null_str
	dw_co_info.object.co_bill_addr2[1] = null_str
	dw_co_info.object.co_bill_city[1] = null_str
	dw_co_info.object.co_bill_state[1] = null_str
	dw_co_info.object.co_bill_zip[1] = null_str
	dw_co_info.object.co_bill_phone1[1] = null_str
	dw_co_info.object.co_bill_phone2[1] = null_str
	dw_co_info.object.co_bill_fax[1] = null_str
	dw_co_info.object.co_bill_usnon[1] = null_str
	dw_co_info.object.co_bill_country[1] = null_str
	dw_co_info.object.co_bill_acctcode[1] = null_str
	dw_co_info.object.co_status[1] = lstr_target.co_status
	dw_co_info.object.co_bill_attn[1] = "N"
	dw_co_info.object.co_bill_attn_text[1] = null_str
	dw_co_info.object.co_allow_billing[1] = "F"
	dw_co_info.object.co_intsig[1] = dw_co_info.object.co_intsig[1] + 1
	
	if dw_co_info.update(false, false) = -1 then goto rollitback
	
	if dw_facility_details.update(false, false) = -1 then goto rollitback
	
	if ids_Contacts.update(false, false) = -1 then goto rollitback
	
	update disp_ship set ds_billto_id = :lstr_target.co_id, ds_intsig = ds_intsig + 1 where ds_billto_id = :co_to_display ;
	if sqlca.sqlcode = -1 then goto rollitback

	DELETE FROM system_settings WHERE ss_uid = :co_to_display AND ss_id < 1000 ;
	if sqlca.sqlcode = -1 then goto rollitback
	
	commit ;
	if sqlca.sqlcode <> 0 then goto rollitback

end choose

ll_affected[upperbound(ll_affected) + 1] = co_to_display
ll_affected[upperbound(ll_affected) + 1] = lstr_target.co_id
ll_affected[upperbound(ll_affected) + 1] = lstr_targpar.co_id
//It's ok that targpar.co_id may be the same as target.co_id, or may not be there at all
for ll_markloop = 1 to li_facility_count
	ll_affected[upperbound(ll_affected) + 1] = dw_facility_details.object.co_id[ll_markloop]
next

gnv_cst_companies.of_cache(ll_affected, true)

//I decided to scrap this refresh attempt because you would also have to do the equipment
//list, and any others that may be added.  A possible alternative is to add the capability
//to the company service of rolling down changes into the various cache lists.  Keep in
//mind, though, that the shipments that would be affected ARE modified in the update
//process above, and therefore would be fixed in a refresh anyway.

//ls_message = ""

//
//if gstr_list_settings.b_trips_retrieved or gstr_list_settings.b_ships_retrieved then
//	if gstr_list_settings.b_trips_retrieved then ls_work = "TRIP~tSHIP" &
//		else ls_work = "SHIP"
//	if gf_refresh(ls_work) = -1 then
//		ls_message = "The operation was performed successfully, but an updated shipment "+&
//			"list reflecting the changes could not be retrieved.  Please attempt to refresh "+&
//			"the list yourself."
//	end if
//end if
//
//if ls_message = "" then ls_message = "Operation performed successfully."
//
////Closing the window here and in rollitback is the easiest option for now.
//
//ls_message += "~n~nThis window will close."
//messagebox(ls_message_header, ls_message)


//Closing the window here and in rollitback is the easiest option for now.

messagebox(ls_message_header, "Operation performed successfully.  The change "+&
	"will be reflected in the summary lists once you refresh them.~n~nThis "+&
	"window will close.")

winisclosing = true
close(this)

return

rollitback:
rollback ;

messagebox(ls_message_header, "Could not process request.  Window will close.", &
	exclamation!)

winisclosing = true
close(this)
end subroutine

protected function string of_getstreetlatlong (string as_address, string as_locater, ref string as_newaddress);string	ls_pcm_address, &
			ls_latlong, &
			ls_foundlocation
			
integer	li_retval
long		ll_pos


if inv_routing.of_locationcheck(as_locater, ls_foundlocation, true) > 0 then
	ls_latlong = inv_routing.of_addresstolatlong(ls_foundlocation)
	as_newaddress = ls_foundlocation
else
	//if a locater can't be returned using street then strip off the street and
	//get a locater for the city/state and use that latlong
	ll_pos = pos(as_locater,';')
	if ll_pos > 0 then
		as_locater = trim ( left(as_locater, ll_pos - 1) )
		if inv_routing.of_locationcheck(as_locater, ls_foundlocation, true) > 0 then
			ls_latlong = inv_routing.of_addresstolatlong(ls_foundlocation)
		end if
	end if
end if

return ls_latlong
end function

protected function integer of_checkstreetinzip (string as_street, string as_zip, ref string as_foundlocator);/*
	return 0	if no zip submitted with street
	return 1 if locater is returned
	return -1  if zip is invalid or if the user cancelled out of list
	
*/
integer	li_return = 1, &
			li_Retval
long		ll_len, &
			ll_Ndx
string	ls_locater, &
			ls_foundlocater, &
			ls_street, &
			ls_zip
			
if len(as_zip) > 0 then
//	//first, is zip valid
//	ls_locater = as_zip
//	li_Retval = inv_routing.of_locationcheck(ls_locater, ls_foundlocater, true)
//	if li_Retval > 0 then
//		//ok
//	else
//		mboxret = 1
//		messagebox("Location Verification", &
//							"The zip code is not valid.",Information!)
//		li_return = -1
//	end if
else
	li_return = 0
end if

if li_return = 1 then
	if isnull(as_street) or len(as_street) = 0 then
		//none passed in
		li_return = 0
	else
		//check street with zip
		ls_locater = as_zip + '; ' + as_street
		li_Retval = inv_routing.of_locationcheck(ls_locater, ls_foundlocater, true)
		SetPointer(HourGlass!)
		choose case li_retval
			case 1, 2
				//good match
				li_return = 1
			case 0
				mboxret = 1
				choose case messagebox("Location Verification", "The PC*Miler street "+&
							" is not valid in this zipcode. Do you want to clear the street " +&
							"and see a list of possible choices similar to the street you entered for this zip?" , &
						question!, yesno!)
	
					case 1 
						if len(as_street) > 2 then
							//remove number from street name
							ll_len = len(as_street)
							for ll_ndx = 1 to ll_len
								if isnumber(left(as_street,ll_ndx) ) then
									continue
								else
									ll_len = ll_ndx - 1
									exit
								end if
							next
							ls_street = trim(right(as_street,len(as_street) - ll_len))
							if len(ls_street) > 2 then
								ls_locater = as_zip + '; ' + left(ls_street,2) + "*"
								SetPointer(HourGlass!)
								if inv_routing.of_locationcheck(ls_locater, ls_foundlocater, false) > 0 then
									li_return = 1
								else
									li_return = -1
								end if
							else
								messagebox("Location Verification",&
								"At least 2 characters must be entered to try a partial match." )
								li_return = -1
							end if
						end if
					case 2
						li_return = -1
				end choose	
			case -1
				li_return = -1
		//				mboxret = 1
		//				messagebox("Location Verification", "The PC*Miler street "+&
		//							" is not valid in this zip. ")				
				
		end choose
				
	end if
end if
if len ( ls_foundlocater ) > 0 then
	as_foundlocator = ls_foundlocater
end if

return li_return

end function

protected function integer of_checkstreetincitystate (ref string as_street, string as_city, string as_state, ref string as_foundlocater);/*
	return 0	if no city/state submitted with street
	return 1 if locater is returned
	return -1  if city/state is invalid or if the user cancelled out of list
	
*/
SetPointer(HourGlass!)
integer	li_return = 1, &
			li_Retval
long		ll_len, &
			ll_ndx

string	ls_locater, &
			ls_foundlocater, &
			ls_street, &
			ls_selected_street
			
if len(as_city) > 0 and len(as_state) > 0 then
	//ok
else
	//nothing to check in
	li_return = 0
end if

if li_return = 1 then
	if isnull(as_street) or len(as_street) = 0 then
		//none passed in
		li_return = 0
	else
		//check street with city/state
		ls_locater = as_city + ', ' + as_state + '; ' + as_street
		li_Retval = inv_routing.of_locationcheck(ls_locater, ls_foundlocater, true)
		SetPointer(HourGlass!)
		choose case li_retval
			case 1, 2
				//good match
				li_return = 1
			case 0, -1
				mboxret = 1
				choose case messagebox("Location Verification", "The PC*Miler street "+&
							" is not valid in this city/state. "+&
						"Do you want to see a list of choices to select a PC*Miler Location?" , &
						question!, yesno!)

					case 1 
						if len(as_street) > 2 then
							//remove number from  street name
							ll_len = len(as_street)
							for ll_ndx = 1 to ll_len
								if isnumber(left(as_street,ll_ndx) ) then
									continue
								else
									ll_len = ll_ndx - 1
									exit
								end if
							next
							ls_street = trim(right(as_street,len(as_street) - ll_len))
							if len(ls_street) > 2 then
								ls_locater = as_city + ', ' + as_state + '; ' + left(ls_street,2) + "*"
							else
								ls_locater = as_city + ', ' + as_state 
							end if
						end if
						SetPointer(HourGlass!)
						if inv_routing.of_locationcheck(ls_locater, ls_foundlocater, false) > 0 then
							ls_selected_street = inv_routing.of_getpartoflocater(ls_foundlocater, "STREET", true)
							if ls_selected_street <> as_street then
								as_street = ls_Selected_Street
							end if
							li_return = 1
						else
							li_return = -1
						end if
					case 2
						li_return = -1										
				end choose
		end choose
		
	end if
	
end if
SetPointer(HourGlass!)	
if len ( ls_foundlocater ) > 0 then
	as_foundlocater = ls_foundlocater
end if

return li_return

end function

protected function string of_streetsverification (ref string as_street, ref string as_city, ref string as_state);/*	 A street will be validated against a city state combination
 	but not zip code. I'm assuming if the street is valid for the 
	city/state then it must be for the zip. 
	If a zip validation triggers a change in city/state then
	the street will be verified for the new city/state. 
	
	return a null value if locator not found
*/
setpointer(HourGlass!)
string	ls_foundpcm, &
			ls_newaddress, &
			ls_latlong, &
			ls_locater, &
			ls_save_street
			
setnull(ls_latlong)

//validate street
if len(as_street) > 0 then
	if len(as_city) > 0 and len(as_state) > 0 then
		//check for city state
		ls_save_street = as_street
		choose case this.of_checkstreetincitystate(as_street, as_city, as_state, ls_foundpcm)
			case 1 
				//replace locator
				ls_latlong = inv_routing.of_addresstolatlong(ls_foundpcm)
				if as_street <> ls_save_street then
					//a new street was selected for the locater
					choose case messagebox("Location Verification", "Do you want to replace the " +&
							"street address that you entered with the PC*Miler street "+&
							"you selected?" , &
						question!, yesno!)
	
						case 1 
							//argument already changed
						case 2
							as_street = ls_save_street
					end choose
	
				end if				
			case 0
				//user cancelled out of list 
				
			case -1
				//couldn't find locater
				
		end choose
	end if

end if

return ls_latlong
end function

public function integer wf_contactdetails (long al_contactid);//long	ll_ID
//n_cst_msg	lnv_Msg
//S_Parm		lstr_Parm
//
//
//
//IF dw_contacts.GetRow ( ) > 0 THEN
//	
//	ll_ID = dw_contacts.getItemNumber (  dw_contacts.GetRow ( ) , "contacts_ct_id" )
//	
//END IF
//
//IF ll_ID > 0 THEN
//	lstr_Parm.is_Label = "CONTACTID"
//	lstr_Parm.ia_Value = ll_ID
//	lnv_Msg.of_Add_Parm ( lstr_Parm )
//	OpenWithParm ( w_CompanyContact_Detail , lnv_Msg )
////	THIS.of_Populate ( )
//END IF

Return 1
end function

public function integer wf_newcontact ();//Long	ll_Null
//
//SetNull ( ll_Null )
//
//n_cst_msg	lnv_Msg
//S_Parm		lstr_Parm
//
//lstr_Parm.is_Label = "COMPANYID"
//lstr_Parm.ia_Value = co_to_display
//lnv_Msg.of_Add_Parm ( lstr_Parm )
//
//lstr_Parm.is_Label = "CONTACTID"
//lstr_Parm.ia_Value = ll_Null
//lnv_Msg.of_Add_Parm ( lstr_Parm )
//
//OpenWithParm ( w_CompanyContact_Detail , lnv_Msg )




RETURN 1
end function

protected function integer wf_retrievecontacts ();
IF co_to_display > 0 THEN
	ids_contacts.Retrieve ( {co_to_display}  )
	
	ids_Contacts.ShareData ( dw_contacts )

END IF

RETURN 1
end function

private function integer wf_initializecontacts ();IF isValid ( ids_Contacts ) THEN
	DESTROY ( ids_Contacts ) 
END IF

ids_Contacts = CREATE DataStore
ids_Contacts.DataObject = "d_companycontacts_list"
ids_Contacts.SetTransObject ( SQLCA ) 
ids_Contacts.SetFilter ("ct_co = " + String (  co_to_Display ) )
ids_Contacts.Filter ( )

dw_contacts.of_SetCompanyid ( co_to_Display )
dw_contacts.of_SetCache ( ids_Contacts )

THIS.wf_RetrieveContacts ( )

RETURN 1
end function

private function integer of_disableentryfields ();Long	ll_ColCount
Long	ll_Index
string	ls_Return
String	ls_Name

ll_ColCount = Long(dw_Co_Info.Object.DataWindow.Column.Count)

//Disable Fields
FOR ll_Index = 1 TO ll_ColCount
	ls_Name = dw_co_info.Describe ("#" + String(ll_Index) + ".Name")
	dw_co_info.Modify ( ls_Name + ".TabSequence = 0 ")
	dw_co_info.MOdify(ls_Name + ".Background.Color = " + cs_Color_Disabled )
NEXT

//Disable Buttons
cb_newfac.Visible = FALSE
cb_delfac.Visible = FALSE
cb_nofac.Visible = FALSE
cb_newct.Visible = FALSE
cb_delct.Visible = FALSE
cb_newco.Visible = FALSE
cb_delco.Visible = FALSE
cb_replace.Visible = FALSE
cb_makefac.Visible = FALSE
cb_car_ct.Visible = FALSE
cb_lanes.Visible = FALSE

return 1
end function

event open;n_cst_Msg	lnv_Msg
s_Parm		lstr_parm
String		ls_NewCo

co_to_display = message.doubleparm

IF isValid(Message.PowerobjectParm) THEN
	
	lnv_Msg = Message.PowerObjectParm
	
	IF lnv_Msg.of_Get_Parm("NEWCOMPANY", lstr_Parm) <> 0 THEN
		ls_NewCo = lstr_Parm.ia_Value
	END IF
	
END IF

long	li_SqlCode
this.x = 1
this.y = 1

//This valid check is necessary incase this is opened as a response window (w_company_response)
IF isValid(m_company) THEN
	gf_mask_menu(m_company)
	
	n_cst_LicenseManager	lnv_LicenseManager
	
	IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Settlements ) THEN
		//Settlements is licensed.  Leave the Payables Setup menu item visible.
	ELSE
		//Settlements is not licensed.  Hide the Payables Setup menu item and its divider.
		m_Company.m_Current.m_div_c02.Visible = FALSE
		m_Company.m_Current.m_PayablesSetup.Visible = FALSE
	END IF
	
	IF lnv_LicenseManager.of_HasAnyEDILicense ( ) THEN
		//EDI is licensed.  Leave the EDI Setup menu item visible.
		//EDI is licensed.  Leave the EDI LOG menu item visible.
	ELSE
		//EDI is not licensed. Hide the EDI Setup menu item.
		m_Company.m_Current.m_EDISetup.Visible = FALSE
		//EDI is not licensed. Hide the EDI Log menu item.
		m_Company.m_Current.m_EDILog.Visible = FALSE
	END IF
END IF

inv_trip = create n_cst_trip
//destroyed in close event
if pcms_inst AND (lnv_LicenseManager.of_usepcmilerstreets() or &
			lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_PCMiler )) then
	if inv_trip.of_connect(inv_routing) then
		if inv_routing.of_isvalid() then
			ib_pcmilerconnected=true
			if inv_routing.of_isoldpcmilerversion() then
				ib_oldpcmilerversion=true
			end if
			if inv_routing.of_isstreets() then
				ib_pcmilerstreets = true
			end if
			if inv_routing.of_IsCanadianPostalInstalled ( ) then
				ib_canadianpostal = true
			end if
		else
			ib_pcmilerconnected=false
		end if
	else
		ib_pcmilerconnected=false
	end if
end if

dw_co_info.settransobject(sqlca)
dw_car_info.settransobject(sqlca)
//dw_facility_list.settransobject(sqlca)
dw_facility_details.settransobject(sqlca)
//dw_contact_list.settransobject(sqlca)
//dw_ct_info.settransobject(sqlca)

dw_facility_details.sharedata(dw_facility_list)
dw_facility_details.setsort("co_name A, co_id A")


//THIS.Post wf_InitializeContacts ( )
IF co_to_display > 0 THEN
	retr()
ELSEIF NOT isNull(ls_NewCo) AND Len(ls_NewCo) > 0 THEN
	This.Event ue_NewCompany(ls_NewCo)
ELSE
	setnull(co_to_display)
	This.Event ue_SelectCompany("ANY!")
END IF




end event

event closequery;if winisclosing then return 0 //forced close

winisclosing = true //changed to false at end of script if query is rejected

if needs_update() = false then return 0

this.setfocus()
this.show()

choose case messagebox("Company Information", "Save changes before closing?", &
	question!, yesnocancel!, 1)
		case 2
			return 0
		case 3
			goto reject
end choose

if save() = 1 then return 0

if messagebox("Company Information", "Could not save changes to database.~n~nPress OK "+&
	"to abandon changes and close window, or Cancel to return to window and preserve "+&
	"changes for now.", exclamation!, okcancel!, 2) = 1 then return 0

reject:
winisclosing = false
return 1
end event

on w_company.create
if this.MenuName = "m_company" then this.MenuID = create m_company
this.cb_lanes=create cb_lanes
this.cb_details=create cb_details
this.cb_nofac=create cb_nofac
this.cb_makefac=create cb_makefac
this.cb_replace=create cb_replace
this.dw_car_info=create dw_car_info
this.st_2=create st_2
this.cb_delfac=create cb_delfac
this.cb_newfac=create cb_newfac
this.st_1=create st_1
this.dw_facility_list=create dw_facility_list
this.cb_selco=create cb_selco
this.cb_delco=create cb_delco
this.cb_delct=create cb_delct
this.cb_newct=create cb_newct
this.cb_newco=create cb_newco
this.dw_co_info=create dw_co_info
this.dw_facility_details=create dw_facility_details
this.dw_contacts=create dw_contacts
this.cb_car_ct=create cb_car_ct
this.Control[]={this.cb_lanes,&
this.cb_details,&
this.cb_nofac,&
this.cb_makefac,&
this.cb_replace,&
this.dw_car_info,&
this.st_2,&
this.cb_delfac,&
this.cb_newfac,&
this.st_1,&
this.dw_facility_list,&
this.cb_selco,&
this.cb_delco,&
this.cb_delct,&
this.cb_newct,&
this.cb_newco,&
this.dw_co_info,&
this.dw_facility_details,&
this.dw_contacts,&
this.cb_car_ct}
end on

on w_company.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_lanes)
destroy(this.cb_details)
destroy(this.cb_nofac)
destroy(this.cb_makefac)
destroy(this.cb_replace)
destroy(this.dw_car_info)
destroy(this.st_2)
destroy(this.cb_delfac)
destroy(this.cb_newfac)
destroy(this.st_1)
destroy(this.dw_facility_list)
destroy(this.cb_selco)
destroy(this.cb_delco)
destroy(this.cb_delct)
destroy(this.cb_newct)
destroy(this.cb_newco)
destroy(this.dw_co_info)
destroy(this.dw_facility_details)
destroy(this.dw_contacts)
destroy(this.cb_car_ct)
end on

event close;if isvalid(inv_trip) then
	destroy inv_trip
end if

end event

type cb_lanes from commandbutton within w_company
integer x = 3077
integer y = 928
integer width = 498
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "C&arrier Lanes"
end type

event constructor;THIS.Visible = FALSE 
end event

event clicked;n_cst_LicenseManager	lnv_LicenseManager
IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) THEN

	Long			ll_CoID
	Long	ll_Row
	n_cst_Msg	lnv_Msg
	S_Parm		lstr_Parm
	IF dw_facility_details.Visible THEN		
		ll_Row = dw_facility_details.GetRow ( )
		IF ll_Row > 0 THEN
			ll_CoID = dw_facility_details.GetItemNumber  ( ll_Row , "co_id" )
		END IF
	ELSE
		ll_CoID = co_to_display
	END IF
	
	lstr_Parm.ia_Value = ll_CoID
	lstr_Parm.is_Label = "CARRIERID"
	lnv_Msg.of_Add_Parm (lstr_Parm )
	
	SetPointer ( HOURGLASS! ) 
	OpenWithParm ( w_LaneSetup , lnv_Msg ) 

ELSE
	MessageBox ( "Carrier Lanes" , "You are not licensed for the Brokerage Module. Please contact Profit Tools." )
END IF
	
	
end event

type cb_details from commandbutton within w_company
integer x = 3077
integer y = 12
integer width = 498
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&More Details..."
end type

event clicked;Parent.Event ue_CompanyDetails ( )
end event

type cb_nofac from commandbutton within w_company
integer x = 923
integer y = 1088
integer width = 530
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Make Independent"
end type

event clicked;integer selrow
string msgstr, ls_message_header
n_cst_numerical	lnv_Numerical
n_cst_Privileges	lnv_Privileges

ls_message_header = "Make Facility Independent"

selrow = dw_facility_list.getselectedrow(0)
if lnv_numerical.of_isnullornotpos(selrow) then return

IF lnv_Privileges.of_HasAdministrativeRights ( ) = FALSE THEN
	MessageBox ( ls_message_header, lnv_Privileges.of_GetRestrictMessage ( ) )
	RETURN
END IF

msgstr = "You have requested that the selected facility, " + dw_facility_details.object.co_name[selrow] +&
	", no longer be associated with the parent company, " + dw_co_info.object.co_name[1] + "."

if needs_update() then
	if messagebox(ls_message_header, msgstr + "~n~nYou must either save or clear your changes before "+&
	"performing this procedure.~n~nOK to save changes and proceed?", question!, okcancel!) &
		= 2 then return
	if save() = -1 then
		messagebox("Save Changes", "Could not save changes to database.~n~nMake "+&
			"Facility Independent request cancelled.", exclamation!)
		return
	end if
else
	if messagebox(ls_message_header, msgstr + "~n~nOK to proceed?", &
		question!, okcancel!) = 2 then return
end if

dw_facility_details.object.co_facility_of[selrow] = -1
dw_facility_details.object.co_bill_attn[selrow] = "F"
dw_facility_details.object.co_intsig[selrow] = &
	dw_facility_details.object.co_intsig[selrow] + 1

if dw_facility_details.update(false, false) = -1 then goto rollitback

commit ;
if sqlca.sqlcode <> 0 then goto rollitback

//Closing the window here and in rollitback is the easiest option for now.

messagebox(ls_message_header, "Operation performed successfully.~n~n"+&
	"Window will close.")

winisclosing = true
close(parent)

return

rollitback:
rollback ;

messagebox(ls_message_header, "Could not process request.  Window will close.", &
	exclamation!)

winisclosing = true
close(parent)
end event

type cb_makefac from commandbutton within w_company
integer x = 3077
integer y = 664
integer width = 498
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Make &Facility of..."
end type

event clicked;wf_alter_company("MAKE_FACILITY!")
end event

type cb_replace from commandbutton within w_company
integer x = 3077
integer y = 552
integer width = 498
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Replace With..."
end type

event clicked;wf_alter_company("REPLACE!")
end event

type dw_car_info from datawindow within w_company
event dwnprocessenter pbm_dwnprocessenter
boolean visible = false
integer x = 14
integer width = 3584
integer height = 1084
string dataobject = "d_carrier_cert"
boolean border = false
boolean livescroll = true
end type

event dwnprocessenter;send(handle(this), 256, 9, long(0, 0))
return 1
end event

event losefocus;//if mboxret = 0 and not winisclosing then 
//	if this.accepttext() = -1 then
//		this.post setfocus()
//		abort_close = true
//		return
//	end if
//	if this.getcolumnname() = "bc_liability_car" then
//		this.settext(this.object.bc_liability_car[1])
//	else
//		this.setcolumn("bc_liability_car")
//	end if
//end if
end event

on dberror;mboxret = 1
end on

event itemchanged;choose case dwo.name
	case "bc_common", "bc_broker", "bc_contract"
		string mc_col
		mc_col = dwo.name + "_mc"
		if dwo.primary[row] = "T" then
			this.setitem(1, mc_col, null_str)
		else
			this.modify(mc_col + ".editmask.mask = '###### (!!!)'")
		end if
end choose
end event

event itemerror;n_cst_string lnv_string
choose case dwo.name
	case "bc_liability_exp", "bc_cargo_exp", "bondexpirationdate" , "workmansexpiration" , "contractdate" , "holdharmlessdate"
		date compdate
		compdate = lnv_string.of_SpecialDate(data)
		if isnull(compdate) then goto invalid
		dwo.primary[row] = compdate
		return 3
	case "bc_liability_amt", "bc_cargo_amt", "bc_bond_amt" , "workmansamount"
		decimal compdec
		compdec = lnv_string.of_SpecialNumber(data)
		if isnull(compdec) then goto invalid
		compdec = truncate(compdec, 0)
		if compdec >= 0 and compdec < 1000000000 then
			dwo.primary[row] = compdec
			return 3
		end if
end choose

invalid:

mboxret = 1
messagebox("Carrier Info", "The value you have entered is invalid.~n~nPlease edit your "+&
	"entry, or restore the previous value by pressing escape in the edit field.")

return 1
end event

event constructor;n_cst_Privileges					lnv_Privileges

IF NOT lnv_Privileges.of_HasEntryRights( ) THEN
	of_DisableEntryFields()
END IF
end event

type st_2 from statictext within w_company
integer x = 1742
integer y = 1104
integer width = 261
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Contacts"
boolean focusrectangle = false
end type

type cb_delfac from commandbutton within w_company
integer x = 635
integer y = 1088
integer width = 247
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Delete"
end type

event clicked;integer selrow
n_cst_numerical lnv_numerical
selrow = dw_facility_list.getselectedrow(0)
if lnv_numerical.of_isnullornotpos(selrow) then return

if messagebox("Delete Facility", "OK to delete the selected facility?", exclamation!, &
	okcancel!, 2) = 2 then return

dw_facility_details.visible = false

if dw_facility_details.object.co_id[selrow] > 0 then
	dw_facility_details.object.co_status[selrow] = "D"
	dw_facility_details.object.co_code_name[selrow] = null_str
	dw_facility_details.rowsmove(selrow, selrow, primary!, dw_facility_details, 9999, filter!)
else
	dw_facility_details.rowsdiscard(selrow, selrow, primary!)
end if

this.enabled = false
end event

type cb_newfac from commandbutton within w_company
integer x = 347
integer y = 1088
integer width = 247
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "New"
end type

event clicked;if isnull(co_to_display) then return

string newname, xon_1, xon_2
long	ll_newrow

//!!See notes in n_cst_companies regarding what should be done with this!!

newname = "*NF" + dw_co_info.object.co_name[1]
openwithparm(w_coname, newname)

newname = message.stringparm

if newname = "*NF" then return

gf_coname_index(newname, xon_1, xon_2)

if len(righttrim(xon_2)) > 0 then xon_2 = xon_2 else setnull(xon_2)

dw_facility_list.setredraw(false)
dw_facility_details.setredraw(false)

ll_newrow = dw_facility_details.insertrow(0)

dw_facility_details.object.co_id[ll_newrow] = 0
dw_facility_details.object.co_name[ll_newrow] = newname
dw_facility_details.object.co_facility_of[ll_newrow] = co_to_display
dw_facility_details.object.co_xon_1[ll_newrow] = xon_1
dw_facility_details.object.co_xon_2[ll_newrow] = xon_2
dw_facility_details.object.co_bill_attn[ll_newrow] = "N"

dw_facility_list.selectrow(0, false)
dw_facility_list.selectrow(ll_newrow, true)

dw_facility_details.sort()
ll_newrow = dw_facility_list.getselectedrow(0)

dw_facility_details.scrolltorow(ll_newrow)
dw_facility_list.scrolltorow(ll_newrow)

dw_facility_list.setredraw(true)
dw_facility_details.setredraw(true)

//dw_ct_info.visible = false
dw_facility_details.visible = true

cb_delfac.enabled = true
cb_nofac.enabled = true

dw_facility_details.setcolumn("co_addr1")
dw_facility_details.setfocus()
end event

type st_1 from statictext within w_company
integer x = 32
integer y = 1104
integer width = 283
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Facilities"
boolean focusrectangle = false
end type

type dw_facility_list from datawindow within w_company
integer x = 32
integer y = 1192
integer width = 1673
integer height = 504
string dataobject = "d_company_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

on rbuttondown;parent.postevent("show_pop", 2, 0)
end on

event clicked;if row > 0 then
	if dw_facility_details.visible then
	//	dw_facility_details.accepttext()
		dw_facility_details.setcolumn("co_name")
		parent.postevent("focus_response", 2, 0)
	end if
	this.selectrow(0, false)
	this.selectrow(row, true)
	dw_facility_details.scrolltorow(row)
	cb_delfac.enabled = true
	cb_nofac.enabled = true
end if
end event

on dberror;mboxret = 1
end on

event doubleclicked;if row > 0 then
	//dw_ct_info.visible = false
	dw_facility_details.visible = true
end if
end event

type cb_selco from commandbutton within w_company
integer x = 3077
integer y = 164
integer width = 498
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Select Company"
end type

event clicked;Parent.Event ue_SelectCompany("ANY!")
end event

type cb_delco from commandbutton within w_company
integer x = 3077
integer y = 440
integer width = 498
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Delete Company"
end type

event clicked;if isnull(co_to_display) then return

n_cst_Privileges	lnv_Privileges
String	ls_MessageHeader = "Delete Company"

IF lnv_Privileges.of_HasAdministrativeRights ( ) = FALSE THEN
	MessageBox ( ls_MessageHeader, lnv_Privileges.of_GetRestrictMessage ( ) )
	RETURN
END IF

if messagebox(ls_MessageHeader, "OK to delete the current company?", &
	exclamation!, okcancel!, 2) = 2 then return

if co_to_display = 0 then goto clear_display

long ll_markloop

dw_co_info.object.co_status[1] = "D"
dw_co_info.object.co_code_name[1] = null_str
dw_co_info.object.co_bill_acctcode[1] = null_str
dw_co_info.object.co_allow_billing[1] = "F"

for ll_markloop = 1 to dw_facility_details.rowcount()
	dw_facility_details.object.co_status[ll_markloop] = "D"
	dw_facility_details.object.co_code_name[ll_markloop] = null_str
	dw_facility_details.object.co_bill_acctcode[ll_markloop] = null_str
	dw_facility_details.object.co_allow_billing[ll_markloop] = "F"
next

//For now, this leaves contact status as "K"; this could need to be changed

if save() = -1 then
	messagebox(ls_MessageHeader, "Could not delete company from database.~n~n"+&
		"Window will close.", exclamation!)
	winisclosing = true
	close(parent)
	return
end if

clear_display:

dw_facility_details.visible = false
//dw_ct_info.visible = false
dw_car_info.visible = false

dw_facility_details.reset()
//dw_ct_info.reset()
dw_car_info.reset()

dw_co_info.setredraw(false)
dw_co_info.reset()
dw_co_info.setcolumn("co_intsig")
dw_co_info.insertrow(0)
setnull(co_to_display)
dw_co_info.object.co_id[1] = co_to_display
dw_co_info.setredraw(true)

parent.postevent("set_buttons")

end event

type cb_delct from commandbutton within w_company
integer x = 2345
integer y = 1088
integer width = 247
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked; dw_contacts.Event ue_DeleteContact ( dw_contacts.getrow( ) )


	



//integer selrow
//n_cst_numerical lnv_numerical
//selrow = 
//if lnv_numerical.of_isnullornotpos(selrow) then return
//
//if messagebox("Delete Contact", "OK to delete the selected contact?", exclamation!, &
//	okcancel!, 2) = 2 then return
//
//dw_ct_info.visible = false
//
//dw_ct_info.deleterow(selrow)
//
//this.enabled = false
end event

type cb_newct from commandbutton within w_company
integer x = 2062
integer y = 1088
integer width = 247
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "New"
end type

event clicked;IF NOT co_to_display > 0 THEN
	MessageBox ( "New Contacts" , "Please save this company before adding contacts." )
ELSE
	dw_contacts.Event ue_newContact ( )
END IF


//if isnull(co_to_display) then return
//
//string readtel, readfax
//readtel = dw_co_info.object.co_phone1[1]
//readfax = dw_co_info.object.co_fax[1]
//
//long	ll_newrow
//
//dw_contact_list.setredraw(false)
//dw_ct_info.setredraw(false)
//
//ll_newrow = dw_ct_info.insertrow(0)
//
//dw_ct_info.setitem(ll_newrow, "ct_id", 0)
//dw_ct_info.setitem(ll_newrow, "ct_dirphone", readtel)
//dw_ct_info.setitem(ll_newrow, "ct_dirfax", readfax)
//dw_ct_info.setitem(ll_newrow, "ct_co", co_to_display)
//
//dw_contact_list.selectrow(0, false)
//dw_contact_list.selectrow(ll_newrow, true)
//
//dw_ct_info.sort()
//ll_newrow = dw_contact_list.getselectedrow(0)
//
//dw_ct_info.scrolltorow(ll_newrow)
//dw_contact_list.scrolltorow(ll_newrow)
//
//dw_contact_list.setredraw(true)
//dw_ct_info.setredraw(true)
//
//dw_facility_details.visible = false
//dw_ct_info.visible = true
//
//cb_delct.enabled = true
//
//dw_ct_info.setcolumn("ct_sal")
//dw_ct_info.setfocus()
end event

type cb_newco from commandbutton within w_company
integer x = 3077
integer y = 276
integer width = 498
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&New Company"
end type

event clicked;Parent.Event ue_SelectCompany("NEW!")
end event

type dw_co_info from datawindow within w_company
event dwnprocessenter pbm_dwnprocessenter
integer x = 37
integer y = 12
integer width = 2999
integer height = 1024
string dataobject = "d_company_info"
boolean livescroll = true
end type

event dwnprocessenter;send(handle(this), 256, 9, long(0, 0))
return 1
end event

on rbuttondown;parent.postevent("show_pop", 1, 0)
end on

event itemchanged;integer	li_return
boolean	lb_change
choose case dwo.name
	case 'co_zip'
		//the zip code field is being changed because of the mask 
		//check the trim value against the original
		if trim(data) = this.object.co_zip[row] then
			//no change
			lb_change=false
		else
			lb_change=true
		end if
	case else
		lb_change=true
end choose

if lb_change then
	li_return = change_response(this, row, dwo, data)
end if

return li_return

end event

event itemerror;mboxret = 1
messagebox("Company Information", "The value you have entered is invalid.~n~nPlease edit "+&
	"your entry, or restore the previous value by pressing escape in the edit field.")

return 1
end event

event losefocus;//if mboxret = 0 and not winisclosing then
//	focus_changing = true
//	if this.accepttext() = -1 then
//		this.post setfocus()
//		abort_close = true
//	else
//		if this.getcolumnname() = "co_name" then
//			this.settext(this.object.co_name[1])
//		else
//			this.setcolumn("co_name")
//		end if
//	end if
//	focus_changing = false
//end if

//if mboxret = 0 and not winisclosing then
//	if this.accepttext() = -1 then
//		this.post setfocus()
//		abort_close = true
//		return
//	end if
//	if this.getcolumnname() = "co_name" then
//		this.settext(this.object.co_name[1])
//	else
//		this.setcolumn("co_name")
//	end if
//end if
end event

on itemfocuschanged;parent.postevent("focus_response", 1, 0)
end on

on dberror;mboxret = 1
end on

event clicked;String	ls_object, &
			ls_pcm

n_cst_licensemanager	lnv_licensemanager
n_cst_msg	lnv_msg
s_parm		lstr_parm

ls_object = this.GetObjectAtPointer()

if pcms_inst AND (lnv_LicenseManager.of_usepcmilerstreets() or &
			lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_PCMiler )) then

	if pos(ls_object, 'p_nopcm', 1) > 0 or &
		pos(ls_object, 'p_pcm', 1) > 0 then
		
		ls_pcm = this.object.co_pcm[row]
	
		lstr_Parm.is_Label = "LOCATOR"
		lstr_Parm.ia_Value = this.object.co_pcm[row]
		lnv_Msg.of_Add_Parm (lstr_Parm)

		OpenWithParm ( w_custompcmlocator, lnv_Msg  )

		lnv_Msg = message.powerobjectparm
		if isvalid(lnv_msg) then
			IF lnv_msg.of_Get_Parm ("CANCELLED", lstr_Parm ) <> 0 THEN
				//Don't replace pcm
			ELSE
				IF lnv_msg.of_Get_Parm ("LOCATOR", lstr_Parm ) <> 0 THEN
					ls_pcm = lstr_Parm.ia_Value 
				END IF
			END IF	
		else
			//don't replace pcm
		end if
		
		this.object.co_pcm[row] = ls_pcm		
		
	end if
	
end if
end event

event constructor;n_cst_Presentation_State	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

end event

type dw_facility_details from datawindow within w_company
event syscommand pbm_syscommand
event dwnprocessenter pbm_dwnprocessenter
event dwnkey pbm_dwnkey
boolean visible = false
integer x = 677
integer y = 240
integer width = 1696
integer height = 1096
boolean bringtotop = true
boolean titlebar = true
string title = "Facility Details"
string dataobject = "d_company_info"
boolean minbox = true
boolean livescroll = true
end type

event syscommand;if message.wordparm = 61472 then
	this.hide()
	message.processed = true
	message.returnvalue = 0
end if
end event

event dwnprocessenter;send(handle(this), 256, 9, long(0, 0))
return 1
end event

on dwnkey;if keydown(keytab!) or keydown(keyenter!) or keydown(keydownarrow!) or &
	keydown(keyuparrow!) or keydown(keypagedown!) or keydown(keypageup!) then
		redraw_row = this.getrow()
		this.setredraw(false)
		this.postevent("rowfocuschanged")
end if
end on

on rbuttondown;parent.postevent("show_pop", 3, 0)
end on

event itemerror;mboxret = 1
messagebox("Facility Details", "The value you have entered is invalid.~n~nPlease edit "+&
	"your entry, or restore the previous value by pressing escape in the edit field.")

return 1
end event

event itemchanged;return change_response(this, row, dwo, data)
end event

event losefocus;//if mboxret = 0 and not winisclosing then 
//	if this.accepttext() = -1 then
//		this.post setfocus()
//		abort_close = true
//		return
//	end if
//	if this.getcolumnname() = "co_name" then
//		this.settext(this.object.co_name[this.getrow()])
//	else
//		this.setcolumn("co_name")
//	end if
//end if
end event

on itemfocuschanged;if redraw_row > 0 then
	this.scrolltorow(redraw_row)
	this.setredraw(true)
	redraw_row = 0
end if

parent.postevent("focus_response", 2, 0)
end on

on dberror;mboxret = 1
end on

on rowfocuschanged;if redraw_row > 0 then
	this.scrolltorow(redraw_row)
	this.setredraw(true)
	redraw_row = 0
end if
end on

event clicked;String ls_object, &
			ls_pcm

s_parm	lstr_parm
n_cst_msg	lnv_msg

n_cst_licensemanager	lnv_licensemanager

ls_object = this.GetObjectAtPointer()

if pcms_inst AND (lnv_LicenseManager.of_usepcmilerstreets() or &
			lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_PCMiler )) then

	if pos(ls_object, 'p_nopcm', 1) > 0 or &
		pos(ls_object, 'p_pcm', 1) > 0 then
		
		ls_pcm = this.object.co_pcm[row]
	
		lstr_Parm.is_Label = "LOCATOR"
		lstr_Parm.ia_Value = this.object.co_pcm[row]
		lnv_Msg.of_Add_Parm (lstr_Parm)

		OpenWithParm ( w_custompcmlocator, lnv_Msg  )

		lnv_Msg = message.powerobjectparm
		if isvalid(lnv_msg) then
			IF lnv_msg.of_Get_Parm ("CANCELLED", lstr_Parm ) <> 0 THEN
				//Don't replace pcm
			ELSE
				IF lnv_msg.of_Get_Parm ("LOCATOR", lstr_Parm ) <> 0 THEN
					ls_pcm = lstr_Parm.ia_Value 
				END IF
			END IF	
		else
			//don't replace pcm
		end if
		
		this.object.co_pcm[row] = ls_pcm		
		
	end if
	
end if
end event

event constructor;n_cst_Presentation_State	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

end event

type dw_contacts from u_dw_companycontacts_list within w_company
integer x = 1742
integer y = 1192
integer width = 1856
integer height = 504
integer taborder = 0
end type

event rbuttonup;// override w/ call to super
IF NOT co_to_display > 0 THEN
	MessageBox ( "New Contacts" , "Please save this company before adding contacts." )
ELSE
	RETURN SUPER::Event rbuttonup ( xpos ,ypos, row, dwo )
END IF


end event

type cb_car_ct from commandbutton within w_company
integer x = 3077
integer y = 824
integer width = 498
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Make Co a &Carrier"
end type

event clicked;if isnull(co_to_display) then //shouldn't happen
	this.enabled = false
	return
end if

if dw_car_info.visible then
	dw_car_info.visible = false
	this.text = "Show &Carrier Info"
	THIS.x = 3077
	THIS.y = 824
	
	cb_lanes.x = 3077
	cb_lanes.y = 928
	
else
	dw_facility_details.visible = false
	//dw_ct_info.visible = false
	if dw_car_info.rowcount() = 0 then
		dw_car_info.insertrow(0)
		dw_car_info.setitem(1, "bc_id", co_to_display)
		dw_car_info.setitem(1, "bc_lastupdt", datetime(today(), now()))
		dw_car_info.modify("bc_common_mc.edit.format = ''")
		dw_car_info.modify("bc_broker_mc.edit.format = ''")
		dw_car_info.modify("bc_contract_mc.edit.format = ''")
	end if
	cb_lanes.Visible = TRUE 
	dw_car_info.visible = true
	this.text = "Hide &Carrier Info"
	THIS.x = 3040
	THIS.y = 436
	THIS.Bringtotop = TRUE
	cb_lanes.x = 2523
	cb_lanes.y = 436
	cb_lanes.BringToTop = TRUE
	
	
end if
end event

