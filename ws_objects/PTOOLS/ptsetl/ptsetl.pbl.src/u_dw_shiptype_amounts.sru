$PBExportHeader$u_dw_shiptype_amounts.sru
forward
global type u_dw_shiptype_amounts from u_dw
end type
end forward

global type u_dw_shiptype_amounts from u_dw
integer width = 1038
integer height = 476
string dataobject = "d_shiptype_amounts"
end type
global u_dw_shiptype_amounts u_dw_shiptype_amounts

type variables
private:
integer	ii_included, &
			ii_processed
end variables

forward prototypes
public function integer of_loadshiptypes ()
public function integer of_entitychanged (n_cst_beo_itinerary2 anv_itinerary)
public function integer of_markshipmentprocessed (n_cst_beo_itinerary2 anv_itinerary)
public function integer of_markshipmenttypeincluded (n_cst_beo_itinerary2 anv_itinerary)
public function integer of_processallincluded (n_cst_beo_itinerary2 anv_itinerary)
public subroutine of_setprocessedcount (integer ai_value)
public subroutine of_setincludedcount (integer ai_value)
public function integer of_getincludedcount ()
public function integer of_getprocessedcount ()
end prototypes

public function integer of_loadshiptypes ();integer	li_return = 1
long 		ll_count, &
			ll_ndx, &
			lla_shiptypeId[], &
			ll_row

n_cst_ship_type lnv_cst_ship_type

this.reset()

if lnv_cst_ship_type.of_ready(true) = false then 
	li_return = -1
else
	
	ll_count = lnv_cst_ship_type.of_gettypelist('ALL', TRUE, lla_shiptypeid)

	for ll_ndx = 1 to ll_count
	
		ll_row = this.insertrow(0)
			if ll_row > 0 then
				this.object.shipmenttype[ll_row] = lla_shiptypeId[ll_ndx]
			end if
	next
	
end if

return li_return

end function

public function integer of_entitychanged (n_cst_beo_itinerary2 anv_itinerary);//need to update the display
//first if a shipment type was part of the drivers work then change
//bacground color to grey
//
//second get the eventcache and see if they all have amount ids
//check all the shipment types except those that are missing amounts

//reset window
long	ll_rowcount, &
		ll_ndx
		
ll_rowcount = this.rowcount()
for ll_ndx = 1 to ll_rowcount
	this.object.included[ll_ndx] = 0
	this.object.processed[ll_ndx] = 0
next

if this.of_Markshipmenttypeincluded(anv_Itinerary) < 0 then
	//problem, don't continue
else
	this.of_MarkshipmentProcessed(anv_Itinerary)
end if

return 1
end function

public function integer of_markshipmentprocessed (n_cst_beo_itinerary2 anv_itinerary);integer	li_return = 1, &
			li_processed

long		lla_EventId[], &
			lla_NoPay[], &
			ll_row, &
			ll_rowcount, &
			ll_ndx, &
			ll_count, &
			ll_shiptype, &
			ll_NoPaycount, &
			ll_found, &
			lla_shiptypes[]

decimal	lc_PaySplit

string	ls_Filter

n_cst_beo_Shipment	lnva_Shipment[]
n_ds		lds_Eventpay

if anv_Itinerary.of_GetEventids(lla_Eventid) > 0 then
	
	//take this list and see if they all have amountids in the paysplit table
	lds_EventPay = create n_ds
	lds_EventPay.dataobject = 'd_eventpay'
	lds_EventPay.SetTransObject(SQLCA)
	ll_rowcount = lds_EventPay.Retrieve(lla_Eventid)
	
	for ll_row = 1 to ll_rowcount
		lc_PaySplit = lds_Eventpay.object.paysplit[ll_row]
		if isnull(lc_PaySplit) or lc_PaySplit = 0 then
			//get the shipment id, this will not be checked
			ll_NoPaycount ++
			lla_NoPay[ll_NoPaycount] = lds_Eventpay.object.de_shipment_id[ll_row]
		end if
	next
	
	IF upperbound(lla_NoPay) > 0 then
		n_cst_anyarraysrv		lnv_Arraysrv
		
		lnv_Arraysrv.of_GetShrinked ( lla_NoPay, TRUE /*Shrink Nulls */, TRUE /*Shrink dupes */)
		
	end if
	
