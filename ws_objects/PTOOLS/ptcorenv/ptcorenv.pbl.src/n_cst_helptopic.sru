$PBExportHeader$n_cst_helptopic.sru
forward
global type n_cst_helptopic from n_base
end type
end forward

global type n_cst_helptopic from n_base
end type
global n_cst_helptopic n_cst_helptopic

type prototypes

end prototypes

type variables
Public:
//topic
CONSTANT String	cs_Classname_RouteInfo 				= "w_routemanager"
CONSTANT String	cs_RouteInfo 							= "Route Information"
CONSTANT Integer	ci_RouteInfo 							= 1

CONSTANT String	cs_Classname_PhoneList  			= "w_phone_list"
CONSTANT String	cs_PhoneList  							= "Phone List"
CONSTANT Integer	ci_PhoneList  							= 2

CONSTANT String	cs_Classname_ExportCompanyList	= "n_cst_companies" //gnv_cst_Companies.of_ExportList ( )
CONSTANT String	cs_ExportCompanyList					= "Export Company List"
CONSTANT Integer	ci_ExportCompanyList					= 3

CONSTANT String	cs_Classname_ImportCompanyInfo	= "n_cst_import_companies"	//lnv_Import_Companies.of_ImportCompanyFile ( )
CONSTANT String	cs_ImportCompanyInfo					= "Import Company Information"
CONSTANT Integer	ci_ImportCompanyInfo					= 4

CONSTANT String	cs_Classname_CompanySearch			= "w_companysearch"
CONSTANT String	cs_CompanySearch						= "Company Search"
CONSTANT Integer	ci_CompanySearch						= 5

CONSTANT String	cs_Classname_CarrierSearch			= "w_carrierlanesearch"
CONSTANT String	cs_CarrierSearch						= "Carrier Search"
CONSTANT Integer	ci_CarrierSearch						= 6

CONSTANT String	cs_Classname_ReportViewer 			= "w_psr_viewer"
CONSTANT String	cs_ReportViewer 						= "Report Viewer"
CONSTANT Integer	ci_ReportViewer 						= 7

CONSTANT String	cs_Classname_ReportLastFreeDate	= "w_review_confirm"	
CONSTANT String	cs_ReportLastFreeDate				= "Report Last Free Date"
CONSTANT Integer	ci_ReportLastFreeDate				= 8

CONSTANT String	cs_Classname_ReportTIR	 			= "w_tirselection"
CONSTANT String	cs_ReportTIR					 		= "Report TIR"
CONSTANT Integer	ci_ReportTIR					 		= 9

CONSTANT String	cs_Classname_ReportShipmentCount	= "w_psr_viewer"	//???
CONSTANT String	cs_ReportShipmentCount				= "Report Shipment Count"
CONSTANT Integer	ci_ReportShipmentCount				= 10

CONSTANT String	cs_Classname_SetupUserPrivileges	= "w_privileges"
CONSTANT String	cs_SetupUserPrivileges				= "Setup User Privileges"
CONSTANT Integer	ci_SetupUserPrivileges				= 11

CONSTANT String	cs_Classname_SetupSystemSettings	= "w_settings"
CONSTANT String	cs_SetupSystemSettings				= "Setup System Settings"
CONSTANT Integer	ci_SetupSystemSettings				= 12

CONSTANT String	cs_Classname_SetupNotificationSetup	= "w_notificationsetup"
CONSTANT String	cs_SetupNotificationSetup				= "Setup Notification Setup"
CONSTANT Integer	ci_SetupNotificationSetup				= 13

CONSTANT String	cs_Classname_SetupEventConfirmationRequirements	= "w_eventconfirmationoptions"
CONSTANT String	cs_SetupEventConfirmationRequirements				= "Setup Event Confirmation Requirements"
CONSTANT Integer	ci_SetupEventConfirmationRequirements				= 14

CONSTANT String	cs_Classname_SetupEquipmentLeaseTypes	= "w_equipmentleasetypes"
CONSTANT String	cs_SetupEquipmentLeaseTypes				= "Setup Equipment Lease Types"
CONSTANT Integer	ci_SetupEquipmentLeaseTypes				= 15

CONSTANT String	cs_Classname_SetupSettingsImport			= "w_namedfileimport"
CONSTANT String	cs_SetupSettingsImport			 			= "Setup Settings Import"
CONSTANT Integer	ci_SetupSettingsImport			 			= 16

CONSTANT	String	cs_Classname_Registration					= "w_reg_adjust"
CONSTANT	String	cs_Registration								= "Registration"
CONSTANT	Integer	ci_Registration								= 17

CONSTANT String	cs_Classname_RateConfirmationTemplate	= "w_rte"
CONSTANT String	cs_RateConfirmationTemplate				= "Rate Confirmation Template"
CONSTANT Integer	ci_RateConfirmationTemplate				= 18

CONSTANT String	cs_Classname_SystemImportData				= "n_cst_bso_import"	//lnv_import.of_Import ( )
CONSTANT String	cs_SystemImportData							= "System Import Data"
CONSTANT Integer	ci_SystemImportData							= 19

CONSTANT String	cs_Classname_SystemImportedLog			= "w_shipimportresults"
CONSTANT String	cs_SystemImportedLog							= "System Imported Log"
CONSTANT Integer	ci_SystemImportedLog							= 20

CONSTANT String	cs_Classname_SystemPCMilerConnection	= "w_pcm_connection"
CONSTANT String	cs_SystemPCMilerConnection					= "System PCMiler Connection"
CONSTANT Integer	ci_SystemPCMilerConnection					= 21

CONSTANT String	cs_Classname_SystemAutomaticCompanyLocatorUpdate	= "n_cst_import_Companies"	//lnv_Import_Companies.of_updatecompanylocators ( )
CONSTANT String	cs_SystemAutomaticCompanyLocatorUpdate					= "System Automatic Company Locator Update"
CONSTANT Integer	ci_SystemAutomaticCompanyLocatorUpdate					= 22

CONSTANT String	cs_Classname_SystemModulesInUse			= "w_licensestatus"
CONSTANT String	cs_SystemModulesInUse						= "System Modules InUse"
CONSTANT Integer	ci_SystemModulesInUse						= 23

