$PBExportHeader$w_itin_select.srw
$PBExportComments$PTDISP.     Itinerary selection window.
forward
global type w_itin_select from w_response
end type
type st_relativedate from statictext within w_itin_select
end type
type rb_trip from radiobutton within w_itin_select
end type
type cbx_active from checkbox within w_itin_select
end type
type rb_shipment from radiobutton within w_itin_select
end type
type ddlb_select from dropdownlistbox within w_itin_select
end type
type vsb_date from vscrollbar within w_itin_select
end type
type st_date_label from statictext within w_itin_select
end type
type sle_date from singlelineedit within w_itin_select
end type
type rb_container from radiobutton within w_itin_select
end type
type cb_cancel from commandbutton within w_itin_select
end type
type cb_select from commandbutton within w_itin_select
end type
type cb_list from commandbutton within w_itin_select
end type
type rb_trailerchassis from radiobutton within w_itin_select
end type
type rb_powerunit from radiobutton within w_itin_select
end type
type rb_driver from radiobutton within w_itin_select
end type
type gb_selection from groupbox within w_itin_select
end type
type gb_type from groupbox within w_itin_select
end type
type dw_reflist from u_dw_reflist within w_itin_select
end type
type dw_equipment from u_dw_eqlist within w_itin_select
end type
end forward

global type w_itin_select from w_response
integer x = 832
integer y = 576
integer width = 1906
integer height = 736
string title = "Itinerary / Shipment Selection"
boolean controlmenu = false
long backcolor = 12632256
event ue_processrequest ( )
event ue_enablecancel ( )
st_relativedate st_relativedate
rb_trip rb_trip
cbx_active cbx_active
rb_shipment rb_shipment
ddlb_select ddlb_select
vsb_date vsb_date
st_date_label st_date_label
sle_date sle_date
rb_container rb_container
cb_cancel cb_cancel
cb_select cb_select
cb_list cb_list
rb_trailerchassis rb_trailerchassis
rb_powerunit rb_powerunit
rb_driver rb_driver
gb_selection gb_selection
gb_type gb_type
dw_reflist dw_reflist
dw_equipment dw_equipment
end type
global w_itin_select w_itin_select

type variables
protected:
integer sel_type
long sel_id, calling_shipment
boolean force_change, routed_only = true
string action
date sel_date
s_emp_info drivers[]
s_eq_info tractors[], trailers[], containers[]
datastore ds_emp, ds_equip
Long	ila_ShipmentIds[]
Long	ila_TripIds[]
end variables

forward prototypes
protected subroutine type_response (integer ai_type)
private function integer wf_setdateselection (date ad_selection)
end prototypes

event ue_processrequest;
date ld_out, ld_in, ld_work
String						ls_Selection

n_cst_AppServices			lnv_AppServices
n_cst_numerical 			lnv_numerical
n_cst_EquipmentManager 	lnv_EquipmentMgr
n_cst_msg					lnv_Msg
S_Parm						lstr_Parm
s_anys 						disp_parms


ls_Selection = upper(trim(ddlb_select.text))

