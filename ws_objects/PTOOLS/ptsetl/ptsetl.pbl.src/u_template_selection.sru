$PBExportHeader$u_template_selection.sru
forward
global type u_template_selection from u_base
end type
type st_templates from statictext within u_template_selection
end type
type st_add from statictext within u_template_selection
end type
type st_remove from statictext within u_template_selection
end type
type st_double from statictext within u_template_selection
end type
type cbx_filtered from checkbox within u_template_selection
end type
type cbx_globals from checkbox within u_template_selection
end type
type st_selected from statictext within u_template_selection
end type
type rb_manual from radiobutton within u_template_selection
end type
type rb_auto from radiobutton within u_template_selection
end type
type dw_templatetype from datawindow within u_template_selection
end type
type st_2 from statictext within u_template_selection
end type
type dw_available from u_dw within u_template_selection
end type
type dw_selected from u_dw within u_template_selection
end type
type gb_1 from groupbox within u_template_selection
end type
type dw_manual from u_dw within u_template_selection
end type
end forward

global type u_template_selection from u_base
integer width = 3598
integer height = 608
boolean border = true
long backcolor = 12632256
long tabbackcolor = 67108864
long picturemaskcolor = 536870912
event ue_selected ( )
event ue_addtemplate ( long al_id )
event ue_generate ( )
event ue_gotfocus ( string as_what )
st_templates st_templates
st_add st_add
st_remove st_remove
st_double st_double
cbx_filtered cbx_filtered
cbx_globals cbx_globals
st_selected st_selected
rb_manual rb_manual
rb_auto rb_auto
dw_templatetype dw_templatetype
st_2 st_2
dw_available dw_available
dw_selected dw_selected
gb_1 gb_1
dw_manual dw_manual
end type
global u_template_selection u_template_selection

type variables
Private:
long	il_Entityid
string	is_OriginalTemplateSQL
string	is_InList
string	is_TemplateTypeFilter
long	il_DisplayType
u_dw	idw_GlobalTemplates
boolean	ib_DateRangeSelected
end variables

forward prototypes
public subroutine of_initialize ()
public subroutine of_disablecontrols ()
public subroutine of_enablecontrols ()
public function long of_getentityid ()
public subroutine of_setentityid (long al_Entity)
public function integer of_getdisplaytype ()
public function string of_getinlist ()
public subroutine of_setinlist (string as_Inlist)
public subroutine of_settemplatefilter (boolean ab_filter)
public function long of_getselectedtemplate (ref long ala_id[])
public function boolean of_isautooptionselected ()
public function boolean of_ismanualoptionselected ()
public function decimal of_getmanualamount ()
public function integer of_getmanualamounttype ()
public function boolean of_getmanualamounttaxable ()
public subroutine of_resetmanualoptions ()
private subroutine of_filteravailabletemplates ()
public function long of_getselectedselectionfilter (ref string asa_expression[])
public function boolean of_isdaterangeselected ()
public subroutine of_setdisplaylist (string as_valuellist)
public subroutine of_setdisplaytype (integer ai_type)
public function long of_getavailableid (ref long ala_ids[], boolean ab_includefiltered)
public function long of_getavailableselectionfilter (ref string asa_expression[], ref long ala_id[], boolean ab_includefiltered)
public subroutine of_resetselected ()
public function string of_getdisplayfilter ()
public subroutine of_setdaterangeselected (boolean ab_daterange)
end prototypes

event ue_addtemplate(long al_id);this.dw_available.SelectRow(al_id,TRUE)
this.st_add.TriggerEvent(clicked!)

end event

public subroutine of_initialize ();string	ls_Sql, &
			ls_ModString, &
			ls_rc
			
long		ll_Entity			

//modify where clause for entity Id
ll_Entity = this.of_GetEntityId (  )
//IF ll_Entity = 0 THEN		//~~"amounttemplate~~".~~"fkentity~~"
//	ls_sql = 'where fkentity = NULL or fkentity = 0'
//	dw_available.object.datawindow.table.select = is_OriginalTemplateSQL + ls_sql
//ELSE
//	ls_sql = 'where fkentity = ' + string ( ll_Entity ) + ' OR fkentity is null'
//	dw_available.object.datawindow.table.select = is_OriginalTemplateSQL + ls_sql
//END IF

dw_available.Retrieve(ll_Entity)
dw_available.SetFilter("isNull( id )" )
dw_available.Filter()
cbx_filtered.checked=true
cbx_filtered.triggerevent(clicked!)
//cbx is unchecked on open and will only be check/unchecked by user
//cbx_globals.checked=false
cbx_globals.triggerevent(clicked!)
dw_templatetype.InsertRow(0)
dw_templatetype.object.amounttemplate_type[1] = 0
dw_selected.Reset ( )
rb_auto.checked=false
rb_manual.checked=true
rb_manual.triggerevent(clicked!)



