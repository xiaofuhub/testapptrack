$PBExportHeader$w_amounttypes.srw
$PBExportComments$AmountTypes (Window from PBL map PTSetl) //@(*)[86321212|608]
forward
global type w_amounttypes from w_response
end type
type dw_amounttypelist from u_dw_amounttypelist within w_amounttypes
end type
type cb_cancel from u_cbcancel within w_amounttypes
end type
type cb_ok from u_cbok within w_amounttypes
end type
type cb_1 from commandbutton within w_amounttypes
end type
type mle_instructions from multilineedit within w_amounttypes
end type
end forward

global type w_amounttypes from w_response
integer x = 14
integer y = 304
integer width = 3611
integer height = 2020
string title = "AmountTypes"
long backcolor = 12632256
dw_amounttypelist dw_amounttypelist
cb_cancel cb_cancel
cb_ok cb_ok
cb_1 cb_1
mle_instructions mle_instructions
end type
global w_amounttypes w_amounttypes

type variables
Boolean	ib_ForceSave
Boolean	ib_Cancel

end variables

forward prototypes
public function any gettaskattribute (string as_name)
public function integer settaskattribute (string as_name, n_cst_parameters anv_parameters)
public subroutine wf_processoptions (n_cst_msg anv_msg)
end prototypes

