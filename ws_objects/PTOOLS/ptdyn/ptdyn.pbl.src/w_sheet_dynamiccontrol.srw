$PBExportHeader$w_sheet_dynamiccontrol.srw
forward
global type w_sheet_dynamiccontrol from w_sheet
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//Boolean		sb_timedRefresh
//int				si_interval = -1
////end modification Shared Variables by appeon  20070730
end variables

global type w_sheet_dynamiccontrol from w_sheet
integer width = 2395
integer height = 2532
string menuname = "m_dynamiccontrolmenu2"
end type
global w_sheet_dynamiccontrol w_sheet_dynamiccontrol

type variables
Private Boolean		ib_JustOpened	= true

Private n_cst_Timer	inv_Timer 

Private	Boolean		ib_AdminMode

//begin modification Shared Variables by appeon  20070730
Boolean		sb_timedRefresh
int				si_interval = -1
//end modification Shared Variables by appeon  20070730



end variables

forward prototypes
public function integer of_autorefreshon ()
public function integer of_autorefreshoff ()
public function integer of_setrefreshrate (integer ai_interval)
public function integer of_setadminmode (boolean ab_switch)
public function boolean of_getadminmode ()
end prototypes

public function integer of_autorefreshon ();//turns on autorefresh by starting the timer with the set interval
//This is called on open now, if there is a system setting for autorefresh.
Integer li_Return

IF isValid(inv_Timer)  AND si_interval > 0 THEN
	inv_Timer.start(si_interval)
	li_Return = 1
ELSE
	li_Return = -1
END IF
RETURN li_Return



end function

public function integer of_autorefreshoff ();//turns off autorefresh by stopping the timer

Integer li_Return

IF isValid(inv_Timer) THEN
	inv_Timer.Stop()
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_setrefreshrate (integer ai_interval);//the interval in which refresh will be called with autorefresh
Integer li_Return = 1

IF ai_interval > 0 THEN
	si_Interval =	ai_interval
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_setadminmode (boolean ab_switch);ib_AdminMode = ab_Switch

IF ab_Switch THEN
	This.Title += "          ********** ADMIN MODE **********"
ELSE
	This.Title = This.of_GetObjName()
END IF

//Trigger Event on all controls 
This.Event ue_BroadCastEvent("ue_GetAdminMode")

Return 1
end function

public function boolean of_getadminmode ();Return	ib_AdminMode
end function

on w_sheet_dynamiccontrol.create
call super::create
if this.MenuName = "m_dynamiccontrolmenu2" then this.MenuID = create m_dynamiccontrolmenu2
end on

on w_sheet_dynamiccontrol.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event closequery;call super::closequery;/****
 4/13/06 - Maury -> For now user must manually save user settings
 Reason: Joe user probably will not need to tweak the window and therefore does not know
 			what the save user settings means. Lesser chance of saving undesired settings for
			non-ptadmin users.

//overriding ancestor
//The following checks to see if the user wants to save user settings for this window 
//after they close it.  

Int	li_return
Int 	li_result

Boolean lb_saveWatchlists

//WE never save user settings on templates.
IF is_objectName <> "Window Template"   THEN
	IF isValid( inv_mypropmanager ) THEN
		IF inv_myPropManager.iw_window = THIS THEN
			li_result = MessageBox("Save User Settings", "Save user settings before closing?", question!, yesnocancel!, 1)
		
		
			IF li_result = 1 THEN
				inv_myPropManager.of_saveSettings( )		//save settings and close
				li_return  = 0
				
			ELSEIF li_result = 2 THEN							//don't save settings and close
				lb_saveWatchlists = true
				li_return = 0
			ELSE
				li_return = 1										//cancel, stay open.
			END IF
		ELSE
			li_return = 0											//propmanager invalid, close
		END IF	
		
		inv_myPropManager.of_removeUnsavedPrefiltersFromCache()
		inv_myPropManager.of_discardprefilter( )
		IF lb_saveWatchlists THEN
			inv_myPropmanager.of_saveWatchLists()
		END IF
	END IF

ELSE
	li_return  = 0													//window is a template, close.

END IF

return li_return

****/
end event

event activate;call super::activate;//prevent calling refresh two times on opening.

IF ib_JustOpened THEN
	ib_JustOpened = FALSE
ELSE
	this.event ue_RefreshDws()
END IF

end event

event open;call super::open;n_cst_setting_dynamicObjectRefresh 	inv_refreshObj
String	ls_refreshRate
String	ls_LoggedInUser
gf_mask_Menu(m_sheets)


inv_refreshObj = CREATE n_cst_setting_dynamicObjectRefresh

ls_refreshRate = inv_RefreshObj.of_getValue( )
//Set up timer for auto refresh----------------------------------------------
inv_Timer = CREATE n_cst_Timer
inv_Timer.of_SetRequester(this)
inv_timer.of_setTimerEvent( "ue_refreshDws")



//initially the interval is -1 representing that the time has not yet been
//set.  A global function call will get the actual time. Right now its set
//to ten Minutes.
IF si_interval = -1 THEN
	
	IF IsNumber( ls_refreshRate ) THEN
		this.of_setRefreshRate( long( ls_refreshRate ))
		this.of_autoRefreshon( )
	END IF
END IF


end event

event close;//overrides ancestor because we don't want to close the created user objects
//before we save the watchlists.
Long	ll_index
Long	ll_max

IF isValid( inv_myPropManager ) THEN
	inv_myPropManager.of_removeUnsavedPrefiltersFromCache()
	inv_myPropManager.of_discardprefilter( )
	inv_myPropmanager.of_saveWatchLists()
	//this.of_closecreatedobjects( )
	Super::EVENT close()
END IF
end event

