$PBExportHeader$n_cst_mapping.sru
forward
global type n_cst_mapping from nonvisualobject
end type
end forward

global type n_cst_mapping from nonvisualobject
end type
global n_cst_mapping n_cst_mapping

type prototypes
FUNCTION integer PCMSAbout( string which, REF string buffer, integer bufLen ) LIBRARY "pcmsrv32.dll" alias for "PCMSAbout;Ansi"

function long PCMSGetStop( long trip, long which, ref string buffer, long bufSize ) library "pcmsrv32.dll" alias for "PCMSGetStop;Ansi"
function long PCMSNumStops( long trip ) library "pcmsrv32.dll"

FUNCTION boolean PCMGInitMap ( string appNaim, string iniFile ) &
	LIBRARY "pcmgw32.dll" alias for "PCMGInitMap;Ansi"

FUNCTION integer PCMGCreateMapWindow ( integer parentHWnd, &
	string title, integer width, integer height ) LIBRARY "pcmgw32.dll" alias for "PCMGCreateMapWindow;Ansi"

FUNCTION integer PCMGCreateMapChild ( integer parentWin ) &
	LIBRARY "pcmgw32.dll"

FUNCTION integer PCMGGetDisplayModule ( ) LIBRARY "pcmgmp32.dll"

FUNCTION integer PCMGGetDisplayWindow ( ) LIBRARY "pcmgmp32.dll"

SUBROUTINE PCMGSetDisplayModule ( integer module_handle ) &
	LIBRARY "pcmgmp32.dll"

SUBROUTINE PCMGSetDisplayWindow ( integer window_handle ) &
	LIBRARY "pcmgmp32.dll"

FUNCTION boolean PCMGResizeMapChild ( integer redraw ) &
	LIBRARY "pcmgw32.dll"

FUNCTION boolean PCMGCleanupMap ( ) LIBRARY "pcmgw32.dll"

FUNCTION long PCMGPlotTrip ( string layerID, string ID, string importance, &
	string style, string locations, string options ) LIBRARY "pcmgmp32.dll" alias for "PCMGPlotTrip;Ansi"

FUNCTION long PCMGPlotPin ( string layerID, string ID, string importance, &
	string symbol, string location, string labels ) LIBRARY "pcmgmp32.dll" alias for "PCMGPlotPin;Ansi"

FUNCTION long PCMGDeletePin ( string layerID, string ID ) &
	LIBRARY "pcmgmp32.dll" alias for "PCMGDeletePin;Ansi"

FUNCTION long PCMGFramePin ( string layerID, string ID ) &
	LIBRARY "pcmgmp32.dll" alias for "PCMGFramePin;Ansi"

FUNCTION long PCMGSetInfoLabels ( string layerID, string ID, string importance, &
	string symbol, string loc, string labels ) LIBRARY "pcmgmp32.dll" alias for "PCMGSetInfoLabels;Ansi"

FUNCTION long PCMGShowPinmap ( string layerID, integer show ) &
	LIBRARY "pcmgmp32.dll" alias for "PCMGShowPinmap;Ansi"

FUNCTION long PCMGDeletePinmap ( string layerID ) LIBRARY "pcmgmp32.dll" alias for "PCMGDeletePinmap;Ansi"

FUNCTION long PCMGFramePinmap ( string layerID ) LIBRARY "pcmgmp32.dll" alias for "PCMGFramePinmap;Ansi"

FUNCTION long PCMGPrintMap ( integer showDlg, string title) &
	LIBRARY "pcmgw32.dll" alias for "PCMGPrintMap;Ansi"

FUNCTION long PCMGSetPinPicking ( integer onOff ) &
	LIBRARY "pcmgw32.dll"

FUNCTION long PCMGSetRoadLegend ( integer onOff ) &
	LIBRARY "pcmgw32.dll"

end prototypes

forward prototypes
public function boolean of_cleanup ()
end prototypes

public function boolean of_cleanup ();return this.PCMGcleanupmap()
end function

on n_cst_mapping.create
TriggerEvent( this, "constructor" )
end on

on n_cst_mapping.destroy
TriggerEvent( this, "destructor" )
end on

