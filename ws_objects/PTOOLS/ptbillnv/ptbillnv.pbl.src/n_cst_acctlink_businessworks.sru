$PBExportHeader$n_cst_acctlink_businessworks.sru
forward
global type n_cst_acctlink_businessworks from n_cst_acctlink
end type
end forward

global type n_cst_acctlink_businessworks from n_cst_acctlink
end type
global n_cst_acctlink_businessworks n_cst_acctlink_businessworks

type variables
string	is_postingcompany
boolean	ib_Gold5

end variables

forward prototypes
public function integer of_validate_customers (datastore ads_list)
public function integer of_batch_create (n_cst_msg anv_msg)
private function datastore of_datainitialization (string asa_transcolumns[])
private function integer of_bwwaccess (string as_batchfilepath, string as_importtype, string as_messageheader)
private function integer of_getbwaccesslocation (ref string as_location)
public function integer of_link_open (ref string as_posting_company)
public function integer of_dataload (n_cst_accountingdata anva_accountingdata[])
private subroutine of_olddataload ()
end prototypes

public function integer of_validate_customers (datastore ads_list);RETURN of_ValidateCustomerFile ( ads_List )
end function

public function integer of_batch_create (n_cst_msg anv_msg);//Return Values : 1 = Success, -1 = Failure, -2 = User Chose No AR Batch

/*
	Modified July 1st 2005: added seconds (ss) to the file save name 
*/

String	ls_Title, ls_PathName, ls_FileName, ls_Filter, ls_CancelWarning
String	ls_BatchFile, ls_BatchFilePath, ls_ExeFile, ls_ExeFilePath, ls_SystemFile
String	ls_SystemFilePath, ls_ControlFilePath, ls_ErrorFilePath
String	ls_GeneralHeader, ls_CancelHeader, ls_CancelNote, ls_Command, lsa_Control[]
Constant String	ls_Extension = "bwi"

String	ls_Message, ls_MessageHeader, ls_Reject
String	ls_Noco_SkipList, ls_Error_SkipList, ls_BatchType, ls_Work1, ls_Work2
String	ls_PostingCompany, lsa_TransactionColumns[], ls_Value

Long		ll_Trns, ll_Dist, ll_Noco_SkipCount, ll_Error_SkipCount, ll_Row
Integer	li_Ndx, li_Result
Boolean	lb_RowError, lb_BWAccess, lb_ForceLocate

Int		li_UsedefaultRtn
Int		li_BatchFolderRtn
String	ls_Path
Boolean	lb_UseDefault, &
			lb_Gold
Int		li_BWReturn
String	ls_BWPath

s_Accounting_Transaction	lstra_Trns[]
s_Accounting_Distribution	lstr_Dist

n_cst_File	lnv_File
s_Parm		lstr_Parm
DataStore	lds_Work

//There was some freaky behavior here.  I was declaring the following two variables
//below ( i.e. :  String ls_MessageHeader = "Create AR Batch" ) and somehow the
//value was being set (consistently) to another string value from outside this object!
//The separate declaration / value assignment works fine, however.

ls_MessageHeader = "Create AR Batch"
ls_Reject = "Could not create AR batch."

lb_BWAccess = TRUE  //Initiate import of data using BWWACCES.EXE

//Extract parameters from message object that was passed in.

FOR li_Ndx = 1 TO anv_Msg.of_Get_Count ( )

	IF anv_Msg.of_Get_Parm ( li_Ndx, lstr_Parm ) > 0 THEN

		CHOOSE CASE lstr_Parm.is_Label

		CASE "BATCH_TYPE"
			ls_BatchType = lstr_Parm.ia_Value

		CASE "POSTING_COMPANY"
			ls_PostingCompany = lstr_Parm.ia_Value

		CASE "TRANSACTION"
			lstra_Trns [ UpperBound ( lstra_Trns ) + 1 ] = lstr_Parm.ia_Value

		END CHOOSE

	END IF

NEXT

//Validate requested batch type

CHOOSE CASE ls_BatchType
CASE "SALES!"
	//Batch type is OK
CASE ELSE
	GOTO Failure
END CHOOSE

//Get Batch File Name
li_UseDefaultRtn = THIS.of_UseDefaultBatchName ( )

//           1 = Success, YES!
//				 2 = Success, NO!
//				 3 = success, ASK!
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

CHOOSE CASE li_useDefaultRtn
	CASE -1 ,0 ,3
		IF	MessageBox ( "Default Batch Name" , "Do you wish to use the default batch name?", QUESTION!, YESNO!, 1 ) = 1 THEN
			lb_useDefault = TRUE
		END IF
	
	CASE 1  // yes, use default
		lb_UseDefault = TRUE	
		
	CASE 2  // No, don't use default 
		lb_UseDefault = FALSE
		
END CHOOSE

li_BatchFolderRtn = THIS.of_GetssBatchFolderName ( ls_Path )
IF lb_UseDefault THEN
	IF li_BatchFolderRtn = -2 THEN
		messageBox ( "Folder Location" , "The folder specified in the system settings '" + ls_Path + &
		    "' does not exist. Please select a folder from the following dialog box." )
	END IF
END IF

	 
IF ( Not lb_UseDefault )OR li_BatchFolderRtn <> 1 THEN
	
	ls_PathName = String ( Now ( ), "mmddhhmmss" ) + ".bwi"
	
	IF li_BatchFolderRtn = 1 THEN
		ls_PathName = ls_Path + String ( Now ( ), "mmddhhmmss") + ".bwi"
	END IF

	ls_Title = "Specify Batch File Location"
	
	ls_FileName = ""
	ls_Filter = "Business Works Import Files (*.bwi), *.bwi"  //"Business Works Import Files (*.bwi), *.bwi, All Files (*.*), *.*"
	
	ls_CancelWarning = "You have indicated that you do not wish to create an AR Batch.~n~n"+&
		"PLEASE NOTE: The bills have already been processed, and you will not be able to "+&
		"recreate an AR Batch for them later."
	
	IF lnv_File.of_GetFileSaveName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
		ls_Filter, ls_CancelWarning ) = -1 THEN
	
		RETURN -2
	
	END IF
ELSE
	
	ls_PathName = ls_Path + String ( Now ( ), "mmddhhmmss") + "." + ls_extension
	ls_FileName = String ( Now ( ), "mmddhhmmss") + "." + ls_extension

END IF

ls_BatchFile = ls_FileName
ls_BatchFilePath = ls_PathName


//Initialize transaction and distribution column arrays
lsa_TransactionColumns = { &
	"TransactionLabel", &
	"CustomerId", &
	"InvoiceNumber", &
	"InvoiceDate", &
	"InvoiceAmount", &
	"InvoiceDescription", &
	"DueDate_TermsCode", &
	"DiscountAvailable", &
	"DiscountDate", &
	"SalesRepNumber", &
	"DefaultSalesAcct", &
	"FreightAmount", &
/*	"TaxableSubtotal", &  This is only included if TAXSPLIT is specified as an import option*/ &
	"TaxAmount1", &
	"TaxId1", &
	"TaxAmount2", &
	"TaxId2", &
	"TaxAmount3", &
	"TaxId3" }

