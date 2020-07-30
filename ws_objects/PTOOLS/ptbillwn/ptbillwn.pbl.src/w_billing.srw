$PBExportHeader$w_billing.srw
$PBExportComments$PTBILL.     The billing window.
forward
global type w_billing from w_sheet
end type
type cb_resendedi from commandbutton within w_billing
end type
type cb_arbatch from commandbutton within w_billing
end type
type cbx_edi from checkbox within w_billing
end type
type st_autorating from statictext within w_billing
end type
type ddlb_shipmentsort from u_ddlb_shipmentsort within w_billing
end type
type cb_manifest from commandbutton within w_billing
end type
type cb_refresh from commandbutton within w_billing
end type
type st_refresh from statictext within w_billing
end type
type st_1 from statictext within w_billing
end type
type cb_mark_all from commandbutton within w_billing
end type
type cb_print from commandbutton within w_billing
end type
type cb_bill from commandbutton within w_billing
end type
type ddlb_ship_display from dropdownlistbox within w_billing
end type
type dw_ship_list from datawindow within w_billing
end type
type st_ship_sort from statictext within w_billing
end type
type st_ship_ind from statictext within w_billing
end type
type st_ships from statictext within w_billing
end type
type ddlb_dorb from dropdownlistbox within w_billing
end type
type st_display from statictext within w_billing
end type
type cb_preview from commandbutton within w_billing
end type
type st_preview from statictext within w_billing
end type
type dw_bill_manifest from u_dw_bill_manifest within w_billing
end type
type gb_autorating from groupbox within w_billing
end type
type st_cachecode from u_st_shipmentcachecode within w_billing
end type
type dw_bills from u_bills within w_billing
end type
type dw_labels from datawindow within w_billing
end type
type dw_letters from datawindow within w_billing
end type
end forward

global type w_billing from w_sheet
integer x = 214
integer y = 156
integer width = 3653
integer height = 2052
string title = "Billing"
string menuname = "m_billwin"
long backcolor = 12632256
event ue_autorateon ( )
event ue_autorateoff ( )
event ue_autoratenext ( )
cb_resendedi cb_resendedi
cb_arbatch cb_arbatch
cbx_edi cbx_edi
st_autorating st_autorating
ddlb_shipmentsort ddlb_shipmentsort
cb_manifest cb_manifest
cb_refresh cb_refresh
st_refresh st_refresh
st_1 st_1
cb_mark_all cb_mark_all
cb_print cb_print
cb_bill cb_bill
ddlb_ship_display ddlb_ship_display
dw_ship_list dw_ship_list
st_ship_sort st_ship_sort
st_ship_ind st_ship_ind
st_ships st_ships
ddlb_dorb ddlb_dorb
st_display st_display
cb_preview cb_preview
st_preview st_preview
dw_bill_manifest dw_bill_manifest
gb_autorating gb_autorating
st_cachecode st_cachecode
dw_bills dw_bills
dw_labels dw_labels
dw_letters dw_letters
end type
global w_billing w_billing

type variables
public:
char dorb
integer numships
n_cst_billing inv_cst_billing

protected:
n_cst_bso_dispatch		inv_dispatch
n_cst_toolmenu_manager inv_cst_toolmenu_manager
m_sheets		im_BillingMenu
long		il_autorateshipcount
long		ila_autorateid[]
long		ila_ratedid[]
long		ila_holdmarked[]
boolean		iba_originalcontrolstate[]
integer mboxret, nummarked, oppmarked
boolean justopened, ib_ignore_activate
boolean	ib_autoratemode
string brok_bill_list, disp_bill_list
datetime ship_update
string	is_savefilter
string	is_ARBatchType
s_longs preview_copies
n_cst_ratedata	inva_ratedata[], &
					inva_blankratedata[]
		
Private:
Boolean	ib_UsePassedIds
Long		ila_ShipmentIds[]	// this holds the ids passed in
Boolean	ib_resendEdi
end variables

forward prototypes
protected function integer set_display ()
protected function integer retr_lists ()
protected function integer reset_range (integer which_dw)
protected function integer scroll_bills ()
protected function long get_sel_id ()
protected function integer wf_get_marked (ref long ala_ids[])
protected subroutine wf_bill (string as_type)
private function long wf_markall (string as_criteria)
public function long wf_getselectedid (ref long ala_id[])
public function integer wf_create_toolmenu ()
public subroutine wf_process_request (string as_request)
public subroutine wf_autoratenext (long al_id)
public subroutine wf_disablecontrols ()
public subroutine wf_enablecontrols ()
public function integer wf_autorate (long ala_autorateid[])
public function integer wf_getmarkedshipments (ref n_cst_beo_shipment anva_shipments[])
public function integer wf_addcustom ()
public function string wf_getformatedshipids ()
public function integer wf_loadshipmentbeo (long ala_id[], ref n_cst_beo_shipment anva_shipment[])
protected subroutine wf_createarbatch (string as_type)
private function integer wf_verrifybillingformat ()
public function long wf_initializeresendedimode (n_cst_msg anv_msg)
public function integer wf_resendedi (long ala_ids[])
private function integer wf_enforcebillingprivs ()
end prototypes

event ue_autorateon;long	ll_ndx, &
		ll_count, &
		lla_blank[], &
		ll_return = 1
		
decimal	lc_total
if not ib_autoratemode then
		//if already rated, clear old ids
		ila_ratedid = lla_blank
		ila_autorateid = lla_blank
		if this.wf_getselectedid( ila_autorateid ) > 0 then
			//disable all controls
			wf_disablecontrols()
			//enable dw
			dw_ship_list.enabled=true
			if wf_autorate(ila_autorateid) = 1 then
			
				//add total charges for all rated items
				ll_count = upperbound(inva_ratedata)
				for ll_ndx = 1 to ll_count
					lc_total += inva_ratedata[ll_ndx].of_gettotalcharge()
				next
				if lc_total > 0 then
					ib_autoratemode = true
					messagebox('Auto Rating', "Total combined charge for shipments " +&
									string(lc_total,"$#,##0.00"))
		
					st_autorating.text=string(upperbound(ila_ratedid)) + " of " + string(il_autorateshipcount) + " Rated"
					gb_autorating.enabled = true
					gb_autorating.visible = true
					st_autorating.visible = true
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
	
				wf_enablecontrols()
				ib_autoratemode = false
				gb_autorating.visible = false
				st_autorating.visible = false
			end if
			
		else
			messagebox("Auto Rating", "Please hightlight shipment(s) to auto rated.")
		end if
	end if
end event

event ue_autorateoff;long	ll_Count, &
		ll_ndx
		
if ib_autoratemode then
	ll_count = upperbound(inva_ratedata)
	for ll_count = 1 to ll_ndx
		destroy inva_ratedata[ll_ndx]
	next

	wf_enablecontrols()
	ib_autoratemode = false
	gb_autorating.visible = false
	st_autorating.visible = false
end if
end event

event ue_autoratenext;if not ib_autoratemode then
	messagebox("Auto Rating", "You must start auto rate mode before you can rate shipments.")
else
	//open next shipment to be rated
	wf_autoratenext(0)
end if
end event

protected function integer set_display ();integer old_oppmarked
old_oppmarked = oppmarked
oppmarked = nummarked


String	ls_Filter, &
			ls_TypeList, &
			ls_Category, &
			ls_BillList, &
			ls_StatusList
n_cst_Ship_Type			lnv_ShipmentTypeManager


//Build the list of statuses we want to display
ls_StatusList = gc_Dispatch.cs_ShipmentStatus_Authorized +&
	gc_Dispatch.cs_ShipmentStatus_AuditRequired +&
	gc_Dispatch.cs_ShipmentStatus_Audited

//Set basic status condition for filter -- this will be extended below
ls_Filter = "pos('" + ls_StatusList + "', Shipment_BillingStatus) > 0"


IF dorb = "D" THEN
	ls_Category = "Dispatch"
	ls_BillList = disp_bill_list
ELSEIF dorb = "B" THEN
	ls_Category = "Brokerage"
	ls_BillList = brok_bill_list
ELSE
	RETURN -1
END IF


CHOOSE CASE ls_Category

CASE "All"
	//No additional filter restrictions required.

	//Can't currently happen here -- kept for relation to u_ship_filter.set_filter code

CASE "Dispatch", "Brokerage"

	CHOOSE CASE lnv_ShipmentTypeManager.of_GetTypeList ( Upper ( ls_Category ), FALSE, ls_TypeList )

	CASE IS >= 0

		//Pad either end of type list with ", " to allow pattern matching of the type list string throughout
		ls_TypeList = ", " + ls_TypeList + ", "

		//Add the pattern match condition to the filter.
		ls_Filter = '( IsNull ( Shipment_ShipTypeId ) OR Match ( "' + ls_TypeList + '", ", " + String ( Shipment_ShipTypeId ) + ", " ) ) and ' + ls_Filter

		IF ib_usepassedids THEN
			n_cst_sql	lnv_Sql
			lnv_Sql.of_makestringinclause( ila_shipmentids 	)
			
			ls_Filter += " AND ds_id " + lnv_Sql.of_makeinclause( ila_shipmentids )
		
		END IF



	CASE ELSE
		//Error

	END CHOOSE

CASE ELSE
	//Unexpected Value.

END CHOOSE


dw_Ship_List.SetFilter ( ls_Filter )
dw_Ship_List.Modify ( "txt_bill_list.text = '" + ls_BillList + "'" )

is_SaveFilter = ls_Filter
if retr_lists() = 0 then
	if st_preview.visible then
		dw_bills.visible = false
		st_preview.visible = false
		cb_preview.visible = true
		cb_print.enabled = false
	end if
	dw_ship_list.setredraw(false)
	
	dw_ship_list.filter()
	dw_ship_list.sort()
	dw_ship_list.setredraw(true)
	numships = dw_ship_list.rowcount()
	nummarked = old_oppmarked
	reset_range(2)
end if

//Enforce Billing privs
This.wf_EnforceBillingPrivs( )


return 1
end function

protected function integer retr_lists ();/*
Both of the lists, brok_bill_list And disp_bill_list Hold the same ids.

Modified by dan to stop refreshes if this window was opened in resend edi mode
*/


