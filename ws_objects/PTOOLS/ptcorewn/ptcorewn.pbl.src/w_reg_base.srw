$PBExportHeader$w_reg_base.srw
forward
global type w_reg_base from w_response
end type
type cb_lm_list from commandbutton within w_reg_base
end type
type st_lm_disp from statictext within w_reg_base
end type
type st_lm_label from statictext within w_reg_base
end type
type dw_cn_disp from datawindow within w_reg_base
end type
type st_logo_mask from statictext within w_reg_base
end type
type st_cn_disp from statictext within w_reg_base
end type
type cb_process from commandbutton within w_reg_base
end type
type cb_cancel from commandbutton within w_reg_base
end type
type cb_ok from commandbutton within w_reg_base
end type
type st_ru_disp from statictext within w_reg_base
end type
type st_lu_disp from statictext within w_reg_base
end type
type st_ru_label from statictext within w_reg_base
end type
type st_lu_label from statictext within w_reg_base
end type
type st_cn_label from statictext within w_reg_base
end type
type sle_rk_entry from singlelineedit within w_reg_base
end type
type st_rc_disp from statictext within w_reg_base
end type
type st_rk_label from statictext within w_reg_base
end type
type st_rc_label from statictext within w_reg_base
end type
type st_pv_label from statictext within w_reg_base
end type
type st_pv_disp from statictext within w_reg_base
end type
type mle_instruct from multilineedit within w_reg_base
end type
type p_logo from picture within w_reg_base
end type
type gb_1 from groupbox within w_reg_base
end type
type st_logo_back from statictext within w_reg_base
end type
end forward

global type w_reg_base from w_response
integer x = 832
integer y = 360
integer width = 2071
integer height = 1532
long backcolor = 12632256
cb_lm_list cb_lm_list
st_lm_disp st_lm_disp
st_lm_label st_lm_label
dw_cn_disp dw_cn_disp
st_logo_mask st_logo_mask
st_cn_disp st_cn_disp
cb_process cb_process
cb_cancel cb_cancel
cb_ok cb_ok
st_ru_disp st_ru_disp
st_lu_disp st_lu_disp
st_ru_label st_ru_label
st_lu_label st_lu_label
st_cn_label st_cn_label
sle_rk_entry sle_rk_entry
st_rc_disp st_rc_disp
st_rk_label st_rk_label
st_rc_label st_rc_label
st_pv_label st_pv_label
st_pv_disp st_pv_disp
mle_instruct mle_instruct
p_logo p_logo
gb_1 gb_1
st_logo_back st_logo_back
end type
global w_reg_base w_reg_base

type variables
Private:
Integer	ii_FailedKeys
Integer	ii_FailedCodes
end variables

forward prototypes
protected function integer wf_update ()
private subroutine wf_listmodules ()
protected subroutine wf_setvalues ()
end prototypes

protected function integer wf_update ();//Returns : 1 = Success, 0 = No update attempt (values missing), -1 = Failure

n_cst_LicenseManager	lnv_LicenseManager
String	ls_MessageHeader, &
			ls_Message
Integer	li_Choice

ls_MessageHeader = "Update Registration Settings"


DO

	CHOOSE CASE lnv_LicenseManager.of_Update ( )
	
	CASE 1
	
		//Success

		Close ( This )
	
		RETURN 1
	
	CASE 0
	
		ls_Message = "Not all required values have been specified.  Please process " +&
			"another key, and retry."
		MessageBox ( ls_MessageHeader, ls_Message )
		sle_rk_Entry.SetFocus ( )

		RETURN 0
	
	CASE ELSE //-1
	
		ls_Message = "Could not save settings to database."
			ls_Message += "~n~nIf Retry fails, press Cancel to exit this window.  You will "+&
			"need to perform the Registration procedure again."
		
		li_Choice = MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, RetryCancel!, 1 )

		IF li_Choice = 2 THEN
			cb_Cancel.Event Post Clicked ( )
			RETURN -1
		END IF

	END CHOOSE

LOOP WHILE li_Choice = 1
end function

private subroutine wf_listmodules ();String	lsa_ModuleDisplayList[], &
			ls_MessageHeader, &
			ls_Message
Integer	li_ModuleDisplayCount
n_cst_LicenseManager	lnv_LicenseManager
n_cst_String	lnv_String

ls_MessageHeader = "Licensed Module List"

li_ModuleDisplayCount = lnv_LicenseManager.of_GetModuleDisplayList ( lsa_ModuleDisplayList )

CHOOSE CASE li_ModuleDisplayCount

CASE 0

	ls_Message = "No modules have been licensed."

CASE IS > 0

	lnv_String.of_ArrayToString ( lsa_ModuleDisplayList, "~n", ls_Message )

CASE ELSE

	ls_Message = "Could not determine module list."

END CHOOSE

MessageBox ( ls_MessageHeader, ls_Message )
end subroutine

protected subroutine wf_setvalues ();n_cst_LicenseManager	lnv_LicenseManager

