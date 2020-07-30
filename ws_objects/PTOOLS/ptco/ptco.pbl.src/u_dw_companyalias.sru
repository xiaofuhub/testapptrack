$PBExportHeader$u_dw_companyalias.sru
forward
global type u_dw_companyalias from u_dw
end type
end forward

global type u_dw_companyalias from u_dw
integer width = 1477
integer height = 620
string dataobject = "d_companyalias"
event type long ue_addinitialrow ( )
end type
global u_dw_companyalias u_dw_companyalias

type variables
Long	il_PtCo
sTRING	is_Sql
end variables

forward prototypes
public function integer of_retrieve (long al_ptcoid)
end prototypes

event type long ue_addinitialrow();Long	ll_Row
ll_Row = THIS.event pfc_addrow( )
THIS.SetItemStatus( ll_Row , 0,Primary!, NotModified! )
RETURN ll_Row
end event

public function integer of_retrieve (long al_ptcoid);String	ls_Sql
il_ptco = al_ptcoid

//ls_Sql = "Select * from companyalias where ptcoid = " +String ( al_PtCoID )
//ls_Sql = 'SELECT "companyalias"."contextcompanyid", "companyalias"."ptcoid", "companies"."co_name", "companyalias"."context"' + & 
//ls_Sql = ' SELECT  "companies"."co_name","companyalias"."contextcompanyid", "companyalias"."ptcoid", "companyalias"."context"' + & 
//			' FROM "companyalias","companies"'  + &
//         ' WHERE ( "companyalias"."context" = "companies"."co_id" AND "companyalias"."ptcoid" =  '+String ( al_PtCoID ) + ' )'
			
//is_sql = THIS.GetSqlselect( )


//THIS.SetSqlSelect( ls_Sql )
THIS.Retrieve( al_ptcoid )

RETURN 1

end function

on u_dw_companyalias.create
end on

on u_dw_companyalias.destroy
end on

event constructor;call super::constructor;THIS.SetTransObject ( sqlca ) 
 THIS.Post Event ue_AddInitialrow( )


end event

event pfc_insertrow;call super::pfc_insertrow;Long	ll_NewRow
ll_NewRow = AncestorReturnValue

IF ll_NewRow > 0 THEN
	THIS.Setitem ( ll_NewRow, "ptcoid" , il_ptco )
	THIS.SetRow ( ll_NewRow ) 
	THIS.SetColumn ( "Context" )
END IF

RETURN ll_NewRow
end event

event pfc_addrow;call super::pfc_addrow;Long	ll_NewRow
ll_NewRow = AncestorReturnValue

IF ll_NewRow > 0 THEN
	THIS.Setitem ( ll_NewRow, "ptcoid" , il_ptco )
	THIS.SetRow ( ll_NewRow ) 
	THIS.SetColumn ( 1 )
END IF

RETURN ll_NewRow
end event

event pfc_preupdate;call super::pfc_preupdate;Int	li_Return
Long	ll_RowCount

ll_RowCount = THIS.RowCount ( )

li_Return = AncestorReturnValue

IF li_Return = Success THEN
	
	THIS.SetFilter('IsNull ( context ) AND isNull ( contextCompanyid ) ')
	THIS.Filter()
	
	ll_RowCount = THIS.RowCount ( )
	IF ll_RowCount > 0 THEN
		THIS.rowsdiscard( 1, ll_RowCount, PRIMARY! )	
	END IF 	
END IF

IF li_Return = success THEN
	THIS.SetFilter ( "" )
	THIS.Filter ( )
	//Step 1: First sort the records in Datawindow 
	THIS.SetSort('context A, ptcoid A , contextcompanyid')
	THIS.Sort()
	
	
	THIS.SetFilter('IsNull ( context ) OR isNull ( contextCompanyid ) ')
	THIS.Filter()
	
	ll_RowCount = THIS.RowCount ( )
	IF ll_RowCount > 0 THEN
		THIS.SetFilter ( "" )
		THIS.Filter ( )
		MessageBox ( "Alias list" , "Please enter both a company and that companies' identifier." )
		THIS.SetRow ( 1 ) 
		THIS.SetColumn ( 1 ) 
		THIS.Post SetFocus ( )
		li_Return = -1

	ELSE	
		THIS.SetFilter ( "" )
		THIS.Filter ( )
	END IF	
