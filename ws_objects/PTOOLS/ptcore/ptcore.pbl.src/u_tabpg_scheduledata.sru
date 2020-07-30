$PBExportHeader$u_tabpg_scheduledata.sru
forward
global type u_tabpg_scheduledata from u_tabpg
end type
type uo_1 from u_cst_schedule within u_tabpg_scheduledata
end type
end forward

global type u_tabpg_scheduledata from u_tabpg
integer width = 1623
integer height = 1140
long backcolor = 12632256
long tabbackcolor = 12632256
uo_1 uo_1
end type
global u_tabpg_scheduledata u_tabpg_scheduledata

forward prototypes
public function integer of_update ()
public function integer of_settabtext (string as_text)
end prototypes

public function integer of_update ();RETURN uo_1.of_Update ( )
end function

public function integer of_settabtext (string as_text);this.Text = as_text
RETURN 1
end function

on u_tabpg_scheduledata.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tabpg_scheduledata.destroy
call super::destroy
destroy(this.uo_1)
end on

event constructor;call super::constructor;IF IsValid (Message.Powerobjectparm ) THEN
	n_cst_ScheduleData	lnv_Data
	//messagebox ( "Valid" , Message.powerobjectparm.classname( ) )
	lnv_Data = Message.powerobjectparm
	uo_1.of_Setscheduledata( lnv_Data )
//	THIS.post of_SetTabText ( lnv_Data.of_GettabPagelabel ( ) )
	THIS.text = lnv_Data.of_GettabPagelabel ( )
//	THIS.setredraw( TRUE )
END IF
end event

type uo_1 from u_cst_schedule within u_tabpg_scheduledata
integer x = 160
integer y = 8
integer taborder = 40
end type

on uo_1.destroy
call u_cst_schedule::destroy
end on

event ue_taskenabled;call super::ue_taskenabled;PARENT.tabtextcolor = RGB ( 0 , 0 , 0 )
end event

event ue_taskdisabled;call super::ue_taskdisabled;PARENT.tabtextcolor = RGB ( 128 , 0 , 0 )
end event

