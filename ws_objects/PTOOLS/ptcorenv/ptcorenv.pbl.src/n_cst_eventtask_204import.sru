$PBExportHeader$n_cst_eventtask_204import.sru
forward
global type n_cst_eventtask_204import from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_204import from n_cst_eventtask
end type
global n_cst_eventtask_204import n_cst_eventtask_204import

forward prototypes
public function integer of_execute ()
private function integer of_import204direct (string as_sourcepath, string as_spentfilepath)
private function integer of_retrieveandacceptall ()
private function integer of_processvan204 (string as_importdirectory, string as_spentfilelocation)
end prototypes

public function integer of_execute ();String	ls_Target
String	ls_FileName
String	ls_ImportDirectory
String	ls_EDIVersion
Int		li_Return 
String	ls_Result

n_cst_edi_Transaction_204	lnv_Edi_204
n_cst_setting_edi204version	lnv_EdiVersion
n_cst_licensemanager	lnv_LicenseManager
n_cst_edishipmentprocessmanager	lnv_ProcessManager

li_Return = ci_result_success
ls_Result =  "EDI 204 Import has completed successfully."

IF NOT lnv_LicenseManager.of_HasEDI204License ( ) THEN  // EARLY RETURN HERE //\\//\\//\\//\\
	THIS.of_Setprocessingresult( ci_result_error )
	THIS.of_Setresultstring( "EDI 204 is not licensed." )
	THIS.of_Disableevent( )
	RETURN 0	
END IF

lnv_ProcessManager = CREATE n_cst_edishipmentprocessmanager
IF lnv_ProcessManager.of_Importpendingfiles( ) <> 1 THEN
	li_Return = ci_result_error
	ls_Result = lnv_ProcessManager.of_GetErrorstring ( )	
END IF


THIS.of_Setprocessingresult( li_Return )
THIS.of_Setresultstring( ls_Result )

DESTROY ( lnv_ProcessManager )

RETURN 1

end function

private function integer of_import204direct (string as_sourcepath, string as_spentfilepath);String	ls_Target
Int		li_FileCount
Int		j
String	ls_FileName
String	ls_ErrorMsg
String	ls_ImportDirectory
STRING	ls_EDIVersion
String	ls_TargetFileName
Int		li_Return = 1

n_cst_filesrvwin32	lnv_FileSrv
n_cst_edi_Transaction_204	lnv_Edi_204
n_cst_dirattrib	lnva_DirAttribs[]
n_cst_edishipment_manager	lnv_EdiManager

lnv_EdiManager = CREATE n_cst_edishipment_manager
lnv_Edi_204 = CREATE n_cst_edi_Transaction_204
lnv_FileSrv = CREATE n_cst_filesrvwin32

// get the location to move the spent import files to
ls_Target = as_Spentfilepath
ls_ImportDirectory = as_Sourcepath

		
// get a list of all the files in the specified directory		
li_FileCount = lnv_FileSrv.of_dirlist ( ls_ImportDirectory+"*.*", 0, lnva_DirAttribs )		
			
FOR j = 1 TO li_FileCount
	ls_ErrorMsg = ""
	ls_FileName = lnva_DirAttribs[j].is_FileName
	
	IF lnv_EDIManager.of_Import204filesintopending( ls_ImportDirectory + ls_FileName ) <> 1 THEN
		li_Return = -1
	END IF
	
	IF FileExists ( ls_Target + ls_FileName ) THEN
		// we are going to add on the date and time to the file, otherwise we would not 
		// be able to move it, and that would cause problems.
		ls_TargetFileName = String ( Today () , "YYMMDD" ) + String (Now(),"HHMMSS" ) + "-" + ls_FileName
		//229	is the lengh limit on file names. so...
		IF Len ( ls_TargetFileName ) >= 229 THEN 
				ls_TargetFileName = Left ( ls_TargetFileName , 229 )
		END IF
		
		
	ELSE
		ls_TargetFileName = ls_FileName
	END IF
	
	IF lnv_FileSrv.of_FileRename ( ls_ImportDirectory + ls_FileName , ls_Target + ls_TargetFileName  ) <> 1 THEN
		ls_ErrorMsg = "COULD NOT MOVE IMPORT FILE. "
	END IF
	
	lnv_Edi_204.of_WriteErrorLog ( ls_ErrorMsg )
				