end if

if ll_NoPaycount > 0 then
	
	//get shiptype
	/* MFS - 5/7/07 - We dont need to retrieve the entire shipment here
	if anv_itinerary.of_GetShipment(lla_NoPay, lnva_Shipment) > 0 then
		anv_itinerary.of_GetShipmenttypes(lnva_Shipment, lla_shiptypes)
	end if
	*/
	/* MFS - 5/7/07 - Lets just get the ship types */
	anv_Itinerary.of_GetShipmentTypes(lla_NoPay, lla_ShipTypes)
	
end if
	
ll_rowcount = this.rowcount()

//first mark them all as processed
this.of_processallincluded( anv_itinerary)

//now loop through and unmark
ll_count = upperbound(lla_shiptypes)
for ll_ndx = 1 to ll_count
	ll_shiptype = lla_shiptypes[ll_ndx]
	if ll_shiptype > 0 then
		//look for the shiptype and check the box on that row
		ls_filter = 'shipmenttype = ' + string(ll_shiptype)
		ll_found = this.find(ls_filter, 1, ll_rowcount)
		if ll_found > 0 then
//			li_processed ++
			this.object.processed[ll_found] = 0
		end if
	end if
next

for ll_ndx = 1 to ll_rowcount
	if this.object.processed[ll_ndx] = 1 then
		li_processed ++
	end if
next


this.of_SetProcessedCount(li_Processed)

return li_return
end function

public function integer of_markshipmenttypeincluded (n_cst_beo_itinerary2 anv_itinerary);integer	li_return = 0, &
			li_included

long	lla_shiptypes[], &
		ll_shiptype, &
		ll_count, &
		ll_ndx, &
		ll_rowcount, &
		ll_found

string	ls_filter

anv_itinerary.of_GetShipmenttypes(lla_shiptypes)

ll_count = upperbound(lla_shiptypes)
ll_rowcount = this.rowcount()
for ll_ndx = 1 to ll_count
	ll_shiptype = lla_shiptypes[ll_ndx]
	if ll_shiptype > 0 then
		//look for the shiptype and set value so row will be gray
		ls_filter = 'shipmenttype = ' + string(ll_shiptype)
		ll_found = this.find(ls_filter, 1, ll_rowcount)
		if ll_found > 0 then
			li_included ++
			this.object.included[ll_found] = 1
		end if
	end if
next

this.of_SetIncludedCount(li_included)

return li_return
end function

public function integer of_processallincluded (n_cst_beo_itinerary2 anv_itinerary);//this will mark all the shiptypes that are included in the itinerary as processed
integer	li_return = 0

long	lla_shiptypes[], &
		ll_shiptype, &
		ll_count, &
		ll_ndx, &
		ll_rowcount, &
		ll_found

string	ls_filter

anv_itinerary.of_GetShipmenttypes(lla_shiptypes)

ll_count = upperbound(lla_shiptypes)
ll_rowcount = this.rowcount()
for ll_ndx = 1 to ll_count
	ll_shiptype = lla_shiptypes[ll_ndx]
	if ll_shiptype > 0 then
		//look for the shiptype and check the box on that row
		ls_filter = 'shipmenttype = ' + string(ll_shiptype)
		ll_found = this.find(ls_filter, 1, ll_rowcount)
		if ll_found > 0 then
			this.object.processed[ll_found] = 1
		end if
	end if
next



return li_return
end function

public subroutine of_setprocessedcount (integer ai_value);ii_processed = ai_value
end subroutine

public subroutine of_setincludedcount (integer ai_value);ii_included = ai_value
end subroutine

public function integer of_getincludedcount ();return ii_included
end function

public function integer of_getprocessedcount ();return ii_processed
end function

on u_dw_shiptype_amounts.create
end on

on u_dw_shiptype_amounts.destroy
end on

