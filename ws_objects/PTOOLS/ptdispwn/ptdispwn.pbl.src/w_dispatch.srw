$PBExportHeader$w_dispatch.srw
forward
global type w_dispatch from w_sheet
end type
end forward

global type w_dispatch from w_sheet
integer x = 0
integer y = 276
integer width = 4539
integer height = 2400
string title = "Dispatch"
long backcolor = 12632256
event ue_sendoutboundmessage ( n_cst_msg anv_msg )
event ue_sendfreeformmessage ( n_cst_msg anv_msg )
event type integer ue_processinterchange ( long al_eventid )
event ue_splitfront ( )
event ue_splitback ( )
event ue_splitboth ( )
event ue_displayshipment pbm_custom01
end type
global w_dispatch w_dispatch

type variables
protected:
s_eq_info find_eqs
s_emp_info find_ems

public:
datastore ds_ships, ds_ships_a, ds_items, ds_items_a, &
	ds_events, ds_emp, ds_equip, ds_retlist, ids_OpenShips
boolean winisclosing
string evsel_base
w_itin itinwin
w_ship shipwin
n_cst_ratedata	inva_ratedata[]

Private:
n_cst_bso_Dispatch	inv_Dispatch

m_sheets		im_ShipmentMenu
m_dispwin	im_ItineraryMenu

n_cst_AlertManager	inv_AlertManager





end variables

forward prototypes
public function integer retr_itin (integer new_type, long new_id, date start_date, date end_date, boolean needs_prior)
public function string itin_sort (integer seq_type, long seq_id)
public function long getid (integer id_type, datastore ds_source, long source_row, dwbuffer source_buffer, boolean original_value)
public subroutine save_request ()
public function integer retr_ship (long retrid)
public subroutine setrefs ()
public function integer save ()
public subroutine wf_set_toolmenu (string as_type)
public function integer wf_reset_times (long al_start_row, string as_context)
public function integer wf_get_miles (long al_start_row, long al_end_row, ref decimal ac_miles)
public function integer wf_quickprint_delrecs (long ala_ids[])
public function n_cst_bso_dispatch wf_getdispatchmanager ()
public function integer merge_events (datastore ads_source)
public function long wf_getselectedevents (ref n_cst_beo_event anva_events[])
public function integer wf_setshares ()
public function string wf_getitinfilter (integer seq_type, long seq_id, date ad_min, date ad_max)
public function n_cst_AlertManager wf_getalertmanager ()
public subroutine wf_restoresize ()
public function long wf_getreportcontexts (ref string asa_contexts[])
public function integer wf_retrieveopenshipment (long al_shipid)
public function integer wf_removeopenshipment (long al_shipid)
public function boolean wf_isshipmentopen (long al_shipid, ref long al_handle)
public function integer wf_recordopenshipment (long al_shipid)
public function integer wf_removeopenshipmentswithcurrenthandle (long al_shipid, long al_excludeid)
public function integer wf_removeopenshipmentswithcurrenthandle (long al_shipid)
public function integer wf_alertremoteopenshipment (long al_shipid)
public function integer wf_displayshipment (long al_shipid, boolean ab_firstopen)
public function boolean wf_isshipmentmodified ()
end prototypes

event ue_sendoutboundmessage(n_cst_msg anv_msg);//////////////////////////////////////////////////////////////////////////////
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
//						Cache the selected event beos and pass to w_communication_outbound.
//						w_communication_outbound will round up the destination,
//						deviceand template and launch the communication manager.
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


String		ls_ErrorMessage
String		lsa_Topic[]
String		ls_Folder
String		ls_Topic
Boolean		lb_FoundWindow = FALSE
Int		i
Long		ll_IDCount
Long		lla_EventIDs[]
Long		ll_MaxCount = 1
Long		ll_SiteID
Long		ll_DriverID
Long		ll_TractorID, &
			ll_arraycount, &
			ll_count

Boolean	lb_UseCurrent = FALSE
boolean	lb_Continue = TRUE

s_beoArrays	lstr_Beos
n_cst_Msg	lnv_Msg
s_parm		lstr_Parm
w_templateSelection lw_DataSelection

n_cst_Beo_Event	lnva_Events[]
//n_cst_Beo_Event	lnv_Event
n_cst_beo_Company		lnva_CompanyBeo[]

long	ll_Devicecount 
String	lsa_DeviceList[]
//Boolean lb_OpenDlg = TRUE
String	ls_Device
	
n_cst_bso_Communication_Manager lnv_Communication

lnv_Communication = CREATE    n_cst_bso_Communication_Manager

IF isValid(anv_Msg) THEN
	lnv_Msg = anv_Msg
END IF

//
//IF IsValid ( lnv_Communication ) THEN
//	ll_DeviceCount = lnv_Communication.of_GetLicensedDevices ( lsa_DeviceList ) 
//	IF ll_DeviceCount > 0 AND UpperBound (lsa_DeviceList) > 0 THEN
//		ls_Device = lsa_DeviceList[1]
//	END IF
//END IF

//IF ll_DeviceCount > 0
		
ll_IDCount = THIS.wf_GEtSelectedEvents ( lnva_Events )
IF ll_IdCount = 0 THEN
	ls_ErrorMessage =  "Please select at least one (1) event as the source of the message."
	lb_Continue = FALSE
END IF

IF ll_IDCount > 0  AND lb_Continue THEN
										
	// the upper bound should always be > 0 since the max count is required to be > 0
	ll_SiteID = lnva_Events[1].of_GetSite ( )
	
	lnva_CompanyBeo[1] = CREATE n_cst_beo_Company
	
	gnv_cst_Companies.of_Cache ( ll_SiteID , TRUE )
	lnva_CompanyBeo[1].of_SetUseCache ( TRUE )
	lnva_CompanyBeo[1].of_SetSourceId ( ll_SiteID )
					
//	FOR i = 1 TO ll_IDCount
//		IF NOT (lnva_Events[i].of_IsPickupGroup( ) OR lnva_Events[i].of_IsDeliverGroup( ) ) THEN
//			lb_Continue = FALSE
//			ls_ErrorMessage = "Please limit your selections to either pickups or deliveries."
//			EXIT
//		END IF
//	NEXT

	// add driver id
	lstr_Parm.is_Label = "EMPLOYEEID"
	IF UpperBound (  lnva_Events ) > 0 THEN
		ll_DriverID = lnva_Events[1].of_GetDriverID ( )
		IF IsNull (ll_DriverID) THEN
			ll_DriverID = 0
		END IF				
	END IF
	lstr_Parm.ia_Value = ll_DriverID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	
	// Add equip id
	lstr_Parm.is_Label = "EQUIPMENTID"
	IF UpperBound (  lnva_Events ) > 0 THEN 
		ll_TractorID = lnva_Events[1].of_getTractorid ( )
		IF isNull ( ll_TractorID ) THEN
			ll_TractorID = 0 
		END IF		
	END IF
	lstr_Parm.ia_Value = ll_TractorID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	
	
//	lstr_Parm.is_Label = "DEVICE"
//	lstr_Parm.ia_Value = n_cst_Constants.cs_communicationDevice_qualcomm
//	lnv_Msg.of_Add_Parm (lstr_Parm )
//	
	lstr_Parm.is_Label = "TEMPLATEPATH"
	lstr_Parm.ia_Value = ls_FOLDER
	lnv_Msg.of_Add_Parm (lstr_Parm)
	
	lstr_Parm.is_Label = "NUMEVENTS"
	lstr_Parm.ia_Value = ll_IDCount
	lnv_Msg.of_Add_Parm (lstr_Parm)
	
	lstr_Beos.inva_Events = lnva_Events
	lstr_Beos.inva_Companies = lnva_CompanyBeo
	
	lstr_Parm.is_Label = "BEOS"
	lstr_Parm.ia_Value = lstr_Beos
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	
ELSEIF ll_IDCount = -1 THEN
	ls_ErrorMessage = "An error occurred while attempting to access the selected event(s). Please contact Profit Tools."
	lb_continue = FALSE	
//ELSEIF ll_IDCount > 2 THEN
//	ls_ErrorMessage = "Please limit your selection to at most 2 (two) events." 
//	lb_Continue = FALSE
ELSE
	lb_Continue = FALSE
END IF

IF Len ( ls_ErrorMessage ) > 0 AND Not lb_Continue THEN
	MessageBox ( "Outbound Message" ,ls_ErrorMessage ) 					
END IF
		
IF lb_Continue THEN
	openWithParm  ( w_communication_outbound, lnv_Msg )	
END IF
	
ll_arraycount = upperbound(lnva_Events)

