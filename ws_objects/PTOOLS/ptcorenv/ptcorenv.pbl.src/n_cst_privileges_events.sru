$PBExportHeader$n_cst_privileges_events.sru
forward
global type n_cst_privileges_events from n_cst_privileges
end type
end forward

global type n_cst_privileges_events from n_cst_privileges
end type

forward prototypes
public function boolean of_editdatestimes ()
public function boolean of_enterdatestimes ()
public function boolean of_allowconfirmation ()
public function boolean of_edittimes ()
public function boolean of_allowalteritins ()
public function boolean of_allowunconfirm ()
end prototypes

public function boolean of_editdatestimes ();RETURN FALSE
end function

public function boolean of_enterdatestimes ();RETURN THIS.of_HasEntryrights( )
end function

public function boolean of_allowconfirmation ();// see if the user has an entry in the DB specifing whether they can alter itineries
long	ll_UserID
Long	ll_Value = -1
Boolean	lb_Return

ll_UserID = gnv_app.of_GetNumericuserid( )

Select ss_long
into :ll_Value
From System_Settings
Where ss_id = 49003 and ss_uid = :ll_UserID;

Commit;

IF ll_Value = 0 THEN
	lb_Return = FALSE
ELSEIF ll_Value = 1 THEN
	lb_Return = TRUE
ELSE
	lb_Return = THIS.of_HasEntryrights( )
END IF
	
RETURN lb_Return

	
end function

public function boolean of_edittimes ();long	ll_UserID
Long	ll_Value = -1
Boolean	lb_Return

ll_UserID = gnv_app.of_GetNumericuserid( )

Select ss_long
into :ll_Value
From System_Settings
Where ss_id = 49002 and ss_uid = :ll_UserID;

Commit;

IF ll_Value = 0 THEN
	lb_Return = FALSE
ELSEIF ll_Value = 1 THEN
	lb_Return = TRUE
ELSE
	lb_Return = THIS.of_HasEntryrights( )
END IF
	
RETURN lb_Return

end function

public function boolean of_allowalteritins ();// see if the user has an entry in the DB specifing whether they can alter itineries
long	ll_UserID
Long	ll_Value = -1
Boolean	lb_Return

ll_UserID = gnv_app.of_GetNumericuserid( )

Select ss_long
into :ll_Value
From System_Settings
Where ss_id = 49004 and ss_uid = :ll_UserID;

Commit;

IF ll_Value = 0 THEN
	lb_Return = FALSE
ELSEIF ll_Value = 1 THEN
	lb_Return = TRUE
ELSE
	lb_Return = THIS.of_HasEntryrights( )
END IF
	
RETURN lb_Return
end function

public function boolean of_allowunconfirm ();// see if the user has an entry in the DB specifing whether they can alter itineries
long	ll_UserID
Long	ll_Value = -1
Boolean	lb_Return

ll_UserID = gnv_app.of_GetNumericuserid( )

Select ss_long
into :ll_Value
From System_Settings
Where ss_id = 49005 and ss_uid = :ll_UserID;

Commit;

IF ll_Value = 0 THEN
	lb_Return = FALSE
ELSEIF ll_Value = 1 THEN
	lb_Return = TRUE
ELSE
	lb_Return = THIS.of_HasEntryrights( )
END IF
	
RETURN lb_Return

	
end function

on n_cst_privileges_events.create
call super::create
end on

on n_cst_privileges_events.destroy
call super::destroy
end on

