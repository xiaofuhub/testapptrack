$PBExportHeader$n_cst_ediimportmanager.sru
forward
global type n_cst_ediimportmanager from n_base
end type
end forward

global type n_cst_ediimportmanager from n_base
end type
global n_cst_ediimportmanager n_cst_ediimportmanager

type variables
n_cst_edishipment_manager inv_shipmentManager
string	is_error
String	is_processFolder				
n_cst_errorlog_manager inv_errorLog
end variables

forward prototypes
public function integer of_import990 (string as_filename)
public function integer of_add990entry ()
public function string of_geterrorstring ()
public function integer of_putfileinarray (string as_filename, ref string asa_records[])
public function integer of_getfileformat (string as_filename, ref string as_filetype, string as_inout, long al_transactionset)
public function integer of_import997 (string as_filename)
public function integer of_add997entry ()
public function integer of_import214 (string as_filename)
public function integer of_add214entry ()
public function long of_gettransactionfromfile (string as_filename)
public function n_cst_errorlog_manager of_geterrorlogmanager ()
public function integer of_setprocessfolder (string as_processfolder)
end prototypes

public function integer of_import990 (string as_filename);/*
	Created By Dan 3-12-07.
	
	I pretty much copied this from appeon_constant.of_import204filesintopending.
	
	We did this because we wanted the functionality to be independent of the shipment managers,
	however the shipment managers have a lot of the parsing functionality that I want and need.
	So I use the base class as a service object for manipulating the segments and such.
*/

String	ls_FilePath
Long     i
Long		ll_FileHandle = -1
Int		li_Return = 1
String	lsa_Records[]
String	lsa_Streams[]
String	ls_Version
String	ls_DirectLinemode
String	ls_FileType
Int		li_FileTypeRtn
Long	ll_StreamCount
String	lsa_Temp[]
String	lsa_EMPTY[]
Long		j

Int		li_rtn



n_Cst_AnyArraySrv	lnv_Array
n_cst_String	lnv_String
n_cst_edisegment		lnva_segment[]

ls_FilePath = as_FileName

li_FileTypeRtn = THIS.of_GetFileformat( ls_FilePath , ls_FileType, appeon_constant.cs_transaction_INBOUND, 990 )

ls_fileType = Upper(ls_fileType)

IF /*lb_StreamMode*/ ls_fileType = "STREAM!" THEN
	IF Len ( ls_FilePath ) > 0 THEN
		ll_FileHandle = FileOpen ( ls_FilePath , StreamMode! )
	END IF
	
	IF ll_FileHandle >= 0 THEN
		DO
			i++
		LOOP WHILE ( FileRead ( ll_FileHandle, lsa_Streams[i] ) >= 0 )
	END IF
	
//	<<*>> I changed the approach to concatinating the long streams 8/17/05
	
	String	ls_Temp
	// put the steams togehter
	lnv_String.of_arraytostring( lsa_Streams, '', ls_Temp)	
	lnv_String.of_parsetoarray(ls_Temp , '~~', lsa_Records)

ELSEIF ls_fileType = "LINE!"  THEN// read the file in line mode

	IF Len ( ls_FilePath ) > 0 THEN
		ll_FileHandle = FileOpen ( ls_FilePath )
	END IF
	
	IF ll_FileHandle >= 0 THEN
		DO
			i++
		LOOP WHILE ( FileRead ( ll_FileHandle, lsa_Records[i] ) >= 0 )
	END IF

END IF

IF ll_FileHandle >= 0 THEN
	FileClose (  ll_FileHandle )
END IF

inv_shipmentmanager.of_resetsegments( )

if inv_shipmentmanager.of_loadSegments( lsa_Records ) = -1 then
	li_return = -1
end if

IF li_Return = 1 THEN
	this.of_add990entry( )
END IF


RETURN li_Return
end function

public function integer of_add990entry ();/*
	DEK created 3-12-07.
	
	Of_import990( /*string as_filename */) should be what is calling this.  If that is the case
	then we can read the information about our segments from the service object which had
	the segments loaded on to it.
*/

Int	li_return
Int	li_index
Long	ll_shipId
Long	ll_groupControl
String	ls_sender
String	ls_response
String	ls_reason
n_cst_ediexportshipmentmanager lnv_manager

lnv_manager = create n_cst_ediexportshipmentmanager

