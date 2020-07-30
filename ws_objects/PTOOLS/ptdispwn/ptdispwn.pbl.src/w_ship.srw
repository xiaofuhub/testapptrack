$PBExportHeader$w_ship.srw
$PBExportComments$PTSHIP.     The shipment window.
forward
global type w_ship from w_child
end type
type cb_autoroute from u_cb within w_ship
end type
type uo_events from u_cst_eventlist within w_ship
end type
type uo_itemlist from u_cst_itemlist within w_ship
end type
type cb_details from u_cb within w_ship
end type
type cb_revenuesplits from commandbutton within w_ship
end type
type cb_equipment from commandbutton within w_ship
end type
type uo_splits from u_cst_splitid within w_ship
end type
type uo_intermodalview from u_cst_intermodalshipment within w_ship
end type
type cb_1 from commandbutton within w_ship
end type
type dw_item_details from u_dw_itemdetails within w_ship
end type
type dw_event_details from u_dw_eventdetail within w_ship
end type
type cb_removerouting from u_cb within w_ship
end type
end forward

shared variables
boolean	sb_ValidateRef
boolean	sb_ValidateBL
string	ss_Status
end variables

global type w_ship from w_child
boolean visible = false
integer x = 5
integer y = 4
integer width = 3685
integer height = 1992
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
long backcolor = 12632256
event ncmousemove pbm_ncmousemove
event show_pop ( dwobject dwo,  long row,  string data )
event recalc_amts pbm_custom26
event date_response pbm_custom03
event ue_ratelookup ( boolean ab_createnew )
event type integer ue_autoroute ( )
event ue_addleasecharges ( )
event ue_revenuesplits ( )
event ue_showequipment ( )
event ue_showedilist ( )
event ue_addeventnote ( n_cst_msg anv_msg,  long ala_ids[] )
event ue_setfocusoneventlist ( )
event ue_addedevent ( )
event ue_autorate ( )
event ue_applyautorate ( n_cst_ratedata anva_ratedata[],  n_cst_beo_item anva_item[] )
event ue_splitfront ( )
event ue_splitback ( )
event type integer ue_sitemove ( long al_insertionpoint,  long al_site,  n_cst_msg anv_msg )
event ue_splitboth ( )
event ue_rightclickoncompany ( dwobject dwo,  long row,  string data )
event ue_postopen ( )
event ue_refreshequipment ( )
event ue_removerouting ( )
cb_autoroute cb_autoroute
uo_events uo_events
uo_itemlist uo_itemlist
cb_details cb_details
cb_revenuesplits cb_revenuesplits
cb_equipment cb_equipment
uo_splits uo_splits
uo_intermodalview uo_intermodalview
cb_1 cb_1
dw_item_details dw_item_details
dw_event_details dw_event_details
cb_removerouting cb_removerouting
end type
global w_ship w_ship

type variables
public:
char 	dorb
integer 	whats_on, mboxret, numevents, numlh, numac
n_cst_toolmenu_manager 	inv_cst_toolmenu_manager
datastore 	ids_orfin_events

protected:
integer 		numst = 4, stloop
decimal 		oldvals[]
char 		bill_format, oldcharvals[]
w_dispatch 	w_disp
string		is_payable_format
//w_ship_add addwin

//statictext st_ip[0 to 5]
s_emp_info 	find_ems
s_eq_info 	find_eqs
string 		scroll_column = "co_name"
n_cst_ship_type	inv_ShipTypeManager
char 		ich_expedite
Boolean		ib_SplitsEnabled = FALSE

Private:
n_cst_beo_Shipment  inv_Shipment



Long il_ItemX
Long il_ItemY
Long il_ItemWidth
Long il_ItemHeight

Long il_EventX
Long il_EventY
Long il_EventHeight
Long il_EventWidth

Long il_SplitsX
Long il_SplitsY

Long il_RevX
Long il_RevY

Long il_MoreX
Long il_MoreY

Long il_EquipX
Long il_EquipY

Long il_RouteX
Long il_RouteY

Long il_OriginalHeight
Long il_OriginalWidth

end variables

forward prototypes
protected function integer clear_seq (integer trailer_id, decimal trailer_seq)
protected function integer set_title ()
public subroutine wf_delete_ship ()
public subroutine wf_jump ()
public subroutine wf_add_event ()
public subroutine wf_move_event ()
public subroutine wf_delete_event ()
public subroutine wf_delete_item ()
public subroutine wf_process_request (string as_request)
public function integer wf_create_toolmenu ()
public subroutine wf_ppcol_check ()
public function integer wf_status_check (string as_context)
public function integer display_ship (long al_id)
public function long wf_getshipmentid ()
private subroutine wf_setdisplayrestrictions (boolean ab_redraw)
private function decimal wf_computerate (readonly long al_row)
public function integer wf_add_item (string as_item_type)
public subroutine wf_ratequery ()
public function integer wf_jumpshipment (readonly long al_id, readonly boolean ab_forceredisplay)
public subroutine wf_managesplits ()
private function n_cst_bso_dispatch wf_getdispatchmanager ()
public function long wf_getselectedeventids (ref long ala_ids[], readonly boolean ab_usecurrent)
public function integer wf_getselectedevents (ref n_cst_beo_event anva_events[])
public subroutine wf_duplicateshipment ()
private function long wf_getcoidfromcode (string as_code)
private function integer wf_clearitemamounts (string as_type)
public function integer wf_constructswitchingoptions (long al_row, ref n_cst_msg anv_msg)
public function long wf_getbilltoid ()
public function integer wf_setcontext (string as_value)
private function integer wf_determinecontext ()
public function n_cst_ShipType wf_getshiptype ()
private function integer wf_resetitemobject ()
private function integer wf_reseteventobject ()
private function integer wf_resetbuttons ()
public function integer wf_validatedata ()
public function integer wf_accepttext (boolean ab_closemsg)
public function integer wf_setitemshare ()
public function integer wf_jumptoitin (n_cst_beo_event anv_event)
public function integer wf_setshares ()
public function integer wf_autoroute ()
public subroutine wf_seteventfocus (long al_row, string as_column)
private function integer wf_showalerts ()
private function integer wf_showallalerts ()
public function n_cst_alertmanager wf_getalertmanager ()
public subroutine wf_ratequery (boolean ab_autoapply)
public subroutine wf_processpsr (readonly n_cst_msg anv_msg)
public function integer wf_overrideshiptype ()
end prototypes

event recalc_amts;//string changed_col, msgstr, ls_ratetype
//integer oldval_index, itemrow, problems[20], checkloop, readloop
//decimal readdec1, readdec2, readdec3, holddec1
//decimal	lc_comp_amt, &
//			lc_ourrate, &
//			lc_totalitemweight, &
//			lc_miles, &
//			lc_qty, &
//			lc_itemamt
//
//changed_col = string(message.longparm, "address")
//oldval_index = message.wordparm
//
//itemrow = dw_item_details.getrow()
//
////dw_item_details.modify("txt_wjc.text = '" + changed_col + "'")
//
////
//ls_ratetype = dw_item_details.getitemstring(itemrow, "di_our_ratetype")
//lc_ourrate = dw_item_details.getitemdecimal(itemrow, "di_our_rate")
//lc_totalitemweight = dw_item_details.getitemdecimal(itemrow, "comp_totitemweight")
//lc_miles = dw_item_details.getitemnumber(itemrow, "di_miles")
//lc_qty = dw_item_details.getitemdecimal(itemrow, "di_qty")
//
//CHOOSE CASE ls_ratetype
//
//CASE appeon_constant.cs_RateUnit_Code_Flat, appeon_constant.cs_RateUnit_Code_Minimum, &
//		appeon_constant.cs_RateUnit_Code_Maximum
//	lc_comp_amt = round ( lc_ourrate, 2 )
//
//CASE appeon_constant.cs_RateUnit_Code_PerUnit, appeon_constant.cs_RateUnit_Code_Piece, &
//	  appeon_constant.cs_RateUnit_Code_Gallon
//	lc_comp_amt = round (lc_qty * lc_ourrate, 2 )
//		
//CASE appeon_constant.cs_RateUnit_Code_PerMile
//	lc_comp_amt	= round ( lc_miles * lc_ourrate, 2 )
//	
//CASE appeon_constant.cs_RateUnit_Code_Class
//	lc_comp_amt = round ( ( lc_totalitemweight / 100 ) * lc_ourrate, 2 )
//
//CASE appeon_constant.cs_RateUnit_Code_Pound
//	lc_comp_amt = round ( lc_totalitemweight * lc_ourrate, 2 )
//	
//CASE appeon_constant.cs_RateUnit_Code_100Pound
//	lc_comp_amt = round ( ( lc_totalitemweight / 100 ) * lc_ourrate, 2 )
//
//CASE appeon_constant.cs_RateUnit_Code_Ton
//	lc_comp_amt = round ( ( lc_totalitemweight / 2000 ) * lc_ourrate, 2 )
//	
//CASE ELSE  //appeon_constant.cs_RateUnit_Code_None
//	lc_comp_amt = 0
//
//END CHOOSE
//////
//
//
////setitem for changed column
//choose case changed_col 
//	case "di_our_ratetype"
//		holddec1 = dw_item_details.getitemnumber(itemrow, "di_our_itemamt")
//		dw_item_details.setitem(itemrow, "di_our_itemamt", 0)
//	case "di_pay_ratetype"
//		holddec1 = dw_item_details.getitemnumber(itemrow, "di_pay_itemamt")
//		dw_item_details.setitem(itemrow, "di_pay_itemamt", 0)
//	case "di_description"
//		//No action needed
//	case else
//
//		//Get the changed value from either the shipment or item datawindow
//		if left(changed_col, 2) = "di" then
//			readdec1 = dw_item_details.getitemnumber(itemrow, changed_col)
//		else
//			readdec1 = dw_ship_info.getitemnumber(1, changed_col)
//		end if
//
//		choose case changed_col
//			case "di_weightperunit", "di_totitemweight", "di_miles"
//				dw_item_details.setitem(itemrow, changed_col, round(readdec1, 0))
//			case "di_our_itemamt", "di_pay_itemamt"
//				dw_item_details.setitem(itemrow, changed_col, round(readdec1, 2))
//				oldvals[oldval_index] = round(oldvals[oldval_index], 2)
//			case "di_our_rate", "di_pay_rate"
//				dw_item_details.setitem(itemrow, changed_col, round(readdec1, 4))
//				oldvals[oldval_index] = round(oldvals[oldval_index], 4)
//			case "di_qty"
//				readdec2 = round(readdec1, 3)
//				oldvals[oldval_index] = round(oldvals[oldval_index], 3)
//				if readdec2 = 0 then //this should be caught by validation, but jic
//					problems[18] ++
//					goto probcheck
//				else
//					dw_item_details.setitem(itemrow, changed_col, readdec2)
//				end if
//			case "ds_total_miles"
//				dw_ship_info.setitem(1, changed_col, round(readdec1, 0))
//			case "ds_lh_totamt", "ds_disc_amt", "ds_ac_totamt", "ds_bill_charge", &
//				"ds_pay_lh_totamt", "ds_pay_ac_totamt", "ds_pay_totamt", "ds_salescom_amt"
//					dw_ship_info.setitem(1, changed_col, round(readdec1, 2))
//					oldvals[oldval_index] = round(oldvals[oldval_index], 2)
//			case "ds_disc_pct"
//				if not isnull(readdec1) then dw_ship_info.setitem(1, changed_col, &
//					round(readdec1, 5))
//				if not isnull(oldvals[oldval_index]) then &
//					oldvals[oldval_index] = round(oldvals[oldval_index], 5)
//		end choose
//end choose
//
//choose case changed_col
//	case "di_weightperunit", "di_qty"
//		readdec1 = dw_item_details.getitemnumber(itemrow, "comp_totitemweight")
//		if readdec1 < 1000000 and readdec1 >= 0 then readdec1 = readdec1 else problems[10] ++
//	case "di_totitemweight"
//		readdec1 = dw_item_details.getitemnumber(itemrow, "di_totitemweight")
//		if readdec1 > 0 then
//			readdec2 = dw_item_details.getitemnumber(itemrow, "di_qty")
//			if readdec2 > 0 then  //should be
//				readdec3 = readdec1 / readdec2
//				if readdec3 < 1 then problems[11] ++
//				if readdec3 >= 1000000 then problems[12] ++
//			else
//				problems[12] ++
//			end if
//		end if
//end choose
//
////???could we have an amount without a ratetype
//
//choose case changed_col
//	case "di_our_rate", "di_our_itemamt", "di_pay_rate", "di_pay_itemamt"
//		if dw_item_details.getitemstring(itemrow, left(changed_col, 7) + "ratetype") = "Z" then
//			problems[20] ++
//			goto probcheck
//		end if
//end choose
//
//
//choose case changed_col
//
//	case "di_our_rate", "di_weightperunit", "di_totitemweight", "di_qty", "di_miles"
//
//		readdec1 = lc_comp_amt//dw_item_details.getitemnumber(itemrow, "comp_our_itemamt")
//
//		if readdec1 < 1000000 and readdec1 >= 0 then
//			//Value is ok
//		else
//			problems[1] ++
//		end if
//		
//		//commented by nwl
////		readdec1 -= dw_item_details.getitemnumber(itemrow, "di_our_itemamt")
//
//		// type 'L' is freight
//		if dw_item_details.getitemstring(itemrow, "di_item_type") = "L" then
//
//			readdec2 = dw_ship_info.getitemnumber(1, "ds_lh_totamt") + readdec1
//
//			if readdec2 < 1000000 and readdec2 >= 0 then
//				//Value is ok
//			else
//				problems[17] ++
//			end if
//
//			readdec3 = dw_ship_info.getitemnumber(1, "ds_disc_pct")
//			if isnull(readdec3) then
//				readdec3 = dw_ship_info.getitemnumber(1, "ds_disc_amt")
//				if readdec3 > readdec2 then 
//					problems[15] ++
//					goto payables
//				end if
//				readdec3 = readdec2 - readdec3
//			else
//				if readdec3 * readdec2 >= 100000 then problems[3] ++
//				readdec3 = readdec2 - round(readdec3 * readdec2, 2)
//			end if
//
//			readdec3 += dw_ship_info.getitemnumber(1, "ds_ac_totamt")
//			if readdec3 < 1000000 and readdec3 >= 0 then
//				//Value is ok
//			else
//				problems[2] ++
//			end if
//
//		else
//
//			readdec2 = dw_ship_info.getitemnumber(1, "ds_bill_charge") + readdec1
//			if readdec2 < 1000000 and readdec2 >= 0 then
//				//Value is ok
//			else
//				problems[2] ++
//			end if
//
//		end if
//
//	case "di_our_itemamt", "di_our_ratetype"
//
//		readdec1 = dw_item_details.getitemnumber(itemrow, "di_our_itemamt")
//		if readdec1 > 0 then
//			readdec2 = wf_ComputeRate ( itemrow )
//			if readdec2 >= 100000 then
//				problems[4] ++
//			elseif readdec2 <= 0 then
//				problems[5] ++
//			elseif isnull(readdec2) then
//				problems[4] ++
//			end if
//		end if
//
//		if dw_item_details.getitemstring(itemrow, "di_item_type") = "L" then
//
//			readdec2 = dw_item_details.getitemnumber(1, "comp_our_real_lh_total")
//			if readdec2 < 1000000 and readdec2 >= 0 then
//				//Value is ok
//			else
//				problems[17] ++
//			end if
//
//			readdec3 = dw_ship_info.getitemnumber(1, "ds_disc_pct")
//			if isnull(readdec3) then
//				readdec3 = dw_ship_info.getitemnumber(1, "ds_disc_amt")
//				if readdec3 > readdec2 then 
//					problems[15] ++
//					goto payables
//				end if
//				readdec3 = readdec2 - readdec3
//			else
//				if readdec3 * readdec2 >= 100000 then problems[3] ++
//				readdec3 = readdec2 - round(readdec3 * readdec2, 2)
//			end if
//
//			readdec3 += dw_ship_info.getitemnumber(1, "ds_ac_totamt")
//			if readdec3 < 1000000 and readdec3 >= 0 then
//				//Value is ok
//			else
//				problems[2] ++
//			end if
//
//		else
//
//			readdec2 = dw_item_details.getitemnumber(1, "comp_our_real_ac_total") + &
//				dw_ship_info.getitemnumber(1, "ds_lh_totamt") - &
//				dw_ship_info.getitemnumber(1, "ds_disc_amt")
//
//			if readdec2 < 1000000 and readdec2 >= 0 then
//				//Value is ok
//			else
//				problems[2] ++
//			end if
//
//		end if
//
//end choose
//
//payables:
//
//choose case changed_col
//	case "ds_disc_pct"
//		readdec1 = dw_ship_info.getitemnumber(1, "comp_disc_amt")
//		if readdec1 >= 0 and readdec1 < 100000 then readdec1 = readdec1 else problems[3] ++
//		readdec2 = dw_ship_info.getitemnumber(1, "comp_bill_charge")
//		if readdec2 >= 0 and readdec2 < 1000000 then readdec2 = readdec2 else problems[2] ++
//	case "ds_disc_amt"
//		readdec1 = dw_ship_info.getitemnumber(1, "ds_disc_amt")
//		readdec2 = dw_ship_info.getitemnumber(1, "ds_lh_totamt")
//		if readdec1 >= readdec2 then
//			problems[15] ++ //covers readdec2 = 0
//		elseif not isnull(dw_ship_info.getitemnumber(1, "ds_disc_pct")) then
//			if round(readdec1 / readdec2, 5) = 0 and readdec1 > 0 then problems[13] ++
//		end if
//		readdec3 = readdec2 - readdec1 + dw_ship_info.getitemnumber(1, "ds_ac_totamt")
//		if readdec3 >= 0 and readdec3 < 1000000 then readdec3 = readdec3 else problems[2] ++
//	case "ds_lh_totamt"
//		readdec1 = dw_ship_info.getitemnumber(1, "ds_lh_totamt")
//		readdec2 = dw_ship_info.getitemnumber(1, "comp_disc_amt")
//		if readdec2 > 0 and readdec2 > readdec1 then problems[15] ++
//		readdec3 = dw_ship_info.getitemnumber(1, "comp_bill_charge")
//		if readdec3 >= 0 and readdec3 < 1000000 then readdec3 = readdec3 else problems[2] ++
//	case "ds_ac_totamt"
//		readdec1 = dw_ship_info.getitemnumber(1, "comp_bill_charge")
//		if readdec1 >= 0 and readdec1 < 1000000 then readdec1 = readdec1 else problems[2] ++
//	case "ds_pay_lh_totamt", "ds_pay_ac_totamt"
//		readdec1 = dw_ship_info.getitemnumber(1, "comp_pay_totamt")
//		if readdec1 >= 0 and readdec1 < 1000000 then readdec1 = readdec1 else problems[7] ++
//end choose
//
//probcheck:
//
//boolean anyprobs
//for checkloop = 1 to 20
//	if problems[checkloop] > 0 then
//		anyprobs = true
//		exit
//	end if
//next
//
//if anyprobs then
//
//	msgstr = "The value you have entered would cause the following problems to occur:~n~n"
//
//	if problems[10] > 0 then msgstr += "The total item weight for the current item "+&
//		"would be 1,000,000 or more.~n~n"
//	if problems[11] > 0 then msgstr += "The weight per unit for the current item would "+&
//		"be less than 1, even though the item has a total weight greater than zero.~n~n"
//	if problems[12] > 0 then msgstr += "The weight per unit for the current item would "+&
//		"be 1,000,000 or more.~n~n"
//	if problems[1] > 0 then msgstr += "The billing item amount for the current item "+&
//		"would be $1,000,000 or more.~n~n"
//	if problems[4] > 0 then msgstr += "The billing rate for the current item would be "+&
//		"$100,000 or more.~n~n"
//	if problems[5] > 0 then msgstr += "The billing rate for the current item would be "+&
//		"less than $0.01, even though the item has a billing item amount greater than zero.~n~n"
//	if problems[17] > 0 then msgstr += "The billing freight total would be $1,000,000 "+&
//		"or more.~n~n"
//	if problems[3] > 0 then msgstr += "The customer discount would be $100,000 or more.~n~n"
//	if problems[15] > 0 then msgstr += "The customer discount, which is specified as a "+&
//		"fixed amount, would exceed the billing freight charges.~n~n"
//	if problems[13] > 0 then msgstr += "The discount rate would be less than 0.001%, "+&
//		"even though the discount amount would be greater than zero.~n~n"
//	if problems[2] > 0 then msgstr += "The billing grand total would be $1,000,000 or more.~n~n"
//	if problems[7] > 0 then msgstr += "The payables grand total would be $1,000,000 or more.~n~n"
//	if problems[18] > 0 then msgstr = "Item quantity cannot be less than .001 (the value "+&
//		"you entered rounds to zero.)~n~n"
//	if problems[20] > 0 then msgstr = "You must select a rate type first.~n~n"
//
//	msgstr += "The change is cancelled, and the previous value will be restored."
//	mboxret = 1
//	messagebox("Shipment Info", msgstr)
//
//	if changed_col = "di_our_ratetype" then
//		dw_item_details.setitem(itemrow, changed_col, oldcharvals[oldval_index])
//		dw_item_details.setitem(itemrow, "di_our_itemamt", holddec1)
////	elseif changed_col = "di_pay_ratetype" then
////		dw_item_details.setitem(itemrow, changed_col, oldcharvals[oldval_index])
////		dw_item_details.setitem(itemrow, "di_pay_itemamt", holddec1)
//	elseif left(changed_col, 2) = "di" then
//		dw_item_details.setitem(itemrow, changed_col, oldvals[oldval_index])
//	elseif left(changed_col, 2) = "ds" then
//		dw_ship_info.setitem(1, changed_col, oldvals[oldval_index])
//	end if
//
////	dw_item_details.modify("txt_wjc.text = '?'")
//	return
//
//end if
//
//choose case changed_col
//	case "di_weightperunit", "di_qty"
//		readdec1 = dw_item_details.getitemnumber(itemrow, "comp_totitemweight")
//		dw_item_details.setitem(itemrow, "di_totitemweight", readdec1)
//	case "di_totitemweight"
//		readdec1 = dw_item_details.getitemnumber(itemrow, "di_totitemweight")
//		readdec3 = 0
//		if readdec1 > 0 then
//			readdec2 = dw_item_details.getitemnumber(itemrow, "di_qty")
//			if readdec2 > 0 then readdec3 = round(readdec1 / readdec2, 0)
//		end if
//		dw_item_details.setitem(itemrow, "di_weightperunit", readdec3)
//end choose
//
//choose case changed_col
//	case "di_weightperunit", "di_qty", "di_totitemweight"
//		if itemrow < numlh + 1 then
//			readdec1 = 0
//			for readloop = 1 to numlh
//				readdec1 += dw_item_details.getitemnumber(readloop, "di_totitemweight")
//			next
//			dw_ship_info.setitem(1, "ds_total_weight", readdec1)
//		end if
//end choose
//
//if not bill_format = "I" then goto jump1
//
//choose case changed_col
//	case "di_our_rate", "di_our_itemamt", "di_weightperunit", "di_totitemweight", &
//		"di_qty", "di_miles", "di_our_ratetype"
//		if changed_col = "di_our_itemamt" or changed_col = "di_our_ratetype" then
//			readdec1 = wf_ComputeRate ( itemrow )
//			dw_item_details.setitem(itemrow, "di_our_rate", readdec1)
//		else
//			readdec1 = round(lc_comp_amt, 2) //round(dw_item_details.getitemnumber(itemrow, "comp_our_itemamt"), 2)
//			dw_item_details.setitem(itemrow, "di_our_itemamt", readdec1)
//		end if
//		if dw_item_details.getitemstring(itemrow, "di_item_type") = "L" then
//			readdec1 = round(dw_item_details.getitemnumber(1, "comp_our_real_lh_total"), 2)
//			dw_ship_info.setitem(1, "ds_lh_totamt", readdec1)
//			dw_ship_info.setitem(1, "ds_disc_amt", &
//				round(dw_ship_info.getitemnumber(1, "comp_disc_amt"), 2))
//		else
//			readdec1 = round(dw_item_details.getitemnumber(1, "comp_our_real_ac_total"), 2)
//			dw_ship_info.setitem(1, "ds_ac_totamt", readdec1)
//		end if
//		dw_ship_info.setitem(1, "ds_bill_charge", &
//			round(dw_ship_info.getitemnumber(1, "comp_bill_charge"), 2))
//end choose
//
//jump1:
//
//if not is_payable_format = "I" then goto jump2
//
//choose case changed_col
//	case "di_pay_rate", "di_pay_itemamt", "di_weightperunit", "di_totitemweight", &
//		"di_qty", "di_miles", "di_pay_ratetype"
////		if changed_col = "di_pay_itemamt" or changed_col = "di_pay_ratetype" then
////			readdec1 = comp_rate(itemrow, "pay")
////			dw_item_details.setitem(itemrow, "di_pay_rate", readdec1)
////		else
////			readdec1 = round(dw_item_details.getitemnumber(itemrow, "comp_pay_itemamt"), 2)
////			dw_item_details.setitem(itemrow, "di_pay_itemamt", readdec1)
////		end if
////		if dw_item_details.getitemstring(itemrow, "di_item_type") = "L" then
////			readdec1 = round(dw_item_details.getitemnumber(1, "comp_pay_real_lh_total"), 2)
////			dw_ship_info.setitem(1, "ds_pay_lh_totamt", readdec1)
////		else
////			readdec1 = round(dw_item_details.getitemnumber(1, "comp_pay_real_ac_total"), 2)
////			dw_ship_info.setitem(1, "ds_pay_ac_totamt", readdec1)
////		end if
////		readdec1 = round(dw_ship_info.getitemnumber(1, "comp_pay_totamt"), 2)
////		dw_ship_info.setitem(1, "ds_pay_totamt", readdec1)
//end choose
//
//jump2:
//
//choose case changed_col
//	case "ds_disc_pct"
//		readdec1 = round(dw_ship_info.getitemnumber(1, "comp_disc_amt"), 2)
//		dw_ship_info.setitem(1, "ds_disc_amt", readdec1)
//		readdec2 = round(dw_ship_info.getitemnumber(1, "comp_bill_charge"), 2)
//		dw_ship_info.setitem(1, "ds_bill_charge", readdec2)
//	case "ds_disc_amt"
//		readdec1 = dw_ship_info.getitemnumber(1, "ds_disc_amt")
//		readdec2 = dw_ship_info.getitemnumber(1, "ds_lh_totamt")
//		if not isnull(dw_ship_info.getitemnumber(1, "ds_disc_pct")) then
//			if readdec1 = 0 then
//				dw_ship_info.setitem(1, "ds_disc_pct", 0)
//			else
//				dw_ship_info.setitem(1, "ds_disc_pct", round(readdec1 / readdec2, 5))
//			end if
//		end if
//		dw_ship_info.setitem(1, "ds_bill_charge", round(readdec2 - readdec1 + &
//			dw_ship_info.getitemnumber(1, "ds_ac_totamt"), 2))
//	case "ds_lh_totamt"
//		readdec2 = round(dw_ship_info.getitemnumber(1, "comp_disc_amt"), 2)
//		dw_ship_info.setitem(1, "ds_disc_amt", readdec2)
//		readdec3 = round(dw_ship_info.getitemnumber(1, "comp_bill_charge"), 2)
//		dw_ship_info.setitem(1, "ds_bill_charge", readdec3)
//	case "ds_ac_totamt"
//		readdec1 = round(dw_ship_info.getitemnumber(1, "comp_bill_charge"), 2)
//		dw_ship_info.setitem(1, "ds_bill_charge", readdec1)
//	case "ds_pay_lh_totamt", "ds_pay_ac_totamt"
//		readdec1 = round(dw_ship_info.getitemnumber(1, "comp_pay_totamt"), 2)
//		dw_ship_info.setitem(1, "ds_pay_totamt", readdec1)
//end choose
//
////dw_item_details.modify("txt_wjc.text = '?'")
end event

