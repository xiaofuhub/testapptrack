$PBExportHeader$u_dw_documenttransferqueue.sru
forward
global type u_dw_documenttransferqueue from u_dw
end type
end forward

global type u_dw_documenttransferqueue from u_dw
integer width = 3625
integer height = 796
string dataobject = "d_documentqueue"
end type
global u_dw_documenttransferqueue u_dw_documenttransferqueue

forward prototypes
public function integer of_showtransfersforcompany (long al_coid)
public function integer of_showtransfersforshipment (long al_shipmentid)
public function integer of_resetexpiration (long al_row)
public function integer of_resetexpiration (long ala_rows[])
end prototypes

public function integer of_showtransfersforcompany (long al_coid);String	ls_Filter
//Long	ll_Count
///ll_Count = THIS.retrieve( )
ls_Filter = "targetcompany = " + String ( al_coid ) 
THIS.SetFilter ( ls_Filter )
THIS.Filter ( )

THIS.Modify ( "companies_co_name.width = 0" )

RETURN 1
end function

public function integer of_showtransfersforshipment (long al_shipmentid);String	ls_Filter

ls_Filter = "SourceID = " + String ( al_shipmentid ) 
THIS.SetFilter ( ls_Filter )
THIS.Filter ( )

THIS.Modify ( "SourceID.width = 0" )

RETURN 1
end function

public function integer of_resetexpiration (long al_row);Long	ll_Company
Long	li_KeepDays
Date	ld_ExpirationDate

ll_Company = THIS.GetItemNumber( al_Row, "TargetCompany" )

SELECT "companydocumenttransfersettings"."daystokeepactive"  
 INTO :li_KeepDays  
 FROM "companydocumenttransfersettings"  
WHERE "companydocumenttransfersettings"."coid" = :ll_Company   ;

IF SQLCA.Sqlcode = 0 THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF
	
IF li_KeepDays > 0 THEN
	ld_ExpirationDate = RelativeDate ( Today ( ) , li_KeepDays )
	THIS.SetItem ( al_Row , "expirationdate" , ld_ExpirationDate ) 	
END IF

RETURN 1
end function

public function integer of_resetexpiration (long ala_rows[]);Long	ll_Count
Long	i
ll_Count = UpperBound ( ala_rows[] )


FOR i = 1 TO ll_Count
	THIS.of_Resetexpiration( ala_rows[i] )
NEXT

RETURN 1

end function

on u_dw_documenttransferqueue.create
end on

on u_dw_documenttransferqueue.destroy
end on

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA ) 
SetPointer ( HOURGLASS! )
THIS.SetRedraw( FALSE )
THIS.Retrieve ( )
THIS.of_SetInsertable( FALSE )
THIS.of_SetRowselect( TRUE )
THIS.of_SetAutoSort ( TRUE ) 
THIS.of_SetAutoFilter ( TRUE ) 
inv_rowselect.of_setstyle( inv_rowselect.extended )
n_Cst_Privileges	lnv_Privs

IF lnv_Privs.of_Hasadministrativerights( ) THEN
	THIS.object.holdtransfer.protect = 0
	THIS.of_SetDeleteable( TRUE )
ELSE
	THIS.object.holdtransfer.protect = 1
	THIS.of_SetDeleteable( FALSE )
END IF

THIS.SetRedraw( TRUE )
end event

event rbuttonup;/// override w. call to super
String	ls_PopReturn 
String	lsa_Labels[]
Any		laa_Values[]
Long		lla_SelectedRows[]

IF dwo.name = "expirationdate" THEN

	lsa_Labels[1] = "ADD_ITEM"
	laa_Values[1] = "Reset Expiration"

	lsa_Labels[2] = "XPOS"
	laa_Values[2] = Pointerx( )
		
	lsa_Labels[3] = "YPOS"
	laa_Values[3] = PointerY( )

	ls_PopReturn = f_pop_standard (lsa_Labels ,laa_Values  ) 
	
	IF ls_PopReturn = "RESET EXPIRATION" THEN
		inv_rowselect.of_selectedcount( lla_SelectedRows )
		THIS.of_resetexpiration( lla_SelectedRows )
	END IF
	RETURN 1
ELSE
	RETURN SUPER::event rbuttonup(  xpos,  ypos,  row, dwo )
	
END IF
end event

event itemchanged;call super::itemchanged;Char	lc_NewValue
Int	li_Count
Int	i
Long	lla_Rows[]


IF dwo.Name = "holdtransfer" THEN

	lc_NewValue = data
	
	li_Count = inv_Rowselect.of_Selectedcount( lla_Rows )
	IF li_Count > 0 THEN
		FOR i = 1 TO li_Count
			THIS.SetItem ( lla_Rows[i] , "holdtransfer" , lc_NewValue )
		NEXT
		IF lc_NewValue = '0' THEN
			THIS.of_Resetexpiration( lla_Rows )
		END IF
		
	ELSE
		THIS.SetItem ( row , "holdtransfer" , lc_NewValue )
		IF lc_NewValue = '0' THEN
			THIS.of_Resetexpiration( row )
		END IF
	END IF
	
END IF
end event

event pfc_deleterow;Int	li_Count
Int	i
Long	lla_Rows[]

THIS.SetRedraw ( FALSE )
SetPointer ( HOURGLASS! )
li_Count = inv_Rowselect.of_Selectedcount( lla_Rows )
IF li_Count > 0 THEN
	FOR i = li_Count TO 1 STEP -1
		THIS.DeleteRow ( lla_Rows [i] ) 
	NEXT

END IF

THIS.SetReDraw ( TRUE )


RETURN 1
end event

