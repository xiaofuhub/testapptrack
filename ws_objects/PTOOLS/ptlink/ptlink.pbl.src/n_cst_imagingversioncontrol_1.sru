$PBExportHeader$n_cst_imagingversioncontrol_1.sru
forward
global type n_cst_imagingversioncontrol_1 from n_cst_imagingversioncontrol
end type
end forward

global type n_cst_imagingversioncontrol_1 from n_cst_imagingversioncontrol
end type
global n_cst_imagingversioncontrol_1 n_cst_imagingversioncontrol_1

type prototypes
SUBROUTINE IX_Unlock ( long pw1, long pw2, long pw3, long pw4) &
	LIBRARY "imagxpr4.dll"  ALIAS FOR "PS_Unlock"

SUBROUTINE PP_Unlock ( long pw1, long pw2, long pw3, long pw4) &
	LIBRARY "PrntPRO1.ocx" ALIAS FOR "PS_Unlock"


end prototypes

forward prototypes
public function integer of_unlock ()
public function string of_getimagexpressobjectstring ()
public function string of_getprintproobjectstring ()
public function integer of_setcompression (ref oleobject anv_imageole)
end prototypes

public function integer of_unlock ();IX_Unlock( 1908224506, 378711776, 1341927877, 10527 )
PP_Unlock( 1908224506, 378711776, 1341927877, 10527 )

RETURN 1
end function

public function string of_getimagexpressobjectstring ();RETURN "ImagXpr4.ImagXpress.1"
end function

public function string of_getprintproobjectstring ();RETURN "PrintPRO.PrintPRO.1" 
end function

public function integer of_setcompression (ref oleobject anv_imageole);IF isValid ( anv_imageole )THEN
	anv_imageole.SaveTIFCompression = 3  // group 4 b/w
END IF

RETURN 1
end function

on n_cst_imagingversioncontrol_1.create
call super::create
end on

on n_cst_imagingversioncontrol_1.destroy
call super::destroy
end on

event constructor;call super::constructor;ir_Version = cr_version_4
end event