event date_response;string changed_col
changed_col = string(message.longparm, "address")

date newdate
integer markloop

n_cst_ShipmentManager	lnv_ShipmentManager

choose case changed_col
	case "ds_ship_date"
		
		newdate = inv_Shipment.of_GetShipDate ( )
		
		if numevents > 0 and not isnull(newdate) then

			IF lnv_ShipmentManager.of_GetInitializeApptDates ( ) THEN

				for markloop = 1 to numevents

					IF IsNull ( dw_event_details.getitemdate(markloop, "de_apptdate") ) THEN
						dw_event_details.setitem(markloop, "de_apptdate", newdate)
					END IF
	
					if dorb = "B" or dorb = "D" then
	
	
						IF IsNull ( dw_event_details.getitemdate(markloop, "de_arrdate") ) THEN
							dw_event_details.setitem(markloop, "de_arrdate", newdate)
						END IF

						//IF IsNull ( dw_event_details.getitemdate(markloop, "de_depdate") ) THEN
						//	dw_event_details.setitem(markloop, "de_depdate", newdate)
						//END IF

					end if
	
				next

			END IF

		end if
end choose
end event

event ue_ratelookup(boolean ab_createnew);/*
	This event will open the rate selection window and allow the user to select a row 
	(populated by rate lookup ). The user will have the option to paste the entire row 
	into a line item ( freight/acces ) or to paste just the rate and rate type.
		
	Args: 
			Bool createNew,
								TRUE
									will create a new line item of the type indicated by the selection 
									the user made from the selection window, and paste the requsted 
									info into the details of the new item.
								
								FALSE
									will not create a line item bit will instead paste the requested 
									info into the current items details, provided the types match 
									(freight/acces).
									
		Note: there is no error notification to the user since the processes success can 
			   be evaluated by the user.
								
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

Created Aug 16 2000   <<*>> RPZ
								


*/

String 	ls_Pasting
String 	ls_Continue 
Boolean	lb_Continue = TRUE
Boolean	lb_PasteDescription = TRUE
Long		ll_ItemIndex
Long		ll_CurrentRow
String	ls_ItemType
String	ls_SetItemType
String	ls_Description
String	ls_TargetDescription 
Dec		ldec_Discount
DataStore	lds_Temp

Int	li_SetRtn

n_cst_Beo_Item			lnv_Item
n_cst_Beo_Item			lnv_SetItem

lnv_Item = CREATE n_cst_beo_Item
lnv_Setitem = CREATE n_cst_beo_Item

n_cst_Rate_Attribs lnv_RateAttribs
n_cst_privileges 	 lnv_Privs

n_cst_Msg	lnv_Msg	
S_Parm		lstr_Parm


lstr_Parm.is_Label = "ITEMBEO"
lstr_Parm.ia_Value = lnv_Item
lnv_Msg.of_Add_Parm ( lstr_Parm )

// this determines if the shipment can be modified

IF isValid (inv_shipment) THEN
	IF inv_Shipment.of_AllowItemEdit (  ) THEN
	ELSE
		lb_Continue = FALSE
		MessageBox( "Alter Shipment" , "You are not authorized to perform this function.")
	END IF
ELSE 
	lb_Continue = FALSE
END IF


IF lb_Continue THEN

	Open ( w_Rate_Selection  )
	
	lnv_Msg = Message.powerObjectParm
	
	IF IsValid ( lnv_Msg ) THEN
		
		IF lnv_Msg.of_Get_Parm ( "CONTINUE" , lstr_Parm ) <> 0 THEN
			ls_Continue = lstr_Parm.ia_Value
		END IF
		
		IF lnv_Msg.of_Get_Parm ( "ITEMINDEX" , lstr_Parm ) <> 0 THEN
			IF IsNull  ( lstr_Parm.ia_Value ) THEN
				lb_Continue = FALSE
				messageBox ( "Item Index" , "The item index is null." )
			ELSE
				ll_ItemIndex = lstr_Parm.ia_Value
			END IF
		ELSE
			lb_continue = FALSE
		END IF
		
		IF lnv_Msg.of_Get_Parm ( "PASTING" , lstr_Parm ) <> 0 THEN
			ls_Pasting = lstr_Parm.ia_Value
		Else
			lb_Continue = FALSE
		END IF
		
	ELSE
		lb_Continue = FALSE	
	END IF
END IF

IF lb_Continue THEN
	CHOOSE CASE ls_Continue
		CASE "TRUE" // row selected, continue and paste
			lb_Continue = TRUE
		CASE "FALSE" // user selected cancel
			lb_Continue = FALSE
		CASE "QUERY" // user selected new query
			lb_Continue = FALSE
	END CHOOSE
END IF	

IF lb_Continue THEN	
	
	//	lnv_item is the cache
	// the source datastore is retreived from the lnv_RateAttribs object
	lnv_Item.of_SetSource ( lnv_RateAttribs.of_GetDataStore ( ) )
	lnv_Item.of_SetSourceID (ll_ItemIndex)
	ls_ItemType = lnv_Item.of_GetType ( )
	ls_Description =  lnv_Item.of_GetDescription( )
	
	// get the discount from the selected row on the selection ds
	ll_CurrentRow = lnv_RateAttribs.of_GetCurrentRow( )
	lds_Temp  = lnv_RateAttribs.of_GetDataStore( )
	IF isValid ( lds_Temp ) AND ll_CurrentRow > 0 THEN
		ldec_Discount = lds_Temp.GetItemNumber ( ll_CurrentRow,  "ds_disc_pct")
	END IF
	
	IF ab_createnew THEN  
		IF lnv_Item.of_IsFreight ( ) THEN
			IF wf_Add_Item ( "FREIGHT!") <> 1 THEN
				lb_Continue = FALSE
			END IF
		ELSE
			IF wf_Add_Item ( "ACCESS!") <> 1 THEN
				lb_Continue = FALSE
			END IF
		END IF
	END IF

	IF lb_Continue THEN
		
		// lnv_SetItem is the target shipment item the properties will be set on
		lnv_SetItem.of_SetSource ( dw_item_details )
		lnv_SetItem.of_SetSourceRow ( dw_item_details.GetRow ( ) )
		lnv_SetItem.of_SetShipment ( inv_Shipment )
		ls_SetItemType = lnv_SetItem.of_GetType ( )
		ls_TargetDescription = lnv_SetItem.of_GetDescription( )
		
		IF ls_ItemType = ls_SetItemType THEN
			CHOOSE CASE ls_Pasting
				CASE "ROW" 
					
					
					li_SetRtn = lnv_SetItem.of_SetRateType ( lnv_Item.of_GetRateType( ) )					
					li_SetRtn = lnv_SetItem.of_SetMiles ( lnv_Item.of_GetMiles( ) )
					li_SetRtn = lnv_SetItem.of_SetQuantity ( lnv_Item.of_GetQuantity( ) )
					li_SetRtn = lnv_SetItem.of_SetTotalWeight ( lnv_Item.of_GetTotalWeight( ) )
					li_SetRtn = lnv_SetItem.of_SetRate ( lnv_Item.of_GetRate( ) ) 
					li_SetRtn = lnv_SetItem.of_SetHazmat ( lnv_Item.of_GetHazmat( ) )
					li_SetRtn = lnv_SetItem.of_SetDescription ( ls_Description )
					
					IF isValid (inv_shipment) AND ldec_discount > 0 THEN
						IF inv_Shipment.of_GetDiscountPercent() <> ldec_discount THEN
							IF MessageBox ("Applied Discount" ,"Do you want to apply the discount of "+ String( ldec_discount * 100, "0.0##")+ "% to the shipment?", QUESTION!, YESNO! , 1 ) = 1 THEN
								inv_shipment.of_SetDiscountPercent( ldec_discount )
							END IF
						END IF
					END IF
				
				CASE "RATE"
					
					li_SetRtn = lnv_SetItem.of_SetRateType ( lnv_Item.of_GetRateType( ) )
					li_SetRtn = lnv_SetItem.of_SetRate ( lnv_Item.of_GetRate( ) )
					dw_Item_details.SetItem ( lnv_SetItem.of_GetSourcerow( ) , "di_our_rate" , lnv_Item.of_GetRate( ) )
					 
					IF lnv_SetItem.of_HasDescription( ) THEN
						IF Trim ( ls_TargetDescription ) <> Trim (ls_Description) THEN 
							IF MessageBox( "Paste Description" , "Do you want to paste the new description? (" + ls_Description + ")" , QUESTION! ,YESNO!, 1 ) = 2 THEN
								lb_PasteDescription = FALSE
							END IF
						END IF
					END IF
				
					IF lb_PasteDescription THEN
						lnv_SetItem.of_SetDescription ( ls_Description )
						lnv_SetItem.of_SetHazmat ( lnv_Item.of_GetHazmat( ) )
					END IF
					
					IF isValid (inv_shipment) AND ldec_discount > 0 THEN
						IF inv_Shipment.of_GetDiscountPercent() <> ldec_discount THEN
							IF MessageBox ("Applied Discount" ,"Do you want to apply the discount of "+ String( ldec_discount * 100, "0.0##")+ "% to the shipment?", QUESTION!, YESNO! , 1 ) = 1 THEN
								inv_shipment.of_SetDiscountPercent( ldec_discount )
							END IF
						END IF
					END IF
			
			END CHOOSE
			
		ELSE
			MessageBox ( "Item Selection" ,"The type of the item you selected does not match the current item type.")
		END IF
		
	END IF
END IF


// the user has the option to perform a new query from the selection window.
// this will process that request.
IF ls_continue = "QUERY" THEN
	Post 	wf_Process_Request ( "RATEQUERY!" )
END IF

DESTROY ( lnv_Item ) 
DESTROY ( lnv_SetItem ) 

end event

event ue_autoroute;
Return This.wf_AutoRoute( ) 	//RDT 8-13-03 

//RDT 8-13-03 new call to wf_autoRoute replaces all code below

////Returns:  1 = Success, 0 = User Cancelled - No action, -1 = Failure
//Int 		i
//Integer	li_LegSelection
//
//Long		ll_EventCount, &
//			ll_EquipmentId, &
//			ll_InsertionEventId, &
//			lla_DriverIds[], &
//			lla_EquipmentIds[], &
//			lla_EventIds[], &
//			lla_Blank[], &
//			ll_Index, &
//			ll_Null, &
//			ll_routablecount, &
//			ll_ConfirmedCount, &
//			ll_RoutedCount 
//			
//String	ls_RouteType, &
//			ls_SelectionCategory
//Integer	li_ItinType, &
//			li_InsertionStyle, &
//			li_Null
//Date		ld_ItinDate
//Boolean	lb_HasRouteEquipment
//
//s_eq_info					lstr_Equip
//s_Anys						lstr_OpenParms, &
//								lstr_Selection
//n_cst_Msg					lnv_Msg
//s_Parm						lstr_Parm
//n_cst_bso_RouteManager	lnv_RouteManager
//n_cst_bso_Dispatch		lnv_Dispatch
//n_cst_EquipmentManager	lnv_EquipmentManager
//n_cst_LicenseManager		lnv_LicenseManager
//n_cst_beo_Event			lnva_Events[], &
//								lnva_RoutableEvents[], &
//								lnva_BlankEvent[]
//n_cst_OFRError				lnva_Errors[]
//
//String	ls_ErrorMessage = "Could not process request."
//Integer	li_Return = 1
//
//SetNull ( li_Null )
//SetNull ( ll_Null )
//lnv_Dispatch = This.wf_GetDispatchManager ( )
//
//
//
//
////Have user select LegSelection
////
////IF li_Return = 1 THEN
////
////	Open ( w_SelectAutoRouteStyle )
////
////	IF IsValid ( Message.PowerObjectParm ) THEN
////		lnv_Msg = Message.PowerObjectParm
////	ELSE
////		li_Return = 0  //User Cancelled in the dialog.
////	END IF
////
////END IF
//
//
//
///*
//	We are going to do the following processing up to twice
//	the first will be to attempt to use the auto route system settings, If the settings don't
//	work then we will go through again, this time opening the window
//
//*/
//
//// Set up the message Object to ask for the system settings
//// of_GetAutoRouteParms will reset the msg obj, so if we do this outside the loop
//// then next time the method gets called the parm won't exist and the window will open
//lstr_Parm.is_Label = "USESETTINGS"
//lstr_Parm.ia_Value = TRUE
//lnv_Msg.of_Add_Parm ( lstr_Parm )
//
//
//FOR i = 1 To 2 
//
//	lnva_RoutableEvents = lnva_BlankEvent
//	ll_routablecount = 0
//	lla_EventIds = lla_blank
//	
//	CHOOSE CASE lnv_RouteManager.of_GetAutoRouteParms ( lnv_Msg )
//			
//		CASE 1 // Success
//			// since we will be coming here twice we want to make sure we only set the
//			// return back to 1 if it was 0
//			IF li_return <> -1 THEN				
//				li_Return = 1  
//			END IF
//		CASE 0  // if it is the 1st time through and we get 0 that means the 
//					// settings are not valid, therefore we will CONTINUE and have the 
//					// selection window open
//					// ??? Do we want to tell them that the settings are not valid ???
//					// IF it is the 2nd time through and we get a zero then the user canceled
//					// in either case it it safe to ser li_return = 0 and continue
//			li_Return = 0
//			CONTINUE
//		CASE ELSE // -1
//					 // this is unexpected so we will flag failure and bail
//			li_Return = -1
//			EXIT
//			
//	END CHOOSE
//			
//		
//	IF li_Return = 1 THEN
//	
//		IF lnv_Msg.of_Get_Parm ( "Leg", lstr_Parm ) > 0 THEN
//			li_LegSelection = lstr_Parm.ia_Value
//		ELSE
//			li_Return = -1
//		END IF
//	
//		IF lnv_Msg.of_Get_Parm ( "RouteType", lstr_Parm ) > 0 THEN
//			ls_RouteType = lstr_Parm.ia_Value
//		ELSE
//			SetNull ( ls_RouteType )
//		END IF
//	
//	END IF
//	
//	
//	//Based on the LegSelection, get the appropriate event list.
//	
//	IF li_Return = 1 THEN
//	
//		CHOOSE CASE li_LegSelection
//	
//		CASE IS > 0  //A specific leg was selected
//	
//			ll_EventCount = inv_Shipment.of_GetLegEventList ( li_LegSelection, lnva_Events )
//	
//		CASE 0  //All Legs
//	
//			ll_EventCount = inv_Shipment.of_GetEventList ( lnva_Events )
//	
//		CASE ELSE  //Unexpected LegSelection.
//	
//			li_Return = -1
//	
//		END CHOOSE
//	
//	END IF
//	
//	
//	//Check that there are events in the leg selected.
//	
//	IF li_Return = 1 THEN
//	
//		IF ll_EventCount > 0 THEN
//			//OK
//		ELSE
//			ls_ErrorMessage = "There are no events in the leg indicated."
//			li_Return = -1
//		END IF
//	
//	END IF
//	
//	//remove non_routable events from the list
//	
//	IF li_Return = 1 THEN
//		
//		FOR ll_Index = 1 to ll_EventCount
//			
//			IF lnva_Events [ ll_Index ].of_GetRoutable ( ) = 'F' THEN
//				//don't include
//			else
//				ll_routablecount ++
//				lnva_RoutableEvents[ll_routablecount] = lnva_Events [ ll_Index ]
//			END IF
//			
//		NEXT
//		
//		lnva_Events = lnva_BlankEvent
//		lnva_Events = lnva_RoutableEvents
//		ll_EventCount = upperbound(lnva_Events)
//		
//	END IF
//	
//	//Pull the event ids from the event list, and count how many are confirmed and routed
//	
//	IF li_Return = 1 THEN
//
//		ll_ConfirmedCount = 0
//		ll_RoutedCount = 0
//	
//		FOR ll_Index = 1 TO ll_EventCount
//	
//			lla_EventIds [ ll_Index ] = lnva_Events [ ll_Index ].of_GetId ( )
//
//			IF lnva_Events [ ll_Index ].of_IsConfirmed ( ) THEN
//
//				ll_ConfirmedCount ++
//
//			END IF
//			
//			IF lnva_Events [ ll_Index ].of_IsRouted( ) THEN
//
//				ll_RoutedCount ++
//				
//			END IF
//	
//		NEXT
//
//
//		IF i = 2 AND ll_ConfirmedCount > 0 THEN   //This is a rush job, and I'm not comfortable putting this
//				//down below also for i = 1 AND lb_HasRouteEquipment = TRUE .  This should be looked into, though. --BKW
//
//			IF MessageBox ( "Auto-Route CONFIRMED Events", String ( ll_ConfirmedCount ) + " Event(s) in the leg you have "+&
//				"selected are already routed and confirmed complete.  ARE YOU SURE YOU WANT TO REMOVE THESE "+& 
//				"ROUTING CONFIRMATIONS AND ASSIGN THESE EVENTS TO SOMEONE ELSE?", Exclamation!, OKCancel!, 2 ) = 2 THEN
//
//				li_Return = 0  //Action cancelled by user.
//
//			END IF
//
//		END IF
//		
//		IF li_Return = 1 THEN
//			IF i = 2 AND ll_RoutedCount > 0 THEN   //This is a rush job too
//	
//				IF MessageBox ( "Auto-Route ROUTED Events", String ( ll_RoutedCount ) + " Event(s) in the leg you have "+&
//					"selected are already routed.  ARE YOU SURE YOU WANT TO "+& 
//					"ASSIGN THESE EVENTS TO SOMEONE ELSE?", Exclamation!, OKCancel!, 2 ) = 2 THEN
//	
//					li_Return = 0  //Action cancelled by user.
//	
//				END IF
//	
//			END IF
//		END IF
//		
//		
//	
//	END IF
//	
//	
//	//Make the selection of equipment, date, and perform the auto routing.
//	
//	IF li_Return = 1 THEN
//	
//		IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_RouteManager ) AND &
//			NOT IsNull ( ls_RouteType ) THEN
//	
//			ll_EquipmentId = lnv_RouteManager.of_GetRouteEquipmentId ( lnva_Events, ls_RouteType )
//		
//			IF lnv_Dispatch.of_GetEquipmentInfo ( ll_EquipmentId, lstr_Equip ) = 1 THEN
//				lb_HasRouteEquipment = TRUE
//				lla_EquipmentIds [ UpperBound ( lla_EquipmentIds ) + 1 ] = ll_EquipmentId
//			END IF
//	
//		END IF
//	
//	
//		// IF This is the first time in the loop we and we don't have equipment then we will
//		// continue so we can have the user select different rout type and leg info
//		IF i = 1 AND lb_HasRouteEquipment THEN
//			EXIT
//		END IF
//	
//	END IF
//
//NEXT
//
//n_cst_Events	lnv_Events
//Int	li_MsgRtn
//
//IF li_Return = 1 THEN
//	IF lnv_Events.of_HasNonRoutableMarkedEvents( lla_EventIds , lnv_Dispatch.of_GetEventCache ( ) ) THEN
//		li_MsgRtn = MessageBox ( "Route Events" , "You have asked to route events that have been marked as Non-Routable. Are you sure you want to do this?" ,Question!, YesNO! , 2) 
//		CHOOSE CASE li_MsgRtn
//			CASE  1  // mark as routable and continue
//				lnv_Events.of_MarkAllEventsAsRoutable (lla_EventIds , lnv_Dispatch.of_GetEventCache ( ) )				
//			CASE 2 // bail
//				li_Return = 0
//		END CHOOSE					
//	END IF
//END IF
//
//IF li_Return = 1 THEN
//	//NEED DATE LOGIC!!!!!?????
//	ld_ItinDate = Date ( DateTime ( Today ( ) ) )
//
//	IF lb_HasRouteEquipment THEN
//		lstr_OpenParms.Anys [ 1 ] = lnv_EquipmentManager.of_GetItinType ( lstr_Equip.eq_Type )
//	ELSE
//		lstr_OpenParms.Anys [ 1 ] = li_Null //Use Default
//	END IF
//	lstr_OpenParms.anys[2] = "ALL_SHIPS" //changed from "ROUTED_ONLY" in 3.0.02
//	lstr_OpenParms.anys[3] = ld_ItinDate
//	lstr_OpenParms.anys[4] = ll_Null  //Dead Parameter
//	lstr_OpenParms.anys[5] = "PASS"
//	lstr_OpenParms.anys[6] = lla_DriverIds
//	lstr_OpenParms.anys[7] = lla_EquipmentIds
//	lstr_OpenParms.anys[8] = w_disp.ds_emp  //??
//	lstr_OpenParms.anys[9] = lnv_Dispatch.of_GetEquipmentCache ( )
////	lstr_OpenParms.Anys [ 10 ] = lla_ShipmentIds
////	lstr_OpenParms.Anys [ 11 ] = lla_TripIds
//	
//	openwithparm(w_itin_select, lstr_OpenParms)
//	lstr_Selection = message.powerobjectparm
//
//	ls_SelectionCategory = lstr_Selection.anys[1]
//
//	IF ls_SelectionCategory = "ITIN" THEN
//		
//		li_ItinType = lstr_Selection.anys[2]
//		ll_EquipmentId = lstr_Selection.anys[3]
//
//		//Note:  This date will be null if user selected a trip.  That's ok for EndOfRoute style.
//		ld_ItinDate = lstr_Selection.anys[4]
//		ld_ItinDate = Date ( DateTime ( ld_ItinDate ) )
//
//		li_InsertionStyle = gc_Dispatch.ci_InsertionStyle_EndOfRoute
//		SetNull ( ll_InsertionEventId )
//
//		SetPointer ( HourGlass! )
//
//		CHOOSE CASE lnv_Dispatch.of_Route ( lla_EventIds, li_ItinType, ll_EquipmentId, &
//			ld_ItinDate, 0 /*DateScaleStyle!*/, ll_InsertionEventId, li_InsertionStyle )
//
//		CASE 1  //Success
//			This.wf_JumpShipment ( inv_Shipment.of_GetId ( ), TRUE /*Force redisplay*/ )
//
//		CASE 0  //User cancelled
//			li_Return = 0
//
//		CASE -1
//			li_Return = -1
//
//			IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
//				//There are errors to process -- Get the error text
//				IF Len ( lnva_Errors[1].GetErrorMessage ( ) ) > 0 THEN
//					ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
//				END IF
//				//Now that we've got what we need, we MUST clear the error list.
//				lnv_Dispatch.ClearOFRErrors ( )
//			END IF
//
//		CASE ELSE  //Unexpected return value
//			//Force redisplay in case any changes were made for this unknown return value
//			This.wf_JumpShipment ( inv_Shipment.of_GetId ( ), TRUE /*Force redisplay*/ )
//			li_Return = -1
//
//		END CHOOSE
//
//	END IF
//
//
//END IF
//
//
//IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
//	MessageBox ( "Auto Route", ls_ErrorMessage, Exclamation! )
//END IF
//
//FOR i = 1 TO ll_EventCount 
//	DESTROY ( lnva_Events[ i ] )
//NEXT
//
//RETURN li_Return
end event

event ue_addleasecharges;Long			ll_EventCount
Long			i
Long			lla_Event[]
Long			lla_Linked[]
Long			lla_ParentLinked[]
Long			lla_ParentEvent[]
Boolean		lb_AppendToArray = TRUE
Boolean		lb_Continue
Long			ll_ShipID 
Long			ll_ParentID

Constant	String	cs_FlatRateType = "F"

n_cst_beo_Item					lnv_NewItem
n_cst_Beo_EquipmentLease	lnv_CurrentLease
n_cst_beo_EquipmentLease	lnva_Lease[]
n_cst_beo_Equipment			lnv_Equipment
n_cst_bso_Dispatch			lnv_Dispatch
n_cst_beo_Shipment			lnv_Shipment
n_cst_Beo_Event				lnva_Events [] 
n_cst_Msg	lnv_msg
S_Parm		lstr_parm

lnv_Shipment = CREATE n_cst_beo_Shipment
lnv_NewItem = CREATE n_cst_beo_Item

lnv_Dispatch = THIS.wf_GetDispatchManager ( )

ll_ShipID = inv_Shipment.of_GetID ( )
ll_ParentID = inv_Shipment.of_GetParentID ( )

ll_EventCount = inv_shipment.of_GetEventList ( lnva_Events )
//  get the equipment linked through the events
For i = 1 TO ll_EventCount 
	lnva_Events[i].of_getContainerList ( lla_Event, lb_AppendToArray   )
	lnva_Events[i].of_getTrailerList ( lla_Event, lb_AppendToArray )	
NEXT


// get the equipment linked to this shipment
lnv_Dispatch.of_GetEquipmentForShipment ( ll_ShipID , lla_Linked ) 


// get the equipment linked to the parent shipment ( if one exists )
IF ll_ParentID > 0 THEN
	lnv_Dispatch.of_GetEquipmentForShipment ( ll_ParentID ,lla_ParentLinked ) 
END IF

// get the equipment linked to the events of the parent
lnv_Dispatch.of_RetrieveShipment ( ll_ParentID )
lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache () )
lnv_Shipment.of_SetsourceID ( ll_ParentID )
ll_EventCount = lnv_shipment.of_GetEventList ( lnva_Events )

FOR i = 1 TO ll_EventCount 
	lnva_Events[i].of_getContainerList ( lla_ParentEvent, lb_AppendToArray   )
	lnva_Events[i].of_getTrailerList ( lla_ParentEvent, lb_AppendToArray )	
NEXT


lstr_Parm.is_Label = "EVENT"
lstr_Parm.ia_Value = lla_Event
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "LINKED"
lstr_Parm.ia_Value = lla_Linked
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "PARENTEVENT"
lstr_Parm.ia_Value = lla_ParentEvent
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "PARENTLINKED"
lstr_Parm.ia_Value = lla_ParentLinked
lnv_Msg.of_Add_Parm ( lstr_Parm )

OpenWithParm ( w_Equipment_Lease_Charges , lnv_Msg )

lnv_msg = Message.powerObjectParm 

IF lnv_msg.of_Get_Parm ( "CONTINUE" , lstr_Parm ) <> 0 THEN
	lb_Continue = lstr_Parm.ia_Value 
END IF

IF lb_Continue  THEN
	inv_Shipment.of_AddLeaseCharges ( lnv_Dispatch , lnv_Msg )
END IF

DESTROY lnv_Shipment 
DESTROY lnv_NewItem 

end event

event ue_revenuesplits;n_cst_msg	lnv_msg
s_Parm		lstr_Parm
w_RevenueManager		lw_Revenue
n_cst_Bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = inv_Shipment
lnv_Dispatch = w_disp.wf_GetDispatchManager ( )

IF IsValid ( lnv_Dispatch ) THEN
	lstr_Parm.is_Label = "DISPATCHOBJECT"
	lstr_Parm.ia_Value = lnv_Dispatch
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "FREIGHT"
	lstr_Parm.ia_Value = lnv_Shipment.of_GetNetFreightCharges ( )
	//lstr_Parm.ia_Value = dw_ship_info.object.ds_lh_totamt[1] - dw_ship_info.object.ds_disc_amt[1]
	lnv_Msg.of_Add_Parm ( lstr_Parm )

	lstr_Parm.is_Label = "ACCESSORIAL"
	lstr_Parm.ia_Value = lnv_Shipment.of_GetAccessorialCharges ( )
	//lstr_Parm.ia_Value = dw_ship_info.object.ds_ac_totamt[1]
	lnv_Msg.of_Add_Parm ( lstr_Parm )
		
	OpenWithParm ( lw_Revenue , lnv_Msg )
	
END IF


end event

event ue_showequipment();n_cst_Msg	lnv_msg
S_Parm		lstr_Parm
Long			ll_ShipID

