$PBExportHeader$w_map_streets.srw
forward
global type w_map_streets from w_map
end type
end forward

global type w_map_streets from w_map
end type
global w_map_streets w_map_streets

type prototypes
Function Long PCMSAbout (String topic, REF String buffer, Long bufLen) LIBRARY "PMWSSRV.DLL" alias for "PCMSAbout;Ansi"
Function Long PCMSGetStop (Long tripID, Long which, REF String buffer, Long bufLen) LIBRARY "PMWSSRV.DLL" alias for "PCMSGetStop;Ansi"
Function Long PCMSNumStops (Long tripID) LIBRARY "PMWSSRV.DLL"
//********************************************************
// PC*MILER/STREETS-Mapping DLL Interface:
//********************************************************
// Set the labels that appear in a pin's info dialog.
Function Long PCMGSetInfoLabels (String layer,  String ID,	String importance, &
		String symbol, String location, String labels) LIBRARY "pmwscomm.dll" alias for "PCMGSetInfoLabels;Ansi"

// Add graphical elements (pins, trips, and lines) to map.
Function Long PCMGPlotPin (String layer, String ID, String importance, &
	String symbol, String location, String dataValues) LIBRARY "pmwscomm.dll" alias for "PCMGPlotPin;Ansi"
Function Long PCMGPlotTrip (String layer, String ID, String importance, &
	String style, String locations, String options) LIBRARY "pmwscomm.dll" alias for "PCMGPlotTrip;Ansi"
Function Long PCMGPlotLine (String layer, String ID, String importance, &
	String style, String locations) LIBRARY "pmwscomm.dll" alias for "PCMGPlotLine;Ansi"

// Deleting graphical elements
Function Long PCMGDeletePin (String layer, String ID) LIBRARY "pmwscomm.dll" alias for "PCMGDeletePin;Ansi"
Function Long PCMGDeleteTrip (String layer, String ID) LIBRARY "pmwscomm.dll" alias for "PCMGDeleteTrip;Ansi"
Function Long PCMGDeleteLine (String layer, String ID) LIBRARY "pmwscomm.dll" alias for "PCMGDeleteLine;Ansi"

// Deleting an entire pinmaps at once
Function Long PCMGDeletePinmap (String layer) LIBRARY "pmwscomm.dll" alias for "PCMGDeletePinmap;Ansi"

// Show, hide, and zoom to pinmaps or individual pins.
Function Long PCMGShowPinmap (String layer, Long showHide) LIBRARY "pmwscomm.dll" alias for "PCMGShowPinmap;Ansi"
Function Long PCMGFramePinmap (String layer) LIBRARY "pmwscomm.dll" alias for "PCMGFramePinmap;Ansi"
Function Long PCMGFramePin (String layer, String ID) LIBRARY "pmwscomm.dll" alias for "PCMGFramePin;Ansi"
Function Long PCMGFrameTrip(String layer, String ID) LIBRARY "pmwscomm.dll" alias for "PCMGFrameTrip;Ansi"

// Toggle redraw on and off.
Function Long PCMGSetRedraw (Long onOff) LIBRARY "pmwscomm.dll"

// Info/Debugging
SUBROUTINE PCMGSetDebug (Long level) LIBRARY "pmwscomm.dll"
Function Long PCMGGetDebug () LIBRARY "pmwscomm.dll"

// Manage Windows, etc.
Function Long PCMGGetDisplayModule () LIBRARY "pmwscomm.dll"
Function Long PCMGGetDisplayWindow () LIBRARY "pmwscomm.dll"
SUBROUTINE PCMGSetDisplayModule (Long module) LIBRARY "pmwscomm.dll"
SUBROUTINE PCMGSetDisplayWindow (Long window) LIBRARY "pmwscomm.dll"


//********************************************************
// pmwsmap DLL Interface:
//********************************************************
// Windows function
Function Long GetModuleHandleA (String moduleName) LIBRARY "Kernel32.DLL" alias for "GetModuleHandleA;Ansi"

// Load the map database. Declare the application's name and point to the PC*MILER INI file.
// Returns 1 on success, 0 on failure.
Function Integer PCMGInitMap (String appName, String iniFile) LIBRARY "pmwsmap.DLL" alias for "PCMGInitMap;Ansi"

// Cleanup all the pmwsmap map stuff. Only call after map window is closed by user.
// Returns 1 on success, 0 on failure.
Function Integer PCMGCleanupMap () LIBRARY "pmwsmap.DLL"

