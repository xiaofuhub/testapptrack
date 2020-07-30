$PBExportHeader$n_cst_bso_importmanager_comdata.sru
$PBExportComments$ImportManager_Comdata (Non-persistent Class from PBL map PTSetl) //@(*)[403421456|709]
forward
global type n_cst_bso_importmanager_comdata from n_cst_bso_importmanager
end type
end forward

shared variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
n_cst_bso_importmanager_comdata sn_n_cst_bso_importmanager_comdata_a[] //@(*)[403421456|709:n]<nosync>
Integer sn_n_cst_bso_importmanager_comdata_c //@(*)[403421456|709:c]<nosync>
//@(text)--

//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

global type n_cst_bso_importmanager_comdata from n_cst_bso_importmanager
end type
global n_cst_bso_importmanager_comdata n_cst_bso_importmanager_comdata

forward prototypes
public function integer of_import ()
private function integer of_createamounts (long al_row)
protected function string of_getproducttype (integer ai_productcode)
protected function string of_convertbillingflag (string as_billingflag)
protected function boolean of_stringvalidate (string as_datastring)
protected function integer of_getemployeelist (ref long al_deleterow[], ref string as_employeelist[])
end prototypes

public function integer of_import ();//@(*)[403557039|710]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>
 
//@(text)--
INT 	li_returnValue
Int 	li_FileNo
string ls_PathName, ls_FileName

IF of_GeneratePayableEntityID ( ) = 1 THEN
 
	li_FileNo = GetFileOpenName ( "Comdata File Name", ls_pathname, ls_filename , ".dat" , &
							"dat Files (*.dat), *.dat,Text Files (*.txt), *.txt, All Files (*.*), *.*" ) 
	
	if (not isNull(ls_PathName)) AND li_FileNo = 1 THEN
		li_ReturnValue = This.of_Import(ls_PathName)		
	End IF
ELSE 
	li_ReturnValue = -1
END IF

Return li_returnValue


end function

private function integer of_createamounts (long al_row);//@(*)[44691761|722]//@(-)Do not edit, move or copy this line//
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
Long	ll_division		//added by dan 1-24-07 I get this from the entity table
Boolean lb_AddProduct 
String	ls_Type
String	ls_Desc
String 	ls_BillingFlag
String	ls_Test
String 	ls_TruckNumber
String	ls_TrailerNumber
String	ls_Driver
String	ls_Container
String	ls_EmployeeName
Decimal	ldec_Amount	
Decimal	ldec_Rate
Decimal	ldec_Quant

DataStore lds_ComdataDetails
n_cst_bso_TransactionManager lnv_TransactionManager
n_cst_beo_AmountOwed lnv_amount, lnva_Amounts[]
n_cst_beo_ratetype	lnv_ratetype
n_cst_beo_RefNumType lnv_RefNumType
n_cst_beo_AmountType lnv_AmountType
n_cst_beo_entity 		lnv_entity


n_cst_EmployeeManager lnv_EmployeeManager
lnv_TransactionManager = of_GetTransactionManager()
lds_ComdataDetails = This.of_GetSource ( )
li_RowNum = al_row

ls_TruckNumber = lds_ComdataDetails.object.UnitNumber[li_RowNum]
ls_TrailerNumber = lds_ComdataDetails.object.TrailerNumber[li_RowNum]

