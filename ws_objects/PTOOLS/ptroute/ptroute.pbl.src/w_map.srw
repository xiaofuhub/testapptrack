$PBExportHeader$w_map.srw
$PBExportComments$copied from deploy
forward
global type w_map from window
end type
type pinstruct from structure within w_map
end type
end forward

type pinstruct from structure
	string		stoplabel
	string		pictpath
	string		locstr
	integer		numstop
end type

global type w_map from window
integer x = 5
integer y = 348
integer width = 3049
integer height = 2064
boolean titlebar = true
string title = "Map"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 16777215
end type
global w_map w_map

type prototypes
Function Long PCMSAbout (String topic, REF String buffer, Long bufLen) LIBRARY "pcmsrv32.dll" alias for "PCMSAbout;Ansi"
Function Long PCMSGetStop (Long tripID, Long which, REF String buffer, Long bufLen) LIBRARY "pcmsrv32.dll" alias for "PCMSGetStop;Ansi"
Function Long PCMSNumStops (Long tripID) LIBRARY "pcmsrv32.dll"
//********************************************************
// PC*MILER/STANDARD-Mapping DLL Interface:
//********************************************************
// Set the labels that appear in a pin's info dialog.
Function Long PCMGSetInfoLabels (String layer,  String ID,	String importance, &
		String symbol, String location, String labels) LIBRARY "pcmgmp32.dll" alias for "PCMGSetInfoLabels;Ansi"

// Add graphical elements (pins, trips, and lines) to map.
Function Long PCMGPlotPin (String layer, String ID, String importance, &
	String symbol, String location, String dataValues) LIBRARY "pcmgmp32.dll" alias for "PCMGPlotPin;Ansi"
Function Long PCMGPlotTrip (String layer, String ID, String importance, &
	String style, String locations, String options) LIBRARY "pcmgmp32.dll" alias for "PCMGPlotTrip;Ansi"
Function Long PCMGPlotLine (String layer, String ID, String importance, &
	String style, String locations) LIBRARY "pcmgmp32.dll" alias for "PCMGPlotLine;Ansi"

// Deleting graphical elements
Function Long PCMGDeletePin (String layer, String ID) LIBRARY "pcmgmp32.dll" alias for "PCMGDeletePin;Ansi"
Function Long PCMGDeleteTrip (String layer, String ID) LIBRARY "pcmgmp32.dll" alias for "PCMGDeleteTrip;Ansi"
Function Long PCMGDeleteLine (String layer, String ID) LIBRARY "pcmgmp32.dll" alias for "PCMGDeleteLine;Ansi"

// Deleting an entire pinmaps at once
Function Long PCMGDeletePinmap (String layer) LIBRARY "pcmgmp32.dll" alias for "PCMGDeletePinmap;Ansi"

// Show, hide, and zoom to pinmaps or individual pins.
Function Long PCMGShowPinmap (String layer, Long showHide) LIBRARY "pcmgmp32.dll" alias for "PCMGShowPinmap;Ansi"
Function Long PCMGFramePinmap (String layer) LIBRARY "pcmgmp32.dll" alias for "PCMGFramePinmap;Ansi"
Function Long PCMGFramePin (String layer, String ID) LIBRARY "pcmgmp32.dll" alias for "PCMGFramePin;Ansi"
Function Long PCMGFrameTrip(String layer, String ID) LIBRARY "pcmgmp32.dll" alias for "PCMGFrameTrip;Ansi"

// Toggle redraw on and off.
Function Long PCMGSetRedraw (Long onOff) LIBRARY "pcmgmp32.dll"

// Info/Debugging
SUBROUTINE PCMGSetDebug (Long level) LIBRARY "pcmgmp32.dll"
Function Long PCMGGetDebug () LIBRARY "pcmgmp32.dll"

// Manage Windows, etc.
Function Long PCMGGetDisplayModule () LIBRARY "pcmgmp32.dll"
Function Long PCMGGetDisplayWindow () LIBRARY "pcmgmp32.dll"
SUBROUTINE PCMGSetDisplayModule (Long module) LIBRARY "pcmgmp32.dll"
SUBROUTINE PCMGSetDisplayWindow (Long window) LIBRARY "pcmgmp32.dll"


//********************************************************
// pmwsmap DLL Interface:
//********************************************************
// Windows function
Function Long GetModuleHandleA (String moduleName) LIBRARY "Kernel32.DLL" alias for "GetModuleHandleA;Ansi"

// Load the map database. Declare the application's name and point to the PC*MILER INI file.
// Returns 1 on success, 0 on failure.
Function Integer PCMGInitMap (String appName, String iniFile) LIBRARY "pcmgw32.dll" alias for "PCMGInitMap;Ansi"

// Cleanup all the pmwsmap map stuff. Only call after map window is closed by user.
// Returns 1 on success, 0 on failure.
Function Integer PCMGCleanupMap () LIBRARY "pcmgw32.dll"

// Creating a new resizable map window with a caption and a frame.
// Pass in the parent's HWND. Returns the map window's HWND.
Function Long PCMGCreateMapWindow (Long parentHWND, String title, Long wid, &
		Long height) LIBRARY "pcmgw32.dll" alias for "PCMGCreateMapWindow;Ansi"

// Create a new map window as a child within the parent window.
// Pass in the parent's HWND. Returns the child map window's HWND.
Function Long PCMGCreateMapChild (Long parentHWND) LIBRARY "pcmgw32.dll"

// Resize the child map window if parent is resized.
// Returns 1 on success, 0 on failure.
Function Integer PCMGResizeMapChild (Integer redraw) LIBRARY "pcmgw32.dll"

// Print the map. Pass 0 for 'showPrintDlg' to bypass Print dialog
Function Long PCMGPrintMap (Integer showPrintDlg, String title) LIBRARY "pcmgw32.dll" alias for "PCMGPrintMap;Ansi"

// Print the map. Pass a printing HDC canvas and a title string for the map.
Function Long PCMGPrintMapOnDC (Long hDC, String title) LIBRARY "pcmgw32.dll" alias for "PCMGPrintMapOnDC;Ansi"

// Copy the map window to the clipboard
Function Long PCMGCopyMap () LIBRARY "pcmgw32.dll"

// Force a redraw
Function Long PCMGRedraw () LIBRARY "pcmgw32.dll"

// Toggle the road legend on/off.
Function Long PCMGToggleRoadLegend () LIBRARY "pcmgw32.dll"

// Toggle scale of miles legend on/off.
Function Long PCMGToggleScale () LIBRARY "pcmgw32.dll"

// Toggle shape points.
Function Long PCMGToggleShapePts () LIBRARY "pcmgw32.dll"

// Toggle user labeling of cities with the mouse.
Function Long PCMGToggleCityPicking () LIBRARY "pcmgw32.dll"

// Toggle user labeling of roads with the mouse.
Function Long PCMGToggleRoadPicking () LIBRARY "pcmgw32.dll"

// Clear all road and city labels.
Function Long PCMGClearLabels () LIBRARY "pcmgw32.dll"

