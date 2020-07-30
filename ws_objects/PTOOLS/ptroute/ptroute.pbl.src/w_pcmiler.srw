$PBExportHeader$w_pcmiler.srw
forward
global type w_pcmiler from Window
end type
type cb_print from commandbutton within w_pcmiler
end type
type dw_location from u_dw within w_pcmiler
end type
type cbx_open_borders from checkbox within w_pcmiler
end type
type cbx_hub_on from checkbox within w_pcmiler
end type
type cb_run from commandbutton within w_pcmiler
end type
type cb_map from commandbutton within w_pcmiler
end type
type cb_directions from commandbutton within w_pcmiler
end type
type cb_deltrip from commandbutton within w_pcmiler
end type
type gb_4 from groupbox within w_pcmiler
end type
type gb_2 from groupbox within w_pcmiler
end type
type rb_air from radiobutton within w_pcmiler
end type
type rb_avoid from radiobutton within w_pcmiler
end type
type rb_natl from radiobutton within w_pcmiler
end type
type rb_shortest from radiobutton within w_pcmiler
end type
type rb_practical from radiobutton within w_pcmiler
end type
type dw_pcm from datawindow within w_pcmiler
end type
type ddlb_trip from dropdownlistbox within w_pcmiler
end type
end forward

type routetype from structure
	integer		milez
	integer		vect
end type

global type w_pcmiler from Window
int X=5
int Y=4
int Width=3401
int Height=1636
boolean TitleBar=true
string Title="PC*Miler Interface"
string MenuName="m_pcmiler"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_print cb_print
dw_location dw_location
cbx_open_borders cbx_open_borders
cbx_hub_on cbx_hub_on
cb_run cb_run
cb_map cb_map
cb_directions cb_directions
cb_deltrip cb_deltrip
gb_4 gb_4
gb_2 gb_2
rb_air rb_air
rb_avoid rb_avoid
rb_natl rb_natl
rb_shortest rb_shortest
rb_practical rb_practical
dw_pcm dw_pcm
ddlb_trip ddlb_trip
end type
global w_pcmiler w_pcmiler

type prototypes
FUNCTION integer prophesy ( integer nParmCt, string lpszParms[], &
	string lpszStops[], string lpszErrFileName, string lpszOutFileName, &
	string lpszDPath ) LIBRARY "batch32.dll" alias for "prophesy;Ansi"

end prototypes

type variables
protected:
integer max_trips = 5, lasttrip
long tripid[6]
n_cst_trip		inv_trip[5]
n_cst_routing	inv_routing[5]
string		is_tripcalced[5]
decimal		ic_milecost[5]
w_map 		iw_map
w_map_streets	iw_mapstreets
w_pcreport reportwin
boolean win_is_closing = false
boolean		ib_isstreets
boolean		ib_isoldpcmilerversion
datastore		ids_trip[5]
end variables

forward prototypes
public function integer reset_face ()
public function integer uncalc_trip ()
public function integer wf_insert_stop ()
public function integer wf_delete_stop ()
public subroutine wf_calc_trip ()
public subroutine wf_clear_trip ()
public function integer change_trip (integer ai_newtrip, routetype router)
private function integer wf_addlocation (string as_location)
public subroutine wf_optimize ()
private function integer wf_print ()
end prototypes

public function integer reset_face ();dw_location.setredraw(false)
//save cost
decimal	lc_cost
lc_cost = dw_location.object.permilecost[1]
dw_location.reset()
dw_location.insertrow(0)
dw_location.object.permilecost[1] = lc_cost
if ib_isstreets then
	dw_location.object.isstreets[1] = "Y"
else
	dw_location.object.isstreets[1] = "N"
end if
dw_location.setredraw(true)
dw_location.setfocus()

dw_pcm.setredraw(false)
dw_pcm.reset()
dw_pcm.insertrow(0)
dw_pcm.selectrow(1, true)
dw_pcm.object.st_tottime.text = ""
dw_pcm.modify("st_calced.text = 'no'")
dw_pcm.object.st_hub.text = "off"
dw_pcm.setredraw(true)

rb_practical.checked = true
cbx_open_borders.checked = true
cbx_hub_on.checked = false

if isvalid (iw_map) then close(iw_map)
if isvalid (iw_mapstreets) then close(iw_mapstreets)
if isvalid (reportwin) then close(reportwin)

return 0


end function

public function integer uncalc_trip ();integer	li_selectedtrip, &
			lcv

li_selectedtrip = integer(right(trim(ddlb_trip.text), 1))

if li_selectedtrip <= 0 then return -1
if tripid[li_selectedtrip] = 0 then return -1

dw_pcm.setredraw(false)

for lcv = 1 to dw_pcm.rowcount()
	dw_pcm.setitem(lcv, "totmiles", null_dec)
	dw_pcm.setitem(lcv, "legmiles", null_dec)
	dw_pcm.setitem(lcv, "tyme", null_str)
	dw_pcm.setitem(lcv, "legtyme", null_str)
	dw_pcm.setitem(lcv, "cost", null_dec)
next
dw_pcm.object.st_tottime.text = ""
dw_pcm.modify("st_calced.text = 'no'")
is_tripcalced[li_selectedtrip]='no'
inv_routing[li_selectedtrip].of_deletetrip(tripid[li_selectedtrip])
tripid[li_selectedtrip] = 0


