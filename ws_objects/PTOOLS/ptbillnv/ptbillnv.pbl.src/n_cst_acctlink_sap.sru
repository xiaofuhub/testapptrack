$PBExportHeader$n_cst_acctlink_sap.sru
forward
global type n_cst_acctlink_sap from n_cst_acctlink
end type
end forward

global type n_cst_acctlink_sap from n_cst_acctlink
end type
global n_cst_acctlink_sap n_cst_acctlink_sap

type variables
Private:
DataStore	ids_Mappings


n_cst_batchsrv_sap	inv_SapSrv
end variables

forward prototypes
public function integer of_batch_create (n_cst_msg anv_cst_msg)
private function string of_getdlcustomerline (s_accounting_transaction astr_transaction, n_cst_beo_shipment anv_shipment, ref real ar_amount)
end prototypes

public function integer of_batch_create (n_cst_msg anv_cst_msg);//Return Values : 1 = Success, -1 = Failure, -2 = User Chose No AR Batch
Int		li_Return = 1
Int	 	li_ndx
Int		li_Width
Int		li_DHIndex
Int		li_DLIndex
Int		li_RowCount
Int		li_TransIndx
Int 		li_FileHandle
Int		li_ResultIndex
Int		li_HeaderIndex
Int		li_TotalDHCount
Int		li_TotalDLCount
Int		li_UseDefaultRtn
Int		li_DistributionIndex
Int		li_batchFolderRtn
Int		li_TransactionCount
Int		li_DistributionCount
Int		li_TotalDLCountForFile
Long 		i
Long		ll_ShipmentID
Long		ll_RecordCount
Real		lr_TotalDocumentAmount
Real		lr_TotalTransactionAmount
string	ls_batch_type
string 	ls_message_header
String	ls_Path
string  	ls_value
String	ls_Title
String	ls_reject
String	ls_Filter
String	ls_DHLine
String	ls_PadSide
String	ls_DLLineGL
String	ls_PathName
String	ls_FileName
String	ls_FieldName
String	lsa_Results[]
String	ls_HeaderLine
String	ls_DLLineCust
String	ls_PaddedValue
String	ls_ErrorMessage
String	ls_CancelWarning
Constant String	ls_Extension = "txt"
Boolean	lb_UseDefault
Boolean	lb_Required

String lsa_DLLinesGL []
String	lsa_Empty[]

n_cst_String	lnv_String
n_ds				lds_DLSource
n_ds				lds_DHSource
n_ds 				lds_HeaderSource
n_cst_file		lnv_FileSrv
s_parm 			lstr_parm
n_cst_msg 		lnv_cst_msg
s_accounting_transaction lstra_trns[]
s_accounting_transaction lstr_CurrentTrans
s_accounting_distribution lstr_CurrentDistribution
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Disp
//n_cst_BatchSrv_SAP	inv_SapSrv

lnv_Disp = CREATE n_Cst_bso_Dispatch
lnv_Shipment = CREATE n_cst_beo_Shipment
inv_SapSrv = Create  n_cst_BatchSrv_SAP

//There was some freaky behavior here.  I was declaring the following two variables
//below ( i.e. :  string ls_message_header = "Create AR Batch" ) and somehow the
//value was being set (consistently) to another string value from outside this object!
//The separate declaration / value assignment works fine, however.


ls_message_header = "Create AR Batch"
ls_reject = "Could not create AR batch."


ls_CancelWarning = "You have indicated that you do not wish to create an AR Batch.~n~n"+&
		"PLEASE NOTE: The bills have already been processed, and you will not be able to "+&
		"recreate an AR Batch for them later."
	
ls_Title = "Specify Batch File Location"
ls_Filter = "txt Files (*.txt), *.txt" 

//Extract parameters from message object that was passed in.

for li_ndx = 1 to anv_cst_msg.of_get_count()
	if anv_cst_msg.of_get_parm(li_ndx, lstr_parm) > 0 then
		choose case lstr_parm.is_label
		case "BATCH_TYPE"
			ls_batch_type = lstr_parm.ia_value
		case "TRANSACTION"
			lstra_trns[upperbound(lstra_trns) + 1] = lstr_parm.ia_value
		end choose
	end if
next

//Validate requested batch type
choose case ls_batch_type
case "SALES!"
	//Batch type is OK
case else
	li_Return = -1
end choose

