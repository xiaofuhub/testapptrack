$PBExportHeader$w_aliassetup.srw
forward
global type w_aliassetup from w_response
end type
type uo_1 from u_cst_sle_company within w_aliassetup
end type
type st_1 from statictext within w_aliassetup
end type
type rb_clear from radiobutton within w_aliassetup
end type
type rb_default from radiobutton within w_aliassetup
end type
type cb_1 from commandbutton within w_aliassetup
end type
type cb_2 from commandbutton within w_aliassetup
end type
type gb_1 from groupbox within w_aliassetup
end type
end forward

global type w_aliassetup from w_response
integer width = 1221
integer height = 760
string title = "EDI Alias List"
event ue_updatewithref ( )
event ue_clearlist ( )
uo_1 uo_1
st_1 st_1
rb_clear rb_clear
rb_default rb_default
cb_1 cb_1
cb_2 cb_2
gb_1 gb_1
end type
global w_aliassetup w_aliassetup

event ue_updatewithref();Long	ll_CoID

ll_CoID = uo_1.of_getid( )
IF ll_CoID > 0 THEN
	IF gnv_cst_companies.of_Defaultaliaslisttocoref( ll_CoID ) = 1 THEN
		MessageBox ( "Update" , "Alias list was successfully updated." )
		CLOSE ( THIS ) 
	ELSE
		MessageBox ( "Update" , "A problem occurred while attempting to update the alias list." ) 
	END IF
ELSE
	Messagebox ("Update", "Please select the context company.")
END IF
end event

event ue_clearlist();Long	ll_CoID


ll_CoID = uo_1.of_getid( )
IF ll_CoID > 0 THEN
	IF gnv_cst_companies.of_DeleteAliasListforContext ( ll_CoID ) = 1 THEN
		MessageBox ( "Delete List" , "Alias list was successfully modified." )
		CLOSE ( THIS ) 
	ELSE
		MessageBox ( "Delete List" , "A problem occurred while attempting to modify the alias list." ) 
	END IF
ELSE	
	Messagebox ("Delete List", "Please select the context company.")
END IF

end event

on w_aliassetup.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.st_1=create st_1
this.rb_clear=create rb_clear
this.rb_default=create rb_default
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.rb_clear
this.Control[iCurrent+4]=this.rb_default
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.gb_1
end on

on w_aliassetup.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.rb_clear)
destroy(this.rb_default)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_1)
end on

type cb_help from w_response`cb_help within w_aliassetup
end type

type uo_1 from u_cst_sle_company within w_aliassetup
integer x = 82
integer y = 120
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call u_cst_sle_company::destroy
end on

type st_1 from statictext within w_aliassetup
integer x = 82
integer y = 36
integer width = 1010
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Enter the Company the alias list is for"
boolean focusrectangle = false
end type

type rb_clear from radiobutton within w_aliassetup
integer x = 82
integer y = 356
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clear List "
end type

type rb_default from radiobutton within w_aliassetup
integer x = 82
integer y = 272
integer width = 1001
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Default to company reference code"
boolean checked = true
end type

type cb_1 from commandbutton within w_aliassetup
integer x = 146
integer y = 512
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;IF rb_clear.Checked THEN
	PARENT.event ue_clearlist( )
ELSE
	PARENT.event ue_updatewithref( )
END IF
end event

type cb_2 from commandbutton within w_aliassetup
integer x = 631
integer y = 512
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;Close ( Parent ) 
end event

type gb_1 from groupbox within w_aliassetup
integer x = 55
integer y = 224
integer width = 1056
integer height = 224
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

