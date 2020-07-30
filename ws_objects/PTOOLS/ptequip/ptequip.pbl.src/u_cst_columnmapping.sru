$PBExportHeader$u_cst_columnmapping.sru
forward
global type u_cst_columnmapping from u_base
end type
type cb_remove from commandbutton within u_cst_columnmapping
end type
type cb_add from commandbutton within u_cst_columnmapping
end type
type dw_ptrtmapping from u_dw within u_cst_columnmapping
end type
end forward

global type u_cst_columnmapping from u_base
integer width = 1938
integer height = 1056
long backcolor = 12632256
event ue_add ( )
event ue_remove ( )
cb_remove cb_remove
cb_add cb_add
dw_ptrtmapping dw_ptrtmapping
end type
global u_cst_columnmapping u_cst_columnmapping

type variables
String	is_Table_PT
String	is_Table_EqTrace

String	isa_RTColumns[]
String	isa_RTDisplayValues[]
end variables

forward prototypes
public function integer of_validatetypes (string as_col1, string as_col2)
public function integer of_initialize ()
public function integer of_setprofittoolstable (string as_tablename)
public function integer of_seteqtracetable (string as_tablename)
public function integer of_setdataobject (string as_dataobject)
public function integer of_setdisplayvalues (string asa_columns[], string asa_displayvalues[])
public function integer of_populatedisplayvalues (datawindowchild adwc_dw, string asa_columns[], string asa_displayvalues[])
end prototypes

event ue_add();dw_ptrtmapping.Event pfc_AddRow()
end event

event ue_remove();dw_ptrtmapping.Event pfc_DeleteRow()
end event

public function integer of_validatetypes (string as_col1, string as_col2);Integer	li_Return = 1
Long		ll_Row
String	ls_PTType
String	ls_RtType

DataWindowChild	ldwc_PT
DataWindowChild	ldwc_RT

dw_PtRtMapping.GetChild("rtcol", ldwc_RT)
dw_PtRtMapping.GetChild("ptcol", ldwc_PT)
		
//Get PT col type
ll_Row = ldwc_PT.Find("syscolumn_column_name = '" + as_Col1 + "'", 1, ldwc_PT.RowCount())
IF ll_Row > 0 THEN
	ls_PtType = ldwc_PT.GetItemString(ll_Row,"sysdomain_domain_name")
END IF

//Get RT col Type
ll_Row = ldwc_RT.Find("syscolumn_column_name = '" + as_Col2 + "'", 1, ldwc_RT.RowCount())
IF ll_Row > 0 THEN
	ls_RTType = ldwc_RT.GetItemString(ll_Row,"sysdomain_domain_name")
END IF


IF ls_PtType <> "varchar" AND ls_PtType <> "long varchar" THEN
	
	IF ls_PTType <> ls_RtType THEN
		MessageBox(gnv_app.of_GetRailTraceAppName()+" Column Mapping", "Cannot map RT column '" + as_col2 + "' of type [" + &
							ls_RtType + "] to PT column '" + as_col2 + "' of type [" + ls_PtType + "].~r~nPlease choose a different column", Information!)
		li_Return = -1
	END IF
		
END IF

Return li_Return
end function

public function integer of_initialize ();Integer	li_Return = 1
Long		ll_RowCount
Long		ll_ColCount
Long		i, j
String	lsa_PtColumns[]
String	ls_ColName
Boolean	lb_Found

DataWindowChild	ldwc_PT
DataWindowChild	ldwc_RT

n_cst_PtRailTraceManager	lnv_RTManager

lnv_RTManager = Create	n_cst_PtRailTraceManager

dw_ptrtmapping.SetRedraw(FALSE)

dw_ptrtmapping.SetTransObject(SQLCA)
ll_RowCount = dw_ptrtmapping.Retrieve()
commit;

IF ll_RowCount < 1 THEN
	dw_ptrtmapping.InsertRow(1)
END IF

//Trace Columns
IF li_Return = 1 THEN
	IF dw_PtRtMapping.GetChild("rtcol", ldwc_RT) = 1 THEN
		ldwc_RT.SetTransObject(SQLCA)
		IF ldwc_RT.Retrieve(is_Table_EqTrace) > 0 THEN
			IF This.of_PopulateDisplayValues(ldwc_Rt, isa_rtcolumns, isa_rtdisplayvalues) = 1 THEN
				ldwc_RT.SetSort("column_displayvalue A")
				ldwc_RT.Sort()
			ELSE
				li_Return =1
			END IF
		END IF
	ELSE
		li_Return = -1
	END IF
END IF

