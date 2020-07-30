$PBExportHeader$n_cst_pegasus_print.sru
forward
global type n_cst_pegasus_print from n_cst_base
end type
end forward

global type n_cst_pegasus_print from n_cst_base
end type
global n_cst_pegasus_print n_cst_pegasus_print

type prototypes
SUBROUTINE IX_Unlock ( long pw1, long pw2, long pw3, long pw4) &
	LIBRARY"imagxpr6.dll"  ALIAS FOR "PS_Unlock"

SUBROUTINE PP_Unlock ( long pw1, long pw2, long pw3, long pw4) &
	LIBRARY "PrntPRO2.dll" ALIAS FOR "PS_Unlock"
end prototypes

type variables
Private:

oleObject		inv_OlePrint
oleObject		inv_OleImage

CONSTANT Long	cl_Right = 10900
CONSTANT Long	cl_Left = 500
CONSTANT Long	cl_Top = 500
CONSTANT Long	cl_Bottom = 15100



end variables

forward prototypes
private function integer of_getimagecontrol (ref oleobject anv_oleimage)
public function integer of_getprintcontrol (ref oleobject anv_oleprint)
public function integer of_print (string as_type, long al_id, n_cst_msg anv_msg)
public function integer of_printsetup (ref n_cst_msg anv_msg)
public function integer of_gettitlequadrant (ref string as_quadrant)
public function integer of_gettitlecoords (ref long al_x, ref long al_y)
public function integer of_printdefaults (ref n_cst_msg anv_msg)
public function integer of_print (long ala_ids, n_cst_beo_imagetype anv_imagetype)
public function integer of_getimageprintregion (ref long al_y, ref long al_height, long al_sourceheight)
public function integer of_gettitlecoords (integer ai_titlelength, ref long al_x, ref long al_y)
end prototypes

private function integer of_getimagecontrol (ref oleobject anv_oleimage);/*
 1  Success
-1  Invalid Call: the argument is the Object property of a control
-2  Class name not found
-3  Object could not be created
-4  Could not connect to object
-9  Other error
*/


Int			li_ReturnValue = 1
OleObject	lnv_OleImage
n_cst_imagingversioncontrol	lnv_version
n_cst_bso_imagemanager	 		lnv_Imagemanager

 
lnv_Imagemanager  = CREATE n_cst_bso_imagemanager
IF lnv_Imagemanager.of_GetImagingversioncontrol( lnv_Version ) <> 1 THEN
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1  THEN
	IF IsValid ( inv_oleImage ) THEN
		anv_OleImage = inv_oleImage 
	ELSE
		lnv_OleImage = Create OleObject
		li_ReturnValue = lnv_OleImage.ConnectToNewObject ( lnv_version.of_getimagexpressobjectstring( ) )
	
		IF li_ReturnValue = 0 THEN
			anv_OleImage = lnv_OleImage
			inv_oleImage = lnv_OleImage
			li_ReturnValue = 1
		END IF
		
	END IF
END IF

DESTROY lnv_Imagemanager
DESTROY lnv_version

Return li_ReturnValue
end function

public function integer of_getprintcontrol (ref oleobject anv_oleprint);/*
 1  Success
-1  Invalid Call: the argument is the Object property of a control
-2  Class name not found
-3  Object could not be created
-4  Could not connect to object
-9  Other error
*/


Int			li_ReturnValue = 1
OleObject	lnv_OlePrint
n_cst_imagingversioncontrol	lnv_version
n_cst_bso_imagemanager	 		lnv_Imagemanager

 
lnv_Imagemanager  = CREATE n_cst_bso_imagemanager
IF lnv_Imagemanager.of_GetImagingversioncontrol( lnv_Version ) <> 1 THEN
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1  THEN

	IF IsValid ( inv_oleprint ) THEN
		anv_OlePrint = inv_oleprint 
	ELSE
		lnv_OlePrint = Create OleObject
		li_ReturnValue = lnv_OlePrint.ConnectToNewObject ( lnv_Version.of_getprintproobjectstring( ) )
	
		IF li_ReturnValue = 0 THEN
			anv_OlePrint = lnv_OlePrint
			inv_oleprint = lnv_OlePrint
			li_ReturnValue = 1
		END IF
		
	END IF
END IF

DESTROY lnv_Imagemanager
DESTROY lnv_version

Return li_ReturnValue
end function

public function integer of_print (string as_type, long al_id, n_cst_msg anv_msg);Int		li_NumPages
Int		i
Int		j
Int		li_ImageCount
Int		li_PrintError
Int		li_ReturnValue = 1


