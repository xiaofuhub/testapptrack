$PBExportHeader$n_cst_bso_accountingmanager.sru
forward
global type n_cst_bso_accountingmanager from n_cst_bso
end type
end forward

global type n_cst_bso_accountingmanager from n_cst_bso
end type
global n_cst_bso_accountingmanager n_cst_bso_accountingmanager

forward prototypes
public function integer of_getentity (long al_id, ref n_cst_beo_entity anv_entity)
public function boolean of_createcarrierpayable ()
public function boolean of_blankpayablesaccount (n_cst_accountingdata anva_accountingdata[])
public function boolean of_blankpayrollaccount (n_cst_accountingdata anva_accountingdata[])
public function boolean of_blankreceivablesaccount (n_cst_accountingdata anva_accountingdata[])
public function long of_createdata (n_cst_beo_shipment anva_shipment[], date ad_invoice, string as_category, ref n_cst_accountingdata anva_accounting[])
public function integer of_getaccount (integer ai_shiptype, integer ai_amounttype, string as_category, boolean ab_credit, ref string as_account)
public function string of_getaccounterror (integer ai_amounttype)
public subroutine of_addtoarrays (string as_account, decimal ac_amount, ref string asa_account[], ref decimal aca_amount[], boolean ab_freightitem, ref string asa_freighttype[])
public function integer of_checkforaccounts (n_cst_beo_shipment anv_shipment, ref n_cst_msg anv_msg)
public subroutine of_applydiscount (n_cst_beo_shipment anv_shipment, ref decimal ac_amount, ref decimal ac_discountremainder)
public function integer of_validateaccounts (string as_accounttype)
end prototypes

public function integer of_getentity (long al_id, ref n_cst_beo_entity anv_entity);integer	li_return

n_cst_bcm					lnv_BCM
n_cst_beo_company			lnv_company
n_cst_beo_entity			lnv_entity

lnv_Company = CREATE n_cst_beo_Company

gnv_cst_Companies.of_Cache ( al_id, TRUE )

lnv_Company.of_SetUseCache ( TRUE )
lnv_Company.of_SetSourceId ( al_id )

IF lnv_Company.of_HasSource ( ) THEN
	
	gnv_App.inv_CacheManager.of_SetAutoCache ( TRUE )
	gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_entity", lnv_Bcm, TRUE, TRUE )
	
	IF IsValid ( lnv_Bcm ) THEN
	
		lnv_entity = lnv_bcm.GetBeo ( "entity_companyid = " + String ( al_id ) )
	
		IF IsValid ( lnv_entity ) THEN
			anv_entity = lnv_entity
			li_return = 1
		else
			li_return = 0
		END IF
	
	END IF

//	IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_entity", lnv_Cache ) = 1 THEN
//	
//		lnv_entity = lnv_Cache.GetBeo ( "entity_id = " + String ( al_id ) )
//	
//		IF IsValid ( lnv_entity ) THEN
//			anv_entity = lnv_entity
//			li_return = 1
//		else
//			li_return = 0
//		END IF
//	end if	
	
END IF

DESTROY lnv_Company

return li_return

end function

public function boolean of_createcarrierpayable ();any		la_Setting
string	ls_Setting
boolean	lb_create

n_cst_Settings lnv_Settings 

CHOOSE CASE lnv_Settings.of_GetSetting( 100, la_Setting ) 
	CASE 0
		//no setting, don't create
		lb_create=FALSE
		
	CASE 1
		ls_Setting = string ( la_Setting ) 
		
		CHOOSE CASE ls_Setting
				
			CASE "YES!"
				
				lb_create=TRUE
								
			CASE "NO!"
				lb_create=FALSE
				
			CASE "ASK!"
				CHOOSE CASE messagebox("Create Carrier Payable", &
									"Do you want to create a payables batch file for carriers?", Question!, YesNo!)
									
					CASE 1
						lb_create=TRUE
						
					CASE 2
						lb_create=FALSE
						
				END CHOOSE
				
		END CHOOSE
		
	CASE ELSE
		lb_create=FALSE
		
END CHOOSE

return lb_create

end function

public function boolean of_blankpayablesaccount (n_cst_accountingdata anva_accountingdata[]);//making sure there are no empty ones

long	ll_ndx, &
		ll_ndx2, &
		ll_count, &
		ll_count2
		
string	lsa_apaccount[], &
			lsa_costaccount[]
			
boolean	lb_blank

ll_count = upperbound(anva_accountingdata)

for ll_ndx = 1 to ll_count
	anva_accountingdata[ll_ndx].of_getDistributionapaccount(lsa_apaccount)
	anva_accountingdata[ll_ndx].of_getDistributioncostaccount(lsa_costaccount)

	ll_count2 = upperbound(lsa_apaccount)

	for ll_ndx2 = 1 to ll_count2
		if len(trim(lsa_apaccount[ll_ndx2])) = 0 or isnull(lsa_apaccount[ll_ndx2]) then
			lb_blank = true
			exit
		end if
	next
	
	if not lb_blank then
		ll_count2 = upperbound(lsa_costaccount)
	
		for ll_ndx2 = 1 to ll_count2
			if len(trim(lsa_costaccount[ll_ndx2])) = 0 or isnull(lsa_costaccount[ll_ndx2]) then
				lb_blank = true
				exit
			end if
		next
	end if
	
	if not lb_blank then
		exit
	end if
	
next

return lb_blank

end function

public function boolean of_blankpayrollaccount (n_cst_accountingdata anva_accountingdata[]);//making sure there are no empty ones

long	ll_ndx, &
		ll_ndx2, &
		ll_count, &
		ll_count2
		