if lnv_numerical.of_IsNullOrNotPos(sel_id) then

	CHOOSE CASE sel_type

	CASE gc_Dispatch.ci_ItinType_Shipment

		long sel_ship
		string new_shipnum, sel_dorb

		if match(ls_Selection, "^[0-9]+-TMP$") then ls_Selection = left(ls_Selection, len(ls_Selection) - 4)

		if IsNumber ( ls_Selection ) then

			sel_ship = Long ( ls_Selection )

			select ds_pronum, ds_dorb into :new_shipnum, :sel_dorb from disp_ship
				where ds_id = :sel_ship ;

		elseif left(ls_Selection, 1) = "/" and len(ls_Selection) > 1 then

			new_shipnum = right(ls_Selection, len(ls_Selection) - 1)
			select ds_id, ds_dorb into :sel_ship, :sel_dorb from disp_ship
				where ds_pronum = :new_shipnum ;
		else
			goto failure

		end if

		choose case sqlca.sqlcode
			case 0
				commit ;
			case 100
				commit ;
				goto failure
			case else
				rollback ;
				goto failure
		end choose

		if sel_dorb = "T" then
			sel_dorb = sel_dorb

		elseif routed_only then

			messagebox("Select Shipment", "When opening an additional shipment, only "+&
				"routed dispatch shipments may be selected.  Non-routed dispatch and "+&
				"and brokerage shipments must be opened by themselves, in their own "+&
				"window.~n~nRequest cancelled.", exclamation!)
			ddlb_select.setfocus()
			return

		end if

		sel_id = sel_ship

	CASE gc_Dispatch.ci_ItinType_Trip

		SetNull ( sel_date )

		IF IsNumber ( ls_Selection ) THEN
			sel_id = Long ( ls_Selection )
		ELSE
			GOTO Failure
		END IF

	CASE gc_Dispatch.ci_ItinType_Driver

		s_emp_info find_ems

		if gf_emp_info(null_ds, upper(ddlb_select.text), "2", find_ems) > 0 then
			sel_id = find_ems.em_id
		end if

	CASE 	gc_Dispatch.ci_ItinType_PowerUnit, &
			gc_Dispatch.ci_ItinType_TrailerChassis, &
			gc_Dispatch.ci_ItinType_Container

		s_eq_info lstr_equip

		if lnv_EquipmentMgr.of_select(lstr_equip, upper(ddlb_select.text), string(sel_type), &
			cbx_active.checked) = 1 then

			if lstr_equip.eq_id > 0 then

				sel_id = lstr_equip.eq_id
				ddlb_select.text = trim(gf_eqref(lstr_equip.eq_type, lstr_equip.eq_ref))

				setnull(ld_work)
				setnull(ld_out)
				setnull(ld_in)

				//If there's an origination / termination event, check whether the requested
				//date is before or after this.  If it is, set the selection to the origination
				//or termination date.   (Should we really be doing this??  --BKW)

				if lstr_equip.oe_orig_event > 0 then
					select de_arrdate into :ld_out from disp_events 
					where de_id = :lstr_equip.oe_orig_event ;
					if sqlca.sqlcode = 0 then
						commit ;
					else
						rollback ;
					end if
				end if

				if lstr_equip.oe_term_event > 0 then
					select de_arrdate into :ld_in from disp_events
					where de_id = :lstr_equip.oe_term_event ;
					if sqlca.sqlcode = 0 then
						commit ;
					else
						rollback ;
					end if
				end if

				if daysafter(sel_date, ld_out) > 0 then
					ld_work = ld_out
				elseif daysafter(sel_date, ld_in) < 0 then
					ld_work = ld_in
				end if

				if not isnull(ld_work) then
					//Changed to use function 3.7.00  8/15/03  BKW
					This.wf_SetDateSelection ( ld_Work )
				end if

			end if

		end if

	CASE ELSE //Unexpected Type
		GOTO Failure

	END CHOOSE

	if lnv_numerical.of_IsNullOrNotPos(sel_id) then //was: sel_id < 1
		ddlb_select.setfocus()
		return
	end if

end if


CHOOSE CASE sel_type
	
	CASE gc_Dispatch.ci_ItinType_Shipment
		
		lstr_Parm.is_Label = "CATEGORY"
		lstr_Parm.ia_Value = "SHIP"
		lnv_msg.of_Add_Parm ( lstr_Parm ) 		
		
		lstr_Parm.is_Label = "ID"
		lstr_Parm.ia_Value = sel_id
		lnv_msg.of_Add_Parm ( lstr_Parm ) 
		
	disp_parms.anys[1] = "SHIP"
	disp_parms.anys[2] = sel_id	

	
	CASE gc_Dispatch.ci_ItinType_Driver, &
		gc_Dispatch.ci_ItinType_PowerUnit, &
		gc_Dispatch.ci_ItinType_TrailerChassis, &
		gc_Dispatch.ci_ItinType_Container, &
		gc_Dispatch.ci_ItinType_Trip
	
	
		lstr_Parm.is_Label = "CATEGORY"
		lstr_Parm.ia_Value = "ITIN"
		lnv_msg.of_Add_Parm ( lstr_Parm ) 
		
		lstr_Parm.is_Label = "TYPE"
		lstr_Parm.ia_Value = sel_type
		lnv_msg.of_Add_Parm ( lstr_Parm ) 
		
		lstr_Parm.is_Label = "ID"
		lstr_Parm.ia_Value =  sel_id
		lnv_msg.of_Add_Parm ( lstr_Parm ) 
		
		lstr_Parm.is_Label = "DATE"
		lstr_Parm.ia_Value = Date ( DateTime ( sel_date )  )
		lnv_msg.of_Add_Parm ( lstr_Parm ) 

	disp_parms.anys[1] = "ITIN"			// i am populating these in addition to save time. I don't have time to
	disp_parms.anys[2] = sel_type      //  chase down all the places the they are expected in the return value
	disp_parms.anys[3] = sel_id
	disp_parms.anys[4] = sel_date
	
	CASE ELSE //Unexpected Type
		GOTO Failure

END CHOOSE

if left(action, 4) = "OPEN" then
	w_dispatch dispwindow
	opensheetwithparm(dispwindow, lnv_msg, lnv_AppServices.of_GetFrame ( ), 0, Layered!)
end if

closewithreturn(THIS, disp_parms)
return

failure:
messagebox("Select Error", "Could not process selection request.~n~nRequest cancelled.", &
	exclamation!)
