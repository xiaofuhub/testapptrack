$PBExportHeader$u_tab_companydetail.sru
forward
global type u_tab_companydetail from u_tab
end type
type tabpage_physicaladdress from userobject within u_tab_companydetail
end type
type dw_physicaladdress from datawindow within tabpage_physicaladdress
end type
type cb_printdirections from u_cb within tabpage_physicaladdress
end type
type mle_textprep from multilineedit within tabpage_physicaladdress
end type
type tabpage_physicaladdress from userobject within u_tab_companydetail
dw_physicaladdress dw_physicaladdress
cb_printdirections cb_printdirections
mle_textprep mle_textprep
end type
type tabpage_billingaddress from userobject within u_tab_companydetail
end type
type dw_billingaddress from datawindow within tabpage_billingaddress
end type
type tabpage_billingaddress from userobject within u_tab_companydetail
dw_billingaddress dw_billingaddress
end type
type tabpage_dispatch from userobject within u_tab_companydetail
end type
type dw_dispatch from u_dw_companyedit within tabpage_dispatch
end type
type tabpage_dispatch from userobject within u_tab_companydetail
dw_dispatch dw_dispatch
end type
type tabpage_notes from userobject within u_tab_companydetail
end type
type dw_notes from u_dw_companyedit within tabpage_notes
end type
type tabpage_notes from userobject within u_tab_companydetail
dw_notes dw_notes
end type
type tabpage_settings from userobject within u_tab_companydetail
end type
type dw_settings from u_dw_companyedit within tabpage_settings
end type
type sle_payablesid from singlelineedit within tabpage_settings
end type
type st_1 from statictext within tabpage_settings
end type
type tabpage_settings from userobject within u_tab_companydetail
dw_settings dw_settings
sle_payablesid sle_payablesid
st_1 st_1
end type
type tabpage_imaging from userobject within u_tab_companydetail
end type
type uo_imaging from u_cst_imagesettings within tabpage_imaging
end type
type tabpage_imaging from userobject within u_tab_companydetail
uo_imaging uo_imaging
end type
type tabpage_contacts from u_cst_tabpg_company_notification within u_tab_companydetail
end type
type tabpage_contacts from u_cst_tabpg_company_notification within u_tab_companydetail
end type
type tabpage_custom_a from userobject within u_tab_companydetail
end type
type dw_custom_a from u_dw_companyedit within tabpage_custom_a
end type
type tabpage_custom_a from userobject within u_tab_companydetail
dw_custom_a dw_custom_a
end type
type tabpage_custom_b from userobject within u_tab_companydetail
end type
type dw_custom_b from u_dw_companyedit within tabpage_custom_b
end type
type tabpage_custom_b from userobject within u_tab_companydetail
dw_custom_b dw_custom_b
end type
end forward

shared variables

end variables

global type u_tab_companydetail from u_tab
integer width = 2766
integer height = 1424
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 12632256
boolean boldselectedtext = true
boolean createondemand = true
tabpage_physicaladdress tabpage_physicaladdress
tabpage_billingaddress tabpage_billingaddress
tabpage_dispatch tabpage_dispatch
tabpage_notes tabpage_notes
tabpage_settings tabpage_settings
tabpage_imaging tabpage_imaging
tabpage_contacts tabpage_contacts
tabpage_custom_a tabpage_custom_a
tabpage_custom_b tabpage_custom_b
event ue_selectionchanged ( )
event type n_cst_beo_company ue_getcompany ( )
end type
global u_tab_companydetail u_tab_companydetail

type variables
PowerObject	ipo_Source
Long		il_CurrentRow

Constant Integer	ci_Tab_PhysicalAddress = 1
Constant Integer	ci_Tab_BillingAddress = 2
Constant Integer	ci_Tab_Dispatch = 3
Constant Integer	ci_Tab_Notes = 4
Constant Integer	ci_Tab_Settings = 5
Constant Integer	ci_Tab_Custom_A = 8
Constant Integer	ci_Tab_Custom_B = 9

Constant String	cs_Color_Disabled = "78682240"
end variables

forward prototypes
public function integer of_setsource (powerobject apo_source)
public function integer of_setcurrentrow (long al_row)
public function long of_getcurrentrow ()
public function powerobject of_getsource ()
public subroutine of_setpayablesid (string as_id)
public function string of_getpayablesid ()
end prototypes

public function integer of_setsource (powerobject apo_source);n_cst_dws	lnv_Dws
DataWindow	ldw_Source
DataStore	lds_Source
Long			ll_CurrentRow

Integer		li_Return = 1

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( apo_Source, ldw_Source, lds_Source )

CASE DataWindow!
	ll_CurrentRow = ldw_Source.GetRow ( )

CASE DataStore!
	ll_CurrentRow = lds_Source.GetRow ( )

CASE ELSE
	li_Return = -1

END CHOOSE

IF li_Return = 1 THEN
	ipo_Source = apo_Source
	IF ll_CurrentRow > 0 THEN
		This.Post of_SetCurrentRow ( ll_CurrentRow )
	END IF
END IF

RETURN li_Return
end function

public function integer of_setcurrentrow (long al_row);WindowObject	lwo_Controls[], &
					lwo_Control
DataWindow		ldw_Target
Long	ll_TabCount, &
		ll_TabIndex, &
		ll_ControlCount, &
		ll_ControlIndex


//Set the CurrentRow flag first, so that scrolling the dw's will not cause a re-notification
//(calling this function again).  Basically the same as the u_tab_Detail version, except as noted below.
il_CurrentRow = al_Row


ll_TabCount = UpperBound ( This.Control )

