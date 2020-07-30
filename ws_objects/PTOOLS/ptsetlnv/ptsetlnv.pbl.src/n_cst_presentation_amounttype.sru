$PBExportHeader$n_cst_presentation_amounttype.sru
forward
global type n_cst_presentation_amounttype from n_cst_presentation
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//string 	ss_settlementtypelist
//string	ss_shipmenttypelist
//string	ssa_freightlist[]
//string	ssa_accesslist[]
//string	ssa_combined[]
//string	ss_freightlist
//string	ss_accesslist
//string	ss_combined
////end modification Shared Variables by appeon  20070730
//
end variables

global type n_cst_presentation_amounttype from n_cst_presentation
end type

type variables
//set default 
integer	ii_category=n_cst_constants.ci_category_both
string	is_itemtype
string	is_filtertype
//begin modification Shared Variables by appeon  20070730
string 	ss_settlementtypelist
string	ss_shipmenttypelist
string	ssa_freightlist[]
string	ssa_accesslist[]
string	ssa_combined[]
string	ss_freightlist
string	ss_accesslist
string	ss_combined
//end modification Shared Variables by appeon  20070730

end variables

forward prototypes
protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist)
public subroutine of_filterbycategory (string as_valuelist)
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
public function string of_settypelist ()
public subroutine of_setcategory (integer ai_category)
public function string of_getshipmenttypelist (ref string lsa_list[])
public function string of_getsettlementtypelist (ref string lsa_list[])
public subroutine of_refreshtypelist ()
public subroutine of_filterbyitemtype ()
public function long of_getbyitemtype (string as_whichtype, ref string asa_amounts[])
public function string of_getbyitemtype (string as_whichtype)
public subroutine of_setamounttypefilter (string as_value)
public function string of_getamounttypefilter ()
public function integer of_getcodetablebycategory (ref string as_list)
end prototypes

protected function integer of_getvaluelist (string as_columnname, ref string as_valuelist);//Returns: 1 = Success, 0 = Column not found, -1 = Error
// rdt 08-14-02 Added itemtype and surcharge


Integer	li_Return
String	ls_ValueList

li_Return = 1
as_ValueList = ""

CHOOSE CASE as_ColumnName
CASE "amounttemplate_amounttypeid", "amounttypeid", "amounttype", "accountmap_amounttypeid", "amountowed_type" , "ratetable_amounttype"
	ls_valuelist = this.of_settypelist()
CASE "amounttype_category"
	ls_ValueList = "SETTLEMENT~t" + String ( n_cst_Constants.ci_Category_Payables ) +&
						"/SHIPMENT~t" + String ( n_cst_Constants.ci_Category_Receivables ) +&
						"/BOTH~t" + String ( n_cst_Constants.ci_Category_Both ) +&
						"/INACTIVE~t" + String ( n_cst_Constants.ci_Category_Inactive ) + "/"  

CASE "amounttype_typicalamount"
	ls_ValueList = "POSITIVE~t" + String ( appeon_constant.ci_TypicalAmount_Positive ) +&
						"/NEGATIVE~t" + String ( appeon_constant.ci_TypicalAmount_Negative ) +&
						"/EITHER~t" + String ( appeon_constant.ci_TypicalAmount_Either ) + "/"

CASE "amounttype_taxabledefault"
	ls_ValueList = "YES~t1/NO~t0"

CASE "amounttype_itemtype"
	ls_ValueList = n_cst_Constants.cs_ItemType_Freight_Description + "~t" + String(n_cst_Constants.cs_ItemType_Freight) + & 
						"/" + n_cst_Constants.cs_ItemType_Accessorial_Description + "~t" + String(n_cst_Constants.cs_ItemType_Accessorial ) +& 
						"/" + n_cst_Constants.cs_ItemType_None_Description+ "~t" + String( n_cst_Constants.cs_ItemType_None ) + "/"  
						
CASE "amounttype_surcharge"
	ls_ValueList = "BILL~t" + String(n_cst_Constants.cs_FuelSurcharge_Bill) + &
						"/PAY~t" + String(n_cst_Constants.cs_FuelSurcharge_Pay) + &
						"/NONE~t" + String(n_cst_Constants.cs_FuelSurcharge_None) + &
						"/BOTH~t" + String(n_cst_Constants.cs_FuelSurcharge_Both) + "/"

CASE ELSE						
	li_Return = 0

END CHOOSE

IF li_Return = 1 THEN
	as_ValueList = "Values = '" + ls_ValueList + "'"
END IF


RETURN li_Return
				
end function

public subroutine of_filterbycategory (string as_valuelist);string	lsa_result[],&
			lsa_amount[]
			
long		ll_ndx,&
			ll_arraycount

n_cst_string	lnv_string
n_cst_bcm		lnv_Cache
n_cst_beo_amounttype		lnv_Beo_amounttype
Integer	li_Return

IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_amounttype", lnv_Cache, TRUE, TRUE ) = 1 THEN

	//loop through id 
	IF lnv_String.of_ParseToArray ( as_valuelist, '/' , lsa_Result ) > 0 THEN
		ll_arraycount = upperbound(lsa_result)
		for ll_ndx = 1 to ll_arraycount
			IF lnv_String.of_ParseToArray ( lsa_result[ll_ndx], '~t' , lsa_amount ) > 0 THEN
				
				lnv_Beo_amounttype = lnv_Cache.GetBeo ( "amounttype_id = " + lsa_amount[2] )
				
				if isvalid(lnv_Beo_amounttype) then
					
					choose case lnv_Beo_amounttype.of_getcategory()
							
						case n_cst_constants.ci_category_payables
							ss_settlementtypelist += lsa_amount[1] + + '~t' + lsa_amount[2] + "/"
							
						case n_cst_constants.ci_category_receivables
							ss_shipmenttypelist += lsa_amount[1] + + '~t' + lsa_amount[2] + "/"
							
						case n_cst_constants.ci_category_both
							ss_settlementtypelist += lsa_amount[1] + + '~t' + lsa_amount[2] + "/"
							ss_shipmenttypelist += lsa_amount[1] + + '~t' + lsa_amount[2] + "/"
							
					end choose
					
					if lnv_Beo_amounttype.of_getcategory() = n_cst_constants.ci_category_inactive then
						//skip
					else
						//add everything except inactive to combined list
						ssa_combined[upperbound(ssa_combined) + 1] = lsa_result[ll_ndx]
						ss_combined += lsa_amount[1] + '~t' + lsa_amount[2] + "/"
					end if
					
				end if
			end if
		next
	end if

ELSE
	li_Return = -1

END IF

end subroutine

public function integer of_setpresentation (powerobject apo_target, string as_objectname);// rdt 08-14-02 Added itemtype and surcharge

String	lsa_Settings[], &
			ls_ValueList, &
			ls_Work, &
			ls_Label
			
Integer	li_Count, &
			li_Index, &
			li_Return


li_Return = 1
as_ObjectName = Lower ( as_ObjectName )


CHOOSE CASE as_ObjectName


//***AmountType Table***

CASE "amounttype_id"
	lsa_Settings = { "Protect = 1", "Background.Color = 12648447" }

CASE "amounttype_category", "amounttype_typicalamount", "amounttype_taxabledefault", "amountowed_type", &
		"amounttypeid", "amounttype", "amounttype_name", "accountmap_amounttypeid", "amounttemplate_amounttypeid", &
		"amounttype_itemtype", "amounttype_surcharge", "ratetable_amounttype"

	IF This.of_GetValueList ( as_ObjectName, ls_ValueList ) = 1 THEN
		lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.VScrollBar = Yes", "ddlb.Sorted = Yes"  }
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

RETURN li_Return

end function

public function string of_settypelist ();string 	ls_list, &
			lsa_settings[]
			
integer	li_index, &
			li_count

/*MFS 6/4/07 - Replaced this with of_GetCodeTableByCategory() calls below
if len ( trim(ss_settlementtypelist) ) > 0 or len ( trim(ss_shipmenttypelist) ) > 0 then
	//already have list
else
	IF This.of_GetCodeTable ( "n_cst_dlkc_amounttype", ls_List ) < 1 THEN
		//problem getting values
	else
		this.of_filterbycategory(ls_list)
	end if
end if
*/

if len(trim(ss_freightlist)) > 0 or len(trim(ss_accesslist)) > 0 then
	//already have lists
else
	this.of_filterbyitemtype()
end if

choose case ii_category

	case n_cst_constants.ci_category_payables
		
		IF Len(Trim(ss_settlementtypelist)) > 0 THEN
			//already have list
			ls_list = ss_settlementtypelist
		ELSE
			This.of_GetCodeTableByCategory(ls_List)
		END IF
		
	case n_cst_constants.ci_category_receivables
		
		choose case this.of_getamounttypefilter()
			case n_cst_constants.cs_itemtype_freight
				ls_list = ss_freightlist
			case n_cst_constants.cs_itemtype_accessorial
				ls_list = ss_accesslist
			case else
				IF Len(Trim(ss_shipmenttypelist) ) > 0 THEN
					//already have list
					ls_list = ss_shipmenttypelist
				ELSE
					This.of_GetCodeTableByCategory(ls_List)
				END IF
		end choose
		
	case else
		IF Len(Trim(ss_combined)) > 0 THEN
			//already have list
			ls_list = ss_combined
		ELSE
			This.of_GetCodeTableByCategory(ls_List)
		END IF
		
end choose

return ls_list

end function