String	lsa_oldEqRef[]
String	lsa_newEqRef[]
String	lsa_oldType[]
String	lsa_newType[]
Long		ll_index
Long		ll_max
U_dw_oeBasics	ldw_eq

ll_ShipID =  inv_Shipment.of_GetID ( )

IF ll_ShipID > 0 THEN
	lstr_Parm.is_Label = "SHIPMENT"
	lstr_PArm.ia_Value = ll_ShipID
	lnv_Msg.Of_Add_PArm ( lstr_Parm )
	
	lstr_Parm.is_Label = "RELOADS"
	lstr_PArm.ia_Value = TRUE
	lnv_Msg.Of_Add_PArm ( lstr_Parm )

	lstr_Parm.is_Label = "DISPATCH"
	lstr_PArm.ia_Value = THIS.wf_GetDispatchManager ( )
	lnv_Msg.Of_Add_PArm ( lstr_Parm )
	
	//ADDED BY DAN 2-1-07
	lstr_Parm.is_Label = "SHIPMENTBEO"
	lstr_PArm.ia_Value = inv_shipment
	lnv_Msg.Of_Add_PArm ( lstr_Parm )
	/* taken out for now until i can come back to it
	ldw_eq = uo_intermodalview.tab_intermodal.tabpage_shipment.uo_equipment.uo_eqinfo.dw_oe
	ll_max = ldw_eq.rowcount()

	FOR ll_index = 1 TO ll_max
		lsa_oldEqRef[ll_index] = ldw_eq.getItemString(ll_index,"eq_ref")
		lsa_oldType[ll_index] = ldw_eq.getItemsTring(ll_index, "intermodalequipment_type")
	NEXT
*/
	//////////////////
	OpenWithParm ( w_LinkedEquipment , lnv_Msg )
	
	//Added By Dan 2-26-07, to cascade the values of any equipment that may be new.

	uo_intermodalview.event ue_syncequipment( )
	uo_intermodalview.event ue_refreshequipment( )
/* taken out for now until i can come back to it
	ll_max = ldw_eq.rowcount()
	FOR ll_index = 1 TO ll_max
		lsa_newEqRef[ll_index] = ldw_eq.getItemString(ll_index,"eq_ref")
		lsa_newType[ll_index] = ldw_eq.getItemsTring(ll_index, "intermodalequipment_type")
	NEXT
	
	FOR ll_index = 1 TO ll_max
		IF lsa_oldEqRef[ll_index] <> lsa_newEqRef[ll_index] OR (isNULL( lsa_oldEqRef[ll_index]) AND not isNull(lsa_newEqRef[ll_index]) ) THEN 	
			ldw_eq.event ue_eqrefchanged( lsa_oldEqRef[ll_index], lsa_newEqRef[ll_index] , ll_index )
		END IF
		IF lsa_oldType[ll_index] <> lsa_newType[ll_index] OR (isNULL( lsa_oldType[ll_index]) AND not isNull(lsa_newType[ll_index]) )THEN
			ldw_eq.event ue_eqtypechanged( ll_index, lsa_newType[ll_index])
		END IF
	NEXT
*/
	//////////////////////////////////////

END IF
end event

event ue_showedilist();w_EDILog		lw_EDILog
n_cst_msg	lnv_msg 
s_parm		lstr_parm

lstr_Parm.is_label = "SHIPMENTIDS"
lstr_Parm.ia_value =  {inv_Shipment.of_GetId()}
lnv_msg.of_Add_Parm( lstr_Parm )
			
opensheetwithparm(lw_EDILog, lnv_Msg, gnv_App.of_GetFrame ( ), 0, Original! )

end event

event ue_addeventnote;S_Parm	lstr_parm
w_EventNoteWizard	lw_EventNote
String	ls_Event
Long		ll_FindRow
any		la_Value
n_cst_Settings	lnv_Settings


IF anv_Msg.of_Get_Parm ( "EVENT" , lstr_Parm ) <> 0 THEN
	ls_Event = lstr_Parm.ia_Value
END IF

lnv_Settings.of_GetSetting ( 86 , la_Value )

IF String ( la_Value )  =  "YES!" THEN

	CHOOSE CASE UPPER ( ls_Event )
			
		CASE "CHASSIS"
			IF UpperBound ( ala_ids ) > 0 THEN
				ll_FindRow = uo_events.of_Find ( "de_id = " + String ( ala_ids [ UpperBound ( ala_ids ) ] ) )
				
				IF ll_FindRow > 0 THEN
					//dw_ship_itin.SelectRow ( 0 , FALSE )				
					//dw_ship_itin.SetRow ( ll_FindRow )
					dw_event_details.Event ue_AddEventNote ( ll_FindRow ,"CHASSIS" ) 
				END IF
			END IF
			
		CASE "YARD"
			IF UpperBound ( ala_ids ) > 0 THEN
				ll_FindRow = uo_events.of_Find ( "de_id = " + String ( ala_ids [ 1 ] ) )
				
				IF ll_FindRow > 0 THEN
					//dw_ship_itin.SelectRow ( 0 , FALSE )
					//dw_ship_itin.SetRow ( ll_FindRow )
					dw_event_details.Event ue_AddEventNote ( ll_FindRow ,"YARD" ) 
				END IF
				THIS.Post Event ue_AddedEvent()
			END IF
	END CHOOSE
			
	
END IF
end event

event ue_setfocusoneventlist;IF isValid ( w_EventList ) THEN
	IF w_EventList.Visible THEN
		w_eventList.SetFocus ( )
	END IF
END IF
end event

event ue_addedevent;POST event ue_setFocusoneventlist ( )
end event

event ue_autorate;integer	li_return = 1

long 	ll_ratedatacount, &
		ll_ndx
		
boolean	lb_recalc, &
			lb_destroy
string	ls_errormessage

n_cst_RateData		lnva_rateData[]
n_cst_LicenseManager	lnv_LicenseManager

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating  ) THEN

	//check for passed rate data objects from billing window
	if upperbound(w_disp.inva_ratedata) > 0 then
		//passed in
		lnva_rateData = w_disp.inva_ratedata
		lb_destroy=false
	else
		inv_shipment.of_autoratecombined(lnva_ratedata)
		lb_destroy=true
	end if
	
	inv_shipment.of_ApplyFreightRate(lnva_ratedata, '', lb_recalc)
	ll_ratedatacount = upperbound(lnva_ratedata)
	if lb_destroy then
		for ll_ndx = 1 to ll_ratedatacount
			destroy lnva_rateData[ll_ndx]
		next
	end if
END IF


end event

event ue_applyautorate;long 	ll_itemcount, &
		ll_ratedatacount, &
		ll_ndx, &
		ll_ndx2, &
		ll_mimaxndx, &
		ll_updatecount
		
string	ls_ratetype, &
			ls_minmaxratetype
			
decimal	lc_rate, &
			lc_count, &
			lc_amount
boolean	lb_minimum, &
			lb_maximum, &
			lb_replacenonetype, &
			lb_createdratedata
			
//n_cst_beo_item			lnva_item[]

ll_ratedatacount = upperbound(anva_ratedata)

//when applying minimum and maximum rates, only populate the first freight item, zero out the rest

//apply rates 
//ll_itemcount = inv_shipment.of_getitemlist(lnva_item)
ll_itemcount = upperbound(anva_item)
for ll_ndx = 1 to ll_itemcount
	anva_item[ll_ndx].of_SetShipment ( inv_shipment )
	if anva_item[ll_ndx].of_gettype() = 'L' then
		ls_ratetype = anva_item[ll_ndx].of_getratetype()
		
		for ll_ndx2 = 1 to ll_ratedatacount 
			
			if len(trim(anva_ratedata[ll_ndx2].of_getratetype())) = 0 then
				continue
			end if
			
			//if there is only one ratedata object then change the rate type on the 
			//item detail to the same as the ratedata ratetype
			if ll_ratedatacount = 1 then
				ls_ratetype = anva_ratedata[ll_ndx2].of_getratetype()
				anva_item[ll_ndx].of_setratetype(anva_ratedata[ll_ndx2].of_getratetype())
			end if
			
			//check for 'NONE' rate types
			if anva_ratedata[ll_ndx2].of_getratetype() = ls_ratetype or & 
				(ls_ratetype = appeon_constant.cs_RateUnit_Code_None and &
					anva_ratedata[ll_ndx2].of_replacenonetype()) then
					
				IF ls_ratetype = appeon_constant.cs_RateUnit_Code_None and &
					anva_ratedata[ll_ndx2].of_replacenonetype() THEN
					ls_ratetype = anva_ratedata[ll_ndx2].of_getratetype()
					lb_replacenonetype = true
				end if
				
				//setting the rate type to the table breakunit
				if anva_ratedata[ll_ndx2].of_replacenonetype() then
					anva_item[ll_ndx].of_setratetype(anva_ratedata[ll_ndx2].of_getratetype())
				end if
				if anva_ratedata[ll_ndx2].of_useminimum() then
					anva_item[ll_ndx].of_setratetype(appeon_constant.cs_RateUnit_Code_Minimum)
					lb_minimum = true
					ls_minmaxratetype = ls_ratetype
				elseif anva_ratedata[ll_ndx2].of_usemaximum() then
					anva_item[ll_ndx].of_setratetype(appeon_constant.cs_RateUnit_Code_Maximum)
					lb_maximum = true
					ls_minmaxratetype = ls_ratetype
				end if
				lc_rate = anva_ratedata[ll_ndx2].of_getrate()
				anva_item[ll_ndx].of_setrate(lc_rate)
				ll_updatecount ++
				exit
			end if
		next
		
		//set rest of type for minmax
		//look ahead for rest of this ratetype and set to blank so it won't be rated
		if lb_minimum or lb_maximum then
			for ll_mimaxndx = ll_ndx + 1 to ll_itemcount
				//amount and type set on first freight item only
				ls_ratetype = anva_item[ll_mimaxndx].of_getratetype()
				if ls_ratetype = ls_minmaxratetype or &
					(ls_ratetype = appeon_constant.cs_RateUnit_Code_None and lb_replacenonetype) then
					if anva_item[ll_mimaxndx].of_gettype() = 'L' then
						anva_item[ll_mimaxndx].of_setratetype('')
						anva_item[ll_mimaxndx].of_setrate(0)
						ll_updatecount ++
					end if
				end if
			next
			exit
		end if		
		
	end if
	
next

//IF ll_updatecount = 0 THEN
//	messagebox("Auto Rate", "No Item(s) have a rate type that matches the Rate table you selected.")
//END IF

end event

event ue_splitfront;String	ls_SelectedType
Long		ll_SiteID
Long		ll_InsertionPoint
s_Parm	lstr_Parm
n_cst_Msg	lnv_Msg

ll_insertionPoint = 1
ls_SelectedType = String ( Message.LongParm , "address" )

lstr_Parm.is_Label = "SPLITFRONT"
lstr_Parm.ia_Value = TRUE
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "SPLITBACK"
lstr_Parm.ia_Value = FALSE
lnv_Msg.of_Add_Parm ( lstr_Parm )

ll_SiteId = THIS.wf_GetCoIdFromCode ( ls_SelectedType )

THIS.Event ue_SiteMove ( ll_insertionPoint , ll_SiteId , lnv_Msg )
end event

event ue_splitback;String	ls_SelectedType
Long		ll_SiteID
Long		ll_InsertionPoint

S_Parm		lstr_Parm
n_cst_msg	lnv_Msg

n_cst_bso_Dispatch	lnv_Dispatch

lnv_Dispatch = wf_GetDispatchManager ( )

ll_InsertionPoint = inv_Shipment.of_GetEventCount ( ) 
ll_InsertionPoint ++
ls_SelectedType = String ( Message.LongParm , "address" )

lstr_Parm.is_Label = "SPLITBACK"
lstr_Parm.ia_Value = TRUE
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "SPLITFRONT"
lstr_Parm.ia_Value = FALSE
lnv_Msg.of_Add_Parm ( lstr_Parm )

ll_SiteId = THIS.wf_GetCoIdFromCode ( ls_SelectedType )

THIS.Event ue_SiteMove ( ll_InsertionPoint , ll_SiteId ,lnv_Msg )

end event

event ue_sitemove;Long		ll_SiteID
Long		lla_NewIds[]
Long		ll_InsertionPoint
Boolean	lb_Continue = TRUE

S_PArm	lstr_Parm

n_Cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch

ll_InsertionPoint = al_insertionpoint
lnv_Dispatch = wf_GetDispatchManager ( )

lstr_Parm.is_Label = "ROWCOUNT"
lstr_Parm.ia_Value = uo_events.of_GetEventCount ( )
anv_msg.of_Add_Parm ( lstr_Parm )

ll_SiteID = al_site
IF ll_SiteID = -1  THEN
	IF MessageBox ( "New Site" , "The company reference could not be resolved. Do you want to continue anyway?" , QUESTION! , YESNO! , 2 ) = 2 THEN
		lb_Continue = FALSE
	END IF
END IF

IF lb_Continue THEN
	IF inv_Shipment.of_AddSiteMove ( ll_SiteID , ll_InsertionPoint , lnv_Dispatch , lla_NewIds,anv_msg ) = 1 THEN
		numevents += UpperBound ( lla_NewIds )
		IF anv_msg.of_Get_Parm  ( "EVENT" , lstr_Parm ) <> 0 THEN
			THIS.TriggerEvent  ( String ( lstr_Parm.ia_Value ) )
			THIS.Post Event ue_AddEventNote (anv_msg , lla_NewIDS )
		END IF
	END IF
END IF

//IF lnv_Msg.of_Get_Parm ( "EVENT" , lstr_Parm ) <> 0 THEN
//		parent.Post Event ue_AddEventNote (lnv_Msg , lla_NewIDS )
//	END IF
//

THIS.wf_JumpShipment ( inv_Shipment.of_GetID ( ) , TRUE )

RETURN 1

end event

event ue_splitboth;String	ls_SelectedType
Long		ll_SiteID
Long		lla_NewIds[]
Long		ll_InsertionPoint
Boolean	lb_Continue = TRUE
S_Parm		lstr_Parm
n_cst_msg	lnv_Msg
//n_Cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Dispatch = wf_GetDispatchManager ( )

//lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
//lnv_Shipment.of_SetSourceID ( inv_Shipment.of_GetID ( ) )
//
//lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
//lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )

ll_InsertionPoint = inv_Shipment.of_GetEventCount ( ) 
ll_InsertionPoint ++
ls_SelectedType = String ( Message.LongParm , "address" )

lstr_Parm.is_Label = "SPLITBACK"
lstr_Parm.ia_Value = TRUE
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "SPLITFRONT"
lstr_Parm.ia_Value = TRUE
lnv_Msg.of_Add_Parm ( lstr_Parm )

ll_SiteId = THIS.wf_GetCoIdFromCode ( ls_SelectedType )

THIS.Event ue_SiteMove ( ll_InsertionPoint , ll_SiteId ,lnv_Msg )

end event

event ue_rightclickoncompany;Any		laa_Parm_Values[]
String	lsa_Parm_Labels[]
String	ls_Name
Long	   ll_CompanyID
Boolean	lb_addDivider


ll_CompanyID = Long ( data ) //THIS.wf_GetBilltoID ( )
ls_Name = dwo.Name 

lsa_parm_labels[1] = "MENU_TYPE"
laa_parm_values[1] = "COMPANY"
lsa_parm_labels[2] = "CO_ID"
laa_parm_values[2] = ll_CompanyID
	


if ls_Name = "ds_billto_id" then
	lsa_parm_labels[3] = "ADDRESS_TYPE"
	laa_parm_values[3] = "BILLING"
end if

// making change here to allow any type of event to be specified as either the origination
// or termination site.
if ls_Name = "de_site" and ll_CompanyID > 0 then

	
	IF lb_AddDivider THEN		
		lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "ADD_ITEM"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
		lb_AddDivider = FALSE
	END IF
	
	IF w_disp.ds_ships.object.ds_origin_id[1] = ll_CompanyID then
		lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "CHECK"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "List as Origin"
	END IF
				
	
	lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "ADD_ITEM"
	laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "List as Origin"

	if w_disp.ds_ships.object.ds_findest_id[1] = ll_CompanyID then
		lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "CHECK"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "List as Final Destination"
	end if
	
	IF lb_AddDivider THEN
		lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "ADD_ITEM"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
	END IF
	
	lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "ADD_ITEM"
	laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "List as Final Destination"
	
	
end if
choose case f_pop_standard(lsa_parm_labels, laa_parm_values)
	case "LIST AS ORIGIN"
		w_disp.ds_ships.setitem(1, "ds_origin_id", ll_CompanyID)
		set_title()
	case "LIST AS FINAL DESTINATION"
		w_disp.ds_ships.setitem(1, "ds_findest_id", ll_CompanyID)
		set_title()
end choose
end event

event ue_postopen();THIS.Width = w_disp.width
THIS.height = w_disp.Height


end event

event ue_refreshequipment;uo_intermodalview.TriggerEvent ( "ue_RefreshEquipment" )
end event

event ue_removerouting();//Returns:  1 = Success, 0 = User Cancelled - No action, -1 = Failure
Int 		i
Long		ll_EventCount
Long		lla_EventIds[]
Long		ll_Index

Long			ll_ConfirmedCount
Long			ll_RoutedCount 
String		ls_ErrorMessage = "Could not process request."
Integer		li_Return = 1

n_cst_bso_Dispatch		lnv_Dispatch
n_cst_beo_Event			lnva_Events[]
n_cst_ShipmentManager	lnv_ShipmentManager

lnv_Dispatch = This.wf_GetDispatchManager ( )

lnv_ShipmentManager.of_AutoRouteGetEvents ( inv_SHipment.of_GetID  ( ) , lnv_Dispatch , lla_EventIds , FALSE )
lnv_Dispatch.of_geteventlist ( lla_EventIds, lnva_Events, TRUE )		
ll_EventCount = UpperBound ( lnva_Events ) 
n_cst_Privileges_Events	lnv_Privs


//IF NOT lnv_Privs.of_AllowAlterItins ( ) THEN
//	MessageBox ( "Routing" , "You do not have sufficient rights to perform this function.~r~nRequest Cancelled." )
//	li_Return = 0
//	
//END IF

IF gnv_app.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( "AlterItinerary", inv_shipment ) <> appeon_constant.ci_true THEN
	MessageBox ( "Routing" , "You do not have sufficient rights to perform this function.~r~nRequest Cancelled." )
	li_Return = 0
END IF

	
//Pull the event ids from the event list, and count how many are confirmed and routed

IF li_Return = 1 THEN

	ll_ConfirmedCount = 0
	ll_RoutedCount = 0

	FOR ll_Index = 1 TO ll_EventCount

		lla_EventIds [ ll_Index ] = lnva_Events [ ll_Index ].of_GetId ( )

		IF lnva_Events [ ll_Index ].of_IsConfirmed ( ) THEN

			ll_ConfirmedCount ++

		END IF
		
		IF lnva_Events [ ll_Index ].of_IsRouted( ) THEN

			ll_RoutedCount ++
			
		END IF

	NEXT


	IF ll_ConfirmedCount > 0 THEN  
		IF MessageBox ( "Remove CONFIRMED Routing Assignments", String ( ll_ConfirmedCount ) + " Event(s) in the leg you have "+&
			"selected are routed and confirmed complete.  ARE YOU SURE YOU WANT TO REMOVE THESE "+& 
			"ROUTING CONFIRMATIONS AND ASSIGNMENTS?", Exclamation!, OKCancel!, 2 ) = 2 THEN

			li_Return = 0  //Action cancelled by user.

		END IF
	END IF
	
	IF li_Return = 1 THEN
		IF ll_RoutedCount > 0 AND  ll_ConfirmedCount = 0  THEN 

			IF MessageBox ( "Remove Routing Assignments", +&
				"ARE YOU SURE YOU WANT TO REMOVE THESE "+& 
				"ROUTING ASSIGNMENTS?", Exclamation!, OKCancel!, 2 ) = 2 THEN

				li_Return = 0  //Action cancelled by user.

			END IF

		END IF
	END IF
END IF


//IF li_Return = 1 THEN
//	
//	FOR i = 1 TO 
//	
//END IF

	
IF li_Return = 1 THEN
	lnv_Dispatch.of_Remove ( 	lla_EventIds )
	This.wf_JumpShipment ( inv_Shipment.of_GetId ( ), TRUE /*Force redisplay*/ )
END IF
	
	
IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
	MessageBox ( "Auto Route", ls_ErrorMessage, Exclamation! )
END IF

FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_Events[ i ] )
NEXT

end event

protected function integer clear_seq (integer trailer_id, decimal trailer_seq);integer markloop

if numevents > 0 then
	for markloop = 1 to numevents
//		dw_event_details.setitem(markloop, "de_driver", -1)
//		dw_event_details.setitem(markloop, "de_driver_seq", 0)
//		dw_event_details.setitem(markloop, "de_tractor", -1)
//		dw_event_details.setitem(markloop, "de_tractor_seq", 0)
//		dw_event_details.setitem(markloop, "de_trailer", trailer_id)
		dw_event_details.setitem(markloop, "de_trailer_seq", trailer_seq)
//		dw_event_details.setitem(markloop, "de_locked", "N")
	next
end if

return 1
end function

protected function integer set_title ();string 	ls_title
String	ls_billto_name
String	ls_origin_name
String	ls_findest_name
String	ls_codename
String	ls_InvoiceNumber
String	ls_Invoicetext
Long		ll_len, &
			ll_totlen, &
			ll_greater
Int		li_Rtn
Boolean	lb_RestrictedView, &
			lb_billtoGreater, &
			lb_originGreater, &
			lb_FindestGreater, &
			lb_Invoice


environment env

s_co_info lstr_company
n_cst_beo_Company	lnv_Co

SetNull ( ls_billto_name )
SetNull ( ls_origin_name )
SetNull ( ls_findest_name )

GetEnvironment(env)
If env.ScreenWidth	>= 1024 then 
	lb_RestrictedView = false
else
	lb_RestrictedView = true
End If					

IF Not IsValid ( inv_Shipment ) THEN
	RETURN -1						//////// MID CODE RETURN
END IF

// Invoice
if inv_Shipment.of_GetStatus ( ) = 'W' then
	ls_InvoiceNumber = inv_Shipment.of_GetInvoiceNumber ( )
	if isnull(ls_InvoiceNumber) or len(trim(ls_InvoiceNumber)) = 0 then
		//no invioice
	else
		ls_Invoicetext = " (Invoice #" + ls_InvoiceNumber + ")"
		lb_Invoice = true
	end if
else
	ls_Invoicetext = ''
	lb_Invoice = false
end if

// Bill to
li_Rtn = inv_Shipment.of_GetBillToCompany ( lnv_Co , TRUE )
IF isValid ( lnv_Co ) THEN
	ls_billto_name = lnv_Co.of_GetBillingName ( )
	IF isNull ( ls_billto_name ) THEN
		ls_billto_name = lnv_Co.of_GetName ( )
	END IF
END IF
IF isnull(ls_billto_name) THEN
	ls_billto_name = "[NONE]"
else
	//add code name
	ls_codename = lnv_Co.of_GetCodeName ( )
	if isnull(ls_codename) then
		//skip
	else
		ls_billto_name += ' [' + ls_codename + ']'
	end if
END IF

// Origin
li_Rtn = inv_Shipment.of_GetOrigin ( lnv_Co , TRUE ) 
IF IsValid ( lnv_Co ) AND li_Rtn = 1 THEN
	ls_origin_name = lnv_Co.of_getName ( )
END IF
IF isnull(ls_origin_name) THEN
	ls_origin_name = "[NONE]" 
END IF
DESTROY ( lnv_co )

// Destination
li_Rtn = inv_Shipment.of_GetDestination ( lnv_Co , TRUE ) 
IF IsValid ( lnv_Co ) AND li_Rtn = 1 THEN
	ls_findest_name = lnv_Co.of_getName ( )
END IF
IF isnull(ls_findest_name) THEN
	ls_findest_name = "[NONE]" 
END IF
Destroy ( lnv_Co )

if lb_RestrictedView then
	ll_totlen = 60
else
	ll_totlen = 99
end if

if len(ls_billto_name) + len(ls_origin_name) + len(ls_findest_name) > ll_totlen then
	//are any less than a third
	if len(ls_billto_name) > (ll_totlen / 3) then 
		lb_billtoGreater = true
		ll_greater ++
	end if
	if len(ls_origin_name) > (ll_totlen / 3) then
		lb_OriginGreater = true
		ll_greater ++
	end if
	if len(ls_findest_name) > (ll_totlen / 3) then
		lb_findestGreater = true
		ll_greater ++
	end if
	
	choose case ll_greater
		case 1
			if lb_BilltoGreater then
				ll_totlen = ll_totlen - ( len(ls_origin_name) + len(ls_findest_name) )
				if len(ls_billto_name) > ll_totlen then
					ls_billto_name = left(ls_billto_name, ll_totlen - 3) + "..."
				end if
			elseif lb_OriginGreater then
				ll_totlen = ll_totlen - ( len(ls_billto_name) + len(ls_findest_name) )
				if len(ls_origin_name) > ll_totlen then
					ls_origin_name = left(ls_origin_name, ll_totlen - 3) + "..."
				end if
			else
				ll_totlen = ll_totlen - ( len(ls_billto_name) + len(ls_origin_name) )
				if len(ls_findest_name) > ll_totlen then
					ls_findest_name = left(ls_findest_name, ll_totlen - 3) + "..."
				end if
			end if
		case 2
			if not lb_BilltoGreater then
				ll_totlen = ll_totlen - len(ls_billto_name)
				if len(ls_origin_name) > (ll_totlen / 2) then
					ls_origin_name = left(ls_origin_name, (ll_totlen / 2) - 3) + "..."
				else
					ls_origin_name = left(ls_origin_name, (ll_totlen / 2))
				end if
				if len(ls_findest_name) > (ll_totlen / 2) then
					ls_findest_name = left(ls_findest_name, (ll_totlen / 2) - 3) + "..."
				else
					ls_findest_name = left(ls_findest_name, (ll_totlen / 2))
				end if
			elseif not lb_OriginGreater then
				ll_totlen = ll_totlen - len(ls_origin_name)
				if len(ls_billto_name) > (ll_totlen / 2) then
					ls_billto_name = left(ls_billto_name, (ll_totlen / 2) - 3) + "..."
				else
					ls_billto_name = left(ls_billto_name, (ll_totlen / 2))
				end if
				if len(ls_findest_name) > (ll_totlen / 2) then
					ls_findest_name = left(ls_findest_name, (ll_totlen / 2) - 3) + "..."
				else
					ls_findest_name = left(ls_findest_name, (ll_totlen / 2))

				end if
			else
				ll_totlen = ll_totlen - len(ls_findest_name)
				if len(ls_billto_name) > (ll_totlen / 2) then
					ls_billto_name = left(ls_billto_name, (ll_totlen / 2) - 3) + "..."
				else
					ls_billto_name = left(ls_billto_name, (ll_totlen / 2))
				end if
				if len(ls_origin_name) > (ll_totlen / 2) then
					ls_origin_name = left(ls_origin_name, (ll_totlen / 2) - 3) + "..."
				else
					ls_origin_name = left(ls_origin_name, (ll_totlen / 2))
				end if
			end if
		case 3
			//all 3 get truncated
			ls_billto_name = left(ls_billto_name, (ll_totlen / 3) - 3) + "..."
			ls_origin_name = left(ls_origin_name, (ll_totlen / 3) - 3) + "..."
			ls_findest_name = left(ls_findest_name, (ll_totlen / 3) - 3) + "..."
	end choose
	
	
end if

ls_title = "Shipment " + string(inv_Shipment.of_GetId ( ) ) + ls_Invoicetext + " for "
ls_title += ls_billto_name + " : " + ls_origin_name + " to " + ls_findest_name

w_disp.title = ls_title



return 1
end function

