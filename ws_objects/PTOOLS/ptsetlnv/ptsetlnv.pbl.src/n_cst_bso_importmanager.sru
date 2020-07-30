$PBExportHeader$n_cst_bso_importmanager.sru
$PBExportComments$ImportManager (Non-persistent Class from PBL map PTSetl) //@(*)[54011352|764]
forward
global type n_cst_bso_importmanager from n_cst_base
end type
end forward

shared variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
n_cst_bso_importmanager sn_n_cst_bso_importmanager_a[] //@(*)[54011352|764:n]<nosync>
Integer sn_n_cst_bso_importmanager_c //@(*)[54011352|764:c]<nosync>
//@(text)--

//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

global type n_cst_bso_importmanager from n_cst_base
end type
global n_cst_bso_importmanager n_cst_bso_importmanager

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_bso_TransactionManager in_transactionmanager //@(*)[54063446|765]
private n_ds in_source //@(*)[57721643|772]
private n_cst_beo_AmountType in_generaltype //@(*)[8874676|104]
private n_cst_beo_AmountType in_fueloiltype //@(*)[8878480|105]
private n_cst_beo_AmountType in_tractorfueltype //@(*)[8880224|106]
private n_cst_beo_AmountType in_reeferfueltype //@(*)[8881570|107]
private n_cst_beo_AmountType in_otherfueltype //@(*)[8882902|108]
private n_cst_beo_AmountType in_oiltype //@(*)[8890181|109]
private n_cst_beo_AmountType in_producttype //@(*)[8890270|110]
private n_cst_beo_AmountType in_cashadvancetype //@(*)[8890359|111]
private n_cst_beo_AmountType in_feetype //@(*)[8890457|112]
private n_cst_beo_AmountType in_fopfeetype //@(*)[8890567|113]
private n_cst_beo_AmountType in_cashadvancefeetype //@(*)[8890676|114]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.
private n_cst_beo_AmountOwed inva_DeleteAmounts[]
Private n_cst_beo_AmountOwed inva_MarkUpAmounts[]
protected boolean ib_CreatePayable = FALSE
protected String is_Type
protected long il_PayableEntityID
Protected n_cst_beo_amountType inv_PayableType

end variables

forward prototypes
public function Integer of_import ()
public function integer of_import (string as_filename)
protected function Integer of_createamounts (long al_row)
public function n_cst_bso_TransactionManager of_GetTransactionmanager ()
public function Integer of_SetTransactionmanager (n_cst_bso_TransactionManager an_transactionmanager)
protected function Integer of_SetSource (n_ds an_source)
protected function Date of_makedate (string as_value)
protected function Boolean of_stringvalidate (string as_datastring)
protected function n_ds of_GetSource ()
protected function Integer of_getamounttype (string as_label, ref n_cst_beo_amounttype an_amounttype)
protected function Integer of_getratetype (string as_label, ref n_cst_beo_ratetype an_ratetype)
protected function Integer of_getrefnumtype (string as_label, ref n_cst_beo_refnumtype an_refnumtype)
protected function Integer of_getemployeelist (ref long al_deleterow[], ref string as_employeelist[])
protected function n_cst_beo_AmountType of_GetGeneraltype ()
protected function Integer of_SetGeneraltype (n_cst_beo_AmountType an_generaltype)
protected function n_cst_beo_AmountType of_GetFueloiltype ()
protected function Integer of_SetFueloiltype (n_cst_beo_AmountType an_fueloiltype)
protected function n_cst_beo_AmountType of_GetTractorfueltype ()
protected function Integer of_SetTractorfueltype (n_cst_beo_AmountType an_tractorfueltype)
protected function n_cst_beo_AmountType of_GetReeferfueltype ()
protected function Integer of_SetReeferfueltype (n_cst_beo_AmountType an_reeferfueltype)
protected function n_cst_beo_AmountType of_GetOtherfueltype ()
protected function Integer of_SetOtherfueltype (n_cst_beo_AmountType an_otherfueltype)
protected function n_cst_beo_AmountType of_GetOiltype ()
protected function Integer of_SetOiltype (n_cst_beo_AmountType an_oiltype)
protected function n_cst_beo_AmountType of_GetProducttype ()
protected function Integer of_SetProducttype (n_cst_beo_AmountType an_producttype)
protected function n_cst_beo_AmountType of_GetCashadvancetype ()
protected function Integer of_SetCashadvancetype (n_cst_beo_AmountType an_cashadvancetype)
protected function n_cst_beo_AmountType of_GetFeetype ()
protected function Integer of_SetFeetype (n_cst_beo_AmountType an_feetype)
protected function n_cst_beo_AmountType of_GetFopfeetype ()
protected function Integer of_SetFopfeetype (n_cst_beo_AmountType an_fopfeetype)
protected function n_cst_beo_AmountType of_GetCashadvancefeetype ()
protected function Integer of_SetCashadvancefeetype (n_cst_beo_AmountType an_cashadvancefeetype)
protected function integer of_getnewamountsowed (ref n_cst_beo_amountowed anva_amounts[])
private function integer of_getmarkupamount (ref decimal ad_amount, ref boolean ab_percent, string as_value)
public function integer of_settype (string as_Type)
public function boolean of_createpayable ()
protected function integer of_setpayableentityid (long al_EntityID)
protected function long of_getpayableentityid ()
protected function integer of_generatepayableentityid ()
public function integer of_createpayable (n_cst_beo_amountowed anva_amounts[])
public function integer of_addtomarkupamounts (n_cst_beo_Amountowed anv_Amountowed)
public function integer of_addtodeleteamounts (n_cst_beo_amountowed anv_AmountOwed)
protected function integer of_markupamounts ()
public function integer of_deleteamounts ()
protected function n_cst_beo_amounttype of_getpayabletype ()
public function integer of_setpayabletype (n_cst_beo_AmountType anv_PayableType)
public function n_cst_Beo_AmountType of_getfuelcardpayabletype ()
private function integer of_createpayableamounts ()
end prototypes

