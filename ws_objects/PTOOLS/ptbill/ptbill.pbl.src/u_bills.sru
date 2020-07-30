$PBExportHeader$u_bills.sru
forward
global type u_bills from u_dw
end type
end forward

global type u_bills from u_dw
integer width = 2811
integer height = 1588
string dataobject = "d_invoice"
end type
global u_bills u_bills

type variables
public:
integer page_offset

protected:
n_cst_billing inv_cst_billing
string is_original_terms
boolean ib_settings_retrieved
boolean ib_full_page
boolean ib_billto_left
boolean ib_delivery_receipt
boolean ib_hide_charges
string is_invoice_comment
string is_delrec_comment
string is_delrec_charges
datastore ids_delivery_receipt
Long	il_Copies
end variables

forward prototypes
public subroutine scrollpage (integer which_way)
public function boolean of_ready ()
protected function integer of_process_shiptypes ()
protected function integer of_create_checklist (ref string asa_labels[], ref string asa_values[])
public subroutine of_set_layout (string as_type)
public function integer of_set_manager (n_cst_billing anv_cst_billing)
public function string of_get_type ()
public function integer of_retrieve (long ala_ids[])
protected function integer of_create_comment (string as_name, string as_text, integer ai_font_height, integer ai_lead_distance)
private function integer of_shiftlist (ref long ala_map[], long ala_removed[], long al_oldcount)
public function integer of_setsort (string as_order)
private function integer of_getrowstohide (dataStore ads_Source, ref long ala_Rows[])
public subroutine of_setcopies (long al_Copies)
public function long of_getcopies ()
end prototypes

public subroutine scrollpage (integer which_way);choose case which_way
case -1
	if page_offset > 0 then
		this.scrollpriorpage()
		page_offset --
	end if
case 0
	do while page_offset > 0
		this.scrollpriorpage()
		page_offset --
	loop
case 1
	integer numpages, frop
	frop = integer(this.describe("datawindow.firstrowonpage"))
	if frop < 1 then return
	numpages = integer(this.describe("evaluate('pagecount()', " + &
		string(frop) + ")"))
	if numpages > page_offset + 1 then
		this.scrollnextpage()
		page_offset ++
	end if
end choose
end subroutine

public function boolean of_ready ();if not ib_settings_retrieved then return false  //See CONSTRUCTOR

if not isvalid(inv_cst_billing) then return false
if not inv_cst_billing.of_ready() then return false

return true
end function

protected function integer of_process_shiptypes ();long ll_bill_row, ll_type_row, ll_ship_type, ll_x_offset, ll_y_offset, lla_logos[]
string ls_def_x, ls_def_y, ls_def_width, ls_def_height, ls_def_filename
n_cst_dws lnv_cst_dws
dwobject ldwo_logo

if this.of_ready() = false then goto failure

choose case this.rowcount()
case is > 0
	//Continue processing
case 0
	return 1
case else
	goto failure
end choose

this.setredraw(false)
for ll_bill_row = 1 to this.rowcount()
	ll_ship_type = this.object.ds_ship_type[ll_bill_row]
	if inv_cst_billing.inv_cst_ship_type.of_find(ll_ship_type, ll_type_row) = -1 then goto failure
	if ll_type_row > 0 then
		lnv_cst_dws.of_copy_by_column(gds_shiptype, ll_type_row, this, ll_bill_row)
	end if
next
this.setredraw(true)


//Logo Section

ldwo_logo = this.object.p_logo

ll_x_offset = 1
ll_y_offset = 4

lla_logos = this.object.st_logo.primary

if inv_cst_billing.of_logo_expressions(lla_logos, ll_x_offset, ll_y_offset, &
	ls_def_x, ls_def_y, ls_def_width, ls_def_height, ls_def_filename) = -1 then goto failure

if inv_cst_billing.of_modify_picture(this, ldwo_logo, ls_def_x, ls_def_y, ls_def_width, &
	ls_def_height, ls_def_filename) = -1 then goto failure

destroy ldwo_logo

return 1

failure:
destroy ldwo_logo
return -1
end function

protected function integer of_create_checklist (ref string asa_labels[], ref string asa_values[]);//This script, and the approach it is part of, were one of several approaches I tried
//on this issue.  For details, see the PB Surprises document and "delrec experiment.doc"

u_dw ldw_target
integer li_report_height, li_ndx, li_entry_count, li_offset
long ll_vertical_extent, ll_start_y
string ls_work, ls_band, ls_report_name
datastore lds_checklist
n_cst_dws lnv_cst_dws

ldw_target = this
lds_checklist = ids_delivery_receipt
ls_report_name = "nr_checklist"
ls_band = "detail"
li_report_height = 137

li_entry_count = upperbound(asa_labels)

//n_cst_numerical lnv_numerical
//if lnv_numerical.of_IsNullOrNotPos(li_entry_count) then return -1
//if lnv_numerical.of_IsNullOrNotPos(upperbound(asa_values)) then return -1

if li_entry_count <> upperbound(asa_values) then return -1

if lnv_cst_dws.of_get_extent(ldw_target, "VERTICAL!", ls_band, ll_vertical_extent) = 1 then
	ll_start_y = ll_vertical_extent + 15
else
	return -1
end if

//if not isvalid(lds_checklist) then
//	lds_checklist = create datastore
//	lds_checklist.dataobject = "d_checklist"
//else
	lds_checklist.reset()
//end if

li_offset = ceiling(li_entry_count / 2)

for li_ndx = 1 to li_offset
	lds_checklist.insertrow(0)
	lds_checklist.object.xx_label_01[li_ndx] = asa_labels[li_ndx]
	lds_checklist.object.xx_value_01[li_ndx] = asa_values[li_ndx]
	if li_ndx + li_offset > upperbound(asa_labels) then continue
	lds_checklist.object.xx_label_02[li_ndx] = asa_labels[li_ndx + li_offset]
	lds_checklist.object.xx_value_02[li_ndx] = asa_values[li_ndx + li_offset]
