$PBExportHeader$n_cst_bso_edimanager.sru
forward
global type n_cst_bso_edimanager from n_cst_bso
end type
end forward

global type n_cst_bso_edimanager from n_cst_bso
end type
global n_cst_bso_edimanager n_cst_bso_edimanager

type variables

Constant long cl_transaction_set_204 = 204
Constant long cl_transaction_set_214 = 214
Constant long cl_transaction_set_210 = 210
Constant long cl_transaction_set_322 = 322
Constant long cl_transaction_set_990 = 990
Constant long cl_transaction_set_997 = 997

CONSTANT String cs_ShipmentRole_None = "NONE"
CONSTANT String cs_ShipmentRole_Billto = "BILLTO"
CONSTANT String cs_ShipmentRole_Origin = "ORIGIN"
CONSTANT String cs_ShipmentRole_Destination = "DESTINATION"
CONSTANT String cs_ShipmentRole_Carrier = "CARRIER"
CONSTANT String cs_ShipmentRole_Agent = "AGENT"
CONSTANT String cs_ShipmentRole_Forwarder = "FORWARDER"
CONSTANT String cs_ShipmentRole_any = "ANY REFERENCE"

CONSTANT String cs_Action_Arrive = "ARRIVE"
CONSTANT String cs_Action_Depart = "DEPART"
CONSTANT String cs_Action_Schedule = "SCHEDULE"
CONSTANT String cs_Action_Bill = "BILL"
CONSTANT String cs_Action_Pickedup = "PICKEDUP"
CONSTANT String cs_Action_Delivered = "DELIVERED"
CONSTANT String cs_Action_Update = "UPDATE"

CONSTANT STRING cs_transaction_INBOUND = "INBOUND"
CONSTANT STRING cs_transaction_OUTBOUND = "OUTBOUND"

Protected:
n_ds	ids_EdiEventCache, &
		ids_ProfileCache, &
		ids_PendingCache


string	isa_edi214code[]
string	isa_edi322code[]
Long		ila_EDICompId[]
Long		il_SourceShipmentID

n_Cst_beo_Shipment	inv_Shipment
n_Cst_bso_Dispatch	inv_Dispatch

Private:
Boolean	ib_DestroyDisp
Boolean	ib_DestroyShip
end variables

forward prototypes
public function datastore of_getcache (boolean ab_create)
private subroutine of_setcache (n_ds ads_edieventcache)
public function integer of_find (string as_findstring)
public function integer of_replacerowincache (datawindow adw_source, long al_row)
public function integer of_searchandreplaceduplicates (datawindow adw_source, long al_sourcerow)
private function integer of_removerowincache (long al_row)
public function integer of_saveeventcache ()
public function integer of_updatespending ()
public function boolean of_produce214file ()
public function integer of_viewpendingtransactions (n_cst_bso_dispatch anv_dispatch, long al_event)
public function integer of_newmessage (n_cst_msg anv_msg)
private function integer of_updatecache (n_ds ads_data, long al_row, long al_shipid)
public function long of_loadevent (long al_event, long al_row, ref n_ds ads_newevent)
public subroutine of_resetcache ()
public function long of_loadnewevent (n_cst_beo_event anv_event, ref n_ds ads_newevent)
public subroutine of_newmessage (n_cst_bso_dispatch anv_bso_dispatch, long al_event, string as_action)
public function integer of_getnotificationsetting (string as_action, string as_edi214code, ref string as_setting)
public function integer of_addtocache (ref n_ds ads_data, long al_shipid, string as_edi214code)
public function long of_getsourceshipmentid ()
public function integer of_setsourceshipmentid (long al_sourceshipmentid)
public function string of_getintermodalmovetype ()
public function integer of_updatelogcache (n_ds ads_data, long al_row)
protected function string of_getstatus (n_cst_beo_event anv_event, string as_action, long al_coid)
public function integer of_addtocache (ref n_ds ads_data, long al_shipid, long al_coid)
public subroutine of_removefromcache (n_ds ads_data, long al_coid)
public subroutine of_deletemessage (n_cst_bso_dispatch anv_dispatch, long al_event, string as_action)
public function n_ds of_getprofilecache ()
public function string of_getshipmentrole (n_cst_beo_company anv_company, long al_transactionset)
public function n_ds of_getpendingcache ()
public function boolean of_hasprofile (long al_transactionset, long al_company)
public function integer of_generate (long al_transactionset, long ala_id[])
public function integer of_createtransactionset (long al_set, ref n_cst_msg anv_msg)
public subroutine of_addtopendingcache (any aaa_beo[], string as_source, long al_transactionset, string as_action)
public function integer of_savependingcache ()
public subroutine of_resetpendingcache ()
public subroutine of_deletefrompendingcache (long al_transactionset, long ala_id[], string as_source)
public function long of_loadnewpendingevent (n_cst_beo_event anv_event, ref n_ds ads_newpendingevent)
public function integer of_showdetails (long al_row, long al_shipid)
public function long of_checkshipperediupdate (n_cst_bso_dispatch anv_dispatch, long al_event, boolean ab_creatingmessage)
public function integer of_edi214profile (n_cst_beo_event anv_event, n_cst_beo_shipment anv_shipment, ref long ala_coid[])
protected subroutine of_addtopendingcache (n_ds ads_edipending)
public function long of_checkshipperediupdate_van (n_cst_bso_dispatch anv_dispatch, long al_event)
public subroutine of_newmessage_van (n_cst_bso_dispatch anv_bso_dispatch, long al_event, string as_action)
public function integer of_newmessage_van (n_cst_msg anv_msg)
public function string of_getcontrolnumber ()
public function string of_appendtoprocessedlocationpath (string as_root)
private function boolean of_indatabaseedipendingtable (integer ai_transaction, long al_sourceid, string as_source, string as_action, datastore ads_databasecache)
end prototypes

public function datastore of_getcache (boolean ab_create);//IF isvalid(ids_EdiEventCache) THEN
//	//ALREADY CREATED
//ELSE
//	IF ab_Create THEN
//		
//		ids_EdiEventCache = CREATE n_ds
//		ids_EdiEventCache.DataObject = "d_Edi_EventCache"
//		ids_EdiEventCache.SetTransObject(SQLCA)
//		ids_EdiEventCache.retrieve()
//	END IF
//END IF
//Return ids_EdiEventCache

IF isvalid(ids_PendingCache) THEN
	//ALREADY CREATED
ELSE
	ids_PendingCache = CREATE n_ds

	n_cst_setting_edi204version	lnv_204Version
	lnv_204Version = create n_cst_setting_edi204version
	IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
		lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
		ids_PendingCache.DataObject = "d_EdiPending_ds"
	ELSE
		ids_PendingCache.DataObject =	"d_Edi_EventCache"
	END IF	
	destroy lnv_204Version	
	
//	ids_PendingCache.DataObject = "d_EdiPending_ds"
	ids_PendingCache.SetTransObject(SQLCA)
	ids_PendingCache.retrieve()
	commit;
END IF

Return ids_PendingCache

end function

private subroutine of_setcache (n_ds ads_edieventcache);ids_edieventcache = ads_edieventcache
end subroutine

public function integer of_find (string as_findstring);// RETURNS 	# < 0 for ERROR
//				 # >= 0  for the found row

Long		ll_FindRow
String	ls_FindString

n_ds	lds_Cache

ls_FindString	= as_findstring
lds_Cache = THIS.of_GetCache ( TRUE )


ll_FindRow = lds_Cache.Find ( ls_FindString , 1 ,9999 )

Return ll_FindRow


end function

public function integer of_replacerowincache (datawindow adw_source, long al_row);/*
The source should only have one row. this one row will replace the row 
specified in the cache. if the source has more than one row the first will be used.
*/
Int	li_Return
Long	ll_Row
DataWindow	ldw_Source
n_ds	lds_Cache


lds_Cache = THIS.of_GetCache ( TRUE )
ldw_Source = adw_Source
ll_Row = al_Row


IF NOT isValid ( ldw_Source ) AND NOT isValid ( lds_Cache ) THEN
	RETURN -1 																		///// EARLY RETURN
END IF

CHOOSE CASE ldw_Source.DataObject 
	CASE "d_shipmentstatus_list" , "d_shipmentstatus_details" , "d_edi_eventcache", "d_Edistatus_ds"
		//OK
	CASE ELSE
		// BAD STUFF
		messageBox ( "Replace Row in Cache" , "An error occurred while atrtempting to replace a row in the cache. ~r~n [wrong dataobject]" )
		RETURN -1																	///// EARLY RETURN
END CHOOSE

IF ll_Row > lds_Cache.RowCount ( ) OR ll_Row = 0 THEN
	RETURN -1																		///// EARLY RETURN
END IF

IF ldw_Source.RowCount ( ) < 1 THEN
	RETURN -1																		///// EARLY RETURN
END IF

IF lds_Cache.RowsDiscard ( ll_Row , ll_Row , PRIMARY! ) = 1 THEN
	IF ldw_Source.RowsCopy  (1, 1, PRIMARY!, lds_Cache, ll_Row, PRIMARY! ) = 1 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return
end function

public function integer of_searchandreplaceduplicates (datawindow adw_source, long al_sourcerow);/*
the source that is passed in should only contian 1 row because it will 
only focus on the first row.

THIS method look for dups among the 1 row passed in and the cache

*/
Long	ll_RowCount
String ls_FindString	
Long		ll_FindRtn
Long	ll_Status
Long	ll_Reason
Long	ll_EventID
String	ls_Processed
Date	ld_Date
Time	lt_Time
Long	ll_Rtn = 1

DataWindow	ldw_Source
n_ds			lds_Cache

lds_Cache  = THIS.of_GetCache ( TRUE )

ldw_Source = adw_Source
IF Not IsValid ( ldw_Source ) THEN
	RETURN -1 								//////  EARLY RETURN
END IF

ll_RowCount = ldw_Source.RowCount ( )

IF ll_RowCount < 1 THEN 
	RETURN -1								//////  EARLY RETURN
END IF

ll_EventID = ldw_Source.GetItemNumber ( 1 ,  "disp_events_de_id" )
ll_Status = ldw_Source.GetItemNumber ( 1 ,  "shipment_status_edi_status_id" )
	
ls_FindString = "shipment_status_edi_status_id = " + String ( ll_Status ) + " AND disp_events_de_id = " + String ( ll_EventID ) 

ll_FindRtn = THIS.of_Find ( ls_FindString ) 		

ll_Reason  = ldw_Source.GetItemNumber ( 1 ,  "shipment_status_edi_reason_id" )
//ll_Status = ldw_Source.GetItemNumber ( 1 ,  "shipment_status_edi_status_id" )
ls_Processed = ldw_Source.GetItemString ( 1 ,  "shipment_status_processed" )
ld_Date = ldw_Source.GetItemDate ( 1 ,  "shipment_status_status_date" )
lt_Time = ldw_Source.GetItemTime ( 1 ,  "shipment_status_status_time" )

IF ll_FindRtn > 0 THEN
	// replace row that was found in the cache
	lds_Cache.SetItem ( ll_FindRtn , "shipment_status_edi_reason_id" , ll_Reason )
	lds_Cache.SetItem ( ll_FindRtn , "shipment_status_edi_status_id" , ll_Status )
	lds_Cache.SetItem ( ll_FindRtn , "shipment_status_processed", ls_Processed )
	lds_Cache.SetItem ( ll_FindRtn , "shipment_status_status_date", ld_Date )
	lds_Cache.SetItem ( ll_FindRtn , "shipment_status_status_time", lt_Time )
	
	MessageBox ("Duplicate Info" , "A message of this type already exists. It will be replaced.")

	// if i found the row then i don't want to keep the one that the edi manager gave to me
	IF ll_FindRtn <> al_SourceRow THEN
		of_RemoveRowInCache ( al_SourceRow )
	END IF
ELSE 
	
	lds_Cache.SetItem ( al_SourceRow , "shipment_status_edi_reason_id" , ll_Reason )
	lds_Cache.SetItem ( al_SourceRow , "shipment_status_edi_status_id" , ll_Status )
	lds_Cache.SetItem ( al_SourceRow , "shipment_status_processed", ls_Processed )
	lds_Cache.SetItem ( al_SourceRow , "shipment_status_status_date", ld_Date )
	lds_Cache.SetItem ( al_SourceRow , "shipment_status_status_time", lt_Time )
	
END IF

RETURN ll_Rtn

end function

private function integer of_removerowincache (long al_row);
Int	li_Return = 1
Long	ll_Row
n_ds	lds_Cache

lds_Cache = THIS.of_GetCache ( TRUE )
ll_Row = al_Row

IF NOT isValid ( lds_Cache ) THEN
	RETURN -1 																		///// EARLY RETURN
END IF

IF ll_Row > lds_Cache.RowCount ( ) OR ll_Row = 0 THEN
	RETURN -1																		///// EARLY RETURN
END IF

IF lds_Cache.RowsDiscard ( ll_Row , ll_Row , PRIMARY! ) <> 1 THEN
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_saveeventcache ();integer	li_return = 1

n_ds	lds_EdiEventCache
		
lds_EdiEventCache = this.of_GetCache(TRUE)

if lds_edieventcache.rowcount() > 0 then
 	if lds_edieventcache.update() <> 1 then
		li_return = -1 
	else
		li_return = 1
	end if
end if

return li_return
end function

public function integer of_updatespending ();//integer	li_return
//if isvalid(ids_edieventcache) then
//	if ids_edieventcache.rowcount() > 0 THEN
//		li_return = 1 
//	end if
//end if
//replaced with

integer	li_return
if isvalid(ids_Pendingcache) then
	if ids_PendingCache.modifiedcount() > 0 THEN
		li_return = 1 
	end if
end if
return li_return

end function

public function boolean of_produce214file ();Integer	li_Return
boolean	lb_producefile
string	ls_producefile
any		la_value

n_cst_settings lnv_Settings
n_cst_string	lnv_string

li_Return = 1

IF lnv_Settings.of_GetSetting ( 84 , la_value ) <> 1 THEN
	li_Return = -1
else
	IF STRING ( la_Value ) = "YES!" THEN
		lb_producefile = true
	else
		lb_producefile = false
	end if
END IF

return lb_producefile
end function

public function integer of_viewpendingtransactions (n_cst_bso_dispatch anv_dispatch, long al_event);long		lla_event[], &
			ll_shipid

string	ls_filter

boolean	lb_direct

