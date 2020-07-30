$PBExportHeader$u_cst_syssettings_generic_populate.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings_generic_populate from u_cst_syssettings
end type
type uo_1 from u_generic_populatesettings within u_cst_syssettings_generic_populate
end type
end forward

global type u_cst_syssettings_generic_populate from u_cst_syssettings
integer width = 1742
integer height = 1288
event ue_deleterow ( long al_row )
uo_1 uo_1
end type
global u_cst_syssettings_generic_populate u_cst_syssettings_generic_populate

type variables
Protected:
String isa_RowValues[]

end variables

forward prototypes
public subroutine of_setheight (integer ai_value)
public subroutine of_setcolumncase (string as_value)
public subroutine of_setcolumnlimit (integer ai_value)
end prototypes

public subroutine of_setheight (integer ai_value);this.height=ai_value
uo_1.of_SetHeight(ai_value)
end subroutine

public subroutine of_setcolumncase (string as_value);uo_1.event ue_SetColumnCase(as_value)
end subroutine

public subroutine of_setcolumnlimit (integer ai_value);uo_1.event ue_Setcolumnlimit(ai_value)
end subroutine

on u_cst_syssettings_generic_populate.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_cst_syssettings_generic_populate.destroy
call super::destroy
destroy(this.uo_1)
end on

event ue_setproperty;call super::ue_setproperty;Int li_Ctr
Long ll_UpperBound
String lsa_Array[]

IF IsValid(inv_sysSetting) THEN 
	uo_1.event ue_setlabel(inv_sysSetting.of_getlabel( ))
END IF	

Return AncestorReturnValue

end event

event ue_setvalue;call super::ue_setvalue;Int li_ReturnValue = 1 

Int li_Ctr
Long ll_UpperBound

String ls_value
String ls_Delimiter
String ls_ColumnHeader

IF IsValid(inv_syssetting) THEN
	IF inv_syssetting.of_getvalue(isa_RowValues[] ) <> 1 THEN 
		li_ReturnValue = -1 
	END IF	
END IF

IF li_ReturnValue = 1 THEN
	
	ls_ColumnHeader	= inv_syssetting.of_GetColHeader( )
	ll_UpperBound = UpperBound(isa_RowValues)
	IF ll_UpperBound > 0 THEN
		FOR li_Ctr = 1 TO ll_UpperBound
				uo_1.event ue_InsertRow(Trim(isa_RowValues[li_Ctr]))
		NEXT
	END IF
	
	uo_1.event ue_SetColumnHeader(ls_ColumnHeader)
	
	uo_1.event ue_SetDWFocus( )
END IF

Return li_ReturnValue

end event

type uo_1 from u_generic_populatesettings within u_cst_syssettings_generic_populate
integer x = 14
integer y = 12
integer height = 1256
integer taborder = 10
end type

on uo_1.destroy
call u_generic_populatesettings::destroy
end on

event ue_savevalues;call super::ue_savevalues;inv_syssetting.of_savevalue(as_values)
end event

event ue_collectitems;call super::ue_collectitems;Int li_Ctr
Long ll_RowCount
String ls_Values
String ls_Item

dw_1.AcceptText()
ll_RowCount = dw_1.RowCount()

FOR li_Ctr = 1 TO ll_RowCount
	ls_Item = dw_1.Object.Values[li_Ctr] 
	IF IsNull(ls_Item) THEN
		Exit
	END IF
	ls_Values = ls_Values + ls_Item + ','
NEXT 

ls_Values = Left(ls_Values,(Len(ls_Values) - 1))

Return ls_Values

end event

