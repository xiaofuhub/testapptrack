$PBExportHeader$n_cst_edishipmentprocessmanager.sru
forward
global type n_cst_edishipmentprocessmanager from n_base
end type
end forward

global type n_cst_edishipmentprocessmanager from n_base
end type
global n_cst_edishipmentprocessmanager n_cst_edishipmentprocessmanager

type variables
Int		ii_ErrorCount
String	isa_Errors[]
n_cst_errorlog_manager inv_errorlogmanager
end variables

forward prototypes
private function integer of_getobjectlist (ref string asa_list[])
private function integer of_importversion3 (string as_pendingfolder, string as_processedfolder)
private function integer of_importversion4 (string as_pendingfolder, string as_processedfolder)
public function integer of_importpendingfiles ()
private function integer of_adderror (string as_error)
public function integer of_geterrors (ref string asa_errors[])
public function integer of_reseterrors ()
public function string of_geterrorstring ()
private function string of_appendtoprocessedlocationpath (string as_root)
private function integer of_getfiles (readonly string as_path, ref string asa_files[])
private function integer of_movefile (string as_filename, string as_source, string as_target)
private function integer of_autoacceptshipments ()
public function integer of_processpendingshipments ()
private function integer of_importversion1 (string as_pendingfolder, string as_processedfolder, long al_company)
private function integer of_importversion2 (string as_pendingfolder, string as_processedfolder, long al_coid)
public function integer of_recieveedifiles (long al_coid)
private function integer of_dirlist (oleobject anv_transport, ref string asa_files[], ref string asa_xmlfiles[])
private function integer of_processrecievedfile (oleobject anv_edidocument)
public function integer of_send997 (oleobject anv_ack997edidocument, long al_coid, string as_204file, long al_port, long al_timeout, string as_userid, string as_password, string as_address)
public function integer of_send997 (oleobject anv_ack997edidocument, long al_coid, string as_204file)
public function integer of_logerror (string as_category, string as_context, string as_message, integer ai_urgency, long ala_sourceids[], string as_remedy)
public function integer of_dirlist (n_cst_wininet_ftp anv_ftp, ref string asa_files[])
public function integer of_processpending214s ()
public function integer of_import204pending ()
public function integer of_import990pending ()
public function integer of_import997pending ()
public function integer of_import214pending ()
public function integer of_movetransactionfilestopending (long al_coid, string as_frompath)
public function integer of_import990 (string as_pendingfolder, string as_processedfolder)
public function integer of_import997 (string as_pendingfolder, string as_processedfolder)
public function integer of_import214 (string as_pendingfolder, string as_processedfolder)
end prototypes

private function integer of_getobjectlist (ref string asa_list[]);CONSTANT String	cs_manager_HubGroup = "Hubgroup"
CONSTANT String	cs_manager_CHRobinson_HW = "CHRobinson"
CONSTANT String	cs_manager_CHRobinson_Int = "CHRobinson_Int"
CONSTANT String	cs_manager_EverGreen = "evergreen"
CONSTANT String	cs_manager_Maersk = "maersk"
CONSTANT String	cs_manager_Tyson_Foods = "Tyson_Foods"
//CONSTANT String	cs_manager_apl= "apl"
CONSTANT String	cs_manager_Preferred= "Preferred"
CONSTANT String	cs_manager_JB_Hunt = "jb_hunt"
CONSTANT String	cs_manager_NYKLogistics = "nyklogistics"
CONSTANT String	cs_manager_OOCL = "OOCL"

Int	li_Count

li_Count ++
asa_List[li_Count] = cs_manager_Preferred

li_Count ++
asa_List[li_Count] = cs_manager_JB_Hunt

li_Count ++
asa_List[li_Count] = cs_manager_HubGroup

li_Count ++
asa_List[li_Count] = cs_manager_CHRobinson_HW

li_Count ++
asa_List[li_Count] = cs_manager_CHRobinson_int

li_Count ++
asa_List[li_Count] = cs_manager_EverGreen

li_Count ++
asa_List[li_Count] = cs_manager_Maersk

li_Count ++
asa_List[li_Count] = cs_manager_Tyson_Foods

li_Count ++
asa_List[li_Count] = cs_manager_NYKLogistics

li_Count ++
asa_List[li_Count] = cs_manager_OOCL

//li_Count ++
//asa_List[li_Count] =cs_manager_apl
//



RETURN li_Count
end function

private function integer of_importversion3 (string as_pendingfolder, string as_processedfolder);// Version 3 Direct with auto accept

String	ls_Target
Int		li_FileCount
Int		j
Int		li_Return = 1
String	ls_FileName
String	ls_errorString
String	ls_badfiles
String	ls_temp
String	ls_ImportDirectory
String	lsa_Files[]
Long		lla_sourceIds[]
N_cst_filesrvwin32	lnv_fileSrv
n_cst_edishipment_manager	lnv_EdiManager


lnv_EdiManager = CREATE n_cst_edishipment_manager
lnv_fileSrv = create N_cst_filesrvwin32

