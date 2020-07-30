$PBExportHeader$w_documenttransferqueue.srw
forward
global type w_documenttransferqueue from w_response
end type
type dw_1 from u_dw_documenttransferqueue within w_documenttransferqueue
end type
type cb_1 from commandbutton within w_documenttransferqueue
end type
end forward

global type w_documenttransferqueue from w_response
integer width = 3438
integer height = 1972
string title = "Pending Transfers for selected shipment"
long backcolor = 12632256
dw_1 dw_1
cb_1 cb_1
end type
global w_documenttransferqueue w_documenttransferqueue

forward prototypes
public subroutine wf_formatforcompany ()
end prototypes

public subroutine wf_formatforcompany ();THIS.Title = "Pending Transfers for selected company"
THIS.Width = 2950
cb_1.x = 1262

end subroutine

on w_documenttransferqueue.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_documenttransferqueue.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;call super::open;/// this window is formated for shipment display by default

n_Cst_msg	lnv_msg
s_Parm		lstr_Parm
Long			ll_ID
lnv_msg = Message.PowerobjectParm

THIS.of_SetResize( TRUE )
inv_REsize.of_Register( dw_1 , inv_Resize.scalerightbottom )
inv_REsize.of_Register( cb_1 , inv_Resize.fixedbottom )

IF gnv_App.of_Getrestrictedview( ) THEN

	THIS.Width -= 500
	THIS.Height -= 200
	cb_1.x -= 250
END IF
THIS.of_SetBase ( TRUE )
inv_Base.of_Center( )



IF lnv_Msg.of_Get_Parm ( "SHIPMENTID" , lstr_Parm ) > 0 THEN
	ll_ID = lstr_Parm.ia_Value
	dw_1.of_showtransfersforshipment( ll_ID )
END IF

IF lnv_Msg.of_Get_Parm ( "COMPANYID" , lstr_Parm ) > 0 THEN
	ll_ID = lstr_Parm.ia_Value
	dw_1.of_showtransfersforCompany( ll_ID )
	THIS.wf_formatforcompany( )
END IF



end event

type cb_help from w_response`cb_help within w_documenttransferqueue
end type

type dw_1 from u_dw_documenttransferqueue within w_documenttransferqueue
integer x = 32
integer y = 28
integer width = 3346
integer height = 1660
integer taborder = 10
boolean bringtotop = true
end type

type cb_1 from commandbutton within w_documenttransferqueue
integer x = 1504
integer y = 1732
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
boolean default = true
end type

event clicked;Parent.event pfc_close( )
end event

