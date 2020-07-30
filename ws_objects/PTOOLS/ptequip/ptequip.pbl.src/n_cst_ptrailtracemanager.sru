$PBExportHeader$n_cst_ptrailtracemanager.sru
forward
global type n_cst_ptrailtracemanager from n_cst_base
end type
end forward

global type n_cst_ptrailtracemanager from n_cst_base
end type
global n_cst_ptrailtracemanager n_cst_ptrailtracemanager

type variables
n_tr_RailTrace 	SQLCA2

CONSTANT String	cs_RailTraceIniFileName = "railtrace.ini"


Private:

Boolean	ib_RTConnected

String	is_RTVersionExpected

String isa_PTColumnList[] = { &
										"ArrivalDate", "ArrivalTime", "arrivedby", &
										"groundeddate", "groundedtime", "groundedby", &		
										"releasedate", "releasetime", "releaseby", &
										"etadate", "etatime", "etaby", &
										"pickupnumber", "pickupnumberby", &
										"Vessel", "Voyage", "Line", &
										"LastFreeDate", "LastFreeTime", "lfdby", &
										"Custom1", "Custom2", "Custom3", &
										"Custom4", "Custom5", "Custom6", &
										"Custom7", "Custom8","Custom9", &
										"Custom10" &
									  }

//Parallel Rail column mapping arrays
String	isa_RailColumnList[] = { &
										  "eqid", "eqref", "eqevent", "eqstatus", &
										  "rrref", "trainid", "city", "state", &
										  "eventdate", "eventtime", "railsite", "eqtype", &
										  "success","destcity","deststate", "etadate", &
										  "etatime","arrivaldate","arrivaltime", "groundeddate", &
										  "groundedtime","releasedate","releasetime", "pickupnumber", &
									     "lastfreedate","lastfreetime","lot", "chassi", &
										  "nextetatime","nextetadate","scrubbedeqref", "eventtype", & 
										  "timestampvalue" &
										}
										
String	isa_RailDisplayList[] = { &
											"Id", "Container", "Event", "L/E", &
										   "Carrier", "Train", "Location City", "Location State", &
										   "Event Date", "Event Time", "Reporting Rail", "Type", &
										   "Success", "Destination City", "Destination State", "ETA Date", &
										   "ETA Time", "Arrive Date","Arrive Time", "Grounded Date", &
										   "Grounded Time", "Released Date", "Released Time", "Pickup Num", &
										   "Last Free Date", "Last Free Time", "Lot", "Chassis", &
										   "Next ETA Time", "Next ETA Date", "scrubbedeqref", "Event Type", & 
										   "timestampvalue" &
										}

//Parallel Terminal column mapping arrays
String	isa_TerminalColumnList[] =  { &
											"eq_id", "eq_ref", "freightstatus", "terminalstatus", &
											"customsstatus", "linehold", "availableforpickup", "dischargedate", &
											"daysinyard", "freedays", "lastfreedate", "billoflading", &
											"line", "containertype", "vessel", "voyage", &
											"timestampvalue", "scrubbedeqref", "terminalsite", "success", &
											"gateoutdate", "usdahold", "demurragehold", "yardstatus", &
											"deliveryorder", "availabledate", "availabletime" &	
										  }
										  
String	isa_TerminalDisplayList[] =  { &
											"Id", "Container", "Freight Status", "Terminal Status", &
											"Customs Status", "Line Hold", "Available for Pickup", "Discharge Date", &
											"Days in Yard", "Free Days", "Last Free Date", "Bill of Lading", &
											"Line", "Container Type", "Vessel", "Voyage", &
											"timestampvalue", "scrubbedeqref", "Terminal Site", "Success", &
											"Outgate Date", "USDA Hold", "Demurrage Hold", "Yard Status", &
											"Delivery Order", "Available Date", "Available Time" &	
										  }




end variables

forward prototypes
private function integer of_adderror (string as_error)
public function integer of_setuprailtrace ()
private function integer of_initializerailtracedb ()
private function integer of_createtriggers ()
private function integer of_createrailtracetriggers ()
private function integer of_dropall ()
public function integer of_connecttorailtracedb ()
public function string of_getrtversionexpected ()
private function integer of_setrtversionexpected (string as_expected)
public function string of_geterrormsg ()
public function integer of_undosetup ()
private function integer of_dropallrailtrace ()
protected function integer of_initializedb ()
public function integer of_addequipmenttrace (long al_eqid)
public function integer of_addequipmenttrace (long ala_eqids[])
public function integer of_getptmapcolumns (ref string asa_columnlist[])
private function integer of_setcolumnremarks (string as_tablename, string asa_columnnames[], string asa_columnremarks[])
public function integer of_getterminalcolumndisplayvalues (ref string asa_columns[], ref string asa_displayvalues[])
public function integer of_getrailcolumndisplayvalues (ref string asa_columns[], ref string asa_displayvalues[])
public function integer of_getrailtraceapplicationfolder (ref string as_path)
public function integer of_setuprailtrace (boolean ab_drop)
end prototypes

private function integer of_adderror (string as_error);String				ls_ErrorMessage
n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

lnv_Error.SetErrorMessage( as_Error )
lnv_Error.SetMessageHeader (gnv_App.of_GetRailTraceAppName() + " Setup" )

RETURN 1
end function

public function integer of_setuprailtrace ();Integer	li_Return = 1

Constant Boolean	lb_DROP = TRUE

Return This.of_SetUpRailTrace(lb_DROP)
end function

private function integer of_initializerailtracedb ();/**************************************************************************************
NAME: 	of_InitializeRatilTraceDB

ACCESS:	Private
		
ARGUMENTS: 	(none)

RETURNS:		Integer
	
DESCRIPTION:
			Creates a remote server on the RT database so that proxy tables can be created on it.
			
			Creates a remote stored procedure 'ptsp_RailTraceUpdate' that points to pt db
			
			Returns 1 if database is successfully initialized for rail trace app
			Retuns -1 if database fails to initialize
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 7/05/06
***************************************************************************************/
Integer	li_Return = 1
String	ls_ErrMsg
String	ls_IniFile
String	ls_AppFolder
String	ls_Sql

SetPointer(Hourglass!)

//Connect to RT database
IF This.of_ConnectToRailTraceDb() <> 1 THEN
	ls_ErrMsg = "Could not find " + gnv_app.of_GetRailTraceAppName() + " application folder."
	li_Return = -1
END IF

//Create remote server to access proxy tables on rail trace database
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sys.sysservers WHERE srvname = 'local_ptdb') THEN "
	ls_sql += "CREATE SERVER local_ptdb CLASS 'asaodbc' USING 'Profit Tools Data' ~n" + &
				 "END IF"
				 
	Execute Immediate :ls_Sql USING SQLCA2;
	
	IF SQLCA2.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA2.sqlerrtext + "~n~nCould not create remote server 'local_ptdb'."
		li_Return = -1
	END IF
END IF

//Add remote stored procedure (rail)
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_RailTraceUpdate') THEN "
	ls_sql += "CREATE PROCEDURE ptsp_RailTraceUpdate() AT 'local_ptdb...ptsp_RailTraceUpdate' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql USING SQLCA2;
	
	IF SQLCA2.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA2.sqlerrtext + "~n~nCould not create remote stored procedure 'ptsp_RailTraceUpdate'."
		li_Return = -1
	END IF
END IF

//Add remote stored procedure (terminal)
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_TerminalTraceUpdate') THEN "
	ls_sql += "CREATE PROCEDURE ptsp_TerminalTraceUpdate() AT 'local_ptdb...ptsp_TerminalTraceUpdate' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql USING SQLCA2;
	
	IF SQLCA2.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA2.sqlerrtext + "~n~nCould not create remote stored procedure 'ptsp_TerminalTraceUpdate'."
		li_Return = -1
	END IF
END IF


SetPointer(Arrow!)

IF li_Return = 1 THEN
	COMMIT USING SQLCA2;
ELSE
	ROLLBACK USING SQLCA2;
	This.of_AddError(ls_ErrMsg)
END IF

Return li_Return
end function

private function integer of_createtriggers ();/***************************************************************************************
NAME: 	of_CreateTriggers

ACCESS:	Private
		
ARGUMENTS: 	(none)

RETURNS:		Integer
	
DESCRIPTION:
			Creates pt database triggers on the equipment table for rail trace interface
			
			Creates pt database event that (when enabled) will activate rail trace sys setting
			on db startup
			
			**Assumes that a remote server and proxy tables have been set up (see of_initializedb)
			
			Returns 1 if success
			Returns -1 if failure
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 6/21/06
***************************************************************************************/

Integer	li_Return = 1
String	ls_sql
String	ls_ErrMsg 

//Create insert trigger on outside_equip table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'outside_equipmentinsert')THEN "
	ls_sql += "CREATE TRIGGER outside_equipmentinsert AFTER INSERT ON DBA.outside_equip ~n" + &
				"REFERENCING NEW AS newRow ~n" + &
				"FOR EACH ROW WHEN((SELECT movecode FROM disp_ship WHERE ds_id = newRow.Shipment ) = 'I') ~n" + &
				"BEGIN ~n" + &
					"CALL ptsp_AddEquipmentTrace(newRow.oe_id); ~n" + & 
				"END; ~n" + &
				"END IF"
				
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create outside_equipmentinsert trigger."
		li_Return = -1
	END IF
END IF


//Create originationdate update trigger on outside_equip table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'outside_equipmentupdate_originationdate')THEN "
	ls_sql += "CREATE TRIGGER outside_equipmentupdate_originationdate AFTER UPDATE OF OriginationDate ON DBA.outside_equip ~n" + &
				"REFERENCING NEW AS newRow ~n" + &
				"FOR EACH ROW  ~n" + &
				"BEGIN ~n" + &
				   "CALL ptsp_RemoveEquipmentTrace(newRow.oe_id); ~n" + &
				"END; ~n" + &
				"END IF"
				
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create outside_equipmentupdate_originationdate trigger."
		li_Return = -1
	END IF
END IF

//Create eq_ref update trigger on equipment table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmentupdate_ref') THEN "
	ls_sql += "CREATE TRIGGER equipmentupdate_ref AFTER UPDATE OF eq_ref ORDER 1 ON DBA.equipment ~n" + &
				"REFERENCING OLD AS oldrow NEW AS newRow ~n" + &
				"FOR EACH ROW ~n" + &
				"BEGIN ~n" + &
					"CALL ptsp_UpdateEquipmentTrace(oldRow.eq_ref, newRow.eq_ref, newRow.eq_id) ~n" + &
				"END; ~n" + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create equipmentupdate_ref trigger."
		li_Return = -1
	END IF
