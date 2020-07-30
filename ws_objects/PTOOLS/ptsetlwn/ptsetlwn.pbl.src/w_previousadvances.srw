$PBExportHeader$w_previousadvances.srw
forward
global type w_previousadvances from w_response
end type
type cb_1 from u_cbok within w_previousadvances
end type
type dw_2 from u_dw_amountowedlist within w_previousadvances
end type
end forward

global type w_previousadvances from w_response
int Width=2592
int Height=840
boolean TitleBar=true
string Title="Today's Previous Advances - ( Read Only )"
cb_1 cb_1
dw_2 dw_2
end type
global w_previousadvances w_previousadvances

on w_previousadvances.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_previousadvances.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_2)
end on

event pfc_default;Close ( THIS )
end event

event open;call super::open;n_Cst_Msg	lnv_Msg	
S_PArm 		lstr_Parm
ib_DisableCloseQuery = TRUE


Blob lblb_State
Any la_State

lnv_Msg = Message.powerObjectParm
IF lnv_Msg.of_Get_Parm ( "STATE" , lstr_Parm ) <> 0 THEN
	lblb_State = lstr_Parm.ia_Value 
END IF



dw_2.SetFullState ( lblb_State )

n_cst_Presentation_AmountOwed lnv_Presentation 

lnv_Presentation.of_SetPresentation ( dw_2  )
dw_2.setUiLink ( false )

//dw_1.SetColumn ( "Amountowed_amount" )
//dw_1.SetFocus ( )
end event

type cb_1 from u_cbok within w_previousadvances
int X=1170
int Y=604
int Width=274
int TabOrder=20
boolean BringToTop=true
string Text="Close"
end type

type dw_2 from u_dw_amountowedlist within w_previousadvances
int X=18
int Y=20
int Width=2528
int Height=548
int TabOrder=10
boolean BringToTop=true
end type

