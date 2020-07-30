$PBExportHeader$u_cst_schedule.sru
forward
global type u_cst_schedule from u_base
end type
type mle_remarks from multilineedit within u_cst_schedule
end type
type em_endtime from editmask within u_cst_schedule
end type
type em_starttime from editmask within u_cst_schedule
end type
type st_3 from statictext within u_cst_schedule
end type
type st_2 from statictext within u_cst_schedule
end type
type cbx_friday from checkbox within u_cst_schedule
end type
type cbx_tuesday from checkbox within u_cst_schedule
end type
type cbx_thursday from checkbox within u_cst_schedule
end type
type cbx_monday from checkbox within u_cst_schedule
end type
type cbx_saturday from checkbox within u_cst_schedule
end type
type cbx_wednesday from checkbox within u_cst_schedule
end type
type cbx_sunday from checkbox within u_cst_schedule
end type
type ddlb_units from dropdownlistbox within u_cst_schedule
end type
type st_1 from statictext within u_cst_schedule
end type
type uo_period from u_cst_integerspin within u_cst_schedule
end type
type cbx_enabled from checkbox within u_cst_schedule
end type
type gb_1 from groupbox within u_cst_schedule
end type
type gb_2 from groupbox within u_cst_schedule
end type
end forward

global type u_cst_schedule from u_base
integer width = 1285
integer height = 1088
long backcolor = 12632256
event ue_taskenabled ( )
event ue_taskdisabled ( )
mle_remarks mle_remarks
em_endtime em_endtime
em_starttime em_starttime
st_3 st_3
st_2 st_2
cbx_friday cbx_friday
cbx_tuesday cbx_tuesday
cbx_thursday cbx_thursday
cbx_monday cbx_monday
cbx_saturday cbx_saturday
cbx_wednesday cbx_wednesday
cbx_sunday cbx_sunday
ddlb_units ddlb_units
st_1 st_1
uo_period uo_period
cbx_enabled cbx_enabled
gb_1 gb_1
gb_2 gb_2
end type
global u_cst_schedule u_cst_schedule

type variables
n_cst_ScheduleData	inv_SchedData
end variables

forward prototypes
public function integer of_setscheduledata (n_cst_scheduledata anv_data)
public function integer of_update ()
private function integer of_populatedisplay ()
private function integer of_enable (boolean ab_value)
public function integer of_save ()
public function integer of_updatespending ()
private function integer of_populatescheduledataobject ()
end prototypes

public function integer of_setscheduledata (n_cst_scheduledata anv_data);inv_scheddata = anv_data
THIS.of_populatedisplay( )
RETURN 1
end function

public function integer of_update ();Int	li_Return = 1 


IF isValid ( inv_scheddata ) THEN
	THIS.of_Populatescheduledataobject( )
	IF inv_scheddata.of_Update( ) <> 1 THEN
		li_Return = -1
	END IF
ELSE
	li_Return = -1
END IF

RETURN li_Return
	
	
	



end function

private function integer of_populatedisplay ();Int	li_Return  = 1

IF IsValid ( inv_scheddata ) THEN
	cbx_enabled.checked = inv_scheddata.of_GetEnabled ( )
	
	cbx_sunday.Checked = inv_scheddata.of_GetRunOnDayOfWeek ( 1 )
	cbx_Monday.Checked = inv_scheddata.of_GetRunOnDayOfWeek ( 2 )
	cbx_tuesday.Checked = inv_scheddata.of_GetRunOnDayOfWeek ( 3 )
	cbx_Wednesday.Checked = inv_scheddata.of_GetRunOnDayOfWeek ( 4 )
	cbx_Thursday.Checked = inv_scheddata.of_GetRunOnDayOfWeek ( 5 )
	cbx_Friday.Checked = inv_scheddata.of_GetRunOnDayOfWeek ( 6 )
	cbx_Saturday.Checked = inv_scheddata.of_GetRunOnDayOfWeek ( 7 )

	uo_period.of_setvalue( inv_scheddata.of_GetPeriod( ) )
	em_starttime.Text = String ( inv_scheddata.of_GetStartTime ( )  )
	em_Endtime.Text = String ( inv_scheddata.of_GetEndTime ( )) 

	ddlb_units.Selectitem( inv_scheddata.of_GetPeriodUnits ( ) ,0 )
	mle_Remarks.Text = inv_scheddata.of_gettaskdescription( )
	THIS.of_Enable(cbx_enabled.checked )
