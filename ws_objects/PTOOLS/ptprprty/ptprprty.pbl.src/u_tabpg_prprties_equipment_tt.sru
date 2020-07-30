$PBExportHeader$u_tabpg_prprties_equipment_tt.sru
forward
global type u_tabpg_prprties_equipment_tt from u_tabpg_prprties_equipment
end type
type cb_uninstall from commandbutton within u_tabpg_prprties_equipment_tt
end type
type cb_upgrade from commandbutton within u_tabpg_prprties_equipment_tt
end type
type cb_terminalmapping from commandbutton within u_tabpg_prprties_equipment_tt
end type
type cb_rtcolmap from commandbutton within u_tabpg_prprties_equipment_tt
end type
type uo_7 from u_cst_eqtracesetting within u_tabpg_prprties_equipment_tt
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_tt
end type
end forward

global type u_tabpg_prprties_equipment_tt from u_tabpg_prprties_equipment
integer width = 1998
integer height = 1576
string text = "Track And Trace"
event ue_eqtracevaluechanged ( string as_value )
event ue_upgradeinterface ( )
event ue_uninstallinterface ( )
cb_uninstall cb_uninstall
cb_upgrade cb_upgrade
cb_terminalmapping cb_terminalmapping
cb_rtcolmap cb_rtcolmap
uo_7 uo_7
uo_1 uo_1
end type
global u_tabpg_prprties_equipment_tt u_tabpg_prprties_equipment_tt

forward prototypes
private function integer of_railtracesetup ()
end prototypes

event ue_eqtracevaluechanged(string as_value);IF as_Value = "Yes" THEN
	uo_7.of_Enable(TRUE)
	cb_rtcolmap.Enabled = TRUE
	cb_upgrade.Enabled = TRUE
	cb_terminalmapping.Enabled = TRUE
	cb_uninstall.Enabled = TRUE
ELSE
	uo_7.of_Enable(FALSE)
	cb_rtcolmap.Enabled = FALSE
	cb_upgrade.Enabled = FALSE
	cb_terminalmapping.Enabled = FALSE
	cb_uninstall.Enabled = FALSE
END IF
end event

event ue_upgradeinterface();Integer	li_Return = 1 //flag no return
String	ls_BackupLocation
Boolean	lb_BackupDb = TRUE

n_cst_LicenseManager  lnv_LicenseManager

//Upgrade interface
IF li_Return = 1 THEN
	lb_BackupDb = MessageBox("Interface Upgrade", "We recommend that a backup of the database is created before the interface is upgraded.~r~n~r~n" + &
						"Backup Database?", Information!, YesNo!, 1) = 1
						
	IF NOT lb_BackupDb THEN
		lb_BackupDb = MessageBox("Interface Upgrade", "Are you sure you want to skip the Database backup?", Information!, YesNo!, 2) = 2
	END IF
	
	li_Return =  lnv_LicenseManager.of_UpgradeRailTraceInterface(lb_BackupDb)
	
END IF

IF li_Return = 1 THEN
	MessageBox(gnv_App.of_getrailtraceappname( ) + " Interface Upgrade", gnv_App.of_getrailtraceappname( ) + " interface has been successfully upgraded.")
ELSE
	//failure messages taken care of in of_UpgradeRailTraceInterface
END IF
end event

event ue_uninstallinterface();Integer	li_Return = 1	//Flag only
String	ls_RailTraceAppname
String	ls_ErrorString

n_cst_ptrailtracemanager	lnv_RT

ls_RailTraceAppName = gnv_App.of_GetRailTraceAppName()

lnv_RT = Create	n_cst_ptrailtracemanager

SetPointer(HourGlass!)

//This will set the setting to NO and decativate interface
uo_1.Event ue_SetValueNo()


//Perform uninstall...
IF lnv_RT.of_UndoSetup() = 1 THEN
	
ELSE
	li_Return = -1
END IF

//Output
IF li_Return = 1 THEN
	MessageBox(ls_RailTraceAppName + " Interface Uninstall" , "Successfully uninstalled " + ls_RailTraceAppName + " interface.")
ELSE
	
	ls_ErrorString =  lnv_RT.of_GetErrorMsg()
	
	ls_ErrorString += "~r~nFailed to uninstall " + ls_RailTraceAppname + " interface."
	
	MessageBox(ls_RailTraceAppName + " Error" , ls_ErrorString  , EXCLAMATION! )
	