FOR li_Ndx = 1 TO 16  //BusinessWorks allows up to 16 sales distributions per invoice

	lsa_TransactionColumns [ UpperBound ( lsa_TransactionColumns ) + 1 ] = &
		"SalesAcct" + String ( li_Ndx, "00" )
	lsa_TransactionColumns [ UpperBound ( lsa_TransactionColumns ) + 1 ] = &
		"SalesAmt" + String ( li_Ndx, "00" )

NEXT


//Set up datastore to hold batch information for export

lds_Work = of_CreateBatchDataStore ( lsa_TransactionColumns )

IF NOT IsValid ( lds_Work ) THEN
	GOTO Failure
END IF


//Load transaction information into datastore

SetPointer ( HourGlass! )

FOR ll_Trns = 1 TO UpperBound ( lstra_Trns )

	lb_RowError = FALSE

	//Check for valid company

	IF Len ( lstra_Trns [ ll_Trns ].is_company_code ) > 0 THEN
		//Accounting ID is OK  (Company name isn't used)
	ELSE
		ll_Noco_SkipCount ++
		IF Len ( ls_Noco_SkipList ) > 0 THEN ls_Noco_SkipList += ", "
		ls_Noco_SkipList += lstra_Trns [ ll_Trns ].is_document_number
		CONTINUE
	END IF

	//Check for AR account (I deleted this)


	//Make Transaction entries

	ll_Row = lds_Work.InsertRow ( 0 )

	FOR li_Ndx = 1 TO UpperBound ( lsa_TransactionColumns )
		
		ls_value = ""

		CHOOSE CASE lsa_TransactionColumns [ li_Ndx ]
		CASE "TransactionLabel"
			ls_Value = "/Invoice"
		CASE "CustomerId"
			ls_Value = lstra_Trns [ ll_Trns ].is_company_code
		CASE "InvoiceNumber"
			ls_Value = lstra_Trns [ ll_Trns ].is_document_number
		CASE "InvoiceDate"
			ls_Value = String ( lstra_Trns [ ll_Trns ].id_document_date, "mm/dd/yy" )
		CASE "InvoiceAmount"
			ls_Value = String ( lstra_Trns [ ll_Trns ].ic_document_amount, "0.00" )
		CASE "InvoiceDescription"
			//BW only allows 20 characters in this field, so I've used the non-descriptive
			//version of the reference number list to conserve space.
			ls_Value = left(of_GetReferenceNumbers ( lstra_Trns [ ll_Trns ] ),20)
		CASE "DueDate_TermsCode"
			ls_Value = "TC"
			//"TC" tells BusinessWorks to calculate based on the customer's default terms code
//		CASE "DiscountAvailable"
//
//		CASE "DiscountDate"
//
//		CASE "SalesRepNumber"
//
//		CASE "DefaultSalesAcct"
//			Omitting this entry uses the default acct set up in BusinessWorks
//		CASE "FreightAmount"
//
//		CASE "TaxableSubtotal"
//
//		CASE "TaxAmount1"
//
//		CASE "TaxId1"
//
//		CASE "TaxAmount2"
//
//		CASE "TaxId2"
//
//		CASE "TaxAmount3"
//
//		CASE "TaxId3"
//
		CASE ELSE
			ls_Value = ""
		END CHOOSE

		lds_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value

	NEXT


	//Make Distribution entries

	FOR li_Ndx = 1 TO UpperBound ( lsa_TransactionColumns )

		IF lsa_TransactionColumns [ li_Ndx ] = "SalesAcct01" THEN
			EXIT
		END IF

	NEXT

	IF lsa_TransactionColumns [ li_Ndx ] = "SalesAcct01" THEN

		FOR ll_Dist = 1 TO UpperBound ( lstra_Trns [ ll_Trns ].istra_distributions )
	
			ls_value = ""
	
			lstr_Dist = lstra_Trns [ ll_Trns ].istra_distributions [ ll_Dist ]
			IF lstr_Dist.ib_credit = FALSE THEN
				//BusinessWorks uses only 1 default AR account -- you don't make 
				//receivables distribution entries, only sales entries.  If this
				//is a receivables entry, skip it and move on.
				CONTINUE
			END IF

			IF li_Ndx + 1 > UpperBound ( lsa_TransactionColumns ) THEN
				lb_RowError = TRUE
				EXIT
			END IF	

			ls_Value = lstr_Dist.is_account
			lds_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value
	
			li_Ndx ++
	
			ls_Value = String ( lstr_Dist.ic_amount, "0.00" )
			lds_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value
	
			li_Ndx ++

		NEXT

	ELSE

		lb_RowError = TRUE

	END IF

	IF lb_RowError THEN
		ll_Error_SkipCount ++
		IF Len ( ls_Error_SkipList ) > 0 THEN ls_Error_SkipList += ", "
		ls_Error_SkipList += lstra_Trns [ ll_Trns ].is_document_number
		lds_Work.deleterow ( ll_Row )
		CONTINUE
	END IF

NEXT


//Export contents of datastore to batch file

DO

	li_Result = lds_Work.SaveAs ( ls_BatchFilePath, CSV!, FALSE )

	IF li_Result = -1 THEN
		IF MessageBox ( ls_MessageHeader, "Could not save batch file.", Exclamation!, &
			RetryCancel!, 1 ) = 2 THEN

			ls_Reject = ""
			GOTO Failure

		END IF
	END IF

LOOP UNTIL li_Result = 1


//If appropriate, initiate BWWACCES.EXE to import the data just written
//Name of file for BWGold is normally BWGACCESS.EXE