END IF

//Create status update trigger on equipment table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmentupdate_status') THEN "
	ls_sql += "CREATE TRIGGER equipmentupdate_status AFTER UPDATE OF eq_status ORDER 2 ON DBA.equipment ~n" + &
				"REFERENCING OLD AS oldrow NEW AS newrow ~n" + &
				"FOR EACH ROW WHEN(newrow.eq_status = 'D') ~n" + &
				"BEGIN ~n" + &
					"CALL ptsp_RemoveEquipmentTrace(oldrow.eq_id); ~n" + &
				"END; ~n" + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create equipmentupdate_status trigger."
		li_Return = -1
	END IF
END IF

//Create type update trigger on equipment table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmentupdate_type') THEN "
	ls_sql += "CREATE TRIGGER equipmentupdate_type AFTER UPDATE OF eq_type ORDER 3 ON DBA.equipment ~n" + &
				"REFERENCING NEW AS newrow ~n" + &
				"FOR EACH ROW ~n" + &
				"BEGIN ~n" + &
					"IF LOCATE((Select ss_string FROM system_settings Where ss_id = 221),newrow.eq_type, 1) > 0 THEN ~n" + &
        				"CALL ptsp_AddEquipmentTrace(newrow.eq_id); ~n" + &
					"ELSE ~n" + &    
						 "CALL ptsp_RemoveEquipmentTrace(newrow.eq_id); ~n" + & 
					"END IF; ~n" + &
				"END; ~n" + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create equipmentupdate_type trigger."
		li_Return = -1
	END IF
END IF

//Create delete trigger on equipment table
//BEFORE DELETE because we need to look up the eq_ref in ptsp_RemoveEquipmentTrace
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmentdelete') THEN "
	ls_sql += "CREATE TRIGGER equipmentdelete BEFORE DELETE ON DBA.equipment ~n" + &
				"REFERENCING OLD AS oldrow ~n" + &
				"FOR EACH ROW ~n" + &
				"BEGIN ~n" + &
					"CALL ptsp_RemoveEquipmentTrace(oldrow.eq_id); ~n" + &
				"END; ~n" + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create equipmentdelete trigger."
		li_Return = -1
	END IF
END IF

/* This trigger has been phased out
	//Create delete trigger on openshipment table
	//IF li_Return = 1 THEN
	//	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'openshipmentsdelete') THEN "
	//	ls_sql += "CREATE TRIGGER openshipmentsdelete AFTER DELETE ON DBA.openshipments ~n" + &
	//				 "FOR EACH STATEMENT WHEN((Select ss_string FROM rt_system_settings Where ss_id = 1) = 'YES!') ~n" + &
	//				 "BEGIN ~n" + &
	//					"CALL ptsp_RailTraceUpdate(); ~n" + &
	//					"CALL ptsp_TerminalTraceUpdate(); ~n" + &
	//				 "END; ~n" + & 
	//				 "END IF"
	//				 
	//	Execute Immediate :ls_Sql;
	//	IF SQLCA.sqlcode <> 0 THEN
	//		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create openshipmentsdelete trigger."
	//		li_Return = -1
	//	END IF
	//END IF
*/

//Create movecode update trigger on shipment table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'shipmentupdatemovecode') THEN "
	ls_sql += "CREATE TRIGGER shipmentupdatemovecode AFTER UPDATE OF movecode ON DBA.disp_ship ~n" + &
				 "REFERENCING OLD AS oldrow NEW AS newRow ~n" + &
				 "FOR EACH ROW WHEN((Select ss_string FROM system_settings Where ss_id = 220) = 'YES!') ~n" + &
				 "BEGIN ~n" + &
					 "DECLARE err_notfound EXCEPTION FOR SQLSTATE '02000'; ~n" + &
					 "DECLARE eqid integer; ~n" + &
					 "DECLARE eqcursor CURSOR FOR ~n" + &
					 "SELECT oe_id FROM outside_equip WHERE Shipment = newRow.ds_id; ~n" + &
					 "OPEN eqcursor; ~n" + &
					 "EqLoop: ~n" + &
					 "LOOP ~n" + &     
						 "FETCH NEXT eqcursor INTO eqid; ~n" + &
						 "IF SQLSTATE = err_notfound THEN ~n" + &
							 "LEAVE EqLoop; ~n" + &
						 "END IF; ~n" + &
						 "IF oldRow.movecode = 'I' THEN ~n" + &
						   "CALL ptsp_RemoveEquipmentTrace(eqid); ~n" + &
						 "END IF; ~n" + &
						 "IF newRow.movecode = 'I' THEN ~n" + &
							"CALL ptsp_AddEquipmentTrace(eqid); ~n" + &
						 "END IF; ~n" + &
					 "END LOOP EqLoop; ~n" + & 
					 "CLOSE eqcursor; ~n" + &
				 "END;  ~n" + &
				 "END IF "
				 
	Execute Immediate :ls_Sql;
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create shipmentmovecode trigger."
		li_Return = -1
	END IF
END IF

//Create activate railtrace EVENT
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysevent WHERE event_name = 'ptev_ActivateRailTrace') THEN "
	ls_sql += "CREATE EVENT ptev_ActivateRailTrace ~n" + &
				 "TYPE DatabaseStart ~n" + &
				 "DISABLE ~n" + &
				 "HANDLER ~n" + &
				 "BEGIN ~n" + &
					"Update DBA.rt_system_settings ~n" + &
    				"Set ss_string = 'YES!'" + &
   				"Where ss_id = 1; ~n" + &
					"ALTER EVENT ptev_ActivateRailTrace DISABLE; ~n" + &
				 "END; ~n" + &
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create ptev_ActivateRailTrace event."
		li_Return = -1
	END IF
END IF

//Create insert trigger on shipment (for ds_origin_id)
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'shipmentinsertorigin') THEN "
	ls_sql +="CREATE TRIGGER shipmentinsertorigin AFTER INSERT ORDER 2 ON DBA.disp_ship ~n" + &
				"REFERENCING NEW AS newRow ~n" + &
				"FOR EACH ROW WHEN( newRow.ds_origin_id IS NOT NULL AND newRow.movecode = 'I') ~n" + &
				"BEGIN ~n" + &
					 "DECLARE err_notfound EXCEPTION FOR SQLSTATE '02000'; ~n" + & 
					 "DECLARE eqid integer; ~n" + & 
					 "DECLARE eqcursor CURSOR FOR SELECT oe_id FROM outside_equip WHERE Shipment = newRow.ds_id; ~n" + & 
					 "OPEN eqcursor; ~n" + & 
					 "EqLoop: ~n" + & 
					 "LOOP ~n" + & 
						  "FETCH NEXT eqcursor INTO eqid; ~n" + & 
						  "IF SQLSTATE = err_notfound THEN ~n" + & 
								"LEAVE EqLoop; ~n" + & 
						  "END IF; ~n" + &
						  "CALL ptsp_AddEquipmentTrace(eqid); ~n" + & 
					 "END LOOP EqLoop; ~n" + & 
					 "CLOSE eqcursor; ~n" + & 
				"END ~n" + &
				"END IF "
				 
	Execute Immediate :ls_Sql;
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create shipmentinsertorigin trigger."
		li_Return = -1
	END IF
END IF

//Create update trigger on shipment (for ds_origin_id update)
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'shipmentupdateorigin') THEN "
	ls_sql +="CREATE TRIGGER shipmentupdateorigin AFTER UPDATE OF ds_origin_id ORDER 2 ON DBA.disp_ship ~n" + &
				"REFERENCING OLD AS oldrow NEW AS newRow ~n" + &
				"FOR EACH ROW WHEN(newRow.movecode = 'I')~n" + &
				"BEGIN ~n" + &
					 "DECLARE err_notfound EXCEPTION FOR SQLSTATE '02000'; ~n" + & 
					 "DECLARE eqid integer; ~n" + & 
					 "DECLARE eqcursor CURSOR FOR SELECT oe_id FROM outside_equip WHERE Shipment = newRow.ds_id; ~n" + & 					
					 "OPEN eqcursor; ~n" + & 
					 "EqLoop: ~n" + & 
					 "LOOP ~n" + & 
						  "FETCH NEXT eqcursor INTO eqid; ~n" + & 
						  "IF SQLSTATE = err_notfound THEN ~n" + & 
								"LEAVE EqLoop; ~n" + & 
						  "END IF; ~n" + & 		
						  "IF newRow.ds_origin_id IS NULL THEN ~n" + &
								"CALL ptsp_RemoveEquipmentTrace(eqid); ~n" + &
						  "ELSEIF oldRow.ds_origin_id IS NULL THEN ~n" + &
								"CALL ptsp_AddEquipmentTrace(eqid); ~n" + &
						  "ELSE ~n" + &
								"CALL ptsp_UpdateEquipmentTraceOrigin(oldrow.ds_origin_id, newRow.ds_origin_id, eqid); ~n" + &
						  "END IF; ~n" + &
					 "END LOOP EqLoop; ~n" + & 
					 "CLOSE eqcursor; ~n" + & 
				"END ~n" + &
				"END IF "
				 
	Execute Immediate :ls_Sql;
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create shipmentupdateorigin trigger."
		li_Return = -1
	END IF
END IF


IF li_Return = 1 THEN
	commit;
ELSE
	rollback;
	This.of_AddError(ls_ErrMsg)
END IF

Return li_Return

end function

private function integer of_createrailtracetriggers ();/***************************************************************************************
NAME: 	of_CreateRailTraceTriggers

ACCESS:	Private
		
ARGUMENTS: 	(none)

RETURNS:		Integer
	
DESCRIPTION:

			**Assumes of_initializeRailTraceDB has been successfully executed.
			
			Creates rt database triggers on the equipmenttrace table for profit tools interface
			
			
			Returns 1 if success
			Returns -1 if failure
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 7/05/06
***************************************************************************************/
Integer	li_Return = 1
String	ls_sql
String	ls_ErrMsg 

//IF NOT isValid(SQLCA2) THEN
//	li_RETURN = -1
//	ls_ErrMsg = "Could not create triggers. sqlca2 not valid."
//END IF

//following 2 triggers commented out becuase we are calling the procedure in script now

