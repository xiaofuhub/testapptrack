$PBExportHeader$n_cst_timing_notification.sru
$PBExportComments$[timing]
forward
global type n_cst_timing_notification from timing
end type
end forward

global type n_cst_timing_notification from timing
end type
global n_cst_timing_notification n_cst_timing_notification

type variables
n_Cst_bso_notification_Manager inv_notemanager
end variables

on n_cst_timing_notification.create
call timing::create
TriggerEvent( this, "constructor" )
end on

on n_cst_timing_notification.destroy
call timing::destroy
TriggerEvent( this, "destructor" )
end on

event destructor;//	
//Destroy (inv_notemanager) 
end event

event constructor;//
//inv_notemanager = Create n_cst_bso_notification_Manager 
end event

event timer;//// RDT 5-06-03 New method
//
////w_pop_progress lnv_pop
////Open(lnv_pop)
////lnv_pop.wf_settext ( "Sending Pending Notifications")
////lnv_pop.wf_showbar ( False)
////
//IF IsValid ( inv_notemanager ) THEN
////	MessageBox("RICH","of_SendPendingNotifications () ")
//	//	inv_notemanager.of_SendPendingNotifications () 
//Else
////	MessageBox("Notification Manager Error","Please restart the request service.")
//END IF
//
////Close (lnv_pop)
end event

