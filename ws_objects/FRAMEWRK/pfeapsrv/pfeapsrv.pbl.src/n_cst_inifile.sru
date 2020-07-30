$PBExportHeader$n_cst_inifile.sru
$PBExportComments$Extension INIFile service
forward
global type n_cst_inifile from pfc_n_cst_inifile
end type
end forward

global type n_cst_inifile from pfc_n_cst_inifile
end type

forward prototypes
public function integer of_getinivalues (string as_file, datastore ads_inivalues)
end prototypes

public function integer of_getinivalues (string as_file, datastore ads_inivalues);//Loads a datastore of type d_IniValues (or equivalent) with values from the
//specified ini file.

//Returns : 1, -1

Long		ll_RowCount, &
			ll_Row
Integer	li_Int, &
			li_IntValue, &
			li_DefaultIntValue
String	ls_StringValue, &
			ls_DefaultStringValue, &
			ls_Section, &
			ls_Key

Integer	li_Return = 1


IF IsValid ( ads_IniValues ) THEN

	ll_RowCount = ads_IniValues.RowCount ( )

ELSE
	li_Return = -1

END IF


FOR ll_Row = 1 TO ll_RowCount

	ls_Section = ads_IniValues.Object.Section [ ll_Row ]
	ls_Key = ads_IniValues.Object.Key [ ll_Row ]
	li_Int = ads_IniValues.Object.Int [ ll_Row ]
	

	IF li_Int = 1 THEN

		li_DefaultIntValue = ads_IniValues.Object.DefaultIntValue [ ll_Row ]
		li_IntValue = ProfileInt ( as_File, ls_Section, ls_Key, li_DefaultIntValue )
		ads_IniValues.Object.IntValue [ ll_Row ] = li_IntValue

	ELSE

		ls_DefaultStringValue = ads_IniValues.Object.DefaultStringValue [ ll_Row ]
		ls_StringValue = ProfileString ( as_File, ls_Section, ls_Key, ls_DefaultStringValue )
		ads_IniValues.Object.StringValue [ ll_Row ] = ls_StringValue

	END IF

NEXT

RETURN li_Return
end function

on n_cst_inifile.create
TriggerEvent( this, "constructor" )
end on

on n_cst_inifile.destroy
TriggerEvent( this, "destructor" )
end on