FOR ll_TabIndex = 1 TO ll_TabCount

	lwo_Controls = This.Control[ll_TabIndex].Control
	ll_ControlCount = UpperBound ( lwo_Controls )

	FOR ll_ControlIndex = 1 TO ll_ControlCount

		lwo_Control = lwo_Controls [ ll_ControlIndex ]

		IF lwo_Control.TypeOf ( ) = DataWindow! THEN   //u_tab_Detail version triggers query event here

			ldw_Target = lwo_Control
	
			IF ldw_Target.GetRow ( ) <> al_Row THEN
				ldw_Target.ScrollToRow ( al_Row )
			END IF

		END IF

	NEXT

NEXT


This.Post Event ue_SelectionChanged ( )

RETURN 1
end function

public function long of_getcurrentrow ();RETURN il_CurrentRow
end function

public function powerobject of_getsource ();RETURN ipo_Source
end function

public subroutine of_setpayablesid (string as_id);tabpage_settings.sle_payablesid.text = as_id
end subroutine

public function string of_getpayablesid ();return tabpage_settings.sle_payablesid.text
end function

on u_tab_companydetail.create
this.tabpage_physicaladdress=create tabpage_physicaladdress
this.tabpage_billingaddress=create tabpage_billingaddress
this.tabpage_dispatch=create tabpage_dispatch
this.tabpage_notes=create tabpage_notes
this.tabpage_settings=create tabpage_settings
this.tabpage_imaging=create tabpage_imaging
this.tabpage_contacts=create tabpage_contacts
this.tabpage_custom_a=create tabpage_custom_a
this.tabpage_custom_b=create tabpage_custom_b
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_physicaladdress
this.Control[iCurrent+2]=this.tabpage_billingaddress
this.Control[iCurrent+3]=this.tabpage_dispatch
this.Control[iCurrent+4]=this.tabpage_notes
this.Control[iCurrent+5]=this.tabpage_settings
this.Control[iCurrent+6]=this.tabpage_imaging
this.Control[iCurrent+7]=this.tabpage_contacts
this.Control[iCurrent+8]=this.tabpage_custom_a
this.Control[iCurrent+9]=this.tabpage_custom_b
end on

on u_tab_companydetail.destroy
call super::destroy
destroy(this.tabpage_physicaladdress)
destroy(this.tabpage_billingaddress)
destroy(this.tabpage_dispatch)
destroy(this.tabpage_notes)
destroy(this.tabpage_settings)
destroy(this.tabpage_imaging)
destroy(this.tabpage_contacts)
destroy(this.tabpage_custom_a)
destroy(this.tabpage_custom_b)
end on

event selectionchanging;//IF this is not the initial constructor (where OldIndex would be 0), 
//perform a pfc_AcceptText to be sure that data entered on the current page is valid.

Long	ll_Return = 0

IF OldIndex > 0 THEN

	IF This.Event pfc_AcceptText ( This.Control, TRUE ) = -1 THEN
		//AcceptText failed.  Prevent selection change by returning 1.
		ll_Return = 1
	END IF

END IF


RETURN ll_Return
		
end event

event constructor;n_cst_Presentation_Company	lnv_Presentation

String	ls_Label

IF lnv_Presentation.Event ue_GetCustomLabel ( "CustomA", ls_Label ) = 1 THEN
	tabpage_Custom_A.Text = ls_Label
END IF

IF lnv_Presentation.Event ue_GetCustomLabel ( "CustomB", ls_Label ) = 1 THEN
	tabpage_Custom_B.Text = ls_Label
END IF


end event

event pfc_update;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_update  OVERRIDING ANCESTOR to update just the ipo_Source, 
// instead of whatever array may be passed in.  This is necessary because the 
// many tabs may contain changes which we want to be accepted, but we only
// want to issue one update, which should be agains ipo_Source.  
//
//	Arguments:
//	apo_control[]	The controls on which to perform functionality.
//	ab_accepttext	When applicable, specifying whether control should perform an
//						AcceptText prior to performing the update:
//	ab_resetflag	Value specifying whether object should automatically 
//						reset its update flags.
//
//	Returns:   integer
//	 1 = all updates successful
//  0 = no action
//	-1 = at least one update failed
//
//////////////////////////////////////////////////////////////////////////////

// Make sure there is something to take action on.
If Not IsValid ( ipo_Source ) Then Return NO_ACTION
If Not of_IsUpdateable() Then Return NO_ACTION

n_cst_Dws	lnv_Dws

Integer		li_Return, &
				li_Result

li_Result = lnv_Dws.of_Update ( ipo_Source, ab_AcceptText, ab_ResetFlag )

CHOOSE CASE li_Result

CASE 1
	COMMIT ;
	li_Return = 1

CASE ELSE
	ROLLBACK ;
	li_Return = -1

END CHOOSE

RETURN li_Return
end event

type tabpage_physicaladdress from userobject within u_tab_companydetail
integer x = 18
integer y = 108
integer width = 2729
integer height = 1300
long backcolor = 12632256
string text = "Physical Addr."
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_physicaladdress dw_physicaladdress
cb_printdirections cb_printdirections
mle_textprep mle_textprep
end type

on tabpage_physicaladdress.create
this.dw_physicaladdress=create dw_physicaladdress
this.cb_printdirections=create cb_printdirections
this.mle_textprep=create mle_textprep
this.Control[]={this.dw_physicaladdress,&
this.cb_printdirections,&
this.mle_textprep}
end on

on tabpage_physicaladdress.destroy
destroy(this.dw_physicaladdress)
destroy(this.cb_printdirections)
destroy(this.mle_textprep)
end on

