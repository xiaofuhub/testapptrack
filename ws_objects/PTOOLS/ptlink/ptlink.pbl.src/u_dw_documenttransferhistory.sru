$PBExportHeader$u_dw_documenttransferhistory.sru
forward
global type u_dw_documenttransferhistory from u_dw
end type
end forward

global type u_dw_documenttransferhistory from u_dw
integer width = 2779
integer height = 1236
string dataobject = "d_documenttransferhistoryreview"
boolean border = false
borderstyle borderstyle = stylebox!
end type
global u_dw_documenttransferhistory u_dw_documenttransferhistory

on u_dw_documenttransferhistory.create
end on

on u_dw_documenttransferhistory.destroy
end on

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA )
THIS.of_SetInsertable( FALSE )
THIS.Retrieve () 
THIS.of_SetAutosort( TRUE )
THIS.of_SetAutofilter( TRUE )
THIS.of_Setrowselect( TRUE )
inv_Rowselect.of_Setstyle( inv_rowselect.extended )


end event

event pfc_deleterow;//OVERRIDE

Long	ll_RowCount
Long	i
Long	lla_Selected[]
Long	ll_Count

ll_RowCount = THIS.RowCount ( )

THIS.SetRedraw ( FALSE ) 
FOR i = 1 TO ll_RowCount
	IF isSelected( i ) THEN
		ll_Count ++
		lla_Selected[ll_Count] = i
	END IF
NEXT


FOR i = ll_Count To 1 STEP -1
	This.DeleteRow ( lla_Selected[i] ) 
NEXT

THIS.SetRedraw ( TRUE ) 



RETURN 1
end event

