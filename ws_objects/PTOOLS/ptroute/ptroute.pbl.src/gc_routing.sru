$PBExportHeader$gc_routing.sru
forward
global type gc_routing from nonvisualobject
end type
end forward

global type gc_routing from nonvisualobject
end type
global gc_routing gc_routing

type variables
// Type of routing calculations
constant long cl_RouteType_Practical = 0
constant long cl_RouteType_Shortest = 1
constant long cl_RouteType_National = 2
constant long cl_RouteType_AvoidToll = 3
constant long cl_RouteType_Air = 4  	

// Report types
constant long RPT_DETAIL = 0
constant long RPT_STATE = 1
constant long RPT_MILEAGE = 2

// Order of states in reports
constant long STATE_ORDER = 1
constant long TRIP_ORDER = 2

// Options
constant long OPTS_NONE = 0 		// 0x0000L
constant long OPTS_MILES = 1		// 0x0001L
constant long OPTS_CHANGEDEST = 2	// 0x0002L
constant long OPTS_HUBMODE = 4		// 0x0004L
constant long OPTS_BORDERS = 8		// 0x0008L
constant long OPTS_ALPHAORDER = 16	// 0x0010L
constant long OPTS_ERROR = 65535	// 0xFFFFL

// Error codes
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

// Match types
constant long PARTIAL_MATCH = 0
constant long EXACT_MATCH = 1

end variables

on gc_routing.create
TriggerEvent( this, "constructor" )
end on

on gc_routing.destroy
TriggerEvent( this, "destructor" )
end on