type dw_physicaladdress from datawindow within tabpage_physicaladdress
integer x = 41
integer y = 52
integer width = 1376
integer height = 648
integer taborder = 21
boolean enabled = false
string dataobject = "d_company_displayaddress"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;n_cst_dws	lnv_Dws
DataWindow	ldw_Source
DataStore	lds_Source
Long			ll_CurrentRow

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( of_GetSource ( ), ldw_Source, lds_Source )

CASE DataWindow!
	ldw_Source.ShareData ( This )

CASE DataStore!
	lds_Source.ShareData ( This )

END CHOOSE

ll_CurrentRow = of_GetCurrentRow ( )
IF ll_CurrentRow > 0 THEN
	This.ScrollToRow ( ll_CurrentRow )
END IF


//Don't need to set display flag here -- Already set to display primary
end event

event rowfocuschanging;//Note : This wasn't firing because there weren't any focusable columns, 
//but the arrows would scroll the row.  So, I disabled the dw instead.

//If the NewRow being set here is not the CurrentRow on the tab control, 
//notify the tab control of the change so it can synchronize other pages, etc.

IF CurrentRow = 0 OR NewRow = 0 THEN
	//DW is constucting.  Ignore.
ELSEIF of_GetCurrentRow ( ) <> NewRow THEN
	Post of_SetCurrentRow ( NewRow )
END IF
end event

type cb_printdirections from u_cb within tabpage_physicaladdress
integer x = 1481
integer y = 52
integer width = 498
integer taborder = 11
boolean bringtotop = true
string text = "&Print Directions"
end type

event clicked;long pj, ll_Row
integer choice, result, textlen, textloop, prevline, curline
string printstr

ll_Row = of_GetCurrentRow ( )

do
	pj = printopen("Directions")
	if pj = -1 then
		choice = messagebox("Print Directions", "Could not open print job -- Retry?", &
			question!, retrycancel!, 1)
	else
		result = printdefinefont(pj, 1, "Arial", -18, 400, Default!, AnyFont!, false, false)
		if result = -1 then goto finish_attempt
		result = printsetfont(pj, 1)
		if result = -1 then goto finish_attempt
		result = print(pj, "DIRECTIONS TO:")
		if result = -1 then goto finish_attempt
		result = print(pj, " ")
		if result = -1 then goto finish_attempt
		printstr = dw_PhysicalAddress.GetItemString(ll_Row, "co_name")
		if len(trim(printstr)) > 0 then result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		printstr = dw_PhysicalAddress.GetItemString(ll_Row, "co_addr1")
		if len(trim(printstr)) > 0 then result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		printstr = dw_PhysicalAddress.GetItemString(ll_Row, "co_addr2")
		if len(trim(printstr)) > 0 then result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		printstr = dw_PhysicalAddress.GetItemString(ll_Row, "comp_loc")
		if len(trim(printstr)) > 0 then result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		result = print(pj, " ")
		if result = -1 then goto finish_attempt
		printstr = "TEL1:~t" + dw_PhysicalAddress.GetItemString(ll_Row, "comp_phone1")
		result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		printstr = "TEL2:~t" + dw_PhysicalAddress.GetItemString(ll_Row, "comp_phone2")
		result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		printstr = "FAX:~t~t" + dw_PhysicalAddress.GetItemString(ll_Row, "comp_fax")
		result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		result = print(pj, " ")
		if result = -1 then goto finish_attempt

		prevline = 0
		mle_TextPrep.Text = dw_PhysicalAddress.GetItemString(ll_Row, "co_directions")
		textlen = len(mle_TextPrep.text)
		if textlen > 0 then
			for textloop = 1 to textlen
				mle_TextPrep.selecttext(textloop, 0)
				curline = mle_TextPrep.selectedline()
				if curline > prevline then result = print(pj, mle_TextPrep.textline())
				if result = -1 then exit
				prevline = curline
			next
		end if

//		printstr = dw_PhysicalAddress.GetItemString(ll_Row, "co_directions")
//		result = print(pj, printstr)
//		if result = -1 then goto finish_attempt

		finish_attempt:
		if result = -1 then
			printcancel(pj)
			choice = messagebox("Print Directions", "Error attempting to print -- "+&
				"Retry?", question!, retrycancel!, 1)
		else
			result = printclose(pj)
			if result = -1 then
				printcancel(pj)
				choice = messagebox("Print Directions", "Error attempting to print -- "+&
					"Retry?", question!, retrycancel!, 1)
			end if
		end if
	end if
loop until result = 1 or choice = 2
end event

type mle_textprep from multilineedit within tabpage_physicaladdress
boolean visible = false
integer x = 50
integer y = 768
integer width = 1298
integer height = 360
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_billingaddress from userobject within u_tab_companydetail
integer x = 18
integer y = 108
integer width = 2729
integer height = 1300
long backcolor = 12632256
string text = "Billing Addr."
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_billingaddress dw_billingaddress
end type

on tabpage_billingaddress.create
this.dw_billingaddress=create dw_billingaddress
this.Control[]={this.dw_billingaddress}
end on

on tabpage_billingaddress.destroy
destroy(this.dw_billingaddress)
end on

type dw_billingaddress from datawindow within tabpage_billingaddress
integer x = 41
integer y = 52
integer width = 1376
integer height = 648
integer taborder = 21
boolean enabled = false
string dataobject = "d_company_displayaddress"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;n_cst_dws	lnv_Dws
DataWindow	ldw_Source
DataStore	lds_Source
Long			ll_CurrentRow

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( of_GetSource ( ), ldw_Source, lds_Source )

CASE DataWindow!
	ldw_Source.ShareData ( This )