public subroutine of_setcategory (integer ai_category);/*MFS 5/4/07 - We are no longer resetting the lists for performance reasons
if ai_category <> ii_category then
	this.of_refreshtypelist()
end if
*/
	
ii_category = ai_category
end subroutine

public function string of_getshipmenttypelist (ref string lsa_list[]);return ss_shipmenttypelist
end function

public function string of_getsettlementtypelist (ref string lsa_list[]);return ss_settlementtypelist
end function

public subroutine of_refreshtypelist ();//clear shared variables and reset
string	lsa_blank[]

ss_settlementtypelist=''
ss_shipmenttypelist=''
ss_combined = ''
ssa_combined =lsa_blank
//ssa_freightlist=lsa_blank
//ssa_accesslist=lsa_blank
//ss_freightlist = ''
//ss_accesslist = ''

end subroutine

public subroutine of_filterbyitemtype ();string	lsa_result[],&
			lsa_amount[], &
			ls_list
			
long		ll_ndx,&
			ll_arraycount
			
integer	li_category

n_cst_string	lnv_string
n_cst_bcm		lnv_Cache
n_cst_beo_amounttype		lnv_Beo_amounttype
Integer	li_Return

if len(trim(ss_freightlist)) > 0 or len(trim(ss_accesslist)) > 0 then
	//already have lists
else
	IF This.of_GetCodeTable ( "n_cst_dlkc_amounttype", ls_List ) < 1 THEN
		//problem getting values
	else
//		this.of_filterbycategory(ls_list)
	end if
	
	IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_amounttype", lnv_Cache, TRUE, TRUE ) = 1 THEN
	
		//loop through id 
		IF lnv_String.of_ParseToArray ( ls_list, '/' , lsa_Result ) > 0 THEN
			ll_arraycount = upperbound(lsa_result)
			
			for ll_ndx = 1 to ll_arraycount
				
				IF lnv_String.of_ParseToArray ( lsa_result[ll_ndx], '~t' , lsa_amount ) > 0 THEN
					
					lnv_Beo_amounttype = lnv_Cache.GetBeo ( "amounttype_id = " + lsa_amount[2] )
					
					if isvalid(lnv_Beo_amounttype) then
						
						li_category = lnv_Beo_amounttype.of_getcategory()
						
						if li_category = n_cst_constants.ci_category_receivables or &
							li_category = n_cst_constants.ci_category_both then
							
							choose case lnv_Beo_amounttype.of_getitemtype()
									
								case n_cst_constants.cs_ItemType_Freight
										ssa_freightlist[upperbound(ssa_freightlist) + 1] = lsa_result[ll_ndx]
										ss_freightlist += lsa_amount[1] + '~t' + lsa_amount[2] + "/"
										
								case n_cst_constants.cs_ItemType_Accessorial
										ssa_accesslist[upperbound(ssa_accesslist) + 1] = lsa_result[ll_ndx]
										ss_accesslist += lsa_amount[1] + '~t' + lsa_amount[2] + "/"
										
								case else
									//doesn't belong on list
									
							end choose
							
						end if
						
					end if
				end if
			next
		end if
	END IF
end if


end subroutine

public function long of_getbyitemtype (string as_whichtype, ref string asa_amounts[]);string lsa_blank[]

if upperbound(ssa_freightlist) > 0 or upperbound(ssa_accesslist) > 0 then
	//already have lists
else
	this.of_filterbyitemtype()
end if

choose case as_whichtype
	case n_cst_constants.cs_ItemType_Freight
		asa_amounts = ssa_freightlist
	case n_cst_constants.cs_ItemType_Accessorial
		asa_amounts = ssa_accesslist
	case else
		asa_amounts = ssa_combined
//		asa_amounts = lsa_blank
end choose

return upperbound(asa_amounts)
end function

public function string of_getbyitemtype (string as_whichtype);string	ls_list
			
if len(trim(ss_freightlist)) > 0 or len(trim(ss_accesslist)) > 0 then
	//already have lists
else
	this.of_filterbyitemtype()
end if

choose case as_whichtype
	case n_cst_constants.cs_ItemType_Freight
		ls_list = ss_freightlist
	case n_cst_constants.cs_ItemType_Accessorial
		ls_list = ss_accesslist
end choose

return ls_list
end function

public subroutine of_setamounttypefilter (string as_value);is_filtertype = as_value
end subroutine

public function string of_getamounttypefilter ();return is_filtertype
end function

public function integer of_getcodetablebycategory (ref string as_list);Integer	li_Return = 1

IF This.of_GetCodeTable ( "n_cst_dlkc_amounttype", as_list ) < 1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	This.of_filterbycategory(as_list)
END IF

Return li_Return
end function

on n_cst_presentation_amounttype.create
call super::create
end on

on n_cst_presentation_amounttype.destroy
call super::destroy
end on

