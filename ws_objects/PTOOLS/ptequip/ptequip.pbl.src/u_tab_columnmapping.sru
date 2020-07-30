$PBExportHeader$u_tab_columnmapping.sru
forward
global type u_tab_columnmapping from u_tab
end type
type tabpage_railtrace from u_cst_columnmapping within u_tab_columnmapping
end type
type tabpage_railtrace from u_cst_columnmapping within u_tab_columnmapping
end type
type tabpage_terminaltrace from u_cst_columnmapping within u_tab_columnmapping
end type
type tabpage_terminaltrace from u_cst_columnmapping within u_tab_columnmapping
end type
end forward

global type u_tab_columnmapping from u_tab
integer width = 1947
integer height = 1056
long backcolor = 12632256
tabpage_railtrace tabpage_railtrace
tabpage_terminaltrace tabpage_terminaltrace
end type
global u_tab_columnmapping u_tab_columnmapping

on u_tab_columnmapping.create
this.tabpage_railtrace=create tabpage_railtrace
this.tabpage_terminaltrace=create tabpage_terminaltrace
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_railtrace
this.Control[iCurrent+2]=this.tabpage_terminaltrace
end on

on u_tab_columnmapping.destroy
call super::destroy
destroy(this.tabpage_railtrace)
destroy(this.tabpage_terminaltrace)
end on

type tabpage_railtrace from u_cst_columnmapping within u_tab_columnmapping
integer x = 18
integer y = 100
integer width = 1911
integer height = 940
string text = "Rail Trace"
long tabbackcolor = 12632256
end type

event constructor;call super::constructor;String 	lsa_Columns[]
String	lsa_DisplayValues[]

n_cst_PtRailTraceManager	lnv_RtManager

lnv_RtManager = Create n_cst_PtRailTraceManager

lnv_RtManager.of_GetRailColumnDisplayValues(lsa_Columns[], lsa_DisplayValues[])

This.of_SetDataObject("d_railtracecolumnmapping")
This.of_SetEqTraceTable("equipmenttrace")
This.of_SetProfitToolsTable("disp_ship")

This.of_Setdisplayvalues( lsa_Columns[], lsa_DisplayValues[])
This.of_Initialize()

Destroy(lnv_RtManager)
end event

type tabpage_terminaltrace from u_cst_columnmapping within u_tab_columnmapping
integer x = 18
integer y = 100
integer width = 1911
integer height = 940
string text = "Terminal Trace"
long tabbackcolor = 12632256
end type

event constructor;call super::constructor;String 	lsa_Columns[]
String	lsa_DisplayValues[]

n_cst_PtRailTraceManager	lnv_RtManager

lnv_RtManager = Create n_cst_PtRailTraceManager

lnv_RtManager.of_GetTerminalColumnDisplayValues(lsa_Columns[], lsa_DisplayValues[])

This.of_SetDataObject("d_terminaltracecolumnmapping")
This.of_SetEqTraceTable("terminaltrace")
This.of_SetProfitToolsTable("disp_ship")
This.of_SetDisplayValues(lsa_Columns, lsa_DisplayValues)
This.of_Initialize()

end event

