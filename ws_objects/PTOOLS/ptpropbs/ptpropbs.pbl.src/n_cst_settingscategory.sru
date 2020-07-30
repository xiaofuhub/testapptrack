$PBExportHeader$n_cst_settingscategory.sru
forward
global type n_cst_settingscategory from n_base
end type
end forward

global type n_cst_settingscategory from n_base
end type
global n_cst_settingscategory n_cst_settingscategory

type variables
String	is_Name 
String 	is_PicName
String 	isa_tabarray[]

String	isa_AssociatedModules[]


end variables

forward prototypes
public function integer of_setname (string as_name)
public function integer of_setpicture (string as_picture)
public function integer of_settabpages (string asa_tabpages[])
public function string of_getname ()
public function string of_getpicture ()
public function integer of_gettabpages (ref string asa_tabpages[])
public function integer of_setaccociatedmodules (string asa_modules[])
public function boolean of_islicensed ()
end prototypes

public function integer of_setname (string as_name);Int li_ReturnValue = 1
String ls_Name

ls_Name = as_name

This.is_name = ls_Name

Return li_ReturnValue
end function

public function integer of_setpicture (string as_picture);Int li_ReturnValue = 1
String ls_Picture

ls_Picture = as_picture

This.is_PicName = ls_Picture

Return li_ReturnValue
end function

public function integer of_settabpages (string asa_tabpages[]);Int li_ReturnValue = 1
String lsa_tabpages[]

lsa_tabpages = asa_tabpages

This.isa_tabarray[] = lsa_tabpages[]

Return li_ReturnValue

end function

public function string of_getname ();Return is_name
end function

public function string of_getpicture ();Return is_picname
end function

public function integer of_gettabpages (ref string asa_tabpages[]);asa_tabpages = isa_tabarray[]
Return UpperBound(asa_tabpages)
end function

public function integer of_setaccociatedmodules (string asa_modules[]);isa_associatedmodules = asa_modules[]

RETURN 1

end function

public function boolean of_islicensed ();Int	li_Ctr
Int	li_Count
Boolean	lb_Return = TRUE
String ls_Value

n_cst_licenseManager	lnv_LicenseMan

li_Count = Upperbound (isa_associatedmodules )

IF li_Count > 0 THEN 
	lb_Return = FALSE
	For li_Ctr = 1 TO li_Count
		ls_Value =   isa_associatedmodules[li_Ctr]
		IF lnv_LicenseMan.of_GetLicensed (ls_Value) THEN
			lb_Return = TRUE
			EXIT
		END IF
	NEXT
END IF

Return lb_Return





end function

on n_cst_settingscategory.create
call super::create
end on

on n_cst_settingscategory.destroy
call super::destroy
end on