li_UseDefaultRtn = THIS.of_UseDefaultBatchName ( )

//           1 = Success, YES!
//				 2 = Success, NO!
//				 3 = success, ASK!
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

CHOOSE CASE li_useDefaultRtn
	CASE -1 ,0 ,3
		IF	MessageBox ( "Default Batch Name" , "Do you wish to use the default AR batch name?", QUESTION!, YESNO!, 1 ) = 1 THEN
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
	ls_PathName = String ( Now ( ), "mmddhhmmss") + "." + ls_extension
	IF li_BatchFolderRtn = 1 THEN
		ls_PathName = ls_Path + String ( Now ( ), "mmddhhmmss") + "." + ls_extension
	END IF
	ls_FileName = ""
	IF lnv_FileSrv.of_GetFileSaveName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
		ls_Filter, ls_CancelWarning ) = -1 THEN
		RETURN -2
	END IF	
ELSE	
	ls_PathName = ls_Path + String ( Now ( ), "mmddhhmmss") + "." + ls_extension
	ls_FileName = String ( Now ( ), "mmddhhmmss") + "." + ls_extension	
END IF

setpointer(hourglass!)	

//Initialize transaction and distribution column arrays
/*
	1.2	Document Lines
	A document consists of one document header line (DH) and two to ninety-nine data lines (DL). 
	Data lines are further classified to customer line or GL line. 

	Sequence of data lines :
	·  For account receivable document, customer line must precede GL line. 
*/
// for every transaction we need to create at the minimum
// 1 DH
// 1 DL (customer line)
// 1 DL (GL Line)
		
IF inv_SapSrv.of_GetBatchMetaData(inv_SapSrv.cs_LineType_DH, lds_DHSource) <> 1 THEN
	li_Return = -1
END IF

IF inv_SapSrv.of_GetBatchMetaData(inv_SapSrv.cs_linetype_dl_gl  , lds_DLSource) <> 1 THEN
	li_Return = -1
END IF

IF inv_SapSrv.of_GetBatchMetaData(inv_SapSrv.cs_LINETYPE_BH, lds_HeaderSource) <> 1 THEN
	li_Return = -1
END IF

li_TransactionCount = UpperBound ( lstra_trns )
FOR li_transIndx = 1 TO li_transactionCount

	/*	For Each transaction, build the two DL lines first then do the DL line.
		stick this into an array so that we can write the whole file at once. 	
	*/
	
	ls_DHLine = ""
	ls_DLLineCust = ""
	ls_DLLineGL = ""	
	lr_TotalTransactionAmount = 0
	ll_ShipmentID = 0
	li_TotalDLCountForFile += li_totalDLCount  // get it before you reset it.
	li_TotalDLCount = 0
	
	
	lstr_CurrentTrans = lstra_trns[li_transIndx]
	IF UpperBound ( lstr_CurrentTrans.isa_tmps ) > 0 THEN
		IF isNumber ( lstr_CurrentTrans.isa_tmps [1]) THEN
			ll_ShipmentID = Long ( lstr_CurrentTrans.isa_tmps [1] )
		END IF
	END IF
		
	lnv_Disp.of_RetrieveShipment ( ll_ShipmentID ) 
	lnv_Shipment.of_SetSource ( lnv_Disp.of_GetShipmentCache ( ) )
	lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
	lnv_Shipment.of_SetItemSource ( lnv_Disp.of_GetItemCache ( ) )
	lnv_Shipment.of_SetEventSource ( lnv_Disp.of_GetEventCache ( ) )
	
	
	// Right now I am making the assumption that the shipment to transaction ration 
	// will be 1:1  
	inv_SapSrv.of_Setnextdocumentnumber( ) // this uses get next id and sets an instance var
													// that the of_getvalue can use.
	
	li_DistributionCount = UpperBound ( lstr_CurrentTrans.istra_distributions )
	li_TotalDLCount ++
	
	ls_DLLineCust = THIS.of_getdlcustomerline( lstr_CurrentTrans,lnv_Shipment , lr_TotalTransactionAmount )
	lr_TotalDocumentAmount += lr_TotalTransactionAmount
	
	FOR li_DistributionIndex = 1 TO li_DistributionCount
		
		
		lstr_CurrentDistribution = lstr_CurrentTrans.istra_distributions[li_DistributionIndex]
		
		IF lstr_CurrentDistribution.ib_credit = FALSE THEN	
			CONTINUE		
		ELSE				

		END IF
		
		li_RowCount = 0 
		li_TotalDLCount ++
				
		IF isvalid ( lds_DLSource ) THEN
			li_RowCount = lds_DLSource.RowCount ( )
		END IF		
		
		
		FOR li_DLIndex = 1 TO li_RowCount
						
			ls_Value = ""			
			ls_FieldName = lds_DLSource.GetItemString ( li_DlIndex , "field_name" )
			li_Width = lds_DLSource.GetItemNumber ( li_DlIndex , "field_width" )
			ls_PadSide = lds_DLSource.GetItemString( li_DLIndex, "pad_side" )
			lb_Required = Upper ( lds_DLSource.GetItemString ( li_DLIndex , "field_status" ) )= "M"
			
