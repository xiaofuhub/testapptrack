$PBExportHeader$w_picklist.srw
forward
global type w_picklist from w_response
end type
type dw_1 from u_dw within w_picklist
end type
type cb_1 from commandbutton within w_picklist
end type
type cb_2 from commandbutton within w_picklist
end type
end forward

global type w_picklist from w_response
integer width = 1481
integer height = 748
long backcolor = 12632256
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_picklist w_picklist

type variables
n_cst_Msg	inv_Msg

end variables

forward prototypes
public subroutine wf_returnselection ()
end prototypes

public subroutine wf_returnselection ();
Long	ll_Row
Long	ll_RowID 
ll_Row = dw_1.GetRow ( )
IF ll_Row > 0 THEN
	
	ll_RowID = dw_1.Getrowidfromrow( ll_Row )
	
	CloseWithReturn ( THIS , ll_RowID  )
ELSE
	MessageBox ( "Selection" , "Please make a selection" )
END IF
end subroutine

event pfc_preopen;call super::pfc_preopen;

THIS.of_Setbase ( True ) 
inv_base.of_Center( )
end event

event pfc_postopen;call super::pfc_postopen;s_parm	lstr_parm

IF inv_msg.of_get_parm( 'FULLSTATE',lstr_parm ) > 0 THEN
	Blob	lb_State
	lb_State = lstr_parm.ia_Value
	dw_1.SetFullState( lb_State )
	
END IF


 IF inv_msg.of_get_parm( 'TITLE',lstr_parm ) > 0 THEN
	THIS.Title = lstr_parm.ia_Value
END IF

end event

on w_picklist.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_picklist.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type cb_help from w_response`cb_help within w_picklist
end type

type dw_1 from u_dw within w_picklist
integer x = 37
integer y = 28
integer width = 1403
integer height = 452
integer taborder = 10
boolean bringtotop = true
string title = "none"
end type

event doubleclicked;Parent.wf_returnselection( )

end event

event constructor;inv_msg = Message.powerobjectparm
THIS.of_Setrowselect( TRUE )

end event

type cb_1 from commandbutton within w_picklist
integer x = 37
integer y = 512
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
boolean default = true
end type

event clicked;Parent.wf_Returnselection( )
end event

type cb_2 from commandbutton within w_picklist
integer x = 489
integer y = 512
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;Close ( PARENT ) 
end event

