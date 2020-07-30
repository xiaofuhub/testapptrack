$PBExportHeader$n_cst_bso_edimanager_322.sru
forward
global type n_cst_bso_edimanager_322 from n_cst_bso
end type
end forward

global type n_cst_bso_edimanager_322 from n_cst_bso
end type
global n_cst_bso_edimanager_322 n_cst_bso_edimanager_322

type variables
Constant	string	cs_FlagStatus_Rail = "RAIL"
Constant	string	cs_FlagStatus_TerminatedImc = "IMC"
Constant	string	cs_FlagStatus_BillToYard = "BTY"  // hubs yard
Constant	string	cs_FlagStatus_BadOrder = "B"
Constant	string	cs_FlagStatus_EmptyAvailable = "MTA"
Constant	string	cs_FlagStatus_DropEmptyAtShipper = "X8"


DataStore	ids_Cache

Constant Int	ci_MessageStatus_Pending = 0
Constant Int	ci_MessageStatus_Processed = 1
Constant Int	ci_MessageStatus_Canceled = -2
Constant Int	ci_MessageStatus_NeedsStatus = -3


n_Cst_bso_Dispatch	inv_Disp
end variables

forward prototypes
public function integer of_getstatusfromuser (ref string as_status)
public function integer of_recordcancel (n_cst_beo_event anv_event)
public function integer of_createmsg (readonly n_cst_beo_event anv_event, string as_status)
public function integer of_savecache ()
public function boolean of_hadupdatespending ()
public function boolean of_iscanidate (n_cst_beo_event anv_event, readonly datastore ads_shipmentcache)
public function integer of_sendpending ()
protected function integer of_sendtransactionsforcompany (long al_coid)
private function datastore of_getcache ()
public function datastore of_getcache (boolean ab_all)
end prototypes

public function integer of_getstatusfromuser (ref string as_status);String	ls_Status
Int	li_Return = -1

open ( w_edi322_status )
ls_Status = Message.stringparm

IF len ( ls_Status ) > 0 THEN
	as_status = ls_Status
	li_Return = 1
END IF


RETURN li_Return
end function

public function integer of_recordcancel (n_cst_beo_event anv_event);Long	ll_EventID
Long	ll_RowCount
String	ls_Find
Long	ll_WorkRow
DataStore	lds_Cache

Int	li_Return = 1

IF li_Return = 1 THEN
	
	lds_Cache = THIS.of_Getcache( )
	IF Not IsValid ( lds_Cache ) THEN
		li_Return = -1
	END IF
	
END IF



IF li_Return = 1 THEN
	IF not isValid ( anv_event ) THEN
		li_Return = -1
	END IF
END IF
IF li_Return = 1 THEN
	ll_EventID = anv_event.of_GetID ( )
END IF

IF li_Return = 1 THEN
	
	n_Cst_bso_dispatch	lnv_Disp
	lnv_Disp = anv_event.of_GetContext ( )
	long	ll_ShipmentID
	ll_ShipmentID = anv_event.of_GetShipment ( )
	
	
	n_Cst_beo_Shipment	lnv_Shipment
	lnv_Shipment = CREATE n_cst_beo_Shipment
	lnv_Shipment.of_SetSource ( lnv_Disp.of_GetShipmentCache ( ) ) 
	lnv_Shipment.of_setSourceID ( ll_ShipmentID )
	
	Long	ll_SourceCo
	ll_SourceCo = lnv_Shipment.of_GetBillto( )
	
	DESTROY ( lnv_Shipment ) 
	
END IF