n_cst_ShipmentManager lnv_ShipmentMgr
n_ds lds_Ships
lds_Ships = lnv_ShipmentMgr.of_Get_DS_Ship( )

IF not IB_resendedi THEN

	if ship_update = lnv_ShipmentMgr.of_Get_Updated_Ships( ) then
		return 0
	elseif lnv_ShipmentMgr.of_Get_Retrieved_Ships( ) = false then
		if gf_refresh("SHIP") = -1 then
			if justopened then
				messagebox("Billing Window", "Could not retrieve shipment list from database.~n~n"+&
					"Please retry.", exclamation!)
				close(this)
				return -1
			else
				return 0 //This should probably be handled better, but I don't think this 
							//circumstance is possible anyway.
			end if
		end if
	end if
	
	if st_preview.visible then
		dw_bills.visible = false
		st_preview.visible = false
		cb_preview.visible = true
		cb_print.enabled = false
	end if
	
	long foundrow, selship, ll_ndx, ll_autocount
	
	foundrow = dw_ship_list.getselectedrow(0)
	if foundrow > 0 then selship = dw_ship_list.object.ds_id[foundrow]
	
	dw_ship_list.setredraw(false)
	dw_ship_list.reset()
	if lds_Ships.rowcount() > 0 then
		lds_Ships.rowscopy(1, lds_Ships.rowcount(), primary!, dw_ship_list, 9999, primary!)
		dw_ship_list.filter()
		dw_ship_list.sort()
	end if
	
	//Added 3.5.15 BKW
	//Update the cache code display to reflect any cache view selection change.
	st_CacheCode.Event ue_Refresh ( )
	
	numships = dw_ship_list.rowcount()
	
	if numships > 0 and selship > 0 then
		foundrow = dw_ship_list.find("ds_id = " + string(selship), 1, numships)
		if foundrow > 0 then
			dw_ship_list.selectrow(foundrow, true)
			dw_ship_list.scrolltorow(foundrow)
		end if
		if ib_autoratemode then
			ll_autocount = upperbound(ila_autorateid)
			for ll_ndx = 1 to ll_autocount
				foundrow = dw_ship_list.find("ds_id = " + string(ila_autorateid[ll_ndx]), 1, numships)
				if foundrow > 0 then
					dw_ship_list.selectrow(foundrow, true)
				end if
			next
		end if
	end if
	
	dw_ship_list.setredraw(true)
	ship_update = lnv_ShipmentMgr.of_Get_Updated_Ships( )
	st_refresh.text = string(time(lnv_ShipmentMgr.of_Get_Refreshed_Ships( )), "h:mma/p")
	
	nummarked = 0
	
	//IF ib_usepassedids THEN
	//	brok_bill_list = THIS.wf_Getformatedshipids( )
	//	disp_bill_list = THIS.wf_Getformatedshipids( )
	//END IF
	Long	lla_Temp[]
	nummarked = THIS.wf_Get_marked( lla_Temp )
	
	//string this_bill_list
	//if dorb = "D" then this_bill_list = disp_bill_list else this_bill_list = brok_bill_list
	//
	//if numships > 0 then
	//	integer curq, nextq, numgone, numaudreq
	//	long bill_id
	//	curq = 1
	//	do while curq < len(this_bill_list)
	//		nextq = pos(this_bill_list, "q", curq + 1)
	//		if nextq > 0 then 
	//			bill_id = long(mid(this_bill_list, curq + 1, (nextq - curq) - 1))
	//			foundrow = dw_ship_list.find("ds_id = " + string(bill_id), 1, numships)
	//			if foundrow > 0 then
	//				if dw_ship_list.object.Shipment_BillingStatus[foundrow] = gc_Dispatch.cs_ShipmentStatus_AuditRequired then
	//					numaudreq ++
	//					this_bill_list = replace(this_bill_list, curq + 1, nextq - curq, "")
	//				else
	//					curq = nextq
	//					nummarked ++
	//				end if
	//			else
	//				numgone ++
	//				this_bill_list = replace(this_bill_list, curq + 1, nextq - curq, "")
	//			end if
	//		else
	//			exit
	//		end if
	//	loop
	//	if numgone + numaudreq > 0 then
	//		string msgstr
	//		if numgone > 0 then msgstr += string(numgone) + " of the shipments you had "+&
	//			"marked are no longer in the list.~n~n"
	//		if numaudreq > 0 then msgstr += string(numaudreq) + " of the shipments you had "+&
	//			"marked have been changed to 'Audit Required.'~n~n"
	//		msgstr += "These shipments will be unmarked."
	//		mboxret = 1
	//		messagebox("Status Changes", msgstr)
	//	end if
	//elseif len(this_bill_list) > 1 then
	//	this_bill_list = "q"
	//	numgone = 1
	//	mboxret = 1
	//	messagebox("Status Changes", "The shipments you had marked for billing are "+&
	//		"no longer in the list.~n~nYour selections will be removed.")
	//end if
	//
	//if numgone + numaudreq > 0 then
	//	dw_ship_list.modify("txt_bill_list.text = '" + this_bill_list + "'")
	//	dw_ship_list.setredraw(true)
	//	if dorb = "D" then disp_bill_list = this_bill_list else brok_bill_list = this_bill_list
	//end if
	
	reset_range(2)
	END IF
return 1
end function

protected function integer reset_range (integer which_dw);integer firstrow, lastrow
string new_range
decimal	lc_TotalCharges

firstrow = integer(dw_ship_list.describe("datawindow.firstrowonpage"))
lastrow = integer(dw_ship_list.describe("datawindow.lastrowonpage"))
lc_TotalCharges = dec ( dw_ship_list.describe ( "evaluate('sum(if(comp_marked=1,shipment_netcharges,0) for all)', 1)" ) )

new_range = string(firstrow) + " to " + string(lastrow) + " of " + string(numships) + &
	" \ " + string(nummarked) + " : " + String ( lc_TotalCharges, "$0.00" ) + " marked"

st_ship_ind.text = new_range

return 1
end function

protected function integer scroll_bills ();long selid[1]
selid[1] = get_sel_id()
if selid[1] < 1 then goto failure

//dw_bills must be visible (and not off the screen!) in order for the firstrowonpage
//calculations for the nest to work properly.  The next four lines tuck it behind
//dw_ship_list, so it's "visible" without being seen
dw_bills.x += this.width
dw_bills.visible = true
dw_ship_list.visible = true
dw_bills.x -= this.width

if dw_bills.of_retrieve(selid) = 1 then
else
	mboxret = 1
	messagebox("Preview Bills", "Could not retrieve preview information from database."+&
		"~n~nPreview cancelled.", exclamation!)
	dw_ship_list.setredraw(true) //I don't know what this is for.
	goto failure
end if

dw_bills.visible = true //brings it to top
cb_preview.visible = false
st_preview.visible = true
cb_print.enabled = true
return 1

failure:
dw_bills.visible = false
st_preview.visible = false
cb_preview.visible = true
cb_print.enabled = false
return -1
end function

protected function long get_sel_id ();long selrow, selid
selrow = dw_ship_list.getselectedrow(0)
if selrow < 1 then return -1

selid = dw_ship_list.getitemnumber(selrow, "ds_id")
if selid > 0 then return selid else return -1
end function

protected function integer wf_get_marked (ref long ala_ids[]);long ll_rowcount, ll_foundrow, lla_ids[]
datawindow ldw_target

ldw_target = dw_ship_list
ll_rowcount = ldw_target.rowcount()

ll_foundrow = 0

do
	ll_foundrow = ldw_target.find("comp_marked = 1", ll_foundrow + 1, ll_rowcount)
	if ll_foundrow > 0 then lla_ids[upperbound(lla_ids) + 1] = &
		ldw_target.object.ds_id[ll_foundrow]
loop while ll_foundrow > 0 and ll_foundrow < ll_rowcount

ala_ids = lla_ids

return upperbound(ala_ids)
end function

protected subroutine wf_bill (string as_type);//Expecting "INVOICE!", "INVOICE_EDI!" or "MANIFEST!" for as_type

long lla_ids[]
string ls_message_header
integer li_result
n_cst_msg	lnv_Msg
S_parm	lstr_Parm
Boolean	lb_ProcessEDI = FALSE
Int	i
Int	li_Count
Integer	li_PrebillRtn

n_cst_beo_Shipment	lnva_Shipments[]

//If "INVOICE_EDI!" was requested, flag lb_ProcessEDI and then perform remaining processing
//as "INVOICE!"
if cbx_edi.checked then
	lb_ProcessEDI = TRUE
end if

//IF as_Type = "INVOICE_EDI!" THEN
//	lb_ProcessEDI = TRUE
//	as_Type = "INVOICE!"
//END IF

ls_message_header = inv_cst_billing.of_get_message_header(as_type)

//Commented the code below but it could be removed. The code below it does the same thing. Also There is no
//need to get the Ids and pass them to of_bill because of_bill gets the ids from 
//the shipment beos. nwl 12/15/04

//if not wf_get_marked(lla_ids) > 0 then
//	mboxret = 1
//	messagebox(ls_message_header, "No shipments are marked.")
//	return
//end if

//lstr_Parm.is_Label = "IDS"
//lstr_Parm.ia_Value = lla_ids
//lnv_msg.of_Add_Parm ( lstr_Parm ) 

IF THIS.wf_GetmarkedShipments ( lnva_Shipments ) > 0 THEN
	lstr_Parm.is_Label = "SHIPMENTS"
	lstr_Parm.ia_Value = lnva_Shipments
	lnv_Msg.of_Add_Parm	( lstr_Parm )
ELSE
	mboxret = 1
	messagebox(ls_message_header, "No shipments are marked.")
	return	
END IF


IF THIS.wf_verrifybillingformat( ) <> 1 THEN  // currently this check that edi bills are not mixed in with regular bills
	RETURN // message in the function
END IF



ib_ignore_activate = true

choose case as_type
case "INVOICE!"

	//dw_bills must be visible (and not off the screen!) in order for the firstrowonpage
	//calculations for the nest to work properly.  The next four lines tuck it behind
	//dw_ship_list, so it's "visible" without being seen
	dw_bills.x += this.width
	dw_bills.visible = true
	dw_ship_list.visible = true
	dw_bills.x -= this.width

