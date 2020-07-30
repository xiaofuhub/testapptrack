$PBExportHeader$n_cst_bso_importmanager_tchek.sru
$PBExportComments$ImportManager_Tchek (Non-persistent Class from PBL map PTSetl) //@(*)[11738544|126]
forward
global type n_cst_bso_importmanager_tchek from n_cst_bso_importmanager
end type
end forward

shared variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
n_cst_bso_importmanager_tchek sn_n_cst_bso_importmanager_tchek_a[] //@(*)[11738544|126:n]<nosync>
Integer sn_n_cst_bso_importmanager_tchek_c //@(*)[11738544|126:c]<nosync>
//@(text)--

//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

global type n_cst_bso_importmanager_tchek from n_cst_bso_importmanager
end type
global n_cst_bso_importmanager_tchek n_cst_bso_importmanager_tchek

forward prototypes
public function integer of_import ()
protected function integer of_createamounts (long al_row)
protected function integer of_getemployeelist (ref long al_deleterow[], ref string as_employeelist[])
protected function Date of_makedate (string as_value)
protected function Boolean of_stringvalidate (string as_data)
end prototypes

public function integer of_import ();//@(*)[11756071|127]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>
 
//@(text)--


INT 	li_returnValue
Int 	li_FileNo
string ls_PathName, ls_FileName
IF of_GeneratePayableEntityID ( ) = 1 THEN 
	li_FileNo = GetFileOpenName ( "T-Chek File Name", ls_pathname, ls_filename , ".txt" , &
							"Text Files (*.txt), *.txt, All Files (*.*), *.*" ) 
	
	if (not isNull(ls_PathName)) AND li_FileNo = 1 THEN
		li_ReturnValue = This.of_Import(ls_PathName)		
	End IF
ELSE
	li_ReturnValue = -1
END IF
Return li_returnValue


end function

protected function integer of_createamounts (long al_row);//@(*)[11779152|128]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--



Int 	li_ReturnValue = 1
int 	li_TestReturn
Int		j
Int		li_RowNum
Int   	li_FoundFlag
Int 	li_PC
long	ll_EntityID
Boolean lb_AddProduct 
String	ls_Type
String	ls_Desc
String 	ls_BillingFlag
String	ls_Test
String	ls_FuelCode
String	ls_Code
String	ls_EmployeeName
String	ls_TrailerNumber
String	ls_truckNumber

Decimal	ldec_Amount	
Decimal	ldec_Rate
Decimal	ldec_Quant

DataStore lds_TchekDetails
n_cst_bso_TransactionManager lnv_TransactionManager
n_cst_beo_AmountOwed lnv_amount
n_cst_beo_ratetype	lnv_ratetype
n_cst_beo_RefNumType lnv_RefNumType
n_cst_beo_AmountType lnv_AmountType
n_cst_EmployeeManager lnv_EmployeeManager
lnv_TransactionManager = of_GetTransactionManager()
lds_TchekDetails = This.of_GetSource ( )
li_RowNum = al_row

ls_TruckNumber = lds_TchekDetails.object.TractorNumber[li_RowNum]
ls_TrailerNumber = lds_TchekDetails.object.TrailerNumber[li_RowNum]


