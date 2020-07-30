$PBExportHeader$n_cst_edi_transaction_204.sru
forward
global type n_cst_edi_transaction_204 from n_cst_edi_transaction
end type
end forward

global type n_cst_edi_transaction_204 from n_cst_edi_transaction
integer ii_transactionset = 1
end type
global n_cst_edi_transaction_204 n_cst_edi_transaction_204

type variables
Constant	string	cs_FieldDelimiter = "*"
Constant String	cs_NewShipmentDelimiter = "ST"
Constant String 	cs_InterchangeHeader = "ISA"
Constant String 	cs_FunctionalGroupHeader = "GS"
Constant String 	cs_TransactionSetHeader = "ST"
Constant String 	cs_BeginingShipmentInformation = "B2"
Constant String 	cs_SetPurpose = "B2A"
Constant String 	cs_ReferenceNumber = "L11"
Constant String 	cs_InterlineInformation = "MS3"
Constant String 	cs_BOLHandlingRequirements = "AT5"
Constant String 	cs_Notes = "NTE"
Constant String 	cs_Name = "N1"
Constant String 	cs_Contact = "G61"
Constant String 	cs_AddressInfo = "N3"
Constant String 	cs_GeographicLocation = "N4"
Constant String 	cs_Date = "G62"
Constant String 	cs_TotalWeightAndCharges = "L3"
Constant String	cs_Description = "L5"
Constant String	cs_FreightRate = "F58"
Constant String	cs_CustomText = "CST"

Constant String	cs_StopOff = "S5"
Constant String	cs_OrderIDDetail = "OID"
Constant String	cs_EquipmentDetail = "N7"
Constant String	cs_AdditionalNameInfo = "N2"
Constant String	cs_TransactionTrailer = "N7"


Constant String	cs_StopType_CompleteLoad = "CL"
Constant String	cs_StopType_CompleteUnload = "CU"
Constant String	cs_StopType_PartialLoad = "PL"
Constant String	cs_StopType_PartialUnload = "SE"

Constant String	cs_Real204 = "R204"

boolean	ib_Real204 = TRUE

String	isa_Records[]
Long	il_CurrentRecord

n_cst_edi_204_record    inva_Records[]


n_ds	ids_outbound204cache		//gets set in of_setCache(  )
Long	ila_currentIDS[]
///n_cst_edisegment			inva_Segments[]  I don't know what this was doing here.




end variables

forward prototypes
public function integer of_importfile (string as_filename)
private function integer of_processsinglerecord (readonly string asa_record[])
private function integer of_parsereferencenumber (string asa_record[])
private function integer of_processrecords ()
public function integer of_parsename (string asa_record[])
public function integer of_getrecord (long al_Index, ref string asa_Record[])
private function long of_incrementindex ()
private function integer of_parsenotes (string asa_record[])
public function integer of_parsedate (string asa_record[])
private function integer of_parsetotalweightandcharges (string asa_record[])
private function integer of_parsedescription (string asa_record[])
public function n_cst_edi_204_record of_getcurrentrecord ()
private function integer of_parsestopoffs (string asa_record[])
public function long of_getrecords (ref n_cst_edi_204_Record asa_Records[])
private function long of_cleanup ()
private function integer of_determinestops ()
public function string of_getspentfilelocation ()
public function string of_getimportfilepath ()
public function integer of_writeerrorlog (string as_additionalmessage)
public function integer of_writeerrorlog ()
public function string of_getlogpath ()
private function integer of_parseshiptransinfo (string asa_record[])
private function integer of_parseequipmentdetails (string asa_record[])
private function integer of_setreal204 (string asa_Record[])
private function integer of_parsesetpurpose (string asa_Record[])
public function integer of_parsefreightrate (readonly string asa_Record[])
private function integer of_parsecustomtext (string asa_Record[])
public function integer of_sendforcompany (long al_coid)
public subroutine of_sendtransaction (long ala_id[])
public function datastore of_getoutboundprofile (long al_coid)
public function integer of_setcache (datastore ads_cache)
public function integer of_addedientry (long al_sourceid, string as_messagesource, long al_company, string as_error, string as_inout)
protected function string of_getoutboundmappingfile ()
protected function integer of_getidsfromcache (ref long ala_ids[], string as_columnname)
public function string of_geterrorcontext (long ala_ids[])
end prototypes

public function integer of_importfile (string as_filename);String	ls_FileName
String	ls_FilePath
Long     i
Long		ll_FileHandle = -1
Int		li_Return
String	ls_ReturnedPath

ls_FilePath = as_FileName
THIS.of_CleanUp ( )

IF IsNull ( ls_FilePath ) THEN
	GetFileOpenName ( "Import Shipments", ls_ReturnedPath, ls_filename )
	ls_FilePath = ls_ReturnedPath
END IF