case "MANIFEST!"

	//dw_bill_manifest must be visible (and not off the screen!) in order for the firstrowonpage
	//calculations for the nest to work properly.  Keep this in mind if it gets a preview mode.
	
	dw_bills.visible = false

end choose

st_preview.visible = false
cb_preview.visible = true
cb_print.enabled = false
dw_ship_list.selectrow(0, false)

lstr_Parm.is_Label = "TYPE"
lstr_Parm.ia_Value = as_Type
lnv_msg.of_Add_Parm ( lstr_Parm ) 

//Need to know if brokerage for payables process in of_bill of n_cst_billing
lstr_Parm.is_Label = "CATEGORY"
IF dorb = "D" THEN
	lstr_Parm.ia_Value = "DISPATCH"
ELSEIF dorb = "B" THEN
	lstr_Parm.ia_Value = "BROKERAGE"
ELSE
	lstr_Parm.ia_Value = ''
END IF
lnv_msg.of_Add_Parm ( lstr_Parm ) 
//

lstr_Parm.is_Label = "PROCESSEDI"
lstr_Parm.ia_Value = lb_ProcessEDI
lnv_msg.of_Add_Parm ( lstr_Parm ) 


li_PreBillRtn = inv_cst_billing.of_prebill( lnv_msg)
IF li_PreBillRtn <> -1 THEN
	li_result = inv_cst_billing.of_bill( lnv_msg )

	// zmc - 2-19-04 refresh the DW
	IF li_Result = 0 THEN
		retr_lists()
	END IF
	
	if as_type = "INVOICE!" then dw_bills.visible = false
	
	ib_ignore_activate = false
	
	if li_result = 1 then
		if dorb = "D" then disp_bill_list = "q" else brok_bill_list = "q"
		retr_lists()
	end if
	
END IF

li_Count = UpperBound ( lnva_Shipments )
FOR i = 1 TO li_Count
	DESTROY ( lnva_Shipments[i] )
NEXT
	
end subroutine

private function long wf_markall (string as_criteria);Long	ll_Count, &
		ll_RowCount, &
		ll_MarkLoop, &
		ll_NumSkipped, &
		ll_FoundRow, &
		ll_Id
Boolean	lb_Criteria
String	ls_BillList, &
			ls_AddList


ll_RowCount = dw_Ship_List.RowCount ( )


if ll_RowCount < 1 then

	mboxret = 1
	messagebox("Mark All Shipments", "No shipments are available to mark.")

ELSE

	dw_bills.visible = false
	dw_ship_list.selectrow(0, false)
	
	if dorb = "D" then ls_BillList = disp_bill_list &
		else ls_BillList = brok_bill_list


	IF Len ( Trim ( as_Criteria ) ) > 0 THEN
		lb_Criteria = TRUE
	END IF


	DO

		IF lb_Criteria THEN
			ll_FoundRow = dw_Ship_List.Find ( as_Criteria, ll_FoundRow + 1, ll_RowCount )
		ELSE
			ll_FoundRow ++
		END IF

		IF ll_FoundRow > 0 THEN

			if not dw_ship_list.object.Shipment_BillingStatus[ll_FoundRow] = gc_Dispatch.cs_ShipmentStatus_AuditRequired then

				ll_Id = dw_Ship_List.Object.ds_Id [ ll_FoundRow ]
				ls_AddList = String ( ll_Id ) + "q"

				IF Pos ( ls_BillList, "q" + ls_AddList ) > 0 THEN
					//Bill is already marked.  Ignore it.
				ELSE
					ls_BillList += ls_AddList
					ll_Count ++
					nummarked ++
				END IF

			else
				ll_NumSkipped ++
			end if

		END IF

	LOOP WHILE ll_FoundRow > 0 AND ll_FoundRow < ll_RowCount

	
	dw_ship_list.modify("txt_bill_list.text = '" + ls_BillList + "'")
	dw_ship_list.setredraw(true)
	if dorb = "D" then disp_bill_list = ls_BillList else brok_bill_list = ls_BillList
	reset_range(2)
	
	if ll_NumSkipped > 0 then
		mboxret = 1
		messagebox("Mark All Shipments", string(ll_NumSkipped) + " shipments were skipped "+&
			"because their status is 'Audit Required'.")
	end if

end if

RETURN ll_Count
end function

public function long wf_getselectedid (ref long ala_id[]);Long	ll_SelectedCount, &
		lla_SelectedIds[], &
		ll_Row

DO

	ll_Row = dw_ship_list.GetSelectedRow ( ll_Row )

	IF ll_Row > 0 THEN
		ll_SelectedCount ++
		lla_SelectedIds [ ll_SelectedCount ] = dw_ship_list.Object.ds_id [ ll_Row ]
	END IF

LOOP WHILE ll_Row > 0

ala_Id = lla_SelectedIds

RETURN ll_SelectedCount
end function

public function integer wf_create_toolmenu ();// RDT 11/27/02 added authorization reply processing 

n_cst_LicenseManager	lnv_LicenseManager
n_cst_privileges	lnv_privileges
s_toolmenu lstr_toolmenu

if isvalid(inv_cst_toolmenu_manager) then return 0

inv_cst_toolmenu_manager = create n_cst_toolmenu_manager

this.changemenu(im_BillingMenu)
gf_mask_menu(im_BillingMenu)
this.inv_cst_toolmenu_manager.of_set_target_menu(im_BillingMenu.m_current)

inv_cst_toolmenu_manager.of_set_parent(this)

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating  ) THEN
	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "AUTORATEON!"
	lstr_toolmenu.s_menuitem_text = "Star&t AutoRate Mode"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
	
	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "AUTORATEOFF!"
	lstr_toolmenu.s_menuitem_text = "Sto&p AutoRate Mode"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
	
	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "AUTORATENEXT!"
	lstr_toolmenu.s_menuitem_text = "AutoRate &Next Shipment"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

END IF

// RDT 11/27/02  - Start
IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_module_notification) THEN
	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "AUTHORIZEREPLY!"
	lstr_toolmenu.s_menuitem_text = "&Authorization Replies"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
End IF
// RDT 11/27/02  - End 

return 1
end function

public subroutine wf_process_request (string as_request);// RDT 11/27/02 added "AUTHORIZEREPLY!" processing 
long	ll_ndx, &
		ll_count, &
		lla_blank[], &
		ll_return = 1
		
decimal	lc_total
n_cst_LicenseManager	lnv_LicenseManager
choose case as_request

case "AUTORATEON!"
	
	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_AutoRating, "E" ) >= 0 THEN
		THIS.Event ue_AutoRateOn ( )
	END IF
	
case "AUTORATEOFF!"
	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_AutoRating, "E" ) >= 0 THEN
		THIS.Event ue_AutoRateOff ( )
	END IF
	
case "AUTORATENEXT!"
	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_AutoRating, "E" ) >= 0 THEN
		THIS.Event ue_AutoRateNext ( )
	END IF

case "AUTHORIZEREPLY!"
	Opensheet( w_Authorization , gnv_App.of_GetFrame ( ), 0, LAYERED! )


end choose
end subroutine

public subroutine wf_autoratenext (long al_id);long	ll_count, &
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
			ll_foundrow = dw_ship_list.find('ds_id = ' + string(ll_id), 1, dw_ship_list.rowcount())
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
	st_autorating.text=string(upperbound(ila_ratedid)) + " of " + string(il_autorateshipcount) + " Rated"
else
	messagebox("Rating", "All shipments have been auto rated.")
end if

end subroutine

public subroutine wf_disablecontrols ();graphicobject 	stp_obj
object 			type_obj

long	ll_ControlCount, &
		ll_ndx

boolean	lb_switch, &
			lb_disable

ll_ControlCount = UpperBound(Control[])
	
for ll_ndx = 1 to ll_ControlCount
	
	type_obj = Control[ll_ndx].TypeOf()
	stp_obj = Control[ll_ndx]
	choose case type_obj
			
		case GroupBox!
			groupbox	lo_groupbox
			lo_groupbox = stp_obj
			lb_switch = lo_groupbox.enabled
			lo_groupbox.enabled = lb_disable

		case dropdownlistbox!
			dropdownlistbox	lo_dropdownlistbox
			lo_dropdownlistbox = stp_obj
			lb_switch = lo_dropdownlistbox.enabled
			lo_dropdownlistbox.enabled = lb_disable
			
		case commandbutton!
			commandbutton	lo_commandbutton
			lo_commandbutton = stp_obj
			lb_switch = lo_commandbutton.enabled
			lo_commandbutton.enabled = lb_disable
			
		case datawindow!
			datawindow	lo_datawindow
			lo_datawindow = stp_obj
			lb_switch = lo_datawindow.enabled
			lo_datawindow.enabled = lb_disable
			
		case checkbox!
			checkbox	lo_checkbox
			lo_checkbox = stp_obj
			lb_switch = lo_checkbox.enabled
			lo_checkbox.enabled = lb_disable
			
	end choose
	
	iba_originalcontrolstate[ll_ndx] = lb_switch
	
next




end subroutine

public subroutine wf_enablecontrols ();graphicobject 	stp_obj
object 			type_obj

long	ll_ControlCount, &
		ll_ndx

boolean	lb_switch, &
			lb_disable

ll_ControlCount = UpperBound(Control[])
	
for ll_ndx = 1 to ll_ControlCount
	
	type_obj = Control[ll_ndx].TypeOf()
	stp_obj = Control[ll_ndx]
	choose case type_obj
			
		case GroupBox!
			groupbox	lo_groupbox
			lo_groupbox = stp_obj
			lb_switch = lo_groupbox.enabled
			lo_groupbox.enabled = iba_originalcontrolstate[ll_ndx]

		case dropdownlistbox!
			dropdownlistbox	lo_dropdownlistbox
			lo_dropdownlistbox = stp_obj
			lb_switch = lo_dropdownlistbox.enabled
			lo_dropdownlistbox.enabled = iba_originalcontrolstate[ll_ndx]
			
		case commandbutton!
			commandbutton	lo_commandbutton
			lo_commandbutton = stp_obj
			lb_switch = lo_commandbutton.enabled
			lo_commandbutton.enabled = iba_originalcontrolstate[ll_ndx]
			
		case datawindow!
			datawindow	lo_datawindow
			lo_datawindow = stp_obj
			lb_switch = lo_datawindow.enabled
			lo_datawindow.enabled = iba_originalcontrolstate[ll_ndx]
			
		case checkbox!
			checkbox	lo_checkbox
			lo_checkbox = stp_obj
			lb_switch = lo_checkbox.enabled
			lo_checkbox.enabled = iba_originalcontrolstate[ll_ndx]
			
	end choose
	
