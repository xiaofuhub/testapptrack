$PBExportHeader$w_activealertcount.srw
forward
global type w_activealertcount from w_response
end type
type uo_details from u_cst_activeemployeealerts within w_activealertcount
end type
type cb_1 from commandbutton within w_activealertcount
end type
end forward

global type w_activealertcount from w_response
integer width = 2537
integer height = 1936
string title = "Active alert details"
long backcolor = 12632256
boolean center = true
uo_details uo_details
cb_1 cb_1
end type
global w_activealertcount w_activealertcount

on w_activealertcount.create
int iCurrent
call super::create
this.uo_details=create uo_details
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_details
this.Control[iCurrent+2]=this.cb_1
end on

on w_activealertcount.destroy
call super::destroy
destroy(this.uo_details)
destroy(this.cb_1)
end on

event open;call super::open;Long	ll_MsgID

ll_MsgID = Message.Doubleparm

IF ll_MsgID > 0 THEN
	uo_details.of_retrieve( ll_MsgID )
END IF

n_cst_Privileges	lnv_Privs
uo_details.of_allowmodifications( lnv_Privs.of_hassysadminrights( ) ) 
end event

event pfc_save;call super::pfc_save;IF ancestorReturnValue = 1 THEN
	Commit;
END IF

RETURN AncestorReturnValue
end event

type cb_help from w_response`cb_help within w_activealertcount
end type

type uo_details from u_cst_activeemployeealerts within w_activealertcount
integer height = 1696
integer taborder = 20
boolean bringtotop = true
end type

on uo_details.destroy
call u_cst_activeemployeealerts::destroy
end on

type cb_1 from commandbutton within w_activealertcount
integer x = 1056
integer y = 1712
integer width = 402
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
boolean cancel = true
boolean default = true
end type

event clicked;Close (Parent )
end event