next

//NOTE: The data just populated is actually put into the report object created below
//during the retrieval process (later, and separate.)  This is because the data entries
//have to be copied once for EACH row in the bill result set.

//li_band_height = integer(ldw_target.describe("datawindow." + ls_band + ".height"))
//li_start_y = li_band_height

ls_work = 'CREATE report(band=BAND_VALUE! dataobject="DATAOBJECT_VALUE!" x="1" y="Y_VALUE!" height="HEIGHT_VALUE!" width="3470" border="0"  height.autosize=yes criteria="" trail_footer = yes  NAME_SEGMENT!  SLIDE_SEGMENT! )'

ls_work = substitute(ls_work, "BAND_VALUE!", ls_band)
ls_work = substitute(ls_work, "DATAOBJECT_VALUE!", "d_checklist")
ls_work = substitute(ls_work, "Y_VALUE!", string(ll_start_y))
ls_work = substitute(ls_work, "HEIGHT_VALUE!", string(li_report_height))
ls_work = substitute(ls_work, "NAME_SEGMENT!", "name=" + ls_report_name)
ls_work = substitute(ls_work, "SLIDE_SEGMENT!", "slideup=directlyabove")

ldw_target.modify(ls_work)

//if li_start_y + li_report_height + 4 > li_band_height then
//	ldw_target.modify("datawindow." + ls_band + ".height = " + string(li_start_y + li_report_height + 4))
//end if

//if lds_checklist.rowcount() > 0 then
//	ldw_target.object.nr_checklist.object.data.primary = lds_checklist.object.data.primary
//end if
//
//destroy lds_checklist

return 1
end function

public subroutine of_set_layout (string as_type);integer li_window_left, li_window_right, li_shift
string ls_work, lsa_labels[], lsa_values[]

choose case as_type
case "FULL_PAGE!"
	if ib_full_page then return
	ib_full_page = true

	li_shift = integer(this.object.datawindow.footer.height) - &
		integer(this.object.billto_address.y) - integer(this.object.billto_address.height)

	//Note: This shift puts the last line of the billing address flush with the bottom
	//page margin.  On a perfect-thirds fold, this line will fall outside the envelope
	//window.  However, due to fold imperfections and the thickness of attachments, 
	//the address tends to shift up, so a "correctly" placed address would float out
	//of the top of the window.  This low placement compensates for that.  This is not
	//an issue for the half-sheet bills because there is no folding, and the attachments
	//do not affect the positioning of the sheet in the envelope.

	this.setredraw(false)
	this.object.datawindow.print.margin.bottom = 110
	this.object.st_billto_label.y = 	integer(this.object.st_billto_label.y) + li_shift
	this.object.billto_address.y = integer(this.object.billto_address.y) + li_shift
	this.object.st_remit_label.y = integer(this.object.st_remit_label.y) + li_shift
	this.object.st_remit_01.y = integer(this.object.st_remit_01.y) + li_shift
	this.object.st_remit_02.y = integer(this.object.st_remit_02.y) + li_shift
	this.object.st_remit_03.y = integer(this.object.st_remit_03.y) + li_shift
	this.object.st_remit_04.y = integer(this.object.st_remit_04.y) + li_shift
	this.object.st_remit_05.y = integer(this.object.st_remit_05.y) + li_shift
	this.vscrollbar = true
	this.setredraw(true)
case "BILLTO_LEFT!"
	if ib_billto_left then return
	ib_billto_left = true

	li_window_left = 362
	li_window_right = 2268
	li_shift = -144
	this.setredraw(false)
	this.object.st_billto_label.x = li_window_left
	this.object.st_billto_label.y = integer(this.object.st_billto_label.y) + li_shift
	this.object.billto_address.x = li_window_left
	this.object.st_remit_label.x = li_window_right
	this.object.st_remit_label.y = integer(this.object.st_remit_label.y) + li_shift
	this.object.st_remit_01.x = li_window_right
	this.object.st_remit_02.x = li_window_right
	this.object.st_remit_03.x = li_window_right
	this.object.st_remit_04.x = li_window_right
	this.object.st_remit_05.x = li_window_right
	this.setredraw(true)
