$PBExportHeader$u_tabpage_company.sru
$PBExportComments$Route company.
forward
global type u_tabpage_company from u_tabpg
end type
type dw_companyinfo from u_dw_company within u_tabpage_company
end type
end forward

global type u_tabpage_company from u_tabpg
integer width = 2144
integer height = 964
event ue_companyadded ( long al_coid )
event ue_companyremoved ( long al_companyid )
dw_companyinfo dw_companyinfo
end type
global u_tabpage_company u_tabpage_company

forward prototypes
private function integer of_getcompany (long al_row, boolean ab_search, string as_search)
end prototypes

private function integer of_getcompany (long al_row, boolean ab_search, string as_search);Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Long		ll_ValidateId = 0
Boolean  lb_Employee 
Boolean	lb_Company
Boolean	lb_validate
String	ls_type
Long		ll_CoID
long		ll_Return
Int	 	li_CoSelectRtn
s_co_info	astr_Company
n_cst_beo_company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

li_CoSelectRtn = gnv_cst_Companies.of_Select	( astr_company, ls_Type, ab_Search, as_Search, lb_Validate, &
ll_ValidateId, lb_AllowHold, lb_Notify )

IF li_CoSelectRtn > 0 THEN // check this rtn !!!! 

	ll_CoID = astr_Company.co_ID
	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_SetSourceID ( ll_CoID )
	IF IsValid ( lnv_Company ) THEN 
		
		//Is this company already part of the route

		IF dw_companyinfo.Find ( "co_id = " + string ( ll_CoID ), 1 , dw_companyinfo.RowCount() ) > 0 THEN
			messagebox ( "Add New Company", "The company you selected is already part of the route." ) 
			ll_Return = 0 
		ELSE
			dw_companyinfo.object.co_id[al_Row] = astr_Company.co_ID
			dw_companyinfo.object.co_Name[al_Row] = lnv_Company.of_GetName ( )
			dw_companyinfo.object.co_addr1[al_Row] = lnv_Company.of_Getaddress1 ( )
			dw_companyinfo.object.co_addr2[al_Row] = lnv_Company.of_Getaddress2 ( )
			dw_companyinfo.object.co_city[al_Row] = lnv_Company.of_Getcity ( )
			dw_companyinfo.object.co_state[al_Row] = lnv_Company.of_Getstate ( )
			dw_companyinfo.object.co_Code_Name[al_Row] = lnv_Company.of_GetCodeName ( )
			dw_companyinfo.ScrollToRow ( al_Row ) 
			ll_Return = li_CoSelectRtn
		END IF
		
	END IF
	
ELSE
	ll_Return = 0 // no Row was added

END IF

DESTROY lnv_Company

return ll_Return
end function

on u_tabpage_company.create
int iCurrent
call super::create
this.dw_companyinfo=create dw_companyinfo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_companyinfo
end on

on u_tabpage_company.destroy
call super::destroy
destroy(this.dw_companyinfo)
end on

event constructor;call super::constructor;//Extending Ancestor


//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_companyinfo
inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
	ldo_Reference.Y + ldo_Reference.Height + li_Border )

//Register resizable controls
This.inv_resize.of_Register ( dw_companyinfo, 'ScaleToRight&Bottom' )

//Trigger resize event to perform initial resize of tabpage contents
This.TriggerEvent ( "Resize" )


RETURN AncestorReturnValue
end event

type dw_companyinfo from u_dw_company within u_tabpage_company
integer x = 18
integer y = 16
integer width = 2089
integer height = 920
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event pfc_addrow;call super::pfc_addrow;Long	ll_Return
Integer	li_RetVal


ll_Return = AncestorReturnValue

IF ll_Return > 0 THEN // row was added

	li_RetVal = parent.of_GetCompany ( ll_Return, FALSE, '' )
	
	IF li_RetVal = 0 	THEN
		//then no company was selected, delete the row
		dw_companyinfo.DeleteRow ( ll_Return )
		ll_Return = 0 
		
	ELSE
		PARENT.Event ue_CompanyAdded ( dw_companyinfo.object.co_id[ll_Return] )

	END IF

END IF

return ll_Return
end event

event pfc_deleterow;// overRide w/ Call TO Super

Long	ll_Row
Long	ll_CoID
Long	ll_Return = 1

Long	test
IF THIS.RowCount( )  > 0 THEN
	ll_Row = THIS.GetRow ( )
	IF ll_Row > 0 THEN
		ll_CoId = THIs.Object.co_ID [ll_Row]
		
		
		ll_Return = SUPER::EVENT pfc_DeleteRow ( )
		
		//ll_Return = AncestorReturnValue
		
		IF ll_Return = 1 THEN
			PArent.Event ue_CompanyRemoved ( ll_CoID ) 
			
		END IF
	ELSE
		MessageBox ( "Delete Row" , "Please select a row to be deleted." ) 
	END IF
END IF
RETURN 1

end event

event pfc_insertrow;call super::pfc_insertrow;Long	ll_Return
Integer	li_RetVal


ll_Return = AncestorReturnValue

IF ll_Return > 0 THEN // row was added

	li_RetVal = parent.of_GetCompany ( ll_Return, FALSE, '' )
	
	IF li_RetVal = 0 	THEN
		//then no company was selected, delete the row
		dw_companyinfo.DeleteRow ( ll_Return )
		ll_Return = 0 
		
	ELSE
		PARENT.Event ue_CompanyAdded ( dw_companyinfo.object.co_id[ll_Return] )

	END IF

END IF

return ll_Return
end event

event constructor;call super::constructor;
of_SetAutoSort ( TRUE )

end event

event rbuttondown;string lsa_parm_labels[]
any laa_parm_values[]

choose case dwo.name
	case "co_name"
		lsa_parm_labels[1] = "MENU_TYPE"
		laa_parm_values[1] = "COMPANY"
		lsa_parm_labels[2] = "CO_ID"
		laa_parm_values[2] = this.object.co_id[row]
		f_pop_standard(lsa_parm_labels, laa_parm_values)
		
	case else
		SUPER::event rbuttondown(xpos,ypos,row,dwo)
		
end choose
end event

