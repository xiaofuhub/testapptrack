$PBExportHeader$u_dw_bill_manifest.sru
forward
global type u_dw_bill_manifest from u_dw
end type
end forward

global type u_dw_bill_manifest from u_dw
integer width = 494
integer height = 360
string dataobject = "d_bill_manifest"
boolean hscrollbar = true
end type
global u_dw_bill_manifest u_dw_bill_manifest

type variables
protected:
n_cst_billing inv_cst_billing
n_cst_shiptype inv_shiptype
long il_billto_id
boolean ib_portrait
boolean ib_billto_right
end variables

forward prototypes
public function integer of_print (s_longs astr_copies)
protected function string of_describe_rate (string as_rate_type, decimal ac_rate, decimal ac_miles)
public function integer of_set_manager (n_cst_billing anv_cst_billing)
public function boolean of_ready ()
public function long of_get_shiptype ()
public function integer of_set_pronum (string as_pronum)
public function integer of_set_bill_date (date ad_bill_date)
public function string of_get_type ()
public function integer of_retrieve (long ala_ids[])
public function string of_get_pronum ()
public function date of_get_bill_date ()
protected function integer of_set_billto (long al_id)
public function long of_get_billto ()
public subroutine of_set_layout (string as_type)
public function integer of_howmanyuniquepaymentterms (ref string asa_terms[])
end prototypes

public function integer of_print (s_longs astr_copies);return this.print()
end function

protected function string of_describe_rate (string as_rate_type, decimal ac_rate, decimal ac_miles);string ls_rate, ls_result

ls_rate = string(ac_rate, "$0.00##")

choose case as_rate_type
	case appeon_constant.cs_RateUnit_Code_Flat
		ls_result = "FLAT " + ls_rate
		
	case appeon_constant.cs_RateUnit_Code_Minimum
		ls_result = "MIN " + ls_rate
		
	case appeon_constant.cs_RateUnit_Code_Maximum
		ls_result = "MAX " + ls_rate
		
	case appeon_constant.cs_RateUnit_Code_PerUnit
		ls_result = ls_rate + " / UNIT"
		
	case appeon_constant.cs_RateUnit_Code_Gallon
		ls_result = ls_rate + " / GAL"
		
	case appeon_constant.cs_RateUnit_Code_Piece
		ls_result = ls_rate + " / PC"
		
	case appeon_constant.cs_RateUnit_Code_Ton
		ls_result = ls_rate + " / TON"
		
	case appeon_constant.cs_RateUnit_Code_100Pound
		ls_result = ls_rate + " CWT"
		
	case appeon_constant.cs_RateUnit_Code_Pound
		ls_result = ls_rate + " / LB"
		
	case appeon_constant.cs_RateUnit_Code_PerMile
		ls_result = ls_rate
		if ac_miles >= 1000 then ls_result += "/" else ls_result += " / "
		if ac_miles >= 0 then
			ls_result += string(ac_miles)
		else
			ls_result += "??"
		end if
		ls_result += " MI"
		
	case appeon_constant.cs_RateUnit_Code_Class
		ls_result = ls_rate + " CWT"
		
	case else
		ls_result = "NONE"
		
end choose

return ls_result
end function

public function integer of_set_manager (n_cst_billing anv_cst_billing);if anv_cst_billing.of_register(this) = -1 then return -1
inv_cst_billing = anv_cst_billing
return 1
end function

public function boolean of_ready ();if not isvalid(inv_cst_billing) then return false

return inv_cst_billing.of_ready()
end function

public function long of_get_shiptype ();//Returns the id of the shipment type being used for the manifest, or null if 
//the manifest has not been retrieved.  Which shipment type will be used is
//determined in of_retrieve.

if not isvalid(inv_shiptype) then return null_long

if not this.rowcount() > 0 then return null_long

return inv_shiptype.ids_data.object.st_id[1]
end function

public function integer of_set_pronum (string as_pronum);//This value may be set either internally or externally, so I wanted to keep the code
//in one place.

this.object.st_pronum.text = as_pronum

return 1
end function

public function integer of_set_bill_date (date ad_bill_date);//This value may be set either internally or externally, so I wanted to keep the code
//in one place.

this.object.st_bill_date.text = string(ad_bill_date, "m/d/yy")

return 1
end function

public function string of_get_type ();return "MANIFEST!"
end function

public function integer of_retrieve (long ala_ids[]);//IMPORTANT: the uo must be visible (and not off the screen!) in order for this function
//to work properly (the firstrowonpage calculations are not accurate otherwise).  It is
//up to the calling script to accomplish this.

n_cst_numerical lnv_numerical