end subroutine

public subroutine of_disablecontrols ();long	ll_ColCount, &
		ll_Ndx
		
st_double.visible = FALSE
st_add.visible = FALSE
st_remove.visible = FALSE
dw_manual.enabled = FALSE
cbx_filtered.enabled = FALSE
cbx_globals.enabled = FALSE
rb_auto.enabled = FALSE
rb_manual.enabled = FALSE

dw_templatetype.enabled = FALSE
dw_templatetype.Object.DataWindow.Color = RGB(192,192,192)

dw_available.enabled = FALSE
dw_available.Object.DataWindow.Color = RGB(192,192,192)

dw_selected.enabled = FALSE
dw_selected.Object.DataWindow.Color = RGB(192,192,192)
end subroutine

public subroutine of_enablecontrols ();long	ll_ColCount, &
		ll_Ndx
		
st_double.visible = TRUE
st_add.visible = TRUE
st_remove.visible = TRUE
dw_manual.enabled = TRUE
cbx_filtered.enabled = TRUE
cbx_globals.enabled = TRUE
rb_auto.enabled = TRUE
rb_manual.enabled = TRUE

dw_templatetype.enabled = TRUE

dw_available.enabled = TRUE
dw_available.Object.DataWindow.Color = RGB(255,255,255)

dw_selected.enabled = TRUE
dw_available.Object.DataWindow.Color = RGB(255,255,255)

dw_available.SetFocus ( )
end subroutine

public function long of_getentityid ();return il_entityid
end function

public subroutine of_setentityid (long al_Entity);il_entityid = al_entity
end subroutine

public function integer of_getdisplaytype ();return il_DisplayType
end function

public function string of_getinlist ();return is_inlist
end function

public subroutine of_setinlist (string as_Inlist);is_inlist = as_Inlist
end subroutine

public subroutine of_settemplatefilter (boolean ab_filter);integer	li_DisplayType

string	ls_InList, &
			ls_Filter

li_DisplayType = this.of_GetDisplayType()
ls_InList = this.of_GetInList()

IF ab_filter THEN
	IF li_DisplayType = 0 THEN
		IF len(ls_InList) > 0 THEN 
			ls_Filter =  'id in (' + ls_InList + ')' 
		ELSE
			ls_Filter = ""
		END IF 
		dw_available.SetFilter (ls_Filter)
	ELSE
		IF len(ls_InList) > 0 THEN 
			ls_Filter =  'type = ' + string ( li_DisplayType )  + ' and id in (' + ls_InList + ')' 
		ELSE
			ls_Filter = 'type = ' + string ( li_DisplayType ) 
		END IF
	END IF
ELSE
	IF isnull(li_DisplayType ) THEN
		ls_Filter = 'type > 0 ' 	
	ELSE
		ls_Filter = 'type = ' + string ( li_DisplayType ) 
	END IF
END IF

is_TemplateTypeFilter = ls_Filter	
if cbx_globals.Checked = false then
	if len(ls_Filter) > 0 then
		if cbx_filtered.Checked then
			ls_Filter += " and "
		else
			ls_Filter += " or "
		end if
	end if
	ls_Filter += 'NOT isnull( fkentity )'
end if
dw_available.SetFilter (ls_Filter)
dw_available.Filter()
IF dw_Available.RowCount() > 0 THEN
	rb_auto.TriggerEvent(clicked!)
else
	cbx_filtered.checked=false
	cbx_filtered.event clicked()
	cbx_globals.checked=true
	cbx_globals.event clicked()
END IF

dw_available.scrolltorow(1)
dw_available.selectrow(0, false)
dw_available.selectrow(1, true)
dw_available.setfocus()

end subroutine

public function long of_getselectedtemplate (ref long ala_id[]);long	ll_SelectedTemplateCount, &
		ll_Ndx

ll_SelectedTemplateCount = dw_selected.RowCount()

FOR ll_Ndx = 1 to ll_SelectedTemplateCount
	
	ala_id[ll_Ndx] = dw_selected.object.id[ll_Ndx]

NEXT

return ll_SelectedTemplateCount
end function

public function boolean of_isautooptionselected ();return rb_auto.checked
end function

public function boolean of_ismanualoptionselected ();return rb_manual.checked
end function

public function decimal of_getmanualamount ();decimal	lc_Amount

IF dw_manual.RowCount() > 0 THEN
	lc_Amount =  dw_manual.object.manual_amount[1]
ELSE
	lc_Amount = 0
END IF

return lc_Amount
end function

public function integer of_getmanualamounttype ();integer li_Type

setnull(li_Type)
IF dw_Manual.RowCount() > 0 THEN
	li_Type = dw_manual.object.amounttype[1]
