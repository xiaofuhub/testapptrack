$PBExportHeader$u_cst_setting_sle.sru
forward
global type u_cst_setting_sle from u_cst_setting
end type
type sle_value from u_sle within u_cst_setting_sle
end type
end forward

global type u_cst_setting_sle from u_cst_setting
int Height=352
sle_value sle_value
end type
global u_cst_setting_sle u_cst_setting_sle

forward prototypes
private subroutine of_populate ()
end prototypes

private subroutine of_populate ();sle_Value.Text = This.of_GetDisplayValue ( )
end subroutine

on u_cst_setting_sle.create
int iCurrent
call super::create
this.sle_value=create sle_value
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_value
end on

on u_cst_setting_sle.destroy
call super::destroy
destroy(this.sle_value)
end on

type sle_value from u_sle within u_cst_setting_sle
int X=0
int Y=88
int Width=1504
int TabOrder=11
boolean BringToTop=true
boolean AutoHScroll=true
end type

event modified;IF Parent.of_SetValue ( This.Text ) = -1 THEN
	MessageBox ( "Edit Setting", "The value you have entered is invalid." )
END IF
end event