CONSTANT String	cs_Classname_RateListLookup				= "w_rate_query"
CONSTANT String	cs_RateListLookup								= "Rate List Lookup"
CONSTANT Integer	ci_RateListLookup								= 24	//also rate lookup

CONSTANT String	cs_Classname_AutoRateLookup				= "w_autoratequery"
CONSTANT String	cs_AutoRateLookup								= "Auto Rate Lookup"
CONSTANT Integer	ci_AutoRateLookup								= 25

CONSTANT String	cs_Classname_ZonesSetup						= "w_zonemanager"
CONSTANT String	cs_ZonesSetup									= "Zones Setup"
CONSTANT Integer	ci_ZonesSetup									= 26

CONSTANT String	cs_Classname_RateTables						= "w_ratetable"
CONSTANT String	cs_RateTables					 				= "Rate Tables"
CONSTANT Integer	ci_RateTables					 				= 27

CONSTANT String	cs_Classname_CodeDefaults					= "w_ratetablelist"
CONSTANT String	cs_CodeDefaults								= "Code Defaults"
CONSTANT Integer	ci_CodeDefaults								= 28

CONSTANT String	cs_Classname_Billing							= "w_billing"
CONSTANT String	cs_Billing										= "Billing"
CONSTANT Integer	ci_Billing										= 29

CONSTANT String	cs_Classname_BilltoOrigDestPoints		= "w_billtopoints"
CONSTANT String	cs_BilltoOrigDestPoints						= "Billto Origin/Destination Points"
CONSTANT Integer	ci_BilltoOrigDestPoints						= 30

CONSTANT String	cs_Classname_LogoSetup						= "w_graphic_setup"
CONSTANT String	cs_LogoSetup									= "Logo Setup"
CONSTANT Integer	ci_LogoSetup									= 31

CONSTANT String	cs_Classname_InvoiceSeriesSetup			= "w_billseq_edit"
CONSTANT String	cs_InvoiceSeriesSetup						= "Invoice Series Setup"
CONSTANT Integer	ci_InvoiceSeriesSetup						= 32

CONSTANT String	cs_Classname_AmountTypeSetup				= "w_amounttypes"
CONSTANT String	cs_AmountTypeSetup							= "Amount Type Setup"
CONSTANT Integer	ci_AmountTypeSetup							= 33

CONSTANT String	cs_Classname_ShipmentTypeSetup			= "w_shiptype_manager"
CONSTANT String	cs_ShipmentTypeSetup				 			= "Shipment Type Setup"
CONSTANT Integer	ci_ShipmentTypeSetup				 			= 34

CONSTANT	String	cs_Classname_ValidateGLAR					= "n_cst_bso_accountingmanager"	//lnv_AccountingManager.of_ValidateAccounts("R")
CONSTANT	String	cs_ValidateGLAR								= "Validate GL AR"
CONSTANT	Integer	ci_ValidateGLAR								= 35

CONSTANT String	cs_Classname_Settlements					= "w_transactionmanager"
CONSTANT String	cs_Settlements									= "Settlements"
CONSTANT Integer	ci_Settlements									= 36

//CONSTANT String	cs_Classname_Settlements_selection		= "w_transaction_selection"
//CONSTANT String	cs_Settlements									= "Settlement Selection"
//CONSTANT Integer	ci_Settlements									= 0

CONSTANT String	cs_Classname_BatchManager					= "w_settlementbatchmanager"
CONSTANT String	cs_BatchManager								= "Batch Manager"
CONSTANT Integer	ci_BatchManager								= 37

CONSTANT String	cs_Classname_FuelCardImport				= "w_importamounts"
CONSTANT String	cs_FuelCardImport								= "Fuel Card Import"
CONSTANT Integer	ci_FuelCardImport								= 38

CONSTANT String	cs_Classname_AmountOwedSearch				= "w_amountowedsearch"
CONSTANT String	cs_AmountOwedSearch							= "Amount Owed Search"
CONSTANT Integer	ci_AmountOwedSearch							= 39

CONSTANT String	cs_Classname_RateTypeSetup					= "w_ratetypes"
CONSTANT String	cs_RateTypeSetup								= "Rate Type Setup"
CONSTANT Integer	ci_RateTypeSetup								= 40

CONSTANT String	cs_Classname_ReferenceTypeSetup			= "w_refnumtypes"
CONSTANT String	cs_ReferenceTypeSetup						= "Reference Type Setup"
CONSTANT Integer	ci_ReferenceTypeSetup						= 41

CONSTANT String	cs_Classname_DivisionSetup					= "w_shiptype_manager"
CONSTANT String	cs_DivisionSetup								= "Division Setup"
CONSTANT Integer	ci_DivisionSetup								= 42

CONSTANT String	cs_Classname_PayablesSetup					= "w_tv_amounttemplates"
CONSTANT String	cs_PayablesSetup								= "Payables Setup"
CONSTANT Integer	ci_PayablesSetup								= 43

CONSTANT String	cs_Classname_ValidatePayableVendors		= "w_entitylist"
CONSTANT String	cs_ValidatePayableVendors					= "Validate Payable Vendors"
CONSTANT Integer	ci_ValidatePayableVendors					= 44

CONSTANT String	cs_Classname_ValidatePayrollEmployees	= "w_entitylist"
CONSTANT String	cs_ValidatePayrollEmployees				= "Validate Payroll Employees"
CONSTANT Integer	ci_ValidatePayrollEmployees				= 45

CONSTANT String	cs_Classname_ValidateGLAP					= "n_cst_bso_accountingmanager"	//lnv_AccountingManager.of_ValidateAccounts("P")
CONSTANT String	cs_ValidateGLAP								= "Validate GL AP"
CONSTANT Integer	ci_ValidateGLAP								= 46

CONSTANT String	cs_Classname_ScanBatch						= "w_imaging"
CONSTANT String	cs_ScanBatch									= "Scan Batch"
CONSTANT Integer	ci_ScanBatch									= 47

CONSTANT String	cs_Classname_Archiving						= "w_imagingsettingsmanager"
CONSTANT String	cs_Archiving									= "Archiving"
CONSTANT Integer	ci_Archiving									= 48

CONSTANT String	cs_Classname_ImageTypeSetup				= "w_imagetypesetup"
CONSTANT String	cs_ImageTypeSetup								= "Image Type Setup"
CONSTANT Integer	ci_ImageTypeSetup								= 49