IF Len ( ls_FilePath ) > 0 THEN
	ll_FileHandle = FileOpen ( ls_FilePath )
END IF

IF ll_FileHandle >= 0 THEN
	DO
		i++
	LOOP WHILE ( FileRead ( ll_FileHandle, isa_Records[i] ) > 0 )
END IF

IF UpperBound ( isa_Records ) > 0 THEN
	// process the array of records
	IF THIS.of_ProcessRecords ( ) = 1 THEN
		li_Return = 1
	ELSE
		li_Return = -1
	END IF
END IF


IF ll_FileHandle >= 0 THEN
	FileClose (  ll_FileHandle )
END IF

RETURN li_Return
end function

private function integer of_processsinglerecord (readonly string asa_record[]);Int		li_return = 1
String	lsa_Record[]

lsa_Record = asa_Record

IF UpperBound ( lsa_Record ) > 0 THEN
	
	CHOOSE CASE lsa_Record [ 1 ]
			
		CASE cs_Real204
			THIS.of_SetReal204 ( lsa_Record )
			
		CASE cs_newshipmentdelimiter
			THIS.of_IncrementIndex ( )
			
		CASE cs_InterchangeHeader
			
		CASE cs_OrderIDDetail
			
		CASE cs_FunctionalGroupHeader
			
		CASE cs_TransactionSetHeader
			
		CASE cs_BeginingShipmentInformation
			THIS.of_ParseShipTransInfo ( lsa_Record )
			
		CASE cs_SetPurpose
			THIS.of_ParseSetPurpose ( lsa_Record )
			
		CASE cs_ReferenceNumber
			THIS.of_ParseReferenceNumber ( lsa_Record )
			
		CASE cs_InterlineInformation
			
		CASE cs_BOLHandlingRequirements
			
		CASE cs_Notes
			THIS.of_ParseNotes ( lsa_Record )
			
		CASE cs_Name
			THIS.of_ParseName ( lsa_Record )
			
		CASE cs_Contact
			
		CASE cs_AddressInfo
			
		CASE cs_GeographicLocation
			
		CASE cs_date
			THIS.of_ParseDate ( lsa_Record )
			
		CASE cs_totalweightandcharges
			THIS.of_ParseTotalWeightAndCharges ( lsa_Record )
			
		CASE cs_Description
			THIS.of_ParseDescription ( lsa_Record )
		
		CASE cs_StopOff
			THIS.of_ParseStopOffs ( lsa_Record )
			
		CASE cs_EquipmentDetail
			THIS.of_ParseEquipmentDetails ( lsa_Record )
			
		CASE cs_FreightRate
			THIS.of_ParseFreightRate ( lsa_Record )
			
		CASE cs_CustomText
			THIS.of_ParseCustomText ( lsa_Record )
	
	END CHOOSE
END IF


Return li_Return





end function

private function integer of_parsereferencenumber (string asa_record[]);String	ls_ReferenceID
String	ls_ReferenceIDQualifier
Int		li_Count
Int		i

li_Count = UpperBound ( asa_record )

FOR i = 2 TO li_Count
	CHOOSE CASE i 
			
		CASE 2 
			ls_ReferenceID = Trim ( asa_Record [ i ] )
			
		CASE 3
			ls_ReferenceIDQualifier = Trim ( asa_record[i] )
			
	END CHOOSE
	
NEXT

THIS.of_GetCurrentRecord ().of_SetReference (  ls_ReferenceID ,ls_ReferenceIDQualifier )


return 1
end function

private function integer of_processrecords ();Int		li_Return = 1
Int		li_RecordCount
Int		i
Int		li_ProcessRtn
String	lsa_Empty[]
String	lsa_ParsedRecord[]

n_cst_String	lnv_String
n_cst_edishipment_manager	lnv_ShipmentManager
//lnv_ShipmentManager = CREATE n_cst_edishipment_manager

li_RecordCount = UpperBound ( isa_Records[] )

FOR i = 1 TO li_RecordCount
	lsa_ParsedRecord = lsa_Empty
	lnv_String.of_ParseToArray ( isa_Records[i] , THIS.cs_FieldDelimiter , lsa_ParsedRecord ) 
	li_ProcessRtn = THIS.of_ProcessSingleRecord ( lsa_ParsedRecord )
	IF li_ProcessRtn = 0 THEN
		
		// I am commenting this because I cannot uderstand what hte heck is going on... THIS.of_ProcessSingleRecord ( lsa_ParsedRecord )
		// will never return 0, therfore it would not come in here. and besides, if it did, the of_process204request would not be able to do anything ?????
		
		
//		// the last record processed was the trailer, so process the segments and then clean up and
//		// go again
//		
//		IF lnv_ShipmentManager.of_process204request( inva_Segments  ) <> 1 THEN
//		//	lnv_ShipmentManager.of_ShowErrorMessages ( ) 
//		ELSE
//		END IF
//		THIS.of_Cleanup( )
//			
	ELSEIF li_ProcessRtn = -1 THEN
		li_Return = -1
		EXIT
	END IF
	
	
