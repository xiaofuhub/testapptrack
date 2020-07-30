$PBExportHeader$w_missingimagedisplay.srw
forward
global type w_missingimagedisplay from w_popup
end type
type dw_view from u_dw within w_missingimagedisplay
end type
end forward

global type w_missingimagedisplay from w_popup
int Width=3159
int Height=1968
dw_view dw_view
end type
global w_missingimagedisplay w_missingimagedisplay

type variables
Protected:
n_cst_msg	inv_msg

end variables

event open;call super::open;THIS.ib_DisableCloseQuery = TRUE

s_parm	lstr_Parm
blob	lblb_return
blob		lblb_dw


datawindow	lds_Temp


inv_msg = message.powerobjectparm




If inv_msg.of_Get_Count() > 0 THEN
	inv_msg.of_Get_Parm("DATAOBJECT",lstr_Parm)
	//lds_Temp = lstr_parm.ia_Value
	lblb_dw = lstr_parm.ia_Value
	dw_view.SetFullState(lblb_dw)
END IF




end event

on w_missingimagedisplay.create
int iCurrent
call super::create
this.dw_view=create dw_view
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_view
end on

on w_missingimagedisplay.destroy
call super::destroy
destroy(this.dw_view)
end on

type dw_view from u_dw within w_missingimagedisplay
int X=27
int Y=40
int Width=3063
int Height=1796
int TabOrder=10
boolean BringToTop=true
boolean HScrollBar=true
end type

