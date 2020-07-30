$PBExportHeader$n_cst_valuelist.sru
$PBExportComments$ValueList service.  Uses d_ValueList.
forward
global type n_cst_valuelist from nonvisualobject
end type
end forward

global type n_cst_valuelist from nonvisualobject
end type
global n_cst_valuelist n_cst_valuelist

type variables
Constant String	cs_ValueColumn = "Value"

Protected n_ds	ids_ValueList
end variables

forward prototypes
public function boolean of_hasvalue (readonly string as_value)
public function integer of_addvalue (readonly string as_value, readonly boolean ab_allowduplicates)
public function integer of_reset ()
end prototypes

public function boolean of_hasvalue (readonly string as_value);//Note: This will probably have a problem if as_Value has single quotes in it.

Boolean	lb_HasValue

IF ids_ValueList.Find ( cs_ValueColumn + " = '" + as_Value + "'", 1, 2147483647 ) > 0 THEN

	lb_HasValue = TRUE

END IF

RETURN lb_HasValue
end function

public function integer of_addvalue (readonly string as_value, readonly boolean ab_allowduplicates);//Returns:	 1 = Value added sucessfully.
//				 0 = ab_AllowDuplicates was false, and the entry already existed.  No action taken.
//				-1 = Error

Boolean	lb_AddValue = TRUE
Long		ll_NewRow

Integer	li_Return = 1

IF ab_AllowDuplicates = FALSE THEN

	IF This.of_HasValue ( as_Value ) THEN
		lb_AddValue = FALSE
	END IF

END IF

IF lb_AddValue THEN

	ll_NewRow = ids_ValueList.InsertRow ( 0 )

	IF ll_NewRow > 0 THEN
		ids_ValueList.SetItem ( ll_NewRow, cs_ValueColumn, as_Value )
	ELSE
		li_Return = -1
	END IF

ELSE
	li_Return = 0

END IF

RETURN li_Return
end function

public function integer of_reset ();//Reset (clear) the value list

//Returns: 1, -1

Integer	li_Return = 1

CHOOSE CASE ids_ValueList.Reset ( )

CASE 1
	//Success

CASE ELSE
	li_Return = -1

END CHOOSE

RETURN li_Return
end function

event constructor;ids_ValueList = CREATE n_ds
ids_ValueList.DataObject = "d_ValueList"
end event

event destructor;DESTROY ids_ValueList
end event

on n_cst_valuelist.create
TriggerEvent( this, "constructor" )
end on

on n_cst_valuelist.destroy
TriggerEvent( this, "destructor" )
end on