NEXT



//DESTROY ( lnv_ShipmentManager )
THIS.of_DetermineStops ( )


RETURN li_Return

end function

public function integer of_parsename (string asa_record[]);String	ls_name
String	ls_Qualifier

Int		li_Count
Int		i

li_Count = UpperBound ( asa_record )

FOR i = 2 TO li_Count
	CHOOSE CASE i 
			
		CASE 2 
			ls_Qualifier = Trim ( asa_Record [ i ] )
			
		CASE 3
			ls_name = Trim ( asa_record[i] )
			
	END CHOOSE
	
NEXT

THIS.of_GetCurrentRecord ().of_SetName ( ls_name , ls_Qualifier )


return 1



return -1

end function

public function integer of_getrecord (long al_Index, ref string asa_Record[]);n_cst_String	lnv_String

IF al_Index <= UpperBound( isa_records ) THEN

	lnv_String.of_ParseToArray ( isa_Records [al_Index] , cs_fielddelimiter , asa_Record )

END IF

RETURN UpperBound ( asa_Record )
end function

private function long of_incrementindex ();n_cst_edi_204_Record	lnv_Record
lnv_Record = CREATE n_cst_edi_204_Record

il_CurrentRecord ++

lnv_Record.of_SetReal204 ( ib_Real204 )

inva_records[ il_CurrentRecord ] = lnv_Record

RETURN il_CurrentRecord

end function

private function integer of_parsenotes (string asa_record[]);String	ls_Note

IF UpperBound (asa_record ) > 2 THEN
	THIS.of_GetCurrentRecord().of_SetNote ( Trim ( asa_record[3] ) , Trim ( asa_record[2] ) )
END IF

RETURN 1
end function

public function integer of_parsedate (string asa_record[]);String	ls_Date
String	ls_Qualifier

Int		li_Count
Int		i

li_Count = UpperBound ( asa_record )

FOR i = 2 TO li_Count
	CHOOSE CASE i 
			
		CASE 2 
			ls_Qualifier = Trim ( asa_Record [ i ] )
			
		CASE 3
			ls_Date = Trim ( asa_record[i] )
			
	END CHOOSE
	
NEXT

THIS.of_GetCurrentRecord ().of_SetDate ( ls_Date , ls_Qualifier )


return 1


end function

private function integer of_parsetotalweightandcharges (string asa_record[]);String	ls_Weight
String	ls_WeightQualifier
String	ls_LadingQuantity
String	ls_Charge
Int		li_Count
Int		i

li_Count = UpperBound ( asa_record )

FOR i = 2 TO li_Count
	CHOOSE CASE i 
			
		CASE 2 
			ls_Weight = Trim ( asa_Record [ i ] )
			
		CASE 3
			ls_WeightQualifier = Trim ( asa_record[i] )
			
		CASE 6
			ls_Charge = Trim ( asa_Record [ i ] )
			
		CASE 12
			ls_LadingQuantity = Trim ( asa_record[i] )
			
	END CHOOSE
	
NEXT

THIS.of_GetCurrentRecord ().of_SetWeight (  ls_Weight ,ls_WeightQualifier )
THIS.of_GetCurrentRecord ().of_SetLadingQuantity ( ls_LadingQuantity )
THIS.of_GetCurrentRecord ().of_SetTotalCharge ( ls_Charge )

return 1

end function

private function integer of_parsedescription (string asa_record[]);String	ls_Description 

Int		li_Count
Int		i

li_Count = UpperBound ( asa_record )

FOR i = 2 TO li_Count
	CHOOSE CASE i 
			
		CASE 3
			ls_Description = Trim ( asa_record[i] )
			
	END CHOOSE
	
NEXT

THIS.of_GetCurrentRecord ().of_SetDescription ( ls_Description )


return 1


end function

public function n_cst_edi_204_record of_getcurrentrecord ();n_cst_edi_204_Record		lnv_currentRecord

lnv_CurrentRecord = inva_records[il_currentrecord]

IF Not isValid ( lnv_CurrentRecord ) THEN
	lnv_CurrentRecord = CREATE n_cst_edi_204_Record
END IF

RETURN lnv_CurrentRecord
end function

private function integer of_parsestopoffs (string asa_record[]);String	ls_Stop
String	ls_Qualifier

Int		li_Count
Int		i

li_Count = UpperBound ( asa_record )

FOR i = 2 TO li_Count
	CHOOSE CASE i 
			
		CASE 2 
			ls_Stop = Trim ( asa_Record [ i ] )
			
		CASE 3
			ls_Qualifier = Trim ( asa_record[i] )
			
	END CHOOSE
	
NEXT

