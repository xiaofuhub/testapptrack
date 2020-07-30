$PBExportHeader$n_cst_presentation_ratetable.sru
forward
global type n_cst_presentation_ratetable from n_cst_presentation
end type
end forward

global type n_cst_presentation_ratetable from n_cst_presentation
end type

forward prototypes
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
public function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
end prototypes

public function integer of_setpresentation (powerobject apo_target, string as_objectname);String	lsa_Settings[], &
			ls_ValueList, &
			ls_Work
Integer	li_Count, &
			li_Index, &
			li_Return

n_cst_LicenseManager	lnv_LicenseManager

li_Return = 1
as_ObjectName = Lower ( as_ObjectName )


CHOOSE CASE as_ObjectName

CASE "rateunit" ,"ratetable_breakunit","breakunit", "di_our_ratetype", "di_pay_ratetype", "rate_type"
	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.vscrollbar=yes"  }
	ELSE
		li_Return = -1
	END IF
case "lastratedby", "lastratedby_t", "formatedtaglist",  &
	 "cb_ratelookup", "cb_autorate", "originzone", "originzone_t", &
	 "destinationzone", "destinationzone_t", "billtoid", "billtoid_t"	//, "rateas_t" //, "eventflag"
	 
//	 "ratecodename", "ratecodename_t",

	IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating  ) THEN
		//don't hide
	else
		lsa_Settings = { "Visible=0" }
	end if
	
END CHOOSE

IF li_Return = 1 THEN

	li_Count = UpperBound ( lsa_Settings )
	
	FOR li_Index = 1 TO li_Count
	
		apo_Target.Dynamic Modify ( as_ObjectName + "." + lsa_Settings [ li_Index ] )
	
	NEXT

END IF

RETURN li_Return

end function

public function integer of_getvaluelist (string as_columnname, ref string as_valuelist);//Returns: 1 = Success, 0 = Column not found, -1 = Error

Integer	li_Return
String	ls_ValueList

n_cst_bso_rating	lnv_Rating

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName

CASE "rateunit" , "ratetable_breakunit" , "breakunit"
	lnv_Rating = create n_cst_bso_rating
	
	ls_ValueList = lnv_Rating.of_getValueList(FALSE /*don't include 'none' type */)
	if len(ls_valuelist) = 0 then
		li_return = -1
	end if
					
	destroy lnv_Rating
	
CASE "di_our_ratetype", "di_pay_ratetype", "rate_type"
	lnv_Rating = create n_cst_bso_rating
	
	ls_ValueList = lnv_Rating.of_getValueList(TRUE /*don't include 'none' type */)
	if len(ls_valuelist) = 0 then
		li_return = -1
	end if
					
	destroy lnv_Rating
	
	
CASE ELSE						
	li_Return = 0

END CHOOSE

IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF


RETURN li_Return
				
end function

on n_cst_presentation_ratetable.create
call super::create
end on

on n_cst_presentation_ratetable.destroy
call super::destroy
end on

