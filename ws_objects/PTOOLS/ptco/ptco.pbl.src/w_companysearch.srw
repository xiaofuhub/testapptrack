$PBExportHeader$w_companysearch.srw
forward
global type w_companysearch from w_sheet
end type
type dw_companies from u_dw_companyedit within w_companysearch
end type
type cb_reset from commandbutton within w_companysearch
end type
type cb_cancelquerymode from commandbutton within w_companysearch
end type
type cb_retrieve from commandbutton within w_companysearch
end type
type cb_save from u_cb_save within w_companysearch
end type
type cb_reactivate from commandbutton within w_companysearch
end type
type cb_querymode from commandbutton within w_companysearch
end type
end forward

global type w_companysearch from w_sheet
integer x = 214
integer y = 221
integer width = 2491
integer height = 1592
string title = "Company Search"
string menuname = "m_sheets"
event type integer ue_setquerymode ( boolean ab_switch )
dw_companies dw_companies
cb_reset cb_reset
cb_cancelquerymode cb_cancelquerymode
cb_retrieve cb_retrieve
cb_save cb_save
cb_reactivate cb_reactivate
cb_querymode cb_querymode
end type
global w_companysearch w_companysearch

type variables
Private n_cst_Toolmenu_Manager	inv_ToolmenuManager
private string		is_where

end variables

forward prototypes
public function integer wf_createtoolmenu ()
public subroutine wf_process_request (string as_request)
end prototypes

event ue_setquerymode;//Returns : 1, -1

Integer	li_Return = 1

IF NOT IsNull ( ab_Switch ) THEN

	IF NOT IsNull ( dw_Companies.inv_QueryMode ) THEN
		cb_QueryMode.Visible = NOT ab_Switch
		cb_Retrieve.Visible = ab_Switch
		IF ab_Switch THEN
			cb_Reset.Text = "R&eset Criteria"
		ELSE
			cb_Reset.Text = "R&eset Data"
		END IF
		cb_CancelQueryMode.Visible = ab_Switch
		dw_Companies.inv_QueryMode.of_SetEnabled ( ab_Switch )

		IF ab_Switch = TRUE THEN
			dw_Companies.SetRow ( 99 )
			dw_Companies.SetRow ( 1 )
		END IF

	ELSE
		li_Return = -1
	END IF

ELSE
	li_Return = -1

END IF

RETURN li_Return
end event

public function integer wf_createtoolmenu ();s_toolmenu lstr_toolmenu

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "SAVE!"
lstr_toolmenu.s_menuitem_text = "&Save~tCtrl+S"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1
end function

public subroutine wf_process_request (string as_request);CHOOSE CASE as_Request

CASE "SAVE!"
	This.PostEvent ( "pfc_Save" )

END CHOOSE
end subroutine

on w_companysearch.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_companies=create dw_companies
this.cb_reset=create cb_reset
this.cb_cancelquerymode=create cb_cancelquerymode
this.cb_retrieve=create cb_retrieve
this.cb_save=create cb_save
this.cb_reactivate=create cb_reactivate
this.cb_querymode=create cb_querymode
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_companies
this.Control[iCurrent+2]=this.cb_reset
this.Control[iCurrent+3]=this.cb_cancelquerymode
this.Control[iCurrent+4]=this.cb_retrieve
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_reactivate
this.Control[iCurrent+7]=this.cb_querymode
end on

on w_companysearch.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_companies)
destroy(this.cb_reset)
destroy(this.cb_cancelquerymode)
destroy(this.cb_retrieve)
destroy(this.cb_save)
destroy(this.cb_reactivate)
destroy(this.cb_querymode)
end on

event open;call super::open;gf_Mask_Menu ( m_Sheets )
wf_CreateToolmenu ( )

This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )

inv_Resize.of_SetMinSize ( 1300, 400 )
inv_Resize.of_Register ( dw_Companies, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( cb_Save, 'FixedToRight' )

n_cst_Privileges	lnv_Privileges

IF lnv_Privileges.of_HasSysAdminRights ( )  THEN
	cb_reactivate.visible=true
ELSE
	cb_reactivate.visible=false
END IF

is_where = dw_companies.getSqlselect( )
this.Event ue_SetQueryMode ( TRUE )
end event

event pfc_preclose;call super::pfc_preclose;Integer	li_Return

li_Return = AncestorReturnValue

IF AncestorReturnValue = 1 THEN

	IF IsValid ( dw_Companies.inv_QueryMode ) THEN
		IF dw_Companies.inv_QueryMode.of_GetEnabled ( ) = TRUE THEN
			//Doing this when query is NOT enabled discards untabbed changes.
			IF This.Event ue_SetQueryMode ( FALSE ) = 1 THEN
				//OK
			ELSE
				li_Return = -1
			END IF
		END IF
	END IF

END IF

RETURN li_Return
end event

event close;call super::close;//Extending ancestor

DESTROY inv_ToolmenuManager
RETURN AncestorReturnValue
end event

event pfc_save;//Overriding ancestor.  We need to make sure querymode is off before attempting save.

Integer	li_Return

IF IsValid ( dw_Companies.inv_QueryMode ) THEN
	IF dw_Companies.inv_QueryMode.of_GetEnabled ( ) = TRUE THEN
		//Doing this when query is NOT enabled discards untabbed changes.
		IF This.Event ue_SetQueryMode ( FALSE ) = 1 THEN
			//OK
		ELSE
			li_Return = -1  //Identify as an accepttext error, for lack of a better code.
		END IF
	END IF
END IF

li_Return = Super::Event pfc_Save ( )

RETURN li_Return
end event

type dw_companies from u_dw_companyedit within w_companysearch
integer x = 50
integer y = 184
integer width = 2359
integer height = 1160
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_company_grid"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
boolean ib_rmbmenu = false
end type

event constructor;String	lsa_QueryColumns[]
n_cst_Presentation_Company	lnv_Presentation

This.of_SetTransObject ( SQLCA )
lnv_Presentation.of_SetPresentation ( THIS )

This.of_SetQueryMode ( TRUE )
This.inv_QueryMode.of_SetResetCriteria ( FALSE ) //Do not clear criteria between toggles

This.of_SetBase ( TRUE )
inv_Base.of_GetObjects ( lsa_QueryColumns, "column", "detail", TRUE /*Not VisOnly*/ )
This.inv_QueryMode.of_SetQueryCols ( lsa_QueryColumns )

n_cst_Privileges	lnv_Privileges
//IF lnv_Privileges.of_HasSysAdminRights ( )  THEN
	//turn on row selection for reactivating companies
	THIS.of_SetRowSelect ( TRUE ) 
	inv_rowselect.of_SetStyle (1) 

//ELSE
//	inv_rowSelect.of_SetStyle(  )
//END IF
//
This.of_SetInsertable ( FALSE )
This.of_SetDeleteable ( FALSE )

This.SetSort ( "company_name A, company_status D" )

This.of_SetAutoFilter ( TRUE )
This.of_SetAutoSort ( TRUE )
This.of_SetAutoFind ( TRUE )


end event

event ue_autofilter;call super::ue_autofilter;//Extend ancestor code to use different options when autostarting
//AncestorReturnValue will be FAILURE or NO_ACTION if not autostarting

IF AncestorReturnValue = SUCCESS THEN

	inv_Filter.of_SetVisibleOnly ( TRUE )
	inv_Filter.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_ColumnName )

END IF

RETURN AncestorReturnValue
end event

event ue_autosort;call super::ue_autosort;//Extend ancestor code to use different options when autostarting
//AncestorReturnValue will be FAILURE or NO_ACTION if not autostarting

IF AncestorReturnValue = SUCCESS THEN

	inv_Sort.of_SetVisibleOnly ( TRUE )
	inv_Sort.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_ColumnName )