//Create insert trigger on equipmenttrace table
//IF li_Return = 1 THEN
//	
//	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmenttraceinsert') THEN "
//	ls_sql += "CREATE TRIGGER equipmenttraceinsert AFTER INSERT ON DBA.equipmenttrace " + &
//				"REFERENCING NEW AS newRow " + &
//				"FOR EACH ROW WHEN ((Select ss_string FROM system_settings Where ss_id = 1) = 'YES!') " + &
//				"BEGIN " + &
//						"CALL ptsp_RailTraceUpdate(); " + &
//				"END; " + &
//				"END IF"
//				 
//	Execute Immediate :ls_Sql USING SQLCA2;
//	
//	IF SQLCA2.sqlcode <> 0 THEN
//		ls_ErrMsg = SQLCA2.sqlerrtext + "~n~nCould not create equipmenttraceinsert trigger."
//		li_Return = -1
//	END IF
//END IF

//Create update trigger on equipmenttrace table
//IF li_Return = 1 THEN
//	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmenttraceupdate') THEN "
//	ls_sql += "CREATE TRIGGER equipmenttraceupdate AFTER UPDATE ON DBA.equipmenttrace " + &
//				"FOR EACH STATEMENT WHEN((Select ss_string FROM system_settings Where ss_id = 1) = 'YES!') " + &
//				"BEGIN " + &
//					"CALL ptsp_railtraceupdate(); /*call remote sp on ptools db*/ " + &
//				"END; " + &
//				"END IF"
//				 
//	Execute Immediate :ls_Sql USING SQLCA2;
//	
//	IF SQLCA2.sqlcode <> 0 THEN
//		ls_ErrMsg = SQLCA2.sqlerrtext + "~n~nCould not create equipmenttraceupdate trigger."
//		li_Return = -1
//	END IF
//END IF



//IF li_Return = 1 THEN
//	COMMIT USING SQLCA2;
//ELSE
//	ROLLBACK USING SQLCA2;
//	This.of_AddError(ls_ErrMsg)
//END IF

Return li_Return
end function

private function integer of_dropall ();/**************************************************************************************
NAME: 	of_DropAll

ACCESS:	Private
		
ARGUMENTS: 	(none)

RETURNS:		Integer
	
DESCRIPTION:
			Drops all Profit Tools rail trace database configurations INCLUDING PROXY TABLES
			
			Returns 1 if database is successfully cleared
			Retuns -1 if database fails to clear
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/8/06
***************************************************************************************/

Integer	li_Return = 1
String	ls_Sql
String	ls_ErrMsg

//Drop insert trigger on outside_equip table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'outside_equipmentinsert')THEN "
	ls_sql += "DROP trigger outside_equipmentinsert; " + &
				"END IF"
				
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop equipmentinsert trigger."
		li_Return = -1
	END IF
END IF


//Drop originationdate update trigger on outside_equip table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'outside_equipmentupdate_originationdate')THEN "
	ls_sql += "DROP trigger outside_equipmentupdate_originationdate " + &
				"END IF"
				
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop equipmentinsert trigger."
		li_Return = -1
	END IF
END IF

//Drop eq_ref update trigger on equipment table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmentupdate_ref') THEN "
	ls_sql += "DROP trigger equipmentupdate_ref; " + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop equipmentupdate_ref trigger."
		li_Return = -1
	END IF
END IF

//Drop status update trigger on equipment table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmentupdate_status') THEN "
	ls_sql += "DROP trigger equipmentupdate_status; " + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop equipmentupdate_status trigger."
		li_Return = -1
	END IF
END IF

//Drop type update trigger on equipment table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmentupdate_type') THEN "
	ls_sql += "DROP trigger equipmentupdate_type; " + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop equipmentupdate_type trigger."
		li_Return = -1
	END IF
END IF

//Drop delete trigger on equipment table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmentdelete') THEN "
	ls_sql += "DROP trigger equipmentdelete; " + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop equipmentdelete trigger."
		li_Return = -1
	END IF
END IF

//Drop movecode update trigger on shipment table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'shipmentupdatemovecode') THEN "
	ls_sql += "DROP trigger shipmentupdatemovecode; " + &
				"END IF "
				 
	Execute Immediate :ls_Sql;
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop shipmentupdatemovecode trigger."
		li_Return = -1
	END IF
END IF

//Drop shipment insert trigger on shipment table (for origin insert)
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'shipmentinsertorigin') THEN "
	ls_sql += "DROP trigger shipmentinsertorigin; " + &
				"END IF "
				 
	Execute Immediate :ls_Sql;
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop shipmentinsertorigin trigger."
		li_Return = -1
	END IF
END IF

//Drop shipment update trigger on shipment table (for origin update)
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'shipmentupdateorigin') THEN "
	ls_sql += "DROP trigger shipmentupdateorigin; " + &
				"END IF "
				 
	Execute Immediate :ls_Sql;
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop shipmentupdateorigin trigger."
		li_Return = -1
	END IF
END IF


//Drop ptsp_AddEquipmentTrace stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_AddEquipmentTrace') THEN "
	ls_sql += "DROP procedure ptsp_AddEquipmentTrace; " + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop ptsp_AddEquipmentTrace."
		li_Return = -1
	END IF
END IF

//Drop ptsp_RemoveEquipmentTrace stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_RemoveEquipmentTrace') THEN "
	ls_sql += "DROP procedure ptsp_RemoveEquipmentTrace; " + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop ptsp_RemoveEquipmentTrace."
		li_Return = -1
	END IF
END IF

//Drop ptsp_UpdateEquipmentTrace stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_UpdateEquipmentTrace') THEN "
	ls_sql += "DROP procedure ptsp_UpdateEquipmentTrace; " + &
				"END IF"
				
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop ptsp_UpdateEquipmentTrace."
		li_Return = -1
	END IF
END IF

//Drop ptsp_UpdateEquipmentTraceOrigin stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_UpdateEquipmentTraceOrigin') THEN "
	ls_sql += "DROP procedure ptsp_UpdateEquipmentTraceOrigin; " + &
				"END IF"
				
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop ptsp_UpdateEquipmentTraceOrigin."
		li_Return = -1
	END IF
END IF



//Drop ptsp_railtraceupdate stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_RailTraceUpdate') THEN "
	ls_sql += "DROP procedure ptsp_RailTraceUpdate; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop ptsp_railtraceupdate."
		li_Return = -1
	END IF
	
END IF


//Drop ptsp_TerminalTraceUpdate stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_TerminalTraceUpdate') THEN "
	ls_sql += "DROP procedure ptsp_TerminalTraceUpdate; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop ptsp_terminaltraceupdate."
		li_Return = -1
	END IF
	
END IF


//Drop ptsp_DynamicShipmentUpdate stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_DynamicShipmentUpdate') THEN "
	ls_sql += "DROP procedure ptsp_DynamicShipmentUpdate; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop ptsp_DynamicShipemntUpdate."
		li_Return = -1
	END IF
	
END IF


//Drop ptfn_GetTerminalId fn
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptfn_GetTerminalId') THEN "
	ls_sql += "DROP procedure ptfn_GetTerminalId; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop ptfn_getterminalid."
		li_Return = -1
	END IF
	
END IF

//Drop ptfn_ExistsEquipmentTrace fn
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptfn_ExistsEquipmentTrace') THEN "
	ls_sql += "DROP procedure ptfn_ExistsEquipmentTrace; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop ptfn_ExistsEquipmentTrace."
		li_Return = -1
	END IF
	
END IF

//Drop ptfn_ExistsTerminalTrace fn
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptfn_ExistsTerminalTrace') THEN "
	ls_sql += "DROP procedure ptfn_ExistsTerminalTrace; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop ptfn_ExistsTerminalTrace."
		li_Return = -1
	END IF
	
END IF


//Drop activate railtrace EVENT
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysevent WHERE event_name = 'ptev_ActivateRailTrace') THEN "
	ls_sql += "DROP event ptev_ActivateRailTrace; " + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop ptev_ActivateRailTrace event."
		li_Return = -1
	END IF
END IF

//Drop equipmenttrace proxy table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'equipmenttrace') THEN "
	ls_sql += "DROP table equipmenttrace; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop equipmenttrace proxy table."
		li_Return = -1
	END IF
END IF

//Drop equipmenttrace_pending proxy table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'equipmenttrace_pending') THEN "
	ls_sql += "DROP table equipmenttrace_pending; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop equipmenttrace_pending proxy table."
		li_Return = -1
	END IF
END IF

//Drop equipmenttrace_deletebuffer proxy table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'equipmenttrace_deletebuffer') THEN "
	ls_sql += "DROP table equipmenttrace_deletebuffer; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop equipmenttrace_deletebuffer proxy table."
		li_Return = -1
	END IF
END IF

//Drop terminaltrace proxy table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltrace') THEN "
	ls_sql += "DROP table terminaltrace; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop terminaltrace proxy table."
		li_Return = -1
	END IF
END IF

//Drop terminaltrace_pending proxy table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltrace_pending') THEN "
	ls_sql += "DROP table terminaltrace_pending; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop terminaltrace_pending proxy table."
		li_Return = -1
	END IF
END IF

//Drop terminaltrace_deletebuffer proxy table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltrace_deletebuffer') THEN "
	ls_sql += "DROP table terminaltrace_deletebuffer; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop terminaltrace_deletebuffer proxy table."
		li_Return = -1
	END IF
END IF

//Drop terminaltrace_terminals proxy table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltrace_terminals') THEN "
	ls_sql += "DROP table terminaltrace_terminals; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop terminaltrace_terminals proxy table."
		li_Return = -1
	END IF
END IF

//Drop terminaltrace_terminalsites proxy table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltrace_terminalsites') THEN "
	ls_sql += "DROP table terminaltrace_terminalsites; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop terminaltrace_terminals proxy table."
		li_Return = -1
	END IF
END IF



//Drop rt_system_settings proxy table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'rt_system_settings') THEN "
	ls_sql += "DROP table rt_system_settings; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop rt_system_settings proxy table."
		li_Return = -1
	END IF
END IF


//Drop tt_errornotification proxy table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'tt_errornotification') THEN "
	ls_sql += "DROP table tt_errornotification; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop tt_errornotification proxy table."
		li_Return = -1
	END IF
END IF

//Drop remote server to access proxy tables on rail trace database
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sys.sysservers WHERE srvname = 'local_rtdb') THEN "
	ls_sql += "DROP server local_rtdb; " + &
				"END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop remote server."
		li_Return = -1
	END IF
END IF


//Create temp table
//this is used to restore deferred equipment
IF li_Return = 1 THEN
	
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'temprailcolmapping') THEN "
	ls_sql += "CREATE TABLE temp_equipmenttrace_deferred (eqid integer, eqref long varchar); " + &
				"ELSE " + &
				 "DELETE FROM temp_equipmenttrace_deferred " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create temprailcolmapping table."
		li_Return = -1
	END IF
END IF