public subroutine wf_delete_ship ();Long		ll_ShipmentId, &
			lla_EventIds[], &
			ll_EventCount, &
			ll_DeletedCount, &
			lla_DeletedEquipmentIds[], &
			ll_DeletedEquipmentCount, &
			ll_Index
String	ls_MessageHeader = "Delete Shipment", &
			ls_ErrorMessage = "Could not delete shipment.", &
			ls_EquipmentMessages, &
			ls_Message, &
			lsa_DeletedEquipmentStatus[]
Boolean	lb_HasConfirmedEvents, &
			lb_InfoRedrawOff = FALSE, &
			lb_RowDeleted = FALSE, &
			lb_IsNonRouted
n_cst_bso_Dispatch		lnv_Dispatch
n_cst_OFRError				lnva_Errors[]
n_cst_beo_Equipment2		lnv_Equipment
n_cst_Msg					lnv_DeleteResults
s_Parm						lstr_Parm


Integer	li_Return = 1   //Used as a flag only, function has no return value.

lnv_Equipment = CREATE n_cst_beo_Equipment2

IF li_Return = 1 THEN

	ll_ShipmentId = inv_Shipment.of_GetId ( )
	
	IF inv_Shipment.of_Delete ( ) < 1 THEN
		li_Return = 0
	END IF

END IF


/////////////////////

IF li_Return = 1 THEN

	lb_HasConfirmedEvents = inv_Shipment.of_HasConfirmedEvents ( )
	lb_IsNonRouted = inv_Shipment.of_IsNonRouted ( )
	
	ls_Message = ""

	IF inv_Shipment.of_IsBilled ( ) THEN
		ls_Message = "This shipment has already been billed."
	END IF

	IF lb_HasConfirmedEvents THEN

		IF Len ( ls_Message ) > 0 THEN
			ls_Message += "~n~n"
		END IF

		ls_Message = "This shipment contains confirmed events, whose confirmations "

		IF lb_IsNonRouted = TRUE THEN
			//Don't need this part
		ELSE
			ls_Message += "and routings "
		END IF

		ls_Message += "will be cleared before the delete operation is attempted.  "

		IF lb_IsNonRouted = TRUE THEN
			//Don't need this part.
		ELSE
			ls_Message += "~n~nIf this work was actually performed, deleting these events "+&
				"will make your itinerary record inaccurate.  In this case, you should "+&
				"consider canceling the shipment instead.  "
		END IF

	END IF

	IF Len ( ls_Message ) > 0 THEN
		ls_Message += "~n~n"
	END IF

	ls_Message += "Before deleting the shipment, you should be sure that:~n~n"+&
		"All freight that may have been picked up has proper disposition.~n"+&
		"All leased equipment that may have been picked up has proper disposition.~n"+&
		"Any charges for Truck Ordered Not Used have been recorded.~n"+& 
		"Driver(s) / Consignee(s) have been notified of the cancellation."+&
		"~n~nOK to proceed with delete?"
	
	IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, OkCancel!, 2 ) = 1 THEN
		//OK -- proceed.
	ELSE
		li_Return = 0
	END IF

END IF

/////////////////////

//Get a handle to the DispatchManager.

IF li_Return = 1 THEN

	lnv_Dispatch = This.wf_GetDispatchManager ( )
	
	IF NOT IsValid ( lnv_Dispatch ) THEN
	
		ls_ErrorMessage += "~n(Could not resolve dispatch object.)"
		li_Return = -1
	
	END IF

END IF


//Get a list of event ids.  These will be needed, below.

IF li_Return = 1 THEN

	ll_EventCount = inv_Shipment.of_GetEventIds ( lla_EventIds )

	CHOOSE CASE ll_EventCount

	CASE IS >= 0
		//OK

	CASE -1
		//Error
		ls_ErrorMessage += "~n(Could not resolve event list.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return value
		ls_ErrorMessage += "~n(Unexpected return error resolving event list.)"
		li_Return = -1

	END CHOOSE

END IF


//Prepare the events for deletion.  This will be different depending on whether it's
//a non-routed shipment or not.

IF li_Return = 1 AND ll_EventCount > 0 THEN

	IF lb_IsNonRouted THEN
	
		//Since we've got lb_HasConfirmedEvents, we might as well use it, even though
		//of_UnconfirmEvents would do fine with an event list with no confirmations.

		IF lb_HasConfirmedEvents THEN

			//The shipment is non-routed. Unconfirm the requested event (if necessary.)
		
			lnv_Dispatch.ClearOFRErrors ( )
			
			CHOOSE CASE lnv_Dispatch.of_UnconfirmEvents ( lla_EventIds, TRUE /*Interactive*/ )
			
			CASE 1
				//OK
			
			CASE -1
			
				IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
	
					//Let this message stand on its own.
					ls_ErrorMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
					li_Return = -1
			
				ELSE
			
					ls_ErrorMessage += "~n(Unspecified error attempting to clear event confirmation.)"
					li_Return = -1
			
				END IF
			
			CASE ELSE
			
				ls_ErrorMessage += "~n(Unexpected return error attempting to clear event confirmation.)"
				li_Return = -1
			
			END CHOOSE

		END IF
	
	ELSE
	
		//The shipment is not non-routed. Clear any routing that may be on the events, 
		//(which will also unconfirm them.
	
		lnv_Dispatch.ClearOFRErrors ( )
	
		CHOOSE CASE lnv_Dispatch.of_Remove ( lla_EventIds )
		
		CASE 1
			//OK
		
		CASE -1
	
			IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN

				//Let this message stand on its own.	
				ls_ErrorMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
				li_Return = -1
	
			ELSE
	
				ls_ErrorMessage += "~n(Unspecified error attempting to clear event routing.)"
				li_Return = -1
	
			END IF
		
		CASE ELSE
	
			ls_ErrorMessage += "~n(Unexpected return error attempting to clear event routing.)"
			li_Return = -1
		
		END CHOOSE
	
	END IF

END IF

/////////////////////


IF li_Return = 1 THEN

	lnv_Dispatch.ClearOFRErrors ( )

	CHOOSE CASE lnv_Dispatch.of_DeleteEquipmentForShipment ( ll_ShipmentId, lnv_DeleteResults )

	CASE 1
		//Successfully deleted all equipment for shipment.

	CASE -1
		//Did not successfully delete all equipment for shipment.

		IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN

			ls_EquipmentMessages = lnva_Errors [ 1 ].GetErrorMessage ( )

		END IF

		IF Len ( ls_EquipmentMessages ) > 0 THEN
			//OK
		ELSE
			ls_EquipmentMessages = "Unspecified error attempting to delete equipment."
		END IF

	CASE ELSE

		//Unexpected return value.
		ls_EquipmentMessages = "Unexpected return error attempting to delete equipment."

	END CHOOSE


	//Read out what got successfully deleted from the DeleteResults object, 
	//so we have this list in case we need to undo the operation.

	IF lnv_DeleteResults.of_Get_Parm ( "DeletedIds", lstr_Parm ) > 0 THEN
		lla_DeletedEquipmentIds = lstr_Parm.ia_Value
		ll_DeletedEquipmentCount = UpperBound ( lla_DeletedEquipmentIds )
	END IF

	IF lnv_DeleteResults.of_Get_Parm ( "DeletedStatuses", lstr_Parm ) > 0 THEN
		lsa_DeletedEquipmentStatus = lstr_Parm.ia_Value
	END IF


	IF Len ( ls_EquipmentMessages ) > 0 THEN

		IF MessageBox ( ls_MessageHeader, "The following errors were encountered while attempting "+&
			"to delete equipment:~n~n" + ls_EquipmentMessages + "Do you want to delete the shipment anyway?" +&
			"  (If you choose OK and delete the shipment, equipment that could not be deleted will be "+&
			"unlinked from the shipment, and will remain in the system with its current status.)", &
			Question!, OKCancel!, 2 ) = 2 THEN

			//Flag that we cancelled
			li_Return = 0

		END IF

	END IF

END IF


//Delete the datawindow row.

IF li_Return = 1 THEN

	//dw_Ship_Info.SetRedraw ( FALSE )
	lb_InfoRedrawOff = TRUE

	//Note that bso_Dispatch only deals with intsig on primary and filter buffers, so this 
	//delete request actually won't have it's instsig changed.
	//I'm not going to bother with intsig, though, since delete is a "trumps all" 
	//kind of operation, anyway.
	
	IF lnv_Dispatch.of_DeleteShipment ( inv_Shipment.of_GetID () ) = 1 THEN
		//OK
		lb_RowDeleted = TRUE
	ELSE
		ls_ErrorMessage += "~n(Could not delete datawindow row.)"
		li_Return = -1
	END IF

END IF


//Save changes.

IF li_Return = 1 THEN

	CHOOSE CASE w_Disp.Save ( )

	CASE 1
		//OK

	CASE -1
		ls_ErrorMessage += "~n(Could not save pending changes to database.)"
		li_Return = -1

	CASE ELSE
		ls_ErrorMessage += "~n(Unexpected return error attempting to save changes.)"
		li_Return = -1

	END CHOOSE

END IF


//If we deleted the shipment row but the update failed, attempt to restore it.
//Note that w_Dispatch may have already done this for us to beat out the setredraw
//it does after saves, but there are early failure circumstances where this wouldn't
//happen, so we'll keep it here, too.

//IF li_Return = -1 AND lb_RowDeleted THEN
//
//	ll_DeletedCount = dw_Ship_Info.DeletedCount ( )
//
//	IF dw_Ship_Info.RowCount ( ) = 0 AND ll_DeletedCount > 0 THEN
//		dw_Ship_Info.RowsMove ( ll_DeletedCount, ll_DeletedCount, Delete!, &
//			dw_Ship_Info, 1, Primary! )
//	END IF
//
//END IF


//Whether we succeeded or failed, set the ship info redraw true.

//IF lb_InfoRedrawOff THEN
//
//	dw_Ship_Info.SetRedraw ( TRUE )
//
//END IF


//If we are not going through with the delete for any reason, undo any equipment
//deletions that may have been performed.

IF li_Return = 1 THEN

	//OK, we succeeded, no need to undo equipment deletion.

ELSEIF ll_DeletedEquipmentCount > 0 THEN

	lnv_Equipment.of_SetSource ( lnv_Dispatch.of_GetEquipmentCache ( ) )

	//Undo the deletions by restoring the previous status.

	FOR ll_Index = 1 TO ll_DeletedEquipmentCount

		lnv_Equipment.of_SetSourceId ( lla_DeletedEquipmentIds [ ll_Index ] )
		lnv_Equipment.of_SetStatus ( lsa_DeletedEquipmentStatus [ ll_Index ] )

	NEXT

END IF


IF li_Return = 1 THEN

	w_disp.winisclosing = true
	post close(w_disp)

ELSEIF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN

	messagebox(ls_MessageHeader, ls_ErrorMessage, exclamation!)

END IF

DESTROY ( lnv_Equipment ) 
end subroutine

public subroutine wf_jump ();integer rowloop, checkloop, numdr, numeq, markloop, sel_type, li_remoteopen = 1
long drids[], eqids[], checkid, sel_id, lla_ShipmentIds[], lla_TripIds[], ll_RowCount, ll_TripCount
string sel_cat, colnames[10] = {"de_driver", "de_tractor", "de_trailer1", "de_trailer2", &
	"de_trailer3", "de_container1", "de_container2", "de_container3", "de_container4", &
	"de_acteq"}
date date_parm, sel_date
s_anys open_parms, disp_parms
n_cst_anyarraysrv lnv_anyarray
n_cst_LicenseManager	lnv_LicenseManager
Boolean	lb_DispatchLicensed, &
			lb_BrokerageLicensed
			
Boolean	lb_UseToday
Any	la_Setting
n_cst_Settings	lnv_Settings
IF lnv_Settings.of_GetSetting	( 90 , la_Setting ) = 1 THEN
	IF String ( la_Setting ) = "YES!" THEN
		lb_UseToday = TRUE
	END IF
END IF


uo_intermodalview.Event ue_SyncEquipment ( )

lb_DispatchLicensed = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch )
lb_BrokerageLicensed = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage )

if not wf_status_check("JUMP!") = 1 then return

setnull(date_parm)

ll_RowCount = dw_Event_Details.RowCount ( )

for rowloop = 1 to ll_RowCount
	for checkloop = 1 to 10
		checkid = dw_event_details.getitemnumber(rowloop, colnames[checkloop])
		if checkid > 0 then
			if checkloop = 1 then
				if lnv_anyarray.of_FindLong(drids, checkid, 1, numdr) > 0 then continue
				numdr ++
				drids[numdr] = checkid
			else
				if lnv_anyarray.of_FindLong(eqids, checkid, 1, numeq) > 0 then continue
				numeq ++
				eqids[numeq] = checkid
			end if
		end if
	next
	if isnull(date_parm) then date_parm = dw_event_details.object.de_arrdate[rowloop]
next

ll_TripCount = dw_Event_Details.of_GetTrips ( lla_TripIds )

if isnull(date_parm) then date_parm = inv_Shipment.of_GetShipDate ( )

IF lb_UseToday THEN
	Setnull ( date_parm )  //If we pass null, selection window will use today's date.
END IF

IF lb_DispatchLicensed = FALSE and lb_BrokerageLicensed = FALSE THEN
	Open_Parms.Anys [ 1 ] = gc_Dispatch.ci_ItinType_Shipment
ELSEIF numeq = 0 AND ll_TripCount > 0 THEN
	Open_Parms.Anys [ 1 ] = gc_Dispatch.ci_ItinType_Trip
ELSE
	open_parms.anys[1] = null_int //Use Default
END IF
open_parms.anys[2] = "ALL_SHIPS" //changed from "ROUTED_ONLY" in 3.0.02
open_parms.anys[3] = date_parm
open_parms.anys[4] = null_long
open_parms.anys[5] = "PASS"
open_parms.anys[6] = drids
open_parms.anys[7] = eqids
open_parms.anys[8] = w_disp.ds_emp
open_parms.anys[9] = w_disp.ds_equip
Open_Parms.Anys [ 10 ] = lla_ShipmentIds
Open_Parms.Anys [ 11 ] = lla_TripIds

openwithparm(w_itin_select, open_parms)
disp_parms = message.powerobjectparm
sel_cat = disp_parms.anys[1]

if sel_cat = "ITIN" then
	
	sel_type = disp_parms.anys[2]
	sel_id = disp_parms.anys[3]
	sel_date = disp_parms.anys[4]
	
	Boolean	lb_ApproveSelection = TRUE
	
	if sel_type > 0 and sel_id > 0 then

		CHOOSE CASE sel_type
		
			CASE gc_Dispatch.ci_ItinType_Trip
				IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Brokerage, "E" ) < 0 THEN
					lb_ApproveSelection = FALSE
				END IF
			CASE ELSE
				IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Dispatch, "E" ) < 0 THEN
					lb_ApproveSelection = FALSE
				END IF
				
		END CHOOSE
		
		
		IF lb_ApproveSelection THEN
		
			if isvalid(w_disp.itinwin) then
				w_disp.itinwin.Tab_route.tabpage_Shipment.TriggerEvent ( "ue_refreshevents" )
				//The shipwin object has been deleted.
				//if isvalid(w_disp.itinwin.shipwin) then close(w_disp.itinwin.shipwin)

			else
				open(w_disp.itinwin, w_disp)
			end if
			this.setredraw(false)
			choose case w_disp.itinwin.display_itin(sel_type, sel_id, sel_date)
				case -2
					this.setredraw(true)
					messagebox("Itinerary Selection", "The itinerary you have requested contains "+&
						"updates to information already used in this window.  This may cause "+&
						"conflicts in saving your changes.  You should attempt to save now, before "+&
						"continuing.~n~nThe itinerary selection request is cancelled.", exclamation!)
					return
				case -1
					this.setredraw(true)
					messagebox("Itinerary Selection", "Could not retrieve the requested itinerary."+&
						"~n~nPlease retry.", exclamation!)
					return
			end choose
			w_disp.itinwin.last_ship = wf_GetShipmentId ( )
			w_disp.wf_set_toolmenu("ITIN!")
			w_disp.itinwin.show()
			w_disp.itinwin.resize(w_disp.width, w_disp.height)
			this.setredraw(true)
			this.hide()
			
			IF NOT w_disp.wf_isShipmentModified() THEN
				w_disp.wf_RemoveOpenShipment(wf_GetShipmentId ( ))
			ELSE
				//leave shipement as 'open' status
			END IF
			
		END IF
		
	end if

elseif sel_cat = "SHIP" then
	sel_id = disp_parms.anys[2]

	if sel_id > 0 then
			THIS.wf_JumpShipment ( sel_id, FALSE /*Do not force redisplay*/ )
	end if

end if
end subroutine

public subroutine wf_add_event ();IF inv_Shipment.of_AddEvent ( ) < 1 THEN
	RETURN
END IF

if numevents > 19 then
	mboxret = 1
	messagebox("Add Event", "A maximum of 20 events may be specified for each shipment.")
	return
end if

//cb_addev.visible = false
//st_addev.visible = true
//open(addwin, w_disp)


Open ( w_EventList )
end subroutine

public subroutine wf_move_event ();IF NOT uo_Events.of_IsMoveEnabled ( ) THEN

	
	//Since we can only move one row, get the focus to the most natural one.
//	uo_Events.of_ScrollToFirstSelectedEvent ( )
	
	IF inv_Shipment.of_MoveEvent ( ) < 1 THEN
		uo_events.of_SetMoveEnabled  ( FALSE )
		RETURN
	END IF
	
	if numevents < 2 then
		mboxret = 1
		messagebox("Move Event", "There must be at least two events in the itinerary "+&
			"in order to move them.")
		return
	end if
	
	uo_Events.of_SetMoveEnabled  ( TRUE )
ELSE
	uo_events.of_SetMoveEnabled  ( FALSE )
END IF


end subroutine

public subroutine wf_delete_event ();IF inv_Shipment.of_DeleteEvent ( 0 ) = 1 THEN
	uo_Events.of_DeleteEvents ( )
END IF


end subroutine

public subroutine wf_delete_item ();Long	ll_Item
long 	sel_item
Long	lla_ItemIds[]

sel_item = uo_itemlist.of_getrow()

if sel_item > 0 then

	IF inv_Shipment.of_DeleteItem ( 0 ) < 1 THEN

		RETURN

	END IF

	uo_itemlist.of_selectrow(sel_item, true)
	mboxret = 1
	
	if messagebox("Delete Item", "OK to delete the selected item?", question!, okcancel!, 2) = 1 THEN
		IF uo_itemlist.of_GetSelectedIds ( lla_ItemIds ) > 0 THEN
			uo_itemlist.of_SetRow ( 1 ) 
			inv_Shipment.of_RemoveItems ( lla_ItemIDs , THIS.wf_GetDispatchManager ( ) )
		END IF
		
	END IF

	IF dw_item_details.RowCount ( ) = 0 THEN
		dw_item_details.hide()
	ELSE
		dw_item_details.Post ScrollToRow ( 1 ) 
		dw_item_details.Post SetRow ( 1 )
	END IF

	uo_itemlist.of_ResetRange()
	uo_itemlist.of_selectrow(0, FALSE)
	
END IF


end subroutine

public subroutine wf_process_request (string as_request);// RDT 4-1-03 Added Code for PSR
Long	ll_ShipmentId, &
		lla_ShipmentId[]

n_cst_LicenseManager	lnv_LicenseManager
datawindow	ldw_Source

ll_ShipmentId = wf_GetShipmentId ( )

choose case as_request
case "SAVE!"

	//uo_intermodalview.Event ue_SyncEquipment ( )
	w_disp.save_request()
	dw_event_details.of_CheckNotifications ( )
	w_disp.setrefs()
	
// Executes when combine save and close on shipment property = "YES" - zmc - 2-4-04
case "SAVECLOSE!"
	IF uo_intermodalview.of_Accepttext( ) = 1 THEN
		w_disp.save_request()
		dw_event_details.of_CheckNotifications ( )
		Close(w_disp)
	END IF
	
case "ADD_SHIP_EVENT!"
	wf_add_event()
case "MOVE_SHIP_EVENT!"
	wf_move_event()
case "DELETE_SHIP_EVENT!"
	wf_delete_event()
case "ADD_FREIGHT_ITEM!"
	wf_add_item("FREIGHT!")
case "ADD_ACCESS_ITEM!"
	wf_add_item("ACCESS!")
CASE "FUELSURCHARGE!"
	wf_Add_item ( "FUELSURCHARGE!")
case "DELETE_SHIP_ITEM!"
	wf_delete_item()
case "DUPLICATE_SHIPMENT!"
	wf_DuplicateShipment ( )
	
case "DOCUMENT!" //"DELIVERY_RECEIPT!", 
//	w_Disp.wf_QuickPrint_Delrecs ( { ll_ShipmentId } )
	
	//***
	n_cst_Msg	lnv_Msg
	s_parm		lstr_Parm
	n_cst_Beo_Event	lnva_Events[]
	
	lla_ShipmentId[1]=ll_ShipmentId
	lstr_Parm.is_Label = "DOCUMENT"
	lstr_Parm.ia_Value = n_cst_Constants.cs_Document_DeliveryReceipt
	lnv_Msg.of_Add_Parm (lstr_Parm)
		
	lstr_Parm.is_Label = "SHIPMENTID"
	lstr_Parm.ia_Value = lla_ShipmentId
	lnv_Msg.of_Add_Parm (lstr_Parm)

	ldw_Source = uo_events.of_GetEventSource ( )
	lstr_Parm.is_Label = "DATAWINDOW"
	lstr_Parm.ia_Value = ldw_Source
	lnv_Msg.of_Add_Parm ( lstr_Parm )	

	IF THIS.wf_GetSelectedEvents ( lnva_Events ) > 0 THEN

		lstr_Parm.is_Label = "TOPIC"
		lstr_Parm.ia_Value = "EVENT"
		lnv_Msg.of_Add_Parm (lstr_Parm)

		lstr_Parm.is_Label = "MATCHCOLUMN"
		lstr_Parm.ia_Value = "de_ship_seq"
		lnv_Msg.of_Add_Parm (lstr_Parm)
		
		lstr_Parm.is_Label = "EVENTS"
		lstr_Parm.ia_Value = lnva_Events
		lnv_Msg.of_Add_Parm ( lstr_Parm )

	ELSE
		lstr_Parm.is_Label = "TOPIC"
		lstr_Parm.ia_Value = "SHIPMENT"
		lnv_Msg.of_Add_Parm (lstr_Parm)

		lstr_Parm.is_Label = "MATCHCOLUMN"
		lstr_Parm.ia_Value = "de_shipment_id"
		lnv_Msg.of_Add_Parm (lstr_Parm)

	END IF
	
	openWithParm  ( w_DocumentSelection, lnv_Msg )

	IF isValid(Message.PowerObjectParm) THEN
		IF Message.PowerObjectParm.ClassName() = "n_cst_msg" THEN
			wf_processpsr( Message.PowerObjectParm )						// RDT 4-1-03 
		END IF
	END IF
	
case "DELETE_SHIPMENT!"
	wf_delete_ship()

case "SHIP_JUMP!"
	wf_jump()
	
CASE "AUTOITEM!"
	EVENT ue_RateLookup ( TRUE )
	
CASE "RATEQUERY!"
	Post wf_RateQuery ( ) 
	
CASE "RATESELECTION!"
	EVENT ue_RateLookup ( FALSE )
	
CASE "SPLIT_BILLING!"
	This.wf_ManageSplits ( )

CASE "REVENUE_SPLITS!"
	This.Event ue_RevenueSplits ( )

CASE "AUTOROUTE!"
	uo_intermodalview.of_Accepttext( )
	IF THIS.wf_ValidateData ( ) = 1 THEN
		uo_intermodalview.Event ue_SyncEquipment ( )
		This.Event ue_AutoRoute ( )
	END IF
	
CASE "REMOVEROUTING!"
	This.Event ue_RemoveRouting ( )
	
	
CASE "AUTORATE!"
	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_AutoRating, "E" ) >= 0 THEN
		This.Event ue_AutoRate ( )
	END IF
	
CASE "LEASE_CHARGES!"
	THIS.Event ue_AddLeaseCharges ( )

CASE "EDI_LIST!"
	THIS.Event ue_ShowEdiList ( )
	
CASE "ShowAlerts!"
	THIS.wf_ShowAllalerts( )
	
//CASE "OVERRIDE_SHIPTYPE!"
//	THIS.wf_OverrideShiptype( )
end choose


end subroutine

public function integer wf_create_toolmenu ();n_cst_setting_combinesaveandcloseonshpmt lnv_SaveClose
lnv_SaveClose = Create n_cst_setting_combinesaveandcloseonshpmt
n_cst_LicenseManager	lnv_LicenseManager
n_cst_privileges	lnv_privileges
s_toolmenu lstr_toolmenu

if isvalid(inv_cst_toolmenu_manager) then return 0

inv_cst_toolmenu_manager = create n_cst_toolmenu_manager
inv_cst_toolmenu_manager.of_set_parent(this)

inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")

// Check Combine Save & Close on Shipment Property 
// If No then call SAVE! else Call SAVECLOSE! - zmc 2-4-04
IF Upper(lnv_SaveClose.of_GetValue()) = "NO" THEN
	inv_cst_toolmenu_manager.of_add_standard("SAVE!")
ELSE
	inv_cst_toolmenu_manager.of_add_standard("SAVECLOSE!")
END IF	

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "SHIP_JUMP!"
lstr_toolmenu.s_toolbutton_picture = "shipitin.bmp"
lstr_toolmenu.s_toolbutton_text = "GO TO..."
lstr_toolmenu.s_menuitem_text = "&Go To..."
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

//inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "VIEW_INVOICE!"
//lstr_toolmenu.s_toolbutton_picture = "invoice.bmp"
//lstr_toolmenu.s_toolbutton_text = "VIEW INVCE."
//lstr_toolmenu.s_menuitem_text = "Vie&w Invoice"
//inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

//inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "DELIVERY_RECEIPT!"
//lstr_toolmenu.s_toolbutton_picture = "delrec.bmp"
//lstr_toolmenu.s_toolbutton_text = "DEL RECEIPT"
//lstr_toolmenu.s_menuitem_text = "Delivery &Receipt"
//inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
//
inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "DOCUMENT!"
lstr_toolmenu.s_toolbutton_picture = "delrec.bmp"
lstr_toolmenu.s_toolbutton_text = "DOCUMENT"
lstr_toolmenu.s_menuitem_text = "Docume&nt"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

IF ib_SplitsEnabled THEN

	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "SPLIT_BILLING!"
	//lstr_toolmenu.s_toolbutton_picture = ""
	//lstr_toolmenu.s_toolbutton_text = ""
	lstr_toolmenu.s_menuitem_text = "Spl&it Billing"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
END IF

//Revenue splits
IF lnv_privileges.of_HasAuditRights () THEN
	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "REVENUE_SPLITS!"
	lstr_toolmenu.s_menuitem_text = "&Revenue Splits"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
END IF

inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "ADD_FREIGHT_ITEM!"
lstr_toolmenu.s_toolbutton_picture = "itemnew.bmp"
lstr_toolmenu.s_toolbutton_text = "ADD FREIGHT"
lstr_toolmenu.s_menuitem_text = "Add &Freight Item"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "ADD_ACCESS_ITEM!"
lstr_toolmenu.s_toolbutton_picture = "itacnew.bmp"
lstr_toolmenu.s_toolbutton_text = "ADD ACCESS"
lstr_toolmenu.s_menuitem_text = "Add &Access. Item"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, False, true)
lstr_toolmenu.s_name = "FUELSURCHARGE!"
lstr_toolmenu.s_menuitem_text = "Add Fuel Surcharge"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "AUTOITEM!"
//lstr_toolmenu.s_toolbutton_picture = "bee.bmp"
//lstr_toolmenu.s_toolbutton_picture = "insert2.bmp"
//lstr_toolmenu.s_toolbutton_text = "PASTE RATE"
lstr_toolmenu.s_menuitem_text = "Add Fr&om Rate List"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu,FALSE, true)
lstr_toolmenu.s_name = "RATEQUERY!"
//lstr_toolmenu.s_toolbutton_picture = "shipdel.bmp"
//lstr_toolmenu.s_toolbutton_text = "Auto Item"
lstr_toolmenu.s_menuitem_text = "Rate List &Lookup"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu,TRUE, true)
lstr_toolmenu.s_name = "RATESELECTION!"
lstr_toolmenu.s_toolbutton_picture = "insert2.bmp"
lstr_toolmenu.s_toolbutton_text = "PASTE RATE"
lstr_toolmenu.s_menuitem_text = "&Paste From Rate List"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch ) THEN
	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, False, true)
	lstr_toolmenu.s_name = "LEASE_CHARGES!"
	lstr_toolmenu.s_menuitem_text = "Paste Per &Diem Charges"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
