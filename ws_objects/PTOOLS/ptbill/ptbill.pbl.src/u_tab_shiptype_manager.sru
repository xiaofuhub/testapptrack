$PBExportHeader$u_tab_shiptype_manager.sru
forward
global type u_tab_shiptype_manager from u_tab
end type
type tabpage_shiptype_details from u_tabpg_shiptype_edit within u_tab_shiptype_manager
end type
type tabpage_armap from u_tabpg_armap within u_tab_shiptype_manager
end type
type tabpage_acctmap from u_tabpg_acctmap within u_tab_shiptype_manager
end type
end forward

global type u_tab_shiptype_manager from u_tab
int Width=2889
int Height=1368
boolean BoldSelectedText=true
int TextSize=-10
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
tabpage_shiptype_details tabpage_shiptype_details
tabpage_armap tabpage_armap
tabpage_acctmap tabpage_acctmap
event type integer ue_rowadded ( long al_row )
event ue_setredraw ( boolean ab_value )
event type long ue_getfirstrowonlistpage ( )
event ue_scrolllisttorow ( long al_row )
event type integer ue_deleterow ( long al_row )
end type
global u_tab_shiptype_manager u_tab_shiptype_manager

on u_tab_shiptype_manager.create
this.tabpage_shiptype_details=create tabpage_shiptype_details
this.tabpage_armap=create tabpage_armap
this.tabpage_acctmap=create tabpage_acctmap
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_shiptype_details
this.Control[iCurrent+2]=this.tabpage_armap
this.Control[iCurrent+3]=this.tabpage_acctmap
end on

on u_tab_shiptype_manager.destroy
call super::destroy
destroy(this.tabpage_shiptype_details)
destroy(this.tabpage_armap)
destroy(this.tabpage_acctmap)
end on

event selectionchanged;
choose case newindex
	case 1 //general settings
		
	case 2 //ar
		this.tabpage_armap.dw_1.post event ue_filter()
		
	case 3 //ap
		this.tabpage_acctmap.dw_acctmap.post event ue_filter()
		
		
end choose

end event

type tabpage_shiptype_details from u_tabpg_shiptype_edit within u_tab_shiptype_manager
int X=18
int Y=112
int Width=2853
int Height=1240
string Text="General Settings"
end type

event constructor;call super::constructor;ib_isupdateable = true

end event

event ue_rowadded;Parent.Event ue_RowAdded ( al_row ) 
Return 1
end event

event ue_setredraw;PARENT.Event ue_SetRedraw  ( ab_Value ) 
end event

event ue_getfirstrowonlistpage;RETURN Parent.Event ue_getfirstrowonlistpage ( )
end event

event ue_scrolllisttorow;Parent.Event ue_ScrollListToRow ( al_Row ) 
end event

type tabpage_armap from u_tabpg_armap within u_tab_shiptype_manager
int X=18
int Y=112
int Width=2853
int Height=1240
string Text="AR Accounts"
end type

type tabpage_acctmap from u_tabpg_acctmap within u_tab_shiptype_manager
int X=18
int Y=112
int Width=2853
int Height=1240
string Text="AP Accounts"
end type

event ue_deleterow;return parent.event ue_deleterow(al_row)
end event