next




end subroutine

public function integer wf_autorate (long ala_autorateid[]);integer	li_return = 1

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
	il_autorateshipcount = this.wf_getselectedid( ala_autorateid )
	
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

return li_return
end function

public function integer wf_getmarkedshipments (ref n_cst_beo_shipment anva_shipments[]);Long	ll_Count
Long 	i
Long	lla_ids[]
long	ll_beocount

n_cst_beo_shipment	lnva_Shipments[]
n_ds	lds_ShipmentCache,&
		lds_EventCache, &
		lds_ItemCache

inv_dispatch = create n_cst_bso_dispatch

ll_Count = THIS.wf_Get_Marked ( lla_Ids )

this.wf_LoadShipmentBEO(lla_ids, lnva_Shipments)

anva_shipments = lnva_Shipments

RETURN UpperBound ( anva_shipments )

end function

public function integer wf_addcustom ();String	ls_CustomColumn
Int		li_Return 

ls_CustomColumn = ProfileString ( gnv_app.of_getappinifile( ) , "custombilling" , "column1", "" )

IF Len ( ls_CustomColumn ) > 0 THEN
	li_Return = 1
	dw_ship_list.Modify ( 'create column(band=detail id='+ ls_CustomColumn +' alignment="0" tabsequence=32766 border="0" color="0" x="3565" y="12" height="52" width="1174" format="[general]"  name=shipment_custom1 edit.limit=0 edit.case=any edit.autoselect=yes  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127"' )  
	dw_Ship_list.hscrollbar = TRUE
END IF

RETURN li_Return
end function

public function string wf_getformatedshipids ();String	ls_Return

n_cst_String	lnv_String

lnv_String.of_ArrayToString( ila_shipmentids , 'q', ls_Return  )
ls_Return = 'q' + ls_Return + 'q'

RETURN ls_Return

end function

public function integer wf_loadshipmentbeo (long ala_id[], ref n_cst_beo_shipment anva_shipment[]);Long	ll_Count
Long 	i
long	ll_beocount

n_cst_beo_shipment	lnva_Shipments[]
n_ds	lds_ShipmentCache,&
		lds_EventCache, &
		lds_ItemCache

// Has already been created once in the calling method.
IF Not IsValid(inv_dispatch) THEN
	inv_dispatch = create n_cst_bso_dispatch
END IF

ll_Count = upperbound(ala_Id)

//inv_dispatch.of_retrieveshipments(ala_id) // Commneted by zmc - 3-8-04 // was not retrieving ids for parents & children. hence commented. 
inv_dispatch.of_retrieveshipmentsplits(ala_id) // zmc - retrieves shipmentids for both parent as well as children.
lds_ShipmentCache = inv_dispatch.of_GetShipmentCache ( )

IF isValid ( lds_ShipmentCache ) THEN
	lds_ShipmentCache.SetFilter ( "" )
	lds_ShipmentCache.SetSort ( "ds_id A" )
	lds_ShipmentCache.Filter ( )
	lds_ShipmentCache.Sort ( )
	
	lds_eventCache = inv_dispatch.of_GeteventCache ( )
	IF isValid ( lds_eventCache ) THEN
		lds_EventCache.SetFilter ( "" )
		lds_EventCache.SetSort ( "de_shipment_id A, de_ship_seq A" )
		lds_EventCache.Filter ( )
		lds_EventCache.Sort ( )
	END IF

	lds_ItemCache = inv_dispatch.of_GetItemCache ( )
	IF isValid ( lds_ItemCache ) THEN
		lds_ItemCache.SetFilter ( "" )
		lds_ItemCache.SetSort ( "di_shipment_id A, di_item_type D, di_item_id A " )
		lds_ItemCache.Filter ( )
		lds_ItemCache.Sort ( )
	END IF
	
	FOR i = 1 TO ll_Count

			ll_BeoCount ++
			// destroyed in wf_bill
			lnva_Shipments[ll_BeoCount] = CREATE n_cst_beo_Shipment
			lnva_Shipments[ll_BeoCount].of_SetSource ( lds_ShipmentCache )
			lnva_Shipments[ll_BeoCount].of_SetSourceId ( ala_Id [ i ] )
			lnva_Shipments[ll_BeoCount].of_SetEventSource ( lds_EventCache )
			lnva_Shipments[ll_BeoCount].of_SetItemSource ( lds_ItemCache )
			
	NEXT
end if

anva_shipment = lnva_Shipments

//destroy inv_dispatch

RETURN UpperBound ( anva_shipment[] )

end function

protected subroutine wf_createarbatch (string as_type);//Expecting "INVOICE!", "INVOICE_EDI!" or "MANIFEST!" for as_type

string ls_message_header
n_cst_msg	lnv_Msg
S_parm	lstr_Parm
Int	i
Int	li_Count
Int	li_Return = 1

n_cst_beo_Shipment	lnva_Shipments[]

ls_message_header = inv_cst_billing.of_get_message_header(as_type)

ib_ignore_activate = true

choose case as_type
case "INVOICE!"

	//dw_bills must be visible (and not off the screen!) in order for the firstrowonpage
	//calculations for the nest to work properly.  The next four lines tuck it behind
	//dw_ship_list, so it's "visible" without being seen
	dw_bills.x += this.width
	dw_bills.visible = true
	dw_ship_list.visible = true
	dw_bills.x -= this.width

case "MANIFEST!"

	//dw_bill_manifest must be visible (and not off the screen!) in order for the firstrowonpage
	//calculations for the nest to work properly.  Keep this in mind if it gets a preview mode.
	
	dw_bills.visible = false

end choose

//Commented the code below but it could be removed. There is no
//need to pass the ids to of_bill because of_bill gets the ids from 
//the shipment beos. nwl 12/15/04


//lstr_Parm.is_Label = "IDS"
//lstr_Parm.ia_Value = ila_ShipmentIds
//lnv_msg.of_Add_Parm ( lstr_Parm ) 

lstr_Parm.is_Label = "TYPE"
lstr_Parm.ia_Value = as_Type
lnv_msg.of_Add_Parm ( lstr_Parm ) 

//Need to know if brokerage for payables process in of_bill of n_cst_billing
lstr_Parm.is_Label = "CATEGORY"
IF dorb = "D" THEN
	lstr_Parm.ia_Value = "DISPATCH"
ELSEIF dorb = "B" THEN
	lstr_Parm.ia_Value = "BROKERAGE"
ELSE
	lstr_Parm.ia_Value = ''
END IF
lnv_msg.of_Add_Parm ( lstr_Parm ) 
//

IF this.wf_LoadShipmentBEO(ila_Shipmentids, lnva_Shipments ) > 0 THEN
	lstr_Parm.is_Label = "SHIPMENTS"
	lstr_Parm.ia_Value = lnva_Shipments
	lnv_Msg.of_Add_Parm	( lstr_Parm )
END IF

lstr_Parm.is_Label = "ARBATCH"
lnv_Msg.of_Add_Parm	( lstr_Parm )


IF inv_cst_billing.of_bill( lnv_msg ) = 1 THEN
	MessageBox ("AR Batch" , "Batching was successful!" )
ELSE
	MessageBox ("AR Batch" , "An error occurred while processing the AR Batch." )
	li_return = -1
END IF

if as_type = "INVOICE!" then dw_bills.visible = false

li_Count = UpperBound ( lnva_Shipments )
FOR i = 1 TO li_Count
	DESTROY ( lnva_Shipments[i] )
NEXT

if li_return = 1 then
	post close(this)
end if
end subroutine

private function integer wf_verrifybillingformat ();// this is used to determine if the user is billing companies that have been setup for EDI 210 in a non-EDI format (standard billing).
//Returns 1 = no problems
//		  -1 stop billing

Long	ll_ProfileCount
Boolean	lb_Found
Long	ll_EDICompany
Long	ll_RowCount
Long  i
Int	li_Return = 1


DataStore lds_210Profile
n_Cst_LicenseManager	lnv_Licman

IF lnv_LicMan.of_HasEdi210license( ) AND Not cbx_edi.Checked  THEN
	n_cst_edi_transaction_210	lnv_transaction210
	lnv_transaction210 = create n_cst_edi_transaction_210
//	lds_210PRofile = lnv_transaction210.of_GetProfile()
//	ll_profilecount = lds_210PRofile.retrieve()
	
	Long	lla_210Companies[]
	
	ll_profilecount = lnv_transaction210.of_Get210companies( lla_210Companies )
	
	// see if any of the marked bills should be billed via Edi 
	ll_RowCount = dw_Ship_List.RowCount ( )
	
	
	
	FOR i = 1 TO ll_ProfileCount
	
		ll_EDICompany = lla_210Companies[i]
		IF dw_Ship_List.Find('billto_id = ' + string(ll_EDICompany) + " And comp_marked = 1" , 1, ll_RowCount ) > 0 THEN
			lb_Found = TRUE
			li_Return = -1  // problem found, we should warn the user
			EXIT
			
		END IF
	NEXT
	
	
	IF lb_Found THEN 
				
		IF MessageBox ( "EDI Bills" , "The shipments you have marked for billing include companies setup for EDI. If you continue, no EDI transactions will be generated. Do you want to continue?" , QUESTION! , YESNO! , 2 ) = 1 THEN
			li_Return = 1 // the user wants to continue anyway.
		END IF
	END IF
	
	DESTROY ( lnv_transaction210 )
	
END IF
	

RETURN li_Return


end function

public function long wf_initializeresendedimode (n_cst_msg anv_msg);//written by dan 5-8-2006

Int	ll_return = 1
String		ls_originalSelect
String		ls_modString
String		ls_sql
Long			ll_rows
S_Parm		lstr_Parm

IF isValid( anv_msg ) THEN
	IF anv_Msg.of_get_parm( "SHIPMENTIDS", lstr_Parm) > 0 THEN
		ila_shipmentids = lstr_Parm.ia_Value
	END IF
