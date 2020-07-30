$PBExportHeader$n_cst_appeon_constant_full.sru
forward
global type n_cst_appeon_constant_full from nonvisualobject
end type
end forward

global type n_cst_appeon_constant_full from nonvisualobject autoinstantiate
end type

type variables
//ptcore.pbl(n_cst_appmanager_trucking)
Constant String cs_User_PTADMIN = "PTADMIN"
 
//ptcore.pbl(n_cst_privsmanager)
//constant string cs_Admin = "Admin"
//constant string cs_Audit = "Audit"
//constant string cs_lookup = "Lookup"
//constant string cs_Entry = "Entry"
Constant Long cl_Admin = 1005
Constant Long cl_Audit = 1004
Constant Long cl_Entry = 1003
Constant Long cl_Lookup = 1002
Constant Long cl_None = 1001
Constant String cs_AllModules = "All"
Constant Long  cl_AllDivisions = 1//2203
Constant String cs_Collection = "n_cst_privdetails_collection"
Constant INT ci_true = 1
Constant Int ci_false = 0
Constant Int ci_error = -1
Constant Int ci_undefinedFunction = -2
//Function Constants
constant string cs_ModifyRateTable = "Modify Rate Table"
CONSTANT STRING  cs_DeleteImage = "Delete Image"
CONSTANT STRING  cs_ModifyImage = "Modify Image"
CONSTANT STRING  cs_SCANImage = "Scan Image"
CONSTANT STRING cs_ModifyShipment = "ModifyShipment"
CONSTANT STRING cs_viewCharges ="View Charges"
CONSTANT STRING cs_ModifyBilledShip = "Modify Billed Shipments"     //added 2-7-07
CONSTANT STRING cs_ModifyBilledShipRates = "Modify Billed Shipment Rates" //added 2-7-07
CONSTANT STRING cs_BillShipment = "Bill Shipment"
CONSTANT STRING cs_ViewBilling = "View Billing Window"
CONSTANT STRING cs_ModifyGlobalPayable = "Modify Global Templates"
CONSTANT STRING cs_ModifyEmployeePayable = "Modify Employee Payables"
CONSTANT STRING cs_SettleDrivers = "Settle Drivers"
CONSTANT STRING cs_ModifyDriverLog = "Modify Driver Log"
CONSTANT STRING cs_ViewLogReports = "View Log Reports"
CONSTANT STRING   cs_ViewEmployee = "View Employee"
CONSTANT STRING cs_ModifyEmployee = "Modify Employee"
 
//ptcore.pbl(u_cst_privs)
constant string ics_allDivisions = "All_Divisions"
constant string ics_allModules = "All Modules"
constant string ics_user = "User"
constant string ics_priv = "priv"
constant string ics_multipleUsers = "{ MULTIPLE USERS } "
constant int  ici_multipleUserID = 1
constant string ics_multipleDivs = "{ MULTIPLE DIVISIONS }"
constant int ci_width = 550
 
//ptcore.pbl(w_userprivs)
Constant Integer ii_DefaultClass = 0
Constant Integer ii_SubClass = -1
Constant Integer ii_SuperClass = 1
Constant Integer ii_SuperSubClass = 2
constant string w_userprivs_cs_Admin = "admin.bmp"//cs_Admin = "admin.bmp"
constant string w_userprivs_cs_Audit = "audit.bmp"//cs_Audit = "audit.bmp"
constant string cs_lookup = "lookup.bmp"
constant string w_userprivs_cs_Entry = "entry.bmp"//replace cs_Entry = "entry.bmp"
constant string cs_AdminPlus = "admin+.bmp"
constant string cs_AuditPlus = "audit+.bmp"
constant string cs_lookupPlus = "lookup+.bmp"
constant string cs_EntryPlus = "entry+.bmp"
constant string cs_AdminMinus = "admin-.bmp"
constant string cs_AuditMinus = "audit-.bmp"
constant string cs_lookupMinus = "lookup-.bmp"
constant string cs_EntryMinus = "entry-.bmp"
constant string cs_AdminPM = "admin+-.bmp"
constant string cs_AuditPM = "audit+-.bmp"
constant string cs_lookupPM = "lookup+-.bmp"
constant string cs_EntryPM = "entry+-.bmp"
constant string w_userprivs_cs_ALL = "all.bmp"//replace cs_ALL = "all.bmp"
constant string cs_ALLDIVISIONS = "alldivisions.bmp"
constant string w_userprivs_cs_ALLMODULES = "allmodules.bmp"//replace cs_ALLMODULES = "allmodules.bmp"
 
//ptcorenv.pbl(n_cst_beo_event)
Constant String cs_StartSiteDelimiter = "<<"
Constant String cs_EndSiteDelimiter = ">>"
 
//ptcorenv.pbl(n_cst_beo_item)
CONSTANT String cs_Type_Freight = "L"
CONSTANT String cs_Type_Accessorial = "A"
//Constant String cs_RateType_None = "Z"
//Constant String cs_RateType_Flat = "F"
//Constant String cs_RateType_Minimum = "N"
//Constant String cs_RateType_PerMile  = "M"
//Constant String cs_RateType_PerUnit = "U"
//Constant String cs_RateType_Class = "C"
 
//ptcorenv.pbl(n_cst_beo_shipment)
CONSTANT String cs_BillingFormat_Item = "I"
CONSTANT String cs_BillingFormat_Category = "L"
CONSTANT String cs_BillingFormat_Total = "G"
CONSTANT String cs_PayableFormat_Item = "I"
CONSTANT String cs_PayableFormat_Category = "L"
CONSTANT String cs_PayableFormat_Total = "G"
CONSTANT String cs_Category_Dispatch = "T"
CONSTANT String cs_Category_Brokerage = "B"
CONSTANT String cs_Category_NonRouted = "D"
CONSTANT String cs_Action_ChangedBillto = "ChangedBillto"
CONSTANT String cs_Action_ChangedOrigin = "ChangedOrigin"
CONSTANT String cs_Action_ChangedDestination = "ChangedDestination"
CONSTANT String cs_Action_ChangedCodename = "ChangedCodename"
CONSTANT String cs_Action_ChangedShiptype = "ChangedShipType"
 
//ptcorenv.pbl(n_cst_bso_liveload)
Protected Constant String cs_IniFile = "liveload.ini"
Protected Constant String cs_StatusList = "Status"
Protected Constant String cs_BillingList = "Billing"
 
//ptcorenv.pbl(n_cst_constant)
/*
CONSTANT String cs_Module_ContactManager = "ContactManager"
CONSTANT String cs_Module_OrderEntry = "OrderEntry"
CONSTANT String cs_Module_Billing = "Billing"
CONSTANT String cs_Module_Brokerage = "Brokerage"
CONSTANT String cs_Module_Dispatch = "Dispatch"
CONSTANT String cs_Module_LogAudit = "Logs"
CONSTANT String cs_Module_PCMiler = "PCMiler"
CONSTANT String  cs_Module_PCMilerStreets = "PCMilerStreets"
CONSTANT String cs_Module_Settlements = "Settlements"
CONSTANT String cs_Module_FuelCard = "FuelCard"
CONSTANT String cs_Module_FuelTax = "FuelTax"
CONSTANT String cs_Module_Imaging = "Imaging"
CONSTANT String cs_Module_Scanning = "Scanning"
CONSTANT String cs_Module_RouteManager = "RouteManager"
CONSTANT String cs_Module_Qualcomm = "Qualcomm"
CONSTANT String cs_Module_InTouch = "InTouch"
CONSTANT String cs_Module_AtRoad = "AtRoad"
CONSTANT String cs_Module_Cadec = "Cadec"
CONSTANT String cs_Module_ClipBoard = "Clipboard"
CONSTANT String  cs_Module_DataManager = "DataManager"
CONSTANT String  cs_Module_AutoRating = "AutoRating"
CONSTANT String  cs_Module_RouteOptimizer = "RouteOptimizer"
CONSTANT String  cs_Module_Notification = "Notification"
CONSTANT String  cs_Module_EDI204 = "EDI204"
CONSTANT String  cs_Module_EDI210 = "EDI"
CONSTANT String cs_Module_EDI214 = "EDI214"
CONSTANT String  cs_Module_EDI322 = "EDI322"
CONSTANT String  cs_Module_EquipmentPosting = "EquipmentPosting"
CONSTANT String  cs_Module_Nextel = "Nextel"
CONSTANT String  cs_Module_DocumentTransfer = "DocumentTransfer"
CONSTANT String  cs_Module_RailTrace = "RailTrace"
CONSTANT Integer ci_Module_ContactManager = 1
CONSTANT Integer ci_Module_OrderEntry = 2
CONSTANT Integer ci_Module_Billing = 3
CONSTANT Integer ci_Module_Brokerage = 4
CONSTANT Integer ci_Module_Dispatch = 5
CONSTANT Integer ci_Module_LogAudit = 6
CONSTANT Integer ci_Module_PCMiler = 7
CONSTANT Integer ci_Context_Close = 1
CONSTANT Integer ci_Context_Selection = 2
CONSTANT Integer ci_Context_New = 3
CONSTANT Integer ci_Context_Save = 4
CONSTANT Integer ci_Category_Inactive = 0
CONSTANT Integer ci_Category_Payables= 1
CONSTANT Integer ci_Category_Receivables = 2
CONSTANT Integer ci_Category_Both = 3
CONSTANT Integer ci_Yes = 1
CONSTANT Integer ci_No = 0
CONSTANT Integer ci_EquipmentCategory_Drivers = 1
CONSTANT Integer ci_EquipmentCategory_PowerUnits = 2
CONSTANT Integer ci_EquipmentCategory_TrailerChassis = 3
CONSTANT Integer ci_EquipmentCategory_Containers = 4
CONSTANT Integer ci_EquipmentCategory_All = 0
Constant Integer ci_DriverCategory_Singles = 1
Constant Integer ci_DriverCategory_Teams = 2
Constant Integer ci_DriverCategory_All = 0
Constant Integer ci_TitleBarHeight = 84
Constant Integer ci_SuperSubClass = 2
Constant Integer ci_SuperClass = 1
Constant Integer ci_SubClass = -1
Constant Integer ci_DefaultClass = 0
CONSTANT String  cs_CommunicationDevice_Qualcomm = "QUALCOMM"
CONSTANT String cs_CommunicationDevice_Nextel = "NEXTEL"
CONSTANT String  cs_CommunicationDevice_Intouch = "INTOUCH"
CONSTANT String  cs_CommunicationDevice_AtRoad = "ATROAD"
CONSTANT String  cs_CommunicationDevice_Cadec = "CADEC"
CONSTANT String  cs_ClipBoard = "CLIPBOARD"
CONSTANT String  cs_ReportTopic_Shipment  = "SHIPMENT"
CONSTANT String  cs_ReportTopic_Event = "EVENT"
CONSTANT String  cs_ReportTopic_Company = "COMPANY"
CONSTANT String cs_Document_DeliveryReceipt = "Delivery Receipt"
CONSTANT String cs_Document_Invoice = "Invoice"
CONSTANT String cs_Document_Quote = "Quote"
CONSTANT String cs_Document_RateConfirmation = "Rate Confirmation"
CONSTANT Int ci_Employee_OwnerOperator = 0
CONSTANT Int ci_Employee_CompanyDriver = 1
CONSTANT Int ci_Employee_3rdParty = 2
CONSTANT Int ci_Employee_Casual = 3
CONSTANT String cs_RequestRole_None = "NONE"
CONSTANT String cs_RequestRole_Billto = "BILLTO"
CONSTANT String cs_RequestRole_any = "ANY REFERENCE"
CONSTANT String cs_ItemEventType_FrontChassisSplit = "CHASSIS PICKUP"
CONSTANT String cs_ItemEventType_BackChassisSplit = "CHASSIS RETURN"
CONSTANT String cs_ItemEventType_StopOff = "STOP OFF"
CONSTANT String cs_ItemEventType_FuelSurcharge = "FUEL SURCHARGE"
CONSTANT String cs_ItemEventType_PerDiem = "PER DIEM"
CONSTANT String cs_ItemEventType_ImportedFreight = "IMPORTED FREIGHT"
CONSTANT String cs_ItemEventType_ImportedAcc = "IMPORTED ACC"
CONSTANT String cs_ItemEventType_Imported = "IMPORTED ITEM"
CONSTANT String cs_ItemEventType_MoveAccessorial = "AUTO ADDED CHARGE"
CONSTANT String cs_ItemEventType_Bobtail = "BOBTAIL ITEM"
CONSTANT String  cs_NotificatioEvent_Orig = "ORIG"
CONSTANT String  cs_NotificatioEvent_HMP = "H,M,P"
CONSTANT String  cs_NotificatioEvent_Dest = "DEST"
CONSTANT String  cs_NotificatioEvent_DRN = "D,R,N"
CONSTANT String cs_Timer_StatusRequest = "StatusRequest"
CONSTANT String cs_Timer_Increment = "Increment"
CONSTANT String cs_Timer_Notification       = "Notification"
CONSTANT String  cs_ItemType_Freight = "L"
CONSTANT String  cs_ItemType_Accessorial = "A"
CONSTANT String  cs_ItemType_None = "N"
CONSTANT String  cs_ItemType_Freight_Description = "FREIGHT"
CONSTANT String  cs_ItemType_Accessorial_Description = "ACCESSORIAL"
CONSTANT String  cs_ItemType_None_Description = "NONE"
CONSTANT String  cs_FuelSurcharge_Bill = "B"
CONSTANT String  cs_FuelSurcharge_Pay = "P"
CONSTANT String  cs_FuelSurcharge_Both = "T"
CONSTANT String  cs_FuelSurcharge_None = "N"
CONSTANT String  cs_Surcharge_Fuel="F"
CONSTANT String  cs_AccountingType_Billable ="1"
CONSTANT String  cs_AccountingType_Payable = "2"
CONSTANT String  cs_AccountingType_Both = "3"
Constant String cs_TimeZoneCodeTable = "HWI~t0/ALK~t1/PAC~t2/MTN~t3/CTL~t4/EST~t5/ATL~t6/"
Constant Long cl_Color_Protected = 12648447
Constant String cs_Color_Protected = "12648447"
Constant Long cl_Color_NA = 12632256
Constant String cs_Color_NA = "12632256"
Constant Long cl_Color_White = 16777215
Constant String cs_Color_White = "16777215"
Constant Long cl_Color_Black = 0
Constant String cs_Color_Black = "0"
Constant Long cl_Color_Red = 255
Constant String cs_Color_Red = "255"
Constant Integer ci_ErrorLog_Urgency_Severe = 1
Constant Integer ci_ErrorLog_Urgency_Important = 3
Constant Integer ci_ErrorLog_Urgency_Low = 5
 */
//ptcorenv.pbl(n_cst_dragservice_dw)
Constant String  cs_focusIndicator_hand = "HAND"
Constant String  cs_focusIndicator_rectangle = "RECTANGLE"
Constant String  cs_focusIndicator_off = "OFF"
Constant String cs_focusIndicator_bluebar = "BB"
 
//ptcorenv.pbl(n_cst_eventconfirmationoptions)
// ROW CONSTANTS
CONSTANT STRING cs_ShipmentAuthorization = "Shipment Authorization"
CONSTANT STRING cs_TerminationEventconfirmation = "Termination Event Confirmation"
CONSTANT STRING cs_EventConfirmation = "Event Confirmation"
// COLUMN CONSTANTS
CONSTANT STRING cs_Driver = "DRIVER"
CONSTANT STRING cs_Tractor = "TRACTOR"
CONSTANT STRING cs_Chassis = "CHASSIS"
CONSTANT STRING cs_FreightCarrying = "FREIGHT"
CONSTANT int ci_RowEventConfirmation = 1
CONSTANT int ci_RowTemminationEvent = 2
CONSTANT int ci_RowShipmentAuthorization = 3
CONSTANT int ci_ColumnDriver = 1
CONSTANT int ci_ColumnTractor = 2
CONSTANT int ci_ColumnFreightCarrying = 3
CONSTANT int ci_ColumnChassis = 4
 
//ptcorenv.pbl(n_cst_eventmanager)
CONSTANT Int ci_Processed = 1
CONSTANT Int ci_NotProcessed = 0
CONSTANT int ci_Result_Error = -1
CONSTANT int ci_Result_Success = 1
CONSTANT int ci_Result_SuccessNotComplete = 0
 
//ptcorenv.pbl(n_cst_eventtask)
CONSTANT int eventtask_ci_Result_Error = -1// ci_Result_Error = n_cst_eventmanager.ci_Result_Error
CONSTANT int eventtaskci_Result_Success = 1//ci_Result_Success = n_cst_eventmanager.ci_Result_Success
CONSTANT int eventtaskci_Result_SuccessNotComplete = 0//ci_Result_SuccessNotComplete = n_cst_eventmanager.ci_Result_SuccessNotComplete
 
