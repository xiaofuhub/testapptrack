$PBExportHeader$w_ptadminlogon.srw
forward
global type w_ptadminlogon from w_response
end type
type st_1 from statictext within w_ptadminlogon
end type
type sle_password from singlelineedit within w_ptadminlogon
end type
type cb_1 from u_cbok within w_ptadminlogon
end type
type cb_2 from u_cbcancel within w_ptadminlogon
end type
end forward

global type w_ptadminlogon from w_response
int Width=1317
int Height=492
boolean TitleBar=true
string Title="Upgrade Authorization"
long BackColor=80269524
st_1 st_1
sle_password sle_password
cb_1 cb_1
cb_2 cb_2
end type
global w_ptadminlogon w_ptadminlogon

forward prototypes
public function integer wf_approvelogon (string as_Password)
end prototypes

public function integer wf_approvelogon (string as_Password);/* 
	This method returns
			1 	if password suplied matches ptadmin pw
			-1 on error
			0  if pw doesn't match
*/



String	ls_PW
String	ls_DbPw
Int		li_Return = -1

ls_Pw = as_Password

IF IsNull ( ls_Pw ) OR Len ( ls_Pw ) = 0 THEN
	RETURN li_Return  /////// early return
END IF


  SELECT "employees"."em_password"  
    INTO :ls_dbpw  
    FROM "employees"  
   WHERE "employees"."em_id" = 10000;
	
	Commit;
	
IF ls_dbpw = ls_pw THEN
	li_Return = 1
ELSE
	li_Return = 0
END IF

RETURN li_Return



end function

on w_ptadminlogon.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_password=create sle_password
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_password
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on w_ptadminlogon.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_password)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event pfc_default;IF THIS.wf_approveLogon ( sle_password.Text ) = 1 THEN
	CloseWithReturn ( THIS , 1 )
ELSE
	MessageBox ( "Password Approval" , "The password supplied is not valid." )
	sle_password.SelectText ( 1 , Len ( sle_password.Text ) )
	sle_password.SetFocus ( )
END IF
end event

event pfc_cancel;call super::pfc_cancel;CloseWithReturn ( THIS , 0 )
end event

event open;call super::open;THIS.of_SetBase ( TRUE ) 
IF isValid ( inv_Base ) THEN
	inv_Base.of_Center ( )
END IF
end event

type st_1 from statictext within w_ptadminlogon
int X=37
int Y=40
int Width=1234
int Height=208
boolean Enabled=false
boolean BringToTop=true
string Text="During this upgrade process, changes may need to be made that require PTADMIN privileges. Please enter the PTADMIN password below."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_password from singlelineedit within w_ptadminlogon
int X=37
int Y=268
int Width=663
int Height=80
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from u_cbok within w_ptadminlogon
int X=750
int Y=260
int TabOrder=20
boolean BringToTop=true
end type

type cb_2 from u_cbcancel within w_ptadminlogon
int X=1029
int Y=260
int TabOrder=30
boolean BringToTop=true
end type