// Add/Remove detail
Function Long PCMGAddDetail () LIBRARY "pcmgw32.dll"
Function Long PCMGRemoveDetail () LIBRARY "pcmgw32.dll"
Function Long PCMGDefaultDetail () LIBRARY "pcmgw32.dll"

// Setting the viewport (zooming in and out)
Function Long PCMGZoomIn () LIBRARY "pcmgw32.dll"
Function Long PCMGZoomOut () LIBRARY "pcmgw32.dll"
Function Long PCMGSetUSWindow () LIBRARY "pcmgw32.dll"
Function Long PCMGSetNAWindow () LIBRARY "pcmgw32.dll"
Function Long PCMGSetCanWindow () LIBRARY "pcmgw32.dll"
//Function PCMGSetMexWindow () LIBRARY "pcmgw32.dll"


// Show and hide layers
Function Long PCMGShowLayer (String layerName) LIBRARY "pcmgw32.dll" alias for "PCMGShowLayer;Ansi"
Function Long PCMGHideLayer (String layerName) LIBRARY "pcmgw32.dll" alias for "PCMGHideLayer;Ansi"

// Plotting text labels
Function Long PCMGPlotLabel (String layer, String ID, String importance, &
	String style, String locations, String options) LIBRARY "pcmgw32.dll" alias for "PCMGPlotLabel;Ansi"
Function Long PCMGDeleteLabel (String layer, String ID) LIBRARY "pcmgw32.dll" alias for "PCMGDeleteLabel;Ansi"

FUNCTION long PCMGSetPinPicking ( integer onOff ) &
	 LIBRARY "pcmgw32.dll"

FUNCTION long PCMGSetRoadLegend ( integer onOff ) &
	 LIBRARY "pcmgw32.dll"


end prototypes

type variables
protected:
s_mapping	istr_Mapping
datastore	ids_Source
//public:			//Changed from public to protected 4/14/05 BKW
long 			il_childwin  //Changed from integer to long 2/20/05 BKW
string 		is_LayerName
string 		is_PCMilerVersion

String		isa_TripColors[] = { "Blue", "DarkYellow", "DarkBlue", "DarkGray", "Gray" }
Integer		ii_LastTripColorIndex
Long			il_LastRouteId

//All possible colors:  Blue, DarkBlue, Green, DarkGreen, Yellow, DarkYellow, Gray, DarkGray, Red, White
//Some of the colors are not included because it's hard to see the pin colors when the pin is on top of the route.


end variables

forward prototypes
public function integer locations ()
public function boolean wf_isstreets ()
protected function integer wf_getroutepinlabel (datastore ads_itin, long al_row, ref string as_pinlabel)
public function integer wf_plottrip (datastore ads_itin, string as_layername, ref string as_routeid, string as_importance, string as_style, string as_routetype)
public function integer wf_plottrip (datastore ads_itin, string as_layername, ref string as_routeid)
public function integer wf_plotstops (datastore ads_itin, string as_layername)
protected function integer wf_getstoppinlabel (datastore ads_itin, long al_row, ref string as_pinlabel)
public function integer wf_plottrip (datastore ads_itin, string as_layername)
public function integer wf_plotpositions (n_cst_beo anva_beolist[])
public function integer wf_getstoppinlabelfrompsr (datastore ads_itin, long al_row, ref string as_pinlabel, ref string as_infolabel)
end prototypes

public function integer locations ();//Revised 4/21/05 BKW to add GPS position capability.  Last recorded GPS position will be used for position plot, 
//if available.  Last confirmed site position will still be listed also in pin detail.  If no GPS position is 
//available, last confirmed site position will be used.

string 	ls_EquipmentId_Column, &
			ls_Locator, &
			ls_Locator_Column, &
			ls_EquipmentType, &
			ls_EquipmentType_Column, &
			ls_EquipmentNumber, &
			ls_EquipmentNumber_Column, &
			ls_DateArrived, &
			ls_DateArrived_Column, &
			ls_TimeArrived, &
			ls_TimeArrived_Column, &
			ls_TimeDeparted, &
			ls_TimeDeparted_Column, &
			ls_EventType, &
			ls_EventType_Column, &
			ls_EventSite, &
			ls_EventSite_Column, &
			ls_LatLong, &
			ls_PositionDate, &
			ls_PositionTime, &
			ls_PositionDateTime, &
			ls_PositionLocation, &
			lsa_Frames[10], &
			ls_PinData, &
			ls_Icon
			
Constant	String	cs_DateFormat = "m/d/yy"
Constant String	cs_TimeFormat = "h:mm A/P"
			
integer  li_Counter, &
			i

Long		ll_Index, &
			ll_ViewRow, &
			ll_IterMax, &
			ll_EquipmentId
			
Boolean	lb_Continue = FALSE, &
			lb_HasMobileComm = FALSE, &
			lb_Framed = FALSE

n_cst_beo lnv_basicBEO
n_cst_bcm lnv_bcm
n_cst_beo lnva_Beo[]
n_cst_beo_equipment lnv_CurrentEquipBeo
n_cst_Events	lnv_Events
n_cst_LicenseManager	lnv_LicenseManager
n_cst_bso_Communication_Manager	lnv_MobileComm
n_cst_MessageData		lnv_MessageData

dataStore lds_View

int 	li_ReturnValue = -1


lb_HasMobileComm = lnv_LicenseManager.of_HasMobileCommunicationsLicense ( )

IF lb_HasMobileComm THEN
	lnv_MobileComm = CREATE n_cst_bso_Communication_Manager
END IF

for i = 1 to 10
	lsa_Frames[i] = ""
next

IF istr_Mapping.Typemap = "L" THEN

	lnva_Beo = istr_Mapping.inva_beoList
	ll_IterMax = upperBound( lnva_Beo )
	if ll_IterMax > 0 then	
		i = 1
		Do While Not IsValid ( lnva_Beo[i] ) 
			i++
		LOOP

		IF i <= ll_IterMax THEN
			lnv_CurrentEquipBeo = lnva_Beo[i]
			lnv_bcm = lnv_CurrentEquipBeo.getbcm()
			lds_View = lnv_bcm.getView()
			ls_Locator_Column = "CurrentEvent_PCM"
			ls_EventSite_Column = "CurrentEvent_Site"
			ls_TimeDeparted_Column = "CurrentEvent_TimeDeparted"
			ls_TimeArrived_Column = "CurrentEvent_TimeArrived"
			ls_EventType_Column =  "CurrentEvent_Type"
			ls_DateArrived_Column = "CurrentEvent_DateArrived"
			ls_EquipmentId_Column = "Equipment_Id"
			ls_EquipmentNumber_Column = "Equipment_Number"
			ls_EquipmentType_Column = "Equipment_Type"
			li_ReturnValue = 1
			lb_Continue = TRUE
		END IF		

	END IF