for ll_count = 1 to ll_arraycount
	if isvalid(lnva_events[ll_count].inv_shipment) then
		destroy lnva_events[ll_count].inv_shipment
	end if
	if isvalid(lnva_events[ll_count]) then
		destroy lnva_events[ll_count]
	end if
next

DESTROY lnva_CompanyBeo[1]	
end event

event ue_sendfreeformmessage(n_cst_msg anv_msg);Integer 	li_Return
any		la_Path
String 	ls_FilePath
Long		ll_EquipmentID
Long		ll_EmployeeID
long		ll_Devicecount, &
			ll_arraycount, &
			ll_count
String	lsa_DeviceList[]
//Boolean lb_OpenDlg = FALSE
String	ls_Device

n_cst_bso_Communication_Manager lnv_Communication

lnv_Communication = CREATE    n_cst_bso_Communication_Manager
	
SetNull ( ll_EquipmentID )
SetNull ( ll_EmployeeID )

n_cst_settings lnv_Settings
n_cst_msg	lnv_msg
S_Parm		lstr_Parm
li_Return = 1
n_cst_beo_Event	lnva_Events[]

IF isValid(anv_Msg) THEN
	lnv_Msg = anv_Msg
END IF

IF isValid ( itinwin ) THEN
	IF itinwin.visible = TRUE THEN
		itinwin.wf_GetSelectedEvents ( lnva_Events )
	END IF
END IF		

IF isValid ( shipwin ) THEN
	IF shipwin.visible = TRUE THEN
		shipwin.wf_GetSelectedEvents ( lnva_Events )
	END IF
END IF	

ll_arraycount = upperbound(lnva_Events)

IF ll_arraycount > 0 THEN
	ll_EmployeeID = lnva_Events[1].of_GetDriverID ( )
	ll_EquipmentID = lnva_Events[1].of_getTractorid ( ) 

	for ll_count = 1 to ll_arraycount
		if isvalid(lnva_events[ll_count].inv_shipment) then
			destroy lnva_events[ll_count].inv_shipment
		end if
		if isvalid(lnva_events[ll_count]) then
			destroy lnva_events[ll_count]
		end if
	next
END IF

n_cst_setting_templatespathfolder	lnv_PathSetting
lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
ls_FilePath = lnv_PathSetting.of_Getvalue( )
DESTROY ( lnv_PathSetting )

IF Len ( ls_FilePath ) = 0 THEN
	li_Return = -1 
END IF
	

IF IsValid ( lnv_Communication ) THEN
	ll_DeviceCount = lnv_Communication.of_GetLicensedDevices ( lsa_DeviceList )
	IF ll_DeviceCount > 0 AND UpperBound (lsa_DeviceList) > 0 THEN
		ls_Device = lsa_DeviceList[1]
	END IF
END IF

IF ll_DeviceCount > 0 THEN
	lstr_Parm.is_label = "DEVICE"
	lstr_Parm.ia_Value = ls_Device
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_label = "FREEFORM"
	lstr_Parm.ia_Value = TRUE
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_label = "TEMPLATEPATH"
	lstr_Parm.ia_Value = ls_FilePath
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "EMPLOYEEID"
	lstr_Parm.ia_Value = ll_EmployeeID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "EQUIPMENTID"
	lstr_Parm.ia_Value = ll_EquipmentID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	openWithParm ( w_communication_outbound, lnv_Msg )

ELSE
	MessageBox ("Free Form Message" , "There are no communication devices available." )
END IF
end event

event ue_processinterchange;//Processes request to use a particular event as the origination / termination
//for equipment being associated / dissociated by the event.

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_Privileges		lnv_Privileges
n_cst_OFRError			lnva_Errors[]

String	ls_ErrorMessage = "Could not set origination / termination information.", &
			ls_MessageHeader = "Set Origination / Termination"

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF lnv_Privileges.of_HasEntryRights ( ) THEN

		//OK

	ELSE

		ls_ErrorMessage = lnv_Privileges.of_GetRestrictMessage ( )
		li_Return = -1

	END IF

END IF


IF li_Return = 1 THEN

	lnv_Dispatch = This.wf_GetDispatchManager ( )

	IF NOT IsValid ( lnv_Dispatch ) THEN

		ls_ErrorMessage += "~n(Invalid dispatch object.)"
		li_Return = -1

	END IF

END IF


IF li_Return = 1 THEN

	lnv_Dispatch.ClearOFRErrors ( )

	CHOOSE CASE lnv_Dispatch.of_ProcessInterchange ( al_EventId, TRUE )

	CASE 1

		//OK

	CASE -1

		IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN

			ls_ErrorMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
			li_Return = -1

		END IF

	CASE ELSE

		ls_ErrorMessage += "~n(Unexpected return error.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	MessageBox ( ls_MessageHeader, "Processing completed.  You must save "+&
		"in order for any changes to take effect." )

ELSE

	MessageBox ( ls_MessageHeader, ls_ErrorMessage, Exclamation! )

END IF

RETURN li_Return
end event

event ue_splitfront;IF isValid ( shipwin ) THEN
	shipwin.TriggerEvent ( "ue_SplitFront" , 0 , Message.LongParm )
END IF

IF isValid ( itinwin ) THEN
	itinwin.TriggerEvent ( "ue_SplitFront" , 0 , Message.LongParm )
END IF
end event

event ue_splitback;IF isValid ( shipwin ) THEN
	shipwin.TriggerEvent ( "ue_Splitback" , 0 , Message.LongParm )	
END IF

IF isValid ( itinwin ) THEN
	itinwin.TriggerEvent ( "ue_Splitback" , 0 , Message.LongParm )
END IF
end event

event ue_splitboth;IF isValid ( shipwin ) THEN
	shipwin.TriggerEvent ( "ue_Splitboth" , 0 , Message.LongParm )
END IF

IF isValid ( itinwin ) THEN
	itinwin.TriggerEvent ( "ue_Splitboth" , 0 , Message.LongParm )
END IF
end event

event ue_displayshipment;Return This.wf_DisplayShipment(lparam, false)
end event

public function integer retr_itin (integer new_type, long new_id, date start_date, date end_date, boolean needs_prior);//Returns:  1 = Success, -1 = Error, -2 = Original value conflict

//For legacy compatibility.  Forward the request to the Dispatch object.

n_cst_bso_Dispatch	lnv_Dispatch
Integer	li_Return = -1

lnv_Dispatch = This.wf_GetDispatchManager ( )

IF IsValid ( lnv_Dispatch ) THEN

	li_Return = lnv_Dispatch.of_RetrieveItinerary ( new_type, new_id, start_date, end_date, needs_prior )

END IF

RETURN li_Return
end function

public function string itin_sort (integer seq_type, long seq_id);//For legacy compatibility.  Forward the request to the Dispatch object.

n_cst_bso_Dispatch	lnv_Dispatch
String	ls_Sort

lnv_Dispatch = This.wf_GetDispatchManager ( )

IF IsValid ( lnv_Dispatch ) THEN

	ls_Sort = lnv_Dispatch.of_GetItinerarySort ( seq_type, seq_id )

ELSE
	SetNull ( ls_Sort )

END IF

RETURN ls_Sort
end function

public function long getid (integer id_type, datastore ds_source, long source_row, dwbuffer source_buffer, boolean original_value);Long	ll_Id = -1

if isvalid(ds_source) then

	choose case id_type

	case 1
		ll_Id = ds_source.getitemnumber(source_row, "de_driver", source_buffer, original_value)

	case 2
		ll_Id = ds_source.getitemnumber(source_row, "de_tractor", source_buffer, original_value)

	case 3
		ll_Id = ds_source.getitemnumber(source_row, "de_trailer1", source_buffer, original_value)

	case 4
		ll_Id = ds_source.getitemnumber(source_row, "de_trailer2", source_buffer, original_value)

	case 5
		ll_Id = ds_source.getitemnumber(source_row, "de_trailer3", source_buffer, original_value)

	case 6
		ll_Id = ds_source.getitemnumber(source_row, "de_container1", source_buffer, original_value)

	case 7
		ll_Id = ds_source.getitemnumber(source_row, "de_container2", source_buffer, original_value)

	case 8
		ll_Id = ds_source.getitemnumber(source_row, "de_container3", source_buffer, original_value)

	case 9
		ll_Id = ds_source.getitemnumber(source_row, "de_container4", source_buffer, original_value)

	case 10
		ll_Id = ds_source.getitemnumber(source_row, "de_acteq", source_buffer, original_value)

	case gc_Dispatch.ci_Assignment_Trip
		ll_Id = ds_Source.GetItemNumber ( source_row, gc_Dispatch.cs_Column_Trip, source_buffer, original_value )

	end choose

