$PBExportHeader$n_cst_edi_transaction_997.sru
forward
global type n_cst_edi_transaction_997 from n_cst_edi_transaction
end type
end forward

global type n_cst_edi_transaction_997 from n_cst_edi_transaction
end type
global n_cst_edi_transaction_997 n_cst_edi_transaction_997

forward prototypes
protected subroutine of_createfile (string as_templatefile, string as_outputfolder, ref string as_outputfile, any aaa_beo[], n_cst_msg anv_tagmessage)
public subroutine of_sendtransaction (string as_groupcontrol, string asa_transactioncontrol[], long al_coid)
public subroutine of_getresultarray (string as_templatefile, string as_outputfolder, ref string as_outputfile, any aaa_beo[], n_cst_msg anv_tagmessage, ref string asa_result[], ref string asa_controlnumber)
end prototypes

protected subroutine of_createfile (string as_templatefile, string as_outputfolder, ref string as_outputfile, any aaa_beo[], n_cst_msg anv_tagmessage);integer	li_InputFile, &
			li_OutputFile, &
			li_ndx, &
			li_count, &
			li_segmentcount, &
			li_AK2Count
Long 		i			
string	ls_line, &
			lsa_line[], &			
			ls_controlnumber, &
			ls_outputfile, &
			ls_Value, &
			ls_modifiedline, &
			lsa_transactionnumber[], &
			ls_stream, &
			ls_ReplaceString

			
String	lsa_Template[]	
Long		ll_TemplateLineCount

String	ls_Ak5Line
Boolean	lb_StreamMode
boolean	lb_NoMoreLines
			

s_parm 		lstr_parm	
n_cst_msg	lnv_tagmessage, &
				lnv_BlankMessage

n_cst_bso_ReportManager	lnv_ReportManager


String	ls_Format
THIS.of_GetFileformat( ls_Format )
IF ls_Format = "STREAM!" THEN
	lb_StreamMode = TRUE 
END IF

lstr_parm.is_Label = "TODAYLONG"
ls_value = string(today(),"yyyymmdd")
if isnull(ls_value) then
	ls_value = ''
end if
lstr_Parm.ia_Value = ls_value
anv_TagMessage.of_Add_Parm ( lstr_Parm )

lstr_parm.is_Label = "TODAY"
ls_value = string(today(),"yymmdd")
if isnull(ls_value) then
	ls_value = ''
end if
lstr_Parm.ia_Value = ls_value
anv_TagMessage.of_Add_Parm ( lstr_Parm )

lstr_parm.is_Label = "NOW"
ls_value = string(now(),"hhmm")
if isnull(ls_value) then
	ls_value = ''
end if
lstr_Parm.ia_Value = ls_value
anv_TagMessage.of_Add_Parm ( lstr_Parm )

lstr_parm.is_Label = "CONTROLNUMBER"
ls_controlnumber = this.of_GetControlNumber()
lstr_Parm.ia_Value = ls_controlnumber
anv_TagMessage.of_Add_Parm ( lstr_Parm )	

//set delimiter 
lnv_ReportManager.of_SetDelimiter('.')

