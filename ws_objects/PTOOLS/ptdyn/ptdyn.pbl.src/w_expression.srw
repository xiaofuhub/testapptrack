$PBExportHeader$w_expression.srw
forward
global type w_expression from w_response
end type
type cb_verify from commandbutton within w_expression
end type
type cb_cancel from commandbutton within w_expression
end type
type cb_ok from commandbutton within w_expression
end type
type st_expression from statictext within w_expression
end type
type st_columns from statictext within w_expression
end type
type lb_columns from listbox within w_expression
end type
type mle_expression from multilineedit within w_expression
end type
end forward

global type w_expression from w_response
integer x = 0
integer y = 0
integer width = 1801
integer height = 1464
string title = "Expression"
boolean controlmenu = false
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_verify cb_verify
cb_cancel cb_cancel
cb_ok cb_ok
st_expression st_expression
st_columns st_columns
lb_columns lb_columns
mle_expression mle_expression
end type
global w_expression w_expression

type variables
DataWindow		idw_CurrentDw
end variables

forward prototypes
public function integer of_setexpression (string as_expression)
public function integer of_validatemouseoverexpression (string as_expression)
end prototypes

public function integer of_setexpression (string as_expression);mle_expression.Text = as_Expression
Return 1
end function

public function integer of_validatemouseoverexpression (string as_expression);/***************************************************************************************
NAME: 			of_ValidateMouseOverExpression

ACCESS:			public
		
ARGUMENTS: 		(string as_expression)

RETURNS:			integer
	
DESCRIPTION:  Validates a string that is passed as an argument
					Used to validate mouseover expressions
					
					Returns 1 if an expression is valid
					Returns -1 if an expressin is invalid
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/5
	

***************************************************************************************/


n_cst_String	lnv_String
String	ls_Result
Integer	li_Return


IF isValid(idw_CurrentDw) THEN
	IF Len(Trim(as_Expression)) > 0 THEN
		
		
		as_Expression = lnv_String.of_GlobalReplace ( as_Expression, "'", "~~~'" )
		
		ls_Result = idw_CurrentDw.Describe ( "Evaluate('" + as_Expression + "'," + String(1) + ")")
		IF Len(ls_Result) > 0 THEN
			IF ls_Result = "?" OR ls_Result = "!" THEN
				li_Return = -1
			ELSE
				li_Return = 1
			END IF
		ELSE
			li_Return = 1
		END IF
	ELSE
		li_Return = 1
	END IF

ELSE
	li_Return = 1
END IF


Return li_Return
end function

on w_expression.create
int iCurrent
call super::create
this.cb_verify=create cb_verify
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_expression=create st_expression
this.st_columns=create st_columns
this.lb_columns=create lb_columns
this.mle_expression=create mle_expression
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_verify
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.st_expression
this.Control[iCurrent+5]=this.st_columns
this.Control[iCurrent+6]=this.lb_columns
this.Control[iCurrent+7]=this.mle_expression
end on

on w_expression.destroy
call super::destroy
destroy(this.cb_verify)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_expression)
destroy(this.st_columns)
destroy(this.lb_columns)
destroy(this.mle_expression)
end on

event open;n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm

IF isValid(Message.PowerObjectParm) THEN
	lnv_Msg = Message.PowerObjectParm 
	
	
	IF lnv_Msg.of_Get_parm("CURRENTDW", lstr_Parm ) > 0 THEN
		idw_currentdw = lstr_Parm.ia_value
		This.lb_columns.Event ue_UpdateColList( )
	END IF
	
	IF lnv_Msg.of_Get_Parm("EXPRESSION", lstr_Parm) > 0 THEN
			of_SetExpression(lstr_Parm.ia_value) //
	END IF

	
END IF






end event

type cb_help from w_response`cb_help within w_expression
boolean visible = false
end type

type cb_verify from commandbutton within w_expression
integer x = 1472
integer y = 760
integer width = 265
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Verify"
end type

event clicked;String 	ls_Expression
Integer	li_Valid

ls_Expression = Trim(mle_Expression.Text)
li_Valid = of_ValidateMouseOverExpression(ls_Expression)
IF li_Valid = 1 THEN
	MessageBox("Expression",  "Valid Expression!")
ELSE
	//Expression not valid - message box taken care of in describe evaluate
END IF

end event

type cb_cancel from commandbutton within w_expression
integer x = 1403
integer y = 1244
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;CloseWithReturn(w_Expression, "CANCEL!")
end event

type cb_ok from commandbutton within w_expression
integer x = 1403
integer y = 1088
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;String 	ls_Expression
Integer	li_Valid

ls_Expression = Trim(mle_Expression.Text)
IF Not isNull(ls_Expression) AND Len(ls_Expression) > 0 THEN
	li_Valid = of_ValidateMouseOverExpression(ls_Expression)
	IF li_Valid = 1 THEN
		CloseWithReturn(w_Expression, ls_Expression)
	ELSE
		//Expression not valid - message box taken care of in describe evaluate
	END IF
ELSE
	CloseWithReturn(w_Expression, ls_Expression)
END IF
end event

type st_expression from statictext within w_expression
integer x = 55
integer y = 36
integer width = 325
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Expression:"
boolean focusrectangle = false
end type

type st_columns from statictext within w_expression
integer x = 55
integer y = 752
integer width = 242
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Columns:"
boolean focusrectangle = false
end type

type lb_columns from listbox within w_expression
event ue_updatecollist ( )
integer x = 55
integer y = 844
integer width = 855
integer height = 488
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event ue_updatecollist();Long		ll_MaxColumns
Long		ll_Index
String	ls_Col



IF isValid( idw_CurrentDw ) THEN 
	IF isValid( idw_CurrentDw.Object ) THEN
		ll_MaxColumns = Long(idw_CurrentDw.Object.DataWindow.Column.Count)
		FOR ll_Index = 1 to ll_MaxColumns
			ls_Col = idw_CurrentDw.Describe("#"+String(ll_Index)+".Name")
			This.AddItem( ls_Col )
		NEXT
	END IF
END IF

end event

event selectionchanged;String	ls_Selected

ls_Selected = This.Text( index )
mle_expression.Event ue_InsertItem( ls_Selected )
mle_expression.SetFocus()

end event

type mle_expression from multilineedit within w_expression
event ue_insertitem ( string as_string )
integer x = 55
integer y = 116
integer width = 1678
integer height = 604
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_insertitem(string as_string);String	ls_String

ls_String = " " + as_String + " "

This.Replacetext( ls_String )
end event