end if

RETURN ll_Id
end function

public subroutine save_request ();integer	li_return = 1

n_cst_bso_Dispatch	lnv_Dispatch
Boolean	lb_AttemptUpdate = FALSE

Long	ll_ShipId


IF isValid ( shipwin ) THEN
	IF Shipwin.Visible THEN
		IF shipwin.wf_AcceptText (FALSE) <> 1 THEN
			lb_AttemptUpdate = FALSE
			li_return = -1
		END IF
	END IF
	
END IF


//Get a handle to the dispatch manager.
lnv_Dispatch = This.wf_GetDispatchManager ( )


//Check whether there are any updates pending on the dispatch manager.

if li_return = 1 then
	IF IsValid ( lnv_Dispatch ) THEN
	
		IF lnv_Dispatch.Event pt_UpdatesPending ( ) = 1 THEN
	
			lb_AttemptUpdate = TRUE
	
		END IF
	
	END IF
end if

//If an update is pending, check with the shipment window whether the data is valid
//for the current shipment status  (note: this should be moved into the dispatch manager.)

IF lb_AttemptUpdate THEN

	if isvalid(shipwin) then
		if shipwin.visible then
			if not shipwin.wf_status_check("SAVE!") = 1 then
				lb_AttemptUpdate = FALSE
			end if
		end if
	end if

END IF


//If we're still supposed to attempt an update, go ahead.

IF lb_AttemptUpdate THEN

	IF This.Save ( ) = 1 THEN
		//Success
		IF isValid(shipwin) THEN
			ll_ShipId = shipwin.wf_GetShipmentId()
			IF shipwin.visible THEN //if shipment is visible, do not remove the current open shipment
				wf_RemoveopenShipmentsWithCurrentHandle(ll_ShipId, ll_ShipId)
			ELSE
				wf_RemoveopenShipmentsWithCurrentHandle(ll_ShipId)
			END IF
		END IF
	ELSE	
		messagebox("Dispatch Window", "Could not save changes to database.~n~nPlease retry.", &
			exclamation!)
	END IF

END IF
end subroutine

public function integer retr_ship (long retrid);//Returns : 1 = Success (either was retrieved or was already cached), 
//				0 = Shipment has been deleted, -1 = Failure, -2 = Original Value Conflict

//For legacy compatibility.  Forward the request to the Dispatch object.

n_cst_bso_Dispatch	lnv_Dispatch
Integer	li_Return = -1

lnv_Dispatch = This.wf_GetDispatchManager ( )

IF IsValid ( lnv_Dispatch ) THEN

	li_Return = lnv_Dispatch.of_RetrieveShipment ( retrid )

END IF

RETURN li_Return
end function

public subroutine setrefs ();integer evrows
evrows = ds_events.rowcount()
if evrows < 1 then return

integer checkloop, markloop, displen, prevlen
long dispid, previd[3], ev_id

string disptype, dispref, prevtype[2 to 3], prevref[3], dispfn, displn, prevfn, prevln, &
	col_hdr
char check_type


dwObject	ldwo_Trailer1Type, &
			ldwo_Trailer1Length, &
			ldwo_Trailer2Type, &
			ldwo_Trailer2Length, &
			ldwo_Trailer3Type, &
			ldwo_Trailer3Length, &
			ldwo_Container1Length, &
			ldwo_Container2Length, &
			ldwo_Container3Length, &
			ldwo_Container4Length, &
			ldwo_ContainerMap

n_cst_Events	lnv_Events

ldwo_Trailer1Type = ds_Events.Object.Trlr1_Type
ldwo_Trailer1Length = ds_Events.Object.Trlr1_Length
ldwo_Trailer2Type = ds_Events.Object.Trlr2_Type
ldwo_Trailer2Length = ds_Events.Object.Trlr2_Length
ldwo_Trailer3Type = ds_Events.Object.Trlr3_Type
ldwo_Trailer3Length = ds_Events.Object.Trlr3_Length
ldwo_Container1Length = ds_Events.Object.Cntn1_Length
ldwo_Container2Length = ds_Events.Object.Cntn2_Length
ldwo_Container3Length = ds_Events.Object.Cntn3_Length
ldwo_Container4Length = ds_Events.Object.Cntn4_Length
ldwo_ContainerMap = ds_Events.Object.ContainerMap


for markloop = 1 to evrows
	setnull(dispfn)
	setnull(displn)
	setnull(dispref)
	dispid = ds_events.object.de_driver[markloop]
	if dispid > 0 then
		if previd[1] = dispid then
			dispfn = prevfn
			displn = prevln
			dispref = prevref[1]
		else
			find_ems.em_id = dispid
			if gf_emp_info(ds_emp, null_str, null_str, find_ems) > 0 then
				dispfn = find_ems.em_fn
				displn = find_ems.em_ln
				dispref = find_ems.em_ref
				previd[1] = dispid
				prevfn = dispfn
				prevln = displn
				prevref[1] = dispref
			end if
		end if
	end if
	ds_events.object.driv_fn[markloop] = dispfn
	ds_events.object.driv_ln[markloop] = displn
	ds_events.object.driv_ref[markloop] = dispref
	for checkloop = 2 to 10
		setnull(disptype)
		setnull(dispref)
		setnull(displen)
		choose case checkloop
			case 2
				dispid = ds_events.object.de_tractor[markloop]
				col_hdr = "trac"
			case 3
				dispid = ds_events.object.de_trailer1[markloop]
				col_hdr = "trlr1"
			case 4
				dispid = ds_events.object.de_trailer2[markloop]
				col_hdr = "trlr2"
			case 5
				dispid = ds_events.object.de_trailer3[markloop]
				col_hdr = "trlr3"
			case 6
				dispid = ds_events.object.de_container1[markloop]
				col_hdr = "cntn1"
			case 7
				dispid = ds_events.object.de_container2[markloop]
				col_hdr = "cntn2"
			case 8
				dispid = ds_events.object.de_container3[markloop]
				col_hdr = "cntn3"
			case 9
				dispid = ds_events.object.de_container4[markloop]
				col_hdr = "cntn4"
			case 10
				dispid = ds_events.object.de_acteq[markloop]
				col_hdr = "acteq"
		end choose
		if dispid > 0 then
			if previd[2] = dispid then
				disptype = prevtype[2]
				dispref = prevref[2]
			elseif previd[3] = dispid then
				disptype = prevtype[3]
				dispref = prevref[3]
				displen = prevlen
			else
				find_eqs.eq_id = dispid
				if gf_eq_info(ds_equip, null_str, null_str, find_eqs) > 0 then
					disptype = find_eqs.eq_type
					dispref = find_eqs.eq_ref
					displen = find_eqs.eq_length
					if checkloop = 2 then
						prevtype[2] = disptype
						prevref[2] = dispref
					elseif (checkloop > 2 and checkloop < 6) or checkloop = 10 then
						prevtype[3] = disptype
						prevref[3] = dispref
						prevlen = displen
					end if
				end if
			end if
		end if
		if checkloop < 6 or checkloop > 9 then &
			ds_events.setitem(markloop, col_hdr + "_type", disptype)
		ds_events.setitem(markloop, col_hdr + "_ref", dispref)
		if checkloop > 2 then &
			ds_events.setitem(markloop, col_hdr + "_length", displen)
	next

	ds_events.object.interch[markloop] = null_long
	check_type = ds_events.object.de_event_type[markloop]
	if pos("HRMN", check_type) > 0 then
		ev_id = ds_events.object.de_id[markloop]
		find_eqs.eq_id = ds_events.object.de_acteq[markloop]
		if gf_eq_info(ds_equip, null_str, null_str, find_eqs) > 0 then
			choose case check_type
				case "H", "M"
					if find_eqs.oe_orig_event = ev_id then &
						ds_events.object.interch[markloop] = 1
				case "R", "N"
					if find_eqs.oe_term_event = ev_id then &
						ds_events.object.interch[markloop] = 1
			end choose
		end if
	end if

	ldwo_ContainerMap.Primary [ markloop ] = lnv_Events.of_GetContainerMap ( &
		ldwo_Trailer1Type.Primary [ markloop ], &
		ldwo_Trailer1Length.Primary [ markloop ], &
		ldwo_Trailer2Type.Primary [ markloop ], &
		ldwo_Trailer2Length.Primary [ markloop ], &
		ldwo_Trailer3Type.Primary [ markloop ], &
		ldwo_Trailer3Length.Primary [ markloop ], &
		ldwo_Container1Length.Primary [ markloop ], &
		ldwo_Container2Length.Primary [ markloop ], &
		ldwo_Container3Length.Primary [ markloop ], &
		ldwo_Container4Length.Primary [ markloop ] )

	//MFS 1/5/06 - set status to not modified
	//wf_isShipmentModifed relies on non-updateable columns being Not Modified.
	//Computed Fields and non-updateable columns should always be reset
	//for dispatch purposes (events, items, equipment, shipments)
	ds_events.SetItemStatus ( markloop , "driv_fn" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "driv_ln" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "driv_ref" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , col_hdr+"_type" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , col_hdr+"_ref" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , col_hdr+"_length" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "interch" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "trac_type" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "trac_ref" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Trlr1_Type" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Trlr1_Length" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Trlr1_Ref" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Trlr2_Type" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Trlr2_Length" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Trlr2_Ref" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Trlr3_Type" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Trlr3_Length" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Trlr3_Ref" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Cntn1_Length" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Cntn1_Ref" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Cntn2_Length" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Cntn2_Ref" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Cntn3_Length" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Cntn3_Ref" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Cntn4_Length" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "Cntn4_Ref" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( markloop , "ContainerMap", PRIMARY!, NotModified! )
	

next


DESTROY ldwo_Trailer1Type
DESTROY ldwo_Trailer1Length
DESTROY ldwo_Trailer2Type
DESTROY ldwo_Trailer2Length
DESTROY ldwo_Trailer3Type
DESTROY ldwo_Trailer3Length
DESTROY ldwo_Container1Length
DESTROY ldwo_Container2Length
DESTROY ldwo_Container3Length
DESTROY ldwo_Container4Length
DESTROY ldwo_ContainerMap
end subroutine

public function integer save ();//Returns : 1, -1

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_LicenseManager	lnv_LicenseManager

Long	ll_DeletedCount

lnv_Dispatch = This.wf_GetDispatchManager ( )

Boolean lb_ApproveRequest = TRUE

IF IsValid ( lnv_Dispatch ) THEN
	
	IF lnv_Dispatch.of_HasItinerariesCached ( ) THEN
		IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Dispatch, "S" ) < 0 THEN
			lb_ApproveRequest = FALSE
		END IF
	END IF
	
	IF lnv_Dispatch.of_HasTripsCached ( ) THEN
		IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Brokerage, "S" ) < 0 THEN
			lb_ApproveRequest = FALSE
		END IF
	END IF
	
	IF lb_ApproveRequest = FALSE THEN
		RETURN -1
	END IF

