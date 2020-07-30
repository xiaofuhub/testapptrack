$PBExportHeader$u_dw_entitylist.sru
forward
global type u_dw_entitylist from u_dw
end type
end forward

global type u_dw_entitylist from u_dw
int Width=3621
int Height=260
string DataObject="d_entitylist"
boolean HScrollBar=true
boolean HSplitScroll=true
end type
global u_dw_entitylist u_dw_entitylist

event constructor;//Extending Ancestor

This.of_SetTransObject ( SQLCA )
This.of_SetInsertable ( FALSE )
This.of_SetDeleteable ( FALSE )

n_cst_Presentation_AmountTemplate	lnv_Presentation
lnv_Presentation.of_SetPresentation ( THIS )
end event

event retrieveend;call super::retrieveend;//Extending Ancestor

//Populate the Entity_Name field (if there is one) for the result set.

Long		ll_Return, &
			ll_Row, &
			ll_EmployeeId, &
			ll_CompanyId
String	ls_Name
Boolean	lb_HasEmployeeColumn, &
			lb_HasCompanyColumn, &
			lb_HasNameColumn
n_cst_EmployeeManager	lnv_EmployeeManager
n_cst_beo_Company			lnv_Company

lnv_Company = CREATE n_cst_beo_Company

IF RowCount > 0 THEN

	//Check whether the relevant columns exist on this dataobject.
	lb_HasNameColumn = Integer ( This.Describe ( "Entity_Name.Id" ) ) > 0
	lb_HasEmployeeColumn = Integer ( This.Describe ( "Entity_fkEmployee.Id" ) ) > 0
	lb_HasCompanyColumn = Integer ( This.Describe ( "Entity_fkCompany.Id" ) ) > 0

	//If the name column doesn't exist, there's nothing to populate, so check it.

	IF lb_HasNameColumn THEN
	
		//Loop through the rows and populate the name column.

		FOR ll_Row = 1 TO RowCount

			SetNull ( ll_EmployeeId )
			SetNull ( ll_CompanyId )
			SetNull ( ls_Name )
	
			IF lb_HasEmployeeColumn THEN
				ll_EmployeeId = This.Object.Entity_fkEmployee [ ll_Row ]
			END IF

			IF lb_HasCompanyColumn THEN
				ll_CompanyId = This.Object.Entity_fkCompany [ ll_Row ]
			END IF
	
			IF NOT IsNull ( ll_CompanyId ) THEN
	
				gnv_cst_Companies.of_Cache ( ll_CompanyId, FALSE )
		
				lnv_Company.of_SetUseCache ( TRUE )
				lnv_Company.of_SetSourceId ( ll_CompanyId )
		
				IF lnv_Company.of_HasSource ( ) THEN
					This.Object.Entity_Name [ ll_Row ] = lnv_Company.of_GetName ( )
					This.SetItemStatus ( ll_Row, "Entity_Name", Primary!, NotModified! )
				END IF
	
			ELSEIF NOT IsNull ( ll_EmployeeId ) THEN
	
				IF lnv_EmployeeManager.of_DescribeEmployee ( ll_EmployeeId, ls_Name, &
					appeon_constant.ci_DescribeType_FirstLast ) = 1 THEN

					This.Object.Entity_Name [ ll_Row ] = ls_Name
					This.SetItemStatus ( ll_Row, "Entity_Name", Primary!, NotModified! )

				END IF
	
			END IF
	
		NEXT

	END IF

END IF

DESTROY lnv_Company

RETURN AncestorReturnValue
end event

event itemchanged;call super::itemchanged;//Extending Ancestor

//Trap "0" value for entity_division, which is "[None]" in the list box.
//Convert it to null.

Long	ll_Return, &
		ll_Null

ll_Return = AncestorReturnValue

IF ll_Return = 0 THEN
	
	CHOOSE CASE Lower ( dwo.Name )
			
		CASE "entity_division"
			
			IF Data = "0" THEN
				SetNull ( ll_Null )
				dwo.Primary [ Row ] = ll_Null
				ll_Return = 2
			END IF
			
	END CHOOSE
	
END IF

RETURN ll_Return
end event

