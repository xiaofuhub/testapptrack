$PBExportHeader$u_tabpg_postingrules_company.sru
forward
global type u_tabpg_postingrules_company from u_tabpg
end type
type cb_2 from commandbutton within u_tabpg_postingrules_company
end type
type cb_1 from commandbutton within u_tabpg_postingrules_company
end type
type dw_list from u_dw_postingrules_company within u_tabpg_postingrules_company
end type
end forward

global type u_tabpg_postingrules_company from u_tabpg
integer width = 2981
integer height = 976
long backcolor = 12632256
cb_2 cb_2
cb_1 cb_1
dw_list dw_list
end type
global u_tabpg_postingrules_company u_tabpg_postingrules_company

on u_tabpg_postingrules_company.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_list
end on

on u_tabpg_postingrules_company.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_list)
end on

type cb_2 from commandbutton within u_tabpg_postingrules_company
integer x = 2569
integer y = 164
integer width = 334
integer height = 96
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Remove"
end type

event clicked;dw_list.event pfc_deleterow( )
end event

type cb_1 from commandbutton within u_tabpg_postingrules_company
integer x = 2569
integer y = 36
integer width = 334
integer height = 96
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add"
end type

event clicked;dw_list.event pfc_addrow( )
end event

type dw_list from u_dw_postingrules_company within u_tabpg_postingrules_company
integer x = 20
integer y = 20
integer width = 2482
integer height = 928
integer taborder = 10
end type

