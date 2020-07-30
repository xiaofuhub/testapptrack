$PBExportHeader$n_cst_tagdata.sru
forward
global type n_cst_tagdata from nonvisualobject
end type
end forward

global type n_cst_tagdata from nonvisualobject
end type
global n_cst_tagdata n_cst_tagdata

type variables
Private:
string	isa_Tags[]
datastore	ids_Values
string	isa_Values[]
oleobject	inv_Object
string	is_ObjectType
boolean	ib_NumberTag
long	il_TagNumber
string	is_TagDelimiter
end variables

forward prototypes
public subroutine of_settags (string asa_Tags[])
public function string of_getobjecttype ()
public subroutine of_setobjecttype (string as_ObjectType)
public subroutine of_setobject (oleobject anv_Object)
public function oleobject of_getobject ()
public subroutine of_getvalues (ref datastore ads_Values)
public subroutine of_setvalues (datastore ads_Values)
public subroutine of_getvalues (ref string asa_Values[])
public subroutine of_setvalues (string asa_Values[])
public function long of_gettags (ref string asa_tags[])
public function boolean of_isnumbertag ()
public subroutine of_settagdelimiter (string as_delimiter)
public function string of_gettagdelimiter ()
public subroutine of_settagnumber (long al_TagNumber)
public function long of_gettagnumber ()
end prototypes

public subroutine of_settags (string asa_Tags[]);isa_Tags = asa_Tags[]
end subroutine

public function string of_getobjecttype ();Return is_objecttype
end function

public subroutine of_setobjecttype (string as_ObjectType);is_objecttype = as_ObjectType
end subroutine

public subroutine of_setobject (oleobject anv_Object);inv_object = anv_Object
end subroutine

public function oleobject of_getobject ();return inv_object
end function

public subroutine of_getvalues (ref datastore ads_Values);ads_Values = ids_values
end subroutine

public subroutine of_setvalues (datastore ads_Values);ids_values = ads_Values
end subroutine

public subroutine of_getvalues (ref string asa_Values[]);asa_Values = isa_values
end subroutine

public subroutine of_setvalues (string asa_Values[]);isa_values = asa_Values
end subroutine

public function long of_gettags (ref string asa_tags[]);asa_Tags = isa_Tags
Return upperbound(asa_Tags)
end function

public function boolean of_isnumbertag ();IF il_tagnumber = 0 or isnull(il_tagnumber) THEN
	return FALSE
ELSE
	Return TRUE
END IF

end function

public subroutine of_settagdelimiter (string as_delimiter);is_tagdelimiter = as_delimiter
end subroutine

public function string of_gettagdelimiter ();return is_tagdelimiter
end function

public subroutine of_settagnumber (long al_TagNumber);il_tagnumber = al_TagNumber
end subroutine

public function long of_gettagnumber ();return il_tagnumber
end function

on n_cst_tagdata.create
TriggerEvent( this, "constructor" )
end on

on n_cst_tagdata.destroy
TriggerEvent( this, "destructor" )
end on

