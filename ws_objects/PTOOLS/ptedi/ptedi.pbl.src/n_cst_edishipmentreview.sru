$PBExportHeader$n_cst_edishipmentreview.sru
forward
global type n_cst_edishipmentreview from n_base
end type
end forward

global type n_cst_edishipmentreview from n_base
end type
global n_cst_edishipmentreview n_cst_edishipmentreview

type variables
Constant String	cs_Accept = "ACCEPT"
Constant String	cs_Decline = "DECLINE"



n_ds	ids_Source
n_cst_bso_Dispatch	inv_Dispatch

String	is_SourceDataObject = "d_edishipmentreview"

long		ila_990shipid[]
end variables

forward prototypes
public function long of_retrivepending ()
public function integer of_setshare (ref datawindow adw_sharetarget)
public function integer of_acceptshipments (long ala_shipmentids[])
public function boolean of_hasupdatespending ()
public function n_ds of_getcache ()
public function integer of_declineshipments (long ala_shipmentids[], string as_reason)
public function integer of_save ()
public subroutine of_send990 ()
public function integer of_retrieveandacceptall ()
public subroutine of_setshipidfor990 ()
public function integer of_getshipidfor990 (ref long ala_shipid[])
private function integer of_getautoacceptscacs (ref string asa_scacs[])
public function integer of_retrieveids (long ala_ids[])
public function integer of_update990status (long al_shipid, string as_status, string as_senderscode)
private function integer of_changestatus ()
end prototypes

public function long of_retrivepending ();Long	ll_Return
Long	ll_RetrieveRtn

DESTROY ( inv_dispatch ) // we are doing this to clear the cache
inv_dispatch = CREATE n_cst_bso_Dispatch

ll_RetrieveRtn = ids_source.Retrieve ( gc_Dispatch.cs_ShipmentStatus_Offered )
Commit;



IF ll_RetrieveRtn >= 0 THEN
	ll_Return = ll_RetrieveRtn
	ids_source.Sort ( )
ELSE
	ll_Return = -1
END IF

RETURN ll_Return


end function

public function integer of_setshare (ref datawindow adw_sharetarget);Int	li_Return = -1
IF ids_source.Sharedata( adw_sharetarget ) = 1 THEN
	li_Return = 1 
END IF

RETURN li_Return
end function

public function integer of_acceptshipments (long ala_shipmentids[]);Int		li_Return = 1
String	ls_Filter
Long		ll_Count
Long		i
Long		ll_ShipmentID
String	ls_Sort
n_cst_sql	lnv_sql

n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment
lnv_Shipment.of_SetAllowFilterSet ( TRUE ) 

IF UpperBound ( ala_shipmentids[] ) > 0 THEN
	inv_dispatch.of_RetrieveShipments ( ala_shipmentids[] )
	lnv_Shipment.of_Setsource ( inv_dispatch.of_getShipmentcache( ) )
	
	ls_Sort = ids_source.Describe ( "Datawindow.Table.Sort" )
	ls_Filter = "ds_id " + lnv_sql.of_makeinclause( ala_shipmentids )	
	ids_source.SetFilter ( ls_Filter )
	ids_source.Filter ( )
	ll_Count = ids_source.RowCount ()
	IF ll_Count = 0 THEN
		li_Return = -1
	END IF
ELSE
	li_Return = 0
END IF

IF li_Return = 1 THEN
	FOR i = 1 TO ll_Count
		ll_ShipmentID = ids_source.object.ds_id [i]
		lnv_Shipment.of_SetSourceid( ll_ShipmentID )
		lnv_Shipment.of_Setstatus( gc_Dispatch.cs_ShipmentStatus_Open )
		ids_source.object.ds_Status [i] = gc_Dispatch.cs_ShipmentStatus_Open // this is just so the color changes
		ids_source.object.importedshipments_status [i] = THIS.cs_accept
	NEXT
END IF

ids_source.SetFilter ( "" )
ids_source.Filter ( )
IF li_Return = 1 THEN
	ids_source.SetSort ( ls_Sort )
	ids_source.Sort( )
END IF

Destroy ( lnv_Shipment )

RETURN li_Return

end function

public function boolean of_hasupdatespending ();RETURN ids_source.of_updatespending( ) = 1
	
end function

public function n_ds of_getcache ();RETURN ids_source
end function

public function integer of_declineshipments (long ala_shipmentids[], string as_reason);Int		li_Return = 1
String	ls_Filter
Long		ll_Count
Long		i
Long		ll_ShipmentID
String	ls_Sort
n_Cst_msg	lnv_Msg	
n_cst_sql	lnv_sql

