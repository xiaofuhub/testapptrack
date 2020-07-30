$PBExportHeader$u_cst_tabpg_company_notification.sru
forward
global type u_cst_tabpg_company_notification from u_tabpg
end type
type uo_settings from u_cst_notification_company_settings within u_cst_tabpg_company_notification
end type
end forward

global type u_cst_tabpg_company_notification from u_tabpg
int Width=2715
int Height=1252
event ue_populate ( )
event type integer ue_rolechanged ( string as_role )
event type integer ue_templatechanged ( string as_template )
event ue_attachmentchanged ( )
event type n_cst_beo_company ue_getcompany ( )
event type integer ue_eventorigchanged ( string as_value )
event type integer ue_eventdestchanged ( string as_value )
uo_settings uo_settings
end type
global u_cst_tabpg_company_notification u_cst_tabpg_company_notification

type variables
n_cst_beo_Company	inv_Company
dataStore			ids_Contacts
end variables

forward prototypes
public function integer of_populate (long al_companyid)
public function integer of_setcompany (ref n_cst_beo_company anv_company)
public function integer of_setrole (string as_role)
public function integer of_settemplate (string as_template)
public function string of_getattachmenttypes ()
public function integer of_setattachimagetypes (string asa_types[])
public function integer of_filterlist (long al_companyid)
public function integer of_setcontactsource (ref datastore ads_source)
public function integer of_setcompanyid (long al_ID)
public function integer of_seteventorig (string as_event)
public function integer of_seteventdest (string as_event)
end prototypes

public function integer of_populate (long al_companyid);uo_settings.of_Populate ( al_companyid )
RETURN 1
end function

public function integer of_setcompany (ref n_cst_beo_company anv_company);uo_settings.of_setCompany ( anv_Company )

RETURN 1
end function

public function integer of_setrole (string as_role);RETURN uo_settings.of_setRole ( as_Role ) 
end function

public function integer of_settemplate (string as_template);uo_settings.of_SetTemplate ( as_Template )
RETURN 1


end function

public function string of_getattachmenttypes ();RETURN uo_settings.of_GetAttachmentTypes( )
end function

public function integer of_setattachimagetypes (string asa_types[]);uo_settings.of_SetAttachmentTypes( asa_Types[] )
RETURN 1
end function

public function integer of_filterlist (long al_companyid);RETURN uo_Settings.of_FilterList ( al_companyid )
end function

public function integer of_setcontactsource (ref datastore ads_source);Return uo_settings.of_SetContactSource ( ads_source )
end function

public function integer of_setcompanyid (long al_ID);uo_settings.of_SetCompanyID ( al_ID )
RETURN 1
end function

public function integer of_seteventorig (string as_event);RETURN uo_settings.of_setEventOrig ( as_event ) 
end function

public function integer of_seteventdest (string as_event);RETURN uo_settings.of_setEventDest ( as_event ) 
end function

on u_cst_tabpg_company_notification.create
int iCurrent
call super::create
this.uo_settings=create uo_settings
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_settings
end on

on u_cst_tabpg_company_notification.destroy
call super::destroy
destroy(this.uo_settings)
end on

type uo_settings from u_cst_notification_company_settings within u_cst_tabpg_company_notification
int X=18
int Y=0
int TabOrder=10
boolean BringToTop=true
end type

event ue_attachmentchanged;Parent.Event ue_AttachmentChanged ( ) 
end event

event ue_populate;Parent.Event ue_Populate ( ) 
end event

event ue_rolechanged;Parent.Event ue_RoleChanged ( as_Role )
end event

event ue_templatechanged;Parent.Event ue_templateChanged ( as_template )
end event

on uo_settings.destroy
call u_cst_notification_company_settings::destroy
end on

event ue_getcompany;Return Parent.Event ue_GetCompany ( )
end event

event ue_eventdestchanged;Parent.Event ue_EventDestChanged ( as_event )
end event

event ue_eventorigchanged;Parent.Event ue_EventOrigChanged ( as_event )

end event