END IF

return li_Type
	
end function

public function boolean of_getmanualamounttaxable ();boolean	lb_Taxable
IF dw_Manual.RowCount() > 0 THEN
	IF dw_manual.object.taxable[1] = 1 THEN
		lb_Taxable = TRUE
	ELSE
		lb_Taxable = FALSE
	END IF
END IF

return lb_Taxable
end function

public subroutine of_resetmanualoptions ();dw_manual.RESET()
dw_manual.Insertrow(0)
end subroutine

private subroutine of_filteravailabletemplates ();IF cbx_filtered.checked THEN
	
END IF
IF cbx_globals.checked THEN
	
END IF
end subroutine

public function long of_getselectedselectionfilter (ref string asa_expression[]);string	lsa_Expression[], &
			ls_SelectionFilter

long		ll_SelectedCount, &
			ll_Ndx, &
			ll_ExpressionCount
			
ll_SelectedCount = 	dw_selected.RowCount()

FOR ll_Ndx = 1 to ll_SelectedCount
	ls_SelectionFilter = dw_selected.object.SelectionFilter[ll_Ndx]
	IF Len ( Trim ( ls_SelectionFilter ) ) > 0 THEN
		ll_ExpressionCount ++
		lsa_Expression[ll_ExpressionCount] = ls_SelectionFilter
	END IF
NEXT

IF ll_ExpressionCount > 0 THEN
	asa_expression = lsa_Expression
END IF

return ll_ExpressionCount
end function

public function boolean of_isdaterangeselected ();return ib_DateRangeSelected
end function

public subroutine of_setdisplaylist (string as_valuellist);integer	li_Count, &
			li_Index
			
string	lsa_Settings[], &
			ls_Return


lsa_Settings = { "Edit.CodeTable = Yes", as_valuellist, "ddlb.UseAsBorder = No", "ddlb.Sorted = Yes", "ddlb.VScrollBar = Yes" }

li_Count = UpperBound ( lsa_Settings )
	
FOR li_Index = 1 TO li_Count

	ls_Return = dw_templatetype.Modify ( "amounttemplate_type" + "." + lsa_Settings [ li_Index ] )
	
NEXT

end subroutine

public subroutine of_setdisplaytype (integer ai_type);il_displaytype = ai_type
dw_templatetype.object.amounttemplate_type[1] = ai_type
end subroutine

public function long of_getavailableid (ref long ala_ids[], boolean ab_includefiltered);//Get ID's from templates which have selectionfilter criteria

long	lla_id[], &
		ll_RowCount, &
		ll_FilteredCount, &
		ll_Ndx, &
		ll_IdCount
		
string	ls_SelectionFilter 		
		
ll_RowCount = dw_available.RowCount()

FOR ll_Ndx = 1 to ll_RowCount

	ls_SelectionFilter = dw_Available.object.SelectionFilter.Primary[ll_Ndx]
	IF Len ( Trim ( ls_SelectionFilter ) ) > 0 THEN
		ll_IdCount ++
		lla_Id[ll_IdCount] = dw_available.object.id.Primary[ll_Ndx]
	END IF
	
NEXT

IF ab_IncludeFiltered THEN
	ll_FilteredCount = dw_available.FilteredCount()
	
	FOR ll_Ndx = 1 to ll_FilteredCount
		ls_SelectionFilter = dw_Available.object.SelectionFilter.Filter[ll_Ndx]
		IF Len ( Trim ( ls_SelectionFilter ) ) > 0 THEN
			ll_IdCount ++
			lla_Id[ll_IdCount] = dw_available.object.id.Filter[ll_Ndx]
		END IF
	NEXT
	
END IF

ala_ids = lla_Id

Return ll_IdCount

end function

public function long of_getavailableselectionfilter (ref string asa_expression[], ref long ala_id[], boolean ab_includefiltered);string	lsa_Expression[], &
			ls_SelectionFilter

long		ll_AvailableCount, &
			ll_FilteredCount, &
			ll_Ndx, &
			ll_ExpressionCount, &
			lla_Id[]
			
ll_AvailableCount = 	dw_available.RowCount()

FOR ll_Ndx = 1 to ll_AvailableCount
	//primary buffer template
	ls_SelectionFilter = dw_Available.object.SelectionFilter.Primary[ll_Ndx]
	IF Len ( Trim ( ls_SelectionFilter ) ) > 0 THEN
		ll_ExpressionCount ++
		lsa_Expression[ll_ExpressionCount] = ls_SelectionFilter
		lla_Id[ll_ExpressionCount] = dw_Available.object.id.Primary[ll_Ndx]
	END IF

NEXT