//ptcorenv.pbl(n_cst_helptopic)
CONSTANT String cs_Classname_RouteInfo     = "w_routemanager"
CONSTANT String cs_RouteInfo        = "Route Information"
CONSTANT Integer ci_RouteInfo        = 1
CONSTANT String cs_Classname_PhoneList     = "w_phone_list"
CONSTANT String cs_PhoneList         = "Phone List"
CONSTANT Integer ci_PhoneList         = 2
CONSTANT String cs_Classname_ExportCompanyList = "n_cst_companies" //gnv_cst_Companies.of_ExportList ( )
CONSTANT String cs_ExportCompanyList     = "Export Company List"
CONSTANT Integer ci_ExportCompanyList     = 3
CONSTANT String cs_Classname_ImportCompanyInfo = "n_cst_import_companies" //lnv_Import_Companies.of_ImportCompanyFile ( )
CONSTANT String cs_ImportCompanyInfo     = "Import Company Information"
CONSTANT Integer ci_ImportCompanyInfo     = 4
CONSTANT String cs_Classname_CompanySearch   = "w_companysearch"
CONSTANT String cs_CompanySearch      = "Company Search"
CONSTANT Integer ci_CompanySearch      = 5
CONSTANT String cs_Classname_CarrierSearch   = "w_carrierlanesearch"
CONSTANT String cs_CarrierSearch      = "Carrier Search"
CONSTANT Integer ci_CarrierSearch      = 6
CONSTANT String cs_Classname_ReportViewer    = "w_psr_viewer"
CONSTANT String cs_ReportViewer       = "Report Viewer"
CONSTANT Integer ci_ReportViewer       = 7
CONSTANT String cs_Classname_ReportLastFreeDate = "w_review_confirm"
CONSTANT String cs_ReportLastFreeDate    = "Report Last Free Date"
CONSTANT Integer ci_ReportLastFreeDate    = 8
CONSTANT String cs_Classname_ReportTIR     = "w_tirselection"
CONSTANT String cs_ReportTIR        = "Report TIR"
CONSTANT Integer ci_ReportTIR        = 9
CONSTANT String cs_Classname_ReportShipmentCount = "w_psr_viewer" //???
CONSTANT String cs_ReportShipmentCount    = "Report Shipment Count"
CONSTANT Integer ci_ReportShipmentCount    = 10
CONSTANT String cs_Classname_SetupUserPrivileges = "w_privileges"
CONSTANT String cs_SetupUserPrivileges    = "Setup User Privileges"
CONSTANT Integer ci_SetupUserPrivileges    = 11
CONSTANT String cs_Classname_SetupSystemSettings = "w_settings"
CONSTANT String cs_SetupSystemSettings    = "Setup System Settings"
CONSTANT Integer ci_SetupSystemSettings    = 12
CONSTANT String cs_Classname_SetupNotificationSetup = "w_notificationsetup"
CONSTANT String cs_SetupNotificationSetup    = "Setup Notification Setup"
CONSTANT Integer ci_SetupNotificationSetup    = 13
CONSTANT String cs_Classname_SetupEventConfirmationRequirements = "w_eventconfirmationoptions"
CONSTANT String cs_SetupEventConfirmationRequirements    = "Setup Event Confirmation Requirements"
CONSTANT Integer ci_SetupEventConfirmationRequirements    = 14
CONSTANT String cs_Classname_SetupEquipmentLeaseTypes = "w_equipmentleasetypes"
CONSTANT String cs_SetupEquipmentLeaseTypes    = "Setup Equipment Lease Types"
CONSTANT Integer ci_SetupEquipmentLeaseTypes    = 15
CONSTANT String cs_Classname_SetupSettingsImport   = "w_namedfileimport"
CONSTANT String cs_SetupSettingsImport       = "Setup Settings Import"
CONSTANT Integer ci_SetupSettingsImport       = 16
CONSTANT String cs_Classname_Registration     = "w_reg_adjust"
CONSTANT String cs_Registration        = "Registration"
CONSTANT Integer ci_Registration        = 17
CONSTANT String cs_Classname_RateConfirmationTemplate = "w_rte"
CONSTANT String cs_RateConfirmationTemplate    = "Rate Confirmation Template"
CONSTANT Integer ci_RateConfirmationTemplate    = 18
CONSTANT String cs_Classname_SystemImportData    = "n_cst_bso_import" //lnv_import.of_Import ( )
CONSTANT String cs_SystemImportData       = "System Import Data"
CONSTANT Integer ci_SystemImportData       = 19
CONSTANT String cs_Classname_SystemImportedLog   = "w_shipimportresults"
CONSTANT String cs_SystemImportedLog       = "System Imported Log"
CONSTANT Integer ci_SystemImportedLog       = 20
CONSTANT String cs_Classname_SystemPCMilerConnection = "w_pcm_connection"
CONSTANT String cs_SystemPCMilerConnection     = "System PCMiler Connection"
CONSTANT Integer ci_SystemPCMilerConnection     = 21
CONSTANT String cs_Classname_SystemAutomaticCompanyLocatorUpdate = "n_cst_import_Companies" //lnv_Import_Companies.of_updatecompanylocators ( )
CONSTANT String cs_SystemAutomaticCompanyLocatorUpdate     = "System Automatic Company Locator Update"
CONSTANT Integer ci_SystemAutomaticCompanyLocatorUpdate     = 22
CONSTANT String cs_Classname_SystemModulesInUse   = "w_licensestatus"
CONSTANT String cs_SystemModulesInUse      = "System Modules InUse"
CONSTANT Integer ci_SystemModulesInUse      = 23
CONSTANT String cs_Classname_RateListLookup    = "w_rate_query"
CONSTANT String cs_RateListLookup        = "Rate List Lookup"
CONSTANT Integer ci_RateListLookup        = 24 //also rate lookup
CONSTANT String cs_Classname_AutoRateLookup    = "w_autoratequery"
CONSTANT String cs_AutoRateLookup        = "Auto Rate Lookup"
CONSTANT Integer ci_AutoRateLookup        = 25
CONSTANT String cs_Classname_ZonesSetup      = "w_zonemanager"
CONSTANT String cs_ZonesSetup         = "Zones Setup"
CONSTANT Integer ci_ZonesSetup         = 26
CONSTANT String cs_Classname_RateTables      = "w_ratetable"
CONSTANT String cs_RateTables          = "Rate Tables"
CONSTANT Integer ci_RateTables          = 27
CONSTANT String cs_Classname_CodeDefaults     = "w_ratetablelist"
CONSTANT String cs_CodeDefaults        = "Code Defaults"
CONSTANT Integer ci_CodeDefaults        = 28
CONSTANT String cs_Classname_Billing       = "w_billing"
CONSTANT String cs_Billing          = "Billing"
CONSTANT Integer ci_Billing          = 29
CONSTANT String cs_Classname_BilltoOrigDestPoints  = "w_billtopoints"
CONSTANT String cs_BilltoOrigDestPoints      = "Billto Origin/Destination Points"
CONSTANT Integer ci_BilltoOrigDestPoints      = 30
CONSTANT String cs_Classname_LogoSetup      = "w_graphic_setup"
CONSTANT String cs_LogoSetup         = "Logo Setup"
CONSTANT Integer ci_LogoSetup         = 31
CONSTANT String cs_Classname_InvoiceSeriesSetup   = "w_billseq_edit"
CONSTANT String cs_InvoiceSeriesSetup      = "Invoice Series Setup"
CONSTANT Integer ci_InvoiceSeriesSetup      = 32
CONSTANT String cs_Classname_AmountTypeSetup    = "w_amounttypes"
CONSTANT String cs_AmountTypeSetup       = "Amount Type Setup"
CONSTANT Integer ci_AmountTypeSetup       = 33
CONSTANT String cs_Classname_ShipmentTypeSetup   = "w_shiptype_manager"
CONSTANT String cs_ShipmentTypeSetup        = "Shipment Type Setup"
CONSTANT Integer ci_ShipmentTypeSetup        = 34
CONSTANT String cs_Classname_ValidateGLAR     = "n_cst_bso_accountingmanager" //lnv_AccountingManager.of_ValidateAccounts("R")
CONSTANT String cs_ValidateGLAR        = "Validate GL AR"
CONSTANT Integer ci_ValidateGLAR        = 35
CONSTANT String cs_Classname_Settlements     = "w_transactionmanager"
CONSTANT String cs_Settlements         = "Settlements"
CONSTANT Integer ci_Settlements         = 36
//CONSTANT String cs_Classname_Settlements_selection  = "w_transaction_selection"
//CONSTANT String cs_Settlements         = "Settlement Selection"
//CONSTANT Integer ci_Settlements         = 0
CONSTANT String cs_Classname_BatchManager     = "w_settlementbatchmanager"
CONSTANT String cs_BatchManager        = "Batch Manager"
CONSTANT Integer ci_BatchManager        = 37
CONSTANT String cs_Classname_FuelCardImport    = "w_importamounts"
CONSTANT String cs_FuelCardImport        = "Fuel Card Import"
CONSTANT Integer ci_FuelCardImport        = 38
CONSTANT String cs_Classname_AmountOwedSearch    = "w_amountowedsearch"
CONSTANT String cs_AmountOwedSearch       = "Amount Owed Search"
CONSTANT Integer ci_AmountOwedSearch       = 39
CONSTANT String cs_Classname_RateTypeSetup     = "w_ratetypes"
CONSTANT String cs_RateTypeSetup        = "Rate Type Setup"
CONSTANT Integer ci_RateTypeSetup        = 40
CONSTANT String cs_Classname_ReferenceTypeSetup   = "w_refnumtypes"
CONSTANT String cs_ReferenceTypeSetup      = "Reference Type Setup"
CONSTANT Integer ci_ReferenceTypeSetup      = 41
CONSTANT String cs_Classname_DivisionSetup     = "w_shiptype_manager"
CONSTANT String cs_DivisionSetup        = "Division Setup"
CONSTANT Integer ci_DivisionSetup        = 42
CONSTANT String cs_Classname_PayablesSetup     = "w_tv_amounttemplates"
CONSTANT String cs_PayablesSetup        = "Payables Setup"
CONSTANT Integer ci_PayablesSetup        = 43
CONSTANT String cs_Classname_ValidatePayableVendors  = "w_entitylist"
CONSTANT String cs_ValidatePayableVendors     = "Validate Payable Vendors"
CONSTANT Integer ci_ValidatePayableVendors     = 44
CONSTANT String cs_Classname_ValidatePayrollEmployees = "w_entitylist"
CONSTANT String cs_ValidatePayrollEmployees    = "Validate Payroll Employees"
CONSTANT Integer ci_ValidatePayrollEmployees    = 45
CONSTANT String cs_Classname_ValidateGLAP     = "n_cst_bso_accountingmanager" //lnv_AccountingManager.of_ValidateAccounts("P")
CONSTANT String cs_ValidateGLAP        = "Validate GL AP"
CONSTANT Integer ci_ValidateGLAP        = 46
CONSTANT String cs_Classname_ScanBatch      = "w_imaging"
CONSTANT String cs_ScanBatch         = "Scan Batch"
CONSTANT Integer ci_ScanBatch         = 47
CONSTANT String cs_Classname_Archiving      = "w_imagingsettingsmanager"
CONSTANT String cs_Archiving         = "Archiving"
CONSTANT Integer ci_Archiving         = 48
CONSTANT String cs_Classname_ImageTypeSetup    = "w_imagetypesetup"
CONSTANT String cs_ImageTypeSetup        = "Image Type Setup"
CONSTANT Integer ci_ImageTypeSetup        = 49
CONSTANT String cs_Classname_LogEntry      = "w_log"
CONSTANT String cs_LogEntry          = "Log Entry"
CONSTANT Integer ci_LogEntry          = 50
CONSTANT String cs_Classname_Violations      = "w_vios_driver"
CONSTANT String cs_Violations         = "Violations"
CONSTANT Integer ci_Violations         = 51
CONSTANT String cs_Classname_Reporting      = "w_log_reports"
CONSTANT String cs_Reporting         = "Reporting"
CONSTANT Integer ci_Reporting         = 52
CONSTANT String cs_Classname_RandomDriverLIst    = "w_driver_random"
CONSTANT String cs_RandomDriverLIst       = "Random Driver LIst"
CONSTANT Integer ci_RandomDriverLIst       = 53
CONSTANT String cs_Classname_LogAdministration   = "w_log_admin"
CONSTANT String cs_LogAdministration       = "Log Administration"
CONSTANT Integer ci_LogAdministration       = 54
CONSTANT String cs_Classname_UserPreferences    = "w_log_settings"
CONSTANT String cs_UserPreferences       = "User Preferences"
CONSTANT Integer ci_UserPreferences       = 55
CONSTANT String cs_Classname_ItinShip3rdPartyTrip  = "w_itin_select"
CONSTANT String cs_ItinShip3rdPartyTrip      = "Itinerary/Shipment/3rdPartyTrip"
CONSTANT Integer ci_ItinShip3rdPartyTrip      = 56
CONSTANT String cs_Classname_AutoRouteRepos    = "w_autoreposequipmentinput"
CONSTANT String cs_AutoRouteRepos        = "Auto Route Repos"
CONSTANT Integer ci_AutoRouteRepos        = 57
CONSTANT String cs_Classname_ShipmentSummary    = "w_shipmentmanager"
CONSTANT String cs_ShipmentSummary       = "Shipment Summary"
CONSTANT Integer ci_ShipmentSummary       = 58
CONSTANT String cs_Classname_EquipmentSummary    = "w_equipmentsummary"
CONSTANT String cs_EquipmentSummary       = "Equipment Summary"
CONSTANT Integer ci_EquipmentSummary       = 59
CONSTANT String cs_Classname_3rdPartyTripSummary   = "w_tripsummary"
CONSTANT String cs_3rdPartyTripSummary      = "3rdPartyTrip Summary"
CONSTANT Integer ci_3rdPartyTripSummary      = 60
CONSTANT String cs_Classname_Search       = "w_search"
CONSTANT String cs_Search          = "Search"
CONSTANT Integer ci_Search          = 61
CONSTANT String cs_Classname_PCMilerInterface    = "w_pcmiler"
CONSTANT String cs_PCMilerInterface       = "PCMiler Interface"
CONSTANT Integer ci_PCMilerInterface       = 62
CONSTANT String cs_Classname_CashAdvance     = "w_cashadvance"
CONSTANT String cs_CashAdvance         = "Cash Advance"
CONSTANT Integer ci_CashAdvance         = 63
CONSTANT String cs_Classname_DeviceSetup     = "w_communication_manager"
CONSTANT String cs_DeviceSetup         = "Device Setup"
CONSTANT Integer ci_DeviceSetup         = 64
CONSTANT String cs_Classname_ProcessInboundMessages  = "w_deviceselection"//?????????
CONSTANT String cs_ProcessInboundMessages     = "Process Inbound Messages"
CONSTANT Integer ci_ProcessInboundMessages     = 65
CONSTANT String cs_Classname_MessageLog      = "w_inboundmessages"
CONSTANT String cs_MessageLog         = "Message Log"
CONSTANT Integer ci_MessageLog         = 66
CONSTANT String cs_Classname_SendFreeFormText    = "w_freeform_text"
CONSTANT String cs_SendFreeFormText       = "Send FreeForm Text"
CONSTANT Integer ci_SendFreeFormText       = 67
CONSTANT String cs_Classname_CompanyFacilitySelection = "w_co_select2"
CONSTANT String cs_CompanyFacilitySelection    = "Company Facility Selection"
CONSTANT Integer ci_CompanyFacilitySelection    = 68
CONSTANT String cs_Classname_CompanyInformation   = "w_company"
CONSTANT String cs_CompanyInformation      = "Company Information"
CONSTANT Integer ci_CompanyInformation      = 69
CONSTANT String cs_Classname_CompanyFacilityDetails  = "w_companydetail"
CONSTANT String cs_CompanyFacilityDetails     = "Company Facility Details"
CONSTANT Integer ci_CompanyFacilityDetails     = 70
CONSTANT String cs_Classname_ContactInformation   = "w_companycontact_detail" //????
CONSTANT String cs_ContactInformation      = "Contact Information"
CONSTANT Integer ci_ContactInformation      = 71
CONSTANT String cs_Classname_FacilityDetails    = "w_company" //????
CONSTANT String cs_FacilityDetails       = "Facility Details"
CONSTANT Integer ci_FacilityDetails       = 72
CONSTANT String cs_Classname_EDISetup      = "w_ediprofile"
CONSTANT String cs_EDISetup          = "EDI Setup"
CONSTANT Integer ci_EDISetup          = 73
CONSTANT String cs_Classname_EDITransactionLog   = "w_edilog"
CONSTANT String cs_EDITransactionLog       = "EDI Transaction Log"
CONSTANT Integer ci_EDITransactionLog       = 74
CONSTANT String cs_Classname_EmployeeInformation   = "w_emp_info"
CONSTANT String cs_EmployeeInformation      = "Employee Information"
CONSTANT Integer ci_EmployeeInformation      = 75
CONSTANT String cs_Classname_EmployeeSelection   = "w_emp_list"
CONSTANT String cs_EmployeeSelection       = "Employee Selection"
CONSTANT Integer ci_EmployeeSelection       = 76
CONSTANT String cs_Classname_EmployeeNotes     = "w_text_edit"
CONSTANT String cs_EmployeeNotes        = "Employee Notes"
CONSTANT Integer ci_EmployeeNotes        = 77
CONSTANT String cs_Classname_DriverFleetHistoryReport = "Driver Fleet History Report" //????
CONSTANT String cs_DriverFleetHistoryReport    = "Driver Fleet History Report"
CONSTANT Integer ci_DriverFleetHistoryReport    = 78
CONSTANT String cs_Classname_DuplicateShipment   = "w_duplicatewithequipment"
CONSTANT String cs_DuplicateShipment       = "Duplicate Shipment"
CONSTANT Integer ci_DuplicateShipment       = 79
CONSTANT String cs_Classname_DocumentWindow    = "w_documentselection"
CONSTANT String cs_DocumentWindow        = "Document Window"
CONSTANT Integer ci_DocumentWindow        = 80
CONSTANT String cs_Classname_LoadBuilder     = "w_loadbuilder"
CONSTANT String cs_LoadBuilder         = "LoadBuilder"
CONSTANT Integer ci_LoadBuilder         = 81
CONSTANT String cs_Classname_Dispatch      = "w_dispatch"
CONSTANT String cs_Classname_ShipmentWindow    = "w_ship"
CONSTANT String cs_ShipmentWindow        = "Shipment Window"
CONSTANT Integer ci_ShipmentWindow        = 82
CONSTANT String cs_Classname_ItemDetails     = "u_dw_itemdetails"
CONSTANT String cs_ItemDetails         = "Item Details"
CONSTANT Integer ci_ItemDetails         = 83
CONSTANT String cs_Classname_RateSelection     = "w_rate_selection"
CONSTANT String cs_RateSelection        = "Rate Selection"
CONSTANT Integer ci_RateSelection        = 84
CONSTANT String cs_Classname_EventDetails     = "u_dw_eventdetail"
CONSTANT String cs_EventDetails        = "Event Details"
CONSTANT Integer ci_EventDetails        = 85
CONSTANT String cs_Classname_ShipmentSplits    = "w_shipmentsplits"
CONSTANT String cs_ShipmentSplits        = "Shipment Splits"
CONSTANT Integer ci_ShipmentSplits        = 86
CONSTANT String cs_Classname_NotificationTargets   = "w_shipmentnotification"
CONSTANT String cs_NotificationTargets      = "Notification Targets"
CONSTANT Integer ci_NotificationTargets      = 87
CONSTANT String cs_Classname_ShipmentDetail    = "w_shipmentdetail"
CONSTANT String cs_ShipmentDetail        = "Shipment Detail"
CONSTANT Integer ci_ShipmentDetail        = 88
CONSTANT String cs_Classname_ManageRevenueSplits   = "w_revenuemanager"
CONSTANT String cs_ManageRevenueSplits      = "Manage Revenue Splits"
CONSTANT Integer ci_ManageRevenueSplits      = 89
CONSTANT String cs_Classname_LinkedEquipment    = "w_linkedequipment"
CONSTANT String cs_LinkedEquipment       = "Linked Equipment"
CONSTANT Integer ci_LinkedEquipment       = 90
CONSTANT String cs_Classname_AutoRouteEventSelection = "w_event_route"
CONSTANT String cs_AutoRouteEventSelection     = "Auto Route Event Selection"
CONSTANT Integer ci_AutoRouteEventSelection     = 91
CONSTANT String cs_Classname_ItineraryWindow    = "w_itin"
CONSTANT String cs_ItineraryWindow       = "Itinerary Window"
CONSTANT Integer ci_ItineraryWindow       = 92
CONSTANT String cs_Classname_RouteMap      = "w_map" //w_map_streets
CONSTANT String cs_RouteMap          = "Route Map"
CONSTANT Integer ci_RouteMap          = 93
CONSTANT String cs_Classname_DrivingInstructions   = "w_pcreport"
CONSTANT String cs_DrivingInstructions      = "Driving Instructions"
CONSTANT Integer ci_DrivingInstructions      = 94
CONSTANT String cs_Classname_Statistics      = "w_itinerartstats"
CONSTANT String cs_Statistics         = "Statistics"
CONSTANT Integer ci_Statistics         = 95
CONSTANT String cs_Classname_ShipmentSelection   = "w_shipment_select"
CONSTANT String cs_ShipmentSelection       = "Shipment Selection"
CONSTANT Integer ci_ShipmentSelection       = 96
CONSTANT String cs_Classname_DriverSelection    = "Driver Selection" //???????
CONSTANT String cs_DriverSelection       = "Driver Selection"
CONSTANT Integer ci_DriverSelection       = 97
CONSTANT String cs_Classname_ImagingWindow     = "w_imaging"
CONSTANT String cs_ImagingWindow        = "Imaging Window"
CONSTANT Integer ci_ImagingWindow        = 98
CONSTANT String cs_Classname_ScanImageType     = "w_imagetype"  //also "Scanner Selection" and "Scanner Settings"
CONSTANT String cs_ScanImageType        = "Scan Image Type"
CONSTANT Integer ci_ScanImageType        = 99
CONSTANT String cs_Classname_MultiShipmentUpdate   = "w_multishipupdate"
CONSTANT String cs_MultiShipmentUpdate      = "Multi-Shipment Update"
CONSTANT Integer ci_MultiShipmentUpdate      = 102
CONSTANT String cs_Classname_EDIMessageDetail    = "w_shipmentstatus_details"
CONSTANT String cs_EDIMessageDetail       = "EDI Message Detail"
CONSTANT Integer ci_EDIMessageDetail       = 103
CONSTANT String cs_Classname_EDIMessagesforShipment  = "w_shipmentstatus_list"
CONSTANT String cs_EDIMessagesforShipment     = "EDI Messages for Shipment"
CONSTANT Integer ci_EDIMessagesforShipment     = 104
CONSTANT String cs_Classname_MIssingDocumentReport  = "w_mIssingimagetypeselection"
CONSTANT String cs_MIssingDocumentReport     = "MIssing Document Report"
CONSTANT Integer ci_MIssingDocumentReport     = 105
CONSTANT String cs_Classname_EquipmentInformation  = "w_eq_info"
CONSTANT String cs_EquipmentInformation      = "Equipment Information"
CONSTANT Integer ci_EquipmentInformation      = 106
CONSTANT String cs_Classname_AddViolation     = "w_add_vios"
CONSTANT String cs_AddViolation        = "Add Violation"
CONSTANT Integer ci_AddViolation        = 107
CONSTANT String cs_Classname_LogReceipts     = "w_log_receipts"
CONSTANT String cs_LogReceipts         = "Log Receipts"
CONSTANT Integer ci_LogReceipts         = 108
CONSTANT String cs_Classname_322dialog      = "w_edi322_dialog"
CONSTANT String cs_322dialog         = "EDI 322"
CONSTANT Integer ci_322dialog         = 111
CONSTANT String cs_Classname_CompanyAlias     = "w_companyalias"
CONSTANT String cs_CompanyAlias        = "Company Alias List"
CONSTANT Integer ci_CompanyAlias        = 112
CONSTANT String cs_Classname_EDIAliasList     = "w_aliassetup"
CONSTANT String cs_EDIAliasList        = "EDI Alias List"
CONSTANT Integer ci_EDIAliasList        = 113
CONSTANT String cs_Classname_EditEventSchedule   = "w_scheduleedit"
CONSTANT String cs_EditEventSchedule       = "Edit Schedule"
CONSTANT Integer ci_EditEventSchedule       = 114
CONSTANT String cs_Classname_UserAlerts      = "w_textinput"
CONSTANT String cs_UserAlerts         = "User Alerts"
CONSTANT Integer ci_UserAlerts         = 115
 
