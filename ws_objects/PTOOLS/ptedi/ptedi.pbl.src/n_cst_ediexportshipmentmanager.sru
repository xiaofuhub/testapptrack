$PBExportHeader$n_cst_ediexportshipmentmanager.sru
forward
global type n_cst_ediexportshipmentmanager from n_base
end type
end forward

global type n_cst_ediexportshipmentmanager from n_base
end type
global n_cst_ediexportshipmentmanager n_cst_ediexportshipmentmanager

type variables
n_ds	ids_exportedShipments
datastore	ids_pending

Constant String cs_shipMentStatus_accepted = "A"
Constant String cs_shipMentStatus_declined = "D"
Constant	String cs_shipmentStatus_offered = "O"

Constant String cs_gen204Request_original = "O"
Constant String cs_gen204Request_change = "CH"
Constant String cs_gen204Request_Cancel = "C"
Constant String cs_cancelby214_cancel	= "CA"

Constant int	ci_processed_processed = 1
Constant int	ci_processed_pending = 0
Constant int	ci_processed_error = -1

n_cst_errorlog_manager inv_errorLogManager
end variables

forward prototypes
public function n_ds of_getcache ()
public function string of_getcarrierscac (long al_id)
public function string of_getfromscac ()
public function integer of_orderaccepted (long al_shipid)
public function integer of_orderoffered (long al_shipid)
public function integer of_addentryoriginal (long al_shipid, string as_toscac, ref string as_message)
public function integer of_addentrychange (long al_shipid, string as_toscac, ref string as_message)
public function integer of_addentrycancel (long al_shipid, string as_toscac, ref string as_message)
public function integer of_addrequeststoexportedshipmentstable ()
public function integer of_process214 (long al_eventid, string as_eventcode, datetime adt_eventtime, long al_groupcontrolnumber, string as_senderscode, long al_transactioncontrolnumber)
public function integer of_214eventlogic ()
public function integer of_cancelshipment (long al_shipid, datetime adt_eventdatetime)
protected function integer of_autoconfirm214 (n_cst_beo_event anv_event)
public function n_cst_errorlog_manager of_geterrorlogmanager ()
public function integer of_process990 (long al_shipid, string as_response, string as_reason, string as_senderscode)
public function integer of_addshiptopendingexport (long al_shipid, string as_scac, string as_purpose)
public function datastore of_getpendingrequestcache ()
public function integer of_getlastshipmentinfo (long al_shipid, ref string as_scac, ref string as_purpose)
public function long of_getpendingid ()
public function integer of_addexportedshipment (n_cst_beo_shipment anv_shipment, string as_toscac, string as_purpose, ref string as_message, date ad_reqdate, time at_reqtime)
private function integer of_cleanupexportcache (long al_shipid, string as_toscac, string as_purpose)
public function integer of_update ()
public function integer of_updatespending ()
end prototypes

public function n_ds of_getcache ();//ALWAYS RETURNS A NON FILTERED CACHE OF THE EXPORTED SHIPMENT TABLE
IF NOT isValid( ids_exportedShipments ) THEN
	ids_exportedShipments = create n_ds
	ids_exportedShipments.dataobject = "d_edi_exportedshipments"
	ids_exportedShipments.settransobject(SQLCA)
	
	ids_exportedShipments.retrieve()	//retrieves all exported shipments
END IF

ids_exportedShipments.setfilter("")
ids_exportedshipments.filter()
ids_exportedshipments.setSort( "req_date A, req_time A" )
ids_exportedshipments.sort()

RETURN ids_exportedShipments
end function

public function string of_getcarrierscac (long al_id);String	ls_scac
String	ls_inbound  
Long		ll_transaction = 204

ls_inbound = appeon_constant.cs_transaction_OUTBOUND
Select scac into :ls_scac FROM ediprofile Where companyid = :al_ID and transactionset =:ll_transaction AND in_out =:ls_inbound ;

CHOOSE CASE SQLCA.SQLCODE
	CASE 100
		setNull(ls_scac)
		Commit;
	CASE 0
		//found
		Commit;
	CASE -1
		SetNull(ls_scac)
		Rollback;
END CHOOSE
		

RETURN ls_scac
end function

public function string of_getfromscac ();String	ls_scac

n_cst_edi_transaction lnv_transaction

lnv_transaction = create n_cst_edi_transaction

ls_scac = lnv_transaction.of_getscac( )
DESTROY lnv_transaction

RETURN ls_scac
end function

public function integer of_orderaccepted (long al_shipid);/*
	This function returns 1 if the shipment already exists in the cache, and it has already been accepted
	via 990.  It returns -1 if it has not.
*/

Int	li_return = 1
Long	ll_max
Long	ll_index
n_ds	lds_cache
String	ls_find


lds_cache = this.of_getCache( )

ls_find = "shipid = "+ string( al_shipId ) + " and status = '" +cs_shipMentStatus_accepted +"'"

li_Return = lds_cache.find( ls_find, 1, lds_cache.rowCount())

RETURN li_Return
end function

public function integer of_orderoffered (long al_shipid);/*
	This function returns 1 if the shipment already exists in the cache, and it has already been accepted
	via 990.  It returns -1 if it has not.
*/

Int	li_return = 1
Long	ll_max
Long	ll_index
n_ds	lds_cache
String	ls_find


lds_cache = this.of_getCache( )

ls_find = "shipid = "+ string( al_shipId ) + " and status = '" +cs_shipMentStatus_offered +"'"

li_Return = lds_cache.find( ls_find, 1, lds_cache.rowCount())
RETURN li_Return
end function

public function integer of_addentryoriginal (long al_shipid, string as_toscac, ref string as_message);/*
	Returns 1 if its added, -1 if its not and returns a message as to why.
	
	This is the logic...it assumes the events are in order from first to last.
	CHOOSE CASE lastEvent


Generation doesn't look at the Pending requests to determine whether or not it will happen.  
The reason for this is because we would have to evaluate every request before the current 
request to determine all the requests that would successfully be added to the real cache 
when the scheduler picked them up.  It seemed like doing such a thing would be a source 
of a error as far as concurrent request adds and scheduler retrievals and deletes.  I think 
it would be risky for db error 3s.
*/

Int		li_Return = 1
Int		li_processed
Int		li_lastOriginalProcessed
Long		ll_index
Long		ll_max

String	ls_find
String	ls_lastPurpose

Boolean	lb_checkLastevent
n_ds	lds_exports

//I filter down and sort because adding is only allowed based on pre existance of the request, as well as
//the last request.
lds_exports = this.of_getcache( )
lds_exports.setfilter( "shipid = "+ string( al_shipId )+ " AND to_scac = '"+as_toscac+"'" )
lds_exports.filter()
lds_exports.setSort( "req_date A, req_time A" )
lds_exports.sort()

ll_max = lds_exports.rowcount( )

//the purpose of this find is to find the last original processed status.  If it was processed then
//it we may not want to add another one. If it failed then we will want to.
ls_find =  "purpose = '"+cs_gen204Request_original+"'"
ll_index = lds_exports.find( ls_find, ll_max, 1 )
IF ll_index > 0 THEN
	li_lastOriginalProcessed = lds_exports.getItemNumber( ll_index, "processed" )