//Temporiarily store old values
//Drop equipmenttrace_deferred table
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'equipmenttrace_deferred') THEN "
	ls_sql += 	"INSERT INTO temp_equipmenttrace_deferred SELECT * FROM equipmenttrace_deferred;" + &
					"DROP table equipmenttrace_deferred; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop equipmenttrace_deferred table."
		li_Return = -1
	END IF
END IF

//Create temp table
//this is used to restore rail col mappings in of_initializedb
IF li_Return = 1 THEN
	
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'temprailcolmapping') THEN "
	ls_sql += "CREATE TABLE temprailcolmapping (pt_col long varchar, rt_col long varchar); " + &
				"ELSE " + &
				 "DELETE FROM temprailcolmapping " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create temprailcolmapping table."
		li_Return = -1
	END IF
END IF

//Temporiarily store old values
//Drop railtracecolumnmapping table
IF li_Return = 1 THEN
	
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'railtracecolumnmapping') THEN "
	ls_sql +=  "INSERT INTO temprailcolmapping SELECT * FROM railtracecolumnmapping;" + &
				  "DROP table railtracecolumnmapping; " + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop railtracecolumnmapping table."
		li_Return = -1
	END IF
END IF

//Create temp table
//this is used to restore terminal col mappings in of_initializedb
IF li_Return = 1 THEN
	
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'tempterminalcolmapping') THEN "
	ls_sql += "CREATE TABLE tempterminalcolmapping (pt_col long varchar, tt_col long varchar); " + &
				"ELSE " + &
				 "DELETE FROM tempterminalcolmapping " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create tempterminalcolmapping table."
		li_Return = -1
	END IF
END IF

//Temporiarily store old values
//Drop terminaltracecolumnmapping table
IF li_Return = 1 THEN
	
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltracecolumnmapping') THEN "
	ls_sql +=  "INSERT INTO tempterminalcolmapping SELECT * FROM terminaltracecolumnmapping;" + &
				  "DROP table terminaltracecolumnmapping; " + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop terminaltracecolumnmapping table."
		li_Return = -1
	END IF
END IF

//Create temp table
//this is used to restore terminalorigin mappings in of_initializedb
IF li_Return = 1 THEN
	
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'tempterminaloriginmapping') THEN "
	ls_sql += "CREATE TABLE tempterminaloriginmapping (originid integer, terminalid integer); " + &
				 "ELSE " + &
				 "DELETE FROM tempterminaloriginmapping " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not create tempterminaloriginmapping table."
		li_Return = -1
	END IF
END IF

//Temporiarily store old values
//Drop terminaloriginmapping table
IF li_Return = 1 THEN
	
	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaloriginmapping') THEN "
	ls_sql += "INSERT INTO tempterminaloriginmapping SELECT * FROM terminaloriginmapping;" + &
				 "DROP table terminaloriginmapping; " + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + "~n~nCould not drop terminaloriginmapping table."
		li_Return = -1
	END IF
END IF


IF li_Return = 1 THEN
	commit;
ELSE
	rollback;
	This.of_AddError(ls_ErrMsg)
END IF

Return li_Return
end function

public function integer of_connecttorailtracedb ();Integer	li_Return = 1
String	ls_AppFolder
String	ls_IniFile
String	ls_ErrMsg

//Connect to RT database
IF NOT ib_RTConnected THEN
	
	IF This.of_GetRailTraceApplicationFolder(ls_AppFolder) = 1 THEN
		ls_IniFile = ls_AppFolder + cs_RailTraceIniFileName
		
		IF SQLCA2.of_Init(ls_inifile,"Database") = -1 THEN     
			ls_ErrMsg = "Unable to initialize rt database using " + ls_inifile
			li_Return = -1
		END IF  
		
		IF li_Return = 1 THEN
			IF SQLCA2.of_Connect() = -1 THEN     
				ls_ErrMsg = "Unable to connect to rt database using " + ls_inifile
				li_Return = -1
			ELSE
				ib_RTConnected = TRUE
			END IF
		END IF
	ELSE
		ls_ErrMsg = "Could not find RailTrace application folder for connection."
		li_Return = -1
	END IF
	
END IF

//Add errors
IF li_Return <> 1 THEN
	This.of_AddError(ls_ErrMsg)
END IF

Return li_Return
end function

public function string of_getrtversionexpected ();Return is_RtVersionExpected
end function

private function integer of_setrtversionexpected (string as_expected);is_RtVersionExpected = as_expected

Return 1
end function

public function string of_geterrormsg ();//Reports first error in the error collection

Integer	li_Return = 1
Integer	li_ErrorCount
String	ls_ErrorMsg

n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection

lnv_ErrorCollection = GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_Errorcollection.GetErrorcount( )

IF li_ErrorCount > 0 THEN
	ls_ErrorMsg =  lnva_Error[1].GetErrorMessage() 
END IF
	
Return ls_ErrorMsg
end function

public function integer of_undosetup ();/**************************************************************************************
NAME: 	of_UndoSetup

ACCESS:	Public
		
ARGUMENTS: 	(none)

RETURNS:		Integer
	
DESCRIPTION:
			Drops everything that is created during of_SetupRailTrace
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/24/06
***************************************************************************************/

Integer	li_Return = 1

//Drop pt setup
IF li_Return = 1 THEN	
	IF This.of_DropAll() <> 1 THEN
		li_Return = -1
	END IF
END IF

//Drop rt setup
IF li_Return = 1 THEN
	IF This.of_DropAllRailTrace() <> 1 THEN
		li_Return = -1
	END IF
END IF
	
Return li_Return
end function

private function integer of_dropallrailtrace ();/**************************************************************************************
NAME: 	of_DropAllRailTrace

ACCESS:	Private
		
ARGUMENTS: 	(none)

RETURNS:		Integer
	
DESCRIPTION:
			Drops all PT/RT database configurations on the RT db
			
			Returns 1 if database is successfully cleared
			Retuns -1 if database fails to clear
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/8/06
***************************************************************************************/

Integer	li_Return = 1
String	ls_ErrMsg
String	ls_Sql

IF NOT isValid(SQLCA2) THEN
	li_RETURN = -1
END IF

//Connect to RT db
IF This.of_ConnectToRailTraceDb() <> 1 THEN
	li_Return = -1
	ls_ErrMsg = "Could not connect to " + gnv_App.of_GetRailTraceAppName() + " db."
END IF

//Drop insert trigger on equipmenttrace table
//IF li_Return = 1 THEN
//	
//	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmenttraceinsert') THEN "
//	ls_sql += "DROP TRIGGER equipmenttraceinsert; " + &
//				"END IF"
//				 
//	Execute Immediate :ls_Sql USING SQLCA2;
//	
//	IF SQLCA2.sqlcode <> 0 THEN
//		ls_ErrMsg = SQLCA2.sqlerrtext + "~n~nCould not drop equipmenttraceinsert trigger."
//		li_Return = -1
//	END IF
//END IF

//Drop update trigger on equipmenttrace table
//IF li_Return = 1 THEN
//	ls_sql = "IF EXISTS (SELECT 1 FROM systriggers WHERE trigname = 'equipmenttraceupdate') THEN "
//	ls_sql += "DROP TRIGGER equipmenttraceupdate; " + &
//				"END IF"
//				 
//	Execute Immediate :ls_Sql USING SQLCA2;
//	
//	IF SQLCA2.sqlcode <> 0 THEN
//		ls_ErrMsg = SQLCA2.sqlerrtext + "~n~nCould not drop equipmenttraceupdate trigger."
//		li_Return = -1
//	END IF
//END IF

//DROP rail remote stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_RailTraceUpdate') THEN "
	ls_sql += "DROP PROCEDURE ptsp_RailTraceUpdate; " + &
				 "END IF"
	
	Execute Immediate :ls_Sql USING SQLCA2;
	
	IF SQLCA2.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA2.sqlerrtext + "~n~nCould not drop remote stored procedure 'ptsp_RailTraceUpdate'."
		li_Return = -1
	END IF
END IF

//DROP terminal remote stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_TerminalTraceUpdate') THEN "
	ls_sql += "DROP PROCEDURE ptsp_TerminalTraceUpdate; " + &
				 "END IF"
	
	Execute Immediate :ls_Sql USING SQLCA2;
	
	IF SQLCA2.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA2.sqlerrtext + "~n~nCould not drop remote stored procedure 'ptsp_TerminalTraceUpdate'."
		li_Return = -1
	END IF
END IF

//Drop remote server to access proxy tables on rail trace database
IF li_Return = 1 THEN
	ls_sql = "IF EXISTS (SELECT 1 FROM sys.sysservers WHERE srvname = 'local_ptdb') THEN "
	ls_sql += "DROP SERVER local_ptdb; " + &
				 "END IF"
				 
	Execute Immediate :ls_Sql USING SQLCA2;
	
	IF SQLCA2.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA2.sqlerrtext + "~n~nCould not drop remote server 'local_ptdb'."
		li_Return = -1
	END IF
END IF



SetPointer(Arrow!)

IF li_Return = 1 THEN
	COMMIT USING SQLCA2;
ELSE
	ROLLBACK USING SQLCA2;
	This.of_AddError(ls_ErrMsg)
END IF

Return li_Return
end function

protected function integer of_initializedb ();/**************************************************************************************
NAME: 	of_InitializeDB

ACCESS:	Private
		
ARGUMENTS: 	(none)

RETURNS:		Integer
	
DESCRIPTION:
			Creates a remote server on the database so that proxy tables can be created on it.
			
			Creates a proxy tables that point to rail trace db
			
			Creates a stored procedure 'ptsp_railtraceupdate' that will be accessed remotely from the rail trace app
			Creates a stored procedure 'ptsp_terminaltraceupdate' that will be accessed remotely from the rail trace app
			
			Creates supporting stored procedures and functions
			
			Inserts System Setting for most recent trace timestamp
			Inserts System Setting PT->RT Interface (outbound) [defaults to NO!]
			Inserts System Setting RT->PT Interface (inbound) [defaults to NO!]
			
			Returns 1 if database is successfully initialized for rail trace app
			Retuns -1 if database fails to initialize
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 6/21/06
***************************************************************************************/

Integer	li_Return = 1
String	ls_sql
String	ls_ErrMsg 

//Create remote server to access proxy tables on rail trace database
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sys.sysservers WHERE srvname = 'local_rtdb') THEN "
	ls_sql += "CREATE SERVER local_rtdb CLASS 'asaodbc' USING 'Rail Trace Data' ~n" + &
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create remote server."
		li_Return = -1
	END IF
END IF

//Add equipmenttrace proxy table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'equipmenttrace') THEN "
	ls_sql += "CREATE EXISTING TABLE equipmenttrace AT 'local_rtdb...equipmenttrace' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create equipmenttrace proxy table."
		li_Return = -1
	END IF
