$PBExportHeader$u_dw_intermodalshipinfo.sru
forward
global type u_dw_intermodalshipinfo from u_dw_shipinfo
end type
end forward

global type u_dw_intermodalshipinfo from u_dw_shipinfo
integer width = 4261
integer height = 1168
string dataobject = "d_intermodalshipinfo"
event ue_setcontextimport ( )
event ue_setcontextexport ( )
event ue_setcontextoneway ( )
event ue_pickupnumberchanged ( )
event type integer ue_pickupbydatechanged ( )
event type integer ue_pickupbytimechanged ( )
event type integer ue_deliverbydatechanged ( )
event type integer ue_deliverbytimechanged ( )
event type integer ue_recordchange ( string as_column,  long al_row )
event ue_setcontextnone ( )
event ue_keydown pbm_dwnkey
event type integer ue_bookingnumberchanged ( string as_value )
event type integer ue_arrivedbychanged ( string as_data )
event type integer ue_groundedbychanged ( string as_data )
event type integer ue_releasebychanged ( string as_data )
event type integer ue_delbychanged ( string as_data )
event type integer ue_emptyatcustomerbychanged ( string as_data )
event type integer ue_pickupbybychanged ( string as_data )
event type integer ue_prenotebychanged ( string as_data )
event type integer ue_lfdbychanged ( string as_data )
event type integer ue_etabychanged ( string as_data )
event type integer ue_cutoffbychanged ( string as_data )
event type integer ue_loadedatcustomerbychanged ( string as_data )
event type integer ue_railbilledbychanged ( string as_data )
event type integer ue_bookingnumberbychanged ( string as_data )
event type integer ue_pickupnumberbychanged ( string as_data )
event type integer ue_releasedatechanged ( date ad_value )
event type integer ue_releasetimechanged ( time at_value )
event type integer ue_railbillnumberchanged ( string data )
event ue_emptyatcustomerdatechanged ( string as_data )
end type
global u_dw_intermodalshipinfo u_dw_intermodalshipinfo

type variables
Boolean ib_RestrictionsSet
end variables

forward prototypes
public function integer of_setdisplayrestrictions ()
public function integer of_setsmallviewtaborder ()
public function integer of_determineinitialcontext ()
public function integer of_setcontext (string as_context)
private function integer of_downarrow ()
private function integer of_leftarrow ()
private function integer of_rightarrow ()
private function integer of_uparrow ()
private function string of_getcontext ()
public subroutine of_openadminwindow ()
end prototypes

event ue_setcontextimport;IF THIS.DataObject <> "d_intermodalshipinfo" THEN
	RETURN 
END IF

THIS.object.st_Prenote.Visible = TRUE
THIS.object.PrenoteDate.Visible = TRUE
THIS.object.PrenoteTime.Visible = TRUE
THIS.object.PrenoteBY.Visible = TRUE

THIS.object.st_ETA.Visible = TRUE
THIS.object.ETADate.Visible = TRUE
THIS.object.ETATime.Visible = TRUE
THIS.object.ETABY.Visible = TRUE

THIS.object.st_arrived.Visible = TRUE
THIS.object.arrivaldate.Visible = TRUE
THIS.object.arrivaltime.Visible = TRUE
THIS.object.arrivedby.Visible = TRUE

THIS.object.st_grounded.Visible = TRUE
THIS.object.groundedDate.Visible = TRUE
THIS.object.groundedTime.Visible = TRUE
THIS.object.groundedBY.Visible = TRUE

THIS.object.st_release.Text = "Release"
THIS.object.st_release.Visible = TRUE
THIS.object.releaseDate.Visible = TRUE
THIS.object.releaseTime.Visible = TRUE
THIS.object.releaseBY.Visible = TRUE

THIS.object.st_LFD.Visible = TRUE
THIS.object.LastFreeDate.Visible = TRUE
THIS.object.LastfreeTime.Visible = TRUE
THIS.object.LFDBY.Visible = TRUE

THIS.object.st_booking.Visible = 0
THIS.object.booking.Visible = 0
THIS.object.bookingnumberby.Visible = 0


THIS.object.st_DelBy.Text = "Del By"
THIS.object.st_DelBy.Visible = TRUE
THIS.object.DelByDate.Visible = TRUE
THIS.object.DelByTime.Visible = TRUE
THIS.object.DelByBY.Visible = TRUE

THIS.object.st_Empty.Visible = TRUE
THIS.object.EmptyAtCustomerDate.Visible = TRUE
THIS.object.EmptyAtCustomerTime.Visible = TRUE
THIS.object.EmptyAtCustomerBY.Visible = TRUE
//
//
THIS.object.st_cutoff.Visible = 0
THIS.object.cutoffDate.Visible = 0
THIS.object.cutoffTime.Visible = 0
THIS.object.cutoffBY.Visible = 0

THIS.object.st_PuBy.Visible = 0
THIS.object.pickupbyDate.Visible = 0
THIS.object.pickupbyTime.Visible = 0
THIS.object.pickupBYby.Visible = 0

THIS.object.st_Loaded.Visible = 0
THIS.object.LoadedAtCustomerDate.Visible = 0
THIS.object.LoadedAtCustomerTime.Visible = 0
THIS.object.LoadedAtCustomerBY.Visible = 0


THIS.object.st_RailBillNumber.Visible = 0
THIS.object.RailBillNumber.Visible = 0


THIS.object.st_RailBilled.Visible = 0
THIS.object.RailBilledDate.Visible = 0
THIS.object.RailBilledby.Visible = 0


THIS.object.st_pickUp.Visible = 1
THIS.object.PickupnumberBy.Visible = 1
THIS.object.Pickupnumber.Visible = 1


THIS.object.st_DelBy.y = 640
THIS.object.DelByDate.y = 640
THIS.object.DelByTime.y = 640
THIS.object.DelByBY.y = 640


THIS.object.st_release.y = 496
THIS.object.releaseDate.y = 496
THIS.object.releaseTime.y = 496
THIS.object.releaseBY.y = 496




end event

event ue_setcontextexport;IF THIS.DataObject <> "d_intermodalshipinfo" THEN
	RETURN 
END IF

THIS.object.st_Prenote.Visible = TRUE
THIS.object.PrenoteDate.Visible = TRUE
THIS.object.PrenoteTime.Visible = TRUE
THIS.object.PrenoteBY.Visible = TRUE

THIS.object.st_ETA.Visible = 0
THIS.object.ETADate.Visible = 0
THIS.object.ETATime.Visible = 0
THIS.object.ETABY.Visible = 0

THIS.object.st_arrived.Visible = 0
THIS.object.arrivaldate.Visible = 0
THIS.object.arrivaltime.Visible = 0
THIS.object.arrivedby.Visible = 0

THIS.object.st_grounded.Visible = 0
THIS.object.groundedDate.Visible = 0
THIS.object.groundedTime.Visible = 0
THIS.object.groundedBY.Visible = 0


THIS.object.st_release.Text = "Eq Avail."
THIS.object.st_release.Visible = 1
THIS.object.releaseDate.Visible = 1
THIS.object.releaseTime.Visible = 1
THIS.object.releaseBY.Visible = 1

THIS.object.st_LFD.Visible = 0
THIS.object.LastFreeDate.Visible = 0
THIS.object.LastFreeTime.Visible = 0
THIS.object.LFDBY.Visible = 0

THIS.object.st_DelBy.Text = "Drop By"
THIS.object.st_DelBy.Visible = 1
THIS.object.DelByDate.Visible = 1
THIS.object.DelByTime.Visible = 1
THIS.object.DelByBY.Visible = 1

THIS.object.st_Empty.Visible = 0
THIS.object.EmptyAtCustomerDate.Visible = 0
THIS.object.EmptyAtCustomerTime.Visible = 0
THIS.object.EmptyAtCustomerBY.Visible = 0

THIS.object.st_cutoff.Visible = 1
THIS.object.cutoffDate.Visible = 1
THIS.object.cutoffTime.Visible = 1
THIS.object.cutoffBY.Visible = 1

THIS.object.st_PuBy.Visible = 1
THIS.object.pickupbyDate.Visible = 1
THIS.object.pickupbyTime.Visible = 1
THIS.object.pickupBYby.Visible = 1

THIS.object.st_Loaded.Visible = 1
THIS.object.LoadedAtCustomerDate.Visible = 1
THIS.object.LoadedAtCustomerTime.Visible = 1
THIS.object.LoadedAtCustomerBY.Visible = 1


THIS.object.st_RailBillNumber.Visible = 1
THIS.object.RailBillNumber.Visible = 1


THIS.object.st_RailBilled.Visible = 1
THIS.object.RailBilledDate.Visible = 1
THIS.object.RailBilledBy.Visible = 1

THIS.object.st_pickUp.Visible = 0
THIS.object.PickupnumberBy.Visible = 0
THIS.object.Pickupnumber.Visible = 0

THIS.object.st_booking.Visible = TRUE
THIS.object.booking.Visible = TRUE
THIS.object.bookingnumberby.Visible = TRUE


THIS.object.st_release.y = 208
THIS.object.releaseDate.y = 208
THIS.object.releaseTime.y = 208
THIS.object.releaseBY.y = 208

THIS.object.st_DelBy.y = 280
THIS.object.DelByDate.y = 280
THIS.object.DelByTime.y = 280
THIS.object.DelByBY.y = 280


//
THIS.object.st_PuBy.y = 352  //368
THIS.object.pickupbyDate.y = 352
THIS.object.pickupbyTime.y= 352
THIS.object.pickupBYby.y = 352

THIS.object.st_cutoff.y = 424 //448 
THIS.object.cutoffDate.y = 424
THIS.object.cutoffTime.y = 424
THIS.object.cutoffBY.y = 424



THIS.object.st_Loaded.y = 496// 528 
THIS.object.LoadedAtCustomerDate.y = 496
THIS.object.LoadedAtCustomerTime.y = 496
THIS.object.LoadedAtCustomerBY.y = 496


THIS.object.st_RailBillNumber.y = 568
THIS.object.RailBillNumber.y = 568


THIS.object.st_RailBilled.y = 640
THIS.object.RailBilledDate.y = 640
THIS.object.RailBilledBy.y = 640

THIS.object.st_booking.y = 722
THIS.object.booking.y= 722
THIS.object.bookingnumberby.y= 722


