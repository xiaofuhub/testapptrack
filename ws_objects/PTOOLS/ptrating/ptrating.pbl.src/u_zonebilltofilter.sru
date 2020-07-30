$PBExportHeader$u_zonebilltofilter.sru
$PBExportComments$reolaces u_rate_tableheader
forward
global type u_zonebilltofilter from u_base
end type
type sle_company from singlelineedit within u_zonebilltofilter
end type
type cbx_base from checkbox within u_zonebilltofilter
end type
type dw_destination from u_dw_ratelinkzone within u_zonebilltofilter
end type
type dw_origin from u_dw_ratelinkzone within u_zonebilltofilter
end type
type st_1 from statictext within u_zonebilltofilter
end type
type dw_ratedefaults from u_dw_ratedefaults within u_zonebilltofilter
end type
type cbx_reset from checkbox within u_zonebilltofilter
end type
end forward

global type u_zonebilltofilter from u_base
integer width = 1051
integer height = 864
long backcolor = 12632256
event ue_itemchanged ( string as_value )
event ue_buildfilter ( )
event ue_setfocus ( )
event ue_gotfocus ( )
event ue_tablechanged ( )
sle_company sle_company
cbx_base cbx_base
dw_destination dw_destination
dw_origin dw_origin
st_1 st_1
dw_ratedefaults dw_ratedefaults
cbx_reset cbx_reset
end type
global u_zonebilltofilter u_zonebilltofilter

type variables
Long	il_CustomerID
String	is_Origin
String	is_Destination
String	is_Filter
String	is_RateDefaultOverride

end variables

forward prototypes
public function string of_getfilter ()
public function long of_getcustomer ()
public function string of_getdestination ()
public function string of_getorigin ()
public function integer of_setcustomer (long al_id)
public function integer of_setdestination (string as_value)
public function integer of_setorigin (string as_value)
public function int of_setcustomertext (string as_Value)
public function string of_getcustomertext ()
public function integer of_setfocus (string as_where)
public function integer of_findorigininlist (string as_originname)
public function integer of_finddestinationinlist (string as_destination)
public subroutine of_setdefaultbase (boolean ab_set)
public subroutine of_resetoptions ()
public subroutine of_setratedefaultoverride (string as_value)
public function string of_getratedefaultoverride ()
public subroutine of_customerchanged ()
end prototypes

event ue_buildfilter;
IF Not IsNull ( il_customerid ) AND Len ( is_Origin ) > 0 AND Len ( is_Destination ) > 0 THEN
	is_Filter = "customerid = " + String ( il_customerid ) + " AND originzonename = '" +is_Origin + &
		"' and destinationzonename = '" + is_destination +"'"
ELSE
	SetNull ( is_Filter )		
END IF

end event

event ue_setfocus;sle_company.setFocus () 
end event

public function string of_getfilter ();THIS.Event ue_BuildFilter ( )

RETURN is_Filter
end function

public function long of_getcustomer ();RETURN il_customerid
end function

public function string of_getdestination ();RETURN is_destination
end function

public function string of_getorigin ();RETURN is_origin
end function

public function integer of_setcustomer (long al_id);il_CustomerID = al_id
IF il_CustomerID <> 0 THEN
	cbx_base.Checked = FALSE
	sle_company.Enabled = TRUE
ELSE
	cbx_base.Checked = TRUE
	cbx_base.Event Clicked ( )
END IF
RETURN 1
end function

public function integer of_setdestination (string as_value);is_destination = as_value
dw_destination.object.zone [ 1 ] = is_Destination
RETURN 1
end function

public function integer of_setorigin (string as_value);is_origin = as_value
dw_origin.object.zone[1] = is_Origin
RETURN 1
end function

public function int of_setcustomertext (string as_Value);sle_company.Text = as_Value

RETURN 1
end function

public function string of_getcustomertext ();RETURN sle_company.Text
end function

public function integer of_setfocus (string as_where);CHOOSE CASE UPPER ( as_Where )
		
	CASE "COMPANY"
		sle_company.post SetFocus ( )
	CASE "RATEDEFAULTS"
		dw_ratedefaults.post SetFocus()
	CASE "ORIGIN"
		dw_origin.post SetFocus ( )
	CASE "DESTINATION"
		dw_destination.setcolumn('zone')
		dw_destination.SetFocus ( )
	CASE "BASE"
		cbx_base.post SetFocus () 
END CHOOSE

RETURN 1
end function

public function integer of_findorigininlist (string as_originname);integer	li_return

datawindowchild	ldwc_origin

ldwc_origin = dw_origin.of_getzone()
if ldwc_origin.find("name = '" + as_originname + "'", 1, ldwc_origin.rowcount()) = 0 then
	li_return = -1 
else
	li_return = 1
