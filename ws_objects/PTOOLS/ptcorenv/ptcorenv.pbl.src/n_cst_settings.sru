$PBExportHeader$n_cst_settings.sru
forward
global type n_cst_settings from nonvisualobject
end type
end forward

global type n_cst_settings from nonvisualobject autoinstantiate
end type

type variables
CONSTANT String cs_datatype_string = 'STRING'
CONSTANT String cs_datatype_decimal = 'DECIMAL'
CONSTANT String cs_datatype_date = 'DATE'
CONSTANT String cs_datatype_long = 'LONG'
CONSTANT String cs_datatype_char = 'CHAR'

private:
n_ds	ids_Cache
end variables

forward prototypes
public function integer of_getsetting (readonly long al_setting, ref any aa_value)
public function integer of_getacctlink (ref string as_acctlink)
public function integer of_getrequiredimagetypes (ref string asa_Types[])
public function integer of_getwarningimagetypes (ref string asa_Types[])
public function integer of_getprintingimagetypes (ref string asa_Types[])
public function long of_deletesetting (long al_id)
public function boolean of_processorfin ()
public function string of_getautoroutestyle ()
public function integer of_getautorouteleg ()
public function integer of_getbasetimezone ()
public function boolean of_createeventnote ()
public function long of_getcache (ref n_ds ads_cache)
public function integer of_setsetting (readonly long al_setting, any aa_value, string as_what)
public function integer of_savesetting ()
public function integer of_getcodedefaultsetting (readonly long al_uid, readonly long al_long, ref any aa_value)
public function integer of_setcodedefaultsetting (readonly long al_uid, readonly long al_long, any aa_value)
public function boolean of_addstopoffitem ()
public function boolean of_addfuelsurcharge ()
public function boolean of_createaccnotification ()
public function boolean of_createaccauthorization ()
public function boolean of_validateopenshipmentsonly ()
public function long of_getcodedefaultsetting (ref n_ds ads_settings)
public function string of_crosscheck2ndand3rdreffields ()
public function boolean of_allowshipmentchangeoflinkedequipment ()
public function long of_getcodedefaultlist (ref long ala_list[])
public function string of_getshipnoteformat ()
public function boolean of_addstopoffitemduring204 ()
public function boolean of_removestopoffitem ()
public function boolean of_excludechassisfrominvoice ()
public function long of_deletesetting (long al_id, long al_uid)
public function integer of_setsetting (readonly long al_setting, any aa_value, string as_what, long al_uid)
public function integer of_getusersforsetting (long al_setting, ref long ala_userids[])
end prototypes

public function integer of_getsetting (readonly long al_setting, ref any aa_value);//Returns: 1 = Success (Value Present ), 0 = Not Found, -1 = Error

Any		la_Value
Integer	li_SqlCode

Long		ll_Long, &
			ll_Rowcount, &
			ll_findrow
Char		lch_Char
String	ls_String
Date		ld_Date
Dec		lc_Dec

Integer	li_Return = 1

n_ds		lds_Cache

ll_rowcount = this.of_GetCache(lds_cache)

if isvalid(lds_cache) then
	//continue
else
	li_return = -1
end if

if li_return = 1 then
	
	ll_findrow = lds_Cache.find('ss_id = ' + string(al_setting), 1, ll_Rowcount)
	
	if ll_findrow > 0 then
		ls_String = lds_Cache.object.ss_String[ll_findrow]
		ll_Long = lds_Cache.object.ss_Long[ll_findrow]
		lc_Dec = lds_Cache.object.ss_Dec[ll_findrow]
		ld_Date = lds_Cache.object.ss_Date[ll_findrow]
		lch_Char = lds_Cache.object.ss_Char[ll_findrow]
		IF NOT IsNull ( ls_String ) THEN
			la_Value = ls_String
		ELSEIF NOT IsNull ( ll_Long ) THEN
			la_Value = ll_Long
		ELSEIF NOT IsNull ( lc_Dec ) THEN
			la_Value = lc_Dec
		ELSEIF NOT IsNull ( ld_Date ) THEN
			la_Value = ld_Date
		ELSEIF NOT IsNull ( lch_Char ) THEN
			la_Value = lch_Char
		ELSE
			//Entry was there, but value wasn't.  Return "Not Found".
			li_Return = 0
		END IF
	else
		li_return = 0
	end if	
