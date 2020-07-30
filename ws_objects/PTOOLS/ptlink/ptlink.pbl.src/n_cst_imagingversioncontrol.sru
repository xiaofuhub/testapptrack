$PBExportHeader$n_cst_imagingversioncontrol.sru
forward
global type n_cst_imagingversioncontrol from n_base
end type
end forward

global type n_cst_imagingversioncontrol from n_base
end type
global n_cst_imagingversioncontrol n_cst_imagingversioncontrol

type variables
Real	ir_Version



CONSTANT Real	cr_Version_4 = 4.0
CONSTANT Real	cr_Version_7 = 7.0


end variables

forward prototypes
public function integer of_unlock ()
public function string of_getimagexpressobjectstring ()
public function string of_getprintproobjectstring ()
public function integer of_setcompression (ref oleobject anv_imageole)
end prototypes

public function integer of_unlock ();// Implement on descendent
RETURN -1
end function

public function string of_getimagexpressobjectstring ();RETURN ""
end function

public function string of_getprintproobjectstring ();RETURN ""
end function

public function integer of_setcompression (ref oleobject anv_imageole);// implemented by descendant
RETURN -1
end function

on n_cst_imagingversioncontrol.create
call super::create
end on

on n_cst_imagingversioncontrol.destroy
call super::destroy
end on