string	lsa_apaccount[], &
			lsa_costaccount[]
			
boolean	lb_valid = true

ll_count = upperbound(anva_accountingdata)

for ll_ndx = 1 to ll_count
	anva_accountingdata[ll_ndx].of_getDistributionapaccount(lsa_apaccount)
	anva_accountingdata[ll_ndx].of_getDistributioncostaccount(lsa_costaccount)

	ll_count2 = upperbound(lsa_apaccount)

	for ll_ndx2 = 1 to ll_count2
		if len(trim(lsa_apaccount[ll_ndx2])) = 0 then
			lb_valid = false
			exit
		end if
	next
	
	if lb_valid then
		ll_count2 = upperbound(lsa_costaccount)
	
		for ll_ndx2 = 1 to ll_count2
			if len(trim(lsa_costaccount[ll_ndx2])) = 0 then
				lb_valid = false
				exit
			end if
		next
	end if
	
	if not lb_valid then
		exit
	end if
	
next

return lb_valid

end function

public function boolean of_blankreceivablesaccount (n_cst_accountingdata anva_accountingdata[]);//making sure there are no empty ones

long	ll_ndx, &
		ll_ndx2, &
		ll_count, &
		ll_count2
		
string	lsa_apaccount[], &
			lsa_costaccount[]
			
boolean	lb_valid = true

ll_count = upperbound(anva_accountingdata)

for ll_ndx = 1 to ll_count
	anva_accountingdata[ll_ndx].of_getDistributionapaccount(lsa_apaccount)
	anva_accountingdata[ll_ndx].of_getDistributioncostaccount(lsa_costaccount)

	ll_count2 = upperbound(lsa_apaccount)

	for ll_ndx2 = 1 to ll_count2
		if len(trim(lsa_apaccount[ll_ndx2])) = 0 then
			lb_valid = false
			exit
		end if
	next
	
	if lb_valid then
		ll_count2 = upperbound(lsa_costaccount)
	
		for ll_ndx2 = 1 to ll_count2
			if len(trim(lsa_costaccount[ll_ndx2])) = 0 then
				lb_valid = false
				exit
			end if
		next
	end if
	
	if not lb_valid then
		exit
	end if
	
next

return lb_valid

end function

public function long of_createdata (n_cst_beo_shipment anva_shipment[], date ad_invoice, string as_category, ref n_cst_accountingdata anva_accounting[]);//this code creates accounting data for carriers only
// RDT 5-26-03 code to add CompanyID to accountingdata
any	la_value

long	ll_carrierid, &
		ll_entityid, &
		ll_shipndx, &
		ll_itemndx, &
		ll_shipcount, &
		ll_itemcount, &
		ll_objectcount, &
		ll_CompanyId // RDT 5-26-03

		
string	ls_entityname, &
			ls_PayablesId, &
			ls_PayrollId, &
			ls_ReceivablesId, &
			ls_holdaccount, &
			ls_account, &
			ls_AcctLink, &
			lsa_costaccount[], &
			lsa_apaccount[], &
			lsa_blank[]
			
String	lsa_DistributionNote[]
/*
I am going to be populating the Distribution array with an empty string for the time being
because other objects using the light-weight accountingdata object assume that all of the
arrays for the distributions have been populated. So we will end up with an array boundry exceeded (ABE) 
if I don't. 
The settlements payables populate it with 'real' data.
<<*>>
*/
			
decimal	lca_distamount[], &
			lc_holdamount, &
			lc_totalamount, &
			lca_quantity[], &
			lca_blank[], &
			lc_amount, &
			lc_freighttotal, &
			lc_accesstotal, &
			lc_grandtotal

integer	li_shiptype, &
			li_amounttype
			
Int		li_DataCount

boolean	lb_UseCompanyName

Constant String	cs_LockId = "accountingmanager"

n_cst_Settings	lnv_Settings

n_cst_accountingdata		lnva_accountingdata[]			
n_cst_ShipmentManager	lnv_ShipmentMgr
n_cst_beo_entity			lnv_entity
n_cst_beo_item				lnva_item[], &
								lnva_clearitem[]
n_cst_beo_company			lnv_company

lnv_Company = CREATE n_cst_beo_Company

//determine if we are using the company name or the entity id name
//For quickbooks we are using the company name if there is no entity id
//are we using quickbooks?
CHOOSE CASE lnv_Settings.of_GetAcctLink ( ls_AcctLink )

CASE 1, 0  //Use Value as returned by reference

CASE ELSE  //Error -- Fail
	ls_AcctLink = ''

END CHOOSE

//RDT 01-21-03 changed to check left chars
//CHOOSE CASE ls_AcctLink
CHOOSE CASE Left ( ls_AcctLink, 25 )

	CASE "n_cst_acctlink_quickbooks"
		lb_UseCompanyName = TRUE
		
	CASE ELSE
		lb_UseCompanyName = FALSE
		
END CHOOSE

ll_shipcount = upperbound(anva_shipment)

