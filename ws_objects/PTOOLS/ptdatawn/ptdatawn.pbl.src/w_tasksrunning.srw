$PBExportHeader$w_tasksrunning.srw
forward
global type w_tasksrunning from w_popup
end type
type st_5 from statictext within w_tasksrunning
end type
type st_4 from statictext within w_tasksrunning
end type
type st_3 from statictext within w_tasksrunning
end type
type st_2 from statictext within w_tasksrunning
end type
type p_1 from picture within w_tasksrunning
end type
type st_1 from statictext within w_tasksrunning
end type
type cb_2 from commandbutton within w_tasksrunning
end type
type cb_1 from commandbutton within w_tasksrunning
end type
end forward

global type w_tasksrunning from w_popup
integer width = 2299
integer height = 1056
string title = "Profit Tools Task Scheduler"
boolean maxbox = false
boolean resizable = false
long backcolor = 12632256
event ue_kill pbm_syscommand
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
p_1 p_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
end type
global w_tasksrunning w_tasksrunning

type variables

end variables

event ue_kill;Constant ULong USERCLOSE = 61536
Constant ULong MINIMIZE  = 61472
Long	ll_Return

IF CommandType = USERCLOSE OR CommandType =  MINIMIZE THEN
		
		post(Handle(gnv_app.of_GetFrame( ) ), 274, MINIMIZE , 0)

		ll_Return = 1  //Reject Action
END IF

RETURN ll_Return
end event

on w_tasksrunning.create
int iCurrent
call super::create
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.p_1=create p_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_1
end on

on w_tasksrunning.destroy
call super::destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;call super::open;THIS.of_SetBase( True )
inv_Base.of_Center( )
end event

type st_5 from statictext within w_tasksrunning
integer x = 1134
integer y = 528
integer width = 96
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "or"
boolean focusrectangle = false
end type

type st_4 from statictext within w_tasksrunning
integer x = 658
integer y = 592
integer width = 1047
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "NO just to minimize the application."
boolean focusrectangle = false
end type

type st_3 from statictext within w_tasksrunning
integer x = 315
integer y = 464
integer width = 1733
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Select YES to stop the processing and close the application"
boolean focusrectangle = false
end type

type st_2 from statictext within w_tasksrunning
integer x = 457
integer y = 228
integer width = 1655
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Do you want to stop the process?"
boolean focusrectangle = false
end type

type p_1 from picture within w_tasksrunning
integer x = 215
integer y = 160
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "ptoolsicon.bmp"
boolean focusrectangle = false
end type

type st_1 from statictext within w_tasksrunning
integer x = 457
integer y = 160
integer width = 1655
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "This instance of Profit Tools is running scheduled tasks."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_tasksrunning
integer x = 1207
integer y = 776
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "No"
end type

event clicked;Constant ULong MINIMIZE  = 61472
post(Handle(gnv_app.of_GetFrame( ) ), 274, MINIMIZE , 0)
end event

type cb_1 from commandbutton within w_tasksrunning
integer x = 722
integer y = 776
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Yes"
end type

event clicked;gnv_App.event ue_stopeventscheduler( )
//Close ( Parent )  
gnv_App.event pfc_exit( )
end event