//ptcorenv.pbl(n_cst_privileges)
CONSTANT Integer ci_Class_NonUser = 1001
CONSTANT Integer ci_Class_Lookup = 1002
CONSTANT Integer ci_Class_Entry = 1003
CONSTANT Integer ci_Class_Audit = 1004
CONSTANT Integer ci_Class_Administrative = 1005
 
//ptcorenv.pbl(n_cst_referencelist)
Constant String  cs_ReferenceType = "REFERENCETYPE"
 
//ptcorenv.pbl(n_cst_scheduledata)
Constant String cs_Sun = 'sunday'
Constant String cs_Mon = 'monday'
Constant String cs_Tues = 'tuesday'
Constant String cs_Wed = 'wednesday'
Constant String cs_Thurs = 'thursday'
Constant String cs_Fri = 'friday'
Constant String cs_Sat = 'saturday'
 
//ptcorenv.pbl(n_cst_settings)
CONSTANT String cs_datatype_string = 'STRING'
CONSTANT String cs_datatype_decimal = 'DECIMAL'
CONSTANT String cs_datatype_date = 'DATE'
CONSTANT String cs_datatype_long = 'LONG'
CONSTANT String cs_datatype_char = 'CHAR'
 
//ptcorenv.pbl(n_cst_valuelist)
Constant String cs_ValueColumn = "Value"
 
//ptdyn.pbl(n_cst_bso_dynamicobjectmanager)
Constant String cs_WindowTemplate = "Window Template"
Constant String cs_DataWindowTemplate = "DataWindow Template"
Constant String cs_ShipmentTemplate = "Shipment Template"
Constant String cs_DriverTemplate = "Driver Template"
Constant String cs_EquipmentTemplate = "Equipment Template"
Constant String cs_TabTemplate = "Tab Template"
Constant String cs_QuickMatchTool = "Quick Match Tool"
Constant String cs_adminTool = "Admin Tool"
Constant String cs_State = "state"
Constant String cs_MinPosX = "minposx"
Constant String cs_MinPosY = "minposy"
Constant String   cs_NormalPosTop = "normalpostop"
Constant String cs_NormalPosLeft = "normalposleft"
Constant String cs_NormalPosRight = "normalposright"
Constant String cs_NormalPosBottom = "normalposbottom"
Constant String cs_PlacementFlag = "placementflag"
Constant String cs_globalReplaceRN = "#^*"
Constant int  ci_FailedDOLinkageTest = -1
Constant int  ci_FailedDOColArgTest = -2
Constant int  ci_FailedDoMouseOverTest = -3
Constant int  ci_FailedDOComputeTest = -4
Constant int  ci_failedArgTest= -5
Constant int  ci_AllertDOPathNonValid = 5
Constant int  ci_failedupdateDynObjTable = -1
Constant int  ci_failedupdateDynPropTable = -2
Constant int  ci_invalidMode = -3
Constant int  ci_invalidObjName = -4
Constant int  ci_nonDynamicObject = -5
 
//ptdyn.pbl(n_cst_dwsrv_mouseover)
Constant String  cs_RowResponse = "[row]"
Constant String  cs_TextType = "text"
Constant String  cs_DwType = "dw"
Constant String  cs_Background = "background~t0" //GetObjectAtPoiner returns this string when there is no object
 
//ptdyn.pbl(n_cst_dwsrv_restrict)
constant Int ci_OutOfMode = 1
constant Int ci_intoMode = 0
constant string cs_CHECKROWSTAG = "CHECKROWS"  //this is the tag that should
constant string cs_KEEPGROUPTAG = "KEEPGROUP"  //this tag is used for shipements views right now.
 
//ptdyn.pbl(n_cst_restrictioncriteria)
Constant String   cs_shipments = "SHIPMENTS"
Constant String  cs_driverEquip = "DRIVER_EQUIP"
Constant String   cs_Drivers = "DRIVERS"
Constant String   cs_Equipment = "EQUIPMENT"
 
//ptdyn.pbl(w_dwapplylink)
Constant String cs_TITLECOL = "detailname"
Constant String cs_RETRIEVECOL = "retrieve"
Constant String cs_SCROLLCOL = "scroll"
Constant String cs_FILTERCOL = "filter"
Constant String cs_MASTERCOL = "mastercol"
Constant String cs_DETAILCOL = "detailcol"
Constant String cs_ORDERCOL = "order"
Constant String cs_ARGKEYCOL = "linkid"
Constant String cs_STYLECOL = "style"
Constant String cs_RETRIEVALTYPECOL = "retrievaltype"
Constant String cs_RETRIEVALNAMECOL = "retrievalname"
Constant String cs_MANDATORYCOL = "mandatory"
 
//ptdyn.pbl(w_dwlink)
Constant String w_dwlink_cs_TITLECOL = "detailname"//cs_TITLECOL = "detailname"
Constant String cs_OBJECTNAMECOL = "objectname"
Constant String w_dwlink_cs_RETRIEVECOL = "retrieve"//cs_RETRIEVECOL = "retrieve"
Constant String w_dwlink_cs_SCROLLCOL = "scroll"//cs_SCROLLCOL = "scroll"
Constant String w_dwlink_cs_FILTERCOL = "filter"//cs_FILTERCOL = "filter
Constant String w_dwlink_cs_MASTERCOL = "mastercolumn"//cs_MASTERCOL = "mastercolumn"
Constant String w_dwlink_cs_DETAILCOL = "detailcolumn"//cs_DETAILCOL = "detailcolumn"
Constant String w_dwlink_cs_ORDERCOL = "argumentorder"//cs_ORDERCOL = "argumentorder"
Constant String w_dwlink_cs_ARGKEYCOL = "linkid"//cs_ARGKEYCOL = "linkid"
Constant String w_dwlink_cs_STYLECOL = "style"//cs_STYLECOL = "style"
Constant String w_dwlink_cs_RETRIEVALTYPECOL = "retrievaltype"//cs_RETRIEVALTYPECOL = "retrievaltype"
Constant String w_dwlink_cs_RETRIEVALNAMECOL = "retrievalname"//cs_RETRIEVALNAMECOL = "retrievalname"
Constant String w_dwlink_cs_MANDATORYCOL = "mandatory"//cs_MANDATORYCOL = "mandatory"
Constant String cs_DWTITLESCOL = "dwtitles"
 
//ptdyn.pbl(w_dwproperties)
Constant String w_dwproperties_cs_Template = "DataWindow Template"//replace cs_Template = "DataWindow Template"
Constant String w_dwproperties_cs_WindowTemplate = "Window Template"//replace  cs_WindowTemplate = "Window Template"
 
//ptdyn.pbl(w_infoflag)
Constant Integer ci_Margin_Top = 1
Constant Integer  ci_Margin_Bottom = 1
Constant Integer ci_Margin_Right = 10
Constant Integer ci_Margin_Left = 10
 
//ptdyn.pbl(w_quickmatch)
Constant String  cs_CurrentPosition = "Current Position"
Constant String  cs_LastReported = "Last Reported"
Constant String  cs_Stop = "Stop"
Constant String  cs_EndRoute = "End Route"
Constant String  cs_EndTrip = "End Trip"
Constant String  cs_Into = "Into"
Constant String  cs_OutOf = "Outof"
 
//ptdyn.pbl(w_savedefinitionas)
Constant String cs_DwTemplate = "DataWindow Template"
Constant String cs_WinTemplate = "Window Template"
 
//ptdispwn.pbl(w_autoreposequipmentinput)
Constant  String cs_MsgHdr = "Auto Route Repos"
 
//ptdispwn.pbl(w_itin)
Constant Integer ci_RouteRequest_Route = 1
Constant Integer ci_RouteRequest_ReRoute = 2
Constant Integer ci_RouteRequest_NewEvent = 3
Constant Integer ci_RouteRequest_Clipboard = 4
Constant Integer ci_RouteRequest_Assignment = 5
 
//ptdisp2.pbl(u_cst_statusfilter)
Constant Integer ci_Selection_Open = 1
Constant Integer ci_Selection_Restricted = 2
Constant Integer ci_Selection_All = 3
 
//ptdispnv.pbl(gc_dispatch)
Constant Integer ci_Assignment_Trip = 20
Constant Integer ci_ItinType_Driver = 100
Constant Integer ci_ItinType_PowerUnit = 200
Constant Integer ci_ItinType_TrailerChassis = 300
Constant Integer ci_ItinType_Container = 400
Constant Integer ci_ItinType_Trip = 500
Constant Integer ci_ItinType_Shipment = 600
Constant Integer ci_MinIndex_Driver = 1
Constant Integer ci_MaxIndex_Driver = 1
Constant Integer ci_MinIndex_PowerUnit = 2
Constant Integer ci_MaxIndex_PowerUnit = 2
Constant Integer ci_MinIndex_TrailerChassis = 3
Constant Integer ci_MaxIndex_TrailerChassis = 5
Constant Integer ci_MinIndex_Container = 6
Constant Integer ci_MaxIndex_Container = 9
Constant String cs_Column_Trip = "de_Trailer"
Constant String cs_Column_TripSeq = "de_Trailer_Seq"
Constant String cs_Column_ParentId = "ds_parentid"
Constant String cs_MultiListDelimiter = ","
Constant String cs_Context_DispatchShipment = "T"
Constant String cs_Context_NonRoutedShipment = "D"
Constant String cs_Context_Itinerary = "I"
Constant String cs_Context_Trip = "3"
Constant String cs_EventType_Pickup = "P"
Constant String cs_EventType_Deliver = "D"
Constant String cs_EventType_NewTrip = "O"
Constant String cs_EventType_EndTrip = "F"
Constant String cs_EventType_Hook = "H"
Constant String cs_EventType_Drop = "R"
Constant String cs_EventType_Mount = "M"
Constant String cs_EventType_Dismount = "N"
Constant String cs_EventType_Bobtail = "B"
Constant String cs_EventType_Deadhead = "A"
Constant String cs_EventType_Reposition = "S"
Constant String cs_EventType_Misc = "X"
Constant String cs_EventType_CheckCall = "C"
Constant String cs_EventType_PositionReport = "U"
Constant String cs_EventType_Breakdown = "K"
Constant String cs_EventType_PMService = "V"
Constant String cs_EventType_Repairs = "Z"
Constant String cs_EventType_Accident = "T"
Constant String cs_EventType_DOT = "I"
Constant String cs_EventType_Scale = "L"
Constant String cs_EventType_OffDuty = "Y"
Constant String cs_EventType_Sleeper = "E"
Constant String cs_EventAction_YardMove = "Y"
Constant String cs_EventAction_CrossDock = "C"
Constant String cs_EventAction_ChassisSplit = "S"
Constant Integer ci_InsertionStyle_Before = 1
Constant Integer ci_InsertionStyle_After = 2
Constant Integer ci_InsertionStyle_StartOfDay = 3
Constant Integer ci_InsertionStyle_EndOfDay = 4
Constant Integer ci_InsertionStyle_StartOfRoute = 5
Constant Integer ci_InsertionStyle_EndOfRoute = 6
Constant Integer ci_InsertionStyle_EmptyDay = 7
Constant Integer ci_InsertionStyle_StartOfTrip = 8
Constant Integer ci_InsertionStyle_EndOfTrip = 9
Constant Integer ci_InsertionStyle_Assignment = 10
Constant String cs_RouteType_Pickup = "PICKUP"
Constant String cs_RouteType_Deliver = "DELIVER"
Constant String cs_RouteType_Any = "ANY"
Constant String cs_ShipmentStatus_Template = "A"
Constant String cs_ShipmentStatus_Cancelled = "C"
Constant String cs_ShipmentStatus_Quoted = "E"
Constant String cs_ShipmentStatus_Offered = "F"
Constant String cs_ShipmentStatus_Pending = "H"
Constant String cs_ShipmentStatus_Open = "K"
Constant String cs_ShipmentStatus_Authorized = "N"
Constant String cs_ShipmentStatus_AuditRequired = "Q"
Constant String cs_ShipmentStatus_Audited = "T"
Constant String cs_ShipmentStatus_Billed = "W"
Constant String cs_ShipmentStatus_Declined = "D"
Constant String cs_ShipDupOpt_Items = "Include Items"
Constant String cs_ShipDupOpt_Payables = "Include Payables"
Constant String cs_ShipDupOpt_RefLabels = "Include Ref # Labels"
Constant String cs_ShipDupOpt_RefValues = "Include Ref # Values"
Constant String cs_ShipDupOpt_ShipNote = "Include Ship Note"
Constant String cs_ShipDupOpt_BillNote = "Include Bill Note"
Constant String cs_ShipDupOpt_NonRouted = "Non-Routed Copy"
Constant String cs_ShipDupOpt_CustomFields = "Include Custom Fields"
Constant String cs_ShipDupOpt_BLNum = "Include BL Num"
Constant String cs_ShipDupOpt_Intermodal = "Include Intermodal"
Constant String cs_ShipDupOpt_EventNotes = "Include Event Notes"
Constant String cs_ShipDupOpt_FreightItems = "Include Freight Items"
Constant String cs_ShipDupOpt_AccItems = "Include Acc. Items"
Constant String cs_ShipDupOpt_EventDates = "Include Event Dates"
Constant String cs_ShipDupOpt_EventTimes = "Include Event Times"
Constant String cs_ShipDupOpt_CopyChild = "Copy Child Shipments"
//Constant String cs_ErrorText_SequenceRange = "Could not apply routing sequence numbers."
Constant String cs_MoveCode_Import = "I"
Constant String cs_MoveCode_Export = "E"
Constant String cs_MoveCode_Other = "O"
 
