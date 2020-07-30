$PBExportHeader$w_shipmentlistorder_routerepos.srw
forward
global type w_shipmentlistorder_routerepos from w_shipmentlistorder
end type
end forward

global type w_shipmentlistorder_routerepos from w_shipmentlistorder
integer height = 2060
end type
global w_shipmentlistorder_routerepos w_shipmentlistorder_routerepos

on w_shipmentlistorder_routerepos.create
call super::create
end on

on w_shipmentlistorder_routerepos.destroy
call super::destroy
end on

event ue_route;call super::ue_route;Int li_Return

Long ll_Id
Long ll_Ctr
Long ll_RowFound
Long lla_ShipmentId[]

String ls_Search

n_cst_ShipmentManager lnv_ShipmentManager

n_cst_bso_dispatch lnv_dispatch
lnv_dispatch = CREATE n_cst_bso_dispatch

ib_Cancel = FALSE

// Array of selected shipmentids.
dw_1.of_getselectedShipmentids(lla_ShipmentId)

//Because "of_getselectedShipmentids" method gets rid of the rowselection, do this
FOR ll_Ctr = 1 TO UpperBound(lla_ShipmentId)
	ls_Search = "ds_id = " + String(lla_ShipmentId[ll_Ctr])
	ll_RowFound = dw_1.Find(ls_Search,1,dw_1.Rowcount())
	IF ll_RowFound > 0 THEN
		dw_1.SelectRow(ll_RowFound,True)
	END IF
NEXT

// Shrink the array and get duplicates & null free array
n_cst_AnyArraySrv lnv_ArraySrv
lnv_ArraySrv.of_Getshrinked(lla_ShipmentId,TRUE,TRUE)

IF UpperBound(lla_ShipmentId) > 0 THEN
	//n_cst_beo_Event		lnv_Event
	//lnv_Event = CREATE n_cst_beo_Event
	li_Return = lnv_ShipmentManager.of_Autoroute(lla_ShipmentId,lnv_dispatch,FALSE,FALSE)
	IF  li_Return = 1 THEN
		
		// Save on successful routing
		IF lnv_dispatch.event pt_save( ) = 1 THEN 
			MessageBox("Auto Route Repos","Events were routed successfully.")
		ELSE	
			MessageBox("Auto Route Repos","Events were routed but not saved.")
		End IF
		/* On hold for now - to be done later 
		IF MessageBox("Auto Route Repos","Do you want to confirm all events with default times", & 
							Question!,YesNo!,2)  = 1 THEN
			
			// reltime_ext()
			// IF lnv_Event.of_SetTimeDeparted ( Time ( ls_ComputedTime ) ) = 1 THEN
			// IF lnv_Event.of_SetTimeArrived  ( Time ( ls_ComputedTime ) ) = 1 THEN
	
			ll_Id = lnv_Event.of_GetId ( )
			lnv_Dispatch.of_ConfirmEvent ( ll_Id, TRUE /*Interactive*/ )
			*/

	ELSEIF li_Return = -1 THEN
		int 		li_errorCount
		int		i
		String	ls_ErrorString

		n_cst_OFRError lnva_Error[]
		n_cst_OFRError_Collection lnv_ErrorCollection
		
		lnv_ErrorCollection = lnv_Dispatch.GetOFRErrorCollection ( )
		lnv_Errorcollection.GetErrorArray( lnva_Error )
		li_ErrorCount = upperBound(lnva_Error)
		
		For i = 1 TO li_ErrorCount
			ls_ErrorString += String( lnva_Error[i].getErrorMessage() )
		next
		
		MessageBox("Auto Route Repos" , ls_ErrorString , EXCLAMATION! )
	END IF
	
	DESTROY (lnv_dispatch)
	//DESTROY (lnv_Event)
	//Close(This)
ELSE
	MessageBox("Auto Route Repos","No rows are selected for routing.")
	Return
END IF	

IF li_Return = 1 THEN 
	CLOSE(THIS)
END IF
end event

type cb_unselectall from w_shipmentlistorder`cb_unselectall within w_shipmentlistorder_routerepos
end type

type cb_selectall from w_shipmentlistorder`cb_selectall within w_shipmentlistorder_routerepos
end type

type cb_ok from w_shipmentlistorder`cb_ok within w_shipmentlistorder_routerepos
string text = "Route"
end type

event cb_ok::clicked;call super::clicked;event ue_route( )
end event

type dw_1 from w_shipmentlistorder`dw_1 within w_shipmentlistorder_routerepos
borderstyle borderstyle = StyleLowered!
end type

event dw_1::rbuttonup;// Override

// ZMC 12-12-03 Show Shipment notes for AutoRoute Repos
String ls_Name
String lsa_parm_labels[]
Any laa_parm_values[]

ls_Name = Lower ( dwo.Name )

CHOOSE CASE ls_name
	CASE "p_shipnotesfull", "p_shipnotesempty"
		lsa_parm_labels[1] = "ADD_ITEM"
		laa_parm_values[1] = "View Notes"
		IF f_pop_standard(lsa_parm_labels, laa_parm_values) = "VIEW NOTES" THEN
			THIS.event ue_ShowNotes(This.Object.ds_id[row])	
		END IF
END CHOOSE		
// ZMC 12-12-03 Show Shipment notes for AutoRoute Repos		

end event

type cb_cancel from w_shipmentlistorder`cb_cancel within w_shipmentlistorder_routerepos
end type

type cb_bottom from w_shipmentlistorder`cb_bottom within w_shipmentlistorder_routerepos
end type

type cb_top from w_shipmentlistorder`cb_top within w_shipmentlistorder_routerepos
end type

type cb_down from w_shipmentlistorder`cb_down within w_shipmentlistorder_routerepos
end type

type cb_up from w_shipmentlistorder`cb_up within w_shipmentlistorder_routerepos
end type

type gb_1 from w_shipmentlistorder`gb_1 within w_shipmentlistorder_routerepos
end type

