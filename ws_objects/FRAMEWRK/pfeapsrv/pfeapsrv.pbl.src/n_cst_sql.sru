$PBExportHeader$n_cst_sql.sru
$PBExportComments$Extension SQL Service service
forward
global type n_cst_sql from pfc_n_cst_sql
end type
end forward

global type n_cst_sql from pfc_n_cst_sql
end type

forward prototypes
public function string of_makeinclause (readonly long ala_list[])
public function string of_makestringinclause (readonly long ala_list[])
public function string of_makeinclausefromstrings (readonly string asa_list[])
end prototypes

public function string of_makeinclause (readonly long ala_list[]);//Makes a SQL "IN" Clause from the list of ids passed in.
//Note: The result string is padded with a space on either end.

String			ls_InClause
n_cst_String	lnv_String

lnv_String.of_ArrayToString ( ala_List, ", ", ls_InClause )

IF IsNull ( ls_InClause ) THEN
	ls_InClause = ""
END IF

ls_InClause = " IN ( " + ls_InClause + " ) "

RETURN ls_InClause
end function

public function string of_makestringinclause (readonly long ala_list[]);//Makes a SQL "IN" Clause from the list of ids passed in.
//Note: The result string is padded with a space on either end.

String			ls_InClause
n_cst_String	lnv_String

lnv_String.of_ArrayToString ( ala_List, "', '", ls_InClause )

IF IsNull ( ls_InClause ) THEN
	ls_InClause = ""
END IF

ls_InClause = " IN ( '" + ls_InClause + "' ) "

RETURN ls_InClause
end function

public function string of_makeinclausefromstrings (readonly string asa_list[]);String			ls_InClause
n_cst_String	lnv_String

lnv_String.of_ArrayToString ( asa_List, "', '", ls_InClause )

IF IsNull ( ls_InClause ) THEN
	ls_InClause = ""
END IF

ls_InClause = " IN ( '" + ls_InClause + "' ) "

RETURN ls_InClause
end function

on n_cst_sql.create
TriggerEvent( this, "constructor" )
end on

on n_cst_sql.destroy
TriggerEvent( this, "destructor" )
end on