for ll_shipndx = 1 to ll_shipcount
	
	ls_holdaccount =''
	ls_account = ''
	lsa_costaccount = lsa_blank
	lsa_apaccount = lsa_blank
	lsa_DistributionNote = lsa_blank 
	lca_distamount = lca_blank
	lc_holdamount = 0
	lc_totalamount = 0
	lca_quantity = lca_blank
	ll_carrierid = 0
	ls_EntityName = ''
	ls_ReceivablesId = ''
	ll_entityid = 0
	ls_PayrollId = ''
	ls_PayablesId = ''
	ll_CompanyId = 0 // RDT 5-26-03
	li_DataCount = 0
	
	
	if isvalid ( anva_shipment[ll_shipndx] ) then
		//ok
	else
		continue
	end if
	
	ll_carrierid = anva_shipment[ll_shipndx].of_getcarrier()

	gnv_cst_Companies.of_Cache ( ll_carrierid, TRUE )
	
	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_SetSourceId ( ll_carrierid )

	IF lnv_Company.of_HasSource ( ) THEN
		ls_EntityName = lnv_Company.of_GetName()
		ll_CompanyID  = lnv_Company.of_Getid ( )	// RDT 5-26-03
	END IF
	
	If Len ( Trim( ls_EntityName ) ) = 0 Then 
		//don't create carrier data
		CONTINUE
	end if
	
	if this.of_getentity(ll_carrierid, lnv_entity) = 1 then
		CHOOSE CASE upper(as_category)
			CASE 'RECEIVABLES'
				ls_ReceivablesId = lnv_Entity.of_GetReceivablesId ( )
				ll_entityid = lnv_Entity.of_Getid()
				if isnull(ls_ReceivablesId) or len(trim(ls_ReceivablesId)) = 0 then
					if lb_UseCompanyName then
						ls_ReceivablesId = ls_EntityName
					else
						ls_ReceivablesId = ''
					end if
				end if
			CASE 'PAYROLL'
				ls_PayrollId = lnv_Entity.of_GetPayrollId ( )
 				ll_entityid = lnv_Entity.of_Getid()
				if isnull(ls_PayrollId) then
					ls_PayrollId = ''
				end if
			CASE 'PAYABLES'
				ls_PayablesId = lnv_Entity.of_GetPayablesId ( )
				ll_entityid = lnv_Entity.of_Getid()
				if isnull(ls_PayablesId) or len(trim(ls_PayablesId)) = 0 then
					if lb_UseCompanyName then
						ls_PayablesId = ls_EntityName
					else
						ls_PayablesId = ''
					end if
				end if
		END CHOOSE	
	else
		choose case upper(as_category)
			case 'RECEIVABLES'
				ls_ReceivablesId = ls_EntityName
			CASE 'PAYABLES'
				ls_PayablesId = ls_EntityName
		end choose	
	end if
	
	li_shiptype = anva_shipment[ll_shipndx].of_gettype()
	
	choose case anva_shipment[ll_shipndx].of_GetPayableFormat ( )
			
		case appeon_constant.cs_PayableFormat_Item

			//loop thru items for amounttypes
			anva_shipment[ll_shipndx].of_LockItemList ( cs_LockId )
			lnva_item = lnva_clearitem
			ll_itemcount = anva_shipment[ll_shipndx].of_getitemlist(lnva_item)
			
			for ll_itemndx = 1 to ll_itemcount
			
				lc_amount = lnva_item[ll_itemndx].of_getpayableamount()
				
				if lc_amount = 0 then
					continue
				end if
				
				/*
				I changed the use of the loop index. the loop index was used to put values into the array, but if 
				we did not have an lc_amount and CONTINUED, the array would have a blank entry, resulting in Sharon having 
				to deal with angry customers
				
				
				*/
				li_DataCount ++
				
				li_amounttype = lnva_item[ll_itemndx].of_getamounttype()
				
				this.of_getaccount(li_shiptype, li_amounttype, as_category, TRUE/*credit*/, ls_account ) 
				lsa_apaccount[li_DataCount] = ls_account
				
				this.of_getaccount(li_shiptype, li_amounttype, as_category, FALSE/*credit*/, ls_account ) 
				lsa_costaccount[li_DataCount] = ls_account
				lca_distamount[li_DataCount] = lc_amount
				lc_totalamount += lca_distamount[li_DataCount]
				lca_quantity[li_DataCount] = lnva_item[ll_itemndx].of_getquantity()
				
				//transaction account will be account of largest amount
				if lca_distamount[li_DataCount] > lc_holdamount then
					lc_holdamount = lca_distamount[li_DataCount]
					ls_holdaccount = lsa_apaccount[li_DataCount]
				end if
				
			next
			
		case appeon_constant.cs_PayableFormat_Category
			lc_freighttotal = anva_shipment[ll_shipndx].of_getfreightpayable()
			//FREIGHT
			if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
				li_amounttype = integer(la_value)
			end if
			
			if lc_freighttotal > 0 then		
				this.of_getaccount(li_shiptype, li_amounttype, as_category, TRUE/*credit*/, ls_account ) 
				lsa_apaccount[upperbound(lsa_apaccount) + 1] = ls_account
				this.of_getaccount(li_shiptype, li_amounttype, as_category, FALSE/*credit*/, ls_account ) 
				lsa_costaccount[upperbound(lsa_costaccount) + 1] = ls_account
				lca_distamount[upperbound(lca_distamount) + 1] = lc_freighttotal
				lc_totalamount += lc_freighttotal
				ls_holdaccount = ls_account
			end if
			
			lc_accesstotal = anva_shipment[ll_shipndx].of_getaccessorialpayable()		
			//ACCESS
			if lnv_Settings.of_GetSetting ( 99 , la_value ) > 0 then
				li_amounttype = integer(la_value)
			end if
			if lc_accesstotal > 0 then		
				this.of_getaccount(li_shiptype, li_amounttype, as_category, TRUE/*credit*/, ls_account ) 
				lsa_apaccount[upperbound(lsa_apaccount) + 1] = ls_account
				this.of_getaccount(li_shiptype, li_amounttype, as_category, FALSE/*credit*/, ls_account ) 
				lsa_costaccount[upperbound(lsa_costaccount) + 1] = ls_account
				lca_distamount[upperbound(lca_distamount) + 1] = lc_accesstotal
				lc_totalamount += lc_accesstotal
				if lc_accesstotal > lc_freighttotal then
					ls_holdaccount = ls_account
				end if
			end if		
			
		case appeon_constant.cs_PayableFormat_Total
			lc_grandtotal = anva_shipment[ll_shipndx].of_Getpayabletotal()	
			//grand total goes to default freight account
			if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
				li_amounttype = integer(la_value)
			end if
			if lc_grandtotal > 0 then		
				this.of_getaccount(li_shiptype, li_amounttype, as_category, TRUE/*credit*/, ls_account ) 
				lsa_apaccount[upperbound(lsa_apaccount) + 1] = ls_account
				ls_holdaccount = ls_account
				this.of_getaccount(li_shiptype, li_amounttype, as_category, FALSE/*credit*/, ls_account ) 
				lsa_costaccount[upperbound(lsa_costaccount) + 1] = ls_account
				lca_distamount[upperbound(lca_distamount) + 1] = lc_grandtotal
				lc_totalamount += lc_grandtotal
				
			end if
									
	end choose
			
	if lc_totalamount > 0 then
	
		//Make Transaction entries
		ll_objectcount = upperbound(lnva_accountingdata) + 1
		lnva_accountingdata[ll_objectcount] = create n_cst_accountingdata
		
		lnva_accountingdata[ll_objectcount].of_setbatchid("CARRIER")
		lnva_accountingdata[ll_objectcount].of_setcategory(as_category)
		lnva_accountingdata[ll_objectcount].of_settransactionaccount(ls_holdaccount)
		lnva_accountingdata[ll_objectcount].of_setEntityName(ls_EntityName)
		lnva_accountingdata[ll_objectcount].of_setEntityid(ll_entityid)
		lnva_accountingdata[ll_objectcount].of_setPayablesId(ls_PayablesId)
		lnva_accountingdata[ll_objectcount].of_setPayrollId(ls_PayrollId)
		lnva_accountingdata[ll_objectcount].of_setReceivablesId(ls_ReceivablesId)	
		lnva_accountingdata[ll_objectcount].of_setEntityType()
		lnva_accountingdata[ll_objectcount].of_setpretaxnet ( lc_totalamount )	
		//tmp as document #
		lnva_accountingdata[ll_objectcount].of_setDocumentNumber (string(anva_shipment[ll_shipndx].of_getid()))
		lnva_accountingdata[ll_objectcount].of_setShipType ( anva_shipment[ll_shipndx].of_getType ( ) )
		lnva_accountingdata[ll_objectcount].of_setPublicNote ('')
		lnva_accountingdata[ll_objectcount].of_setref1text ( anva_shipment[ll_shipndx].of_getref1text() )	
		lnva_accountingdata[ll_objectcount].of_setref2text ( anva_shipment[ll_shipndx].of_getref2text() )	
		lnva_accountingdata[ll_objectcount].of_setref3text ( anva_shipment[ll_shipndx].of_getref3text() )	
		lnva_accountingdata[ll_objectcount].of_setDescription (lnva_accountingdata[ll_objectcount].of_GetRefNumbers () )
		//invoice date as document date	
		//if the user selected shipdate then the argument would have been set to null
		if isnull( ad_invoice ) then
			lnva_accountingdata[ll_objectcount].of_setDocumentdate ( anva_shipment[ll_shipndx].of_GetShipdate ( ) )
			//add 30 for due date 
			lnva_accountingdata[ll_objectcount].of_setDuedate (relativedate(anva_shipment[ll_shipndx].of_GetShipdate ( ),30))				
		else
			lnva_accountingdata[ll_objectcount].of_setDocumentdate ( ad_invoice )
			//add 30 for due date 
			lnva_accountingdata[ll_objectcount].of_setDuedate (relativedate(ad_invoice,30))				
		end if
		lnva_accountingdata[ll_objectcount].of_setDistributionapaccount(lsa_apaccount)
		lnva_accountingdata[ll_objectcount].of_setDistributioncostaccount(lsa_costaccount)
		lnva_accountingdata[ll_objectcount].of_setDistributionamount(lca_distamount)
		lnva_accountingdata[ll_objectcount].of_setDistributionquantity (lca_quantity )
		
		lnva_accountingdata[ll_objectcount].of_setCompanyId ( ll_CompanyId ) // RDT 5-26-03

		lsa_DistributionNote[ UpperBound ( lca_distamount ) ] = ""  // here is where I am avoiding ABE
		lnva_accountingdata[ll_objectcount].of_setdistributionnote( lsa_DistributionNote ) 

	end if
	
	anva_shipment[ll_shipndx].of_ReleaseItemList ( cs_LockId )

	FOR ll_itemndx = 1 TO ll_ItemCount
		DESTROY  ( lnva_item[ll_itemndx] )
	NEXT

