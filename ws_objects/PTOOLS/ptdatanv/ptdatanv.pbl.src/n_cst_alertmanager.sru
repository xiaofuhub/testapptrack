$PBExportHeader$n_cst_alertmanager.sru
forward
global type n_cst_alertmanager from n_cst_base
end type
end forward

global type n_cst_alertmanager from n_cst_base
event type integer ue_deleteinactivealerts ( )
end type
global n_cst_alertmanager n_cst_alertmanager

type variables
Long	il_UserId
Long	ila_ShownAlerts[]

CONSTANT	int	ci_Status_Inactive = 0
CONSTANT	int	ci_Status_active = 1

end variables

forward prototypes
public function integer of_showalerts (pt_n_cst_beo anva_source[])
public function integer of_showallalerts (pt_n_cst_beo anva_source[])
public function integer of_deactivatealert (long al_alertid)
public function integer of_activatealert (long al_alertid)
public function integer of_setalertstatus (long al_alertid, integer ai_status)
public function integer of_reset ()
private function integer of_showalert (long al_alertid)
public function integer of_showalertlist ()
public function integer of_addsytemalert ()
public function integer of_showsystemalerts ()
public function integer of_deleteinactivealerts ()
public function integer of_alertseen (long al_alertid)
public function integer of_addalert (string as_msgtext, pt_n_cst_beo anv_source)
private function integer of_addalerttojointable (long al_alertid)
public function integer of_deletealertforcurrentuser (long al_alertid)
public function integer of_addalertforcurrentuser (long al_alertid)
public function integer of_showalerts (long ala_msgids[])
public function integer of_showalertsforcurrentuser ()
public function integer of_showinternaldbalerts ()
public function integer of_showalertsforcurrentuser (long ala_alertids[], string as_caption)
end prototypes

event type integer ue_deleteinactivealerts();RETURN 1
end event

public function integer of_showalerts (pt_n_cst_beo anva_source[]);String	ls_ClassName
Long		ll_SourceID
Long		ll_messageID
Int		li_Count
Int		i
int		li_MsgCnt
Long		lla_MsgIds[]
Int		li_Return = 1


n_cst_AnyArraySrv	lnv_Array

li_Count = UpperBound ( Anva_source[] )

IF li_Return = 1 THEN
	FOR i = 1 TO li_Count
	
		ls_ClassName = anva_Source[i].ClassName ()
		ll_SourceID = anva_Source[i].of_GetSourceID ( )
		
		
		 DECLARE UserAlerts CURSOR FOR  
		  SELECT "useralerts"."id" 
			 FROM "useralerts" ,
					"JoinUserAlert"
			WHERE ( "useralerts"."sourceid" = :ll_SourceID ) AND  
					( "useralerts"."classname" = :ls_ClassName ) AND
					( "useralerts"."status" = 1 ) AND 
					( "joinuseralert"."employeeid" = :il_UserId) AND
					("useralerts"."id" = "joinuseralert"."alertid");
		
		OPEN UserAlerts;
		
		FETCH UserAlerts INTO :ll_messageID ;
		
		// Loop through result set until exhausted.
		
		DO WHILE SQLCA.sqlcode = 0
			
			IF IsNull ( lnv_Array.of_Findlong( ila_shownalerts , ll_messageID , 1, UpperBound ( ila_shownalerts ) ) ) THEN
				li_MsgCnt ++
				THIS.of_Alertseen( ll_messageID )
				lla_MsgIds [ li_MsgCnt ] = ll_messageID
			END IF
			// Fetch the next row from the result set.
			FETCH UserAlerts INTO :ll_messageID;
		LOOP
		
		// All done, so close the cursor.
		
		CLOSE UserAlerts;
		
		Commit;
		
	NEXT
	
	IF THIS.of_Showalerts( lla_MsgIds ) <> 1 THEN
		li_Return = -1
	END IF
	
END IF


RETURN li_Return

end function

public function integer of_showallalerts (pt_n_cst_beo anva_source[]);String	ls_ClassName
Long		ll_SourceID
Long		ll_messageID
Int		li_Count
Int		i
int		li_MsgCnt
Long		lla_MsgIds[]
n_cst_AnyArraySrv	lnv_Array

li_Count = UpperBound ( Anva_source[] )

