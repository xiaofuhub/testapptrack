$PBExportHeader$n_cst_wininet_ftp.sru
$PBExportComments$Win32 FTP Service Extension.
forward
global type n_cst_wininet_ftp from n_cst_wininet32
end type
end forward

global type n_cst_wininet_ftp from n_cst_wininet32
end type
global n_cst_wininet_ftp n_cst_wininet_ftp

type prototypes
FUNCTION ulong FtpDeleteFile( ulong hSession, string lpszFileName ) LIBRARY "wininet.dll" alias for "FtpDeleteFile;Ansi"
FUNCTION ulong FtpDeleteFileA( ulong hSession, string lpszFileName ) LIBRARY "wininet.dll" alias for "FtpDeleteFileA;Ansi"
FUNCTION ulong FtpCreateDirectory( ulong hSession, string lpszDirectory ) LIBRARY "wininet.dll" alias for "FtpCreateDirectory;Ansi"
FUNCTION ulong FtpFindFirstFileA( ulong hSession, string szSearchFile, REF FINDDATA lpvData, ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll" alias for "FtpFindFirstFileA;Ansi"
FUNCTION ulong FtpGetFileA( ulong hService, string szRemoteFile, string szLocalFile, boolean bFailIfExist, ulong dwLocalFlags, ulong dwInetFals, ulong dwContext ) LIBRARY "wininet.dll" alias for "FtpGetFileA;Ansi"
FUNCTION ulong FtpPutFileA( ulong hService, string szLocalFile, string szRemoteFile, ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll" alias for "FtpPutFileA;Ansi"
FUNCTION ulong FtpGetCurrentDirectoryA( ulong hService, REF string szPath, REF ulong lpdwBuffLength ) LIBRARY "wininet.dll" alias for "FtpGetCurrentDirectoryA;Ansi"
FUNCTION ulong FtpRemoveDirectory( ulong hSession, string lpszDirectory ) LIBRARY "wininet.dll" alias for "FtpRemoveDirectory;Ansi"
FUNCTION ulong FtpRenameFile( ulong hSession, string lpszExisting, string lpszNew ) LIBRARY "wininet.dll" alias for "FtpRenameFile;Ansi"
FUNCTION ulong FtpSetCurrentDirectoryA( ulong hService, string szPath ) LIBRARY "wininet.dll" alias for "FtpSetCurrentDirectoryA;Ansi"
FUNCTION ulong InternetFindNextFileA( ulong hFind, REF FINDDATA lpvData ) LIBRARY "wininet.dll" alias for "InternetFindNextFileA;Ansi"

end prototypes

type variables
Protected:
ulong	iul_service

Public:
// FTP transfer flags
CONSTANT uint FTP_TRANSFER_TYPE_ASCII		= 1
CONSTANT uint FTP_TRANSFER_TYPE_BINARY	= 2

CONSTANT uint InternetConnect_Passive = 32768

end variables

forward prototypes
public function integer of_connect (string as_server)
public function integer of_changedirectory (string as_directory)
public function string of_dirlist ()
public function boolean of_fileexist (string as_filename)
public function integer of_getfile (string as_source, string as_target, boolean ab_ascii)
public function integer of_putfile (string as_source, string as_target, boolean ab_ascii)
public function integer of_connect (string as_servername, string as_username, string as_password)
protected function unsignedlong of_gethandle ()
public function integer of_connect (string as_servername, string as_username, string as_password, unsignedinteger ai_port)
public function integer of_connect (string as_servername, string as_username, string as_password, unsignedinteger ai_port, unsignedlong al_flag)
public function integer of_deletefile (string as_filename)
end prototypes

public function integer of_connect (string as_server);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_Connect
//
//	Access:				public
//
//	Arguments:			String as_server	- e.g., "ftp.powersoft.com"
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Opens an FTP session for a given site.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

String	ls_null

SetNull( ls_null )
iul_service = InternetConnectA( iul_session, as_server, DEFAULT_FTP_PORT, &
											ls_null, ls_null, FTP, 0, 0 )
IF iul_service = 0 THEN
	RETURN FAILURE
ELSE
	RETURN SUCCESS
END IF
end function

public function integer of_changedirectory (string as_directory);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_FTPChangeDirectory
//
//	Access:				public
//
//	Arguments:			String as_as_directory - remote directory to switch to
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Changes to a specified working directory on the FTP server.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc

li_rc = FtpSetCurrentDirectoryA( iul_service, as_directory )
iul_errorcode = GetLastError()


IF li_rc = 0 THEN
	RETURN FAILURE
ELSE
	RETURN SUCCESS
END IF
end function

public function string of_dirlist ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_DirList
//
//	Access:				public
//
//	Arguments:			None
//
//	Returns:				String
//
//	Description:		Returns a newline-delimited list of files and sub-
//							directories in the working directory on the FTP server.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
ulong		ll_flags
ulong		lul_hFind, lul_rc = 1
String	ls_null, ls_retval
FINDDATA	pData

//10-17-06 DEK, I changed the flag it passes into FtpFindFirstFileA, according to the microsoft
//website, if the data is being changed on teh ftp server often( by us or them ), we should
//be passing in the flags Internet_flag_raw_data + Internet_flag_no_cache_write.  It is
//changing often, and I noticed a problem with it thinking files were still there even though
//they definately are not, because we deleted them.  The reason I didn't overload it is because
//I can't think of  a time when i don't want the most current data.
ll_flags = Internet_flag_raw_data + Internet_flag_no_cacje_write + internet_flag_reload

SetNull( ls_null )
lul_hFind = FtpFindFirstFileA( iul_service, ls_null, pData, ll_flags/*INTERNET_FLAG_RAW_DATA*/, 0 )
iul_errorcode = GetLastError()
IF lul_hFind > 0 THEN
	ls_retval += ( pData.cFilename + "~r~n" )
	DO WHILE lul_rc > 0
		lul_rc = InternetFindNextFileA( lul_hFind, pData )
		IF lul_rc > 0 THEN
			ls_retval += ( pData.cFilename + "~r~n" )
		END IF
	LOOP
	RETURN ls_retval
ELSE
	RETURN ls_null
END IF

end function

public function boolean of_fileexist (string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_FileExist
//
//	Access:				public
//
//	Arguments:			String as_filename - name of file to look for
//
//	Returns:				Boolean
//							TRUE if file exists, FALSE otherwise
//
//	Description:		Searches for a file in the working directory on the FTP server.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

ulong		lul_hFind
FINDDATA	pData

lul_hFind = FtpFindFirstFileA( iul_service, as_filename, pData, 0, 0 )
iul_errorcode = GetLastError()
IF lul_hFind > 0 THEN
	// If the requested file is the first one - we're done
	IF pData.cFilename = as_filename THEN
		RETURN TRUE	
	ELSE
		RETURN FALSE
	END IF
ELSE
	RETURN FALSE
END IF

end function

public function integer of_getfile (string as_source, string as_target, boolean ab_ascii);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_GetFile
//
//	Access:				public
//
//	Arguments:			String  as_source	 - remote filename
//							String  as_target	 - local filename
//							Boolean ab_ascii	 - transfer mode
//													   TRUE  - ASCII
//													   FALSE - binary (default)
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Retrieves a file from an FTP server ans stores it under 
//							the specified local filename, creating a new local file
//							in the process.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc
Ulong		lul_mode

IF ab_ascii THEN
	lul_mode = FTP_TRANSFER_TYPE_ASCII
ELSE
	lul_mode = FTP_TRANSFER_TYPE_BINARY
END IF

li_rc = FtpGetFileA( iul_service, as_source, as_target, FALSE, 0, lul_mode, 0 )
iul_errorcode = GetLastError()

IF li_rc <> 0 THEN
	RETURN SUCCESS
ELSE
	RETURN FAILURE
END IF
end function

public function integer of_putfile (string as_source, string as_target, boolean ab_ascii);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_FTPGetFile
//
//	Access:				public
//
//	Arguments:			String  as_source	 - local filename
//							String  as_target	 - remote filename
//							Boolean ab_ascii	 - transfer mode
//													   TRUE  - ASCII
//													   FALSE - binary (default)
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Uploads a file to an FTP server and stores it under 
//							the specified remote filename, creating a new remote file
//							in the process.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc
Ulong		lul_mode

IF ab_ascii THEN
	lul_mode = FTP_TRANSFER_TYPE_ASCII
ELSE
	lul_mode = FTP_TRANSFER_TYPE_BINARY
END IF

li_rc = FtpPutFileA( iul_service, as_source, as_target, lul_mode, 0 )
iul_errorcode = GetLastError()

IF li_rc <> 0 THEN
	RETURN SUCCESS
ELSE
	RETURN FAILURE
END IF
end function

public function integer of_connect (string as_servername, string as_username, string as_password);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_Connect
//
//	Access:				public
//
//	Arguments:			Ulong al_session		- An Internet session handle returned
//													  	  by a previous call to of_InternetOpen()
//
//							String as_servername	- e.g., "ftp.powersoft.com"
//							String as_userrname	- user name
//							String as_password	- password
//
//	Returns:				Ulong	- connection handle
//							> 0	- success
//							<= 0	- error
//
//	Description:		Opens an FTP session for a given site.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// Modified by dan to call overloaded function with default port
//////////////////////////////////////////////////////////////////////////////
return this.of_connect(as_servername,as_username, as_password,  DEFAULT_FTP_PORT)

//iul_service = InternetConnectA( iul_session, as_servername, DEFAULT_FTP_PORT, &
//											as_username, as_password, FTP, 0, 0 )
//
//iul_errorcode = GetLastError()
//IF iul_service > 0 THEN
//	RETURN SUCCESS
//ELSE
//	RETURN FAILURE
//END IF
end function

protected function unsignedlong of_gethandle ();RETURN iul_service
end function

public function integer of_connect (string as_servername, string as_username, string as_password, unsignedinteger ai_port);//copied from By Dan 
//		this.of_connect( /*string as_servername*/, /*string as_username*/, /*string as_password */)
//so that we can specify a port 

iul_service = InternetConnectA( iul_session, as_servername, ai_port, &
											as_username, as_password, FTP, 0, 0 )

iul_errorcode = GetLastError()
IF iul_service > 0 THEN
	RETURN SUCCESS
ELSE
	RETURN FAILURE
END IF
end function

public function integer of_connect (string as_servername, string as_username, string as_password, unsignedinteger ai_port, unsignedlong al_flag);//passive mode as flag would be 32768

iul_service = InternetConnectA( iul_session, as_servername, ai_port, &
											as_username, as_password, FTP, al_flag, 0 )

iul_errorcode = GetLastError()
IF iul_service > 0 THEN
	RETURN SUCCESS
ELSE
	RETURN FAILURE
END IF
end function

public function integer of_deletefile (string as_filename);/*
	DEK: This is meant to delete the file specified for the current session.
	
	RETURNS 1 Success
	REturns -1 Failutre
*/

Integer	li_rc
Ulong		lul_mode

li_rc = FtpDeleteFileA( iul_service , as_filename ) 
iul_errorcode = GetLastError()

IF li_rc <> 0 THEN
	RETURN SUCCESS
ELSE
	RETURN FAILURE
END IF
end function

on n_cst_wininet_ftp.create
call super::create
end on

on n_cst_wininet_ftp.destroy
call super::destroy
end on