//			IF Upper ( ls_FieldName ) = "LINECOUNT" THEN
//				ls_Value = String ( li_TotalDLCount , "000" )
//			ELSE			
				inv_SapSrv.of_GetValue(ls_FieldName, lds_DLSource , lnv_Shipment , lstr_CurrentTrans, li_DistributionIndex, ls_Value)
			//END IF
			
			// before we pad we are going to need to jump in here and perform
			// any special processing that might be needed.			
			CHOOSE CASE Upper ( ls_FieldName )
					  
				CASE "DOCUMENTAMOUNT"
					 
					IF IsNumber ( ls_Value ) THEN
						lr_TotalDocumentAmount+= Real ( ls_Value )
						lr_TotalTransactionAmount += Real ( ls_Value )
						ls_Value = string(Real ( ls_Value ), "0.00")					
					END IF
				CASE "LINENUMBER"
					ls_Value = String ( li_TotalDLCount , "000" )					
			END CHOOSE
					
			CHOOSE CASE Upper ( ls_PadSide )
				CASE "L"
					ls_PaddedValue = lnv_String.of_Padleft ( ls_Value , li_Width  )
				CASE "R"
					ls_PaddedValue = lnv_String.of_PadRight ( ls_Value , li_Width  )
			END CHOOSE
			
			IF lb_Required AND Len ( Trim ( ls_paddedValue ) ) = 0 THEN
				
				ls_ErrorMessage += "Missing a value for required field '" +ls_fieldName + "' on shipment " + String ( ll_ShipmentID )+".~r~n"
				li_Return = -1
			END IF
			
			
																	
			// we need to make the following check b.c. of_PadLeft will return the entire string if the length of the value
			// is larger than the specified width.
			IF Len ( ls_paddedValue ) > li_Width THEN
				ls_PaddedValue = Left ( ls_PaddedValue , li_Width )
			END IF
		
			//IF li_DistributionIndex = 1 THEN
			//	ls_DLLineCust += ls_PaddedValue
			//ELSEIF li_DistributionIndex = 2 THEN
				ls_DLLineGL += ls_PaddedValue
			//END IF
				
		NEXT
				
		lsa_DLLinesGL [ UpperBound ( lsa_DLLinesGL ) + 1 ] = ls_DLLineGL
		ls_DLLineGL = ""
		
	NEXT// Loop for li_DistributionIndex: we go through twice once for customer and then again for GL. 
	
	
	//////////////////////////// Process the DH LINE
	li_RowCount = 0
	IF IsValid ( lds_DHSource ) THEN
		li_RowCount = lds_DHSource.RowCount ( )
	END IF
	
	li_TotalDHCount ++
	
	FOR li_DhIndex = 1 TO li_RowCount
		
		
		ls_Value = ""
				
		ls_FieldName = lds_DHSource.GetItemString ( li_DhIndex , "field_name" )
		li_Width = lds_DHSource.GetItemNumber ( li_DhIndex , "field_width" )
		ls_PadSide = lds_DHSource.GetItemString( li_DhIndex, "pad_side" )
		lb_Required = Upper ( lds_DHSource.GetItemString ( li_DhIndex , "field_status" ) )= "M"
		
		inv_SapSrv.of_GetValue(ls_FieldName, lds_DHSource , lnv_Shipment , lstr_CurrentTrans, ls_Value)
	
		CHOOSE CASE Upper ( ls_FieldName )
				  
			CASE "AMOUNTCOUNT"
				ls_Value = String ( lr_TotalTransactionAmount , "#.00")
			CASE "LINECOUNT"
				ls_Value = String ( li_TotalDLCount , "000" )
		END CHOOSE
		
		CHOOSE CASE Upper ( ls_PadSide )
			CASE "L"
				ls_PaddedValue = lnv_String.of_Padleft ( ls_Value , li_Width  )
			CASE "R"
				ls_PaddedValue = lnv_String.of_PadRight ( ls_Value , li_Width  )
		END CHOOSE
		
		IF lb_Required AND Len ( Trim ( ls_paddedValue ) ) = 0 THEN				
			ls_ErrorMessage += "Missing a value for required field '" +ls_fieldName + "' on shipment " + String ( ll_ShipmentID )+".~r~n"
			li_Return = -1
		END IF
		
							
		IF Len ( ls_paddedValue ) > li_Width THEN
			ls_PaddedValue = Left ( ls_PaddedValue , li_Width )
		END IF
		
		ls_DHLine += ls_PaddedValue
		
		
	NEXT  // loop for the DH Record.
	

	// before we process the next transaction put the results into the result array
	li_ResultIndex ++
	lsa_Results[ li_ResultIndex ] = ls_DHLine
	li_ResultIndex ++
	lsa_Results[ li_ResultIndex ] = ls_DLLineCust
	FOR i = 1 To UpperBound ( lsa_DLLinesGL )
		li_ResultIndex ++
		lsa_Results[ li_ResultIndex ] = lsa_DLLinesGL[i]
	NEXT
	
	lsa_DLLinesGL = lsa_Empty[]
	