END IF


Integer	li_Return = 1

if isvalid(shipwin) then
	//shipwin.dw_ship_info.setredraw(false)
//	shipwin.dw_ship_itin.setredraw(false)
	shipwin.dw_event_details.setredraw(false)
end if

if isvalid(itinwin) then
	itinwin.dw_itin.setredraw(false)
	itinwin.dw_detail.setredraw(false)
end if

///////////
IF li_Return = 1 THEN
	IF IsValid ( lnv_Dispatch ) THEN
	
		CHOOSE CASE lnv_Dispatch.Event pt_Save ( )
	
		CASE 1  //Success
			//OK
	
		CASE -1  //Failure
			li_Return = -1
	
		CASE ELSE  //Unexpected result
			li_Return = -1
	
		END CHOOSE
	
	END IF
END IF

///////////

if isvalid(shipwin) then

	//If the update failed, check whether the shipment row has been deleted, and if so,
	//restore it before restoring redraw.

//	IF li_Return = -1 THEN
//
//		ll_DeletedCount = shipwin.dw_Ship_Info.DeletedCount ( )
//	
//		IF shipwin.dw_Ship_Info.RowCount ( ) = 0 AND ll_DeletedCount > 0 THEN
//			shipwin.dw_Ship_Info.RowsMove ( ll_DeletedCount, ll_DeletedCount, Delete!, &
//				shipwin.dw_Ship_Info, 1, Primary! )
//		END IF
//	
//		shipwin.Event ue_RefreshEquipment ( )
//	
//	END IF

//	shipwin.dw_ship_info.setredraw(true)
//	shipwin.dw_ship_itin.setredraw(true)
	shipwin.dw_event_details.setredraw(true)
	
end if

if isvalid(itinwin) then
	itinwin.dw_itin.setredraw(true)
	itinwin.dw_detail.setredraw(true)
	itinwin.dw_detail.of_CheckNotifications ( )
	itinwin.Event ue_RefreshEquipment ( )
end if

//Until 3.6.b2, we were calling of_RefreshShipments here.  Moved this to n_cst_bso_dispatch.pt_Save in 3.6.b2 5-9-03

return li_Return
end function

public subroutine wf_set_toolmenu (string as_type);//The main reason I put this function here rather than in the two child windows is the
//need to reference m_current in m_sheets.  I don't think there's any direct way to do 
//this from the child windows.

s_toolmenu lstr_toolmenu
Boolean	lb_ShipmentMenuValid

choose case as_type
case "SHIP!"
	if not isvalid(shipwin) then return
	if not isvalid(shipwin.inv_cst_toolmenu_manager) then
		if shipwin.wf_create_toolmenu() = -1 then
			//Error processing??
		end if
	end if

	//The yields were added in 2.3.00 to prevent a crash in User.exe, a known
	//issue which PB has supposedly fixed in 6.5.1

	//We commented them out and switched to using instance variables and the 
	//DESTROY in 3.0.09, to try to eliminate crashing people still had.
	//Same applies to the ITIN section, below.

	IF IsValid ( im_ItineraryMenu ) THEN
		DESTROY im_ItineraryMenu
	END IF

//	Yield ( )
	this.changemenu(im_ShipmentMenu)

//	Yield ( )
	gf_mask_menu(im_ShipmentMenu)

//	Yield ( )
	shipwin.inv_cst_toolmenu_manager.of_set_target_menu(im_ShipmentMenu.m_current)

case "ITIN!"
	if not isvalid(itinwin) then return
	
	if not isvalid(itinwin.inv_cst_toolmenu_manager) then
		if itinwin.wf_create_toolmenu() = -1 then
			//Error processing??
		end if
	end if
	
	IF IsValid ( im_ShipmentMenu ) THEN
		DESTROY im_ShipmentMenu
	END IF

	//We'll do it this way until we get the toolmenu set up in w_itin
	this.changemenu(im_ItineraryMenu)
	gf_mask_menu(im_ItineraryMenu)
	itinwin.inv_cst_toolmenu_manager.of_set_target_menu(im_ItineraryMenu.m_current)

end choose
end subroutine

public function integer wf_reset_times (long al_start_row, string as_context);// n_cst_numerical lnv_numerical
//if lnv_numerical.of_IsNullOrNotPos(itinevents) then return 1

//start_row was not being referenced in the script copied over from w_itin.  I'm not
//sure at what point this feature got dropped, and whether there was a problem using it
//or if I just dropped it for safety's sake at some point.

long ll_markloop, ll_minutes
decimal {1} lc_miles
string ls_pcm, ls_arr, ls_dep, ls_pcm_prev, ls_dep_prev
time lt_appt, lt_arr, lt_dep, lt_duration
date ld_appt

setnull(ls_pcm_prev)
setnull(ls_dep_prev)