FOR i = 1 TO li_Count

	ls_ClassName = anva_Source[i].ClassName ()
	ll_SourceID = anva_Source[i].of_GetSourceID ( )
	
	 DECLARE UserAlerts CURSOR FOR  
	  SELECT "useralerts"."id" 
		 FROM "useralerts"  
		WHERE ( "useralerts"."sourceid" = :ll_SourceID ) AND  
				( "useralerts"."classname" = :ls_ClassName ) ;					
	OPEN UserAlerts;
	FETCH UserAlerts INTO :ll_messageID ;
	
	// Loop through result set until exhausted.
	DO WHILE SQLCA.sqlcode = 0
		li_MsgCnt ++
		lla_MsgIds [ li_MsgCnt ] = ll_messageID
		// Fetch the next row from the result set.
		FETCH UserAlerts INTO :ll_messageID;
	LOOP
	
	// All done, so close the cursor.
	CLOSE UserAlerts;
	Commit;
	
NEXT


lnv_Array.of_GetShrinked( lla_MsgIds, TRUE , TRUE )

li_MsgCnt = UpperBound ( lla_Msgids ) 

IF THIS.of_Showalerts( lla_MsgIds ) <> 1 THEN

END IF
	

RETURN 1
end function

public function integer of_deactivatealert (long al_alertid);RETURN THIS.of_setalertstatus( al_alertid , ci_status_inactive )
end function

public function integer of_activatealert (long al_alertid);RETURN THIS.of_setalertstatus( al_alertid , ci_status_active )
end function

public function integer of_setalertstatus (long al_alertid, integer ai_status);Int	li_Status
Long	ll_AlertID
Int	li_Return

ll_AlertID = al_alertid
li_Status = ai_status 

UPDATE "useralerts"  
  SET "status" = :li_Status  
WHERE "useralerts"."id" = :ll_AlertID  ;

IF SQLCA.SQLCode = 0 THEN
	Commit;
	li_Return = 1
ELSE
	Rollback;
	li_Return = -1
END IF

RETURN li_Return


end function

public function integer of_reset ();Long	lla_EMPTY[]

ila_shownalerts = lla_EMPTY
RETURN  1
end function

private function integer of_showalert (long al_alertid);n_csT_msg	lnv_Msg
S_Parm		lstr_Parm
w_UserAlert	lw_UserAlert

	
lstr_Parm.ia_value = al_Alertid
lstr_Parm.is_Label = "messageID"
lnv_Msg.of_Add_Parm ( lstr_Parm )	

OpenWithParm ( lw_UserAlert , lnv_Msg )
	

RETURN 1

end function

public function integer of_showalertlist ();Open ( w_AlertList ) 
RETURN 1
end function

public function integer of_addsytemalert ();Int		li_Return = -1
Int		li_Status
Long		ll_MsgID
String	ls_Message
String	ls_ExistingMsg
String	ls_ClassName
String	ls_User
Date		ld_today
Time		lt_Now
Long		ll_User

n_Cst_msg	lnv_Msg
S_Parm		lstr_Parm

lstr_Parm.is_Label = "INSTRUCTIONS" 
lstr_PArm.ia_Value = "Enter message text."
lnv_Msg.of_add_parm( lstr_Parm )

lstr_Parm.is_Label = "Title" 
lstr_PArm.ia_Value = "User Alert"
lnv_Msg.of_add_parm( lstr_Parm )

OpenWithParm ( w_Textinput , lnv_Msg ) 

If isValid ( message.powerobjectparm  ) THEN
	lnv_Msg = message.powerobjectparm
	IF lnv_Msg.of_get_parm( "TEXT" , lstr_Parm ) > 0 THEN
		ls_Message = lstr_Parm.ia_Value
	END IF
END IF

gnv_app.of_Getnextid( "useralert" ,ll_MsgID , FALSE )
ls_Message = ls_Message
ls_ClassName = "system"
ls_User = gnv_App.of_Getuserid( )
ld_today = Today ( )
lt_Now	= Now ( )
li_Status = 1

IF ll_MsgID > 0 AND Len ( ls_Message ) > 0 THEN
  INSERT INTO "useralerts"  
         ( "id",   
           "classname",   
           "sourceid",   
           "alertmessage",   
           "usergroup" ,
			  "createdby",
			  "createddate",
			  "createdtime",
			  "status"	)  
  VALUES ( :ll_MsgID,   
           :ls_Classname,   
           null,   
           :ls_Message,   
           null,
			  :ls_User,
			  :ld_today,
			  :lt_Now,
			  :li_Status )  ;
  
	IF SQLCA.Sqlcode = 0 THEN
		
		IF THIS.of_Addalerttojointable( ll_MsgID ) = 1 THEN
			li_Return = 1
			COMMIT;
		END IF
		
	ELSE
		ROLLBACK;
	END IF

END IF
	
RETURN li_Return
end function

public function integer of_showsystemalerts ();String	ls_ClassName
Long		ll_SourceID
Long		ll_messageID
Int		li_Count
Int		i
int		li_MsgCnt
Long		lla_MsgIds[]
Int		li_Return


