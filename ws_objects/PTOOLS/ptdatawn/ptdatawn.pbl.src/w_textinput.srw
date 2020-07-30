$PBExportHeader$w_textinput.srw
forward
global type w_textinput from w_response
end type
type mle_1 from multilineedit within w_textinput
end type
type st_1 from statictext within w_textinput
end type
type cb_1 from commandbutton within w_textinput
end type
type cb_2 from commandbutton within w_textinput
end type
end forward

global type w_textinput from w_response
integer x = 214
integer y = 221
integer width = 1129
integer height = 804
boolean controlmenu = false
mle_1 mle_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
end type
global w_textinput w_textinput

forward prototypes
public function integer wf_returntext ()
public function integer wf_cancel ()
end prototypes

public function integer wf_returntext ();n_cst_msg	lnv_Msg
S_Parm		lstr_Parm


lstr_Parm.is_Label = "TEXT" 
lstr_Parm.ia_Value = mle_1.Text
lnv_Msg.of_Add_parm ( lstr_Parm )

CloseWithReturn ( THIS , lnv_Msg )

RETURN 1

end function

public function integer wf_cancel ();n_cst_msg	lnv_Msg
S_Parm		lstr_Parm


lstr_Parm.is_Label = "Continue" 
lstr_Parm.ia_Value = False
lnv_Msg.of_Add_parm ( lstr_Parm )

CloseWithReturn ( THIS , lnv_Msg )

RETURN 1

end function

on w_textinput.create
int iCurrent
call super::create
this.mle_1=create mle_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on w_textinput.destroy
call super::destroy
destroy(this.mle_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;THIS.of_SetBase( TRUE )
inv_Base.of_Center( )
n_Cst_msg	lnv_Msg
S_parm		lstr_Parm

//THIS.X = Pointerx( )
//THIS.y = Pointery ( )

IF isValid ( Message.powerobjectparm ) THEN
	
	lnv_Msg = Message.powerobjectparm
	IF lnv_msg.of_Get_Parm ( "INSTRUCTIONS" , lstr_Parm ) > 0 THEN
		st_1.text = lstr_Parm.ia_Value
	END IF
	
	IF lnv_msg.of_Get_Parm ( "Text" , lstr_Parm ) > 0 THEN
		mle_1.text = lstr_Parm.ia_Value
	END IF
	
	IF lnv_msg.of_Get_Parm ( "Title" , lstr_Parm ) > 0 THEN
		THIS.Title = lstr_Parm.ia_Value
	END IF
	
END IF

end event

type cb_help from w_response`cb_help within w_textinput
integer x = 1010
integer y = 624
end type

type mle_1 from multilineedit within w_textinput
integer x = 46
integer y = 84
integer width = 997
integer height = 400
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "If this needs to be used for another task other than user alerts the Help link will need to be changed (create a descendant)"
borderstyle borderstyle = stylelowered!
end type

event constructor;THIS.Text = ""
end event

type st_1 from statictext within w_textinput
integer x = 46
integer y = 16
integer width = 983
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_textinput
integer x = 123
integer y = 544
integer width = 402
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;Parent.wf_returntext( )
end event

type cb_2 from commandbutton within w_textinput
integer x = 585
integer y = 544
integer width = 402
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;Parent.wf_cancel( )
end event