ELSEIF istr_Mapping.Typemap = "Z" THEN
	lds_View = ids_Source
	ll_IterMax = lds_View.rowCount ( )	
	IF ll_IterMax > 0 THEN
		ls_Locator_Column = "curevco_pcm"
		ls_EventSite_Column = "curevco_name"
		ls_TimeDeparted_Column = "curev_deptime"
		ls_TimeArrived_Column = "curev_arrtime"
		ls_EventType_Column =  "curev_type"
		ls_DateArrived_Column = "curev_arrdate"
		ls_EquipmentId_Column = "eq_id"
		ls_EquipmentNumber_Column = "eq_ref"  
		ls_EquipmentType_Column = "eq_type"
		li_ReturnValue = 1
		lb_Continue = TRUE
	END IF
END IF



IF lb_Continue THEN
	
	for i = 1 to ll_IterMax
		IF istr_Mapping.typeMap = "L" THEN
			IF isValid ( lnva_Beo[i] ) THEN
				lnv_CurrentEquipBeo = lnva_Beo[i]
			ELSE
				CONTINUE
			END IF						
			ll_Index = lnv_currentEquipBeo.getBeoIndex( )
			ll_ViewRow = lds_view.getRowFromRowID ( ll_Index ) 

		ELSEIF istr_Mapping.TypeMap = "Z" THEN
			ll_ViewRow = i
		END IF

	
		ls_Locator = trim(lds_View.getitemstring ( ll_ViewRow , ls_Locator_Column ))  
		ll_EquipmentId = lds_View.GetItemNumber ( ll_ViewRow, ls_EquipmentId_Column )
		

		IF lb_HasMobileComm THEN
			
			DESTROY lnv_MessageData
			lnv_MessageData = CREATE n_cst_MessageData

			IF lnv_MobileComm.of_GetLastRecordedPosition ( ll_EquipmentId, lnv_MessageData ) = 1 THEN
				
				ls_LatLong = lnv_MessageData.of_GetLastPositionLatLong ( "HMSD" /*Hrs Mins Secs Direction Format*/ )
				ls_PositionDate = String ( lnv_MessageData.of_GetLastPositionDate ( ), cs_DateFormat )
				ls_PositionTime = String ( lnv_MessageData.of_GetLastPositionTime ( ), cs_TimeFormat )
				ls_PositionDateTime = ls_PositionDate + " " + ls_PositionTime
				ls_PositionLocation = lnv_MessageData.of_GetLastPositionLocation ( )
				
				IF ls_LatLong > "" THEN
					ls_Locator = ls_LatLong
				END IF
				
			END IF
			
		END IF
		
		
		if isnull(ls_Locator) or len(trim(ls_Locator)) = 0 then
			continue 
		END IF
	
		li_Counter ++
		ls_PinData  = ""
	
		ls_EquipmentNumber = lds_View.getitemstring( ll_ViewRow , ls_EquipmentNumber_Column )
		ls_EquipmentType = lds_View.getitemstring( ll_ViewRow , ls_EquipmentType_Column )
		if isnull(ls_EquipmentNumber) then ls_EquipmentNumber = ""
		if isnull(ls_EquipmentType) then ls_EquipmentType = ""
		ls_EquipmentNumber  =  trim ( gf_eqref( ls_EquipmentType , ls_EquipmentNumber ) )
		ls_EventSite = lds_View.getitemstring( ll_ViewRow, ls_EventSite_Column )  
		ls_TimeDeparted   = string(lds_View.getitemtime( ll_ViewRow, ls_TimeDeparted_Column ), cs_TimeFormat)  
		ls_TimeArrived   = string(lds_View.getitemtime( ll_ViewRow, ls_TimeArrived_Column ), cs_TimeFormat)  
		ls_EventType = lds_View.getitemstring(ll_ViewRow , ls_EventType_Column )  
		ls_DateArrived = string(lds_View.getitemdate( ll_ViewRow, ls_DateArrived_Column ), cs_DateFormat) 
		
		//Although other script areas suggest that there may be a version-dependent syntax difference for ls_Icon, 
		//this version works for both Streets 17 and Std 15, which the other scripts suggest should require 
		//different syntax.  Therefore, I'm going with this, unless testing proves otherwise.

		choose case ls_EquipmentType
			case "T"	
				ls_EquipmentType = "TRACTORS"
				lsa_Frames[1] = "TRACTORS"
				ls_Icon = "red box 5"
			case "S"	
				ls_EquipmentType = "STRT TRUCKS"
				lsa_Frames[2] = "STRT TRUCKS"
				ls_Icon = "red box 5"
			case "N"	
				ls_EquipmentType = "VANS"
				lsa_Frames[3] = "VANS"
				ls_Icon = "red box 5"
			case "V"	
				ls_EquipmentType = "TRAILERS"
				lsa_Frames[4] = "TRAILERS"
				ls_Icon = "yellow box 5"
			case "F"	
				ls_EquipmentType = "FLATBEDS"
				lsa_Frames[5] = "FLATBEDS"
				ls_Icon = "yellow box 5"
			case "R"	
				ls_EquipmentType = "REEFERS"
				lsa_Frames[6] = "REEFERS"
				ls_Icon = "yellow box 5"
			case "K"	
				ls_EquipmentType = "TANKS"
				lsa_Frames[7] = "TANKS"
				ls_Icon = "yellow box 5"
			case "B"	
				ls_EquipmentType = "RAILBOXES"
				lsa_Frames[8] = "RAILBOXES"
				ls_Icon = "green box 5"
			case "H"	
				ls_EquipmentType = "CHASSIS"
				lsa_Frames[9] = "CHASSIS"
				ls_Icon = "blue box 5"
			case "C"	
				ls_EquipmentType = "CONTAINERS"
				lsa_Frames[10] = "CONTAINERS"
				ls_Icon = "darkgreen box 5"
		end choose
	
	
		CHOOSE CASE ls_EquipmentType
				
			CASE "TRACTORS", "STRT TRUCKS", "VANS"
				
				ls_PinData += ls_EquipmentNumber   //Switched to using Equip# as Label 4/21/05, since position may not be at company site due to GPS positioning
				ls_PinData += " |"
				
			CASE ELSE

				IF isnull(ls_EventSite) THEN ls_PinData += "" ELSE ls_PinData += Left ( ls_EventSite, 6 )
				ls_PinData += " |"
				
		END CHOOSE

		
		IF IsNull ( ls_PositionLocation ) THEN ls_PinData += "" ELSE ls_PinData += ls_PositionLocation
		ls_PinData += " |"
		
		IF IsNull ( ls_PositionDateTime ) THEN ls_PinData += "" ELSE ls_PinData += ls_PositionDateTime
		ls_PinData += " |"
		
		IF IsNull ( ls_EventSite ) THEN ls_PinData += "" ELSE ls_PinData += ls_EventSite