end if

return li_return
end function

public function integer of_finddestinationinlist (string as_destination);integer	li_return
datawindowchild	ldwc_destination

ldwc_destination = dw_destination.of_getzone()
if ldwc_destination.find("name = '" + as_destination + "'", 1, ldwc_destination.rowcount()) = 0 then
	li_return = -1 
else
	li_return = 1
end if

return li_return
end function

public subroutine of_setdefaultbase (boolean ab_set);if ab_set then
	cbx_base.Checked = TRUE
	cbx_base.Event Clicked ( )
end if
end subroutine

public subroutine of_resetoptions ();if cbx_reset.checked then
	this.of_setorigin('')
	this.of_setdestination('')
	this.of_setdefaultbase(true)
end if
end subroutine

public subroutine of_setratedefaultoverride (string as_value);is_RateDefaultOverride = as_value
end subroutine

public function string of_getratedefaultoverride ();return is_RateDefaultOverride
end function

public subroutine of_customerchanged ();//roll change to defaults

this.event ue_itemchanged('CUSTOMER')

end subroutine

on u_zonebilltofilter.create
int iCurrent
call super::create
this.sle_company=create sle_company
this.cbx_base=create cbx_base
this.dw_destination=create dw_destination
this.dw_origin=create dw_origin
this.st_1=create st_1
this.dw_ratedefaults=create dw_ratedefaults
this.cbx_reset=create cbx_reset
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_company
this.Control[iCurrent+2]=this.cbx_base
this.Control[iCurrent+3]=this.dw_destination
this.Control[iCurrent+4]=this.dw_origin
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_ratedefaults
this.Control[iCurrent+7]=this.cbx_reset
end on

on u_zonebilltofilter.destroy
call super::destroy
destroy(this.sle_company)
destroy(this.cbx_base)
destroy(this.dw_destination)
destroy(this.dw_origin)
destroy(this.st_1)
destroy(this.dw_ratedefaults)
destroy(this.cbx_reset)
end on

type sle_company from singlelineedit within u_zonebilltofilter
integer x = 14
integer y = 196
integer width = 1015
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
integer accelerator = 109
borderstyle borderstyle = stylelowered!
end type

event modified;Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Long		ll_ValidateId = 0
Boolean	lb_Search = false
Boolean  lb_Employee 
Boolean	lb_Company
Boolean	lb_validate
String	ls_Search = ""
String	ls_type
Long		ll_EntityId
String	ls_MessageHeader
integer	li_Return
Long		ll_RowCount
Long		i
S_co_info	lstr_Company

IF Len  ( THIS.Text ) > 0 THEN
	ls_Search = THIS.Text 
	lb_Search = TRUE
END IF
	

li_Return = gnv_cst_Companies.of_Select &
	( lstr_company, ls_Type, lb_Search, ls_Search, lb_Validate, &
	  ll_ValidateId, lb_AllowHold, lb_Notify )
IF lstr_Company.co_id > 0 THEN
	il_CustomerID = lstr_Company.co_id
	THIS.Text = lstr_Company.Co_Name
	parent.of_customerchanged()
ELSE 
	THIS.Text = ""
	SetNull ( il_CustomerID  )
END  IF

 

end event

event getfocus;PARENT.Event ue_GotFocus ( ) 
THIS.SelectText ( 1, Len ( THIS.Text ) )
end event

type cbx_base from checkbox within u_zonebilltofilter
integer x = 640
integer y = 120
integer width = 379
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Base Table"
boolean lefttext = true
end type

event clicked;IF THIS.Checked THEN
	sle_company.Text = "[BASE]"
	sle_company.Enabled = FALSE
	il_customerid = 0
	dw_ratedefaults.of_Enableoverridedescription( true )
	parent.post of_customerchanged()
	PARENT.Event ue_ItemChanged ("BASE")
ELSE
	sle_company.Text = ""
	sle_company.Enabled = TRUE
	sle_Company.SetFocus ( )
	dw_ratedefaults.of_Enableoverridedescription( false )
	SetNull ( il_customerid )
END IF


end event

event getfocus;PARENT.Event ue_GotFocus ( ) 
end event

type dw_destination from u_dw_ratelinkzone within u_zonebilltofilter
integer x = 9
integer y = 668
integer width = 1051
integer height = 184
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
end type

event itemchanged;call super::itemchanged;long	ll_found, &
		ll_return
		
string	ls_find
		
CHOOSE CASE dwo.name
		
	CASE "zone"
		ls_find = "name = '" + data + "'"
		ll_found = idwc_zone.find(ls_find, 1,idwc_zone.rowcount()) 
		if ll_found > 0 then
			parent.of_setdestination(data)
		else
			messagebox('Destination Zone', "Zone does not exist")
			this.post selecttext(1,len(data))
			ll_return = 1
		end if