CASE DataStore!
	lds_Source.ShareData ( This )

END CHOOSE

ll_CurrentRow = of_GetCurrentRow ( )
IF ll_CurrentRow > 0 THEN
	This.ScrollToRow ( ll_CurrentRow )
END IF


//Set the flag to display billing address here
This.Modify ( "txt_disp_ind.text = 'B'" )
end event

event rowfocuschanging;//Note : This wasn't firing because there weren't any focusable columns, 
//but the arrows would scroll the row.  So, I disabled the dw instead.

//If the NewRow being set here is not the CurrentRow on the tab control, 
//notify the tab control of the change so it can synchronize other pages, etc.

IF CurrentRow = 0 OR NewRow = 0 THEN
	//DW is constucting.  Ignore.
ELSEIF of_GetCurrentRow ( ) <> NewRow THEN
	Post of_SetCurrentRow ( NewRow )
END IF
end event

type tabpage_dispatch from userobject within u_tab_companydetail
integer x = 18
integer y = 108
integer width = 2729
integer height = 1300
long backcolor = 12632256
string text = "Dispatch"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_dispatch dw_dispatch
end type

on tabpage_dispatch.create
this.dw_dispatch=create dw_dispatch
this.Control[]={this.dw_dispatch}
end on

on tabpage_dispatch.destroy
destroy(this.dw_dispatch)
end on

type dw_dispatch from u_dw_companyedit within tabpage_dispatch
integer width = 2318
integer height = 1176
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_company_dispatchdata"
end type

event constructor;call super::constructor;//Extending ancestor

n_cst_dws	lnv_Dws
DataWindow	ldw_Source
DataStore	lds_Source
Long			ll_CurrentRow

n_cst_Privileges					lnv_Privileges

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( of_GetSource ( ), ldw_Source, lds_Source )

CASE DataWindow!
	ldw_Source.ShareData ( This )

CASE DataStore!
	lds_Source.ShareData ( This )

END CHOOSE

ll_CurrentRow = of_GetCurrentRow ( )
IF ll_CurrentRow > 0 THEN
	This.ScrollToRow ( ll_CurrentRow )
END IF


IF lnv_Privileges.of_HasEntryRights( ) THEN
	//ok
ELSE
	This.Enabled = FALSE
END IF

end event

event itemerror;call super::itemerror;Long	ll_Return

ll_Return = AncestorReturnValue

IF ll_Return = 0 THEN

	messagebox("Company Information", "The value you have entered is invalid.~n~nPlease edit "+&
		"your entry, or restore the previous value by pressing escape in the edit field.")

	ll_Return = 1

END IF

RETURN ll_Return
end event

event rowfocuschanging;call super::rowfocuschanging;//If the NewRow being set here is not the CurrentRow on the tab control, 
//notify the tab control of the change so it can synchronize other pages, etc.

IF CurrentRow = 0 OR NewRow = 0 THEN
	//DW is constucting.  Ignore.
ELSEIF of_GetCurrentRow ( ) <> NewRow THEN
	Post of_SetCurrentRow ( NewRow )
END IF
end event

type tabpage_notes from userobject within u_tab_companydetail
integer x = 18
integer y = 108
integer width = 2729
integer height = 1300
long backcolor = 12632256
string text = "Notes"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_notes dw_notes
end type

on tabpage_notes.create
this.dw_notes=create dw_notes
this.Control[]={this.dw_notes}
end on

on tabpage_notes.destroy
destroy(this.dw_notes)
end on

type dw_notes from u_dw_companyedit within tabpage_notes
integer width = 2327
integer height = 1200
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_company_notes"
end type

event constructor;call super::constructor;//Extending ancestor

n_cst_dws	lnv_Dws
DataWindow	ldw_Source
DataStore	lds_Source
Long			ll_CurrentRow

n_cst_Privileges		lnv_Privileges

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( of_GetSource ( ), ldw_Source, lds_Source )

CASE DataWindow!
	ldw_Source.ShareData ( This )

CASE DataStore!
	lds_Source.ShareData ( This )

END CHOOSE


ll_CurrentRow = of_GetCurrentRow ( )
IF ll_CurrentRow > 0 THEN
	This.ScrollToRow ( ll_CurrentRow )
END IF


IF lnv_Privileges.of_HasEntryRights( ) THEN
	//ok
ELSE
	This.Enabled = FALSE
END IF

end event

event itemerror;call super::itemerror;Long	ll_Return

ll_Return = AncestorReturnValue

IF ll_Return = 0 THEN

	messagebox("Company Information", "The value you have entered is invalid.~n~nPlease edit "+&
		"your entry, or restore the previous value by pressing escape in the edit field.")

	ll_Return = 1

END IF

RETURN ll_Return
end event

event rowfocuschanging;call super::rowfocuschanging;//If the NewRow being set here is not the CurrentRow on the tab control, 
//notify the tab control of the change so it can synchronize other pages, etc.

IF CurrentRow = 0 OR NewRow = 0 THEN
	//DW is constucting.  Ignore.
ELSEIF of_GetCurrentRow ( ) <> NewRow THEN
	Post of_SetCurrentRow ( NewRow )
END IF
end event

type tabpage_settings from userobject within u_tab_companydetail
integer x = 18
integer y = 108
integer width = 2729
integer height = 1300
long backcolor = 12632256
string text = "Settings"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_settings dw_settings
sle_payablesid sle_payablesid
st_1 st_1
end type

on tabpage_settings.create
this.dw_settings=create dw_settings
this.sle_payablesid=create sle_payablesid
this.st_1=create st_1
this.Control[]={this.dw_settings,&
this.sle_payablesid,&
this.st_1}
end on

