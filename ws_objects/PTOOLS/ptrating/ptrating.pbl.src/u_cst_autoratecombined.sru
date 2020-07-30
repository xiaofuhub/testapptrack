$PBExportHeader$u_cst_autoratecombined.sru
forward
global type u_cst_autoratecombined from u_base
end type
type cb_2 from commandbutton within u_cst_autoratecombined
end type
type cb_1 from commandbutton within u_cst_autoratecombined
end type
type gb_count from groupbox within u_cst_autoratecombined
end type
end forward

global type u_cst_autoratecombined from u_base
integer width = 576
integer height = 300
long backcolor = 12632256
event ue_next ( )
event ue_stop ( )
event ue_autorateon ( )
cb_2 cb_2
cb_1 cb_1
gb_count gb_count
end type
global u_cst_autoratecombined u_cst_autoratecombined

type variables
Int	ii_Count
Int	ii_Current

Private:
u_dw_Shipmentlist	idw_ShipList

long		il_autorateshipcount
long		ila_autorateid[]
long		ila_ratedid[]
long		ila_holdmarked[]
boolean	ib_autoratemode
n_cst_ratedata	inva_ratedata[], &
					inva_blankratedata[]
end variables

forward prototypes
public function integer of_settotalcount (integer ai_count)
public function integer of_setcounttext ()
public function integer of_setcurrentcount (integer ai_value)
public function integer of_setsource (ref u_dw_shipmentlist adw_shiplist)
public function integer of_autorate (long ala_autorateid[])
public subroutine of_autoratenext (long al_id)
end prototypes

event ue_next();THIS.of_autoratenext( 0 )
end event

event ue_autorateon();long	ll_ndx, &
		ll_count, &
		lla_blank[], &
		ll_return = 1
		
decimal	lc_total

//if already rated, clear old ids
ila_ratedid = lla_blank
ila_autorateid = lla_blank
if idw_shiplist.event ue_getselectedids(  ila_autorateid ) > 0 then
	//disable all controls
	//wf_disablecontrols()
	//enable dw
	THIS.enabled=true
	if of_autorate(ila_autorateid) = 1 then
	
		//add total charges for all rated items
		ll_count = upperbound(inva_ratedata)
		for ll_ndx = 1 to ll_count
			lc_total += inva_ratedata[ll_ndx].of_gettotalcharge()
		next
		if lc_total > 0 then
			ib_autoratemode = true
			messagebox('Auto Rating', "Total combined charge for shipments " +&
							string(lc_total,"$#,##0.00"))

			THIS.of_Settotalcount( il_autorateshipcount )
			THIS.of_SetCurrentcount( 0 )

		else
			messagebox('Auto Rating', "A zero charge was returned. Check rate table.")
			ll_return = -1 
		end if
		//check for a min/max return and inform user 
		if ll_count > 0 then
			if isvalid(inva_ratedata[1]) then
				if inva_ratedata[1].of_useminimum() then
					messagebox('Auto Rating', "The minimum amount was returned from the rate table. " +&
														"Assign this amount to the first shipment.")
				end if
				
				if inva_ratedata[1].of_usemaximum() then
					messagebox('Auto Rating', "The maximum amount was returned from the rate table. " +&
													"Assign this amount to the first shipment.")
				end if
			end if
		else
			messagebox('Auto Rating', "There are no matching rate types for the table you selected.")
			ll_return = -1
		end if				

	else
		ll_return = -1
	end if
	
	if ll_return = -1 then
		ll_count = upperbound(inva_ratedata)
		for ll_count = 1 to ll_ndx
			destroy inva_ratedata[ll_ndx]
		next

//				wf_enablecontrols()
		ib_autoratemode = false
//				gb_autorating.visible = false
//				st_autorating.visible = false
	end if
	
else
	THIS.event ue_stop( )
	messagebox("Auto Rating", "Please hightlight shipment(s) to auto rated.")
	
end if
		
IF ll_Return = -1 THEN
	THIS.event ue_stop( )
END IF

		

end event

public function integer of_settotalcount (integer ai_count);ii_count = ai_count

RETURN 1
end function

public function integer of_setcounttext ();gb_count.Text = String ( ii_current ) + " of " + String ( ii_count ) + " Rated"
RETURN 1
end function

public function integer of_setcurrentcount (integer ai_value);ii_current = ai_value
THIS.of_Setcounttext( )
RETURN 1
end function

public function integer of_setsource (ref u_dw_shipmentlist adw_shiplist);idw_shiplist = adw_shiplist
RETURN 1
end function

public function integer of_autorate (long ala_autorateid[]);integer	li_return = 1

long 	ll_beocount, &
		ll_ndx, &
		ll_errorcount

string	ls_errormessage

n_cst_bso_rating	lnv_rating
//n_cst_beo_item		lnva_item[]
n_cst_bso_dispatch	lnv_dispatch
n_cst_LicenseManager	lnv_LicenseManager
n_cst_beo_Shipment	lnva_Shipment[]
n_cst_OFRError	lnva_Errors[]

n_ds	lds_itemcache, &
		lds_EventCache, &
		lds_shipmentcache

