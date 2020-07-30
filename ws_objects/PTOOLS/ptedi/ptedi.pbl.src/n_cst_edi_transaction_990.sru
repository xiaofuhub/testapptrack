$PBExportHeader$n_cst_edi_transaction_990.sru
forward
global type n_cst_edi_transaction_990 from n_cst_edi_transaction
end type
end forward

global type n_cst_edi_transaction_990 from n_cst_edi_transaction
end type
global n_cst_edi_transaction_990 n_cst_edi_transaction_990

type variables
protected:		

string	is_GSSegmentrow
string	is_GESegmentrow
n_ds		ids_cache

n_cst_bso_edi_manager inv_990manager

end variables

forward prototypes
protected subroutine of_createfile (string as_templatefile, string as_outputfolder, ref string as_outputfile, any aaa_beo[], n_cst_msg anv_tagmessage)
private function integer of_processloopelements (ref string asa_loopconstruct[], pt_n_cst_beo anv_source, n_cst_msg anv_tagmsg)
protected function integer of_prewriteprocess (ref string asa_results[])
protected function integer of_loadtemplateintoarray (long al_filehandle, ref string asa_templateresults[], ref string asa_templateheader[], ref string asa_templatefooter[])
public subroutine of_sendtransaction (n_ds ads_ship, long ala_shipid[])
protected function string of_getoutboundmappingfile ()
protected function string of_getidcolname ()
public function string of_getremedyobjectstring ()
public function integer of_setmanager (n_cst_bso_edi_manager anv_edimanager)
public function string of_geterrorcontext (long ala_ids[])
public subroutine of_sendtransactionsplitgs (n_ds ads_ship, long ala_shipid[])
public subroutine of_sendtransactionnormal (n_ds ads_ship, long ala_shipid[])
end prototypes

protected subroutine of_createfile (string as_templatefile, string as_outputfolder, ref string as_outputfile, any aaa_beo[], n_cst_msg anv_tagmessage);// not being called

//integer	li_InputFile, &
//			li_OutputFile, &
//			li_fileret
//			
//string	ls_line, &
//			ls_controlnumber, &
//			ls_outputfile, &
//			lsa_line[], &
//			lsa_Blank[], &
//			ls_Value,&
//			ls_modifiedline, &
//			ls_stream
//
//boolean	lb_NoMoreLines, &
//			lb_EDIDirect
//
//s_parm	lstr_Parm
//
//n_cst_bso_ReportManager	lnv_ReportManager
//
//n_cst_setting_edi204version	lnv_204Version
//
//lnv_204Version = CREATE n_cst_setting_edi204version
//
//IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct THEN
//	lb_EDIDirect = true
//ELSE
//	lb_EDIDirect = false
//END IF
//
//lstr_parm.is_Label = "TODAYLONG"
//ls_value = string(today(),"yyyymmdd")
//if isnull(ls_value) then
//	ls_value = ''
//end if
//lstr_Parm.ia_Value = ls_value
//anv_TagMessage.of_Add_Parm ( lstr_Parm )
//
//lstr_parm.is_Label = "TODAY"
//ls_value = string(today(),"yymmdd")
//if isnull(ls_value) then
//	ls_value = ''
//end if
//lstr_Parm.ia_Value = ls_value
//anv_TagMessage.of_Add_Parm ( lstr_Parm )
//
//lstr_parm.is_Label = "NOW"
//ls_value = string(now(),"hhmm")
//if isnull(ls_value) then
//	ls_value = ''
//end if
//lstr_Parm.ia_Value = ls_value
//anv_TagMessage.of_Add_Parm ( lstr_Parm )
//
//lstr_parm.is_Label = "CONTROLNUMBER"
//ls_controlnumber = this.of_GetControlNumber()
//lstr_Parm.ia_Value = ls_controlnumber
//anv_TagMessage.of_Add_Parm ( lstr_Parm )	
//
////set delimiter 
//lnv_ReportManager.of_SetDelimiter('.')
//
//if FileExists ( as_templatefile ) then
//	
//	//output file, create
//
//	if len(trim(as_outputfile)) = 0 then
//		as_outputfile = ls_controlnumber + ".txt"
//	end if
//	
//	ls_outputfile = as_outputfolder + "\" + as_outputfile
//	
//	if lb_EDIDirect then
//		//stream mode
//		li_OutputFile = FileOpen(ls_outputfile, StreamMode!, Write!, LockWrite!, replace!)
//	else
//		//line mode
//		li_OutputFile = FileOpen(ls_outputfile, LineMode!, Write!, LockWrite!, replace!)
//	end if
//	
//	//input file, read
//	li_InputFile = FileOpen(as_templatefile, LineMode!, Read!, Shared!)
//	
//	do until lb_NoMoreLines
//		
//		li_fileRet = FileRead ( li_InputFile, ls_line )
//		
//		choose case li_FileRet
//				
//			case is > 0
//				
//				//process line
//				ls_modifiedline = ''
//				lnv_ReportManager.of_ProcessString(ls_line, ls_modifiedline, anv_TagMessage )
//				
//				if lb_EDIDirect then
//					//stream mode
//					if len (ls_modifiedline) > 0 then
//						ls_stream = ls_stream + ls_modifiedline
//					end if					
//				else
//					//line mode
//					if len (ls_modifiedline) > 0 then
//						FileWrite(li_OutputFile, ls_modifiedline)
//					end if
//				end if
//				
//			case is < 0
//				lb_NoMoreLines = true
//			
//			case 0
//				lb_NoMoreLines = true
//				
//			case else //null
//				lb_NoMoreLines = true
//				
//		end choose
//		
//		
//	loop
//	
//	if lb_EDIDirect then
//		//stream mode
//		if len(ls_stream) > 0 then
//			FileWrite(li_OutputFile, ls_stream)
//		end if
//	end if
//
//	Fileclose(li_InputFile)
//	Fileclose(li_OutputFile)
//	
//end if
//
//DESTROY lnv_204Version
//
//
end subroutine

private function integer of_processloopelements (ref string asa_loopconstruct[], pt_n_cst_beo anv_source, n_cst_msg anv_tagmsg);int		li_SourceCount
Int		i
String	lsa_Result[]
String	ls_Working
String	ls_Modified
int		li_ConstructCount
int		li_ConstructIndex
Int		li_ResultIndex
Int		li_InLoop
Int		li_Return = 1


pt_n_cst_beo	lnv_Beo
n_cst_bso_ReportManager	lnv_ReportManager

li_ConstructCount = UpperBound ( asa_loopconstruct[] )

lnv_Beo = anv_source

	// Process the every element of the construct array
