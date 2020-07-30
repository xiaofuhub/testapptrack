$PBExportHeader$u_dw_companyedit.sru
forward
global type u_dw_companyedit from u_dw
end type
end forward

global type u_dw_companyedit from u_dw
integer width = 1074
integer height = 472
string dataobject = "d_company_form"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
event ue_exportselected ( )
end type
global u_dw_companyedit u_dw_companyedit

forward prototypes
public function integer of_getmenuenabled (integer ai_xpos, integer ai_ypos, long al_row, dwobject adwo_dwo, ref boolean ab_iscopyable, ref boolean ab_iscutable, ref boolean ab_ispasteable, ref boolean ab_isselectallable)
end prototypes

event ue_exportselected();
//return 1
//written by Dan 11-29-2005
Boolean	lb_rowSelection
Long		ll_selectedCount
Long		lla_selected[]
Long		ll_cnt
datawindow	ldw_selection
Window	lw_parent

IF isValid( parent ) THEN
	IF parent.typeOf( ) = window! THEN
		lw_parent = parent
		//i use a u_dw instead of a datastore because datastores do not prompt
		//for a save as file name.  They require the file is specified on save.
		lw_parent.openuserObject(ldw_selection, "u_dw", this.x, this.y)
		IF isValid( ldw_selection ) THEN
			ldw_selection.visible = false
		END IF
	END IF
END IF
// Get selected count
lb_rowselection = IsValid (inv_rowselect)
if not lb_rowselection then
	of_SetRowSelect (true)
end if
ll_selectedcount = inv_rowselect.of_SelectedCount (lla_selected)
if not lb_rowselection then
	of_SetRowSelect (false)
end if	

if ll_selectedcount > 0 and isValid( ldw_selection ) then
	// Create a datastore to print selected rows	ldw_selection = create datawindow
	ldw_selection.dataobject = this.dataobject
	ldw_selection.settransobject( sqlca)

	// First discard any data in the dataobject
	ldw_selection.Reset()

	// Copy selected rows
	for ll_cnt = 1 to ll_selectedcount
	
		if this.RowsCopy (lla_selected[ll_cnt], lla_selected[ll_cnt], primary!, &
			ldw_selection, 2147483647, primary!) < 0 then
			EXIT
		end if
		
	next
END IF

IF isValid (ldw_selection) THEN
	
	//i need a solution to this..i need to beable to specify the file name of 
	//the thing that i want to export.
	ldw_selection.saveAs()
	lw_parent.closeUserobject(ldw_selection)
END IF



end event

public function integer of_getmenuenabled (integer ai_xpos, integer ai_ypos, long al_row, dwobject adwo_dwo, ref boolean ab_iscopyable, ref boolean ab_iscutable, ref boolean ab_ispasteable, ref boolean ab_isselectallable);/*
	integer ai_xpos
	integer ai_ypos
	long	al_row
	dwobject adwo_dwo
r	boolean	ab_iscopyable
r	boolean	ab_iscutable
r	boolean	ab_ispasteable
r	boolean	ab_isselectallable
*/




boolean		lb_frame
boolean		lb_desired
boolean		lb_readonly
boolean		lb_editstyleattrib
integer		li_tabsequence
long			ll_getrow
string		ls_editstyle
string		ls_val
string		ls_protect
string		ls_colname
string		ls_currcolname
string		ls_type
string		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent


//set the vars to be returned initially to false
ab_isCopyable = false
ab_isCutable = false
ab_isPasteable = false
ab_isSelectallable = false

// Determine if RMB popup menu should occur
if IsNull (adwo_dwo) then
	return 1
end if

// No RMB support for OLE objects and graphs
ls_type = adwo_dwo.type
if ls_type = "ole" or ls_type = "tableblob" or ls_type = "graph" then
	return 1
end if

// No RMB support for print preview mode
if this.object.datawindow.print.preview = "yes" then
	return 1
end if

//// Determine parent window for PointerX, PointerY offset
//this.of_GetParentWindow (lw_parent)
//if IsValid (lw_parent) then
//	// Get the MDI frame window if available
//	lw_frame = lw_parent
//	do while IsValid (lw_frame)
//		if lw_frame.windowtype = mdi! or lw_frame.windowtype = mdihelp! then
//			lb_frame = true
//			exit
//		else
//			lw_frame = lw_frame.ParentWindow()
//		end if
//	loop
//	
//	if lb_frame then
//		// If MDI frame window is available, use it as the reference point for the
//		// popup menu for sheets (windows opened with OpenSheet function) or child windows
//		if lw_parent.windowtype = child! then
//			lw_parent = lw_frame
//		else
//			lw_sheet = lw_frame.GetFirstSheet()
//			if IsValid (lw_sheet) then
//				do
//					// Use frame reference for popup menu if the parentwindow is a sheet
//					if lw_sheet = lw_parent then
//						lw_parent = lw_frame
//						exit
//					end if
//					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
//				loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
//			end if
//		end if
//	else
//		// SDI application.  All windows except for child windows will use the parent
//		// window of the control as the reference point for the popmenu
//		if lw_parent.windowtype = child! then
//			lw_childparent = lw_parent.ParentWindow()
//			if IsValid ( lw_childparent ) then
//				lw_parent = lw_childparent
//			end if
//		end if
//	end if
//else
//	return 1
//end if