//		ls_PinData += " |"   Changed this to one data point to conserve space in the popup.
		ls_EventType = lnv_Events.of_GetTypeDisplayValue ( ls_EventType )
		IF IsNull ( ls_EventType ) THEN ls_PinData += "" ELSE ls_PinData += " (" + ls_EventType + ")"
		ls_PinData += " |"
		
		if isnull(ls_DateArrived) then ls_PinData += "" else ls_PinData += ls_DateArrived
		ls_PinData += " |"
		
		if isnull(ls_TimeArrived) then ls_PinData += "" else ls_PinData += ls_TimeArrived
		ls_PinData += " |"
		
		if isnull(ls_TimeDeparted) then ls_PinData += "" else ls_PinData += ls_TimeDeparted
		ls_PinData += " |"

		if This.PCMGPlotPin ( ls_EquipmentType, ls_EquipmentNumber, "1", ls_Icon, ls_Locator, ls_PinData ) < 0 then 
			li_Counter --
		end if
		
	next

	IF li_Counter = 0 THEN 
		li_ReturnValue = -1
	ELSE
		
		for i = 1 to 10
			IF len ( trim ( lsa_Frames[i] ) ) > 0 THEN
				This.PCMGSetInfoLabels ( lsa_Frames[i], "", "", "", "Location", "Label|GPS Loc|GPSDtTm|Last Site|Date|Arrived|Departed" )
				IF lb_Framed = FALSE THEN
					This.PCMGFramePinMap ( lsa_Frames[i] )
					lb_Framed = TRUE
				END IF
			END IF
		next

		//Added 5/3/05 BKW
		//If only one pin, the map draws zoomed excessively tight.  Zoom out 4 units.
		IF li_Counter = 1 THEN
			FOR i = 1 TO 4
				This.PCMGZoomOut ( )
			NEXT
		END IF
		//

	END IF
	
END IF

DESTROY lnv_MobileComm
DESTROY lnv_MessageData

return li_ReturnValue


end function

public function boolean wf_isstreets ();//Indicate whether the Standard (ancestory) or Streets (descendant) version of the window has been opened.
//This function will be overridden on the Streets descendant in order to implement this distinction.

RETURN FALSE
end function

protected function integer wf_getroutepinlabel (datastore ads_itin, long al_row, ref string as_pinlabel);//See note regarding # of available elements, length of elements in wf_GetStopPinLabel

n_cst_Events	lnv_Events

Long	 ll_RowCount, ll_Row
String ls_SiteName, ls_EventType, ls_DepartTime, ls_PinLabel

Integer	li_Return = 1

as_PinLabel = ""


IF li_Return = 1 THEN

	if al_Row = 0 or isnull(al_Row) then
		li_Return = 0
	END IF
	
END IF


IF li_Return = 1 THEN

	ll_RowCount = ads_Itin.rowcount()
	
	ls_SiteName = ads_Itin.getitemstring(al_Row, "co_name")
	
//	Changed to add a 6-character label, to reduce clutter.  4/29/05 BKW	
//	if isnull( ls_SiteName ) then
//		ls_PinLabel = " |"
//	else
//		ls_PinLabel = ls_SiteName + "|"
//	end if	
	
	if isnull( ls_SiteName ) then
		ls_SiteName = " "
	end if
	ls_PinLabel += Left ( ls_SiteName, 6 ) + "|"
	ls_PinLabel += ls_SiteName + "|"
	
	ll_Row = al_Row
	
	fillit:
	ls_EventType = ads_Itin.getitemstring(ll_Row, "de_event_type")
	ls_DepartTime = string(ads_Itin.getitemtime(ll_Row, "comp_dep"), "h:mm A/P")
	
	ls_PinLabel += lnv_Events.of_GetTypeDisplayValue ( ls_EventType )
	
	if ll_Row < ll_RowCount then
		if ads_Itin.getitemstring(ll_Row, "co_pcm") = &
			ads_Itin.getitemstring(ll_Row + 1, "co_pcm") then
			ll_Row ++
			if not isnull(ads_Itin.getitemstring(ll_Row, "de_event_type")) and &
				len(trim(ads_Itin.getitemstring(ll_Row, "de_event_type"))) > 0 then ls_PinLabel += ", "
			goto fillit
		end if
	end if
	ls_PinLabel += "|"
	if isnull(ads_Itin.getitemtime(al_Row, "comp_arr")) then 
		ls_PinLabel += " |"
	else
		ls_PinLabel += string(ads_Itin.getitemtime(al_Row, "comp_arr"), "h:mm A/P") + "|"
	end if
	
	if isnull(ls_DepartTime) then 
		ls_PinLabel += " |"
	else
		ls_PinLabel += ls_DepartTime + "|"
	end if
	
END IF


//If all is ok, pass the pinlabel value out in as_PinLabel

IF li_Return = 1 AND ls_PinLabel > "" THEN
	
	as_PinLabel = ls_PinLabel
	
END IF


RETURN li_Return
end function

public function integer wf_plottrip (datastore ads_itin, string as_layername, ref string as_routeid, string as_importance, string as_style, string as_routetype);//modified by Dan 11-28-2005 to check for system settings specifieing a psr to load from instead
//of the default.

integer	li_Row, li_RowCount, li_StopCount
string	ls_Route, ls_Pcm, ls_LastPcm, ls_PinLabel, ls_PinColor
String	ls_psr
Long		lla_ids[]
Datastore	lds_temp
String		ls_infoLabel
Boolean		lb_proceed

//Blue, DarkBlue, Green, DarkGreen,
//Yellow, DarkYellow, Gray, DarkGray, Red,
//White
Long		ll_retrieveRes
Integer	li_Return = 1
n_cst_setting_tripPinInfo	inv_tripInfo

IF li_Return = 1 THEN

	IF NOT IsValid ( ads_Itin ) THEN
		
		li_Return = -1
		
	END IF
	
END IF
		

IF li_Return = 1 THEN

	IF IsNull ( as_Importance ) OR as_Importance = "" THEN
		as_Importance = "1"  //Highest importance -- always show.
	END IF
	
	IF IsNull ( as_Style ) OR as_Style = "" THEN
		
		ii_LastTripColorIndex ++
		
		IF ii_LastTripColorIndex > UpperBound ( isa_TripColors ) THEN
			ii_LastTripColorIndex = 1
		END IF
		
		as_Style = isa_TripColors [ ii_LastTripColorIndex ] + "|5"  //5 pixels wide.
		
	END IF
	
	//Added 4.0.41 8/8/05 BKW.  NOTE:  Default for driving instructions on w_itin uses
	//SettlementsRouteType (setting 12).  But mapping has not been doing this.
	IF IsNull ( as_RouteType ) OR as_RouteType = "" THEN
		as_RouteType = "PRAC|NOHUB|CLOSED"  //Practical, Non-Hub, Borders Closed
	END IF
	
END IF


