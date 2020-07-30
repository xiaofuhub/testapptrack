$PBExportHeader$w_equipmentsearch.srw
forward
global type w_equipmentsearch from w_child
end type
type dw_equipment from u_dw_equipmentsearch within w_equipmentsearch
end type
type cb_search from commandbutton within w_equipmentsearch
end type
type cb_3 from commandbutton within w_equipmentsearch
end type
type st_1 from statictext within w_equipmentsearch
end type
type gb_1 from groupbox within w_equipmentsearch
end type
type st_results from statictext within w_equipmentsearch
end type
type cb_criteria from commandbutton within w_equipmentsearch
end type
type cb_reset from commandbutton within w_equipmentsearch
end type
end forward

global type w_equipmentsearch from w_child
integer x = 50
integer y = 1320
integer width = 3429
integer height = 660
string title = "Equipment Query By Example"
boolean minbox = false
boolean maxbox = false
long backcolor = 12632256
event ue_setquerymode ( boolean ab_switch )
dw_equipment dw_equipment
cb_search cb_search
cb_3 cb_3
st_1 st_1
gb_1 gb_1
st_results st_results
cb_criteria cb_criteria
cb_reset cb_reset
end type
global w_equipmentsearch w_equipmentsearch

type variables
n_cst_uilink_dw	inv_UiLink
datawindowChild	idwc_Origin
datawindowChild	idwc_Destination
end variables

forward prototypes
public function integer wf_populatechild ()
private function integer wf_getquerycolumns (ref string asa_list[])
private function integer wf_getexcludelist (ref string asa_list[])
end prototypes

event ue_setquerymode;//Returns : 1, -1

Integer	li_Return = 1

IF NOT IsNull ( ab_Switch ) THEN

	IF NOT IsNull ( dw_equipment.inv_QueryMode ) THEN
		cb_criteria.Visible = NOT ab_Switch
		cb_search.Visible = ab_Switch
		IF ab_Switch THEN
			cb_Reset.Text = "R&eset Criteria"
			cb_Reset.Enabled = TRUE
		ELSE
			cb_Reset.Text = "PROCESSING"
			cb_Reset.Enabled = FALSE
		END IF

		dw_equipment.inv_QueryMode.of_SetEnabled ( ab_Switch )

		IF ab_Switch = TRUE THEN
			dw_equipment.SetRow ( 1 )
		END IF

	ELSE
		li_Return = -1
	END IF

ELSE
	li_Return = -1

END IF

//RETURN li_Return
end event

public function integer wf_populatechild ();dw_equipment.GetChild ( "outside_equip_originationsite" , idwc_Origin )
dw_equipment.GetChild ( "outside_equip_terminationsite" , idwc_destination )


idwc_Origin.SetTransObject ( sqlca )
idwc_Origin.Retrieve ( )

idwc_destination.SetTransObject ( sqlca )
idwc_destination.Retrieve ( )
//idwc_Origin.RowsCopy ( 1 , idwc_Origin.Rowcount () , Primary! , idwc_destination , 9999 , PRIMARY! )


RETURN 1




end function

private function integer wf_getquerycolumns (ref string asa_list[]);String	lsa_QueryColumns []
String	lsa_Exclude[]
String	ls_Current
Boolean	lb_Skip
Int		li_KeepCount = 1
Int		i,j
Int		li_ColumnCount
Int		li_ExcludeCount

dw_equipment.inv_Base.of_GetObjects ( lsa_QueryColumns, "*", "*", FALSE /*Not VisOnly*/ )
li_ExcludeCount = THIS.wf_GetExcludeList ( lsa_Exclude )
li_ColumnCount = UpperBound ( lsa_QueryColumns )

FOR j = 1 TO li_ColumnCount

	ls_Current = lsa_QueryColumns[j]
	
	FOR i = 1 TO li_ExcludeCount
		IF lsa_Exclude [ i ] = ls_Current THEN
			EXIT
		END IF
	NEXT
	
	IF i > li_ExcludeCount THEN
		asa_list [ li_KeepCount ] = ls_Current
		li_KeepCount ++ 
	END IF
NEXT

RETURN 1
end function

private function integer wf_getexcludelist (ref string asa_list[]);String	lsa_ExcludeList[]
Int		li_Count

//li_Count++
//lsa_ExcludeList [ li_Count ] = "terminationname"
//
//li_Count++
//lsa_ExcludeList [ li_Count ] = "originationname"
//
//li_Count++
//lsa_ExcludeList [ li_Count ] = "fromname"
//
//li_Count++
//lsa_ExcludeList [ li_Count ] = "forname"
//
//asa_List = lsa_ExcludeList 

RETURN UpperBound ( asa_List )
end function

on w_equipmentsearch.create
int iCurrent
call super::create
this.dw_equipment=create dw_equipment
this.cb_search=create cb_search
this.cb_3=create cb_3
this.st_1=create st_1
this.gb_1=create gb_1
this.st_results=create st_results
this.cb_criteria=create cb_criteria
this.cb_reset=create cb_reset
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_equipment
this.Control[iCurrent+2]=this.cb_search
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.st_results
this.Control[iCurrent+7]=this.cb_criteria
this.Control[iCurrent+8]=this.cb_reset
end on

on w_equipmentsearch.destroy
call super::destroy
destroy(this.dw_equipment)
destroy(this.cb_search)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.st_results)
destroy(this.cb_criteria)
destroy(this.cb_reset)
end on

event open;call super::open;ib_DisableCloseQuery = TRUE
inv_uilink = Message.PowerObjectParm
THIS.Event ue_SetQueryMode ( TRUE )

