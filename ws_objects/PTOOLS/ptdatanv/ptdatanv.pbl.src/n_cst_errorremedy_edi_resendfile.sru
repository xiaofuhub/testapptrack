$PBExportHeader$n_cst_errorremedy_edi_resendfile.sru
forward
global type n_cst_errorremedy_edi_resendfile from n_cst_errorremedy_edi
end type
end forward

global type n_cst_errorremedy_edi_resendfile from n_cst_errorremedy_edi
end type
global n_cst_errorremedy_edi_resendfile n_cst_errorremedy_edi_resendfile

forward prototypes
public function integer of_remedy ()
private function integer of_checkcompanysettings (long al_coid, string as_filepath, integer ai_transactionset, ref string as_errormessage)
private function integer of_getfileformat (ref string as_fileformat, integer ai_transaction)
private function integer of_sendfile (string as_file, integer ai_transactionset, ref string as_errormessage)
end prototypes

public function integer of_remedy ();//attempts to resend the file specified in the 
//First looks at the error log to find out the company its being sent to, and
//the transaction set that is being sent.
//This does all the same checks as though it would use the Freddi object, but it doesn't
//actually use it to do the FTP.(so we don't have to install fredi on the client.)
//It then attempts to send the file.

//It should be noted that the only way this gets created is if they click on trouble shoot.
//This error should only occur because of internet failure...failure to connect to the internet.
//In other words, the file has already been validated, but of_sendFile on the n_cst_editransaction failed.

//IF we fail to resend the file...the file remains where it is. Otherwise it should get moved
//to the done folder.
Int			li_return
Int			li_pos
Int			li_transaction
String		ls_message
String		ls_context
String		ls_file
String		ls_errorMessage

li_return = 1
IF upperBound( ila_sourceids ) > 0 THEN
	ls_message = inv_errorlog.of_getMessage( )
	ls_context = inv_errorLog.of_GetContext( )

	IF pos( ls_context, "210" ) > 0 THEN
		li_transaction = 210
	ELSEIF pos( ls_context, "214" ) > 0 THEN
		li_transaction = 214
	ELSEIF pos( ls_context, "322" ) > 0 THEN
		li_transaction = 322
	ELSEIF pos( ls_context, "990" ) > 0 THEN
		li_transaction = 990
	ELSEIF pos( ls_context, "997" ) > 0 THEN
		li_transaction = 997
	ELSE
		ls_errorMessage = "Unrecognized edi file type.  Couldn't resend the file."
		li_return = -1
	END IF

ELSE
	li_return = -1
END IF

IF li_return = 1 THEN
	//after the word 'File::' there is a file path in the message
	li_pos = pos( ls_message, "File::" )
	IF li_pos > 0 THEN 
		//gets the file path
		ls_file = RIGHT( ls_message, len(ls_message) - (li_pos + 5) )
		IF len(ls_file) > 0 THEN
			IF FILEEXISTS( ls_File ) THEN
				//checks all the samestuff as the validate results file on the edi_transaction, eg, file names exist, and other company ftp settings
				li_Return = this.of_checkcompanysettings( ila_sourceIds[1]/*company id*/, ls_file, li_transaction, ls_errorMessage )
			ELSE
				ls_errorMessage = "The file "+ls_file +" no longer exists at the specified location and could not be sent."
				li_return = - 1
			END IF
		ELSE
			ls_errorMessage = "The length of the file path was 0.  File couldn't be resent."
			li_RETURN = -1
		END IF
	ELSE
		ls_errorMessage = "The file path wasn't found in the message.  File couldn't be resent."
		li_return = -1
	END IF
	
END IF

IF li_return = 1 THEN
	//uses winInet to send the file via FTP
  	li_return = this.of_sendfile( ls_file, li_transaction, ls_errorMessage )
END IF
IF li_return = -1 THEN
	MessageBox("Resend EDI File", ls_errorMessage, exclamation!  )
END IF

IF li_return = 1 THEN
	MessageBox( "Resend EDI File", "Successfully sent EDI file.  It is now safe to delete the error from the error log." )
