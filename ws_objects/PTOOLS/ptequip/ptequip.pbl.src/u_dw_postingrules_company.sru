$PBExportHeader$u_dw_postingrules_company.sru
forward
global type u_dw_postingrules_company from u_dw_postingrules
end type
end forward

global type u_dw_postingrules_company from u_dw_postingrules
integer width = 2830
integer height = 692
string dataobject = "d_postingrules_company"
end type
global u_dw_postingrules_company u_dw_postingrules_company

on u_dw_postingrules_company.create
end on

on u_dw_postingrules_company.destroy
end on

event itemchanged;call super::itemchanged;Long	ll_Return

ll_Return = AncestorReturnValue	

IF Row > 0 THEN
	CHOOSE CASE dwo.name
			
		CASE "companyname" , "overridecompanyname"
			IF Len ( data ) > 0 THEN
				Long	ll_CoId
				String	ls_name
				n_Cst_beo_Company	lnv_Company
				
				lnv_Company = gnv_cst_companies.of_Select( data )
				IF ISvalid ( lnv_Company ) THEN
					ll_CoID = lnv_Company.of_GetID ( )
					ls_name = lnv_Company.of_Getname( )
				
					IF dwo.name = "companyname" THEN	
						
						IF THIS.Find( "equipmentpostingrulescompany_companyid = " +String	( ll_CoId ) ,1, THIS.RowCount ( ) ) > 0 THEN
						
							MessageBox ( "Company Rules" , ls_name + " already exists in the list and cannot be entered more than once." )
							THIS.Post SetItem ( row , "companyname" , "" )
						ELSE
					
							THIS.Post SetItem ( row , "equipmentpostingrulescompany_companyid" , ll_CoID )
							THIS.Post SetItem ( row , "companyname" , ls_Name )
						END IF
					ELSEIF dwo.name = "overridecompanyname" THEN
						THIS.Post SetItem ( row , "equipmentpostingrulescompany_overridelocation" , ll_CoID )
						THIS.Post SetItem ( row , "overridecompanyname" , ls_Name )
					END IF
					
					ll_Return = 2
				ELSE
					ll_Return = 0
				END IF
				
			END IF
			
	END CHOOSE
	
END IF
end event

event pfc_addrow;call super::pfc_addrow;Long	ll_Return 

ll_Return = AncestorReturnValue

IF ll_Return > 0 THEN
	THIS.SetItem ( ll_Return , "excludeifbillto" , 0 )
	THIS.SetRow ( ll_Return )
	THIS.SetColumn( 1 )
	THIS.SetFocus( )
END IF
RETURN ll_Return
//THIS.SetRow 
end event

event pfc_preupdate;call super::pfc_preupdate;Long	ll_RowCount
Long	i
ll_RowCount = THIS.RowCount ( )

FOR i = ll_RowCount TO 1 STEP -1
	
	IF ISNull ( THIS.GetItemNumber ( i , "equipmentpostingrulescompany_companyid" ) ) THEN
		THIS.DeleteRow ( i ) 
	END IF
	
NEXT

RETURN AncestorReturnValue
end event

