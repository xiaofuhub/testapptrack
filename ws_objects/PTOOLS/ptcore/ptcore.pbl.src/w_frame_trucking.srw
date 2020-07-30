$PBExportHeader$w_frame_trucking.srw
$PBExportComments$Trucking (Frame Window from PBL map PTApp) //@(*)[8916340|47]<nosync>
forward
global type w_frame_trucking from w_frame
end type
end forward

global type w_frame_trucking from w_frame
integer x = 0
integer y = 0
integer width = 3689
integer height = 2400
string title = "Profit Tools for Trucking"
string menuname = "m_frame_trucking"
windowtype windowtype = mdi!
windowstate windowstate = maximized!
end type
global w_frame_trucking w_frame_trucking

on w_frame_trucking.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_frame_trucking" then this.MenuID = create m_frame_trucking
end on

on w_frame_trucking.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_open;call super::pfc_open;//@(text)(recreate=yes)<Body>
String ls_sheet; w_sheet lw_sheet
ls_sheet = Message.StringParm
if ls_sheet > "" then
   OpenSheet(lw_sheet, ls_sheet, this, 0, Layered!)
else
   gnv_app.inv_taskmanager.BeginTask()
end if
//@(text)--

end event

event open;call super::open;//@(text)(recreate=yes)<Body>
this.of_setsheetmanager ( TRUE )
//@(text)--

//Force initial display of date & time on toolbar
This.Event Trigger Timer ( )

//Set timer event, which will update date & time display
Timer ( 15 )

gf_Mask_Menu ( m_Frame_Trucking )
end event

event pfc_postopen;call super::pfc_postopen;//@(text)(recreate=no)<Body>
//String ls_inifile
//
//ls_inifile = gnv_app.of_GetAppIniFile()
//
//SetPointer(Hourglass!)
//IF SQLCA.of_Init(ls_inifile,"Database") = -1 THEN     
// MessageBox("Database", "Unable to connect using " + ls_inifile) 
// HALT CLOSE  
//END IF  
//
//IF SQLCA.of_Connect() = -1 THEN     
// MessageBox("Database", "Unable to connect using " + ls_inifile)  
// HALT CLOSE 
//ELSE     
// gnv_app.of_GetFrame().SetMicroHelp("Connection complete") 
//END IF
//SetPointer(Arrow!)
gnv_app.Event Post task_OpenFirstWindow(this)
//@(text)--

end event

event timer;String	ls_TimeDisplay

ls_TimeDisplay = String ( Today ( ), "m/d  h:mm A/P" )
ls_TimeDisplay = Left ( ls_TimeDisplay, Len ( ls_TimeDisplay ) - 2 )

m_Frame_Trucking.m_System.m_Sys_Clock.ToolbarItemText = ls_TimeDisplay

n_cst_alertmanager	lnv_AlertManager
lnv_AlertManager = CREATE n_cst_alertmanager
lnv_AlertManager.of_Showinternaldbalerts( )
DESTROY ( lnv_AlertManager )
end event

event pfc_preclose;call super::pfc_preclose;Int	li_Return
Int	li_ThreadCount, i
Window	lw_Frame

String	lsa_ThreadIds[]
String	lsa_ThreadDetail[]
String	ls_Message
String	ls_ThreadList
n_cst_ThreadManager		lnv_ThreadManager
n_cst_ThreadComm			lnv_ThreadComm


li_Return = AncestorReturnValue

//Check if we are running any threads
IF li_Return = 1 THEN
	lnv_ThreadManager = gnv_App.of_GetThreadManager()
	IF isValid(lnv_ThreadManager) THEN
		
		li_ThreadCount = lnv_ThreadManager.of_BusyThreadCount(lsa_ThreadIds, lsa_ThreadDetail)
		
		IF li_ThreadCount  > 0 THEN
			
			FOR i = 1 TO li_ThreadCount
				ls_ThreadList += "~t-" + lsa_ThreadDetail[i] + "~r~n"
			NEXT
			
			ls_Message = "The following processes are still running in the background:~r~n" + ls_ThreadList + "~r~n" + &
							 "Please wait until these processes are done before closing Profit Tools."
			MessageBox ( "Exit Profit Tools" , ls_Message , Information! , OK! )
			
			//Send setfocus request to the threadComm object on the busy threads
			FOR i = 1 TO li_ThreadCount
				IF lnv_ThreadManager.of_GetThreadComm(lsa_ThreadIds[i], lnv_threadComm) = 1 THEN
					IF isValid(lnv_ThreadComm) THEN
						lnv_ThreadComm.of_SetFocus( )
					END IF
				END IF
			NEXT
			
			li_Return = -1 // do not close	
			
		END IF
		
	END IF

END IF



IF li_Return = 1 THEN
	
	n_cst_setting_confirmexit	lnv_ConfirmExit
	lnv_ConfirmExit = CREATE n_cst_setting_confirmexit
	IF NOT gnv_app.of_Runningscheduledtask( ) THEN  
		
		IF lnv_ConfirmExit.of_Getvalue( ) = lnv_ConfirmExit.cs_Yes THEN
			li_Return = -1  // don't close
			
			IF MessageBox ( "Exit Profit Tools" , "Do you really want to exit Profit Tools?" , QUESTION! , YESNO! , 2)  = 1 THEN
				li_Return = 1 // close	
			ELSE
				lw_Frame = gnv_App.of_GetFrame ( )
				lw_Frame.Post Show ( )

			END IF
		END IF
		
	END IF
	DESTROY  ( lnv_ConfirmExit )
	
END IF

RETURN li_Return

end event

event activate;call super::activate;IF gnv_app.ib_globaleventscheduler THEN
	IF isValid ( w_tasksrunning ) THEN
		w_tasksrunning.SetFocus ( ) 
	END IF
END IF

RETURN AncestorReturnValue
end event