For j = 1 TO 11
	ldec_Amount = 0	
	Choose Case j
		Case 1	//Cash Advance
			ldec_Amount = lds_ComdataDetails.object.CashAdvanceAmount[li_RowNum]
			ls_Desc = "COMDATA CASH ADVANCE"
			ls_BillingFlag = lds_ComdataDetails.object.CashBillingFlag[li_RowNum]
			lnv_AmountType = of_GetCashAdvanceType()
			
		Case 2 // Tractor fuel purchase
			ldec_Amount = lds_ComdataDetails.object.CostOfTractorFuel[li_Rownum]
			ldec_Rate = lds_ComdataDetails.object.TractorFuelPricePerGallon[li_RowNum] 
			ldec_Quant = lds_ComdataDetails.object.NumberOfTractorGallons[li_RowNum]
			ls_Desc = "COMDATA TRACTOR FUEL PURCHASE"
			ls_BillingFlag = lds_ComdataDetails.object.TractorFuelBillingFlag[li_RowNum]
			lnv_AmountType = of_GetTractorFuelType()

		Case 3 // Reefer Fuel Purchase
			ldec_Amount = lds_ComdataDetails.object.CostOfReeferFuel[li_RowNum]
			ldec_Rate = lds_ComdataDetails.object.ReeferPPG[li_RowNum]
			ldec_Quant = lds_ComdataDetails.object.NumberOfReeferGallons[li_RowNum]
			ls_Desc = "COMDATA REEFER FUEL PURCHASE"
			ls_BillingFlag = lds_ComdataDetails.object.ReeferFuelBillingFlag[li_RowNum]
			lnv_AmountType = of_GetReeferFuelType()

		Case 4 // oil Purchase
			ldec_Amount = lds_ComdataDetails.object.TotalCostOfOil[li_RowNum]
			ldec_Quant = lds_ComdataDetails.object.NumberOfQuartsOfOil[li_RowNum]
			ls_Desc = "COMDATA OIL PURCHASE"
			ls_BillingFlag = lds_ComdataDetails.object.oilBillingFlag[li_RowNum]
			lnv_AmountType = of_GetOilType()

		Case 5 // Fees For Cash Advance
			ldec_Amount = lds_ComdataDetails.object.ChargesForCashAdvance[li_RowNum]
			ls_Desc = "COMDATA FEE FOR CASH ADVANCE"
			lnv_AmountType = of_GetCashAdvanceFeeType()

		Case 6 // Fees For Fuel, Oil & Product
			ldec_Amount = lds_ComdataDetails.object.FeesForFuelOilProduct[li_RowNum]
			ls_Desc = "COMDATA FEE FOR FUEL, OIL & PRODUCT"
			lnv_AmountType = of_GetFOPFeeType()

		Case 7 // product amount 1
			ldec_Amount = lds_ComdataDetails.object.productAmount1[li_RowNum]
			ls_Desc ="COMDATA PRODUCT 1 AMOUNT"
			IF Not ldec_Amount = 0 THEN
				lnv_Amount.of_setRef2Text(of_GetProductType(INTEGER(lds_ComdataDetails.object.productCode1[li_RowNum])))
			END IF
			ls_BillingFlag = lds_ComdataDetails.object.Product1BillingFlag[li_RowNum]
			lnv_AmountType = of_GetProductType()

		Case 8 // product amount 2
			ldec_Amount = lds_ComdataDetails.object.ProductAmount2[li_RowNum]
			ls_Desc = "COMDATA PRODUCT 2 AMOUNT"
			IF Not ldec_Amount = 0 THEN
				lnv_Amount.of_setRef2Text(of_GetProductType(INTEGER(lds_ComdataDetails.object.productCode2[li_RowNum])))
			END IF
			ls_BillingFlag = lds_ComdataDetails.object.Product2BillingFlag[li_RowNum]
			lnv_AmountType = of_GetProductType()

		Case 9 // Product amount 3
			ldec_Amount = lds_ComdataDetails.object.ProductAmount3[li_RowNum]
			ls_Desc ="COMDATA PRODUCT 3 AMOUNT"
			IF Not ldec_Amount = 0 THEN
				lnv_Amount.of_setRef2Text(of_GetProductType(INTEGER(lds_ComdataDetails.object.productCode3[li_RowNum])))
			END IF
			ls_BillingFlag = lds_ComdataDetails.object.Product3BillingFlag[li_RowNum]
			lnv_AmountType = of_GetProductType()

		Case 10 // OTHER Fuel
			ldec_Amount = lds_ComdataDetails.object.OtherFuelCost[li_RowNum]
			ldec_Quant = lds_ComdataDetails.object.OtherFuelGallons[li_RowNum]
			ldec_Rate = lds_ComdataDetails.object.OtherFuelPPG[li_RowNum]
			ls_Desc = "COMDATA OTHER FUEL"
			lnv_AmountType = of_GetOtherFuelType()
		
		//ADDED 1-25-07 by dan
		CASE 11
			ldec_Amount = lds_ComdataDetails.object.fuelcarddiscount[li_RowNum]
			ls_Desc ="COMDATA REBATE AMOUNT"
			of_GetAmountType( "FUELCARD_REBATE", lnv_AmountType )
		//	
	End Choose

	IF NOT ldec_Amount = 0 THEN  // Create a new amount
		lnv_Amount = lnv_TransactionManager.of_newAmountOwed()
		Constant Boolean lb_AllowCreate = TRUE
		Constant Boolean lb_CreateQuery = TRUE
		ls_Test = lds_ComdataDetails.object.employeeNumber[li_RowNum]
		li_TestReturn = lnv_EmployeeManager.of_GetEntityByCode(ls_Test, ll_EntityID, lb_AllowCreate, lb_CreateQuery)
		lnv_EmployeeManager.of_DescribeEmployee ( ls_Test , 2,ls_EmployeeName )

		IF li_TestReturn = 1 THEN		//of_getEntityByCode was a success
			lnv_Amount.of_SetfkEntity(ll_EntityID)
			IF IsValid(lnv_Amount) THEN
				li_ReturnValue = 1									//  Success of procedure Declared 
				IF ls_Desc = "COMDATA TRACTOR FUEL PURCHASE" OR ls_Desc = "COMDATA REEFER FUEL PURCHASE" OR &
					ls_Desc = "COMDATA OTHER FUEL"   THEN
					lnv_Amount.of_SetRate(ldec_Rate)
					lnv_Amount.of_SetQuantity(ldec_Quant)
					This.of_getRateType("FUELCARD_FUEL", lnv_RateType)
					IF NOT ABS(lnv_Amount.of_GetAmount()) = ABS(ldec_Amount) THEN // rounding difference
						//This was causing a divide by 0 error
						//lnv_Amount.of_setRate(ldec_amount / ldec_Quant)

						lnv_Amount.of_SetAmount ( ldec_Amount )
					END IF
				ELSE
					This.of_GetRateType("",lnv_RateType)
					lnv_Amount.of_SetAmount(ldec_Amount)
					IF ls_Desc = "COMDATA OIL PURCHASE" THEN
						lnv_Amount.of_SetQuantity(ldec_Quant)
						This.of_getRateType("FUELCARD_OIL", lnv_RateType)
					END IF
				END IF
				
				IF Len ( ls_TruckNumber ) > 0 THEN
					lnv_Amount.of_Settruck ( ls_TruckNumber )
				END IF
				
				IF Len ( ls_TrailerNumber ) > 0 THEN
					lnv_Amount.of_SetTrailer ( ls_TrailerNumber )
				END IF 
				
				IF Len ( TRIM ( ls_EmployeeName ) ) > 0 THEN
					lnv_Amount.of_SetDriver ( ls_EmployeeName )
					
					///////ADDED BY DAN 1-26-07, this is the code i added to default the division information.
					//Rick told me that when he tried something similar he had some issues with lost data,
					//so if we notice anything strange happening, look here.
					IF lnv_TransactionManager.of_Getentity( ll_EntityID , lnv_entity) = 1 THEN
						ll_division = lnv_entity.of_getDivision( )
						IF ll_division > 0 THEN
							lnv_amount.of_setDivision( ll_division)
						END IF
						DESTROY lnv_entity
					END IF
					/////////////////////////////////
				END IF
				lnv_Amount.of_SetDescription(ls_Desc)
				lnv_Amount.of_SetStartDate(lds_comdataDetails.object.TransactionDate[li_RowNum])
				lnv_Amount.of_SetPublicNote(lds_comdataDetails.object.TruckStopName[li_RowNum] &
				+", " +lds_ComdataDetails.object.TruckStopCity[li_RowNum]+" "+ &
				lds_ComdataDetails.object.TruckStopState[li_RowNum] +" AT "+ &
				String(lds_ComdataDetails.object.TransactionTime[li_RowNum]) &
				+"~r~n"+of_ConvertBillingFlag(ls_BillingFlag ))
	
				This.of_getRefNumType("FUELCARD_TRANSACTIONREF", lnv_RefNumType)
				IF isValid(lnv_RefNumType) THEN
					lnv_Amount.of_SetRef1Type(lnv_RefNumType.of_Getid())
					lnv_Amount.of_SetRef1Text(lds_comdataDetails.object.TransactionNumber[li_RowNum])
				END IF
	
				This.of_GetRefNumType("FUELCARD_EMPLOYEEREF",lnv_RefNumType)
				IF isValid(lnv_RefNumType) THEN
					lnv_Amount.of_SetRef2Type(lnv_RefNumType.of_GetId())
					lnv_Amount.of_SetRef2Text(lds_comdataDetails.object.EmployeeNumber[li_RowNum])
				END IF
	
				This.of_GetRefNumType("FUELCARDNO",lnv_RefNumType)
				IF isValid(lnv_RefNumType) THEN
					lnv_Amount.of_SetRef3Type(lnv_RefNumType.of_GetId())
					lnv_Amount.of_SetRef3Text(lds_ComdataDetails.object.FuelCardIDNumber[li_RowNum])
				END IF
	
				IF IsValid(lnv_RateType) THEN
					lnv_Amount.of_SetRateType(lnv_rateType.of_getid())
				END IF
	
				IF IsValid(lnv_AmountType) THEN
					lnv_Amount.of_SetType(lnv_AmountType.of_GetId())
				END IF
				
				CHOOSE CASE j  // this case is to determine if the amount nees to marked up
					CASE 5 , 6 
					    THIS.of_AddToMarkupAmounts ( lnv_Amount )
				END CHOOSE
				
				CHOOSE CASE j // this case is to determine if the amount may be deleted b/c
								 //  the entity is an employee and doesn't go against their settlement
					CASE 2,3,4,6,7,8,9,10
						THIS.of_AddToDeleteAmounts ( lnv_Amount )
				END CHOOSE
				
				// I don't think this is needed any more 
				lnva_Amounts[ UpperBound( lnva_Amounts ) + 1 ] = lnv_Amount				
				
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