next

anva_accounting = lnva_accountingdata

DESTROY lnv_Company
RETURN upperbound(anva_accounting)

end function

public function integer of_getaccount (integer ai_shiptype, integer ai_amounttype, string as_category, boolean ab_credit, ref string as_account);string	ls_findstring, &
			ls_Account

long		ll_findrow

integer	li_return = 1, &
			li_division, &
			li_amounttype
			
datastore					lds_AccountMap
n_cst_dws					lnv_dws
								
lnv_dws.of_CreateDataStoreByDataObject ( "d_dlkc_accountmap", lds_AccountMap, FALSE )
lds_AccountMap.Retrieve()

ls_FindString = "accountmap_division = " + string ( ai_shiptype ) + &
					" and accountmap_amounttypeid = " + string ( ai_amounttype )
ll_FindRow = lds_AccountMap.Find ( ls_FindString, 1, lds_AccountMap.RowCount() )
if ll_findrow > 0 then
	
	choose case as_category
		case "PAYABLES"
			if ab_credit then 
				as_account = lds_AccountMap.Object.accountmap_apaccount[ll_FindRow]
			else
				//debit
				as_account = lds_AccountMap.Object.accountmap_costaccount[ll_FindRow]
			end if
		case "PAYROLL"
			if ab_credit then
				as_account = lds_AccountMap.Object.accountmap_payrollcashaccount[ll_FindRow]
			else
				//debit
				as_account = lds_AccountMap.Object.accountmap_payrollexpenseaccount[ll_FindRow]			
			end if
		case "RECEIVABLES"
			if	ab_credit then
				as_account = lds_AccountMap.Object.accountmap_salesaccount[ll_FindRow]			
			else
				//debit
				as_account = lds_AccountMap.Object.accountmap_araccount[ll_FindRow]
			end if
	end choose
	