NEXT // loop for each transaction

li_TotalDLCountForFile += li_totalDLCount 
	
//////// THEN we are going to build the header record. We are doing this last because we need totals
li_RowCount = 0 
IF IsValid ( lds_HeaderSource ) THEN
	li_RowCount = lds_HeaderSource.RowCount( )
END IF


FOR li_HeaderIndex = 1 TO li_RowCount 
	
	ls_Value = ""
		
	ls_FieldName = lds_HeaderSource.GetItemString ( li_HeaderIndex , "field_name" )
	li_Width = lds_HeaderSource.GetItemNumber ( li_HeaderIndex , "field_width" )
	ls_PadSide = lds_HeaderSource.GetItemString( li_HeaderIndex, "pad_side" )	
	lb_Required = Upper ( lds_HeaderSource.GetItemString ( li_HeaderIndex , "field_status" ) )= "M"
	inv_SapSrv.of_GetValue(ls_FieldName, lds_HeaderSource , lnv_Shipment , lstr_CurrentTrans, ls_Value)
			
	CHOOSE CASE Upper ( ls_FieldName )
			  
		CASE "DOCUMENTCOUNT"
			ls_Value = String ( li_TotalDHCount  )
		CASE "LINECOUNT"
			ls_Value = STRING ( li_TotalDLCountForFile )
		CASE "CONTROLTOTAL"
			ls_Value = String ( lr_TotalDocumentAmount , "#.00")
			
	END CHOOSE
	
	CHOOSE CASE Upper ( ls_PadSide )
		CASE "L"
			ls_PaddedValue = lnv_String.of_Padleft ( ls_Value , li_Width  )
		CASE "R"
			ls_PaddedValue = lnv_String.of_PadRight ( ls_Value , li_Width  )
	END CHOOSE
					
	IF lb_Required AND Len ( Trim ( ls_paddedValue ) ) = 0 THEN				
		ls_ErrorMessage += "Missing a value for required field '" +ls_fieldName + "' on shipment " + String ( ll_ShipmentID ) +".~r~n"
		li_Return = -1
	END IF	
				
	IF Len ( ls_paddedValue ) > li_Width THEN
		ls_PaddedValue = Left ( ls_PaddedValue , li_Width )		
	END IF
	
	ls_HeaderLine += ls_PaddedValue

NEXT
	
DESTROY ( lds_HeaderSource )
DESTROY ( lnv_Disp )
DESTROY ( lnv_Shipment )
Destroy ( inv_SapSrv)
	

li_FileHandle = FileOpen ( ls_PathName , LineMode!  , Write! )
IF li_FileHandle < 0 THEN
	li_Return = -1 
END IF

ll_RecordCount = UpperBound ( lsa_Results )
FileWrite ( li_fileHandle , ls_HeaderLine )
FOR i = 1 TO ll_RecordCount 
	FileWrite ( li_FileHandle , lsa_Results[i] )