END IF

//Add equipmenttrace_pending proxy table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'equipmenttrace_pending') THEN "
	ls_sql += "CREATE EXISTING TABLE equipmenttrace_pending AT 'local_rtdb...equipmenttrace_pending' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create equipmenttrace_pending proxy table."
		li_Return = -1
	END IF
END IF

//Add equipmenttrace_deletebuffer proxy table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'equipmenttrace_deletebuffer') THEN "
	ls_sql += "CREATE EXISTING TABLE equipmenttrace_deletebuffer AT 'local_rtdb...equipmenttrace_deletebuffer' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create equipmenttrace_deletebuffer proxy table."
		li_Return = -1
	END IF
END IF

//Add terminatrace proxy table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltrace') THEN "
	ls_sql += "CREATE EXISTING TABLE terminaltrace AT 'local_rtdb...terminaltrace' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create terminaltrace proxy table."
		li_Return = -1
	END IF
END IF


//Add terminaltrace_pending proxy table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltrace_pending') THEN "
	ls_sql += "CREATE EXISTING TABLE terminaltrace_pending AT 'local_rtdb...terminaltrace_pending' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create terminaltrace_pending proxy table."
		li_Return = -1
	END IF
END IF

//Add terminaltrace_deletebuffer proxy table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltrace_deletebuffer') THEN "
	ls_sql += "CREATE EXISTING TABLE terminaltrace_deletebuffer AT 'local_rtdb...terminaltrace_deletebuffer' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create terminaltrace_deletebuffer proxy table."
		li_Return = -1
	END IF
END IF

//Add terminaltrace_terminals proxy table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltrace_terminals') THEN "
	ls_sql += "CREATE EXISTING TABLE terminaltrace_terminals AT 'local_rtdb...terminals' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create terminaltrace_terminals proxy table."
		li_Return = -1
	END IF
END IF

//Add terminaltrace_terminalsites proxy table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltrace_terminalsites') THEN "
	ls_sql += "CREATE EXISTING TABLE terminaltrace_terminalsites AT 'local_rtdb...terminalsites' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create terminaltrace_terminals proxy table."
		li_Return = -1
	END IF
END IF


//Add terminaloriginmapping table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaloriginmapping') THEN "
	ls_sql += "CREATE TABLE DBA.terminaloriginmapping(originid integer NOT NULL UNIQUE, terminalid integer NOT NULL, PRIMARY KEY (originid) , FOREIGN KEY companies (originid) REFERENCES DBA.companies ON DELETE CASCADE ) ; ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create terminaloriginmapping table."
		li_Return = -1
	END IF
END IF

//Copy old data to terminaloriginmapping table
IF li_Return = 1 THEN
 	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'tempterminaloriginmapping') THEN "
	ls_sql += "INSERT INTO DBA.terminaloriginmapping SELECT * FROM tempterminaloriginmapping; ~n" + &
				 "DROP TABLE tempterminaloriginmapping; ~n" + & 
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould copy old data to terminaloriginmapping table."
		li_Return = -1
	END IF
				 
END IF


//Add equipmenttrace_deferred table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'equipmenttrace_deferred') THEN "
	ls_sql += "CREATE TABLE DBA.equipmenttrace_deferred(eqid integer NOT NULL DEFAULT NULL, eqref varchar(15) DEFAULT NULL , PRIMARY KEY (eqid) , FOREIGN KEY equipment (eqid) REFERENCES DBA.equipment ON DELETE CASCADE ) ; ~n" + &
				 "CREATE CLUSTERED INDEX ndx_eqref ON DBA.equipmenttrace_deferred ( eqref ASC ) IN SYSTEM; ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create equipmenttrace_deferred table."
		li_Return = -1
	END IF
END IF

//Copy old data to equipmenttrace_deferred table
IF li_Return = 1 THEN
 	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'temp_equipmenttrace_deferred') THEN "
	ls_sql += "INSERT INTO DBA.equipmenttrace_deferred SELECT * FROM temp_equipmenttrace_deferred; ~n" + &
				 "DROP TABLE temp_equipmenttrace_deferred; ~n" + & 
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould copy old data to tequipmenttrace_deferred table."
		li_Return = -1
	END IF
				 
END IF

//Add railtracecolumnmapping table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'railtracecolumnmapping') THEN "
	ls_sql += "CREATE TABLE DBA.railtracecolumnmapping (ptcol long varchar NOT NULL DEFAULT NULL, rtcol long varchar DEFAULT NULL , PRIMARY KEY (ptcol)); ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create railtracecolumnmapping table."
		li_Return = -1
	END IF
END IF

//Copy old data to railtracecolumnmapping table
IF li_Return = 1 THEN
 	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'temprailcolmapping') THEN "
	ls_sql += "INSERT INTO DBA.railtracecolumnmapping SELECT * FROM temprailcolmapping; ~n" + &
				 "DROP TABLE temprailcolmapping; ~n" + & 
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould copy old data to railtracecolumnmapping table."
		li_Return = -1
	END IF
				 
END IF

//Add terminalcolumnmapping table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'terminaltracecolumnmapping') THEN "
	ls_sql += "CREATE TABLE DBA.terminaltracecolumnmapping (ptcol long varchar NOT NULL DEFAULT NULL, ttcol long varchar DEFAULT NULL , PRIMARY KEY (ptcol)); ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create terminaltracecolumnmapping table."
		li_Return = -1
	END IF
END IF

//Copy old data to terminaltracecolumnmapping table
IF li_Return = 1 THEN
 	ls_sql = "IF EXISTS (SELECT 1 FROM systable WHERE table_name = 'tempterminalcolmapping') THEN "
	ls_sql += "INSERT INTO DBA.terminaltracecolumnmapping SELECT * FROM tempterminalcolmapping; ~n" + &
				 "DROP TABLE tempterminalcolmapping; ~n" + & 
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould copy old data to terminaltracecolumnmapping table."
		li_Return = -1
	END IF
				 
END IF
			
//Add rt_system_settings proxy table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'rt_system_settings') THEN "
	ls_sql += "CREATE EXISTING TABLE rt_system_settings AT 'local_rtdb...system_settings' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create rt_system_settings proxy table."
		li_Return = -1
	END IF
END IF

//Add tt_errornotification proxy table
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM systable WHERE table_name = 'tt_errornotification') THEN "
	ls_sql += "CREATE EXISTING TABLE tt_errornotification AT 'local_rtdb...notification' ~n" + &
				 "END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create tt_errornotification proxy table."
		li_Return = -1
	END IF
END IF

//Add ptfn_GetTerminalId() function
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptfn_GetTerminalId') THEN "
	ls_sql += "CREATE FUNCTION ptfn_GetTerminalId(IN ai_originid integer) RETURNS integer NOT DETERMINISTIC ~n" + &
				 "BEGIN ~n" + &
					 "DECLARE li_terminalid integer; ~n" + &
					 "SET li_terminalid = (SELECT terminalid FROM terminaloriginmapping WHERE originid = ai_originid); ~n" + &
					 "IF li_terminalid IS NULL THEN ~n" + &
						  "SET li_terminalid = 0 ~n" + &
					 "END IF; ~n" + &
					 "RETURN li_terminalid ~n" + &
				 "END; ~n" + &
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create function ptfn_GetTerminalId."
		li_Return = -1
	END IF
END IF

//Add ptfn_ExistsEquipmentTrace() function
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptfn_ExistsEquipmentTrace') THEN "
	ls_sql += "CREATE FUNCTION ptfn_ExistsEquipmentTrace(IN as_eqref varchar(15)) RETURNS bit NOT DETERMINISTIC ~n" + &
				 "BEGIN ~n" + &
					"DECLARE li_exists bit; ~n" + &
					"Set li_exists = 0; ~n" + &
					"IF EXISTS (SELECT eqref FROM equipmenttrace WHERE eqref = as_eqref) THEN ~n" + &
						"SET li_exists = 1; ~n" + &
					"END IF; ~n" + & 
					"IF EXISTS (SELECT eqref FROM equipmenttrace_pending WHERE eqref = as_eqref) THEN ~n" + &
						"Set li_exists = 1; ~n" + &
					"END IF; ~n" + &
					"RETURN li_exists; ~n" + &
				 "END; ~n" + &
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create function ptfn_ExistsEquipmentTrace()."
		li_Return = -1
	END IF
END IF

//Add ptfn_ExistsTerminalTrace() function
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptfn_ExistsTerminalTrace') THEN "
	ls_sql += "CREATE FUNCTION ptfn_ExistsTerminalTrace(IN as_eqref varchar(15)) RETURNS bit NOT DETERMINISTIC ~n" + &
				 "BEGIN ~n" + &
					 "DECLARE li_exists bit; ~n" + &
					 "Set li_exists = 0; ~n" + &
					 "IF EXISTS (SELECT eq_ref FROM terminaltrace WHERE eq_ref = as_eqref) THEN ~n" + & 
					 "SET li_exists = 1; ~n" + &
					 "END IF; ~n" + & 
					 "IF EXISTS (SELECT eq_ref FROM terminaltrace_pending WHERE eq_ref = as_eqref) THEN ~n" + &
						 "Set li_exists = 1; ~n" + &
					 "END IF; ~n" + &
					 "RETURN li_exists; ~n" + &
				 "END; ~n" + &
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create function ptfn_ExistsTerminalTrace."
		li_Return = -1
	END IF
END IF

