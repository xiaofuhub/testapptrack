$PBExportHeader$w_pop_progress.srw
$PBExportComments$[w_popup] Popup window to show progress of processing. Progress bar included.
forward
global type w_pop_progress from w_popup
end type
type cb_min from commandbutton within w_pop_progress
end type
type st_status from statictext within w_pop_progress
end type
type uo_progressbar from u_progressbar within w_pop_progress
end type
type st_description from u_st within w_pop_progress
end type
end forward

global type w_pop_progress from w_popup
integer width = 1755
integer height = 560
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
long backcolor = 80269524
event ue_showmessagebox ( string as_title,  string as_message )
event ue_message ( string as_message )
event ue_setfocus ( )
cb_min cb_min
st_status st_status
uo_progressbar uo_progressbar
st_description st_description
end type
global w_pop_progress w_pop_progress

forward prototypes
public subroutine wf_settext (string as_text)
public subroutine wf_showbar (boolean ad_Show)
public function integer wf_setstep (integer ai_step)
public function integer wf_stepit ()
public function integer wf_setmax (integer ai_max)
public function integer wf_settitle (string as_title)
public function integer wf_setstatus (string as_status)
public function integer wf_setminimizeable (boolean ab_switch)
end prototypes

event ue_showmessagebox(string as_title, string as_message);This.WindowState = Normal!
This.SetFocus()
MessageBox(as_Title, as_Message)

end event

event ue_message(string as_message);CHOOSE CASE as_Message
	CASE "DONE"
		CLOSE(THIS)
END CHOOSE
end event

event ue_setfocus();This.WindowState = Normal!
This.SetFocus()
end event

public subroutine wf_settext (string as_text);st_description.Text = as_text
end subroutine

public subroutine wf_showbar (boolean ad_Show);uo_progressbar.Visible = ad_Show
end subroutine

public function integer wf_setstep (integer ai_step);Return uo_progressbar.of_SetStep(ai_step)
end function

public function integer wf_stepit ();Return uo_progressbar.of_increment()
end function

public function integer wf_setmax (integer ai_max);Return uo_progressbar.of_setmaximum( ai_max)
end function

public function integer wf_settitle (string as_title);THIS.Title = as_title
RETURN 1
end function

public function integer wf_setstatus (string as_status);st_status.Text = as_Status
Return 1
end function

public function integer wf_setminimizeable (boolean ab_switch);cb_Min.Visible = ab_Switch

Return 1
end function

on w_pop_progress.create
int iCurrent
call super::create
this.cb_min=create cb_min
this.st_status=create st_status
this.uo_progressbar=create uo_progressbar
this.st_description=create st_description
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_min
this.Control[iCurrent+2]=this.st_status
this.Control[iCurrent+3]=this.uo_progressbar
this.Control[iCurrent+4]=this.st_description
end on

on w_pop_progress.destroy
call super::destroy
destroy(this.cb_min)
destroy(this.st_status)
destroy(this.uo_progressbar)
destroy(this.st_description)
end on

event open;call super::open;THIS.of_SetBase ( TRUE ) 

IF isValid ( inv_Base ) THEN
	inv_Base.of_Center ( )
END IF

uo_ProgressBar.of_SetFillColor(RGB(0, 0, 128))
end event

type cb_min from commandbutton within w_pop_progress
boolean visible = false
integer x = 174
integer y = 332
integer width = 1371
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Minimize and continue working"
end type

event clicked;Parent.WindowState = Minimized!
end event

type st_status from statictext within w_pop_progress
integer x = 32
integer y = 180
integer width = 1646
integer height = 140
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 80263581
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_progressbar from u_progressbar within w_pop_progress
integer x = 183
integer y = 352
integer width = 1349
integer taborder = 10
boolean bringtotop = true
boolean border = true
long backcolor = 80269524
borderstyle borderstyle = stylelowered!
end type

on uo_progressbar.destroy
call u_progressbar::destroy
end on

type st_description from u_st within w_pop_progress
integer x = 37
integer y = 12
integer width = 1641
integer height = 144
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