FOR li_ConstructIndex = 1 TO li_ConstructCount
	IF Left ( asa_Loopconstruct[li_ConstructIndex ] , 2 ) = "<+" THEN
		li_InLoop ++
	END IF
	
	IF Left ( asa_Loopconstruct[li_ConstructIndex ] , 2 ) = "<-" THEN
		li_InLoop --
	END IF

	IF li_InLoop = 0 THEN
		ls_Modified = ""
		ls_Working = asa_loopconstruct[li_ConstructIndex]
//		lnv_ReportManager.of_ProcessString(ls_Working, ls_Modified, anv_TagMsg )
		lnv_ReportManager.of_ProcessString( ls_Working , ls_Modified , {lnv_Beo} , anv_TagMsg )
	ELSE
		ls_Modified = asa_loopconstruct[li_ConstructIndex]
	END IF
	li_ResultIndex ++
	lsa_Result [ li_ResultIndex ] = ls_Modified 
NEXT

asa_loopconstruct[] = lsa_Result

RETURN li_Return

end function

protected function integer of_prewriteprocess (ref string asa_results[]);// this is where we can evaluate the results and fill in any 'holes' that 
// were not previously known, like segment count (from loops).
// also if there is any logic that needs to be applied to the results it can be done here.
Int		i
Int		li_TotalCount
li_TotalCount = UpperBound (asa_results[])
FOR i = 1 TO li_TotalCount
	THIS.of_loadsegmentandvalidate( asa_results[i])
NEXT

n_cst_AnyArraySrv	lnv_Array
lnv_Array.of_getshrinked( asa_results, TRUE, FALSE ) // only shrinking nulls NOT dupes




/*  					//\\//\\//\\	NOTE:		\\//\\//\\//

	If any 'pre-write' processing is going to change, or potentialy change the number of 
	segments it should be done BEFORE here since we are counting the segments next.
	
*/


//Int		li_HeaderandFooterCount = 4 // 2 header segments and 2 footer segments
String	ls_ReplaceString
//li_TotalCount = UpperBound (asa_results[])
//ls_ReplaceString = "SE*" + String ( li_TotalCount - li_HeaderandFooterCount) + "*"
//
//
//// when sending an outbound file we need to indicate the number of segments.
//// this is sent in the SE record. We are going to assume that the number of segments can 
//// be calculated by counting the total number of elements in the array and subtracting 
//// the header and footer records.
//
//
////we need to find the SE* record. At this point in the processing it should look
//// like SE** because the <SEGMENTCOUNT> tag should always be included, however in the 
//// case of 214 adn 210 it cannot be resolved so it will be collapsed.
//FOR i = 1 TO  li_TotalCount
//	IF LEFT ( asa_Results[i] , 4  ) = "SE**"THEN 
//		asa_Results[i] = Replace ( asa_Results[i], 1, 4, ls_ReplaceString )
//		EXIT
//	END IF
//NEXT

integer	li_count, &
			li_SegmentCount, &
			li_TransactionCount
//			li_Totalcount, &

Int		li_GSCount
string	lsa_Results[], &
			ls_line

lsa_Results = asa_Results[]
li_Totalcount = upperbound(lsa_Results)

do until UPPER(left(ls_line,2)) = 'GE'
	
	
	
	
	
	li_Count ++
	if li_Count > li_TotalCount then
		EXIT
	else
		ls_line = lsa_Results[li_Count]
	end if
		
	if UPPER(left(ls_line,2)) = 'GE' then
		li_GsCount ++
		if UPPER(left(lsa_Results[li_Count],4)) = "GE**" then
			ls_ReplaceString = "GE*" + String (li_TransactionCount) + "*"
			lsa_Results[li_Count] = Replace ( lsa_Results[li_Count], 1, 4, ls_ReplaceString )
		elseif UPPER(left(lsa_Results[li_Count],5)) = "GE*1*" then
			ls_ReplaceString = "GE*" + String (li_TransactionCount) + "*"
			lsa_Results[li_Count] = Replace ( lsa_Results[li_Count], 1, 5, ls_ReplaceString )
		end if
		
		li_TransactionCount = 0
		//on to next set of transactions

		li_Count ++
		if li_Count > li_TotalCount then
			EXIT
		else
			ls_line = lsa_Results[li_Count]
		end if

		CONTINUE
		
	end if
	
	//find the Beginning of a transaction set
	do until UPPER(left(ls_line,2)) = 'ST'
		li_Count ++
		if li_Count > li_TotalCount then
			EXIT
		else
			ls_line = lsa_Results[li_Count]
		end if
	loop
	
	if li_Count > li_TotalCount then
		//array done
	else
		//now find the end of the transaction set and count the lines
		li_SegmentCount = 0
		do until UPPER(left(ls_line,2)) = 'SE'
			li_SegmentCount ++
			li_Count ++
			if li_Count > li_TotalCount then
				EXIT
			else
				ls_line = lsa_Results[li_Count]
			end if
		loop
	end if
	
	if UPPER(left(ls_line,2)) = 'SE' then
		//add 1 for the SE
		li_SegmentCount ++	
		ls_ReplaceString = "SE*" + String (li_SegmentCount) + "*"
		lsa_Results[li_Count] = Replace ( lsa_Results[li_Count], 1, 4, ls_ReplaceString )
		li_SegmentCount = 0
		li_TransactionCount ++
	end if
		
loop

li_count = upperbound(lsa_Results)
if UPPER(left(lsa_Results[li_Count],5)) = "IEA**" then
	ls_ReplaceString = "IEA*" + String (li_GSCount ) + "*"
	lsa_Results[li_Count] = Replace ( lsa_Results[li_Count], 1, 5, ls_ReplaceString )
END IF

////// I am going to make sure that all of the segments have the terminator set at the end
/////  I am assuming that the terminator can be found at the end of the 1st line

String ls_Term
ls_Term = THIS.of_GetSegmentterminator( lsa_Results )

li_SegmentCount = UpperBound ( lsa_Results )

IF Len ( ls_Term ) > 0 THEN
	FOR i = 1 To li_SegmentCount
		IF Right  ( trim ( lsa_Results[i] ) , 1) <> ls_Term THEN
			lsa_Results[i] = Trim ( lsa_Results[i] ) + ls_Term
		END IF	
	NEXT
END IF

asa_Results = lsa_Results

RETURN 1


end function

protected function integer of_loadtemplateintoarray (long al_filehandle, ref string asa_templateresults[], ref string asa_templateheader[], ref string asa_templatefooter[]);//	modified to seperate the header and trailer rows from the
//	template nwl 1/10/2005

Int	li_FileRet
String	ls_Line
Int	li_TemplateHandle
Int	li_Count
String	lsa_Results[], &
			lsa_header[], &
			lsa_footer[]
			
Boolean	lb_noMoreLines

li_TemplateHandle = al_filehandle

//clear 
is_GSSegmentrow = ''
is_GESegmentrow = ''