case "DELIVERY_RECEIPT!"
	if ib_delivery_receipt then return

	of_set_layout("FULL_PAGE!")

	ib_delivery_receipt = true
	//This is referenced in of_retrieve().  Changes in the nests need to be performed
	//each time bills are retrieved.  The original nest definition is restored with each
	//retrieval.

	choose case is_delrec_charges
	case "SHOW!"
		ib_hide_charges = false
	case "HIDE!"
		ib_hide_charges = true
	case else //i.e. "ASK!"
		if messagebox("Delivery Receipt", "Do you want to display charges on this "+&
			"Delivery Receipt?", question!, yesno!, 2) = 1 then ib_hide_charges = false &
			else ib_hide_charges = true
	end choose


	if not isvalid(ids_delivery_receipt) then
		ids_delivery_receipt = create datastore
		ids_delivery_receipt.dataobject = "d_checklist"
	end if

	this.object.st_block1_label.text = "DELIVERY RECEIPT"
	this.object.st_bill_date_label.visible = 0
	this.object.ds_bill_date.visible = 0
	this.object.comp_terms.visible = 0

	if ib_hide_charges then
		this.object.comp_bill_summary.visible = 0
		this.object.comp_bill_total.visible = 0
		this.object.st_bill_total_background.visible = 0
		this.object.st_bill_charge_label.visible = 0
		this.object.ds_bill_charge.visible = 0
	end if

	//This whole section should be user-configurable.

	lsa_labels[upperbound(lsa_labels) + 1] = "APPOINTMENT TIME:"
	lsa_labels[upperbound(lsa_labels) + 1] = "ARRIVAL TIME:"
	lsa_labels[upperbound(lsa_labels) + 1] = "STARTED:"
	lsa_labels[upperbound(lsa_labels) + 1] = "COMPLETED:"
	lsa_labels[upperbound(lsa_labels) + 1] = "UNIT RELEASED:"
	lsa_labels[upperbound(lsa_labels) + 1] = "TOTAL DELIVERY TIME:"
	lsa_labels[upperbound(lsa_labels) + 1] = "LESS FREE TIME:"
	lsa_labels[upperbound(lsa_labels) + 1] = "DETENTION TIME:"

	lsa_labels[upperbound(lsa_labels) + 1] = "PALLETIZED"
	lsa_values[upperbound(lsa_labels)] = space(15) + "YES" + space(15) + "NO"

	lsa_labels[upperbound(lsa_labels) + 1] = "DRIVER UNLOAD"
	lsa_values[upperbound(lsa_labels)] = space(15) + "YES" + space(15) + "NO"

	lsa_labels[upperbound(lsa_labels) + 1] = "SPOTTED"
	lsa_values[upperbound(lsa_labels)] = space(15) + "YES" + space(15) + "NO"

	lsa_labels[upperbound(lsa_labels) + 1] = ""
	lsa_labels[upperbound(lsa_labels) + 1] = "TIME VERIFIED BY:"
	lsa_labels[upperbound(lsa_labels) + 1] = "DATE:"
	lsa_labels[upperbound(lsa_labels) + 1] = "DRIVER:"
	lsa_labels[upperbound(lsa_labels) + 1] = "SEAL NUMBER:"

	lsa_values[upperbound(lsa_labels)] = ""  //To get the upperbounds the same.

	of_create_checklist(lsa_labels, lsa_values)

	//Comment creation.
	if len(is_delrec_comment) > 0 then
		of_create_comment("comp_delrec_comment", is_delrec_comment, 11, 15)
	end if

	//Create signature line.
	of_create_comment("comp_delrec_signature", "SIGNATURE : .............................................     PRINT NAME : ........................................", 18, 120)

	this.setredraw(true)

end choose
end subroutine

public function integer of_set_manager (n_cst_billing anv_cst_billing);if anv_cst_billing.of_register(this) = -1 then return -1
inv_cst_billing = anv_cst_billing
return 1
end function

public function string of_get_type ();if ib_delivery_receipt then
	return "DELIVERY_RECEIPT!"
else
	return "INVOICE!"
end if
end function

public function integer of_retrieve (long ala_ids[]);//IMPORTANT: the uo must be visible (and not off the screen!) in order for this function
//to work properly (the firstrowonpage calculations are not accurate otherwise).  It is
//up to the calling script to accomplish this.

//In 3-6-b3, changed the equipment logic from taking just active containers to taking all 
//leased equipment from active events.  --BKW

//In 3-6-00, added the ability to exclude chassis from the equipment list, 8/5/03 BKW


integer 	billrow, &
			markloop, & 
			numbills, &
			foundrow, &
			li_ndx, &
			li_EventCount, &
			li_ItemCount, &
			li_CrossDockRows, &
			li_HideCount, &
			li_Count
			
long 	co_list[],&
		co_check[], &
		lla_empty[], &
		co_id, &
		lla_container1[], &
		lla_container2[], &
		lla_container3[], &
		lla_container4[], &
		lla_trailer1[], &
		lla_trailer2[], &
		lla_trailer3[], &
		lla_equip_list[], &
		lla_EventMap[], &
		lla_CrossDockRows[],&
		lla_Check[], &
		lla_RowsToHide[], &
		ll_EquipRow, &
		ll_ParentID, &
		ll_pos
		
string 	workstr, &
			selstr, &
			ls_address, &
			ls_codename, &
			ls_MessageHeader ,&
		 	lsa_event_type[], &
			lsa_empty[] //see note later for string vs. char choice
			
s_eq_info 	lstr_equip
datastore 	lds_invoice_equip
DataStore	lds_InvoiceItin
Boolean		lb_FilterDockEvents, &
				lb_ShowPhoneNumbers, &
				lb_ExcludeChassis, &
				lb_PrintCodeName


n_cst_anyarraysrv lnv_Array
n_cst_CrossDock	lnv_CrossDock
n_cst_beo_Company	lnv_Company
n_cst_EquipmentManager lnv_EquipmentMgr
n_cst_beo_Equipment2	lnv_Equip
n_cst_Settings			lnv_Settings
n_cst_setting_printcodenameoninvoice	lnv_CodeNameOnInvoice


n_Cst_bso_Dispatch	lnv_Dispatch
lnv_Dispatch = CREATE n_Cst_bso_Dispatch

lnv_Company = CREATE n_cst_beo_Company
lnv_Company.of_SetUseCache ( TRUE )

lnv_CodeNameOnInvoice = CREATE n_cst_setting_printcodenameoninvoice
lb_PrintCodeName = lnv_CodeNameOnInvoice.of_Getvalue( ) = lnv_CodeNameOnInvoice.cs_yes
DESTROY lnv_CodeNameOnInvoice

numbills = upperbound(ala_ids)
if numbills > 0 then
else
	goto failure
end if

lds_InvoiceItin = CREATE DataStore
lds_InvoiceItin.DataObject = "d_invoice_itin"
lds_InvoiceItin.SetTransObject ( SQLCA )

setpointer(hourglass!)

lb_ExcludeChassis = lnv_Settings.of_ExcludeChassisFromInvoice ( )