IF ab_IncludeFiltered THEN
	ll_FilteredCount = dw_available.filteredcount()

	FOR ll_Ndx = 1 to ll_FilteredCount
		//previously filtered out templates
		ls_SelectionFilter = dw_Available.object.SelectionFilter.Filter[ll_Ndx]
		IF Len ( Trim ( ls_SelectionFilter ) ) > 0 THEN
			ll_ExpressionCount ++
			lsa_Expression[ll_ExpressionCount] = ls_SelectionFilter
			lla_Id[ll_ExpressionCount] = dw_Available.object.id.Filter[ll_Ndx]
		END IF
	NEXT
	
END IF

IF ll_ExpressionCount > 0 THEN
	asa_expression = lsa_Expression
	ala_Id = lla_Id
END IF

return ll_ExpressionCount
end function

public subroutine of_resetselected ();/*
	This will remove all the selected templates and put them back in the
	available list. Then set and highlight the first row in the available list.
*/

this.dw_selected.SelectRow(0,TRUE)
this.st_remove.TriggerEvent(clicked!)


end subroutine

public function string of_getdisplayfilter ();return is_templatetypefilter
end function

public subroutine of_setdaterangeselected (boolean ab_daterange);ib_daterangeselected = ab_daterange
end subroutine

on u_template_selection.create
int iCurrent
call super::create
this.st_templates=create st_templates
this.st_add=create st_add
this.st_remove=create st_remove
this.st_double=create st_double
this.cbx_filtered=create cbx_filtered
this.cbx_globals=create cbx_globals
this.st_selected=create st_selected
this.rb_manual=create rb_manual
this.rb_auto=create rb_auto
this.dw_templatetype=create dw_templatetype
this.st_2=create st_2
this.dw_available=create dw_available
this.dw_selected=create dw_selected
this.gb_1=create gb_1
this.dw_manual=create dw_manual
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_templates
this.Control[iCurrent+2]=this.st_add
this.Control[iCurrent+3]=this.st_remove
this.Control[iCurrent+4]=this.st_double
this.Control[iCurrent+5]=this.cbx_filtered
this.Control[iCurrent+6]=this.cbx_globals
this.Control[iCurrent+7]=this.st_selected
this.Control[iCurrent+8]=this.rb_manual
this.Control[iCurrent+9]=this.rb_auto
this.Control[iCurrent+10]=this.dw_templatetype
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.dw_available
this.Control[iCurrent+13]=this.dw_selected
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.dw_manual
end on

on u_template_selection.destroy
call super::destroy
destroy(this.st_templates)
destroy(this.st_add)
destroy(this.st_remove)
destroy(this.st_double)
destroy(this.cbx_filtered)
destroy(this.cbx_globals)
destroy(this.st_selected)
destroy(this.rb_manual)
destroy(this.rb_auto)
destroy(this.dw_templatetype)
destroy(this.st_2)
destroy(this.dw_available)
destroy(this.dw_selected)
destroy(this.gb_1)
destroy(this.dw_manual)
end on

event constructor;//string ls_dwsyntax
//
//ls_dwsyntax = 'release 6;' +&
//'datawindow(units=0 timer_interval=0 color=12632256 processing=0 print.documentname="" print.orientation = 0 print.margin.left = 110 print.margin.right = 110 print.margin.top = 96 print.margin.bottom = 96 print.paper.source = 0 print.paper.size = 0 print.prompt=no print.buttons=no print.preview.buttons=no )' +&
//'summary(height=0 color="536870912" )' +&
//'footer(height=0 color="536870912" )' +&
//'detail(height=92 color="536870912" )' +&
//'table(column=(type=decimal(2) updatewhereclause=yes name=manual_amount dbname="manual_amount" )' +&
//' )' +&
//'column(band=detail id=1 alignment="1" tabsequence=10 border="5" color="0" x="9" y="8" height="64" width="288" format="###,##0.00"  name=manual_amount edit.limit=9 edit.case=any edit.focusrectangle=no edit.autoselect=yes  font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )' +&
//'htmltable(border="1" cellpadding="0" cellspacing="0" generatecss="no" nowrap="yes") '
//
//dw_manual.Create ( ls_dwsyntax )
datawindowchild	ldwc_amounttype

dw_Manual.GetChild ( "amounttype", ldwc_AmountType )
ldwc_AmountType.SetTransObject(SQLCA)
ldwc_AmountType.Retrieve ( )
dw_manual.InsertRow(0)

dw_manual.BringtoTop =true

of_SetResize(TRUE)
inv_resize.of_Register (gb_1, 'FixedToRight')
inv_resize.of_Register (dw_manual, 'FixedToRight')
inv_resize.of_Register (dw_selected, 'FixedToRight')
inv_resize.of_Register (rb_manual, 'FixedToRight')
inv_resize.of_Register (rb_auto, 'FixedToRight')
inv_Resize.of_Register (st_selected, 'FixedToRight')
inv_resize.of_Register (dw_available, 'ScaleToRight')