//	st = transaction set header
li_FileRet = 0
li_Count = 0
do until UPPER(left(ls_line,2)) = 'GS'
	IF li_FileRet > 0 THEN
		li_Count ++
		lsa_header[li_Count] = ls_Line
	end if
	li_fileRet = FileRead ( li_TemplateHandle, ls_line )
	if UPPER(left(ls_line,2)) = 'GS' then
		is_GSSegmentrow = ls_line
	end if
loop

//transaction set
//DON'T RESET li_FileRet
li_Count = 0
do until UPPER(left(ls_line,2)) = 'GE'
	IF li_FileRet > 0 THEN
		choose case UPPER(left(ls_line,2))
			case 'GS', 'GE'
				//SKIP
			case else
				li_Count ++
				lsa_Results[li_Count] = ls_Line						
		end choose
	end if	
	li_fileRet = FileRead ( li_TemplateHandle, ls_line )
	if UPPER(left(ls_line,2)) = 'GE' then
		is_GESegmentrow = ls_line
	end if

loop

//	se = transaction set trailer
//DON'T RESET li_FileRet
li_Count = 0
do until lb_NoMoreLines
	//get last line this is trailer
	IF li_FileRet > 0 THEN
	ELSE
		lb_noMoreLines = TRUE
	END IF		
	li_fileRet = FileRead ( li_TemplateHandle, ls_line )
loop

li_Count ++
lsa_footer[li_Count] = ls_Line

asa_templateresults[] = lsa_Results
asa_templateheader[] = lsa_header
asa_templatefooter[] = lsa_footer

RETURN 1
end function

public subroutine of_sendtransaction (n_ds ads_ship, long ala_shipid[]);long	ll_rowcount, &
		ll_shipcount, &
		ll_Index
		
Long		lla_shipIds[]
Long		lla_ShipIdOneGS[]
			
STring	ls_scac

String	lsa_scacs[]

boolean	lb_error, &
			lb_wroteheader
			
int 		li_res

n_cst_sql			lnv_Sql
				
datastore	lds_temp						
n_ds			lds_copiedAdsShip
n_ds			lds_shiponeGs

ll_rowcount = ads_ship.rowcount()
ll_shipcount = upperbound(ala_shipid)

li_res = ads_ship.SetSort('importedshipments_senderscode A, importedshipments_GroupControlNumber A, importedshipments_TransactionControlNumber A')
li_res = ads_Ship.sort()

//added by dan 
lds_copiedAdsShip = create n_ds
lds_copiedAdsShip.dataobject = ads_ship.dataobject
lds_copiedAdsShip.setTransobject( SQLCA )

lds_ShipOneGS = create n_Ds
lds_ShipOneGS.dataobject = ads_ship.dataobject
lds_ShipOneGS.setTransObject( SQLCA )

ll_rowCount = ads_ship.rowCount()
IF ll_rowCount > 0 THEN
	ads_ship.RowsCopy ( 1, ll_rowCount, PRIMARY!, lds_copiedAdsShip , 1, PRIMARY!)
END IF
lds_temp = ids_ediCache
ids_edicache = lds_copiedAdsShip


li_res = lds_copiedAdsShip.setFilter( "NOT (ds_id)"+ lnv_sql.of_makeinclause(ala_shipid) )
li_res = lds_copiedAdsShip.filter()

ll_rowCount = lds_copiedAdsShip.rowCount()

li_res = lds_copiedAdsShip.RowsDiscard (1, ll_rowCOunt, PRIMARY! ) 
li_res = lds_copiedAdsShip.setFilter("")
li_res = lds_copiedAdsShip.filter()
li_res = lds_copiedAdsShip.sort()

ll_rowCount = lds_copiedAdsShip.rowCount()

//get all the company ids
FOR ll_index = ll_rowCount TO 1 STEP -1
	ls_SCAC =  lds_copiedAdsShip.object.importedshipments_senderscode[ll_index]

	//Added OOCL to create separate 990s for each GS
	IF ls_scac = "MAEU" OR ls_scac = "OOCLIES" THEN
		//these ones will be processed so that a file will only contain one GS loop.
		//These are not handled in this function, they are handled by of_sendTransactionSplitGS()
//		lla_shipIdOneGS[upperBound( lla_shipIdOneGS )+ 1] = this.of_Getcompanyid( ls_scac )
//		lla_shipIdOneGS[upperBound( lla_shipIdOneGs )+ 1] = lds_copiedAdsShip.getItemNumber( ll_index, "ds_id" )
		lds_copiedAdsShip.RowsCopy ( ll_index, ll_index, PRIMARY!, lds_ShipOneGS , 1, PRIMARY!)
		lds_copiedAdsShip.rowsdiscard( ll_index, ll_index, PRIMARY!)
	ELSE
		//these ones are handled normally within this script.
//		lla_coIds[upperBound( lla_coIds )+ 1] = this.of_Getcompanyid( ls_scac )
		//lsa_scacs[ll_index] = ls_scac
	END IF
NEXT

IF lds_copiedAdsShip.rowCount() > 0 THEN
	this.of_sendtransactionnormal( lds_copiedAdsShip, ala_shipId )
END IF

IF lds_shiponeGs.rowcount( ) > 0 THEN
	this.of_sendtransactionsplitgs( lds_shipOneGs,  ala_shipID )
END IF

DESTROY lds_ShipOneGs
DESTROY lds_copiedAdsShip
end subroutine

protected function string of_getoutboundmappingfile ();//  I pulled a DAN and copied from the 210 of_getoutboundmappingfile  SAT  4/12/06
//  I needed to have an outbound rules file for 990 to be able to adjust the N7 segment when 
//  Maersk sends an export order without a container number.  We create a UNK1-tmp# piece
//  of equipment.  Maersk wants an N7 segment with a 0 for the number and the ISO code returned
//  on the 990.


Long		ll_RowCount
String	ls_File
Long		ll_CoID

DataStore	lds_Mappings
lds_Mappings = CREATE DataStore

lds_Mappings.DataObject = "d_mappingfiles"
lds_Mappings.SetTransobject ( SQLCA )

ll_CoID = THIS.of_GetEdicompanyid( )

IF ll_CoID > 0 THEN
	ll_RowCount = lds_Mappings.Retrieve ( ll_CoID , 990 )  // Changed to 990 SAT
	
	IF ll_RowCount> 0 THEN
		
		ls_File = lds_Mappings.GetItemString ( 1 , "MappingFile" )
		
	END IF
END IF

DESTROY ( lds_Mappings )

RETURN ls_File
end function

protected function string of_getidcolname ();//i believe the dataobject is d_edishipmentReview which is set on n_cst_edishipmentReview
return "ds_id"
end function

public function string of_getremedyobjectstring ();//implemented by dan
return "n_cst_errorremedy_edi_990"
end function