inv_shipmentmanager.of_getGroupControl( ll_groupControl, ls_sender  )

DO 
	li_index ++

	li_return = inv_shipmentmanager.of_getShipmentResponses(li_index, ll_shipId,ls_response, ls_reason )
	IF li_return = 1 THEN
		lnv_manager.of_process990( ll_shipid, ls_response, ls_reason, ls_sender)
	END IF
LOOP WHILE li_return = 1 

DESTROY lnv_manager
RETURN li_RETURN
end function

public function string of_geterrorstring ();return is_error
end function

public function integer of_putfileinarray (string as_filename, ref string asa_records[]);/*
	Created By Dan 3-12-07.
	
	I pretty much copied this from appeon_constant.of_import204filesintopending.
	
	We did this because we wanted the functionality to be independent of the shipment managers,
	however the shipment managers have a lot of the parsing functionality that I want and need.
	So I use the base class as a service object for manipulating the segments and such.
*/

String	ls_FilePath
Long     i
Long		ll_FileHandle = -1
Int		li_Return = 1
String	lsa_Records[]
String	lsa_Streams[]
String	ls_Version
String	ls_DirectLinemode
String	ls_FileType
Int		li_FileTypeRtn
Long	ll_StreamCount
String	lsa_Temp[]
String	lsa_EMPTY[]
Long		j
String	ls_mySefFile
Int		li_rtn
n_cst_setting_edi204sefPath lnv_setting



OleObject	lnv_xmlDocument
OleObject	lnv_ediDocument
OleObject	lnv_schemas
OleObject   lnv_schema

n_Cst_AnyArraySrv	lnv_Array
n_cst_String	lnv_String
n_cst_edisegment		lnva_segment[]

ls_FilePath = as_FileName

//li_FileTypeRtn = THIS.of_GetFileformat( ls_FilePath , ls_FileType, ls_Version, appeon_constant.cs_transaction_INBOUND )

ls_fileType = Upper(ls_fileType)

IF /*lb_StreamMode*/ ls_fileType = "STREAM!" THEN
	IF Len ( ls_FilePath ) > 0 THEN
		ll_FileHandle = FileOpen ( ls_FilePath , StreamMode! )
	END IF
	
	IF ll_FileHandle >= 0 THEN
		DO
			i++
		LOOP WHILE ( FileRead ( ll_FileHandle, lsa_Streams[i] ) >= 0 )
	END IF
	
//	<<*>> I changed the approach to concatinating the long streams 8/17/05
	
	String	ls_Temp
	// put the steams togehter
	lnv_String.of_arraytostring( lsa_Streams, '', ls_Temp)	
	lnv_String.of_parsetoarray(ls_Temp , '~~', lsa_Records)

ELSEIF ls_fileType = "LINE!"  THEN// read the file in line mode

	IF Len ( ls_FilePath ) > 0 THEN
		ll_FileHandle = FileOpen ( ls_FilePath )
	END IF
	
	IF ll_FileHandle >= 0 THEN
		DO
			i++
		LOOP WHILE ( FileRead ( ll_FileHandle, lsa_Records[i] ) >= 0 )
	END IF

END IF

asa_records = lsa_records

RETURN 1
end function

public function integer of_getfileformat (string as_filename, ref string as_filetype, string as_inout, long al_transactionset);/*
	This is a lot like of_getFileFormat on the n_cst_edishipment_manager, except there
	is only one version so we don't worry about it, and also this is capable of getting
	a specified transaction set file format, rather then one only for the 204
*/

Int	li_File
String	ls_Data
long	ll_ReadReturn
Long	li_Return = 1
Long	ll_CompanyID
Long	lla_dummy[]
String	ls_GSGF = "GS*GF*"
String	ls_GSSM = "GS*SM*"
String	ls_GSFA = "GS*FA*"
String	ls_GSQM = "GS*QM*"
String	ls_
String	ls_Scac
String	ls_Return = "LINE!"
String	ls_FileFormat
Int	li_Pos1
Int	li_Pos2
Int	li_FileClose
String	ls_transCheck
String	ls_message
String	ls_fileLink
n_cst_errorlog_manager	lnv_errorLog


