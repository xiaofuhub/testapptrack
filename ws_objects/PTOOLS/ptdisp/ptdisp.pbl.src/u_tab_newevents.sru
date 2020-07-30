$PBExportHeader$u_tab_newevents.sru
forward
global type u_tab_newevents from u_tab
end type
type tabpage_newevent from u_cst_newevent within u_tab_newevents
end type
type tabpage_newevent from u_cst_newevent within u_tab_newevents
end type
type tabpage_neweventtemplate from u_cst_neweventtemplate within u_tab_newevents
end type
type tabpage_neweventtemplate from u_cst_neweventtemplate within u_tab_newevents
end type
end forward

global type u_tab_newevents from u_tab
integer width = 2395
integer height = 604
long backcolor = 12632256
boolean boldselectedtext = true
boolean perpendiculartext = true
tabposition tabposition = tabsonright!
tabpage_newevent tabpage_newevent
tabpage_neweventtemplate tabpage_neweventtemplate
event type n_cst_bso_dispatch ue_getdispatchmanager ( )
event type long ue_getroutingids ( ref long ala_ids[] )
event ue_setroutemodeindicator ( boolean ab_switch )
event type integer ue_autoroute ( )
event ue_routemode ( )
end type
global u_tab_newevents u_tab_newevents

event type long ue_getroutingids(ref long ala_ids[]);Long		ll_Return

CHOOSE CASE This.Control[This.SelectedTab] 
	CASE  tabpage_newevent
		ll_Return = tabpage_newevent.Event ue_GetRoutingIds(ala_ids)
	CASE tabpage_neweventtemplate
		ll_Return = tabpage_neweventtemplate.Event ue_GetRoutingIds(ala_ids)
END CHOOSE


Return ll_Return
end event

event ue_setroutemodeindicator(boolean ab_switch);CHOOSE CASE This.Control[This.SelectedTab]
	CASE tabpage_newevent
		tabpage_newevent.Event ue_SetRouteModeIndicator(ab_switch)
		tabpage_neweventtemplate.Enabled = NOT ab_Switch
	CASE tabpage_neweventtemplate
		tabpage_neweventtemplate.Event ue_SetRouteModeIndicator(ab_switch)
		tabpage_newevent.Enabled = NOT ab_Switch
END CHOOSE
end event

on u_tab_newevents.create
this.tabpage_newevent=create tabpage_newevent
this.tabpage_neweventtemplate=create tabpage_neweventtemplate
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_newevent
this.Control[iCurrent+2]=this.tabpage_neweventtemplate
end on

on u_tab_newevents.destroy
call super::destroy
destroy(this.tabpage_newevent)
destroy(this.tabpage_neweventtemplate)
end on

type tabpage_newevent from u_cst_newevent within u_tab_newevents
integer x = 18
integer y = 16
integer width = 2034
integer height = 572
string text = "Events"
long tabbackcolor = 12632256
boolean ib_isupdateable = false
end type

event ue_getdispatchmanager;call super::ue_getdispatchmanager;Return Parent.Event ue_GetDispatchManager()
end event

event ue_autoroute;call super::ue_autoroute;Return Parent.Event ue_AutoRoute()
end event

event ue_routemode;call super::ue_routemode;Parent.Event ue_RouteMode()
end event

type tabpage_neweventtemplate from u_cst_neweventtemplate within u_tab_newevents
integer x = 18
integer y = 16
integer width = 2034
integer height = 572
string text = "Templates"
long tabbackcolor = 12632256
end type

event ue_routemode;call super::ue_routemode;Parent.Event ue_RouteMode()
end event

event ue_getdispatchmanager;call super::ue_getdispatchmanager;Return Parent.Event ue_GetDispatchManager()
end event

event ue_autoroute;call super::ue_autoroute;Return Parent.Event ue_AutoRoute()
end event