CONSTANT String	cs_Classname_LogEntry						= "w_log"
CONSTANT String	cs_LogEntry										= "Log Entry"
CONSTANT Integer	ci_LogEntry										= 50

CONSTANT String	cs_Classname_Violations						= "w_vios_driver"
CONSTANT String	cs_Violations									= "Violations"
CONSTANT Integer	ci_Violations									= 51

CONSTANT String	cs_Classname_Reporting						= "w_log_reports"
CONSTANT String	cs_Reporting									= "Reporting"
CONSTANT Integer	ci_Reporting									= 52

CONSTANT String	cs_Classname_RandomDriverLIst				= "w_driver_random"
CONSTANT String	cs_RandomDriverLIst							= "Random Driver LIst"
CONSTANT Integer	ci_RandomDriverLIst							= 53

CONSTANT String	cs_Classname_LogAdministration			= "w_log_admin"
CONSTANT String	cs_LogAdministration							= "Log Administration"
CONSTANT Integer	ci_LogAdministration							= 54

CONSTANT String	cs_Classname_UserPreferences				= "w_log_settings"
CONSTANT String	cs_UserPreferences							= "User Preferences"
CONSTANT Integer	ci_UserPreferences							= 55

CONSTANT String	cs_Classname_ItinShip3rdPartyTrip		= "w_itin_select"
CONSTANT String	cs_ItinShip3rdPartyTrip						= "Itinerary/Shipment/3rdPartyTrip"
CONSTANT Integer	ci_ItinShip3rdPartyTrip						= 56

CONSTANT String	cs_Classname_AutoRouteRepos				= "w_autoreposequipmentinput"
CONSTANT String	cs_AutoRouteRepos								= "Auto Route Repos"
CONSTANT Integer	ci_AutoRouteRepos								= 57

CONSTANT String	cs_Classname_ShipmentSummary				= "w_shipmentmanager"
CONSTANT String	cs_ShipmentSummary							= "Shipment Summary"
CONSTANT Integer	ci_ShipmentSummary							= 58

CONSTANT String	cs_Classname_EquipmentSummary				= "w_equipmentsummary"
CONSTANT String	cs_EquipmentSummary							= "Equipment Summary"
CONSTANT Integer	ci_EquipmentSummary							= 59

CONSTANT String	cs_Classname_3rdPartyTripSummary			= "w_tripsummary"
CONSTANT String	cs_3rdPartyTripSummary						= "3rdPartyTrip Summary"
CONSTANT Integer	ci_3rdPartyTripSummary						= 60

CONSTANT String	cs_Classname_Search							= "w_search"
CONSTANT String	cs_Search										= "Search"
CONSTANT Integer	ci_Search										= 61

CONSTANT String	cs_Classname_PCMilerInterface				= "w_pcmiler"
CONSTANT String	cs_PCMilerInterface							= "PCMiler Interface"
CONSTANT Integer	ci_PCMilerInterface							= 62

CONSTANT String	cs_Classname_CashAdvance					= "w_cashadvance"
CONSTANT String	cs_CashAdvance									= "Cash Advance"
CONSTANT Integer	ci_CashAdvance									= 63

CONSTANT String	cs_Classname_DeviceSetup					= "w_communication_manager"
CONSTANT String	cs_DeviceSetup									= "Device Setup"
CONSTANT Integer	ci_DeviceSetup									= 64

CONSTANT String	cs_Classname_ProcessInboundMessages		= "w_deviceselection"//?????????
CONSTANT String	cs_ProcessInboundMessages					= "Process Inbound Messages"
CONSTANT Integer	ci_ProcessInboundMessages					= 65

CONSTANT String	cs_Classname_MessageLog						= "w_inboundmessages"
CONSTANT String	cs_MessageLog									= "Message Log"
CONSTANT Integer	ci_MessageLog									= 66

CONSTANT String	cs_Classname_SendFreeFormText				= "w_freeform_text"
CONSTANT String	cs_SendFreeFormText							= "Send FreeForm Text"
CONSTANT Integer	ci_SendFreeFormText							= 67

CONSTANT String	cs_Classname_CompanyFacilitySelection	= "w_co_select2"
CONSTANT String	cs_CompanyFacilitySelection				= "Company Facility Selection"
CONSTANT Integer	ci_CompanyFacilitySelection				= 68

CONSTANT String	cs_Classname_CompanyInformation			= "w_company"
CONSTANT String	cs_CompanyInformation						= "Company Information"
CONSTANT Integer	ci_CompanyInformation						= 69

CONSTANT String	cs_Classname_CompanyFacilityDetails		= "w_companydetail"
CONSTANT String	cs_CompanyFacilityDetails					= "Company Facility Details"
CONSTANT Integer	ci_CompanyFacilityDetails					= 70

CONSTANT String	cs_Classname_ContactInformation			= "w_companycontact_detail"	//????
CONSTANT String	cs_ContactInformation						= "Contact Information"
CONSTANT Integer	ci_ContactInformation						= 71

CONSTANT String	cs_Classname_FacilityDetails				= "w_company"	//????
CONSTANT String	cs_FacilityDetails							= "Facility Details"
CONSTANT Integer	ci_FacilityDetails							= 72

CONSTANT String	cs_Classname_EDISetup						= "w_ediprofile"
CONSTANT String	cs_EDISetup										= "EDI Setup"
CONSTANT Integer	ci_EDISetup										= 73

CONSTANT String	cs_Classname_EDITransactionLog			= "w_edilog"
CONSTANT String	cs_EDITransactionLog							= "EDI Transaction Log"
CONSTANT Integer	ci_EDITransactionLog							= 74

CONSTANT String	cs_Classname_EmployeeInformation			= "w_emp_info"
CONSTANT String	cs_EmployeeInformation						= "Employee Information"
CONSTANT Integer	ci_EmployeeInformation						= 75

CONSTANT String	cs_Classname_EmployeeSelection			= "w_emp_list"
CONSTANT String	cs_EmployeeSelection							= "Employee Selection"
CONSTANT Integer	ci_EmployeeSelection							= 76