IF li_Return = 1 THEN

	li_RowCount = ads_Itin.RowCount ( )
	
	
	//Dan added-----
	IF	li_rowCount > 0 THEN
		
		inv_tripInfo = CREATE n_cst_setting_tripPinInfo
		
		//check to see if there is a system setting that specifies where ls_pinLabel comes from
		ls_psr = inv_tripInfo.of_getvalue( ) //"V:\Code Snips\PTS\PTSMap.psr"		//!!!change this to get the system setting
		IF ls_psr > "" THEN
			//since we are loading from the psr instead, we need to get the arguments from
			//ads_itin in order to retrieve on it.  The arguments consist of an array of long ids.
			lla_ids = ads_itin.object.de_id.Primary			//this gets all the ids
			
			lds_temp = Create Datastore
			lds_temp.dataObject = ls_psr
			lds_temp.setTransObject( sqlca )
			ll_retrieveRes = lds_temp.retrieve( lla_ids )
			COMMIT;
			
			//if our retrieve failed, then we will do the default behavior
			IF ll_retrieveRes < 0 THEN
				ls_psr = ""
				ls_infoLabel = "Label|Site|Event|Arrive|Depart"
			END IF
			
		ELSE
			//this used to be the hardcoded value which stays the same if we are not
			//loading from a PSR
			ls_infoLabel = "Label|Site|Event|Arrive|Depart"
		END IF
		
	END IF	
	//-----------------
	
	for li_Row = 1 to li_RowCount
		
		ls_Pcm = trim(ads_Itin.getitemstring(li_Row, "co_pcm"))
		if isnull(ls_Pcm) or len(trim(ls_Pcm)) = 0 then	continue
	
		if ls_Pcm <> ls_LastPcm then
			
			ls_LastPcm = ls_Pcm
			
			IF li_StopCount > 0 THEN
				ls_Route += "|"
			END IF
			
			ls_Route += ls_Pcm
			li_StopCount ++
			
			
			//---Aded by Dan----------
			IF ls_psr > "" THEN
				// if they specified a psr instead of the default, the following function will
				// pass back the correck ls_pinLabel, and InfoLabel. 
				IF	this.wf_getStopPinLabelFromPSR( lds_temp, li_row, ls_pinLabel,ls_infoLabel ) = 1 THEN
					lb_proceed = TRUE 
				ELSE
					lb_proceed = false
				END IF
				
			ELSEIF This.wf_GetStopPinLabel ( ads_Itin, li_Row, ls_PinLabel ) = 1 THEN
				lb_proceed = true
			ELSE
				lb_proceed = false
			END IF
			//--------------
			
			
			IF lb_proceed THEN
				
				IF ads_Itin.GetItemString ( li_Row, "de_conf" ) = "T" THEN
					//Stop is confirmed complete.  Color it gray.
					ls_PinColor = "Gray"
				ELSE
					ls_PinColor = "DarkYellow"
				END IF
				
	
				//Plot the pin.  Style syntax varies slightly based on version.
				//Use importance "4..6" for the pins, so that they don't show until the user drills in a bit, and won't clutter the screen.
				
				choose case is_PCMilerVersion  //2/20/05 BKW  Changed to use is_PCMilerVersion instead of getting the value again locally in ls_About

					//Changed layers from 3..6 to 2..6 4.0.41 8/17/05 BKW to have greater visibility of pins
					//Changed layers from 2..6 to 1..6 4.0.45 9/01/05 BKW to have greater visibility of pins
	
					case /*Std Versions:*/ "11.0", "12.0", "2000.0", "14.0", "15.0", /*Streets Versions:*/ "4.0", "1.0"
						PCMGPlotPin ( as_LayerName + " Stop Pins", "Stop: " + string(li_StopCount, "00"), "1..6", ls_PinColor + "|circle", ls_Pcm, ls_PinLabel)
						
					case else
						PCMGPlotPin ( as_LayerName + " Stop Pins", "Stop: " + string(li_StopCount, "00"), "1..6", ls_PinColor + " circle 5", ls_Pcm, ls_PinLabel)			
						//PCMGFrameTrip(as_LayerName, "")   Commented 4/14/05 BKW   Not necessarily one trip anymore
						
				end choose	
				
			END IF
			
		end if
		
	next
	
	
	IF li_StopCount > 0 THEN
		
		This.PCMGSetInfoLabels ( as_LayerName + " Stop Pins", "", "", "", "Location", ls_infoLabel )
		This.PCMGSetPinPicking ( 1 )
		
	END IF
	
	
	IF li_StopCount > 1 THEN
		
		IF len ( trim ( ls_Route ) ) > 0 THEN
			
			//Generate a unique route id.  This will be unique within the map window, but is that what they mean,
			//or do they want globally unique??
			il_LastRouteId ++
			as_RouteId = String ( il_LastRouteId )
			
			This.PCMGPlotTrip ( as_LayerName, as_RouteId, as_Importance, as_Style, ls_Route, as_RouteType )
			
		END IF
	
	END IF
	
END IF

IF isValid( lds_temp ) THEN
	DESTROY lds_temp
END IF

IF isValid (inv_tripInfo) THEN
	DESTRoY inv_tripInfo
END IF

RETURN li_Return
end function

public function integer wf_plottrip (datastore ads_itin, string as_layername, ref string as_routeid);Integer	li_Return = 1

String	ls_Null
SetNull ( ls_Null )

li_Return = This.wf_PlotTrip ( ads_Itin, as_LayerName, as_RouteId, ls_Null /*Importance*/, ls_Null /*Style*/, ls_Null /*RouteType*/ )

RETURN li_Return
end function

public function integer wf_plotstops (datastore ads_itin, string as_layername);//modified by Dan 11-28-2005 to check for system settings specifieing a psr to load from instead
//of the default.

integer	li_Row, li_RowCount, li_ShipSeq
string	ls_Route, ls_Pcm, ls_EventType, ls_PinLabel, ls_PinColor, ls_LayerName, ls_Id
String	ls_PickupLayer, ls_DeliveryLayer, ls_MiscLayer
Long		ll_Shipment
Boolean	lb_HasPickups
Boolean	lb_HasDeliveries
Boolean	lb_HasMisc
n_cst_beo_Event	lnv_Event
n_cst_Events		lnv_Events

Boolean	lb_proceed
String	ls_psr
String	ls_infoLabel
Long		lla_ids[]
Long		ll_retrieveRes
Datastore	lds_temp

Integer	li_Return = 1

ls_PickupLayer = as_LayerName + " : Pickups"
ls_DeliveryLayer = as_LayerName + " : Deliveries"
ls_MiscLayer = as_LayerName + " : Misc Stops"

li_RowCount = ads_Itin.RowCount ( )

lnv_Event = CREATE n_cst_beo_Event
lnv_Event.of_SetSource ( ads_Itin )

n_cst_setting_unnAssignedPinInfo inv_stopInfo

//Dan added-----
IF	li_rowCount > 0 THEN
	
	inv_stopInfo = CREATE n_cst_setting_unnAssignedPinInfo
	
	//check to see if there is a system setting that specifies where ls_pinLabel comes from
	ls_psr =  inv_stopInfo.of_getValue( )   //"V:\Code Snips\PTS\PTSMap.psr"		//!!!change this to get the system setting
	IF ls_psr > "" THEN
		//since we are loading from the psr instead, we need to get the arguments from
		//ads_itin in order to retrieve on it.  The arguments consist of an array of long ids.
		lla_ids = ads_itin.object.de_id.Primary			//this gets all the ids
		
		lds_temp = Create Datastore
		lds_temp.dataObject = ls_psr
		lds_temp.setTransObject( sqlca )
		ll_retrieveRes = lds_temp.retrieve( lla_ids )
		COMMIT;
		
		//if our retrieve failed, then we will do the default behavior
		IF ll_retrieveRes < 0 THEN
			ls_psr = ""
			ls_infoLabel = "Label|Site|Event|Arrive|Depart"
		END IF
	
	ELSE
		//this used to be the hardcoded value which stays the same if we are not
		//loading from a PSR
		ls_infoLabel = "Label|Site|Event|Appt Date|Appt Time"
	END IF
	
