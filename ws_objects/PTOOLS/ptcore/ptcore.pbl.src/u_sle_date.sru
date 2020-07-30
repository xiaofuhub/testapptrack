$PBExportHeader$u_sle_date.sru
forward
global type u_sle_date from singlelineedit
end type
end forward

global type u_sle_date from singlelineedit
int Width=297
int Height=76
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_sle_date u_sle_date

type variables
protected:
powerobject ipoa_suspend_list[]
boolean ib_suspend
end variables

forward prototypes
public subroutine of_set_suspend (boolean ab_suspend)
public function integer of_suspend_list_add (powerobject apo_target)
public function date of_get_date ()
public function date of_get_date (boolean ab_allowpastexpiration)
end prototypes

public subroutine of_set_suspend (boolean ab_suspend);ib_suspend = ab_suspend
end subroutine

public function integer of_suspend_list_add (powerobject apo_target);//The suspend_list is a list of outside objects (such as a cancel button) that, if clicked,
//will cause the processing of text in this object to be suspended during losefocus.

ipoa_suspend_list[upperbound(ipoa_suspend_list) + 1] = apo_target
return 1
end function

public function date of_get_date ();//if isdate(this.text) then return date(this.text) else return null_date
Boolean	lb_AllowDatesPastExpiration = TRUE
RETURN THIS.of_get_Date ( lb_AllowDatesPastExpiration )
end function

public function date of_get_date (boolean ab_allowpastexpiration);Date ld_ReturnDate

if isdate(this.text) THEN
	ld_returnDate =  date(this.text)
else 
	ld_returnDate = null_date
END IF

IF NOT ab_allowPastExpiration AND Not isNull ( ld_returnDate )THEN
	n_cst_LicenseManager	lnv_LicenseManager

	IF daysafter(lnv_LicenseManager.of_GetLicenseExpiration ( ), ld_returnDate) > 7 then 
		messagebox("Selected Date", lnv_LicenseManager.of_GetExpirationNotice ( ) +&
		"You cannot work with dates that are more than 7 days past the expiration "+&
		"date.  Please contact Profit Tools to extend your registration.", exclamation!)

		SetNull ( ld_ReturnDate )
	end if
END IF

RETURN ld_returnDate
end function

event getfocus;this.selecttext(1, len(this.text))
end event

event losefocus;date ld_work
integer li_ndx
powerobject lpo_focus
n_cst_string lnv_string

if len(this.text) > 0 then
	ld_work = lnv_string.of_SpecialDate(this.text)
	if isnull(ld_work) and not ib_suspend then
		if not keydown(keytab!) then
			lpo_focus = getfocus()
			if isvalid(lpo_focus) then
				for li_ndx = 1 to upperbound(ipoa_suspend_list)
					if isvalid(ipoa_suspend_list[li_ndx]) then
						if ipoa_suspend_list[li_ndx] = lpo_focus then return
					end if
				next
			end if
		end if

		post beep(1)
		this.post selecttext(1, len(this.text))
		this.post setfocus()
		return
	end if
else
	setnull(ld_work)
end if

this.text = string(ld_work, "m/d/yy")
end event

event modified;if getfocus() = this then this.event trigger losefocus()
end event