IF ll_EventID > 0 THEN
	// we only allow one status per Event
	ls_Find = "eventid = " + String  ( ll_EventID ) 
	ll_RowCount = lds_Cache.RowCount ( )
	
	ll_WorkRow = lds_Cache.Find( ls_Find,1,ll_RowCount )
	
	IF ll_WorkRow = 0 THEN
		ll_WorkRow = lds_Cache.InsertRow ( 0 ) 
		lds_Cache.SetItem ( ll_WorkRow , "eventid" , ll_EventID ) 
	END IF
	String	ls_Null
	SetNull ( ls_Null )
	
	lds_Cache.SetItem ( ll_WorkRow , "Status" , ls_Null ) 
	lds_Cache.SetItem ( ll_WorkRow , "userid" , gnv_app.of_getnumericuserid( ) ) 
	lds_Cache.SetItem ( ll_WorkRow , "EntryDate" , Today ( ) ) 
	lds_Cache.SetItem ( ll_WorkRow , "entrytime" , now() ) 
	lds_Cache.SetItem ( ll_WorkRow , "MessageStatus" , THIS.ci_MessageStatus_Canceled  ) 
	lds_Cache.SetItem ( ll_WorkRow , "sourceCo" , ll_SourceCo  ) 


END IF

return li_Return
end function

public function integer of_createmsg (readonly n_cst_beo_event anv_event, string as_status);Long	ll_EventID
Long	ll_RowCount
String	ls_Find
Long	ll_WorkRow
Int	li_MessageStatus
DataStore	lds_Cache


Int	li_Return = 1

// by default the messageStatus will be pending
// we might change this if the trx status is null (see below)
li_MessageStatus = THIS.ci_messagestatus_pending

IF li_Return = 1 THEN
	
	lds_Cache = THIS.of_Getcache( true )		//DEK 5-29-07, This version uses the dataobject that selects all of the rows in the cache.  Issue 2943
	IF Not IsValid ( lds_Cache ) THEN
		li_Return = -1
	END IF
	
END IF

//
IF li_Return = 1 THEN
	
	n_Cst_bso_dispatch	lnv_Disp
	lnv_Disp = anv_event.of_GetContext ( )
	long	ll_ShipmentID
	ll_ShipmentID = anv_event.of_GetShipment ( )
	
	
	n_Cst_beo_Shipment	lnv_Shipment
	lnv_Shipment = CREATE n_cst_beo_Shipment
	lnv_Shipment.of_SetSource ( lnv_Disp.of_GetShipmentCache ( ) ) 
	lnv_Shipment.of_setSourceID ( ll_ShipmentID )
	
	Long	ll_SourceCo
	ll_SourceCo = lnv_Shipment.of_GetBillto( )
	
	DESTROY ( lnv_Shipment ) 
	
END IF
	
	

IF li_Return = 1 THEN
	IF not isValid ( anv_event ) THEN
		li_Return = -1
	END IF
END IF
IF li_Return = 1 THEN
	ll_EventID = anv_event.of_GetID ( )
END IF

IF IsNull ( as_status ) THEN
	// we need create an empty entry
	// and flag the message as needing user interaction.
	// This is the case when the event is confirmed by a mobile comm device.
	
	li_MessageStatus = THIS.ci_messagestatus_needsstatus
	
	
END IF


IF ll_EventID > 0 THEN
	// we only allow one status per Event
	ls_Find = "eventid = " + String  ( ll_EventID ) 
	ll_RowCount = lds_Cache.RowCount ( )
	
	ll_WorkRow = lds_Cache.Find( ls_Find,1,ll_RowCount )
	
	IF ll_WorkRow = 0 THEN
		ll_WorkRow = lds_Cache.InsertRow ( 0 ) 
		lds_Cache.SetItem ( ll_WorkRow , "eventid" , ll_EventID ) 
	END IF
	
	
	lds_Cache.SetItem ( ll_WorkRow , "Status" , as_status ) 
	lds_Cache.SetItem ( ll_WorkRow , "userid" , gnv_app.of_getnumericuserid( ) ) 
	lds_Cache.SetItem ( ll_WorkRow , "EntryDate" , Today ( ) ) 
	lds_Cache.SetItem ( ll_WorkRow , "entrytime" , now() ) 
	lds_Cache.SetItem ( ll_WorkRow , "MessageStatus" , li_MessageStatus  ) 
	lds_Cache.SetItem ( ll_WorkRow , "sourceCo" , ll_SourceCo  ) 


