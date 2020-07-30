$PBExportHeader$n_cst_beo_image.sru
$PBExportComments$Image (Persistent Class from PBL map PTData) //@(*)[49978537|1341]
forward
global type n_cst_beo_image from n_cst_beo
end type
end forward

global type n_cst_beo_image from n_cst_beo
event ue_imagesaved ( )
end type
global n_cst_beo_image n_cst_beo_image

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_beo inv_imagetype //@(*)[49978537|1341:imagetype]<nosync>
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.
Protected:
oleObject		io_ScanObject
oleObject		io_ImageObject
oleObject		io_BarcodeObject
oleObject		io_PrintObject
Datastore	ids_modLog				//added by dan
String		is_modString
Public:
Int		ii_NumberPages
Int		ii_CurrentPageNo = 1
n_cst_bso_ImageManager_pegasus	inv_ImageManager

end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly String as_name, readonly any aa_value)
protected function integer getattribute (readonly String as_name, ref any aa_value)
public function String of_GetTopic ()
public function Integer of_SetTopic (String as_topic)
public function String of_GetCategory ()
public function Integer of_SetCategory (String as_category)
public function String of_GetType ()
public function Integer of_SetType (String as_type)
public function String of_GetFilepath ()
public function integer of_setfilepath (string as_filepath)
public function Long of_GetId ()
public function n_cst_beo of_getimagetype ()
public function n_cst_beo of_getimagetype (string as_query)
public function Integer of_SetImagetype (n_cst_beo anv_imagetype)
public function integer of_deleteimage ()
private function integer of_calculatepath ()
public function integer of_save (string as_oldfilepath)
public function integer of_move (n_cst_beo_imagetype anv_imagetype, long al_imageid)
public function integer of_print (oleobject anv_oleprint, oleobject anv_oleimage)
protected function integer of_setnumberpages (integer ai_NumberPages)
public function integer of_calcpages (oleobject anv_imageobject)
public function integer of_getnumberpages ()
public function integer of_changetype (string as_type)
public function integer of_changecategory (string as_category)
public function integer of_print (oleobject anv_oleprint, oleobject anv_oleimage, n_cst_msg anv_msg)
public function integer of_saverotation (integer ai_pagenum, long al_position)
public function integer of_copyimage (readonly long al_shipid)
public function integer of_setid (long al_id)
public function integer of_setid (long al_id, boolean ab_movefile)
private function integer of_changetypefromnone (string as_type)
public function datastore of_getmodlog ()
public function integer of_updatemodlog (string as_moddescript)
public function integer of_updatemodlog (long al_id, string as_moddescript)
public function long of_getdivision ()
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_image")
inv_bcm.RegisterRelationshipAttribute("topic", "string(32767)", "n_cst_beo_imagetype", "topic", "imagetype")
inv_bcm.RegisterRelationshipAttribute("category", "string(32767)", "n_cst_beo_imagetype", "category", "imagetype")
inv_bcm.RegisterRelationshipAttribute("type", "string(32767)", "n_cst_beo_imagetype", "type", "imagetype")
inv_bcm.RegisterAttribute("filepath", "string(32767)") //@(*)[50011511|1342]
inv_bcm.RegisterAttribute("id", "long") //@(*)[50332966|1344]
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("topic", "Image", "Topic")
   inv_bcm.MapDBColumn("category", "Image", "Category")
   inv_bcm.MapDBColumn("type", "Image", "Type")
   inv_bcm.MapDBColumn("filepath", "Image", "FilePath")
   inv_bcm.MapDBColumn("id", "Image", "Id")
end if 
//@(text)--


return 1
end function

protected function integer setattribute (readonly String as_name, readonly any aa_value);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attribute Case>
int li_rc

li_rc = super::SetAttribute(as_name, aa_value)

if li_rc <> 0 then
    return li_rc
end if

choose case as_name
 case "topic" 
   return of_SetTopic(String(aa_value))
 case "category" 
   return of_SetCategory(String(aa_value))
 case "type" 
   return of_SetType(String(aa_value))
 case "filepath" 
   return of_SetFilepath(String(aa_value))
 case "id" 
   return of_SetId(Long(aa_value))
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return 0
//@(text)--

end function

protected function integer getattribute (readonly String as_name, ref any aa_value);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attribute Case>
integer li_rc

li_rc = super::GetAttribute(as_name, aa_value)

if li_rc <> 0 then
    return li_rc
end if

choose case as_name
 case "topic" 
   aa_value = of_GetTopic()
   li_rc = 1
 case "category" 
   aa_value = of_GetCategory()
   li_rc = 1
 case "type" 
   aa_value = of_GetType()
   li_rc = 1
 case "filepath" 
   aa_value = of_GetFilepath()
   li_rc = 1
 case "id" 
   aa_value = of_GetId()
   li_rc = 1
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function String of_GetTopic ();//@(*)[10383519|988:topic:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("topic")
//@(text)--

end function

public function Integer of_SetTopic (String as_topic);//@(*)[10383519|988:topic:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "topic" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("topic", as_topic) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetCategory ();//@(*)[10633532|989:category:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("category")
//@(text)--

end function

public function Integer of_SetCategory (String as_category);//@(*)[10633532|989:category:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "category" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

Int	li_NullRtn

IF  ( NOT isNull ( THIS.of_GetFilePath ( ) ) )  THEN 
		
	li_nullRtn = 1
	IF THIS.of_ChangeCategory ( as_category ) = -1 THEN 
			
		li_rc = -1
		
	END IF	

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("category", as_category) < 1 then
      li_rc = -1
   end if
end if
//@(text)--
IF li_Rc > 0 THEN
	This.of_CalculatePath ( )
	 
	
	IF isValid ( w_imaging ) AND li_NullRtn = 1 THEN
		w_imaging.wf_DisplayImage ( THIS )
	END IF

END IF
//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--



end function

public function String of_GetType ();//@(*)[10654161|990:type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("type")
//@(text)--

end function

public function Integer of_SetType (String as_type);//@(*)[10654161|990:type:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "type" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

Int	li_NullRtn

IF  ( NOT isNull ( THIS.of_GetFilePath ( ) ) )  THEN 
		
	li_nullRtn = 1
	IF THIS.of_ChangeType ( as_type ) = -1 THEN 
			
		li_rc = -1
		
	END IF	

END IF



//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("type", as_type) < 1 then
      li_rc = -1
   end if
end if
//@(text)--
IF li_Rc > 0 THEN
	This.of_CalculatePath ( )
	 
	IF isValid ( w_imaging ) AND li_NullRtn = 1 THEN
		w_imaging.wf_DisplayImage ( THIS )
	END IF