public function Integer of_import ();//@(*)[54169376|766]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
return -1
end function

public function integer of_import (string as_filename);//@(*)[54192814|767]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


/* Returns 1= success, 0= could not determine, -1= failure*/

setPointer(HourGlass!)
n_cst_String lnv_string
n_cst_EmployeeManager lnv_EmployeeManager
n_cst_beo_AmountOwed lnv_amountOwed
datastore lds_Source
lds_Source = This.of_GetSource ( )


int 		i,j = 1
int 		li_NumberCols,	li_NumberRows = 0
int		li_FileNo
int 		li_ReturnValue = 1
int		li_EOFflag
int     	li_ExistingRows
int 		li_CompStartKey
int		li_CompRunKey
int     	li_BoxResult  //= 1
Int		li_EmployeeFind  
int		li_UpBound
Long		ll_EntityID
String	ls_Tag,  ls_Start,  ls_Data,  ls_File,  ls_len
String  	ls_compData
string 	ls_Type
string 	ls_Comp
String	ls_Rows[]
String  	ls_Temp
String	ls_Test
String  	ls_Message
String	ls_Tense
String	lsa_EmployeeList[]
String  	ls_EmployeeList
Decimal	ldec_data
Long		lla_DeleteRow[]
Boolean 	lb_Continue = TRUE


//IF of_CreatePayable ( ) THEN	
//	IF THIS.of_GeneratePayableEntityID ( ) <> 1 THEN
//		li_ReturnValue = -1
//	END IF
//END IF

IF of_CreatePayable ( ) THEN
	n_cst_beo_AmountType	lnv_FCPayable
	Int	li_TypeRtn
	li_TypeRtn = THIS.of_GetAmountType ( "FUELCARD_PAYABLE" ,  lnv_FCPayable)
	//THIS.of_SetPayableType ( lnv_FCPayable )
	IF li_TypeRtn <> 1 THEN  
		MessageBox ( "Fuel Card Import" , "There is no AmountType specified with the tag 'FUELCARD_PAYABLE' for the fuel card payable. Processing stopped." )
		lb_Continue = FALSE
	ELSE
		THIS.of_SetPayableType ( lnv_FCPayable )
	END IF
END IF