if this.of_ready() = false then goto failure

this.scrollpage(0)
this.reset()

IF ib_Delivery_Receipt THEN
	ls_MessageHeader = "Retrieve Delivery Receipt"
	lb_ShowPhoneNumbers = TRUE
ELSE
	ls_MessageHeader = "Retrieve Invoice"
END IF


lnv_CrossDock = CREATE n_cst_CrossDock

IF lnv_CrossDock.of_Ready ( ) THEN

	IF ib_Delivery_Receipt THEN
		lb_FilterDockEvents = lnv_CrossDock.of_GetFilterOnDelrec ( )
	ELSE
		lb_FilterDockEvents = lnv_CrossDock.of_GetFilterOnInvoice ( )
	END IF

ELSE

	CHOOSE CASE MessageBox ( ls_MessageHeader, "Could not retrieve crossdock filter "+&
		"settings from database.  Do you want to proceed without filtering crossdock events?", &
		Question!, YesNo!, 1 )
	CASE 1
		//Proceed
	CASE 2
		GOTO FAILURE
	END CHOOSE

END IF

if this.retrieve(ala_ids) = -1 then goto rollitback
commit ;
if sqlca.sqlcode <> 0 then goto rollitback

if this.rowcount() = numbills then
else
	goto failure
end if

for billrow = 1 to numbills
	co_list[upperbound(co_list) + 1] = this.object.ds_billto_id[billrow]
	// without the scroll to row, First Row on page was not working if there were not any events 
	// in the first shipment being processed.
	THIS.SetRedraw ( FALSE )
	THIS.Scrolltorow( billRow )
	THIS.SetRedraw ( TRUE ) 
	if integer(this.object.nr_itin[billrow].object.datawindow.firstrowonpage) > 0 then
		co_check = lla_empty
		co_check = this.object.nr_itin[billrow].object.de_site.primary
		for markloop = 1 to upperbound(co_check)
			if co_check[markloop] > 0 then &
				co_list[upperbound(co_list) + 1] = co_check[markloop]
		next
	end if
next

if gnv_cst_companies.of_cache(co_list, true) = -1 then goto failure

this.setredraw(false)

lds_invoice_equip = create datastore
lds_invoice_equip.dataobject = "d_invoice_equip"
lds_invoice_equip.settransobject(sqlca)

for billrow = 1 to numbills
	co_id = this.object.ds_billto_id[billrow]
	if gnv_cst_companies.of_get_address(co_id, "BILLING!", true, ls_address) = 1 then
		lnv_Company.of_SetSourceId ( co_id )
		IF lnv_Company.of_HasSource ( ) THEN
			ls_codename = lnv_company.of_getcodename()
			if isnull(ls_codename) or len(trim(ls_codename)) = 0 OR NOT lb_PrintCodeName then
				//nothing to add to address
			else
				ll_pos = pos(ls_address, "~r~n", 1)
				if ll_pos > 0 then
					ls_address = left(ls_address,ll_pos - 1) + "    [" + lnv_company.of_getcodename() + "]" +&
									 right(ls_address, (len(ls_address) - ll_pos) + 1)
				end if
			end if
		end if
		this.object.billto_address[billrow] = ls_address
	else
		goto failure
	end if
	IF Integer ( This.Object.nr_Itin[billrow].Object.Datawindow.FirstRowOnPage ) > 0 THEN


///////////////////////////////////////////
		

		lds_InvoiceItin.Object.Data.Primary = This.Object.nr_Itin[billrow].Object.Data.Primary
		
		THIS.of_GetRowsToHide( lds_InvoiceItin , lla_RowsToHide )  
		
		li_EventCount = lds_InvoiceItin.RowCount ( )
		
		IF lb_FilterDockEvents THEN
			li_CrossDockRows = lnv_CrossDock.of_GetDockRows ( lds_InvoiceItin, lla_CrossDockRows )
		END IF
		
		// concatinate the hide rows and the x-dock rows		
		lnv_Array.of_appendlong ( lla_RowsToHide, lla_CrossDockRows )
		lnv_Array.of_GetShrinked ( lla_RowsToHide , TRUE , TRUE )
		lnv_Array.of_SortLong ( lla_RowsToHide )
		li_HideCount = UpperBound ( lla_RowsToHide )
		IF li_HideCount > 0 THEN

			FOR li_Ndx = li_HideCount TO 1 STEP -1
				lds_InvoiceItin.RowsDiscard ( lla_RowsToHide [ li_Ndx ], &
					lla_RowsToHide [ li_Ndx ], Primary! )
			NEXT
/**/
			//IF lds_InvoiceItin.RowCount ( )  > 0 THEN  // if there is nothing in the primary it will crash
				This.Object.nr_Itin[billrow].Object.Data.Primary = lds_InvoiceItin.Object.Data.Primary							
			//END IF
			
			IF Integer ( This.Object.nr_Items[billrow].Object.Datawindow.FirstRowOnPage ) > 0 THEN
	
				IF of_ShiftList ( lla_EventMap, lla_RowsToHide, li_EventCount ) > 0 THEN
	
					lla_Check = This.Object.nr_Items[billrow].Object.di_pu_event.Primary
					li_ItemCount = UpperBound ( lla_Check )

					FOR li_Ndx = 1 TO li_ItemCount
						IF lla_Check [ li_Ndx ] > 0 AND lla_Check [ li_Ndx ] <= li_EventCount THEN
							This.Object.nr_Items[billrow].Object.di_pu_event[li_Ndx] = &
								lla_EventMap [ lla_Check [ li_Ndx ] ]
						END IF
					NEXT

					lla_Check = This.Object.nr_Items[billrow].Object.di_del_event.Primary
					li_ItemCount = UpperBound ( lla_Check )

					FOR li_Ndx = 1 TO li_ItemCount
						IF lla_Check [ li_Ndx ] > 0 AND lla_Check [ li_Ndx ] <= li_EventCount THEN
							This.Object.nr_Items[billrow].Object.di_del_event[li_Ndx] = &
								lla_EventMap [ lla_Check [ li_Ndx ] ]
						END IF
					NEXT

				END IF
			END IF
