$PBExportHeader$w_scheduleedit.srw
forward
global type w_scheduleedit from w_response
end type
type uo_1 from u_cst_schedule within w_scheduleedit
end type
type cb_1 from commandbutton within w_scheduleedit
end type
type cb_2 from commandbutton within w_scheduleedit
end type
end forward

global type w_scheduleedit from w_response
integer width = 1349
integer height = 1360
string title = "Edit Schedule"
long backcolor = 12632256
uo_1 uo_1
cb_1 cb_1
cb_2 cb_2
end type
global w_scheduleedit w_scheduleedit

type variables
n_Cst_scheduleData	inv_Data

end variables

on w_scheduleedit.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_scheduleedit.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;THIS.of_Setbase( TRUE )
THIS.inv_base.of_center( )

IF IsValid ( Message.Powerobjectparm ) THEN
	inv_data = Message.Powerobjectparm
END IF

IF IsValid ( inv_data ) THEN
	uo_1.of_setscheduledata ( inv_data )
	
END IF

THIS.of_Setupdateobjects( {uo_1})
end event

event pfc_save;call super::pfc_save;IF uo_1.of_update( ) <> 1 THEN
	MessageBox ( "Save Changes" , "An error occurred while attempting to save your changes." ) 
END IF
RETURN 1
end event

type cb_help from w_response`cb_help within w_scheduleedit
integer x = 1243
integer y = 1208
end type

type uo_1 from u_cst_schedule within w_scheduleedit
integer x = 32
integer y = 28
integer width = 1266
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call u_cst_schedule::destroy
end on

type cb_1 from commandbutton within w_scheduleedit
integer x = 302
integer y = 1124
integer width = 343
integer height = 100
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

event clicked;CLOSE ( PARENT ) 

end event

type cb_2 from commandbutton within w_scheduleedit
integer x = 699
integer y = 1124
integer width = 343
integer height = 100
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

event clicked;PARENT.event pfc_cancel( )
PArent.event pfc_close( )
end event

