$PBExportHeader$w_intermodaladmin.srw
forward
global type w_intermodaladmin from w_response
end type
type dw_admin from u_dw_intermodaladmin within w_intermodaladmin
end type
type cb_1 from u_cbok within w_intermodaladmin
end type
end forward

global type w_intermodaladmin from w_response
int X=1234
int Y=544
int Width=891
int Height=1396
boolean TitleBar=true
string Title="Shipment Changes"
long BackColor=12632256
dw_admin dw_admin
cb_1 cb_1
end type
global w_intermodaladmin w_intermodaladmin

type variables
PRIVATE:
n_cst_beo_Shipment	inv_Shipment
n_cst_bso_Dispatch	inv_Dispatch
end variables

forward prototypes
private function integer wf_setdispatch (readonly n_cst_bso_dispatch anv_dispatch)
private function integer wf_setshipment (readonly n_cst_beo_Shipment anv_Shipment)
private function long wf_getxpos ()
private function long wf_getypos ()
end prototypes

private function integer wf_setdispatch (readonly n_cst_bso_dispatch anv_dispatch);Int	li_Return = 1

inv_dispatch = anv_Dispatch

IF isValid ( inv_Dispatch ) THEN
	dw_admin.of_ShareData ( inv_Dispatch.of_GetShipmentCache ( ) )
ELSE
	li_Return = -1
END IF

RETURN li_Return 

	
end function

private function integer wf_setshipment (readonly n_cst_beo_Shipment anv_Shipment);Int	li_Return

inv_shipment = anv_shipment

IF isValid ( inv_shipment ) THEN
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return 

end function

private function long wf_getxpos ();environment l_env
GetEnvironment(l_env)
Long	ll_XPos
IF Inv_Shipment.of_IsIntermodal ( ) THEN
	If l_env.ScreenWidth	>= 1024 then 
		ll_XPos = 3543
		//ll_Y = 532
	ELSE
		ll_XPos = 1234
		//ll_Y = 544
	End If	
ELSE		
	ll_XPos = 1614
END IF



RETURN ll_XPos
end function

private function long wf_getypos ();environment l_env
GetEnvironment(l_env)
Long	ll_YPos

IF Inv_Shipment.of_IsIntermodal ( ) THEN
	If l_env.ScreenWidth	>= 1024 then 
		ll_YPos = 532
	ELSE		
		ll_YPos = 544
	End If	
ELSE		
	ll_YPos = 528			
END IF

RETURN ll_YPos
end function

event open;call super::open;Long			ll_X
Long			ll_Y
n_cst_msg	lnv_Msg
S_Parm		lstr_parm


lnv_Msg = Message.PowerobjectParm

IF lnv_Msg.of_Get_Parm ( "SHIPMENT" , lstr_Parm ) <> 0 THEN
	THIS.wf_setShipment ( lstr_Parm.ia_Value )
END IF

IF lnv_Msg.of_Get_Parm ( "DISPATCH" , lstr_Parm ) <> 0 THEN
	THIS.wf_setDispatch ( lstr_Parm.ia_Value )
END IF

ib_DisableCloseQuery = TRUE


THIS.X = THIS.wf_GetXPos ( )
THIS.Y = THIS.wf_GetYPos ( )
end event

on w_intermodaladmin.create
int iCurrent
call super::create
this.dw_admin=create dw_admin
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_admin
this.Control[iCurrent+2]=this.cb_1
end on

on w_intermodaladmin.destroy
call super::destroy
destroy(this.dw_admin)
destroy(this.cb_1)
end on

event pfc_default;//MessageBox ( String  ( THIS.x ) , This.Y  )
CLOSE ( THIS ) 
end event

type dw_admin from u_dw_intermodaladmin within w_intermodaladmin
int X=32
int Y=20
int Height=1124
int TabOrder=10
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
end type

type cb_1 from u_cbok within w_intermodaladmin
int X=311
int Y=1184
int TabOrder=20
boolean BringToTop=true
string Text="Close"
boolean Cancel=true
end type