ELSE
	setNull(li_lastOriginalProcessed)
END IF

IF ll_max > 0 THEN
	ls_lastPurpose = lds_exports.getItemString( ll_max, "purpose" )
	li_processed = lds_exports.getItemNumber( ll_max, "processed" )
ELSE
	ls_lastPurpose = "NOHISTORY"
END IF


//IF the last original failed to be processed then it was never sent so we can readd it.
CHOOSE CASE li_lastOriginalProcessed
	CASE ci_processed_processed, ci_processed_pending
		//can't determine, must do it based on last event.
		lb_checkLastevent = true
	CASE ci_processed_error
		li_return = 1	
	CASE ELSE
		//null, never existed
		li_return = 1
END CHOOSE

IF lb_checkLastevent THEN
	CHOOSE CASE ls_lastpurpose
		CASE cs_gen204Request_original
			CHOOSE CASE li_processed
				CASE ci_processed_processed
					li_return = 1  //ok to readd, this scenereo would be used if they failed to get it the 204 the first time.
				CASE ci_processed_pending
					li_return = -1 //its already there
					as_message = "There is a preexisting, pending 204 request for the shipment.  Action cancelled."
				CASE ci_processed_error
					li_return = 1  //it failed to go once so we can add it and try again
			END CHOOSE
		CASE cs_gen204Request_change
			li_return = -1			//the fact that this is in here means that it was already offered.
			as_message = ""
		CASE cs_gen204Request_cancel
			li_return = 1			//we can reoffer if our last was a cancel
		CASE "NOHISTORY"
			li_return = 1			//first entry no problem
	END CHOOSE
END IF
		
	



RETURN li_return
end function

public function integer of_addentrychange (long al_shipid, string as_toscac, ref string as_message);/*
	Returns 1 if its ok to add a change order for the specified shipment
			-1 if it isn't
			
*/

Int		li_Return = 1
Int		li_processed
Int		li_lastOriginalProcessed
Long		ll_index
Long		ll_max

String	ls_find
String	ls_lastPurpose
Boolean	lb_checkLastevent
n_ds	lds_exports

//I filter down and sort because adding is only allowed based on pre existance of the request, as well as
//the last request.
lds_exports = this.of_getcache( )
lds_exports.setfilter( "shipid = "+ string( al_shipId )+ " AND to_scac = '"+as_toscac+"'" )
lds_exports.filter()
lds_exports.setSort( "req_date A, req_time A" )
lds_exports.sort()

ll_max = lds_exports.rowcount( )

//the purpose of this find is to find the last original processed status.  If it was processed then
//it we may not want to add another one. If it failed then we will want to.
ls_find =  "purpose = '"+cs_gen204Request_original+"'"
ll_index = lds_exports.find( ls_find, ll_max, 1 )
IF ll_index > 0 THEN
	li_lastOriginalProcessed = lds_exports.getItemNumber( ll_index, "processed" )
ELSE
	setNull(li_lastOriginalProcessed)
END IF

IF ll_max > 0 THEN
	ls_lastPurpose = lds_exports.getItemString( ll_max, "purpose" )
	li_processed = lds_exports.getItemNumber( ll_max, "processed" )
ELSE
	ls_lastPurpose = "NOHISTORY"
END IF


//IF the last original failed to be processed then it needs to be resent before we can send any change orders
CHOOSE CASE li_lastOriginalProcessed
	CASE ci_processed_processed, ci_processed_pending
		//can't determine, must do it based on last event.
		lb_checkLastevent = true
	CASE ci_processed_error	
		li_return = -1
		as_message = "Cannot add change order for shipment "+ string(al_shipid)+", the original 204 failed to be sent, and must be sent out before a change order can be completed."
	CASE ELSE
		//null, never existed
		li_return = -1
		as_message = "Cannot add change order for shipment "+ string(al_shipid)+", an original 204 must be sent first."
END CHOOSE

IF lb_checkLastevent THEN
	CHOOSE CASE ls_lastpurpose
		CASE cs_gen204Request_original
			li_Return = 1
		CASE cs_gen204Request_change
			CHOOSE CASE li_processed
				CASE ci_processed_processed
					li_return = 1
				CASE ci_processed_pending
					li_return = -1  
					as_message ="There is a pending change order for that shipment. Action canelled."
				CASE ci_processed_error
					li_return = 1	//we can resend it if the last change order failed to be processed.
			END CHOOSE
		CASE cs_gen204Request_cancel
			li_return = -1			
			as_message = "A cancel request has been made on the shipment, the shipment must be reoffered before change orders can go through."
		CASE "NOHISTORY"
			li_return = -1			//first entry no problem
			as_message = "There is no history of an original 204 for shipment "+string(al_shipid)+", an original 204 must be generated before any change orders can go through."
	END CHOOSE
END IF
		
RETURN li_return
end function

public function integer of_addentrycancel (long al_shipid, string as_toscac, ref string as_message);/*
	Returns 1 if its ok to add a change order for the specified shipment
			-1 if it isn't
			
	CHOOSE CASE lastEvent
		CASE CANCEL
			if processed then
				add = false
			else
				add = true
		CASE offered
			add = true
		case change
			add = true
		case no history
			add = false

*/

Int		li_Return = 1
Int		li_processed
Int		li_lastOriginalProcessed
Long		ll_index
Long		ll_max

String	ls_find
String	ls_lastPurpose
Boolean	lb_checkLastevent
n_ds	lds_exports

//I filter down and sort because adding is only allowed based on pre existance of the request, as well as
//the last request.
lds_exports = this.of_getcache( )
lds_exports.setfilter( "shipid = "+ string( al_shipId )+ " AND to_scac = '"+as_toscac+"'" )
lds_exports.filter()
lds_exports.setSort( "req_date A, req_time A" )
lds_exports.sort()

ll_max = lds_exports.rowcount( )

//the purpose of this find is to find the last original processed status.  If it was processed then
//it we may not want to add another one. If it failed then we will want to.
ls_find =  "purpose = '"+cs_gen204Request_original+"'"
ll_index = lds_exports.find( ls_find, ll_max, 1 )
IF ll_index > 0 THEN
	li_lastOriginalProcessed = lds_exports.getItemNumber( ll_index, "processed" )
ELSE
	setNull(li_lastOriginalProcessed)
END IF

IF ll_max > 0 THEN
	ls_lastPurpose = lds_exports.getItemString( ll_max, "purpose" )
	li_processed = lds_exports.getItemNumber( ll_max, "processed" )
ELSE
	ls_lastPurpose = "NOHISTORY"
END IF


//IF the last original failed to be processed then it was never sent so we cannot send a cancel.
CHOOSE CASE li_lastOriginalProcessed
	CASE ci_processed_processed, ci_processed_pending
		//can't determine, must do it based on last event.
		lb_checkLastevent = true
	CASE ci_processed_error	
		li_return = -1
		as_message = "Cannot add cancel order for shipment "+ string(al_shipid)+", the original 204 failed to be sent, and must be sent out before a cancel order can be completed."
	CASE ELSE
		//null, never existed
		li_return = -1
		as_message = "Cannot add cancel order for shipment "+ string(al_shipid)+", there is no record of an original 204 for this shipment."