//THIS.of_GetCurrentRecord ().of_addStop ( ls_Qualifier )
THIS.of_GetCurrentRecord ().of_SetStopDetail ( asa_record[] )


return 1





end function

public function long of_getrecords (ref n_cst_edi_204_Record asa_Records[]);asa_Records[] = inva_records[]
RETURN UpperBound ( asa_Records[] )
end function

private function long of_cleanup ();Int	li_Count
Int	i
String	lsa_Empty[]
n_cst_edi_204_record   lnva_Empty[]
li_Count = UpperBound ( inva_records )

FOR i = 1 TO li_Count
	IF IsValid ( inva_records[i] ) THEN
		DESTROY ( inva_records[i] )
	END IF
NEXT
il_currentrecord = 0
inva_records = lnva_Empty
isa_Records[] = lsa_Empty
RETURN 1


end function

private function integer of_determinestops ();Int	li_Count
Int	i

li_Count = Upperbound ( inva_records )


FOR i = 1 TO li_Count
	
	inva_records[i].of_DetermineStops ( )
	
NEXT

RETURN 1
end function

public function string of_getspentfilelocation ();n_cst_Settings	lnv_Settings
Any la_Result

Integer	li_Day

String	ls_Return, &
			ls_Week
			
n_cst_filesrvwin32	lnv_filesrv

SetNull ( ls_Return ) 

IF lnv_Settings.of_GetSetting ( 102 , la_Result ) = 1 THEN
	ls_Return = Trim ( String  (la_Result))

	IF Right ( ls_Return , 1 ) <> "\" THEN
		ls_Return += "\"
	END IF
	
	li_Day = Day ( Today () )
	
	choose case li_Day
		case is < 8
			ls_Week = "week1"
		case is < 16
			ls_Week = "week2"
		case is < 22
			ls_Week = "week3"
		case is < 29
			ls_Week = "week4"
		case is < 32
			ls_Week = "week5"
	end choose
	
	ls_return += String ( Today (), "YYYY" )

	lnv_filesrv = create n_cst_filesrvwin32

	if lnv_filesrv.of_Directoryexists( ls_return ) then
		//on to next folder
	else
		lnv_filesrv.of_createdirectory( ls_return )
	end if
	
	ls_return += "\" + String ( Today (), "MMM" )
	
	if lnv_filesrv.of_Directoryexists( ls_return ) then
		//on to next folder
	else
		lnv_filesrv.of_createdirectory( ls_return )
	end if
		
	ls_return += "\" + ls_Week
	
	if lnv_filesrv.of_Directoryexists( ls_return ) then
		//on to next folder
	else
		lnv_filesrv.of_createdirectory( ls_return )
	end if
	
	destroy lnv_filesrv
	
END IF 


RETURN	ls_Return
end function

public function string of_getimportfilepath ();n_cst_Settings	lnv_Settings
Any la_Result
String	ls_Return

SetNull ( ls_Return ) 
IF lnv_Settings.of_GetSetting ( 101 , la_Result ) = 1 THEN
	ls_Return = Trim ( String  (la_Result))
END IF 

RETURN	ls_Return
end function

public function integer of_writeerrorlog (string as_additionalmessage);Int		li_Count
Int		i
Long		ll_NewRow
String	ls_Message
String	ls_FilePath
String	ls_LogPath
Boolean	lb_Success
Long		ll_ShipmentID

DataStore	lds_Log
lds_Log = CREATE	DataStore
lds_Log.DataObject = "d_shipImportResults"

n_cst_edi_204_Record	lnva_Records[]
li_Count = THIS.of_GetRecords ( lnva_Records ) 


FOR i = 1 TO li_Count
	ll_NewRow = lds_Log.insertRow ( 0 )
	
	ll_ShipmentID = lnva_Records[i].of_GetShipmentID ( )
	lb_Success = lnva_Records[i].of_GetSuccessfulImportFlag ( )
	IF lb_Success THEN
		ls_Message = "Shipment imported successfully"
	ELSE
		ls_Message = lnva_Records[i].of_GetErrorText ( )
	END IF
	
	IF ll_NewRow > 0 THEN
		lds_Log.SetItem ( ll_NewRow , "ShipmentID" , ll_ShipmentID )
		lds_Log.SetItem ( ll_NewRow , "ErrorText" , ls_Message )
	END IF
	

NEXT

IF Len ( as_AdditionalMessage ) > 0 THEN
	ll_NewRow = lds_Log.insertRow ( 0 )
	IF ll_NewRow > 0 THEN
		lds_Log.SetItem ( ll_NewRow , "ErrorText" , as_AdditionalMessage )
	END IF
END IF

IF lds_Log.RowCount ( ) > 0 THEN
	ls_LogPath =  THIS.of_GetLogPath ( )
	IF Len ( Trim ( ls_LogPath ) ) > 0 THEN
		lds_Log.SaveAs ( THIS.of_GetLogPath ( ) , Text! , FALSE ) 
	END IF
