$PBExportHeader$n_cst_beo.sru
$PBExportComments$Business Object base class
forward
global type n_cst_beo from ofr_n_cst_beo
end type
end forward

shared variables

end variables

global type n_cst_beo from ofr_n_cst_beo
event type string ue_describe ( integer ai_describetype )
event type boolean ue_allowuseredit ( )
event type boolean ue_alloweditrestricted ( )
event ue_rejectedit ( readonly string as_message )
end type
global n_cst_beo n_cst_beo

type variables
Protected Integer		ii_ActionSource = 0
Protected Integer		ii_PriorActionSource = 0
Public Constant Integer	ci_ActionSource_User = 0
Public Constant Integer	ci_ActionSource_System = 1

Public Constant Boolean	cb_UserField = FALSE
Public Constant Boolean	cb_SystemField = TRUE

Public Constant Boolean	cb_Restricted = TRUE
Public Constant Boolean	cb_Unrestricted = FALSE

Public Constant Integer	ci_DescribeType_Default = 0
Public Constant Integer	ci_DescribeType_Short = 1
Public Constant Integer	ci_DescribeType_Long = 2

Protected Constant String	cs_RejectEdit_NotAuthorized = &
	"You are not authorized to make this change."

Protected Constant String	cs_RejectEdit_Invalid = &
	"The value you have entered is invalid."

Protected Constant String	cs_RejectEdit_Negative = &
	"The value for this field cannot be negative."

Protected Constant String	cs_RejectEdit_Error = &
	"Could not process request."
end variables

forward prototypes
public function n_cst_bso getcontext ()
public function boolean hascontext ()
public function string describe (integer ai_describetype)
public function string describe ()
public function integer getcodetableentry (ref string as_codetableentry)
protected function integer getcodetableentry (string as_id, string as_description, ref string as_codetableentry)
public function integer get (readonly string as_name, ref any aa_value)
public function integer setactionsource (readonly integer ai_actionsource)
public function integer getactionsource ()
public function boolean useraction ()
public function boolean systemaction ()
protected function integer approveedit (readonly boolean ab_systemfield, readonly boolean ab_staterestricted)
public function boolean allowedit (readonly boolean ab_systemfield, readonly boolean ab_staterestricted)
public function integer restoreactionsource ()
end prototypes

event ue_describe;//This event will return a display description of the beo.  The ai_DescribeType argument
//should be one of the DescribeType constants defined on this object.

//This event should be overridden in decendants that wish to implement this capability.

RETURN "[UNKNOWN]"
end event

event ue_allowuseredit;//Allow all user edit by default, unless restricted by the descendant.

RETURN TRUE
end event

event ue_alloweditrestricted;//Default functionality implemented here is to allow or disallow the change
//based on whether the user can edit or impact the class at all.  Descendants
//will typically want to extend this functionality  (**BUT SHOULD NOT OVERRIDE, 
//BECAUSE THEY'D BE BYPASSING THE AllowUserEdit CHECK**)

RETURN This.Event ue_AllowUserEdit ( )
end event

event ue_rejectedit;n_cst_OFRError	lnv_Error

lnv_Error = This.AddOFRError ( )

IF IsValid ( lnv_Error ) THEN

	lnv_Error.SetErrorMessage( as_Message + "~n~n(Press Esc twice to undo your edit.)" )
	lnv_Error.SetMessageHeader ( "Edit Value" )

END IF
end event

public function n_cst_bso getcontext ();n_cst_Bcm	lnv_Bcm
n_cst_Bso	lnv_Context

lnv_Bcm = GetBcm ( )

IF IsValid ( lnv_Bcm ) THEN
	lnv_Context = lnv_Bcm.GetContext ( )
END IF

RETURN lnv_Context
end function

public function boolean hascontext ();n_cst_Bcm	lnv_Bcm
Boolean		lb_HasContext

lnv_Bcm = GetBcm ( )

IF IsValid ( lnv_Bcm ) THEN
	lb_HasContext = lnv_Bcm.HasContext ( )
END IF

RETURN lb_HasContext
end function

public function string describe (integer ai_describetype);RETURN Event ue_Describe ( ai_DescribeType )
end function

public function string describe ();RETURN Event ue_Describe ( ci_DescribeType_Default )
end function

public function integer getcodetableentry (ref string as_codetableentry);//This function will attempt to construct a code table entry describing this beo.

//If the default segment values here are not appropriate for a particular class, the
//function can be overridden in the decendant (but should still then call 
//the RETURN version of the function for standardized concatenation.)

Any		la_Id
String	ls_Id, &
			ls_Description

IF GetAttribute ( "id", la_Id ) = 1 THEN
	ls_Id = String ( la_Id )
END IF

ls_Description = Describe ( ci_DescribeType_Short )

RETURN GetCodeTableEntry ( ls_Id, ls_Description, as_CodeTableEntry )
end function

