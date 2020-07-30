$PBExportHeader$u_cst_fileselection.sru
forward
global type u_cst_fileselection from u_base
end type
type sle_file from singlelineedit within u_cst_fileselection
end type
type cb_change from commandbutton within u_cst_fileselection
end type
end forward

global type u_cst_fileselection from u_base
int Width=773
int Height=92
event type string ue_changefile ( )
event type string ue_setfilefrompath ( string as_path )
event type integer ue_filechanged ( string as_path )
event ue_slegetfocus ( )
sle_file sle_file
cb_change cb_change
end type
global u_cst_fileselection u_cst_fileselection

type variables
Protected:
String	is_title

end variables

forward prototypes
public function integer of_setenabled (boolean ab_Value)
public function integer of_setfileopentitle (string as_Title)
public function string of_gettext ()
public subroutine of_setprotected (readonly boolean ab_truefalse)
end prototypes

event ue_changefile;String	ls_pathname
String	ls_FileName
String	ls_Title

IF Len ( is_Title ) > 0 THEN
	ls_Title = is_Title
ELSE
	ls_Title = "Select File"
END IF


IF GetFileOpenName ( ls_Title , ls_pathname, ls_filename ) = 1 THEN
	//of_SetAccNoteTemplate ( ls_PathName ) // this sets and formats the presentation 
	//THIS.Event ue_SetAccNoteTemplate ( ls_PathName  ) // this set the value on the company beo
	sle_file.Text = ls_FileName 

//END IF 													// rdt 3-5-03
	THIS.Event ue_FileChanged ( ls_pathname )
ELSE															// rdt 3-5-03
	ls_PATHNAME = ""										// rdt 3-5-03
END IF														// rdt 3-5-03


RETURN ls_pathname
end event

event ue_setfilefrompath;String	ls_File
String	lsa_Result[]

n_cst_String	lnv_String

IF lnv_String.of_ParseToArray ( as_path , "\", lsa_Result ) > 0 THEN
	
	ls_File = lsa_Result [ UpperBound ( lsa_Result ) ]
	sle_file.Text = ls_File
	
END IF



RETURN as_path
end event

public function integer of_setenabled (boolean ab_Value);cb_change.Enabled = ab_Value
sle_file.Enabled = ab_Value
RETURN 1
end function

public function integer of_setfileopentitle (string as_Title);is_Title = as_Title
RETURN 1
end function

public function string of_gettext ();RETURN sle_file.text
end function

public subroutine of_setprotected (readonly boolean ab_truefalse);
If ab_TrueFalse Then 

	sle_file.BackColor = n_cst_constants.cl_color_protected
	sle_file.DisplayOnly = ab_TrueFalse 

Else
	
	sle_file.BackColor = n_cst_constants.cl_color_white
	sle_file.DisplayOnly = ab_TrueFalse 

End IF

end subroutine

on u_cst_fileselection.create
int iCurrent
call super::create
this.sle_file=create sle_file
this.cb_change=create cb_change
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_file
this.Control[iCurrent+2]=this.cb_change
end on

on u_cst_fileselection.destroy
call super::destroy
destroy(this.sle_file)
destroy(this.cb_change)
end on

type sle_file from singlelineedit within u_cst_fileselection
int Width=475
int Height=80
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;Parent.Event ue_SetFileFromPath ( THIS.Text )
Parent.Event ue_FileChanged ( THIS.Text )
end event

event getfocus;Parent.Event ue_SleGetFocus( )
end event

type cb_change from commandbutton within u_cst_fileselection
int X=512
int Width=247
int Height=80
int TabOrder=20
boolean BringToTop=true
string Text="Change"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Event ue_ChangeFile ( )
end event

event getfocus;Parent.Event ue_SleGetFocus( )
end event