lnv_errorLog	= this.of_getErrorlogmanager( )
CHOOSE CASE al_transactionset
	CASE 990
		ls_transCheck = ls_GSGF
	CASE 204
		ls_transCheck = ls_GSSM	//shouldn't ever happen in this script. Still handled by n_cst_edishipment_manager
	CASE 997
		ls_transCheck = ls_GSFA
	CASE 214
		ls_transCheck = ls_GSQM
	CASE ELSE
		//wierd.
		li_return = -1
		ls_message = "Couldn't find a valid file format, couldn't resolve transaction set from '"+string(al_transactionset)+"'"
END CHOOSE

IF li_return = 1 THEN
	li_File = FileOpen ( as_filename , StreamMode! )
	
	If li_File >= 0 THEN
		ll_ReadReturn = FileRead ( li_File , ls_Data )
		IF ll_ReadReturn <= 0 THEN
			li_Return = -1
			ls_message = "Couldn't find a valid file format, error reading file."
		END IF
		
		li_FileClose = FILEClose ( li_File )
	ELSE
		li_Return = -1
		ls_message = "Couldn't find a valid file format, error opening file."
	END IF
END IF

IF li_Return = 1 THEN
	IF Left ( ls_Data , 3 ) <> "ISA"  THEN  // this will screen out the old formats
		//added by dan to account for xml document imports on 2-2-2006
		IF lower(RIGHT( as_fileName, 3 )) = "xml" THEN
			ls_fileFormat = "XML!"
		ELSE
		//---------------------------
			ls_FileFormat = "LINE!" 
		END IF
		li_Return = 0 //no need to continue processing  !! this will be set back to 1 at the end to return success
		// but we do need to see what version the EDI should be processed By
		

		
	END IF
END IF

IF li_Return = 1 THEN
	li_Pos1 = Pos ( ls_Data , ls_transcheck )

	IF IsNull(li_Pos1) OR li_Pos1 = 0 THEN
		li_Return = -1
		ls_message = "Couldn't find a valid file format, no '"+ls_transcheck+"' found in file string '"+ls_data+"'"
	END IF
END IF

IF li_Return = 1 THEN
	li_Pos2 = Pos ( ls_Data , "*" , li_Pos1 + Len ( ls_transcheck ) )
			
	IF IsNull(li_Pos2) OR li_Pos2 = 0 THEN
		li_Return = -1
		ls_message = "Couldn't find a valid file format, closing '*' not found when looking for scac."
	END IF
END IF

IF li_Return = 1 THEN
	
	ls_Scac = Mid ( ls_Data , li_Pos1 + Len ( ls_transcheck ) , li_Pos2 - ( li_Pos1 + Len ( ls_transcheck ) )  )
	IF Len ( ls_Scac ) <= 0 THEN
		li_Return = -1
		ls_message = "Couldn't find a valid file format, no scac found in file."
	END IF
END IF

IF li_Return = 1 THEN
	
	SELECT  "ediprofile"."fileformat"  
   INTO  :ls_FileFormat  
   FROM 
         "ediprofile"  
   WHERE		"ediprofile"."SCAC" = :ls_Scac AND
				"ediprofile"."transactionset" =:al_transactionSet AND
				"ediprofile"."in_out" =:as_inout ;  
				
	//DEK 5-21-07  Added this to catch an error if the scac or transaction set isn't valid.			
	CHOOSE CASE	SQLCA.sqlcode
		CASE 0	//success
			COMMIT;
		CASE 100	//not found
			COMMIT;
			ls_message = "Couldn't find a valid file format for "+ls_scac + " transaction set "+ string(al_transactionset)
		CASE -1	//error
			ROLLBACK;
	END CHOOSE
		
				

END IF

IF Len ( ls_FileFormat ) > 0 AND li_Return <> -1 THEN
	li_Return = 1
	as_filetype = ls_FileFormat

ELSE
	li_Return = -1
END IF

