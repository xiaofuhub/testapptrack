$PBExportHeader$u_dw_communication_setup_equipment.sru
forward
global type u_dw_communication_setup_equipment from u_dw
end type
end forward

global type u_dw_communication_setup_equipment from u_dw
integer width = 1929
integer height = 572
boolean hsplitscroll = true
end type
global u_dw_communication_setup_equipment u_dw_communication_setup_equipment

event constructor;// entries for new communication devices need to be added here
n_cst_Presentation_EquipmentSummary	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

String 	lsa_Settings[]
String	ls_ValueList
Int		li_Count
Int		li_Index

n_cst_LicenseManager	Lnv_LicenseMgr

IF lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_communicationdevice_Qualcomm ) THEN
	ls_ValueList = n_cst_Constants.cs_communicationdevice_Qualcomm + "~t" + n_cst_Constants.cs_communicationdevice_Qualcomm
END IF

IF lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_communicationdevice_Intouch ) THEN
	IF Len ( Trim ( ls_ValueList ) ) > 0 THEN
		ls_ValueList +=  "/"
	END IF
	ls_ValueList += n_cst_Constants.cs_communicationdevice_Intouch + "~t" + n_cst_Constants.cs_communicationdevice_Intouch
END IF

IF lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_communicationdevice_AtRoad ) THEN
	IF Len ( Trim ( ls_ValueList ) ) > 0 THEN
		ls_ValueList +=  "/"
	END IF
	ls_ValueList += n_cst_Constants.cs_communicationdevice_AtRoad + "~t" + n_cst_Constants.cs_communicationdevice_AtRoad
END IF

IF lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_communicationdevice_Cadec ) THEN
	IF Len ( Trim ( ls_ValueList ) ) > 0 THEN
		ls_ValueList +=  "/"
	END IF
	ls_ValueList += n_cst_Constants.cs_communicationdevice_Cadec + "~t" + n_cst_Constants.cs_communicationdevice_Cadec
END IF

//IF lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_communicationdevice_xxx ) THEN
//	IF Len ( Trim ( ls_ValueList ) ) > 0 THEN
//		ls_ValueList +=  "/"
//	END IF
//	ls_ValueList += n_cst_Constants.cs_communicationdevice_xxx + "~t" + n_cst_Constants.cs_communicationdevice_xxx
//END IF

ls_ValueList = "Values = '" + ls_ValueList + "'"		
		
lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No" }

li_Count = UpperBound ( lsa_Settings )
	
FOR li_Index = 1 TO li_Count

	THIS.Dynamic Modify ( "type." + lsa_Settings [ li_Index ] )

NEXT

THIS.of_SetRowSelect ( TRUE )
THIS.of_SetAutoSort ( TRUE )
THIS.of_SetAutoFilter ( TRUE )


end event

event pfc_addrow;call super::pfc_addrow;Long	ll_Return

ll_Return = AncestorReturnValue 

IF ll_Return > 0 THEN
	


	//Determine and set a value for Id
	Constant Boolean	cb_Commit = TRUE
	long	ll_NextId
	
	IF gnv_App.of_GetNextId ( "communication_device", ll_NextId, cb_Commit ) = 1 THEN
	
		THIS.Object.Id[ll_Return] = ll_NextId
		//Parent.Event ue_RouteChanged ( ll_NextId )
	
	END IF
	
	this.ScrollToRow ( ll_Return ) 
	
END IF

RETURN ll_Return
end event

event pfc_insertrow;call super::pfc_insertrow;Long	ll_Return

ll_Return = AncestorReturnValue 

IF ll_Return > 0 THEN
	


	//Determine and set a value for Id
	Constant Boolean	cb_Commit = TRUE
	long	ll_NextId
	
	IF gnv_App.of_GetNextId ( "communication_device", ll_NextId, cb_Commit ) = 1 THEN
	
		THIS.Object.Id[ll_Return] = ll_NextId
		//Parent.Event ue_RouteChanged ( ll_NextId )
	
	END IF
	
	this.ScrollToRow ( ll_Return ) 
	
END IF

RETURN ll_Return
end event

event pfc_deleterow;call super::pfc_deleterow;THIS.SelectRow ( GetRow () , TRUE )
Return AncestorReturnValue
end event

event ue_autofilter;call super::ue_autofilter;
inv_Filter.of_SetExclude ( { "employeeid" , "equipmentid" } ) 
//"employees_em_fn" , "employees_em_mn" , "employees_em_ln" , 
RETURN AncestorReturnValue


end event

event ue_autosort;call super::ue_autosort;Int	li_Return 

li_Return = AncestorReturnValue 


inv_Sort.of_SetExclude ( { "employeeid" , "equipmentid" } ) 


RETURN li_Return
end event

on u_dw_communication_setup_equipment.create
end on

on u_dw_communication_setup_equipment.destroy
end on