END IF

RETURN AncestorReturnValue
end event

event ue_autofind;call super::ue_autofind;//Extend ancestor code to use different options when autostarting
//AncestorReturnValue will be FAILURE or NO_ACTION if not autostarting

IF AncestorReturnValue = SUCCESS THEN

//	inv_Find.of_SetVisibleOnly ( TRUE )  Not supported for find
	inv_Find.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_ColumnName )

END IF

RETURN AncestorReturnValue
end event

event doubleclicked;Boolean	lb_PerformAction = TRUE
w_Company	lw_Co
IF IsValid ( dw_Companies.inv_QueryMode ) THEN
	IF dw_Companies.inv_QueryMode.of_GetEnabled ( ) = TRUE THEN
		lb_PerformAction = FALSE
	END IF
END IF

IF Row > 0 AND lb_PerformAction THEN

	long			ll_coid
//	n_cst_Msg	lnv_Msg
//	s_Parm		lstr_Parm
	
	ll_coid = dw_Companies.object.company_id[ row ]
	
	if row > 0 then
		
//		lstr_Parm.is_Label = "ID"
//		lstr_Parm.ia_Value = ll_coid
//		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
		//***modified 11-29-05 by Dan to open w_company instead of detail,  detail
		//		can still be reached from w_company.
		//OpenWithParm ( w_CompanyDetail, lnv_Msg )
		IF ll_CoID > 0 THEN
			OpenSheetWithParm ( lw_Co , ll_CoID ,gnv_App.of_GetFrame ( ) ,0, Original! )
		END IF
	end if
END IF


end event

event rbuttondown;//OVERIDES ANCESTOR
//11-30-05, The ib_rmbmenu no longer pops up for this datawindow, instead
//we took the menu options we liked and copied the functionality into this one.
//In addition to the ones we copied, there is now a print selected and export selected option.

String	lsa_parm_labels[]
Any		laa_parm_values[]

Int		li_length		
String		ls_result
String	ls_oldValue

Boolean	lb_copy
Boolean	lb_cut
Boolean	lb_paste
Boolean	lb_selectAll


this.of_getMenuEnabled( xpos, ypos, row, dwo, lb_copy, lb_cut, lb_paste, lb_selectall)

li_length =upperBound( lsa_parm_labels )
	
IF lb_cut THEN
	li_length ++
	lsa_parm_labels[li_length] = "ADD_ITEM"
	laa_parm_values[li_length] = "Cut"
END IF

IF lb_copy THEN
	li_length ++
	lsa_parm_labels[li_length] = "ADD_ITEM"
	laa_parm_values[li_length] = "Copy"
END IF



IF lb_paste THEN
	li_length ++
	lsa_parm_labels[li_length] = "ADD_ITEM"
	laa_parm_values[li_length] = "Paste"
END IF

IF lb_selectAll THEN
	li_length ++
	lsa_parm_labels[li_length] = "ADD_ITEM"
	laa_parm_values[li_length] = "Select All"
END IF

IF lb_copy OR lb_cut OR lb_paste OR lb_selectAll THEN
	li_length ++
	lsa_parm_labels[li_length] = "ADD_ITEM"
	laa_parm_values[li_length] = "-"
END IF


li_length ++
lsa_parm_labels[li_length] = "ADD_ITEM"
laa_parm_values[li_length] = "Sort..."



li_length ++
lsa_parm_labels[li_length] = "ADD_ITEM"
laa_parm_values[li_length] = "Filter..."



li_length ++
lsa_parm_labels[li_length] = "ADD_ITEM"
laa_parm_values[li_length] = "Find..."

li_length ++
lsa_parm_labels[li_length] = "ADD_ITEM"
laa_parm_values[li_length] = "Print..."

li_length ++
lsa_parm_labels[li_length] = "ADD_ITEM"
laa_parm_values[li_length] = "Export..."