//Add ptsp_AddEquipmentTrace stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_AddEquipmentTrace') THEN "
	ls_sql += "CREATE PROCEDURE ptsp_AddEquipmentTrace(IN equip_id integer) ~n" + &
				 "BEGIN ~n" + &
				 	 "DECLARE equip_ref varchar(15);~n" + &
					 "DECLARE equip_type char(1); ~n" + & 
					 "DECLARE equip_terminalid integer; ~n" + & 
					 "DECLARE equip_originid integer; ~n" + & 
					 "IF (Select ss_string FROM system_settings Where ss_id = 220) = 'YES!' THEN ~n" + &
						  "SET equip_type = (SELECT eq_type FROM equipment WHERE eq_id = equip_id); ~n" + & 
						  "IF LOCATE((Select ss_string FROM system_settings Where ss_id = 221),equip_type, 1) > 0 THEN ~n" + &
								"SET equip_originid = (SELECT ds_origin_id FROM disp_ship WHERE ds_id = (SELECT Shipment FROM outside_equip WHERE oe_id = equip_id)); ~n" + &
								"IF equip_originid > 0 THEN ~n" + & 
									 "SET equip_ref = (SELECT eq_ref FROM equipment WHERE eq_id = equip_id); ~n" + & 
									 "SET equip_terminalid = ptfn_GetTerminalId(equip_originid); ~n" + & 
									 "IF equip_terminalid > 0 THEN ~n" + &
										  "IF NOT EXISTS (SELECT eq_ref, terminalsite FROM DBA.terminaltrace_pending WHERE eq_ref = equip_ref AND terminalsite = equip_terminalid) THEN ~n" + &
												"INSERT INTO DBA.terminaltrace_pending(eq_ref, terminalsite) VALUES(equip_ref, equip_terminalid); ~n" + &
										  "ELSE ~n" + &
												"DELETE FROM DBA.terminaltrace_deletebuffer WHERE eq_ref = equip_ref AND terminalid = equip_terminalid; ~n" + &
										  "END IF ~n" + &
									 "ELSE ~n" + & 
										  "IF NOT EXISTS (SELECT eqref FROM DBA.equipmenttrace_pending WHERE eqref = equip_ref) THEN ~n" + &
												"INSERT INTO DBA.equipmenttrace_pending(eqref) VALUES(equip_ref); ~n" + &
											"ELSE ~n" + &
												"DELETE FROM DBA.equipmenttrace_deletebuffer WHERE eqref = equip_ref; ~n" + &
										  "END IF; ~n" + &
									 "END IF; ~n" + & 
								"END IF; ~n" + & 
						  "END IF; ~n" + & 
					 "END IF; ~n" + & 
				 "END; ~n" + &
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create ptsp_AddEquipmentTrace."
		li_Return = -1
	END IF
END IF

//Add ptsp_RemoveEquipmentTrace stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_RemoveEquipmentTrace') THEN "
	ls_sql += "CREATE PROCEDURE ptsp_RemoveEquipmentTrace(IN eqid integer) ~n" + &
				 "BEGIN ~n" + &
					 "DECLARE equip_ref varchar(15); ~n" + &
					 "DECLARE equip_originid integer; ~n" + &
					 "IF (Select ss_string FROM system_settings Where ss_id = 220) = 'YES!' THEN ~n" + & 
							"SET equip_ref = (SELECT eq_ref FROM equipment WHERE eq_id = eqid); ~n" + & 
							"IF ptfn_ExistsTerminalTrace(equip_ref) = 1 THEN ~n" + &
								 "INSERT INTO DBA.terminaltrace_deletebuffer(eq_ref) VALUES(equip_ref); ~n" + & 
							"END IF; ~n" + &
							"IF ptfn_ExistsEquipmentTrace(equip_ref) = 1 THEN ~n" + & 
								 "INSERT INTO DBA.equipmenttrace_deletebuffer(eqref) VALUES(equip_ref); ~n" + & 
							"END IF; ~n" + &
					 "END IF; ~n" + & 
				 "END; ~n" + &
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create ptsp_RemoveEquipmentTrace."
		li_Return = -1
	END IF
END IF

//Add ptsp_UpdateEquipmentTrace stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_UpdateEquipmentTrace') THEN "
	ls_sql += "CREATE PROCEDURE ptsp_UpdateEquipmentTrace(IN oldeqref varchar(15), IN neweqref varchar(15), IN eqid integer) ~n" + & 
				 "BEGIN ~n" + & 
					 "DECLARE terminalid integer; ~n" + &
					 "DECLARE originid integer; ~n" + &
					 "DECLARE equip_type char(1); ~n" + &
					 "IF (Select ss_string FROM system_settings Where ss_id = 220) = 'YES!' THEN ~n" + &
					 	  "/*Remove old eqref*/ ~n" + &
						  "IF ptfn_ExistsEquipmentTrace(oldeqref) = 1 THEN ~n" + & 
								"INSERT INTO equipmenttrace_deletebuffer(eqref) VALUES(oldeqref); ~n" + & 
						  "END IF; ~n" + &
						  "IF ptfn_ExistsTerminalTrace(oldeqref) = 1 THEN ~n" + & 
								"INSERT INTO terminaltrace_deletebuffer(eq_ref) VALUES(oldeqref); ~n" + & 
						  "END IF; ~n" + &
						  "/*Add new eqref*/ ~n" + &
						  "SET equip_type = (SELECT eq_type FROM equipment WHERE eq_id = eqid); ~n" + &
					 	  "IF LOCATE((Select ss_string FROM system_settings Where ss_id = 221),equip_type, 1) > 0 THEN ~n" + &
							  "SET originid = (SELECT ds_origin_id FROM disp_ship WHERE ds_id = (SELECT Shipment FROM outside_equip WHERE oe_id = eqid)); ~n" + &           
							  "SET terminalid = ptfn_GetTerminalId(originid); ~n" + &
							  "IF terminalid > 0 THEN ~n" + &
									"IF NOT EXISTS (SELECT eq_ref, terminalsite FROM DBA.terminaltrace_pending WHERE eq_ref = neweqref AND terminalsite = terminalid) THEN ~n" + &
										 "INSERT INTO terminaltrace_pending(eq_ref, terminalsite) VALUES(neweqref, terminalid); ~n" + &
									"ELSE ~n" + &
										 "DELETE FROM DBA.terminaltrace_deletebuffer WHERE eq_ref = neweqref AND terminalid = terminalid; ~n" + &
									"END IF; ~n" + & 
							  "ELSE ~n" + &
								  "IF NOT EXISTS (SELECT eqref FROM DBA.equipmenttrace_pending WHERE eqref = neweqref) THEN ~n" + &									 
										"INSERT INTO equipmenttrace_pending(eqref) VALUES(neweqref); ~n" + &
								  "ELSE ~n" + &
										"DELETE FROM DBA.equipmenttrace_deletebuffer WHERE eqref = neweqref; ~n" + &
								  "END IF; ~n" + &
							  "END IF; ~n" + &
					 	 "END IF; ~n" + &
					 "END IF; ~n" + & 
				 "END; ~n" + &
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create ptsp_UpdateEquipmentTrace."
		li_Return = -1
	END IF
END IF

//Add ptsp_UpdateEquipmentTraceOrigin stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_UpdateEquipmentTraceOrigin') THEN "
	ls_sql += "CREATE PROCEDURE ptsp_UpdateEquipmentTraceOrigin(IN oldoriginid integer, IN neworiginid integer, IN eqid integer) ~n" + &
				 "BEGIN ~n" + & 
					 "DECLARE equip_ref varchar(15); ~n" + &
					 "DECLARE newterminalid integer; ~n" + &
					 "DECLARE oldterminalid integer; ~n" + &
					 "DECLARE equip_type char(1); ~n" + &
					 "IF (Select ss_string FROM system_settings Where ss_id = 220) = 'YES!' THEN ~n" + &
					 	  "SET equip_type = (SELECT eq_type FROM equipment WHERE eq_id = eqid); ~n" + &
						  "SET equip_ref = (SELECT eq_ref FROM equipment WHERE eq_id = eqid); ~n" + &
						  "SET newterminalid = ptfn_GetTerminalId(neworiginid); ~n" + &
						  "IF newterminalid > 0 THEN ~n" + &
								"IF ptfn_ExistsEquipmentTrace(equip_ref) = 1 THEN ~n" + &
									 "INSERT INTO equipmenttrace_deletebuffer(eqref) VALUES(equip_ref); ~n" + &
								"END IF; ~n" + &
								"IF ptfn_ExistsTerminalTrace(equip_ref) = 1 THEN ~n" + & 
									 "SET oldterminalid = ptfn_GetTerminalId(oldoriginid); ~n" + &
									 "INSERT INTO terminaltrace_deletebuffer(eq_ref, terminalid) VALUES(equip_ref, oldterminalid); ~n" + & 
								"END IF; ~n" + &
								"IF LOCATE((Select ss_string FROM system_settings Where ss_id = 221),equip_type, 1) > 0 THEN ~n" + &
									"IF NOT EXISTS (SELECT eq_ref, terminalsite FROM DBA.terminaltrace_pending WHERE eq_ref = equip_ref AND terminalsite = newterminalid) THEN ~n" + &
										 "INSERT INTO DBA.terminaltrace_pending(eq_ref, terminalsite) VALUES(equip_ref, newterminalid); ~n" + &
									"ELSE ~n" + &
										 "DELETE FROM DBA.terminaltrace_deletebuffer WHERE eq_ref = equip_ref AND terminalid = newterminalid; ~n" + &
									"END IF; ~n" + &
								"END IF; ~n" + &
						  "ELSE ~n" + &
								"IF ptfn_ExistsTerminalTrace(equip_ref) = 1 THEN ~n" + & 
									 "INSERT INTO terminaltrace_deletebuffer(eq_ref) VALUES(equip_ref); ~n" + & 
								"END IF; ~n" + &
								"IF LOCATE((Select ss_string FROM system_settings Where ss_id = 221),equip_type, 1) > 0 THEN ~n" + &
									"IF ptfn_ExistsEquipmentTrace(equip_ref) <> 1 THEN ~n" + &
										 "INSERT INTO DBA.equipmenttrace_pending(eqref) VALUES(equip_ref); ~n" + &
									"ELSE ~n" + &
										"DELETE FROM DBA.equipmenttrace_deletebuffer WHERE eqref = equip_ref; ~n" + &
									"END IF; ~n" + &
								"END IF; ~n" + &
						  "END IF; ~n" + &
					 "END IF; ~n" + & 
				 "END; ~n" + &
				 "END IF"
				 
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create ptsp_UpdateEquipmentTraceOrigin."
		li_Return = -1
	END IF
END IF

