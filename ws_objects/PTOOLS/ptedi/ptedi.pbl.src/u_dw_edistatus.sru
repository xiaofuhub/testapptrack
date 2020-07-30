$PBExportHeader$u_dw_edistatus.sru
forward
global type u_dw_edistatus from u_dw
end type
end forward

global type u_dw_edistatus from u_dw
integer width = 2240
integer height = 804
string dataobject = "d_edistatus"
boolean hscrollbar = true
end type
global u_dw_edistatus u_dw_edistatus

on u_dw_edistatus.create
end on

on u_dw_edistatus.destroy
end on

event constructor;call super::constructor;This.of_SetResize ( TRUE )

inv_Resize.of_SetMinSize ( 1200, 800 )

// enable multi-row-select-ability
THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (2) //2 = extended row select service

of_setinsertable ( false )
of_setDeleteable ( false )

of_SetAutoFind ( TRUE ) 
of_SetAutoSort ( TRUE )
of_SetFilter ( TRUE )

this.SetTransobject(sqlca)


end event

