$PBExportHeader$n_cst_imagingversioncontrol_2.sru
forward
global type n_cst_imagingversioncontrol_2 from n_cst_imagingversioncontrol
end type
end forward

global type n_cst_imagingversioncontrol_2 from n_cst_imagingversioncontrol
end type
global n_cst_imagingversioncontrol_2 n_cst_imagingversioncontrol_2

type prototypes
SUBROUTINE IX_Unlock ( long pw1, long pw2, long pw3, long pw4) &
	LIBRARY "imagxpr7.dll"  ALIAS FOR "PS_Unlock"

//SUBROUTINE PP_Unlock ( long pw1, long pw2, long pw3, long pw4) &
//	LIBRARY "PrntPRO2.dll" ALIAS FOR "PS_Unlock"

SUBROUTINE PP_Unlock ( long pw1, long pw2, long pw3, long pw4) &
	LIBRARY "PrntPRO1.ocx" ALIAS FOR "PS_Unlock"
end prototypes

forward prototypes
public function integer of_unlock ()
public function string of_getimagexpressobjectstring ()
public function string of_getprintproobjectstring ()
public function integer of_setcompression (ref oleobject anv_imageole)
end prototypes

public function integer of_unlock ();IX_Unlock( 1908224365, 373706624, 1341694595, 29587 )
//PP_Unlock( 1908224365, 373706624, 1341694595, 29587 )
PP_Unlock( 1908224506, 378711776, 1341927877, 10527 ) // notice the numbers are differnt b.c. we are
																		// still using version 1 of Print Pro

RETURN 1
end function

public function string of_getimagexpressobjectstring ();RETURN "ImagXpr7.ImagXpress.1"
end function

public function string of_getprintproobjectstring ();//The PT install routine does not upgrade to printpro 3, 
//so we are still going to use printpro 1

//When our install routine updates printpro to version 3, 
//This should be changed to "PrintPRO3.PrintPRO.1"

RETURN "PrintPRO.PrintPRO.1"
end function

public function integer of_setcompression (ref oleobject anv_imageole);IF isValid ( anv_imageole )THEN
	anv_imageole.SaveTIFFCompression = 3  // group 4 b/w
END IF

RETURN 1
end function

on n_cst_imagingversioncontrol_2.create
call super::create
end on

on n_cst_imagingversioncontrol_2.destroy
call super::destroy
end on

event constructor;call super::constructor;ir_Version = cr_version_7
end event

