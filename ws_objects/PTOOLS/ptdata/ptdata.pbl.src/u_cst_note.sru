$PBExportHeader$u_cst_note.sru
forward
global type u_cst_note from u_base
end type
type mle_note from multilineedit within u_cst_note
end type
type cb_add from commandbutton within u_cst_note
end type
type uo_noteicon from u_cst_noteicon within u_cst_note
end type
end forward

global type u_cst_note from u_base
integer width = 1143
integer height = 316
long backcolor = 12632256
event ue_shownotes ( )
event ue_notemodified ( )
mle_note mle_note
cb_add cb_add
uo_noteicon uo_noteicon
end type
global u_cst_note u_cst_note

type variables
n_cst_noteManager inv_NoteManager
end variables

forward prototypes
public function integer of_setcontext (pt_n_cst_beo anv_context, string as_attribute)
public function integer of_setdimensions (long al_width, long al_height)
public function integer of_setposition (long al_x, long al_y)
public subroutine of_showicons ()
public function integer of_setenabled (boolean ab_value)
end prototypes

public function integer of_setcontext (pt_n_cst_beo anv_context, string as_attribute);Int	li_Return = -1

IF inv_NoteManager.of_SetContext ( anv_Context , as_Attribute ) = 1 THEN
	li_Return = 1
END IF

uo_noteicon.of_SetContext ( anv_Context , as_Attribute ) 


RETURN li_Return 

end function

public function integer of_setdimensions (long al_width, long al_height);THIS.Width = al_width 
THIS.Height = al_Height 

mle_note.Width = al_width - ( cb_add.Width + 10 )
mle_note.Height = al_Height

uo_noteicon.x = uo_noteicon.x + al_width - ( cb_add.Width + 10 )

cb_add.y = mle_note.y + al_Height - cb_add.Height
cb_add.x = cb_add.x + al_width - ( cb_add.Width + 10 )

RETURN 1

end function

public function integer of_setposition (long al_x, long al_y);THIS.x = al_X 
THIS.Y = al_Y 

RETURN  1
end function

public subroutine of_showicons ();uo_noteicon.of_ShowIcons ( ) 
end subroutine

public function integer of_setenabled (boolean ab_value);IF NOT ab_value THEN
	//mle_note.c
	mle_note.backcolor = 12648447 //, 16777215
END IF

mle_note.displayonly = Not ab_value
cb_add.Enabled = ab_value

RETURN 1
end function

on u_cst_note.create
int iCurrent
call super::create
this.mle_note=create mle_note
this.cb_add=create cb_add
this.uo_noteicon=create uo_noteicon
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_note
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.uo_noteicon
end on

on u_cst_note.destroy
call super::destroy
destroy(this.mle_note)
destroy(this.cb_add)
destroy(this.uo_noteicon)
end on

event constructor;call super::constructor;inv_NoteManager = CREATE n_cst_NoteManager

end event

event destructor;call super::destructor;DESTROY inv_NoteManager
end event

type mle_note from multilineedit within u_cst_note
integer width = 969
integer height = 292
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autovscroll = true
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type cb_add from commandbutton within u_cst_note
integer x = 9
integer y = 216
integer width = 128
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add"
end type

event clicked;IF Len ( Trim ( mle_note.Text ) ) > 0 THEN
	IF inv_NoteManager.of_AddNote ( mle_note.Text ) = 1 THEN
		mle_note.Text = ""
	ELSE
		Beep ( 1 )
		mle_note.SelectText (1, Len ( mle_note.Text ) )
		mle_note.SetFocus ( ) 
	END IF
END IF

Parent.Event ue_NoteModified ( )
end event

type uo_noteicon from u_cst_noteicon within u_cst_note
integer x = 14
integer height = 56
integer taborder = 30
boolean bringtotop = true
end type

event ue_shownotes;Parent.Event ue_ShowNotes ( )
end event

on uo_noteicon.destroy
call u_cst_noteicon::destroy
end on