n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment
lnv_Shipment.of_SetAllowFilterSet ( TRUE ) 

IF UpperBound ( ala_shipmentids[] ) > 0 THEN
	inv_dispatch.of_RetrieveShipments ( ala_shipmentids[] )
	lnv_Shipment.of_Setsource ( inv_dispatch.of_getShipmentcache( ) )	
	
	ls_Sort = ids_source.Describe ( "Datawindow.Table.Sort" )
	ls_Filter = "ds_id " + lnv_sql.of_makeinclause( ala_shipmentids )	
	ids_source.SetFilter ( ls_Filter )
	ids_source.Filter ( )
	ll_Count = ids_source.RowCount ()
	IF ll_Count = 0 THEN
		li_Return = -1
	END IF
ELSE
	li_Return = 0
END IF

IF li_Return = 1 THEN
	FOR i = 1 TO ll_Count
		ll_ShipmentID = ids_source.object.ds_id [i]
		
		lnv_Shipment.of_SetSourceid( ll_ShipmentID )
		lnv_Shipment.of_Setstatus( gc_Dispatch.cs_ShipmentStatus_declined )
		
		ids_source.object.ds_Status [i] = gc_Dispatch.cs_ShipmentStatus_declined // this is just so the color changes
		ids_source.object.importedshipments_status [i] = THIS.cs_Decline
		ids_source.object.importedshipments_statusReason [i] = as_reason
	NEXT
END IF

ids_source.SetFilter ( "" )
ids_source.Filter ( )
IF li_Return = 1 THEN
	ids_source.SetSort ( ls_Sort )
	ids_source.Sort( )
END IF

DESTROY ( lnv_Shipment )

RETURN li_Return
end function

public function integer of_save ();//Dan's Plan for modification to update the new pending 990 table as well
//look to see if there is a row for the shipId already.  If so, update it with 
//the new status.  If not, insert a row and update it accordingly.

int	li_Return = 1
String	ls_status
N_cst_setting_produce990edi	lnv_setting

lnv_setting = create N_cst_setting_produce990edi

this.of_Setshipidfor990( )

ids_source.Update ( TRUE ,FALSE )
IF sqlca.sqlcode <> 0 THEN
	ROLLBACK;
	li_Return = -1
ELSE
	COMMIT;
END IF


Long	ll_Count
Long	i
Long	ll_ShipmentID

n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_Cst_beo_shipment
lnv_Shipment.of_SetAllowFilterSet ( TRUE )

ll_Count = ids_Source.RowCount ( )
FOR i = 1 TO ll_Count
	ls_status = ""			//this needs to be cleared otherwise it will update the 990 status table with everything in the loop
								//after the accepted or declined values.  
	
	ll_ShipmentID = ids_source.GetItemNumber ( i , "ds_id" )
	inv_Dispatch = CREATE n_cst_Bso_Dispatch
	CHOOSE CASE ids_source.GetItemString ( i , "importedShipments_Status" )
			
		CASE THIS.cs_accept
			inv_Dispatch.of_Retrieveshipment( ll_ShipmentID )
			lnv_Shipment.of_SetSource ( inv_dispatch.of_GetShipmentcache( ) )
			lnv_Shipment.of_Setsourceid( ll_ShipmentID )
			ls_status = gc_Dispatch.cs_ShipmentStatus_Open //added by dan
			lnv_Shipment.of_Setstatus( ls_status )
			
		CASE THIS.cs_decline
			inv_Dispatch.of_Retrieveshipment( ll_ShipmentID )
			inv_dispatch.of_Retrieveequipmentforshipment( ll_ShipmentID )
			lnv_Shipment.of_setContext ( inv_dispatch )
			lnv_Shipment.of_SetSource ( inv_dispatch.of_GetShipmentcache( ) )
			lnv_Shipment.of_Setsourceid( ll_ShipmentID )		
			ls_status = gc_Dispatch.cs_ShipmentStatus_Declined	//added by dan
			lnv_Shipment.of_Setstatus( ls_status )		
			
			
	END CHOOSE
	
	inv_dispatch.event pt_save( )
	
	//added by dan, only add accepted or declined shipments becuase it does no filtering when we send the 990
	IF len(ls_status) > 0 AND lnv_setting.of_getValue() = lnv_setting.cs_no THEN
		this.of_update990status( ll_ShipmentID, ls_status, ids_source.getItemString( i , "importedshipments_senderscode" ) )
	END IF
	//---------------
	
	DESTROY ( inv_dispatch )
		
NEXT

DESTROY ( lnv_Shipment )