END CHOOSE

IF lb_checkLastevent THEN
	CHOOSE CASE ls_lastpurpose
		CASE cs_gen204Request_original
			li_Return = 1
		CASE cs_gen204Request_change
			li_return = 1	//we can resend it if the last change order failed to be processed.
		CASE cs_gen204Request_cancel
			CHOOSE CASE li_processed
				CASE ci_processed_processed,ci_processed_pending
					li_Return = -1
					as_message = "A cancel request has already been made on the shipment, action cancelled. "
				CASE ci_processed_error
					li_return = 1
			END CHOOSE	
			
		CASE "NOHISTORY"
			li_return = -1			//first entry no problem
			as_message = "There is no history of an original 204 for shipment "+string(al_shipid)+", an original 204 must be generated before any cancel orders can go through."
	END CHOOSE
END IF
		
RETURN li_return
end function

public function integer of_addrequeststoexportedshipmentstable ();/*
	This function goes through the pending requests for generating 204s in order and attempts to add
	them to the exported shipment table.  It then clears out all the requests.  Returns 1 if success
	-1 if failed.
*/
Int	li_return = 1
Long	ll_max
Long	ll_index
Long	ll_id
Long	lla_ids[]

String	ls_scac
String	ls_message
String	ls_purpose
String	ls_find
Time	lt_reqtime
Date	ld_reqDate

n_cst_bso_dispatch	lnv_dispatch
N_cst_beo_shipment	lnv_shipment

datastore	lds_pending
n_cst_anyArraySrv lnv_arraySrv
lnv_dispatch = create n_cst_bso_dispatch



lds_pending = create datastore
lds_pending.dataobject = "d_edipending204out"
lds_pending.settransobject(SQLCA)
ll_max = lds_pending.retrieve()
commit;

lds_pending.setSort( "req_date A, req_time A, req_id A")
lds_pending.sort( )


FOR ll_index = 1 TO ll_max
	lla_ids[ll_index] = lds_pending.getItemNumber( ll_index, "shipId" )
NEXT

//gather all the information i will need about the shipment to try and add it to the exported shipment table.
lnv_ArraySrv.of_getShrinked( lla_ids, true, true )
lnv_dispatch.of_retrieveshipments( lla_ids )
FOR ll_index = 1 TO ll_max
	ll_id = lds_pending.getItemNumber( ll_index, "shipId" )
	ls_scac = lds_pending.getItemString( ll_index, "to_scac")
	ls_purpose = lds_pending.getItemString( ll_index, "purpose")
	ld_reqDate = lds_pending.getItemdate( ll_index, "req_date")
	lt_reqtime = lds_pending.getItemtime( ll_index, "req_time")
	lnv_shipment = create n_cst_beo_shipment
	lnv_shipment.of_setsource( lnv_dispatch.of_getshipmentcache( ) )
	lnv_shipment.of_setsourceid( ll_id)
	
	IF lnv_shipment.of_hasSource( ) THEN
		this.of_addexportedshipment( lnv_shipment, ls_scac, ls_purpose, ls_message, ld_reqDate, lt_reqtime )
	END IF
	DESTROY lnv_shipment
NEXT

//delete all the requests.
FOR ll_index = ll_max TO 1 STEP -1 
	lds_pending.deleterow( ll_index)
NEXT

IF lds_pending.update( ) = 1 THEN
	li_return = 1
	commit;
ELSE
	li_return = -1
	rollback;
END IF



RETURN li_return
end function

public function integer of_process214 (long al_eventid, string as_eventcode, datetime adt_eventtime, long al_groupcontrolnumber, string as_senderscode, long al_transactioncontrolnumber);/*
	DEK 3-13-07
	
	The purpose of this function is to make an entry in the edi_imported214 table for the event  with the specified
	code  and time.  
*/

Int	li_Return = 1
long	ll_max
Long	ll_index
String	ls_find
String	ls_message
String	ls_info
n_ds	lds_214importCache
n_cst_errorlog_manager lnv_errorLogManager

lds_214importCache = create n_ds
lds_214importCache.dataobject = "d_ediimported214status"
lds_214importCache.setTransobject( SQLCA )

ll_max = lds_214importCache.retrieve( )
commit;

lnv_errorLogManager = this.of_Geterrorlogmanager( )
ls_info ="Event Id: "+ string(al_eventId)+ " Event Code: "+as_eventCode +&
							"~r~nEvent Time: "+ string( adt_eventTime ) + " Groupcontrol Number: "+ string(al_groupControlNumber)+&
							"~r~nSCAC: "+ as_senderscode + " Transaction Control Number: "+ string( al_transactioncontrolnumber )
ls_find = "groupcontrol = "+ string( al_groupControlNumber )+ " AND transactionnumber = "+ string( al_transactioncontrolnumber ) + " AND senderscode = '"+ as_senderscode+"'"

ll_index = lds_214importCache.find( ls_find, 1, ll_max )

IF ll_index > 0 THEN
	//cannot add this
	li_return = -1
	ls_message = "Couldn't add 214 to be processed.  There is already an entry in the 214 table that matches the criteria:~r~n"+ ls_info
	lnv_errorLogManager.of_logerror( "EDI Inbound 214", "Process 214", ls_message, n_cst_constants.ci_ErrorLog_Urgency_Severe, {al_eventId}, "n_cst_errorremedy_edi")
ELSE
	ll_index = lds_214importCache.insertrow( 0 )
	
	lds_214importCache.setItem( ll_index, "groupcontrol", al_groupControlNumber)
	lds_214importCache.setItem( ll_index, "transactionnumber", al_transactioncontrolNumber)
	lds_214importCache.setItem( ll_index, "eventid", al_eventid)
	lds_214importCache.setItem( ll_index, "eventdatetime", adt_eventtime)
	lds_214importCache.setItem( ll_index, "senderscode", as_senderscode )
	lds_214importCache.setItem( ll_index, "eventcode", as_eventcode )
	lds_214importCache.setItem( ll_index, "processed", 0)
	
	IF lds_214importCache.update( ) =1 THEN
		commit;
	ELSE
		li_Return = -1
		rollback;
		ls_message = "Couldn't update 214 inbound cache.  "+ ls_info
		lnv_errorLogManager.of_logerror( "EDI Inbound 214", "Process 214", ls_message, n_cst_constants.ci_ErrorLog_Urgency_Severe, {al_eventId}, "n_cst_errorremedy_edi")
	END IF
END IF

destroy lds_214importCache
RETURN li_Return
end function

public function integer of_214eventlogic ();/*
	DEK 3-14-07
	
	The purpose of this function is to go through the unprocessed imported 214 entries and attempt
	to set times on the correct fields to confirm the events.  Returns -1 if update fails,
	1 if it succeeds.
*/
Int	li_Return = 1
Long	ll_max
Long	ll_index
Long	ll_eventId
Long	lla_eventIds[]
Long	ll_shipId


