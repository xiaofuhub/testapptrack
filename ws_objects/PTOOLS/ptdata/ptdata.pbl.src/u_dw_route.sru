$PBExportHeader$u_dw_route.sru
forward
global type u_dw_route from u_dw
end type
end forward

global type u_dw_route from u_dw
int Width=2322
int Height=480
string DataObject="d_route"
boolean HScrollBar=true
boolean HSplitScroll=true
end type
global u_dw_route u_dw_route

event constructor;//Instantiate the default row focus indicator
This.Event ue_SetFocusIndicator ( TRUE )
this.of_SetRowManager ( TRUE )
end event