inv_Dispatch = CREATE n_Cst_bso_Dispatch

IF li_Return = 1 THEN  // we will need to send the appropriate 990s
//commented out because the scheduler is going to take care of it from now on
	IF lnv_setting.of_getvalue( ) = lnv_setting.cs_yes THEN
		this.of_send990()			
	END IF
END IF

DESTROY lnv_setting
RETURN li_Return


end function

public subroutine of_send990 ();Long		ll_Count, &
			i, &
			lla_ShipmentID[]
			
string	ls_status
String	ls_transaction

n_cst_edi_transaction_990	lnv_EDI
	
n_cst_setting_edi204version	lnv_204Version

lnv_204Version = CREATE n_cst_setting_edi204version

IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct THEN

	ls_transaction = "n_cst_edi_transaction_990"
	lnv_EDI = create using ls_transaction

	if this.of_Getshipidfor990( lla_shipmentid) > 0 then
		lnv_EDI.of_SendTransaction(ids_source, lla_ShipmentID)
	end if
	
	destroy lnv_EDI
	
END IF

destroy lnv_204Version

end subroutine

public function integer of_retrieveandacceptall ();Int	li_Return = 1
Long	ll_Count
Long	i
Long	lla_ShipmentIDS[]
String	lsa_Scacs[]
String	ls_inClause

n_cst_Sql	lnv_Sql
n_Cst_AnyArraysrv	lnv_Array


THIS.of_Retrivepending( )

IF THIS.of_GetAutoacceptscacs( lsa_Scacs ) > 0 THEN
	ls_inClause = lnv_sql.of_Makeinclausefromstrings( lsa_Scacs )
	ids_source.SetFilter ( "importedshipments_senderscode " + ls_InClause )
	ids_Source.Filter( )


	ll_Count = ids_source.RowCount ( )
	
	FOR i = 1 TO ll_Count
		
		lla_ShipmentIDS[i] = ids_Source.object.ds_ID[i]
		
	NEXT
	
	lnv_Array.of_GetShrinked ( lla_ShipmentIDS, TRUE , TRUE )
	
	IF UpperBound ( lla_ShipmentIDS ) > 0 THEN
		THIS.of_Acceptshipments( lla_ShipmentIDS )
		THIS.of_save( )
	END IF
	
	ids_source.SetFilter ( "" ) 
	ids_source.Filter( )
	

END IF

RETURN li_Return
end function

public subroutine of_setshipidfor990 ();//what ids were modified
long		ll_row, &
			ll_rowcount, &
			lla_shipid[]
			
integer	li_count

string	ls_shiplist

ll_rowcount = ids_source.rowcount( )

for ll_row = 1 to ll_rowcount

	choose case ids_source.GetItemStatus(ll_row, 'importedshipments_status', Primary!)
		case datamodified!
			li_count ++
			lla_shipid[li_count] = ids_source.object.importedshipments_shipmentid[ll_row]
	end choose
next

ila_990shipid = lla_shipid

end subroutine

public function integer of_getshipidfor990 (ref long ala_shipid[]);ala_shipid = ila_990shipid

return upperbound(ila_990shipid)
end function

private function integer of_getautoacceptscacs (ref string asa_scacs[]); String	ls_Version
 Int	li_Count
 String	lsa_Scacs[]
 String	ls_Scac
 
 
 ls_Version = appeon_constant.cs_ediversion_directwithautoreply
 
 
 DECLARE cur_Scacs CURSOR FOR  
  SELECT "ediprofile"."scac"  
    FROM "edi204profile",   
         "ediprofile"  
   WHERE ( "edi204profile"."companyid" = "ediprofile"."companyid" ) and  
         ( ( "ediprofile"."transactionset" = 204 ) AND  
         ( "edi204profile"."ediversion" = :ls_Version )   
         )   ;

OPEN cur_Scacs;

FETCH cur_Scacs INTO :ls_Scac;
// Loop through result set until exhausted.

DO WHILE SQLCA.sqlcode = 0
	IF LEN ( ls_Scac ) > 0 THEN
		li_Count ++
		lsa_Scacs[li_Count] = ls_Scac
	END IF
	// Fetch the next row from the result set.
	FETCH cur_Scacs INTO :ls_Scac;
LOOP

// All done, so close the cursor.

CLOSE cur_Scacs;

Commit;
asa_scacs[] = lsa_Scacs

RETURN li_Count
end function

public function integer of_retrieveids (long ala_ids[]);//written by dan 5-17-06 to retrieve specified shipment ids.