for ll_markloop = 1 to ds_events.rowcount()
	ls_pcm = ds_events.object.co_pcm[ll_markloop]
	lt_arr = ds_events.object.de_arrtime[ll_markloop]
	lt_dep = ds_events.object.de_deptime[ll_markloop]
	ld_appt = ds_events.object.de_apptdate[ll_markloop]
	lt_appt = ds_events.object.de_appttime[ll_markloop]
	lt_duration = ds_events.object.de_duration[ll_markloop]
	if isnull(lt_duration) then lt_duration = 00:30:00
	if len(ls_pcm_prev) > 0 and len(ls_pcm) > 0 then
		gf_calc_miles(ls_pcm_prev, ls_pcm, lc_miles, ll_minutes, 0)
	else
		setnull(lc_miles)
		setnull(ll_minutes)
	end if
	ds_events.object.leg_miles[ll_markloop] = lc_miles
	ds_events.object.leg_mins[ll_markloop] = ll_minutes
	choose case as_context
	case "ITIN!"
		if isnull(ls_dep_prev) then
			if not isnull(lt_arr) then
				ls_arr = string(lt_arr)
			elseif datetime(ld_appt) = datetime(itinwin.itin_date) and not isnull(lt_appt) then
				ls_arr = string(lt_appt)
			else
				setnull(lt_arr)
			end if
		elseif isnull(ll_minutes) then
			if not isnull(lt_arr) then
				if secondsafter(time(ls_dep_prev), lt_arr) > 0 then
					ls_arr = string(lt_arr)
				else
					ls_arr = ls_dep_prev
				end if
			elseif datetime(ld_appt) = datetime(itinwin.itin_date) and not isnull(lt_appt) then
				if secondsafter(time(ls_dep_prev), lt_appt) > 0 then
					ls_arr = string(lt_appt)
				else
					ls_arr = ls_dep_prev
				end if
			else
				ls_arr = ls_dep_prev
			end if
		else
			ls_arr = string(reltime_ext(ls_dep_prev, ll_minutes * 60))
		end if
		ds_events.object.cc_arrstr[ll_markloop] = ls_arr
		if not isnull(lt_arr) then ls_arr = string(lt_arr)
		if ld_appt = itinwin.itin_date and not isnull(lt_appt) then
			if isnull(ls_arr) then
				ls_arr = string(lt_appt)
			elseif secondsafter(time(ls_arr), lt_appt) > 0 then
				ls_arr = string(lt_appt)
			end if
		end if
		if isnull(ls_arr) then
			setnull(ls_dep)
		else
			ls_dep = string(reltime_ext(ls_arr, secondsafter(00:00:00, lt_duration)))
		end if
		ds_events.object.cc_depstr[ll_markloop] = ls_dep
		if isnull(lt_dep) then
			if len(ls_dep) > 0 then
				ls_dep_prev = ls_dep
			elseif len(ls_dep_prev) > 0 then
				ls_dep_prev = string(reltime_ext(ls_dep_prev, secondsafter(00:00:00, lt_duration)))
			end if
		else
			ls_dep_prev = string(lt_dep)
		end if
	case else //i.e., SHIP!
		ds_events.object.cc_arrstr[ll_markloop] = null_str
		ds_events.object.cc_depstr[ll_markloop] = null_str
	end choose

	if len(ls_pcm) > 0 then ls_pcm_prev = ls_pcm
	
	//MFS 1/5/06 - set status to not modified
	//wf_isShipmentModifed relies on non-updateable columns being Not Modified
	//Computed Fields and non-updateable columns should always be reset
	//for dispatch purposes (events, items, equipment, shipments)
	ds_events.SetItemStatus ( ll_markloop , "leg_miles" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( ll_markloop , "leg_mins" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( ll_markloop , "cc_arrstr" , PRIMARY!, NotModified! )
	ds_events.SetItemStatus ( ll_markloop , "cc_depstr" , PRIMARY!, NotModified! )
	
next

return 1
end function

public function integer wf_get_miles (long al_start_row, long al_end_row, ref decimal ac_miles);//The calculation part of this function can (and should) be generalized to a column 
//summing function.  I don't have time to deal with the decimal/non-decimal argument
//issues right now.

//!!Note!! The al_start_row value (which is correct from a point-to-point perspective) 
//needs to have one added to it in order to target the correct rows.

long ll_row
decimal lc_miles, lc_total
boolean lb_all_ok

if isnull(al_start_row) then al_start_row = 1
if isnull(al_end_row) then al_end_row = ds_events.rowcount()

al_start_row ++

lb_all_ok = true

for ll_row = al_start_row to al_end_row
	lc_miles = ds_events.object.leg_miles[ll_row]
	if isnull(lc_miles) then lb_all_ok = false else lc_total += lc_miles
next

ac_miles = lc_total

if lb_all_ok then
	return 1
else
	return 0
end if
end function

public function integer wf_quickprint_delrecs (long ala_ids[]);n_cst_BillServices	lnv_BillServices

RETURN lnv_BillServices.of_QuickPrint_Delrecs ( ala_Ids )
end function

public function n_cst_bso_dispatch wf_getdispatchmanager ();//Return a handle to the dispatch object.

RETURN inv_Dispatch
end function

public function integer merge_events (datastore ads_source);//Returns:  1 = Success, -1 = Error, -2 = Original value conflict

//For legacy compatibility.  Forward the request to the Dispatch object.

n_cst_bso_Dispatch	lnv_Dispatch
Integer	li_Return = -1

lnv_Dispatch = This.wf_GetDispatchManager ( )

IF IsValid ( lnv_Dispatch ) THEN

	li_Return = lnv_Dispatch.of_MergeEvents ( ads_Source )

END IF


RETURN li_Return
end function

public function long wf_getselectedevents (ref n_cst_beo_event anva_events[]);Long	ll_Return = -1
Long	ll_IDCount
n_cst_beo_Event	lnva_Events[]


IF IsValid ( itinwin ) THEN
	IF itinwin.Visible = TRUE THEN
		ll_IDCount = itinwin.wf_GetSelectedEvents ( lnva_Events )
	END IF
END IF

IF isValid( shipwin ) THEN
	IF shipwin.visible = TRUE THEN
		ll_IDCount = shipwin.wf_GetSelectedEvents ( lnva_Events )
	END IF
END IF

IF ll_IDCount > 0 THEN 
	ll_Return = ll_IDCount
	anva_events = lnva_Events
ELSEIF ll_IDCount = 0 THEN
	ll_Return = 0 
	
END IF

RETURN ll_Return
end function

public function integer wf_setshares ();IF isValid ( shipwin ) THEN
	shipwin.wf_SetShares ( )	
END IF

IF isValid ( itinwin ) THEN
	itinwin.wf_SetShares ( )	
END IF

RETURN 1
end function

public function string wf_getitinfilter (integer seq_type, long seq_id, date ad_min, date ad_max);//For legacy compatibility.  Forward the request to the Dispatch object.

n_cst_bso_Dispatch	lnv_Dispatch
String	ls_Filter

lnv_Dispatch = This.wf_GetDispatchManager ( )

IF IsValid ( lnv_Dispatch ) THEN

	ls_Filter = lnv_Dispatch.of_GetItineraryFilter ( seq_type, seq_id, ad_Min, ad_Max )

ELSE
	SetNull ( ls_Filter )

END IF

RETURN ls_Filter
end function

public function n_cst_AlertManager wf_getalertmanager ();IF Not IsValid ( inv_alertmanager ) THEN
	inv_alertmanager = CREATE n_cst_AlertManager
END IF
RETURN inv_Alertmanager
end function

public subroutine wf_restoresize ();
THIS.Width = gnv_app.of_getframe( ).workspacewidth( ) - 15
THIS.Height = gnv_app.of_getframe( ).workspaceheight( ) - 125

this.x = 0 
this.y = 0
end subroutine

public function long wf_getreportcontexts (ref string asa_contexts[]);String	lsa_contexts[]

//returns the folder names  that goes with the reports 
String	ls_context

IF isValid( itinWin ) THEN
	IF itinwin.visible THEN
		lsa_contexts[1] = "Itinerary"
	ELSEIF isValid( shipWin ) THEN
		IF shipwin.visible THEN
			//if there ever is contexts for shipments do it here
		END IF
	END IF
ELSE
	IF isVALID( shipWin ) THEN
		IF shipwin.visible THEN
			//if there ever is contexts for shipments do it here
		END IF
	END IF
END IF

asa_contexts = lsa_contexts
return upperBound( lsa_contexts )
end function

public function integer wf_retrieveopenshipment (long al_shipid);Integer	li_Return

IF NOT isValid(ids_OpenShips) THEN
	ids_OpenShips = Create DataStore
	ids_OpenShips.DataObject = "d_openshipments"
	ids_OpenShips.SetTransObject(SQLCA)
END IF

li_Return = ids_OpenShips.Retrieve(al_shipid)


Commit;

Return li_Return


end function

public function integer wf_removeopenshipment (long al_shipid);String	ls_MachineName
Long		ll_UserId
LOng		ll_FrameHandle
String	ls_FindString
Integer	li_Return
Long		ll_FoundRow
n_cst_PlatformWin32 lnv_Platform

lnv_Platform = Create n_cst_PlatformWin32
ls_MachineName = lnv_Platform.of_GetComputerName()
ll_FrameHandle = Handle(gnv_app.of_GetFrame())

ls_FindString	 = "machinename = '" + ls_MachineName + "' AND shipid = " + String(al_Shipid) + " And userid = " + String ( gnv_app.of_GetNumericuserid( ) ) + &
						"AND framehandle = " + String(ll_FrameHandle)

IF wf_RetrieveOpenShipment(al_shipid) > 0 THEN
	ll_FoundRow = ids_OpenShips.Find(ls_FindString, 1, ids_OpenShips.RowCount())
	IF ll_FoundRow > 0 THEN
		IF ids_OpenShips.DeleteRow(ll_FoundRow) = 1 THEN
			li_Return = 1
		ELSE
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF
	IF li_Return = 1 THEN
		IF ids_OpenShips.Update() = 1 THEN
			Commit;
		ELSE
			RollBack;
		END IF
	END IF
	
	
ELSE
	li_Return = -1
END IF

Destroy lnv_Platform

Return li_Return
end function

public function boolean wf_isshipmentopen (long al_shipid, ref long al_handle);/***************************************************************************************
NAME: of_isShipmentOpen

ACCESS:	Public
		
ARGUMENTS: 	(Long al_ShipId, Ref Long al_handle)

RETURNS:		Boolean
	
DESCRIPTION:
	
		Returns True if the user on the current machine has the shipment open
		Returns False if the user on the current machine does not have shipment open
		
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created: 1/9/06 - Maury

***************************************************************************************/

String	ls_MachineName
Long		ll_FrameHandle
Long		ll_FoundRow
String	ls_FindString
Boolean	lb_Return

n_cst_PlatformWin32 lnv_Platform

lnv_Platform = Create n_cst_PlatformWin32
ls_MachineName = lnv_Platform.of_GetComputerName()
ll_FrameHandle = Handle(gnv_App.of_GetFrame())
ls_FindString	 = "machinename = '" + ls_MachineName + "' AND shipid = " + String(al_Shipid) + " AND userid = " + String ( gnv_app.of_Getnumericuserid( )) + &
						"AND framehandle = " + String(ll_FrameHandle)


ll_FoundRow = ids_OpenShips.Find(ls_FindString, 1, ids_OpenShips.RowCount())

IF ll_FoundRow > 0 THEN
	al_Handle = ids_OpenShips.GetItemNumber(ll_FoundRow, "winhandle")
	lb_Return = TRUE
ELSE
	lb_Return = FALSE
END IF

DESTROY ( lnv_Platform )
Return lb_Return
end function

public function integer wf_recordopenshipment (long al_shipid);Integer 	li_Return
Integer	li_Order
Integer	li_Update
Long		ll_UserId
Long		ll_Row
Long		ll_Handle
Long		ll_FrameHandle
String	ls_UserName
String	ls_MachineName

n_cst_PlatformWin32	lnv_Platform

lnv_Platform = Create n_cst_PlatformWin32
ls_MachineName = lnv_platform.of_GetComputerName()

ls_UserName = gnv_App.of_GetUserId( )
ll_UserId = gnv_App.of_GetNumericUserId()
ll_Handle = Handle(This)
ll_FrameHandle = Handle(gnv_App.of_GetFrame())


ll_Row = ids_OpenShips.InsertRow(0)
IF ll_Row > 0 THEN
	ids_OpenShips.Object.userid[ll_Row] = ll_UserId
	ids_OpenShips.Object.shipid[ll_Row] = al_ShipId
	ids_OpenShips.Object.username[ll_Row] = ls_UserName
	ids_OpenShips.Object.machinename[ll_Row] = ls_MachineName
	ids_OpenShips.Object.winhandle[ll_Row] = ll_Handle
	ids_OpenShips.Object.framehandle[ll_Row] = ll_FrameHandle
END IF

IF ids_OpenShips.Update() = 1 THEN
	Commit;
ELSE
	Rollback;
END IF

Destroy lnv_Platform

Return li_Return
end function

public function integer wf_removeopenshipmentswithcurrenthandle (long al_shipid, long al_excludeid);/***************************************************************************************
NAME: wf_RemoveShipmentHandles

ACCESS:	Public
		
ARGUMENTS: 		
							(Long al_ShipId, Long al_ExcludeId //shipement that should not be removed)

RETURNS:			Integer
	
DESCRIPTION:
		Removes all open shipment rows with current machine name from openshipments 
		that have w_dispatch's handle
		
		IF al_ExcludeId is specified that id will not be removed


		Returns -1 if error occurs
		Returns number of rows deleted otherwise
		
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created: 1/5/06 - Maury

***************************************************************************************/
String	ls_MachineName, ls_MachineCache, ls_Handle
String	ls_SQL, ls_Where, ls_NewSql
Integer	li_Return = 0
Long		i, ll_RowCount
Long		ll_Handle
Long		ll_ShipId
integer	li_ret

n_cst_PlatformWin32 lnv_Platform

n_cst_SQLAttrib	lstr_SQL[]
n_cst_SQL	lnv_SQL
n_cst_String	lnv_String

//modify select to retrieve all shipments
ls_SQL = ids_OpenShips.Describe("datawindow.table.select")
lnv_SQL.of_Parse( ls_SQL, lstr_SQL[] )
lstr_SQL[1].s_Where = ""
ls_NewSQL = lnv_SQL.of_assemble( lstr_SQL[] )
ids_OpenShips.Modify("datawindow.table.select = '" + ls_NewSQL + "'")


lnv_Platform = Create n_cst_PlatformWin32
ls_MachineName = lnv_Platform.of_GetComputerName()


IF wf_RetrieveOpenShipment(al_shipid) > 0 THEN
	ll_RowCount = ids_OpenShips.RowCount()

	FOR i = ll_RowCount TO 1 STEP - 1
		ll_ShipId = ids_OpenShips.Object.shipid[i]
		ls_MachineCache = ids_OpenShips.Object.machinename[i]
		ll_Handle = ids_OpenShips.Object.winhandle[i]
		
		IF NOT isNull(al_excludeid) THEN //Remove all except al_excludeid
			IF ls_MachineCache = ls_MachineName AND ll_Handle = Handle(This) AND ll_Shipid <> al_ExcludeId THEN
				IF ids_OpenShips.DeleteRow(i) = 1 THEN
					li_Return ++
				END iF
			END IF
		ELSE
			IF ls_MachineCache = ls_MachineName AND ll_Handle = Handle(This) THEN
				IF ids_OpenShips.DeleteRow(i) = 1 THEN
					li_Return ++
				END iF
			END IF
		END IF

		
	NEXT
	
	
	IF li_Return > 0 THEN
		IF ids_OpenShips.Update() = 1 THEN
			Commit;
		ELSE
			RollBack;
			li_Return = -1
		END IF
	END IF
	
ELSE
	li_Return = -1
END IF

//restore sql select
ids_OpenShips.Modify("datawindow.table.select = '" + ls_SQL + "'")

Destroy lnv_Platform 

Return li_Return
end function

public function integer wf_removeopenshipmentswithcurrenthandle (long al_shipid);Long	ll_ExcludeId
SetNull(ll_ExcludeId)

Return wf_RemoveOpenShipmentsWithCurrentHandle(al_ShipId, ll_ExcludeId)
end function

public function integer wf_alertremoteopenshipment (long al_shipid);/***************************************************************************************
NAME: of_AlertOpenShipement

ACCESS:	Private
		
ARGUMENTS: 	(None)
					

RETURNS:		Integer
	
DESCRIPTION:
			Alerts user if someone else already has the shipment open
			
			Returns 1 if no shipment is found or user clicks OK
			Returns 0 if user cancels


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
		Created 1/3/2006 - Maury

***************************************************************************************/

String	ls_MachineName
String	ls_UserName
String	ls_FindString
String	ls_Message
Integer	li_Return
Integer	li_Warn
Long		ll_UserId
Long		ll_FoundRow
Long		ll_FrameHandle


n_cst_PlatformWin32	lnv_Platform

lnv_Platform = Create n_cst_PlatformWin32
ls_MachineName = lnv_platform.of_GetComputerName()

ll_FrameHandle = Handle(gnv_App.of_GetFrame())
ll_UserId = gnv_App.of_GetNumericUserId()

//ls_FindString	 = "shipid = " + String(al_Shipid) + " AND machinename <> '" + String(ls_MachineName) + "'"
ls_FindString	 = "shipid = " + String(al_Shipid) + " AND framehandle <> " + String(ll_FrameHandle)

ll_FoundRow = ids_OpenShips.Find(ls_FindString, 1, ids_OpenShips.RowCount())
IF ll_FoundRow > 0 THEN
	ls_MachineName = ids_OpenShips.GetItemString(ll_FoundRow, "machinename")
	ls_UserName = ids_OpenShips.GetItemString(ll_FoundRow, "username")
	ls_Message = "User " + ls_UserName + " on machine " + ls_MachineName + " has shipment " + String(al_Shipid) + " open or has unsaved changes." + &
						"~r~n~r~nClick OK to open shipment anyway.~r~n"
	li_Warn = MessageBox("Shipment Open by Another User", ls_Message, Exclamation!, OKCANCEL!, 1)
	IF li_Warn = 1 THEN
		li_Return = 1
	ELSE
		li_Return = 0
	END IF
ELSE
	li_Return = 1
END IF

Destroy lnv_Platform

Return li_Return
end function

public function integer wf_displayshipment (long al_shipid, boolean ab_firstopen);/***************************************************************************************
NAME: 	wf_DisplayShipemnt

ACCESS:	Public
		
ARGUMENTS: 		(long al_shipid, bool ab_firstOpen)

RETURNS:	Integer				
	
DESCRIPTION:
		Returns
			1: Shipment Displayed
			0: Shipment Forwarded to another window for Display
				*This w_disp window will CLOSE
		  -1: Error OR user cancelled


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created 1/11/06 - MFS

***************************************************************************************/

Integer	li_Return = -1
Integer	li_SaveAndOpen = 1
Long		ll_ShipHandle
Boolean	lb_IsOpen = FALSE
Boolean	lb_DisplayShip = TRUE
Boolean	lb_AutoRate
Long		ll_LastShipId = 0




n_cst_bso_Dispatch	lnv_Dispatch
n_Cst_LicenseManager	lnv_LicMan



lb_AutoRate = UpperBound ( inva_ratedata ) > 0 AND lnv_LicMan.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating )

	
	
	
IF wf_RetrieveOpenShipment(al_ShipId) > 0 THEN
	lb_isOpen = wf_isShipmentOpen( al_ShipId, ll_ShipHandle)
END IF

IF lb_AutoRate AND lb_IsOpen THEN
	MessageBox ( "Auto Rate Combined Freight" , "The shipment you are attempting to rate is already open. However it was not opened in AUTO RATE MODE. You need to close the window and attempt the process again." 	)
END IF
	
IF lb_isOpen THEN
	IF ll_ShipHandle <>  Handle(This) THEN 
		lb_DisplayShip = FALSE  //Open in another window so forward request and close
		li_Return = 0
	END IF
END IF


//Try to Display the Shipement
IF lb_DisplayShip THEN
	IF wf_AlertRemoteOpenShipment(al_ShipId) = 1 THEN
		IF isValid(shipwin) THEN
			ll_LastShipId = shipwin.wf_GetShipmentId ( )
		
			//remove last shipment from 'open' status if nothing has been modified
			//Calling wf_isShipmentModified instead of pt_updatespending because
			//we only want to know if their are modifications made to the currently 
			//open shipment (in the primary  buffer)
			
			IF NOT wf_isShipmentModified() THEN
				wf_RemoveOpenShipment(ll_LastShipId)
			ELSE
				//leave shipement as 'open' status
			END IF

		END IF
		
	
		if not isvalid(shipwin) then open(shipwin, this)
	
		this.setredraw(false)
	
		choose case shipwin.display_ship(al_ShipId)
			case 1
				li_Return = 1
			case -2
				this.setredraw(true)
				messagebox("Display Shipment", "Information on this shipment has been modified "+&
					"since it was originally retrieved for this window.  This may cause conflicts "+&
					"in saving your changes.  You should attempt to save now, before continuing.~n~n"+&
					"The shipment selection request is cancelled.", exclamation!)
				li_Return = -1
			case -1
				this.setredraw(true)
				messagebox("Display Shipment", "Could not retrieve shipment information from "+&
					"database.~n~nRequest cancelled -- Please retry.", exclamation!)
				li_Return = -1 
			case 0
				this.setredraw(true)
				messagebox("Display Shipment", "The shipment you have selected has been deleted "+&
					"in this window, and will be removed from the list upon saving.~n~nRequest "+&
					"cancelled.", exclamation!)
				li_Return =  -1
		end choose
		
		IF li_Return = 1 THEN
			
			IF UpperBound ( inva_RateData ) > 0 THEN
				IF lnv_LicMan.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating  ) THEN
					shipwin.postevent("ue_autorate")
				end if	
			end if				
			
			wf_set_toolmenu("SHIP!")
			
			shipwin.show()
			this.setredraw(true)
			IF isValid(itinwin) THEN
				itinwin.Hide()
			END IF
			IF This.WindowState = Minimized! THEN
				This.WindowState = Normal!
			END IF
		END IF
	ELSE
		IF ab_FirstOpen THEN
			Close(This)
			li_Return = -1
		END IF
	END IF