CONSTANT String	cs_Classname_EmployeeNotes					= "w_text_edit"
CONSTANT String	cs_EmployeeNotes								= "Employee Notes"
CONSTANT Integer	ci_EmployeeNotes								= 77

CONSTANT String	cs_Classname_DriverFleetHistoryReport	= "Driver Fleet History Report"	//????
CONSTANT String	cs_DriverFleetHistoryReport				= "Driver Fleet History Report"
CONSTANT Integer	ci_DriverFleetHistoryReport				= 78

CONSTANT String	cs_Classname_DuplicateShipment			= "w_duplicatewithequipment"
CONSTANT String	cs_DuplicateShipment							= "Duplicate Shipment"
CONSTANT Integer	ci_DuplicateShipment							= 79

CONSTANT String	cs_Classname_DocumentWindow				= "w_documentselection"
CONSTANT String	cs_DocumentWindow								= "Document Window"
CONSTANT Integer	ci_DocumentWindow								= 80

CONSTANT String	cs_Classname_LoadBuilder					= "w_loadbuilder"
CONSTANT String	cs_LoadBuilder									= "LoadBuilder"
CONSTANT Integer	ci_LoadBuilder									= 81

//used to determine if ship window or itinerary window
CONSTANT String	cs_Classname_Dispatch						= "w_dispatch"

CONSTANT String	cs_Classname_ShipmentWindow				= "w_ship"
CONSTANT String	cs_ShipmentWindow								= "Shipment Window"
CONSTANT Integer	ci_ShipmentWindow								= 82

CONSTANT String	cs_Classname_ItemDetails					= "u_dw_itemdetails"
CONSTANT String	cs_ItemDetails									= "Item Details"
CONSTANT Integer	ci_ItemDetails									= 83

CONSTANT String	cs_Classname_RateSelection					= "w_rate_selection"
CONSTANT String	cs_RateSelection								= "Rate Selection"
CONSTANT Integer	ci_RateSelection								= 84

CONSTANT String	cs_Classname_EventDetails					= "u_dw_eventdetail"
CONSTANT String	cs_EventDetails								= "Event Details"
CONSTANT Integer	ci_EventDetails								= 85

CONSTANT String	cs_Classname_ShipmentSplits				= "w_shipmentsplits"
CONSTANT String	cs_ShipmentSplits								= "Shipment Splits"
CONSTANT Integer	ci_ShipmentSplits								= 86

CONSTANT String	cs_Classname_NotificationTargets			= "w_shipmentnotification"
CONSTANT String	cs_NotificationTargets						= "Notification Targets"
CONSTANT Integer	ci_NotificationTargets						= 87

CONSTANT String	cs_Classname_ShipmentDetail				= "w_shipmentdetail"
CONSTANT String	cs_ShipmentDetail								= "Shipment Detail"
CONSTANT Integer	ci_ShipmentDetail								= 88

CONSTANT String	cs_Classname_ManageRevenueSplits			= "w_revenuemanager"
CONSTANT String	cs_ManageRevenueSplits						= "Manage Revenue Splits"
CONSTANT Integer	ci_ManageRevenueSplits						= 89

CONSTANT String	cs_Classname_LinkedEquipment				= "w_linkedequipment"
CONSTANT String	cs_LinkedEquipment							= "Linked Equipment"
CONSTANT Integer	ci_LinkedEquipment							= 90

CONSTANT String	cs_Classname_AutoRouteEventSelection	= "w_event_route"
CONSTANT String	cs_AutoRouteEventSelection					= "Auto Route Event Selection"
CONSTANT Integer	ci_AutoRouteEventSelection					= 91

CONSTANT String	cs_Classname_ItineraryWindow				= "w_itin"
CONSTANT String	cs_ItineraryWindow							= "Itinerary Window"
CONSTANT Integer	ci_ItineraryWindow							= 92

CONSTANT String	cs_Classname_RouteMap						= "w_map"	//w_map_streets
CONSTANT String	cs_RouteMap										= "Route Map"
CONSTANT Integer	ci_RouteMap										= 93

CONSTANT String	cs_Classname_DrivingInstructions			= "w_pcreport"
CONSTANT String	cs_DrivingInstructions						= "Driving Instructions"
CONSTANT Integer	ci_DrivingInstructions						= 94

CONSTANT String	cs_Classname_Statistics						= "w_itinerartstats"
CONSTANT String	cs_Statistics									= "Statistics"
CONSTANT Integer	ci_Statistics									= 95

CONSTANT String	cs_Classname_ShipmentSelection			= "w_shipment_select"
CONSTANT String	cs_ShipmentSelection							= "Shipment Selection"
CONSTANT Integer	ci_ShipmentSelection							= 96

CONSTANT String	cs_Classname_DriverSelection				= "Driver Selection"	//???????
CONSTANT String	cs_DriverSelection							= "Driver Selection"
CONSTANT Integer	ci_DriverSelection							= 97

CONSTANT String	cs_Classname_ImagingWindow					= "w_imaging"
CONSTANT String	cs_ImagingWindow								= "Imaging Window"
CONSTANT Integer	ci_ImagingWindow								= 98

CONSTANT String	cs_Classname_ScanImageType					= "w_imagetype"		//also "Scanner Selection" and "Scanner Settings"
CONSTANT String	cs_ScanImageType								= "Scan Image Type"
CONSTANT Integer	ci_ScanImageType								= 99


CONSTANT String	cs_Classname_MultiShipmentUpdate			= "w_multishipupdate"
CONSTANT String	cs_MultiShipmentUpdate						= "Multi-Shipment Update"
CONSTANT Integer	ci_MultiShipmentUpdate						= 102

CONSTANT String	cs_Classname_EDIMessageDetail				= "w_shipmentstatus_details"
CONSTANT String	cs_EDIMessageDetail							= "EDI Message Detail"
CONSTANT Integer	ci_EDIMessageDetail							= 103

CONSTANT String	cs_Classname_EDIMessagesforShipment		= "w_shipmentstatus_list"
CONSTANT String	cs_EDIMessagesforShipment					= "EDI Messages for Shipment"
CONSTANT Integer	ci_EDIMessagesforShipment					= 104

CONSTANT String	cs_Classname_MIssingDocumentReport		= "w_mIssingimagetypeselection"
CONSTANT String	cs_MIssingDocumentReport					= "MIssing Document Report"
CONSTANT Integer	ci_MIssingDocumentReport					= 105