end event

event ue_setcontextoneway;IF THIS.DataObject <> "d_intermodalshipinfo" THEN
	RETURN 
END IF

THIS.object.st_Prenote.Visible = TRUE
THIS.object.PrenoteDate.Visible = TRUE
THIS.object.PrenoteTime.Visible = TRUE
THIS.object.PrenoteBY.Visible = TRUE

THIS.object.st_ETA.Visible = 1
THIS.object.ETADate.Visible = 1
THIS.object.ETATime.Visible = 1
THIS.object.ETABY.Visible = 1

THIS.object.st_arrived.Visible = 1
THIS.object.arrivaldate.Visible = 1
THIS.object.arrivaltime.Visible = 1
THIS.object.arrivedby.Visible = 1

THIS.object.st_grounded.Visible = 1
THIS.object.groundedDate.Visible = 1
THIS.object.groundedTime.Visible = 1
THIS.object.groundedBY.Visible = 1

THIS.object.st_release.Text = "Release"
THIS.object.st_release.Visible = 1
THIS.object.releaseDate.Visible = 1
THIS.object.releaseTime.Visible = 1
THIS.object.releaseBY.Visible = 1

THIS.object.st_LFD.Visible = 0
THIS.object.LastFreeDate.Visible = 0
THIS.object.LastFreetime.Visible = 0
THIS.object.LFDBY.Visible = 0

THIS.object.st_DelBy.Text = "Del By"
THIS.object.st_DelBy.Visible = 0
THIS.object.DelByDate.Visible = 0
THIS.object.DelByTime.Visible = 0
THIS.object.DelByBY.Visible = 0

THIS.object.st_Empty.Visible = 0
THIS.object.EmptyAtCustomerDate.Visible = 0
THIS.object.EmptyAtCustomerTime.Visible = 0
THIS.object.EmptyAtCustomerBY.Visible = 0

THIS.object.st_booking.Visible = 0
THIS.object.booking.Visible = 0
THIS.object.bookingnumberby.Visible = 0

//
//
THIS.object.st_cutoff.Visible = 1
THIS.object.cutoffDate.Visible = 1
THIS.object.cutoffTime.Visible = 1
THIS.object.cutoffBY.Visible = 1

THIS.object.st_PuBy.Visible = 1
THIS.object.pickupbyDate.Visible = 1
THIS.object.pickupbyTime.Visible = 1
THIS.object.pickupBYby.Visible = 1

THIS.object.st_Loaded.Visible = 0
THIS.object.LoadedAtCustomerDate.Visible = 0
THIS.object.LoadedAtCustomerTime.Visible = 0
THIS.object.LoadedAtCustomerBY.Visible = 0


THIS.object.st_RailBillNumber.Visible = 1
THIS.object.RailBillNumber.Visible = 1


THIS.object.st_RailBilled.Visible = 1
THIS.object.RailBilledDate.Visible = 1
THIS.object.RailBilledby.Visible = 1

THIS.object.st_pickUp.Visible = 1
THIS.object.PickupnumberBy.Visible =1
THIS.object.Pickupnumber.Visible = 1

//MessageBox ( "a" , String ( THIS.object.st_LFD.y ) ) 

THIS.object.st_PuBy.y = 568
THIS.object.pickupbyDate.y = 568
THIS.object.pickupbyTime.y= 568
THIS.object.pickupBYby.y = 568

THIS.object.st_cutoff.y = 640// 630
THIS.object.cutoffDate.y = 640
THIS.object.cutoffTime.y = 640
THIS.object.cutoffBY.y = 640


THIS.object.st_release.y = 496
THIS.object.releaseDate.y = 496
THIS.object.releaseTime.y = 496
THIS.object.releaseBY.y = 496


//THIS.object.st_Loaded.y = 929
//THIS.object.LoadedAtCustomerDate.y = 929
//THIS.object.LoadedAtCustomerTime.y = 929
//THIS.object.LoadedAtCustomerBY.y = 929
//

THIS.object.st_RailBillNumber.y = 712 //702
THIS.object.RailBillNumber.y = 712


THIS.object.st_RailBilled.y = 784 //774
THIS.object.RailBilledDate.y = 784
THIS.object.RailBilledBy.y = 784



end event

event ue_pickupnumberchanged();Long	ll_Row 
Date	ld_Today
Boolean	lb_FillReleased

n_cst_Setting_PickupNumberFillReleased	lnv_FillReleased

ld_Today = Today ( )
ld_Today = Date ( DateTime ( ld_Today ) )

ll_Row = THIS.GetRow ( )

IF ll_Row > 0 THEN
	
	lnv_FillReleased = Create n_cst_Setting_PickupNumberFillReleased
	lb_FillReleased = (lnv_FillReleased.of_GetValue() = lnv_FillReleased.cs_Yes)
	Destroy(lnv_FillReleased)
	
	IF lb_FillReleased THEN

		IF IsNull ( THIS.GetItemDate ( ll_Row , "releasedate" )  ) THEN
			THIS.SetItem ( ll_Row , "releasedate" ,  ld_Today  )
			THIS.Event ue_RecordChange ( "releasedate" , ll_Row ) 
		END IF
		
		IF IsNull ( THIS.GetItemTime ( ll_Row , "releasetime" )  ) THEN
			THIS.SetItem ( ll_Row , "releasetime" , Now ( ) )
			THIS.Event ue_RecordChange ( "releasetime" , ll_Row ) 
		END IF

	END IF
	
	
END IF


end event

event type integer ue_pickupbydatechanged();// zmc - 1/22/04
// Had to change this event because, when processing Cross Dock shipments, 
// the PU date should be assigned to the 1st Pickup instance of the events.

Int	li_Return = -1
Date	ld_Value

n_cst_events			lnv_Events

n_cst_beo_Shipment 	lnv_Shipment
lnv_Shipment = This.Event ue_GetShipment()

n_cst_setting_setshipdate	lnv_SetDate
lnv_SetDate = CREATE n_cst_setting_setshipdate


ld_Value = THIS.GetItemDate ( 1 , "pickupbyDate"  )

//IF Not IsNull(ld_Value) THEN  <<*>> 2608
	IF lnv_Events.of_SetPuApptDate (lnv_Shipment,ld_Value) = 1 THEN
		li_Return = 1 
	END IF
//END IF

// zmc - 2-19-04 - start
// Coded this to set the shipment date to PU date &
// if n_cst_setting_setshipdate property = yes and shipdate is null.
IF li_Return = 1 THEN
	IF lnv_SetDate.of_GetValue ( ) = lnv_SetDate.cs_yes THEN
		IF IsNull(This.GetItemDate(1,"ds_Ship_Date")) THEN
			THIS.SetItem ( 1 , "ds_Ship_Date" , ld_Value  )
		END IF
	END IF
END IF	
// zmc - 2-19-04 - end

DESTROY ( lnv_SetDate )

RETURN	li_Return


/* // Code prior to version 3.8 commented by zmc on 1/22/04.

Date				ld_Value
Int				li_Return = -1
n_cst_events	lnv_Events
n_cst_bso_Dispatch	lnv_Disp

lnv_Disp = THIS.Event ue_GetDispatchManager ( )
ld_Value = THIS.GetItemDate ( 1 , "pickupbyDate"  )

IF IsValid ( lnv_Disp ) THEN
	IF lnv_Events.of_SetPuApptDate ( ld_Value , lnv_Disp.of_GetEventCache ( ) ) = 1 THEN
		li_Return = 1 
	END IF
END IF

RETURN	li_Return
*/
end event

event type integer ue_pickupbytimechanged();// zmc - 1/22/04
// Had to change this event because, when processing Cross Dock shipments, 
// the DEL date should be assigned to the Last Delivery instance of the events.

Int	li_Return = -1
Time	lt_Value

n_cst_events lnv_Events

n_cst_beo_Shipment 	lnv_Shipment
lnv_Shipment = This.Event ue_GetShipment()

lt_Value = THIS.GetItemTime ( 1 , "pickupbytime" )

//IF Not IsNull(lt_Value) THEN <<*>> 2608
	IF lnv_Events.of_SetPuApptTime (lnv_Shipment,lt_Value) = 1 THEN
		li_Return = 1 
	END IF
//END IF
RETURN	li_Return


/* // Code prior to version 3.8 commented by zmc on 1/22/04.


Time				lt_Value
Int				li_Return = -1
n_cst_events	lnv_Events
n_cst_bso_Dispatch	lnv_Disp

lnv_Disp = THIS.Event ue_GetDispatchManager ( )
lt_Value = THIS.GetItemTime ( 1 , "pickupbytime" )

IF IsValid ( lnv_Disp ) THEN
	IF lnv_Events.of_SetPuApptTime ( lt_value , lnv_Disp.of_GetEventCache ( ) ) = 1 THEN
		li_Return = 1 
	END IF
END IF

RETURN li_Return

*/
end event

event type integer ue_deliverbydatechanged();// zmc - 1/22/04
// Had to change this event because, when processing Cross Dock shipments, 
// the DEL date should be assigned to the Last Delivery instance of the events.

Int	li_Return = -1
Date	ld_Value

n_cst_events			lnv_Events

n_cst_beo_Shipment 	lnv_Shipment
lnv_Shipment = This.Event ue_GetShipment()

ld_Value = THIS.GetItemDate ( 1 , "delbyDate" )

//IF Not IsNull(ld_Value) THEN<<*>> 2608
	IF lnv_Events.of_SetDeliverApptDate (lnv_Shipment,ld_Value) = 1 THEN
		li_Return = 1 
	END IF
//END IF
RETURN	li_Return


/* // Code prior to version 3.8 commented by zmc on 1/22/04.

Int				li_Return = -1
Date				ld_Value
n_cst_events	lnv_Events
n_cst_bso_Dispatch	lnv_Disp


lnv_Disp = THIS.Event ue_GetDispatchManager ( )
ld_Value = THIS.GetItemDate ( 1 , "delbyDate" )

//If Not isNull ( ld_Value ) THEN
	IF IsValid ( lnv_Disp ) THEN
		IF lnv_Events.of_SetDeliverApptDate ( ld_Value , lnv_Disp.of_GetEventCache ( ) ) = 1 THEN
			li_Return = 1 
		END IF
	END IF
//END IF

RETURN	li_Return
*/
end event

