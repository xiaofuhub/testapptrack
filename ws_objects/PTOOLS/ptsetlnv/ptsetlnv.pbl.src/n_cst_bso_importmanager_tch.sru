$PBExportHeader$n_cst_bso_importmanager_tch.sru
$PBExportComments$ImportManager_TCH (Non-persistent Class from PBL map PTSetl) //@(*)[55387533|771]
forward
global type n_cst_bso_importmanager_tch from n_cst_bso_importmanager
end type
end forward

shared variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
n_cst_bso_importmanager_tch sn_n_cst_bso_importmanager_tch_a[] //@(*)[55387533|771:n]<nosync>
Integer sn_n_cst_bso_importmanager_tch_c //@(*)[55387533|771:c]<nosync>
//@(text)--

//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

global type n_cst_bso_importmanager_tch from n_cst_bso_importmanager
end type
global n_cst_bso_importmanager_tch n_cst_bso_importmanager_tch

forward prototypes
public function Integer of_import ()
protected function Boolean of_stringvalidate (string as_datastring)
private function Integer of_createamounts (long al_row)
protected function String of_convertpurchasecategory (string as_categorycode)
protected function String of_convertinfocode (string as_infocode)
protected function Date of_makedate (string as_value)
protected function Integer of_getemployeelist (ref long al_deleterow[], ref string as_employeelist[])
protected function n_cst_beo_AmountType of_getamounttype (string as_Desc)
end prototypes

public function Integer of_import ();//@(*)[62380613|793]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


INT 	li_returnValue =  -1
Int 	li_FileNo
string ls_PathName, ls_FileName
 
li_FileNo = GetFileOpenName ( "Comdata File Name", ls_pathname, ls_filename , ".dat" , &
						"dat Files (*.dat), *.dat, All Files (*.*), *.*" ) 

if (not isNull(ls_PathName)) AND li_FileNo = 1 THEN
	li_ReturnValue = This.of_Import(ls_PathName)		
End IF

Return li_returnValue

end function

protected function Boolean of_stringvalidate (string as_datastring);//@(*)[63450352|801]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

Return True
end function

private function Integer of_createamounts (long al_row);//@(*)[62108504|791]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


Int 	li_ReturnValue = -1
int 	li_EntityReturn
Int		j
Int		li_RowNum
Int   	li_FoundFlag
Int 	li_PC
Int 	li_ServiceType
long	ll_EntityID
Boolean lb_AddProduct 
String	ls_Type
String	ls_Desc
String 	ls_BillingFlag
String	ls_Employee
Decimal	ldec_Amount	
Decimal	ldec_Rate
Decimal	ldec_Quant

DataStore lds_TCHDetails
n_cst_bso_TransactionManager lnv_TransactionManager
n_cst_beo_AmountOwed lnv_amount
n_cst_beo_ratetype	lnv_ratetype
n_cst_beo_RefNumType lnv_RefNumType
n_cst_beo_AmountType lnv_AmountType
n_cst_EmployeeManager lnv_EmployeeManager
lnv_TransactionManager = of_GetTransactionManager()
lds_TCHDetails = This.of_GetSource ( )
li_RowNum = al_Row



For j = 1 TO 7
	ldec_Amount = 0	
	Choose Case j
		Case 1	//Cash Advance
			ldec_Amount = lds_TCHDetails.object.PurchaseAmount1[li_RowNum]
			ldec_Quant = lds_TCHDetails.object.PurchaseQuant1[li_RowNum]
			ls_Desc = lds_TCHDetails.object.PurchaseCatID1[li_RowNum]
			li_ServiceType = lds_TCHDetails.object.ServiceTypeFlag1[li_RowNum]
			
			
		Case 2 // 
			ldec_Amount = lds_TCHDetails.object.PurchaseAmount2[li_RowNum]
			ldec_Quant = lds_TCHDetails.object.PurchaseQuant2[li_RowNum]
			ls_Desc = lds_TCHDetails.object.PurchaseCatID2[li_RowNum]
			li_ServiceType = lds_TCHDetails.object.ServiceTypeFlag2[li_RowNum]
		
		Case 3 // 
			
			ldec_Amount = lds_TCHDetails.object.PurchaseAmount3[li_RowNum]
			ldec_Quant = lds_TCHDetails.object.PurchaseQuant[li_RowNum]
			ls_Desc = lds_TCHDetails.object.PurchaseCatID3[li_RowNum]
			li_ServiceType = lds_TCHDetails.object.ServiceTypeFlag3[li_RowNum]

		Case 4 // 
			
			ldec_Amount = lds_TCHDetails.object.PurchaseAmount4[li_RowNum]
			ldec_Quant = lds_TCHDetails.object.PurchaseQuant4[li_RowNum]
			ls_Desc = lds_TCHDetails.object.PurchaseCatID4[li_RowNum]
			li_ServiceType = lds_TCHDetails.object.ServiceTypeFlag4[li_RowNum]

		Case 5 // 
			ldec_Amount = lds_TCHDetails.object.PurchaseAmount5[li_RowNum]
			ldec_Quant = lds_TCHDetails.object.PurchaseQuant5[li_RowNum]
			ls_Desc = lds_TCHDetails.object.PurchaseCatID5[li_RowNum]
			li_ServiceType = lds_TCHDetails.object.ServiceTypeFlag5[li_RowNum]

		Case 6 // 
			
			ldec_Amount = lds_TCHDetails.object.PurchaseAmount6[li_RowNum]
			ldec_Quant = lds_TCHDetails.object.PurchaseQuant6[li_RowNum]
			ls_Desc = lds_TCHDetails.object.PurchaseCatID6[li_RowNum]
			li_ServiceType = lds_TCHDetails.object.ServiceTypeFlag6[li_RowNum]
		Case 7 
			
			ldec_Amount = lds_TCHDetails.object.TransFee[li_RowNum]