END IF

IF NOT lb_DisplayShip THEN 
	//Check if updates are pending on current dispatch window
	lnv_Dispatch = wf_GetDispatchManager()
	IF IsValid ( lnv_Dispatch ) THEN
		IF lnv_Dispatch.Event pt_UpdatesPending ( ) = 1 THEN
			// tell the user that it is in their best interest to try and save b.c since the shipment
			// they are trying to display to is already open we want to avoid the DB error 3 
			// by saving this dispatch instance and then displaying the already open instance.
			li_SaveAndOpen = MessageBox("Save Changes?", "Shipment " + String(al_shipid) + " is already open." + &
							"Changes should be saved before jumping to the shipement.~r~nSelect OK to save changes and jump to shipment" + String(al_shipid) + ".",&
							Exclamation!, OKCANCEL!, 1) 
							
			IF li_SaveAndOpen = 1 THEN
				IF This.Save() < 0 THEN
					// error saving so we want to stop. We don't want to Jump and we don't want to 
					// try and restore anything
					li_Return = -1
				END IF
			ELSE
				li_Return = -1
			END IF	
		END IF
	END IF
	
	
	IF li_Return = 0 THEN	//Attempt to forward request to different window
		
		IF Send(ll_ShipHandle, 1024, 0, al_ShipId) <> 1 THEN // Refresh the window with the correct id (by triggering the event ue_displayshipment
			li_Return = -1 
		END IF
		Close(This)
		
	END IF
	