if gnv_App.of_GetrestrictedView ( ) then
	inv_resize.of_Register (st_double, 'FixedToRight')
	inv_resize.of_Register (st_add, 'FixedToRight')
	inv_resize.of_Register (st_remove, 'FixedToRight')
end if


end event

type st_templates from statictext within u_template_selection
integer x = 2373
integer y = 404
integer width = 297
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Templates"
boolean focusrectangle = false
end type

event constructor;if gnv_App.of_GetrestrictedView ( ) then
	//ok
else
	this.y=28
	this.x=3200
end if

end event

type st_add from statictext within u_template_selection
integer x = 2373
integer y = 256
integer width = 169
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "to Add"
boolean focusrectangle = false
end type

event clicked;long	lla_Selected[], &
		ll_SelectedRowCount, &
		ll_RowNdx, &
		ll_RowCount, &
		ll_SelectedRow, &
		ll_return = 1
		
lla_Selected = dw_available.object.id.selected
ll_SelectedRowCount = upperbound ( lla_Selected )
ll_RowCount = dw_available.RowCount()
IF ll_SelectedRowCount > 0 THEN

	FOR ll_RowNdx = 1 to ll_SelectedRowCount
	
		ll_SelectedRow = dw_available.Find ( "id = " + String ( lla_Selected [ll_RowNdx] ), 1, ll_RowCount )

		IF ll_SelectedRow > 0 THEN
			if dw_available.object.type[ll_SelectedRow] = 3 then
				//move template can't be used with other templates
				if dw_selected.rowcount() > 0 then
					messagebox('Select Template', "A 'MOVE' type template can't be used with other template types.")
					ll_return = -1
					exit
				else
					if ll_SelectedRowCount > 1 then
						//a move was selcted with other templates
						messagebox('Select Template', "A 'MOVE' type template can't be used with other template types.")
						ll_return = -1
						exit
					end if
				end if	
			end if
			
			dw_available.RowsMove ( ll_SelectedRow, ll_SelectedRow, Primary!, dw_selected, dw_selected.RowCount() + 1 , Primary! )

		END IF				
		
	NEXT
	
END IF

if ll_return = 1 then
	rb_auto.TriggerEvent(Clicked!)
	parent.triggerevent ( "ue_Selected" )
end if

return ll_return
end event

event constructor;if gnv_App.of_GetrestrictedView ( ) then
	//ok
else
	this.y=28
	this.x=2734	
end if

end event

type st_remove from statictext within u_template_selection
integer x = 2373
integer y = 328
integer width = 297
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "or Remove"
boolean focusrectangle = false
end type

event clicked;long	lla_Selected[], &
		ll_SelectedRowCount, &
		ll_RowNdx, &
		ll_RowCount, &
		ll_SelectedRow
		
lla_Selected = dw_selected.object.id.selected
ll_SelectedRowCount = upperbound ( lla_Selected )
ll_RowCount = dw_selected.RowCount()

IF ll_SelectedRowCount > 0 THEN

	FOR ll_RowNdx = 1 to ll_SelectedRowCount
	
		ll_SelectedRow = dw_selected.Find ( "id = " + String ( lla_Selected [ll_RowNdx] ), 1, ll_RowCount )

		IF ll_SelectedRow > 0 THEN
			dw_selected.RowsMove ( ll_SelectedRow, ll_SelectedRow, Primary!, dw_available, dw_available.RowCount() + 1 , Primary! )	
		END IF				
		
	NEXT
	
END IF
parent.triggerevent ( "ue_Selected" )
parent.setredraw(false)
dw_available.sort( )
parent.Setredraw(true)
if dw_selected.rowcount() > 0 then
	dw_selected.SelectRow(1, TRUE)
	dw_selected.SetFocus ( )
else
	dw_available.SelectRow(0, FALSE)
	dw_available.SelectRow(1, TRUE)
	dw_available.Setfocus()
end if
end event

event constructor;if gnv_App.of_GetrestrictedView ( ) then
	//ok
else
	this.y=28
	this.x=2907
end if

end event

type st_double from statictext within u_template_selection
integer x = 2373
integer y = 180
integer width = 320
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Double click"
boolean focusrectangle = false
end type

event clicked;if gnv_App.of_GetrestrictedView ( ) then
	//ok
else
	this.y=28
	this.x=2414	
end if

end event

event constructor;if gnv_App.of_GetrestrictedView ( ) then
	//ok
else
	this.y=28
	this.x=2414
end if

end event

type cbx_filtered from checkbox within u_template_selection
integer x = 2030
integer y = 24
integer width = 297
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Filtere&d"
boolean checked = true
end type