END IF

//-----------------

for li_Row = 1 to li_RowCount
	
	lnv_Event.of_SetSourceRow ( li_Row )
	
	
	ls_Pcm = trim(ads_Itin.getitemstring(li_Row, "co_pcm"))
	if isnull(ls_Pcm) or len(trim(ls_Pcm)) = 0 then	continue
	
	//---Aded by Dan----------
	IF ls_psr > "" THEN
		// if they specified a psr instead of the default, the following function will
		// pass back the correck ls_pinLabel, and InfoLabel. 
		IF	this.wf_getStopPinLabelFromPSR( lds_temp, li_row, ls_pinLabel,ls_infoLabel ) = 1 THEN
			lb_proceed = TRUE 
		ELSE
			lb_proceed = false
		END IF
		
	ELSEIF This.wf_GetStopPinLabel ( ads_Itin, li_Row, ls_PinLabel ) = 1 THEN
		lb_proceed = true
	ELSE
		lb_proceed = false
	END IF
	//--------------
	IF lb_proceed THEN
		
		ll_Shipment = lnv_Event.of_GetShipment ( )
		li_ShipSeq = lnv_Event.of_GetShipmentSequence ( )
		ls_EventType = lnv_Event.of_GetType ( )
		
		IF ll_Shipment > 0 AND li_ShipSeq > 0 THEN
			ls_Id = String ( ll_Shipment, "0000" ) + " : " + String ( li_ShipSeq )
		ELSE
			ls_Id = "Non-Shipment Event " + String ( lnv_Event.of_GetId ( ) )
		END IF
		
		IF lnv_Events.of_IsTypePickupGroup ( ls_EventType ) THEN
			//Stop is a pickup group event.
			lb_HasPickups = TRUE
			ls_LayerName = ls_PickupLayer
			ls_PinColor = "Green"
		ELSEIF lnv_Events.of_IsTypeDeliverGroup ( ls_EventType ) THEN
			//Stop is a deliver group event.
			lb_HasDeliveries = TRUE
			ls_LayerName = ls_DeliveryLayer
			ls_PinColor = "Red"
		ELSE
			//Stop is neither type.
			lb_HasMisc = TRUE
			ls_LayerName = ls_MiscLayer
			ls_PinColor = "Pink"
		END IF
		

//		//Plot the pin.  Style syntax varies slightly based on version.
//		//Use importance "4..6" for the pins, so that they don't show until the user drills in a bit, and won't clutter the screen.
//		
//		choose case is_PCMilerVersion  //2/20/05 BKW  Changed to use is_PCMilerVersion instead of getting the value again locally in ls_About
//
//			case /*Std Versions:*/ "11.0", "12.0", "2000.0", "14.0", "15.0", /*Streets Versions:*/ "4.0", "1.0"
//				PCMGPlotPin ( ls_LayerName, ls_Id, "1", ls_PinColor + "|box", ls_Pcm, ls_PinLabel)
//				
//			case else
//				PCMGPlotPin ( ls_LayerName, ls_Id, "1", ls_PinColor + " box 5", ls_Pcm, ls_PinLabel)			
//				
//		end choose	


		//The syntax distinctions above do not apply for the "warehouse" icon, and actually cause it not
		//to work, at least under v 15.0.  Use one syntax unless testing proves otherwise.
		This.PCMGPlotPin ( ls_LayerName, ls_Id, "1", ls_PinColor + " warehouse", ls_Pcm, ls_PinLabel)
		
	END IF
	
next

IF lb_HasPickups THEN
	This.PCMGSetInfoLabels ( ls_PickupLayer, "", "", "", "Location", ls_infoLabel )
	This.PCMGFramePinMap ( ls_PickupLayer )
END IF

IF lb_HasDeliveries THEN
	This.PCMGSetInfoLabels ( ls_DeliveryLayer, "", "", "", "Location", ls_infoLabel )
	This.PCMGFramePinMap ( ls_DeliveryLayer )
END IF

IF lb_HasMisc THEN
	This.PCMGSetInfoLabels ( ls_MiscLayer, "", "", "", "Location", ls_infoLabel )
END IF

This.PCMGSetPinPicking ( 1 )
This.PCMGSetRoadLegend ( 0 )

//Added 4.0.45 BKW  When only one stop, map zoomed way too tight.
//Hard to know even with multiple stops whether they may be right on top of each other,
//so zoom all the way out and let them zoom back in.
This.PCMGSetUSWindow ( )

IF isValid( lds_temp ) THEN
	DESTROY lds_temp
END IF
DESTROY lnv_Event

IF isValid ( inv_stopInfo ) THEN
	Destroy inv_stopInfo
END IF

RETURN li_Return
end function

protected function integer wf_getstoppinlabel (datastore ads_itin, long al_row, ref string as_pinlabel);//Note:  BKW 9/1/05
//Based on testing, it appears that you can have up to 9 data elements (including the first element, the label)
//There doesn't appear to be any specific limit on # of characters per field (data will wrap to multiple lines)
//but once the popup box is full, it doesn't display any more data.  So, you probably want to either truncate 
//potentially long fields, or put them at the end.

n_cst_Events	lnv_Events

String ls_SiteName, ls_EventType, ls_ScheduledDate, ls_ScheduledTime, ls_PinLabel

Integer	li_Return = 1

as_PinLabel = ""


IF li_Return = 1 THEN

	if al_Row = 0 or isnull(al_Row) then
		li_Return = 0
	END IF
	
END IF


IF li_Return = 1 THEN
	
	ls_SiteName = ads_Itin.getitemstring(al_Row, "co_name")
	ls_EventType = ads_Itin.getitemstring ( al_Row, "de_event_type" )
	ls_EventType = lnv_Events.of_GetTypeDisplayValue ( ls_EventType )
	ls_ScheduledDate = String ( ads_Itin.GetItemDate ( al_Row, "de_apptdate" ), "m/d" )
	ls_ScheduledTime = String ( ads_Itin.GetItemTime ( al_Row, "de_appttime" ), "h:mm A/P" )

	if isnull( ls_SiteName ) then
		ls_SiteName = " "
	end if
	ls_PinLabel += Left ( ls_SiteName, 6 ) + "|"
	ls_PinLabel += ls_SiteName + "|"
	
	ls_PinLabel += ls_EventType + "|"
	
	IF IsNull ( ls_ScheduledDate ) THEN 
		ls_ScheduledDate = " "
	END IF
	ls_PinLabel += ls_ScheduledDate + "|"
	
	IF IsNull ( ls_ScheduledTime ) THEN 
		ls_ScheduledTime = " "
	END IF
	ls_PinLabel += ls_ScheduledTime + "|"
	
END IF


//If all is ok, pass the pinlabel value out in as_PinLabel

IF li_Return = 1 AND ls_PinLabel > "" THEN
	
	as_PinLabel = ls_PinLabel
	
END IF


RETURN li_Return
end function

