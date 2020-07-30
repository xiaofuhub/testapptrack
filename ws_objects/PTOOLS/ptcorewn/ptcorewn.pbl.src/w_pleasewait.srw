$PBExportHeader$w_pleasewait.srw
forward
global type w_pleasewait from w_popup
end type
type st_1 from statictext within w_pleasewait
end type
type hpb_1 from hprogressbar within w_pleasewait
end type
end forward

global type w_pleasewait from w_popup
integer width = 1349
integer height = 316
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
st_1 st_1
hpb_1 hpb_1
end type
global w_pleasewait w_pleasewait

type variables
Boolean	ib_CLOSE

end variables

forward prototypes
public subroutine of_go ()
public subroutine of_stopandclose ()
end prototypes

public subroutine of_go ();Do 	
	Yield()
	hpb_1.stepit( )
Loop WHILE ib_close = FALSE


CLOSE ( THIS )

end subroutine

public subroutine of_stopandclose ();ib_Close = TRUE


end subroutine

on w_pleasewait.create
int iCurrent
call super::create
this.st_1=create st_1
this.hpb_1=create hpb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.hpb_1
end on

on w_pleasewait.destroy
call super::destroy
destroy(this.st_1)
destroy(this.hpb_1)
end on

event open;call super::open;THIS.of_Setbase( TRUE )
inv_base.of_Center()
Timer ( .5 )

end event

event timer;call super::timer;hpb_1.stepit( )
end event

type st_1 from statictext within w_pleasewait
integer x = 23
integer y = 28
integer width = 430
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please Wait ..."
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_pleasewait
integer x = 18
integer y = 112
integer width = 1271
integer height = 64
unsignedinteger maxposition = 100
integer setstep = 1
end type