NEXT
FILEWrite ( li_FileHandle , "BT" )
FileClose ( li_FileHandle )

IF li_Return = -1 AND ls_ErrorMessage <> "" THEN	
	MessageBox ( "Error during batch creation" , ls_ErrorMessage )
END IF

RETURN li_Return
	
	

end function

private function string of_getdlcustomerline (s_accounting_transaction astr_transaction, n_cst_beo_shipment anv_shipment, ref real ar_amount);

n_cst_String	lnv_String
n_ds				lds_DLSource
n_ds				lds_DHSource
n_ds 				lds_HeaderSource
n_cst_file		lnv_FileSrv
s_parm 			lstr_parm
n_cst_msg 		lnv_cst_msg
s_accounting_transaction lstra_trns[]
s_accounting_transaction lstr_CurrentTrans


inv_sapsrv.of_GetBatchMetaData(inv_SapSrv.cs_LineType_DL_Customer, lds_DLSource)

Int	i
Real	lr_totalAmount
FOR i = 1 TO UpperBound (  astr_Transaction.istra_distributions )
	IF astr_Transaction.istra_distributions[i].ib_credit = FALSE THEN	
		CONTINUE
	END IF
		
	lr_totalAmount += astr_Transaction.istra_distributions[i].ic_Amount
		
NEXT

ar_amount = lr_totalAmount
		
		

Int	li_Rowcount	
Int	li_DLIndex
String	ls_Fieldname
Int	li_Width
String	ls_PadSide
Boolean	lb_Required
Int	li_DistributionIndex
String	ls_value

String	ls_PaddedValue
String	ls_ErrorMessage
Long	ll_ShipmentID
String	ls_dllineCust
Int	li_Return

IF isvalid ( lds_DLSource ) THEN
	li_RowCount = lds_DLSource.RowCount ( )
END IF


FOR li_DLIndex = 1 TO li_RowCount
			
	ls_Value = ""			
	ls_FieldName = lds_DLSource.GetItemString ( li_DlIndex , "field_name" )
	li_Width = lds_DLSource.GetItemNumber ( li_DlIndex , "field_width" )
	ls_PadSide = lds_DLSource.GetItemString( li_DLIndex, "pad_side" )
	lb_Required = Upper ( lds_DLSource.GetItemString ( li_DLIndex , "field_status" ) )= "M"
				
	inv_SapSrv.of_GetValue(ls_FieldName, lds_DLSource , anv_Shipment , astr_transaction , UpperBound ( astr_transaction.istra_distributions ), ls_Value)
	
	// before we pad we are going to need to jump in here and perform
	// any special processing that might be needed.			
	CHOOSE CASE Upper ( ls_FieldName )
			  
		CASE "DOCUMENTAMOUNT"		
				ls_Value = string(Real ( lr_totalAmount ), "0.00")					
		CASE "LINECOUNT"
			ls_Value = String ( 1 , "000" )					
	END CHOOSE
	
	
	CHOOSE CASE Upper ( ls_PadSide )
		CASE "L"
			ls_PaddedValue = lnv_String.of_Padleft ( ls_Value , li_Width  )
		CASE "R"
			ls_PaddedValue = lnv_String.of_PadRight ( ls_Value , li_Width  )
	END CHOOSE
	
	IF lb_Required AND Len ( Trim ( ls_paddedValue ) ) = 0 THEN
		
		ls_ErrorMessage += "Missing a value for required field '" +ls_fieldName + "' on shipment " + String ( ll_ShipmentID )+".~r~n"
		li_Return = -1
	END IF
															
	// we need to make the following check b.c. of_PadLeft will return the entire string if the length of the value
	// is larger than the specified width.
	IF Len ( ls_paddedValue ) > li_Width THEN
		ls_PaddedValue = Left ( ls_PaddedValue , li_Width )
	END IF
	ls_DLLineCust += ls_PaddedValue
NEXT

RETURN ls_DLLineCust
	
end function

on n_cst_acctlink_sap.create
call super::create
end on

on n_cst_acctlink_sap.destroy
call super::destroy
end on

event constructor;call super::constructor;inv_SapSrv = CREATE n_cst_batchsrv_sap
end event

event destructor;call super::destructor;DESTROY ( inv_sapsrv )
end event