w_ShipmentStatus_List		lw_status
w_ShipmentStatus_List_van	lw_status_van
		
n_cst_beo_event		lnv_event
n_cst_beo_shipment	lnv_shipment

n_cst_sql	lnv_sql
n_ds			lds_Cache
S_Parm		lstr_Parm
n_cst_Msg	lnv_Msg
n_cst_setting_edi204version	lnv_204Version

lnv_204Version = CREATE n_cst_setting_edi204version
IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
	lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
	//ok
	lb_direct = true
ELSE
	lb_direct = false
END IF	
DESTROY ( lnv_204Version )

lds_cache = this.of_getPendingcache()

lnv_Event = CREATE n_cst_beo_Event
lnv_Shipment = create n_cst_beo_Shipment

inv_dispatch = anv_dispatch

lnv_Event.of_SetSource ( inv_dispatch.of_GetEventCache ( ) )
lnv_Event.of_SetSourceId ( al_event )

IF lnv_Event.of_HasSource ( ) THEN
	ll_shipid = lnv_Event.of_getshipment()
	lnv_Shipment.of_SetSource ( inv_Dispatch.of_GetShipmentCache ( ) )
	lnv_Shipment.of_SetEventsource( inv_dispatch.of_GetEventCache ( ) )
	lnv_Shipment.of_SetSourceId ( ll_shipid )
	if lnv_shipment.of_HasSource( ) then
		lnv_Shipment.of_GetEventIds(lla_event)
		ls_filter = 'sourceid ' + lnv_sql.of_makeinclause(lla_event)
		lds_Cache.setfilter(ls_filter)
		lds_Cache.filter()
	end if
end if

IF lds_Cache.rowcount() > 0 THEN
	
	lstr_Parm.is_Label = "EDIMANAGER"
	lstr_Parm.ia_Value = THIS
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "CACHE"
	lstr_Parm.ia_Value = lds_cache
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	if lb_direct then
		openWithParm ( lw_status , lnv_Msg )
	else
		openWithParm ( lw_status_van , lnv_Msg )
	end if
	
	
END IF

RETURN 1

end function

public function integer of_newmessage (n_cst_msg anv_msg);Long	ll_EventID, &
		ll_shipid, &
		ll_Return = 1, &
		lla_coid[], &
		ll_count, &
		ll_ndx
		
boolean	lb_redirect		
		
n_ds	lds_Data
n_ds	lds_rtnData
n_cst_beo_event	lnv_event
n_cst_bso_dispatch	lnv_dispatch

n_cst_setting_edi204version	lnv_204Version

lnv_204Version = CREATE n_cst_setting_edi204version
IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
	lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
	//ok
ELSE
	//redirect to old logic
	ll_return = this.of_Newmessage_van( anv_msg)
	lb_redirect = true
END IF	
DESTROY ( lnv_204Version )

if lb_redirect then
	//*********************** mid code return ***********************//
	return ll_return
end if 

lnv_event = CREATE n_cst_beo_Event

if ll_return = 1 then
	n_cst_Msg	lnv_Msg
	S_Parm		lstr_Parm
	
	IF anv_Msg.of_Get_Parm ( "EVENTID" , lstr_parm ) <> 0 THEN
		ll_EventID	= lstr_Parm.ia_Value
	END IF
	
	IF anv_Msg.of_Get_Parm ( "DISPATCH" , lstr_parm ) <> 0 THEN
		lnv_dispatch	= lstr_Parm.ia_Value
	END IF

	lnv_Event.of_SetSource ( lnv_dispatch.of_GetEventCache ( ) )
	lnv_Event.of_SetSourceId ( ll_EventID )
	
	IF lnv_Event.of_HasSource ( ) THEN
		ll_shipid = lnv_Event.of_getshipment()
		
		if isnull(ll_shipid ) or ll_shipid = 0 then
			//edi update is only for shipment events
			ll_return = -1
		else
			//load shipment to cache
			lnv_dispatch.of_retrieveshipments({ll_shipid})
			THIS.of_LoadNewPendingEvent ( lnv_event , lds_Data )
		end if
	END IF
	
	if ll_return = 1 then
		
		lstr_parm.is_Label = "DISPATCH"
		lstr_Parm.ia_Value = lnv_Dispatch
		lnv_Msg.of_Add_Parm ( lstr_Parm ) 
		
		lstr_parm.is_Label = "DATA"
		lstr_Parm.ia_Value = lds_Data
		lnv_Msg.of_Add_Parm ( lstr_Parm ) 
		
		lstr_parm.is_Label = "NEW"
		lstr_Parm.ia_Value = TRUE
		lnv_Msg.of_Add_Parm ( lstr_Parm ) 
		
		if this.of_CheckShipperEDIUpdate(lnv_dispatch, ll_EventID, true) = 1 then
			lstr_parm.is_Label = "COMPANY"
			lstr_Parm.ia_Value = ila_EDICompId
			lnv_Msg.of_Add_Parm ( lstr_Parm ) 
			
			OpenWithParm ( w_shipmentStatus_details , lnv_Msg )
			
			IF IsValid( Message.PowerObjectParm ) Then 
				lnv_Msg = Message.powerobjectParm
				IF lnv_Msg.of_Get_Parm ( "DATA" , lstr_Parm ) <> 0 THEN
					lds_rtnData = lstr_Parm.ia_Value
				END IF
			end if		
			
			IF IsValid ( lds_rtnData ) THEN
				//send message immediately for selected companies
				IF lnv_Msg.of_Get_Parm ( "COMPANYSELECTED" , lstr_Parm ) <> 0 THEN
					lla_coid = lstr_Parm.ia_Value
				END IF
				ll_count = upperbound(lla_coid)
				for ll_ndx = 1 to ll_count
					if ll_ndx = 1 then
						lds_rtnData.object.company[1] = lla_coid[ll_ndx]
					else
						lds_rtnData.rowscopy( 1, 1, Primary!, lds_rtnData, 9999, primary!)
						lds_rtnData.object.company[lds_rtnData.rowcount()] = lla_coid[ll_ndx]
					end if	
				next
				
				if ll_count > 0 then
					THIS.of_AddToPendingCache ( lds_rtnData )
				end if

			END IF
				
		else
			
			messagebox('EDI Status', 'There were no EDI 214 profiles found for the companies on this shipment and event')
		
		end if	

		
	else
		ll_return = -1
	end if

end if

DESTROY ( lnv_event )

RETURN ll_return 



end function

private function integer of_updatecache (n_ds ads_data, long al_row, long al_shipid);/*
the source that is passed in should only contian 1 row because it will 
only focus on the first row.

THIS method look for dups among the 1 row passed in and the cache

*/

Long		ll_Status
Long		ll_Reason
Long		ll_EventID
Long		ll_arraycount
Long		ll_index
String	ls_EventType
String	ls_Processed
Date		ld_Date
Time		lt_Time
Long		ll_Rtn = 1

n_ds			lds_Source
n_ds			lds_Cache

lds_Source = ads_Data
lds_Cache  = THIS.of_GetCache ( TRUE )

IF Not IsValid ( lds_Source ) THEN
	RETURN -1 								//////  EARLY RETURN
END IF

IF lds_Source.RowCount ( ) < 1 THEN 
	RETURN -1								//////  EARLY RETURN
END IF

IF al_Row < 1 OR  al_Row > lds_Cache.RowCount( ) THEN
	RETURN -1 								//////  EARLY RETURN
END IF

ll_EventID = lds_Source.GetItemNumber ( 1 ,  "shipment_status_eventid" )
ll_Status = lds_Source.GetItemNumber ( 1 ,  "shipment_status_edi_status_id" )
ll_Reason  = lds_Source.GetItemNumber ( 1 ,  "shipment_status_edi_reason_id" )
ls_EventType = lds_Source.GetItemString ( 1 ,  "event_type" )
ls_Processed = lds_Source.GetItemString ( 1 ,  "shipment_status_processed" )
ld_Date = lds_Source.GetItemDate ( 1 ,  "shipment_status_status_date" )
lt_Time = lds_Source.GetItemTime ( 1 ,  "shipment_status_status_time" )	

ll_arraycount = upperbound(isa_edi214code)
for ll_index = 1 to ll_arraycount
	// replace row that was found in the cache
	lds_Cache.SetItem ( al_Row , "event_type" , ls_EventType )
	lds_Cache.SetItem ( al_Row , "shipment_status_eventid" , ll_EventID )
	lds_Cache.SetItem ( al_Row , "shipment_status_edi_214_code", isa_edi214code[ll_index] )
	lds_Cache.SetItem ( al_Row , "shipment_status_edi_reason_id" , ll_Reason )
	lds_Cache.SetItem ( al_Row , "shipment_status_edi_status_id" , ll_Status )
	lds_Cache.SetItem ( al_Row , "shipment_status_processed", ls_Processed )
	lds_Cache.SetItem ( al_Row , "shipment_status_status_date", ld_Date )
	lds_Cache.SetItem ( al_Row , "shipment_status_status_time", lt_Time )
	lds_Cache.SetItem ( al_Row , "disp_events_de_shipment_id", al_shipid)
	
	MessageBox ("Duplicate Info" , "A message of this type already exists. It will be replaced.")
next

if isvalid(lds_Source) then
	destroy lds_Source
end if

RETURN ll_Rtn

end function

public function long of_loadevent (long al_event, long al_row, ref n_ds ads_newevent);long		ll_Return

n_ds	lds_EdiNewEvent, &
		lds_EventCache
		
n_cst_events lnv_EventType

//load the cache to the instance variable
lds_EventCache = this.of_GetpendingCache()
		
lds_EdiNewEvent = CREATE n_ds
//lds_EdiNewEvent.DataObject = "d_Edi_EventCache"
lds_EdiNewEvent.DataObject = "d_EdiPending_ds"
lds_EdiNewEvent.SetTransObject(SQLCA)

lds_EventCache.RowsCopy (al_row, al_row, Primary!, lds_EdiNewEvent, 1, 	Primary! )

ads_newevent = lds_EdiNewEvent

Return ll_Return

end function

public subroutine of_resetcache ();destroy ids_edieventcache
this.of_getcache(true)
end subroutine

public function long of_loadnewevent (n_cst_beo_event anv_event, ref n_ds ads_newevent);long		ll_row, &
			ll_Return

n_ds	lds_EdiNewEvent
		
IF Not IsValid ( anv_Event ) THEN
	RETURN -1
END IF
		
//load the cache to the instance variable
this.of_GetCache(TRUE)
				
lds_EdiNewEvent = CREATE n_ds
lds_EdiNewEvent.DataObject = "d_Edi_EventCache"
lds_EdiNewEvent.SetTransObject(SQLCA)
ll_row = lds_EdiNewEvent.InsertRow(0)

lds_EdiNewEvent.object.shipment_status_eventid[ll_row] = anv_event.of_getid()
lds_EdiNewEvent.object.event_type[ll_row] = anv_event.of_gettype()

ads_newevent = lds_EdiNewEvent

Return ll_Return

end function

public subroutine of_newmessage (n_cst_bso_dispatch anv_bso_dispatch, long al_event, string as_action);//Revised for 3.5.23 3-12-2003 by BKW to allow for EDI 322 off a non-shipment event.

long	ll_shipid, &
		ll_statusid, &
		ll_index, &
		ll_arraycount, &
		ll_322Status, &
		ll_322EquipmentStatus

string	ls_eventtype, &
			ls_action, &
			ls_setting, &
			ls_322Status, &
			ls_MessageHeader, &
			ls_Intermodal, &
			ls_billto, &
			ls_report
			
date		ld_event

time		lt_event

Boolean	lb_Has214, &
			lb_Has322, &
			lb_214Pending, &
			lb_322Pending, &
			lb_ShipmentEvent, &
			lb_Continue = TRUE, &
			lb_Retry, &
			lb_Tag, &
			lb_redirect

n_cst_events 			lnv_Events
n_cst_bso_dispatch	lnv_dispatch
n_cst_beo_event		lnv_event
n_cst_beo_Company		lnv_Site

n_ds						lds_newconfirmedevent

n_cst_LicenseManager	lnv_LicenseManager
n_cst_Selection		lnv_Selection
Any						laa_SelectionArgs[20], &
							laa_EmptyArgs[20], &
							laa_SelectionResults[]


n_cst_setting_edi204version	lnv_204Version

lnv_204Version = CREATE n_cst_setting_edi204version
IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
	lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
	//ok
ELSE
	//redirect to old logic
	this.of_Newmessage_van( anv_bso_dispatch, al_event, as_action)
	lb_redirect = true
END IF	
DESTROY ( lnv_204Version )

if lb_redirect then
	//*********************** mid code return ***********************//
	return 
end if 

lb_Has214 = lnv_LicenseManager.of_HasEDI214License ( )
lb_Has322 = lnv_LicenseManager.of_HasEDI322License ( )

setnull(ls_action)
setnull(ll_statusid)

lnv_event = CREATE n_cst_beo_event

lnv_dispatch = anv_bso_dispatch

lnv_Event.of_SetSource ( lnv_dispatch.of_GetEventCache ( ) )
lnv_Event.of_SetSourceId ( al_event )


IF lb_Continue THEN

	IF lnv_Event.of_HasSource ( ) THEN
	
		ll_ShipId = lnv_Event.of_GetShipment ( )

		if isnull(ll_shipid) or ll_shipid = 0 then

			lb_ShipmentEvent = FALSE

			//edi 214 update is only for shipment events.

			//In 3.5.23, we changed this to allow non-shipment 322 update.
			//So, lb_322Pending is determined by other criteria.  BKW

			lb_214Pending = FALSE

		else

			lb_ShipmentEvent = TRUE

			if lb_Has214 THEN

				lb_214Pending = TRUE  //Just an indication that it's a candidate, at this point.

			else
	
				lb_214Pending = FALSE
	
			end if

		end if
	
	ELSE
		lb_Continue = FALSE
	
	END IF

END IF



//If EDI322 is licensed and we're departing (confirming) the event, check to see if the site of the 
//event is an EDI322 site location.
//If not, a 322 message will not be applicable to this event.

IF lb_Continue AND lb_Has322 AND Upper ( as_Action ) = "DEPART" THEN

	IF lnv_Event.of_GetSite ( lnv_Site ) = 1 THEN

		IF lnv_Site.of_IsEDI322Site ( ) THEN

			lb_322Pending = TRUE

		END IF

	END IF

END IF



