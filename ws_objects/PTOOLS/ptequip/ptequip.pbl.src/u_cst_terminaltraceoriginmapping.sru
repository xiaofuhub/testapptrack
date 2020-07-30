$PBExportHeader$u_cst_terminaltraceoriginmapping.sru
forward
global type u_cst_terminaltraceoriginmapping from u_base
end type
type cb_remove from commandbutton within u_cst_terminaltraceoriginmapping
end type
type rb_2 from radiobutton within u_cst_terminaltraceoriginmapping
end type
type rb_1 from radiobutton within u_cst_terminaltraceoriginmapping
end type
type st_terminals from statictext within u_cst_terminaltraceoriginmapping
end type
type dw_terminals from u_dw within u_cst_terminaltraceoriginmapping
end type
type cb_add from commandbutton within u_cst_terminaltraceoriginmapping
end type
type dw_terminaloriginmapping from u_dw within u_cst_terminaltraceoriginmapping
end type
end forward

global type u_cst_terminaltraceoriginmapping from u_base
integer width = 2153
integer height = 1096
long backcolor = 12632256
event type integer ue_addmapping ( long al_row )
event ue_removemapping ( )
event type integer ue_showterminals ( )
event type integer ue_hideterminals ( )
cb_remove cb_remove
rb_2 rb_2
rb_1 rb_1
st_terminals st_terminals
dw_terminals dw_terminals
cb_add cb_add
dw_terminaloriginmapping dw_terminaloriginmapping
end type
global u_cst_terminaltraceoriginmapping u_cst_terminaltraceoriginmapping

forward prototypes
private function integer of_initializedefaults ()
end prototypes

event type integer ue_addmapping(long al_row);Integer	li_Return = 1
String	ls_TerminalName
String	ls_Active
Long		ll_TerminalCount
Long		ll_TerminalId
Long		ll_TerminalSiteid
Long		ll_NewRow

ll_TerminalId = dw_Terminals.GetItemNumber(al_Row, "t_id")
ls_TerminalName = dw_Terminals.GetItemString(al_Row, "t_name")
ll_TerminalSiteId = dw_Terminals.GetItemNumber(al_Row, "terminaltrace_terminals_siteid")
ls_Active = dw_Terminals.GetItemString(al_Row, "terminaltrace_terminalsites_active")

ll_NewRow =  dw_TerminalOriginMapping.InsertRow(0) 
IF ll_NewRow > 0 THEN
	dw_TerminalOriginMapping.SetItem(ll_NewRow, "terminaltrace_terminals_t_id", ll_TerminalId)
	dw_TerminalOriginMapping.SetItem(ll_NewRow, "terminaltrace_terminals_t_name", ls_TerminalName)
	dw_TerminalOriginMapping.SetItem(ll_NewRow, "terminaltrace_terminals_siteid", ll_TerminalSiteId)
	dw_TerminalOriginMapping.SetItem(ll_NewRow, "terminaloriginmapping_terminalid", ll_TerminalId)
	dw_TerminalOriginMapping.SetItem(ll_Newrow, "terminaltrace_terminalsites_active", ls_Active)
	dw_TerminalOriginMapping.SetItem(ll_Newrow, "terminaltrace_terminalsites_siteid", ll_TerminalSiteId)
	dw_TerminalOriginMapping.SetRow(ll_NewRow)
	dw_TerminalOriginMapping.ScrollToRow(ll_NewRow)
ELSE
	li_Return = -1
END IF

Return li_Return

end event

event ue_removemapping();dw_terminaloriginmapping.Event pfc_DeleteRow()
end event

event type integer ue_showterminals();Integer li_Return = 1

IF dw_Terminals.RowCount() > 0 THEN
	dw_Terminals.Visible = True
	st_Terminals.Visible = True
	rb_1.Visible = True
	rb_2.Visible = True
ELSE
	MessageBox("Add Terminal Mapping", "There are no terminals set up for terminal tracing.")
	li_Return = -1
END IF


Return li_Return
end event

event type integer ue_hideterminals();Integer li_Return = 1 
dw_Terminals.Visible = False
st_Terminals.Visible = False
rb_1.Visible = False
rb_2.Visible = False
Return li_Return
end event

private function integer of_initializedefaults ();Integer	li_Return = 1
LOng		ll_TerminalCount
Long		i

//Add a row for every terminal
IF li_Return = 1 THEN
	ll_TerminalCount = dw_Terminals.Rowcount()
	FOR i = 1 TO ll_TerminalCount
		This.Event ue_AddMapping(i)
	NEXT
END IF

Return li_Return

end function