END IF
//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetFilepath ();//@(*)[50011511|1342:filepath:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>
//THIS.of_CalculatePath ( )
return GetValue("filepath")
//@(text)--

end function

public function integer of_setfilepath (string as_filepath);//@(*)[50011511|1342:filepath:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "filepath" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("filepath", as_filepath) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetId ();//@(*)[50332966|1344:id:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("id")
//@(text)--

end function

public function n_cst_beo of_getimagetype ();//@(*)[50095669|1343:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetImagetype(ls_dlkname)
//@(text)--

/* ***** CAUTION!!! CALLING THIS METHOD MAY CAUSE MEMORY LEAKS ***** */
end function

public function n_cst_beo of_getimagetype (string as_query);//@(*)[50095669|1343]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_imagetype = GetRelationship( inv_imagetype, "n_cst_dlkc_imagetype",  "imagetype", "image", as_query, "n_cst_beo_imagetype" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_imagetype
//@(text)--


/* ***** CAUTION!!! CALLING THIS METHOD MAY CAUSE MEMORY LEAKS ***** */
end function

public function Integer of_SetImagetype (n_cst_beo anv_imagetype);//@(*)[50095669|1343:so]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_imagetype,"imagetype") = 1 then
inv_imagetype = anv_imagetype
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

public function integer of_deleteimage ();Int	li_Return
String	ls_descript
IF  FileDelete ( This.of_GetFilePath ( ) ) THEN
	//added by dan to log a delettion of an image
	ls_descript = "Deleted "+this.of_getType( )+" image id "+ string(this.of_getid( ))
	this.of_updatemodlog( ls_descript )
	//-------------------------------------------
	li_Return = 1
ELSE
	li_Return = -1
END IF



Return li_Return
end function

private function integer of_calculatepath ();//RDT 7-29-03 do not set path if type = "NONE" or IsNull(type)
String 	ls_Range
string  	ls_lowRange
string 	ls_Path
String	lsa_NodeFolders	[]	// individual folder names used to tack onto paths
string	lsa_PathParts[]
String	ls_Root
String 	ls_Category
String 	ls_type
String	ls_Topic
string  	ls_Group

long		ll_Cat
long		lla_Span[]
long		ll_ID

ulong		lul_LowLim  
ulong		lul_ValueTemp
ulong		lul_Value

Int		li_UpperBound
Int 		i
Int 		j
Int	 	li_partsCount
Int		li_PathCounter
Int		li_ReturnValue = 1

n_cst_filesrvWin32  lnv_win32
lnv_win32 = create n_cst_filesrvWin32

n_cst_Bso_ImageManager_pegasus lnv_ImageManager
lnv_ImageManager = Create n_cst_Bso_ImageManager_pegasus

lla_Span[1] = 8000000
lla_Span[2] = 40000
lla_Span[3] = 200
	

ls_Root = lnv_ImageManager.of_GetRoot ( )

IF NOT Len( ls_Root ) > 0 THEN
	li_returnValue = -1
END IF

IF li_ReturnValue = 1 THEN
	ls_Category = THIS.of_GetCategory ( )
	ls_Topic = THIS.of_GetTopic ( )
	ls_Type	= THIS.of_GetType ( ) 
	
	lul_Value = THIS.of_GetID ( )
	
	li_PathCounter = 1
	
	
	lsa_PathParts [ li_Pathcounter ] = ""
	lsa_NodeFolders [ li_PathCounter ] = ls_category
	
	li_PathCounter ++ // = 2
	lsa_PathParts[ li_PathCounter ] = ls_category
	lsa_NodeFolders[ li_PathCounter ] = ls_topic
	
	li_PathCounter++ // = 3
	lsa_PathParts[ li_PathCounter ] =  ls_category + "\" + ls_topic
	lsa_NodeFolders [ li_PathCounter ] = ls_type
	
	li_PathCounter++  // = 4
	lsa_PathParts[ li_PathCounter ] = ls_category + "\" + ls_topic + "\" + ls_type


	For li_PathCounter = 5 To 7
	
		If li_PathCounter = 5 THEN
			lul_ValueTemp = lul_value
		Else 
			lul_ValueTemp = mod ( lul_Value , lla_Span[ li_PathCounter - 5 ] )  // previous span
		END IF
			
		ll_Cat = int ( lul_ValueTemp / lla_Span[ li_PathCounter - 4 ] ) + 1
		ls_group = String(ll_Cat,"#,000")
		
		lul_LowLim = lul_Value - ( mod ( lul_Value , lla_Span[ li_PathCounter - 4  ] ) )
		
		If lul_LowLim > 0 THEN
			ls_lowRange = string ( lul_LowLim,"#,000" )
		Else
			ls_lowRange = String ( lul_LowLim )
		END IF
			
		ls_Range = ls_group+ " " + ls_lowRange 
		lsa_PathParts [ li_PathCounter ] = lsa_PathParts [ li_PathCounter - 1 ] + "\" + ls_Range	
		lsa_NodeFolders[ li_PathCounter - 1] = ls_Range		
	
	NEXT

	lsa_NodeFolders[ li_PathCounter - 1 ] = String ( lul_Value,"#,000" )	

	lsa_PathParts [ li_PathCounter ] = lsa_PathParts [ li_PathCounter - 1 ] + "\" + lsa_NodeFolders [ li_pathCounter - 1 ]

	ls_Path = ls_Root + lsa_PathParts[ upperBound ( lsa_PathParts ) ] + "\" + lsa_NodeFolders [ upperbound ( lsa_NodeFolders ) ] + ".TIF"

END IF


IF NOT Len ( ls_Path ) > 0 THEN
	li_returnValue = -1
END IF

IF li_returnValue = 1 THEN
	if IsNull( ls_Type ) or ls_Type	= "NONE" Then 	//RDT 7-29-03 
		// do not set file path 							//RDT 7-29-03 
	else															//RDT 7-29-03 
		THIS.of_SetFilePath ( ls_path ) 
	end if														//RDT 7-29-03 
	
	//this code creates the folders to prepare for save
	
	li_partsCount = upperBound ( lsa_pathparts[ ] )
	
	j = 1
	DO While ( (j <= li_PartsCount ) AND ( lnv_Win32.of_directoryExists ( lsa_PathParts [ j ] ) ))
		j ++
	Loop
	
	For i = j To li_PartsCount
		lnv_win32.of_createDirectory (ls_Root + lsa_pathparts[ i ] )
	next

END IF

DESTROY lnv_win32
DESTROY lnv_ImageManager


Return li_ReturnValue
end function

public function integer of_save (string as_oldfilepath);/* As implemented the save method acts as copy, 
there is a move function as well in the image object*/
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs reading the source file,
//					-2 if an error occurrs writting to the target file.
//