IF lb_BWAccess THEN
	
	li_BWreturn = THIS.of_GetBWAccessLocation ( ls_BWPath )
	IF li_BWReturn = 1 THEN 
		ls_ExeFilePath = ls_BWPath
	ELSE  //Locate the bwaccess file

		ls_ExeFile = "BW*ACC*.EXE"  //Changed from "BWWACC*.EXE" in 3.5.18 to accommodate Gold
		ls_ExeFilePath = ""
		
		lb_ForceLocate = TRUE
		ls_GeneralHeader = ls_MessageHeader
		ls_CancelHeader = "Cancel BW Access"
		ls_CancelNote = "The bills have already been processed, and you will not have another "+&
			"opportunity to import them."
		
		IF of_FileLocate ( ls_ExeFile, ls_ExeFilePath, lb_ForceLocate, ls_GeneralHeader, &
			ls_CancelHeader, ls_CancelNote ) < 1 THEN
	
			RETURN -2
	
		END IF
	
	END IF


	//Added 3.5.18  --  Determine if we're dealing with BW Gold or not by checking the bwaccess file name.

	IF Match ( Upper ( ls_ExeFilePath ), "BWGACC.*\.EXE$" ) THEN  //this is like "*BWGACC*.EXE" in file lookup terms

		lb_Gold = TRUE

	END IF


	//Determine Business Works System Folder -- this is not necessary for Gold.

	IF lb_Gold = FALSE THEN   //Condition added 3.5.18 BKW

		ls_SystemFile = "BWW.EXE"
	
		IF Match ( Upper ( Right ( ls_ExeFilePath, 12 ) ), "BWWACC..\.EXE" ) THEN
	
			ls_SystemFilePath = Upper ( Left ( ls_ExeFilePath, Len ( ls_ExeFilePath ) - 12 ) ) +&
				"BWW.EXE"
	
		ELSE
	
			ls_SystemFilePath = ""
	
		END IF
	
		IF NOT FileExists ( ls_SystemFilePath ) THEN
	
			lb_ForceLocate = TRUE
	//		The following values are already set, above.
	//		ls_GeneralHeader = ls_MessageHeader
	//		ls_CancelHeader = "Cancel BW Access"
	//		ls_CancelNote = "The bills have already been processed, and you will not have another "+&
	//			"opportunity to import them."
			
			IF of_FileLocate ( ls_SystemFile, ls_SystemFilePath, lb_ForceLocate, ls_GeneralHeader, &
				ls_CancelHeader, ls_CancelNote ) < 1 THEN
	
				RETURN -2
	
			END IF
	
		END IF
	
		ls_SystemFilePath = Substitute ( Upper ( ls_SystemFilePath ), "\BWW.EXE", "" )

	END IF


	IF lb_Gold = FALSE THEN   //Condition added 3.5.18 BKW  --  System entry not needed for Gold
		lsa_Control [ UpperBound ( lsa_Control ) + 1 ] = "/SYSTEM," + ls_SystemFilePath
	END IF
	lsa_Control [ UpperBound ( lsa_Control ) + 1 ] = "/COMPANY," + ls_PostingCompany
	lsa_Control [ UpperBound ( lsa_Control ) + 1 ] = "/IMPORT,ART," + ls_BatchFilePath


	ls_ControlFilePath = Substitute ( ls_BatchFilePath, ".BWI", ".CTL" )
	ls_ControlFilePath = Substitute ( ls_ControlFilePath, ".bwi", ".ctl" )

	ls_ErrorFilePath = Substitute ( ls_BatchFilePath, ".BWI", ".ERR" )
	ls_ErrorFilePath = Substitute ( ls_ErrorFilePath, ".bwi", ".err" )


	DO

		li_Result = of_FileCreate ( ls_ControlFilePath, lsa_Control )

		IF li_Result = -1 THEN

			IF MessageBox ( ls_MessageHeader, "Error attempting to create control file.", &
				Exclamation!, RetryCancel!, 1 ) = 2 THEN

				ls_Reject = ""
				GOTO Failure

			END IF

		END IF

	LOOP WHILE li_Result = -1


	DO

		li_Result = of_FileCreate ( ls_ErrorFilePath )

		IF li_Result = -1 THEN

			IF MessageBox ( ls_MessageHeader, "Error attempting to create error log file.", &
				Exclamation!, RetryCancel!, 1 ) = 2 THEN

				ls_Reject = ""
				GOTO Failure

			END IF

		END IF

	LOOP WHILE li_Result = -1


	ls_Command = ls_ExeFilePath + " "
	ls_Command += "0" + " "
	ls_Command += ls_ControlFilePath + " "
	ls_Command += ls_ErrorFilePath

	DO

		li_Result = Run ( ls_Command )

		IF li_Result = -1 THEN

			IF MessageBox ( ls_MessageHeader, "Error attempting to run BWAccess.", &
				Exclamation!, RetryCancel!, 1 ) = 2 THEN

				ls_Reject = ""
				GOTO Failure

			END IF

		END IF

	LOOP WHILE li_Result = -1

END IF


//Inform user of any invoices that were not included in the batch

IF ll_Noco_SkipCount > 0 or ll_Error_SkipCount > 0 THEN

	IF ll_Noco_SkipCount > 0 THEN

		IF ll_Noco_SkipCount = 1 THEN
			ls_Work1 = "invoice was"
			ls_Work2 = "company"
		ELSE
			ls_Work1 = String ( ll_Noco_SkipCount) + " invoices were"
			ls_Work2 = "companies"
		END IF

		ls_Message += "The following " + ls_Work1 + " not included in the AR batch because the " +&
			ls_Work2 + " being billed did not have a valid accounting ID:~n~n" +&
			ls_Noco_SkipList

	END IF

	IF ll_Error_SkipCount > 0 THEN

		IF ll_Error_SkipCount = 1 THEN
			ls_Work1 = "invoice was"
		ELSE
			ls_Work1 = String ( ll_Error_SkipCount) + " invoices were"
		END IF

		IF Len ( ls_Message ) > 0 THEN
			ls_Message += "~n~n"
		END IF

		ls_Message += "The following " + ls_Work1 + " not included in the AR batch because "+&
			"of processing errors:~n~n" + ls_Error_SkipList

	END IF

	MessageBox ( "Notes on AR Batch", ls_Message )

END IF

DESTROY lds_Work

RETURN 1


Failure:

IF Len ( ls_Reject ) > 0 THEN
	MessageBox ( ls_MessageHeader, ls_Reject, Exclamation! )
END IF

DESTROY lds_Work

RETURN -1
end function

private function datastore of_datainitialization (string asa_transcolumns[]);/*
		Creates the datastore and sets the transaction columns.
		Returns:  datastore


*/

SetPointer(HourGlass!)

Integer	li_Return, &
			li_TransColumnCount, &
			li_ndx

Long		ll_row
datastore lds_work

li_Return = 1
li_TransColumnCount = upperbound( asa_transcolumns )
//Set up datastore to hold batch information for export
IF li_Return = 1 THEN
	lds_Work = of_CreateBatchDataStore ( li_TransColumnCount )
	IF NOT IsValid ( lds_Work ) THEN
		li_Return = -1
	END IF
END IF

////Put column headers into datastore
//IF li_Return = 1 THEN
//
//	setpointer(hourglass!)
//	
//	ll_row = lds_work.insertrow(0)
//	FOR li_ndx = 1 TO li_TransColumnCount
//		lds_work.object.data.primary[ll_row, li_ndx] = asa_transcolumns [][li_ndx]
//	NEXT
//
//END IF

RETURN lds_work
end function

private function integer of_bwwaccess (string as_batchfilepath, string as_importtype, string as_messageheader);/*
	Initiate BWWACCES.EXE to import the data just written
	
*/
SetPointer(HourGlass!)

Boolean	lb_ForceLocate, &
			lb_Gold

String	ls_ExeFile, &
			ls_ExeFilePath, &
			ls_GeneralHeader, &
			ls_CancelHeader, &
			ls_CancelNote, &
			ls_SystemFile, &
			ls_SystemFilePath, &
			lsa_Control [], &
			ls_ControlFilePath , &
			ls_ErrorFilePath, &
			ls_Command, &
			ls_BWPath
			