IF lb_Continue THEN

		
	li_FileNo = FileOpen(as_FileName, LineMode!, Read!)
	IF li_FileNo < 0 OR IsNull(li_FileNo) THEN
		li_ReturnValue = -1
		Return li_ReturnValue   						// Exit Function
	END IF	
	
	li_EOFFlag = FileRead(li_FileNo,ls_Temp)
	li_ExistingRows = lds_Source.RowCount()
	//Reads Data Strings into array if valid
		Do While NOT  (li_EOFflag <= 0) 
		 IF This.of_StringValidate(ls_Temp) = TRUE THEN
				li_NumberRows ++
				ls_Rows[li_NumberRows] = ls_Temp
				lds_Source.insertRow(0) 
			END IF
			li_EOFflag = FileRead(li_FileNo,ls_Temp)
		LOOP
	
	FileClose(li_FileNo)
	
	li_NumberCols = Integer ( lds_Source.Describe ( "DataWindow.Column.Count" ))
	
	For i=1 To li_NumberCols
		For j = 1 TO li_NumberRows
			IF j = 1 THEN  // First Time Reading Row So Get Tag Values 
				ls_Tag = lds_Source.describe("#"+string(i)+".tag")
				ls_Start = lnv_string.of_getKeyValue(ls_Tag,"sp",";")
				ls_len = lnv_String.of_GetKeyValue(ls_Tag,"len",";")
				ls_Type = Lower ( Left ( lds_Source.Describe ( "#" + String(i) + ".ColType" ) , 5 ) )
				ls_Comp =  (lnv_String.of_GetKeyValue(ls_Tag,"comp",";"))
				If ls_Comp = "yes" THEN
					li_CompStartKey = integer(lnv_String.of_GetKeyValue(ls_Tag,"st",";"))
					li_CompRunKey = integer(lnv_String.of_GetKeyValue(ls_Tag,"run",";"))
				END IF
			END IF
	
			ls_Data = MID(ls_Rows[j],integer(ls_Start),integer(ls_Len))
			IF ls_Comp = "yes" THEN
				ls_compData = MID(ls_Rows[j],li_CompStartKey,li_CompRunKey)
				ls_Data = ls_CompData + ls_Data
			END IF 
				
			CHOOSE CASE ls_Type
		
				CASE "char(","Strin"		//  CHARACTER DATATYPE
					lds_Source.SetItem ( j+li_ExistingRows, i, Trim(String(ls_Data))) 
			
				CASE "date"					//  DATE DATATYPE
					IF Not integer(ls_Data) = 000000 THEN
						lds_Source.SetItem ( j+li_ExistingRows, i,of_makeDate(ls_Data))
					Else 
						lds_Source.setItem(j+li_ExistingRows,i, setNull(ls_Data))
					End IF
		
				CASE "datet"				//  DATETIME DATATYPE
					lds_Source.SetItem ( j+li_ExistingRows, i, dateTime(ls_Data))
		
				CASE "decim"				//  DECIMAL DATATYPE
					ldec_Data = dec(ls_Data) / integer(lnv_String.of_GetKeyValue(ls_Tag,"dec",";"))
					lds_Source.SetItem ( j+li_ExistingRows, i, ldec_Data)
			
				CASE "numbe", "long", "ulong", "real"				//  NUMBER DATATYPE	
					lds_Source.SetItem ( j+li_ExistingRows, i, long(ls_Data)) 
			
				CASE "time", "times"		//  TIME DATATYPE
					lds_Source.SetItem ( j+li_ExistingRows, i, Time(Mid(ls_Data,1,2)+","+Mid(ls_Data,3,2)))
		
			END CHOOSE
		Next
	Next
	
	
	IF  This.of_GetEmployeelist(lla_DeleteRow,lsa_EmployeeList) = 1 THEN   // successful search of db
	
		n_cst_anyarraysrv lnv_anyarray
		any laa_ids1[], laa_ids2[]
		laa_ids1 = lsa_EmployeeList
		lnv_anyarray.of_GetUnique( laa_ids1, laa_ids2 )  // removes Duplicates
		lsa_EmployeeList = laa_ids2
		
		li_upBound = upperbound(lsa_EmployeeList)
		For i = 1 To li_UpBound
			ls_EmployeeList += "    "+lsa_EmployeeList[i] +"~r~n"
		Next
		
		IF li_UpBound = 1 THEN
			ls_Tense = " was"
		ELSE
			ls_Tense = "s were"
		END IF
		
		IF li_upBound > 0 THEN  // Could Not Find A Match For All Employees
			ls_Message = "The following employee code"+ls_Tense+" not recognized by Profit Tools:~n~n"+&
						+ ls_EmployeeList + &
						+"~nIf you wish to proceed transactions will not be created for these employees."
			li_BoxResult = MessageBox("Profit Tools Employee List",ls_Message,information!,okCancel!)
		END IF
	
	
		IF li_BoxResult = 1 OR li_upBound = 0 THEN
			IF li_UpBound > 0 THEN
				li_UpBound = UpperBound ( lla_DeleteRow )
				For i =  li_UpBound TO 1 Step -1
					lds_Source.RowsDiscard(lla_DeleteRow[i],lla_DeleteRow[i],Primary!)
				Next
			END IF
			
			li_NumberRows = lds_Source.RowCount()
			IF li_NumberRows > 0 THEN
				For  i = li_ExistingRows + 1 To li_NumberRows  //  Create Amounts For New Rows
					IF This.of_CreateAmounts(i) <= 0 THEN  //create amounts failed
						li_ReturnValue = -1
						Exit
					END IF
				Next
				
				// this is the call that will initiate the payable generatino ti the fuel card vendor
				IF THIS.of_CreatePayable ( ) THEN
					IF this.of_CreatePayableAmounts ( ) <> 1 THEN
						li_ReturnValue = -1
						MessageBox( "Payable Generation" , "An error occurred while attempting to generate the fuel card payable." )
					END IF
				END IF
				
				IF li_ReturnValue = 1 THEN
					THIS.of_MarkupAmounts ( ) // there is a check inside both these methods to
					THIS.of_DeleteAmounts ( )// see if the system setting is set
				END IF
				
			ELSE
				li_ReturnValue = 0 // mo rows were imported
			END IF
			
		ELSEIF li_BoxResult = 2 THEN  // User initiated Cancel
			li_ReturnValue = 0
		End IF
		
	Else 
		li_ReturnValue = -1
	END IF
	
	n_cst_beo_AmountOwed lnva_Empty[]
	inva_deleteamounts = lnva_Empty
	inva_markupamounts = lnva_Empty 
	
	lds_Source.Reset()
ELSE
	li_ReturnValue = 0
END IF

RETURN li_ReturnValue

end function

protected function Integer of_createamounts (long al_row);//@(*)[54284969|769]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
Return -1
end function

public function n_cst_bso_TransactionManager of_GetTransactionmanager ();//@(*)[54063446|765:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_transactionmanager
//@(text)--

end function

public function Integer of_SetTransactionmanager (n_cst_bso_TransactionManager an_transactionmanager);//@(*)[54063446|765:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_transactionmanager = an_transactionmanager
return 1
//@(text)--

end function

protected function Integer of_SetSource (n_ds an_source);//@(*)[57721643|772:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_source = an_source
return 1
//@(text)--

end function

protected function Date of_makedate (string as_value);//@(*)[60641883|773]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//yymmdd
Return date(Mid(as_value,3,2)+","+Mid(as_value,5,2)+","+Mid(as_value,1,2))
end function

protected function Boolean of_stringvalidate (string as_datastring);//@(*)[63188123|797]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

return False
end function

protected function n_ds of_GetSource ();//@(*)[57721643|772:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_source
//@(text)--

end function

protected function Integer of_getamounttype (string as_label, ref n_cst_beo_amounttype an_amounttype);//@(*)[60504052|775]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_Beo = lnv_Cache.getBeo("pos(amounttype_tag, '" + as_Label + "') > 0")
	IF isValid(lnv_Beo) THEN
		li_Return = 1
	END IF

END IF
an_AmountType = lnv_Beo

return li_Return

end function

protected function Integer of_getratetype (string as_label, ref n_cst_beo_ratetype an_ratetype);//@(*)[60622423|778]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_ratetype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_Beo = lnv_Cache.getBeo("pos(rateType_Tag, '" + as_Label + "') > 0")
	IF isValid(lnv_Beo) THEN
		li_Return = 1
	END IF

END IF

an_ratetype = lnv_Beo
return li_Return

end function

protected function Integer of_getrefnumtype (string as_label, ref n_cst_beo_refnumtype an_refnumtype);//@(*)[60667159|781]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_refnumtype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_Beo = lnv_Cache.getBeo("pos(refnumType_Tag, '" + as_Label + "') > 0")
	IF isValid( lnv_Beo ) THEN
		li_Return = 1
	END IF

END IF

an_RefNumType = lnv_Beo
RETURN li_Return
end function