dw_pcm.setredraw(true)
return 0


end function

public function integer wf_insert_stop ();long ll_selrow, ll_newrow
n_cst_numerical lnv_numerical

ll_selrow = dw_pcm.getselectedrow(0)
if lnv_numerical.of_IsNullOrNotPos(ll_selrow) then ll_selrow = 1

ll_newrow = dw_pcm.insertrow(ll_selrow)

if ll_newrow > 0 then
	dw_pcm.selectrow(0, false)
	dw_pcm.selectrow(ll_newrow, true)
	dw_location.setredraw(false)
	dw_location.reset()
	dw_location.insertrow(0)
	dw_location.setredraw(true)
	dw_location.setfocus()
else
	return -1
end if

return 1
end function

public function integer wf_delete_stop ();string	ls_pcm
long ll_selrow, ll_rowloop
n_cst_numerical lnv_numerical

ll_selrow = dw_pcm.getselectedrow(0)
if lnv_numerical.of_IsNullOrNotPos(ll_selrow) then return -1

dw_pcm.setredraw(false)

dw_pcm.deleterow(ll_selrow)

if ll_selrow > dw_pcm.rowcount() then
	dw_pcm.insertrow(0)
else
	//if no pcm, this is a blank row
	ls_pcm = dw_pcm.object.pcm[ll_selrow]
	if len(trim(ls_pcm)) > 0 then
		dw_pcm.setitem(ll_selrow, "totmiles", null_dec)
		dw_pcm.setitem(ll_selrow, "legmiles", null_dec)
		dw_pcm.setitem(ll_selrow, "tyme", null_str)
		dw_pcm.setitem(ll_selrow, "legtyme", null_str)
		dw_pcm.setitem(ll_selrow, "cost", null_dec)
		
		dw_pcm.object.st_tottime.text = ""
		dw_pcm.modify("st_calced.text = 'no'")
		is_tripcalced[lasttrip]='no'

	end if
end if

dw_pcm.selectrow(0, false)
dw_pcm.selectrow(ll_selrow, true)

dw_pcm.setredraw(true)

dw_pcm.postevent(clicked!)
inv_routing[lasttrip].of_deletetrip(tripid[lasttrip])
tripid[lasttrip] = 0

return 1
end function

public subroutine wf_calc_trip ();setpointer(HourGlass!)
string 	ls_locater, &
			ls_city, &
			ls_state, &
			ls_zip

integer  alpha_o = 1, &
			borders, &
			hubmode, &
			changedest = 1, &
			miler = 1, &
			li_selectedtrip, &
			li_matches, &
			li_return = 1
			
long		ll_ndx, &
			ll_rowcount
			
routetype router

if li_return = 1 then
	li_selectedtrip = integer(right(trim(ddlb_trip.text), 1))

	if li_selectedtrip <= 0 then 
		li_return = -1
	else
		//set trip options
		if rb_practical.checked = true then
			router.milez = 0
		elseif rb_shortest.checked = true then
			router.milez = 1
		elseif rb_natl.checked = true then
			router.milez = 2
		elseif rb_avoid.checked = true then
			router.milez = 3
		elseif rb_air.checked = true then
			router.milez = 4
		end if
		 
		if cbx_open_borders.checked = true then 
			borders = 1
		else
			borders = 0
		end if
	
		if cbx_hub_on.checked = true then
			hubmode = 1
		else
			hubmode = 0
		end if
		router.vect = (16 * alpha_o) + (8 * borders) + (4 * hubmode) + (2 * changedest) + (1 * miler) 
//		router.vect = (16 * alpha_o) + (2 * changedest) + (1 * miler) 
	end if
end if

if li_return = 1 then
	//remove any rows with invalid locaters
	ll_rowcount = dw_pcm.rowcount()
	for ll_ndx = ll_rowcount - 1 to 1 step -1
		ls_locater = dw_pcm.getitemstring(ll_ndx, "pcm")
		if len(trim(ls_locater)) = 0 or isnull(ls_locater) then dw_pcm.deleterow(ll_ndx)
	next

	if dw_pcm.find("len(trim(pcm)) > 0", dw_pcm.rowcount(), 1) < 2 then
		messagebox("Run Trip Calculation", "There must be more than one stop before trip is calculated.")
		li_return = -1
	end if
end if	

if li_return = 1 then	
	inv_trip[li_selectedtrip].of_clearstops(tripid[li_selectedtrip])
	ll_rowcount = dw_pcm.rowcount()
	//load trip
	for ll_ndx = 1 to ll_rowcount
		ls_locater = dw_pcm.getitemstring(ll_ndx, "pcm")
		if len(ls_locater) > 0 then
			inv_trip[li_selectedtrip].of_addstop(ls_locater)		
		end if
	next

	if inv_trip[li_selectedtrip].of_getstopscount() = 0 then 
		li_return = -1
	end if
end if
if li_return = 1 then
	change_trip(li_selectedtrip, router)
end if


end subroutine

public subroutine wf_clear_trip ();//This is the script that Megan had in cb_deltrip (no revisions)

integer li_selectedtrip