//			lnv_AmountType = of_GetFeeType()

	End Choose
	
	IF ldec_Amount > 0 THEN
		lnv_Amount = lnv_TransactionManager.of_newAmountOwed()
		Constant Boolean lb_AllowCreate = TRUE
		Constant Boolean lb_CreateQuery = TRUE
		ls_Employee = lds_TCHDetails.object.DriverCode[li_RowNum]
		li_EntityReturn = lnv_EmployeeManager.of_GetEntityByCode(ls_Employee,ll_EntityID,lb_AllowCreate, lb_CreateQuery)

		IF li_EntityReturn = 1 AND isValid(lnv_Amount) THEN
			li_ReturnValue = 1
			lnv_Amount.of_SetfkEntity(ll_EntityID)
			lnv_Amount.of_SetQuantity(ldec_Quant)
	   	    lnv_Amount.of_SetAmount(ldec_Amount)
			IF (ls_Desc = "FUEL") OR (ls_Desc = "RFR") OR (ls_Desc = "UNRG") OR &
			   (ls_Desc = "UNPL") OR (ls_Desc = "UNPR") OR (ls_Desc = "DSL1") OR (ls_Desc = "CDSL") THEN
			   This.of_getRateType("TCH_FUEL", lnv_RateType)
			ELSEIF (ls_Desc = "OIL") THEN
				THIS.of_GetRateType("TCH_FUEL",lnv_RateType)
			END IF
			
			
			lnv_Amount.of_SetDescription(This.of_convertPurchaseCategory(ls_Desc))
			lnv_Amount.of_SetStartDate(lds_TCHDetails.object.TransactionDate[li_RowNum])
			
			lnv_Amount.of_SetPublicNote(lds_TCHDetails.object.TruckStopName[li_RowNum] &
				+", "+lds_TCHDetails.object.TruckStopNum[li_RowNum]+" "+ &
				+", " +lds_TCHDetails.object.TruckStopCity[li_RowNum]+" "+ &
				lds_TCHDetails.object.TruckStopState[li_RowNum] +" AT "+ &
				String(lds_TCHDetails.object.TransactionTime[li_RowNum]) )
				
			This.of_GetRefNumType("TCH_TRANSACTIONREF", lnv_RefNumType)
			IF IsValid(lnv_RefNumType) THEN
				lnv_Amount.of_SetRef1Type(lnv_RefNumType.of_GetID())
				lnv_Amount.of_SetRef1Text(lds_TCHDetails.object.TransactionID[li_RowNum])
			END IF
			
			This.of_GetRefNumType("TCH_EMPLOYEEREF",lnv_RefNumType)
			IF isValid(lnv_RefNumType) THEN
				lnv_Amount.of_SetRef2Type(lnv_RefNumType.of_GetId())
				lnv_Amount.of_SetRef2Text(lds_TCHDetails.object.DriverCode[li_RowNum])
			END IF
			
			This.of_GetRefNumType("TCH_FUELCARDNO",lnv_RefNumType)
			IF isValid(lnv_RefNumType) THEN
				lnv_Amount.of_SetRef3Type(lnv_RefNumType.of_GetId())
				lnv_Amount.of_SetRef3Text(lds_TCHDetails.object.CardNumber[li_RowNum])
			END IF
			
			IF IsValid(lnv_RateType) THEN
				lnv_Amount.of_SetRateType(lnv_rateType.of_getid())
			END IF
	
			IF IsValid(lnv_AmountType) THEN
				lnv_Amount.of_SetType(lnv_AmountType.of_GetId())
			END IF
			
			
		Else // amount not created -or- Get Entity by Code Failed
			li_ReturnValue = -1
			EXIT
		END IF
		
	END IF  // amount <= 0
