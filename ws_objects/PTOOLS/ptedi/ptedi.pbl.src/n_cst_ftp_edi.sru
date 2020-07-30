$PBExportHeader$n_cst_ftp_edi.sru
forward
global type n_cst_ftp_edi from n_base
end type
end forward

global type n_cst_ftp_edi from n_base
end type
global n_cst_ftp_edi n_cst_ftp_edi

type variables
String	is_lastDownloadLocation

n_cst_errorlog_manager inv_errorLogManager


end variables

forward prototypes
public function integer of_sendfile (string as_file, integer ai_transactionset, ref string as_errormessage, long al_coid, string as_fileformat)
public function string of_getlastdownloadlocation ()
public function integer of_downloadedifrom (long al_coid, string asa_frompaths[], ref string as_errormessage)
public function integer of_dirlist (n_cst_wininet_ftp anv_ftp, ref string asa_files[])
public function n_cst_errorlog_manager of_geterrorlogmanager ()
end prototypes

public function integer of_sendfile (string as_file, integer ai_transactionset, ref string as_errormessage, long al_coid, string as_fileformat);//created 1-4-2007, This function will FTP the specified edi file to the company passed in 
//using the format specified. 
/*
		returns
		1:	success
	  -1: fail
	  	as_errorMessage will be returned by reference explaining why it failed.
*/

int 	li_return
int	li_res
int	li_Rc
int	li_passiveTransfer
Long	ll_coId
Long	ll_index 
Long	li_mode
Long	ll_port
Long	ll_timeout
Long	ll_rows
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

Boolean		lb_sendAsCii
Boolean		lb_sendByProfitTools
Datastore	lds_transportSettings
Datastore	lds_transactionPaths
n_cst_wininet_ftp        lnv_ftp

n_cst_errorlog			lnv_error
//	n_cst_edishipment_manager inv_shipmentManager
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
ll_coId =  al_coid//ila_sourceids[1] //this.of_getEdicompanyid( )
ls_remedy = "n_cst_errorremedy_edi_resendFile"

ll_index = lds_transportSettings.Retrieve( ll_coId )		//there should be 1 row retrieved
ll_rows = lds_transactionPaths.retrieve( ll_coid )
lds_transactionPaths.setfilter( "in_out = '"+ appeon_constant.cs_transaction_OUTBOUND +"'" )
lds_transactionPaths.filter()

ls_fileFormat = as_fileFormat
//if not set up we don't send it
IF ll_index > 0 THEN
	lb_sendByProfitTools = true
ELSE
	as_errorMessage = "The company isn't set up for Profit Tools to handle the transport.  Couldn't send file."
END IF


IF lb_sendByProfitTools THEN
	
	//use winInet to send the file as specified by the following settings.
	
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

		
	//send the file
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
						
						lb_sendAsCii = (ls_fileFOrmat <> "STREAM!")
						li_return = lnv_ftp.of_putfile( as_file, ls_name, lb_sendAsCii/*boolean ab_ascii */)
						//MEssagebox( "", lnv_ftp.of_internetgeterrortext( ) )
						IF li_return = -1 THEN
							as_errormessage = "Failed 'put' operation of of_sendFile. Couldn't send file."
						END IF
					ELSE
						//directory doesn't exist, we fail to send
						li_return = -1
						as_errormessage = "Invalid put location, couldn't send file."
					END IF
				ELSE
					//send to the path that we connected to.
					lb_sendAsCii = (ls_fileFOrmat <> "STREAM!")
					li_return = lnv_ftp.of_putfile( as_file, ls_name, lb_sendAsCii/*boolean ab_ascii */)
					//MEssagebox( "", lnv_ftp.of_internetgeterrortext( ) )
					IF li_return = -1 THEN
						as_errormessage = "Failed 'put' operation of of_sendFile. Couldn't send file."
					END IF
				END IF
			ELSE
				//failed to connect to FTP server
				li_return = -1
				as_errorMessage = "Couldn't connect to FTP server, couldn't send file."
			END IF
		ELSE
			//Failed to connect to the internet
			li_return = -1
			as_errormessage = "Failed to connect to the internet, couldn't send file."
		END IF
	ELSE
		//for some reason the transaction couldn't be sent by profit tools.
		li_return = -1
	END IF		