integer lia_ref_type[], lia_empty[], li_ndx
long ll_rowcount, ll_row, ll_billto_id, lla_ids[], lla_work[], ll_nest_row, &
	lla_type_list[], lla_type_count[], ll_elected_type, ll_check, ll_logo, ll_extension
string ls_address, ls_address_type, ls_ref_list, ls_work, lsa_ref_text[], lsa_empty[], &
	ls_rate_type, ls_remit, ls_terms, ls_base
string	ls_Origin, &
			ls_Dest
			
String	lsa_terms[], &
			ls_list

long		ll_tag1, &
			ll_tag2
date ld_bill_date
dwobject ldwo_logo
n_cst_ShipmentManager	lnv_ShipmentMgr

setpointer(hourglass!)

if this.of_ready() = false then goto failure

setnull(ll_billto_id)
destroy inv_shiptype


//Retrieve the requested shipments

ll_rowcount = this.retrieve(ala_ids)

choose case ll_rowcount
case is > 0
	commit ;
case 0
	commit ;
	return ll_rowcount
case else
	rollback ;
	return ll_rowcount
end choose


//Determine the billto id

ll_billto_id = this.object.ds_billto_id[1]
if lnv_numerical.of_IsNullOrNotPos(ll_billto_id) then goto failure
this.of_set_billto(ll_billto_id)


//Determine which shipment type will be used for the header

if inv_cst_billing.of_get_shipment_types(this, lla_type_list, lla_type_count) = -1 &
	then goto failure

ll_check = 0

for li_ndx = 1 to upperbound(lla_type_list)
	if (lla_type_count[li_ndx] > ll_check) or &
		(lla_type_count[li_ndx] = ll_check and lla_type_list[li_ndx] < ll_elected_type) then

		//The second condition, used as a tiebreaker, is arbitrary.  We could conceivably
		//use more elaborate criteria (particularly, checking if one type is a default.)

		ll_elected_type = lla_type_list[li_ndx]
		ll_check = lla_type_count[li_ndx]

	end if
next

if lnv_numerical.of_IsNullOrNotPos(ll_elected_type) then goto failure

//Get the shiptype object

if not inv_cst_billing.inv_cst_ship_type.of_get_object(ll_elected_type, inv_shiptype) = 1 &
	then goto failure

//Set remit in the header

if not inv_shiptype.of_get_remit(ls_remit) = 1 then goto failure

//Note: using an st instead of a cf presented the ampersand problem.
ls_remit = substitute(ls_remit, "'", "~~~~~~~'")
ls_remit = substitute(ls_remit, '"', '~~~~~~~"')
this.object.cf_remit_address.expression = "'" + ls_remit + "'"

//Set logo in the header

ldwo_logo = this.object.p_logo

ll_logo = inv_shiptype.ids_data.object.st_logo[1]

if not inv_cst_billing.of_set_logo(this, ldwo_logo, ll_logo) = 1 then goto failure


//Set the terms in the header

// nwl 6/30/2004
//first look for billto override 
n_cst_beo_Company	lnv_Company

lnv_company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE )
lnv_Company.of_SetSourceId ( ll_billto_id )

ls_terms = lnv_Company.of_GetPaymentTerms ( )

DESTROY lnv_Company

if len(ls_terms) > 0 then
	//have terms
else

	ls_terms = inv_shiptype.ids_data.object.st_terms[1]
	
end if

choose case this.of_HowManyUniquePaymentTerms(lsa_terms)
	case is > 1 
		
		n_cst_string	lnv_string
		
		lnv_String.of_ArrayToString( lsa_terms, ',', ls_list)
		
		choose case messagebox('AR Terms', 'Different AR Terms were found amoung ' +&
					'the shipments included in this manifest. They are ' +ls_list + '. ' +&
					'Select Cancel to review the shipments or OK to ' +&
					'proceed with the default AR Terms of ' + ls_terms + '.', exclamation!, OKCancel!)
			case 1
				//continue
			case 2
				goto failure
				
		end choose
		
	case else
		//continue
		
end choose

//end new logic nwl


if not isnull(ls_terms) then this.object.st_terms.text = ls_terms


//Determine whether this is a previously billed manifest, and if so, set the invoice 
//number and invoice date in the header.  If it's a new manifest, these values will be 
//set in inv_cst_billing.of_bill()

if this.object.ds_status[1] = gc_Dispatch.cs_ShipmentStatus_Billed then

	ls_work = this.object.ds_pronum[1]
	if inv_cst_billing.of_manifest_extract(ls_work, ls_base, ll_extension) = false &
		then goto failure
	if this.of_set_pronum(ls_base) = -1 then goto failure

	ld_bill_date = this.object.ds_bill_date[1]
	if this.of_set_bill_date(ld_bill_date) = -1 then goto failure