protected function Integer of_getemployeelist (ref long al_deleterow[], ref string as_employeelist[]);//@(*)[61578988|784]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

Return -1
end function

protected function n_cst_beo_AmountType of_GetGeneraltype ();//@(*)[8874676|104:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>

 
//@(text)--
n_cst_bcm	lnv_Cache
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE
n_cst_beo lnv_AmountType
li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_amounttype = lnv_Cache.getBeo("pos(amounttype_tag, 'FUELCARD') > 0")
	IF NOT isValid(lnv_amounttype) THEN
		SetNull(lnv_AmountType)
	END IF
	
END IF

return lnv_AmountType

end function

protected function Integer of_SetGeneraltype (n_cst_beo_AmountType an_generaltype);//@(*)[8874676|104:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_generaltype = an_generaltype
return 1
//@(text)--

end function

protected function n_cst_beo_AmountType of_GetFueloiltype ();//@(*)[8878480|105:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>


//@(text)--
n_cst_bcm	lnv_Cache
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE
n_cst_beo lnv_AmountType
li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_amounttype = lnv_Cache.getBeo("pos(amounttype_tag, 'FUELCARD_PURCHASE') > 0")
	IF NOT isValid(lnv_amounttype) THEN
		lnv_AmountType = of_GetGeneralType()
	END IF
	
END IF


return lnv_AmountType

end function

protected function Integer of_SetFueloiltype (n_cst_beo_AmountType an_fueloiltype);//@(*)[8878480|105:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_fueloiltype = an_fueloiltype
return 1
//@(text)--

end function

protected function n_cst_beo_AmountType of_GetTractorfueltype ();//@(*)[8880224|106:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>


//@(text)--
n_cst_bcm	lnv_Cache
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE
n_cst_beo lnv_AmountType
li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_amounttype = lnv_Cache.getBeo("pos(amounttype_tag, 'FUELCARD_PURCHASE_TRACTORFUEL') > 0")
	IF NOT isValid(lnv_amounttype) THEN
		lnv_AmountType = of_GetFuelOilType()
	END IF
	
END IF


return lnv_AmountType

end function

protected function Integer of_SetTractorfueltype (n_cst_beo_AmountType an_tractorfueltype);//@(*)[8880224|106:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_tractorfueltype = an_tractorfueltype
return 1
//@(text)--

end function

protected function n_cst_beo_AmountType of_GetReeferfueltype ();//@(*)[8881570|107:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>


//@(text)--
n_cst_bcm	lnv_Cache
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE
n_cst_beo lnv_AmountType
li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_amounttype = lnv_Cache.getBeo("pos(amounttype_tag, 'FUELCARD_PURCHASE_REEFERFUEL') > 0")
	IF NOT isValid(lnv_amounttype) THEN
		lnv_AmountType = of_GetFuelOilType()
	END IF
	
END IF


return lnv_AmountType

end function

protected function Integer of_SetReeferfueltype (n_cst_beo_AmountType an_reeferfueltype);//@(*)[8881570|107:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_reeferfueltype = an_reeferfueltype
return 1
//@(text)--

end function

protected function n_cst_beo_AmountType of_GetOtherfueltype ();//@(*)[8882902|108:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>

 
//@(text)--
n_cst_bcm	lnv_Cache
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE
n_cst_beo lnv_AmountType
li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_amounttype = lnv_Cache.getBeo("pos(amounttype_tag, 'FUELCARD_OTHERFUEL') > 0")
	IF NOT isValid(lnv_amounttype) THEN
		lnv_AmountType = of_GetFuelOilType()
	END IF
	
END IF


return lnv_AmountType

end function

protected function Integer of_SetOtherfueltype (n_cst_beo_AmountType an_otherfueltype);//@(*)[8882902|108:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_otherfueltype = an_otherfueltype
return 1
//@(text)--

end function

protected function n_cst_beo_AmountType of_GetOiltype ();//@(*)[8890181|109:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>


//@(text)--
n_cst_bcm	lnv_Cache
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE
n_cst_beo lnv_AmountType
li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_amounttype = lnv_Cache.getBeo("pos(amounttype_tag, 'FUELCARD_PURCHASE_OIL') > 0")
	IF NOT isValid(lnv_amounttype) THEN
		lnv_AmountType = of_GetFuelOilType()
	END IF
	
END IF


return lnv_AmountType

end function

protected function Integer of_SetOiltype (n_cst_beo_AmountType an_oiltype);//@(*)[8890181|109:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_oiltype = an_oiltype
return 1
//@(text)--

end function

protected function n_cst_beo_AmountType of_GetProducttype ();//@(*)[8890270|110:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>

 
//@(text)--
n_cst_bcm	lnv_Cache
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE
n_cst_beo lnv_AmountType
li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_amounttype = lnv_Cache.getBeo("pos(amounttype_tag, 'FUELCARD_PURCHASE_PRODUCT') > 0")
	IF NOT isValid(lnv_amounttype) THEN
		lnv_AmountType = of_GetFuelOilType()
	END IF
	
END IF


return lnv_AmountType

end function

protected function Integer of_SetProducttype (n_cst_beo_AmountType an_producttype);//@(*)[8890270|110:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_producttype = an_producttype
return 1
//@(text)--

end function

protected function n_cst_beo_AmountType of_GetCashadvancetype ();//@(*)[8890359|111:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>


//@(text)--
n_cst_bcm	lnv_Cache
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE
n_cst_beo lnv_AmountType
li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_amounttype = lnv_Cache.getBeo("pos(amounttype_tag, 'FUELCARD_CASH') > 0")
	IF NOT isValid(lnv_amounttype) THEN
		lnv_AmountType = of_GetGeneralType()
	END IF
	
END IF


return lnv_AmountType

end function

