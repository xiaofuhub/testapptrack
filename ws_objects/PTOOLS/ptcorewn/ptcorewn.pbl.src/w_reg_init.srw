$PBExportHeader$w_reg_init.srw
forward
global type w_reg_init from w_reg_base
end type
type st_welcome from statictext within w_reg_init
end type
type cb_next from commandbutton within w_reg_init
end type
type st_02_cn_label from statictext within w_reg_init
end type
type sle_02_cn_entry from singlelineedit within w_reg_init
end type
type st_02_tz_label from statictext within w_reg_init
end type
type ddlb_02_tz_entry from dropdownlistbox within w_reg_init
end type
type st_setreg from statictext within w_reg_init
end type
type st_allset from statictext within w_reg_init
end type
end forward

global type w_reg_init from w_reg_base
st_welcome st_welcome
cb_next cb_next
st_02_cn_label st_02_cn_label
sle_02_cn_entry sle_02_cn_entry
st_02_tz_label st_02_tz_label
ddlb_02_tz_entry ddlb_02_tz_entry
st_setreg st_setreg
st_allset st_allset
end type
global w_reg_init w_reg_init

type variables
Private:
Integer	ii_Stage = 1
end variables

forward prototypes
protected subroutine set_next ()
private function integer wf_gettimezoneentry ()
end prototypes

protected subroutine set_next ();Boolean lb_Approval

CHOOSE CASE ii_Stage

CASE 2
	IF Len ( sle_02_cn_Entry.Text ) > 0 AND &
		NOT IsNull ( wf_GetTimeZoneEntry ( ) ) THEN

		lb_Approval = TRUE

	END IF

END CHOOSE

cb_Next.Enabled = lb_Approval
end subroutine

private function integer wf_gettimezoneentry ();//Prior to 3.5.18 (11/4/02), this was using a windows API message to try to get the selected item.
//This used to work, but at some point it appeared to stop working, probably due to a windows version change, 
//although I could not reproduce the issue in development on Win98.
//The end result was that ATL timezone would be set all or most of the time.  
//Getting the value using more standard means below will hopefully correct the problem.

Integer	li_Index, &
			li_TimeZone
String	ls_Text


ls_Text = ddlb_02_tz_entry.Text


IF Len ( ls_Text ) > 0 THEN

	li_Index = ddlb_02_tz_entry.FindItem ( ls_Text, 0 )

END IF


IF li_Index > 0 THEN

	li_TimeZone = 7 - li_Index

ELSE

	SetNull ( li_TimeZone )

END IF

RETURN li_TimeZone
end function

on w_reg_init.create
int iCurrent
call super::create
this.st_welcome=create st_welcome
this.cb_next=create cb_next
this.st_02_cn_label=create st_02_cn_label
this.sle_02_cn_entry=create sle_02_cn_entry
this.st_02_tz_label=create st_02_tz_label
this.ddlb_02_tz_entry=create ddlb_02_tz_entry
this.st_setreg=create st_setreg
this.st_allset=create st_allset
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_welcome
this.Control[iCurrent+2]=this.cb_next
this.Control[iCurrent+3]=this.st_02_cn_label
this.Control[iCurrent+4]=this.sle_02_cn_entry
this.Control[iCurrent+5]=this.st_02_tz_label
this.Control[iCurrent+6]=this.ddlb_02_tz_entry
this.Control[iCurrent+7]=this.st_setreg
this.Control[iCurrent+8]=this.st_allset
end on

on w_reg_init.destroy
call super::destroy
destroy(this.st_welcome)
destroy(this.cb_next)
destroy(this.st_02_cn_label)
destroy(this.sle_02_cn_entry)
destroy(this.st_02_tz_label)
destroy(this.ddlb_02_tz_entry)
destroy(this.st_setreg)
destroy(this.st_allset)
end on

