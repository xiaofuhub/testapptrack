$PBExportHeader$u_tabpg_prprties_dynamicobjects_general.sru
forward
global type u_tabpg_prprties_dynamicobjects_general from u_tabpg_prprties_dynamicobjects
end type
type uo_mouseoverthreshhold from u_cst_syssettings_sle within u_tabpg_prprties_dynamicobjects_general
end type
type uo_refreshrate from u_cst_syssettings_sle within u_tabpg_prprties_dynamicobjects_general
end type
end forward

global type u_tabpg_prprties_dynamicobjects_general from u_tabpg_prprties_dynamicobjects
string text = "General"
uo_mouseoverthreshhold uo_mouseoverthreshhold
uo_refreshrate uo_refreshrate
end type
global u_tabpg_prprties_dynamicobjects_general u_tabpg_prprties_dynamicobjects_general

on u_tabpg_prprties_dynamicobjects_general.create
int iCurrent
call super::create
this.uo_mouseoverthreshhold=create uo_mouseoverthreshhold
this.uo_refreshrate=create uo_refreshrate
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_mouseoverthreshhold
this.Control[iCurrent+2]=this.uo_refreshrate
end on

on u_tabpg_prprties_dynamicobjects_general.destroy
call super::destroy
destroy(this.uo_mouseoverthreshhold)
destroy(this.uo_refreshrate)
end on

type uo_mouseoverthreshhold from u_cst_syssettings_sle within u_tabpg_prprties_dynamicobjects_general
integer y = 344
integer width = 1454
integer taborder = 20
end type

on uo_mouseoverthreshhold.destroy
call u_cst_syssettings_sle::destroy
end on

event ue_valuechanged;call super::ue_valuechanged;Int li_Return = 1
String 	ls_dimensions
String	ls_width
String	ls_height

ls_dimensions = Trim(Sle_1.Text)

if len(ls_dimensions) = 0 or isnull(ls_dimensions) then
	//do nothing
	sle_1.text = ""
elseIF POS( ls_dimensions, "," ) > 0 THEN
	//gets everything left of the comma
	ls_width = trim( left( ls_dimensions, pos( ls_dimensions, "," )-1 ) )
	
	//gets everything to the right of the comma
	ls_height = trim( RIGHT( ls_dimensions,( len(ls_dimensions) - pos( ls_dimensions, ","))) )

	IF isNumber( ls_width ) AND isNumber( ls_height ) THEN
		sle_1.text = ls_width+","+ls_height
		//proceed
	ELSE
		Messagebox("Mouseover Threshhold","Please enter the mouseover threshhold in the for width,height.")
		sle_1.text = ""
	END IF
	
ELSE
	MessageBox("Mouseover Threshhold", "Please enter the mouseover threshhold in the for width,height.")
	sle_1.text = ""
end if
end event

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_dynamicobject_mousthresh

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

type uo_refreshrate from u_cst_syssettings_sle within u_tabpg_prprties_dynamicobjects_general
integer y = 36
integer width = 1426
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_dynamicobjectrefresh

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_refreshrate.destroy
call u_cst_syssettings_sle::destroy
end on

event ue_valuechanged;call super::ue_valuechanged;Int li_Return = 1
String ls_time
Long	ll_seconds

ls_time = Trim(Sle_1.Text)

if len(ls_time) = 0 or isnull(ls_time) then
	//do nothing
elseIF isNUmber( ls_time ) THEN
	ll_seconds = LONG( ls_time )
	// The objects using this setting
	// interpret 0 as having no refresh rate.
	IF ll_seconds = 0 THEN
		sle_1.Text = ""
	END IF
ELSE
	IF inv_syssetting.of_ShouldValidate( ) THEN
		IF istime(ls_time) THEN
			//valid
			sle_1.text = String(time(ls_time),"hh:mm")
		ELSE
			Messagebox("Refresh Interval","Please enter the refresh interval in seconds only.")
			Sle_1.SetFocus()
			li_Return = -1
		END IF	
	END IF	
end if
end event