n_cst_beo_image						lnva_Images[]
n_cst_beo_image						lnv_CurrentImage
n_cst_Beo_imagetype					lnva_ImageTypes[]
n_cst_bso_ImageManager_pegasus	lnv_ImageManager
n_cst_imagingversioncontrol		lnv_Version
OleObject	lnv_ImageOle
Oleobject 	lnv_PrintOle



lnv_ImageManager = Create n_cst_bso_ImageManager_pegasus   


IF  THIS.of_GetPrintControl ( lnv_PrintOle ) <> 1 THEN
	li_ReturnValue = -1
ELSE
	IF THIS.of_GetImageControl ( lnv_ImageOle ) <> 1 THEN
		li_ReturnValue = -1
	END IF
END IF

IF lnv_ImageManager.of_Getimagingversioncontrol( lnv_Version ) = 1  THEN
	// unlock the  Pegasus Controls
	lnv_Version.of_Unlock( )
ELSE 
	li_ReturnValue = -1
END IF

	
IF isValid ( lnv_ImageOle ) AND isValid ( lnv_PrintOle ) AND li_ReturnValue = 1 THEN
	
//	IX_Unlock( 1908224506, 378711776, 1341927877, 10527 )
//	PP_Unlock( 1908224506, 378711776, 1341927877, 10527 )
//
	lnv_imagemanager.of_GetImageTypesForType ( as_Type , lnva_ImageTypes )
	
	lnv_ImageManager.of_GenerateImageList ( {al_ID}, lnva_ImageTypes, lnva_Images )	

	IF upperbound ( lnva_Images ) > 0 THEN // zmc 3/12/04
	
		FOR j = 1 TO upperbound ( lnva_Images )
	
			lnv_CurrentImage = lnva_Images[j]
			
			lnv_CurrentImage.of_Print (lnv_PrintOle , lnv_ImageOle, anv_msg  )
				
		NEXT
	ELSE 							// zmc 3/12/04
		//li_ReturnValue = -1  // zmc 3/12/04    /// I commented this line <<*>> 4/30/04
	END IF 						// zmc 3/12/04
	
END IF

DESTROY ( lnv_Version )
IF isValid ( lnv_ImageManager ) THEN
	DESTROY lnv_Imagemanager
END IF
Return li_ReturnValue



end function

public function integer of_printsetup (ref n_cst_msg anv_msg);/*
		return Values: 
							 1 = success
							-1 = failure
							-2 = user canceled
							-3 = Imaging Not installed
*/

OleObject	lnv_PrintOle

Int			li_binNum
Int			li_Copies
Int			li_orientation
Int			li_PaperSize
String		ls_PrinterName

Int			li_ReturnValue = 1
String		lsa_PrintTypes[]
Long			ll_X
Long			ll_Y
Long			ll_Error

s_parm				lstr_Parm

//n_cst_billing		lnv_billing	
//lnv_Billing = Create n_cst_billing

// IF Imaging is installed then

//	lnv_Billing.of_GetImagesToPrint ( lsa_PrintTypes ) 

//	IF UpperBound ( lsa_PrintTypes ) > 0 THEN
		
		IF THIS.of_GetPrintControl ( lnv_PrintOle ) = 1 THEN
		
			IF isValid ( lnv_PrintOle ) THEN 
				MessageBox( "Printer Settings for Associated Images" , + &
				  "Please select the properties for the document images in the folowing dialog box")  
				lnv_PrintOle.PrintDialog ( )
				
				ll_Error = lnv_PrintOle.PrintError
			
				IF ll_Error = -3018 OR ll_Error = -3005 THEN
					li_ReturnValue = -2
					
				ELSE
					
					THIS.of_GetTitleCoords ( ll_X , ll_Y )	
					lnv_PrintOle.CurrentX = ll_X
					lnv_PrintOle.CurrentY = ll_Y
					lnv_PrintOle.SetCtlFontSize( 16 )
				
				END IF
			END IF
		ELSE
			li_ReturnValue = -1
		END IF
//	END IF
	
//ELSE
//	li_returnValue = -3
	
//END IF
	
IF li_ReturnValue = 1 THEN
	
	lstr_Parm.is_Label = "SETTINGS"
	lstr_Parm.ia_Value = lnv_PrintOle
	anv_Msg.of_Add_parm( lstr_Parm )

END IF

//DESTROY lnv_Billing

return li_ReturnValue
end function

public function integer of_gettitlequadrant (ref string as_quadrant);//Returns:   1 = Success (value returned by reference in as_Quadrant)
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1