end if

//SELECT ss_long, ss_char, ss_string, ss_date, ss_dec 
//INTO :ll_Long, :lch_Char, :ls_String, :ld_Date, :lc_Dec 
//FROM system_settings WHERE ss_id = :al_Setting ;
//
//li_SqlCode = SQLCA.SqlCode
//
//COMMIT ;

//CHOOSE CASE li_SqlCode
//
//CASE 0  //Entry found.  Extract the setting.
//
//	IF NOT IsNull ( ls_String ) THEN
//		la_Value = ls_String
//	ELSEIF NOT IsNull ( ll_Long ) THEN
//		la_Value = ll_Long
//	ELSEIF NOT IsNull ( lc_Dec ) THEN
//		la_Value = lc_Dec
//	ELSEIF NOT IsNull ( ld_Date ) THEN
//		la_Value = ld_Date
//	ELSEIF NOT IsNull ( lch_Char ) THEN
//		la_Value = lch_Char
//	ELSE
//		//Entry was there, but value wasn't.  Return "Not Found".
//		li_Return = 0
//	END IF
//
//CASE 100  //Entry not present.  Return "Not Found".
//	li_Return = 0
//
//CASE ELSE //-1 (Error), or Unexpected value.  Return "Error".
//	li_Return = -1
//
//END CHOOSE

//Pass out the value by reference and return.
aa_Value = la_Value
RETURN li_Return
end function

public function integer of_getacctlink (ref string as_acctlink);//Returns: 1 = Success, 0 = No entry found (or entry was None!, or invalid), -1 = Error
//Note: For 0 and -1 return, as_AcctLink will be empty string, NOT null!

Any		la_Custom, &
			la_Standard
String	ls_AcctLink

Integer	li_Return = 0
as_AcctLink = ""

//Get the custom accounting package setting (if any) from the database (id=29).
//This will be an entry of type "n_cst_acctlink_xxx".  This setting, if present,
//takes precedence over the Accounting Package chosen in System Settings (id=20).

IF li_Return = 0 THEN

	CHOOSE CASE This.of_GetSetting ( 29, la_Custom )
	
	CASE 1  //Value present.  If it's not an empty string, use it.

		ls_AcctLink = la_Custom

		IF Len ( Trim ( ls_AcctLink ) ) > 0 THEN
			as_AcctLink = ls_AcctLink
			li_Return = 1
		END IF
	
	CASE 0  //Value not present.
		//Proceed and try Standard.
	
	CASE ELSE  //-1 = Error.  Fail.
		li_Return = -1

	END CHOOSE

END IF

////If the custom value was not present, try the standard setting.

IF li_Return = 0 THEN

	CHOOSE CASE This.of_GetSetting ( 20, la_Standard )

	CASE 1  //Value present.  Use it.

		ls_AcctLink = la_Standard

		//Translate the enumerated value to an acctlink classname.

		choose case ls_acctlink
		case "DYNAMICS4AND5!", "DYNAMICS6!", "DYNAMICS7!"
			as_acctlink = "n_cst_acctlink_dynamics"
			li_Return = 1
		case "QUICKBOOKS!"
			as_acctlink = "n_cst_acctlink_quickbooks"
			li_Return = 1

		// RDT 01-02-03 Added Code block - Start
		case Upper( "QUICKBOOKSDIRECT2002!" )
			as_acctlink = "n_cst_acctlink_quickbooks_Direct_2002"
			li_Return = 1
		case Upper( "QUICKBOOKSDIRECT2003!")
			as_acctlink = "n_cst_acctlink_quickbooks_Direct_2003"
			li_Return = 1
		// RDT 01-02-03 Added Code block - End 

		case "BUSINESSWORKS!", "BUSINESSWORKSGOLD5!"
			as_acctlink = "n_cst_acctlink_businessworks"
			li_Return = 1
		CASE "PEACHTREE!"  //Added 2.5.00
			as_acctlink = "n_cst_acctlink_peachtree"
			li_Return = 1
		case "FLATFILE!"
			as_acctlink = "n_cst_acctlink_generic"
			li_Return = 1
		case "DACEASY!"
			as_acctlink = "n_cst_acctlink_daceasy"
			li_Return = 1
		CASE "SAP!"
			as_AcctLink = "n_cst_acctlink_sap"
			li_Return = 1
			