String	ls_SourcePath
String	ls_TargetPath


n_cst_Filesrv 	lnv_FileSrv
lnv_FileSrv = create n_cst_Filesrv
This.of_CalculatePath ( ) 

ls_SourcePath = as_OldFilePath

ls_TargetPath = This.of_GetFilePath ( )

DESTROY lnv_FileSrv

RETURN lnv_FileSrv.of_FileCopy ( ls_SourcePath , ls_TargetPath , TRUE ) // true = append





end function

public function integer of_move (n_cst_beo_imagetype anv_imagetype, long al_imageid);String	ls_TargetPath
String 	ls_OldPath

Int		li_ReturnValue = 1
Int		li_NumberPages
INT		i
Int		li_ImageError
Boolean	lb_Append 

String	ls_topic
String	ls_Type
String	ls_Category
String	lsa_pathParts[ ]
String	lsa_NodeFolders[ ]

n_cst_imagingversioncontrol		lnv_Version
n_cst_Beo_ImageType					lnv_ImageType
n_cst_ShipmentManager				lnv_ShipmentManager
n_cst_bso_ImageManager_pegasus	lnv_ImageManager
n_cst_Filesrv 							lnv_FileSrv
oleObject								lnv_SaveOle


Long			ll_lastParenth			//added by dan
Long			ll_lastPer				//added by dan
Long			ll_newModRow
Long			ll_index
Int			li_result
String		ls_modDescript
String		ls_oldId
String		ls_newId

DateTime		ldt_now

lnv_ImageManager 	= CREATE n_cst_bso_ImageManager_pegasus
lnv_FileSrv 		= create n_cst_Filesrv
lnv_SaveOle 		= Create oleObject


IF li_ReturnValue = 1 THEN
	IF lnv_ImageManager.of_GetImagingversioncontrol( lnv_Version ) <> 1 THEN
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	IF lnv_Saveole.ConnectToNewObject (lnv_Version.of_getimagexpressobjectstring( ) ) <> 0 THEN
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	CHOOSE CASE lnv_ShipmentManager.of_ShipmentExists ( al_imageid )
	
	CASE TRUE
		//Exists
	
	CASE FALSE
		li_ReturnValue = -1
		//Does not exist
	
	CASE ELSE
		li_ReturnValue = -1
		//Error -- Could not determine
	
	END CHOOSE
	
END IF