END IF


RETURN li_return
end function

private function integer of_checkcompanysettings (long al_coid, string as_filepath, integer ai_transactionset, ref string as_errormessage);//OleObject lnv_Interchage
//returns true if the company is set up to send through FTP
Long			ll_index
String		ls_mySefFile
Int			li_Rtn = 1

Long		ll_coid
Long		ll_rows

Datastore	lds_transactionPaths
lds_transactionPaths = Create datastore
lds_transactionPaths.dataobject = "d_ediprofile"
lds_transactionPaths.setTransobject( SQLCA )

ll_coid = al_coid

//DEK 4-17-07, modified to make sure it retrieves the settings for the outbound file.
ll_rows = lds_transactionPaths.retrieve( ll_coid, ai_transactionset, appeon_constant.cs_transaction_OUTBOUND  )

IF ll_rows > 0 THEN
	ls_myseffile = lds_transactionPaths.getItemString( 1, "seffilepath" )
	
	IF len( ls_myseffile ) = 0 THEN
		setnull( ls_mySeffile )
	END IF	

END IF

IF isNULL( ls_mySefFile ) THEN
	as_errorMessage = "There is no SEF file path specified for that company. File cannot be resent."
	RETURN -1				//this is the duplication of old functionality.
END IF

//lnv_ediDocument = CREATE oleObject
IF FileExists( as_filePath ) THEN
	li_rtn = 1
ELSE
	li_rtn = -1
END IF


IF li_Rtn = 1 THEN
	IF FileExists( ls_mySefFile ) THEN
//		lnv_schama = lnv_ediDocument.LoadSchema(ls_mySefFile, 0) 
	ELSE
		as_errorMessage = "The specified SEF file: "+ ls_mysefFile+" does not exist at that location. Couldn't resend file."
		li_rtn = -1
	END IF
END IF	
	
IF li_rtn = 1 THEN

END IF	

Destroy lds_transactionPaths
RETURN li_rtn
end function

private function integer of_getfileformat (ref string as_fileformat, integer ai_transaction);int	li_Return = 1
String	ls_Format
String	ls_inout 

ls_inOut = appeon_constant.cs_transaction_OUTBOUND 

IF ila_sourceids[1] > 0 THEN
  SELECT "ediprofile"."fileformat"  
    INTO :ls_Format  
    FROM "ediprofile"  
   WHERE "ediprofile"."companyid" = :ila_sourceids[1] and
			"ediprofile"."transactionset" = :ai_transaction and
			"ediprofile"."in_out" = :ls_inout;
			
    Commit;
	 
	 IF IsNull ( ls_Format ) OR ls_Format = "" THEN
		li_Return = -1
	ELSE
		as_Fileformat = ls_Format
	END IF
	 
ELSE
	li_Return = -1
END IF


RETURN li_Return
end function

private function integer of_sendfile (string as_file, integer ai_transactionset, ref string as_errormessage);//changed on 1-4-2007
/*
	This function now uses a nonvisual to handle the ftp.  If the ftp succeeds, the function
	moves the file to the correct location.
	
	Returns 1 if it succeeds
			 -1 if it fails
*/

Int	li_Return = 1
Int	li_Res
String	ls_fileFormat
String	ls_donePath
String	ls_name

n_cst_ftp_edi	lnv_ftpTransport
n_cst_bso_ediManager lnv_ediManager

lnv_ediManager = create n_cst_bso_ediManager

IF this.of_getfileformat( ls_fileFOrmat , ai_transactionset ) = 1 THEN
	lnv_ftpTransport = create n_cst_ftp_edi
	li_return = lnv_ftpTransport.of_sendfile( as_file, ai_transactionSet, as_errormessage, ila_sourceids[1], ls_fileFormat)
	DESTROY lnv_ftpTransport
ELSE
	li_return = -1
	as_errormessage = "Couldn't send file, invalid file format."
END IF