//		case else  //Unexpected value, or NONE!.  Clear it.
//			as_acctlink = ""
		case else  //Unexpected value, or NONE!.
			//Proceed, and return "Not Found"
		end choose
	
	CASE 0  //Value not present.
		//Proceed, and return "Not Found"
	
	CASE ELSE  //-1 = Error.  Fail.
		li_Return = -1

	END CHOOSE

END IF


RETURN li_Return
end function

public function integer of_getrequiredimagetypes (ref string asa_Types[]);Any		la_Value
String	lsa_Values[]
n_cst_string	lnv_String


THIS.of_GetSetting ( 31 , la_Value )

lnv_String.of_parseToArray ( String ( la_Value ) , ";" , lsa_Values )

asa_Types = lsa_Values

RETURN 1
end function

public function integer of_getwarningimagetypes (ref string asa_Types[]);Any		la_Value
String	lsa_Values[]
n_cst_string	lnv_String


THIS.of_GetSetting ( 32 , la_Value )

lnv_String.of_parseToArray ( String ( la_Value ) , ";" , lsa_Values )

asa_Types = lsa_Values

RETURN 1
end function

public function integer of_getprintingimagetypes (ref string asa_Types[]);Any		la_Value
String	lsa_Values[]
n_cst_string	lnv_String


THIS.of_GetSetting ( 34 , la_Value )

lnv_String.of_parseToArray ( String ( la_Value ) , ";" , lsa_Values )

asa_Types = lsa_Values

RETURN 1
end function

public function long of_deletesetting (long al_id);long	ll_return

  DELETE FROM "system_settings"  
   WHERE "system_settings"."ss_id" = :al_id   ;

commit;

choose case sqlca.sqlcode
	case 0
		ll_return = 1
		
	case else
		ll_return = -1
		
end choose

return ll_return
end function

public function boolean of_processorfin ();// process or/fin by default

Any	la_Value
Boolean lb_Return = TRUE

IF THIS.of_GetSetting ( 104 , la_Value ) = 1 THEN
	lb_Return = NOT ( String ( la_Value ) = "NO!" )
END IF
		
RETURN lb_Return
end function

public function string of_getautoroutestyle ();Any		la_Value
String	ls_Return
String	ls_Temp

THIS.of_GetSetting ( 106 , la_Value )

IF Not isNull ( la_Value ) THEN
	ls_Temp = Trim ( String ( la_Value ) )
	IF Len ( ls_Temp ) > 0 AND  ls_Temp <> "NONE" THEN
		ls_Return = ls_temp
	END IF
END IF 

RETURN ls_Return
end function

public function integer of_getautorouteleg ();Any	la_Value
Int	li_Temp
Int	li_Return = -1

THIS.of_GetSetting ( 107 , la_Value ) 

IF NOT isNull ( la_Value ) THEN
	li_Temp = Integer ( la_Value ) 

	IF li_Temp >= 0 THEN
		li_Return = li_Temp
	END IF
	
END IF

RETURN li_Return 

end function

public function integer of_getbasetimezone ();//get timezone from system_settings
Any	la_Value
Int	li_TZ

SetNull ( li_TZ )

IF THIS.of_GetSetting ( 2 , la_Value ) = 1 THEN
	IF Not IsNull ( la_Value ) THEN
		li_TZ = Integer ( la_Value )
	END IF
END IF

RETURN li_TZ

end function

public function boolean of_createeventnote ();Boolean	lb_Return 
Any		la_Value

THIS.of_GetSetting ( 109 , la_Value )
IF String ( la_Value ) = "YES!" THEN
	lb_Return = TRUE 
