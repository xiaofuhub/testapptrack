$PBExportHeader$u_cst_syssettings_company_populate.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings_company_populate from u_cst_syssettings_generic_populate
end type
end forward

global type u_cst_syssettings_company_populate from u_cst_syssettings_generic_populate
end type
global u_cst_syssettings_company_populate u_cst_syssettings_company_populate

event ue_setproperty;call super::ue_setproperty;Long	lla_CoIds[]
Long	ll_Ctr
Long	ll_Count
String	ls_Name

n_cst_beo_Company	lnv_Company
lnv_Company = Create n_cst_beo_Company

anv_setting.of_GetValue ( lla_CoIds )

gnv_cst_companies.of_cache(  lla_CoIds , TRUE )

lnv_Company.of_SetUseCache ( TRUE )

ll_Count = UpperBound(lla_CoIds)
FOR ll_Ctr = 1 TO ll_Count
	lnv_Company.of_SetSourceID ( lla_CoIds[ll_Ctr] )
	uo_1.of_insertitem(lnv_Company.of_getCodeName( )  + "  (" + & 
						lnv_Company.of_GetCity( ) + ")", lla_CoIds[ll_Ctr] )	 // Shows company code Name + City
NEXT

uo_1.event ue_SetColumnHeader(inv_syssetting.of_getcolheader( ))

DESTROY ( lnv_Company )
RETURN -1


end event

on u_cst_syssettings_company_populate.create
int iCurrent
call super::create
end on

on u_cst_syssettings_company_populate.destroy
call super::destroy
end on

type uo_1 from u_cst_syssettings_generic_populate`uo_1 within u_cst_syssettings_company_populate
end type

event uo_1::ue_rowadded;call super::ue_rowadded;String ls_Values
String	ls_CodeName

n_Cst_beo_Company	lnv_Co

lnv_Co = gnv_cst_companies.of_Select( '' )
IF isValid ( lnv_Co ) THEN

	ls_CodeName = lnv_Co.of_GetCodeName( )
	IF LEN ( ls_CodeName ) > 0 THEN
	
		IF isValid ( lnv_Co ) THEN
			THIS.of_insert ( al_newRow , ls_CodeName + "(" + lnv_Co.of_GetCity( ) + ")", lnv_Co.of_GetID ( ) ) 
			DESTROY ( lnv_Co ) 	
		END IF
		
		ls_Values = event ue_collectitems( ) 
		
		event ue_savevalues(ls_Values)
	
	ELSE
		dw_1.DeleteRow( al_newrow )
		MessageBox ( "System Settings", "Any company selected here must have a code-name assigned to it."  )
	END IF
		
ELSE
	dw_1.DeleteRow( al_newrow )
END IF
end event

event uo_1::ue_collectitems;call super::ue_collectitems;Int li_Ctr
Long ll_RowCount
String ls_Values
String ls_Item

dw_1.AcceptText()
ll_RowCount = dw_1.RowCount()

FOR li_Ctr = 1 TO ll_RowCount
	ls_Item = dw_1.Object.hidden_Values[li_Ctr] 
	IF IsNull(ls_Item) THEN
		Exit
	END IF
	ls_Values = ls_Values + ls_Item + ';'
NEXT 

ls_Values = Left(ls_Values,(Len(ls_Values) - 1))

Return ls_Values
end event

event uo_1::ue_savevalues;call super::ue_savevalues;inv_syssetting.of_Savevalue(as_values)

end event