CONSTANT String	cs_Classname_EquipmentInformation		= "w_eq_info"
CONSTANT String	cs_EquipmentInformation						= "Equipment Information"
CONSTANT Integer	ci_EquipmentInformation						= 106

CONSTANT String	cs_Classname_AddViolation					= "w_add_vios"
CONSTANT String	cs_AddViolation								= "Add Violation"
CONSTANT Integer	ci_AddViolation								= 107

CONSTANT String	cs_Classname_LogReceipts					= "w_log_receipts"
CONSTANT String	cs_LogReceipts									= "Log Receipts"
CONSTANT Integer	ci_LogReceipts									= 108

CONSTANT String	cs_Classname_322dialog						= "w_edi322_dialog"
CONSTANT String	cs_322dialog									= "EDI 322"
CONSTANT Integer	ci_322dialog									= 111

CONSTANT String	cs_Classname_CompanyAlias					= "w_companyalias"
CONSTANT String	cs_CompanyAlias								= "Company Alias List"
CONSTANT Integer	ci_CompanyAlias								= 112

CONSTANT String	cs_Classname_EDIAliasList					= "w_aliassetup"
CONSTANT String	cs_EDIAliasList								= "EDI Alias List"
CONSTANT Integer	ci_EDIAliasList								= 113

CONSTANT String	cs_Classname_EditEventSchedule			= "w_scheduleedit"
CONSTANT String	cs_EditEventSchedule							= "Edit Schedule"
CONSTANT Integer	ci_EditEventSchedule							= 114

CONSTANT String	cs_Classname_UserAlerts						= "w_textinput"
CONSTANT String	cs_UserAlerts									= "User Alerts"
CONSTANT Integer	ci_UserAlerts									= 115





end variables

forward prototypes
public function integer of_gettopic (string as_classname)
public function string of_getdescription (string as_classname)
public function string of_whichwindow ()
public function string of_gethelpfile ()
public function integer of_openprofittoolswebsite ()
end prototypes

public function integer of_gettopic (string as_classname);integer	li_topic