public function integer of_setmanager (n_cst_bso_edi_manager anv_edimanager);//created by dan 5-18-06
//this is here because when the 990 gets run through the scheduler, it needs to update
//the status to processed.  This function might beable to go on the ancestor when we redo edi.
//I was trying to copy the 322, but what i didn't realize was that the 322 is using the 
//same cache to send the transactions and it gets its cache from the edimanager_322.  Since
//the 990 uses a different cache to generate its 990s, i couldn't just  update the row
//in senttransaction like the 322 does.  Instead i need a function on the edimanager_990 that
//will take the shipment id to update with a specified message status.  

inv_990manager = anv_edimanager
return 1
end function

public function string of_geterrorcontext (long ala_ids[]);STRing 	ls_return
Long		ll_max
Long		ll_index

ls_return=  String(Today(), "m/d/yy hh:mm")+"~r~nCould not send EDI file. Fix errors and resend. "
ls_return += "~r~nClick 'Troubleshoot' to attempt to resend failed 990's for related shipments.~r~nDouble check shipment data before resending.~r~n"

ll_max = upperBOund(ala_ids)
FOR ll_index = 1 TO ll_max
	IF ll_index = 1 THEN
		ls_return += "    Relevent Shipment ids: "+ string( ala_ids[ll_index] )
	ELSE
		ls_return += " "+ string( ala_ids[ll_index] )
	END IF
NEXT

RETURN ls_return
end function

public subroutine of_sendtransactionsplitgs (n_ds ads_ship, long ala_shipid[]);//ads_ship should only contain shipments for companies who will have their
//files contain only one GS loop.  Same goes ala_shipid

Integer	li_InputFile

long		ll_row, &
			ll_rowcount, &
			ll_ediid, &
			ll_coid, &
			ll_shipid, &
			ll_shipcount, &
			ll_Index, &
			ll_Count, &
			ll_companyCount
			
Long		lla_coIds[]
Long 		ll_index2
Long		ll_GroupIndex
Long		ll_groupCount
			
string	ls_outputfolder, &
			ls_outputfile, &
			ls_templatefile, &
			ls_text, &
			ls_ControlNumber, &
			ls_GroupControlNumber, &
			lsa_file[], &
			lsa_blank[], &
			ls_value, &
			lsa_value[], &
			ls_error, &
			ls_scac,&
			ls_B104, &
			ls_V91, &
			ls_v98, &
			ls_Filter, &
			lsa_Transaction[], &
			lsa_TemplateArray[], &
			lsa_TemplateHeader[], &
			lsa_TemplateFooter[], &
			lsa_Results[], &
			ls_HoldSender, &
			ls_HoldGroup
			
String	lsa_scacs[], lsa_groupControlNumbers[]

boolean	lb_error, &
			lb_changeorder, &
			lb_wroteheader
			
int 		li_res
n_cst_beo_equipment2 lnva_deleteTHISJUNK[]

n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_sql			lnv_Sql
s_parm 				lstr_parm	
n_cst_string		lnv_string
n_cst_msg			lnv_tagmessage, &
						lnv_BlankMessage
						
n_cst_setting_produce990edi	lnv_setting
						
Datastore			lds_temp
n_ds			lds_copiedAdsShip

n_cst_edishipment_manager	lnv_manager

lnv_setting = CREATE n_cst_setting_produce990edi
lnv_Manager = create n_cst_edishipment_manager

ll_rowcount = ads_ship.rowcount()
ll_shipcount = upperbound(ala_shipid)

li_res = ads_ship.SetSort('importedshipments_senderscode A, importedshipments_GroupControlNumber A, importedshipments_TransactionControlNumber A')
li_res = ads_Ship.sort()



n_Cst_beo_Shipment	lnv_Shipment
n_Cst_beo_Shipment	lnva_ships[]
n_cst_bso_Dispatch	lnv_Dispatch
lnv_Dispatch = CREATE n_cst_bso_Dispatch
lnv_Shipment = CREATE n_cst_beo_Shipment

lnv_Dispatch.of_Retrieveshipments( ala_shipid[] )
lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )
lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )


//added by dan 
lds_copiedAdsShip = create n_ds
lds_copiedAdsShip.dataobject = ads_ship.dataobject
lds_copiedAdsShip.setTransobject( SQLCA )

ll_rowCount = ads_ship.rowCount()
IF ll_rowCount > 0 THEN
	ads_ship.RowsCopy ( 1, ll_rowCount, PRIMARY!, lds_copiedAdsShip , 1, PRIMARY!)
	lds_copiedAdsShip.SetSort('importedshipments_senderscode A, importedshipments_GroupControlNumber A, importedshipments_TransactionControlNumber A')
	lds_copiedAdsShip.sort()
END IF
lds_temp = ids_ediCache
ids_edicache = lds_copiedAdsShip


li_res = lds_copiedAdsShip.setFilter( "NOT (ds_id)"+ lnv_sql.of_makeinclause(ala_shipid) )
li_res = lds_copiedAdsShip.filter()

ll_rowCount = lds_copiedAdsShip.rowCount()

li_res = lds_copiedAdsShip.RowsDiscard (1, ll_rowCOunt, PRIMARY! ) 
li_res = lds_copiedAdsShip.setFilter("")
li_res = lds_copiedAdsShip.filter()
li_res = lds_copiedAdsShip.sort()

ll_rowCount = lds_copiedAdsShip.rowCount()

//get all the group control numbers
FOR ll_index = 1 TO ll_rowCount
	lsa_GroupControlNumbers[ll_index] = string(lds_copiedAdsShip.object.importedshipments_GroupControlNumber[ ll_index ])
NEXT
lnv_ArraySrv.of_getshrinked( lsa_GroupControlNumbers, true, true) 

ll_groupCount = upperBound( lsa_groupControlNumbers )


//get all the company ids
FOR ll_index = 1 TO ll_rowCount
	ls_SCAC =  lds_copiedAdsShip.object.importedshipments_senderscode[ll_index]
	lla_coIds[ll_index] = this.of_Getcompanyid( ls_scac )
	
	 lsa_scacs[ll_index] = ls_scac
NEXT

ll_CompanyCount = lnv_ArraySrv.of_getshrinked( lla_coids, true, true) 
li_res = lnv_ArraySrv.of_getshrinked( lsa_scacs, true, true) 
ll_rowCount = lds_copiedAdsShip.rowCount()

