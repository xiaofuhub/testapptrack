$PBExportHeader$u_dw_ratedefaults.sru
forward
global type u_dw_ratedefaults from u_dw
end type
end forward

global type u_dw_ratedefaults from u_dw
integer width = 1038
integer height = 208
string dataobject = "d_ratedefaults"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
event ue_clearblankrow ( )
event type integer ue_allowchangefocus ( )
end type
global u_dw_ratedefaults u_dw_ratedefaults

forward prototypes
public subroutine of_enableoverridedescription (boolean ab_value)
end prototypes

public subroutine of_enableoverridedescription (boolean ab_value);if ab_value then
	this.object.overridedescription.protect=1
	this.Object.overridedescription.Background.Color = RGB(192, 192, 192)
else
	this.object.overridedescription.protect=0
	this.Object.overridedescription.Background.Color = RGB(255, 255, 255)
end if

end subroutine

on u_dw_ratedefaults.create
end on

on u_dw_ratedefaults.destroy
end on

