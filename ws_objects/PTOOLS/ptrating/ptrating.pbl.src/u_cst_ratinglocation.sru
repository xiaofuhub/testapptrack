$PBExportHeader$u_cst_ratinglocation.sru
forward
global type u_cst_ratinglocation from u_base
end type
type sle_state from singlelineedit within u_cst_ratinglocation
end type
type sle_zip from singlelineedit within u_cst_ratinglocation
end type
type sle_site from singlelineedit within u_cst_ratinglocation
end type
type st_1 from statictext within u_cst_ratinglocation
end type
type st_2 from statictext within u_cst_ratinglocation
end type
type st_3 from statictext within u_cst_ratinglocation
end type
end forward

global type u_cst_ratinglocation from u_base
integer width = 1618
integer height = 248
long backcolor = 12632256
event ue_setfocus ( string as_where )
event ue_sitechanged ( )
sle_state sle_state
sle_zip sle_zip
sle_site sle_site
st_1 st_1
st_2 st_2
st_3 st_3
end type
global u_cst_ratinglocation u_cst_ratinglocation

type variables
Long	il_SiteID
String	is_Zip
String	is_State
String	is_Site
end variables

forward prototypes
public function integer of_resolvelocation ()
public function Long of_getsiteid ()
public function string of_getsite ()
public function string of_getzip ()
public function string of_getstate ()
public function String of_getzone ()
public function integer of_hasdata ()
protected function integer of_lookupsite ()
public subroutine of_setsiteid (long al_coid)
public subroutine of_setzip (string as_value)
public subroutine of_setstate (string as_value)
public subroutine of_setsite (string as_value)
public subroutine of_setcompany (long al_coid)
public subroutine of_setcompany (n_cst_beo_company anv_company)
end prototypes

event ue_setfocus(string as_where);CHOOSE CASE UPPER ( as_Where )
			
	CASE "SITE"
		sle_site.Post SetFocus ( )
	CASE "STATE"
		sle_state.Post SetFocus ( )
	CASE ELSE
		sle_zip.POst SetFocus ( )
END CHOOSE
		
		
end event

public function integer of_resolvelocation ();String	ls_Zip
String	ls_State
String	ls_Site
String	ls_Locator
Boolean	lb_Resolved
Long		ll_SiteID

Int		li_Return = -1

n_cst_Sql					lnv_Sql
S_Parm						lstr_parm
n_cst_msg					lnv_msg
n_cst_routing_PCMiler	lnv_Routing
n_cst_Trip					lnv_Trip
lnv_trip = CREATE n_cst_Trip
lnv_Trip.of_Connect ( lnv_Routing )


ls_Zip = trim ( sle_zip.Text )
ls_State = trim ( sle_state.Text ) 

IF Len ( ls_State ) = 0 AND Len ( ls_Zip ) > 0 THEN
	// try to determine the state from the zip in case we need it later
	IF IsValid ( lnv_Routing ) THEN
		ls_Locator = lnv_Routing.of_makelocator (  "", ls_state, ls_zip )  
		is_State = lnv_Routing.of_getpartoflocater ( ls_locator, appeon_constant.cs_locater_state, TRUE )
		DESTROY ( lnv_Trip )
		lb_Resolved = TRUE
	END IF	
END IF

//IF Len ( ls_Zip ) > 0 AND Not lb_Resolved THEN
//	is_Zip = ls_Zip
//	lb_Resolved = TRUE
//END IF

IF Len ( ls_State ) > 0 AND Not lb_Resolved THEN
	is_State = ls_state
	lb_Resolved = TRUE
END IF

IF lb_Resolved THEN	
	li_Return = 1
	//sle_zip.Text = is_Zip
	sle_state.Text  = is_State
END IF


RETURN li_Return
end function

public function Long of_getsiteid ();Return il_SiteID
end function

public function string of_getsite ();Return is_Site
end function

public function string of_getzip ();RETURN is_Zip
end function

public function string of_getstate ();RETURN is_State

end function

public function String of_getzone ();
RETURN ""
end function

public function integer of_hasdata ();// Returns an integer derived from the binary value of associated positions.
// ( ZIP STATE SITE )
// (  1    1    0   )
// Zip is the most signifigant bit and site is the least
// if return = 7 then all fields have been filled in.
// if return = 6 then only zip and state have data.

Int		li_HasSite
Int		li_HasState
Int		li_HasZip

IF LEN ( THIS.of_GetSite ( ) ) > 0 THEN
	li_HasSite = (2^0) 
END IF

IF LEN ( THIS.of_GetState ( ) ) > 0 THEN
	li_HasState = (2^1) 
END IF

