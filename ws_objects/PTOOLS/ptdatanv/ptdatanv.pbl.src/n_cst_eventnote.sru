$PBExportHeader$n_cst_eventnote.sru
forward
global type n_cst_eventnote from n_cst_base
end type
end forward

global type n_cst_eventnote from n_cst_base
end type
global n_cst_eventnote n_cst_eventnote

type variables
Protected:
Boolean	ib_Bill = TRUE
String	is_Amount
String	is_Type
String	is_Authorization
String	is_User
String	is_BillWho
String	is_Note

Boolean	ib_Append
end variables

forward prototypes
public function boolean of_isbilled ()
public function int of_setbill (boolean ab_Value)
public function string of_getauthorization ()
public function String of_getuser ()
public function int of_setauthorization (string as_Value)
public function String of_gettype ()
public function int of_settype (String as_Value)
public function integer of_setuser (string as_Value)
public function integer of_setappend (boolean ab_Value)
public function string of_getnote ()
public function string of_getamount ()
public function integer of_setamount (string as_value)
public function integer of_setnote (String as_Value)
public function integer of_buildnote ()
public function boolean of_append ()
public function integer of_setbillwho (string as_Value)
public function string of_getbillwho ()
end prototypes

public function boolean of_isbilled ();RETURN ib_Bill
end function

public function int of_setbill (boolean ab_Value);ib_Bill = ab_Value
RETURN 1
end function

public function string of_getauthorization ();RETURN is_Authorization
end function

public function String of_getuser ();RETURN is_User
end function

public function int of_setauthorization (string as_Value);is_Authorization = as_Value
RETURN 1
end function

public function String of_gettype ();RETURN is_Type
end function

public function int of_settype (String as_Value);is_Type = as_Value
RETURN 1
end function

public function integer of_setuser (string as_Value);is_User = as_Value 
RETURN 1
end function

public function integer of_setappend (boolean ab_Value);ib_Append = ab_Value
RETURN 1
end function

public function string of_getnote ();Return  UPPER ( is_Note )
end function

public function string of_getamount ();RETURN is_Amount
end function

public function integer of_setamount (string as_value);is_Amount = as_Value
RETURN 1
end function

public function integer of_setnote (String as_Value);is_Note = as_Value
RETURN 1
end function

public function integer of_buildnote ();String	ls_Bill
String	ls_Working

IF	ib_Bill THEN
	ls_Bill = "Bill " 
	IF Len ( is_BillWho ) > 0 THEN
		ls_Bill += is_BillWho + " "
	END IF
	
	IF Trim ( is_amount ) <> "$.00" THEN
		ls_Bill += is_Amount + " " 
	END IF
ELSE
	ls_Bill = "Don't bill "
	IF Len ( is_BillWho ) > 0 THEN
		ls_Bill += is_BillWho + " "
	END IF
END IF


ls_Working = ls_Bill +  "for " + is_Type + "."
IF ib_Bill AND len ( is_Authorization ) > 0 THEN
	ls_Working += " Auth: " + is_Authorization  
END IF

IF Len ( is_User ) > 0 THEN
	ls_Working +=	" User: " + is_User
END IF

is_Note = ls_Working
Return 1


end function

public function boolean of_append ();RETURN ib_Append
end function

public function integer of_setbillwho (string as_Value);is_BillWho = TRIM ( as_Value )
RETURN 1
end function

public function string of_getbillwho ();RETURN is_BillWho
end function

on n_cst_eventnote.create
TriggerEvent( this, "constructor" )
end on

on n_cst_eventnote.destroy
TriggerEvent( this, "destructor" )
end on