/**/
			
		END IF
////////////////////////////////////////////

		co_check = lla_empty
		co_check = this.object.nr_itin[billrow].object.de_site.primary
		for markloop = 1 to upperbound(co_check)

//			if co_check[markloop] = 0 then setnull(co_check[markloop])
//			//Null values of de_site are read into the array as 0

//			if gnv_cst_companies.of_get_info(co_check[markloop], lstr_company, false) = 1 then
//				this.object.nr_itin[billrow].object.co_name[markloop] = lstr_company.co_name
//				this.object.nr_itin[billrow].object.co_addr1[markloop] = lstr_company.co_addr1
//				this.object.nr_itin[billrow].object.co_city[markloop] = lstr_company.co_city
//				this.object.nr_itin[billrow].object.co_state[markloop] = lstr_company.co_state
//				this.object.nr_itin[billrow].object.co_usnon[markloop] = lstr_company.co_usnon
//				this.object.nr_itin[billrow].object.co_country[markloop] = lstr_company.co_country
//			else
//				goto failure
//			end if


			lnv_Company.of_SetSourceId ( co_check[markloop] )
		
			IF lnv_Company.of_HasSource ( ) THEN

				this.object.nr_itin[billrow].object.co_name[markloop] = lnv_Company.of_GetName ( )
				this.object.nr_itin[billrow].object.co_addr1[markloop] = lnv_Company.of_GetAddress1 ( )
				this.object.nr_itin[billrow].object.co_Location[markloop] = lnv_Company.of_GetLocationPostal ( )

				IF lb_ShowPhoneNumbers THEN
					this.object.nr_itin[billrow].object.co_Phone[markloop] = lnv_Company.of_FormatPhone1 ( )
				END IF

			ELSEIF co_check[markloop] > 0 THEN

				//ID is valid, but beo couldn't be initialized
				GOTO Failure

			END IF

		next

		lla_equip_list = lla_empty
		lsa_event_type = lsa_empty
		lla_container1 = lla_empty
		lla_container2 = lla_empty
		lla_Container3 = lla_Empty
		lla_Container4 = lla_Empty
		lla_Trailer1 = lla_Empty
		lla_Trailer2 = lla_Empty
		lla_Trailer3 = lla_Empty
		
		//Get the Event Type, Container1, Container2, and Acteq lists 
		//for this shipment's events (see comment at top of script for explanation)
		lsa_event_type = this.object.nr_itin[billrow].object.de_event_type.primary
		lla_container1 = this.object.nr_itin[billrow].object.de_container1.primary
		lla_container2 = this.object.nr_itin[billrow].object.de_container2.primary
		lla_container3 = this.object.nr_itin[billrow].object.de_container3.primary
		lla_container4 = this.object.nr_itin[billrow].object.de_container4.primary
		lla_trailer1 = this.object.nr_itin[billrow].object.de_trailer1.primary
		lla_trailer2 = this.object.nr_itin[billrow].object.de_trailer2.primary
		lla_trailer3 = this.object.nr_itin[billrow].object.de_trailer3.primary
		
		//Loop through the events, and if they're Hooks, Drops, Mounts, or Dismounts
		//(HRMN) record them in the list of equipment
		
		li_Count = 0
		
		ll_ParentID = this.object.ds_parentid[billrow]
		IF ll_ParentID > 0 THEN
			lnv_Dispatch.of_GetEquipmentForShipment ( ll_ParentID ,lla_equip_list )
			li_Count = UpperBound ( lla_equip_list )
		END IF
			

		for li_ndx = 1 to upperbound(lsa_event_type)
			if pos("HRMN", lsa_event_type[li_ndx]) > 0 then 
				//The line above did not work with a char array.

				if lla_container1[li_ndx] > 0 then
					li_Count ++
					lla_equip_list[li_Count] = lla_container1[li_ndx]
				end if

				if lla_container2[li_ndx] > 0 then
					li_Count ++
					lla_equip_list[li_Count] = lla_container2[li_ndx]
				end if

				if lla_container3[li_ndx] > 0 then
					li_Count ++
					lla_equip_list[li_Count] = lla_container3[li_ndx]
				end if

				if lla_container4[li_ndx] > 0 then
					li_Count ++
					lla_equip_list[li_Count] = lla_container4[li_ndx]
				end if

				if lla_trailer1[li_ndx] > 0 then
					li_Count ++
					lla_equip_list[li_Count] = lla_trailer1[li_ndx]
				end if

				if lla_trailer2[li_ndx] > 0 then
					li_Count ++
					lla_equip_list[li_Count] = lla_trailer2[li_ndx]
				end if

				if lla_trailer3[li_ndx] > 0 then
					li_Count ++
					lla_equip_list[li_Count] = lla_trailer3[li_ndx]
				end if

			end if
		next
		
		//Condense the Equipment Id array to eliminate nulls and duplicate ids.
		n_cst_anyarraysrv lnv_anyarray
		lnv_anyarray.of_GetShrinked(lla_equip_list, "NULLS~tDUPES")

		//If we've got any equipment, load it into the cache and populate the nested
		//report on the invoice.
		
		if upperbound(lla_equip_list) > 0 then

			if lnv_EquipmentMgr.of_cache(lla_equip_list, true) = -1 then goto failure

			lnv_Equip = CREATE n_cst_beo_Equipment2
			lnv_Equip.of_SetSource ( lnv_EquipmentMgr.of_Get_DS_Equipment ( ) )


			lds_invoice_equip.reset()
			ll_EquipRow = 0

			//Copy by Column looks for all the columns in the nested report
			//(lds_Invoice_Equip) that match column names in the source
			//(the cache on EqupimentMgr) and copies the data for those columns across,
			//adding one row for each of the ids specified in lla_Equip_List.
			for li_ndx = 1 to upperbound(lla_equip_list)

