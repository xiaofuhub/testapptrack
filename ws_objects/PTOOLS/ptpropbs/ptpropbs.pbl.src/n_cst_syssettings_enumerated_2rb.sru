$PBExportHeader$n_cst_syssettings_enumerated_2rb.sru
$PBExportComments$ZMC
forward
global type n_cst_syssettings_enumerated_2rb from n_cst_syssettings_enumerated
end type
end forward

global type n_cst_syssettings_enumerated_2rb from n_cst_syssettings_enumerated
end type
global n_cst_syssettings_enumerated_2rb n_cst_syssettings_enumerated_2rb

forward prototypes
public function integer of_savevalue (any aa_value)
public function String of_decideyesnorb (string as_value)
public function string of_decide01rb (string as_value)
public function string of_decidecyescno (string as_value)
public function string of_decidec0c1 (string as_value)
end prototypes

public function integer of_savevalue (any aa_value);String ls_value
ls_value = String(aa_value)

Return 1
end function

public function String of_decideyesnorb (string as_value);String ls_value
ls_value = as_value

IF ls_Value = "YES!" THEN
	ls_Value = THIS.cs_yes
ELSE
	ls_Value = THIS.cs_no
END IF

Return ls_value
end function

public function string of_decide01rb (string as_value);String ls_value
ls_value = as_value

IF ls_Value = "1" THEN
	ls_Value = THIS.cs_yes
ELSE
	ls_Value = THIS.cs_no
END IF

Return ls_value
end function

public function string of_decidecyescno (string as_value);String ls_value
ls_value = as_value

IF ls_Value = THIS.cs_yes  THEN
	ls_Value = "YES!"
ELSE
	ls_Value = "NO!"
END IF

Return ls_Value

end function

public function string of_decidec0c1 (string as_value);String ls_value
ls_value = as_value

IF ls_Value = THIS.cs_yes THEN
	ls_Value = "1"
ELSE
	ls_Value = "0"
END IF

Return ls_value
end function

on n_cst_syssettings_enumerated_2rb.create
call super::create
end on

on n_cst_syssettings_enumerated_2rb.destroy
call super::destroy
end on

