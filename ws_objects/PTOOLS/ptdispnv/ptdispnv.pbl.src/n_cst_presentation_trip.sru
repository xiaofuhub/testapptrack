$PBExportHeader$n_cst_presentation_trip.sru
forward
global type n_cst_presentation_trip from n_cst_presentation
end type
end forward

global type n_cst_presentation_trip from n_cst_presentation
end type

forward prototypes
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
end prototypes

public function integer of_setpresentation (powerobject apo_target, string as_objectname);

String	lsa_Settings[], &
			ls_ValueList

Integer	li_Count, &
			li_Return, &
			li_Index


li_Return = 1
as_ObjectName = Lower ( as_ObjectName )


CHOOSE CASE as_ObjectName


CASE "trip_id"
	lsa_Settings = { "Format = '0000'", "Protect = 1", "Background.Color = 12648447" }

CASE "trip_status", "bt_pmtstatus", "trip_equipmenttype", "bt_eq_type"  //Background and Protect are copied from amtowed and transn status
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { /*ls_Trip_Background??, ls_Trip_Protect??,*/ "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes" }
	ELSE
		li_Return = -1
	END IF
	
CASE ELSE
	li_Return = 0
	
END CHOOSE

IF li_Return = 1 THEN

	li_Count = UpperBound ( lsa_Settings )
	
	FOR li_Index = 1 TO li_Count
	
		apo_Target.Dynamic Modify ( as_ObjectName + "." + lsa_Settings [ li_Index ] )
	
	NEXT

END IF

RETURN li_Return

end function

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);Integer	li_Return
String	ls_ValueList

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName
CASE "trip_status", "bt_pmtstatus"
	ls_ValueList = appeon_constant.cs_Status_ValueList
CASE  "trip_equipmenttype", "bt_eq_type"
		ls_ValueList = "----~tZ/TRAC~tT/STRT~tS/VAN~tN/TRLR~tV"+&
				"/FLBD~tF/REFR~tR/TANK~tK/RBOX~tB/CHAS~tH/CNTN~tC/" 
CASE ELSE
	li_Return = 0
				
END CHOOSE


IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF


RETURN li_return
end function

on n_cst_presentation_trip.create
call super::create
end on

on n_cst_presentation_trip.destroy
call super::destroy
end on