ELSE
	li_Return = -1

END IF

RETURN li_Return
	


end function

private function integer of_enable (boolean ab_value);
cbx_sunday.Enabled = ab_value 
cbx_Monday.Enabled = ab_value 
cbx_tuesday.Enabled = ab_value 
cbx_Wednesday.Enabled = ab_value 
cbx_Thursday.Enabled = ab_value 
cbx_Friday.Enabled = ab_value 
cbx_Saturday.Enabled = ab_value 

uo_period.of_Enable ( ab_value  )
em_starttime.Enabled = ab_value 
em_Endtime.Enabled = ab_value 

ddlb_units.Enabled = ab_value 

IF ab_value THEN
	THIS.event ue_taskenabled( )
ELSE
	THIS.event ue_taskdisabled( )
END IF

RETURN 1
end function

public function integer of_save ();MessageBox ("A" , "A"  )
RETURN 1
end function

public function integer of_updatespending ();String	ls_Original
String	ls_Current
Int		li_Return
Boolean	lb_UpdatesPending

THIS.of_populatescheduledataobject ( )

ls_Original = inv_scheddata.of_GetOriginalsql( )
ls_Current = inv_scheddata.of_Buildschedulesql( )

lb_UpdatesPending = ( isNull ( ls_Original ) AND Not isNull ( ls_Current ) ) OR ( ls_Current <> ls_Original ) 

IF lb_UpdatesPending THEN
	li_Return = 1 
END IF

RETURN li_Return
end function

private function integer of_populatescheduledataobject ();Time	lt_Value
	
inv_scheddata.of_Setenabled( cbx_enabled.checked )

inv_Scheddata.of_SetRunondayofweek( 1 , cbx_sunday.Checked )
inv_Scheddata.of_SetRunondayofweek( 2 , cbx_Monday.Checked   )
inv_Scheddata.of_SetRunondayofweek( 3 , cbx_tuesday.Checked )
inv_Scheddata.of_SetRunondayofweek( 4 , cbx_Wednesday.checked )
inv_Scheddata.of_SetRunondayofweek( 5 , cbx_Thursday.Checked )
inv_Scheddata.of_SetRunondayofweek( 6 , cbx_Friday.Checked  )
inv_Scheddata.of_SetRunondayofweek( 7 , cbx_Saturday.Checked  )

inv_scheddata.of_SetPeriod( uo_period.of_getvalue( ) )

em_starttime.getdata( lt_Value )
inv_scheddata.of_Setstarttime( lt_Value )

em_endtime.GetData( lt_Value )
inv_scheddata.of_Setendtime( lt_Value )

inv_Scheddata.of_setperiodunits( ddlb_units.Text )

RETURN 1
end function

on u_cst_schedule.create
int iCurrent
call super::create
this.mle_remarks=create mle_remarks
this.em_endtime=create em_endtime
this.em_starttime=create em_starttime
this.st_3=create st_3
this.st_2=create st_2
this.cbx_friday=create cbx_friday
this.cbx_tuesday=create cbx_tuesday
this.cbx_thursday=create cbx_thursday
this.cbx_monday=create cbx_monday
this.cbx_saturday=create cbx_saturday
this.cbx_wednesday=create cbx_wednesday
this.cbx_sunday=create cbx_sunday
this.ddlb_units=create ddlb_units
this.st_1=create st_1
this.uo_period=create uo_period
this.cbx_enabled=create cbx_enabled
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_remarks
this.Control[iCurrent+2]=this.em_endtime
this.Control[iCurrent+3]=this.em_starttime
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cbx_friday
this.Control[iCurrent+7]=this.cbx_tuesday
this.Control[iCurrent+8]=this.cbx_thursday
this.Control[iCurrent+9]=this.cbx_monday
this.Control[iCurrent+10]=this.cbx_saturday
this.Control[iCurrent+11]=this.cbx_wednesday
this.Control[iCurrent+12]=this.cbx_sunday
this.Control[iCurrent+13]=this.ddlb_units
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.uo_period
this.Control[iCurrent+16]=this.cbx_enabled
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.gb_2
end on