END IF

RETURN lb_Return
end function

public function long of_getcache (ref n_ds ads_cache);ids_cache = gnv_app.of_GetSettingscache( )

if isvalid(ids_Cache) then
	//already created
else

	ids_Cache = CREATE n_ds
	ids_Cache.DataObject = "d_Settings"
	ids_Cache.SetTransObject ( SQLCA )
	ids_Cache.Retrieve()
	commit;
//	ids_Cache.SetSort('ss_id D')
//	ids_Cache.Sort()

	gnv_app.of_SetSettingcache( ids_cache )
	
end if
ads_Cache = ids_Cache
return ids_Cache.rowcount()
end function

public function integer of_setsetting (readonly long al_setting, any aa_value, string as_what);RETURN THIS.of_Setsetting( al_setting, aa_value, as_what, 0 )
/*
//Returns: 1 = Success (Value Present ), 0 = Not Found, -1 = Error
Any		la_Value
Integer	li_SqlCode

Long		ll_Long, &
			ll_Rowcount, &
			ll_findrow
Char		lch_Char
String	ls_String
Date		ld_Date
Dec		lc_Dec

Integer	li_Return = 1

n_ds		lds_Cache

ll_rowcount = this.of_GetCache(lds_cache)

if isvalid(lds_cache) then
	//continue
else
	li_return = -1
end if

if li_return = 1 then
	
	ll_findrow = lds_Cache.find('ss_id = ' + string(al_setting), 1, ll_Rowcount)
	
	if ll_findrow = 0 then
		ll_findrow = lds_Cache.Insertrow(0)
		lds_Cache.object.ss_id[ll_findrow] = al_setting
		lds_Cache.object.ss_uid[ll_findrow] = 0
	end if

	
	if ll_findrow > 0 then
		
		choose case as_what
			case cs_datatype_string
				lds_Cache.object.ss_String[ll_findrow] = string(aa_value)
				
			case cs_datatype_decimal
				lds_Cache.object.ss_Dec[ll_findrow] = dec(aa_value)
				
			case cs_datatype_date
				lds_Cache.object.ss_Date[ll_findrow] = date(aa_value)
				
			case cs_datatype_long
				lds_Cache.object.ss_Long[ll_findrow] = long(aa_value)

			case cs_datatype_char
				lds_Cache.object.ss_Char[ll_findrow] = char(aa_value)
				
		end choose
	else
		li_return = 0
	end if	
end if

return li_return
*/
end function

public function integer of_savesetting ();// If not valid then it return zero.

Integer	li_Return
String	ls_DbParm
IF IsValid(ids_Cache) THEN
	ls_DbParm = SQLCA.dbParm
	//Fixes DB error 3 caused by loss of percsion in decimal data types when input parms are binded
	SQLCA.dbParm = "DisableBind = 1" 
	CHOOSE CASE ids_Cache.Update ( )
	
	CASE 1
		COMMIT ;
		li_Return = 1
	
	CASE ELSE
		ROLLBACK ;
		li_Return = -1
	
	END CHOOSE
	
	SQLCA.dbParm = ls_DBParm //Restore old DbParm
ELSE
	li_Return = 0
END IF

RETURN li_Return
end function

public function integer of_getcodedefaultsetting (readonly long al_uid, readonly long al_long, ref any aa_value);//Returns: 1 = Success (Value Present ), 0 = Not Found, -1 = Error

Any		la_Value
Integer	li_SqlCode

Long		ll_Long, &
			ll_Rowcount, &
			ll_findrow
Char		lch_Char
String	ls_String
Date		ld_Date
Dec		lc_Dec

Integer	li_Return = 1

n_ds		lds_Cache

ll_rowcount = this.of_GetCache(lds_cache)

if isvalid(lds_cache) then
	//continue
else
	li_return = -1
end if

