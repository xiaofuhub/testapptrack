$PBExportHeader$n_cst_presentation_amounttemplate.sru
$PBExportComments$Also used by entity for division.
forward
global type n_cst_presentation_amounttemplate from n_cst_presentation
end type
end forward

global type n_cst_presentation_amounttemplate from n_cst_presentation
end type

forward prototypes
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
end prototypes

public function integer of_setpresentation (powerobject apo_target, string as_objectname);String	lsa_Settings[], &
		ls_ValueList, &
		ls_Work, &
		ls_Label
Integer	li_Count, &
		li_Index, &
		li_Return


li_Return = 1
as_ObjectName = Lower ( as_ObjectName )


CHOOSE CASE as_ObjectName

CASE "amounttemplate_splitsby"
	lsa_Settings [ UpperBound ( lsa_Settings ) + 1] = &
		"BackGround.Color = '16777215~tIF ( amounttemplate_aggregatecalc = 1, 16777215, 12632256 )'"
	lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
		"Protect = '0~tIF ( amounttemplate_aggregatecalc = 1, 0, 1 )'"

CASE "amounttemplate_ref1typeid", "amounttemplate_ref2typeid", "amounttemplate_ref3typeid", &
		"amounttemplate_ratetypeid", "amounttemplate_amounttypeid", "amounttemplate_generateifzero", &
		"amounttemplate_division", "entity_division", "amounttemplate_aggregatecalc", "amounttypeid", &
		"ref1typeid", "ref2typeid", "ref3typeid", "ratetypeid", "amounttypeid", "division", &
		"generateifzero", "aggregatecalc", "amounttype"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.Sorted = Yes", "ddlb.VScrollBar = Yes" }
	ELSE
		li_Return = -1
	END IF
	
case "amounttemplate_type"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.Sorted = Yes", "ddlb.VScrollBar = Yes" }
	ELSE
		li_Return = -1
	END IF
	
// jma 9.06.02  Central States work to make deductions show appropriately, when 
//    amounttemplate_intervaltype dropdown list box value is not 0.)		
case "amounttemplate_intervaltype"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.Sorted = No", "ddlb.VScrollBar = Yes" }
	ELSE
		li_Return = -1
	END IF
	
CASE "amounttemplate_interval", "amounttemplate_activationdate", "amounttemplate_targettotal"
	lsa_Settings [ UpperBound ( lsa_Settings ) + 1] = &
		"BackGround.Color = '12632256~tIF ( amounttemplate_intervaltype = 0,  12632256,  16777215 )'"
	lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
		"Protect = '0~tIF ( amounttemplate_intervaltype = 0, 1, 0 )'"
		
CASE "amounttemplate_runningtotal", "amounttemplate_runningcount", "amounttemplate_lastamount", &
	"amounttemplate_lastdate", "amounttemplate_firstdate"
	lsa_Settings [ UpperBound ( lsa_Settings ) + 1] = &
		"BackGround.Color = '16777215~tIF ( amounttemplate_intervaltype = 0, 12632256, 12648447 )'"
	lsa_Settings [ UpperBound ( lsa_Settings ) + 1 ] = &
		"Protect = '0~tIF ( amounttemplate_intervaltype = 0, 1, 0,  )'"	
	

// rdt 08-14-02
CASE "amounttemplate_custom1_t", "amounttemplate_custom2_t", "amounttemplate_custom3_t"
	//Trim the "_t" off the end of the object name
	ls_Work = Left ( as_ObjectName, Len ( as_ObjectName ) - 2 )

	IF This.Event ue_GetCustomLabel ( ls_Work, ls_Label ) = 1 THEN
		//A custom field label has been provided.  Relabel the field accordingly.
		lsa_Settings = { "Text = '" + ls_Label + "'" }
	ELSE
		//No custom field label has been provided for this column.
		//(ie, this custom field has not been defined.)
		//Leave the generic field label in place.
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

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);Integer	li_Return
String	ls_ValueList
n_cst_Ship_Type	lnv_ShipType
Long		lla_Empty[]

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName

CASE	"amounttemplate_ref1typeid", "amounttemplate_ref2typeid", "amounttemplate_ref3typeid", &
		"ref1typeid", "ref2typeid", "ref3typeid"
	IF This.of_GetCodeTable ( "n_cst_dlkc_refnumtype", ls_ValueList ) < 1 THEN
		li_Return = -1
	ELSE
		ls_ValueList += "[NONE]~t0/" 
	END IF

CASE "amounttemplate_amounttypeid", "amounttypeid", "amounttype"
	IF This.of_GetCodeTable ( "n_cst_dlkc_amounttype", ls_ValueList ) < 1 THEN
		li_Return = -1
	END IF

CASE "amounttemplate_generateifzero", "generateifzero"
	ls_ValueList = "YES~t1/NO~t0/"

CASE  "amounttemplate_ratetypeid", "ratetypeid"
	IF This.of_GetCodeTable ( "n_cst_dlkc_ratetype", ls_ValueList ) < 1 THEN
		li_Return = -1
	ELSE
		ls_ValueList += "[NONE]~t0/"
	END IF

CASE "amounttemplate_division", "entity_division", "division"
	IF lnv_ShipType.of_GetCodeTable ( "DIVISION", FALSE /*ActiveOnly*/, lla_Empty /*ReqIds*/, ls_ValueList ) < 1 THEN
		li_Return = -1
	ELSE
		IF Right ( ls_ValueList, 1 ) <> "/" THEN
			ls_ValueList += "/"
		END IF
		ls_ValueList += "[NONE]~t0/"
	END IF
	
CASE "amounttemplate_type" 	
	ls_ValueList = appeon_constant.cs_type_ValueList


CASE "amounttemplate_aggregatecalc", "aggregatecalc"
	ls_ValueList = "YES~t1/NO~t0/"
	
// jma 9.06.02  Central States project, deductions automatic, 
// not always visible.
	
CASE "amounttemplate_intervaltype" 	
	ls_ValueList = appeon_constant.cs_intervaltype_ValueList	

CASE ELSE
	li_Return = 0 
END CHOOSE

IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF

RETURN li_Return 
end function

on n_cst_presentation_amounttemplate.create
TriggerEvent( this, "constructor" )
end on

on n_cst_presentation_amounttemplate.destroy
TriggerEvent( this, "destructor" )
end on

event ue_getcustomsectionheader;// rdt 08-14-02
//Overriding ancestor to designate the custom section header for this class.

RETURN "AmountTemplate"
end event

