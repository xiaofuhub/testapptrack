$PBExportHeader$u_radius.sru
forward
global type u_radius from userobject
end type
type rb_outside from radiobutton within u_radius
end type
type rb_within from radiobutton within u_radius
end type
type st_4 from statictext within u_radius
end type
type sle_state from singlelineedit within u_radius
end type
type sle_city from singlelineedit within u_radius
end type
type sle_zip from singlelineedit within u_radius
end type
type cb_unapply from commandbutton within u_radius
end type
type cb_apply from commandbutton within u_radius
end type
type st_3 from statictext within u_radius
end type
type sle_radius from singlelineedit within u_radius
end type
type st_1 from statictext within u_radius
end type
type gb_1 from groupbox within u_radius
end type
end forward

global type u_radius from userobject
integer width = 2597
integer height = 124
long backcolor = 12632256
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event oe_prefilter pbm_custom01
event oe_postfilter pbm_custom02
rb_outside rb_outside
rb_within rb_within
st_4 st_4
sle_state sle_state
sle_city sle_city
sle_zip sle_zip
cb_unapply cb_unapply
cb_apply cb_apply
st_3 st_3
sle_radius sle_radius
st_1 st_1
gb_1 gb_1
end type
global u_radius u_radius

type variables
protected:
boolean ib_ready
datawindow idw_target
string is_target_column
string is_target_column_type
end variables

forward prototypes
public function integer of_set_target (datawindow adw_target, string as_target_column, string as_target_column_type)
public function integer of_apply (long al_miles, string as_location)
public function integer of_unapply ()
public subroutine of_unapplied ()
end prototypes

public function integer of_set_target (datawindow adw_target, string as_target_column, string as_target_column_type);idw_target = adw_target
is_target_column = as_target_column
is_target_column_type = as_target_column_type

ib_ready = true

return 1
end function

public function integer of_apply (long al_miles, string as_location);long ll_target_row, ll_site, ll_minutes
decimal {1} lc_miles
string ls_pcm
s_co_info lstr_company

if not ib_ready then return -1

this.event trigger oe_prefilter(0, 0)

idw_target.setredraw(false)
idw_target.rowsmove(1, idw_target.filteredcount(), filter!, idw_target, &
	idw_target.rowcount() + 1, primary!)
idw_target.filter()
idw_target.sort()

for ll_target_row = idw_target.rowcount() to 1 step -1
	choose case is_target_column_type
	case "COMPANY!"
		ll_site = idw_target.getitemnumber(ll_target_row, is_target_column)
		if gnv_cst_companies.of_get_info(ll_site, lstr_company, false) = 1 then
			ls_pcm = lstr_company.co_pcm
		else
			setnull(ls_pcm)
		end if
	case "PCM!"
		ls_pcm = idw_target.getitemstring(ll_target_row, is_target_column)
	end choose
	gf_calc_miles(as_location, ls_pcm, lc_miles, ll_minutes, 0)
	IF rb_within.Checked THEN
		if lc_miles <= al_miles then continue
	ELSE// outside
		if lc_miles >= al_miles then continue
	END IF
	idw_target.rowsmove(ll_target_row, ll_target_row, primary!, idw_target, 9999, filter!)
next

idw_target.setredraw(true)

this.event trigger oe_postfilter(0, 0)

cb_apply.enabled = false
cb_unapply.enabled = true
cb_unapply.setfocus()

return 1
end function

public function integer of_unapply ();if not ib_ready then return -1
if cb_unapply.enabled = false then return 1

this.event trigger oe_prefilter(0, 0)

idw_target.setredraw(false)
idw_target.rowsmove(1, idw_target.filteredcount(), filter!, idw_target, &
	idw_target.rowcount() + 1, primary!)
idw_target.filter()
idw_target.sort()
idw_target.setredraw(true)

this.event trigger oe_postfilter(0, 0)

this.of_unapplied()
cb_apply.enabled=true
cb_apply.setfocus()

return 1
end function

public subroutine of_unapplied ();cb_apply.enabled = true
cb_unapply.enabled = false
end subroutine

on u_radius.create
this.rb_outside=create rb_outside
this.rb_within=create rb_within
this.st_4=create st_4
this.sle_state=create sle_state
this.sle_city=create sle_city
this.sle_zip=create sle_zip
this.cb_unapply=create cb_unapply
this.cb_apply=create cb_apply
this.st_3=create st_3
this.sle_radius=create sle_radius
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.rb_outside,&
this.rb_within,&
this.st_4,&
this.sle_state,&
this.sle_city,&
this.sle_zip,&
this.cb_unapply,&
this.cb_apply,&
this.st_3,&
this.sle_radius,&
this.st_1,&
this.gb_1}
end on

on u_radius.destroy
destroy(this.rb_outside)
destroy(this.rb_within)
destroy(this.st_4)
destroy(this.sle_state)
destroy(this.sle_city)
destroy(this.sle_zip)
destroy(this.cb_unapply)
destroy(this.cb_apply)
destroy(this.st_3)
destroy(this.sle_radius)
destroy(this.st_1)
destroy(this.gb_1)
end on

type rb_outside from radiobutton within u_radius
integer x = 526
integer y = 44
integer width = 293
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Outside"
end type

