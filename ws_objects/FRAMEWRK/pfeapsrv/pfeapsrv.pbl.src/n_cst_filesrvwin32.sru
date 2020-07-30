$PBExportHeader$n_cst_filesrvwin32.sru
$PBExportComments$Extension Win32 File handler service
forward
global type n_cst_filesrvwin32 from pfc_n_cst_filesrvwin32
end type
end forward

global type n_cst_filesrvwin32 from pfc_n_cst_filesrvwin32
end type
global n_cst_filesrvwin32 n_cst_filesrvwin32

forward prototypes
public function integer of_createfolder (string as_path)
end prototypes

public function integer of_createfolder (string as_path);/////////////////////////////////////////////////////////
//
// Function		: of_createfolder
// Arguments 	: as_path, string 
// Returns 		: 1 = Success, -1 = Failure
// Description : Create a folder when full path is passed to it on the 
//					  desired drive
//
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1

String ls_Path
String ls_Drive
String ls_DirPath
String ls_filename 
String ls_Separator 
String ls_PathBuild
String lsa_PathParts[]

Long ll_PartCount

ls_Path = as_path
ls_Separator = '\'

n_cst_String lnv_string

// Parse the path into parts and create directory by directory
IF THIS.of_parsepath(ls_Path,ls_Drive,ls_DirPath,ls_filename) = 1 THEN
	ll_PartCount = lnv_string.of_parsetoarray(ls_DirPath,ls_Separator,lsa_PathParts[])
	IF ll_PartCount > 0 THEN
		ls_PathBuild = ls_Drive
		For ll_PartCount = 1 to UpperBound( lsa_PathParts[])			// loop thru dir path and create each directory as needed	
			ls_PathBuild = ls_PathBuild + lsa_PathParts[ll_PartCount] + ls_Separator
			IF THIS.of_directoryExists(ls_PathBuild) THEN // Returns Boolean 			
				// Do nothing
			Else
				IF THIS.of_CreateDirectory(ls_PathBuild) = 1 THEN				
				ELSE
					li_ReturnValue = -1 
					//MessageBox(cs_ErrMsgHeader,'Can not create directory path: '+ ls_PathBuild ) 
					EXIT
				END IF
			End If
		Next
	ELSE	
		li_ReturnValue = -1 
		//MessageBox(cs_ErrMsgHeader,'Parsing of path to array failed while copying images.') 
	END IF	
ELSE	
	li_ReturnValue = -1 
	//MessageBox(cs_ErrMsgHeader,'Parsing of path failed while copying images.') 
END IF

Return li_ReturnValue
end function

on n_cst_filesrvwin32.create
call super::create
end on

on n_cst_filesrvwin32.destroy
call super::destroy
end on