//ptdispnv.pbl(n_cst_beo_trip)
Constant String cs_Status_Open = "K"
Constant String cs_Status_Authorized = "N"
Constant String cs_Status_AuditRequired = "Q"
Constant String cs_Status_Audited = "T"
Constant String cs_Status_History = "W"
Constant String cs_Status_ValueList = "OPEN~tK/AUTHORIZED~tN/AUDIT REQ.~tQ/AUDITED~tT/HISTORY~tW/"
 
//ptdispnv.pbl(n_cst_bso_dispatch)
Public Constant String cs_DataObject_Event = "d_itin"
Public Constant String cs_DataObject_Item = "d_item_details"
Public Constant String cs_DataObject_Shipment = "d_ship_info"
Public Constant String cs_DataObject_Equipment = "d_equip_list"
 
//ptdisp.pbl(u_cst_eventrouting_shipment)
Constant Int ci_NumIP = 0
 
//ptdisp.pbl(u_tab_intermodalshipment)
Constant Int ci_TabPage_ShipInfo = 1
Constant Int ci_TabPage_Billing = 3
Constant Int ci_TabPage_Extended = 4
Constant Int ci_TabPage_ExtendedShipInfo = 2
 
//ptdata.pbl(u_cst_employeedivisiondefaults)
constant string cs_unSavedDefaultDivision = "NONE DEFINED"
constant long  cl_unSavedDefaultDivisionID = -1
 
//ptdata.pbl(u_dw_errorlog)
Constant Integer ci_Expand = 350
Constant Integer  ci_Collapse = 76
 
//ptdata.pbl(u_dw_imagelist)
CONSTANT STRING cs_functionSCAN = "Scan Image"
 
//ptdatanv.pbl(n_cst_alertmanager)
CONSTANT int ci_Status_Inactive = 0
CONSTANT int ci_Status_active = 1
 
//ptdatanv.pbl(n_cst_beo_employee)
Constant Integer ci_DescribeType_FirstLast = 100
Constant Integer ci_DescribeType_LastFirst = 101
 
//ptdatanv.pbl(n_cst_beo_imagetype)
CONSTANT String    cs_ImageTopic_Shipment = "SHIPMENT"
CONSTANT String    cs_ImageTopic_Employee= "EMPLOYEE"
CONSTANT String    cs_ImageType_POD = "POD"
CONSTANT String   cs_ImageType_ValueList  = "POD~tPOD/"
CONSTANT String   cs_ImageTopic_ValueList = "SHIPMENT~tSHIPMENT/"
 
//ptdatanv.pbl(n_cst_bso_imagemanager)
Constant String cs_Type_Label   = "Type"
Constant String cs_Type_Shipment  = "Invoice"
Constant String cs_Data_TempNo  = "TempNo"
Constant String cs_VolNumPrefix  = 'PTARCHIVE'   // ZMC 10-31-03
Constant String  cs_ErrMsgHeader = 'Imaging Archive'
 
//ptdatanv.pbl(n_cst_bso_import)
Constant String n_cst_bso_import_cs_IniFile = "trucking.ini"//cs_IniFile = "trucking.ini"
 
//ptdatanv.pbl(n_cst_bso_psr_manager)
Constant  String appeon_cs_Image           = "RULE_IMAGE"// replace cs_Image           = "RULE_IMAGE"
Constant  String cs_Email        =  "RULE_EMAIL"
Constant  String cs_EmailFormat =  "RULE_EMAILFORMAT"
Constant  String cs_PrintPrompt  =  "RULE_PRINTPROMPT"
Constant  String cs_AutoPrint     =  "RULE_AUTOPRINT"
Constant  String cs_SaveAsType =  "RULE_SAVEASTYPE"
Constant  String cs_ShipID     =  "RULE_SHIPID"
Constant  String cs_EventID     =  "RULE_EVENTID"
Constant  String cs_PSRFile  =  "C:\PTREPORT"
 
//ptdatanv.pbl(n_cst_errorlog_manager)
Constant String cs_ErrorRemedy_EDI = "n_cst_ErrorRemedy_edi"
 
//ptdatanv.pbl(n_cst_notemanager)
CONSTANT String cs_Delimiter = "/^\"
 
//ptdatanv.pbl(n_cst_pegasus_print)
CONSTANT Long cl_Right = 10900
CONSTANT Long cl_Left = 500
CONSTANT Long cl_Top = 500
CONSTANT Long cl_Bottom = 15100
 
//ptdatanv.pbl(n_cst_presentation_state)
Constant String	cs_State_ValueList = "choose a state~t /" +&
													"Alabama~tAL/" +&
													"Alaska~tAK/" +&
													"Arizona~tAZ/" +&
													"Arkansas~tAR/" +&
													"California~tCA/" +&
													"Colorado~tCO/" +&
													"Connecticut~tCT/" +&
													"Delaware~tDE/" +&
													"District of Columbia~tDC/" +&
													"Florida~tFL/" +&
													"Georgia~tGA/" +&
													"Hawaii~tHI/" +&
													"Idaho~tID/" +&
													"Illinois~tIL/" +&
													"Indiana~tIN/" +&
													"Iowa~tIA/" +&
													"Kansas~tKS/" +&
													"Kentucky~tKY/" +&
													"Louisiana~tLA/" +&
													"Maine~tME/" +&
													"Maryland~tMD/" +&
													"Massachusetts~tMA/" +&
													"Michigan~tMI/" +&
													"Minnesota~tMN/" +&
													"Mississippi~tMS/" +&
													"Missouri~tMO/" +&
													"Montana~tMT/" +&
													"Nebraska~tNE/" +&
													"Nevada~tNV/" +&
													"New Hampshire~tNH/" +&
													"New Jersey~tNJ/" +&
													"New Mexico~tNM/" +&
													"New York~tNY/" +&
													"North Carolina~tNC/" +&
													"North Dakota~tND/" +&
													"Ohio~tOH/" +&
													"Oklahoma~tOK/" +&
													"Oregon~tOR/" +&
													"Pennsylvania~tPA/" +&
													"Rhode Island~tRI/" +&
													"South Carolina~tSC/" +&
													"South Dakota~tSD/" +&
													"Tennessee~tTN/" +&
													"Texas~tTX/" +&
													"Utah~tUT/" +&
													"Vermont~tVT/" +&
													"Virginia~tVA/" +&
													"Washington~tWA/" +&
													"West Virginia~tWV/" +&
													"Wisconsin~tWI/" +&
													"Wyoming~tWY/" 
													
													
Constant String	cs_State_PRE16 =		"Alberta~tAB/" +&
													"British Columbia~tBC/" +&
													"Manitoba~tMB/" +&
													"New Brunswick~tNB/" +&
													"Newfoundland~tNF/" +&
													"Northwest Territories~tNT/" +&
													"Nova Scotia~tNS/" +&
													"Ontario~tON/" +&
													"Prince Edward Island~tPE/" +&
													"Quebec~tPQ/" +&
													"Saskatchewan~tSK/" +&
													"Yukon~tYK/" +&
													"Mexico~tMX/"
													
Constant String	cs_State_POST15 =		"Alberta~tAB/" +&
													"British Columbia~tBC/" +&
													"Manitoba~tMB/" +&
													"New Brunswick~tNB/" +&
													"Newfoundland and Labrador~tNL/" +&
													"Northwest Territories~tNT/" +&
													"Nova Scotia~tNS/" +&
													"Nunavut~tNU/" +&
													"Ontario~tON/" +&
													"Prince Edward Island~tPE/" +&
													"Quebec~tQC/" +&
													"Saskatchewan~tSK/" +&
													"Yukon~tYT/" +&
													"Mexico~tMX/"
													
Constant String	cs_State_AbrevList = "AL~tAL/" +&
													"AK~tAK/" +&
													"AZ~tAZ/" +&
													"AR~tAR/" +&
													"CA~tCA/" +&
													"CO~tCO/" +&
													"CT~tCT/" +&
													"DE~tDE/" +&
													"DC~tDC/" +&
													"FL~tFL/" +&
													"GA~tGA/" +&
													"HI~tHI/" +&
													"ID~tID/" +&
													"IL~tIL/" +&
													"IN~tIN/" +&
													"IA~tIA/" +&
													"KS~tKS/" +&
													"KY~tKY/" +&
													"LA~tLA/" +&
													"ME~tME/" +&
													"MD~tMD/" +&
													"MA~tMA/" +&
													"MI~tMI/" +&
													"MN~tMN/" +&
													"MS~tMS/" +&
													"MO~tMO/" +&
													"MT~tMT/" +&
													"NE~tNE/" +&
													"NV~tNV/" +&
													"NH~tNH/" +&
													"NJ~tNJ/" +&
													"NM~tNM/" +&
													"NY~tNY/" +&
													"NC~tNC/" +&
													"ND~tND/" +&
													"OH~tOH/" +&
													"OK~tOK/" +&
													"OR~tOR/" +&
													"PA~tPA/" +&
													"RI~tRI/" +&
													"SC~tSC/" +&
													"SD~tSD/" +&
													"TN~tTN/" +&
													"TX~tTX/" +&
													"UT~tUT/" +&
													"VT~tVT/" +&
													"VA~tVA/" +&
													"WA~tWA/" +&
													"WV~tWV/" +&
													"WI~tWI/" +&
													"WY~tWY/"
													
Constant String	cs_State_Abrev_PRE16 =	 &
													"AB~tAB/" +&
													"BC~tBC/" +&
													"MB~tMB/" +&
													"NB~tNB/" +&
													"NF~tNF/" +&
													"NT~tNT/" +&
													"NS~tNS/" +&
													"ON~tON/" +&
													"PE~tPE/" +&
													"PQ~tPQ/" +&
													"SK~tSK/" +&
													"YK~tYK/" +&
													"MX~tMX/"
													
Constant String	cs_State_Abrev_POST15 =	&
													"AB~tAB/" +&
													"BC~tBC/" +&
													"MB~tMB/" +&
													"NB~tNB/" +&
													"NL~tNL/" +&
													"NT~tNT/" +&
													"NS~tNS/" +&
													"NU~tNU/" +&
													"ON~tON/" +&
													"PE~tPE/" +&
													"QC~tQC/" +&
													"SK~tSK/" +&
													"YT~tYT/" +&
													"MX~tMX/"
 
//ptdatawn.pbl(w_authorization)
Constant String appeon_cs_Accept = "ACCEPTED"//replace cs_Accept = "ACCEPTED"
Constant String cs_Deny = "DENIED"
 
//ptdatawn.pbl(w_imaging)
CONSTANT INT ic_FullX = 3653
CONSTANT INT ic_HalfX = 2000
CONSTANT INT ic_BarcodeTO = 0
CONSTANT INT ic_DeletePageTO = 30
CONSTANT INT ic_DeleteTO = 40
CONSTANT INT   ic_ScanTO = 50
 
//ptco.pbl(n_cst_companies)
CONSTANT String  cs_CompanyRole_BillTo = "BillTo"
CONSTANT String   cs_CompanyRole_Agent = "Agent"
CONSTANT String   cs_CompanyRole_Forwarder = "Forwarder"
CONSTANT String   cs_CompanyRole_EventSite = "EventSite"
CONSTANT String   cs_CompanyRole_None = "None"
 
//ptco.pbl(u_tab_companydetail)
Constant Integer ci_Tab_PhysicalAddress = 1
Constant Integer ci_Tab_BillingAddress = 2
Constant Integer ci_Tab_Dispatch = 3
Constant Integer ci_Tab_Notes = 4
Constant Integer ci_Tab_Settings = 5
Constant Integer ci_Tab_Custom_A = 8
Constant Integer ci_Tab_Custom_B = 9
Constant String cs_Color_Disabled = "78682240"
 
//ptco.pbl(w_company)
//Constant String cs_Color_Disabled = "78682240" //replace with  u_tab_companydetail.cs_Color_Disabled
 
//ptequip.pbl(n_cst_beo_equipmentleasetype)
Public Constant Integer ci_CalendarDays = 1
Public Constant Integer ci_WorkingDays = 2
Public Constant Integer ci_Hours = 3
Public Constant Integer ci_Notify = 1
Public Constant Integer ci_Outgate = 2
//Public Constant Integer ci_Yes = 1//replace with n_cst_constant.ci_yes
//Public Constant Integer ci_No = 0//replace with n_cst_constant.ci_No
Public Constant Integer ci_Active = 1
Public Constant Integer ci_DeActive = 0
 
//ptequip.pbl(n_cst_equipmentmanager)
Constant String cs_TRAC = 'T'
Constant String cs_STRT = 'S'
Constant String cs_VAN  = 'N'
Constant String cs_TRLR = 'V'
Constant String cs_FLBD = 'F'
Constant String cs_REFR = 'R'
Constant String cs_TANK = 'K'
Constant String cs_RBOX = 'B'
Constant String cs_CHAS = 'H'
Constant String cs_CNTN = 'C'
Constant String cs_display_TRAC = "TRAC"
Constant String cs_display_STRT = "STRT"
Constant String cs_display_VAN  = "VAN"
Constant String cs_display_TRLR = "TRLR"
Constant String cs_display_FLBD = "FLBD"
Constant String cs_display_REFR = "REFR"
Constant String cs_display_TANK = "TANK"
Constant String cs_display_RBOX = "RBOX"
Constant String cs_display_CHAS = "CNTN"
Constant String cs_display_CNTN = "CHAS"
Constant String cs_Status_Active = 'K'
Constant Long cl_PermIDStart = 10000001
Constant int ci_FreeTimeStart_Notify  = 1
Constant int ci_FreeTimeStart_Outgate  = 2
 
//ptequip.pbl(n_cst_equipmentposting)
Constant String cs_Need = "N"
Constant String cs_Have = "H"
Constant String cs_Inactive = "I"
CONSTANT String cs_FileDelimiter = '~t'
 
//ptequip.pbl(n_cst_presentation_equipment)
Constant String	cs_TANK_Type_Hazardous = 'HAZARDOUS'
Constant String	cs_TANK_Type_GeneralChemical = 'GENERAL CHEMICAL'
Constant String	cs_TANK_Type_FoodGrade = 'FOOD GRADE'
Constant String	cs_TANK_Type_Lined = 'LINED'
Constant String	cs_TANK_Type_DryBulk = 'DRY BULK'
Constant String	cs_TANK_Type_Insulated = 'INSULATED'
Constant String	cs_TANK_Type_Pressurized = 'PRESSURIZED'
													
Constant String	cs_FLAT_Type_StraightFrame = 'STRAIGHT FRAME'
Constant String	cs_FLAT_Type_StraightFrameSpreadAxle = 'STRAIGHT FRAME SPREAD AXLE'
Constant String	cs_FLAT_Type_StraightFrameExtendable = 'STRAIGHT FRAME EXTENDABLE'
Constant String	cs_FLAT_Type_SingleDrop = 'SINGLE DROP'
Constant String	cs_FLAT_Type_SingleDropExtendable = 'SINGLE DROP EXTENDABLE'
Constant String	cs_FLAT_Type_DoubleDrop = 'DOUBLE DROP'
Constant String	cs_FLAT_Type_DoubleDropExtendable = 'DOUBLE DROP EXTENDABLE'
Constant String	cs_FLAT_Type_LowBoy = 'LOWBOY'
Constant String	cs_FLAT_Type_LandAll = 'LANDALL'

Constant String	cs_STRT_Type_Dry = 'DRY'
Constant String	cs_STRT_Type_Reefer = 'REEFER'

Constant String	cs_TRLR_Type_Van = 'VAN'
Constant String	cs_TRLR_Type_AutoDrop = 'AUTO DROP'
Constant String	cs_TRLR_Type_ElectronicsDrop = 'ELECTRONICS DROP'
Constant String	cs_TRLR_Type_CurtainSide = 'CURTAIN SIDE'
Constant String	cs_TRLR_Type_RollerBed = 'ROLLER BED'

Constant String	cs_CHAS_Type_Slider = 'SLIDER'
Constant String	cs_CHAS_Type_HeavyHauler = 'HEAVY HAULER'
Constant String	cs_CHAS_Type_SuperChassis = 'SUPERCHASSIS'
Constant String	cs_CHAS_Type_Extendable = 'EXTENDABLE'
Constant String	cs_CHAS_Type_8Pin = '8 PIN'

Constant String	cs_CNTN_Type_ReeferStandard = 'REEFER-STANDARD'
Constant String	cs_CNTN_Type_ReeferHighCube = 'REEFER-HIGH CUBE'
Constant String	cs_CNTN_Type_DryStandard = 'DRY-STANDARD'
Constant String	cs_CNTN_Type_DryHighCube = 'DRY-HIGH CUBE'
Constant String	cs_CNTN_Type_FlatRack = 'FLAT RACK'
Constant String	cs_CNTN_Type_OpenTop = 'OPEN TOP'
Constant String	cs_CNTN_Type_OpenSide = 'OPEN SIDE'
Constant String	cs_CNTN_Type_Vented = 'VENTED'
Constant String	cs_CNTN_Type_Tank = 'TANK'
Constant String	cs_CNTN_Type_Bulk = 'BULK'
Constant String	cs_CNTN_Type_AutoRack = 'AUTO RACK'

