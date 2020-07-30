$PBExportHeader$w_rtcolumnmapping.srw
forward
global type w_rtcolumnmapping from w_response
end type
type dw_ptrtmapping from u_dw within w_rtcolumnmapping
end type
type cb_save from commandbutton within w_rtcolumnmapping
end type
end forward

global type w_rtcolumnmapping from w_response
integer width = 1984
integer height = 884
string title = "Equipment Trace Data Mapping"
long backcolor = 12632256
dw_ptrtmapping dw_ptrtmapping
cb_save cb_save
end type
global w_rtcolumnmapping w_rtcolumnmapping

forward prototypes
public function integer wf_initialize ()
public function integer of_validatetypes (string as_ptcol, string as_rtcol)
end prototypes

public function integer wf_initialize ();Integer	li_Return = 1
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

//Rail Trace Columns
IF li_Return = 1 THEN
	IF dw_PtRtMapping.GetChild("rtcol", ldwc_RT) <> 1 THEN
		li_Return = -1
	ELSE
		ldwc_RT.SetTransObject(SQLCA)
		IF ldwc_RT.Retrieve("equipmenttrace") < 1 THEN
			li_Return = -1
		ELSE
			ldwc_RT.SetSort("syscolumn_column_name A")
			ldwc_RT.Sort()
		END IF
	END IF
END IF

//Profit Tools columns
IF dw_PtRtMapping.GetChild("ptcol", ldwc_PT) <> 1 THEN
	li_Return = -1
ELSE
	ldwc_PT.SetTransObject(SQLCA)
	ll_RowCount = ldwc_PT.Retrieve("disp_ship") 
	IF ll_RowCount < 1 THEN
		li_Return = -1
	ELSE
		ldwc_PT.SetSort("syscolumn_column_name A")
		ldwc_PT.Sort()
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

public function integer of_validatetypes (string as_ptcol, string as_rtcol);Integer	li_Return = 1
Long		ll_Row
String	ls_PTType
String	ls_RtType

DataWindowChild	ldwc_PT
DataWindowChild	ldwc_RT

dw_PtRtMapping.GetChild("rtcol", ldwc_RT)
dw_PtRtMapping.GetChild("ptcol", ldwc_PT)
		
//Get PT col type
ll_Row = ldwc_PT.Find("syscolumn_column_name = '" + as_PtCol + "'", 1, ldwc_PT.RowCount())
IF ll_Row > 0 THEN
	ls_PtType = ldwc_PT.GetItemString(ll_Row,"sysdomain_domain_name")
END IF

//Get RT col Type
ll_Row = ldwc_RT.Find("syscolumn_column_name = '" + as_RtCol + "'", 1, ldwc_RT.RowCount())
IF ll_Row > 0 THEN
	ls_RTType = ldwc_RT.GetItemString(ll_Row,"sysdomain_domain_name")
END IF


IF ls_PtType <> "varchar" AND ls_PtType <> "long varchar" THEN
	
	IF ls_PTType <> ls_RtType THEN
		MessageBox(gnv_App.of_GetRailTraceAppName() + " Column Mapping", "Cannot map RT column '" + as_rtcol + "' of type [" + &
							ls_RtType + "] to PT column '" + as_ptcol + "' of type [" + ls_PtType + "].~r~nPlease choose a different column", Information!)
		li_Return = -1
	END IF
		
END IF

Return li_Return
end function

on w_rtcolumnmapping.create
int iCurrent
call super::create
this.dw_ptrtmapping=create dw_ptrtmapping
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ptrtmapping
this.Control[iCurrent+2]=this.cb_save
end on

on w_rtcolumnmapping.destroy
call super::destroy
destroy(this.dw_ptrtmapping)
destroy(this.cb_save)
end on

event open;call super::open;// Center window
This.of_SetBase(TRUE) 
This.inv_Base.Of_Center()

This.wf_Initialize()
end event

event pfc_preupdate;call super::pfc_preupdate;Integer	li_Return
Long		ll_index
Long		ll_max
String	ls_PTCol
String	ls_RtCol

li_Return = AncestorReturnValue

ll_max = dw_ptrtmapping.rowCount()

dw_ptrtmapping.SetRedraw(FALSE)
//sort for dupes logic
dw_ptrtmapping.setsort("ptcol A")
dw_ptrtmapping.sort()

FOR ll_index = ll_max TO 1 STEP -1
	
	
	ls_ptcol = dw_ptrtmapping.getItemString( ll_index, "ptcol" )
	ls_rtcol = dw_ptrtmapping.getItemString( ll_index, "rtcol" )
	//Discard nulls
	IF isNull( ls_ptcol ) OR isNull( ls_rtcol ) THEN
		dw_ptrtmapping.rowsDiscard( ll_index, ll_index, PRIMARY!)
	//Discard dupes
	ELSE
		IF ll_Index > 1 THEN
			IF dw_ptrtmapping.GetItemString(ll_index, "ptcol") =  dw_ptrtmapping.GetItemString(ll_index - 1, "ptcol") THEN
				dw_ptrtmapping.rowsDiscard( ll_index, ll_index, PRIMARY!)
			END IF
		END IF
	END IF
	
NEXT

//clear sort
dw_ptrtmapping.SetSort("")
dw_ptrtmapping.Sort()

dw_ptrtmapping.SetRedraw(TRUE)
	

RETURN li_Return
end event

event pfc_save;call super::pfc_save;Integer	li_Return = 1
Long	ll_Rowcount
Long	i

ll_RowCount = dw_ptrtmapping.Rowcount()
FOR i = 1 TO ll_Rowcount
	IF dw_ptrtmapping.Event ue_Validate(i) <> 1 THEN
		li_Return = -1
		EXIT
	END IF
NEXT

IF li_Return = 1 THEN
	li_Return = Super::Event pfc_Save()
END IF

Return li_Return
end event

type cb_help from w_response`cb_help within w_rtcolumnmapping
boolean visible = false
integer x = 2395
integer y = 1368
end type

type dw_ptrtmapping from u_dw within w_rtcolumnmapping
event type integer ue_validate ( long al_row )
integer x = 78
integer y = 68
integer width = 1810
integer height = 520
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_railtracecolumnmapping"
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

event itemchanged;call super::itemchanged;Long		ll_NewRow
String	ls_ptcol
String	ls_rtcol

IF dwo.Name = "rtcol" THEN
	IF row = This.RowCount() THEN
		ls_ptcol = this.getitemstring(row, "ptcol")
		IF Parent.of_ValidateTypes(ls_ptcol, data) = 1 THEN
			ll_newRow = This.InsertRow(0)
			IF ll_NewRow > 0 THEN
				this.setRow(ll_NewRow)
				this.setcolumn("ptcol")
				this.scrollnextpage( )
			END IF
		END IF
		
	END IF
END IF
end event

type cb_save from commandbutton within w_rtcolumnmapping
integer x = 1490
integer y = 648
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Done"
end type

event clicked;CLOSE(Parent)
end event