//Add ptsp_DynamicShipmentUpdate stored procedure
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_DynamicShipmentUpdate') THEN "
	ls_sql += "CREATE PROCEDURE ptsp_DynamicShipmentUpdate(IN setcol long varchar, IN setval long varchar, IN eqref varchar(15)) ~n" + &
				 "BEGIN ~n" + &
				 "DECLARE ls_sql LONG VARCHAR; ~n" + &
				 "DECLARE colby LONG VARCHAR; ~n" + &
				 "DECLARE coluser LONG VARCHAR; ~n" + &
				 "DECLARE overwrite INTEGER; ~n" + &
				 "SET overwrite = 1 ; ~n" + &
				 "IF setcol = 'arrivaldate' OR setcol = 'arrivaltime' THEN ~n" + &
					"SET colby = 'arrivedby'; ~n" + &
					"SET coluser = 'arriveduser'; ~n" + &
				 "ELSEIF setcol = 'groundeddate' OR setcol = 'groundedtime' THEN ~n" + &
					"SET colby = 'groundedby'; ~n" + &
					"SET coluser = 'groundeduser'; ~n" + &
				 "ELSEIF setcol = 'releasedate' OR setcol = 'releasetime' THEN ~n" + &
					"SET colby = 'releaseby'; ~n" + &
					"SET coluser = 'releaseuser'; ~n" + &
				 "ELSEIF setcol = 'etadate' OR setcol = 'etatime' THEN ~n" + &
					"SET colby = 'etaby'; ~n" + &
					"SET coluser = 'etauser'; ~n" + &
				 "ELSEIF setcol = 'LastFreeDate' OR setcol = 'LastFreeTime' THEN ~n" + &
					"SET colby = 'lfdby'; ~n" + &
					"SET coluser = 'lfduser'; ~n" + &
				 "ELSEIF setcol = 'pickupnumber' THEN ~n" + &
					"SET colby = 'pickupnumberby'; ~n" + &
					"SET coluser = 'pickupnumberuser'; ~n" + &
					"SET overwrite = 0; ~n" + &
				 "END IF; ~n" + &
				 "/*Escape all single quotes*/ ~n" + &
				 "SET setval = (SELECT Replace(setval, '''', '''''')); ~n" + &
				 "SET ls_sql = 'UPDATE disp_ship SET ' || setcol || ' = ''' || setval || ''''; ~n" + &
				 "IF colby IS NOT NULL THEN ~n" + &
				 	"IF colby NOT IN (SELECT ptcol FROM railtracecolumnmapping) AND colby NOT IN (SELECT ptcol FROM terminaltracecolumnmapping) THEN ~n" + & 
				 		"SET ls_sql = ls_sql || ', ' || colby || ' = ''TTAPP'''; ~n" + &
					"END IF; ~n" + &
				 "END IF; ~n" + &
				 "IF coluser IS NOT NULL THEN ~n" + &
				 	"IF coluser NOT IN (SELECT ptcol FROM railtracecolumnmapping) AND coluser NOT IN (SELECT ptcol FROM terminaltracecolumnmapping) THEN ~n" + &
				 		"SET ls_sql = ls_sql || ', ' || coluser || ' = ''TTAPP'''; ~n" + &
					"END IF; ~n" + &
				 "END IF; ~n" + &
				 "SET ls_sql = ls_sql || ' WHERE ds_id = (SELECT Shipment FROM outside_equip WHERE oe_id = (SELECT MAX(eq_id) FROM equipment WHERE eq_ref = ''' || eqref || ''' AND eq_status = ''K''))'; ~n" + &
				 "IF overwrite = 0 THEN ~n" + &
				 	"SET ls_sql = ls_sql || ' AND ' || setcol || ' IS NULL'; ~n" + &
				 "END IF; ~n" + &
				 "EXECUTE IMMEDIATE WITH ESCAPES OFF ls_sql; ~n" + &
				"END; ~n" + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create ptsp_DynamicShipmentUpdate."
		li_Return = -1
	END IF
	
END IF

//Add ptsp_railtraceupdate stored procedure
//temp table is used becuase Execute Immediate does not support result sets ~n" + &
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_RailTraceUpdate') THEN "
	ls_sql += "CREATE PROCEDURE ptsp_RailTraceUpdate() ~n" + &
				 "BEGIN ~n" + &
				 	 "DECLARE err_notfound EXCEPTION FOR SQLSTATE '02000'; ~n" + &
					 "DECLARE now datetime; ~n" + & 
					 "DECLARE ptcolumn long varchar; ~n" + & 
					 "DECLARE rtcolumn long varchar; ~n" + & 
					 "DECLARE rtvalue long varchar; ~n" + &
					 "DECLARE equipid integer; ~n" + &
					 "DECLARE defer integer; ~n" + &
					 "DECLARE LOCAL TEMPORARY TABLE temptable (tempvalue long varchar) ON COMMIT PRESERVE ROWS; ~n" + & 
					 "DECLARE eqcursor CURSOR FOR SELECT ptcol, rtcol FROM railtracecolumnmapping; ~n" + & 
					 "SET now = (Select Now(*)); ~n" + & 
					 "FOR forloop AS rt_curs CURSOR FOR SELECT eqref AS eqref_rt, timestampvalue AS timestamp_rt FROM equipmenttrace WHERE timestamp_rt > (Select ss_string FROM system_settings WHERE ss_id = 222) OR eqref_rt IN (SELECT eqref FROM equipmenttrace_deferred) ~n" + &
					 "DO ~n" + & 
						  "SET defer = 0; ~n" + &
						  "IF eqref_rt NOT IN (SELECT eq_ref FROM equipment WHERE eq_id IN (SELECT oe_id FROM outside_equip WHERE shipment IN (SELECT shipid FROM openshipments ) ) ) THEN ~n" + & 
								"OPEN eqcursor; ~n" + &  
								"CursorLoop: LOOP FETCH NEXT eqcursor INTO ptcolumn, rtcolumn; ~n" + & 
									 "IF SQLSTATE = err_notfound THEN ~n" + & 
										  "LEAVE CursorLoop; ~n" + & 
									 "END IF; ~n" + &
									 "/*temp table used because execute immediate does not support result sets*/ ~n" + & 
									 "EXECUTE IMMEDIATE WITH ESCAPES OFF 'INSERT INTO temptable SELECT FIRST ' || rtcolumn || ' FROM equipmenttrace WHERE eqref = ''' || eqref_rt || ''''; ~n" + & 
									 "SET rtvalue = (SELECT FIRST tempvalue FROM temptable); ~n" + & 
									 "DELETE FROM temptable; ~n" + & 
									 "IF rtvalue IS NOT NULL THEN ~n" + & 
										  "CALL ptsp_DynamicShipmentUpdate(ptcolumn, rtvalue, eqref_rt) ; ~n" + & 
									 "END IF; ~n" + & 
								"END LOOP CursorLoop; ~n" + & 
								"CLOSE eqcursor; ~n" + & 
								"IF SQLCODE <> -1 THEN ~n" + &
									 "COMMIT; ~n" + &
									 "IF SQLCODE = -1 THEN /*Check if commit failed*/ ~n" + &
										  "SET defer = 1; ~n" + &
										  "ROLLBACK; ~n" + &
									 "END IF; ~n" + &
								"ELSE ~n" + &
									 "SET defer = 1; ~n" + &
									 "ROLLBACK; ~n" + &
								"END IF; ~n" + &
						  "ELSE ~n" + & 
								"SET defer = 1; ~n" + &
						  "END IF; ~n" + &
						  "IF defer = 1 THEN ~n" + &
								"SET equipid = (SELECT MAX(eq_id) FROM equipment WHERE eq_ref = eqref_rt AND eq_status = 'K'); ~n" + & 
								"IF equipid > 0 THEN ~n" + & 
									 "INSERT INTO equipmenttrace_deferred (eqid, eqref) ON EXISTING SKIP VALUES(equipid, eqref_rt); ~n" + & 
									 "IF SQLCODE <> -1 THEN ~n" + &
										  "COMMIT; ~n" + &
										  "IF SQLCODE = -1 THEN /*Check if commit failed*/ ~n" + &                   
												"ROLLBACK; ~n" + &
										  "END IF; ~n" + &
									 "ELSE ~n" + &                  
										  "ROLLBACK; ~n" + &
									 "END IF; ~n" + &
								"END IF; ~n" + & 
						  "ELSE ~n" + &
								"DELETE FROM equipmenttrace_deferred WHERE eqref = eqref_rt; ~n" + &
								"IF SQLCODE <> -1 THEN ~n" + &
									 "COMMIT; ~n" + &
									 "IF SQLCODE = -1 THEN /*Check if commit failed*/ ~n" + &                   
										  "ROLLBACK; ~n" + &
									 "END IF; ~n" + &
								"ELSE ~n" + &               
									 "ROLLBACK; ~n" + &
								"END IF; ~n" + &
						  "END IF; ~n" + &    
					 "END FOR; ~n" + &
					 "UPDATE system_settings SET ss_string = now WHERE ss_id = 222; ~n" + & 
					 "IF SQLCODE <> -1 THEN ~n" + &
						  "COMMIT; ~n" + &
						  "IF SQLCODE = -1 THEN /*Check if commit failed*/ ~n" + &                   
								"ROLLBACK; ~n" + &
						  "END IF; ~n" + &
					 "ELSE ~n" + &               
						  "ROLLBACK; ~n" + &
					 "END IF; ~n" + &
				"END; ~n" + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create ptsp_railtraceupdate."
		li_Return = -1
	END IF
	
END IF