FOR ll_groupIndex = 1 TO ll_groupCount
	//for all companies filter the shipments down to that company
	//and write the file
	for ll_Index = 1 TO ll_CompanyCount
		//clear...
		lb_wroteheader = FALSE
		lb_error = false
		ls_error = ''
		lsa_transaction = lsa_blank
		lsa_Results = lsa_blank
		ls_SCAC =  lsa_scacs[ll_index]
		ls_Text = ''
		lsa_file = lsa_blank
		lsa_value = lsa_blank
		ls_outputfile = ''
		ls_holdgroup = ""
		ll_coid = lla_coIds[ll_index]
		lb_changeorder = false
	
		
		THIS.of_Setedicompanyid( ll_coid )
		ls_controlnumber = this.of_GetControlNumber()	
		
		ls_filter = "importedshipments_senderscode = '" + ls_scac +"'" + " AND importedshipments_GroupControlNumber = "+lsa_GroupControlNumbers[ll_groupindex]
		li_res = lds_copiedAdsShip.setfilter(ls_filter)
		li_res = lds_copiedAdsShip.filter()	
		lds_copiedAdsShip.sort()
		
		ll_shipCount = lds_copiedAdsShip.rowCount()
		
		IF ll_shipCount > 0 THEN
		
			ls_outputfolder = this.of_GetOutputFolder( appeon_constant.cl_transaction_set_990, ll_coid, "OUTBOUND" )
			
			if len(trim(ls_outputfolder)) > 0 then
				//ok
			else
				if this.of_getsystemfilepath("EDI990", ls_outputfolder) = 1 then
					//ok
				else
					lb_error = true
					ls_error = "No output folder in company profile or system settings. Message not sent"
				end if
			end if
			
			//get the template file	
			ls_templatefile = this.of_GetTemplateFile( appeon_constant.cl_transaction_set_990, ll_coid, "OUTBOUND" )
				
			//Read template file and load into array this will also return the header and trailer rows
			if FileExists ( ls_templatefile ) then	
				//input file, read
				li_InputFile = FileOpen(ls_templatefile, LineMode!, Read!, Shared!)
				THIS.of_loadtemplateintoarray( li_InputFile , lsa_TemplateArray, lsa_TemplateHeader, lsa_TemplateFooter )
				Fileclose(li_InputFile)
			END IF
		
			//For every shipment that belongs to that company write them to the file
			
			
			//IF ll_shipcount > 0 THEN
			//	ll_HoldGroup = string(lds_copiedAdsShip.object.importedshipments_GroupControlNumber[1])
			//END IF
			
			
			FOR ll_row = 1 TO ll_shipCount
				
				//get the file contents
				lnv_Manager.of_resetSegments()  // clear the old
				ls_Text = lds_copiedAdsShip.object.importedshipments_filecontents[ll_row]
				lnv_String.of_parseToArray( ls_Text , "~r~n" , lsa_File )
				lnv_manager.of_LoadSegments(lsa_File)  // add the new
				lb_changeorder = false
				
				//we only want to write offered shipments to our 990s, if its not offered then
				//skip it.
				IF lnv_manager.of_getsetpurpose( ) <> lnv_manager.cs_SetPurpose_Original THEN
					lb_changeOrder = true
					continue 
				END IF
				
				lsa_file = lsa_blank
				ls_GroupControlNumber = string(lds_copiedAdsShip.object.importedshipments_GroupControlNumber[ ll_row ])
				ll_shipId = lds_copiedAdsShip.getItemNumber( ll_row, "ds_id" )
			
				//8-30-06, I did this because it wasn't ressetting the equipment to the current shipments equipment.
				///        I don't know why of_setSourceId didn't change the equipment with the shipment.
				lnv_Shipment = CREATE n_cst_beo_Shipment
				lnva_ships[ll_row] = lnv_shipment
				lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
				lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )
				lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
				lnv_Shipment.of_SetSourceid( ll_shipid )	
		
				// lnv_Shipment.of_getequipmentlist( lnva_deleteTHISJUNK )
				//lnv_shipment.of_GetLinkedequipment( lnva_deleteTHISJUNK)
				// setup tagmessage
				lnv_tagmessage.of_reset( ) 
				this.of_GetHeaderFooterTags(lnv_TagMessage)
			
				lstr_parm.is_Label = "CONTROLNUMBER"
				lstr_Parm.ia_Value = ls_controlnumber
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
				
				//DEK 5-23-07 NEW TAG
				lstr_parm.is_Label = "CONTROLNUMBERNOLEADINGZEROS"
				lstr_Parm.ia_Value = STRING(LONG(ls_controlnumber))
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
			
				//this is for the isa row
				if not lb_wroteheader then 
					//start with header
					THIS.of_Processloop( lsa_TemplateHeader , lsa_transaction , lnv_TagMessage , lnv_Shipment )
					ll_count = upperbound(lsa_transaction)
					for ll_index2 = 1 to ll_count
						lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
					next		
					lb_wroteheader = true
					
				end if		
				//	end tagmessage setup
			
				/***		Check for a new Group Control Number A file may contain multiple GS with 
								multiple STs within the GS
																					***/
				if ls_GroupControlNumber <> ls_HoldGroup then
					
					if len(ls_holdgroup) = 0 then
						//first time through
					else
						
	//					//new GS 
	//					lstr_parm.is_Label = "GROUPCONTROLNUMBER"
	//					lstr_Parm.ia_Value = ls_HoldGroup
	//					lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	//		
	//					//process GE for last transaction
	//					THIS.of_Processloop( {is_GeSegmentRow} , lsa_transaction , lnv_TagMessage , lnv_Shipment )
	//					ll_count = upperbound(lsa_transaction)
	//					for ll_index2 = 1 to ll_count
	//						lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
	//					next	
	//					
	//					//delete and reinitialize
	//					lnv_tagmessage = lnv_BlankMessage	
	//					this.of_GetHeaderFooterTags(lnv_TagMessage)
	//				
	//					lstr_parm.is_Label = "CONTROLNUMBER"
	//					lstr_Parm.ia_Value = ls_controlnumber
	//					lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
						
					end if
				
					//new GS 
					lstr_parm.is_Label = "GROUPCONTROLNUMBER"
					lstr_Parm.ia_Value = ls_GroupControlNumber
					lnv_TagMessage.of_Add_Parm ( lstr_Parm )
			
					//process GS for new transaction
					THIS.of_Processloop( {is_GSsegmentrow} , lsa_transaction , lnv_TagMessage , lnv_Shipment )
					ll_count = upperbound(lsa_transaction)
					for ll_index2 = 1 to ll_count
						lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
					next		
				
					ls_HoldGroup = ls_GroupControlNumber
				
				else
					
					lstr_parm.is_Label = "GROUPCONTROLNUMBER"
					lstr_Parm.ia_Value = ls_GroupControlNumber
					lnv_TagMessage.of_Add_Parm ( lstr_Parm )
					
				end if
					
				ls_value = lds_copiedAdsShip.object.importedshipments_status[ll_row]
				
				choose case ls_value
					case appeon_constant.cs_Accept
						ls_B104 = 'A'
						ls_V91 = 'ACC'
						ls_v98 = ''//reason
						
					case appeon_constant.cs_Decline
						ls_B104 = 'D'
						ls_V91 = 'DEC'
						ls_v98 = lds_copiedAdsShip.object.importedshipments_statusreason[ll_row]
						if isnull(ls_v98) then
							ls_v98 = ''
						end if
					
					case else
						continue
				end choose
				
				lstr_parm.is_Label = "B104"
				lstr_Parm.ia_Value = ls_B104
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )
				
				lstr_parm.is_Label = "V91"
				lstr_Parm.ia_Value = ls_V91
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )
			
				lstr_parm.is_Label = "V98"
				lstr_Parm.ia_Value = ls_V98
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )
			