event type integer ue_deliverbytimechanged();// zmc - 1/22/04
// Had to change this event because, when processing Cross Dock shipments, 
// the DEL date should be assigned to the Last Delivery instance of the events.

Int	li_Return = -1
Time	lt_Value

n_cst_events lnv_Events

n_cst_beo_Shipment 	lnv_Shipment
lnv_Shipment = This.Event ue_GetShipment()

lt_Value = THIS.GetItemTime ( 1 , "delbyTime" )

//IF Not IsNull(lt_Value) THEN<<*>> 2608
	IF lnv_Events.of_SetDeliverApptTime(lnv_Shipment,lt_Value) = 1 THEN
		li_Return = 1 
	END IF
//END IF
RETURN	li_Return


/* // Code prior to version 3.8 commented by zmc on 1/22/04.

Time				lt_Value
Int				li_Return = -1
n_cst_events	lnv_Events
n_cst_bso_Dispatch	lnv_Disp

lnv_Disp = THIS.Event ue_GetDispatchManager ( )
lt_Value = THIS.GetItemTime ( 1 , "delbyTime" )

//If Not isNull ( ld_Value ) THEN
	
	IF IsValid ( lnv_Disp ) THEN
		IF lnv_Events.of_SetDeliverApptTime ( lt_Value , lnv_Disp.of_GetEventCache ( ) ) = 1 THEN
			li_Return = 1 
		END IF
	END IF
//END IF

RETURN	li_Return
*/
end event

event ue_recordchange;String	ls_User
Int		li_Return

ls_User = gnv_App.of_GetUserId ( )

CHOOSE CASE lower ( as_column )
		
	
	CASE "prenotedate", "prenotetime",    "prenoteby"
		li_Return =  THIS.SetItem ( al_Row , "prenoteuser"  , ls_User )

	 
	CASE "etadate",   "etatime",    "etaby"   
		THIS.SetItem ( al_Row , "etauser"  , ls_User )
	 
	CASE "arrivedby" , "arrivaldate" , "arrivaltime"
		THIS.SetItem ( al_Row , "arriveduser"  , ls_User )
	
	CASE "groundeddate",   "groundedtime",    "groundedby"   
		THIS.SetItem ( al_Row , "groundeduser"  , ls_User )
		
	CASE"pickupnumber",   "pickupnumberby"
		THIS.SetItem ( al_Row , "pickupnumberuser"  , ls_User )
		
	CASE "bookingnumberby"  , "booking" 
		THIS.SetItem ( al_Row , "bookingnumberuser" , ls_User )
		
	CASE "releasedate",   "releasetime",   "releaseby"   
		THIS.SetItem ( al_Row , "releaseuser"  , ls_User )
		
	CASE"lfdby"  , "lastfreedate" , "lastfreetime"
		THIS.SetItem ( al_Row , "lfduser"  , ls_User )
		
	CASE"pickupbydate",   "pickupbytime",   "pickupbyby"  
		THIS.SetItem ( al_Row , "pickupbyuser"   , ls_User )
		
	CASE"delbydate",   "delbytime",   "delbyby"   
		THIS.SetItem ( al_Row , "delbyuser"  , ls_User )
		
	CASE"cutoffby" , "cutoffdate" , "cutofftime"
		THIS.SetItem ( al_Row , "cutoffuser" , ls_User )
		
	CASE"emptyatcustomerdate",   "emptyatcustomertime",   "emptyatcustomerby" 
		THIS.SetItem ( al_Row , "emptyatcustomeruser"     , ls_User )
		
	CASE"loadedatcustomerdate",   "loadedatcustomertime",   "loadedatcustomerby" 
		THIS.SetItem ( al_Row ,   "loadedatcustomeruser"    , ls_User )
		
	CASE "railbillnumber"  
		THIS.SetItem ( al_Row , "railbillnumberuser"   , ls_User )
		
	CASE   "railbilleddate",   "railbilledby"  
		THIS.SetItem ( al_Row , "railbilleduser"   , ls_User )
		
	CASE"movecode"
	

END CHOOSE


RETURN 1
end event

event ue_setcontextnone;IF THIS.DataObject <> "d_intermodalshipinfo" THEN
	RETURN 
END IF

THIS.object.st_date.Visible = FALSE
THIS.object.st_Time.Visible = FALSE
THIS.object.st_By.Visible = FALSE

THIS.object.st_Prenote.Visible = FALSE
THIS.object.PrenoteDate.Visible = FALSE
THIS.object.PrenoteTime.Visible = FALSE
THIS.object.PrenoteBY.Visible = FALSE

THIS.object.st_ETA.Visible = FALSE
THIS.object.ETADate.Visible = FALSE
THIS.object.ETATime.Visible = FALSE
THIS.object.ETABY.Visible = FALSE

THIS.object.st_arrived.Visible = FALSE
THIS.object.arrivaldate.Visible = FALSE
THIS.object.arrivaltime.Visible = FALSE
THIS.object.arrivedby.Visible = FALSE

THIS.object.st_grounded.Visible = FALSE
THIS.object.groundedDate.Visible = FALSE
THIS.object.groundedTime.Visible = FALSE
THIS.object.groundedBY.Visible = FALSE

THIS.object.st_release.Visible = FALSE
THIS.object.releaseDate.Visible = FALSE
THIS.object.releaseTime.Visible = FALSE
THIS.object.releaseBY.Visible = FALSE

THIS.object.st_LFD.Visible = FALSE
THIS.object.LastFreeDate.Visible = FALSE
THIS.object.LastFreeTime.Visible = FALSE
THIS.object.LFDBY.Visible = FALSE

THIS.object.st_DelBy.Visible = FALSE
THIS.object.DelByDate.Visible = FALSE
THIS.object.DelByTime.Visible = FALSE
THIS.object.DelByBY.Visible = FALSE

THIS.object.st_Empty.Visible = FALSE
THIS.object.EmptyAtCustomerDate.Visible = FALSE
THIS.object.EmptyAtCustomerTime.Visible = FALSE
THIS.object.EmptyAtCustomerBY.Visible = FALSE

THIS.object.st_cutoff.Visible = FALSE
THIS.object.cutoffDate.Visible = FALSE
THIS.object.cutoffTime.Visible = FALSE
THIS.object.cutoffBY.Visible = FALSE

THIS.object.st_PuBy.Visible = FALSE
THIS.object.pickupbyDate.Visible = FALSE
THIS.object.pickupbyTime.Visible = FALSE
THIS.object.pickupBYby.Visible = FALSE

THIS.object.st_Loaded.Visible = FALSE
THIS.object.LoadedAtCustomerDate.Visible = FALSE
THIS.object.LoadedAtCustomerTime.Visible = FALSE
THIS.object.LoadedAtCustomerBY.Visible = FALSE


THIS.object.st_RailBillNumber.Visible = FALSE
THIS.object.RailBillNumber.Visible = FALSE


THIS.object.st_RailBilled.Visible = FALSE
THIS.object.RailBilledDate.Visible = FALSE
THIS.object.RailBilledBy.Visible = FALSE

THIS.object.st_pickUp.Visible = FALSE
THIS.object.PickupnumberBy.Visible = FALSE
THIS.object.Pickupnumber.Visible = FALSE

THIS.object.st_booking.Visible = FALSE
THIS.object.booking.Visible = FALSE
THIS.object.bookingnumberby.Visible = FALSE

end event

event ue_keydown;
CHOOSE CASE key
		// <<*>>  I comented this because it made editing the columns very difficult
//	CASE KeyLeftArrow!
//		THIS.of_LeftArrow ( )
		
//	CASE KeyRightArrow!
//		THIS.of_RightArrow ( )
		
	CASE KeyUpArrow!
		THIS.of_UpArrow ( ) 
		
	CASE KeyDownArrow!
		THIS.of_DownArrow ( ) 
		
END CHOOSE


end event

event ue_arrivedbychanged;Int	li_Return 
Long	ll_Row 
Time	lt_Now
Date	ld_Today

lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 
ll_Row = THIS.GetRow ( ) 
IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "arrivedby" , "FAX" )
	END IF	
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "arrivedby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "arrivedby" , "PHONE" )
	END IF
	
	
	li_Return = 1
	
	IF IsNull ( THIS.GetItemDate ( ll_Row , "arrivalDate" ) ) THEN
		THIS.SetItem ( ll_Row , "arrivalDate" , ld_Today )
	END IF
	
	IF IsNull ( THIS.GetItemTime ( ll_Row , "arrivalTime" ) ) THEN
		THIS.SetItem ( ll_Row , "arrivalTime" , lt_Now )
	END IF
	
END IF

RETURN li_Return


	
	
end event

event ue_groundedbychanged;Int	li_Return 
Long	ll_Row 
Time	lt_Now
Date	ld_Today

lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 
ll_Row = THIS.GetRow ( ) 
IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "groundedby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "groundedby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "groundedby" , "PHONE" )
	END IF
	
	li_Return = 1
	
	IF IsNull ( THIS.GetItemDate ( ll_Row , "groundedDate" ) ) THEN
		THIS.SetItem ( ll_Row , "groundedDate" , ld_Today )
	END IF
	
	IF IsNull ( THIS.GetItemTime ( ll_Row , "groundedTime" ) ) THEN
		THIS.SetItem ( ll_Row , "groundedTime" , lt_Now )
	END IF
	
END IF

RETURN li_Return

end event

event type integer ue_releasebychanged(string as_data);Int	li_Return 
Long	ll_Row 
Time	lt_Now
Date	ld_Today

lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 
ll_Row = THIS.GetRow ( ) 
IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "releaseby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "releaseby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "releaseby" , "PHONE" )
	END IF
	
	li_Return = 1
	
	IF IsNull ( THIS.GetItemDate ( ll_Row , "releaseDate" ) ) THEN
		THIS.SetItem ( ll_Row , "releaseDate" , ld_Today )
		THIS.Post Event ue_ReleaseDateChanged( ld_Today )		
	END IF
	
	IF IsNull ( THIS.GetItemTime ( ll_Row , "releaseTime" ) ) THEN
		THIS.SetItem ( ll_Row , "releaseTime" , lt_Now )
	END IF
	
END IF

RETURN li_Return

end event

