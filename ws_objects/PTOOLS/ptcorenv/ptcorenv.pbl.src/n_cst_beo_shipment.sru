$PBExportHeader$n_cst_beo_shipment.sru
$PBExportComments$added set equipment release date / time
forward
global type n_cst_beo_shipment from pt_n_cst_beo
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070731
//Char	sch_AllowRestrictActive
////end modification Shared Variables by appeon  20070731
//
//
end variables

global type n_cst_beo_shipment from pt_n_cst_beo
end type
global n_cst_beo_shipment n_cst_beo_shipment

type variables
Private:
DataWindow	idw_EventSource
DataStore	ids_EventSource

DataWindow	idw_ItemSource
DataStore	ids_ItemSource

//n_cst_beo_Event	inva_EventList[]
//String		is_EventListLock
//Boolean		ib_EventListReady

//n_cst_beo_Item	inva_ItemList[]
String		is_ItemListLock
Boolean		ib_ItemListReady

Boolean		ib_AskRecalculate
Boolean		ib_Recalculate

Boolean		ib_ExcludeCrossDock
Boolean		ib_DeliveryMode
Boolean		ib_autoRateForEdiCompany		//this should only be true when an EDI imported shipment has its 
														//senders company setting to autorate edi set to true.

Integer		ii_DeliveryModeStopIndex
Integer		ii_DeliveryModePickupIndex

DataStore	ids_Equipment
string		is_RatingAction

//Note -- The value for il_DeliveryModeStopIndex is  
//only applicable if ib_DeliveryMode = TRUE.  As such, 
//the value is not initialized to Null.  I handled it this
//way because I was afraid setting it to Null in the
//constructor might clear a legitimate value when
//objects were passed and re-auto-instantiated.


Long	ila_DelRecitems[]

Boolean		ib_AutoGenAccessorialItem
PUBLIC:
CONSTANT String	cs_BillingFormat_Item = "I"
CONSTANT String	cs_BillingFormat_Category = "L"
CONSTANT String	cs_BillingFormat_Total = "G"

CONSTANT String	cs_PayableFormat_Item = "I"
CONSTANT String	cs_PayableFormat_Category = "L"
CONSTANT String	cs_PayableFormat_Total = "G"

CONSTANT String	cs_Category_Dispatch = "T"
CONSTANT String	cs_Category_Brokerage = "B"
CONSTANT String	cs_Category_NonRouted = "D"

CONSTANT String	cs_Action_ChangedBillto = "ChangedBillto"
CONSTANT String	cs_Action_ChangedOrigin = "ChangedOrigin"
CONSTANT String	cs_Action_ChangedDestination = "ChangedDestination"
CONSTANT String	cs_Action_ChangedCodename = "ChangedCodename"
CONSTANT String	cs_Action_ChangedShiptype = "ChangedShipType"

//begin modification Shared Variables by appeon  20070731
Char	sch_AllowRestrictActive
//end modification Shared Variables by appeon  20070731

end variables

forward prototypes
public function long of_getid ()
public function integer of_delete ()
public function integer of_deleteitem (long al_id)
public function integer of_additem ()
public function integer of_addevent ()
public function integer of_moveevent ()
public function integer of_deleteevent (long al_id)
public function integer of_seteventsource (powerobject apo_source)
public function integer of_setitemsource (powerobject apo_source)
public function powerobject of_geteventsource ()
public function powerobject of_getitemsource ()
public function boolean of_hasconfirmedevents ()
public function long of_geteventcount ()
public function long of_getitemcount ()
public function integer of_changeformat ()
public function boolean of_isbilled ()
public function string of_getstatus ()
public function boolean of_isrestricted ()
private subroutine of_displayrestrictmessage (string as_messageheader)
public function integer of_validatestatus (string as_status, ref string as_message)
public function long of_gettype ()
public function long of_getitemlist (ref n_cst_beo_item anva_items[])
public function boolean of_hasalleventsconfirmed ()
public function long of_getconfirmedeventcount ()
public function long of_getunconfirmedeventcount ()
public function string of_getbillingformat ()
public function long of_getbillto ()
public function boolean of_hasbillto ()
public function date of_getshipdate ()
public function integer of_validatestatus (ref string as_message)
public function integer of_setstatus (string as_value)
public function string of_getcategory ()
public function boolean of_isbrokerage ()
public function long of_gettrip ()
public function long of_getcarrier ()
public function boolean of_hastrip ()
public function boolean of_hascarrier ()
public function integer of_unconfirmevent ()
public function boolean of_alloweditbill ()
public function boolean of_allowedit ()
public function boolean of_allowrestrictactive ()
public function integer of_getevent (integer ai_index, ref n_cst_beo_event anv_event)
public function boolean of_isnonrouted ()
public function integer of_confirmallevents ()
public function decimal of_getfreightcharges ()
public function decimal of_getaccessorialcharges ()
public function decimal of_getdiscountamount ()
public function decimal of_getnetfreightcharges ()
public function integer of_calculate ()
public function decimal of_getdiscountpercent ()
public function boolean of_allowitemcharges ()
public function string of_getref1text ()
public function string of_getref2text ()
public function string of_getref3text ()
public function integer of_getref1type ()
public function integer of_getref2type ()
public function integer of_getref3type ()
public function string of_getref1label ()
public function string of_getref2label ()
public function string of_getref3label ()
public function date of_getinvoicedate ()
public function string of_getinvoicenumber ()
public function decimal of_getnetcharges ()
public function decimal of_getgrosscharges ()
public function decimal of_gettotalpieces ()
public function decimal of_gettotalweight ()
public function string of_getdispatchstatus ()
public function date of_getscheduleddeliverydate ()
public function time of_getscheduleddeliverytime ()
public function string of_getoriginlocation ()
public function string of_getdestinationlocation ()
public function long of_getorigin ()
public function long of_getdestination ()
public subroutine of_lockeventlist (readonly string as_lockid)
public subroutine of_releaseeventlist (readonly string as_lockid)
public subroutine of_lockitemlist (readonly string as_lockid)
public subroutine of_releaseitemlist (readonly string as_lockid)
public function decimal of_getadjustednetcharges ()
public function date of_getdatedelivered ()
public function date of_getdatepickedup ()
public function time of_gettimepickedup ()
public function time of_gettimedelivered ()
public function string of_getpod ()
public function date of_getscheduledpickupdate ()
public function time of_getscheduledpickuptime ()
public function string of_getblnumbers ()
public function integer of_calculatehazmat ()
public function integer of_setdiscountpercent (decimal ac_discountpercent)
public function string of_getrequiredequipment ()
public function string of_getprepaidcollect ()
public function int of_gettotalmiles ()
public function string of_gethazmat ()
public function string of_getexpedite ()
public function string of_getbillingcomments ()
public function string of_getshipmentcomments ()
public function string of_getmodlog ()
public function integer of_getorigin (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache)
public function integer of_getdestination (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache)
public function integer of_getbilltocompany (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache)
public function string of_getshipmenttype ()
public function long of_getparentid ()
public function boolean of_isroutable ()
public function long of_getlegeventlist (integer ai_leg, ref n_cst_beo_event anva_legeventlist[])
public function integer of_setexcludecrossdock (boolean ab_switch)
public function boolean of_getexcludecrossdock ()
public function string of_getstatusdisplayvalue (string as_datavalue)
public function decimal of_getaccessorialchargesbydescription (string as_description)
public function integer of_setcategory (string as_category)
public function decimal of_getsettlementpay ()
public function boolean of_hasequipmentreferenced ()
public function integer of_getreferencedequipment (ref datastore ads_equiplist)
public function string of_getmovetype ()
public function string of_getoriginport ()
public function string of_getdestinationport ()
public function string of_getline ()
public function string of_getvessel ()
public function string of_getvoyage ()
public function string of_getbooking ()
public function string of_getseal ()
public function string of_getmasterbl ()
public function string of_gethousebl ()
public function string of_getforwarderref ()
public function string of_getagentref ()
public function date of_getcutoffdate ()
public function date of_getarrivaldate ()
public function date of_getlastfreedate ()
public function time of_getcutofftime ()
public function time of_getarrivaltime ()
public function time of_getlastfreetime ()
public function long of_geteventids (ref long ala_ids[])
public function integer of_changestatus (string as_status, n_cst_bso_dispatch anv_dispatch)
public function integer of_changestatus (n_cst_bso_dispatch anv_dispatch)
public function integer of_updateitemindicators ()
public function long of_getfirstpuid ()
public function long of_getfirstdelid ()
public function integer of_getnextdeliverevent (integer ai_startindex)
public function integer of_addevent (string as_type, integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatchmanager, ref long al_id)
public function integer of_addevents (string asa_types[], integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatchmanager, ref long ala_newids[])
private function integer of_resequenceevents (n_cst_beo_event anv_newevent, ref n_cst_beo_event anva_previouseventlist[])
public function integer of_setref1text (string as_value)
private function boolean of_doeventshaveitems (n_cst_beo_event anva_events[], n_cst_beo_item anva_items[])
private function integer of_getevents (long ala_EventIDs[], ref n_cst_beo_event anva_Events[])
private function integer of_removeevent (long al_eventid, boolean ab_deleteitems, n_cst_bso_dispatch anv_dispatch)
public function integer of_preparesingleeventfordeletion (long al_id, n_cst_bso_dispatch anv_dispatch)
public function integer of_addsitemove (long al_siteid, integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatch, ref long ala_newids[], ref n_cst_msg anv_msg)
public function integer of_getforwardercompany (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache)
public function integer of_getagentcompany (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache)
public function long of_getagent ()
public function long of_getforwarder ()
private function boolean of_convertfirsthook ()
private function boolean of_convertlastdrop ()
private function integer of_addchassismove (Long al_SiteID, n_cst_Bso_Dispatch anv_Dispatch, ref long ala_NewIds[])
public function integer of_setref2text (string as_value)
public function integer of_setref3text (string as_value)
public function integer of_setshipmentcomments (string as_value)
public function integer of_setref1type (integer ai_value)
public function integer of_setref2type (integer ai_value)
public function integer of_setref3type (integer ai_value)
public function long of_setbilltoid (long al_value)
public function int of_setshipdate (date ad_Value)
public function integer of_removefreightitems (ref n_cst_bso_dispatch anv_dispatch)
public function integer of_setdefaultdestination ()
public function integer of_setfinaldestination (long al_value)
public function integer of_setdefaultorigin ()
public function integer of_setorigin (long al_value)
public function integer of_setbillingcomments (string as_Value)
public function date of_getavailableon ()
public function date of_getavailableuntil ()
public function string of_getdispatchedby ()
public function string of_getpayableformat ()
public function decimal of_getfreightpayable ()
public function decimal of_getaccessorialpayable ()
public function integer of_calculatepayable ()
public function decimal of_getpayabletotal ()
public function integer of_getcarriercompany (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache)
public function integer of_addevent (string as_type, integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatchmanager, ref long al_id, long al_siteid)
public function decimal of_getsalescommission ()
public function integer of_getnexteventlist (ref n_cst_beo_event anva_events[])
public function integer of_getequipmentlist (ref n_cst_beo_equipment2 anva_equipment[])
public function integer of_removeevents (long ala_eventids[], n_cst_bso_dispatch anv_dispatch, boolean ab_notify)
public function integer of_removeevents (long ala_EventIds[], n_cst_bso_Dispatch anv_Dispatch)
public function integer of_getchassislist (ref n_cst_beo_equipment2 anva_equipment[])
public function integer of_getcontainerlist (ref n_cst_beo_equipment2 anva_equipment[])
public function integer of_gettrailerlist (ref n_cst_beo_equipment2 anva_equipment[])
public function long of_getfirsteventid (string as_eventtypes)
public function integer of_getreferencedcompanies (ref long ala_companyids[])
public function integer of_validatestatus (string as_status, ref string as_message, unsignedlong aul_exclude)
public function long of_geteventlist (ref n_cst_beo_event anva_events[])
private function integer of_prevalidateeventremoval (n_cst_beo_event anva_events[])
public function string of_getnotificationtemplate ()
public function integer of_setnotificationtemplate (string as_Value)
public function int of_setnetcharge (dec ac_Value)
public function integer of_setbillingformat (string as_Value)
public function int of_setrequiredequipment (string as_Value)
public function integer of_setimportreference (string as_Value)
public function string of_getimportreference ()
public function integer of_setdiscountamount (decimal ac_value)
public function integer of_setfreightamount (decimal ac_value)
public function integer of_setaccessorialamount (decimal ac_value)
public function integer of_getnotificationtargets (ref long ala_targets[])
public function integer of_setaccnotecontacts (long ala_contacts[])
public function integer of_setaccauthcontacts (long ala_contacts[])
public function integer of_setlastfreedatecontacts (long ala_contacts[])
public function integer of_getlastfreedatecontacts (ref long ala_contacts[])
public function integer of_geteventcontacts (ref long ala_contacts[])
public function int of_getaccnotecontacts (ref long ala_Contacts[])
public function int of_getaccauthcontacts (ref long ala_Contacts[])
public function integer of_getshipmentcontacts (ref long ala_Contacts[])
public function integer of_setshipmentcontacts (long ala_contacts[])
public function integer of_seteventcontacts (long ala_contacts[])
public function long of_getitemlist (ref n_cst_beo_item anva_item[], string as_type)
public function integer of_addleasecharges (n_cst_bso_dispatch anv_dispatch, n_cst_msg anv_msg)
public function integer of_removeitem (long al_itemid, n_cst_bso_dispatch anv_dispatch)
public function integer of_removeitems (long ala_ItemIds[], n_cst_bso_Dispatch anv_Dispatch)
public function long of_getitemcount (string as_Type)
public function integer of_addchassismove (long al_siteid, n_cst_bso_dispatch anv_dispatch, ref long ala_newids[], boolean ab_convertfirst, boolean ab_convertlast)
public function long of_addfrontchassissplititem (n_cst_bso_dispatch anv_dispatch)
public function long of_addbackchassissplititem (n_cst_bso_dispatch anv_dispatch)
public function integer of_getitemsforeventtype (string as_type, ref n_cst_beo_item anva_items[])
public function integer of_setforwarderref (string as_value)
public function integer of_setseal (string as_value)
public function integer of_setbookingnumber (string as_value)
public function integer of_setmasterbl (string as_value)
public function string of_getmovecode ()
public function int of_sethazmat (boolean ab_Value)
public function boolean of_allowchassismove (boolean ab_splitfront, boolean ab_splitback)
public function integer of_autoratecombined (ref n_cst_ratedata anva_ratedata[])
public function integer of_companyadded (long al_companyid)
public function int of_addaccnotecontacts (long ala_contactids[])
public function integer of_addaccauthcontacts (long ala_contactids[])
public function integer of_addshipmentcontacts (long ala_ContactIds[])
public function integer of_addlastfreedatecontacts (long ala_Contactids[])
private function integer of_setcontacts ()
public function date of_getprenotedate ()
public function boolean of_isintermodal ()
public function integer of_cleancontactlist ()
public function integer of_processstatusnotifications (string as_newstatus, n_cst_bso_dispatch anv_dispatch)
public function integer of_setagent (long al_value)
public function integer of_setforwarder (long al_value)
public function string of_getnotificationsubject ()
public subroutine of_rerateitems ()
public function long of_applyaccessrate (n_cst_ratedata anva_ratedata[])
public function long of_applyfreightrate (n_cst_ratedata anva_ratedata[], string as_whatchanged)
public function integer of_autorate (ref n_cst_ratedata anva_ratedata[], string as_whatchanged)
public function long of_applyfreightrate (n_cst_ratedata anva_ratedata[], string as_whatchanged, boolean ab_recalc)
public function time of_getprenotetime ()
public function string of_getprenoteby ()
public function string of_getprenoteuser ()
public function date of_getetadate ()
public function time of_getetatime ()
public function string of_getetaby ()
public function string of_getetauser ()
public function string of_getarrivedby ()
public function string of_getarriveduser ()
public function date of_getgroundeddate ()
public function time of_getgroundedtime ()
public function string of_getgroundedby ()
public function string of_getgroundeduser ()
public function string of_getpickupnumber ()
public function string of_getpickupnumberby ()
public function string of_getpickupnumberuser ()
public function string of_getbookingnumberby ()
public function string of_getbookingnumberuser ()
public function date of_getreleasedate ()
public function time of_getreleasetime ()
public function string of_getreleaseby ()
public function string of_getreleaseuser ()
public function string of_getlfdby ()
public function string of_getlfduser ()
public function string of_getpickupbyby ()
public function string of_getpickupbyuser ()
public function date of_getdelbydate ()
public function time of_getdelbytime ()
public function string of_getdelbyby ()
public function string of_getdelbyuser ()
public function string of_getcutoffuser ()
public function date of_getemptyatcustomerdate ()
public function time of_getemptyatcustomertime ()
public function string of_getemptyatcustomerby ()
public function string of_getemptyatcustomeruser ()
public function date of_getloadedatcustomerdate ()
public function time of_getloadedatcustomertime ()
public function string of_getloadedatcustomerby ()
public function string of_getloadedatcustomeruser ()
public function string of_getrailbillnumber ()
public function string of_getrailbillnumberuser ()
public function date of_getrailbilleddate ()
public function string of_getrailbilledby ()
public function string of_getrailbilleduser ()
public function string of_getcutoffby ()
public function date of_getpickupbydate ()
public function time of_getpickupbytime ()
public function integer of_autorateeventtypeitem (string as_itemtype)
public function integer of_setprenotedate (date ad_Value)
public function integer of_setprenotetime (time at_Value)
public function integer of_setprenoteuser (string as_Value)
public function integer of_setunspecifiedeventtype (string as_Type)
public function integer of_getnotifyitems (ref n_cst_beo_item anva_items[])
public function date of_getshipmentexpire ()
public function integer of_setreleasedate (date ad_value)
public function integer of_getlinkedequipment (ref n_cst_beo_equipment2 anva_equipment[])
public function integer of_setequipmentreleasedate (date ad_value, ref n_cst_bso_dispatch anv_dispatch)
public function integer of_calculateequipmentleaseftx (n_cst_bso_dispatch anv_dispatch)
public function integer of_setequipmentreleasetime (time at_value, n_cst_bso_dispatch anv_dispatch)
public function integer of_setreleasetime (time at_value)
public function integer of_setcustomtext (string as_Value, string as_WhichOne)
public function integer of_setcustomtext (string as_Value, integer ai_WhichOne)
public function boolean of_isshiptypebrokerage ()
public function integer of_getreloadequipment (ref n_Cst_beo_Equipment2 anva_Equipment[])
public function integer of_eventsitechanged (long al_oldsiteid, long al_newsiteid, long al_eventid)
public function long of_addstopoffitem (n_cst_beo_event anv_event, n_cst_bso_dispatch anv_dispatch)
public function boolean of_hasfuelsurcharge ()
public function long of_recalcsurcharges ()
public function integer of_removeitem (n_cst_beo_item anv_item)
public function long of_additem (string as_type)
public function integer of_recalcexistingsurcharges ()
public function integer of_reseteqcache ()
public function integer of_getroutedevents (ref n_cst_beo_Event anva_EventList[])
public function integer of_setpickupnumber (string as_value)
public function integer of_addtomodlog (string as_Value)
private function integer of_removestopoffitem ()
private function integer of_removestopoffifneeded ()
public function boolean of_hasfrontchassissplit ()
public function boolean of_hasbackchassissplit ()
public function integer of_frontchassissplitadded (n_cst_bso_dispatch anv_dispatch)
public function integer of_backchassissplitadded (n_cst_bso_dispatch anv_dispatch)
public function integer of_resetcontacts (ref n_cst_beo_event anv_event, string as_action, string as_type, ref long ala_contactid[], long al_site)
public function integer of_geteventbyorigindestination (ref n_cst_beo_event anva_beo_event[], string as_type)
public function integer of_geteventcompanies (ref long ala_companyid[])
public function integer of_reseteventcontacts ()
public function integer of_moveeventcontacts (ref n_cst_beo_event anva_oldevent[], ref n_cst_beo_event anva_newevent[], string as_orgindestination)
public function integer of_addeventcontacts (ref n_cst_beo_event anv_event)
public function integer of_removedeletedeventsite (long ala_siteid[])
public function integer of_setrailbilleduser (string as_value)
public function integer of_setprepaidcollect (character ac_value)
public function integer of_setinvoicenumber (string as_value)
public function integer of_setmovecode (string as_value)
public function integer of_setbillto (long al_value)
public function integer of_setcarrier (long al_value)
public function integer of_settotalmiles (integer ai_value)
public function integer of_settotalweight (long al_value)
public function integer of_sethazmat (string as_value)
public function integer of_setexpedite (string as_value)
public function integer of_setinvoicedate (date ad_value)
public function integer of_setmodlog (string as_value)
public function integer of_settype (long al_value)
public function integer of_setmovetype (string as_value)
public function integer of_setoriginport (string as_value)
public function integer of_setdestinationport (string as_value)
public function integer of_setline (string as_value)
public function integer of_setvessel (string as_value)
public function integer of_setvoyage (string as_value)
public function integer of_setcutoffdate (date ad_value)
public function integer of_setcutofftime (time at_value)
public function integer of_setarrivaldate (date ad_value)
public function integer of_setarrivaltime (time at_value)
public function integer of_setlastfreedate (date ad_value)
public function integer of_setlastfreetime (time at_value)
public function integer of_sethousebl (string as_value)
public function integer of_setagentref (string as_value)
public function integer of_setdispatchedby (string as_value)
public function integer of_setavailableon (date ad_value)
public function integer of_setavailableuntil (date ad_value)
public function integer of_setprenoteby (string as_value)
public function integer of_setetadate (date ad_value)
public function integer of_setetatime (time at_value)
public function integer of_setetaby (string as_value)
public function integer of_setetauser (string as_value)
public function integer of_setarrivedby (string as_value)
public function integer of_setarriveduser (string as_value)
public function integer of_setgroundeddate (date ad_value)
public function integer of_setgroundedtime (time at_value)
public function integer of_setgroundedby (string as_value)
public function integer of_setgroundeduser (string as_value)
public function integer of_setpickupnumberby (string as_value)
public function integer of_setpickupnumberuser (string as_value)
public function integer of_setbookingnumberby (string as_value)
public function integer of_setbookingnumberuser (string as_value)
public function integer of_setreleaseby (string as_value)
public function integer of_setreleaseuser (string as_value)
public function integer of_setlfdby (string as_value)
public function integer of_setlfduser (string as_value)
public function integer of_setpickupbydate (date ad_value)
public function integer of_setpickupbytime (time at_value)
public function integer of_setpickupbyby (string as_value)
public function integer of_setpickupbyuser (string as_value)
public function integer of_setdelbydate (date ad_value)
public function integer of_setdelbytime (time at_value)
public function integer of_setdelbyby (string as_value)
public function integer of_setdelbyuser (string as_value)
public function integer of_setcutoffby (string as_value)
public function integer of_setcutoffuser (string as_value)
public function integer of_setemptyatcustomerdate (date ad_value)
public function integer of_setemptyatcustomertime (time at_value)
public function integer of_setemptyatcustomerby (string as_value)
public function integer of_setemptyatcustomeruser (string as_value)
public function integer of_setloadedatcustomerdate (date ad_value)
public function integer of_setloadedatcustomertime (time at_value)
public function integer of_setloadedatcustomerby (string as_value)
public function integer of_setloadedatcustomeruser (string as_value)
public function integer of_setrailbillnumber (string as_value)
public function integer of_setrailbillnumberuser (string as_value)
public function integer of_setrailbilleddate (date ad_value)
public function integer of_setrailbilledby (string as_value)
public function integer of_setdatepickedup (date ad_value)
public function integer of_settimepickedup (time at_value)
public function integer of_setdatedelivered (date ad_value)
public function integer of_settimedelivered (time at_value)
public function integer of_setpod (string as_value)
public function integer of_setscheduledpickupdate (date ad_value)
public function integer of_setscheduledpickuptime (time at_value)
public function integer of_setscheduleddeliverydate (date ad_value)
public function integer of_setscheduleddeliverytime (time at_value)
public function integer of_settotalpieces (decimal ac_value)
public function integer of_setsalescommission (decimal ac_value)
public function integer of_setpayabletotal (decimal ac_value)
public function integer of_setfreightpayable (decimal ac_value)
public function integer of_setaccessorialpayable (decimal ac_value)
public function integer of_setfreightcharges (decimal ac_value)
public function integer of_setparentid (readonly long al_value)
public function integer of_setvalue (string as_column, string as_value)
public function integer of_setid (long al_value)
public function integer of_setblnumbers (string as_value)
public function integer of_setref1label (string as_value)
public function integer of_setref2label (string as_value)
public function integer of_setref3label (string as_value)
private function integer of_setdefaultfreightdescription ()
public function integer of_setbilltobyref (string as_companyref)
public function integer of_checkprepaidcollect ()
public function long of_getnonspecialfreight (ref n_cst_beo_item anva_item[])
public function decimal of_getfuelsurchargeableamount (string as_surchargetype)
public function integer of_recordchange (string as_column)
public function integer of_gettotalmiles (ref decimal ac_miles)
public function integer of_setdeliverymode (integer ai_pickupindex, integer ai_stopindex)
public function boolean of_getdeliverymodestop (ref integer ai_stopindex)
public function boolean of_getdeliverymodepickup (ref integer ai_pickup)
public function string of_getpaymentterms ()
public function integer of_setpaymentterms (string as_value)
public function integer of_getleasecharges ()
public function integer of_getreferencedcompanies (ref n_cst_beo_company anva_companies[])
public function integer of_getreferencedentities (ref pt_n_cst_beo anv_objects[])
public function integer of_getfreightitemsforpudelpair (integer ai_pu, integer ai_del, ref long ala_itemids[])
public function integer of_setdelrecitems (long ala_itemids[])
public function integer of_determinepaymentterms (string as_whatchanged, ref string as_terms)
public function integer of_getnonorigindestevents (ref n_cst_beo_event anv_events[])
public function integer of_getoriginevent (ref n_cst_beo_event anv_event)
public function integer of_getdestinationevent (ref n_cst_beo_event anv_event)
public function decimal of_getpermilemileage ()
private function integer of_getlinkedequipmentviasql (ref n_cst_beo_equipment2 anv_equipment[])
public function boolean of_iscancelled ()
public subroutine of_autogenaccessorialitem ()
public function boolean of_createaccessorialitem ()
public function integer of_getitemtype (string as_ratecode, ref long al_amounttype, ref string as_itemtype, ref string as_description)
public function long of_additem (string as_type, ref n_cst_bso_dispatch anv_dispatch)
public function integer of_getnonorigindestevents (ref n_cst_beo_event anva_events[], boolean ab_hidecrossdocks)
public function integer of_geteventlist (ref n_cst_beo_event anva_events[], boolean ab_removecrossdocs)
public function integer of_addbilltodocumentrequest (string as_documenttype)
private function integer of_klugevalidation (ref string as_error)
public function integer of_addyardmove (long al_siteid, integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatch, ref long ala_newids[])
public function boolean of_allowitemedit ()
public function integer of_addyardmove (long al_siteid, integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatch, ref long ala_newids[], long al_dropid)
public function boolean of_hasnewfuelsurcharge ()
public function integer of_recalcexistingsurcharges (boolean ab_useoldvalue)
public function integer of_getlinkedequipmentnocoinfo (ref n_cst_beo_equipment2 anva_equipment[])
public function long of_getdivisionid ()
public function string of_getmanifestinvoicenumbernodashes ()
public function integer of_markasmodified ()
public function boolean of_setautoratingforedicompany (long al_companyid)
public function boolean of_getautorateforedicompany ()
public function long of_additem (string as_type, boolean ab_ignorerestrictions)
public function long of_additem (string as_type, ref n_cst_bso_dispatch anv_dispatch, boolean ab_temporaryitem)
public function integer of_deactivateequipment ()
public function n_cst_beo_ShipType of_getshipmenttypebeo ()
public function long of_addbobtailitem (n_cst_beo_event anv_event, n_cst_bso_dispatch anv_dispatch)
public function n_cst_beo_event of_getlastconfirmedevent ()
public function integer of_addyardstorageitem (n_cst_beo_event anv_anchorevent)
end prototypes

public function long of_getid ();RETURN This.of_GetValue ( "ds_id", TypeLong! )
end function

public function integer of_delete ();//Returns : 1 (OK), -2 (Not OK)

String	ls_MessageHeader = "Delete Shipment"
n_cst_Privileges	lnv_Privileges

n_cst_LicenseManager	lnv_LicenseManager
String	ls_UserId, ls_LicensedCompany
ls_LicensedCompany = lnv_LicenseManager.of_GetLicensedCompany ( )
ls_UserId = gnv_App.of_GetUserId ( )

IF Left ( ls_LicensedCompany, 3 ) = "S&J" AND &
	NOT ( ls_UserId = "SAM" OR ls_UserId = "MAL" OR ls_UserId = "BARBARA" ) THEN

	This.of_DisplayRestrictMessage ( ls_MessageHeader )
	RETURN -2

ELSEIF lnv_Privileges.of_Shipment_Delete ( ) = FALSE THEN

	This.of_DisplayRestrictMessage ( ls_MessageHeader )
	RETURN -2

ELSEIF This.of_AllowEditBill ( ) = FALSE THEN

	This.of_DisplayRestrictMessage ( ls_MessageHeader )
	RETURN -2

END IF

RETURN 1
end function

public function integer of_deleteitem (long al_id);String	ls_MessageHeader
Integer	li_Result

ls_MessageHeader = "Delete Item"

IF of_AllowItemEdit ( ) = FALSE THEN
	of_DisplayRestrictMessage ( ls_MessageHeader )
	RETURN -2
END IF

li_Result = 1

RETURN li_Result
end function

public function integer of_additem ();String	ls_MessageHeader
Integer	li_Result

ls_MessageHeader = "Add Item"

IF of_AllowItemEdit ( ) = FALSE THEN
	of_DisplayRestrictMessage ( ls_MessageHeader )
	RETURN -2
END IF

li_Result = 1

RETURN li_Result
end function

public function integer of_addevent ();String	ls_MessageHeader = "Add Event"

Integer	li_Result = 1
n_cst_privileges_events	lnv_Privs


IF NOT lnv_Privs.of_Allowalteritins( ) THEN
	This.of_DisplayRestrictMessage ( ls_MessageHeader )
	li_Result = -2
ELSE
	IF This.of_AllowEdit ( ) = FALSE THEN
		//User can't edit shipments at all, so adding events is not allowed.
		This.of_DisplayRestrictMessage ( ls_MessageHeader )
		li_Result = -2
	ELSEIF This.of_AllowEditBill ( ) = TRUE THEN
		//Based on privileges, user can modify the bill for the current status.
	ELSEIF This.of_AllowRestrictActive ( ) = TRUE THEN
		//Force billing is enabled, adding events is allowed, regardless of status.
	ELSE
		//None of the allowing conditions were met, so reject.
		This.of_DisplayRestrictMessage ( ls_MessageHeader )
		li_Result = -2
	END IF
END IF

RETURN li_Result
end function

public function integer of_moveevent ();String	ls_MessageHeader
Integer	li_Result

n_cst_privileges_events	lnv_Privs

ls_MessageHeader = "Move Event"

IF of_AllowEditBill ( ) = FALSE OR lnv_Privs.of_allowalteritins( ) = FALSE THEN
	of_DisplayRestrictMessage ( ls_MessageHeader )
	RETURN -2
END IF

li_Result = 1

RETURN li_Result


/*  From w_ship.wf_move_event

if restrict or status > "K" then return

*/
end function

public function integer of_deleteevent (long al_id);String	ls_MessageHeader
Integer	li_Result

ls_MessageHeader = "Delete Event"

IF of_AllowEditBill ( ) = FALSE THEN
	of_DisplayRestrictMessage ( ls_MessageHeader )
	RETURN -2
END IF

li_Result = 1

RETURN li_Result
end function

public function integer of_seteventsource (powerobject apo_source);DataWindow	ldw_Source
DataStore	lds_Source
n_cst_Dws	lnv_Dws
Integer		li_Return

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( apo_Source, ldw_Source, lds_Source )

CASE DataWindow!, DataStore!

	idw_EventSource = ldw_Source
	ids_EventSource = lds_Source
	li_Return = 1

CASE ELSE

	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function integer of_setitemsource (powerobject apo_source);DataWindow	ldw_Source
DataStore	lds_Source
n_cst_Dws	lnv_Dws
Integer		li_Return

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( apo_Source, ldw_Source, lds_Source )

CASE DataWindow!, DataStore!

	idw_ItemSource = ldw_Source
	ids_ItemSource = lds_Source
	li_Return = 1

CASE ELSE

	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function powerobject of_geteventsource ();PowerObject	lpo_Source

IF IsValid ( idw_EventSource ) THEN
	lpo_Source = idw_EventSource
ELSEIF IsValid ( ids_EventSource ) THEN
	lpo_Source = ids_EventSource
END IF

RETURN lpo_Source
end function

public function powerobject of_getitemsource ();PowerObject	lpo_Source

IF IsValid ( idw_ItemSource ) THEN
	lpo_Source = idw_ItemSource
ELSEIF IsValid ( ids_ItemSource ) THEN
	lpo_Source = ids_ItemSource
END IF

RETURN lpo_Source
end function

public function boolean of_hasconfirmedevents ();Boolean	lb_Result

IF This.of_GetConfirmedEventCount ( ) > 0 THEN
	lb_Result = TRUE
END IF

RETURN lb_Result


/* From w_ship.display_ship

if w_disp.ds_events.find("de_conf = 'T'", 1, numevents) <> 0 then anyconf = true

*/
end function

public function long of_geteventcount ();n_cst_beo_Event	lnva_Events[]
Int	li_Count
Int 	i

li_Count = This.of_GetEventList ( lnva_Events )

FOR i = 1 TO li_Count 
	DESTROY ( lnva_Events[i] )
NEXT

RETURN li_Count

end function

public function long of_getitemcount ();n_cst_beo_Item	lnva_Items[]
Int 	li_Index
long	ll_Count

ll_Count = This.of_GetItemList ( lnva_Items )

ll_Count = UpperBound ( lnva_Items ) 
FOR li_Index = 1 TO ll_Count
	DESTROY ( lnva_Items [ li_Index ] )
NEXT

RETURN ll_Count
end function

public function integer of_changeformat ();String	ls_MessageHeader
Integer	li_Result

ls_MessageHeader = "Change Billing/Payables Format"

IF of_AllowEditBill ( ) = FALSE THEN
	of_DisplayRestrictMessage ( ls_MessageHeader )
	RETURN -2
END IF

li_Result = 1

RETURN li_Result
end function

public function boolean of_isbilled ();Boolean	lb_Result

CHOOSE CASE This.of_GetStatus ( )

CASE gc_Dispatch.cs_ShipmentStatus_Billed
	lb_Result = TRUE

CASE ELSE
	lb_Result = FALSE

END CHOOSE

RETURN lb_Result
end function

public function string of_getstatus ();RETURN This.of_GetValue ( "ds_status", TypeString! )
end function

public function boolean of_isrestricted ();//Returns TRUE if the shipment has any level of authorization, or if that can't be determined
//Returns FALSE if the shipment has no authorization, and therefore no restrictions

Boolean	lb_Restricted

CHOOSE CASE This.of_GetStatus ( )

CASE gc_Dispatch.cs_ShipmentStatus_Open
	lb_Restricted = FALSE

CASE ELSE
	lb_Restricted = TRUE

END CHOOSE

RETURN lb_Restricted
end function

private subroutine of_displayrestrictmessage (string as_messageheader);n_cst_Privileges	lnv_Privileges
//Dan check to see if scheduler is running
IF NOT gnv_app.of_runningscheduledtask( ) THEN	
	MessageBox ( as_MessageHeader, lnv_Privileges.of_GetRestrictMessage ( ) )
END IF
//-------
/* commented out when Dan integrated autorating of imports with FSC
n_cst_Privileges	lnv_Privileges

MessageBox ( as_MessageHeader, lnv_Privileges.of_GetRestrictMessage ( ) )
*/
end subroutine

public function integer of_validatestatus (string as_status, ref string as_message);RETURN THIS.of_ValidateStatus ( as_status , as_message , 0 ) 
end function

public function long of_gettype ();RETURN This.of_GetValue ( "ds_ship_type", TypeLong! )
end function

public function long of_getitemlist (ref n_cst_beo_item anva_items[]);//Returns : The number of items in the shipment, or null if the list cannot be determined

//**NOTE:  The items will be returned in whatever order they are encountered in the primary
//buffer of the cache.  If you want them in shipment sequence order, they must be sorted that
//way in the cache.**

Long	ll_Row, &
		ll_RowCount, &
		ll_ItemCount, &
		ll_ShipmentId
Long	ll_id
Integer		li_DeliveryModeStopIndex
Boolean		lb_DeliveryMode
String		ls_Find
Long			ll_FilterCount
PowerObject	lpo_Source
n_cst_Dws	lnv_Dws
n_cst_beo_Item		lnva_ItemList[]
DataStore		lds_Copy

Int i
ll_ItemCount = UpperBound ( anva_items[] )


	ll_ShipmentId = This.of_GetSourceId ( )
	
	lpo_Source = This.of_GetItemSource ( )
	ll_RowCount = lnv_Dws.of_Rowcount ( lpo_Source )
	ll_FilterCount = lnv_Dws.of_FilteredCount ( lpo_Source )
	//
	lds_Copy = CREATE DataStore
	lds_Copy.DataObject = lnv_Dws.of_GetDataObject ( lpo_Source )

	// make a copy of the data so it can be filtered and sorted
	lnv_Dws.of_RowsCopy ( lpo_Source, 1, ll_RowCount, Primary!, lds_Copy, 9999, Primary! )
	lnv_Dws.of_rowscopy ( lpo_Source, 1, ll_FilterCount, FILTER!, lds_Copy ,9999, PRIMARY! )	
	
	lds_Copy.SetFilter ( "di_Shipment_Id = " + String ( ll_ShipmentId ) ) 
	lds_Copy.Filter ( ) 
	
	lds_Copy.SetSort ( "di_item_type D , di_Item_id A" )
	lds_Copy.Sort ( )
	//
	
	
	lb_DeliveryMode = This.of_GetDeliveryModeStop ( li_DeliveryModeStopIndex )

	ls_Find = "di_Shipment_Id = " + String ( ll_ShipmentId )

	IF lb_DeliveryMode THEN//AND NOT IsNull ( li_DeliveryModeStopIndex ) THEN
		//Because specifically assigned accessorials only record the stop index in
		//di_pu_event, we need to include that, too.  If li_DeliveryModeStopIndex
		//erroneously points to a pickup, this will yield some odd behavior.
		//ls_Find += "AND (di_pu_event = " + String ( li_DeliveryModeStopIndex ) +&
		//	" OR di_del_event = " + String ( li_DeliveryModeStopIndex ) + ")"
		String ls_Filter
		n_cst_Sql	lnv_Sql
		ls_Filter = "di_Item_id " + lnv_Sql.of_Makeinclause( ila_delrecitems )
		lds_Copy.SetFilter ( ls_Filter ) 
		lds_Copy.Filter ( ) 
		
	END IF
	
	ll_RowCount = lds_Copy.rowcount()
	
	FOR i = 1 TO ll_RowCount 

			ll_ID = lds_Copy.object.di_item_id [ i ]
			ll_ItemCount ++
			lnva_ItemList [ ll_ItemCount ] = CREATE n_cst_Beo_Item
			lnva_ItemList [ ll_ItemCount ].of_SetSource ( lpo_Source )
			lnva_ItemList [ ll_ItemCount ].of_SetSourceid ( ll_ID )
//			<<*>> I added this on 4-9-03
			lnva_ItemList [ ll_ItemCount ].of_SetShipment ( THIS )
	NEXT


	anva_Items = lnva_ItemList

	IF ll_RowCount >= 0 THEN

	ELSE  //The item list couldn't be determined.  Return Null.
		SetNull ( ll_ItemCount )

	END IF



DESTROY ( lds_Copy )
RETURN ll_ItemCount
end function

public function boolean of_hasalleventsconfirmed ();Boolean	lb_Result

Constant String	cs_LockId = "This.of_HasAllEventsConfirmed"

This.of_LockEventList ( cs_LockId )

IF This.of_GetEventCount ( ) = This.of_GetConfirmedEventCount ( ) THEN
	lb_Result = TRUE
END IF

This.of_ReleaseEventList ( cs_LockId )

RETURN lb_Result
end function

public function long of_getconfirmedeventcount ();Long	ll_EventCount, &
		ll_Ndx, &
		ll_ConfirmedCount
n_cst_beo_Event	lnva_Events[]

ll_EventCount = This.of_GetEventList ( lnva_Events )

FOR ll_Ndx = 1 TO ll_EventCount

	IF lnva_Events [ ll_Ndx ].of_IsConfirmed ( ) THEN
		ll_ConfirmedCount ++
	END IF

NEXT

IF IsNull ( ll_EventCount ) THEN
	SetNull ( ll_ConfirmedCount )
END IF

Int i
ll_EventCount = UpperBound ( lnva_Events )
FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_Events[i] )
NEXT

RETURN ll_ConfirmedCount
end function

public function long of_getunconfirmedeventcount ();Long	ll_EventCount, &
		ll_ConfirmedEventCount, &
		ll_UnconfirmedEventCount

Constant String	cs_LockId = "This.of_GetUnconfirmedEventCount"

This.of_LockEventList ( cs_LockId )

ll_EventCount = This.of_GetEventCount ( )
ll_ConfirmedEventCount = This.of_GetConfirmedEventCount ( )

This.of_ReleaseEventList ( cs_LockId )

IF ll_EventCount >= ll_ConfirmedEventCount AND &
	ll_EventCount >= 0 THEN

	ll_UnconfirmedEventCount = ll_EventCount - ll_ConfirmedEventCount

ELSE

	SetNull ( ll_UnconfirmedEventCount )

END IF

RETURN ll_UnconfirmedEventCount
end function

public function string of_getbillingformat ();RETURN of_GetValue ( "ds_bill_format", TypeString! )
end function

public function long of_getbillto ();RETURN This.of_GetValue ( "ds_billto_id", TypeLong! )
end function

public function boolean of_hasbillto ();Boolean	lb_Result

IF of_GetBillto ( ) > 0 THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function date of_getshipdate ();RETURN This.of_GetValue ( "ds_ship_date", TypeDate! )
end function

public function integer of_validatestatus (ref string as_message);String	ls_CurrentStatus

ls_CurrentStatus = This.of_GetStatus ( )

RETURN This.of_ValidateStatus ( ls_CurrentStatus, as_Message )
end function

public function integer of_setstatus (string as_value);Int	li_Return

li_Return = of_SetAny ( "ds_status", as_Value )

Boolean	lb_DeactivateEq

IF li_Return = 1 THEN
	
	CHOOSE CASE as_Value
			
		CASE gc_Dispatch.cs_ShipmentStatus_Declined, &
				gc_Dispatch.cs_ShipmentStatus_Cancelled
			  
			  	THIS.of_Deactivateequipment( )
				  
		CASE gc_Dispatch.cs_ShipmentStatus_authorized, &
				gc_Dispatch.cs_ShipmentStatus_audited			  
				  
			n_Cst_beo_Equipment2	lnva_Equipment[]
			IF THIS.of_Hasalleventsconfirmed( ) THEN
				THIS.of_GetLinkedEquipment  (	lnva_Equipment )
			
			
				Int	i
				Int li_Count
				
				n_Cst_bso	lnv_Dispatch
				
				n_cst_beo_Equipment2		lnva_Eq[]
				n_Cst_beo_Equipment2		lnv_equipment
				n_Cst_Equipmentmanager	lnv_EqMan
				DataStore					lds_EqCache
			
				lnv_Dispatch = THIS.of_GetContext( )
				lnv_equipment = CREATE n_cst_beo_Equipment2
			
				IF Not isValid ( lnv_Dispatch ) THEN
					li_Return = -1
				END IF
			
				IF li_Return = 1 THEN
					IF lnv_Dispatch.Classname( ) <> "n_cst_bso_dispatch" THEN
						li_Return = -1
					END IF	
				END IF
			
				IF li_Return = 1 THEN
					
					li_Count =	THIS.of_GetLinkedequipment( lnva_Eq	)
					lds_EqCache = lnv_Dispatch.Dynamic of_getequipmentcache()
					Long	ll_Reload
					FOR i = 1 TO 	li_Count	
						ll_Reload = lnva_Eq[i].of_GetReloadshipment( )
						IF IsNull ( ll_Reload ) OR ll_Reload = THIS.of_GetID ( ) THEN
						
						
						//IF ll_Reload > 0 AND ll_Reload <> THIS.of_GetID ( )THEN
							lnva_Eq[i].of_SetStatus("D")
							lnv_Equipment.of_SetSource ( lds_eqCache )
							lnv_Equipment.of_SetSourceid( lnva_Eq[i].of_getID ( ) )
							lnv_equipment.of_SetStatus ( "D" )
						END IF
						DESTROY (lnva_Eq[i])
					NEXT	
				END IF
			
				DESTROY lnv_equipment
			END IF
		
			
		
	END CHOOSE
	
	
END IF



RETURN li_Return
end function

public function string of_getcategory ();RETURN of_GetValue ( "ds_dorb", TypeString! )
end function

public function boolean of_isbrokerage ();Boolean	lb_Result

IF This.of_GetCategory ( ) = cs_Category_Brokerage THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function long of_gettrip ();RETURN of_GetValue ( "ds_brok_trip", TypeLong! )
end function

public function long of_getcarrier ();//commented following code 2/26/02 norm.
//Long	ll_Carrier
//
//IF of_IsBrokerage ( ) THEN
//	ll_Carrier = of_GetValue ( "ds_pay1_id", TypeLong! )
//ELSE
//	SetNull ( ll_Carrier )
//END IF
//
//RETURN ll_Carrier

RETURN of_GetValue ( "ds_pay1_id", TypeLong! )
end function

public function boolean of_hastrip ();Boolean	lb_Result

IF of_GetTrip ( ) > 0 THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function boolean of_hascarrier ();Boolean	lb_Result

IF of_GetCarrier ( ) > 0 THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function integer of_unconfirmevent ();String	ls_MessageHeader
n_cst_Privileges_Events	lnv_Privs

ls_MessageHeader = "Unconfirm Event"
//If NOT lnv_Privs.of_allowunconfirm( ) THEN
IF gnv_App.of_getprivsmanager( ).of_getuserpermissionfromfn( "UnconfirmEvents", THIS ) = appeon_constant.ci_FALSE THEN

//IF of_AllowEdit ( ) = FALSE THEN
	of_DisplayRestrictMessage ( ls_MessageHeader )
	RETURN -2
END IF

RETURN 1
end function

public function boolean of_alloweditbill ();Boolean	lb_Allow
Boolean	lb_hasPermission
n_cst_Privileges	lnv_Privileges
n_cst_setting_allowforcebilling	lnv_AllowForceBilling

//Modified By dan 2-7-07 to user a different extended priv if this shipment is billed.
String	ls_privFunction
IF this.of_isBilled( ) THEN
	//DEK 4-19-07 My previous changes took away functionality for users who were not using
	//advanced privileges. This is because the default user role is different from one function to the other.
	IF gnv_App.of_getprivsmanager( ).of_useadvancedprivs( ) THEN
		ls_privFunction = appeon_constant.cs_ModifyBilledShip
	ELSE
		ls_privFunction = "ModifyShipment"
	END IF
ELSE
	ls_privFunction = "ModifyShipment"
END IF
//////////////////////////

IF gnv_App.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction, THIS ) = appeon_constant.ci_True THEN	
	IF of_IsBilled ( ) THEN
	
		IF lnv_Privileges.of_Shipment_EditBilledBill ( ) THEN
			lb_Allow = TRUE
		END IF
		
		IF Not lb_Allow AND lnv_Privileges.of_hasentryrights( ) THEN
			lnv_AllowForceBilling = CREATE n_cst_setting_allowforcebilling
			IF lnv_AllowForceBilling.of_GetValue( ) = lnv_AllowForceBilling.cs_yes THEN
				IF THIS.of_Getconfirmedeventcount( ) <> THIS.of_GetEventcount( ) THEN
					lb_Allow = TRUE
				END IF				
			END IF
			DESTROY (lnv_AllowForceBilling)		
		END IF
	
	ELSEIF of_IsRestricted ( ) THEN
	
		IF lnv_Privileges.of_Shipment_EditRestrictedBill ( ) THEN
			lb_Allow = TRUE
		END IF
	
	ELSEIF lnv_Privileges.of_Shipment_EditBill ( ) THEN
	
		lb_Allow = TRUE
	
	END IF
END IF
//IF THIS.of_GetStatus ( ) = gc_Dispatch.cs_ShipmentStatus_Offered OR &
//	THIS.of_GetStatus ( ) = gc_Dispatch.cs_ShipmentStatus_Declined THEN
//	lb_Allow = FALSE
//END IF


RETURN lb_Allow
end function

public function boolean of_allowedit ();Boolean	lb_Allow
n_cst_Privileges	lnv_Privileges

//Modified by Dan 2-7-07 to check a different privilege if it has been billed.
String	ls_privFunction
IF this.of_isBilled( ) THEN
	//DEK 4-19-07 My previous change took away functionality for users who were
	//not using advanced privs.  This is because the default roll is different for modifying a billed shipment
	//then it was for others.
	IF gnv_App.of_getprivsmanager( ).of_useadvancedprivs( ) THEN
		ls_privFunction = appeon_constant.cs_ModifyBilledShip
	ELSE
		ls_privFunction = "ModifyShipment"
	END IF
ELSE
	ls_privFunction = "ModifyShipment"
END IF
////////////////////////////


IF gnv_App.of_getprivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction, THIS ) = appeon_constant.ci_True AND &
	( THIS.of_GetStatus ( ) <> gc_Dispatch.cs_ShipmentStatus_Declined ) THEN
	
	lb_Allow	= TRUE


END IF


//IF gnv_App.of_getprivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction, THIS ) = appeon_constant.ci_True AND & 
//	( THIS.of_GetStatus ( ) <> gc_Dispatch.cs_ShipmentStatus_offered AND THIS.of_GetStatus ( ) <> gc_Dispatch.cs_ShipmentStatus_Declined ) THEN
//	
//	lb_Allow	= TRUE
//
//
//END IF
//
//IF lnv_Privileges.of_Shipment_Edit ( ) AND ( THIS.of_GetStatus ( ) <> gc_Dispatch.cs_ShipmentStatus_offered AND THIS.of_GetStatus ( ) <> gc_Dispatch.cs_ShipmentStatus_Declined ) THEN
//	
//	lb_Allow = TRUE
//
//END IF

RETURN lb_Allow
end function

public function boolean of_allowrestrictactive ();//NOTE: Returns Null if value cannot be determined!

Boolean	lb_Allow
Long		ll_Value

//Retrieve the value, if it hasn't been already

CHOOSE CASE sch_AllowRestrictActive

CASE "T", "F"
	//Value has been retrieved already

CASE ELSE

	SELECT ss_long into :ll_Value FROM system_settings where ss_id = 26 ;

	CHOOSE CASE SQLCA.SqlCode
	CASE 0
		COMMIT ;
		IF ll_Value = 1 THEN
			sch_AllowRestrictActive = "T"
		ELSEIF ll_Value = 0 THEN
			sch_AllowRestrictActive = "F"
		END IF
	CASE 100
		COMMIT ;
		sch_AllowRestrictActive = "F"
	CASE ELSE
		ROLLBACK ;
	END CHOOSE

END CHOOSE


//Translate the value to boolean

CHOOSE CASE sch_AllowRestrictActive

CASE "T"
	lb_Allow = TRUE

CASE "F"
	lb_Allow = FALSE

CASE ELSE
	SetNull ( lb_Allow )

END CHOOSE


RETURN lb_Allow
end function

public function integer of_getevent (integer ai_index, ref n_cst_beo_event anv_event);//Returns : 1 (Success), 0 (Not Found), -1 (Error)

n_cst_beo_Event	lnva_Events[], &
						lnv_Target
Long	ll_Count, &
		ll_Index
Integer	li_Result

ll_Count = of_GetEventList ( lnva_Events )

CHOOSE CASE ll_Count

CASE IS > 0

	FOR ll_Index = 1 TO ll_Count
		
		IF lnva_Events [ ll_Index ].of_GetShipmentSequence ( ) = ai_Index THEN
	
			lnv_Target = lnva_Events [ ll_Index ]
			li_Result = 1
//			EXIT
		ELSE 
			DESTROY ( lnva_Events [ ll_Index ] )
		END IF

	NEXT

CASE 0

	li_Result = 0

CASE ELSE //-1

	li_Result = -1

END CHOOSE


anv_Event = lnv_Target

RETURN li_Result
end function

public function boolean of_isnonrouted ();Boolean	lb_Result

IF This.of_GetCategory ( ) = cs_Category_NonRouted THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function integer of_confirmallevents ();//Attempt to confirm all the events in the shipment.  NOTE : this is a special 
//function only available to non-routed shipments, that does not go through the dispatch
//manager.  Normally, event confirmations go through the dispatch manager to 
//handle things like equipment origination / termination, but that's not an 
//issue with non-routed.

//Returns:  1, -1

Long		ll_EventCount, &
			ll_Index
n_cst_beo_Event	lnva_Events[]
String	lsa_Errors[]


Integer	li_Return = 1


IF li_Return = 1 THEN

	//The shipment must be non-routed in order to perform this operation.  (See note above.)
	//Check that it is, and fail if it isn't, or it can't be determined.

	IF This.of_IsNonRouted ( ) = TRUE THEN
		//OK
	ELSE
		This.of_AddError ( "The shipment is not non-routed." )
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	ll_EventCount = This.of_GetEventList ( lnva_Events )
	
	IF ll_EventCount >= 0 THEN
	
		FOR ll_Index = 1 TO ll_EventCount
	
			IF lnva_Events [ ll_Index ].of_Confirm ( ) = -1 THEN
				lnva_Events [ ll_Index ].of_GetErrors ( lsa_Errors )  //Clears error list
				This.of_AddErrors ( lsa_Errors )
				li_Return = -1
				EXIT
			END IF
	
		NEXT
	
	ELSE
		This.of_AddError ( "There was an error resolving the event list." )
		li_Return = -1
	
	END IF

END IF

Int i

ll_EventCount = UpperBound ( lnva_Events )
FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_Events[i] )
NEXT


RETURN li_Return
end function

public function decimal of_getfreightcharges ();RETURN This.of_GetValue ( "ds_lh_totamt", TypeDecimal! )
end function

public function decimal of_getaccessorialcharges ();RETURN This.of_GetValue ( "ds_ac_totamt", TypeDecimal! )
end function

public function decimal of_getdiscountamount ();RETURN of_GetValue ( "ds_disc_amt", TypeDecimal! )
end function

public function decimal of_getnetfreightcharges ();Decimal	lc_NetFreightCharges

lc_NetFreightCharges = This.of_GetFreightCharges ( ) - This.of_GetDiscountAmount ( )

RETURN lc_NetFreightCharges
end function

public function integer of_calculate ();//Returns : 1, -1

n_cst_beo_Item	lnva_Items[]
Long		ll_ItemCount, &
			ll_Index
Decimal	lc_FreightCharges, &
			lc_DiscountAmount, &
			lc_DiscountPercent, &
			lc_AccessorialCharges, &
			lc_TotalCharges,&
			lc_totalweight

String	ls_BillingFormat

Integer	li_Return = 1

ls_BillingFormat = This.of_GetBillingFormat ( )

ll_ItemCount = This.of_GetItemList ( lnva_Items )

IF ls_BillingFormat = cs_BillingFormat_Total THEN

	//No Processing Needed.  Total is whatever has been specified by the user.

ELSE

	CHOOSE CASE ls_BillingFormat
	
	CASE cs_BillingFormat_Item
			
		IF ll_ItemCount >= 0 THEN
	
			FOR ll_Index = 1 TO ll_ItemCount
	
				lc_FreightCharges += lnva_Items [ ll_Index ].of_GetFreightCharges ( )
				lc_AccessorialCharges += lnva_Items [ ll_Index ].of_GetAccessorialCharges ( )	

			NEXT
	
		ELSE
			li_Return = -1
	
		END IF
	
	CASE cs_BillingFormat_Category
	
		lc_FreightCharges = This.of_GetFreightCharges ( )
		lc_AccessorialCharges = This.of_GetAccessorialCharges ( )
	
	CASE ELSE  //Unexpected Format
		li_Return = -1
	
	END CHOOSE

	IF li_Return = 1 THEN

		lc_DiscountPercent = This.of_GetDiscountPercent ( )
		IF IsNull ( lc_DiscountPercent ) or lc_DiscountPercent = 0 THEN
			//Fixed Discount
			lc_DiscountAmount = This.of_GetDiscountAmount ( )
			
			if lc_FreightCharges > 0 and lc_DiscountAmount > 0 then
				lc_DiscountPercent = lc_DiscountAmount / lc_FreightCharges
			end if
			
		ELSE
			//Calculate Discount from Freight Total & Percentage
			lc_DiscountAmount = lc_DiscountPercent * lc_FreightCharges
		END IF

		IF ll_ItemCount >= 0 THEN	
			FOR ll_Index = 1 TO ll_ItemCount
				lc_totalweight += lnva_Items [ ll_Index ].of_Gettotalweight ( )
			NEXT
		end if
		
		This.of_SetAny ( "ds_lh_totamt", lc_FreightCharges )
		This.of_SetAny ( "ds_disc_pct", lc_DiscountPercent )
		This.of_SetAny ( "ds_disc_amt", lc_DiscountAmount )
		This.of_SetAny ( "ds_ac_totamt", lc_AccessorialCharges )
		This.of_SetAny ( "ds_total_weight", lc_totalweight )
		
		//Read the amounts just set back, so that any rounding performed by the dw fields
		//will be properly reflected in the total.

		lc_FreightCharges = This.of_GetFreightCharges ( )
		lc_DiscountAmount = This.of_GetDiscountAmount ( )
		lc_AccessorialCharges = This.of_GetAccessorialCharges ( )

		lc_TotalCharges = lc_FreightCharges - lc_DiscountAmount + lc_AccessorialCharges

		This.of_SetAny ( "ds_bill_charge", lc_TotalCharges )

	END IF

END IF

ll_ItemCount = UpperBound ( lnva_Items ) 
FOR ll_Index = 1 TO ll_ItemCount
	DESTROY ( lnva_Items [ ll_Index ] )
NEXT

RETURN li_Return
end function

public function decimal of_getdiscountpercent ();RETURN of_GetValue ( "ds_disc_pct", TypeDecimal! )
end function

public function boolean of_allowitemcharges ();//Based on the billing format, are item-level charges allowed or not?

Boolean	lb_Allow

CHOOSE CASE This.of_GetBillingFormat ( )

CASE cs_BillingFormat_Item
	lb_Allow = TRUE

END CHOOSE

RETURN lb_Allow
end function

public function string of_getref1text ();RETURN This.of_GetValue ( "ds_ref1_text", TypeString! )
end function

public function string of_getref2text ();RETURN This.of_GetValue ( "ds_ref2_text", TypeString! )
end function

public function string of_getref3text ();RETURN This.of_GetValue ( "ds_ref3_text", TypeString! )
end function

public function integer of_getref1type ();RETURN This.of_GetValue ( "ds_ref1_type", TypeInteger! )
end function

public function integer of_getref2type ();RETURN This.of_GetValue ( "ds_ref2_type", TypeInteger! )
end function

public function integer of_getref3type ();RETURN This.of_GetValue ( "ds_ref3_type", TypeInteger! )
end function

public function string of_getref1label ();n_cst_ShipmentManager	lnv_ShipmentManager

RETURN lnv_ShipmentManager.of_ConvertReference ( This.of_GetRef1Type ( ) )
end function

public function string of_getref2label ();n_cst_ShipmentManager	lnv_ShipmentManager

RETURN lnv_ShipmentManager.of_ConvertReference ( This.of_GetRef2Type ( ) )
end function

public function string of_getref3label ();n_cst_ShipmentManager	lnv_ShipmentManager

RETURN lnv_ShipmentManager.of_ConvertReference ( This.of_GetRef3Type ( ) )
end function

public function date of_getinvoicedate ();RETURN This.of_GetValue ( "ds_bill_date", TypeDate! )
end function

public function string of_getinvoicenumber ();RETURN This.of_GetValue ( "ds_pronum", TypeString! )
end function

public function decimal of_getnetcharges ();RETURN This.of_GetValue ( "ds_bill_charge", TypeDecimal! )
end function

public function decimal of_getgrosscharges ();//Returns:  Gross charges (the sum of freight and accessorial charges.)
//Will always return a value; will not return null.

Decimal	lc_FreightCharges, &
			lc_AccessorialCharges, &
			lc_GrossCharges


//Get freight charges, and if they're null, set to 0.

lc_FreightCharges = This.of_GetFreightCharges ( )

IF IsNull ( lc_FreightCharges ) THEN
	lc_FreightCharges = 0
END IF


//Get accessorial charges, and if they're null, set to 0.

lc_AccessorialCharges = This.of_GetAccessorialCharges ( )

IF IsNull ( lc_AccessorialCharges ) THEN
	lc_AccessorialCharges = 0
END IF


//Compute Gross charges, the sum of freight and accessorial charges.
lc_GrossCharges = lc_FreightCharges + lc_AccessorialCharges

RETURN lc_GrossCharges
end function

public function decimal of_gettotalpieces ();n_cst_beo_Item	lnva_Items[]
Integer	li_ItemCount, &
			li_Index
Decimal	lc_Pieces, &
			lc_TotalPieces

li_ItemCount = This.of_GetItemList ( lnva_Items )

FOR li_Index = 1 TO li_ItemCount

	IF lnva_Items [ li_Index ].of_IsFreight ( ) THEN

		lc_Pieces = lnva_Items [ li_Index ].of_GetQuantity ( )

		IF lc_Pieces > 0 THEN
			lc_TotalPieces += lc_Pieces
		END IF

	END IF
	
	DESTROY ( lnva_Items [ li_Index ] )

NEXT


RETURN lc_TotalPieces
end function

public function decimal of_gettotalweight ();RETURN This.of_GetValue ( "ds_total_weight", TypeLong! )
end function

public function string of_getdispatchstatus ();String	ls_DispatchStatus

Constant String	cs_LockId = "This.of_GetDispatchStatus"
This.of_LockEventList ( cs_LockId )

IF This.of_HasAllEventsConfirmed ( ) THEN
	ls_DispatchStatus = "DELIVERED"

ELSEIF This.of_HasConfirmedEvents ( ) THEN
	ls_DispatchStatus = "PICKED UP"

ELSE
	ls_DispatchStatus = "PENDING"

END IF

This.of_ReleaseEventList ( cs_LockId )

RETURN ls_DispatchStatus
end function

public function date of_getscheduleddeliverydate ();//Returns the Scheduled Delivery Date, or Null if it is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_DeliverIndex
Long		ll_Destination
Date		ld_Result

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "delivery" 
//by seeing which event represents the final destination for the shipment.

IF li_EventCount > 2 THEN

	ll_Destination = This.of_GetDestination ( )

	IF NOT IsNull ( ll_Destination ) THEN

		FOR li_Index = li_EventCount TO 1 STEP -1

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Destination THEN
				IF lnva_Events [ li_Index ].of_IsDeliverGroup ( ) THEN
					li_DeliverIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a DeliverIndex by the special criteria above, use the last event.
IF li_DeliverIndex = 0 THEN
	li_DeliverIndex = li_EventCount
END IF


//If we've got an event index, get the date, otherwise set the date to null.
IF li_DeliverIndex > 1 THEN
	ld_Result = lnva_Events [ li_DeliverIndex ].of_GetScheduledDate ( )

ELSE
	SetNull ( ld_Result )

END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT


RETURN ld_Result
end function

public function time of_getscheduleddeliverytime ();//Returns the Scheduled Delivery Time, or Null if it is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_DeliverIndex
Long		ll_Destination
Time		lt_Result

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "delivery" 
//by seeing which event represents the final destination for the shipment.

IF li_EventCount > 2 THEN

	ll_Destination = This.of_GetDestination ( )

	IF NOT IsNull ( ll_Destination ) THEN

		FOR li_Index = li_EventCount TO 1 STEP -1

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Destination THEN
				IF lnva_Events [ li_Index ].of_IsDeliverGroup ( ) THEN
					li_DeliverIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a DeliverIndex by the special criteria above, use the last event.
IF li_DeliverIndex = 0 THEN
	li_DeliverIndex = li_EventCount
END IF


//If we've got an event index, get the time, otherwise set the time to null.
IF li_DeliverIndex > 1 THEN
	lt_Result = lnva_Events [ li_DeliverIndex ].of_GetScheduledTime ( )

ELSE
	SetNull ( lt_Result )

END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT

RETURN lt_Result
end function

public function string of_getoriginlocation ();n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE )
lnv_Company.of_SetSourceId ( This.of_GetOrigin ( ) )

RETURN lnv_Company.of_GetLocation ( )
end function

public function string of_getdestinationlocation ();n_cst_beo_Company	lnv_Company

lnv_company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE )
lnv_Company.of_SetSourceId ( This.of_GetDestination ( ) )

RETURN lnv_Company.of_GetLocation ( )
end function

public function long of_getorigin ();long	ll_originId
integer	li_stop

Integer	li_Return = -1

n_cst_beo_event	lnv_event

/*
	if the shipment is in deliverymode then pass out the site company for the delivery stop
	not the shipment final origin.
	Currently (8/06/03) this is only used for seperated delivery receipts for the document selection window.
*/

if this.of_getDeliveryModePickup(li_stop) then
	if this.of_GetEvent(li_stop, lnv_event) = 1 then
		ll_originId = lnv_event.of_getsite()
	end if
else
	ll_originId = This.of_GetValue ( "ds_origin_id", TypeInteger! )	
end if

RETURN ll_originid
end function

public function long of_getdestination ();long	ll_destinationId
integer	li_stop

Integer	li_Return = -1

n_cst_beo_event	lnv_event

/*
	if the shipment is in deliverymode then pass out the site company for the delivery stop
	not the shipment final destination.
	Currently (8/06/03) this is only used for seperated delivery receipts for the document selection window.
*/

if this.of_getDeliveryModeStop(li_stop) then
	if this.of_GetEvent(li_stop, lnv_event) = 1 then
		ll_destinationId = lnv_event.of_getsite()
	end if
else
	ll_DestinationId = This.of_GetValue ( "ds_findest_id", TypeInteger! )	
end if

RETURN ll_destinationid
end function

public subroutine of_lockeventlist (readonly string as_lockid);//The EventListLock is a reference set by a calling script to indicate that once 
//the EventList is determined on a subsequent call, it should be retained for other
//other requests until the script calls of_ReleaseEventList to clear the lock.  This
//is done for performance reasons, as pulling the list can be costly.

//Calling of_LockEventList does not in itself cause the list to be pulled the first time.

//If a lock is already set, it is not overridden.
//
//IF is_EventListLock = "" THEN
//	is_EventListLock = as_LockId
//END IF

end subroutine

public subroutine of_releaseeventlist (readonly string as_lockid);//If the EventListLock currently in effect was set with the same LockId (ie, by the 
//same script or process ) as the one requesting the release, it will be released, 
//and the event list will need to be recalculated the next time it is requested.

//If the EventListLock does not match the LockId submitted, the request is ignored and
//the lock is retained (so that it can be released by the script or process that originally set it.)

//IF is_EventListLock = as_LockId THEN
//	is_EventListLock = ""
//	ib_EventListReady = FALSE
//END IF
end subroutine

public subroutine of_lockitemlist (readonly string as_lockid);//The ItemListLock is a reference set by a calling script to indicate that once 
//the ItemList is determined on a subsequent call, it should be retained for other
//other requests until the script calls of_ReleaseItemList to clear the lock.  This
//is done for performance reasons, as pulling the list can be costly.

//Calling of_LockItemList does not in itself cause the list to be pulled the first time.

//If a lock is already set, it is not overridden.

IF is_ItemListLock = "" THEN
	is_ItemListLock = as_LockId
END IF
end subroutine

public subroutine of_releaseitemlist (readonly string as_lockid);//If the ItemListLock currently in effect was set with the same LockId (ie, by the 
//same script or process ) as the one requesting the release, it will be released, 
//and the item list will need to be recalculated the next time it is requested.

//If the ItemListLock does not match the LockId submitted, the request is ignored and
//the lock is retained (so that it can be released by the script or process that originally set it.)

IF is_ItemListLock = as_LockId THEN
	is_ItemListLock = ""
	ib_ItemListReady = FALSE
END IF
end subroutine

public function decimal of_getadjustednetcharges ();//Returns the Net Charges minus any Hidden Discount for the customer

n_cst_beo_Company	lnv_Company
Long	ll_BilltoId
Decimal	lc_HiddenDiscount, &
			lc_NetCharges, &
			lc_AdjustedNetCharges

ll_BilltoId = This.of_GetBillto ( )
lnv_Company = CREATE n_cst_beo_Company 

IF NOT IsNull ( ll_BilltoId ) THEN

	lnv_Company.of_SetUseCache ( TRUE )
	
	lnv_Company.of_SetSourceId ( ll_BilltoId )

	lc_HiddenDiscount = lnv_Company.of_GetHiddenDiscount ( )

	IF lc_HiddenDiscount > 0 AND &
		lc_HiddenDiscount <= 1 THEN

		//Hidden discount value is ok

	ELSE
		lc_HiddenDiscount = 0  //Don't apply a hidden discount

	END IF

END IF

lc_NetCharges = This.of_GetNetCharges ( )

lc_AdjustedNetCharges = lc_NetCharges * ( 1 - lc_HiddenDiscount )
DESTROY ( lnv_Company )
RETURN lc_AdjustedNetCharges
end function

public function date of_getdatedelivered ();//Returns the Date (Confirmed) Delivered, or Null if is not confirmed, is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_DeliverIndex
Long		ll_Destination
Date		ld_Result

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "delivery" 
//by seeing which event represents the final destination for the shipment.

IF li_EventCount > 2 THEN

	ll_Destination = This.of_GetDestination ( )

	IF NOT IsNull ( ll_Destination ) THEN

		FOR li_Index = li_EventCount TO 1 STEP -1

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Destination THEN
				IF lnva_Events [ li_Index ].of_IsDeliverGroup ( ) THEN
					li_DeliverIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a DeliverIndex by the special criteria above, use the last event.
IF li_DeliverIndex = 0 THEN
	li_DeliverIndex = li_EventCount
END IF


//If we've got an event index, get the date, otherwise set the date to null.
IF li_DeliverIndex > 1 THEN
	ld_Result = lnva_Events [ li_DeliverIndex ].of_GetDateArrived ( TRUE /*RequireConf*/ )

ELSE
	SetNull ( ld_Result )

END IF

Int i
li_EventCount = UpperBound ( lnva_Events )
FOR i = 1 TO li_EventCount 
	DESTROY ( lnva_Events[i] )
NEXT

RETURN ld_Result
end function

public function date of_getdatepickedup ();//Returns the Date (Confirmed) PickedUp, or Null if is not confirmed, is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_PickupIndex
Long		ll_Origin
Date		ld_Result

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "pickup" 
//by seeing which event represents the origin for the shipment.


IF li_EventCount > 2 THEN

	ll_Origin = This.of_GetOrigin ( )

	IF NOT IsNull ( ll_Origin ) THEN

		FOR li_Index = 1 TO li_EventCount

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Origin THEN
				IF lnva_Events [ li_Index ].of_IsPickupGroup ( ) THEN
					li_PickupIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a PickupIndex by the special criteria above, use the first event.
IF li_PickupIndex = 0 AND li_EventCount > 0 THEN
	li_PickupIndex = 1
END IF


//If we've got an event index, get the date, otherwise set the date to null.
IF li_PickupIndex > 0 THEN
	ld_Result = lnva_Events [ li_PickupIndex ].of_GetDateArrived ( TRUE /*RequireConf*/ )

ELSE
	SetNull ( ld_Result )

END IF

Int i
li_EventCount = UpperBound ( lnva_Events )
FOR i = 1 TO li_EventCount 
	DESTROY ( lnva_Events[i] )
NEXT

RETURN ld_Result
end function

public function time of_gettimepickedup ();//Returns the Time (Confirmed) PickedUp, or Null if is not confirmed, is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_PickupIndex
Long		ll_Origin
Time		lt_Result

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "pickup" 
//by seeing which event represents the origin for the shipment.

IF li_EventCount > 2 THEN

	ll_Origin = This.of_GetOrigin ( )

	IF NOT IsNull ( ll_Origin ) THEN

		FOR li_Index = 1 TO li_EventCount

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Origin THEN
				IF lnva_Events [ li_Index ].of_IsPickupGroup ( ) THEN
					li_PickupIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a PickupIndex by the special criteria above, use the first event.
IF li_PickupIndex = 0 AND li_EventCount > 0 THEN
	li_PickupIndex = 1
END IF


//If we've got an event index, get the time, otherwise set the time to null.
IF li_PickupIndex > 0 THEN
	lt_Result = lnva_Events [ li_PickupIndex ].of_GetTimeArrived ( TRUE /*RequireConf*/ )

ELSE
	SetNull ( lt_Result )

END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT

RETURN lt_Result
end function

public function time of_gettimedelivered ();//Returns the Time (Confirmed) Delivered, or Null if is not confirmed, is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_DeliverIndex
Long		ll_Destination
Time		lt_Result

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "delivery" 
//by seeing which event represents the final destination for the shipment.

IF li_EventCount > 2 THEN

	ll_Destination = This.of_GetDestination ( )

	IF NOT IsNull ( ll_Destination ) THEN

		FOR li_Index = li_EventCount TO 1 STEP -1

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Destination THEN
				IF lnva_Events [ li_Index ].of_IsDeliverGroup ( ) THEN
					li_DeliverIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a DeliverIndex by the special criteria above, use the last event.
IF li_DeliverIndex = 0 THEN
	li_DeliverIndex = li_EventCount
END IF


//If we've got an event index, get the time, otherwise set the time to null.
IF li_DeliverIndex > 1 THEN
	lt_Result = lnva_Events [ li_DeliverIndex ].of_GetTimeArrived ( TRUE /*RequireConf*/ )

ELSE
	SetNull ( lt_Result )

END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT

RETURN lt_Result
end function

public function string of_getpod ();//Returns the POD (The "POD" value is actually the note field on the event), 
//or Null if is not confirmed, is unspecified, or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_DeliverIndex
Long		ll_Destination
String	ls_Result

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "delivery" 
//by seeing which event represents the final destination for the shipment.

IF li_EventCount > 2 THEN

	ll_Destination = This.of_GetDestination ( )

	IF NOT IsNull ( ll_Destination ) THEN

		FOR li_Index = li_EventCount TO 1 STEP -1

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Destination THEN
				IF lnva_Events [ li_Index ].of_IsDeliverGroup ( ) THEN
					li_DeliverIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a DeliverIndex by the special criteria above, use the last event.
IF li_DeliverIndex = 0 THEN
	li_DeliverIndex = li_EventCount
END IF


//If we've got an event index, get the POD (Note value), otherwise set the POD to null.
IF li_DeliverIndex > 1 THEN
	ls_Result = lnva_Events [ li_DeliverIndex ].of_GetNote ( TRUE /*RequireConf*/ )

ELSE
	SetNull ( ls_Result )

END IF

Int i
FOR i = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ i ] )
NEXT


RETURN ls_Result
end function

public function date of_getscheduledpickupdate ();//Returns the Scheduled Pickup Date, or Null if it is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_PickupIndex
Long		ll_Origin
Date		ld_Result

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "pickup" 
//by seeing which event represents the origin for the shipment.

IF li_EventCount > 2 THEN

	ll_Origin = This.of_GetOrigin ( )

	IF NOT IsNull ( ll_Origin ) THEN

		FOR li_Index = 1 TO li_EventCount

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Origin THEN
				IF lnva_Events [ li_Index ].of_IsPickupGroup ( ) THEN
					li_PickupIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a PickupIndex by the special criteria above, use the first event.
IF li_PickupIndex = 0 AND li_EventCount > 0 THEN
	li_PickupIndex = 1
END IF


//If we've got an event index, get the date, otherwise set the date to null.
IF li_PickupIndex > 0 THEN
	ld_Result = lnva_Events [ li_PickupIndex ].of_GetScheduledDate ( )

ELSE
	SetNull ( ld_Result )

END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT

RETURN ld_Result
end function

public function time of_getscheduledpickuptime ();//Returns the Scheduled Pickup Time, or Null if it is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_PickupIndex
Long		ll_Origin
Time		lt_Result

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "pickup" 
//by seeing which event represents the origin for the shipment.

IF li_EventCount > 2 THEN

	ll_Origin = This.of_GetOrigin ( )

	IF NOT IsNull ( ll_Origin ) THEN

		FOR li_Index = 1 TO li_EventCount

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Origin THEN
				IF lnva_Events [ li_Index ].of_IsPickupGroup ( ) THEN
					li_PickupIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a PickupIndex by the special criteria above, use the first event.
IF li_PickupIndex = 0 AND li_EventCount > 0 THEN
	li_PickupIndex = 1
END IF


//If we've got an event index, get the time, otherwise set the time to null.
IF li_PickupIndex > 0 THEN
	lt_Result = lnva_Events [ li_PickupIndex ].of_GetScheduledTime ( )

ELSE
	SetNull ( lt_Result )

END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT

RETURN lt_Result
end function

public function string of_getblnumbers ();n_cst_beo_Item	lnva_Items[]
Integer	li_ItemCount, &
			li_Index
String	lsa_BLNumbers[], &
			ls_BLNumbers
n_cst_String	lnv_String

li_ItemCount = This.of_GetItemList ( lnva_Items )

FOR li_Index = 1 TO li_ItemCount
	//This call automatically returns null if the item is not freight.
	lsa_BLNumbers [ li_Index ] = lnva_Items [ li_Index ].of_GetBLNum ( )
	DESTROY ( lnva_Items [ li_Index ] )
NEXT

//Concatenate the Array to a String  (the function automatically weeds out nulls)
lnv_String.of_ArrayToString ( lsa_BLNumbers, "  ", ls_BLNumbers )

RETURN ls_BLNumbers
end function

public function integer of_calculatehazmat ();//Returns : 1, -1

n_cst_beo_Item	lnva_Items[]
Long		ll_ItemCount, &
			ll_Index
Boolean	lb_HasHazmat = FALSE
Integer	li_Return = 1

	
ll_ItemCount = This.of_GetItemList ( lnva_Items )

IF ll_ItemCount >= 0 THEN

	FOR ll_Index = 1 TO ll_ItemCount

		IF lnva_Items [ ll_Index ].of_IsHazmat ( ) THEN
			lb_HasHazmat = TRUE
			EXIT
		END IF

	NEXT

ELSE
	li_Return = -1

END IF
	

IF li_Return = 1 THEN

	IF lb_HasHazmat THEN
		This.of_SetAny ( "ds_hazmat", "T" )
	ELSE
		This.of_SetAny ( "ds_hazmat", "F" )
	END IF

END IF

FOR ll_Index = 1 TO ll_ItemCount
	DESTROY ( lnva_Items[ ll_Index ] )
NEXT

RETURN li_Return
end function

public function integer of_setdiscountpercent (decimal ac_discountpercent);Int	li_ReturnValue = -1

IF THIS.of_SetAny ( "ds_disc_pct" ,ac_DiscountPercent) = 1 THEN
	IF	THIS.of_Calculate ( ) = 1 THEN
		li_ReturnValue = 1
	END IF
END IF

// we are not going to recalc when they enter the discount. this will
// give them a way to regulate if the discount applies to the FSC
//IF li_ReturnValue = 1 THEN
//	THIS.of_Recalcexistingsurcharges( )
//END IF

RETURN li_ReturnValue
end function

public function string of_getrequiredequipment ();RETURN This.of_GetValue ( "ds_equip_req", TypeString! )
end function

public function string of_getprepaidcollect ();RETURN This.of_GetValue ( "ds_ppcol", TypeString! )
end function

public function int of_gettotalmiles ();RETURN This.of_GetValue ( "ds_total_miles", TypeInteger! )
end function

public function string of_gethazmat ();RETURN This.of_GetValue ( "ds_hazmat", TypeString! )
end function

public function string of_getexpedite ();RETURN This.of_GetValue ( "ds_expedite", TypeString! )
end function

public function string of_getbillingcomments ();RETURN This.of_GetValue ( "ds_bill_comment", TypeString! )
end function

public function string of_getshipmentcomments ();RETURN This.of_GetValue ( "ds_ship_comment", TypeString! )
end function

public function string of_getmodlog ();RETURN This.of_GetValue ( "ds_mod_log", TypeString! )
end function

public function integer of_getorigin (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache);//Return : 1 = Success (Valid Origin Passed Out), 0 = No Origin (Null OriginId), -1 = Error

Long		ll_OriginId
Integer	li_Return = -1

ll_OriginId = This.of_GetOrigin ( )

IF IsNull ( ll_OriginId ) THEN

	li_Return = 0

ELSE
	
	DESTROY anv_company
	
	anv_company = CREATE n_cst_beo_company
	
	IF ab_CheckCache THEN
		gnv_cst_Companies.of_Cache ( ll_OriginId, FALSE )
	END IF

	anv_Company.of_SetUseCache ( TRUE )
	
	IF anv_Company.of_SetSourceId ( ll_OriginId ) = 1 THEN
		IF anv_Company.of_HasSource ( ) THEN
			li_Return = 1
		END IF
	END IF

END IF

RETURN li_Return
end function

public function integer of_getdestination (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache);//Return : 1 = Success (Valid Destination Passed Out), 0 = No Destination (Null DestinationId), -1 = Error

//We're not calling the overloaded version in order to avoid the performance
//hit of passing the AutoInstantiated variable again.

Long		ll_DestinationId
Integer	li_Return = -1

ll_DestinationId = This.of_GetDestination ( )

IF IsNull ( ll_DestinationId ) THEN

	li_Return = 0

ELSE
	
	DESTROY anv_company
	
	anv_company = CREATE n_cst_beo_company
	
	IF ab_CheckCache THEN
		gnv_cst_Companies.of_Cache ( ll_DestinationId, FALSE )
	END IF

	anv_Company.of_SetUseCache ( TRUE )
	
	IF anv_Company.of_SetSourceId ( ll_DestinationId ) = 1 THEN
		IF anv_Company.of_HasSource ( ) THEN
			li_Return = 1
		END IF
	END IF

END IF

RETURN li_Return
end function

public function integer of_getbilltocompany (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache);//Return : 1 = Success (Valid Billto Passed Out), 0 = No Billto (Null BilltoId), -1 = Error

//We're not calling the overloaded version in order to avoid the performance
//hit of passing the AutoInstantiated variable again.

Long		ll_BilltoId
Integer	li_Return = -1

ll_BilltoId = This.of_GetBillto ( )

IF IsNull ( ll_BilltoId ) THEN

	li_Return = 0

ELSE

	DESTROY anv_company
	
	anv_company = CREATE n_cst_beo_company
	
	IF ab_CheckCache THEN
		gnv_cst_Companies.of_Cache ( ll_BilltoId, FALSE )
	END IF

	anv_Company.of_SetUseCache ( TRUE )
	
	IF anv_Company.of_SetSourceId ( ll_BilltoId ) = 1 THEN
		IF anv_Company.of_HasSource ( ) THEN
			li_Return = 1
		END IF
	END IF

END IF

RETURN li_Return
end function

public function string of_getshipmenttype ();//Returns the Name of the ShipType assigned to the shipment, if any.  Null if not.

String	ls_Name
n_cst_Ship_Type	lnv_ShipTypeManager

CHOOSE CASE lnv_ShipTypeManager.of_GetName ( This.of_GetType ( ), ls_Name )

CASE 1
	//Got the name successfully.  Use it.

CASE ELSE
	SetNull ( ls_Name )

END CHOOSE
	

RETURN ls_Name
end function

public function long of_getparentid ();RETURN This.of_GetValue ( gc_Dispatch.cs_Column_ParentId, TypeLong! )
end function

public function boolean of_isroutable ();Boolean	lb_Result

IF This.of_GetCategory ( ) = cs_Category_Dispatch THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function long of_getlegeventlist (integer ai_leg, ref n_cst_beo_event anva_legeventlist[]);//Returns : The number of events in the leg, or null if the list cannot be determined.
//Will return 0 and no events if the leg requested does not exist.

//**NOTE:  Because of the way of_GetEventList gives the shipment event list, events must
//be in the primary buffer of the cache sorted in shipment sequence order in order for 
//this function to work properly.  It should not be called if this will not be the case.**

n_cst_beo_Event	lnva_EventList[]
Long	ll_EventCount, &
		ll_LegEventCount, &
		ll_Index
Integer	li_CurrentLeg
Boolean	lb_DeliverySegment

ll_EventCount = This.of_GetEventList ( lnva_EventList )

Int	i
Int	li_Count
li_Count = UpperBound ( anva_LegEventList ) 
FOR i = 1 TO li_Count 
	DESTROY ( anva_LegEventList [i] )
NEXT


IF ll_EventCount >= 0 THEN

	lb_DeliverySegment = FALSE
	li_CurrentLeg = 1

	FOR ll_Index = 1 TO ll_EventCount

		IF li_CurrentLeg > ai_Leg THEN
			EXIT
		END IF

		IF lnva_EventList [ ll_Index ].of_IsPickupGroup ( ) THEN

			IF lb_DeliverySegment THEN
				//We've hit the first event of the next leg
				li_CurrentLeg ++
				lb_DeliverySegment = FALSE
			END IF

		ELSEIF lnva_EventList [ ll_Index ].of_IsDeliverGroup ( ) THEN

			//Flag that we're in the delivery segment (we may have been already)
			lb_DeliverySegment = TRUE

		ELSE

			//Other event type -- no action needed.

		END IF

		//If the leg we're currently in is the requested leg, add the current event
		//to the leg event list, and increment the leg event counter.

		IF li_CurrentLeg = ai_Leg THEN

			ll_LegEventCount ++
			anva_LegEventList [ ll_LegEventCount ] = lnva_EventList [ ll_Index ]

		END IF

	NEXT

ELSE
	SetNull ( ll_LegEventCount )
END IF

RETURN ll_LegEventCount
end function

public function integer of_setexcludecrossdock (boolean ab_switch);Integer	li_Return

IF ib_ExcludeCrossDock = ab_Switch THEN
	li_Return = 0
ELSEIF IsNull ( ab_Switch ) THEN
	li_Return = -1
ELSE
	ib_ExcludeCrossDock = ab_Switch
	//If an event list lock has been set, flag the fact that the list, if it's already
	//been determined, is now invalid.
//	ib_EventListReady = FALSE
	li_Return = 1
END IF

RETURN li_Return
end function

public function boolean of_getexcludecrossdock ();RETURN ib_ExcludeCrossDock
end function

public function string of_getstatusdisplayvalue (string as_datavalue);//Returns : The display value if determined, Null if cannot be determined.
//(Forwards the request to the ShipmentManager.)

n_cst_ShipmentManager	lnv_ShipmentManager

RETURN lnv_ShipmentManager.of_GetStatusDisplayValue ( as_DataValue )
end function

public function decimal of_getaccessorialchargesbydescription (string as_description);//Return the total charges for any accessorial line items the start of whose description
//matches the value provided in as_Description.  The comparison is not case sensitive.

n_cst_beo_Item	lnva_Items[]
Integer	li_ItemCount, &
			li_Index, &
			li_Len

Decimal	lc_Charges, &
			lc_Result

as_Description = Upper ( as_Description )
li_Len = Len ( as_Description )
li_ItemCount = This.of_GetItemList ( lnva_Items )

FOR li_Index = 1 TO li_ItemCount
	IF lnva_Items [ li_Index ].of_IsAccessorial ( ) THEN
		IF Upper ( Left ( lnva_Items [ li_Index ].of_GetDescription ( ), li_Len ) ) = as_Description THEN
			lc_Charges = lnva_Items [ li_Index ].of_GetAccessorialCharges ( )
			IF NOT IsNull ( lc_Charges ) THEN
				lc_Result += lc_Charges
			END IF
		END IF
	END IF
	DESTROY ( lnva_Items [ li_Index ] )
NEXT


RETURN lc_Result
end function

public function integer of_setcategory (string as_category);//Does not do any user-privilege or data validation.  Is only intended to be called by a
//fully authorized script.

//Returns : 1, -1 for now.  Other set returns not currently implemented.

Integer	li_Return = -1

IF This.of_SetAny ( "ds_dorb", as_Category ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return
end function

public function decimal of_getsettlementpay ();Boolean	lb_Finished
Long		lla_Ids[]
DataStore	lds_Total

Decimal {2}	lc_Result  //=0

//IF lb_Finished = FALSE THEN
//
//	IF NOT IsNull ( ic_Payables ) THEN
//		lc_Result = ic_Payables
//		lb_Finished = TRUE
//	END IF
//
//END IF


IF lb_Finished = FALSE THEN

	lla_Ids [ 1 ] = This.of_GetId ( )

	lds_Total = CREATE DataStore
	lds_Total.DataObject = "d_PaySplitsTotal_Shipments"
	lds_Total.SetTransObject ( SQLCA )

	CHOOSE CASE lds_Total.Retrieve ( lla_Ids )

	CASE 1  //Successfully retrieved one total row.
		lc_Result = lds_Total.Object.SplitsTotal [ 1 ]
		lb_Finished = TRUE

	CASE ELSE  //Error
		SetNull ( lc_Result )
		lb_Finished = TRUE

	END CHOOSE

	DESTROY lds_Total

END IF

//IF NOT IsNull ( lc_Result ) THEN
//	ic_Payables = lc_Result
//END IF

RETURN lc_Result
end function

public function boolean of_hasequipmentreferenced ();Boolean	lb_Return


CHOOSE CASE THIS.of_getRef1Type ( )
		
	CASE 20, 23, 26 , 28  //Container #, Trailer #, Railbox # , CHASSIS
		lb_Return = TRUE
END CHOOSE


RETURN lb_Return
end function

public function integer of_getreferencedequipment (ref datastore ads_equiplist);// 	RETURNS	-1 on error or rowcount of find

String	ls_EquipRef
Int		li_Return
DataStore	lds_Find

IF THIS.of_HasEquipmentReferenced ( ) THEN
	ls_EquipRef = THIS.of_GetRef1Text ( )
	n_cst_EquipmentManager	lnv_EquipmentManager
	
	lnv_EquipmentManager.of_Retrieve ( lds_Find ,  " Where eq_status = 'K' AND eq_Ref = '"+ ls_EquipRef +"'" )
	IF isValid ( lds_Find ) THEN
		li_Return = lds_Find.RowCount ( )
	ELSE
		li_Return = -1
	END IF
	
END IF

RETURN li_Return
	
end function

public function string of_getmovetype ();RETURN This.of_GetValue ( "movetype", TypeString! )
end function

public function string of_getoriginport ();RETURN This.of_GetValue ( "originport", TypeString! )
end function

public function string of_getdestinationport ();RETURN This.of_GetValue ( "destinationport", TypeString! )
end function

public function string of_getline ();RETURN This.of_GetValue ( "line", TypeString! )
end function

public function string of_getvessel ();RETURN This.of_GetValue ( "vessel", TypeString! )
end function

public function string of_getvoyage ();RETURN This.of_GetValue ( "voyage", TypeString! )
end function

public function string of_getbooking ();RETURN This.of_GetValue ( "booking", TypeString! )
end function

public function string of_getseal ();RETURN This.of_GetValue ( "seal", TypeString! )
end function

public function string of_getmasterbl ();RETURN This.of_GetValue ( "masterbl", TypeString! )
end function

public function string of_gethousebl ();RETURN This.of_GetValue ( "housebl", TypeString! )
end function

public function string of_getforwarderref ();RETURN This.of_GetValue ( "forwarderref", TypeString! )
end function

public function string of_getagentref ();RETURN This.of_GetValue ( "agentref", TypeString! )
end function

public function date of_getcutoffdate ();RETURN This.of_GetValue ( "cutoffdate", TypeDate! )
end function

public function date of_getarrivaldate ();RETURN This.of_GetValue ( "arrivaldate", TypeDate! )
end function

public function date of_getlastfreedate ();RETURN This.of_GetValue ( "lastfreedate", TypeDate! )
end function

public function time of_getcutofftime ();RETURN This.of_GetValue ( "cutofftime", TypeTime! )
end function

public function time of_getarrivaltime ();RETURN This.of_GetValue ( "arrivaltime", TypeTime! )
end function

public function time of_getlastfreetime ();RETURN This.of_GetValue ( "lastfreetime", TypeTime! )
end function

public function long of_geteventids (ref long ala_ids[]);//Returns : >= 0 (The number of events, which will be the number of ids in the array), 
//-1 = Error

Long		lla_Ids[], &
			ll_Count, &
			ll_Index
n_cst_beo_Event	lnva_Events[]

Long		ll_Return = 0

ll_Count = This.of_GetEventList ( lnva_Events )

CHOOSE CASE ll_Count

CASE IS >= 0

	FOR ll_Index = 1 TO ll_Count

		lla_Ids [ ll_Index ] = lnva_Events [ ll_Index ].of_GetId ( )

	NEXT

CASE ELSE

	//Error, or unexpected return.

	ll_Return = -1

END CHOOSE


//Set the reference argument (even if we were unsuccessful, to clear it.)
ala_Ids = lla_Ids

FOR ll_Index = 1 TO ll_Count 
	DESTROY ( lnva_Events[ ll_Index ] )
NEXT


RETURN ll_Return
end function

public function integer of_changestatus (string as_status, n_cst_bso_dispatch anv_dispatch);String	ls_MessageHeader, &
			ls_Message, &
			ls_CurrentStatus, &
			ls_CurrentStatusDisplay, &
			ls_StatusDisplay
Boolean	lb_DeactivateEquipment
//Boolean  lb_AddFuelSurcharge

n_Cst_beo_Company			lnv_Company
n_cst_Privileges			lnv_Privileges
n_cst_ShipmentManager	lnv_ShipmentManager
n_cst_Settings				lnv_Settings

ls_MessageHeader = "Change Shipment Status"
ls_CurrentStatus = of_GetStatus ( )
ls_CurrentStatusDisplay = lnv_ShipmentManager.of_GetStatusDisplayValue ( ls_CurrentStatus )
ls_StatusDisplay = lnv_ShipmentManager.of_GetStatusDisplayValue ( as_Status )


THIS.of_SetContext ( anv_dispatch )

// Verify that a change is actually being requested

IF as_Status = ls_CurrentStatus THEN
	RETURN 0
END IF



// Cannot manually set status to gc_Dispatch.cs_ShipmentStatus_Billed, offered or Declined. Verify that's not the request.
CHOOSE CASE as_Status
	CASE  gc_Dispatch.cs_ShipmentStatus_Billed , &
			gc_Dispatch.cs_ShipmentStatus_Offered , &
			gc_Dispatch.cs_ShipmentStatus_Declined 

	RETURN 0
	
END CHOOSE


// don't allow users to change the status from Offered or Declined
IF ls_CurrentStatus = gc_Dispatch.cs_ShipmentStatus_Offered THEN
	MessageBox ( ls_MessageHeader , "You must accept or decline an offered shipment from the EDI shipment review window." )
	RETURN 0
	
END IF

IF ls_CurrentStatus = gc_Dispatch.cs_ShipmentStatus_Declined THEN
	MessageBox( ls_MessageHeader , "You cannot change the status of a declined shipment." )
	RETURN 0
END IF

//Verify that the user can edit based on current status, etc.

IF of_AllowEditBill ( ) = FALSE THEN
	of_DisplayRestrictMessage ( ls_MessageHeader )
	RETURN -2
END IF


//Verify that the user can set the specific status requested

CHOOSE CASE as_Status

CASE gc_Dispatch.cs_ShipmentStatus_Authorized, gc_Dispatch.cs_ShipmentStatus_AuditRequired

	IF lnv_Privileges.of_Shipment_SetStatusRestricted ( ) = FALSE THEN
		of_DisplayRestrictMessage ( ls_MessageHeader )
		RETURN -2
	END IF

CASE gc_Dispatch.cs_ShipmentStatus_Audited, &
	gc_Dispatch.cs_ShipmentStatus_Quoted, gc_Dispatch.cs_ShipmentStatus_Template
	//I'm including Quoted and Template in this category, because, in an approval sense, they're "audited",
	//so there should be more restriction than on someone setting open to authorized.

	IF lnv_Privileges.of_Shipment_SetStatusAudited ( ) = FALSE THEN
		of_DisplayRestrictMessage ( ls_MessageHeader )
		RETURN -2
	END IF

CASE gc_Dispatch.cs_ShipmentStatus_Cancelled

	IF lnv_Privileges.of_Shipment_SetStatusCancelled ( ) = FALSE THEN
		of_DisplayRestrictMessage ( ls_MessageHeader )
		RETURN -2
	END IF

END CHOOSE


//If status change involves changing away from template or quote, or to template or quote from a restricted
//status, verify that the user really wants to make the change.

IF ( ls_CurrentStatus = gc_Dispatch.cs_ShipmentStatus_Quoted &
	OR ls_CurrentStatus = gc_Dispatch.cs_ShipmentStatus_Template ) OR &
	&
	( ( as_Status = gc_Dispatch.cs_ShipmentStatus_Quoted &
	OR as_Status = gc_Dispatch.cs_ShipmentStatus_Template ) &
	AND NOT ls_CurrentStatus = gc_Dispatch.cs_ShipmentStatus_Open ) THEN

	IF MessageBox ( ls_MessageHeader, "OK to change status from " + ls_CurrentStatusDisplay + " to " +&
		ls_StatusDisplay + "?~nYou are modifying the " + ls_CurrentStatusDisplay + " record, "+&
		"not creating a copy.", Question!, OKCancel!, 1 ) = 2 THEN

		RETURN 0  //Cancel

	END IF

END IF

// see if we need to add the fuel surchare to this shipment
//THIS.of_GetBillToCompany ( lnv_Company , TRUE ) 
//IF IsValid ( lnv_Company ) THEN
//	CHOOSE CASE as_status 
//		CASE gc_Dispatch.cs_ShipmentStatus_Authorized , gc_Dispatch.cs_ShipmentStatus_Audited 	
//			IF lnv_Settings.of_AddFuelSurcharge ( )  THEN
//				IF lnv_Company.of_AddFuelSurcharge ( ) AND NOT THIS.of_HasFuelSurCharge ( ) THEN
//					lb_AddFuelSurcharge = TRUE 
//				END IF
//			END IF
//	END CHOOSE
//END IF
		
IF Not isValid ( THIS.of_GetContext ( ) ) THEN
	THIS.of_SetContext ( anv_dispatch )
END IF


//If the user is authorizing a non-routed shipment and there are unconfirmed events, 
//ask if they want to confirm them.

CHOOSE CASE as_Status

CASE gc_Dispatch.cs_ShipmentStatus_Authorized, gc_Dispatch.cs_ShipmentStatus_AuditRequired, &
		gc_Dispatch.cs_ShipmentStatus_Audited

	choose case this.of_GetLeasecharges( )
		case 0
			// There are no Lease Charges.  
			//	Nothing needs to be done
		case 1
			n_cst_beo_item	lnva_item[]
			if this.of_getitemsforeventtype( n_cst_constants.cs_ItemEventType_PerDiem, lnva_item) > 0 then
				//	We found lease charges, but there is a per diem item.
				//	Nothing needs to be done.
			else
				//	We found charges and there is no per diem item. 
				// We need to warn the user.
				choose case messagebox('Lease Charges', 'There are lease charges associated with this shipment (' +&
							string(this.of_Getid()) + ') but no item charge has been found. Select OK to proceed or '+ &
							'Cancel to review the shipment', question!, OKCancel!)
					case 1
						//continue
					case 2
						RETURN 0
				end choose			
			end if
		case else
			
	end choose
	
	IF This.of_IsNonRouted ( ) THEN

		IF This.of_HasAllEventsConfirmed ( ) = FALSE THEN

			CHOOSE CASE MessageBox ( ls_MessageHeader, "Confirm all events as completed?", &
				Question!, YesNoCancel! )

			CASE 1  //Yes

				//Attempt to confirm all the events.  NOTE : of_ConfirmAllEvents is a special 
				//function only available to non-routed, that does not go through the dispatch
				//manager.  Normally, event confirmations go through the dispatch manager to 
				//handle things like equipment origination / termination, but that's not an 
				//issue with non-routed.

				IF This.of_ConfirmAllEvents ( ) = -1 THEN
					MessageBox ( ls_MessageHeader, "Cannot confirm event completion because the "+&
						"following problems have been detected:~n~n" + This.of_GetErrorString ( ) )
				END IF
				//Allow user to get status-change error message if operation was not successful
				//and confirmation of all events is required.

			CASE 2  //No

				//Proceed with status change attempt without confirming events.

			CASE 3  //Cancel

				RETURN 0

			END CHOOSE

		END IF

	END IF

END CHOOSE

CHOOSE CASE as_Status

CASE gc_Dispatch.cs_ShipmentStatus_Authorized, &
		gc_Dispatch.cs_ShipmentStatus_Audited
		
		lnv_ShipmentManager.of_Processcrossdocksforinvoice( THIS )
		
END CHOOSE


//////////////////////////////////////////////////////////////////////////////////
//If the request is to cancel the shipment, peform special processing, most of which
//is related to equipment.

Long		ll_ShipmentId, &
			lla_DeletedEquipmentIds[], &
			ll_DeletedEquipmentCount, &
			ll_Index
String	ls_ErrorMessage = "Could not cancel shipment.", &
			ls_EquipmentMessages, &
			ls_WarningMessage, &
			lsa_DeletedEquipmentStatus[]
n_cst_bso_Dispatch		lnv_Dispatch
n_cst_OFRError				lnva_Errors[]
n_cst_beo_Equipment2		lnv_Equipment
n_cst_Msg					lnv_DeleteResults
s_Parm						lstr_Parm

Boolean	lb_CancelRequest = FALSE
Integer	li_Return = 1   //Used as a flag only within equipment processing.

lnv_Equipment = CREATE n_cst_beo_Equipment2

IF as_Status = gc_Dispatch.cs_ShipmentStatus_Cancelled THEN
	lb_CancelRequest = TRUE
END IF


/////////////////////

IF li_Return = 1 AND lb_CancelRequest = TRUE THEN

	ls_WarningMessage = ""

	ls_WarningMessage += "Before cancelling the shipment, you should be sure that:~n~n"+&
		"All freight that may have been picked up has proper disposition.~n"+&
		"All leased equipment that may have been picked up has proper disposition.~n"+&
		"Any charges for Truck Ordered Not Used have been recorded.~n"+& 
		"Driver(s) / Consignee(s) have been notified of the cancellation.~n"+&
		"All routing and/or shipment pay has been removed if you don't want driver pay generated for this shipment."+&
		"~n~nOK to proceed with cancel?"
	
	IF MessageBox ( ls_MessageHeader, ls_WarningMessage, Exclamation!, OkCancel!, 2 ) = 1 THEN
		//OK -- proceed.
	ELSE
		li_Return = 0
	END IF

END IF

/////////////////////

//Get a handle to the DispatchManager.

IF li_Return = 1 AND lb_CancelRequest = TRUE THEN

	lnv_Dispatch = anv_Dispatch
	
	IF NOT IsValid ( lnv_Dispatch ) THEN
	
		ls_ErrorMessage += "~n(Could not resolve dispatch object.)"
		li_Return = -1
	
	END IF

END IF

/////////////////////


IF li_Return = 1 AND lb_CancelRequest = TRUE THEN

	ll_ShipmentId = This.of_GetId ( )

	lnv_Dispatch.ClearOFRErrors ( )

	CHOOSE CASE lnv_Dispatch.of_DeleteEquipmentForShipment ( ll_ShipmentId, lnv_DeleteResults )

	CASE 1
		//Successfully deleted all equipment for shipment.

	CASE -1
		//Did not successfully delete all equipment for shipment.

		IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN

			ls_EquipmentMessages = lnva_Errors [ 1 ].GetErrorMessage ( )

		END IF

		IF Len ( ls_EquipmentMessages ) > 0 THEN
			//OK
		ELSE
			ls_EquipmentMessages = "Unspecified error attempting to delete equipment."
		END IF

	CASE ELSE

		//Unexpected return value.
		ls_EquipmentMessages = "Unexpected return error attempting to delete equipment."

	END CHOOSE


	IF Len ( ls_EquipmentMessages ) > 0 THEN

		IF MessageBox ( ls_MessageHeader, "The following errors were encountered while attempting "+&
			"to delete equipment:~n~n" + ls_EquipmentMessages + "Do you want to cancel the shipment anyway?" +&
			"  (If you choose YES and cancel the shipment, equipment that could not be deleted will remain "+&
			"linked to the shipment, and will remain in the system with its current status.)", &
			Question!, YesNo!, 2 ) = 2 THEN

			IF lnv_DeleteResults.of_Get_Parm ( "DeletedIds", lstr_Parm ) > 0 THEN
				lla_DeletedEquipmentIds = lstr_Parm.ia_Value
				ll_DeletedEquipmentCount = UpperBound ( lla_DeletedEquipmentIds )
			END IF

			IF lnv_DeleteResults.of_Get_Parm ( "DeletedStatuses", lstr_Parm ) > 0 THEN
				lsa_DeletedEquipmentStatus = lstr_Parm.ia_Value
			END IF


			lnv_Equipment.of_SetSource ( lnv_Dispatch.of_GetEquipmentCache ( ) )

			//Undo the deletions by restoring the previous status.

			FOR ll_Index = 1 TO ll_DeletedEquipmentCount

				lnv_Equipment.of_SetSourceId ( lla_DeletedEquipmentIds [ ll_Index ] )
				lnv_Equipment.of_SetStatus ( lsa_DeletedEquipmentStatus [ ll_Index ] )

			NEXT

			//Flag that we cancelled
			li_Return = 0

		END IF

	END IF

END IF

DESTROY ( lnv_Equipment )

IF lb_CancelRequest = TRUE THEN

	IF li_Return = 0 THEN
	
		RETURN 0
	
	ELSEIF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
	
		messagebox(ls_MessageHeader, ls_ErrorMessage, exclamation!)
		RETURN -1
	
	END IF

END IF

//End Special Cancel Processing
//////////////////////////////////////////////////////////////////////////////////

/////////////// BEGIN KLUGE FOR DAYBREAK
//n_cst_LicenseManager	lnv_licensemanager 
//String	ls_TempErrSting
//IF  lnv_LicenseManager.of_GetLicensedCompany ( ) = "DAYBREAK EXPRESS INCORPORATED" THEN
//	IF THIS.of_GetBillto( ) = 8079 and ( as_status =  gc_Dispatch.cs_ShipmentStatus_Authorized OR as_status =  gc_Dispatch.cs_ShipmentStatus_Audited ) THEN
//		li_Return = THIS.of_klugevalidation( ls_TempErrSting )
//		IF li_Return = -1 THEN
//			MessageBox ( "Change Status Error" , ls_tempErrSting + "Request Cancelled" )
//			RETURN -2			
//		END IF
//		IF li_Return = 0 THEN
//			MessageBox ( "Change Status Warning" , "**Warning~r~n" + ls_tempErrSting  )
//		END IF
//	END IF
//END IF
//////////////// TEMPORY KLUGE FOR DAYBREAK END






//Verify that the status requested is valid, given the info in the shipment

CHOOSE CASE of_ValidateStatus ( as_Status, ls_Message )

CASE 1, -3  //Success, or optional omissions
	

//	IF lb_AddFuelSurcharge THEN
//		THIS.of_AddItem ( "FUELSURCHARGE!" , anv_dispatch )
//	END IF
	
	THIS.of_ProcessStatusNotifications ( as_status , anv_dispatch )	
	of_SetStatus ( as_Status )
	RETURN 1

CASE -1  //Error
	ls_Message += "~nRequest cancelled."
	Messagebox ( ls_MessageHeader, ls_Message, Exclamation! )
	RETURN -1

CASE -2  //Requirements not met

	ls_Message = "Cannot approve status change because the following problems have "+&
		"been detected:~n~n" + ls_Message + "~nRequest Cancelled."
	Messagebox ( ls_MessageHeader, ls_Message, Exclamation! )
	RETURN -2

CASE ELSE  //Unexpected return value
	ls_Message = "Error validating shipment status.~n~nRequest cancelled."
	Messagebox ( ls_MessageHeader, ls_Message, Exclamation! )
	RETURN -1

END CHOOSE
end function

public function integer of_changestatus (n_cst_bso_dispatch anv_dispatch);String	lsa_ParmLabels[]
Any		laa_ParmValues[]
String	ls_StatusRequest, &
			ls_Current, &
			ls_CodeTable, &
			lsa_Status[], &
			ls_ValuePair, &
			ls_DisplayValue
Integer	li_Count, &
			li_Index
n_cst_ShipmentManager	lnv_ShipmentManager
n_cst_String				lnv_String

Integer	li_Return = 0


//Get the status code table string, and parse it out into value pairs
ls_CodeTable = lnv_ShipmentManager.of_GetStatusCodeTable ( )
li_Count = lnv_String.of_ParseToArray ( ls_CodeTable, "/", lsa_Status )

IF Not isValid ( THIS.of_GetContext ( ) ) THEN
	THIS.of_SetContext ( anv_dispatch )
END IF
//Loop through the value pair array, extract the display value from each pair, 
//and add it to the selection list.

FOR li_Index = 1 TO li_Count

	ls_ValuePair = lsa_Status [ li_Index ]
	//The value pairs have the format DISPLAY~tDATA
	ls_DisplayValue = Left ( ls_ValuePair, Pos ( ls_ValuePair, "~t" ) - 1 )

	lsa_ParmLabels [ li_Index ] = "ADD_ITEM"
	laa_ParmValues [ li_Index ] = ls_DisplayValue

NEXT


//Add an entry to the parms to Check the menu item corresponding to the current status.

ls_Current = lnv_ShipmentManager.of_GetStatusDisplayValue ( This.of_GetStatus ( ) )

IF Len ( ls_Current ) > 0 THEN
	li_Index ++
	lsa_ParmLabels [ li_Index ] = "CHECK"
	laa_ParmValues [ li_Index ] = ls_Current
END IF


//Display the popup
ls_StatusRequest = f_Pop_Standard ( lsa_ParmLabels, laa_ParmValues )


//If the user made a choice, translate the value, which is a Display Value, to a data value
IF Len ( ls_StatusRequest ) > 0 THEN
	ls_StatusRequest = lnv_ShipmentManager.of_GetStatusDataValue ( ls_StatusRequest )
END IF


//If we now have a data value, attempt to change to that status.
IF Len ( ls_StatusRequest ) > 0 THEN
	li_Return = This.of_ChangeStatus ( ls_StatusRequest, anv_Dispatch )
END IF


RETURN li_Return
end function

public function integer of_updateitemindicators ();Long	ll_FirstPUID
Long	ll_FirstDELID
//Long	ll_EventCount
Long	ll_ItemCount
Long 	i

n_cst_Beo_Item		lnva_Items[]
//n_cst_Beo_Event	lnva_EventList[]

//THIS.of_GetItemList ( lnva_Items )
//THIS.of_GetEventList ( lnva_EventList )

ll_ItemCount = UpperBound ( lnva_Items )

// try to get the firstPUID And First DELID
ll_FirstPUID = THIS.of_GetFirstPUID ( )
IF ll_FirstPUID > 0 THEN
	ll_FirstDELID = THIS.of_GetFirstDELID ( )
	IF ll_FirstDELID < 1 THEN
		SetNull ( ll_FirstDELID )
	END IF
ELSE
	SetNull ( ll_FirstPUID )
	SetNull ( ll_FirstDELID )
END IF





RETURN -1





end function

public function long of_getfirstpuid ();n_cst_beo_Event	lnva_EventList[]
Long	ll_EventCount
Long	i
Long	ll_ReturnID = -1
String	ls_EventType


THIS.of_GetEventList ( lnva_EventList )
ll_EventCount = UpperBound ( lnva_EventList )


FOR i = 1 TO ll_EventCount
	ls_EventType = lnva_EventList[i].of_Gettype ( )
	IF pos('PHM', ls_EventType ) > 0 THEN  // found the first one
		ll_ReturnID = lnva_EventList[i].of_GetID ( )
		EXIT
	END IF
	
NEXT

FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_EventList[ i ] )
NEXT


RETURN ll_ReturnID
end function

public function long of_getfirstdelid ();n_cst_beo_Event	lnva_EventList[]
Long	ll_EventCount
Long	i
Long	ll_ReturnID = -1
String	ls_EventType


THIS.of_GetEventList ( lnva_EventList )
ll_EventCount = UpperBound ( lnva_EventList )


FOR i = 1 TO ll_EventCount
	ls_EventType = lnva_EventList[i].of_Gettype ( )
	IF pos('DRN', ls_EventType ) > 0 THEN  // found the first one
		ll_ReturnID = lnva_EventList[i].of_GetID ( )
		EXIT
	END IF
	
NEXT

FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_EventList[ i ] )
NEXT


RETURN ll_ReturnID
end function

public function integer of_getnextdeliverevent (integer ai_startindex);//Returns the index of the event found 

n_cst_beo_Event	lnva_EventList[]
Long	ll_EventCount
Long	i
Long	ll_ReturnID = -1
String	ls_EventType
n_cst_AnyArraySrv	lnv_Array

THIS.of_GetEventList ( lnva_EventList )
ll_EventCount = UpperBound ( lnva_EventList )

FOR i = ai_StartIndex  TO ll_EventCount
	ls_EventType = lnva_EventList[i].of_Gettype ( )
	IF pos('DRN', ls_EventType ) > 0 THEN  // 
		ll_ReturnID = i
		EXIT
	END IF
NEXT

lnv_Array.of_Destroy ( lnva_EventList )

RETURN ll_ReturnID
end function

public function integer of_addevent (string as_type, integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatchmanager, ref long al_id);Long	ll_Site 
ll_Site = 0

RETURN THIS.of_AddEvent ( as_type , ai_insertionpoint , anv_dispatchmanager , al_id , ll_Site )


//// this method will add an event or events of the specified type and reoreder the sequence
//// numbers according to the insertion point.
//
//Long	lla_NewEventIDs[]
//Long	ll_EventCount
//Long	ll_ShipID
//Int	i
//Int	li_ResequenceRtn
//Long	ll_InsertionPoint
//Int	li_Return = 1
//Long	ll_SetRtn
//
//PowerObject	lpo_Events
//n_cst_beo_Event	lnv_CurrentEvent
//n_cst_beo_event	lnva_EventList[]
//
//ll_ShipID = THIS.of_GetID ( ) 
//
//ll_InsertionPoint	= ai_insertionPoint
//
//anv_dispatchmanager.of_NewEvents ( {as_type} , lla_NewEventIDs )
//ll_EventCount = UpperBound( lla_NewEventIDs )
//
//IF ll_EventCount = 1 THEN
//
//	lpo_Events = THIS.of_GetEventSource ( )
//	THIS.of_GetEventList ( lnva_EventList )
//	
//	al_id = lla_NewEventIDs [ 1 ]
//	ll_SetRtn = lnv_CurrentEvent.of_SetSource ( lpo_Events )
//	ll_SetRtn =	lnv_CurrentEvent.of_SetSourceID ( lla_NewEventIDs [ 1 ] )	
//	lnv_CurrentEvent.of_SetAllowFilterSet ( TRUE )
//	
//	ll_SetRtn = lnv_CurrentEvent.of_SetShipSeq ( ll_InsertionPoint )
//	ll_SetRtn = lnv_CurrentEvent.of_SetShipment ( ll_ShipID )
//	
//	
//	li_ResequenceRtn = THIS.of_ResequenceEvents ( lnv_CurrentEvent , lnva_EventList )
//	
//	IF li_ResequenceRtn <> 1 THEN
//		li_Return = -1
//	END IF
//
//END IF
//
//return li_Return
end function

public function integer of_addevents (string asa_types[], integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatchmanager, ref long ala_newids[]);Long	lla_NewIds[]
Long	ll_NewID
Int	i
Int	li_EventCount
Int	li_InsertionPoint


li_InsertionPoint = ai_InsertionPoint
li_EventCount = UpperBound( asa_Types )

FOR i = 1 TO li_EventCount
	
	THIS.of_AddEvent ( asa_Types[i] , li_InsertionPoint , anv_DispatchManager , ll_NewID )
	
	lla_NewIds [ i ] = ll_NewID
	li_InsertionPoint ++
	
NEXT

ala_NewIds = lla_NewIds

Return 1





end function

private function integer of_resequenceevents (n_cst_beo_event anv_newevent, ref n_cst_beo_event anva_previouseventlist[]);Int	i
Long	ll_EventCount
Long	ll_ItemCount
Int	li_PuEvent
Int	li_DelEvent
Int	li_InsertionPoint
Int	li_Rtn = 1
Boolean	lb_Found 
Int	li_NextDeliverPosition
String	ls_NewEventType

n_cst_beo_Event	lnva_EventList[]
n_cst_beo_Item		lnva_ItemList[]
n_cst_beo_Item		lnv_CurrentItem

IF Not isValid ( anv_NewEvent ) THEN
	RETURN -1
END IF

li_InsertionPoint = anv_NewEvent.of_GetshipSeq ( )
ls_NewEventType = anv_NewEvent.of_GetType ( )

lnva_EventList = anva_PreviousEventList


ll_EventCount = UpperBound ( lnva_EventList )

IF li_InsertionPoint > ll_EventCount + 1 OR li_InsertionPoint < 1 THEN
	li_Rtn = -1
END IF

IF li_Rtn = 1 THEN
	
	FOR i = li_InsertionPoint   TO ll_EventCount 
		lnva_EventList [ i ].of_SetAllowFilterSet ( TRUE )
		lnva_EventList [ i ].of_SetShipSeq ( lnva_EventList [ i ].of_GetShipSeq ( ) + 1 )
	NEXT
	
END IF

// now make any changes to the item indicators
THIS.of_GetItemList ( lnva_ItemList )
ll_ItemCount = UpperBound ( lnva_ItemList )

FOR i = 1 TO ll_ItemCount
	lnv_CurrentItem = lnva_ItemList [ i ]
	li_PUEvent = lnv_CurrentItem.of_GetPickupEvent ( ) 
	li_DelEvent = lnv_CurrentItem.of_GetDeliverEvent ( )
	
	IF li_PUEvent >= li_InsertionPoint THEN
		li_PUEvent ++
		lnv_CurrentItem.of_SetPUEvent ( li_PUEvent )
	END IF
	
	IF li_DelEvent >= li_InsertionPoint THEN
		li_DelEvent ++
		lnv_CurrentItem.of_SetDELEvent ( li_DelEvent )
	END IF
	
NEXT

// now look to resolve any null deliver events
FOR i = 1 TO ll_ItemCount
	
	lnv_CurrentItem = lnva_ItemList [ i ]
	li_PUEvent = lnv_CurrentItem.of_GetPickupEvent ( ) 
	li_DelEvent = lnv_CurrentItem.of_GetDeliverEvent ( )
	
	IF li_PUEvent > 0 AND IsNull ( li_DelEvent ) THEN
		li_NextDeliverPosition = THIS.of_GetNextDeliverEvent ( li_InsertionPoint )
		IF li_NextDeliverPosition > 0 THEN
			lnv_CurrentItem.of_SetDELEvent ( li_NextDeliverPosition )
		ELSE
			// check to see if the new event is a deliver type
			IF pos('DRN', ls_NewEventType ) > 0 THEN  // it is a del type
				lnv_CurrentItem.of_SetDELEvent ( li_InsertionPoint )
			END IF
				
		END IF
	END IF
	
	DESTROY ( lnva_ItemList [ i ] )
	
NEXT


RETURN li_Rtn
end function

public function integer of_setref1text (string as_value);Int	li_Return

li_Return = This.of_SetAny ( "ds_ref1_text", as_Value ) 

//IF li_Return = 1 THEN
//	
//	//sync value 
//	choose case THIS.of_GetRef1Type ( )
//		case 15
//			THIS.of_SetMasterBl ( as_Value )
//			//this.object.masterbl[1] = trim(ls_Value)
//		case 18
//			THIS.of_SetBookingNumber( as_Value )
//		//	this.object.booking[1] = trim(ls_Value)
//		case 21
//			THIS.of_SetSeal ( as_Value )
//		//	this.object.seal[1] = trim(ls_Value)
//		case 22
//			THIS.of_SetForwarderRef ( as_Value )
//		//	this.object.forwarderref[1] = trim(ls_Value)
//	end choose
//
//END IF
RETURN  li_Return
end function

private function boolean of_doeventshaveitems (n_cst_beo_event anva_events[], n_cst_beo_item anva_items[]);/** THIS method will see if the events passed in have any of the items passed in
    associated with them
**/

Long	ll_EventCount
Long	ll_ItemCount
Long	i,j
Int	li_ShipSeq
Boolean	lb_Exit
Boolean	lb_Return

n_cst_beo_Item	lnv_CurrentItem	

ll_ItemCount = UpperBound ( anva_Items )
ll_EventCount= UpperBound ( anva_Events )

IF ll_ItemCount > 0 AND ll_EventCount > 0 THEN
	FOR i = 1 TO ll_EventCount
		li_ShipSeq = anva_Events [ i ].of_GetShipSeq ( )
		
		FOR j = 1 TO ll_ItemCount 
			IF anva_Items [ j ].of_GetPickUpEvent ( ) = li_ShipSeq OR &
				anva_Items [ j ].of_GetDeliverEvent ( ) = li_ShipSeq    THEN
				lb_Return = TRUE
				lb_Exit = TRUE
				EXIT
			END IF
		NEXT
		
		IF lb_Exit THEN
			EXIT
		END IF
		
	NEXT
END IF

RETURN lb_Return

end function

private function integer of_getevents (long ala_EventIDs[], ref n_cst_beo_event anva_Events[]);Long	ll_EventlistCount
Long	ll_EventIDCount
Long	i,j

n_cst_beo_Event	lnva_EventList[]
n_cst_beo_Event	lnva_ShrinkedEventList[]
n_cst_beo_Event	lnv_CurrentEvent

THIS.of_GetEventList ( lnva_EventList [] )

ll_EventlistCount = UpperBound ( lnva_EventList )
ll_EventIDCount = UpperBound ( ala_EventIds )

// thin the event list down to the ones we want
For i = 1 To ll_EventIDCount
	FOR j = 1 TO ll_EventListCount
		lnv_CurrentEvent = lnva_EventList [j]

		IF ala_EventIds [ i ] = lnv_CurrentEvent.of_GetID ( ) THEN
			lnva_ShrinkedEventList [ UpperBound ( lnva_ShrinkedEventList ) + 1 ] = lnv_CurrentEvent
			EXIT
		END IF		
		
	NEXT
NEXT


anva_Events = lnva_ShrinkedEventList
RETURN UpperBound ( lnva_ShrinkedEventList )

end function

private function integer of_removeevent (long al_eventid, boolean ab_deleteitems, n_cst_bso_dispatch anv_dispatch);Long  ll_EventID
Long	ll_EventCount
Long	ll_ItemCount
Long	i,j,k
Long	ll_EventSeqNum
Long	ll_SourceRow
Long	ll_Null
Long	ll_FindRtn
Long	ll_Row
Long	ll_moveRtn
Long	ll_OldSeq
Long	ll_Rtn
Int	li_PUEvent
Int	li_NewPuEvent
Int	li_DelEvent
Int	li_NewDelEvent
String	ls_EventType
Boolean	lb_Found
Boolean	lb_HavePriorPU

long	ll_NewDelIndex	
	
Int	li_Return = 1

PowerObject		lpo_EventSource

n_cst_dws	lnv_Dws

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_Beo_Event	lnva_EventList[]
n_cst_beo_Event	lnv_CurrentEvent
n_cst_beo_Event	lnv_EventToDelete
n_cst_Beo_Item		lnva_ItemList[]
n_cst_beo_Item		lnv_CurrentItem
n_Cst_Settings		lnv_Settings

SetNull ( ll_Null )
lnv_Dispatch = anv_Dispatch
ll_EventID = al_EventID


ll_EventCount = THIS.of_GetEventList ( lnva_EventList )
ll_ItemCount = THIS.of_GetItemList ( lnva_ItemList )

FOR i = 1 To ll_EventCount
	IF lnva_EventList[ i ].of_GEtID ( ) = ll_EventID THEN
		lb_Found = TRUE
		EXIT
	END IF
NEXT

IF lb_Found THEN
	
	
	lnv_CurrentEvent = lnva_EventList [ i ]
	lnv_EventToDelete = lnva_EventList [ i ]
	lnv_CurrentEvent.of_SetAllowFilterSet ( TRUE )
	ls_EventType = lnv_CurrentEvent.of_GetType ( )
	ll_SourceRow = lnv_CurrentEvent.of_GetSourceRow ( )
	ll_EventSeqNum = lnv_CurrentEvent.of_GetShipSeq ( )
	
	// deal with the stop off item here
	CHOOSE CASE lnv_EventToDelete.of_GetType ( )			
		CASE gc_dispatch.cs_eventtype_pickup, gc_dispatch.cs_eventtype_deliver			
			IF ll_EventCount > 2 AND NOT ab_deleteitems THEN
				IF lnv_Settings.of_RemoveStopoffItem ( ) THEN
					THIS.of_RemoveStopOffItem ( )
				END IF
			END IF		
	END CHOOSE
	
	
	// shift the event shipseq. this should probably be done later in the script when we are able to 
	// evaluate the success of the operation
	FOR i = ll_EventSeqNum + 1 TO ll_EventCount
		lnv_CurrentEvent = lnva_EventList[i]
		lnv_CurrentEvent.of_SetAllowFilterSet ( TRUE )
		ll_OldSeq = lnv_CurrentEvent.of_GetShipSeq ( )
		ll_Rtn = lnv_CurrentEvent.of_SetShipSeq ( ll_OldSeq - 1 ) 
	NEXT
	
	// either delete the item or adjust its feright indicators
	FOR i = 1 TO ll_ItemCount
		
		lnv_CurrentItem = lnva_ItemList [ i ]
		lnv_CurrentItem.of_SetAllowFilterSet ( TRUE )
		li_PuEvent = lnv_CurrentItem.of_GetPickupEvent ( )
		li_DelEvent = lnv_CurrentItem.of_GetDeliverEvent ( )
		
		IF ab_deleteitems THEN
			
			IF li_PUEvent = ll_EventSeqNum OR li_DelEvent = ll_EventSeqNum THEN
				THIS.Post of_RemoveItem ( lnv_CurrentItem.of_GetID ( ) , anv_dispatch ) 				
			END IF
			
		ELSE

			IF li_PUEvent = ll_EventSeqNum  THEN
				lnv_CurrentItem.of_SetPUEvent ( ll_Null )
			ELSEIF li_PuEvent > ll_EventSeqNum THEN
				lnv_CurrentItem.of_SetPUEvent ( li_PUEvent - 1 )
			END IF
			
			
//			DelEvent is the freight indicator of the current item
							
			FOR k = 1 TO ll_EventSeqNum
				IF lnva_EventList[k].of_IsPickupGroup ( ) AND lnva_EventList[k].of_GetID ( ) <> lnv_EventToDelete.of_GetID ( ) THEN // can't have the item delived w/o a prior PU
					EXIT 
				END IF
			NEXT
			
			lb_HavePriorPU = k <= ll_EventSeqNum
			
			IF li_DelEvent < ll_EventSeqNum THEN
				// leave it alone
			ELSEIF li_DelEvent > ll_EventSeqNum AND li_DelEvent > 1 THEN 
				IF lb_HavePriorPU THEN				
					lnv_CurrentItem.of_SetDelEvent ( li_DelEvent - 1 )
				ELSE
					lnv_CurrentItem.of_SetDelEvent ( ll_Null )
				END IF
				
			ELSEIF li_DelEvent = ll_EventSeqNum  THEN // 
				
				ll_NewDelIndex = THIS.of_GetNextDeliverEvent ( li_DelEvent + 1 )
				IF ll_NewDelIndex > 0 AND lb_HavePriorPU THEN
					lnv_CurrentItem.of_SetDelEvent ( ll_NewDelIndex - 1 )
				ELSE
					lnv_CurrentItem.of_SetDelEvent ( ll_Null )
				END IF
			END IF						
		END IF
	NEXT
	
END IF

// see if we just removed the Origin or Dest
IF li_Return = 1 THEN 
	Long	ll_EventSite

	ll_EventSite = lnv_EventToDelete.of_GetSite ( )
	
	IF lnv_EventToDelete.of_IsPickUpGroup ( ) THEN
		 IF THIS.of_GetOrigin ( ) = ll_EventSite THEN
			FOR i = 1 TO ll_EventCount 
				IF lnva_EventList[i].of_GetSite ( ) = ll_EventSite AND lnva_EventList[i].of_IsPickUpGroup ( ) THEN
					IF lnva_EventList[i].of_GetID ( ) = lnv_EventToDelete.of_GetID ( ) THEN
						CONTINUE // a match on the event we are deleting obviously does not count as another
									// event with the same site
					ELSE
						// no need to clear the origin
						EXIT
					END IF
				END IF				
			NEXT
			
			IF i > ll_EventCount THEN
				THIS.of_SetOrigin ( ll_Null )
				IF lnv_Settings.of_processorfin ( ) AND NOT THIS.of_IsIntermodal ( ) THEN
					THIS.Post of_SetDefaultOrigin ( )
				END IF
			END IF
			
		END IF
	
	ELSEIF lnv_EventToDelete.of_IsDeliverGroup ( ) THEN
		IF THIS.of_GetDestination ( ) = ll_EventSite THEN
			FOR i = 1 TO ll_EventCount 
				IF lnva_EventList[i].of_GetSite ( ) = ll_EventSite AND lnva_EventList[i].of_IsDeliverGroup ( )THEN
					IF lnva_EventList[i].of_GetID ( ) = lnv_EventToDelete.of_GetID ( ) THEN
						CONTINUE // a match on the event we are deleting obviously does not count as another
									// event with the same site
					ELSE
						// no need to clear the Dest
						EXIT
					END IF
				END IF				
			NEXT
			
			IF i > ll_EventCount THEN
				THIS.of_SetFinalDestination ( ll_Null )
				IF lnv_Settings.of_processorfin ( ) AND NOT THIS.of_IsIntermodal ( ) THEN
					THIS.Post of_SetDefaultDestination ( )
				END IF
			END IF
			
		END IF
	END IF	
END IF



IF li_Return = 1 THEN
	n_ds	lds_EventCache
	n_ds	lds_ItemCache
	
	lds_EventCache = anv_dispatch.of_GetEventCache ( )
	lds_ItemCache = anv_dispatch.of_GetItemCache ( )

	dwBuffer	le_Buffer
	lnv_EventToDelete.of_GetSourceRow ( ll_Row , le_Buffer, FALSE )
	
	IF ll_Row > 0 THEN

// 	THIS will need to be dealt with later. it was causing a db error without the status being changed
		lds_EventCache.setitemstatus(ll_Row, 0, le_Buffer, notmodified!)

		ll_moveRtn = lds_EventCache.RowsMove ( ll_Row , ll_Row, le_Buffer, lds_EventCache, lds_EventCache.DeletedCount ( ) + 1 , DELETE! )
	END IF
	
END IF

IF ll_MoveRtn = 1 THEN
	
ELSE
	li_Return = -1
	MessageBox ( "Delete Event" , "An error occurred while attempting to delete the event." )
END IF

FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_EventList[ i ] )
NEXT

FOR i = 1 TO ll_ItemCount
	DESTROY ( lnva_ItemList [ i ] )
NEXT

Return li_Return
end function

public function integer of_preparesingleeventfordeletion (long al_id, n_cst_bso_dispatch anv_dispatch);//Prepare the event for deletion.  This will be different depending on whether it's
//a non-routed shipment or not.

String	ls_ErrorMessage
Int		li_Return = 1
n_cst_OFRError			lnva_Errors[]

n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_Cst_beo_Event
lnv_Event.of_SetAllowfilterset( TRUE )
lnv_Event.of_SetSource ( anv_dispatch.of_getEventCache ( ) ) 
lnv_Event.of_SetSourceid( al_id )
IF IsNull ( lnv_Event.of_GetType() ) OR lnv_Event.of_GetType ( ) = "" THEN
	lnv_Event.of_SetType ( gc_dispatch.cs_EventType_Misc ) // need a type to delete
END IF
DESTROY lnv_Event



IF THIS.of_IsNonRouted ( ) THEN

	//The shipment is non-routed. Unconfirm the requested event (if necessary.)
	anv_Dispatch.ClearOFRErrors ( )	
	CHOOSE CASE anv_Dispatch.of_UnconfirmEvents ( { al_Id }, TRUE /*Interactive*/ )
	
	CASE 1
		//OK
	CASE -1

		IF anv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
			ls_ErrorMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
		ELSE
			ls_ErrorMessage = "Unspecified error attempting to clear event confirmation."
		END IF
	
	CASE ELSE
		ls_ErrorMessage = "Unexpected return error attempting to clear event confirmation."
	END CHOOSE

ELSE

	//The shipment is not non-routed. Clear any routing that may be on the event, 
	//(which will also unconfirm it.)
	anv_Dispatch.ClearOFRErrors ( )
	CHOOSE CASE anv_Dispatch.of_Remove ( { al_Id } )
	
	CASE 1
		//OK
	
	CASE -1

		IF anv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
			ls_ErrorMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
		ELSE
			ls_ErrorMessage = "Unspecified error attempting to clear event routing."
		END IF
	
	CASE ELSE
		ls_ErrorMessage = "Unexpected return error attempting to clear event routing."
	END CHOOSE

END IF

IF Len ( ls_ErrorMessage ) > 0 THEN
	li_Return = -1
	messagebox("Delete Event", ls_ErrorMessage + "~n~nRequest cancelled.", exclamation!)
END IF

RETURN li_Return
end function

public function integer of_addsitemove (long al_siteid, integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatch, ref long ala_newids[], ref n_cst_msg anv_msg);String	ls_Event
Long		ll_ID
Long		ll_RowCount 
Int		li_Return = 1
Boolean	lb_ConvertFirst = TRUE
Boolean	lb_ConvertLast = TRUE
Boolean	lb_HaveInstructions = FALSE
S_Parm	lstr_Parm


IF anv_Msg.of_Get_Parm ( "ROWCOUNT" , lstr_Parm ) <> 0 THEN
	ll_RowCount = lstr_Parm.ia_Value
END IF

IF anv_msg.of_Get_Parm ( "SPLITFRONT" , lstr_Parm ) <> 0 THEN
	lb_HaveInstructions = TRUE
	lb_ConvertFirst = lstr_Parm.ia_Value
	
END IF

IF anv_msg.of_Get_Parm ( "SPLITBACK" , lstr_Parm ) <> 0 THEN
	lb_HaveInstructions = TRUE
	lb_ConvertLast = lstr_Parm.ia_Value
END IF

anv_Msg.of_Reset ()

IF ai_InsertionPoint = 1 OR  ( ai_InsertionPoint > ll_RowCount AND ll_RowCount <> 0 ) THEN // CHASSIS MOVE

	IF NOT lb_HaveInstructions THEN
		IF ai_InsertionPoint = 1 THEN  // standard... so check the system setting
			lb_ConvertLast = THIS.of_ConvertLastDrop ( )
			lb_ConvertFirst = TRUE
		ELSE // at the end so only convert the last drop
			lb_ConvertFirst = FALSE
			lb_ConvertLast = TRUE
		END IF
	END IF

	IF THIS.of_AllowChassisMove ( lb_ConvertFirst , lb_ConvertLast  ) THEN
		IF THIS.of_AddChassisMove ( al_SiteID ,  anv_dispatch, ala_newids, lb_ConvertFirst , lb_ConvertLast ) = 1 THEN
			ls_Event = "chassis"
		ELSE
			li_Return = -1
		END IF
			
		
	ELSE		
		MessageBox ( "Add Chassis Move" , "The existing event structure does not permit the move selection you made." )
		li_Return = -1
	END IF
			
ELSE
	THIS.of_AddYardMove ( al_siteid , ai_insertionpoint, anv_dispatch, ala_newids )
	
	ls_Event = "yard" 
		
END IF

lstr_Parm.is_Label = "EVENT"
lstr_parm.ia_Value = ls_Event
anv_Msg.of_Add_Parm ( lstr_Parm )

if lb_ConvertFirst then
	lstr_Parm.is_Label = "SPLITFRONT"
	lstr_Parm.ia_Value = TRUE
	anv_Msg.of_Add_Parm ( lstr_Parm )
end if

if lb_ConvertLast then
	lstr_Parm.is_Label = "SPLITBACK"
	lstr_Parm.ia_Value = TRUE
	anv_Msg.of_Add_Parm ( lstr_Parm )
end if


RETURN li_Return
end function

public function integer of_getforwardercompany (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache);Long		ll_Forwarder
Integer	li_Return = -1

ll_Forwarder = This.of_GetForwarder ( )

IF IsNull ( ll_Forwarder ) THEN

	li_Return = 0

ELSE

	DESTROY anv_company
	
	anv_company = CREATE n_cst_beo_Company
	
	IF ab_CheckCache THEN
		gnv_cst_Companies.of_Cache ( ll_Forwarder, FALSE )
	END IF

	anv_Company.of_SetUseCache ( TRUE )
	
	IF anv_Company.of_SetSourceId ( ll_Forwarder ) = 1 THEN
		IF anv_Company.of_HasSource ( ) THEN
			li_Return = 1
		END IF
	END IF

END IF

RETURN li_Return
end function

public function integer of_getagentcompany (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache);Long		ll_Agent
Integer	li_Return = -1

ll_Agent = This.of_GetAgent ( )

IF IsNull ( ll_Agent ) THEN

	li_Return = 0

ELSE

	DESTROY anv_company
	
	anv_company = CREATE n_cst_beo_Company
	
	IF ab_CheckCache THEN
		gnv_cst_Companies.of_Cache ( ll_Agent, FALSE )
	END IF

	anv_Company.of_SetUseCache ( TRUE )
	
	IF anv_Company.of_SetSourceId ( ll_Agent ) = 1 THEN
		IF anv_Company.of_HasSource ( ) THEN
			li_Return = 1
		END IF
	END IF

END IF

RETURN li_Return
end function

public function long of_getagent ();RETURN This.of_GetValue ( "agent", TypeLong! )
end function

public function long of_getforwarder ();RETURN This.of_GetValue ( "forwarder", TypeLong! )
end function

private function boolean of_convertfirsthook ();Any la_Value
Boolean	lb_Return 

lb_Return = TRUE

n_cst_settings	lnv_Settings
IF lnv_Settings.of_GetSetting ( 92 , la_Value ) > 0 THEN
	IF String ( la_Value ) = "NO!" THEN
		lb_Return = FALSE
	END IF
END IF

RETURN lb_Return
end function

private function boolean of_convertlastdrop ();// the system setting is "only convert first" , so a yes = dont't convert last

Any la_Value
Boolean	lb_Return 

lb_Return = TRUE

n_cst_settings	lnv_Settings
IF lnv_Settings.of_GetSetting ( 92 , la_Value ) > 0 THEN
	IF String ( la_Value ) = "YES!" THEN
		lb_Return = FALSE
	END IF
END IF

RETURN lb_Return
end function

private function integer of_addchassismove (Long al_SiteID, n_cst_Bso_Dispatch anv_Dispatch, ref long ala_NewIds[]);RETURN THIS.of_AddChassisMove ( al_SiteID,anv_Dispatch,ala_NewIds[], TRUE , TRUE )
end function

public function integer of_setref2text (string as_value);Int li_Return = -1
String	ls_SyncColum

li_Return = This.of_SetAny ( "ds_ref2_text", as_Value )


// this used to be commented by i needed to undo the comment for issue 2514
IF li_Return = 1 THEN
	CHOOSE CASE THIS.of_GetRef2type( )
			
		CASE 15
			ls_SyncColum = "masterbl"
		CASE 18 
			ls_SyncColum = "booking"
		CASE 21
			ls_syncColum = "Seal"
		CASE 22
			ls_SyncColum = "forwarderref"			
		CASE 24 
			ls_SyncColum = "pickupnumber"
			
	END CHOOSE
	
	
	IF Len ( ls_SyncColum ) > 0 THEN
		This.of_SetAny ( ls_SyncColum, as_Value )
	END IF
	
END IF

RETURN li_Return
end function

public function integer of_setref3text (string as_value);Int li_Return = -1
String	ls_SyncColum

li_Return = This.of_SetAny ( "ds_ref3_text", as_Value )


// this used to be commented by i needed to undo the comment for issue 2514
IF li_Return = 1 THEN
	CHOOSE CASE THIS.of_GetRef3type( )
			
		CASE 15
			ls_SyncColum = "masterbl"
		CASE 18 
			ls_SyncColum = "booking"
		CASE 21
			ls_syncColum = "Seal"
		CASE 22
			ls_SyncColum = "forwarderref"			
		CASE 24 
			ls_SyncColum = "pickupnumber"
			
	END CHOOSE
	
	
	IF Len ( ls_SyncColum ) > 0 THEN
		This.of_SetAny ( ls_SyncColum, as_Value )
	END IF
	
END IF

RETURN li_Return
end function

public function integer of_setshipmentcomments (string as_value);RETURN of_SetAny ( "ds_Ship_Comment", as_Value )
end function

public function integer of_setref1type (integer ai_value);Int		li_Return
String	ls_Null
n_cst_ShipmentManager	lnv_ShipMan
SetNull ( ls_Null )

li_Return = this.of_SetAny ( "ds_ref1_type" , ai_Value ) 
IF li_Return = 1 THEN
	IF ai_Value = 0 THEN
		THIS.of_SetRef1Text ( ls_Null )
	ELSE
		lnv_ShipMan.of_Reftypechanged( 1, THIS )
	END IF
END IF

RETURN li_Return
end function

public function integer of_setref2type (integer ai_value);Int		li_Return
String	ls_Null
n_cst_shipmentManager	lnv_ShipMan
SetNull ( ls_Null )

li_Return = this.of_SetAny ( "ds_ref2_type" , ai_Value ) 

IF li_Return = 1 THEN
	IF ai_Value = 0 THEN
		THIS.of_SetRef2Text ( ls_Null )
	ELSE
		lnv_ShipMan.of_RefTypechanged( 2, THIS )
	END IF	
END IF

RETURN li_Return
end function

public function integer of_setref3type (integer ai_value);Int		li_Return
String	ls_Null
n_Cst_ShipmentManager	lnv_ShipMan
SetNull ( ls_Null )

li_Return = this.of_SetAny ( "ds_ref3_type" , ai_Value ) 
IF li_Return = 1 THEN
	IF ai_Value = 0 THEN
		THIS.of_SetRef3Text ( ls_Null )
	ELSE
		lnv_ShipMan.of_RefTypechanged( 3, THIS )
	END IF
END IF

RETURN li_Return
end function

public function long of_setbilltoid (long al_value);SetPointer(HourGlass!)		
integer	li_return
Long		ll_OldBillTO
long		ll_origin, &
			ll_destination
String	ls_Terms			
boolean	lb_recalc	

n_cst_ContactManager	lnv_Contacts
n_cst_beo_Company	lnv_Company
n_cst_ratedata	lnva_ratedata[]
n_cst_beo_item	lnva_item[]
n_cst_AnyArraySrv		lnv_ArraySrv
n_cst_setting_recalcfuelsurcharge	lnv_recalc

lnv_recalc = create n_cst_setting_recalcfuelsurcharge

ll_OldBillTo = THIS.of_GetBillTo ( )

lnv_Contacts = CREATE n_CsT_ContactManager
lnv_Company = CREATE n_Cst_Beo_Company

lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID ( ll_OldBillTo )


li_return = THIS.of_SetAny ( "ds_billto_id" , al_Value )

if li_return = 1 then
	IF lnv_Company.of_HasSource ( ) THEN
		lnv_Contacts.of_RemoveContactsIfNeeded ( THIS , lnv_Company )
	END IF
	lnv_Company.of_SetSourceID ( al_Value )
	lnv_Contacts.of_AddContactsIfNeeded ( THIS , lnv_Company , n_cst_companies.cs_companyrole_billto)
	

	//if origin and destination have been set then we can autorate
	ll_origin = this.of_getorigin()
	ll_destination = this.of_getDestination()
	if (isnull(al_value) or al_value = 0) or &
		(isnull(ll_origin) or ll_origin = 0) or &
		(isnull(ll_destination) or ll_destination = 0) then
		//don't have all of the info to rate
	else
		
		
		
		if this.of_autorate(lnva_ratedata, cs_action_changedbillto) = 1 then
			this.of_ApplyFreightRate(lnva_ratedata, cs_action_changedbillto)
			this.of_ApplyAccessRate(lnva_ratedata)	
			
		end if
		
		this.of_autogenaccessorialitem ( )
		
		lnv_ArraySrv.of_Destroy ( lnva_RateData )
	end if
	// Dan changed 12-29-2005---
	// I swapped the call from of_reCalcSurcharges to of_recalcExistingSurcharges when I was attempting to address
	// the issue of not recalculating fuelsurcharges for older shipments.  Because of a change I made in of_RecalcSurcharges,
	// it is possible that setting the billtoid will not actually recalculate the surcharge.  (That change was one that checked
	// to see if the data in fuel surcharge was modified before changeing it.  If it isn't modified, the recalc doesn't happen.)
	// I thought about two issues before changing this. 1.  What happens when there is a fuelSurcharge and 2. what happens when there is no
	// fuel surcharge.  For when there is one, it recalculates it using the correct rate.  When there isn't one, there is nothing
	// to calculate anyhow.
	//THIS.Post of_ReCalcSurcharges ( )
//	IF NOT this.of_hasnewfuelsurcharge( ) AND lnv_recalc.of_getvalue( ) = "No" THEN
//		MessageBox("Fuel Surcharge", "Note: Fuel surcharge will be recalculated on every change until the next save. The FSC row will have green text while in this mode.", EXCLAMATION!)		
//	END IF
	IF this.of_hasFuelsurcharge( ) THEN
		THIS.Post of_ReCalcExistingSurcharges()
	ELSE
		THIS.POST of_ReCalcSurcharges ( )
	END IF
	//--------------
	
	if this.Of_Determinepaymentterms(cs_action_changedbillto, ls_Terms) = 1 then
		this.of_SetPaymentterms( ls_terms)
	end if
	
end if


n_cst_LicenseManager	lnv_LicMan

IF lnv_LicMan.of_HasDocumentttansfer( ) THEN
	n_cst_bso	lnv_Disp
	lnv_Disp = THIS.of_GetContext( )
	IF IsValid ( lnv_Disp ) THEN
		lnv_Disp.Dynamic of_GetDocumentManager ( ).of_RemoveTransferRequest ( ll_OldBillTO , THIS.of_GetID ( ) )
		lnv_Disp.Dynamic of_GetDocumentManager ( ).of_AddTransferRequestForCompany ( al_value , THIS.of_GetID ( ) )
		
	END IF
	
END IF

DESTROY ( lnv_recalc )
DESTROY ( lnv_Contacts ) 
DESTROY ( lnv_Company )

//THIS.of_CompanyAdded ( al_value )

RETURN li_Return
end function

public function int of_setshipdate (date ad_Value);RETURN THIS.of_SetAny ( "ds_ship_date" , ad_Value )
end function

public function integer of_removefreightitems (ref n_cst_bso_dispatch anv_dispatch);Datastore	lds_ItemCache
Long			lla_FreightItemIDs[]
Long			ll_ItemCount
Long			ll_FoundRow
Long			i
Long			ll_RowCount
dwbuffer		le_Buffer


n_cst_beo_Item	lnva_Items[]


lds_ItemCache = anv_Dispatch.of_GetItemCache ( )
THIS.of_SetItemSource ( lds_ItemCache )

ll_RowCount = lds_ItemCache.RowCount ( )

ll_ItemCount = THIS.of_GetItemList ( lnva_Items )

FOR i = 1 TO ll_ItemCount
	IF lnva_Items[i].of_Gettype ( ) = "L" THEN
		lla_FreightItemIDs[ UpperBound ( lla_FreightItemIDs ) + 1 ] = lnva_Items[i].of_GetID ( )
	END IF
	
NEXT

ll_ItemCount = UpperBound ( lla_FreightItemIDs )

FOR i = 1 TO ll_ItemCount
	
	IF IsValid ( lnva_Items[i] ) THEN
		lnva_Items[i].of_GetSourceRow ( ll_FoundRow, le_buffer, FALSE )
		IF ll_FoundRow > 0 THEN
			lds_ItemCache.RowsMove ( ll_FoundRow , ll_FoundRow , le_Buffer , lds_ItemCache , 999 , DELETE! )
		END IF
	END IF

NEXT

ll_ItemCount = UpperBound (lnva_Items )
FOR i = 1 TO ll_ItemCount
	DESTROY ( lnva_Items[i] )
NEXT

RETURN 1


end function

public function integer of_setdefaultdestination ();n_cst_beo_Event	lnva_EventList[]
Long					ll_Count
Long					i
Int					li_Return

// get the list of events for the shipment 

THIS.of_GetEventList ( lnva_EventList )
ll_Count = UpperBound ( lnva_EventList )

// determine the last del event with a site
FOR i = ll_Count TO 1 STEP -1
	IF lnva_EventList[i].of_IsDeliverGroup ( ) THEN
		IF lnva_EventList[i].of_GetSite ( ) > 0 THEN
			THIS.of_SetFinalDestination (  lnva_EventList[i].of_GetSite ( ) )
			li_Return = 1
			EXIT 
		END IF
	END IF
NEXT

FOR i = 1 TO ll_Count 
	DESTROY ( lnva_EventList[ i ] )
NEXT


RETURN li_Return
end function

public function integer of_setfinaldestination (long al_value);SetPointer(HourGlass!)
long		ll_billto, &
			ll_origin, &
			ll_updatecount
			
integer	li_return

n_cst_ratedata	lnva_ratedata[]
n_cst_AnyArraysrv	lnv_ArraySrv

li_return = THIS.of_SetAny ( "ds_findest_id" , al_Value )

// This could change the Billto, thats why it is above the rating.
IF li_Return = 1 THEN
	This.of_CheckPrepaidCollect( )
END IF	

if li_return = 1 then
	//if origin and destination have been set then we can autorate
	ll_origin = this.of_getOrigin()
	if (isnull(al_value) or al_value = 0) or &
		(isnull(ll_Origin) or ll_Origin = 0) then
		//need both to autorate
	else
		ll_billto = this.of_getbillto()			
		if (isnull(ll_billto) or ll_billto = 0) then
			//try rerating items already rated
			this.of_RerateItems()	
		else
			//go ahead and rate whole shipment
			
			this.of_autogenaccessorialitem ( )
			
			if this.of_autorate(lnva_ratedata, cs_action_changeddestination) = 1 then
				ll_updatecount = this.of_ApplyFreightRate(lnva_ratedata, cs_action_changeddestination)
				ll_updatecount += this.of_ApplyAccessRate(lnva_ratedata)	
				if ll_updatecount = 0 then
					//nothing was updated try to rerate items individually
					this.of_RerateItems()
				end if
				
			end if
			THIS.Post of_ReCalcSurcharges ( ) // moved this out from within the IF statement above (1 line above)
			lnv_ArraySrv.of_Destroy ( lnva_RateData )
		end if
	end if
end if	


IF li_Return = 1 THEN  // issue 2280
	n_cst_beo_Event	lnv_Event
	IF THIS.of_getdestinationevent ( lnv_Event ) = 1 THEN
		IF isNull ( lnv_Event.of_Getscheduleddate( )  ) THEN
			lnv_Event.of_SetScheduleddate( THIS.of_getdelbydate( ) )
		END IF
		
		IF isNull ( lnv_Event.of_GetScheduledtime( ) ) THEN
			lnv_Event.of_setscheduledtime( THIS.of_getDelbytime( ) )
		END IF		
	END IF
	DESTROY ( lnv_Event )
END IF

IF li_return = 1 THEN // issue 2236
	n_cst_ContactManager	lnv_Contacts
	lnv_Contacts = CREATE n_cst_ContactManager
	n_cst_beo_Company	lnv_co
	THIS.of_GetBilltocompany( lnv_co, TRUE )
	lnv_Contacts.of_AddContactsIfNeeded ( THIS , lnv_co , n_cst_companies.cs_companyrole_billto)
	DESTROY ( lnv_co ) 
	DESTROY ( lnv_Contacts )
END IF

RETURN li_Return

end function

public function integer of_setdefaultorigin ();n_cst_beo_Event	lnva_EventList[]
Long					ll_Count
Long					i
Int					li_Return

// get the list of events for the shipment 

THIS.of_GetEventList ( lnva_EventList )
ll_Count = UpperBound ( lnva_EventList )

// determine the first pu event with a site
FOR i = 1 TO ll_Count 
	IF lnva_EventList[i].of_IsPickupGroup ( ) THEN
		IF lnva_EventList[i].of_GetSite ( ) > 0 THEN
			THIS.of_SetOrigin (  lnva_EventList[i].of_GetSite ( ) )
			li_Return = 1
			EXIT 
		END IF
	END IF
NEXT

FOR i = 1 TO ll_Count 
	DESTROY ( lnva_EventList[ i ] )
NEXT

RETURN li_Return
end function

public function integer of_setorigin (long al_value);long		ll_billto, &
			ll_destination, &
			ll_updatecount

integer	li_return

n_cst_ratedata	lnva_ratedata[]
n_cst_AnyArraySrv lnv_ArraySrv

li_return = THIS.of_SetAny ( "ds_origin_id" , al_Value )

// This could change the Billto, thats why it is above the rating.
IF li_Return = 1 THEN
	This.of_CheckPrepaidCollect( )
END IF	

IF li_Return = 1 THEN
	THIS.of_SetDefaultFreightDescription( )
END IF

if li_return = 1 then
	//if destination has been set then we can autorate
	ll_destination = this.of_getDestination()
	if (isnull(al_value) or al_value = 0) or &
		(isnull(ll_destination) or ll_destination = 0) then
		//need both to autorate
	else
		ll_billto = this.of_getbillto()
		if (isnull(ll_billto) or ll_billto = 0) then
			//try rerating items already rated
			this.of_RerateItems()	
		else
			//go ahead and rate whole shipment
			
			this.of_autogenaccessorialitem ( )
			
			if this.of_autorate(lnva_ratedata, cs_action_changedorigin) = 1 then
				ll_updatecount = this.of_ApplyFreightRate(lnva_ratedata, cs_action_changedorigin)
				ll_updatecount += this.of_ApplyAccessRate(lnva_ratedata)	
				if ll_updatecount = 0 then
					//nothing was updated try to rerate items individually
					this.of_RerateItems()
				end if
				
			end if
			THIS.Post of_ReCalcSurcharges ( ) // moved this out from the IF statement 1 line above
			lnv_ArraySrv.of_Destroy ( lnva_RateData )
		end if
	end if
end if

IF li_Return = 1 THEN  // issue 2280
	n_cst_beo_Event	lnv_Event
	IF THIS.of_GetOriginevent( lnv_Event ) = 1 THEN
		IF isNull ( lnv_Event.of_Getscheduleddate( )  ) THEN
			lnv_Event.of_SetScheduleddate( THIS.of_getpickupbydate( ) )
		END IF
		
		IF isNull ( lnv_Event.of_GetScheduledtime( ) ) THEN
			lnv_Event.of_setscheduledtime( THIS.of_getpickupbytime( ) )
		END IF		
	END IF
	DESTROY ( lnv_Event )
END IF

IF li_return = 1 THEN// issue 2236
	n_cst_ContactManager	lnv_Contacts
	lnv_Contacts = CREATE n_cst_ContactManager
	n_cst_beo_Company	lnv_co
	THIS.of_GetBilltocompany( lnv_co, TRUE )
	lnv_Contacts.of_AddContactsIfNeeded ( THIS , lnv_co , n_cst_companies.cs_companyrole_billto)
	DESTROY ( lnv_co ) 
	DESTROY ( lnv_Contacts )
END IF

RETURN li_Return










end function

public function integer of_setbillingcomments (string as_Value);RETURN THIS.of_SetAny ( "ds_Bill_Comment" , as_Value )
end function

public function date of_getavailableon ();RETURN This.of_GetValue ( "availableon", TypeDate! )
end function

public function date of_getavailableuntil ();RETURN This.of_GetValue ( "availableuntil", TypeDate! )
end function

public function string of_getdispatchedby ();RETURN This.of_GetValue ( "dispatchedby", TypeString! )
end function

public function string of_getpayableformat ();RETURN of_GetValue ( "ds_pay_format", TypeString! )
end function

public function decimal of_getfreightpayable ();RETURN This.of_GetValue ( "ds_pay_lh_totamt", TypeDecimal! )
end function

public function decimal of_getaccessorialpayable ();RETURN This.of_GetValue ( "ds_pay_ac_totamt", TypeDecimal! )
end function

public function integer of_calculatepayable ();//Returns : 1, -1

n_cst_beo_Item	lnva_Items[]
Long		ll_ItemCount, &
			ll_Index
Decimal	lc_FreightPayable, &
			lc_AccessorialPayable, &
			lc_TotalPayable
String	ls_PayableFormat

Integer	li_Return = 1

ls_PayableFormat = This.of_GetPayableFormat ( )

IF ls_PayableFormat = cs_PayableFormat_Total THEN

	//No Processing Needed.  Total is whatever has been specified by the user.

ELSE

	CHOOSE CASE ls_PayableFormat
	
	CASE cs_PayableFormat_Item
	
		ll_ItemCount = This.of_GetItemList ( lnva_Items )
		
		IF ll_ItemCount >= 0 THEN
	
			FOR ll_Index = 1 TO ll_ItemCount
	
				lc_FreightPayable += lnva_Items [ ll_Index ].of_GetFreightPayable ( )
				lc_AccessorialPayable += lnva_Items [ ll_Index ].of_GetAccessorialPayable ( )	
		
			NEXT
	
		ELSE
			li_Return = -1
	
		END IF
	
	CASE cs_PayableFormat_Category
	
		lc_FreightPayable = This.of_GetFreightPayable ( )
		lc_AccessorialPayable = This.of_GetAccessorialPayable ( )
	
	CASE ELSE  //Unexpected Format
		li_Return = -1
	
	END CHOOSE

	IF li_Return = 1 THEN

		This.of_SetAny ( "ds_pay_lh_totamt", lc_FreightPayable )
		This.of_SetAny ( "ds_pay_ac_totamt", lc_AccessorialPayable )

		//Read the amounts just set back, so that any rounding performed by the dw fields
		//will be properly reflected in the total.

		lc_FreightPayable = This.of_GetFreightPayable ( )
		lc_AccessorialPayable = This.of_GetAccessorialPayable ( )

		if isnull(lc_AccessorialPayable) then
			lc_AccessorialPayable = 0
		end if
		
		if isnull(lc_freightPayable) then
			lc_freightPayable = 0
		end if
		
		lc_TotalPayable = lc_FreightPayable + lc_AccessorialPayable

		This.of_SetAny ( "ds_pay_totamt", lc_TotalPayable )

	END IF

END IF

FOR ll_Index = 1 TO ll_ItemCount
	DESTROY ( lnva_Items [ ll_Index ] )
NEXT

RETURN li_Return
end function

public function decimal of_getpayabletotal ();RETURN of_GetValue ( "ds_pay_totamt", TypeDecimal! )
end function

public function integer of_getcarriercompany (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache);Long		ll_CarrierId
Integer	li_Return = -1

ll_CarrierId = This.of_Getcarrier ( )

IF IsNull ( ll_CarrierId ) THEN

	li_Return = 0

ELSE

	DESTROY anv_company
	
	anv_company = CREATE n_cst_beo_Company
	
	IF ab_CheckCache THEN
		gnv_cst_Companies.of_Cache ( ll_CarrierId, FALSE )
	END IF

	anv_Company.of_SetUseCache ( TRUE )
	
	IF anv_Company.of_SetSourceId ( ll_CarrierId ) = 1 THEN
		IF anv_Company.of_HasSource ( ) THEN
			li_Return = 1
		END IF
	END IF

END IF

RETURN li_Return
end function

public function integer of_addevent (string as_type, integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatchmanager, ref long al_id, long al_siteid);// this method will add an event or events of the specified type and reoreder the sequence
// numbers according to the insertion point.

Long	lla_NewEventIDs[]
Long	ll_EventCount
Long	ll_ShipID
Int	i
Int	li_ResequenceRtn
Long	ll_InsertionPoint
Int	li_Return = 1
Long	ll_SetRtn

PowerObject	lpo_Events
n_cst_beo_Event	lnv_CurrentEvent
n_cst_beo_event	lnva_EventList[]
n_cst_settings		lnv_Settings

lnv_CurrentEvent = CREATE n_cst_Beo_Event

ll_ShipID = THIS.of_GetID ( ) 

ll_InsertionPoint	= ai_insertionPoint

anv_dispatchmanager.of_NewEvents ( {as_type} , lla_NewEventIDs )
ll_EventCount = UpperBound( lla_NewEventIDs )

IF ll_EventCount = 1 THEN

	lpo_Events = THIS.of_GetEventSource ( )
	THIS.of_GetEventList ( lnva_EventList )
	
	al_id = lla_NewEventIDs [ 1 ]
	ll_SetRtn = lnv_CurrentEvent.of_SetSource ( lpo_Events )
	ll_SetRtn =	lnv_CurrentEvent.of_SetSourceID ( lla_NewEventIDs [ 1 ] )	
	lnv_CurrentEvent.of_SetAllowFilterSet ( TRUE )
	
	ll_SetRtn = lnv_CurrentEvent.of_SetShipSeq ( ll_InsertionPoint )
	ll_SetRtn = lnv_CurrentEvent.of_SetShipment ( ll_ShipID )
	
	IF al_siteid > 0 THEN
		ll_SetRtn = lnv_CurrentEvent.of_SetSite ( al_SiteID )
	END IF
	
	IF	( lnv_CurrentEvent.of_GetType ( ) = gc_dispatch.cs_EventType_Pickup OR lnv_CurrentEvent.of_GetType ( ) = gc_dispatch.cs_EventType_Deliver ) AND THIS.of_GetEventCount ( ) > 2 THEN
		IF  lnv_Settings.of_AddStopOffItem ( )  THEN		
			THIS.of_AddStopOffItem ( lnv_CurrentEvent , anv_DispatchManager ) 
		END IF
	END IF	
	
	li_ResequenceRtn = THIS.of_ResequenceEvents ( lnv_CurrentEvent , lnva_EventList )
	
	IF li_ResequenceRtn <> 1 THEN
		li_Return = -1	
	END IF
		
END IF

DESTROY ( lnv_CurrentEvent ) 

Int li_Count
li_Count = UpperBound ( lnva_EventList )
FOR i = 1 TO li_Count 
	DESTROY ( lnva_EventList[i] )
NEXT


Return li_Return

end function

public function decimal of_getsalescommission ();RETURN of_GetValue ( "ds_salescom_amt", TypeDecimal! )
end function

public function integer of_getnexteventlist (ref n_cst_beo_event anva_events[]);/*
	THIS method will return a list of events. the first event in the list will be 
	the first unconfirmed event .
*/
Int	li_Return
Int	i, j
Int	li_Index
Int	li_Count
n_cst_beo_Event	lnva_EventList[]

li_count = UpperBound ( anva_events[] )
FOR i = 1 TO li_Count
	Destroy ( anva_events[i] )
NEXT



THIS.of_GetEventList ( lnva_EventList )

li_Count = UpperBound ( lnva_EventList )

FOR i = 1 TO li_Count 
	IF NOT lnva_EventList[i].of_IsConfirmed ( ) THEN
		EXIT
	ELSE
		DESTROY ( lnva_EventList[i] )
	END IF
	
NEXT

FOR j = i TO li_Count
	li_Index ++
	anva_Events[ li_index ] = lnva_EventList[j]
NEXT

Return UpperBound ( anva_Events )
end function

public function integer of_getequipmentlist (ref n_cst_beo_equipment2 anva_equipment[]);Int		li_Return
Int		li_Count
Int		i
Long		ll_eqId
Long		ll_ShipmentID
Long		lla_Drivers[]
Long		lla_PowerUnits[]
Long		lla_AllEquipment[]
Long		lla_TrailerChassis[]
Long		lla_Containers[]
Long		ll_tempCount
Long		ll_findRow
String	ls_find
String	ls_Where
String	ls_where2

n_cst_beo_Event	lnva_Events[]
n_cst_EquipmentManager	lnv_EquipmentManager
n_cst_anyarraysrv		lnv_ArraySrv
n_cst_sql				lnv_Sql

datastore	lds_temp

li_Count = UpperBound ( anva_Equipment )  
FOR i = 1 TO li_Count
	DESTROY ( anva_Equipment[i] )
NEXT



IF NOT isValid ( ids_equipment ) THEN
	ll_ShipmentID = THIS.of_GetID ( ) 
	li_Count = THIS.of_GetEventList ( lnva_Events )
	
	FOR i = 1 TO li_Count
		lnva_Events[i].of_getassignments ( lla_Drivers, lla_PowerUnits, lla_TrailerChassis, lla_Containers )
	
		lnv_ArraySrv.of_appendlong ( lla_AllEquipment, lla_TrailerChassis )
		lnv_ArraySrv.of_appendlong ( lla_AllEquipment, lla_Containers )
		lnv_ArraySrv.of_appendlong ( lla_AllEquipment, lla_PowerUnits )
		
	NEXT
	
	// shrink the array by removing nulls and dupes
	lnv_ArraySrv.of_getshrinked ( lla_AllEquipment, TRUE , TRUE )
// *****DEK 5-15-07******The performance for doing a combined retrieve was significantly worse then doing
//  				Two seperate retreivals, and then combining the results.  So what I do is do
//					the first part of the retrieve, and then if necessary I do a retrieve of the 'In' clause
//					into a temporary datastore, and then I copy them into the datastore they should have
//					been retrieved into(if they are not there already.)  I also reset the status of the
//					datastore because all of the rows after the old retrieval should be "NOTMODIFIED".
	// first build the where clause for linked equipment
	ls_Where = "WHERE ( ~~~"outside_equip~~~".~~~"shipment~~~" = " + String ( ll_ShipmentID ) + " OR  ~~~"outside_equip~~~".~~~"reloadshipment~~~" = " + String ( ll_ShipmentID ) + " ) AND eq_status <> 'X' "
	
	lnv_EquipmentManager.of_retrievewithcompanyinfo( ids_equipment, ls_where)

	
	li_count = ids_equipment.rowCOunt()
	//Then add the in clause to retrieve the equipment associated by event assignments
	IF UpperBound ( lla_AllEquipment ) > 0 THEN
		ls_Where2 = "WHERE eq_ID " + lnv_Sql.of_MakeInClause ( lla_AllEquipment )
		lnv_EquipmentManager.of_RetrieveWithCompanyInfo ( lds_temp , ls_Where2  )	//lds_temp gets created here
		ll_tempCount = lds_temp.rowcount( )
	END IF
	
	//DEK 5-15-07  Check to see if the additional equipment is there already, and discard
	//					them.
	FOR i = ll_TempCount TO 1 STEP -1
		ll_eqID = lds_temp.getitemNumber( i, "eq_id")
		ls_find = "eq_id = "+ string(ll_eqId)
		ll_findRow = ids_equipment.find( ls_find, 1, li_Count)
		
		IF ll_FindRow > 0 THEN
			lds_temp.rowsdiscard( i, i, PRIMARY!)
		END IF
	NEXT

	//DEK 5-15-07 copy the rows if any into datastore it should have been retreived in originally.
	IF isValid(lds_temp) THEN
		ll_TempCount = lds_temp.rowCOunt()
		IF ll_tempCount > 0 THEN
			lds_temp.rowscopy( 1, ll_tempCount, PRIMARY!, ids_equipment, li_count+ 1 , PRIMARY!)
		END IF
		DESTROY lds_temp
	END IF
	
	//DEK 5-15-07  Reset the update, the retreival before wouldn't have had any modified rows in it.
	ids_equipment.resetupdate( )
	ids_Equipment.SetSort ( "pos('CHBVFRKNTS',eq_type) A , eq_id D " )
	ids_Equipment.Sort ( )
	
	
END IF

li_Count = ids_equipment.RowCount ( ) 
FOR i = 1 TO li_Count
	anva_Equipment[i] = CREATE n_cst_beo_Equipment2
	anva_Equipment[i].of_SetSource ( ids_equipment )
	anva_Equipment[i].of_SetSourceRow ( i )

NEXT

li_Return = UpperBound ( anva_Equipment )

li_Count = UpperBound ( lnva_Events )
FOR i = 1 TO li_Count 
	DESTROY ( lnva_Events[i] )
NEXT

RETURN li_Return
end function

public function integer of_removeevents (long ala_eventids[], n_cst_bso_dispatch anv_dispatch, boolean ab_notify);Long		ll_EventCount
Long		ll_ItemCount
Long		i
Boolean	lb_DeleteItems
Boolean	lb_HasItems
Long		ll_OriginBTEvent
Long		ll_DestBTEvent

Int	li_Return = 1

n_cst_beo_Event	lnva_EventList[]
n_cst_beo_Item		lnva_ItemList []
n_Cst_AnyArraySrv	lnv_Array


/// we need to see if one of the events selected is part of a "bob tail" 
// and if it is we need to get the other event if we don't already have it
ll_EventCount = THIS.of_GetEvents ( ala_EventIds , lnva_EventList )
FOR i = 1 TO ll_EventCount
	IF lnva_EventList[i].of_IsBobtailevent( ) THEN
		lnva_EventList[i].of_getbobtaileventids( ll_OriginBTEvent, ll_DestBTEvent )
		ala_eventids[UpperBound ( ala_eventids[] ) + 1 ] = ll_OriginBTEvent
		ala_eventids[UpperBound ( ala_eventids[] ) + 1 ] = ll_DestBTEvent
	END IF
NEXT
lnv_Array.of_destroy( lnva_EventList )


lnv_Array.of_Getshrinked( ala_eventids,TRUE, TRUE)



ll_EventCount = THIS.of_GetEvents ( ala_EventIds , lnva_EventList )
ll_ItemCount =  THIS.of_GetItemList ( lnva_Itemlist )

IF li_Return = 1 THEN
	
	lb_HasItems = THIS.of_DoEventsHaveItems ( lnva_EventList , lnva_ItemList )
	
	IF lb_HasItems THEN
		IF THIS.of_AllowItemEdit( ) THEN
				
			choose case messagebox("Delete Event", "Do you also wish to delete every item "+&
					"associated with the selected event(s)?  Press Yes to delete items, No to delete "+&
					"the event(s) only, and Cancel to cancel operation.", question!, yesnocancel!, 3)
	
				case 1
					lb_DeleteItems = TRUE
		
				case 2
					lb_DeleteItems = FALSE
					
				case 3
					li_Return = 0 
					
			end choose
			
		ELSE 
			
			IF messagebox("Delete Event", "You are not authorized to make changes to items. Therefore, the items associated to the event(s) will not be deleted.", INFORMATION!, OKcancel!, 1) = 2 THEN
				li_Return = 0 
			END IF	
							
		END IF
	END IF
END IF


IF li_Return = 1 THEN
	CHOOSE CASE UpperBound ( ala_eventids )
		CASE 1
		
			IF THIS.of_PrepareSingleEventForDeletion ( ala_eventids[1], anv_dispatch ) <> 1 THEN
				li_Return = -1
			END IF
		
		CASE is > 1
			
			IF THIS.of_PreValidateEventRemoval ( lnva_EventList ) <> 1 AND ab_Notify THEN // won't be able to delete
				MessageBox ( "Deletion of Events" , "Routed assignment events and confirmed events cannot be part of a group selected for deletion. Request Cancelled." ) 
				li_Return = -1
			END IF
			
		CASE ELSE
			li_Return = 0
			
	END CHOOSE
END IF


IF li_Return = 1 THEN
	
	THIS.of_GetEventList ( lnva_EventList[] )
	
	FOR i = 1 TO ll_EventCount		
		THIS.of_RemoveEvent ( ala_EventIds [ i ], lb_DeleteItems , anv_dispatch ) 
		DESTROY ( lnva_EventList[i] )
	NEXT
	

END IF

ll_ItemCount = UpperBound ( lnva_itemlist[] )
FOR i = 1 TO ll_ItemCount
	DESTROY ( lnva_itemlist[i] )
NEXT

RETURN li_Return


end function

public function integer of_removeevents (long ala_EventIds[], n_cst_bso_Dispatch anv_Dispatch);RETURN THIS.of_RemoveEvents ( ala_EventIds , anv_Dispatch , TRUE )
end function

public function integer of_getchassislist (ref n_cst_beo_equipment2 anva_equipment[]);// this will get chassis
Int		li_Return
Int		li_Count
Int		i
Int		li_Index


n_cst_beo_equipment2	lnva_Equipment[]

IF NOT isValid ( ids_equipment ) THEN
	THIS.of_GetEquipmentList ( lnva_Equipment )
END IF

li_Count = UpperBound ( lnva_Equipment ) 
FOR i = 1 TO li_Count 
	DESTROY ( lnva_Equipment [i])
NEXT
	

li_Count = ids_equipment.RowCount ( ) 
FOR i = 1 TO li_Count
	IF ids_equipment.GetItemString ( i , "eq_type" ) = "H" THEN
		li_Index ++
		anva_Equipment[li_Index]= CREATE n_cst_beo_Equipment2
		anva_Equipment[li_Index].of_SetSource ( ids_equipment )
		anva_Equipment[li_Index].of_SetSourceRow ( i )
	END IF
NEXT

li_Return = UpperBound ( anva_Equipment )

RETURN li_Return
end function

public function integer of_getcontainerlist (ref n_cst_beo_equipment2 anva_equipment[]);Int		li_Return
Int		li_Count
Int		i
Int		li_Index

n_cst_beo_Equipment2		lnva_Equipment[]
anva_equipment = lnva_Equipment

//Get a list of all the equipment, this will also retrieve the equipment if needed
IF NOT isValid ( ids_equipment ) THEN
	THIS.of_GetEquipmentList ( lnva_Equipment )
END IF

li_Count = UpperBound ( lnva_Equipment ) 
FOR i = 1 TO li_Count 
	DESTROY ( lnva_Equipment [i])
NEXT


li_Count = ids_equipment.RowCount ( ) 
FOR i = 1 TO li_Count
	IF ids_equipment.GetItemString ( i , "eq_type" ) = "C" THEN
		li_Index ++
		anva_Equipment[li_Index] = CREATE n_cst_beo_Equipment2
		anva_Equipment[li_Index].of_SetSource ( ids_equipment )
		anva_Equipment[li_Index].of_SetSourceRow ( i )
	END IF
NEXT

li_Return = UpperBound ( anva_Equipment )

RETURN li_Return
end function

public function integer of_gettrailerlist (ref n_cst_beo_equipment2 anva_equipment[]);// this will get chassis, trailer, railboxes , FlatBeds, Refers, Tanks.

Int		li_Return
Int		li_Count
Int		i
Int		li_Index
String	ls_EqType


n_cst_beo_equipment2	lnva_Equipment[]

IF NOT isValid ( ids_equipment ) THEN
	THIS.of_GetEquipmentList ( lnva_Equipment )
END IF

li_Count = UpperBound ( lnva_Equipment ) 
FOR i = 1 TO li_Count 
	DESTROY ( lnva_Equipment [i])
NEXT

li_Count = ids_equipment.RowCount ( ) 
FOR i = 1 TO li_Count
	ls_EqType = ids_equipment.GetItemString ( i , "eq_type" )
	CHOOSE CASE ls_EqType
		CASE "V","F","R","K","B","H"
		li_Index ++
		anva_Equipment[li_Index] = CREATE n_cst_beo_Equipment2
		anva_Equipment[li_Index].of_SetSource ( ids_equipment )
		anva_Equipment[li_Index].of_SetSourceRow ( i )
	END CHOOSE
NEXT

li_Return = UpperBound ( anva_Equipment )

RETURN li_Return
end function

public function long of_getfirsteventid (string as_eventtypes);/***************************************************************************************
NAME: 			of_GetFirstEventID		
	
ACCESS:			Public
	
ARGUMENTS: 		as_EventTypes
					a string of chars indicating the type of events of look for
					'H' Hook
					'HM' Hook or Mount 
					
RETURNS:			Long
					The event id of the first event matching the type(s) passed in 
					-1 if not found or error
	
	
DESCRIPTION:	
					this method will locate the first event in the shipment of the type 
					specified, multiple types can be specified but only one id will be passed
					out. NOTE this method will not find the the first event for each type 
					passed in.


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
		CREATED April 9 2002 RPZ



***************************************************************************************/


Long		ll_EventCount
Long		i
Long		ll_ReturnID = -1
String	ls_EventType

n_cst_beo_Event	lnva_EventList[]

THIS.of_GetEventList ( lnva_EventList )
ll_EventCount = UpperBound ( lnva_EventList )


FOR i = 1 TO ll_EventCount
	ls_EventType = lnva_EventList[i].of_Gettype ( )
	IF pos( as_EventTypes, ls_EventType ) > 0 THEN  // found the first one
		ll_ReturnID = lnva_EventList[i].of_GetID ( )
		EXIT
	END IF
	
NEXT

FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_EventList[ i ] )
NEXT


RETURN ll_ReturnID
end function

public function integer of_getreferencedcompanies (ref long ala_companyids[]);// Referenced Companies
/*
		Bill to
		Agent
		Forwarder
		Sites for Event
		
		Carrier added 4.0

*/

Int	li_IdCount
Int	li_EventCount
Int   i
Long	lla_CompanyIDs [ ]

Long	ll_BillTo
Long	ll_Agent
Long	ll_Forwarder
Long	ll_Carrier

n_cst_beo_Event	lnva_EventList[]

ll_BillTo = THIS.of_GetBillTo ( )
ll_Agent = THIS.of_GetAgent ( )
ll_Forwarder = THIS.of_GetForwarder ( )
ll_Carrier = THIS.of_GetCarrier( )

IF ll_BillTo > 0 THEN
	li_IDCount ++
	lla_CompanyIDs [ li_IDCount ] = ll_BillTo
END IF

IF ll_Agent > 0 THEN
	li_IdCount ++
	lla_CompanyIDs [ li_IDCount ] = ll_Agent
END IF

IF ll_Forwarder > 0 THEn
	li_IDCount ++ 
	lla_CompanyIds [ li_IDCount ] = ll_Forwarder
END IF

IF ll_Carrier > 0 THEn
	li_IDCount ++ 
	lla_CompanyIds [ li_IDCount ] = ll_Carrier
END IF

li_EventCount = THIS.of_geteventlist ( lnva_EventList )

FOR i = 1 TO li_EventCount
	li_IDCount ++
	lla_CompanyIds [ li_IDCount ] = lnva_EventList[i].of_GetSite () 	
	DESTROY ( lnva_EventList[i] )
NEXT

n_cst_anyarraysrv	lnv_ArraySrv
lnv_ArraySrv.of_getshrinked ( lla_CompanyIds, TRUE , TRUE )

ala_CompanyIds[] = lla_CompanyIds

RETURN 1

end function

public function integer of_validatestatus (string as_status, ref string as_message, unsignedlong aul_exclude);/*
NOTE:	ai_exclude is a bitwise representation of the errors to exclude
	6 = 110 therfore the 2nd and 3rd problems will not be processed
	262143 = 111111111111111111 therefore all problems will not be processed
*/


Boolean	lb_ValidateCurrent, &
			lb_Invalid
Boolean	lb_Intermodal
String	ls_CurrentStatus
Long		ll_ItemCount, &
			ll_Eventcount, &
			ll_Ndx
Integer	lia_Problems[18]  // note that this upperbound is used further down
Int		i
n_cst_beo_Item		lnva_Items[]
n_cst_beo_Event	lnva_Events[]
n_cst_numerical lnv_numerical

as_Message = ""

ls_CurrentStatus = of_GetStatus ( )

lb_intermodal = THIS.of_IsIntermodal ( )

IF as_Status = ls_CurrentStatus THEN
	lb_ValidateCurrent = TRUE
END IF

IF ls_CurrentStatus = gc_Dispatch.cs_ShipmentStatus_Billed AND &
	lb_ValidateCurrent = FALSE THEN

	as_Message += "Cannot change status of a billed shipment.~n"
	RETURN -2

END IF


IF ls_CurrentStatus = gc_Dispatch.cs_ShipmentStatus_Offered THEN

	as_Message += "Cannot modify an offered shipment.~n"
	RETURN -4

END IF

IF ls_CurrentStatus = gc_Dispatch.cs_ShipmentStatus_Declined THEN

	as_Message += "Cannot modify a declined shipment.~n"
	RETURN -4

END IF


//If we're validating a status with no minimum information requirements, approve it without 
//performing the other checks.

CHOOSE CASE as_Status

CASE	gc_Dispatch.cs_ShipmentStatus_Template, &
		gc_Dispatch.cs_ShipmentStatus_Cancelled, &
		gc_Dispatch.cs_ShipmentStatus_Quoted, &
		gc_Dispatch.cs_ShipmentStatus_Pending, &
		gc_Dispatch.cs_ShipmentStatus_Open

		RETURN 1

END CHOOSE


ll_ItemCount = of_GetItemList ( lnva_Items )
ll_EventCount = of_GetEventList ( lnva_Events )

IF IsNull ( ll_ItemCount ) OR &
	IsNull ( ll_EventCount ) THEN

	as_Message = "Error validating shipment status.~n"
	RETURN -1

END IF



//Check for Shipment Type

IF lnv_numerical.of_IsNullOrNotPos ( of_GetType ( ) ) THEN
	lia_Problems [ 18 ] = 1
END IF



//Check for Ship Date or pre note date 
//IF lb_intermodal THEN
//	IF IsNull ( of_GetPrenoteDate ( ) ) THEN
//		lia_Problems [ 12 ] = 1
//	END IF
//ELSE
	IF IsNull ( of_GetShipDate ( ) ) THEN
		lia_Problems [ 12 ] = 1
	END IF
//END IF



//Check for billto
IF of_HasBillto ( ) = FALSE THEN
	lia_Problems [ 9 ] = 1
END IF



//Check for billing total

IF This.of_GetNetCharges ( ) > 0 THEN
	//There is a billing total
ELSE
	lia_Problems [ 10 ] ++
END IF



//Check that there are items in the shipment

IF lnv_numerical.of_IsNullOrNotPos ( ll_ItemCount ) THEN
	lia_Problems [ 7 ] = 1
END IF



//Check that Freight Items have a pickup and delivery event specified
//Check that all items have a description
//If billing format is by item, check that all items have amounts

FOR ll_Ndx = 1 TO ll_ItemCount

	IF ll_EventCount > 1 THEN

		//The ll_EventCount > 1 condition was added in 2.5.02 to allow shipments without full
		//routing (zero or one events) but with freight items to be authorized.
		IF NOT lb_Intermodal THEN
			IF lnva_Items [ ll_Ndx ].of_IsFreight ( )  THEN
				IF lnva_Items [ ll_Ndx ].of_IsFullyAssigned ( ) = FALSE THEN
					lia_Problems [ 1 ] ++
				END IF
			END IF
		END IF

	END IF
	
	
	IF lnva_Items [ ll_Ndx ].of_HasDescription ( ) = FALSE THEN
		lia_Problems [ 5 ] ++
	END IF


	IF of_GetBillingFormat ( ) = cs_BillingFormat_Item THEN
		IF lnva_Items [ ll_Ndx ].of_GetBillingAmount ( ) > 0 OR &  
			lnva_Items [ ll_Ndx ].of_GetAccountingType ( ) = n_cst_constants.cs_accountingtype_payable THEN
			//Item has a billing amount OR we don't care B/C it is a payable type
		ELSE		
			lia_Problems [ 6 ] ++
		END IF
	END IF

NEXT


//If any events are unconfirmed, check whether event Confirmations are required to restrict.
lia_Problems [ 3 ] = of_GetUnconfirmedEventCount ( )

IF lia_Problems [ 3 ] > 0 THEN

	CHOOSE CASE of_AllowRestrictActive ( )
	CASE TRUE
		//Unconfirmed events are not a problem.  Clear the flag.
		lia_Problems [ 3 ] = 0
	CASE FALSE
		//Unconfirmed events are a problem.  Leave the flag in place.
	CASE ELSE
		//Could not determine setting.
		as_Message = "Error validating shipment status.~n"
		RETURN -1
	END CHOOSE

END IF



//Check that all events have sites specified

FOR ll_Ndx = 1 TO ll_EventCount
	IF lnva_Events [ ll_Ndx ].of_HasSite ( ) = FALSE THEN
		lia_Problems [ 2 ] ++
	END IF
NEXT


IF of_IsBrokerage ( ) THEN
	IF of_HasTrip ( ) = FALSE THEN
		lia_Problems [ 13 ] = 1
	ELSEIF of_HasCarrier ( ) = FALSE THEN
		lia_Problems [ 14 ] = 1
	END IF
END IF


//
FOR i = 1 TO 18 
	IF lnv_Numerical.of_GetBit ( aul_exclude , i ) THEN
		 lia_problems[i] = 0 // clear it
	END IF
NEXT
//


if lia_problems[18] > 0 then &
	as_Message += "The shipment type has not been specified~n"
if lia_problems[13] > 0 then &
	as_Message += "The shipment has not been assigned to a trip~n"
if lia_problems[14] > 0 then &
	as_Message += "A carrier has not been selected for the assigned trip~n"
if lia_problems[1] > 0 then &
	as_Message += string(lia_problems[1]) + " freight item(s) do not have a pickup and/or "+&
		"delivery assigned~n"
if lia_problems[2] > 0 then &
	as_Message += string(lia_problems[2]) + " event(s) have no site specified~n"
if lia_problems[3] > 0 then &
	as_Message += string(lia_problems[3]) + " event(s) have not been confirmed as completed~n"
if lia_problems[5] > 0 then &
	as_Message += string(lia_problems[5]) + " item(s) have no description~n"
if lia_problems[7] > 0 then &
	as_Message += "There are no items specified for the shipment~n"
if lia_problems[9] > 0 then &
	as_Message += "The billto company has not been selected~n"
	
if lia_problems[12] > 0 then 
	IF THIS.of_IsIntermodal ( ) THEN
//		IF THIS.of_GetMoveCode ( ) = "I" THEN
//			as_Message += "The Last Free Date has not been specified~n"	
//		ELSE
//			as_Message += "The Pickup By Date has not been specified~n"	
//		END IF
	ELSE
		as_Message += "The ship date has not been specified~n"
	END IF
END IF

IF Len ( as_Message ) > 0 THEN
	lb_Invalid = TRUE
END IF


if lia_problems[6] > 0 then &
	as_Message += string(lia_problems[6]) + " item(s) have no charges specified (optional)~n"
	
if lia_problems[10] > 0 then &
	as_Message += "There is no billing total (optional)~n"
	
//if lia_problems[15] > 0 then &
//	as_Message += "The assigned trip is currently using the automatic payables format, "+&
//		"but this shipment has no payables total (optional)~n"
//if lia_problems[16] > 0 then &
//	as_Message += "There is no payables total for this shipment, and the payables format "+&
//		"of the assigned trip could not be verified (optional)~n"


///////////// BEGIN KLUGE FOR DAYBREAK
n_cst_LicenseManager	lnv_licensemanager 
String	ls_TempErrSting
Int	li_Return
IF  lnv_LicenseManager.of_GetLicensedCompany ( ) = "DAYBREAK EXPRESS INCORPORATED" THEN
	IF THIS.of_GetBillto( ) = 8079 and ( as_status =  gc_Dispatch.cs_ShipmentStatus_Authorized OR as_status =  gc_Dispatch.cs_ShipmentStatus_Audited ) THEN
		li_Return = THIS.of_klugevalidation( ls_TempErrSting )
		
		IF li_Return = -1 THEN
			as_message += "~r~n" + ls_TempErrSting
			lb_Invalid = TRUE		
		END IF
		IF li_Return = 0 THEN
			as_message += "~r~n**Warning~r~n" + ls_TempErrSting
		
		END IF
	END IF
END IF
////////////// TEMPORY KLUGE FOR DAYBREAK END



FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_Events[ i ] )
NEXT

FOR i = 1 TO ll_ItemCount
	DESTROY ( lnva_Items [i] )
NEXT

IF Len ( as_Message ) > 0 THEN

	IF lb_Invalid THEN
		RETURN -2
	ELSE
		RETURN -3
	END IF

ELSE
	RETURN 1

END IF

end function

public function long of_geteventlist (ref n_cst_beo_event anva_events[]);//Returns : The number of events in the shipment, or null if the list cannot be determined

Long	ll_Row, &
		ll_RowCount, &
		ll_CandidateEventCount, &
		ll_CrossDockEventCount, &
		ll_ExcludeEventCount, &
		ll_FinalEventCount, &
		ll_ShipmentId, &
		lla_CandidateRows[], &
		lla_CrossDockRows[], &
		lla_ExcludeRows[], &
		lla_FinalRows[], &
		ll_Index, &
		ll_CrossDockIndex, &
		ll_Null
Integer		li_DeliveryModeStopIndex
String		ls_Find
String 		ls_DataObject
Long			i
Long			lla_EventIDS[]
Long			ll_FilterCount
PowerObject	lpo_Source
n_cst_Dws	lnv_Dws
n_cst_beo_Event	lnv_Event, &
						lnva_EventList[] //, &
//						lnva_EmptyList[] *Dropped this due to auto-instantiate overhead

Boolean		lb_DeliveryMode, &
				lb_ExcludeCrossDock
DataStore	lds_Copy
n_cst_Crossdock	lnv_Crossdock
n_cst_AnyArraySrv	lnv_Arrays
n_cst_shipmentManager	lnv_ShipmentManager

lnv_Event = CREATE n_cst_beo_Event


Int	li_Count
li_Count = UpperBound( anva_events[] )
FOR i = 1 TO li_Count 
	DESTROY ( anva_events[i] )
NEXT


//If an EventListLock has been set, and the list has previously been determined, use the
//pre-determined event list.  Otherwise, determine it now.

//IF Len ( is_EventListLock ) > 0 AND ib_EventListReady THEN
//
//	anva_Events = inva_EventList
//	ll_FinalEventCount = UpperBound ( anva_Events )
//
//ELSE

	SetNull ( ll_Null )
	
	lb_DeliveryMode = This.of_GetDeliveryModeStop ( li_DeliveryModeStopIndex )
	lb_ExcludeCrossDock = This.of_GetExcludeCrossDock ( )


	ll_ShipmentId = This.of_GetSourceId ( )
	
	lpo_Source = This.of_GetEventSource ( )
	ll_RowCount = lnv_Dws.of_Rowcount ( lpo_Source )
	ll_FilterCount = lnv_Dws.of_Filteredcount ( lpo_Source )
	
	ls_DataObject = lnv_Dws.of_GetDataObject ( lpo_Source )
	
	// in some cases the lpo_Source is created by syntax and will not have a 
	// dataobject. so this has to be done
	IF Len ( ls_DataObject ) > 0 THEN
		lds_Copy = CREATE DataStore
		lds_Copy.DataObject = ls_DataObject
	ELSE
		lds_Copy =	lnv_ShipmentManager.of_CreateEventDataStore ( FALSE )
	END IF

	// make a copy of the data so it can be filtered and sorted
	lnv_Dws.of_RowsCopy ( lpo_Source, 1, ll_RowCount, Primary!, lds_Copy, 9999, Primary! )
	lnv_Dws.of_rowscopy ( lpo_Source, 1, ll_FilterCount, FILTER!, lds_Copy ,99999, PRIMARY! )
	
	lds_Copy.SetFilter ( "de_Shipment_Id = " + String ( ll_ShipmentId ) ) 
	lds_Copy.Filter ( ) 
	
	lds_Copy.SetSort ( "de_ship_seq A" )
	lds_Copy.Sort ( )
	
		
	ll_CandidateEventCount = lds_Copy.RowCount ( ) 
	
	// this was a patch to keep development moving. It can and sould be addressed later
	FOR i = 1 TO ll_CandidateEventCount
		lla_CandidateRows[ i ] = i 
	
	NEXT
		


	IF lb_ExcludeCrossDock AND ll_CandidateEventCount > 0 THEN

		lnv_CrossDock = CREATE n_cst_CrossDock
		
		IF lnv_CrossDock.of_Ready ( ) THEN

			ll_CrossDockEventCount = lnv_CrossDock.of_GetDockRows ( lds_Copy, lla_CrossDockRows )
	
			IF ll_CrossDockEventCount > 0 THEN
				ll_ExcludeEventCount = ll_CrossDockEventCount
				lla_ExcludeRows = lla_CrossDockRows
			END IF

		ELSE
			//Couldn't load crossdock settings.  Fail.
			SetNull ( ll_FinalEventCount )

		END IF

	END IF


	IF NOT IsNull ( ll_FinalEventCount ) THEN

		IF lb_DeliveryMode AND ll_CandidateEventCount > 0 AND NOT IsNull ( li_DeliveryModeStopIndex ) THEN

			//Note : If li_DeliveryStopModeIndex is not REALLY a delivery, ALL the deliveries will be hidden.
			//No error will be issued.

			lnv_Event.of_SetSource ( lds_Copy )

			FOR ll_Index = 1 TO ll_CandidateEventCount

				IF ll_Index = li_DeliveryModeStopIndex THEN
					//This is the delivery we want to keep.  Pass over it.
					CONTINUE
				ELSE
					//Point the beo to the current loop row
					lnv_Event.of_SetSourceRow ( ll_Index )

					//If the cuurent loop event is a delivery, we want to exclude it
					IF lnv_Event.of_IsDeliverGroup ( ) THEN
						//Add the row index to the exclude list
						//Note : This may double up some entries from exclude crossdock, but that's ok
						ll_ExcludeEventCount ++
						lla_ExcludeRows [ ll_ExcludeEventCount ] = ll_Index
					END IF
				END IF
				
			NEXT

		END IF

	END IF


	IF NOT IsNull ( ll_FinalEventCount ) THEN

		IF ll_ExcludeEventCount > 0 THEN

			FOR ll_Index = 1 TO ll_CandidateEventCount

				IF lnv_Arrays.of_FindLong ( lla_ExcludeRows, ll_Index, 1, ll_ExcludeEventCount ) > 0 THEN
					//It's an excluded event -- skip it
					CONTINUE
				ELSE
					ll_FinalEventCount ++
					lla_FinalRows [ ll_FinalEventCount ] = lla_CandidateRows [ ll_Index ]
				END IF

			NEXT

		ELSE
			ll_FinalEventCount = ll_CandidateEventCount
			lla_FinalRows = lla_CandidateRows
	
		END IF

	END IF

	FOR i = 1 TO ll_FinalEventCount 
		lla_EventIDs [ i ] = lds_Copy.Object.de_id [lla_FinalRows [ i ] ]
	NEXT



	IF NOT IsNull ( ll_FinalEventCount ) THEN

		FOR ll_Index = 1 TO ll_FinalEventCount
			lnva_EventList [ ll_Index ] = CREATE n_cst_beo_Event
			lnva_EventList [ ll_Index ].of_SetSource ( lpo_Source )
//			lnva_EventList [ ll_Index ].of_SetSourceRow ( lla_FinalRows [ ll_Index ] )
			lnva_EventList [ ll_Index ].of_SetSourceID ( lla_EventIDs [ ll_Index ] )
			lnva_EventList [ ll_Index ].of_SetShipment ( This )
			lnva_EventList [ ll_Index ].of_setcontext( THIS.of_GetContext ( ) )
	
		NEXT
	

		anva_Events = lnva_EventList
	
	
		IF ll_RowCount >= 0 THEN
	
			//If an EventListLock has been set, set the EventListReady flag to indicate
			//that the list has been successfully determined and may be reused during the
			//lock session. 
	
//			IF Len ( is_EventListLock ) > 0 THEN
//				ib_EventListReady = TRUE
//			END IF
	
		ELSE  //The event list couldn't be determined.  Return Null.
			SetNull ( ll_FinalEventCount )
	
		END IF

	END IF

//END IF

DESTROY ( lnv_Event ) 
DESTROY lds_Copy

RETURN ll_FinalEventCount
end function

private function integer of_prevalidateeventremoval (n_cst_beo_event anva_events[]);Long	ll_EventListCount
Long	i, j
Long	lla_BadEvents[]
Long	li_Return 

n_cst_beo_Event	lnva_EventList[]
n_cst_Beo_Event	lnv_CurrentEvent

lnva_EventList = anva_events[]

ll_EventListCount = UpperBound ( lnva_EventList )

// check to see if the events can be deleted w/o problems
FOR i = 1 TO ll_EventListCount
	
	lnv_CurrentEvent = lnva_EventList[ i ]
	// i need to add the check to if the event is routed
	IF	lnv_CurrentEvent.of_isConfirmed ( ) OR lnv_CurrentEvent.of_IsRouted ( )  THEN
		lla_BadEvents [ upperBound ( lla_BadEvents ) + 1 ] = lnv_CurrentEvent.of_GetID ( )
	END IF
	
NEXT 

CHOOSE CASE UpperBound ( lla_BadEvents )
		
	CASE 0 
		li_Return = 1
		
	CASE ELSE
		li_Return = -1
END CHOOSE



RETURN li_Return
end function

public function string of_getnotificationtemplate ();String	ls_Template
Any		la_Value
n_cst_Settings	lnv_Setting

ls_Template = This.of_GetValue ( "notificationtemplate", TypeString! )

IF Len ( ls_Template ) > 0 THEN
	
ELSE
	IF lnv_Setting.of_GetSetting ( 110 , la_Value ) = 1 THEN
		ls_Template = String ( la_Value )
	END IF
END IF

RETURN ls_Template
end function

public function integer of_setnotificationtemplate (string as_Value);RETURN THIS.of_SetAny ( "notificationtemplate" ,as_Value)
end function

public function int of_setnetcharge (dec ac_Value);RETURN This.of_SetAny ( "ds_bill_charge", ac_Value )
end function

public function integer of_setbillingformat (string as_Value);RETURN THIS.of_SetAny ( "ds_bill_format" , as_Value )
end function

public function int of_setrequiredequipment (string as_Value);RETURN This.of_SetAny ( "ds_equip_req", as_Value )
end function

public function integer of_setimportreference (string as_Value);RETURN THIS.of_SetAny ( "edireference" , as_Value )
end function

public function string of_getimportreference ();RETURN THIS.of_GetValue ( "edireference" , TypeString! )
end function

public function integer of_setdiscountamount (decimal ac_value);Int	li_ReturnValue = -1

THIS.of_SetAny ( "ds_disc_pct" ,0) 

IF THIS.of_SetAny ( "ds_disc_amt" ,ac_value) = 1 THEN
	IF	THIS.of_Calculate ( ) = 1 THEN
		li_ReturnValue = 1
	END IF
END IF


// we are not going to recalc when they enter the discount. this will
// give them a way to regulate if the discount applies to the FSC
//IF li_ReturnValue = 1 THEN
//	THIS.of_Recalcexistingsurcharges( )
//END IF

RETURN li_ReturnValue


end function

public function integer of_setfreightamount (decimal ac_value);Int	li_ReturnValue = -1

IF THIS.of_SetAny ( "ds_lh_totamt" ,ac_value) = 1 THEN
	IF	THIS.of_Calculate ( ) = 1 THEN
		li_ReturnValue = 1
	END IF
END IF

RETURN li_ReturnValue
end function

public function integer of_setaccessorialamount (decimal ac_value);Int	li_ReturnValue = -1

IF THIS.of_SetAny ( "ds_ac_totamt" ,ac_value) = 1 THEN
	IF	THIS.of_Calculate ( ) = 1 THEN
		li_ReturnValue = 1
	END IF
END IF

RETURN li_ReturnValue
end function

public function integer of_getnotificationtargets (ref long ala_targets[]);//Int		li_Return = -1
//Long		ll_RowCount
//Long		i
//Long		lla_ContactIds[]
//
//DataStore	lds_note
//lds_Note = CREATE DataStore
//lds_Note.DataObject = "d_notification"
//lds_Note.SetTransObject ( SQLCA )							  			  							 
//
//
//lds_Note.object.datawindow.table.select = "SELECT * FROM notification where shipmentid = " + String ( THIS.of_GetID ( ) )
//
//ll_RowCount = lds_Note.Retrieve ( )
//FOR i = 1 TO ll_RowCount 
//	lla_ContactIds [i] = lds_Note.GetItemNumber ( i , "contactid" )
//NEXT
//
//ala_Targets[] = lla_ContactIds
//
//Destroy ( lds_Note )
CHOOSE CASE THIS.of_GEtDocumentType ( )
		
	CASE appeon_constant.cs_acc
		THIS.of_getAccNoteContacts ( ala_Targets )
		
	CASE appeon_constant.cs_authout
		THIS.of_getAccAuthContacts ( ala_Targets )
		
	CASE appeon_constant.cs_event
		THIS.of_getEventContacts ( ala_Targets )
		
	CASE appeon_constant.cs_lfd
		THIS.of_getLastFreeDateContacts ( ala_Targets )
		
	CASE appeon_constant.cs_loadconfirmation
		THIS.of_getShipmentContacts ( ala_Targets )
	
		
END CHOOSE 
		


RETURN UpperBound ( ala_Targets[] )
end function

public function integer of_setaccnotecontacts (long ala_contacts[]);String			ls_Result
n_cst_String	lnv_String


lnv_String.of_ArrayToString ( ala_contacts , "," , ls_Result )

RETURN THIS.of_SetAny ("accnotecontacts", ls_Result  )
end function

public function integer of_setaccauthcontacts (long ala_contacts[]);String			ls_Result
n_cst_String	lnv_String


lnv_String.of_ArrayToString ( ala_contacts , "," , ls_Result )

RETURN THIS.of_SetAny (  "accauthcontacts" , ls_Result  )
end function

public function integer of_setlastfreedatecontacts (long ala_contacts[]);String			ls_Result
n_cst_String	lnv_String


lnv_String.of_ArrayToString ( ala_contacts , "," , ls_Result )

RETURN THIS.of_SetAny ( "lfdcontacts" , ls_Result )
end function

public function integer of_getlastfreedatecontacts (ref long ala_contacts[]);n_cst_string	lnv_String
Int				li_return = 0
Long				lla_Contacts[]
String			ls_Contacts


ls_Contacts = THIS.of_GetValue ( "lfdcontacts" , TYPESTRING! )

IF Not IsNull ( ls_Contacts ) THEN
	lnv_String.of_ParseToArray ( ls_Contacts , "," , lla_Contacts )
	
	ala_Contacts = lla_Contacts
	
	li_Return = UpperBound ( ala_Contacts )
	
END IF

RETURN li_Return

end function

public function integer of_geteventcontacts (ref long ala_contacts[]);// RDT 6-09-03 This should NOT be used. Event Contacts are on the Event, not the shipment.
//MessageBox("RICH","beo_shipment.of_GetEventContacts called in error")
//n_cst_string	lnv_String
Int				li_return = 0
//Long				lla_Contacts[]
//String			ls_Contacts
//
//
//ls_Contacts = THIS.of_GetValue ( "eventcontacts" , TYPESTRING! )
//
//IF Not IsNull ( ls_Contacts ) THEN
//	lnv_String.of_ParseToArray ( ls_Contacts , "," , lla_Contacts )
//	
//	ala_Contacts = lla_Contacts
//	
//	li_Return = UpperBound ( ala_Contacts )
//	
//END IF
//

RETURN li_Return

end function

public function int of_getaccnotecontacts (ref long ala_Contacts[]);n_cst_string	lnv_String
Int				li_return = 0
Long				lla_Contacts[]
String			ls_Contacts


ls_Contacts = THIS.of_GetValue ( "accnotecontacts" , TYPESTRING! )

IF Not IsNull ( ls_Contacts ) THEN
	lnv_String.of_ParseToArray ( ls_Contacts , "," , lla_Contacts )
	
	ala_Contacts = lla_Contacts
	
	li_Return = UpperBound ( ala_Contacts )
	
END IF

RETURN li_Return
end function

public function int of_getaccauthcontacts (ref long ala_Contacts[]);n_cst_string	lnv_String
Int				li_return = 0
Long				lla_Contacts[]
String			ls_Contacts


ls_Contacts = THIS.of_GetValue ( "accauthcontacts" , TYPESTRING! )

IF Not IsNull ( ls_Contacts ) THEN
	lnv_String.of_ParseToArray ( ls_Contacts , "," , lla_Contacts )
	
	ala_Contacts = lla_Contacts
	
	li_Return = UpperBound ( ala_Contacts )
	
END IF

RETURN li_Return
end function

public function integer of_getshipmentcontacts (ref long ala_Contacts[]);n_cst_string	lnv_String
Int				li_return = 0
Long				lla_Contacts[]
String			ls_Contacts


ls_Contacts = THIS.of_GetValue ( "shipmentcontacts" , TYPESTRING! )

IF Not IsNull ( ls_Contacts ) THEN
	lnv_String.of_ParseToArray ( ls_Contacts , "," , lla_Contacts )
	
	ala_Contacts = lla_Contacts
	
	li_Return = UpperBound ( ala_Contacts )
	
END IF

RETURN li_Return

end function

public function integer of_setshipmentcontacts (long ala_contacts[]);String			ls_Result
n_cst_String	lnv_String


lnv_String.of_ArrayToString ( ala_contacts , "," , ls_Result )

RETURN THIS.of_SetAny ( "shipmentcontacts" , ls_Result )
end function

public function integer of_seteventcontacts (long ala_contacts[]);String			ls_Result
n_cst_String	lnv_String


lnv_String.of_ArrayToString ( ala_contacts , "," , ls_Result )

RETURN THIS.of_SetAny ("eventcontacts" , ls_Result )
end function

public function long of_getitemlist (ref n_cst_beo_item anva_item[], string as_type);/*	cs_ItemType_Freight, cs_ItemType_Accessorial

	Call overloaded method and then filter list down to type passed
	in argument.
			
	Return - item beos by reference
			 - number of items
*/
long		ll_index, &
			ll_ItemCount, &
			ll_typecount
			
n_cst_beo_item		lnva_Item[], &
						lnva_itembytype[]

ll_ItemCount = this.of_GetItemList(lnva_Item)

for ll_index = 1 to ll_itemcount
	
	if lnva_item[ll_index].of_Gettype () = as_type then
		ll_typecount ++
		lnva_ItemByType[ll_typecount] = lnva_Item[ll_Index]
	ELSE
		DESTROY ( lnva_Item[ll_Index] )
	end if
next		

if ll_TypeCount > 0 then
	anva_item = lnva_itembytype
end if

return ll_typecount
end function

public function integer of_addleasecharges (n_cst_bso_dispatch anv_dispatch, n_cst_msg anv_msg);Int		li_Return
Int		li_PeriodNdx
Int		li_PeriodCount
Long		ll_EventCount
Long		i
Long		ll_ItemID
Any		la_Setting
Dec		ldec_Charges
Boolean	lb_Continue = TRUE
String	ls_DateOut
String	ls_DateIn
String	ls_EquipType
String   ls_RefNum
String	ls_Description
String	ls_FTX
String	ls_OutOrNotify
Long		ll_CoID
Long		ll_AMountType
String	lsa_RateList[]
String	ls_RateCodeName
String	ls_RateDescription
String	ls_ChargeFormat = "TOTAL!"
String	ls_BillingFormat
Date		ld_DateOut
Date		ld_DateIN
Date		ld_OverrideOut
Date		ld_OverrideIN
Date		ld_FTX
Time		lt_FTX
Boolean	lb_OverRideOut
Boolean	lb_OverRideIN

Constant	String	cs_FlatRateType = appeon_constant.cs_rateunit_code_flat
Constant	String	cs_UnitRateType = appeon_constant.cs_rateunit_code_perUnit

n_Cst_EquipmentManager			lnv_EqManager
n_cst_leaseCharges				lnv_LeaseCharges
n_cst_bso_Rating					lnv_Rating
n_cst_RateData						lnv_RateData
n_cst_beo_Item						lnv_NewItem
n_cst_Beo_EquipmentLease		lnv_CurrentLease
n_cst_beo_EquipmentLease		lnva_Lease[]
n_cst_beo_EquipmentLeasetype	lnv_LeaseType
n_cst_beo_Equipment				lnv_Equipment
n_cst_bso_Dispatch				lnv_Dispatch
n_cst_Beo_Event					lnva_Events [] 
n_cst_Msg							lnv_msg
S_Parm								lstr_parm
n_cst_Settings						lnv_Setting

lnv_NewItem = CREATE n_cst_beo_Item
lnv_Rating = CREATE n_cst_bso_Rating
lnv_RateData = CREATE n_cst_RateData

lnv_msg = anv_Msg

IF lnv_Setting.of_getsetting (144 , la_Setting ) = 1 THEN
	ls_ChargeFormat = String ( la_Setting )
END IF

IF lb_Continue THEN
	IF lnv_Msg.of_Get_Parm ( "BEOS" , lstr_Parm ) <> 0 THEN
		lnva_Lease = lstr_Parm.ia_Value
	ELSE
		lb_Continue = FALSE
	END IF
END IF

/* */
IF lb_Continue THEN
	IF lnv_Msg.of_Get_Parm ( "DATEOUT" , lstr_Parm ) <> 0 THEN
		ld_OverrideOut = lstr_Parm.ia_Value
		lb_OverRideOut = TRUE
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "DATEIN" , lstr_Parm ) <> 0 THEN
		ld_OverrideIN = lstr_Parm.ia_Value
		lb_OverRideIN = TRUE
	END IF
	
END IF
	
/* */

ls_BillingFormat = THIS.of_GetBillingFormat ()
ll_CoID = THIS.of_GetBillTo ( )

IF lb_Continue THEN
	For i = 1 TO UpperBound ( lnva_Lease )
		
		lnv_CurrentLease = lnva_Lease[i]
		lnv_Equipment = lnv_CurrentLease.of_GetEquipment ( ) 
		
		ls_EquipType = lnv_Equipment.of_GetType ( )
		CHOOSE CASE Upper ( ls_EquipType )
			CASE lnv_EqManager.cs_CNTN 
				ls_EquipType = "CONTAINER PER DIEM CHARGES"
			CASE lnv_EqManager.cs_CHAS
				ls_EquipType = "CHASSIS RENTAL CHARGES"
			CASE lnv_EqManager.cs_TRLR 
				ls_EquipType = "TRAILER PER DIEM CHARGES"
			CASE lnv_EqManager.cs_RBOX
				ls_EquipType = "RAIL BOX PER DIEM CHARGES"
			CASE lnv_EqManager.cs_FLBD 
				ls_EquipType = "FLAT BED LEASE CHARGES"
			CASE lnv_EqManager.cs_REFR
				ls_EquipType = "REFER LEASE CHARGES"
			CASE lnv_EqManager.cs_TANK
				ls_EquipType = "TANKER LEASE CHARGES"				
			CASE ELSE
				ls_EquipType = "LEASE CHARGES"
		END CHOOSE
				
		
		ls_RefNum = lnv_Equipment.of_GetNumber ( )
		lnv_LeaseType = lnv_CurrentLease.of_Getequipmentleasetype( )
		/* */
		IF lb_OverRideOut THEN
			ld_DateOut = ld_OverRideOut			
			// get the ftx for the override date out
			
			IF isValid ( lnv_LeaseType ) THEN
				lnv_LeaseType.of_GetFreetimeexpiration( ld_DateOut , TIME ( lnv_CurrentLease.of_gettimeout( ) )  , ld_FTX ,lt_FTX )
			END IF
			
		ELSE
			ld_DateOut = Date ( 	lnv_CurrentLease.of_GetTimeOut ( ) )
			ld_FTX = Date ( lnv_CurrentLease.of_GetFreeTimeExpiration ( ) ) 
			
		END IF
		
		IF lb_OverRideIn THEN
			ld_DateIn = ld_OverRideIn
		ELSE
			ld_DateIn = Date ( lnv_CurrentLease.of_GetTimeIn ( ) )
		END IF
		
		/* */
		ls_DateOut = String ( ld_DateOut )
		IF IsNull ( ls_DateOut ) THEN ls_DateOut = " "
		ls_DateIN = String ( ld_DateIn )
		IF IsNull ( ls_DateIN ) THEN ls_DateIN = " "
		ls_FTX = String ( ld_FTX  )
		IF isNull ( ls_FTX ) THEN ls_FTX = " "

		IF isValid ( lnv_LeaseType ) THEN
			IF lnv_LeaseType.of_GetFreetimeStart ( ) = 1 THEN
				ls_OutOrNotify = "RELEASED:"
			ELSE
				ls_OutOrNotify = "OUT:"
			END IF
		END IF
		
		CHOOSE CASE ls_ChargeFormat 
				
			CASE "TOTAL!"
				
				IF isValid ( lnv_LeaseType ) THEN		
					lnv_LeaseType.of_GetCharges( ld_DateOut , Time ( lnv_CurrentLease.of_gettimeout( ) ) , ld_DateIn ,  Time ( lnv_CurrentLease.of_gettimeIn( ) ) , ldec_Charges )
				END IF				
						
				//ldec_Charges = lnv_CurrentLease.of_GetCharges ( )								
							
				
				
				
				IF lnv_LeaseType.of_GetFreetimeperiod( ) > 0 THEN  // mention the LFD 
					ls_Description =  ls_EquipType +" - " + ls_OutOrNotify + " " + ls_DateOut  & 
											+ " - IN: " + ls_DateIn + " - LFD: " + ls_FTX + " - $" + String ( ldec_Charges )
				ELSE  // don't even talk about the FTX
					ls_Description =  ls_EquipType +" - " + ls_OutOrNotify + " " + ls_DateOut  & 
											+ " - IN: " + ls_DateIn + " - $" + String ( ldec_Charges )
				END IF
											
				
				
				
				ll_ItemID = THIS.of_AddItem ( "ACCESS!" , anv_Dispatch )
				
				IF ll_ItemID <= 0 THEN
					lb_Continue = FALSE
				END IF
		
				IF lb_Continue THEN
								
					// lnv_NewItem is the target shipment item the properties will be set on
					lnv_NewItem.of_SetSource 		( anv_Dispatch.of_GetItemCache ( ) )
					lnv_NewItem.of_SetSourceID 	( ll_ItemID )
					lnv_NewItem.of_SetShipment 	( THIS )
					IF ls_BillingFormat =  "G" THEN  // grand total
						THIS.of_SetNetCharge ( THIS.of_GetNetCharges ( ) + ldec_Charges )
					ELSEIF ls_BillingFormat =  "L" THEN  // Freight and acc amnts
						THIS.of_SetNetCharge ( THIS.of_GetNetCharges ( ) + ldec_Charges )
						this.of_setaccessorialamount ( this.of_getaccessorialcharges ( ) + ldec_Charges )
					ELSE
						lnv_NewItem.of_SetRateType 	( cs_FlatRateType )
						lnv_NewItem.of_SetAmount 		( ldec_Charges )
					END IF
					lnv_NewItem.of_SetRefNum 		( ls_RefNum )
					
					// Get Rate Code
					IF lnv_Rating.of_GetCodeDefaultList ( ll_CoID , appeon_constant.cl_PerDiem_list , lsa_RateList ) > 0 THEN	
						lnv_RateData.of_SetCodeName ( lsa_RateList[1] )				
						ll_AmountType = lnv_Rating.of_GetAmountType ( lnv_RateData )
						ls_RateCodeName = lsa_RateList[1]
						ls_RateDescription = lnv_Rating.of_GetRateDescription ( lnv_RateData )
					END IF
			
					IF ll_AmountType > 0 THEN
						lnv_NewItem.of_SetAmountType ( ll_AmountType )
					END IF
				
					IF ls_RateCodeName <> "" THEN
						lnv_NewItem.of_SetRateCodeName ( ls_RateCodeName )
					END IF
					
					IF Len ( ls_RateDescription ) > 0 THEN
						ls_Description = ls_RateDescription 
					END IF
			
					lnv_NewItem.of_SetEventTypeFlag ( n_Cst_Constants.cs_ItemEventType_PerDiem )
					lnv_NewItem.of_SetDescription ( ls_Description )
								
				END IF
								
			CASE "BYPERIOD!"
				
				IF isValid ( lnv_LeaseType ) THEN		
					lnv_LeaseType.of_GetCharges( ld_DateOut , Time ( lnv_CurrentLease.of_gettimeout( ) ) , ld_DateIn ,  Time ( lnv_CurrentLease.of_gettimeIn( ) ) , lnv_LeaseCharges )
				END IF	
				
				//lnv_CurrentLease.of_GetCharges ( lnv_LeaseCharges )
				IF isValid ( lnv_LeaseCharges ) THEN																				
					
					ldec_Charges = lnv_LeaseCharges.of_GetTotalCharges ( )
					
					//ls_Description =  ls_EquipType +" - " + ls_OutOrNotify + " " + ls_DateOut  & 
					//						+ " - IN: " + ls_DateIn + " - LFD: " + ls_FTX + " - $" + String ( ldec_Charges )
												
					IF lnv_LeaseType.of_GetFreetimeperiod( ) > 0 THEN  // mention the LFD 
						ls_Description =  ls_EquipType +" - " + ls_OutOrNotify + " " + ls_DateOut  & 
												+ " - IN: " + ls_DateIn + " - LFD: " + ls_FTX + " - $" + String ( ldec_Charges )
					ELSE  // don't even talk about the FTX
						ls_Description =  ls_EquipType +" - " + ls_OutOrNotify + " " + ls_DateOut  & 
												+ " - IN: " + ls_DateIn + " - $" + String ( ldec_Charges )
					END IF
				
				
					li_PeriodCount  = lnv_LeaseCharges.of_GetChargePeriods ()
					FOR li_PeriodNdx = 1 TO li_PeriodCount
						
						ldec_Charges = lnv_LeaseCharges.of_GetCharges ( li_PeriodNdx  )
						
						IF li_PeriodNdx = 1 THEN				
							ls_Description += " " + lnv_LeaseCharges.of_GetPeriodRange ( li_PeriodNdx) 
						ELSE
							ls_Description = 	lnv_LeaseCharges.of_GetPeriodRange ( li_PeriodNdx) 
						END IF
						
						ll_ItemID = THIS.of_AddItem ( "ACCESS!" , anv_Dispatch )
						
						IF ll_ItemID <= 0 THEN
							lb_Continue = FALSE
						END IF
				
						IF lb_Continue THEN
										
							// lnv_NewItem is the target shipment item the properties will be set on
							lnv_NewItem.of_SetSource 		( anv_Dispatch.of_GetItemCache ( ) )
							lnv_NewItem.of_SetSourceID 	( ll_ItemID )
							lnv_NewItem.of_SetShipment 	( THIS )
							
							IF ls_BillingFormat =  "G" THEN  // grand total
								THIS.of_SetNetCharge ( THIS.of_GetNetCharges ( ) + ldec_Charges )
							ELSEIF ls_BillingFormat =  "L" THEN  // Freight and acc amnts
								THIS.of_SetNetCharge ( THIS.of_GetNetCharges ( ) + ldec_Charges )
								this.of_setaccessorialamount ( this.of_getaccessorialcharges ( ) + ldec_Charges )
							ELSE
								
								lnv_NewItem.of_SetRateType 	( cs_UnitRateType )
								lnv_NewItem.of_SetQuantity ( lnv_LeaseCharges.of_GetQty ( li_PeriodNdx ) )
								lnv_NewItem.of_SetRate ( lnv_LeaseCharges.of_GetRate ( li_PeriodNdx ) )
								
						
							END IF
							
							lnv_NewItem.of_SetRefNum 		( ls_RefNum )
							
							// Get Rate Code
							IF lnv_Rating.of_GetCodeDefaultList ( ll_CoID , appeon_constant.cl_PerDiem_list , lsa_RateList ) > 0 THEN	
								lnv_RateData.of_SetCodeName ( lsa_RateList[1] )				
								ll_AmountType = lnv_Rating.of_GetAmountType ( lnv_RateData )
								ls_RateCodeName = lsa_RateList[1]
								ls_RateDescription = lnv_Rating.of_GetRateDescription ( lnv_RateData )
							END IF
					
							IF ll_AmountType > 0 THEN
								lnv_NewItem.of_SetAmountType ( ll_AmountType )
							END IF
						
							IF ls_RateCodeName <> "" THEN
								lnv_NewItem.of_SetRateCodeName ( ls_RateCodeName )
							END IF
							
							IF Len ( ls_RateDescription ) > 0 THEN
								ls_Description = ls_RateDescription 
							END IF
					
							lnv_NewItem.of_SetEventTypeFlag ( n_Cst_Constants.cs_ItemEventType_PerDiem )
							lnv_NewItem.of_SetDescription ( ls_Description )
							
						END IF
					NEXT
					
				DESTROY (lnv_LeaseCharges) 
	
			END IF
					
		END CHOOSE
							
	NEXT
	
END IF
	

DESTROY ( lnv_NewItem )

FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_Events[ i ] )
NEXT
DESTROY	lnv_Rating
DESTROY	lnv_RateData

IF lb_Continue THEN
	THIS.of_RecalcSurcharges ( )
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_removeitem (long al_itemid, n_cst_bso_dispatch anv_dispatch);Int		li_Return = -1
Boolean	lb_Continue 
Long		ll_ItemID
Long		ll_ItemRow
String	ls_Find
String	ls_OldDocType
dwbuffer	le_Buffer

n_cst_beo_Item	lnv_Item
n_ds				lds_ItemCache

lnv_Item = CREATE n_cst_beo_Item 

lb_Continue = al_itemid > 0 

IF Not isValid ( anv_dispatch ) THEN
	lb_Continue = FALSE
END IF

IF lb_Continue THEN
	lds_ItemCache = anv_Dispatch.of_GetItemCache ( )
	If Not IsValid ( lds_ItemCache ) THEN
		lb_Continue = FALSE
	END IF
END IF

IF lb_Continue THEN
	
	lnv_Item.of_SetSource ( lds_ItemCache )
	lnv_Item.of_SetSourceID ( al_itemid )
	
	IF lnv_Item.of_GetSourceRow ( ll_ItemRow , le_Buffer , FALSE ) <> 1 THEN
		lb_Continue = FALSE
	END IF
END IF
	
//IF lb_Continue THEN
//				We can't do this because we create the item notification as a shipment object with a accnote tag.
//		this way we can send a running total of the acc charges that have been added.
//	ls_OldDocType = lnv_Item.of_GetDocumentType ( ) 
//	lnv_Item.of_setDocumentType ( appeon_constant.cs_acc )	
//	anv_Dispatch.of_GetNotificationManager( ).of_CreatePendingNotification ( THIS )	
//	lnv_Item.of_SetDocumentType ( ls_OldDocType )
//	anv_dispatch.of_GetNotificationManager ( ).of_RemovePendingNotification ( lnv_Item )
//END IF


Int i 
For i = 1 TO 10 
	Yield ( ) 
NEXT
	

IF lb_Continue THEN	
	//	THIS will need to be dealt with later. it was causing a db error without the status being changed
	IF lds_ItemCache.RowCount ( ) > 0 THEN
		lds_ItemCache.SetRow ( 1 ) 
	END IF
	lds_ItemCache.setitemstatus(ll_ItemRow, 0, le_Buffer, notmodified!)
	
	IF lds_ItemCache.RowsMove ( ll_ItemRow , ll_ItemRow, le_Buffer, lds_ItemCache, lds_ItemCache.DeletedCount ( ) + 1 , DELETE! ) <> 1 THEN
		lb_Continue = FALSE
	END IF			
END IF

For i = 1 TO 10 
	Yield ( ) 
NEXT


IF lb_Continue THEN
	THIS.of_Calculate ( )
	THIS.of_CalculatePayable( )
END IF

IF lnv_Item.of_getEventtypeFlag ( ) = n_cst_Constants.cs_ItemEventType_fuelSurcharge THEN
ELSE
	THIS.POST of_RecalcSurcharges ( )
END IF

IF lb_Continue THEN
	li_Return = 1
END IF

DESTROY lnv_Item

IF li_Return = 1 THEN
	THIS.of_Calculatehazmat( )
END IF

RETURN li_Return


end function

public function integer of_removeitems (long ala_ItemIds[], n_cst_bso_Dispatch anv_Dispatch);Long	ll_IdCount
Long	ll_i
Int	li_Return = 1

ll_IdCount = UpperBound ( ala_ItemIds[ ] )

FOR ll_i = 1 TO ll_idCount
	IF THIS.of_RemoveItem ( ala_ItemIDs [ ll_i ] , anv_Dispatch ) <> 1 THEN
		li_Return = -1
	END IF
NEXT

RETURN li_Return
end function

public function long of_getitemcount (string as_Type);n_cst_beo_Item	lnva_Items[]
Int 	li_Index
long	ll_Count

ll_Count = This.of_GetItemList ( lnva_Items , as_Type )

ll_Count = UpperBound ( lnva_Items ) 
FOR li_Index = 1 TO ll_Count
	DESTROY ( lnva_Items [ li_Index ] )
NEXT

RETURN ll_Count
end function

public function integer of_addchassismove (long al_siteid, n_cst_bso_dispatch anv_dispatch, ref long ala_newids[], boolean ab_convertfirst, boolean ab_convertlast);Long	ll_NewID
Long	lla_NewIds[]
Long	ll_EventCount 
Long	i
Boolean	lb_Found
Boolean	lb_ConvertFirst
Boolean	lb_ConvertLast
Boolean	lb_AllowMount
Boolean	lb_AllowDismount
Int	li_NewCount
Int	li_Return = 1
Int	li_Count 
DataStore	lds_Events
n_cst_beo_Event	lnva_EventList[]
n_cst_beo_Event	lnv_CurrentEvent
n_cst_beo_Event	lnv_HookEvent
n_cst_beo_Event	lnv_DropEvent

THIS.of_GetEventList ( lnva_EventList )
ll_EventCount = UpperBound ( lnva_EventList )

// check to see if we are to convert both
lb_ConvertFirst = ab_ConvertFirst
lb_ConvertLast = ab_ConvertLast


//First find the Hook  // and allow filter sets
FOR i = 1 TO ll_EventCount
	lnv_CurrentEvent = lnva_EventList [ i ]
	lnv_CurrentEvent.of_SetAllowFilterSet ( TRUE )
	IF lnv_CurrentEvent.of_GetType( ) = gc_dispatch.cs_EventType_Hook THEN
		lb_Found = TRUE
		EXIT
	END IF
NEXT
		
IF lb_Found THEN
	lnv_HookEvent = lnva_EventList [ i ]
END IF
lb_Found = FALSE

// Then find the Drop
FOR i = ll_EventCount TO 1 STEP -1
	lnv_CurrentEvent = lnva_EventList [ i ]
	IF lnv_CurrentEvent.of_GetType ( ) = gc_dispatch.cs_EventType_Drop THEN
		lb_Found = TRUE
		EXIT
	END IF
NEXT
		
IF lb_Found THEN
	lnv_DropEvent = lnva_EventList [ i ]
END IF	

IF lb_ConvertFirst AND NOT isValid ( lnv_HookEvent ) THEN
	li_Return = -1
END IF

IF lb_ConvertLast AND NOT isValid ( lnv_DropEvent ) THEN
	li_Return = -1
END IF

// now see if they can be switched
IF li_Return = 1 THEN
	lb_AllowMount = lnv_HookEvent.of_AllowMakeMount ( )
	lb_AllowDismount = lnv_DropEvent.of_AllowMakeDisMount ( )
END IF

IF lb_ConvertFirst AND li_Return = 1 THEN
	IF Not lb_AllowMount THEN
		li_Return = -1
		MessageBox ( "Adding a chassis move" , "This request cannot be processed if the Hook event has a trailer/chassis assigned to it or if the event is confirmed." )
	END IF
END IF

//IF lb_ConvertLast AND li_Return = 1  THEN
//	IF Not lb_AllowDismount THEN
//		MessageBox ( "Adding a chassis move" , "This request cannot be processed if the Drop event has a trailer/chassis assigned to it or if the event is confirmed." )		
//		li_Return = -1
//	END IF
//END IF

Int li_SetRtn 
IF li_Return = 1 THEN

	IF lb_ConvertFirst THEN
		// add a hook as the first event
		THIS.of_AddEvent ( gc_dispatch.cs_EventType_Hook , 1 , anv_dispatch , ll_NewID )
		li_Count ++
		lla_NewIds [ li_Count ] = ll_NewID
		
		// switch the hook to a mount
		lnv_HookEvent.of_SetAllowFilterSet( TRUE )
		li_SetRtn = lnv_HookEvent.of_SetType ( gc_Dispatch.cs_EventType_Mount )
		
		THIS.post of_FrontChassisSplitAdded ( anv_Dispatch )	
	
	END IF
	
	IF lb_ConvertLast THEN
		// switch the drop to a dismount
		// then add a drop as the last event
		IF lnv_DropEvent.of_GetConfirmed ( ) <> 'T' THEN
			THIS.of_AddEvent ( gc_dispatch.cs_EventType_DROP , ll_EventCount + 1 + li_count , anv_dispatch , ll_NewID )  // this was ll_eventcount + 2 , 
			li_Count ++ 
			lla_NewIds [ li_Count ] = ll_NewID
			
			IF anv_Dispatch.of_DuplicateRouting ( lnv_DropEvent.of_GetId ( ) , {ll_NewID} , gc_dispatch.ci_insertionstyle_AFTER ) = 1 THEN	 // was before but that was wrong 10.22.03 <<*>>	
				
			END IF
			
			IF anv_dispatch.of_DropToDismount ( lnv_DropEvent.of_GetID ( ) ) <> 1 THEN
				li_Return = -1						
				//	THIS.post of_BackChassisSplitAdded ( anv_Dispatch )	// this just did the routing but the code above does it now
			END IF
			
		ELSE
			MessageBox ( "Adding a chassis move" , "This request cannot be processed if the Drop event is confirmed." )		
			li_Return = -1
			
		END IF
		
	END IF
		
	li_NewCount = UpperBound ( lla_NewIds )
	
	lds_Events = THIS.of_GetEventSource ( )
	lnv_CurrentEvent.of_SetSource ( lds_Events )
	lnv_CurrentEvent.of_SetAllowFilterSet ( TRUE )
	
	FOR i = 1 TO li_NewCount
		
		lnv_CurrentEvent.of_SetSourceID ( lla_NewIds [ i ] )
		lnv_CurrentEvent.of_SetSite ( al_SiteID )
		lnv_CurrentEvent.of_AddCompaniesToEvent() //<<*>>
	
	NEXT
	
END IF

li_Count = UpperBound ( lnva_EventList )
FOR i = 1 TO li_Count 
	DESTROY ( lnva_EventList[i] )
NEXT

ala_newids = lla_NewIds

RETURN li_Return
end function

public function long of_addfrontchassissplititem (n_cst_bso_dispatch anv_dispatch);string	ls_codename

long	ll_ratedatacount, &
		ll_ndx, &
		ll_ItemID
		
n_cst_bso_Dispatch 	lnv_Dispatch
n_cst_beo_Item			lnv_Item

lnv_Item = CREATE n_cst_beo_Item

lnv_Dispatch = anv_Dispatch

ll_ItemID = THIS.of_AddItem ( "L" , lnv_Dispatch )
IF ll_ItemID > 0 THEN
	lnv_Item.of_SetSource ( lnv_Dispatch.of_GetItemCache ( ) )
	lnv_Item.of_SetSourceID ( ll_ItemID )
	lnv_Item.of_SetShipment ( THIS )
	lnv_Item.of_SetDescription ( "CHASSIS PICKUP" )
	lnv_Item.of_SetEventTypeFlag ( n_cst_Constants.cs_ItemEventType_FrontChassisSplit )

END IF		

THIS.of_RecalcSurcharges ( ) 

DESTROY ( lnv_Item ) 

RETURN ll_ItemID


end function

public function long of_addbackchassissplititem (n_cst_bso_dispatch anv_dispatch);string	ls_codename

long	ll_ratedatacount, &
		ll_ndx, &
		ll_ItemID

n_cst_bso_Dispatch 	lnv_Dispatch
n_cst_beo_Item			lnv_Item

lnv_Item = CREATE n_cst_beo_Item

lnv_Dispatch = anv_Dispatch

ll_ItemID = THIS.of_AddItem ( "L" , lnv_Dispatch )
IF ll_ItemID > 0 THEN
	lnv_Item.of_SetSource ( lnv_Dispatch.of_GetItemCache ( ) )
	lnv_Item.of_SetSourceID ( ll_ItemID )
	lnv_Item.of_SetShipment ( THIS )
	lnv_Item.of_SetDescription ( "CHASSIS RETURN" )
	lnv_Item.of_SetEventTypeFlag ( n_cst_Constants.cs_ItemEventType_BackChassisSplit )
END IF		

THIS.of_RecalcSurcharges ( )

DESTROY ( lnv_Item ) 

RETURN ll_ItemID


end function

public function integer of_getitemsforeventtype (string as_type, ref n_cst_beo_item anva_items[]);/*
	if as_type is null then get all "non-special" types
	
	
CHANGE::
	The way that this code was written was that by passing in a NULL as_type
	the calling script would want all not-specail types. when this was written
	threre were only a couple of 'special' types. 
	
		
	SPECAIL TYPES ARE cs_itemeventtype_backchassissplit
							cs_itemeventtype_frontchassissplit
							cs_itemeventtype_stopoff
	
	As time went on more possible values were added to the tagtypes.
	
					cs_itemeventtype_fuelsurcharge
					cs_itemeventtype_imported
					cs_itemeventtype_importedacc
					cs_itemeventtype_importedfreight
					cs_itemeventtype_moveaccessorial
					cs_itemeventtype_perdiem
	
	The investigation to this started when imported items were not being payed. 
	
	I am making a change to allow the following items to be consididered as 
	non-special types and to be passed back out
	cs_itemeventtype_imported
	cs_itemeventtype_importedacc
	cs_itemeventtype_importedfreight
	cs_itemeventtype_moveaccessorial
	
	
<<*>> 8/17/05	
	

	
	
*/



Boolean	lb_NonSpecial
Long	ll_ItemCount
Long	ll_I
string	ls_type

n_cst_beo_Item		lnva_ItemList[]
n_cst_beo_Item		lnva_KeepList[]

ll_ItemCount = THIS.of_GetItemList ( lnva_ItemList )

lb_NonSpecial = IsNull ( as_type )


FOR ll_i = 1 TO ll_ItemCount
	
	ls_type = lnva_ItemList[ll_i].of_GetEventtypeFlag ()
	
	IF ls_type = as_type THEN // KEEP IT
		lnva_KeepList [ UpperBound ( lnva_KeepList ) + 1 ] = lnva_ItemList[ll_i]
	ELSEIF isNull ( ls_type ) AND lb_NonSpecial  THEN // Keep IT
		lnva_KeepList [ UpperBound ( lnva_KeepList ) + 1 ] = lnva_ItemList[ll_i]
	ELSEIF lb_NonSpecial THEN
		
		CHOOSE CASE ls_type
		
			CASE n_cst_constants.cs_itemeventtype_imported, &
				  n_cst_constants.cs_itemeventtype_importedacc, &
				  n_cst_constants.cs_itemeventtype_importedfreight, &
				  n_cst_constants.cs_itemeventtype_moveaccessorial
				// KEEP IT
				lnva_KeepList [ UpperBound ( lnva_KeepList ) + 1 ] = lnva_ItemList[ll_i]
				
		END CHOOSE
	ELSE
		DESTROY ( lnva_ItemList[ll_i] )
	END IF
	
NEXT

anva_items[] = lnva_KeepList

RETURN UpperBound ( anva_items[ ] )





end function

public function integer of_setforwarderref (string as_value);Int	li_Return

li_Return = THIS.of_SetAny ( "forwarderref" , as_Value )

IF li_Return = 1 THEN
	IF THIS.of_GetRef1Type ( ) = 22 THEN
		THIS.of_SetRef1Text ( as_value )
	END IF
	
	IF THIS.of_GetRef2Type ( ) = 22 THEN
		THIS.of_SetRef2Text ( as_value )
	END IF
	
	IF THIS.of_GetRef3Type ( ) = 22 THEN
		THIS.of_SetRef3Text ( as_value )
	END IF
END IF			
			
RETURN li_Return
end function

public function integer of_setseal (string as_value);Int	li_Return

li_Return = THIS.of_SetAny ( "seal" , as_Value )

IF li_Return = 1 THEN
	IF THIS.of_GetRef1Type ( ) = 21 THEN
		THIS.of_SetRef1Text ( as_value )
	END IF
	
	IF THIS.of_GetRef2Type ( ) = 21 THEN
		THIS.of_SetRef2Text ( as_value )
	END IF
	
	IF THIS.of_GetRef3Type ( ) = 21 THEN
		THIS.of_SetRef3Text ( as_value )
	END IF
END IF			
			
RETURN li_Return
end function

public function integer of_setbookingnumber (string as_value);Int	li_Return

li_Return = THIS.of_SetAny ( "booking" , as_Value )


IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "booking" )
	
	IF THIS.of_GetRef1Type ( ) = 18 THEN
		THIS.of_SetRef1Text ( as_value )
	END IF
	
	IF THIS.of_GetRef2Type ( ) = 18 THEN
		THIS.of_SetRef2Text ( as_value )
	END IF
	
	IF THIS.of_GetRef3Type ( ) = 18 THEN
		THIS.of_SetRef3Text ( as_value )
	END IF
END IF			
			
RETURN li_Return

end function

public function integer of_setmasterbl (string as_value);Int	li_Return

li_Return = THIS.of_SetAny ( "masterbl" , as_Value )

IF li_Return = 1 THEN
	IF THIS.of_GetRef1Type ( ) = 15 THEN
		THIS.of_SetRef1Text ( as_value )
	END IF
	
	IF THIS.of_GetRef2Type ( ) = 15 THEN
		THIS.of_SetRef2Text ( as_value )
	END IF
	
	IF THIS.of_GetRef3Type ( ) = 15 THEN
		THIS.of_SetRef3Text ( as_value )
	END IF
END IF			
			
RETURN li_Return
end function

public function string of_getmovecode ();RETURN This.of_GetValue ( "movecode", TypeString! )
end function

public function int of_sethazmat (boolean ab_Value);String ls_Value

IF ab_Value THEN
	ls_Value = "T"
ELSE
	ls_Value = "F"
END IF

RETURN This.of_SetAny ( "ds_hazmat",  ls_Value )
end function

public function boolean of_allowchassismove (boolean ab_splitfront, boolean ab_splitback);Long	ll_EventCount
Long	i
Boolean	lb_Return
n_cst_beo_Event	lnva_EventList[]

THIS.of_GetEventList	( lnva_EventList )

ll_EventCount = UpperBound ( lnva_EventList )
IF ll_EventCount > 1 THEN
	
	IF ab_SplitFront THEN
		IF lnva_EventList[ 1 ].of_GetType ( ) = gc_Dispatch.cs_EventType_Hook THEN
			lb_Return = TRUE
		END IF
	END IF
	
	IF ab_SplitBack THEN
		IF lnva_EventList[ ll_EventCount ].of_GetType ( ) = gc_Dispatch.cs_EventType_Drop THEN
			lb_Return = TRUE
		END IF
	END IF
	
END IF

ll_EventCount = UpperBound ( lnva_EventList )
FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_EventList[i] )
NEXT


RETURN lb_Return
		
end function

public function integer of_autoratecombined (ref n_cst_ratedata anva_ratedata[]);SetPointer(HourGlass!)
integer	li_return = 1

long 	ll_errorcount

string	ls_errormessage

n_cst_bso_rating		lnv_rating
n_cst_beo_shipment	lnv_shipment
n_cst_RateData			lnva_rateData[]
n_cst_OFRError			lnva_Errors[]

lnva_ratedata = anva_ratedata

lnv_rating = create n_cst_bso_rating	

lnv_rating.ClearOFRErrors ( )

lnv_Shipment = this

if lnv_rating.of_autorate( {lnv_Shipment} , lnva_rateData, n_cst_constants.ci_Category_Receivables, true ) = 1 then
	SetPointer(HourGlass!)
	lnv_rating.GetOFRErrors ( lnva_Errors )
	ll_errorcount = lnv_rating.GetErrorCount()
	if ll_errorcount > 0 then
		ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )
	
		if Len ( ls_errormessage ) > 0 then
			//OK
		else
			ls_errormessage = "Unspecified error on rating."
		end if
	
		if len(ls_errormessage) > 0 then
			if ls_errormessage = "Cancelled" then
				//user cancelled
				li_return = -1
			else
				//Dan, check for scheduler running here
				IF not Gnv_app.of_runningscheduledtask( ) THEN
					messagebox("Auto Rating", ls_errormessage)
				END IF
				//-------------------------------------
				li_return = -1
			end if
		end if
	
		destroy lnv_rating
			
	end if
	if li_return = 1 then
		anva_ratedata = lnva_ratedata
	end if
else
	li_return = -1
end if

return li_return
/* commented out when dan integrated autorating of imports with fsc
SetPointer(HourGlass!)
integer	li_return = 1

long 	ll_errorcount

string	ls_errormessage

n_cst_bso_rating		lnv_rating
n_cst_beo_shipment	lnv_shipment
n_cst_RateData			lnva_rateData[]
n_cst_OFRError			lnva_Errors[]

lnva_ratedata = anva_ratedata

lnv_rating = create n_cst_bso_rating	

lnv_rating.ClearOFRErrors ( )

lnv_Shipment = this

if lnv_rating.of_autorate( {lnv_Shipment} , lnva_rateData, n_cst_constants.ci_Category_Receivables, true ) = 1 then
	SetPointer(HourGlass!)
	lnv_rating.GetOFRErrors ( lnva_Errors )
	ll_errorcount = lnv_rating.GetErrorCount()
	if ll_errorcount > 0 then
		ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )
	
		if Len ( ls_errormessage ) > 0 then
			//OK
		else
			ls_errormessage = "Unspecified error on rating."
		end if
	
		if len(ls_errormessage) > 0 then
			if ls_errormessage = "Cancelled" then
				//user cancelled
				li_return = -1
			else
				messagebox("Auto Rating", ls_errormessage)
				li_return = -1
			end if
		end if
	
		destroy lnv_rating
			
	end if
	if li_return = 1 then
		anva_ratedata = lnva_ratedata
	end if
else
	li_return = -1
end if

return li_return
*/
end function

public function integer of_companyadded (long al_companyid);/* 
	This method is used to determine and set the contacts on the shipment as needed

*/ 


Int		li_Return = 0  // no action taken by default

//n_cst_licenseManager	lnv_Lic
//
//IF lnv_Lic.of_HasNotificationLicense ( )  THEN
//	CHOOSE CASE THIS.of_CleanContactList ( ) // this will add the contacts if needed as well as remove any non referenced
//		CASE 1
//			li_Return = 1 
//		CASE 0 
//			li_Return = 0			
//		CASE ELSE
//			li_Return = -1			
//	END CHOOSE		
//END IF


RETURN li_Return


end function

public function int of_addaccnotecontacts (long ala_contactids[]);long	lla_ContactIds[]
Long	ll_I
Long	ll_Index
Long	ll_Count
Int	li_Return	= -1

n_cst_anyarraySrv	lnv_ArraySrv
ll_Index = THIS.of_GetAccNoteContacts ( lla_ContactIDs[] )

ll_Count = UpperBound ( ala_ContactIds )
FOR ll_i = 1 TO ll_Count
	ll_Index ++
	lla_ContactIds [ ll_Index ] = ala_ContactIds[ ll_i ]	
NEXT

lnv_ArraySrv.of_GetShrinked ( lla_ContactIds , TRUE , TRUE )  

IF THIS.of_SetAccNoteContacts ( lla_ContactIds ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return

end function

public function integer of_addaccauthcontacts (long ala_contactids[]);long	lla_ContactIds[]
Long	ll_I
Long	ll_Index
Long	ll_Count
Int	li_Return	= -1

n_cst_anyarraySrv	lnv_ArraySrv
ll_Index = THIS.of_GetAccAuthContacts ( lla_ContactIDs[] )

ll_Count = UpperBound ( ala_ContactIds )
FOR ll_i = 1 TO ll_Count
	ll_Index ++
	lla_ContactIds [ ll_Index ] = ala_ContactIds[ ll_i ]	
NEXT

lnv_ArraySrv.of_GetShrinked ( lla_ContactIds , TRUE , TRUE )  

IF THIS.of_SetAccAuthContacts ( lla_ContactIds ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return

end function

public function integer of_addshipmentcontacts (long ala_ContactIds[]);long	lla_ContactIds[]
Long	ll_I
Long	ll_Index
Long	ll_Count
Int	li_Return	= -1

n_cst_anyarraySrv	lnv_ArraySrv
ll_Index = THIS.of_GetShipmentContacts ( lla_ContactIDs[] )

ll_Count = UpperBound ( ala_ContactIds )
FOR ll_i = 1 TO ll_Count
	ll_Index ++
	lla_ContactIds [ ll_Index ] = ala_ContactIds[ ll_i ]	
NEXT

lnv_ArraySrv.of_GetShrinked ( lla_ContactIds , TRUE , TRUE )  

IF THIS.of_SetShipmentContacts ( lla_ContactIds ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return

end function

public function integer of_addlastfreedatecontacts (long ala_Contactids[]);long	lla_ContactIds[]
Long	ll_I
Long	ll_Index
Long	ll_Count
Int	li_Return	= -1

n_cst_anyarraySrv	lnv_ArraySrv
ll_Index = THIS.of_GetLastFreeDateContacts ( lla_ContactIDs[] )

ll_Count = UpperBound ( ala_ContactIds )
FOR ll_i = 1 TO ll_Count
	ll_Index ++
	lla_ContactIds [ ll_Index ] = ala_ContactIds[ ll_i ]	
NEXT

lnv_ArraySrv.of_GetShrinked ( lla_ContactIds , TRUE , TRUE )  

IF THIS.of_SetLastFreeDateContacts ( lla_ContactIds ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return

end function

private function integer of_setcontacts ();Return -1
//
//
//
//
//
//
//long	lla_RefCos [ ]
//Long	ll_CoCount
//Long	ll_CoIndex
//Long	ll_ContactCount
//Long	ll_ContactIndex
//
//DataStore				lds_Contacts
//lds_Contacts = CREATE DataStore
//
//lds_Contacts.DataObject = "d_companyContacts_list"
//lds_Contacts.SetTransObject ( SQLCA )
//
//
//THIS.of_GetReferencedCompanies ( lla_RefCos )
//ll_CoCount = UpperBound ( lla_RefCos )
//
//
//FOR ll_CoIndex = 1 TO ll_CoCount
//	lds_Contacts.Retrieve ( lla_RefCos [ ll_CoIndex ] )
//	
//	
//	
//	
//	
//	
//NEXT
//
//
//
//
//
//
///* 
//	This method is used to determine and set the contacts on the shipment as needed
//
//*/ 
//Int		li_Return = 0  // no action taken by default
//Boolean	lb_Continue
//Long		lla_Contacts[]
//String	ls_ReqRole
//
//n_Cst_bso_Notification_Manager	lnv_NoteManager
//n_cst_licenseManager	lnv_Lic

//n_cst_beo_Company		lnv_Company
//n_cst_ContactManager	lnv_ContactManager
//
//lnv_NoteManager = CREATE n_Cst_bso_Notification_Manager
//lnv_Company = CREATE n_cst_beo_Company 
//lnv_ContactManager = CREATE n_cst_ContactManager
//
//
//
//
//lb_Continue = TRUE
//
//
//
//lnv_Company.of_SetUseCache ( TRUE ) 
//lnv_Company.of_SetSourceID ( al_CompanyID )
//
//IF lb_Continue THEN
//	lb_Continue = lnv_Lic.of_HasNotificationLicense ( ) 
//END IF
//
//IF lb_Continue THEN
//	IF NOT lnv_Company.of_HasSource ( ) THEN
//		lb_Continue = FALSE
//		li_Return = -1
//	END IF
//END IF
//
//IF lb_Continue THEN
//	CHOOSE CASE lnv_NoteManager.of_ValidateRequestRole ( lnv_Company , THIS )
//			
//		CASE 0 // not valid 
//			li_Return = 0
//			lb_Continue = FALSE
//		CASE 1 // valid
//			// continue
//			
//		CASE ELSE // ERROR
//			li_Return = -1
//			lb_Continue = FALSE
//	END CHOOSE
//END IF
//
//IF lb_Continue THEN
//	
//	lds_Contacts.Retrieve ( {lnv_Company.of_GetID ( )} )
//	
//	lnv_ContactManager.of_GetAccNoteContacts ( lds_Contacts , lla_Contacts )
//	THIS.of_AddAccNoteContacts ( lla_Contacts )
//	
//	lnv_ContactManager.of_GetAccAuthContacts ( lds_Contacts , lla_Contacts )
//	THIS.of_AddAccAuthContacts ( lla_Contacts )
//
//	lnv_ContactManager.of_GetEventContacts ( lds_Contacts , lla_Contacts )
//	THIS.of_AddEventContacts ( lla_Contacts )
//
//	lnv_ContactManager.of_GetShipmentContacts ( lds_Contacts , lla_Contacts )
//	THIS.of_AddShipmentContacts ( lla_Contacts )
//	
//	lnv_ContactManager.of_GetLastFreeDateContacts ( lds_Contacts , lla_Contacts )
//	THIS.of_AddLastFreeDateContacts ( lla_Contacts )
//	
//END IF
//
//
//Destroy ( lnv_Contactmanager )
//DESTROY ( lds_Contacts ) 
//DESTROY ( lnv_NoteManager ) 
//DESTROY ( lnv_Company ) 
//
//RETURN li_Return
end function

public function date of_getprenotedate ();RETURN This.of_GetValue ( "prenotedate", TypeDate! )
end function

public function boolean of_isintermodal ();n_cst_ship_Type	lnv_ShipTypeManager
n_cst_ShipType		lnv_ShipType
Boolean	lb_Return
Long		ll_ShipType

lnv_ShipTypeManager.of_Ready ( TRUE ) 

ll_ShipType = THIS.of_GetType ( ) 

lnv_ShipTypeManager.of_Get_Object ( ll_ShipType , lnv_ShipType )

IF lnv_ShipType.of_GetIntermodal ( ) THEN
	lb_Return = TRUE
ELSE
	lb_Return = FALSE
END IF

DESTROY ( lnv_Shiptype ) 

RETURN lb_Return
end function

public function integer of_cleancontactlist ();// RDT 6-09-03 changed to save event contacts on event instead of shipment.

Long	lla_Companies[]
Long	lla_Contacts[]
Int	li_CoCount
Int	li_ContactCount 
Int	li_i
Int	li_Return
Boolean	lb_Continue = TRUE

DataStore	lds_Contacts
n_cst_ContactManager	lnv_ContactManager
n_Cst_bso_Notification_Manager	lnv_NoteManager
n_cst_beo_Company	lnv_Company

n_cst_beo_event lnva_Events[]										// RDT 6-09-03 
Long ll_upper , ll_count, lla_AllContacts[], ll_co_id 	// RDT 6-09-03 

lnv_ContactManager = CREATE n_cst_ContactManager
lnv_Company = CREATE n_cst_beo_Company
lnv_NoteManager = CREATE n_Cst_bso_Notification_Manager

lds_Contacts = CREATE DataStore
lds_Contacts.DataObject = "d_companyContacts_list"
lds_Contacts.SetTransObject ( SQLCA )

THIS.of_GetReferencedCompanies ( lla_Companies  )
li_CoCount = UpperBound ( lla_Companies ) 
gnv_cst_companies.of_Cache ( lla_Companies , TRUE ) 
lnv_Company.of_SetUseCache ( TRUE ) 

// clear out the contact list
THIS.of_SetAccNoteContacts ( lla_Contacts )
THIS.of_SetAccAuthContacts ( lla_Contacts )
THIS.of_SetEventContacts ( lla_Contacts )
THIS.of_SetShipmentContacts ( lla_Contacts )
THIS.of_SetLastFreeDateContacts ( lla_Contacts )


// FOR EACH Refernced company get, validate and set the contacts on this shipment
FOR li_i = 1 TO li_CoCount
	
	lnv_Company.of_SetSourceID ( lla_Companies[ li_i ] )
	
	CHOOSE CASE lnv_NoteManager.of_ValidateRequestRole ( lnv_Company , THIS )
			
		CASE 0 // not valid 
			li_Return = 0
			lb_Continue = FALSE
		CASE 1 // valid
			lb_Continue = TRUE
			
		CASE ELSE // ERROR
			li_Return = -1
			lb_Continue = FALSE
	END CHOOSE
	
	IF li_Return = -1 THEN
		EXIT 
	END IF
	
	IF lb_Continue THEN
		lds_Contacts.Retrieve ( {lnv_Company.of_GetID ( )} )		
	END IF
	
	IF lb_Continue THEN
		lnv_ContactManager.of_GetAccNoteContacts ( lds_Contacts , lla_Contacts )
		THIS.of_AddAccNoteContacts ( lla_Contacts )
		
		IF	lnv_Company.of_GetID ( ) = THIS.of_GetBillTo ( ) AND &
		 lnv_Company.of_GetRequiredRequestRole ( ) <> n_cst_constants.cs_RequestRole_NONE THEN
		
			lnv_ContactManager.of_GetAccAuthContacts ( lds_Contacts , lla_Contacts )
			THIS.of_AddAccAuthContacts ( lla_Contacts )
		END IF
	
		lnv_ContactManager.of_GetEventContacts ( lds_Contacts , lla_Contacts )
		//THIS.of_AddEventContacts ( lla_Contacts ) //RDT 6-09-03	
	
		// RDT 6-09-03 Set contacts on the events - Start
		This.of_GetEventList ( lnva_Events[] )
		ll_upper = UpperBound( lnva_Events[] )
	
		IF ll_Upper > 0 Then 
			For ll_Count = 1 to ll_Upper
				if IsValid( lnva_Events[ ll_Count ] ) then 
					ll_co_id = lnv_Company.of_GetID ( )
						
					If lnv_NoteManager.of_IsCompanyEvent( ll_co_id ,lnva_events[ll_Count] ) then 
						lnv_NoteManager.of_EventCompanyContact ( lnv_Company.of_GetID ( ) , lnva_events[ll_Count], TRUE /*add*/ )
					else
						// do nothing
					end if 

					Destroy ( lnva_Events[ ll_Count ] )
				end if
			Next
		END IF 
		// RDT 6-09-03 // Get contacts from the events - End

	
		lnv_ContactManager.of_GetShipmentContacts ( lds_Contacts , lla_Contacts )
		THIS.of_AddShipmentContacts ( lla_Contacts )
		
		lnv_ContactManager.of_GetLastFreeDateContacts ( lds_Contacts , lla_Contacts )
		THIS.of_AddLastFreeDateContacts ( lla_Contacts )
	END IF

NEXT

DESTROY ( lnv_NoteManager )
DESTROY ( lnv_Company ) 
DESTROY ( lds_Contacts ) 
Destroy ( lnv_Contactmanager )
RETURN li_Return


end function

public function integer of_processstatusnotifications (string as_newstatus, n_cst_bso_dispatch anv_dispatch);String			ls_OldStatus
String			ls_OldDocType
n_cst_Settings	lnv_Settings


IF lnv_Settings.of_CreateAccAuthorization ( ) THEN
	ls_OldDocType = THIS.of_GetDocumentType ( ) 
	ls_OldStatus = THIS.of_GetStatus ( )
	
	THIS.of_setDocumentType ( appeon_constant.cs_authout )
	
	IF ls_OldStatus = gc_dispatch.cs_ShipmentStatus_AuditRequired THEN
		anv_Dispatch.of_GetNotificationManager( ).of_RemovePendingNotification ( THIS )
	END IF
	
	IF as_NewStatus = gc_dispatch.cs_ShipmentStatus_AuditRequired THEN
		anv_Dispatch.of_GetNotificationManager( ).of_CreatePendingNotification ( THIS )
	END IF
	
	THIS.of_SetDocumentType ( ls_OldDocType )
END IF
RETURN 1
	
end function

public function integer of_setagent (long al_value);int	li_Return
Long	ll_OldAgent
n_cst_ContactManager	lnv_Contacts
n_cst_beo_Company		lnv_Company

lnv_Contacts = CREATE n_CsT_ContactManager
lnv_Company = CREATE n_Cst_Beo_Company

ll_OldAgent = THIS.of_GetAgent ( )

lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID ( ll_OldAgent )

li_Return =  THIS.of_SetAny ( "agent" , al_Value )

IF li_Return = 1 THEN
	IF lnv_Company.of_HasSource ( ) THEN
		lnv_Contacts.of_RemoveContactsIfNeeded ( THIS , lnv_Company )
	END IF
	lnv_Company.of_SetSourceID ( al_Value )
	lnv_Contacts.of_AddContactsIfNeeded ( THIS , lnv_Company , n_cst_companies.cs_companyrole_Agent )
	
END IF

DESTROY ( lnv_Contacts ) 
DESTROY ( lnv_Company )

RETURN li_Return

end function

public function integer of_setforwarder (long al_value);int	li_Return
Long	ll_OldForwarder
n_cst_ContactManager	lnv_Contacts
n_cst_beo_Company		lnv_Company

lnv_Contacts = CREATE n_CsT_ContactManager
lnv_Company = CREATE n_Cst_Beo_Company

ll_OldForwarder = THIS.of_GetForwarder ( )

lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID ( ll_OldForwarder )

li_Return =  THIS.of_SetAny ( "forwarder" , al_Value )

IF li_Return = 1 THEN
	IF lnv_Company.of_HasSource ( ) THEN
		lnv_Contacts.of_RemoveContactsIfNeeded ( THIS , lnv_Company )
	END IF
	lnv_Company.of_SetSourceID ( al_Value )
	lnv_Contacts.of_AddContactsIfNeeded ( THIS , lnv_Company , n_cst_companies.cs_companyrole_Forwarder )
	
END IF

DESTROY ( lnv_Contacts ) 
DESTROY ( lnv_Company )

RETURN li_Return
end function

public function string of_getnotificationsubject ();// April 29 2004 <<*>> RPZ
// Changing the subject line to Ref1Type Ref1Text, Ref2Type Ref2Text, 'Shipment #' Tmp no
// ie CONTAINER: APLU123456, CHASSIS: APLZ123456, SHIPMENT 123000



String 	ls_Return 
String 	ls_RefLabel, &
			ls_RefText, &
			ls_Container, &
			ls_Subject = ""
			

/////  get and format ref 1
ls_RefLabel = THIS.of_GetRef1Label ( )
ls_RefText  = THIS.of_GetRef1Text( )

If Len(Trim( ls_RefLabel ) ) = 0 or IsNull( ls_RefLabel ) or ls_RefLabel = "[NONE]" then 
	ls_RefLabel = ""
ELSE
	ls_RefLabel += ": "
		
End If
If Len(Trim( ls_RefText ) ) = 0 or IsNull( ls_RefText ) then 
	ls_RefText = ""
End If

ls_Subject += ls_RefLabel + ls_RefText

/////  get and format ref 2
ls_RefLabel = THIS.of_GetRef2Label ( )
ls_RefText  = THIS.of_GetRef2Text( )

If Len(Trim( ls_RefLabel ) ) = 0 or IsNull( ls_RefLabel ) or ls_RefLabel = "[NONE]" then 
	ls_RefLabel = ""
ELSE
	ls_RefLabel += ": "
End If
If Len(Trim( ls_RefText ) ) = 0 or IsNull( ls_RefText ) then 
	ls_RefText = ""
End If

IF Len (ls_Subject) > 0 AND ( Len ( ls_RefLabel)  + Len ( ls_RefText ) ) >  0 THEN
	ls_Subject += ", "
END IF

ls_Subject += ls_RefLabel + ls_RefText


/////  get and format the shipment Number
IF Len (ls_Subject) > 0 THEN
	ls_Subject += ", "
END IF

ls_Subject += "SHIPMENT: " + String ( THIS.of_GetID ( ) )


// determine the document type so we can apply the appropriate prefix
Choose Case is_documenttype
		
	Case  appeon_constant.cs_authout	
		ls_Return = "Accessorial Charges Authorization " + ls_Subject 
	
	Case appeon_constant.cs_shipstat
		ls_Return = "Shipment Status " + String ( THIS.of_GetID ( ) )		

	Case appeon_constant.cs_acc
		ls_Return = "Accessorial Charges " + ls_Subject 
	
	CASE appeon_constant.cs_lfd
		ls_Return = "LFD Notification " + ls_Subject

	CASE appeon_constant.cs_LoadConfirmation	
		ls_Return = "Load Confirmation " + ls_subject
		
	Case Else 
		ls_Return = ls_Subject
		

End Choose

RETURN ls_Return



// RDT 6-19-03 Changed Subject line 
//
//String ls_Return 
//
//// RDT 6-19-03 -Start 
//n_cst_anyarraySrv lnv_array
//String 	ls_RefLabel, &
//			ls_RefText, &
//			ls_Container, &
//			ls_Subject = ""
//			
//Integer 	li_Count, li_Upper
//
//n_cst_beo_equipment2 lnva_equipment[] 
//
//n_cst_equipmentmanager lnv_equipmentmanager 
//
//li_Upper = This.of_getLinkedequipment ( lnva_equipment[] ) 
//
//If li_Upper > 0 then 
//	// loop thru looking for a container
//	For li_Count = 1 to li_Upper
//		if lnva_Equipment[li_count].of_GetType() = lnv_equipmentmanager.cs_cntn Then 
//			ls_Container = lnva_Equipment[li_count].of_GetNumber()
//			Exit
//		end if
//	Next
//	If Len(Trim( ls_Container)) > 0 then
//		ls_Subject = "Container "+ls_Container + " "
//	End if
//		
//End If
//
//ls_RefLabel = THIS.of_GetRef2Label ( )
//ls_RefText  = THIS.of_GetRef2Text( )
//If Len(Trim( ls_RefLabel ) ) < 1 or IsNull( ls_RefLabel ) or ls_RefLabel = "[NONE]" then 
//		ls_RefLabel = ""
//End If
//If Len(Trim( ls_RefText ) ) < 1 or IsNull( ls_RefText ) then 
//		ls_RefText = ""
//End If
//
//lnv_array.of_Destroy( lnva_equipment[] ) 
//
//ls_Subject += ls_RefLabel + ls_RefText
//
//// RDT 6-19-03 -End 
//
//Choose Case is_documenttype
//		
//	Case  appeon_constant.cs_authout	
////    ls_Return = "Accessorial Charges Authorization for Shipment " + String ( THIS.of_GetID ( ) )
//		ls_Return = "Accessorial Charges Authorization " + ls_Subject 
//	
//	Case appeon_constant.cs_shipstat
//		ls_Return = "Shipment Status " + String ( THIS.of_GetID ( ) )		
//
//	Case appeon_constant.cs_acc
//		ls_Return = "Accessorial Charges " + ls_Subject 
//		
//	Case Else
//		ls_Return = "Shipment " + String ( THIS.of_GetID ( ) )		
//
//End Choose
//
//RETURN ls_Return
end function

public subroutine of_rerateitems ();long		ll_ndx, &
			ll_count	
string	ls_ratecode		

n_cst_LicenseManager	lnv_LicenseManager
n_cst_ratedata	lnva_Ratedata[]
n_cst_beo_item	lnva_item[]

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating  ) THEN
	ll_count = this.of_getitemlist(lnva_item)
	for ll_ndx = 1 to ll_count
		lnva_Item[ll_ndx].of_setshipment(this)
		ls_ratecode = lnva_Item[ll_ndx].of_GetRatecodename()
		if isnull(ls_ratecode) or len(trim(ls_ratecode)) = 0 or ls_ratecode = 'CUSTOM' OR lnva_Item[ll_ndx].of_getEventtypeflag( ) = n_cst_constants.cs_ItemEventType_FuelSurcharge then
			continue
		else
			if	lnva_Item[ll_ndx].of_autorate(lnva_Ratedata) < 0 then
				continue
			else
				lnva_Item[ll_ndx].of_applyautorate(lnva_Ratedata)
			end if
		end if
	next	
end if		

end subroutine

public function long of_applyaccessrate (n_cst_ratedata anva_ratedata[]);SetPointer(HourGlass!)
long 	ll_itemcount, &
		ll_ratedatacount, &
		ll_updatecount, &
		ll_ndx, &
		ll_ndx2
		
string	ls_ratetype	

n_cst_beo_item			lnva_item[]

//apply rates 
ll_itemcount = this.of_getitemlist(lnva_item, n_cst_constants.cs_ItemType_Accessorial)
for ll_ndx = 1 to ll_itemcount
//	if ib_recalculate then  // Rick and Norm on phone 6/13/03
		if lnva_item[ll_ndx].of_ApplyAutorate(anva_ratedata) > 0 then
			ll_updatecount ++
		end if
//	end if
next

return ll_updatecount

end function

public function long of_applyfreightrate (n_cst_ratedata anva_ratedata[], string as_whatchanged);SetPointer(HourGlass!)
integer	x
long 	ll_itemcount, &
		ll_ratedatacount, &
		ll_ndx, &
		ll_ndx2, &
		ll_mimaxndx, &
		ll_updatecount
		
string	ls_ratetype, &
			ls_Codename, &
			ls_itemcodename, &
			ls_description, &
			ls_billto, &
			ls_origin, &
			ls_ExistingCodename, &
			ls_minmaxratetype, &
			ls_test, &
			ls_rateeventtype, &
			ls_itemeventtype, &
			ls_taglist, &
			ls_Changed, &
			ls_newvalue
			
decimal	lc_rate

boolean	lb_minimum, &
			lb_maximum, &
			lb_flatcombined, &
			lb_applyrate, &
			lb_standardfreightdone
			
n_cst_beo_item			lnva_item[]
n_cst_string			lnv_string
ll_ratedatacount = upperbound(anva_ratedata)

//when applying minimum and maximum rates, only populate the first freight item, zero out the rest
//apply rates 
ll_itemcount = this.of_getitemlist(lnva_item, n_cst_constants.cs_ItemType_Freight)

//if the question was asked and the answer was no change all items with ratecodes to custom
if ib_askrecalculate and not ib_recalculate then
	for ll_ndx = 1 to ll_itemcount
		ls_Codename = lnva_item[ll_ndx].of_GetRateCodename()
		if ls_codename = 'CUSTOM' then
			CONTINUE
		end if
		
		//don't rate payable only
		if lnva_item[ll_ndx].of_GetAccountingType() = n_cst_constants.cs_AccountingType_Payable then
			continue
		end if	

		//if not 'CUSTOM'
		if lnva_item[ll_ndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_FrontChassisSplit or &
		   lnva_item[ll_ndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_BackChassisSplit or &
			lnva_item[ll_ndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_StopOff then
			//don't change specials to 'CUSTOM'
			CONTINUE
		end if
		if len(trim(ls_codename)) > 0 then
			//change to 'CUSTOM'
			lnva_item[ll_ndx].of_setRateCodename('CUSTOM')
			
			//set taglist
			ls_taglist = lnva_item[ll_ndx].of_GetTagList() 
			ls_changed = lnv_string.of_GetKeyValue(ls_taglist,'Changed',',')
			ls_newvalue = 'ratecode' 
			if len(trim(ls_changed)) > 0 then
				//replace old value
				lnv_String.of_SetKeyvalue(ls_taglist,'Changed,', ls_newvalue, ',')
			else
				//new value
				ls_taglist += ',Changed=' + ls_newvalue
			end if
			
			lnva_Item [ ll_ndx ].of_SetTaglist(ls_taglist)
			lnva_item [ ll_ndx ].of_setlastratedby(gnv_app.of_getuserid())
			
		end if
	next
end if

for ll_ndx = 1 to ll_itemcount
	ls_itemcodename = lnva_item[ll_ndx].of_GetRateCodename()
	
	//don't rate payable only
	if lnva_item[ll_ndx].of_GetAccountingType() = n_cst_constants.cs_AccountingType_Payable then
		continue
	end if	

	if ls_itemcodename = 'CUSTOM' then
		CONTINUE
	elseif len(trim(ls_itemcodename)) = 0 or isnull(ls_itemcodename) then
		//ok rate
	else
		//previously rated
		//was question asked?
		if ib_askrecalculate then
			if ib_recalculate then
				//ok rate
			else
				CONTINUE				
			end if
		else
			//ok rate
		end if
	end if

	lnva_item[ll_ndx].of_SetShipment ( this )
	
	ls_itemeventtype = lnva_item[ll_ndx].of_getEventTypeFlag()
	
	//only rate one standard freight for intermodal
	if this.of_IsIntermodal() then
		if isnull(ls_itemeventtype) and lb_standardfreightdone then
			//frieght already done
			continue
		end if
	end if
	
	for ll_ndx2 = 1 to ll_ratedatacount 
		if isvalid(anva_ratedata[ll_ndx2]) then
			//ok
		else
			CONTINUE
		end if
		
		//does item type (freight,access) match ratedata ?
		if anva_ratedata[ll_ndx2].of_getItemType() <> lnva_item[ll_ndx].of_GetType() then
			CONTINUE
		end if
		
		ls_rateeventtype = anva_ratedata[ll_ndx2].of_getItemEventType()
		if (ls_rateeventtype <> ls_itemeventtype) or (isnull(ls_rateeventtype) and not isnull(ls_itemeventtype)) or &
			(not isnull(ls_rateeventtype) and isnull(ls_itemeventtype)) then
			CONTINUE
		end if
		
		ls_ratetype = anva_ratedata[ll_ndx2].of_getratetype()
		ls_Codename = anva_ratedata[ll_ndx2].of_getcodename()
		
		if len(trim(ls_ratetype)) = 0 then
			//no rate type on object. this should not happen.
			continue
		end if

		//if there is only one ratedata object then change the rate type on the 
		//item detail to the same as the ratedata ratetype

		//look for a custom rate
		ls_itemcodename = lnva_item[ll_ndx].of_GetRateCodename()
		
		if ls_itemcodename = 'CUSTOM' then
			//don't do anything
		else
			lb_applyrate = true
			ls_taglist = 'BillTo=' + string(anva_ratedata[ll_ndx2].of_getbilltoid()) + "," + &
							'Originzone=' + anva_ratedata[ll_ndx2].of_getOriginZone() + "," + &
							'Destinationzone=' + anva_ratedata[ll_ndx2].of_getDestinationZone()
			lnva_item[ll_ndx].of_setTaglist(ls_taglist)
		end if
		if lb_applyrate then		
			if lnva_item[ll_ndx].of_getmiles() > 0 then
				choose case as_whatchanged
					case cs_action_changedorigin, cs_action_changedDestination
						if anva_ratedata[ll_ndx2].of_useshipmiles() then
							lnva_item[ll_ndx].of_setmiles(anva_ratedata[ll_ndx2].of_gettotalmiles())
						end if
				end choose
			else
				if anva_ratedata[ll_ndx2].of_useshipmiles() then
					lnva_item[ll_ndx].of_setmiles(anva_ratedata[ll_ndx2].of_gettotalmiles())
				end if
			end if			
			
			if lb_minimum or lb_maximum or lb_flatcombined then
				//only one freight line should be set
			else
				if (ll_ratedatacount = 1) or (anva_ratedata[ll_ndx2].of_getratetype() = ls_ratetype) or &
					(ls_ratetype = appeon_constant.cs_RateUnit_Code_None) then
					
					lnva_item[ll_ndx].of_setratetype(anva_ratedata[ll_ndx2].of_getratetype())	
					if anva_ratedata[ll_ndx2].of_useminimum() then
						lnva_item[ll_ndx].of_setratetype(appeon_constant.cs_RateUnit_Code_Minimum)
						lb_minimum = true
						ls_minmaxratetype = ls_ratetype
					elseif anva_ratedata[ll_ndx2].of_usemaximum() then
						lnva_item[ll_ndx].of_setratetype(appeon_constant.cs_RateUnit_Code_Maximum)
						lb_maximum = true
						ls_minmaxratetype = ls_ratetype
					end if
					
					//if combined autorate and ratetype is flat then only first item will be set
					if anva_ratedata[ll_ndx2].of_getratetype() = appeon_constant.cs_RateUnit_Code_Flat then
						if anva_ratedata[ll_ndx2].of_IsCombinedRate() then
							lnva_item[ll_ndx].of_setratetype(appeon_constant.cs_RateUnit_Code_Flat)
							ls_minmaxratetype = ls_ratetype
							lb_flatcombined = true
						end if
					end if
					
					lc_rate = anva_ratedata[ll_ndx2].of_getrate()
					IF anva_ratedata[ll_ndx2].of_GetMinMaxApplied (  ) AND anva_RateData[ll_ndx2].of_IsCombinedRate()  THEN
						lnva_item[ll_ndx].of_setrate(0)
					ELSE
						lnva_item[ll_ndx].of_setrate(lc_rate)
					END IF
					lnva_item[ll_ndx].of_setratecodename(anva_ratedata[ll_ndx2].of_getcodename())
					ls_description = anva_ratedata[ll_ndx2].of_getDescription()	
					//only replace description	if there is one on the ratetable				
					if len(trim(ls_description)) > 0 then
						lnva_item[ll_ndx].of_setdescription(ls_description)
					end if
					lnva_item[ll_ndx].of_setamounttype(anva_ratedata[ll_ndx2].of_getAmounttype())
					lnva_item[ll_ndx].of_setlastratedby(gnv_app.of_getuserid())
					
					IF lb_maximum OR lb_minimum THEN
						anva_ratedata[ll_ndx2].of_SetMinMaxApplied ( TRUE ) 
					END IF
					
					
					ll_updatecount ++
					exit
				end if
			end if
		end if
		
		
		
		
	next
	
	if isnull(ls_itemeventtype) then
		lb_standardfreightdone = true
	end if

	//set rest of type for minmax
	//look ahead for rest of this ratetype and set to blank so it won't be rated
	if lb_minimum or lb_maximum or lb_flatcombined then
		for ll_mimaxndx = ll_ndx + 1 to ll_itemcount
			//amount and type set on first freight item only
			ls_ratetype = lnva_item[ll_mimaxndx].of_getratetype()
//			if ls_ratetype = ls_minmaxratetype or &     commented <<*>> 8/2/05
//				(ls_ratetype = appeon_constant.cs_RateUnit_Code_None) or &
//				(ls_minmaxratetype = appeon_constant.cs_RateUnit_Code_Flat) then
				if lnva_item[ll_mimaxndx].of_gettype() = n_cst_constants.cs_ItemType_Freight then
					lnva_item[ll_mimaxndx].of_setratetype('')
					lnva_item[ll_mimaxndx].of_setrate(0)
					ll_updatecount ++
				end if
	//		end if
		next
		exit
	end if	
	
next

return ll_updatecount
end function

public function integer of_autorate (ref n_cst_ratedata anva_ratedata[], string as_whatchanged);SetPointer(HourGlass!)
integer	li_return = 1

long 	ll_ratedatacount, &
		ll_ndx, &
		ll_errorcount, &
		ll_count
boolean	lb_rate

string	ls_errormessage, &
			ls_billto, &
			ls_origin, &
			ls_dest, &
			ls_ratecode, &
			ls_taglist
Int		li_res

n_cst_bso_rating		lnv_rating
n_cst_beo_shipment	lnv_shipment
n_cst_beo_item			lnva_item[]
n_cst_RateData			lnva_rateData[]
n_cst_LicenseManager	lnv_LicenseManager
n_cst_OFRError			lnva_Errors[]

lnva_ratedata = anva_ratedata

ib_AskRecalculate = false
ib_Recalculate = false

//added condition to check the edicompany to see if the sender will be autorated.
IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating  ) AND this.of_getAutorateForEdiCompany() THEN
	//do i have all the data i need to rate ?
	ls_billto = string(this.of_getbillto())
	ls_origin = string(this.of_GetOrigin())
	ls_dest = string(this.of_getdestination())
	
	// if any items have a ratecode and a blank taglist then ask question,
	// otherwise we don't recalculate custom rates
	ll_count = this.of_getitemlist(lnva_item)
	for ll_ndx = 1 to ll_count
		
		//don't rate payable only
		if lnva_item[ll_ndx].of_GetAccountingType() = n_cst_constants.cs_AccountingType_Payable then
			continue
		end if	

		//only check for freight
		if lnva_item[ll_ndx].of_gettype() = n_cst_constants.cs_itemtype_accessorial then
			CONTINUE
		end if		
		ls_ratecode = lnva_item[ll_ndx].of_getratecodename()
		ls_taglist = lnva_item[ll_ndx].of_gettaglist()
		if ls_ratecode = 'CUSTOM' then
			CONTINUE
		elseif len(trim(ls_ratecode)) = 0 or isnull(ls_ratecode) then
			lb_rate=true
		elseif lnva_item[ll_ndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_FrontChassisSplit or &
				 lnva_item[ll_ndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_BackChassisSplit or &
				 lnva_item[ll_ndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_StopOff then
					  lb_rate=true
		else
			ib_AskRecalculate=true
			exit			
		end if
	next
	
	if ib_AskRecalculate then	
		
		n_cst_setting_rerateconf	lnv_AskForRerate
		lnv_AskForRerate = CREATE n_cst_setting_rerateconf
		IF lnv_AskForRerate.of_getvalue( ) = lnv_AskForRerate.cs_yes THEN
			//Dan check for scheduler running here, and chooose default value if it is
			IF NOT gnv_app.of_runningscheduledtask( )  THEN
				li_res = messagebox('Auto Rate', "Do you want to re-rate non-special freight items based on this change? " + &
											"(If you say 'No', items may be marked as 'CUSTOM'.)", Question!, Yesno!)
			ELSE
				li_res = 1
			END IF
			choose case li_res
			//-----------------------------
				case 1
					ib_recalculate=true
					lb_rate=true
				case 2
					ib_recalculate=false
			end choose
		ELSE
			ib_recalculate=true
			lb_rate=true
		END IF
		
		DESTROY ( lnv_AskForRerate )
		
	end if
	
	//if lb_rate then   // commented by Rick and Norm on phone 6/13/03
		lnv_rating = create n_cst_bso_rating	
	
		lnv_rating.ClearOFRErrors ( )
		
		lnv_Shipment = this
		lnv_rating.of_setrecalculate(ib_recalculate)
		lnv_rating.of_SetWhatChanged(as_whatchanged)
		if lnv_rating.of_autorate( {lnv_Shipment} , lnva_rateData, n_cst_constants.ci_Category_Receivables, false ) = 1 then
			SetPointer(HourGlass!)
			lnv_rating.GetOFRErrors ( lnva_Errors )
			ll_errorcount = lnv_rating.GetErrorCount()
			if ll_errorcount > 0 then
				ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )
		
				if Len ( ls_errormessage ) > 0 then
					//OK
				else
					ls_errormessage = "Unspecified error on rating."
				end if
			
				if len(ls_errormessage) > 0 then
					if ls_errormessage = "Cancelled" then
						//Dan check for scheduler running here. was just returning -1 if user cancalled
						IF NOT Gnv_app.of_runningscheduledtask( ) THEN
							//user cancelled
							li_return = -1	
						ELSE
							li_return = 1		//user couldn't have cancelled if the scheduler is running
						END IF
						//------------------------------------
					else
						//Dan check for scheduler running here
						IF not Gnv_app.of_runningscheduledtask( ) THEN
							messagebox("Auto Rating", ls_errormessage)
						END IF
						//-------------------------------------
						li_return = -1
					end if
				end if
			else
				li_return = 1
			end if
			
			destroy lnv_rating
				
		end if
		if li_return = 1 then
			anva_ratedata = lnva_ratedata
		end if
	//end if
ELSE
	li_return = -1
END IF


return li_return

/* commented out when dan integrated FSC with autorating of imports
SetPointer(HourGlass!)
integer	li_return = 1

long 	ll_ratedatacount, &
		ll_ndx, &
		ll_errorcount, &
		ll_count
boolean	lb_rate

string	ls_errormessage, &
			ls_billto, &
			ls_origin, &
			ls_dest, &
			ls_ratecode, &
			ls_taglist

n_cst_bso_rating		lnv_rating
n_cst_beo_shipment	lnv_shipment
n_cst_beo_item			lnva_item[]
n_cst_RateData			lnva_rateData[]
n_cst_LicenseManager	lnv_LicenseManager
n_cst_OFRError			lnva_Errors[]

lnva_ratedata = anva_ratedata

ib_AskRecalculate = false
ib_Recalculate = false

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating  ) THEN
	//do i have all the data i need to rate ?
	ls_billto = string(this.of_getbillto())
	ls_origin = string(this.of_GetOrigin())
	ls_dest = string(this.of_getdestination())
	
	// if any items have a ratecode and a blank taglist then ask question,
	// otherwise we don't recalculate custom rates
	ll_count = this.of_getitemlist(lnva_item)
	for ll_ndx = 1 to ll_count
		
		//don't rate payable only
		if lnva_item[ll_ndx].of_GetAccountingType() = n_cst_constants.cs_AccountingType_Payable then
			continue
		end if	

		//only check for freight
		if lnva_item[ll_ndx].of_gettype() = n_cst_constants.cs_itemtype_accessorial then
			CONTINUE
		end if		
		ls_ratecode = lnva_item[ll_ndx].of_getratecodename()
		ls_taglist = lnva_item[ll_ndx].of_gettaglist()
		if ls_ratecode = 'CUSTOM' then
			CONTINUE
		elseif len(trim(ls_ratecode)) = 0 or isnull(ls_ratecode) then
			lb_rate=true
		elseif lnva_item[ll_ndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_FrontChassisSplit or &
				 lnva_item[ll_ndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_BackChassisSplit or &
				 lnva_item[ll_ndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_StopOff then
					  lb_rate=true
		else
			ib_AskRecalculate=true
			exit			
		end if
	next
	
	if ib_AskRecalculate then	
		
		n_cst_setting_rerateconf	lnv_AskForRerate
		lnv_AskForRerate = CREATE n_cst_setting_rerateconf
		IF lnv_AskForRerate.of_getvalue( ) = lnv_AskForRerate.cs_yes THEN
			choose case messagebox('Auto Rate', "Do you want to re-rate non-special freight items based on this change? " + &
											"(If you say 'No', items may be marked as 'CUSTOM'.)", Question!, Yesno!)
				case 1
					ib_recalculate=true
					lb_rate=true
				case 2
					ib_recalculate=false
			end choose
		ELSE
			ib_recalculate=true
			lb_rate=true
		END IF
		
		DESTROY ( lnv_AskForRerate )
		
	end if
	
	//if lb_rate then   // commented by Rick and Norm on phone 6/13/03
		lnv_rating = create n_cst_bso_rating	
	
		lnv_rating.ClearOFRErrors ( )
		
		lnv_Shipment = this
		lnv_rating.of_setrecalculate(ib_recalculate)
		lnv_rating.of_SetWhatChanged(as_whatchanged)
		if lnv_rating.of_autorate( {lnv_Shipment} , lnva_rateData, n_cst_constants.ci_Category_Receivables, false ) = 1 then
			SetPointer(HourGlass!)
			lnv_rating.GetOFRErrors ( lnva_Errors )
			ll_errorcount = lnv_rating.GetErrorCount()
			if ll_errorcount > 0 then
				ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )
		
				if Len ( ls_errormessage ) > 0 then
					//OK
				else
					ls_errormessage = "Unspecified error on rating."
				end if
			
				if len(ls_errormessage) > 0 then
					if ls_errormessage = "Cancelled" then
						//user cancelled
						li_return = -1
					else
						messagebox("Auto Rating", ls_errormessage)
						li_return = -1
					end if
				end if
			else
				li_return = 1
			end if
			
			destroy lnv_rating
				
		end if
		if li_return = 1 then
			anva_ratedata = lnva_ratedata
		end if
	//end if
ELSE
	li_return = -1
END IF


return li_return*/
end function

public function long of_applyfreightrate (n_cst_ratedata anva_ratedata[], string as_whatchanged, boolean ab_recalc);//i wrote this because w_ship was checked out and i couldn't change the arguments for a build
SetPointer(HourGlass!)
ib_AskRecalculate = false
ib_Recalculate = false
return this.of_ApplyFreightRate(anva_ratedata,'')

end function

public function time of_getprenotetime ();RETURN This.of_GetValue ( "prenotetime", TypeTime! )
end function

public function string of_getprenoteby ();RETURN This.of_GetValue ( "prenoteby", TypeString! )
end function

public function string of_getprenoteuser ();RETURN This.of_GetValue ( "prenoteuser", TypeString! )
end function

public function date of_getetadate ();RETURN This.of_GetValue ( "etadate", Typedate! )
end function

public function time of_getetatime ();RETURN This.of_GetValue ( "etaTime", TypeTime! )
end function

public function string of_getetaby ();RETURN This.of_GetValue ( "etaby", TypeString! )
end function

public function string of_getetauser ();RETURN This.of_GetValue ( "etauser", Typestring! )
end function

public function string of_getarrivedby ();RETURN This.of_GetValue ( "arrivedby", Typestring! )
end function

public function string of_getarriveduser ();RETURN This.of_GetValue ( "arriveduser", Typestring! )
end function

public function date of_getgroundeddate ();RETURN This.of_GetValue ( "groundeddate", TypeDate! )
end function

public function time of_getgroundedtime ();RETURN This.of_GetValue ( "groundedtime", Typetime! )
end function

public function string of_getgroundedby ();RETURN This.of_GetValue ( "groundedby", Typestring! )
end function

public function string of_getgroundeduser ();RETURN This.of_GetValue ( "groundeduser", Typestring! )
end function

public function string of_getpickupnumber ();RETURN This.of_GetValue ( "pickupnumber", Typestring! )
end function

public function string of_getpickupnumberby ();RETURN This.of_GetValue ( "pickupnumberby", Typestring! )
end function

public function string of_getpickupnumberuser ();RETURN This.of_GetValue ( "pickupnumberuser", Typestring! )
end function

public function string of_getbookingnumberby ();RETURN This.of_GetValue ( "bookingnumberby", TypeString! )
end function

public function string of_getbookingnumberuser ();RETURN This.of_GetValue ( "bookingnumberuser", TypeString! )
end function

public function date of_getreleasedate ();RETURN This.of_GetValue ( "releasedate", Typedate! )
end function

public function time of_getreleasetime ();RETURN This.of_GetValue ( "releasetime", Typetime! )
end function

public function string of_getreleaseby ();RETURN This.of_GetValue ( "releaseby", Typestring! )
end function

public function string of_getreleaseuser ();RETURN This.of_GetValue ( "releaseuser", Typestring! )
end function

public function string of_getlfdby ();RETURN This.of_GetValue ( "lfdby", Typestring! )
end function

public function string of_getlfduser ();RETURN This.of_GetValue ( "lfduser", Typestring! )
end function

public function string of_getpickupbyby ();RETURN This.of_GetValue ( "pickupbyby", Typestring! )
end function

public function string of_getpickupbyuser ();RETURN This.of_GetValue ( "pickupbyuser", Typestring! )
end function

public function date of_getdelbydate ();RETURN This.of_GetValue ( "delbydate", Typedate! )
end function

public function time of_getdelbytime ();RETURN This.of_GetValue ( "delbytime", Typetime! )
end function

public function string of_getdelbyby ();RETURN This.of_GetValue ( "delbyby", Typestring! )
end function

public function string of_getdelbyuser ();RETURN This.of_GetValue ( "delbyuser", Typestring! )
end function

public function string of_getcutoffuser ();RETURN This.of_GetValue ( "cutoffuser", Typestring! )
end function

public function date of_getemptyatcustomerdate ();RETURN This.of_GetValue ( "emptyatcustomerdate", Typedate! )
end function

public function time of_getemptyatcustomertime ();RETURN This.of_GetValue ( "emptyatcustomertime", Typetime! )
end function

public function string of_getemptyatcustomerby ();RETURN This.of_GetValue ( "emptyatcustomerby", Typestring! )
end function

public function string of_getemptyatcustomeruser ();RETURN This.of_GetValue ( "emptyatcustomeruser", Typestring! )
end function

public function date of_getloadedatcustomerdate ();RETURN This.of_GetValue ( "loadedatcustomerdate", Typedate! )
end function

public function time of_getloadedatcustomertime ();RETURN This.of_GetValue ( "loadedatcustomertime", Typetime! )
end function

public function string of_getloadedatcustomerby ();RETURN This.of_GetValue ( "loadedatcustomerby", TypeString! )
end function

public function string of_getloadedatcustomeruser ();RETURN This.of_GetValue ( "loadedatcustomeruser", TypeString! )
end function

public function string of_getrailbillnumber ();RETURN THIS.of_GetValue ( "railbillnumber" , TypeString! )
end function

public function string of_getrailbillnumberuser ();RETURN THIS.of_GetValue ( "railbillnumberuser" , TypeString! )
end function

public function date of_getrailbilleddate ();RETURN THIS.of_GetValue ( "railbilleddate" , Typedate! )
end function

public function string of_getrailbilledby ();RETURN THIS.of_GetValue ( "railbilledby" , Typestring! )
end function

public function string of_getrailbilleduser ();RETURN THIS.of_GetValue ( "railbilleduser" , Typestring! )
end function

public function string of_getcutoffby ();RETURN This.of_GetValue ( "cutoffby", Typestring! )
end function

public function date of_getpickupbydate ();RETURN THIS.of_GetValue ( "Pickupbydate" , typeDate! )
end function

public function time of_getpickupbytime ();RETURN THIS.of_GetValue ( "Pickupbytime" , typetime! )
end function

public function integer of_autorateeventtypeitem (string as_itemtype);Int	li_ItemCount
Int	li_i

n_cst_beo_Item	lnva_Items []
li_ItemCount = THIS.of_GetItemsForEventType ( as_ItemType , lnva_Items )

FOR li_i = 1 TO li_ItemCount 
	lnva_Items[li_i].of_SetShipment ( THIS )
	lnva_Items[li_i].of_AutoRateAndApply ( )
NEXT

RETURN 1
end function

public function integer of_setprenotedate (date ad_Value);RETURN This.of_SetAny ( "prenotedate", ad_Value )
end function

public function integer of_setprenotetime (time at_Value);RETURN THIS.of_SetAny ( "prenotetime" , at_Value )
end function

public function integer of_setprenoteuser (string as_Value);RETURN THIS.of_SetAny ( "PreNoteUser" , as_Value )
end function

public function integer of_setunspecifiedeventtype (string as_Type);Long		ll_Count
Long		ll_i
String	ls_Type 
n_cst_Beo_Event	lnva_Events[]

ll_Count = THIS.of_GetEventList ( lnva_Events )
FOR ll_i = 1 TO ll_Count
	ls_Type = lnva_Events[ll_i].of_GetType ( )
	IF IsNull ( ls_Type ) OR ls_Type = "" THEN
		lnva_Events[ll_i].of_SetType ( as_Type )
	END IF	
	DESTROY ( lnva_Events[ll_i] )
NEXT

RETURN 1
end function

public function integer of_getnotifyitems (ref n_cst_beo_item anva_items[]);Int	li_i
Int	li_Count
Int	li_KeepCount
n_cst_beo_Item	lnva_Items[]
n_cst_beo_Item	lnva_Empty[]

anva_items = lnva_Empty

li_Count = THIS.of_GetItemList ( lnva_Items )

FOR li_i = 1 TO li_Count 
	IF lnva_Items[li_i].of_SendNotification ( ) THEN
		li_KeepCount ++ 
		anva_items [ li_KeepCount ] = lnva_Items[li_i]	
		anva_items [ li_KeepCount ].of_SetShipment ( THIS )
		
	ELSE
		DESTROY ( lnva_Items[li_i])
	END IF
NEXT

RETURN UpperBound ( anva_Items )
end function

public function date of_getshipmentexpire ();
Date ldt_date

	

Return ldt_date

end function

public function integer of_setreleasedate (date ad_value);int	li_Return = -1
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso				lnv_Context
n_Cst_bso_Dispatch	lnv_Disp

li_Return  = THIS.of_SetAny ( "releasedate" , ad_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "releasedate" )
	
	lnv_Context = THIS.of_GetContext( )
	
	IF lnv_Context.Classname( ) = "n_cst_bso_dispatch" THEN
		
		lnv_Disp = lnv_Context
		ad_value = Date ( DateTime ( ad_value ) )
		
		THIS.of_SetEquipmentReleaseDate ( ad_value , lnv_Disp )
	END IF
	
END IF


RETURN li_Return
end function

public function integer of_getlinkedequipment (ref n_cst_beo_equipment2 anva_equipment[]);Int		li_Count
Int		li_Keep
Int		i
Long		ll_ShipmentID

n_cst_beo_Equipment2		lnva_Equipment2 []
n_cst_beo_Equipment2		lnva_KeepEquipment []

ll_ShipmentID = THIS.of_GetID ( )

li_Count = THIS.of_GetEquipmentList ( lnva_Equipment2 )

FOR i = 1 TO li_Count
	IF lnva_Equipment2[i].of_GetShipment ( ) = ll_ShipmentID OR lnva_Equipment2[i].of_GetReloadShipment ( ) = ll_ShipmentID THEN
		li_Keep ++ 
		lnva_KeepEquipment[li_Keep] = lnva_Equipment2[i]		
	ELSE 
		DESTROY  lnva_Equipment2[i]
	END IF
NEXT

anva_equipment[] =  lnva_KeepEquipment

RETURN li_Keep

end function

public function integer of_setequipmentreleasedate (date ad_value, ref n_cst_bso_dispatch anv_dispatch);Int		li_Return	= 1
Int		li_EqCount
Int		li_i

n_cst_beo_Equipment2			lnva_Equipment[]
n_Cst_beo_EquipmentLease2	lnv_EquipmentLease
n_cst_bso_Dispatch			lnv_Dispatch

lnv_Dispatch = anv_Dispatch
li_Return  = THIS.of_SetAny ( "releasedate" , ad_Value )

IF li_Return = 1 THEN

	li_EqCount = lnv_Dispatch.of_GetEquipmentForShipment ( THIS.of_GetID ( ) , lnva_Equipment ) 
	FOR li_i = 1 TO li_EqCount
		lnva_Equipment[li_i].of_GetEquipmentLease ( lnv_EquipmentLease )
		IF IsValid ( lnv_EquipmentLease ) THEN
			lnv_EquipmentLease.of_SetReleaseDate ( ad_value )
			DESTROY ( lnv_EquipmentLease )
		END IF
		DESTROY ( lnva_Equipment[li_i] )
	NEXT		

END IF

RETURN li_Return
end function

public function integer of_calculateequipmentleaseftx (n_cst_bso_dispatch anv_dispatch);//Int		li_Return	= 1
//Int		li_EqCount
//Int		li_i
//Long		ll_I
//Boolean	lb_AllRows 
//Boolean	lb_AllColumns 
//
//n_ds							lds_EquipmentCache
//DataStore					lds_Null
//DataWindow					ldw_Null
//n_cst_beo_Equipment2		lnva_Equipment[]
//n_cst_bso_Dispatch		lnv_Dispatch
//
//lnv_Dispatch = anv_Dispatch
//
//IF li_Return = 1 THEN
//	
//	li_EqCount = THIS.of_GetLinkedEquipment ( lnva_Equipment ) 
//	FOR li_i = 1 TO li_EqCount
//		lnva_Equipment[li_i].of_CalculateLeaseFreeTimeExpiration ( )
//	NEXT		
//
//	IF isValid ( lnv_dispatch ) THEN
//	//	lnv_Dispatch.of_RetrieveEquipmentForShipment ( THIS.of_GetID () )
//		lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( )
//	END IF
//	
//	IF isValid ( lds_EquipmentCache ) THEN
//			
//		IF gf_rows_sync(ids_equipment, ldw_Null, lds_EquipmentCache, ldw_Null, PRIMARY!, lb_AllRows, lb_AllColumns) <> 1 THEN
//			li_Return = -1
//		END IF
//		
//	END IF
//	
//	li_i = 1
//	
//END IF
//
RETURN -1//li_Return
//
end function

public function integer of_setequipmentreleasetime (time at_value, n_cst_bso_dispatch anv_dispatch);Int		li_Return	= 1
Int		li_EqCount
Int		li_i

n_cst_beo_Equipment2			lnva_Equipment[]
n_Cst_beo_EquipmentLease2	lnv_EquipmentLease
n_cst_bso_Dispatch			lnv_Dispatch

lnv_Dispatch = anv_Dispatch
li_Return  = THIS.of_SetAny ( "releasetime" , at_value )

IF li_Return = 1 THEN

	li_EqCount = lnv_Dispatch.of_GetEquipmentForShipment ( THIS.of_GetID ( ) , lnva_Equipment ) 
	FOR li_i = 1 TO li_EqCount
		lnva_Equipment[li_i].of_GetEquipmentLease ( lnv_EquipmentLease )
		IF IsValid ( lnv_EquipmentLease ) THEN
			lnv_EquipmentLease.of_SetReleaseTime ( at_value )
			DESTROY ( lnv_EquipmentLease )
		END IF
		DESTROY ( lnva_Equipment[li_i] )
	NEXT		

END IF

RETURN li_Return
end function

public function integer of_setreleasetime (time at_value);int	li_Return = -1
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso				lnv_Context
n_Cst_bso_Dispatch	lnv_Disp

li_Return  = THIS.of_SetAny ( "releasetime" , at_value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "releasetime" )
	
	lnv_Context = THIS.of_GetContext( )
	
	IF lnv_Context.Classname( ) = "n_cst_bso_dispatch" THEN
		lnv_Disp = lnv_Context
		THIS.of_SetEquipmentReleaseTime ( at_value , lnv_Disp ) 	
	END IF
	
END IF


RETURN li_Return
end function

public function integer of_setcustomtext (string as_Value, string as_WhichOne);// as_WhichOne should be the column name for the desired custom column
RETURN THIS.of_SetAny ( as_WhichOne , as_Value )
end function

public function integer of_setcustomtext (string as_Value, integer ai_WhichOne);String	ls_Column
IF ai_WhichOne > 0 AND ai_WhichOne < 11 THEN
	ls_Column = "custom" + string ( ai_WhichOne ) 
END IF

RETURN THIS.of_SetCustomText (as_Value, ls_Column )

		
end function

public function boolean of_isshiptypebrokerage ();n_cst_ship_Type	lnv_ShipTypeManager
n_cst_ShipType		lnv_ShipType
Boolean	lb_Return
Long		ll_ShipType

lnv_ShipTypeManager.of_Ready ( TRUE ) 

ll_ShipType = THIS.of_GetType ( ) 

lnv_ShipTypeManager.of_Get_Object ( ll_ShipType , lnv_ShipType )

IF lnv_ShipType.of_ISBrokerage ( ) THEN
	lb_Return = TRUE
ELSE
	lb_Return = FALSE
END IF

DESTROY ( lnv_Shiptype ) 

RETURN lb_Return
end function

public function integer of_getreloadequipment (ref n_Cst_beo_Equipment2 anva_Equipment[]);Int		li_Count
Int		li_Keep
Int		i
Long		ll_ShipmentID

n_cst_beo_Equipment2		lnva_Equipment2 []
n_cst_beo_Equipment2		lnva_KeepEquipment []

ll_ShipmentID = THIS.of_GetID ( )

li_Count = THIS.of_GetEquipmentList ( lnva_Equipment2 )

FOR i = 1 TO li_Count
	IF lnva_Equipment2[i].of_GetReloadShipment ( ) = ll_ShipmentID THEN
		li_Keep ++ 
		lnva_KeepEquipment[li_Keep] = lnva_Equipment2[i]		
	ELSE 
		DESTROY  lnva_Equipment2[i]
	END IF
NEXT

anva_equipment[] =  lnva_KeepEquipment

RETURN li_Keep

end function

public function integer of_eventsitechanged (long al_oldsiteid, long al_newsiteid, long al_eventid);//RDT 8-12-03 	Move sequence of events

int	li_Return = 1
Long	ll_OldSite
n_cst_ContactManager	lnv_Contacts
n_cst_beo_Company		lnv_Company

n_cst_ShipmentManager	lnv_ShipmentManager
lnv_Contacts = CREATE n_cst_ContactManager
lnv_Company = CREATE n_Cst_Beo_Company

ll_OldSite = al_oldSiteid

lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID ( ll_OldSite )

THIS.of_markasmodified( ) // this is here only to force an update to the shipment summary screen.

IF li_Return = 1 THEN

	IF lnv_Company.of_HasSource ( ) THEN
		lnv_Contacts.of_RemoveContactsIfNeeded ( THIS , lnv_Company )
	END IF
	lnv_Company.of_SetSourceID ( al_newSiteid )
//	lnv_Contacts.of_AddContactsIfNeeded ( THIS , lnv_Company , n_cst_companies.cs_companyrole_EventSite )
	
//	IF THIS.of_IsIntermodal ( ) THEN
	lnv_ShipmentManager.of_SetOriginDestination ( THIS , al_EventID, al_oldSiteid , al_newSiteid  )	
//	END IF

	lnv_Contacts.of_AddContactsIfNeeded ( THIS , lnv_Company , n_cst_companies.cs_companyrole_EventSite )	//RDT 8-12-03 	


END IF


DESTROY ( lnv_Contacts ) 
DESTROY ( lnv_Company )

RETURN li_Return



end function

public function long of_addstopoffitem (n_cst_beo_event anv_event, n_cst_bso_dispatch anv_dispatch);string	ls_codename

long	ll_ratedatacount, &
		ll_ndx, &
		ll_ItemID
		
n_cst_bso_Dispatch 	lnv_Dispatch
n_cst_beo_Item			lnv_Item
n_cst_beo_Item			lnva_ItemList[]
n_cst_AnyArraySrv		lnv_ArraySrv

lnv_Item = CREATE n_cst_beo_Item

lnv_Dispatch = anv_Dispatch

IF THIS.of_GetItemsForEventType ( n_cst_Constants.cs_ItemEventType_STOPOFF ,  lnva_ItemList ) = 0 THEN

	ll_ItemID = THIS.of_AddItem ( "L" , lnv_Dispatch )
	IF ll_ItemID > 0 THEN
		lnv_Item.of_SetSource ( lnv_Dispatch.of_GetItemCache ( ) )
		lnv_Item.of_SetSourceID ( ll_ItemID )
		lnv_Item.of_SetShipment ( THIS )
		lnv_Item.of_SetDescription ( "STOPOFF" )
		lnv_Item.of_SetEventTypeFlag ( n_cst_Constants.cs_ItemEventType_STOPOFF )
	END IF		
ELSE
	lnva_ItemList[1].of_setquantity ( lnva_ItemList[1].of_getquantity ( ) + 1 )
END IF

lnv_ArraySrv.of_Destroy ( lnva_ItemList )
DESTROY ( lnv_Item ) 

RETURN ll_ItemID

end function

public function boolean of_hasfuelsurcharge ();Boolean	lb_Return
Int		li_ItemCount
Int		i

n_cst_beo_item	lnva_Items[]
n_cst_AnyArraySrv		lnv_ArraySrv

li_ItemCount = THIS.of_GetItemList ( lnva_Items )

FOR i = 1 TO li_ItemCount 
	IF lnva_Items[i].of_GetEventTypeFlag ( ) = n_Cst_Constants.cs_ItemEventType_FuelSurcharge  THEN
		lb_Return = TRUE
		EXIT
	END IF
NEXT

lnv_ArraySrv.of_Destroy ( lnva_Items )

RETURN lb_Return

end function

public function long of_recalcsurcharges ();/* 
	IF a Fuel Surcharge exists THEN 
	   We will update it to the current state of the shipment. This may include removing the
		Surcharge if the net amount of the charge = 0
	ELSE
		we will see if a Surcharge should be added. Contributing factors in determining this 
		will be the the system setting as well as the bill to.
	END IF

	Currently this method only works with Fuel surcharges. There is no reason that this can't be extended later
	
*/

Boolean	lb_AddSurcharge 
Int	li_Count
Int	i
integer	x
string	ls_SurchargeType
String	ls_Recalc
Constant string	lcs_recalc = "No"

n_cst_beo_Item	lnva_Items[]
n_cst_beo_Company	lnv_Company
n_cst_Settings		lnv_Settings
n_cst_setting_recalcFuelSurcharge	lnv_fuelSurchargeSetting
n_cst_ShipmentManager	lnv_ShipmentManager

lnv_fuelSurchargeSetting = create n_cst_setting_recalcFuelSurcharge
li_Count = this.of_getitemsforeventtype ( n_cst_Constants.cs_ItemEventType_FuelSurcharge , lnva_Items ) 
ls_Recalc = lnv_fuelSurchargeSetting.of_getvalue( )

lb_AddSurcharge = lnv_Settings.of_AddFuelSurcharge ( ) 

Dec lc_Surcharge

IF lb_AddSurcharge THEN
	//get the surcharge type
	IF THIS.of_GetBillToCompany ( lnv_Company, TRUE ) = 1 AND lb_AddSurcharge THEN  
		//lb_AddSurcharge = lnv_Company.of_AddFuelSurcharge ( )  
		if lnv_Company.of_hascustomfuelsurcharge( ) then
			ls_SurchargeType = lnv_Company.of_GetFuelSurchargeType ( )
			lc_Surcharge = lnv_Company.of_GetCustomFuelSurcharge ( )
		else
			ls_SurchargeType = lnv_ShipmentManager.of_GetFuelSurchargeType ( )
			lnv_ShipmentManager.of_GetFuelsurcharge( lc_Surcharge)
		end if
	ELSE
		ls_SurchargeType = lnv_ShipmentManager.of_GetFuelSurchargeType ( )
		lnv_ShipmentManager.of_GetFuelsurcharge( lc_Surcharge)
	END IF
END IF


IF isNull ( lc_Surcharge ) OR lc_Surcharge = 0 THEN
	lb_AddSurcharge = FALSE
END IF



IF lb_AddSurcharge THEN
//call method to get surcharge type (company override or system?)

	IF THIS.of_GetFuelSurchargeableAmount (ls_SurchargeType) > 0 THEN
		
		IF li_Count > 0 THEN
			FOR i = 1 TO li_Count
				//Added by dan this condition
				//if setting is yes or has new fuel surcharge
				IF ls_Recalc <> lcs_recalc OR this.of_hasnewfuelsurcharge( ) THEN
					lnva_Items[i].of_MakeFuelSurcharge ( ) // this will recalc the surcharge.
					IF lnva_Items[i].of_GetBillingAmount ( ) = 0 OR NOT lb_AddSurcharge THEN
						for x = 1 to 5
							yield()
						next	
						//mod 2-16-2006  this replaced this.removeItem
						lnva_Items[i].of_resetFuelSurcharge()
		
//						THIS.of_RemoveItem ( lnva_Items[i] )
					END IF
					DESTROY ( lnva_Items[i] )
				ELSE
					//added all this by dan 2-15-2006
					lnva_Items[i].of_MakeFuelSurcharge ( TRUE ) // this will recalc the surcharge.
					IF lnva_Items[i].of_GetBillingAmount ( ) = 0 OR NOT lb_AddSurcharge THEN
						for x = 1 to 5
							yield()
						next	
						
						//mod 2-16-2006  this replaced this.removeItem
						lnva_Items[i].of_resetFuelSurcharge()
//						THIS.of_RemoveItem ( lnva_Items[i] )
					END IF
					DESTROY ( lnva_Items[i] )
					//--------------
				END IF	//added this line
			NEXT
		ELSE
			
			IF lb_AddSurcharge THEN
			
				THIS.of_AddItem ( "FUELSURCHARGE!" ) 
				
			END IF
	
			// added this <<*>>
			li_Count = this.of_getitemsforeventtype ( n_cst_Constants.cs_ItemEventType_FuelSurcharge , lnva_Items ) 
			FOR i = 1 TO li_Count
				IF lnva_Items[i].of_GetBillingAmount ( ) = 0  THEN
					for x = 1 to 5
						yield()
					next	
					
					//mod 2-16-2006  this replaced this.removeItem
					lnva_Items[i].of_resetFuelSurcharge()
		
				//	THIS.of_RemoveItem ( lnva_Items[i] )
				END IF
				DESTROY ( lnva_Items[i] )
			NEXT
			// end of added
	
			
		END IF
	ELSE
		lb_AddSurcharge = FALSE
	END IF

	IF Not lb_AddSurcharge THEN
		//need to allow other processing to finish before removing the surcharge		
		for x = 1 to 10
			yield()
		next	
		FOR i = 1 TO li_Count
			//mod 2-16-2006  this replaced this.removeItem
			lnva_Items[i].of_resetFuelSurcharge()
		
			//THIS.of_RemoveItem ( lnva_Items[i] )
			DESTROY ( lnva_Items[i] )
		NEXT
	
	END IF
ELSE
	IF li_Count > 0 AND lnv_Settings.of_AddFuelSurcharge ( ) THEN
		
		FOR i = 1 TO li_Count
			lnva_Items[1].of_MakeFuelSurcharge()
		next
	END IF
END IF


IF isValid(lnv_fuelSurchargeSetting) THEN
	Destroy lnv_fuelSurchargeSetting
END IF

RETURN 1 




end function

public function integer of_removeitem (n_cst_beo_item anv_item);Int		li_Return = -1
Boolean	lb_Continue 
Long		ll_ItemID
Long		ll_ItemRow
String	ls_Find
String	ls_OldDocType
dwbuffer	le_Buffer

n_cst_beo_Item	lnv_Item
n_cst_bso		lnv_Dispatch
n_ds				lds_ItemCache

lnv_Dispatch = THIS.of_GetContext ( ) 
IF IsValid ( lnv_Dispatch ) THEN
	IF lnv_Dispatch.Classname ( ) = "n_cst_bso_dispatch" THEN
		lb_Continue = TRUE
	END IF
END IF

IF lb_Continue THEN
	lnv_Item = anv_Item
	lb_Continue = IsValid ( lnv_Item ) 
END IF

IF lb_Continue THEN
	ll_ItemID = lnv_Item.of_GetID ( )
	lb_Continue = ll_ItemID > 0 	
END IF

IF lb_Continue THEN 
	IF THIS.of_RemoveItem( ll_ItemID ,lnv_dispatch ) = 1 THEN
		li_Return = 1
	END IF
END IF


RETURN li_Return


end function

public function long of_additem (string as_type);RETURN THIS.of_AddItem ( as_type , FALSE ) 

end function

public function integer of_recalcexistingsurcharges ();//Modified by Dan 1-4-2006 to use the newer version of this function.  The default behavior of this function is
//still accomplished when passing FALSE in as a parameter to the new version.
/* 
	this method can be called to ReCalc any existing surcharges. It will not add or remove any items	
	Returns the number of items recalculated
*/

return this.of_recalcExistingSurcharges( FALSE )

//Int	li_Count
//Int	i
//Int	j
//n_cst_beo_Item	lnva_Items[]
//
//li_Count = this.of_getitemsforeventtype ( n_cst_Constants.cs_ItemEventType_FuelSurcharge , lnva_Items ) 
//	
//FOR i = 1 TO li_Count
//	lnva_Items[i].of_MakeFuelSurcharge ( ) // this will recalc the surcharge.	
//	IF lnva_Items[i].of_GetBillingAmount ( ) = 0 THEN
//		For j = 1 TO 5
//			Yield ()
//		NEXT
//		THIS.of_RemoveItem ( lnva_Items[i] )
//	END IF
//	DESTROY ( lnva_Items[i] )
//NEXT
//		
//
//RETURN li_Count 
//
//
//

end function

public function integer of_reseteqcache ();DESTROY ( ids_Equipment )
RETURN 1
end function

public function integer of_getroutedevents (ref n_cst_beo_Event anva_EventList[]);n_cst_beo_Event	lnva_EventList []
n_cst_beo_Event	lnva_RoutedEventList []

Int	li_EventCount
Int	li_EventIndex
Int	li_RoutedCount


THIS.of_GetEventList ( lnva_EventList )


li_EventCount = UpperBound ( lnva_EventList )

FOR li_EventIndex = 1 TO li_EventCount
	IF lnva_EventList [ li_EventIndex ].of_IsRouted ( ) THEN
		li_RoutedCount ++ 
		lnva_RoutedEventList [ li_RoutedCount ] = lnva_EventList [ li_EventIndex ]
	ELSE
		DESTROY ( lnva_EventList [ li_EventIndex ] )
	END IF
NEXT 

anva_EventList[] = lnva_RoutedEventList

RETURN li_RoutedCount 


end function

public function integer of_setpickupnumber (string as_value);Int	li_Return
Long	ll_Row 
Date	ld_Today
Boolean	lb_FillReleased
n_cst_Setting_PickupNumberFillReleased		lnv_FillReleased

li_Return = THIS.of_SetAny ( "pickupnumber" , as_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "pickupnumber" )
	
	lnv_FillReleased = Create n_cst_Setting_PickupNumberFillReleased
	lb_FillReleased = (lnv_FillReleased.of_GetValue() = lnv_FillReleased.cs_Yes)
	Destroy(lnv_FillReleased)
	
	IF lb_FillReleased THEN
		ld_Today = Today ( )
		ld_Today = Date ( DateTime ( ld_Today ) )
	
		IF IsNull ( THIS.of_getreleasedate( ) ) THEN
			THIS.of_setreleasedate( ld_Today )
		END IF
		
		IF IsNull ( THIS.of_GetReleaseTime( )  ) THEN
			THIS.of_SetReleaseTime ( Now ( ) )
		END IF
	END IF

	IF THIS.of_GetRef1Type ( ) = 24 THEN
		THIS.of_SetRef1Text ( as_value )
	END IF
	
	IF THIS.of_GetRef2Type ( ) = 24 THEN
		THIS.of_SetRef2Text ( as_value )
	END IF
	
	IF THIS.of_GetRef3Type ( ) = 24 THEN
		THIS.of_SetRef3Text ( as_value )
	END IF
END IF			
			
RETURN li_Return
end function

public function integer of_addtomodlog (string as_Value);String	ls_ModLog

ls_ModLog	= THIS.of_GetModLog ( )
IF isNull ( ls_ModLog ) THEN
	ls_ModLog = ""
END IF
ls_ModLog += as_Value

RETURN THIS.of_SetAny ( "ds_mod_log" , ls_ModLog )

end function

private function integer of_removestopoffitem ();string	ls_codename

long	ll_ratedatacount, &
		ll_ndx
Int	li_Return
		
		
n_cst_bso_Dispatch 	lnv_Dispatch
n_cst_beo_Item			lnva_ItemList[]
n_cst_AnyArraySrv		lnv_ArraySrv

IF THIS.of_GetItemsForEventType ( n_cst_Constants.cs_ItemEventType_STOPOFF ,  lnva_ItemList ) = 0 THEN
	// 
ELSE
	lnva_ItemList[1].of_setquantity ( lnva_ItemList[1].of_getquantity ( ) - 1 )
	
	IF lnva_ItemList[1].of_Getquantity ( ) = 0 THEN
		THIS.of_RemoveItem ( lnva_ItemList[1] )
	END IF
	
END IF

lnv_ArraySrv.of_Destroy ( lnva_ItemList )

RETURN -1
end function

private function integer of_removestopoffifneeded ();RETURN -1
end function

public function boolean of_hasfrontchassissplit ();Long					ll_EventCount
Boolean				lb_Return

n_cst_AnyArraySrv	lnv_Array
n_cst_beo_Event	lnva_EventList	[]


IF THIS.of_GetEventList ( lnva_EventList )  > 1 THEN
		
	lb_Return = lnva_EventList[ 1 ].of_GetType ( ) = gc_Dispatch.cs_EventType_HOOK AND &
					lnva_EventList[ 2 ].of_GetType ( ) = gc_Dispatch.cs_EventType_MOUNT	
	
END IF

lnv_Array.of_Destroy ( lnva_EventList )

RETURN lb_Return
end function

public function boolean of_hasbackchassissplit ();Long					ll_EventCount
Boolean				lb_Return

n_cst_AnyArraySrv	lnv_Array
n_cst_beo_Event	lnva_EventList	[]

ll_EventCount = THIS.of_GetEventList ( lnva_EventList ) 
IF ll_EventCount >= 3 THEN
		
	lb_Return = lnva_EventList[ll_EventCount - 1 ].of_GetType ( ) = gc_Dispatch.cs_EventType_Dismount AND &
					lnva_EventList[ll_EventCount ].of_GetType ( ) = gc_Dispatch.cs_EventType_Drop	
	
END IF

lnv_Array.of_Destroy ( lnva_EventList )

RETURN lb_Return
	
	





end function

public function integer of_frontchassissplitadded (n_cst_bso_dispatch anv_dispatch);Int	li_Return = 1
Int	li_EventCount

n_cst_AnyArraySrv	lnv_Array
n_Cst_beo_Event	lnva_EventList[]
n_Cst_beo_Event	lnv_Event
n_Cst_beo_Event	lnv_HookEvent

li_EventCount = THIS.of_GetEventList ( lnva_EventList )

// I need to see if the mount (event 2) is routed and if it
// is route the Hook (event 1) to the same piece of equipment
IF li_EventCount > 1 THEN  // should be b.c. of the chassis split
	lnv_HookEvent = lnva_EventList[1]
	lnv_Event = lnva_EventList[2]
	
	li_Return = anv_Dispatch.of_DuplicateRouting ( lnv_Event.of_GetID ( ) , {lnv_HookEvent.of_getID ( )} , gc_dispatch.ci_InsertionStyle_Before )

END IF

lnv_Array.of_Destroy ( lnva_EventList )

RETURN li_Return



end function

public function integer of_backchassissplitadded (n_cst_bso_dispatch anv_dispatch);Int	li_EventCount
Int	li_Return

n_cst_AnyArraySrv	lnv_Array
n_Cst_beo_Event	lnva_EventList[]
n_Cst_beo_Event	lnv_DropEvent
n_Cst_beo_Event	lnv_DismountEvent

li_EventCount = THIS.of_GetEventList ( lnva_EventList )

// I need to see if the dismount (event li_EventCount - 1 ) is routed and if it
// is route the Drop  (event li_EventCount) to the same piece of equipment
IF li_EventCount > 1 THEN  // should be b.c. of the chassis split

	lnv_DismountEvent = lnva_EventList[li_EventCount - 1]
	lnv_DropEvent = lnva_EventList[li_EventCount]
	
	li_Return = anv_Dispatch.of_DuplicateRouting ( lnv_DismountEvent.of_GetID ( ) , {lnv_DropEvent.of_getID ( )}, gc_dispatch.ci_InsertionStyle_After )
		
END IF

lnv_Array.of_Destroy ( lnva_EventList )

RETURN li_Return
end function

public function integer of_resetcontacts (ref n_cst_beo_event anv_event, string as_action, string as_type, ref long ala_contactid[], long al_site);// RDT 8-21-03 resets the contacts based on new origin & Destination
// I don't think this is called. However, I am not going to delete it 
// until I am sure
Integer	li_Return = 1

Integer	i

Long		ll_OldSite, &
			lla_ContactID[]

n_cst_ContactManager	lnv_Contacts
n_cst_beo_Company		lnv_Company
n_cst_beo_Event		lnva_Events[]
n_cst_beo_Event		lnv_Event
n_cst_ShipmentManager	lnv_ShipmentManager

lnv_Contacts = CREATE n_cst_ContactManager
lnv_Company = CREATE n_Cst_Beo_Company

n_cst_anyarraysrv lnv_Arrarysrv

This.of_geteventlist ( lnva_events[] )

If as_action = "REMOVE" Then 
	
	If as_type = "ORIGIN" Then 
		
		// Find the origin event
		li_Return = -1
		For i = 1 to UpperBound( lnva_events[] ) 
			If lnva_Events[i].of_IsOrigin( al_Site ) then 
				lnv_event = lnva_Events[i]
				li_Return = 1
				Exit
			End if
		Next 
	End if
	
	// Find the Destination event
	If as_type = "DESTINATION" Then 
		li_Return = -1
		For i = 1 to UpperBound( lnva_events[] ) 
			If lnva_Events[i].of_IsDestination( al_Site ) then 
				lnv_event = lnva_Events[i]
				li_Return = 1
				Exit
			End if
		Next 
	End if
	
	If li_return = 1 then 
		// remove them from the old event
		lnv_Event.of_getnotificationtargets ( ala_Contactid[] )
		For i = 1 to UpperBound( ala_Contactid[] )
			lnv_Event.of_removecontactid ( ala_Contactid[i] )
		next	
	End if

end if

If li_Return = 1 then 
	If as_action = "ADD" Then 
		// ADD to the passed in event
		For i = 1 to UpperBound( ala_Contactid[] )
			anv_event.of_addcontactid ( ala_Contactid[i] )
		next	
	End If
end if


DESTROY ( lnv_Contacts ) 
DESTROY ( lnv_Company )
lnv_Arrarysrv.of_destroy ( lnva_Events[] )

RETURN li_Return



end function

public function integer of_geteventbyorigindestination (ref n_cst_beo_event anva_beo_event[], string as_type);// RDT 8-22-03 of_GetEventByOrginDestination (anva_beo_event[],as_type )

Integer  li_Return = 1
integer	li_result, &
			i

Long		ll_Origin, &
			ll_Destination

n_cst_beo_Event lnva_Event[]

If as_type = "O" then 
	
	ll_Origin = This.of_GetOrigin()
	li_result = This.of_GetEventList(lnva_Event)
	
	For i = 1 to li_Result
		if lnva_Event[i].of_isorigin(ll_origin) then 
			anva_beo_Event[ UpperBound( anva_beo_Event[] ) +1 ] = lnva_Event[i]
		End if
	Next
	
	li_Return = UpperBound( anva_beo_Event[] )
End if


If as_type = "D" then 
	ll_Destination = This.of_GetDestination ()
	li_result = This.of_GetEventList(lnva_Event)
	
	For i = 1 to li_Result
		if lnva_Event[i].of_isDestination(ll_Destination) then 
			anva_beo_Event[ UpperBound( anva_beo_Event[] ) +1 ] = lnva_Event[i]
		End if
	Next
	
	li_Return = UpperBound( anva_beo_Event[] )
End if

Return li_Return 
end function

public function integer of_geteventcompanies (ref long ala_companyid[]);// RDT 8-22-03 of_GetEventCompanies(ala_companyid[] ref)
//get all companies for all all events 


int	li_Return = 1, &
		i
		
Long	lla_ContactId[], &
		lla_Blank[], &
		lla_AllContactList[], &
		lla_CompanyId[], &
		ll_CompanyCount, &
		ll_RowCount, &
		ll_CompanyId , &
		ll_row , &
		ll_SameCompany

String	ls_CompanyNotetype

n_cst_beo_Company		lnv_Company

lnv_Company = CREATE n_Cst_Beo_Company
lnv_Company.of_SetUseCache ( TRUE ) 

n_cst_beo_Event	lnv_Event[]

n_cst_anyarraysrv  lnv_AnyArraySrv

n_cst_bso_Notification_Manager lnv_Notification_Manager 
lnv_Notification_Manager = Create n_cst_bso_Notification_Manager 

n_ds lds_company
lds_Company = Create n_ds

lds_Company.Dataobject = 'd_companycodename'						// This groups contacts by company 
lds_Company.SetTransObject(SQLCA)

// 	
	
// Get all events
This.Of_GetEVentList( lnv_Event[] ) 

// Get all contact for each event
For i = 1 to UpperBound( lnv_Event[] ) 
	lnv_event[i].of_geteventcontacts ( lla_contactID[]  )

	// add ids to save array
	lnv_AnyArraySrv.of_appendlong ( lla_AllContactList[], lla_contactID[] )
	
	// clear Old contact
	lla_contactID[]  = lla_Blank[]

Next 

lnv_anyarraysrv.of_getshrinked ( lla_AllContactList[], TRUE , TRUE )

If UpperBound( lla_AllContactList ) > 0 Then 

	// Get all Companies for all contacts 
	ll_RowCount = lds_Company.Retrieve( lla_AllContactList[] )
	For ll_Row = 1 to ll_RowCount 
		ll_CompanyId = lds_Company.GetItemNumber(ll_Row , 'companies_co_id')
		If ll_SameCompany <> ll_CompanyId Then 
			lla_CompanyId[ UpperBound( lla_CompanyId )+ 1 ] = ll_CompanyId 
			ll_SameCompany = ll_CompanyId 
		End If
	Next 

	ala_CompanyID[] = lla_CompanyId 
	li_Return = UpperBound( lla_CompanyId )

Else
	li_Return = -1
End If


Return li_Return 
end function

public function integer of_reseteventcontacts ();// RDT 8-22-03 
/*

get all companies and loop thru all events and reset the origin or desination contacts to the defaults 
this includes removeing contacts from old destination 

*/

int	li_Return = 1, &
		li_OldCount, &
		li_NewCount, &
		i, &
		li_ContactCount 
		
Long	lla_CompanyId[], &
		ll_Comp_i, &
		ll_Event_i, &
		ll_CompanyId , &
		ll_comp_Max , &
		ll_Event_Max
		

String	ls_CompanyNotetype

n_cst_contactmanager lnv_contactmanager
lnv_contactmanager = Create n_cst_contactmanager 
n_cst_beo_Company		lnv_Company
lnv_Company = CREATE n_Cst_Beo_Company
lnv_Company.of_SetUseCache ( TRUE ) 

n_cst_beo_Event	lnva_Event[]

n_cst_anyarraysrv  lnv_AnyArraySrv

n_cst_bso_Notification_Manager lnv_Notification_Manager 
lnv_Notification_Manager = Create n_cst_bso_Notification_Manager 

ll_Comp_Max = This.of_GetEventCompanies( lla_CompanyId[] )

If ll_Comp_Max > 0 then 
	// Loop thru each event and set the company defaults
	ll_Event_max = This.of_GetEventList( lnva_Event )
	
	For ll_Comp_i = 1 to ll_Comp_Max
		//set company on beo
	
		lnv_company.of_SetSourceID( lla_CompanyId[ ll_Comp_i ] )

		For ll_Event_i = 1 to ll_Event_Max
			// is an origin OR Destination company and event is ? then remove contacts		
			
			/*
			 	<<*>> RPZ I split up the code below to evaluate n_cst_constants.cs_notificatioevent_orig and
				n_cst_constants.cs_notificatioevent_dest seperatly. Also I added the check for pickup/Deliver group
				9/17/03
				
				
				Old code :
				
				If ( lnv_company.of_getnotificationeventorigin (  ) =  n_cst_constants.cs_notificatioevent_orig ) OR &
				( lnv_Company.of_getnotificationeventdestination ( ) = n_cst_constants.cs_notificatioevent_dest ) Then 
				
				IF NOT ( lnva_Event[ ll_event_i ].of_isOrigin( This.of_GetOrigin() ) ) AND &
					NOT ( Lnva_Event[ll_event_i].of_IsDestination( This.of_GetDestination () ) ) Then 
					lnv_Notification_Manager.of_eventcompanycontact ( lla_CompanyId[ ll_Comp_i ], lnva_Event[ ll_Event_i ] , FALSE/*Delete*/)					
				End If
				End If
				
			*/
			
			IF lnva_Event [ ll_Event_i ].of_IsPickupGroup ( ) THEN
				If  lnv_company.of_getnotificationeventorigin (  ) =  n_cst_constants.cs_notificatioevent_orig  Then 				
					IF NOT ( lnva_Event[ ll_event_i ].of_isOrigin( This.of_GetOrigin() ) )  Then 
						lnv_Notification_Manager.of_eventcompanycontact ( lla_CompanyId[ ll_Comp_i ], lnva_Event[ ll_Event_i ] , FALSE/*Delete*/)					
					End If
				End If
				
			ELSEIF lnva_Event [ ll_Event_i ].of_IsDeliverGroup ( ) THEN
				
				If lnv_Company.of_getnotificationeventdestination ( ) = n_cst_constants.cs_notificatioevent_dest Then 				
					IF NOT ( Lnva_Event[ll_event_i].of_IsDestination( This.of_GetDestination () ) ) Then 
						lnv_Notification_Manager.of_eventcompanycontact ( lla_CompanyId[ ll_Comp_i ], lnva_Event[ ll_Event_i ] , FALSE/*Delete*/)					
					End If
				End If
			END IF
			
			//is this is a origin event?
			IF lnva_Event[ ll_event_i ].of_isOrigin( This.of_GetOrigin() )  Then 
				
				// is this an origin company ?
				If ( lnv_company.of_getnotificationeventorigin (  ) =  n_cst_constants.cs_notificatioevent_orig ) Then 
					// add the contacts to the event
					lnv_Notification_Manager.of_eventcompanycontact ( lla_CompanyId[ ll_Comp_i ], lnva_Event[ ll_Event_i ] , TRUE /*ADD*/)

				Else
					// remove contacts from event
					//RDT 8-27-03 lnv_Notification_Manager.of_eventcompanycontact ( lla_CompanyId[ ll_Comp_i ], lnva_Event[ ll_Event_i ] , FALSE/*Delete*/)

				End if					
					
			End if					
				
			// is this a destination event
			If Lnva_Event[ll_event_i].of_IsDestination( This.of_GetDestination () )  Then 

				// Is this a Desintation company 
				If  lnv_Company.of_getnotificationeventdestination ( ) = n_cst_constants.cs_notificatioevent_dest  Then 
					// add the contacts to the event
					lnv_Notification_Manager.of_eventcompanycontact ( lla_CompanyId[ ll_Comp_i ], lnva_Event[ ll_Event_i ] , TRUE /*ADD*/)

				Else
					// remove contacts from event
					//RDT 8-27-03 lnv_Notification_Manager.of_eventcompanycontact ( lla_CompanyId[ ll_Comp_i ], lnva_Event[ ll_Event_i ] , FALSE/*Delete*/)

				End If
				
			End If	

		Next // event
	
	Next // company
Else
	// no companies exist on shipment yet.
	li_Return = -1
End If

Destroy ( lnv_contactmanager )
Destroy ( lnv_Company  )
Destroy ( lnv_Notification_Manager )

lnv_AnyarraySrv.of_Destroy( lnva_Event )

Return li_Return
end function

public function integer of_moveeventcontacts (ref n_cst_beo_event anva_oldevent[], ref n_cst_beo_event anva_newevent[], string as_orgindestination);// RDT 8-22-03 
/* of_MoveEventContacts( anva_oldevent[ ]ref, anva_newevent[]ref, as_orgindestination value)
*/

int	li_Return = 1, &
		li_OldCount, &
		li_NewCount, &
		i, &
		li_ContactCount 
		
Long	lla_ContactIds[], &
		lla_SaveContactIds[], &
		ll_CompanyCount, &
		ll_RowCount, &
		ll_CompanyId , &
		ll_row , &
		ll_Upper, &
		ll_rowcontact, &
		ll_SameCompany

String	ls_CompanyNotetype

n_cst_beo_Company		lnv_Company
lnv_Company = CREATE n_Cst_Beo_Company
lnv_Company.of_SetUseCache ( TRUE ) 

n_cst_bso_Notification_Manager lnv_Notification_Manager 
lnv_Notification_Manager = Create n_cst_bso_Notification_Manager 
n_ds lds_company
lds_Company = Create n_ds

lds_Company.Dataobject = 'd_companycodename'						// This groups contacts by company 
lds_Company.SetTransObject(SQLCA)
	
// loop thru old events and get contactids
li_Oldcount = UpperBound( anva_oldevent[] )
li_NewCount = UpperBound( anva_newevent[] )

// remove companies from old events if needed.
For i = 1 to li_Oldcount 
	
	anva_oldevent[i].of_Getnotificationtargets ( lla_ContactIds [])

	If UpperBound( lla_ContactIds[]) > 0 then 
		
		ll_RowCount = lds_Company.Retrieve( lla_contactids[] )
		
		For ll_row = 1 to ll_RowCount 	 		
			ll_CompanyId = lds_Company.GetItemNumber(ll_Row , 'companies_co_id')
			
			If ll_SameCompany <> ll_CompanyId Then 
				
				ll_SameCompany = ll_CompanyId
				// set the company source
				lnv_Company.of_SetSourceID ( ll_CompanyId )
				
				// get company role / notification type 
				If Upper( Left( as_orgindestination, 1) ) = "O" Then 
					
					If  lnv_Company.of_getnotificationeventorigin ( ) = n_cst_constants.cs_notificatioevent_orig Then 
						// remove the contacts for this company
						//lnv_Notification_Manager.of_eventcompanycontact ( ll_CompanyId, anva_oldevent[i], FALSE /*remove*/ )
						
						// loop thru datastore and save contacts for the company to be removed 
						For ll_rowcontact = 1 to ll_RowCount
							If lds_Company.GetItemNumber(ll_rowcontact , 'companies_co_id') = ll_CompanyId Then 
								lla_SaveContactIds[ UpperBound( lla_SaveContactIds ) + 1] = &
														lds_Company.GetItemNumber(ll_rowcontact , 'contacts_ct_id')
							End If
						Next
			
					End if
					
				Else
					
					IF lnv_Company.of_getnotificationeventdestination ( ) = n_cst_constants.cs_notificatioevent_dest Then 
						// remove Company ids
						//lnv_Notification_Manager.of_eventcompanycontact ( ll_CompanyId, anva_oldevent[i], FALSE /*remove*/ )				
		
						// loop thru datastore and save contacts for the company to be removed 
						For ll_rowcontact = 1 to ll_RowCount
							If lds_Company.GetItemNumber(ll_rowcontact , 'companies_co_id') = ll_CompanyId Then 
								lla_SaveContactIds[ UpperBound( lla_SaveContactIds ) + 1] = &
														lds_Company.GetItemNumber(ll_rowcontact , 'contacts_ct_id')
							End If
						Next
		
					End If
					
				End If // as_orgindestination
					
			End if //ll_SameCompany <> ll_CompanyId 
			
		Next //lds_company
	End If //UpperBound( lla_ContactIds[]) > 0
Next	//anva_oldevent

// Remove contacts from oldevents
ll_Upper	= UpperBound( lla_SaveContactIds )
If ll_upper > 0 Then 
	For i = 1 to li_Oldcount 	
		For li_ContactCount = 1 to ll_Upper
			anva_oldevent[i].of_RemoveContactid ( lla_SaveContactIds [ li_ContactCount ] )
		Next
	Next
End If

// Add Contacts to new events
ll_Upper	= UpperBound( lla_SaveContactIds )
If ll_upper > 0 Then 
	For i = 1 to li_Newcount 	
		For li_ContactCount = 1 to ll_Upper
			anva_NewEvent[i].of_AddContactid ( lla_SaveContactIds [ li_ContactCount ] )
		Next
	Next
End If

Destroy ( lds_Company )
Destroy ( lnv_Company  )
Destroy ( lnv_Notification_Manager )

Return li_Return
end function

public function integer of_addeventcontacts (ref n_cst_beo_event anv_event);// RDT 6-09-03 this should not be used.

//MessageBox("RICH","beo_Shipment.of_AddEventContacts called in error")

//long	lla_ContactIds[]
//Long	ll_I
//Long	ll_Index
//Long	ll_Count
Int	li_Return	= -1
//
//n_cst_anyarraySrv	lnv_ArraySrv
//ll_Index = THIS.of_GetEventContacts ( lla_ContactIDs[] )
//
//ll_Count = UpperBound ( ala_ContactIds )
//FOR ll_i = 1 TO ll_Count
//	ll_Index ++
//	lla_ContactIds [ ll_Index ] = ala_ContactIds[ ll_i ]	
//NEXT
//
//lnv_ArraySrv.of_GetShrinked ( lla_ContactIds , TRUE , TRUE )  
//
//IF THIS.of_SetEventContacts ( lla_ContactIds ) = 1 THEN
//	li_Return = 1
//END IF
//
RETURN li_Return
//
end function

public function integer of_removedeletedeventsite (long ala_siteid[]);// RDT 8-27-03
// of_RemoveDeletedEventSite ( ala_siteid[]) 
// the deleted events company is no longer on the shipment then remove from all events.
//	Get and pass in the contact Ids before the event is deleted.
//
Integer	li_Return = 1
Long 	ll_EventUpper, &
		ll_Count, &
		ll_EventCount, &
		ll_FindID, &
		ll_SiteCount, &
		lla_ShipmentCompanyIds[] ,&
		ll_CompanyId, &
		ll_Upper_ShipmentCompanyIds
		

n_cst_anyarraysrv lnv_ArraySrv

n_cst_ShipmentManager lnv_shipmentManager  

n_cst_ContactManager lnv_ContactManager
lnv_ContactManager = Create n_cst_ContactManager 

n_cst_beo_company lnv_company 
lnv_company = Create n_cst_beo_company 
lnv_Company.of_SetUseCache ( TRUE )

//	Get All Current Companies on shipment
lnv_shipmentManager.of_getallcompanies ( {this}, lla_ShipmentCompanyIds[] )
ll_Upper_ShipmentCompanyIds = UpperBound( lla_ShipmentCompanyIds )

// For each company check if they are on the shipment 
ll_SiteCount = UpperBound(ala_Siteid[] )

For ll_count = 1 to ll_SiteCount 
	
	ll_CompanyId = ala_SiteId[ll_count] 
	
	ll_FindID = lnv_ArraySrv.of_findlong ( lla_ShipmentCompanyIds[], ll_CompanyId, 1, ll_Upper_ShipmentCompanyIds)
	
	If IsNull( ll_FindID ) Then 	
		// company not on shipment so remove company contacts
		IF lnv_Company.of_SetSourceId ( ll_CompanyId ) = 1 THEN
			IF lnv_Company.of_HasSource ( ) THEN
				lnv_ContactManager.of_RemoveAllContactsFromShipment ( This, lnv_Company )
			End If
		End if

	End If
	
Next

Destroy( lnv_ContactManager )

Return li_Return 
end function

public function integer of_setrailbilleduser (string as_value);RETURN This.of_SetAny ( "railbilleduser", as_Value )
end function

public function integer of_setprepaidcollect (character ac_value);Int li_RtnVal = 1
IF This.of_SetAny ( "ds_ppcol", ac_Value ) <> 1 THEN
	li_RtnVal = -1
END IF

IF li_RtnVal = 1 AND (NOT gnv_app.of_runningscheduledtask( ) ) THEN
	// check if appmanager.scheduled is yes or no
	// if no then do the following
	This.of_CheckPrePaidCollect()
END IF	

Return li_RtnVal
end function

public function integer of_setinvoicenumber (string as_value);RETURN This.of_SetAny ("ds_pronum", as_Value )
end function

public function integer of_setmovecode (string as_value);RETURN This.of_SetAny ( "movecode", as_Value )

end function

public function integer of_setbillto (long al_value);RETURN This.of_SetAny ( "ds_billto_id", al_Value )
end function

public function integer of_setcarrier (long al_value);RETURN This.of_SetAny ("ds_pay1_id",al_Value )
end function

public function integer of_settotalmiles (integer ai_value);RETURN This.of_SetAny ("ds_total_miles", ai_Value )
end function

public function integer of_settotalweight (long al_value);RETURN This.of_SetAny ("ds_total_weight", al_Value )
end function

public function integer of_sethazmat (string as_value);String ls_Value

IF as_Value = "T" THEN
	ls_Value = "T"
ELSE
	ls_Value = "F"
END IF

RETURN This.of_SetAny ( "ds_hazmat",  ls_Value )
end function

public function integer of_setexpedite (string as_value);RETURN This.of_SetAny (  "ds_expedite", as_Value )
end function

public function integer of_setinvoicedate (date ad_value);// Here the column ds_bill_date is not updatable in d_ship_info DW.
//RETURN This.of_SetAny ( "ds_bill_date", ad_Value )

Return -1

end function

public function integer of_setmodlog (string as_value);RETURN This.of_SetAny (  "ds_mod_log", as_Value )
end function

public function integer of_settype (long al_value);integer	li_return
string	ls_Terms

li_return = This.of_SetAny (  "ds_ship_type",  al_Value )

if li_return = 1 then
	
	if this.Of_Determinepaymentterms(cs_Action_ChangedShipType, ls_Terms) = 1 then
		this.of_SetPaymentterms( ls_terms)
	end if
	
end if

return li_return






end function

public function integer of_setmovetype (string as_value);RETURN This.of_SetAny (  "movetype",  as_Value )
end function

public function integer of_setoriginport (string as_value);RETURN This.of_SetAny ("originport",  as_Value )
end function

public function integer of_setdestinationport (string as_value);RETURN This.of_SetAny ( "destinationport",  as_Value )

end function

public function integer of_setline (string as_value);RETURN This.of_SetAny ("line",  as_Value )
end function

public function integer of_setvessel (string as_value);RETURN This.of_SetAny ("vessel",  as_Value )
end function

public function integer of_setvoyage (string as_value);RETURN This.of_SetAny ( "voyage",  as_Value )
end function

public function integer of_setcutoffdate (date ad_value);Int	li_Return 

li_Return = This.of_SetAny ( "cutoffdate",  ad_Value )

IF li_Return = 1 AND THIS.of_getmovecode( ) = "E" THEN
	n_cst_beo_Event	lnva_Events[]
	Int	li_Count
	Int	i
	Long	ll_Site
	ll_Site = THIS.of_GetDestination( )
	li_Count = THIS.of_GetEventlist( lnva_Events )
	FOR i = 1 TO li_Count
		IF lnva_Events[i].of_GetSite ( ) =  ll_Site AND &
			lnva_Events[i].of_IsDeliverGroup( ) THEN
			lnva_Events[i].of_SetScheduledDate(ad_value)
			EXIT
		END IF 		
	NEXT
	
END IF

RETURN li_Return 
end function

public function integer of_setcutofftime (time at_value);Int	li_Return 

li_Return = This.of_SetAny (  "cutofftime",  at_Value )

IF li_Return = 1 AND THIS.of_getmovecode( ) = "E" THEN
	n_cst_beo_Event	lnva_Events[]
	Int	li_Count
	Int	i
	Long	ll_Site
	ll_Site = THIS.of_GetDestination( )
	li_Count = THIS.of_GetEventlist( lnva_Events )
	FOR i = 1 TO li_Count
		IF lnva_Events[i].of_GetSite ( ) =  ll_Site AND &
			lnva_Events[i].of_IsDeliverGroup( ) THEN
			lnva_Events[i].of_SetScheduledTime(at_value )
			EXIT
		END IF 		
	NEXT
	
END IF

RETURN li_Return 



end function

public function integer of_setarrivaldate (date ad_value);RETURN This.of_SetAny (  "arrivaldate",  ad_Value )
end function

public function integer of_setarrivaltime (time at_value);RETURN This.of_SetAny ( "arrivaltime",  at_Value )
end function

public function integer of_setlastfreedate (date ad_value);Int li_Return = -1
n_cst_setting_setshipdate	lnv_SetDate
lnv_SetDate = CREATE n_cst_setting_setshipdate

li_Return = This.of_SetAny (  "lastfreedate",  ad_Value )

IF li_Return = 1 THEN
	THIS.of_Recordchange( "lastfreedate" )
	
	IF NOT isNull ( ad_value ) THEN
		ad_value = Date ( DateTime ( ad_value ) )
		IF lnv_SetDate.of_GetValue ( ) = lnv_SetDate.cs_yes THEN
			THIS.of_setshipdate( ad_value )
		END IF
	END IF
	
END IF

DESTROY ( lnv_SetDate )
RETURN li_Return
end function

public function integer of_setlastfreetime (time at_value);RETURN This.of_SetAny ( "lastfreetime",  at_Value )
end function

public function integer of_sethousebl (string as_value);RETURN This.of_SetAny ("housebl",as_Value )
end function

public function integer of_setagentref (string as_value);RETURN This.of_SetAny ( "agentref",  as_Value )
end function

public function integer of_setdispatchedby (string as_value);RETURN This.of_SetAny ( "dispatchedby",  as_Value )
end function

public function integer of_setavailableon (date ad_value);RETURN This.of_SetAny (  "availableon",   ad_Value )
end function

public function integer of_setavailableuntil (date ad_value);RETURN This.of_SetAny (  "availableuntil",   ad_Value )
end function

public function integer of_setprenoteby (string as_value);Int		li_Return = -1
Time		lt_Now
Date		ld_Today
String	ls_Value

lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "prenoteby",  ls_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "prenoteby" )
	
	IF IsNull ( THIS.of_GetPrenoteDate ( ) ) THEN
		THIS.of_SetPreNoteDate ( ld_Today )
	END IF
	
	IF IsNull ( THIS.of_getPrenoteTime ( ) ) THEN
		THIS.of_SetPrenotetime ( lt_Now )
	END IF
	
END IF

RETURN li_Return


end function

public function integer of_setetadate (date ad_value);RETURN This.of_SetAny ( "etadate",  ad_Value )
end function

public function integer of_setetatime (time at_value);RETURN This.of_SetAny ("etaTime",   at_Value )
end function

public function integer of_setetaby (string as_value);Int		li_Return = -1
String	ls_Value

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "etaby",  ls_Value )

IF li_Return = 1 THEN	
	THIS.of_Recordchange( "etaby" )
END IF

RETURN li_Return
end function

public function integer of_setetauser (string as_value);RETURN THIS.of_SetAny ("etauser",  as_Value )
end function

public function integer of_setarrivedby (string as_value);Int		li_Return = -1
Time		lt_Now
Date		ld_Today
String	ls_Value

lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "arrivedby",  ls_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "arrivedby" )
	
	IF IsNull ( THIS.of_getarrivaldate( )  ) THEN
		THIS.of_setarrivaldate( ld_Today )
	END IF
	
	IF IsNull ( THIS.of_getarrivalTime ( ) ) THEN
		THIS.of_setarrivalTime ( lt_Now )
	END IF
	
END IF

RETURN li_Return

end function

public function integer of_setarriveduser (string as_value);RETURN THIS.of_SetAny ( "arriveduser", 	as_Value )
end function

public function integer of_setgroundeddate (date ad_value);RETURN This.of_SetAny ( "groundeddate",  ad_Value )
end function

public function integer of_setgroundedtime (time at_value);RETURN This.of_SetAny ( "groundedtime",   at_Value )
end function

public function integer of_setgroundedby (string as_value);Int		li_Return = -1
Time		lt_Now
Date		ld_Today
String	ls_Value

lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "groundedby",  ls_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "groundedby" )
	
	IF IsNull ( THIS.of_getgroundeddate( )  ) THEN
		THIS.of_setGroundedDate( ld_Today )
	END IF
	
	IF IsNull ( THIS.of_getGroundedTime ( ) ) THEN
		THIS.of_setGroundedTime ( lt_Now )
	END IF
	
END IF

RETURN li_Return

end function

public function integer of_setgroundeduser (string as_value);RETURN THIS.of_SetAny ( "groundeduser" , as_Value )
end function

public function integer of_setpickupnumberby (string as_value);Int		li_Return = -1
String	ls_Value

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "pickupnumberby",  ls_Value )

IF li_Return = 1 THEN	
	THIS.of_Recordchange( "pickupnumberby" )
END IF

RETURN li_Return
end function

public function integer of_setpickupnumberuser (string as_value);RETURN THIS.of_SetAny ("pickupnumberuser",as_Value )
end function

public function integer of_setbookingnumberby (string as_value);Int		li_Return = -1
String	ls_Value

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "bookingnumberby",  ls_Value )

IF li_Return = 1 THEN	
	THIS.of_Recordchange( "bookingnumberby" )
END IF

RETURN li_Return
end function

public function integer of_setbookingnumberuser (string as_value);RETURN This.of_SetAny ("bookingnumberuser",  as_Value )

end function

public function integer of_setreleaseby (string as_value);Int		li_Return = -1
Time		lt_Now
Date		ld_Today
String	ls_Value

lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "releaseby",  ls_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "releaseby" )
	
	IF IsNull ( THIS.of_getReleasedate( )  ) THEN
		THIS.of_setReleaseDate( ld_Today )
	END IF
	
	IF IsNull ( THIS.of_getReleaseTime ( ) ) THEN
		THIS.of_setReleaseTime ( lt_Now )
	END IF
	
END IF

RETURN li_Return
end function

public function integer of_setreleaseuser (string as_value);RETURN of_SetAny ( "releaseuser",  as_Value )
end function

public function integer of_setlfdby (string as_value);Int		li_Return = -1
String	ls_Value

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "lfdby",  ls_Value )

IF li_Return = 1 THEN	
	THIS.of_Recordchange( "lfdby" )
END IF

RETURN li_Return
end function

public function integer of_setlfduser (string as_value);RETURN This.of_SetAny (  "lfduser", as_Value )

end function

public function integer of_setpickupbydate (date ad_value);Int	li_Return = -1

n_cst_events			lnv_Events
n_cst_setting_setshipdate	lnv_SetDate
lnv_SetDate = CREATE n_cst_setting_setshipdate

li_Return = This.of_SetAny ( "Pickupbydate", ad_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "Pickupbydate" )
	
	ad_value = Date ( DateTime ( ad_value ) )
	//IF Not IsNull(ad_Value) THEN<<*>> 2608
		lnv_Events.of_SetPuApptDate (THIS,ad_Value) 

	//END IF
		
	IF lnv_SetDate.of_GetValue ( ) = lnv_SetDate.cs_yes THEN
		IF IsNull(This.of_getshipdate( ) ) THEN
			THIS.of_SetShipDate ( ad_Value  ) 
		END IF
	END IF

END IF

DESTROY ( lnv_SetDate )

RETURN	li_Return
end function

public function integer of_setpickupbytime (time at_value);Int	li_Return = -1
n_cst_events lnv_Events

li_Return = THIS.of_SetAny ( "Pickupbytime" , at_Value )

IF li_Return = 1 THEN
	THIS.of_Recordchange( "pickupbytime" )

	//IF Not IsNull(at_Value) THEN<<*>> 2608
		lnv_Events.of_SetPuApptTime (THIS,at_Value)
	//END IF
END IF

RETURN li_Return
end function

public function integer of_setpickupbyby (string as_value);Int		li_Return = -1
Date		ld_Today
String	ls_Value

ld_Today = Date ( DateTime ( Today ( ) ) ) 

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "pickupbyby",  ls_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "pickupbyby" )
	
	IF IsNull ( THIS.of_getPickupBydate( ) ) THEN
		THIS.of_setPickupBydate ( ld_Today )
	END IF

END IF

RETURN li_Return

end function

public function integer of_setpickupbyuser (string as_value);RETURN THIS.of_SetAny ( "pickupbyuser",  as_Value )
end function

public function integer of_setdelbydate (date ad_value);Int	li_Return = -1
n_cst_events lnv_Events

li_Return = This.of_SetAny ( "delbydate",  ad_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "delbydate" )
	
	//IF Not IsNull(ad_Value) THEN<<*>> 2608
		lnv_Events.of_SetDeliverApptDate (THIS,ad_Value) 
	//END IF
END IF

RETURN li_Return

end function

public function integer of_setdelbytime (time at_value);Int	li_Return = -1
n_cst_events lnv_Events

li_Return = This.of_SetAny (  "delbytime",  at_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "delbytime" )
	
	//IF Not IsNull(at_Value) THEN <<*>> 2608
		lnv_Events.of_SetDeliverApptTime(THIS,at_Value) 
	//END IF
	
END IF

RETURN	li_Return

end function

public function integer of_setdelbyby (string as_value);Int		li_Return = -1
Date		ld_Today
String	ls_Value

ld_Today = Date ( DateTime ( Today ( ) ) ) 

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "delbyby",  ls_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "delbyby" )
	
	IF IsNull ( THIS.of_getdelbydate( ) ) THEN
		THIS.of_SetDelByDate ( ld_Today )
	END IF

END IF

RETURN li_Return


end function

public function integer of_setdelbyuser (string as_value);RETURN This.of_SetAny ( "delbyuser",  as_Value )

end function

public function integer of_setcutoffby (string as_value);Int		li_Return = -1
String	ls_Value

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "cutoffby",  ls_Value )

IF li_Return = 1 THEN	
	THIS.of_Recordchange( "cutoffby" )
END IF

RETURN li_Return
end function

public function integer of_setcutoffuser (string as_value);RETURN This.of_SetAny ("cutoffuser",   as_Value )

end function

public function integer of_setemptyatcustomerdate (date ad_value);Int	li_Return 

li_Return = This.of_SetAny ( "emptyatcustomerdate",  ad_Value )

//JBiron Edit - Deleted posting functionality and moved to deliver by date

RETURN li_Return 
end function

public function integer of_setemptyatcustomertime (time at_value);RETURN This.of_SetAny ("emptyatcustomertime",  at_Value )
end function

public function integer of_setemptyatcustomerby (string as_value);Int		li_Return = -1
Date		ld_Today
Time		lt_Now
String	ls_Value

lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "emptyatcustomerby",  ls_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "emptyatcustomerby" )
	
	IF IsNull ( THIS.of_getemptyatcustomerdate( ) ) THEN
		THIS.of_setemptyatcustomerdate ( ld_Today )
	END IF
	
	IF IsNull ( THIS.of_getemptyatcustomerTime ( ) ) THEN
		THIS.of_setemptyatcustomerTime ( lt_Now )
	END IF

END IF

RETURN li_Return

end function

public function integer of_setemptyatcustomeruser (string as_value);RETURN This.of_SetAny ( "emptyatcustomeruser", as_Value )
end function

public function integer of_setloadedatcustomerdate (date ad_value);RETURN This.of_SetAny (  "loadedatcustomerdate",  ad_Value )
end function

public function integer of_setloadedatcustomertime (time at_value);RETURN This.of_SetAny ( "loadedatcustomertime", at_Value )
end function

public function integer of_setloadedatcustomerby (string as_value);Int		li_Return = -1
Time		lt_Now
Date		ld_Today
String	ls_Value

lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "loadedatcustomerby",  ls_Value )

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "loadedatcustomerby" )
	
	IF IsNull ( THIS.of_getloadedatcustomerdate( )  ) THEN
		THIS.of_setloadedatcustomerdate( ld_Today )
	END IF
	
	IF IsNull ( THIS.of_getloadedatcustomerTime ( ) ) THEN
		THIS.of_setloadedatcustomerTime ( lt_Now )
	END IF
	
END IF

RETURN li_Return
end function

public function integer of_setloadedatcustomeruser (string as_value);RETURN This.of_SetAny ("loadedatcustomeruser", as_Value )
end function

public function integer of_setrailbillnumber (string as_value);Int	li_Return = -1
Date	ld_Today

li_Return = This.of_SetAny ( "railbillnumber" , as_Value )

ld_Today = Date ( DateTime ( Today ( ) ) ) 

IF li_Return = 1 THEN
	
	THIS.of_Recordchange( "railbillnumber" )
	IF IsNull ( THIS.of_GetRailBilleddate( )  ) THEN
		THIS.of_SetRailBilleddate( ld_Today )
	END IF
	
END IF

RETURN li_Return
end function

public function integer of_setrailbillnumberuser (string as_value);RETURN This.of_SetAny ( "railbillnumberuser" , as_Value )
end function

public function integer of_setrailbilleddate (date ad_value);RETURN This.of_SetAny ( "railbilleddate" , ad_Value )
end function

public function integer of_setrailbilledby (string as_value);Int		li_Return = -1
String	ls_Value

ls_Value = as_value

CHOOSE CASE Upper ( ls_Value ) 
	CASE 'F'
		ls_Value = "FAX"
	CASE 'V'
		ls_Value = "VERBAL"		
	CASE 'P'
		ls_Value = "PHONE"
END CHOOSE

li_Return = THIS.of_SetAny ( "railbilledby",  ls_Value )

IF li_Return = 1 THEN	
	THIS.of_Recordchange( "railbilledby" )
END IF

RETURN li_Return
end function

public function integer of_setdatepickedup (date ad_value);//Returns the Date (Confirmed) PickedUp, or Null if is not confirmed, is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_PickupIndex, &
			li_ReturnValue
Long		ll_Origin
//Date		ld_Result // ZMC

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "pickup" 
//by seeing which event represents the origin for the shipment.

IF li_EventCount > 2 THEN

	ll_Origin = This.of_GetOrigin ( )

	IF NOT IsNull ( ll_Origin ) THEN

		FOR li_Index = 1 TO li_EventCount

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Origin THEN
				IF lnva_Events [ li_Index ].of_IsPickupGroup ( ) THEN
					li_PickupIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a PickupIndex by the special criteria above, use the first event.
IF li_PickupIndex = 0 AND li_EventCount > 0 THEN
	li_PickupIndex = 1
END IF


//If we've got an event index, get the date, otherwise set the date to null.
IF li_PickupIndex > 0 THEN
//	ld_Result = lnva_Events [ li_PickupIndex ].of_GetDateArrived (TRUE)
	li_ReturnValue = lnva_Events [ li_PickupIndex ].of_SetDateArrived (ad_value) // ZMC

ELSE
//	SetNull ( ld_Result )  //ZMC
	li_ReturnValue = -1   // ZMC
END IF

Int i
li_EventCount = UpperBound ( lnva_Events )
FOR i = 1 TO li_EventCount 
	DESTROY ( lnva_Events[i] )
NEXT

RETURN li_ReturnValue
end function

public function integer of_settimepickedup (time at_value);//Returns the 1 (Confirmed), or -1 if is not confirmed, is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_PickupIndex, & 
			li_ReturnValue
Long		ll_Origin
// Time		lt_Result // ZMC

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "pickup" 
//by seeing which event represents the origin for the shipment.

IF li_EventCount > 2 THEN

	ll_Origin = This.of_GetOrigin ( )

	IF NOT IsNull ( ll_Origin ) THEN

		FOR li_Index = 1 TO li_EventCount

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Origin THEN
				IF lnva_Events [ li_Index ].of_IsPickupGroup ( ) THEN
					li_PickupIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a PickupIndex by the special criteria above, use the first event.
IF li_PickupIndex = 0 AND li_EventCount > 0 THEN
	li_PickupIndex = 1
END IF


//If we've got an event index, get the time, otherwise set the time to null.
IF li_PickupIndex > 0 THEN
	li_ReturnValue = lnva_Events [ li_PickupIndex ].of_SetTimeArrived ( at_Value )

ELSE
	// SetNull ( lt_Result ) // ZMC
	li_ReturnValue = -1 

END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT

RETURN li_ReturnValue
end function

public function integer of_setdatedelivered (date ad_value);//Returns the Date (Confirmed) Delivered, or Null if is not confirmed, is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_DeliverIndex, & 
			li_returnValue
Long		ll_Destination
// Date		ld_Result // ZMC

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "delivery" 
//by seeing which event represents the final destination for the shipment.

IF li_EventCount > 2 THEN

	ll_Destination = This.of_GetDestination ( )

	IF NOT IsNull ( ll_Destination ) THEN

		FOR li_Index = li_EventCount TO 1 STEP -1

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Destination THEN
				IF lnva_Events [ li_Index ].of_IsDeliverGroup ( ) THEN
					li_DeliverIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a DeliverIndex by the special criteria above, use the last event.
IF li_DeliverIndex = 0 THEN
	li_DeliverIndex = li_EventCount
END IF


//If we've got an event index, get the date, otherwise set the date to null.
IF li_DeliverIndex > 1 THEN
	// It is GetDateArrived in of_GetDateDelivered.
	li_returnValue = lnva_Events [ li_DeliverIndex ].of_SetDateArrived ( ad_Value) 

ELSE
//	SetNull ( ld_Result ) // ZMC
	li_returnValue = -1
END IF

Int i
li_EventCount = UpperBound ( lnva_Events )
FOR i = 1 TO li_EventCount 
	DESTROY ( lnva_Events[i] )
NEXT

RETURN li_returnValue
end function

public function integer of_settimedelivered (time at_value);//Returns the Time (Confirmed) Delivered, or Null if is not confirmed, is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_DeliverIndex, & 
			li_ReturnValue
Long		ll_Destination
// Time		lt_Result //ZMC

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "delivery" 
//by seeing which event represents the final destination for the shipment.

IF li_EventCount > 2 THEN

	ll_Destination = This.of_GetDestination ( )

	IF NOT IsNull ( ll_Destination ) THEN

		FOR li_Index = li_EventCount TO 1 STEP -1

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Destination THEN
				IF lnva_Events [ li_Index ].of_IsDeliverGroup ( ) THEN
					li_DeliverIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a DeliverIndex by the special criteria above, use the last event.
IF li_DeliverIndex = 0 THEN
	li_DeliverIndex = li_EventCount
END IF


//If we've got an event index, get the time, otherwise set the time to null.
IF li_DeliverIndex > 1 THEN
	li_ReturnValue = lnva_Events [ li_DeliverIndex ].of_SetTimeArrived (at_Value)

ELSE
//	SetNull ( lt_Result ) // ZMC
li_ReturnValue = -1
END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT

RETURN li_ReturnValue
end function

public function integer of_setpod (string as_value);
//Returns the POD (The "POD" value is actually the note field on the event), 
//or Null if is not confirmed, is unspecified, or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_DeliverIndex, & 
			li_ReturnValue
Long		ll_Destination

// String	ls_Result // ZMC

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "delivery" 
//by seeing which event represents the final destination for the shipment.

IF li_EventCount > 2 THEN

	ll_Destination = This.of_GetDestination ( )

	IF NOT IsNull ( ll_Destination ) THEN

		FOR li_Index = li_EventCount TO 1 STEP -1

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Destination THEN
				IF lnva_Events [ li_Index ].of_IsDeliverGroup ( ) THEN
					li_DeliverIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT
 
	END IF

END IF


//If we didn't determine a DeliverIndex by the special criteria above, use the last event.
IF li_DeliverIndex = 0 THEN
	li_DeliverIndex = li_EventCount
END IF

//If we've got an event index, get the POD (Note value), otherwise set the POD to null.
IF li_DeliverIndex > 1 THEN
	li_ReturnValue = lnva_Events [ li_DeliverIndex ].of_SetNote (as_Value)
ELSE
	li_ReturnValue = -1
END IF

Int i
FOR i = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ i ] )
NEXT


RETURN li_ReturnValue
end function

public function integer of_setscheduledpickupdate (date ad_value);//Returns the Scheduled Pickup Date, or Null if it is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_PickupIndex, & 
			li_ReturnValue
Long		ll_Origin
// Date		ld_Result // ZMC

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "pickup" 
//by seeing which event represents the origin for the shipment.

IF li_EventCount > 2 THEN

	ll_Origin = This.of_GetOrigin ( )

	IF NOT IsNull ( ll_Origin ) THEN

		FOR li_Index = 1 TO li_EventCount

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Origin THEN
				IF lnva_Events [ li_Index ].of_IsPickupGroup ( ) THEN
					li_PickupIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a PickupIndex by the special criteria above, use the first event.
IF li_PickupIndex = 0 AND li_EventCount > 0 THEN
	li_PickupIndex = 1
END IF


//If we've got an event index, get the date, otherwise set the date to null.
IF li_PickupIndex > 0 THEN
	li_ReturnValue = lnva_Events [ li_PickupIndex ].of_SetScheduledDate (ad_value )

ELSE
	li_ReturnValue = -1 
	//SetNull ( ld_Result ) // ZMC

END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT

RETURN li_ReturnValue
end function

public function integer of_setscheduledpickuptime (time at_value);//Returns the Scheduled Pickup Time, or Null if it is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_PickupIndex, & 
			li_ReturnValue
Long		ll_Origin
// Time		lt_Result // ZMC

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "pickup" 
//by seeing which event represents the origin for the shipment.

IF li_EventCount > 2 THEN

	ll_Origin = This.of_GetOrigin ( )

	IF NOT IsNull ( ll_Origin ) THEN

		FOR li_Index = 1 TO li_EventCount

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Origin THEN
				IF lnva_Events [ li_Index ].of_IsPickupGroup ( ) THEN
					li_PickupIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a PickupIndex by the special criteria above, use the first event.
IF li_PickupIndex = 0 AND li_EventCount > 0 THEN
	li_PickupIndex = 1
END IF


//If we've got an event index, get the time, otherwise set the time to null.
IF li_PickupIndex > 0 THEN
	li_ReturnValue = lnva_Events [ li_PickupIndex ].of_SetScheduledTime (at_value )

ELSE
	li_ReturnValue = -1 

END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT

RETURN li_ReturnValue
end function

public function integer of_setscheduleddeliverydate (date ad_value);//Returns the Scheduled Delivery Date, or Null if it is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_DeliverIndex, & 
			li_ReturnValue
Long		ll_Destination
// Date		ld_Result // ZMC

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "delivery" 
//by seeing which event represents the final destination for the shipment.

IF li_EventCount > 2 THEN

	ll_Destination = This.of_GetDestination ( )

	IF NOT IsNull ( ll_Destination ) THEN

		FOR li_Index = li_EventCount TO 1 STEP -1

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Destination THEN
				IF lnva_Events [ li_Index ].of_IsDeliverGroup ( ) THEN
					li_DeliverIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a DeliverIndex by the special criteria above, use the last event.
IF li_DeliverIndex = 0 THEN
	li_DeliverIndex = li_EventCount
END IF


//If we've got an event index, get the date, otherwise set the date to null.
IF li_DeliverIndex > 1 THEN
	li_ReturnValue = lnva_Events [ li_DeliverIndex ].of_SetScheduledDate (ad_value )

ELSE
	li_ReturnValue = -1 
//	SetNull ( ld_Result ) // ZMC

END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT


RETURN li_ReturnValue
end function

public function integer of_setscheduleddeliverytime (time at_value);//Returns the Scheduled Delivery Time, or Null if it is unspecified, 
//or cannot be determined.

//Note:  This assumes the events in lnva_Events to be in shipment-sequence order

n_cst_beo_Event	lnva_Events[]
Integer	li_EventCount, &
			li_Index, &
			li_DeliverIndex, & 
			li_ReturnValue
Long		ll_Destination
//Time		lt_Result

li_EventCount = This.of_GetEventList ( lnva_Events )

//If we have more than 2 events, try to determine which one is really the "delivery" 
//by seeing which event represents the final destination for the shipment.

IF li_EventCount > 2 THEN

	ll_Destination = This.of_GetDestination ( )

	IF NOT IsNull ( ll_Destination ) THEN

		FOR li_Index = li_EventCount TO 1 STEP -1

			IF lnva_Events [ li_Index ].of_GetSite ( ) = ll_Destination THEN
				IF lnva_Events [ li_Index ].of_IsDeliverGroup ( ) THEN
					li_DeliverIndex = li_Index
					EXIT
				END IF
			END IF

		NEXT

	END IF

END IF


//If we didn't determine a DeliverIndex by the special criteria above, use the last event.
IF li_DeliverIndex = 0 THEN
	li_DeliverIndex = li_EventCount
END IF


//If we've got an event index, get the time, otherwise set the time to null.
IF li_DeliverIndex > 1 THEN
	li_ReturnValue = lnva_Events [ li_DeliverIndex ].of_SetScheduledTime (at_value)

ELSE
	li_ReturnValue = -1 
//	SetNull ( lt_Result ) // ZMC

END IF

FOR li_Index = 1 TO li_EventCount 
	DESTROY ( lnva_Events[ li_Index ] )
NEXT

RETURN li_ReturnValue
end function

public function integer of_settotalpieces (decimal ac_value);n_cst_beo_Item	lnva_Items[]
Integer	li_ItemCount, &
			li_Index, & 
			li_ReturnValue

li_ItemCount = This.of_GetItemList ( lnva_Items )

FOR li_Index = 1 TO li_ItemCount

	IF lnva_Items [ li_Index ].of_IsFreight ( ) THEN

		li_ReturnValue = lnva_Items [ li_Index ].of_SetQuantity (ac_value)

	END IF
	
	DESTROY ( lnva_Items [ li_Index ] )

NEXT

RETURN li_ReturnValue
end function

public function integer of_setsalescommission (decimal ac_value);RETURN THIS.of_SetAny ( "ds_salescom_amt", ac_Value )
end function

public function integer of_setpayabletotal (decimal ac_value);Int	li_ReturnValue = -1

IF THIS.of_SetAny ( "ds_pay_totamt", ac_Value ) = 1 THEN
	IF	THIS.of_Calculatepayable( ) = 1 THEN
		li_ReturnValue = 1
	END IF
END IF

RETURN li_ReturnValue
end function

public function integer of_setfreightpayable (decimal ac_value);Int	li_ReturnValue = -1

IF THIS.of_SetAny ( "ds_pay_lh_totamt", ac_Value ) = 1 THEN
	IF	THIS.of_Calculate ( ) = 1 THEN
		li_ReturnValue = 1
	END IF
END IF

RETURN li_ReturnValue
end function

public function integer of_setaccessorialpayable (decimal ac_value);Int	li_ReturnValue = -1

IF THIS.of_SetAny ( "ds_pay_ac_totamt", ac_Value ) = 1 THEN
	IF	THIS.of_calculatepayable( ) = 1 THEN
		li_ReturnValue = 1
	END IF
END IF

RETURN li_ReturnValue
end function

public function integer of_setfreightcharges (decimal ac_value);Return THIS.of_SetAny ( "ds_lh_totamt" ,ac_value) 



end function

public function integer of_setparentid (readonly long al_value);//RETURN This.of_SetAny ("ds_PARENTID",al_Value )

//Returns: 1, -1 = Straight Faiure, -2 = User is not authorized to modify

String	ls_MessageHeader = "Split Billing Assignment"

// assume failure
Int	li_Return = -1

IF THIS.of_AllowEditBill ( ) THEN
	
	IF This.of_SetAny ( gc_Dispatch.cs_Column_ParentId, al_value  ) = 1 THEN
		li_Return = 1
	END IF
	
ELSE

//	This.of_DisplayRestrictMessage ( ls_MessageHeader )  //Use custom message instead.
	MessageBox ( ls_MessageHeader, "You are not authorized to make this change to " +&
		"Shipment " + String (THIS.of_GetID ( ) ) +  ".")
	li_Return = -2

END IF

RETURN li_Return

end function

public function integer of_setvalue (string as_column, string as_value);

RETURN THIS.of_SetAny ( as_column, as_Value )
end function

public function integer of_setid (long al_value);RETURN This.of_SetAny ("ds_id",al_Value )


end function

public function integer of_setblnumbers (string as_value);n_cst_beo_Item	lnva_Items[]
Integer	li_ItemCount, &
			li_Index
/*  Commented by ZMC		
String	lsa_BLNumbers[], &
			ls_BLNumbers
*/			
Int li_ReturnValue = -1	// Added by ZMC
n_cst_String	lnv_String // Commented by ZMC

li_ItemCount = This.of_GetItemList ( lnva_Items )

FOR li_Index = 1 TO li_ItemCount
	//This call automatically returns null if the item is not freight.
	li_ReturnValue = lnva_Items [ li_Index ].of_SetBLNum (as_value)
	DESTROY ( lnva_Items [ li_Index ] )
NEXT

/* Commented by ZMC
//Concatenate the Array to a String  (the function automatically weeds out nulls)
lnv_String.of_ArrayToString ( lsa_BLNumbers, "  ", ls_BLNumbers )
*/

RETURN li_ReturnValue
end function

public function integer of_setref1label (string as_value);n_cst_ShipmentManager	lnv_ShipmentManager

Return 1
//RETURN lnv_ShipmentManager.of_ConvertReference ( This.of_SetRef1Text (as_value) )

end function

public function integer of_setref2label (string as_value);n_cst_ShipmentManager	lnv_ShipmentManager

Return 1
//RETURN lnv_ShipmentManager.of_ConvertReference ( This.of_SetRef1Text (as_value) )

end function

public function integer of_setref3label (string as_value);n_cst_ShipmentManager	lnv_ShipmentManager

Return 1
//RETURN lnv_ShipmentManager.of_ConvertReference ( This.of_SetRef1Text (as_value) )

end function

private function integer of_setdefaultfreightdescription ();// returns the number of items modified

Int		li_Return = 0
Int		li_itemCount
Int		i
String	ls_FreightDescription

n_Cst_beo_Item		lnva_Items[]
li_ItemCount = THIS.of_getitemlist( lnva_Items , "L" )

n_Cst_beo_company 	lnv_Company
IF THIS.of_GetOrigin( lnv_Company , TRUE ) = 1 THEN
	ls_FreightDescription = lnv_Company.of_GetDefaultfreightdescription( )
END IF


FOR i = 1 TO li_itemCount
	
	IF isNull ( lnva_Items[i].of_GetDescription( ) ) THEN
		li_Return ++
		lnva_Items[i].of_SetDescription( ls_FreightDescription )
	END IF
	DESTROY ( lnva_Items[i] )
	
	
NEXT

DESTROY ( lnv_Company )

RETURN li_Return
end function

public function integer of_setbilltobyref (string as_companyref);Long	ll_Return = -1
Long	ll_SiteID
n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

ll_Return = gnv_cst_companies.of_Find ( as_companyref )
IF ll_Return > 0 THEN
	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_SetSourceRow ( ll_Return )
	ll_SiteID = lnv_Company.of_GetID ( )
	
	IF ll_SiteID > 0 THEN
		IF THIS.of_SetBillTo ( ll_SiteID ) = 1 THEN
			ll_Return = 1
		END IF
	END IF
END IF

DESTROY lnv_Company

return ll_Return
end function

public function integer of_checkprepaidcollect ();// zmc - 2-6-04

Int li_RtnVal = 1

Long ll_current_billto
Long  ll_potential_billto

String ls_ppcol
String ls_message_header
String ls_message
String ls_ErrMsg
String ls_PotentialName

s_co_info lstr_company

IF gnv_app.of_runningscheduledtask( ) THEN
	li_RtnVal = 0
END IF

IF li_RtnVal = 1 THEN

	ls_ppcol = This.of_GetPrepaidcollect( )
		
	ll_current_billto = This.of_GetBillto( )
		
	CHOOSE CASE ls_ppcol
		CASE "P"
			ll_potential_billto = This.of_GetOrigin( )
			ls_message_header = "Prepaid Shipment"
		CASE "C"
			ll_potential_billto = This.of_GetDestination( )

			ls_message_header = "Collect Shipment"
		CASE ELSE
			li_RtnVal = 0
	END CHOOSE
END IF

IF li_RtnVal = 1 THEN
	IF (ll_current_billto = ll_potential_billto) OR &
		(isnull(ll_current_billto) and isnull(ll_potential_billto)) THEN
		li_RtnVal = 0
	END IF
END IF	

IF li_RtnVal = 1 THEN
	n_cst_beo_Company lnv_Company
	lnv_Company = CREATE n_cst_beo_Company
	gnv_cst_companies.of_cache(ll_potential_billto,TRUE)
	lnv_Company.of_SetUseCache( TRUE)
	lnv_Company.of_SetSourceId(ll_potential_billto)	
	IF lnv_Company.of_GetBillsame( ) = 'T' THEN
		ls_PotentialName = Trim(lnv_Company.of_GetName( ))
	ELSE
		ls_PotentialName = Trim(lnv_Company.of_getbillname( ))		
	END IF
	IF IsNull(ls_PotentialName) OR Len(ls_PotentialName) = 0 THEN
		
		ls_message = "Do you want to clear the Billto?"
	ELSE
		ls_message = "Specify " + ls_PotentialName + " as the Billto?"
	END IF
	Destroy(n_cst_beo_Company)
END IF

IF li_RtnVal = 1 THEN
	IF messagebox(ls_message_header, ls_message, question!, yesno!, 1) = 2 THEN
		li_RtnVal = 0
	END IF	
END IF	
	
IF li_RtnVal = 1 THEN
	IF gnv_cst_companies.of_select(lstr_company, "BILLTO!", false, "", true, & 
												ll_potential_billto, false, false) = 1 then
		IF ll_current_billto = lstr_company.co_id then 
			li_RtnVal = 0 
		END IF
	ELSE
		ls_ErrMsg = "Your request to change the Billto could not be completed."
		li_RtnVal = -1 
	END IF	
END IF	

IF li_RtnVal = 1 THEN
	//Note : ll_potential_billto may not = lstr_company.co_id, b.c. of facilities
	This.of_SetBillToID (lstr_company.co_id)
END IF	

IF li_RtnVal = -1  THEN
	IF Len(ls_ErrMsg) = 0 THEN
		ls_ErrMsg = "Your request could not be completed."
	END IF	
	messagebox(ls_message_header, ls_ErrMsg)
END IF

Return li_RtnVal
end function

public function long of_getnonspecialfreight (ref n_cst_beo_item anva_item[]);// zmc - 2-13-04
/*	cs_ItemType_Freight, cs_ItemType_Accessorial

cs_ItemEventType_FrontChassisSplit = "CHASSIS PICKUP"
cs_ItemEventType_BackChassisSplit = "CHASSIS RETURN"
cs_ItemEventType_StopOff = "STOP OFF"

Call overloaded method and then filter list down to type passed
in argument.
		
Return - item beos by reference
		 - number of items
*/

long		ll_index, &
			ll_ItemCount, &
			ll_typecount
String   ls_TypeFlag			
			
n_cst_beo_item		lnva_Item[], &
						lnva_itembytype[]

ll_ItemCount = this.of_GetItemList(lnva_Item , n_cst_constants.cs_ItemType_Freight)

FOR ll_index = 1 TO ll_itemcount
	ls_TypeFlag = lnva_item[ll_index].of_GetEventTypeFlag() 
	
	IF ls_TypeFlag = n_cst_constants.cs_ItemEventType_FrontChassisSplit OR & 
		ls_TypeFlag = n_cst_constants.cs_ItemEventType_BackChassisSplit OR & 
		ls_TypeFlag = n_cst_constants.cs_ItemEventType_StopOff THEN
		DESTROY ( lnva_Item[ll_Index] )		
	ELSE
		ll_typecount ++
		lnva_ItemByType[ll_typecount] = lnva_Item[ll_Index]
	END IF
	ls_TypeFlag  = ""
NEXT

IF ll_TypeCount > 0 THEN
	anva_item = lnva_itembytype
END IF

RETURN ll_typecount
end function

public function decimal of_getfuelsurchargeableamount (string as_surchargetype);DEC 	lc_Return
Dec	lc_DiscountPercent
Int	li_ItemCount
Int	i
Int	li_ID
String	ls_SurchargeType
Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
n_cst_beo_amounttype lnv_amounttype

n_cst_beo_Item	lnva_Items[]


IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	
	li_ItemCount = THIS.of_GetItemList ( lnva_Items )
	
	FOR i = 1 TO li_ItemCount
		IF IsValid ( lnva_Items[i] ) THEN
			li_id = lnva_Items[i].of_getamounttype()
			lnv_Beo = lnv_Cache.getBeo("amounttype_id = " + string(li_id) )
			IF isValid(lnv_Beo) THEN    
			
				lnv_amounttype = lnv_Beo
				
				IF lnv_amounttype.of_IsBillableFuelSurcharge ( )  THEN
					choose case as_SurchargeType
						case 'PERCENTAGE'
							lc_Return += lnva_Items[i].of_GetBillingAmount ( )
						case 'PERMILE'
							lc_Return += lnva_Items[i].of_GetMiles ( )
					end choose
				END IF
			END IF			
			
		END IF
		
		DESTROY ( lnva_Items[i]  )
	NEXT
		
	// we are going to apply the discount to the amount
	lc_DiscountPercent = THIS.of_Getdiscountpercent( )
	IF lc_DiscountPercent > 0 THEN
		lc_Return = lc_return * ( 1 - lc_discountPercent )	
	END IF
	
	
END IF

RETURN lc_Return




end function

public function integer of_recordchange (string as_column);String	ls_User
Int		li_Return

ls_User = gnv_App.of_GetUserId ( )

CHOOSE CASE lower ( as_column )
			
	CASE "prenotedate", "prenotetime",    "prenoteby"
	  This.of_SetAny ( "prenoteuser"  , ls_User )

	CASE "etadate",   "etatime",    "etaby"   
		This.of_SetAny ( "etauser"  , ls_User )
	 
	CASE "arrivedby" , "arrivaldate" , "arrivaltime"
		This.of_SetAny ( "arriveduser"  , ls_User )
	
	CASE "groundeddate",   "groundedtime",    "groundedby"   
		This.of_SetAny ( "groundeduser"  , ls_User )
		
	CASE"pickupnumber",   "pickupnumberby"
		This.of_SetAny ( "pickupnumberuser"  , ls_User )
		
	CASE "bookingnumberby"  , "booking" 
		This.of_SetAny ( "bookingnumberuser" , ls_User )
		
	CASE "releasedate",   "releasetime",   "releaseby"   
		This.of_SetAny ( "releaseuser"  , ls_User )
		
	CASE"lfdby"  , "lastfreedate" , "lastfreetime"
		This.of_SetAny ( "lfduser"  , ls_User )
		
	CASE"pickupbydate",   "pickupbytime",   "pickupbyby"  
		This.of_SetAny ( "pickupbyuser"   , ls_User )
		
	CASE"delbydate",   "delbytime",   "delbyby"   
		This.of_SetAny ( "delbyuser"  , ls_User )
		
	CASE"cutoffby" , "cutoffdate" , "cutofftime"
		This.of_SetAny ( "cutoffuser" , ls_User )
		
	CASE"emptyatcustomerdate",   "emptyatcustomertime",   "emptyatcustomerby" 
		This.of_SetAny ( "emptyatcustomeruser"     , ls_User )
		
	CASE"loadedatcustomerdate",   "loadedatcustomertime",   "loadedatcustomerby" 
		This.of_SetAny (   "loadedatcustomeruser"    , ls_User )
		
	CASE "railbillnumber"  
		This.of_SetAny ( "railbillnumberuser"   , ls_User )
		
	CASE   "railbilleddate",   "railbilledby"  
		This.of_SetAny ( "railbilleduser"   , ls_User )
		
	CASE"movecode"
	

END CHOOSE


RETURN 1
end function

public function integer of_gettotalmiles (ref decimal ac_miles);long 	ll_row, &
		ll_endrow, &
		ll_return = 1
decimal lc_miles, lc_total
boolean lb_all_ok

n_ds		lds_EventCache

lds_eventcache = this.of_GetEventSource()

if isvalid(lds_EventCache) then
	ll_endrow = lds_EventCache.rowcount()
else
	ll_return = 0
end if

if ll_return = 1 then
	for ll_row = 1 to ll_endrow
		lc_miles = lds_EventCache.object.leg_miles[ll_row]
		if isnull(lc_miles) then
			//skip
		else
			lc_total += lc_miles
		end if
	next
	
	ac_miles = lc_total
	
end if

return ll_return

end function

public function integer of_setdeliverymode (integer ai_pickupindex, integer ai_stopindex);//Pass an event StopIndex in to turn delivery mode on.  Pass null in to turn it off.

//Returns : 1 = Success, 0 = Requested setting already in place, -1 = Error

Integer	li_Return = -1

IF IsNull ( ai_StopIndex ) THEN

	//Request is to turn mode off.

	IF ib_DeliveryMode = FALSE THEN
		//DeliveryMode is already off -- return NoAction
		li_Return = 0
	ELSE
		ib_DeliveryMode = FALSE
		//ii_DeliveryModeStopIndex can stay what it is -- with ib_DeliveryMode = FALSE, it won't be used
//		ib_EventListReady = FALSE
//		ib_ItemListReady = FALSE
		li_Return = 1
	END IF

ELSE

	//Request is to turn mode on.

	IF ib_DeliveryMode = TRUE AND ai_StopIndex = ii_DeliveryModeStopIndex THEN
		//Setting is already in place -- return NoAction
		li_Return = 0
	ELSE
		ib_DeliveryMode = TRUE
		ii_DeliveryModePickupIndex = ai_PickupIndex
		ii_DeliveryModeStopIndex = ai_StopIndex
//		ib_EventListReady = FALSE
//		ib_ItemListReady = FALSE
		li_Return = 1
	END IF

END IF

RETURN li_Return
end function

public function boolean of_getdeliverymodestop (ref integer ai_stopindex);//Returns : TRUE, FALSE -- whether or not we're in delivery mode, and passes out the 
//delivery stopindex in ai_StopIndex if we are.

IF ib_DeliveryMode THEN
	ai_StopIndex = ii_DeliveryModeStopIndex
ELSE
	SetNull ( ai_StopIndex )
END IF

RETURN ib_DeliveryMode
end function

public function boolean of_getdeliverymodepickup (ref integer ai_pickup);//Returns : TRUE, FALSE -- whether or not we're in delivery mode, and passes out the 
//delivery pickupindex in ai_pickupIndex if we are.

IF ib_DeliveryMode THEN
	ai_pickup = ii_DeliveryModepickupIndex
ELSE
	SetNull ( ai_pickup )
END IF

RETURN ib_DeliveryMode
end function

public function string of_getpaymentterms ();RETURN THIS.of_GetValue ( "paymentterms" , Typestring! )
end function

public function integer of_setpaymentterms (string as_value);RETURN THIS.of_SetAny ("paymentterms",  as_Value )
end function

public function integer of_getleasecharges ();integer		li_return = 1

Long			ll_EventCount
Long			i
Long			lla_Equipment[]
Long			lla_id[], &
				lla_blank[]
				
Boolean		lb_AppendToArray = TRUE
Long			ll_ShipID 
Long			ll_ParentID
n_cst_bcm 		lnv_bcm
n_cst_database lnv_database
n_cst_query 	lnv_query
n_ds				lds_Equip
n_cst_bso_Dispatch			lnv_Dispatch
n_cst_Beo_Event				lnva_Events [] 
n_cst_AnyArraySrv				lnv_ArraySrv
n_cst_EquipmentManager		lnv_eqMan

lnv_Dispatch = THIS.of_GetContext ( ) 

ll_ShipID = this.of_GetID ( )
ll_ParentID = this.of_GetParentID ( )

//  get the equipment linked through the events
ll_EventCount = this.of_GetEventList ( lnva_Events )
lla_id = lla_blank
For i = 1 TO ll_EventCount 
	lnva_Events[i].of_getContainerList ( lla_id, lb_AppendToArray   )
	lnva_Events[i].of_getTrailerList ( lla_id, lb_AppendToArray )	
NEXT

if upperbound(lla_id) > 0 then
	//add to equipment array
	lnv_ArraySrv.of_appendlong(lla_Equipment, lla_id)
	lla_id = lla_blank
end if

// get the equipment linked to this shipment
lnv_Dispatch.of_GetEquipmentForShipment ( ll_ShipID , lla_id ) 

if upperbound(lla_id) > 0 then
	//add to equipment array
	lnv_ArraySrv.of_appendlong(lla_Equipment, lla_id)
	lla_id = lla_blank
end if

// get the equipment linked to the parent shipment ( if one exists )
IF ll_ParentID > 0 THEN
	lnv_Dispatch.of_GetEquipmentForShipment ( ll_ParentID , lla_id ) 
	
	if upperbound(lla_id) > 0 then
		//add to equipment array
		lnv_ArraySrv.of_appendlong(lla_Equipment, lla_id)
		lla_id = lla_blank
	end if

END IF

// get the equipment linked to the events of the parent
lnv_Dispatch.of_RetrieveShipment ( ll_ParentID )
ll_EventCount = this.of_GetEventList ( lnva_Events )

FOR i = 1 TO ll_EventCount 
	lnva_Events[i].of_getContainerList ( lla_id, lb_AppendToArray   )
	lnva_Events[i].of_getTrailerList ( lla_id, lb_AppendToArray )	
NEXT

if upperbound(lla_id) > 0 then
	//add to equipment array
	lnv_ArraySrv.of_appendlong(lla_Equipment, lla_id)
	lla_id = lla_blank
end if


IF UpperBound ( lla_Equipment ) > 0 THEN
		
	lds_Equip = Create n_ds
	lds_Equip.DataObject = 'd_equipment_lease_charges'
	lds_Equip.SetTransObject(SQLCA)
	
	lds_Equip.SetUILink ( TRUE )
	
	lnv_database = gnv_bcmmgr.GetDatabase()
	If IsValid(lnv_database) Then
		lnv_query = lnv_database.GetQuery()
		lnv_query.SetArgument(lla_Equipment)
		lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlk_equipmentcache","","Ids")
	End If
	
	IF isValid ( lds_Equip.inv_UILink ) THEN
		lds_Equip.inv_UILink.SetBcm ( lnv_Bcm )
	END IF

	For i = lds_Equip.RowCount ( )  TO 1 STEP -1
		// I am intentionally checking for 0 here as well as null, as opposed to the window, which we want to open if there
		// are 0 charges(so they can override them) <<*>>
		IF IsNull (lds_Equip.object.EquipmentLease_Charges[i] ) OR lds_Equip.object.EquipmentLease_Charges[i] = 0 THEN
			lds_Equip.DeleteRow ( i )
		END IF
		
	NEXT
END IF

if isvalid(lds_Equip) then
	IF lds_Equip.RowCount () <= 0 THEN
		li_return = 0
	end if
	destroy (lds_Equip)
else
	li_return = 0
END IF

return li_return

end function

public function integer of_getreferencedcompanies (ref n_cst_beo_company anva_companies[]);long	lla_Ids[]
int	li_Count
int	i
Int	li_Return
n_cst_Beo_Company	lnva_Companies[]

THIS.of_getReferencedcompanies( lla_Ids )
li_Count = UpperBound ( lla_Ids )

gnv_cst_companies.of_Cache( lla_Ids , FALSE )

FOR i = 1 TO li_Count
	
	lnva_Companies[i] = CREATE n_Cst_beo_Company
	lnva_Companies[i].of_SetUsecache( TRUE )
	lnva_Companies[i].of_SetSourceID ( lla_Ids[i] )
	
NEXT 

anva_companies[] = lnva_Companies
li_Return = i - 1

RETURN li_Return



end function

public function integer of_getreferencedentities (ref pt_n_cst_beo anv_objects[]);Int	li_Count
Int	li_Return
Int	i
pt_n_cst_beo	lnva_ReturnList[]
pt_n_cst_beo	lnva_ReturnList2[]

n_cst_beo_Equipment2	lnva_Equipment[]
n_Cst_beo_Item			lnva_items[]
n_cst_beo_Event		lnva_Events[]
n_cst_beo_Company		lnva_Companies[]

THIS.of_GetReferencedcompanies( lnva_Companies )
THIS.of_getlinkedequipmentviasql ( lnva_Equipment )
THIS.of_GetItemlist( lnva_items )
THIS.of_GetEventlist( lnva_Events )


li_Count = UpperBound ( lnva_Companies )
FOR i = 1 TO li_Count
	li_Return ++
	lnva_ReturnList[ li_Return ] = lnva_Companies[i]
NEXT

li_Count = UpperBound ( lnva_Equipment )
FOR i = 1 TO li_Count
	li_Return ++
	lnva_ReturnList[ li_Return ] = lnva_Equipment[i]
NEXT

li_Count = UpperBound ( lnva_items )
FOR i = 1 TO li_Count
	li_Return ++
	lnva_ReturnList[ li_Return ] = lnva_items[i]
NEXT

li_Count = UpperBound ( lnva_Events )
FOR i = 1 TO li_Count
	li_Return ++
	lnva_ReturnList[ li_Return ] = lnva_Events[i]
NEXT

FOR i = 1 TO li_Return
	lnva_ReturnList[i].of_GetReferencedentities( lnva_ReturnList )
NEXT

li_Count = UpperBound ( anv_objects[] )
FOR i = 1 TO UpperBound ( lnva_ReturnList )
	li_Count ++
	anv_objects [li_Count] = lnva_ReturnList[i]
NEXT

li_Return = UpperBound ( anv_objects[] )


RETURN li_Return

end function

public function integer of_getfreightitemsforpudelpair (integer ai_pu, integer ai_del, ref long ala_itemids[]);Long	lla_ids[]
Int	li_KeepCount
int	i
Int	li_itemCount


n_cst_beo_Item	lnva_Itemlist[]

li_itemCount = THIS.of_GetItemList( lnva_Itemlist ,"L" )
FOR i = 1 TO li_ItemCount
	IF lnva_Itemlist[i].of_GetPickupEvent ( ) = ai_Pu AND lnva_Itemlist[i].of_GetDeliverEvent ( ) = ai_Del THEN
		li_KeepCount ++
		lla_ids[li_KeepCount] = lnva_Itemlist[i].of_GetId ()
	END IF
	DESTROY ( lnva_Itemlist[i] ) 
NEXT

ala_itemids[] =lla_ids

RETURN li_KeepCount
	

end function

public function integer of_setdelrecitems (long ala_itemids[]);ila_DelRecitems = ala_itemids[]
ib_DeliveryMode = TRUE
RETURN 1
end function

public function integer of_determinepaymentterms (string as_whatchanged, ref string as_terms);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_DeterminePaymentTerms
//  
//	Access		:public
//
//	Arguments	:as_terms by reference
//
//	Return		:integer
//						
//	Description	:
//
//			If there are Payment terms on the billto company then use them. If there
//			is no billto specific payment terms then check the shipment type. If 
//			found then use those.
//
//			rule: if the shipment type changed and there is no company terms and there
//					is already a term set, then if the ship type term is different from the
//					current terms, ask user if it should be changed.
//
// Written by	:Norm LeBlanc
// 		Date	:06/30/2004
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//
integer	li_return = 1

string	ls_Terms, &
			ls_currentterms

n_cst_beo_Company	lnv_Company

lnv_company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE )
lnv_Company.of_SetSourceId ( this.of_GetBillto() )

ls_terms = lnv_Company.of_GetPaymentTerms ( )

DESTROY lnv_Company

if len(ls_terms) > 0 then
	//have terms
else
	n_cst_beo_ShipType		lnv_ShipType
	lnv_ShipType = CREATE n_cst_beo_ShipType
	lnv_ShipType.Of_SetUseCache ( TRUE )

	lnv_ShipType.Of_SetSourceId ( this.of_GetType() )
	
	ls_Terms = lnv_ShipType.Of_GetTerms ()
	
	ls_currentterms = this.of_Getpaymentterms( )
	
	
	IF gnv_app.of_runningscheduledtask( ) THEN
		// if we already have terms on the shipment then
		// keep them
		IF ls_currentterms <> '' THEN
			ls_Terms = '' 
		END IF
			
	ELSE
		if as_Whatchanged = cs_action_changedShipType then
			if len(ls_Currentterms) > 0 then
				if ls_terms <> ls_Currentterms then
									
					choose case messagebox('Change AR Terms', "The AR Terms '" + ls_terms + "' for the selected Shipment type" + &
													" does not match the current AR terms '" + ls_currentterms + "'. " +&
													"Do you want to replace the current AR terms with the Shipment Type AR terms?", +&
													question!, YESNO!, 2)
						case 1
							//keep ls_terms
						case 2
							ls_terms = ''
					end choose
	
				end if
			end if
		end if
	END IF
	DESTROY ( lnv_shipType )
end if

if len(ls_terms) > 0 then
	as_terms = ls_terms
else
	li_return = 0
end if

return li_return
end function

public function integer of_getnonorigindestevents (ref n_cst_beo_event anv_events[]);Long	ll_Origin
Long	ll_Dest
Long	ll_EventSite
Int	li_Count
Int	li_Keep
Int	i

n_cst_Beo_Event	lnva_Temp[]
n_cst_Beo_Event	lnva_Keep[]

ll_Origin = THIS.of_GetOrigin( )
ll_Dest = THIS.of_GetDestination( )

li_Count = THIS.of_GetEventlist( lnva_Temp )
FOR i = 1 TO li_Count
	ll_EventSite = lnva_Temp[i].of_GetSite( )
	IF ll_EventSite = ll_Dest OR ll_EventSite = ll_Origin THEN
		DESTROY ( lnva_Temp[i] )
	ELSE		
		li_Keep ++
		lnva_Keep[li_Keep] = lnva_Temp[i]	
	END IF			
NEXT

anv_events[] = lnva_Keep

RETURN li_Keep


end function

public function integer of_getoriginevent (ref n_cst_beo_event anv_event);Long	ll_Origin
Long	ll_EventSite
Int	li_Count
Int	i
Boolean	lb_HaveEvent
Int	li_Return = 0

n_cst_Beo_Event	lnva_Temp[]
n_cst_Beo_Event	lnv_Keep

ll_Origin = THIS.of_GetOrigin( )

li_Count = THIS.of_GetEventlist( lnva_Temp )
FOR i = 1 TO li_Count
	ll_EventSite = lnva_Temp[i].of_GetSite( )
	
	IF ll_EventSite = ll_Origin AND NOT lb_HaveEvent THEN
		li_Return = 1
		lb_HaveEvent = TRUE
		lnv_Keep = lnva_Temp[i]
	ELSE		
		DESTROY ( lnva_Temp[i] )
	END IF			
NEXT

anv_event = lnv_Keep

RETURN li_Return


end function

public function integer of_getdestinationevent (ref n_cst_beo_event anv_event);Long	ll_Dest
Long	ll_EventSite
Int	li_Count
Int	i
Boolean	lb_HaveEvent
Int	li_Return = 0


n_cst_Beo_Event	lnva_Temp[]
n_cst_Beo_Event	lnv_Keep

ll_Dest = THIS.of_GetDestination( )

li_Count = THIS.of_GetEventlist( lnva_Temp )
FOR i = li_Count TO 1 STEP -1
	ll_EventSite = lnva_Temp[i].of_GetSite( )
	
	IF ll_EventSite = ll_Dest AND NOT lb_HaveEvent THEN
		li_Return = 1
		lb_HaveEvent = TRUE
		lnv_Keep = lnva_Temp[i]
	ELSE		
		DESTROY ( lnva_Temp[i] )
	END IF			
NEXT




anv_event = lnv_Keep

RETURN li_Return


end function

public function decimal of_getpermilemileage ();//Returns the summation of all of the leg miles for items rated as per-mile. 
Decimal	lc_Return
Dec	lc_Temp
Int	li_ItemCount
Int	i
n_cst_beo_Item	lnva_items[]

li_ItemCount = THIS.of_Getitemlist( lnva_items )
FOR i = 1 TO li_ItemCount
	IF lnva_Items[i].of_Getratetype( ) = appeon_constant.cs_RateUnit_Code_PerMile THEN
		lc_Temp = lnva_items[i].of_getmiles( )
		IF lc_Temp > 0 THEN
			lc_Return += lc_Temp
		END IF
	END IF
	DESTROY ( lnva_Items[i] )
NEXT

RETURN lc_Return

end function

private function integer of_getlinkedequipmentviasql (ref n_cst_beo_equipment2 anv_equipment[]);// this doesnot return equipment beos with a source only a soure id. This is because we are only using this 
// with UserAlerts and we don't need/want the overhead associated with that


Long	ll_Shipment
Long	ll_EqIds[]
Long	ll_EqID
Int	li_Count
n_Cst_beo_Equipment2	lnva_Eq[]

ll_Shipment = THIS.of_GetID ( )
 
 DECLARE Cur_LinkedEq CURSOR FOR  
  /*SELECT "outside_equip"."oe_id"  
    FROM "outside_equip"  
   WHERE ( "outside_equip"."shipment" = :ll_Shipment ) OR  
         ( "outside_equip"."reloadshipment" = :ll_Shipment )
           ;*/
			  
	//MFS 6/1/07 - Replaced above statement with UNION for performance reasons		  
	SELECT "outside_equip"."oe_id"  
   FROM "outside_equip"  
   WHERE ( "outside_equip"."shipment" = :ll_Shipment ) 
	UNION 
	SELECT "outside_equip"."oe_id"  
   FROM "outside_equip"
   WHERE( "outside_equip"."reloadshipment" = :ll_Shipment )   
           ;

OPEN Cur_LinkedEq;

FETCH Cur_LinkedEq INTO :ll_EqID;

// Loop through result set until exhausted.	
DO WHILE SQLCA.sqlcode = 0

	li_Count ++			
	lnva_Eq[li_Count] = CREATE n_Cst_beo_Equipment2
	lnva_Eq[li_Count].of_SetSourceID ( ll_EqID)
	// Fetch the next row from the result set.
	FETCH Cur_LinkedEq INTO :ll_EqID;
LOOP

// All done, so close the cursor.	
CLOSE Cur_LinkedEq;

Commit;


anv_equipment[] = lnva_Eq


RETURN li_Count




end function

public function boolean of_iscancelled ();Boolean	lb_Result

CHOOSE CASE This.of_GetStatus ( )

CASE gc_Dispatch.cs_ShipmentStatus_Cancelled
	lb_Result = TRUE

CASE ELSE
	lb_Result = FALSE

END CHOOSE

RETURN lb_Result
end function

public subroutine of_autogenaccessorialitem ();integer	i, &
			j, &
			li_Itemcount, &
			li_OldRateCount, &
			li_NewRateCount

long		ll_OriginalBillto, &
			ll_NewBillto, &
			ll_null
			
string	lsa_OriginalRateList[], &
			lsa_RateList[]

boolean	lb_found

n_cst_beo_item			lnva_Item[]
n_cst_bso_Rating		lnv_Rating
n_cst_AnyArraySrv		lnv_Arraysrv

setnull(ll_null)

lnv_Rating = CREATE n_cst_bso_Rating

this.of_SetOriginalValueMode ( TRUE )
ll_OriginalBillto = this.of_GetBillto ( )	
this.of_SetOriginalValueMode ( FALSE )


// the of_getCodeDefaultList was calling overloaded function with a FALSE parm
//li_OldRateCount = lnv_Rating.of_GetCodeDefaultList (ll_OriginalBillto , appeon_constant.cl_AutoCreatedAccessorialCharge_list , lsa_OriginalRateList )

ll_NewBillto = this.of_GetBillto ( )	

li_NewRateCount = lnv_Rating.of_GetCodeDefaultList ( ll_NewBillto , appeon_constant.cl_AutoCreatedAccessorialCharge_list , lsa_RateList , FALSE )

//get item list for comparison
this.of_GetitemList( lnva_Item )
li_ItemCount = upperbound(lnva_Item)

FOR i = 1 TO li_Itemcount
	IF lnva_Item[i].of_GetEventtypeflag( ) = n_cst_constants.cs_ItemEventType_MoveAccessorial THEN
		this.of_removeitem( lnva_Item[i] )
	END IF
	
NEXT 


//Long	ll_Find
//for i = 1 to li_OldRateCount
//
//	ll_Find = lnv_ArraySrv.of_find(lsa_RateList, lsa_OriginalRateList[i], ll_null, ll_null )
//	
//	IF isNull ( ll_Find ) THEN
//		//wasn't found in the new list
//		//is there a matching item
//		lb_found = false
//		for j = 1 to li_ItemCount
//			if lsa_OriginalRateList[i] = lnva_Item[j].of_GetRatecodename( ) then
//				lb_found = true
//				//remove item
//				this.of_removeitem( lnva_Item[j] )
//				//refresh list
//				this.of_GetitemList(lnva_Item, n_cst_constants.cs_itemtype_accessorial)
//				li_ItemCount = upperbound(lnva_Item)
//			end if
//		next
//	ELSEIF ll_Find > 0 THEN
//		//found in new list leave it
//	END IF
//		
//	if lnv_ArraySrv.of_find(lsa_RateList, lsa_OriginalRateList[i], ll_null, ll_null ) > 0 then
//		//found in new list leave it
//	else
//		//wasn't found in the new list
//		//is there a matching item
//		lb_found = false
//		for j = 1 to li_ItemCount
//			if lsa_OriginalRateList[i] = lnva_Item[j].of_GetRatecodename( ) then
//				lb_found = true
//				//remove item
//				this.of_removeitem( lnva_Item[j] )
//				//refresh list
//				this.of_GetitemList(lnva_Item, n_cst_constants.cs_itemtype_accessorial)
//				li_ItemCount = upperbound(lnva_Item)
//			end if
//		next
//	end if
		
//next

//add new items
for i = 1 to li_NewRateCount
	
	//loop thru list of charges to create
	//be careful it may already exist
	//check for ratecode in item list, if it isn't found then create new item
//	lb_found = false
//	for j = 1 to li_ItemCount
//		if lsa_RateList[i] = lnva_Item[j].of_GetRatecodename( ) then
//			lb_found = true
//			exit
//		end if
//	next
	
	if lb_found then
		continue
	else
		ib_autogenaccessorialitem = true
		this.of_Additem( lsa_RateList[i] )
		ib_autogenaccessorialitem = false
	end if

next

DESTROY	lnv_Rating

end subroutine

public function boolean of_createaccessorialitem ();return ib_Autogenaccessorialitem
end function

public function integer of_getitemtype (string as_ratecode, ref long al_amounttype, ref string as_itemtype, ref string as_description);integer	li_return

long		ll_Amounttype

n_cst_beo_amounttype	lnv_AmountType
n_cst_bcm				lnv_Cache

n_cst_bso_Rating	lnv_Rating

lnv_Rating = create n_cst_bso_rating

ll_Amounttype = lnv_Rating.of_Getamounttype( as_ratecode )
as_Description = lnv_Rating.of_GetRatedescription( as_ratecode, this.of_getbillto( ) )

if ll_Amounttype > 0 then
	al_Amounttype = ll_Amounttype
	//get item type 
	IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_amounttype", lnv_Cache, TRUE, TRUE ) = 1 THEN

		lnv_AmountType = lnv_Cache.GetBeo ( "amounttype_id = " + String ( al_amounttype ) )
	
		IF IsValid ( lnv_AmountType ) THEN
			as_Itemtype = lnv_AmountType.of_Getitemtype( )
			li_Return = 1
		ELSE
			as_Itemtype = ''
		END IF
	
	ELSE
		as_Itemtype = ''			
	END IF
	
else
	li_return = 0
end if

destroy lnv_Rating

return li_return



end function

public function long of_additem (string as_type, ref n_cst_bso_dispatch anv_dispatch);
RETURN THIS.of_Additem( as_Type, anv_dispatch, FALSE )
Long			ll_Return = 1
Long			ll_NewID
Long			ll_NewRow
Long			ll_ShipmentID
Boolean		lb_Continue = TRUE
char 			lch_type
integer		li_amounttypeid
long			ll_RateCodeAmountType
String		ls_ItemType
any			la_value
Long			ll_Bufrows
String		ls_ItemSelect
Long			ll_RR
Long			ll_Null
String		ls_OldDocType	
String		ls_FreightDescription
String		ls_ItemDescription
String		ls_localtype
String		ls_Ratecode


n_cst_sql			lnv_Sql
n_cst_SqlAttrib	lnva_SqlAttrib[], &
						lnva_BlankSqlAttrib[]
DataStore	lds_ItemCache
DataStore	lds_ItemWork
n_cst_dws	lnv_Dws
n_cst_ShipmentManager	lnv_ShipmentManager
n_cst_numerical 			lnv_numerical
n_cst_settings				lnv_settings
n_cst_beo_Item				lnv_Item

SetNull ( ll_Null )  

lnv_Item = CREATE n_cst_beo_Item	


ls_localtype = as_type

IF lb_Continue THEN
	IF THIS.of_AddItem ( ) < 1 THEN
		lb_Continue = FALSE
	END IF
END IF

IF Not IsValid ( anv_Dispatch ) THEN
	lb_Continue = FALSE
END IF

IF lb_Continue THEN
	ll_ShipmentID = THIS.of_GetID ( )
	IF lnv_numerical.of_IsNullOrNeg( ll_ShipmentID ) THEN
		lb_Continue = FALSE
	END IF
END IF	

IF lb_Continue THEN

	choose case ls_localtype
		case "FREIGHT!" , "L"
			lch_type = "L"
			if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
				li_amounttypeid = integer(la_value)
			else
				li_amounttypeid = 0
			end if
		case "ACCESS!" , "A"
			lch_type = "A"
			if lnv_Settings.of_GetSetting ( 99 , la_value ) > 0 then
				li_amounttypeid = integer(la_value)
			else
				li_amounttypeid = 0
			end if
		
			
		CASE "FUELSURCHARGE!"
			lch_type = "A"
			if lnv_Settings.of_GetSetting ( 99 , la_value ) > 0 then
				li_amounttypeid = integer(la_value)
			else
				li_amounttypeid = 0
			end if
			
		case else
			//is it one of the auto gen accessorial rates?
			
			if this.of_createaccessorialitem( ) THEN
				ls_RateCode = as_type
				//get amount type from rate code and set item type based on amount type itemtype
				if this.of_GetItemtype( ls_RateCode, ll_RateCodeAmountType, ls_ItemType, ls_ItemDescription ) = 1 then
					li_amounttypeid = integer(ll_RateCodeAmountType)
					lch_type = ls_ItemType
					ls_localtype = ls_ItemType
//					lch_type = "A"
//					ls_localtype = 'ACCESS!'
				else
					//default to system setting for accessorial
					lch_type = "A"
					ls_localtype = 'ACCESS!'
					
					if lnv_Settings.of_GetSetting ( 99 , la_value ) > 0 then
						li_amounttypeid = integer(la_value)
					else
						li_amounttypeid = 0
					end if
				end if		
				
			ELSE
				//NOT ONE OF THE LIST
				lb_Continue = FALSE
				
			END IF
			
	end choose
	
END IF

IF lb_Continue THEN
	gnv_App.of_Getnextid( "n_cst_beo_item", ll_NewID, TRUE )	
END IF

//  !!!
//IF lb_Continue THEN	
//	insert into disp_items (di_item_id, di_item_type ) 
//	values (:ll_NewID, :lch_type ) ;
//	
//	if sqlca.sqlcode <> 0 then
//		rollback ;
//		lb_Continue = FALSE
//	else
//		commit ;
//	end if
//END IF


IF lb_Continue THEN
	lds_ItemCache = anv_Dispatch.of_GEtItemCache ( )
	IF Not IsValid ( lds_ItemCache ) THEN
		lb_Continue = FALSE
	END IF
END IF

//IF lb_Continue AND lch_type = "L" THEN
//	n_Cst_beo_company 	lnv_Company
//	IF THIS.of_GetOrigin( lnv_Company , TRUE ) = 1 THEN
//		ls_FreightDescription = lnv_Company.of_GetDefaultfreightdescription( )
//	END IF
//	DESTROY ( lnv_Company )
//END IF


IF lb_Continue THEN
	
	ll_Return = ll_NewID
	ll_NewRow = lds_ItemCache.InsertRow ( 0 ) 
	lds_ItemCache.setitem(ll_NewRow, "di_item_id", ll_NewID)
	lds_ItemCache.setitem(ll_NewRow, "di_item_type", lch_type)
	
// !!!	
//	lds_ItemCache.setitemstatus(ll_NewRow, 0, primary!, datamodified!)
//	lds_ItemCache.setitemstatus(ll_NewRow, 0, primary!, notmodified!)

	lds_ItemCache.setitem(ll_NewRow, "di_shipment_id", THIS.of_GetID ( ) )
	lds_ItemCache.setitem(ll_NewRow, "accountingtype", n_cst_constants.cs_AccountingType_Both )
	
	if len(ls_Ratecode) > 0 then
	//	if this.of_IsIntermodal( ) then
			//auto move accessorial item
			lds_ItemCache.setitem(ll_NewRow, "eventflag", n_Cst_Constants.cs_ItemEventType_MoveAccessorial )
	//	end if
		lds_ItemCache.setitem(ll_NewRow, "ratecodename", ls_Ratecode)
		lds_ItemCache.setitem(ll_NewRow, "di_description", ls_ItemDescription )
	end if

	lnv_Item.of_SetSource ( lds_ItemCache )
	lnv_Item.of_SetSourceID ( ll_NewID )
	lnv_Item.of_SetShipment ( THIS )
	
	
	// we are doing this b/c of_setAmountType will kick off undesired processing unless the item knows it is the FSC
	// and of_MakeFuelSurcharge may ovewrride the default amount type... in other words, think before changing this
	IF ls_Localtype = "FUELSURCHARGE!" THEN
		lnv_Item.of_SetEventTypeFlag ( n_Cst_Constants.cs_ItemEventType_FuelSurcharge )
	END IF
	lnv_Item.of_SetDefaultFreightCircles ( THIS )
	lnv_Item.of_SetAmountType ( li_amounttypeid )
	IF ls_Localtype = "FUELSURCHARGE!" THEN
		lnv_Item.of_MakeFuelSurcharge ( )
	END IF
		
	//lnv_Item.of_Setdescription( ls_FreightDescription )

END IF



IF ib_autogenaccessorialitem AND lb_Continue THEN
	IF lnv_Item.of_Autorateandapply( ) = -1 THEN
		this.OF_removeitem( lnv_Item )   											 
	END IF
END IF

//IF lb_Continue THEN
//	THIS.of_RecalcSurcharges ( ) 
//END IF

//IF lb_Continue THEN  now done in the dispatch
//	
//	IF lnv_Settings.of_CreateAccNotification ( ) THEN  // we are using 'THIS' so we can report a running total
//		ls_OldDocType = THIS.of_GetDocumentType ( )    //  of Acc items
//		THIS.of_setDocumentType ( appeon_constant.cs_acc )	
//		anv_Dispatch.of_GetNotificationManager( ).of_CreatePendingNotification ( THIS )	
//		THIS.of_SetDocumentType ( ls_OldDocType )	
//	END IF
//END IF

DESTROY ( lds_ItemWork )
DESTROY	lnv_Item

IF NOT lb_Continue THEN
	ll_Return = -1
END IF

RETURN ll_Return
end function

public function integer of_getnonorigindestevents (ref n_cst_beo_event anva_events[], boolean ab_hidecrossdocks);Int	li_Count
Int	li_Keep
Int	i
Long	lla_DockRows[]
Int	li_Return
Int	li_DocCount
n_cst_CrossDock lnv_Docks
n_cst_Beo_Event	lnva_Keep[]
n_cst_Beo_Event	lnva_Events[]
n_Cst_anyArraySrv	lnv_Array

lnv_Docks = CREATE n_cst_CrossDock	

THIS.of_GetNonOrigindestevents( lnva_Events )

IF NOT ab_hidecrossdocks THEN
	anva_events[] = lnva_Events
	li_Return = UpperBound ( anva_events[]  )	
ELSE
	
	lnv_Docks.of_Getdockrows( THIS.of_geteventsource( ) , lla_DockRows )
	li_DocCount = UpperBound ( lla_dockRows )
	li_Count = UpperBound ( lnva_Events )
	
	FOR i = 1 TO li_Count
		
		IF lnv_Array.of_FindLong (lla_DockRows , lnva_Events[i].of_GetSourceRow ( ) , 1, li_DocCount ) > 0 THEN
			DESTROY ( lnva_Events[i] )
		ELSE		
			li_Keep ++
			lnva_Keep[li_Keep] = lnva_Events[i]	
		END IF			
	NEXT
	
	li_Return = li_Keep
	anva_events[] = lnva_Keep
	
END IF

DESTROY (lnv_Docks)

RETURN li_Return




end function

public function integer of_geteventlist (ref n_cst_beo_event anva_events[], boolean ab_removecrossdocs);Int	li_Return
Long	lla_DockRows[]
n_Cst_beo_event	lnva_Events[]
n_Cst_beo_event	lnva_Keep[]
Int	li_DocCount
Int	li_KeepCount
Int	i
n_Cst_AnyArraySrv	lnv_Array

n_cst_CrossDock	lnv_Docks
lnv_Docks = CREATE n_cst_CrossDock	

THIS.of_GetEventlist( lnva_Events )

IF NOT ab_removecrossdocs THEN
	
	anva_events[] = lnva_Events
	li_Return = UpperBound ( anva_events[] )

ELSE
	
		
	lnv_Docks.of_Getdockrows( THIS.of_geteventsource( ) , lla_DockRows )
	li_DocCount = UpperBound ( lla_dockRows )
	FOR i = 1 TO UpperBound ( lnva_Events )
		IF lnv_Array.of_FindLong (lla_DockRows , lnva_Events[i].of_GetSourceRow ( ) , 1, li_DocCount ) > 0 THEN
			DESTROY  (lnva_Events[i] )
			CONTINUE
		ELSE
			li_KeepCount ++
			lnva_Keep [ li_KeepCount ] = lnva_Events[i]
		END IF
			
	NEXT
	
	li_Return = li_KeepCount
	anva_events[] = lnva_Keep

END IF

DESTROY ( lnv_Docks )

RETURN li_Return
end function

public function integer of_addbilltodocumentrequest (string as_documenttype);// curently this updates the request 

Long	ll_BillTo
Int	li_Return = 1
n_cst_bso_Document_manager	lnv_Docman
lnv_Docman = CREATE n_cst_bso_Document_manager

ll_BillTo = THIS.of_GetBillto( )
IF ll_BillTo > 0 THEN
	IF lnv_Docman.of_AddTransferrequest( ll_BillTo, as_documenttype , THIS.of_GetID ( ), TRUE ) <> 1 THEN
		li_Return = -1
	END IF
ELSE
	li_Return = -1
END IF

IF li_Return = 1 THEN
	IF lnv_Docman.event pt_save( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

DESTROY ( lnv_Docman ) 
	
	

RETURN li_Return
end function

private function integer of_klugevalidation (ref string as_error);// this is a temporary validation script that is only to be called to validate changes to EDI Shipments for Daybreak.
// this will be deleted in the near future. 

// THIS is not the most efficient code by any shot. But I don't care.... just look at the method name!

Int	li_Return = 1
String	ls_MasterBl
String	ls_Ref1Text
String	ls_Ref3Text

Int		li_Ref1Type
Int		li_Ref3Type

Int		li_Count
Int		i
String	ls_ErrorMessage

Int	li_Pcs
Long	ll_Weight
String	ls_Com

n_Cst_AnyArraySrv	lnv_Array


n_cst_beo_Event	lnva_Events[],&
						lnva_MTEvents[]
n_cst_beo_Item		lnva_items[],&
						lnva_MTItems[]


//Items REQUIRED before Authorizing for Billing:

//1)    CAN#... Ref1Label = Auth# and Ref1Text is present
ls_Ref1Text = THIS.of_GetRef1Text( )
li_Ref1Type = THIS.of_GetRef1Type( )
IF NOT ( li_Ref1Type = 16 AND ( Len ( Trim ( ls_Ref1Text ) ) > 0  OR NOT isNull ( ls_Ref1Text ) )) THEN
	li_Return = -1
	ls_ErrorMessage += "Ref 1 Values are not correctly populated.~r~n"
END IF

//2)    PO#..... Ref3Label = PO# and Ref3Text is present
ls_Ref3Text = THIS.of_GetRef3Text( )
li_Ref3Type = THIS.of_GetRef3Type( )
IF NOT ( li_Ref3Type = 3 AND (Len ( Trim ( ls_Ref3Text ) ) > 0  OR NOT isNull ( ls_Ref3Text ) )) THEN
	li_Return = -1
	ls_ErrorMessage += "Ref 3 Values are not correctly populated.~r~n"
END IF

//3)    Master BL#
ls_MasterBl = THIS.of_GetMAsterbl( )
IF NOT ( len ( Trim ( ls_MasterBl ) ) ) > 0 OR isNull ( ls_MasterBl )  THEN
	li_Return = -1
	ls_ErrorMessage += "The master BL is missing.~r~n"
END IF

//4)    All Freight Line Items must have Pcs/weight and commodity
li_Count = THIS.of_GetItemList( lnva_items , n_cst_Constants.cs_ItemType_Freight)
FOR i = 1 TO li_Count
	
	li_Pcs = lnva_items[i].of_GetQuantity( )
	ll_Weight = lnva_items[i].of_GetTotalweight( )
	ls_Com = lnva_items[i].of_GetDescription( )
	
	If isNull ( lnva_items[i].of_GetEventtypeflag( ) ) THEN // check all	
		IF  ( li_Pcs <= 0 OR IsNull (ll_Weight ) OR ll_Weight <= 0 OR IsNull ( ls_Com ) OR Len ( Trim ( ls_Com )) = 0 )THEN
			li_Return = -1
			ls_ErrorMessage += "Not all freight items have required data. (Pcs/weight and commodity)~r~n"
			EXIT
		END IF
	ELSE
		IF IsNull ( ls_Com ) OR Len ( Trim ( ls_Com )) = 0 THEN
			li_Return = -1
			ls_ErrorMessage += "Not all freight items have required data. (commodity)~r~n"
			EXIT
		END IF
	END IF
		
NEXT
lnv_Array.of_Destroy( lnva_items )
lnva_items = lnva_MTItems

//5)    All Line Items (Freight AND Access.) must be linked to an event... with the exception of FSC.
li_Count = THIS.of_GetItemList ( lnva_items ) 
FOR i = 1 TO li_Count
	IF lnva_items[i].of_GetEventtypeflag( ) = n_cst_Constants.cs_ItemEventType_FuelSurcharge THEN
		CONTINUE
	ELSEIF Not lnva_items[i].of_isfullyassigned( )  THEN
		li_Return = -1 
		ls_ErrorMessage += "Not all items have been assigned to events.~r~n"
		EXIT
	END IF
NEXT
lnv_Array.of_Destroy( lnva_items )
lnva_items = lnva_MTItems

//6)    Pick-up date and Delivery Date (all events confirmed)
li_Count = THIS.of_GetEventlist( lnva_Events )
FOR i = 1 TO li_Count
	IF Not ( lnva_Events[i].of_Isconfirmed( ) ) THEN
		li_Return = -1
		ls_ErrorMessage += "All events are not confirmed.~r~n"
		EXIT
	END IF
NEXT
lnv_Array.of_Destroy( lnva_Events )
lnva_Events = lnva_MTEvents

IF isNull ( THIS.of_GetDatedelivered( ) ) THEN
	li_Return = -1
	ls_ErrorMessage += "The delivery date has not been specified.~r~n"	
END IF

IF isNull ( THIS.of_getdatepickedup( ) ) THEN
	li_Return = -1
	ls_ErrorMessage += "The Pickup date has not been specified.~r~n"	
END IF

//7)    Freight rate and Freight charges
li_Count = THIS.of_GetItemList ( lnva_items , n_cst_Constants.cs_ItemType_Freight ) 
FOR i = 1 TO li_Count
	IF lnva_items[i].of_GetRate( ) > 0 AND lnva_items[i].of_Getfreightcharges( ) > 0 THEN
		EXIT  // Terry said that one item w/ charges is enough
	END IF
NEXT
IF i > li_Count THEN
	li_Return = -1
	ls_ErrorMessage += "The freight rate and charges could not be resovled.~r~n"
END IF
lnv_Array.of_Destroy( lnva_items )
lnva_items = lnva_MTItems




//Items to be WARNED if not present:


IF li_Return <> -1 THEN
 
//1)    Freight Line Item Ref# (if more than one Freight Line Item).
	li_Count = THIS.of_GetItemList ( lnva_items , n_cst_Constants.cs_ItemType_Freight ) 
	IF li_Count > 1 THEN
		FOR i = 1 TO li_Count
			IF IsNull ( lnva_items[i].of_getreference( ) ) OR ( len ( Trim ( lnva_items[i].of_getreference( ) )) ) = 0 THEN
				li_Return = 0 
				ls_ErrorMessage = "Reference Numbers have not been assigned to all of the freight items.~r~n"
				EXIT
			END IF
		NEXT		
	END IF
	lnv_Array.of_Destroy( lnva_items )
	lnva_items = lnva_MTItems

//2)    Trailer# (destinationevent.trailerlist)
	n_cst_beo_Event	lnv_Dest
	THIS.of_GetDestinationevent( lnv_Dest )
	IF isValid ( lnv_Dest ) THEN
		IF IsNull ( lnv_Dest.of_GetTrailerlist( ) ) OR Len ( Trim ( lnv_Dest.of_GetTrailerlist( ) )) = 0 THEN
			li_Return = 0
			ls_ErrorMessage += "A trailer has not been assigned to the deliver event.~r~n"
		END IF
	END IF
	
END IF


as_error = ls_ErrorMessage


RETURN li_Return



end function

public function integer of_addyardmove (long al_siteid, integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatch, ref long ala_newids[]); //doin' a yard move ( this is a two event move. Drop , Hook )
		

Int					i
Int					li_NewCount
Boolean				lb_Hide

dataStore			lds_Events
n_cst_beo_Event	lnv_Event
n_cst_setting_hideyardmovesonbill	lnv_MarkAsHide
lnv_MarkAsHide = CREATE n_cst_setting_hideyardmovesonbill
lnv_Event = CREATE n_cst_beo_Event

lb_Hide = lnv_MarkAsHide.of_Getvalue( ) = lnv_MarkAsHide.cs_Yes
lnv_Event.of_SetShipment ( THIS ) 
THIS.of_AddEvents ( {gc_Dispatch.cs_Eventtype_Drop , gc_Dispatch.cs_Eventtype_Hook} , ai_InsertionPoint , anv_Dispatch , ala_NewIds[] )

li_newCount = UpperBound ( ala_NewIds )

lds_Events = THIS.of_GetEventSource ( )
lnv_Event.of_SetSource ( lds_Events )


FOR i = 1 TO li_NewCount
	
	lnv_Event.of_SetSourceID ( ala_NewIds [ i ] )
	lnv_Event.of_SetAllowFilterSet ( TRUE )
	lnv_Event.of_SetSite ( al_SiteID )
	lnv_Event.of_Sethideonbill( lb_Hide )
	

NEXT

DESTROY ( lnv_MarkAsHide )
DESTROY ( lnv_Event )

RETURN 1
end function

public function boolean of_allowitemedit ();Boolean	lb_Allow
n_cst_Privileges	lnv_Privileges
n_cst_setting_allowforcebilling	lnv_AllowForceBilling

IF of_IsBilled ( ) THEN

	IF lnv_Privileges.of_Shipment_EditBilledBill ( ) THEN
		lb_Allow = TRUE
	END IF
	//ADDED BY DAN 2/8/07
	IF gnv_app.of_GetPrivsmanager( ).of_getuserpermissionfromfn( appeon_constant.cs_ModifyBilledShipRates , this) = 1 THEN
		lb_allow = true
	END IF
	/////////////////////
//	IF Not lb_Allow THEN
//		lnv_AllowForceBilling = CREATE n_cst_setting_allowforcebilling
//		IF lnv_AllowForceBilling.of_GetValue( ) = lnv_AllowForceBilling.cs_yes THEN
//			IF THIS.of_Getconfirmedeventcount( ) <> THIS.of_GetEventcount( ) THEN
//				lb_Allow = TRUE
//			END IF				
//		END IF
//		DESTROY (lnv_AllowForceBilling)		
//	END IF

ELSEIF of_IsRestricted ( ) THEN

	IF lnv_Privileges.of_Shipment_EditRestrictedBill ( ) THEN
		lb_Allow = TRUE
	END IF

ELSEIF lnv_Privileges.of_Shipment_EditBill ( ) THEN

	lb_Allow = TRUE

END IF

//IF THIS.of_GetStatus ( ) = gc_Dispatch.cs_ShipmentStatus_Offered OR &
//	THIS.of_GetStatus ( ) = gc_Dispatch.cs_ShipmentStatus_Declined THEN
//	lb_Allow = FALSE
//END IF


RETURN lb_Allow
end function

public function integer of_addyardmove (long al_siteid, integer ai_insertionpoint, n_cst_bso_dispatch anv_dispatch, ref long ala_newids[], long al_dropid); //doin' a yard move ( this is a two event move. Drop , Hook )
		

Int					i
Int					li_NewCount
Boolean				lb_Hide
Long					lla_EventIds[]
dataStore			lds_Events
n_cst_beo_Event	lnv_Event

n_cst_setting_hideyardmovesonbill	lnv_MarkAsHide
lnv_MarkAsHide = CREATE n_cst_setting_hideyardmovesonbill
lnv_Event = CREATE n_cst_beo_Event

lb_Hide = lnv_MarkAsHide.of_Getvalue( ) = lnv_MarkAsHide.cs_Yes
lnv_Event.of_SetShipment ( THIS ) 
THIS.of_AddEvents ( { gc_Dispatch.cs_Eventtype_Hook} , ai_InsertionPoint + 1 , anv_Dispatch , ala_NewIds[] )

// Since we have the drop event id already we want to put 
// the hook after it since the new events could automaticaly routed
// to the shipment in the order that they come back from this method
lla_EventIds [1] = al_dropid
IF UpperBound ( ala_newids[] ) > 0 THEN
	lla_EventIds [2] = ala_newids[1]
END IF

ala_NewIds = lla_EventIds
li_newCount = UpperBound ( ala_NewIds )


lds_Events = THIS.of_GetEventSource ( )
lnv_Event.of_SetSource ( lds_Events )


FOR i = 1 TO li_NewCount
	
	lnv_Event.of_SetSourceID ( ala_NewIds [ i ] )
	lnv_Event.of_SetAllowFilterSet ( TRUE )
	lnv_Event.of_SetSite ( al_SiteID )
	lnv_Event.of_Sethideonbill( lb_Hide )
	IF i = 1 THEN
		lnv_Event.of_SetType ( gc_Dispatch.cs_Eventtype_Drop )
	END IF
	IF i = 2 THEN
		lnv_Event.of_SetType ( gc_Dispatch.cs_Eventtype_Hook )
	END IF
NEXT


DESTROY ( lnv_MarkAsHide )
DESTROY ( lnv_Event )

RETURN 1
end function

public function boolean of_hasnewfuelsurcharge ();//Written by dan, returns true if the surcharge source row is not 'notModified!'
Boolean	lb_Return
Int		li_ItemCount
Int		i
dwItemStatus		li_itemStatus
Long	ll_sourceRow

Datawindow ldw_source
Datastore	lds_source
PowerObject	lpo_source

n_cst_beo_item	lnva_Items[]
n_cst_AnyArraySrv		lnv_ArraySrv

li_ItemCount = THIS.of_GetItemList ( lnva_Items )

FOR i = 1 TO li_ItemCount 
	IF lnva_Items[i].of_GetEventTypeFlag ( ) = n_Cst_Constants.cs_ItemEventType_FuelSurcharge  THEN
		//get the source and source row
		lpo_source = lnva_items[i].of_getSource( )
		ll_sourceRow = lnva_Items[i].of_getSourcerow( )
		IF isValid( lpo_source ) THEN
			IF lpo_source.typeOf( ) = datawindow! THEN
				ldw_source = lpo_source
				li_itemStatus = ldw_source.getItemStatus( ll_sourceRow, 0 /*status of entire row*/, PRIMARY! )
			ELSEIF lpo_source.typeOf() = datastore! THEN
				lds_source =  lpo_source
				li_itemStatus = lds_source.getItemStatus( ll_sourceRow, 0 /*status of entire row*/, PRIMARY! )
			END IF
						
			IF li_itemStatus = NEW! OR  li_itemStatus = NewModified! THEN
				lb_Return = TRUE
				EXIT
			END IF
		END IF
	END IF
NEXT

lnv_ArraySrv.of_Destroy ( lnva_Items )

RETURN lb_Return
end function

public function integer of_recalcexistingsurcharges (boolean ab_useoldvalue);//Written By Dan 1-3-2006 to use new version of of_makeFuelSurcharge.  If ab_useOldValue is False it has the default behavior
//If its true then it uses the old Value used to recalculate existing fuel surcharges.

/* 
	this method can be called to ReCalc any existing surcharges. It will not add or remove any items	
	Returns the number of items recalculated
*/

Int	li_Count
Int	i
Int	j
n_cst_beo_Item	lnva_Items[]

li_Count = this.of_getitemsforeventtype ( n_cst_Constants.cs_ItemEventType_FuelSurcharge , lnva_Items ) 
	
FOR i = 1 TO li_Count
	IF lnva_Items[i].of_MakeFuelSurcharge ( ab_useOldValue ) = 1 THEN// this will recalc the surcharge.	
		IF lnva_Items[i].of_GetBillingAmount ( ) = 0 THEN
			For j = 1 TO 5
				Yield ()
			NEXT
			
			
			//mod 2-16-2006  these replaced this.removeItem
	//		lnva_Items[i].of_SetRate( 0 )
	//		lnva_Items[i].of_SetDescription( "FUEL SURCHARGE")
			lnva_Items[i].of_resetFuelSurcharge()
			
			//THIS.of_RemoveItem ( lnva_Items[i] )
		END IF
	END IF
	DESTROY ( lnva_Items[i] )
NEXT
		

RETURN li_Count 
end function

public function integer of_getlinkedequipmentnocoinfo (ref n_cst_beo_equipment2 anva_equipment[]);Int		li_Count
Int		i
Long		ll_ShipmentID
Int		li_Return
String	ls_Where

n_cst_beo_Equipment2		lnva_Equipment2 []

n_cst_EquipmentManager	lnv_EquipmentManager
n_cst_anyarraysrv		lnv_ArraySrv



lnv_ArraySrv.of_Destroy( anva_equipment[] )


IF Not isValid (ids_equipment) THEN

	ll_ShipmentID = THIS.of_GetID ( ) 
		
	// first build the where clause for linked equipment
	ls_Where = "WHERE ( ~~~"outside_equip~~~".~~~"shipment~~~" = " + String ( ll_ShipmentID ) + " OR  ~~~"outside_equip~~~".~~~"reloadshipment~~~" = " + String ( ll_ShipmentID ) + " ) AND eq_status <> 'X' "

	lnv_EquipmentManager.of_Retrieve( ids_equipment, ls_Where)
	
END IF

li_Count = ids_equipment.RowCount ( ) 


FOR i = 1 TO li_Count
	lnva_Equipment2[i] = CREATE n_cst_beo_Equipment2
	lnva_Equipment2[i].of_SetSource ( ids_equipment )
	lnva_Equipment2[i].of_SetSourceRow ( i )
NEXT

anva_equipment[] = lnva_Equipment2

li_Return = UpperBound ( anva_Equipment )

RETURN li_Return

end function

public function long of_getdivisionid ();RETURN This.of_GetValue ( "ds_ship_type", TypeLong! )
end function

public function string of_getmanifestinvoicenumbernodashes ();String 	ls_Pronum
Integer	li_Pos

ls_Pronum = This.of_GetValue ( "ds_pronum", TypeString! )

li_Pos = Pos(ls_Pronum, "--")

IF li_Pos > 0 THEN
	ls_ProNum = Left(ls_Pronum, li_Pos - 1)
END IF

RETURN ls_ProNum 
end function

public function integer of_markasmodified ();Int		li_Return = -1
Long		ll_sourceRow
Long		ll_ID
dwBuffer	ldwb_Buffer
DataStore	lds_Source

lds_Source = THIS.of_GetSource ( )

IF THIS.of_Getsourcerow( ll_sourceRow, ldwb_Buffer, FALSE ) = 1 AND IsValid ( lds_Source ) THEN

	IF lds_Source.SetItemStatus( ll_SourceRow , 0 , ldwb_Buffer, DataModified! ) = 1 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return
end function

public function boolean of_setautoratingforedicompany (long al_companyid);//added by dan 8-21-2006
//this function is called from n_cst_ediShipmentManager.of_createShipment

//if the return value is true then it means that, the company passed in, has their autorate
//imported edishipments set to yes.  Or true if the scheduler isn't running.

Boolean	lb_Return
Long	ll_rows
String		ls_autorate
datastore	lds_204profile

lds_204Profile = CREATE datastore
lds_204Profile.dataobject = "d_204companysettings"
lds_204Profile.setTransobject( SQLCA )

IF gnv_App.of_Runningscheduledtask( ) THEN

	ll_rows = lds_204Profile.retrieve( al_companyID )
	commit;
	
	IF ll_rows > 0 THEN
		ls_autoRate = lds_204Profile.getItemString( ll_rows, "edi204profile_autorate" )
							
		IF ls_autorate = "Yes" THEN
			ib_autorateforedicompany = TRUE
		END IF
	END IF
else
	lb_return = true		//this will allow normal processing to take place.
END IF

DESTROY lds_204profile
RETURN lb_Return
end function

public function boolean of_getautorateforedicompany ();//created by Dan 8-21-2006
/*
	This is true if the scheduler is not running and they have an autorating liscence OR
	the scheduler is running and the sending edi company has a setting of autorate next to it.
*/
return ib_autorateforedicompany
end function

public function long of_additem (string as_type, boolean ab_ignorerestrictions);
Long			ll_Return = 1

Boolean		lb_Continue = TRUE

n_Cst_Bso					lnv_Dispatch
n_cst_bso_Dispatch		lnv_CastDispatch

lnv_Dispatch = THIS.of_GetContext ( ) 
IF IsValid ( lnv_Dispatch ) THEN
	IF lnv_Dispatch.Classname ( ) = "n_cst_bso_dispatch" THEN
		lnv_CastDispatch = lnv_Dispatch
		lb_Continue = TRUE
	ELSE
		lb_Continue = FALSE
	END IF
ELSE
	lb_Continue = FALSE
END IF

IF lb_Continue THEN
	ll_Return = THIS.of_AddItem ( as_type , lnv_CastDispatch , ab_ignorerestrictions )
END IF

RETURN ll_Return


end function

public function long of_additem (string as_type, ref n_cst_bso_dispatch anv_dispatch, boolean ab_temporaryitem);
Long			ll_Return = 1
Long			ll_NewID
Long			ll_NewRow
Long			ll_ShipmentID
Boolean		lb_Continue = TRUE
char 			lch_type
integer		li_amounttypeid
long			ll_RateCodeAmountType
String		ls_ItemType
any			la_value
Long			ll_Bufrows
String		ls_ItemSelect
Long			ll_RR
Long			ll_Null
String		ls_OldDocType	
String		ls_FreightDescription
String		ls_ItemDescription
String		ls_localtype
String		ls_Ratecode


n_cst_sql			lnv_Sql
n_cst_SqlAttrib	lnva_SqlAttrib[], &
						lnva_BlankSqlAttrib[]
DataStore	lds_ItemCache
DataStore	lds_ItemWork
n_cst_dws	lnv_Dws
n_cst_ShipmentManager	lnv_ShipmentManager
n_cst_numerical 			lnv_numerical
n_cst_settings				lnv_settings
n_cst_beo_Item				lnv_Item

SetNull ( ll_Null )  

lnv_Item = CREATE n_cst_beo_Item	


ls_localtype = as_type

IF lb_Continue AND NOT ( ab_temporaryitem ) THEN
	IF THIS.of_AddItem ( ) < 1 THEN
		lb_Continue = FALSE
	END IF
END IF

IF Not IsValid ( anv_Dispatch ) THEN
	lb_Continue = FALSE
END IF

IF lb_Continue THEN
	ll_ShipmentID = THIS.of_GetID ( )
	IF lnv_numerical.of_IsNullOrNeg( ll_ShipmentID ) THEN
		lb_Continue = FALSE
	END IF
END IF	

IF lb_Continue THEN

	choose case ls_localtype
		case "FREIGHT!" , "L"
			lch_type = "L"
			if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
				li_amounttypeid = integer(la_value)
			else
				li_amounttypeid = 0
			end if
		case "ACCESS!" , "A"
			lch_type = "A"
			if lnv_Settings.of_GetSetting ( 99 , la_value ) > 0 then
				li_amounttypeid = integer(la_value)
			else
				li_amounttypeid = 0
			end if
		
			
		CASE "FUELSURCHARGE!"
			lch_type = "A"
			if lnv_Settings.of_GetSetting ( 99 , la_value ) > 0 then
				li_amounttypeid = integer(la_value)
			else
				li_amounttypeid = 0
			end if
			
		case else
			//is it one of the auto gen accessorial rates?
			
			if this.of_createaccessorialitem( ) THEN
				ls_RateCode = as_type
				//get amount type from rate code and set item type based on amount type itemtype
				if this.of_GetItemtype( ls_RateCode, ll_RateCodeAmountType, ls_ItemType, ls_ItemDescription ) = 1 then
					li_amounttypeid = integer(ll_RateCodeAmountType)
					lch_type = ls_ItemType
					ls_localtype = ls_ItemType
//					lch_type = "A"
//					ls_localtype = 'ACCESS!'
				else
					//default to system setting for accessorial
					lch_type = "A"
					ls_localtype = 'ACCESS!'
					
					if lnv_Settings.of_GetSetting ( 99 , la_value ) > 0 then
						li_amounttypeid = integer(la_value)
					else
						li_amounttypeid = 0
					end if
				end if		
				
			ELSE
				//NOT ONE OF THE LIST
				lb_Continue = FALSE
				
			END IF
			
	end choose
	
END IF

IF lb_Continue THEN//AND NOT ab_temporaryitem THEN
	gnv_App.of_Getnextid( "n_cst_beo_item", ll_NewID, TRUE )	

	lds_ItemCache = anv_Dispatch.of_GEtItemCache ( )
	IF Not IsValid ( lds_ItemCache ) THEN
		lb_Continue = FALSE
	END IF
END IF

//IF lb_Continue AND lch_type = "L" THEN
//	n_Cst_beo_company 	lnv_Company
//	IF THIS.of_GetOrigin( lnv_Company , TRUE ) = 1 THEN
//		ls_FreightDescription = lnv_Company.of_GetDefaultfreightdescription( )
//	END IF
//	DESTROY ( lnv_Company )
//END IF


IF lb_Continue THEN //AND NOT ab_temporaryitem THEN
	
	ll_Return = ll_NewID
	ll_NewRow = lds_ItemCache.InsertRow ( 0 ) 
	lds_ItemCache.setitem(ll_NewRow, "di_item_id", ll_NewID)
	lds_ItemCache.setitem(ll_NewRow, "di_item_type", lch_type)
	
// !!!	
//	lds_ItemCache.setitemstatus(ll_NewRow, 0, primary!, datamodified!)
//	lds_ItemCache.setitemstatus(ll_NewRow, 0, primary!, notmodified!)

	lds_ItemCache.setitem(ll_NewRow, "di_shipment_id", THIS.of_GetID ( ) )
	lds_ItemCache.setitem(ll_NewRow, "accountingtype", n_cst_constants.cs_AccountingType_Both )
	
	if len(ls_Ratecode) > 0 then
	//	if this.of_IsIntermodal( ) then
			//auto move accessorial item
			lds_ItemCache.setitem(ll_NewRow, "eventflag", n_Cst_Constants.cs_ItemEventType_MoveAccessorial )
	//	end if
		lds_ItemCache.setitem(ll_NewRow, "ratecodename", ls_Ratecode)
		lds_ItemCache.setitem(ll_NewRow, "di_description", ls_ItemDescription )
	end if

	lnv_Item.of_SetSource ( lds_ItemCache )
	lnv_Item.of_SetSourceID ( ll_NewID )
	lnv_Item.of_SetShipment ( THIS )
	lnv_Item.of_SetDontrecalcflag( ab_temporaryitem )
	
	
	// we are doing this b/c of_setAmountType will kick off undesired processing unless the item knows it is the FSC
	// and of_MakeFuelSurcharge may ovewrride the default amount type... in other words, think before changing this
	IF ls_Localtype = "FUELSURCHARGE!" THEN		
		lnv_Item.of_SetEventTypeFlag ( n_Cst_Constants.cs_ItemEventType_FuelSurcharge )
	END IF
	lnv_Item.of_SetDefaultFreightCircles ( THIS )
	lnv_Item.of_SetAmountType ( li_amounttypeid )
	IF ls_Localtype = "FUELSURCHARGE!" THEN		
		lnv_Item.of_MakeFuelSurcharge ( )
	END IF
		
	//lnv_Item.of_Setdescription( ls_FreightDescription )

END IF



IF ib_autogenaccessorialitem AND lb_Continue THEN
	IF lnv_Item.of_Autorateandapply( ) = -1 THEN
		this.OF_removeitem( lnv_Item )   											 
	END IF
END IF

//IF lb_Continue THEN
//	THIS.of_RecalcSurcharges ( ) 
//END IF

//IF lb_Continue THEN  now done in the dispatch
//	
//	IF lnv_Settings.of_CreateAccNotification ( ) THEN  // we are using 'THIS' so we can report a running total
//		ls_OldDocType = THIS.of_GetDocumentType ( )    //  of Acc items
//		THIS.of_setDocumentType ( appeon_constant.cs_acc )	
//		anv_Dispatch.of_GetNotificationManager( ).of_CreatePendingNotification ( THIS )	
//		THIS.of_SetDocumentType ( ls_OldDocType )	
//	END IF
//END IF

DESTROY ( lds_ItemWork )
DESTROY	lnv_Item

IF NOT lb_Continue THEN
	ll_Return = -1
END IF

RETURN ll_Return
end function

public function integer of_deactivateequipment ();Int	li_Return = 1
Int	i
Int li_Count

n_Cst_bso	lnv_Dispatch

n_cst_beo_Equipment2		lnva_Eq[]
n_Cst_beo_Equipment2		lnv_equipment
n_Cst_Equipmentmanager	lnv_EqMan
DataStore					lds_EqCache

lnv_Dispatch = THIS.of_GetContext( )
lnv_equipment = CREATE n_cst_beo_Equipment2

IF Not isValid ( lnv_Dispatch ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	IF lnv_Dispatch.Classname( ) <> "n_cst_bso_dispatch" THEN
		li_Return = -1
	END IF	
END IF

IF li_Return = 1 THEN
	
	li_Count =	THIS.of_GetLinkedequipment( lnva_Eq	)
	lds_EqCache = lnv_Dispatch.Dynamic of_getequipmentcache()
		Int	li_SetRtn
	FOR i = 1 TO 	li_Count	
		li_SetRtn = lnva_Eq[i].of_SetStatus("D")
		li_SetRtn = lnv_Equipment.of_SetSource ( lds_eqCache )
		li_SetRtn = lnv_Equipment.of_SetSourceid( lnva_Eq[i].of_getID ( ) )
		li_SetRtn = lnv_equipment.of_SetStatus ( "D" )
		DESTROY (lnva_Eq[i])
	NEXT	
END IF

DESTROY lnv_equipment

RETURN li_return
end function

public function n_cst_beo_ShipType of_getshipmenttypebeo ();Long	ll_ShipTypeID
Boolean  lb_Proceed = TRUE

n_cst_beo_ShipType   lnv_ShipType

ll_ShipTypeID = THIS.of_GetType () 


IF IsNull ( ll_ShipTypeID ) THEN
   lb_Proceed = FALSE
END IF


IF lb_Proceed THEN
   
   lnv_ShipType = CREATE n_cst_beo_ShipType
   
   IF lnv_ShipType.of_SetUseCache ( TRUE ) = 1 THEN
      //OK
   ELSE
      lb_Proceed = FALSE
   END IF
   
END IF


IF lb_Proceed THEN
   
   lnv_ShipType.of_SetSourceId ( ll_ShipTypeID )
   
END IF

RETURN lnv_ShipType
end function

public function long of_addbobtailitem (n_cst_beo_event anv_event, n_cst_bso_dispatch anv_dispatch);string	ls_codename

long	ll_ratedatacount, &
		ll_ndx, &
		ll_ItemID
		
n_cst_bso_Dispatch 	lnv_Dispatch
n_cst_beo_Item			lnv_Item
n_cst_beo_Item			lnva_ItemList[]
n_cst_AnyArraySrv		lnv_ArraySrv

lnv_Item = CREATE n_cst_beo_Item

lnv_Dispatch = anv_Dispatch

ll_ItemID = THIS.of_AddItem ( "L" , lnv_Dispatch )
IF ll_ItemID > 0 THEN
	lnv_Item.of_SetSource ( lnv_Dispatch.of_GetItemCache ( ) )
	lnv_Item.of_SetSourceID ( ll_ItemID )
	lnv_Item.of_SetShipment ( THIS )
	lnv_Item.of_SetDescription ( "BOBTAIL" )
	lnv_Item.of_SetEventTypeFlag ( n_cst_Constants.cs_ItemEventType_Bobtail )	
	lnv_Item.of_SetPUevent( anv_Event.of_GetShipSeq() )
	lnv_Item.of_SetDelevent( anv_Event.of_GetShipSeq() +1 )	
END IF		

lnv_ArraySrv.of_Destroy ( lnva_ItemList )
DESTROY ( lnv_Item ) 

RETURN ll_ItemID

end function

public function n_cst_beo_event of_getlastconfirmedevent ();
Int    i
Int    li_Count 
Boolean    lb_GotIt

n_cst_beo_Event    lnv_Event
n_cst_beo_Event    lnva_Events[]

li_Count = THIS.of_GetEventList ( lnva_Events )

FOR i = li_Count TO 1 STEP -1
	IF NOT lb_GotIt THEN
		IF lnva_Events[i].of_Getconfirmed( ) = 'T' THEN 
			lb_GotIt = TRUE
			lnv_Event = lnva_Events[i]
		ELSE
			DESTROY ( lnva_Events[i] )            
		END IF
	ELSE
		DESTROY ( lnva_Events[i] )   
	END IF
NEXT

RETURN lnv_Event


end function

public function integer of_addyardstorageitem (n_cst_beo_event anv_anchorevent);Int	li_Return  = 1

n_cst_Events	lnv_Events

n_Cst_beo_Event	lnv_HookEvent
n_cst_beo_Event	lnv_DropEvent


IF lnv_Events.of_GetYardevents( anv_AnchorEvent, lnv_DropEvent, lnv_HookEvent ) <> 1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	Date	ld_Start
	Date	ld_End
	Int	li_NumDays
	
	ld_Start = lnv_DropEvent.of_GetDatearrived( )
	ld_End = lnv_HookEvent.of_getDatearrived( )
	
	li_NumDays = DaysAfter ( ld_Start , ld_end )
	IF li_NumDays <= 0 OR IsNull ( li_NumDays ) THEN
		li_Return = 0
	END IF
END IF

IF li_Return = 1 THEN

	n_cst_bso_Dispatch	lnv_Disp
	lnv_Disp = THIS.of_GetContext( )
	IF Not isValid ( lnv_Disp ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	Long	ll_NewItemID
	ll_NewItemID = THIS.of_AddItem( 'A' )
	IF ll_NewItemID <= 0 THEN
		li_Return = -1
	END IF
END IF

IF li_return = 1 THEN
	
	n_cst_beo_Item	lnv_Item
	
	DataStore	lds_Items
	lds_Items = THIS.of_GetItemsource( )
	IF isValid ( lds_Items ) THEN
		
		lnv_Item = CREATE n_Cst_beo_Item
		
		lnv_Item.of_SetSource ( lds_Items ) 
		lnv_Item.of_SetSourceID ( ll_NewItemID )
		If Not lnv_Item.of_HasSource ( ) THEN
			li_Return = -1
		END IF
	END IF
END IF


IF li_Return= 1 THEN 
	lnv_Item.of_Setquantity( li_NumDays )
	lnv_Item.of_SetDescription( "YARD STORAGE: " + String ( ld_Start, "mm/dd/yy" ) + " to " + String ( ld_End , "mm/dd/yy" ) )	
END IF


DESTROY lnv_Item
DESTROY lnv_DropEvent
DESTROY lnv_HookEvent
DESTROY ( anv_anchorevent )

RETURN li_Return
	
end function

on n_cst_beo_shipment.create
call super::create
end on

on n_cst_beo_shipment.destroy
call super::destroy
end on

event constructor;call super::constructor;n_cst_LicenseManager	lnv_LicenseManager

This.of_SetKeyColumn ( "ds_id" )
is_Topic = "SHIPMENT"
is_documenttype = appeon_constant.cs_shipstat					// RDT 11/18/02

//---Added by Dan 8-21-2006--------------------
/*this logic is here to address autorating while the scheduler is running.
	
		The idea is that ib_autorateforedicompany will not change anything unless
		the scheduler is running.  If the scheduler is running, then the default behavior
		used to be false, do not allow autorating.  Since at the time of construction there
		isn't a company to find out if the setting is true or not, there is only one method
		that can turn ib_autorateforedicompany = true.  It is the function 
		of_setAutoratingForEdiCompany( ai_companyId ).
		
		Scheduler NOT Running -> ib_autorateforedicompany can always be true.

*/
if lnv_LicenseManager.of_HasAutoRatingLicensed ( ) then
	//ok
	ib_autorateforedicompany = true
else
	//no license, no rating 
	ib_autorateforedicompany = false
end if

IF gnv_App.of_Runningscheduledtask( ) THEN
	ib_autorateforedicompany = FALSE
END IF
//------------------------------------------------
end event

event ue_getvalueany;call super::ue_getvalueany;//Extending Ancestor to provide attribute support for this class.

Integer	li_Return
Dec{2}	lc_Temp

li_Return = AncestorReturnValue

IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_Attribute ) )

		CASE "ID", "TMP" 
			aa_Value = This.of_GetId ( )

		CASE "SHIPMENTTYPE" 
			aa_Value = This.of_GetShipmentType ( )
			
		CASE "PREPAIDCOLLECT"
			aa_Value = This.of_getPrePaidCollect ( )
			
		CASE "INVOICENUMBER"
			aa_Value = This.of_GetInvoiceNumber ( )
			
		CASE "MANIFESTINVOICENUMBERNODASHES"
			aa_Value = This.of_GetManifestInvoiceNumberNoDashes()
			
		CASE "ORIGINID"
			aa_Value = This.of_GetOrigin ( )
			//use this id to get company info
						
		CASE "DESTINATIONID"
			aa_Value = This.of_GetDestination ( )
			//use this id to get company info
			
		CASE "BILLTOID"
			aa_Value = This.of_GetBillTo ( )
			//use this id to get company info
			
		CASE "CARRIERID"
			aa_Value = This.of_GetCarrier ( )
			
		CASE "TOTALMILES"
			IF This.of_GetTotalMiles ( lc_Temp ) = 1 THEN
				aa_value = lc_Temp
			END IF
						
		CASE "TOTALWEIGHT"
			aa_Value = This.of_GetTotalWeight ( )

		CASE "TOTALPIECES"
			aa_Value = This.of_GetTotalPieces ( )
			
		CASE "HAZMAT"
			aa_Value = This.of_GetHazmat ( )
			
		CASE "EXPEDITE"
			aa_Value = This.of_GetExpedite ( )
			
		CASE "FREIGHTCHARGES"
			aa_Value = This.of_GetFreightCharges ( )
			
		CASE "DISCOUNTAMOUNT"
			aa_Value = This.of_GetDiscountAmount ( )
			
		CASE "DISCOUNTPERCENT"
			aa_Value = This.of_GetDiscountPercent ( )
			
		CASE "ACCESSORIALCHARGES" 
			aa_Value = This.of_GetAccessorialCharges ( )
			
		CASE "GROSSCHARGES" 
			aa_Value = This.of_GetGrossCharges ( )

		CASE "NETCHARGES" 
			aa_Value = This.of_GetNetCharges ( )

		CASE "NETFREIGHTCHARGES" 
			aa_Value = This.of_GetNetFreightCharges ( )

		CASE "ADJUSTEDNETCHARGES" 
			aa_Value = This.of_GetAdjustedNetCharges ( )

		CASE "SETTLEMENTPAY" 
			aa_Value = This.of_GetSettlementPay ( )
			
		CASE "PAYABLES" 
			aa_Value = This.of_GetPayableTotal ( )

		CASE "FREIGHTPAYABLES" 
			aa_Value = This.of_GetFreightPayable ( )

		CASE "ACCESSORIALPAYABLES" 
			aa_Value = This.of_GetAccessorialPayable ( )	

		CASE "COMMISSIONS" 
			aa_Value = This.of_GetSalesCommission ( )

		CASE "BILLINGSTATUS"
			aa_Value = This.of_GetStatus ( )
			
		CASE "INVOICEDATE"
			aa_Value = This.of_GetInvoiceDate ( )
			
		CASE "SHIPDATE"
			aa_Value = This.of_GetShipDate ( )
			
		CASE "BILLNOTE"
			aa_Value = This.of_GetBillingComments ( )
			
		CASE "SHIPNOTE"
			aa_Value = This.of_GetShipmentComments ( )
			
		CASE "MODLOG"
			aa_Value = This.of_GetModLog ( )
			
		CASE "REF1TYPE"   //This is the raw column value
			aa_Value = This.of_GetRef1Type ( )

		CASE "REF1LABEL"  //This is the display value
			aa_Value = This.of_GetRef1Label ( )
			
		CASE "REF1TEXT"
			aa_Value = This.of_GetRef1Text ( )
			
		CASE "REF2TYPE"   //This is the raw column value
			aa_Value = This.of_GetRef2Type ( )
			
		CASE "REF2LABEL"  //This is the display value
			aa_Value = This.of_GetRef2Label ( )

		CASE "REF2TEXT"
			aa_Value = This.of_GetRef2Text ( )
			
		CASE "REF3TYPE"   //This is the raw column value
			aa_Value = This.of_GetRef3Type ( )
			
		CASE "REF3LABEL"  //This is the display value
			aa_Value = This.of_GetRef3Label ( )

		CASE "REF3TEXT"
			aa_Value = This.of_GetRef3Text ( )
			
		CASE "SHIPTYPEID"
			aa_Value = This.of_GetType ( )

		CASE "BLNUMBERS"
			aa_Value = This.of_GetBLNumbers ( )

		CASE "SCHEDULEDPICKUPDATE" 
			aa_Value = This.of_GetScheduledPickupDate ( )

		CASE "SCHEDULEDPICKUPTIME" 
			aa_Value = This.of_GetScheduledPickupTime ( )

		CASE "SCHEDULEDDELIVERYDATE" 
			aa_Value = This.of_GetScheduledDeliveryDate ( )

		CASE "SCHEDULEDDELIVERYTIME" 
			aa_Value = This.of_GetScheduledDeliveryTime ( )

		CASE "DATEPICKEDUP"
			aa_Value = This.of_GetDatePickedUp ( )

		CASE "TIMEPICKEDUP"
			aa_Value = This.of_GetTimePickedUp ( )

		CASE "DATEDELIVERED"
			aa_Value = This.of_GetDateDelivered ( )

		CASE "TIMEDELIVERED"
			aa_Value = This.of_GetTimeDelivered ( )

		CASE "STATUS", "DISPATCHSTATUS"
			aa_Value = This.of_GetDispatchStatus ( )

		CASE "POD" 
			aa_Value = This.of_GetPOD ( )

		CASE "EVENTCOUNT" 
			aa_Value = This.of_GetEventCount ( )

		CASE "CONFIRMEDEVENTCOUNT" 
			aa_Value = This.of_GetConfirmedEventCount ( )

		CASE "UNCONFIRMEDEVENTCOUNT" 
			aa_Value = This.of_GetUnconfirmedEventCount ( )

		CASE "ITEMCOUNT" 
			aa_Value = This.of_GetItemCount ( )

		CASE "REQUIREDEQUIPMENT" 
			aa_Value = This.of_GetRequiredEquipment ( )

		CASE "PARENTID" //(Split Billing Parent)
			aa_Value = This.of_GetParentId ( )

		CASE "CUSTOM1", "CUSTOM2", "CUSTOM3", "CUSTOM4", "CUSTOM5", "CUSTOM6", "CUSTOM7", "CUSTOM8", "CUSTOM9", "CUSTOM10"
			aa_Value = This.of_GetValue ( Trim ( as_Attribute ), TypeString! )
			
		CASE "MOVETYPE"
			aa_Value = This.of_Getmovetype ( )
			
		CASE "ORIGINPORT"
			aa_Value = This.of_Getoriginport ( )
			
		CASE "DESTINATIONPORT"
			aa_Value = This.of_Getdestinationport ( )
			
		CASE "LINE"
			aa_Value = This.of_Getline ( )
			
		CASE "VESSEL"
			aa_Value = This.of_Getvessel ( )
			
		CASE "VOYAGE", "FLIGHT"
			aa_Value = This.of_Getvoyage ( )
			
		CASE "CUTOFFDATE"
			aa_Value = This.of_Getcutoffdate ( )
			
		CASE "CUTOFFTIME"
			aa_Value = This.of_Getcutofftime ( )
			
		CASE "ARRIVALDATE" , "ARRIVEDDATE"
			aa_Value = This.of_Getarrivaldate ( )
			
		CASE "ARRIVALTIME" , "ARRIVEDTIME"
			aa_Value = This.of_Getarrivaltime ( )
			
		CASE "LASTFREEDATE"  
			aa_Value = This.of_Getlastfreedate ( )
			
		CASE "LASTFREETIME"
			aa_Value = This.of_Getlastfreetime ( )
			
		CASE "BOOKING"
			aa_Value = This.of_Getbooking ( )
			
		CASE "SEAL"
			aa_Value = This.of_Getseal ( )
			
		CASE "MASTERBL", "MAWB"
			aa_Value = This.of_Getmasterbl ( )
			
		CASE "HOUSEBL", "HAWB"
			aa_Value = This.of_Gethousebl ( )
			
		CASE "FORWARDERREF"
			aa_Value = This.of_Getforwarderref ( )
			
		CASE "AGENTREF"
			aa_Value = This.of_Getagentref ( )
			
		CASE "FORWARDERID"
			aa_Value = This.of_Getforwarder ( )
			
		CASE "AGENTID"
			aa_Value = This.of_Getagent ( )
			
		CASE "DISPATCHEDBY"
			aa_Value = This.of_GetDispatchedBy ( )
			
		CASE "AVAILABLEON"
			aa_Value = This.of_GetAvailableOn ( )
			
		CASE "AVAILABLEUNTIL"
			aa_Value = This.of_GetAvailableUntil ( )
		
		CASE "IMPORTREFERENCE"
			aa_Value = This.of_GetImportReference ( )
			
		// added for intermodal shipment
		
		CASE "PRENOTEDATE"
			aa_Value = This.of_GetPreNoteDate ( )
		CASE "PRENOTETIME"
			aa_Value = This.of_GetPrenoteTime ( )
		CASE "PRENOTEBY"
			aa_Value = This.of_GetPreNoteBy ( )
		CASE "PRENOTEUSER"
			aa_Value = This.of_GetPRENOTEUSER ( )
		CASE "ETADATE"
			aa_Value = This.of_GetETADATE ( )
		CASE "ETATIME"
			aa_Value = This.of_GetETATIME ( )
		CASE "ETABY"
			aa_Value = This.of_GetETABY ( )
		CASE "ETAUSER"
			aa_Value = This.of_GetETAUSER ( )
		CASE "ARRIVEDBY"
			aa_Value = THIS.of_GetArrivedBY ( )		
		CASE "ARRIVEDUSER"
			aa_Value = This.of_GetARRIVEDUSER ( )
		CASE "GROUNDEDDATE"
			aa_Value = This.of_GetGROUNDEDDATE ( )
		CASE "GROUNDEDTIME"
			aa_Value = This.of_GetGROUNDEDTIME ( ) 
		CASE "GROUNDEDBY"
			aa_Value = This.of_GetGROUNDEDBY ( ) 
		CASE "GROUNDEDUSER"
			aa_Value = This.of_GetGROUNDEDUSER ( )
		CASE "PICKUPNUMBER"
			aa_Value = This.of_GetPICKUPNUMBER ( )
		CASE "PICKUPNUMBERBY"
			aa_Value = This.of_GetPICKUPNUMBERBY ( )
		CASE "PICKUPNUMBERUSER"
			aa_Value = This.of_GetPICKUPNUMBERUSER ( )
		CASE "BOOKINGNUMBERBY"
			aa_Value = This.of_GetBOOKINGNUMBERBY ( )
		CASE "BOOKINGNUMBERUSER"
			aa_Value = This.of_GetBOOKINGNUMBERUSER ( )
		CASE "RELEASEDATE"
			aa_Value = This.of_GetRELEASEDATE ( )
		CASE "RELEASETIME"
			aa_Value = This.of_GetRELEASETIME ( )
		CASE "RELEASEBY"
			aa_Value = This.of_GetRELEASEBY ( )
		CASE "RELEASEUSER"
			aa_Value = This.of_GetRELEASEUSER ( )
		CASE "LFDBY"
			aa_Value = This.of_GetLFDBY ( )
		CASE "LFDUSER"
			aa_Value = This.of_GetLFDUSER ( )
		CASE "PICKUPBYDATE"
			aa_Value = This.of_GetPICKUPbyDATE ( )
		CASE "PICKUPBYTIME"
			aa_Value = This.of_GetPICKUPBYTIME ( )
		CASE "PICKUPBYBY"
			aa_Value = This.of_GetPICKUPBYBY ( )
		CASE "PICKUPBYUSER"
			aa_Value = This.of_GetPICKUPBYUSER ( )
		CASE "DELBYDATE"
			aa_Value = This.of_GetDELBYDATE ( )
		CASE "DELBYTIME"
			aa_Value = This.of_GetDELBYTIME ( )
		CASE "DELBYBY"
			aa_Value = This.of_GetDELBYBY ( )
		CASE "DELBYUSER"
			aa_Value = This.of_GetDELBYUSER ( )
		CASE "CUTOFFBY"
			aa_Value = This.of_GetCUTOFFBY ( )
		CASE "CUTOFFUSER"
			aa_Value = This.of_GetCUTOFFUSER( )
		CASE "EMPTYATCUSTOMERDATE"
			aa_Value = This.of_GetEMPTYATCUSTOMERDATE ( )
		CASE "EMPTYATCUSTOMERTIME"
			aa_Value = This.of_GetEMPTYATCUSTOMERTIME ( )
		CASE "EMPTYATCUSTOMERBY"
			aa_Value = This.of_GetEMPTYATCUSTOMERBY ( )
		CASE "EMPTYATCUSTOMERUSER"
			aa_Value = This.of_GetEMPTYATCUSTOMERUSER ( )
		CASE "LOADEDATCUSTOMERDATE"
			aa_Value = This.of_GetLOADEDATCUSTOMERDATE ( )
		CASE "LOADEDATCUSTOMERTIME"
			aa_Value = This.of_GetLOADEDATCUSTOMERTIME ( )
		CASE "LOADEDATCUSTOMERBY"
			aa_Value = This.of_GetLOADEDATCUSTOMERBY ( )
		CASE "LOADEDATCUSTOMERUSER"
			aa_Value = This.of_GetLOADEDATCUSTOMERUSER ( )
		CASE "RAILBILLNUMBER"
			aa_Value = This.of_GetRAILBILLNUMBER ( )
		CASE "RAILBILLNUMBERUSER"
			aa_Value = This.of_GetRAILBILLNUMBERUSER ( )
		CASE "RAILBILLEDDATE"
			aa_Value = This.of_GetRAILBILLEDDATE ( )
		CASE "RAILBILLEDBY"
			aa_Value = This.of_GetRAILBILLEDBY ( )
		CASE "RAILBILLEDUSER"
			aa_Value = This.of_GetRAILBILLEDUSER ( )
		CASE "MOVECODE"
			aa_Value = This.of_GetMOVECODE ( )

		CASE "PAYMENTTERMS"
			aa_Value = THIS.of_GetPaymentTerms ( ) 
		
		CASE "PERMILEMILEAGE"
			aa_value = THIS.of_GetPermilemileage( )
			
		// this should really be able to process any object request not just the one here.
		// this was done for the SAP accounting interface and I don't have time
		// to make it more flexable at this time.
		CASE "SHIPMENTTYPE.ACCOUNTINGCOMPANY" , "SHIPTYPE.ACCOUNTINGCOMPANY"
			n_cst_beo_shiptype	lnv_ShipmentType
			lnv_ShipmentType = THIS.of_GetShipmentTypebeo( )
			IF ISValid ( lnv_ShipmentType ) THEN
				aa_Value = lnv_ShipmentType.of_GetAccountingcompany( )
				DESTROY ( lnv_ShipmentType )
			END IF
			
		
		CASE ELSE
			li_Return = 0

			
	END CHOOSE

END IF

RETURN li_Return
end event

event ue_getobject;call super::ue_getobject;//Extending Ancestor to provide object support for this class.

//See ancestor script for explanation of return codes.
//RDT	 111102 Added EQUIPMENTEXPIRED
// zmc 2/13/04	Added "FREIGHT","ACCESSORIAL","NONSPECIALFREIGHT"	

Integer	li_Return
Long		ll_Count, &
			ll_Index
Any		laa_Beo[]
n_cst_beo_Item		lnva_Items[]
n_cst_beo_Event	lnva_Events[]
n_cst_beo_Company	lnv_Company
n_cst_beo_Equipment2	lnva_Equipment[]
n_Cst_beo_Event	lnv_Event

li_Return = AncestorReturnValue
aaa_Beo = laa_Beo

IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_ObjectName ) )

		CASE "ITEM"
			ll_Count = This.of_GetItemList ( lnva_Items )
			IF ll_Count >= 0 THEN
				FOR ll_Index = 1 TO ll_Count
					aaa_Beo [ ll_Index ] = lnva_Items [ ll_Index ]
				NEXT
			ELSE
				li_Return = -1
			END IF
	
		CASE "EVENT"
			ll_Count = This.of_GetEventList ( lnva_Events )
			IF ll_Count >= 0 THEN
				FOR ll_Index = 1 TO ll_Count
					aaa_Beo [ ll_Index ] = lnva_Events [ ll_Index ]
				NEXT
			ELSE
				li_Return = -1
			END IF
	
		CASE "ORIGIN"
			
			CHOOSE CASE This.of_GetOrigin ( lnv_Company, TRUE )
					
				CASE 1  //Request resolved successfully.
					aaa_Beo [ 1 ] = lnv_Company
				CASE 0  //Site is not specified (null).
					//Leave the array empty, but return 1
				CASE ELSE
					li_Return = -1
					
			END CHOOSE
			
		CASE "DESTINATION"
			CHOOSE CASE This.of_GetDestination ( lnv_Company, TRUE )
					
				CASE 1  //Request resolved successfully.
					aaa_Beo [ 1 ] = lnv_Company
				CASE 0  //Site is not specified (null).
					//Leave the array empty, but return 1
				CASE ELSE
					li_Return = -1
					
			END CHOOSE
			
		CASE "BILLTO"
			
			CHOOSE CASE This.of_GetBillToCompany ( lnv_Company, TRUE )
					
				CASE 1  //Request resolved successfully.
					aaa_Beo [ 1 ] = lnv_Company
				CASE 0  //Site is not specified (null).
					//Leave the array empty, but return 1
				CASE ELSE
					li_Return = -1
					
			END CHOOSE
	
		CASE "CARRIER"
			
			CHOOSE CASE This.of_GetCarrierCompany ( lnv_Company, TRUE )
					
				CASE 1  //Request resolved successfully.
					aaa_Beo [ 1 ] = lnv_Company
				CASE 0  //Site is not specified (null).
					//Leave the array empty, but return 1
				CASE ELSE
					li_Return = -1
					
			END CHOOSE
	
		CASE "FORWARDER"
			
			CHOOSE CASE This.of_GetForwarderCompany ( lnv_Company, TRUE )
					
				CASE 1  //Request resolved successfully.
					aaa_Beo [ 1 ] = lnv_Company
				CASE 0  //Site is not specified (null).
					//Leave the array empty, but return 1
				CASE ELSE
					li_Return = -1
					
			END CHOOSE
	
		CASE "AGENT"
			
			CHOOSE CASE This.of_GetAgentCompany ( lnv_Company, TRUE )
					
				CASE 1  //Request resolved successfully.
					aaa_Beo [ 1 ] = lnv_Company
				CASE 0  //Site is not specified (null).
					//Leave the array empty, but return 1
				CASE ELSE
					li_Return = -1
					
			END CHOOSE
			
			
		CASE "NEXTEVENT"
			
			THIS.of_GEtNextEventList ( lnva_Events )
			aaa_beo[] = lnva_Events
			
		CASE "EQUIPMENT" , "EQUIP"
			
			THIS.of_GEtEquipmentList ( lnva_Equipment )
			aaa_beo[] = lnva_Equipment
	
		CASE "CONTAINER" , "CNTN"
			
			THIS.of_GEtcontainerList ( lnva_Equipment )
			aaa_beo[] = lnva_Equipment
		
		CASE "CHASSIS" , "CHAS"
			
			THIS.of_GEtChassisList ( lnva_Equipment )
			aaa_beo[] = lnva_Equipment
	
	
		CASE "TRAILER" 
			
			THIS.of_GEtTrailerList ( lnva_Equipment )
			aaa_beo[] = lnva_Equipment
	
		CASE "LINKEDEQUIPMENT" 										
			THIS.of_GetLinkedEquipment ( lnva_Equipment )		
			aaa_beo[] = lnva_Equipment
			
		CASE "LINKEDEQUIPMENTNOCOINFO" 										
			THIS.of_getlinkedequipmentnocoinfo ( lnva_Equipment )		
			aaa_beo[] = lnva_Equipment		
	
		CASE "RELOADEQUIPMENT" 										
			THIS.of_GetReloadEquipment ( lnva_Equipment )
			aaa_beo[] = lnva_Equipment									
	
		CASE "NOTIFYITEM"
			THIS.of_GetNotifyItems ( lnva_Items )
			aaa_beo[] = lnva_Items		
		
		CASE "FREIGHTITEM"
			ll_Count = This.of_GetItemList( lnva_Items, n_cst_constants.cs_ItemType_Freight)
			IF ll_Count > 0 THEN
				aaa_beo[] = lnva_Items		
			END IF	
			
		CASE "ACCESSORIALITEM"
			ll_Count = This.of_GetItemList( lnva_Items, n_cst_constants.cs_ItemType_Accessorial)
			IF ll_Count > 0 THEN
				aaa_beo[] = lnva_Items		
			END IF	
			
		CASE "NONSPECIALFREIGHT"
			ll_Count = This.of_GetNonSpecialFreight(lnva_Items[])
			IF ll_Count > 0 THEN			
				aaa_beo[] = lnva_Items
			END IF
		
		CASE "NONORIGDESTEVENTS"// 4.0	
			
			ll_Count = This.of_Getnonorigindestevents( lnva_Events)
			IF ll_Count > 0 THEN			
				aaa_beo[] = lnva_Events
			END IF
		
		CASE "ORIGINEVENT"// 4.0	
			
			ll_Count = This.of_GetOriginEvent ( lnv_Event )
			IF ll_Count = 1 THEN			
				aaa_beo[1] = lnv_Event
			END IF
		
		CASE "DESTINATIONEVENT"// 4.0	
			
			ll_Count = This.of_GetDestinationEvent ( lnv_Event )
			IF ll_Count = 1 THEN			
				aaa_beo[1] = lnv_Event
			END IF
			
		CASE UPPER ("NonOrigDestEventsHideCrossDocks" ) , "NONORIGDESTEVENTHIDECROSSDOCKS"// 4.0
			ll_Count = This.of_Getnonorigindestevents( lnva_Events , TRUE)
			IF ll_Count > 0 THEN			
				aaa_beo[] = lnva_Events
			END IF
			
			
			
		CASE Upper ("EventHideCrossDock"), "EVENTSHIDECROSSDOCK"
			ll_Count = This.of_GetEventList ( lnva_Events , TRUE )
			IF ll_Count > 0 THEN			
				aaa_beo[] = lnva_Events
			END IF
	
		CASE "SHIPTYPE" , "SHIPMENTTYPE"
			aaa_beo[1] = THIS.of_GetShipmentTypebeo( )

		CASE "LASTCONFIRMEDEVENT"	
			lnv_Event = THIS.of_GetLastconfirmedevent( )
			IF IsValid ( lnv_Event ) THEN
				aaa_beo[1] = lnv_Event
			END IF
		
		CASE ELSE
			li_Return = 0
				
	END CHOOSE

END IF

RETURN li_Return
end event

event ue_getstringformat;call super::ue_getstringformat;// Extending Ancestor Script.

// Returns: -1 = Error
//           0 = Requested attribute format not found
//           1 = Success

Int li_Return

li_Return = AncestorReturnValue 

IF li_Return = 0 THEN
	
	li_Return = 1 //Changed back later if no match is found.

	CHOOSE CASE  UPPER( Trim ( as_attribute ) ) 
			
		CASE  "FREIGHTCHARGES", "DISCOUNTAMOUNT", "ACCESSORIALCHARGES", "NETCHARGES", &
			"NETFREIGHTCHARGES", "ADJUSTEDNETCHARGES", "GROSSCHARGES"

			as_Format = "0.00##"
			
		CASE "INVOICEDATE", "SHIPDATE", "DATEDELIVERED", "DATEPICKEDUP", &
			"SCHEDULEDPICKUPDATE", "SCHEDULEDDELIVERYDATE"

			as_Format = "m/d/yy"

		CASE "SCHEDULEDPICKUPTIME", "SCHEDULEDDELIVERYTIME", "TIMEPICKEDUP", "TIMEDELIVERED"
			as_Format = "h:mm am/pm"
			
		CASE "DISCOUNTPERCENT"
			as_Format =  "0.0##%;-0.0##%;0.0%;FIXED"
			
		CASE "TOTALWEIGHT", "TOTALPIECES"
			as_Format = "0"
			
			
		CASE ELSE
			li_Return = 0
			
	END CHOOSE

END IF 

RETURN li_Return
end event

event ue_formatvalue;call super::ue_formatvalue;// Extending Ancestor Script.

// Returns: -1 = Error
//           0 = Requested attribute format not found
//           1 = Success

Int li_Return

li_Return = AncestorReturnValue 

IF li_Return = 0 THEN
	
	li_Return = 1 //Changed back later if no match is found.

	CHOOSE CASE  UPPER( Trim ( as_attribute ) ) 
			
		CASE "PREPAIDCOLLECT"

			CHOOSE CASE UPPER ( Trim ( String ( aa_value ) ) )
				//String ( ) is necessary to prevent crash on null value for any variable.
					
				CASE "Z"
					as_FormattedValue = "UNCLASSIFIED"
					
				CASE "P"
					as_FormattedValue = "PREPAID"
					
				CASE "C"
					as_FormattedValue = "COLLECT"
					
				CASE "T"
					as_FormattedValue = "3RD PARTY"
					
				CASE ELSE //unexpected value, including null
					as_FormattedValue = ""
					
			END CHOOSE
			
		CASE "HAZMAT"
			
			CHOOSE CASE UPPER ( Trim ( String ( aa_value ) ) )
				//String ( ) is necessary to prevent crash on null value for any variable.
					
				CASE "T"
					as_FormattedValue = "HAZMAT"
					
				CASE "F"
					as_FormattedValue = ""
					
				CASE ELSE
					as_FormattedValue = ""
			END CHOOSE
			
		CASE "EXPEDITE"
			
			CHOOSE CASE UPPER ( Trim ( String ( aa_value ) ) )
				//String ( ) is necessary to prevent crash on null value for any variable.
					
				CASE "T"
					as_FormattedValue = "EXPEDITE"
					
				CASE "F"
					as_FormattedValue = ""
					
				CASE ELSE //unexpected value, including null
					as_FormattedValue = ""
			END CHOOSE
					
					
		CASE "BILLINGSTATUS"
			
			as_FormattedValue = This.of_GetStatusDisplayValue ( UPPER ( Trim ( String ( aa_value ) ) ) )

			//If we couldn't determine a display value, pass out the empty string.
			IF IsNull ( as_FormattedValue ) THEN
				as_FormattedValue = ""
			END IF
				
//		CASE "SHIPTYPE" 
			
		CASE ELSE
			li_Return = 0
			
	END CHOOSE
END IF 

RETURN li_Return
end event

event ue_getvalueanywithparmobject;call super::ue_getvalueanywithparmobject;s_Parm	lstr_Parm
String	ls_Work

Integer	li_Return
li_Return = AncestorReturnValue

IF li_Return = 0 THEN

	CHOOSE CASE Upper ( as_Attribute )

	CASE "ACCESSORIALCHARGES"

		IF anv_Msg.of_Get_Parm ( "DESCR", lstr_Parm ) > 0 THEN

			ls_Work = lstr_Parm.ia_Value
			aa_Value = This.of_GetAccessorialChargesByDescription ( ls_Work )
			li_Return = 1

		END IF

	END CHOOSE

END IF

RETURN li_Return
end event

event destructor;DESTROY ( ids_equipment  )

end event

event ue_setvalueany;call super::ue_setvalueany;Int	li_Return 
String	ls_Temp
Date		ld_Temp

IF Len ( as_attribute ) = 0 AND  Len ( String ( aa_value ) ) = 0 THEN
	RETURN 1 // so we can check that the event exists w. a 'triggerevent' call
END IF

CHOOSE CASE Upper ( as_attribute )
		
/*------------------			Date */			
			
		CASE "INVOICEDATE"
			li_Return = THIS.of_SetInvoiceDate ( Date ( aa_value ) ) 
			
		CASE "SHIPDATE"
			li_Return = THIS.of_SetShipdate ( Date ( aa_value ) ) 
			
		CASE "SCHEDULEDPICKUPDATE" 		
			li_Return = THIS.of_SetScheduledPickupDate ( Date (aa_value)  ) 						
			
		CASE "SCHEDULEDDELIVERYDATE" 
			li_Return = THIS.of_SetScheduledDeliveryDate ( Date ( aa_value ) ) 												
			
		CASE "DATEPICKEDUP"
			li_Return = THIS.of_SetDatePickedUp ( Date ( aa_value ) ) 						

		CASE "DATEDELIVERED"
			li_Return = THIS.of_SetDateDelivered ( Date ( aa_value ) )			
			
		CASE "CUTOFFDATE"
			li_Return = THIS.of_SetCutOffDate (Date(aa_value))
			
		CASE "ARRIVALDATE" , "ARRIVEDDATE"
			li_Return = THIS.of_Setarrivaldate (Date(aa_value)) 																								
			
		CASE "LASTFREEDATE"  
			li_Return = THIS.of_Setlastfreedate (Date(aa_value)) 																											

		CASE "AVAILABLEON"
			li_Return = THIS.of_SetAvailableOn ( Date ( aa_value ) ) 									
		
		CASE "AVAILABLEUNTIL"
			li_Return = THIS.of_SetAvailableUntil ( Date ( aa_value ) ) 												

/*------------------			Decimal */

		CASE "FREIGHTCHARGES"
			li_Return = This.of_SetFreightCharges(Dec(aa_value ))				
			
		CASE "DISCOUNTAMOUNT"
			li_Return = This.of_setDiscountAmount(Dec(aa_value ))	
			
		CASE "DISCOUNTPERCENT"
			li_Return = This.of_SetDiscountPercent(Dec(aa_value ))				
			
		CASE "ACCESSORIALCHARGES"
			li_Return = This.of_SetAccessorialAmount(Dec(aa_value ))
			
		CASE "NETCHARGES"
			li_Return = This.of_SetNetCharge(Dec(aa_value))

		CASE "PAYABLES" 
			li_Return = THIS.of_SetPayableTotal ( Dec ( aa_value ) ) 								

		CASE "FREIGHTPAYABLES" 
			li_Return = THIS.of_SetFreightPayable ( Dec ( aa_value ) ) 								

		CASE "ACCESSORIALPAYABLES" 
			li_Return = THIS.of_SetAccessorialPayable ( Dec ( aa_value ) ) 											

		CASE "COMMISSIONS" 
			li_Return = THIS.of_SetSalesCommission ( Dec ( aa_value ) ) 

/*------------------			String */			

		CASE "STATUS", "DISPATCHSTATUS"  // it is assumed that the change has been validated prior to making this call
			li_Return = This.of_setStatus ( String ( aa_value ) )	

		CASE "PREPAIDCOLLECT"
			li_Return = This.of_setPrePaidCollect ( String ( aa_value ) )	
			
		CASE "INVOICENUMBER"
			li_Return = This.of_SetInvoiceNumber ( String ( aa_value ) )	
			
		CASE "HAZMAT"
			li_Return = This.of_SetHazmat(String(aa_value ))	
			
		CASE "EXPEDITE"
			li_Return = This.of_SetExpedite(String(aa_value ))	

		CASE "BILLINGSTATUS"
			li_Return = THIS.of_SetStatus ( String ( aa_value ) ) 			

		CASE "BILLNOTE"
			li_Return = THIS.of_SetBillingComments ( String ( aa_value ) ) 			
			
		CASE "SHIPNOTE"  
			li_Return = THIS.of_SetShipmentComments ( String ( aa_value ) ) 			
			
		CASE "MODLOG"
			li_Return = THIS.of_SetModLog ( String ( aa_value ) ) 			
			
		CASE "REF1TEXT"
			li_Return = THIS.of_SetRef1Text ( String ( aa_value ) ) 
			
		CASE "REF2TEXT"
			li_Return = THIS.of_SetRef2Text ( String ( aa_value ) ) 
			
		CASE "REF3TEXT"
			li_Return = THIS.of_SetRef3Text ( String ( aa_value ) ) 
			
		CASE "POD" 
			li_Return = THIS.of_SetPOD ( String ( aa_value ) )						

		CASE "REQUIREDEQUIPMENT"
			li_Return = THIS.of_SetRequiredEquipment (String(aa_value))

		CASE "CUSTOM1"
			li_Return = THIS.of_SetValue ("CUSTOM1",String(aa_value))
			
		CASE "CUSTOM2"
			li_Return = THIS.of_SetValue ("CUSTOM2",String(aa_value))
			
		CASE "CUSTOM3"
			li_Return = THIS.of_SetValue ("CUSTOM3",String(aa_value))			
			
		CASE "CUSTOM4"
			li_Return = THIS.of_SetValue ("CUSTOM4",String(aa_value))
			
		CASE "CUSTOM5"
			li_Return = THIS.of_SetValue ("CUSTOM5",String(aa_value))
			
		CASE "CUSTOM6"
			li_Return = THIS.of_SetValue ("CUSTOM6",String(aa_value))
			
		CASE "CUSTOM7"
			li_Return = THIS.of_SetValue ("CUSTOM7",String(aa_value))			
			
		CASE "CUSTOM8"
			li_Return = THIS.of_SetValue ("CUSTOM8",String(aa_value))
			
		CASE "CUSTOM9"
			li_Return = THIS.of_SetValue ("CUSTOM9",String(aa_value))
			
		CASE "CUSTOM10"
			li_Return = THIS.of_SetValue ("CUSTOM10",String(aa_value))
			
		CASE "MOVETYPE"
			li_Return = THIS.of_Setmovetype (String(aa_value))
			
		CASE "ORIGINPORT"
			li_Return = THIS.of_SetOriginPort (String(aa_value))
			
		CASE "DESTINATIONPORT"
			li_Return = THIS.of_SetDestinationPort (String(aa_value))
			
		CASE "LINE"
			li_Return = THIS.of_Setline (String(aa_value))
			
		CASE "VESSEL"
			li_Return = THIS.of_SetVessel (String(aa_value))
			
		CASE "VOYAGE", "FLIGHT"
			li_Return = THIS.of_SetVoyage (String(aa_value))			
			
		CASE "BOOKING"
			li_Return = THIS.of_SetBookingNumber ( String ( aa_value ) ) 
			
		CASE "SEAL"
			li_Return = THIS.of_SetSeal ( String ( aa_value ) ) 

		CASE "MASTERBL", "MAWB"
			li_Return = THIS.of_Setmasterbl ( String ( aa_value ) ) 			
			
		CASE "HOUSEBL", "HAWB"
			li_Return = THIS.of_Sethousebl ( String ( aa_value ) ) 			
			
		CASE "FORWARDERREF"
			li_Return = THIS.of_Setforwarderref ( String ( aa_value ) ) 			
			
		CASE "AGENTREF"
			li_Return = THIS.of_Setagentref ( String ( aa_value ) ) 			
			
		CASE "DISPATCHEDBY"
			li_Return = THIS.of_SetDispatchedBy ( String ( aa_value ) ) 						
			
		CASE "IMPORTREFERENCE"
			li_Return = THIS.of_SetImportReference ( String ( aa_value ) ) 
			
		CASE "BILLTOBYREF"
			li_Return = THIS.of_SetBillTobyref( String ( aa_value ) )
			
/*------------------			Integer */

		
		CASE "TOTALMILES"
			li_Return = This.of_SetTotalMiles ( Integer ( aa_value ) )	
			
		CASE "REF1TYPE"   //This is the raw column value
			li_Return = THIS.of_SetRef1Type ( Integer ( aa_value ) ) 

		CASE "REF2TYPE"   //This is the raw column value
			li_Return = THIS.of_SetRef2Type ( Integer ( aa_value ) ) 
			
		CASE "REF3TYPE"   //This is the raw column value
			li_Return = THIS.of_SetRef3Type ( Integer ( aa_value ) ) 

/*------------------			Long */			

		CASE "SHIPMENTTYPE"  
			li_Return = This.of_setType ( Long ( aa_value ) )				

		CASE "DESTINATIONID" , "DESTINATIONBYALIAS"
			li_Return = This.of_SetFinalDestination ( Long ( aa_value ) )	
			//use this id to get company info
		
		CASE "ORIGINID" , "ORIGINBYALIAS"
			li_Return = This.of_SetOrigin ( Long ( aa_value ) )	
			//use this id to get company info
			
		
		CASE "BILLTOID" , "BILLTOBYALIAS" // alias used by Edi
			
			li_Return = This.of_SetBillToID ( Long ( aa_value ) )	
			// I Changed the call from This.of_SetBillTo to THIS.of_SetBilltoID for issue 2544.
			// this will impact quite a bit since the new call will kick off all of the intened 
			// change in billto processing. 
			
		CASE "CARRIERID", "CARRIERBYALIAS"
			li_Return = This.of_SetCarrier ( Long ( aa_value ) )	
			
		CASE "TOTALWEIGHT"
			li_Return = This.of_SetTotalWeight ( Long ( aa_value ) )	

		CASE "SHIPTYPEID"
			li_Return = THIS.of_SetType ( Long ( aa_value ) ) 			
			
		CASE "PARENTID" //(Split Billing Parent)
			li_Return = THIS.of_SetParentId (Long(aa_value))

		CASE "FORWARDERID", "FORWARDERBYALIAS"
			li_Return = THIS.of_Setforwarder ( Long ( aa_value ) ) 			

		CASE "AGENTID" , "AGENTBYALIAS"
			li_Return = THIS.of_Setagent ( Long ( aa_value ) ) 			

/*------------------			Time */						

		CASE "SCHEDULEDPICKUPTIME" 
			li_Return = THIS.of_SetScheduledPickupTime ( Time ( aa_value ) ) 									

		CASE "SCHEDULEDDELIVERYTIME" 
			li_Return = THIS.of_SetScheduledDeliveryTime ( Time ( aa_value ) ) 															

		CASE "TIMEPICKEDUP"
			li_Return = THIS.of_SetTimePickedUp ( Time ( aa_value ) )
			
		CASE "TIMEDELIVERED"
			li_Return = THIS.of_SetTimeDelivered ( Time ( aa_value ) )			

		CASE "CUTOFFTIME"
			li_Return = THIS.of_SetCutOffTime (Time(aa_value)) 																					

		CASE "ARRIVALTIME" , "ARRIVEDTIME"
			li_Return = THIS.of_Setarrivaltime (Time(aa_value)) 																								

		CASE "LASTFREETIME"
			li_Return = THIS.of_Setlastfreetime (Time(aa_value)) 																											
			
			
		// added for intermodal shipment

/*------------------			String */						

		CASE "PRENOTEBY"
			li_Return = THIS.of_SetPreNoteBy ( String ( aa_value ) ) 																		

		CASE "PRENOTEUSER"
			li_Return = THIS.of_SetPRENOTEUSER ( String ( aa_value ) ) 																		
			
		CASE "ETABY"
			li_Return = THIS.of_SetETABY ( String ( aa_value ) ) 																		
			
		CASE "ETAUSER"
			li_Return = THIS.of_SetETAuser ( String ( aa_value ) ) 																					
			
		CASE "ARRIVEDBY"
			li_Return = THIS.of_SetArrivedBy ( String ( aa_value ) ) 																								
			
		CASE "ARRIVEDUSER"
			li_Return = THIS.of_SetArrivedUser ( String ( aa_value ) ) 																											
			
		CASE "GROUNDEDBY"
			li_Return = THIS.of_SetGROUNDEDBY ( String ( aa_value ) ) 																														
			
		CASE "GROUNDEDUSER"
			li_Return = THIS.of_SetGROUNDEDUSER ( String ( aa_value ) ) 																																	
			
		CASE "PICKUPNUMBER"
			li_Return = THIS.of_SetPICKUPNUMBER ( String ( aa_value ) ) 																																	
			
		CASE "PICKUPNUMBERBY"
			li_Return = THIS.of_SetPICKUPNUMBERBY ( String ( aa_value ) ) 																																	
			
		CASE "PICKUPNUMBERUSER"
			li_Return = THIS.of_SetPICKUPNUMBERUSER ( String ( aa_value ) ) 																																				
			
		CASE "BOOKINGNUMBERBY"
			li_Return = THIS.of_SetBOOKINGNUMBERBY ( String ( aa_value ) ) 																																							
			
		CASE "BOOKINGNUMBERUSER"
			li_Return = THIS.of_SetBOOKINGNUMBERUSER ( String ( aa_value ) ) 

		CASE "RELEASEBY"
			li_Return = THIS.of_SetRELEASEBY ( String ( aa_value ) ) 																																													
			
		CASE "RELEASEUSER"
			li_Return = THIS.of_SetRELEASEUSER ( String ( aa_value ) ) 																																																
			
		CASE "LFDBY"
			li_Return = THIS.of_SetLFDBY ( String ( aa_value ) ) 																																																			
			
		CASE "LFDUSER"
			li_Return = THIS.of_SetLFDUser ( String ( aa_value ) ) 																																																						

		CASE "PICKUPBYBY"
			li_Return = THIS.of_SetPICKUPBYBY ( String ( aa_value ) ) 																																																															
			
		CASE "PICKUPBYUSER"
			li_Return = THIS.of_SetPICKUPBYUSER ( String ( aa_value ) ) 																																																																		

		CASE "DELBYBY"
			li_Return = THIS.of_SetDELBYBY ( String ( aa_value ) ) 																																																																											
			
	   CASE "DELBYUSER"
 			li_Return = THIS.of_SetDELBYUSER ( String ( aa_value ) ) 																																																																														
			
		CASE "CUTOFFBY"
 			li_Return = THIS.of_SetCUTOFFBY ( String ( aa_value ) ) 																																																																																	
			
		CASE "CUTOFFUSER"
 			li_Return = THIS.of_SetCUTOFFUSER ( String ( aa_value ) ) 																																																																																				

		CASE "EMPTYATCUSTOMERBY"
			li_Return = THIS.of_setemptyatcustomerby ( String ( aa_value ) ) 																																																																																										
			
		CASE "EMPTYATCUSTOMERUSER"
			li_Return = THIS.of_setEMPTYATCUSTOMERUSER ( String ( aa_value ) ) 																																																																																													

		CASE "LOADEDATCUSTOMERBY"
			li_Return = THIS.of_setLOADEDATCUSTOMERBY( String ( aa_value ) ) 																																																																																																						

		CASE "LOADEDATCUSTOMERUSER"
			li_Return = THIS.of_setLOADEDATCUSTOMERUSER( String ( aa_value ) ) 																																																																																																									
			
		CASE "RAILBILLNUMBER"
			li_Return = THIS.of_setRAILBILLNUMBER( String ( aa_value ) ) 																																																																																																												
			
		CASE "RAILBILLNUMBERUSER"
			li_Return = THIS.of_setRAILBILLNUMBERUSER ( String ( aa_value ) ) 																																																																																																															

		CASE "RAILBILLEDBY"
			li_Return = THIS.of_setRAILBILLEDBY ( String ( aa_value ) ) 																																																																																																																					
			
		CASE "RAILBILLEDUSER"
			li_Return = THIS.of_setRAILBILLEDUSER ( String ( aa_value ) ) 																																																																																																																					
			
		CASE "MOVECODE"
			li_Return = This.of_SetMoveCode ( String ( aa_value ) ) 
			
		CASE "PAYMENTTERMS"
			li_Return = THIS.of_SetPaymentTerms ( String ( aa_value ) ) 
			
/*------------------			Date */									

		CASE "PRENOTEDATE"
			li_Return = THIS.of_SetPreNoteDate  ( Date ( aa_value ) ) 															
			
		CASE "ETADATE"
			li_Return = THIS.of_SetETADate  ( Date ( aa_value ) ) 																		
			
		CASE "GROUNDEDDATE"
			li_Return = THIS.of_SetGROUNDEDDATE ( Date ( aa_value ) ) 																														
			
		CASE "RELEASEDATE"
			li_Return = THIS.of_SetRELEASEDATE ( Date ( aa_value ) ) 																																													

		CASE "PICKUPBYDATE"
			li_Return = THIS.of_SetPICKUPbyDATE ( Date ( aa_value ) ) 																																																									

		CASE "DELBYDATE"
			li_Return = THIS.of_SetDELBYDATE ( Date ( aa_value ) ) 																																																																					

		CASE "EMPTYATCUSTOMERDATE"
			li_Return = THIS.of_setemptyatcustomerdate ( Date ( aa_value ) ) 																																																																																				

		CASE "LOADEDATCUSTOMERDATE"
			li_Return = THIS.of_setLOADEDATCUSTOMERDATE( Date ( aa_value ) ) 																																																																																																

		CASE "RAILBILLEDDATE"
			li_Return = THIS.of_setRAILBILLEDDATE ( Date ( aa_value ) ) 																																																																																																																		
			
/*------------------			Time */												

		CASE "PRENOTETIME"
			li_Return = THIS.of_SetPrenoteTime  ( Time ( aa_value ) ) 																		

		CASE "ETATIME"
			li_Return = THIS.of_SetETATime  ( Time ( aa_value ) ) 																					

		CASE "GROUNDEDTIME"
			li_Return = THIS.of_SetGROUNDEDTIME ( Time ( aa_value ) ) 																																	
			
		CASE "RELEASETIME"
			li_Return = THIS.of_SetRELEASETIME ( Time ( aa_value ) ) 																																																
			
		CASE "PICKUPBYTIME"
			li_Return = THIS.of_SetPICKUPBYTIME ( Time ( aa_value ) ) 																																																												
			
		CASE "DELBYTIME"
			li_Return = THIS.of_SetDELBYTIME ( Time ( aa_value ) ) 																																																																								

		CASE "EMPTYATCUSTOMERTIME"
			li_Return = THIS.of_setemptyatcustomerTime ( Time ( aa_value ) ) 																																																																																							
			
		CASE "LOADEDATCUSTOMERTIME"
			li_Return = THIS.of_setLOADEDATCUSTOMERTIME( Time ( aa_value ) ) 																																																																																																			
			

		CASE "BILLTODOCUMENTREQUEST" , "BILLTODOCREQUEST"
			li_Return = THIS.of_AddBilltodocumentrequest(String ( aa_Value ) )
			

// 	Will not be called as per RZ.		
//		CASE "ADJUSTEDNETCHARGES" 
//			aa_Value = This.of_GetAdjustedNetCharges ( )

// 	Will not be called as per RZ.		
//		CASE "SETTLEMENTPAY" 
//			aa_Value = This.of_GetSettlementPay ( )
			
// 	Will not be called as per RZ.		
//		CASE "REF1LABEL"  //This is the display value
//			li_Return = THIS.of_SetRef1Label( String ( aa_value ) ) 																																																																																																			

// 	Will not be called as per RZ.					
//		CASE "REF2LABEL"  //This is the display value
//			li_Return = THIS.of_SetRef2Label( String ( aa_value ) ) 																																																																																																			

// 	Will not be called as per RZ.					
//		CASE "REF3LABEL"  //This is the display value
//			li_Return = THIS.of_SetRef3Label( String ( aa_value ) ) 																																																																																																			

// 	Will not be called as per RZ.		
//		CASE "BLNUMBERS"
//		li_Return = This.of_SetBLNumbers ( String ( aa_value ) )	

/*
// Will not be called as per RZ
//		CASE "EVENTCOUNT" 
//			aa_Value = This.of_GetEventCount ( )

//		CASE "CONFIRMEDEVENTCOUNT" 
//			aa_Value = This.of_GetConfirmedEventCount ( )

//		CASE "UNCONFIRMEDEVENTCOUNT" 
//			li_Return = THIS.of_UnconfirmEvent () 			

//		CASE "ITEMCOUNT" 
//			aa_Value = This.of_GetItemCount ( )

*/

END CHOOSE

RETURN li_Return


end event