on u_cst_schedule.destroy
call super::destroy
destroy(this.mle_remarks)
destroy(this.em_endtime)
destroy(this.em_starttime)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cbx_friday)
destroy(this.cbx_tuesday)
destroy(this.cbx_thursday)
destroy(this.cbx_monday)
destroy(this.cbx_saturday)
destroy(this.cbx_wednesday)
destroy(this.cbx_sunday)
destroy(this.ddlb_units)
destroy(this.st_1)
destroy(this.uo_period)
destroy(this.cbx_enabled)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type mle_remarks from multilineedit within u_cst_schedule
integer x = 41
integer y = 48
integer width = 1207
integer height = 164
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean border = false
boolean displayonly = true
end type

type em_endtime from editmask within u_cst_schedule
integer x = 754
integer y = 544
integer width = 256
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = timemask!
string mask = "hh:mm am/pm"
end type

type em_starttime from editmask within u_cst_schedule
integer x = 329
integer y = 544
integer width = 256
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "12"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = timemask!
string mask = "hh:mm am/pm"
end type

type st_3 from statictext within u_cst_schedule
integer x = 626
integer y = 552
integer width = 101
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "And"
boolean focusrectangle = false
end type

type st_2 from statictext within u_cst_schedule
integer x = 73
integer y = 552
integer width = 215
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Between"
boolean focusrectangle = false
end type

type cbx_friday from checkbox within u_cst_schedule
integer x = 878
integer y = 812
integer width = 279
integer height = 80
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Friday"
end type

type cbx_tuesday from checkbox within u_cst_schedule
integer x = 878
integer y = 728
integer width = 279
integer height = 80
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tuesday"
end type

type cbx_thursday from checkbox within u_cst_schedule
integer x = 544
integer y = 812
integer width = 311
integer height = 80
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Thursday"
end type

type cbx_monday from checkbox within u_cst_schedule
integer x = 544
integer y = 728
integer width = 311
integer height = 80
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Monday"
end type

type cbx_saturday from checkbox within u_cst_schedule
integer x = 146
integer y = 896
integer width = 370
integer height = 80
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Saturday"
end type

type cbx_wednesday from checkbox within u_cst_schedule
integer x = 146
integer y = 812
integer width = 370
integer height = 80
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Wednesday"
end type

type cbx_sunday from checkbox within u_cst_schedule
integer x = 146
integer y = 728
integer width = 370
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Sunday"
end type

type ddlb_units from dropdownlistbox within u_cst_schedule
integer x = 658
integer y = 364
integer width = 352
integer height = 400
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
string item[] = {"hours","minutes","seconds"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within u_cst_schedule
integer x = 73
integer y = 380
integer width = 329
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Repeat every"
boolean focusrectangle = false
end type

type uo_period from u_cst_integerspin within u_cst_schedule
integer x = 411
integer y = 364
integer width = 206
integer height = 88
integer taborder = 20
end type

on uo_period.destroy
call u_cst_integerspin::destroy
end on

event constructor;call super::constructor;Long	ll_Null	
SetNull ( ll_Null )
THIS.of_setbounds( 1, 999, ll_Null )
end event

type cbx_enabled from checkbox within u_cst_schedule
integer x = 55
integer y = 224
integer width = 261
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Enable"
end type

event clicked;Parent.of_Enable ( this.Checked )
end event

type gb_1 from groupbox within u_cst_schedule
integer x = 73
integer y = 660
integer width = 1138
integer height = 360
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within u_cst_schedule
integer x = 9
integer y = 244
integer width = 1257
integer height = 816
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "             "
borderstyle borderstyle = styleraised!
end type