IF lb_Continue THEN

	IF lb_214Pending OR lb_322Pending THEN
		//OK, we potentially have something to generate.
	ELSE
		//Notification possibilities eliminated.
		lb_Continue = FALSE
	END IF

END IF


IF lb_Continue THEN

	//if it's a shipment event, load the shipment to cache

	IF lb_ShipmentEvent THEN
		lnv_dispatch.of_retrieveshipments ( { ll_ShipId } )   //Is this really needed?? -- it's done inside 
																				//of_CheckShipperEDIUpdate, too.   --BKW
	END IF

	if this.of_CheckShipperEDIUpdate(lnv_dispatch, al_event, true) = 1 then  //Loads the list of 214 and 322 codes to notify

		//OK

	ELSE

		lb_Continue = FALSE

	END IF

END IF


IF lb_Continue AND lb_214Pending THEN

	this.of_addtoPendingCache( {lnv_event}, 'EVENT', cl_transaction_set_214, as_action)

END IF

IF lb_Continue AND lb_322Pending THEN

	ll_arraycount = upperbound(isa_edi322code)

	IF ll_ArrayCount > 0 THEN

		//Try to get a value for the status header (EDI322:Q501 field)

		ls_MessageHeader = "EDI 322 Status Header"

		//Initialize the selection args with the segment and element values, which will be used as retrieval 
		//arguments in d_edi_status_selection

		laa_SelectionArgs = laa_EmptyArgs
		laa_SelectionArgs [ 1 ] = "Q5"
		laa_SelectionArgs [ 2 ] = "01"

		DO

			lb_Retry = FALSE

			CHOOSE CASE lnv_Selection.of_Open ( "d_edi_status_selection", laa_SelectionResults, SQLCA, { "id" }, &
				laa_SelectionArgs, ls_MessageHeader )
	
			CASE 1
				ll_322Status = laa_SelectionResults [ 1 ]   //edi_status.id for the Q501 field
	
			CASE IS > 1
				MessageBox ( ls_MessageHeader, "Too many selections -- Please retry." )
				lb_Retry = TRUE
	
			CASE 0
				CHOOSE CASE  MessageBox ( ls_MessageHeader, "Are you sure you want to cancel?  This means no EDI 322 message will be sent.", &
					Exclamation!, YesNo!, 1 )

				CASE 1  //Yes - cancel.
					//leave lb_Retry = FALSE

				CASE 2  //No - don't cancel.
					lb_Retry = TRUE

				CASE ELSE  //Unexpected return
					lb_Retry = TRUE

				END CHOOSE

			CASE ELSE  //Unexpected return

				CHOOSE CASE MessageBox ( ls_MessageHeader, "Error determining EDI 322 code selection.", Exclamation!, &
					RetryCancel!, 1 )

				CASE 1  //Retry
					lb_Retry = TRUE 

				CASE 2  //Cancel
					//leave lb_Retry = FALSE

				CASE ELSE  //Unexpected return
					lb_Retry = TRUE

				END CHOOSE

			END CHOOSE

		LOOP UNTIL lb_Retry = FALSE


		//If the status header (EDI322:Q501 field) was selected, now ask for the status detail (EDI322:W205).

		IF ll_322Status > 0 THEN

			ls_MessageHeader = "EDI 322 Status Detail"

			//Initialize the selection args with the segment and element values, which will be used as retrieval 
			//arguments in d_edi_status_selection
			laa_SelectionArgs = laa_EmptyArgs
			laa_SelectionArgs [ 1 ] = "W2"
			laa_SelectionArgs [ 2 ] = "05"	

			DO
	
				lb_Retry = FALSE
	
				CHOOSE CASE lnv_Selection.of_Open ( "d_edi_status_selection", laa_SelectionResults, SQLCA, { "id" }, &
					laa_SelectionArgs, ls_MessageHeader )
		
				CASE 1
					ll_322EquipmentStatus = laa_SelectionResults [ 1 ]  //edi_status.id for the W205 field
		
				CASE IS > 1
					MessageBox ( ls_MessageHeader, "Too many selections -- Please retry." )
					lb_Retry = TRUE
		
				CASE 0
					CHOOSE CASE  MessageBox ( ls_MessageHeader, "Are you sure you want to cancel?  This means no EDI 322 message will be sent.", &
						Exclamation!, YesNo!, 1 )
	
					CASE 1  //Yes - cancel.
						//leave lb_Retry = FALSE
	
					CASE 2  //No - don't cancel.
						lb_Retry = TRUE
	
					CASE ELSE  //Unexpected return
						lb_Retry = TRUE
	
					END CHOOSE
	
				CASE ELSE  //Unexpected return
	
					CHOOSE CASE MessageBox ( ls_MessageHeader, "Error determining EDI 322 code selection.", Exclamation!, &
						RetryCancel!, 1 )
	
					CASE 1  //Retry
						lb_Retry = TRUE 
	
					CASE 2  //Cancel
						//leave lb_Retry = FALSE
	
					CASE ELSE  //Unexpected return
						lb_Retry = TRUE
	
					END CHOOSE
	
				END CHOOSE
	
			LOOP UNTIL lb_Retry = FALSE

		END IF


		IF ll_322Status > 0 AND ll_322EquipmentStatus > 0 THEN
			//OK -- selection made
		ELSE
			lb_322Pending = FALSE
		END IF

	END IF

END IF


IF lb_Continue AND lb_322Pending THEN

	for ll_index = 1 to ll_arraycount

		this.of_loadnewevent(lnv_Event, lds_newconfirmedevent)	
		lds_newconfirmedevent.object.shipment_status_edi_status_id[1] = ll_322Status
		lds_newconfirmedevent.object.shipment_status_edi_reason_id[1] = ll_322EquipmentStatus
		lds_newconfirmedevent.object.shipment_status_status_date[1] = lnv_Event.of_GetDateDeparted ( )
		lds_newconfirmedevent.object.shipment_status_status_time[1] = lnv_Event.of_GetTimeDeparted ( )
		this.of_Addtocache(lds_newconfirmedevent, ll_shipid, isa_edi322code[ll_index])
		DESTROY lds_newconfirmedevent

	next

END IF  //End 322


DESTROY lnv_event
end subroutine

public function integer of_getnotificationsetting (string as_action, string as_edi214code, ref string as_setting);long		ll_find, &
			ll_rowcount, &
			ll_coid
			
string	ls_findstring, &
			ls_type = "EDI214"

integer	li_return=1

n_ds	lds_notificationsettings
													
lds_notificationsettings = CREATE n_ds
lds_notificationsettings.DataObject = "d_notificationsettings"
lds_notificationsettings.SetTransObject(SQLCA)
ll_rowcount = lds_notificationsettings.retrieve()

	 SELECT "companies"."co_id"  
    INTO :ll_coid  
    FROM "companies"  
   WHERE "companies"."edi214code" = :as_edi214code   ;

	commit;
	
if ll_coid > 0 then
	ls_findstring = "transfertype = '" + ls_type + "' and direction = 'O' and companyid = " + &
						string(ll_coid) + " and action = '" + as_action + "'"
	
	ll_find = lds_notificationsettings.find(ls_findstring,1,ll_rowcount)
	if ll_find > 0 then
		as_setting = lds_notificationsettings.object.setting[ll_find]
	else
		li_return = -1
	end if
else
	li_return = -1
end if

destroy lds_notificationsettings

return li_return
end function

public function integer of_addtocache (ref n_ds ads_data, long al_shipid, string as_edi214code);/*
the source that is passed in should only contian 1 row because it will 
only focus on the first row.

THIS method look for dups among the 1 row passed in and the cache

*/
Long	ll_RowCount
String ls_FindString	
Long		ll_FindRtn
Long	ll_Status
Long	ll_Reason
Long	ll_EventID
String	ls_EventType
String	ls_Processed
Date	ld_Date
Time	lt_Time
Long	ll_NewRow
Long	ll_Rtn = 1

n_ds			lds_Source
n_ds			lds_Cache

lds_Cache  = THIS.of_GetCache ( TRUE )

lds_Source = ads_Data
IF Not IsValid ( lds_Source ) THEN
	RETURN -1 								//////  EARLY RETURN
END IF

ll_RowCount = lds_Source.RowCount ( )

IF ll_RowCount < 1 THEN 
	RETURN -1								//////  EARLY RETURN
END IF

ll_EventID = lds_Source.GetItemNumber ( 1 ,  "shipment_status_eventid" )
ll_Status = lds_Source.GetItemNumber ( 1 ,  "shipment_status_edi_status_id" )
ll_Reason  = lds_Source.GetItemNumber ( 1 ,  "shipment_status_edi_reason_id" )
ls_EventType = lds_Source.GetItemString ( 1 ,  "event_type" )
ls_Processed = lds_Source.GetItemString ( 1 ,  "shipment_status_processed" )
ld_Date = lds_Source.GetItemDate ( 1 ,  "shipment_status_status_date" )
lt_Time = lds_Source.GetItemTime ( 1 ,  "shipment_status_status_time" )	
ls_FindString = "shipment_status_edi_status_id = " + String ( ll_Status ) + &
					" AND shipment_status_eventid = " + String ( ll_EventID ) + &
					" AND shipment_status_edi_214_code = '" + as_edi214code + "'"

ll_FindRtn = THIS.of_Find ( ls_FindString ) 		
IF ll_FindRtn > 0 THEN
	// replace row that was found in the cache
	lds_Cache.SetItem ( ll_FindRtn , "event_type" , ls_EventType )
	lds_Cache.SetItem ( ll_FindRtn , "shipment_status_eventid" , ll_EventID )
	lds_Cache.SetItem ( ll_FindRtn , "shipment_status_edi_reason_id" , ll_Reason )
	lds_Cache.SetItem ( ll_FindRtn , "shipment_status_edi_status_id" , ll_Status )
	lds_Cache.SetItem ( ll_FindRtn , "shipment_status_processed", ls_Processed )
	lds_Cache.SetItem ( ll_FindRtn , "shipment_status_status_date", ld_Date )
	lds_Cache.SetItem ( ll_FindRtn , "shipment_status_status_time", lt_Time )
	lds_Cache.SetItem ( ll_FindRtn , "disp_events_de_shipment_id", al_shipid)
	
//test message	
//	MessageBox ("Duplicate Info" , "A message of this type already exists. It will be replaced.")

	
ELSE 
	ll_NewRow = lds_Cache.InsertRow ( 0 )
	
	lds_Cache.SetItem ( ll_NewRow , "event_type" , ls_EventType )
	lds_Cache.SetItem ( ll_NewRow , "shipment_status_eventid" , ll_EventID )
	lds_Cache.SetItem ( ll_NewRow , "shipment_status_edi_214_code", as_edi214code )
	lds_Cache.SetItem ( ll_NewRow , "shipment_status_edi_reason_id" , ll_Reason )
	lds_Cache.SetItem ( ll_NewRow , "shipment_status_edi_status_id" , ll_Status )
	lds_Cache.SetItem ( ll_NewRow , "shipment_status_processed", ls_Processed )
	lds_Cache.SetItem ( ll_NewRow , "shipment_status_status_date", ld_Date )
	lds_Cache.SetItem ( ll_NewRow , "shipment_status_status_time", lt_Time )
	lds_Cache.SetItem ( ll_NewRow , "disp_events_de_shipment_id", al_shipid)
	
END IF

if isvalid(ads_data) then
	DESTROY ads_data
end if

RETURN ll_Rtn

end function

public function long of_getsourceshipmentid ();RETURN il_sourceshipmentid
end function

public function integer of_setsourceshipmentid (long al_sourceshipmentid);il_sourceshipmentid = al_sourceshipmentid

IF not isValid ( inv_Dispatch ) THEN
	inv_dispatch = CREATE n_cst_bso_Dispatch 
	ib_destroydisp = TRUE
END IF

inv_Dispatch.of_Retrieveshipment( il_sourceshipmentid )

IF Not isValid ( inv_shipment ) THEN
	inv_SHipment = CREATE n_cst_beo_Shipment 
	ib_Destroyship = TRUE
END IF

inv_Shipment.of_SetSource ( inv_Dispatch.of_GetShipmentCache ( ) )
inv_Shipment.of_SetSourceID ( il_sourceshipmentid )
inv_SHipment.of_SetEventsource( inv_dispatch.of_geteventcache( ) )
inv_SHipment.of_SetItemsource( inv_dispatch.of_getItemcache( ) )




RETURN 1
end function

public function string of_getintermodalmovetype ();string	ls_MoveCode, &
			ls_Intermodal
			
if isvalid(inv_Shipment) then
	if inv_Shipment.of_IsIntermodal() then
		ls_MoveCode = inv_Shipment.of_GetMoveCode()
		choose case ls_MoveCode
			case gc_Dispatch.cs_MoveCode_Export
				ls_Intermodal = 'OUTBOUND'
			case gc_Dispatch.cs_MoveCode_Import
				ls_Intermodal = 'INBOUND'					
			case else
				ls_Intermodal = ''
		end choose
	end if
else
	ls_Intermodal = ''
end if

return ls_intermodal
end function

public function integer of_updatelogcache (n_ds ads_data, long al_row);/*
the source that is passed in should only contian 1 row because it will 
only focus on the first row.

THIS method look for dups among the 1 row passed in and the cache

*/

String	ls_Status
string	ls_Reason
Long		ll_EventID
Long		ll_arraycount
Long		ll_index
String	ls_EventType
String	ls_Processed
Date		ld_Date
Time		lt_Time
Long		ll_Rtn = 1

n_ds			lds_Source
n_ds			lds_Cache

lds_Source = ads_Data
lds_Cache  = THIS.of_GetCache ( TRUE )

IF Not IsValid ( lds_Source ) THEN
	RETURN -1 								//////  EARLY RETURN
END IF

IF lds_Source.RowCount ( ) < 1 THEN 
	RETURN -1								//////  EARLY RETURN
END IF

IF al_Row < 1 OR  al_Row > lds_Cache.RowCount( ) THEN
	RETURN -1 								//////  EARLY RETURN
END IF

ll_EventID = lds_Source.GetItemNumber ( 1 ,  "edi_sourceid" )
ls_Status = lds_Source.GetItemString ( 1 ,  "edistatus_status" )
ls_Reason  = lds_Source.GetItemString ( 1 ,  "edistatus_reason" )
ld_Date = lds_Source.GetItemDate ( 1 ,  "edistatus_statusdate" )
lt_Time = lds_Source.GetItemTime ( 1 ,  "edistatus_statustime" )	