THIS.of_SetResize( TRUE )
inv_Resize.of_Register( dw_equipment , inv_resize.scalerightbottom )
inv_Resize.of_Register( cb_3 , inv_Resize.fixedright )

THIS.Width =THIS.ParentWindow ( ).workspacewidth( ) - 160
THIS.y = (THIS.ParentWindow( ).Y + THIS.Parentwindow( ).height) - ( THIS.Height + 250 )



end event

event pfc_postopen;String	lsa_QueryColumns[]
String	ls_OriginalSelect


dw_equipment.of_SetTransObject ( SQLCA )
dw_equipment.of_SetBase ( TRUE )


THIS.wf_GetQueryColumns ( lsa_QueryColumns )


dw_equipment.inv_QueryMode.of_SetQueryCols ( lsa_QueryColumns )
dw_equipment.inv_QueryMode.of_SetRetrieveonDisabled ( FALSE )

dw_equipment.of_SetInsertable ( FALSE )
dw_equipment.of_SetDeleteable ( FALSE )

//ls_OriginalSelect = dw_Equipment.object.datawindow.table.select
//Messagebox ( "a" , ls_OriginalSelect )
//THIS.wf_PopulateChild ( )


end event

type dw_equipment from u_dw_equipmentsearch within w_equipmentsearch
integer x = 9
integer y = 148
integer width = 3365
integer height = 408
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event constructor;n_cst_Presentation_EquipmentSummary	lnv_Presentation
lnv_Presentation.ib_Editable  = TRUE

lnv_Presentation.of_SetPresentation ( THIS )

This.of_SetQueryMode ( TRUE )
This.inv_QueryMode.of_SetResetCriteria ( FALSE ) //Do not clear criteria between toggles


end event

type cb_search from commandbutton within w_equipmentsearch
boolean visible = false
integer x = 23
integer y = 36
integer width = 485
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Retrieve"
boolean default = true
end type

event clicked;SetPointer ( HOURGLASS! )
Long		lla_Ids[]
n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query
String	ls_Time

ls_Time = "Start = " + String ( Now ( ) ) + "~r~n"



IF dw_equipment.Event pfc_AcceptText ( TRUE /*FocusOnError*/ ) = -1 THEN

ELSE
	Time Start
	Time lt_End
	Start = Now ( )
	ls_time += "After accept text = " + String ( Start ) + "~r~n" 

	Parent.Event ue_SetQueryMode ( FALSE )
	st_Results.Text = String ( dw_Equipment.Retrieve ( ) )
	
	ls_Time += "After Retrieve = " + String ( Now ( ) )+ "~r~n"
	
	IF dw_Equipment.RowCount ( ) > 0 THEN	
		lla_Ids = dw_equipment.Object.equipment_eq_id.Primary
	ELSE
		lla_Ids [ 1 ] = 0  // THIS IS DONE TO FORCE THE DISPLAY TO SHOW NOTHING IF THE 
	END IF					// RETRIEVE RETURNS NOTHING
	
	ls_Time += "After RowCount = " + String ( Now ( ) )+ "~r~n"

	lnv_database = gnv_bcmmgr.GetDatabase ( )
	
	ls_Time += "After Get DB = " + String ( Now ( ) )+ "~r~n"
	
	If IsValid(lnv_database) Then
		lnv_query = lnv_database.GetQuery ( )
		lnv_Query.SetArgument ( lla_Ids )
		lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlk_equipmentcache" , "" , "IdArray")
		ls_Time += "After Execute Query = " + String ( Now ( ) )+ "~r~n"
	End If
	
	IF isValid ( lnv_Bcm ) AND IsValid ( inv_UILink )  THEN
		inv_UILink.SetBCM ( lnv_Bcm )	
		
		ls_Time += "After Set BCM = " + String ( Now ( ) )+ "~r~n"
		
		inv_UILink.RefreshFromBCM ( )		
		
		lt_End = Now ( )
		ls_Time += "After Refresh = " + String ( lt_End )+ "~r~n"
		
	END IF
		
	Parent.Event ue_SetQueryMode ( TRUE )
		ls_Time += "After Set Query = " + String ( Now ( ) )+ "~r~n"

END IF

		ls_Time += "Total Time = " + String ( SecondsAfter ( start , lt_End ) )

//MessageBox ( "Time" , ls_Time )
end event

type cb_3 from commandbutton within w_equipmentsearch
integer x = 3035
integer y = 36
integer width = 338
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
boolean cancel = true
end type

event clicked;CLOSE ( PARENT )
end event

type st_1 from statictext within w_equipmentsearch
integer x = 1280
integer y = 44
integer width = 430
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Search Results: "
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_equipmentsearch
integer x = 1248
integer width = 731
integer height = 128
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_results from statictext within w_equipmentsearch
integer x = 1746
integer y = 44
integer width = 215
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "0"
boolean focusrectangle = false
end type

type cb_criteria from commandbutton within w_equipmentsearch
integer x = 23
integer y = 36
integer width = 485
integer height = 88
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "PROCESSING"
boolean default = true
end type

type cb_reset from commandbutton within w_equipmentsearch
integer x = 617
integer y = 36
integer width = 544
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "R&eset Data"
end type

event clicked;st_Results.Text = "0"

IF dw_equipment.Object.DataWindow.QueryMode = "yes" THEN
	dw_equipment.Object.DataWindow.QueryClear = "yes"
ELSE
	dw_equipment.Reset ( )
END IF

end event

