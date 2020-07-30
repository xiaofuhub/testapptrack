$PBExportHeader$u_dw_shipimportresults.sru
forward
global type u_dw_shipimportresults from u_dw
end type
end forward

global type u_dw_shipimportresults from u_dw
int Width=2400
int Height=828
string DataObject="d_shipimportresults"
end type
global u_dw_shipimportresults u_dw_shipimportresults

forward prototypes
public function integer of_populate (n_cst_EDI_204_Record anva_Records[])
public function integer of_importfile (string as_FileName)
end prototypes

public function integer of_populate (n_cst_EDI_204_Record anva_Records[]);Int	li_Count
Int	i
Long	ll_NewRow
String	ls_Message
Boolean	lb_Success
Long		ll_ShipmentID

li_Count = UpperBound ( anva_Records )


FOR i = 1 TO li_Count
	ll_NewRow = THIS.insertRow ( 0 )
	
	ll_ShipmentID = anva_Records[i].of_GetShipmentID ( )
	lb_Success = anva_Records[i].of_GetSuccessfulImportFlag ( )
	IF lb_Success THEN
		ls_Message = "Shipment imported successfully"
	ELSE
		ls_Message = anva_Records[i].of_GetErrorText ( )
	END IF
	
	IF ll_NewRow > 0 THEN
		THIS.SetItem ( ll_NewRow , "ShipmentID" , ll_ShipmentID )
		THIS.SetItem ( ll_NewRow , "ErrorText" , ls_Message )
	END IF
	
	
	
NEXT

RETURN 1
end function

public function integer of_importfile (string as_FileName);
RETURN THIS.ImportFile  ( as_FileName )


end function

event doubleclicked;Long			ll_ShipID
w_dispatch 	lw_dispwindow
s_Parm		lstr_Parm
n_cst_msg	lnv_Msg

IF row > 0 THEN
	ll_ShipID = THIS.GetItemNumber ( row , "shipmentID" )
	
	IF ll_ShipID > 0 THEN		

		lstr_parm.is_Label = "CATEGORY"
		lstr_Parm.ia_Value = "SHIP"
		lnv_msg.of_Add_Parm ( lstr_Parm )
		
		lstr_parm.is_Label = "ID"
		lstr_Parm.ia_Value = ll_ShipID
		lnv_msg.of_Add_Parm ( lstr_Parm )
			
		
		opensheetwithparm(lw_dispwindow, lnv_msg, gnv_app.of_GetFrame ( ), 0, LAYERED!)
		
	END IF
	
END IF
end event