ELSE 
	ll_return  = -1
END IF

IF ll_return  = 1 THEN
	dw_ship_list.SetTransObject(SQLCA)
	n_cst_sql	lnv_Sql
	ls_OriginalSelect =dw_ship_list.Describe("DataWindow.Table.Select")
	ls_SQL = " where ds_id " + lnv_Sql.of_makeinclause( ila_shipmentids )

	ls_ModString = "DataWindow.Table.Select='" + ls_OriginalSelect + ls_sql + "'"

	IF dw_ship_list.Modify(ls_ModString) = "" THEN
		ll_rows = dw_ship_list.Retrieve()
		commit;
		if ll_rows > 0 then
			ll_return  = ll_rows
		END IF
	END IF
END IF

RETURN ll_return
end function

public function integer wf_resendedi (long ala_ids[]);//written by Dan 5-9-2006

n_cst_Beo_Shipment				lnva_Shipments[]
n_cst_bso_EDIManager				lnv_EDIManager		
n_cst_setting_edi204version	lnv_204Version
int									li_return
Long				ll_index
Long				ll_max
n_cst_setting_produce210edi	lnv_setting

lnv_setting	= create n_cst_setting_produce210edi

lnv_ediManager = CREATE n_cst_bso_EDIManager

IF not ISValid( inv_dispatch) THEN
	inv_dispatch = create n_cst_bso_dispatch
END IF
	
inv_dispatch.of_getShipments( ala_ids, lnva_shipments)

ll_max  = upperBound( lnva_Shipments )
IF ll_max > 0 THEN
	lnv_EDIManager.of_AddtoPendingCache ( lnva_Shipments, 'SHIPMENT', appeon_constant.cl_transaction_set_210, 'BILL' )
	if lnv_EDIManager.of_Saveeventcache( ) = 1 then
		
		lnv_204Version = create n_cst_setting_edi204version
		//THIS CONDITION ALSO MUST BE PUT ON n_cst_billing.of_bill()
		IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
			lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
			//it will be handled by the scheduler
			IF lnv_setting.of_GetValue( ) = lnv_setting.cs_yes THEN
				lnv_EDIManager.of_Generate ( appeon_constant.cl_transaction_set_210, ala_ids )
			END IF
		ELSE
			//it is being handled by something else so it can be genereated automatically.
			lnv_EDIManager.of_Generate ( appeon_constant.cl_transaction_set_210, ala_ids )
		END IF
		lnv_EDIManager.of_SaveEventCache()
	else
		//do we stop process??
	end if
END IF

//cleanup
FOR ll_index = 1 TO ll_max
	IF isValid( lnva_shipments[ll_index] ) THEN
		DESTROY lnva_shipments[ll_index]
	END IF
NEXT

IF ISVALID(lnv_204version) THEN
	DESTROY lnv_204Version
END IF
DESTROY lnv_ediManager
DESTROY lnv_setting
RETURN li_return
end function

private function integer wf_enforcebillingprivs ();//Enforce billing priv 'BillShipment'
Integer	li_Return
Long	i
Long	ll_RowCount
Long	ll_ShipType
n_cst_PrivsManager	lnv_PrivManager

lnv_PrivManager = gnv_App.of_GetPrivsManager( )

dw_ship_list.SetRedraw(FALSE)

ll_Rowcount = dw_ship_list.RowCount()
FOR i = ll_Rowcount TO 1 STEP -1
	ll_ShipType = dw_ship_list.Object.shipment_shiptypeid[i]
	IF lnv_PrivManager.of_GetUserPermissionFromFn(lnv_PrivManager.cs_BillShipment, ll_ShipType) <> 1 THEN
		IF dw_ship_list.RowsDiscard(i, i, Primary!) <> 1 THEN
			li_Return = -1
			EXIT
		END IF
	END IF
NEXT

dw_ship_list.SetRedraw(TRUE)

Return li_Return
end function

event open;call super::open;//modified by dan to operate with the resending of edi stuff 5-8-2006

String		ls_OriginalSelect, &
				ls_ModString, &
				ls_SQL
Boolean		lb_ARBarch
//Boolean		lb_ResendEdi


n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

n_cst_privsmanager lnv_manager		//added by dan 1-29-07

IF IsValid ( Message.PowerobjectParm ) THEN
	If UPPER( Message.PowerObjectParm.ClassName ( ) ) = "N_CST_MSG" Then 
		lnv_Msg = Message.PowerobjectParm
	End If

END IF

justopened = true

ib_disableclosequery = TRUE
THIS.of_Setresize( TRUE )
inv_Resize.of_register( dw_ship_list, inv_resize.scalerightbottom )

THIS.Width = gnv_app.of_getframe( ).Width - 50


//		see if we need to use the shipmentids passed in
IF isValid ( lnv_Msg ) THEN
	IF lnv_Msg.of_get_parm( "SHIPMENTIDS", lstr_Parm) > 0 THEN
		ila_shipmentids = lstr_Parm.ia_Value
	END IF
END IF

//		see if we are recreating an AR BATCH
IF isValid ( lnv_Msg ) THEN
	IF lnv_Msg.of_get_parm( "ARBATCH", lstr_Parm) > 0 THEN
		lb_ARBarch = TRUE
		ib_ignore_activate = TRUE
	END IF
END IF
IF isValid ( lnv_Msg ) THEN
	IF lnv_Msg.of_get_parm( "TYPE", lstr_Parm) > 0 THEN
		is_ARBatchType = lstr_Parm.ia_Value
	END IF
END IF

//Added by dan - see if we are resending edi
IF isValid ( lnv_Msg ) THEN
	IF lnv_Msg.of_get_parm( "RESENDEDI", lstr_Parm) > 0 THEN
		ib_resendEdi = true
		cb_refresh.enabled = false
	END IF
END IF
//--------------------------------------

ib_usepassedids = UpperBound ( ila_Shipmentids ) > 0

IF ib_usepassedids THEN
	THIS.Title = "Billing using submitted shipments"
END IF

//IF ib_usepassedids THEN
//	brok_bill_list = THIS.wf_Getformatedshipids( )
//	disp_bill_list = THIS.wf_Getformatedshipids( )
//END IF
Long	lla_Temp[]
nummarked = THIS.wf_Get_marked( lla_Temp )
//


inv_cst_billing = create n_cst_billing
dw_bills.of_set_manager(inv_cst_billing)
dw_bill_manifest.of_set_manager(inv_cst_billing)

this.x = 1
this.y = 1

gf_mask_menu(m_billwin)

n_cst_LicenseManager	lnv_LicenseManager
Char	lch_Dorb
Boolean	lb_OrderEntry, &
			lb_Brokerage, &
			lb_Dispatch, &
			lb_Billing, &
			lb_EDI, &
			lb_autorating

lb_OrderEntry = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_OrderEntry )
lb_Brokerage = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage )
lb_Dispatch = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch )
lb_Billing = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Billing )
lb_EDI = lnv_LicenseManager.of_hasedi210license( )
lb_autorating = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating )

IF lb_Dispatch THEN
	lch_Dorb = "D"
ELSEIF lb_Brokerage THEN
	lch_Dorb = "B"
//	lch_Dorb = "D"  //Brokerage Merge   --  Changed back in release 2.5.00
ELSEIF lb_Billing OR lb_OrderEntry THEN
	lch_Dorb = "D"
ELSE
	lnv_LicenseManager.of_DisplayModuleNotice ( "Billing" )
	Close ( This )
	RETURN
END IF

//	Request a lock for user
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Billing, "E" ) < 0 THEN
	close (this)
	return
END IF

n_cst_ShipmentManager	lnv_ShipmentMgr
lnv_ShipmentMgr.of_PopulateReferenceLists ( dw_Ship_List )


///////////////////////////////
//Populate shipment type list

n_cst_Ship_Type			lnv_ShipType
DWObject						ldwo_ShipType

ldwo_ShipType = dw_Ship_List.Object.Shipment_ShipTypeId
lnv_ShipType.of_Populate ( ldwo_ShipType )
DESTROY ldwo_ShipType

///////////////////////////////

///////////////////////////////
//Hide shipment progress indicator if AllowRestrictActive = FALSE

n_cst_beo_Shipment		lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment

IF lnv_Shipment.of_AllowRestrictActive ( ) = FALSE THEN
	//Force billing is off.  Hide the status bar -- everything will be completed anyway
	dw_Ship_List.Modify ( "r_test.y = 100" )
ELSE
	dw_Ship_List.Modify ( "r_test.width = 190" )  //Added 3-6-b3 BKW  Size the row hlt down to just the ds_id field
																//This is to enhance readability -- very difficult with completed hlt.
END IF


IF NOT gnv_app.of_getprivsmanager( ).of_useadvancedprivs( ) THEN
	if g_max_permit >= "T" then
	
		cb_mark_all.enabled = true
		cb_bill.enabled = true
		cb_manifest.enabled = true
	
		IF lb_EDI THEN
			cbx_edi.enabled = TRUE
	//		cb_BillEDI.Enabled = TRUE
		END IF
	
	end if
ELSE
	cb_mark_all.enabled = true
	cb_bill.enabled = true
	cb_manifest.enabled = true

	IF lb_EDI THEN
		cbx_edi.enabled = TRUE
//		cb_BillEDI.Enabled = TRUE
	END IF
	
END IF

//dw_ship_list.settransobject(sqlca)
//dw_bills.settransobject(sqlca)
dw_labels.settransobject(sqlca)
dw_letters.settransobject(sqlca)

dw_ship_list.modify("txt_bill_mode.text = 'T'")
brok_bill_list = "q"
disp_bill_list = "q"

setnull(ship_update)

integer setloop

preview_copies.longar[1] = 1
preview_copies.longar[5] = 0
for setloop = 2 to 5
	setnull(preview_copies.longar[setloop])
next

dorb = lch_Dorb
IF lch_Dorb = "B" THEN    //Couldn't happen with original brokerage merge changes -- can again in 2.5.00
	ddlb_dorb.selectitem(2)
ELSE
	ddlb_dorb.selectitem(1)
END IF
ddlb_ship_display.selectitem(2)
dw_ship_list.modify("txt_disp_ind.text = 'T'")