END IF


RETURN 1
end function

public function integer of_writeerrorlog ();RETURN THIS.of_WriteErrorLog ( "" )
end function

public function string of_getlogpath ();n_cst_Settings	lnv_Settings
Any la_Result

Integer	li_Day
String	ls_Return, &
			ls_Week

n_cst_filesrvwin32	lnv_filesrv

SetNull ( ls_Return ) 
IF lnv_Settings.of_GetSetting ( 103 , la_Result ) = 1 THEN
	ls_Return = Trim ( String  (la_Result)) 
	
	IF Right ( ls_Return , 1 ) <> "\" THEN
		ls_Return += "\"
	END IF

	li_Day = Day ( Today () )
	
	choose case li_Day
		case is < 8
			ls_Week = "week1"
		case is < 16
			ls_Week = "week2"
		case is < 22
			ls_Week = "week3"
		case is < 29
			ls_Week = "week4"
		case is < 32
			ls_Week = "week5"
	end choose
	
	lnv_filesrv = create n_cst_filesrvwin32
	
	ls_return += String ( Today (), "YYYY" )
	
	if lnv_filesrv.of_Directoryexists( ls_return ) then
		//on to next folder
	else
		lnv_filesrv.of_createdirectory( ls_return )
	end if
	
	ls_return += "\" + String ( Today (), "MMM" )
	
	if lnv_filesrv.of_Directoryexists( ls_return ) then
		//on to next folder
	else
		lnv_filesrv.of_createdirectory( ls_return )
	end if
		
	ls_return += "\" + ls_Week
	
	if lnv_filesrv.of_Directoryexists( ls_return ) then
		//on to next folder
	else
		lnv_filesrv.of_createdirectory( ls_return )
	end if
		
	ls_return += "\" 
	
	ls_Return += String ( TODAY ( ),"MMDD"  ) + String ( Now ( ),"HHMMSS" ) + ".txt"

	destroy lnv_filesrv
	
END IF 

RETURN	ls_Return
end function

private function integer of_parseshiptransinfo (string asa_record[]);String	ls_MOP // method of payment 
String	ls_EDIShipmentId
String	ls_Scac
Int		li_Count
Int		i

li_Count = UpperBound ( asa_record )

FOR i = 2 TO li_Count
	CHOOSE CASE i 
		CASE 3
			ls_Scac = Trim ( asa_record[i] )
		CASE 5 
			ls_EDIShipmentId = Trim ( asa_record[i] )
		CASE 7
			ls_MOP = Trim ( asa_record[i] )
			
	END CHOOSE
	
NEXT

THIS.of_GetCurrentRecord ().of_SetPaymentMethod ( ls_MOP )
THIS.of_GetCurrentRecord ().of_SetEDIShipmentIDNumber ( ls_EDIShipmentId )
THIS.of_GetCurrentRecord ().of_SetShipmentScac ( ls_Scac )

return 1

end function

private function integer of_parseequipmentdetails (string asa_record[]);THIS.of_GetCurrentRecord ( ).of_SetEquipmentDetails ( asa_Record )

RETURN 1
end function

private function integer of_setreal204 (string asa_Record[]);IF UpperBound( asa_Record[] ) > 1 THEN
	IF Upper ( asa_Record[2] ) = "F" THEN
		ib_Real204 = FALSE
	END IF
	
END IF

RETURN 1
		
end function

private function integer of_parsesetpurpose (string asa_Record[]);String	ls_Type
Int		li_Count
Int		i

li_Count = UpperBound ( asa_record )

FOR i = 2 TO li_Count
	CHOOSE CASE i 
			
		CASE 2 
			ls_Type = Trim ( asa_Record [ i ] ) 
			
	END CHOOSE
	
NEXT

THIS.of_GetCurrentRecord ().of_SetOrderType ( ls_Type )



return 1

end function

public function integer of_parsefreightrate (readonly string asa_Record[]);String	ls_Amount
String	ls_Index
Int		li_Count
Int		i

li_Count = UpperBound ( asa_record )

FOR i = 2 TO li_Count
	CHOOSE CASE i 
			
		CASE 2 
			ls_Index = Trim ( asa_Record [ i ] )
			
		CASE 3
			ls_Amount = Trim ( asa_record[i] )
			
	END CHOOSE
NEXT

THIS.of_GetCurrentRecord ().of_SetFreightRate ( ls_Index , ls_Amount )

return 1

end function

private function integer of_parsecustomtext (string asa_Record[]);
IF UpperBound (asa_record ) > 2 THEN
	THIS.of_GetCurrentRecord().of_SetCustomText ( Trim ( asa_record[3] ) , Trim ( asa_record[2] ) )
END IF

RETURN 1
end function

public function integer of_sendforcompany (long al_coid);//created by dan 3-7-05


