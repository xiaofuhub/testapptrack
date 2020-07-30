$PBExportHeader$u_tab_invoicetransfer.sru
forward
global type u_tab_invoicetransfer from u_tab
end type
type tabpage_settings from u_cst_invoicetransfersettings within u_tab_invoicetransfer
end type
type tabpage_settings from u_cst_invoicetransfersettings within u_tab_invoicetransfer
end type
type tabpage_mapping from u_cst_invoicemapping within u_tab_invoicetransfer
end type
type tabpage_mapping from u_cst_invoicemapping within u_tab_invoicetransfer
end type
end forward

global type u_tab_invoicetransfer from u_tab
integer width = 2025
integer height = 1096
long backcolor = 12632256
tabpage_settings tabpage_settings
tabpage_mapping tabpage_mapping
event ue_itemchanged ( )
event ue_preupdate ( )
event ue_toggleemailinvoice ( boolean ab_switch )
event ue_postsave ( )
event ue_toggleoff ( )
end type
global u_tab_invoicetransfer u_tab_invoicetransfer

forward prototypes
public function integer of_retrieve (long al_coid)
public function boolean of_werechangesmadetomapping ()
public function integer of_validate ()
end prototypes

event ue_preupdate();tabpage_mapping.Event ue_preUpdate()
end event

event ue_toggleemailinvoice(boolean ab_switch);tabpage_settings.Event ue_toggleemailinvoice(ab_Switch)
tabpage_mapping.Event ue_toggleemailinvoice(ab_Switch)
end event

event ue_postsave();tabpage_mapping.Event ue_Postsave()
end event

public function integer of_retrieve (long al_coid);Int	li_Return
n_cst_LicenseManager	lnv_LicenseMan

Tabpage_settings.of_Retrieve( al_coid )

IF lnv_LicenseMan.of_GetLicensed(n_cst_constants.cs_Module_Imaging ) THEN
	tabpage_mapping.of_Retrieve( al_coid )
END IF

RETURN 1
end function

public function boolean of_werechangesmadetomapping ();RETURN  tabpage_mapping.of_updatespending( ) = 1 
end function

public function integer of_validate ();Return tabpage_settings.of_Validate()
end function

on u_tab_invoicetransfer.create
this.tabpage_settings=create tabpage_settings
this.tabpage_mapping=create tabpage_mapping
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_settings
this.Control[iCurrent+2]=this.tabpage_mapping
end on

on u_tab_invoicetransfer.destroy
call super::destroy
destroy(this.tabpage_settings)
destroy(this.tabpage_mapping)
end on

event constructor;call super::constructor;n_cst_LicenseManager	lnv_LicenseMan


IF NOT lnv_LicenseMan.of_GetLicensed(n_cst_constants.cs_Module_Imaging ) THEN
	tabpage_mapping.Enabled = FALSE
END IF
end event

type tabpage_settings from u_cst_invoicetransfersettings within u_tab_invoicetransfer
integer x = 18
integer y = 100
integer width = 1989
string text = "Settings"
long tabbackcolor = 12632256
end type

event ue_itemchanged;call super::ue_itemchanged;Parent.event ue_itemchanged( )
end event

type tabpage_mapping from u_cst_invoicemapping within u_tab_invoicetransfer
integer x = 18
integer y = 100
integer width = 1989
integer height = 980
string text = "Image Mapping"
long tabbackcolor = 12632256
end type

event ue_itemchanged;call super::ue_itemchanged;Parent.event ue_itemchanged( )
end event

