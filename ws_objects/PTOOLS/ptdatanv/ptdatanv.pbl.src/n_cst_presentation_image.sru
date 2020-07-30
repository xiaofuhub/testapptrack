$PBExportHeader$n_cst_presentation_image.sru
forward
global type n_cst_presentation_image from n_cst_presentation
end type
end forward

global type n_cst_presentation_image from n_cst_presentation
end type

forward prototypes
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
end prototypes

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);//Returns: 1 = Success, 0 = Column not found, -1 = Error

Integer	li_Return
String	ls_ValueList

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName
CASE "imagetype_topic"
//		ls_ValueList = n_cst_beo_imageType.cs_ImageTopic_ValueList  // this wasn't working right
																						// so I hard coded.
		ls_ValueList = "SHIPMENT~tSHIPMENT/"
CASE "imagetype_type"
		ls_ValueList = appeon_constant.cs_ImageType_ValueList
		
CASE "imagetype_category"
		ls_ValueList = "SECURE~tSECURE/UNSECURE~tUNSECURE/"	
		
CASE "image_category"
		ls_ValueList = "SECURE~tSECURE/UNSECURE~tUNSECURE/"
		
CASE "image_type"
		n_cst_bso_imageManager_pegasus lnv_Peg
		lnv_peg = Create n_cst_bso_imageManager_pegasus
		lnv_peg.of_GetTypeValueList ( "SHIPMENT" ,ls_ValueList )
		DESTROY lnv_peg
		
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
//***ImageType ***

//	CASE "imagetype_topic"
//		IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
//			lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes" }
//		ELSE
//			li_Return = -1
//		END IF
		
	CASE "imagetype_topic"
		IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
			lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes" }
		ELSE
			li_Return = -1
		END IF
		
	CASE "image_category"
		IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
			lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes" }
		ELSE
			li_Return = -1
		END IF
		
	CASE "image_type"
		IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
			lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes" }
		ELSE
			li_Return = -1
		END IF	

	CASE "imagetype_category"
		IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
			lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes" }
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

Return li_Return

end function

on n_cst_presentation_image.create
call super::create
end on

on n_cst_presentation_image.destroy
call super::destroy
end on