on tabpage_settings.destroy
destroy(this.dw_settings)
destroy(this.sle_payablesid)
destroy(this.st_1)
end on

type dw_settings from u_dw_companyedit within tabpage_settings
event ue_gettables ( ref string as_value )
integer width = 2368
integer height = 1196
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_company_settings"
end type

event ue_gettables;integer	li_msgcount, &
			li_ndx
			
string	lsa_list[], &
			ls_list
			
n_cst_string	lnv_string
n_cst_msg	lnv_Msg
s_parm	lstr_Parm

w_ratetablelist	lw_list

lstr_Parm.is_Label = "COMPANY"
lstr_Parm.ia_Value = this.object.co_id[this.getrow()]
lnv_Msg.of_Add_Parm (lstr_Parm)

lstr_Parm.is_Label = "TITLE"
lstr_Parm.ia_Value = this.object.co_name[this.getrow()]
lnv_Msg.of_Add_Parm (lstr_Parm)

openwithparm ( lw_list, lnv_msg )

lnv_Msg = message.powerobjectparm



end event

event constructor;call super::constructor;//Extending ancestor

n_cst_dws	lnv_Dws
DataWindow	ldw_Source
DataStore	lds_Source
Long			ll_CurrentRow
Boolean		lb_EntryRights
String	lsa_Objects[]
			
Integer	li_ObjectCount, &
			li_Index

n_cst_setting_edi204version	lnv_204Version		
n_cst_Privileges					lnv_Privileges
n_cst_presentation_shipment	lnv_presentationShipment

lnv_presentationShipment.of_setpresentation( this )

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( of_GetSource ( ), ldw_Source, lds_Source )

CASE DataWindow!
	ldw_Source.ShareData ( This )

CASE DataStore!
	lds_Source.ShareData ( This )

END CHOOSE

//lnv_204Version = CREATE n_cst_setting_edi204version
//
//IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
//	lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
//	
//	This.object.edi210code.Visible = 0
//	This.object.edi210code_t.Visible = 0
//	This.object.edi214code.Visible = 0
//	This.object.edi214code_t.Visible = 0

//ELSE
	
	This.object.edi210code.Visible = 1
	This.object.edi210code_t.Visible = 1
	This.object.edi214code.Visible = 1
	This.object.edi214code_t.Visible = 1

//END IF	

DESTROY ( lnv_204Version )

lb_EntryRights = lnv_Privileges.of_HasEntryRights ( )

IF lnv_Privileges.of_HasAdministrativeRights ( ) THEN

	//OK
	This.of_SetBase ( TRUE )
	if g_privs.l_customerhold = 0 then
		
		
		This.Modify (	"cb_placeonhold" + ".Visible = 0" )
		This.Modify (	"cb_removehold" + ".Visible = 0" )
		
//				This.Modify (	lsa_Objects [ li_Index ] + ".Visible = 0" )

	end if


ELSE

	//Protect everything except salesrep column
	This.Modify (	"cb_ratetablelist" + ".Visible = 1" )
	This.of_SetBase ( TRUE )
	
	li_ObjectCount = This.inv_Base.of_GetObjects ( lsa_Objects )
	
	FOR li_Index = 1 TO li_ObjectCount
	
		CHOOSE CASE This.Describe ( lsa_Objects [ li_Index ] + ".type" )

		CASE "column"
			
			IF upper(This.Describe ( lsa_Objects [ li_Index ] + ".name" )) = "SALESREP" AND lb_EntryRights then
				//don't protect
			else
				This.Modify ( 	lsa_Objects [ li_Index ] + ".TabSequence = 0 "+&
									lsa_Objects [ li_Index ] + ".Background.Color = " + cs_Color_Disabled )
			end if
			
		CASE "button"
			IF upper(This.Describe ( lsa_Objects [ li_Index ] + ".name" )) <> "cb_ratetablelist" THEN
				if g_privs.l_customerhold = 0 then
					This.Modify (	lsa_Objects [ li_Index ] + ".Visible = 0" )
				end if
			END IF
			
		END CHOOSE

	NEXT

//	This.Enabled = FALSE

END IF

ll_CurrentRow = of_GetCurrentRow ( )
IF ll_CurrentRow > 0 THEN
	This.ScrollToRow ( ll_CurrentRow )
END IF
end event

event itemerror;call super::itemerror;Long	ll_Return

ll_Return = AncestorReturnValue

IF ll_Return = 0 THEN

	messagebox("Company Information", "The value you have entered is invalid.~n~nPlease edit "+&
		"your entry, or restore the previous value by pressing escape in the edit field.")

	ll_Return = 1

END IF

RETURN ll_Return
end event

event buttonclicked;String	ls_NewStatus
String	ls_MessageHeader = "Change Hold Status"
String	ls_list

n_cst_Privileges	lnv_Privileges
n_cst_bso_rating	lnv_Rating

CHOOSE CASE Lower ( dwo.Name )

CASE Lower ( "cb_PlaceOnHold" )
	ls_NewStatus = "H"

CASE Lower ( "cb_RemoveHold" )
	ls_NewStatus = "K"

CASE Lower ( "cb_ratetablelist" )
	this.event ue_gettables(ls_list)
		
END CHOOSE

IF ls_NewStatus <> "" AND Row > 0 THEN
	IF This.Object.co_status [ Row ] = "D" THEN
		MessageBox ( ls_MessageHeader, "Cannot change hold status for a deactivated company.~n~n"+&
			"Request cancelled." )
	ELSE
		This.Object.co_status [ Row ] = ls_NewStatus
	END IF
END IF
end event