END IF

return li_Return
end function

public function integer of_savecache ();Int	li_Return

IF ids_cache.Update() = 1 THEN
	COmmit;
	li_Return = 1

ELSE
//	MessageBox("SQL error", SQLCA.SQLErrText)
	RollBack;
	li_return = -1
END IF

IF li_Return = 1 THEN
	DESTROY ( ids_cache ) 
END IF

RETURN li_Return
end function

public function boolean of_hadupdatespending ();Boolean	lb_Return
IF isvalid ( ids_cache ) THEN
	lb_Return = ids_cache.Modifiedcount( ) > 0 
END IF

RETURN lb_Return
end function

public function boolean of_iscanidate (n_cst_beo_event anv_event, readonly datastore ads_shipmentcache);Boolean	lb_Return
Long	ll_BillTO
Long	ll_Shipment

n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment


n_Cst_beo_Event	lnv_Event

lnv_Event = anv_event
IF lnv_Event.of_Isdissociation( ) THEN

	ll_Shipment = lnv_Event.of_GetShipment( )
	
	IF ll_Shipment > 0 THEN
		lnv_Shipment.of_SetSource ( ads_shipmentcache ) 
		lnv_Shipment.of_SetSourceID ( ll_Shipment )
		
		ll_BillTo = lnv_Shipment.of_getBillto( )
		
	END IF
	
	
	IF ll_BillTO > 0 THEN
		
		String	ls_template
		
		  SELECT "ediprofile"."template"  
		 INTO :ls_Template  
		 FROM "ediprofile"  
		WHERE ( "ediprofile"."companyid" = :ll_Billto ) AND  
				( "ediprofile"."transactionset" = 322 )   ;
		Commit;
		
		IF Len ( ls_template ) > 0 THEN
			lb_Return = TRUE
		END IF
		
	END IF
	
END IF

DESTROY ( lnv_shipment )

RETURN lb_Return

end function

public function integer of_sendpending ();// get a list of companies that are set up for 322.
DataStore	lds_Companies

lds_Companies = CREATE dataStore
ldS_Companies.DataObject = "d_322Companies" 
lds_Companies.SetTransobject( SQLCA )

Long	ll_Count
ll_Count =lds_Companies.Retrieve( )
Commit;
Long	i

Long	lla_Companies[]

n_Cst_AnyArraySrv	lnv_Array



FOR i = 1 TO ll_Count
	
	lla_Companies [ i ] = lds_Companies.GetItemNumber ( i , "companyid" )
	
NEXT

lnv_Array.of_getshrinked( lla_Companies , TRUE , TRUE )

ll_Count = UpperBound ( lla_Companies ) 

FOR i = 1 TO ll_Count
	
	THIS.of_sendtransactionsforcompany( lla_Companies [i] )
	
NEXT
IF THIS.of_hadupdatespending( ) THEN
	THIS.of_savecache( )
END IF

DESTROY ( lds_Companies )


RETURN 1
end function

protected function integer of_sendtransactionsforcompany (long al_coid);
n_cst_edi_transaction_322		lnv_transaction
lnv_Transaction = CREATE n_cst_edi_transaction_322

lnv_transaction.of_SetCache ( THIS.of_GetCache( ) )

Int	li_Return 
li_Return = lnv_transaction.of_Sendforcompany( al_coid ) 

Destroy ( lnv_transaction ) 
RETURN li_Return