//				Replaced with beo logic in 3-6-b3
//				if lnv_EquipmentMgr.of_copy_by_column(lla_equip_list[li_ndx], &
//					lds_invoice_equip, 0) < 1 then goto failure

				lnv_Equip.of_SetSourceId ( lla_Equip_List [ li_Ndx ] )

				IF lnv_Equip.of_IsLeased ( ) THEN

					//Exclude chassis option added 3.6.00 BKW 8/5/03

					IF lb_ExcludeChassis THEN

						IF lnv_Equip.of_IsChassis ( ) THEN

							CONTINUE   //Do not list the equipment -- skip over adding it to the list, below

						END IF

					END IF

					ll_EquipRow = lds_Invoice_Equip.InsertRow ( 0 )
	
					IF ll_EquipRow > 0 THEN
	
						lds_Invoice_Equip.Object.eq_id [ ll_EquipRow ] = lla_Equip_List [ li_Ndx ]
						lds_Invoice_Equip.Object.eq_type [ ll_EquipRow ] = lnv_Equip.of_GetType ( )
						lds_Invoice_Equip.Object.eq_ref [ ll_EquipRow ] = lnv_Equip.of_GetNumber ( )
						lds_Invoice_Equip.Object.xx_description [ ll_EquipRow ] = lnv_Equip.of_GetDescription ( )
	
					END IF

				END IF

			next

			//This is looping through the equipment list looking for chassis with the
			//same reference number as a container.  In these cases, dispatch didn't 
			//specify the actual container number, which is fine for them, but we don't
			//want to confuse the customer, so we're replacing the bogus chassis number
			//with "unspecified".  COMMENTED 3-6-B3 NO LONGER NECESSARY, NO DUP NUMBERS ALLOWED.
//			for li_ndx = 1 to lds_invoice_equip.rowcount()
//				if lds_invoice_equip.object.eq_type[li_ndx] = "H" then
//					if lds_invoice_equip.find("eq_type = 'C' and eq_ref = '" +&
//						lds_invoice_equip.object.eq_ref[li_ndx] + "'", &
//						1, lds_invoice_equip.rowcount()) > 0 then &
//							lds_invoice_equip.object.eq_ref[li_ndx] = "[UNSPECIFIED]"
//				end if
//			next

			//If we ended up with something to transfer, transfer it in.
			if lds_invoice_equip.rowcount() > 0 then
				this.object.nr_equip[billrow].object.data.primary = lds_invoice_equip.object.data.primary
			end if

			DESTROY lnv_Equip

		end if

	end if
next

if ib_delivery_receipt then

	//These changes in the nests need to be performed each time bills are retrieved.  
	//The original nest definition is restored with each retrieval.

	for billrow = 1 to numbills
		if ib_hide_charges then
			this.object.nr_items[billrow].object.comp_rate_descr.expression = "'N.A.'"
			this.object.nr_items[billrow].object.di_our_itemamt.format = "N.A."
			this.object.nr_items[billrow].object.cf_HideFSC.expression = "'N.A.'"
		end if

		if isvalid(ids_delivery_receipt) then
			if ids_delivery_receipt.rowcount() > 0 then
				this.object.nr_checklist[billrow].object.data.primary = &
					ids_delivery_receipt.object.data.primary
			end if
		end if
	next

end if

// this is here so that the dw is back to a "normal" position since
// we are scrolling through each row at the top of the script
THIS.ScrollToRow ( 1 )

this.setredraw(true)
destroy lds_invoice_equip
DESTROY lds_InvoiceItin
DESTROY lnv_CrossDock
DESTROY lnv_Company
Destroy lnv_Dispatch

if this.of_process_shiptypes() = -1 then goto failure

return numbills

rollitback:
rollback ;

failure:
this.setredraw(true)
destroy lds_invoice_equip
DESTROY lds_InvoiceItin
DESTROY lnv_CrossDock
DESTROY lnv_Company
Destroy lnv_Dispatch


this.reset()
return -1

end function

protected function integer of_create_comment (string as_name, string as_text, integer ai_font_height, integer ai_lead_distance);//as_name is the name you want to give to the computed field that is created
//as_text is the text you want to display
//ai_font_height can be the positive or negative font height value
//ai_lead_distance is the distance (in pbu's) that you want to leave between the
//		comment and any objects above it

u_dw ldw_target
integer li_x, li_y, li_height, li_width
long ll_vertical_extent
string ls_work, ls_band
n_cst_dws lnv_cst_dws

if isnull(as_text) then as_text = ""

ldw_target = this
ls_band = "detail"

if lnv_cst_dws.of_get_extent(ldw_target, "VERTICAL!", ls_band, ll_vertical_extent) = 1 &
	and ai_lead_distance >= 0 then
		li_y = ll_vertical_extent + ai_lead_distance
else
	return -1
end if

//li_band_height = integer(ldw_target.describe("datawindow." + ls_band + ".height"))
//li_y = li_band_height
li_x = 10
li_width = 3457
li_height = 73
ai_font_height = 0 - abs(ai_font_height)  //font height must be a negative number