IF LEN ( THIS.of_GetZip ( ) ) > 0 THEN
	li_HasZip = (2^2) 
END IF

RETURN li_HasZip + li_HasState + li_HasSite

end function

protected function integer of_lookupsite ();Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Long		ll_ValidateId = 0
Boolean	lb_Search = false
Boolean  lb_Employee 
Boolean	lb_Company
Boolean	lb_validate
String	ls_Search = ""
String	ls_type
Int		li_Return = -1 

ls_Search = Trim ( sle_site.Text )

S_co_info	lstr_Company

IF Len  ( ls_Search ) > 0 THEN
	lb_Search = TRUE
END IF

li_Return = gnv_cst_Companies.of_Select &
	( lstr_company, ls_Type, lb_Search, ls_Search, lb_Validate, &
	  ll_ValidateId, lb_AllowHold, lb_Notify )
	  
IF lstr_Company.co_id > 0 THEN
	
	sle_Site.Text = lstr_Company.co_Name
	sle_State.Text = lstr_Company.co_State
	sle_Zip.Text = lstr_Company.co_Zip
	
	is_State = lstr_Company.co_State
	is_Zip = String (  lstr_Company.co_Zip )
	is_site = lstr_Company.co_Name
	il_siteid = lstr_Company.co_ID
	li_Return = 1
END IF

Return li_Return

end function

public subroutine of_setsiteid (long al_coid);il_siteid = al_coID

end subroutine

public subroutine of_setzip (string as_value);sle_Zip.Text = as_value
is_Zip = as_value

end subroutine

public subroutine of_setstate (string as_value);sle_State.Text = as_value
is_State = as_value

end subroutine

public subroutine of_setsite (string as_value);sle_Site.Text = as_value
is_site = as_value


end subroutine

public subroutine of_setcompany (long al_coid);
n_cst_beo_Company		lnv_Company

IF al_coid > 0 THEN
	lnv_Company = CREATE n_cst_beo_Company
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceID ( al_coid )
	
	this.of_setcompany(lnv_company)
	
	destroy lnv_Company
	
END IF


end subroutine

public subroutine of_setcompany (n_cst_beo_company anv_company);if isvalid(anv_company) then
	this.of_SetSiteid(anv_company.of_Getid())
	this.of_SetSite(anv_company.of_GetName())
	this.of_SetState(anv_company.of_GetState())
	this.of_SetZip(anv_company.of_GetZip())
	sle_state.enabled=false
	sle_zip.enabled=false
end if
end subroutine

on u_cst_ratinglocation.create
int iCurrent
call super::create
this.sle_state=create sle_state
this.sle_zip=create sle_zip
this.sle_site=create sle_site
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_state
this.Control[iCurrent+2]=this.sle_zip
this.Control[iCurrent+3]=this.sle_site
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
end on

on u_cst_ratinglocation.destroy
call super::destroy
destroy(this.sle_state)
destroy(this.sle_zip)
destroy(this.sle_site)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

type sle_state from singlelineedit within u_cst_ratinglocation
integer x = 407
integer y = 96
integer width = 165
integer height = 72
integer taborder = 20
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
borderstyle borderstyle = stylelowered!
end type

event modified;is_State =  Trim ( THIS.Text )
Parent.Post of_ResolveLocation ( )
end event

event getfocus;
THIS.SelectText ( 1 , Len ( THIS.Text ) )
end event

type sle_zip from singlelineedit within u_cst_ratinglocation
integer x = 32
integer y = 96
integer width = 325
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;is_Zip = Trim ( THIS.Text )
Parent.Post of_ResolveLocation ( )
end event

event getfocus;THIS.SelectText ( 1 , Len ( THIS.Text ) )
end event

type sle_site from singlelineedit within u_cst_ratinglocation
integer x = 631
integer y = 96
integer width = 946
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
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;is_Site = Trim ( THIS.Text )
IF Len ( THIS.Text  ) > 0 THEN
	Parent.Post of_LookupSite ( )
	parent.Post event ue_sitechanged()
END IF

end event

event getfocus;THIS.SelectText ( 1 , Len ( THIS.Text ) )
end event

type st_1 from statictext within u_cst_ratinglocation
integer x = 407
integer y = 40
integer width = 82
integer height = 56
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
string text = "St."
boolean focusrectangle = false
end type

type st_2 from statictext within u_cst_ratinglocation
integer x = 37
integer y = 40
integer width = 87
integer height = 56
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
string text = "Zip"
boolean focusrectangle = false
end type

type st_3 from statictext within u_cst_ratinglocation
integer x = 631
integer y = 40
integer width = 210
integer height = 52
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
string text = "Site"
boolean focusrectangle = false
end type

