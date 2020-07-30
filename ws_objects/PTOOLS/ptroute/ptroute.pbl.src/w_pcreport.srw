$PBExportHeader$w_pcreport.srw
$PBExportComments$copied from log app
forward
global type w_pcreport from window
end type
type dw_report from u_dw within w_pcreport
end type
type st_print from statictext within w_pcreport
end type
end forward

global type w_pcreport from window
integer x = 160
integer y = 160
integer width = 3392
integer height = 2052
boolean titlebar = true
string title = "Driving Instructions"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 12632256
dw_report dw_report
st_print st_print
end type
global w_pcreport w_pcreport

type variables
protected:
s_mapping tripinfo
long tripid
long	il_routetype
datastore ds_source
boolean	ib_usestreets
end variables

forward prototypes
public function integer create_report ()
public function string of_getroutetype ()
end prototypes

public function integer create_report ();//---------------------------------------------------- part 1:  making the trip
any		la_value

integer  li_matches, &
			li_ndx, &
			li_return = 1, &
			li_tabpos1, &
			li_tabpos2, &
			li_tabpos3, &
			li_start, &
			li_end, &
			li_colonpos

long		ll_rowcount, &
			ll_time, &
			ll_reportlines, &
			ll_return, &
			ll_stopcount

decimal	lc_distance

string	ls_locater,&
			ls_address, &
			ls_city, &
			ls_state, &
			ls_street, &
			ls_lastlocater, &
			ls_report, &
			ls_laststop, &
			lsa_report[], &
			ls_reporttext = "~r~n",&
			temp, &
			ls_routename, &
			ls_tag_totals, &
			ls_linestr, &
			ls_companyname
			
boolean	lb_latlong

n_cst_trip	lnv_trip
n_cst_routing	lnv_routing
n_cst_trip_attribs	lds_data
n_cst_string	lnv_string
n_cst_settings lnv_Settings

//company name for header

IF lnv_Settings.of_GetSetting ( 1 , la_value ) <> 1 THEN
	ls_companyname = ''
else
	ls_companyname = string(la_value)
end if

lds_data = create n_cst_trip_attribs

lnv_trip = create n_cst_trip

if lnv_trip.of_connect(lnv_routing) then
	if lnv_routing.of_isvalid() then
		ll_rowcount = ds_source.rowcount()
		//load trip
		for li_ndx = 1 to ll_rowcount
			ls_locater = ds_source.getitemstring(li_ndx, "co_pcm")
			if isnull(ls_locater) or len(trim(ls_locater)) = 0 then
				continue
			elseif ls_locater = ls_lastlocater then
				continue
			else
				lnv_trip.of_addstop(ls_locater)		
				ls_lastlocater = ls_locater
			end if
		next
	else
		messagebox("Programmer's Warning","Pcmiler could not create a trip.~nnull")
		li_return = -1
	end if
else
	messagebox("Programmer's Warning","Pcmiler could not create a trip.~nnull")
	li_return = -1
end if

ll_stopcount = lnv_trip.of_getstops(lds_data)
if ll_stopcount = 0 then 
	messagebox("Programmer's Warning", "No stops in the trip.")
	li_return = -1
end if

if li_return = 1 then
		
	ls_report=space(32768)
	lnv_trip.of_setroutetype(il_routetype)
	ll_return = lnv_trip.of_getreport(0, tripinfo.borders, ls_report)
	if ll_return > 0 then
		if len(ls_report) > 0 then
			lnv_string.of_parsetoarray(ls_report, "~n", lsa_report)
			ll_reportlines=upperbound(lsa_report)
		end if
	else
		messagebox("Programmer's Warning", "No lines in the pcreport.")
		li_return = -1
	end if
	
	//from stop
//	ls_locater = lds_data.object.stop[1]
	ls_city = ds_source.getitemstring(1, "co_city")
	ls_state = ds_source.getitemstring(1, "co_state")
	if lnv_routing.of_isstreets() then
		ls_street = ds_source.getitemstring(1, "co_addr1")
		ls_address = ls_street + " " + ls_city + ", " + ls_state
	else
		ls_address = ls_city + ", " + ls_state
	end if
	ls_locater = ls_address

	//strip zip
	if ib_usestreets then
		ls_routename = ls_locater
	else
		if isnumber(left(ls_locater,5)) then
			ls_routename = replace(ls_locater, 1, 5, "")
		else
			ls_routename = ls_locater
		end if
	end if
	//to stop
