$PBExportHeader$u_tab_routemanager.sru
forward
global type u_tab_routemanager from u_tab
end type
type tabpage_route from u_tabpage_route within u_tab_routemanager
end type
type tabpage_company from u_tabpage_company within u_tab_routemanager
end type
type tabpage_equipment from u_tabpage_equipment within u_tab_routemanager
end type
type tabpage_zones from u_tabpage_zones within u_tab_routemanager
end type
end forward

global type u_tab_routemanager from u_tab
int Width=2176
int Height=1076
boolean BoldSelectedText=true
int TextSize=-10
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
tabpage_route tabpage_route
tabpage_company tabpage_company
tabpage_equipment tabpage_equipment
tabpage_zones tabpage_zones
event type integer ue_routechanged ( long al_newrouteid )
event ue_companyadded ( long al_companyid )
event ue_companyremoved ( long al_coid )
event ue_equipmentadded ( long al_equipmentid )
event ue_equipmentremoved ( long ad_equipmentid )
event type integer ue_zoneadded ( string as_name )
event type integer ue_zoneremoved ( string as_name )
end type
global u_tab_routemanager u_tab_routemanager

on u_tab_routemanager.create
this.tabpage_route=create tabpage_route
this.tabpage_company=create tabpage_company
this.tabpage_equipment=create tabpage_equipment
this.tabpage_zones=create tabpage_zones
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_route
this.Control[iCurrent+2]=this.tabpage_company
this.Control[iCurrent+3]=this.tabpage_equipment
this.Control[iCurrent+4]=this.tabpage_zones
end on

on u_tab_routemanager.destroy
call super::destroy
destroy(this.tabpage_route)
destroy(this.tabpage_company)
destroy(this.tabpage_equipment)
destroy(this.tabpage_zones)
end on

type tabpage_route from u_tabpage_route within u_tab_routemanager
int X=18
int Y=112
int Width=2139
int Height=948
string Text="Route"
end type

event ue_routechanged;
Parent.Event ue_RouteChanged ( al_newrouteid )
RETURN 1
end event

type tabpage_company from u_tabpage_company within u_tab_routemanager
int X=18
int Y=112
int Width=2139
int Height=948
string Text="Company"
end type

event ue_companyadded;Parent.Event ue_CompanyAdded ( al_coid ) 

end event

event ue_companyremoved;Parent.Event ue_CompanyRemoved ( al_companyid ) 

end event

type tabpage_equipment from u_tabpage_equipment within u_tab_routemanager
int X=18
int Y=112
int Width=2139
int Height=948
string Text="Equipment"
end type

event ue_equipmentadded;Parent.Event ue_EquipmentAdded ( al_equipid ) 
end event

event ue_equipmentremoved;Parent.Event ue_EquipmentRemoved ( al_equipmentid ) 
end event

type tabpage_zones from u_tabpage_zones within u_tab_routemanager
int X=18
int Y=112
int Width=2139
int Height=948
string Text="Zones"
end type

event ue_zoneadded;Parent.Event ue_ZoneAdded ( as_name ) 
end event

event ue_zoneremoved;Parent.Event ue_ZoneRemoved ( as_name ) 
end event