END IF

Destroy(lnv_RT)
end event

private function integer of_railtracesetup ();/***************************************************************************************
NAME: 	of_RailTraceSetup

ACCESS:	Private
		
ARGUMENTS: 	(none)

RETURNS:		Integer
	
DESCRIPTION: Sets up Initail Profit Tools/RailTrace interface
				 This should only be called if it is a FIRST time setup.
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/10/06
***************************************************************************************/
Integer		li_Return = 1
Integer 		li_errorCount
String		ls_ErrorString
String		ls_BackupLocation
String		ls_RailTraceAppName

//We should not drop anthing becuase
//A)This is the first interface setup OR
//B)The interface setup was un-installed and we need the temp mapping tables to re-establish the PT/RT mappings
Constant Boolean	lb_Drop = FALSE


ls_ErrorString	= "Error setting up " + ls_RailTraceAppName + " application."

n_cst_ptRailTraceManager		lnv_RT

lnv_Rt = Create	n_cst_ptRailTraceManager

n_cst_licensemanager		lnv_LicenseManager

ls_RailTraceAppName = gnv_app.of_GetRailTraceAppName()

//Check db version (the rail trace app needs 99 to check openshipments table)
IF lnv_LicenseManager.of_GetDbversion( ) < 99 THEN
	MessageBox(ls_RailTraceAppName + " Error.","Database must be upgraded before " + ls_RailTraceAppName + " can be initialized.")	
	li_Return = -1
END IF

//Make sure no other clients are running
IF li_Return = 1 THEN
	IF lnv_LicenseManager.of_GetLocalConnectionCount() > 1 THEN
		MessageBox("Interface Upgrade", "Profit Tools has detected other clients connected to the database.~r~n" + &
						  "Make sure that all clients are disconneced from Profit Tools and try again.")
		li_Return = -1
	END IF
END IF


//Back up db or warn
IF li_Return = 1 THEN
	IF lnv_LicenseManager.of_Asa9Db() THEN
		ls_BackUpLocation = lnv_licenseManager.of_GetDbBackUpLocation()
		IF lnv_LicenseManager.of_Backupdatabase(ls_BackUpLocation) <> 1 THEN
			MessageBox(ls_RailTraceAppName + " Setup Error.", "Error occured while trying to backup database to " + ls_BackupLocation + ".")
			li_Return = -1
		END IF
	ELSE
		IF MessageBox(ls_RailTraceAppName + " Setup", "WARNING:  DO NOT PERFORM THIS SETUP WITHOUT MAKING A BACKUP OF YOUR DATABASE FIRST. " + &
			"THIS SETUP IS NOT REVERSIBLE, AND ANY ERRORS COULD SERIOUSLY DAMAGE YOUR DATABASE.~n~n" + &
			"OK to proceed with " + ls_RailTraceAppName + " Setup?", Exclamation!, YesNo!, 2) = 2 THEN
			li_Return = -1
		END IF
	END IF
END IF

//Perform Setup
IF li_Return = 1 THEN
	
	IF lnv_RT.of_SetupRailTrace(lb_Drop) <> 1 THEN
		li_Return = -1
	END IF
	
	//Show Errors
	IF li_Return <> 1 THEN
		
		ls_ErrorString =  lnv_RT.of_GetErrorMsg()
		
		ls_ErrorString += "~r~nSettting will not be saved."
		
		MessageBox(ls_RailTraceAppName + " Error" , ls_ErrorString  , EXCLAMATION! )
		
	END IF
	
END IF

Destroy lnv_Rt

Return li_Return
end function

on u_tabpg_prprties_equipment_tt.create
int iCurrent
call super::create
this.cb_uninstall=create cb_uninstall
this.cb_upgrade=create cb_upgrade
this.cb_terminalmapping=create cb_terminalmapping
this.cb_rtcolmap=create cb_rtcolmap
this.uo_7=create uo_7
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_uninstall
this.Control[iCurrent+2]=this.cb_upgrade
this.Control[iCurrent+3]=this.cb_terminalmapping
this.Control[iCurrent+4]=this.cb_rtcolmap
this.Control[iCurrent+5]=this.uo_7
this.Control[iCurrent+6]=this.uo_1
end on

