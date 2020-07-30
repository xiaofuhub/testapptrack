$PBExportHeader$w_lanesetup.srw
forward
global type w_lanesetup from w_response
end type
type dw_lanes from u_dw_carrierlanesetup within w_lanesetup
end type
type cb_1 from u_cbok within w_lanesetup
end type
type cb_2 from u_cbcancel within w_lanesetup
end type
type cb_add from commandbutton within w_lanesetup
end type
end forward

global type w_lanesetup from w_response
int Width=2482
int Height=1024
boolean TitleBar=true
string Title="Carrier Lane Setup"
long BackColor=12632256
dw_lanes dw_lanes
cb_1 cb_1
cb_2 cb_2
cb_add cb_add
end type
global w_lanesetup w_lanesetup

forward prototypes
public function integer wf_settitle ()
end prototypes

public function integer wf_settitle ();String	ls_Title
String	ls_Name 
n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_Cst_beo_Company 
lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID ( dw_lanes.of_GetCarrierID ( ) ) 

ls_Title = "Carrier Lane Setup"
ls_Name = lnv_Company.of_getName ( )

IF Not isNull ( ls_Name ) THEN
	ls_title += " For " + ls_Name 
END IF
	
THIS.title = ls_Title

DESTROY ( lnv_Company )

RETURN 1
end function

on w_lanesetup.create
int iCurrent
call super::create
this.dw_lanes=create dw_lanes
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_add=create cb_add
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lanes
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_add
end on

on w_lanesetup.destroy
call super::destroy
destroy(this.dw_lanes)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_add)
end on

event open;call super::open;n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

lnv_Msg = Message.PowerobjectParm

THIS.of_Setbase ( TRUE ) 
inv_Base.of_Center ( )

IF lnv_Msg.of_Get_Parm ( "CARRIERID" , lstr_Parm ) <> 0 THEN
	dw_Lanes.of_SetCarrierID ( Long (lstr_Parm.ia_Value) )
END IF

THIS.wf_Settitle ( )

IF dw_Lanes.of_Retrieve ( ) = -1 THEN
	MessageBox ( "Lane Setup" , "Could not retrieve lanes." )
END IF

cb_add.SetFocus ( )
end event

event pfc_cancel;call super::pfc_cancel;ib_DisableCloseQuery =  TRUE 
Close ( THIS )
end event

event pfc_default;Close ( THIS )
end event

event pfc_preclose;call super::pfc_preclose;dw_lanes.Event ue_CleanUp ( )
RETURN AncestorReturnValue
end event

type dw_lanes from u_dw_carrierlanesetup within w_lanesetup
int X=37
int Y=64
int Width=2126
int Height=816
int TabOrder=10
boolean BringToTop=true
end type

type cb_1 from u_cbok within w_lanesetup
int X=2190
int Y=248
int TabOrder=30
boolean BringToTop=true
FontCharSet FontCharSet=Ansi!
end type

type cb_2 from u_cbcancel within w_lanesetup
int X=2190
int Y=360
int TabOrder=40
boolean BringToTop=true
FontCharSet FontCharSet=Ansi!
end type

type cb_add from commandbutton within w_lanesetup
int X=2190
int Y=72
int Width=233
int Height=88
int TabOrder=20
boolean BringToTop=true
string Text="Add"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_lanes.Event pfc_AddRow ( ) 
end event