choose case as_classname
		
	case cs_Classname_RouteInfo
		li_topic = ci_RouteInfo
	
	case cs_Classname_PhoneList
		li_topic = ci_PhoneList
	
	case cs_Classname_ExportCompanyList
		li_topic = ci_ExportCompanyList
	
	case cs_ImportCompanyInfo
		li_topic = ci_ImportCompanyInfo
	
	case cs_Classname_CompanySearch
		li_topic = ci_CompanySearch
	
	case cs_Classname_CarrierSearch
		li_topic = ci_CarrierSearch
		
	case cs_Classname_ReportViewer
		li_topic = ci_ReportViewer
	
	case cs_Classname_ReportLastFreeDate
		li_topic = ci_ReportLastFreeDate
	
	case cs_Classname_ReportTIR
		li_topic = ci_ReportTIR
	
	case cs_Classname_ReportShipmentCount
		li_topic = ci_ReportShipmentCount
	
	case cs_Classname_SetupUserPrivileges
		li_topic = ci_SetupUserPrivileges
	
	case cs_Classname_SetupSystemSettings
		li_topic = ci_SetupSystemSettings
	
	case cs_Classname_SetupNotificationSetup
		li_topic = ci_SetupNotificationSetup
	
	case cs_Classname_SetupEventConfirmationRequirements
		li_topic = ci_SetupEventConfirmationRequirements
	
	case cs_Classname_SetupEquipmentLeaseTypes
		li_topic = ci_SetupEquipmentLeaseTypes
	
	case cs_Classname_SetupSettingsImport
		li_topic = ci_SetupSettingsImport
	
	case	cs_Classname_Registration
		li_topic =	ci_Registration
	
	case cs_Classname_RateConfirmationTemplate
		li_topic = ci_RateConfirmationTemplate
	
	case cs_Classname_SystemImportData
		li_topic = ci_SystemImportData
	
	case cs_Classname_SystemImportedLog	
		li_topic = ci_SystemImportedLog
	
	case cs_Classname_SystemPCMilerConnection
		li_topic = ci_SystemPCMilerConnection
	
	case cs_Classname_SystemAutomaticCompanyLocatorUpdate
		li_topic = ci_SystemAutomaticCompanyLocatorUpdate
	
	case cs_Classname_SystemModulesInUse
		li_topic = ci_SystemModulesInUse	
	
	case cs_Classname_RateListLookup
		li_topic = ci_RateListLookup
	
	case cs_Classname_AutoRateLookup
		li_topic = ci_AutoRateLookup	
	
	case cs_Classname_ZonesSetup
		li_topic = ci_ZonesSetup
	
	case cs_Classname_RateTables	
		li_topic = ci_RateTables	
	
	case cs_Classname_CodeDefaults
		li_topic = ci_CodeDefaults	
	
	case cs_Classname_Billing
		li_topic = ci_Billing	
	
	case cs_Classname_BilltoOrigDestPoints
		li_topic = ci_BilltoOrigDestPoints	
	
	case cs_Classname_LogoSetup
		li_topic = ci_LogoSetup		
	
	case cs_Classname_InvoiceSeriesSetup
		li_topic = ci_InvoiceSeriesSetup	
	
	case cs_Classname_AmountTypeSetup
		li_topic = ci_AmountTypeSetup			
	
	case cs_Classname_ShipmentTypeSetup
		li_topic = ci_ShipmentTypeSetup		
	
	case cs_Classname_ValidateGLAR
		li_topic = ci_ValidateGLAR	
	
	case cs_Classname_Settlements
		li_topic = ci_Settlements		
		
	case cs_Classname_BatchManager
		li_topic = ci_BatchManager			
	
	case cs_Classname_FuelCardImport
		li_topic = ci_FuelCardImport			
		
	case cs_Classname_AmountOwedSearch	
		li_topic = ci_AmountOwedSearch	
	
	case cs_Classname_RateTypeSetup	
		li_topic = ci_RateTypeSetup		
	
	case cs_Classname_ReferenceTypeSetup
		li_topic = ci_ReferenceTypeSetup		
	
	case cs_Classname_DivisionSetup
		li_topic = ci_DivisionSetup			
	
	case cs_Classname_PayablesSetup
		li_topic = ci_PayablesSetup				
	
	case cs_Classname_ValidatePayableVendors
		li_topic = ci_ValidatePayableVendors		
	
	case cs_Classname_ValidatePayrollEmployees
		li_topic = ci_ValidatePayrollEmployees		
	
	case cs_Classname_ValidateGLAP
		li_topic = ci_ValidateGLAP	
	
	case cs_Classname_ScanBatch
		li_topic = ci_ScanBatch			
	
	case cs_Classname_Archiving
		li_topic = ci_Archiving			
	
	case cs_Classname_ImageTypeSetup	
		li_topic = ci_ImageTypeSetup		
	
	case cs_Classname_LogEntry
		li_topic = ci_LogEntry		
	
	case cs_Classname_Violations
		li_topic = ci_Violations		
	
	case cs_Classname_Reporting
		li_topic = ci_Reporting		
	
	case cs_Classname_RandomDriverLIst
		li_topic = ci_RandomDriverLIst	
	
	case cs_Classname_LogAdministration	
		li_topic = ci_LogAdministration			
	
	case cs_Classname_UserPreferences
		li_topic = ci_UserPreferences		
	
	case cs_Classname_ItinShip3rdPartyTrip
		li_topic = ci_ItinShip3rdPartyTrip	
	
	case cs_Classname_AutoRouteRepos
		li_topic = ci_AutoRouteRepos			
	
	case cs_Classname_ShipmentSummary
		li_topic = ci_ShipmentSummary			
	
	case cs_Classname_EquipmentSummary
		li_topic = ci_EquipmentSummary	
	
	case cs_Classname_3rdPartyTripSummary	
		li_topic = ci_3rdPartyTripSummary	
	
	case cs_Classname_Search
		li_topic = ci_Search		
	
	case cs_Classname_PCMilerInterface
		li_topic = ci_PCMilerInterface	
		
	case cs_Classname_CashAdvance	
		li_topic = ci_CashAdvance			
	
	case cs_Classname_DeviceSetup
		li_topic = ci_DeviceSetup		
	
	case cs_Classname_ProcessInboundMessages
		li_topic = ci_ProcessInboundMessages	
	
	case cs_Classname_MessageLog
		li_topic = ci_MessageLog			
	
	case cs_Classname_SendFreeFormText
		li_topic = ci_SendFreeFormText		
	
	case cs_Classname_CompanyFacilitySelection
		li_topic = ci_CompanyFacilitySelection		
	
	case cs_Classname_CompanyInformation
		li_topic = ci_CompanyInformation		
	
	case cs_Classname_CompanyFacilityDetails
		li_topic = ci_CompanyFacilityDetails	
	
	case cs_Classname_ContactInformation
		li_topic = ci_ContactInformation		
	
	case cs_Classname_FacilityDetails	
		li_topic = ci_FacilityDetails		
	
	case cs_Classname_EDISetup
		li_topic = ci_EDISetup				
	
	case cs_Classname_EDITransactionLog
		li_topic = ci_EDITransactionLog	
	
	case cs_Classname_EmployeeInformation
		li_topic = ci_EmployeeInformation		
	
	case cs_Classname_EmployeeSelection	
		li_topic = ci_EmployeeSelection	
	
	case cs_Classname_EmployeeNotes
		li_topic = ci_EmployeeNotes				
	
	case cs_Classname_DriverFleetHistoryReport
		li_topic = ci_DriverFleetHistoryReport	
	
	case cs_Classname_DuplicateShipment
		li_topic = ci_DuplicateShipment		
	
	case cs_Classname_DocumentWindow	
		li_topic = ci_DocumentWindow	
	
	case cs_Classname_LoadBuilder
		li_topic = ci_LoadBuilder		
	
	case cs_Classname_Dispatch
		
		choose case this.of_WhichWindow()
			case cs_Classname_ShipmentWindow	
				li_topic = ci_ShipmentWindow		
			case cs_Classname_ItineraryWindow
				li_topic = ci_ItineraryWindow		
		end choose
	
	case cs_Classname_ItemDetails	
		li_topic = ci_ItemDetails			
	
	case cs_Classname_RateSelection
		li_topic = ci_RateSelection			
	
	case cs_Classname_EventDetails
		li_topic = ci_EventDetails			
	
	case cs_Classname_ShipmentSplits	
		li_topic = ci_ShipmentSplits				
	
	case cs_Classname_NotificationTargets
		li_topic = ci_NotificationTargets	
	
	case cs_Classname_ShipmentDetail
		li_topic = ci_ShipmentDetail			
	
	case cs_Classname_ManageRevenueSplits	
		li_topic = ci_ManageRevenueSplits		
	
	case cs_Classname_LinkedEquipment
		li_topic = ci_LinkedEquipment			
	
	case cs_Classname_AutoRouteEventSelection
		li_topic = ci_AutoRouteEventSelection		
	
	case cs_Classname_RouteMap	
		li_topic = ci_RouteMap				
	
	case cs_Classname_DrivingInstructions
		li_topic = ci_DrivingInstructions		
	
	case cs_Classname_Statistics
		li_topic = ci_Statistics		
	
	case cs_Classname_ShipmentSelection	
		li_topic = ci_ShipmentSelection		
	
	case cs_Classname_DriverSelection
		li_topic = ci_DriverSelection			
	
	case cs_Classname_ImagingWindow
		li_topic = ci_ImagingWindow	
	
	case cs_Classname_ScanImageType
		li_topic = ci_ScanImageType	
	
	case cs_Classname_MultiShipmentUpdate
		li_topic = ci_MultiShipmentUpdate	
	
	case cs_Classname_EDIMessageDetail
		li_topic = ci_EDIMessageDetail		
	
	case cs_Classname_EDIMessagesforShipment
		li_topic = ci_EDIMessagesforShipment		
	
	case cs_Classname_MIssingDocumentReport
		li_topic = ci_MIssingDocumentReport		
	
	case cs_Classname_EquipmentInformation
		li_topic = ci_EquipmentInformation			
	
	case cs_Classname_AddViolation
		li_topic = ci_AddViolation			
	
	case cs_Classname_LogReceipts
		li_topic = ci_LogReceipts
		
	case cs_Classname_322dialog
		li_topic = ci_322dialog

	CASE cs_Classname_CompanyAlias
		li_topic = ci_CompanyAlias
		
	CASE cs_Classname_EDIAliasList
		li_topic = ci_EDIAliasList
		
	CASE cs_Classname_EditEventSchedule
		li_topic = ci_EditEventSchedule
		
	CASE cs_Classname_UserAlerts
		li_topic = ci_UserAlerts
		