//Profit Tools columns
IF li_Return = 1 THEN
	IF dw_PtRtMapping.GetChild("ptcol", ldwc_PT) = 1 THEN
		ldwc_PT.SetTransObject(SQLCA)
		ll_RowCount = ldwc_PT.Retrieve(is_Table_PT) 
		IF ll_RowCount > 0 THEN
			//Get list of raw column values
			FOR i = 1 TO ll_RowCount
				lsa_PtColumns[i] = ldwc_PT.GetItemString(i, "syscolumn_column_name")
			NEXT
			//Populate display values with raw column values
			IF This.of_PopulateDisplayValues(ldwc_PT, lsa_PtColumns, lsa_PtColumns) = 1 THEN
				ldwc_PT.SetSort("column_displayvalue A")
				ldwc_PT.Sort()
			ELSE
				li_Return = -1
			END IF
		END IF
	ELSE
		li_Return = -1
	END IF
END IF


//Filter out PT columns that we do not want to map to
IF li_Return = 1 THEN
	lnv_RTManager.of_GetPtMapColumns(lsa_PtColumns)
	
	FOR i = ll_RowCount TO 1 STEP -1
		lb_Found = FALSE
		ls_ColName = ldwc_PT.GetItemString(i,"syscolumn_column_name")
		ll_ColCount = UpperBound(lsa_PtColumns)
		FOR j = 1 TO ll_ColCount
			IF ls_ColName = lsa_PTColumns[j] THEN
				lb_Found = TRUE
			END IF
		NEXT
		IF NOT lb_Found THEN
			ldwc_Pt.RowsDiscard(i,i,Primary!)
		END IF
	NEXT
	
END IF

dw_ptrtmapping.SetRedraw(TRUE)

Destroy(lnv_RTManager)


Return li_Return
end function

public function integer of_setprofittoolstable (string as_tablename);is_Table_Pt = as_TableName

return 1
end function

public function integer of_seteqtracetable (string as_tablename);is_Table_EqTrace = as_TableName

return 1
end function

public function integer of_setdataobject (string as_dataobject);dw_ptrtmapping.DataObject = as_DataObject

return 1
end function

public function integer of_setdisplayvalues (string asa_columns[], string asa_displayvalues[]);isa_rtcolumns = asa_columns
isa_rtdisplayvalues = asa_displayvalues

Return 1
end function

public function integer of_populatedisplayvalues (datawindowchild adwc_dw, string asa_columns[], string asa_displayvalues[]);Integer	li_Return = 1
Long		i, j
Long		ll_RowCount
Long		ll_ColCount
String	ls_RawColName
String	ls_MappingCol
String	ls_CurrentCol
Boolean 	lb_Mapped

ll_ColCount = UpperBound(asa_Columns)

IF ll_ColCount <> UpperBound(asa_DisplayValues) THEN
	li_Return = -1
END IF

//Populate display values
IF li_Return = 1 THEN
	
	ll_RowCount = adwc_dw.RowCount()
	FOR i = 1 TO ll_RowCount
		lb_Mapped = FALSE
		ls_CurrentCol = adwc_dw.GetItemString(i, "syscolumn_column_name")
		
		FOR j = 1 TO ll_ColCount
			ls_MappingCol = asa_Columns[j]
			IF ls_CurrentCol = ls_MappingCol THEN
				adwc_dw.SetItem( i, "column_displayvalue", asa_DisplayValues[j])
				lb_Mapped = TRUE
			END IF
		NEXT
		
		//Use raw column name if we do not provide a display value
		IF NOT lb_Mapped THEN
			ls_RawColName = adwc_dw.GetItemString( i, "syscolumn_column_name")
			adwc_dw.SetItem( i, "column_displayvalue", ls_RawColName)
		END IF
		
	NEXT
	
END IF


Return li_Return
end function

on u_cst_columnmapping.create
int iCurrent
call super::create
this.cb_remove=create cb_remove
this.cb_add=create cb_add
this.dw_ptrtmapping=create dw_ptrtmapping
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_remove
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.dw_ptrtmapping
end on

on u_cst_columnmapping.destroy
call super::destroy
destroy(this.cb_remove)
destroy(this.cb_add)
destroy(this.dw_ptrtmapping)
end on

type cb_remove from commandbutton within u_cst_columnmapping
integer x = 489
integer y = 916
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Remove"
end type

event clicked;Parent.Event ue_Remove()
end event

type cb_add from commandbutton within u_cst_columnmapping
integer x = 59
integer y = 916
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add"
end type

event clicked;Parent.Event ue_Add()
end event

type dw_ptrtmapping from u_dw within u_cst_columnmapping
event type integer ue_validate ( long al_row )
integer x = 50
integer y = 36
integer width = 1833
integer height = 844
integer taborder = 10
end type

event type integer ue_validate(long al_row);Integer	li_Return = 1

String	ls_PtColumn
String	ls_RtColumn