li_length ++
lsa_parm_labels[li_length] = "ADD_ITEM"
laa_parm_values[li_length] = "-"

li_length ++
lsa_parm_labels[li_length] = "ADD_ITEM"
laa_parm_values[li_length] = "Print Selected"

li_length ++
lsa_parm_labels[li_length] = "ADD_ITEM"
laa_parm_values[li_length] = "Export Selected"



ls_result = f_pop_standard(lsa_parm_labels, laa_parm_values)
	
choose case ls_result
	case "SORT..."
		this.TriggerEvent( "pfc_sortdlg" )
	case	"FILTER..."
		this.TriggerEvent( "pfc_filterdlg" )
	case	"FIND..."
		this.TriggerEvent( "pfc_finddlg" )
	case	"PRINT..."
		this.TriggerEvent( "pfc_print" )
	case	"EXPORT..."
		this.TriggerEvent( "ue_Export" )
	case	"PRINT SELECTED"
		//prints only the selected rows
		ls_oldValue = this.object.datawindow.print.page.range
		this.object.datawindow.print.page.range = "selection"
		this.TriggerEvent( "pfc_print" )
		this.object.datawindow.print.page.range = ls_oldValue
	case	"EXPORT SELECTED"
		this.triggerEvent("ue_exportselected")
	case	"COPY"
		this.event pfc_copy()
	Case	"CUT"
		this.event pfc_cut()
	CASE	"PASTE"
		this.event pfc_paste()
	CASE	"SELECT ALL"
		this.event pfc_selectall()
end choose

	
	

end event

type cb_reset from commandbutton within w_companysearch
integer x = 782
integer y = 52
integer width = 681
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "R&eset Data"
end type

event clicked;IF dw_Companies.Object.DataWindow.QueryMode = "yes" THEN
	dw_Companies.Object.DataWindow.QueryClear = "yes"
ELSE
	dw_Companies.Reset ( )
END IF
end event

type cb_cancelquerymode from commandbutton within w_companysearch
boolean visible = false
integer x = 1513
integer y = 52
integer width = 681
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;Parent.Event ue_SetQueryMode ( FALSE )
end event

type cb_retrieve from commandbutton within w_companysearch
boolean visible = false
integer x = 50
integer y = 52
integer width = 681
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sea&rch"
end type

event clicked;Int	li_result
String	ls_where
li_result = dw_Companies.Event pfc_AcceptText (TRUE /*FocusOnError*/ )

IF  li_result = -1 THEN

ELSE
	ls_where = dw_companies.getSqlselect( )
	
	//here i compare the original sql statement with the current one to see if any data
	//was entered.  If there wasn't then we ask if they wish to continue.
	IF len( ls_where ) > len( is_where ) AND ls_where <> is_where THEN
		//nothing
	ELSE
		li_result = MessageBox( "Search","No criteria was entered, proceeding will retrieve everything. This could take a moment. Continue?", EXCLAMATION!, yesno! )
	END IF
	IF li_result = 1 THEN
		Parent.Event ue_SetQueryMode ( FALSE )
		dw_Companies.Retrieve ( )
	END IF
END IF 



end event

type cb_save from u_cb_save within w_companysearch
integer x = 2057
integer y = 52
integer height = 88
integer taborder = 70
boolean bringtotop = true
end type

type cb_reactivate from commandbutton within w_companysearch
integer x = 1513
integer y = 52
integer width = 453
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reacti&vate"
end type

event clicked;/*
	This will loop thru all of the selected companies, add them to an array 
	and change the status to active. Ask if the facilities should also be 
	reactivated.  If a selected company is a facility of another
	company then reactivate the parent company as well.
	
*/
long		ll_row, &
			ll_rowcount, &
			ll_SelectedCount, &
			lla_Selected[], &
			lla_company[], &
			ll_ndx, &
			ll_facilitycount, &
			ll_parent
			
String	ls_ids, &
			ls_original, &
			ls_sql, &
			ls_status, &
			ls_MessageHeader = "Reactivate Company"

