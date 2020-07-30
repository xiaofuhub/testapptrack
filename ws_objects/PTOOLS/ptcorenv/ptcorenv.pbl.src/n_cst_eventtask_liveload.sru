$PBExportHeader$n_cst_eventtask_liveload.sru
forward
global type n_cst_eventtask_liveload from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_liveload from n_cst_eventtask
end type
global n_cst_eventtask_liveload n_cst_eventtask_liveload

forward prototypes
public function integer of_execute ()
private function integer of_getliveloadpath (ref string as_path)
end prototypes

public function integer of_execute ();String	ls_FileGroup
String	ls_LiveLoadPath
Int		li_llPathRtn
int		li_ProcessReturn
String	ls_Result

n_cst_bso_LiveLoad	lnv_LiveLoad
lnv_LiveLoad = CREATE n_cst_bso_LiveLoad


li_ProcessReturn = ci_result_success
ls_Result = "Live Load executed successfully."


//If a filegroup has been specified, generate files for it.  Otherwise, just upload any
//existing files  (this can be used if an upload failed after generation.)

li_llPathRtn = THIS.of_GetLiveLoadPath ( ls_LiveLoadPath )

IF li_llpathRtn = 1 THEN
	
//	IF Len ( ls_FileGroup ) > 0 THEN
//		lnv_LiveLoad.of_GenerateFiles ( ls_FileGroup )
//	END IF
//	
	Run ( ls_LiveLoadPath + "llapps\" + "liveload.exe -b")
ELSE
	li_ProcessReturn = ci_result_Error
	ls_Result = "The file 'LiveLoad.ini' could not be located. Please be sure the system setting in Profit Tools is correct."
END IF

THIS.of_Setprocessingresult( li_ProcessReturn )
THIS.of_Setresultstring( ls_Result )



DESTROY lnv_LiveLoad

RETURN li_llPathRtn

end function

private function integer of_getliveloadpath (ref string as_path);

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1



SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 57 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( ls_Description ) > 0 THEN
		//Value is OK --
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE

IF li_Return = 1 THEN
	IF RIGHT ( ls_Description , 1 ) <> "\" THEN
		ls_Description += "\"
	END IF
	IF NOT FileExists ( ls_Description + "llapps\liveload.ini" ) THEN
		li_Return = -1
	ELSE
		as_Path = ls_Description
	END IF
END IF


RETURN li_Return



end function

on n_cst_eventtask_liveload.create
call super::create
end on

on n_cst_eventtask_liveload.destroy
call super::destroy
end on