//				//get the file contents
//				lnv_Manager.of_resetSegments()  // clear the old
//				ls_Text = lds_copiedAdsShip.object.importedshipments_filecontents[ll_row]
//				lnv_String.of_parseToArray( ls_Text , "~r~n" , lsa_File )
//				lnv_manager.of_LoadSegments(lsa_File)  // add the new
				
				lsa_value = lsa_blank
				if lnv_manager.of_GetElement('B2', 4, lsa_value ) = 1 then
					
					lstr_parm.is_Label = "B2"
					lstr_Parm.ia_Value = lsa_value[upperbound(lsa_value)]
					lnv_TagMessage.of_Add_Parm ( lstr_Parm )
					
				end if
			
				lsa_value = lsa_blank
				if lnv_manager.of_GetElement('L3', 5, lsa_value ) = 1 then
					
					lstr_parm.is_Label = "L3"
					lstr_Parm.ia_Value = lsa_value[upperbound(lsa_value)]
					lnv_TagMessage.of_Add_Parm ( lstr_Parm )
					
				end if
				
				lsa_value = lsa_blank
				if lnv_manager.of_GetElement('ST', 2, lsa_value ) = 1 then
					
					lstr_parm.is_Label = "ST"
					lstr_Parm.ia_Value = lsa_value[upperbound(lsa_value)]
					lnv_TagMessage.of_Add_Parm ( lstr_Parm )
							
					lstr_parm.is_Label = "TRANSACTIONCONTROLNUMBER"
					lstr_Parm.ia_Value = lsa_value[upperbound(lsa_value)]
					lnv_TagMessage.of_Add_Parm ( lstr_Parm )
					
				end if
			
				THIS.of_Processloop( lsa_TemplateArray , lsa_transaction , lnv_TagMessage , lnv_Shipment )
				//move to the results array
				ll_count = upperbound(lsa_transaction)
				for ll_index2 = 1 to ll_count
					lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
				next
				
				this.of_ProcessedEDI(ll_EDIId, ls_error)
			
				IF isValid( inv_990manager )  THEN
					IF lnv_setting.of_GetValue( ) = lnv_Setting.cs_no THEN
						inv_990manager.dynamic of_setmessagestatus( ll_shipid, appeon_constant.ci_MessageStatus_Processed)
					END IF
				END IF
				
			NEXT
			
			//i do this because a file consisting of only change orders will not have a shipment in it
			//so it will not have a header and no edi 990 file should be sent. (look at the line where i continue out of the shipment loop)
			IF lb_wroteheader THEN
				//process GE for last transaction
				THIS.of_Processloop( {is_GeSegmentRow} , lsa_transaction , lnv_TagMessage , lnv_Shipment )
				ll_count = upperbound(lsa_transaction)
				for ll_index2 = 1 to ll_count
					lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
				next		
				
				//process the trailer row
				THIS.of_Processloop( lsa_TemplateFooter , lsa_transaction , lnv_TagMessage , lnv_Shipment )
				ll_count = upperbound(lsa_transaction)
				for ll_index2 = 1 to ll_count
					lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
				next			
				
				
				//create results file
				//ls_outputfile = ls_controlnumber + ".txt"
				
				//gets the edi file name from the schema if it has one otherwise does the old way
				ls_outputFile = this.of_getEditransactionfilename( lnv_Shipment, ls_controlNumber )
				IF isNull( ls_outputFile ) OR ls_outputfile = "" THEN
					ls_outputfile = ls_controlnumber + this.of_GetOutboundfileextension( )
				END IF
				
				ls_outputfile = ls_outputfolder + "\" + ls_outputfile
				
				this.of_writeresultstofile( lsa_Results , ls_outputfile)
			END IF
		END IF
	NEXT		//end company loop
NEXT		//end group loop
ll_shipcount = upperBOund( lnva_ships )
FOR ll_row = 1 TO ll_shipCOunt
	destroy lnva_ships[ll_row]
NEXT

//Destroy ( lnv_Shipment ) 
Destroy ( lnv_Dispatch ) 

destroy lnv_Manager
destroy lds_copiedAdsShip
DESTROY lnv_Setting
end subroutine

public subroutine of_sendtransactionnormal (n_ds ads_ship, long ala_shipid[]);Integer	li_InputFile

long		ll_row, &
			ll_rowcount, &
			ll_ediid, &
			ll_coid, &
			ll_shipid, &
			ll_shipcount, &
			ll_Index, &
			ll_Count, &
			ll_companyCount
			
Long		lla_coIds[]
Long 		ll_index2
			
string	ls_outputfolder, &
			ls_outputfile, &
			ls_templatefile, &
			ls_text, &
			ls_ControlNumber, &
			ls_GroupControlNumber, &
			lsa_file[], &
			lsa_blank[], &
			ls_value, &
			lsa_value[], &
			ls_error, &
			ls_scac,&
			ls_B104, &
			ls_V91, &
			ls_v98, &
			ls_Filter, &
			lsa_Transaction[], &
			lsa_TemplateArray[], &
			lsa_TemplateHeader[], &
			lsa_TemplateFooter[], &
			lsa_Results[], &
			ls_HoldSender, &
			ls_HoldGroup
			
String	lsa_scacs[]

boolean	lb_error, &
			lb_wroteheader
			
int 		li_res


n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_sql			lnv_Sql
s_parm 				lstr_parm	
n_cst_string		lnv_string
n_cst_msg			lnv_tagmessage, &
						lnv_BlankMessage
						
n_cst_setting_produce990edi	lnv_setting
						
datastore	lds_temp						
n_ds			lds_copiedAdsShip
//n_ds			lds_ShipOneGS
//long			lla_shipIdOneGS[]

n_cst_edishipment_manager	lnv_manager

lnv_setting = CREATE n_cst_setting_produce990edi
lnv_Manager = create n_cst_edishipment_manager

ll_rowcount = ads_ship.rowcount()
ll_shipcount = upperbound(ala_shipid)

li_res = ads_ship.SetSort('importedshipments_senderscode A, importedshipments_GroupControlNumber A, importedshipments_TransactionControlNumber A')
li_res = ads_Ship.sort()


