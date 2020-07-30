$PBExportHeader$u_dw_shipmentstatus_details_van.sru
forward
global type u_dw_shipmentstatus_details_van from u_dw
end type
end forward

global type u_dw_shipmentstatus_details_van from u_dw
integer width = 1623
integer height = 792
string dataobject = "d_shipmentstatus_details"
boolean vscrollbar = false
event ue_cleardate ( )
event ue_cleartime ( )
event ue_selectestimateddelivery ( )
end type
global u_dw_shipmentstatus_details_van u_dw_shipmentstatus_details_van

type variables
DataWindowChild    idwc_Status
DataWindowChild	idwc_Reasons
end variables

forward prototypes
public function integer of_filterstatus ()
public function integer of_filterreason ()
public function integer of_filterstatusfornew ()
public function integer of_getchildren ()
public function integer of_initializedate ()
public function integer of_initializetime ()
end prototypes

event ue_cleartime;Time lt_Null
SetNull ( lt_Null )

THIS.SetItem ( THIS.GetRow ( ) , "shipment_status_status_time"  , lt_Null )
end event

event ue_selectestimateddelivery;
Long	ll_FindRow 
Long	ll_ETDID
Long	ll_Null
SetNull ( ll_Null )

ll_FindRow = idwc_Status.Find ( "definition = 'Estimated Delivery'" , 1, 9999 )

IF ll_FindRow > 0 THEN
	ll_ETDID = idwc_Status.GetItemNumber ( ll_FindRow , "id" )
	
	IF ll_ETDID > 0 THEN
		THIS.SetItem ( THIS.GetRow ( ) , "shipment_status_edi_status_id", ll_ETDID )
	END IF
	THIS.SetItem ( THIS.GetRow ( ) , "shipment_status_edi_reason_id", ll_null )	
	THIS.SetColumn ( "shipment_status_status_time" )
	
END IF
end event

public function integer of_filterstatus ();idwc_Status.SetFilter ( "segmentid = 'AT7' AND referenceid = '01'" )
idwc_Status.Filter ( ) 

RETURN 1
end function

public function integer of_filterreason ();
idwc_Reasons.SetFilter ( "segmentid = 'AT7' AND referenceid = '02'" )
idwc_Reasons.Filter ( )

return 1
end function

public function integer of_filterstatusfornew ();idwc_Status.SetFilter ( "segmentid = 'AT7' AND referenceid = '01'" )
idwc_Status.Filter ( ) 

RETURN 1
end function

public function integer of_getchildren ();Long	ll_Rtn
THIS.GetChild ( "shipment_status_edi_status_id" , idwc_Status )
THIS.GetChild ( "shipment_status_edi_reason_id" , idwc_Reasons )
idwc_Status.SetTransObject ( SQLCA )
idwc_Reasons.SetTransObject ( SQLCA )

ll_Rtn = idwc_Status.Retrieve ( )
ll_Rtn = idwc_Reasons.Retrieve ( ) 

RETURN 1
end function

public function integer of_initializedate ();IF THIS.RowCount ( ) > 0 THEN
	THIS.SetItem ( 1, "shipment_status_status_date" , TODAY ( ) )
END IF
RETURN 1
end function

public function integer of_initializetime ();IF THIS.RowCount () > 0 THEN
	THIS.SetItem ( 1 , "shipment_status_status_time" , NOW ( ) )
END IF

RETURN 1
end function

event constructor;Long	ll_Rtn
n_cst_events	lnv_Events 


This.Modify ( "event_type.Edit.CodeTable = Yes "+&
	"event_type.Values = '" + lnv_Events.of_GetTypeCodeTable ( ) + "'" )




end event

event itemchanged;call super::itemchanged;//CHOOSE CASE lower ( dwo.name )
//		
//	CASE "edi_status_definition"
//		
////		THIS.of_FilterReasons ( data )
//		
//END CHOOSE
end event

event buttonclicked;CHOOSE CASE dwo.Name
		
	CASE "cb_eta"
		
	
		THIS.EVENT ue_ClearTime	( )
		THIS.EVENT ue_SelectEstimatedDelivery ( )
		
		
		
END CHOOSE


end event

event itemerror;call super::itemerror;n_cst_String	lnv_String
Date	ld_CompDate
Time	lt_CompTime, &
		lt_null

Long	ll_Rtn

setnull(lt_null)
CHOOSE CASE dwo.Name
		
	CASE "shipment_status_status_time"
		
		ll_Rtn = 3 
		//Attempt to convert the text typed to a time
		lt_CompTime = lnv_string.of_SpecialTime(data)
		
		if isnull(lt_CompTime) then
			//Value is really invalid
			this.setitem(row, String (dwo.Name), lt_null)
			
		ELSE
			this.setitem(row, String (dwo.Name), lt_CompTime)
		
			//lb_Processed = TRUE
		
		END IF
	CASE "shipment_status_status_date"
		ll_Rtn = 3
		
		//Attempt to convert the text typed to a date
		ld_CompDate = lnv_string.of_SpecialDate(data)

		if isnull(ld_CompDate) then
			//Value is really invalid
	
		ELSE
			this.setitem(row, String (dwo.Name), ld_CompDate)
				
			//lb_Processed = TRUE
	
		END IF
		
END CHOOSE

RETURN ll_Rtn
end event

on u_dw_shipmentstatus_details_van.create
end on

on u_dw_shipmentstatus_details_van.destroy
end on