protected function Integer of_SetCashadvancetype (n_cst_beo_AmountType an_cashadvancetype);//@(*)[8890359|111:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_cashadvancetype = an_cashadvancetype
return 1
//@(text)--

end function

protected function n_cst_beo_AmountType of_GetFeetype ();//@(*)[8890457|112:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>

 
//@(text)--
n_cst_bcm	lnv_Cache
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE
n_cst_beo lnv_AmountType
li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_amounttype = lnv_Cache.getBeo("pos(amounttype_tag, 'FUELCARD_FEE') > 0")
	IF NOT isValid(lnv_amounttype) THEN
		lnv_AmountType = of_GetGeneralType()
	END IF
	
END IF


return lnv_AmountType

end function

protected function Integer of_SetFeetype (n_cst_beo_AmountType an_feetype);//@(*)[8890457|112:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_feetype = an_feetype
return 1
//@(text)--

end function

protected function n_cst_beo_AmountType of_GetFopfeetype ();//@(*)[8890567|113:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>


//@(text)--
n_cst_bcm	lnv_Cache
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE
n_cst_beo lnv_AmountType
li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_amounttype = lnv_Cache.getBeo("pos(amounttype_tag, 'FUELCARD_FEE_FOP') > 0")
	IF NOT isValid(lnv_amounttype) THEN
		lnv_AmountType = of_GetFeeType()
	END IF
	
END IF


return lnv_AmountType

end function

protected function Integer of_SetFopfeetype (n_cst_beo_AmountType an_fopfeetype);//@(*)[8890567|113:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_fopfeetype = an_fopfeetype
return 1
//@(text)--

end function

protected function n_cst_beo_AmountType of_GetCashadvancefeetype ();//@(*)[8890676|114:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>


//@(text)--
n_cst_bcm	lnv_Cache
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE
n_cst_beo lnv_AmountType
li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_amounttype = lnv_Cache.getBeo("pos(amounttype_tag, 'FUELCARD_FEE_CASH') > 0")
	IF NOT isValid(lnv_amounttype) THEN
		lnv_AmountType = of_GetFeeType()
	END IF
	
END IF


return lnv_AmountType

end function

protected function Integer of_SetCashadvancefeetype (n_cst_beo_AmountType an_cashadvancefeetype);//@(*)[8890676|114:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_cashadvancefeetype = an_cashadvancefeetype
return 1
//@(text)--

end function

protected function integer of_getnewamountsowed (ref n_cst_beo_amountowed anva_amounts[]);//anva_Amounts = inva_newamountsowed
Return -1 // upperBound ( inva_newamountsowed )
end function

private function integer of_getmarkupamount (ref decimal ad_amount, ref boolean ab_percent, string as_value);Int		li_Rtn = -1
Any		la_Value
String	ls_Value
Dec		ldec_Amount 

SetNull ( ldec_Amount )
n_cst_Settings	lnv_Settings
IF Len (as_Value ) = 0 THEN
	IF	lnv_Settings.of_GetSetting ( 73 , la_Value ) = 1 THEN
		ls_Value = Trim ( String ( la_Value ) )
	END IF
ELSE
	ls_Value = as_Value
END IF

IF Len ( ls_Value ) > 0 THEN
	IF Right ( ls_Value , 1 ) = "%" THEN
		ab_Percent = TRUE
		ls_Value = Left ( ls_Value , Len ( ls_Value ) -1 )
		IF isNumber ( ls_Value ) THEN 
			ldec_Amount = Dec ( ls_Value ) / 100
		END IF
	ELSE 
		IF isNumber ( ls_Value ) THEN 
			ldec_Amount = Dec ( ls_Value )
		END IF		
		ab_Percent = FALSE
	END IF
	
	
	IF Not IsNull ( ldec_Amount ) THEN
		li_Rtn = 1
	ELSE
		li_Rtn = -1
	END IF

	
END IF

IF li_Rtn = 1 THEN
	ad_Amount = ldec_Amount
END IF

Return li_Rtn
end function

public function integer of_settype (string as_Type);is_Type = as_Type
return 1
end function

public function boolean of_createpayable ();return ib_CreatePayable
end function

protected function integer of_setpayableentityid (long al_EntityID);il_PayableEntityID = al_EntityID
return 1
end function

protected function long of_getpayableentityid ();return il_PayableEntityID
end function

protected function integer of_generatepayableentityid ();String 	ls_Entity
Long		ll_CoID
Int		li_MboxRtn
Int		li_Return = -1
Long		ll_EntityID
n_cst_bcm	lnv_Bcm

n_cst_Companies	lnv_Companies
lnv_Companies = CREATE n_cst_Companies

n_cst_CacheManager				lnv_CacheManager
n_cst_bso_TransactionManager	lnv_TransactionManager

lnv_TransactionManager = of_GetTransactionManager()

lnv_CacheManager = lnv_TransactionManager.GetCacheManager ( )
IF isValid ( lnv_CacheManager ) THEN
	lnv_CacheManager.of_GetCache ( "n_cst_dlkc_transaction", lnv_Bcm, TRUE , FALSE )
END IF

ls_Entity = is_Type

select co_id into :ll_CoID from companies where co_code_name = :ls_Entity ;

choose case sqlca.sqlcode
case 0  // found
	commit ;
case 100 // not found so create a new one
	commit ;
	li_MboxRtn = MessageBox ( "Payables Entity" , "You have indicated that you wish to genterate a Payable"&
		+" to the fuel card vendor. However a company with the code name of " + ls_Entity + &
		" does not exist. Do you want to create one now?" , QUESTION! , YESNO!, 1 )
		
	IF li_MboxRtn = 1 THEN	
		ll_CoID = lnv_Companies.of_CreateNewCompany ( ls_Entity, ls_Entity , null_str )
	END IF
			