li_selectedtrip = integer(right(trim(ddlb_trip.text), 1))

if li_selectedtrip < 1 then return 

if tripid[li_selectedtrip] <> 0 then
	if isvalid(inv_routing[li_selectedtrip]) then
		//proceed
	else
		//need to reconnect to object
		inv_trip[li_selectedtrip].of_connect(inv_routing[li_selectedtrip])
	end if
	inv_routing[li_selectedtrip].of_deletetrip(tripid[li_selectedtrip])
	tripid[li_selectedtrip] = 0
end if

reset_face()
end subroutine

public function integer change_trip (integer ai_newtrip, routetype router);setpointer(HourGlass!)
integer	li_return = 1

if ai_newtrip <= 0 or tripid[ai_newtrip] = 0 then 
	if inv_trip[ai_newtrip].of_connect(inv_routing[ai_newtrip]) then
		if inv_routing[ai_newtrip].of_isvalid() then
			tripid[ai_newtrip] = inv_trip[ai_newtrip].of_createtrip()
			if tripid[ai_newtrip] <= 0 then 
				messagebox("Programmer's Warning", "PC*Miler cannot create the trip id??")
				li_return = -1
			end if
		else
			messagebox("Programmer's Warning", "PC*Miler cannot create the trip id??")
			li_return = -1
		end if
	else
		messagebox("Programmer's Warning", "PC*Miler cannot create the trip id??")
		li_return = -1
	end if
	if isnull(router.vect) or router.vect <= 0 then router.vect = 31
	if isnull(router.milez) or router.milez < 0 then router.milez = 0
end if

if li_return = 1 then
	
	decimal	lc_totaldistance, &
				lc_totallegdistance, &
				lc_legdistance, &
				lc_cost
	
	long		ll_totalminutes, &
				ll_totallegminutes, &
				ll_legminutes, &
				ll_null, &
				ll_option, &
				ll_ndx, &
				ll_stopcount
				
	string	ls_locater, &
				ls_legtime, &
				ls_totaltime
				
	integer	li_hours
	time		test_time
	n_cst_trip_attribs lds_data	
	setnull(ll_null)
	lds_data = create n_cst_trip_attribs
	
	
	if isvalid(reportwin) then close(reportwin)
	if isvalid(iw_map) then close(iw_map)
	if isvalid(iw_mapstreets) then close(iw_mapstreets)
	lc_cost = dw_location.object.permilecost[1]
	ic_milecost[ai_newtrip] = lc_cost
	dw_pcm.setredraw(false)
	setpointer(HourGlass!)
	//sethubmode
	inv_trip[ai_newtrip].of_setbordersopen(tripid[ai_newtrip], cbx_open_borders.checked)
	inv_trip[ai_newtrip].of_sethubmode(tripid[ai_newtrip], cbx_hub_on.checked)
	inv_trip[ai_newtrip].of_calculatetrip(tripid[ai_newtrip], router.vect, router.milez, lc_cost, lc_totaldistance, ll_totalminutes)
	ll_stopcount = inv_trip[ai_newtrip].of_getstops(lds_data)
	for ll_ndx = 1 to ll_stopcount
		
		lc_legdistance = lds_Data.Object.Distance[ll_ndx]
		ll_legminutes = lds_Data.Object.Minutes[ll_ndx]
		lc_cost = lds_Data.Object.Cost[ll_ndx]
		
		if cbx_hub_on.checked then
			lc_totallegdistance = lc_legdistance
			ll_totallegminutes = ll_legminutes
		else
			lc_totallegdistance += lc_legdistance
			ll_totallegminutes += ll_legminutes
		end if
		
		li_hours = truncate(ll_legminutes / 60.0,0)
		ll_legminutes = ll_legminutes - li_hours * 60
		ls_legtime = string(li_hours, "0") + ":" + string(ll_legminutes, "00")
		
		li_hours = truncate(ll_totallegminutes / 60.0,0)
		ll_legminutes = ll_totallegminutes - li_hours * 60
		ls_totaltime = string(li_hours, "0") + ":" + string(ll_legminutes, "00")
		
		dw_pcm.setitem(ll_ndx, "totmiles", lc_totallegdistance)
		dw_pcm.setitem(ll_ndx, "legmiles", lc_legdistance)
		dw_pcm.setitem(ll_ndx, "tyme", ls_totaltime)
		dw_pcm.setitem(ll_ndx, "legtyme", ls_legtime)
		dw_pcm.setitem(ll_ndx, "cost", lc_cost)
		
	//	test_time = time(ls_totaltime)
	//	dw_pcm.setitem(ll_ndx, "duration", time(ls_totaltime))
		
	next
	dw_pcm.object.st_tottime.text = ls_totaltime 
			
	dw_pcm.setredraw(true)
	dw_location.setfocus()
	dw_pcm.selectrow(0, false)
	if dw_pcm.rowcount() > 0 then
		if len(trim(dw_pcm.getitemstring(dw_pcm.rowcount(), "pcm"))) > 0 then &
			dw_pcm.insertrow(0)
	else
		dw_pcm.insertrow(0)
	end if
	dw_pcm.selectrow(dw_pcm.rowcount(), true)
	dw_pcm.modify("st_calced.text = 'yes'")
	is_tripcalced[ai_newtrip]='yes'
	li_return = 0
