$PBExportHeader$w_acct_logon.srw
forward
global type w_acct_logon from Window
end type
type mle_instruct from multilineedit within w_acct_logon
end type
type st_instruct from statictext within w_acct_logon
end type
type cb_cancel from commandbutton within w_acct_logon
end type
type cb_nobatch from commandbutton within w_acct_logon
end type
type cb_ok from commandbutton within w_acct_logon
end type
type st_5 from statictext within w_acct_logon
end type
type st_4 from statictext within w_acct_logon
end type
type st_3 from statictext within w_acct_logon
end type
type sle_pwd from singlelineedit within w_acct_logon
end type
type st_uid from statictext within w_acct_logon
end type
type st_company from statictext within w_acct_logon
end type
end forward

global type w_acct_logon from Window
int X=705
int Y=665
int Width=2263
int Height=525
boolean TitleBar=true
string Title="Create AR Batch"
long BackColor=12632256
WindowType WindowType=response!
mle_instruct mle_instruct
st_instruct st_instruct
cb_cancel cb_cancel
cb_nobatch cb_nobatch
cb_ok cb_ok
st_5 st_5
st_4 st_4
st_3 st_3
sle_pwd sle_pwd
st_uid st_uid
st_company st_company
end type
global w_acct_logon w_acct_logon

type variables
protected:
n_cst_acctlink inv_cst_acctlink
end variables

on w_acct_logon.create
this.mle_instruct=create mle_instruct
this.st_instruct=create st_instruct
this.cb_cancel=create cb_cancel
this.cb_nobatch=create cb_nobatch
this.cb_ok=create cb_ok
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.sle_pwd=create sle_pwd
this.st_uid=create st_uid
this.st_company=create st_company
this.Control[]={ this.mle_instruct,&
this.st_instruct,&
this.cb_cancel,&
this.cb_nobatch,&
this.cb_ok,&
this.st_5,&
this.st_4,&
this.st_3,&
this.sle_pwd,&
this.st_uid,&
this.st_company}
end on

on w_acct_logon.destroy
destroy(this.mle_instruct)
destroy(this.st_instruct)
destroy(this.cb_cancel)
destroy(this.cb_nobatch)
destroy(this.cb_ok)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_pwd)
destroy(this.st_uid)
destroy(this.st_company)
end on

event open;n_cst_msg lnv_cst_msg
s_parm lstr_parm
string ls_request, ls_message

lnv_cst_msg = message.powerobjectparm

if lnv_cst_msg.of_get_parm("REQUEST", lstr_parm) > 0 then
	ls_request = lstr_parm.ia_value
end if

choose case ls_request
case "MESSAGE!"
	if lnv_cst_msg.of_get_parm("MESSAGE", lstr_parm) > 0 then
		ls_message = lstr_parm.ia_value
		mle_instruct.text = ls_message
		mle_instruct.visible = true
		sle_pwd.visible = false
	else
		goto failure
	end if
case "LOGON!"
	if lnv_cst_msg.of_get_parm("ACCTLINK", lstr_parm) > 0 then &
		inv_cst_acctlink = lstr_parm.ia_value else goto failure
	if lnv_cst_msg.of_get_parm("COMPANY", lstr_parm) > 0 then &
		st_company.text = lstr_parm.ia_value //else goto failure
	if lnv_cst_msg.of_get_parm("UID", lstr_parm) > 0 then &
		st_uid.text = lstr_parm.ia_value //else goto failure
	if lnv_cst_msg.of_get_parm("INSTRUCT", lstr_parm) > 0 then &
		st_instruct.text = lstr_parm.ia_value
	sle_pwd.setfocus()
case else
	goto failure
end choose

return

failure:
messagebox(this.title, "Could not process request.  Request cancelled.", exclamation!)
closewithreturn(this, -1)
end event

type mle_instruct from multilineedit within w_acct_logon
event lbuttondown pbm_lbuttondown
int X=65
int Y=37
int Width=1537
int Height=345
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean DisplayOnly=true
string Pointer="Arrow!"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event lbuttondown;DragObject	ldo_Current

ldo_Current = GetFocus ( )

IF IsValid ( ldo_Current ) THEN
	ldo_Current.Post SetFocus ( )
END IF
end event

type st_instruct from statictext within w_acct_logon
int X=78
int Y=61
int Width=1527
int Height=77
boolean Enabled=false
string Text="Please log on to the accounting package."
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_acct_logon
int X=1710
int Y=281
int Width=453
int Height=89
int TabOrder=40
string Text="Cancel Billing"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn(parent, -3)
end event

type cb_nobatch from commandbutton within w_acct_logon
int X=1710
int Y=165
int Width=453
int Height=89
int TabOrder=30
string Text="No AR Batch"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn(parent, -2)
end event

type cb_ok from commandbutton within w_acct_logon
int X=1710
int Y=49
int Width=453
int Height=89
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if mle_instruct.visible then
	closewithreturn(parent, 1)
else
	if inv_cst_acctlink.of_logon(st_company.text, st_uid.text, sle_pwd.text) = 1 then
		closewithreturn(parent, 1)
	else
		sle_pwd.setfocus()
	end if
end if
end event

type st_5 from statictext within w_acct_logon
int X=823
int Y=289
int Width=311
int Height=77
boolean Enabled=false
string Text="Password:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_acct_logon
int X=33
int Y=285
int Width=307
int Height=77
boolean Enabled=false
string Text="User ID:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_acct_logon
int X=33
int Y=173
int Width=307
int Height=77
boolean Enabled=false
string Text="Company:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_pwd from singlelineedit within w_acct_logon
int X=1139
int Y=285
int Width=453
int Height=77
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

type st_uid from statictext within w_acct_logon
int X=343
int Y=281
int Width=453
int Height=77
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=29425663
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_company from statictext within w_acct_logon
int X=343
int Y=173
int Width=1253
int Height=77
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=29425663
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