event ue_delbychanged;Int	li_Return 
Long	ll_Row 
Date	ld_Today

ld_Today = Date ( DateTime ( Today ( ) ) ) 
ll_Row = THIS.GetRow ( ) 
IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "delbyby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "delbyby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "delbyby" , "PHONE" )
	END IF
	
	li_Return = 1
	
	IF IsNull ( THIS.GetItemDate ( ll_Row , "delbyDate" ) ) THEN
		THIS.SetItem ( ll_Row , "delbyDate" , ld_Today )
	END IF
	
END IF

RETURN li_Return

end event

event ue_emptyatcustomerbychanged;Int	li_Return 
Long	ll_Row 
Time	lt_Now
Date	ld_Today

lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 
ll_Row = THIS.GetRow ( ) 
IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "emptyatcustomerby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "emptyatcustomerby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "emptyatcustomerby" , "PHONE" )
	END IF
	
	li_Return = 1
	
	IF IsNull ( THIS.GetItemDate ( ll_Row , "emptyatcustomerDate" ) ) THEN
		THIS.SetItem ( ll_Row , "emptyatcustomerDate" , ld_Today )
	END IF
	
	IF IsNull ( THIS.GetItemTime ( ll_Row , "emptyatcustomerTime" ) ) THEN
		THIS.SetItem ( ll_Row , "emptyatcustomerTime" , lt_Now )
	END IF
	
END IF

RETURN li_Return

end event

event ue_pickupbybychanged;Int	li_Return 
Long	ll_Row 
Date	ld_Today

ld_Today = Date ( DateTime ( Today ( ) ) ) 
ll_Row = THIS.GetRow ( ) 
IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "pickupbyby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "pickupbyby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "pickupbyby" , "PHONE" )
	END IF
	
	li_Return = 1
	
	IF IsNull ( THIS.GetItemDate ( ll_Row , "pickUpbyDate" ) ) THEN
		THIS.SetItem ( ll_Row , "pickupbyDate" , ld_Today )
	END IF

	
END IF

RETURN li_Return

end event

event ue_prenotebychanged;Int	li_Return 
Long	ll_Row 
Time	lt_Now
Date	ld_Today

lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 
ll_Row = THIS.GetRow ( ) 
IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "prenoteby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "prenoteby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "prenoteby" , "PHONE" )
	END IF
	
	
	li_Return = 1
	
	IF IsNull ( THIS.GetItemDate ( ll_Row , "prenoteDate" ) ) THEN
		THIS.SetItem ( ll_Row , "prenoteDate" , ld_Today )
	END IF
	
	IF IsNull ( THIS.GetItemTime ( ll_Row , "prenoteTime" ) ) THEN
		THIS.SetItem ( ll_Row , "prenoteTime" , lt_Now )
	END IF
	
END IF

RETURN li_Return

end event

event ue_lfdbychanged;Int	li_Return 
Long	ll_Row 

ll_Row = THIS.GetRow ( ) 

IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "lfdby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "lfdby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "lfdby" , "PHONE" )
	END IF
	li_Return = 1
	
END IF

RETURN li_Return
end event

event ue_etabychanged;Int	li_Return 
Long	ll_Row 

ll_Row = THIS.GetRow ( ) 

IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "etaby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "etaby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "etaby" , "PHONE" )
	END IF
	li_Return = 1
	
END IF

RETURN li_Return
end event

event ue_cutoffbychanged;Int	li_Return 
Long	ll_Row 

ll_Row = THIS.GetRow ( ) 

IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "cutoffby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "cutoffby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "cutoffby" , "PHONE" )
	END IF
	li_Return = 1
	
END IF

RETURN li_Return
end event

event ue_loadedatcustomerbychanged;Int	li_Return 
Long	ll_Row 
Time	lt_Now
Date	ld_Today
lt_Now = Now ( )
ld_Today = Date ( DateTime ( Today ( ) ) ) 

ll_Row = THIS.GetRow ( ) 

IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "Loadedatcustomerby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "Loadedatcustomerby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "Loadedatcustomerby" , "PHONE" )
	END IF
	li_Return = 1

	
	IF IsNull ( THIS.GetItemDate ( ll_Row , "LoadedatcustomerDate" ) ) THEN
		THIS.SetItem ( ll_Row , "LoadedatcustomerDate" , ld_Today )
	END IF
	
	IF IsNull ( THIS.GetItemTime ( ll_Row , "LoadedatcustomerTime" ) ) THEN
		THIS.SetItem ( ll_Row , "LoadedatcustomerTime" , lt_Now )
	END IF
	
	
END IF

RETURN li_Return



end event

event ue_railbilledbychanged;Int	li_Return 
Long	ll_Row 

ll_Row = THIS.GetRow ( ) 

IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "Railbilledby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "Railbilledby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "Railbilledby" , "PHONE" )
	END IF
	li_Return = 1
	
END IF

RETURN li_Return
end event

event ue_bookingnumberbychanged;Int	li_Return 
Long	ll_Row 

ll_Row = THIS.GetRow ( ) 

IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "bookingnumberby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "bookingnumberby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "bookingnumberby" , "PHONE" )
	END IF
	li_Return = 1
	
END IF

RETURN li_Return
end event

event ue_pickupnumberbychanged;Int	li_Return 
Long	ll_Row 

ll_Row = THIS.GetRow ( ) 

IF ll_Row > 0 And Len ( as_Data ) > 0 THEN
	
	IF Upper ( as_Data ) = 'F' THEN
		THIS.SetItem ( ll_Row , "pickupnumberby" , "FAX" )
	END IF
	IF Upper ( as_Data ) = 'V' THEN
		THIS.SetItem ( ll_Row , "pickupnumberby" , "VERBAL" )
	END IF
	IF Upper ( as_Data ) = 'P' THEN
		THIS.SetItem ( ll_Row , "pickupnumberby" , "PHONE" )
	END IF
	li_Return = 1
	
END IF

RETURN li_Return
end event

event type integer ue_releasedatechanged(date ad_value);int	li_Return = -1
n_cst_beo_Shipment	lnv_Shipment
n_Cst_bso_Dispatch	lnv_Disp
//n_cst_EquipmentManager	lnv_Manager

lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Disp = THIS.Event ue_GetDispatchManager( ) 

IF IsValid ( lnv_Shipment ) AND isValid ( lnv_Disp )THEN
	//	lnv_Manager.of_Sync ( lnv_Disp.of_GetEquipmentCache ( ) , FALSE , FALSE ) //
	IF lnv_Shipment.of_SetEquipmentReleaseDate ( ad_value , lnv_Disp ) = 1 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return
end event

event ue_releasetimechanged;int	li_Return = -1
n_cst_beo_Shipment	lnv_Shipment
n_Cst_bso_Dispatch	lnv_Disp
//n_cst_EquipmentManager	lnv_Manager

IF IsNull ( at_value ) THEN
	at_value = THIS.GetItemTime ( THIS.GetRow ( ) , "releaseTime" ) 
END IF

lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Disp = THIS.Event ue_GetDispatchManager( ) 

IF IsValid ( lnv_Shipment ) AND isValid ( lnv_Disp )THEN
	
	//lnv_Manager.of_Sync ( lnv_Disp.of_GetEquipmentCache ( ) , FALSE , FALSE ) //
	IF lnv_Shipment.of_SetEquipmentReleaseTime ( at_value , lnv_Disp ) = 1 THEN
		li_Return = 1		
	END IF
	
END IF

RETURN li_Return
end event

event ue_railbillnumberchanged;Int	li_Return 
Long	ll_Row 
Date	ld_Today

ld_Today = Date ( DateTime ( Today ( ) ) ) 
ll_Row = THIS.GetRow ( ) 
IF ll_Row > 0 And Len ( Data ) > 0 THEN
			
	li_Return = 1
	
	IF IsNull ( THIS.GetItemDate ( ll_Row , "railbilledDate" ) ) THEN
		THIS.SetItem ( ll_Row , "railbilledDate" , ld_Today )
	END IF
	
END IF

RETURN li_Return
end event

event ue_emptyatcustomerdatechanged(string as_data);n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( )

IF isValid (lnv_Shipment ) THEN
	lnv_Shipment.of_Setemptyatcustomerdate( Date (as_data ) )
END IF

//n_cst_bso_Dispatch	lnv_Disp
//N_cst_Beo_Equipment2	lnva_equipment[]
//
//lnv_Disp = THIS.event ue_getdispatchmanager( )
//
//IF isValid ( lnv_Disp ) AND Not IsNull ( as_Data ) THEN
//	lnv_Disp.of_GetEquipmentforshipment( THIS.event ue_getshipment( ).of_GetID ()  , lnva_equipment )
//	lnv_Disp.of_GetEquipmentPosting ( ).of_ProposeHavePostings ( lnva_equipment )
//	
//END IF
end event