end if

return li_return

end function

private function integer wf_addlocation (string as_location);if win_is_closing = true then return 0
integer	li_selectedtrip, &
			li_return = 0, &
			li_selected
string	ls_locater, &
			ls_foundlocater, &
			ls_city, &
			ls_state, &
			ls_zip, &
			ls_stop
			
li_selectedtrip = integer(right(trim(ddlb_trip.text), 1))

if li_selectedtrip < 1 then return -1

if tripid[li_selectedtrip] = 0 then
	
	inv_trip[li_selectedtrip] = create n_cst_trip

	if inv_trip[li_selectedtrip].of_connect(inv_routing[li_selectedtrip]) then
		if inv_routing[li_selectedtrip].of_isvalid() then
			//ok
//			tripid[li_selectedtrip] =
		else
			messagebox("Programmer's Warning","Could not instatiate trip id.")
			li_return = -1
		end if
	end if
else
//	pcmsclearstops(tripid[li_selectedtrip])
end if

li_selected = dw_pcm.getselectedrow(0)
if li_selected = 0 then
	messagebox("", "Select a row to set.")
	li_return = -1
end if

if li_return = 0 then
	
	if inv_routing[li_selectedtrip].of_locationcheck(as_location, ls_foundlocater, false) > 0 then
		if inv_routing[li_selectedtrip].of_isstreets() then
			ls_locater = inv_routing[li_selectedtrip].of_addresstolatlong(ls_foundlocater)
		else
			//create locater without county
			ls_locater = upper(trim(inv_routing[li_selectedtrip].of_stripcounty(ls_foundlocater)))
		end if
		
		//delete stop being replaced
		ls_stop = dw_pcm.object.pcm[li_selected]
		if len(trim(ls_stop)) > 0 then
			inv_trip[li_selectedtrip].of_deletestop(li_selected)
		end if
		
		dw_pcm.setitem(li_selected, "pcm",ls_locater)
		dw_pcm.setitem(li_selected, "state", upper(inv_routing[li_selectedtrip].of_getpartoflocater(ls_foundlocater,'STATE',true)))
		dw_pcm.setitem(li_selected, "city", upper(inv_routing[li_selectedtrip].of_getpartoflocater(ls_foundlocater,'CITY',true)))
		dw_pcm.setitem(li_selected, "zip", inv_routing[li_selectedtrip].of_getpartoflocater(ls_foundlocater,'ZIPCODE',true))
		if inv_routing[li_selectedtrip].of_isstreets() then
			dw_pcm.setitem(li_selected, "street", upper(inv_routing[li_selectedtrip].of_getpartoflocater(ls_foundlocater,'STREET',true)))
		end if
		if li_selected = dw_pcm.rowcount() then 			
			li_selected = dw_pcm.insertrow(0)
			ls_locater = ""
		else
			//if changing the locater of a row in the middle then
			// all distance and time after that should be cleared
//			li_selected ++
			ls_locater = dw_pcm.getitemstring(li_selected, "pcm")
			integer lcv
			for lcv = li_selected to dw_pcm.rowcount()
				dw_pcm.setitem(lcv, "legmiles", null_dec)
				dw_pcm.setitem(lcv, "totmiles", null_dec)
				dw_pcm.setitem(lcv, "tyme", null_str)
				dw_pcm.setitem(lcv, "legtyme", null_str)
				dw_pcm.setitem(lcv, "cost", null_dec)
			next
			dw_pcm.object.st_tottime.text = ""
		end if
		dw_pcm.selectrow(0, false)
		dw_pcm.selectrow(li_selected, true)
		dw_pcm.postevent(clicked!)
		li_return = 0
	else
		messagebox("Invalid Stop", "PC*Miler could not find a match.")
		li_return = -1
	end if
end if

return li_return



end function

public subroutine wf_optimize ();//integer curtrip
//curtrip = gettrip()
//if curtrip < 1 then return 
//if tripid[curtrip] = 0 then return
//if cbx_hub_on.checked = true then
//	messagebox("Invalid Request", "Cannot optimize in hub mode.")
//	return
//elseif dw_pcm.rowcount() < 3 then
//	messagebox("Invalid Request", "Must have more than 2 stops to optimize.")
//	return
//end if
//
//integer destchange 
//if rb_yes.checked = true then
//	destchange = 1
//else
//	destchange = 0 
//end if
//pcmssetresequence(tripid[curtrip], destchange)
//
//pcmsoptimize(tripid[curtrip])
//pcmscalculate(tripid[curtrip])
//
////change_trip(curtrip, null_int)
//
//
//
end subroutine

private function integer wf_print ();//
/***************************************************************************************
NAME			: wf_Print
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: his prints the datawindow. 

REVISION		: RDT 3-11-03
***************************************************************************************/
Integer 	li_Return = 1
String 	ls_City

// check for data
ls_City = dw_pcm.GetItemString(1, "City") 

If IsNull( ls_City ) or Len( Trim( ls_City) ) < 1 Then 
	MessageBox("Print","No data to Print.~nPlease enter at least one location.")
	li_Return = -1
End If

If li_Return  = 1 then 
	li_Return = PrintSetup ( ) 
