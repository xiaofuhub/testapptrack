$PBExportHeader$u_dw_co_list.sru
forward
global type u_dw_co_list from u_dw
end type
end forward

global type u_dw_co_list from u_dw
int Width=1719
string DataObject="d_company_list"
end type
global u_dw_co_list u_dw_co_list

forward prototypes
public function long of_getselectedids (ref long ala_coids[])
public function long of_getselectedcompanies (ref n_cst_beo_Company anva_Companies[])
end prototypes

public function long of_getselectedids (ref long ala_coids[]);Long	ll_i
Long	ll_Count
Long	lla_SelectedIDS[]
Long	lla_SelectedRows []


ll_Count = THIS.inv_RowSelect.of_SelectedCount ( lla_SelectedRows )

FOR ll_i = 1 TO ll_Count
	
	lla_SelectedIDS [ ll_i ] = THIS.GetItemNumber ( lla_SelectedRows[ ll_i ] , "co_id" )
	
NEXT
ala_coids[] = lla_SelectedIDS

RETURN UpperBound ( ala_coids[] )
end function

public function long of_getselectedcompanies (ref n_cst_beo_Company anva_Companies[]);Long	ll_i
Long	ll_Count
Long	lla_SelectedIDS[]
Long	lla_SelectedRows []
Long	ll_Row
Long	ll_CoID 

n_cst_beo_Company	lnva_Companies[]

ll_Count = THIS.inv_RowSelect.of_SelectedCount ( lla_SelectedRows )

FOR ll_i = 1 TO ll_Count
	
	ll_CoID = THIS.GetItemNumber ( lla_SelectedRows[ ll_i ], "co_id" )
	lnva_Companies [ ll_i ] = CREATE n_cst_beo_Company 
	gnv_cst_companies.of_Cache ( ll_CoID , TRUE ) 
	lnva_Companies [ ll_i ].of_SetUseCache ( TRUE ) 
	lnva_Companies [ ll_i ].of_SetSourceID ( ll_CoID )
	
NEXT

anva_Companies[] = lnva_Companies

RETURN UpperBound ( anva_Companies[ ] )
end function

event constructor;THIS.of_SetRowSelect ( TRUE )




end event