END IF //end if not lb_displayship


Return li_Return
end function

public function boolean wf_isshipmentmodified ();/***************************************************************************************
NAME: is_ShipmentModified

ACCESS:	Public
		
ARGUMENTS: 		(None)

RETURNS:			Boolean
	
DESCRIPTION:
		Returns True if any dispatch rows in the PRIMARY buffer are modified
		Returns False if no dispatch rows in the PRIMARY buffer are modified
		
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created: 1/5/06 - Maury

***************************************************************************************/


n_cst_bso_Dispatch	lnv_Dispatch
LOng	ll_Modified = 0
Boolean	lb_Return

n_cst_dssrv		lnv_DSsrv
lnv_DSsrv = Create n_cst_dssrv

	
lnv_Dispatch = This.wf_GetDispatchManager()
IF isValid(lnv_Dispatch) THEN
	lnv_DSsrv.of_SetRequestor(lnv_Dispatch.of_GetShipmentCache())
	ll_Modified += lnv_DSsrv.of_PrimaryModifiedCount()
	lnv_DSsrv.of_SetRequestor(lnv_Dispatch.of_GetEventCache())
	ll_Modified += lnv_DSsrv.of_PrimaryModifiedCount()
	lnv_DSsrv.of_SetRequestor(lnv_Dispatch.of_GetItemCache())
	ll_Modified += lnv_DSsrv.of_PrimaryModifiedCount()
	lnv_DSsrv.of_SetRequestor(lnv_Dispatch.of_GetEquipmentCache())
	ll_Modified += lnv_DSsrv.of_PrimaryModifiedCount()
END IF

IF ll_Modified = 0 THEN
	lb_Return = FALSE
ELSE
	lb_Return = TRUE
END iF

Destroy lnv_DSsrv

Return lb_Return
end function

on w_dispatch.create
call super::create
end on

on w_dispatch.destroy
call super::destroy
end on

event open;call super::open;long   		ll_SelID
long			ll_handle
string 		ls_SelCat
boolean		lb_autorate
integer 		li_SelType
date 			ld_SelDate
Boolean		lb_ApproveSelection = TRUE
Boolean		lb_AlreadyOpen
Boolean		lb_OpenShip = TRUE
Integer		li_RemoteOpen = 1
Integer		li_Return = 1
Long			ll_CurrentId
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm
			
n_cst_LicenseManager	lnv_LicenseManager
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Msg = message.powerobjectparm

lnv_Dispatch = CREATE n_cst_bso_Dispatch

this.x = 1
this.y = 1


setpointer(hourglass!)

inv_Dispatch = lnv_Dispatch

ds_Ships = lnv_Dispatch.of_GetShipmentCache ( ) 

ds_ships_a = create datastore
ds_ships_a.dataobject = "d_ship_info"

ds_Items = lnv_Dispatch.of_GetItemCache ( )

ds_items_a = create datastore
ds_items_a.dataobject = "d_item_details"

ds_Events = lnv_Dispatch.of_GetEventCache ( )