n_Cst_beo_Shipment	lnv_Shipment
n_Cst_beo_Shipment	lnva_ships[]
n_cst_bso_Dispatch	lnv_Dispatch
lnv_Dispatch = CREATE n_cst_bso_Dispatch
lnv_Shipment = CREATE n_cst_beo_Shipment

lnv_Dispatch.of_Retrieveshipments( ala_shipid[] )
lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )
lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )


//added by dan 
lds_copiedAdsShip = create n_ds
lds_copiedAdsShip.dataobject = ads_ship.dataobject
lds_copiedAdsShip.setTransobject( SQLCA )


ll_rowCount = ads_ship.rowCount()
IF ll_rowCount > 0 THEN
	ads_ship.RowsCopy ( 1, ll_rowCount, PRIMARY!, lds_copiedAdsShip , 1, PRIMARY!)
	lds_copiedAdsShip.SetSort('importedshipments_senderscode A, importedshipments_GroupControlNumber A, importedshipments_TransactionControlNumber A')
	lds_copiedAdsShip.sort()
END IF
lds_temp = ids_ediCache
ids_edicache = lds_copiedAdsShip


li_res = lds_copiedAdsShip.setFilter( "NOT (ds_id)"+ lnv_sql.of_makeinclause(ala_shipid) )
li_res = lds_copiedAdsShip.filter()

ll_rowCount = lds_copiedAdsShip.rowCount()

li_res = lds_copiedAdsShip.RowsDiscard (1, ll_rowCOunt, PRIMARY! ) 
li_res = lds_copiedAdsShip.setFilter("")
li_res = lds_copiedAdsShip.filter()
li_res = lds_copiedAdsShip.sort()

ll_rowCount = lds_copiedAdsShip.rowCount()

//get all the company ids
FOR ll_index = ll_rowCount TO 1 STEP -1
	ls_SCAC =  lds_copiedAdsShip.object.importedshipments_senderscode[ll_index]
	lla_coIds[upperBound( lla_coIds )+ 1] = this.of_Getcompanyid( ls_scac )
	lsa_scacs[upperBound( lsa_scacs )+ 1] = ls_scac
NEXT

ll_CompanyCount = lnv_ArraySrv.of_getshrinked( lla_coids, true, true) 
li_res = lnv_ArraySrv.of_getshrinked( lsa_scacs, true, true) 
ll_rowCount = lds_copiedAdsShip.rowCount()
	//for all companies filter the shipments down to that company
	//and write the file
	for ll_Index = 1 TO ll_CompanyCount
		//clear...
		lb_wroteheader = FALSE
		lb_error = false
		ls_error = ''
		lsa_transaction = lsa_blank
		lsa_Results = lsa_blank
		ls_SCAC =  lsa_scacs[ll_index]
		ls_Text = ''
		lsa_file = lsa_blank
		lsa_value = lsa_blank
		ls_outputfile = ''
		ls_holdgroup = ""
		ll_coid = lla_coIds[ll_index]
	

		
		THIS.of_Setedicompanyid( ll_coid )
		ls_controlnumber = this.of_GetControlNumber()	
		
		ls_filter = "importedshipments_senderscode = '" + ls_scac +"'"
		li_res = lds_copiedAdsShip.setfilter(ls_filter)
		li_res = lds_copiedAdsShip.filter()	
		lds_copiedAdsShip.sort()
			
		ls_outputfolder = this.of_GetOutputFolder( appeon_constant.cl_transaction_set_990, ll_coid, "OUTBOUND" )
		
		if len(trim(ls_outputfolder)) > 0 then
			//ok
		else
			if this.of_getsystemfilepath("EDI990", ls_outputfolder) = 1 then
				//ok
			else
				lb_error = true
				ls_error = "No output folder in company profile or system settings. Message not sent"
			end if
		end if
		
		//get the template file	
		ls_templatefile = this.of_GetTemplateFile( appeon_constant.cl_transaction_set_990, ll_coid, "OUTBOUND" )
			
		//Read template file and load into array this will also return the header and trailer rows
		if FileExists ( ls_templatefile ) then	
			//input file, read
			li_InputFile = FileOpen(ls_templatefile, LineMode!, Read!, Shared!)
			THIS.of_loadtemplateintoarray( li_InputFile , lsa_TemplateArray, lsa_TemplateHeader, lsa_TemplateFooter )
			Fileclose(li_InputFile)
		END IF
	
		//For every shipment that belongs to that company write them to the file
		ll_shipCount = lds_copiedAdsShip.rowCount()
		
		//IF ll_shipcount > 0 THEN
		//	ll_HoldGroup = string(lds_copiedAdsShip.object.importedshipments_GroupControlNumber[1])
		//END IF
		
		
		FOR ll_row = 1 TO ll_shipCount
			

						//get the file contents
			lnv_Manager.of_resetSegments()  // clear the old
			ls_Text = lds_copiedAdsShip.object.importedshipments_filecontents[ll_row]
			lnv_String.of_parseToArray( ls_Text , "~r~n" , lsa_File )
			lnv_manager.of_LoadSegments(lsa_File)  // add the new
			
			//we only want to write offered shipments to our 990s, if its not offered then
			//skip it.
			IF lnv_manager.of_getsetpurpose( ) <> lnv_manager.cs_SetPurpose_Original THEN
				continue 
			END IF
			
			
			
			lsa_file = lsa_blank
			ls_GroupControlNumber = string(lds_copiedAdsShip.object.importedshipments_GroupControlNumber[ ll_row ])
			ll_shipId = lds_copiedAdsShip.getItemNumber( ll_row, "ds_id" )
		
			//8-30-06, I did this because it wasn't ressetting the equipment to the current shipments equipment.
			///        I don't know why of_setSourceId didn't change the equipment with the shipment.
			lnv_Shipment = CREATE n_cst_beo_Shipment
			lnva_ships[ll_row] = lnv_shipment
			lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
			lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )
			lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
			lnv_Shipment.of_SetSourceid( ll_shipid )	

			// lnv_Shipment.of_getequipmentlist( lnva_deleteTHISJUNK )
			//lnv_shipment.of_GetLinkedequipment( lnva_deleteTHISJUNK)
			// setup tagmessage
			lnv_tagmessage.of_reset( ) 
			this.of_GetHeaderFooterTags(lnv_TagMessage)
		
			lstr_parm.is_Label = "CONTROLNUMBER"
			lstr_Parm.ia_Value = ls_controlnumber
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
			
			//DEK 5-23-07 NEW TAG
			lstr_parm.is_Label = "CONTROLNUMBERNOLEADINGZEROS"
			lstr_Parm.ia_Value = STRING(LONG(ls_controlnumber))
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
		
			//this is for the isa row
			if not lb_wroteheader then 
				//start with header
				THIS.of_Processloop( lsa_TemplateHeader , lsa_transaction , lnv_TagMessage , lnv_Shipment )
				ll_count = upperbound(lsa_transaction)
				for ll_index2 = 1 to ll_count
					lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
				next		
				lb_wroteheader = true
				
			end if		
			//	end tagmessage setup
		
			/***		Check for a new Group Control Number A file may contain multiple GS with 
							multiple STs within the GS
																				***/
			if ls_GroupControlNumber <> ls_HoldGroup then
				
				if len(ls_holdgroup) = 0 then
					//first time through
				else
					
					//new GS 
					lstr_parm.is_Label = "GROUPCONTROLNUMBER"
					lstr_Parm.ia_Value = ls_HoldGroup
					lnv_TagMessage.of_Add_Parm ( lstr_Parm )
		
					//process GE for last transaction
					THIS.of_Processloop( {is_GeSegmentRow} , lsa_transaction , lnv_TagMessage , lnv_Shipment )
					ll_count = upperbound(lsa_transaction)
					for ll_index2 = 1 to ll_count
						lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
					next	
					
					//delete and reinitialize
					lnv_tagmessage = lnv_BlankMessage	
					this.of_GetHeaderFooterTags(lnv_TagMessage)
				
					lstr_parm.is_Label = "CONTROLNUMBER"
					lstr_Parm.ia_Value = ls_controlnumber
					lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
				
				end if
			
				//new GS 
				lstr_parm.is_Label = "GROUPCONTROLNUMBER"
				lstr_Parm.ia_Value = ls_GroupControlNumber
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )
		
				//process GS for new transaction
				THIS.of_Processloop( {is_GSsegmentrow} , lsa_transaction , lnv_TagMessage , lnv_Shipment )
				ll_count = upperbound(lsa_transaction)
				for ll_index2 = 1 to ll_count
					lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
				next		
			
				ls_HoldGroup = ls_GroupControlNumber
			
			else
				
				lstr_parm.is_Label = "GROUPCONTROLNUMBER"
				lstr_Parm.ia_Value = ls_GroupControlNumber
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )
				
			end if
				
			ls_value = lds_copiedAdsShip.object.importedshipments_status[ll_row]
			
			choose case ls_value
				case appeon_constant.cs_Accept
					ls_B104 = 'A'
					ls_V91 = 'ACC'
					ls_v98 = ''//reason
					
				case appeon_constant.cs_Decline
					ls_B104 = 'D'
					ls_V91 = 'DEC'
					ls_v98 = lds_copiedAdsShip.object.importedshipments_statusreason[ll_row]
					if isnull(ls_v98) then
						ls_v98 = ''
					end if
				
				case else
					continue
			end choose
			
			lstr_parm.is_Label = "B104"
			lstr_Parm.ia_Value = ls_B104
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )
			
			lstr_parm.is_Label = "V91"
			lstr_Parm.ia_Value = ls_V91
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )
		
			lstr_parm.is_Label = "V98"
			lstr_Parm.ia_Value = ls_V98
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )
		
			//get the file contents