event clicked;cb_apply.enabled = true
end event

type rb_within from radiobutton within u_radius
integer x = 251
integer y = 44
integer width = 251
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Within"
boolean checked = true
end type

event clicked;cb_apply.enabled = true
end event

type st_4 from statictext within u_radius
integer x = 1833
integer y = 32
integer width = 69
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "or"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_state from singlelineedit within u_radius
integer x = 1682
integer y = 32
integer width = 137
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "st"
boolean autohscroll = false
textcase textcase = upper!
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;if upper(sle_city.text) = 'CITY' then
	sle_city.text=''
end if

sle_zip.text=''
end event

type sle_city from singlelineedit within u_radius
integer x = 1239
integer y = 32
integer width = 439
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "city"
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;if upper(sle_state.text) = 'ST' then
	sle_state.text=''
end if
sle_zip.text=''
end event

type sle_zip from singlelineedit within u_radius
integer x = 1911
integer y = 32
integer width = 187
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "zip"
boolean autohscroll = false
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;IF len(this.text) > 0 then
	sle_city.text=''
	sle_state.text=''
end if
end event

type cb_unapply from commandbutton within u_radius
event clicked pbm_bnclicked
integer x = 2336
integer y = 20
integer width = 247
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Remove"
end type

event clicked;of_unapply()
end event

type cb_apply from commandbutton within u_radius
integer x = 2107
integer y = 20
integer width = 219
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Apply"
end type

event clicked;integer	li_return=1
	
long		ll_radius
string	ls_city, &
			ls_state, &
			ls_zip, &
			ls_locater, &
			ls_foundpcm
			
boolean	lb_pcmilerconnected, &
			lb_oldpcmilerversion, &
			lb_pcmilerstreets
n_cst_trip	lnv_trip
n_cst_routing	lnv_routing
n_cst_licensemanager	lnv_licensemanager

ll_radius = round(dec(sle_radius.text), 0)

if ll_radius > 0 and ll_radius <= 3000 then
	sle_radius.text = string(ll_radius)
else
	beep(1)
	sle_radius.setfocus()
	return
end if

lnv_trip = create n_cst_trip
if pcms_inst AND (lnv_LicenseManager.of_usepcmilerstreets() or &
			lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_PCMiler )) then
	if lnv_trip.of_connect(lnv_routing) then
		if lnv_routing.of_isvalid() then
			lb_pcmilerconnected=true
			if lnv_routing.of_isoldpcmilerversion() then
				lb_oldpcmilerversion=true
			end if
			if lnv_routing.of_isstreets() then
				lb_pcmilerstreets = true
			end if
		else
			lb_pcmilerconnected=false
		end if
	else
		lb_pcmilerconnected=false
	end if
end if

if lb_pcmilerconnected then
	//get city/state or zip
	ls_city = trim(sle_city.text)
	ls_state = trim(sle_state.text)
	ls_zip = trim(sle_zip.text)

	if trim(ls_city) = "CITY" or len(trim(ls_city)) = 0 THEN
		//Nothing entered
		//try zip
		if isnumber(ls_zip) then
			ls_locater = trim(ls_zip)
		else
			//nothing entered
			li_return = -1
		end if
	else
		if trim(ls_state) = "ST" or len(trim(ls_state)) = 0 then
			//nothing entered
			//try zip
			if isnumber(ls_zip) then
				ls_locater = trim(ls_zip)
			else
				//nothing entered
				li_return = -1
			end if
		else
			if trim(ls_city) = "CITY" or len(trim(ls_city)) = 0 THEN
				//Nothing entered
				li_return = -1
			else
				if lb_oldpcmilerversion then
					ls_locater = trim(ls_city) + " " + trim(ls_state)
				else
					ls_locater = trim(ls_city) + ", " + trim(ls_state)
				end if	
			end if
		end if
	end if
			
	if len( trim( ls_locater ) ) = 0 then
		li_return = -1
	end if

	if li_return = 1 then
		if lnv_routing.of_locationcheck(ls_locater, ls_foundpcm, false) > 0 then
	
			if isvalid(lnv_trip) then
				destroy lnv_trip
			end if
			
			sle_city.text = lnv_routing.of_getpartoflocater(ls_foundpcm,"CITY",true)
			sle_state.text = lnv_routing.of_getpartoflocater(ls_foundpcm,"STATE",true)
			sle_zip.text = lnv_routing.of_getpartoflocater(ls_foundpcm,"ZIPCODE",true)
		
			of_apply(ll_radius, ls_foundpcm)
			
		else
			li_return = -1
		end if
	end if
	
	if isvalid(lnv_trip) then
		destroy lnv_trip
	end if
else
	li_return = -1
end if


end event

type st_3 from statictext within u_radius
integer x = 1024
integer y = 32
integer width = 210
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Miles of"
boolean focusrectangle = false
end type

type sle_radius from singlelineedit within u_radius
event enchange pbm_enchange
integer x = 850
integer y = 32
integer width = 165
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event enchange;cb_apply.enabled = true
end event

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;cb_apply.enabled = true
end event

type st_1 from statictext within u_radius
integer y = 32
integer width = 224
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Radius:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within u_radius
integer x = 233
integer width = 603
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