END IF

IF li_Return = success THEN
	DO 
		
		THIS.SetFilter(' ( context = context[1] AND contextcompanyid = contextcompanyid[1] ) OR ( context = context[-1] AND contextcompanyid = contextcompanyid[-1] )')
		THIS.Filter()
	
		ll_RowCount = THIS.RowCount ( )
		IF ll_RowCount > 0 THEN
			THIS.DeleteRow ( 1 )
		END IF
	
		
	LOOP UNTIL ll_RowCount = 0

END IF
//DO 
//	
//	//Step 2: 
//	THIS.SetFilter('IsNull (context) AND ( contextcompanyid = contextcompanyid[1]  OR contextcompanyid = contextcompanyid[-1] )  ')
//	THIS.Filter()
//
//	ll_RowCount = THIS.RowCount ( )
//	IF ll_RowCount > 0 THEN
//		THIS.DeleteRow ( 1 )
//	END IF
//
//	
//LOOP UNTIL ll_RowCount = 0
//
//DO 
//	
//	//Step 2: 
//	THIS.SetFilter('IsNull (contextcompanyid) AND ( context = context[1]  OR  context = context[-1] ) ')
//	THIS.Filter()
//
//	ll_RowCount = THIS.RowCount ( )
//	IF ll_RowCount > 0 THEN
//		THIS.DeleteRow ( 1 )
//	END IF
//
//	
//LOOP UNTIL ll_RowCount = 0


RETURN li_Return
end event

event editchanged;call super::editchanged;Long	ll_RowCount

ll_RowCount = THIS.RowCount ( )
IF ll_RowCount > 0 THEN
	IF isNull ( THIS.GetItemstring ( ll_RowCount , "companies_co_name" ) )  AND isNull ( THIS.GetItemstring ( ll_RowCount , "contextcompanyid" ) ) THEN
	ELSE
		ll_RowCount = THIS.InsertRow ( 0 )
		THIS.SetItem ( ll_RowCount , "ptcoid" , il_ptco )
	END IF
END IF
end event

event itemchanged;call super::itemchanged;Long	ll_Return
String	ls_Search
String	ls_DisplayName
Long		ll_CoID
	
n_cst_beo_Company	lnv_Company
	
ll_Return = AncestorReturnValue

IF ll_Return = 0 THEN
	IF row > 0 AND dwo.name = "companies_co_name" THEN	
		ls_Search = Trim ( data  )
		SetNull ( ll_CoID )
		SetNull ( ls_DisplayName )
		IF Len  ( ls_Search ) > 0 THEN
		
			lnv_Company = gnv_cst_Companies.of_Select ( ls_Search , TRUE, TRUE )
			
			IF IsValid ( lnv_Company ) THEN
				
				ll_CoID = lnv_Company.of_GetID ( )
				ls_DisplayName = lnv_Company.of_GetName ( ) 
				destroy lnv_company
				ll_Return = 2
				
				THIS.Object.companies_co_name [ row ] = ls_DisplayName
				THIS.Object.Context [ row ] = ll_CoID
				
			ELSE 
				ll_Return = 1
				THIS.Post SetItem ( row , "companies_co_name" , ls_DisplayName )
				THIS.Post SetItem ( row , "Context" , ll_CoID )
			//	THIS.post SetColumn ( 1 ) 
			END IF
	
			
		END IF
	END IF
END IF

RETURN ll_Return
end event

event itemerror;call super::itemerror;Long	ll_Return

ll_Return = ancestorReturnValue

IF dwo.name = "companies_co_name" THEN
	ll_Return = 1
	
END IF

RETURN ll_Return
end event