//Add ptsp_terminaltraceupdate stored procedure
//temp table is used becuase Execute Immediate does not support result sets ~n" + &
IF li_Return = 1 THEN
	ls_sql = "IF NOT EXISTS (SELECT 1 FROM sysprocedure WHERE proc_name = 'ptsp_TerminalTraceUpdate') THEN "
	ls_sql += "CREATE PROCEDURE ptsp_TerminalTraceUpdate() ~n" + &
				 "BEGIN ~n" + &
				 	 "DECLARE err_notfound EXCEPTION FOR SQLSTATE '02000'; ~n" + &
					 "DECLARE now datetime; ~n" + & 
					 "DECLARE ptcolumn long varchar; ~n" + & 
					 "DECLARE ttcolumn long varchar; ~n" + & 
					 "DECLARE ttvalue long varchar; ~n" + & 
					 "DECLARE equipid integer; ~n" + &
					 "DECLARE defer integer; ~n" + & 
					 "DECLARE LOCAL TEMPORARY TABLE temptable (tempvalue long varchar) ON COMMIT PRESERVE ROWS; ~n" + & 
					 "DECLARE eqcursor CURSOR FOR SELECT ptcol, ttcol FROM terminaltracecolumnmapping; ~n" + & 
					 "SET now = (Select Now(*)); ~n" + & 
					 "FOR forloop AS tt_curs CURSOR FOR SELECT eq_ref AS eqref_tt, timestampvalue AS timestamp_tt FROM terminaltrace WHERE timestamp_tt > (Select ss_string FROM system_settings WHERE ss_id = 223) OR eqref_tt IN (SELECT eqref FROM equipmenttrace_deferred) ~n" + & 
					 "DO ~n" + & 
						  "SET defer = 0; ~n" + &
						  "IF eqref_tt NOT IN (SELECT eq_ref FROM equipment WHERE eq_id IN (SELECT oe_id FROM outside_equip WHERE shipment IN (SELECT shipid FROM openshipments ) ) ) THEN ~n" + & 
								"OPEN eqcursor; ~n" + & 
								"CursorLoop: LOOP FETCH NEXT eqcursor INTO ptcolumn, ttcolumn; ~n" + & 
									"IF SQLSTATE = err_notfound THEN ~n" + & 
										 "LEAVE CursorLoop; ~n" + & 
									"END IF; ~n" + &
									"/*temp table used because execute immediate does not support result sets*/ ~n" + & 
									"EXECUTE IMMEDIATE WITH ESCAPES OFF 'INSERT INTO temptable SELECT FIRST ' || ttcolumn || ' FROM terminaltrace WHERE eq_ref = ''' || eqref_tt || ''''; ~n" + & 
									"SET ttvalue = (SELECT FIRST tempvalue FROM temptable); ~n" + & 
									"DELETE FROM temptable; ~n" + & 
									"IF ttvalue IS NOT NULL THEN ~n" + & 
										 "CALL ptsp_DynamicShipmentUpdate(ptcolumn, ttvalue, eqref_tt) ; ~n" + & 
									"END IF; ~n" + & 
								"END LOOP CursorLoop; ~n" + & 
								"CLOSE eqcursor; ~n" + &
								"IF SQLCODE <> -1 THEN ~n" + &
									 "COMMIT; ~n" + &
									 "IF SQLCODE = -1 THEN /*Check if commit failed*/ ~n" + &
										  "SET defer = 1; ~n" + &
										  "ROLLBACK; ~n" + &
									 "END IF; ~n" + &
								"ELSE ~n" + &
									 "SET defer = 1; ~n" + &
									 "ROLLBACK; ~n" + &
								"END IF; ~n" + & 
						  "ELSE ~n" + &
								"SET defer = 1; ~n" + & 
						  "END IF; ~n" + &
						  "IF defer = 1 THEN ~n" + &
								"SET equipid = (SELECT MAX(eq_id) FROM equipment WHERE eq_ref = eqref_tt AND eq_status = 'K'); ~n" + & 
								"IF equipid > 0 THEN ~n" + & 
									 "INSERT INTO equipmenttrace_deferred (eqid, eqref) ON EXISTING SKIP VALUES(equipid, eqref_tt); ~n" + &
									 "IF SQLCODE <> -1 THEN ~n" + &
										  "COMMIT; ~n" + &
										  "IF SQLCODE = -1 THEN /*Check if commit failed*/ ~n" + &                   
												"ROLLBACK; ~n" + &
										  "END IF; ~n" + &
									 "ELSE ~n" + &                  
										  "ROLLBACK; ~n" + &
									 "END IF; ~n" + & 
								"END IF; ~n" + & 
						  "ELSE ~n" + &
								"DELETE FROM equipmenttrace_deferred WHERE eqref = eqref_tt; ~n" + &
								"IF SQLCODE <> -1 THEN ~n" + &
									"COMMIT; ~n" + &
									"IF SQLCODE = -1 THEN /*Check if commit failed*/ ~n" + &                   
										 "ROLLBACK; ~n" + &
									"END IF; ~n" + &
							  "ELSE ~n" + &               
									"ROLLBACK; ~n" + &
							  "END IF; ~n" + & 
						  "END IF; ~n" + &
					 "END FOR; ~n" + &
					 "UPDATE system_settings SET ss_string = now WHERE ss_id = 223; ~n" + &
					 "IF SQLCODE <> -1 THEN ~n" + &
						  "COMMIT; ~n" + &
						  "IF SQLCODE = -1 THEN /*Check if commit failed*/ ~n" + &                   
								"ROLLBACK; ~n" + &
						  "END IF; ~n" + &
					 "ELSE ~n" + &               
						  "ROLLBACK; ~n" + &
					 "END IF; ~n" + & 
				"END; ~n" + &
				"END IF"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create ptsp_terminaltraceupdate."
		li_Return = -1
	END IF
	
END IF


//Insert System Setting for last railtrace update timestamp
IF li_Return = 1 THEN
	ls_Sql = "IF NOT EXISTS (SELECT ss_string FROM system_settings WHERE ss_id = 222) THEN ~n" + &
				 "INSERT INTO system_settings (ss_id, ss_string) VALUES(222, (Select Now(*))); ~n" + &
				 "END IF;"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create 'railtrace timestamp' system setting."
		li_Return = -1
	END IF
	
END IF

//Insert System Setting for last terminaltrace update timestamp
IF li_Return = 1 THEN
	ls_Sql = "IF NOT EXISTS (SELECT ss_string FROM system_settings WHERE ss_id = 223) THEN ~n" + &
				 "INSERT INTO system_settings (ss_id, ss_string) VALUES(223, (Select Now(*))); ~n" + &
				 "END IF;"
	
	Execute Immediate :ls_Sql;
	
	IF sqlca.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create 'terminaltrace timestamp' system setting."
		li_Return = -1
	END IF
	
END IF

//Set pt system setting 'Activate RailTrace' (outbound)
IF li_Return = 1 THEN
	ls_Sql = "IF NOT EXISTS (SELECT ss_string FROM system_settings WHERE ss_id = 220) THEN ~n" + &
				 "INSERT INTO system_settings (ss_id, ss_string) VALUES(220, 'NO!'); ~n" + &
				 "END IF;"
	
	Execute Immediate :ls_Sql;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create 'Activate RailTrace outbound' system setting."
		li_Return = -1
	END IF
	
END IF

//Set rt system setting 'Activate RailTrace'  (Inbound)
IF li_Return = 1 THEN
	ls_Sql = "IF NOT EXISTS (SELECT ss_string FROM rt_system_settings WHERE ss_id = 1) THEN ~n" + &
				 "INSERT INTO rt_system_settings (ss_id, ss_string) VALUES(1, 'NO!'); ~n" + &
				 "END IF;"
	
	Execute Immediate :ls_Sql USING SQLCA;
	
	IF SQLCA.sqlcode <> 0 THEN
		ls_ErrMsg = SQLCA.sqlerrtext + " ~n ~nCould not create 'Activate RailTrace inbound' system setting."
		li_Return = -1
	END IF
	
END IF


IF li_Return = 1 THEN
	commit;
ELSE
	rollback;
	This.of_AddError(ls_ErrMsg)
END IF

Return li_Return
end function

public function integer of_addequipmenttrace (long al_eqid);Return This.of_AddEquipmentTrace({al_eqid})
end function

public function integer of_addequipmenttrace (long ala_eqids[]);Integer	li_Return = 1
Long		ll_EqCount
Long		i

ll_EqCount = UpperBound(ala_EqIds)

FOR i = 1 TO ll_EqCount
	
	IF SQLCA.of_AddEquipmentTrace(ala_EqIds[i]) <> 1 THEN
		li_Return = -1
		EXIT
	END IF
	
NEXT


Return li_Return
end function

public function integer of_getptmapcolumns (ref string asa_columnlist[]);asa_ColumnList = isa_PtColumnList

Return 1


end function

private function integer of_setcolumnremarks (string as_tablename, string asa_columnnames[], string asa_columnremarks[]);/**************************************************************************************
NAME: 	of_SetColumnRemarks

ACCESS:	Private
		
ARGUMENTS: 	(string as_tableName, string asa_columnNames[], string asa_columnRemarks[])

RETURNS:		Integer
	
DESCRIPTION:
			Sets Remarks (AKA comments) on the columns of a given table.
			
			Return 1 -> Success
			Return -1 -> Faliure to set comment on one or more columns
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 1/26/07
***************************************************************************************/

//Obsolete - not used

Integer	li_Return = 1
//Long		i
//Long		ll_NameCount
//Long		ll_RemarkCount
//String	ls_Sql
//
//ll_NameCount = UpperBound(asa_ColumnNames)
//ll_RemarkCount = Upperbound(asa_ColumnRemarks)
//
//IF ll_NameCount <> ll_RemarkCount THEN
//	li_Return = -1 //must be parallel arrays 
//END IF
//
//IF li_Return = 1 THEN
//	
//	FOR i = 1 TO ll_NameCount
//		ls_Sql = "COMMENT ON COLUMN " + as_TableName + "." + asa_ColumnNames[i] + " IS '" + asa_ColumnRemarks[i] + "'"
//		Execute Immediate :ls_Sql;
//		IF sqlca.sqlcode <> 0 THEN
//			li_Return = -1
//		END IF
//	NEXT
//	
//END IF
//
Return li_Return
end function

public function integer of_getterminalcolumndisplayvalues (ref string asa_columns[], ref string asa_displayvalues[]);asa_Columns = isa_TerminalColumnList
asa_DisplayValues = isa_TerminalDisplayList

Return 1
end function

public function integer of_getrailcolumndisplayvalues (ref string asa_columns[], ref string asa_displayvalues[]);asa_Columns = isa_RailColumnList
asa_DisplayValues = isa_RailDisplaylist

Return 1
end function

public function integer of_getrailtraceapplicationfolder (ref string as_path);Integer	li_Return = 1
String	ls_Path

IF RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Profit Tools RailTrace", "AppPath", RegString!, ls_Path) = 1 THEN
	as_Path = ls_Path
ELSE
	li_Return = -1
END IF

Return li_Return
end function

public function integer of_setuprailtrace (boolean ab_drop);Integer	li_Return = 1

SetPointer(HourGlass!)


//PT Setup ----------------------------------

//Drop old PT configs
IF li_Return = 1 THEN
	IF ab_Drop THEN
		IF This.of_DropAll() <> 1 THEN
				li_Return = -1 
		END IF
	END IF
END IF


IF li_Return = 1 THEN
	IF This.of_InitializeDB() <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF This.of_CreateTriggers() <> 1 THEN
		li_Return = -1
	END IF
END IF


//RT Setup---------------------------------------

//Drop old RT configs
IF li_Return = 1 THEN
	IF ab_Drop THEN
		IF This.of_DropAllRailTrace() <> 1 THEN     //here we connect to rt db
			li_Return = -1
		END IF
	END IF
END IF

IF li_Return = 1 THEN
	IF This.of_InitializeRailTraceDB() <> 1 THEN
		li_Return = -1
	END IF
END IF

//If we are not successful, back it out
IF li_Return = -1 THEN
	This.of_UndoSetup()
END IF


SetPointer(Arrow!)

Return li_Return
end function

on n_cst_ptrailtracemanager.create
call super::create
end on

on n_cst_ptrailtracemanager.destroy
call super::destroy
end on

event constructor;call super::constructor;String	ls_RtVersionExpected

SQLCA2 = Create n_tr_RailTrace

ls_RtVersionExpected = "1.2.0"

of_SetRtVersionExpected(ls_RtVersionExpected)
end event

event destructor;call super::destructor;Destroy(SQLCA2)
end event