event clicked;string	ls_Filter, &
			ls_GlobalFilter = 'isnull( fkentity )'

//if dw_available.rowcount() > 0 then
if this.enabled = true then
	IF this.checked THEN
		ls_Filter = is_templatetypefilter 
		IF cbx_globals.Checked THEN
//			ls_Filter += " or " + ls_GlobalFilter
		ELSE
			ls_Filter += " and NOT " + ls_GlobalFilter
		END IF
	
	ELSE
	
		IF il_DisplayType = 0 THEN
			IF cbx_globals.Checked THEN
				ls_Filter = ""
			ELSE
				ls_Filter = 'NOT isnull( fkentity )'
			END IF
		ELSE
			ls_Filter = "(" + is_templatetypefilter + " or " + "type = " + string(il_DisplayType) + ")" 
			IF cbx_globals.Checked THEN
//				ls_Filter += " or " + ls_GlobalFilter
			ELSE
				ls_Filter += " and NOT " + ls_GlobalFilter
			END IF
		END IF
	
	END IF
	
	dw_available.SetFilter(ls_Filter)
	dw_available.Filter()
	dw_available.selectrow(0, false)
end if
end event

type cbx_globals from checkbox within u_template_selection
integer x = 1563
integer y = 24
integer width = 475
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Show Gl&obals"
end type

event clicked;string	ls_FilteredTemplates = "not isNull( type )" , &
			ls_Filter

//if dw_available.rowcount() > 0 then
//
	IF this.checked THEN
		IF cbx_filtered.Checked THEN
			if len(trim(is_TemplateTypeFilter)) > 0 then
				IF il_DisplayType = 0 THEN
					ls_Filter = "(" + is_templatetypefilter + ")"
				ELSE
					ls_Filter = "(" + is_templatetypefilter +  ")" 
				END IF
			else
//				ls_filter = ""
			end if

		ELSE	
			IF il_DisplayType = 0 THEN
				ls_Filter = ""
			ELSE
				if len(trim(is_TemplateTypeFilter)) > 0 then
					ls_Filter = "(" + is_templatetypefilter + " or " + "type = " + string(il_DisplayType) + ") or ( " + is_templatetypefilter +' and isnull( fkentity ))'
				else
//					ls_Filter = ""
				end if
			END IF
		END IF
		
	ELSE
		//	"entity"
		IF cbx_filtered.Checked THEN
			if len(trim(is_TemplateTypeFilter)) > 0 then	
				IF il_DisplayType = 0 THEN
					ls_Filter = "(" + is_templatetypefilter + " or " + "type = " + string(il_DisplayType) + ")" + ' and NOT isnull( fkentity )'
				ELSE
					ls_Filter = is_templatetypefilter + ' and NOT isnull( fkentity )'
				END IF	
			else
//				ls_filter = ''
			end if
		ELSE
			IF il_DisplayType = 0 THEN
				ls_Filter = 'NOT isnull( fkentity )'
			ELSE
				if len(trim(is_TemplateTypeFilter)) > 0 then	
					ls_Filter = "(" + is_templatetypefilter + " or " + "type = " + string(il_DisplayType) + ")" + ' and NOT isnull( fkentity )'		
				else
//					ls_filter=''
				end if
			END IF	
		END IF
	END IF
	
	if (len(trim(ls_filter)) = 0 and dw_available.rowcount() = 0) and cbx_filtered.checked then
			//don't do
	else
		dw_available.SetFilter(ls_Filter)
		dw_available.Filter()
		dw_available.selectrow(0, false)
	end if
//end if



end event

type st_selected from statictext within u_template_selection
integer x = 2743
integer y = 188
integer width = 631
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "&Selected Templates"
boolean focusrectangle = false
end type

type rb_manual from radiobutton within u_template_selection
integer x = 2958
integer y = 104
integer width = 288
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Manual"
boolean checked = true
boolean automatic = false
end type

event clicked;this.checked = TRUE
rb_auto.checked = FALSE
dw_manual.InsertRow(0)
dw_manual.visible = TRUE
dw_selected.visible = FALSE
st_selected.visible = FALSE
dw_selected.Object.DataWindow.Color = RGB(192,192,192)
end event

type rb_auto from radiobutton within u_template_selection
integer x = 2725
integer y = 104
integer width = 247
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "A&uto"
boolean automatic = false
end type

event clicked;this.checked = TRUE
rb_manual.checked = FALSE
dw_manual.visible = FALSE
dw_Manual.Reset ( )
dw_selected.visible = TRUE
st_selected.visible = TRUE
dw_selected.Object.DataWindow.Color = RGB(255,255,255)


end event

type dw_templatetype from datawindow within u_template_selection
integer x = 613
integer y = 8
integer width = 919
integer height = 96
boolean bringtotop = true
string dataobject = "d_amounttemplatetype"
boolean border = false
boolean livescroll = true
end type