ddlb_select.setfocus()



//We should revise the way the return values are passed to be something more like this.
//However, we'd have to chase the things that call this window, the open of w_dispatch, 
//other things that open w_dispatch, etc...  I'm not sure how many references there are.

//lstr_Parm.is_Label = "ItinType"
//lstr_Parm.ia_Value = sel_type
//lnv_Msg.of_Add_Parm ( lstr_Parm )
//
//lstr_Parm.is_Label = "Id"
//lstr_Parm.ia_Value = sel_id
//lnv_Msg.of_Add_Parm ( lstr_Parm )
//
//CHOOSE CASE sel_type
//
//CASE gc_Dispatch.ci_ItinType_Driver, &
//	gc_Dispatch.ci_ItinType_PowerUnit, &
//	gc_Dispatch.ci_ItinType_TrailerChassis, &
//	gc_Dispatch.ci_ItinType_Container
//
//	lstr_Parm.is_Label = "Date"
//	lstr_Parm.ia_Value = sel_date
//	lnv_Msg.of_Add_Parm ( lstr_Parm )
//
//END CHOOSE
end event

event ue_enablecancel;cb_cancel.Enabled = TRUE
end event

protected subroutine type_response (integer ai_type);integer readloop, &
			li_Count
Boolean	lb_ShowDateControl = TRUE
long ll_current_id
string ls_current_text

if sel_type = ai_Type then return

ll_current_id = sel_id
ls_current_text = ddlb_select.text

choose case ai_Type

case gc_Dispatch.ci_ItinType_Driver

	cb_list.text = "Name:"
	cbx_active.checked = true
	cbx_active.enabled = false

case gc_Dispatch.ci_ItinType_Shipment

	cb_list.text = "Ship#:"
	cbx_active.checked = false
	cbx_active.enabled = false
	lb_ShowDateControl = false

case gc_Dispatch.ci_ItinType_Trip

	cb_List.Text = "Trip#:"
	cbx_Active.Checked = FALSE
	cbx_Active.Enabled = FALSE
	lb_ShowDateControl = FALSE

case gc_Dispatch.ci_ItinType_PowerUnit, &
	gc_Dispatch.ci_ItinType_TrailerChassis, &
	gc_Dispatch.ci_ItinType_Container

	cb_list.text = "Ref # :"

	CHOOSE CASE sel_type

	CASE	gc_Dispatch.ci_ItinType_PowerUnit, &
			gc_Dispatch.ci_ItinType_TrailerChassis, &
			gc_Dispatch.ci_ItinType_Container

		//User was already dealing with equipment.  Leave active only the way it is.

	CASE ELSE

		//User was not deailing with equipment.  Restore active only default.

		cbx_Active.Checked = TRUE

	END CHOOSE

//	if sel_type = 100 or sel_type = 500 then cbx_active.checked = true
	cbx_active.enabled = true

CASE ELSE  //Unexpected Type
	RETURN  //??  This shouldn't happen, but it should probably be handled better anyway.

end choose

sel_type = ai_Type
sel_id = 0

st_date_label.visible = lb_ShowDateControl
sle_date.visible = lb_ShowDateControl
vsb_date.visible = lb_ShowDateControl
st_RelativeDate.Visible = lb_ShowDateControl

ddlb_select.setredraw(false)
ddlb_select.reset()

choose case sel_type

case gc_Dispatch.ci_ItinType_Driver

	li_Count = UpperBound ( Drivers )

	for readloop = 1 to li_Count
		ddlb_select.additem(drivers[readloop].em_fn + " " + drivers[readloop].em_ln)
	next

	if li_Count > 0 then sel_id = drivers[1].em_id

case gc_Dispatch.ci_ItinType_PowerUnit

	li_Count = UpperBound ( Tractors )

	for readloop = 1 to li_Count
		ddlb_select.additem(trim(gf_eqref(tractors[readloop].eq_type, &
			tractors[readloop].eq_ref)))
	next

	if li_Count > 0 then sel_id = tractors[1].eq_id

case gc_Dispatch.ci_ItinType_TrailerChassis

	li_Count = UpperBound ( Trailers )

	for readloop = 1 to li_Count
		ddlb_select.additem(trim(gf_eqref(trailers[readloop].eq_type, &
			trailers[readloop].eq_ref)))
	next

	if li_Count > 0 then sel_id = trailers[1].eq_id

case gc_Dispatch.ci_ItinType_Container

	li_Count = UpperBound ( Containers )

	for readloop = 1 to li_Count
		ddlb_select.additem(trim(gf_eqref(containers[readloop].eq_type, &
			containers[readloop].eq_ref)))
	next

	if li_Count > 0 then sel_id = containers[1].eq_id

