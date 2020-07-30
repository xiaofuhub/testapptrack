$PBExportHeader$n_cst_presentation_transaction.sru
forward
global type n_cst_presentation_transaction from n_cst_presentation
end type
end forward

global type n_cst_presentation_transaction from n_cst_presentation
end type

forward prototypes
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
end prototypes

public function integer of_setpresentation (powerobject apo_target, string as_objectname);
String	lsa_Settings[], &
		ls_ValueList, &
		ls_Work
Integer	li_Count, &
		li_Index, &
		li_Return


Constant String	ls_Transaction_Background = "Background.Color = '16777215~tIF ( transaction_open = 0, 12648447, 16777215 )'"
Constant String	ls_Transaction_Protect = "Protect = '0~tIF ( transaction_open = 0, 1, 0 )'"

li_Return = 1
as_ObjectName = Lower ( as_ObjectName )


CHOOSE CASE as_ObjectName

//***Transaction Table***

CASE "transaction_id"
	lsa_Settings = { "Format = '0000'", "Protect = 1", "Background.Color = 12648447" }

CASE "transaction_type"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "Protect = 1", "Background.Color = 12648447" }
	ELSE
		li_Return = -1
	END IF

CASE "transaction_taxablegross", "transaction_nontaxablegross", "transaction_pretaxnet"

	IF ib_Report THEN
		lsa_Settings = { "Format = '[general];[general];0.00'" }
	ELSE
		lsa_Settings = { "Format = '[general];[red][general];0.00'", "Protect = 1", "Background.Color = 12648447" }
	END IF

CASE "transaction_status"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { ls_Transaction_Background, ls_Transaction_Protect, "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes" }
	ELSE
		li_Return = -1
	END IF
	
CASE "transaction_batchdate", "transaction_batchnumber"
	lsa_Settings = { "Protect = 1", "Background.Color = 12648447" }

CASE "transaction_documentdate", "transaction_documentnumber"
	lsa_Settings = { "Protect = 1", "Background.Color = '12632256~tIF ( transaction_open = 0, 12648447, 12632256 )'" }
	//This will also need to take fixedamount into account, once there are transaction types that support it.

CASE "transaction_ref1type", "transaction_ref2type", "transaction_ref3type"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.Sorted = Yes", "ddlb.VScrollBar = Yes" }
	ELSE
		li_Return = -1
	END IF
END CHOOSE

IF li_Return = 1 THEN

	li_Count = UpperBound ( lsa_Settings )
	
	FOR li_Index = 1 TO li_Count
	
		apo_Target.Dynamic Modify ( as_ObjectName + "." + lsa_Settings [ li_Index ] )
	
	NEXT

END IF

RETURN li_Return

end function

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);//Returns: 1 = Success, 0 = Column not found, -1 = Error

Integer	li_Return
String	ls_ValueList

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName

CASE "transaction_type"
	ls_ValueList = appeon_constant.cs_Type_ValueList

CASE "transaction_status"
	ls_ValueList = appeon_constant.cs_Status_ValueList

CASE	"transaction_ref1type", "transaction_ref2type", "transaction_ref3type"
		
	IF This.of_GetCodeTable ( "n_cst_dlkc_refnumtype", ls_ValueList ) < 1 THEN
		li_Return = -1
	ELSE
		ls_ValueList += "[NONE]~t0/"
	END IF
	
CASE ELSE
	li_Return = 0
	
END CHOOSE

IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF


RETURN li_Return
end function

on n_cst_presentation_transaction.create
TriggerEvent( this, "constructor" )
end on

on n_cst_presentation_transaction.destroy
TriggerEvent( this, "destructor" )
end on

