$PBExportHeader$n_cst_wininet_http.sru
$PBExportComments$Win32 HTTP Service Extension.
forward
global type n_cst_wininet_http from n_cst_wininet32
end type
end forward

global type n_cst_wininet_http from n_cst_wininet32
end type
global n_cst_wininet_http n_cst_wininet_http

type prototypes
// HTTP functions
FUNCTION ulong HttpOpenRequestA( ulong hHttpSession, string lpszVerb, string lpszObjectName, string lpszVersion, string lpszReferer, string lpszAcceptTypes[], ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll" alias for "HttpOpenRequestA;Ansi"
FUNCTION ulong HttpSendRequestA( ulong hHttpRequest, string lpszHeaders, ulong dwHeadersLength, string lpOptional, ulong dwOptionalLength ) LIBRARY "wininet.dll" alias for "HttpSendRequestA;Ansi"

end prototypes

type variables
Protected:
ulong	iul_service

end variables

forward prototypes
public function integer of_connect (string as_servername)
public function unsignedlong of_gethandle ()
end prototypes

public function integer of_connect (string as_servername);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_Connect
//
//	Access:				public
//
//	Arguments:			String as_servername	- e.g., "www.powersoft.com"
//
//	Returns:				Ulong	- connection handle
//							> 0	- success
//							<= 0	- error
//
//	Description:		Opens an HTTP session for a given site.
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
iul_service = InternetConnectA( of_GetSessionHandle(), as_servername, DEFAULT_HTTP_PORT, &
											ls_null, ls_null, HTTP, 0, 0 )

iul_errorcode = GetLastError()
IF iul_service = 0 THEN
	RETURN FAILURE
ELSE
	RETURN SUCCESS
END IF
end function

public function unsignedlong of_gethandle ();RETURN iul_service
end function

on n_cst_wininet_http.create
call super::create
end on

on n_cst_wininet_http.destroy
call super::destroy
end on

