$PBExportHeader$n_cst_appmanager.sru
$PBExportComments$Extension Application Manager service
forward
global type n_cst_appmanager from pfc_n_cst_appmanager
end type
end forward

global type n_cst_appmanager from pfc_n_cst_appmanager
end type
global n_cst_appmanager n_cst_appmanager

type variables
Protected:
String	is_AppName
String	is_AppDirectory
end variables

forward prototypes
public function string of_getappname ()
public function integer of_setappname (string as_appname)
public function string of_getappversionname ()
public function integer of_getnextid (string as_class, ref long al_nextid, boolean ab_commit)
public function string of_getappdirectory ()
end prototypes

public function string of_getappname ();RETURN is_AppName
end function

public function integer of_setappname (string as_appname);n_cst_String	lnv_String

IF IsNull ( as_AppName ) THEN
	RETURN -1
END IF

is_AppName = as_AppName
iapp_Object.DisplayName = lnv_String.of_RemoveNonPrint ( as_AppName )

RETURN 1
end function

public function string of_getappversionname ();String	ls_VersionName

ls_VersionName = of_GetAppName ( ) + ", Version " + of_GetVersion ( )

RETURN ls_VersionName
end function

public function integer of_getnextid (string as_class, ref long al_nextid, boolean ab_commit);//Stub function, to be overridden in decendants
//Returns : 1, -1

SetNull ( al_NextId )
RETURN -1
end function

public function string of_getappdirectory ();// is_directory is set in the constructor event
return is_appdirectory
end function

on n_cst_appmanager.create
TriggerEvent( this, "constructor" )
end on

on n_cst_appmanager.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//when the application is run we want to capture 
//the fully qualified path to the application

n_cst_filesrvwin32	lnv_filesrvwin32
lnv_filesrvwin32 = Create n_cst_filesrvwin32

is_appdirectory = lnv_filesrvwin32.of_GetCurrentDirectory ( ) 

Destroy lnv_filesrvwin32

end event