CASE gc_Dispatch.ci_ItinType_Shipment

	li_Count = UpperBound ( ila_ShipmentIds )

	FOR readloop = 1 TO li_Count

		ddlb_Select.AddItem ( String ( ila_ShipmentIds [ readloop ], "0000" ) )

	NEXT

	IF li_Count > 0 THEN

		sel_id = ila_ShipmentIds [ 1 ]

	END IF

CASE gc_Dispatch.ci_ItinType_Trip

	li_Count = UpperBound ( ila_TripIds )

	FOR readloop = 1 TO li_Count

		ddlb_Select.AddItem ( String ( ila_TripIds [ readloop ], "0000" ) )

	NEXT

	IF li_Count > 0 THEN

		sel_id = ila_TripIds [ 1 ]

	END IF


//CASE ELSE
	//No processing needed

end choose

ddlb_select.setredraw(true)
if sel_id > 0 then
	ddlb_select.selectitem(1)
elseif ll_current_id > 0 then
	ddlb_select.text = ""
else
	ddlb_select.text = ls_current_text
end if
ddlb_select.setfocus()
end subroutine

private function integer wf_setdateselection (date ad_selection);Long		ll_DaysAfter

Integer	li_Return = 1


//Currently, null date selection is not allowed.  If null is requested,
//reset the display to the current selection.  If that's null, use today.

IF li_Return = 1 THEN

	IF IsNull ( ad_Selection ) THEN

		IF IsNull ( sel_date ) THEN

			ad_Selection = Date ( DateTime ( Today ( ) ) )  //Trim the hidden time component

		ELSE

			ad_Selection = sel_date

		END IF

	END IF

END IF


//Although null date selection is not allowed, above, I'm going to code display handling
//below as if it were, in case we decide to allow it.

IF li_Return = 1 THEN

	//Set the instance variable
	sel_date = ad_Selection


	//Set the text in the date sle

	IF IsNull ( ad_Selection ) THEN

		sle_Date.Text = ""

	ELSE

		sle_Date.Text = Upper ( String ( ad_Selection, "m/d/yy (ddd.)" ) )

	END IF


	//Set the relative date indicator text and color

	ll_DaysAfter = DaysAfter ( Today ( ), ad_Selection )

	CHOOSE CASE ll_DaysAfter

	CASE 0

		st_RelativeDate.Text = "Today"
		st_RelativeDate.TextColor = Rgb ( 255, 255, 255 )  //White
		st_RelativeDate.BackColor = Rgb ( 0, 128, 0 )  //Dark Green

	CASE IS > 0

		st_RelativeDate.Text = "+" + String ( ll_DaysAfter )
		st_RelativeDate.TextColor = 0 //Black
		st_RelativeDate.BackColor = Rgb ( 255, 255, 0 ) //Yellow

	CASE IS < 0

		st_RelativeDate.Text = String ( ll_DaysAfter )
		st_RelativeDate.TextColor = Rgb ( 255, 255, 255 ) //White
		st_RelativeDate.BackColor = Rgb ( 255, 0, 0 ) //Red

	CASE ELSE  //Null

		st_RelativeDate.Text = ""
		st_RelativeDate.TextColor = 0  //Black
		st_RelativeDate.BackColor = Rgb ( 192, 192, 192 )  //Silver

	END CHOOSE

END IF


RETURN li_Return
end function

on w_itin_select.create
int iCurrent
call super::create
this.st_relativedate=create st_relativedate
this.rb_trip=create rb_trip
this.cbx_active=create cbx_active
this.rb_shipment=create rb_shipment
this.ddlb_select=create ddlb_select
this.vsb_date=create vsb_date
this.st_date_label=create st_date_label
this.sle_date=create sle_date
this.rb_container=create rb_container
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.cb_list=create cb_list
this.rb_trailerchassis=create rb_trailerchassis
this.rb_powerunit=create rb_powerunit
this.rb_driver=create rb_driver
this.gb_selection=create gb_selection
this.gb_type=create gb_type
this.dw_reflist=create dw_reflist
this.dw_equipment=create dw_equipment
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_relativedate
this.Control[iCurrent+2]=this.rb_trip
this.Control[iCurrent+3]=this.cbx_active
this.Control[iCurrent+4]=this.rb_shipment
this.Control[iCurrent+5]=this.ddlb_select
this.Control[iCurrent+6]=this.vsb_date
this.Control[iCurrent+7]=this.st_date_label
this.Control[iCurrent+8]=this.sle_date
this.Control[iCurrent+9]=this.rb_container
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.cb_select
this.Control[iCurrent+12]=this.cb_list
this.Control[iCurrent+13]=this.rb_trailerchassis
this.Control[iCurrent+14]=this.rb_powerunit
this.Control[iCurrent+15]=this.rb_driver
this.Control[iCurrent+16]=this.gb_selection
this.Control[iCurrent+17]=this.gb_type
this.Control[iCurrent+18]=this.dw_reflist
this.Control[iCurrent+19]=this.dw_equipment
end on