event open;call super::open;mle_instruct.text = "Thank you for choosing Profit Tools!~r~n~r~n" +& 
"This screen will collect a few basic pieces of information needed to set up the program, and will allow you to enter a registration key that will unlock the software for your use.  The key must be acquired from us ~"live~", over the phone, so you should complete this procedure at a time when you'll be able to contact us.~r~n~r~n" +&
"If you'd like to wait until later, or if you need to start over at any point during the procedure, just press Cancel at the bottom of the screen, and restart the program when it's convenient.  None of your entries will have taken effect, and you'll be returned to this screen for a fresh start.~r~n~r~n" +&
"If you are ready to begin now, press Next to proceed!"
end event

type cb_lm_list from w_reg_base`cb_lm_list within w_reg_init
boolean Visible=false
end type

type st_lm_disp from w_reg_base`st_lm_disp within w_reg_init
boolean Visible=false
end type

type st_lm_label from w_reg_base`st_lm_label within w_reg_init
boolean Visible=false
end type

type dw_cn_disp from w_reg_base`dw_cn_disp within w_reg_init
boolean Visible=false
end type

type cb_process from w_reg_base`cb_process within w_reg_init
int TabOrder=60
boolean Visible=false
end type

type cb_cancel from w_reg_base`cb_cancel within w_reg_init
int TabOrder=90
end type

type cb_ok from w_reg_base`cb_ok within w_reg_init
int TabOrder=70
boolean Visible=false
end type

type st_ru_disp from w_reg_base`st_ru_disp within w_reg_init
boolean Visible=false
long BackColor=12632256
end type

type st_lu_disp from w_reg_base`st_lu_disp within w_reg_init
boolean Visible=false
long BackColor=12632256
end type

type st_ru_label from w_reg_base`st_ru_label within w_reg_init
boolean Visible=false
end type

type st_lu_label from w_reg_base`st_lu_label within w_reg_init
boolean Visible=false
end type

type st_cn_label from w_reg_base`st_cn_label within w_reg_init
boolean Visible=false
end type

type sle_rk_entry from w_reg_base`sle_rk_entry within w_reg_init
int TabOrder=50
boolean Visible=false
end type

type st_rc_disp from w_reg_base`st_rc_disp within w_reg_init
boolean Visible=false
end type

type st_rk_label from w_reg_base`st_rk_label within w_reg_init
boolean Visible=false
end type

type st_rc_label from w_reg_base`st_rc_label within w_reg_init
boolean Visible=false
end type

type st_pv_label from w_reg_base`st_pv_label within w_reg_init
boolean Visible=false
end type

type st_pv_disp from w_reg_base`st_pv_disp within w_reg_init
boolean Visible=false
end type

