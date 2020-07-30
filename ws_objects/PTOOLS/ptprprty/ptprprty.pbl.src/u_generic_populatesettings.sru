$PBExportHeader$u_generic_populatesettings.sru
forward
global type u_generic_populatesettings from u_base
end type
type dw_1 from u_dw within u_generic_populatesettings
end type
type st_1 from statictext within u_generic_populatesettings
end type
type cb_remove from commandbutton within u_generic_populatesettings
end type
type cb_add from commandbutton within u_generic_populatesettings
end type
end forward

global type u_generic_populatesettings from u_base
integer width = 1701
integer height = 1248
event ue_setlabel ( string as_label )
event type integer ue_addrow ( )
event ue_removerow ( )
event ue_insertrow ( string as_columnvalue )
event ue_setcolumnheader ( string as_columnheader )
event ue_setdwfocus ( )
event ue_rowadded ( ref long al_newrow )
event type string ue_collectitems ( )
event ue_savevalues ( string as_values )
event ue_setcolumncase ( string as_value )
event ue_setcolumnlimit ( integer ai_value )
dw_1 dw_1
st_1 st_1
cb_remove cb_remove
cb_add cb_add
end type
global u_generic_populatesettings u_generic_populatesettings

forward prototypes
public subroutine of_insertitem (string as_coname, long al_coid)
public subroutine of_insert (long al_newrow, string as_colname, long al_coid)
public subroutine of_setheight (integer ai_value)
end prototypes

event ue_setlabel(string as_label);st_1.Text = as_label
end event

event type integer ue_addrow();dw_1.SetReDraw(False)
Int li_ReturnValue = 1
Long ll_InsertRowNum
String ls_Values
ll_InsertRowNum = dw_1.InsertRow(0)

IF ll_InsertRowNum > 0 THEN
	dw_1.Modify("Values.Edit.DisplayOnly = 'No'")
	dw_1.ScrollToRow(ll_InsertRowNum)
	dw_1.SetRow(ll_InsertRowNum)
	dw_1.SetFocus()
	THIS.Event ue_RowAdded ( ll_InsertRowNum )	
ELSE
	li_ReturnValue = -1
	MessageBox('System Settings','Failed to Insert Row')
END IF
dw_1.SetReDraw(True)
Return li_ReturnValue

end event

event ue_removerow();Long ll_Row
ll_Row = dw_1.GetRow()

IF MessageBox('System Settings',& 
					'Are you sure you want to remove entry?',Question!,YesNo!,2) = 1 THEN
	dw_1.DeleteRow(ll_Row)
	event ue_savevalues(event ue_collectitems( ))
END IF

event ue_SetDWFocus( )
end event

event ue_insertrow(string as_columnvalue);dw_1.Object.Values[dw_1.InsertRow(0)] = as_ColumnValue
end event

event ue_setcolumnheader(string as_columnheader);dw_1.Modify("values_t.text = '" + as_columnheader + "'")
end event

event ue_setdwfocus();dw_1.SetFocus()
end event

event type string ue_collectitems();// Implemented in decendants
Return ''

end event

event ue_setcolumncase(string as_value);dw_1.Object.values.Edit.Case=as_value
end event

event ue_setcolumnlimit(integer ai_value);dw_1.Object.values.Edit.Limit=ai_value
end event

public subroutine of_insertitem (string as_coname, long al_coid);Long ll_InsertRowNum

ll_InsertRowNum = dw_1.InsertRow(0)

IF dw_1.RowCount() > 0 THEN
	dw_1.Object.values[ll_InsertRowNum] 			= as_coname
	dw_1.Object.hidden_values[ll_InsertRowNum]	= String(al_coid)
ELSE
	MessageBox('System Setting','Failed to Insert Row')
END IF
	



end subroutine

public subroutine of_insert (long al_newrow, string as_colname, long al_coid);dw_1.Object.values[al_newrow] 			= as_colname
dw_1.Object.hidden_values[al_newrow] 	= String(al_coid)
end subroutine

public subroutine of_setheight (integer ai_value);THIS.height = ai_value
dw_1.height = ai_value * .7

end subroutine

on u_generic_populatesettings.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.cb_remove=create cb_remove
this.cb_add=create cb_add
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_remove
this.Control[iCurrent+4]=this.cb_add
end on

on u_generic_populatesettings.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.cb_remove)
destroy(this.cb_add)
end on

type dw_1 from u_dw within u_generic_populatesettings
integer x = 41
integer y = 128
integer width = 1248
integer height = 1104
integer taborder = 10
string dataobject = "d_generic_populate"
boolean ib_isupdateable = false
end type

event losefocus;call super::losefocus;IF dw_1.Modifiedcount( ) > 0 THEN
	dw_1.Accepttext( )
END IF

dw_1.Modify("Values.Edit.DisplayOnly = 'Yes'")


end event

event getfocus;call super::getfocus;cb_remove.Enabled = True

end event

event itemchanged;call super::itemchanged;String ls_Values
ls_Values = event ue_collectitems( )

event ue_SaveValues(ls_Values)












end event

type st_1 from statictext within u_generic_populatesettings
integer x = 41
integer y = 48
integer width = 1262
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type cb_remove from commandbutton within u_generic_populatesettings
integer x = 1344
integer y = 332
integer width = 297
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Remove"
end type

event clicked;dw_1.SelectRow( dw_1.getRow(),TRUE)
Event ue_removerow( )
end event

type cb_add from commandbutton within u_generic_populatesettings
integer x = 1344
integer y = 128
integer width = 297
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Add"
end type

event clicked;Event ue_addrow( )
end event