IF lb_ARBarch THEN
	//retrive dw
	dw_ship_list.SetTransObject(SQLCA)
	n_cst_sql	lnv_Sql
	ls_OriginalSelect =dw_ship_list.Describe("DataWindow.Table.Select")
	ls_SQL = " where ds_id " + lnv_Sql.of_makeinclause( ila_shipmentids )

	ls_ModString = "DataWindow.Table.Select='" + ls_OriginalSelect + ls_sql + "'"

	IF dw_ship_list.Modify(ls_ModString) = "" THEN
		if dw_ship_list.Retrieve() > 0 then
			cb_arbatch.x=1719
			cb_arbatch.y=168
			cb_arbatch.visible = true
			cb_bill.enabled=false
			cb_preview.enabled=false
			cb_manifest.enabled=false
			cbx_edi.enabled=false
			cb_mark_all.enabled=false
			cb_refresh.enabled=false
			ddlb_Dorb.enabled=false
			ddlb_Dorb.Reset( )
			st_cachecode.enabled=false
		end if
	ELSE
		MessageBox("Status", "Modify Failed" )
	END IF
	

ELSEIF ib_resendEdi THEN
	IF this.wf_initializeresendedimode( lnv_Msg ) > 0 THEN	//added by dan
		
		cb_resendedi.visible = true
		cb_resendedi.enabled = true
		cb_arbatch.visible = FALSE
		cb_resendedi.x=1719
		cb_resendedi.y=168
		cb_bill.enabled=false
		cb_preview.enabled=false
		cb_manifest.enabled=false
		cbx_edi.enabled=false
		cbx_edi.checked = true
		cb_mark_all.enabled=false
		cb_refresh.enabled=false
		ddlb_Dorb.enabled=false
		ddlb_Dorb.Reset( )
		st_cachecode.enabled=false
	END IF
ELSE
	
	cb_arbatch.visible = FALSE
	set_display()
END IF

wf_create_toolmenu()


/*	Eliminated this disablement entirely for 2.5.00
	Both "Dispatch" and "Brokerage" types are supported regardless of license.
//IF ( lch_Dorb = "D" AND NOT lb_Brokerage ) THEN
	//Commented for brokerage merge
	ddlb_dorb.enabled = false
//END IF
*/

//dw_bills.modify("datawindow.print.preview.zoom = 75")
//dw_bills.modify("datawindow.print.paper.source = 1")


DESTROY ( lnv_Shipment )


//ADDED BY DAN 1-29-07
lnv_manager = gnv_app.of_GetPrivsmanager( )
IF lnv_manager.of_getuserpermissionfromfn( "View Billing Window") <> 1 THEN
	Messagebox("Billing", "You do not have permission to view this window.", exclamation!)
	close (this)
END IF
///////////




end event

event activate;call super::activate;if mboxret = 1 then
	mboxret = 0
	return
end if

if ib_ignore_activate then return

if justopened then justopened = false else retr_lists()
end event

event key;call super::key;if numships < 1 then return

boolean shiftpress
shiftpress = keydown(keyshift!)

integer curselrow, newselrow
curselrow = dw_ship_list.getselectedrow(0)
if curselrow < 1 then return

if keydown(keyuparrow!) then
	if curselrow > 1 then
		if shiftpress then
			newselrow = dw_ship_list.find("comp_marked = 1", curselrow - 1, 1)
		else
			newselrow = curselrow - 1
		end if
	end if
elseif keydown(keydownarrow!) then
	if curselrow < numships then
		if shiftpress then
			newselrow = dw_ship_list.find("comp_marked = 1", curselrow + 1, numships)
		else
			newselrow = curselrow + 1
		end if
	end if
elseif keydown(keyleftarrow!) then
	if st_preview.visible then dw_bills.scrollpage(-1)
elseif keydown(keyrightarrow!) then
	if st_preview.visible then dw_bills.scrollpage(1)
end if

if newselrow > 0 and not curselrow = newselrow then
	dw_ship_list.selectrow(curselrow, false)
	dw_ship_list.selectrow(newselrow, true)
	if st_preview.visible then scroll_bills()
end if
end event

on w_billing.create
int iCurrent
call super::create
if this.MenuName = "m_billwin" then this.MenuID = create m_billwin
this.cb_resendedi=create cb_resendedi
this.cb_arbatch=create cb_arbatch
this.cbx_edi=create cbx_edi
this.st_autorating=create st_autorating
this.ddlb_shipmentsort=create ddlb_shipmentsort
this.cb_manifest=create cb_manifest
this.cb_refresh=create cb_refresh
this.st_refresh=create st_refresh
this.st_1=create st_1
this.cb_mark_all=create cb_mark_all
this.cb_print=create cb_print
this.cb_bill=create cb_bill
this.ddlb_ship_display=create ddlb_ship_display
this.dw_ship_list=create dw_ship_list
this.st_ship_sort=create st_ship_sort
this.st_ship_ind=create st_ship_ind
this.st_ships=create st_ships
this.ddlb_dorb=create ddlb_dorb
this.st_display=create st_display
this.cb_preview=create cb_preview
this.st_preview=create st_preview
this.dw_bill_manifest=create dw_bill_manifest
this.gb_autorating=create gb_autorating
this.st_cachecode=create st_cachecode
this.dw_bills=create dw_bills
this.dw_labels=create dw_labels
this.dw_letters=create dw_letters
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_resendedi
this.Control[iCurrent+2]=this.cb_arbatch
this.Control[iCurrent+3]=this.cbx_edi
this.Control[iCurrent+4]=this.st_autorating
this.Control[iCurrent+5]=this.ddlb_shipmentsort
this.Control[iCurrent+6]=this.cb_manifest
this.Control[iCurrent+7]=this.cb_refresh
this.Control[iCurrent+8]=this.st_refresh
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.cb_mark_all
this.Control[iCurrent+11]=this.cb_print
this.Control[iCurrent+12]=this.cb_bill
this.Control[iCurrent+13]=this.ddlb_ship_display
this.Control[iCurrent+14]=this.dw_ship_list
this.Control[iCurrent+15]=this.st_ship_sort
this.Control[iCurrent+16]=this.st_ship_ind
this.Control[iCurrent+17]=this.st_ships
this.Control[iCurrent+18]=this.ddlb_dorb
this.Control[iCurrent+19]=this.st_display
this.Control[iCurrent+20]=this.cb_preview
this.Control[iCurrent+21]=this.st_preview
this.Control[iCurrent+22]=this.dw_bill_manifest
this.Control[iCurrent+23]=this.gb_autorating
this.Control[iCurrent+24]=this.st_cachecode
this.Control[iCurrent+25]=this.dw_bills
this.Control[iCurrent+26]=this.dw_labels
this.Control[iCurrent+27]=this.dw_letters
end on

on w_billing.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_resendedi)
destroy(this.cb_arbatch)
destroy(this.cbx_edi)
destroy(this.st_autorating)
destroy(this.ddlb_shipmentsort)
destroy(this.cb_manifest)
destroy(this.cb_refresh)
destroy(this.st_refresh)
destroy(this.st_1)
destroy(this.cb_mark_all)
destroy(this.cb_print)
destroy(this.cb_bill)
destroy(this.ddlb_ship_display)
destroy(this.dw_ship_list)
destroy(this.st_ship_sort)
destroy(this.st_ship_ind)
destroy(this.st_ships)
destroy(this.ddlb_dorb)
destroy(this.st_display)
destroy(this.cb_preview)
destroy(this.st_preview)
destroy(this.dw_bill_manifest)
destroy(this.gb_autorating)
destroy(this.st_cachecode)
destroy(this.dw_bills)
destroy(this.dw_labels)
destroy(this.dw_letters)
end on

event close;call super::close;destroy inv_cst_billing
destroy inv_cst_toolmenu_manager
if isvalid(inv_dispatch) then
	destroy inv_dispatch
end if
end event

type cb_resendedi from commandbutton within w_billing
boolean visible = false
integer x = 2368
integer y = 52
integer width = 389
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Resend EDI"
end type

event clicked;wf_resendedi( ila_shipmentids )
end event

type cb_arbatch from commandbutton within w_billing
integer x = 2857
integer y = 68
integer width = 389
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "AR Batch"
end type

event clicked;String	ls_Message
Boolean	lb_Continue = TRUE

n_cst_LicenseManager	lnv_Lic


IF lnv_Lic.of_Getlicensed( n_Cst_Constants.ci_module_brokerage ) THEN
	ls_Message = "Carrier payables will not be processed during the export of the AR Batch. Do you want to continue?" 
	lb_Continue =  MessageBox ( "AR Batch" , ls_Message, QUESTION! , YESNO! , 1 ) = 1
END IF

IF lb_Continue THEN
	Parent.wf_CreateARBatch(is_ARBatchType) 
END IF


end event

type cbx_edi from checkbox within w_billing
integer x = 1376
integer y = 172
integer width = 288
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "EDI Bills"
end type

event clicked;long		ll_RowCount, &
			ll_index, &
			ll_Billtoid, &
			lla_id[], &
			ll_found, &
			ll_profilecount

string	ls_filter, &
			ls_EDI210code
boolean	lb_continue

n_ds			lds_210PRofile

n_cst_Sql	lnv_Sql
n_cst_anyarraysrv	lnv_Arraysrv
n_cst_edi_transaction_210	lnv_transaction210




if this.checked then

	if  wf_get_marked(ila_holdmarked) > 0 then
		choose case messagebox("EDI Bills", "All currently marked bills will be unmarked.",information!,okcancel!,1)
			case 1
				nummarked = 0
				dw_ship_list.modify("txt_bill_list.text = ''")
				dw_ship_list.setredraw(true)
				if dorb = "D" then disp_bill_list = 'q' else brok_bill_list = 'q'
				reset_range(2)
				lb_continue = true
			case 2
				this.checked=false
		end choose	
	else
		lb_continue = true
	end if

	if lb_continue then
		
		lnv_transaction210 = create n_cst_edi_transaction_210
		//lds_210PRofile = lnv_transaction210.of_GetProfile()
		Long	lla_210Companies[]
		ll_Profilecount = lnv_transaction210.of_Get210companies( lla_id )
//		ll_profilecount = lds_210PRofile.retrieve()


//		ll_RowCount = dw_Ship_List.RowCount ( )
		