event constructor;integer	li_Count, &
			li_Index
			
string	ls_ValueList, &
			lsa_Settings[], &
			ls_Return


//ls_ValueList =  "Values = '" + appeon_constant.cs_type_ValueList + "[ALL]~t0/" + "'" 

ls_ValueList = "Values = '" + & 
	"[ALL]~t" + string(appeon_constant.ci_Type_All) + "/" +&
	"POINT-TO-POINT~t" + string(appeon_constant.ci_Type_Point_to_point) + "/" + &
	"SHIPMENT~t" + string(appeon_constant.ci_Type_Shipment) + "/" + &
	"MOVE~t" + string(appeon_constant.ci_Type_Move) + "/" + 	"'" 
	
lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.Sorted = Yes", "ddlb.VScrollBar = Yes" }

li_Count = UpperBound ( lsa_Settings )
	
FOR li_Index = 1 TO li_Count

	ls_Return = this.Modify ( "amounttemplate_type" + "." + lsa_Settings [ li_Index ] )
	
NEXT

end event

event itemchanged;string	ls_Filter, &
			ls_column, &
			ls_CurrentFilter, &
			ls_GlobalFilter

ls_GlobalFilter = 'isnull( fkentity ))'

ls_column = dwo.name

choose case ls_column
		
CASE "amounttemplate_type"
	
	ls_CurrentFilter = this.object.datawindow.table.filter 
	
	IF long(data) = 0 THEN
		
		is_TemplateTypeFilter = "id in (" + is_InList + ")"
	
	ELSE
		is_TemplateTypeFilter = "type = " + data + " and id in (" + is_InList + ")"
		
	END IF
	
	IF integer ( data ) = appeon_constant.ci_Type_DateRange THEN
		IF dw_selected.RowCount() > 0 THEN
			messagebox("Display Type", "Other template types cannot be selected with this type.  " + & 
			"The selected list will be cleared.")
			dw_selected.Reset()
		END IF
		cbx_filtered.Checked = FALSE
		ib_daterangeselected = TRUE
	ELSE
		ib_daterangeselected = FALSE
	END IF
	
	IF cbx_globals.Checked THEN
		IF cbx_filtered.Checked THEN
			ls_Filter = "(" + is_templatetypefilter + ")" + "and isnull( fkentity )"//" or " + ls_GlobalFilter
		ELSE
			IF long ( data ) = 0 THEN
				ls_Filter = ""
			ELSE
				ls_Filter = "( ( (" + is_templatetypefilter + " ) or type = " + data + ') and isnull( fkentity ) )'
//				ls_Filter = "( ( (" + is_templatetypefilter + " ) or type = " + data + ") and not isnull(fkentity) )" + " or ( " + ls_GlobalFilter 
			END IF
		END IF
	ELSE
		IF cbx_filtered.Checked THEN
			ls_Filter = is_templatetypefilter + " and NOT isnull(fkentity)"
			
		ELSE
			IF long ( data ) = 0 THEN
				ls_Filter = "((" + is_templatetypefilter + ' ) and not isnull( fkentity )) or not isnull( fkentity )'
//				ls_Filter = "(" + is_templatetypefilter + " ) or not isnull(fkentity) "			
			ELSE
				ls_Filter = "( (" + is_templatetypefilter + " ) or type = " + data + ' ) and not isnull( fkentity ) '
			END IF
		END IF 
	END IF
		
	dw_available.SetFilter(ls_Filter)
	dw_available.Filter()
	
	il_DisplayType = integer ( data )
	
END CHOOSE


end event

type st_2 from statictext within u_template_selection
integer x = 32
integer y = 20
integer width = 530
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "A&vailable Templates"
boolean focusrectangle = false
end type

type dw_available from u_dw within u_template_selection
event ue_processkey pbm_dwnkey
integer x = 27
integer y = 112
integer width = 2341
integer height = 460
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_amounttemplate"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = styleraised!
end type

event ue_processkey;Long		ll_Return

CHOOSE CASE Key 
	CASE keyapps!	

	CASE keydownarrow! , keypagedown! , keyuparrow! , keypageup!
		
	CASE keytab!
		
	CASE keyenter!
		
		if this.GetSelectedrow(0) > 0 then
			if st_add.event clicked() = -1 then
				//don't move
				long	ll_row
				
				ll_row = this.getrow()
				if ll_row > 0 then 
					//ok
				else
					ll_row = 1
				end if
				
				this.post selectrow(0, false)
				this.post selectrow(ll_row, true)
				
			else
				dw_selected.setfocus()
				this.post selectrow(0, false)
			end if
		end if
		
	CASE ELSE

			
END CHOOSE

RETURN ll_Return 

end event