else
	as_account=''
end if

if len(trim(as_account)) = 0 or isnull(as_account) then
	li_return = -1
end if

return li_return

			

end function

public function string of_getaccounterror (integer ai_amounttype);string	ls_amounttype

n_cst_bcm	lnv_Cache
n_cst_beo_amounttype	lnv_Beo

IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_amounttype", lnv_Cache, TRUE, TRUE ) = 1 THEN

	lnv_Beo = lnv_Cache.GetBeo ( "amounttype_id = " + String ( ai_amounttype ) )

	IF IsValid ( lnv_Beo ) THEN
		ls_amounttype = lnv_Beo.of_getname()
	ELSE
		ls_amounttype = ''
	END IF

ELSE
	ls_amounttype = ''			
END IF

return  "The account for amount type " + ls_amounttype + " is blank."

end function

public subroutine of_addtoarrays (string as_account, decimal ac_amount, ref string asa_account[], ref decimal aca_amount[], boolean ab_freightitem, ref string asa_freighttype[]);long		ll_arraycount, &
			ll_ndx
			
boolean	lb_accountfound

ll_arraycount = upperbound(asa_account)
for ll_ndx = 1 to ll_arraycount
	if as_account = asa_account[ll_ndx] then
		lb_accountfound=true
		exit
	end if
next

if lb_accountfound then	
	aca_amount[ll_ndx] += ac_amount
else
	IF ab_freightitem then
		asa_freighttype[ll_arraycount + 1] = "YES"
	end if
	asa_account[ll_arraycount + 1] = as_account
	aca_amount[ll_arraycount + 1] = ac_amount
end if


end subroutine

public function integer of_checkforaccounts (n_cst_beo_shipment anv_shipment, ref n_cst_msg anv_msg);any		la_value

integer	li_shiptype, &
			li_amounttype, &
			li_return = 1
			
long		ll_itemcount, &
			ll_itemndx
			
string	ls_account, &
			ls_error			

s_parm	lstr_parm

n_cst_beo_item	lnva_item[], &
					lnva_clearitem[]
n_cst_settings	lnv_settings

li_shiptype = anv_shipment.of_gettype()