// Creating a new resizable map window with a caption and a frame.
// Pass in the parent's HWND. Returns the map window's HWND.
Function Long PCMGCreateMapWindow (Long parentHWND, String title, Long wid, &
		Long height) LIBRARY "pmwsmap.DLL" alias for "PCMGCreateMapWindow;Ansi"

// Create a new map window as a child within the parent window.
// Pass in the parent's HWND. Returns the child map window's HWND.
Function Long PCMGCreateMapChild (Long parentHWND) LIBRARY "pmwsmap.DLL"

// Resize the child map window if parent is resized.
// Returns 1 on success, 0 on failure.
Function Integer PCMGResizeMapChild (Integer redraw) LIBRARY "pmwsmap.DLL"

// Print the map. Pass 0 for 'showPrintDlg' to bypass Print dialog
Function Long PCMGPrintMap (Integer showPrintDlg, String title) LIBRARY "pmwsmap.DLL" alias for "PCMGPrintMap;Ansi"

// Print the map. Pass a printing HDC canvas and a title string for the map.
Function Long PCMGPrintMapOnDC (Long hDC, String title) LIBRARY "pmwsmap.DLL" alias for "PCMGPrintMapOnDC;Ansi"

// Copy the map window to the clipboard
Function Long PCMGCopyMap () LIBRARY "pmwsmap.DLL"

// Force a redraw
Function Long PCMGRedraw () LIBRARY "pmwsmap.DLL"

// Toggle the road legend on/off.
Function Long PCMGToggleRoadLegend () LIBRARY "pmwsmap.DLL"

// Toggle scale of miles legend on/off.
Function Long PCMGToggleScale () LIBRARY "pmwsmap.DLL"

// Toggle shape points.
Function Long PCMGToggleShapePts () LIBRARY "pmwsmap.DLL"

// Toggle user labeling of cities with the mouse.
Function Long PCMGToggleCityPicking () LIBRARY "pmwsmap.DLL"

// Toggle user labeling of roads with the mouse.
Function Long PCMGToggleRoadPicking () LIBRARY "pmwsmap.DLL"

// Clear all road and city labels.
Function Long PCMGClearLabels () LIBRARY "pmwsmap.DLL"

// Add/Remove detail
Function Long PCMGAddDetail () LIBRARY "pmwsmap.DLL"
Function Long PCMGRemoveDetail () LIBRARY "pmwsmap.DLL"
Function Long PCMGDefaultDetail () LIBRARY "pmwsmap.DLL"

// Setting the viewport (zooming in and out)
Function Long PCMGZoomIn () LIBRARY "pmwsmap.DLL"
Function Long PCMGZoomOut () LIBRARY "pmwsmap.DLL"
Function Long PCMGSetUSWindow () LIBRARY "pmwsmap.DLL"
Function Long PCMGSetNAWindow () LIBRARY "pmwsmap.DLL"
Function Long PCMGSetCanWindow () LIBRARY "pmwsmap.DLL"
//Function PCMGSetMexWindow () LIBRARY "pmwsmap.DLL"


// Show and hide layers
Function Long PCMGShowLayer (String layerName) LIBRARY "pmwsmap.DLL" alias for "PCMGShowLayer;Ansi"
Function Long PCMGHideLayer (String layerName) LIBRARY "pmwsmap.DLL" alias for "PCMGHideLayer;Ansi"

// Plotting text labels
Function Long PCMGPlotLabel (String layer, String ID, String importance, &
	String style, String locations, String options) LIBRARY "pmwsmap.DLL" alias for "PCMGPlotLabel;Ansi"
Function Long PCMGDeleteLabel (String layer, String ID) LIBRARY "pmwsmap.DLL" alias for "PCMGDeleteLabel;Ansi"

FUNCTION long PCMGSetPinPicking ( integer onOff ) &
	 LIBRARY "pmwsmap.DLL"

FUNCTION long PCMGSetRoadLegend ( integer onOff ) &
	 LIBRARY "pmwsmap.DLL"


end prototypes

forward prototypes
public function boolean wf_isstreets ()
end prototypes

public function boolean wf_isstreets ();//Indicate whether the Standard (ancestor) or Streets (descendant) version of the window has been opened.
//This function returns FALSE on the ancestor and is overridden to return TRUE here on the Streets descendant in order to implement this distinction.

RETURN TRUE
end function

on w_map_streets.create
call super::create
end on

on w_map_streets.destroy
call super::destroy
end on