boolean	lb_IncludeFacilities

n_cst_Privileges	lnv_Privileges
n_cst_string		lnv_string
n_cst_beo_company	lnv_company, &
						lnva_company[]

datastore	lds_Cache

lnv_company = create n_cst_beo_company

IF lnv_Privileges.of_HasSysAdminRights ( ) THEN
	
	if dw_companies.inv_rowselect.of_selectedcount(lla_Selected) > 0 then
		if MessageBox ( ls_MessageHeader, 'Would you like to also reactivate the facilities if there are any?',&
							Question!,YesNo!,1) = 1 then
			lb_IncludeFacilities = true
		else
			lb_IncludeFacilities = false
		end if
	end if
	
	ll_rowcount = upperbound(lla_Selected)
	
	for ll_row = 1 to ll_rowcount
		
		ls_status = dw_companies.object.company_status[lla_Selected[ll_row]]
		
		if upper(ls_status) = 'D' then
			ll_SelectedCount ++
			lla_company[ll_Selectedcount] = dw_companies.object.company_id[lla_Selected[ll_row]]
			//is company a facility
			gnv_cst_Companies.of_Cache ( lla_company[ll_Selectedcount], FALSE )
			lnv_Company.of_SetUseCache ( TRUE )
			lnv_Company.of_SetSourceId ( lla_company[ll_Selectedcount] )
			if isvalid(lnv_company) then
				ll_parent = lnv_company.of_GetFacilityof()
				if ll_parent > 0 then
					//add the parent to the list, the facility can't be accessed with a deleted parent
					ll_SelectedCount ++
					lla_company[ll_Selectedcount] = ll_parent
				end if
			end if
			
			if lb_IncludeFacilities then
				//add the facilities
				ll_facilitycount = gnv_cst_companies.of_getFacilities(lla_company[ll_SelectedCount],lnva_company)
				for ll_ndx = 1 to ll_FacilityCount
					ll_SelectedCount ++
					lla_company[ll_Selectedcount] = lnva_company[ll_ndx].of_GetId()
				next
				for ll_ndx = 1 to ll_FacilityCount
					destroy lnva_company[ll_ndx]
				next
			end if
		end if
		
	next
	
	if ll_SelectedCount > 0 then
		//proceed
		if messagebox(ls_MessageHeader, "Are you sure you want to reactivate the selected companies?  " +&
						"After the companies have been reactivated, it may be necessary to reenter the AR accounting Id, Codename and set Allow billing status.", &
			exclamation!, okcancel!, 2) = 1 then 
			
			lds_cache = create datastore
			lds_cache.dataobject = "d_company_list"
			lds_Cache.SetTransObject(SQLCA)
				
			lnv_String.	of_ArrayToString(lla_company,',',ls_ids)
			ls_original = lds_cache.Object.DataWindow.Table.Select
			ls_sql = ' WHERE companies.co_id IN (' +ls_ids+ ')'
			lds_cache.Object.DataWindow.Table.Select = ls_original + ls_sql
			ll_rowcount = lds_Cache.Retrieve(lla_company)

			for ll_ndx = 1 to ll_rowcount
				lds_Cache.object.co_status[ll_ndx] = "K"
			next
			
			if lds_Cache.update() = 1 then
				commit;
				messagebox(ls_MessageHeader,'The selected companies have been reactivated.')
			else
				messagebox(ls_MessageHeader,'There was a problem trying to update the companies.')
			end if
			destroy lds_cache
		end if
		
	else
		MessageBox ( ls_MessageHeader, 'Highlight the companies to be reactivated.' )
	end if
	
END IF

destroy lnv_company
end event

type cb_querymode from commandbutton within w_companysearch
integer x = 50
integer y = 52
integer width = 681
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Enter Sea&rch Criteria"
end type

event clicked;Parent.Event ue_SetQueryMode ( TRUE )
end event