For j = 1 TO 8
	ldec_Amount = 0	
	Choose Case j
		Case 1	//Cash Advance
			ldec_Amount = lds_TchekDetails.object.CashAdvance[li_RowNum]
			ls_Desc = "TCHEK CASH ADVANCE"
 			lnv_AmountType = of_GetCashAdvanceType()
			
		Case 2 //  fuel purchase
			ldec_Amount = lds_TchekDetails.object.FuelCost[li_Rownum]
			ldec_Rate = lds_TchekDetails.object.FuelPPG[li_RowNum] 
			ldec_Quant = lds_TchekDetails.object.FuelGallons[li_RowNum]
			ls_FuelCode = lds_TchekDetails.object.FuelCode[li_RowNum]
			ls_Desc = "TCHEK FUEL PURCHASE"
 			lnv_AmountType = of_GetTractorFuelType()

		Case 3 // Non-HWY Fuel Purchase
			ldec_Amount = lds_TchekDetails.object.NonHwyCost[li_RowNum]
			ldec_Rate = lds_TchekDetails.object.NonHwyPPG[li_RowNum]
			ldec_Quant = lds_TchekDetails.object.NonHwyGallons[li_RowNum]
			ls_Desc = "TCHEK NON-HWY FUEL PURCHASE"
	 		lnv_AmountType = of_GetOtherFuelType()

		Case 4 // oil Purchase
			ldec_Amount = lds_TchekDetails.object.OilCost[li_RowNum]
			ldec_Quant = lds_TchekDetails.object.OilQuarts[li_RowNum]
			ls_Desc = "TCHEK OIL PURCHASE"
		 	lnv_AmountType = of_GetOilType()

		Case 5 // Transaction Fee
			ldec_Amount = lds_TchekDetails.object.TransactionFee[li_RowNum]
			ls_Desc = "TCHEK TRANSACTION FEE"
			lnv_AmountType = of_GetFeeType()

		Case 6 // TS TRANS FEE
			ldec_Amount = lds_TchekDetails.object.TSTransFee[li_RowNum]
			ls_Desc = "TCHEK TS TRANSACTION FEE"
	     	lnv_AmountType = of_GetFeeType()

		Case 7 // product amount 1
			ldec_Amount = lds_TchekDetails.object.Other1Cost[li_RowNum]
			ls_Code = lds_TchekDetails.object.Other1Code[li_RowNum]
			ls_Desc ="TCHEK OTHER 1 AMOUNT"
			lnv_AmountType = of_GetProductType()

		Case 8 // product amount 2
			ldec_Amount = lds_TchekDetails.object.Other2Cost[li_RowNum]
			ls_Code = lds_TchekDetails.object.Other2Code[li_RowNum]
			ls_Desc = "TCHEK OTHER 2 AMOUNT"
			lnv_AmountType = of_GetProductType()

		End Choose

	IF NOT ldec_Amount = 0 THEN  // Create a new amount
		lnv_Amount = lnv_TransactionManager.of_newAmountOwed()
		Constant Boolean lb_AllowCreate = TRUE
		Constant Boolean lb_CreateQuery = TRUE
		ls_Test = lds_TchekDetails.object.DriverNumber[li_RowNum]
		li_TestReturn = lnv_EmployeeManager.of_GetEntityByCode(ls_Test, ll_EntityID, lb_AllowCreate, lb_CreateQuery)
		lnv_EmployeeManager.of_DescribeEmployee ( ls_Test , 2,ls_EmployeeName )
		
		
		IF li_TestReturn = 1 THEN		//of_getEntityByCode was a success
			lnv_Amount.of_SetfkEntity(ll_EntityID)
			IF IsValid(lnv_Amount) THEN
				li_ReturnValue = 1									//  Success of procedure Declared 
				IF ls_Desc = "TCHEK FUEL PURCHASE" OR ls_Desc = "TCHEK NON-HWY FUEL PURCHASE" THEN
				
					lnv_Amount.of_SetRate(ldec_Rate)
					lnv_Amount.of_SetQuantity(ldec_Quant)
					This.of_getRateType("FUELCARD_FUEL", lnv_RateType)
					IF NOT ABS(lnv_Amount.of_GetAmount()) = ABS(ldec_Amount) THEN // rounding difference
						//This was causing a divide by 0 error
						//lnv_Amount.of_setRate(ldec_amount / ldec_Quant)

						lnv_Amount.of_SetAmount ( ldec_Amount )
					END IF
				ELSEIF ls_Desc = "TCHEK TRANSACTION FEE" OR ls_Desc = "TCHEK TS TRANSACTION FEE" THEN
						THIS.of_GetRateType("FUELCARD_FEE",lnv_RateType)
						lnv_Amount.of_SetAmount(ldec_Amount)
				ELSE
					This.of_GetRateType("",lnv_RateType)
					lnv_Amount.of_SetAmount(ldec_Amount)
					IF ls_Desc = "TCHEK OIL PURCHASE" THEN
						lnv_Amount.of_SetQuantity(ldec_Quant)
						This.of_getRateType("FUELCARD_OIL", lnv_RateType)
					END IF
				END IF
	
				lnv_Amount.of_SetDescription(ls_Desc)
				lnv_Amount.of_SetStartDate(lds_TchekDetails.object.IssueDate[li_RowNum])
				lnv_Amount.of_SetPublicNote(lds_TchekDetails.object.Location[li_RowNum] &
				+" AT "+ &
				String(lds_TchekDetails.object.IssueTime[li_RowNum]) )
				
	
				This.of_getRefNumType("FUELCARD_TRANSACTIONREF", lnv_RefNumType)
				IF isValid(lnv_RefNumType) THEN
					lnv_Amount.of_SetRef1Type(lnv_RefNumType.of_Getid())
					lnv_Amount.of_SetRef1Text(lds_TchekDetails.object.AuthorizationCode[li_RowNum])
				END IF
	
				This.of_GetRefNumType("FUELCARD_EMPLOYEEREF",lnv_RefNumType)
				IF isValid(lnv_RefNumType) THEN
					lnv_Amount.of_SetRef2Type(lnv_RefNumType.of_GetId())
					lnv_Amount.of_SetRef2Text(lds_TchekDetails.object.DriverNumber[li_RowNum])
				END IF
	
				This.of_GetRefNumType("FUELCARDNO",lnv_RefNumType)
				IF isValid(lnv_RefNumType) THEN
					lnv_Amount.of_SetRef3Type(lnv_RefNumType.of_GetId())
					lnv_Amount.of_SetRef3Text(lds_TchekDetails.object.CardNumber[li_RowNum])
				END IF
	
				IF IsValid(lnv_RateType) THEN
					lnv_Amount.of_SetRateType(lnv_rateType.of_getid())
				END IF
	
				IF IsValid(lnv_AmountType) THEN
					lnv_Amount.of_SetType(lnv_AmountType.of_GetId())
				END IF
				
				IF Len ( ls_TruckNumber ) > 0 THEN
					lnv_Amount.of_Settruck ( ls_TruckNumber )
				END IF
				
				IF Len ( ls_TrailerNumber ) > 0 THEN
					lnv_Amount.of_SetTrailer ( ls_TrailerNumber )
				END IF 
				
				IF Len ( TRIM ( ls_EmployeeName ) ) > 0 THEN
					lnv_Amount.of_SetDriver ( ls_EmployeeName )
				END IF
				
				
				CHOOSE CASE j  // this case is to determine if the amount nees to marked up
					CASE  5,6   // fees
					    THIS.of_AddToMarkupAmounts ( lnv_Amount )
				END CHOOSE
				
				CHOOSE CASE j // this case is to determine if the amount may be deleted b/c
								 //  the entity is an employee and doesn't go against their settlement
					CASE 2,3,4
						THIS.of_AddToDeleteAmounts ( lnv_Amount )
				END CHOOSE
				
			ELSE
				li_ReturnValue = -1
				Exit  // amount not created
			END IF
			
		Else // li_TestReturn <> 1
			li_ReturnValue = -1
			EXIT
		END IF  // li_testReturn 

	END IF  //amount = 0 