case else // error
	rollback ;
end choose


IF ll_CoID > 0 THEN
			
	CHOOSE CASE lnv_Companies.of_GetEntity ( ll_CoID, ll_EntityID, TRUE/*AllowCreate*/,&
										FALSE/*createquery*/, FALSE/*open setup*/ )
	CASE 1 //1 = Success
		li_Return = 1
		
	CASE 0 //0 = Not Found
		IF lnv_Companies.of_MakeEntity ( ll_CoID, ll_EntityID ) <> -1 THEN
			li_Return = 1
		ELSE
			li_Return = -1
		END IF
		
	CASE ELSE // -1 = Error
		li_Return = -1
	
	END CHOOSE
END IF


IF ll_EntityID > 0 THEN
	of_SetPayableEntityID ( ll_EntityID )
ELSE 
	li_Return = -1
END IF

DESTROY lnv_Companies
RETURN li_Return 
end function

public function integer of_createpayable (n_cst_beo_amountowed anva_amounts[]);/**
*  This method will create the payable associated with the amounts generated for the
*	Driver. 
*	The amounts must already be in the view of the bcm because the rows of the ds
*	are coppied for performance reasons
*
*	
*	Returns:	 Int	-1, 1
*
*******
*
*
*	Version 3.0.17
*	May 16, 2001
*	Rick Zacher
*
*/
RETURN -1

/*  NOT USED , NOW OF_CREATEPAYABLEAMOUNTS ( ) SHOULD BE CALLED

boolean				lb_Continue
Long					i
Long					ll_TransactionID
Long					ll_EntityID
Int					li_Return = 1
Long					ll_PayableTypeID
Long					ll_NextID
long					ll_RowCount

n_bcm_ds								lds_Source
n_cst_beo_AmountOwed				lnv_AmountOwed, lnv_CurrentAmountOwed
n_cst_beo_Transaction 			lnv_Transaction
n_cst_bso_TransactionManager	lnv_TransactionManager
n_cst_beo_AmountType				lnv_payabletype

lnv_payabletype = THIS.of_GetPayableType ( )
lnv_TransactionManager = of_GetTransactionManager()

n_cst_bcm	lnv_Bcm
lnv_Bcm = lnv_TransactionManager.of_GetAmountsOwed ( )

ll_EntityID = THIS.of_GetPayableEntityID( ) 
IF isValid ( lnv_PayableType ) THEN
	ll_PayableTypeId = lnv_PayableType.of_GetID ( )
END IF

IF IsValid ( lnv_Bcm ) THEN
	lds_Source = lnv_Bcm.GetView ( )
	IF isValid ( lds_Source ) THEN
		lds_Source.RowsCopy (1, lds_Source.RowCount( ), PRIMARY!, lds_Source, lds_Source.RowCount( ) + 1, PRIMARY! )
		ll_RowCount = lds_Source.RowCount ( )
	END IF
END IF

IF ll_EntityID > 0 THEN // at this point we should have a valid company set up to take transactions
							// as a valid entity
	lnv_TransactionManager.of_SetDefaultEntityID ( ll_EntityID )
	lnv_TransactionManager.of_SetDefaultCategory ( n_cst_constants.ci_Category_Payables )

	lnv_Transaction = lnv_TransactionManager.of_NewTransaction ( )
	
	IF isValid ( lnv_Transaction ) THEN
		
		ll_TransactionId = lnv_Transaction.of_GetId ( )
		
	// we need to assign new ids to the duplicate data that is being used to generate payables			
		FOR i = ( ll_RowCount / 2 ) + 1 TO ll_RowCount 
																	  
			IF  gnv_app.of_getNextID ( "n_cst_beo_amountowed" , ll_NextID , TRUE /*commit*/ ) = 1 THEN
				lds_source.object.AmountOwed_id [ i ] = ll_NextID 
			ELSE
				li_Return = -1
				EXIT
			END IF
			lds_source.setbeoindexforRow ( i )
			lds_source.object.AmountOwed_fktransaction [ i ] = ll_TransactionId 
			lds_Source.object.AmountOwed_Description [ i ] = "PAYABLE: " + lds_Source.Object.AmountOwed_Description [i] 
			lds_source.object.AmountOwed_Type [ i ] = ll_PayableTypeId 
		NEXT
		
		//Recalculate the transaction, to take all the new amounts into account.
		lnv_Transaction.of_Calculate ( )
		
	ELSE // transaction is not Valid 
		
		li_return = -1
		
	END IF
	
ELSE // we don't have a entity
 	li_Return = -1
	
END IF

RETURN li_Return */
end function

public function integer of_addtomarkupamounts (n_cst_beo_Amountowed anv_Amountowed);
inva_markupamounts[ UpperBound ( inva_markupamounts ) + 1 ] = anv_Amountowed
return 1
end function

public function integer of_addtodeleteamounts (n_cst_beo_amountowed anv_AmountOwed);
inva_deleteamounts[ UpperBound ( inva_deleteamounts ) + 1 ] = anv_AmountOwed
return 1
end function

protected function integer of_markupamounts ();/**
*	This method will markup the generated fee amounts for the driver. it will look to the 
* 	system setting to see if markups should occur at all, then it will see if there is a 
* 	specified markup amount for the entity, if not it will then look to the default specified
* 	in the system setting.
*
*	The list should be prepopulated in the of_generateAmounts method
*
*	Returns: 1,-1
*
******
* 	Version 3.0.16
*	May 16, 2001	
* 	Rick Zacher
*
*/