Long	ll_Return
Long	ll_RetrieveRtn
String	ls_oldselect
String	ls_newSelect
N_cst_sql	lnv_sql
string			li_result
n_cst_string	lnv_string
Long				ll_pos

IF upperBOund( ala_ids ) > 0 THEN
										
	DESTROY ( inv_dispatch ) // we are doing this to clear the cache
	inv_dispatch = CREATE n_cst_bso_Dispatch
	
	ls_oldselect = ids_source.describe("datawindow.table.select")
	
	//i copied this from the debugger on the describe above and modified the where clause
	ls_newSelect = left( ls_oldselect, POS(ls_oldSelect, "WHERE") - 1 )
	ls_newSelect += "WHERE ( ~~~"importedshipments~~~".~~~"shipmentid~~~" = ~~~"disp_ship~~~".~~~"ds_id~~~"   AND ~~~"disp_ship~~~".~~~"ds_id~~~" " +lnv_sql.of_makeinclause( ala_ids )+")"
				
	//lnv_string.of_globalreplace( ls_newSelect, "~", /*string as_new */)			
	li_result = ids_source.modify( "datawindow.table.select = '"+ ls_newSelect+"'")
 	ll_RetrieveRtn = ids_source.retrieve("a")		//just to keep retrieve happy, it doesn't actually use the argument
	Commit;
	
	//put it back the way it was
	li_result = ids_source.modify( "datawindow.table.select = '"+ ls_oldSelect +"'")
	
	IF ll_RetrieveRtn >= 0 THEN
		ll_Return = ll_RetrieveRtn
		ids_source.Sort ( )
		
		this.of_changestatus( )		//this call changes every row and column to modified so that 
										//the user doesn't have to reselect and accept and decline.
										//This is expecting that we are resending the edi
		this.of_setshipidfor990( )
		
	ELSE
		ll_Return = -1
	END IF
	
ELSE
	ll_return = -1
END IF

RETURN ll_Return



end function

public function integer of_update990status (long al_shipid, string as_status, string as_senderscode);//implemented by dan to update the new 990 pending cache with the shipments new status.
//accepted or declined..
Long	ll_index
Long	ll_max
String	ls_find
Int	li_Return
Int	li_res

Datastore	lds_990Pending
lds_990Pending = create Datastore
lds_990Pending.dataobject = "d_990Status"
lds_990Pending.settransobject( SQLCA )

ll_max = lds_990Pending.retrieve()

IF al_shipId > 0 THEN
	ls_find = " shipid = "+ string( al_shipId )
	ll_index = lds_990Pending.find( ls_find, 1, ll_max)
	
	//we don't want a shipment to be in there mroe than once
	IF ll_index > 0 THEN
		
	ELSE
		ll_index = lds_990Pending.insertrow( 0 )
	END IF
END IF

IF ll_index > 0 THEN
	li_res = lds_990Pending.setItem( ll_index, "shipid", al_shipId )
	li_res = lds_990Pending.setItem( ll_index, "status", as_status )
	li_res = lds_990Pending.setItem( ll_index, "entrydate", today() )
	li_res = lds_990Pending.setItem( ll_index, "entrytime", now() )
	li_res = lds_990Pending.setItem( ll_index, "scac", as_senderscode )
	li_res = lds_990Pending.setItem( ll_index, "userid", gnv_app.of_getnumericuserid( ) )
	li_res = lds_990Pending.setItem( ll_index, "messagestatus", appeon_constant.ci_messagestatus_pending )
END IF



IF lds_990Pending.Update() = 1 THEN
	COmmit;
	li_Return = 1
ELSE
	RollBack;
	li_return = -1
END IF

DESTROY 		lds_990Pending
RETURN 		li_Return
end function

private function integer of_changestatus ();//implemented by Dan and called by retrieve(ids) so that resending edi will
//resend all of the ids in the window view without them having to accept and decline all over again
Long	ll_index
Long	ll_max
Int	li_res

ll_max = ids_source.rowCount()
FOR ll_index = 1 TO ll_max
	li_Res = ids_source.setitemstatus( ll_index, 'importedshipments_status', PRIMARY!, DATAMODIFIED!)	
NEXT

RETURN ll_max
end function

on n_cst_edishipmentreview.create
call super::create
end on

on n_cst_edishipmentreview.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_source = CREATE n_ds
ids_source.Dataobject = THIS.is_sourcedataobject
ids_source.SetTransObject ( SQLCA )

inv_dispatch = CREATE n_cst_bso_Dispatch




end event

event destructor;call super::destructor;DESTROY ( ids_source )
DESTROY ( inv_dispatch )
end event