event rowfocuschanging;call super::rowfocuschanging;//If the NewRow being set here is not the CurrentRow on the tab control, 
//notify the tab control of the change so it can synchronize other pages, etc.

IF CurrentRow = 0 OR NewRow = 0 THEN
	//DW is constucting, or there's nothing to focus on.  Ignore.
ELSEIF of_GetCurrentRow ( ) <> NewRow THEN
	Post of_SetCurrentRow ( NewRow )
END IF
end event

type sle_payablesid from singlelineedit within tabpage_settings
integer x = 1618
integer y = 772
integer width = 709
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
textcase textcase = upper!
integer accelerator = 121
borderstyle borderstyle = stylelowered!
end type

event constructor;n_cst_privileges	lnv_privileges

IF lnv_Privileges.of_HasAdministrativeRights ( ) THEN

	//OK

ELSE

	//Protect payablesid
	this.enabled=false
	//this.backcolor = n_cst_Constants.cl_Color_Protected
	

END IF

end event

type st_1 from statictext within tabpage_settings
integer x = 1056
integer y = 772
integer width = 549
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Accounting Id: (AP)"
alignment alignment = right!
boolean focusrectangle = false
end type

type tabpage_imaging from userobject within u_tab_companydetail
event ue_setnewrequired ( )
event ue_setnewwarning ( )
event ue_setnewprinting ( )
event ue_populatesettings ( )
integer x = 18
integer y = 108
integer width = 2729
integer height = 1300
long backcolor = 12632256
string text = "Imaging"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
uo_imaging uo_imaging
end type

event ue_setnewrequired;String	ls_Types
Long		ll_CurrentRow

powerObject	lpo_Source
n_cst_dws	lnv_Dws

ll_CurrentRow = of_GetCurrentRow ( )
ls_Types = uo_imaging.of_GetRequiredTypes ( )


lpo_Source = of_GetSource ( )

IF IsValid (lpo_Source ) AND ll_CurrentRow > 0 THEN
	lnv_dws.of_SetItem ( lpo_Source , ll_CurrentRow ,"requiredimagetypes" , ls_Types )
ELSE
	MessageBox ( "Image Settings" , "An error occurred while attempting to record the new settings.")
END IF
end event

event ue_setnewwarning;String	ls_Types
Long		ll_CurrentRow

powerObject	lpo_Source
n_cst_dws	lnv_Dws

ll_CurrentRow = of_GetCurrentRow ( )
ls_Types = uo_imaging.of_GetWarningTypes ( )

lpo_Source = of_GetSource ( )

IF IsValid (lpo_Source ) AND ll_CurrentRow > 0 THEN
	lnv_dws.of_SetItem ( lpo_Source , ll_CurrentRow ,"warningimagetypes" , ls_Types )
ELSE
	MessageBox ( "Image Settings" , "An error occurred while attempting to record the new settings.")
END IF
end event

event ue_setnewprinting;String	ls_Types
Long		ll_CurrentRow

powerObject	lpo_Source
n_cst_dws	lnv_Dws

ll_CurrentRow = of_GetCurrentRow ( )
ls_Types = uo_imaging.of_GetPrintTypes ( )

lpo_Source = of_GetSource ( )

IF IsValid (lpo_Source ) AND ll_CurrentRow > 0 THEN
	lnv_dws.of_SetItem ( lpo_Source , ll_CurrentRow ,"printingimagetypes" , ls_Types )
ELSE
	MessageBox ( "Image Settings" , "An error occurred while attempting to record the new settings.")
END IF
end event

event ue_populatesettings();//THIS.dw_Images.Event post ue_PopulateSettings ( )
long	ll_Row
String	lsa_Required[]
String	lsa_Warning[]
String	lsa_Printing[]

PowerObject	lpo_Source

n_cst_beo_Company	lnv_Company
n_cst_settings	lnv_Settings

lnv_Company =  CREATE n_cst_beo_Company

lpo_source = of_GetSource ( )
ll_row = of_GetCurrentrow ( )

IF ll_Row > 0 AND isValid ( lpo_Source ) THEN
	
	lnv_company.of_SetSource ( lpo_Source )
	lnv_Company.of_SetSourceRow ( ll_Row )
	
	IF lnv_Company.of_HasSource ()  THEN
		
		IF lnv_Company.of_OverrideRequiredImageTypes ( ) THEN
			uo_imaging.of_SetOverrideRequired ( TRUE )
			lnv_Company.of_GetRequiredImageTypes ( lsa_Required )
			uo_imaging.Post of_SetRequiredTypes ( lsa_Required )
		ELSE
			uo_imaging.of_SetOverrideRequired ( FALSE )
		//	lnv_Settings.of_GetRequiredImageTypes ( lsa_Required )
		END IF
		
		IF lnv_Company.of_OverrideWarningImageTypes ( ) THEN
			uo_imaging.of_SetOverrideWarning ( TRUE )
			lnv_Company.of_GetWarningImageTypes ( lsa_Warning )
			uo_imaging.Post of_SetWarningtypes ( lsa_Warning )
		ELSE
			uo_imaging.of_SetOverrideWarning ( FALSE )
		//	lnv_Settings.of_GetWarningImageTypes ( lsa_Warning )
		END IF
		
		IF lnv_Company.of_OverridePrintingImageTypes ( ) THEN
			uo_imaging.of_SetOverridePrinting ( TRUE )
			lnv_Company.of_GetPrintingImageTypes ( lsa_Printing ) 
			uo_imaging.Post of_SetPrintingTypes ( lsa_Printing )
		ELSE
			uo_imaging.of_SetOverridePrinting ( FALSE )
		//	lnv_Settings.of_GetPrintingImageTypes ( lsa_Printing )
			
		END IF
		
	END IF
	