any		la_Value
Boolean	lb_Continue = FALSE
Boolean  lb_Percent
String	ls_Type
String	ls_Description
String	ls_MarkUpValue
Dec		lc_MarkupAmount
String	ls_MarkupType
Int		li_AmountOwedCount
Int		li_Return = 1
Int		i
Int		li_EmployeeType
Long		ll_EmployeeID
long		ll_EntityID
Dec		lc_Amount

n_cst_beo_AmountOwed lnva_Amounts[]

n_cst_CacheManager				lnv_CacheManager
n_cst_bcm							lnv_Bcm
n_cst_beo_Entity 					lnv_Entity
n_cst_beo_AmountOwed				lnv_CurrentAmount
n_cst_bso_TransactionManager 	lnv_TransactionManager
n_cst_EmployeeManager			lnv_EmpManager
n_cst_Beo_AmountType				lnv_AmountType

lnv_TransactionManager = THIS.of_GetTransactionManager ( )
lnva_Amounts[] = inva_markupamounts
li_AmountOwedCount = UpperBound ( lnva_Amounts )

lnv_TransactionManager = THIS.of_GetTransactionManager ( )
n_cst_Settings	lnv_Settings

lnv_Settings.of_GetSetting ( 76 , la_Value )

CHOOSE CASE String ( la_Value )
	CASE "YES!" 
		lb_Continue = true
	CASE ELSE
		lb_Continue = FALSE
END CHOOSE


IF lb_Continue THEN
	lnv_CacheManager = lnv_TransactionManager.GetCacheManager ( )
	IF isValid ( lnv_CacheManager ) THEN
		lnv_CacheManager.of_GetCache ( "n_cst_dlkc_entity", lnv_Bcm, TRUE , TRUE )
	END IF
	
	lnv_TransactionManager.of_GetEntity( ll_EntityID, lnv_Entity ) 
	
	For i = 1 TO li_AmountOwedCount 
						
		li_EmployeeType = -1
		lnv_CurrentAmount = lnva_Amounts[i]
	
		IF isValid ( lnv_CurrentAmount ) THEN
	
			ll_EntityId = lnv_CurrentAmount.of_GetFkEntity ( )
			lnv_TransactionManager.of_GetEntity( ll_EntityID, lnv_Entity )
			IF isValid ( lnv_Entity ) THEN	
				ll_EmployeeID = lnv_Entity.of_GetFKEmployee ( )
				ls_MarkUpValue = UPPER ( TRIM ( lnv_Entity.of_GetFuelCardFeeMarkup ( )  ) )
				
			END IF
	
			IF Len ( Trim ( ls_MarkUpValue ) ) = 0 OR isNull ( ls_MarkupValue )  THEN
				IF of_GetMarkUpAmount ( lc_MarkupAmount , lb_Percent, "" ) = -1 THEN
					lb_Continue = FALSE
				END IF
			ELSE
				IF of_GetMarkUpAmount ( lc_MarkupAmount , lb_Percent, ls_MarkupValue ) = -1 THEN
					lb_Continue = FALSE
				END IF
			END IF
				
			IF lb_Continue THEN
				IF lb_Percent THEN
					lnv_CurrentAmount.of_MarkUpPercent ( lc_MarkupAmount )
				ELSE // dollar amount markup
					lnv_CurrentAmount.of_MarkUpDollar ( lc_MarkupAmount )
				END IF
			END IF
		ELSE
			li_Return = -1
			MessageBox ( "Fee Markup", "An error occurred while attemptng to markup fees to drivers.")
		END IF
			
	NEXT
END IF

RETURN li_Return


end function

public function integer of_deleteamounts ();/**
*	This method will delete the amounts that are for drivers in the EMPLOYEE OR CASUAL 
*  Category IFF the system setting is set. It will not delete the amounts for the 
*  payable to the fuel card if the generation to the vendor is set to yes. It is 
*	intended to prevent deductions going against the driver settlement if they are
*	an employee or casual driver
*	
*	The list should be prepopulated in the of_generateAmounts method
*	
*	Returns: 1,-1
*
******
*	Version 3.0.16
*	May 16, 2001
*	Rick Zacher
**/

any		la_Value
Boolean 	lb_Delete
Boolean	lb_continue = FALSE
Long		i	
Long		ll_Count
Long		ll_EntityID
Long		ll_EmployeeID
Int		li_EmployeeType
Int		li_Return = 1

n_cst_Bso_TransactionManager	lnv_TransactionManager
n_cst_beo_AmountOwed 			lnva_AmountOwed[]
n_cst_Beo_AmountOwed 			lnv_CurrentAmount
n_cst_Beo_Entity					lnv_Entity
n_cst_EmployeeManager 			lnv_EmpManager
n_cst_bcm							lnv_Bcm
n_cst_CacheManager 				lnv_CacheManager

n_cst_Settings	lnv_Settings

lnv_Settings.of_GetSetting ( 75 , la_Value )

lnv_TransactionManager = THIS.of_GetTransactionManager ( )

CHOOSE CASE String ( la_Value )
	CASE "NO!" // then delete the amounts for employees and casual
		lb_Continue = true
	CASE ELSE
		lb_Continue = FALSE
END CHOOSE