choose case anv_shipment.of_GetBillingFormat ( )
		
	case appeon_constant.cs_BillingFormat_Item
		//	loop thru items for amounttypes
		anv_shipment.of_LockItemList ( "billing" )
		lnva_item = lnva_clearitem
		ll_itemcount = anv_shipment.of_getitemlist(lnva_item)
	
		for ll_itemndx = 1 to ll_itemcount
			
			li_amounttype = lnva_item[ll_itemndx].of_getamounttype()
			if isnull(li_amounttype) or li_amounttype = 0 then
				ls_error = "Amount type missing for TMP " + string(anv_shipment.of_getid())
				lstr_parm.is_label = "ERROR"
				lstr_parm.ia_value = ls_error
				anv_msg.of_add_parm(lstr_parm)
				li_return = -1
			end if
			
			if li_return = 1 then
				//do we have an account?
				if	this.of_getaccount(li_shiptype, li_amounttype, "RECEIVABLES", FALSE /*CREDIT*/, ls_account ) = -1 then
					ls_error = this.of_getaccounterror(li_amounttype)
					lstr_parm.is_label = "ERROR"
					lstr_parm.ia_value = ls_error
					anv_msg.of_add_parm(lstr_parm)
					li_return = -1
				end if
			end if
			
			if li_return = 1 then
				//add sales account and amount
				if this.of_getaccount(li_shiptype, li_amounttype, "RECEIVABLES", TRUE /*CREDIT*/, ls_account ) = -1 then
					ls_error = this.of_getaccounterror(li_amounttype)
					lstr_parm.is_label = "ERROR"
					lstr_parm.ia_value = ls_error
					anv_msg.of_add_parm(lstr_parm)
					li_return = -1
				end if				
			end if
			
			DESTROY ( lnva_item[ ll_itemndx ] )
			
		next
		
		anv_shipment.of_ReleaseItemList ( "billing" )
		
	case appeon_constant.cs_BillingFormat_Category
		//FREIGHT
		if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
			li_amounttype = integer(la_value)
		end if
		if isnull(li_amounttype) or li_amounttype = 0 then
			ls_error = "Amount type missing for TMP " + string(anv_shipment.of_getid())
			lstr_parm.is_label = "ERROR"
			lstr_parm.ia_value = ls_error
			anv_msg.of_add_parm(lstr_parm)
			li_return = -1
		end if

		if li_return = 1 then
			//do we have an account?
			if	this.of_getaccount(li_shiptype, li_amounttype, "RECEIVABLES", FALSE /*CREDIT*/, ls_account ) = -1 then
				ls_error = this.of_getaccounterror(li_amounttype)
				lstr_parm.is_label = "ERROR"
				lstr_parm.ia_value = ls_error
				anv_msg.of_add_parm(lstr_parm)
				li_return = -1
			end if
		end if
		
		if li_return = 1 then
			//add sales account and amount
			if this.of_getaccount(li_shiptype, li_amounttype, "RECEIVABLES", TRUE /*CREDIT*/, ls_account ) = -1 then
				ls_error = this.of_getaccounterror(li_amounttype)
				lstr_parm.is_label = "ERROR"
				lstr_parm.ia_value = ls_error
				anv_msg.of_add_parm(lstr_parm)
				li_return = -1
			end if		
		end if
			
		//ACCESS
		if lnv_Settings.of_GetSetting ( 99 , la_value ) > 0 then
			li_amounttype = integer(la_value)
		end if
		
		if isnull(li_amounttype) or li_amounttype = 0 then
			ls_error = "Amount type missing for TMP " + string(anv_shipment.of_getid())			
			lstr_parm.is_label = "ERROR"
			lstr_parm.ia_value = ls_error
			anv_msg.of_add_parm(lstr_parm)
			li_return = -1
		end if
		
		if li_return = 1 then
			//do we have an account?
			if	this.of_getaccount(li_shiptype, li_amounttype, "RECEIVABLES", FALSE /*CREDIT*/, ls_account ) = -1 then
				ls_error = this.of_getaccounterror(li_amounttype)
				lstr_parm.is_label = "ERROR"
				lstr_parm.ia_value = ls_error
				anv_msg.of_add_parm(lstr_parm)
				li_return = -1
			end if
		end if
		
		if li_return = 1 then
			//add sales account and amount
			if this.of_getaccount(li_shiptype, li_amounttype, "RECEIVABLES", TRUE /*CREDIT*/, ls_account ) = -1 then
				ls_error = this.of_getaccounterror(li_amounttype)
				lstr_parm.is_label = "ERROR"
				lstr_parm.ia_value = ls_error
				anv_msg.of_add_parm(lstr_parm)
				li_return = -1
			end if				
		end if
			

	case appeon_constant.cs_BillingFormat_Total
		//grand total goes to default freight account
		if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
			li_amounttype = integer(la_value)
		end if
		
		if isnull(li_amounttype) or li_amounttype = 0 then
			ls_error = "Amount type missing for TMP " + string(anv_shipment.of_getid())			
			lstr_parm.is_label = "ERROR"
			lstr_parm.ia_value = ls_error
			anv_msg.of_add_parm(lstr_parm)
			li_return = -1			
		end if
		
		if li_return = 1 then
				//do we have an account?
				if	this.of_getaccount(li_shiptype, li_amounttype, "RECEIVABLES", FALSE /*CREDIT*/, ls_account ) = -1 then
					ls_error = this.of_getaccounterror(li_amounttype)
					lstr_parm.is_label = "ERROR"
					lstr_parm.ia_value = ls_error
					anv_msg.of_add_parm(lstr_parm)
					li_return = -1
				end if
			end if
			
			if li_return = 1 then
				//add sales account and amount
				if this.of_getaccount(li_shiptype, li_amounttype, "RECEIVABLES", TRUE /*CREDIT*/, ls_account ) = -1 then
					ls_error = this.of_getaccounterror(li_amounttype)
					lstr_parm.is_label = "ERROR"
					lstr_parm.ia_value = ls_error
					anv_msg.of_add_parm(lstr_parm)
					li_return = -1
				end if				
		end if		
		
end choose
		
return li_return		
end function

public subroutine of_applydiscount (n_cst_beo_shipment anv_shipment, ref decimal ac_amount, ref decimal ac_discountremainder);// apply discount to reference amount and return any remainder

decimal	lc_DiscountAmount, &
			lc_DiscountPercent, &
			lc_DiscountRemainder, &
			lc_DiscountTotal, &
			lc_amount, &
			lc_freightcharges
			
lc_freightcharges =	anv_shipment.of_GetFreightCharges()
lc_DiscountTotal = anv_shipment.of_GetDiscountAmount()

if lc_freightcharges > 0 then
	lc_discountamount = ROUND ( ( ( ac_amount / lc_freightcharges ) * lc_DiscountTotal ), 2 )
end if

if ac_DiscountRemainder - lc_DiscountAmount < 0 then
	lc_discountamount = ac_DiscountRemainder
	ac_DiscountRemainder = 0
else
	ac_DiscountRemainder -= lc_discountAmount
end if

ac_amount = ac_amount - lc_DiscountAmount

end subroutine

public function integer of_validateaccounts (string as_accounttype);/***************************************************************************************
NAME			: of_ValidateAccounts
ACCESS		: Public 
ARGUMENTS	: String 	( "P"ayables, "R"eceivables )
RETURNS		: Integer 	( 1=Success, -1=Fail)
DESCRIPTION	: 
	Retrieve accounts in AccountMap Table. (d_AcctMap)
	Read system settings to find default file to validate against.
	If the file or the system setting is not found open a file browse window.
	Read the external file into a datastore.
	Read the first AccountMap entry and find it in the External datastore.
	If the Ptools entry was found, mark the entry in the external datastore as found.
	If the Ptools entry was not found move it to the report datastore.
	Once all the Ptool entries have been validated, move the unfound external 

REVISION		: RDT 112102
***************************************************************************************/
String 	ls_ValidateFile, &
			ls_FileName, &
			ls_ProcessText, &
			ls_Message, &
			ls_Find, &
			ls_ValueList, &
			lsa_Settings[]
			