Int	li_return = 1
Long	ll_max
Long	ll_index
Long	lla_ids[]
Long	lla_blank[]


String	ls_scac

n_ds	lds_coEDIprofile
n_ds	lds_cache
n_cst_AnyArraySrv	lnv_ArraySrv

//this is a copy of d_ediprofile_ds filtered down to this companies settings for 204 outbound.
lds_coEDIprofile = this.of_getOutboundprofile( al_coid )
lds_cache = create n_ds

this.of_setEdicompanyid( al_coid )
IF isValid( lds_coEDIprofile ) THEN

	ll_max = lds_coEDIprofile.rowcount( )	//this should only be 1		
	
	IF ll_max  > 0 THEN
		ls_scac = lds_coEDIprofile.getItemstring( ll_max, "scac" )
	END IF
	IF len( ls_scac ) > 0 THEN
		// uses "d_edi_exportedshipments" in the cache.
		
		IF isValid(	ids_outbound204cache ) THEN
			
			//I filter the cache here to just the companies. when file generation happens in
			//of_sendTransaction, it will add on to this filter.
			
			lds_cache = ids_outbound204cache
			lds_cache.setFilter( "to_scac = '" +ls_scac + "'")
			lds_cache.filter()
			
			
			//it turns out I want to filter the cache...
	
			ll_max = lds_cache.rowcount( )

			
			FOR ll_index = 1 TO ll_max
				lla_ids[ll_index] = lds_cache.getItemNumber( ll_index, "shipid" )
			NEXT		
			
			lnv_ArraySrv.of_getShrinked( lla_ids, true, true )
			IF upperBound( lla_ids ) > 0 THEN
				ila_currentids = lla_blank		//dek 5-23-07 clears out the current ids being stored for the dataobject.
				this.of_sendTransaction( lla_ids[])	
			END IF
		ELSE
			//the cache wasn't valid when we went to send the file
		END IF
	ELSE
		//this company was not set up with a scac so we can't send anything. This is NOT an error.
	END IF

END IF

DESTROY lds_coEDIprofile
RETURN li_RETURn

end function

public subroutine of_sendtransaction (long ala_id[]);/*
	Implemented By dan 3-6-07, The purpose of this function is to take all of the shipment ids passed in
	and create a 204 for the company that they are going to.  It should be the current company in the
	edioutbound 204 cache.  It will write the results to a file...which will then do all the sending and
	validation.
*/

Int	li_inputFile

Long	ll_ediCoid
Long	ll_max
Long	ll_row
Long	ll_rowCount
Long	ll_shipId
Long	ll_count
Long	ll_index, ll_subsize, ll_subIndex, ll_subsetIndex2
Long	lla_idsubset1[], lla_idsubset2[]
String	ls_outboundFolder
String	ls_outputFolder
String	ls_outputFile
String	ls_error
String	ls_templateFile
String	ls_controlnumber
String	lsa_templateArray[]
String	lsa_templateHeader[]
String	lsa_templateFooter[]
String	lsa_results[]
String	lsa_transaction[]
String	lsa_blank[]
String	ls_edi
String	ls_purpose
String	ls_CompanyFilter
String	ls_ExtendedFilter

S_parm	 lstr_parm
n_cst_msg lnv_tagmessage
n_cst_msg lnv_blankMessage



Boolean	lb_error

n_ds		lds_cache
n_cst_sql	lnv_sql


ll_ediCoid = this.of_getEdicompanyid( )  //this is set in the calling function, the coid is the one we are sending to.