Constant String	cs_REFR_Type_SingleTemp = 'SINGLE TEMP'
Constant String	cs_REFR_Type_MultiTemp = 'MULTI TEMP'

Constant String	cs_DoorType_Swing = 'SWING'
Constant String	cs_DoorType_Roll = 'ROLL'

Constant String	cs_FloorType_Wood = 'WOOD'
Constant String	cs_FloorType_Aluminum = 'ALUMINUM'

Constant String	cs_Construction_Steel = 'STEEL'
Constant String	cs_Construction_Aluminum = 'ALUMINUM'
Constant String	cs_Construction_FRP = 'FRP'

Constant String	cs_Discharge_Powered = 'POWERED'
Constant String	cs_Discharge_GravityFeed = 'GRAVITY FEED'

Constant String	cs_AuxiliaryDevice_PrePass = 'PrePass#'
Constant String	cs_AuxiliaryDevice_FastTrack = 'Fast Track'
Constant String	cs_AuxiliaryDevice_IMEI = 'IMEI#'

Constant String	cs_Tarp_Full = 'FULL'
Constant String	cs_Tarp_Half = 'HALF'
Constant String	cs_Tarp_Skin = 'SKIN'

Constant String	cs_PowerSource_Mechanical = 'MECHANICAL'
Constant String	cs_PowerSource_Electric = 'ELECTRIC'


Constant String	cs_Tank_Type_ValueList = cs_TANK_Type_Hazardous + "~t" + cs_TANK_Type_Hazardous+ "/" +&
													cs_TANK_Type_GeneralChemical + "~t" + cs_TANK_Type_GeneralChemical+ "/" +&
													cs_TANK_Type_FoodGrade + "~t" + cs_TANK_Type_FoodGrade+ "/" +&
													cs_TANK_Type_Lined + "~t" + cs_TANK_Type_Lined+ "/" +&
													cs_TANK_Type_DryBulk + "~t" + cs_TANK_Type_DryBulk+ "/" +&
													cs_TANK_Type_Insulated + "~t" + cs_TANK_Type_Insulated+ "/" +&
													cs_TANK_Type_Pressurized + "~t" + cs_TANK_Type_Pressurized+ "/" 
													
Constant String	cs_FLAT_Type_ValueList = cs_FLAT_Type_StraightFrame + "~t" + cs_FLAT_Type_StraightFrame+ "/" +&
													cs_FLAT_Type_StraightFrameSpreadAxle + "~t" + cs_FLAT_Type_StraightFrameSpreadAxle+ "/" +&
													cs_FLAT_Type_StraightFrameExtendable + "~t" + cs_FLAT_Type_StraightFrameExtendable+ "/" +&
													cs_FLAT_Type_SingleDrop + "~t" + cs_FLAT_Type_SingleDrop+ "/" +&
													cs_FLAT_Type_SingleDropExtendable + "~t" + cs_FLAT_Type_SingleDropExtendable+ "/" +&
													cs_FLAT_Type_DoubleDrop + "~t" + cs_FLAT_Type_DoubleDrop+ "/" +&
													cs_FLAT_Type_DoubleDropExtendable + "~t" + cs_FLAT_Type_DoubleDropExtendable+ "/" +&
													cs_FLAT_Type_LowBoy + "~t" + cs_FLAT_Type_LowBoy+ "/" +&
													cs_FLAT_Type_LandAll + "~t" + cs_FLAT_Type_LandAll+ "/" 						

Constant String	cs_STRT_Type_ValueList = cs_STRT_Type_Dry + "~t" + cs_STRT_Type_Dry+ "/" +&
													cs_STRT_Type_Reefer + "~t" + cs_STRT_Type_Reefer+ "/" 

Constant String	cs_TRLR_Type_ValueList = cs_TRLR_Type_Van + "~t" + cs_TRLR_Type_Van+ "/" +&
													cs_TRLR_Type_AutoDrop + "~t" + cs_TRLR_Type_AutoDrop+ "/" +&
													cs_TRLR_Type_ElectronicsDrop + "~t" + cs_TRLR_Type_ElectronicsDrop+ "/" +&
													cs_TRLR_Type_CurtainSide + "~t" + cs_TRLR_Type_CurtainSide+ "/" +&
													cs_TRLR_Type_RollerBed + "~t" + cs_TRLR_Type_RollerBed+ "/"
													
Constant String	cs_CHAS_Type_ValueList = cs_CHAS_Type_Slider + "~t" + cs_CHAS_Type_Slider+ "/" +&
													cs_CHAS_Type_HeavyHauler + "~t" + cs_CHAS_Type_HeavyHauler+ "/" +&
													cs_CHAS_Type_SuperChassis + "~t" + cs_CHAS_Type_SuperChassis+ "/" +&
													cs_CHAS_Type_Extendable + "~t" + cs_CHAS_Type_Extendable+ "/" +&
													cs_CHAS_Type_8Pin + "~t" + cs_CHAS_Type_8Pin+ "/"

Constant String	cs_CNTN_Type_ValueList = cs_CNTN_Type_ReeferStandard + "~t" + cs_CNTN_Type_ReeferStandard+ "/" +&
													cs_CNTN_Type_ReeferHighCube + "~t" + cs_CNTN_Type_ReeferHighCube+ "/" +&
													cs_CNTN_Type_DryStandard + "~t" + cs_CNTN_Type_DryStandard+ "/" +&
													cs_CNTN_Type_DryHighCube + "~t" + cs_CNTN_Type_DryHighCube+ "/" +&
													cs_CNTN_Type_FlatRack + "~t" + cs_CNTN_Type_FlatRack+ "/" +&
													cs_CNTN_Type_OpenTop + "~t" + cs_CNTN_Type_OpenTop+ "/" +&
													cs_CNTN_Type_OpenSide + "~t" + cs_CNTN_Type_OpenSide+ "/" +&
													cs_CNTN_Type_Vented + "~t" + cs_CNTN_Type_Vented+ "/" +&
													cs_CNTN_Type_Tank + "~t" + cs_CNTN_Type_Tank+ "/" +&
													cs_CNTN_Type_Bulk + "~t" + cs_CNTN_Type_Bulk+ "/" +&
													cs_CNTN_Type_AutoRack + "~t" + cs_CNTN_Type_AutoRack+ "/"

Constant String	cs_REFR_Type_ValueList = cs_REFR_Type_SingleTemp + "~t" + cs_REFR_Type_SingleTemp+ "/" +&
													cs_REFR_Type_MultiTemp + "~t" + cs_REFR_Type_MultiTemp+ "/"

Constant String	cs_DoorType_ValueList = cs_DoorType_Swing + "~t" + cs_DoorType_Swing+ "/" +&
													cs_DoorType_Roll + "~t" + cs_DoorType_Roll+ "/"

Constant String	cs_FloorType_ValueList = cs_FloorType_Wood + "~t" + cs_FloorType_Wood+ "/" +&
													cs_FloorType_Aluminum + "~t" + cs_FloorType_Aluminum+ "/"

Constant String	cs_Construction_ValueList = cs_Construction_Steel + "~t" + cs_Construction_Steel+ "/" +&
													cs_Construction_Aluminum + "~t" + cs_Construction_Aluminum+ "/" +&
													cs_Construction_FRP + "~t" + cs_Construction_FRP+ "/"
													
Constant String	cs_Discharge_ValueList = cs_Discharge_Powered + "~t" + cs_Discharge_Powered+ "/" +&
													cs_Discharge_GravityFeed + "~t" + cs_Discharge_GravityFeed+ "/"

Constant String	cs_AuxiliaryDevice_ValueList = cs_AuxiliaryDevice_PrePass + "~t" + cs_AuxiliaryDevice_PrePass+ "/" +&
													cs_AuxiliaryDevice_FastTrack + "~t" + cs_AuxiliaryDevice_FastTrack+ "/" +&
													cs_AuxiliaryDevice_IMEI + "~t" + cs_AuxiliaryDevice_IMEI+ "/"

Constant String	cs_Tarp_ValueList = cs_Tarp_Full + "~t" + cs_Tarp_Full+ "/" +&
													cs_Tarp_Half + "~t" + cs_Tarp_Half+ "/" +&
													cs_Tarp_Skin + "~t" + cs_Tarp_Skin+ "/"

Constant String	cs_PowerSource_ValueList = cs_PowerSource_Mechanical + "~t" + cs_PowerSource_Mechanical+ "/" +&
													cs_PowerSource_Electric + "~t" + cs_PowerSource_Electric+ "/"

 
//ptequip.pbl(n_cst_ptrailtracemanager)
CONSTANT String cs_RailTraceIniFileName = "railtrace.ini"
 
//ptequip.pbl(w_equip_messagebox)
Constant String cs_unlink = "UNLINK"
Constant String cs_deactivateUnlink = "DEACTIVATEUNLINK"
Constant String cs_changeRef = "CHANGEREF"
 
//ptprprty.pbl(n_cst_syssettings)
CONSTANT String cs_Yes    = "Yes"
CONSTANT String cs_No     = "No"
CONSTANT String cs_Ask    = "Ask"
CONSTANT String cs_AskEachTime = "Ask Each Time"
CONSTANT String cs_AlwaysHide = "Always Hide"
CONSTANT String cs_AlwaysShow = "Always Show"
CONSTANT String cs_All    = "ALL"
CONSTANT String cs_Entry   = "ENTRY"
CONSTANT String cs_AUDIT   = "AUDIT"
CONSTANT String cs_ADMIN   = "ADMIN"
CONSTANT String cs_None    = "NONE"
CONSTANT String cs_PTADMIN   = "PTADMIN"
CONSTANT String cs_Audit_Admin = "AUDIT / ADMIN"
CONSTANT String cs_Item      = "ITEM"
CONSTANT String cs_Freight_AccTotals = "FREIGHT/ACC TOTAL"
CONSTANT String cs_GrandTotal    = "GRAND TOTAL"
CONSTANT String cs_Percentage = "Percentage"
CONSTANT String cs_PerMIle  = "PerMile"
 
//ptpropbs.pbl(u_cst_syssettings_enumerated_cbx)
//Constant String cs_Yes = "Yes"// replace with n_cst_syssettings.cs_yes
//Constant String cs_No = "No"// replace with n_cst_syssettings.cs_No
 
//ptpropnv.pbl(n_cst_setting_accpkgs)
CONSTANT String cs_BusinessWorks   = "BusinessWorks"
CONSTANT String cs_BusinessWorksGold5 = "BusinessWorks Gold 5"
CONSTANT String cs_PeachTree     = "Peachtree"
CONSTANT String cs_QB        = "QuickBooks"
CONSTANT String cs_QB2002Direct   = "QuickBooks 2002 Direct"
CONSTANT String cs_QB2003Direct   = "QuickBooks 2003 Direct"
CONSTANT String cs_Dynamics45     = "Dynamics ver. 4 and 5"
CONSTANT String cs_Dynamics6     = "Dynamics ver. 6"
CONSTANT String cs_Dynamics7     = "Dynamics ver. 7"
CONSTANT String cs_DacEasy      = "DacEasy"
CONSTANT String cs_FlatFileExport   = "Flat File Export"
CONSTANT STring cs_SAP      = "SAP"
 
//ptpropnv.pbl(n_cst_setting_allowrelinking)
Constant String cs_Relink = "Relink"
Constant String cs_Reload = "Reload"
 
//ptpropnv.pbl(n_cst_setting_autoroutedefaulttype)
Constant String cs_Any  = "ANY"
Constant String cs_PickUp = "PICKUP"
Constant String cs_Deliver = "DELIVER"
 
//ptpropnv.pbl(n_cst_setting_billmaniprntorient)
CONSTANT String cs_LandScape  = "Landscape"
CONSTANT String cs_Portrait  = "Portrait"
 
//ptpropnv.pbl(n_cst_setting_crosscheck2nd3rdref)
Constant String cs_Ref1Empty = "Only If Ref1 is Empty"
 
//ptpropnv.pbl(n_cst_setting_dbupdateinprogress)
Constant String cs_Locked = "1"
Constant String cs_Unlocked = "0"
 
//ptpropnv.pbl(n_cst_setting_defaultbatchname)
CONSTANT String cs_Always = "Always"
CONSTANT String cs_Never  = "Never"
 
//ptpropnv.pbl(n_cst_setting_defaultbilltype)
Constant String cs_UnClassified  = "UNCLASSIFIED"
Constant String cs_Prepaid   = "PREPAID"
Constant String cs_Collect   = "COLLECT"
Constant String cs_3RDParty   = "3RD PARTY"
 
//ptpropnv.pbl(n_cst_setting_defaultitinerarybutton)
//CONSTANT String cs_Driver     = "Driver"//replace with n_cst_eventconfirmationoptions.cs_Driver = "DRIVER"
CONSTANT String cs_PowerUnit    = "Power Unit"
CONSTANT String cs_Trailer      = "Trailer/Chassis"
CONSTANT String cs_Container    = "Container"
CONSTANT String cs_3rdpartytrip   = "3rd Party Trip"
 
//ptpropnv.pbl(n_cst_setting_defaultnewshipbutton)
CONSTANT String cs_Dispatch     = "DISPATCH"
CONSTANT String cs_Intermodal    = "INTERMODAL"
CONSTANT String cs_Crossdock     = "CROSSDOCK"
CONSTANT String cs_Nonrouted     = "NONROUTED"
CONSTANT String cs_Brokerage    = "BROKERAGE"
CONSTANT String cs_Nonroutedbrokerage = "NONROUTEDBROKERAGE"
CONSTANT String cs_Template     = "TEMPLATE"
CONSTANT String appeon_cs_3rdpartytrip   = "3RDPARTYTRIP"//replace cs_3rdpartytrip   = "3RDPARTYTRIP"
 
//ptpropnv.pbl(n_cst_setting_edi204version)
//CONSTANT String cs_EDIVersion_Pseudo = "1.0 (pseudo)"    // mcst//replace with n_cst_edishipment_manager. cs_EDIVersion_Pseudo = "1.0 (pseudo)"
CONSTANT String cs_EDIVersion_VanMapping = "2.0 (VAN mapping)"  // Toal WH
//CONSTANT String cs_EDIVersion_DirectWithAutoReply = "3.0 (Direct auto accept)"//replace with n_cst_edishipment_manager.cs_EDIVersion_DirectWithAutoReply = "3.0 (Direct auto accept)"
CONSTANT String cs_EDIVersion_Direct = "4.0 (Direct)"
 
//ptpropnv.pbl(n_cst_setting_eventlistdisplay)
//Constant String cs_Driver = "DRIVER"//replace with n_cst_eventconfirmationoptions.cs_Driver = "DRIVER"
//Constant String cs_Tractor = "TRACTOR"//replace with n_cst_eventconfirmationoptions.cs_Tractor = "TRACTOR"
Constant String cs_Both = "BOTH"
 
//ptpropnv.pbl(n_cst_setting_imagetitlequadrant)
CONSTANT String cs_UpperRight  = "Upper Right"
CONSTANT String cs_UpperLeft = "Upper Left"
CONSTANT String cs_LowerRight  = "Lower Right"
CONSTANT String cs_LowerLeft = "Lower Left"
 
//ptpropnv.pbl(n_cst_setting_invoicebillalign)
CONSTANT String cs_LeftSide  = "Left Side"
CONSTANT String cs_RightSide = "Right Side"
 
//ptpropnv.pbl(n_cst_setting_invoicesize)
CONSTANT String cs_HalfSheet = "Half Sheet"
CONSTANT String cs_FullSheet = "Full Sheet"
 
//ptpropnv.pbl(n_cst_setting_perdiemchargesformat)
Constant String cs_TotalAmount = "Total Amount"
Constant String cs_By_Period  = "By Period"
 
//ptpropnv.pbl(n_cst_setting_settlementsmileagetype)
CONSTANT String cs_Practical   = "Practical"
CONSTANT String cs_Short      = "Short"
CONSTANT String cs_National_Network  = "National Network"
CONSTANT String cs_Avoid_Toll   = "Avoid Toll"
CONSTANT String cs_Air     = "Air"
 
//ptpropnv.pbl(n_cst_setting_shipnoteformat)
CONSTANT String cs_Single   = "One Single Note"
CONSTANT String cs_Individual = "Individual Notes"
 
//ptpropnv.pbl(n_cst_setting_shipprimrefval)
CONSTANT String cs_Open    = "Open"
 
//ptroute.pbl(gc_routing)
constant long cl_RouteType_Practical = 0
constant long cl_RouteType_Shortest = 1
constant long cl_RouteType_National = 2
constant long cl_RouteType_AvoidToll = 3
constant long cl_RouteType_Air = 4
constant long RPT_DETAIL = 0
constant long RPT_STATE = 1
constant long RPT_MILEAGE = 2
constant long STATE_ORDER = 1
constant long TRIP_ORDER = 2
constant long OPTS_NONE = 0   // 0x0000L
constant long OPTS_MILES = 1  // 0x0001L
constant long OPTS_CHANGEDEST = 2 // 0x0002L
constant long OPTS_HUBMODE = 4  // 0x0004L
constant long OPTS_BORDERS = 8  // 0x0008L
constant long OPTS_ALPHAORDER = 16 // 0x0010L
constant long OPTS_ERROR = 65535 // 0xFFFFL
constant long PCMS_INVALIDPTR = 101
constant long PCMS_NOINIFILE = 102
constant long PCMS_LOADINIFILE = 103
constant long PCMS_LOADGEOCODE = 104
constant long PCMS_LOADNETWORK = 105
constant long PCMS_MAXTRIPS = 106
constant long PCMS_INVALIDTRIP = 107
constant long PCMS_INVALIDSERVER = 108
constant long PCMS_BADROOTDIR = 109
constant long PCMS_BADMETANETDIR = 110
constant long PCMS_NOLICENSE = 111
constant long PCMS_TRIPNOTREADY = 112
constant long PCMS_INVALIDPLACE = 113
constant long PCMS_ROUTINGERROR = 114
constant long PCMS_OPTERROR = 115
constant long PCMS_OPTHUB = 116
constant long PCMS_OPT2STOPS = 117
constant long PCMS_OPT3STOPS = 118
constant long PCMS_NOTENOUGHSTOPS = 119
constant long PCMS_BADNETDIR = 120
constant long PCMS_LOADGRIDNET = 121
constant long PCMS_BADOPTIONDIR = 122
constant long PARTIAL_MATCH = 0
constant long EXACT_MATCH = 1
 