ll_arraycount = upperbound(isa_edi214code)
for ll_index = 1 to ll_arraycount
	// replace row that was found in the cache
//	lds_Cache.SetItem ( al_Row , "shipment_status_edi_214_code", isa_edi214code[ll_index] ) //company
	lds_Cache.SetItem ( al_Row , "edistatus_reason" , ls_Reason )
	lds_Cache.SetItem ( al_Row , "edistatus_status" , ls_Status )
	lds_Cache.SetItem ( al_Row , "edistatus_statusdate", ld_Date )
	lds_Cache.SetItem ( al_Row , "edistatus_statustime", lt_Time )
	
	MessageBox ("Duplicate Info" , "A message of this type already exists. It will be replaced.")
next

if isvalid(lds_Source) then
	destroy lds_Source
end if

RETURN ll_Rtn

end function

protected function string of_getstatus (n_cst_beo_event anv_event, string as_action, long al_coid);//not used anymore, old school edi
string	ls_status, &
			ls_arrive, &
			ls_depart, &
			ls_role, &
			ls_eventtype, &
			ls_SiteType, &
			ls_Intermodal, &
			ls_Billto, &
			ls_report

long		ll_Company
boolean	lb_tag	

n_cst_events	lnv_events

ls_eventtype = anv_event.of_gettype()
ll_company = anv_event.of_Getsite()

this.of_SetSourceShipmentId(anv_event.of_getshipment())
//ls_intermodal = this.of_GetIntermodalMovetype() // INBOUND OUTBOUND
ls_intermodal = inv_Shipment.of_GetMoveCode()
if lnv_Events.of_IsTypePickupGroup ( ls_EventType ) THEN
	IF ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI214", "PICKUPGROUP", "" ) = "0" THEN
		ls_eventtype = lnv_Events.of_GetTypeDisplayValue(ls_EventType)
	END IF
else
	if lnv_Events.of_IsTypeDeliverGroup ( ls_EventType ) THEN
		IF ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI214", "DELIVERGROUP", "" ) = "0" THEN
			ls_eventtype = lnv_Events.of_GetTypeDisplayValue(ls_EventType)
		END IF
	end if
end if

	
IF ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI214", "TAGORIGDEST", "" ) = "1" THEN
	lb_Tag = TRUE
ELSE
	lb_Tag = FALSE
END IF

IF anv_Event.of_GetSite() = inv_Shipment.of_GetOrigin() THEN
	IF lb_Tag THEN
		ls_SiteType = 'ORIG'
	END IF
ELSE 
	IF anv_Event.of_GetSite() = inv_Shipment.of_GetDestination() THEN
		IF lb_Tag THEN
			ls_SiteType = 'DEST'
		END IF
	ELSE
		//if a company needs to be reported to for non origin/destination events,
		//their sysid needs to be in the trucking.ini file
		//default don't report
		ls_billto = string(inv_Shipment.of_GetBillto())
		ls_report = ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI214NONORIGDEST", ls_billto, "" )
		IF len(ls_report) > 0 THEN
			//report, notice these tags don't have 'orig' or 'dest'
		ELSE
			//don't report
//			setnull(ls_action)
		END IF
	END IF
END IF

			
//  SELECT "edistatusprofile"."arrivestatus",   
//         "edistatusprofile"."departstatus",   
//         "edistatusprofile"."statusrole"  
//    INTO :ls_arrive,
//	 		:ls_depart, 
//			:ls_role
//    FROM "ediprofile",   
//         "edistatusprofile"  
//   WHERE ( "ediprofile"."companyid" = "edistatusprofile"."companyid" ) and  
//         ( "ediprofile"."transactionset" = "edistatusprofile"."transactionset" )
//			and "ediprofile"."companyid" = :al_CoId and "edistatusprofile"."transactionset" = 214
//			and "edistatusprofile"."eventtype" = :ls_eventtype and "edistatusprofile"."movecode" = :ls_intermodal
//			and "edistatusprofile"."sitetype" = :ls_SiteType ;
//
//	commit;

choose case upper(as_action)
	case 'ARRIVE'
		ls_status = ls_arrive
	case 'DEPART'
		ls_status = ls_depart
		
end choose

return ls_status
end function

public function integer of_addtocache (ref n_ds ads_data, long al_shipid, long al_coid);//this method added for new EDI logic
/*
the source that is passed in should only contian 1 row because it will 
only focus on the first row.

THIS method look for dups among the 1 row passed in and the cache

*/

String	ls_Status, &
			ls_Reason, &
			ls_FindString
			
Long		ll_EventID, &
			ll_NextId, &
			ll_NewRow, &
			ll_FindRtn, &
			ll_Rtn = 1

Date		ld_Date, &
			ld_StatusDate

Time		lt_StatusTime

Boolean	lb_NewRow

CONSTANT Boolean cb_Commit	= TRUE	

n_ds			lds_Source
n_ds			lds_Cache

lds_Cache  = THIS.of_GetCache ( TRUE )

lds_Source = ads_Data
IF Not IsValid ( lds_Source ) THEN
	ll_Rtn = -1 
ELSE
	IF lds_Source.RowCount ( ) < 1 THEN 
		ll_Rtn =  -1								//////  EARLY RETURN
	END IF	
END IF

IF ll_Rtn = 1 then
	ll_EventID = lds_Source.GetItemNumber ( 1 , "EDI_sourceid" )
	ls_Status = lds_Source.GetItemString ( 1 , "edistatus_status" )
	ls_Reason  = lds_Source.GetItemString ( 1 , "edistatus_reason" )
	ld_StatusDate = lds_Source.GetItemDate ( 1 , "edistatus_statusdate" )
	lt_StatusTime = lds_Source.GetItemtime ( 1 , "edistatus_statustime" )
	
	ls_FindString = "edistatus_status = '" + ls_Status + "'" + &
						" AND edi_sourceid = " + String ( ll_EventID ) + &
						" AND edi_source = 'EVENT'" + &
						" AND edi_TransactionSet = " + string(cl_transaction_set_214) + &
						" AND edi_company = " + string(al_coid) 
						
	ll_FindRtn = THIS.of_Find ( ls_FindString )

	if ll_FindRtn > 0 then
		//was it already processed
		ld_Date = lds_cache.GetItemDate ( ll_Findrtn ,  "EDI_ProcessedDate" )
			
		if isnull(ld_date) then
		
			// replace row that was found in the cache
			lds_Cache.SetItem ( ll_FindRtn , "edistatus_reason" , ls_Reason )
			lds_Cache.SetItem ( ll_FindRtn , "edistatus_statusdate", ld_statusDate )
			lds_Cache.SetItem ( ll_FindRtn , "edistatus_statustime", lt_StatusTime )
		
			lb_newrow = false
		else
			//already processed, add new row
			lb_newrow = true
		end if
		
	else
		lb_NewRow = true
	end if
	
	if lb_newrow then
		
		IF gnv_App.of_GetNextId ( "edi", ll_NextId, cb_Commit ) = 1 THEN
			
			ll_NewRow = lds_Cache.InsertRow ( 0 )
	
			if ll_Newrow > 0 then
				lds_Cache.SetItem ( ll_NewRow , "edi_transactionSet" , 214 )
				lds_Cache.SetItem ( ll_NewRow , "edi_sourceid" , ll_EventID )
				lds_Cache.SetItem ( ll_NewRow , "edi_source" , 'EVENT' )
				lds_Cache.SetItem ( ll_NewRow , "edi_Company" , al_CoId)
			
				lds_Cache.SetItem ( ll_NewRow , "edistatus_EDIid" , ll_NextId )
				lds_Cache.SetItem ( ll_NewRow , "edistatus_status" , ls_Status )
				lds_Cache.SetItem ( ll_NewRow , "edistatus_reason" , ls_Reason )
				lds_Cache.SetItem ( ll_NewRow , "edistatus_statusdate", ld_statusDate )
				lds_Cache.SetItem ( ll_NewRow , "edistatus_statustime", lt_StatusTime )
			end if
					
		end if
		
	END IF
END IF

if isvalid(ads_data) then
	DESTROY ads_data
end if

RETURN ll_Rtn

end function

public subroutine of_removefromcache (n_ds ads_data, long al_coid);/*
the source that is passed in should only contian 1 row because it will 
only focus on the first row.

*/
Long		ll_RowCount
String 	ls_FindString	
Long		ll_FindRtn
Long		ll_EDIid
String	ls_Status
Long		ll_EventID
String	ls_Processed
Date	ld_Date

n_ds			lds_Source
n_ds			lds_Cache

lds_Cache  = THIS.of_GetCache ( TRUE )

lds_Source = ads_Data

IF Not IsValid ( lds_Source ) THEN
	ll_RowCount = 0
ELSE
	ll_RowCount = lds_Source.RowCount ( )
END IF


IF ll_RowCount > 0 THEN 
	ll_EventID = lds_Source.GetItemNumber ( 1 , "EDI_sourceid" )
	ls_Status = lds_Source.GetItemString ( 1 , "edistatus_status" )
	
	ls_FindString = "edistatus_status = '" + ls_Status + "'" + &
						" AND edi_sourceid = " + String ( ll_EventID ) + &
						" AND edi_source = 'EVENT'" + &
						" AND edi_TransactionSet = 214" + &
						" AND edi_company = " + string(al_coid) 
						
	ll_FindRtn = THIS.of_Find ( ls_FindString )

	if ll_FindRtn > 0 then
		//was it already processed
		ld_Date = lds_cache.GetItemDate ( ll_Findrtn ,  "EDI_Processeddate" )
			
		if isnull(ld_date) then
		
			ll_EDIid =  lds_cache.GetItemNumber ( ll_FindRtn , "edistatus_ediid" )

			// OK TO DELETE ROW
			
			lds_cache.deleterow(ll_Findrtn)
						
		else
			//already processed, DON'T DELETE
		end if
		
	end if
	
END IF

if isvalid(ads_data) then
	DESTROY ads_data
end if


end subroutine

public subroutine of_deletemessage (n_cst_bso_dispatch anv_dispatch, long al_event, string as_action);//Revised for 3.5.23 3-12-2003 by BKW to allow for EDI 322 off a non-shipment event.

long	ll_shipid, &
		ll_statusid, &
		ll_index, &
		ll_arraycount, &
		ll_322Status, &
		ll_322EquipmentStatus

string	ls_eventtype, &
			ls_action, &
			ls_setting, &
			ls_322Status, &
			ls_MessageHeader, &
			ls_Intermodal, &
			ls_billto, &
			ls_report
			
date		ld_event

time		lt_event

Boolean	lb_Has214, &
			lb_Continue = TRUE

n_cst_events 			lnv_Events
n_cst_beo_event		lnv_event
n_cst_beo_Company		lnv_Site
n_ds						lds_unconfirmedevent
n_cst_LicenseManager	lnv_LicenseManager

lb_Has214 = lnv_LicenseManager.of_HasEDI214License ( )

setnull(ls_action)
setnull(ll_statusid)

lnv_event = CREATE n_cst_beo_event
lnv_Event.of_SetSource ( anv_dispatch.of_GetEventCache ( ) )
lnv_Event.of_SetSourceId ( al_event )

//if this.of_CheckShipperEDIUpdate(anv_dispatch, al_event) = 1 then  //Loads the list of 214 and 322 codes to notify
//	//OK
//ELSE
//	lb_Continue = FALSE
//END IF

IF lb_Continue THEN
	ll_arraycount = upperbound(ila_EDICompId)

	for ll_index = 1 to ll_arraycount
		ls_setting = this.of_GetStatus(lnv_event, as_action, ila_EDICompId[ll_index])
		if len(ls_setting) > 0 then
				this.of_loadnewevent(lnv_Event, lds_unconfirmedevent)	
				lds_unconfirmedevent.object.edistatus_status[1] = ls_setting
				this.of_RemoveFromcache(lds_unconfirmedevent, ila_edicompid[ll_index])
				DESTROY lds_unconfirmedevent
		end if
	next
	
END IF //End 214



end subroutine

public function n_ds of_getprofilecache ();IF isvalid(ids_ProfileCache) THEN
	//ALREADY CREATED
ELSE
	ids_ProfileCache = CREATE n_ds
	ids_ProfileCache.DataObject = "d_Ediprofile_ds"
	ids_ProfileCache.SetTransObject(SQLCA)
	ids_ProfileCache.retrieve()
	commit;
END IF

Return ids_ProfileCache
end function

public function string of_getshipmentrole (n_cst_beo_company anv_company, long al_transactionset);integer	li_return = 1

string	ls_Find, &
			ls_role
			
long		ll_coid, &
			ll_Found			

n_ds	lds_EDIPRofile

lds_EDIProfile = this.of_GetProfileCache()

if isvalid(anv_company) then
	ll_coid = anv_company.of_Getid()
else
	li_return = -1
end if

if li_return = 1 then
	if isvalid(lds_EDIPRofile) then
		ls_find = "transactinoset = " + string(al_Transactionset) + " and companyid = " + string(ll_coid)
		
		ll_found = lds_EdIPRofile.find(ls_find, 1, lds_EDIProfile.rowcount())
		
		if ll_found > 0 then
			ls_role = lds_EDIPRofile.object.shipmentrole[ll_found]
		end if 
		
	end if
end if

return ls_role


end function

public function n_ds of_getpendingcache ();IF isvalid(ids_PendingCache) THEN
	//ALREADY CREATED
ELSE
	ids_PendingCache = CREATE n_ds

	n_cst_setting_edi204version	lnv_204Version
	lnv_204Version = create n_cst_setting_edi204version
	IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
		lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
		ids_PendingCache.DataObject = "d_EdiPending_ds"
	ELSE
		ids_PendingCache.DataObject =	"d_Edi_EventCache"
	END IF	
	destroy lnv_204Version	
	
//	ids_PendingCache.DataObject = "d_EdiPending_ds"
	ids_PendingCache.SetTransObject(SQLCA)
	ids_PendingCache.retrieve()
	commit;
END IF

Return ids_PendingCache

end function

public function boolean of_hasprofile (long al_transactionset, long al_company);string	ls_find

long		ll_found

boolean	lb_profile

n_ds	lds_ProfileCache