End If

If li_Return  = 1 then 
	li_Return  = dw_pcm.Print(TRUE)
Else
	li_Return = -1
End IF

Return li_Return 
end function

on w_pcmiler.create
if this.MenuName = "m_pcmiler" then this.MenuID = create m_pcmiler
this.cb_print=create cb_print
this.dw_location=create dw_location
this.cbx_open_borders=create cbx_open_borders
this.cbx_hub_on=create cbx_hub_on
this.cb_run=create cb_run
this.cb_map=create cb_map
this.cb_directions=create cb_directions
this.cb_deltrip=create cb_deltrip
this.gb_4=create gb_4
this.gb_2=create gb_2
this.rb_air=create rb_air
this.rb_avoid=create rb_avoid
this.rb_natl=create rb_natl
this.rb_shortest=create rb_shortest
this.rb_practical=create rb_practical
this.dw_pcm=create dw_pcm
this.ddlb_trip=create ddlb_trip
this.Control[]={this.cb_print,&
this.dw_location,&
this.cbx_open_borders,&
this.cbx_hub_on,&
this.cb_run,&
this.cb_map,&
this.cb_directions,&
this.cb_deltrip,&
this.gb_4,&
this.gb_2,&
this.rb_air,&
this.rb_avoid,&
this.rb_natl,&
this.rb_shortest,&
this.rb_practical,&
this.dw_pcm,&
this.ddlb_trip}
end on

on w_pcmiler.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_print)
destroy(this.dw_location)
destroy(this.cbx_open_borders)
destroy(this.cbx_hub_on)
destroy(this.cb_run)
destroy(this.cb_map)
destroy(this.cb_directions)
destroy(this.cb_deltrip)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.rb_air)
destroy(this.rb_avoid)
destroy(this.rb_natl)
destroy(this.rb_shortest)
destroy(this.rb_practical)
destroy(this.dw_pcm)
destroy(this.ddlb_trip)
end on

event open;this.x = 1
this.y = 1

gf_mask_menu(m_pcmiler)

ddlb_trip.selectitem(1)
lasttrip = 1

cbx_open_borders.checked = true
rb_practical.checked = true
cbx_hub_on.checked  = false

integer lcv
for lcv = 1 to max_trips
	tripid[lcv] = 0 
next

//get first trip ready
boolean	lb_pcmilerconnected
string 	ls_productname, &
			ls_productversion
			
inv_trip[1] = create n_cst_trip

if inv_trip[1].of_connect(inv_routing[1]) then
	if inv_routing[1].of_isvalid() then
		lb_pcmilerconnected=true
	else
		lb_pcmilerconnected=false
	end if
end if


if lb_pcmilerconnected then
	ls_productname=inv_routing[1].of_about("ProductName")
	ls_productversion=inv_routing[1].of_about("ProductVersion")
	if len(ls_productname) > 0 then
		this.title += " - " + ls_productname + ' Version ' + ls_productversion
	end if
	if inv_routing[1].of_isstreets() then
		dw_pcm.dataobject='d_pcmiler_street'
	else
		dw_pcm.dataobject='d_pcmiler'
	end if
	dw_pcm.settransobject(sqlca)
	
	dw_location.insertrow(0)
	if inv_routing[1].of_isstreets() then
		dw_location.object.isstreets[1] = "Y"
		ib_isstreets=true
	else
		dw_location.object.isstreets[1] = "N"
	end if
	if inv_routing[1].of_isoldpcmilerversion() then
		ib_isoldpcmilerversion = true
	end if
	
	dw_pcm.insertrow(0)
	dw_pcm.selectrow(1, true)
	dw_location.setfocus()

else
	messagebox("PC*Miler", "Could not connect to PC*Miler.")
	close(this)
end if

end event

event close;win_is_closing = true
integer li_ndx
for li_ndx = 1 to max_trips
	if tripid[li_ndx] <> 0 then 
		if isvalid( inv_trip[li_ndx]) then
			inv_trip[li_ndx].of_deletetrip(tripid[li_ndx])
			destroy inv_trip[li_ndx]
		end if
	end if
next

if isvalid (iw_map) then close(iw_map)
if isvalid (iw_mapstreets) then close(iw_mapstreets)
if isvalid (reportwin) then close(reportwin)




end event

event deactivate;if this.windowstate = minimized! then
	if isvalid(reportwin) then close(reportwin)
	if isvalid(iw_map) then close(iw_map)
	if isvalid(iw_mapstreets) then close(iw_mapstreets)
end if

end event

type cb_print from commandbutton within w_pcmiler
int X=2898
int Y=1240
int Width=384
int Height=88
int TabOrder=30
string Text="&Print"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// RDT 3-11-03 Added Print Button and script.
Parent.wf_Print()
end event

type dw_location from u_dw within w_pcmiler
event ue_keydown pbm_dwnkey
int X=18
int Y=236
int Width=3314
int Height=184
int TabOrder=10
string DataObject="d_location"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event ue_keydown;
long ll_selrow
string	ls_zip, &
			ls_city, &
			ls_state, &
			ls_street, &
			ls_locater, &
			ls_data
			
ll_selrow = dw_pcm.getselectedrow(0)

