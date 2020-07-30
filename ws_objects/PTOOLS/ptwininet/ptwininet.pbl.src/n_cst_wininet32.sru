$PBExportHeader$n_cst_wininet32.sru
$PBExportComments$Win32 Internet API service.
forward
global type n_cst_wininet32 from n_base
end type
type filetime from structure within n_cst_wininet32
end type
type finddata from structure within n_cst_wininet32
end type
end forward

type filetime from structure
	unsignedlong		dwLowDateTime
	unsignedlong		dwHighDateTime
end type

type finddata from structure
	unsignedlong		dwfileattrib
	filetime		ftcreate
	filetime		ftLastaccess
	filetime		ftlastwrite
	unsignedlong		nFileSizeHigh
	unsignedlong		nFileSizelow
	unsignedlong		dwreserved0
	unsignedlong		dwreserved1
	character		cfilename[256]
	character		cAlternatefname[14]
end type

global type n_cst_wininet32 from n_base
event ue_init ( )
end type
global n_cst_wininet32 n_cst_wininet32

type prototypes
FUNCTION ulong InternetAutodial( ulong  dwFlags, ulong dwReserved ) LIBRARY "wininet.dll"
FUNCTION ulong InternetAutodialHangup( ulong dwReserved ) LIBRARY "wininet.dll"
FUNCTION ulong InternetCloseHandle( ulong handle ) LIBRARY "wininet.dll"
FUNCTION ulong InternetConnectA( ulong hSession, string szServer, uint iPort, string szUser, string szPassword, ulong dwService, ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll" alias for "InternetConnectA;Ansi"
FUNCTION ulong InternetDial( ulong hwndParent, string szConnectId, ulong dwFlags, REF ulong dwConnection, ulong dwReserved ) LIBRARY "wininet.dll" alias for "InternetDial;Ansi"
FUNCTION ulong InternetGetConnectedState( REF ulong lpdwFlags, ulong dwReserved ) LIBRARY "wininet.dll"
FUNCTION ulong InternetGetLastResponseInfoA( REF ulong lpdwError, REF string lpszBuffer, REF ulong lpdwBufferLength ) LIBRARY "wininet.dll" alias for "InternetGetLastResponseInfoA;Ansi"
FUNCTION ulong InternetHangup( ulong dwConnection, ulong dwReserved ) LIBRARY "wininet.dll"
FUNCTION ulong InternetOpenA( string szAgent, ulong dwAccessType, string szProxy, string szProxyBypass, ulong dwFlags ) LIBRARY "wininet.dll" alias for "InternetOpenA;Ansi"
FUNCTION ulong InternetQueryDataAvailable( ulong hFile, REF ulong lpdwBytesAvailable, ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll"
FUNCTION ulong InternetReadFile( ulong hFile, REF string lpBuffer, ulong dwBytesToRead, REF ulong lpBytesRead ) LIBRARY "wininet.dll" alias for "InternetReadFile;Ansi"

// helper functions
FUNCTION ulong GetLastError() LIBRARY "kernel32.dll"
end prototypes

type variables
Protected:
ulong iul_session
ulong iul_errorcode

Public:

// Internet connection flags
CONSTANT uint CONNECTION_MODEM	= 1
CONSTANT uint CONNECTION_LAN		= 2
CONSTANT uint CONNECTION_PROXY	= 4
CONSTANT uint CONNECTION_MODEM_BUSY	= 8
CONSTANT ulong INTERNET_FLAG_ASYNC	= 268435456
CONSTANT ulong INTERNET_FLAG_SECURE	= 8388608

// Internet auto-dial flags
CONSTANT uint AUTODIAL_FORCE_ONLINE		= 1
CONSTANT uint AUTODIAL_FORCE_UNATTENDED	= 2
CONSTANT uint AUTODIAL_FAILIFSECURITYCHECK	= 4

// Internet dial flags
CONSTANT uint INTERNET_DIAL_UNATTENDED	= 32768

// Internet open flags
CONSTANT uint OPEN_TYPE_PRECONFIG	= 0
CONSTANT uint OPEN_TYPE_DIRECT	= 1
CONSTANT uint OPEN_TYPE_GATEWAY	= 2
CONSTANT uint OPEN_TYPE_PROXY		= 3

// Ports
CONSTANT uint INVALID_PORT_NUMBER	= 0
CONSTANT uint DEFAULT_FTP_PORT	= 21
CONSTANT uint DEFAULT_GOPHER_PORT	= 70
CONSTANT uint DEFAULT_HTTP_PORT	= 80
CONSTANT uint DEFAULT_HTTPS_PORT	= 443
CONSTANT uint DEFAULT_SOCKS_PORT	= 1080

// Service/Command types
CONSTANT uint FTP	= 1
CONSTANT uint GOPHER	= 2
CONSTANT uint HTTP	= 3

// Internet flags
CONSTANT ulong INTERNET_FLAG_RELOAD			= 2147483648
CONSTANT ulong INTERNET_FLAG_NO_CACJE_WRITE		= 67108864
CONSTANT ulong INTERNET_FLAG_RAW_DATA		= 1073741824

// Error messages
CONSTANT uint ERROR_NO_MORE_FILES			= 18
CONSTANT uint INTERNET_ERROR_BASE			= 12000
CONSTANT uint ERROR_INTERNET_OUT_OF_HANDLES		= (INTERNET_ERROR_BASE + 1)
CONSTANT uint ERROR_INTERNET_TIMEOUT			= (INTERNET_ERROR_BASE + 2)
CONSTANT uint ERROR_INTERNET_EXTENDED_ERROR		= (INTERNET_ERROR_BASE + 3)
CONSTANT uint ERROR_INTERNET_INTERNAL_ERROR		= (INTERNET_ERROR_BASE + 4)
CONSTANT uint ERROR_INTERNET_INVALID_URL			= (INTERNET_ERROR_BASE + 5)
CONSTANT uint ERROR_INTERNET_UNRECOGNIZED_SCHEME	= (INTERNET_ERROR_BASE + 6)
CONSTANT uint ERROR_INTERNET_NAME_NOT_RESOLVED	= (INTERNET_ERROR_BASE + 7)
CONSTANT uint ERROR_INTERNET_PROTOCOL_NOT_FOUND	= (INTERNET_ERROR_BASE + 8)
CONSTANT uint ERROR_INTERNET_INVALID_OPTION		= (INTERNET_ERROR_BASE + 9)
CONSTANT uint ERROR_INTERNET_BAD_OPTION_LENGTH        	= (INTERNET_ERROR_BASE + 10)
CONSTANT uint ERROR_INTERNET_OPTION_NOT_SETTABLE      	= (INTERNET_ERROR_BASE + 11)
CONSTANT uint ERROR_INTERNET_SHUTDOWN                 		= (INTERNET_ERROR_BASE + 12)
CONSTANT uint ERROR_INTERNET_INCORRECT_USER_NAME      	= (INTERNET_ERROR_BASE + 13)
CONSTANT uint ERROR_INTERNET_INCORRECT_PASSWORD       	= (INTERNET_ERROR_BASE + 14)
CONSTANT uint ERROR_INTERNET_LOGIN_FAILURE            		= (INTERNET_ERROR_BASE + 15)
CONSTANT uint ERROR_INTERNET_INVALID_OPERATION        	= (INTERNET_ERROR_BASE + 16)
CONSTANT uint ERROR_INTERNET_OPERATION_CANCELLED      	= (INTERNET_ERROR_BASE + 17)
CONSTANT uint ERROR_INTERNET_INCORRECT_HANDLE_TYPE    	= (INTERNET_ERROR_BASE + 18)
CONSTANT uint ERROR_INTERNET_INCORRECT_HANDLE_STATE   	= (INTERNET_ERROR_BASE + 19)
CONSTANT uint ERROR_INTERNET_NOT_PROXY_REQUEST        	= (INTERNET_ERROR_BASE + 20)
CONSTANT uint ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND	= (INTERNET_ERROR_BASE + 21)
CONSTANT uint ERROR_INTERNET_BAD_REGISTRY_PARAMETER   	= (INTERNET_ERROR_BASE + 22)
CONSTANT uint ERROR_INTERNET_NO_DIRECT_ACCESS         	= (INTERNET_ERROR_BASE + 23)
CONSTANT uint ERROR_INTERNET_NO_CONTEXT               		= (INTERNET_ERROR_BASE + 24)
CONSTANT uint ERROR_INTERNET_NO_CALLBACK              		= (INTERNET_ERROR_BASE + 25)
CONSTANT uint ERROR_INTERNET_REQUEST_PENDING          	= (INTERNET_ERROR_BASE + 26)
CONSTANT uint ERROR_INTERNET_INCORRECT_FORMAT         	= (INTERNET_ERROR_BASE + 27)
CONSTANT uint ERROR_INTERNET_ITEM_NOT_FOUND           	= (INTERNET_ERROR_BASE + 28)
CONSTANT uint ERROR_INTERNET_CANNOT_CONNECT           	= (INTERNET_ERROR_BASE + 29)
CONSTANT uint ERROR_INTERNET_CONNECTION_ABORTED       	= (INTERNET_ERROR_BASE + 30)
CONSTANT uint ERROR_INTERNET_CONNECTION_RESET         	= (INTERNET_ERROR_BASE + 31)
CONSTANT uint ERROR_INTERNET_FORCE_RETRY              		= (INTERNET_ERROR_BASE + 32)
CONSTANT uint ERROR_INTERNET_INVALID_PROXY_REQUEST    	= (INTERNET_ERROR_BASE + 33)
CONSTANT uint ERROR_INTERNET_NEED_UI                  		= (INTERNET_ERROR_BASE + 34)
CONSTANT uint ERROR_INTERNET_HANDLE_EXISTS            		= (INTERNET_ERROR_BASE + 36)
CONSTANT uint ERROR_INTERNET_SEC_CERT_DATE_INVALID    	= (INTERNET_ERROR_BASE + 37)
CONSTANT uint ERROR_INTERNET_SEC_CERT_CN_INVALID      	= (INTERNET_ERROR_BASE + 38)
CONSTANT uint ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR   	= (INTERNET_ERROR_BASE + 39)
CONSTANT uint ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR   	= (INTERNET_ERROR_BASE + 40)
CONSTANT uint ERROR_INTERNET_MIXED_SECURITY           		= (INTERNET_ERROR_BASE + 41)
CONSTANT uint ERROR_INTERNET_CHG_POST_IS_NON_SECURE   	= (INTERNET_ERROR_BASE + 42)
CONSTANT uint ERROR_INTERNET_POST_IS_NON_SECURE       	= (INTERNET_ERROR_BASE + 43)
CONSTANT uint ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED  	= (INTERNET_ERROR_BASE + 44)
CONSTANT uint ERROR_INTERNET_INVALID_CA               		= (INTERNET_ERROR_BASE + 45)
CONSTANT uint ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP    	= (INTERNET_ERROR_BASE + 46)
CONSTANT uint ERROR_INTERNET_ASYNC_THREAD_FAILED      	= (INTERNET_ERROR_BASE + 47)
CONSTANT uint ERROR_INTERNET_REDIRECT_SCHEME_CHANGE   	= (INTERNET_ERROR_BASE + 48)
CONSTANT uint ERROR_INTERNET_DIALOG_PENDING           		= (INTERNET_ERROR_BASE + 49)
CONSTANT uint ERROR_INTERNET_RETRY_DIALOG             		= (INTERNET_ERROR_BASE + 50)
CONSTANT uint ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR  	= (INTERNET_ERROR_BASE + 52)
CONSTANT uint ERROR_INTERNET_INSERT_CDROM             		= (INTERNET_ERROR_BASE + 53)
CONSTANT uint ERROR_FTP_TRANSFER_IN_PROGRESS          	= (INTERNET_ERROR_BASE + 110)
CONSTANT uint ERROR_FTP_DROPPED                       		= (INTERNET_ERROR_BASE + 111)
CONSTANT uint ERROR_FTP_NO_PASSIVE_MODE               		= (INTERNET_ERROR_BASE + 112)
CONSTANT uint ERROR_GOPHER_PROTOCOL_ERROR             	= (INTERNET_ERROR_BASE + 130)
CONSTANT uint ERROR_GOPHER_NOT_FILE                   		= (INTERNET_ERROR_BASE + 131)
CONSTANT uint ERROR_GOPHER_DATA_ERROR                 		= (INTERNET_ERROR_BASE + 132)
CONSTANT uint ERROR_GOPHER_END_OF_DATA                		= (INTERNET_ERROR_BASE + 133)
CONSTANT uint ERROR_GOPHER_INVALID_LOCATOR            		= (INTERNET_ERROR_BASE + 134)
CONSTANT uint ERROR_GOPHER_INCORRECT_LOCATOR_TYPE     	= (INTERNET_ERROR_BASE + 135)
CONSTANT uint ERROR_GOPHER_NOT_GOPHER_PLUS            	= (INTERNET_ERROR_BASE + 136)
CONSTANT uint ERROR_GOPHER_ATTRIBUTE_NOT_FOUND        	= (INTERNET_ERROR_BASE + 137)
CONSTANT uint ERROR_GOPHER_UNKNOWN_LOCATOR            	= (INTERNET_ERROR_BASE + 138)
CONSTANT uint ERROR_HTTP_HEADER_NOT_FOUND             	= (INTERNET_ERROR_BASE + 150)
CONSTANT uint ERROR_HTTP_DOWNLEVEL_SERVER             	= (INTERNET_ERROR_BASE + 151)
CONSTANT uint ERROR_HTTP_INVALID_SERVER_RESPONSE      	= (INTERNET_ERROR_BASE + 152)
CONSTANT uint ERROR_HTTP_INVALID_HEADER               		= (INTERNET_ERROR_BASE + 153)
CONSTANT uint ERROR_HTTP_INVALID_QUERY_REQUEST        	= (INTERNET_ERROR_BASE + 154)
CONSTANT uint ERROR_HTTP_HEADER_ALREADY_EXISTS        	= (INTERNET_ERROR_BASE + 155)
CONSTANT uint ERROR_HTTP_REDIRECT_FAILED              		= (INTERNET_ERROR_BASE + 156)
CONSTANT uint ERROR_HTTP_NOT_REDIRECTED               		= (INTERNET_ERROR_BASE + 160)
CONSTANT uint ERROR_HTTP_COOKIE_NEEDS_CONFIRMATION    	= (INTERNET_ERROR_BASE + 161)
CONSTANT uint ERROR_HTTP_COOKIE_DECLINED              		= (INTERNET_ERROR_BASE + 162)
CONSTANT uint ERROR_HTTP_REDIRECT_NEEDS_CONFIRMATION  	= (INTERNET_ERROR_BASE + 168)
CONSTANT uint ERROR_INTERNET_SECURITY_CHANNEL_ERROR   	= (INTERNET_ERROR_BASE + 157)
CONSTANT uint ERROR_INTERNET_UNABLE_TO_CACHE_FILE     	= (INTERNET_ERROR_BASE + 158)
CONSTANT uint ERROR_INTERNET_TCPIP_NOT_INSTALLED      	= (INTERNET_ERROR_BASE + 159)
CONSTANT uint ERROR_INTERNET_DISCONNECTED             		= (INTERNET_ERROR_BASE + 163)
CONSTANT uint ERROR_INTERNET_SERVER_UNREACHABLE       	= (INTERNET_ERROR_BASE + 164)
CONSTANT uint ERROR_INTERNET_PROXY_SERVER_UNREACHABLE 	= (INTERNET_ERROR_BASE + 165)
CONSTANT uint ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT    		= (INTERNET_ERROR_BASE + 166)
CONSTANT uint ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT 	= (INTERNET_ERROR_BASE + 167)
CONSTANT uint ERROR_INTERNET_SEC_INVALID_CERT    		= (INTERNET_ERROR_BASE + 169)
CONSTANT uint ERROR_INTERNET_SEC_CERT_REVOKED    	= (INTERNET_ERROR_BASE + 170)
CONSTANT uint ERROR_INTERNET_FAILED_DUETOSECURITYCHECK	= (INTERNET_ERROR_BASE + 171)
CONSTANT uint INTERNET_ERROR_LAST                       		= ERROR_INTERNET_FAILED_DUETOSECURITYCHECK
end variables

forward prototypes
public function integer of_internetautodial ()
public function integer of_internetdial (string as_connection, boolean ab_switch)
public function string of_internetgetconnection ()
public function string of_internetgeterrortext ()
public function unsignedlong of_getsessionhandle ()
public function integer of_internetautodialhangup ()
public function integer of_internethangup (unsignedlong aul_connection)
protected function unsignedlong of_internetopen ()
protected function unsignedlong of_internetopen (string as_proxyname, string as_proxybypass)
protected function unsignedlong of_internetopen (unsignedinteger ai_accesstype)
end prototypes

event ue_init;iul_session = of_InternetOpen()
IF iul_session <= 0 THEN
	MessageBox( "Internet Error", "WININET.DLL could not be initialized.", Exclamation! )
	RETURN
END IF


end event

public function integer of_internetautodial ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_InternetAutoDial
//
//	Access:				public
//
//	Arguments:			None
//
//	Returns:				Integer
//							 1 - success
//							 0 - already connected, no action
//							-1 - error
//
//	Description:		Initiates a unattended dial-up connection to the internet
//							using Dial-up Networking's default phonebook entry.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

ulong		lul_connection
integer	li_rc

lul_connection = CONNECTION_LAN + &
					  CONNECTION_MODEM + &
					  CONNECTION_PROXY
li_rc = InternetGetConnectedState( lul_connection, 0 )
IF li_rc = 0 THEN
	li_rc = InternetAutoDial( AUTODIAL_FORCE_ONLINE, 0 )
	iul_errorcode = GetLastError()
	IF li_rc > 0 THEN
		RETURN SUCCESS
	ELSE
		RETURN FAILURE
	END IF
ELSE
	RETURN NO_ACTION
END IF
end function

public function integer of_internetdial (string as_connection, boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_InternetDial
//
//	Access:				public
//
//	Arguments:			String as_connection	- Dial-Up Networking connection
//														  to be used.
//							Boolean ab_swicth		- Display connection info (Y/N)
//
//	Returns:				Integer
//							 1 - success
//							 0 - already connected, no action
//							-1 - error
//
//	Description:		Initiates a unattended dial-up connection to the internet
//							using Dial-up Networking's default phonebook entry.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

ulong		lul_connection, lul_flags
integer	li_rc

lul_connection = CONNECTION_LAN + &
					  CONNECTION_MODEM + &
					  CONNECTION_PROXY
li_rc = InternetGetConnectedState( lul_connection, 0 )
IF li_rc = 0 THEN
	lul_flags = AUTODIAL_FORCE_UNATTENDED
	IF NOT ab_switch THEN
		lul_flags += INTERNET_DIAL_UNATTENDED
	END IF
	li_rc = InternetDial( Handle( gnv_app.of_GetFrame() ), &
								 as_connection, lul_flags, lul_connection, 0 )
	iul_errorcode = GetLastError()
	IF li_rc > 0 THEN
		RETURN SUCCESS
	ELSE
		RETURN FAILURE
	END IF
ELSE
	RETURN NO_ACTION
END IF
end function

public function string of_internetgetconnection ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_InternetDial
//
//	Access:				public
//
//	Arguments:			None
//
//	Returns:				String	- connection type
//							"Modem"
//							"Lan"
//							"Proxy"
//							"Not Connected"
//
//	Description:		Returns the type of the current Internet connection.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version

//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

ulong					lul_connection, lul_flags
integer				li_rc
n_cst_numerical	inv_num
string				ls_connection = ""

lul_connection = CONNECTION_LAN + &
					  CONNECTION_MODEM + &
					  CONNECTION_PROXY

li_rc = InternetGetConnectedState( lul_connection, 0 )
IF li_rc = 0 THEN RETURN "Not Connected"

IF inv_num.of_GetBit( lul_connection, 1 ) THEN			// 0x0001
	ls_connection += "Modem"
ELSE
	IF inv_num.of_GetBit( lul_connection, 2 ) THEN		// 0x0010
		ls_connection += "Lan"
	END IF
END IF

IF inv_num.of_GetBit( lul_connection, 3 ) THEN			// 0x0100
	ls_connection += "/Proxy"
END IF

RETURN ls_connection

end function

public function string of_internetgeterrortext ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_InternetGetErrorText
//
//	Access:				public
//
//	Arguments:			None
//
//	Returns:				String
//							The error text associated with the last error code
//							NULL string if error code is invalid
//
//	Description:		Returns a string containing an error description or 
//							server response on the thread calling the failed function. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

String 	ls_retval

SetNull( ls_retval )
IF iul_errorcode < INTERNET_ERROR_BASE OR &
	iul_errorcode > INTERNET_ERROR_LAST THEN
	RETURN ls_retval
END IF

CHOOSE CASE iul_errorcode
	CASE ERROR_FTP_DROPPED 
		ls_retval = "The FTP operation was not completed because the session was aborted."
	CASE ERROR_FTP_TRANSFER_IN_PROGRESS 
		ls_retval = "The requested operation cannot be made on the FTP session handle " + &
						"because an operation is already in progress."
	CASE ERROR_GOPHER_ATTRIBUTE_NOT_FOUND 
		ls_retval = "The requested attribute could not be located."
	CASE ERROR_GOPHER_DATA_ERROR 
		ls_retval = "An error was detected while receiving data from the Gopher server."
	CASE ERROR_GOPHER_END_OF_DATA 
		ls_retval = "The end of the data has been reached."
	CASE ERROR_GOPHER_INCORRECT_LOCATOR_TYPE 
		ls_retval = "The type of the locator is not correct for this operation."
	CASE ERROR_GOPHER_INVALID_LOCATOR 
		ls_retval = "The supplied locator is not valid."
	CASE ERROR_GOPHER_NOT_FILE 
		ls_retval = "The request must be made for a file locator."
	CASE ERROR_GOPHER_NOT_GOPHER_PLUS 
		ls_retval = "The requested operation can only be made against a Gopher+ " + &
						"server, or with a locator that specifies a Gopher+ operation."
	CASE ERROR_GOPHER_PROTOCOL_ERROR 
		ls_retval = "An error was detected while parsing data returned from the Gopher server."
	CASE ERROR_GOPHER_UNKNOWN_LOCATOR 
		ls_retval = "The locator type is unknown."
	CASE ERROR_HTTP_DOWNLEVEL_SERVER 
		ls_retval = "The server did not return any headers."
	CASE ERROR_HTTP_HEADER_ALREADY_EXISTS 
		ls_retval = "The header could not be added because it already exists."
	CASE ERROR_HTTP_HEADER_NOT_FOUND 
		ls_retval = "The requested header could not be located."
	CASE ERROR_HTTP_INVALID_HEADER 
		ls_retval = "The supplied header is invalid."
	CASE ERROR_HTTP_INVALID_QUERY_REQUEST 
		ls_retval = "The request made to HttpQueryInfo is invalid."
	CASE ERROR_HTTP_REDIRECT_FAILED 
		ls_retval = "The redirection failed because either the scheme changed " + &
						"(HTTP to FTP) or all attempts made to redirect failed."
	CASE ERROR_HTTP_REDIRECT_NEEDS_CONFIRMATION 
		ls_retval = "The redirection requires user confirmation."
	CASE ERROR_HTTP_INVALID_SERVER_RESPONSE 
		ls_retval = "The server response could not be parsed."
	CASE ERROR_INTERNET_ASYNC_THREAD_FAILED 
		ls_retval = "The application could not start an asynchronous thread."
	CASE ERROR_INTERNET_BAD_OPTION_LENGTH 
		ls_retval = "The length of an option supplied to InternetQueryOption " + &
						"or InternetSetOption is incorrect for the type of option specified."
	CASE ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT 
		ls_retval = "There was an error in the automatic proxy configuration script."
	CASE ERROR_INTERNET_BAD_REGISTRY_PARAMETER 
		ls_retval = "A required registry value was located but is an incorrect " + &
						"type or has an invalid value."
	CASE ERROR_INTERNET_CANNOT_CONNECT 
		ls_retval = "The attempt to connect to the server failed."
	CASE ERROR_INTERNET_CHG_POST_IS_NON_SECURE 
		ls_retval = "The application is posting and attempting to change multiple " + &
						"lines of text on a server that is not secure."
	CASE ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED 
		ls_retval = "The server is requesting client authentication."
	CASE ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP 
		ls_retval = "Client authorization is not set up on this computer."
	CASE ERROR_INTERNET_CONNECTION_ABORTED 
		ls_retval = "The connection with the server has been terminated."
	CASE ERROR_INTERNET_CONNECTION_RESET 
		ls_retval = "The connection with the server has been reset."
	CASE ERROR_INTERNET_DIALOG_PENDING 
		ls_retval = "Another thread has a password dialog in progress."
	CASE ERROR_INTERNET_DISCONNECTED 
		ls_retval = "The Internet connection has been lost."
	CASE ERROR_INTERNET_EXTENDED_ERROR
		ulong		lul_buffSize, lul_rc
		
		InternetGetLastResponseInfoA( iul_errorcode, ls_retval, lul_buffSize )
		IF lul_buffSize > 0 THEN
			ls_retval = Space( lul_buffSize + 1 )
			lul_rc = InternetGetLastResponseInfoA( iul_errorcode, ls_retval, lul_buffSize )
			IF lul_rc <> 0 THEN
				ls_retval = "The server has returned an extended error: " + ls_retval
			END IF
		ELSE
			ls_retval = "The server has returned an extended error."
		END IF
	CASE ERROR_INTERNET_FAILED_DUETOSECURITYCHECK 
		ls_retval = "The function failed due to a security check."
	CASE ERROR_INTERNET_FORCE_RETRY 
		ls_retval = "The Win32 Internet function needs to redo the request."
	CASE ERROR_INTERNET_HANDLE_EXISTS 
		ls_retval = "The request failed because the handle already exists."
	CASE ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR 
		ls_retval = "The application is moving from a non-SSL to an SSL connection " + &
						"because of a redirect."
	CASE ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR 
		ls_retval = "The application is moving from an SSL to an non-SSL connection " + &
						"because of a redirect."
	CASE ERROR_INTERNET_INCORRECT_FORMAT 
		ls_retval = "The format of the request is invalid."
	CASE ERROR_INTERNET_INCORRECT_HANDLE_STATE 
		ls_retval = "The requested operation cannot be carried out because the " + &
						"handle supplied is not in the correct state."
	CASE ERROR_INTERNET_INCORRECT_HANDLE_TYPE 
		ls_retval = "The type of handle supplied is incorrect for this operation."
	CASE ERROR_INTERNET_INCORRECT_PASSWORD 
		ls_retval = "The request to connect and log on to an FTP server could not " + &
						"be completed because the supplied password is incorrect."
	CASE ERROR_INTERNET_INCORRECT_USER_NAME 
		ls_retval = "The request to connect and log on to an FTP server could not " + &
						"be completed because the supplied user name is incorrect."
	CASE ERROR_INTERNET_INSERT_CDROM 
		ls_retval = "The request requires a CD-ROM to be inserted in the CD-ROM " + &
						"drive to locate the resource requested."
	CASE ERROR_INTERNET_INTERNAL_ERROR 
		ls_retval = "An internal error has occurred."
	CASE ERROR_INTERNET_INVALID_CA 
		ls_retval = "The function is unfamiliar with the Certificate Authority " + &
						"that generated the server's certificate."
	CASE ERROR_INTERNET_INVALID_OPERATION 
		ls_retval = "The requested operation is invalid."
	CASE ERROR_INTERNET_INVALID_OPTION 
		ls_retval = "A request to InternetQueryOption or InternetSetOption " + &
						"specified an invalid option value."
	CASE ERROR_INTERNET_INVALID_PROXY_REQUEST 
		ls_retval = "The request to the proxy was invalid."
	CASE ERROR_INTERNET_INVALID_URL 
		ls_retval = "The URL is invalid."
	CASE ERROR_INTERNET_ITEM_NOT_FOUND 
		ls_retval = "The requested item could not be located."
	CASE ERROR_INTERNET_LOGIN_FAILURE 
		ls_retval = "The request to connect and log on to an FTP server failed."
	CASE ERROR_INTERNET_MIXED_SECURITY 
		ls_retval = "The content is not entirely secure. Some of the content being " + &
						"viewed may have come from unsecured servers."
	CASE ERROR_INTERNET_NAME_NOT_RESOLVED 
		ls_retval = "The server name could not be resolved."
	CASE ERROR_INTERNET_NEED_UI 
		ls_retval = "A user interface or other blocking operation has been requested."
	CASE ERROR_INTERNET_NO_CALLBACK 
		ls_retval = "An asynchronous request could not be made because a callback " + &
						"function has not been set."
	CASE ERROR_INTERNET_NO_CONTEXT 
		ls_retval = "An asynchronous request could not be made because a zero " + &
						"context value was supplied."
	CASE ERROR_INTERNET_NO_DIRECT_ACCESS 
		ls_retval = "Direct network access cannot be made at this time."
	CASE ERROR_INTERNET_NOT_PROXY_REQUEST 
		ls_retval = "The request cannot be made via a proxy."
	CASE ERROR_INTERNET_OPERATION_CANCELLED 
		ls_retval = "The operation was canceled, usually because the handle on which " + &
						"the request was operating was closed before the operation completed."
	CASE ERROR_INTERNET_OPTION_NOT_SETTABLE 
		ls_retval = "The requested option cannot be set, only queried."
	CASE ERROR_INTERNET_OUT_OF_HANDLES 
		ls_retval = "No more handles could be generated at this time."
	CASE ERROR_INTERNET_POST_IS_NON_SECURE 
		ls_retval = "The application is posting data to a sever that is not secure."
	CASE ERROR_INTERNET_PROTOCOL_NOT_FOUND 
		ls_retval = "The requested protocol could not be located."
	CASE ERROR_INTERNET_PROXY_SERVER_UNREACHABLE 
		ls_retval = "The designated proxy server cannot be reached."
	CASE ERROR_INTERNET_REDIRECT_SCHEME_CHANGE 
		ls_retval = "The function could not handle the redirection, because the scheme " + &
						"changed (HTTP to FTP)."
	CASE ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND 
		ls_retval = "A required registry value could not be located."
	CASE ERROR_INTERNET_REQUEST_PENDING 
		ls_retval = "The required operation could not be completed because one or more " + &
						"requests are pending."
	CASE ERROR_INTERNET_SEC_CERT_CN_INVALID 
		ls_retval = "SSL certificate common name (host name field) is incorrect. " + &
						"for example, if you entered www.server.com and the common name " + &
						"on the certificate says www.different.com."
	CASE ERROR_INTERNET_SEC_CERT_DATE_INVALID 
		ls_retval = "SSL certificate date that was received from the server is bad. " + &
						"The certificate is expired."
	CASE ERROR_INTERNET_SEC_CERT_REVOKED 
		ls_retval = "SSL certificate was revoked."
	CASE ERROR_INTERNET_SEC_INVALID_CERT 
		ls_retval = "SSL certificate is invalid."
	CASE ERROR_INTERNET_SECURITY_CHANNEL_ERROR 
		ls_retval = "The application experienced an internal error loading the SSL libraries."
	CASE ERROR_INTERNET_SERVER_UNREACHABLE 
		ls_retval = "The Web site or server indicated is unreachable."
	CASE ERROR_INTERNET_SHUTDOWN 
		ls_retval = "The Win32 Internet function support is being shut down or unloaded."
	CASE ERROR_INTERNET_TCPIP_NOT_INSTALLED 
		ls_retval = "The required protocol stack is not loaded and the application " + &
						"cannot start WinSock."
	CASE ERROR_INTERNET_TIMEOUT 
		ls_retval = "The request has timed out."
	CASE ERROR_INTERNET_UNABLE_TO_CACHE_FILE 
		ls_retval = "The function was unable to cache the file."
	CASE ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT 
		ls_retval = "The automatic proxy configuration script could not be downloaded. " + &
						"The INTERNET_FLAG_MUST_CACHE_REQUEST flag was set."
	CASE ERROR_INTERNET_UNRECOGNIZED_SCHEME 
		ls_retval = "The URL scheme could not be recognized, or is not supported."
	CASE ELSE
		//
END CHOOSE

RETURN ls_retval
end function

public function unsignedlong of_getsessionhandle ();IF iul_session <= 0 THEN
	// try one more time
	iul_session = of_InternetOpen()
END IF
RETURN iul_session
end function

public function integer of_internetautodialhangup ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_InternetAutoDialHangup
//
//	Access:				public
//
//	Arguments:			None
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Disconnects a dial-up connection which was initiated with
//							of_InternetAutoDial().
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

li_rc = InternetAutoDialHangup(0)
iul_errorcode = GetLastError()
IF li_rc > 0 THEN
	RETURN SUCCESS
ELSE
	RETURN FAILURE
END IF

end function

public function integer of_internethangup (unsignedlong aul_connection);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_InternetHangup
//
//	Access:				public
//
//	Arguments:			Ulong aul_connection	- Internet connection handle
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Disconnects a dial-up connection that was initiated
//							with of_InternetDial().
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

li_rc = InternetHangup( aul_connection, 0 )
iul_errorcode = GetLastError()
IF li_rc > 0 THEN
	RETURN SUCCESS
ELSE
	RETURN FAILURE
END IF

end function

protected function unsignedlong of_internetopen ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_InternetOpen
//
//	Access:				protected
//
//	Arguments:			None
//
//	Returns:				ULong	- an Internet session handle to be used by 
//									  subsequent calls to Internet functions
//
//							> 0 - success
//							  0 - error
//
//	Description:		Initilizes the internet DLL.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Ulong			ll_rc
String		ls_null
Application	la_app

SetNull( ls_null)
la_app = GetApplication()
ll_rc = InternetOpenA( la_app.AppName, &
								  OPEN_TYPE_DIRECT, ls_null, ls_null, 0 )
iul_errorcode = GetLastError()
RETURN ll_rc

end function

protected function unsignedlong of_internetopen (string as_proxyname, string as_proxybypass);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_InternetOpen
//
//	Access:				protected
//
//	Arguments:			String as_proxyname, as_proxybypass
//
//	Returns:				Unsigned long	- an Internet session handle to be used by 
//												  subsequent calls to Internet functions
//							> 0 - success
//							  0 - error
//
//	Description:		Initilizes the internet DLL.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Ulong		ll_rc
String	ls_null
Application	la_app

SetNull( ls_null)
la_app = GetApplication()
ll_rc = InternetOpenA( la_app.AppName, &
							  OPEN_TYPE_PROXY, as_proxyname, as_proxybypass, 0 )

iul_errorcode = GetLastError()
RETURN ll_rc

end function

protected function unsignedlong of_internetopen (unsignedinteger ai_accesstype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_InternetOpen
//
//	Access:				protected
//
//	Arguments:			Uint ai_accesstype - default is OPEN_TYPE_DIRECT. If
//														you have special registry settings
//														in place,  use OPEN_TYPE_PRECONFIG.
//														If you are connecting through a
//														gateway, use OPEN_TYPE_GATEWAY.
//
//	Returns:				ULong	- an Internet session handle to be used by 
//									  subsequent calls to Internet functions
//
//							> 0 - success
//							  0 - error
//
//	Description:		Initilizes the internet DLL.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Ulong		ll_rc
String	ls_null
Application	la_app

SetNull( ls_null)
la_app = GetApplication()
ll_rc = InternetOpenA( la_app.AppName, &
								  ai_accesstype, ls_null, ls_null, 0 )

iul_errorcode = GetLastError()
RETURN ll_rc

end function

on n_cst_wininet32.create
call super::create
end on

on n_cst_wininet32.destroy
call super::destroy
end on

event destructor;InternetCloseHandle( iul_session )
end event

event constructor;this.POST EVENT ue_init()
end event