lds_ProfileCache = this.of_GetProfileCache()
if isvalid(lds_ProfileCache) then
	ls_find = 'transactionset = ' + string(al_transactionset) + ' and companyid = ' + string(al_company)
	ll_found = lds_ProfileCache.find(ls_find, 1, lds_ProfileCache.rowcount())
	if ll_found > 0 then
		lb_profile = true
	else
		lb_profile = false
	end if
end if

return lb_profile

end function

public function integer of_generate (long al_transactionset, long ala_id[]);integer	li_return = 1

string	ls_filter, &
			ls_source, &
			ls_action, &
			ls_TransactionSet

long		ll_row, &
			ll_rowcount, &
			ll_source, &
			ll_sourceid, &
			lla_coid[], &
			lla_EDI[], &
			lla_Source[], &
			ll_FilteredCount

boolean	lb_EDIDirect
			
s_parm		lstr_parm
n_cst_msg	lnv_msg
n_ds	lds_shipmentstatus

n_ds			lds_EDIPending
n_cst_sql	lnv_sql
n_cst_edi_transaction	lnv_cst_edi_transaction
n_cst_setting_edi204version	lnv_204Version

lnv_204Version = CREATE n_cst_setting_edi204version
IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
	lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
	lb_EDIDirect = true
ELSE
	lb_EDIDirect = false
END IF	
DESTROY ( lnv_204Version )


ls_TransactionSet = "n_cst_EDI_Transaction_"

if lb_EDIDirect then
	lds_EDIPending = this.of_GetPendingCache()
	
	if lds_EDIPending.rowcount() > 0 then
		ls_filter = 'transactionset = ' + string(al_transactionset)
		
		if upperbound(ala_id) > 0 then
			//filter to id list
			ls_filter = ls_filter + ' and sourceid'  + lnv_sql.of_makeinclause(ala_id)
		end if
		
		lds_EDIPending.setfilter(ls_filter)
		lds_EDIPending.filter()
	else
		li_return = -1
	end if
end if

if li_return = 1 then
	choose case al_TransactionSet
		case cl_transaction_set_214
			lnv_cst_edi_transaction = CREATE USING ls_TransactionSet + string(cl_transaction_set_214)
							
			if lb_EDIDirect then 
				if lds_EDIPending.RowCount() > 0 then
					lnv_cst_edi_transaction.of_createtransaction( lds_edipending, lla_EDI, lla_Source )
					if upperbound(lla_EDI) > 0 then
						lnv_cst_edi_transaction.of_SendTransaction(lla_EDI)
					end if
				end if
				//save cache
				if lnv_cst_edi_transaction.of_UpdateEDICache() = 1 then
					//delete pending
					this.of_DeleteFromPendingCache(cl_transaction_set_214, lla_Source, 'EVENT')
					this.of_SavePendingCache()
				end if
			else
				lds_shipmentstatus = CREATE n_ds
				lds_shipmentstatus.DataObject = "d_shipmentstatus_list"
				lds_shipmentstatus.SetTransObject(SQLCA)
						
				//Filter off any 322 messages.  "Q501" is the 322 status field, so we'll use that to distinguish 322.
				//Added 3.5.19 BKW in order to accommodate addition of 322
				//Obviously, it would be preferable to have a TransactionSet field to go by.
				lds_ShipmentStatus.SetFilter ( "edi_status_a_segmentid <> 'Q5'" ) 
		
				lds_shipmentstatus.retrieve()
				COMMIT ;   //This had been omitted -- Added 3.5.19 BKW
		
				//Discard any 322 rows that were retrieved and filtered out.
				//Added 3.5.19 BKW in order to accommodate addition of 322
		
				ll_FilteredCount = lds_ShipmentStatus.FilteredCount ( )
		
				IF ll_FilteredCount > 0 THEN
					lds_ShipmentStatus.RowsDiscard ( 1, ll_FilteredCount, Filter! )
				END IF
		
				lstr_Parm.is_Label = "SHIPMENTSTATUS"
				lstr_Parm.ia_Value = lds_shipmentstatus
				lnv_Msg.of_Add_Parm ( lstr_Parm )
				
				lnv_cst_edi_transaction.of_loadtransactions(lnv_msg)
				DESTROY lds_shipmentstatus
				
			end if

			DESTROY lnv_cst_edi_transaction
	
		case cl_transaction_set_322
			//still done in this.of_CreateTransactionSet ()
			
		case cl_transaction_set_210		
			lnv_cst_edi_transaction = CREATE USING ls_TransactionSet + string(cl_transaction_set_210)
	
			if lds_EDIPending.RowCount() > 0 then
				lnv_cst_edi_transaction.of_createtransaction( lds_edipending, lla_EDI, lla_Source)
				if upperbound(lla_EDI) > 0 then
					lnv_cst_edi_transaction.of_SendTransaction(lla_EDI)
					//save cache
					if lnv_cst_edi_transaction.of_UpdateEDICache() = 1 then
						//delete pending
						this.of_DeleteFromPendingCache(cl_transaction_set_210, lla_Source, 'SHIPMENT')
						this.of_SavePendingCache()
					end if
					
				end if
			end if
					
			DESTROY lnv_cst_edi_transaction
	
		case else
			//
			
	end choose
end if

return li_return


end function

public function integer of_createtransactionset (long al_set, ref n_cst_msg anv_msg);string ls_TransactionSet
long		lla_ids[], &
			ll_FilteredCount

S_Parm 	lstr_Parm

n_cst_edi_transaction	lnv_cst_edi_transaction
n_ds	lds_shipmentstatus
		
DataWindow	ldw_Source

IF isValid (anv_msg ) THEN
	IF anv_msg.Of_Get_Parm ( "SOURCE" , lstr_Parm ) <> 0 THEN
		ldw_Source= lstr_Parm.ia_Value
	END IF
	
	IF anv_msg.Of_Get_Parm ( "IDS" , lstr_Parm ) <> 0 THEN
		lla_IDS = lstr_Parm.ia_Value
	END IF

END IF

ls_TransactionSet = "n_cst_EDI_Transaction_"


choose case al_set
	case cl_transaction_set_214
		lds_shipmentstatus = CREATE n_ds
		lds_shipmentstatus.DataObject = "d_shipmentstatus_list"
		lds_shipmentstatus.SetTransObject(SQLCA)
				
		//Filter off any 322 messages.  "Q501" is the 322 status field, so we'll use that to distinguish 322.
		//Added 3.5.19 BKW in order to accommodate addition of 322
		//Obviously, it would be preferable to have a TransactionSet field to go by.
		lds_ShipmentStatus.SetFilter ( "edi_status_a_segmentid <> 'Q5'" ) 

		lds_shipmentstatus.retrieve()
		COMMIT ;   //This had been omitted -- Added 3.5.19 BKW

		//Discard any 322 rows that were retrieved and filtered out.
		//Added 3.5.19 BKW in order to accommodate addition of 322

		ll_FilteredCount = lds_ShipmentStatus.FilteredCount ( )

		IF ll_FilteredCount > 0 THEN
			lds_ShipmentStatus.RowsDiscard ( 1, ll_FilteredCount, Filter! )
		END IF


		ls_TransactionSet = ls_TransactionSet + string(al_set)
		lnv_cst_edi_transaction = CREATE USING ls_TransactionSet
		
		lstr_Parm.is_Label = "SHIPMENTSTATUS"
		lstr_Parm.ia_Value = lds_shipmentstatus
		Anv_Msg.of_Add_Parm ( lstr_Parm )
		
		lnv_cst_edi_transaction.of_loadtransactions(anv_msg)
		
		DESTROY lnv_cst_edi_transaction
		DESTROY lds_shipmentstatus

	case cl_transaction_set_322

		//I don't agree that the shipmentstatus retrieval should be done out here rather than in the TransactionSet
		//object, but this is the way 214 was being done, so I'm going to mirror it.  Also, there was no error 
		//checking being done, so I'm going to stick with that, too. --BKW

		lds_shipmentstatus = CREATE n_ds
		lds_shipmentstatus.DataObject = "d_shipmentstatus_list"
		lds_shipmentstatus.SetTransObject(SQLCA)

		//Filter off any 322 messages.  "Q501" is the 322 status field, so we'll use that to distinguish 322.
		//Added 3.5.19 BKW to basic retrieve in order to accommodate addition of 322
		//Obviously, it would be preferable to have a TransactionSet field to go by.
		lds_ShipmentStatus.SetFilter ( "edi_status_a_segmentid = 'Q5'" ) 
				
		lds_shipmentstatus.retrieve()
		COMMIT ;

		//Discard any 322 rows that were retrieved and filtered out.
		//Added 3.5.19 BKW in order to accommodate addition of 322

		ll_FilteredCount = lds_ShipmentStatus.FilteredCount ( )

		IF ll_FilteredCount > 0 THEN
			lds_ShipmentStatus.RowsDiscard ( 1, ll_FilteredCount, Filter! )
		END IF


		ls_TransactionSet = ls_TransactionSet + string(al_set)
		lnv_cst_edi_transaction = CREATE USING ls_TransactionSet
		
		lstr_Parm.is_Label = "SHIPMENTSTATUS"
		lstr_Parm.ia_Value = lds_shipmentstatus
		Anv_Msg.of_Add_Parm ( lstr_Parm )
		
		lnv_cst_edi_transaction.of_loadtransactions(anv_msg)
		DESTROY lnv_cst_edi_transaction
		DESTROY lds_shipmentstatus
		
	case cl_transaction_set_210
		ls_TransactionSet = ls_TransactionSet + string(al_set)
		lnv_cst_edi_transaction = CREATE USING ls_TransactionSet
		lnv_cst_edi_transaction.of_loadtransactions(anv_msg)
		DESTROY lnv_cst_edi_transaction
	case else
		//create all transaction sets
		
end choose

return 1
end function

public subroutine of_addtopendingcache (any aaa_beo[], string as_source, long al_transactionset, string as_action);string	ls_find

long		ll_company, &
			ll_source, &
			ll_found, &
			ll_row, &
			ll_ndx, &
			ll_count

n_ds		lds_PendingCache

n_cst_beo_Event		lnva_Event[]
n_cst_beo_Shipment	lnva_Shipment[]
n_cst_beo_Company		lnv_Company

choose case as_source
	case 'EVENT'
		lnva_Event = aaa_beo

	case 'SHIPMENT'
		lnva_Shipment = aaa_beo
		
end choose

//prescreen
lds_PendingCache = this.of_GetPendingCache()

if isvalid(lds_PendingCache) then
	ll_count = upperbound(aaa_beo)
	
	for ll_ndx = 1 to ll_count
		choose case as_source
			case 'EVENT'
				ll_company = lnva_Event[ll_ndx].of_GetSite()
				ll_source = lnva_Event[ll_ndx].of_Getid()
				
			case 'SHIPMENT'
				ll_company = lnva_Shipment[ll_ndx].of_Getbillto( )
				ll_source = lnva_Shipment[ll_ndx].of_Getid()
				
		end choose
		
		//find profile
//		if this.of_HasProfile(al_transactionset, ll_company) then
			
			//is it already in the cache
			ls_find = 'transactionset = ' + string(al_transactionset) + &
						 ' and sourceid = ' + string(ll_source) + &
						 " and source = '" + as_source + "'" + &
						 " and action = '" + as_action + "'"
						 
			ll_found = lds_PendingCache.find(ls_find, 1, lds_PendingCache.rowcount())
			if ll_found > 0 then
				//already in cache
			else
				//add to cache
				ll_row = lds_pendingCache.insertrow(0)
				lds_PendingCache.object.transactionset[ll_row] = al_Transactionset
				lds_PendingCache.object.sourceid[ll_row] = ll_source
				lds_PendingCache.object.source[ll_row] = as_source
				lds_PendingCache.object.action[ll_row] = as_action					
			end if
			
//		end if
		
	next
	
end if
				

end subroutine

public function integer of_savependingcache ();//Written by dan 6-12-2006, written after a bug was found from moving the 214 from the scheduler.
//Basically there would be a db error 3 when saving after removing a confim even from a 
//shipment after the scheduler had already sent the file.   for each row in the delete buffer.  When this returns
//, if the row exists in the database edipending table and it is ok to delete it.
//IF false, the row should be discarded by the of_savePendingCahce before the update.
integer	li_return = 1
Long	   ll_deleteCOunt
Long	   ll_index

int		ai_transaction
long		al_sourceid
String	as_source
String	as_action

Datastore	lds_SearchCache

n_ds	lds_PendingCache

lds_PendingCache = this.of_GetPendingCache()

ll_deleteCOunt = lds_pendingCache.deletedCount()

//discard rows from deleteBuffer if they dont' exist in the db
// if direct verition of edi...because getedpendingcache could have two different dataobjects.
IF lower(lds_pendingCache.dataobject) = "d_edipending_ds" THEN
	lds_searchCache = create Datastore
	lds_searchCache.dataobject = "d_edipending_ds"
	lds_searchCache.settransObject( SQLCA )
	lds_searchCache.retrieve()
	commit;
	
	IF lds_searchCache.RowCount() > 0 THEN
		FOR ll_index = ll_deleteCOunt TO 1 STEP -1
			ai_transaction = lds_pendingCache.getItemnumber( ll_index, "transactionset", delete!, true)
			al_sourceId = lds_pendingCache.getItemnumber( ll_index, "sourceid", delete!, true)
			as_source = lds_pendingCache.getItemString( ll_index, "source", delete!, true)
			as_action = lds_pendingCache.getItemString( ll_index, "action", delete!, true)
			
			IF this.of_indatabaseedipendingtable( ai_transaction, al_sourceId, as_source,  as_action, lds_searchCache ) THEN
				//ok to delete
			ELSE
				lds_pendingCache.rowsDiscard( ll_index, ll_index, DELETE!)
			END IF
		NEXT
	ELSE
		//theres no chance anything in the deletebuffer is in database, discard the whole cache
		lds_pendingCache.rowsDiscard( 1, ll_deleteCount, DELETE!)
	END IF
	
	DESTROY lds_SearchCache
END IF

if lds_PendingCache.update() <> 1 then
		li_return = -1 
		rollback;
	else
		li_return = 1
		commit;
	end if

return li_return


end function

public subroutine of_resetpendingcache ();destroy ids_Pendingcache
this.of_getPendingCache()
end subroutine

public subroutine of_deletefrompendingcache (long al_transactionset, long ala_id[], string as_source);string	ls_find

long		ll_found, &
			ll_row, &
			ll_rowcount, &
			ll_pendingcount

n_ds		lds_PendingCache