//	ls_locater = lds_data.object.stop[ll_stopcount]
	ls_city = ds_source.getitemstring(ll_stopcount, "co_city")
	ls_state = ds_source.getitemstring(ll_stopcount, "co_state")
	if lnv_routing.of_isstreets() then
		ls_street = ds_source.getitemstring(ll_stopcount, "co_addr1")
		ls_address = ls_street + " " + ls_city + ", " + ls_state
	else
		ls_address = ls_city + ", " + ls_state
	end if
	ls_locater = ls_address
	
	//strip zip
	if ib_usestreets then
		ls_laststop = ls_locater
	else
		if isnumber(left(ls_locater,5)) then
			ls_laststop = replace(ls_locater, 1, 5, "")
		else
			ls_laststop = ls_locater
		end if
	end if
	
	if ll_rowcount = 2 then
		ls_routename += "  to  " + ls_laststop + "   (No Stops)"
	else
		ls_routename += " to " + ls_laststop + ":  " + string(ll_rowcount - 2) + " Stop"
		if ll_rowcount > 3 then ls_routename += "s"
	end if
	
	if isvalid(lnv_trip) then
		destroy lnv_trip
	end if
	//------------------------------------------------------------ part 2:  creating the report
	ll_rowcount = 0
	for li_ndx = 1 to ll_reportlines
		ls_linestr = space(100)
		ls_linestr = lsa_report[li_ndx]
		if len(trim(ls_linestr)) > 0 and pos(ls_linestr, "~t") = 3 then 
			li_tabpos1 = pos(ls_linestr, "~t")
			li_tabpos1 = pos(ls_linestr, "~t", li_tabpos1 + 1)
			li_tabpos1 = pos(ls_linestr, "~t", li_tabpos1 + 1)
			li_tabpos1 = pos(ls_linestr, "~t", li_tabpos1 + 1)
			li_tabpos1 = pos(ls_linestr, "~t", li_tabpos1 + 1)
			li_tabpos1 = pos(ls_linestr, "~t", li_tabpos1 + 1)
			li_tabpos1 = pos(ls_linestr, "~t", li_tabpos1 + 1)
			li_tabpos2 = pos(ls_linestr, "~t", li_tabpos1 + 1)
			if ib_usestreets then
				//check for latlong and remove
				ls_locater = mid(ls_linestr, li_tabpos1 + 1, li_tabpos2 - li_tabpos1)
				if Match(ls_locater, "[0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Za-z]+") or &
					Match(ls_locater, "[0-9][0-9][.][0-9][0-9][0-9][0-9][A-Za-z]+") then
					ls_linestr = replace ( ls_linestr, li_tabpos1 + 1, li_tabpos2 - li_tabpos1, "~t" )
				end if
			end if
			ls_reporttext += ls_linestr + "~r~n"
		elseif len(trim(ls_linestr)) = 0 then
			ls_reporttext += "~r~n"
		elseif left(ls_linestr, 5) = "Stop " or left(ls_linestr, 5) = "Dest:" &
			or left(ls_linestr, 7) = "Origin:" then
			temp = ls_linestr
			li_tabpos1 = pos(temp, "~t")
			li_tabpos2 = pos(temp, "~t", li_tabpos1 + 1)
			li_tabpos2 = pos(temp, "~t", li_tabpos2 + 1)
			li_tabpos2 = pos(temp, "~t", li_tabpos2 + 1)
			li_tabpos2 = pos(temp, "~t", li_tabpos2 + 1)
			li_tabpos2 = pos(temp, "~t", li_tabpos2 + 1)
			li_tabpos2 = pos(temp, "~t", li_tabpos2 + 1)
			li_tabpos3 = pos(temp, "$")
			if li_tabpos3 <> 0 then
				li_tabpos2 = pos(temp, "~t", li_tabpos3)
			end if
			if li_tabpos2 = 0 then
				li_tabpos2 = len(temp) + 1
			else
				li_tabpos2 = pos(temp, "~t", li_tabpos2 + 1)
			end if
			temp = replace(temp, li_tabpos1, li_tabpos2 - li_tabpos1, "")
			
			//strip out county if there is one
			li_tabpos1 = pos ( temp, "," ) //1st comma
			li_tabpos1 = pos ( temp, ",", li_tabpos1 + 1 ) //2nd comma

			if Match(ls_linestr, "[0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Za-z]+") or &
				Match(ls_linestr, "[0-9][0-9][.][0-9][0-9][0-9][0-9][A-Za-z]+") then
				lb_latlong=true
			else
				lb_latlong=false
			end if	
			
			if ib_usestreets or lb_latlong then
				if li_tabpos1 > 0 then
					//change latlong to address
					li_colonpos = pos ( ls_linestr, ":" )
					li_start = li_colonpos + 2

					if li_start > 2 then
						ll_rowcount ++
						if ll_rowcount > ll_stopcount then
							//skip
						else
							ls_city = ds_source.getitemstring(ll_rowcount, "co_city")
							ls_state = ds_source.getitemstring(ll_rowcount, "co_state")
							ls_street = ds_source.getitemstring(ll_rowcount, "co_addr1")
							ls_address = ls_street + " " + ls_city + ", " + ls_state
						end if		
						if len(trim(ls_address)) > 0 then
							li_end = pos(temp, "~t")
							if li_end > 0 then
								temp = replace ( temp, li_start, li_end - li_start, ls_address )
							else
								temp = replace ( temp, li_start, (len(temp) - li_start) + 1, ls_address )
							end if
						end if
					end if
				end if
				//no county, address line built from scratch
				li_tabpos1 = 0
				//strip county