Long	ll_profileMax
String	ls_scac
String	ls_autoConfirm
String	ls_errorMessage = "EDI Inbound 214~r~n"
String	ls_eventInfo
String	ls_groupControl
String	ls_transactionControl
String	ls_idList
Long		ll_null

Boolean	lb_setProcessed


DateTime ldt_eventdatetime
Date		ld_eventdate
Time		lt_eventTime
int	li_temp
n_cst_errorlog_manager lnv_errorLogManager

String	ls_eventCode
n_ds	lds_214importCache
n_ds	lds_214CompanyProfile

n_cst_bso_dispatch	lnv_dispatch
n_cst_anyarraysrv		lnv_arraysrv
n_cst_beo_event		lnv_event
n_cst_beo_shipment	lnva_shipment[]

lds_214importCache = create n_ds
lds_214importCache.dataobject = "d_ediimported214status"
lds_214importCache.setTransobject( SQLCA )

ll_max = lds_214importCache.retrieve( )
commit;

lds_214CompanyProfile = create n_ds
lds_214CompanyProfile.dataobject = "d_214companies_in"
lds_214CompanyProfile.settransobject( SQLCA )
lds_214CompanyProfile.retrieve()
commit;

lds_214importCache.setfilter( "processed = 0")
lds_214importCache.filter( )

lnv_dispatch = create n_cst_bso_dispatch
ll_max = lds_214importCache.rowcount( )

FOR ll_index = 1 TO ll_max
	ll_eventid = lds_214importCache.getitemnumber( ll_index, "eventid")
	lla_eventIds[ll_index] = ll_eventId
NEXT

lnv_arraysrv.of_getShrinked( lla_eventIds, true, true)
lnv_dispatch.of_retrieveevents( lla_eventIds )
SetNull( ll_null )
FOR ll_index = 1 TO UpperBound( lla_eventIds )
	IF Mod( ll_index, 5 ) = 0 THEN
		ls_idList +="~r~n"
	END IF
	ls_idList += string( lla_eventIds )
NEXT

lnv_errorLogManager = this.of_getErrorlogmanager( )
FOR ll_index = 1 TO ll_max
	lb_setProcessed = false
	ls_autoConfirm = "NO!"
	ll_eventid = lds_214importCache.getitemnumber( ll_index, "eventid")
	ls_eventCode = lds_214importCache.getItemString( ll_index, "eventcode")
	ls_scac = lds_214importCache.getItemString( ll_index, "senderscode" )
	ls_groupControl = String(lds_214importCache.getItemNumber( ll_index, "groupcontrol" ))
	ls_transactionControl = String(lds_214importCache.getItemNumber( ll_index, "transactionnumber" ))
	
	ls_eventInfo = "Event ID: "+ string(ll_eventId)+ ", Event Code: "+ ls_eventCode + " SCAC: "+ ls_scac+ &
						"~r~n"+"Group Control: "+ ls_groupControl+ ", Transaction Number: "+ ls_transactionControl+ "~r~n"
	
	IF not IsNull( ls_eventInfo ) THEN
		ls_errormessage = ls_eventInfo
	ELSE
		ls_errormessage = ""
	END IF
	
	lds_214CompanyProfile.setfilter( "ediprofile_scac = '"+ ls_scac +"'" )
	lds_214CompanyProfile.filter()
	
	ll_profileMax = lds_214CompanyProfile.rowCount()
	IF ll_profileMax > 0 THEN
		ls_autoConfirm = lds_214CompanyProfile.getItemString( ll_profileMax , "edi214profile_confirmevent" )
	END IF
	
	IF ll_eventId > 0 THEN
		
		ldt_eventdatetime = lds_214importCache.getitemdatetime( ll_index, "eventdatetime")
		ld_eventdate = date( ldt_eventdatetime )
		lt_eventtime = time( ldt_eventdatetime )
		IF not IsNull( ld_eventdate ) AND not IsNull( lt_eventTime )  THEN
			
			//get the event beo
			lnv_event = create n_cst_beo_event
			lnv_event.of_setsource( lnv_dispatch.of_geteventcache( ) )
			lnv_event.of_setsourceid( ll_eventId )
			lnv_event.of_setallowfilterset( true)
			
			IF lnv_event.of_hassource( ) THEN
				ll_shipId = lnv_event.of_getshipment( )
				lnv_dispatch.of_retrieveshipment( ll_shipId )
				lnv_dispatch.of_getShipments( {ll_shipId}, lnva_shipment)
				IF upperBound( lnva_shipment ) > 0 THEN 	
					lnv_event.of_setShipment( lnva_shipment[1])
			
				END IF
				
				CHOOSE CASE ls_eventcode
					CASE "X3",  "X1"	//complete arrival at pickup location, complete arrival at del location, 
						li_temp  = lnv_event.of_setdatearrived( ld_eventDate )
						IF li_temp = 1 THEN		//DEK 5-23-07 no longer sets process to 1 if it fails to set a time
							li_temp = lnv_event.of_settimearrived( lt_eventTime )
						END IF
						IF li_Temp = 1 THEN		//DEK 5-23-07 no longer sets process to 1 if it fails to set a time
							lb_setprocessed = true
						ELSE
							ls_errormessage += "Error setting arrival date and time.  The event may have already been confirmed. Set Date/Time: "+String(ld_eventDate)+" "+ string(lt_eventtime)
						END IF
					CASE "AF", "CD"  	//complete departure at pickup location,complete dep at del location	
						li_temp = lnv_event.of_settimedeparted( lt_eventTime)	//looks like the date is set when the arrival is set
						IF li_temp = 1 THEN			//DEK 5-23-07 no longer sets process to 1 if it fails to set a time			
							lb_setProcessed = true
						ELSE
							ls_errormessage += "Error setting depart date and time. The event may have already been confirmed. Set Date/Time: "+String(ld_eventDate)+" "+ string(lt_eventtime)
						END IF
					CASE "AA", "AB"	//set appt dat/time for pickup, set appt dat/time for del
						li_temp = lnv_event.of_setscheduleddate( ld_eventdate )
						IF li_temp = 1 THEN			//DEK 5-23-07 no longer sets process to 1 if it fails to set a time	
							li_temp = lnv_event.of_setscheduledtime( lt_eventTime )
						END IF
						IF li_temp = 1 THEN			//DEK 5-23-07 no longer sets process to 1 if it fails to set a time	
							lb_setProcessed = true
						ELSE
							ls_errormessage += "Error setting appointment date and time. Set Date/Time: "+String(ld_eventDate)+" "+ string(lt_eventtime)
						END IF
					CASE "CA"	//Carrier has cancelled the shipment.
						//we want to update the exported shipments table with a status of cancelled and update the date and time.
						ll_shipId = lnv_event.of_getshipment( )
						lnva_shipment[1].of_setallowfilterset( true )
						li_temp = lnva_shipment[1].of_setcarrier( ll_null )			//DEK 5-23-07  we clear the carrier on the shipment if its been cancelled.
						this.of_cancelShipment( ll_shipid, ldt_eventdatetime )
						lb_setProcessed = true
					CASE ELSE
						//error unrecognized code
						
						ls_errormessage += "Error processing event code '"+ls_eventCode+"'. Code not recognized.~r~n"
				END CHOOSE
				
				IF ls_autoConfirm = "YES!" THEN
					IF this.of_autoconfirm214( lnv_event ) = -1 THEN
						//there was an error autoconfirming, I dont think we want to stop processing in this case
						ls_errorMessage += "Error auto-confirming event "+ string( ll_eventId )+ ".~r~n"
					END IF
				END IF
				
				DESTROY lnv_event
				DESTROY lnva_shipment[1]
			ELSE
				//error, event has no source
				
				ls_errorMessage += "Error, event "+string( ll_eventId ) + " is missing source. "
			END IF
		ELSE
			//error, cannot set null date time on an event
			//DEK 5-17-07  there was no error message being recorded here.
			ls_errorMessage += "Error, event "+string( ll_eventId ) + ", invalid date and time. "
		
		END IF
	ELSE
		//error, invalid event id
		IF isNull( ll_eventId ) THEN
			ls_errorMessage+= "Error, event id is Null.~r~n"
		ELSE
			ls_errorMessage+= "Error, event id is 0.~r~n"
		END IF
	END IF
	
	IF lb_setProcessed THEN
		lds_214importCache.setItem( ll_index, "processed", ci_processed_processed )
	ELSE
		lds_214importCache.setItem( ll_index, "processed", ci_processed_error )
		lnv_errorLogManager.of_logerror( "EDI Inbound", "Process 214 Data", ls_errorMessage , n_cst_constants.ci_ErrorLog_Urgency_Important, { ll_eventid }, "n_cst_errorremedy_edi")
	END IF