public function integer of_setdisplayrestrictions ();IF Not ib_restrictionsset THEN
	
 	//if ( describe ( 'txt_restrict_ind.text' ) = 'T', 1, 0 )
	//protect="0~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 1, 0 )"
	Long		ll_ColumnCount	
	Long		ll_i
	String	ls_ColumnName
	String	ls_ModifyRtn, ls_privFunction
	n_cst_beo_shipment lnv_shipment
	n_cst_setting_advancedprivs lnv_setting 
	Boolean 	lb_disableNote
	Boolean	lb_Billed
	Boolean	lb_AdvancedPrivs
	Boolean	lb_ModifyBilledShipRates
	lnv_setting = create n_cst_setting_advancedprivs
		
	ll_ColumnCount = Long ( THIS.Object.DataWindow.Column.Count )
	
	lb_AdvancedPrivs = lnv_setting.of_getValue( ) = "Yes"
	
	lnv_shipment = this.event ue_getshipment( )
	lb_Billed = lnv_shipment.of_isBilled( )
	
	lb_ModifyBilledShipRates = (gnv_App.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( appeon_constant.cs_ModifyBilledShipRates, lnv_shipment )) = appeon_constant.ci_TRUE
	
	FOR ll_i = 1 TO ll_ColumnCount
		ls_ColumnName = String (  THIS.Describe("#"+ String (ll_i)+ ".Name") )
		
		IF Pos ( ls_ColumnName , "user" ) > 0 THEN
			CONTINUE
		END IF
		
		//Modified by Dan 2-7-07 to use new privilege if the shipment is billed
		
		IF lb_Billed THEN
			//DEK 4-18-07 The default role was disabling shipnotes when extended privs were off.
			//That is not the functionality that we wanted.
			IF lb_AdvancedPrivs THEN		
				ls_privFunction = appeon_constant.cs_ModifyBilledShip
			ELSE
				//When the extended privs are off, we do not want to disable the use of shipnotes unless the setting is no.
				//Regardless of whether or not it is billed, the default role to change the notes was the same
				//as the modify shipment.  
				ls_privFunction = "ModifyShipment"	//DEK 4-18-07 
			END IF
		ELSE
			ls_privFunction = "ModifyShipment"
		END IF
		//////////////////
		
		CHOOSE CASE ls_ColumnName 
			CASE  "ds_ship_comment" 
				n_cst_Setting_EnableShipNote	lnv_ShipNote
				lnv_ShipNote = CREATE n_cst_Setting_EnableShipNote
				IF gnv_App.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction, lnv_shipment ) = appeon_constant.ci_FALSE & 
					OR lnv_Shipnote.of_GetValue ( ) = lnv_ShipNote.cs_NO THEN
					
					
						ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".protect=~"0~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 1, 0 )~"" )
						ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".background.color=~"16777215~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 12648447, 16777215 )~"" )					
				END IF
				DESTROY ( lnv_ShipNote )					

			
			CASE  "ds_bill_comment" 
								
					n_cst_Setting_EnableBillNote	lnv_BillNote
					lnv_BillNote = CREATE n_cst_Setting_EnableBillNote
					
					IF gnv_App.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction, lnv_shipment ) = appeon_constant.ci_FALSE &
						OR lnv_Billnote.of_GetValue ( ) = lnv_BillNote.cs_NO THEN
					
						ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".protect=~"0~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 1, 0 )~"" )
						ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".background.color=~"16777215~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 12648447, 16777215 )~"" )	
					ELSE
						ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".protect=0" )
						ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".background.color=16777215" )	
						
					END IF
					DESTROY ( lnv_BillNote ) 
				
	
			CASE "ds_id" ,  "ds_ref1_text" , "ds_ref2_text" , "ds_ref3_text" , "ds_status" , "ds_bill_date" , "ds_pronum" 
			 //,"custom1" , "custom2" ,"custom3" , "custom4" ,"custom5" , "custom6" ,"custom7" , "custom8","custom9" , "custom10"
	//		"movecode" , this was in the list above
			//DEK: 3-27-07
			CASE "ds_lh_totamt"	, "ds_disc_pct" , "ds_disc_amt" , "ds_ac_totamt" , "ds_bill_charge" , "ds_pay_lh_totamt" , "ds_pay_ac_totamt", &
			"ds_pay_totamt" , "ds_salescom_amt"
				String	ls_modify
				CONSTANT String	ls_RestrictRates = "txt_restrictrates_ind.text = 'T'"
				CONSTANT String	ls_NonRestrictRates = "txt_restrictrates_ind.text = 'F'"
				IF lb_Billed THEN
					
					IF lb_ModifyBilledShipRates THEN
						ls_modify = ls_nonRestrictRates
					ELSE
						ls_modify = ls_restrictRates
					END IF
					this.modify( ls_modify )
				END IF
			/////////////////////////////
			CASE ELSE
				ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".protect=~"0~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 1, 0 )~"" )
				ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".background.color=~"16777215~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 12648447, 16777215 )~"" )	
			
		END CHOOSE
		
	NEXT
	
	ib_Restrictionsset = TRUE
	
	// computed fields are not accounted for in get column count
	//THIS.Modify( "comp_confirmed.Width=0")
	//THIS.Modify( "comp_routed.Width=0")
	//THIS.Modify( "comp_tz_adj.Width=0")
	//THIS.Post of_AllowEdit ( TRUE ) 
	//
	
END IF
DESTROY lnv_setting
THIS.SetColumn ( "ds_ship_comment" ) 
THIS.SetColumn ( "prenotedate" ) 
RETURN 1
end function

public function integer of_setsmallviewtaborder ();
THIS.SetTabOrder ( "Custom1", 0 )
THIS.SetTabOrder ( "Custom2", 0 )
THIS.SetTabOrder ( "Custom3", 0 )
THIS.SetTabOrder ( "Custom4", 0 )
THIS.SetTabOrder ( "Custom5", 0 )


RETURN 1
end function

public function integer of_determineinitialcontext ();Long	ll_Row
String	ls_Context

ll_Row = THIS.GetRow ( )

IF ll_Row > 0 THEN
	ls_Context = THIS.GetItemString ( ll_Row , "MoveCode" )	
	THIS.of_SetContext ( ls_Context )
END IF


RETURN 1
end function

public function integer of_setcontext (string as_context);THIS.SetRedraw ( FALSE )
CHOOSE CASE as_context							
	CASE "I"
		THIS.Event ue_SetContextImport ( )
	CASE "E"
		THIS.Event ue_SetContextExport ( )				
	CASE "O"
		THIS.Event ue_SetContextOneWay ( )
	CASE ELSE
		THIS.Event ue_SetContextNone ( )
		
END CHOOSE
THIS.SetRedraw ( TRUE )
RETURN 1
end function

private function integer of_downarrow ();String	ls_Context
String	ls_CurrentColumn
Boolean	lb_Intermodal = TRUE
Constant String	cs_Import = "I"
Constant String	cs_Export = "E"
Constant String	cs_OneWay = "O"

n_Cst_beo_Shipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( )

IF isValid ( lnv_SHipment ) THEN
	lb_Intermodal = lnv_Shipment.of_IsIntermodal ( )
END IF

ls_CurrentColumn = Lower ( THIS.GetColumnName ( )  )
ls_Context = THIS.of_GetContext ( )

CHOOSE CASE ls_CurrentColumn
				
	CASE "prenotedate"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "etadate" )
		ELSE
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "releasedate" )
			ELSE
				THIS.SetColumn ( "etadate" )
			END IF
		END IF		
		
	CASE "prenotetime"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "etatime" )
		ELSE
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "releasetime" )
			ELSE
				THIS.SetColumn ( "etatime" )
			END IF
		END IF
		
	CASE "prenoteby"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "etaby" )
		ELSE
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "releaseby" )
			ELSE
				THIS.SetColumn ( "etaby" )
			END IF
		END IF
		
	CASE "etadate"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "releasedate" )
		ELSE
			THIS.SetColumn ( "arrivaldate" )
		END IF
		
	CASE "etatime"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "releasetime" )
		ELSE
			THIS.SetColumn ( "arrivaltime" )
		END IF
		
	CASE "etaby"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "releaseby" )
		ELSE
			THIS.SetColumn ( "arrivedby" )
		END IF
			
	CASE "arrivaldate"
		THIS.SetColumn ( "groundeddate" )
		
	CASE "arrivaltime"
		THIS.SetColumn ( "groundedtime" )		
		
	CASE "arrivedby"
		THIS.SetColumn ( "groundedby" )
		
	CASE "groundeddate"
		THIS.SetColumn ( "pickupnumber" )
		
	CASE "groundedtime"
		
//		THIS.SetColumn ( "pickupnumber" )
		THIS.SetColumn ( "releasetime" )
		
	CASE "groundedby"
		THIS.SetColumn ( "pickupnumberby" )
	
	CASE "releasedate"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "pickupbydate" )
		ELSE
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "delbydate" )
			ELSEIF ls_Context = cs_import THEN
				THIS.SetColumn ( "lastfreedate" )
			ELSE
				THIS.SetColumn ( "pickupbydate" )
			END IF
		END IF
		
		
	CASE "releasetime"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "pickupbytime" )
		ELSE
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "delbytime" )
			ELSEIF ls_Context = cs_import THEN
				THIS.SetColumn ( "lastfreetime" )
			ELSE
				THIS.SetColumn ( "pickupbytime" )
			END IF
		END IF

		
	CASE "releaseby"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "pickupbyby" )
		ELSE
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "delbyby" )
			ELSEIF ls_Context = cs_import THEN
				THIS.SetColumn ( "lfdby" )
			ELSE
				THIS.SetColumn ( "pickupbyby" )
			END IF
		END IF
			
	CASE "lastfreedate"
		//IF ls_Context = cs_Import THEN
			THIS.SetColumn ( "delbydate" )
	//	ELSE
	//		THIS.SetColumn ( "cutoffdate" )
	//	END IF
		
		
	
	CASE "lastfreetime"
	//	IF ls_Context = cs_Import THEN
			THIS.SetColumn ( "delbytime" )
	//	ELSE
	//		THIS.SetColumn ( "cutofftime" )
	//	END IF
		
	CASE "lfdby"
	//	IF ls_Context = cs_Import THEN
			THIS.SetColumn ( "delbyby" )
	//	ELSE
	//		THIS.SetColumn ( "cutoffby" )
	//	END IF
		
	CASE "delbydate"
		IF lb_Intermodal THEN
			IF ls_Context = cs_Import THEN
				THIS.SetColumn ( "emptyatcustomerdate" )		
			ELSE
				THIS.SetColumn ( "pickupbydate" )		
			END IF
		ELSE
			THIS.SetColumn ( "emptyatcustomerdate" )		
		END IF
		
	CASE "delbytime"
		IF lb_Intermodal THEN
			IF ls_Context = cs_Import THEN
				THIS.SetColumn ( "emptyatcustomertime" )	
			ELSE
				THIS.SetColumn ( "pickupbytime" )		
			END IF
		ELSE
			THIS.SetColumn ( "emptyatcustomertime" )	
		END IF
		
		
		   
	CASE "delbyby"
		IF lb_Intermodal THEN
			IF ls_Context = cs_Import THEN
				THIS.SetColumn ( "emptyatcustomerby" )
			ELSE
				THIS.SetColumn ( "pickupbyby" )		
			END IF
		ELSE
			THIS.SetColumn ( "emptyatcustomerby" )
		END IF
	
	
	CASE "emptyatcustomerdate"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "loadedatcustomerdate" )
		END IF
		
	CASE "emptyatcustomertime"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "loadedatcustomertime" )
		END IF
		
	CASE "emptyatcustomerby"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "loadedatcustomerby" )
		END IF

	CASE "cutoffdate"
		IF ls_Context = cs_export THEN
			THIS.SetColumn ( "loadedatcustomerdate" )



		ELSE
			THIS.SetColumn ( "railbillnumber" )	
		END IF
	
	CASE "cutofftime"
		IF ls_Context = cs_export THEN
			THIS.SetColumn ( "loadedatcustomertime" )
		ELSE
			THIS.SetColumn ( "railbillnumber" )	
		END IF

		
	CASE "cutoffby"
		IF ls_Context = cs_export THEN
			THIS.SetColumn ( "loadedatcustomerby" )
		ELSE
			THIS.SetColumn ( "railbilledby" )
		END IF
		
		//THIS.SetColumn ( "railbilledby" )
		
	CASE "pickupbydate"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "pickupnumber" )
		ELSE
			THIS.SetColumn ( "cutoffdate" )
		END IF
		
	CASE "pickupbytime"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "delbytime" )
		ELSE
			THIS.SetColumn ( "cutofftime" )
		END IF
		
	CASE "pickupbyby"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "pickupnumberby" )
		ELSE
			THIS.SetColumn ( "cutoffby" )
		END IF
		
	CASE "loadedatcustomerdate"
		THIS.SetColumn ( "railbillnumber" )
		
	CASE "loadedatcustomertime"
		THIS.SetColumn ( "railbillnumber" )
		
	CASE "loadedatcustomerby"
		THIS.SetColumn ( "railbilledby" )
		
	CASE "railbillnumber"
		THIS.SetColumn ( "railbilleddate" )
		
	CASE "pickupnumberby"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "delbyby" )
		ELSE
			THIS.SetColumn ( "releaseby" )
		END IF
		
	CASE "pickupnumber"
		IF NOT lb_intermodal THEN
			THIS.SetColumn ( "delbydate" )
		ELSE
			THIS.SetColumn ( "releasedate" )
		END IF
		
			
	CASE "railbilleddate"		
		IF ls_Context = cs_export THEN
			THIS.SetColumn ( "booking" )
		END IF
		
	CASE "railbilledby"			
		IF ls_Context = cs_export THEN
			THIS.SetColumn ( "bookingnumberby" )
		END IF