lds_PendingCache = this.of_GetPendingCache()
if isvalid(lds_PendingCache) then
	ll_rowcount = upperbound(ala_id)
	
	for ll_row = 1 to ll_rowcount
		
		ls_find = "transactionset = " + string(al_transactionset) + &
					 " and sourceid = " + string(ala_id[ll_row]) + &
					 " and source = '" + as_Source + "'" 

					 
		ll_found = lds_PendingCache.find(ls_find, lds_PendingCache.rowcount(), 1)

		DO while ll_found > 0
		
			lds_PendingCache.deleterow(ll_found)
		
			// Prevent endless loop
			
			IF lds_PendingCache.rowcount() = 0 THEN EXIT
			
			ll_found = lds_PendingCache.find(ls_find, lds_PendingCache.rowcount(), 1)
		
		LOOP

	next
	
end if
	

end subroutine

public function long of_loadnewpendingevent (n_cst_beo_event anv_event, ref n_ds ads_newpendingevent);long		ll_row, &
			ll_Return

n_ds	lds_newpendingevent
		
IF Not IsValid ( anv_Event ) THEN
	RETURN -1
END IF
		
//load the cache to the instance variable
this.of_GetCache(TRUE)
				
lds_newpendingevent = CREATE n_ds
lds_newpendingevent.DataObject = "d_EdiPending_ds"
lds_newpendingevent.SetTransObject(SQLCA)
ll_row = lds_newpendingevent.InsertRow(0)

if ll_row > 0 then
	lds_newpendingevent.object.sourceid[ll_row] = anv_event.of_getid()
	lds_newpendingevent.object.source[ll_row] = 'EVENT'
	lds_newpendingevent.object.transactionset[ll_row] = cl_transaction_set_214
	lds_newpendingevent.object.action[ll_row] = cs_Action_Update
end if

ads_newpendingevent = lds_newpendingevent

Return ll_Return

end function

public function integer of_showdetails (long al_row, long al_shipid);Long			ll_EventID
boolean		lb_direct

n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm
n_ds			lds_Data
n_ds			lds_Cache
n_ds			lds_RtnData
n_cst_setting_edi204version	lnv_204Version

lnv_204Version = CREATE n_cst_setting_edi204version
IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
	lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
	//ok
	lb_direct = true
ELSE
	lb_direct = false
END IF	
DESTROY ( lnv_204Version )

lds_Cache = THIS.of_GetPendingCache ( )
IF al_Row > 0 AND al_Row <= lds_Cache.RowCount( ) THEN
		
	ll_EventID = lds_Cache.GetItemNumber ( al_Row , "sourceid" )
	
	THIS.of_LoadEvent ( ll_EventID , al_Row , lds_Data )
	
	lstr_parm.is_Label = "DISPATCH"
	lstr_Parm.ia_Value = inv_Dispatch
	lnv_Msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "DATA"
	lstr_Parm.ia_Value = lds_Data
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "NEW"
	lstr_Parm.ia_Value = FALSE
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	if lb_direct then
		OpenWithParm ( w_ShipmentStatus_Details , lnv_Msg )
	else
		OpenWithParm ( w_ShipmentStatus_Details_van , lnv_Msg )
	end if
	
	lnv_Msg = Message.powerobjectParm
	
	IF lnv_Msg.of_Get_Parm ( "DATA" , lstr_Parm ) <> 0 THEN
		lds_rtnData = lstr_Parm.ia_Value
	END IF
	
	IF IsValid ( lds_rtnData ) THEN
	
//		THIS.of_updateCache ( lds_rtnData, al_Row, al_shipid )

	END IF
END IF

RETURN 1
end function

public function long of_checkshipperediupdate (n_cst_bso_dispatch anv_dispatch, long al_event, boolean ab_creatingmessage);//check for edi updates to company
/*
	ab_creatingmessage message = false if you just want to see if 
	any companies have a profile
*/

long	ll_shipid, &
		ll_rowcount, &
		lla_Drivers[], &
		lla_Equipment[], &
		lla_Empty[], &
		lla_coid[], &
		ll_EquipmentCount, &
		ll_Index, &
		ll_return=1
		
string	lsa_blank[], &
			ls_Line, &
			ls_322Code

n_cst_beo_shipment	lnv_shipment
n_cst_beo_company		lnv_company
n_cst_beo_event		lnv_event
n_cst_beo_Equipment2	lnv_Equipment
n_cst_beo_EquipmentLease2	lnv_EquipmentLease
n_cst_bso_dispatch 	lnv_dispatch
n_cst_anyarraysrv		lnv_arraysrv
n_cst_LicenseManager	lnv_LicenseManager

Boolean	lb_Has214, &
			lb_Has322, &
			lb_214Pending


lb_Has214 = lnv_LicenseManager.of_HasEDI214License ( )
lb_Has322 = lnv_LicenseManager.of_HasEDI322License ( )

isa_EDI214Code = lsa_Blank
isa_EDI322Code = lsa_Blank

lnv_dispatch = anv_dispatch
lnv_Shipment = CREATE n_cst_beo_Shipment

lnv_event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( lnv_dispatch.of_GetEventCache ( ) )
lnv_Event.of_SetSourceId ( al_event )


//Although the following code was initially revised to flag companies on the shipment for both 214 and 322,
//it's now looking like 322 will only need to be based on the equipment lease types, which is handled in 
//a separate code block, below.  If we did want to do 322 based on companies on the shipment, we could remove the
// lb_Has214 condition from the beginning of this block and uncomment the lb_Has322 blocks under each company
//lookup in the body of the code.  Note that of_GetEDI322Code would then need to be implemented (which it's not, now.)

IF lb_Has214 = TRUE AND lnv_Event.of_HasSource ( ) THEN

	//load shipment to cache
	ll_shipid = lnv_Event.of_getshipment()

	lnv_dispatch.of_retrieveshipments({ll_shipid})

	lnv_shipment.of_setsource(lnv_dispatch.of_getshipmentcache())
	lnv_shipment.of_setsourceid(ll_shipid)

	if this.of_edi214profile( lnv_event, lnv_Shipment, lla_coid) = 1 then
		ila_EDICompId = lla_Empty
		lnv_arraysrv.of_getshrinked(lla_coid,true,true)
		ila_EDICompId = lla_coid
		lb_214Pending=true
	end if
	
end if


//Determine if any 322 notifications should be issued


IF lb_Has322 = TRUE AND lnv_Event.of_HasSource ( ) THEN

	lla_Equipment = lla_Empty

	lnv_event.of_getsite(lnv_company, TRUE)

	if isvalid (lnv_Company) then

		IF lnv_Company.of_IsEDI322Site ( ) THEN

			//If it's an assignment event, just get the equipment that's "actively" involved in the event, 
			//ie, being hooked, dropped, mounted, dismounted, etc.  If it's not an assignment event, just
			//get a list of everything.

			IF lnv_Event.of_IsAssignment ( ) THEN

				lnv_Event.of_GetActiveAssignments ( lla_Drivers, lla_Equipment )

			ELSE

				lnv_Event.of_GetAssignments ( lla_Drivers, lla_Equipment )

			END IF

		END IF

	END IF


	ll_EquipmentCount = UpperBound ( lla_Equipment )

	IF ll_EquipmentCount > 0 THEN

		lnv_Dispatch.of_RetrieveEquipment ( lla_Equipment )

		lnv_Equipment = CREATE n_cst_beo_Equipment2
		lnv_Equipment.of_SetSource ( lnv_Dispatch.of_GetEquipmentCache ( ) )

	END IF


	FOR ll_Index = 1 TO ll_EquipmentCount

		lnv_Equipment.of_SetSourceId ( lla_Equipment [ ll_Index ] )

		CHOOSE CASE lnv_Equipment.of_GetEquipmentLease ( lnv_EquipmentLease )

		CASE 1

			ls_Line = lnv_EquipmentLease.of_GetLeaseLine ( )

			IF Len ( ls_Line ) > 0 THEN

				ls_322Code = ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI322Lines", ls_Line, "" )

				IF Len ( ls_322Code ) > 0 THEN

					isa_EDI322code [ UpperBound ( isa_EDI322code ) + 1 ] = ls_322Code

				END IF

			END IF

		END CHOOSE

	NEXT				

END IF

if upperbound(isa_edi322code) > 0 then
	//remove dupes
	lnv_arraysrv.of_getshrinked(isa_edi322code,true,true)
end if

//Note : This was returning -1 if there were no 214 codes.  I've changed this to return 0
//if there's no 214 or 322 codes.   --BKW, 322 revision.

IF not lb_214Pending AND UpperBound ( isa_EDI322Code ) = 0 AND UpperBound ( ila_EDICompId ) = 0 THEN
	ll_Return = 0
END IF

DESTROY lnv_Shipment
DESTROY lnv_event 
DESTROY lnv_Company
DESTROY lnv_EquipmentLease
DESTROY lnv_Equipment

return ll_return
end function

public function integer of_edi214profile (n_cst_beo_event anv_event, n_cst_beo_shipment anv_shipment, ref long ala_coid[]);integer	li_return = 1
long		lla_coid[]

n_cst_edi_transaction_214	lnv_transaction214

n_ds	lds_214profile

lnv_transaction214 = create n_cst_edi_transaction_214

lds_214PRofile = lnv_transaction214.of_GetStatusProfile()

if isvalid(lds_214Profile) then
	
	//site
	lds_214PRofile.retrieve(anv_event.of_getsite(), this.cl_transaction_set_214)
	commit;
	if lds_214PRofile.rowcount() > 0  then
		lla_coid[upperbound(lla_coid) + 1] = anv_event.of_getsite()
	end if
	
	if anv_shipment.of_hassource() then
		
		// check billto
		lds_214PRofile.retrieve(anv_Shipment.of_GetBillto(), this.cl_transaction_set_214)
		commit;
		if lds_214PRofile.rowcount() > 0  then
			lla_coid[upperbound(lla_coid) + 1] = anv_Shipment.of_GetBillto()
		end if

		// check origin
		lds_214PRofile.retrieve(anv_Shipment.of_Getorigin(), this.cl_transaction_set_214)
		commit;
		if lds_214PRofile.rowcount() > 0  then
			lla_coid[upperbound(lla_coid) + 1] = anv_Shipment.of_Getorigin()
		end if
	
		// check destination
		lds_214PRofile.retrieve(anv_Shipment.of_GetDestination(), this.cl_transaction_set_214)
		commit;
		if lds_214PRofile.rowcount() > 0  then
			lla_coid[upperbound(lla_coid) + 1] = anv_Shipment.of_GetDestination()
		end if
	
		// check Carrier
		lds_214PRofile.retrieve(anv_Shipment.of_getcarrier(), this.cl_transaction_set_214)
		commit;
		if lds_214PRofile.rowcount() > 0  then
			lla_coid[upperbound(lla_coid) + 1] = anv_Shipment.of_getcarrier()
		end if
	
		// check Agent
		lds_214PRofile.retrieve(anv_Shipment.of_getagent(), this.cl_transaction_set_214)
		commit;
		if lds_214PRofile.rowcount() > 0  then
			lla_coid[upperbound(lla_coid) + 1] = anv_Shipment.of_getagent()	
		end if
	
		// check Forwarder
		lds_214PRofile.retrieve(anv_Shipment.of_getforwarder(), this.cl_transaction_set_214)
		commit;
		if lds_214PRofile.rowcount() > 0  then
			lla_coid[upperbound(lla_coid) + 1] = anv_Shipment.of_getforwarder()	
		end if
		
	end if
	
end if

destroy lnv_transaction214
destroy lds_214profile

if upperbound(lla_coid) > 0 then
	ala_coid = lla_coid
	li_return = 1 
else
	li_return = 0
end if

return li_return
end function

protected subroutine of_addtopendingcache (n_ds ads_edipending);string	ls_find, &
			ls_source, &
			ls_action, &
			ls_status, &
			ls_reason

long		ll_transactionset, &
			ll_sourceid, &
			ll_found, &
			ll_row, &
			ll_ndx, &
			ll_count, &
			ll_coid

date		ld_status

time		lt_status

n_ds		lds_PendingCache

lds_PendingCache = this.of_GetPendingCache()

if isvalid(lds_PendingCache) then
	ll_count = ads_EDIPending.rowcount()
	
	for ll_ndx = 1 to ll_count
		ll_transactionset = ads_EDIPending.object.transactionset[ll_ndx]
		ll_sourceid = ads_EDIPending.object.sourceid[ll_ndx]
		ls_source = ads_EDIPending.object.source[ll_ndx]
		ls_Action = ads_EDIPending.object.action[ll_ndx]
		ls_status = ads_EDIPending.object.status[ll_ndx]
		ls_reason = ads_EDIPending.object.reason[ll_ndx]
		ld_status = ads_EDIPending.object.statusdate[ll_ndx]
		lt_status = ads_EDIPending.object.statustime[ll_ndx]
		ll_coid	 =  ads_EDIPending.object.company[ll_ndx]
		
		//is it already in the cache
		ls_find = 'transactionset = ' + string(ll_transactionset) + &
					 ' and sourceid = ' + string(ll_sourceid) + &
					 " and source = '" + ls_source + "'" + &
					 " and action = '" + ls_action + "'"
					 
		if ll_coid > 0 then
			ls_find = ls_find + " and company = " + string(ll_coid)
		end if
		
		ll_found = lds_PendingCache.find(ls_find, 1, lds_PendingCache.rowcount())

		if ll_found > 0 then
			//already in cache update status
			lds_PendingCache.object.status[ll_found] = ls_status
			lds_PendingCache.object.reason[ll_found] = ls_reason
			lds_PendingCache.object.statusdate[ll_found] = ld_status
			lds_PendingCache.object.statustime[ll_found] = lt_status
		else
			//add to cache
			ll_row = lds_pendingCache.insertrow(0)
			lds_PendingCache.object.transactionset[ll_row] = ll_Transactionset
			lds_PendingCache.object.sourceid[ll_row] = ll_sourceid
			lds_PendingCache.object.source[ll_row] = ls_source
			lds_PendingCache.object.action[ll_row] = ls_action			
			lds_PendingCache.object.status[ll_row] = ls_status
			lds_PendingCache.object.reason[ll_row] = ls_reason
			lds_PendingCache.object.statusdate[ll_row] = ld_status
			lds_PendingCache.object.statustime[ll_row] = lt_status
			lds_PendingCache.object.company[ll_row] = ads_EDIPending.object.company[ll_ndx]
		end if
		
	next
	