NEXT

IF lnv_dispatch.event pt_updatespending( ) = 1 THEN
	IF lnv_dispatch.event pt_save( ) = 1 THEN
		//ok
		
	ELSE
		lnv_errorLogManager.of_logerror( "EDI Inbound", "Process 214 Data", "Error saving inbound 214 shipment updates.~r~nEvents: "+ ls_idList, n_cst_constants.ci_ErrorLog_Urgency_Severe , lla_eventIds , "n_cst_errorremedy_edi")
		
		li_Return = -1
	END IF
END IF

//DEK 5-17-07, this was moved from inside the pt save.  If it isn't here, then it won't save
//processed status.
IF this.of_updatespending( ) = 1 THEN
	IF this.of_update( ) = 1 THEN
		commit;
	ELSE
		li_return = -1
		rollback;
		lnv_errorLogManager.of_logerror( "EDI Inbound", "Process 214 Data", "Error updateing 214 import data.~r~nEvents: "+ ls_idList , n_cst_constants.ci_ErrorLog_Urgency_Severe , lla_eventIds , "n_cst_errorremedy_edi")
	END IF
END IF

IF lds_214importCache.modifiedCount() > 0 THEN
	IF lds_214importCache.update() = 1 THEN
		commit;
	ELSE
		rollback;
		lnv_errorLogManager.of_logerror( "EDI Inbound", "Process 214 Data", "Error updateing 214 import data.~r~nEvents: "+ ls_idList , n_cst_constants.ci_ErrorLog_Urgency_Severe , lla_eventIds , "n_cst_errorremedy_edi")
	END IF
END IF

DESTROY lds_214CompanyProfile
DESTROY lnv_dispatch
DESTROY lds_214importCache
RETURN li_Return
end function

public function integer of_cancelshipment (long al_shipid, datetime adt_eventdatetime);/*
	DEK this function was writtin with the intent of putting a cancelled status for a shipment from
	a 214.  It will loop through all the rows where the shipid matches and set the status to cancelled.
*/
Int	li_Return =1 
String	ls_find
Long	ll_index
Long	ll_max
Long	ldt_
n_ds	lds_cache
n_cst_errorlog_manager lnv_errorLogManager

lnv_errorLogManager = this.of_geterrorlogmanager( )
lds_cache = this.of_getCache( )

lds_cache.setFilter( "shipid = "+ string(al_shipId) )
lds_cache.filter()

ll_max = lds_cache.rowcount( )

FOR ll_index = 1 TO ll_max
	lds_cache.setItem( ll_index, "status", this.cs_cancelby214_cancel )
	lds_cache.setItem( ll_index, "statusdate", DATE(adt_eventdatetime) )
	lds_cache.setItem( ll_index, "statustime", TIME(adt_eventdatetime) )
NEXT

IF ll_max = 0 THEN
	lnv_errorLogManager.of_logerror( "EDI Inbound", "Process 214 Data", "Couldn't find shipment: "+ string(al_shipid)+ " while attempting to cancel." , n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_shipid }, "n_cst_errorremedy_edi")
END IF


//DEK 5-17-07  it wasn't saving the canceled status.
//IF lds_cache.modifiedcount( ) > 0 THEN
//	IF lds_cache.update( ) = 1 THEN
//		commit;
//	ELSE
//		rollback;
//		lnv_errorLogManager.of_logerror( "EDI Inbound", "Process 214 Data", "Couldn't cancel: "+ string(al_shipid)+ " while attempting to cancel." , n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_shipid }, "n_cst_errorremedy_edi")
//		li_return = -1
//	END IF
//END IF
///////////////////////////////////////////////////

RETURN li_RETURN
end function

protected function integer of_autoconfirm214 (n_cst_beo_event anv_event);/*
	If the event has an arrival date and time then we can confirm it.
	
	Returns 1 if confirm was success
	
				0 if its not ready to confirm
				
				-1 if its an error

	It only attempts to confirm if the arrival and departed info is all valid.
*/

Int	li_return
Date	ld_arrivaldate
Date	ld_depDate

Time	lt_arrivalTime
Time	lt_depTime
n_cst_beo_event	lnv_event
IF isValid( anv_event ) THEN
	lnv_event = anv_event
ELSE
	li_return = -1
END IF

IF li_return >= 0 THEN
	ld_arrivaldate = lnv_event.of_getdatearrived( )
	ld_depDate = lnv_event.of_getdatedeparted( )
	lt_arrivalTime = lnv_event.of_getTimearrived( )
	lt_depTime = lnv_event.of_getTimedeparted( )
	
	IF not isnull( ld_arrivaldate ) AND not IsNull( ld_depDate ) AND not Isnull( lt_arrivalTime ) AND not Isnull( lt_depTime ) THEN
		IF lnv_event.of_confirm( ) = 1 THEN
			li_return = 1 
		ELSE
			li_return = -1
		END IF
	END IF
END IF


RETURN li_return
end function

public function n_cst_errorlog_manager of_geterrorlogmanager ();IF NOT isValid( inv_errorlogmanager ) THEN
	inv_errorLogManager = create n_cst_errorlog_manager
END IF

RETURN inv_errorLogManager
end function

public function integer of_process990 (long al_shipid, string as_response, string as_reason, string as_senderscode);/*
	This happens when a 990 is imported.
*/


