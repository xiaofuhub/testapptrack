$PBExportHeader$u_tab_documenttransfer.sru
forward
global type u_tab_documenttransfer from u_tab
end type
type tabpage_settings from u_cst_documenttransfersettings within u_tab_documenttransfer
end type
type tabpage_settings from u_cst_documenttransfersettings within u_tab_documenttransfer
end type
type tabpage_mappings from u_cst_documentmapping within u_tab_documenttransfer
end type
type tabpage_mappings from u_cst_documentmapping within u_tab_documenttransfer
end type
end forward

global type u_tab_documenttransfer from u_tab
integer width = 2405
long backcolor = 12632256
tabpage_settings tabpage_settings
tabpage_mappings tabpage_mappings
event ue_itemchanged ( )
end type
global u_tab_documenttransfer u_tab_documenttransfer

forward prototypes
public function integer of_retrieve (long al_company)
public function boolean of_werechangesmadetomapping ()
end prototypes

public function integer of_retrieve (long al_company);Int	li_Return

tabpage_mappings.of_Retrieve( al_company )
Tabpage_settings.of_Retrieve( al_company )
RETURN 1
end function

public function boolean of_werechangesmadetomapping ();RETURN  tabpage_mappings.of_updatespending( ) = 1 
end function

on u_tab_documenttransfer.create
this.tabpage_settings=create tabpage_settings
this.tabpage_mappings=create tabpage_mappings
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_settings
this.Control[iCurrent+2]=this.tabpage_mappings
end on

on u_tab_documenttransfer.destroy
call super::destroy
destroy(this.tabpage_settings)
destroy(this.tabpage_mappings)
end on

type tabpage_settings from u_cst_documenttransfersettings within u_tab_documenttransfer
integer x = 18
integer y = 100
integer width = 2368
integer height = 776
string text = "Settings"
long tabbackcolor = 12632256
end type

event ue_itemchanged;call super::ue_itemchanged;Parent.event ue_itemchanged( )
end event

type tabpage_mappings from u_cst_documentmapping within u_tab_documenttransfer
integer x = 18
integer y = 100
integer width = 2368
integer height = 776
string text = "Mapping"
long tabbackcolor = 12632256
end type

event ue_itemchanged;call super::ue_itemchanged;Parent.event ue_itemchanged( )
end event