if FileExists ( as_templatefile ) then
	
	//output file, create

	if len(trim(as_outputfile)) = 0 then
		//as_outputfile = ls_controlnumber + ".txt"
		as_outputfile = ls_controlnumber + THIS.of_Getoutboundfileextension( )
	end if
	
	ls_outputfile = as_outputfolder + "\" + as_outputfile
	
	if lb_StreamMode then
		//stream mode
		li_OutputFile = FileOpen(ls_outputfile, StreamMode!, Write!, LockWrite!, replace!)
	else
		//line mode
		li_OutputFile = FileOpen(ls_outputfile, LineMode!, Write!, LockWrite!, replace!)
	end if
	
	//input file, read
	li_InputFile = FileOpen(as_templatefile, LineMode!, Read!, Shared!)
	
	
	do until lb_NoMoreLines
		
		choose case FileRead ( li_InputFile, ls_line )
				
			case is > 0
								
				choose case left (ls_line, 3)
					case 'AK5'
						 
						lnv_ReportManager.of_ProcessString(ls_line, ls_Ak5Line, lnv_TagMessage )
						// we will stick this into ls_Ak5Line for reference later in the construction of the AK2 loop
						
					CASE ELSE
					// save it
					ll_TemplateLineCount ++
					lsa_Template[ll_TemplateLineCount] = ls_Line
				
				
				END CHOOSE
			
			case else //null
				lb_NoMoreLines = true
				
		end choose		
	loop	
	
	FileClose ( li_InputFile )
		
	FOR i = 1 TO ll_TemplateLineCount
		
		ls_Line = lsa_Template[i]
		
		choose case left (ls_line, 3)
				
			case 'AK2'
				
				//loop
				IF anv_TagMessage.of_Get_Parm ( "204TRANSACTIONNUMBER" , lstr_Parm ) <> 0 THEN
					lsa_transactionnumber = lstr_Parm.ia_Value 
					li_count = upperbound(lsa_TransactionNumber)
					for li_ndx = 1 to li_count
						
						li_segmentcount ++
						li_AK2Count ++
						
						lnv_tagmessage = lnv_BlankMessage
	
						lstr_parm.is_Label = "204TRANSACTIONNUMBER"
						lstr_Parm.ia_Value = lsa_TransactionNumber[li_ndx]
						lnv_TagMessage.of_Add_Parm ( lstr_Parm )
						
						ls_modifiedline = ''
						lnv_ReportManager.of_ProcessString(ls_line, ls_modifiedline, lnv_TagMessage )
						
						if lb_StreamMode then
							//stream mode
							if len (ls_modifiedline) > 0 then
								ls_stream = ls_stream + ls_modifiedline
							end if					
						else
							//line mode
							if len (ls_modifiedline) > 0 then
								FileWrite(li_OutputFile, ls_modifiedline)
							end if
						end if
						
						IF Len ( ls_Ak5Line ) = 0 THEN  // only if we didn't get one from the template will we hardcode it.
							ls_Ak5Line = "AK5*A~~"
						END IF	
						
						li_segmentcount ++
						// write the needed AK5 line out
						if lb_StreamMode then
							//stream mode								
							ls_stream = ls_stream + ls_Ak5Line									
						else
							//line mode									
							FileWrite(li_OutputFile, ls_Ak5Line)									
						end if
						
					
					next
				END IF
	
			case 'AK9'
				//modify counts for the AK2s
	//						'AK9*A*1*1*1~'
				li_segmentcount ++
				lstr_parm.is_Label = "SETCOUNT"
				lstr_Parm.ia_Value = string(li_AK2Count)
				anv_TagMessage.of_Add_Parm ( lstr_Parm )	
										
				//process line
				ls_modifiedline = ''
				lnv_ReportManager.of_ProcessString(ls_line, ls_modifiedline, anv_TagMessage )
				
				if lb_StreamMode then
					//stream mode
					if len (ls_modifiedline) > 0 then
						ls_stream = ls_stream + ls_modifiedline
					end if					
				else
					//line mode
					if len (ls_modifiedline) > 0 then
						FileWrite(li_OutputFile, ls_modifiedline)
					end if
				end if
	
			case 'SE*'				
				
				li_segmentcount ++
							
				lstr_parm.is_Label = "SEGMENTCOUNT"
				lstr_Parm.ia_Value = string(li_segmentcount)
				anv_TagMessage.of_Add_Parm ( lstr_Parm )		
				
				//process line
				ls_modifiedline = ''
				lnv_ReportManager.of_ProcessString(ls_line, ls_modifiedline, anv_TagMessage )
				
				if lb_StreamMode then
					//stream mode
					if len (ls_modifiedline) > 0 then
						ls_stream = ls_stream + ls_modifiedline
					end if					
				else
					//line mode
					if len (ls_modifiedline) > 0 then
						FileWrite(li_OutputFile, ls_modifiedline)
					end if
				end if
				
			case else
				
				choose case left (ls_line, 3)
					case 'ISA', 'GE*' , "GS*", "IEA"
						//don't count
					case else
						li_segmentcount ++
				end choose
				//process line
				ls_modifiedline = ''
				lnv_ReportManager.of_ProcessString(ls_line, ls_modifiedline, anv_TagMessage )
				
				if lb_StreamMode then
					//stream mode
					if len (ls_modifiedline) > 0 then
						ls_stream = ls_stream + ls_modifiedline
					end if					
				else
					//line mode
					if len (ls_modifiedline) > 0 then
						FileWrite(li_OutputFile, ls_modifiedline)
					end if
				end if
	
		end choose
	
	NEXT

	if lb_StreamMode then
		//stream mode
		if len(ls_stream) > 0 then
			FileWrite(li_OutputFile, ls_stream)
		end if
	end if

	Fileclose(li_OutputFile)
	
	if filelength(ls_outputfile) > 0 then
		//file write ok
	else
		filedelete(ls_outputfile)
	end if
	
