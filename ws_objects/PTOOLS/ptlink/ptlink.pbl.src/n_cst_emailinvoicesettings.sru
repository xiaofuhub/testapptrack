$PBExportHeader$n_cst_emailinvoicesettings.sru
forward
global type n_cst_emailinvoicesettings from n_cst_documentsettings
end type
end forward

global type n_cst_emailinvoicesettings from n_cst_documentsettings
end type
global n_cst_emailinvoicesettings n_cst_emailinvoicesettings

type variables
String		is_EITargetAdress
String		is_EIInvoiceSchema
String		is_EIImageSchema

DataStore	ids_EISettings
DataStore	ids_EIMappings

end variables

forward prototypes
public function integer of_setcompanyid (long al_id)
public function string of_gettargetaddress ()
public function string of_getinvoicenamingschema ()
public function string of_getimagenamingschema ()
public function string of_getinvoicesubjectlineschema ()
public function integer of_processspecialtagsforei (string as_stringvalue, string as_type, ref n_cst_msg anv_msg)
public function string of_getinvoicetargetdocumenttype (string as_type)
public function string of_gettargetbcc ()
public function string of_getbodyschema ()
end prototypes

public function integer of_setcompanyid (long al_id);Integer	li_Return
il_Coid = al_id

IF ids_EISettings.Retrieve( il_coid ) < 1 THEN
	li_Return = -1
END IF

IF ids_EIMappings.Retrieve( il_coid ) < 1 THEN
	li_Return = -1
END IF

Commit;

Return li_Return
end function

public function string of_gettargetaddress ();Return ids_EIsettings.GetItemString ( 1 , "targetaddress" )
end function

public function string of_getinvoicenamingschema ();RETURN ids_EIsettings.GetItemString ( 1 , "namingschema" )
end function

public function string of_getimagenamingschema ();Return ids_EIMappings.GetItemString(1, "namingschema")

end function

public function string of_getinvoicesubjectlineschema ();RETURN ids_EIsettings.GetItemString ( 1 , "subjectline" )
end function

public function integer of_processspecialtagsforei (string as_stringvalue, string as_type, ref n_cst_msg anv_msg);s_Parm	lstr_Parm
String	ls_Type

IF Pos ( Upper ( as_stringvalue ) , "<" + cs_targetdoctype + ">" ) > 0 THEN
	ls_Type = This.of_GetInvoiceTargetDocumentType(as_type)
	lstr_Parm.is_Label = cs_targetdoctype
	lstr_Parm.ia_value = ls_Type
	anv_msg.of_Add_Parm ( lstr_Parm )
END IF

Return 1
end function

public function string of_getinvoicetargetdocumenttype (string as_type);Long	ll_FoundRow
String	ls_Return 
ll_FoundRow = ids_EImappings.Find ( "ptdocument = '" + as_type + "'" , 1 , ids_EImappings.RowCount ( ) )

IF ll_FoundRow > 0 THEN
	ls_Return = ids_EImappings.GetItemString ( ll_FoundRow, "targetcompanydocument" )
END IF

RETURN ls_Return
end function

public function string of_gettargetbcc ();Return ids_EIsettings.GetItemString ( 1 , "bccaddress" )
end function

public function string of_getbodyschema ();RETURN ids_EIsettings.GetItemString ( 1 , "body" )
end function

on n_cst_emailinvoicesettings.create
call super::create
end on

on n_cst_emailinvoicesettings.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_EIsettings = CREATE DataStore
ids_EIsettings.DataObject = "d_companyinvoicesettings"
ids_EIsettings.SetTransObject(SQLCA) 


ids_EImappings = CREATE DataStore
ids_EImappings.DataObject = "d_companyinvoicemapping"
ids_EImappings.SetTransObject(SQLCA) 
end event

event destructor;call super::destructor;Destroy	ids_EISettings
Destroy	ids_EIMappings
end event