ELSE
	li_return = -1
END IF


DESTROY lds_transportSettings
DESTROY lds_transactionPaths
DESTROY lnv_ediManager
DESTROY lnv_ftp
return li_return
end function

public function string of_getlastdownloadlocation ();//this is the TO path determined at run time for a specified edi company. It gets set when
//it determines where files downloaded to.
RETURN is_lastDownloadLocation	
end function

public function integer of_downloadedifrom (long al_coid, string asa_frompaths[], ref string as_errormessage);
/*
DEK 3-15-07: The purpose of this function is to download all of the files from teh specied locations into a companies
download folder. It uses wininet.
*/

Int	li_return = 1
Int	li_passiveTransfer
Int	li_mode
Int	li_deleteremoteFile
Long	i
Long	ll_timeout
Long	ll_coid
Long	ll_index
Long	ll_fileindex
Long	ll_port
Long	ll_fromCOunt
Long	ll_fileCount
Long	ll_Max
Long	ll_numSlashes


String	ls_address
String	ls_userId
String	ls_password
String	ls_targetPath
String	ls_protocol
String	ls_downloadPath
String	ls_fileName
String	lsa_blank[]
String	lsa_files[]

Boolean	lb_checkConnectionLocation	= true //this is set to false if a location is found where the path is null
Boolean	lb_downloadUsingPT
Boolean	lb_ascii

n_cst_string	lnv_string


n_cst_wininet_ftp	lnv_ftp

n_Ds	lds_transportSettings
n_ds	lds_transactionPaths

n_cst_errorlog_manager lnv_errorLogManager

lnv_errorLogManager = this.of_getErrorlogmanager( )
ll_coId =  al_coid

lnv_ftp = create n_cst_wininet_ftp

lds_transportSettings = CREATE n_ds
lds_transportSettings.dataobject = "d_transportsettings"
lds_transportSettings.setTransobject( SQLCA )

ll_index = lds_transportSettings.Retrieve( ll_coId )		//there should be 1 row retrieved
commit;

lds_transactionPaths = CREATE n_ds
lds_transactionPaths.dataobject = "d_transactionpaths"
lds_transactionPaths.settransobject( SQLCA )
ll_max = lds_transactionPaths.retrieve( ll_coid )
commit;




//if not set up we don't send it
IF ll_index > 0 THEN
	lb_downloadUsingPt = true
	
	//The only reason i do this is because I need to know if I delete the files remotely.
	//When we were downloading only 204s we thought that it would be a transaction setting so 
	//we could delete certain transactions remotely while not others.  For now we will only support
	//the deletion of remote files after download if the setting is on the 204 transaction, however
	//since we do not know the transaction set of the file at download time, we will delete all transaction
	//downloads if the setting is set for the 204.  This may not be an acceptable solution in the long run.
	FOR ll_index = 1 TO ll_max
		IF lds_transactionPaths.getItemNumber( ll_index, "transactionset") = 204 AND lds_transactionPaths.getitemstring( ll_index, "in_out") = "INBOUND" THEN
			li_deleteRemoteFile = lds_transactionPaths.getItemNumber( ll_index, "deleteremotely" )
		END IF
	NEXT
ELSE
	li_return = -1
	as_errorMessage = "The company isn't set up for Profit Tools to handle the transport.  Couldn't send file. Company ID: "+ string(al_coid)
	lnv_errorLogManager.of_logerror( "EDI FTP download", "FTP Download", as_errorMessage, n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_coid }, "n_cst_errorremedy_edi")
END IF

IF lnv_ftp.of_internetautodial( ) <> -1 THEN
	li_Return = 1
	lnv_ftp.event ue_init( )
ELSE
	//problem connecting to the internet
	li_return = -1
	as_errormessage = "Error connecting to the internet when attempting to download from company: "+ string( al_coid )
	lnv_errorLogManager.of_logerror( "EDI FTP download", "FTP Download", as_errorMessage, n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_coid }, "n_cst_errorremedy_edi")
