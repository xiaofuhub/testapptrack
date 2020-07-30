$PBExportHeader$n_cst_timing_statusrequest.sru
$PBExportComments$[timing]
forward
global type n_cst_timing_statusrequest from timing
end type
end forward

global type n_cst_timing_statusrequest from timing
end type
global n_cst_timing_statusrequest n_cst_timing_statusrequest

type variables
n_cst_bso_Notification_Manager	inv_NoteManager
Long   il_File
Time	it_BlackoutStart
Time	it_BlackoutEnd
end variables

forward prototypes
public function integer of_setblackouttime (string as_Value)
private function boolean of_inblackouttime ()
end prototypes

public function integer of_setblackouttime (string as_Value);n_Cst_String	lnv_String
String	lsa_Result[]

lnv_String.of_parseToArray ( as_Value , "*" , lsa_Result )
IF UpperBound ( lsa_Result ) > 1 THEN
	it_blackoutstart = Time ( lsa_Result[1] )
	it_blackoutend = Time ( lsa_Result[2] )
END IF

RETURN 1
end function

private function boolean of_inblackouttime ();Boolean	lb_Return
DateTime ldt_Now
DateTime ldt_Start
DateTime ldt_End
Long		ll_Offset
Time		lt_Now
Date 		ld_Today

lt_Now = NOW ( )
ld_Today = Today () 
ldt_Now = DateTime ( ld_Today , NOW ( ) )

IF ( it_blackoutstart < Time ( 23:59:59 ) AND it_blackoutstart > Time ( 11:59:59 ) ) AND &
	 ( it_blackoutend >= TIME ( 00:00:00 )  AND it_blackoutend <=  Time ( 11:59:59 )  ) THEN // We are starting at PM going to AM THEN
	// We are starting at PM going to AM 
	// so we will need to adjust the days
	IF lt_Now > it_Blackoutstart THEN
		// add one day to the end time
		ldt_Start = DateTime ( ld_Today , it_blackoutstart )
		ldt_End = DateTime ( RelativeDate ( ld_Today , 1 ) , it_blackoutend )
	ELSE
		// subtract one day from the start
		ldt_Start = DateTime (RelativeDate ( ld_Today , -1 ), it_blackoutstart )
		ldt_End = DateTime ( ld_Today , it_blackoutend )
	END IF

	lb_Return = (  ldt_Now >= ldt_Start AND ldt_Now <= ldt_End )
ELSE // The range is in the same day
	lb_Return = (  lt_now >= it_blackoutstart AND lt_now <= it_blackoutend )
END IF


RETURN lb_Return



//mboxret = 1
//if messagebox("Clear Search", "OK to clear the current search criteria?", question!, &
//	okcancel!, 2) = 2 then return
//
//if ib_HasResultSet = TRUE then
//	st_no_match.visible = false
//	dw_ship_list.reset()
//	dw_trip_list.reset()
//	st_range.text = "0 to 0 of 0"
//	ib_HasResultSet = FALSE
//end if
//
//uo_Radius.of_Unapplied ( )
//
//dw_search.deleterow(1)
//dw_search.insertrow(0)
//
////if search_type = "T" then dw_search.setitem(1, "ss_ref_type", "T") else search_type = "SE"
////dw_search.setitem(1, "ss_type", search_type)
//
//dw_search.setitem(1, "ss_type", search_type)
////if search_type = "T" then dw_search.setitem(1, "ss_ref_type", "T")  Commented 3.6.00
//
end function

on n_cst_timing_statusrequest.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_timing_statusrequest.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
inv_notemanager = CREATE n_cst_bso_Notification_Manager
//il_File = FileOpen ( "c:\timer.txt" , linemode! , write!)

end event

event destructor;DESTROY ( inv_notemanager )
IF IsValid ( SQLCA ) AND IsValid ( gnv_App ) THEN
	IF NOT SQLCA.of_IsConnected ( ) THEN
		gnv_App.of_ConnectToDB ( )
	END IF
END IF 
//FileClose ( il_File )
end event

event timer;// RDT 5-06-03 Centralized Email Processing 

// RDT 5-06-03 Commented out following code -START
//Long	File
//file = Fileopen ( "C:\Timer.txt" , lineMode! , Write! )
//FileWrite ( file , " Status " + String ( Now ( ) )  )
//FileClose ( file )
// RDT 5-06-03 Commented out following code -end

IF IsValid ( inv_notemanager ) THEN
	
	IF THIS.of_inBlackoutTime ( ) THEN
	//	MessageBox ( "Timer" , "Black out" )
		IF sqlca.of_IsConnected ( )  THEN
			gnv_app.of_DisconnectFromDB ( )
		//	MessageBox ( "DB" , "Disconnect" )
		END IF
	ELSE
		IF NOT sqlca.of_IsConnected ( )  THEN
			gnv_app.of_connectToDB ( )
		//	MessageBox ( "DB" , "Connect" )
		END IF
		//MessageBox ( "Timer" , "Process" )
		inv_notemanager.of_ProcessStatusRequests () 
		inv_notemanager.of_SendPendingNotifications ()  			// RDT 5-06-03
		
	END IF	
END IF


end event