n_cst_string	lnv_String



//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 35 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( ls_Description ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	
	as_Quadrant = ls_description
	
END IF
 

RETURN li_Return

end function

public function integer of_gettitlecoords (ref long al_x, ref long al_y);String	ls_Quadrant

Long		ll_X
Long		ll_Y

Int	li_ReturnValue


li_ReturnValue = THIS.of_GetTitleQuadrant ( ls_Quadrant )

//IF li_ReturnValue = 1 THEN
	CHOOSE CASE ls_Quadrant
			
		CASE "UR!"
			ll_X = cl_Right
			ll_Y = cl_Top
			
		CASE "UL!"
			ll_X = cl_Left
			ll_Y = cl_Top
			
		CASE "LR!"
			ll_X = cl_Right
			ll_Y = cl_Bottom
			
			
		CASE "LL!"
			ll_X = cl_Left
			ll_Y = cl_Bottom
		CASE ELSE
			ll_X = cl_Right
			ll_Y = cl_Bottom
			
	END CHOOSE
	
	al_x = ll_X
	al_y = ll_Y
	
//END IF

Return li_ReturnValue
end function

public function integer of_printdefaults (ref n_cst_msg anv_msg);/* of_PrintDefaults RDT 4-1-03
		return Values: 
							 1 = success
							-1 = failure
*/

OleObject	lnv_PrintOle

Int			li_binNum
Int			li_Copies
Int			li_orientation
Int			li_PaperSize
String		ls_PrinterName

Int			li_ReturnValue = 1
String		lsa_PrintTypes[]
Long			ll_X
Long			ll_Y
Long			ll_Error

s_parm				lstr_Parm

n_cst_billing		lnv_billing	
lnv_Billing = Create n_cst_billing


	lnv_Billing.of_GetImagesToPrint ( lsa_PrintTypes ) 

	IF UpperBound ( lsa_PrintTypes ) > 0 THEN
		
		IF THIS.of_GetPrintControl ( lnv_PrintOle ) = 1 THEN
		
			IF isValid ( lnv_PrintOle ) THEN 
					
					THIS.of_GetTitleCoords ( ll_X , ll_Y )	
					lnv_PrintOle.CurrentX = ll_X
					lnv_PrintOle.CurrentY = ll_Y
					lnv_PrintOle.SetCtlFontSize( 16 )
				
			END IF
		ELSE
			li_ReturnValue = -1
		END IF
	END IF
	

	
IF li_ReturnValue = 1 THEN
	
	lstr_Parm.is_Label = "SETTINGS"
	lstr_Parm.ia_Value = lnv_PrintOle
	anv_Msg.of_Add_parm( lstr_Parm )

END IF

DESTROY lnv_Billing

return li_ReturnValue
end function

public function integer of_print (long ala_ids, n_cst_beo_imagetype anv_imagetype);Int		li_NumPages
Int		i
Int		j
Int		li_ImageCount
Int		li_PrintError
Int		li_Return = 1

n_cst_beo_image						lnva_Images[]
n_cst_beo_image						lnv_CurrentImage
n_cst_imagingversioncontrol		lnv_Version
n_cst_bso_ImageManager_pegasus	lnv_ImageManager
OleObject								lnv_ImageOle
Oleobject 								lnv_PrintOle

lnv_ImageManager = Create n_cst_bso_ImageManager_pegasus   
lnv_ImageManager = Create n_cst_bso_ImageManager_pegasus  

THIS.of_GetPrintControl ( lnv_PrintOle )
THIS.of_GetImageControl ( lnv_ImageOle )

IF	lnv_ImageManager.of_Getimagingversioncontrol( lnv_Version ) = 1 THEN
	// these unlock the pegasus controls. 
	lnv_Version.of_Unlock( )
ELSE
	li_Return = -1
END IF

IF isValid ( lnv_ImageOle ) AND isValid ( lnv_PrintOle ) AND li_Return = 1 THEN
	