on u_cst_terminaltraceoriginmapping.create
int iCurrent
call super::create
this.cb_remove=create cb_remove
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_terminals=create st_terminals
this.dw_terminals=create dw_terminals
this.cb_add=create cb_add
this.dw_terminaloriginmapping=create dw_terminaloriginmapping
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_remove
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.st_terminals
this.Control[iCurrent+5]=this.dw_terminals
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.dw_terminaloriginmapping
end on

on u_cst_terminaltraceoriginmapping.destroy
call super::destroy
destroy(this.cb_remove)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_terminals)
destroy(this.dw_terminals)
destroy(this.cb_add)
destroy(this.dw_terminaloriginmapping)
end on

event constructor;call super::constructor;String	ls_Filter

dw_Terminals.SetTransObject(SQLCA)
dw_Terminals.Retrieve()
rb_1.Checked = True
dw_Terminals.Event ue_ShowActive()

dw_TerminalOriginMapping.SetTransObject(SQLCA)
IF dw_TerminalOriginMapping.Retrieve() < 1 THEN
	This.of_InitializeDefaults()
END IF







end event

type cb_remove from commandbutton within u_cst_terminaltraceoriginmapping
integer x = 539
integer y = 948
integer width = 453
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Remove"
end type

event clicked;Parent.Event ue_RemoveMapping()
end event

type rb_2 from radiobutton within u_cst_terminaltraceoriginmapping
boolean visible = false
integer x = 814
integer y = 260
integer width = 178
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "All"
end type

event clicked;dw_terminals.Event ue_ShowAll()
end event

type rb_1 from radiobutton within u_cst_terminaltraceoriginmapping
boolean visible = false
integer x = 494
integer y = 260
integer width = 320
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Active"
end type

event clicked;dw_Terminals.Event ue_ShowActive()
end event

type st_terminals from statictext within u_cst_terminaltraceoriginmapping
boolean visible = false
integer x = 480
integer y = 176
integer width = 1230
integer height = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Choose a terminal to map"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_terminals from u_dw within u_cst_terminaltraceoriginmapping
event ue_hide ( )
event ue_showactive ( )
event ue_showall ( )
boolean visible = false
integer x = 480
integer y = 252
integer width = 1230
integer height = 596
integer taborder = 20
string title = "Add Terminal Mapping"
string dataobject = "d_terminaltraceterminals"
boolean controlmenu = true
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

event ue_hide();Parent.Event ue_HideTerminals()
end event

event ue_showactive();String	ls_Filter
ls_Filter = "terminaltrace_terminalsites_active = 'y'"
This.SetFilter(ls_Filter)
This.Filter()
end event

event ue_showall();This.SetFilter("")
This.Filter()
end event

event constructor;call super::constructor;Long	ll_Silver
This.of_SetRowSelect(TRUE)
This.inv_RowSelect.of_SetRequestor(THIS)
This.inv_RowSelect.of_SetStyle(0)

ll_Silver = rgb(192, 192, 192)

 //give room for the filter radio buttons
This.Modify("DataWindow.Header.Height = 60")
This.Modify("DataWindow.Header.Color = " + String(ll_Silver))

This.Modify("DataWindow.Footer.Height = 72") //Show close button


end event

event clicked;call super::clicked;IF row > 0 THEN
	This.SetRow(row)
	Parent.Event ue_AddMapping(row)
	This.Event ue_Hide()
END IF

end event

event doubleclicked;call super::doubleclicked;IF row > 0 THEN
	Parent.Event ue_AddMapping(row)
	This.Event ue_Hide()
END IF
end event

event buttonclicked;call super::buttonclicked;IF dwo.Name = "b_close" THEN
	This.Event ue_Hide()
END IF
end event

type cb_add from commandbutton within u_cst_terminaltraceoriginmapping
integer x = 50
integer y = 948
integer width = 453
integer height = 112
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add"
end type

event clicked;Parent.Event ue_ShowTerminals()
end event

type dw_terminaloriginmapping from u_dw within u_cst_terminaltraceoriginmapping
event type integer ue_validateorigin ( long al_originid )
integer x = 50
integer y = 48
integer width = 2034
integer height = 864
integer taborder = 10
string dataobject = "d_terminaltraceoriginmapping"
boolean hscrollbar = true
end type

event type integer ue_validateorigin(long al_originid);Integer	li_Return = 1
Long		ll_FoundRow
String	ls_FindString
String	ls_CoName
String	ls_TerminalName


IF isNull(al_OriginId) OR al_OriginId <= 0 THEN
	li_Return = -1
END IF