END CHOOSE 

RETURN 1




end function

private function integer of_leftarrow ();String	ls_Context
String	ls_CurrentColumn
Constant String	cs_Import = "I"
Constant String	cs_Export = "E"
Constant String	cs_OneWay = "O"


ls_CurrentColumn = Lower ( THIS.GetColumnName ( )  )
ls_Context = THIS.of_GetContext ( )



CHOOSE CASE ls_CurrentColumn
				
//	CASE "prenotedate"
//		THIS.SetColumn ( "prenotetime" )
		
	CASE "prenotetime"
		THIS.SetColumn ( "prenotedate" )
		
	CASE "prenoteby"
		THIS.SetColumn ( "prenotetime" )
	
//	CASE "etadate"
//		THIS.SetColumn ( "etatime" )
		
	CASE "etatime"
		THIS.SetColumn ( "etadate" )
		
	CASE "etaby"
		THIS.SetColumn ( "etatime" )
			
			
//	CASE "arrivaldate"
//		THIS.SetColumn ( "arrivaltime" )
		
	CASE "arrivaltime"
		THIS.SetColumn ( "arrivaldate" )		
		
	CASE "arrivedby"
		THIS.SetColumn ( "arrivaltime" )
		
//	CASE "groundeddate"
//		THIS.SetColumn ( "groundedtime" )
		
	CASE "groundedtime"
		THIS.SetColumn ( "groundeddate" )
		
	CASE "groundedby"
		THIS.SetColumn ( "groundedtime" )
	
//	CASE "releasedate"
//		THIS.SetColumn ( "releasetime" )
		
		
	CASE "releasetime"
		THIS.SetColumn ( "releasedate" )
		
	CASE "releaseby"	
		THIS.SetColumn ( "releasetime" )
			
//	CASE "lastfreedate"
//		THIS.SetColumn ( "lastfreetime" )
			
	CASE "lastfreetime"
		THIS.SetColumn ( "lastfreedate" )
						
	CASE "lfdby"
		THIS.SetColumn ( "lastfreetime" )
		
//	CASE "delbydate"
//		THIS.SetColumn ( "delbytime" )		
		
	CASE "delbytime"
		THIS.SetColumn ( "delbydate" )
		   
	CASE "delbyby"
		THIS.SetColumn ( "delbytime" )
	
//	CASE "emptyatcustomerdate"
//		THIS.SetColumn ( "emptyatcustomertime" )
		
	CASE "emptyatcustomertime"
		THIS.SetColumn ( "emptyatcustomerdate" )
		
	CASE "emptyatcustomerby"
		THIS.SetColumn ( "emptyatcustomertime" )
//		
//	CASE "cutoffdate"
//		THIS.SetColumn ( "cutofftime" )
	
	CASE "cutofftime"
		THIS.SetColumn ( "cutoffdate" )
		
	CASE "cutoffby"
		THIS.SetColumn ( "cutofftime" )
		
		
//	CASE "pickupbydate"
//		THIS.SetColumn ( "pickupbytime" )
		
	CASE "pickupbytime"
		THIS.SetColumn ( "pickupbydate" )
		
	CASE "pickupbyby"
		THIS.SetColumn ( "pickupbytime" )
		
//	CASE "loadedatcustomerdate"
//		THIS.SetColumn ( "loadedatcustomertime" )

		
	CASE "loadedatcustomertime"
		THIS.SetColumn ( "loadedatcustomerdate" )
		
	CASE "loadedatcustomerby"
		THIS.SetColumn ( "loadedatcustomertime" )
		
//	CASE "railbillnumber"
//		THIS.SetColumn ( "RailBilledby" )
	CASE "railbilleddate"		
		
	CASE "railbilledby"	
		THIS.SetColumn ( "railbilleddate" )
//		
//	CASE "pickupnumber"
//		THIS.SetColumn ( "pickupnumberby" )
	CASE "pickupnumberby"
		THIS.SetColumn ( "pickupnumber" )
	
	CASE "bookingnumberby"
		THIS.SetColumn ( "booking" )
	
		
END CHOOSE 

RETURN -1




end function

private function integer of_rightarrow ();String	ls_Context
String	ls_CurrentColumn
Constant String	cs_Import = "I"
Constant String	cs_Export = "E"
Constant String	cs_OneWay = "O"


ls_CurrentColumn = Lower ( THIS.GetColumnName ( )  )
ls_Context = THIS.of_GetContext ( )



CHOOSE CASE ls_CurrentColumn
				
	CASE "prenotedate"
		THIS.SetColumn ( "prenotetime" )
		
	CASE "prenotetime"
		THIS.SetColumn ( "prenoteby" )
		
//	CASE "prenoteby"
//		THIS.SetColumn ( "prenotetime" )
	
	CASE "etadate"
		THIS.SetColumn ( "etatime" )
		
	CASE "etatime"
		THIS.SetColumn ( "etaby" )
		
//	CASE "etaby"
//		THIS.SetColumn ( "prenoteby" )
			
			
	CASE "arrivaldate"
		THIS.SetColumn ( "arrivaltime" )
		
	CASE "arrivaltime"
		THIS.SetColumn ( "arrivedby" )		
		
//	CASE "arrivedby"
//		THIS.SetColumn ( "etaby" )
		
	CASE "groundeddate"
		THIS.SetColumn ( "groundedtime" )
		
	CASE "groundedtime"
		THIS.SetColumn ( "groundedby" )
		
//	CASE "groundedby"
//		THIS.SetColumn ( "arrivedby" )
	
	CASE "releasedate"
		THIS.SetColumn ( "releasetime" )
		
		
	CASE "releasetime"
		THIS.SetColumn ( "releaseby" )
		
//	CASE "releaseby"	
//		THIS.SetColumn ( "pickupnumberby" )
			
	CASE "lastfreedate"
		THIS.SetColumn ( "lastfreetime" )
			
	CASE "lastfreetime"
		THIS.SetColumn ( "lfdby" )
						
//	CASE "lfdby"
//		THIS.SetColumn ( "releaseby" )
		
	CASE "delbydate"
		THIS.SetColumn ( "delbytime" )		
		
	CASE "delbytime"
		THIS.SetColumn ( "delbyby" )
		   
//	CASE "delbyby"
//		THIS.SetColumn ( "lfdby" )
	
	CASE "emptyatcustomerdate"
		THIS.SetColumn ( "emptyatcustomertime" )
		
	CASE "emptyatcustomertime"
		THIS.SetColumn ( "emptyatcustomerby" )
		
//	CASE "emptyatcustomerby"
//		THIS.SetColumn ( "delbyby" )
		
	CASE "cutoffdate"
		THIS.SetColumn ( "cutofftime" )
	
	CASE "cutofftime"
		THIS.SetColumn ( "cutoffby" )
		
//	CASE "cutoffby"
//		THIS.SetColumn ( "emptyatcustomerby" )
		
		
	CASE "pickupbydate"
		THIS.SetColumn ( "pickupbytime" )
		
	CASE "pickupbytime"
		THIS.SetColumn ( "pickupbyby" )
		
//	CASE "pickupbyby"
//		THIS.SetColumn ( "prenoteby" )
		
	CASE "loadedatcustomerdate"
		THIS.SetColumn ( "loadedatcustomertime" )
		
	CASE "loadedatcustomertime"
		THIS.SetColumn ( "loadedatcustomerby" )
		
//	CASE "loadedatcustomerby"
//		THIS.SetColumn ( "cutoffby" )
		
	CASE "railbillnumber"
		THIS.SetColumn ( "RailBilledby" )
	CASE "railbilleddate"		
		THIS.SetColumn ( "RailBilledby" )
//	CASE "RailBilledby"	
//		THIS.SetColumn ( "RailBilledby" )
		
	CASE "pickupnumber"
		THIS.SetColumn ( "pickupnumberby" )
//	CASE "pickupnumberby"
//		THIS.SetColumn ( "groundedby" )
		
	CASE "booking"
		THIS.SetColumn ( "bookingnumberby" )
	
		
END CHOOSE 

RETURN -1




end function

