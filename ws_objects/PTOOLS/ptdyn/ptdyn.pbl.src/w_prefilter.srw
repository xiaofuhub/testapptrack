$PBExportHeader$w_prefilter.srw
forward
global type w_prefilter from w_response
end type
type cb_ok from commandbutton within w_prefilter
end type
type st_prefilter from statictext within w_prefilter
end type
type mle_prefilter from multilineedit within w_prefilter
end type
type st_note from statictext within w_prefilter
end type
end forward

global type w_prefilter from w_response
integer width = 1637
integer height = 1272
long backcolor = 12632256
cb_ok cb_ok
st_prefilter st_prefilter
mle_prefilter mle_prefilter
st_note st_note
end type
global w_prefilter w_prefilter

type variables
s_parm 	istr_Parm
end variables

event open;call super::open;s_parm	lstr_Parm
String	ls_PreFilterType
String	ls_PreFilter

IF isValid(Message.PowerObjectParm) THEN
	istr_Parm = Message.PowerObjectParm
	
	ls_PreFilterType = istr_Parm.is_label
	ls_PreFilter = istr_Parm.ia_Value
	
	IF ls_PreFilterType = "Definition" THEN
		This.Title = "Definition PreFilter"
		This.st_prefilter.Text = "Definition PreFilter"
		This.mle_PreFilter.Text = ls_PreFilter
	ELSEIF ls_PreFilterType = "Unique" THEN
		This.Title = "Unique PreFilter"
		This.st_prefilter.Text = "Unique PreFilter"
		This.mle_PreFilter.Text = ls_PreFilter
	END IF
	
END IF

// Center window
This.of_SetBase(TRUE) 
This.inv_Base.Of_Center()
end event

on w_prefilter.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.st_prefilter=create st_prefilter
this.mle_prefilter=create mle_prefilter
this.st_note=create st_note
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.st_prefilter
this.Control[iCurrent+3]=this.mle_prefilter
this.Control[iCurrent+4]=this.st_note
end on

on w_prefilter.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.st_prefilter)
destroy(this.mle_prefilter)
destroy(this.st_note)
end on

type cb_help from w_response`cb_help within w_prefilter
boolean visible = false
end type

type cb_ok from commandbutton within w_prefilter
integer x = 585
integer y = 1032
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;String	ls_NewPreFilter
Integer	li_Valid
w_dwproperties 	lw_Parent

lw_Parent = Parent.ParentWindow()
ls_NewPreFilter = Parent.mle_prefilter.Text

li_Valid = lw_Parent.of_ValidateExpression(ls_NewPreFilter)
IF li_Valid = 1 THEN
	IF istr_Parm.is_Label = "Definition" THEN
		lw_Parent.tab_dwproperties.tabpage_general.dw_generalproperties.event ue_updateprefilter( ls_NewPreFilter, 0)
		Close(w_prefilter)
	ELSEIF istr_Parm.is_Label = "Unique" THEN
		lw_Parent.tab_dwproperties.tabpage_general.dw_generalproperties.event ue_updateprefilter( ls_NewPreFilter, 1)
		Close(w_prefilter)
	END IF
ELSE
	//Filter Invalid
END IF

end event

type st_prefilter from statictext within w_prefilter
integer x = 78
integer y = 44
integer width = 832
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type mle_prefilter from multilineedit within w_prefilter
integer x = 69
integer y = 148
integer width = 1486
integer height = 696
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type st_note from statictext within w_prefilter
integer x = 329
integer y = 884
integer width = 928
integer height = 136
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Note:Prefilter settings will automatically be saved when the apply button is clicked."
boolean focusrectangle = false
end type