//				li_tabpos1 = pos ( temp, "," ) //1st comma
//				li_tabpos1 = pos ( temp, ",", li_tabpos1 + 1 ) //2nd comma
//				li_tabpos1 = pos ( temp, ",", li_tabpos1 + 1 ) //3rd comma
//				li_tabpos1 = pos ( temp, ",", li_tabpos1 + 1 ) //4th comma
			end if
			if li_tabpos1 > 0 then
				li_tabpos2 = pos ( temp, "~t") //1st tab
				if li_tabpos2 > 0 then
					temp = replace ( temp, li_tabpos1, li_tabpos2 - li_tabpos1, "" )
				else
					temp = replace ( temp, li_tabpos1, (len ( temp ) - li_tabpos1 ) + 1, "" )
				end if
			end if
			if left(ls_linestr, 5) = "Dest:" then
				li_tabpos1 = pos(temp, "~t")
				li_tabpos1 = pos(temp, "~t", li_tabpos1 + 1)
				li_tabpos1 = pos(temp, "~t", li_tabpos1 + 1) + 1
				li_tabpos2 = pos(temp, "~t", li_tabpos1)
				ls_tag_totals = "Total Miles: " + mid(temp, li_tabpos1, li_tabpos2 - li_tabpos1) 
				ls_tag_totals += "  Time: " + mid(temp, li_tabpos2 + 1)
			end if
			temp = "~t~t~t~t~t~t~t" + temp
			ls_reporttext += temp + "~r~n"
		end if
		temp = ""
		ls_linestr = ""
	next
	dw_report.Object.cf_company_name.Expression = "'" + ls_companyname + "'" 
	dw_report.object.st_route.text = ls_routename
	dw_report.Object.cf_distance_time.Expression = "'" + lnv_string.of_removenonprint(ls_tag_totals) + "'"
	dw_report.importstring(ls_reporttext)
end if

return li_return


end function

public function string of_getroutetype ();//Note:  This gets setting 12, Mileage Type for Settlements 
//This could be replaced with n_cst_Setting_SettlementsMileageType.
//However, the code values returned from that are different from this.
//This cases out on the raw data value, then converts that to a 1-char string.

any		la_Setting

string	ls_routetype
			
n_cst_Settings lnv_Settings 

CHOOSE CASE lnv_Settings.of_GetSetting( 12, la_Setting )
	CASE 0
		
	CASE 1
		ls_routetype = String ( la_Setting )
							
	CASE ELSE
		