on w_itin_select.destroy
call super::destroy
destroy(this.st_relativedate)
destroy(this.rb_trip)
destroy(this.cbx_active)
destroy(this.rb_shipment)
destroy(this.ddlb_select)
destroy(this.vsb_date)
destroy(this.st_date_label)
destroy(this.sle_date)
destroy(this.rb_container)
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.cb_list)
destroy(this.rb_trailerchassis)
destroy(this.rb_powerunit)
destroy(this.rb_driver)
destroy(this.gb_selection)
destroy(this.gb_type)
destroy(this.dw_reflist)
destroy(this.dw_equipment)
end on

event open;s_anys open_parms
open_parms = message.powerobjectparm
n_cst_numerical lnv_numerical

integer num_parms, num_em, num_eq, readloop, type_parm
string ship_policy
long drids[], eqids[]
s_emp_info find_ems
s_eq_info find_eqs
n_cst_LicenseManager	lnv_LicenseManager
Boolean	lb_Dispatch, &
			lb_OrderEntry, &
			lb_Brokerage
RadioButton	lrb_Initial
Date		ld_Selection

lb_Dispatch = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_Dispatch )
lb_OrderEntry = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_OrderEntry )
lb_Brokerage = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_Brokerage )


rb_Driver.Enabled = lb_Dispatch
rb_PowerUnit.Enabled = lb_Dispatch
rb_TrailerChassis.Enabled = lb_Dispatch
rb_Container.Enabled = lb_Dispatch
rb_Shipment.Enabled = lb_Dispatch OR lb_OrderEntry
rb_Trip.Enabled = lb_Brokerage


type_parm = open_parms.anys[1]

//no type passed in, use sys setting default
IF isNull(type_parm) OR type_parm = 0 THEN
	n_cst_setting_defaultitinerarybutton	lnv_Setting
	lnv_Setting = CREATE n_cst_setting_defaultitinerarybutton
	CHOOSE CASE lnv_Setting.of_Getvalue( )
	
		CASE appeon_constant.cs_Driver
			type_parm = gc_Dispatch.ci_ItinType_Driver
			
		CASE appeon_constant.cs_PowerUnit
			type_parm = gc_Dispatch.ci_ItinType_PowerUnit
			
		CASE appeon_constant.cs_Trailer
			type_parm = gc_Dispatch.ci_ItinType_TrailerChassis
			
		CASE appeon_constant.cs_Container
			type_parm = gc_Dispatch.ci_ItinType_Container
			
		CASE appeon_constant.cs_3rdpartytrip
			type_parm = gc_Dispatch.ci_ItinType_Trip
			
	END CHOOSE
	Destroy(lnv_Setting)
END IF


IF lnv_numerical.of_IsNullOrNotPos(type_parm) THEN

	//Bug fix 2.6.00  Was not letting user use jump to from shipment when
	//only brokerage was licensed (setting would default to PowerUnit, which
	//was disabled, and then they'd get a Licensed message below.)

	IF lb_Dispatch THEN
		type_parm = gc_Dispatch.ci_ItinType_PowerUnit
	ELSEIF lb_Brokerage THEN
		type_parm = gc_Dispatch.ci_ItinType_Trip
	END IF

END IF

ship_policy = open_parms.anys[2]
if ship_policy = "ALL_SHIPS" then routed_only = false

ld_Selection = open_parms.anys[3]
if isnull(ld_Selection) then
	ld_Selection = date(datetime(today()))  //Set to today, trim hidden time component
end if

action = open_parms.anys[5] //Expecting either "OPEN" or "PASS"

num_parms = upperbound(open_parms.anys)

if num_parms > 5 then drids = open_parms.anys[6]
if num_parms > 6 then eqids = open_parms.anys[7]
if num_parms > 7 then ds_emp = open_parms.anys[8]
if num_parms > 8 then ds_equip = open_parms.anys[9]
IF Num_Parms > 9 THEN ila_ShipmentIds = Open_Parms.Anys[10]
IF Num_Parms > 10 THEN ila_TripIds = Open_Parms.Anys[11]

num_em = upperbound(drids)
num_eq = upperbound(eqids)

for readloop = 1 to num_em
	find_ems.em_id = drids[readloop]
	if gf_emp_info(ds_emp, null_str, null_str, find_ems) > 0 then &
		drivers[upperbound(drivers) + 1] = find_ems
next