public function integer wf_plottrip (datastore ads_itin, string as_layername);//This version allows you to call the function without providing the ls_RouteId reference argument, 
//or the other parameters of the full version.

Integer	li_Return = 1

String	ls_RouteId

li_Return = This.wf_PlotTrip ( ads_Itin, as_LayerName, ls_RouteId )

RETURN li_Return
end function

public function integer wf_plotpositions (n_cst_beo anva_beolist[]);//Wrapper function to allow plotting positions of equipment beo's onto an
//existing map.  Uses the old plotting function, but sets up the instance
//structure appropriately.

s_Mapping	lstr_Mapping

Integer	li_Return = 1

lstr_Mapping.TypeMap = "L"
lstr_Mapping.inva_BEOList = anva_BEOList

istr_Mapping = lstr_Mapping

CHOOSE CASE This.Locations ( )
		
	CASE 1  //OK
		this.pcmgsetpinpicking(1)
		this.pcmgsetroadlegend(0)
		
	CASE ELSE  //-1 = nothing to plot
		li_Return = 0
		
END CHOOSE

RETURN li_Return
end function

public function integer wf_getstoppinlabelfrompsr (datastore ads_itin, long al_row, ref string as_pinlabel, ref string as_infolabel);/***************************************************************************************
NAME: 	wf_getStopPinLabelFromPsr		

ACCESS:			public
		
ARGUMENTS: 		
							ads_itin:	the datastore that has tags in it in which we will use to create as_infoLabel and as_pinLabel
							al_row:		The row of ads_itin we are looking at.
							as_infolabel:	The label that we create if it doesn't already exist, that displays the Field labels
							as_pinlabel: 	The values that we create which correspond to as_infoLabel
							

RETURNS:			1 if it succeeds
					0 if nothing happens
	
DESCRIPTION:	The following function generates as_infoLabel from the tags in ads_itin if
					it doesn't exist when this is called.  It also creates the as_pinLabel from
					the specified row of ads_itin.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	11-28-05
	

***************************************************************************************/

//Note copied from wf_getStopPinLabel:  BKW 9/1/05
//Based on testing, it appears that you can have up to 9 data elements (including the first element, the label)
//There doesn't appear to be any specific limit on # of characters per field (data will wrap to multiple lines)
//but once the popup box is full, it doesn't display any more data.  So, you probably want to either truncate 
//potentially long fields, or put them at the end.

n_cst_Events	lnv_Events

String 	ls_field
String	ls_pinLabel
String	ls_infoLabel
String	ls_value
String	ls_label
String	ls_columnTag

Integer	li_Return = 1
Long		ll_max 
Long		ll_index
Int		li_res

n_cst_String		lnv_StringService

as_PinLabel = ""


IF li_Return = 1 THEN

	if al_Row = 0 or isnull(al_Row) then
		li_Return = 0
	END IF
	
END IF


IF li_Return = 1 THEN

	ls_field = "field_"		// the order in which i build the pin label and info label is determined by
									//ls_field = field_1, field_2, field_3...etc
		
		
	ll_max = 9				//for now there is at most 9 because of the comment at the top,
								//Otherwise we would do the total number of columns or computed fields.
	FOR ll_index = 1 TO ll_max
		//reset vars		
		ls_value = ""
		ls_label = ""
		
		//find out if the next field exists
		//li_res = ads_itin.setsort(ls_field + string( ll_index )+" A")	
		
		ls_columnTag = ads_itin.Describe(ls_field + String( ll_index )+".tag")
		
		//if it exists, read the data, read the tag
		IF ls_columnTag <> "!" AND ls_columnTag <> "?" THEN
			ls_value = ads_Itin.getItemString( al_row, ls_field + String( ll_index ) )
			
			//gets the label from tag
			ls_label = lnv_StringService.of_GetKeyValue (ls_columnTag, "label", ";")
			
			//if the label value is botched, then we default it to 'Field n'
			IF ls_label = "" OR isNULL(ls_label) THEN
				ls_label = "Field "+ string( ll_index )
			END IF
		
				
			//gets the value and parses it into the ls_Pinlabel string
			IF isNull( ls_value ) OR ls_value = "" THEN
				ls_value = " "
			END IF
			ls_pinLabel += ls_value+"|"
			
			//we only set up as_infoLabel the first time we enter this function
			//It is the same throughout any other calls to this function.
			IF len( as_infoLabel ) = 0 THEN
				IF ls_label > "" THEN
					ls_infoLabel += ls_label+"|"
				END IF
				
			END IF
			
		END IF
	NEXT
	

	
END IF


//If all is ok, pass the pinlabel value out in as_PinLabel

IF li_Return = 1 AND ls_PinLabel > "" THEN
	
	as_PinLabel = ls_PinLabel
	IF len( as_infoLabel ) = 0 THEN
		IF RIGHT( ls_infoLabel , 1 ) = "|" THEN
			as_infolabel = left( ls_infoLabel, len( ls_infoLabel ) - 1 )
		ELSE
			as_infoLabel = ls_infoLabel
		END IF
	END IF
END IF


RETURN li_Return
end function

on w_map.create
end on

on w_map.destroy
end on

event open;/*		Purpose:  this window will map a route or a location of object.
		The window must be opened with a powerobjectparm of type s_mapping. (global sturc)
		Here are the possible settings for s_mapping:
			typemap - (a letter) 
				"R" = Route 
				"L" = Locations
			dw_source - a datawindow with pcmvals, the only current acceptable type is "d_itin"
			ds_source - a datastore with pcmvals, the only current acceptable type is "d_itin"
			xpos - nullint or an xpos, the map will default to the top and centered
			ypos - "

			if typemap = "R" (routing map) then the programmer can specify types of routes
			typeroute - a capitol letter
				"P" = Practical route			(default)
				"N" = National highways only
				"T" = Avoid Tolls if possible
				"S" = Shortest route
			hubs -
				"H" = hubs on
				"N" = no hubs			(default)
			borders -
				"O" = open borders
				"C" = borders closed	 (default)  (Changed 4.0.41 8/5/05 BKW)
	If anything fails, the map will open to the USA with no locations or routes
Declare a window of this type in the parent window that calls is.  Check to make sure this
window isn't already opened before it is opened again.  This window is a pop up!!
Make sure that it is close if the parent is closed!!!!!!!.
--------------------------------------------------------------------------------------*/
//streets - add n_cst_trip to s_mapping
istr_Mapping = message.powerobjectparm

n_cst_LicenseManager	lnv_LicenseManager

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_PCMiler ) or &
	lnv_LicenseManager.of_usepcmilerstreets() THEN
	//ok to proceed
	IF pcmm_inst = FALSE THEN
		MessageBox ( This.Title, "You must set the 'PC*Miler Mapping Installed' setting in System Settings to 'YES' "+&
		"in order to use this feature.  You will also need to exit and restart Profit Tools in order for the "+&
		"change to take effect." )
		Close ( This )
		RETURN
	end if
else
	MessageBox ( This.Title, "You must have a Profit Tools PC*Miler Interface license in order to use this feature." +&
		"  Please contact your Profit Tools sales representative, or Profit Tools technical support." )
		Close ( This )
		RETURN