Next

Return 1
//IF NOT ldec_Amount = 0 THEN  // Create a new amount
//		lnv_Amount = lnv_TransactionManager.of_newAmountOwed()
//		Constant Boolean lb_AllowCreate = TRUE
//		Constant Boolean lb_CreateQuery = TRUE
//		ls_Test = lds_ComdataDetails.object.employeeNumber[li_RowNum]
//		li_TestReturn = lnv_EmployeeManager.of_GetEntityByCode(ls_Test, ll_EntityID, lb_AllowCreate, lb_CreateQuery)
//		
//		IF li_TestReturn = 1 THEN		//of_getEntityByCode was a success
//			lnv_Amount.of_SetfkEntity(ll_EntityID)
//			IF IsValid(lnv_Amount) THEN
//				li_ReturnValue = 1									//  Success of procedure Declared 
//				IF ls_Desc = "COMDATA TRACTOR FUEL PURCHASE" OR ls_Desc = "COMDATA REEFER FUEL PURCHASE" OR &
//					ls_Desc = "COMDATA OTHER FUEL"   THEN
//					lnv_Amount.of_SetRate(ldec_Rate)
//					lnv_Amount.of_SetQuantity(ldec_Quant)
//					This.of_getRateType("COMDATA_FUEL", lnv_RateType)
//					IF NOT ABS(lnv_Amount.of_GetAmount()) = ABS(ldec_Amount) THEN // rounding difference
//							lnv_Amount.of_setRate(ldec_amount / ldec_Quant)
//					END IF
//				ELSE
//					This.of_GetRateType("",lnv_RateType)
//					lnv_Amount.of_SetAmount(ldec_Amount)
//					IF ls_Desc = "COMDATA OIL PURCHASE" THEN
//						lnv_Amount.of_SetQuantity(ldec_Quant)
//						This.of_getRateType("COMDATA_OIL", lnv_RateType)
//					END IF
//				END IF
//	
//				lnv_Amount.of_SetDescription(ls_Desc)
//				lnv_Amount.of_SetStartDate(lds_comdataDetails.object.TransactionDate[li_RowNum])
//				lnv_Amount.of_SetPublicNote(lds_comdataDetails.object.TruckStopName[li_RowNum] &
//				+", " +lds_ComdataDetails.object.TruckStopCity[li_RowNum]+" "+ &
//				lds_ComdataDetails.object.TruckStopState[li_RowNum] +" AT "+ &
//				String(lds_ComdataDetails.object.TransactionTime[li_RowNum]) &
//				+"~r~n"+of_ConvertBillingFlag(ls_BillingFlag ))
//	
//				This.of_getRefNumType("COMDATA_TRANSACTIONREF", lnv_RefNumType)
//				IF isValid(lnv_RefNumType) THEN
//					lnv_Amount.of_SetRef1Type(lnv_RefNumType.of_Getid())
//					lnv_Amount.of_SetRef1Text(lds_comdataDetails.object.TransactionNumber[li_RowNum])
//				END IF
//	
//				This.of_GetRefNumType("COMDATA_EMPLOYEEREF",lnv_RefNumType)
//				IF isValid(lnv_RefNumType) THEN
//					lnv_Amount.of_SetRef2Type(lnv_RefNumType.of_GetId())
//					lnv_Amount.of_SetRef2Text(lds_comdataDetails.object.EmployeeNumber[li_RowNum])
//				END IF
//	
//				This.of_GetRefNumType("FUELCARDNO",lnv_RefNumType)
//				IF isValid(lnv_RefNumType) THEN
//					lnv_Amount.of_SetRef3Type(lnv_RefNumType.of_GetId())
//					lnv_Amount.of_SetRef3Text(lds_ComdataDetails.object.FuelCardIDNumber[li_RowNum])
//				END IF
//	
//				IF IsValid(lnv_RateType) THEN
//					lnv_Amount.of_SetRateType(lnv_rateType.of_getid())
//				END IF
//	
//				IF IsValid(lnv_AmountType) THEN
//					lnv_Amount.of_SetType(lnv_AmountType.of_GetId())
//				END IF
//			ELSE
//				li_ReturnValue = -1
//				Exit  // amount not created
//			END IF
//			
//		Else // li_TestReturn <> 1
//			li_ReturnValue = -1
//			EXIT
//		END IF  // li_testReturn 
//
//	END IF  //amount = 0 
//Next
//
//Return li_ReturnValue
end function

protected function String of_convertpurchasecategory (string as_categorycode);//@(*)[62010831|787]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
string 	ls_ReturnValue
string  ls_Test
n_cst_beo_AmountType lnv_AmountType

ls_Test = UPPER(as_categorycode)