END CHOOSE

if ll_return = 0 then
	THIS.Event ue_BuildFilter ( )
	PARENT.Event ue_ItemChanged("DESTINATION")
end if

return ll_return
end event

event constructor;call super::constructor;//this.of_setzone('d_ratelinkdestzone')
ib_rmbmenu=false
this.getchild("zone", idwc_zone)
end event

event getfocus;call super::getfocus;long	ll_length, &
		ll_row

string	ls_zone

ll_row = this.getrow()

if ll_row > 0 then

	ls_zone = this.object.zone[ll_row]
	if isnull(ls_zone) then
		ll_length = 30
	else
		ll_length = len(ls_zone)
	end if
	
else
	ll_length = 30
end if

This.Post selecttext(1, ll_length)
end event

event lbuttondown;call super::lbuttondown;this.post setfocus()
end event

event itemerror;call super::itemerror;CHOOSE CASE dwo.name
		
	CASE "zone"
		return 1
		
END CHOOSE

end event

type dw_origin from u_dw_ratelinkzone within u_zonebilltofilter
integer x = 9
integer y = 472
integer width = 1051
integer height = 184
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_ratelinkorigzone"
end type

event itemchanged;call super::itemchanged;long	ll_found, &
		ll_return
		
string	ls_find
		
CHOOSE CASE dwo.name
		
	CASE "zone"
		if isnull(data) or len(data) = 0 then 
			dw_destination.enabled=false
			dw_destination.object.zone[dw_destination.getrow()] = ''
		else
			ls_find = "name = '" + data + "'"
			ll_found = idwc_zone.find(ls_find, 1,idwc_zone.rowcount()) 
			if ll_found > 0 then
				dw_destination.enabled=true
				parent.of_setorigin(data)
			else
				messagebox('Origin Zone', "Zone does not exist")
				this.post selecttext(1,len(data))
				ll_return = 1
			end if
		end if
		
END CHOOSE

if ll_return = 0 then
	THIS.Event ue_BuildFilter ( )
	PARENT.Event ue_ItemChanged("ORIGIN")
end if

return ll_return
end event

event constructor;call super::constructor;//this.of_setzone('d_ratelinkorigzone')

//THIS.dataobject=as_value

this.getchild("zone", idwc_zone)
ib_rmbmenu=false
end event

event lbuttondown;call super::lbuttondown;this.post setfocus()
end event

event getfocus;call super::getfocus;long	ll_length, &
		ll_row

string	ls_zone

ll_row = this.getrow()

if ll_row > 0 then

	ls_zone = this.object.zone[ll_row]
	if isnull(ls_zone) then
		ll_length = 30
	else
		ll_length = len(ls_zone)
	end if
	
else
	ll_length = 30
end if

This.Post selecttext(1, ll_length)
end event

event itemerror;call super::itemerror;CHOOSE CASE dwo.name
		
	CASE "zone"
		return 1
		
END CHOOSE

end event

type st_1 from statictext within u_zonebilltofilter
integer x = 18
integer y = 120
integer width = 325
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Co&mpany"
boolean focusrectangle = false
end type

type dw_ratedefaults from u_dw_ratedefaults within u_zonebilltofilter
integer x = 14
integer y = 288
integer height = 184
integer taborder = 40
boolean bringtotop = true
end type

event itemchanged;call super::itemchanged;Parent.of_SetRateDefaultOverride(data)
Parent.Event ue_ItemChanged("RATEDEFAULTS")
end event

event constructor;this.settransobject(SQLCA)
ib_rmbmenu=false
end event

event ue_clearblankrow;this.setredraw(false)
dwitemstatus	ldwstatus

Long	ll_Row
string	ls_value

ll_Row = THIS.GetRow ( )
if ll_row > 0 then
	if this.accepttext() = 1 then
		ls_value = this.object.overridedescription[ll_row]
		IF IsNull (  ls_value   ) then
			THIS.RowsDiscard ( ll_Row, ll_Row, Primary! ) 
		else
			if len(trim(ls_value)) = 0 then
				ldwstatus = this.GetItemStatus(ll_row, 'overridedescription', Primary!)
				choose case ldwstatus
					case datamodified!
						this.deleterow(ll_row)
					case newmodified!
						THIS.RowsDiscard ( ll_Row, ll_Row, Primary! ) 
				end choose
			end if
		END IF	
	end if
end if

this.setredraw(true)
end event

event ue_allowchangefocus;integer	li_Return

li_Return = THIS.AcceptText ( )

RETURN li_Return

end event

type cbx_reset from checkbox within u_zonebilltofilter
integer x = 18
integer y = 12
integer width = 969
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Reset Zones on table selection."
boolean checked = true
end type