on u_tabpg_prprties_equipment_tt.destroy
call super::destroy
destroy(this.cb_uninstall)
destroy(this.cb_upgrade)
destroy(this.cb_terminalmapping)
destroy(this.cb_rtcolmap)
destroy(this.uo_7)
destroy(this.uo_1)
end on

event constructor;call super::constructor;This.text = gnv_App.of_GetRailTraceAppName()
end event

type cb_uninstall from commandbutton within u_tabpg_prprties_equipment_tt
integer x = 69
integer y = 952
integer width = 965
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "Uninstall Interface"
end type

event clicked;String	ls_RtAppName

ls_RtAppName = gnv_App.of_GetRailTraceAppName()
IF MessageBox("Uninstall " + ls_RtAppName + " interface", + &
	"Are you sure you want to uninstall the " + ls_RtAppName + " interface?~r~n" + &
	"You will not be able to re-install the interface untill all client users are out of Profit Tools.", Information!, YesNo!) = 1 THEN
	
	Parent.Event ue_UninstallInterface()
	
END IF
end event

type cb_upgrade from commandbutton within u_tabpg_prprties_equipment_tt
integer x = 69
integer y = 776
integer width = 965
integer height = 112
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Upgrade Interface"
end type

event clicked;Parent.Event ue_UpgradeInterface( )
end event

type cb_terminalmapping from commandbutton within u_tabpg_prprties_equipment_tt
integer x = 1179
integer y = 388
integer width = 690
integer height = 112
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Terminal Origin Mapping"
end type

event clicked;Open(w_terminaloriginmapping)
end event

type cb_rtcolmap from commandbutton within u_tabpg_prprties_equipment_tt
integer x = 1179
integer y = 252
integer width = 690
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Data Mapping"
end type

event clicked;Open(w_eqtracecolumnmapping)
end event

type uo_7 from u_cst_eqtracesetting within u_tabpg_prprties_equipment_tt
integer x = 59
integer y = 216
integer taborder = 20
end type

event constructor;call super::constructor;n_cst_LicenseManager	lnv_LicenseManager

inv_syssetting = CREATE n_cst_setting_EquipmentTypeTrace

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_7.destroy
call u_cst_eqtracesetting::destroy
end on

event destructor;call super::destructor;Destroy inv_syssetting
end event

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_tt
event ue_setvalueno ( )
integer x = 50
integer y = 60
integer width = 2034
integer taborder = 10
end type

event ue_setvalueno();rb_2.Checked = TRUE
This.Event ue_ChoiceChanged("No")
end event

event constructor;call super::constructor;String	ls_Dummy

n_cst_PtRailTraceManager	lnv_TraceManager

lnv_TraceManager = Create n_cst_PtRailTraceManager

inv_syssetting = CREATE n_cst_setting_RailTrace

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

//If RailTrace is installed, Enabled trace options
This.of_Enable(lnv_TraceManager.of_GetRailtraceApplicationFolder(ls_Dummy) = 1 )

Destroy(lnv_TraceManager)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

event ue_choicechanged;//Overriding Ancestor
Integer	li_Return = 1 //Flag, no return

String	ls_BackupLocation
String	ls_Rtappname

n_cst_licensemanager		lnv_LicenseManager
n_cst_setting_railtrace	lnv_RailTrace

IF as_Value = "Yes" THEN
	ls_Rtappname = gnv_App.of_GetRailTraceAppName()
	IF NOT lnv_LicenseManager.of_IsRailTraceSetup( ) THEN
		IF MessageBox(ls_Rtappname + " Setup", "Click OK to itialize Profit Tools/" + ls_Rtappname + " for the first time.", &
						Exclamation!, OKCancel!, 1) = 1 THEN
				
			//Setup railtrace
			IF Parent.of_RailTraceSetup() <> 1 THEN
				li_Return = -1
			END IF

		ELSE
			//deny
			li_Return = -1
		END IF
	END IF
	
	IF li_Return = -1 THEN
		This.rb_2.Checked = TRUE //Set back to No
	END IF

END IF


IF li_Return = 1 THEN
	inv_syssetting.of_savevalue( as_Value )
	Parent.Event ue_eqtracevaluechanged(as_Value)
END IF
end event

event ue_setvalue;call super::ue_setvalue;Parent.event ue_eqtracevaluechanged( anv_Setting.of_GetValue() )
Return AncestorReturnValue
end event

