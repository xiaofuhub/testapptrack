$PBExportHeader$u_cst_ratinglocationzone.sru
forward
global type u_cst_ratinglocationzone from u_cst_ratinglocation
end type
type dw_1 from u_dw_ratelinkzone within u_cst_ratinglocationzone
end type
end forward

global type u_cst_ratinglocationzone from u_cst_ratinglocation
integer width = 2734
integer height = 196
dw_1 dw_1
end type
global u_cst_ratinglocationzone u_cst_ratinglocationzone

forward prototypes
public function string of_getzone ()
public function integer of_hasdata ()
public subroutine of_initialize ()
public subroutine of_setzone (string as_value)
end prototypes

public function string of_getzone ();long		ll_row
string	ls_zone

ll_row = dw_1.getrow()
if ll_row > 0  then
	if dw_1.accepttext() = 1 then
		ls_zone = dw_1.object.zone[ll_row]
	end if
end if

return  ls_zone
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
Int		li_HasZone

IF LEN ( THIS.of_GetSite ( ) ) > 0 THEN
	li_HasSite = (2^0) 
END IF

IF LEN ( THIS.of_GetState ( ) ) > 0 THEN
	li_HasState = (2^1) 
END IF

IF LEN ( THIS.of_GetZip ( ) ) > 0 THEN
	li_HasZip = (2^2) 
END IF

IF LEN ( THIS.of_GetZone ( ) ) > 0 THEN
	li_HasZone = (2^3) 
END IF

RETURN li_HasZone + li_HasZip + li_HasState + li_HasSite

end function

public subroutine of_initialize ();dw_1.reset()
dw_1.InsertRow(0)
sle_zip.text=''
sle_state.text=''
sle_site.text=''
sle_zip.enabled=true
sle_state.enabled=true
sle_site.enabled=true

end subroutine

public subroutine of_setzone (string as_value);dw_1.object.zone[1] = as_value
end subroutine

on u_cst_ratinglocationzone.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_cst_ratinglocationzone.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_setfocus;CHOOSE CASE UPPER ( as_Where )
	CASE "ZONE"
		dw_1.POST setcolumn(1)
		dw_1.POST setfocus ( )
	CASE "SITE"
		sle_site.SetFocus ( )
	CASE "STATE"
		sle_state.SetFocus ( )
	CASE ELSE
		sle_zip.SetFocus ( )
END CHOOSE
		

end event

type sle_state from u_cst_ratinglocation`sle_state within u_cst_ratinglocationzone
integer x = 1504
integer y = 84
integer width = 178
integer height = 80
integer taborder = 30
end type

type sle_zip from u_cst_ratinglocation`sle_zip within u_cst_ratinglocationzone
integer x = 1175
integer y = 84
integer width = 329
integer height = 80
integer taborder = 20
end type

type sle_site from u_cst_ratinglocation`sle_site within u_cst_ratinglocationzone
integer x = 1682
integer y = 84
integer width = 1038
integer height = 80
integer taborder = 40
end type

type st_1 from u_cst_ratinglocation`st_1 within u_cst_ratinglocationzone
integer x = 1509
integer y = 8
integer width = 178
integer height = 76
string text = "State"
end type

type st_2 from u_cst_ratinglocation`st_2 within u_cst_ratinglocationzone
integer x = 1179
integer y = 8
integer width = 329
integer height = 76
string text = "Zipcode"
end type

type st_3 from u_cst_ratinglocation`st_3 within u_cst_ratinglocationzone
integer x = 1691
integer y = 8
integer width = 1029
integer height = 76
end type

type dw_1 from u_dw_ratelinkzone within u_cst_ratinglocationzone
integer x = 14
integer y = 4
integer taborder = 10
boolean bringtotop = true
end type

event itemchanged;call super::itemchanged;choose case dwo.name
	case "zone"
		if len(trim(data)) = 0 then
			sle_zip.enabled=true
			sle_state.enabled=true
			sle_site.enabled=true
		else
			sle_zip.enabled=false
			sle_state.enabled=false
			sle_site.enabled=false
			sle_zip.text=''
			sle_state.text=''
			sle_site.text=''
		end if
end choose
			
			
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