n_ds	lds_cache
String	ls_find
int	li_Return = 1
Date	ld_date
Time	lt_time

Long	ll_index
n_cst_errorlog_manager lnv_errorLogManager

lnv_errorlogmanager = this.of_geterrorlogmanager( )

lds_cache = this.of_GetCache( )
ld_date = today()
lt_time = now()

ls_find = "shipid = " +string(al_shipId) +" And purpose = '"+cs_gen204Request_original + "' AND to_scac = '"+ as_sendersCode+"'"

ll_index = lds_cache.find( ls_find, 1, lds_cache.rowCount())

IF ll_index > 0 THEN
	IF as_response = "A" THEN	//DEK 4-17-07 was looking for ACC from V1 segment, now it is from the B1
		lds_cache.setItem( ll_index, "status" , cs_shipmentstatus_accepted )
	ELSEIF as_response = "D" THEN //DEK 4-17-07 was looking for DEC from V1 segment, now it is from the B1
		lds_cache.setItem( ll_index, "status" , cs_shipmentstatus_declined )
		lds_cache.setItem( ll_index, "statusreason" , as_reason )
		
	ELSE
		//unknown status
		li_return = -1
		setNull(ld_date)
		setNull(lt_time)
		lnv_errorLogManager.of_logerror( "EDI Inbound", "Process 990 Data", "Uknown Response: "+ as_response+ " when processing 990 for shipment: "+ string(al_shipid)+ " sent to SCAC: "+ as_senderscode  , n_cst_constants.ci_ErrorLog_Urgency_Important, { al_shipid }, "n_cst_errorremedy_edi")

	END IF
	lds_cache.setItem( ll_index, "statusdate" , ld_date )
	lds_cache.setItem( ll_index, "statustime" , lt_time )
	IF lds_cache.update() = 1 THEN
		commit;
	ELSE
		rollback;
		li_Return = -1
		lnv_errorLogManager.of_logerror( "EDI Inbound", "Process 990 Data", "Couldn't update exported shipment cache for shipment: "+ string(al_shipid)+ + "~r~nsent to SCAC: "+ as_senderscode +" in outbound 204 cache. Response: "+ as_response , n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_shipid }, "n_cst_errorremedy_edi")
	END IF
ELSE
	lnv_errorLogManager.of_logerror( "EDI Inbound", "Process 990 Data", "Couldn't find shipment: "+ string(al_shipid)+ " sent to SCAC: "+ as_senderscode +"~r~nin outbound 204 cache. Response: "+ as_response , n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_shipid }, "n_cst_errorremedy_edi")
END IF

return li_return


end function

public function integer of_addshiptopendingexport (long al_shipid, string as_scac, string as_purpose);/*
	This function puts an entry into the ediPending204out  table for the shipment passed.
	
	This adds an entry to the pending 204 generations for the specified shipment.
	
	Returns 1 if it inserts something
			-1 otherwise
*/


Int	li_return = 1
Long	ll_max
Long	ll_index
Long	ll_maxId
Long	ll_temp
Long	i

Boolean	lb_insert

String	ls_lastPurpose
String	ls_lastScac

String	lsa_setPurpose[]		//an array of things i may have to insert
String	lsa_scacs[]				//an array of scacs to go with the things i insert
/*
	This function may prompte the user for input.
*/

String	ls_find
datastore	lds_pending


lds_pending = this.of_getpendingrequestcache( )

IF this.of_getLastshipmentinfo( al_shipId, ls_lastScac , ls_lastPurpose ) = 1 THEN
	
	IF ls_lastScac = as_scac THEN
		CHOOSE CASE ls_lastPurpose
			CASE cs_gen204request_original
				//last was original
				IF as_purpose = cs_gen204request_original OR as_purpose = cs_gen204request_change THEN
					//request was original or change
					lsa_setPurpose[1] = cs_gen204request_change
					lsa_scacs[1] = as_scac
				ELSE  
					//request was cancel
					lsa_setPurpose[1] = cs_gen204request_cancel
					lsa_scacs[1] = as_scac
				END IF
			CASE cs_gen204request_change
				//last was change
				IF as_purpose = cs_gen204request_original OR as_purpose = cs_gen204request_change THEN
					//request is original or change
					lsa_setPurpose[1] = cs_gen204request_change
					lsa_scacs[1] = as_scac
				ELSE
					//request was cancel
					//we can cancel the last change
					lsa_setPurpose[1] = cs_gen204request_cancel
					lsa_scacs[1] = as_scac
				END IF
			CASE cs_gen204request_cancel
				//last was cancel
				IF as_purpose = cs_gen204request_original OR as_purpose = cs_gen204request_change THEN
					//request was original or change
					lsa_setPurpose[1] = cs_gen204request_original
					lsa_scacs[1] = as_scac
				ELSE
					//request was cancel
					IF messagebox( "Generate Cancel Request", "The last request made for this shipment was a cancel order for the same compay, do you want to post an addition cancel order for the same company?",question!, yesno!, 2 ) = 1 THEN
						lsa_setPurpose[1] = cs_gen204request_cancel		//maybe we don't even have to add it here..
						lsa_scacs[1] = as_scac
					END IF
				END IF
		END CHOOSE
	ELSE
		//scacs are different
		CHOOSE CASE ls_lastPurpose
			CASE cs_gen204request_original, cs_gen204request_change
				//last was original
				IF as_purpose = cs_gen204request_original OR as_purpose = cs_gen204request_change THEN
					//ask if they want to request an original to a different company
					//and cancel the old one.
					IF messagebox( "Generate 204 Request", "A generation request already exists for another company, do you want to send a cancel order to that company and generate a 204 for the new company?~r~n~r~nSaying no does not cancel any 204 generations for either company.", question!, yesno!, 2 ) =1 THEN
						//generate a cancel for last company
						lsa_setPurpose[1] = cs_gen204request_cancel
						lsa_scacs[1] = ls_lastScac
						//generate original for new company
						lsa_setPurpose[2] = cs_gen204request_original
						lsa_scacs[2] = as_scac
					ELSE
						//they said no, so we will not cancel and we will not send a 204 to the new company.  Calling code
						li_return = -1
					END IF
				ELSE
					//request was a cancel
					Messagebox("Generate Cancel Request", "The company you chose to send a cancel order to is not the same company that recieved a 204. Action cancelled.")
					li_return = -1
				END IF
				
			CASE cs_gen204request_cancel
				//last was cancel
				IF as_purpose = cs_gen204request_original OR as_purpose = cs_gen204request_change THEN
					lsa_setPurpose[1] = cs_gen204request_original
					lsa_scacs[1] = as_scac
				ELSE 	//cancel
					//request was cancel
					lsa_setPurpose[1] = cs_gen204request_cancel		//maybe we don't even have to add it here..
					lsa_scacs[1] = as_scac
					IF messagebox( "Generate Cancel Request", "The last request made for this shipment was a cancel order for a different compay, do you want to post a cancel order for "+as_scac+"?",question!, yesno!, 2 ) = 1 THEN
						lsa_setPurpose[1] = cs_gen204request_cancel		//maybe we don't even have to add it here..
						lsa_scacs[1] = as_scac
					END IF
				END IF
		END CHOOSE
	END IF
