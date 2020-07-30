$PBExportHeader$w_resolvedate.srw
forward
global type w_resolvedate from w_response
end type
type cb_date1 from commandbutton within w_resolvedate
end type
type cb_date2 from commandbutton within w_resolvedate
end type
end forward

global type w_resolvedate from w_response
integer x = 214
integer y = 221
integer width = 462
integer height = 360
string title = "Select the date"
boolean controlmenu = false
cb_date1 cb_date1
cb_date2 cb_date2
end type
global w_resolvedate w_resolvedate

forward prototypes
public subroutine wf_returndate (string as_return)
end prototypes

public subroutine wf_returndate (string as_return);

CloseWithReturn ( THIS, as_Return )


end subroutine

event open;call super::open;THIS.x = Pointerx( ) + 200
THIS.y = Pointery( )

n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm


lnv_Msg = Message.PowerobjectParm
IF lnv_Msg.of_Get_Parm ( "Date1" , lstr_Parm ) <> 0 THEN
	cb_date1.Text = String( lstr_Parm.ia_value )
END IF

IF lnv_Msg.of_Get_Parm ( "Date2" , lstr_Parm ) <> 0 THEN
	cb_date2.Text = String( lstr_Parm.ia_value )
END IF


end event

on w_resolvedate.create
int iCurrent
call super::create
this.cb_date1=create cb_date1
this.cb_date2=create cb_date2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_date1
this.Control[iCurrent+2]=this.cb_date2
end on

on w_resolvedate.destroy
call super::destroy
destroy(this.cb_date1)
destroy(this.cb_date2)
end on

type cb_help from w_response`cb_help within w_resolvedate
boolean visible = false
end type

type cb_date1 from commandbutton within w_resolvedate
integer x = 27
integer y = 16
integer width = 375
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
boolean default = true
end type

event clicked;PARENT.wf_returndate( THIS.Text )
end event

type cb_date2 from commandbutton within w_resolvedate
integer x = 32
integer y = 148
integer width = 375
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;PARENT.wf_returndate( THIS.Text )
end event

