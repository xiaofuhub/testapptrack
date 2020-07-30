$PBExportHeader$w_eventdetail.srw
$PBExportComments$CAUTION This window is not used from w_ship
forward
global type w_eventdetail from w_popup
end type
type dw_eventdetails from u_dw_eventdetail within w_eventdetail
end type
end forward

global type w_eventdetail from w_popup
int X=946
int Y=560
int Width=2793
int Height=908
boolean TitleBar=true
string Title="Event Detail"
long BackColor=12632256
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_eventdetails dw_eventdetails
end type
global w_eventdetail w_eventdetail

type variables
n_cst_msg	inv_Msg

end variables

forward prototypes
public function integer wf_showevent (long al_eventid)
end prototypes

public function integer wf_showevent (long al_eventid);Long	ll_Row

ll_Row = dw_eventdetails.Find ( "de_id = " + String ( al_EventID ) , 1, dw_eventdetails.RowCount ( )) 

IF ll_Row > 0 THEN
	dw_eventdetails.ScrollToRow ( ll_Row ) 
END IF

RETURN ll_Row

end function

on w_eventdetail.create
int iCurrent
call super::create
this.dw_eventdetails=create dw_eventdetails
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_eventdetails
end on

on w_eventdetail.destroy
call super::destroy
destroy(this.dw_eventdetails)
end on

event open;call super::open;S_Parm	lstr_Parm

inv_Msg = Message.PowerobjectParm


IF inv_Msg.of_Get_Parm ( "SOURCE" , lstr_Parm ) <> 0 THEN
	dw_eventdetails.of_SetEventList ( lstr_Parm.ia_Value )
	
	lstr_Parm.ia_Value.Dynamic ShareData ( dw_eventdetails )
END IF

IF inv_Msg.of_Get_Parm ( "ROW" , lstr_Parm ) <> 0 THEN
	dw_eventdetails.ScrollToRow ( lstr_Parm.ia_Value )
END IF


ib_DisableCloseQuery = TRUE
end event

type dw_eventdetails from u_dw_eventdetail within w_eventdetail
int X=0
int Y=12
int Width=2766
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event losefocus;//Close ( Parent ) 
end event

event ue_rightclickondriver;call super::ue_rightclickondriver;IF AncestorReturnValue = 1 THEN
	Close ( Parent ) 
END IF

RETURN AncestorReturnValue
end event

event ue_rightclickonequipment;call super::ue_rightclickonequipment;IF AncestorReturnValue = 1 THEN
	Close ( Parent ) 
END IF

RETURN AncestorReturnValue
end event