//	IX_Unlock( 1908224506, 378711776, 1341927877, 10527 )
//	PP_Unlock( 1908224506, 378711776, 1341927877, 10527 )

	//lnv_ImageOle.Update = FALSE
	lnv_ImageManager.of_GenerateImageList ( {ala_IDs}, {anv_ImageType}, lnva_Images )
	
	li_ImageCount = upperbound ( lnva_Images )

	For j = 1 TO li_ImageCount
				
		IF j = 1 THEN
			lnv_printOle.Orientation = 1 // portrait
			lnv_printOle.PrintDialog()
			li_PrintError = lnv_printOle.printError 
			IF li_PrintError = -3005 THEN  // user canceled
				EXIT 
			END IF

		END IF
		lnv_CurrentImage = lnva_Images[j]
		
		li_NumPages = lnv_CurrentImage.of_CalcPages ( lnv_ImageOle )

		lnv_PrintOle.StartPrintDoc( ) 
				
		// loop to print multi-page docs
		FOR i = 1 TO li_NumPages
		

			lnv_ImageOle.pageNbr = i
			lnv_ImageOle.FileName = lnv_CurrentImage.of_GetFilePAth ( )
		
			lnv_PrintOle.hdib =  lnv_ImageOle.hDib
			
			lnv_PrintOle.PrintDIB ( 0, 0 , lnv_PrintOle.scaleWidth - 1 , lnv_PrintOle.scaleHeight - 1 , 0,0,0,0, TRUE )
			
			IF i < li_NumPages THEN
		 		lnv_PrintOle.NewPage()
			END IF
			
		NEXT
		
			lnv_PrintOle.EndPrintDoc ()
			
	NEXT
	
	//lnv_ImageOle.update = TRUE
	
END IF

DESTROY ( lnv_Version )
IF isValid ( lnv_ImageManager ) THEN
	Destroy lnv_ImageManager
END IF
return li_Return



end function

public function integer of_getimageprintregion (ref long al_y, ref long al_height, long al_sourceheight);String	ls_Quadrant

Long		ll_Y
Long		ll_Height

Int	li_ReturnValue


li_ReturnValue = THIS.of_GetTitleQuadrant ( ls_Quadrant )

//IF li_ReturnValue = 1 THEN
	CHOOSE CASE ls_Quadrant
			
		CASE "UR!", "UL!"
			
			ll_Y = cl_top + 300
			ll_Height = al_sourceheight - 800		
			
		CASE ELSE
			ll_Y = 0
			ll_Height = al_sourceheight - 300
			
	END CHOOSE		
	
	al_height = ll_Height
	al_y = ll_Y
	
//END IF

Return li_ReturnValue
end function

public function integer of_gettitlecoords (integer ai_titlelength, ref long al_x, ref long al_y);String	ls_Quadrant

Long		ll_X
Long		ll_Y

Int	li_ReturnValue

li_ReturnValue = THIS.of_GetTitleQuadrant ( ls_Quadrant )

//IF li_ReturnValue = 1 THEN
	CHOOSE CASE ls_Quadrant
			
		CASE "UR!"
			ll_X = cl_Right - ( ai_titlelength * 125 ) 
			ll_Y = cl_Top
			
		CASE "UL!"
			ll_X = cl_Left
			ll_Y = cl_Top
			
		CASE "LR!"
			ll_X = cl_Right - ( ai_titlelength * 125 ) 
			ll_Y = cl_Bottom
						
		CASE "LL!"
			ll_X = cl_Left
			ll_Y = cl_Bottom
		CASE ELSE
			ll_X = cl_Right - ( ai_titlelength * 125 ) 
			ll_Y = cl_Bottom
			
	END CHOOSE
	
	al_x = ll_X
	al_y = ll_Y
	
//END IF

Return li_ReturnValue
end function

on n_cst_pegasus_print.create
call super::create
end on

on n_cst_pegasus_print.destroy
call super::destroy
end on

event destructor;call super::destructor;IF isValid ( inv_oleimage ) THEN
	inv_oleimage.DisconnectObject ( )
	IF isValid (  inv_oleimage ) THEN
		DESTROY inv_oleimage
	END IF
END IF

IF Isvalid ( inv_oleprint ) THEN
	inv_oleprint.DisconnectObject ( )
	IF Isvalid ( inv_oleprint ) THEN
		DESTROY inv_oleprint
	END IF
END IF

end event

event constructor;call super::constructor;// these unlock the pegasus controls. 
//IX_Unlock( 1908224506, 378711776, 1341927877, 10527 )
//PP_Unlock( 1908224506, 378711776, 1341927877, 10527 )
n_cst_bso_imagemanager				lnv_ImageManager
n_cst_imagingversioncontrol		lnv_Version
lnv_ImageManager = Create n_cst_bso_ImageManager_pegasus   
IF lnv_ImageManager.of_Getimagingversioncontrol( lnv_Version ) = 1 THEN
	lnv_Version.of_Unlock( )
END IF

DESTROY ( lnv_ImageManager )
DESTROY ( lnv_Version )
end event