end choose

return li_topic

end function

public function string of_getdescription (string as_classname);string	ls_description

choose case as_classname
		
	case cs_Classname_RouteInfo
		ls_description = cs_RouteInfo
	
	case cs_Classname_PhoneList
		ls_description = cs_PhoneList
	
	case cs_Classname_ExportCompanyList
		ls_description = cs_ExportCompanyList
	
	case cs_ImportCompanyInfo
		ls_description = cs_ImportCompanyInfo
	
	case cs_Classname_CompanySearch
		ls_description = cs_CompanySearch
	
	case cs_Classname_CarrierSearch
		ls_description = cs_CarrierSearch
		
	case cs_Classname_ReportViewer
		ls_description = cs_ReportViewer
	
	case cs_Classname_ReportLastFreeDate
		ls_description = cs_ReportLastFreeDate
	
	case cs_Classname_ReportTIR
		ls_description = cs_ReportTIR
	
	case cs_Classname_ReportShipmentCount
		ls_description = cs_ReportShipmentCount
	
	case cs_Classname_SetupUserPrivileges
		ls_description = cs_SetupUserPrivileges
	
	case cs_Classname_SetupSystemSettings
		ls_description = cs_SetupSystemSettings
	
	case cs_Classname_SetupNotificationSetup
		ls_description = cs_SetupNotificationSetup
	
	case cs_Classname_SetupEventConfirmationRequirements
		ls_description = cs_SetupEventConfirmationRequirements
	
	case cs_Classname_SetupEquipmentLeaseTypes
		ls_description = cs_SetupEquipmentLeaseTypes
	
	case cs_Classname_SetupSettingsImport
		ls_description = cs_SetupSettingsImport
	
	case	cs_Classname_Registration
		ls_description =	cs_Registration
	
	case cs_Classname_RateConfirmationTemplate
		ls_description = cs_RateConfirmationTemplate
	
	case cs_Classname_SystemImportData
		ls_description = cs_SystemImportData
	
	case cs_Classname_SystemImportedLog	
		ls_description = cs_SystemImportedLog
	
	case cs_Classname_SystemPCMilerConnection
		ls_description = cs_SystemPCMilerConnection
	
	case cs_Classname_SystemAutomaticCompanyLocatorUpdate
		ls_description = cs_SystemAutomaticCompanyLocatorUpdate
	
	case cs_Classname_SystemModulesInUse
		ls_description = cs_SystemModulesInUse	
	
	case cs_Classname_RateListLookup
		ls_description = cs_RateListLookup
	
	case cs_Classname_AutoRateLookup
		ls_description = cs_AutoRateLookup	
	
	case cs_Classname_ZonesSetup
		ls_description = cs_ZonesSetup
	
	case cs_Classname_RateTables	
		ls_description = cs_RateTables	
	
	case cs_Classname_CodeDefaults
		ls_description = cs_CodeDefaults	
	
	case cs_Classname_Billing
		ls_description = cs_Billing	
	
	case cs_Classname_BilltoOrigDestPoints
		ls_description = cs_BilltoOrigDestPoints	
	
	case cs_Classname_LogoSetup
		ls_description = cs_LogoSetup		
	
	case cs_Classname_InvoiceSeriesSetup
		ls_description = cs_InvoiceSeriesSetup	
	
	case cs_Classname_AmountTypeSetup
		ls_description = cs_AmountTypeSetup			
	
	case cs_Classname_ShipmentTypeSetup
		ls_description = cs_ShipmentTypeSetup		
	
	case cs_Classname_ValidateGLAR
		ls_description = cs_ValidateGLAR	
	
	case cs_Classname_Settlements
		ls_description = cs_Settlements		
		
	case cs_Classname_BatchManager
		ls_description = cs_BatchManager			
	
	case cs_Classname_FuelCardImport
		ls_description = cs_FuelCardImport			
		
	case cs_Classname_AmountOwedSearch	
		ls_description = cs_AmountOwedSearch	
	
	case cs_Classname_RateTypeSetup	
		ls_description = cs_RateTypeSetup		
	
	case cs_Classname_ReferenceTypeSetup
		ls_description = cs_ReferenceTypeSetup		
	
	case cs_Classname_DivisionSetup
		ls_description = cs_DivisionSetup			
	
	case cs_Classname_PayablesSetup
		ls_description = cs_PayablesSetup				
	
	case cs_Classname_ValidatePayableVendors
		ls_description = cs_ValidatePayableVendors		
	
	case cs_Classname_ValidatePayrollEmployees
		ls_description = cs_ValidatePayrollEmployees		
	
	case cs_Classname_ValidateGLAP
		ls_description = cs_ValidateGLAP	
	
	case cs_Classname_ScanBatch
		ls_description = cs_ScanBatch			
	
	case cs_Classname_Archiving
		ls_description = cs_Archiving			
	
	case cs_Classname_ImageTypeSetup	
		ls_description = cs_ImageTypeSetup		
	
	case cs_Classname_LogEntry
		ls_description = cs_LogEntry		
	
	case cs_Classname_Violations
		ls_description = cs_Violations		
	
	case cs_Classname_Reporting
		ls_description = cs_Reporting		
	
	case cs_Classname_RandomDriverLIst
		ls_description = cs_RandomDriverLIst	
	
	case cs_Classname_LogAdministration	
		ls_description = cs_LogAdministration			
	
	case cs_Classname_UserPreferences
		ls_description = cs_UserPreferences		
	
	case cs_Classname_ItinShip3rdPartyTrip
		ls_description = cs_ItinShip3rdPartyTrip	
	
	case cs_Classname_AutoRouteRepos
		ls_description = cs_AutoRouteRepos			
	
	case cs_Classname_ShipmentSummary
		ls_description = cs_ShipmentSummary			
	
	case cs_Classname_EquipmentSummary
		ls_description = cs_EquipmentSummary	
	
	case cs_Classname_3rdPartyTripSummary	
		ls_description = cs_3rdPartyTripSummary	
	
	case cs_Classname_Search
		ls_description = cs_Search		
	
	case cs_Classname_PCMilerInterface
		ls_description = cs_PCMilerInterface	
		
	case cs_Classname_CashAdvance	
		ls_description = cs_CashAdvance			
	
	case cs_Classname_DeviceSetup
		ls_description = cs_DeviceSetup		
	
	case cs_Classname_ProcessInboundMessages
		ls_description = cs_ProcessInboundMessages	
	
	case cs_Classname_MessageLog
		ls_description = cs_MessageLog			
	
	case cs_Classname_SendFreeFormText
		ls_description = cs_SendFreeFormText		
	
	case cs_Classname_CompanyFacilitySelection
		ls_description = cs_CompanyFacilitySelection		
	
	case cs_Classname_CompanyInformation
		ls_description = cs_CompanyInformation		
	
	case cs_Classname_CompanyFacilityDetails
		ls_description = cs_CompanyFacilityDetails	
	
	case cs_Classname_ContactInformation
		ls_description = cs_ContactInformation		
	
	case cs_Classname_FacilityDetails	
		ls_description = cs_FacilityDetails		
	
	case cs_Classname_EDISetup
		ls_description = cs_EDISetup				
	
	case cs_Classname_EDITransactionLog
		ls_description = cs_EDITransactionLog	
	
	case cs_Classname_EmployeeInformation
		ls_description = cs_EmployeeInformation		
	
	case cs_Classname_EmployeeSelection	
		ls_description = cs_EmployeeSelection	
	
	case cs_Classname_EmployeeNotes
		ls_description = cs_EmployeeNotes				
	
	case cs_Classname_DriverFleetHistoryReport
		ls_description = cs_DriverFleetHistoryReport	
	
	case cs_Classname_DuplicateShipment
		ls_description = cs_DuplicateShipment		
	
	case cs_Classname_DocumentWindow	
		ls_description = cs_DocumentWindow	
	
	case cs_Classname_LoadBuilder
		ls_description = cs_LoadBuilder		
	
	case cs_Classname_Dispatch
		
		choose case this.of_WhichWindow()
			case cs_Classname_ShipmentWindow	
				ls_description = cs_ShipmentWindow		
			case cs_Classname_ItineraryWindow
				ls_description = cs_ItineraryWindow		
		end choose
	
	case cs_Classname_ItemDetails	
		ls_description = cs_ItemDetails			
	
	case cs_Classname_RateSelection
		ls_description = cs_RateSelection			
	
	case cs_Classname_EventDetails
		ls_description = cs_EventDetails			
	
	case cs_Classname_ShipmentSplits	
		ls_description = cs_ShipmentSplits				
	
	case cs_Classname_NotificationTargets
		ls_description = cs_NotificationTargets	
	
	case cs_Classname_ShipmentDetail
		ls_description = cs_ShipmentDetail			
	
	case cs_Classname_ManageRevenueSplits	
		ls_description = cs_ManageRevenueSplits		
	
	case cs_Classname_LinkedEquipment
		ls_description = cs_LinkedEquipment			
	
	case cs_Classname_AutoRouteEventSelection
		ls_description = cs_AutoRouteEventSelection		
	
	case cs_Classname_RouteMap	
		ls_description = cs_RouteMap				
	
	case cs_Classname_DrivingInstructions
		ls_description = cs_DrivingInstructions		
	
	case cs_Classname_Statistics
		ls_description = cs_Statistics		
	
	case cs_Classname_ShipmentSelection	
		ls_description = cs_ShipmentSelection		
	
	case cs_Classname_DriverSelection
		ls_description = cs_DriverSelection			
	
	case cs_Classname_ImagingWindow
		ls_description = cs_ImagingWindow	
	
	case cs_Classname_ScanImageType
		ls_description = cs_ScanImageType	
	
	case cs_Classname_MultiShipmentUpdate
		ls_description = cs_MultiShipmentUpdate	
	
	case cs_Classname_EDIMessageDetail
		ls_description = cs_EDIMessageDetail		
	
	case cs_Classname_EDIMessagesforShipment
		ls_description = cs_EDIMessagesforShipment		
	
	case cs_Classname_MIssingDocumentReport
		ls_description = cs_MIssingDocumentReport		
	
	case cs_Classname_EquipmentInformation
		ls_description = cs_EquipmentInformation			
	
	case cs_Classname_AddViolation
		ls_description = cs_AddViolation			
	
	case cs_Classname_LogReceipts
		ls_description = cs_LogReceipts			

	case cs_Classname_322dialog
		ls_description = cs_322dialog
		
	CASE cs_Classname_CompanyAlias
		ls_description = cs_CompanyAlias
		
	CASE cs_Classname_EDIAliasList
		ls_description = cs_EDIAliasList
		
	CASE cs_Classname_EditEventSchedule
		ls_description = cs_EditEventSchedule
		
	CASE cs_Classname_UserAlerts
		ls_description = cs_UserAlerts
		
end choose


return ls_Description

end function

public function string of_whichwindow ();string	ls_window
window	activesheet

activesheet = gnv_app.of_getframe().GetActiveSheet()

if pos(activesheet.title,'Ship') > 0  then
	ls_window = cs_classname_shipmentwindow
elseif pos(activesheet.title,'Itin') > 0  then
	ls_window = cs_classname_itinerarywindow
end if
		
return ls_window
end function

public function string of_gethelpfile ();Integer	li_Return = 1
String	ls_helpfile


ls_helpfile = gnv_app.of_Getappdirectory( ) + "\PTHELP.hlp"

IF li_Return = 1 THEN
	//have value
ELSE
	SetNull ( ls_helpfile )
END IF



RETURN ls_helpfile
end function

public function integer of_openprofittoolswebsite ();//created by Dan 12-2-2005
//Connects to profittools website using the default browser
inet iinet_base 
GetContextService("Internet", iinet_base) 
return iinet_base.HyperlinkToURL("http://www.profittools.net/connect.html") 


end function

on n_cst_helptopic.create
call super::create
end on

on n_cst_helptopic.destroy
call super::destroy
end on

