$PBExportHeader$w_documenttransferhistory.srw
forward
global type w_documenttransferhistory from w_response
end type
type dw_1 from u_dw_documenttransferhistory within w_documenttransferhistory
end type
type cb_1 from commandbutton within w_documenttransferhistory
end type
type st_1 from statictext within w_documenttransferhistory
end type
type st_2 from statictext within w_documenttransferhistory
end type
end forward

global type w_documenttransferhistory from w_response
integer width = 3840
integer height = 2356
string title = "Document Transfer History"
long backcolor = 12632256
dw_1 dw_1
cb_1 cb_1
st_1 st_1
st_2 st_2
end type
global w_documenttransferhistory w_documenttransferhistory

on w_documenttransferhistory.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on w_documenttransferhistory.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;call super::open;
IF gnv_App.of_Getrestrictedview( ) THEN

	THIS.of_SetResize( TRUE )
	inv_REsize.of_Register( dw_1 , inv_Resize.scalerightbottom )
	inv_REsize.of_Register( cb_1 , inv_Resize.fixedbottom )
	THIS.Width -= 500
	THIS.Height -= 200
	cb_1.x -= 250
END IF

THIS.of_SetBase( TRUE )
inv_base.of_Center( )

end event

type cb_help from w_response`cb_help within w_documenttransferhistory
integer y = 1600
end type

type dw_1 from u_dw_documenttransferhistory within w_documenttransferhistory
integer x = 37
integer y = 228
integer width = 3739
integer height = 1828
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;n_cst_Privileges	lnv_Privs
IF lnv_Privs.of_hasadministrativerights( ) THEN
	THIS.of_Setdeleteable( TRUE )
ELSE
	THIS.of_Setdeleteable( FALSE )
END IF
end event

type cb_1 from commandbutton within w_documenttransferhistory
integer x = 1705
integer y = 2108
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Parent.event pfc_close( )
end event

type st_1 from statictext within w_documenttransferhistory
integer x = 41
integer y = 52
integer width = 2962
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "This window can be used to export transfer history and/or delete it from the Database to increase performance."
boolean focusrectangle = false
end type

type st_2 from statictext within w_documenttransferhistory
integer x = 41
integer y = 112
integer width = 2533
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tip: use the right-click menu to filter to a desired result set to then be exported for your records."
boolean focusrectangle = false
end type

