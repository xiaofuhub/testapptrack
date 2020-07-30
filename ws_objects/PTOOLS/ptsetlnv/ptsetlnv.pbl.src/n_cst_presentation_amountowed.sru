$PBExportHeader$n_cst_presentation_amountowed.sru
forward
global type n_cst_presentation_amountowed from n_cst_presentation
end type
end forward

global type n_cst_presentation_amountowed from n_cst_presentation
end type

type variables
Protected:
//Whether to omit any formatting that would protect columns
Boolean	ib_NoProtect = FALSE
end variables

forward prototypes
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
public function integer of_setnoprotect (boolean ab_switch)
public function boolean of_getnoprotect ()
end prototypes

public function integer of_setpresentation (powerobject apo_target, string as_objectname);String	lsa_Settings[], &
			ls_ValueList, &
			ls_Work
Integer	li_Count, &
			li_Index, &
			li_Return
Boolean	lb_NoProtect

Constant String	ls_AmountOwed_Background = "Background.Color = '16777215~tIF ( amountowed_open = 0, 12648447, 16777215 )'"
Constant String	ls_AmountOwed_Protect = "Protect = '0~tIF ( amountowed_open = 0, 1, 0 )'"

li_Return = 1
as_ObjectName = Lower ( as_ObjectName )
lb_NoProtect = This.of_GetNoProtect ( )

CHOOSE CASE as_ObjectName

//***AmountOwed Table***

CASE "amountowed_fktransaction_t"
	lsa_Settings = { "Text = 'Transaction'" }

CASE "amountowed_id"
	IF lb_NoProtect = FALSE THEN
		lsa_Settings = { "Format = '0000'", "Protect = 1", "Background.Color = 12648447" }
	END IF

CASE "amountowed_fktransaction"
	IF lb_NoProtect = FALSE THEN
		lsa_Settings = { "Format = '0000'", "Protect = 1", "Background.Color = '12648447~tIF ( IsNull ( amountowed_fktransaction ), 12632256, 12648447 )'" }
	END IF

CASE "amountowed_division"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes", "ddlb.Sorted = Yes" }
	ELSE
		li_Return = -1
	END IF

CASE "amountowed_quantity", "amountowed_rate"
	lsa_Settings = { "Format = '0.0#####'", "Edit.Format = '0.0#####'" }

CASE "amountowed_amount"

	IF ib_Report THEN
		lsa_Settings = { "Format = '[general];[general];0.00'" }
	ELSE
		lsa_Settings = { "Format = '##0.00;[red]##0.00;0.00'" }
//		lsa_Settings = { "Format = '[general];[red][general];0.00'" }
	END IF

//	lsa_Settings = { "Format = '[currency];[red][currency]'" }
//	lsa_Settings = { "Format = '#,##0.00;[red](#,##0.00)'" }

CASE "amountowed_status"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { ls_AmountOwed_Background, ls_AmountOwed_Protect, "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes" }
	ELSE
		li_Return = -1
	END IF

CASE "amountowed_taxable"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No" }
	ELSE
		li_Return = -1
	END IF

CASE "amountowed_type", "amountowed_ratetype", "amountowed_ref1type", "amountowed_ref2type", "amountowed_ref3type", "accountmap_amounttypeid" , "amounttypeid"
	
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.Sorted = Yes", "ddlb.VScrollBar = Yes" }
	ELSE
		li_Return = -1
	END IF

CASE "disp_events_de_event_type"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes", "ddlb.Sorted = Yes" }
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
n_cst_Ship_Type	lnv_ShipType
Long		lla_Empty[]
n_cst_Events	lnv_Events

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName

CASE "amountowed_status"
	ls_ValueList = n_cst_beo_AmountOwed.cs_Status_ValueList

CASE "amountowed_ref1type", "amountowed_ref2type", "amountowed_ref3type"
		
	IF This.of_GetCodeTable ( "n_cst_dlkc_refnumtype", ls_ValueList ) < 1 THEN
		li_Return = -1
	ELSE
		ls_ValueList += "[NONE]~t0/"
	END IF

CASE  "accountmap_amounttypeid" // , "amountowed_type"  done in presentation amounttype
	IF This.of_GetCodeTable ( "n_cst_dlkc_amounttype", ls_ValueList ) < 1 THEN
		li_Return = -1
	END IF

CASE "amountowed_taxable"
	ls_ValueList = "YES~t1/NO~t0/"

CASE "amountowed_ratetype"
	IF This.of_GetCodeTable ( "n_cst_dlkc_ratetype", ls_ValueList ) < 1 THEN
		li_Return = -1
	ELSE
		ls_ValueList += "[NONE]~t0/"
	END IF

CASE "amountowed_division"
	IF lnv_ShipType.of_GetCodeTable ( "DIVISION", FALSE /*ActiveOnly*/, lla_Empty /*ReqIds*/, ls_ValueList ) < 1 THEN
		li_Return = -1
	ELSE
		IF Right ( ls_ValueList, 1 ) <> "/" THEN
			ls_ValueList += "/"
		END IF
		ls_ValueList += "[NONE]~t0/"
	END IF

CASE "disp_events_de_event_type"
	ls_ValueList = lnv_Events.of_GetTypeCodeTable ( )
	
	
CASE ELSE
	li_Return = 0
	
END CHOOSE

IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF

RETURN li_Return
end function

public function integer of_setnoprotect (boolean ab_switch);//Returns : 1, -1

//Setting will be consulted to determine whether to apply formatting that would 
//protect columns.  This is relevant for displays like QueryMode.

Integer	li_Return = 1

IF IsNull ( ab_Switch ) THEN
	li_Return = -1
ELSE
	ib_NoProtect = ab_Switch
END IF

RETURN li_Return
end function

public function boolean of_getnoprotect ();RETURN ib_NoProtect
end function

on n_cst_presentation_amountowed.create
TriggerEvent( this, "constructor" )
end on

on n_cst_presentation_amountowed.destroy
TriggerEvent( this, "destructor" )
end on