END IF




inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "DELETE_SHIP_ITEM!"
lstr_toolmenu.s_toolbutton_picture = "itemdel.bmp"
lstr_toolmenu.s_toolbutton_text = "DELETE ITEM"
lstr_toolmenu.s_menuitem_text = "Delete Ite&m"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")

//inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "ADD_SHIP_EVENT!"
//lstr_toolmenu.s_toolbutton_picture = "eventnew.bmp"
//lstr_toolmenu.s_toolbutton_text = "ADD EVENT"
//lstr_toolmenu.s_menuitem_text = "Add &Event"
//inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "MOVE_SHIP_EVENT!"
lstr_toolmenu.s_toolbutton_picture = "eventmov.bmp"
lstr_toolmenu.s_toolbutton_text = "MOVE EVENT"
lstr_toolmenu.s_menuitem_text = "Move E&vent"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "DELETE_SHIP_EVENT!"
lstr_toolmenu.s_toolbutton_picture = "eventdel.bmp"
lstr_toolmenu.s_toolbutton_text = "DEL. EVENT"
lstr_toolmenu.s_menuitem_text = "Delete Even&t"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch ) OR &
	lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) THEN

	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "AUTOROUTE!"
	//lstr_toolmenu.s_toolbutton_picture = ""
	//lstr_toolmenu.s_toolbutton_text = ""
	lstr_toolmenu.s_menuitem_text = "A&uto Route..."
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "REMOVEROUTING!"
	//lstr_toolmenu.s_toolbutton_picture = ""
	//lstr_toolmenu.s_toolbutton_text = ""
	lstr_toolmenu.s_menuitem_text = "Remove Routing..."
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)


ELSE

	cb_AutoRoute.Visible = FALSE

END IF

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating  ) THEN
	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "AUTORATE!"
	lstr_toolmenu.s_menuitem_text = "Auto Rate Com&bined Freight"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
else
	
	dw_item_details.object.cb_autorate.visible=false
	
END IF

//inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "OVERRIDE_SHIPTYPE!"
////lstr_toolmenu.s_toolbutton_picture = "delrec.bmp"
////lstr_toolmenu.s_toolbutton_text = "OVERRIDE SHIPTYPE"
//lstr_toolmenu.s_menuitem_text = "&Override Shipment Type"
//inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "DUPLICATE_SHIPMENT!"
lstr_toolmenu.s_toolbutton_picture = "copy.bmp"
lstr_toolmenu.s_toolbutton_text = "DUP. SHIP"
lstr_toolmenu.s_menuitem_text = "Duplicate Shipment"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "DELETE_SHIPMENT!"
lstr_toolmenu.s_toolbutton_picture = "shipdel.bmp"
lstr_toolmenu.s_toolbutton_text = "DEL. SHIP"
lstr_toolmenu.s_menuitem_text = "Delete S&hipment"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)



IF lnv_LicenseManager.of_HasAnyEDILicense ( )THEN
	inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")
	
	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "EDI_LIST!"
	lstr_toolmenu.s_menuitem_text = "View Edi Transactions"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
END IF


	inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")
	
	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "ShowAlerts!"
	lstr_toolmenu.s_menuitem_text = "Show All Alerts"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
	


DESTROY(lnv_SaveClose)

return 1
end function

public subroutine wf_ppcol_check ();long ll_current_billto, ll_potential_billto
string ls_ppcol, ls_message_header, ls_message, ls_address
s_co_info lstr_company

ls_ppcol = w_disp.ds_ships.getitemstring(1, "ds_ppcol")
ll_current_billto = w_disp.ds_ships.getitemnumber(1, "ds_billto_id")


choose case ls_ppcol
case "P"
	ll_potential_billto = w_disp.ds_ships.getitemnumber(1, "ds_origin_id")
	ls_message_header = "Prepaid Shipment"
case "C"
	ll_potential_billto = w_disp.ds_ships.getitemnumber(1, "ds_findest_id")
	ls_message_header = "Collect Shipment"
case else
	return
end choose

if (ll_current_billto = ll_potential_billto) or &
	(isnull(ll_current_billto) and isnull(ll_potential_billto)) then return


if gnv_cst_companies.of_select(lstr_company, "BILLTO!", false, "", true, &
	ll_potential_billto, false, false) = 1 then

	if ll_current_billto = lstr_company.co_id then return

//	if ll_current_billto > 0 then
		//The "request cancelled" wording in the rejection scripts of of_select would
		//be out of place if the user had not made the request, per se, so I've commented 
		//out this current_billto criterion so that have the user will always get the 
		//confirmation dialog, for now at least.

		ls_message = "Specify " + substitute(lstr_company.co_name, null_str, "[NONE]") +&
			" as the Billto?"
		if messagebox(ls_message_header, ls_message, question!, yesno!, 1) = 2 &
			then return
//	end if

		//Note : ll_potential_billto may not = lstr_company.co_id, b.c. of facilities
		inv_Shipment.of_SetBillToID (lstr_company.co_id)
		uo_intermodalview.Post of_SyncBillTo ( )		
	
		
		set_title()

elseif len(message.stringparm) > 0 then
	ls_message = "Please Note:~n~n" + message.stringparm + "~nThe current billto will be retained."
	messagebox(ls_message_header, ls_message)

end if
end subroutine

public function integer wf_status_check (string as_context);String	ls_Message
Integer	li_Result
Int		li_Return = 1

CONSTANT String	ls_JumpHeader = "Change Selection..."

IF THIS.wf_ValidateData ( ) <> 1 THEN
	li_Return = -2
END IF

IF li_Return = 1 THEN

	li_Result = inv_Shipment.of_ValidateStatus ( ls_Message )
	
	CHOOSE CASE li_Result
	
	CASE -1  //Error
	
		CHOOSE CASE as_Context
	
		CASE "SAVE!"
			ls_Message += "~nSave request cancelled."
			MessageBox ( "Save Changes", ls_Message, Exclamation! )
			RETURN -1
	
		CASE "JUMP!"
			ls_Message += "~nSelection request cancelled."
			MessageBox ( ls_JumpHeader, ls_Message, Exclamation! )
			RETURN -1
	
		CASE "CLOSE!"
			ls_Message += "~nPress OK to abandon changes and close window, or Cancel to "+&
				"return to window and continue editing."
			IF MessageBox ( "Save Changes", ls_Message, Exclamation!, OkCancel!, 2) = 1 THEN
				RETURN -1
			ELSE
				RETURN -2
			END IF
	
		END CHOOSE
	
	CASE -2  //Requirements not met
	
		ls_Message = "Your changes have made this shipment's status invalid for the following "+&
			"reasons:~n~n" + ls_message + "~n"
	
		choose case as_context
	
		case "SAVE!"
			ls_Message += "In order to save, you must either correct these "+&
				"problems, or withdraw billing authorization.~n~nSave request cancelled."
			MessageBox ( "Save Changes", ls_Message, Exclamation! )
			RETURN -1
	
		case "JUMP!"
			ls_Message += "In order to change your selection, you must either correct these "+&
				"problems, or withdraw billing authorization.~n~nSelection request cancelled."
			MessageBox ( ls_JumpHeader, ls_Message, Exclamation! )
			RETURN -1
	
		case "CLOSE!"
			ls_Message += "In order to save, you must either correct these "+&
				"problems, or withdraw billing authorization.~n~nPress OK to abandon changes "+&
				"and close window, or Cancel to return to window and continue editing."
			IF MessageBox ( "Save Changes", ls_Message, Exclamation!, OkCancel!, 2) = 1 THEN
				RETURN -1
			ELSE
				RETURN -2
			END IF
	
		end choose
	
	CASE -3  //Optional omissions
	
		ls_message = "Please note the following conditions regarding this shipment:~n~n" +&
			ls_message + "~n"
		choose case as_context
		case "SAVE!"
			ls_message += "OK to save changes anyway?"
			if messagebox("Save Changes", ls_message, information!, okcancel!, 2) = 1 then &
				return 1 else return -1
		case "JUMP!"
			ls_message += "OK to change selection anyway?"
			if messagebox(ls_JumpHeader, ls_message, information!, okcancel!, 2) = 1 then &
				return 1 else return -1
		case "CLOSE!"
			ls_message += "Do you wish to save changes anyway?~n~nPress Yes to save and close "+&
				"window, No to abandon and close, or Cancel to return to window and continue "+&
				"editing."
			choose case messagebox("Save Changes", ls_message, information!, yesnocancel!, 3)
			case 1
				return 1
			case 2
				return -1
			case else
				return -2
			end choose
		end choose
	
	END CHOOSE
END IF

dw_event_details.Hide( )
dw_item_details.Hide( )

return li_Return 
end function

public function integer display_ship (long al_id);integer result, total_items, first_ac
long lla_RequiredShipTypes[]
dwobject ldwo_ShipType
Long	ll_SplitID
LOng	li_RemoteOpen = 1

n_cst_bso_Dispatch	lnv_Dispatch

result = w_disp.retr_ship(al_Id)

if result < 1 then return result

lnv_Dispatch = This.wf_GetDispatchManager ( )

if dw_event_details.visible then dw_event_details.hide()
if dw_item_details.visible then dw_item_details.hide()

//dw_ship_info.setredraw(false)
uo_itemlist.of_setredraw(false)
dw_item_details.setredraw(false)
uo_events.of_setredraw(false)
dw_event_details.setredraw(false)

IF IsValid ( lnv_Dispatch ) THEN
	ShareDataOff ( lnv_Dispatch.of_GetItemCache ( ) )
	ShareDataOff ( lnv_Dispatch.of_GetEventCache ( ) )
	lnv_Dispatch.of_FilterShipment ( al_Id )	
	w_disp.wf_SetShares ( )
ELSE
	//Failure condition??
END IF

numlh = 0
numac = 0

//billing format
bill_format = w_disp.ds_ships.object.ds_bill_format[1]

dw_item_details.modify("txt_bill_ind.text = '" + bill_format + "'")
//payable format
is_payable_format = w_disp.ds_ships.object.ds_pay_format[1]
dw_item_details.modify("txt_pay_ind.text = '" + is_payable_format + "'")

total_items = w_disp.ds_items.rowcount()

if total_items > 0 then
	first_ac = w_disp.ds_items.find("di_item_type = 'A'", 1, total_items)
	if first_ac > 0 then
		numlh = first_ac - 1
		numac = total_items - numlh
	else
		numlh = total_items
	end if
end if

numevents = w_disp.ds_events.rowcount()
dorb = w_disp.ds_ships.object.ds_dorb[1]

//////////
Long	ll_OldShipmentID
IF NOT isValid ( inv_Shipment ) THEN
	inv_Shipment = CREATE n_cst_beo_Shipment
END IF

ll_OldShipmentId = inv_Shipment.of_GetID ( )

inv_Shipment.of_SetContext ( lnv_Dispatch ) 
inv_Shipment.of_SetSource ( w_Disp.ds_Ships )
inv_Shipment.of_SetSourceId ( al_Id )

inv_Shipment.of_SetEventSource ( w_Disp.ds_Events )
inv_Shipment.of_SetItemSource ( w_Disp.ds_Items )

////////////

wf_SetDisplayRestrictions ( FALSE )

set_title()
w_disp.setrefs()
w_disp.wf_reset_times(1, "SHIP!")


long	ll_foundrow, &
		ll_shipid
		
n_cst_licensemanager	lnv_licensemanager


//IF inv_Shipment.of_AllowEditBill ( ) THEN
////	dw_ship_info.post setcolumn("ds_ship_date")
//END IF
////	dw_ship_info.post setfocus()

//this.postevent("reset_range", 1, 0)
//this.postevent("reset_range", 2, 0)

//uo_events.Event ue_PostRefresh ( )
IF ll_OldShipmentID <> al_id OR isNull ( ll_OldShipmentID ) THEN
	uo_intermodalview.of_ShipmentChanged ( inv_SHipment )
	THIS.Post wf_DetermineContext ( )
END IF
//
uo_splits.of_SetSplitsID ( inv_Shipment.of_GetParentID () )
cb_autoroute.Visible = NOT inv_Shipment.of_IsNonRouted ( )
cb_removerouting.Visible = cb_autoroute.Visible
cb_equipment.Visible = NOT inv_Shipment.of_IsNonRouted ( )

//dw_ship_info.setredraw(true)
uo_itemlist.of_setredraw(true)
dw_item_details.setredraw(true)
uo_events.of_setredraw(true)
dw_event_details.setredraw(true)

w_disp.wf_RetrieveOpenShipment(wf_GetShipmentId())
w_disp.wf_RecordOpenShipment(wf_GetShipmentId())

THIS.Post wf_ShowAlerts()
return 1

end function

public function long wf_getshipmentid ();RETURN inv_Shipment.of_GetId ( )
end function

private subroutine wf_setdisplayrestrictions (boolean ab_redraw);CONSTANT String	ls_Restrict = "txt_restrict_ind.text = 'T'"
CONSTANT String	ls_NonRestrict = "txt_restrict_ind.text = 'F'"
String	ls_Context




IF inv_Shipment.of_AllowEditBill ( ) THEN
	//dw_Ship_Info.Modify ( ls_NonRestrict )
ELSE
	//dw_Ship_Info.SetColumn ( "ds_pronum" )
	//dw_Ship_Info.Modify ( ls_Restrict )
	dw_Item_Details.SetColumn ( "di_item_type" )
END IF

dw_item_details.of_SetDisplayRestrictions ( )
uo_itemlist.Post of_SetDisplayRestrictions ( )

CHOOSE CASE dorb

CASE "T", "B"
	ls_Context = gc_Dispatch.cs_Context_DispatchShipment

CASE "D"
	ls_Context = gc_Dispatch.cs_Context_NonRoutedShipment

END CHOOSE

dw_Event_Details.of_SetContext ( ls_Context, inv_Shipment )
uo_events.of_SetContext ( ls_Context, inv_Shipment )

IF ab_Redraw THEN
	//dw_Ship_Info.SetRedraw ( TRUE )
	IF dw_Item_Details.Visible THEN
		dw_Item_Details.SetRedraw ( TRUE )
	END IF
	IF dw_Event_Details.Visible THEN
		dw_Event_Details.SetRedraw ( TRUE )
	END IF
END IF
end subroutine

private function decimal wf_computerate (readonly long al_row);decimal nulldec, readdec1, readdec2, rate
setnull(nulldec)

readdec1 = dw_item_details.getitemnumber(al_Row, "di_our_itemamt")

if readdec1 = 0 then return 0

choose case dw_item_details.getitemstring(al_Row, "di_our_ratetype")
	case appeon_constant.cs_RateUnit_Code_Flat, appeon_constant.cs_RateUnit_Code_Minimum, &
		  appeon_constant.cs_RateUnit_Code_Maximum
		rate = readdec1
	case appeon_constant.cs_RateUnit_Code_PerMile
		readdec2 = dw_item_details.getitemnumber(al_Row, "di_miles")
		if readdec2 > 0 then
			rate = round(readdec1 / readdec2, 4)
		else
			rate = nulldec
		end if
	case appeon_constant.cs_RateUnit_Code_PerUnit, appeon_constant.cs_RateUnit_Code_Piece, &
		  appeon_constant.cs_RateUnit_Code_Gallon
		readdec2 = dw_item_details.getitemnumber(al_Row, "di_qty")
		if readdec2 > 0 then //should be
			rate = round(readdec1 / readdec2, 4)
		else
			rate = nulldec
		end if
	case appeon_constant.cs_RateUnit_Code_Class
		readdec2 = dw_item_details.getitemnumber(al_Row, "di_totitemweight")
		if readdec2 > 0 then
			rate = round((readdec1 * 100) / readdec2, 4)
		else
			rate = nulldec
		end if
	case appeon_constant.cs_RateUnit_Code_Pound
		readdec2 = dw_item_details.getitemnumber(al_Row, "di_totitemweight")
		if readdec2 > 0 then
			rate = round(readdec1 / readdec2, 4)
		else
			rate = nulldec
		end if
		
	case appeon_constant.cs_RateUnit_Code_100Pound
		readdec2 = dw_item_details.getitemnumber(al_Row, "di_totitemweight")
		if readdec2 > 0 then
			rate = round((readdec1 * 100) / readdec2, 4)
		else
			rate = nulldec
		end if

	case appeon_constant.cs_RateUnit_Code_Ton
		readdec2 = dw_item_details.getitemnumber(al_Row, "di_totitemweight")
		if readdec2 > 0 then
			rate = round((readdec1 * 2000) / readdec2, 4)
		else
			rate = nulldec
		end if

	case else //appeon_constant.cs_RateUnit_Code_None
		
end choose

return rate
end function

public function integer wf_add_item (string as_item_type);String	ls_Find
Long		ll_Row
Long		ll_NewItemId
Int		li_Return = 1
Int		li_result

Dec		lc_fscRate
Dec		lc_rate
String	ls_recalc


n_cst_ShipmentManager					lnv_ShipmentManager
n_cst_bso_Dispatch						lnv_Dispatch
n_cst_setting_recalcFuelSurcharge 	lnv_recalcFSC
n_cst_beo_item 							lnva_items[]

lnv_recalcFsc = CREATE n_cst_setting_recalcFuelSurcharge

IF inv_Shipment.of_AddItem ( ) < 1 THEN
	li_Return = -1
END IF

IF li_return = 1 THEN
lnv_ShipmentManager.of_GetFuelSurcharge ( lc_rate , inv_shipment )		//added by dan

IF as_item_type = "FUELSURCHARGE!" THEN 
	//change By Dan 2-10-2006
	//IF inv_Shipment.of_HasFuelSurcharge ( ) THEN
	
		ls_recalc =lnv_recalcFsc.Of_getvalue( )
		inv_shipment.of_getitemsforeventtype("FUEL SURCHARGE", lnva_items )
		IF Upper ( ls_recalc ) = "YES" THEN
			IF UpperBound ( lnva_items ) > 0 THEN
				lnva_items[1].of_makefuelsurcharge( )
				li_Return = 0	
			END IF
		ELSEIF inv_Shipment.of_HasFuelSurcharge ( )  THEN	
			li_Return = 0
			lc_fscRate = lnva_items[1].of_getfscrate( )	
			
			IF not IsNull( lc_fscRate ) THEN
				IF lc_fscRate <> lc_rate THEN
					li_result = MessageBox( "Add Fuel Surcharge","The FSC rate used in the existing calculation is different than the rate being used in the pending change.Do you want to change the FSC rate?", QUESTION!,YESNO! )
				ELSE
					li_result = 1
				END IF
			ELSE
				li_result = 1
			END IF		
			
			IF li_result = 1 THEN	
				inv_Shipment.of_RecalcExistingSurcharges ( )
				//lnv_Item.of_MakeFuelSurcharge ( )
			ELSE
				//lnv_item.of_Makefuelsurcharge( TRUE )
				inv_shipMent.of_RecalcExistingSurcharges( TRUE )
			END IF
		END IF
		/*
		IF inv_shipment.of_hasnewfuelsurcharge( )  THEN
			inv_Shipment.of_RecalcExistingSurcharges ( )
		
		ELSEIF inv_Shipment.of_HasFuelSurcharge ( ) AND ls_recalc = "No" THEN	
			inv_shipment.of_getitemsforeventtype("FUEL SURCHARGE", lnva_items )
			lc_fscRate = lnva_items[1].of_getfscrate( )	
			
			IF not IsNull( lc_fscRate ) THEN
				IF lc_fscRate <> lc_rate THEN
					li_result = MessageBox( "Add Fuel Surcharge","The FSC rate used in the existing calculation is different than the rate being used in the pending change.Do you want to change the FSC rate?", QUESTION!,YESNO! )
				ELSE
					li_result = 1
				END IF
			ELSE
				li_result = 1
			END IF		
			
			IF li_result = 1 THEN	
				inv_Shipment.of_RecalcExistingSurcharges ( )
				//lnv_Item.of_MakeFuelSurcharge ( )
			ELSE
				//lnv_item.of_Makefuelsurcharge( TRUE )
				inv_shipMent.of_RecalcExistingSurcharges( TRUE )
			END IF
		END IF
		
		*/
   //-------------------------------------------------------------------
	//	li_return = 0
	//END IF
END IF

END IF
IF li_Return = 1 THEN
	lnv_Dispatch = This.wf_GetDispatchManager ( )
	IF Not IsValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	ll_NewItemID = inv_Shipment.of_AddItem ( as_item_type , lnv_Dispatch ) 
END IF

IF li_Return = 1 THEN
	IF ll_NewItemID = -1 THEN
		li_Return = -1 
	END IF
END IF

IF li_Return = 1 THEN
	uo_itemlist.Event ue_ItemAdded ( ll_NewItemID )
END IF


IF li_Return = 1 THEN
	ls_Find = "di_item_id = " + String ( ll_NewItemID )
	ll_Row = dw_item_details.Find ( ls_Find , 1 , 99 )
	
	IF ll_Row > 0 THEN
		dw_item_details.scrolltorow( ll_Row )	
		uo_itemlist.of_SetRow ( ll_Row )
	ELSE
		li_Return = -1
	END IF	
END IF

IF li_Return = 1  THEN
	IF as_item_type <> "FUELSURCHARGE!" THEN
		if dw_item_details.visible = false then
			if dw_event_details.visible then 
				dw_event_details.hide()
			END IF
			dw_item_details.show()
		end if
	END IF
		
	dw_item_details.setfocus()
END IF


n_Cst_AnyArraySrv	lnv_Array
lnv_Array.of_Destroy( lnva_items )

DESTROY lnv_recalcFSC
RETURN li_Return

/* old code before dan pasted back his changes
String	ls_Find
Long		ll_Row
Long		ll_NewItemId
Int		li_Return = 1

n_cst_bso_Dispatch	lnv_Dispatch


IF inv_Shipment.of_AddItem ( ) < 1 THEN
	li_Return = -1
END IF

IF as_item_type = "FUELSURCHARGE!" THEN 
	IF inv_Shipment.of_HasFuelSurcharge ( ) THEN
		inv_Shipment.of_RecalcExistingSurcharges ( )
		//MessageBox ( "Add Fuel Surcharge" , "A fuel surcharge already exists on this shipment." )
		li_Return = 0
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Dispatch = This.wf_GetDispatchManager ( )
	IF Not IsValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	ll_NewItemID = inv_Shipment.of_AddItem ( as_item_type , lnv_Dispatch ) 
END IF

IF li_Return = 1 THEN
	IF ll_NewItemID = -1 THEN
		li_Return = -1 
	END IF
END IF

IF li_Return = 1 THEN
	uo_itemlist.Event ue_ItemAdded ( ll_NewItemID )
END IF


IF li_Return = 1 THEN
	ls_Find = "di_item_id = " + String ( ll_NewItemID )
	ll_Row = dw_item_details.Find ( ls_Find , 1 , 99 )
	
	IF ll_Row > 0 THEN
		dw_item_details.scrolltorow( ll_Row )	
		uo_itemlist.of_SetRow ( ll_Row )
	ELSE
		li_Return = -1
	END IF	
END IF

IF li_Return = 1  THEN
	IF as_item_type <> "FUELSURCHARGE!" THEN
		if dw_item_details.visible = false then
			if dw_event_details.visible then 
				dw_event_details.hide()
			END IF
			dw_item_details.show()
		end if
	END IF
		
	dw_item_details.setfocus()
END IF

RETURN li_Return
*/
end function

public subroutine wf_ratequery ();THIS.wf_ratequery( FALSE )
end subroutine

public function integer wf_jumpshipment (readonly long al_id, readonly boolean ab_forceredisplay);//Returns:  1, -1
// RDT 6-19-03 Added method call to remove sharedata from items. PB8 having problems with share and filter.
// RDT 6-30-03 Added call to wf_setItemShare()
// MFS 1/11/06 Replaced display_ship call with w_disp.wf_DisplayShipment()
Integer	li_Return = -1
Long		ll_Modified = 0
Long		ll_LastId


ll_LastId = This.wf_GetShipmentId ( )

IF ab_ForceRedisplay = FALSE and al_Id = ll_LastId THEN

	//Id requested is already displayed, and we don't need to refresh.
	li_Return = 1

ELSE
	
	uo_itemlist.of_ShareDataOff() // RDT 6-19-03

	IF w_disp.wf_DisplayShipment(al_id, false) <> 1 THEN
		li_Return = -1 
	END IF
//	choose case display_ship(al_id)
//
//		CASE 1  //Success
//
//			li_Return = 1
//
//		case -2
//			messagebox("Display Shipment", "Information on this shipment has been modified "+&
//				"since it was originally retrieved for this window.  This may cause conflicts "+&
//				"in saving your changes.  You should attempt to save now, before continuing.~n~n"+&
//				"The shipment selection request is cancelled.", exclamation!)
//			
//		case -1
//			messagebox("Display Shipment", "Could not retrieve shipment information from "+&
//				"database.~n~nRequest cancelled -- Please retry.", exclamation!)
//			
//		case 0
//			messagebox("Display Shipment", "The shipment you have selected has been deleted "+&
//				"in this window, and will be removed from the list upon saving.~n~nRequest "+&
//				"cancelled.", exclamation!)
//
//		//CASE ELSE  //Unexpected return
//			
//	end choose
//
END IF


uo_events.of_ResetRange ( )
uo_itemlist.of_ResetRange ( )

//THIS.Post wf_DetermineContext( )
This.Post wf_SetItemShare( ) // RDT 6-30-03



RETURN li_Return
end function

public subroutine wf_managesplits ();
n_cst_msg	lnv_msg
s_Parm		lstr_Parm

Long	ll_ID
Long	ll_JumpID

n_cst_Bso_Dispatch	lnv_Dispatch
lnv_Dispatch = w_disp.wf_GetDispatchManager ( )

ll_ID = THIS.wf_GetShipmentID ( )
IF IsValid ( lnv_Dispatch ) THEN
	
	
	
	IF lnv_Dispatch.Event pt_updatesPending( ) = 1 THEN
	
		CHOOSE CASE MessageBox ("Shipment Splits" ,"You must save your changes in order to manage shipment splits. Do you want to save your changes now?" , QUESTION!, YESNO! , 1 ) 
			CASE 1 // save
				w_disp.save_request()
			CASE 2 // Don't Save
				return
		END CHOOSE
		
	END IF

	
	
	lstr_Parm.is_Label = "SHIPMENTID"
	lstr_Parm.ia_Value = ll_ID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "DISPATCHOBJECT"
	lstr_Parm.ia_Value = lnv_Dispatch
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	
	OpenWithParm ( w_ShipmentSplits , lnv_Msg )

	IF isValid ( message.powerobjectParm ) THEN
		
		lnv_Msg = message.powerobjectParm
		IF lnv_Msg.of_Get_Parm ( "JUMPID" ,lstr_Parm ) <> 0 THEN
			ll_JumpID = lstr_Parm.ia_Value
		END IF
	END IF
	

ELSE
	messageBox ( "Manage Splits" , "An error occurred while attempting to load the shipment. Request Cancelled.")
END IF

