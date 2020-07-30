$PBExportHeader$n_cst_presentation_company.sru
forward
global type n_cst_presentation_company from n_cst_presentation
end type
end forward

shared variables

end variables

global type n_cst_presentation_company from n_cst_presentation
end type

forward prototypes
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
end prototypes

public function integer of_setpresentation (powerobject apo_target, string as_objectname);String	lsa_Settings[], &
			ls_ValueList, &
			ls_Work, &
			ls_Label, &
			ls_Prefix, &
			lsa_PrefixCandidates[]

Integer	li_Count, &
			li_Return, &
			li_Index, &
			li_CandidateLength, &
			li_CandidateCount


li_Return = 1
as_ObjectName = Lower ( as_ObjectName )


IF Pos ( as_ObjectName, "_" ) > 0 THEN

	lsa_PrefixCandidates = { "co_", "company_" }
	li_CandidateCount = UpperBound ( lsa_PrefixCandidates )

	FOR li_Index = 1 TO li_CandidateCount

		IF Pos ( as_ObjectName, lsa_PrefixCandidates [ li_Index ] ) = 1 THEN
	
			li_CandidateLength = Len ( lsa_PrefixCandidates [ li_Index ] )
			as_ObjectName = Mid ( as_ObjectName, li_CandidateLength + 1 )
			ls_Prefix = lsa_PrefixCandidates [ li_Index ]
			EXIT

		END IF

	NEXT

END IF


CHOOSE CASE as_ObjectName

CASE "defaultduration"
	lsa_Settings = { "Format = 'h:mm'", "Edit.Format = 'h:mm'" }

CASE "hiddendiscount"
	lsa_Settings = { "Format = '0.0##%;-0.0##%;0.0%;NONE'", "Edit.Format = '0.00###'" }

CASE  "bill_same", "billsame", "status", &
	"bill_attn", "billingattn", "timezone", "usnon", "bill_usnon", "billingusnon"

	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList /*, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes"*/ }
	ELSE
		li_Return = -1
	END IF

// allow billing was in the list above. But there was no drop down for it. I moved it here for 3.8 <<*>>
CASE  "allow_billing", "allowbilling", "terminationlocation", "brok_carriers_bc_common", "brok_carriers_bc_broker", "brok_carriers_bc_contract", "brok_carriers_bc_hazmat"

	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes" }
	ELSE
		li_Return = -1
	END IF

CASE "custom1_t", "custom2_t", "custom3_t", "custom4_t", "custom5_t", &
	"custom6_t", "custom7_t", "custom8_t", "custom9_t", "custom10_t"

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

CASE "custom1", "custom2", "custom3", "custom4", "custom5", &
	"custom6", "custom7", "custom8", "custom9", "custom10"

	IF This.Event ue_GetCustomLabel ( as_ObjectName, ls_Label ) = 1 THEN
		//A custom field label has been provided.  
		//No changes are needed to the field.
	ELSE
		//No custom field label has been provided for this column.
		//(ie, this custom field has not been defined.)
		//Disable the field and remove it from the tab order.
		//(Note : Using Protect = 1 instead causes a problem on the tab view if the first column is protected:  
		//When the user tabs in from the tab control, the row focus jumps to row 1.)
		//Also, using this taborder setting will prevent an undefined custom column from 
		//being queryable, even though it will be included in the QueryCols list by default.
		//Protect and DisplayOnly are cleared for QueryCols, but not TabOrder.
		lsa_Settings = { "TabSequence = 0", "Background.Color = " + n_cst_Constants.cs_Color_NA }
		//Note : Not sure why, but the background color doesn't take on the grid view.
	END IF

CASE ELSE
	li_Return = 0
	
END CHOOSE

IF li_Return = 1 THEN

	li_Count = UpperBound ( lsa_Settings )
	as_ObjectName = ls_Prefix + as_ObjectName
	
	FOR li_Index = 1 TO li_Count
	
		apo_Target.Dynamic Modify ( as_ObjectName + "." + lsa_Settings [ li_Index ] )
	
	NEXT

END IF

RETURN li_Return


//////////////////////