//		for ll_index = 1 to ll_RowCount
//			
//			ll_Billtoid = dw_Ship_List.object.billto_id[ll_index]
//			
//			if ll_profilecount > 0  then
//				ll_found = lds_210Profile.find('companyid = ' + string(ll_billtoid), 1, ll_profilecount )
//				//site
//				if ll_found > 0  then
//					//edi
//					lla_Id[upperbound(lla_id) + 1] = ll_Billtoid
//				end if
//			
//			end if			
//			
//		next

		destroy lnv_transaction210
		
		if upperbound(lla_id) > 0 then
			//eliminate dupes
			lnv_arraysrv.of_getshrinked ( lla_id,TRUE,TRUE)
			ls_filter = is_savefilter + " and billto_id" + lnv_Sql.of_MakeInClause ( lla_Id )
			dw_Ship_List.SetFilter ( ls_Filter )
			dw_Ship_List.Filter()
		else
			messagebox("EDI Bills", "There are currently no EDI bills.")
			this.checked=false
		end if
	end if

else
		dw_Ship_List.SetFilter (is_savefilter)
		dw_Ship_List.Filter()

end if

cb_manifest.Enabled = NOT THIS.Checked 

//wf_bill("INVOICE_EDI!")
end event

type st_autorating from statictext within w_billing
boolean visible = false
integer x = 2149
integer y = 68
integer width = 466
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "1 of 10 Rated"
boolean focusrectangle = false
end type

type ddlb_shipmentsort from u_ddlb_shipmentsort within w_billing
integer x = 1454
integer y = 16
integer taborder = 10
end type

event getfocus;dw_bills.visible = false

//Commented 2.5.03
//if numships > 0 then dw_ship_list.selectrow(0, false)
end event

event ue_processchange;call super::ue_processchange;dw_Ship_List.SetSort ( as_Sort )
dw_Ship_List.Sort ( )

if dw_ship_list.getselectedrow(0) > 0 then &
	dw_ship_list.scrolltorow(dw_ship_list.getselectedrow(0))

reset_range(2)
end event

type cb_manifest from commandbutton within w_billing
integer x = 3232
integer y = 168
integer width = 361
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Manifest"
end type

event clicked;wf_bill("MANIFEST!")
end event

type cb_refresh from commandbutton within w_billing
event clicked pbm_bnclicked
integer x = 3346
integer y = 16
integer width = 247
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Refresh"
end type

event clicked;if gf_refresh("SHIP") = 1 then
	retr_lists()
else
	messagebox("Refresh", "Could not retrieve information from database." +&
		"~n~nPlease retry.", exclamation!)
end if
end event

type st_refresh from statictext within w_billing
integer x = 3081
integer y = 24
integer width = 247
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 29425663
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_billing
integer x = 2674
integer y = 32
integer width = 389
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Last Refresh:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_mark_all from commandbutton within w_billing
integer x = 2478
integer y = 168
integer width = 361
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Mark All"
end type

event clicked;	wf_MarkAll ( "" )

//if numships < 1 then
//	mboxret = 1
//	messagebox("Mark All Shipments", "No shipments are available to mark.")
//	return
//end if
//
//dw_bills.visible = false
//dw_ship_list.selectrow(0, false)
//
//string new_bill_list = "q"
//integer markloop, numskipped
//
//for markloop = 1 to numships
//	if not dw_ship_list.object.ds_status[markloop] = "Q" then
//		new_bill_list += string(dw_ship_list.object.ds_id[markloop]) + "q"
//	else
//		numskipped ++
//	end if
//next
//
//dw_ship_list.modify("txt_bill_list.text = '" + new_bill_list + "'")
//dw_ship_list.setredraw(true)
//if dorb = "D" then disp_bill_list = new_bill_list else brok_bill_list = new_bill_list
//nummarked = numships - numskipped
//reset_range(2)
//
//if numskipped > 0 then
//	mboxret = 1
//	messagebox("Mark All Shipments", string(numskipped) + " shipments were skipped "+&
//		"because their status is 'Audit Required'.")
//end if
end event

type cb_print from commandbutton within w_billing
integer x = 2130
integer y = 168
integer width = 329
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Print Copy"
end type

event clicked;s_longs lstr_selection

ib_ignore_activate = true

if inv_cst_billing.of_get_copies(preview_copies, lstr_selection) then
	preview_copies = lstr_selection
	inv_cst_billing.of_print(dw_bills, preview_copies)
end if

ib_ignore_activate = false
end event

type cb_bill from commandbutton within w_billing
integer x = 2857
integer y = 168
integer width = 361
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Bill"
end type

event clicked;////condition added by dan to make sure that billing by edi will only contain one company id.
//Boolean lb_continue
//Long	ll_index
//Long	ll_max
//Long	ll_marked
//Long	ll_billto1
//Long	ll_billTo2
//IF cbx_edi.checked THEN
//	lb_continue = true
//	ll_max = dw_ship_list.rowcount( )
//	FOR ll_index = 1 TO ll_max
//		ll_marked = dw_ship_list.getItemNumber( ll_index, "comp_marked")
//		IF ll_marked = 1 THEN
//			IF ll_billto1 = 0 THEN
//				//get the first one that the rest should match
//				ll_billto1 = dw_ship_list.getItemNumber( ll_index, "billto_id" )
//			ELSE
//				ll_billto2 = dw_ship_list.getItemNumber( ll_index, "billto_id" )
//			END IF
//			
//			IF ll_billTo1 <> ll_billTo2 AND ll_billto2 <> 0 THEN
//				lb_continue = false
//				Messagebox("Billing", "All selected bill to companies must be the same for edi billing. No bills sent.", EXCLAMATION!)
//				EXIT
//			END IF
//		END IF
//	NEXT
//ELSE
//	lb_continue = true
//END IF
//
//IF lb_continue THEN
	wf_bill("INVOICE!")
//END IF
end event

type ddlb_ship_display from dropdownlistbox within w_billing
integer x = 690
integer y = 16
integer width = 475
integer height = 464
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Locations","Billing Info","Intermodal"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;dw_ship_list.Object.DataWindow.header.height=80
choose case this.text
	case "Locations"
		dw_ship_list.modify("txt_disp_ind.text = 'L'")
	case "Intermodal"
		dw_ship_list.modify("txt_disp_ind.text = 'I'")
		dw_ship_list.Object.DataWindow.header.height=140
	case "Billing Info"
		dw_ship_list.modify("txt_disp_ind.text = 'T'")
end choose

dw_ship_list.setredraw(true)
end event

event getfocus;dw_bills.visible = false

//Commented 2.5.03
//if numships > 0 then dw_ship_list.selectrow(0, false)
end event

type dw_ship_list from datawindow within w_billing
integer x = 9
integer y = 276
integer width = 3593
integer height = 1584
string dataobject = "d_bill_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;st_preview.setfocus()

if numships < 1 then return

integer clobjrow, tabpos, idpos  //, curselrow
string clobj, idstr, this_bill_list

clobj = this.getobjectatpointer()

tabpos = pos(clobj, "~t")

if tabpos > 0 then
	clobjrow = integer(mid(clobj, tabpos + 1))
	clobj = left(clobj, tabpos - 1)
end if

//curselrow = this.getselectedrow(0)
//this.selectrow(0, false)

if ib_autoratemode then
	//
else
	if clobj = "r_to_bill" and clobjrow = row then
		dw_bills.visible = false
		long clid
		clid = this.object.ds_id[row]
		if clid > 0 then
			if dorb = "D" then this_bill_list = disp_bill_list &
				else this_bill_list = brok_bill_list
			idstr = string(clid) + "q"
			idpos = pos(this_bill_list, "q" + idstr)
			if idpos > 0 then
				this_bill_list = replace(this_bill_list, idpos + 1, len(idstr), "")
				nummarked --
			else
				if this.object.Shipment_BillingStatus[row] = gc_Dispatch.cs_ShipmentStatus_AuditRequired then
					mboxret = 1
					messagebox("Mark Shipment for Billing", "Cannot mark a shipment whose "+&
						"status is 'Audit Required'.")
					return
				end if
				this_bill_list += idstr
				nummarked ++
			end if
			this.modify("txt_bill_list.text = '" + this_bill_list + "'")
			this.setredraw(true)
			if dorb = "D" then disp_bill_list = this_bill_list &
				else brok_bill_list = this_bill_list
			reset_range(2)
		end if
		return
	
	ELSE
			gf_MultiSelect ( This, Row )
	END IF
//if this.getselectedrow(0) > 0 then
	if st_preview.visible then
//		if curselrow = this.getselectedrow(0) and dw_bills.visible then
//			dw_bills.visible = false
//		else
			scroll_bills()
//		end if
	end if
//else
//	dw_bills.visible = false
//end if
end if
end event

on dberror;mboxret = 1
end on

on scrollvertical;reset_range(2)
end on

event rbuttondown;string ls_object_name, ls_IdColumn, lsa_parm_labels[]
any laa_parm_values[]
Integer	li_Check
n_cst_numerical lnv_numerical
Long	ll_CompanyId, &
		ll_TypeId
String	ls_RefText, &
			ls_Selection

IF Upper ( dwo.Type ) = "DATAWINDOW" THEN

	lsa_Parm_Labels [1] = "ADD_ITEM"
	laa_Parm_Values [1] = "&Print"

	lsa_Parm_Labels [2] = "ADD_ITEM"
	laa_Parm_Values [2] = "E&xport"

	CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values)

	CASE "PRINT"
		li_Check = Integer ( dw_Ship_List.Describe ( "r_test.y" ) )
		dw_Ship_List.Object.r_test.y = 100
		dw_Ship_List.Print ( )
		dw_Ship_List.Object.r_test.y = li_Check

	CASE "EXPORT"
		dw_Ship_List.SaveAs ( )

	END CHOOSE

	RETURN 0

END IF

if lnv_numerical.of_IsNullOrNotPos(row) then return 0

ls_object_name = dwo.name

choose case ls_object_name
case "billto_name"
	ls_IdColumn = "billto_id"
case "origin_name"
	ls_IdColumn = "origin_id"
case "destination_name"
	ls_IdColumn = "destination_id"
case "shipment_invoicenumber", "ds_id"
	ls_IdColumn = "ds_id"
CASE "shipment_shiptypeid"
	ls_IdColumn = "shipment_shiptypeid"
