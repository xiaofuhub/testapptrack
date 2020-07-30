$PBExportHeader$n_cst_syssettings_generic_populate.sru
$PBExportComments$ZMC
forward
global type n_cst_syssettings_generic_populate from n_cst_syssettings
end type
end forward

global type n_cst_syssettings_generic_populate from n_cst_syssettings
end type
global n_cst_syssettings_generic_populate n_cst_syssettings_generic_populate

type variables
Protected:

String 	isa_MultiChoice[]
String	is_ColName
String 	is_Delimiter
end variables

forward prototypes
public function integer of_getarray (string asa_array[])
public function string of_getdelimiter ()
public function string of_getcolheader ()
end prototypes

public function integer of_getarray (string asa_array[]);Int li_ReturnValue = -1 
IF UpperBound(isa_MultiChoice[]) > 0 THEN
	asa_array[] = isa_MultiChoice[]
	li_ReturnValue = 1 
END IF

Return li_ReturnValue
end function

public function string of_getdelimiter ();Return is_delimiter
end function

public function string of_getcolheader ();RETURN is_colname
end function

on n_cst_syssettings_generic_populate.create
call super::create
end on

on n_cst_syssettings_generic_populate.destroy
call super::destroy
end on