END CHOOSE

choose case ls_routetype
	case '0'
		ls_routetype = "P"
	case '1'
		ls_routetype = "S"
	case '2'
		ls_routetype = "N"
	case '3'
		ls_routetype = "T"
	case '4'
		ls_routetype = "" 
end  choose

return ls_routetype
end function

on w_pcreport.create
this.dw_report=create dw_report
this.st_print=create st_print
this.Control[]={this.dw_report,&
this.st_print}
end on

on w_pcreport.destroy
destroy(this.dw_report)
destroy(this.st_print)
end on

event open;/*		Purpose:  this window will give the directions for info currently in a d_itin.

		The window must be opened with a powerobjectparm of type s_mapping. (global sturc)
		Here are the possible settings for s_mapping:

			typemap - (a letter) not important
			dw_source - a datawindow with pcmvals, the only current acceptable type is "d_itin"
			ds_source - datastore version of above, send either
			xpos - nullint or an xpos, the map will default to the top and centered
			ypos - "

			typeroute - a capitol letter
				"P" = Practical route			(default)
				"N" = National highways only
				"T" = Avoid Tolls if possible
				"S" = Shortest route
			hubs - not important
			borders -
				"O" = open borders
				"C" = borders closed	(default)

	If anything fails the window will not open

Declare a window of this type in the parent window that calls is.  Check to make sure this
window isn't already opened before it is opened again.  This window is a pop up!!
Make sure that it is close if the parent is closed!!!!!!!.

--------------------------------------------------------------------------------------*/
//streets - n_cst_trip should be passed in
tripinfo = message.powerobjectparm

n_cst_LicenseManager	lnv_LicenseManager

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_PCMiler ) or &
	lnv_LicenseManager.of_usepcmilerstreets() THEN
	//ok to proceed
	IF pcmm_inst = FALSE THEN
		MessageBox ( This.Title, "You must set the 'PC*Miler Mapping Installed' setting in System Settings to 'YES' "+&
		"in order to use this feature.  You will also need to exit and restart Profit Tools in order for the "+&
		"change to take effect." )
		Close ( This )
		RETURN
	end if
else
	MessageBox ( This.Title, "You must have a Profit Tools PC*Miler Interface license in order to use this feature." +&
		"  Please contact your Profit Tools sales representative, or Profit Tools technical support." )
		Close ( This )
		RETURN
END IF

if lnv_LicenseManager.of_usepcmilerstreets() THEN
	ib_usestreets = true
end if

if lnv_LicenseManager.of_getpcmilerserverid() > 0 then
	//connected
else
	MessageBox ( This.Title, "PC*Miler connection has not been established.")
	Close ( This )
	RETURN
end if

if not isvalid(tripinfo.dw_source) and not isvalid(tripinfo.ds_source) and &
	(isnull(tripinfo.valid_tripid) or tripinfo.valid_tripid <= 0 ) then
	messagebox("System Error", "This program cannot create directions at this time. " +&
	" (Invalid dw_itin or ds_itin or valid_tripid)")
	close(this)
	return
end if

ds_source = CREATE datastore 

if isvalid(tripinfo.dw_source) then
	if tripinfo.dw_source.rowcount() = 0 then return
	ds_source.DataObject = tripinfo.dw_source.dataobject
	ds_source.object.data.primary = tripinfo.dw_source.object.data.primary
elseif isvalid(tripinfo.ds_source) then
	if tripinfo.ds_source.rowcount() = 0 then return
	ds_source.DataObject = tripinfo.ds_source.dataobject
	ds_source.object.data.primary = tripinfo.ds_source.object.data.primary
elseif not isnull(tripinfo.valid_tripid) and tripinfo.valid_tripid > 0 then
	integer numstops, lcv, newrow
	string pcm
//	numstops = pcmsnumstops(tripinfo.valid_tripid)
//	if numstops <= 0 then
//		messagebox("Programmer's Warning", "No stops or invalid tripid in open of w_map.")
//		close(this)
//		return
//	end if
//	ds_source.DataObject = "d_itin"
//	for lcv = 0 to (numstops - 1)
//		pcm = space(128)
//		pcmsgetstop(tripinfo.valid_tripid, lcv, pcm, 128 )
//		pcm = lnv_bso_pcmiler.of_formatlocater(pcm, "ALL")
//		newrow = ds_source.insertrow(0)
//		ds_source.setitem(newrow, "co_pcm", pcm)
//	next
else
	close(this)
	return
