$PBExportHeader$u_ddlb_shipmentsort.sru
forward
global type u_ddlb_shipmentsort from dropdownlistbox
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//String	ss_LastSort
////end modification Shared Variables by appeon  20070730
end variables

global type u_ddlb_shipmentsort from dropdownlistbox
integer width = 526
integer height = 308
integer taborder = 1
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
borderstyle borderstyle = stylelowered!
event ue_processchange ( integer ai_ndx,  string as_label,  string as_sort )
end type
global u_ddlb_shipmentsort u_ddlb_shipmentsort

type variables
Private:
n_cst_Msg	inv_Sorts

//begin modification Shared Variables by appeon  20070730
String	ss_LastSort
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public function integer of_setsort (string as_label)
public function integer of_setsort ()
end prototypes

event ue_processchange;ss_LastSort = as_Label
end event

public function integer of_setsort (string as_label);Integer	li_Ndx

li_Ndx = This.SelectItem ( as_Label, 0 )

IF li_Ndx > 0 THEN
	This.Event SelectionChanged ( li_Ndx )
END IF

RETURN li_Ndx
end function

public function integer of_setsort ();String ls_Sort

IF Len ( ss_LastSort ) > 0 THEN
	ls_Sort = ss_LastSort
ELSE
	ls_Sort = "TMP#"
END IF

RETURN of_SetSort ( ls_Sort )
end function

event constructor;n_cst_ShipmentManager	lnv_ShipmentMgr
s_Parm		lstr_Parm
Integer		li_SortCount, &
				li_Ndx

li_SortCount = lnv_ShipmentMgr.of_GetShipmentSorts ( inv_Sorts )

This.SetRedraw ( FALSE )

FOR li_Ndx = 1 TO li_SortCount
	inv_Sorts.of_Get_Parm ( li_Ndx, lstr_Parm )
	This.AddItem ( lstr_Parm.is_Label )
NEXT

This.Height = 100 * ( li_SortCount + 1 )

This.SetRedraw ( TRUE )

This.of_SetSort ( )
end event

event selectionchanged;Integer	li_Ndx
s_Parm	lstr_Parm
String	ls_Label, &
			ls_Sort

li_Ndx = inv_Sorts.of_Get_Parm ( This.Text, lstr_Parm )

IF li_Ndx > 0 THEN

	ls_Label = lstr_Parm.is_Label
	ls_Sort = lstr_Parm.ia_Value

	This.Event ue_ProcessChange ( li_Ndx, ls_Label, ls_Sort )

END IF
end event

on u_ddlb_shipmentsort.create
end on

on u_ddlb_shipmentsort.destroy
end on