Integer	li_return, &
			li_Result,&
			li_BWReturn 

li_return = 1
li_BWreturn = THIS.of_GetBWAccessLocation ( ls_BWPath )
IF li_BWReturn = 1 THEN 
	ls_ExeFilePath = ls_BWPath
ELSE
	

	//Locate BWWACCES.EXE file  -- Gold will normally be BWGACCESS.EXE
	ls_ExeFile = "BW*ACC*.EXE"   //Changed from "BWWACC*.EXE" in 3.5.18 to accomodate Gold
	ls_ExeFilePath = ""
	lb_ForceLocate = TRUE
	ls_GeneralHeader = as_MessageHeader
	ls_CancelHeader = "Cancel BW Access"
	ls_CancelNote = "Cancelling will stop the export batch process."
	
	IF of_FileLocate ( ls_ExeFile, ls_ExeFilePath, lb_ForceLocate, ls_GeneralHeader, &
		ls_CancelHeader, ls_CancelNote ) < 1 THEN
		li_Return = -2
	END IF
END IF


IF li_Return = 1 THEN

	//Added 3.5.18  --  Determine if we're dealing with BW Gold or not by checking the bwaccess file name.

	IF Match ( Upper ( ls_ExeFilePath ), "BWGACC.*\.EXE$" ) THEN  //this is like "*BWGACC*.EXE" in file lookup terms

		lb_Gold = TRUE

	END IF

END IF


//Determine Business Works System Folder -- this is not necessary in Gold
IF li_Return = 1 AND lb_Gold = FALSE THEN  //Gold condition added 3.5.18 BKW
	ls_SystemFile = "BWW.EXE"
	IF Match ( Upper ( Right ( ls_ExeFilePath, 12 ) ), "BWWACC..\.EXE" ) THEN
		ls_SystemFilePath = Upper ( Left ( ls_ExeFilePath, Len ( ls_ExeFilePath ) - 12 ) ) +&
			"BWW.EXE"
	ELSE		
		ls_SystemFilePath = ""
	END IF

	IF NOT FileExists ( ls_SystemFilePath ) THEN
		lb_ForceLocate = TRUE
		IF of_FileLocate ( ls_SystemFile, ls_SystemFilePath, lb_ForceLocate, ls_GeneralHeader, &
			ls_CancelHeader, ls_CancelNote ) < 1 THEN	
			li_Return = -2
		END IF		
	END IF
	
END IF

/*			create control file				*/
IF li_Return = 1 THEN

	IF lb_Gold = FALSE THEN  //Gold condition added 3.5.18 BKW -- System file path not necessary for Gold
		ls_SystemFilePath = Substitute ( Upper ( ls_SystemFilePath ), "\BWW.EXE", "" )	
		lsa_Control [ UpperBound ( lsa_Control ) + 1 ] = "/SYSTEM," + ls_SystemFilePath
	END IF
	lsa_Control [ UpperBound ( lsa_Control ) + 1 ] = "/COMPANY," + is_PostingCompany	//"SAMPLE" 		
	// Context sensitive: ls_ImportType = "/IMPORT,ART," -OR- "/IMPORT,APT,"
	lsa_Control [ UpperBound ( lsa_Control ) + 1 ] = as_ImportType + as_BatchFilePath //+ ",REPORT"(parm to validate only)
	IF as_ImportType = "/IMPORT,PRT," THEN
		lsa_Control [ UpperBound ( lsa_Control ) ] = lsa_Control [ UpperBound ( lsa_Control ) ] + ",KEEPTC"
	END IF
	ls_ControlFilePath = Substitute ( as_BatchFilePath, ".BWI", ".CTL" )
	ls_ControlFilePath = Substitute ( ls_ControlFilePath, ".bwi", ".ctl" )		
	
	ls_ErrorFilePath = Substitute ( as_BatchFilePath, ".BWI", ".ERR" )
	ls_ErrorFilePath = Substitute ( ls_ErrorFilePath, ".bwi", ".err" )

	DO	
		li_Result = of_FileCreate ( ls_ControlFilePath, lsa_Control )

		IF li_Result = -1 THEN
			IF MessageBox ( as_MessageHeader, "Error attempting to create control file.", &
				Exclamation!, RetryCancel!, 1 ) = 2 THEN		
 
 				li_Return = -1
				EXIT
			END IF
		END IF
	LOOP WHILE li_Result = -1	
	
END IF

/*			create error log file				*/
IF li_Return = 1 THEN

	DO	
		li_Result = of_FileCreate ( ls_ErrorFilePath )		
		IF li_Result = -1 THEN

			IF MessageBox ( as_MessageHeader, "Error attempting to create error log file.", &
				Exclamation!, RetryCancel!, 1 ) = 2 THEN		

				li_Return = -1
				EXIT		
			END IF		
		END IF
		
	LOOP WHILE li_Result = -1

END IF

/*			run Business Works Access exe				*/
IF li_Return = 1 THEN
	ls_Command = ls_ExeFilePath + " "
	ls_Command += "0" + " "
	ls_Command += ls_ControlFilePath + " "
	ls_Command += ls_ErrorFilePath

	DO		
		li_Result = Run ( ls_Command )		
		IF li_Result = -1 THEN		
			IF MessageBox ( as_MessageHeader, "Error attempting to run BWAccess.", &
				Exclamation!, RetryCancel!, 1 ) = 2 THEN		

				li_Return = -1
				EXIT		
			END IF		
		END IF		
	LOOP WHILE li_Result = -1

END IF			

RETURN li_Return


end function

private function integer of_getbwaccesslocation (ref string as_location);//Returns:   1 = Success (value returned by reference in as_location)
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1
Int		li_FileID
n_cst_string	lnv_String