IF li_ReturnValue = 1 THEN

	SetPointer ( HOURGLASS! )

	ls_OldPath = This.of_GetFilePath ( ) 
	
	//added by dan
	ll_lastParenth = LastPos( ls_oldPath, "\" )
	ll_lastPer = LastPos( ls_oldPath, "." )
	//gets everything in between the last slash and the last period...should equal the old tmp id
	ls_oldId = Mid( ls_oldPath, ll_lastParenth + 1, ll_lastPer - (ll_lastParenth + 1) )
	//------------------------
	
	ls_Topic = THIS.of_GetTopic ( )
	ls_Type = THIS.of_GetType ( )
	ls_Category = THIS.of_GetCategory ( )
	

	THIS.of_CalculatePath ( )
	
	ls_TargetPath = THIS.OF_GetFilePath ( )
	
	//added by dan
	ll_lastParenth = LastPos( ls_TargetPath, "\" )
	ll_lastPer = LastPos( ls_TargetPath, "." )
	//gets everything in between the last slash and the last period...should equal the new tmp id
	ls_NewId = Mid( ls_TargetPath, ll_lastParenth + 1, ll_lastPer - (ll_lastParenth + 1) )
	//==================
	
	lnv_Version.of_SetCompression ( lnv_SaveOle )
	
	IF ls_TargetPath <> ls_OldPath THEN  // <<*>> 10/7/03  w.o. this, changing the image id when the type is not known
												 	//						 would apend the image to itself
		li_NumberPages = lnv_SaveOle.NumPages ( ls_oldPath) 
		//lnv_SaveOle.SaveTIFFCompression = 3  // group 4 b/w
		lnv_SaveOle.SaveMultiPage = TRUE
	//	lnv_SaveOle.Update = FALSE
		
		For i = 1 TO li_NumberPages
			lnv_saveOle.PageNbr = i
			lnv_SaveOle.FileName = ls_OldPath
			lnv_SaveOle.SaveFileName = ls_TargetPath
			lnv_SaveOle.SaveFile ( )
			li_ImageError = lnv_SaveOle.ImagError ( )
			
		NEXT
		
		//lnv_SaveOle.Update = TRUE
		
		IF Not ls_OldPath = ls_TargetPath AND li_ImageError = 0 THEN
			FileDelete ( ls_OldPath )
		END IF

		
		
		//added by dan
		//ll_index = ids_modLog.Find( "modid = "+ls_newId , ids_modLog.RowCount(), 1)
		
		IF len( ls_oldId ) > 0 THEN
			ls_modDescript = "("+ls_type+")"+ "Modified Id from "+ ls_oldId+ " to "+ls_newId
		END IF

		this.of_updatemodlog( ls_modDescript )
		
		//saves a record of the move to the old image modlog.
		IF len(ls_oldID) > 0 THEN
			this.of_updateModLog( long( ls_oldId ), ls_modDescript )
		END IF
		//-------------

	END IF
END IF


lnv_SaveOle.DisconnectObject ( )

DESTROY  lnv_Version
DESTROY 	lnv_FileSrv
DESTROY	lnv_ImageManager
DESTROY	lnv_SaveOle


Return li_ReturnValue

end function

public function integer of_print (oleobject anv_oleprint, oleobject anv_oleimage);//Int		li_NumPages
//Int		i
//String	ls_Type
//Long		ll_id
//String	ls_PageText
//
//OleObject	lnv_ImageOle
//
//oleobject lnv_PrintOle
//
//
//lnv_Imageole = anv_OleImage
//lnv_PrintOle = anv_OlePrint
//
//IF isValid ( lnv_ImageOle ) AND isValid ( lnv_PrintOle ) THEN
//	
//	ls_Type = THIS.of_GetType ()
//	ll_ID = THIS.of_GetID ( )
//	
//	ls_PageText = ls_Type + " " + String( ll_ID )
//	
//	li_NumPages = THIS.of_CalcPages ( anv_oleimage )
//	//IF isValid ( w_Imaging ) THEN
//		
//		
//		lnv_PrintOle.StartPrintDoc( ) 
//		
//
//		// loop to print multi-page docs
//		FOR i = 1 TO li_NumPages
//		
//		//	w_Imaging.wf_DisplayImage ( THIS , i ) 
//		lnv_ImageOle.pageNbr = i
//		lnv_ImageOle.FileName = THIS.of_GetFilePAth ( )
//		
//			lnv_PrintOle.hdib =  lnv_ImageOle.hDib
//			lnv_PrintOle.CurrentX = 10000
//			lnv_PrintOle.SetCtlFontSize( 16 )
//	
//			lnv_PrintOle.PrintText ( ls_PageText )					
//			lnv_PrintOle.PrintDIB ( 0, 0 , lnv_PrintOle.scaleWidth - 1 , lnv_PrintOle.scaleHeight - 1 , 0,0,0,0, TRUE )
//			
//			IF i < li_NumPages THEN
//		  		lnv_PrintOle.NewPage()
//			END IF
//			
//		NEXT
//			lnv_PrintOle.EndPrintDoc ()
//		//	lnv_ImageOle.update = TRUE
//			
//	//END IF
//	
//END IF
//
//	
return -1
//
//
//
end function

protected function integer of_setnumberpages (integer ai_NumberPages);IF ai_NumberPages > -1 THEN
	
	ii_numberpages = ai_NumberPages
	
ELSE 
	
	ii_NumberPages = 0 
	
END IF

Return ii_NumberPages
end function

public function integer of_calcpages (oleobject anv_imageobject);Int		li_NumberPages
String	ls_FilePath


ls_FilePath = THIS.of_GetFilePath ( )

IF Len ( ls_FilePath ) > 0 THEN

	IF isValid ( anv_imageobject ) THEN
		
		li_NumberPages = anv_ImageObject.NumPages ( ls_FilePath ) 
		THIS.of_SetNumberPages ( li_NumberPages ) 
	ELSE
		messageBox( "Imaging" , "An error occurred while attempting to calculate the number of pages.")
		li_NumberPages = -1
	END IF
ELSE 
	li_numberPages = -1
	
END IF  

Return li_NumberPages
end function

public function integer of_getnumberpages ();RETURN ii_numberpages
end function

public function integer of_changetype (string as_type);
Int		li_NumberPages
Int		i
Int		li_ImageError
Int		li_TypeCount
Boolean	lb_Append 
Long		ll_ID
String	ls_NewCategory
String	ls_Root
String	ls_topic
String	ls_Type
String	ls_Category
String	lsa_pathParts[ ]
String	lsa_NodeFolders[ ]
String	ls_TargetPath
String 	ls_OldPath
String	ls_oldType

Int		li_ReturnValue = 1

n_cst_beo_imagetype					lnva_ImageTypes[]
n_cst_bso_ImageManager_pegasus	lnv_ImageManager
n_cst_Filesrv 							lnv_FileSrv
n_cst_imagingversioncontrol		lnv_Version
oleObject								lnv_SaveOle

Long		ll_index
String	ls_moddescript
Long		ll_newModRow
DateTime ldt_now
Int		li_result

lnv_ImageManager	= CREATE n_cst_bso_ImageManager_pegasus
lnv_FileSrv 		= create n_cst_Filesrv
lnv_SaveOle 		= Create oleObject

IF li_ReturnValue = 1 THEN
	IF lnv_ImageManager.of_GetImagingversioncontrol( lnv_Version ) <> 1 THEN
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	IF IsNull ( THIS.of_GetID ( ) ) THEN
		li_Returnvalue = -1
		MessageBox("Image Attributes" , "Please assign an id to the image prior to altering the attributes" )
	END IF	
END IF

IF li_ReturnValue = 1 THEN
	IF lnv_Saveole.ConnectToNewObject (lnv_Version.of_getimagexpressobjectstring( ) ) <> 0 THEN
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	ls_Root = lnv_ImageManager.of_GetRoot ( )
END IF
ls_OldPath = This.of_GetFilePath ( ) 
ls_Category = This.of_GetCategory ( )
/////// <<*>>
li_TypeCount = lnv_ImageManager.of_GetImagetypesfortype( as_type , lnva_ImageTypes )
IF li_TypeCount > 0 THEN
	ls_NewCategory = lnva_ImageTypes[1].of_GetCategory( )
	
//	IF This.of_GetType ( ) = "NONE" THEN  
//		if SetValue("category", ls_NewCategory ) < 1 then
//			li_ReturnValue = -1
//		END IF
//	ELSE
		IF ls_Category <> ls_NewCategory THEN
			
			if SetValue("category", ls_NewCategory ) < 1 then
				li_ReturnValue = -1
			END IF
//			
//			This.of_SetCategory ( ls_NewCategory )
		END IF
//	END IF
END IF
//////



IF li_ReturnValue = 1 AND Len ( ls_Root ) > 0 THEN

	SetPointer ( HOURGLASS! )
	THIS.of_CalculatePath ( )
	
//	ls_OldPath = This.of_GetFilePath ( ) 
	
	ll_ID = This.of_GetID ( )	
	ls_Topic = This.of_GetTopic ( )
	ls_oldType = this.of_getType( )
	ls_Type = as_Type
	ls_Category = This.of_GetCategory ( )
	
	lnv_ImageManager.of_CreatePath (ls_Topic, ls_Category , ls_Type , ll_ID , lsa_PathParts[] , lsa_nodeFolders[] )
	ls_TargetPath = ls_Root + lsa_PathParts [ upperBound (lsa_PathParts ) ] +"\"+ lsa_NodeFolders [ upperBound ( lsa_NodeFolders ) ]+".TIF"	
	IF lnv_ImageManager.of_CreateFolder ( lsa_PathParts[] , lsa_nodeFolders[] ) <> 1 THEN 
		li_ReturnValue = -1
	END IF
	
	if IsValid ( lnv_SaveOle ) and Len ( ls_OldPath ) >0  AND li_ReturnValue = 1 THEN
		li_NumberPages = lnv_SaveOle.NumPages ( ls_oldPath) 
		lnv_Version.of_SetCompression ( lnv_SaveOle )
		lnv_SaveOle.SaveMultiPage = TRUE
		//lnv_SaveOle.Update = FALSE
		For i = 1 TO li_NumberPages			// I commented the page count code														
			lnv_saveOle.PageNbr = i				// it was appending to itself.
			lnv_SaveOle.FileName = ls_OldPath
			lnv_SaveOle.SaveFileName = ls_TargetPath
			lnv_SaveOle.SaveFile ( )
			li_ImageError = lnv_SaveOle.ImagError ( )
		NEXT
		
		//lnv_SaveOle.Update = TRUE
	
		IF Not ls_OldPath = ls_TargetPath AND li_ImageError = 0 THEN
			FileDelete ( ls_OldPath )
		END IF
		
		//added by dan
		//ll_index = ids_modLog.Find( "modid = "+string(ll_id) , ids_modLog.RowCount(), 1)
		
		IF ll_index = 0 THEN
			//ls_modDescript = "Created as "+string(ll_id) +" by "+gnv_app.of_getuserid( )
			ls_modDescript = /*ids_modLog.getItemString( ll_index, "moddescription") +*/ " Modified Type from "+ ls_oldType+ " to "+ls_type
		ELSE
			ls_modDescript = /*ids_modLog.getItemString( ll_index, "moddescription") +*/ " Modified Type from "+ ls_oldType+ " to "+ls_type
		END IF
		
		this.of_updatemodlog( ls_modDescript )

		//-------------
		
	END IF
	
lnv_saveOle.DisconnectObject ( )

END IF

DESTROY 	lnv_Version
DESTROY 	lnv_FileSrv
DESTROY	lnv_ImageManager
DESTROY	lnv_SaveOle

Return li_ReturnValue


end function

public function integer of_changecategory (string as_category);String	ls_TargetPath
String 	ls_OldPath

Int		li_ReturnValue = 1
Int		li_NumberPages
INT		i
Int		li_ImageError

Long		ll_ID
String	ls_Root
String	ls_topic
String	ls_Type
String	ls_Category
String	lsa_pathParts[ ]
String	lsa_NodeFolders[ ]
String	ls_oldCat

Long		ll_index
String	ls_modDescript
Long		ll_newModRow
Long		ll_row
DateTime ldt_now
int		li_result


n_cst_imagingversioncontrol		lnv_Version
n_cst_bso_ImageManager_pegasus	lnv_ImageManager
n_cst_Filesrv 							lnv_FileSrv
oleObject								lnv_SaveOle

lnv_ImageManager = CREATE n_cst_bso_ImageManager_pegasus
lnv_FileSrv = create n_cst_Filesrv
lnv_SaveOle = Create oleObject

IF lnv_ImageManager.of_GetImagingversioncontrol( lnv_Version ) <> 1 THEN
	li_ReturnValue = -1
END IF
	
IF li_ReturnValue = 1 THEN
	IF ISNull (THIS.of_GetID ( ) ) THEN
		li_Returnvalue = -1
		MessageBox("Image Attributes" , "Please assign an id to the image prior to altering the attributes" )
	END IF	
END IF

IF li_ReturnValue = 1 THEN
	IF lnv_Saveole.ConnectToNewObject ( lnv_Version.of_getimagexpressobjectstring( ) ) <> 0 THEN
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	ls_Root = lnv_ImageManager.of_GetRoot ( )
END IF

IF li_ReturnValue = 1 AND LEN ( ls_root ) > 0 THEN

	SetPointer ( HOURGLASS! )
	THIS.of_CalculatePath ( ) 
	
	ls_OldPath = This.of_GetFilePath ( ) 
	
	ll_ID = This.of_GetID ( )	
	ls_Topic = This.of_GetTopic ( )
	ls_Type = This.of_GetType ( )
	ls_oldCat = this.of_getCategory( )
	ls_Category = as_category
	
	lnv_ImageManager.of_CreatePath (ls_Topic, ls_Category , ls_Type , ll_ID , lsa_PathParts[] , lsa_nodeFolders[] )
	ls_TargetPath = ls_Root + lsa_PathParts [ upperBound (lsa_PathParts ) ] +"\"+ lsa_NodeFolders [ upperBound ( lsa_NodeFolders ) ]+".tif"
	
	IF lnv_ImageManager.of_CreateFolder ( lsa_PathParts[] , lsa_nodeFolders[] ) <> 1 THEN
		li_ReturnValue = -1
	END IF
		
	if IsValid ( lnv_SaveOle ) and Len ( ls_OldPath ) >0  AND li_ReturnValue = 1 THEN
		
		li_NumberPages = lnv_SaveOle.NumPages ( ls_oldPath) 
		lnv_Version.of_SetCompression ( lnv_SaveOle )
		lnv_SaveOle.SaveMultiPage = TRUE
		//lnv_SaveOle.Update = FALSE
		
		For i = 1 TO li_NumberPages
			
			lnv_saveOle.PageNbr = i
			lnv_SaveOle.FileName = ls_OldPath
			lnv_SaveOle.SaveFileName = ls_TargetPath
			lnv_SaveOle.SaveFile ( )
			li_ImageError = lnv_SaveOle.ImagError ( )
					
		NEXT
		
		//lnv_SaveOle.Update = TRUE
	END IF
	
	IF Not ls_OldPath = ls_TargetPath  AND li_ImageError = 0 THEN
		FileDelete ( ls_OldPath )
	END IF


//	//added by dan
//		ll_index = ids_modLog.Find( "modid = "+string(ll_id) , ids_modLog.RowCount(), 1)
//		
//		IF ll_index = 0 THEN
//			//ls_modDescript = "Created as "+string(ll_id) +" by "+gnv_app.of_getuserid( )
//		ELSE
//			ls_modDescript = ids_modLog.getItemString( ll_index, "moddescription") + " modified category from "+ ls_oldCat
//		END IF
//		ll_newModRow = ids_modLog.insertRow( 0 )
//		ids_modLog.setItem( ll_newModRow, "modid", ll_id )
//		ids_modLog.setItem( ll_newModRow, "category", ls_category )
//		ids_modLog.setItem( ll_newModRow, "type", ls_type )
//		ids_modLog.setItem( ll_newModRow, "topic", ls_topic )
//		ids_modLog.setItem( ll_newModRow, "moddescription", ls_modDescript )
//		ldt_now =  DateTime( today(), now() )
//		ids_modLog.setItem( ll_newModRow,"datet" ,ldt_now )
//		ids_modLog.setItem( ll_newModRow, "user", gnv_app.of_getuserid( ) )
//		
//		li_result = ids_modLog.update( )
//		IF li_result = 1 THEN
//			COMMIT;
//		ELSE
//			ROLLBACK;
//		END IF
//		//is_modString += " modified Category" 
		//-------------

END IF

lnv_saveOle.DisconnectObject ( )

DESTROY 	lnv_Version
DESTROY 	lnv_FileSrv
DESTROY	lnv_ImageManager
DESTROY	lnv_SaveOle

Return li_ReturnValue


end function

public function integer of_print (oleobject anv_oleprint, oleobject anv_oleimage, n_cst_msg anv_msg);Int		li_NumPages
Int		li_EndPage
Int		i
Int		li_Source
Int		li_ReturnValue = 1
Int		li_StartPage
String	ls_Type
Long		ll_id
Long		ll_X
Long		ll_Y
String	ls_PageText
Long		ll_ImageY
Long		ll_Height

OleObject	lnv_ImageOle

oleobject lnv_PrintOle

n_cst_Msg	lnv_Msg
s_Parm		lstr_parm

n_cst_pegasus_print	lnv_PegPrint
lnv_PegPrint = CREATE n_cst_pegasus_Print

lnv_Msg = anv_msg


IF lnv_Msg.of_Get_Parm( "SETTINGS", lstr_Parm ) <> 0 THEN
	lnv_PrintOle = lstr_Parm.ia_Value
Else
	li_ReturnValue = -1
END IF

lnv_Imageole = anv_OleImage

ls_Type = THIS.of_GetType ()
ll_ID = THIS.of_GetID ( )


n_cst_setting_includeimagetypeinprint	lnv_PrintType
lnv_PrintType = CREATE n_cst_setting_includeimagetypeinprint
IF lnv_PrintType.of_GetValue( ) = lnv_Printtype.cs_Yes THEN
	ls_PageText =  ls_Type + " - TMP: " + String( ll_ID )
ELSE
	ls_PageText = "TMP: " + String( ll_ID )
END IF
DESTROY ( lnv_PrintType )


IF isValid ( lnv_ImageOle ) AND isValid ( lnv_PrintOle ) AND li_ReturnValue = 1 THEN
		
	li_NumPages = THIS.of_CalcPages ( anv_oleimage )
	
	IF lnv_PrintOle.PdRange = 2 THEN // we have been instructed to print a specific range
		li_EndPage = lnv_PrintOle.PdToPage
		li_StartPage = lnv_PrintOle.PdFromPage
	ELSE // print all the pages
		li_StartPage = 1
		li_EndPage = li_NumPages		
	END IF
	
	IF li_StartPage > li_NumPages THEN
		li_NumPages = 0 
	END IF
	
	IF li_EndPage > li_NumPages THEN
		li_EndPage = li_NumPages
	END IF
	
	IF li_numpages > 0 THEN
		lnv_PrintOle.StartPrintDoc( ) 
																										
		// loop to print multi-page docs
		FOR i = li_StartPage TO li_EndPage
		
			lnv_ImageOle.pageNbr = i
			lnv_ImageOle.FileName = THIS.of_GetFilePAth ( )
		
			// assigns the image to be printed to the print control
			lnv_PrintOle.hdib =  lnv_ImageOle.hDib
			
			lnv_PegPrint.of_GetTitleCoords ( Len ( ls_PageText ) , ll_X, ll_Y )
			lnv_PrintOle.CurrentX = ll_X
			lnv_PrintOle.CurrentY = ll_Y
	
			lnv_PrintOle.SetCtlFontSize( 12 )
			lnv_PrintOle.BackStyle = 1		// changed from 0
			IF ls_PageText <> "" THEN
				lnv_PrintOle.PrintText ( ls_PageText )			
			END IF		
			ll_Height = lnv_PrintOle.scaleHeight
		
			lnv_PegPrint.of_getimageprintregion( ll_ImageY , ll_Height , lnv_PrintOle.scaleHeight )
			lnv_PrintOle.PrintDIB ( 0, ll_ImageY , lnv_PrintOle.scaleWidth - 1 , ll_Height , 0,0,0,0, TRUE )
		
			IF i < li_NumPages THEN
				lnv_PrintOle.NewPage()
			END IF
		
		NEXT

		lnv_PrintOle.EndPrintDoc ()
	//	lnv_ImageOle.UpDate = TRUE   // had to comment this one too
		
	ELSE
		li_returnValue = -1
	END IF
	
ELSE
	li_ReturnValue = -1
	
END IF

DESTROY 	lnv_PegPrint
	
return li_ReturnValue




end function

public function integer of_saverotation (integer ai_pagenum, long al_position);String	ls_tempPath 
String 	ls_OldPath

Int		li_NumberPages
Int		i
Int		li_ImageError
Int		li_ReturnValue = 1

n_cst_imagingversioncontrol	lnv_Version
oleObject	lnv_SaveOle
lnv_SaveOle = Create oleObject

n_cst_bso_imageManager_pegasus	lnv_Manager
lnv_Manager = create n_cst_bso_imageManager_pegasus

IF lnv_Manager.of_GetImagingVersioncontrol( lnv_Version ) <> 1 THEN
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1 THEN
	IF lnv_Saveole.ConnectToNewObject (lnv_Version.of_getimagexpressobjectstring( ) ) <> 0 THEN
		li_returnValue = -1
	END IF
END IF

ls_TempPath = lnv_Manager.of_GetRoot( )

IF NOT Len ( ls_TempPath ) > 0 THEN 
	li_ReturnValue = -1
ELSE
	ls_TempPath += "Temp.tif"
END IF

IF li_ReturnValue = 1 THEN

	SetPointer ( HOURGLASS! )
	
	ls_OldPath = This.of_GetFilePath ( ) 

	li_NumberPages = lnv_SaveOle.NumPages ( ls_oldPath) 
	IF li_numberPages < 0 THEN
		li_ReturnValue = -1
	END IF
	
	IF li_ReturnValue = 1 THEN
		lnv_Version.of_SetCompression ( lnv_SaveOle )
		//lnv_SaveOle.SaveTIFCompression = 3  // group 4 b/w
		lnv_Version.of_SetCompression ( lnv_SaveOle )
		lnv_SaveOle.SaveMultiPage = TRUE
		//lnv_SaveOle.Update = FALSE
		
		For i = 1 TO li_NumberPages
			lnv_saveOle.PageNbr = i
			lnv_SaveOle.FileName = ls_OldPath
			lnv_SaveOle.SaveFileName = ls_TempPath
			
			IF i = ai_pagenum THEN
				lnv_SaveOle.Rotate( al_position )
			END IF
			lnv_SaveOle.SaveFile ( )
			li_ImageError = lnv_SaveOle.ImagError ( )
		
		NEXT
		
		IF li_ImageError <> 0 THEN
			li_ReturnValue = -1
		END IF
	END IF
	
	
	IF li_ReturnValue = 1 THEN
		
		FileDelete ( ls_OldPath )
		
		//lnv_SaveOle.SaveTIFCompression = 3
		For i = 1 TO li_NumberPages
			lnv_saveOle.PageNbr = i
			lnv_SaveOle.FileName = ls_TempPath
			lnv_SaveOle.SaveFileName = ls_OldPath
			lnv_SaveOle.SaveFile ( )
			li_ImageError = lnv_SaveOle.ImagError ( )
		NEXT
		
		FileDelete ( ls_TempPath )	
	END IF
	
END IF

//lnv_SaveOle.Update = TRUE
lnv_SaveOle.DisconnectObject ( )

DESTROY 	lnv_Version
DESTROY	lnv_Manager
DESTROY	lnv_SaveOle

Return li_ReturnValue

end function

public function integer of_copyimage (readonly long al_shipid);return 1
///***************************************************************************************
//NAME			: of_CopyImage
//ACCESS		: Public 
//ARGUMENTS	: Long	(Shipment id to copy image to)
//RETURNS		: Integer (1=Success, -1=Fail)
//DESCRIPTION	: 
//REVISION		: RDT 3-12-03
//***************************************************************************************/
//
//String	ls_TargetPath
//String 	ls_SourcePath
//String	ls_topic
//String	ls_Type
//String	ls_Category
//
//Int		li_ReturnValue = 1
//Int		li_NumberPages
//INT		i
//Int		li_ImageError
//Long		ll_HoldID
//Boolean	lb_Append 
//
//
//n_cst_ShipmentManager	lnv_ShipmentManager
//
//n_cst_Filesrv 	lnv_FileSrv
//lnv_FileSrv = create n_cst_Filesrv
//
//IF li_ReturnValue = 1 THEN
//	CHOOSE CASE lnv_ShipmentManager.of_ShipmentExists ( al_shipid )
//	
//	CASE TRUE
//		//Exists
//	
//	CASE FALSE
//		li_ReturnValue = -1
//		MessageBox("Shipment Error","Shipment not found. Copy Failed.")
//		//Does not exist
//	
//	CASE ELSE
//		li_ReturnValue = -1
//		//Error -- Could not determine
//	
//	END CHOOSE
//	
//END IF
//
//
//IF li_ReturnValue = 1 THEN
//
//	SetPointer ( HOURGLASS! )
//
//	ls_SourcePath = This.of_GetFilePath ( ) 
//
//	ls_Topic = THIS.of_GetTopic ( )
//	ls_Type = THIS.of_GetType ( )
//	ls_Category = THIS.of_GetCategory ( )
//
//	ll_HoldID = This.of_GetId()
//
//	//set image to NEW ID to calculate path
//	This.of_SetID( al_shipid ) 
//	THIS.of_CalculatePath ( )
//	ls_TargetPath = THIS.OF_GetFilePath ( )
//	
//	This.of_SetID( ll_HoldID) // reset to old id
//	
//If MessageBox("RICH","Source: "	+ ls_SourcePath + "~nTarget: "+ls_TargetPath+"~nGO?", Question!, YesNo! ) = 1 Then 
//	lnv_FileSrv.of_FileCopy( ls_SourcePath, ls_TargetPath, FALSE) 	
//End IF		
//
//END IF
//
//DESTROY 	lnv_FileSrv
//
//Return li_ReturnValue
//
end function

public function integer of_setid (long al_id);
Return This.of_SetId( al_id, TRUE )   //RDT 7-29-03 

////@(*)[50332966|1344:id:s]<nosync>//@(-)Do not edit, move or copy this line//
////@(text)(recreate=yes)<Define Return Value>
//integer li_rc = 1
//
//// Validation logic for "id" attribute goes after this fragment.
//// Set li_rc to -1 if validation fails.
//// Set li_rc to 2 if other attributes have been modified.
////@(text)--
//String 	ls_ErrorMessage
//Int		li_NullRtn = -1
//String	ls_Temp
//n_cst_OFRError		lnv_Error
//n_cst_shipmentManager lnv_ShipmentManager
//
//
//	CHOOSE CASE lnv_ShipmentManager.of_ShipmentExists ( al_id )
//	
//	CASE TRUE
//		//Exists
//	
//	CASE FALSE
//		li_rc = -1
//		//Does not exist
//	
//	CASE ELSE
//		li_rc = -1
//		//Error -- Could not determine
//	
//	END CHOOSE
//
////@(text)(recreate=yes)<Set Value>
//if li_rc > 0 then
//   if SetValue("id", al_id) < 1 then
//      li_rc = -1
//   end if
//end if
////@(text)--
//
//n_cst_beo_Imagetype	lnv_ImageType 
//// This is not being callled anymore since it creates a major memory leak
////lnv_ImageType = THIS.of_GetImageType ()
//
//IF li_Rc > 0 THEN
//	IF  ( NOT isNull ( THIS.of_GetFilePath ( ) ) )  THEN 
//			
//		li_nullRtn = 1
//		
//		 IF THIS.of_Move ( lnv_imageType , al_id ) = -1 THEN 
//	
//			
//			lnv_Error = This.AddOFRError ( )
//			
//			ls_ErrorMessage = "The Tmp No. you specified does not exist. Please try again." 
//	
//			lnv_Error.SetErrorMessage( ls_ErrorMessage )
//			lnv_Error.SetMessageHeader ( "Image Attributes" )
//			
//			
//			li_rc = -1
//		END IF
//		 
//	END IF
//END IF
//
//IF li_rc > 0 THEN
//	THIS.of_CalculatePath ( )
//	
//	IF isValid ( w_imaging )  AND li_NullRtn = 1 THEN
//		w_imaging.wf_DisplayImage ( THIS )
//	END IF
//else
//			//n_cst_OFRError		lnv_Error
//			lnv_Error = This.AddOFRError ( )
//			
//			ls_ErrorMessage = "The Tmp No. you specified does not exist. Please try again." 
//	
//			lnv_Error.SetErrorMessage( ls_ErrorMessage )
//			lnv_Error.SetMessageHeader ( "Image Attributes" )
//END IF
////@(text)(recreate=yes)<Return Value>
//return li_rc
////@(text)--

end function

public function integer of_setid (long al_id, boolean ab_movefile);//@(*)[50332966|1344:id:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1


// Validation logic for "id" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--
String 	ls_ErrorMessage
Int		li_NullRtn = -1
String	ls_Temp
n_cst_OFRError		lnv_Error
n_cst_shipmentManager lnv_ShipmentManager

	CHOOSE CASE lnv_ShipmentManager.of_ShipmentExists ( al_id )
	
	CASE TRUE
		//Exists
	
	CASE FALSE
		li_rc = -1
		//Does not exist
	
	CASE ELSE
		li_rc = -1
		//Error -- Could not determine
	
	END CHOOSE


	//@(text)(recreate=yes)<Set Value>
	if li_rc > 0 then
		if SetValue("id", al_id) < 1 then
			li_rc = -1
		end if
	end if
	//@(text)--
	
	n_cst_beo_Imagetype	lnv_ImageType 
	// This is not being callled anymore since it creates a major memory leak
	//lnv_ImageType = THIS.of_GetImageType ()
	
	IF li_Rc > 0 THEN
		IF  ( NOT isNull ( THIS.of_GetFilePath ( ) ) )  THEN 
				
			li_nullRtn = 1
			If ab_MoveFile Then  	//RDT 7-29-03
				IF THIS.of_Move ( lnv_imageType , al_id ) = -1 THEN 
					lnv_Error = This.AddOFRError ( )
					
					ls_ErrorMessage = "The Tmp No. you specified does not exist. Please try again." 
					
					lnv_Error.SetErrorMessage( ls_ErrorMessage )
					lnv_Error.SetMessageHeader ( "Image Attributes" )
					li_rc = -1
				END IF					//RDT 7-29-03
			End if
		END IF
	END IF
	
	IF li_rc > 0 THEN
		If NOT ab_MoveFile Then  	//RDT 7-29-03
		THIS.of_CalculatePath ( )
		END IF							//RDT 7-29-03
		
		IF isValid ( w_imaging )  AND li_NullRtn = 1 THEN
			w_imaging.wf_DisplayImage ( THIS )
		END IF
	else
		//n_cst_OFRError		lnv_Error
		lnv_Error = This.AddOFRError ( )
		
		ls_ErrorMessage = "The Tmp No. you specified does not exist. Please try again." 
	
		lnv_Error.SetErrorMessage( ls_ErrorMessage )
		lnv_Error.SetMessageHeader ( "Image Attributes" )
	END IF
	
	//@(text)(recreate=yes)<Return Value>
	
return li_rc
//@(text)--

end function

private function integer of_changetypefromnone (string as_type);RETURN -1
end function

public function datastore of_getmodlog ();//Created by dan 1-10-2006
//creates ids_modlog if it doesn't already exist, and returns it.

IF NOT isValid( ids_modLog ) THEN
	ids_modLog			=	CREATE Datastore
	
	ids_modLog.dataobject = "d_imagemods"
	
	ids_modLog.setTransObject( SQLCA )
	//ids_modLog.Retrieve( )
ELSE
END IF

RETURN ids_modLog
end function

public function integer of_updatemodlog (string as_moddescript);/***************************************************************************************
NAME: 			of_updateModLog

ACCESS:			public
		
ARGUMENTS: 		
							as_newId: 				the image or tmp id 
							as_category:			the category the image has
							as_type:					the type of the image
							as_topic:				the topic of the image
							as_moddescript:		the description of the modification to the image

RETURNS:			1 if update succeeds, -1 if it fails
	
DESCRIPTION:  The following updates the database with a new row that contains all of
					the information passed in for parameters, as well as the user who is 
					currently logged in, and the date and time that this call was made
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :created by dan 1-9-2006
	

***************************************************************************************/

return this.of_updateModLog( this.of_getid( ) , as_moddescript)

//DateTime	ldt_now
//Long	ll_newModRow
//Int	li_result
//
//Long	ll_newId
//String	ls_category
//String	ls_type
//String	ls_topic
//Datastore	lds_modLog 
//
//lds_modLog = this.of_getModlog( )
//
//ll_newId = this.of_getid( )
//ls_category = this.of_getcategory( )
//ls_type = this.of_gettype( )
//ls_topic = this.of_getTopic( )
//
//IF isValid (lds_modLog) THEN
//	ll_newModRow = lds_modLog.insertRow( 0 )
//	lds_modLog.setItem( ll_newModRow, "modid", ll_newId )
//	lds_modLog.setItem( ll_newModRow, "category", ls_category )
//	lds_modLog.setItem( ll_newModRow, "type", ls_type )
//	lds_modLog.setItem( ll_newModRow, "topic", ls_topic )
//	lds_modLog.setItem( ll_newModRow, "moddescription", as_modDescript )
//	ldt_now =  DateTime( today(), Time(String(Now(), "hh:mm") ))
//	lds_modLog.setItem( ll_newModRow,"datet" ,ldt_now )
//	lds_modLog.setItem( ll_newModRow, "user", gnv_app.of_getuserid( ) )
//	
//	li_result = lds_modLog.update( )
//	IF li_result = 1 THEN
//		COMMIT;
//	ELSE
//		ROLLBACK;
//	END IF
//END IF
//Return li_result		
end function

public function integer of_updatemodlog (long al_id, string as_moddescript);/***************************************************************************************
NAME: 			of_updateModLog

ACCESS:			public
		
ARGUMENTS: 		
							as_newId: 				the image or tmp id 
							as_category:			the category the image has
							as_type:					the type of the image
							as_topic:				the topic of the image
							as_moddescript:		the description of the modification to the image

RETURNS:			1 if update succeeds, -1 if it fails
	
DESCRIPTION:  The following updates the database with a new row that contains all of
					the information passed in for parameters, as well as the user who is 
					currently logged in, and the date and time that this call was made
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :created by dan 1-9-2006
	

***************************************************************************************/

DateTime	ldt_now
Long	ll_newModRow
Int	li_result

Long	ll_newId
String	ls_category
String	ls_type
String	ls_topic
Datastore	lds_modLog 

lds_modLog = this.of_getModlog( )

ll_newId = al_id
ls_category = this.of_getcategory( )
ls_type = this.of_gettype( )
ls_topic = this.of_getTopic( )

IF isValid (lds_modLog) THEN
	ll_newModRow = lds_modLog.insertRow( 0 )
	lds_modLog.setItem( ll_newModRow, "modid", ll_newId )
	lds_modLog.setItem( ll_newModRow, "category", ls_category )
	lds_modLog.setItem( ll_newModRow, "type", ls_type )
	lds_modLog.setItem( ll_newModRow, "topic", ls_topic )
	lds_modLog.setItem( ll_newModRow, "moddescription", as_modDescript )
	ldt_now =  DateTime( today(), Time(String(Now(), "hh:mm") ))
	lds_modLog.setItem( ll_newModRow,"moddate" ,ldt_now )
	lds_modLog.setItem( ll_newModRow, "user", gnv_app.of_getuserid( ) )
	
	li_result = lds_modLog.update( )
	IF li_result = 1 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF
END IF
Return li_result		
end function

public function long of_getdivision ();//written by dan 5-3-2006 to return the division of the shipment( or possibly other types )
//associated with this image.
Long	ll_division
Long	ll_tmpNum
N_cst_shipmentManager	lnv_shipmentManager

ll_tmpNum = this.of_getId()
CHOOSE CASE this.of_getTopic()
	
	CASE "SHIPMENT"
		 	ll_division = lnv_shipmentManager.of_getDivision( ll_tmpNum )
COMMIT;
END CHOOSE

RETURN ll_division
end function

on n_cst_beo_image.create
call super::create
end on

on n_cst_beo_image.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
//@(data)--

//@(text)(recreate=yes)<body>

//@(text)--

end event

event destructor;call super::destructor;//added by dan 1-9-2006
IF isValid (ids_modlog) THEN
	DESTROY ids_modlog
END IF
end event