IF al_row > 0 THEN
	
	ls_Ptcolumn = This.GetItemString(al_row, "ptcol")
	ls_RtColumn = This.GetItemString(al_row, "rtcol")
	
	
	IF Parent.of_ValidateTypes(ls_ptcolumn, ls_rtcolumn) <> 1 THEN
			li_Return = -1
			This.Setfocus()
			This.SetRow(al_Row)
			This.Setcolumn("rtcol")
	END IF


END IF

Return li_Return
end event

event itemchanged;call super::itemchanged;Long		ll_NewRow
Integer	li_Valid
String	ls_ptcol
String	ls_rtcol
String	ls_null
String	ls_FindString
setNull(ls_Null)

CHOOSE CASE dwo.Name 
	CASE "rtcol"
		
		ls_rtcol = data
		ls_ptcol = This.GetItemString(row, "ptcol")
		
	CASE "ptcol"
		
		ls_ptcol = data
		ls_rtCol = This.GetItemString(row, "rtcol")
		
		//check if we already have a mapping for this column
		ls_FindString = "ptcol = '" + data + "'"
		IF This.Find(ls_FindString, 1, This.RowCount()) > 0 THEN
			MessageBox("EqTrace Mapping", data + " is already mapped.")
			This.SetItem(row, dwo.Name, ls_null)
			Return 1   //Do not allow focus/data to change
		END IF
		
END CHOOSE


IF NOT isNull(ls_ptCol) AND NOT isNull(ls_rtCol) THEN
	li_Valid = Parent.of_ValidateTypes(ls_ptcol, ls_rtcol)
ELSE 
	li_Valid = 0 //null value, so its valid until changed
END IF



CHOOSE CASE li_Valid
	CASE 1  //both types are valid
		ll_newRow = This.InsertRow(0)
		IF ll_NewRow > 0 THEN
			this.setRow(ll_NewRow)
			this.setcolumn("ptcol")
			this.scrollnextpage( )
		END IF
		
	CASE -1 //invalid types
		This.SetItem(row, dwo.Name, ls_null)
		Return 1 //Do not allow focus/data to change
		
	CASE 0 //one value is still null
		//ok
END CHOOSE
end event

event rowfocuschanged;call super::rowfocuschanged;DataWindowChild	ldwc_PT
DataWindowChild	ldwc_RT

IF dw_PtRtMapping.GetChild("rtcol", ldwc_RT) = 1 THEN
	ldwc_RT.SetFilter("")
	ldwc_RT.Filter()
END IF

IF dw_PtRtMapping.GetChild("ptcol", ldwc_PT) = 1 THEN
	ldwc_PT.SetFilter("")
	ldwc_PT.Filter()
END IF
end event

event rowfocuschanging;call super::rowfocuschanging;Integer	li_Return

li_Return = AncestorReturnValue

IF currentrow > 0 THEN
	
	IF This.Event ue_Validate(currentrow) <> 1 THEN
		
		li_Return = 1 //do not allow row change
		
	END IF

END IF

Return li_Return
end event

event pfc_preupdate;call super::pfc_preupdate;Integer	li_Return
Long		ll_index
Long		ll_max
String	ls_PTCol
String	ls_RtCol

li_Return = AncestorReturnValue

ll_max = This.rowCount()

This.SetRedraw(False)
//sort for dupes logic
This.setsort("ptcol A")
This.sort()

FOR ll_index = ll_max TO 1 STEP -1
	
	
	ls_ptcol = This.GetItemString( ll_index, "ptcol" )
	ls_rtcol = This.GetItemString( ll_index, "rtcol" )
	//Discard nulls
	IF isNull( ls_ptcol ) OR isNull( ls_rtcol ) THEN
		This.RowsDiscard( ll_index, ll_index, Primary!)
	//Discard dupes
	ELSE
		IF ll_Index > 1 THEN
			IF This.GetItemString(ll_index, "ptcol") =  This.GetItemString(ll_index - 1, "ptcol") THEN
				This.RowsDiscard( ll_index - 1, ll_index -1, Primary!)
			END IF
		END IF
	END IF
	
NEXT

//clear sort
This.SetSort("")
This.Sort()

This.SetRedraw(TRUE)

Return li_Return
end event

event itemerror;call super::itemerror;//Here we assume that an item error will only be caused by rejecting a value in 
//itemchanged. So we reject data with no message box in ALL cases

Return 1 // message taken care of in of_validatetypes()
end event

event pfc_addrow;call super::pfc_addrow;Long	ll_Return

ll_Return = AncestorReturnValue

This.SetRow(ll_Return)

Return ll_Return
end event

event pfc_insertrow;//Overriding Ancestor

Return This.Event pfc_AddRow()
end event

