$PBExportHeader$app_trucking.sra
$PBExportComments$Trucking (Application from PBL map PTApp) //@(*)[8916340|47]<nosync>
forward
global n_tr_trucking sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global n_err error
global n_msg message
end forward

global variables
//begin add by appeon  20070727
n_cst_constant n_cst_constants
Boolean		sb_Ready
DataStore	sds_Cache
String		ssa_DefinedModules[]
Integer		si_DefinedModuleCount
Boolean		sb_PCMilerStreets
integer		si_pcmilerserverid
Integer	si_UserClass
Long	sl_EmployeeId
String	ss_ShipmentSummary_ViewTotalCharges
//end add by appeon 20070727
//@(-)[Generated global variables - Do not edit]
n_cst_appmanager_trucking gnv_app
n_cst_bcmmgr gnv_bcmmgr
//@(-)--

//Add your global variables after this line

integer g_tempint, g_max_h, g_max_w, &
	start_time = 0, pcms_id, null_int
long null_long, g_temp_long
string g_tempstr, g_tempstr2, null_str
char g_max_permit, g_tempchar, null_char
boolean pcms_inst, pcmm_inst, pcms_on
date null_date
time null_time
datetime g_emp_refresh, g_emp_update, null_datetime
decimal null_dec
datastore gds_emp, gds_shiptype, null_ds
datastore gds_pcmiles, gds_privs
datawindow null_dw
s_longs blank_longs
s_class_info g_privs
s_list_settings gstr_list_settings
n_cst_companies gnv_cst_companies
integer gi_childwin
//begin modification Shared Variables by appeon  20070730
n_ds	sds_Source //n_cst_invoice_psr_manifest ptbillnv.pbl
n_ds 	sds_equip  //n_cst_equipmentmanager  ptequip.pbl
n_ds 	sds_ship, &
	sds_trip      //n_cst_shipmentmanager ptcorenv.pbl
	
	
n_ds		ids_defaultDivsCache //n_cst_ship_type ptcorenv.pbl
DataStore	sds_CustomCache   //n_cst_presentation ptcorenv.pbl
n_ds 	sds_employee    //n_cst_employeemanager ptcoreenv.pbl
n_ds	sds_deviceCache  //n_cst_bso_communication_manager ptmblcom.pbl
n_ds	sds_commequipidcache  //n_cst_bso_communication_manager ptmblcom.pbl
datastore  sds_Destination  //n_cst_bso_communication_manager ptmblcom.pbl
n_ds 	sds_selectedRows      //n_cst_rate_attribs ptdispnv.pbl
n_ds		sds_rate, &
		sds_rateDefaults, &
		sds_ratenames           //n_cst_bso_rating ptrating.pbl
n_cst_bso_zonemanager	snv_ZoneManager  //n_cst_bso_rating ptrating.pbl
n_cst_routing snv_routing   //n_cst_trip  ptroute.pbl
n_cst_pegasus_print	snv_print  //n_cst_invoice ptbillnv.pbl
n_Cst_Msg				snv_PrintSetupMsg  //n_cst_invoice ptbillnv.pbl
n_cst_Settings snv_Settings  // n_cst_syssettings ptprprty.pbl
n_cst_dwsrv_property 	snv_property  // pfc_u_dw pfcmain.pbl
//end modification Shared Variables by appeon  20070730

//begin modification Shared Variables by appeon  20070731
n_cst_bcmmgr snv_bcmmgr   //ofr_n_cst_base how_srv.pbl
//end modification Shared Variables by appeon  20070731

//begin add by appeon 
//invoke constant form n_cst_appeon_constant 20070731
n_cst_appeon_constant appeon_constant
gc_dispatch_appeon gc_dispatch
gc_logs_appeon gc_logs
//end add by appeon 

//begin modification Shared Variables by appeon  20070801
String	ss_ShipmentSyntax, &
	ss_EventSyntax, &
	ss_ItemSyntax

boolean 	sb_ships_retrieved, &
	sb_trips_retrieved
string	ss_ships_last_change
integer	si_ships_filter
datetime	sdt_ships_refreshed, &
	sdt_ships_updated, &
	sdt_LastShipmentCacheWrite, &
	sdt_trips_refreshed, &
	sdt_trips_updated
long	sl_counter = 0

//Contains the full file name & path for the (current) cache file.
//Initialized to null in constructor.
String	ss_ShipmentCacheFile

//In 3.5.15, capability was added to define multiple cache
//file codes, with restricted retrievals.  If this is in effect, the
//code and retrieval restriction will be listed in these variables.
//ss_ShipmentCacheWhereClauseExtension is initialized to null in constructor.
String	ss_ShipmentCacheCode = "Default"
String	ss_ShipmentCacheWhereClauseExtension

Long sla_TotalEventIds[]
Long sl_totaleventidsCtr
//end modification Shared Variables by appeon  20070801

end variables

global type app_trucking from application
 end type
global app_trucking app_trucking

type prototypes
//SUBROUTINE IX_Unlock ( long pw1, long pw2, long pw3, long pw4) &
//	LIBRARY"imagxpr4.dll"  ALIAS FOR "PS_UnLock"

//SUBROUTINE PP_Unlock ( long pw1, long pw2, long pw3, long pw4) &
//	LIBRARY "PrntPRO1.ocx" ALIAS FOR "PS_UnLock"

FUNCTION int  ScrollBar_SetPos ( long al_handle , int al_pos , BOOLEAN ab_redraw ) &
	LIBRARY "kernel32.dll"
//Created By Maury For getting and setting window positioning information
FUNCTION int  GetWindowPlacement ( long al_handle , ref s_windowplacement astr_wp ) &
	LIBRARY "user32.dll" alias for "GetWindowPlacement;Ansi"
	
FUNCTION int  SetWindowPlacement ( long al_handle, ref s_windowplacement astr_wp ) &
	LIBRARY "user32.dll" alias for "SetWindowPlacement;Ansi"
end prototypes

on app_trucking.create
appname = "app_trucking"
message = create n_msg
sqlca = create n_tr_trucking
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create n_err
end on

on app_trucking.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

event close;//@(text)(recreate=yes)<Body>
gnv_app.Event pfc_Close()
destroy gnv_bcmmgr  // switched the following two destroys
DESTROY gnv_app  
//@(text)--

end event

event connectionbegin;//@(text)(recreate=yes)<Body>
ConnectPrivilege  lcp_privilege
lcp_privilege = gnv_app.Event pfc_ConnectionBegin(userid, password, connectstring)
Return lcp_privilege
//@(text)--

end event

event connectionend;//@(text)(recreate=yes)<Body>
gnv_app.Event pfc_ConnectionEnd()
//@(text)--

end event

event idle;//@(text)(recreate=yes)<Body>
gnv_app.Event pfc_Idle()
//@(text)--

end event

event systemerror;//@(text)(recreate=yes)<Body>
gnv_app.Event pfc_SystemError()
//@(text)--

end event

event open;//@(text)(recreate=yes)<Body>
gnv_bcmmgr = create n_cst_bcmmgr
gnv_app = CREATE n_cst_appmanager_trucking
gnv_app.Event pfc_Open(commandline)
toolbartips=true
//@(text)--

end event