//ptroute.pbl(n_cst_routing)
CONSTANT String  cs_Locater_State = "STATE"
CONSTANT String cs_Locater_Zipcode = "ZIPCODE"
CONSTANT String  cs_Locater_City = "CITY"
CONSTANT String  cs_Locater_County = "COUNTY"
CONSTANT String  cs_Locater_Street = "STREET"
 
//ptroute.pbl(tc)
// Some trip related constants
constant long STATE_BOBTAIL = -1
constant long STATE_DEADHEAD = 0
constant long STATE_LOADED = 1
Constant Long STATE_EMPTY = 2
Constant Long STATE_ANY = 3
 
//ptroute.pbl(w_routemanager)
Constant Integer ci_tabpage_Route = 1
Constant Integer  ci_tabpage_Company = 2
Constant Integer  ci_tabpage_Equipment = 3
Constant Integer  ci_tabpage_Zones = 4
 
//ptlink.pbl(n_cst_bso_document_manager)
Constant Integer  ci_Success  =  1
Constant Integer  ci_Failure     = -1
Constant Int  ci_NoAction = 0
CONSTANT STRING cs_TransferMethod_FTP = "FTP"
CONSTANT STRING cs_TransferMethod_Email = "EMAIL"
Constant String cs_Event         = "EVENTCONFIRM"
Constant String cs_ACC           = "ACCESSORIAL"
Constant String cs_AUTHIN     = "AUTHORIZEIN"
Constant String cs_AUTHACCEPT  = "AUTHORIZEACCEPT"
Constant String cs_AUTHDENY     = "AUTHORIZEDENY"
Constant String cs_AUTHOUT = "AUTHORIZEOUT"
Constant String cs_TIR         = "TIRNOTIFICATION"
Constant String cs_LFD          = "LFD"
Constant String cs_SHIPSTAT = "STATUSREQUEST"
Constant String cs_LoadConfirmation = "LOADCONFIRMATION"
 
//ptlink.pbl(n_cst_clipboard)
Constant String  cs_Beo = "BEO" // rdt 3-12-03
Constant String  cs_Text = "TEXT" // rdt 3-12-03
Constant String  cs_Image = "IMAGE" // rdt 3-12-03
 
//ptlink.pbl(n_cst_document)
//Constant Integer  ci_Success      =  1//replace with n_cst_bso_document_manager.ci_Success  =  1
//Constant Integer  ci_Failure         = -1//replace with n_cst_bso_document_manager.ci_Failure     = -1
 
//ptlink.pbl(n_cst_documentsettings)
Constant String cs_TargetDocType = "TARGETDOCTYPE"
Constant String cs_PageCount = "PAGECOUNT"
 
//ptlink.pbl(n_cst_imagingversioncontrol)
CONSTANT Real cr_Version_4 = 4.0
CONSTANT Real cr_Version_7 = 7.0
 
//ptnote.pbl(n_cst_bso_email_manager)
Constant  Int ci_EML_SUCCESS = 1
 
//ptnote.pbl(n_cst_bso_notification_manager)
//Constant string cs_status_Active = 'K'//replace with n_cst_equipmentmanager.cs_status_Active = 'K'
Constant string cs_status_Hidden = 'H'
Constant int ci_status_Pending = 0
Constant int ci_status_Error = -1
Constant int ci_status_NoAddr = -3
Constant int ci_status_Success = 1
 
//ptnote.pbl(n_cst_emailmessage)
CONSTANT String cs_StatusRequest = "STATUSREQUEST"
CONSTANT String cs_AuthorizationReply = "AUTHORIZATIONREPLY"
 
//ptnote.pbl(n_cst_messagedata)
CONSTANT String appeon_cs_ShipmentTemplate = "SHIPMENTTEMPLATE"//replacecs_ShipmentTemplate = "SHIPMENTTEMPLATE"
 
//ptnote.pbl(u_dw_attachimages)
//Constant String cs_Color_Disabled = "78682240"//replace with  u_tab_companydetail.cs_Color_Disabled
 
//ptnote.pbl(u_dw_companycontact_detail)
//Constant String cs_Color_Disabled = "78682240"//replace with  u_tab_companydetail.cs_Color_Disabled
 
//ptedi.pbl(n_cst_bso_edi_manager)
Constant Int ci_MessageStatus_Pending = 0
Constant Int ci_MessageStatus_Processed = 1
Constant Int ci_MessageStatus_Canceled = -2
 
//ptedi.pbl(n_cst_bso_edimanager)
Constant long cl_transaction_set_204 = 204
Constant long cl_transaction_set_214 = 214
Constant long cl_transaction_set_210 = 210
Constant long cl_transaction_set_322 = 322
Constant long cl_transaction_set_990 = 990
Constant long cl_transaction_set_997 = 997
CONSTANT String cs_ShipmentRole_None = "NONE"
CONSTANT String cs_ShipmentRole_Billto = "BILLTO"
CONSTANT String cs_ShipmentRole_Origin = "ORIGIN"
CONSTANT String cs_ShipmentRole_Destination = "DESTINATION"
CONSTANT String cs_ShipmentRole_Carrier = "CARRIER"
CONSTANT String cs_ShipmentRole_Agent = "AGENT"
CONSTANT String cs_ShipmentRole_Forwarder = "FORWARDER"
CONSTANT String cs_ShipmentRole_any = "ANY REFERENCE"
CONSTANT String cs_Action_Arrive = "ARRIVE"
CONSTANT String cs_Action_Depart = "DEPART"
CONSTANT String cs_Action_Schedule = "SCHEDULE"
CONSTANT String cs_Action_Bill = "BILL"
CONSTANT String cs_Action_Pickedup = "PICKEDUP"
CONSTANT String cs_Action_Delivered = "DELIVERED"
CONSTANT String cs_Action_Update = "UPDATE"
CONSTANT STRING cs_transaction_INBOUND = "INBOUND"
CONSTANT STRING cs_transaction_OUTBOUND = "OUTBOUND"
 
//ptedi.pbl(n_cst_bso_edimanager_camir)
CONSTANT String Cs_type_SQLRetrieve = "SQLRETRIEVE"
CONSTANT String Cs_type_TAG = "TAG"
CONSTANT String cs_Type_Literal = "LITERAL"
CONSTANT String Cs_TypeTag_TAG = "^TAG^"
CONSTANT String Cs_TypeTag_SQLRetrieve = "^SQLRETRIEVE^"
CONSTANT String Cs_TypeTag_Literal = "!"
 
//ptedi.pbl(n_cst_edi_transaction)
Constant string cs_transaction_edicache = 'd_edi'
 
//ptedi.pbl(n_cst_ediexportshipmentmanager)
Constant String cs_shipMentStatus_accepted = "A"
//Constant String cs_shipMentStatus_declined = "D"//replace with gc_dispatch.cs_shipMentStatus_declined = "D"
Constant String appeon_cs_shipmentStatus_offered = "O"//replace cs_shipmentStatus_offered = "O"
Constant String cs_gen204Request_original = "O"
Constant String cs_gen204Request_change = "CH"
Constant String cs_gen204Request_Cancel = "C"
Constant String cs_cancelby214_cancel = "CA"
Constant int ci_processed_processed = 1
Constant int ci_processed_pending = 0
Constant int ci_processed_error = -1
 
//ptedi.pbl(n_cst_edishipment_manager)
CONSTANT String cs_EDIVersion_Pseudo = "1.0 (pseudo)"    // mcst
//CONSTANT String cs_EDIVersion_VanMapping = "2.0 (VAN mapping)"  // Toal WH//replace with n_cst_setting_edi204version.cs_EDIVersion_VanMapping = "2.0 (VAN mapping)"
CONSTANT String cs_EDIVersion_DirectWithAutoReply = "3.0 (Direct auto accept)"
//CONSTANT String cs_EDIVersion_Direct = "4.0 (Direct)"//replace with n_cst_setting_edi204version.s_EDIVersion_Direct = "4.0 (Direct)"
Constant String cs_Import = "I"
Constant String cs_Export = "E"
Constant String cs_OneWay = "O"
PUBLIC Constant String cs_SetPurpose_Original = "00"
PUBLIC Constant String cs_SetPurpose_Cancel = "01"
PUBLIC Constant String cs_SetPurpose_Change = "04"
 
//ptedi.pbl(n_cst_edishipment_manager_chrobinson)
Constant String cs_CHRobinsonTLScac = "RBTW"
 
//ptedi.pbl(n_cst_edishipment_manager_chrobinson_int)
Constant String cs_CHRobinsonIntScac = "RBIN"
 
//ptedi.pbl(n_cst_edishipment_manager_evergreen)
Constant String cs_EvergreenScac = "EVERGREEN"
 
//ptedi.pbl(n_cst_edishipment_manager_hubgroup)
Constant String cs_HUBScac = "HUBG"
Constant String cs_PullLoaded = "Pull Loaded from Pickup"
Constant String cs_DropEmpty  = "Drop Empty at Pickup"
Constant String cs_DropLoaded  = "Drop Loaded at Delivery"
Constant String cs_StaywithPickup  = "Stay with Pickup"
Constant String cs_StaywithDelivery  = "Stay with Delivery"
 
//ptedi.pbl(n_cst_edishipment_manager_jb_hunt)
Constant String cs_JBHuntScac = "HJBT"
 
//ptedi.pbl(n_cst_edishipment_manager_maersk)
Constant String cs_MaerskScac = "MAEU"
 
//ptedi.pbl(n_cst_edishipment_manager_nyklogistics)
Constant String cs_NYKLogisticsScac = "GRSF"
Constant String cs_NYKLogisticsScac2 = "NYKT"
 
//ptedi.pbl(n_cst_edishipment_manager_oocl)
Constant String cs_OOCLScac = "OOCLIES"
 
//ptedi.pbl(n_cst_edishipment_manager_preferred)
Constant String cs_PreferredScac = "7323242000"
 
//ptedi.pbl(n_cst_edishipment_manager_tyson_foods)
Constant String cs_Tyson_Foods_SCAC = "006903702"
 
//ptedi.pbl(n_cst_edishipmentreview)
Constant String cs_Accept = "ACCEPT"
Constant String cs_Decline = "DECLINE"
 
//ptmblcom.pbl(n_cst_bso_communication_atroad)
CONSTANT String cs_VEH_LOCN = "VEHICLE_LOCATION"
CONSTANT String cs_INBMESGS = "INBOUND_MESSAGES"
CONSTANT String cs_RESPSTAT = "RESPONSE_STATUS"
CONSTANT String   cs_VEH_LABL = "VEHICLE_LABEL"
CONSTANT String   cs_DRVR_TEXT_MSG = "TEXT_MSSAGE"
CONSTANT String   cs_DRVR_FILL_IN = "FILL_IN"
CONSTANT String   cs_LOC_STAT = "LOCATION_STATUS"
CONSTANT String   cs_COORD_LOCN = "COORDINATE_LOCATION"
CONSTANT String   cs_MSG_TIMESTAMP = "MESSAGE_TIMESTAMP"
CONSTANT String   cs_ADDRS_LOCN = "ADDRESS_LOCATION"
CONSTANT String   cs_COORD_LOCN_LAT = "LATITUDE"
CONSTANT String   cs_COORD_LOCN_LON = "LONGITUDE"
CONSTANT String   cs_MSG_DATE = "MESSAGE_DATE"
CONSTANT String   cs_MSG_TIME = "MESSAGE_TIME"
CONSTANT String   cs_MSG_TZ = "MESSAGE_TIMEZONE"
CONSTANT String   cs_LOCN_DATE = "LOCATION_DATE"
CONSTANT String   cs_LOCN_TIME = "LOCATION_TIME"
CONSTANT String   cs_LOCN_TZ = "LOCATION_TIMEZONE"
CONSTANT String   cs_ADDRS_BLDG = "BUILDING_NUMBER"
CONSTANT String   cs_ADDRS_STRT = "STREET"
CONSTANT String   cs_ADDRS_CITY = "CITY"
CONSTANT String   cs_ADDRS_STATE = "STATE"
CONSTANT String   cs_ADDRS_ZIP = "ZIP"
CONSTANT String   cs_ADDRS_XSTREET = "CROSS_STREET"
CONSTANT String   cs_ADDRS_CTY = "COUNTY"
CONSTANT String   cs_ADDRS_CTRY = "COUNTRY"
CONSTANT String   cs_CUST_LMK = "CUSTOMER_LANDMARK"
CONSTANT String   cs_LOCN_TIMESTAMP = "LOCATION_TIMESTAMP"
CONSTANT String   cs_DRVR_TEXT_MESG = "DRIVER_TEXT_MESSAGE"
CONSTANT String   cs_DRVR_FORM_MESG = "DRIVER_FORM_MESSAGE"
CONSTANT String   cs_FORM_INFO = "FORM_INFORMATION"
CONSTANT String   cs_DRVR_FORM_NAME = "FORM_NAME"
CONSTANT String   cs_FORM_FLD1 = "FORM_FIELD1"
CONSTANT String   cs_FORM_FLD2 = "FORM_FIELD2"
CONSTANT String   cs_FORM_FLD3 = "FORM_FIELD3"
CONSTANT String   cs_FORM_FLD4 = "FORM_FIELD4"
CONSTANT String   cs_FORM_FLD5 = "FORM_FIELD5"
CONSTANT String   cs_FORM_FLD6 = "FORM_FIELD6"
CONSTANT String   cs_FORM_FLD7 = "FORM_FIELD7"
CONSTANT String   cs_FORM_FLD8 = "FORM_FIELD8"
CONSTANT String   cs_FORM_FLD9 = "FORM_FIELD9"
CONSTANT String   cs_FORM_FLD10 = "FORM_FIELD10"
CONSTANT String   cs_INB_MESGS = "INBOUND_MESSAGES"
CONSTANT String   cs_FLEET_LOCN = "FLEET_LOCATIONS"
CONSTANT String   cs_LOCN_REC = "LOCATION_RECORD"
CONSTANT String   cs_LOCN_PARKED = "PARKED"
CONSTANT String   cs_LOCN_MOVING = "MOVING"
CONSTANT String   cs_LOCN_ADRS = "ADDRESS"
CONSTANT String   cs_LOCN_XSTRT = "CROSS_STREET"
CONSTANT String   cs_LOCN_CITY = "CITY"
CONSTANT String   cs_LOCN_STATE = "STATE"
CONSTANT String   cs_LOCN_ZIPC = "ZIP"
CONSTANT String   cs_LOCN_COUNTY = "COUNTY"
CONSTANT String   cs_LOCN_CTRY = "COUNTRY"
CONSTANT String   cs_LOCN_LNDMK = "LANDMARK"
CONSTANT String   cs_OutBound_Stats= "OUTBOUND_MESSAGE"
CONSTANT String   cs_SEND_OPER = "SEND_STATUS"
CONSTANT String   cs_ORIG_MSG = "ORIG_OUTBOUND_MESSAGE"
CONSTANT String   cs_SEND_STATUS = "SEND_MESSAGES_STATUS"
CONSTANT String   cs_OUTB_STAT_MESG = "OUTBOUND_MESSAGE_ACKNOWLEDGEMENT"
CONSTANT String cs_HANDHELD = "HANDHELD"
CONSTANT String cs_ONBOARD = "ONBOARD"
 
//ptmblcom.pbl(n_cst_bso_communication_manager)
CONSTANT String cs_EMPLOYEE = "EMPLOYEE"
//CONSTANT String cs_EQUIPMENT = "EQUIPMENT"//replace with n_cst_restrictioncriteria.cs_Equipment = "EQUIPMENT"

//ptmblcom.pbl(n_cst_bso_communication_qualcomm)
CONSTANT Int  ci_FileFree = 1
CONSTANT Int  ci_FileActive = 2
CONSTANT String  cs_FileFree = "FREE"
CONSTANT String  cs_FileActive = "ACTIVE"
 
//ptmblcom.pbl(w_communication_manager)
Constant Integer  appeon_ci_tabpage_Equipment = 1//replace ci_tabpage_Equipment = 1
Constant Integer  ci_tabpage_Employee = 2
 
//ptmblcom.pbl(w_communication_outbound)
Constant String cs_Template_Directions = "directns.doc"
 
//ptsetlwn.pbl(w_settlementbatchmanager)
Constant string  cs_newbatch_cache = 'd_driverlist_nobatch'
Constant string  cs_oldbatch_cache = 'd_driverlist_batch'
Constant string cs_request_incremental = 'INCREMENTAL'
Constant string cs_request_repair     = 'REPAIR'
 
//ptsetlwn.pbl(w_transactionmanager)
Constant Integer ci_tabpage_transactions = 1
Constant Integer  ci_tabpage_amounts = 2
Constant Integer  ci_tabpage_unassignedamounts = 3
 
//ptbillnv.pbl(n_cst_accountingdata)
constant string cs_payables='PAYABLES'
constant string cs_payroll='PAYROLL'
constant string cs_mixed="MIXED"
constant string cs_receivables="RECEIVABLES"
 
//ptbillnv.pbl(n_cst_acctlink_quickbooks_direct)
Constant Integer ci_roeContinue = 1
Constant Integer ci_Locking_DontCare = 2
Constant String        cs_PT_Company_Name = "Profit Tools"
Constant String cs_QBAppId_ProfitTools = ""
 
