$PBExportHeader$gc_dispatch_appeon.sru
forward
global type gc_dispatch_appeon from nonvisualobject
end type
end forward

global type gc_dispatch_appeon from nonvisualobject autoinstantiate
end type

type variables
Public:
Constant Integer	ci_Assignment_Trip = 20

Constant Integer	ci_ItinType_Driver = 100
Constant Integer	ci_ItinType_PowerUnit = 200
Constant Integer	ci_ItinType_TrailerChassis = 300
Constant Integer	ci_ItinType_Container = 400
Constant Integer	ci_ItinType_Trip = 500
Constant Integer	ci_ItinType_Shipment = 600

Constant Integer	ci_MinIndex_Driver = 1
Constant Integer	ci_MaxIndex_Driver = 1
Constant Integer	ci_MinIndex_PowerUnit = 2
Constant Integer	ci_MaxIndex_PowerUnit = 2
Constant Integer	ci_MinIndex_TrailerChassis = 3
Constant Integer	ci_MaxIndex_TrailerChassis = 5
Constant Integer	ci_MinIndex_Container = 6
Constant Integer	ci_MaxIndex_Container = 9

Constant String	cs_Column_Trip = "de_Trailer"
Constant String	cs_Column_TripSeq = "de_Trailer_Seq"
Constant String	cs_Column_ParentId = "ds_parentid"

Constant String	cs_MultiListDelimiter = ","

Constant String	cs_Context_DispatchShipment = "T"
Constant String	cs_Context_NonRoutedShipment = "D"
Constant String	cs_Context_Itinerary = "I"
Constant String	cs_Context_Trip = "3"

Constant String	cs_EventType_Pickup = "P"
Constant String	cs_EventType_Deliver = "D"
Constant String	cs_EventType_NewTrip = "O"
Constant String	cs_EventType_EndTrip = "F"
Constant String	cs_EventType_Hook = "H"
Constant String	cs_EventType_Drop = "R"
Constant String	cs_EventType_Mount = "M"
Constant String	cs_EventType_Dismount = "N"
Constant String	cs_EventType_Bobtail = "B"
Constant String	cs_EventType_Deadhead = "A"
Constant String	cs_EventType_Reposition = "S"
Constant String	cs_EventType_Misc = "X"
Constant String	cs_EventType_CheckCall = "C"
Constant String	cs_EventType_PositionReport = "U"
Constant String	cs_EventType_Breakdown = "K"
Constant String	cs_EventType_PMService = "V"
Constant String	cs_EventType_Repairs = "Z"
Constant String	cs_EventType_Accident = "T"
Constant String	cs_EventType_DOT = "I"
Constant String	cs_EventType_Scale = "L"
Constant String	cs_EventType_OffDuty = "Y"
Constant String	cs_EventType_Sleeper = "E"
Constant String	cs_EventAction_YardMove = "Y"
Constant String	cs_EventAction_CrossDock = "C"
Constant String	cs_EventAction_ChassisSplit = "S"


Constant Integer	ci_InsertionStyle_Before = 1
Constant Integer	ci_InsertionStyle_After = 2
Constant Integer	ci_InsertionStyle_StartOfDay = 3
Constant Integer	ci_InsertionStyle_EndOfDay = 4
Constant Integer	ci_InsertionStyle_StartOfRoute = 5
Constant Integer	ci_InsertionStyle_EndOfRoute = 6
Constant Integer	ci_InsertionStyle_EmptyDay = 7
Constant Integer	ci_InsertionStyle_StartOfTrip = 8
Constant Integer	ci_InsertionStyle_EndOfTrip = 9
Constant Integer	ci_InsertionStyle_Assignment = 10

Constant String	cs_RouteType_Pickup = "PICKUP"
Constant String	cs_RouteType_Deliver = "DELIVER"
Constant String	cs_RouteType_Any = "ANY"

Constant String	cs_ShipmentStatus_Template = "A"
Constant String	cs_ShipmentStatus_Cancelled = "C"
Constant String	cs_ShipmentStatus_Quoted = "E"
Constant String	cs_ShipmentStatus_Offered = "F"
Constant String	cs_ShipmentStatus_Pending = "H"
Constant String	cs_ShipmentStatus_Open = "K"
Constant String	cs_ShipmentStatus_Authorized = "N"
Constant String	cs_ShipmentStatus_AuditRequired = "Q"
Constant String	cs_ShipmentStatus_Audited = "T"
Constant String	cs_ShipmentStatus_Billed = "W"
Constant String	cs_ShipmentStatus_Declined = "D"

Constant String	cs_ShipDupOpt_Items = "Include Items"
Constant String	cs_ShipDupOpt_Payables = "Include Payables"
Constant String	cs_ShipDupOpt_RefLabels = "Include Ref # Labels"
Constant String	cs_ShipDupOpt_RefValues = "Include Ref # Values"
Constant String	cs_ShipDupOpt_ShipNote = "Include Ship Note"
Constant String	cs_ShipDupOpt_BillNote = "Include Bill Note"
Constant String	cs_ShipDupOpt_NonRouted = "Non-Routed Copy"
Constant String	cs_ShipDupOpt_CustomFields = "Include Custom Fields"
Constant String	cs_ShipDupOpt_BLNum = "Include BL Num"
Constant String	cs_ShipDupOpt_Intermodal = "Include Intermodal"
Constant String	cs_ShipDupOpt_EventNotes = "Include Event Notes"
Constant String	cs_ShipDupOpt_FreightItems = "Include Freight Items"
Constant String	cs_ShipDupOpt_AccItems = "Include Acc. Items"
Constant String	cs_ShipDupOpt_EventDates = "Include Event Dates"
Constant String	cs_ShipDupOpt_EventTimes = "Include Event Times"
Constant String	cs_ShipDupOpt_CopyChild = "Copy Child Shipments"

Constant String	cs_ErrorText_SequenceRange = &
"Could not apply routing sequence numbers."

Constant String	cs_MoveCode_Import = "I"
Constant String	cs_MoveCode_Export = "E"
Constant String	cs_MoveCode_Other = "O"

end variables

on gc_dispatch_appeon.create
call super::create
TriggerEvent( this, "constructor" )
end on

on gc_dispatch_appeon.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