/*
//If custom fields have been designated, apply the labels.
//Otherwise, disable the columns by taking them out of the tabsequence.
//(Note : Using Protect = 1 instead causes a problem if the first column is protected:  When the user
//tabs in from the tab control, the row focus jumps to row 1.)

IF Len ( ss_Custom1 ) > 0 THEN
	This.Modify ( "Custom1_t.Text = '" + ss_Custom1 + "'" )
ELSE
	This.Modify ( "Custom1.TabSequence = 0  Custom1.Background.Color = " + n_cst_Constants.cs_Color_NA )
END IF

IF Len ( ss_Custom2 ) > 0 THEN
	This.Modify ( "Custom2_t.Text = '" + ss_Custom2 + "'" )
ELSE
	This.Modify ( "Custom2.TabSequence = 0  Custom2.Background.Color = " + n_cst_Constants.cs_Color_NA )
END IF

IF Len ( ss_Custom3 ) > 0 THEN
	This.Modify ( "Custom3_t.Text = '" + ss_Custom3 + "'" )
ELSE
	This.Modify ( "Custom3.TabSequence = 0  Custom3.Background.Color = " + n_cst_Constants.cs_Color_NA )
END IF

IF Len ( ss_Custom4 ) > 0 THEN
	This.Modify ( "Custom4_t.Text = '" + ss_Custom4 + "'" )
ELSE
	This.Modify ( "Custom4.TabSequence = 0  Custom4.Background.Color = " + n_cst_Constants.cs_Color_NA )
END IF

IF Len ( ss_Custom5 ) > 0 THEN
	This.Modify ( "Custom5_t.Text = '" + ss_Custom5 + "'" )
ELSE
	This.Modify ( "Custom5.TabSequence = 0  Custom5.Background.Color = " + n_cst_Constants.cs_Color_NA )
END IF

/////////////////////////////////

//If custom fields have been designated, apply the labels.
//Otherwise, disable the columns by taking them out of the tabsequence.
//(Note : Using Protect = 1 instead causes a problem if the first column is protected:  When the user
//tabs in from the tab control, the row focus jumps to row 1.)

IF Len ( ss_Custom6 ) > 0 THEN
	This.Modify ( "Custom6_t.Text = '" + ss_Custom6 + "'" )
ELSE
	This.Modify ( "Custom6.TabSequence = 0  Custom6.Background.Color = " + n_cst_Constants.cs_Color_NA )
END IF

IF Len ( ss_Custom7 ) > 0 THEN
	This.Modify ( "Custom7_t.Text = '" + ss_Custom7 + "'" )
ELSE
	This.Modify ( "Custom7.TabSequence = 0  Custom7.Background.Color = " + n_cst_Constants.cs_Color_NA )
END IF

IF Len ( ss_Custom8 ) > 0 THEN
	This.Modify ( "Custom8_t.Text = '" + ss_Custom8 + "'" )
ELSE
	This.Modify ( "Custom8.TabSequence = 0  Custom8.Background.Color = " + n_cst_Constants.cs_Color_NA )
END IF

IF Len ( ss_Custom9 ) > 0 THEN
	This.Modify ( "Custom9_t.Text = '" + ss_Custom9 + "'" )
ELSE
	This.Modify ( "Custom9.TabSequence = 0  Custom9.Background.Color = " + n_cst_Constants.cs_Color_NA )
END IF

IF Len ( ss_Custom10 ) > 0 THEN
	This.Modify ( "Custom10_t.Text = '" + ss_Custom10 + "'" )
ELSE
	This.Modify ( "Custom10.TabSequence = 0  Custom10.Background.Color = " + n_cst_Constants.cs_Color_NA )
END IF
*/
end function

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);Integer	li_Return
String	ls_ValueList

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName

CASE "allow_billing", "allowbilling", "terminationlocation", "brok_carriers_bc_common", "brok_carriers_bc_broker", "brok_carriers_bc_contract", "brok_carriers_bc_hazmat"

	ls_ValueList = "YES~tT/NO~tF/"

CASE "bill_same", "billsame"
	ls_ValueList = "SAME~tT/DIFFERENT~tF/"

CASE "status"
	ls_ValueList = "ACTIVE~tK/HOLD~tH/DELETED~tD/"

CASE "bill_attn", "billingattn"
	ls_ValueList = "NONE~tN/AP + TEXT~tF/TEXT + AP~tL/TEXT ONLY~tO/"

CASE "timezone"
	ls_ValueList = n_cst_Constants.cs_TimeZoneCodeTable

CASE "usnon", "bill_usnon", "billingusnon"
	ls_ValueList = "YES~tU/NO~tN/"

CASE ELSE
	li_Return = 0
				
END CHOOSE


IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF


RETURN li_return
end function

on n_cst_presentation_company.create
call super::create
end on

on n_cst_presentation_company.destroy
call super::destroy
end on

event ue_getcustomsectionheader;//Overriding ancestor to designate the custom section header for this class.

RETURN "CompanyCustom"
end event