type mle_instruct from w_reg_base`mle_instruct within w_reg_init
int Height=928
end type

type st_welcome from statictext within w_reg_init
int X=992
int Y=68
int Width=827
int Height=180
boolean Enabled=false
boolean BringToTop=true
string Text="Welcome!"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_next from commandbutton within w_reg_init
int X=741
int Y=1296
int Width=274
int Height=88
int TabOrder=80
boolean BringToTop=true
string Text="Next >>"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_Reject
n_cst_LicenseManager	lnv_LicenseManager

choose case ii_Stage
case 1
	mle_instruct.text = "Please provide the information requested below."
	mle_instruct.height = 281
	st_welcome.visible = false
	st_setreg.visible = true

	integer shift_x
	shift_x = sle_02_cn_entry.x - mle_instruct.x
	st_02_cn_label.x -= shift_x
	sle_02_cn_entry.x -= shift_x
	st_02_tz_label.x -= shift_x
	ddlb_02_tz_entry.x -= shift_x

	st_02_cn_label.visible = true
	sle_02_cn_entry.visible = true
	st_02_tz_label.visible = true
	ddlb_02_tz_entry.visible = true

	sle_02_cn_entry.setfocus()
	this.enabled = false
	ii_Stage = 2
case 2

	IF lnv_LicenseManager.of_SetLicensedCompany ( Trim ( sle_02_cn_Entry.Text ) ) = -1 THEN
		MessageBox ( "Information Entry", "You must enter your company's name before "+&
			"proceeding.", Exclamation! )
		sle_02_cn_Entry.Post SetFocus ( )
		RETURN
	END IF

	IF lnv_LicenseManager.of_SetBaseTimeZone ( wf_GetTimeZoneEntry ( ) ) = -1 THEN
		MessageBox ( "Information Entry", "You must specify the time zone of your "+&
			"company's base terminal before proceeding.", Exclamation! )
		ddlb_02_tz_Entry.Post SetFocus ( )
		RETURN
	END IF

	IF lnv_LicenseManager.of_SetLicenseStart ( Date ( DateTime ( Today ( ) ) ) ) = -1 THEN
		MessageBox ( "Information Entry", "Could not set license start date.  Please retry." )
		RETURN
	END IF

	IF lnv_LicenseManager.of_SetDBVersion ( gnv_App.of_GetDBExpected ( ) ) = -1 THEN
		MessageBox ( "Information Entry", "Could not set database version.  Please retry." )
		RETURN
	END IF

	st_02_cn_label.visible = false
	sle_02_cn_entry.visible = false
	st_02_tz_label.visible = false
	ddlb_02_tz_entry.visible = false

	mle_instruct.text = "Please call Profit Tools at (603) 659-3822 during East Coast business hours to obtain the registration keys that will unlock the software.  Press~r~nOK when all the required keys have been entered."
//	mle_instruct.height = 281

//	st_cn_disp.text = lnv_LicenseManager.of_GetLicensedCompany ( )
	dw_cn_disp.object.text_val[1] = lnv_LicenseManager.of_GetLicensedCompany ( )

	st_cn_label.visible = true
//	st_cn_disp.visible = true
	dw_cn_disp.visible = true
	st_pv_label.visible = true
	st_pv_disp.visible = true
	st_lu_label.visible = true
	st_lu_disp.visible = true
	st_ru_label.visible = true
	st_ru_disp.visible = true
	st_lm_label.visible = true
	st_lm_disp.visible = true
	cb_lm_list.visible = true
	st_rc_label.visible = true
	st_rc_disp.visible = true
	st_rk_label.visible = true
	sle_rk_entry.visible = true
	cb_process.visible = true

	wf_SetValues ( )

	This.Enabled = FALSE
	This.Visible = FALSE
	cb_Ok.Visible = TRUE

	ii_Stage = 3

end choose
end event

event getfocus;this.default = true
end event

event losefocus;this.default = false
end event

type st_02_cn_label from statictext within w_reg_init
int X=2309
int Y=652
int Width=1061
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Program Licensed to (Company Name):"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_02_cn_entry from singlelineedit within w_reg_init
event enchange pbm_enchange
event keydown pbm_keydown
int X=2309
int Y=732
int Width=1929
int Height=80
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
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

event enchange;post set_next()
end event

event keydown;if keydown(keyenter!) then
	if keydown(keyshift!) then cb_cancel.post setfocus() &
		else ddlb_02_tz_entry.post setfocus()
end if
end event

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;if this.text = trim(this.text) then return

this.text = trim(this.text)
end event

type st_02_tz_label from statictext within w_reg_init
int X=2309
int Y=872
int Width=704
int Height=76
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Base Terminal Time Zone:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_02_tz_entry from dropdownlistbox within w_reg_init
event keydown pbm_keydown
int X=2309
int Y=956
int Width=681
int Height=352
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"ATLANTIC (ATL)",&
"EASTERN (EST)",&
"CENTRAL (CTL)",&
"MOUNTAIN (MTN)",&
"PACIFIC (PAC)",&
"ALASKA (ALK)",&
"HAWAII (HWI)"}
end type

event keydown;if keydown(keyenter!) then
	if keydown(keyshift!) then
		sle_02_cn_Entry.post setfocus()
	elseif cb_next.enabled then
		cb_next.post setfocus()
	else
		cb_cancel.post setfocus()
	end if
end if
end event

event selectionchanged;post set_next()
end event

type st_setreg from statictext within w_reg_init
int X=873
int Y=100
int Width=1083
int Height=120
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Setup and Registration"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_allset from statictext within w_reg_init
int X=965
int Y=100
int Width=873
int Height=120
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="You're All Set!"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