//ptbillnv.pbl(n_cst_batchsrv_sap)
Constant String cs_LINETYPE_DH = "DH"
Constant String cs_LINETYPE_DL_CUSTOMER = "DLD"
Constant String cs_LINETYPE_DL_GL = "DLS"
Constant String cs_LINETYPE_BH = "BH"
Constant String cs_STATUS_MANDATORY = "M"
Constant String cs_STATUS_OPTIONAL = "O"
Constant String cs_STATUS_FUTUREUSE = "F"
Constant String cs_STATUS_NA = "S"
Constant String cs_FIELD_RecordType = "RecordType"
Constant String cs_FIELD_DocumentDate = "DocumentDate"
Constant String cs_FIELD_DocumentType = "DocumentType"
Constant String cs_FIELD_Company = "Company"
Constant String cs_FIELD_PostingDate = "PostingDate"
Constant String cs_FIELD_Period = "Period"
Constant String cs_FIELD_Currency = "Currency"
Constant String cs_FIELD_ExchangeRate = "ExchangeRate"
Constant String cs_FIELD_DocumentNumber = "DocumentNumber"
Constant String cs_FIELD_TranslationDate = "TranslationDate"
Constant String cs_FIELD_ReferenceNumber = "ReferenceNumber"
Constant String cs_FIELD_DocHeaderText = "DocHeaderText"
Constant String cs_FIELD_Reserved = "Reserved"
Constant String cs_FIELD_LineNumber = "LineNumber"
Constant String cs_FIELD_LineType = "LineType"
Constant String cs_FIELD_PostingKey = "PostingKey"
Constant String cs_FIELD_NewCompany = "NewCompany"
Constant String cs_FIELD_Account = "Account"
Constant String cs_FIELD_GLIndecator = "GLIndecator"
Constant String cs_FIELD_TransactionType = "TransactionType"
Constant String cs_FIELD_DocumentAmount = "DocumentAmount"
Constant String cs_FIELD_LCAmount = "LCAmount"
Constant String cs_FIELD_BusinessArea = "BusinessArea"
Constant String cs_FIELD_Dpt = "Dpt"
Constant String cs_FIELD_Svc = "Svc"
Constant String cs_FIELD_Vsl = "Vsl"
Constant String cs_FIELD_Voyage = "Voyage"
Constant String cs_FIELD_D = "D"
Constant String cs_FIELD_YY = "YY"
Constant String cs_FIELD_MM = "MM"
Constant String cs_FIELD_Allocation = "Allocation"
Constant String cs_FIELD_LineItemText = "LineItemText"
Constant String cs_FIELD_ValueDate = "ValueDate"
Constant String cs_FIELD_Taxcode = "Taxcode"
Constant String cs_FIELD_PmntTerms = "PmntTerms"
Constant String cs_FIELD_PmntMethod = "PmntMethod"
Constant String cs_FIELD_PmntBlock = "PmntBlock"
Constant String cs_FIELD_CollectInvoice = "CollectInvoice"
Constant String cs_FIELD_HouseBank = "HouseBank"
Constant String cs_FIELD_PartnerBank = "PartnerBank"
Constant String cs_FIELD_WhTaxCode = "WhTaxCode"
Constant String cs_FIELD_WhTaxBaseAmount = "WhTaxBaseAmount"
Constant String cs_FIELD_CustName = "CustName"
Constant String cs_FIELD_CustCity = "CustCity"
 
//ptbillnv.pbl(n_cst_edi_export_transportgold)
CONSTANT String cs_Mark = "\"
CONSTANT Long  cl_InvoiceLen = 15
CONSTANT Long  cl_TPLen = 15
CONSTANT Long  cl_BLLen = 15
CONSTANT Long  cl_POLen = 6
CONSTANT Long  cl_QTYLen = 6
CONSTANT Long  cl_WTLen = 5
CONSTANT Long  cl_ChargesLen = 9
CONSTANT Long  cl_EquipLen = 10
CONSTANT Long  cl_LocCodeLen = 20
CONSTANT Long  cl_NameLen = 20
CONSTANT Long  cl_AddLen = 20
CONSTANT Long  cl_StateLen = 2
CONSTANT Long  cl_ZipLen = 9
CONSTANT Long  cl_CityLen = 15
CONSTANT Long  cl_DescLen = 20
CONSTANT Long  cl_BillRateQtyLen = 9
CONSTANT Long  cl_NMFCLen = 7
CONSTANT Long  cl_FreightLen = 7
 
//ptbillnv.pbl(n_cst_invoicemanager)
Constant string cs_Invoicetype_PSR = "PSR"
Constant string cs_Invoicetype_WordDoc = "WORDDOC"
Constant string cs_Invoicetype_XlsDoc = "XLSDOC"
Constant string cs_InvoiceType_EMAILABLE_PSR = "EMAILABLE_PSR"
Constant string cs_InvoiceType_PSR_Manifest = "PSR_MANIFEST"
Constant string cs_InvoiceType_Emailable_PSR_Manifest = "EMAILABLE_PSR_MANIFEST"
 
//ptbillwn.pbl(w_shiptype_manager)
CONSTANT INT ci_TabPage_Details = 1
CONSTANT INT ci_TabPage_ARMap = 2
CONSTANT INT ci_TabPage_AcctMap = 3
 
//ptsetl.pbl(u_event_bracketing)
Constant String cs_lock_button_text = "&Lock"
Constant String cs_unlock_button_text = "Un&lock"
Constant String cs_showitem_button_text = "Show &Item"
Constant String cs_hideitem_button_text = "Hide &Item"
 
//ptsetlnv.pbl(n_cst_beo_amountowed)
Constant Integer ci_Status_Open = 0
Constant Integer ci_Status_Authorized = 1
Constant Integer ci_Status_AuditRequired = 2
Constant Integer ci_Status_Audited = 3
Constant Integer ci_Status_Hold = 4
Constant Integer ci_Status_History = 5
Constant String appeon_2_cs_Status_ValueList = "OPEN~t0/AUTHORIZED~t1/AUDIT REQ.~t2/AUDITED~t3/HOLD~t4/HISTORY~t5/"//replace cs_Status_ValueList
 		
//ptsetlnv.pbl(n_cst_beo_amounttemplate)
Constant Integer ci_IntervalType_None = 0
Constant Integer ci_IntervalType_Every = 1
Constant Integer ci_IntervalType_On = 2
Constant String cs_IntervalType_ValueList = "[NONE]~t0/EVERY __ DAYS~t1/ON __ DAY(S)~t2/"
Constant Integer ci_Type_All = 0
Constant Integer ci_Type_Point_to_point = 1
Constant Integer ci_Type_Shipment = 2
Constant Integer ci_Type_Move = 3
Constant Integer ci_Type_DateRange = 4
Constant Integer ci_Type_Day = 5
Constant Integer ci_Type_Leg = 6
Constant Integer ci_Type_Periodic = 7
Constant Integer ci_Type_FuelSurcharge = 8
Constant String cs_Type_ValueList = "POINT-TO-POINT~t1/SHIPMENT~t2/MOVE~t3/DATE RANGE ~t4/DAY~t5/LEG~t6/PERIODIC~t7/FUEL SURCHARGE~t8"
 
//ptsetlnv.pbl(n_cst_beo_amounttype)
Public Constant Integer ci_TypicalAmount_Either = 0
Public Constant Integer ci_TypicalAmount_Positive = 1
Public Constant Integer ci_TypicalAmount_Negative = 2
 
//ptsetlnv.pbl(n_cst_beo_transaction)
Constant Integer ci_Type_Settlement = 1
Constant String appeon_cs_Type_ValueList = "SETTLEMENT~t1/"//replace cs_Type_ValueList = "SETTLEMENT~t1/"
//Constant Integer ci_Status_Open = 0//replace with n_cst_beo_amountowed.ci_Status_Open
//Constant Integer ci_Status_Authorized = 1//replace with n_cst_beo_amountowed.ci_Status_Authorized
//Constant Integer ci_Status_AuditRequired = 2//replace with n_cst_beo_amountowed.ci_Status_AuditRequired
//Constant Integer ci_Status_Audited = 3//replace with n_cst_beo_amountowed.ci_Status_Audited
//Constant Integer ci_Status_Hold = 4//replace with n_cst_beo_amountowed.ci_Status_Hold
//Constant Integer ci_Status_History = 5//replace with n_cst_beo_amountowed.ci_Status_History
Constant Integer ci_Status_Failed=6
Constant String appeon_cs_Status_ValueList = "OPEN~t0/AUTHORIZED~t1/AUDIT REQ.~t2/AUDITED~t3/HOLD~t4/HISTORY~t5/FAILED~t6/"//replace cs_Status_ValueList = "OPEN~t0/AUTHORIZED~t1/AUDIT REQ.~t2/AUDITED~t3/HOLD~t4/HISTORY~t5/FAILED~t6/"


//ptsetlnv.pbl(n_cst_bso_fueltax)
Public CONSTANT String cs_Context_HistoryReport = "HISTORYREPORT"
Public CONSTANT String cs_Context_FuelTax = "FUELTAX"
Public CONSTANT String cs_Context_StateBreakdown = "PRETAX"
 
//ptsetlnv.pbl(n_cst_bso_transactionmanager)
Constant String cs_TagKey_Optional = "Optional"
Constant String cs_Loaded_AllTransactions = "AT"
Constant String cs_Loaded_OpenTransactions = "OT"
Constant String cs_Loaded_Transactions = "TR"
Constant String cs_Loaded_UnbatchedTransactions = "UT"
Constant String cs_Loaded_UnassignedAmounts = "UA"
Constant String cs_Loaded_TransactionAmounts = "TA"
Constant String cs_Loaded_Entities = "EN"
 
//ptsetlnv.pbl(n_cst_presentation_amounttype)
integer ii_category=3//replace ii_category=n_cst_constants.ci_category_both
 
//ptrating.pbl(n_cst_bso_rating)
Constant  String cs_RateUnit_Flat = "FLAT"
Constant  String cs_RateUnit_Pound = "POUND"
Constant  String cs_RateUnit_100Pound = "CWT"
Constant  String cs_RateUnit_Ton = "TON"
Constant  String cs_RateUnit_Piece = "PIECE"
Constant  String cs_RateUnit_PerMile = "MILE"
Constant  String cs_RateUnit_PerUnit = "UNIT"
Constant  String cs_RateUnit_Gallon = "GALLON"
Constant  String cs_RateUnit_Class = "CLASS"
Constant  String cs_RateUnit_Minimum = "MINIMUM"
Constant  String cs_RateUnit_Maximum = "MAXIMUM"
Constant  String cs_RateUnit_None = "NONE"
Constant  String cs_RateUnit_Code_Pound = "1"
Constant  String cs_RateUnit_Code_100Pound = "2"
Constant  String cs_RateUnit_Code_Ton = "3"
Constant  String cs_RateUnit_Code_Piece = "4"
Constant  String cs_RateUnit_Code_Gallon ="5"
Constant  String cs_RateUnit_Code_None = "Z"
Constant  String cs_RateUnit_Code_Flat = "F"
Constant  String cs_RateUnit_Code_Class = "C"
Constant  String cs_RateUnit_Code_PerMile = "M"
Constant  String cs_RateUnit_Code_PerUnit = "U"
Constant  String cs_RateUnit_Code_Minimum = "N"
Constant  String cs_RateUnit_Code_Maximum = "X"
Constant String cs_CodenameList_Stopoff = "STOPOFF"
Constant String cs_CodenameList_ChassisSplit = "CHASSISSPLIT"
Constant String cs_CodenameList_SearchOrder = "SEARCHORDER"
CONSTANT Long cl_itemfreight_list = 123
CONSTANT Long cl_chassissplit_list = 124
CONSTANT Long cl_stopoff_list = 125
CONSTANT Long cl_FuelSurcharge_list = 140
CONSTANT Long cl_PerDiem_list = 141
CONSTANT Long cl_AutoCreatedAccessorialCharge_list = 196
CONSTANT Long cl_BobTail_list = 254
CONSTANT String cs_itemfreight_list = 'Freight Items'
CONSTANT String cs_chassissplit_list = 'Chassis Pickup/Return'
CONSTANT String cs_stopoff_list = 'Stopoff'
CONSTANT String cs_custom_list = 'Custom'
CONSTANT String cs_FuelSurcharge_list = 'Fuel Surcharge'
CONSTANT String cs_PerDiem_list = 'Per Diem'
CONSTANT String cs_AutoCreatedAccessorialCharge_list = 'Auto Added Charges'
CONSTANT String cs_BobTail_list = 'Bobtail item'
 
//ptrating.pbl(n_cst_bso_zonemanager)
Constant integer ci_locationtype_site = 1
Constant integer ci_locationtype_zip = 2
Constant integer ci_locationtype_citystate = 3
Constant integer ci_locationtype_state = 4
Constant string cs_locationtype_site = "SITE"
Constant string cs_locationtype_zip = "ZIP"
//Constant string cs_locationtype_citystate = "CITY STATE"
Constant string cs_locationtype_state = "STATE"
 
//ptrating.pbl(n_cst_importrating)
Constant int ci_verifyNewTableMode = 1
Constant int ci_verifyUpdateRatesMode = 2
 
//ptrating.pbl(w_importrateing)
Constant int ci_NewTableMode = 1    //rate, ratetable, ratelinkbillable, ratelinkdestzone, ratelinkorigzone
Constant int ci_CompanyOverride = 2   //rate, ratelinkbillable, ratelinkdestzone, ratelinkorigzone
Constant int ci_RatesOnly = 3
 
//ptlog.pbl(gc_logs)
Constant String cs_Status_Unknown = "0"
Constant String cs_Status_OffDuty = "1"
Constant String cs_Status_Sleeper = "2"
Constant String cs_Status_Driving = "3"
Constant String cs_Status_OnDuty = "4"
Constant String cs_Status_Lost = "5"
Constant String cs_Status_AirRadius = "6"
Constant String cs_Status_Startup = "7"
Constant String cs_Status_New = "8"
Constant Integer ci_ViolationType_Other = 0
Constant Integer ci_ViolationType_DrivingTime = 1
Constant Integer ci_ViolationType_DutyTime = 2
Constant Integer ci_ViolationType_WeeklyTime = 3
Constant Integer ci_ViolationType_MPH = 4
Constant Integer ci_ViolationType_Receipts = 5
Constant Integer ci_ViolationType_Documentation = 6
Constant Integer ci_ViolationType_LostLog = 7
Constant Integer ci_ViolationType_AirRadius = 8
 
//ptwininet.pbl(n_cst_wininet_ftp)
CONSTANT uint FTP_TRANSFER_TYPE_ASCII  = 1
CONSTANT uint FTP_TRANSFER_TYPE_BINARY = 2
CONSTANT uint InternetConnect_Passive = 32768
 
//pfcapsrv.pbl(pfc_n_cst_color)
constant long BUTTONFACE =  78682240
constant long WINDOW_BACKGROUND = 1087434968
constant long WINDOW_TEXT = 33554592
constant long APPLICATION_WORKSPACE = 268435456
constant long TRANSPARENT = 553648127
constant long BLACK = RGB(0, 0, 0)
constant long WHITE = RGB(255, 255, 255)
constant long LIGHT_GRAY = RGB(192, 192, 192)
constant long DARK_GRAY = RGB(128, 128, 128)
constant long RED = RGB(255, 0, 0)
constant long DARK_RED = RGB(128, 0, 0)
constant long GREEN = RGB(0, 255, 0)
constant long DARK_GREEN = RGB(0, 128, 0)
constant long BLUE = RGB(0, 0, 255)
constant long DARK_BLUE = RGB(0, 0, 128)
constant long MAGENTA = RGB(255, 0, 255)
constant long DARK_MAGENTA = RGB(128, 0, 128)
constant long CYAN = RGB(0, 255, 255)
constant long DARK_CYAN = RGB(0, 128, 128)
constant long YELLOW = RGB(255, 255, 0)
constant long BROWN = RGB(128, 128, 0)
 
//pfcapsrv.pbl(pfc_n_cst_dropdown)
Constant Integer DWSTYLE_BOX = 1
Constant Integer DWSTYLE_SHADOWBOX = 2
Constant Integer DWSTYLE_LOWERED = 3
Constant Integer DWSTYLE_RAISED = 4
Constant Integer STYLE_BOX = 5
Constant Integer STYLE_SHADOWBOX = 6
Constant Integer STYLE_LOWERED = 7
Constant Integer STYLE_RAISED = 8
Constant Integer DW_HSPLITBAR_WIDTH = 9
Constant Integer TAB_BORDER = 10
Constant Integer MISC_XPOSITION = 11
Constant Integer MISC_YPOSITION = 12
Constant Integer DWMISC_XPOSITION = 13
Constant Integer DWMISC_YPOSITION = 14
Constant Integer DWDETAIL_HEIGHT = 15
Constant Integer BORDER_CHECK = 16
 
//pfcapsrv.pbl(pfc_n_cst_dwcache)
// -- Style Constants.
Constant String appeon_RETRIEVE = 'retrieve'//replace RETRIEVE = 'retrieve'
Constant String DATAOBJECTDATA = 'dataobjectdata'
Constant String POWEROBJECT = 'powerobject'
Constant String DATAWINDOWCONTROL = 'datawindowcontrol'
Constant String DATASTORECONTROL = 'datastorecontrol'
Constant String IMPORTFILE = 'importfile'
Constant String SQL = 'sql'
// -- Other Internal Constants.
Constant String EMPTY = ''
// Obsoleted Constants.
Constant String ics_retrieve = 'retrieve'  // Obsoleted in 6.0
Constant String ics_dataobjectdata = 'dataobjectdata' // Obsoleted in 6.0
Constant String ics_powerobject = 'powerobject' // Obsoleted in 6.0
 
//pfcapsrv.pbl(pfc_n_cst_error)
// Style constants.
constant integer DEFAULT=0
constant integer PFCWINDOW=1
// Log Style constants.
constant integer TAB_DELIMITED = 1
constant integer NEWLINE_DELIMITED = 2
// Pre-defined message constants.
constant string DATABASE='database'
constant string FILE='file'
constant string ics_database='database'    // Obsoleted in 6.0
constant string ics_file='file'  // Obsoleted in 6.0
 
//pfcapsrv.pbl(pfc_n_cst_luw)
Constant String ALL_OBJECTS = ''
 
