$PBExportHeader$u_cst_eqtracesetting.sru
$PBExportComments$ZMC
forward
global type u_cst_eqtracesetting from u_cst_syssettings
end type
type cbx_refr from checkbox within u_cst_eqtracesetting
end type
type cbx_tank from checkbox within u_cst_eqtracesetting
end type
type cbx_rbox from checkbox within u_cst_eqtracesetting
end type
type cbx_flbd from checkbox within u_cst_eqtracesetting
end type
type cbx_trlr from checkbox within u_cst_eqtracesetting
end type
type cbx_chas from checkbox within u_cst_eqtracesetting
end type
type cbx_cntn from checkbox within u_cst_eqtracesetting
end type
type gb_1 from groupbox within u_cst_eqtracesetting
end type
end forward

global type u_cst_eqtracesetting from u_cst_syssettings
integer width = 987
integer height = 532
event ue_choicechanged ( )
cbx_refr cbx_refr
cbx_tank cbx_tank
cbx_rbox cbx_rbox
cbx_flbd cbx_flbd
cbx_trlr cbx_trlr
cbx_chas cbx_chas
cbx_cntn cbx_cntn
gb_1 gb_1
end type
global u_cst_eqtracesetting u_cst_eqtracesetting

forward prototypes
public function integer of_enable (boolean ab_enable)
public function integer of_setproperty (n_cst_syssettings anv_setting)
end prototypes

event ue_choicechanged();String	ls_Value

n_cst_EquipmentManager		lnv_EqMgr

IF cbx_chas.Checked THEN
	ls_Value = lnv_EqMgr.cs_chas + ","
END IF

IF cbx_cntn.checked THEN
	ls_Value += lnv_EqMgr.cs_cntn + ","
END IF

IF cbx_flbd.Checked THEN
	ls_Value += lnv_EqMgr.cs_flbd + ","
END IF

IF cbx_rbox.Checked THEN
	ls_Value += lnv_EqMgr.cs_rbox + ","
END IF

IF cbx_refr.Checked THEN
	ls_Value += lnv_EqMgr.cs_refr + ","
END IF
IF cbx_tank.Checked THEN
	ls_Value += lnv_EqMgr.cs_tank + ","
END IF

IF cbx_trlr.Checked THEN
	ls_Value += lnv_EqMgr.cs_trlr + ","
END IF

//remove ending comma
IF Right (ls_Value, 1) = "," THEN
	ls_Value = Left(ls_Value, Len(ls_Value) -1)
END iF

inv_syssetting.of_savevalue( ls_Value )
end event

public function integer of_enable (boolean ab_enable);cbx_cntn.Enabled = ab_enable
cbx_chas.Enabled = ab_enable
cbx_flbd.Enabled = ab_enable
cbx_rbox.Enabled = ab_enable
cbx_refr.Enabled = ab_enable
cbx_tank.Enabled = ab_enable
cbx_trlr.Enabled = ab_enable
Return 1

end function

public function integer of_setproperty (n_cst_syssettings anv_setting);inv_syssetting = anv_setting

Return 1
end function

on u_cst_eqtracesetting.create
int iCurrent
call super::create
this.cbx_refr=create cbx_refr
this.cbx_tank=create cbx_tank
this.cbx_rbox=create cbx_rbox
this.cbx_flbd=create cbx_flbd
this.cbx_trlr=create cbx_trlr
this.cbx_chas=create cbx_chas
this.cbx_cntn=create cbx_cntn
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_refr
this.Control[iCurrent+2]=this.cbx_tank
this.Control[iCurrent+3]=this.cbx_rbox
this.Control[iCurrent+4]=this.cbx_flbd
this.Control[iCurrent+5]=this.cbx_trlr
this.Control[iCurrent+6]=this.cbx_chas
this.Control[iCurrent+7]=this.cbx_cntn
this.Control[iCurrent+8]=this.gb_1
end on

on u_cst_eqtracesetting.destroy
call super::destroy
destroy(this.cbx_refr)
destroy(this.cbx_tank)
destroy(this.cbx_rbox)
destroy(this.cbx_flbd)
destroy(this.cbx_trlr)
destroy(this.cbx_chas)
destroy(this.cbx_cntn)
destroy(this.gb_1)
end on

event ue_setvalue;call super::ue_setvalue;Integer 	li_Return = -1 
Long		i, ll_Count
String 	ls_value
String 	lsa_Values[]

n_cst_String	lnv_String

n_cst_EquipmentManager	lnv_EqMgr

IF IsValid(inv_syssetting) THEN
	ls_value = inv_syssetting.of_getvalue( )
	li_Return = 1 
END IF

IF li_Return = 1 THEN
	lnv_String.of_Parsetoarray( ls_Value, ",", lsa_Values)
	ll_Count = UpperBound(lsa_Values)
	
	FOR i = 1 TO ll_Count
		
		CHOOSE CASE lsa_VALUES[i]
			CASE lnv_EqMgr.cs_cntn
				This.cbx_cntn.Checked = TRUE
			CASE lnv_EqMgr.cs_chas
				This.cbx_chas.Checked = TRUE
			CASE lnv_EqMgr.cs_flbd
				This.cbx_flbd.Checked = TRUE
			CASE lnv_EqMgr.cs_rbox
				This.cbx_rbox.Checked = TRUE
			CASE lnv_EqMgr.cs_refr
				This.cbx_refr.Checked = TRUE
			CASE lnv_EqMgr.cs_tank
				This.cbx_tank.Checked = TRUE
			CASE lnv_EqMgr.cs_trlr
				This.cbx_trlr.Checked = TRUE
		END CHOOSE
			
	NEXT
	
END IF

Return li_Return
end event

type cbx_refr from checkbox within u_cst_eqtracesetting
integer x = 498
integer y = 292
integer width = 402
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Refrs"
end type

event clicked;Event ue_choicechanged( )
end event

type cbx_tank from checkbox within u_cst_eqtracesetting
integer x = 498
integer y = 196
integer width = 402
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tanks"
end type

event clicked;Event ue_choicechanged( )
end event

type cbx_rbox from checkbox within u_cst_eqtracesetting
integer x = 498
integer y = 104
integer width = 402
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Railboxes"
end type

event clicked;Event ue_choicechanged( )
end event

type cbx_flbd from checkbox within u_cst_eqtracesetting
integer x = 96
integer y = 388
integer width = 402
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Flatbeds"
end type

event clicked;Event ue_choicechanged( )
end event

type cbx_trlr from checkbox within u_cst_eqtracesetting
integer x = 96
integer y = 292
integer width = 402
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Trailers"
end type

event clicked;Event ue_choicechanged( )
end event

type cbx_chas from checkbox within u_cst_eqtracesetting
integer x = 96
integer y = 196
integer width = 402
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Chassis"
end type

event clicked;Event ue_choicechanged( )
end event

type cbx_cntn from checkbox within u_cst_eqtracesetting
integer x = 96
integer y = 104
integer width = 402
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Containers"
end type

event clicked;Event ue_choicechanged( )
end event

type gb_1 from groupbox within u_cst_eqtracesetting
integer x = 9
integer y = 4
integer width = 965
integer height = 516
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Outside Equipment to Auto-Trace"
end type