if li_return = 1 then
	
	ll_findrow = lds_Cache.find('ss_uid = ' + string(al_uid) + ' and ss_id = ' + string(al_long), 1, ll_Rowcount)
	
	if ll_findrow > 0 then
		ls_String = lds_Cache.object.ss_String[ll_findrow]
		IF NOT IsNull ( ls_String ) THEN
			la_Value = ls_String
		ELSE
			//Entry was there, but value wasn't.  Return "Not Found".
			li_Return = 0
		END IF
	else
		li_return = 0
	end if	
end if

//Pass out the value by reference and return.
aa_Value = la_Value
RETURN li_Return
end function

public function integer of_setcodedefaultsetting (readonly long al_uid, readonly long al_long, any aa_value);//Returns: 1 = Success (Value Present ), 0 = Not Found, -1 = Error
Any		la_Value
Integer	li_SqlCode

Long		ll_Long, &
			ll_Rowcount, &
			ll_findrow
Char		lch_Char
String	ls_String
Date		ld_Date
Dec		lc_Dec

Integer	li_Return = 1

n_ds		lds_Cache

ll_rowcount = this.of_GetCache(lds_cache)

if isvalid(lds_cache) then
	//continue
else
	li_return = -1
end if

if li_return = 1 then
	
	ls_String = string(aa_value)
	
	ll_findrow = lds_Cache.find('ss_uid = ' + string(al_uid) + ' and ss_id = ' + string(al_long), 1, ll_Rowcount)

	if ll_findrow = 0 then
		if len(trim(ls_string)) > 0 then
			ll_findrow = lds_Cache.Insertrow(0)
			lds_Cache.object.ss_id[ll_findrow] = al_long
			lds_Cache.object.ss_uid[ll_findrow] = al_uid
		end if
	end if

	if ll_findrow > 0 then
		lds_Cache.object.ss_String[ll_findrow] = ls_String
	else
		li_return = 0
	end if	
end if

return li_return
end function

public function boolean of_addstopoffitem ();Boolean	lb_Return 
Any		la_Value
String	ls_Return

THIS.of_GetSetting ( 139 , la_Value )
ls_Return = String ( la_Value )

IF gnv_app.of_RunningScheduledTask ( ) THEN
	lb_Return = THIS.of_AddStopOffItemDuring204 ( ) // this will not ask only return True or false. Default is False
ELSE

	CHOOSE CASE ls_Return 
			
		CASE "YES!"
			lb_Return = TRUE 
		CASE "NO!"
			lb_Return = FALSE
		CASE "ASK!"
			lb_Return = MessageBox ( "Stopoff Item" , "Do you want to add the associated Stopoff Item?" , QUESTION! , YESNO! , 1 ) = 1
			
	END CHOOSE
	
END IF

RETURN lb_Return
end function

public function boolean of_addfuelsurcharge ();Boolean	lb_Return 
Any		la_Value
String	ls_Return

THIS.of_GetSetting ( 142 , la_Value )
ls_Return = String ( la_Value )
CHOOSE CASE ls_Return 
		
	CASE "YES!"
		lb_Return = TRUE 
	CASE "NO!"
		lb_Return = FALSE
END CHOOSE

RETURN lb_Return
end function

public function boolean of_createaccnotification ();Boolean	lb_Return 
Any		la_Value

THIS.of_GetSetting ( 135 , la_Value )
IF String ( la_Value ) = "YES!" THEN
	lb_Return = TRUE 
END IF

RETURN lb_Return
end function

public function boolean of_createaccauthorization ();Boolean	lb_Return 
Any		la_Value

THIS.of_GetSetting ( 136 , la_Value )
IF String ( la_Value ) = "YES!" THEN
	lb_Return = TRUE 
END IF

RETURN lb_Return
end function

public function boolean of_validateopenshipmentsonly ();Boolean	lb_Return 
Any		la_Value
String	ls_Return

THIS.of_GetSetting ( 72 , la_Value )
ls_Return = String ( la_Value )
CHOOSE CASE ls_Return 
		
	CASE "OPEN!"
		lb_Return = TRUE 
	CASE "ALL!"
		lb_Return = FALSE
		
END CHOOSE

RETURN lb_Return
end function