IF isValid(	ids_outbound204cache ) THEN
	lds_cache = ids_outbound204cache //this can't be a copy because I need to update it.
	
	//The cache is already filtered down to the senders scac, so we append on the shipment ids that aren't processed
	//to get the  correct rows.
	
	ls_CompanyFilter = lds_cache.describe( "datawindow.table.filter" )
	ls_ExtendedFilter = ls_companyFilter + " AND processed = 0 and shipid " + lnv_sql.of_makeinclause(ala_id)
	
	lds_cache.setFilter( ls_ExtendedFilter )
	lds_cache.filter()

	ll_max = lds_cache.rowcount( )
	IF ll_max > 0 THEN
		ls_outPutfolder = this.of_getOutputfolder( 204, ll_ediCoid, appeon_constant.cs_transaction_OUTBOUND )
		ls_controlnumber = this.of_GetControlNumber()	
		
		if len(trim(ls_outputfolder)) > 0 then
			//ok
		else
			if this.of_getsystemfilepath("EDI204", ls_outputfolder) = 1 then
				//ok
			else
				lb_error = true
				ls_error = "No output folder in company profile or system settings. Message not sent"
			end if
		end if
		
		
			//get the file	
		ls_templatefile = this.of_GetTemplateFile( appeon_constant.cl_transaction_set_204, ll_edicoid, "OUTBOUND" )
			
		//Read template file and load into array
		if FileExists ( ls_templatefile ) then	
			//input file, read
			li_InputFile = FileOpen(ls_templatefile, LineMode!, Read!, Shared!)
			THIS.of_loadtemplateintoarray( li_InputFile , lsa_TemplateArray, lsa_TemplateHeader, lsa_TemplateFooter )
			Fileclose(li_InputFile)
		END IF
		
		
		ll_rowCount = lds_cache.rowCount()
		IF ll_RowCount > 0 THEN
			//loop through all the shipments for this company
			FOR ll_row = 1 TO ll_rowCount
				lb_error = false
				ls_error = ''	
				lsa_transaction = lsa_blank
				lnv_tagmessage = lnv_BlankMessage
				ls_edi = ""
				ls_purpose = lds_cache.getItemString( ll_row, "purpose" )			
				ll_shipid = lds_cache.getItemNumber( ll_row, "shipid" )
	
				CHOOSE CASE ls_purpose
					CASE appeon_constant.cs_gen204Request_original
						ls_purpose = "00"
					CASE appeon_constant.cs_gen204Request_change
						ls_purpose = "04"
					CASE appeon_constant.cs_gen204Request_Cancel
						ls_purpose = "01"
					CASE ELSE
						ls_purpose = ""
				END CHOOSE
	
						
				this.of_LoadShipment(ll_ShipId)
				
				inv_Shipment.of_Setcontextcompany( ll_edicoid ) // this is used to resolve aliases
				
				//Set additional tag values 
				this.of_GetHeaderFooterTags(lnv_TagMessage)
		
				lstr_parm.is_Label = "CONTROLNUMBER"
				lstr_Parm.ia_Value = ls_controlnumber
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
		
				lstr_parm.is_Label = "CONTROLNUMBERNOLEADINGZEROS"
				lstr_Parm.ia_Value = STRING(LONG(ls_controlnumber))
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
		
				lstr_parm.is_Label = "TRANSACTIONCONTROLNUMBER"
				lstr_Parm.ia_Value = string(ll_row, '0000')
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
				
				lstr_parm.is_Label = "PURPOSE"
				lstr_Parm.ia_Value = ls_purpose
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
				
				
				if ll_row = 1 then 
					//start with header
					THIS.of_Processloop( lsa_TemplateHeader , lsa_transaction , lnv_TagMessage , inv_Shipment )
					ll_count = upperbound(lsa_transaction)
					for ll_index = 1 to ll_count
						lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
					next			
				end if
				
				THIS.of_Processloop( lsa_TemplateArray , lsa_transaction , lnv_TagMessage , inv_Shipment )
				//move to the results array
				ll_count = upperbound(lsa_transaction)
				for ll_index = 1 to ll_count
					lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]	//everything in the transaction array is the edi I want to store in the table for the current row.
					ls_edi += lsa_Transaction[ll_index]
				next
				
				lds_cache.setItem( ll_Row , "edi" , ls_edi )
				lds_cache.SetItem ( ll_Row , "processed" , n_cst_bso_edimanager_204.ci_MessageStatus_Processed )
				lds_cache.SetItem( ll_row, "transactionnumber", ll_row )
				lds_cache.SetItem( ll_row, "groupcontrolnumber", integer( ls_controlnumber ) )
				lds_cache.SetItem( ll_row, "processeddate", today() )
				lds_cache.SetItem( ll_row, "processedtime", now() )
			NEXT
		
				
			//processloopelements
			THIS.of_Processloop( lsa_TemplateFooter , lsa_transaction , lnv_TagMessage , inv_Shipment )
			ll_count = upperbound(lsa_transaction)
			for ll_index = 1 to ll_count
				lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
			next			
			
			//create results file
			if len(trim(ls_outputfile)) = 0 then
				if isvalid(lnv_TagMessage) then
					IF lnv_TagMessage.Of_Get_Parm ( "CONTROLNUMBER" , lstr_Parm ) <> 0 THEN
						ls_controlnumber = string(lstr_Parm.ia_Value)
					END IF
				
				end if
				//ls_outputfile = ls_controlnumber + ".txt"
				//if they have a specified schema, this will create  a file name for it
				ls_outputFile = this.of_getEditransactionfilename( inv_Shipment, ls_controlNumber )
				IF isNull( ls_outputFile ) OR ls_outputfile = "" THEN
					ls_outputfile = ls_controlnumber + this.of_GetOutboundfileextension( )
				END IF
			end if
			
			ls_outputfile = ls_outputfolder + "\" + ls_outputfile
			ila_currentids = ala_id[]		//DEK 5-22-07
			
			IF this.of_writeresultstofile( lsa_results, ls_outPutFile) = -2 THEN
				
				//have to reset to pending
				IF ll_rowCount > 1 THEN
					//if more then one shipment left, i must set it to pending so i can try to split the ids and send them again.
					FOR ll_row = 1 TO ll_rowCount
						lds_cache.SetItem ( ll_Row , "processed" , n_cst_bso_edimanager_204.ci_MessageStatus_pending )
					NEXT
				END IF
			
				ll_subSize = upperBound( ala_id ) 
				
				IF ll_subSize = 1 THEN
					//then we exit because we found a bad shipment
					//if there is only 1 left and it failed validation, then i want to set the status to failed for that shipment id.
					IF ll_rowCount = 1 THEN
						lds_cache.SetItem ( ll_Row , "processed" , -1 )
					END IF
				ELSE
					//split the ids and resend for each.
					FOR ll_subIndex = 1 TO ll_subSize		
						IF ll_subIndex <= (ll_subSize/2) THEN
							lla_idSubset1[ll_subIndex] = ala_id[ll_subIndex]
						ELSE
							ll_subsetindex2 = ll_subSize/2		//this will remove the decimal if ll_subsize is an odd number
							lla_idSubset2[ll_subIndex - ll_subsetindex2] = ala_id[ll_subIndex]
						END IF
					NEXT
				END IF
				
				IF upperBound( lla_idSubset1 )  > 0 THEN
					this.of_sendTransaction( lla_idSubset1 )
				END IF
				
				IF upperBound( lla_idSubset2 ) > 0 THEN
					this.of_sendTransaction( lla_idSubset2 )
				END IF
			END IF
		END IF
		/*
			Notice there is not call to updateEdicache here.  It is because this transaction unlike 210 and
			214 has its own table with its own status and such.  These transactions are not stored in the edi
			table.  Only inbound 204s and outbound 210 and 214 are in the edi table.
		*/
	END IF
