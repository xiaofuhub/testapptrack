$PBExportHeader$u_dw_admintool.sru
forward
global type u_dw_admintool from u_dw
end type
end forward

global type u_dw_admintool from u_dw
integer width = 526
integer height = 348
boolean titlebar = true
string title = "User Mode"
string dataobject = "d_adminmodetool"
boolean vscrollbar = false
string icon = "AppIcon!"
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
event ue_getadminmode ( )
event ue_setadminmode ( boolean ab_mode )
end type
global u_dw_admintool u_dw_admintool

event ue_getadminmode();w_sheet_dynamiccontrol lw_Dynamic
w_Master		lw_Win
Boolean		lb_AdminMode

IF isValid(This.GetParent()) THEN
	lw_Win = This.GetParent()
	IF lw_Win.ClassName() = "w_sheet_dynamiccontrol" THEN
		lw_Dynamic = lw_Win
		lb_AdminMode = lw_Dynamic.of_GetAdminMode()
	ELSEIF isValid(lw_Win.ParentWindow()) THEN
		IF lw_Win.ParentWindow().ClassName() = "w_sheet_dynamiccontrol" THEN
			lw_Dynamic = lw_Win.ParentWindow()
			lb_AdminMode = lw_Dynamic.of_GetAdminMode()
		ELSE
			This.Object.Mode.Visible = FALSE
		END IF
	ELSE
		This.Object.Mode.Visible = FALSE		
	END IF
ELSE //No Parent
	This.Object.Mode.Visible = FALSE
END IF

IF lb_AdminMode THEN
	This.SetItem(1, "mode", 1)
ELSE
	This.SetItem(1, "mode", 0)
END IF
end event

event ue_setadminmode(boolean ab_mode);w_sheet_dynamiccontrol lw_Dynamic
w_Master		lw_Win
Boolean		lb_AdminMode

IF isValid(This.GetParent()) THEN
	lw_Win = This.GetParent()
	IF lw_Win.ClassName() = "w_sheet_dynamiccontrol" THEN
		lw_Dynamic = lw_Win
		lw_Dynamic.of_SetAdminMode(ab_Mode)
	ELSEIF isValid(lw_Win.ParentWindow()) THEN
		IF lw_Win.ParentWindow().ClassName() = "w_sheet_dynamiccontrol" THEN
			lw_Dynamic = lw_Win.ParentWindow()
			lw_Dynamic.of_SetAdminMode(ab_mode)
		END IF	
	END IF
END IF
end event

on u_dw_admintool.create
end on

on u_dw_admintool.destroy
end on

event constructor;call super::constructor;This.InsertRow(1)
This.Event ue_GetAdminMode()


end event

event itemchanged;call super::itemchanged;IF dwo.Name = "mode" THEN
	IF data = "0" THEN
		This.Event ue_SetAdminMode(FALSE)
	ELSEIF data = "1" THEN
		This.Event ue_SetAdminMode(TRUE)
	END IF
END IF
end event

