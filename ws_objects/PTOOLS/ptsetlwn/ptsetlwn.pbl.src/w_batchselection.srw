$PBExportHeader$w_batchselection.srw
forward
global type w_batchselection from w_response
end type
type mle_message from u_mle within w_batchselection
end type
type ddlb_selection from u_ddlb within w_batchselection
end type
type cb_continue from u_cb within w_batchselection
end type
type cb_stop from u_cb within w_batchselection
end type
type st_1 from u_st within w_batchselection
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//String	ssa_BatchNames []
//String	ss_LastName = "NEW BATCH NUMBER"
////end modification Shared Variables by appeon  20070730
end variables

global type w_batchselection from w_response
integer x = 663
integer y = 600
integer width = 1125
integer height = 960
mle_message mle_message
ddlb_selection ddlb_selection
cb_continue cb_continue
cb_stop cb_stop
st_1 st_1
end type
global w_batchselection w_batchselection

type variables
n_cst_msg	inv_msg
s_parm 		istr_Parm
Private:
Boolean		ib_continue
String		isa_BatchNames[]

//begin modification Shared Variables by appeon  20070730
String	ssa_BatchNames []
String	ss_LastName = "NEW BATCH NUMBER"
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public function integer wf_populatewindow ()
end prototypes

public function integer wf_populatewindow ();String	ls_ButtonSet
String	lsa_BatchNames[]
Int		i
Int		li_TotalItems

IF inv_msg.of_Get_Parm ( "TITLE", istr_Parm ) <> 0 THEN
	THIS.Title = istr_Parm.ia_Value
END IF	
	
IF inv_msg.of_Get_Parm ( "MESSAGE", istr_Parm ) <> 0 THEN
	mle_message.TEXT = istr_Parm.ia_Value
END IF

IF inv_msg.of_Get_Parm ( "BUTTONSET", istr_Parm ) <> 0 THEN
	ls_ButtonSet = istr_Parm.ia_Value
	
	CHOOSE CASE ls_ButtonSet
		CASE "YESNO!"
			cb_continue.Text = "&Yes"
			cb_stop.Text	= "&No"
		CASE "OKCANCEL!"
			cb_continue.Text = "&OK"
			cb_stop.Text = "Cancel"
	END CHOOSE
	
END IF


li_TotalItems = UpperBound ( ssa_BatchNames )
FOR i = 1 TO li_TotalItems
	ddlb_selection.AddItem ( ssa_BatchNames [i] )
NEXT



IF inv_msg.of_Get_Parm ( "DEFAULT", istr_Parm ) <> 0 THEN
	String	ls_NewText
	ls_NewText = istr_Parm.ia_Value
	IF IsNull ( ls_NewText ) or Len ( ls_NewText ) = 0 THEN
		ddlb_selection.SelectItem ( ddlb_selection.Event ue_AddItem ( ss_LastName ) )
	ELSE
		ddlb_selection.SelectItem ( ddlb_selection.Event ue_AddItem ( ls_NewText ) )
	END IF
END IF



RETURN 1
end function

on w_batchselection.create
int iCurrent
call super::create
this.mle_message=create mle_message
this.ddlb_selection=create ddlb_selection
this.cb_continue=create cb_continue
this.cb_stop=create cb_stop
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_message
this.Control[iCurrent+2]=this.ddlb_selection
this.Control[iCurrent+3]=this.cb_continue
this.Control[iCurrent+4]=this.cb_stop
this.Control[iCurrent+5]=this.st_1
end on

on w_batchselection.destroy
call super::destroy
destroy(this.mle_message)
destroy(this.ddlb_selection)
destroy(this.cb_continue)
destroy(this.cb_stop)
destroy(this.st_1)
end on

event open;call super::open;inv_msg = message.powerobjectparm
ib_continue = FALSE
IF isValid ( inv_msg ) THEN
	
	THIS.wf_PopulateWindow ( )
	
END IF
end event

event close;call super::close;String	ls_Null
SetNull ( ls_Null )

istr_Parm.is_Label = "CONTINUE"
istr_Parm.ia_Value = ib_continue

inv_Msg.of_add_parm ( istr_Parm )


IF ib_Continue THEN
	istr_Parm.is_Label = "BATCH"
	istr_Parm.ia_Value = Trim (UPPER ( ddlb_selection.Text))
	inv_Msg.of_add_parm ( istr_Parm )
	ss_LastName = ddlb_selection.Text
ELSE
	istr_Parm.is_Label = "BATCH"
	istr_Parm.ia_Value = ls_Null 
	inv_Msg.of_add_parm ( istr_Parm )
END IF

CloseWithReturn ( THIS, inv_Msg )
end event

event closequery;call super::closequery;Int	li_Return

li_Return = AncestorReturnValue 

IF li_Return = 0 THEN  //ALLOW_CLOSE
	IF ib_Continue  THEN
		IF ddlb_selection.Text = "NEW BATCH NUMBER" THEN
			MessageBox("Batch Number" , "Please select or enter a Batch Number." )
			ddlb_selection.SetFocus ( )
			ib_continue = FALSE
			li_Return = 1 // PREVENT_CLOSE 
		END IF
	END IF
END IF

RETURN li_Return
	
end event

type cb_help from w_response`cb_help within w_batchselection
end type

type mle_message from u_mle within w_batchselection
integer x = 23
integer y = 24
integer width = 1065
integer height = 392
integer taborder = 0
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean displayonly = true
end type

type ddlb_selection from u_ddlb within w_batchselection
event type integer ue_additem ( string as_item )
integer x = 23
integer y = 520
integer width = 1065
integer height = 328
integer taborder = 10
boolean bringtotop = true
boolean allowedit = true
boolean autohscroll = true
integer accelerator = 110
end type

event ue_additem;Int		i
String	ls_NewText
Int		li_ReturnValue
Int		li_Index
ls_NewText = UPPER (TRIM ( as_item ))


IF ls_NewText <> "" THEN 
		
	SetRedraw ( FALSE )
	For i = 1 TO THIS.TotalItems ( )
		
		THIS.SelectItem (i)
		IF Upper ( ls_NewText ) = Upper ( THIS.Text) THEN
			li_Index = i
			Exit
		END IF
		
	NEXT
	SetRedraw ( TRUE )
	IF i > THIS.TotalItems ()THEN
		li_Index = THIS.AddItem ( ls_NewText )
		THIS.SelectItem ( li_Index  )
		ssa_batchnames[ upperbound ( ssa_batchnames[] ) + 1 ] = ls_NewText
		
	end if
ELSE
	li_Index = 1
END IF

Return li_Index

end event

event modified;Int	i
String	ls_NewText
ls_NewText = THIS.Text

i = THIS.Event ue_AddItem ( ls_NewText )

THIS.SelectItem (i)

end event

type cb_continue from u_cb within w_batchselection
integer x = 169
integer y = 744
integer taborder = 20
boolean bringtotop = true
string text = "&OK"
boolean default = true
end type

event clicked;ib_continue = TRUE

Close ( PARENT ) 
end event

type cb_stop from u_cb within w_batchselection
integer x = 562
integer y = 744
integer taborder = 30
boolean bringtotop = true
string text = "Cancel"
boolean cancel = true
end type

event clicked;ib_continue = FALSE
Close ( PARENT ) 
end event

type st_1 from u_st within w_batchselection
integer x = 37
integer y = 452
integer width = 347
boolean bringtotop = true
string text = "Batch &Number"
end type