protected function string of_getproducttype (integer ai_productcode);//@(*)[57559604|749]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>
 
//@(text)--
Choose Case ai_productcode
			Case 0 
				Return "ADDITIVES"
			Case 1
				Return "TIRE REPAIR"
			Case 2
				Return"EMERGENCY REPAIR"
			Case 3
				Return"LUBRICANTS"
			Case 4
				Return"TIRE PURCHASE"
			Case 5 
				Return"DRIVER EXPENSE"
			Case 6
				Return"TRUCK REPAIR"
			Case 7 
				Return"PARTS"
			Case 8 
				Return"TRAILER EXPENSE"
			Case 9 
				Return"MISCELLANEOUS"
		END CHOOSE


end function

protected function string of_convertbillingflag (string as_billingflag);//@(*)[41542145|753]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
String ls_Return

IF as_BillingFlag = "F" THEN
	ls_Return = "FUNDED"
ELSEIF as_BillingFlag = "D" THEN
	ls_Return = "DIRECT BILLED"
ELSEIF as_BillingFlag = "T" THEN
	ls_Return = "TERMINAL"
END IF

 
 Return ls_Return

end function

protected function boolean of_stringvalidate (string as_datastring);//@(*)[63389603|799]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>
 
//@(text)--
BOOLEAN lb_ReturnValue = FALSE

