$PBExportHeader$n_cst_beo_shiptype.sru
forward
global type n_cst_beo_shiptype from pt_n_cst_beo
end type
end forward

global type n_cst_beo_shiptype from pt_n_cst_beo
end type
global n_cst_beo_shiptype n_cst_beo_shiptype

forward prototypes
public function string of_getname ()
public function string of_getstatus ()
public function string of_getaccountingcompany ()
public function integer of_setusecache (boolean ab_switch)
public function boolean of_isactive ()
public function string of_getterms ()
public function string of_getremit1 ()
public function string of_getremit2 ()
public function string of_getremit3 ()
public function string of_getremit4 ()
public function string of_getremit5 ()
public function string of_getremit ()
public function boolean of_isexpedite ()
public function long of_getid ()
end prototypes

public function string of_getname ();RETURN This.of_GetValue ( "st_Name", TypeString! )
end function

public function string of_getstatus ();RETURN This.of_GetValue ( "st_Status", TypeString! )
end function

public function string of_getaccountingcompany ();RETURN This.of_GetValue ( "st_Accounting_Company", TypeString! )
end function

public function integer of_setusecache (boolean ab_switch);n_cst_Ship_Type	lnv_ShipType

Integer	li_Result = 1

IF ab_Switch = TRUE THEN

	IF lnv_ShipType.of_Ready ( FALSE ) THEN
		li_Result = This.of_SetSource ( gds_ShipType )
	ELSE
		li_Result = -1
	END IF

ELSEIF ab_Switch = FALSE THEN
	li_Result = This.of_ClearSource ( )

ELSE
	li_Result = -1

END IF

RETURN li_Result
end function

public function boolean of_isactive ();//Returns:  TRUE, FALSE, Null ( Can't be determined )

Boolean	lb_IsActive
String	ls_Status

ls_Status = This.of_GetStatus ( )

IF IsNull ( ls_Status ) THEN
	SetNull ( lb_IsActive )
ELSEIF ls_Status = "K" THEN
	lb_IsActive = TRUE
END IF

RETURN lb_IsActive
end function

public function string of_getterms ();RETURN This.of_GetValue ( "st_Terms", TypeString! )
end function

public function string of_getremit1 ();RETURN This.of_GetValue ( "st_Remit_01", TypeString! )
end function

public function string of_getremit2 ();RETURN This.of_GetValue ( "st_Remit_02", TypeString! )
end function

public function string of_getremit3 ();RETURN This.of_GetValue ( "st_Remit_03", TypeString! )
end function

public function string of_getremit4 ();RETURN This.of_GetValue ( "st_Remit_04", TypeString! )
end function

public function string of_getremit5 ();RETURN This.of_GetValue ( "st_Remit_05", TypeString! )
end function

public function string of_getremit ();String	ls_Remit, &
			ls_Work

//Remit1

ls_Work = This.of_GetRemit1 ( )

IF IsNull ( ls_Work ) THEN
	ls_Work = ""
END IF

ls_Remit += ls_Work + "~r~n"


//Remit2

ls_Work = This.of_GetRemit2 ( )

IF IsNull ( ls_Work ) THEN
	ls_Work = ""
END IF

ls_Remit += ls_Work + "~r~n"


//Remit3

ls_Work = This.of_GetRemit3 ( )

IF IsNull ( ls_Work ) THEN
	ls_Work = ""
END IF

ls_Remit += ls_Work + "~r~n"


//Remit4

ls_Work = This.of_GetRemit4 ( )

IF IsNull ( ls_Work ) THEN
	ls_Work = ""
END IF

ls_Remit += ls_Work + "~r~n"


//Remit5

ls_Work = This.of_GetRemit5 ( )

IF IsNull ( ls_Work ) THEN
	ls_Work = ""
END IF

ls_Remit += ls_Work   //No trailing CR/NL


RETURN ls_Remit
end function

public function boolean of_isexpedite ();RETURN This.of_GetValue ( "st_Expedite", TypeString! ) = "T"
end function

public function long of_getid ();RETURN This.of_GetValue ( "st_Id", TypeLong! )


end function

on n_cst_beo_shiptype.create
call super::create
end on

on n_cst_beo_shiptype.destroy
call super::destroy
end on

event constructor;call super::constructor;This.of_SetKeyColumn ( "st_id" )
end event

event ue_getvalueany;call super::ue_getvalueany;//Extending Ancestor to provide attribute support for this class.

Integer	li_Return

li_Return = AncestorReturnValue

IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_Attribute ) )

//		CASE "ID"
//			aa_Value = This.of_GetId ( )

		CASE "NAME"
			aa_Value = This.of_GetName ( )
			
		CASE "TERMS"
			aa_Value = This.of_GetTerms ( )
			
		CASE "REMIT"
			aa_Value = This.of_GetRemit ( )
			
		CASE "REMIT1"
			aa_Value = This.of_GetRemit1 ( )
			
		CASE "REMIT2"
			aa_Value = This.of_GetRemit2 ( )
			
		CASE "REMIT3"
			aa_Value = This.of_GetRemit3 ( )
			
		CASE "REMIT4"
			aa_Value = This.of_GetRemit4 ( )
			
		CASE "REMIT5"
			aa_Value = This.of_GetRemit5 ( )
			
		CASE "ACCOUNTINGCOMPANY"
			aa_Value = This.of_GetAccountingCompany ( )
			
		CASE ELSE
			li_Return = 0

	END CHOOSE

END IF

RETURN li_Return
end event