end if


end subroutine

public subroutine of_sendtransaction (string as_groupcontrol, string asa_transactioncontrol[], long al_coid);
// old working code before dan tampered with it on 1-19-2006

long		ll_ediid
			
string	ls_outputfolder, &
			ls_outputfile, &
			ls_templatefile, &
			ls_value, &
			ls_error, &
			ls_scac

boolean	lb_error
String	lsa_results[]
String	ls_controlNumber
Long		ll_controlnum

n_cst_sql	lnv_Sql
s_parm 		lstr_parm	
n_cst_msg	lnv_tagmessage, &
				lnv_BlankMessage

lb_error = false
 ls_error = ''
ls_outputfile = ''

li_edicoid = al_coid

if al_coid > 0 then
	ls_outputfolder = this.of_GetOutputFolder( appeon_constant.cl_transaction_set_997, al_coid, "OUTBOUND" )
	
	if len(trim(ls_outputfolder)) > 0 then
		//ok
	else
		if this.of_getsystemfilepath("EDI997", ls_outputfolder) = 1 then
			//ok
		else
			lb_error = true
			ls_error = "No output folder in company profile or system settings. Message not sent"
		end if
	end if
		
	if lb_error then
		//skip
		
	else
					
		//special tags in the msg object for status
		lnv_tagmessage = lnv_BlankMessage
		
		lstr_parm.is_Label = "204CONTROLNUMBER"
		lstr_Parm.ia_Value = as_groupcontrol
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
		lstr_parm.is_Label = "204TRANSACTIONNUMBER"
		lstr_Parm.ia_Value = asa_transactioncontrol
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
		
		
		//get the file
		
		ls_templatefile = this.of_GetTemplateFile( appeon_constant.cl_transaction_set_997, al_coid, "OUTBOUND" )
		
		
		//Replaced by dan 1-19-2006, to return a result array rather than creating a file
		//the function is pretty much a stripped down version of of_createfile for 997's that
		//instead of writing to file in line mode, puts the lines into an array instead, and doesn't
		//do any file creation.  So the refererence to ls_outputfile for the time being has no meaning. The creation
		//of the file functionality was taken out and will go after of_getResultArray to make it of_sendTrandsaction
		//look more like the other of_sendtransaction functions for other types of EDI files.
		
		//this.of_Createfile( ls_templatefile, ls_outputfolder, ls_outputfile, {inv_event}, lnv_tagmessage )
		this.of_getResultArray( ls_templatefile, ls_outputfolder, ls_outputfile, {inv_event}, lnv_tagmessage, lsa_results,ls_controlnumber )
		//create results file
		if len(trim(ls_outputfile)) = 0 then
			if isvalid(lnv_TagMessage) then
				IF lnv_TagMessage.Of_Get_Parm ( "CONTROLNUMBER" , lstr_Parm ) <> 0 THEN
		//			ls_controlnumber = string(lstr_Parm.ia_Value)
				ELSE
		//			ls_controlnumber = this.of_GetControlNumber()
				END IF
			
			end if
			//gets the edi file name from the schema if it has one otherwise does the old way
			ls_outputFile = this.of_getEditransactionfilename( inv_Event, ls_controlNumber )
			IF isNull( ls_outputFile ) OR ls_outputfile = "" THEN
				ls_outputfile = ls_controlnumber + this.of_GetOutboundfileextension( )
			END IF
		end if
		
		ls_outputfile = ls_outputfolder + "\" + ls_outputfile
		
		THIS.of_Writeresultstofile( lsa_Results , ls_outputfile )
		//----------------------------------------------------------------------------------
	end if
	
	this.of_ProcessedEDI(ll_EDIId, ls_error)