Any 		la_String
 
Blob 		lblob_dwstate

Integer	li_Return, &
			li_FileID, &
			li_Result , &
			li_Count, &
			li_Index 

Long 		ll_RowCount, &
			ll_Row, &
			ll_NewRow, &
			ll_Valid_RowCount , &
			lla_Empty[]

li_Return = 1

If as_AccountType <> "P" and as_AccountType <> "R" Then 
	messageBox("PROGRAM ERROR in n_cst_bso_AccountingManager.of_ValidateAccounts()","Argument of " +as_AccountType+ " Not supported")
	Return -1 // MIDCODE RETURN 
End IF

// Create objects
n_cst_Msg lmsg
s_parm lstr_parm

n_cst_Ship_Type lnv_Ship_Type

// Accoumt map datastore 
n_ds lds_AccountMap
lds_AccountMap = create n_ds 
lds_AccountMap.DataObject = "d_AcctMap"
lds_AccountMap.SetTransObject(SQLCA)
ll_RowCount = lds_AccountMap.Retrieve()

// GL Validation datastore
n_ds lds_GLFile
lds_GLFile   = create n_ds 
lds_GLFile.DataObject = "d_Ext_Accounts" 

// Report datastore
n_ds lds_Report
lds_Report	= create n_ds 
lds_Report.DataObject = "d_ext_GLValidation" 

n_cst_Settings	lnv_Settings
n_cst_filesrv  lnv_FileSrv

f_SetFileSrv(lnv_FileSrv, TRUE)				// Create file service

If as_AccountType = "P" Then 
	lnv_Settings.of_GetSetting ( 132 , la_String ) 	// get system setting 
	ls_ValidateFile = String ( la_String )
End If

If as_AccountType = "R" Then 
	lnv_Settings.of_GetSetting ( 133 , la_String ) 	// get system setting 
	ls_ValidateFile = String ( la_String )
End If

// Look for validation file in system settings. if no file name, let user browser a file in
If Len( Trim( ls_ValidateFile ) ) < 1 Then 
	li_Return = GetFileOpenName("System Setting not found. Select GL Validation File", ls_ValidateFile, ls_FileName, "TXT", "Text Files (*.TXT),*.TXT,")
	IF li_Return <> 1 THEN 
		ls_message = "No File Selected. Process stopped."
		li_Return = -1
	End If
End If

// Check if file exists 
If FileExists ( ls_ValidateFile ) Then 
	li_Return = 1
Else
	ls_message = "File "+ ls_ValidateFile + " Not Found. Please select GL Validation File"
	li_Return = GetFileOpenName(ls_Message , ls_ValidateFile, ls_FileName, "TXT", "Text Files (*.TXT),*.TXT,")
	IF li_Return <> 1 THEN 
		ls_message = "No File Selected. Process stopped."
		li_Return = -1
	End If
	
End If

// Load external dw with validation file
If li_Return = 1 Then 
	li_Result = lds_GLFile.ImportFile( ls_ValidateFile )

	Choose Case li_Result
		Case 0  
			ls_message= "Empty file."
			li_Return = -1
		Case -1  
			ls_message= "No rows"
			li_Return = -1
		Case -2  
			ls_message= "Empty file"
			li_Return = -1
		Case -3  
			ls_message= "Invalid argument"
			li_Return = -1
		Case -4  
			ls_message= "Invalid input"
			li_Return = -1
		Case -5  
			ls_message= "Could not open the file"
			li_Return = -1
		Case -6  
			ls_message= "Could not close the file"
			li_Return = -1
		Case -7  
			ls_message= "Error reading the text"
			li_Return = -1
		Case -8  
			ls_message= "Not a TXT file"
			li_Return = -1
		Case -9  
			ls_message= "Invalid File, Import canceled "
			li_Return = -1
		Case -10 
			ls_message= "Unsupported dBase file format (not version 2 or 3)"
			li_Return = -1
		Case Else 
			ll_Valid_RowCount= li_Result 
			li_Return = 1	// Returns number of rows imported. 
	End Choose

End IF

