$PBExportHeader$u_tabpg.sru
$PBExportComments$Extension TabPage class
forward
global type u_tabpg from pfc_u_tabpg
end type
end forward

global type u_tabpg from pfc_u_tabpg
integer width = 1975
integer height = 1220
end type
global u_tabpg u_tabpg

type variables
//FOr dynamic use
private PowerObject	ipo_object
end variables

forward prototypes
public function PowerObject of_getobject ()
public function integer of_setreftoobject (ref powerobject apo_object)
end prototypes

public function PowerObject of_getobject ();// the dw or window that is attatched to this tab
return ipo_object
end function

public function integer of_setreftoobject (ref powerobject apo_object);//sets the ipo_object to the datawindow or window it is suppose to pop open or close
Window 			lw_window
DataWindow 		ldw_dw
ipo_object = apo_object

IF typeOf(ipo_object) = dataWindow! THEN
	ldw_dw = ipo_object
	//ldw_dw.visible = false
ELSEIF typeOf(ipo_object) = Window! THEN
	lw_window = ipo_object
	//lw_window.visible = false
END IF
	
return 1
end function

on u_tabpg.create
call super::create
end on

on u_tabpg.destroy
call super::destroy
end on

event dragdrop;call super::dragdrop;u_tab	luo_Tab

IF source.triggerEvent( "ue_isTab") = 1 THEN
	luo_Tab = source
	luo_Tab.Event ue_dropNotify( this )
END IF
end event