n_cst_AnyArraySrv	lnv_Array
ls_ClassName = "system"


DECLARE UserAlerts CURSOR FOR
SELECT "useralerts"."id" 
 FROM "useralerts" , 
		"joinuseralert"
 WHERE( "useralerts"."classname" = :ls_ClassName ) AND
		( "useralerts"."status" = 1 ) AND 
		( "joinuseralert"."employeeid" = :il_UserID) and
		("useralerts"."id" = "joinuseralert"."alertid");

OPEN UserAlerts;

FETCH UserAlerts INTO :ll_messageID ;

// Loop through result set until exhausted.	
DO WHILE SQLCA.sqlcode = 0

	li_MsgCnt ++			
	lla_MsgIds [ li_MsgCnt ] = ll_messageID
	// Fetch the next row from the result set.
	FETCH UserAlerts INTO :ll_messageID;
LOOP

// All done, so close the cursor.	
CLOSE UserAlerts;

Commit;
	
THIS.of_Showalerts( lla_MsgIds )	

RETURN 1

end function

public function integer of_deleteinactivealerts ();Int	li_return
Int	li_Status
 li_Status = THIS.ci_status_inactive
 
 
DELETE FROM "useralerts"  
WHERE "useralerts"."status" = :li_Status;

IF	SQLCA.Sqlcode = 0 THEN
	COMMIT;
	li_return = 1
ELSE
	ROLLBACK; 
	li_return = -1
END IF
	
RETURN li_return
end function

public function integer of_alertseen (long al_alertid);ila_shownalerts [ UpperBound ( ila_shownalerts ) + 1 ] = al_alertid
RETURN 1
end function

public function integer of_addalert (string as_msgtext, pt_n_cst_beo anv_source);Int		li_Return = -1
Int		li_Status
Long		ll_MsgID
Long		ll_SourceID
String	ls_Message
String	ls_ExistingMsg
String	ls_ClassName
String	ls_User
Date		ld_today
Time		lt_Now
Long		ll_User



gnv_app.of_Getnextid( "useralert" ,ll_MsgID , FALSE )
ls_Message = as_msgtext
ll_SourceID = anv_Source.of_Getsourceid( )
ls_ClassName = anv_Source.Classname( )
ls_User = gnv_App.of_Getuserid( )
ld_today = Today ( )
lt_Now	= Now ( )
li_Status = 1

IF ll_MsgID > 0 AND ll_SourceID > 0 AND Len ( ls_Message ) > 0 THEN
  INSERT INTO "useralerts"  
         ( "id",   
           "classname",   
           "sourceid",   
           "alertmessage",   
           "usergroup" ,
			  "createdby",
			  "createddate",
			  "createdtime",
			  "status"	)  
  VALUES ( :ll_MsgID,   
           :ls_Classname,   
           :ll_SourceID,   
           :ls_Message,   
           null,
			  :ls_User,
			  :ld_today,
			  :lt_Now,
			  :li_Status )  ;
  
	IF SQLCA.Sqlcode = 0 THEN
		
		IF THIS.of_Addalerttojointable( ll_MsgID ) = 1 THEN
			li_Return = 1
			COMMIT;
		END IF
	END IF
	
	IF li_Return <> 1 THEN
		ROLLBACK;
	END IF

END IF
	
IF li_Return = 1 THEN
	THIS.of_AlertSeen ( ll_MsgID )
END IF
	
RETURN li_Return
end function

private function integer of_addalerttojointable (long al_alertid);Long	lla_Users[]
Long	ll_Count
Long	i
Long	ll_NewRow
Int	li_Return

n_cst_EmployeeManager	lnv_EmpMan

DataStore	lds_Table
lds_table = CREATE DataStore
lds_Table.Dataobject = "d_UserAlertJoin"
lds_Table.SetTransObject ( SQLCA )

ll_Count = lnv_EmpMan.of_GetUserlist( lla_Users )

FOR i = 1 TO ll_Count
	ll_NewRow = lds_Table.InsertRow ( 0 )
	lds_Table.setitem( ll_NewRow,"EmployeeID", lla_Users [i] )
	lds_Table.setitem( ll_NewRow,"AlertID", al_alertid )
NEXT
  
IF lds_Table.Update( ) = 1 THEN
	li_Return = 1
	// commit is done by calling script
ELSE
	li_Return = -1
END IF

Destroy ( lds_Table )

RETURN li_Return


end function

public function integer of_deletealertforcurrentuser (long al_alertid);Int	li_Return = 1