// Create popup menu
lm_dw = create m_dw
lm_dw.of_SetParent (this)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = this.GetRow()

ls_val = this.object.datawindow.readonly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

choose case ls_type
	case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"

		// Row operations based on readonly status
		lm_dw.m_table.m_insert.enabled = not lb_readonly
		lm_dw.m_table.m_addrow.enabled = not lb_readonly
		lm_dw.m_table.m_delete.enabled = not lb_readonly

		// Menu item enablement for current row
		if not lb_readonly then
			lb_desired = False
			if ll_getrow > 0 then lb_desired = True
			lm_dw.m_table.m_delete.enabled = lb_desired
			lm_dw.m_table.m_insert.enabled = lb_desired			
		end if
	case else
		lm_dw.m_table.m_insert.enabled = false
		lm_dw.m_table.m_delete.enabled = false
		lm_dw.m_table.m_addrow.enabled = false
end choose

// Get column properties
ls_currcolname = this.GetColumnName()
if ls_type = "column" then
	ls_editstyle = adwo_dwo.edit.style
	ls_colname = adwo_dwo.name
	ls_protect = adwo_dwo.protect
	If Not IsNumber(ls_protect) Then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, '~t'))
		ls_expression = "Evaluate(~""+ls_expression+","+String(al_row)+")"
		ls_protect = this.Describe(ls_expression)
	End If
	ls_val = adwo_dwo.tabsequence
	if IsNumber (ls_val) then
		li_tabsequence = Integer (ls_val)
	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
lm_dw.m_table.m_copy.enabled = false
lm_dw.m_table.m_cut.enabled = false
lm_dw.m_table.m_paste.enabled = false
lm_dw.m_table.m_selectall.enabled = false

// Get the column/editystyle specific editable flag.
if ls_type = "column" and not lb_readonly then
	choose case ls_editstyle
		case "edit"
			ls_val = adwo_dwo.edit.displayonly
		case "editmask"
			ls_val = adwo_dwo.editmask.readonly
		case "ddlb"
			ls_val = adwo_dwo.ddlb.allowedit
		case "dddw"
			ls_val = adwo_dwo.dddw.allowedit
		case Else
			ls_val = ''
	end choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	If IsNull(lb_editstyleattrib) Then lb_editstyleattrib = False
End If

if ls_type = "column" and not lb_readonly then
	if adwo_dwo.bitmapname = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then

		if Len (this.SelectedText()) > 0 and ll_getrow = al_row and ls_currcolname = ls_colname then
			// Copy
			lm_dw.m_table.m_copy.enabled = true

			// Cut
			if li_tabsequence > 0 and ls_protect = "0" then
				lb_desired = False
				choose case ls_editstyle
					case "edit", "editmask"
						lb_desired = not lb_editstyleattrib
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib
				end choose
				lm_dw.m_table.m_cut.enabled = lb_desired
			end if
		end if
			
		if li_tabsequence > 0 and ls_protect = "0" then
			// Paste
			if Len (ClipBoard()) > 0 then
				lb_desired = False
				choose case ls_editstyle
					case "edit", "editmask"
						lb_desired = not lb_editstyleattrib
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib
				end choose
				lm_dw.m_table.m_paste.enabled = lb_desired
			end if

			// Select All
			if Len (this.GetText()) > 0 and ll_getrow = al_row and ls_currcolname = ls_colname then
				choose case ls_editstyle
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib						
					case else
						lb_desired = true
				end choose
				lm_dw.m_table.m_selectall.enabled = lb_desired				
			end if
		end if

	end if
end if





//set the vars to be returned
ab_isCopyable = lm_dw.m_table.m_copy.enabled
ab_isCutable = lm_dw.m_table.m_cut.enabled
ab_isPasteable = lm_dw.m_table.m_paste.enabled
ab_isSelectallable = lm_dw.m_table.m_selectall.enabled
destroy lm_dw

return 1

end function

event constructor;This.of_SetInsertable ( FALSE )
This.of_SetDeleteable ( FALSE )
end event

on u_dw_companyedit.create
end on

on u_dw_companyedit.destroy
end on