end if

//Set billto address in header

ls_address_type = "BILLING!"

if not gnv_cst_companies.of_get_address(ll_billto_id, ls_address_type, ls_address) = 1 &
	then goto failure
ls_address = substitute(ls_address, "'", "~~~~~~~'")
ls_address = substitute(ls_address, '"', '~~~~~~~"')
this.object.cf_billto_address.expression = "'" + ls_address + "'"


ls_address_type = "PHYSICAL!" + "~t" + "NO_STREETS!" + "~t" + "NO_ZIP!" + &
	"~t" + "DESCRIBE_NULL!"

//Fill in origin addresses

lla_ids = this.object.ds_origin_id.primary
lla_work = lla_ids

if gnv_cst_companies.of_cache(lla_work, false) = -1 then goto failure

for ll_row = 1 to ll_rowcount

	IF lla_Ids [ ll_Row ] = 0 OR IsNull ( lla_Ids [ ll_Row ] ) THEN

		//See if Origin address is embedded in ShipNote.  SET ls_Address = Null IF NOT!!!
		
		ll_tag1 = 0
		ll_tag2 = 0
		
		//begin tag 
		ll_tag1 = pos ( String ( This.Object.ds_Ship_Comment [ ll_Row ] ), "<ORIGIN>" )
		IF ll_tag1 > 0 THEN
			//end tag
			ll_tag2 = pos ( String ( This.Object.ds_Ship_Comment [ ll_Row ] ), "</ORIGIN>" )
			IF ll_tag2 > 0 THEN
				ls_Origin = mid ( String ( This.Object.ds_Ship_Comment [ ll_Row ] ), &
													ll_tag1 + 8, ll_tag2 - ( ll_tag1 + 8 ) )
			END IF 										
		END IF
						
		IF len ( ls_Origin ) = 0 THEN
			setnull ( ls_Address )
		ELSE
			ls_Address = trim ( ls_Origin )
		END IF

	ELSEIF gnv_cst_companies.of_get_address(lla_ids[ll_row], ls_address_type, ls_address) = 1 then

		//Get the address for the company id.

	else
		goto failure

	END IF

	//Set the address into the display.
	this.object.xx_origin_address[ll_row] = ls_address

next

//Fill in destination addresses

lla_ids = this.object.ds_findest_id.primary
lla_work = lla_ids

if gnv_cst_companies.of_cache(lla_work, false) = -1 then goto failure

for ll_row = 1 to ll_rowcount

	IF lla_Ids [ ll_Row ] = 0 OR IsNull ( lla_Ids [ ll_Row ] ) THEN

		//See if Destination address is embedded in ShipNote.  SET ls_Address = Null IF NOT!!!

		ll_tag1 = 0
		ll_tag2 = 0

		//begin tag 
		ll_tag1 = pos ( String ( This.Object.ds_Ship_Comment [ ll_Row ] ), "<DEST>" )
		IF ll_tag1 > 0 THEN
			//end tag
			ll_tag2 = pos ( String ( This.Object.ds_Ship_Comment [ ll_Row ] ), "</DEST>" )
			IF ll_tag2 > 0 THEN
				ls_Origin = mid ( String ( This.Object.ds_Ship_Comment [ ll_Row ] ), &
													ll_tag1 + 6, ll_tag2 - ( ll_tag1 + 6 ) )
			END IF
		END IF
		
		IF len ( ls_Origin ) = 0 THEN
			setnull ( ls_Address )
		ELSE
			ls_Address = trim ( ls_Origin )
		END IF
	

	ELSEIF gnv_cst_companies.of_get_address(lla_ids[ll_row], ls_address_type, ls_address) = 1 then

		//Get the address for the company id.

	else
		goto failure

	END IF

	//Set the address into the display.
	this.object.xx_findest_address[ll_row] = ls_address

next


//Assemble the ref list and fill in the values, and fill in the rate descriptions