If li_Return = 1 Then 
	If as_AccountType = "P" Then 
		ls_ProcessText = "Accounts Payables"
	// Check GL against validation file
		For ll_Row = 1 to ll_RowCount 
			// Check AP Account
			ls_Find = "accountID = '" + lds_AccountMap.GetItemString(ll_Row, "accountmap_apaccount")+"'"
			if lds_GLFile.Find ( ls_Find, 1, ll_Valid_RowCount) < 1 Then 
				// not found copy to report 
				ll_NewRow = lds_Report.InsertRow(0)
				lds_Report.SetItem( ll_NewRow , "division" , String( lds_AccountMap.GetItemNumber( ll_Row, "accountmap_division" ) ) )
				lds_Report.SetItem( ll_NewRow , "catagory" ,	lds_AccountMap.GetItemString( ll_Row, "amounttype_name" ) )
				lds_Report.SetItem( ll_NewRow , "account" ,	lds_AccountMap.GetItemString( ll_Row, "accountmap_apaccount" ) )
				lds_Report.SetItem( ll_NewRow , "amounttype", String(lds_AccountMap.GetItemNumber( ll_Row, "accountmap_amounttypeid" ) ) )
				lds_Report.SetItem( ll_NewRow , "description" ,	"AP Account not found." )
			end if
		
		// Check Cost Account
			ls_Find = "accountID = '"+lds_AccountMap.GetItemString(ll_Row, "accountmap_costaccount")+"'"
			if lds_GLFile.Find ( ls_Find, 1, ll_Valid_RowCount) < 1 Then 
				// not found copy to report 
				ll_NewRow = lds_Report.InsertRow(0)
				lds_Report.SetItem( ll_NewRow , "division" , String( lds_AccountMap.GetItemNumber( ll_Row, "accountmap_division" ) ) )
				lds_Report.SetItem( ll_NewRow , "catagory" ,	lds_AccountMap.GetItemString( ll_Row, "amounttype_name" ) )
				lds_Report.SetItem( ll_NewRow , "account" ,	lds_AccountMap.GetItemString( ll_Row, "accountmap_costaccount" ) )
				lds_Report.SetItem( ll_NewRow , "amounttype", String(lds_AccountMap.GetItemNumber( ll_Row, "accountmap_amounttypeid" ) ) )
				lds_Report.SetItem( ll_NewRow , "description" ,	"Cost Account not found." )
			end if
			
		Next
	End IF

	If as_AccountType = "R" Then 
	// Check GL against validation file
		ls_ProcessText = "Accounts Receivables"
		For ll_Row = 1 to ll_RowCount 
			// Check Sales Account
			ls_Find = "accountID = '" + lds_AccountMap.GetItemString(ll_Row, "accountmap_salesaccount")+"'"
			if lds_GLFile.Find ( ls_Find, 1, ll_Valid_RowCount) < 1 Then 
				// not found copy to report 
				ll_NewRow = lds_Report.InsertRow(0)
				lds_Report.SetItem( ll_NewRow , "division" , String( lds_AccountMap.GetItemNumber( ll_Row, "accountmap_division" ) ) )
				lds_Report.SetItem( ll_NewRow , "catagory" ,	lds_AccountMap.GetItemString( ll_Row, "amounttype_name" ) )
				lds_Report.SetItem( ll_NewRow , "account" ,	lds_AccountMap.GetItemString( ll_Row, "accountmap_salesaccount" ) )
				lds_Report.SetItem( ll_NewRow , "amounttype", String(lds_AccountMap.GetItemNumber( ll_Row, "accountmap_amounttypeid" ) ) )
				lds_Report.SetItem( ll_NewRow , "description" ,	"Sales Account not found." )
			end if
		
		// Check AR Account
			ls_Find = "accountID = '"+lds_AccountMap.GetItemString(ll_Row, "accountmap_araccount")+"'"
			if lds_GLFile.Find ( ls_Find, 1, ll_Valid_RowCount) < 1 Then 
				// not found copy to report 
				ll_NewRow = lds_Report.InsertRow(0)
				lds_Report.SetItem( ll_NewRow , "division" , String( lds_AccountMap.GetItemNumber( ll_Row, "accountmap_division" ) ) )
				lds_Report.SetItem( ll_NewRow , "catagory" ,	lds_AccountMap.GetItemString( ll_Row, "amounttype_name" ) )
				lds_Report.SetItem( ll_NewRow , "account" ,	lds_AccountMap.GetItemString( ll_Row, "accountmap_araccount" ) )
				lds_Report.SetItem( ll_NewRow , "amounttype", String(lds_AccountMap.GetItemNumber( ll_Row, "accountmap_amounttypeid" ) ) )
				lds_Report.SetItem( ll_NewRow , "description" ,	"AR Account not found." )
			end if
			
		Next
	End IF
End IF

////Load Division code table 
IF lnv_Ship_Type.of_GetCodeTable ( "DIVISION", TRUE /*All*/, lla_Empty /*ReqIds*/, ls_ValueList ) < 1 THEN
	li_Return = -1
ELSE
	IF Right ( ls_ValueList, 1 ) <> "/" THEN
		ls_ValueList += "/"
	END IF
END IF

ls_ValueList = "Values = '" + ls_ValueList + "'"

lsa_Settings = { "Edit.CodeTable = Yes", ls_ValueList, "ddlb.UseAsBorder = No", "ddlb.Sorted = Yes", "ddlb.VScrollBar = Yes" }

li_Count = UpperBound ( lsa_Settings )

FOR li_Index = 1 TO li_Count
	lds_Report.Dynamic Modify ( "division" + "." + lsa_Settings [ li_Index ] )
NEXT

// display results
If li_Return = 1 Then 
	// Report to User results 
	if lds_Report.getFullState(lblob_dwstate) = -1 then 
		messageBox("bso_AccountingManager.of_ValidateAccounts error","GetFullState failed")
	else
		lstr_Parm.is_Label = "dw"
		lstr_Parm.ia_Value = lblob_dwstate
		lmsg.of_add_parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "title"
		lstr_Parm.ia_Value = "Account Validation Report"
		lmsg.of_add_parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "message1"
		lstr_Parm.ia_Value = ls_ProcessText 
		lmsg.of_add_parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "message2"
		lstr_Parm.ia_Value = "Please review and click OK to continue."
		lmsg.of_add_parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "cb_Cancel"
		lstr_Parm.ia_Value = "false"
		lmsg.of_add_parm ( lstr_Parm )

		OpenWithParm(w_Review_confirm, lmsg )

	end if
		
End IF

If li_Return = -1 Then 
	MessageBox(ls_ProcessText +" Validation",ls_Message)
End If


// Destroy Objects
Destroy lds_AccountMap
Destroy lds_GLFile
Destroy lds_Report

f_SetFileSrv(lnv_FileSrv, FALSE)				// Destroy file service


Return li_Return 
end function

on n_cst_bso_accountingmanager.create
call super::create
end on

on n_cst_bso_accountingmanager.destroy
call super::destroy
end on

