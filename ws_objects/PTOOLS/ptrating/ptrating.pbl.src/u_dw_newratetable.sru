$PBExportHeader$u_dw_newratetable.sru
forward
global type u_dw_newratetable from u_dw
end type
end forward

global type u_dw_newratetable from u_dw
integer width = 1618
integer height = 376
string dataobject = "d_ratetables"
end type
global u_dw_newratetable u_dw_newratetable

event constructor;n_cst_Presentation_Amounttype lnv_presentationamounttype

lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_both)
lnv_presentationamounttype.of_setpresentation(this)

n_cst_Presentation_RateTable	lnv_Pres
lnv_Pres.of_SetPresentation ( THIS )
end event

event itemchanged;call super::itemchanged;Long	ll_Return

ll_Return = AncestorReturnValue

CHOOSE CASE dwo.name
		
	CASE "name"
		IF THIS.Find ( "name = '" + data +"'" , 1 ,THIS.RowCount( )  ) > 0 THEN
			ll_Return = 1
			MessageBox ( "Table Name" , "The name entered already exists. Please alter your entry." )
		END IF
		
END CHOOSE

Return ll_Return
end event

event itemerror;call super::itemerror;Long	ll_Return

ll_Return = AncestorReturnValue

CHOOSE CASE dwo.name
		
	CASE "name"
		IF isNull ( data )  THEN
			MessageBox ( "Table Name" , "Enter a name." )
		END IF
		ll_Return = 1
END CHOOSE

Return ll_Return
end event

event pfc_addrow;call super::pfc_addrow;THIS.ScrollToRow ( THIS.RowCount( ) ) 
THIS.SetColumn ( 1 )
RETURN AncestorReturnValue
end event

event pfc_insertrow;call super::pfc_insertrow;Long	ll_Row

ll_Row = AncestorReturnValue
IF ll_Row > 0 THEN
	THIS.SetRow ( ll_Row )
	THIS.SetColumn ( 1 )
END IF


RETURN ll_Row
end event

on u_dw_newratetable.create
end on

on u_dw_newratetable.destroy
end on