if keydown(keyenter!) then 
	SetPointer(HourGlass!)
	//build location
	//note: the location should be sent to the routing object in pieces and assembled 
	//into the correct syntax by the object.
	//I don't have the time right now to do this.
	this.accepttext()
	ls_zip = this.object.zip[1] //this.getitemstring(1,'zip')
	ls_city = this.object.city[1] //this.getitemstring(1,'city')
	ls_state = this.object.state[1] //this.getitemstring(1,'state')
	ls_street = this.object.street[1] //this.getitemstring(1,'street')
	if len(trim(ls_zip)) > 0 then
		if ib_isstreets then
			if len(trim(ls_street)) > 0 then
				ls_locater = trim(ls_zip) + "; " + trim(ls_street)
			else
				ls_locater = trim(ls_zip)
			end if
		else
			ls_locater = trim(ls_zip)
		end if
	elseif len(trim(ls_city)) > 0 and len(trim(ls_state)) > 0 then
		if ib_isstreets then
			if len(trim(ls_street)) > 0 then
				ls_locater = trim(ls_city) + ", " + trim(ls_state) + "; " + trim(ls_street)
			else
				ls_locater = trim(ls_city) + ", " + trim(ls_state)
			end if
		else
			if ib_isoldpcmilerversion then
				ls_locater = trim(ls_city) + " " + trim(ls_state)
			else
				ls_locater = trim(ls_city) + ", " + trim(ls_state)
			end if		
		end if
	end if
	if len( trim( ls_locater ) ) = 0 then
		return 1
	end if
	wf_addlocation(ls_locater)
	this.setfocus()
elseif keydown(keytab!) then 
//	if sle_mod() = -1 then 
//		this.setfocus()
//	else
//		cb_run.setfocus()
//	end if
elseif keydown(keydownarrow!) then
	if dw_pcm.rowcount() > ll_selrow then
		dw_pcm.selectrow(0, false)
		dw_pcm.selectrow(max(ll_selrow + 1, 1), true)
		dw_pcm.postevent(clicked!)
	end if
	return 1
elseif keydown(keyuparrow!) then
	if dw_pcm.getselectedrow(0) > 1 then
		dw_pcm.selectrow(0, false)
		dw_pcm.selectrow(ll_selrow - 1, true)
		dw_pcm.postevent(clicked!)
	end if
	return 1
else
	
	choose case upper(this.getcolumnname())
		case "ZIP"
			this.object.city[1]=null_str
			this.object.state[1]=null_str

		case "CITY"
			this.object.zip[1]=null_str
			this.object.state[1]=null_str
			
		case "STATE"
			this.object.zip[1]=null_str
			
	end choose
	
end if
end event

event itemchanged;call super::itemchanged;
choose case dwo.name
		
	case "zip"
		
	case "city"
		
	case "state"
		
	case "street"
		
end choose

end event

event constructor;
this.ib_rmbmenu = False	// RDT 3-11-03 
end event

type cbx_open_borders from checkbox within w_pcmiler
int X=2469
int Y=32
int Width=448
int Height=76
string Text="Open Borders"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uncalc_trip()
end event

type cbx_hub_on from checkbox within w_pcmiler
int X=1947
int Y=32
int Width=494
int Height=76
string Text="Hub Mode On "
boolean Checked=true
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_pcm.setredraw(false)
if this.checked = true then 
	dw_pcm.object.st_hub.text = "on"
else
	dw_pcm.object.st_hub.text = "off"
end if
uncalc_trip()
dw_pcm.setredraw(true)


end event

type cb_run from commandbutton within w_pcmiler
event keydowner pbm_keydown
int X=2898
int Y=680
int Width=384
int Height=88
int TabOrder=20
string Text="&Run"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event keydowner;if keydown(keyenter!) then this.triggerevent(clicked!)


end event

event clicked;long	ll_rowcount, &
		ll_ndx
		
for ll_ndx = 1 to ll_rowcount
	dw_pcm.setitem(ll_ndx, "totmiles", null_dec)
	dw_pcm.setitem(ll_ndx, "legmiles", null_dec)
	dw_pcm.setitem(ll_ndx, "tyme", null_str)
	dw_pcm.setitem(ll_ndx, "legtyme", null_str)
	dw_pcm.setitem(ll_ndx, "cost", null_dec)
next
dw_location.accepttext()
post wf_calc_trip()
end event

type cb_map from commandbutton within w_pcmiler
int X=2898
int Y=960
int Width=384
int Height=88
string Text="&Map"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if isvalid(iw_map) or isvalid(iw_mapstreets) then return

integer li_selectedtrip

li_selectedtrip = integer(right(trim(ddlb_trip.text), 1))

if li_selectedtrip < 1 then return

if tripid[li_selectedtrip] = 0 or dw_pcm.object.st_calced.text = "no" then 
	messagebox("Invalid Request", "Calculate trip first.")
	return 
//elseif pcmsnumstops(tripid[curtrip]) = 0 then 
//	return 
end if
s_mapping maps
maps.typemap = "R"
/*----------------------------------------------------------------
			typeroute - a capitol letter
				"P" = Practical route			(default)
				"N" = National highways only
				"T" = Avoid Tolls if possible
				"S" = Shortest route
			hubs -
				"H" = hubs on
				"N" = no hubs			(default)
			borders -
				"O" = open borders	(default)
				"C" = borders closed
---------------------------------------------------------------- */
if rb_practical.checked = true then
	maps.typeroute = "P"