st_pv_disp.text = gnv_App.of_GetVersion ( )
dw_cn_disp.object.text_val[1] = lnv_LicenseManager.of_GetLicensedCompany ( )
st_lu_disp.text = String ( lnv_LicenseManager.of_GetLicensedUsers ( ) )
st_ru_disp.text = String ( lnv_LicenseManager.of_GetLicenseExpiration ( ) )
st_lm_disp.text = String ( lnv_LicenseManager.of_GetModuleDisplayCount ( ) )

st_rc_disp.text = lnv_LicenseManager.of_GenerateRequestCode ( )
sle_rk_entry.text = ""
ii_FailedKeys = 0
sle_rk_entry.SetFocus ( )
end subroutine

on w_reg_base.create
int iCurrent
call super::create
this.cb_lm_list=create cb_lm_list
this.st_lm_disp=create st_lm_disp
this.st_lm_label=create st_lm_label
this.dw_cn_disp=create dw_cn_disp
this.st_logo_mask=create st_logo_mask
this.st_cn_disp=create st_cn_disp
this.cb_process=create cb_process
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_ru_disp=create st_ru_disp
this.st_lu_disp=create st_lu_disp
this.st_ru_label=create st_ru_label
this.st_lu_label=create st_lu_label
this.st_cn_label=create st_cn_label
this.sle_rk_entry=create sle_rk_entry
this.st_rc_disp=create st_rc_disp
this.st_rk_label=create st_rk_label
this.st_rc_label=create st_rc_label
this.st_pv_label=create st_pv_label
this.st_pv_disp=create st_pv_disp
this.mle_instruct=create mle_instruct
this.p_logo=create p_logo
this.gb_1=create gb_1
this.st_logo_back=create st_logo_back
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_lm_list
this.Control[iCurrent+2]=this.st_lm_disp
this.Control[iCurrent+3]=this.st_lm_label
this.Control[iCurrent+4]=this.dw_cn_disp
this.Control[iCurrent+5]=this.st_logo_mask
this.Control[iCurrent+6]=this.st_cn_disp
this.Control[iCurrent+7]=this.cb_process
this.Control[iCurrent+8]=this.cb_cancel
this.Control[iCurrent+9]=this.cb_ok
this.Control[iCurrent+10]=this.st_ru_disp
this.Control[iCurrent+11]=this.st_lu_disp
this.Control[iCurrent+12]=this.st_ru_label
this.Control[iCurrent+13]=this.st_lu_label
this.Control[iCurrent+14]=this.st_cn_label
this.Control[iCurrent+15]=this.sle_rk_entry
this.Control[iCurrent+16]=this.st_rc_disp
this.Control[iCurrent+17]=this.st_rk_label
this.Control[iCurrent+18]=this.st_rc_label
this.Control[iCurrent+19]=this.st_pv_label
this.Control[iCurrent+20]=this.st_pv_disp
this.Control[iCurrent+21]=this.mle_instruct
this.Control[iCurrent+22]=this.p_logo
this.Control[iCurrent+23]=this.gb_1
this.Control[iCurrent+24]=this.st_logo_back
end on

on w_reg_base.destroy
call super::destroy
destroy(this.cb_lm_list)
destroy(this.st_lm_disp)
destroy(this.st_lm_label)
destroy(this.dw_cn_disp)
destroy(this.st_logo_mask)
destroy(this.st_cn_disp)
destroy(this.cb_process)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_ru_disp)
destroy(this.st_lu_disp)
destroy(this.st_ru_label)
destroy(this.st_lu_label)
destroy(this.st_cn_label)
destroy(this.sle_rk_entry)
destroy(this.st_rc_disp)
destroy(this.st_rk_label)
destroy(this.st_rc_label)
destroy(this.st_pv_label)
destroy(this.st_pv_disp)
destroy(this.mle_instruct)
destroy(this.p_logo)
destroy(this.gb_1)
destroy(this.st_logo_back)
end on

event open;dw_cn_disp.object.text_val.width = 1918
end event

event close;
n_cst_LicenseManager	lnv_LicenseManager

IF lnv_LicenseManager.of_Ready ( ) = FALSE THEN
	MessageBox ( "Cancel Registration Update", "Program will close." )
	Halt Close
END IF
end event

