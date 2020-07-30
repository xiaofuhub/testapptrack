$PBExportHeader$u_dw_zonelocation.sru
forward
global type u_dw_zonelocation from u_dw
end type
end forward

global type u_dw_zonelocation from u_dw
integer width = 2080
integer height = 696
string dataobject = "d_zonelocation"
boolean border = false
borderstyle borderstyle = stylebox!
event ue_addrow ( )
event ue_deleterow ( )
event ue_clearblankrows ( )
end type
global u_dw_zonelocation u_dw_zonelocation

forward prototypes
private function integer of_filter (string as_name)
public function long of_getcompanyid (long al_Row)
public function long of_getsiteid (long al_row)
public function string of_getsitename (string as_value, ref n_cst_beo_company anv_company)
end prototypes

event ue_deleterow;long	ll_Row

ll_Row = THIS.GetRow ( )
IF ll_Row > 0 THEN
	THIS.DeleteRow ( ll_Row )
END IF
end event

event ue_clearblankrows;if this.accepttext() = 1 then
	this.setredraw(false)
	
	Long	ll_RowCount
	Long	i
	
	ll_RowCount = THIS.RowCount ( )
	FOR i = ll_RowCount TO 1 STEP -1
		IF IsNull (  THIS.GetItemString ( i , "location", Primary!, false )  ) or &
			len ( trim ( THIS.GetItemString ( i , "location", Primary!, false ) ) ) = 0 THEN
			THIS.RowsDiscard ( i, i, Primary! ) 
		END IF	
	NEXT
		
	ll_RowCount = THIS.FilteredCount ( )
	FOR i = ll_RowCount TO 1 STEP -1
		IF IsNull (  THIS.GetItemString ( i , "location", Filter!, false )  ) or &
			len ( trim ( THIS.GetItemString ( i , "location", Filter!, false ) ) ) = 0 THEN
			THIS.RowsDiscard ( i, i, Filter! ) 
		END IF	
	NEXT
		
	this.setredraw(true)
end if
end event

private function integer of_filter (string as_name);string	ls_zone, &
			ls_filter

if isnull(ls_zone) then
	ls_zone = ''
end if
ls_filter = "zonename = '" + trim(as_Name) + "'"
THIS.setfilter(ls_filter)
THIS.filter()

RETURN  1
end function

public function long of_getcompanyid (long al_Row);RETURN -1
end function

public function long of_getsiteid (long al_row);//Constant Boolean	lb_AllowHold = TRUE
//Constant Boolean	lb_Notify = FALSE
//Long		ll_ValidateId = 0
//Boolean	lb_Search = TRUE
//Boolean  lb_Employee 
//Boolean	lb_Company
//Boolean	lb_validate
//String	ls_Search = ""
//String	ls_type
Long		ll_Return
//Long		ll_CompanyID
//s_co_info	    lstr_Company
//
//IF al_Row > 0 THEN
//	ls_Search = THIS.GetItemString ( al_Row , "display" )
//	
//	IF Len  ( ls_Search ) > 0 THEN
//	
//		ll_Return = gnv_cst_Companies.of_Select &
//			( lstr_company, ls_Type, lb_Search, ls_Search, lb_Validate, &
//			  ll_ValidateId, lb_AllowHold, lb_Notify )
//		
//		IF ll_Return = 1 THEN
//			ll_Return = lstr_Company.co_id
//		ELSE
//			ll_Return = -1
//		END IF
//		
//	END IF
//END IF
//
String	ls_Value 

ls_Value = THIS.GetItemString ( al_Row , "location" )
IF isNumber ( ls_Value ) THEN
	ll_Return = Long ( ls_Value ) 
END IF

RETURN ll_Return



end function

public function string of_getsitename (string as_value, ref n_cst_beo_company anv_company);String	ls_Return
String	ls_Search = ""

n_cst_beo_company	lnv_company
ls_Search = Trim ( as_value  )

IF Len  ( ls_Search ) > 0 THEN
	
	lnv_company = gnv_cst_Companies.of_Select(ls_Search)
	if isvalid(lnv_company) then
		anv_company = lnv_company
		ls_return = lnv_company.of_getname()
	end if

END IF


RETURN ls_Return



end function

event itemchanged;call super::itemchanged;long		ll_return
long		ll_found
String	ls_Name, &
			ls_city, &
			ls_state, &
			ls_codename, &
			ls_display, &
			ls_id, &
			ls_null
			

n_cst_beo_company	lnv_company

setnull(ls_null)

ll_return = ancestorreturnvalue