for readloop = 1 to num_eq
	find_eqs.eq_id = eqids[readloop]
	if gf_eq_info(ds_equip, null_str, null_str, find_eqs) > 0 then
		choose case find_eqs.eq_type
		case "T", "S", "N"
			tractors[upperbound(tractors) + 1] = find_eqs
		case "V", "F", "R", "K", "B", "H"
			trailers[upperbound(trailers) + 1] = find_eqs
		case "C"
			containers[upperbound(containers) + 1] = find_eqs
		end choose
	end if
next

choose case type_parm
case gc_Dispatch.ci_ItinType_Driver
	lrb_Initial = rb_Driver
case gc_Dispatch.ci_ItinType_PowerUnit
	lrb_Initial = rb_PowerUnit
case gc_Dispatch.ci_ItinType_TrailerChassis
	lrb_Initial = rb_TrailerChassis
case gc_Dispatch.ci_ItinType_Container
	lrb_Initial = rb_Container
case gc_Dispatch.ci_ItinType_Shipment
	lrb_Initial = rb_Shipment
case gc_Dispatch.ci_ItinType_Trip
	lrb_Initial = rb_Trip
end choose

IF lrb_Initial.Enabled THEN
	lrb_Initial.Checked = TRUE
ELSE
	lnv_LicenseManager.of_DisplayModuleNotice ( This.Title )
	cb_Cancel.Event Trigger Clicked ( )
	RETURN
END IF

This.wf_SetDateSelection ( ld_Selection )

post type_response(type_parm)

dw_equipment.BringToTop = TRUE
dw_reflist.BringToTop = TRUE
end event

event key;
IF lower ( GetFocus ( ).Classname ( ) ) = "ddlb_select" THEN
	
	IF key = KEYDOWNARROW! THEN
		String	ls_Value

		ls_Value = TRIM ( ddlb_select.Text )
		
		IF sel_type = gc_Dispatch.ci_ItinType_Shipment THEN
			IF Left ( ls_Value , 2 ) = "//"  AND Len ( ls_Value ) > 2 THEN
				ls_Value = TRIM ( right(ls_Value, len(ls_Value) - 2) )
				IF dw_reflist.of_RetrieveWithRef ( ls_Value ) <> -1 THEN
					dw_reflist.SetFocus ( )
					cb_cancel.Enabled = FALSE
				END IF
						
			ELSE
				IF dw_Equipment.of_Retrieve  ( ls_Value ) <> -1 THEN
					dw_Equipment.Visible = TRUE
					dw_Equipment.SetFocus ( )
					cb_cancel.Enabled = FALSE
				ELSE 
					MessageBox ( "Equipment selection" , "An error occurred while attempting to find a matching piece of equipment." )
				END IF
			END IF
		END IF
		
	ELSEIF key = KeyEscape! THEN
		ddlb_select.SetFocus( ) 	
	END IF
	
ELSEIF lower ( GetFocus ( ).Classname ( ) ) = "dw_equipment" THEN
	dw_Equipment.Event ue_Key ( key, keyflags )
	
END IF






end event