//pfcapsrv.pbl(pfc_n_cst_lvsrv_datasource)
Constant String UNDO_EDIT = "Edit"
Constant String UNDO_INSERT = "Insert"
Constant String UNDO_DELETE = "Delete"
Constant String CACHE_ID = "pfc listview"
 
//pfcapsrv.pbl(pfc_n_cst_nodecomparebase)
// Comparison return value constants.
constant integer EQUAL = 0
constant integer LESSTHAN = 1
constant integer GREATERTHAN = 2
 
//pfcapsrv.pbl(pfc_n_cst_security)
Constant String INVISIBLE = 'I'
Constant String ENABLE = 'E'
Constant String DISABLE = 'D'
Constant String NOTSET = ''
 
//pfcapsrv.pbl(pfc_n_cst_tmgmultiple)
constant integer TRIGGEREVENT = 0
constant integer POSTEVENT = 1
 
//pfcapsrv.pbl(pfc_n_cst_tmgsingle)
//constant integer TRIGGEREVENT = 0//replace with pfc_n_cst_tmgmultiple.TRIGGEREVENT
//constant integer POSTEVENT = 1//replace with pfc_n_cst_tmgmultiple.POSTEVENT
 
//pfcapsrv.pbl(pfc_n_cst_tvsrv_levelsource)
//- UpdateStyle Constants:
constant  integer TOPDOWN =1
constant  integer BOTTOMUP =2
constant  integer TOPDOWN_BOTTOMUP =3
constant  integer BOTTOMUP_TOPDOWN =4
constant  integer CUSTOM =101
//- Delete Style Constants:
Constant Integer DELETE_ROWS  = 0
Constant Integer DISCARD_ROWS = 1
//- Undo Style Constants
//Constant String UNDO_EDIT = "Edit"//replace with pfc_n_cst_lvsrv_datasource.UNDO_EDIT
//Constant String UNDO_INSERT = "Insert"//replace with pfc_n_cst_lvsrv_datasource.UNDO_INSERT
//Constant String UNDO_DELETE = "Delete"//replace with pfc_n_cst_lvsrv_datasource.UNDO_DELETE
Constant String appeon_CACHE_ID = "level"//replace CACHE_ID = "level"
 
//pfcdwsrv.pbl(pfc_n_cst_dssrv)
// Note: The constant DEFAULT=0 is used in descendants.
//constant integer DEFAULT = 0//replace with pfc_n_cst_error.DEFAULT
constant integer DBNAME =1
constant integer HEADER = 2
 
//pfcdwsrv.pbl(pfc_n_cst_dwsrv)
// Note: The constant DEFAULT=0 is used in descendants.
//constant integer DEFAULT = 0 //replace with pfc_n_cst_error.DEFAULT
//constant integer DBNAME =1//replace with pfc_n_cst_dssrv.DBNAME
//constant integer HEADER = 2//replace with pfc_n_cst_dssrv.HEADER
 
//pfcdwsrv.pbl(pfc_n_cst_dwsrv_filter)
// Defined in ancestor - constant integer DEFAULT = 0
constant integer EXTENDED = 1
constant integer SIMPLE = 2
 
//pfcdwsrv.pbl(pfc_n_cst_dwsrv_linkage)
//- LinkageStyle Constants:
constant  integer FILTER =1
constant  integer RETRIEVE =2
constant  integer SCROLL =3
//- UpdateStyle Constants:
//constant  integer TOPDOWN =1//replace with pfc_n_cst_tvsrv_levelsource.TOPDOWN
//constant  integer BOTTOMUP =2//replace with pfc_n_cst_tvsrv_levelsource.BOTTOMUP
//constant  integer TOPDOWN_BOTTOMUP =3//replace with pfc_n_cst_tvsrv_levelsource.TOPDOWN_BOTTOMUP
//constant  integer BOTTOMUP_TOPDOWN =4//replace with pfc_n_cst_tvsrv_levelsource.BOTTOMUP_TOPDOWN
//constant  integer CUSTOM =101//replace with pfc_n_cst_tvsrv_levelsource.CUSTOM
//- DetailDelete Style Constants:
// defined in ancestor constant  integer DEFAULT =0
constant  integer appeon_DELETE_ROWS =1//replace DELETE_ROWS =1
constant  integer appeon_DISCARD_ROWS =2//replace DISCARD_ROWS = 2
 
//pfcdwsrv.pbl(pfc_n_cst_dwsrv_resize)
// Predefined resize constants.
//Constant String FIXEDRIGHT =  'FixedToRight'//replace with pfc_n_cst_resize.FIXEDRIGHT
//Constant String FIXEDBOTTOM = 'FixedToBottom'//replace with pfc_n_cst_resize.FIXEDBOTTOM
//Constant String FIXEDRIGHTBOTTOM = 'FixedToRight&Bottom'//replace with pfc_n_cst_resize.FIXEDRIGHTBOTTOM
//Constant String SCALE = 'Scale'//replace with pfc_n_cst_resize.SCALE
//Constant String SCALERIGHT = 'ScaleToRight'//replace with pfc_n_cst_resize.SCALERIGHT
//Constant String SCALEBOTTOM = 'ScaleToBottom'//replace with pfc_n_cst_resize.SCALEBOTTOM
//Constant String SCALERIGHTBOTTOM = 'ScaleToRight&Bottom'//replace with pfc_n_cst_resize.SCALERIGHTBOTTOM
//Constant String FIXEDRIGHT_SCALEBOTTOM = 'FixedToRight&ScaleToBottom'//replace with pfc_n_cst_resize.FIXEDRIGHT_SCALEBOTTOM
//Constant String FIXEDBOTTOM_SCALERIGHT = 'FixedToBottom&ScaleToRight'//replace with pfc_n_cst_resize.FIXEDBOTTOM_SCALERIGHT
//constant string LINE='line'//replace with pfc_n_cst_resize.LINE
//constant string EMPTY='' //replace with pfc_n_cst_dwcache.EMPTY
 
//pfcdwsrv.pbl(pfc_n_cst_dwsrv_rowselection)
//Style constants:
constant integer SINGLE =0
constant integer MULTIPLE =1
constant integer appeon_EXTENDED =2//replace EXTENDED =2
 
//pfcdwsrv.pbl(pfc_n_cst_dwsrv_sort)
// Style constants.
// Defined in ancestor - constant integer DEFAULT = 0
constant integer DRAGDROP = 1
//constant integer SIMPLE = 2//replace with pfc_n_cst_dwsrv_filter.SIMPLE
constant integer DROPDOWNLISTBOX = 3
 
//pfcdwsrv.pbl(pfc_w_sortsingle)
constant string appeon_NONE='[None]'//replace NONE='[None]'
constant string ics_none='[None]'  // Obsoleted in 6.0
 
//pfcmain.pbl(pfc_n_base)
// - Common return value constants:
constant integer   SUCCESS = 1
constant integer   FAILURE = -1
constant integer   NO_ACTION = 0
// - Continue/Prevent return value constants:
constant integer   CONTINUE_ACTION = 1
constant integer   PREVENT_ACTION = 0
//constant integer   FAILURE = -1
 
//pfcmain.pbl(pfc_n_ds)
// - Common return value constants:
//constant integer   SUCCESS = 1//replace with pfc_n_base.SUCCESS
//constant integer   FAILURE = -1//replace with pfc_n_base.FAILURE
//constant integer   NO_ACTION = 0//replace with pfc_n_base.NO_ACTION
// - Continue/Prevent return value constants:
//constant integer   CONTINUE_ACTION = 1//replace with pfc_n_base.CONTINUE_ACTION
//constant integer   PREVENT_ACTION = 0//replace with pfc_n_base.PREVENT_ACTION
//constant integer   FAILURE = -1//replace with pfc_n_base.PREVENT_ACTION
 
//pfcmain.pbl(pfc_u_base)
// - Common return value constants:
//constant integer   SUCCESS = 1//replace with pfc_n_base.SUCCESS
//constant integer   FAILURE = -1//replace with pfc_n_base.FAILURE
//constant integer   NO_ACTION = 0//replace with pfc_n_base.NO_ACTION
// - Continue/Prevent return value constants:
//constant integer   CONTINUE_ACTION = 1//replace with pfc_n_base.CONTINUE_ACTION
//constant integer   PREVENT_ACTION = 0//replace with pfc_n_base.PREVENT_ACTION
//constant integer   FAILURE = -1
 
//pfcmain.pbl(pfc_u_calculator)
// Datawindow Register ColumnStyle constants.
constant integer NONE = 1
constant integer DDLB = 2
constant integer DDLB_WITHARROW = 3
//constant string EMPTY = ''//replace with pfc_n_cst_dwcache.EMPTY
 
//pfcmain.pbl(pfc_u_calendar)
//constant integer NONE = 1//replace with pfc_u_calculator.NONE
//constant integer DDLB = 2//replace with pfc_u_calculator.DDLB
//constant integer DDLB_WITHARROW = 3//replace with pfc_u_calculator.DDLB_WITHARROW
 
//pfcmain.pbl(pfc_u_dw)
// - Common return value constants:
//constant integer   SUCCESS = 1//replace with pfc_n_base.SUCCESS
//constant integer   FAILURE = -1//replace with pfc_n_base.FAILURE
//constant integer   NO_ACTION = 0//replace with pfc_n_base.NO_ACTION
// - Continue/Prevent return value constants:
//constant integer   CONTINUE_ACTION = 1//replace with pfc_n_base.CONTINUE_ACTION
//constant integer   PREVENT_ACTION = 0//replace with pfc_n_base.PREVENT_ACTION
//constant integer   FAILURE = -1

//pfcmain.pbl(pfc_u_lvs)
//Constant Integer CONTINUE_ACTION = 1//replace with pfc_n_base.CONTINUE_ACTION
//Constant Integer PREVENT_ACTION = 0//replace with pfc_n_base.PREVENT_ACTION
//Constant Integer NO_ACTION = 0//replace with pfc_n_base.NO_ACTION
Constant String INSERT_FIRST = "first"
Constant String INSERT_LAST = "last"
Constant String INSERT_BEFORE = "before"
Constant String INSERT_AFTER = "after"
 
//pfcmain.pbl(pfc_u_progressbar)
constant integer BAR = 0
constant integer PCTCOMPLETE = 1
constant integer POSITION = 2
constant integer MSGTEXT = 3
constant integer LEFTRIGHT = 0
constant integer RIGHTLEFT = 1
constant integer appeon_TOPDOWN = 2//replace TOPDOWN = 2
constant integer appeon_BOTTOMUP = 3//replace BOTTOMUP = 2
 
//pfcmain.pbl(pfc_u_st_splitbar)
constant integer VERTICAL = 1
constant integer HORIZONTAL = 2
constant integer LEFT=1
constant integer RIGHT=2
constant integer ABOVE=3
constant integer BELOW=4
//-- Define the "Extreme points" constants. --
constant integer LEFTMOST=1
constant integer RIGHTMOST=2
constant integer TOPMOST=3
constant integer BOTTOMMOST=4
constant integer UNITIALIZED = -32000
 
//pfcmain.pbl(pfc_u_tab)
// - Common return value constants:
//constant integer   SUCCESS = 1//replace with pfc_n_base.SUCCESS
//constant integer   FAILURE = -1//replace with pfc_n_base.FAILURE
//constant integer   NO_ACTION = 0//replace with pfc_n_base.NO_ACTION
// - Continue/Prevent return value constants:
//constant integer   CONTINUE_ACTION = 1//replace with pfc_n_base.CONTINUE_ACTION
//constant integer   PREVENT_ACTION = 0//replace with pfc_n_base.PREVENT_ACTION
//constant integer   FAILURE = -1 
 
//pfcmain.pbl(pfc_u_tvs)
//Constant Integer CONTINUE_ACTION = 1//replace with pfc_n_base.CONTINUE_ACTION
//Constant  Integer PREVENT_ACTION = 0//replace with pfc_n_base.PREVENT_ACTION
//Constant Integer NO_ACTION = 0//replace with pfc_n_base.NO_ACTION
// constants for inserting a item
//Constant  String INSERT_FIRST = "first"//replace with pfc_u_lvs.INSERT_FIRST
//Constant  String INSERT_LAST = "last"//replace with pfc_u_lvs.INSERT_LAST
Constant  String INSERT_SORT = "sort"
//Constant  String INSERT_AFTER = "after"//replace with pfc_u_lvs.INSERT_AFTER
// constants for finding a value
Constant  String FIND_LABEL = "label"
Constant  String FIND_DATA = "data"
 
//pfcmain.pbl(pfc_w_master)
// - Common return value constants:
//constant integer   SUCCESS = 1//replace with pfc_n_base.SUCCESS
//constant integer   FAILURE = -1//replace with pfc_n_base.FAILURE
//constant integer   NO_ACTION = 0//replace with pfc_n_base.NO_ACTION
// - Continue/Prevent return value constants:
//constant integer   CONTINUE_ACTION = 1//replace with pfc_n_base.CONTINUE_ACTION
//constant integer   PREVENT_ACTION = 0//replace with pfc_n_base.PREVENT_ACTION
//constant integer   FAILURE = -1
 
//pfcutil.pbl(pfc_n_cst_debug)
constant integer PFC_MAJOR = 6
constant integer PFC_MINOR = 5
constant integer PFC_FIXES = 0
constant string PFC_NAME = "PowerBuilder Foundation Classes"
constant date PFC_BUILD_DATE = Today()
constant time PFC_BUILD_TIME = Now()
// Old constants
constant integer ici_pfcmajorrevision = 6 // Obsoleted in 6.0
constant integer ici_pfcminorrevision = 0 // Obsoleted in 6.0
constant integer ici_pfcfixesrevision = 1 // Obsoleted in 6.0
constant string ics_pfc = "PowerBuilder Foundation Classes" // Obsoleted in 6.0
constant date icd_build = Today()  // Obsoleted in 6.0
constant time ictm_build = Now()  // Obsoleted in 6.0
 
//pfcutil.pbl(pfc_u_tabpg_dwproperty_services)
// Enable/Disable constants.
constant string SERVICE_ENABLED  ='Y'
constant string SERVICE_DISABLED ='N'
// PFC objects/services constants.
constant integer DDCALCULATOR =1
constant integer DDCALENDAR =2
constant integer  DDSEARCH =3
constant integer appeon_FILTER =4//replace  FILTER =4
constant integer  FIND =5
constant integer  LINKAGE =6
constant integer MULTITABLE =7
constant integer  PRINTPREVIEW =8
constant integer QUERYMODE =9
constant integer REPORT =10
constant integer  REQCOLUMN =11
constant integer  RESIZE =12
constant integer  ROWMANAGER =13
constant integer  ROWSELECT =14
constant integer  SORT=15
 
//pfcwnsrv.pbl(pfc_n_cst_resize)
// Predefined resize constants.
Constant String FIXEDRIGHT =  'FixedToRight'
Constant String FIXEDBOTTOM = 'FixedToBottom'
Constant String FIXEDRIGHTBOTTOM = 'FixedToRight&Bottom'
Constant String SCALE = 'Scale'
Constant String SCALERIGHT = 'ScaleToRight'
Constant String SCALEBOTTOM = 'ScaleToBottom'
Constant String SCALERIGHTBOTTOM = 'ScaleToRight&Bottom'
Constant String FIXEDRIGHT_SCALEBOTTOM = 'FixedToRight&ScaleToBottom'
Constant String FIXEDBOTTOM_SCALERIGHT = 'FixedToBottom&ScaleToRight'
constant string  DRAGOBJECT = 'dragobject!'
constant string  LINE = 'line!'
constant string  OVAL = 'oval!'
constant string  RECTANGLE = 'rectangle!'
constant string  ROUNDRECTANGLE = 'roundrectangle!'
constant string  MDICLIENT = 'mdiclient!'
constant string  ics_dragobject = 'dragobject!' // Obsoleted in 6.0
constant string  ics_line = 'line!'  // Obsoleted in 6.0
constant string  ics_oval = 'oval!'  // Obsoleted in 6.0
constant string  ics_rectangle = 'rectangle!' // Obsoleted in 6.0
constant string  ics_roundrectangle = 'roundrectangle!' // Obsoleted in 6.0
constant string ics_mdiclient = 'mdiclient!' // Obsoleted in 6.0
 
//pfcwnsrv.pbl(pfc_n_cst_winsrv_statusbar)
// Bar display style constants.
//constant integer BAR = 0//replace with pfc_u_progressbar.BAR
//constant integer PCTCOMPLETE = 1//replace with pfc_u_progressbar.PCTCOMPLETE
//constant integer POSITION = 2//replace with pfc_u_progressbar.POSITION
// Bar fill style constants.
//constant integer LEFTRIGHT = 0//replace with pfc_u_progressbar.LEFTRIGHT
//constant integer RIGHTLEFT = 1//replace with pfc_u_progressbar.RIGHTLEFT
//constant integer TOPDOWN = 2//replace with pfc_u_progressbar.TOPDOWN
//constant integer BOTTOMUP = 3//replace with  pfc_u_progressbar.BOTTOMUP
// Registrable object styles constants.
constant string TEXT = 'text'
constant string BITMAP = 'bitmap'
constant string PREDEFINED = 'predefined'
constant string ics_typetext = 'text'  //Obsoleted in 6.0
constant string ics_typebitmap = 'bitmap' //Obsoleted in 6.0
constant string ics_typepredefined = 'predefined'  //Obsoleted in 6.0

 
//pfeapsrv.pbl(n_cst_anyarraysrv)
constant int T_CHAR = 1
constant int T_BOOL = 2
constant int T_TIME = 3
constant int T_DATE = 4
constant int T_DATETIME = 5
constant int T_INT = 6
constant int T_UINT = 7
constant int T_LONG = 8
constant int T_ULONG = 9
constant int T_DEC = 10
constant int T_REAL = 11
constant int T_DOUBLE = 12
constant int T_NULL = 13
constant int T_ANY = 14
 
//pfemain.pbl(u_tab)
Constant String       cs_myType = "tab"

end variables

on n_cst_appeon_constant_full.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_appeon_constant_full.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