end if


end subroutine

public subroutine of_getresultarray (string as_templatefile, string as_outputfolder, ref string as_outputfile, any aaa_beo[], n_cst_msg anv_tagmessage, ref string asa_result[], ref string asa_controlnumber);//Written By Dan 1-19-2006 to replace of_createFile and return a result array rather
//than actually creating a file.

integer	li_InputFile, &
			li_OutputFile, &
			li_ndx, &
			li_count, &
			li_segmentcount, &
			li_AK2Count
Long 		i			
string	ls_line, &
			lsa_line[], &			
			ls_controlnumber, &
			ls_outputfile, &
			ls_Value, &
			ls_modifiedline, &
			lsa_transactionnumber[], &
			ls_ReplaceString

			
String	lsa_Template[]	
Long		ll_TemplateLineCount

String	ls_Ak5Line

boolean	lb_NoMoreLines
			

s_parm 		lstr_parm	
n_cst_msg	lnv_tagmessage, &
				lnv_BlankMessage
				
String	lsa_results[]

n_cst_bso_ReportManager	lnv_ReportManager


String	ls_Format



lstr_parm.is_Label = "TODAYLONG"
ls_value = string(today(),"yyyymmdd")
if isnull(ls_value) then
	ls_value = ''
end if
lstr_Parm.ia_Value = ls_value
anv_TagMessage.of_Add_Parm ( lstr_Parm )

lstr_parm.is_Label = "TODAY"
ls_value = string(today(),"yymmdd")
if isnull(ls_value) then
	ls_value = ''
end if
lstr_Parm.ia_Value = ls_value
anv_TagMessage.of_Add_Parm ( lstr_Parm )

lstr_parm.is_Label = "NOW"
ls_value = string(now(),"hhmm")
if isnull(ls_value) then
	ls_value = ''
end if
lstr_Parm.ia_Value = ls_value
anv_TagMessage.of_Add_Parm ( lstr_Parm )

lstr_parm.is_Label = "CONTROLNUMBER"
ls_controlnumber = this.of_GetControlNumber()
lstr_Parm.ia_Value = ls_controlnumber			 	//pass back control number by ref
asa_controlnumber = ls_controlNumber
anv_TagMessage.of_Add_Parm ( lstr_Parm )	

//DEK 5-23-07 NEW TAG
lstr_parm.is_Label = "CONTROLNUMBERNOLEADINGZEROS"
lstr_Parm.ia_Value = STRING(LONG(ls_controlnumber))
lnv_TagMessage.of_Add_Parm ( lstr_Parm )	

//set delimiter 
lnv_ReportManager.of_SetDelimiter('.')

