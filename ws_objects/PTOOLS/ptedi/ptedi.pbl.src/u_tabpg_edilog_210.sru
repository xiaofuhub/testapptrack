$PBExportHeader$u_tabpg_edilog_210.sru
forward
global type u_tabpg_edilog_210 from u_tabpg_edilog
end type
end forward

global type u_tabpg_edilog_210 from u_tabpg_edilog
string text = "210"
end type
global u_tabpg_edilog_210 u_tabpg_edilog_210

on u_tabpg_edilog_210.create
call super::create
end on

on u_tabpg_edilog_210.destroy
call super::destroy
end on

event constructor;call super::constructor;//Extending Ancestor
long	lla_shipid[]

this.of_getshipment(lla_shipid)
IF UpperBound ( lla_shipid ) > 0 THEN
	dw_1.SetTransObject(SQLCA)
	dw_1.retrieve(lla_shipid)
END IF

//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_1
inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
	ldo_Reference.Y + ldo_Reference.Height + li_Border )

//Register resizable controls
This.inv_resize.of_Register ( dw_1, 'ScaleToRight&Bottom' )

//Trigger resize event to perform initial resize of tabpage contents
This.TriggerEvent ( "Resize" )


RETURN AncestorReturnValue
end event

type dw_1 from u_tabpg_edilog`dw_1 within u_tabpg_edilog_210
integer x = 27
integer y = 32
integer width = 3282
integer height = 1500
string dataobject = "d_edilog_210"
end type