//String	ls_Filter 
//Long	ll_Count 
//Long	ll_EventID
//Long	ll_Ship
//Long	ll_Co
//String	ls_322Status
//String	ls_Template
//
//
//Long	i
//
//
//
//n_Cst_beo_Event	lnv_Event
//lnv_event = CREATE n_cst_beo_Event
//
//lnv_Event.of_SetSource ( inv_Disp.of_GetEventCache( ) ) 
//
//n_Cst_beo_Shipment	lnv_Shipment
//lnv_Shipment = CREATE n_Cst_beo_Shipment
//
//n_cst_Edi_Transaction	lnv_trans
//lnv_trans = CREATE n_cst_Edi_Transaction
//
//lnv_Shipment.of_SetSource ( inv_disp.of_GetShipmentCache ( ) ) 
//
//ll_Co = al_coid
//
//
//ls_Filter = "sourceco = " + String ( ll_Co )
//ids_cache.SetFilter ( ls_Filter ) 
//ids_cache.Filter (  )
//ll_Count = ids_cache.RowCount ( )
//
//
//  SELECT "ediprofile"."template"  
// INTO :ls_Template  
// FROM "ediprofile"  
//WHERE ( "ediprofile"."companyid" = :ll_Co ) AND  
//		( "ediprofile"."transactionset" = 322 )   ;
//Commit;
//
//
//IF Len ( ls_Template ) > 0 THEN
//	
//	Long	ll_FileHandle
//	ll_FileHandle = FileOpen ( ls_Template)
//	String	lsa_TemplateResults[]
//	String	lsa_TemplateHeader[]
//	String	lsa_TemplateFooter[]
//	
//	IF ll_FileHandle >= 0 THEN
//	
//		lnv_trans.of_Loadtemplateintoarray( ll_FileHandle , lsa_TemplateResults, lsa_TemplateHeader, lsa_TemplateFooter)
//	
//	END IF
//	
//	
//END IF
//
//
//FOR i = 1 TO ll_Count
//	
//	ll_EventID = ids_cache.getItemNumber ( i , "eventid" )
//	
//	lnv_Event.of_SetSourceID ( ll_EventID ) 
//	lnv_Shipment.of_SetSourceID ( lnv_Event.of_GetShipment( ) ) 
//	lnv_Event.of_SetShipment ( lnv_SHipment ) 
//	
//	ls_322Status = ids_cache.GetITemString ( i , "status" )
//	
//	
//	
//	
//	
//	
////	lnv_ReportManager.of_ProcessString( ls_Working , ls_Modified , {lnv_Beo} , anv_TagMsg )
//	
//	
//NEXT
//
//
//
//ids_cache.SetFilter ( "" )
//ids_cache.Filter ( )
//
//RETURN 1
end function

private function datastore of_getcache ();//DEK 5-29-07 overloaded function
//IF Not IsValid ( ids_cache ) THEN
//	ids_cache = CREATE dataStore
//	ids_cache.DataObject = "d_322status"
//	ids_cache.SetTransObject ( SQLCA ) 
//	
//	ids_cache.Retrieve ( )
//	
//	Commit;
//END IF
//
//RETURN ids_cache
RETURN this.of_getCache( false )
end function

public function datastore of_getcache (boolean ab_all);//DEK 5-29-07
//		This version of the function will use a different dataobject if ab_all is true.  The
//		differences in the dataobjects is that d_322status selects the top 50 while d_322Status_all
//		will return every thing in the cache.  SO far ab_all is only true when called from of_createMsg.

IF Not IsValid ( ids_cache ) THEN
	ids_cache = CREATE dataStore
	IF ab_all THEN
		ids_cache.DataObject = "d_322status_all"		//DEK 5-29-07, this version selects all 
	ELSE
		ids_cache.DataObject = "d_322status"			//This version selects top 50 where messagestatus = 0
	END IF
	ids_cache.SetTransObject ( SQLCA ) 
	
	ids_cache.Retrieve ( )
	
	Commit;
END IF

RETURN ids_cache
end function

on n_cst_bso_edimanager_322.create
call super::create
end on

on n_cst_bso_edimanager_322.destroy
call super::destroy
end on

event destructor;call super::destructor;Destroy ( ids_cache )

end event

