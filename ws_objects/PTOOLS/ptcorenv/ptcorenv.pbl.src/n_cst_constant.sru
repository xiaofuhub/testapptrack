$PBExportHeader$n_cst_constant.sru
forward
global type n_cst_constant from nonvisualobject
end type
end forward

global type n_cst_constant from nonvisualobject autoinstantiate
end type

type variables
////modify this nvo to a autoinstatntiate nvo by appeon 20070726
Public:
//Note:  For each module entry, you can/should also set a
//display name in n_cst_LicenseManager.of_GetDisplayName()
//Once defined here, these names should not be changed,
//since they are used in the database to record which
//modules are licensed.

//See notes in Constructor of n_cst_LicenseManager
//for full explanation on how to add a module.

CONSTANT String	cs_Module_ContactManager = "ContactManager"
CONSTANT String	cs_Module_OrderEntry = "OrderEntry"
CONSTANT String	cs_Module_Billing = "Billing"
CONSTANT String	cs_Module_Brokerage = "Brokerage"
CONSTANT String	cs_Module_Dispatch = "Dispatch"
CONSTANT String	cs_Module_LogAudit = "Logs"
CONSTANT String	cs_Module_PCMiler = "PCMiler"
CONSTANT String  cs_Module_PCMilerStreets = "PCMilerStreets"
CONSTANT String	cs_Module_Settlements = "Settlements"
CONSTANT String	cs_Module_FuelCard = "FuelCard"
CONSTANT String	cs_Module_FuelTax = "FuelTax"
CONSTANT String	cs_Module_Imaging = "Imaging"
CONSTANT String	cs_Module_Scanning = "Scanning"
CONSTANT String	cs_Module_RouteManager = "RouteManager"
CONSTANT String	cs_Module_Qualcomm = "Qualcomm"
CONSTANT String	cs_Module_InTouch = "InTouch"
CONSTANT String	cs_Module_AtRoad = "AtRoad"
CONSTANT String	cs_Module_Cadec = "Cadec"
CONSTANT String	cs_Module_ClipBoard = "Clipboard"
CONSTANT String  cs_Module_DataManager = "DataManager"
CONSTANT String  cs_Module_AutoRating = "AutoRating"
CONSTANT String  cs_Module_RouteOptimizer = "RouteOptimizer"
CONSTANT String  cs_Module_Notification = "Notification"
CONSTANT String  cs_Module_EDI204 = "EDI204"
CONSTANT String  cs_Module_EDI210 = "EDI"
CONSTANT String	cs_Module_EDI214 = "EDI214"
CONSTANT String  cs_Module_EDI322 = "EDI322"
CONSTANT String  cs_Module_EquipmentPosting = "EquipmentPosting"
CONSTANT String  cs_Module_Nextel = "Nextel"
CONSTANT String  cs_Module_DocumentTransfer = "DocumentTransfer"
CONSTANT String  cs_Module_RailTrace = "RailTrace"


//Note:  These numeric ids are for legacy purposes.
//NOT all modules need to have a numeric id.

CONSTANT Integer	ci_Module_ContactManager = 1
CONSTANT Integer	ci_Module_OrderEntry = 2
CONSTANT Integer	ci_Module_Billing = 3
CONSTANT Integer	ci_Module_Brokerage = 4
CONSTANT Integer	ci_Module_Dispatch = 5
CONSTANT Integer	ci_Module_LogAudit = 6
CONSTANT Integer	ci_Module_PCMiler = 7

CONSTANT Integer	ci_Context_Close = 1
CONSTANT Integer	ci_Context_Selection = 2
CONSTANT Integer	ci_Context_New = 3
CONSTANT Integer	ci_Context_Save = 4

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

Constant Integer	ci_DriverCategory_Singles = 1
Constant Integer	ci_DriverCategory_Teams = 2
Constant Integer	ci_DriverCategory_All = 0

Constant Integer	ci_TitleBarHeight = 84

Constant Integer	ci_SuperSubClass = 2
Constant Integer	ci_SuperClass = 1
Constant Integer	ci_SubClass = -1
Constant Integer	ci_DefaultClass = 0

CONSTANT String 	cs_CommunicationDevice_Qualcomm = "QUALCOMM"
CONSTANT String	cs_CommunicationDevice_Nextel = "NEXTEL"
CONSTANT String 	cs_CommunicationDevice_Intouch = "INTOUCH"
CONSTANT String 	cs_CommunicationDevice_AtRoad = "ATROAD"
CONSTANT String 	cs_CommunicationDevice_Cadec = "CADEC"

CONSTANT String  cs_ClipBoard = "CLIPBOARD"

CONSTANT String 	cs_ReportTopic_Shipment  = "SHIPMENT"
CONSTANT String 	cs_ReportTopic_Event = "EVENT"
CONSTANT String 	cs_ReportTopic_Company = "COMPANY"

CONSTANT String	cs_Document_DeliveryReceipt = "Delivery Receipt"
CONSTANT String	cs_Document_Invoice = "Invoice"
CONSTANT String	cs_Document_Quote = "Quote"
CONSTANT String	cs_Document_RateConfirmation = "Rate Confirmation"

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

// RDT 5-13-03
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

Constant String	cs_TimeZoneCodeTable = "HWI~t0/ALK~t1/PAC~t2/MTN~t3/CTL~t4/EST~t5/ATL~t6/"

Constant Long	cl_Color_Protected = 12648447
Constant String	cs_Color_Protected = "12648447"

Constant Long	cl_Color_NA = 12632256
Constant String	cs_Color_NA = "12632256"

Constant Long	cl_Color_White = 16777215
Constant String	cs_Color_White = "16777215"

Constant Long	cl_Color_Black = 0
Constant String	cs_Color_Black = "0"

Constant Long	cl_Color_Red = 255
Constant String	cs_Color_Red = "255"

Constant Integer	ci_ErrorLog_Urgency_Severe = 1
Constant Integer	ci_ErrorLog_Urgency_Important = 3
Constant Integer	ci_ErrorLog_Urgency_Low = 5
end variables

on n_cst_constant.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_constant.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