elseif rb_shortest.checked = true then
	maps.typeroute = "S"
elseif rb_natl.checked = true then
	maps.typeroute = "N"
elseif rb_avoid.checked = true then
	maps.typeroute = "T"
elseif rb_air.checked = true then
	maps.typeroute = "P"
end if

if cbx_hub_on.checked = true then
	maps.hubs = "H"
else
	maps.hubs = "N"
end if

if cbx_open_borders.checked = true then 
	maps.borders = "O"
else
	maps.borders = "C"	
end if

maps.ds_source = null_ds
maps.dw_source = null_dw
maps.valid_tripid = tripid[li_selectedtrip]
maps.ypos = parent.y + dw_pcm.y + (dw_pcm.width / 2) 
maps.xpos = parent.x + (dw_pcm.width / 2) //dw_pcm.x +

if ib_isstreets then
	openwithparm(iw_mapstreets, maps, parent)
else
	openwithparm(iw_map, maps, parent)
end if


 
 
end event

type cb_directions from commandbutton within w_pcmiler
int X=2898
int Y=1100
int Width=384
int Height=88
string Text="&Directions"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long	ll_return = 1, &
		ll_stopcount, &
		ll_ndx, &
		ll_row
		
integer li_selectedtrip
string	ls_locater, &
			ls_address
datastore	lds_data, &
				lds_source
				
li_selectedtrip = integer(right(trim(ddlb_trip.text), 1))

if isvalid(reportwin) then 
	ll_return = -1
end if

if ll_return = 1 then
	if li_selectedtrip < 1 then 
		ll_return = -1
	end if
end if

if ll_return = 1 then
	
	if tripid[li_selectedtrip] = 0 or dw_pcm.object.st_calced.text = "no" then
		messagebox("Invalid Request", "Calculate a trip first.")
		ll_return = -1
	end if
end if

if ll_return = 1 then
	
	lds_data = create n_cst_trip_attribs
	lds_source = create datastore
//	lds_source.DataObject = "d_itin"
	lds_source.DataObject = "d_companyinfo"

	ll_stopcount = inv_trip[li_selectedtrip].of_getstops(lds_data)
	
	if ll_stopcount = 0 then 
		ll_return = -1
	else
		for ll_ndx = 1 to ll_stopcount
			if lds_data.object.stop[ll_ndx] = ls_locater then
				continue  //same as last row
			end if
			
			ls_locater = lds_data.object.stop[ll_ndx]
			ll_row = lds_source.insertrow(0)
			lds_source.setitem(ll_row, "co_pcm", ls_locater)
			lds_source.setitem(ll_row, "co_city", dw_pcm.object.city[ll_ndx])
			lds_source.setitem(ll_row, "co_state", dw_pcm.object.state[ll_ndx])
			lds_source.setitem(ll_row, "co_zip", dw_pcm.object.zip[ll_ndx])
			ls_address = dw_pcm.object.street[ll_ndx]
			if isnull(ls_address) then
				ls_address = ""
			end if
			lds_source.setitem(ll_row, "co_addr1", ls_address)
		next
		
		s_mapping trips

		if rb_practical.checked = true then
			trips.typeroute = "P"
		elseif rb_shortest.checked = true then
			trips.typeroute = "S"
		elseif rb_natl.checked = true then
			trips.typeroute = "N"
		elseif rb_avoid.checked = true then
			trips.typeroute = "T"
		elseif rb_air.checked = true then
			trips.typeroute = "P"
		end if

		if cbx_hub_on.checked = true then
			trips.hubs = "H"
		else
			trips.hubs = "N"
		end if
		
		if cbx_open_borders.checked = true then 
			trips.borders = "O"
		else
			trips.borders = "C"	
		end if

		trips.ds_source = lds_source
		trips.dw_source = null_dw
		trips.valid_tripid = null_long //tripid[li_selectedtrip]
		trips.ypos = parent.y + dw_pcm.y + 100
		trips.xpos = null_int
		
		openwithparm(reportwin, trips, parent)

	end if
end if





end event

type cb_deltrip from commandbutton within w_pcmiler
int X=2898
int Y=820
int Width=384
int Height=88
string Text="&Clear"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;post wf_clear_trip()
end event

type gb_4 from groupbox within w_pcmiler
int X=2853
int Y=420
int Width=480
int Height=992
string Text="Trip"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_pcmiler
int X=18
int Width=1874
int Height=204
string Text="Routing"
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_air from radiobutton within w_pcmiler
int X=1609
int Y=84
int Width=247
int Height=80
boolean BringToTop=true
string Text="Air"
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uncalc_trip()


end event

type rb_avoid from radiobutton within w_pcmiler
int X=1225
int Y=84
int Width=329
int Height=80
boolean BringToTop=true
string Text="Avoid Toll"
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uncalc_trip()


end event

type rb_natl from radiobutton within w_pcmiler
int X=891
int Y=84
int Width=293
int Height=80
boolean BringToTop=true
string Text="National"
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uncalc_trip()


end event