IF li_Return =1 THEN
	ls_Name = right( as_file, len( as_file ) - lastpos(as_file,"\") )
	//if it was sent successfully then we want to put the file into its done location
	//which is created if it doesn't exist.
	//FileDelete( as_filePath )

	ls_donePath = left( as_file, Lastpos( as_file, "\" ) - 1 )  //should change 'C:\ediwhatever\filname.txt' to 'C:\ediwhatever done'
	ls_donePath += " done"
	IF not DirectoryExists( ls_donePath ) THEN
		li_res = Createdirectory( ls_donePath )
	ELSE
		li_Res = 1
	END IF
	
	//once the file has been sent we keep a copy of the sent file locally
	IF li_res = 1 THEN
		ls_donePath = lnv_ediManager.of_appendtoprocessedlocationpath( ls_donePath )
		ls_donePath += "\" +ls_Name
		li_res = FileMove( as_file, ls_donePath )
	END IF

END IF

RETURN li_Return
/*
int 	li_return
int	li_res
int	li_Rc
int	li_passiveTransfer
Long	ll_coId
Long	ll_index 

Long	li_mode
Long	ll_port
Long	ll_timeout
Long	lla_sourceIds[]
String	ls_userId
String	ls_password
String	ls_protocol
String	ls_address
String	ls_value
String	ls_targetPath
String	ls_Name
String	ls_columnName
String	ls_remedy
String	ls_fileFormat

String	ls_donePath
Boolean	lb_sendAsCii
Boolean 	lb_putInOutBoundFolder

Long			ll_rows

Boolean		lb_sendByProfitTools
Datastore	lds_transportSettings
Datastore	lds_transactionPaths
n_cst_wininet_ftp        lnv_ftp

n_cst_errorlog			lnv_error
n_cst_errorlog_manager	lnv_errorlogManager
n_cst_bso_ediManager lnv_ediManager


lnv_ftp = create n_cst_wininet_ftp
lnv_ediManager = create n_cst_bso_ediManager
lds_transportSettings = CREATE datastore
lds_transportSettings.dataobject = "d_transportsettings"
lds_transportSettings.setTransobject( SQLCA )

lds_transactionPaths = CREATE datastore
lds_transactionPaths.dataobject = "d_transactionpaths"
lds_transactionPaths.settransobject( SQLCA )

li_return = 1
ll_coId =  ila_sourceids[1] //this.of_getEdicompanyid( )
ls_remedy = "n_cst_errorremedy_edi_resendFile"

ll_index = lds_transportSettings.Retrieve( ll_coId )		//there should be 1 row retrieved
ll_rows = lds_transactionPaths.retrieve( ll_coid )

//if not set up we don't send it
IF ll_index > 0 THEN
	lb_sendByProfitTools = true
ELSE
	as_errorMessage = "The company isn't set up for Profit Tools to handle the transport.  Couldn't send file."
END IF


IF lb_sendByProfitTools THEN
	
	//use the Fredi objects to send the data as specified by settings
	
	li_mode = lds_transportSettings.getItemNumber( ll_index, "mode_text" )
	ll_port = lds_transportSettings.getItemNumber( ll_index, "port" )
	ll_timeout = lds_transportSettings.getItemNumber( ll_index, "timeout" )
	ls_userId = lds_transportSettings.getItemString( ll_index, "userid" )
	ls_password = lds_transportSettings.getItemString( ll_index, "password" )
	ls_protocol = lds_transportSettings.getItemString( ll_index, "protocol" )
	ls_address = lds_transportSettings.getItemString( ll_index, "address" )
	li_passiveTransfer = lds_transportSettings.getItemNumber( ll_index, "passive_transfer" )
	
	FOR ll_index = 1 TO ll_rows 
		IF lds_transactionPaths.getItemNumber( ll_index, "transactionset") = ai_transactionset THEN
			ls_targetPath = lds_transactionPaths.getItemstring( ll_index, "remotepaths" )
			EXIT
		END IF
	NEXT

		
		//send the file, we use a different object to test the connection first because
	//FREDI crashes if we try to send to an invalid path.
	IF li_return = 1 THEN
		li_Rc = lnv_ftp.of_internetautodial( )
		lnv_ftp.event ue_init( )
	
		
		//if connected to the internet try to connect to server
		IF li_rc > -1 THEN 

			//already connected or connects
			IF li_passiveTransfer = 1 THEN
				li_rc = lnv_ftp.of_connect( ls_address, ls_userId, ls_password, ll_port, appeon_constant.InternetConnect_Passive )
			ELSE
				li_rc = lnv_ftp.of_connect( ls_address, ls_userId, ls_password, ll_port )
			END IF
			
			IF li_rc > 0 THEN
				ls_Name = right( as_file, len( as_file ) - lastpos(as_file,"\") )

				IF len( ls_targetPath ) > 0 THEN
					IF lnv_ftp.of_changedirectory( ls_targetPath ) = 1 THEN
						IF this.of_getfileformat( ls_fileFOrmat , ai_transactionset ) = 1 THEN
							lb_sendAsCii = (ls_fileFOrmat <> "STREAM!")
							li_return = lnv_ftp.of_putfile( as_file, ls_name, lb_sendAsCii/*boolean ab_ascii */)
							IF li_return = -1 THEN
								as_errormessage = "Failed 'put' operation of of_sendFile. Couldn't send file."
							END IF
						ELSE
							as_errormessage = "Invalid file format, couldn't resend file."
						END IF
					ELSE
						//directory doesn't exist, we fail to send
						li_return = -1
						lb_putInoutBoundFolder = true
						as_errormessage = "Invalid put location, couldn't send file."
					END IF
				ELSE
					//send to the path that we connected to.
					IF this.of_getfileformat( ls_fileFOrmat , ai_transactionset ) = 1 THEN
						lb_sendAsCii = (ls_fileFOrmat <> "STREAM!")
						li_return = lnv_ftp.of_putfile( as_file, ls_name, lb_sendAsCii/*boolean ab_ascii */)
						IF li_return = -1 THEN
							as_errormessage = "Failed 'put' operation of of_sendFile. Couldn't send file."
						END IF
					END IF
				END IF
			ELSE
				//failed to connect to FTP server
				lb_putInOutBoundFolder = true
				li_return = -1
				as_errorMessage = "Couldn't connect to FTP server, couldn't send file."
			END IF
		ELSE
			//Failed to connect to the internet
			lb_putInOutBoundFolder = true
			li_return = -1
			as_errormessage = "Failed to connect to the internet, couldn't send file."
		END IF
	ELSE
		//for some reason the transaction couldn't be sent by profit tools.
		//we will put it int the outbound folder specified on the transaction page.
		lb_putInOutBoundFolder = true
		li_return = -1
	END IF		
	
	IF lb_putInOutBoundFolder THEN
		//leave it where it is, the location it is located in at this point is the outbound folder
	END IF
	
	IF li_return = 1 THEN
		//if it was sent successfully then we want to put the file into its done location
		//which is created if it doesn't exist.
		//FileDelete( as_filePath )
		ls_donePath = left( as_file, Lastpos( as_file, "\" ) - 1 )  //should change 'C:\ediwhatever\filname.txt' to 'C:\ediwhatever done'
		ls_donePath += " done"
		IF not DirectoryExists( ls_donePath ) THEN
			li_res = Createdirectory( ls_donePath )
		ELSE
			li_Res = 1
		END IF
		
		
		//once the file has been sent we keep a copy of the sent file locally
		IF li_res = 1 THEN
			ls_donePath = lnv_ediManager.of_appendtoprocessedlocationpath( ls_donePath )
			ls_donePath += "\" +ls_Name
			li_res = FileMove( as_file, ls_donePath )
		END IF
		
	END IF
ELSE
	li_return = -1
END IF
//END IF

DESTROY lds_transportSettings
DESTROY lds_transactionPaths
DESTROY lnv_ediManager
DESTROY lnv_ftp
return li_return
*/
end function

on n_cst_errorremedy_edi_resendfile.create
call super::create
end on

on n_cst_errorremedy_edi_resendfile.destroy
call super::destroy
end on