end if
	

end subroutine

public function long of_checkshipperediupdate_van (n_cst_bso_dispatch anv_dispatch, long al_event);//check for edi updates to company
long	ll_shipid, &
		ll_rowcount, &
		lla_Drivers[], &
		lla_Equipment[], &
		lla_Empty[], &
		ll_EquipmentCount, &
		ll_Index, &
		ll_return=1
		
string	ls_requestrole, &
			lsa_blank[], &
			ls_Line, &
			ls_322Code

n_cst_beo_shipment	lnv_shipment
n_cst_beo_company		lnv_company
n_cst_beo_event		lnv_event
n_cst_beo_Equipment2	lnv_Equipment
n_cst_beo_EquipmentLease2	lnv_EquipmentLease
n_cst_bso_dispatch 	lnv_dispatch
n_cst_anyarraysrv		lnv_arraysrv
n_cst_LicenseManager	lnv_LicenseManager

Boolean	lb_Has214, &
			lb_Has322

lb_Has214 = lnv_LicenseManager.of_HasEDI214License ( )
lb_Has322 = lnv_LicenseManager.of_HasEDI322License ( )

isa_EDI214Code = lsa_Blank
isa_EDI322Code = lsa_Blank

lnv_dispatch = anv_dispatch
lnv_Shipment = CREATE n_cst_beo_Shipment

lnv_event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( lnv_dispatch.of_GetEventCache ( ) )
lnv_Event.of_SetSourceId ( al_event )


//Although the following code was initially revised to flag companies on the shipment for both 214 and 322,
//it's now looking like 322 will only need to be based on the equipment lease types, which is handled in 
//a separate code block, below.  If we did want to do 322 based on companies on the shipment, we could remove the
// lb_Has214 condition from the beginning of this block and uncomment the lb_Has322 blocks under each company
//lookup in the body of the code.  Note that of_GetEDI322Code would then need to be implemented (which it's not, now.)

IF lb_Has214 = TRUE AND lnv_Event.of_HasSource ( ) THEN

	ll_shipid = lnv_Event.of_getshipment()
	
	lnv_event.of_getsite(lnv_company, TRUE)

	if isvalid (lnv_Company) then

		choose case lnv_company.of_GetRequiredRequestRole()

			case n_cst_constants.cs_RequestRole_any

				IF lb_Has214 THEN
					isa_EDI214code [ UpperBound ( isa_EDI214code ) + 1 ] = lnv_Company.of_GetEDI214Code ( )
				END IF

//				IF lb_Has322 THEN
//					isa_EDI322code [ UpperBound ( isa_EDI322code ) + 1 ] = lnv_Company.of_GetEDI322Code ( )
//				END IF

		end choose

	end if		
	
	//load shipment to cache
	lnv_dispatch.of_retrieveshipments({ll_shipid})

	lnv_shipment.of_setsource(lnv_dispatch.of_getshipmentcache())
	lnv_shipment.of_setsourceid(ll_shipid)
	if lnv_shipment.of_hassource() then

		lnv_shipment.of_getorigin(lnv_company, TRUE)

		if isvalid (lnv_Company) then

			choose case lnv_company.of_GetRequiredRequestRole()

				case n_cst_constants.cs_RequestRole_any

					IF lb_Has214 THEN
						isa_EDI214code [ UpperBound ( isa_EDI214code ) + 1 ] = lnv_Company.of_GetEDI214Code ( )
					END IF

//					IF lb_Has322 THEN
//						isa_EDI322code [ UpperBound ( isa_EDI322code ) + 1 ] = lnv_Company.of_GetEDI322Code ( )
//					END IF

			end choose

		end if
		
		lnv_shipment.of_getdestination(lnv_company, TRUE)

		if isvalid (lnv_Company) then

			choose case lnv_company.of_GetRequiredRequestRole()

				case n_cst_constants.cs_RequestRole_any

					IF lb_Has214 THEN
						isa_EDI214code [ UpperBound ( isa_EDI214code ) + 1 ] = lnv_Company.of_GetEDI214Code ( )
					END IF

//					IF lb_Has322 THEN
//						isa_EDI322code [ UpperBound ( isa_EDI322code ) + 1 ] = lnv_Company.of_GetEDI322Code ( )
//					END IF

			end choose

		end if
		
		lnv_shipment.of_getbilltocompany(lnv_company, TRUE)

		if isvalid (lnv_Company) then

			choose case lnv_company.of_GetRequiredRequestRole()

				case n_cst_constants.cs_RequestRole_Billto, n_cst_constants.cs_RequestRole_any

					IF lb_Has214 THEN
						isa_EDI214code [ UpperBound ( isa_EDI214code ) + 1 ] = lnv_Company.of_GetEDI214Code ( )
					END IF

//					IF lb_Has322 THEN
//						isa_EDI322code [ UpperBound ( isa_EDI322code ) + 1 ] = lnv_Company.of_GetEDI322Code ( )
//					END IF

			end choose

		end if
		
		lnv_shipment.of_getcarriercompany(lnv_company, TRUE)

		if isvalid (lnv_Company) then

			choose case lnv_company.of_GetRequiredRequestRole()

				case n_cst_constants.cs_RequestRole_any

					IF lb_Has214 THEN
						isa_EDI214code [ UpperBound ( isa_EDI214code ) + 1 ] = lnv_Company.of_GetEDI214Code ( )
					END IF

//					IF lb_Has322 THEN
//						isa_EDI322code [ UpperBound ( isa_EDI322code ) + 1 ] = lnv_Company.of_GetEDI322Code ( )
//					END IF

			end choose

		end if
		
		lnv_shipment.of_getagentcompany(lnv_company, TRUE)

		if isvalid (lnv_Company) then

			choose case lnv_company.of_GetRequiredRequestRole()

				case n_cst_constants.cs_RequestRole_any

					IF lb_Has214 THEN
						isa_EDI214code [ UpperBound ( isa_EDI214code ) + 1 ] = lnv_Company.of_GetEDI214Code ( )
					END IF

//					IF lb_Has322 THEN
//						isa_EDI322code [ UpperBound ( isa_EDI322code ) + 1 ] = lnv_Company.of_GetEDI322Code ( )
//					END IF

			end choose

		end if
		
		lnv_shipment.of_getforwardercompany(lnv_company, TRUE)

		if isvalid (lnv_Company) then

			choose case lnv_company.of_GetRequiredRequestRole()

				case n_cst_constants.cs_RequestRole_any

					IF lb_Has214 THEN
						isa_EDI214code [ UpperBound ( isa_EDI214code ) + 1 ] = lnv_Company.of_GetEDI214Code ( )
					END IF

//					IF lb_Has322 THEN
//						isa_EDI322code [ UpperBound ( isa_EDI322code ) + 1 ] = lnv_Company.of_GetEDI322Code ( )
//					END IF

			end choose

		end if
		
	end if
end if



//Determine if any 322 notifications should be issued


IF lb_Has322 = TRUE AND lnv_Event.of_HasSource ( ) THEN

	lla_Equipment = lla_Empty

	lnv_event.of_getsite(lnv_company, TRUE)

	if isvalid (lnv_Company) then

		IF lnv_Company.of_IsEDI322Site ( ) THEN

			//If it's an assignment event, just get the equipment that's "actively" involved in the event, 
			//ie, being hooked, dropped, mounted, dismounted, etc.  If it's not an assignment event, just
			//get a list of everything.

			IF lnv_Event.of_IsAssignment ( ) THEN

				lnv_Event.of_GetActiveAssignments ( lla_Drivers, lla_Equipment )

			ELSE

				lnv_Event.of_GetAssignments ( lla_Drivers, lla_Equipment )

			END IF

		END IF

	END IF


	ll_EquipmentCount = UpperBound ( lla_Equipment )

	IF ll_EquipmentCount > 0 THEN

		lnv_Dispatch.of_RetrieveEquipment ( lla_Equipment )

		lnv_Equipment = CREATE n_cst_beo_Equipment2
		lnv_Equipment.of_SetSource ( lnv_Dispatch.of_GetEquipmentCache ( ) )

	END IF


	FOR ll_Index = 1 TO ll_EquipmentCount

		lnv_Equipment.of_SetSourceId ( lla_Equipment [ ll_Index ] )

		CHOOSE CASE lnv_Equipment.of_GetEquipmentLease ( lnv_EquipmentLease )

		CASE 1

			ls_Line = lnv_EquipmentLease.of_GetLeaseLine ( )

			IF Len ( ls_Line ) > 0 THEN

				ls_322Code = ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI322Lines", ls_Line, "" )

				IF Len ( ls_322Code ) > 0 THEN

					isa_EDI322code [ UpperBound ( isa_EDI322code ) + 1 ] = ls_322Code

				END IF

			END IF

		END CHOOSE

	NEXT				

END IF



if upperbound(isa_edi214code) > 0 then
	//remove dupes
	lnv_arraysrv.of_getshrinked(isa_edi214code,true,true)
//else
//	ll_return = -1
end if

if upperbound(isa_edi322code) > 0 then
	//remove dupes
	lnv_arraysrv.of_getshrinked(isa_edi322code,true,true)
end if

//Note : This was returning -1 if there were no 214 codes.  I've changed this to return 0
//if there's no 214 or 322 codes.   --BKW, 322 revision.

IF UpperBound ( isa_EDI214Code ) = 0 AND UpperBound ( isa_EDI322Code ) = 0 THEN
	ll_Return = 0
END IF

DESTROY lnv_Shipment
DESTROY lnv_event 
DESTROY lnv_Company
DESTROY lnv_EquipmentLease
DESTROY lnv_Equipment

return ll_return
end function

public subroutine of_newmessage_van (n_cst_bso_dispatch anv_bso_dispatch, long al_event, string as_action);//Revised for 3.5.23 3-12-2003 by BKW to allow for EDI 322 off a non-shipment event.

long	ll_shipid, &
		ll_statusid, &
		ll_index, &
		ll_arraycount, &
		ll_322Status, &
		ll_322EquipmentStatus

string	ls_eventtype, &
			ls_action, &
			ls_setting, &
			ls_322Status, &
			ls_MessageHeader, &
			ls_Intermodal, &
			ls_billto, &
			ls_report
			
date		ld_event

time		lt_event

Boolean	lb_Has214, &
			lb_Has322, &
			lb_214Pending, &
			lb_322Pending, &
			lb_ShipmentEvent, &
			lb_Continue = TRUE, &
			lb_Retry, &
			lb_Tag

n_cst_events 			lnv_Events
n_cst_bso_dispatch	lnv_dispatch
n_cst_beo_event		lnv_event
n_cst_beo_Company		lnv_Site
n_ds						lds_newconfirmedevent
n_cst_LicenseManager	lnv_LicenseManager
n_cst_Selection		lnv_Selection
Any						laa_SelectionArgs[20], &
							laa_EmptyArgs[20], &
							laa_SelectionResults[]

lb_Has214 = lnv_LicenseManager.of_HasEDI214License ( )
lb_Has322 = lnv_LicenseManager.of_HasEDI322License ( )

setnull(ls_action)
setnull(ll_statusid)

lnv_event = CREATE n_cst_beo_event

lnv_dispatch = anv_bso_dispatch

lnv_Event.of_SetSource ( lnv_dispatch.of_GetEventCache ( ) )
lnv_Event.of_SetSourceId ( al_event )



IF lb_Continue THEN

	IF lnv_Event.of_HasSource ( ) THEN
	
		ll_ShipId = lnv_Event.of_GetShipment ( )

		if isnull(ll_shipid) or ll_shipid = 0 then

			lb_ShipmentEvent = FALSE

			//edi 214 update is only for shipment events.

			//In 3.5.23, we changed this to allow non-shipment 322 update.
			//So, lb_322Pending is determined by other criteria.  BKW

			lb_214Pending = FALSE

		else

			lb_ShipmentEvent = TRUE

			if lb_Has214 THEN

				lb_214Pending = TRUE  //Just an indication that it's a candidate, at this point.

			else
	
				lb_214Pending = FALSE
	
			end if

		end if
	
	ELSE
		lb_Continue = FALSE
	
	END IF

END IF



//If EDI322 is licensed and we're departing (confirming) the event, check to see if the site of the 
//event is an EDI322 site location.
//If not, a 322 message will not be applicable to this event.

IF lb_Continue AND lb_Has322 AND Upper ( as_Action ) = "DEPART" THEN

	IF lnv_Event.of_GetSite ( lnv_Site ) = 1 THEN

		IF lnv_Site.of_IsEDI322Site ( ) THEN

			lb_322Pending = TRUE

		END IF

	END IF

END IF



IF lb_Continue THEN

	IF lb_214Pending OR lb_322Pending THEN
		//OK, we potentially have something to generate.
	ELSE
		//Notification possibilities eliminated.
		lb_Continue = FALSE
	END IF

END IF


IF lb_Continue THEN

	//if it's a shipment event, load the shipment to cache

	IF lb_ShipmentEvent THEN
		lnv_dispatch.of_retrieveshipments ( { ll_ShipId } )   //Is this really needed?? -- it's done inside 
																				//of_CheckShipperEDIUpdate, too.   --BKW
	END IF

	if this.of_CheckShipperEDIUpdate_van(lnv_dispatch, al_event) = 1 then  //Loads the list of 214 and 322 codes to notify

		//OK

	ELSE

		lb_Continue = FALSE

	END IF

END IF


