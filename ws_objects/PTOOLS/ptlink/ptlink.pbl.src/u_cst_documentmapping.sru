$PBExportHeader$u_cst_documentmapping.sru
forward
global type u_cst_documentmapping from u_base
end type
type cb_2 from commandbutton within u_cst_documentmapping
end type
type cb_1 from commandbutton within u_cst_documentmapping
end type
type dw_1 from u_dw_documentmapping within u_cst_documentmapping
end type
end forward

global type u_cst_documentmapping from u_base
integer width = 2725
long backcolor = 12632256
event ue_itemchanged ( )
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global u_cst_documentmapping u_cst_documentmapping

forward prototypes
public function integer of_retrieve (long al_coid)
end prototypes

public function integer of_retrieve (long al_coid);RETURN dw_1.of_Retrieve ( al_coid )
end function

on u_cst_documentmapping.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on u_cst_documentmapping.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within u_cst_documentmapping
integer x = 2350
integer y = 172
integer width = 329
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;dw_1.event pfc_deleterow( )
end event

type cb_1 from commandbutton within u_cst_documentmapping
integer x = 2350
integer y = 56
integer width = 329
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add"
end type

event clicked;dw_1.event pfc_addrow( )
end event

type dw_1 from u_dw_documentmapping within u_cst_documentmapping
integer x = 46
integer y = 40
integer width = 2272
integer height = 660
integer taborder = 10
end type

event itemchanged;call super::itemchanged;Parent.Event ue_ItemChanged ( ) 
end event

event pfc_deleterow;call super::pfc_deleterow;Parent.event ue_itemchanged( )
RETURN AncestorReturnValue 
end event

event editchanged;call super::editchanged;Parent.event ue_itemchanged( )

end event