Next

Return li_ReturnValue
end function

protected function integer of_getemployeelist (ref long al_deleterow[], ref string as_employeelist[]);//@(*)[11835197|130]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>
 
//@(text)--
int 	i
int 	li_ReturnValue = 1
int 	li_NumberRows
int		li_EmployeeFind
long 	ll_entityid
string 	ls_Test

n_cst_EmployeeManager lnv_EmployeeManager
datastore lds_Source
lds_Source = This.of_GetSource ( )


li_NumberRows = lds_Source.RowCount()

For i = 1 TO li_NumberRows
	ls_Test = lds_Source.object.Drivernumber[i]  // Get EmployeeNumber
	Constant Boolean lb_AllowCreate = TRUE
	Constant Boolean lb_CreateQuery = TRUE
	li_EmployeeFind = lnv_EmployeeManager.of_GetEntityByCode(ls_Test, ll_EntityID, lb_AllowCreate, lb_CreateQuery)
	IF li_EmployeeFind = 0 THEN  // Match Not Found In PTOOLS Employee List
		al_DeleteRow[upperBound(al_DeleteRow) + 1 ] = i	
		as_EmployeeList[(upperBound (as_EmployeeList) + 1) ] = ls_Test
	ElseIF li_EmployeeFind = -1 THEN // ERROR While Searching For Match
		MessageBox("File Import","An error occured while reading data base",StopSign!,ok!)
		li_ReturnValue = -1
		EXIT
	END IF
Next
Return li_ReturnValue
end function

protected function Date of_makedate (string as_value);//@(*)[12052197|134]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>
 
//@(text)--
Return date(Mid(as_value,3,2)+","+Mid(as_value,5,2)+","+Mid(as_value,7,2))
end function

protected function Boolean of_stringvalidate (string as_data);//@(*)[12099085|136]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>
 
//@(text)--
Return True
end function

on n_cst_bso_importmanager_tchek.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bso_importmanager_tchek.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(text)(recreate=no)<init>

//@(text)--
n_ds	lds_Source
lds_Source = This.of_GetSource ( )

lds_Source.DataObject = "d_TchekDetails"
end event