Choose Case ls_Test
	Case "FUEL"
		ls_ReturnValue = "#2 Diesel Truck Use"
	Case "RFR"
		ls_ReturnValue = "Reefer Fuel"
	Case "CADV"
		ls_ReturnValue = "Cash Advance"
	Case "OIL"
		ls_ReturnValue = "Oil"
	Case "ADD"
		ls_ReturnValue = "Additives"
	Case "MERCH"
		ls_ReturnValue = "Merchandise"
	Case "Wash"
		ls_ReturnValue = "Truck Wash"
	Case "SCLE"
		ls_ReturnValue = "Scale"
	Case "PART"
		ls_ReturnValue = "Truck Parts"
	Case "HARD"
		ls_ReturnValue = "Hardware"
	Case "OILC"
		ls_ReturnValue = "Oil Change"
	Case "REPR"
		ls_ReturnValue = "Truck Repair"
	Case "SHWR"
		ls_ReturnValue = "Shower"
	Case "TIRE"
		ls_ReturnValue = "Tires"
	Case "TRPP"
		ls_ReturnValue = "Trip Permit"
	Case "DELI"
		ls_ReturnValue = "Deli Foods"
	Case "ELEC"
		ls_ReturnValue = "Electronics"
	Case "GROC"
		ls_ReturnValue = "Groceries"
	Case "CLTH"
		ls_ReturnValue = "Clothing"
	Case "UNRG"
		ls_ReturnValue = "Unleaded Regular"
	Case "UNPL"
		ls_ReturnValue = "Unleaded Plus"
	Case "UNPR"
		ls_ReturnValue = "Unleaded Premium"
	Case "DSL1"
		ls_ReturnValue = "Diesel #1"
	Case "CDSL"
		ls_ReturnValue = "Car Diesel"
		
End Choose

Return ls_ReturnValue

end function

protected function String of_convertinfocode (string as_infocode);//@(*)[62066425|789]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
string ls_Test
string ls_ReturnValue
ls_Test = UPPER(as_InfoCode)
Choose Case ls_Test
	Case "HBRD"
		ls_ReturnValue = "Hubometer"
	Case "ODRD"
		ls_ReturnValue = "Odometer"
	Case "LICN"
		ls_ReturnValue = "Truck License #"
	Case "LCST"
		ls_ReturnValue = "Truck License State"
	Case "HRRD"
		ls_ReturnValue = "Reefer Hours"
	Case "PONB"
		ls_ReturnValue = "P.O. Number"
	Case "FSTI"
		ls_ReturnValue = "First Initial"
	Case "LSTN"
		ls_ReturnValue = "Last Name"
	Case "CNTN"
		ls_ReturnValue = "Control Number"
	Case "BDAY"
		ls_ReturnValue = "Birthday"
	Case "RTMP"
		ls_ReturnValue = "Reefer Temperature"
End Choose

Return ls_ReturnValue

end function

protected function Date of_makedate (string as_value);//@(*)[63593695|805]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//yyyymmdd

Return date(Mid(as_value,5,2)+","+Mid(as_value,7,2)+","+Mid(as_value,1,4))
end function

protected function Integer of_getemployeelist (ref long al_deleterow[], ref string as_employeelist[]);//@(*)[72970519|810]//@(-)Do not edit, move or copy this line//
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
	ls_Test = lds_Source.object.DriverCode[i]  // Get EmployeeNumber
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
return li_ReturnValue
end function

protected function n_cst_beo_AmountType of_getamounttype (string as_Desc);n_cst_beo_AmountType lnv_AmountType

CHOOSE CASE as_Desc
	Case "FEE"
//		lnv_AmountType = of_GetFeeType()

	Case "ADD","MERC", "WASH", "PART", "HARD", "OILC", "REPR", "SHWR", "TIRE", "DELI", &
		 "ELEC", "GROC", "CLTH", "SCLE", "TRPP"
		// lnv_AmountType = of_GetProductType()
		 
	Case "FUEL", "DSL1"
	//	lnv_AmountType = of_GetTractorFuelType()
		
	Case "RFR"
	//	lnv_AmountType = of_GetReeferFuelType()
		
	Case "OIL"
		//lnv_AmountType = of_GetOilType()
		
	Case "CADV"
		//lnv_AmountType = of_GetCashAdvanceType()
				
	Case "UNRG", "UNPL", "UNPL", "CDSL"
	//	lnv_AmountType = of_GetOtherFuelType()
		
END CHOOSE

Return lnv_AmountType
end function

on n_cst_bso_importmanager_tch.create
TriggerEvent(this, "constructor")
end on

on n_cst_bso_importmanager_tch.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(text)(recreate=yes)<init>

//@(text)--

n_ds	lds_Source
lds_Source = This.of_GetSource ( )

lds_Source.DataObject = "d_TCHDetails"
end event