type rb_shortest from radiobutton within w_pcmiler
int X=539
int Y=84
int Width=306
int Height=80
boolean BringToTop=true
string Text="Shortest"
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uncalc_trip()


end event

type rb_practical from radiobutton within w_pcmiler
int X=178
int Y=84
int Width=315
int Height=80
boolean BringToTop=true
string Text="Practical"
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uncalc_trip()


end event

type dw_pcm from datawindow within w_pcmiler
int X=18
int Y=448
int Width=2816
int Height=968
string DataObject="d_pcmiler"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;//I'm using this as a temporary compromise until we can get a rowfocuschanged setup.
//The clicked event is posted from other scripts when they change the row selection.
string ls_locater
long	ll_row
decimal	lc_cost
n_cst_numerical lnv_numerical

if xpos > 0 and ypos > 0 and row = 0 then return 
//The row really was clicked (the event wasn't posted), but not on a row.

if lnv_numerical.of_IsNullOrNotPos(row) then row = this.getselectedrow(0)
if lnv_numerical.of_IsNullOrNotPos(row) then return

this.selectrow(0, false)
this.selectrow(row, true)
this.scrolltorow(row) //This is only relevant when the event is posted.

//sle_1.text = this.getitemstring(row, "city")
//sle_1.text += " " + this.getitemstring(row, "state")
ls_locater = this.getitemstring(row, "pcm")
dw_location.setredraw(false)
//get cost 
lc_cost = dw_location.object.permilecost[1]
dw_location.reset()
ll_row = dw_location.insertrow(0)
dw_location.object.permilecost[ll_row] = lc_cost
dw_location.object.zip[ll_row] = this.getitemstring(row, "zip")
dw_location.object.city[ll_row] = this.getitemstring(row, "city")
dw_location.object.state[ll_row] = this.getitemstring(row, "state")
dw_location.object.street[ll_row] = this.getitemstring(row, "street")
if inv_routing[1].of_isstreets() then
	dw_location.object.isstreets[1] = "Y"
	ib_isstreets=true
else
	dw_location.object.isstreets[1] = "N"
end if
dw_location.setfocus()
dw_location.setredraw(true)


end event

event rbuttondown;// RDT 3-11-03 Added right button script.
String	ls_PopRtn
String	lsa_parm_labels[]
Any		laa_parm_values[]

lsa_parm_labels [1] = "ADD_ITEM"
laa_parm_values [1] = "&Print"	
	
ls_PopRtn = f_pop_standard(lsa_parm_labels, laa_parm_values)

CHOOSE CASE ls_PopRtn
		
	CASE "PRINT"
		Parent.wf_Print()
END CHOOSE
end event

type ddlb_trip from dropdownlistbox within w_pcmiler
int X=2898
int Y=520
int Width=384
int Height=560
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Trip 1",&
"Trip 2",&
"Trip 3",&
"Trip 4",&
"Trip 5"}
end type

event selectionchanged;string	ls_time
integer newtrip 
newtrip = index
if newtrip = lasttrip then return
long opts, &
		ll_rowcount
dec diver
blob	lblb_pcm

if dw_pcm.rowcount() > 1 and dw_pcm.object.st_calced.text = "no" then
	if messagebox("Trip Change", "Trip will be lost unless it is calculated before changing." +&
	"  OK to change trip?", exclamation!, okcancel!, 2) = 2 then 
		this.post selectitem(lasttrip)
		dw_location.post setfocus()
		return
	elseif tripid[lasttrip] > 0 then
		tripid[lasttrip] = 0
	end if
end if
if not isvalid(ids_trip[lasttrip]) then
	ids_trip[lasttrip] = create datastore
end if

dw_pcm.getfullstate(lblb_pcm)
ids_trip[lasttrip].setfullstate(lblb_pcm)
if tripid[newtrip] = 0 then
	reset_face()
else
	dw_pcm.setredraw(false)
	ids_trip[newtrip].getfullstate(lblb_pcm)
	dw_pcm.setfullstate(lblb_pcm)
	//text value is not being change in full state change
	//this is a quick fix , could cause problems if code is changed to 
	//remove blank line at end of dw, should be changed 
	ll_rowcount=dw_pcm.rowcount() - 1
	ls_time = dw_pcm.object.tyme[ll_rowcount] 
	dw_pcm.object.st_tottime.text = ls_time 

	choose case inv_trip[newtrip].of_getroutetype()
		case 0
			rb_practical.checked = true
		case 1
			rb_shortest.checked = true
		case 2
			rb_natl.checked = true
		case 3
			rb_avoid.checked = true
		case 4
			rb_air.checked = true
	end choose
	cbx_open_borders.checked = inv_trip[newtrip].of_getbordersopen()
	cbx_hub_on.checked = inv_trip[newtrip].of_gethubmode()
	if cbx_hub_on.checked  = true then 
		dw_pcm.object.st_hub.text = "on"
	else
		dw_pcm.object.st_hub.text = "off"
	end if
	dw_pcm.modify("st_calced.text = '" + is_tripcalced[newtrip] + "'")
	dw_location.object.permilecost[1] = ic_milecost[newtrip]

	dw_pcm.setredraw(true)

end if

lasttrip = newtrip




end event