END IF


DESTROY lnv_Company



	


end event

on tabpage_imaging.create
this.uo_imaging=create uo_imaging
this.Control[]={this.uo_imaging}
end on

on tabpage_imaging.destroy
destroy(this.uo_imaging)
end on

event constructor;THIS.Event POST ue_PopulateSettings ( )

n_cst_privileges	lnv_Privs

uo_imaging.of_SetEnabled ( lnv_Privs.of_HasAdministrativeRights ( ) )


uo_imaging.of_ResetUpdate( )




end event

type uo_imaging from u_cst_imagesettings within tabpage_imaging
event destroy ( )
integer width = 2400
integer height = 1168
integer taborder = 31
boolean bringtotop = true
end type

on uo_imaging.destroy
call u_cst_imagesettings::destroy
end on

event ue_printtypeschanged;PARENT.Post Event ue_SetnewPrinting ( )
end event

event ue_requiredtypeschanged;PARENT.Post Event ue_SetnewRequired ( )
end event

event ue_warningtypeschanged;PARENT.Post Event ue_SetnewWarning ( )
end event

event ue_setoverrideprinttypes;//IF ab_Value = FALSE THEN
	THIS.Post Event ue_PrintTypesChanged ( ) 
//END IF
RETURN 1
end event

event ue_setoverridewarningtypes;THIS.Post Event ue_WarningTypesChanged ( ) 

RETURN 1
end event

event ue_setoverriderequiredtypes;THIS.Post Event ue_RequiredTypesChanged ( )

RETURN 1
end event

type tabpage_contacts from u_cst_tabpg_company_notification within u_tab_companydetail
event ue_populateattachments ( )
integer x = 18
integer y = 108
integer width = 2729
integer height = 1300
long backcolor = 12632256
string text = "Contacts"
long tabbackcolor = 12632256
end type

event ue_populateattachments;long	ll_Row
String	lsa_Attach[]

PowerObject	lpo_Source

n_cst_beo_Company	lnv_Company


lnv_Company =  CREATE n_cst_beo_Company

lpo_source = of_GetSource ( )
ll_row = of_GetCurrentrow ( )

IF ll_Row > 0 AND isValid ( lpo_Source ) THEN
	
	lnv_company.of_SetSource ( lpo_Source )
	lnv_Company.of_SetSourceRow ( ll_Row )
	
	IF lnv_Company.of_HasSource ()  THEN
		lnv_Company.of_GetAttachImageTypes ( lsa_Attach )
		THIS.of_SetAttachimageTypes ( lsa_Attach )
	END IF
	
END IF

DESTROY ( lnv_Company )
end event

event constructor;call super::constructor;// RDT 5-13-03 added of_seteventdist and of_seteventorig
long	ll_Row
PowerObject	lpo_Source

n_cst_beo_Company	lnv_Company

lnv_Company =  CREATE n_cst_beo_Company

lpo_source = of_GetSource ( )
ll_row = of_GetCurrentrow ( )

IF ll_Row > 0 AND isValid ( lpo_Source ) THEN
	
	lnv_company.of_SetSource ( lpo_Source )
	lnv_Company.of_SetSourceRow ( ll_Row )
	
	IF lnv_Company.of_HasSource ()  THEN
		THIS.of_Populate ( lnv_Company.of_GetID ( ) )
		THIS.of_SetRole ( lnv_Company.of_GetRequiredRequestRole ( ) )
		THIS.of_SetTemplate ( lnv_Company.of_GetStatusRequesttemplate ( ) )
		THIS.of_SetEventDest( lnv_Company.of_GetNotificationEventDestination ( ) )
		THIS.of_SetEventOrig( lnv_Company.of_GetNotificationEventOrigin ( )	)	
		THIS.Post Event ue_PopulateAttachments ( )
	END IF
	
END IF

DESTROY ( lnv_Company )



end event

event ue_rolechanged;Long		ll_CurrentRow

powerObject	lpo_Source
n_cst_dws	lnv_Dws

ll_CurrentRow = of_GetCurrentRow ( )

lpo_Source = of_GetSource ( )

IF IsValid (lpo_Source ) AND ll_CurrentRow > 0 THEN
	lnv_dws.of_SetItem ( lpo_Source , ll_CurrentRow ,"statusrequestrole" , as_role )
//ELSE
//	MessageBox ( "Image Settings" , "An error occurred while attempting to record the new settings.")
END IF

RETURN 1
end event

event ue_templatechanged;Long		ll_CurrentRow

powerObject	lpo_Source
n_cst_dws	lnv_Dws

ll_CurrentRow = of_GetCurrentRow ( )

lpo_Source = of_GetSource ( )

IF IsValid (lpo_Source ) AND ll_CurrentRow > 0 THEN
	lnv_dws.of_SetItem ( lpo_Source , ll_CurrentRow ,"statusrequesttemplate" , as_template )
END IF

RETURN 1
end event

event ue_attachmentchanged;String	ls_Types
Long		ll_CurrentRow

powerObject	lpo_Source
n_cst_dws	lnv_Dws

ll_CurrentRow = of_GetCurrentRow ( )
ls_Types = THIS.of_GetAttachmentTypes ( )

lpo_Source = of_GetSource ( )

IF IsValid (lpo_Source ) AND ll_CurrentRow > 0 THEN
	lnv_dws.of_SetItem ( lpo_Source , ll_CurrentRow ,"attachimagetypes" , ls_Types )
ELSE
	MessageBox ( "Image Settings" , "An error occurred while attempting to record the new settings.")
END IF

end event