//Attempt to retrieve the BWAccess file path from the database.

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 53 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( ls_Description ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		//ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	IF FileExists ( ls_description ) THEN
	  //
	ELSE
		MessageBox ( "BW Access" , "The path specified in the system settings '" + ls_Description +&
			+"' does not exist. Please attempt to locate the BW Access file manually.")
			li_Return = 0			
	END IF
	
	IF li_Return = 1 THEN
		
		as_location = ls_description
		
	END IF

END IF

RETURN li_Return


end function

public function integer of_link_open (ref string as_posting_company);is_postingcompany = as_posting_company
return 1
end function

public function integer of_dataload (n_cst_accountingdata anva_accountingdata[]);SetPointer(HourGlass!)

Boolean	lb_RowError

string	ls_TransType, &
			lsa_transaction_columns[], &
			ls_value, &
			ls_reject, &
			ls_messageheader, &
			ls_MessageContext, & 
			ls_type, &
			ls_pathname, &
			ls_filename, &
			ls_TermsCode, &
			ls_ImportType, &
			ls_ContextDependentColumnStop, &
			ls_EarningsType, &
			lsa_distributionaccount[], &
			ls_Error_SkipList, &
			ls_EntityName, &
			ls_category, &
			ls_EntityId


Integer	li_Return, &
			li_TransactionSign, &
			li_DistributionSign, &
			li_ndx, &
			li_result

Long		ll_TransactionCount, &
			ll_DistributionCount, &
			ll_trns, &
			ll_dist, &
			ll_TransactionColumnCount, &
			ll_Error_SkipCount, &
			ll_row, &
			ll_Division
			
decimal	lca_AmountOwed[]

datastore					lds_work

n_cst_accountingdata		lnv_accountingdata

li_Return = 1
ls_category = anva_accountingdata[1].of_GetCategory ( )

Choose case upper( ls_category )
	case "PAYABLES"
		ls_TermsCode = "TV"    // TV = use vendor's default terms code
		ls_ImportType = "/IMPORT,APT,"
		ls_ContextDependentColumnStop = "DistAcct01"
		ls_type = "AP"
		ls_TransType = "/INVOICE"  
		ls_MessageContext = "AP"
		li_TransactionSign = -1
		li_DistributionSign = 1
		IF ib_Gold5 then
			lsa_transaction_columns = { &
							"TransactionLabel", &
							"VendorID", &
							"InvoiceNumber", &
							"InvoiceDate", &
							"InvoiceAmount", &
							"InvoiceReference", &
							"PurchaseOrderNumber", &
							"DueDate_TermsCode", &
							"DiscountAvailable", &
							"DiscountDate" }					
		else
			lsa_transaction_columns = { &
							"TransactionLabel", &
							"VendorID", &
							"InvoiceNumber", &
							"InvoiceDate", &
							"InvoiceAmount", &
							"InvoiceReference", &
							"DueDate_TermsCode", &
							"DiscountAvailable", &
							"DiscountDate" }		
		end if
		
		FOR li_Ndx = 1 TO 20  //BusinessWorks allows up to 20 distributions per invoice
			
			lsa_transaction_columns [ UpperBound ( lsa_transaction_columns ) + 1 ] = &
				"DistAcct" + String ( li_Ndx, "00" )
			lsa_transaction_columns [ UpperBound ( lsa_transaction_columns ) + 1 ] = &
				"DistAmt" + String ( li_Ndx, "00" )
		NEXT
	case "RECEIVABLES"
		ls_TermsCode = "TC" //"TC" tells BusinessWorks to calculate based on the customer's default terms code
		ls_ImportType = "/IMPORT,ART,"
		ls_MessageContext	= "AR"
		ls_ContextDependentColumnStop = "SalesAcct01"
		ls_type = "AR"
		ls_TransType = "/INVOICE" 
		li_TransactionSign = 1
		li_DistributionSign = -1
		lsa_transaction_columns = { &
						"TransactionLabel", &
						"CustomerId", &
						"InvoiceNumber", &
						"InvoiceDate", &
						"InvoiceAmount", &
						"InvoiceDescription", &
						"DueDate_TermsCode", &
						"DiscountAvailable", &
						"DiscountDate", &
						"SalesRepNumber", &
						"DefaultSalesAcct", &
						"FreightAmount", &
					/*	"TaxableSubtotal", &  This is only included if TAXSPLIT is specified as an import option*/ &
						"TaxAmount1", &
						"TaxId1", &
						"TaxAmount2", &
						"TaxId2", &
						"TaxAmount3", &
						"TaxId3" }	
						
		FOR li_Ndx = 1 TO 16  //BusinessWorks allows up to 16 sales distributions per invoice
	
			lsa_transaction_columns [ UpperBound ( lsa_transaction_columns ) + 1 ] = &
				"SalesAcct" + String ( li_Ndx, "00" )
			lsa_transaction_columns [ UpperBound ( lsa_transaction_columns ) + 1 ] = &
				"SalesAmt" + String ( li_Ndx, "00" )

		NEXT		
	case "PAYROLL"
		ls_ImportType = "/IMPORT,PRT,"
		ls_MessageContext	= "PR"
		ls_type = "PR"
		ls_EarningsType = "MISC"
		li_DistributionSign = 1
		lsa_transaction_columns = { &
						"EmployeeId", &
						"EarningsType", &
						"PLACEHOLDER", &
						"GrossWages" }
end choose

ls_messageheader = "Create " + ls_type + " Batch"
ls_reject = "Could not create "+ ls_type + " batch."
ll_TransactionCount = upperBound	( anva_accountingdata )
ll_TransactionColumnCount = upperBound	( lsa_transaction_columns[] )

//Get Batch File Name
IF li_Return = 1 THEN
	li_Return = this.of_getbatchfilename("bwi",ls_MessageContext, ls_filename, ls_pathname)
	//	returns 1 (success) or -1 (failure)
END IF

IF li_Return = 1 then
	lds_work = this.of_datainitialization( lsa_transaction_columns [] )
	IF NOT IsValid ( lds_Work ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN

	SetPointer ( HourGlass! )

	FOR ll_Trns = 1 TO ll_TransactionCount
	
		// Get a single transaction
		lnv_accountingdata = anva_accountingdata [ ll_Trns ]
		
		choose case upper(ls_category)
			case "PAYABLES"
				ls_EntityId = lnv_accountingdata.of_GetPayablesId ( )
			case "PAYROLL"
				ls_EntityId = lnv_accountingdata.of_GetPayrollId ( )
			case "RECEIVABLES"
				ls_EntityId = lnv_accountingdata.of_GetReceivablesId ( )
		end choose
		
		// Get associated AmountsOwed and determine the number of distributions for that trans.
		ll_DistributionCount = lnv_accountingdata.of_GetdistributionAmount ( lca_AmountOwed )
		lnv_accountingdata.of_GetcostexpenseAccount	(lsa_distributionaccount)
		ll_division = lnv_accountingdata.of_GetShipType ()
		//Make Transaction entries
		ll_row = lds_work.insertrow(0)

		if ll_trns = 1 then
			//get posting company from first transaction they should all be the same posting company
			n_cst_Ship_Type	lnv_Ship_type
			n_cst_shiptype		lnv_shiptype
			if not lnv_Ship_type.of_get_object(ll_Division, lnv_shiptype) = 1 then 
				//no posting company
			else
				is_postingcompany = lnv_shiptype.ids_data.object.st_accounting_company[1]
				if isvalid(lnv_shiptype) then
					destroy lnv_shiptype
				end if
			end if
//			lnv_ShipTypeManager.of_GetName ( li_Division, is_postingcompany )
		end if		
	
		FOR li_Ndx = 1 TO ll_TransactionColumnCount
			
			ls_value = ""
	
			CHOOSE CASE lsa_transaction_columns [ li_Ndx ]
					
			CASE "TransactionLabel"
				ls_Value = ls_TransType
				
			CASE "CustomerID", "VendorID", "EmployeeId"
				ls_Value = ls_EntityiD
				
			CASE "InvoiceNumber"
				ls_Value = string(lnv_accountingdata.of_GetDocumentNumber ( )	)
			CASE "InvoiceDate"
				ls_Value = string(lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YY")
				
			CASE "InvoiceAmount", "GrossWages"
				ls_Value = string(lnv_accountingdata.of_getPreTaxNet ( ))
				
			CASE "InvoiceDescription", "InvoiceReference"
				//BW only allows 20 characters in this field, so I've used the non-descriptive
				//version of the reference number list to conserve space.
				 
				 //Check This !! \\
				ls_Value = lnv_accountingdata.of_getDescription (  )
				
			CASE "PurchaseOrderNumber"	//15 character limit
				ls_Value = ""
				
			CASE "DueDate_TermsCode"
				ls_Value = ls_TermsCode
								
			CASE "EarningsType"
				ls_Value = ls_EarningsType

			CASE "PLACEHOLDER"
				ls_Value = ""
				
			CASE "DiscountAvailable"
				ls_Value = ""
				
			CASE "DiscountDate"
				ls_Value = ""
				
			CASE ELSE
				ls_Value = ""
				
			END CHOOSE
	
			lds_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value
	
		NEXT
	
		//Make Distribution entries
		IF ls_category <> "PAYROLL" THEN	
			FOR li_Ndx = 1 TO ll_TransactionColumnCount 
				// Stop when the first distribution column is reached
				IF lsa_transaction_columns [ li_Ndx ] = ls_ContextDependentColumnStop THEN  // ie: "SalesAcct01"
					EXIT
				END IF
		
			NEXT
		
			IF lsa_transaction_columns [ li_Ndx ] = ls_ContextDependentColumnStop THEN
		
				FOR ll_Dist = 1 TO ll_DistributionCount
					
					//BusinessWorks uses only 1 default AR account -- you don't make 
					//receivables distribution entries, only sales entries.  If this
					//is a receivables entry, skip it and move on.
					IF	ls_category = "RECEIVABLES" THEN
		//			IF lstr_Dist.ib_credit = FALSE THEN  // old code: the above should take its place
						
						CONTINUE
					END IF
		
					IF li_Ndx + 1 > ll_TransactionColumnCount THEN
						lb_RowError = TRUE
						EXIT
					END IF	
		
			
					ls_Value = lsa_distributionaccount[ll_Dist]
					lds_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value
			
					li_Ndx ++
					
					ls_Value = string(lca_AmountOwed[ll_Dist]  , "0.00")
					lds_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value
			
					li_Ndx ++
		
				NEXT
		
			ELSE
		
				lb_RowError = TRUE
		
			END IF
		
			IF lb_RowError THEN
				ll_Error_SkipCount ++
				IF Len ( ls_Error_SkipList ) > 0 THEN ls_Error_SkipList += ", "
				ls_Error_SkipList += string(lnv_accountingdata.of_GetDocumentNumber ( )	)
				lds_Work.deleterow ( ll_Row )
				CONTINUE
			END IF
		END IF
	NEXT

END IF

//Export contents of datastore to batch file
IF li_Return = 1 THEN
	DO
		li_result = lds_work.saveas(ls_pathname, CSV!, false)
		IF li_result = -1 THEN
			IF messagebox(ls_messageheader, "Could not save batch file.", exclamation!, &
				retrycancel!, 1) = 2 THEN
				ls_reject = ""
				li_Return = -1
				EXIT
			END IF
		END IF
	LOOP UNTIL li_result = 1
END IF

//Initiate BWWACCES.EXE to import the data just written
IF li_Return = 1 THEN
	li_return = this.of_bwwaccess(ls_pathname, ls_ImportType, ls_messageheader )
	ls_Reject = 'There was a problem trying to import the data into BusinessWorks'
END IF

IF li_Return = -1 THEN
	IF Len ( ls_Reject ) > 0 THEN		
		MessageBox ( ls_MessageHeader, ls_Reject, Exclamation! )		
	END IF
END IF

DESTROY lds_Work

RETURN li_Return
end function

private subroutine of_olddataload ();//SetPointer(HourGlass!)
//
//Boolean	lb_RowError, &
//			lb_company
//
//String	ls_ar_account, &
//			ls_TransType, &
//			lsa_transaction_columns[], &
//			lsa_distribution_columns[], &
//			lsa_check[], &
//			lsa_empty[], &
//			ls_value, &
//			ls_reject, &
//			ls_Error_SkipList, &
//			ls_messageheader, &
//			ls_MessageContext, & 
//			ls_type, &
//			ls_work1, &
//			ls_work2, &
//			ls_message, &
//			ls_pathname, &
//			ls_filename, &
//			ls_TermsCode, &
//			ls_ImportType, &
//			ls_ContextDependentColumnStop, &
//			ls_EarningsType, &
//			ls_EntityId, &
//			ls_EntityName, &
//			ls_DistributionAccount, &
//			ls_TransactionAccount, &
//			ls_FindString
//
//
//Integer	li_Return, &
//			li_winner, &
//			li_TransactionSign, &
//			li_DistributionSign, &
//			li_ndx, &
//			li_result, &
//			li_AmountType, &
//			li_Division
//
//Long		ll_TransactionCount, &
//			ll_DistributionCount, &
//			ll_trns, &
//			ll_dist, &
//			ll_Noco_SkipCount, &
//			ll_error_skipcount, &
//			ll_DistributionColumnCount, &
//			ll_TransactionColumnCount, &
//			ll_row, &
//			ll_FindRow, &
//			ll_Winner, &
//			ll_division
//			
//Dec {2}	lc_check, &
//			lc_AmountOwed
//			
//datastore					lds_work, &
//								lds_AccountMap
//
//n_cst_constants			lnv_Constants
//n_cst_beo_Transaction	lnv_CurrentTransaction
//n_cst_beo_AmountOwed		lnva_AmountsOwed [ ]
//n_cst_beo_AmountOwed		lnv_CurrentAmountOwed
//n_cst_beo_AmountType		lnv_CurrentAmountType
//n_cst_beo_Entity			lnv_CurrentEntity
//n_cst_dws					lnv_dws
//			
//
//li_Return = 1
//
//Choose case upper( as_category )
//	case "PAYABLES"
//		ls_TermsCode = "TV"    // TV = use vendor's default terms code
//		ls_ImportType = "/IMPORT,APT,"
//		ls_ContextDependentColumnStop = "DistAcct01"
//		ls_type = "AP"
//		ls_TransType = "/INVOICE"  
//		ls_MessageContext = "AP"
//		li_TransactionSign = -1
//		li_DistributionSign = 1
//		lsa_transaction_columns = { &
//						"TransactionLabel", &
//						"VendorID", &
//						"InvoiceNumber", &
//						"InvoiceDate", &
//						"InvoiceAmount", &
//						"InvoiceReference", &
//						"DueDate_TermsCode", &
//						"DiscountAvailable", &
//						"DiscountDate" }		
//		FOR li_Ndx = 1 TO 20  //BusinessWorks allows up to 20 distributions per invoice
//			
//			lsa_transaction_columns [ UpperBound ( lsa_transaction_columns ) + 1 ] = &
//				"DistAcct" + String ( li_Ndx, "00" )
//			lsa_transaction_columns [ UpperBound ( lsa_transaction_columns ) + 1 ] = &
//				"DistAmt" + String ( li_Ndx, "00" )
//		NEXT
//	case "RECEIVABLES"
//		ls_TermsCode = "TC" //"TC" tells BusinessWorks to calculate based on the customer's default terms code
//		ls_ImportType = "/IMPORT,ART,"
//		ls_MessageContext	= "AR"
//		ls_ContextDependentColumnStop = "SalesAcct01"
//		ls_type = "AR"
//		ls_TransType = "/INVOICE" 
//		li_TransactionSign = 1
//		li_DistributionSign = -1
//		lsa_transaction_columns = { &
//						"TransactionLabel", &
//						"CustomerId", &
//						"InvoiceNumber", &
//						"InvoiceDate", &
//						"InvoiceAmount", &
//						"InvoiceDescription", &
//						"DueDate_TermsCode", &
//						"DiscountAvailable", &
//						"DiscountDate", &
//						"SalesRepNumber", &
//						"DefaultSalesAcct", &
//						"FreightAmount", &
//					/*	"TaxableSubtotal", &  This is only included if TAXSPLIT is specified as an import option*/ &
//						"TaxAmount1", &
//						"TaxId1", &
//						"TaxAmount2", &
//						"TaxId2", &
//						"TaxAmount3", &
//						"TaxId3" }	
//						
//		FOR li_Ndx = 1 TO 16  //BusinessWorks allows up to 16 sales distributions per invoice
//	
//			lsa_transaction_columns [ UpperBound ( lsa_transaction_columns ) + 1 ] = &
//				"SalesAcct" + String ( li_Ndx, "00" )
//			lsa_transaction_columns [ UpperBound ( lsa_transaction_columns ) + 1 ] = &
//				"SalesAmt" + String ( li_Ndx, "00" )
//
//		NEXT		
//	case "PAYROLL"
//		ls_ImportType = "/IMPORT,PRT,"
//		ls_MessageContext	= "PR"
//		ls_type = "PR"
//		ls_EarningsType = "MISC"
//		li_DistributionSign = 1
//		lsa_transaction_columns = { &
//						"EmployeeId", &
//						"EarningsType", &
//						"PLACEHOLDER", &
//						"GrossWages" }
//end choose
//
//ls_messageheader = "Create " + ls_type + " Batch"
//ls_reject = "Could not create "+ ls_type + " batch."
//ll_TransactionCount = upperBound	( anva_Transactions )
//ll_DistributionColumnCount = upperBound	( lsa_distribution_columns[] )
//ll_TransactionColumnCount = upperBound	( lsa_transaction_columns[] )
//
////Get Batch File Name
//IF li_Return = 1 THEN
//	li_Return = this.of_getbatchfilename("bwi",ls_MessageContext, ls_filename, ls_pathname)
//	//	returns 1 (success) or -1 (failure)
//END IF
//
//lnv_dws.of_CreateDataStoreByDataObject ( "d_dlkc_accountmap", lds_AccountMap, FALSE )
//lds_AccountMap.Retrieve()
//
//IF li_Return = 1 then
//	lds_work = this.of_datainitialization( lsa_transaction_columns [] )
//	IF NOT IsValid ( lds_Work ) THEN
//		li_Return = -1
//	END IF
//END IF
//
//
//IF li_Return = 1 THEN
//
//	SetPointer ( HourGlass! )
//
//	FOR ll_Trns = 1 TO ll_TransactionCount
//	
//		lb_RowError = FALSE
//		
//		// load current transaction into a local var
//		lnv_CurrentTransaction = anva_transactions [ ll_trns ]
//		
//		// load all associated AmountsOwed into local Var
//		lnv_CurrentTransaction.of_GetAmountsList ( lnva_AmountsOwed )
//		ll_DistributionCount = UpperBound ( lnva_AmountsOwed )
//	
//		// load current Entity
//		lnv_CurrentEntity = lnv_CurrentTransaction.of_GetEntity ( ) 
//		
//		IF NOT isValid ( lnv_CurrentEntity ) THEN
//			li_Return = -1
//		END IF
//
//		//Get account from amountowed type with greatest amount
//		
//		lc_check = 0
//		ll_winner = 0
//		for ll_dist = 1 to ll_DistributionCount
//			lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_Dist ]
//			lc_AmountOwed = lnv_CurrentAmountOwed.of_GetAmount ( )
//			IF lc_AmountOwed * li_DistributionSign > lc_check then
//				lc_check = lnv_CurrentAmountOwed.of_GetAmount ( ) * li_DistributionSign
//				ll_winner = ll_Dist
//			end if
//		next
//
//		if ll_winner = 0 then
//			//error msg
//			continue
//		end if
//
//		/*	 An accountmap should be found. These were already validated.	*/ 
//		lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_winner ]
//		li_AmountType = lnv_CurrentAmountOwed.of_GetType ( )
//		li_Division = lnv_CurrentAmountOwed.of_GetDivision ( )
//		ls_FindString = "accountmap_division = " + string ( li_Division ) + &
//							" and accountmap_amounttypeid = " + string ( li_AmountType )
//		ll_FindRow = lds_AccountMap.Find ( ls_FindString, 1, lds_AccountMap.RowCount() )
//		
//		if ll_trns = 1 then
//			//get posting company from first transaction they should all be the same posting company
//			n_cst_Ship_Type	lnv_Ship_type
//			n_cst_shiptype		lnv_shiptype
//			if not lnv_Ship_type.of_get_object(li_Division, lnv_shiptype) = 1 then 
//				//no posting company
//			else
//				is_postingcompany = lnv_shiptype.ids_data.object.st_accounting_company[1]
//				if isvalid(lnv_shiptype) then
//					destroy lnv_shiptype
//				end if
//			end if
////			lnv_ShipTypeManager.of_GetName ( li_Division, is_postingcompany )
//		end if		
//	
///*  If we want to use this method for receivables 
//		then we will have to copy the 	//Check for AR account
//		
//		logic from of_batch_create
//*/
//
//		IF ll_FindRow > 0 THEN
//			CHOOSE CASE ls_type
//				CASE "AP"
//					ls_EntityName = lnv_CurrentEntity.of_GetPayablesId ( )
//					ls_TransactionAccount = lds_AccountMap.Object.accountmap_apaccount[ll_FindRow]
//		
//				CASE "AR"
//		//			ls_EntityName = lnv_CurrentEntity.of_GetReceivablesId ( )
//		//			ls_TransactionAccount = lds_AccountMap.Object.accountmap_araccount[ll_FindRow]
//		
//				CASE "PR"
//					ls_EntityName = lnv_CurrentEntity.of_GetPayrollId ( )
//					ls_TransactionAccount = lds_AccountMap.Object.accountmap_payrollcashaccount[ll_FindRow]
//		
//			END CHOOSE
//		END IF
//
//	
//		//Make Transaction entries
//	
//		ll_Row = lds_Work.InsertRow ( 0 )
//	
//		FOR li_Ndx = 1 TO ll_TransactionColumnCount
//			
//			ls_value = ""
//	
//			CHOOSE CASE lsa_transaction_columns [ li_Ndx ]
//					
//			CASE "TransactionLabel"
//				ls_Value = ls_TransType
//				
//			CASE "CustomerID", "VendorID", "EmployeeId"
//				ls_Value = ls_EntityName
//				
//			CASE "InvoiceNumber"
//				ls_Value = lnv_CurrentTransaction.of_GetDocumentNumber ( )
//			CASE "InvoiceDate"
//				ls_Value = String ( lnv_CurrentTransaction.of_GetDocumentDate ( ) , "mm/dd/yy" )
//				
//			CASE "InvoiceAmount", "GrossWages"
//				ls_Value = String ( lnv_CurrentTransaction.of_GetPreTaxNet  ( )  )
//				
//			CASE "InvoiceDescription", "InvoiceReference"
//				//BW only allows 20 characters in this field, so I've used the non-descriptive
//				//version of the reference number list to conserve space.
//				 
//				 //Check This !! \\
//				ls_Value = lnv_CurrentTransaction.of_getDescription (  )
//				
//			CASE "DueDate_TermsCode"
//				ls_Value = ls_TermsCode
//								
//			CASE "EarningsType"
//				ls_Value = ls_EarningsType
//
//			CASE "PLACEHOLDER"
//				ls_Value = ""
//				
//			CASE "DiscountAvailable"
//				ls_Value = ""
//				
//			CASE "DiscountDate"
//				ls_Value = ""
//				
//			CASE ELSE
//				ls_Value = ""
//				
//			END CHOOSE
//	
//			lds_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value
//	
//		NEXT
//	
//		//Make Distribution entries
//		IF as_category <> "PAYROLL" THEN	
//			FOR li_Ndx = 1 TO ll_TransactionColumnCount 
//				// Stop when the first distribution column is reached
//				IF lsa_transaction_columns [ li_Ndx ] = ls_ContextDependentColumnStop THEN  // ie: "SalesAcct01"
//					EXIT
//				END IF
//		
//			NEXT
//		
//			IF lsa_transaction_columns [ li_Ndx ] = ls_ContextDependentColumnStop THEN
//		
//				FOR ll_Dist = 1 TO UpperBound ( lnva_AmountsOwed )
//					
//					// Get Associated Amount Owed
//					lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_Dist ]  
//					li_AmountType = lnv_CurrentAmountOwed.of_GetType ( )
//					li_Division = lnv_CurrentAmountOwed.of_GetDivision ( )
//					ls_FindString = "accountmap_division = " + string ( li_Division ) + &
//										" and accountmap_amounttypeid = " + string ( li_AmountType )
//					ll_FindRow = lds_AccountMap.Find ( ls_FindString, 1, lds_AccountMap.RowCount() )
//					
//					// get account
//					IF ll_FindRow > 0 THEN
//						CHOOSE CASE ls_type
//							CASE "AP"
//								ls_DistributionAccount = lds_AccountMap.Object.accountmap_costaccount[ll_FindRow]
//					
//							CASE "AR"
//					//			ls_DistributionAccount = lds_AccountMap.Object.accountmap_salesaccount[ll_FindRow]
//					
//							CASE "PR"
//								ls_DistributionAccount = lds_AccountMap.Object.accountmap_payrollexpenseaccount[ll_FindRow]
//					
//						END CHOOSE
//					END IF
//					
//					//BusinessWorks uses only 1 default AR account -- you don't make 
//					//receivables distribution entries, only sales entries.  If this
//					//is a receivables entry, skip it and move on.
//					IF	as_category = "RECEIVABLES" THEN
//		//			IF lstr_Dist.ib_credit = FALSE THEN  // old code: the above should take its place
//						
//						CONTINUE
//					END IF
//		
//					IF li_Ndx + 1 > ll_TransactionColumnCount THEN
//						lb_RowError = TRUE
//						EXIT
//					END IF	
//		
//			
//					ls_Value = ls_DistributionAccount
//					lds_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value
//			
//					li_Ndx ++
//					
//					ls_Value = String ( lnv_CurrentAmountOwed.of_GetAmount ( ) , "0.00" )
//					lds_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value
//			
//					li_Ndx ++
//		
//				NEXT
//		
//			ELSE
//		
//				lb_RowError = TRUE
//		
//			END IF
//		
//			IF lb_RowError THEN
//				ll_Error_SkipCount ++
//				IF Len ( ls_Error_SkipList ) > 0 THEN ls_Error_SkipList += ", "
//				ls_Error_SkipList += lnv_CurrentTransaction.of_GetDocumentNumber ( )
//				lds_Work.deleterow ( ll_Row )
//				CONTINUE
//			END IF
//		END IF
//	NEXT
//
//END IF
//
////Export contents of datastore to batch file
//IF li_Return = 1 THEN
//	DO
//		li_result = lds_work.saveas(ls_pathname, CSV!, false)
//		IF li_result = -1 THEN
//			IF messagebox(ls_messageheader, "Could not save batch file.", exclamation!, &
//				retrycancel!, 1) = 2 THEN
//				ls_reject = ""
//				li_Return = -1
//				EXIT
//			END IF
//		END IF
//	LOOP UNTIL li_result = 1
//END IF
//
////Initiate BWWACCES.EXE to import the data just written
//IF li_Return = 1 THEN
//	li_return = this.of_bwwaccess(ls_pathname, ls_ImportType, ls_messageheader )
//END IF
//
//IF li_Return = -1 THEN
//	IF Len ( ls_Reject ) > 0 THEN		
//		MessageBox ( ls_MessageHeader, ls_Reject, Exclamation! )		
//	END IF
//END IF
//
//DESTROY lds_Work
//DESTROY lds_AccountMap
//RETURN 1
end subroutine

on n_cst_acctlink_businessworks.create
call super::create
end on

on n_cst_acctlink_businessworks.destroy
call super::destroy
end on

event constructor;call super::constructor;any		la_value
string	ls_value

n_cst_setting_accpkgs	lnv_Setting

lnv_Setting = create n_cst_setting_accpkgs


la_Value = lnv_Setting.of_Getvalue( )
	
ls_Value = Upper(String(la_Value))

CHOOSE CASE UPPER(ls_Value)
	CASE "BUSINESSWORKS"
		ib_Gold5 = FALSE
	CASE "BUSINESSWORKS GOLD 5"
		ib_Gold5 = TRUE
	CASE ELSE
		ib_Gold5 = FALSE
END CHOOSE		


end event