END IF

//Messagebox("n_cst_ediTransaction 204", "sendtransaction not yet implemented.")







end subroutine

public function datastore of_getoutboundprofile (long al_coid);/*
	THIS function returns a copy of the outbound 204 profile for the specified company id.  It is the
	callers responsibility to destroy this.
*/

n_ds	lds_coEDIprofile
n_ds	lds_cache

//copy the cache into local ds so I can filter it down and not worry about changing the original cache.
lds_cache = this.of_getprofile( )
lds_coEDIprofile = create n_ds
lds_coEDIprofile.dataObject = lds_cache.dataobject

lds_cache.rowscopy( 1, lds_cache.rowCount(), PRIMARY!, lds_coEdiProfile, 9999, PRIMARY!)

lds_coEDIprofile.setFilter( "companyid = "+string(al_coid)+ " and transactionset = 204 and in_out = '"+ appeon_constant.cs_transaction_OUTBOUND +"'"  )
lds_coEDIprofile.filter()

RETURN lds_coEdiProfile
end function

public function integer of_setcache (datastore ads_cache);//implemented by dan 3-6-07 for outbound 204 cache.
ids_outbound204cache = ads_cache
RETURN 1
end function

public function integer of_addedientry (long al_sourceid, string as_messagesource, long al_company, string as_error, string as_inout);/*
	DEK added another parameter to specify inbound or outbound.
*/
Date		ld_Processed
Time		lt_Processed
String	ls_Error

ld_Processed = TODAY ( ) 
lt_Processed = NOW ( )

RETURN THIS.of_Addedientry( 204, as_messagesource , al_sourceid , al_Company, ld_Processed , lt_Processed, as_Error, as_inOut )
end function

protected function string of_getoutboundmappingfile ();Long	ll_RowCount
String	ls_File
Long	ll_CoID

DataStore	lds_Mappings
lds_Mappings = CREATE DataStore
lds_Mappings.DataObject = "d_mappingfiles"
lds_Mappings.SetTransobject ( SQLCA )


ll_CoID = THIS.of_Getedicompanyid( )

IF ll_CoID > 0 THEN

	ll_RowCount = lds_Mappings.Retrieve ( ll_CoID , 204 )
	
	IF ll_RowCount> 0 THEN
		
		ls_File = lds_Mappings.GetItemString ( 1 , "MappingFile" )
		
	END IF

END IF

DESTROY ( lds_Mappings )

RETURN ls_File
end function

protected function integer of_getidsfromcache (ref long ala_ids[], string as_columnname);//DEK 5-22-07

ala_ids = ila_currentids

RETURN upperBound(ala_ids)
end function

public function string of_geterrorcontext (long ala_ids[]);STRING	ls_return

IF upperBound( ala_ids ) > 1 THEN
	setNull(ls_return)
ELSE
	
END IF

RETURN ls_return
end function

on n_cst_edi_transaction_204.create
call super::create
end on

on n_cst_edi_transaction_204.destroy
call super::destroy
end on

event constructor;String	ls_IniSetting
il_currentrecord = 0
ib_Real204 = TRUE
ii_transactionset = 204




end event

event destructor;THIS.of_CleanUp ( )
end event

