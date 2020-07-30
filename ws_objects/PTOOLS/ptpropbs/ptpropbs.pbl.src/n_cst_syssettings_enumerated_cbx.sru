$PBExportHeader$n_cst_syssettings_enumerated_cbx.sru
$PBExportComments$ZMC
forward
global type n_cst_syssettings_enumerated_cbx from n_cst_syssettings_enumerated
end type
end forward

global type n_cst_syssettings_enumerated_cbx from n_cst_syssettings_enumerated
end type
global n_cst_syssettings_enumerated_cbx n_cst_syssettings_enumerated_cbx

type variables
Private String 	is_CBXText
end variables

forward prototypes
public function string of_decideyesno (string as_value)
public function integer of_savevalue (any aa_value)
public function string of_decidecyesno (string as_value)
end prototypes

public function string of_decideyesno (string as_value);String ls_value
ls_value = as_value

IF ls_Value = "YES!" THEN
	ls_Value = THIS.cs_yes
ELSE
	ls_Value = THIS.cs_no
END IF

Return ls_value
end function

public function integer of_savevalue (any aa_value);String ls_value
ls_value = String(aa_value)

Return 1
end function

public function string of_decidecyesno (string as_value);String ls_value
ls_value = as_value

IF ls_Value = THIS.cs_yes  THEN
	ls_Value = "YES!"
ELSE
	ls_Value = "NO!"
END IF

Return ls_Value

end function

on n_cst_syssettings_enumerated_cbx.create
call super::create
end on

on n_cst_syssettings_enumerated_cbx.destroy
call super::destroy
end on