END IF


// try to connect to server
IF li_return = 1 THEN 
	
	//this block of code will determine if we
	//need to check the connection location for the ftp transfer.
	//In previous functionality, a null target path meant we checked
	//the connection location.
	ll_fromcount = upperBound( asa_frompaths )
	IF ll_fromCount > 0 THEN
		FOR ll_index = 1 TO ll_fromcount
			IF NOT isNull( asa_fromPaths[ll_index] ) THEN
				lb_checkConnectionLocation = false
			END IF
		NEXT
	END IF
	
	IF lds_transportSettings.rowCount() > 0 THEN
		li_mode = lds_transportSettings.getItemNumber( 1, "mode_text" )
		ll_port = lds_transportSettings.getItemNumber( 1, "port" )
		ll_timeout = lds_transportSettings.getItemNumber( 1, "timeout" )
		ls_userId = lds_transportSettings.getItemString( 1, "userid" )
		ls_password = lds_transportSettings.getItemString( 1, "password" )
		ls_protocol = lds_transportSettings.getItemString( 1, "protocol" )
		ls_address = lds_transportSettings.getItemString( 1, "address" )
		li_passiveTransfer = lds_transportSettings.getItemNumber( 1, "passive_transfer" )
		ls_downloadPath = lds_transportSettings.getItemString( 1, "downloadlocation" )
		is_lastdownloadlocation = ls_downloadPath
		lb_ascii = ( li_mode = 2 )
	END IF
	IF len(ls_downloadPath) > 0 THEN
		//ok
	ELSE
		li_return = -1
		as_errormessage = "Error downloading files for company: "+string(al_coid) +" No download to location specified."
		lnv_errorLogManager.of_logerror( "EDI FTP download", "FTP Download", as_errorMessage, n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_coid }, "n_cst_errorremedy_edi")
	END IF

	IF li_passiveTransfer = 1 THEN
		IF lnv_ftp.of_connect( ls_address, ls_userId, ls_password, ll_port, appeon_constant.InternetConnect_Passive ) > 0 THEN
			//success
		ELSE
			li_return = -1
			as_errormessage = "Error downloading files for company: "+string(al_coid) +" Could not connect to ftp server."
			lnv_errorLogManager.of_logerror( "EDI FTP download", "FTP Download", as_errorMessage, n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_coid }, "n_cst_errorremedy_edi")
		END IF
	ELSE
		IF lnv_ftp.of_connect( ls_address, ls_userId, ls_password, ll_port ) > 0 THEN
			//success
		ELSE
			li_return = -1
			as_errormessage = "Error downloading files for company: "+string(al_coid) +" Could not connect to ftp server."
			lnv_errorLogManager.of_logerror( "EDI FTP download", "FTP Download", as_errorMessage, n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_coid }, "n_cst_errorremedy_edi")
		END IF
	END IF
END IF

//at this point I should be connected to the server, now I want
//to try downloading all of the files from the specified paths.