IF ll_JumpID > 0 THEN
	//Call wf_JumpShipment, forcing redisplay of current id, if that's what was selected.
	THIS.wf_JumpShipment ( ll_JumpID, TRUE /*Force redisplay*/ ) 
END IF
	
end subroutine

private function n_cst_bso_dispatch wf_getdispatchmanager ();RETURN w_Disp.wf_GetDispatchManager ( )
end function

public function long wf_getselectedeventids (ref long ala_ids[], readonly boolean ab_usecurrent);Long	ll_Count
ll_Count = uo_Events.of_GetSelectedEventIds ( ala_ids[], ab_usecurrent )

RETURN ll_Count 



	

end function

public function integer wf_getselectedevents (ref n_cst_beo_event anva_events[]);Long	ll_IDCount
Long	lla_EventIDs[], &
		ll_shipmentid
Boolean	lb_UseCurrent = FALSE
Int	i
n_cst_beo_Event	lnva_Events[ ]
n_cst_beo_shipment	lnv_shipment
n_cst_bso_dispatch	lnv_dispatch

DataStore	lds_Shipments

lnv_Dispatch = This.wf_GetDispatchManager ( )

ll_IDCount = THIS.wf_GetSelectedEventids ( lla_EventIDs , lb_UseCurrent )

lnv_shipment = CREATE n_cst_beo_shipment
lnv_shipment.of_SetSource ( lnv_dispatch.of_getshipmentcache() )
lnv_shipment.of_SetSourceId (inv_Shipment.of_getid())

FOR i = 1 TO ll_IDCount
	lnva_Events[i] = CREATE n_cst_beo_Event
	lnva_Events[i].of_SetSource ( uo_events.of_GetEventSource( ) )
	lnva_Events[i].of_SetSourceID ( lla_EventIDs[i] )
	lnva_Events[i].of_SetShipment ( lnv_Shipment ) 
NEXT

anva_Events = lnva_Events
RETURN ll_IDCount
end function

public subroutine wf_duplicateshipment ();n_cst_msg	lnv_msg
S_Parm		lstr_parm

IF THIS.wf_GetDispatchManager ( ).Event pt_updatesPending( ) = 1 THEN
	
	CHOOSE CASE MessageBox ("Duplicate Shipment" ,"You must save your changes in order for them to be duplicated. Do you want to save your changes now?" , QUESTION!, YESNOCANCEL! , 1 ) 
		CASE 1 // save
			w_disp.save_request()
		CASE 2 // Don't Save
			
		CASE 3 // cancel
			return			//// early return 
	END CHOOSE
		
END IF


Long	ll_ShipID
Int	li_Type
String	ls_Text
ll_ShipID = inv_Shipment.of_GetID ( )

lstr_Parm.is_Label = "SHIPMENTID"
lstr_Parm.ia_Value = ll_ShipID
lnv_Msg.of_Add_Parm ( lstr_Parm )

//ls_Text = dw_ship_info.object.ds_Ref1_text [ 1 ]
//li_Type = dw_ship_info.object.ds_Ref1_Type [ 1 ]

ls_Text = inv_Shipment.of_GetRef1Text ( )
li_Type = inv_Shipment.of_GetRef1Type ( )

IF Not isNull ( ls_Text ) AND ( li_Type = 20 OR li_Type = 26 OR li_Type = 28 ) THEN
	
	lstr_Parm.is_Label = "EQREF"
	lstr_Parm.ia_Value =  ls_Text
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	IF li_Type = 20 THEN
		lstr_Parm.ia_Value = 'C'
	ELSEIF li_Type = 26  THEN
		lstr_Parm.ia_Value = 'B'
	ELSE 
		lstr_Parm.ia_Value = 'H'
	END IF
	lstr_Parm.is_Label = "TYPE"
	lnv_Msg.of_Add_Parm  ( lstr_Parm ) 
	
	
END IF


openWithParm ( w_duplicatewithEquipment , lnv_Msg )



end subroutine

private function long wf_getcoidfromcode (string as_code);Long	ll_FoundRow
Long	ll_CompanyID = -1
n_cst_Beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

ll_FoundRow = gnv_cst_companies.of_Find ( as_Code ) 

IF ll_FoundRow > 0 THEN
	
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceRow ( ll_FoundRow )
	
	ll_CompanyID = lnv_Company.of_getID ( ) 
	
END IF

DESTROY lnv_Company

RETURN ll_CompanyID
	

end function

private function integer wf_clearitemamounts (string as_type);//Clear ratetype, rate, and itemamt for all items

Long	ll_RowCount, &
		ll_Row

ll_RowCount = dw_Item_Details.RowCount ( )

choose case upper(as_type) 
	case "CHARGES"
		for ll_Row = 1 to ll_RowCount
			dw_item_details.setitem(ll_Row, "di_our_ratetype", "Z")
			dw_item_details.setitem(ll_Row, "di_our_rate", 0)
			dw_item_details.setitem(ll_Row, "di_our_itemamt", 0)
		next
		
	CASE "PAYABLE"
		for ll_Row = 1 to ll_RowCount
			dw_item_details.setitem(ll_Row, "di_pay_ratetype", "Z")
			dw_item_details.setitem(ll_Row, "di_pay_rate", 0)
			dw_item_details.setitem(ll_Row, "di_pay_itemamt", 0)
		next
		
end choose

return 1
end function

public function integer wf_constructswitchingoptions (long al_row, ref n_cst_msg anv_msg);//String	ls_PreviousType
//String	ls_NextType
//String	lsa_ParmLabel[]
//Any		laa_ParmValue[]
//Boolean	lb_HasShipment
//Boolean	lb_Continue = TRUE
//Long	ll_SelectedRow
//Long	lla_SelectedRows[]
//Long	ll_SelectedCount
//Long	ll_Row 
//Long	ll_RowCount
//Long	ll_EventID
//Long	ll_Shipment1
//Long	ll_Shipment2
//
//Int	li_Rtn
//
//s_Parm	lstr_Parm
//
//
//n_cst_beo_Event	lnv_Event1
//n_cst_beo_Event	lnv_Event2
//
//lnv_Event1 = CREATE n_cst_beo_Event
//lnv_Event2 = CREATE n_cst_beo_Event
//
//ll_RowCount = dw_ship_itin.RowCount ( )
//ll_Row = al_Row
//
//DO 
//	
//	ll_SelectedRow = dw_ship_itin.GetSelectedRow ( ll_SelectedRow )
//	IF ll_SelectedRow > 0 THEN
//		lla_SelectedRows [ UpperBound ( lla_SelectedRows ) + 1 ] = ll_SelectedRow
//	END IF
//	
//LOOP WHILE ll_SelectedRow > 0
//
//ll_SelectedCount = UpperBound ( lla_SelectedRows )
//IF ll_SelectedCount = 0 THEN  // set the row passed in as a selected row
//	ll_SelectedCount = 1
//	lla_SelectedRows [ 1 ] = ll_Row
//END IF
//
//IF ll_SelectedCount = 2 THEN
//	
//	CHOOSE CASE ll_Row
//			
//		CASE lla_SelectedRows [ 1 ]
//			lnv_Event1.of_SetSource ( dw_ship_itin )
//			lnv_Event1.of_SetSourceRow ( lla_SelectedRows [1] )
//			ls_NextType = lnv_Event1.of_GetType ( )
//			
//		CASE lla_SelectedRows [ 2 ]
//			lnv_Event1.of_SetSource ( dw_ship_itin )
//			lnv_Event1.of_SetSourceRow ( lla_SelectedRows [2] )
//			ls_PreviousType = lnv_Event1.of_GetType ( )
//	END CHOOSE
//
//END IF
//
//IF ll_Row > 0 AND ll_Row <= ll_RowCount THEN
//	lnv_Event1.of_SetSource ( dw_ship_itin )
//	lnv_Event1.of_SetSourceRow ( ll_Row )
//	
//	ll_EventID = lnv_Event1.of_GetID ( )
//	lb_HasShipment = lnv_Event1.of_GetShipment ( ) > 0 
//	
//	
//	CHOOSE CASE ll_SelectedCount
//			
//		CASE 1
//			IF NOT lnv_Event1.of_IsConfirmed ( ) THEN
//				CHOOSE CASE lnv_Event1.of_GetType( )
//				
//					CASE gc_Dispatch.cs_EventType_Drop
//						
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount"
//				
//							IF lb_HasShipment THEN
//								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Deliver"
//							END IF
//					
//					CASE gc_Dispatch.cs_EventType_Dismount
//						
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop"
//							
//							IF lb_HasShipment THEN
//								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Deliver"
//							END IF
//					
//					CASE gc_Dispatch.cs_EventType_Hook
//				
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount"
//							
//							IF lb_HasShipment THEN
//								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Pickup"
//							END IF
//				
//					CASE gc_Dispatch.cs_EventType_Mount
//						
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook"
//				
//							IF lb_HasShipment THEN
//								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Pickup"
//							END IF
//							
//						
//					CASE gc_Dispatch.cs_EventType_Pickup
//						IF lb_HasShipment THEN
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook and Drop"
//							
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook"
//							
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount and Dismount"
//													
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount"
//							
//						END IF
//						
//						
//					CASE gc_Dispatch.cs_EventType_Deliver
//						IF lb_HasShipment THEN
//							
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop"
//							
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop and Hook"
//							
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount"
//							
//							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount and Mount"
//						END IF
//							
//						
//						
//				END CHOOSE
//			END IF
//					
//			
//			
//		CASE 2
//			IF lla_SelectedRows[2] = lla_SelectedRows[1] + 1 THEN // the 2 rows are adjacent
//				lnv_Event1.of_SetSource ( dw_ship_itin )
//				lnv_Event1.of_SetSourceRow ( lla_SelectedRows [ 1 ] )

//				
//				lnv_Event2.of_SetSource ( dw_ship_itin )
//				lnv_Event2.of_SetSourceRow ( lla_SelectedRows [ 2 ] )
//				
//				ll_Shipment1 = lnv_Event1.of_GetShipment ( )
//				ll_Shipment2 = lnv_Event2.of_GetShipment ( )
//				IF lnv_Event1.of_IsDeliverGroup ( ) AND lnv_Event2.of_IsPickupGroup ( ) THEN
//					IF Not ( lnv_Event1.of_IsConfirmed ( ) OR lnv_Event2.of_IsConfirmed ( ) ) THEN
//						
//						CHOOSE CASE lnv_Event1.of_GetType( )
//						
//							CASE gc_Dispatch.cs_EventType_Drop , gc_Dispatch.cs_EventType_Dismount , gc_Dispatch.cs_EventType_Hook , &
//									gc_Dispatch.cs_EventType_Mount 
//									
//									// determine the other type to put in the message
//						
//									IF ll_Shipment1 > 0 OR ll_Shipment2 > 0 THEN
//										IF ll_Shipment1 > 0 AND  ll_Shipment2 > 0 THEN
//											IF ll_Shipment1 <> ll_Shipment2 THEN // bail
//												lb_Continue = FALSE
//											END IF
//										END IF
//										
//										IF lb_Continue THEN
//											
//											lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//											laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Deliver"
//											
//											lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
//											laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Pickup"
//										END IF
//									END IF
//								
//						
//						END CHOOSE
//					END IF
//				END IF
//			END IF
//		END CHOOSE
//	
//END IF
//
//lstr_Parm.is_label = "LABELS"
//lstr_Parm.ia_Value = lsa_ParmLabel
//anv_msg.of_Add_Parm ( lstr_Parm )
//
//lstr_Parm.is_label = "VALUES"
//lstr_Parm.ia_Value = laa_ParmValue
//anv_msg.of_Add_Parm ( lstr_Parm )
//
//
//DESTROY ( lnv_Event1 )
//DESTROY ( lnv_Event2 )
//
//
//
//Return li_Rtn
//
//

RETURN -1
end function

public function long wf_getbilltoid ();Long	ll_BilltoID

ll_BillToID = inv_Shipment.of_GetBillTo ( )
RETURN ll_BillToID
end function

public function integer wf_setcontext (string as_value);CHOOSE CASE Upper ( as_Value )
		
	CASE "INTERMODAL"
		

		//uo_intermodalview.Visible = TRUE
		//uo_intermodalview.Enabled = TRUE
		//dw_Ship_Info.Visible = FALSE
		//dw_Ship_Info.Enabled = FALSE
		uo_itemlist.of_SetContext ( "INTERMODAL" )
		uo_itemlist.Post of_ShareData ( w_disp.ds_items )
		//uo_intermodalview.Post of_SetFocus ( )
					

	CASE ELSE
		
		//uo_intermodalview.Visible = FALSE
		//uo_intermodalview.Enabled = FALSE
		//dw_Ship_Info.Visible = TRUE
		//dw_Ship_Info.Enabled = TRUE
		uo_itemlist.of_SetContext ( "TL" )
		uo_itemlist.Post of_ShareData ( w_disp.ds_items )

END CHOOSE

RETURN 1


end function

private function integer wf_determinecontext ();IF inv_Shipment.of_IsIntermodal ( )  THEN
	THIS.wf_SetContext ( "INTERMODAL" )
ELSE
	THIS.wf_SetContext ( "TL" )
END IF

RETURN 1







end function

public function n_cst_ShipType wf_getshiptype ();n_cst_ship_Type	lnv_ShipTypeManager
n_cst_ShipType		lnv_ShipType

Long	ll_ShipType

lnv_ShipTypeManager.of_Ready ( TRUE ) 

ll_ShipType = inv_Shipment.of_GetType ( ) 

lnv_ShipTypeManager.of_Get_Object ( ll_ShipType , lnv_ShipType )

RETURN lnv_ShipType 



end function

private function integer wf_resetitemobject ();inv_Resize.of_UnRegister ( uo_itemlist )
uo_itemlist.x = il_ItemX
uo_itemlist.y = il_Itemy
uo_itemlist.Width = il_ItemWidth
uo_itemlist.height = il_ItemHeight


RETURN 1
end function

private function integer wf_reseteventobject ();inv_Resize.of_UnRegister ( uo_events )
uo_Events.x = il_EventX
uo_Events.y = il_Eventy
uo_Events.Width = il_EventWidth
uo_Events.height = il_EventHeight


RETURN 1
end function

private function integer wf_resetbuttons ();inv_Resize.of_UnRegister ( cb_autoroute )
//inv_Resize.of_Register ( cb_autoroute , 0 , 50 , 0, 0  )
		
inv_Resize.of_UnRegister ( cb_details ) 
inv_Resize.of_UnRegister ( cb_equipment ) 
inv_Resize.of_UnRegister ( uo_splits )
inv_Resize.of_UnRegister ( cb_revenuesplits ) 

cb_autoroute.X = il_RouteX
cb_autoroute.Y = il_RouteY
cb_details.X = il_MoreX
cb_details.Y = il_MoreY
cb_equipment.X = il_EquipX
cb_equipment.Y= il_EquipY
uo_splits.X = il_SplitsX
uo_splits.Y = il_SplitsY
cb_revenuesplits.X = il_RevX
cb_revenuesplits.Y = il_RevY




RETURN 1
end function

public function integer wf_validatedata ();Int	li_Return = 1
int i

n_cst_beo_Equipment2	lnva_Equip[]
n_cst_AnyArraySrv	lnv_Array



THIS.wf_GetDispatchManager( ).of_getequipmentforshipment ( inv_SHipment.of_GetID () , lnva_Equip )

FOR i = 1 TO UpperBound ( lnva_Equip ) 
	IF IsNull ( lnva_Equip[i].of_GetType ( ) ) THEN
		li_Return = -1
		MessageBox ( "Shipment Equipment" , "Please select a type for all equipment." )
		EXIT 
	END IF
NEXT

lnv_Array.of_Destroy ( lnva_Equip )
	
RETURN li_Return
end function

public function integer wf_accepttext (boolean ab_closemsg);
Int	li_Return = 1
boolean	lb_required
any		la_value
//string	ls_messagetext = "Data does not pass validation. Save canceled"
string	ls_messagetext = "Data does not pass validation."

n_cst_settings lnv_Settings


IF uo_intermodalview.of_Accepttext( ) <> 1 THEN
	li_Return = -1 
END IF

if li_return = 1 then
	IF uo_events.Event ue_ValidateEvents ( )  <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_return = 1 then
	if inv_shipment.of_getbillto() > 0 then
		//ok
	else
		//is it required
		IF lnv_Settings.of_GetSetting ( 145 , la_value ) <> 1 THEN
			//default
			lb_required = false
		else
			IF STRING ( la_Value ) = "YES!" THEN
				lb_required = true
			else
				lb_required = false
			end if
		END IF
		
		if lb_required then
			ls_messagetext = "A Billto must be entered in order to save the shipment."
	
			li_return = -1
		end if
		
	end if
end if

if li_return = -1 then
	if ab_closemsg then
		choose case messagebox("Dispatch Window", ls_messagetext + " Close without saving?", question!, yesno!, 2)
			case 1 
				li_return = 0
			case 2
				li_return = -1
		end choose
	else
		messagebox("Dispatch Window", ls_messagetext)
	end if
end if

RETURN li_Return
end function

public function integer wf_setitemshare ();// RDT 6-30-03 New Method to reset the items shares.

Integer li_Return = 1 

If li_Return = 1 then 
	li_Return  = w_disp.ds_items.sharedata(dw_item_details)
End if

If li_Return = 1 then 
	li_Return = uo_itemlist.of_ShareData ( w_disp.ds_items )
End if


Return li_Return 
end function

public function integer wf_jumptoitin (n_cst_beo_event anv_event);Boolean	lb_ApproveSelection = TRUE
Int		li_Type
Long		ll_ID
Date		ld_ItinDate
Int		li_Return = 1
Long		ll_LastId
Long		lla_DontCare[]
Long		lla_PowerUnits[]

n_Cst_beo_Event	lnv_Event
n_Cst_LicenseManager	lnv_LicenseManager

IF NOT IsValid ( anv_Event ) THEN
	RETURN -1
ELSE
	lnv_Event = anv_Event
END IF

SetNull ( ld_ItinDate )

IF  lnv_Event.of_Isthirdparty( ) THEN
	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Brokerage, "E" ) < 0 THEN
		lb_ApproveSelection = FALSE
	END IF
ELSE
	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Dispatch, "E" ) < 0 THEN
		lb_ApproveSelection = FALSE
	END IF
END IF	


IF lb_ApproveSelection THEN
	
	li_Type = gc_Dispatch.ci_ItinType_PowerUnit 
	lnv_Event.of_getassignments ( lla_DontCare, lla_PowerUnits, lla_DontCare, lla_DontCare )
	IF UpperBound ( lla_PowerUnits ) > 0 THEN
		ll_ID = lla_PowerUnits[1]		
	END IF
	
	ld_ItinDate = lnv_Event.of_GetDateArrived ( )
	
END IF

IF lb_ApproveSelection THEN
	IF ll_ID > 0 AND NOT isNull ( ld_ItinDate ) THEN
		
		if isvalid(w_disp.itinwin) then
			w_disp.itinwin.Tab_route.tabpage_Shipment.TriggerEvent ( "ue_refreshevents" )
			//The shipwin object has been deleted.
			//if isvalid(w_disp.itinwin.shipwin) then close(w_disp.itinwin.shipwin)
	
		else
			open(w_disp.itinwin, w_disp)
		end if
		this.setredraw(false)
		choose case w_disp.itinwin.display_itin(li_Type, ll_ID, ld_ItinDate)
			case -2
				this.setredraw(true)
				messagebox("Itinerary Selection", "The itinerary you have requested contains "+&
					"updates to information already used in this window.  This may cause "+&
					"conflicts in saving your changes.  You should attempt to save now, before "+&
					"continuing.~n~nThe itinerary selection request is cancelled.", exclamation!)
				li_Return = -1
			case -1
				
				messagebox("Itinerary Selection", "Could not retrieve the requested itinerary."+&
					"~n~nPlease retry.", exclamation!)
				li_Return = -1
		end choose
	ELSE
		li_Return = 0
		THIS.wf_Jump ( ) 
		
	END IF
	
	
	IF li_Return = 1 THEN
		w_disp.itinwin.last_ship = wf_GetShipmentId ( )
		w_disp.wf_set_toolmenu("ITIN!")
		w_disp.itinwin.show()
		w_disp.itinwin.resize(w_disp.width, w_disp.height)
		this.setredraw(true)
		this.hide()
		
		IF NOT w_disp.wf_isShipmentModified() THEN
			w_disp.wf_RemoveOpenShipment(wf_GetShipmentId ( ))
		ELSE
			//leave shipement as 'open' status
		END IF
		
	END IF
END IF
		
RETURN  li_Return

end function

public function integer wf_setshares ();w_disp.ds_items.sharedata(dw_item_details)

//w_disp.ds_events.sharedata(dw_ship_itin)
w_disp.ds_events.sharedata(dw_event_details)

uo_itemlist.POST of_ShareData ( w_disp.ds_items )
uo_events.POST of_ShareData ( w_disp.ds_events )
uo_intermodalview.POST of_ShareData (w_disp.ds_ships )

RETURN 1
end function

public function integer wf_autoroute ();String	ls_ErrorMessage
Integer 	li_Result , li_Return 
long		ll_shipmentid
n_cst_ShipmentManager 	lnv_ShipmentManager
n_cst_OFRError				lnva_Errors[]
n_cst_bso_Dispatch 		lnv_Dispatch 

lnv_Dispatch = This.wf_GetDispatchManager ( )

ll_shipmentid = inv_Shipment.of_Getid()

li_Result  = lnv_ShipmentManager.of_AutoRoute( ll_shipmentid, lnv_Dispatch, FALSE ) 

CHOOSE CASE li_Result

CASE 1  //Success
	This.wf_JumpShipment ( inv_Shipment.of_GetId ( ), TRUE /*Force redisplay*/ )

CASE 0  //User cancelled
	li_Return = 0

CASE -1
	li_Return = -1

	IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
		//There are errors to process -- Get the error text
		IF Len ( lnva_Errors[1].GetErrorMessage ( ) ) > 0 THEN
			ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
		END IF
		//Now that we've got what we need, we MUST clear the error list.
		lnv_Dispatch.ClearOFRErrors ( )
	END IF

CASE ELSE  //Unexpected return value
	//Force redisplay in case any changes were made for this unknown return value
	This.wf_JumpShipment ( inv_Shipment.of_GetId ( ), TRUE /*Force redisplay*/ )

	li_Return = -1

END CHOOSE

Return li_Return 

end function

public subroutine wf_seteventfocus (long al_row, string as_column);uo_events.Post SetFocus ( )
uo_events.Post of_SetFocus ( al_Row , as_Column )

end subroutine

private function integer wf_showalerts ();Int	li_Count
Int	i
pt_n_cst_beo	lnva_List[]
n_cst_AnyArraysrv	lnv_Array

li_Count = inv_Shipment.of_GetReferencedentities( lnva_List )
lnva_List[ li_Count + 1 ] = inv_shipment

THIS.wf_Getalertmanager( ).of_Showalerts( lnva_List )

FOR i = 1 TO li_Count // intentionally 1 short of upperbound
	Destroy ( lnva_List[i] )
NEXT

RETURN 1

end function

private function integer wf_showallalerts ();Int	li_Count
Int	i
pt_n_cst_beo	lnva_List[]

li_Count = inv_Shipment.of_GetReferencedentities( lnva_List )
lnva_List[ li_Count + 1 ] = inv_shipment

THIS.wf_Getalertmanager( ).of_ShowAllAlerts( lnva_List )

FOR i = 1 TO li_Count // intentionally 1 short of upperbound
	Destroy ( lnva_List[i] )
NEXT

RETURN 1
end function

public function n_cst_alertmanager wf_getalertmanager ();RETURN wf_getdispatchmanager( ).of_GetAlertManager ( )
end function

public subroutine wf_ratequery (boolean ab_autoapply);long 	lla_Shipmentids []
long	lla_BilltoIds []
Long	ll_OriginID
Long  ll_DestinationID
Boolean	lb_AllowEdit = TRUE


n_cst_beo_Item	lnv_Item


// Create attrib object
n_cst_rate_attribs lnv_attribs

n_cst_privileges	lnv_Privs
n_cst_setting_modfreightrateinfogroup	lnv_ModFreight
lnv_ModFreight = CREATE n_cst_setting_modfreightrateinfogroup

n_cst_setting_modaccessrateinfogroup	lnv_ModAcc
lnv_ModAcc = CREATE n_cst_setting_modaccessrateinfogroup

IF isValid ( inv_shipment ) THEN
	IF ab_autoapply THEN
		
		lnv_Item = uo_itemlist.of_Getselecteditem( )
		
		IF IsValid ( lnv_Item ) THEN
			lb_AllowEdit =  inv_Shipment.of_AllowItemedit( ) 
			IF lb_AllowEdit THEN
				IF lnv_Item.of_ISfreight( ) THEN
					lb_AllowEdit  = lnv_Privs.of_hassufficientrights(  lnv_ModFreight.of_Getvalue( ) )
				ELSEIF lnv_Item.of_ISAccessorial( ) THEN
					lb_AllowEdit  = lnv_Privs.of_hassufficientrights(  lnv_Modacc.of_Getvalue( ) )
				END IF
			END IF
			lnv_Item.of_SetShipment( inv_shipment )
			lnv_attribs.of_Settargetitem( lnv_Item )	
			
		END IF
	END IF
	
	
	IF lb_AllowEdit THEN
	
		lla_BilltoIDs[1] = 	inv_shipment.of_GetBillTo ( )
		lla_ShipmentIDs[1] = inv_shipment.of_GetID( )
		
		ll_OriginID = inv_shipment.of_GetOrigin( ) 
		ll_DestinationID = inv_shipment.of_GetDestination ( )
	
		lnv_attribs.of_SetOriginID ( ll_OriginID )
		lnv_attribs.of_SetDestinationID( ll_DestinationID )
		
		// Fill in IDs
		lnv_attribs.of_setShipmentids ( lla_Shipmentids )
		lnv_attribs.of_setBillToids ( lla_BillToids )
		
		
		IF IsValid ( w_rate_query ) THEN
			//restore it and apply focus
			IF w_rate_query.WindowState = MINIMIZED! THEN
				w_rate_query.WindowState = NORMAL!
			END IF
			w_rate_query.SetFocus ( )
		ELSE
			// Open  window		
			OpensheetWithParm( w_rate_query, lnv_attribs, gnv_App.of_GetFrame ( ), 0, LAYERED! )
		END IF
		
		
	ELSE
		
		MessageBox ( "Apply Rate" , lnv_Privs.of_Getrestrictmessage( ) )
		
	END IF
END IF

DESTROY ( lnv_ModFreight )
DESTROY ( lnv_ModAcc )

end subroutine

public subroutine wf_processpsr (readonly n_cst_msg anv_msg);//
/***************************************************************************************
NAME			: wf_ProcessPSR
ACCESS		: Private 
ARGUMENTS	: String		PSR File Name (path incl.)
RETURNS		: Integer	(1=Success, -1=Failure)
DESCRIPTION	: Opens the PSR View window
					The PSR window will call the PSR Manager 
REVISION		: RDT 4-1-03
***************************************************************************************/
Long		lla_ShipId[], &
			ll_ShipId 

Integer  li_Counter
String	ls_FileName

n_cst_Msg	lnv_msg
s_parm		lstr_parm


IF isValid(anv_Msg) THEN
	IF anv_Msg.of_Get_Parm("TEMPLATE", lstr_Parm) <> 0 THEN
		ls_FileName = lstr_Parm.ia_Value
	END IF
	IF anv_msg.of_Get_Parm("SHIPMENTIDS", lstr_Parm) <> 0 THEN
		lla_ShipId[] = lstr_Parm.ia_Value
	END IF
END IF