public function any gettaskattribute (string as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null


Return la_null
//@(text)--
//begin comment by appeon 20070727
//@(-)
//any x; return x
//@(-)--
//end comment by appeon 20070727
end function

public function integer settaskattribute (string as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>

Return 1
//@(text)--
//begin comment by appeon 20070727
//@(-)
//integer x; return x
//@(-)--
//end comment by appeon 20070727
end function

public subroutine wf_processoptions (n_cst_msg anv_msg);String		lsa_ColumnList[]
Int			i
Int			li_Count
s_Parm		lstr_Parm

IF anv_Msg.of_Get_Parm ( "INSTRUCTIONS" , lstr_Parm ) <> 0 THEN
	mle_Instructions.Text = lstr_Parm.ia_Value 
	mle_Instructions.Visible = TRUE
	dw_amounttypelist.height=1432
	dw_amounttypelist.y=332
	//reset the focus indicator
	this.setredraw(false)
	dw_amounttypelist.Event ue_SetFocusIndicator ( FALSE )
	dw_amounttypelist.Event ue_SetFocusIndicator ( TRUE )
	this.setredraw(true)
END IF

IF anv_Msg.of_Get_Parm ( "HIDECOLUMNS" , lstr_Parm ) <> 0 THEN
	lsa_ColumnList = lstr_Parm.ia_Value 
	li_Count  = UpperBound ( lsa_ColumnList )
	FOR i = 1 TO li_Count
		dw_amounttypelist.Modify ( lsa_ColumnList[i] + ".width = 0" )
	NEXT
END IF

IF anv_Msg.of_Get_Parm ( "FORCESAVE" , lstr_Parm ) <> 0 THEN
	ib_forcesave = lstr_Parm.ia_Value 
	cb_cancel.Visible = NOT ib_ForceSave
	cb_1.visible = NOT ib_ForceSave 
END IF
end subroutine

on w_amounttypes.create
int iCurrent
call super::create
this.dw_amounttypelist=create dw_amounttypelist
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_1=create cb_1
this.mle_instructions=create mle_instructions
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_amounttypelist
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.mle_instructions
end on

on w_amounttypes.destroy
call super::destroy
destroy(this.dw_amounttypelist)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_1)
destroy(this.mle_instructions)
end on

event open;call super::open;//@(data)(recreate=yes)<Parameters>
//@(data)--

//@(data)(recreate=yes)<Links>
Setlinkage(TRUE)
//@(data)--

//@(data)(recreate=yes)<GenerationOptions>
of_SetResize(TRUE)
SetTransactionManagement(TRUE)
inv_txsrv.SetLoadUpdateList(TRUE)
//@(data)--

//@(text)(recreate=yes)<RetrieveNoArgs>

//@(text)--
inv_Linkage.Retrieve ( dw_AmountTypeList )

//@(text)(recreate=yes)<resizevalues>
inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (dw_amounttypelist, 'ScaleToRight')
//@(text)--

mle_Instructions.Visible = FALSE

THIS.of_SetBase ( TRUE ) 
IF isValid ( inv_Base ) THEN
	inv_Base.of_Center ( )
END IF

end event

event pfc_default;if isValid(this) then
	IF dw_amounttypelist.of_AcceptText ( ) = 1 THEN
		if this.Event pfc_Save() >= 0 then
			this.Event task_SetOutputParameters()
			n_cst_presentation_amounttype lnv_amounttype
			lnv_amounttype.of_refreshtypelist()
			Close(this)
		end if
	END IF
end if
end event

event pfc_cancel;call super::pfc_cancel;
ib_Cancel = TRUE

Close(this)
end event

event task_setinputparameters;call super::task_setinputparameters;//@(+)(recreate=opt)<ValueMaps-EditAmountTypes>
Choose Case an_navigation.GetName()
Case "AmountTypes to Exit1"
//@(data)(recreate=yes)<AmountTypes to Exit1>
//@(data)--

//@(text)(recreate=no)<AmountTypes to Exit1 User Code>

//@(text)--
End Choose
//@(+)--

return 1
end event

event closequery;call super::closequery;Long	ll_Rtn
ll_Rtn = AncestorReturnValue

IF ll_Rtn = 0 THEN
	IF ( NOT  ib_Cancel ) AND ib_ForceSave THEN
		IF dw_amounttypelist.of_AcceptText ( ) <> 1 THEN
			ll_Rtn = 1
		END IF
	END IF
END IF

RETURN ll_Rtn
	
end event

event pfc_preclose;call super::pfc_preclose;Int	li_SaveRtn
Int	li_Rtn

li_Rtn = AncestorReturnValue

IF ib_forcesave THEN
	li_SaveRtn = 	THIS.Event pfc_Save ( )
	IF li_SaveRtn = 1 OR li_SaveRtn = 0 THEN
		li_Rtn = 1
	END IF
END IF
RETURN li_Rtn
end event

type cb_help from w_response`cb_help within w_amounttypes
end type

type dw_amounttypelist from u_dw_amounttypelist within w_amounttypes
string tag = ";objectid=[86337568|609]"
integer x = 32
integer y = 132
integer width = 3529
integer height = 1632
integer taborder = 20
boolean hscrollbar = false
boolean hsplitscroll = false
end type

on dw_amounttypelist.create
call u_dw_amounttypelist::create
end on

on dw_amounttypelist.destroy
call u_dw_amounttypelist::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
//@(data)--
of_setDeleteable ( false )



end event

event pfc_addrow;call super::pfc_addrow;Long	ll_Return
ll_Return = AncestorReturnValue

IF ll_Return > 0 THEN
	THIS.SetFocus ( )
	THIS.ScrollToRow ( ll_Return )
	THIS.SetRow ( ll_Return )
	THIS.SetColumn (  "amounttype_name" )
	
END IF

RETURN ll_Return
end event

event ue_recievedmsg;IF IsValid ( anv_msg ) THEN
	Parent.wf_Processoptions ( anv_Msg )
	s_parm	lstr_parm
	IF anv_Msg.of_Get_Parm ( "FORCESAVE" , lstr_Parm ) <> 0 THEN
		ib_rmbmenu = NOT ib_ForceSave 
	END IF
END IF
end event

type cb_cancel from u_cbcancel within w_amounttypes
integer x = 1815
integer y = 1808
integer width = 233
integer taborder = 40
boolean cancel = false
end type

on cb_cancel.create
call u_cbcancel::create
end on

on cb_cancel.destroy
call u_cbcancel::destroy
end on

type cb_ok from u_cbok within w_amounttypes
integer x = 1536
integer y = 1808
integer width = 233
integer taborder = 30
end type

on cb_ok.create
call u_cbok::create
end on

on cb_ok.destroy
call u_cbok::destroy
end on

type cb_1 from commandbutton within w_amounttypes
integer x = 32
integer y = 24
integer width = 247
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Add"
end type

event clicked;dw_amounttypelist.Event pfc_AddRow ( )	
end event

type mle_instructions from multilineedit within w_amounttypes
integer x = 384
integer y = 16
integer width = 3177
integer height = 292
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