//			lnv_Manager.of_resetSegments()  // clear the old
//			ls_Text = lds_copiedAdsShip.object.importedshipments_filecontents[ll_row]
//			lnv_String.of_parseToArray( ls_Text , "~r~n" , lsa_File )
//			lnv_manager.of_LoadSegments(lsa_File)  // add the new
			
			lsa_value = lsa_blank
			if lnv_manager.of_GetElement('B2', 4, lsa_value ) = 1 then
				
				lstr_parm.is_Label = "B2"
				lstr_Parm.ia_Value = lsa_value[upperbound(lsa_value)]
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )
				
			end if
		
			lsa_value = lsa_blank
			if lnv_manager.of_GetElement('L3', 5, lsa_value ) = 1 then
				
				lstr_parm.is_Label = "L3"
				lstr_Parm.ia_Value = lsa_value[upperbound(lsa_value)]
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )
				
			end if
			
			lsa_value = lsa_blank
			if lnv_manager.of_GetElement('ST', 2, lsa_value ) = 1 then
				
				lstr_parm.is_Label = "ST"
				lstr_Parm.ia_Value = lsa_value[upperbound(lsa_value)]
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )
						
				lstr_parm.is_Label = "TRANSACTIONCONTROLNUMBER"
				lstr_Parm.ia_Value = lsa_value[upperbound(lsa_value)]
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )
				
			end if
		
			THIS.of_Processloop( lsa_TemplateArray , lsa_transaction , lnv_TagMessage , lnv_Shipment )
			//move to the results array
			ll_count = upperbound(lsa_transaction)
			for ll_index2 = 1 to ll_count
				lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
			next
			
			this.of_ProcessedEDI(ll_EDIId, ls_error)
		
			IF isValid( inv_990manager )  THEN
				IF lnv_setting.of_GetValue( ) = lnv_Setting.cs_no THEN
					inv_990manager.dynamic of_setmessagestatus( ll_shipid, appeon_constant.ci_MessageStatus_Processed)
				END IF
			END IF
			
		NEXT
		
		
		//i do this because a file consisting of only change orders will not have a shipment in it
		//so it will not have a header and no edi 990 file should be sent. (look at the line where i continue out of the shipment loop)
		IF lb_wroteheader THEN
			//process GE for last transaction
			THIS.of_Processloop( {is_GeSegmentRow} , lsa_transaction , lnv_TagMessage , lnv_Shipment )
			ll_count = upperbound(lsa_transaction)
			for ll_index2 = 1 to ll_count
				lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
			next		
			
			//process the trailer row
			THIS.of_Processloop( lsa_TemplateFooter , lsa_transaction , lnv_TagMessage , lnv_Shipment )
			ll_count = upperbound(lsa_transaction)
			for ll_index2 = 1 to ll_count
				lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index2]
			next			
			
			
			//create results file
			//ls_outputfile = ls_controlnumber + ".txt"
			
			//gets the edi file name from the schema if it has one otherwise does the old way
			ls_outputFile = this.of_getEditransactionfilename( lnv_Shipment, ls_controlNumber )
			IF isNull( ls_outputFile ) OR ls_outputfile = "" THEN
				ls_outputfile = ls_controlnumber + this.of_GetOutboundfileextension( )
			END IF
			
			ls_outputfile = ls_outputfolder + "\" + ls_outputfile
			
			this.of_writeresultstofile( lsa_Results , ls_outputfile)
		END IF
	NEXT

ll_shipcount = upperBOund( lnva_ships )
FOR ll_row = 1 TO ll_shipCOunt
	destroy lnva_ships[ll_row]
NEXT

//Destroy ( lnv_Shipment ) 
Destroy ( lnv_Dispatch ) 

destroy lnv_Manager
destroy lds_copiedAdsShip
DESTROY lnv_Setting


end subroutine

on n_cst_edi_transaction_990.create
call super::create
end on

on n_cst_edi_transaction_990.destroy
call super::destroy
end on

event constructor;call super::constructor;ii_transactionset=990
end event

