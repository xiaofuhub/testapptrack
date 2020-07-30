$PBExportHeader$n_cst_syssettings.sru
$PBExportComments$ZMC
forward
global type n_cst_syssettings from n_base
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//n_cst_Settings snv_Settings
////end modification Shared Variables by appeon  20070730
end variables

global type n_cst_syssettings from n_base
end type
global n_cst_syssettings n_cst_syssettings

type variables
Protected:
String	is_PropertyTextLabel
String 	is_RB1Text
String 	is_RB2Text
String 	is_Value
Boolean  ib_SkipVal = FALSE
Boolean 	ib_AllowEditDDLB

Public:
CONSTANT String	cs_Yes 			= "Yes"
CONSTANT String	cs_No  			= "No"
CONSTANT String	cs_Ask 			= "Ask"
CONSTANT String	cs_AskEachTime	= "Ask Each Time"

CONSTANT String	cs_AlwaysHide = "Always Hide"
CONSTANT String	cs_AlwaysShow = "Always Show"

CONSTANT String	cs_All 			= "ALL"
CONSTANT String	cs_Entry 		= "ENTRY"
CONSTANT String	cs_AUDIT 		= "AUDIT"
CONSTANT String	cs_ADMIN 		= "ADMIN"
CONSTANT String	cs_None 			= "NONE"
CONSTANT String	cs_PTADMIN 		= "PTADMIN"
CONSTANT String	cs_Audit_Admin = "AUDIT / ADMIN"

CONSTANT String	cs_Item 					= "ITEM"
CONSTANT String	cs_Freight_AccTotals = "FREIGHT/ACC TOTAL"
CONSTANT String	cs_GrandTotal 			= "GRAND TOTAL"

CONSTANT	String	cs_Percentage	= "Percentage"
CONSTANT String	cs_PerMIle		= "PerMile"




end variables

forward prototypes
public function string of_getlabel ()
public function string of_getrb1text ()
public function string of_getrb2text ()
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
public function integer of_setrb1text (string as_value)
public function string of_getcolheader ()
public function integer of_getvalue (ref long ala_value[])
public function integer of_getvalue (ref string asa_value[])
public subroutine of_savesetting ()
public function integer of_setsetting (long al_setting, any aa_value, string as_what)
public function boolean of_shouldvalidate ()
public function integer of_setusersetting (long al_setting, long ala_userids[])
public function integer of_getusersettings (long al_setting, long ala_userids[])
public function integer of_savevalues (long ala_values[])
public function integer of_deleteusersetting (long al_settng, long al_uid)
end prototypes

public function string of_getlabel ();RETURN is_PropertyTextLabel
end function

public function string of_getrb1text ();Return is_RB1text
end function

public function string of_getrb2text ();Return is_RB2text
end function

public function string of_getvalue ();Return is_value
end function

public function integer of_savevalue (any aa_value);// Implemented in decendant

// Return -1  // RZ
Return 1 // ZMC
end function

public function integer of_setrb1text (string as_value);// Implemented in decendants

Return -1 
end function

public function string of_getcolheader ();Return ''
end function

public function integer of_getvalue (ref long ala_value[]);// must be implemented by desc.

Return -1
end function

public function integer of_getvalue (ref string asa_value[]);// must be implemented by desc.

Return -1


end function

public subroutine of_savesetting ();snv_settings.of_Savesetting( )
end subroutine

public function integer of_setsetting (long al_setting, any aa_value, string as_what);Return snv_Settings.of_Setsetting(al_setting,aa_value,as_what)


end function

public function boolean of_shouldvalidate ();Return ib_SkipVal
end function

public function integer of_setusersetting (long al_setting, long ala_userids[]);Int	li_Count
Int	i
li_Count = UpperBound ( ala_Userids[] )
FOR i = 1 TO li_Count

	snv_settings.of_Setsetting( al_setting , "" ,"", ala_Userids[i] )
	
NEXT

RETURN 1
end function

public function integer of_getusersettings (long al_setting, long ala_userids[]);RETURN snv_settings.of_getusersforsetting( al_Setting, ala_UserIDs[])
end function

public function integer of_savevalues (long ala_values[]);RETURN -1
end function

public function integer of_deleteusersetting (long al_settng, long al_uid);RETURN snv_settings.of_Deletesetting( al_Settng, al_UID )
end function

on n_cst_syssettings.create
call super::create
end on

on n_cst_syssettings.destroy
call super::destroy
end on

