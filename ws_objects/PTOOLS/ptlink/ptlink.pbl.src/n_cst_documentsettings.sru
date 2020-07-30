$PBExportHeader$n_cst_documentsettings.sru
forward
global type n_cst_documentsettings from n_base
end type
end forward

global type n_cst_documentsettings from n_base
end type
global n_cst_documentsettings n_cst_documentsettings

type variables
Constant String	cs_TargetDocType = "TARGETDOCTYPE"
Constant String	cs_PageCount = "PAGECOUNT"


Long	il_CoID
String	is_TransferMethod
String	is_TargetAddress
String	is_NamingSchema


DataStore	ids_Settings
DataStore	ids_Mappings

end variables

forward prototypes
public function integer of_setcompanyid (long al_id)
public function string of_gettransfermethod ()
public function integer of_settransfermethod (string as_transfermethod)
public function string of_gettargetaddress ()
public function string of_getfilename (n_cst_document anv_document)
protected function string of_gettargetdocumenttype (string as_pttype)
protected function integer of_processspecialtags (ref n_cst_msg anv_msg, string as_stringvalue, n_cst_document anv_document)
protected function string of_getsubjectlineschema ()
public function string of_getsubjectline (n_cst_document anv_document)
protected function string of_getnamingschema ()
end prototypes

public function integer of_setcompanyid (long al_id);Int	li_Return = 1
il_Coid = al_id

IF ids_settings.Retrieve ( il_coid ) < 1 THEN
	li_Return = -1
END IF

IF ids_mappings.Retrieve ( il_coid ) < 1 THEN
	li_Return = -1
END IF

Commit;

RETURN li_Return
end function

public function string of_gettransfermethod ();RETURN is_transfermethod
end function

public function integer of_settransfermethod (string as_transfermethod);is_Transfermethod = as_transfermethod

RETURN 1
end function

public function string of_gettargetaddress ();//This can be the folder or an email address

String	ls_Return

ls_Return = ids_settings.GetItemString ( 1 , "targetaddress" )
//ls_Return = "rzacher@profittools.net"

RETURN ls_Return
end function

public function string of_getfilename (n_cst_document anv_document);// Get the name from the settings and use the beo source on the document to run though the 
// report manager to get the proper filename.
String	ls_FileNameSchema
String	ls_Return
String	ls_DocumentType
Int		li_Return = 1
Int		li_CreateRtn
Any		laa_Beo[]
pt_n_cst_beo				lnv_Beo
n_cst_Msg					lnv_Msg
n_cst_Bso_ReportManager	lnv_ReportManager



ls_FileNameSchema = THIS.of_Getnamingschema( )

THIS.of_processspecialtags( lnv_Msg, ls_FileNameSchema , anv_document )


lnv_Beo = anv_Document.of_Getbeo ()
laa_Beo[1] = lnv_Beo

IF li_Return = 1 THEN
	li_CreateRtn = lnv_ReportManager.of_Processstring( ls_FileNameSchema, ls_Return, laa_Beo,lnv_Msg )
	
	IF li_CreateRtn <> 1 THEN
		li_Return = -1
	END IF

END IF


RETURN ls_return
end function

protected function string of_gettargetdocumenttype (string as_pttype);Long	ll_FoundRow
String	ls_Return 
ll_FoundRow = ids_mappings.Find ( "ptdocument = '" + as_pttype + "'" , 1 , ids_mappings.RowCount ( ) )

IF ll_FoundRow > 0 THEN
	ls_Return = ids_mappings.GetItemString ( ll_FoundRow, "TargetCompanyDocument" )
END IF

RETURN ls_Return

end function

protected function integer of_processspecialtags (ref n_cst_msg anv_msg, string as_stringvalue, n_cst_document anv_document);s_Parm	lstr_Parm
String	ls_Type

IF Pos ( Upper ( as_stringvalue ) , "<" + cs_targetdoctype + ">" ) > 0 THEN
	ls_Type = THIS.of_Gettargetdocumenttype(anv_document.of_GetDocumentType() )
	lstr_Parm.is_Label = cs_targetdoctype
	lstr_Parm.ia_value = ls_Type
	anv_msg.of_Add_Parm ( lstr_Parm )
END IF


IF Pos ( Upper ( as_stringvalue ) , "<" + cs_pagecount + ">" ) > 0 THEN
	lstr_Parm.is_Label = cs_Pagecount
	lstr_Parm.ia_value = String ( anv_Document.of_GetPageCount ( ) ) 
	anv_msg.of_Add_Parm ( lstr_Parm )
END IF

RETURN 1
end function

protected function string of_getsubjectlineschema ();RETURN ids_settings.GetItemString ( 1 , "subjectline" )
end function

public function string of_getsubjectline (n_cst_document anv_document);// Get the name from the settings and use the beo source on the document to run though the 
// report manager to get the proper filename.
String	ls_Subjectlineschema
String	ls_Return
String	ls_DocumentType
Int		li_Return = 1
Int		li_CreateRtn
Any		laa_Beo[]
pt_n_cst_beo				lnv_Beo
n_cst_Msg					lnv_Msg
n_cst_Bso_ReportManager	lnv_ReportManager



ls_Subjectlineschema = THIS.of_GetSubjectlineschema( )

THIS.of_processspecialtags( lnv_Msg, ls_Subjectlineschema , anv_document )


lnv_Beo = anv_Document.of_Getbeo ()
laa_Beo[1] = lnv_Beo

IF li_Return = 1 THEN
	li_CreateRtn = lnv_ReportManager.of_Processstring( ls_Subjectlineschema, ls_Return, laa_Beo,lnv_Msg )
	
	IF li_CreateRtn <> 1 THEN
		li_Return = -1
	END IF

END IF


RETURN ls_return
end function

protected function string of_getnamingschema ();RETURN ids_settings.GetItemString ( 1 , "namingschema" )
end function

on n_cst_documentsettings.create
call super::create
end on

on n_cst_documentsettings.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_settings = CREATE DataStore
ids_settings.DataObject = "d_companydocumentsettings"
ids_settings.SetTransObject(SQLCA) 


ids_mappings = CREATE DataStore
ids_mappings.DataObject = "d_documentmapping"
ids_mappings.SetTransObject(SQLCA) 


end event

event destructor;call super::destructor;DESTROY ( ids_mappings ) 
DESTROY ( ids_settings ) 


end event