ds_emp = create datastore
ds_emp.dataobject = "d_emp_list"

ds_Equip = lnv_Dispatch.of_GetEquipmentCache ( )
ds_RetList = lnv_Dispatch.of_GetItineraryList ( )


ds_ships_a.settransobject(sqlca)
ds_items_a.settransobject(sqlca)
ds_emp.settransobject(sqlca)

evsel_base = lnv_Dispatch.of_GetEventSelectStatement ( )


This.of_SetResize ( TRUE )
//
////Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize ( 1300, 400 )


IF lnv_msg.of_Get_Parm ( "CATEGORY" , lstr_Parm ) <> 0 THEN
	ls_SelCat = lstr_Parm.ia_Value
END IF

IF lnv_msg.of_Get_Parm ( "TYPE" , lstr_Parm ) <> 0 THEN
	li_SelType = lstr_Parm.ia_Value
END IF

IF lnv_msg.of_Get_Parm ( "ID" , lstr_Parm ) <> 0 THEN
	ll_SelID = lstr_Parm.ia_Value
END IF


IF lnv_msg.of_Get_Parm ( "DATE" , lstr_Parm ) <> 0 THEN
	// I could not get this to set right without first casting it to a string 
	ld_SelDate = Date ( String ( lstr_Parm.ia_Value ) )
END IF

IF lnv_msg.of_Get_Parm ( "RATEDATA" , lstr_Parm ) <> 0 THEN
	inva_ratedata = lstr_Parm.ia_Value
END IF


if ls_SelCat = "ITIN" then
	
	CHOOSE CASE li_SelType
			
		CASE gc_Dispatch.ci_ItinType_Trip
			IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Brokerage, "E" ) < 0 THEN
				lb_ApproveSelection = FALSE
			END IF
		CASE ELSE
			IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Dispatch, "E" ) < 0 THEN
				lb_ApproveSelection = FALSE
			END IF
			
	END CHOOSE
	
	IF lb_ApproveSelection THEN
	
		open(itinwin, this)
		
		if itinwin.display_itin(li_SelType, ll_SelID, ld_SelDate) = 1 then
			wf_set_toolmenu("ITIN!")
			//See note below for ship call.  This is here for symmetry.
			itinwin.show()
		else
			messagebox("Display Itinerary", "Could not retrieve the itinerary information "+&
				"you requested.~n~nRequest cancelled.", exclamation!)
			winisclosing = true
			close(this)
		end if
		
	ELSE
		WinIsClosing = TRUE
		Close ( This )
	END IF
	
else

	
	THIS.wf_DisplayShipment ( ll_SelID, true /*first time opening*/ )

	/*
	IF UpperBound ( inva_RateData ) > 0 THEN
		IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating  ) THEN
			lb_autorate = true
		end if
	else
		lb_autorate = false		
	end if
		
	/* Begining of the  new window instance code MFS 2006 */
	
	IF wf_RetrieveOpenShipment(ll_SelId) > 0 THEN
		li_RemoteOpen = wf_AlertRemoteOpenShipment(ll_SelId)
		lb_AlreadyOpen = wf_IsShipmentOpen(ll_SelId, ll_Handle)
	END IF

	IF li_RemoteOpen = 1 THEN
	
		IF lb_AlreadyOpen THEN
			
			lb_OpenShip = FALSE  // FALSE b.c the shipment is already open and we are going to try anf find/restore it	
			
			ll_CurrentId = Send(ll_handle, 1025, 0, 0)//triggers event ue_getshipmentid()
			
			//Here the shipment is already open so we are going to try to restore it instead of opening a new one
			//If the shipment id in window we are tyring to restore does not match the id in the database
				//try to refresh the shipment window with the correct id.
			IF ll_CurrentId > 0 THEN
				IF ll_CurrentId <> ll_SelId THEN
					IF Send(ll_Handle, 1024, 0, ll_Selid) <> 1 THEN // Refresh the window with the correct id (by triggering the event ue_forcejumpshipment
						lb_OpenShip = TRUE  				  							// which calls wf_jumpshipment on shipwin)
						// lb_OpenShip = TRUE  b.c we couldn't refresh to the right shipment so we just want to jump the the shipment they want to see.
					END IF
				END IF
				//Try to Restore the open shipment
				IF lb_OpenShip = FALSE THEN
					IF Send(ll_Handle, 274, 61728, 0)  = -1 THEN  // Restores open shipment window if minimized	
						lb_OpenShip = TRUE  	// b.c. we couldn't restore the shipment so we want to perform the default operation of jump ship
					END IF
				END IF
			ELSE
				lb_OpenShip = TRUE  // couldn't resolve the shipments
			END IF
		
		END IF
		
	ELSE
		lb_OpenShip = False //User Canceled opening of shipment because someone else had it open
	END IF
	/* End of the  new window instance code MFS 2006 */
	
	
	IF lb_OpenShip THEN
		OpenWithParm( shipwin, lnv_Msg , this )
		//OpenSheetWithParm ( shipwin, this, gnv_App.of_GetFrame ( ), 0, Layered! )
				
				
		if lb_autorate then
			shipwin.postevent("ue_autorate")
		end if
		
		if shipwin.display_ship(ll_SelID) = 1 then
			
			wf_set_toolmenu("SHIP!")
			//This is called here rather than in open of w_ship because w_create_toolmenu 
			//in w_ship needs to know the dorb value which is retrieved during display_ship
			shipwin.Post show()
	
			//The yields added in wf_Set_Toolmenu in 2.3.00 caused the initial SetFocus in 
			//shipwin.display_ship to no longer function properly on window open (window
			//would open with nothing having focus).  This SetFocus was added in 2.3.01 
			//to correct that problem.
			//shipwin.dw_Ship_Info.Post SetFocus ( )
		else
			messagebox("Display Shipment", "Could not retrieve the shipment information "+&
				"you requested.~n~nRequest cancelled.", exclamation!)
			winisclosing = true
			close(this)
		end if
	END IF

	IF NOT lb_OpenShip THEN
		Close(This)
	END IF
*/
end if






end event

event closequery;if winisclosing then return 0 //forced close

winisclosing = true //changed to false at end of script if query is rejected


n_cst_bso_Dispatch	lnv_Dispatch

//Get a handle to the dispatch manager.
lnv_Dispatch = This.wf_GetDispatchManager ( )


IF isValid ( shipwin ) THEN
	IF Shipwin.Visible THEN
		choose case shipwin.wf_AcceptText (TRUE) 
			case -1 
				goto reject
			case 0
				return 0
		end choose
	END IF
	
END IF


//Check whether there are any updates pending on the dispatch manager, 
//and if not, allow the close to proceed.
//!! moved this from above the shipwin acceptText because the reftext validation was not happening
IF IsValid ( lnv_Dispatch ) THEN

	IF lnv_Dispatch.Event pt_UpdatesPending ( ) = 0 THEN

		RETURN 0

	END IF

END IF

this.setfocus()
this.show()

choose case messagebox("Dispatch Window", "Save changes before closing?", &
	question!, yesnocancel!, 1)
case 2
	return 0
case 3
	goto reject
end choose

if isvalid(shipwin) then
	if shipwin.visible then
		choose case shipwin.wf_status_check("CLOSE!")
		case -1
			return 0
		case -2
			goto reject
		end choose
	end if
end if

if save() = 1 then return 0

if messagebox("Dispatch Window", "Could not save changes to database.~n~nPress OK "+&
	"to abandon changes and close window, or Cancel to return to window and preserve "+&
	"changes for now.", exclamation!, okcancel!, 2) = 1 then return 0

reject:
winisclosing = false
return 1
end event

event close;DESTROY ds_ships_a
DESTROY ds_items_a
DESTROY ds_emp
DESTROY inv_Dispatch
Destroy ids_OpenShips
end event

event resize;call super::resize;IF IsValid ( Itinwin ) THEN
	IF ItinWin.Visible THEN
		Itinwin.event resize(  sizetype, newwidth, newheight )
		Itinwin.Width = newwidth
		Itinwin.height = newheight
	END IF
END IF

IF IsValid ( shipwin ) THEN
	IF shipwin.Visible THEN
		shipwin.event resize(  sizetype, newwidth, newheight )
		shipwin.Width = newwidth
		shipwin.height = newheight
	END IF
END IF
end event

event pfc_postopen;call super::pfc_postopen;/***window front back issue fix ********/

/*When the w_itin_select window closes, the active w_dispatch window loses focus for unknown reasons.
The following line will allow the close event of w_itin_select to execute BEFORE we force a bring to top */

This.BringToTop = TRUE

/***end window front back issue fix ********/
end event

