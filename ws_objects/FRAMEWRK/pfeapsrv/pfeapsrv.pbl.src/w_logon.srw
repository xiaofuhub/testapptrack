$PBExportHeader$w_logon.srw
$PBExportComments$Extension Logon window
forward
global type w_logon from pfc_w_logon
end type
type st_instruct from statictext within w_logon
end type
type st_copyright from statictext within w_logon
end type
type st_logomask from statictext within w_logon
end type
type st_logoback from statictext within w_logon
end type
end forward

global type w_logon from pfc_w_logon
integer width = 1184
integer height = 888
long backcolor = 79741120
st_instruct st_instruct
st_copyright st_copyright
st_logomask st_logomask
st_logoback st_logoback
end type
global w_logon w_logon

on w_logon.create
int iCurrent
call super::create
this.st_instruct=create st_instruct
this.st_copyright=create st_copyright
this.st_logomask=create st_logomask
this.st_logoback=create st_logoback
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_instruct
this.Control[iCurrent+2]=this.st_copyright
this.Control[iCurrent+3]=this.st_logomask
this.Control[iCurrent+4]=this.st_logoback
end on

on w_logon.destroy
call super::destroy
destroy(this.st_instruct)
destroy(this.st_copyright)
destroy(this.st_logomask)
destroy(this.st_logoback)
end on

event pfc_default;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_default  OVERRIDE OF ANCESTOR
//
//	Arguments:  none
//
//	Returns:  none
//
//	Description:  Peform logon
//
//////////////////////////////////////////////////////////////////////////////
//	
//	The purpose of the override is to suppress the messagebox that appears
//	for an incorrect password.  pfc_Logon in the appmanager is already handling
//	error messages, so this is redundant.  Also, we add support for setting
//	focus to the UserId field, based on a -2 return code from pfc_Logon
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc

//////////////////////////////////////////////////////////////////////////////
// Check required fields
//////////////////////////////////////////////////////////////////////////////
if Len (sle_userid.text) = 0 then
	of_MessageBox ("pfc_logon_enterid", inv_logonattrib.is_appname, &
		"Please enter a User ID to logon.", exclamation!, OK!, 1)
	sle_userid.SetFocus()
	return
end if
if Len (sle_password.text) = 0 then
	of_MessageBox ("pfc_logon_enterpassword", inv_logonattrib.is_appname, &
		"Please enter a password to logon.", exclamation!, OK!, 1)
	sle_password.SetFocus()
	return
end if
if Isnull(inv_logonattrib.ipo_source) or Not IsValid (inv_logonattrib.ipo_source) then
	this.event pfc_cancel()
	return
End If

//////////////////////////////////////////////////////////////////////////////
// Attempt to logon
//////////////////////////////////////////////////////////////////////////////
ii_logonattempts --
li_rc = inv_logonattrib.ipo_source.dynamic event pfc_logon &
	(sle_userid.text, sle_password.text)
if IsNull (li_rc) then 
	this.event pfc_cancel()
	return
ElseIf li_rc <= 0 Then
	If ii_logonattempts > 0 Then
		// There are still have more attempts for a succesful login.


//		**BEGIN OVERRIDE**
//		of_MessageBox ("pfc_logon_incorrectpassword", "Login", &
//			"The password is incorrect.", StopSign!, Ok!, 1)
		IF li_RC = -2 THEN
			sle_UserId.SetFocus ( )
		ELSE
			sle_Password.SetFocus()
		END IF
//		**END OVVERRIDE

		Return
	Else
		// Failure return code
		inv_logonattrib.ii_rc = -1	
		CloseWithReturn (this, inv_logonattrib)
	End If
Else
	// Successful return code
	inv_logonattrib.ii_rc = 1
	inv_logonattrib.is_userid = sle_userid.text
	inv_logonattrib.is_password = sle_password.text	
	CloseWithReturn (this, inv_logonattrib)	
End if

Return
end event

event open;call super::open;THIS.of_setbase( TRUE )
inv_Base.of_center( )
IF THIS.y - THIS.Height / 2 > 0 THEN
	THIS.y =  THIS.y - THIS.Height / 2
END IF


IF p_Logo.Visible THEN

	//Center the logo against the background

	p_Logo.X = st_LogoBack.X + ( st_LogoBack.Width - p_Logo.Width ) / 2

END IF


IF Len ( inv_LogonAttrib.is_AppName ) > 0 THEN
	This.Title = inv_LogonAttrib.is_AppName + " Logon"
END IF
end event

type cb_help from pfc_w_logon`cb_help within w_logon
end type

type p_logo from pfc_w_logon`p_logo within w_logon
integer y = 28
end type

type st_help from pfc_w_logon`st_help within w_logon
boolean visible = false
end type

type cb_ok from pfc_w_logon`cb_ok within w_logon
integer x = 581
integer y = 348
integer width = 256
end type

type cb_cancel from pfc_w_logon`cb_cancel within w_logon
integer x = 873
integer y = 348
integer width = 256
end type

type sle_userid from pfc_w_logon`sle_userid within w_logon
integer x = 347
integer y = 480
integer width = 777
string text = "ptadmin"
end type

type sle_password from pfc_w_logon`sle_password within w_logon
integer x = 347
integer y = 612
integer width = 777
string text = "trucks"
end type

type st_2 from pfc_w_logon`st_2 within w_logon
integer x = 64
integer y = 488
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
end type

type st_3 from pfc_w_logon`st_3 within w_logon
integer x = 14
integer y = 620
integer width = 315
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
end type

type st_instruct from statictext within w_logon
integer x = 105
integer y = 352
integer width = 448
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 80269524
boolean enabled = false
string text = "Please log on."
boolean focusrectangle = false
end type

type st_copyright from statictext within w_logon
integer x = 18
integer y = 244
integer width = 1106
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 80269524
boolean enabled = false
string text = "CopyRight"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;This.Text = gnv_App.of_GetCopyRight ( )
end event

type st_logomask from statictext within w_logon
integer x = 215
integer y = 28
integer width = 722
integer height = 28
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type st_logoback from statictext within w_logon
integer x = 18
integer y = 20
integer width = 1106
integer height = 204
integer textsize = -18
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