private function integer of_uparrow ();String	ls_Context
String	ls_CurrentColumn
Boolean	lb_Intermodal = TRUE
Constant String	cs_Import = "I"
Constant String	cs_Export = "E"
Constant String	cs_OneWay = "O"
n_cst_beo_shipment lnv_Shipment 

lnv_Shipment = THIS.Event ue_GetShipment () 
IF isvalid ( lnv_SHipment ) THEN
	lb_intermodal = lnv_Shipment.of_IsIntermodal ( )
END IF


ls_CurrentColumn = Lower ( THIS.GetColumnName ( )  )
ls_Context = THIS.of_GetContext ( )



CHOOSE CASE ls_CurrentColumn
				
	
	CASE "etadate"
		THIS.SetColumn ( "prenotedate" )
		
	CASE "etatime"
		THIS.SetColumn ( "prenotetime" )
		
	CASE "etaby"
		THIS.SetColumn ( "prenoteby" )
			
			
	CASE "arrivaldate"
		THIS.SetColumn ( "etadate" )
		
	CASE "arrivaltime"
		THIS.SetColumn ( "etatime" )		
		
	CASE "arrivedby"
		THIS.SetColumn ( "etaby" )
		
	CASE "groundeddate"
		THIS.SetColumn ( "arrivaldate" )
		
	CASE "groundedtime"
		THIS.SetColumn ( "arrivaltime" )
		
	CASE "groundedby"
		THIS.SetColumn ( "arrivedby" )
	
	CASE "releasedate"
		IF lb_Intermodal THEN
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "prenotedate" )
			ELSE 
				THIS.SetColumn ( "pickupnumber" )
			END IF			
		ELSE			
			THIS.SetColumn ( "etadate" )			
		END IF
		

		
	CASE "releasetime"
		
		IF lb_Intermodal THEN
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "prenotetime" )
			ELSE 
				THIS.SetColumn ( "groundedtime" )
			END IF	
			
		ELSE
			THIS.SetColumn ( "etatime" )
		END IF
		
		
		
	CASE "releaseby"	
		IF lb_Intermodal THEN
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "prenoteby" )
			ELSE
				THIS.SetColumn ( "pickupnumberby" )
			END IF
			
		ELSE
			THIS.SetColumn ( "etaby" )
		END IF
		
		
			
	CASE "lastfreedate"
		THIS.SetColumn ( "releasedate" )
			
	CASE "lastfreetime"
		THIS.SetColumn ( "releasetime" )
		
				
	CASE "lfdby"
		THIS.SetColumn ( "releaseby" )
		
	CASE "delbydate"
		IF lb_Intermodal THEN
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "releasedate" )
			ELSE 
				THIS.SetColumn ( "lastfreedate" )
			END IF
			
		ELSE
			THIS.SetColumn ( "pickupnumber" )
		END IF
				
		
	CASE "delbytime"
		IF lb_Intermodal THEN
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "releasetime" )
			ELSE
				THIS.SetColumn ( "lastfreetime" )
			END IF
			
		ELSE
			THIS.SetColumn ( "pickupbytime" )
		END IF
		
		   
	CASE "delbyby"
		IF lb_Intermodal THEN
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "releaseby" )
			ELSE
				THIS.SetColumn ( "lfdby" )
			END IF
			
		ELSE
			THIS.SetColumn ( "pickupnumberby" )
		END IF
		
	
	CASE "emptyatcustomerdate"
		THIS.SetColumn ( "delbydate" )
		
	CASE "emptyatcustomertime"
		THIS.SetColumn ( "delbytime" )
		
	CASE "emptyatcustomerby"
		THIS.SetColumn ( "delbyby" )
		

	CASE "cutoffdate"
//		IF ls_Context = cs_export THEN
			THIS.SetColumn ( "pickupbydate" )
	//	ELSE
	//		THIS.SetColumn ( "lastfreedate" )
	//	END IF
	
	CASE "cutofftime"
		//IF ls_Context = cs_export THEN
			THIS.SetColumn ( "pickupbytime" )
		//ELSE
		//	THIS.SetColumn ( "lastfreetime" )
		//END IF
		
	CASE "cutoffby"
		//IF ls_Context = cs_export THEN
			THIS.SetColumn ( "pickupbyby" )
	//	ELSE
	//		THIS.SetColumn ( "lfdby" )
	//	END IF
		
		
	CASE "pickupbydate"
		
		IF lb_Intermodal THEN
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "delbydate" )
			ELSE
				THIS.SetColumn ( "releasedate" )
			END IF
			
		ELSE
			THIS.SetColumn ( "releasedate" )
		END IF
		
		
		
	CASE "pickupbytime"
		IF lb_Intermodal THEN
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "delbytime" )
			ELSE
				THIS.SetColumn ( "releasetime" )
			END IF
			
		ELSE
			THIS.SetColumn ( "releasetime" )
		END IF
		
		
		
		
		
	CASE "pickupbyby"
		IF lb_Intermodal THEN
			IF ls_Context = cs_Export THEN
				THIS.SetColumn ( "delbyby" )
			ELSE
				THIS.SetColumn ( "releaseby" )
			END IF
			
		ELSE
			THIS.SetColumn ( "releaseby" )
		END IF
		
		
	CASE "loadedatcustomerdate"
		IF lb_Intermodal THEN
			THIS.SetColumn ( "cutoffdate" )
		ELSE
			THIS.SetColumn ( "emptyatcustomerdate" )
		END IF
		
		
		
	CASE "loadedatcustomertime"
		IF lb_Intermodal THEN
			THIS.SetColumn ( "cutofftime" )
		ELSE
			THIS.SetColumn ( "emptyatcustomertime" )
		END IF
		
		
		
	CASE "loadedatcustomerby"
		
		IF lb_Intermodal THEN
			THIS.SetColumn ( "cutoffby" )
		ELSE
			THIS.SetColumn ( "emptyatcustomerby" )
		END IF
		
		
		
	CASE "railbillnumber"
		IF ls_Context = cs_export THEN
			THIS.SetColumn ( "loadedatcustomerdate" )
		ELSE
			THIS.SetColumn ( "cutoffdate" )
		END IF
	
	CASE "railbilleddate"	
		THIS.SetColumn ( "railbillnumber" )
		
	CASE "railbilledby"	
		IF ls_Context = cs_export THEN
			THIS.SetColumn ( "loadedatcustomerby" )
		ELSE
			THIS.SetColumn ( "cutoffby" )
		END IF
		
	CASE "pickupnumberby"
		IF lb_Intermodal THEN
			THIS.SetColumn ( "groundedby" )
		ELSE
			THIS.SetColumn ( "pickupbyby" )
		END IF
		
		
		
	CASE "pickupnumber"
		IF lb_Intermodal THEN
			THIS.SetColumn ( "groundeddate" )
		ELSE
			THIS.SetColumn ( "pickupbydate" )
		END IF
		
		
		
	CASE "booking"		
		IF ls_Context = cs_export THEN
			THIS.SetColumn ( "railbilleddate" )
		END IF
		
	CASE "bookingnumberby"			
		IF ls_Context = cs_export THEN
			THIS.SetColumn ( "railbilledby" )
		END IF
		
END CHOOSE 

RETURN -1




end function

private function string of_getcontext ();Long	ll_Row
String	ls_Context

ll_Row = THIS.GetRow ( )

IF ll_Row > 0 THEN
	ls_Context = THIS.GetItemString ( ll_Row , "MoveCode" )	
END IF

RETURN ls_Context

end function

public subroutine of_openadminwindow ();n_CsT_bso_Dispatch	lnv_Disp
n_Cst_beo_SHipment	lnv_SHip
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm

lnv_Ship = THIS.Event ue_GetShipment ( )
lnv_Disp = THIS.Event ue_GetDispatchManager ( )

lstr_Parm.is_Label = "DISPATCH"
lstr_Parm.ia_Value = lnv_Disp
lnv_Msg.of_Add_Parm ( lstr_Parm ) 

lstr_Parm.is_Label = "SHIPMENT"
lstr_Parm.ia_Value = lnv_Ship
lnv_Msg.of_Add_Parm ( lstr_Parm ) 


OpenWithParm ( w_IntermodalAdmin , lnv_Msg )


end subroutine

event itemchanged;call super::itemchanged;Date	ld_ExistingShipDate
Date  ld_NewDate
Time	lt_NewTime
Long	ll_Return
String	ls_Temp

n_cst_Privileges	lnv_Privs

ll_Return = AncestorReturnValue