IF lnv_LicenseManager.of_HasAutoRatingLicensed ( ) THEN
	lnv_rating = create n_cst_bso_rating
	il_autorateshipcount = idw_shiplist.event ue_getselectedids( ala_autorateid )
	
	if il_autorateshipcount > 0 then
		lnv_dispatch = create n_cst_bso_dispatch
		
		lnv_Dispatch.of_RetrieveShipments ( ala_autorateid )
		lds_ShipmentCache = lnv_Dispatch.of_GetShipmentCache ( )
		IF isValid ( lds_ShipmentCache ) THEN

			lds_ShipmentCache.SetSort ( "ds_id A" )
			lds_ShipmentCache.Sort ( )
			
			lds_eventCache = lnv_Dispatch.of_GeteventCache ( )
			IF isValid ( lds_eventCache ) THEN
				lds_EventCache.SetSort ( "de_shipment_id A, de_ship_seq A" )
				lds_EventCache.Sort ( )
			END IF
	
			lds_ItemCache = lnv_Dispatch.of_GetItemCache ( )
			IF isValid ( lds_ItemCache ) THEN
				lds_ItemCache.SetSort ( "di_shipment_id A, di_item_type D, di_item_id A " )
				lds_ItemCache.Sort ( )
			END IF
			
			ll_BeoCount = 0
			FOR ll_ndx = 1 TO il_autorateshipcount
				ll_BeoCount ++
				lnva_Shipment [ ll_BeoCount ] = CREATE n_cst_beo_Shipment
				lnva_Shipment [ ll_BeoCount ].of_SetSource ( lds_ShipmentCache )
				lnva_Shipment [ ll_BeoCount ].of_SetSourceId ( ala_autorateid [ ll_ndx ] )
				lnva_Shipment [ ll_BeoCount ].of_SetItemSource ( lds_ItemCache )
				lnva_Shipment [ ll_BeoCount ].of_SetEventSource ( lds_EventCache )
			NEXT
			
		end if
	end if
			
	if upperbound(lnva_shipment) > 0 then
		
		inva_ratedata = inva_blankratedata
		
		lnv_rating.ClearOFRErrors ( )
		if lnv_rating.of_autorate(lnva_Shipment, inva_rateData, n_cst_constants.ci_category_receivables, true /* combine freight*/ ) = 1 then
			lnv_rating.GetOFRErrors ( lnva_Errors )
			ll_errorcount = lnv_rating.GetErrorCount ( )
			//ll_errorcount = UpperBound ( lnva_Errors )
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
					messagebox("Auto Rating", ls_errormessage + "  Auto Rate mode will be stopped.")
					li_return = -1
					end if
				end if
			
			end if
			
		end if
	else
		li_return = -1
	end if
	
	if isvalid(lnv_dispatch) then
		destroy lnv_dispatch
	end if
	if isvalid(lnv_rating) then
		destroy lnv_rating
	end if

END IF

FOR ll_ndx = 1 TO ll_BeoCount
	DESTROY ( lnva_Shipment [ ll_Ndx ] )
NEXT

IF li_Return = -1 THEN
	THIS.event ue_stop( )
END IF
return li_return
end function

public subroutine of_autoratenext (long al_id);long	ll_count, &
		ll_ndx, &
		ll_newcount, &	
		lla_id[], &
		ll_id, &
		ll_foundrow, &
		ll_foundid
		
n_cst_ShipmentManager	lnv_ShipmentMgr
n_cst_anyarraysrv				lnv_Arraysrv
if al_id > 0 then
	ll_id = al_id
else
	if upperbound(ila_autorateid) > 0 then
		if ila_autorateid[1] > 0 then
			ll_id = ila_autorateid[1]
			ll_foundrow = idw_shiplist.find('ds_id = ' + string(ll_id), 1, idw_shiplist.rowcount())
			if ll_foundrow > 0 then
				//ok 
			else
				ll_id = 0
			end if
		end if
	end if
end if

if ll_id > 0 then
	lnv_ShipmentMgr.of_setautoratingmode(true)
	lnv_ShipmentMgr.of_setratedata(inva_ratedata)
	//this shipment will be automatically rated in the open event
	//mark it here as being rated
	ll_count = upperbound(ila_ratedid)
	if ll_count> 0 then
		ll_foundid = lnv_arraysrv.of_findlong(ila_ratedid, ll_id, 1, ll_count)
	end if
	if ll_foundid = 0 or isnull(ll_foundid) or ll_count = 0 then
		ila_ratedid[upperbound(ila_ratedid) + 1] = ll_id
		//remove from remaining list
		ll_count = upperbound(ila_autorateid)
		for ll_ndx = 1 to ll_count
			if ila_autorateid[ll_ndx] = ll_id then
				//skip
			else
				ll_newcount ++
				lla_id[ll_newcount] = ila_autorateid[ll_ndx]
			end if
		next
		ila_autorateid = lla_id
	end if
	lnv_ShipmentMgr.of_OpenShipment ( ll_id )
	THIS.of_SetCurrentcount( upperbound(ila_ratedid) )
else
	messagebox("Rating", "All shipments have been auto rated.")
	THIS.event ue_stop( )
end if

end subroutine

on u_cst_autoratecombined.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_count=create gb_count
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.gb_count
end on

on u_cst_autoratecombined.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_count)
end on

type cb_2 from commandbutton within u_cst_autoratecombined
integer x = 69
integer y = 172
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stop Rating"
end type

event clicked;Parent.Event ue_Stop ()
end event

type cb_1 from commandbutton within u_cst_autoratecombined
integer x = 69
integer y = 68
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Next"
end type

event clicked;Parent.event ue_next( )
end event

type gb_count from groupbox within u_cst_autoratecombined
integer width = 530
integer height = 288
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "0 of 0 Rated"
end type