event ue_getcompany;RETURN Parent.Event ue_GetCompany ( )
end event

event ue_eventdestchanged;// RDT 5-13-03 All New Code
Long		ll_CurrentRow

powerObject	lpo_Source
n_cst_dws	lnv_Dws

ll_CurrentRow = of_GetCurrentRow ( )

lpo_Source = of_GetSource ( )

IF IsValid (lpo_Source ) AND ll_CurrentRow > 0 THEN
	if as_value = "none" Then
		Setnull(as_value)
	end if
	lnv_dws.of_SetItem ( lpo_Source , ll_CurrentRow ,"notificationeventdestination" , as_value )
END IF

RETURN 1
end event

event ue_eventorigchanged;// RDT 5-13-03 All New Code
Long		ll_CurrentRow

powerObject	lpo_Source
n_cst_dws	lnv_Dws

ll_CurrentRow = of_GetCurrentRow ( )

lpo_Source = of_GetSource ( )

IF IsValid (lpo_Source ) AND ll_CurrentRow > 0 THEN
	if as_value = "none" Then
		Setnull(as_value)
	end if
	lnv_dws.of_SetItem ( lpo_Source , ll_CurrentRow ,"notificationeventorigin" , as_value )
END IF

RETURN 1
end event

type tabpage_custom_a from userobject within u_tab_companydetail
integer x = 18
integer y = 108
integer width = 2729
integer height = 1300
long backcolor = 12632256
string text = "Custom A"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_custom_a dw_custom_a
end type

on tabpage_custom_a.create
this.dw_custom_a=create dw_custom_a
this.Control[]={this.dw_custom_a}
end on

on tabpage_custom_a.destroy
destroy(this.dw_custom_a)
end on

type dw_custom_a from u_dw_companyedit within tabpage_custom_a
integer width = 2327
integer height = 1200
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_company_custom_a"
end type

event constructor;call super::constructor;//Extending ancestor

n_cst_dws	lnv_Dws
DataWindow	ldw_Source
DataStore	lds_Source
Long			ll_CurrentRow

n_cst_Presentation_Company	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

n_cst_Privileges					lnv_Privileges

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( of_GetSource ( ), ldw_Source, lds_Source )

CASE DataWindow!
	ldw_Source.ShareData ( This )

CASE DataStore!
	lds_Source.ShareData ( This )

END CHOOSE


ll_CurrentRow = of_GetCurrentRow ( )
IF ll_CurrentRow > 0 THEN
	This.ScrollToRow ( ll_CurrentRow )
END IF


IF lnv_Privileges.of_HasEntryRights( ) THEN
	//ok
ELSE
	This.Enabled = FALSE
END IF
end event

event itemerror;call super::itemerror;Long	ll_Return

ll_Return = AncestorReturnValue

IF ll_Return = 0 THEN

	messagebox("Company Information", "The value you have entered is invalid.~n~nPlease edit "+&
		"your entry, or restore the previous value by pressing escape in the edit field.")

	ll_Return = 1

END IF

RETURN ll_Return
end event

event rowfocuschanging;call super::rowfocuschanging;//If the NewRow being set here is not the CurrentRow on the tab control, 
//notify the tab control of the change so it can synchronize other pages, etc.

IF CurrentRow = 0 OR NewRow = 0 THEN
	//DW is constucting.  Ignore.
ELSEIF of_GetCurrentRow ( ) <> NewRow THEN
	Post of_SetCurrentRow ( NewRow )
END IF
end event

type tabpage_custom_b from userobject within u_tab_companydetail
integer x = 18
integer y = 108
integer width = 2729
integer height = 1300
long backcolor = 12632256
string text = "Custom B"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_custom_b dw_custom_b
end type

on tabpage_custom_b.create
this.dw_custom_b=create dw_custom_b
this.Control[]={this.dw_custom_b}
end on

on tabpage_custom_b.destroy
destroy(this.dw_custom_b)
end on

type dw_custom_b from u_dw_companyedit within tabpage_custom_b
integer width = 2327
integer height = 1200
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_company_custom_b"
end type

event constructor;call super::constructor;//Extending ancestor

n_cst_dws	lnv_Dws
DataWindow	ldw_Source
DataStore	lds_Source
Long			ll_CurrentRow

n_cst_Presentation_Company	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

n_cst_Privileges	lnv_Privileges

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( of_GetSource ( ), ldw_Source, lds_Source )

CASE DataWindow!
	ldw_Source.ShareData ( This )

CASE DataStore!
	lds_Source.ShareData ( This )

END CHOOSE


ll_CurrentRow = of_GetCurrentRow ( )
IF ll_CurrentRow > 0 THEN
	This.ScrollToRow ( ll_CurrentRow )
END IF

IF lnv_Privileges.of_HasEntryRights( ) THEN
	//ok
ELSE
	This.Enabled = FALSE
END IF
end event

event itemerror;call super::itemerror;Long	ll_Return

ll_Return = AncestorReturnValue

IF ll_Return = 0 THEN

	messagebox("Company Information", "The value you have entered is invalid.~n~nPlease edit "+&
		"your entry, or restore the previous value by pressing escape in the edit field.")

	ll_Return = 1

END IF

RETURN ll_Return
end event

event rowfocuschanging;call super::rowfocuschanging;//If the NewRow being set here is not the CurrentRow on the tab control, 
//notify the tab control of the change so it can synchronize other pages, etc.

IF CurrentRow = 0 OR NewRow = 0 THEN
	//DW is constucting.  Ignore.
ELSEIF of_GetCurrentRow ( ) <> NewRow THEN
	Post of_SetCurrentRow ( NewRow )
END IF
end event