type cb_help from w_response`cb_help within w_reg_base
integer x = 1947
integer y = 1372
end type

type cb_lm_list from commandbutton within w_reg_base
integer x = 1728
integer y = 872
integer width = 274
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "List"
end type

event clicked;wf_ListModules ( )
end event

type st_lm_disp from statictext within w_reg_base
event constructor pbm_constructor
integer x = 1330
integer y = 876
integer width = 379
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 29425663
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_lm_label from statictext within w_reg_base
integer x = 809
integer y = 884
integer width = 512
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Licensed Modules:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_cn_disp from datawindow within w_reg_base
integer x = 78
integer y = 732
integer width = 1975
integer height = 88
integer taborder = 10
boolean enabled = false
string dataobject = "d_noamp_st"
boolean border = false
end type

type st_logo_mask from statictext within w_reg_base
integer x = 87
integer y = 68
integer width = 713
integer height = 28
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type st_cn_disp from statictext within w_reg_base
boolean visible = false
integer x = 73
integer y = 732
integer width = 1929
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 29425663
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_process from commandbutton within w_reg_base
integer x = 1728
integer y = 1088
integer width = 274
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Process"
end type

event clicked;String	ls_RequestCode, &
			ls_RegistrationKey, &
			ls_Message
n_cst_LicenseManager	lnv_LicenseManager

ls_RequestCode = st_RC_Disp.Text
ls_RegistrationKey = Trim ( sle_RK_Entry.Text )

IF lnv_LicenseManager.of_ProcessRegistrationKey ( ls_RequestCode, ls_RegistrationKey ) = 1 THEN

	st_lu_disp.backcolor = 12648447
	st_ru_disp.backcolor = 12648447

	ii_FailedCodes = 0
	wf_SetValues ( )
	
//	mle_Instruct.Text = "The registration key has been accepted!  If the license information "+&
//		"displayed below is correct, press OK to save the settings and return to the Profit "+&
//		"Tools system, or press Generate to perform another update."
	
	cb_Ok.Enabled = TRUE
//	cb_Ok.SetFocus()

ELSE

	ii_FailedKeys ++
	
	ls_Message = "The registration key you have entered is invalid."
	if ii_FailedKeys < 3 then ls_Message += "  Please verify your entry and retry."
	
	choose case ii_FailedKeys
	case 2
		ls_Message += "~n~n(PLEASE NOTE: For security reasons, another failed attempt will cause "
		if ii_FailedCodes > 0 then
			ls_Message += "the program to close.)"
		else
			ls_Message += "a new request code to be generated.)"
		end if
	case 3
		if ii_FailedCodes > 0 then
			ls_Message += "  The program will close."
		else
			ls_Message += "  A new request code will be generated."
		end if
	end choose
	
	messagebox("Process Registration", ls_Message, exclamation!)
	
	if ii_FailedKeys = 3 then
		if ii_FailedCodes > 0 then
			halt close
		else
			ii_FailedCodes = 1
			wf_SetValues ( )
		end if
	else
		sle_rk_entry.setfocus()
	end if

END IF
end event

type cb_cancel from commandbutton within w_reg_base
integer x = 1065
integer y = 1296
integer width = 274
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;Close ( Parent )
end event

event losefocus;this.default = false
end event

event getfocus;this.default = true
end event

type cb_ok from commandbutton within w_reg_base
integer x = 741
integer y = 1296
integer width = 274
integer height = 88
integer taborder = 50
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "OK"
end type

event getfocus;this.default = true
end event

event losefocus;this.default = false
end event

event clicked;wf_Update ( )
end event

type st_ru_disp from statictext within w_reg_base
integer x = 549
integer y = 1092
integer width = 288
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 29425663
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_lu_disp from statictext within w_reg_base
integer x = 549
integer y = 984
integer width = 229
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 29425663
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_ru_label from statictext within w_reg_base
integer x = 87
integer y = 1096
integer width = 453
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Registered Until:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_lu_label from statictext within w_reg_base
integer x = 64
integer y = 988
integer width = 475
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Lic. Connections:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_cn_label from statictext within w_reg_base
integer x = 64
integer y = 652
integer width = 1061
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Program Licensed to (Company Name):"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_rk_entry from singlelineedit within w_reg_base
integer x = 1330
integer y = 1092
integer width = 379
integer height = 76
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

event getfocus;this.selecttext(1, len(this.text))
cb_process.default = true
end event

type st_rc_disp from statictext within w_reg_base
integer x = 1330
integer y = 984
integer width = 379
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 29425663
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_rk_label from statictext within w_reg_base
integer x = 850
integer y = 1096
integer width = 471
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Registration Key:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_rc_label from statictext within w_reg_base
integer x = 914
integer y = 988
integer width = 407
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Request Code:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_pv_label from statictext within w_reg_base
integer x = 64
integer y = 880
integer width = 475
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Program Version:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_pv_disp from statictext within w_reg_base
integer x = 549
integer y = 876
integer width = 229
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 29425663
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type mle_instruct from multilineedit within w_reg_base
event lbuttondown pbm_lbuttondown
integer x = 73
integer y = 316
integer width = 1929
integer height = 280
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Arrow!"
long backcolor = 16777215
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

event lbuttondown;DragObject	ldo_Current

ldo_Current = GetFocus ( )

IF IsValid ( ldo_Current ) THEN
	ldo_Current.Post SetFocus ( )
END IF
end event

type p_logo from picture within w_reg_base
integer x = 87
integer y = 68
integer width = 713
integer height = 184
boolean originalsize = true
string picturename = "ptftw6.wmf"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_reg_base
integer x = 73
integer y = 1196
integer width = 1929
integer height = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_logo_back from statictext within w_reg_base
integer x = 73
integer y = 56
integer width = 745
integer height = 204
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