type cb_help from w_response`cb_help within w_itin_select
integer x = 1787
integer y = 560
end type

type st_relativedate from statictext within w_itin_select
integer x = 1605
integer y = 220
integer width = 192
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_trip from radiobutton within w_itin_select
integer x = 82
integer y = 468
integer width = 640
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "&3RD PARTY TRIP"
end type

event clicked;type_response ( gc_Dispatch.ci_ItinType_Trip )
end event

type cbx_active from checkbox within w_itin_select
integer x = 832
integer y = 384
integer width = 402
integer height = 76
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Active Only "
boolean checked = true
end type

type rb_shipment from radiobutton within w_itin_select
integer x = 82
integer y = 392
integer width = 640
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "&SHIPMENT"
end type

event clicked;type_response ( gc_Dispatch.ci_ItinType_Shipment )
end event

type ddlb_select from dropdownlistbox within w_itin_select
event ue_editchanged pbm_cbneditchange
integer x = 1042
integer y = 104
integer width = 750
integer height = 312
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"CLARK","DRANGULA","WIDELL","PHILLIPS","GRAPKOWSKY","DAVIDSON"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;sel_id = 0

if index > 0 then

	choose case sel_type

	case gc_Dispatch.ci_ItinType_Driver
		sel_id = drivers[index].em_id

	case gc_Dispatch.ci_ItinType_PowerUnit
		sel_id = tractors[index].eq_id

	case gc_Dispatch.ci_ItinType_TrailerChassis
		sel_id = trailers[index].eq_id

	case gc_Dispatch.ci_ItinType_Container
		sel_id = containers[index].eq_id

	//CASE ELSE
		//No processing needed

	end choose

	force_change = true

end if
end event

event modified;if force_change then force_change = false else sel_id = 0



end event

type vsb_date from vscrollbar within w_itin_select
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event rbuttondown pbm_rbuttondown
integer x = 1518
integer y = 204
integer width = 73
integer height = 104
boolean stdwidth = false
end type

event linedown;Date	ld_New
n_cst_string lnv_string
ld_New = lnv_string.of_SpecialDate(sle_date.text)

if isnull(ld_New) then
	if isdate(left(sle_date.text, 8)) then
		ld_New = date(left(sle_date.text, 8))
	elseif isdate(left(sle_date.text, 7)) then
		ld_New = date(left(sle_date.text, 7))
	elseif isdate(left(sle_date.text, 6)) then
		ld_New = date(left(sle_date.text, 6))
	else
		beep(1)
		return
	end if
end if

ld_New = relativedate(ld_New, -1)

Parent.wf_SetDateSelection ( ld_New )  //Changed to use function 3.7.00  8/15/03  BKW

cb_select.setfocus()
end event

event lineup;Date	ld_New
n_cst_string lnv_string
ld_New = lnv_string.of_SpecialDate(sle_date.text)

if isnull(ld_New) then
	if isdate(left(sle_date.text, 8)) then
		ld_New = date(left(sle_date.text, 8))
	elseif isdate(left(sle_date.text, 7)) then
		ld_New = date(left(sle_date.text, 7))
	elseif isdate(left(sle_date.text, 6)) then
		ld_New = date(left(sle_date.text, 6))
	else
		beep(1)
		return
	end if
end if

ld_New = relativedate(ld_New, 1)

Parent.wf_SetDateSelection ( ld_New )  //Changed to use function 3.7.00  8/15/03  BKW

cb_select.setfocus()
end event

event rbuttondown;//parent.setfocus() //To trigger modified of sle_date
end event

type st_date_label from statictext within w_itin_select
integer x = 837
integer y = 220
integer width = 187
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Date:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_date from singlelineedit within w_itin_select
event keydown pbm_keydown
integer x = 1042
integer y = 212
integer width = 466
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event keydown;CHOOSE CASE Key

CASE KeyUpArrow!

	vsb_Date.Event LineUp ( )
	This.SetFocus ( )   //LineUp sets focus to cb_Select

CASE KeyDownArrow!

	vsb_Date.Event LineDown ( )
	This.SetFocus ( )   //LineDown sets focus to cb_Select

END CHOOSE
end event

event modified;Date	ld_New
n_cst_string lnv_string

//Attempt to determine a date from what was typed.
ld_New = lnv_string.of_SpecialDate(this.text)

if isnull(ld_New) then

	//We can't determine a date from what was typed. Reset the date selection to the current 
	//instance selection.

	beep(1)
	Parent.wf_SetDateSelection ( sel_date ) //Changed to use function 3.7.00  8/15/03  BKW
	this.setfocus()

else

	//We could determine a date from what was typed.  Set the date selection.

	Parent.wf_SetDateSelection ( ld_New )  //Changed to use function 3.7.00  8/15/03  BKW

end if
end event

event getfocus;this.selecttext(1, len(this.text))
end event

type rb_container from radiobutton within w_itin_select
integer x = 82
integer y = 316
integer width = 640
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "&CONTAINER"
end type

event clicked;type_response( gc_Dispatch.ci_ItinType_Container )
end event

type cb_cancel from commandbutton within w_itin_select
integer x = 1545
integer y = 376
integer width = 247
integer height = 88
integer taborder = 80
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;s_anys disp_parms

disp_parms.anys[1] = "NONE"
disp_parms.anys[2] = null_int
disp_parms.anys[3] = null_long
disp_parms.anys[4] = null_date

closewithreturn(parent, disp_parms)
end event

type cb_select from commandbutton within w_itin_select
integer x = 1257
integer y = 376
integer width = 247
integer height = 88
integer taborder = 50
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Select"
boolean default = true
end type

event clicked;PARENT.Event ue_ProcessRequest ( )
end event

type cb_list from commandbutton within w_itin_select
integer x = 832
integer y = 104
integer width = 197
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Name:"
end type

event clicked;n_cst_ShipmentManager lnv_ShipmentMgr
n_ds lds_Ships
lds_Ships = lnv_ShipmentMgr.of_Get_DS_Ship( )

CHOOSE CASE sel_type

CASE gc_Dispatch.ci_ItinType_Shipment

	long ship_id, foundrow
	open(w_ship_select)
	ship_id = message.doubleparm

	if ship_id > 0 then
		foundrow = lds_Ships.find("ds_id = " + string(ship_id), 1, lds_Ships.rowcount())
		if foundrow > 0 then
			if lds_Ships.object.ds_dorb[foundrow] = "T" or not routed_only then
				ddlb_select.text = lds_Ships.object.ds_pronum[foundrow]
				sel_id = lds_Ships.object.ds_id[foundrow]
				cb_select.setfocus()
				cb_select.event post clicked()
				return
			end if
		end if
	end if
	ddlb_select.setfocus()

CASE gc_Dispatch.ci_ItinType_Trip

	Long	ll_TripId
	Open ( w_Trip_Select )
	ll_TripId = message.doubleparm

	if ll_TripId > 0 then
		ddlb_select.text = String ( ll_TripId, "0000" )
		sel_id = ll_TripId
		cb_select.setfocus()
		cb_select.event post clicked()
		return
	end if
	ddlb_select.setfocus()

CASE gc_Dispatch.ci_ItinType_Driver

	s_emp_info find_ems
	find_ems.em_type = 2
	find_ems.di_date = sel_Date
//	find_ems.em_status = "K"
	openwithparm(w_emp_list, find_ems)
	find_ems = message.powerobjectparm
	if find_ems.em_id > 0 then
//		force_change = true
		ddlb_select.text = find_ems.em_fn + " " + find_ems.em_ln
		sel_id = find_ems.em_id
		sle_date.setfocus()
	else
		ddlb_select.setfocus()
	end if

CASE gc_Dispatch.ci_ItinType_PowerUnit, &
	gc_Dispatch.ci_ItinType_TrailerChassis, &
	gc_Dispatch.ci_ItinType_Container

	s_eq_info find_eqs
	g_tempstr = string(sel_type)
	openwithparm(w_equip_select, null_ds)
	find_eqs.eq_id = message.doubleparm
	if gf_eq_info(null_ds, null_str, null_str, find_eqs) < 1 then
		ddlb_select.setfocus()
		return
	end if
//	force_change = true
	ddlb_select.text = trim(gf_eqref(find_eqs.eq_type, find_eqs.eq_ref))
	sel_id = find_eqs.eq_id
	sle_date.setfocus()

END CHOOSE
end event

type rb_trailerchassis from radiobutton within w_itin_select
integer x = 82
integer y = 240
integer width = 640
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "TRAI&LER / CHASSIS"
end type

event clicked;type_response ( gc_Dispatch.ci_ItinType_TrailerChassis )
end event

type rb_powerunit from radiobutton within w_itin_select
integer x = 82
integer y = 164
integer width = 640
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "&TRACTOR / VAN / S.T."
end type

event clicked;type_response( gc_Dispatch.ci_ItinType_PowerUnit )
end event

type rb_driver from radiobutton within w_itin_select
integer x = 82
integer y = 88
integer width = 640
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "&DRIVER"
end type

event clicked;type_response( gc_Dispatch.ci_ItinType_Driver )
end event

type gb_selection from groupbox within w_itin_select
integer x = 795
integer y = 20
integer width = 1029
integer height = 308
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Selection"
end type

type gb_type from groupbox within w_itin_select
integer x = 41
integer y = 20
integer width = 699
integer height = 536
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Selection Type"
end type

type dw_reflist from u_dw_reflist within w_itin_select
boolean visible = false
integer x = 64
integer y = 184
integer width = 1728
integer height = 348
integer taborder = 60
boolean bringtotop = true
boolean hscrollbar = true
end type

event constructor;call super::constructor;THIS.of_SetRowSelect ( TRUE )
inv_RowSelect.of_SetStyle ( 0 )
end event

event losefocus;THIS.Visible = FALSE
Post Event ue_EnableCancel ( )
end event

event ue_selectionchanged;IF al_ID > 0 THEN
	ddlb_select.Text = String ( al_ID )
	PARENT.Event ue_ProcessRequest ( )
END IF

RETURN 1
end event

event ue_key;call super::ue_key;IF Key = KeyEscape! THEN
	ddlb_select.SetFocus ()
END IF
RETURN 0
end event

type dw_equipment from u_dw_eqlist within w_itin_select
boolean visible = false
integer x = 283
integer y = 184
integer width = 1509
integer height = 348
integer taborder = 70
boolean bringtotop = true
end type

event losefocus;THIS.Visible = FALSE
Post Event ue_EnableCancel ( )
end event

event constructor;call super::constructor;
THIS.of_SetRowSelect ( TRUE )
inv_RowSelect.of_SetStyle ( 0 )
end event

event ue_selectionchanged;long		ll_Row
Long		ll_SelectionID

ll_Row = al_row

IF ll_Row > 0 THEN
	ll_SelectionID = THIS.getItemNumber ( ll_Row , "outside_equip_shipment" )
	IF ll_SelectionID > 0 THEN
		ddlb_select.Text = String ( ll_SelectionID )
		ddlb_select.SetFocus ( )
		PARENT.Event ue_ProcessRequest ( )
	END IF
END IF


RETURN 0
end event

event ue_key;call super::ue_key;IF Key = KeyEscape! THEN
	ddlb_select.SetFocus ()
END IF
RETURN 0
end event