ELSE
	//it has no history so we can add the request
	lsa_setPurpose[1] = as_purpose
	lsa_scacs[1] = as_scac
	lb_insert = true
END IF


ll_max = lds_pending.rowCount()


IF li_return = 1 THEN
		
	IF isNull(ll_maxId) THEN
		ll_maxId = 0
	END IF
	
	ll_max = upperBound( lsa_setPurpose )
	FOR i = 1 TO ll_max
	
		ll_maxId = this.of_getpendingid( )
	
		ll_index = lds_pending.insertRow( 0 )
		lds_pending.setitem( ll_index, "shipId", al_shipId )
		lds_pending.setitem( ll_index, "to_scac", lsa_scacs[i] )
		lds_pending.setItem( ll_index, "purpose", lsa_setPurpose[i] )
		lds_pending.setItem( ll_index, "req_date", today())
		lds_pending.setItem( ll_index, "req_time", now() )
		ll_temp = lds_pending.setItem( ll_index, "req_id", ll_maxID )
	NEXT
	
//	IF lds_pending.update() = 1 THEN
//		commit;
//	ELSE
//		rollback;
//		li_return = -1
//	END IF
END IF

RETURN li_return
end function

public function datastore of_getpendingrequestcache ();Long	ll_max
IF not IsValid( ids_pending ) THEN
	ids_pending = create datastore
	ids_pending.dataobject = "d_edipending204out"
	ids_pending.settransobject(SQLCA)
	ll_max = ids_pending.retrieve()
	commit;
	
END IF

ids_pending.setFilter("")
ids_pending.filter()
ids_pending.Setsort( "req_date A, req_time A, req_id A" )
ids_pending.sort()

RETURN ids_pending
end function

public function integer of_getlastshipmentinfo (long al_shipid, ref string as_scac, ref string as_purpose);/*
	 This will look through the pending cache first and the shipment table next, and get the last scac and request 
	 made on the specified shipment.
	 
	 Returns 1 if it finds it, -1 if it doesn't
*/

Datastore lds_pending
n_ds		lds_exportedShipments
Long	ll_index
Long	ll_max
Int		li_return = 1
String	ls_scac
String	ls_purpose
String	ls_find

lds_pending = this.of_getPendingrequestcache( )


ls_find = "shipid = " + string(al_shipID)

ll_max = lds_pending.rowcount( )
ll_index = lds_pending.find( ls_find, ll_max, 1)

IF ll_index > 0 THEN
	ls_scac = lds_pending.getitemstring( ll_index, "to_scac")
	ls_purpose = lds_pending.getitemstring( ll_index, "purpose")
ELSE
	lds_exportedShipments = this.of_getcache( )
	
	lds_exportedShipments.setSort( "req_date A, req_time A" )
	lds_exportedShipments.sort()
	ll_max = lds_exportedShipments.rowcount( )
	
	ll_index = lds_exportedShipments.find( ls_find, ll_max, 1)
	
	
	IF ll_index > 0 THEN
		ls_scac = lds_exportedShipments.getitemstring( ll_index, "to_scac")
		ls_purpose = lds_exportedShipments.getItemString( ll_index, "purpose" )
	ELSE
		li_Return = -1
	END IF
END IF	

as_scac = ls_scac
as_purpose = ls_purpose

return li_return
end function

public function long of_getpendingid ();long		ll_nextid


CONSTANT Boolean cb_Commit	= TRUE	

IF gnv_App.of_GetNextId ( "gen204request", ll_NextId, cb_Commit ) = 1 THEN
	//edi system can't handle number larger than 99999
	if ll_nextid > 99999 then
		//	Reset next id for 'EDICONTROL'
		 UPDATE "nextids" SET "nextid" = 2 WHERE "nextids"."classid" = 31   ;
		commit;
	end if
END IF

return ll_nextId
end function

public function integer of_addexportedshipment (n_cst_beo_shipment anv_shipment, string as_toscac, string as_purpose, ref string as_message, date ad_reqdate, time at_reqtime);/*
	Returns 1 if it is inserted into the shipmenttable successfully.

	
	Returns -1 and as_message if it fails to insert it into the table.
*/

Int	li_return = 1
Long	ll_index
Long	ll_max
Long	ll_shipId
Long	ll_carrier
boolean	lb_insert
String	ls_find
String	ls_fromScac
String	ls_carrierScac
String	ls_message


n_ds	lds_exports
n_cst_beo_shipment	lnv_shipment

IF isValid( anv_shipment ) THEN
	lnv_shipment = anv_shipment
	ll_shipId = lnv_shipment.of_getId( )
	
	//I filter down and sort because adding is only allowed based on pre existance of the request, as well as
	//the last request.
	lds_exports = this.of_getcache( )

ELSE
	li_return = -1
	ls_message = "The shipment "+ string(ll_shipId)+ " failed to be added to the outbound 204 table.  Unexpected error."
END IF


CHOOSE CASE as_purpose
	CASE cs_gen204Request_original
		IF this.of_addentryoriginal( ll_shipId ,as_toscac, ls_message ) = 1 THEN
			lb_insert = true
		
		END IF
	CASE cs_gen204Request_change
		IF this.of_addentrychange( ll_shipId, as_toScac, ls_message ) = 1 THEN
			lb_insert = true
		END IF
	CASE cs_gen204Request_cancel
		IF this.of_addEntrycancel( ll_shipId, as_toscac, ls_message) = 1 THEN
			lb_insert = true
		END IF
	CASE ELSE
		ls_message = "Invalid request, add exported shipment entry."
		//invalid request
END CHOOSE
		

IF lb_insert THEN
	ll_index = lds_exports.insertrow( 0 )
	ll_carrier = lnv_shipment.of_getCarrier( )
	ls_carrierScac = this.of_getCarrierscac( ll_carrier)
	ls_fromScac = this.of_GetFromscac( )
	lds_exports.setItem( ll_index, "shipid", ll_shipId)
	lds_exports.setItem( ll_index, "to_scac", as_toscac )
	lds_exports.setItem( ll_index, "from_scac", ls_fromScac )
	lds_exports.setItem( ll_index, "exporteddate", today() )
	lds_exports.setItem( ll_index, "status", cs_shipmentstatus_offered )
	lds_exports.setItem( ll_index,  "processed", -5 )	//this is a value I use for cleanupexportcache, so that I know which row I just added. We set it back to 0 in cleanup.
	lds_exports.setItem( ll_index,  "purpose", as_purpose )
	lds_exports.setItem( ll_index,  "req_date", ad_reqDate )
	lds_exports.setItem( ll_index,  "req_time", at_reqTime )
	
	this.of_cleanupexportcache( ll_shipId, as_toScac, as_purpose )
	
	IF lds_exports.update() = 1 THEN
		commit;
	ELSE
		rollback;
		ls_message = "Shipment "+string(ll_shipId)+" failed to be added to outbound 204 table. Unable to update the database."
		inv_errorlogmanager.of_logerror( "EDI Outbound 204", "Add Exported Shipment", ls_message, 3, {ll_shipid}, "n_cst_errorremedy_edi")
		li_return = -1
	END IF