ls_work = 'CREATE compute(band=BAND_VALUE! alignment="0" expression="EXPRESSION_VALUE!" border="0" color="0" x="X_VALUE!" y="Y_VALUE!" height="HEIGHT_VALUE!" width="WIDTH_VALUE!" format="[general]"  NAME_SEGMENT!  SLIDE_SEGMENT!  font.face="Univers Condensed" font.height="FONT_HT_VALUE!" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127"  height.autosize=yes)'

ls_work = substitute(ls_work, "BAND_VALUE!", ls_band)
ls_work = substitute(ls_work, "EXPRESSION_VALUE!", "'" + as_text + "'")
ls_work = substitute(ls_work, "X_VALUE!", string(li_x))
ls_work = substitute(ls_work, "Y_VALUE!", string(li_y))
ls_work = substitute(ls_work, "HEIGHT_VALUE!", string(li_height))
ls_work = substitute(ls_work, "WIDTH_VALUE!", string(li_width))
if len(trim(as_name)) > 0 then
	ls_work = substitute(ls_work, "NAME_SEGMENT!", "name=" + trim(as_name))
else
	ls_work = substitute(ls_work, "NAME_SEGMENT!", "")
end if
ls_work = substitute(ls_work, "SLIDE_SEGMENT!", "slideup=directlyabove")
ls_work = substitute(ls_work, "FONT_HT_VALUE!", string(ai_font_height))

ldw_target.modify(ls_work)

//if li_y + li_height + 4 > li_band_height then
//	ldw_target.modify("datawindow." + ls_band + ".height = " + string(li_y + li_height + 4))
//end if

return 1
end function

private function integer of_shiftlist (ref long ala_map[], long ala_removed[], long al_oldcount);Long	ll_NewIndex, ll_Ndx1, ll_Ndx2, lla_Map[], ll_Removed, ll_Count
Boolean	lb_Removed

ll_Removed = UpperBound ( ala_Removed )

FOR ll_Ndx1 = 1 TO al_OldCount

	lb_Removed = FALSE

	FOR ll_Ndx2 = 1 TO ll_Removed
		IF ala_Removed [ ll_Ndx2 ] = ll_Ndx1 THEN
			lb_Removed = TRUE
			ll_Count ++
			EXIT
		END IF
	NEXT

	IF lb_Removed THEN
		lla_Map [ ll_Ndx1 ] = 0
	ELSE
		ll_NewIndex ++
		lla_Map [ ll_Ndx1 ] = ll_NewIndex
	END IF

NEXT

ala_Map = lla_Map

RETURN ll_Count
end function

public function integer of_setsort (string as_order);integer	li_return

li_return = this.setsort(as_order)
if li_return = 1 then
	li_return = this.sort()
end if

return li_return
end function

private function integer of_getrowstohide (dataStore ads_Source, ref long ala_Rows[]);Long	ll_RowCount
Long	ll_i
Long	lla_HideRows[]
Int	li_HideCount

n_Cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

IF IsValid ( ads_Source ) THEN
	lnv_Event.of_SetSource ( ads_Source )
	ll_RowCount = ads_Source.RowCount ( )
	
	FOR ll_i = 1 TO ll_RowCount
		lnv_Event.of_SetSourceRow ( ll_i )
		IF lnv_Event.of_GetHideOnBill ( ) THEN
			li_HideCount ++
			lla_HideRows[ li_HideCount ] = ll_i
		END IF
	NEXT
	
ELSE
	li_HideCount = -1
END IF

DESTROY( lnv_Event ) 

ala_Rows[] = lla_HideRows

RETURN li_HideCount
end function

public subroutine of_setcopies (long al_Copies);//
/***************************************************************************************
NAME			: of_SetCopies
ACCESS		: Public 
ARGUMENTS	: Long al_Copies
RETURNS		: none
DESCRIPTION	: Set instance on object

REVISION		: RDT 7-29-03
	This is used to set the number of copies in the print dialog
***************************************************************************************/

il_copies = al_Copies
end subroutine

public function long of_getcopies ();//
/***************************************************************************************
NAME			: of_GetCopies
ACCESS		: Public 
ARGUMENTS	: Long al_Copies
RETURNS		: none
DESCRIPTION	: Set instance on object

REVISION		: RDT 7-29-03
	This is used to Get the number of copies for the print dialog
***************************************************************************************/

Return il_copies 
end function

event constructor;n_cst_ShipmentManager	lnv_ShipmentMgr
lnv_ShipmentMgr.of_PopulateReferenceLists ( This )

string ls_invoice_size, ls_billto_alignment

this.settransobject(sqlca)
this.modify("datawindow.print.preview.zoom = 75")

is_original_terms = this.object.comp_terms.expression


//NOTE:  The following is here rather than in of_ready or elsewhere because of some
//awkwardness in the timing of this retrieval.  of_set_layout for delivery receipt
//needs one of these values.  Basically, the problem boils down to being able to
//call of_set_layout from the outside before of_ready has been called.  You run into
//some infinite loop issues.  What I've done for now is make an ib_settings_retrieved
//flag.  You get one crack at it here, and then of_ready will fail if it's not set.

select ss_string into :ls_invoice_size from system_settings where ss_id = 21 ;

choose case sqlca.sqlcode
case 100
	commit ;
	ls_invoice_size = "HALF_PAGE!"
case 0
	commit ;
case else
	rollback ;
	return
end choose


select ss_string into :ls_billto_alignment from system_settings where ss_id = 22 ;

choose case sqlca.sqlcode
case 100
	commit ;
	ls_billto_alignment = "BILLTO_RIGHT!"
case 0
	commit ;
case else
	rollback ;
	return
end choose


select ss_string into :is_invoice_comment from system_settings where ss_id = 23 ;

choose case sqlca.sqlcode
case 100
	commit ;
	setnull(is_invoice_comment)
case 0
	commit ;