event constructor;// enable multi-row-select-ability
THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (2) //2 = extended row select service

of_setinsertable ( FALSE )
of_setDeleteable ( FALSE )

of_SetAutoSort ( FALSE )

THIS.SetTransObject (  sqlca ) 
is_OriginalTemplateSQL = this.Describe("DataWindow.Table.Select")

//set presentation
string	ls_ValueList, &
			lsa_Settings[]

integer	li_Count,&
			li_Index
			
ls_ValueList = appeon_constant.cs_type_ValueList
			
ls_ValueList = "Values = '" + ls_ValueList + "'"		
		
lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No" }

li_Count = UpperBound ( lsa_Settings )
	
FOR li_Index = 1 TO li_Count

	THIS.Dynamic Modify ( "type." + lsa_Settings [ li_Index ] )

NEXT
n_cst_Presentation_AmountTemplate	lnv_Presentation
n_cst_presentation_amounttype lnv_presentationamounttype

lnv_Presentation.of_setpresentation(this)

lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_payables)
lnv_presentationamounttype.of_setpresentation(this)


//CASE "amounttemplate_amounttypeid"
//	IF This.of_GetCodeTable ( "n_cst_dlkc_amounttype", ls_ValueList ) < 1 THEN
//		li_Return = -1
//	END IF
//
//CASE  "amounttemplate_ratetypeid"
//	IF This.of_GetCodeTable ( "n_cst_dlkc_ratetype", ls_ValueList ) < 1 THEN
//		li_Return = -1
//	ELSE
//		ls_ValueList += "[NONE]~t0/"
//	END IF

			
end event

event getfocus;call super::getfocus;THIS.BORDERSTYLE=STYLELOWERED!
if this.getselectedrow(0) > 0 then
	//already selected
else
	long	ll_row
	
	ll_row = this.getrow()
	if ll_row > 0 then 
		//ok
	else
		ll_row = 1
	end if
	
	this.selectrow(ll_row, true)
	
end if

parent.event ue_gotfocus('AVAILABLE TEMPLATE')
end event

event losefocus;THIS.BORDERSTYLE=STYLERAISED!
this.selectrow(0, false)
end event

event doubleclicked;if st_add.event clicked() = 1 then
	long	ll_row
	
	ll_row = this.getrow()
	if ll_row > 0 then 
		//ok
	else
		ll_row = 1
	end if
	
	this.selectrow(ll_row, true)
end if

end event

type dw_selected from u_dw within u_template_selection
event ue_processkey pbm_dwnkey
integer x = 2743
integer y = 260
integer width = 791
integer height = 292
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_amounttemplateselected"
borderstyle borderstyle = styleraised!
end type

event ue_processkey;Long		ll_Return

CHOOSE CASE Key 
	CASE keyapps!	

	CASE keydownarrow! , keypagedown! , keyuparrow! , keypageup!
		
	CASE keytab!
		
	CASE keyenter!
		
		if this.GetSelectedrow(0) > 0 then
			parent.event ue_generate()
		end if
		
	CASE ELSE

			
END CHOOSE

RETURN ll_Return 

end event

event constructor;// enable multi-row-select-ability
THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (2) //2 = extended row select service

of_setinsertable ( FALSE )
of_setDeleteable ( FALSE )

of_SetAutoSort ( FALSE )

THIS.SetTransObject (  sqlca ) 

end event

event getfocus;call super::getfocus;THIS.BORDERSTYLE=STYLELOWERED!
if this.getselectedrow(0) > 0 then
	//already selected
else
	long	ll_row
	
	ll_row = this.getrow()
	if ll_row > 0 then 
		//ok
	else
		ll_row = 1
	end if
	
	this.selectrow(ll_row, true)
	
end if
end event

event losefocus;THIS.BORDERSTYLE=STYLERAISED!
this.selectrow(0, false)
end event

event doubleclicked;st_remove.TriggerEvent(Clicked!)
end event

event rowfocuschanged;call super::rowfocuschanged;IF this.RowCount() > 0 THEN
	rb_auto.TriggerEvent(Clicked!)
ELSE
	rb_manual.TriggerEvent(Clicked!)
END IF

end event

type gb_1 from groupbox within u_template_selection
integer x = 2693
integer y = 32
integer width = 878
integer height = 540
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Generation Options"
end type

type dw_manual from u_dw within u_template_selection
integer x = 2715
integer y = 188
integer width = 846
integer height = 364
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_manualoptions"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;choose case dwo.name
		
	case "manual_amount"
		
		If len ( data ) > 0 then 
			parent.post triggerevent ("ue_Selected")
		END IF
		
end choose

end event

event constructor;n_cst_presentation_amounttype lnv_presentationamounttype
lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_payables)
lnv_presentationamounttype.of_setpresentation(this)

end event

