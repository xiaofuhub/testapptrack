$PBExportHeader$u_tabpg_edilog_214.sru
forward
global type u_tabpg_edilog_214 from u_tabpg_edilog
end type
end forward

global type u_tabpg_edilog_214 from u_tabpg_edilog
string text = "214"
end type
global u_tabpg_edilog_214 u_tabpg_edilog_214

forward prototypes
public subroutine of_refresh ()
end prototypes

public subroutine of_refresh ();long	lla_shipid[]

this.of_getshipment(lla_shipid)

this.SetRedraw(False)
dw_1.retrieve(lla_shipid)
THIS.SetRedraw(True)
end subroutine

on u_tabpg_edilog_214.create
call super::create
end on

on u_tabpg_edilog_214.destroy
call super::destroy
end on

event constructor;call super::constructor;long	lla_shipid[]

this.of_getshipment(lla_shipid)
dw_1.SetTransObject(SQLCA)
if upperbound(lla_shipid) > 0 then
	dw_1.retrieve(lla_shipid)
end if

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

type dw_1 from u_tabpg_edilog`dw_1 within u_tabpg_edilog_214
integer x = 27
integer y = 32
integer width = 3282
integer height = 1500
string dataobject = "d_edilog_214"
end type

event dw_1::constructor;call super::constructor;datawindowchild	ldwc_status, &
						ldwc_reason

THIS.GetChild ( "edistatus_status" , ldwc_status )
ldwc_status.SetTransObject ( SQLCA )
ldwc_status.Retrieve ( )
ldwc_status.SetFilter ( "segmentid = 'AT7' AND referenceid = '01'" )
ldwc_status.Filter ( ) 

THIS.GetChild ( "edistatus_reason" , ldwc_reason )
ldwc_reason.SetTransObject ( SQLCA )
ldwc_reason.Retrieve ( )
ldwc_reason.SetFilter ( "segmentid = 'AT7' AND referenceid = '02'" )
ldwc_reason.Filter ( ) 


end event

