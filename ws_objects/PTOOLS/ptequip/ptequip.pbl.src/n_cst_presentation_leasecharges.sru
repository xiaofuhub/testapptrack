$PBExportHeader$n_cst_presentation_leasecharges.sru
forward
global type n_cst_presentation_leasecharges from n_cst_presentation
end type
end forward

global type n_cst_presentation_leasecharges from n_cst_presentation
end type

forward prototypes
public function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
end prototypes

public function integer of_getvaluelist (string as_columnname, ref string as_valuelist);Integer	li_Return
String	ls_ValueList
n_cst_Events	lnv_Events

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName

CASE "equipment_type"
		ls_ValueList = "----~tZ/TRAC~tT/STRT~tS/VAN~tN/TRLR~tV"+&
				"/FLBD~tF/REFR~tR/TANK~tK/RBOX~tB/CHAS~tH/CNTN~tC/" 


CASE ELSE
	li_Return = 0 
END CHOOSE

IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF


RETURN li_Return
end function

public function integer of_setpresentation (powerobject apo_target, string as_objectname);String	lsa_Settings[], &
		ls_ValueList, &
		ls_Work
Integer	li_Count, &
		li_Index, &
		li_Return


li_Return = 1
as_ObjectName = Lower ( as_ObjectName )


CHOOSE CASE as_ObjectName


//*** EQUIPMENT  SUMMARY***

	CASE "equipment_type"
		IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
			lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList}
		ELSE
			li_Return = -1
		END IF		

	CASE "equipmentlease_charges"
		
		lsa_Settings = { "Format = '[Currency]' " }
		
END CHOOSE

IF li_Return = 1 THEN

	li_Count = UpperBound ( lsa_Settings )
	
	FOR li_Index = 1 TO li_Count
	
		apo_Target.Dynamic Modify ( as_ObjectName + "." + lsa_Settings [ li_Index ] )
	
	NEXT

END IF

RETURN li_return



end function

on n_cst_presentation_leasecharges.create
TriggerEvent( this, "constructor" )
end on

on n_cst_presentation_leasecharges.destroy
TriggerEvent( this, "destructor" )
end on

