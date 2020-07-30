$PBExportHeader$w_companyalias.srw
forward
global type w_companyalias from w_response
end type
type dw_1 from u_dw_companyalias within w_companyalias
end type
type cb_1 from commandbutton within w_companyalias
end type
end forward

global type w_companyalias from w_response
integer x = 214
integer y = 221
integer width = 1499
integer height = 1112
string title = "Company Alias List"
long backcolor = 12632256
dw_1 dw_1
cb_1 cb_1
end type
global w_companyalias w_companyalias

event open;call super::open;n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm

IF IsValid ( Message.Powerobjectparm ) THEN
	lnv_Msg = Message.Powerobjectparm 
	
	IF lnv_Msg.of_Get_Parm ( "PTCO" , lstr_Parm ) > 0 THEN
		dw_1.of_Retrieve( lstr_Parm.ia_Value )
	END IF
END IF

THIS.of_SetBase( TRUE )
inv_Base.of_Center( )
end event

on w_companyalias.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_companyalias.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event pfc_preupdate;call super::pfc_preupdate;RETURN  dw_1.Event pfc_preupdate( ) 
end event

type cb_help from w_response`cb_help within w_companyalias
end type

type dw_1 from u_dw_companyalias within w_companyalias
integer x = 41
integer y = 24
integer width = 1394
integer height = 808
integer taborder = 10
boolean bringtotop = true
end type

type cb_1 from commandbutton within w_companyalias
integer x = 535
integer y = 872
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
string text = "&Close"
end type

event clicked;Close ( Parent )
end event