// get the location to move the spent import files to
ls_Target = as_Processedfolder
ls_ImportDirectory = as_Pendingfolder
ls_temp = left(ls_importDirectory, len(ls_importDIrectory) - 1)	//i had to strip off the last character because it was a "\".
//changes blabla/importDirectory/   into blabla/badfiles/importdirectory, which is the new target when a file cannot be imported successfully
ls_badfiles = left( ls_temp, lastPOS(ls_temp,"\")) + "Bad Files\"		
// get a list of all the files in the specified directory		
li_FileCount = THIS.of_GetFiles( ls_ImportDirectory , lsa_Files )
			
FOR j = 1 TO li_FileCount
	
	ls_FileName = lsa_Files[j]
	
	IF lnv_EDIManager.of_Import204filesintopending( ls_ImportDirectory + ls_FileName ) <> 1 THEN
		ls_errorString = lnv_ediManager.of_getErrorString()
		
		//DEK 5-14-07 made file so that it is moved into the badfiles folder.
		IF not DIRECTORYEXISTS(ls_badfiles) THEN
			lnv_fileSrv.of_createdirectory( ls_badfiles ) 
		END IF
		IF not DIRECTORYEXISTS( ls_badfiles + RIGHT( ls_temp, len( ls_temp ) - lastPos( ls_temp,"\" )  ) + "\"  ) THEN
			lnv_fileSrv.of_createdirectory( ls_badfiles + RIGHT( ls_temp, len( ls_temp ) - lastPos( ls_temp,"\" )  ) + "\" ) 
		END IF
		this.of_movefile( ls_fileName, ls_importDirectory, ls_badfiles + RIGHT( ls_temp, len( ls_temp ) - lastPos( ls_temp,"\" )  ) + "\")
		//This error string is set up so that the remedy will look at this string and open the file in this string.
		ls_errorString += "~r~nThe 204 file failed to be imported: " +ls_fileName+".~r~nClick trouble shoot to open in notepad.~r~nFILE::" + ls_badfiles + RIGHT( ls_temp, len( ls_temp ) - lastPos( ls_temp,"\" )  ) + "\"+ ls_fileName

		this.of_logerror( "EDI", "Import EDI Version 3", ls_errorString,1, lla_sourceIds, "n_cst_errorremedy_edi")
		//////////////////////////////////////////////////////////////////
		li_Return = -1
	ELSE
		THIS.of_Movefile( ls_FileName , ls_ImportDirectory, ls_Target )
	END IF

NEXT

DESTROY lnv_fileSrv
DESTROY ( lnv_EdiManager )

RETURN li_Return

end function

private function integer of_importversion4 (string as_pendingfolder, string as_processedfolder);// Version 4 Direct 
// DEK 5-14-07  **Made the file move to a bad files folder instead of the done folder when it fails to be imported.

String	ls_Target
Int		li_FileCount
Int		j
Int		li_Return = 1
String	ls_FileName
String	ls_errorString
String	ls_badfiles
String	ls_temp
String	ls_ImportDirectory

String	lsa_Files[]
Long		lla_sourceIds[]
n_cst_filesrvwin32 lnv_fileSrv
n_cst_edishipment_manager	lnv_EdiManager

lnv_EdiManager = CREATE n_cst_edishipment_manager
lnv_fileSrv = create n_cst_filesrvwin32
// get the location to move the spent import files to
ls_Target = as_Processedfolder
ls_ImportDirectory = as_Pendingfolder
ls_temp = left(ls_importDirectory, len(ls_importDIrectory) - 1)	//i had to strip off the last character because it was a "\".
//changes blabla/importDirectory/   into blabla/badfiles/importdirectory, which is the new target when a file cannot be imported successfully
ls_badfiles = left( ls_temp, lastPOS(ls_temp,"\")) + "Bad Files\"

// get a list of all the files in the specified directory		
li_FileCount = THIS.of_GetFiles( ls_ImportDirectory , lsa_Files )
			
			
FOR j = 1 TO li_FileCount
	
	ls_FileName = lsa_Files[j]
	
	IF lnv_EDIManager.of_Import204filesintopending( ls_ImportDirectory + ls_FileName ) <> 1 THEN
		THIS.of_AddError ( lnv_EdiManager.of_GetErrorString ( ) )
		ls_errorString = lnv_ediManager.of_getErrorString()
		
		//DEK 5-14-07 made file so that it is moved into the badfiles folder.
		IF not DIRECTORYEXISTS(ls_badfiles) THEN
			lnv_fileSrv.of_createdirectory( ls_badfiles ) 
		END IF
		IF not DIRECTORYEXISTS( ls_badfiles + RIGHT( ls_temp, len( ls_temp ) - lastPos( ls_temp,"\" )  ) + "\"  ) THEN
			lnv_fileSrv.of_createdirectory( ls_badfiles + RIGHT( ls_temp, len( ls_temp ) - lastPos( ls_temp,"\" )  ) + "\" ) 
		END IF
		this.of_movefile( ls_fileName, ls_importDirectory, ls_badfiles + RIGHT( ls_temp, len( ls_temp ) - lastPos( ls_temp,"\" )  ) + "\")
		//This error string is set up so that the remedy will look at this string and open the file in this string.
		ls_errorString += "~r~nThe 204 file failed to be imported: " +ls_fileName+".~r~nClick trouble shoot to open in notepad.~r~nFILE::" + ls_badfiles + RIGHT( ls_temp, len( ls_temp ) - lastPos( ls_temp,"\" )  ) + "\"+ ls_fileName

		this.of_logerror( "EDI", "Import EDI Version 4", ls_errorString,1, lla_sourceIds, "n_cst_errorremedy_edi")
		//////////////////////////////////////////////////////////////////
		li_Return = -1
	ELSE
		THIS.of_Movefile( ls_FileName , ls_ImportDirectory, ls_Target )
	END IF
				
NEXT
DESTROY lnv_fileSrv
DESTROY ( lnv_EdiManager )

RETURN li_Return
end function

public function integer of_importpendingfiles ();/*
	DEK:  This was redone on 3-9-07.
	
	First it loops through all the companies, and attempts to download all the edi files to the 
	correct locations.
	
	It then loops through all the companies again, and attempts to import the files into the PT
	database.
*/

// loop through all companies that have been set up to process 204s
// check the format to see if it is pseudo or direct.
// Determine the import format and process

Long		ll_Count
Long		i, ll_profileIndex
Long		ll_CoID
String	lsa_DownloadLocations[]
Int		li_Return = 1
Long		ll_inboundCount

String	ls_error
String	ls_value
String	ls_inbound
String	lsa_blank[]
String	lsa_remotePaths[]
n_cst_ftp_edi	lnv_ftp
n_cst_anyarraysrv	lnv_arraySrv
n_ds		lds_ediProfilesInbound
n_ds		lds_ediInboundCompanies

n_cst_licenseManager	lnv_manager
n_cst_setting_editransport 	lnv_setting


lnv_setting = CREATE n_cst_setting_editransport


//Import from profit tooLs?
ls_value = lnv_setting.of_getvalue( )		//added by dan
ls_inbound = appeon_constant.cs_transaction_INBOUND 
//attempt to download the edifiles from all the companies.
IF ls_value = "Yes" THEN
	lds_ediProfilesInbound = create n_ds
	lds_ediProfilesInbound.dataobject = "d_ediProfile_ds"
	lds_ediProfilesInbound.setTransobject(SQLCA)
	lds_ediProfilesInbound.retrieve()
	commit;

	//this contains a distinct list of companies with inbound edi transactions.
	lds_ediInboundCompanies = create n_ds
	lds_ediInboundCompanies.dataobject = "d_ediinboundcompanies"
	lds_ediInboundCompanies.settransobject( SQLCA )
	ll_inboundCount = lds_ediInboundCompanies.retrieve( )
	commit;
	
	lnv_ftp	= create n_cst_ftp_edi

	//loop through all the companies gathering all of the inbound paths for that company. And attempt to download
	//all the files from the paths.
	FOR i = 1 TO ll_inboundCount
		ll_coiD = lds_ediInboundCompanies.getItemNumber( i, "companyid" )
		//dek 4-9-07 changed filter so that inbound transactions with no scac will not attempt to download.
		lds_ediProfilesInbound.setFilter("companyid ="+string(ll_coid)+" and in_out ='"+ appeon_constant.cs_transaction_INBOUND +"' AND not isNull(scac)")
		lds_ediProfilesInbound.filter()
		ll_count = lds_ediProfilesInbound.rowcount( )
		lsa_remotePaths = lsa_blank
		//gets all the inbound paths for the company
		FOR ll_profileIndex = 1 TO ll_Count
			lsa_remotePaths[ll_profileIndex] = lds_ediProfilesInbound.getItemstring( ll_profileIndex,"remotepaths" )
		NEXT	
		
		//I don't want to take out nulls, nulls indicate we want to download files from the path we connected with.
		lnv_arraySrv.of_getshrinked( lsa_remotePaths , FALSE, true)
		ll_count = upperBound( lsa_remotePaths )
		//THis is stupid, I had it worked out that it would connect once and navigate around the hiearchy but 
		//because WININET SUCKS, I can't do more then one dirlist in a session.  So I cannot get a file listing
		//of more then one directory in a session, SO i have to loop and connect for every blasted folder I want
		//to connect to.
		FOR ll_profileIndex = 1 TO ll_count
			lnv_ftp.of_downloadedifrom( ll_coid, {lsa_remotePaths[ll_profileIndex]}, ls_error)
		NEXT	

		lsa_DownloadLocations[i] = lnv_ftp.of_getlastdownloadlocation( )
		
		//determine the trasaction types of the files, and move them into the correct pending locations.
		this.of_movetransactionfilestopending( ll_coid, lsa_DownloadLocations[i])
	NEXT
	
	destroy lnv_ftp
	destroy lds_ediInboundCompanies
	destroy lds_ediProfilesInbound
END IF

//IF PT doesn't handle the transport then all the files should already be in the correct locations for pending imports.
IF lnv_manager.of_hasedi204license( ) THEN
	this.of_import204pending( )
	this.of_import997pending( )
	this.of_import990pending( )
END IF

IF lnv_manager.of_hasedi214license( ) THEN
	this.of_import214pending( )
END IF

RETURN li_RETURN
/*  Commented out on 3-8-07

// loop through all companies that have been set up to process 204s
// check the format to see if it is pseudo or direct.
// Determine the import format and process

Long		ll_Count
Long		i
Long		ll_CoID
String	ls_CompanyName
String	ls_Pending
String	ls_Processed
String	ls_EDIVersion
Int		li_Return = 1
Boolean	lb_doPTImport
String	ls_value
String	ls_remotePath

n_cst_setting_editransport 	lnv_setting
n_cst_bso_ediManager  lnv_ShipmentManager

lnv_setting = CREATE n_cst_setting_editransport
lnv_shipmentManager = create n_cst_bso_ediManager

DataStore	lds_204Companies
lds_204Companies = CREATE DataStore
lds_204Companies.dataobject = "d_204companies"
lds_204Companies.SetTransObject ( SQLCA )

ll_Count = lds_204Companies.Retrieve( )
Commit;

//Import from profit tooLs?
ls_value = lnv_setting.of_getvalue( )		//added by dan


FOR i = 1 TO ll_Count
	ll_CoID = lds_204Companies.Object.edi204profile_CompanyID[i]
	ls_Pending = lds_204Companies.Object.edi204profile_PendingFiles[i]
	ls_Processed = lds_204Companies.Object.edi204profile_ProcessedFiles[i]
	ls_EDIVersion = lds_204Companies.Object.edi204profile_EdiVersion[i]

	//added By Dan 2-3-2006 to handle importing 204s with profit tools.
	//IF profit tools then branch off, otherwise do the rest of this stuff
	IF ls_value = "Yes" THEN
		ls_remotePath = lds_204Companies.Object.ediprofile_remotepaths[i]
		IF len( ls_remotePath ) > 0 THEN
			lb_doPTimport = true
		ELSE
			lb_doPTimport = false		//proceeds with old processing
		END IF
	ELSE
		lb_doPTimport = false			//proceeds with old processing
	END IF
	//----------------------------------------------------------------------
// undone 6-20-06**	IF NOT lb_doPTimport THEN
		IF isNull ( ls_EDIVersion ) THEN
			CONTINUE
		END IF
	
		Select co_name into :ls_CompanyName FROM Companies Where co_id = :ll_CoID;
		Commit;
		
		If isNull ( ls_Pending ) OR Len ( ls_Pending ) = 0 THEN	
			THIS.of_AddError( "Could not process EDI requests for " + ls_CompanyName + ". The 'Pending File' location has not been specified.")
			CONTINUE
		END IF
			
		If isNull ( ls_Processed ) OR Len ( ls_Processed ) = 0 THEN	
			THIS.of_AddError( "Could not process EDI requests for " + ls_CompanyName + ". The 'Processed File' location has not been specified.")
			CONTINUE
		END IF
		
		IF Right ( ls_Pending , 1 ) <> "\" THEN
			ls_Pending += "\"
		END IF
		
		ls_Processed = lnv_shipmentManager.of_appendtoprocessedlocationpath( ls_Processed )
		IF Right ( ls_Processed , 1 ) <> "\" THEN 	
			ls_Processed += "\" 
		END IF
	// end undone**END IF	
	
	CHOOSE CASE ls_EDIVersion
						
		CASE appeon_constant.cs_EDIVersion_Pseudo
			//added by dan 2-9-2006
			IF lb_doPTimport THEN				//if there was a specified path, reset it
				lb_doPTimport = false			//don't do the profit tools import, this version doesn't support it
			END IF
			//----------------------------------------------
			IF THIS.of_Importversion1( ls_Pending, ls_Processed ,ll_CoID) <> 1 THEN
				THIS.of_Adderror("All Files from " + ls_Pending + " could not be processed successfully" )
				li_Return = -1
			END IF
			
		CASE appeon_constant.cs_EDIVersion_VanMapping
			//added by dan 2-9-2006 to prevent profit tools from recieving files if it doesn't support the version
			IF lb_doPTimport THEN
				lb_doPTimport = false			//don't do the profit tools import, this version doesn't support it
			END IF
			//--------------------
			IF THIS.of_Importversion2( ls_Pending, ls_Processed ,ll_CoID) <> 1 THEN
				THIS.of_Adderror("All Files from " + ls_Pending + " could not be processed successfully" )
				li_Return = -1
			END IF
		CASE appeon_constant.cs_EDIVersion_DirectWithAutoReply
			//added condition by dan
			//do import
			IF lb_doPTImport THEN
				this.of_recieveedifiles( ll_coId )
			END IF
	// undone 6-20-2006**		IF NOT lb_doPTimport THEN
				IF THIS.of_Importversion3( ls_Pending, ls_Processed ) <> 1 THEN
					THIS.of_Adderror("All Files from " + ls_Pending + " could not be processed successfully" )
					li_Return = -1
				END IF
	// **end undone		END IF
		CASE appeon_constant.cs_EDIVersion_Direct
			//added condition by dan
			//do import
			//if a company isn't set up for PT to do the import, that doesn't mean a file isn't in the foler to be processed.
			IF lb_doPTImport THEN
				this.of_recieveedifiles( ll_coId )
			END IF
	// undone 6-20-2006		IF Not lb_doPTimport THEN
				IF THIS.of_Importversion4( ls_Pending, ls_Processed ) <> 1 THEN
					THIS.of_Adderror("All Files from " + ls_Pending + " could not be processed successfully" )
					li_Return = -1
				END IF
	// end undone		END IF
			
		CASE "" 
			lb_doPTimport = false
			// displayed as (NONE) is setup. can be used to turn off for specific company
		CASE ELSE
			lb_doPTimport = false			//added by dan
			THIS.of_Adderror( "An unexpected version of EDI was encountered.-" + ls_EDIVersion )
			li_Return = -1
			
	END CHOOSE

//  **undone 6-20-2006
	//Added by dan
//	IF lb_doPTimport THEN
//		IF this.of_recieveedifiles( ll_coId ) = -1 THEN
//			li_Return = -1			
//		END IF
//		this.of_processpendingshipments( )
//	END IF
	//--------------------------
NEXT

DESTROY ( lds_204Companies )
DESTROY lnv_setting
Destroy lnv_ShipmentManager
RETURN li_Return
*/

end function

private function integer of_adderror (string as_error);ii_errorcount ++
isa_errors[ii_errorcount] = as_error
RETURN 1
end function

public function integer of_geterrors (ref string asa_errors[]);asa_errors[] = isa_errors
RETURN ii_errorcount
end function

public function integer of_reseterrors ();String	lsa_Empty[]
isa_errors = lsa_Empty
ii_errorcount = 0
RETURN 1
end function

public function string of_geterrorstring ();String	ls_Return
Int	i

FOR i = ii_errorcount TO 1 STEP -1
	ls_Return += isa_errors[i] 
	IF i > 1  THEN
		ls_Return += "~r~n"
	END IF
NEXT

RETURN ls_Return
end function

private function string of_appendtoprocessedlocationpath (string as_root);n_cst_Settings	lnv_Settings
Any la_Result

Integer	li_Day

String	ls_Return, &
			ls_Week
			
n_cst_filesrvwin32	lnv_filesrv

SetNull ( ls_Return ) 


ls_Return = as_Root

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
	
RETURN	ls_Return
end function

private function integer of_getfiles (readonly string as_path, ref string asa_files[]);Int	li_FileCount
Int	i
String	lsa_Files[]
n_cst_dirattrib	lnva_DirAttribs[]
n_cst_filesrvwin32	lnv_FileSrv
lnv_FileSrv = CREATE n_cst_filesrvwin32

// get a list of all the files in the specified directory		
li_FileCount = lnv_FileSrv.of_dirlist ( as_path+"*.*", 39, lnva_DirAttribs )		
FOR i = 1 TO li_FileCount
	lsa_files[i] = lnva_DirAttribs[i].is_filename
NEXT

asa_files[] = lsa_Files
Destroy ( lnv_FileSrv )

RETURN li_FileCount

end function

private function integer of_movefile (string as_filename, string as_source, string as_target);String	ls_TargetFileName
Int		li_Return = 1
n_Cst_FileSrvWin32	lnv_FileSrv
lnv_FileSrv = CREATE n_cst_FileSrvwin32


IF FileExists ( as_target + as_filename ) THEN
	// we are going to add on the date and time to the file, otherwise we would not 
	// be able to move it, and that would cause problems.
	ls_TargetFileName = String ( Today () , "YYMMDD" ) + String (Now(),"HHMMSS" ) + "-" + as_FileName
	//229	is the lengh limit on file names. so...
	IF Len ( ls_TargetFileName ) >= 229 THEN 
			ls_TargetFileName = Left ( ls_TargetFileName , 229 )
	END IF
			
ELSE
	ls_TargetFileName = as_filename
END IF

IF lnv_FileSrv.of_FileRename ( as_Source + as_FileName , as_Target + ls_TargetFileName  ) <> 1 THEN
	li_Return = -1
	THIS.of_Adderror( "COULD NOT MOVE IMPORT FILE. " )
END IF

DESTROY ( lnv_FileSrv )

RETURN li_Return
end function

private function integer of_autoacceptshipments ();Int	li_Return = 1
n_cst_edishipmentreview lnv_EDIReview

lnv_EDIReview = CREATE n_Cst_EDIShipmentReview

IF lnv_EDIReview.of_Retrieveandacceptall( ) <> 1 THEN
	THIS.of_adderror( "Imported shipments could not be accepted." )
	li_Return = -1
END IF
Destroy ( lnv_EDIReview )

RETURN li_Return
end function

public function integer of_processpendingshipments ();Int		li_Return = 1
Long		ll_Count
Long		i
String	ls_ErrorMessage
String	ls_Object 
String	lsa_Objects[]

n_cst_EdiShipment_Manager	lnv_EDIManager

IF li_Return = 1 THEN
	
	ll_Count = THIS.of_getobjectlist( lsa_Objects )
	
END IF


IF li_Return = 1 THEN
	
	FOR i = 1 TO ll_Count
		
		ls_Object = lsa_Objects[i]

		lnv_EDIManager = CREATE using "n_cst_EdiShipment_Manager" + "_" + ls_object
		
	 	IF lnv_EDIManager.of_Processpendingshipments( ) <> 1 THEN	
			THIS.of_Adderror( "An error occurred while attempting to process EDI shipments from " + ls_object + "." )
			li_Return = -1
		END IF

		DESTROY ( lnv_EDIManager )
			
	NEXT
	
	// Process Generic	
	// this will process anything in the pending table that has not been flagged as processed yet
	
	lnv_EDIManager = CREATE n_cst_EdiShipment_Manager
	IF lnv_EDIManager.of_Processpendingshipments( ) <> 1 THEN		
		THIS.of_AddError ( "An error occurred while attempting to process EDI shipments." )
		li_Return = -1
	END IF
	DESTROY ( lnv_EdiManager )

END IF

IF THIS.of_autoacceptshipments( ) <> 1 THEN // processes edi version 3.0
	li_Return = -1
END IF		
	
RETURN li_Return

end function

private function integer of_importversion1 (string as_pendingfolder, string as_processedfolder, long al_company);// Version 1 Pseudo

/*
	DEK changed on 3-8-07 to add entries to the edi table with new column to specify that it is inbound.
*/
Long		i
Long		ll_Count
Int		li_FileCount
Int		j
String	ls_Target
String	ls_FileName
String	ls_ImportDirectory
String	ls_TargetFileName
String	lsa_Files[]
Int		li_Return = 1
String	ls_Message

n_cst_edi_204_Record	lnva_Records[]
n_cst_edi_Transaction_204	lnv_Edi_204
n_cst_ShipmentManager	lnv_ShipmentManager

lnv_Edi_204 = CREATE n_cst_edi_Transaction_204

// get the location to move the spent import files to
ls_Target = as_Processedfolder
ls_ImportDirectory = as_Pendingfolder
	
// get a list of all the files in the specified directory		
li_FileCount = THIS.of_getfiles( ls_ImportDirectory , lsa_Files )	
			
FOR j = 1 TO li_FileCount

	ls_FileName = lsa_Files[j]	

	lnv_Edi_204.of_ImportFile ( ls_ImportDirectory + ls_FileName )		
	ll_Count = lnv_Edi_204.of_GetRecords ( lnva_Records )
	FOR i = 1 TO ll_Count 
		IF lnv_ShipmentManager.of_Process204 ( lnva_Records[i] , al_company ) <> 1 THEN
			THIS.of_addError ( lnva_Records[i].of_geterrortext( ) ) 
			li_Return = -1
		END IF
		
		
		IF lnva_Records[i].of_GetSuccessfulImportFlag ( ) THEN
			ls_Message = "Shipment imported successfully"
		ELSE
			ls_Message = lnva_Records[i].of_GetErrorText ( )
		END IF
	
		lnv_Edi_204.of_addedientry( lnva_Records[i].of_GetShipmentID ( ) , String ( lnva_Records[i].of_GetShipmentID ( ) ) , al_company , ls_Message, appeon_constant.cs_transaction_INBOUND)
		
	NEXT
	
	// this adds its own errors
	THIS.of_Movefile( ls_FileName , ls_ImportDirectory , ls_Target  ) 
	
	//lnv_Edi_204.of_WriteErrorLog (  )
			
NEXT

DESTROY ( lnv_Edi_204 )

RETURN li_Return

end function

private function integer of_importversion2 (string as_pendingfolder, string as_processedfolder, long al_coid);// Version 2 Van Mapping
/*
	DEK changed on 3-8-07 to add edi entry with new column 'in_out' defaulted as inbound.
*/

Long		i
Long		ll_Count
Int		li_FileCount
Int		j
String	ls_Target
String	ls_FileName
String	ls_ImportDirectory
String	ls_TargetFileName
String	lsa_Files[]
Int		li_Return = 1
String	 ls_Message

n_cst_edi_204_Record	lnva_Records[]
n_cst_edi_Transaction_204	lnv_Edi_204
n_cst_ShipmentManager	lnv_ShipmentManager

lnv_Edi_204 = CREATE n_cst_edi_Transaction_204

// get the location to move the spent import files to
ls_Target = as_Processedfolder
ls_ImportDirectory = as_Pendingfolder
	
// get a list of all the files in the specified directory		
li_FileCount = THIS.of_getfiles( ls_ImportDirectory , lsa_Files )	
			
FOR j = 1 TO li_FileCount

	ls_FileName = lsa_Files[j]	

	lnv_Edi_204.of_ImportFile ( ls_ImportDirectory + ls_FileName )		
	ll_Count = lnv_Edi_204.of_GetRecords ( lnva_Records )
	FOR i = 1 TO ll_Count 
		IF lnv_ShipmentManager.of_Process204 ( lnva_Records[i] , al_CoID ) <> 1 THEN
			li_Return = -1
		END IF
		
		IF lnva_Records[i].of_GetSuccessfulImportFlag ( ) THEN
			ls_Message = "Shipment imported successfully"
		ELSE
			ls_Message = lnva_Records[i].of_GetErrorText ( )
		END IF
	
		lnv_Edi_204.of_addedientry( lnva_Records[i].of_GetShipmentID ( ) , String ( lnva_Records[i].of_GetShipmentID ( ) ) , al_CoID , ls_Message, appeon_constant.cs_transaction_INBOUND)
		
		
		
	NEXT
	
	// this adds its own errors
	THIS.of_Movefile( ls_FileName , ls_ImportDirectory , ls_Target  ) 
	//lnv_Edi_204.of_WriteErrorLog ( ls_ErrorMsg )
			
NEXT

DESTROY ( lnv_Edi_204 )

RETURN li_Return

end function

public function integer of_recieveedifiles (long al_coid);//Created By Dan 2-3-2006
//the following is meant to do the recieving of EDI files through profit tools rather than
//third party software.  It uses the FREDI objects.

//Fredi only supports the recieve() call through FTP set up of the FrediDocument


//RETURNS -1 if it tries to import a control number that already exists, (an error has been added)
Int 			li_rtn
Int		li_return
Int		li_res
Int		li_Rc
Int		li_deleteRemoteFile
Int		li_passiveTransfer

Long		ll_index
Long		ll_max
Long		ll_docIndex
Long	li_mode
Long	ll_port
Long	ll_timeout
Long	ll_rows
Long	ll_i
Long	ll_rows2
Long	lla_sourceIds[]

String	ls_userId
String	ls_password
String	ls_protocol
String	ls_address
String	ls_value
String	ls_targetPath
String	ls_fileFormat
String	ls_204SefFile
String	ls_companyName
String	ls_204path
String	ls_204ProcessedPath
String	ls_204FileName
String	ls_extension

String	lsa_files[]
String	lsa_xmlFiles[]

n_cst_errorlog		lnv_error
n_cst_errorlog_manager	lnv_errorlogmanager
n_cst_wininet_ftp	lnv_ftp

n_cst_EdiShipment_Manager	lnv_EDIMShipmentanager

N_cst_setting_edi204SefPath lnv_setting
N_CST_bso_ediManager lnv_EDImanager

OleObject	lnv_filesystem
OleObject	lnv_file

OleObject	lnv_ediDocument
OleObject   lnv_transports
OleObject	lnv_transport
OleObject	lnv_tempEdiDocument
OleObject	lnv_ftpConfig			//used to set passive mode

OleObject	lnv_tmpTransports
OleObject	lnv_tmpTransport
OleObject	lnv_xmlDocument

OleObject	lnv_schemas
OleObject	lnv_schama

OleObject	lnv_ack997Document

Datastore	lds_transportSettings
Datastore	lds_transactionPaths
Datastore	lds_204CompanySettings

lnv_ediManager = create n_cst_bso_ediManager

lds_transportSettings = CREATE datastore
lds_transportSettings.dataobject = "d_transportsettings"
lds_transportSettings.setTransobject( SQLCA )

lds_transactionPaths = CREATE datastore
lds_transactionPaths.dataobject = "d_transactionpaths"
lds_transactionPaths.settransobject( SQLCA )

lds_204CompanySettings = CREATE datastore
lds_204CompanySettings.dataobject = "d_204companysettings"
lds_204CompanySettings.setTransobject( SQLCA )

lnv_setting = CREATE n_cst_setting_edi204SefPath

lnv_errorlogmanager = create n_cst_errorlog_manager
ls_204SefFile = lnv_setting.of_getValue()

ll_index = lds_transportSettings.Retrieve( al_coId )		//should be 1 row
commit;
ll_rows = lds_transactionPaths.retrieve( al_coid )
commit;
ll_rows2 = lds_204CompanySettings.retrieve( al_coid )
commit;


lnv_EDIMShipmentanager =create n_cst_EdiShipment_Manager	//used to create 997	


Select co_name into :ls_CompanyName FROM Companies Where co_id = :al_CoID;
		Commit;
		
lnv_ftp = create n_cst_wininet_ftp
IF ll_rows2 > 0 THEN
	ls_204path = lds_204CompanySettings.getItemString( ll_rows2, "edi204profile_pendingfiles")
	ls_204ProcessedPath = lds_204CompanySettings.getItemString( ll_rows2, "edi204profile_processedfiles")
END IF
		
//gets 204 and 997 paths and other properties
FOR ll_i = 1 TO ll_rows 
	IF lds_transactionPaths.getItemNumber( ll_i, "transactionset") = 204 THEN
		ls_targetPath = lds_transactionPaths.getItemstring( ll_i, "remotepaths" )
		li_deleteRemoteFile = lds_transactionPaths.getItemNumber( ll_i, "deleteremotely" )
	ELSEIF lds_transactionPaths.getItemNumber( ll_i, "transactionset") = 997 THEN
		ls_fileFormat = lds_transactionPaths.getItemstring( ll_i, "fileformat" )
	END IF
NEXT

lnv_ediDocument = create OLEOBJECT

IF lnv_ediDocument.ConnectToNewObject ( "Fredi.ediDocument" ) = 0 THEN
	li_rtn = 1 
ELSE
	THIS.of_AddError( "Could not process EDI requests for " + ls_CompanyName + ". Profit Tools doesn't have FREDI component.")
	lnv_error = CREATE n_cst_errorlog	
	lnv_error.of_setlogdata( "EDI", "Profit Tools EDI Transport",  String(Today(), "m/d/yy hh:mm")+" Could not process EDI requests for " + ls_CompanyName + ". Profit Tools doesn't have FREDI component.", 1, lla_sourceIds[], "n_cst_errorremedy")
	lnv_errorLogManager.of_logerror( lnv_error )
	Destroy lnv_error	
	li_rtn = -1
END IF

IF li_rtn = 1 THEN
	lnv_transports = lnv_ediDocument.GetTransports()
	
	//create transport for looking at edi files at the getLocation
	lnv_transport = lnv_transports.createTransport()
	
	li_mode = lds_transportSettings.getItemNumber( ll_index, "mode_text" )
	ll_port = lds_transportSettings.getItemNumber( ll_index, "port" )
	ll_timeout = lds_transportSettings.getItemNumber( ll_index, "timeout" )
	ls_userId = lds_transportSettings.getItemString( ll_index, "userid" )
	ls_password = lds_transportSettings.getItemString( ll_index, "password" )
	ls_protocol = lds_transportSettings.getItemString( ll_index, "protocol" )
	ls_address = lds_transportSettings.getItemString( ll_index, "address" )
	li_passiveTransfer = lds_transportSettings.getItemNumber( ll_index, "passive_transfer" )
	
	lnv_schemas = lnv_ediDocument.getschemas( )
	
	IF FileExists( ls_204SefFile ) THEN
		lnv_schama = lnv_ediDocument.importSchema( ls_204SefFile, 0 ) 
	END IF
	
	// Set required parameters for the download.
	//FTP
	CHOOSE CASE ls_protocol
		CASE "FTP"
			li_rtn = lnv_transport.setFTP()
			IF li_rtn = 1 THEN
				lnv_transport.Address = ls_address
				lnv_transport.Password = ls_password
				lnv_transport.User = ls_userId
				lnv_transport.serverport = ll_port
				lnv_transport.timeout = ll_timeout				//seconds
				IF not Isnull( ls_targetPath ) THEN
					lnv_transport.TargetPath = ls_targetPath
				END IF
				
				IF li_passiveTransfer = 1 THEN
					lnv_ftpConfig = lnv_transport.GetFtpCfg()
					IF isValid( lnv_ftpConfig ) THEN
						lnv_ftpConfig.EnablePassive = true
					ELSE
						this.of_logerror( "EDI", "Recieve EDI File", "Couldn't set passive mode for company "+ls_CompanyName+".  Attempting download in active mode. ", 2, lla_sourceIds , "n_cst_errorremedy")
					END IF
				END IF
			END IF
			
			IF li_rtn = 1 THEN
				
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
						IF not Isnull( ls_targetPath ) THEN
							IF lnv_ftp.of_changedirectory( ls_targetPath ) = 1 THEN					
								try
									li_rtn = this.of_dirlist( lnv_ftp, lsa_files )
									//li_rtn = this.of_dirList( lnv_transport, lsa_files, lsa_xmlFiles )
									
								Catch( oleruntimeerror olerr)
									this.of_logerror( "EDI", "Receive EDI Files",  String(Today(), "m/d/yy hh:mm")+" Could not process EDI requests for " + ls_CompanyName + ". Couldn't change directory olerr: " + olerr.getMessage() , 1, lla_sourceIds[], "n_cst_errorremedy")
									DESTROY olerr
									li_Rtn = -1				
								END TRY
							ELSE
								//directory path not valid
								li_rtn = -1
								lnv_error = CREATE n_cst_errorlog	
								lnv_error.of_setlogdata( "EDI", "Recieve Edi Files",  String(Today(), "m/d/yy hh:mm")+" The get path for " + ls_CompanyName + " does not appear to be valid. Verify the path name and try again.", 1, lla_sourceIds[], "n_cst_errorremedy")
								lnv_errorLogManager.of_logerror( lnv_error )
								Destroy lnv_error
							END IF
						ELSE
							try	
								li_rtn = this.of_dirlist( lnv_ftp, lsa_files )
								//li_rtn = this.of_dirList( lnv_transport, lsa_files, lsa_xmlFiles )
								DESTROY lnv_ftp
							Catch( oleruntimeerror olerr2)
								this.of_logerror( "EDI", "Receive EDI Files",  String(Today(), "m/d/yy hh:mm")+" Could not process EDI requests for " + ls_CompanyName + ".~r~nCouldn't change directory olerr: ~r~n" + olerr2.getMessage() , 1, lla_sourceIds[], "n_cst_errorremedy")
								DESTROY olerr2
								li_Rtn = -1					
							END TRY
						END IF
					ELSE
						//couldn't connect to server
						li_rtn = -1
						lnv_error = CREATE n_cst_errorlog	
						lnv_error.of_setlogdata( "EDI", "Recieve Edi Files",  String(Today(), "m/d/yy hh:mm")+" Could not connect to specified server for " + ls_CompanyName + ". Verify server address, user name, and password.", 1, lla_sourceIds[], "n_cst_errorremedy")
						lnv_errorLogManager.of_logerror( lnv_error )
						Destroy lnv_error
					END IF
				ELSE
					//couldnt' connect to the internet
					li_rtn = -1
					lnv_error = CREATE n_cst_errorlog	
					lnv_error.of_setlogdata( "EDI", "Receive Edi Files",  String(Today(), "m/d/yy hh:mm")+" Could not connect to the Internet. Verify your Internet connect and try again.", 1, lla_sourceIds[], "n_cst_errorremedy")
					lnv_errorLogManager.of_logerror( lnv_error )
					Destroy lnv_error
				END IF
			ELSE
				THIS.of_AddError( "Could not process EDI requests for " + ls_CompanyName + ". FTP Transport failed to be initialized through Profit Tools.")	
				lnv_error = CREATE n_cst_errorlog	
				lnv_error.of_setlogdata( "EDI", "Profit Tools EDI Transport",  String(Today(), "m/d/yy hh:mm")+" Could not process EDI requests for " + ls_CompanyName + ". FTP Transport failed to be initialized through Profit Tools.", 1, lla_sourceIds[], "n_cst_errorremedy")
				lnv_errorLogManager.of_logerror( lnv_error )
				Destroy lnv_error
			END IF
			
			//I have a listing of the files that need to be imported.  
			//For each one, I have to import it, and then add it to the database.
			IF li_rtn = 1 THEN
				ll_max = upperBound( lsa_files )
				//edi documents
				FOR ll_index = 1 TO ll_max
					//set up a bunch of edi documents and recieve the corresponding files.
					//Process the each file one by one just incase one of them fails. Then we would be
					//"Foo Barred"
					lnv_tempEdiDocument = create OleObject
					IF lnv_tempEdiDocument.connectToNewObject ( "Fredi.ediDocument" ) = 0 THEN
						destroy lnv_schemas
						lnv_schemas = lnv_tempediDocument.getschemas( )
						
						IF FileExists( ls_204SefFile ) THEN
							destroy lnv_schama
							lnv_schama = lnv_tempediDocument.importSchema(ls_204SefFile, 0) 
						END IF
						
						lnv_tmpTransports = lnv_tempEdiDocument.getTransports( ) //lnva_ediDocuments[ll_docIndex].getTransports( )
						lnv_tmpTransport = lnv_tmpTransports.createTransport( )
						
						li_rtn = lnv_tmpTransport.setFtp()
						IF li_rtn = 1 THEN
							lnv_tmpTransport.Address = ls_address
							lnv_tmpTransport.Password = ls_password
							lnv_tmpTransport.User = ls_userId
							lnv_tmpTransport.serverport = ll_port
							lnv_tmpTransport.timeout = ll_timeout				//seconds
							lnv_tmpTransport.TargetPath = ls_targetPath
							
							//added 10-4-2006 to enable passive transfer
							IF li_passiveTransfer = 1 THEN				
								DESTROY lnv_ftpconfig		//destroy the last one
								lnv_ftpConfig = lnv_tmptransport.GetFtpCfg()
								IF isValid( lnv_ftpConfig ) THEN
									lnv_ftpConfig.EnablePassive = true
								ELSE
									this.of_logerror( "EDI", "Recieve EDI File", "Couldn't set passive mode for company "+ls_CompanyName+".  Attempting download in active mode. ", 2, lla_sourceIds , "n_cst_errorremedy")
								END IF
							END IF
						ELSE
							li_rtn = -1
							THIS.of_AddError( "Could not process EDI requests for " + ls_CompanyName + ". Error setting up FTP transport for recieving 204s. File: "+lsa_files[ll_index])
							li_return = -1
						END IF
						
						IF li_rtn = 1 THEN					
							//gets the name after the location of the filepath
							ls_204FileName = right( lsa_files[ll_index], len(lsa_files[ll_index]) - lastPOS(lsa_files[ll_index], "\") )			
							try
								li_rtn = lnv_tmpTransport.receiveFile(lsa_files[ll_index], ls_204path+"\"+ ls_204FileName )
							catch( oleruntimeerror olerr3)
							li_rtn = -1
								this.of_logerror( "EDI", "Recieve EDI Files",  String(Today(), "m/d/yy hh:mm")+" Could not process EDI request for " + ls_CompanyName + ". Error attempting to recieve file: "+ ls_204FileName+"." + olerr3.getMessage() , 1, lla_sourceIds[], "n_cst_errorremedy")
								destroy olerr3
							END TRY
							//this stuff tests the types of the files that were downloaded.
							//if the file is an edi file then we keep it otherwise we delete the download
							
							IF li_rtn = 1 THEN
								lnv_fileSystem = lnv_tempEdiDocument.getFileSystem()
								lnv_file = lnv_filesystem.getFile( ls_204path+"\"+ ls_204FileName )
								IF lnv_file.isAscX12() THEN
									li_rtn = lnv_tempEdiDocument.loadEdi(ls_204path+"\"+ ls_204FileName)
									IF li_rtn = 1 THEN
										//ok
									ELSE
										THIS.of_AddError( "Could not load downloaded edi file for " + ls_CompanyName + ". File location: "+ls_204path+"\"+ ls_204FileName)
										lnv_error = CREATE n_cst_errorlog		
										lnv_error.of_setlogdata( "EDI", "Load Fredi Object", String(Today(), "m/d/yy hh:mm")+" Could not load downloaded edi file for " + ls_CompanyName + ". File location: "+ls_204path+"\"+ ls_204FileName, 1, lla_sourceIds[], "n_cst_errorremedy")	
										lnv_errorLogManager.of_logerror( lnv_error )
										Destroy lnv_error
										li_return = -1
									END IF
								ELSEIF lnv_file.IsXml() THEN
									//probably won't be supported
								ELSE
									FileDelete(ls_204path+"\"+ ls_204FileName)
									li_rtn = -1
								END IF
								destroy lnv_file
								destroy lnv_fileSystem
							ELSE
								//error recieving edi file
								THIS.of_AddError( "Could not process EDI requests for " + ls_CompanyName + ". Error recieving file: "+lsa_files[ll_index]+".")
								lnv_error = CREATE n_cst_errorlog	
								lnv_error.of_setlogdata( "EDI", "Recieve EDI File", String(Today(), "m/d/yy hh:mm")+" Could not process EDI requests for " + ls_CompanyName + ". Error recieving file: "+lsa_files[ll_index]+".", 1, lla_sourceIds[], "n_cst_errorremedy")						
								lnv_errorLogManager.of_logerror( lnv_error )
								Destroy lnv_error
								li_return = -1
							END IF
						END IF
						
						IF li_rtn = 1 THEN	
							IF li_deleteRemoteFile > 0 THEN
								lnv_tmpTransport.DeleteRemoteFile( lsa_files[ll_index] )
							END IF	
							//I am done with this file at this point						
							lnv_tempEdiDocument.disconnectobject( )
						END IF				
						destroy lnv_tmpTransports
						destroy lnv_tmpTransport
					END IF					
					DESTROY lnv_ftpConfig
					Destroy lnv_tempEdiDocument
				NEXT
			END IF
	END CHOOSE
	DESTROY lnv_transport
	DESTROY lnv_transports
	lnv_ediDocument.disconnectobject( )
END IF

destroy	lnv_EDIMShipmentanager
Destroy lds_transactionPaths
Destroy lds_transportSettings
DESTROY lnv_ediDocument
Destroy lnv_setting
Destroy lds_204CompanySettings
Destroy lnv_EDImanager

DESTROY lnv_ftpConfig
destroy lnv_schemas
destroy lnv_schama

IF isValid( lnv_ftp)THEN
	DESTROY lnv_ftp
END IF
IF isValid( lnv_errorlogmanager ) THEN
 	DESTROY lnv_errorlogmanager
END IF
return li_return
end function

private function integer of_dirlist (oleobject anv_transport, ref string asa_files[], ref string asa_xmlfiles[]);/*
	DEK:
	Problem with this function, for unknown reasons the getDirectory function on the freddi
	object fails from time to time.  It will sit on it for about 15 seconds before it disconnects
	from the server without actually sending a list command accross.  The connect and everything
	seems fine when looking at the network traffic.
*/

//created By dan 2-3-2006 to return a list of all the files to be recieved.
//assumes transport object was already set up

//only works if its set up for FTP transport - restriction on FREDI object

Oleobject	lnv_edifiles
Oleobject	lnv_edifile
Int	li_return
Long	ll_index
Long	ll_max

String	ls_fileName
String	lsa_files[]
String	lsa_xmlFiles[]


li_return  = 1
IF isValid( anv_transport ) THEN
	//gets all files in the specified targetpath
   try
		lnv_ediFiles = anv_transport.GetDirectory()
	Catch( oleruntimeerror olerr)
		throw olerr
		li_return = -1
	END TRY
	
	IF li_return = 1 THEN
		ll_max = lnv_ediFiles.count
		
		FOR ll_index = 1 TO ll_max
			lnv_ediFile = lnv_ediFiles.getFileByIndex( ll_index )
			IF isValid( lnv_ediFile ) THEN
				//if its an edi file we want it, there is a third option im not sure if we want to include, unEdiFact
				ls_fileName = lnv_ediFile.FullPathName	
				IF not lnv_ediFile.isFolder() THEN
					lsa_files[upperBound(lsa_files)+ 1] = lnv_ediFile.FullPathName	
				END IF
			END IF
		NEXT
		destroy lnv_ediFiles
	END IF
ELSE
	li_return  = -1
END IF

asa_files = lsa_files
asa_xmlfiles = lsa_xmlFiles



RETURN li_return
end function

private function integer of_processrecievedfile (oleobject anv_edidocument);//Created By dan 2-3-2006
//the following is meant to take an already set up edi document and put it in the database
Int	li_return
Int	li_transControlNum
Boolean		lb_startCopying
Boolean		lb_stopCopying
String		ls_ediString
String		ls_SendersCode
Long			ll_groupControlNumber

Oleobject	lnv_segment




li_return = 1
IF isValid( anv_edidocument ) THEN
	
	//loop through all datasegments in the document that was recieved and 
	//create a string of everything between the ST(inclusive) and THe GE(not inclusive ).
	
	lnv_segment = anv_ediDocument.firstDataSegment
	
	IF isValid( lnv_segment ) THEN
		ls_sendersCode = trim( lnv_segment.DataElementValue(6) )
		ll_groupControlNumber = long( lnv_segment.dataElementValue(13) )
	END IF
	
	DO WHILE isValid( lnv_segment ) AND not lb_stopCopying
		IF lower(string(lnv_segment.ID)) = "st" THEN
			lb_startCopying = true
			li_transControlNum ++		//another shipment
		END IF
		
		IF lower(string(lnv_segment.ID)) = "se" THEN
			lb_stopCopying = true
			ls_ediString += lnv_segment.segmentBuffer     //gets the last line
		END IF
		
		IF lb_startCopying AND NOT lb_stopCopying THEN
			ls_ediString += lnv_segment.segmentBuffer +"~r~n"
		ELSEIF lb_stopCopying THEN
			//we have completed a shipment string
			
			//update the database with the new shipment.
			INSERT INTO "importedshipments"  
				( "senderscode",   
				  "groupcontrolnumber",   
				  "transactioncontrolnumber",              
				  "filecontents",
				  "processed")  
			 VALUES ( :ls_SendersCode ,   
				  :ll_groupControlNumber ,   
				  :li_transControlNum,         
				  :ls_ediString ,
				  0)  ;
	
			IF SQLCA.sqlcode <> 0 THEN
				RollBack;
				li_Return = -1  // most likely that the shipment already exists. (could not move the import file and is being processes again)
			ELSE
				Commit;
				
			END IF
			
			
			ls_ediString = ""		//clears the string
			lb_stopCopying = false
		END IF
		
		//gets teh next segment
		lnv_segment = anv_ediDocument.nextDataSegment
		
		//we drop out of the loop if its ge
		IF lower(string(lnv_segment.ID)) = "ge" THEN
			lb_stopCopying = true
		END IF
	LOOP
ELSE
	li_return = -1
END IF




Return li_return

end function

public function integer of_send997 (oleobject anv_ack997edidocument, long al_coid, string as_204file, long al_port, long al_timeout, string as_userid, string as_password, string as_address);//Created By Dan 2-8-2006
//this version was written because the scheduler picks up all of the 204s at once, and
//the calling function already knows all of the transport information.  Since it already
//knows the transport information, we shouldn't have to retrieve it for every 204 the
//company sends.  IF the transport information isn't already known, then call the other
//version of this function.
Int	li_rtn
Int	li_res
Long	ll_i
Long	ll_rows

Long	ll_port
Long	ll_timeout

String	ls_userId
String	ls_password
String	ls_protocol
String	ls_address

String	ls_companyName
String	ls_putPath
String	ls_204SefFile
String	ls_targetPath
String	ls_997Folder
String	ls_fileFormat
String	ls_extension
String	ls_template

String	ls_ackFile

Oleobject	lnv_ackTransports
OleObject	lnv_ack997Document
OleObject	lnv_ackTransport

N_cst_bso_ediManager  lnv_manager 
N_cst_setting_edi204SefPath lnv_setting
Datastore	lds_transactionPaths

IF isValid( anv_ack997edidocument ) THEN
	li_rtn = 1
ELSE
	li_rtn = -1
END IF

IF li_rtn = 1 THEN

	lnv_manager = create N_cst_bso_ediManager
	
	lds_transactionPaths = CREATE datastore
	lds_transactionPaths.dataobject = "d_transactionpaths"
	lds_transactionPaths.settransobject( SQLCA )
	
	ll_rows = lds_transactionPaths.retrieve( al_coid )
	commit;
	
	Select co_name into :ls_CompanyName FROM Companies Where co_id = :al_CoID;
			Commit;
			
	Select template into :ls_template FROM ediprofile Where companyid =:al_CoID AND transactionset = 997;
			COMMIT;
			
	IF len(ls_template) > 0 AND LastPos(ls_template, ".") > LastPos(ls_template, "\") THEN
		ls_extension = RIGHT( ls_template, len(ls_template) - (LastPos(ls_template,".")-1) )
	ELSE
		ls_extension = ".txt"
	END IF
	lnv_setting = CREATE n_cst_setting_edi204SefPath
	
	ls_204SefFile = lnv_setting.of_getValue()		
	lnv_ack997Document = anv_ack997edidocument
	
	//gets 204 and 997 paths and other properties
	FOR ll_i = 1 TO ll_rows 
		IF lds_transactionPaths.getItemNumber( ll_i, "transactionset") = 204 THEN
			ls_targetPath = lds_transactionPaths.getItemstring( ll_i, "remotepaths" )
		ELSEIF lds_transactionPaths.getItemNumber( ll_i, "transactionset") = 997 THEN
			ls_putPath = lds_transactionPaths.getItemstring( ll_i, "remotepaths" )
			ls_fileFormat = lds_transactionPaths.getItemstring( ll_i, "fileformat" )
			ls_997Folder = lds_transactionPaths.getItemString( ll_i, "folder" )
		END IF
	NEXT
	
	
	ll_port = al_port
	ll_timeout = al_timeout
	ls_userId = as_userid
	ls_password = as_password
	ls_address = as_address
	
	lnv_ackTransports = lnv_ack997Document.Get997Transport( )
	
	//Send 997 Acknowledgment using FTP
	
	lnv_ackTransport = lnv_ackTransports.CreateTransport
	li_rtn = lnv_ackTransport.SetFTP( ) 
	IF li_rtn = 1 THEN
		lnv_ackTransport.Address = ls_address
		lnv_ackTransport.Password = ls_password
		lnv_ackTransport.User = ls_userId
		lnv_ackTransport.TargetPath = ls_putPath
	
		ls_ackFile = lnv_manager.of_getcontrolnumber( )+ls_extension
	
		li_rtn = lnv_ackTransport.Send( ls_ackFile )
		IF li_rtn <> 1 THEN
			THIS.of_AddError( "Could not acknowledge recieved file: "+as_204File+" for "+ ls_CompanyName + ". Error while sending 997. File: "+ ls_ackFile )
		END IF
	ELSE
		THIS.of_AddError( "Could not acknowledge recieved file: "+as_204File+" for "+ ls_CompanyName + ". Error setting up FTP transport for sending 997. File: "+ ls_ackFile )
	END IF
	
	//we need to save the file that we failed to send somewhere.
	IF li_rtn <> 1 THEN
		IF DirectoryExists( ls_997Folder ) THEN
			ls_997Folder +="\" +ls_ackFile
			li_res = lnv_ack997Document.save( ls_997Folder )
		ELSE
			THIS.of_AddError( "Specified path for 997s doesn't exist for "+ ls_CompanyName + ".")
			IF NOT DirectoryExists( "C:\Failed Edi Acknowledgements" ) THEN
				CreateDirectory( "C:\Failed Edi Acknowledgements" )
			END IF
			ls_997Folder = "C:\Failed Edi Acknowledgements\"+ ls_ackFile
			li_res = lnv_ack997Document.save( ls_997Folder )
			IF li_res = 1 THEN
				THIS.of_AddError( "Failed Acknowledgement for file: "+as_204File+" for company " +ls_CompanyName + " saved to path: "+ls_997Folder+".")
			END IF
		END IF
		
		IF li_res = 1 THEN
			THIS.of_AddError( "File: "+as_204File+ " for " +ls_CompanyName + " saved to location "+ ls_997Folder+ ".")
		ELSE
			THIS.of_AddError( "File: "+as_204File+ " for " +ls_CompanyName + " couldn't be sent nor saved.  The file is lost. ")
		END IF
	END IF
	
	Destroy lnv_manager
	Destroy lds_transactionPaths
	Destroy lnv_setting
END IF
RETURN li_rtn
end function

public function integer of_send997 (oleobject anv_ack997edidocument, long al_coid, string as_204file);//Created By Dan 2-8-2006  
//This version is intended to be used if the transport information for the company isn't
//already known.  It gets the information and calls the other version.

Int 	li_return
Long	ll_index

Int	li_mode
Long	ll_port
Long	ll_timeout

String	ls_userId
String	ls_password
String	ls_protocol
String	ls_address

Datastore	lds_transportSettings

lds_transportSettings = CREATE datastore
lds_transportSettings.dataobject = "d_transportsettings"
lds_transportSettings.setTransobject( SQLCA )

ll_index = lds_transportSettings.Retrieve( al_coId )		//should be 1 row
commit;

li_mode = lds_transportSettings.getItemNumber( ll_index, "mode" )
ll_port = lds_transportSettings.getItemNumber( ll_index, "port" )
ll_timeout = lds_transportSettings.getItemNumber( ll_index, "timeout" )
ls_userId = lds_transportSettings.getItemString( ll_index, "userid" )
ls_password = lds_transportSettings.getItemString( ll_index, "password" )
ls_protocol = lds_transportSettings.getItemString( ll_index, "protocol" )
ls_address = lds_transportSettings.getItemString( ll_index, "address" )

li_return = this.of_send997( anv_ack997EdiDocument, al_coid,as_204File, ll_port, ll_timeout, ls_userId, ls_password, ls_address )

Destroy  lds_transportSettings
RETURN li_return
end function

public function integer of_logerror (string as_category, string as_context, string as_message, integer ai_urgency, long ala_sourceids[], string as_remedy);
n_cst_errorlog lnv_error

IF NOT isValid( inv_errorlogmanager ) THEN
	inv_errorlogmanager = create n_cst_errorlog_manager
END IF


lnv_error = CREATE n_cst_errorlog	

lnv_error.of_setlogdata( as_category, as_context , String(Today(), "m/d/yy hh:mm")+" "+as_message, ai_urgency, ala_sourceIds, as_remedy)

inv_errorlogManager.of_logerror( lnv_error )
Destroy lnv_error

RETURN 1	
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
		//IF anv_ftp.of_fileexist( lsa_files[ll_index] ) THEN
			lsa_existingFiles[upperBound(lsa_existingFiles)+ 1] = lsa_files[ll_index]
		//END IF
	NEXT
ELSE
	li_RETURN = -1
END IF

asa_files = lsa_existingfiles
RETURN li_RETURN 


end function

public function integer of_processpending214s ();/*
	DEK: Created 3-14-07
	
	Returns 1 if the update succeeds, -1 if it fails
*/
Int	li_return = 1

n_cst_ediexportshipmentmanager lnv_exportmanager

lnv_exportmanager = create n_cst_ediexportshipmentmanager

li_return = lnv_exportmanager.of_214eventlogic( )

DESTROY lnv_exportmanager
RETURN li_Return
end function

public function integer of_import204pending ();/*
	DEK: This functionality was moved from of_importPendingFiles() 3/9/07.  The part where it goes out 
	to download edi from the site is stripped out and done in a different task as well.
*/


// loop through all companies that have been set up to process 204s
// check the format to see if it is pseudo or direct.
// Determine the import format and process

Long		ll_Count
Long		i
Long		ll_CoID
String	ls_CompanyName
String	ls_Pending
String	ls_Processed
String	ls_EDIVersion
Int		li_Return = 1

String	ls_value
String	ls_remotePath

n_cst_setting_editransport 	lnv_setting
n_cst_bso_ediManager  lnv_ShipmentManager

lnv_setting = CREATE n_cst_setting_editransport
lnv_shipmentManager = create n_cst_bso_ediManager

DataStore	lds_204Companies
lds_204Companies = CREATE DataStore
lds_204Companies.dataobject = "d_204companies"
lds_204Companies.SetTransObject ( SQLCA )

ll_Count = lds_204Companies.Retrieve( )
Commit;

//Import from profit tooLs?
ls_value = lnv_setting.of_getvalue( )		//added by dan


FOR i = 1 TO ll_Count
	ll_CoID = lds_204Companies.Object.edi204profile_CompanyID[i]
	ls_Pending = lds_204Companies.Object.edi204profile_PendingFiles[i]
	ls_Processed = lds_204Companies.Object.edi204profile_ProcessedFiles[i]
	ls_EDIVersion = lds_204Companies.Object.edi204profile_EdiVersion[i]

	IF isNull ( ls_EDIVersion ) THEN
		CONTINUE
	END IF

	Select co_name into :ls_CompanyName FROM Companies Where co_id = :ll_CoID;
	Commit;
	
	If isNull ( ls_Pending ) OR Len ( ls_Pending ) = 0 THEN	
		THIS.of_AddError( "Could not process EDI requests for " + ls_CompanyName + ". The 'Pending File' location has not been specified.")
		CONTINUE
	END IF
		
	If isNull ( ls_Processed ) OR Len ( ls_Processed ) = 0 THEN	
		THIS.of_AddError( "Could not process EDI requests for " + ls_CompanyName + ". The 'Processed File' location has not been specified.")
		CONTINUE
	END IF
	
	IF Right ( ls_Pending , 1 ) <> "\" THEN
		ls_Pending += "\"
	END IF
	
	ls_Processed = lnv_shipmentManager.of_appendtoprocessedlocationpath( ls_Processed )
	IF Right ( ls_Processed , 1 ) <> "\" THEN 	
		ls_Processed += "\" 
	END IF

	
	CHOOSE CASE ls_EDIVersion
						
		CASE appeon_constant.cs_EDIVersion_Pseudo

			IF THIS.of_Importversion1( ls_Pending, ls_Processed ,ll_CoID) <> 1 THEN
				THIS.of_Adderror("All Files from " + ls_Pending + " could not be processed successfully" )
				li_Return = -1
			END IF
			
		CASE appeon_constant.cs_EDIVersion_VanMapping
	
			IF THIS.of_Importversion2( ls_Pending, ls_Processed ,ll_CoID) <> 1 THEN
				THIS.of_Adderror("All Files from " + ls_Pending + " could not be processed successfully" )
				li_Return = -1
			END IF
		CASE appeon_constant.cs_EDIVersion_DirectWithAutoReply

			IF THIS.of_Importversion3( ls_Pending, ls_Processed ) <> 1 THEN
				THIS.of_Adderror("All Files from " + ls_Pending + " could not be processed successfully" )
				li_Return = -1
			END IF

		CASE appeon_constant.cs_EDIVersion_Direct

			IF THIS.of_Importversion4( ls_Pending, ls_Processed ) <> 1 THEN
				THIS.of_Adderror("All Files from " + ls_Pending + " could not be processed successfully" )
				li_Return = -1
			END IF

		CASE "" 

		CASE ELSE
			THIS.of_Adderror( "An unexpected version of EDI was encountered.-" + ls_EDIVersion )
			li_Return = -1
			
	END CHOOSE

NEXT

DESTROY ( lds_204Companies )
DESTROY lnv_setting
Destroy lnv_ShipmentManager
RETURN li_Return
end function

public function integer of_import990pending ();/*
 DEK: created on 3-12-07
*/

// loop through all companies that have been set up to process 990s


Long		ll_Count
Long		i
Long		ll_CoID
String	ls_CompanyName
String	ls_Pending
String	ls_Processed
String	ls_EDIVersion
Int		li_Return = 1

String	ls_value
String	ls_remotePath

n_cst_setting_editransport 	lnv_setting
n_cst_bso_ediManager  lnv_ShipmentManager

lnv_setting = CREATE n_cst_setting_editransport
lnv_shipmentManager = create n_cst_bso_ediManager

DataStore	lds_990Companies
lds_990Companies = CREATE DataStore
lds_990Companies.dataobject = "d_990companies_in"
lds_990Companies.SetTransObject ( SQLCA )

ll_Count = lds_990Companies.Retrieve( )
Commit;


FOR i = 1 TO ll_Count
	ll_CoID = lds_990Companies.Object.edi990profile_CompanyID[i]
	ls_Pending = lds_990Companies.Object.edi990profile_PendingFiles[i]
	ls_Processed = lds_990Companies.Object.edi990profile_ProcessedFiles[i]
	


	Select co_name into :ls_CompanyName FROM Companies Where co_id = :ll_CoID;
	Commit;
	
	If isNull ( ls_Pending ) OR Len ( ls_Pending ) = 0 THEN	
		THIS.of_AddError( "Could not process EDI requests for inbound 990s " + ls_CompanyName + ". The 'Pending File' location has not been specified.")
		CONTINUE
	END IF
		
	If isNull ( ls_Processed ) OR Len ( ls_Processed ) = 0 THEN	
		THIS.of_AddError( "Could not process EDI requests for inbound 990s " + ls_CompanyName + ". The 'Processed File' location has not been specified.")
		CONTINUE
	END IF
	
	IF Right ( ls_Pending , 1 ) <> "\" THEN
		ls_Pending += "\"
	END IF
	
	ls_Processed = lnv_shipmentManager.of_appendtoprocessedlocationpath( ls_Processed )
	IF Right ( ls_Processed , 1 ) <> "\" THEN 	
		ls_Processed += "\" 
	END IF


	IF THIS.of_Import990( ls_Pending, ls_Processed ) <> 1 THEN
		THIS.of_Adderror("All Files from " + ls_Pending + " could not be processed successfully" )
		li_Return = -1
	END IF

NEXT

DESTROY ( lds_990Companies )
DESTROY lnv_setting
Destroy lnv_ShipmentManager
RETURN li_Return
end function

public function integer of_import997pending ();/*
 DEK: created on 3-13-07
*/

// loop through all companies that have been set up to process 990s


Long		ll_Count
Long		i
Long		ll_CoID
String	ls_CompanyName
String	ls_Pending
String	ls_Processed
String	ls_EDIVersion
Int		li_Return = 1

String	ls_value
String	ls_remotePath

n_cst_setting_editransport 	lnv_setting
n_cst_bso_ediManager  lnv_ShipmentManager

lnv_setting = CREATE n_cst_setting_editransport
lnv_shipmentManager = create n_cst_bso_ediManager

DataStore	lds_997Companies
lds_997Companies = CREATE DataStore
lds_997Companies.dataobject = "d_997companies_in"
lds_997Companies.SetTransObject ( SQLCA )

ll_Count = lds_997Companies.Retrieve( )
Commit;

FOR i = 1 TO ll_Count
	ll_CoID = lds_997Companies.Object.edi997profile_CompanyID[i]
	ls_Pending = lds_997Companies.Object.edi997profile_PendingFiles[i]
	ls_Processed = lds_997Companies.Object.edi997profile_ProcessedFiles[i]
	


	Select co_name into :ls_CompanyName FROM Companies Where co_id = :ll_CoID;
	Commit;
	
	If isNull ( ls_Pending ) OR Len ( ls_Pending ) = 0 THEN	
		THIS.of_AddError( "Could not process EDI requests for inbound 997s " + ls_CompanyName + ". The 'Pending File' location has not been specified.")
		CONTINUE
	END IF
		
	If isNull ( ls_Processed ) OR Len ( ls_Processed ) = 0 THEN	
		THIS.of_AddError( "Could not process EDI requests for inbound 997s " + ls_CompanyName + ". The 'Processed File' location has not been specified.")
		CONTINUE
	END IF
	
	IF Right ( ls_Pending , 1 ) <> "\" THEN
		ls_Pending += "\"
	END IF
	
	ls_Processed = lnv_shipmentManager.of_appendtoprocessedlocationpath( ls_Processed )
	IF Right ( ls_Processed , 1 ) <> "\" THEN 	
		ls_Processed += "\" 
	END IF


	IF THIS.of_Import997( ls_Pending, ls_Processed ) <> 1 THEN
		THIS.of_Adderror("All Files from " + ls_Pending + " could not be processed successfully" )
		li_Return = -1
	END IF

NEXT

DESTROY ( lds_997Companies )
DESTROY lnv_setting
Destroy lnv_ShipmentManager
RETURN li_Return
end function

public function integer of_import214pending ();/*
 DEK: created on 3-13-07
*/

// loop through all companies that have been set up to process 990s


Long		ll_Count
Long		i
Long		ll_CoID
String	ls_CompanyName
String	ls_Pending
String	ls_Processed
String	ls_EDIVersion
Int		li_Return = 1

String	ls_value
String	ls_remotePath

n_cst_setting_editransport 	lnv_setting
n_cst_bso_ediManager  lnv_ShipmentManager

lnv_setting = CREATE n_cst_setting_editransport
lnv_shipmentManager = create n_cst_bso_ediManager

DataStore	lds_214Companies
lds_214Companies = CREATE DataStore
lds_214Companies.dataobject = "d_214companies_in"
lds_214Companies.SetTransObject ( SQLCA )

ll_Count = lds_214Companies.Retrieve( )
Commit;


FOR i = 1 TO ll_Count
	ll_CoID = lds_214Companies.Object.edi214profile_CompanyID[i]
	ls_Pending = lds_214Companies.Object.edi214profile_PendingFiles[i]
	ls_Processed = lds_214Companies.Object.edi214profile_ProcessedFiles[i]
	


	Select co_name into :ls_CompanyName FROM Companies Where co_id = :ll_CoID;
	Commit;
	
	If isNull ( ls_Pending ) OR Len ( ls_Pending ) = 0 THEN	
		THIS.of_AddError( "Could not process EDI requests for inbound 214s " + ls_CompanyName + ". The 'Pending File' location has not been specified.")
		CONTINUE
	END IF
		
	If isNull ( ls_Processed ) OR Len ( ls_Processed ) = 0 THEN	
		THIS.of_AddError( "Could not process EDI requests for inbound 214s " + ls_CompanyName + ". The 'Processed File' location has not been specified.")
		CONTINUE
	END IF
	
	IF Right ( ls_Pending , 1 ) <> "\" THEN
		ls_Pending += "\"
	END IF
	
	ls_Processed = lnv_shipmentManager.of_appendtoprocessedlocationpath( ls_Processed )
	IF Right ( ls_Processed , 1 ) <> "\" THEN 	
		ls_Processed += "\" 
	END IF


	IF THIS.of_Import214( ls_Pending, ls_Processed ) <> 1 THEN
		THIS.of_Adderror("All Files from " + ls_Pending + " could not be processed successfully" )
		li_Return = -1
	END IF

NEXT

DESTROY ( lds_214Companies )
DESTROY lnv_setting
Destroy lnv_ShipmentManager
RETURN li_Return
end function

public function integer of_movetransactionfilestopending (long al_coid, string as_frompath);
/*
	DEK: This function will look at all the files specified in as_frompath, and will determine which
	transaction the file is, and move the file to its pending location.
	
	IF this company is importing the old 204 formats, unrecognized downloaded files will go into the import204 folder.
	Since old 204 formats will not return a valid transaction number..Any files that I download that I cannot
	Identify a transaction, I will put in the inbound 204 folder.
	
	If we download a transaction file that isn't licensed or an is an unrecognized transaction( that isn't
	a 204 old format) then we delete the file.
*/

Int	li_return = 1
String	lsa_files[]
Int	li_fileCount
Int	li_index
Int	li_pos

String	ls_204version
String	ls_pending204
String	ls_pending214
String 	ls_pending997
String	ls_pending990

Boolean	lb_deleteFile
Long	ll_transaction
N_cst_licenseManager	lnv_licenseManager
n_cst_ediimportmanager lnv_importmanager

lnv_importmanager = create n_cst_ediimportmanager


DataStore	lds_Companies

//this part was annoying but necessary, i have to get the pending location of all the transaction sets
//so i know where to put the files when I identify them.
lds_Companies = CREATE DataStore

IF lnv_licenseManager.of_hasedi204license( ) THEN
	//204
	lds_Companies.dataobject = "d_204companies"
	lds_Companies.SetTransObject ( SQLCA )
	lds_Companies.Retrieve( )
	Commit;
	lds_companies.setFilter( "edi204profile_CompanyID = "+string( al_coid ) )
	lds_companies.filter()
	
	IF lds_companies.rowcount( ) > 0 THEN
		ls_pending204 = lds_Companies.Object.edi204profile_PendingFiles[1]
		ls_204version = lds_Companies.Object.edi204profile_ediversion[1]
	END IF
	
	//990
	lds_Companies.dataobject = "d_990companies_in"
	lds_Companies.SetTransObject ( SQLCA )
	lds_Companies.Retrieve(  )
	Commit;
	lds_companies.setFilter( "edi990profile_CompanyID = "+string( al_coid ) )
	lds_companies.filter()
	
	IF lds_companies.rowcount( ) > 0 THEN
		ls_pending990 = lds_Companies.Object.edi990profile_PendingFiles[1]
	END IF
	
	//997
	lds_Companies.dataobject = "d_997companies_in"
	lds_Companies.SetTransObject ( SQLCA )
	lds_Companies.Retrieve(  )
	Commit;
	lds_companies.setFilter( "edi997profile_CompanyID = "+string( al_coid ) )
	lds_companies.filter()

	IF lds_companies.rowcount( ) > 0 THEN
		ls_pending997 = lds_Companies.Object.edi997profile_PendingFiles[1]
	END IF
END IF
IF lnv_licenseManager.of_hasedi214license( ) THEN
	//214
	lds_Companies.dataobject = "d_214companies_in"
	lds_Companies.SetTransObject ( SQLCA )
	lds_Companies.Retrieve( al_coid )
	Commit;
	lds_companies.setFilter( "edi214profile_CompanyID = "+string( al_coid ) )
	lds_companies.filter()
	
	IF lds_companies.rowcount( ) > 0 THEN
		ls_pending214 = lds_Companies.Object.edi214profile_PendingFiles[1]
	END IF
END IF


// get a list of all the files in the specified directory		
li_FileCount = THIS.of_getfiles( as_fromPath +"\" , lsa_Files )	
int li_temp
FOR li_index = 1 TO li_fileCount
	ll_transaction = lnv_importmanager.of_gettransactionfromfile( as_fromPath +"\"+lsa_files[li_index] )
	li_pos = LASTPOS( lsa_files[li_index], "\")
	lb_deleteFile = false

	CHOOSE CASE ll_transaction
		CASE 204
			IF lnv_licenseManager.of_hasEdi204license( ) THEN
				FILEMOVE(as_fromPath +"\"+lsa_files[li_index], ls_pending204 + "\"+ lsa_files[li_index]  )
			ELSE
				lb_deleteFile = true
			END IF
		CASE 214
			
			FILEMOVE(as_fromPath +"\"+lsa_files[li_index], ls_pending214 + "\"+ lsa_files[li_index]  )
		CASE 990
			IF lnv_licenseManager.of_hasEdi204license( ) THEN
				FILEMOVE(as_fromPath +"\"+lsa_files[li_index], ls_pending990 + "\"+ lsa_files[li_index]  )
			ELSE
				lb_deleteFile = true
			END IF
		CASE 997
			IF lnv_licenseManager.of_hasEdi204license( ) THEN
				FILEMOVE(as_fromPath +"\"+lsa_files[li_index], ls_pending997 + "\"+ lsa_files[li_index]  )
			ELSE
				lb_deleteFile = true
			END IF
		CASE ELSE
			//unidentified transactions get treated as 204's as they could be 
			IF ls_204version = appeon_constant.cs_EDIVersion_Pseudo OR ls_204version = appeon_constant.cs_EDIVersion_VanMapping THEN
				//move to 204 folder
				IF lnv_licenseManager.of_hasEdi204license( ) THEN
					FILEMOVE(as_fromPath +"\"+lsa_files[li_index], ls_pending204 + "\"+ lsa_files[li_index]  )
				ELSE
					lb_deleteFile = true
				END IF
			ELSE
				//if they aren't expecting these then they are unidentified files that can probably stay where they are
				//or get deleted.
				lb_deleteFile = true
			END IF
	END CHOOSE
	
	IF lb_deleteFile THEN
		FileDelete( as_fromPath +"\"+lsa_files[li_index] )
	END IF
NEXT


DESTROY lnv_importmanager
RETURN li_Return
end function

public function integer of_import990 (string as_pendingfolder, string as_processedfolder);// Version 4 Direct 

String	ls_Target
Int		li_FileCount
Int		j
Int		li_Return = 1
String	ls_FileName
String	ls_ImportDirectory
String	lsa_Files[]
Long		lla_sourceIds[]

n_cst_ediimportmanager	lnv_EdiManager

lnv_EdiManager = CREATE n_cst_ediimportmanager

// get the location to move the spent import files to
ls_Target = as_Processedfolder
ls_ImportDirectory = as_Pendingfolder
		
// get a list of all the files in the specified directory		
li_FileCount = THIS.of_GetFiles( ls_ImportDirectory , lsa_Files )
//lnv_EdiManager.of_setprocessfolder( as_processedFolder )	// DEK: 5-22-07right now we only use this for recording errors.		
FOR j = 1 TO li_FileCount
	
	ls_FileName = lsa_Files[j]
	
	IF lnv_EdiManager.of_import990( ls_ImportDirectory + ls_FileName ) <> 1 THEN
		THIS.of_AddError ( lnv_EdiManager.of_GetErrorString ( ) )
		this.of_logerror( "EDI", "Import 990", lnv_ediManager.of_getErrorString(),1, lla_sourceIds, "n_cst_errorremedy_edi")
		li_Return = -1
	END IF
	
	THIS.of_Movefile( ls_FileName , ls_ImportDirectory, ls_Target )
				
NEXT

DESTROY ( lnv_EdiManager )

RETURN li_Return
end function

public function integer of_import997 (string as_pendingfolder, string as_processedfolder);// Version 4 Direct 

String	ls_Target
Int		li_FileCount
Int		j
Int		li_Return = 1
String	ls_FileName
String	ls_ImportDirectory
String	lsa_Files[]
Long		lla_sourceIds[]

n_cst_ediimportmanager	lnv_EdiManager

lnv_EdiManager = CREATE n_cst_ediimportmanager

// get the location to move the spent import files to
ls_Target = as_Processedfolder
ls_ImportDirectory = as_Pendingfolder
		
// get a list of all the files in the specified directory		
li_FileCount = THIS.of_GetFiles( ls_ImportDirectory , lsa_Files )
			
FOR j = 1 TO li_FileCount
	
	ls_FileName = lsa_Files[j]
	
	IF lnv_EdiManager.of_import997( ls_ImportDirectory + ls_FileName ) <> 1 THEN
		THIS.of_AddError ( lnv_EdiManager.of_GetErrorString ( ) )
		this.of_logerror( "EDI", "Import 997", lnv_ediManager.of_getErrorString(),1, lla_sourceIds, "n_cst_errorremedy_edi")
		li_Return = -1
	END IF
	
	THIS.of_Movefile( ls_FileName , ls_ImportDirectory, ls_Target )
				
NEXT

DESTROY ( lnv_EdiManager )

RETURN li_Return
end function

public function integer of_import214 (string as_pendingfolder, string as_processedfolder);// Version 4 Direct 

String	ls_Target
Int		li_FileCount
Int		j
Int		li_Return = 1
String	ls_FileName
String	ls_ImportDirectory
String	lsa_Files[]
Long		lla_sourceIds[]

n_cst_ediimportmanager	lnv_EdiManager

lnv_EdiManager = CREATE n_cst_ediimportmanager

// get the location to move the spent import files to
ls_Target = as_Processedfolder
ls_ImportDirectory = as_Pendingfolder
		
// get a list of all the files in the specified directory		
li_FileCount = THIS.of_GetFiles( ls_ImportDirectory , lsa_Files )
			
FOR j = 1 TO li_FileCount
	
	ls_FileName = lsa_Files[j]
	
	IF lnv_EdiManager.of_import214( ls_ImportDirectory + ls_FileName ) <> 1 THEN
		THIS.of_AddError ( lnv_EdiManager.of_GetErrorString ( ) )
		this.of_logerror( "EDI", "Import 214", lnv_ediManager.of_getErrorString(),1, lla_sourceIds, "n_cst_errorremedy_edi")
		li_Return = -1
	END IF
	
	THIS.of_Movefile( ls_FileName , ls_ImportDirectory, ls_Target )
				
NEXT

DESTROY ( lnv_EdiManager )

RETURN li_Return
end function

on n_cst_edishipmentprocessmanager.create
call super::create
end on

on n_cst_edishipmentprocessmanager.destroy
call super::destroy
end on

event destructor;call super::destructor;IF isvalid( inv_errorlogmanager ) THEN
	DESTROY inv_errorlogmanager
END IF
end event