IF integer(Mid(as_datastring,1,2)) = 01 THEN
	lb_ReturnValue = TRUE
END IF


return lb_ReturnValue


end function

protected function integer of_getemployeelist (ref long al_deleterow[], ref string as_employeelist[]);//@(*)[72853063|807]//@(-)Do not edit, move or copy this line//
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
	ls_Test = lds_Source.object.employeenumber[i]  // Get EmployeeNumber
	Constant Boolean lb_AllowCreate = TRUE
	Constant Boolean lb_CreateQuery = TRUE
	li_EmployeeFind = lnv_EmployeeManager.of_GetEntityByCode(ls_Test, ll_EntityID, lb_AllowCreate, lb_CreateQuery)
	IF li_EmployeeFind = 0 THEN  // Match Not Found In PTOOLS Employee List
		al_DeleteRow[upperBound(al_DeleteRow) + 1 ] = i	
		as_EmployeeList[upperBound(as_EmployeeList) + 1 ] = ls_Test
	ElseIF li_EmployeeFind = -1 THEN // ERROR While Searching For Match
		MessageBox("File Import","An error occured while reading data base",StopSign!,ok!)
		li_ReturnValue = -1
		EXIT
	END IF
Next
Return li_ReturnValue

end function

on n_cst_bso_importmanager_comdata.create
call super::create
end on

on n_cst_bso_importmanager_comdata.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(text)(recreate=no)<init>

//@(text)--
n_ds	lds_Source
lds_Source = This.of_GetSource ( )

lds_Source.DataObject = "d_ComDataDetails"
end event