protected function integer getcodetableentry (string as_id, string as_description, ref string as_codetableentry);//This function assembles the id and description segments into a code table entry.

//Return : 1, -1

Integer	li_Return

IF Len ( as_Id ) > 0 AND &
	Len ( as_Description ) > 0 THEN

	as_CodeTableEntry = as_Description + "~t" + as_Id + "/"
	li_Return = 1

ELSE

	as_CodeTableEntry = ""
	li_Return = -1

END IF

RETURN li_Return
end function

public function integer get (readonly string as_name, ref any aa_value);//Public wrapper for GetAttribute

RETURN This.GetAttribute ( as_Name, aa_Value )
end function

public function integer setactionsource (readonly integer ai_actionsource);//Set the action source, which affects whether system fields may be modified, etc.
//The parameter should be one of the ci_ActionSource_xxx constants.

//Returns: 1, -1

//Record the current value, in case it needs to be restored.
ii_PriorActionSource = ii_ActionSource

//Set the new value
ii_ActionSource = ai_ActionSource

RETURN 1
end function

public function integer getactionsource ();RETURN ii_ActionSource
end function

public function boolean useraction ();Boolean	lb_UserAction

lb_UserAction = This.GetActionSource ( ) = This.ci_ActionSource_User

RETURN lb_UserAction
end function

public function boolean systemaction ();Boolean	lb_SystemAction

lb_SystemAction = This.GetActionSource ( ) = This.ci_ActionSource_System

RETURN lb_SystemAction
end function

protected function integer approveedit (readonly boolean ab_systemfield, readonly boolean ab_staterestricted);//This function consults AllowEdit, then calls ue_RejectEdit to register
//an OFRError if approval is denied.  This function should be used when
//you are actively making the change, and want an explanation registered
//if it's denied.

//Returns: 1 (Approved), -1 (Not Approved)

Integer	li_Return = 1

IF This.AllowEdit ( ab_SystemField, ab_StateRestricted ) = FALSE THEN

	This.Event ue_RejectEdit ( This.cs_RejectEdit_NotAuthorized )
	li_Return = -1

END IF

RETURN li_Return
end function

public function boolean allowedit (readonly boolean ab_systemfield, readonly boolean ab_staterestricted);//Approve or reject the edit as determined by the user event, 
//with potential descendant processing.

Boolean	lb_Allow = TRUE


//If the field being modified is a system field, reject the edit
//if it is not a SystemAction.

IF ab_SystemField = cb_SystemField THEN

	IF This.SystemAction ( ) = FALSE THEN
		lb_Allow = FALSE
	END IF

END IF


//If all is well so far, see if the user is permitted to edit or impact
//the field.

IF lb_Allow THEN

	IF ab_StateRestricted = cb_Restricted THEN

		//StateRestricted Field	
		lb_Allow = This.Event ue_AllowEditRestricted ( )

	ELSEIF ab_StateRestricted = cb_Unrestricted THEN

		//Unrestricted Field -- See if the user can change anything on the class.
		lb_Allow = This.Event ue_AllowUserEdit ( )

	ELSE //Unexpected value - reject.

		lb_Allow = FALSE

	END IF

END IF


RETURN lb_Allow



//IF ab_SystemField = cb_SystemField AND &
//	ab_StateRestricted = cb_Restricted THEN
//
//	//StateRestricted System Field
//
//	IF This.SystemAction ( ) THEN
//
//		lb_Allow = This.Event ue_AllowEditRestricted ( )
//
//	END IF
//
//ELSEIF ab_SystemField = cb_SystemField AND &
//	ab_StateRestricted = cb_Unrestricted THEN
//
//	//Unrestricted System Field
//
//	IF This.SystemAction ( ) THEN
//
//		lb_Allow = TRUE
//
//	END IF
//
//ELSEIF ab_SystemField = cb_UserField AND &
//	ab_StateRestricted = cb_Restricted THEN
//
//	//StateRestricted User Field
//
//	lb_Allow = This.Event ue_AllowEditRestricted ( )
//
//
//ELSEIF ab_SystemField = cb_UserField AND &
//	ab_StateRestricted = cb_Unrestricted THEN
//
//	//Unrestricted User Field
//
//	IF This.SystemAction ( ) THEN
//
//		lb_Allow = TRUE
//
//	ELSE
//
//		//Let the event processing determine whether this particular user
//		//can make the change.
//		lb_Allow = This.Event ue_AllowUserEdit ( )
//
//	END IF
//
//ELSE
//	//Unexpected values -- don't allow
//
//END IF
end function

public function integer restoreactionsource ();//Restores the most recent action source, before the current one.
//The current action source will become the prior action source.
//We are, in effect, swapping them.

//Returns: 1, -1

Integer	li_Return = -1

IF This.SetActionSource ( ii_PriorActionSource ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return
end function

on n_cst_beo.create
TriggerEvent( this, "constructor" )
end on

on n_cst_beo.destroy
TriggerEvent( this, "destructor" )
end on

