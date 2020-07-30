$PBExportHeader$u_cst_noteicon.sru
forward
global type u_cst_noteicon from u_base
end type
type p_emptynote from picture within u_cst_noteicon
end type
type p_full from picture within u_cst_noteicon
end type
end forward

global type u_cst_noteicon from u_base
int Width=82
int Height=72
long BackColor=12632256
event ue_shownotes ( )
p_emptynote p_emptynote
p_full p_full
end type
global u_cst_noteicon u_cst_noteicon

type variables
n_cst_noteManager inv_NoteManager
end variables

forward prototypes
public function integer of_showicons ()
public function integer of_setcontext (pt_n_cst_beo anv_Context, string as_Attribute)
end prototypes

public function integer of_showicons ();IF IsValid ( inv_NoteManager ) THEN
	p_full.Visible = inv_NoteManager.of_HaveNotes ( )
	p_emptynote.Visible = NOT p_full.Visible
END IF

RETURN 1
end function

public function integer of_setcontext (pt_n_cst_beo anv_Context, string as_Attribute);IF isValid ( inv_notemanager ) THEN
	inv_notemanager.of_SetContext( anv_Context , as_Attribute )
	THIS.of_ShowIcons ( )
END IF

RETURN 1
end function

on u_cst_noteicon.create
int iCurrent
call super::create
this.p_emptynote=create p_emptynote
this.p_full=create p_full
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_emptynote
this.Control[iCurrent+2]=this.p_full
end on

on u_cst_noteicon.destroy
call super::destroy
destroy(this.p_emptynote)
destroy(this.p_full)
end on

event constructor;call super::constructor;inv_notemanager = CREATE n_cst_noteManager 

end event

event destructor;call super::destructor;DESTROY ( inv_notemanager )
end event

type p_emptynote from picture within u_cst_noteicon
int Width=73
int Height=56
string PictureName="EmptyNote.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

event clicked;Parent.Event ue_ShowNotes ( )
end event

type p_full from picture within u_cst_noteicon
int Width=73
int Height=56
string PictureName="Fullnote.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

event clicked;Parent.Event ue_ShowNotes ( )
end event