end if

if ds_source.rowcount() < 2 then 
	messagebox("System Error", "This program cannot create directions at this time. " +&
	" (Not enough Tripinfo)")
	close(this)
	return
end if


this.x = 161
this.y = 161

//Note:  This gets setting 12, Mileage Type for Settlements (n_cst_Setting_SettlementsMileageType).
//Not sure whether this was originally done intentionally or by mistake.
//However, if intentional, the rationale would be that since they're paying the
//driver on something other than practical, they don't want to give him a printed 
//document that shows something other than practical.  --BKW 8/8/05
if isnull(tripinfo.typeroute) or len(trim(tripinfo.typeroute)) = 0 then
	tripinfo.typeroute = this.of_getroutetype()
end if

string routetag = "Route Type:  ", bordertag = "Borders:  "
choose case tripinfo.typeroute
	case "P"
		routetag += "PRACTICAL"
		il_routetype = 0
	case "S"
		routetag += "SHORT"
		il_routetype = 1
	case "N"
		routetag += "NATIONAL"
		il_routetype = 2		
	case "T"
		routetag += "AVOID TOLL"
		il_routetype = 3		
	case else	//Default if no value specified.  
					//And, doesn't make sense to get directions for Air Radius, so use Practical instead
		routetag += "PRACTICAL"
		il_routetype = 0   //Changed from "4"  Bug fix 8/5/05 4.0.41 BKW		
end choose
if isnull(tripinfo.borders) or len(trim(tripinfo.borders)) = 0 then
	tripinfo.borders = "C"
end if
if tripinfo.borders = "C" and not isnull(tripinfo.borders) then 
	bordertag += "CLOSED"
else
	bordertag += "OPEN"
end if

dw_report.object.st_routetag.text = routetag
dw_report.object.st_borderstag.text = bordertag

tripid = 0
if create_report() = -1 then
	messagebox("System Error", "This program could not obtain a PcMiler Report at this time.")
	close(this)
	return
end if
dw_report.object.datawindow.zoom = 92




end event

event close;if tripinfo.valid_tripid <= 0 or isnull(tripinfo.valid_tripid) then 
//	if tripid <> 0 then pcmsdeletetrip(tripid)
end if
destroy ds_source




end event

type dw_report from u_dw within w_pcreport
integer x = 41
integer y = 136
integer width = 3301
integer height = 1816
integer taborder = 20
string dataobject = "d_pcreport"
end type

type st_print from statictext within w_pcreport
integer x = 1422
integer y = 28
integer width = 535
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Print Copy"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;n_cst_PrintSrvc lnv_PrintSrvc
lnv_PrintSrvc = CREATE n_cst_PrintSrvc

lnv_PrintSrvc.of_Print(dw_report)

DESTROY(lnv_PrintSrvc)

/*
if printsetup() = -1 then
	messagebox("Print Copies", "Error executing printer setup -- Request cancelled.")
	return
end if

dw_report.setredraw(false)
dw_report.object.datawindow.zoom = 100

long pj
integer choice, result, copy_type
do
	pj = printopen("Driving Instructions")
	if pj = -1 then
		choice = messagebox("Print Copies", "Could not open print job -- Retry?(a)", &
			question!, retrycancel!, 1)
	else
		result = printdatawindow(pj, dw_report)
		if result = -1 then
			printcancel(pj)
			choice = messagebox("Print Copies", "Error attempting to print -- Retry?(b)", &
				question!, retrycancel!, 1)
		else
			result = printclose(pj)
			if result = -1 then
				printcancel(pj)
				choice = messagebox("Print Copies", "Error attempting to print -- Retry?(c)", &
					question!, retrycancel!, 1)
			end if
		end if
	end if
loop until result = 1 or choice = 2

dw_report.object.datawindow.zoom = 92
dw_report.setredraw(true)

*/
end event