public function long of_getcodedefaultsetting (ref n_ds ads_settings);//Returns: 1 = Success (Value Present ), 0 = Not Found, -1 = Error
//pass out a datastore containing all settings with a uid > 0

Any		la_Value
Integer	li_SqlCode

Long		ll_Rowcount, &
			ll_row, &
			lla_list[], &
			ll_ndx, &
			ll_count

Integer	li_Return = 1

n_ds		lds_Cache, &
			lds_settings

ll_rowcount = this.of_GetCache(lds_cache)

if isvalid(lds_cache) then
	lds_settings = create n_ds
	lds_settings.dataobject='d_settings'
	lds_settings.SetTransobject(SQLCA)
else
	li_return = -1
end if

if li_return = 1 then
	ll_count = this.of_getcodedefaultlist(lla_list)
	for ll_row = 1 to ll_rowcount
		for ll_ndx = 1 to ll_count
			if lds_cache.object.ss_id[ll_row] = lla_list[ll_ndx] then
				lds_Cache.rowscopy(ll_row, ll_row, Primary!, lds_settings, 1, Primary!)
				exit
			end if
		next
	next
end if

//Pass out the value by reference and return.
ads_settings = lds_settings

RETURN ads_settings.rowcount()
end function

public function string of_crosscheck2ndand3rdreffields ();Any		la_Value
String	ls_Return

THIS.of_GetSetting ( 143 , la_Value )
ls_Return = String ( la_Value )

RETURN ls_Return
end function

public function boolean of_allowshipmentchangeoflinkedequipment ();Any		la_Value
Boolean	lb_Return

THIS.of_GetSetting ( 138 , la_Value )

IF String ( la_Value ) = "YES!" THEN
	lb_Return = TRUE 
END IF

RETURN lb_Return

end function

public function long of_getcodedefaultlist (ref long ala_list[]);ala_list[1] = appeon_constant.cl_itemfreight_list
ala_list[2] = appeon_constant.cl_chassissplit_list
ala_list[3] = appeon_constant.cl_stopoff_list
ala_list[4] = appeon_constant.cl_FuelSurcharge_list
ala_list[5] = appeon_constant.cl_PerDiem_list

return upperbound(ala_list)
end function

public function string of_getshipnoteformat ();String	ls_Return
Any		la_Value

THIS.of_GetSetting ( 147 , la_Value )

ls_Return = "ONENOTE!"

IF String ( la_Value ) = "INDIVIDUAL!" THEN
	ls_Return =  "INDIVIDUAL!"
END IF

RETURN ls_Return
end function

public function boolean of_addstopoffitemduring204 ();Boolean	lb_Return 
Any		la_Value
String	ls_Return

THIS.of_GetSetting ( 149, la_Value )
ls_Return = String ( la_Value )
CHOOSE CASE ls_Return 
		
	CASE "YES!"
		lb_Return = TRUE 
	CASE ELSE
		lb_Return = FALSE

END CHOOSE

RETURN lb_Return
end function

public function boolean of_removestopoffitem ();Boolean	lb_Return 
Any		la_Value
String	ls_Return

THIS.of_GetSetting ( 139 , la_Value )
ls_Return = String ( la_Value )

IF gnv_app.of_RunningScheduledTask ( ) THEN
	lb_Return = THIS.of_AddStopOffItemDuring204 ( ) // this will not ask only return True or false. Default is False
ELSE

	CHOOSE CASE ls_Return 
			
		CASE "YES!"
			lb_Return = TRUE 
		CASE "NO!"
			lb_Return = FALSE
		CASE "ASK!"
			lb_Return = MessageBox ( "Stopoff Item" , "Do you want to remove an associated Stopoff Item?" , QUESTION! , YESNO! , 1 ) = 1
			
	END CHOOSE
	
END IF

RETURN lb_Return
end function

public function boolean of_excludechassisfrominvoice ();Boolean	lb_Return 
Any		la_Value

THIS.of_GetSetting ( 151 , la_Value )
IF String ( la_Value ) = "YES!" THEN
	lb_Return = TRUE 
END IF

RETURN lb_Return
end function