IF li_Return = 1 THEN

	DELETE FROM "JoinUserAlert"  
	WHERE ( "JoinUserAlert"."employeeid" = :il_UserId ) AND  
			( "JoinUserAlert"."alertid" = :al_AlertID )   
			  ;
	
	
	IF SQLCA.SQLCode = 0 THEN
		Commit;
		li_Return = 1
	ELSE
		Rollback;
		li_Return = -1
	END IF
ELSE
	li_Return = -1
END IF

RETURN li_Return


end function

public function integer of_addalertforcurrentuser (long al_alertid);Int	li_Return = 1

IF li_Return = 1 THEN

	  INSERT INTO "joinuseralert"  
         ( "employeeid",   
           "alertid" )  
  		VALUES ( :il_UserId,   
           :al_AlertID )  ;
	
	
	IF SQLCA.SQLCode = 0 THEN
		Commit;
		li_Return = 1
	ELSE
		Rollback;
		li_Return = -1
	END IF
ELSE
	li_Return = -1
END IF

RETURN li_Return


end function

public function integer of_showalerts (long ala_msgids[]);Int	i
Int	li_msgCount
Int	li_DispCount
Long	lla_MsgIds[]
Long	ll_CurrentID
Int	li_Return = 1
	

lla_MsgIds = ala_msgids[]
li_MsgCount = UpperBound ( lla_MsgIds )

IF li_MsgCount > 0 THEN
	
	FOR i = 1 TO li_MsgCount
		
		ll_CurrentID = lla_MsgIds[i]
		THIS.of_Showalert( ll_CurrentID )
	
	/* We are not ging to flag failure here because we are only attempting to
		count the number of times the message is displayed. If we fail it is not
		significant.
	*/
	
		Select "displayCount" INTO :li_DispCount 
			From  "JoinUserAlert" 
			where "employeeID" = :il_UserID 
			and "Alertid" = :ll_CurrentID  ;
			
		IF isNull (li_DispCount ) THEN
			li_DispCount = 0
		END IF
		li_DispCount ++
		
		Update "JoinUserAlert" 
		Set "DisplayCount" = :li_DispCount
		where "employeeID" = :il_UserID 
		and "Alertid" = :ll_CurrentID  ;
		
		IF SQLCA.sqlcode = 0 THEN
			COMMIT;
		ELSE
			ROLLBACK;  			
		END IF
	/*         End of Display count logic       */
		
	NEXT
	
END IF



	
RETURN li_Return
end function

public function integer of_showalertsforcurrentuser ();Open ( w_AlertList_ByUser )
RETURN 1
end function

public function integer of_showinternaldbalerts ();String	ls_ClassName
Int		i
int		li_MsgCnt
Long		lla_MsgIds[]
Long		ll_messageID


n_cst_AnyArraySrv	lnv_Array

ls_ClassName = "DATABASE ALERT"

DECLARE UserAlerts CURSOR FOR
SELECT "useralerts"."id" 
 FROM "useralerts" , 
		"joinuseralert"
 WHERE( "useralerts"."classname" = :ls_ClassName ) AND
		( "useralerts"."status" = 1 ) AND 
		( "joinuseralert"."employeeid" = :il_UserID) and
		("useralerts"."id" = "joinuseralert"."alertid")AND 
		( "joinuseralert"."displayCount" is null );

OPEN UserAlerts;

FETCH UserAlerts INTO :ll_messageID ;

// Loop through result set until exhausted.	
DO WHILE SQLCA.sqlcode = 0
	li_MsgCnt ++			
	lla_MsgIds [ li_MsgCnt ] = ll_messageID
	// Fetch the next row from the result set.
	FETCH UserAlerts INTO :ll_messageID;
LOOP

// All done, so close the cursor.	
CLOSE UserAlerts;

Commit;

THIS.of_Showalerts( lla_MsgIds )	

RETURN 1

end function

public function integer of_showalertsforcurrentuser (long ala_alertids[], string as_caption);Integer		li_Return = 1
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm

//List of Ids to show in window (the rest will be discarded)
lstr_Parm.is_label = "ALERTIDS"
lstr_parm.ia_Value = ala_AlertIds
lnv_Msg.of_Add_Parm(lstr_Parm)

OpenWithParm(w_AlertList_ByUser, lnv_Msg )

IF Len(as_Caption) > 0 THEN
	IF isValid(w_AlertList_ByUser) THEN
		w_AlertList_ByUser.wf_SetCaption(as_Caption)
	END IF
END IF

Return li_Return
end function

on n_cst_alertmanager.create
call super::create
end on

on n_cst_alertmanager.destroy
call super::destroy
end on

event constructor;call super::constructor;il_UserId = gnv_App.of_GetNumericUserId()
end event