// check for ".psr" in file name
If Upper( Right( ls_filename , 4 ) ) = ".PSR" Then 
	
	IF UpperBound(lla_ShipId) < 1 THEN //IF shipment ids were not passed in, get current id
		lla_ShipId[1] =  This.wf_GetShipmentId( ) 
	END IF
	
	lstr_Parm.is_label = "FILENAME"
	lstr_Parm.ia_value = ls_filename
	lnv_Msg.of_Add_Parm( lstr_Parm )
	
	lstr_Parm.is_label = "SHIPMENTID"
	lstr_Parm.ia_value =  lla_ShipId
	lnv_Msg.of_Add_Parm( lstr_Parm )
	
	W_Psr_Viewer	lw_Psr
	
	OpenSheetWithParm ( lw_psr, lnv_msg, gnv_App.of_GetFrame ( ),0 , Layered! )
	
	IF isValid( lw_psr ) THEN
		lw_psr.setFocus()
	END IF
	
End If



end subroutine

public function integer wf_overrideshiptype ();Integer	li_Return = 1/*
Integer	li_Type
Long		i, ll_EventCount
Long		ll_EventIds[]
n_cst_Msg	lnv_Msg
s_parm	lstr_Parm

n_cst_beo_Event 	lnv_Events[]

This.wf_GetSelectedEventIds( ll_EventIds[], FALSE )
This.wf_GetSelectedEvents(lnv_Events[])

IF UpperBound(ll_EventIds[]) > 0 THEN
	
	lstr_Parm.is_Label = "IDS"
	lstr_Parm.ia_Value = ll_EventIds[]
	lnv_Msg.of_Add_Parm( lstr_Parm )
	
	OpenWithParm(w_ShipmentTypeOveride, lnv_Msg, This)
	
	
	IF isValid(Message.PowerObjectParm) THEN
		lnv_Msg = Message.PowerObjectParm
		
		IF lnv_Msg.of_Get_parm( "OVERRIDETYPE", lstr_Parm) > 0 THEN
			li_Type = lstr_Parm.ia_Value
		ELSE
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF
ELSE
	MessageBox("Shipment type override", "Please select event(s) to override.")
	li_Return = -1
END IF


IF li_Return = 1 THEN
	
	ll_EventCount = UpperBound(lnv_Events[])
	FOR i = 1 TO ll_EventCount
		IF lnv_Events[i].of_GetShipment() > 0 THEN // if event is a shipment event, allow override
			IF NOT isNull(li_Type) THEN
				lnv_Events[i].of_SetShipTypeOverride(li_Type)
			END IF
		END IF
	NEXT
	
END IF

*/

Return li_Return

end function

event open;Any	la_Setting
string ls_Setting
String		ls_Context
n_cst_msg	lnv_Msg	
s_Parm		lstr_Parm
n_cst_Settings	lnv_Settings

il_OriginalHeight = THIS.Height
il_OriginalWidth = THIS.Width


IF IsValid ( Message.PowerobjectParm ) THEN
	lnv_Msg = Message.PowerobjectParm
END IF
//dw_ship_info.Visible = FALSE
THIS.ib_DisableCloseQuery = TRUE
w_disp = this.parentwindow()

this.x = 1
this.y = 1
THIS.SetRedraw ( FALSE )


ids_orfin_events = create datastore
ids_orfin_events.dataobject = "d_itin"
ids_orfin_events.settransobject(sqlca)


IF lnv_Msg.of_Get_Parm ( "INTERMODAL" , lstr_Parm ) <> 0 THEN
	IF lstr_Parm.ia_Value = TRUE THEN
		ls_Context =  "INTERMODAL" 
	ELSE
		ls_Context = "TL"
	END IF
	THIS.POST wf_SetContext ( ls_Context ) 	
END IF

THIS.of_SetResize ( TRUE ) 
inv_Resize.of_Register ( uo_intermodalview ,appeon_constant.scaleright  )
inv_Resize.of_Register ( uo_events , 0 , 50 , 100 , 50  )
inv_Resize.of_Register ( uo_itemlist , 0 , 0 , 100 , 50  )
inv_Resize.of_Register ( cb_autoroute , 0 , 50 , 0, 0  )		
inv_Resize.of_Register ( cb_removerouting , 0 , 50 , 0, 0  )		

IF lnv_Settings.of_GetSetting ( 65, la_Setting ) = 1 THEN // "Enable Split Billing" 
	IF String ( la_Setting ) = "YES!" THEN
		ib_SplitsEnabled = TRUE
	END IF
END IF

uo_splits.of_Enable ( ib_SplitsEnabled )


this.Event Post ue_PostOpen ( ) 


//These modifications are identical to the ones done to dw_Detail on w_Itin

string modstring

//New-End Trip Sign
modstring = 'CREATE bitmap(band=detail filename="~~"off.bmp~~"~tif ( de_event_type = ~~"O~~", ~~"on.bmp~~", ~~"off.bmp~~" )" x="1651" y="580" height="37" width="42" border="0"  name=p_of visible="0~tif ( pos ( ~~"OF~~", de_event_type ) > 0, 1, 0 )" )'
dw_event_details.modify(modstring)

//S.T.
modstring = 'CREATE bitmap(band=detail filename="~~"st.bmp~~"~tcase ( trac_type when ~~"N~~" then ~~"van.bmp~~" else ~~"st.bmp~~" )" x="1719" y="614" height="65" width="119" border="0"  name=p_st visible="0~tif ( de_tractor > 0 and not trac_type = ~~"T~~", 1, 0 )" )'
dw_event_details.modify(modstring)

//Trailer1
modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr1_length >= 40, case ( trlr1_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr1_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="1779" y="614" height="65" width="229~tif ( trlr1_length >= 40, 229, 115 )" border="0"  name=p_trlr1 visible="0~tif ( de_trailer1 > 0, 1, 0 )" )'
dw_event_details.modify(modstring)
dw_event_details.SetPosition("p_wheels", "", true)

//Trailer2
modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr2_length >= 40, case ( trlr2_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr2_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="2007~tif ( trlr1_length >= 40, 2007, 1893 )" y="614" height="65" width="229~tif ( trlr2_length >= 40, 229, 115 )" border="0"  name=p_trlr2 visible="0~tif ( de_trailer2 > 0, 1, 0 )" )'
dw_event_details.modify(modstring)

//Trailer3
modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr3_length >= 40, case ( trlr3_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr3_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="2236~tif ( trlr1_length >= 40 and trlr2_length >= 40, 2236, if ( trlr1_length >= 40 or trlr2_length >= 40, 2122, 2007 ) )" y="614" height="65" width="229~tif ( trlr3_length >= 40, 229, 115 )" border="0"  name=p_trlr3 visible="0~tif ( de_trailer3 > 0, 1, 0 )" )'
dw_event_details.modify(modstring)

//Container Set 1     x = 1779 (trlr1.x) + 5
modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 1, 2 ) + ~~".bmp~~"" x="1784" y="614" height="45" width="225" border="0"  name=p_cntn01 visible="0~tif ( Integer ( Mid ( ContainerMap, 1, 2 ) ) > 0, 1, 0 )" )'
dw_event_details.modify(modstring)

//Container Set 2
modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 3, 2 ) + ~~".bmp~~"" x="2007~tif ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~", 2007, 1893 ) + 5" y="614" height="45" width="225" border="0"  name=p_cntn02 visible="0~tif ( Integer ( Mid ( ContainerMap, 3, 2 ) ) > 0, 1, 0 )" )'
dw_event_details.modify(modstring)

//Container Set 3
modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 5, 2 ) + ~~".bmp~~"" x="2236~tif ( ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~" ) and ( trlr2_length >= 40 OR Mid ( ContainerMap, 3, 2 ) > ~~"10~~" ), 2236, if ( ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~" ) or ( trlr2_length >= 40 OR Mid ( ContainerMap, 3, 2 ) > ~~"10~~" ), 2122, 2007 ) ) + 5" y="614" height="45" width="225" border="0"  name=p_cntn03 visible="0~tif ( Integer ( Mid ( ContainerMap, 5, 2 ) ) > 0, 1, 0 )" )'
dw_event_details.modify(modstring)

////ActTrlr
//modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( acteq_length >= 40, case ( acteq_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( acteq_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="2323~tif ( de_trailer1 > 0 and de_trailer2 > 0, if ( trlr1_length >= 40 and trlr2_length >= 40, 2323, if ( trlr1_length >= 40 or trlr2_length >= 40, 2209, 2094 ) ), if ( de_trailer1 > 0, if ( trlr1_length >= 40, 2094, 1980 ), 1898 ) )" y="564" height="65" width="229~tif ( acteq_length >= 40, 229, 115 )" border="0"  name=p_trlract visible="0~tif ( de_acteq > 0 and pos(~~"HR~~", de_event_type) > 0, 1, 0 )" )'
//dw_event_details.modify(modstring)
//
////Hook-Drop Sign
//modstring = 'CREATE bitmap(band=detail filename="~~"drop.bmp~~"~tif ( de_event_type = ~~"H~~", if ( interch > 0, ~~"hookic.bmp~~", ~~"hook.bmp~~" ), if ( interch > 0, ~~"dropic.bmp~~", ~~"drop.bmp~~" ) )" x="2259~tif ( de_trailer1 > 0 and de_trailer2 > 0, if ( trlr1_length >= 40 and trlr2_length >= 40, 2259, if ( trlr1_length >= 40 or trlr2_length >= 40, 2145, 2030 ) ), if ( de_trailer1 > 0, if ( trlr1_length >= 40, 2030, 1916 ), 1834 ) )" y="580" height="37" width="42" border="0"  name=p_hr visible="0~tif ( pos(~~"HR~~", de_event_type) > 0, 1, 0 )" )'
//dw_event_details.modify(modstring)
//
////Container1
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn1_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="1783~tcase ( pos ( de_multi_list, ~~"1~~" ) when 1, 2 then 1779 + if ( pos ( de_multi_list, ~~"1~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"1~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"1~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"1~~" ) = 8, 120, 5 ) else 1783 )" y="564" height="45" width="225~tif ( cntn1_length >= 40, 225, 110 )" border="0"  name=p_cntn1 visible="0~tif ( de_container1 > 0, 1, 0 )" )'
//dw_event_details.modify(modstring)
//
////Container2
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn2_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="1898~tcase ( pos ( de_multi_list, ~~"2~~" ) when 1, 2 then 1779 + if ( pos ( de_multi_list, ~~"2~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"2~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"2~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"2~~" ) = 8, 120, 5 ) else 1898 )" y="564" height="45" width="225~tif ( cntn2_length >= 40, 225, 110 )" border="0"  name=p_cntn2 visible="0~tif ( de_container2 > 0, 1, 0 )" )'
//dw_event_details.modify(modstring)
//
////Container3
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn3_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="2012~tcase ( pos ( de_multi_list, ~~"3~~" ) when 1, 2 then 1779 + if ( pos ( de_multi_list, ~~"3~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"3~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"3~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"3~~" ) = 8, 120, 5 ) else 2012 )" y="564" height="45" width="225~tif ( cntn3_length >= 40, 225, 110 )" border="0"  name=p_cntn3 visible="0~tif ( de_container3 > 0, 1, 0 )" )'
//dw_event_details.modify(modstring)
//
////Container4
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn4_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="2126~tcase ( pos ( de_multi_list, ~~"4~~" ) when 1, 2 then 1779 + if ( pos ( de_multi_list, ~~"4~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"4~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"4~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"4~~" ) = 8, 120, 5 ) else 2126 )" y="564" height="45" width="225~tif ( cntn4_length >= 40, 225, 110 )" border="0"  name=p_cntn4 visible="0~tif ( de_container4 > 0, 1, 0 )" )'
//dw_event_details.modify(modstring)
//
////ActCntn
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( acteq_length >= 40, if ( de_event_type = ~~"M~~", if ( interch > 0, ~~"4umic.bmp~~", ~~"4um.bmp~~" ), if ( interch > 0, ~~"4unic.bmp~~", ~~"4un.bmp~~" ) ), if ( de_event_type = ~~"M~~", if ( interch > 0, ~~"2umic.bmp~~", ~~"2um.bmp~~" ), if ( interch > 0, ~~"2unic.bmp~~", ~~"2un.bmp~~" ) ) )" x="2241~tcase ( pos ( de_multi_list, ~~"5~~" ) when 1, 2 then 1779 + if ( pos ( de_multi_list, ~~"5~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"5~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"5~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"5~~" ) = 8, 120, 5 ) else 2241 )" y="564" height="45" width="225~tif ( acteq_length >= 40, 225, 110 )" border="0"  name=p_cntnact visible="0~tif ( de_acteq > 0 and pos ( ~~"MN~~", de_event_type ) > 0, 1, 0 )" )'
//dw_event_details.modify(modstring)


//THIS.Post SetRedraw ( TRUE )


end event

on w_ship.create
int iCurrent
call super::create
this.cb_autoroute=create cb_autoroute
this.uo_events=create uo_events
this.uo_itemlist=create uo_itemlist
this.cb_details=create cb_details
this.cb_revenuesplits=create cb_revenuesplits
this.cb_equipment=create cb_equipment
this.uo_splits=create uo_splits
this.uo_intermodalview=create uo_intermodalview
this.cb_1=create cb_1
this.dw_item_details=create dw_item_details
this.dw_event_details=create dw_event_details
this.cb_removerouting=create cb_removerouting
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_autoroute
this.Control[iCurrent+2]=this.uo_events
this.Control[iCurrent+3]=this.uo_itemlist
this.Control[iCurrent+4]=this.cb_details
this.Control[iCurrent+5]=this.cb_revenuesplits
this.Control[iCurrent+6]=this.cb_equipment
this.Control[iCurrent+7]=this.uo_splits
this.Control[iCurrent+8]=this.uo_intermodalview
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.dw_item_details
this.Control[iCurrent+11]=this.dw_event_details
this.Control[iCurrent+12]=this.cb_removerouting
end on

on w_ship.destroy
call super::destroy
destroy(this.cb_autoroute)
destroy(this.uo_events)
destroy(this.uo_itemlist)
destroy(this.cb_details)
destroy(this.cb_revenuesplits)
destroy(this.cb_equipment)
destroy(this.uo_splits)
destroy(this.uo_intermodalview)
destroy(this.cb_1)
destroy(this.dw_item_details)
destroy(this.dw_event_details)
destroy(this.cb_removerouting)
end on

event close;destroy inv_cst_toolmenu_manager
destroy ids_orfin_events
DESTROY inv_Shipment
end event

event show;call super::show;w_disp.wf_restoresize( )
end event

event resize;If IsValid (inv_resize) Then
	inv_resize.Event pfc_Resize (sizetype, newwidth ,newheight )
End If
RETURN 1
end event

event closequery;call super::closequery;w_disp.wf_RemoveOpenShipmentsWithCurrentHandle(wf_GetShipmentId())

end event

type cb_autoroute from u_cb within w_ship
integer x = 1317
integer y = 1412
integer width = 407
integer height = 68
integer taborder = 80
boolean bringtotop = true
integer weight = 400
string text = "A&uto Route..."
end type

event clicked;
uo_intermodalview.of_Accepttext( )
IF Parent.wf_ValidateData ( ) = 1 THEN
	uo_intermodalview.Event ue_SyncEquipment ( )

 	Parent.Event ue_AutoRoute ( )	

END IF
end event

event constructor;il_RouteX = THIS.X
il_RouteY = THIS.Y

n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_AllowAlterItins ( )
end event

type uo_events from u_cst_eventlist within w_ship
integer x = 288
integer y = 1408
integer width = 3342
integer height = 528
integer taborder = 100
end type

on uo_events.destroy
call u_cst_eventlist::destroy
end on

event ue_getdispatchmanager;RETURN Parent.wf_GetDispatchmanager ( )
end event

event ue_getshipment;RETURN inv_Shipment 
end event

event ue_eventadded;THIS.Event ue_PostRefresh ( )

//ids_orfin_events.reset()
//w_disp.ds_events.rowscopy(1, w_disp.ds_events.rowcount(), primary!, ids_orfin_events, 9999, primary!)
//post wf_check_orfin( ids_orfin_events )


dw_event_details.scrolltorow( al_row )

if dw_event_details.visible = false then
	if dw_item_details.visible then 
		dw_item_details.hide()
	END IF
	dw_event_details.show()
end if


//dw_event_details.Post setfocus()
uo_events.Post of_SetFocus ( al_Row , "" )
end event

event ue_showdetail;Long	ll_Row

ll_Row = al_row

IF ll_Row > 0 THEN

	if dw_item_details.visible then dw_item_details.hide()
	if dw_event_details.visible = false then 
		dw_event_details.show()

		dw_event_details.post setredraw(false)
		dw_event_details.post setcolumn("de_note")
		dw_event_details.post scrolltorow(ll_Row)
		dw_event_details.Event post RowFocusChanged(ll_Row)
		dw_event_details.post setcolumn("co_name")
		dw_event_details.post setredraw(true)
		dw_event_details.post setfocus()
	ELSE
		dw_event_details.Hide()
	END IF
		
END IF

RETURN 1
end event

event ue_eventdeleted;call super::ue_eventdeleted;Int i

numevents = THIS.of_GetEventCount ( ) 
numac = 0
numlh = 0

FOR i = 1 TO dw_item_details.RowCount ( )
	IF dw_item_details.object.di_item_type[i] = "A" then 
		numac ++
	else 
		numlh ++
	END IF
NEXT

Parent.Post Set_title ( ) 


end event

event ue_moveevent;call super::ue_moveevent;PARENT.wf_JumpShipment ( inv_Shipment.of_GetID ()  , TRUE )

RETURN 1
end event

event ue_postrefresh;call super::ue_postrefresh;w_disp.wf_reset_times(1, "SHIP!")
//THIS.of_ShareDataOff ( )

Parent.wf_GetDispatchManager ( ).of_FilterShipment ( inv_Shipment.of_GetID ( ) )

//Parent.wf_SetShares( )
THIS.of_ResetRange ( )
uo_itemlist.post of_ResetRange ( )
end event

event ue_chassispuchanged;Int	li_Return
li_Return = uo_intermodalview.of_SetChassisPuSite ( al_site )
inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_Frontchassissplit )

RETURN li_Return
end event

event ue_chassisrtnchanged;Int	li_Return
li_Return = uo_intermodalView.of_SetChassisRtnSite ( al_Site )
inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_BackChassissplit )

RETURN li_Return
end event

event ue_trailerpuchanged;Int	li_Rtn

li_Rtn =  uo_intermodalview.of_SetTrailerPuSite ( al_site )
inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_Frontchassissplit )

RETURN li_Rtn
end event

event ue_trailerrtnchanged;Int	li_Rtn
li_Rtn = uo_intermodalview.of_SetTrailerRtnSite ( al_SIte )

inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_Backchassissplit )

RETURN li_Rtn
end event

event ue_rowchanged;dw_event_details.scrolltorow( al_newrow )

if dw_event_details.visible then
	//dw_event_details.setfocus()
end if

RETURN 1
end event

event ue_sitechanged;call super::ue_sitechanged;n_cst_shipmentManager	lnv_Manager
IF inv_Shipment.of_isIntermodal () THEN
	//lnv_Manager.of_SetIntermodalOriginDest ( inv_Shipment )
ELSE
	//parent.post wf_check_orfin(ids_orfin_events)
END IF

Parent.Post set_Title (  )

n_Cst_beo_Company	lnv_Company	
lnv_Company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID ( al_new ) 
PARENT.wf_GetAlertmanager( ).of_ShowAlerts( {lnv_Company} )

DESTROY ( lnv_Company )

end event

event constructor;call super::constructor;il_Eventx = THIS.x
il_Eventy = THIS.y
il_EventWidth = THIS.Width 
il_EventHeight = THIS.Height
end event

event ue_origindestchanged;uo_intermodalview.Post of_SyncBillTo ( )		
Parent.set_Title (  )

end event

event ue_jumptoitinerary;n_cst_beo_Event	lnv_Event

IF al_row > 0 THEN
	lnv_Event = THIS.of_GetEventForRow ( al_row )
	
	IF ISValid ( lnv_Event ) THEN
		IF lnv_Event.of_HasSource ( ) THEN
			Parent.wf_JumpToItin ( lnv_Event )			
		END IF 
		DESTROY ( lnv_Event )
	END IF
	
END IF

RETURN 1
	
end event

event ue_refreshshipment;Long	ll_Row
String	ls_Column

ll_Row = THIS.dw_Events.GetRow ( )
ls_Column = THIS.dw_Events.GetColumnName () 


Parent.display_Ship ( inv_Shipment.of_GetID ( )  )

Parent.Post wf_setEventfocus(ll_Row  ,ls_Column  )
end event

event ue_yardstorageadded;call super::ue_yardstorageadded;String	ls_Find
Int	li_Row
Int	li_Count
li_Count = uo_itemlist.of_getItemcount( )
ls_Find = "di_description Like 'YARD STORAGE%'"
li_Row = uo_itemlist.dw_itemlist.Find ( ls_Find , li_Count  , 1 )
IF li_Row > 0 THEN
	uo_itemlist.event ue_showdetails( li_Row )
END IF

//MessageBox (String ( li_count ) , li_Row )
end event

type uo_itemlist from u_cst_itemlist within w_ship
integer x = 416
integer y = 1024
integer width = 3223
integer taborder = 20
end type

on uo_itemlist.destroy
call u_cst_itemlist::destroy
end on

event ue_showdetails;Long	ll_Row

ll_Row = al_row

IF ll_Row > 0 THEN
	
	
	// these 2 lines are to fix a wierd display issue, one that only comes up if an acc item is added and then
	// a item is auto generatred and then the details of the item is displayed
	THIS.of_SetRow( THIS.of_GetItemCount ( ) )
	THIS.of_SetRow ( al_row )	

	if dw_event_details.visible then dw_event_details.hide()
	if dw_item_details.visible = false then 
	
		dw_item_details.show()

		dw_item_details.event post rowfocuschanged(al_row)
		dw_item_details.post setredraw(false)
		dw_item_details.post setcolumn("di_item_type")		
		dw_item_details.post scrolltorow(ll_Row)
		dw_item_details.post setcolumn("di_qty")
		dw_item_details.post setredraw(true)
		dw_item_details.post setfocus()
	ELSE
		dw_item_details.Hide()
	END IF

END IF

RETURN 1
end event

event ue_ratelookup;PARENT.event ue_RateLookup ( ab_createnew )
Return 1

end event

event ue_rowfocuschanged;if al_row > 0 then
	if dw_item_details.visible then dw_item_details.setredraw(false)
//	dw_item_details.setcolumn("di_item_type")
	dw_item_details.scrolltorow(al_row)
//	dw_item_details.setcolumn("di_qty")
	string	ls_column
	ls_column = dw_item_details.of_getcolumnfocus()
	IF Len ( ls_Column ) > 0 THEN
		dw_item_details.setcolumn(ls_column)
	END IF
	if dw_item_details.visible then dw_item_details.setredraw(true)
	if dw_item_details.visible then dw_item_details.setfocus()
end if


This.Post SetRedraw ( TRUE )  //To force redraw of highlight

RETURN 1
end event

event ue_calcfreightcircles;
Long		ll_curpu
Long  	ll_curdel
Long		ll_newpu
Long		ll_newdel
Long 		ll_selevent
long 		ll_foundrow
Long		ll_NumEvents
Int		li_NumFreight
Int		li_NumAcc
string 	ls_findstr
char 		lc_cltype
Char		lc_EventType
Boolean	lb_Continue 
Boolean	lb_Intermodal
Long		ll_Null

n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Item			lnv_Item

SetNull ( ll_Null )

//this.of_selectrow(0, false)

lnv_Item = THIS.of_GetSelectedItem ( ) 
lnv_Shipment = inv_Shipment



ll_selevent = uo_events.of_getrow()
lb_Continue = ( row > 0 AND ll_selEvent > 0 AND isValid ( lnv_Shipment ) AND isValid ( lnv_Item ) )

IF lb_Continue THEN
	ll_NumEvents = uo_events.of_getEventCount ( )
	li_NumFreight = lnv_Shipment.of_GetItemCount ( "L" )
	li_NumAcc = lnv_Shipment.of_GetItemCount ( "A" )
	ll_curpu = lnv_Item.of_GetPickupEvent ( ) 
	ll_curdel = lnv_Item.of_GetDeliverEvent ( )
	lb_Intermodal = lnv_Shipment.of_IsIntermodal ( )
END IF




IF lb_Continue THEN
	
	IF lnv_Item.of_GetType ( ) = "A" OR  (Not IsNull (lnv_Item.of_GetEventTypeFlag ( ) ) AND (lnv_Item.of_GetEventTypeFlag ( ) <> n_Cst_constants.cs_ItemEventtype_MoveAccessorial ) ) THEN
		
		if ll_curpu = ll_selevent then 
			ll_newpu = ll_null 
		else 
			ll_newpu = ll_selevent
		END IF
		
		lnv_Item.of_SetPuEvent ( ll_newpu )
	
	
	ELSE  // freight
		IF lb_Intermodal AND lnv_Item.of_GetEventTypeFlag ( ) <> n_Cst_constants.cs_ItemEventtype_MoveAccessorial THEN
			lb_Continue = FALSE 
		END IF
			
		IF lb_Continue THEN
			
			lc_EventType = uo_events.of_GetEventSource ( ).object.de_event_type[ ll_selevent ]
			
			IF pos("PHM", lc_EventType) > 0 then 
				lc_EventType = "P" 
			ELSE 
				lc_EventType = "D"
			END IF			
					
			if dwo.name = "comp_pu" then 
				lc_cltype = "P"
			else 
				lc_cltype = "D"
			END IF
					
			lb_Continue = lc_EventType = lc_cltype
					
		END IF			
	
		IF lb_Continue THEN
					
			IF lc_EventType = "P" then
						
				ll_newpu = ll_selevent
				ll_newdel = ll_curdel
				
				IF ll_newdel > ll_newpu THEN
					
					ll_newpu = ll_newpu
					
				ELSEIF ll_numevents > ll_newpu THEN
					
					ls_findstr = "pos('DRN', de_event_type) > 0"
					ll_foundrow = uo_events.of_GetEventSource ( ).find( ls_findstr, ll_newpu + 1, ll_numevents )
					
					IF ll_foundrow > 0 then 
						ll_newdel = ll_foundrow 
					ELSE
						ll_newdel = ll_Null
					END IF
					
				ELSE
					ll_newdel = ll_Null
				END IF
				
			ELSE
					
				ll_newdel = ll_selevent
				ll_newpu = ll_curpu
				
				if ll_newdel > ll_newpu and ll_newpu > 0 then
					
					ll_newdel = ll_newdel
					
				elseif ll_newdel > 1 then
					
					ls_findstr = "pos('PHM', de_event_type) > 0"
					ll_foundrow = uo_events.of_GetEventSource ( ).find( ls_findstr, ll_newdel - 1, 1 ) 
					
					IF ll_foundrow > 0 then 
						ll_newpu = ll_foundrow				
					END IF
					
				END IF
				
				IF ll_newdel > ll_newpu and ll_newpu > 0 then
					ll_newdel = ll_newdel
				ELSE
					
					mboxret = 1
					messagebox("Change Pickup/Delivery Assignments", "Cannot assign freight "+&
						"items to a delivery with no prior pickup.~n~nRequest cancelled.")
					lb_Continue = FALSE
					
				END IF
			END IF
			
			IF lb_Continue THEN
				lnv_Item.of_SetPuEvent ( ll_newpu )
				lnv_Item.of_SetDelEvent ( ll_newdel )
			END IF
				
		END IF
		
	
	
	END IF
END IF

DESTROY lnv_Item 
	
this.setredraw(true)

end event

event ue_getshipment;RETURN inv_Shipment
end event

event constructor;call super::constructor;il_Itemx = THIS.x
il_Itemy = THIS.y
il_ItemWidth = THIS.Width 
il_ItemHeight = THIS.Height
end event

event ue_itemdeleted;call super::ue_itemdeleted;IF dw_item_details.RowCount ( ) = 0 THEN
	dw_item_details.hide()