case else
	rollback ;
	return
end choose


select ss_string into :is_delrec_comment from system_settings where ss_id = 24 ;

choose case sqlca.sqlcode
case 100
	commit ;
	setnull(is_delrec_comment)
case 0
	commit ;
case else
	rollback ;
	return
end choose


select ss_string into :is_delrec_charges from system_settings where ss_id = 25 ;

choose case sqlca.sqlcode
case 100
	commit ;
	is_delrec_charges = "ASK!"
case 0
	commit ;
case else
	rollback ;
	return
end choose

ib_settings_retrieved = true

this.of_set_layout(ls_invoice_size)
this.of_set_layout(ls_billto_alignment)
end event

event destructor;destroy ids_delivery_receipt
end event

event pfc_print;// override // override // override // override // override // override 

//RDT 7-29-03 Everthing EXCEPT Printing is done here. 

// override // override // override // override // override // override 

//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_print
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Opens the print dialog to allow user to change print settings,
//	and then prints the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.01   Modified script to avoid 64K segment problem with 16bit machine code executables
//	5.0.04	Destroy local datastore prior to returning in error condition.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

boolean	lb_rowselection
integer	li_rc
long		ll_selected[]
long		ll_selectedcount
long		ll_cnt
string		ls_val
datastore				lds_selection
s_printdlgattrib		lstr_printdlg

li_rc = this.event pfc_printdlg (lstr_printdlg)
if li_rc < 0 then
	return li_rc
end if

// Print selection
if this.object.datawindow.print.page.range = "selection" then
	// Get selected count
	lb_rowselection = IsValid (inv_rowselect)
	if not lb_rowselection then
		of_SetRowSelect (true)
	end if
	ll_selectedcount = inv_rowselect.of_SelectedCount (ll_selected)
	if not lb_rowselection then
		of_SetRowSelect (false)
	end if	

	if ll_selectedcount > 0 then
		// Create a datastore to print selected rows
		lds_selection = create datastore
		lds_selection.dataobject = this.dataobject

		// First discard any data in the dataobject
		lds_selection.Reset()

		// Copy selected rows
		for ll_cnt = 1 to ll_selectedcount
			if this.RowsCopy (ll_selected[ll_cnt], ll_selected[ll_cnt], primary!, &
				lds_selection, 2147483647, primary!) < 0 then
				destroy lds_selection
				return -1
			end if
		next

		// Capture print properties of original DW
		// (Note:  this syntax uses Describe/Modify PS functions to avoid 64K segment limit)
		ls_val = this.Describe ("datawindow.print.collate")
		lds_selection.Modify ("datawindow.print.collate = " + ls_val)

		ls_val = this.Describe ("datawindow.print.color")
		lds_selection.Modify ("datawindow.print.color = " + ls_val)

		ls_val = this.Describe ("datawindow.print.columns")
		lds_selection.Modify ("datawindow.print.columns = " + ls_val)

		ls_val = this.Describe ("datawindow.print.columns.width")
		lds_selection.Modify ("datawindow.print.columns.width = " + ls_val)

		ls_val = this.Describe ("datawindow.print.copies")
		lds_selection.Modify ("datawindow.print.copies = " + ls_val)

		ls_val = this.Describe ("datawindow.print.documentname")
		lds_selection.Modify ("datawindow.print.documentname = " + ls_val)

		ls_val = this.Describe ("datawindow.print.duplex")
		lds_selection.Modify ("datawindow.print.duplex = " + ls_val)

		ls_val = this.Describe ("datawindow.print.filename")
		lds_selection.Modify ("datawindow.print.filename = " + ls_val)

		ls_val = this.Describe ("datawindow.print.margin.bottom")
		lds_selection.Modify ("datawindow.print.margin.bottom = " + ls_val)

		ls_val = this.Describe ("datawindow.print.margin.left")
		lds_selection.Modify ("datawindow.print.margin.left = " + ls_val)

		ls_val = this.Describe ("datawindow.print.margin.right")
		lds_selection.Modify ("datawindow.print.margin.right = " + ls_val)

		ls_val = this.Describe ("datawindow.print.margin.top")
		lds_selection.Modify ("datawindow.print.margin.top = " + ls_val)

		ls_val = this.Describe ("datawindow.print.orientation")
		lds_selection.Modify ("datawindow.print.orientation = " + ls_val)

		ls_val = this.Describe ("datawindow.print.page.range")
		lds_selection.Modify ("datawindow.print.page.range = " + ls_val)

		ls_val = this.Describe ("datawindow.print.page.rangeinclude")
		lds_selection.Modify ("datawindow.print.page.rangeinclude = " + ls_val)

		ls_val = this.Describe ("datawindow.print.paper.size")
		lds_selection.Modify ("datawindow.print.paper.size = " + ls_val)

		ls_val = this.Describe ("datawindow.print.paper.source")
		lds_selection.Modify ("datawindow.print.paper.source = " + ls_val)

		ls_val = this.Describe ("datawindow.print.prompt")
		lds_selection.Modify ("datawindow.print.prompt = " + ls_val)

		ls_val = this.Describe ("datawindow.print.quality")
		lds_selection.Modify ("datawindow.print.quality = " + ls_val)

		ls_val = this.Describe ("datawindow.print.scale")
		lds_selection.Modify ("datawindow.print.scale = " + ls_val)
	end if
end if

//// Print
//if IsValid (lds_selection) then
//	li_rc = lds_selection.Print (true)
//	destroy lds_selection
//else
//	li_rc = this.Print (true)
//end if
//
//this.object.datawindow.print.filename = ""
//this.object.datawindow.print.page.range = ""
li_rc = 1
return li_rc

end event

on u_bills.create
end on

on u_bills.destroy
end on