CHOOSE CASE dwo.name
		
	CASE "display"
		IF THIS.GetItemNumber ( row , "type" ) = appeon_constant.ci_locationtype_site THEN
			ls_Name = THIS.of_GetSiteName ( data  , lnv_company ) 
			if isvalid(lnv_company) then
				ls_city = lnv_company.of_getcity()
				ls_state = lnv_company.of_getstate()
				ls_codename = lnv_company.of_getcodename()
				ls_id = String ( lnv_company.of_getid() )
			end if		
		
			IF len ( ls_Name ) > 0 THEN
				ll_found = THIS.FInd ( "location = '" + ls_id + "'" , 1 , this.rowcount() )
				if ll_found > 0 then
					if ll_found = row then
						ll_found = THIS.FInd ( "location = '" + ls_id + "'" , ll_found + 1 , this.rowcount() )
						if ll_found > 0 then
							ll_Return = 1
							MessageBox ( "Zone Location" , "The location entered already exists." )
							THIS.object.display[row] = ls_Null
						end if
					else
						ll_Return = 1
						MessageBox ( "Zone Location" , "The location entered already exists." )
						THIS.object.display[row] = ls_Null
					end if
				END IF
			
				if ll_return = 1 then
					//skip
				else
					if len(trim(ls_codename)) > 0 then
						ls_display = ls_codename + " : " + ls_name
					else
						ls_display = ls_name
					end if					
					ls_display = ls_display + " ("
					if len(trim(ls_city)) > 0 then
						ls_display = ls_display + ls_city
					end if
					if len(trim(ls_state)) > 0 then
						ls_display = ls_display + ", " + ls_state
					end if
					ls_display = ls_display + ")"
					
					THIS.post SetItem ( row, "display" , ls_display )
					THIS.post setItem ( row , "location" , String ( lnv_company.of_getid() ) )
				end if
				
			ELSE
				THIS.post SetItem ( row, "display" , "" )
				THIS.post setItem ( row , "location" , "" )
			END IF
		END IF
	CASE "type"
		THIS.post SetItem ( row, "display" , "" )
		THIS.post setItem ( row , "location" , "" )
		
END CHOOSE 

if isvalid(lnv_company) then
	destroy lnv_company
end if

RETURN ll_return
		
		
end event

event doubleclicked;Long	ll_ID
w_Company	lw_Co

if row > 0 then
	IF THIS.GetItemNumber ( row , "type" ) = appeon_constant.ci_locationtype_site THEN
		ll_ID = THIS.of_GetSiteID ( row ) 
		IF ll_ID > 0 THEN
			OpenSheetWithParm ( lw_Co , ll_ID ,gnv_App.of_GetFrame ( ) ,0, Original! )
		ELSE 
			Messagebox ( "Site details" , "Profit Tools could not resolve the site to display." )
		END IF
			
	END IF
end if
end event

event retrieveend;call super::retrieveend;Long	ll_RowCount 
Long	ll_i
Long	ll_CoID
Long	ll_CacheRow
String	ls_CoID, &
			ls_display, &
			ls_name, &
			ls_codename, &
			ls_city, &
			ls_state

n_cst_beo_Company	lnv_Company
lnv_Company = CREATE n_cst_Beo_Company
lnv_Company.of_SetUseCache ( TRUE ) 

THIS.SetFilter ( "type = " + String ( appeon_constant.ci_locationtype_site ) )
THIS.Filter ( ) 

ll_RowCount = THIS.RowCount ( ) 
FOR ll_i = 1 TO ll_RowCount
	
	ls_CoID = THIS.GetItemString ( ll_i , "location" ) 
	IF isNumber ( ls_CoID ) THEN
		ll_CoID = Long ( ls_CoID ) 
		ll_CacheRow = gnv_cst_companies.of_Find ( ll_CoID )
		IF ll_CacheRow > 0 THEN
			lnv_Company.of_SetSourceRow ( ll_CacheRow )
			ls_name = lnv_Company.of_GetName ( )
			ls_city = lnv_company.of_getcity()
			ls_state = lnv_company.of_getstate()
			ls_codename = lnv_company.of_getcodename()
			
			IF len ( ls_Name ) > 0 THEN
				if len(trim(ls_codename)) > 0 then
					ls_display = ls_codename + " : " + ls_name
				else
					ls_display = ls_name
				end if					
				ls_display = ls_display + " ("
				if len(trim(ls_city)) > 0 then
					ls_display = ls_display + ls_city
				end if
				if len(trim(ls_state)) > 0 then
					ls_display = ls_display + ", " + ls_state
				end if
				ls_display = ls_display + ")"
			end if	
			
			THIS.SetITem ( ll_i , "display" ,  ls_display)
		END IF
	END IF
	
NEXT

THIS.SetFilter( "" ) 
THIS.Filter ( )
THIS.ResetUpdate ( )

DESTROY ( lnv_Company )

RETURN AncestorReturnValue

end event

on u_dw_zonelocation.create
end on

on u_dw_zonelocation.destroy
end on