ELSE
	dw_item_details.Post ScrollToRow ( 1 ) 
	dw_item_details.Post SetRow ( 1 )
END IF


end event

event ue_deleteitem;call super::ue_deleteitem;Parent.wf_Delete_item( )
end event

type cb_details from u_cb within w_ship
integer x = 2510
integer y = 1000
integer width = 256
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer weight = 400
string text = "&More..."
end type

event clicked;n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm

lstr_Parm.is_Label = "Source"
lstr_Parm.ia_Value = w_disp.ds_ships
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "DISPATCHOBJECT"
lstr_Parm.ia_Value = Parent.wf_GetDispatchManager ( )
lnv_Msg.of_Add_Parm ( lstr_Parm )

OpenWithParm ( w_ShipmentDetail, lnv_Msg )
end event

event constructor;il_MoreX = THIS.X
il_Morey = THIS.y
end event

type cb_revenuesplits from commandbutton within w_ship
integer x = 2779
integer y = 1000
integer width = 448
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Re&venue Splits"
end type

event clicked;Parent.Event ue_RevenueSplits ( )
end event

event constructor;n_cst_privileges	lnv_Privileges

IF not lnv_Privileges.of_HasAuditRights ( ) THEN
	
	this.visible=FALSE
	
END IF

il_RevX = THIS.x
il_RevY = THIS.Y

end event

type cb_equipment from commandbutton within w_ship
integer x = 3241
integer y = 1000
integer width = 334
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Equipmen&t"
end type

event clicked;uo_intermodalview.Event ue_SyncEquipment ( )
Parent.Post Event ue_ShowEquipment ( )
end event

event constructor;n_cst_LicenseManager	lnv_LicenseMgr

THIS.Visible = lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch ) 

il_EquipX = THIS.X
il_EquipY = THIS.Y


end event

type uo_splits from u_cst_splitid within w_ship
event destroy ( )
integer x = 1317
integer y = 1000
integer width = 827
integer taborder = 30
boolean bringtotop = true
end type

on uo_splits.destroy
call u_cst_splitid::destroy
end on

event constructor;call super::constructor;il_SplitsX = THIS.X
il_SplitsY = THIS.y
end event

event ue_splitclicked;PARENT.wf_ManageSplits ( )
end event

event ue_iddblclick;call super::ue_iddblclick;Long	ll_ID
ll_ID = THIS.of_getsplitid( )

IF ll_ID > 0 THEN
	PARENT.display_ship( ll_ID )
END IF

RETURN 1
end event

type uo_intermodalview from u_cst_intermodalshipment within w_ship
integer x = 288
integer height = 1000
integer taborder = 10
boolean bringtotop = true
integer linesperpage = 100
end type

on uo_intermodalview.destroy
call u_cst_intermodalshipment::destroy
end on

event ue_chassispuadded;///* THIS doesn't seem to be called. I am going to leave it here for now though <<*>> */
//Long			lla_NewIds[]
//Boolean		lb_ConvertFirst
//Boolean		lb_ConvertLast
//Long			ll_ItemID
//Long			ll_Return = 1
//MessageBox ( "a" ,"CPU Added Called" ) 
//n_cst_RateData			lnva_RateData[]
//n_cst_beo_Item			lnv_Item
//n_csT_beo_Event		lnv_Event
//n_cst_bso_Dispatch 	lnv_Dispatch
//
//lnv_Dispatch = PARENT.wf_GetDispatchManager ( ) 
//lnv_Item = CREATE n_cst_beo_Item
//lnv_Event = CREATE n_cst_beo_Event
//
//lb_ConvertFirst = TRUE
//lb_ConvertLast = FALSE
//
//
//IF Not isValid ( lnv_Dispatch ) THEN
//	ll_Return = -1
//END IF
//
//IF ll_Return = 1 THEN
//	
//	IF NOT uo_Events.of_HasFrontChassisSplit ( ) THEN	
//		// see if the site is the same as the hook
//		lnv_Event.of_SetSource ( lnv_Dispatch.of_GetEventCache ( ) )
//		lnv_Event.of_SetSourceRow ( 1 ) 
//		IF lnv_Event.of_GetType ( ) = gc_dispatch.cs_EventType_Hook THEN
//			IF lnv_Event.of_GetSite ( ) <> al_companyid THEN			
//				IF inv_Shipment.of_AddChassisMove ( al_companyid ,  lnv_Dispatch, lla_newids, lb_ConvertFirst , lb_ConvertLast ) = 1 THEN
//					THIS.Event POST ue_FrontChassisSplitAdded ( )
//				END IF
//			END IF
//		END IF
//		
//	ELSE
//		
//		uo_Events.of_SetFrontChassisSplitSite ( al_companyid )
//		
//	END IF
//	
//END IF
//
//DESTROY ( lnv_Item ) 
//DESTROY ( lnv_Event ) 
//
//uo_events.Event ue_PostRefresh ( )
//
//RETURN ll_Return
//
//
RETURN -1
end event

event ue_chassisrtnadded;call super::ue_chassisrtnadded;
//////////////////////////////////////////////////////////////////////////
Long			lla_NewIds[]
Boolean		lb_ConvertFirst
Boolean		lb_ConvertLast
Long			ll_ItemID
Long			ll_RowCount
Long			ll_Return = 1


n_cst_Dws				lnv_Dws
n_cst_RateData			lnva_RateData[]
n_cst_beo_Item			lnv_Item
n_csT_beo_Event		lnv_Event
n_cst_bso_Dispatch 	lnv_Dispatch

lnv_Dispatch = PARENT.wf_GetDispatchManager ( ) 
lnv_Item = CREATE n_cst_beo_Item
lnv_Event = CREATE n_cst_beo_Event

lb_ConvertFirst = FALSE
lb_ConvertLast = TRUE




IF Not isValid ( lnv_Dispatch ) THEN
	ll_Return = -1
END IF

IF ll_Return = 1 THEN
	
	ll_RowCount = lnv_Dws.of_RowCount ( lnv_Dispatch.of_GetEventCache ( ) )
	
	IF NOT uo_Events.of_HasBackChassisSplit ( ) THEN	
		// see if the site is the same as the dismount
		lnv_Event.of_SetSource ( lnv_Dispatch.of_GetEventCache ( ) )
		lnv_Event.of_SetSourceRow ( ll_RowCount  ) 
		IF lnv_Event.of_GetType ( ) = gc_dispatch.cs_EventType_Drop THEN
			IF lnv_Event.of_GetSite ( ) <> al_siteid AND ll_rowCount > 2 THEN			
				IF inv_Shipment.of_AddChassisMove ( al_siteid ,  lnv_Dispatch, lla_newids, lb_ConvertFirst , lb_ConvertLast ) = 1 THEN
					THIS.Event POST ue_BackChassisSplitAdded ( )
				END IF
			END IF
		END IF
		
	ELSE
		
		uo_Events.of_SetBackChassisSplitSite ( al_siteid )
		
	END IF
	
END IF

DESTROY ( lnv_Item ) 
DESTROY ( lnv_Event ) 

uo_events.Event ue_PostRefresh ( )

RETURN ll_Return

end event

event ue_getshipment;RETURN inv_Shipment
end event

event ue_getdispatch;RETURN Parent.wf_GetDispatchManager ( )
end event

event ue_addchassissplit;call super::ue_addchassissplit;uo_events.Event ue_PostRefresh ( )
Return 1
//RETURN PARENT.wf_JumpShipment ( inv_Shipment.of_GetID ( ) , TRUE )
end event

event ue_getshiptypemanager;RETURN inv_shiptypemanager
end event

event ue_frontchassissplitadded;PARENT.wf_JumpShipment ( inv_Shipment.of_GetId ( ), TRUE /*Force redisplay*/ )

//uo_itemList.event ue_Refresh ( )
//uo_events.Event Post ue_Postrefresh ( )
//MessageBox ("A" , "a" )

/* THIS doesn't seem to be called. I am going to leave it here for now though <<*>> */
//Long						ll_ItemCount
//Long						ll_Hook
//Long						ll_Mount
//
//n_cst_bso_dispatch	lnv_Dispatch
//n_cst_beo_Item			lnva_Items[]
//
//n_cst_Events			lnv_Events
//MessageBox ( "A" , "FCSA Called in ship" )
//
//lnv_Dispatch = Parent.wf_GetDispatchManager ( )
//
//ll_ItemCount = inv_Shipment.of_getitemsforeventtype (n_cst_constants.cs_itemeventtype_frontchassissplit, lnva_Items ) 
//
//lnv_Events.of_GetFrontChassisSplitSites ( ll_Hook , ll_Mount , lnv_Dispatch.of_GetEventCache ( ) )
//
//IF ll_ItemCount = 0 THEN
//	IF ll_Hook <> ll_Mount THEN
//		inv_Shipment.of_AddFrontChassisSplitItem ( lnv_Dispatch )
//	END IF
//END IF
//
//n_cst_anyarraysrv	lnv_arraySrv
//lnv_ArraySrv.of_Destroy ( lnva_Items )
//
//
//
end event

event ue_backchassissplitadded;uo_itemList.event ue_Refresh ( )
PARENT.wf_JumpShipment ( inv_Shipment.of_GetId ( ), TRUE /*Force redisplay*/ )
/* THIS doesn't seem to be called. I am going to leave it here for now though <<*>> */
//Long						ll_ItemCount
//Long						ll_Dismount
//Long						ll_Drop
//
//n_cst_bso_dispatch	lnv_Dispatch
//n_cst_beo_Item			lnva_Items[]
//
//n_cst_Events			lnv_Events
//
//lnv_Dispatch = Parent.wf_GetDispatchManager ( )
//
//ll_ItemCount = inv_Shipment.of_getitemsforeventtype (n_cst_constants.cs_itemeventtype_Backchassissplit, lnva_Items ) 
//
//lnv_Events.of_GetBackChassisSplitSites ( ll_Dismount , ll_Drop , lnv_Dispatch.of_GetEventCache ( ) )
//
//IF ll_ItemCount = 0 THEN
//	IF ll_Dismount <> ll_Drop THEN
//		inv_Shipment.of_AddBackChassisSplitItem ( lnv_Dispatch )
//	END IF
//END IF
//
//n_cst_anyarraysrv	lnv_arraySrv
//lnv_ArraySrv.of_Destroy ( lnva_Items )


end event

event ue_trailerpuchanged;call super::ue_trailerpuchanged;//I don't think this is called
//Long		ll_Hook
//Long		ll_Mount
//Long		ll_Chassis
//
//n_cst_Events		lnv_Events
//n_cst_bso_Dispatch lnv_Dispatch
//
//lnv_Dispatch = PARENT.wf_GetDispatchManager ( ) 
//
//IF isValid ( lnv_Dispatch ) THEN
//	IF lnv_Events.of_HasFrontChassisSplit ( lnv_Dispatch.of_GetEventCache ( ) ) THEN
//		lnv_Events.of_GetFrontChassisSplitSites ( ll_Hook , ll_Mount , lnv_Dispatch.of_GetEventCache ( ) )
//		IF ll_Hook <> ll_Mount THEN
//			THIS.Event ue_FrontChassisSplitAdded ( ) 
//		END IF	
//	ELSE
//		ll_Chassis =	uo_intermodalview.of_GetChassisPuSite ( ) 
//		IF ll_Chassis <> al_id THEN
//			THIS.Event Post ue_ChassisPuAdded ( ll_Chassis )
//		END IF
//	END IF
//
//END IF


RETURN 1
end event

event ue_trailerrtnchanged;call super::ue_trailerrtnchanged;//I don't think this is called

//Long		ll_Dismount
//Long		ll_Drop
//Long		ll_Chassis
//Long		ll_RowCount
//n_cst_Dws			lnv_Dws
//n_cst_Events		lnv_Events
//n_cst_bso_Dispatch lnv_Dispatch
//
//lnv_Dispatch = PARENT.wf_GetDispatchManager ( ) 
//
//IF isValid ( lnv_Dispatch ) THEN
//	
//	ll_RowCount = lnv_Dws.of_RowCount ( lnv_Dispatch.of_GetEventCache ( ) )
//	
//	IF lnv_Events.of_HasBackChassisSplit ( lnv_Dispatch.of_GetEventCache ( ) ) THEN
//		lnv_Events.of_GetBackChassisSplitSites ( ll_Dismount , ll_Drop , lnv_Dispatch.of_GetEventCache ( ) )
//		IF ll_Dismount <> ll_Drop THEN
//			THIS.Event ue_BackChassisSplitAdded ( ) 
//		END IF	
//	ELSE
//		ll_Chassis = uo_intermodalview.of_GetChassisRtnLocation ( ) 
//		IF ll_Chassis <> al_id AND ll_RowCount > 2 THEN
//			THIS.Event Post ue_ChassisRtnAdded ( ll_Chassis )
//		END IF
//	END IF
//
//END IF
//
//
RETURN 1
end event

event ue_displayshipment;RETURN Parent.wf_JumpShipment ( al_id , TRUE )

//THIS.Event ue_ShipmentChanged ( inv_Shipment )
end event

event ue_getshiptype;RETURN PARENT.wf_GetShipType ( )
end event

event ue_shiptypechanged;PARENT.Post wf_DetermineContext ( )
RETURN 1
end event

event ue_ppcolchanged;uo_intermodalview.Post of_SyncBillTo ( )		
set_title()

end event

event ue_billformatchanged;String	ls_BillFormat

IF isValid ( inv_Shipment ) THEN
	ls_BillFormat = inv_Shipment.of_GetBillingFormat ( ) 
	dw_item_details.modify("txt_bill_ind.text = '" + ls_BillFormat + "'")
	dw_item_details.Hide ( )	
END IF
end event

event ue_billtochanged;n_Cst_beo_Company	lnv_Company	
lnv_Company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID ( inv_Shipment.of_GetBillTo ( ) ) 
PARENT.wf_GetAlertmanager( ).of_ShowAlerts( {lnv_Company} )

DESTROY ( lnv_Company )



Parent.Set_Title ( )
end event

event ue_preremovesplit;IF dw_item_details.RowCount ( ) > 0 THEN
	dw_item_details.SetRow ( 1 )
END IF
end event

event ue_refreshshipment;uo_events.of_ResetRange ( )
uo_itemlist.post of_ResetRange ( )
w_disp.wf_reset_times(1, "SHIP!")
Parent.set_Title (  )

end event

event ue_payformatchanged;String	ls_PayFormat

IF isValid ( inv_Shipment ) THEN
	ls_PayFormat = inv_Shipment.of_GetPayableFormat ( ) 
	dw_item_details.modify("txt_Pay_ind.text = '" + ls_PayFormat + "'")
	dw_item_details.Hide ( )	
END IF
end event

event ue_equipmentlocationchanged;call super::ue_equipmentlocationchanged;n_Cst_beo_Company	lnv_Company	
lnv_Company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID ( al_siteid ) 
PARENT.wf_GetAlertmanager( ).of_ShowAlerts( {lnv_Company} )

DESTROY ( lnv_Company )
end event

type cb_1 from commandbutton within w_ship
integer x = 2149
integer y = 1000
integer width = 347
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Notification"
end type

event clicked;S_Parm	lstr_Parm
n_Cst_Msg	lnv_Msg

lstr_Parm.is_Label = "SHIPMENT"
lstr_Parm.ia_Value = inv_Shipment
lnv_Msg.of_Add_Parm ( lstr_Parm )

OpenWithParm ( w_shipmentNotification , lnv_Msg ) 



end event

event constructor;n_cst_LicenseManager	lnv_Lic
THIS.Enabled = lnv_Lic.of_HasNotificationLicense( )
end event

type dw_item_details from u_dw_itemdetails within w_ship
event ue_processenter pbm_dwnprocessenter
event ue_processkey pbm_dwnkey
boolean visible = false
integer x = 741
integer y = 160
integer width = 1719
integer taborder = 0
boolean bringtotop = true
end type

event ue_processenter;send(handle(this), 256, 9, long(0, 0))
return 1
end event

event ue_processkey;//if keydown(keydownarrow!) or keydown(keypagedown!) or keydown(keyuparrow!) or &
//	keydown(keypageup!) then
//		if keydown(keydownarrow!) then
//			dw_item_list.post scrollnextrow()
//		elseif keydown(keyuparrow!) then
//			dw_item_list.post scrollpriorrow()
//		elseif keydown(keycontrol!) and keydown(keypagedown!) then
//			dw_item_list.post scrolltorow(dw_item_list.rowcount())
//		elseif keydown(keycontrol!) and keydown(keypageup!) then
//			dw_item_list.post scrolltorow(1)
//		elseif keydown(keypagedown!) then
//			dw_item_list.post scrollnextpage()
//		elseif keydown(keypageup!) then
//			dw_item_list.post scrollpriorpage()
//		end if
//		return 1
//end if
end event

event ue_getshipment;RETURN inv_Shipment
end event

event ue_getdispatch;RETURN PARENT.wf_GetDispatchManager ( )
end event

event clicked;call super::clicked;decimal lc_miles
long ll_miles, ll_pu_event, ll_del_event
//Modified byd dan 2-9-07 to use a different priv if the shipment is billed
String	ls_privFunction
IF inv_shipment.of_isBilled( ) THEN
	ls_privFunction = appeon_constant.Cs_modifyBilledSHip
ELSE
	ls_privFunction = "ModifyShipment"
END IF
/////////////////
IF gnv_app.of_getprivsmanager( ).of_getuserpermissionfromfn( ls_privFunction, inv_shipment ) = appeon_constant.ci_True THEN
	choose case dwo.name
	case "cb_leg_miles", "cb_total_miles"
		choose case dwo.name
		case "cb_leg_miles"
			ll_pu_event = this.object.di_pu_event[row]
			ll_del_event = this.object.di_del_event[row]
			if ll_pu_event > 0 and ll_del_event > 0 then
				w_disp.wf_get_miles(ll_pu_event, ll_del_event, lc_miles)
	//		else
	//			I'm going to let this set miles to 0 instead
	//			beep(1)
	//			return
			end if
		case "cb_total_miles"
			w_disp.wf_get_miles(null_long, null_long, lc_miles)	
		end choose
		lc_miles = round(lc_miles, 0)
		this.setfocus()
		if this.getcolumnname() = "di_miles" then
		else
			if this.setcolumn("di_miles") = 1 then
			else
				return
			end if
		end if
		this.settext(string(lc_miles, "0"))
		this.selecttext(1, len(this.gettext()))
		
	CASE "b_savedrates" 
		Parent.wf_RateQuery ( TRUE ) 
		
		
	end choose
END IF
end event

event ue_additem;Int	li_Return

IF PARENT.wf_Add_Item ( as_type ) = 1 THEN
	li_Return = 1
END IF


RETURN li_Return

end event

event rowfocuschanged;call super::rowfocuschanged;uo_itemlist.of_SetRow ( currentrow )
end event

event ue_ratelookup;call super::ue_ratelookup;Parent.event ue_ratelookup( ab_createnew )

RETURN 1
end event

event ue_deleteitem;call super::ue_deleteitem;Parent.wf_Delete_item( )
end event

event ue_setredraw;call super::ue_setredraw;//added by Dan 8-1-06, this event was added to fix a flicker problem.
this.setRedraw( ab_redraw )
parent.setRedraw( ab_redraw )
end event

type dw_event_details from u_dw_eventdetail within w_ship
boolean visible = false
integer x = 315
integer y = 96
integer height = 876
integer taborder = 0
boolean bringtotop = true
end type

event itemchanged;call super::itemchanged;//This assumes, with the exception of de_conf,  that information that shouldn't be 
//editable based on status is protected, so there's no validation done here

n_cst_beo_Event		lnv_Event
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_OFRError			lnva_Errors[]
String	ls_ErrorMessage
//Long	ll_EventID
Long	ll_Return
ll_Return = AncestorReturnValue

lnv_Event = CREATE n_cst_beo_Event

choose case dwo.name
		
case "de_conf"
	IF ll_Return = 0 THEN
		//ll_EventID = THIS.GetItemNumber( row , "de_id" )
		
		lnv_Dispatch = Parent.wf_GetDispatchManager ( )
		//If there's an error, we'll want to get the error message, so clear the error stack.
		lnv_Dispatch.ClearOFRErrors ( )
	
		lnv_Event.of_SetSource ( This )
		lnv_Event.of_SetSourceRow ( Row )
	
		if data = "T" then
	
			IF lnv_Dispatch.of_ConfirmEvent ( lnv_Event.of_GetID ( ) , TRUE /*Interactive*/ ) = -1 THEN
	
				IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
					//There are errors to process -- Get the error text
					ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
				ELSE
					ls_ErrorMessage = "Could not confirm event completion.~n(Unspecified error.)"
				END IF
	
				MessageBox ( "Confirm Event Completion", ls_ErrorMessage )
				This.SetText ( "F" )
				DESTROY ( lnv_Event ) 
				RETURN 2
	
			END IF
	
		else
	
			//First, since this event is part of a shipment, check if it's ok with the shipment to unconfirm it.
			//Then, if that's ok, go ahead and attempt to unconfirm the event.
	
			IF inv_Shipment.of_UnconfirmEvent ( ) < 1 THEN
	
				//The above call provides it's own message if it fails.
				This.SetText ( "T" )
				DESTROY ( lnv_Event ) 
				RETURN 2
	
			ELSEIF lnv_Dispatch.of_UnconfirmEvent ( lnv_Event.of_GetId ( ), TRUE /*Interactive*/ ) = -1 THEN
	
				IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
					//There are errors to process -- Get the error text
					ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
				ELSE
					ls_ErrorMessage = "Could not clear event confirmation.~n(Unspecified error.)"
				END IF
	
				MessageBox ( "Clear Event Confirmation", ls_ErrorMessage )
				This.SetText ( "T" )
				DESTROY ( lnv_Event ) 
				RETURN 2
	
			END IF
	
		end if
		
		
		THIS.of_CheckNotifications ( lnv_Event )
		uo_intermodalview.Post Event ue_SyncEquipment ( )
	END IF

end choose

DESTROY ( lnv_Event ) 


RETURN ll_Return
end event

event ue_setscrollcolumn;scroll_column = as_ScrollColumn


end event

event rbuttondown;call super::rbuttondown;string lsa_parm_labels[]
any laa_parm_values[]
IF AncestorReturnValue = 0 THEN
	if upper(dwo.type) = "DATAWINDOW" then
		lsa_parm_labels[1] = "MENU_TYPE"
		laa_parm_values[1] = "PRINT"
		lsa_parm_labels[2] = "PRINT_OBJECT"
		laa_parm_values[2] = this
		f_pop_standard(lsa_parm_labels, laa_parm_values)
//	else
//		Parent.Post Event show_Pop ( dwo , row , "" ) 
//		
	end if
END IF
end event

event constructor;call super::constructor;This.Event ue_MakePopup ( )
This.of_SetEventList ( uo_events.of_getEventSource ( ) )
end event

event ue_prechangesite;call super::ue_prechangesite;Integer	li_Return

li_Return = AncestorReturnValue

IF AncestorReturnValue = 1 THEN
	ids_orfin_events.reset()
	w_disp.ds_events.rowscopy(1, w_disp.ds_events.rowcount(), primary!, &
		ids_orfin_events, 9999, primary!)
END IF

RETURN li_Return
end event

event ue_postchangesite;call super::ue_postchangesite;//Provide PostChangeSite processing specific to this instance.

w_disp.post wf_reset_times(al_Row, "SHIP!")
this.post setredraw(true)
uo_events.post of_setredraw(true)
//IF NOT inv_Shipment.of_IsIntermodal ( ) THEN
//	parent.post wf_check_orfin(ids_orfin_events)
//END IF

n_Cst_beo_Company	lnv_Company	
lnv_Company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID ( al_new ) 
PARENT.wf_GetAlertmanager( ).of_ShowAlerts( {lnv_Company} )

DESTROY ( lnv_Company )

IF isValid ( inv_Shipment ) THEN
	inv_Shipment.of_CompanyAdded ( al_new )
END IF



end event

event ue_cancelnotification;RETURN Parent.wf_GetDispatchManager ( ).of_GetnotificationManager ( ).of_RemovePendingNotification ( anv_event )
end event

event ue_getnotificationerror;RETURN Parent.wf_GetDispatchManager ( ).of_GetnotificationManager ( ).of_GetNotificationError ( anv_ptbeo )
end event

event ue_processinterchange;w_Disp.Event ue_ProcessInterchange ( al_eventid )
RETURN 1
end event

event ue_firsthooksitechanged;n_cst_Events	lnv_Events

IF inv_Shipment.of_IsIntermodal ( ) THEN
	IF lnv_Events.of_HasFrontChassisSplit ( THIS ) THEN
		uo_intermodalview.of_SetChassisPuSite ( al_site )
	ELSE
		uo_intermodalview.of_SetTrailerPuSite ( al_site )
	END IF
	inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_Frontchassissplit )
END IF

RETURN 1
end event

event ue_lastdropsitechanged;n_cst_Events	lnv_Events
IF inv_Shipment.of_IsIntermodal ( ) THEN
	IF lnv_Events.of_HasBackChassisSplit ( THIS ) THEN
		uo_intermodalview.of_SetChassisRtnSite ( al_siteid )
	ELSE
		uo_intermodalview.of_SetTrailerRtnSite ( al_siteid )
	END IF
	inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_Backchassissplit )
END IF
RETURN 1
end event

event ue_firstmountsitechanged;IF inv_Shipment.of_IsIntermodal ( ) THEN
	uo_intermodalview.of_SetTrailerPuSite ( al_Site )
	inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_Frontchassissplit )
END IF
RETURN 1
end event

event ue_lastdismountsitechanged;IF inv_Shipment.of_IsIntermodal ( ) THEN
	uo_intermodalview.of_SetTrailerRtnSite ( al_siteid )
	inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_Backchassissplit )
END IF
RETURN 1
end event

event ue_getshipment;RETURN inv_Shipment
end event

event ue_origindestchanged;uo_intermodalview.Post of_SyncBillTo ( )
Parent.set_Title (  )
end event

event ue_getdispatchmanager;RETURN Parent.wf_GetDispatchManager ( )
end event

event ue_addnotification;// RDT 5-13-03 new line added
RETURN Parent.wf_GetDispatchManager ( ).of_GetnotificationManager ( ).of_CreatePendingNotification ( anv_event )
end event

event ue_postdatetimeedit;call super::ue_postdatetimeedit;n_cst_licensemanager	lnv_licensemanager

IF lnv_LicenseManager.of_HasEDI214License() OR &
	lnv_LicenseManager.of_HasEDI322License() THEN
	//save event for edi message
	n_cst_bso_dispatch	lnv_dispatch
	n_cst_beo_event		lnv_event
	
	lnv_Event = CREATE n_cst_beo_Event
	
	lnv_Dispatch = Parent.wf_GetDispatchManager ( )
	lnv_Event.of_SetSource ( This )
	lnv_Event.of_SetSourceRow ( al_row )
	lnv_Event.of_SetContext(lnv_Dispatch)
	
	choose case as_colname
		case "de_arrdate"
			lnv_Event.of_SetDateArrived(date(as_data))
			
		case "de_arrtime"
			lnv_Event.of_SetTimeArrived(time(as_data))
			
		case "de_deptime"
			lnv_Event.of_SetTimeDeparted(time(as_data))
	
		case "de_apptdate"
			lnv_Event.of_SetScheduleddate(date(as_data))
			
		case "de_appttime"
			lnv_Event.of_SetScheduledtime(time(as_data))
			
	end choose
		
	destroy lnv_event	

end if
	

end event

type cb_removerouting from u_cb within w_ship
integer x = 1769
integer y = 1412
integer width = 539
integer height = 68
integer taborder = 90
boolean bringtotop = true
integer weight = 400
string text = "Remove Routing..."
end type

event clicked;Parent.Event ue_RemoveRouting ( )
end event

event constructor;call super::constructor;n_cst_Privileges_Events  lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