NEXT


DESTROY ( lnv_EdiManager )
DESTROY ( lnv_Edi_204 )
DESTROY ( lnv_FileSrv )

RETURN li_Return

end function

private function integer of_retrieveandacceptall ();n_cst_edishipmentreview lnv_EDIReview
lnv_EDIReview = CREATE n_Cst_EDIShipmentReview

lnv_EDIReview.of_Retrieveandacceptall( )

DESTROY ( lnv_EDIReview )
	
RETURN 1	


end function

private function integer of_processvan204 (string as_importdirectory, string as_spentfilelocation);Long		i
Long		ll_Count
Int		li_FileCount
Int		j
String	ls_Target
String	ls_FileName
String	ls_ErrorMsg
String	ls_ImportDirectory
String	ls_TargetFileName
Int		li_Return = 1

//n_cst_filesrvwin32	lnv_FileSrv
//n_cst_edi_204_Record	lnva_Records[]
//n_cst_edi_Transaction_204	lnv_Edi_204
//n_cst_dirattrib	lnva_DirAttribs[]
//n_cst_ShipmentManager	lnv_ShipmentManager
//
//lnv_Edi_204 = CREATE n_cst_edi_Transaction_204
//lnv_FileSrv = CREATE n_cst_filesrvwin32
//
//// get the location to move the spent import files to
//ls_Target = as_Spentfilelocation
//ls_ImportDirectory = as_importdirectory
//	
//// get a list of all the files in the specified directory		
//li_FileCount = lnv_FileSrv.of_dirlist ( ls_ImportDirectory+"*.*", 0, lnva_DirAttribs )		
//			
//FOR j = 1 TO li_FileCount
//	ls_ErrorMsg = ""
//	ls_FileName = lnva_DirAttribs[j].is_FileName
//	
//
//	lnv_Edi_204.of_ImportFile ( ls_ImportDirectory + ls_FileName )		
//	ll_Count = lnv_Edi_204.of_GetRecords ( lnva_Records )
//	FOR i = 1 TO ll_Count 
//		IF lnv_ShipmentManager.of_Process204 ( lnva_Records[i] ) <> 1 THEN
//			li_Return = -1
//		END IF
//	NEXT
//	
//	IF FileExists ( ls_Target + ls_FileName ) THEN
//		// we are going to add on the date and time to the file, otherwise we would not 
//		// be able to move it, and that would cause problems.
//		ls_TargetFileName = String ( Today () , "YYMMDD" ) + String (Now(),"HHMMSS" ) + "-" + ls_FileName
//		//229	is the lengh limit on file names. so...
//		IF Len ( ls_TargetFileName ) >= 229 THEN 
//				ls_TargetFileName = Left ( ls_TargetFileName , 229 )
//		END IF
//		
//		
//	ELSE
//		ls_TargetFileName = ls_FileName
//	END IF
//	
//	IF lnv_FileSrv.of_FileRename ( ls_ImportDirectory + ls_FileName , ls_Target + ls_TargetFileName  ) <> 1 THEN
//		ls_ErrorMsg = "COULD NOT MOVE IMPORT FILE. "
//	END IF
//	
//	lnv_Edi_204.of_WriteErrorLog ( ls_ErrorMsg )
//			
//NEXT
//
//DESTROY ( lnv_Edi_204 )
//DESTROY ( lnv_FileSrv )
RETURN li_Return

end function

on n_cst_eventtask_204import.create
call super::create
end on

on n_cst_eventtask_204import.destroy
call super::destroy
end on

event constructor;call super::constructor;is_taskdescription = "This is the process that downloads and imports licensed 204s, 214s, 990s, and 997s into the Profit Tools Database."
is_Tabpagelabel = "EDI Import"
is_eventname = "ptev_204import"
is_Schedulename = "ptsch_204import" 
is_Procedurename = "ptsp_204import"
end event