IF li_return = 1 THEN
	ll_fromCount = upperBound( asa_frompaths )
	
	FOR  ll_index = 1 TO ll_fromCount
		ls_targetPath = asa_fromPaths[ll_index]
		
		//this is to navigate back up to the root, it is the number of .. i have to do in change directory
		ll_numSlashes = lnv_string.of_countoccurrences( ls_targetPath, "/") + 1  
	
		lsa_files = lsa_blank
		//check the connection location if we have determined that we need to.
		//This will only happen on the first pass through.
		IF lb_checkConnectionLocation AND ll_index = 1 THEN
			try	
				IF this.of_dirlist( lnv_ftp, lsa_files ) = 1 THEN
					
				ELSE
					//unexpected error
				END IF		
			Catch( oleruntimeerror olerr2)
				as_errormessage = "Error downloading files for company: " + string( al_coid )+ ".~r~nDirlist Error: ~r~n" + olerr2.getMessage() 
				lnv_errorLogManager.of_logerror( "EDI FTP download", "FTP Download", as_errorMessage, n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_coid }, "n_cst_errorremedy_edi")
			
				DESTROY olerr2				
			END TRY
		ELSEIF not Isnull( ls_targetPath ) THEN
			
			//we do not have to navigate up the first time.
			IF ll_numSlashes > 0 AND ll_index > 1 THEN
				FOR i = 1 TO ll_numSlashes
					lnv_ftp.of_changeDirectory( ".." )
				NEXT
			END IF
			
			IF lnv_ftp.of_changedirectory( ls_targetPath ) = 1 THEN					
				try
					IF this.of_dirlist( lnv_ftp, lsa_files ) = 1 THEN
						
					ELSE
						//unexpected error
					END IF
				Catch( oleruntimeerror olerr)
					as_errormessage = "Error downloading files for company: " + string( al_coid )+ ".~r~nDirlist error: ~r~n" + olerr2.getMessage() 
					lnv_errorLogManager.of_logerror( "EDI FTP download", "FTP Download", as_errorMessage, n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_coid }, "n_cst_errorremedy_edi")
					DESTROY olerr		
				END TRY
			ELSE
				//couldn't change the directory to the one we wanted.
				as_errormessage = "Error downloading files for company: " + string( al_coid )+ ".~r~nCouldn't change directory to: "+ ls_targetPath+ "~r~nFTP Error: "+ string( lnv_ftp.getlasterror( )) + lnv_ftp.of_internetgeterrortext( )                       
				lnv_errorLogManager.of_logerror( "EDI FTP download", "FTP Download", as_errorMessage, n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_coid }, "n_cst_errorremedy_edi")
			END IF
		ELSE
			//we already checked the connection location, so there is nothing to do here.
		END IF
		
		//At This point we should have a list of files from the current directory that we want to download.
		ll_fileCount = upperBound( lsa_files )
		
		FOR ll_fileindex = 1 TO ll_FileCount
			ls_fileName = lsa_files[ll_fileINdex]
			
			//Download the file, if successful and setting to delete remote file is yes then we delete the file.
			IF lnv_ftp.of_getfile( ls_fileName , ls_downloadPath +"\"+ ls_fileName , lb_ascii ) = 1 THEN
				IF li_deleteRemoteFile > 0 THEN
					IF lnv_ftp.of_deletefile( ls_fileName ) = 1 THEN
					
					ELSE
						//failed to delete file after successful download
					END IF
				ELSE
					//failed
					as_errormessage = "Error downloading files for company: " + string( al_coid )+ ".~r~nError during get call on: "+ ls_fileName
					lnv_errorLogManager.of_logerror( "EDI FTP download", "FTP Download", as_errorMessage, n_cst_constants.ci_ErrorLog_Urgency_Severe , { al_coid }, "n_cst_errorremedy_edi")
				END IF
			END IF
		NEXT
	NEXT
END IF

DESTROY lnv_ftp

RETURN li_return
end function

public function integer of_dirlist (n_cst_wininet_ftp anv_ftp, ref string asa_files[]);Int		li_return = 1
Long		ll_index
Long		ll_max
String	ls_files	
String	lsa_files[]
String	lsa_existingFiles[]

n_cst_string	lnv_string



IF isValid(anv_ftp) THEN
	//returns a list of files delimited by ~r~n
	ls_files = anv_ftp.of_dirList()
	ll_max = lnv_string.of_parsetoarray( ls_files, "~r~n", lsa_files )
	
	FOR ll_index = 1 TO ll_max
			lsa_existingFiles[upperBound(lsa_existingFiles)+ 1] = lsa_files[ll_index]
	NEXT
ELSE
	li_RETURN = -1
END IF

asa_files = lsa_existingfiles
RETURN li_RETURN 
end function

public function n_cst_errorlog_manager of_geterrorlogmanager ();

IF NOT isValid(  inv_errorLogManager ) THEN
	inv_errorLogManager = create n_cst_errorlog_manager
END IF

RETURN inv_errorLogManager
end function

on n_cst_ftp_edi.create
call super::create
end on

on n_cst_ftp_edi.destroy
call super::destroy
end on

event destructor;call super::destructor;IF isValid(inv_errorLogManager) THEN
	destroy inv_errorLogManager
END IF
end event

