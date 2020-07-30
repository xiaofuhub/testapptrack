$PBExportHeader$u_cst_invoicemapping.sru
forward
global type u_cst_invoicemapping from u_base
end type
type st_namingschema from statictext within u_cst_invoicemapping
end type
type cb_delete from commandbutton within u_cst_invoicemapping
end type
type cb_add from commandbutton within u_cst_invoicemapping
end type
type sle_fileschema from singlelineedit within u_cst_invoicemapping
end type
type dw_1 from u_dw_invoicemapping within u_cst_invoicemapping
end type
end forward

global type u_cst_invoicemapping from u_base
integer width = 2002
long backcolor = 12632256
event ue_itemchanged ( )
event ue_preupdate ( )
event ue_toggleemailinvoice ( boolean ab_switch )
event ue_postsave ( )
st_namingschema st_namingschema
cb_delete cb_delete
cb_add cb_add
sle_fileschema sle_fileschema
dw_1 dw_1
end type
global u_cst_invoicemapping u_cst_invoicemapping

forward prototypes
public function integer of_retrieve (long al_coid)
end prototypes

event ue_preupdate();dw_1.event ue_preUpdate( )
end event

event ue_toggleemailinvoice(boolean ab_switch);sle_fileschema.Enabled = ab_Switch
cb_add.Enabled = ab_Switch
cb_Delete.Enabled = ab_Switch
dw_1.Event ue_ToggleEmailInvoice(ab_Switch)
end event

event ue_postsave();dw_1.Event ue_PostSave()
end event

public function integer of_retrieve (long al_coid);Integer	li_Return
String	ls_Schema

li_Return = dw_1.of_Retrieve ( al_coid )

IF li_Return > 0 THEN
	ls_Schema = dw_1.GetItemString(1, "namingschema")
	sle_fileschema.Text = ls_Schema
END IF

Return li_Return
end function

on u_cst_invoicemapping.create
int iCurrent
call super::create
this.st_namingschema=create st_namingschema
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.sle_fileschema=create sle_fileschema
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_namingschema
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.sle_fileschema
this.Control[iCurrent+5]=this.dw_1
end on

on u_cst_invoicemapping.destroy
call super::destroy
destroy(this.st_namingschema)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.sle_fileschema)
destroy(this.dw_1)
end on

type st_namingschema from statictext within u_cst_invoicemapping
integer x = 338
integer y = 640
integer width = 553
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "File Naming Schema:"
boolean focusrectangle = false
end type

type cb_delete from commandbutton within u_cst_invoicemapping
integer x = 1627
integer y = 212
integer width = 343
integer height = 100
integer taborder = 12
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;dw_1.event pfc_deleterow( )
end event

type cb_add from commandbutton within u_cst_invoicemapping
integer x = 1627
integer y = 88
integer width = 343
integer height = 100
integer taborder = 11
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add"
end type

event clicked;dw_1.event pfc_addrow( )
end event

type sle_fileschema from singlelineedit within u_cst_invoicemapping
integer x = 905
integer y = 628
integer width = 699
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;Parent.event ue_itemchanged( )

Dw_1.of_SetSchema(This.Text)


end event

type dw_1 from u_dw_invoicemapping within u_cst_invoicemapping
integer x = 50
integer y = 64
integer width = 1536
integer height = 464
integer taborder = 10
end type

event itemchanged;call super::itemchanged;Parent.event ue_itemchanged( )
end event

event editchanged;call super::editchanged;Parent.event ue_itemchanged( )
end event

event ue_preupdate;call super::ue_preupdate;String	ls_Schema

ls_Schema = Parent.sle_fileschema.Text

This.of_SetSchema(ls_Schema)
end event

event pfc_deleterow;call super::pfc_deleterow;Parent.Event ue_ItemChanged( )
RETURN AncestorReturnValue 
end event