for ll_row = 1 to ll_rowcount
	ls_ref_list = ""
	lia_ref_type = lia_empty
	lsa_ref_text = lsa_empty

	lia_ref_type[1] = this.object.ds_ref1_type[ll_row]
	lsa_ref_text[1] = this.object.ds_ref1_text[ll_row]
	lia_ref_type[2] = this.object.ds_ref2_type[ll_row]
	lsa_ref_text[2] = this.object.ds_ref2_text[ll_row]
	lia_ref_type[3] = this.object.ds_ref3_type[ll_row]
	lsa_ref_text[3] = this.object.ds_ref3_text[ll_row]

	for li_ndx = 1 to upperbound(lia_ref_type)
		lsa_ref_text[li_ndx] = trim(lsa_ref_text[li_ndx])
		if lia_ref_type[li_ndx] > 0 and len(lsa_ref_text[li_ndx]) > 0 then
			ls_Work = lnv_ShipmentMgr.of_ConvertReference ( lia_Ref_Type[li_Ndx] )
			ls_work += " : " + lsa_ref_text[li_ndx]
			if len(ls_ref_list) > 0 then ls_ref_list += "~r~n"
			ls_ref_list += ls_work
		end if
	next

	if integer(this.object.nr_items[ll_row].object.datawindow.firstrowonpage) > 0 then

		//lla_ids = lla_empty
		lla_ids = this.object.nr_items[ll_row].object.di_item_id.primary
		for ll_nest_row = 1 to upperbound(lla_ids)
			ls_work = trim(this.object.nr_items[ll_row].object.di_blnum[ll_nest_row])
			if len(ls_work) > 0 then
				if len(ls_ref_list) > 0 then ls_ref_list += "~r~n"
				choose case this.object.nr_items[ll_row].object.di_item_type[ll_nest_row]
				case "L"
					ls_ref_list += "B.L. # : " + ls_work
				case "A"
					ls_ref_list += "REF # : " + ls_work
				end choose
			end if

			ls_work = of_describe_rate(this.object.nr_items[ll_row].object.di_our_ratetype[ll_nest_row], &
				this.object.nr_items[ll_row].object.di_our_rate[ll_nest_row], &
				this.object.nr_items[ll_row].object.di_miles[ll_nest_row])
			this.object.nr_items[ll_row].object.xx_rate[ll_nest_row] = ls_work

		next
	end if

	if len(ls_ref_list) = 0 then ls_ref_list = "[NOT SPECIFIED]"  //"[NO REF #'S SUPPLIED]"
	this.object.xx_ref_list[ll_row] = ls_ref_list

next

destroy ldwo_logo
return ll_rowcount

failure:
destroy ldwo_logo
destroy inv_shiptype
return -1
end function

public function string of_get_pronum ();string ls_pronum

ls_pronum = this.object.st_pronum.text

return ls_pronum
end function

public function date of_get_bill_date ();string ls_bill_date
date ld_bill_date

ls_bill_date = this.object.st_bill_date.text

if isdate(ls_bill_date) then
	ld_bill_date = date(ls_bill_date)
else
	setnull(ld_bill_date)
end if

return ld_bill_date
end function

protected function integer of_set_billto (long al_id);il_billto_id = al_id
return 1
end function

public function long of_get_billto ();return il_billto_id
end function

public subroutine of_set_layout (string as_type);integer li_window_left, li_window_right, li_shift
string ls_work, lsa_labels[], lsa_values[]

choose case as_type
case "Portrait!"
	ib_portrait=true
	this.setredraw(false)
	this.dataobject = "d_bill_manifest_portrait"
	this.setredraw(true)

case "BILLTO_RIGHT!"
	if not ib_portrait then return
	ib_billto_right = true

	this.setredraw(false)
	this.object.st_billto_label.x = 2121
	this.object.st_remit_label.x = 443
	this.object.cf_billto_address.x = 2121
	this.object.cf_remit_address.x = 443
	this.setredraw(true)

end choose
end subroutine

public function integer of_howmanyuniquepaymentterms (ref string asa_terms[]);integer	li_return

long		ll_ndx, &
			ll_max

string	lsa_terms[]

n_cst_anyarraysrv		lnv_Arraysrv

ll_max = this.rowcount()

for ll_ndx = 1 to ll_max
	
	lsa_terms[ll_ndx] = this.object.paymentterms[ll_ndx]

next

lnv_Arraysrv.of_GetShrinked ( lsa_terms, true /*Shrink Nulls */, true /*Shrink dupes */)

asa_terms = lsa_terms

return upperbound(lsa_terms)


end function

event constructor;//determine if manifest is to be printed landscape or portrait

string	ls_orientation, &
			ls_billto_alignment
			
			
select ss_string into :ls_orientation from system_settings where ss_id = 43 ;

choose case sqlca.sqlcode
case 100
	commit ;
	ls_orientation = "Landscape!"
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

this.of_set_layout(ls_orientation)
this.of_set_layout(ls_billto_alignment)
this.settransobject(sqlca)
this.modify("datawindow.print.preview.zoom = 85")

end event

event destructor;destroy inv_shiptype
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

on u_dw_bill_manifest.create
end on

on u_dw_bill_manifest.destroy
end on

