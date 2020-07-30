$PBExportHeader$n_cst_presentation_shipment.sru
forward
global type n_cst_presentation_shipment from n_cst_presentation
end type
end forward

global type n_cst_presentation_shipment from n_cst_presentation
end type

type variables
n_cst_ship_type			inv_ShipTypeManager
dwobject						idwo_ShipType
Long							ila_RequiredShipTypes[]
datawindow					idw_Source
DataStore					ids_Source
n_cst_dws					inv_dws
end variables

forward prototypes
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
public function string of_getpaymentterms ()
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

	lsa_PrefixCandidates = { "shipment_" }
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
		//Leave the generic field label in place if the first column
		IF as_ObjectName <> "custom1_t" THEN
			lsa_Settings = { "Visible = FALSE "}
		END IF
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
		//lsa_Settings = { "TabSequence = 0", "Background.Color = " + n_cst_Constants.cs_Color_NA }
		IF as_ObjectName = "custom1" THEN
			lsa_Settings = { "TabSequence = 0", "Background.Color = " + n_cst_Constants.cs_Color_NA }
		ELSE
			lsa_Settings = { "Visible = FALSE "}
		END IF
		//Note : Not sure why, but the background color doesn't take on the grid view.
	END IF


CASE "shipmenttype"
	Long							lla_RequiredShipTypes[]

	inv_Dws.of_resolvepowerobject( apo_target, idw_Source, ids_Source )
	
	IF isValid ( idw_Source ) THEN
		idwo_ShipType = idw_Source.object.ShipmentType
	ELSEIF isValid ( ids_Source ) THEN
		idwo_ShipType = ids_Source.object.ShipmentType
	END IF
	
	inv_ShipTypeManager.of_Ready ( TRUE )

	IF IsValid ( inv_ShipTypeManager ) THEN
	
		
		inv_ShipTypeManager.of_populate(idwo_ShipType, "ALL", true, &
				lla_RequiredShipTypes)
		
	END IF
	
CASE "paymentterms", "st_terms"	
	
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes", "ddlb.Sorted = Yes"  }
	ELSE
		li_Return = -1
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
end function

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);Integer	li_Return
String	ls_ValueList

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName
CASE "paymentterms", "st_terms"
	
	ls_valuelist = this.of_GetPaymentTerms()

CASE ELSE						
	li_Return = 0

END CHOOSE

IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF


RETURN li_Return
	
end function

public function string of_getpaymentterms ();Integer	li_Return
string	lsa_terms[], &
			ls_terms
			
			
long		ll_ndx,&
			ll_arraycount

n_cst_setting_billingpaymentterms	lnv_terms

lnv_terms = CREATE n_cst_setting_billingpaymentterms
lnv_terms.of_getvalue(lsa_terms)
DESTROY ( lnv_terms )


ll_arraycount = upperbound(lsa_terms)
for ll_ndx = 1 to ll_arraycount
	ls_terms += lsa_terms[ll_ndx] + + '~t' + lsa_terms[ll_ndx] + "/"
next

ls_terms = '' + '~t' + '' + "/" + ls_terms 

return ls_terms

end function

event ue_getcustomsectionheader;//Overriding ancestor to designate the custom section header for this class.

RETURN "ShipmentCustom"
end event

on n_cst_presentation_shipment.create
call super::create
end on

on n_cst_presentation_shipment.destroy
call super::destroy
end on