//Check if origin site is already set up
IF li_Return = 1 THEN
	
	ls_FindString = "companies_co_id = " + String(al_OriginId) 
	ll_FoundRow = This.Find(ls_FindString, 1, This.RowCount())
	IF ll_FoundRow > 0 THEN
		ls_CoName = This.GetItemString(ll_FoundRow, "companies_co_name")
		ls_TerminalName = This.GetItemString(ll_FoundRow, "terminaltrace_terminals_t_name")
		MessageBox("Duplicate Origin", "Origin site " + ls_CoName + " is already mapped to " + ls_TerminalName + ".")
		li_Return = -1
	END IF
	

END IF



Return li_Return




end event

event itemchanged;call super::itemchanged;Integer	li_Return

s_co_Info	lstr_Company

li_Return = AncestorReturnValue

CHOOSE CASE dwo.Name 
	CASE "companies_co_name"
		
		IF gnv_cst_Companies.of_Select(lstr_company, "ANY!", True, data, False, 0, False, True) = 1 THEN
			
			IF This.Event ue_ValidateOrigin(lstr_Company.co_Id) = 1 THEN
				This.SetItem(row, "companies_co_id", lstr_Company.co_Id )
				This.SetItem(row, "companies_co_name", lstr_Company.co_Name)
				This.SetItem(row, "terminaloriginmapping_originid", lstr_Company.co_Id)
				li_Return = 2 //Reject and replace with new value, allow focus to change
			ELSE
				li_Return = 1 //Reject value, do not allow focus to change
			END IF
		ELSE
			li_Return = 1 //Reject value, do not allow focus to change
		END IF
	
END CHOOSE


Return li_Return

end event

event pfc_addrow;Integer li_Return = 1

//Overriding Ancestor
IF Parent.Event ue_ShowTerminals() <> 1 THEN
	li_Return = -1
END IF

Return li_Return
end event

event pfc_preupdate;call super::pfc_preupdate;//change update status of rows that have null originid or null terminalid
Integer 	li_Return = 1
Long		ll_RowCount
Long		i
Long		ll_TerminalId
Long		ll_OriginId

DwItemStatus 	dwis_status

//Change status to notmodified for unmapped rows in primary buffer
ll_RowCount = This.RowCount()
FOR i = ll_RowCount TO 1 STEP -1
	ll_TerminalId = This.GetItemNumber(i, "terminaloriginmapping_terminalid")
	ll_OriginId = This.GetItemNumber(i, "terminaloriginmapping_originid")
	dwis_status = This.GetItemStatus(i, 0, Primary!)
	
	IF isNull(ll_TerminalId) OR isNull(ll_OriginId) &
		OR ll_TerminalId < 1 OR ll_OriginId < 1 THEN
		
		IF dwis_status = New! OR dwis_status = NewModified! THEN
			This.SetItemStatus(i, 0, Primary!, DataModified!)
		END IF
		
		This.SetItemStatus(i, 0, Primary!, NotModified!)
		
	END IF
NEXT

//Change status to notmodified for unmapped rows in filter buffer
ll_RowCount = This.FilteredCount()
FOR i = ll_RowCount TO 1 STEP -1
	ll_TerminalId = This.GetItemNumber(i, "terminaloriginmapping_terminalid", Filter!, FALSE)
	ll_OriginId = This.GetItemNumber(i, "terminaloriginmapping_originid", Filter!, FALSE)
	dwis_status = This.GetItemStatus(i, 0, Filter!)
	
	IF isNull(ll_TerminalId) OR isNull(ll_OriginId) &
		OR ll_TerminalId < 1 OR ll_OriginId < 1 THEN
			
		IF dwis_status = New! OR dwis_status = NewModified! THEN
			This.SetItemStatus(i, 0, Filter!, DataModified!)
		END IF
		
		This.SetItemStatus(i, 0, Filter!, NotModified!)
			
	END IF
NEXT

///Discard rows in delete buffer that do not have valid ids
ll_RowCount = This.DeletedCount()
FOR i = ll_RowCount TO 1 STEP -1
	ll_TerminalId = This.GetItemNumber(i, "terminaloriginmapping_terminalid", Delete!, FALSE)
	ll_OriginId = This.GetItemNumber(i, "terminaloriginmapping_originid", Delete!, FALSE)
	
	IF isNull(ll_TerminalId) OR isNull(ll_OriginId) &
		OR ll_TerminalId < 1 OR ll_OriginId < 1 THEN
			
		This.RowsDiscard(i, i, Delete!)
		
	END IF
NEXT





Return li_Return
end event

event constructor;call super::constructor;This.of_SetInsertable(FALSE)
end event

event pfc_insertrow;Integer li_Return = 1

//Overriding Ancestor
IF Parent.Event ue_ShowTerminals() <> 1 THEN
	li_Return = -1
END IF

Return li_Return
end event