public function long of_deletesetting (long al_id, long al_uid);//Returns: 1 = Success (Value Present ), 0 = Not Found, -1 = Error
Any		la_Value
Integer	li_SqlCode

Long		ll_Long, &
			ll_Rowcount, &
			ll_findrow
Char		lch_Char
String	ls_String
Date		ld_Date
Dec		lc_Dec

Integer	li_Return = 1

n_ds		lds_Cache

ll_rowcount = this.of_GetCache(lds_cache)

if isvalid(lds_cache) then
	//continue
else
	li_return = -1
end if

if li_return = 1 then
	
	ll_findrow = lds_Cache.find('ss_id = ' + string(al_id) + ' and ss_uid = ' + string(al_uid) , 1, ll_Rowcount)
	
	if ll_findrow > 0 then
		ll_findrow = lds_Cache.deleterow(ll_findrow)
	else
		li_return = 0
	end if	
	
end if

return li_return
end function

public function integer of_setsetting (readonly long al_setting, any aa_value, string as_what, long al_uid);//Returns: 1 = Success (Value Present ), 0 = Not Found, -1 = Error
Any		la_Value
Integer	li_SqlCode

Long		ll_Long, &
			ll_Rowcount, &
			ll_findrow
Char		lch_Char
String	ls_String
Date		ld_Date
Dec		lc_Dec
Long		ll_UserID
String	ls_findString

Integer	li_Return = 1

n_ds		lds_Cache

ll_rowcount = this.of_GetCache(lds_cache)

if isvalid(lds_cache) then
	//continue
else
	li_return = -1
end if

ls_FindString =	'ss_id = ' + string(al_setting) 

IF al_UID > 0 THEN
	ls_FindString += ' AND ss_uid = ' + String ( al_uid )
	ll_UserID = al_uid
END IF





if li_return = 1 then
	
	ll_findrow = lds_Cache.find( ls_FindString , 1, ll_Rowcount)
	
	if ll_findrow = 0 then
		ll_findrow = lds_Cache.Insertrow(0)
		lds_Cache.object.ss_id[ll_findrow] = al_setting
		lds_Cache.object.ss_uid[ll_findrow] = ll_UserID
	end if

	
	if ll_findrow > 0 then
		
		choose case as_what
			case cs_datatype_string
				lds_Cache.object.ss_String[ll_findrow] = string(aa_value)
				
			case cs_datatype_decimal
				lds_Cache.object.ss_Dec[ll_findrow] = dec(aa_value)
				
			case cs_datatype_date
				lds_Cache.object.ss_Date[ll_findrow] = date(aa_value)
				
			case cs_datatype_long
				lds_Cache.object.ss_Long[ll_findrow] = long(aa_value)

			case cs_datatype_char
				lds_Cache.object.ss_Char[ll_findrow] = char(aa_value)
				
		end choose
	else
		li_return = 0
	end if	
end if

return li_return
end function

public function integer of_getusersforsetting (long al_setting, ref long ala_userids[]);
Long	ll_rowCount
Long	ll_FindRow
Long	lla_UserIDS[]
int	li_UserCount
String	ls_Find
Integer	li_Return = 1

n_ds		lds_Cache

ll_rowcount = this.of_GetCache(lds_cache)

if isvalid(lds_cache) then
	//continue
else
	li_return = -1
end if

if li_return = 1 then
	ls_Find = 'ss_id = ' + string(al_setting)
	ll_FindRow = 1
	
	ll_findrow = lds_Cache.find( ls_Find , ll_findrow, ll_Rowcount)

	DO WHILE ll_findrow > 0
		
		li_UserCount ++
		lla_UserIDS[li_UserCount] = lds_Cache.Object.ss_uid[ll_findRow]
	
		ll_findrow++
	
		IF ll_findrow > ll_Rowcount THEN 
			EXIT
		END IF
	  ll_findrow = lds_Cache.Find(ls_Find, ll_findrow, ll_rowCount)
	
	LOOP
	
end if

ala_userids[] = lla_UserIDS

RETURN li_UserCount
end function

on n_cst_settings.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_settings.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

