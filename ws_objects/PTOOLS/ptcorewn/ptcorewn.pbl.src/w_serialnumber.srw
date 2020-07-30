$PBExportHeader$w_serialnumber.srw
forward
global type w_serialnumber from w_response
end type
type sle_key from singlelineedit within w_serialnumber
end type
type st_1 from statictext within w_serialnumber
end type
type st_2 from statictext within w_serialnumber
end type
type cb_ok from u_cbok within w_serialnumber
end type
type cb_cancel from u_cbcancel within w_serialnumber
end type
end forward

global type w_serialnumber from w_response
int X=704
int Y=516
int Width=1138
int Height=528
boolean TitleBar=true
string Title="Profit Tools CD Key"
sle_key sle_key
st_1 st_1
st_2 st_2
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_serialnumber w_serialnumber

type variables
n_cst_ModLicenses		inv_ModLicenses
end variables

on w_serialnumber.create
int iCurrent
call super::create
this.sle_key=create sle_key
this.st_1=create st_1
this.st_2=create st_2
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_key
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_cancel
end on

on w_serialnumber.destroy
call super::destroy
destroy(this.sle_key)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event open;call super::open;inv_modLicenses = CREATE n_cst_ModLicenses

This.Title = "Version " + gnv_App.of_GetVersion ( ) + " CD Key"

ib_disableCloseQuery = TRUE
end event

event pfc_default;String	ls_Result
String	lsa_Results[]
Int		li_Group


ls_Result = Trim ( sle_Key.text )

IF inv_modLicenses.of_GetCountsFromKey ( ls_Result , lsa_Results ) = 1 THEN // 1 = valid code

	li_group = Integer (lsa_Results[1])

	IF inv_modLicenses.of_UpdateTable ( li_Group , lsa_Results[2] ) = 1 THEN
		cb_OK.enabled = FALSE
		MessageBox( "CD Key Accepted" , "Thank you. Your CD key has been accepted." )
		CloseWithReturn ( THIS , 1 )
	END IF

ELSE
	MessageBox( "Process CD Key" , "The CD Key you entered is not valid. Please be sure you entered it correctly." )
	sle_Key.SetFocus ( )
	
END IF
	
	

end event

event close;call super::close;DESTROY inv_ModLicenses
end event

event pfc_cancel;call super::pfc_cancel;//Extending Ancestor
CloseWithReturn ( This, 0 )
end event

type sle_key from singlelineedit within w_serialnumber
int X=41
int Y=172
int Width=1047
int Height=92
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_serialnumber
int X=41
int Y=24
int Width=1061
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Please enter your CD key below,"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_serialnumber
int X=41
int Y=84
int Width=955
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="including any dashes."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from u_cbok within w_serialnumber
int X=325
int Y=312
int TabOrder=30
boolean BringToTop=true
end type

type cb_cancel from u_cbcancel within w_serialnumber
int X=599
int Y=312
int TabOrder=20
boolean BringToTop=true
end type