IF lb_Continue THEN
	
	lnv_CacheManager = lnv_TransactionManager.GetCacheManager ( )
	IF isValid ( lnv_CacheManager ) THEN
		lnv_CacheManager.of_GetCache ( "n_cst_dlkc_entity", lnv_Bcm, TRUE , TRUE )
	END IF
	
	lnva_AmountOwed = inva_deleteamounts
	
	ll_Count = UpperBound ( lnva_AmountOwed )
	
	FOR i = 1 TO ll_Count
		lb_Delete = FALSE
		
		lnv_CurrentAmount = lnva_AmountOwed [i]

		ll_EntityId = lnv_CurrentAmount.of_GetFkEntity ( )
		lnv_TransactionManager.of_GetEntity( ll_EntityID, lnv_Entity )
		IF isValid ( lnv_Entity ) THEN	
			ll_EmployeeID = lnv_Entity.of_GetFKEmployee ( )
			li_EmployeeType = lnv_EmpManager.of_GetEmployeeType ( ll_EmployeeID )
		END IF

		CHOOSE CASE li_EmployeeType 
			
			CASE n_cst_Constants.ci_Employee_CompanyDriver,  n_cst_Constants.ci_Employee_Casual
				lb_Delete = TRUE
	
			CASE  n_cst_Constants.ci_Employee_OwnerOperator, n_cst_Constants.ci_Employee_3rdParty
				lb_Delete = FALSE
				
			CASE -2 // the type was not specified in the driver window 
				lb_Delete = FALSE
			CASE ELSE // error
				li_Return = -1
				EXIT
		END CHOOSE

		IF lb_Delete THEN
			lnv_CurrentAmount.DeleteBeo ( )
		END IF
		
	NEXT 
	
END IF
IF li_Return = -1 THEN
	MessageBox( "Removal of Employee Deductions" , "An error occurred while attempting to remove employee fuel deductions.")
END IF
	
	
return li_Return

end function

protected function n_cst_beo_amounttype of_getpayabletype ();
return inv_payabletype

end function

public function integer of_setpayabletype (n_cst_beo_AmountType anv_PayableType);inv_payabletype = anv_PayableType
return 1
end function

public function n_cst_Beo_AmountType of_getfuelcardpayabletype ();return inv_payabletype
end function

private function integer of_createpayableamounts ();/**
*  This method will create the payable associated with the amounts generated for the
*	Driver. 
*	The amounts must already be in the view of the bcm because the rows of the ds
*	are coppied for performance reasons
*
*	
*	Returns:	 Int	-1, 1
*
*******
*
*
*	Version 3.0.17
*	May 16, 2001
*	Rick Zacher
*
*/

boolean				lb_Continue
Long					i
Long					ll_TransactionID
Long					ll_EntityID
Int					li_Return = 1
Long					ll_PayableTypeID
Long					ll_NextID
long					ll_RowCount

n_bcm_ds								lds_Source
n_cst_beo_AmountOwed				lnv_AmountOwed, lnv_CurrentAmountOwed
n_cst_beo_Transaction 			lnv_Transaction
n_cst_bso_TransactionManager	lnv_TransactionManager
n_cst_beo_AmountType				lnv_payabletype

lnv_payabletype = THIS.of_GetPayableType ( )
lnv_TransactionManager = of_GetTransactionManager()

n_cst_bcm	lnv_Bcm
lnv_Bcm = lnv_TransactionManager.of_GetAmountsOwed ( )

ll_EntityID = THIS.of_GetPayableEntityID( ) 
IF isValid ( lnv_PayableType ) THEN
	ll_PayableTypeId = lnv_PayableType.of_GetID ( )
END IF

IF IsValid ( lnv_Bcm ) THEN
	lds_Source = lnv_Bcm.GetView ( )
	IF isValid ( lds_Source ) THEN
		lds_Source.RowsCopy (1, lds_Source.RowCount( ), PRIMARY!, lds_Source, lds_Source.RowCount( ) + 1, PRIMARY! )
		ll_RowCount = lds_Source.RowCount ( )
	END IF
END IF

IF ll_EntityID > 0 THEN // at this point we should have a valid company set up to take transactions
							// as a valid entity
	lnv_TransactionManager.of_SetDefaultEntityID ( ll_EntityID )
	lnv_TransactionManager.of_SetDefaultCategory ( n_cst_constants.ci_Category_Payables )

	lnv_Transaction = lnv_TransactionManager.of_NewTransaction ( )
	
	IF isValid ( lnv_Transaction ) THEN
		
		ll_TransactionId = lnv_Transaction.of_GetId ( )
		
	// we need to assign new ids to the duplicate data that is being used to generate payables			
		FOR i = ( ll_RowCount / 2 ) + 1 TO ll_RowCount 
																	  
			IF gnv_app.of_getNextID ( "n_cst_beo_amountowed" , ll_NextID , TRUE /*commit*/ ) = 1 THEN
				lds_source.object.AmountOwed_id [ i ] = ll_NextID 
			ELSE
				li_Return = -1
				EXIT
			END IF
			
			IF lds_source.setbeoindexforRow ( i ) = -1 THEN
				li_Return = -1
				EXIT
			END IF
			lds_source.object.AmountOwed_fktransaction [ i ] = ll_TransactionId 
			lds_Source.object.AmountOwed_Description [ i ] = "PAYABLE: " + lds_Source.Object.AmountOwed_Description [i] 
			lds_source.object.AmountOwed_Type [ i ] = ll_PayableTypeId 
		NEXT
		
		//Recalculate the transaction, to take all the new amounts into account.
		lnv_Transaction.of_Calculate ( )
		
	ELSE // transaction is not Valid 
		
		li_return = -1
		
	END IF
	
ELSE // we don't have a entity
 	li_Return = -1
	
END IF

RETURN li_Return
end function

on n_cst_bso_importmanager.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bso_importmanager.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(text)(recreate=yes)<init>

//@(text)--

n_ds	lds_Source
lds_Source = CREATE n_ds
This.of_SetSource ( lds_Source )

any la_Value
n_cst_Settings	lnv_Setting 
lnv_Setting.of_getSetting ( 74 , la_Value )

CHOOSE CASE STRING ( la_Value )
		
	CASE "YES!"
		ib_CreatePayable = TRUE
	CASE ELSE 
		ib_CreatePayable = FALSE
END CHOOSE

SetNull ( inv_payabletype )



end event

event destructor;call super::destructor;DESTROY in_Source
 
end event