ELSE
	li_return = -1
END IF


as_message = ls_message

RETURN li_Return
end function

private function integer of_cleanupexportcache (long al_shipid, string as_toscac, string as_purpose);/*

	The arguments passed in should be the arguments of the thing we just added to the exported shipment table.
	We are basically going through unprocessed generations that meet this criteria, that are in the queue
	before this event, and evaluating if they still make sense.
	
	The purpose of this function is to clean up unnecessary unprocessed 204 requests.
	
	It will do this in a loop
	
	For each to_scac
	Filter down to unprocessed requests for that company shipment. and be sure they are sorted in order of request time.
	
	Three checks
	
	First, delete all Change orders before a cancel
	
	
	//clean up all of the stuff before this event that are no longer necessary.
	//All unprocessed changes for the shipment for the company are removed before a cancel.
	//All unprocessed originals for a shipment for the company are removed before the cancel, not sure we can remove the cancel.
	//All unprocessed cancels for a shipment for the company can be removed before an offered.
	//no originals followed by an original for a shipment for a company that are both unprocessed.
	//no changes followed by changes that are unprocessed for a company for the shipment
	//no cancels followed by cancels that are unprocessed for a company for the shipment
*/
Int	li_Return = 1
Long	ll_max
Long	ll_index

Long	ll_CancelIndex
Long	ll_originalIndex

String	ls_filterUnprocessed
String	ls_filterProcessed
Boolean	lb_discardNewRow
N_ds	lds_exportedCache

lds_exportedCache = this.of_getCache( )

ls_filterUnprocessed ="processed = 0 AND to_scac ='"+as_toscac+"' AND shipid = " + string(al_shipId)

ls_filterProcessed =  "processed = 1 AND to_scac ='"+as_toscac+"' AND shipid = " + string(al_shipId) 
lds_exportedCache.setFilter( ls_filterUnprocessed )
lds_exportedCache.filter()
lds_exportedCache.sort()
ll_max = lds_exportedCache.rowCount()


CHOOSE CASE as_purpose
	CASE cs_gen204request_cancel,  cs_gen204request_original
		//delete all unprocessed changes and offers and cancels before this cancel.
		IF ll_max > 0 THEN
			lds_exportedCache.rowsmove( 1, ll_max, PRIMARY!, lds_exportedCache, 9999, DELETE!)
		END IF
END CHOOSE


//if it was a cancel or change then we need to check to see if an original was sent at all to this company
//if not, then we can delete it.
CHOOSE CASE  as_purpose
	CASE cs_gen204request_cancel , cs_gen204request_change
		ll_max = lds_exportedCache.rowCount()
		IF as_purpose = cs_gen204request_change THEN
			IF ll_max > 0 THEN
				//delete all unprocessed change orders before this one

				FOR ll_index = ll_max TO 1 STEP -1
					IF lds_exportedCache.getItemstring( ll_index, "purpose" ) = cs_gen204request_change THEN
						lds_exportedCache.deleterow( ll_index )
					END IF
				NEXT
			END IF
		END IF
		
		lds_exportedCache.setFilter( ls_filterProcessed )
		lds_exportedCache.filter()
		lds_exportedCache.Sort()
		ll_max = lds_exportedCache.rowCount()
		
		ll_CancelIndex = lds_exportedCache.find( "purpose = '"+ cs_gen204request_cancel +"'", ll_max, 1 )
		ll_originalIndex = lds_exportedCache.find( "purpose = '"+ cs_gen204request_original +"'", ll_max, 1 )
		
		lds_exportedCache.setFilter( /*ls_filterUnprocessed */ "processed = -5" ) //I set the new row to negative 5 for this purpose
		lds_exportedCache.filter()
		lds_exportedCache.Sort()
		ll_max = lds_exportedCache.rowCount()
		
		IF ll_originalIndex > ll_cancelIndex THEN
			//original exists and was processed, so we can leave the row in here
			IF ll_max > 0 THEN
				lds_exportedCache.setITem( 1, "processed", 0 )
			END IF
		ELSE
			//if there wasn't a processed original since the last cancel, we need to delete this cancel or changeorer.
			lds_exportedCache.setFilter( /*ls_filterUnprocessed */ "processed = -5" ) //I set the new row to negative 5 for this purpose
			lds_exportedCache.filter()
			lds_exportedCache.Sort()
			ll_max = lds_exportedCache.rowCount()
			
			IF ll_max > 0 THEN
				lds_exportedCache.rowsdiscard( 1, 1, PRIMARY!)
			END IF
			
			//i discard it because it has not been updated yet.
//			//IF ll_max > 0 THEN
//			FOR ll_index = 1 TO ll_max
//				//there should only be one modified row that has to be removed.
//				IF lds_exportedCache.getItemstatus( ll_index, 0, Primary!) = NEW! or lds_exportedCache.getItemstatus( ll_index, 0, Primary!) = NEWMODIFIED! THEN       
//					lds_exportedCache.rowsdiscard( ll_index, ll_max, PRIMARY!)
//					EXIT
//				END IF
//			NEXT
		END IF
	CASE ELSE
		//originals can always be added.
		lds_exportedCache.setFilter( /*ls_filterUnprocessed */ "processed = -5" ) //I set the new row to negative 5 for this purpose
		lds_exportedCache.filter()
		lds_exportedCache.Sort()
		ll_max = lds_exportedCache.rowCount()
		IF ll_max > 0 THEN
			lds_exportedCache.setITem( 1, "processed", 0 )
		END IF
END CHOOSE




RETURN li_Return

end function

public function integer of_update ();Int	li_Return = 1
datastore lds_exports 
n_Ds	lds_exportedshipments

lds_exports = this.of_getPendingrequestcache( )
lds_exportedShipments = this.of_getCache( )
IF lds_exports.update() = 1 THEN
	commit;
ELSE
	rollback;

	li_return = -1
END IF

//added this 5/17/07
IF lds_exportedshipments.update( ) = 1 THEN
	commit;
ELSE
	rollback;
	li_return = -1
END IF

RETURN li_Return
end function

public function integer of_updatespending ();Int	li_Return = 1
n_ds lds_exportedshipments
datastore lds_exports 

lds_exports = this.of_getPendingrequestcache( )
lds_exportedshipments = this.of_getcache( )
//added the or condtion 5/17/07
IF lds_exports.modifiedCount() > 0 OR lds_exportedSHipments.modifiedCount() > 0 THEN
	li_Return = 1
ELSE
	li_return = -1
END IF

RETURN li_Return
end function

on n_cst_ediexportshipmentmanager.create
call super::create
end on

on n_cst_ediexportshipmentmanager.destroy
call super::destroy
end on

event destructor;call super::destructor;if isvalid( ids_exportedShipments ) THEN
	destroy ids_exportedShipments
END IF

IF isValid(inv_errorLogManager) THEN
	destroy inv_errorLogManager
END IF

IF isValid( ids_pending ) THEN
	destroy ids_pending
END IF
end event