//Added error loggin 5-22-07
IF len( ls_message ) > 0 THEN
	n_cst_errorremedy_edi	lnv_error
	lnv_error = create n_cst_errorremedy_edi
	ls_fileLink =	lnv_error.of_getFilelinkstring( is_processfolder ) + RIGHT(as_fileName, len(as_fileName) - lastPOS(as_fileName, "\"))
	DESTROY lnv_error
	lnv_errorLog.of_logerror( "EDI PROCESSING", "GET FILE FORMAT", ls_message +ls_fileLink , n_cst_constants.ci_ErrorLog_Urgency_Severe, lla_dummy, "n_cst_errorremedy_edi")
END IF
RETURN li_Return
end function

public function integer of_import997 (string as_filename);/*
	Created By Dan 3-12-07.
	
	I pretty much copied this from appeon_constant.of_import204filesintopending.
	
	We did this because we wanted the functionality to be independent of the shipment managers,
	however the shipment managers have a lot of the parsing functionality that I want and need.
	So I use the base class as a service object for manipulating the segments and such.
*/

String	ls_FilePath
Long     i
Long		ll_FileHandle = -1
Int		li_Return = 1
String	lsa_Records[]
String	lsa_Streams[]
String	ls_Version
String	ls_DirectLinemode
String	ls_FileType
Int		li_FileTypeRtn
Long	ll_StreamCount
String	lsa_Temp[]
String	lsa_EMPTY[]
Long		j
Int		li_rtn


n_Cst_AnyArraySrv	lnv_Array
n_cst_String	lnv_String
n_cst_edisegment		lnva_segment[]

ls_FilePath = as_FileName

li_FileTypeRtn = THIS.of_GetFileformat( ls_FilePath , ls_FileType, appeon_constant.cs_transaction_INBOUND, 997 )

ls_fileType = Upper(ls_fileType)

IF /*lb_StreamMode*/ ls_fileType = "STREAM!" THEN
	IF Len ( ls_FilePath ) > 0 THEN
		ll_FileHandle = FileOpen ( ls_FilePath , StreamMode! )
	END IF
	
	IF ll_FileHandle >= 0 THEN
		DO
			i++
		LOOP WHILE ( FileRead ( ll_FileHandle, lsa_Streams[i] ) >= 0 )
	END IF
	
//	<<*>> I changed the approach to concatinating the long streams 8/17/05
	
	String	ls_Temp
	// put the steams togehter
	lnv_String.of_arraytostring( lsa_Streams, '', ls_Temp)	
	lnv_String.of_parsetoarray(ls_Temp , '~~', lsa_Records)

ELSEIF ls_fileType = "LINE!"  THEN// read the file in line mode

	IF Len ( ls_FilePath ) > 0 THEN
		ll_FileHandle = FileOpen ( ls_FilePath )
	END IF
	
	IF ll_FileHandle >= 0 THEN
		DO
			i++
		LOOP WHILE ( FileRead ( ll_FileHandle, lsa_Records[i] ) >= 0 )
	END IF

END IF

IF ll_FileHandle >= 0 THEN
	FileClose (  ll_FileHandle )
END IF

inv_shipmentmanager.of_resetsegments( )

if inv_shipmentmanager.of_loadSegments( lsa_Records ) = -1 then
	li_return = -1
end if

IF li_Return = 1 THEN
	this.of_add997entry( )
END IF


RETURN li_Return
end function

public function integer of_add997entry ();/*
	DEK: 3-13-07
	Creates an entry in edi_imported997status and sets the group control, senderscode, edi, and the
	acknowleged group control number.  Returns 1 if success -1 otherwise
*/
n_cst_edisegment	lnva_Segments[]
n_cst_edisegment	lnva_GSSegments[]
int	li_Return = 1
Long	ll_segTotal
Long	ll_index
Long	ll_groupControl
Long	ll_max
String	ls_sender
String	ls_segId
String	ls_ak1Val1
String	ls_ackGroupControl
String	ls_fileContents
String	ls_find

n_ds	lds_997cache

lds_997cache = create n_ds
lds_997cache.dataobject = "d_997imports"
lds_997cache.settransobject( SQLCA )
lds_997cache.retrieve()
commit;


ll_segTotal = inv_shipmentmanager.of_getreply( 1, lnva_Segments )		//gets all the segments between ST and SE loop inclusively.

inv_shipmentmanager.of_getGroupControl( ll_groupControl, ls_sender  )

FOR ll_index = 1 TO ll_segTotal
	ls_segId = lnva_segments[ll_index].of_Getsegmentid( )
	
	CHOOSE CASE ls_segId
		CASE "AK1"	
			lnva_segments[ll_index].of_getValue( {1}, ls_ak1Val1 )	//this is what i check to see if its a response to a 204
			lnva_segments[ll_index].of_getValue( {2}, ls_ackGroupControl )
			
	END CHOOSE
	ls_fileContents += lnva_segments[ll_index].of_getrecordstring( )			
NEXT

ls_find = "groupcontrolnumber = "+ string( ll_groupControl ) + " and senderscode = '"+ ls_sender+"'"

ll_max = lds_997cache.rowcount()
ll_index = lds_997cache.find( ls_find, 1, ll_max )

IF ll_index > 0 Then
	//do not add it, this is an error
	li_Return = -1
END IF

If li_Return = 1 THEN
	IF len(ls_sender) > 0 AND ll_groupControl > 0 THEN
		//ok
	ELSE
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	ll_index = lds_997cache.insertrow( 0 )
	lds_997cache.setItem( ll_index, "groupcontrolnumber", ll_groupControl )
	lds_997cache.setItem( ll_index, "edi", ls_fileContents )
	lds_997cache.setItem( ll_index, "senderscode", ls_sender )
	lds_997cache.setItem( ll_index, "ackgroupcontrolnumber", long(ls_ackGroupControl) )
	lds_997cache.setItem( ll_index, "processed",0 )
END IF

IF li_Return = 1 THEN
	IF lds_997cache.update() = 1 THEN
		commit;
	ELSE
		rollback;
		li_return = -1
	END IF
END IF


destroy lds_997cache
RETURN li_Return
end function

public function integer of_import214 (string as_filename);/*
	Created By Dan 3-13-07.
	
	I pretty much copied this from appeon_constant.of_import204filesintopending.
	
	We did this because we wanted the functionality to be independent of the shipment managers,
	however the shipment managers have a lot of the parsing functionality that I want and need.
	So I use the base class as a service object for manipulating the segments and such.
*/

String	ls_FilePath
Long     i
Long		ll_FileHandle = -1
Int		li_Return = 1
String	lsa_Records[]
String	lsa_Streams[]
String	ls_Version
String	ls_DirectLinemode
String	ls_FileType
Int		li_FileTypeRtn
Long	ll_StreamCount
String	lsa_Temp[]
String	lsa_EMPTY[]
Long		j

Int		li_rtn



n_Cst_AnyArraySrv	lnv_Array
n_cst_String	lnv_String
n_cst_edisegment		lnva_segment[]

ls_FilePath = as_FileName

li_FileTypeRtn = THIS.of_GetFileformat( ls_FilePath , ls_FileType, appeon_constant.cs_transaction_INBOUND, 214 )

ls_fileType = Upper(ls_fileType)

IF /*lb_StreamMode*/ ls_fileType = "STREAM!" THEN
	IF Len ( ls_FilePath ) > 0 THEN
		ll_FileHandle = FileOpen ( ls_FilePath , StreamMode! )
	END IF
	
	IF ll_FileHandle >= 0 THEN
		DO
			i++
		LOOP WHILE ( FileRead ( ll_FileHandle, lsa_Streams[i] ) >= 0 )
	END IF
	
//	<<*>> I changed the approach to concatinating the long streams 8/17/05
	
	String	ls_Temp
	// put the steams togehter
	lnv_String.of_arraytostring( lsa_Streams, '', ls_Temp)	
	lnv_String.of_parsetoarray(ls_Temp , '~~', lsa_Records)

ELSEIF ls_fileType = "LINE!"  THEN// read the file in line mode

	IF Len ( ls_FilePath ) > 0 THEN
		ll_FileHandle = FileOpen ( ls_FilePath )
	END IF
	
	IF ll_FileHandle >= 0 THEN
		DO
			i++
		LOOP WHILE ( FileRead ( ll_FileHandle, lsa_Records[i] ) >= 0 )
	END IF

END IF

IF ll_FileHandle >= 0 THEN
	FileClose (  ll_FileHandle )
END IF

inv_shipmentmanager.of_resetsegments( )

if inv_shipmentmanager.of_loadSegments( lsa_Records ) = -1 then
	li_return = -1
end if

IF li_Return = 1 THEN
	this.of_add214entry( )
END IF


RETURN li_Return
end function

public function integer of_add214entry ();/*
	DEK created 3-13-07.
	
	Of_import214( /*string as_filename */) should be what is calling this.  If that is the case
	then we can read the information about our segments from the service object which had
	the segments loaded on to it.
*/

Int	li_return
Int	li_index
Long	ll_shipId
Long	ll_eventId
Long	ll_groupControlNumber
Int		li_process
String	ls_reason
String	ls_at7element
String	ls_at7code
String	ls_sendingCompany

DateTime	ldt_eventDateTime
n_cst_ediexportshipmentmanager lnv_manager

lnv_manager = create n_cst_ediexportshipmentmanager

inv_shipmentmanager.of_getgroupcontrol( ll_groupControlNumber, ls_sendingCompany )

DO 
	li_index ++
	ll_eventId = 0
	ll_shipId = 0
	li_process = 0
	ls_at7code = ""
	ls_at7element = ""
	setnull( ldt_eventDateTime )
	li_return = inv_shipmentManager.of_getshipEventId( li_index, ll_shipId, ll_eventId )
	
	IF li_return = 1 THEN
		li_process = inv_shipmentmanager.of_geteventconfirmation( li_index, ls_at7element, ls_at7code, ldt_eventDateTime)
	END IF
	IF li_process = 1 THEN
		lnv_manager.of_process214( ll_eventId, ls_at7code, ldt_eventDateTime, ll_groupControlNumber, ls_sendingCompany, li_index )
	END IF
LOOP WHILE li_return = 1 


DESTROY lnv_manager
RETURN li_RETURN
end function

public function long of_gettransactionfromfile (string as_filename);Int	li_File
String	ls_Data
long	ll_ReadReturn
Long	li_Return = 1
Long	ll_CompanyID
String	ls_GSGF = "GS*GF*"	//990
String	ls_GSSM = "GS*SM*"	//204
String	ls_GSFA = "GS*FA*"	//997
String	ls_GSQM = "GS*QM*"	//214
String	ls_
String	ls_Scac
String	ls_Return = "LINE!"
String	ls_FileFormat
Int	li_Pos1
Int	li_Pos2
Int	li_FileClose
Boolean lb_found
String	ls_transCheck

Long	ll_transaction


IF li_return = 1 THEN
	li_File = FileOpen ( as_filename , StreamMode! )
	
	If li_File >= 0 THEN
		ll_ReadReturn = FileRead ( li_File , ls_Data )
		IF ll_ReadReturn <= 0 THEN
			li_Return = -1
		END IF
		
		li_FileClose = FILEClose ( li_File )
	ELSE
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF Left ( ls_Data , 3 ) <> "ISA"  THEN  // this will screen out the old formats
		//---------------------------
		ls_FileFormat = "LINE!" 
	
		li_Return = 0 //no need to continue processing  !! this will be set back to 1 at the end to return success
		// but we do need to see what version the EDI should be processed By
	END IF
END IF

IF li_Return = 1 THEN
	li_Pos1 = Pos ( ls_Data , ls_GSSM )

	IF li_Pos1 > 0 THEN
		lb_found = true
		ll_transaction = 204
	END IF
	
	IF not lb_found THEN
		li_Pos1 = Pos ( ls_Data , ls_GSFA )

		IF li_Pos1 > 0 THEN
			lb_found = true
			ll_transaction = 997
		END IF
	END IF
	
	IF not lb_found THEN
		li_Pos1 = Pos ( ls_Data , ls_GSGF )

		IF li_Pos1 > 0 THEN
			lb_found = true
			ll_transaction = 990
		END IF
	END IF
	
	IF not lb_found THEN
		li_Pos1 = Pos ( ls_Data , ls_GSQM )

		IF li_Pos1 > 0 THEN
			lb_found = true
			ll_transaction = 214
		END IF
	END IF
	
END IF

RETURN ll_transaction
end function

public function n_cst_errorlog_manager of_geterrorlogmanager ();IF not isValid( inv_errorLog  ) THEN
	inv_errorLog = create n_cst_errorlog_manager
END IF

RETURN inv_errorLog
end function

public function integer of_setprocessfolder (string as_processfolder);is_processFOlder = as_processFolder
RETURN 1
end function

on n_cst_ediimportmanager.create
call super::create
end on

on n_cst_ediimportmanager.destroy
call super::destroy
end on

event constructor;call super::constructor;inv_shipmentManager = create n_cst_edishipment_manager 
end event

event destructor;call super::destructor;destroy inv_shipmentManager 
destroy inv_errorLog
end event