END IF

if lnv_LicenseManager.of_getpcmilerserverid() > 0 then
	//connected
else
	MessageBox ( This.Title, "PC*Miler connection has not been established.")
	Close ( This )
	RETURN
end if

/*  Commented 4/15/05 BKW  Go with a full-screen map size, ignore these settings.
n_cst_numerical lnv_numerical

if lnv_numerical.of_IsNullOrNotPos(istr_Mapping.xpos) then 
	this.x = 594
else
	this.x = istr_Mapping.xpos
end if

//if isnull(istr_Mapping.ypos) or istr_Mapping.ypos <= 0 then 
//	this.y = 5
//else
//	this.y = istr_Mapping.ypos
//end if
 
this.y = 281

*/

This.Width = gnv_App.of_GetFrame().WorkspaceWidth() - 10
This.Height = gnv_App.of_GetFrame().WorkspaceHeight() - 180

long ll_WindowHandle
ll_WindowHandle = handle(this)

//get PCMiler version
string ls_version, ls_buffer, ls_pcmgini
integer li_bufferlen
li_bufferlen = 256
is_pcmilerversion=space(li_bufferlen)
ls_version="ProductVersion"

PCMSAbout(ls_version,is_pcmilerversion,li_bufferlen)

IF This.wf_IsStreets ( ) THEN
	
	ls_PCMGIni = "pmwssrv.ini"

ELSE

	choose case is_pcmilerversion
		case "11.0", "12.0", "2000.0"
			ls_pcmgini = "pcmgwin.ini"
		case else //  14.0, 15.0
			ls_pcmgini = ""
	end choose

END IF

if this.PCMGInitMap(null_str, ls_pcmgini) = 1 then
	il_ChildWin = this.PCMGCreateMapChild(ll_WindowHandle)
else
//	beep(1)
end if

//if il_ChildWin < 0 then 
//	//essagebox("Programmer's Warning","The child handle is long for the very first time!")
//	close(this)
//	return
//end if

this.pcmgsetdisplaywindow(il_ChildWin)


if len(istr_Mapping.layername) > 0 then is_LayerName = istr_Mapping.layername

IF istr_Mapping.typemap = "L" THEN
	
	this.title = "Equipment Location Map"
	
	IF is_LayerName = "" THEN   //Added 4/15/05 BKW
		is_LayerName = "Positions"
	END IF
	
	if locations() = -1 then
		messagebox("Mapping Equipment", "There is no equipment that can be mapped.")
		close(this)
		return
	else
		this.pcmgsetpinpicking(1)
		this.pcmgsetroadlegend(0)
	end if
		
ELSEIF istr_Mapping.typemap = "B" THEN  //Blank

	This.PCMGSetUSWindow ( )  //Zoom in at least a little bit.

ELSE
	ids_Source = CREATE datastore 
	if isvalid(istr_Mapping.dw_source) then
		if istr_Mapping.dw_source.rowcount() = 0 then return
		ids_Source.DataObject = istr_Mapping.dw_source.dataobject
		ids_Source.object.data.primary = istr_Mapping.dw_source.object.data.primary
	elseif isvalid(istr_Mapping.ds_source) then
		if istr_Mapping.ds_source.rowcount() = 0 then return
		ids_Source.DataObject = istr_Mapping.ds_source.dataobject
		ids_Source.object.data.primary = istr_Mapping.ds_source.object.data.primary
	elseif not isnull(istr_Mapping.valid_tripid) and istr_Mapping.valid_tripid > 0 then
		integer li_StopCount, li_StopIndex, li_NewRow
		string ls_pcm
		li_StopCount = this.pcmsnumstops(istr_Mapping.valid_tripid)
		ids_Source.DataObject = "d_itin"
		for li_StopIndex = 0 to (li_StopCount - 1)
			ls_pcm = space(128)
			pcmsgetstop(istr_Mapping.valid_tripid, li_StopIndex, ls_pcm, 128)
			li_NewRow = ids_Source.insertrow(0)
			ids_Source.setitem(li_NewRow, "co_pcm", ls_pcm)
//			ids_Source.setitem(li_NewRow, "co_pcm", lnv_bso_pcmiler.of_formatlocater(pcm, "ALL"))
		next
	else
		close(this)
		return
	end if

	IF istr_Mapping.typemap = "Z" THEN
		this.title = "Equipment Location Map"
		
		IF is_LayerName = "" THEN    //Added 4/15/05 BKW
			is_LayerName = "Positions"
		END IF
		
		if locations() = -1 then
			messagebox("Mapping Equipment", "There is no equipment that can be mapped.")
			close(this)
			return
		else
			this.pcmgsetpinpicking(1)
			this.pcmgsetroadlegend(0)
		end if
	END IF

	string ls_LocString, ls_RouteType, ls_RouteId
	
	IF istr_Mapping.typemap = "R" THEN
		
		this.title = "Route Map"
		
		IF is_LayerName = "" THEN   //Added 4/15/05 BKW
			is_LayerName = "Route"
		END IF
		
		choose case istr_Mapping.typeroute
			case "P"
				ls_RouteType = "PRAC"
			case "S"
				ls_RouteType = "SHORT"
			case "N"
				ls_RouteType = "NATL"
			case "T"
				ls_RouteType = "TOLL"
			case else
				ls_RouteType = "PRAC"
		end choose
		if istr_Mapping.hubs = "H" and not isnull(istr_Mapping.hubs) then 
			ls_RouteType += "|HUB"
		else
			ls_RouteType += "|NOHUB"
		end if
//		if istr_Mapping.borders = "C" and not isnull(istr_Mapping.borders) then 
//			ls_RouteType += "|CLOSED"
//		else
//			ls_RouteType += "|OPEN"
//		end if

		//Changed default to Closed 8/5/05 4.0.41 BKW  to mirror what the directions window was doing.
		if istr_Mapping.borders = "O" then 
			ls_RouteType += "|OPEN"
		else
			ls_RouteType += "|CLOSED"
		end if


		if ids_Source.dataobject = "d_itin" then
//			itin_route(ls_LocString)
//			if len(trim(ls_LocString)) > 0 then &
//				this.PCMGPlotTrip(is_LayerName, is_RouteName, "1", "green|5", ls_LocString, ls_RouteType)
//			routing()

			This.wf_PlotTrip ( ids_Source, is_LayerName, ls_RouteId, "" /*Importance*/, "" /*Style*/, ls_RouteType )
			PCMGFrameTrip ( is_LayerName, ls_RouteId )

			if istr_Mapping.valid_tripid > 0 then
			else
				this.pcmgsetpinpicking(1)
			end if
			this.pcmgsetroadlegend(0)
		else
			//nothing programmed, no other datawindow type allowed
		end if
		
	END IF
	
END IF

end event

event close;choose case is_pcmilerversion
	case "14.0"
		//don't do cleanup -- it causes a crash in this version.
	case else //11.0, 12.0, 2000.0, 15.0, etc., and All Streets Versions
		PCMGcleanupmap()	
end choose			

if isvalid ( ids_Source ) then
	destroy ids_Source
end if


end event