Choose Case dwo.name
	CASE "movecode"
		IF IsNull ( THIS.GetItemString ( row , "moveCode" )  ) OR lnv_Privs.of_hasAdministrativeRights ( ) THEN
			THIS.of_SetContext ( data )	
		ELSE
			MessageBox ( "Change of move type"  , "The move type cannot be changed once defined." )
			ll_Return = 2
		END IF
	
	CASE "pickupnumber"
		
		THIS.Event ue_PickupNumberChanged ( )
		
	CASE "pickupbydate"	 
		THIS.Post Event ue_PickupByDateChanged (  )
		
	CASE "pickupbytime"
		THIS.Post Event ue_PickupByTimeChanged (  )
		
	CASE "delbytime"
		THIS.Post Event ue_deliverBytimeChanged ( )
		
	CASE "delbydate"
		THIS.Post Event ue_deliverByDateChanged (  )
		
	CASE "lastfreedate" , "pickupbydate"	
		IF IsNull ( data ) THEN
			SetNull (ld_NewDate )
		ELSE
			ld_NewDate = Date ( DateTime ( data ) )
		END IF
		n_cst_setting_setshipdate	lnv_SetDate
		lnv_SetDate = CREATE n_cst_setting_setshipdate
		IF lnv_SetDate.of_GetValue ( ) = lnv_SetDate.cs_yes THEN
			THIS.SetItem ( row , "ds_Ship_Date" , ld_NewDate  )
		END IF
		DESTROY ( lnv_SetDate )
		
	CASE "booking"
		THIS.Post Event ue_BookingNumberChanged ( data )
	
	CASE "prenoteby"
		THIS.Post Event ue_PrenoteByChanged ( data )
	
	CASE "arrivedby"
		THIS.Post Event ue_ArrivedBYChanged( data )
		
	CASE "groundedby"
		THIS.Post Event ue_GroundedBYChanged( data )
		
	CASE "releaseby"
		THIS.Post Event ue_ReleaseBYChanged( data )
		
	CASE "releasedate"
		IF IsNull ( data ) THEN
			SetNull (ld_NewDate )
		ELSE
			ld_NewDate = Date ( data ) 
			ls_Temp = String (ld_NewDate ,"MM/DD/YY" ) 
			ld_NewDate = Date ( data ) 
			// I know this is weird. It was the only way to prevent ??/??/00 on a double click.			
		END IF
	
		THIS.Post Event ue_ReleaseDateChanged( ld_NewDate )
				
	CASE "releasetime"

		lt_NewTime = Time ( data )

		THIS.Post Event ue_ReleaseTimeChanged( lt_NewTime )
		
	CASE "delbyby"
		THIS.Post Event ue_DelBYChanged( data )
		
	CASE "emptyatcustomerby"
		THIS.Post Event ue_EmptyAtCustomerBYChanged( data )
		
	CASE "pickupbyby"
		THIS.Post Event ue_PickUpByByChanged ( data )
	
	CASE "cutoffby"
		THIS.Post Event ue_CutoffByChanged ( data )
	CASE "cutoffdate"
		THIS.event ue_getshipment( ).of_SetCutoffDate ( Date ( data ) )
	CASE "cutofftime"
		THIS.event ue_getshipment( ).of_SetCutoffTime ( Time ( data ) )
	CASE "lfdby"
		THIS.Post Event ue_lfdByChanged ( data )
	
	CASE "railbilledby"
		THIS.Post Event ue_railbilledByChanged ( data )
		
	CASE "bookingnumberby"
		THIS.Post Event ue_bookingNumberByChanged ( data )
		
	CASE "etaby"
		THIS.Post Event ue_etaByChanged ( data )

	CASE "pickupnumberby"
		THIS.Post Event ue_pickupnumberByChanged ( data )
		
	CASE "loadedatcustomerby"
		THIS.Post Event ue_loadedatcustomerByChanged ( data )
	
	CASE "railbillnumber"
		THIS.Post Event ue_railbillnumberChanged ( data )
	
	CASE "emptyatcustomerdate"
		THIS.post Event ue_emptyAtCustomerDateChanged( data )
		
END CHOOSE

// this code is used to trap the edit of a field and record who dunit
THIS.Post Event ue_RecordChange ( dwo.name , row)

RETURN ll_Return


end event

event ue_shiptypechanged;////OVerride because of the height commands

Boolean	lb_WasIntermodal
Long	ll_FoundRow
Long	ll_Return = 1
n_cst_LicenseManager	lnv_LicenseManager
n_cst_Ship_Type		lnv_ShipTypeManager
n_cst_ShipType			lnv_ShipType

//Dan modified 2-7-07 to use a new Priv Function if the shipment is billed
n_cst_beo_shipment	lnv_shipment
String	ls_privFunction

lnv_shipment = THIS.event ue_getshipment( ) 
IF lnv_shipment.of_isBilled( ) THEN
	ls_privFunction =  appeon_constant.cs_ModifyBilledShip
ELSE
	ls_privFunction = "ModifyShipment"
END IF
//////////////////
IF gnv_App.of_getprivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction , THIS.event ue_getshipment( ) ) = appeon_constant.ci_FALSE THEN
	RETURN 2
END IF


if lnv_ShipTypeManager.of_find( al_value , ll_foundrow) = 1 then
	
	if gds_shiptype.object.st_expedite[ll_foundrow] = "T" then
		this.setitem(1, "ds_expedite", "T")
//	elseif this.getitemstring(1, "ds_expedite") = "T" and ich_expedite = "F" then
//		this.setitem(1, "ds_expedite", "F")
	end if
	

	IF gnv_App.of_getprivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction, al_value  ) =  appeon_constant.ci_TRUE THEN
		lnv_ShipType = THIS.Event ue_GetShipType ( )
		IF isValid ( lnv_ShipType ) THEN
			lb_WasIntermodal = lnv_ShipType.of_GetIntermodal ( ) 
			
			IF lb_WasIntermodal THEN
				IF gds_shiptype.object.Intermodal[ll_foundrow] <> "T" THEN
					IF MessageBox ( "Shipment type", "You are changing from an intermodal shipment type to a non-intermodal shipment type. Are you sure you want to do this?" , QUESTION! , YESNO! , 2 ) = 1 THEN
	
					ELSE
						ll_Return = 2
	
					END IF					
				END IF
			ELSE
				IF gds_shiptype.object.Intermodal[ll_foundrow] = "T" THEN
					IF MessageBox ( "Shipment type", "You are changing from a non intermodal shipment type to an intermodal shipment type. Are you sure you want to do this?" , QUESTION! , YESNO! , 2 ) = 1 THEN
	
					ELSE
						ll_Return = 2
					END IF
				END IF
			END IF
		END IF
	ELSE
		MessageBox ( "Shipment type", "You cannot change the shipment type to one that you have not been granted rights to modify."  ) 
		ll_Return = 2
	END IF
	DESTROY ( lnv_ShipType ) 
				
end if

	
Return ll_Return


end event

event ue_sourcechanged;THIS.of_DetermineInitialContext ( )
end event

event itemerror;call super::itemerror;String	ls_ColumnType
Long	ll_Return 
Time	lt_Null

SetNull (lt_Null)

ll_Return = ANCESTORReturnValue
CHOOSE CASE dwo.name 
	
	CASE "movecode"	
		ll_Return = 1	
	
	CASE "releasetime"
		THIS.Post Event ue_ReleaseTimeChanged (lt_Null )
		
END CHOOSE 

RETURN ll_Return


end event

event buttonclicked;IF dwo.Name = "cb_hot" THEN
	
	If this.object.txt_restrict_ind.text  <> 'T' THEN		
		IF THIS.object.ds_expedite [row] = 'T' THEN
			THIS.object.ds_expedite [row] = 'F'
		ELSE
			THIS.object.ds_expedite [row] = 'T'
		END IF
	ELSE
		MessageBox ( "Hot Status" , "You are not authorized to change this status." )	
	END IF
	
END IF
end event

event ue_specialdatetime;// the item error was getting in the way of the same call in the item changed event
 //this code is used to trap the edit of a field and record who dunit
THIS.Event ue_RecordChange ( dwo.name , row)

Date		ld_ExistingShipDate
Date		ld_NewDate
String	ls_ColumnType
Long	ll_Return 

CHOOSE CASE dwo.name 
			
	CASE "pickupbytime"
		THIS.Event Post ue_PickupByTimeChanged ( )
		
	CASE "delbytime"
		THIS.Event Post ue_deliverBytimeChanged ( )
		
	CASE "delbydate"
		THIS.Event Post ue_deliverByDateChanged ( )
		
	CASE "lastfreedate" 	
		ld_NewDate = THIS.GetItemDate ( row , String ( dwo.name ) )
		
		n_cst_setting_setshipdate	lnv_SetDate
		lnv_SetDate = CREATE n_cst_setting_setshipdate
		IF lnv_SetDate.of_GetValue ( ) = lnv_SetDate.cs_yes THEN
			THIS.SetItem ( row , "ds_Ship_Date" , ld_NewDate  )
		END IF
		DESTROY ( lnv_SetDate )
		case "pickupbydate"
		
		//ld_ExistingShipDate = THIS.GetItemDate ( row , "ds_Ship_Date" ) 
		
		
		//IF dwo.name  = "pickupbydate" THEN
			THIS.Event Post ue_PickupByDateChanged ( )		
		//END IF
		
	CASE "releasedate"
		THIS.Post Event ue_ReleaseDateChanged( THIS.GetItemDate ( row , String ( dwo.name ) ) )
	CASE "releasetime"
		THIS.Post Event ue_ReleaseTimeChanged( THIS.GetItemTime ( row , String ( dwo.name ) ) )
		
		
		 
END CHOOSE 


RETURN 1

//CASE "lastfreedate" , "pickupbydate"
//		ld_ExistingShipDate = THIS.GetItemDate ( THIS.GEtRow ( ) , "ds_Ship_Date" ) 
//		ld_NewDate = Date ( data )
//		IF IsNull ( ld_ExistingShipDate ) OR ( ld_NewDate = ld_ExistingShipDate ) THEN
//			THIS.SetItem ( THIS.GEtRow ( ) , "ds_Ship_Date" , ld_NewDate  )
//		END IF
end event

event doubleclicked;Date	ld_Today
time	lt_Now
String	ls_ColumnType
String	ls_Data

n_cst_beo_Shipment	lnv_Shipment

ld_Today = Date ( DateTime ( Today ( )) ) 
lt_Now = Now ( )

lnv_Shipment = THIS.event ue_getshipment( )

IF isValid(lnv_Shipment) THEN
	IF lnv_Shipment.of_AllowEdit ( ) THEN
	
		IF Upper ( String ( dwo.type ) )  = "COLUMN" THEN
			ls_ColumnType = dwo.colType
			
			CHOOSE CASE UPPER ( ls_ColumnType )
					
				CASE  "DATE" 
					ls_Data = String ( ld_Today ) 
					this.setitem(row, String ( dwo.name ), ld_Today)
					//THIS.Post Event ue_RecordChange ( dwo.name , row)
					
				CASE "TIME"
					ls_Data = String ( lt_Now ) 
					this.setitem(row, String ( dwo.name ), lt_Now)
					//THIS.Post Event ue_RecordChange ( dwo.name , row)
					
				CASE "CHAR(32766)"
					
					IF Upper (  Right ( dwo.name , 2 )  ) = "BY" AND Upper ( dwo.name ) <> "DISPATCHEDBY" THEN
						this.setitem(row, String ( dwo.name ), "F" )
						ls_Data = "F"
						
						//THIS.Post Event ue_RecordChange ( dwo.name , row)
						
					END IF
					
			END CHOOSE
			
			IF Len ( ls_Data ) > 0 THEN
				THIS.Event ItemChanged ( row , dwo , ls_data )
			END IF
		
			
		END IF
	END IF
END IF
	

end event

on u_dw_intermodalshipinfo.create
end on

on u_dw_intermodalshipinfo.destroy
end on

event constructor;call super::constructor;n_cst_Privileges	lnv_Privs
THIS.Enabled = lnv_Privs.of_Hasentryrights( )
end event

