$PBExportHeader$u_cst_companyimagesettings.sru
forward
global type u_cst_companyimagesettings from u_cst_syssettings_imagesettings
end type
type st_3 from statictext within u_cst_companyimagesettings
end type
type cbx_printing from checkbox within u_cst_companyimagesettings
end type
type cbx_warning from checkbox within u_cst_companyimagesettings
end type
type cbx_required from checkbox within u_cst_companyimagesettings
end type
end forward

global type u_cst_companyimagesettings from u_cst_syssettings_imagesettings
st_3 st_3
cbx_printing cbx_printing
cbx_warning cbx_warning
cbx_required cbx_required
end type
global u_cst_companyimagesettings u_cst_companyimagesettings

on u_cst_companyimagesettings.create
int iCurrent
call super::create
this.st_3=create st_3
this.cbx_printing=create cbx_printing
this.cbx_warning=create cbx_warning
this.cbx_required=create cbx_required
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.cbx_printing
this.Control[iCurrent+3]=this.cbx_warning
this.Control[iCurrent+4]=this.cbx_required
end on

on u_cst_companyimagesettings.destroy
call super::destroy
destroy(this.st_3)
destroy(this.cbx_printing)
destroy(this.cbx_warning)
destroy(this.cbx_required)
end on

type dw_imagesettings from u_cst_syssettings_imagesettings`dw_imagesettings within u_cst_companyimagesettings
end type

type st_1 from u_cst_syssettings_imagesettings`st_1 within u_cst_companyimagesettings
end type

type st_3 from statictext within u_cst_companyimagesettings
integer x = 498
integer y = 292
integer width = 704
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "override system settings"
boolean focusrectangle = false
end type

type cbx_printing from checkbox within u_cst_companyimagesettings
integer x = 343
integer y = 292
integer width = 64
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean lefttext = true
end type

event clicked;PARENT.of_SetOverridePrinting ( THIS.Checked )
end event

type cbx_warning from checkbox within u_cst_companyimagesettings
integer x = 224
integer y = 292
integer width = 64
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean lefttext = true
end type

event clicked;PARENT.of_SetOverrideWarning ( THIS.Checked )
end event

type cbx_required from checkbox within u_cst_companyimagesettings
integer x = 105
integer y = 292
integer width = 64
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean lefttext = true
end type

event clicked;PARENT.of_SetOverrideRequired ( THIS.Checked )
end event