if FileExists ( as_templatefile ) then
	
	//input file, read
	li_InputFile = FileOpen(as_templatefile, LineMode!, Read!, Shared!)
	
	
	do until lb_NoMoreLines
		
		choose case FileRead ( li_InputFile, ls_line )
				
			case is > 0
								
				choose case left (ls_line, 3)
					case 'AK5'
						 
						lnv_ReportManager.of_ProcessString(ls_line, ls_Ak5Line, lnv_TagMessage )
						// we will stick this into ls_Ak5Line for reference later in the construction of the AK2 loop
						
					CASE ELSE
					// save it
					ll_TemplateLineCount ++
					lsa_Template[ll_TemplateLineCount] = ls_Line
				
				
				END CHOOSE
			
			case else //null
				lb_NoMoreLines = true
				
		end choose		
	loop	
	
	FileClose ( li_InputFile )
		
	FOR i = 1 TO ll_TemplateLineCount
		
		ls_Line = lsa_Template[i]
		
		choose case left (ls_line, 3)
				
			case 'AK2'
				
				//loop
				IF anv_TagMessage.of_Get_Parm ( "204TRANSACTIONNUMBER" , lstr_Parm ) <> 0 THEN
					lsa_transactionnumber = lstr_Parm.ia_Value 
					li_count = upperbound(lsa_TransactionNumber)
					for li_ndx = 1 to li_count
						
						li_segmentcount ++
						li_AK2Count ++
						
						lnv_tagmessage = lnv_BlankMessage
	
						lstr_parm.is_Label = "204TRANSACTIONNUMBER"
						lstr_Parm.ia_Value = lsa_TransactionNumber[li_ndx]
						lnv_TagMessage.of_Add_Parm ( lstr_Parm )
						
						ls_modifiedline = ''
						lnv_ReportManager.of_ProcessString(ls_line, ls_modifiedline, lnv_TagMessage )
						
						if len (ls_modifiedline) > 0 then
							lsa_results[upperBound( lsa_results )+ 1] = ls_modifiedLine
						end if

						
						IF Len ( ls_Ak5Line ) = 0 THEN  // only if we didn't get one from the template will we hardcode it.
							ls_Ak5Line = "AK5*A~~"
						END IF	
						
						li_segmentcount ++
						// write the needed AK5 line out
						lsa_results[upperBound( lsa_results )+ 1] = ls_aK5Line //ls_modifiedLine

					next
				END IF
	
			case 'AK9'
				//modify counts for the AK2s
	//						'AK9*A*1*1*1~'
				li_segmentcount ++
				lstr_parm.is_Label = "SETCOUNT"
				lstr_Parm.ia_Value = string(li_AK2Count)
				anv_TagMessage.of_Add_Parm ( lstr_Parm )	
										
				//process line
				ls_modifiedline = ''
				lnv_ReportManager.of_ProcessString(ls_line, ls_modifiedline, anv_TagMessage )
				
				if len (ls_modifiedline) > 0 then
					lsa_results[upperBound( lsa_results )+ 1] = ls_modifiedLine
				end if

			case 'SE*'				

				//process line
				ls_modifiedline = ''
				lnv_ReportManager.of_ProcessString(ls_line, ls_modifiedline, anv_TagMessage )
				
				if len (ls_modifiedline) > 0 then

					lsa_results[upperBound( lsa_results )+ 1] = ls_modifiedLine
				end if

			case else
				
				choose case left (ls_line, 3)
					case 'ISA', 'GE*' , "GS*", "IEA"
						//don't count
					case else
						li_segmentcount ++
				end choose
				//process line
				ls_modifiedline = ''
				lnv_ReportManager.of_ProcessString(ls_line, ls_modifiedline, anv_TagMessage )
				
				if len (ls_modifiedline) > 0 then

					lsa_results[upperBound( lsa_results )+ 1] = ls_modifiedLine
				end if
	
		end choose
	
	NEXT
	
asa_result = lsa_results	
end if


end subroutine

on n_cst_edi_transaction_997.create
call super::create
end on

on n_cst_edi_transaction_997.destroy
call super::destroy
end on

event constructor;call super::constructor;ii_transactionset=997
end event

