$PBExportHeader$u_dw_shipmentstatus_details.sru
forward
global type u_dw_shipmentstatus_details from u_dw
end type
end forward

global type u_dw_shipmentstatus_details from u_dw
integer width = 1911
integer height = 568
string dataobject = "d_edipending"
boolean vscrollbar = false
event ue_cleardate ( )
event ue_cleartime ( )
event ue_selectestimateddelivery ( )
end type
global u_dw_shipmentstatus_details u_dw_shipmentstatus_details

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
public subroutine of_initializereason ()
end prototypes

event ue_cleartime();Time lt_Null
SetNull ( lt_Null )

THIS.SetItem ( THIS.GetRow ( ) , "statustime"  , lt_Null )
end event

event ue_selectestimateddelivery();
Long		ll_FindRow 
string	ls_status, &
			ls_reason



ll_FindRow = idwc_Status.Find ( "definition = 'Estimated Delivery'" , 1, 9999 )

IF ll_FindRow > 0 THEN
	ls_status = idwc_Status.GetItemstring ( ll_FindRow , "code" )
	
	IF len(trim(ls_status)) > 0 THEN
		THIS.SetItem ( THIS.GetRow ( ) , "status", ls_status )
	END IF
	THIS.SetItem ( THIS.GetRow ( ) , "reason", ls_reason )	
	THIS.SetColumn ( "statustime" )
	
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
if idwc_status.rowcount() > 0 then
	idwc_status.setrow(1)
end if

RETURN 1
end function

public function integer of_getchildren ();Long	ll_Rtn
THIS.GetChild ( "status" , idwc_Status )
THIS.GetChild ( "reason" , idwc_Reasons )
idwc_Status.SetTransObject ( SQLCA )
idwc_Reasons.SetTransObject ( SQLCA )

ll_Rtn = idwc_Status.Retrieve ( )
ll_Rtn = idwc_Reasons.Retrieve ( ) 

RETURN 1
end function

public function integer of_initializedate ();IF THIS.RowCount ( ) > 0 THEN
	THIS.SetItem ( 1, "statusdate" , TODAY ( ) )
END IF
RETURN 1
end function

public function integer of_initializetime ();IF THIS.RowCount () > 0 THEN
	THIS.SetItem ( 1 , "statustime" , NOW ( ) )
END IF

RETURN 1
end function

public subroutine of_initializereason ();string	ls_code

if idwc_reasons.rowcount() > 0 then
	ls_code = idwc_reasons.getitemstring(1, 'code' )
	this.object.reason[1] = ls_code
end if
end subroutine

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
		
	CASE "statustime"
		
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
	CASE "statusdate"
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

on u_dw_shipmentstatus_details.create
end on

on u_dw_shipmentstatus_details.destroy
end on