CASE ELSE
	ls_IDColumn = ls_Object_Name
end choose

choose case ls_IdColumn
case "billto_id", "origin_id", "destination_id"
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "COMPANY"

	ll_CompanyId = this.getitemnumber(row, ls_IdColumn)

	lsa_parm_labels[2] = "CO_ID"
	laa_parm_values[2] = ll_CompanyId
	if ls_IdColumn = "billto_id" then
		lsa_parm_labels[3] = "ADDRESS_TYPE"
		laa_parm_values[3] = "BILLING"
	end if

	lsa_Parm_Labels [4] = "ADD_ITEM"
	laa_Parm_Values [4] = "&Mark All for This Company"

	CHOOSE CASE f_pop_standard(lsa_parm_labels, laa_parm_values)

	CASE "MARK ALL FOR THIS COMPANY"

		IF ll_CompanyId > 0 THEN
			Parent.wf_MarkAll ( ls_IdColumn + " = " + String ( ll_CompanyId ) )
		END IF

	END CHOOSE

case "ds_id"
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "SHIPMENT_PERFORM_OPEN"
	lsa_parm_labels[2] = "TARGET_ID"
	laa_parm_values[2] = this.getitemnumber(row, ls_IdColumn)

	IF This.GetSelectedRow ( 0 ) > 0 THEN
		
		lsa_parm_labels[3] = "TARGET_IDS"
		laa_parm_values[3] = This.Object.ds_id.Selected
		
	END IF
	
	//added this parm so the list would display in the document window
	//nwl 8/24/04
	lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "DATAWINDOW"
	laa_parm_values[upperbound(laa_parm_values) + 1] = this

	f_pop_standard(lsa_parm_labels, laa_parm_values)

CASE "shipment_shiptypeid"

	lsa_Parm_Labels [1] = "ADD_ITEM"
	laa_Parm_Values [1] = "&Mark All for this Type"

	CHOOSE CASE f_pop_standard(lsa_parm_labels, laa_parm_values)

	CASE "MARK ALL FOR THIS TYPE"

		ll_TypeId = This.GetItemNumber ( Row, ls_IdColumn )

		IF ll_TypeId > 0 THEN
			Parent.wf_MarkAll ( ls_IdColumn + " = " + String ( ll_TypeId ) )
		END IF

	END CHOOSE

CASE "comp_custref", "shipment_ref1type", "shipment_ref1text"

	ls_RefText = This.GetItemString ( Row, "shipment_ref1text" )

	IF Len ( ls_RefText ) > 0 THEN

		lsa_Parm_Labels [ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
		laa_Parm_Values [ UpperBound ( laa_Parm_Values ) + 1 ] = "Mark All for REF&1 : " + ls_RefText

	END IF


	ls_RefText = This.GetItemString ( Row, "shipment_ref2text" )

	IF Len ( ls_RefText ) > 0 THEN

		lsa_Parm_Labels [ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
		laa_Parm_Values [ UpperBound ( laa_Parm_Values ) + 1 ] = "Mark All for REF&2 : " + ls_RefText

	END IF


	ls_RefText = This.GetItemString ( Row, "shipment_ref3text" )

	IF Len ( ls_RefText ) > 0 THEN

		lsa_Parm_Labels [ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
		laa_Parm_Values [ UpperBound ( laa_Parm_Values ) + 1 ] = "Mark All for REF&3 : " + ls_RefText

	END IF


	ls_RefText = This.GetItemString ( Row, "shipment_booking" )

	IF Len ( ls_RefText ) > 0 THEN

		lsa_Parm_Labels [ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
		laa_Parm_Values [ UpperBound ( laa_Parm_Values ) + 1 ] = "Mark All for &BOOKING : " + ls_RefText

	END IF


	IF UpperBound ( lsa_Parm_Labels ) > 0 THEN

		ls_Selection = f_pop_standard(lsa_parm_labels, laa_parm_values)
		ls_RefText = ""
	
		IF Pos ( ls_Selection, "REF1" ) > 0 THEN

			ls_RefText = This.GetItemString ( Row, "shipment_ref1text" )

		ELSEIF Pos ( ls_Selection, "REF2" ) > 0 THEN

			ls_RefText = This.GetItemString ( Row, "shipment_ref2text" )

		ELSEIF Pos ( ls_Selection, "REF3" ) > 0 THEN

			ls_RefText = This.GetItemString ( Row, "shipment_ref3text" )

		ELSEIF Pos ( ls_Selection, "BOOKING" ) > 0 THEN

			ls_RefText = This.GetItemString ( Row, "shipment_booking" )
	
		END IF


		IF Len ( ls_RefText ) > 0 THEN

			Parent.wf_MarkAll ( "shipment_ref1text = '" + ls_RefText + "' OR " +&
						 "shipment_ref2text = '" + ls_RefText + "' OR " +&
						 "shipment_ref3text = '" + ls_RefText + "' OR " +&
						 "shipment_booking = '"  + ls_RefText + "'"  )

		END IF

	END IF

end choose
end event

event doubleclicked;long	selid, &
		ll_count, &
		ll_ndx, &
		ll_newcount, &	
		lla_id[]
		
n_cst_ShipmentManager	lnv_ShipmentMgr
n_cst_anyarraysrv				lnv_Arraysrv

if Row > 0 then
	selid = dw_ship_list.object.ds_id[Row]
	if selid > 0 then
		if ib_autoratemode then
			wf_autoratenext(selid)
//			lnv_ShipmentMgr.of_setautoratingmode(true)
//			lnv_ShipmentMgr.of_setratedata(inva_ratedata)
//			//this shipment will be automatically rated in the open event
//			//mark it here as being rated
//			ll_count = upperbound(ila_ratedid)
//			if lnv_arraysrv.of_findlong(ila_ratedid, selid, 1, ll_count) = 0 then
//				ila_ratedid[upperbound(ila_ratedid) + 1] = selid
//				//remove from remaining list
//				ll_count = upperbound(ila_autorateid)
//				for ll_ndx = 1 to ll_count
//					if ila_autorateid[ll_ndx] = selid then
//						//skip
//					else
//						ll_newcount ++
//						lla_id[ll_newcount] = ila_autorateid[ll_ndx]
//					end if
//				next
//			end if
		else
			lnv_ShipmentMgr.of_setautoratingmode(false)
			lnv_ShipmentMgr.of_OpenShipment ( selid )
		end if
	else
		messagebox("Shipment Details", "Could not process request.  Request cancelled.", &
			exclamation!)
	end if
end if
end event

event constructor;n_cst_ShipmentManager	lnv_ShipmentManager

This.Modify ( "Shipment_BillingStatus.Edit.CodeTable = Yes "+&
	"shipment_BillingStatus.Values = '" + lnv_ShipmentManager.of_GetStatusCodeTable ( ) + "'" )

lnv_ShipmentManager.of_PrepareSummaryDisplay ( This )

//Hide the footer display area, which now contains row range and buttons,
//not intended for this context.
This.Modify ( "DataWindow.Footer.Height = 0" )

Parent.wf_Addcustom( )
end event

type st_ship_sort from statictext within w_billing
integer x = 1202
integer y = 32
integer width = 242
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Sort By:"
boolean focusrectangle = false
end type

type st_ship_ind from statictext within w_billing
integer x = 375
integer y = 176
integer width = 987
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "0 to 0 of 0 \ 0 marked"
boolean focusrectangle = false
end type

type st_ships from statictext within w_billing
integer x = 14
integer y = 176
integer width = 325
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Shipments"
boolean focusrectangle = false
end type

type ddlb_dorb from dropdownlistbox within w_billing
integer x = 256
integer y = 16
integer width = 402
integer height = 272
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Dispatch","Brokerage"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if this.text = "Dispatch" and dorb = "B" then
	dorb = "D"
elseif this.text = "Brokerage" and dorb = "D" then
	dorb = "B"
else
	return
end if

set_display()
end event

event getfocus;dw_bills.visible = false

//Commented 2.5.03
//if numships > 0 then dw_ship_list.selectrow(0, false)
end event

type st_display from statictext within w_billing
integer x = 14
integer y = 32
integer width = 242
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Display:"
boolean focusrectangle = false
end type

type cb_preview from commandbutton within w_billing
integer x = 1719
integer y = 168
integer width = 389
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preview Bills"
end type

event clicked;n_cst_numerical lnv_numerical
if lnv_numerical.of_IsNullOrNotPos(numships) then return

if dw_ship_list.getselectedrow(0) < 1 then
	integer frow
	frow = integer(dw_ship_list.describe("datawindow.firstrowonpage"))
	if frow < 1 then return
	dw_ship_list.selectrow(frow, true)
end if

scroll_bills()
end event

type st_preview from statictext within w_billing
boolean visible = false
integer x = 1728
integer y = 176
integer width = 366
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 255
string text = "Preview Bills"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

on clicked;dw_bills.visible = false
st_preview.visible = false
cb_preview.visible = true
cb_print.enabled = false
end on

type dw_bill_manifest from u_dw_bill_manifest within w_billing
integer x = 23
integer y = 276
integer width = 3552
integer height = 1580
integer taborder = 20
end type

type gb_autorating from groupbox within w_billing
boolean visible = false
integer x = 2053
integer width = 585
integer height = 156
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Auto Rating"
end type

type st_cachecode from u_st_shipmentcachecode within w_billing
integer x = 2290
integer y = 24
end type

event clicked;n_cst_ShipmentManager	lnv_ShipmentManager

lnv_ShipmentManager.of_SetShipmentCacheCode ( "ASK!" )

cb_Refresh.Event Clicked ( )
end event

type dw_bills from u_bills within w_billing
boolean visible = false
integer x = 709
integer y = 276
integer taborder = 0
end type

type dw_labels from datawindow within w_billing
boolean visible = false
integer x = 1166
integer y = 848
integer width = 1125
integer height = 360
integer taborder = 30
string dataobject = "d_labels"
boolean livescroll = true
end type

on dberror;mboxret = 1
end on

type dw_letters from datawindow within w_billing
boolean visible = false
integer x = 1166
integer y = 1312
integer width = 1125
integer height = 360
integer taborder = 40
string dataobject = "d_intro_letter"
boolean livescroll = true
end type

on dberror;mboxret = 1
end on