IF lb_Continue AND lb_214Pending THEN
	ls_eventtype = lnv_event.of_gettype()
	
	this.of_SetSourceShipmentId(ll_shipid)
	ls_intermodal = this.of_GetIntermodalMovetype() // INBOUND OUTBOUND

	if lnv_Events.of_IsTypePickupGroup ( ls_EventType ) THEN
		IF ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI214", "PICKUPGROUP", "" ) = "0" THEN
			ls_action = as_action + ls_Intermodal + lnv_Events.of_GetTypeDisplayValue(ls_EventType)
		else
			ls_action = as_action + ls_Intermodal + "PICKUP"
		END IF
	else
		if lnv_Events.of_IsTypeDeliverGroup ( ls_EventType ) THEN
			IF ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI214", "DELIVERGROUP", "" ) = "0" THEN
				ls_action = as_action + ls_Intermodal + lnv_Events.of_GetTypeDisplayValue(ls_EventType)
			ELSE
				ls_action = as_action + ls_Intermodal + "DELIVER"
			END IF
		end if
	end if
	
	if isnull(ls_action) then
		//no action
	else
		
		IF ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI214", "TAGORIGDEST", "" ) = "1" THEN
			lb_Tag = TRUE
		ELSE
			lb_Tag = FALSE
		END IF
		
		IF lnv_Event.of_GetSite() = inv_Shipment.of_GetOrigin() THEN
			IF lb_Tag THEN
				ls_action = ls_action + 'ORIG'
			END IF
		ELSE 
			IF lnv_Event.of_GetSite() = inv_Shipment.of_GetDestination() THEN
				IF lb_Tag THEN
					ls_action = ls_action + 'DEST'
				END IF
			ELSE
				//if a company needs to be reported to for non origin/destination events,
				//their sysid needs to be in the trucking.ini file
				//default don't report
				ls_billto = string(inv_Shipment.of_GetBillto())
				ls_report = ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI214NONORIGDEST", ls_billto, "" )
				IF len(ls_report) > 0 THEN
					//report, notice these tags don't have 'orig' or 'dest'
				ELSE
					//don't report
					setnull(ls_action)
				END IF
			END IF
		END IF
		
	end if

	if isnull(ls_action) then
		//no action
		lb_214Pending = FALSE
	else
		ll_arraycount = upperbound(isa_edi214code)

		for ll_index = 1 to ll_arraycount
			if this.of_getnotificationsetting(ls_action,isa_edi214code[ll_index],ls_setting) = 1 then
				
				ll_statusid = long(ls_setting)
				
				if isnull(ll_statusid) then
					//no edi update
				else
					this.of_loadnewevent(lnv_Event, lds_newconfirmedevent)	
					lds_newconfirmedevent.object.shipment_status_edi_status_id[1] = ll_statusid
					choose case upper(as_action)
						case "ARRIVE"
							lds_newconfirmedevent.object.shipment_status_status_date[1] = lnv_Event.of_GetDateArrived ( )
							lds_newconfirmedevent.object.shipment_status_status_time[1] = lnv_Event.of_GetTimeArrived ( )
						case "DEPART"
							lds_newconfirmedevent.object.shipment_status_status_date[1] = lnv_Event.of_GetDateDeparted ( )
							lds_newconfirmedevent.object.shipment_status_status_time[1] = lnv_Event.of_GetTimeDeparted ( )
					end choose
					this.of_Addtocache(lds_newconfirmedevent, ll_shipid, isa_edi214code[ll_index])
					DESTROY lds_newconfirmedevent
				end if		
			else
				//commented out nwl when intermodal was added. Not sure we need this anyway.
//				messagebox("EDI 214 Update", "No " + ls_action + &
//						" setting in the notification table for " + isa_edi214code[ll_index] + ".")						
			end if
		next
	end if

END IF //End 214



IF lb_Continue AND lb_322Pending THEN

	ll_arraycount = upperbound(isa_edi322code)

	IF ll_ArrayCount > 0 THEN

		//Try to get a value for the status header (EDI322:Q501 field)

		ls_MessageHeader = "EDI 322 Status Header"

		//Initialize the selection args with the segment and element values, which will be used as retrieval 
		//arguments in d_edi_status_selection

		laa_SelectionArgs = laa_EmptyArgs
		laa_SelectionArgs [ 1 ] = "Q5"
		laa_SelectionArgs [ 2 ] = "01"

		DO

			lb_Retry = FALSE

			CHOOSE CASE lnv_Selection.of_Open ( "d_edi_status_selection", laa_SelectionResults, SQLCA, { "id" }, &
				laa_SelectionArgs, ls_MessageHeader )
	
			CASE 1
				ll_322Status = laa_SelectionResults [ 1 ]   //edi_status.id for the Q501 field
	
			CASE IS > 1
				MessageBox ( ls_MessageHeader, "Too many selections -- Please retry." )
				lb_Retry = TRUE
	
			CASE 0
				CHOOSE CASE  MessageBox ( ls_MessageHeader, "Are you sure you want to cancel?  This means no EDI 322 message will be sent.", &
					Exclamation!, YesNo!, 1 )

				CASE 1  //Yes - cancel.
					//leave lb_Retry = FALSE

				CASE 2  //No - don't cancel.
					lb_Retry = TRUE

				CASE ELSE  //Unexpected return
					lb_Retry = TRUE

				END CHOOSE

			CASE ELSE  //Unexpected return

				CHOOSE CASE MessageBox ( ls_MessageHeader, "Error determining EDI 322 code selection.", Exclamation!, &
					RetryCancel!, 1 )

				CASE 1  //Retry
					lb_Retry = TRUE 

				CASE 2  //Cancel
					//leave lb_Retry = FALSE

				CASE ELSE  //Unexpected return
					lb_Retry = TRUE

				END CHOOSE

			END CHOOSE

		LOOP UNTIL lb_Retry = FALSE


		//If the status header (EDI322:Q501 field) was selected, now ask for the status detail (EDI322:W205).

		IF ll_322Status > 0 THEN

			ls_MessageHeader = "EDI 322 Status Detail"

			//Initialize the selection args with the segment and element values, which will be used as retrieval 
			//arguments in d_edi_status_selection
			laa_SelectionArgs = laa_EmptyArgs
			laa_SelectionArgs [ 1 ] = "W2"
			laa_SelectionArgs [ 2 ] = "05"	

			DO
	
				lb_Retry = FALSE
	
				CHOOSE CASE lnv_Selection.of_Open ( "d_edi_status_selection", laa_SelectionResults, SQLCA, { "id" }, &
					laa_SelectionArgs, ls_MessageHeader )
		
				CASE 1
					ll_322EquipmentStatus = laa_SelectionResults [ 1 ]  //edi_status.id for the W205 field
		
				CASE IS > 1
					MessageBox ( ls_MessageHeader, "Too many selections -- Please retry." )
					lb_Retry = TRUE
		
				CASE 0
					CHOOSE CASE  MessageBox ( ls_MessageHeader, "Are you sure you want to cancel?  This means no EDI 322 message will be sent.", &
						Exclamation!, YesNo!, 1 )
	
					CASE 1  //Yes - cancel.
						//leave lb_Retry = FALSE
	
					CASE 2  //No - don't cancel.
						lb_Retry = TRUE
	
					CASE ELSE  //Unexpected return
						lb_Retry = TRUE
	
					END CHOOSE
	
				CASE ELSE  //Unexpected return
	
					CHOOSE CASE MessageBox ( ls_MessageHeader, "Error determining EDI 322 code selection.", Exclamation!, &
						RetryCancel!, 1 )
	
					CASE 1  //Retry
						lb_Retry = TRUE 
	
					CASE 2  //Cancel
						//leave lb_Retry = FALSE
	
					CASE ELSE  //Unexpected return
						lb_Retry = TRUE
	
					END CHOOSE
	
				END CHOOSE
	
			LOOP UNTIL lb_Retry = FALSE

		END IF


		IF ll_322Status > 0 AND ll_322EquipmentStatus > 0 THEN
			//OK -- selection made
		ELSE
			lb_322Pending = FALSE
		END IF

	END IF

END IF


IF lb_Continue AND lb_322Pending THEN

	for ll_index = 1 to ll_arraycount

		this.of_loadnewevent(lnv_Event, lds_newconfirmedevent)	
		lds_newconfirmedevent.object.shipment_status_edi_status_id[1] = ll_322Status
		lds_newconfirmedevent.object.shipment_status_edi_reason_id[1] = ll_322EquipmentStatus
		lds_newconfirmedevent.object.shipment_status_status_date[1] = lnv_Event.of_GetDateDeparted ( )
		lds_newconfirmedevent.object.shipment_status_status_time[1] = lnv_Event.of_GetTimeDeparted ( )
		this.of_Addtocache(lds_newconfirmedevent, ll_shipid, isa_edi322code[ll_index])
		DESTROY lds_newconfirmedevent

	next

END IF  //End 322


DESTROY lnv_event
end subroutine

public function integer of_newmessage_van (n_cst_msg anv_msg);Long	ll_EventID, &
		ll_shipid, &
		ll_Return = 1
n_ds	lds_Data
n_ds	lds_rtnData
n_cst_beo_event	lnv_event
n_cst_bso_dispatch	lnv_dispatch

lnv_event = CREATE n_cst_beo_Event

if ll_return = 1 then
	n_cst_Msg	lnv_Msg
	S_Parm		lstr_Parm
	
	IF anv_Msg.of_Get_Parm ( "EVENTID" , lstr_parm ) <> 0 THEN
		ll_EventID	= lstr_Parm.ia_Value
	END IF
	
	//GET SHIPMENT ID
	IF anv_Msg.of_Get_Parm ( "DISPATCH" , lstr_parm ) <> 0 THEN
		lnv_dispatch	= lstr_Parm.ia_Value
	END IF

	if this.of_CheckShipperEDIUpdate_van(lnv_dispatch, ll_EventID) = 1 then
		
		lnv_Event.of_SetSource ( lnv_dispatch.of_GetEventCache ( ) )
		lnv_Event.of_SetSourceId ( ll_EventID )
		
		IF lnv_Event.of_HasSource ( ) THEN
			ll_shipid = lnv_Event.of_getshipment()
			
			if isnull(ll_shipid ) or ll_shipid = 0 then
				//edi update is only for shipment events
				ll_return = -1
			else
				//load shipment to cache
				lnv_dispatch.of_retrieveshipments({ll_shipid})
				THIS.of_LoadNewEvent ( lnv_event , lds_Data )
			end if
		END IF
		
		if ll_return = 1 then
			lstr_parm.is_Label = "DATA"
			lstr_Parm.ia_Value = lds_Data
			lnv_Msg.of_Add_Parm ( lstr_Parm ) 
			
			lstr_parm.is_Label = "NEW"
			lstr_Parm.ia_Value = TRUE
			lnv_Msg.of_Add_Parm ( lstr_Parm ) 
			
			OpenWithParm ( w_shipmentStatus_details_van , lnv_Msg )
			
			lds_rtnData = Message.powerobjectParm
			
			IF IsValid ( lds_rtnData ) THEN
				
				THIS.of_AddToCache ( lds_rtnData, ll_shipid, isa_edi214code[1] )
				
			END IF
		end if
		
	else
		ll_return = -1
	end if

end if

DESTROY ( lnv_event )

RETURN ll_return 



end function

public function string of_getcontrolnumber ();//Function Moved from n_cst_transaction so that this can be instantiated on the edishipmentProcessManager
//as well as from the transaction objects.
//Moved by Dan on 2-7-2006
long		ll_nextid
string	ls_ControlNumber		

CONSTANT Boolean cb_Commit	= TRUE	

IF gnv_App.of_GetNextId ( "edicontrol", ll_NextId, cb_Commit ) = 1 THEN
	//edi system can't handle number larger than 99999
	if ll_nextid > 99999 then
		//	Reset next id for 'EDICONTROL'
		 UPDATE "nextids" SET "nextid" = 2 WHERE "nextids"."classid" = 12   ;
		commit;
		ls_controlnumber = "000000001"
	else
		ls_controlnumber = string(ll_NextId,"000000000")		
	end if
END IF

return ls_controlnumber

end function

public function string of_appendtoprocessedlocationpath (string as_root);//Final resting spot for this code that used to be called from n_cst_editTransaction_204 and
//n_cst_edi_shipmentmanager
n_cst_Settings	lnv_Settings
Any la_Result

Integer	li_Day

String	ls_Return, &
			ls_Week
			
n_cst_filesrvwin32	lnv_filesrv

SetNull ( ls_Return ) 


ls_Return = as_Root

IF Right ( ls_Return , 1 ) <> "\" THEN
	ls_Return += "\"
END IF

li_Day = Day ( Today () )

choose case li_Day
	case is < 8
		ls_Week = "week1"
	case is < 16
		ls_Week = "week2"
	case is < 22
		ls_Week = "week3"
	case is < 29
		ls_Week = "week4"
	case is < 32
		ls_Week = "week5"
end choose

ls_return += String ( Today (), "YYYY" )

lnv_filesrv = create n_cst_filesrvwin32

if lnv_filesrv.of_Directoryexists( ls_return ) then
	//on to next folder
else
	lnv_filesrv.of_createdirectory( ls_return )
end if

ls_return += "\" + String ( Today (), "MMM" )

if lnv_filesrv.of_Directoryexists( ls_return ) then
	//on to next folder
else
	lnv_filesrv.of_createdirectory( ls_return )
end if
	
ls_return += "\" + ls_Week

if lnv_filesrv.of_Directoryexists( ls_return ) then
	//on to next folder
else
	lnv_filesrv.of_createdirectory( ls_return )
end if

destroy lnv_filesrv
	
RETURN	ls_Return
end function

private function boolean of_indatabaseedipendingtable (integer ai_transaction, long al_sourceid, string as_source, string as_action, datastore ads_databasecache);//Written by dan 6-12-2006, written after a bug was found from moving the 214 from the scheduler.
//Basically there would be a db error 3 when saving after removing a confim even from a 
//shipment after the scheduler had already sent the file.  This function is meant to be
//called in of_savePending cache for each row in the delete buffer.  When this returns
//true, the row exists in the database edipending table and it is ok to delete it.
//IF false, the row should be discarded by the of_savePendingCahce before the update.


Boolean lb_return
Long	ll_count
Long	ll_index
String	ls_find

ll_count = ads_databasecache.rowCount()

ls_find 	= "transactionset = "+ string( ai_transaction ) &
		  	+ " AND sourceId = "+ string( al_sourceid ) &
			+ " AND source = '"+as_source+"'" &
			+ " AND action = '"+as_action+"'"

ll_index = ads_databasecache.Find ( ls_find, 1, ll_count )

lb_return = ll_index > 0 

RETURN lb_return
end function

on n_cst_bso_edimanager.create
call super::create
end on

on n_cst_bso_edimanager.destroy
call super::destroy
end on

event destructor;call super::destructor;IF isvalid(ids_edieventcache) then
	destroy ids_edieventcache
end if

IF isvalid(ids_ProfileCache) THEN
	destroy ids_profilecache
END IF

IF isvalid(ids_PendingCache) THEN
	destroy(ids_PendingCache)
END IF

IF ib_destroydisp THEN
	DESTROY (  inv_Dispatch )
END IF

IF ib_destroyship THEN
	DESTROY ( inv_Shipment ) 
END IF

end event

