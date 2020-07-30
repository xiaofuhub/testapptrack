$PBExportHeader$n_cst_billing.sru
forward
global type n_cst_billing from nonvisualobject
end type
end forward

global type n_cst_billing from nonvisualobject
end type
global n_cst_billing n_cst_billing

type variables
public:
n_cst_ship_type inv_cst_ship_type
datastore ids_graphic_definitions
n_cst_dws inv_cst_dws

protected:
boolean ib_ready
boolean	ib_UseShipDate
boolean	ib_ARBatch
Date	id_InvoiceDate
datawindow idwa_registry[]
s_longs istr_billing_copies
string	isa_ArAccount[],&
	isa_SalesAccount[], &
	isa_FreightType[]
decimal	ica_ArAmount[],&
	ica_SalesAmount[]

string is_acctlink
n_cst_errorMessages_accounting inv_messages


end variables

forward prototypes
public function boolean of_ready ()
public function integer of_modify_picture (powerobject apo_target, ref dwobject adwo_target, string as_x, string as_y, string as_width, string as_height, string as_filename)
protected function integer of_find_logo (long al_target_id, ref long al_foundrow)
public function integer of_logo_expressions (long ala_ids[], long al_x_offset, long al_y_offset, ref string as_x, ref string as_y, ref string as_width, ref string as_height, ref string as_filename)
public function integer of_get_logo_info (long al_target, ref long al_x, ref long al_y, ref long al_width, ref long al_height, ref string as_filename)
public function integer of_get_shipment_types (datawindow adw_target, ref long ala_list[], ref long ala_count[])
public function integer of_set_logo (powerobject apo_target, ref dwobject adwo_target, long al_logo_id)
public function string of_get_message_header (string as_type)
public function boolean of_get_copies (s_longs astr_old_copies, ref s_longs astr_new_copies)
public function integer of_register (datawindow adw_target)
public function integer of_retrieve (long ala_ids[], string as_type)
public function integer of_manifest_check (ref long ala_ids[], ref string as_type)
public function boolean of_manifest_extract (string as_pronum, ref string as_base, ref long al_extension)
protected function integer of_validate_billtos (datawindow adw_target)
protected function integer of_validate_status (datawindow adw_target)
public function integer of_validate_shipments (datawindow adw_target)
public function boolean of_manifest_extract (string as_pronum)
public function integer of_process_bills (datawindow adw_target)
protected function integer of_get_dw (string as_type, datawindow adw_after, ref datawindow adw_next)
protected function integer of_get_posting_lists (datawindow adw_target, ref s_anys astr_lists)
protected function integer of_get_posting_company (string asa_company_list[], long ala_company_count[], long al_shipment_count, ref string as_posting_company)
protected function boolean of_get_acct_cos (datawindow adw_target, ref datastore ads_acct_cos)
protected function boolean of_payment_due (string as_payment_terms, date ad_document_date, ref date ad_payment_due)
private function string of_gettype (datawindow adw_target)
public function integer of_getrequiredimagetypes (ref string asa_imageTypes[])
public function integer of_getwarningimagetypes (ref String asa_ImageTypes[])
public function integer of_getimagestoprint (ref string asa_types[])
public function integer of_bill (ref n_cst_msg anv_msg)
public function integer of_printimagesforcustominvoices (datawindow adw_target, n_cst_msg anv_imagemsg)
protected function integer of_getdesiredinvoicedate (ref n_cst_msg anv_Msg)
private function integer of_getinvoicedate (n_cst_msg anv_msg)
protected function integer of_validateshipdates (readonly datawindow adw_target)
protected function integer of_validateinvoicedateselection (readonly dataWindow adw_Target)
public function integer of_printbillingimages (readonly datawindow adw_target)
public function integer of_printimages (n_cst_beo_shipment anv_shipment, n_cst_msg anv_msg)
public function integer of_doimagesneedtoprint (n_cst_beo_shipment anva_shipments[])
private function long of_getshipments (long ala_id[], ref n_cst_beo_shipment anva_shipment[])
protected function decimal of_getdistribution (n_cst_beo_shipment anv_shipment, ref s_accounting_distribution astra_distribution[], decimal ac_hiddendiscount, ref n_cst_msg anv_errormsg)
protected function string of_prepare_batch (datawindow adw_target, datastore ads_acct_cos, string as_postingcompany, n_cst_beo_shipment anva_shipment[], ref n_cst_msg anv_cst_msg)
protected function decimal of_getdistributionaccounts (n_cst_beo_shipment anv_shipment, ref n_cst_msg anv_errormsg)
protected subroutine of_setdistribution (n_cst_beo_shipment anv_shipment, ref decimal ac_amount, ref decimal ac_discountremainder, integer ai_amounttype, boolean ab_freight, ref string as_error)
public function integer of_print (u_dw adw_target, s_longs astr_copies)
public function long of_prevalidateimaging (n_cst_beo_shipment anva_shipment[], ref long ala_id[], ref boolean ab_value)
private function integer of_doimagesneedtoprintforshipment (long al_shipmentid, string asa_imagetypes[])
public function long of_filteridsbyimages (ref n_cst_beo_shipment anv_shipments[], ref long ala_filteredids[])
public function long of_createpayabledata (ref n_cst_beo_shipment anva_shipment[], ref n_cst_accountingdata anva_accountingdata[], ref string as_errormsg)
public function integer of_prebill (n_cst_msg anv_msg)
private function integer of_setgsregistry ()
public function integer of_recordmessage (string as_message)
public function integer of_getlastmessage (ref string as_message)
public function integer of_resetmessages ()
end prototypes

public function boolean of_ready ();if ib_ready then return true

if inv_cst_ship_type.of_refresh() = -1 then return false

if not isvalid(ids_graphic_definitions) then
	ids_graphic_definitions = create datastore
	ids_graphic_definitions.dataobject = "d_graphic_definitions"
	ids_graphic_definitions.settransobject(sqlca)
end if

if ids_graphic_definitions.retrieve() = -1 then
	rollback ;
	return false
else
	commit ;
end if


n_cst_Settings	lnv_Settings
String	ls_AcctLink

CHOOSE CASE lnv_Settings.of_GetAcctLink ( ls_AcctLink )

CASE 1, 0  //Use Value as returned by reference

CASE ELSE  //Error -- Fail
	RETURN FALSE

END CHOOSE

is_AcctLink = ls_AcctLink

ib_ready = true
return true
end function

public function integer of_modify_picture (powerobject apo_target, ref dwobject adwo_target, string as_x, string as_y, string as_width, string as_height, string as_filename);//Whether the as_ values are intended to be base values or expressions is determined by
//whether they are preceded by a tab (~t) or not.  apo_target is the dw or ds.

//A null parm value will cause that value to be skipped; an empty parm value will
//cause that value to have its expression component stripped.

//Something of this kind could be included in the dw service.

integer li_ndx, li_check
string ls_work, ls_parm
DataWindow	ldw_Target

IF apo_Target.TypeOf ( ) = DataWindow! THEN
	ldw_Target = apo_Target
END IF

IF IsValid ( ldw_Target ) THEN
	ldw_Target.SetRedraw ( FALSE )
END IF

for li_ndx = 1 to 5
	choose case li_ndx
	case 1
		ls_work = adwo_target.x
		ls_parm = as_x
	case 2
		ls_work = adwo_target.y
		ls_parm = as_y
	case 3
		ls_work = adwo_target.width
		ls_parm = as_width
	case 4
		ls_work = adwo_target.height
		ls_parm = as_height
	case 5
		ls_work = adwo_target.filename
		ls_parm = as_filename
	end choose

	if isnull(ls_parm) then continue  //Skip for null; strip for "" (see note at top)

	if left(ls_parm, 1) = "~t" or ls_parm = "" then
		if left(ls_work, 1) = '"' and right(ls_work, 1) = '"' then
			ls_work = mid(ls_work, 2, len(ls_work) - 2)
			li_check = pos(ls_work, "~t")
			if li_check > 0 then ls_work = left(ls_work, li_check - 1)
		end if

//		if li_ndx = 5 then ls_work = "'" + ls_work + "'"

		ls_work += ls_parm
	else
		ls_work = ls_parm
	end if

	choose case li_ndx
	case 1
		adwo_target.x = ls_work
	case 2
		adwo_target.y = ls_work
	case 3
		adwo_target.width = ls_work
	case 4
		adwo_target.height = ls_work
	case 5
		adwo_target.filename = ls_work
	end choose

next

IF IsValid ( ldw_Target ) THEN
	ldw_Target.SetRedraw ( TRUE )
END IF

return 1
end function

protected function integer of_find_logo (long al_target_id, ref long al_foundrow);//This function should be moved into a graphic definitions service.

long ll_row

al_foundrow = 0

if isnull(al_target_id) then return 1

if this.of_ready() = false then return -1

ll_row = ids_graphic_definitions.find("gd_id = " + string(al_target_id), &
	1, ids_graphic_definitions.rowcount())

choose case ll_row
case is > 0
	al_foundrow = ll_row
	return 1
case 0
	return 0
case else
	return -1
end choose
end function

public function integer of_logo_expressions (long ala_ids[], long al_x_offset, long al_y_offset, ref string as_x, ref string as_y, ref string as_width, ref string as_height, ref string as_filename);integer li_ndx
long ll_x, ll_y, ll_width, ll_height
string ls_filename
s_anys lstr_work


n_cst_anyarraysrv lnv_anyarray
any laa_ids1[], laa_ids2[]
laa_ids1 = ala_ids
lnv_anyarray.of_GetUnique( laa_ids1, laa_ids2 )
ala_ids = laa_ids2

as_x = ""
as_y = ""
as_width = ""
as_height = ""
as_filename = ""

for li_ndx = 1 to upperbound(ala_ids)
	if ala_ids[li_ndx] > 0 then
		if of_get_logo_info(ala_ids[li_ndx], ll_x, ll_y, ll_width, ll_height, &
			ls_filename) = 1 then
				ll_x += al_x_offset
				ll_y += al_y_offset
				as_x += " WHEN " + string(ala_ids[li_ndx]) + " THEN " + string(ll_x)
				as_y += " WHEN " + string(ala_ids[li_ndx]) + " THEN " + string(ll_y)
				as_width += " WHEN " + string(ala_ids[li_ndx]) + " THEN " + string(ll_width)
				as_height += " WHEN " + string(ala_ids[li_ndx]) + " THEN " + string(ll_height)
				as_filename += " WHEN " + string(ala_ids[li_ndx]) + " THEN '" + ls_filename + "'"
		else
			goto failure
		end if
	end if
next

if len(as_x) > 0 then

	//Note:  I wanted to let this return "~tCASE ( st_logo )" if there were no logos, 
	//but you have to have at least one WHEN clause for it to be valid

	as_x = "~tCASE ( st_logo " + as_x + " )"
	as_y = "~tCASE ( st_logo " + as_y + " )"
	as_width = "~tCASE ( st_logo " + as_width + " )"
	as_height = "~tCASE ( st_logo " + as_height + " )"
	as_filename = "~tCASE ( st_logo " + as_filename + " )"
	return 1
else
	//These must be empty as opposed to null to have the desired result in of_modify_picture
	//They should already have this value at this point, but j.i.c.
	as_x = ""
	as_y = ""
	as_width = ""
	as_height = ""
	as_filename = ""
	return 0
end if

failure:
setnull(as_x)
setnull(as_y)
setnull(as_width)
setnull(as_height)
setnull(as_filename)
return -1
end function

public function integer of_get_logo_info (long al_target, ref long al_x, ref long al_y, ref long al_width, ref long al_height, ref string as_filename);long ll_row, ll_x, ll_y, ll_width, ll_height
string ls_dbstring, ls_filename
n_cst_string lnv_string

setnull(al_x)
setnull(al_y)
setnull(al_width)
setnull(al_height)
setnull(ls_filename)

choose case of_find_logo(al_target, ll_row)
case 1
	ls_dbstring = ids_graphic_definitions.object.gd_dbstring[ll_row]
	ll_x = long(lnv_string.of_ExtractDelimited(ls_dbstring, "X"))
	if isnull(ll_x) then return -1
	ll_y = long(lnv_string.of_ExtractDelimited(ls_dbstring, "Y"))
	if isnull(ll_y) then return -1
	ll_width = long(lnv_string.of_ExtractDelimited(ls_dbstring, "WIDTH"))
	if isnull(ll_width) then return -1
	ll_height = long(lnv_string.of_ExtractDelimited(ls_dbstring, "HEIGHT"))
	if isnull(ll_height) then return -1
	ls_filename = lnv_string.of_ExtractDelimited(ls_dbstring, "FILENAME")
	if isnull(ls_filename) then return -1
	al_x = ll_x
	al_y = ll_y
	al_width = ll_width
	al_height = ll_height
	as_filename = ls_filename
	return 1
case 0
	return 0
case else
	return -1
end choose
end function

public function integer of_get_shipment_types (datawindow adw_target, ref long ala_list[], ref long ala_count[]);long lla_work_list[], lla_work_count[], ll_row, ll_check, ll_found_ndx, ll_count

for ll_row = 1 to adw_target.rowcount()
	ll_check = adw_target.object.ds_ship_type[ll_row]
	n_cst_anyarraysrv lnv_anyarray
	ll_found_ndx = lnv_anyarray.of_Find(lla_work_list, ll_check, 1, ll_count)
	if ll_found_ndx > 0 then
		lla_work_count[ll_found_ndx] ++
	else
		ll_count ++
		lla_work_list[ll_count] = ll_check
		lla_work_count[ll_count] = 1
	end if
next

ala_list = lla_work_list
ala_count = lla_work_count

return 1
end function

public function integer of_set_logo (powerobject apo_target, ref dwobject adwo_target, long al_logo_id);long ll_x, ll_y, ll_width, ll_height
string ls_filename

if not of_get_logo_info(al_logo_id, ll_x, ll_y, ll_width, ll_height, ls_filename) = 1 then &
	return -1

if not of_modify_picture(apo_target, adwo_target, "~t" + string(ll_x), &
	"~t" + string(ll_y), "~t" + string(ll_width), "~t" + string(ll_height), &
	"~t" + "'" + ls_filename + "'") = 1 then return -1

return 1
end function

public function string of_get_message_header (string as_type);choose case as_type
case "MANIFEST!"
	return "Manifest Marked Shipments"
case else //including "INVOICE!"
	return "Bill Marked Shipments"
end choose
end function

public function boolean of_get_copies (s_longs astr_old_copies, ref s_longs astr_new_copies);//modified method to return true if the OK button is selected.

Boolean	lb_Continue
//boolean lb_anysel
//integer li_ndx
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm


openwithparm(w_bill_copies, astr_old_copies)
IF IsValid ( message.powerobjectparm ) THEN
	lnv_Msg = message.powerobjectparm
END IF

IF lnv_Msg.of_Get_Parm ( "CONTINUE" , lstr_parm ) <> 0 THEN
	lb_Continue = lstr_Parm.ia_value
END IF

IF lb_Continue THEN
	
	IF lnv_Msg.of_Get_Parm ( "COPIES" , lstr_parm ) <> 0 THEN
		astr_new_copies = lstr_Parm.ia_value
	ELSE
		lb_Continue = FALSE
	END IF

END IF

RETURN lb_Continue

//astr_new_copies = message.powerobjectparm
//
//lb_anysel = false
//
//for li_ndx = 1 to upperbound(astr_new_copies.longar)
//	if astr_new_copies.longar[li_ndx] > 0 then
//		lb_anysel = true
//		exit
//	end if
//next
//
//return lb_anysel
end function

public function integer of_register (datawindow adw_target);idwa_registry[upperbound(idwa_registry) + 1] = adw_target

return 1
end function

public function integer of_retrieve (long ala_ids[], string as_type);//This function assumes the calling script knows what it is doing in requesting
//the ids in ala_ids be retrieved in the format requested in as_type.

integer li_result, li_success_count, li_Retrieve
datawindow ldw_target
String	ls_Type, &
			ls_InvoiceSortOrder
u_Bills	luo_Bills
u_dw_Bill_Manifest	luo_Manifest

if this.of_ready() = false then goto failure

do
	li_result = of_get_dw(as_type, ldw_target, ldw_target)
	if li_result = 1 then

		ls_Type = of_GetType ( ldw_Target )

		CHOOSE CASE ls_Type
		CASE "MANIFEST!"
			luo_Manifest = ldw_Target
			li_Retrieve = luo_Manifest.of_Retrieve ( ala_Ids )
		CASE ELSE
			luo_Bills = ldw_Target
			li_Retrieve = luo_Bills.of_Retrieve ( ala_Ids )
		END CHOOSE

		if li_Retrieve = -1 then
			goto failure
		else
			li_success_count ++
		end if
	end if
loop while li_result = 1

if li_success_count = 0 then return 0

return 1

failure:
return -1
end function

public function integer of_manifest_check (ref long ala_ids[], ref string as_type);//Return Values:  -1 : Error, 0 : Not a manifest, 1 : A manifest (as_type will be
//changed to MANIFEST! and ala_ids[] will contain all the ids in the manifest)

long lla_ids[], ll_RowCount, ll_Row, ll_TestExtension
string ls_base, ls_select, ls_syntax, ls_style, ls_error, ls_Test, ls_TestBase
datastore lds_work, lds_Check
Boolean	lb_HasNonManifest

n_cst_AnyArraySrv	 lnv_ArraySrv

lds_Check = CREATE DataStore
lds_Check.DataObject = "d_ManifestCheck"
lds_Check.SetTransObject ( SQLCA )

ll_RowCount = lds_Check.Retrieve ( ala_Ids )
COMMIT ;

IF ll_RowCount > 0 THEN

	FOR ll_Row = 1 TO ll_RowCount

		ls_Test = lds_Check.object.ds_pronum [ ll_Row ]
		ls_TestBase = ""
		ll_TestExtension = 0

		if This.of_manifest_extract(ls_Test, ls_TestBase, ll_TestExtension) then

			IF lb_HasNonManifest THEN

				DESTROY lds_Check
				RETURN -2

			ELSEIF ls_Base = "" THEN

				//No prior manifest identified -- note the one we just found.
				ls_Base = ls_TestBase

			ELSEIF ls_Base = ls_TestBase THEN

				//Same as manifest identified previously.  OK.

			ELSE

				//Different from manifest identified previously.  Not OK.
				DESTROY lds_Check
				RETURN -2

			END IF

		ELSE

			lb_HasNonManifest = TRUE

			IF Len ( ls_Base ) > 0 THEN
				//We've previously had something that was in a manifest
				DESTROY lds_Check
				RETURN -2
			END IF		

		end if

	NEXT

ELSEIF ll_RowCount = 0 THEN

	DESTROY lds_Check
	RETURN 0

ELSE

	DESTROY lds_Check
	RETURN -1

END IF


DESTROY lds_Check

IF Len ( ls_Base ) > 0 THEN
	//We've got a manifest
ELSE
	RETURN 0
END IF


ls_select = "SELECT ds_id FROM disp_ship WHERE left(ds_pronum, LENGTH_VALUE!) "+&
	" = 'PRONUM_VALUE!'"

ls_select = substitute(ls_select, "LENGTH_VALUE!", string(len(ls_base) + 2))
ls_select = substitute(ls_select, "PRONUM_VALUE!", ls_base + "--")

ls_style = ""
ls_error = ""
ls_syntax = sqlca.syntaxfromsql(ls_select, ls_style, ls_error)

if len(ls_error) > 0 then return -1

lds_work = create datastore

ls_error = ""
lds_work.create(ls_syntax, ls_error)

if len(ls_error) > 0 then
	destroy lds_work
	return -1
end if

lds_work.settransobject(sqlca)

if lds_work.retrieve() <= 0 then
	rollback ;
	destroy lds_work
	return -1
else
	commit ;
	lla_ids = lds_work.object.ds_id.primary
	lnv_ArraySrv.of_SortLong( lla_ids )
	ala_ids = lla_ids
	as_type = "MANIFEST!"
	destroy lds_work
	return 1
end if
end function

public function boolean of_manifest_extract (string as_pronum, ref string as_base, ref long al_extension);//This function will extract the base pronum and extension values from a full manifest
//pronum.  The function returns true and sets the values of as_base and al_extension
//if as_pronum is a properly formatted manifest pronum.  The function returns false
//and sets the two reference values to null if as_pronum is not in manifest format.

integer li_ndx

for li_ndx = len(as_pronum) - 1 to 1 step -1
	if mid(as_pronum, li_ndx, 2) = "--" then exit
next

if li_ndx > 1 then
	as_base = left(as_pronum, li_ndx - 1)
	al_extension = long(mid(as_pronum, li_ndx + 2))
	return true
else
	setnull(as_base)
	setnull(al_extension)
	return false
end if
end function

protected function integer of_validate_billtos (datawindow adw_target);//Return Values:  1 = Billtos are OK, based on the criteria in gnv_cst_companies.of_select()
//							Note: The function will currently not fail due to a null billto.  
//						-1 = Billtos are not OK, or there was a processing error

//Note on the approach:  We could simply loop through the rows, but using a unique array 
//will be more efficient if values repeat.

long ll_checkloop, lla_ids[]
string ls_message, ls_type
s_co_info lstr_company
s_anys lstr_work

ls_Type = of_GetType ( adw_Target )

CHOOSE CASE ls_Type
CASE "MANIFEST!", "INVOICE!"
	//Types are valid.
CASE ELSE
	MessageBox ( of_get_message_header(ls_type), "Could not process billing request.~n~n"+&
		"Request cancelled.", exclamation!)
	RETURN -1
END CHOOSE

if adw_target.rowcount() > 0 then

	lla_ids = adw_target.object.ds_billto_id.primary

	n_cst_anyarraysrv lnv_anyarray
	any laa_ids1[], laa_ids2[]
	laa_ids1 = lla_ids
	lnv_anyarray.of_GetUnique( laa_ids1, laa_ids2 )
	lla_ids = laa_ids2

	choose case ls_type
	case "MANIFEST!"
		if upperbound(lla_ids) > 1 then
			ls_message = "There is more than one billto among the shipments you have "+&
				"selected.~n"
		end if
	end choose

end if

if ls_message = "" then
	for ll_checkloop = 1 to upperbound(lla_ids)
		if gnv_cst_companies.of_select(lstr_company, "BILLING!", false, "", true, &
			lla_ids[ll_checkloop], false, false) = 1 then
				//No processing needed
		elseif len(message.stringparm) > 0 then
			ls_message += message.stringparm + "~n"
		else
			ls_message = "Could not validate billto information."
		end if
	next
end if

if len(ls_message) > 0 then
	ls_message = "Cannot process billing request due to the following conflicts:~n~n" +&
		ls_message + "~nBilling request cancelled."
	messagebox(of_get_message_header(ls_type), ls_message)
	return -1
else
	return 1
end if
end function

protected function integer of_validate_status (datawindow adw_target);//Returns: 1 (All statuses are billable), -1 (At least one shipment has an unbillable status)

string ls_list, ls_reject, ls_type
long ll_row, ll_RowCount

Integer	li_Return = 1


ls_Type = This.of_GetType ( adw_Target )
ll_RowCount = adw_Target.RowCount ( )

FOR ll_row = 1 TO ll_RowCount

	CHOOSE CASE adw_target.object.ds_status[ll_row]

	CASE gc_Dispatch.cs_ShipmentStatus_Authorized, gc_Dispatch.cs_ShipmentStatus_Audited
		//Status is OK.  No processing needed.

	CASE ELSE
		if len(ls_list) > 0 then ls_list += ", "
		ls_list += adw_target.object.ds_pronum[ll_row]
		li_Return = -1

	END CHOOSE

NEXT


if li_Return = -1 then
	ls_reject = "Cannot process billing request due to status changes for the following "+&
		"shipments: " + ls_list + ".  Please refresh the shipment list and retry."
	messagebox(This.of_get_message_header(ls_type), ls_reject)
end if


return li_Return


end function

public function integer of_validate_shipments (datawindow adw_target);//Return Values:  1 = The shipments retrieved in adw_target are OK for billing.
//						-1 = The shipments are not OK, or there was a processing error.
//								An explanatory message is returned in as_message.

if of_validate_billtos(adw_target) = -1 then return -1

if of_validate_status(adw_target) = -1 then return -1

return 1
end function

public function boolean of_manifest_extract (string as_pronum);string ls_base
long ll_extension

return of_manifest_extract(as_pronum, ls_base, ll_extension)
end function

public function integer of_process_bills (datawindow adw_target);long ll_bill_row, ll_billseq, ll_billseq_row, ll_id, ll_shiptype, ll_foundrow
string ls_pronum_base, ls_pronum, ls_type, ls_Invoice, ls_error
char lch_status
date ld_bill_date
n_cst_BillSeq	lnv_BillSeq
n_cst_shiptype	lnv_ShipType
n_cst_ShipmentManager	lnv_ShipmentMgr
n_cst_LicenseManager	lnv_LicenseManager
u_dw_Bill_Manifest	luo_Manifest
n_cst_numerical lnv_numerical

IF lnv_LicenseManager.of_GetLicenseExpired ( ) THEN
	RETURN -1
END IF

ls_Type = of_GetType ( adw_Target )

CHOOSE CASE ls_Type
CASE "MANIFEST!"
	luo_Manifest = adw_Target
CASE "INVOICE!"
	//Type is valid.
CASE ELSE
	RETURN -1
END CHOOSE

if lnv_numerical.of_IsNullOrNotPos(adw_target.rowcount()) then goto failure
if this.of_ready() = false then goto failure
if lnv_BillSeq.of_ready(true) = false then goto failure



//ld_bill_date = date(datetime(today()))
ld_Bill_Date = id_invoiceDate


adw_target.setredraw(false)

for ll_bill_row = 1 to adw_target.rowcount()

	if not (ls_type = "MANIFEST!" and ll_bill_row > 1) then

		choose case ls_type
		case "MANIFEST!"
			ll_shiptype = luo_Manifest.of_get_shiptype()
		case "INVOICE!"
			ll_shiptype = adw_target.object.ds_ship_type[ll_bill_row]
		end choose
	
		if lnv_numerical.of_IsNullOrNotPos(ll_shiptype) then goto failure
	
		if isvalid(lnv_ShipType) then
			if lnv_ShipType.ids_data.object.st_id[1] = ll_shiptype then
				//We've already got the matching object
			else
				//Destroy the existing object to force getting the matching one, below
				destroy lnv_ShipType
			end if
		end if

		if not isvalid(lnv_ShipType) then
			if not inv_cst_ship_type.of_get_object(ll_shiptype, lnv_ShipType) = 1 &
				then goto failure
	
			ll_billseq = lnv_ShipType.ids_data.object.st_billing_sequence[1]
		end if
	
		if lnv_BillSeq.of_find(ll_billseq, ll_billseq_row) = -1 then goto failure
		if ll_billseq_row > 0 then
			ls_pronum_base = lnv_BillSeq.ids_billseq.getitemstring(ll_billseq_row, &
				"comp_next_invoice")
			if lnv_numerical.of_IsNullOrNotPos(len(trim(ls_pronum_base))) then goto failure
			lnv_BillSeq.ids_billseq.object.bs_next[ll_billseq_row] = &
				lnv_BillSeq.ids_billseq.object.bs_next[ll_billseq_row] + 1
		else
			goto failure
		end if

	end if

	choose case ls_type
	case "MANIFEST!"
		ls_pronum = ls_pronum_base + "--" + string(ll_bill_row, "000")
	case "INVOICE!"
		ls_pronum = ls_pronum_base
	end choose

	adw_target.object.ds_pronum[ll_bill_row] = ls_pronum
	
	IF ib_UseShipDate THEN
		ld_bill_date = adw_target.object.ds_Ship_Date[ ll_bill_row ]
	END IF
	
	adw_target.object.ds_bill_date[ll_bill_row] = ld_bill_date

next

choose case ls_type
case "MANIFEST!"
	if luo_Manifest.of_set_pronum(ls_pronum_base) = -1 then goto failure
	if luo_Manifest.of_set_bill_date(ld_bill_date) = -1 then goto failure
end choose

adw_target.setredraw(true) //This used to follow the commit

if lnv_BillSeq.ids_billseq.update() = -1 then goto rollitback


String	ls_ModLog



for ll_bill_row = 1 to adw_target.rowcount()
	ll_id = adw_target.object.ds_id[ll_bill_row]
	lch_status = adw_target.object.ds_status[ll_bill_row]
	ls_pronum = adw_target.object.ds_pronum[ll_bill_row]
	
	IF ib_UseShipDate THEN
		ld_bill_date = adw_target.object.ds_Ship_Date[ ll_bill_row ]
	END IF
	
	
	Select ds_mod_log  into :ls_ModLog From disp_ship where ds_id = :ll_id;
	
	ls_ModLog += string(today(), "m/d/yy") + "~t" + string(now(), "h:mmA/P") + "~t"
	ls_ModLog += "BILLED~t~t"
	ls_ModLog += gnv_App.of_GetUserId ( ) + "~r~n"

	//Added By Dan in an attempt to Capture the duplicate invoice error on 2-19-07
	Select ds_pronum  into :ls_Invoice From disp_ship where ds_pronum = :ls_pronum;
	IF sqlca.sqlcode = 0 THEN
		//it was found , there could be a potential error during the update.  If there is we will record this message in rollitback.
		ls_error = "The invoice "+ ls_pronum + " already exists in Profit Tools."
	END IF
	////////////////////
	update disp_ship set ds_pronum = :ls_pronum, ds_status = 'W', ds_bill_date = :ld_bill_date, 
		ds_intsig = 0 , ds_mod_log = :ls_ModLog where ds_id = :ll_id and ds_status = :lch_status ;
	if not (sqlca.sqlcode = 0 and sqlca.sqlnrows = 1) then goto rollitback

//	The status change is no longer necessary, but do we want the intsig change?
//	update disp_events set de_status = 'W', de_intsig = 0 where de_shipment_id = :ll_id ;
//	if not (sqlca.sqlcode = 0) then goto rollitback
next

commit ;
//adw_target.setredraw(true)  I've moved this above the updates.


//Update the shipment cache
lnv_ShipmentMgr.of_RefreshShipments ( FALSE )

return 1

rollitback:
rollback ;
IF len(ls_error) > 0 THEN
	this.of_recordmessage( ls_error )	//added by dan 2-19-07  this message will be reported in of_bill
END IF

failure:
adw_target.setredraw(true)
return -1
end function

protected function integer of_get_dw (string as_type, datawindow adw_after, ref datawindow adw_next);integer li_ndx

for li_ndx = 1 to upperbound(idwa_registry)
	if isvalid(idwa_registry[li_ndx]) then
		if of_GetType ( idwa_registry[li_ndx] ) = as_type then
			if isvalid(adw_after) then
				if adw_after = idwa_registry[li_ndx] then continue
			end if
			adw_next = idwa_registry[li_ndx]
			return 1
		end if
	end if
next

return 0
end function

protected function integer of_get_posting_lists (datawindow adw_target, ref s_anys astr_lists);long ll_bill_row, ll_shiptype
n_cst_shiptype lnv_shiptype
integer li_ndx
boolean lb_matched
string ls_check
s_anys lstr_empty
n_cst_numerical lnv_numerical

astr_lists = lstr_empty

long lla_type_list[], lla_type_count[], lla_company_count[], lla_sales_count[], lla_recv_count[]
string lsa_company_list[], lsa_sales_list[], lsa_recv_list[]

if this.of_ready() = false then goto failure

for ll_bill_row = 1 to adw_target.rowcount()

	ll_shiptype = adw_target.object.ds_ship_type[ll_bill_row]

	if lnv_numerical.of_IsNullOrNotPos(ll_shiptype) then continue

	if isvalid(lnv_shiptype) then
		if lnv_shiptype.ids_data.object.st_id[1] = ll_shiptype then
			//We've already got the matching object
		else
			//Destroy the existing object to force getting the matching one, below
			destroy lnv_shiptype
		end if
	end if

	if not isvalid(lnv_shiptype) then
		if not inv_cst_ship_type.of_get_object(ll_shiptype, lnv_shiptype) = 1 &
			then goto failure
	end if

	//Shipment Type matching

	lb_matched = false

	for li_ndx = 1 to upperbound(lla_type_list)
		if lla_type_list[li_ndx] = ll_shiptype then
			lb_matched = true
			lla_type_count[li_ndx] ++
		end if
	next

	if not lb_matched then
		lla_type_list[upperbound(lla_type_list) + 1] = ll_shiptype
		lla_type_count[upperbound(lla_type_count) + 1] = 1
	end if


	//Posting Company matching

	lb_matched = false
	ls_check = lnv_shiptype.ids_data.object.st_accounting_company[1]

	if len(trim(ls_check)) > 0 then
		for li_ndx = 1 to upperbound(lsa_company_list)
			if lsa_company_list[li_ndx] = ls_check then
				lb_matched = true
				lla_company_count[li_ndx] ++
			end if
		next
	
		if not lb_matched then
			lsa_company_list[upperbound(lsa_company_list) + 1] = ls_check
			lla_company_count[upperbound(lla_company_count) + 1] = 1
		end if
	end if


//** logic for new account maps **



//****


	//Posting Account matching : Sales

	lb_matched = false
	ls_check = lnv_shiptype.ids_data.object.st_accounting_sales[1]

	if len(trim(ls_check)) > 0 then
		for li_ndx = 1 to upperbound(lsa_sales_list)
			if lsa_sales_list[li_ndx] = ls_check then
				lb_matched = true
				lla_sales_count[li_ndx] ++
			end if
		next
	
		if not lb_matched then
			lsa_sales_list[upperbound(lsa_sales_list) + 1] = ls_check
			lla_sales_count[upperbound(lla_sales_count) + 1] = 1
		end if
	end if

	//Posting Account matching : AccessorialSales

	lb_matched = false
	ls_check = lnv_shiptype.ids_data.object.st_accounting_accessorialsales[1]

	if len(trim(ls_check)) > 0 then
		for li_ndx = 1 to upperbound(lsa_sales_list)
			if lsa_sales_list[li_ndx] = ls_check then
				lb_matched = true
				lla_sales_count[li_ndx] ++
			end if
		next
	
		if not lb_matched then
			lsa_sales_list[upperbound(lsa_sales_list) + 1] = ls_check
			lla_sales_count[upperbound(lla_sales_count) + 1] = 1
		end if
	end if


	//Posting Account matching : Recv

	lb_matched = false
	ls_check = lnv_shiptype.ids_data.object.st_accounting_ar[1]

	if len(trim(ls_check)) > 0 then
		for li_ndx = 1 to upperbound(lsa_recv_list)
			if lsa_recv_list[li_ndx] = ls_check then
				lb_matched = true
				lla_recv_count[li_ndx] ++
			end if
		next
	
		if not lb_matched then
			lsa_recv_list[upperbound(lsa_recv_list) + 1] = ls_check
			lla_recv_count[upperbound(lla_recv_count) + 1] = 1
		end if
	end if

next

astr_lists.anys[1] = lla_type_list
astr_lists.anys[2] = lla_type_count

astr_lists.anys[3] = lsa_company_list
astr_lists.anys[4] = lla_company_count

astr_lists.anys[5] = lsa_sales_list
astr_lists.anys[6] = lla_sales_count

astr_lists.anys[7] = lsa_recv_list
astr_lists.anys[8] = lla_recv_count

destroy lnv_shiptype
return 1

failure:
destroy lnv_shiptype
return -1
end function

protected function integer of_get_posting_company (string asa_company_list[], long ala_company_count[], long al_shipment_count, ref string as_posting_company);long ll_noco_shipcount
string ls_work
integer li_ndx

setnull(as_posting_company)

string ls_message_header = "Create AR Batch"
string ls_reject = "Could not process billing request.  Request cancelled."

n_cst_anyarraysrv lnv_anyarray
if lnv_anyarray.of_SummLong(ala_company_count) < al_shipment_count then
	ls_reject = "One or more shipment types used in this batch do not have a posting "+&
		"company specified.  Please verify your shipment type setup."
	goto reject

elseif upperbound(asa_company_list) = 1 then
	as_posting_company = asa_company_list[1]

else
	ls_work = ""
	ll_noco_shipcount = al_shipment_count
	
	for li_ndx = 1 to upperbound(asa_company_list)
		ls_work += asa_company_list[li_ndx] + " (" + string(ala_company_count[li_ndx]) + ")~n"
		ll_noco_shipcount -= ala_company_count[li_ndx]
	next

	if ll_noco_shipcount > 0 then ls_work += "[UNSPECIFIED COMPANY] (" +&
		string(ll_noco_shipcount) + ")~n"
	ls_reject = "The shipments you have marked do not all post to the same "+&
		"company (based on their shipment types).  In order to create an AR batch, "+&
		"only those shipments associated with ONE valid company can be billed together.  "+&
		"The shipments you have marked break down as follows:~n~n" + ls_work +&
		"~nPlease adjust your selections and retry."
	goto reject

end if

return 1

reject:
messagebox(ls_message_header, ls_reject)
return 0
end function

protected function boolean of_get_acct_cos (datawindow adw_target, ref datastore ads_acct_cos);long ll_newrow, lla_ids[]
any laa_ids1[], laa_ids2[]
integer li_ndx
s_anys lstr_work
s_co_info lstr_company
n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE )

destroy ads_acct_cos

ads_acct_cos = create datastore
ads_acct_cos.dataobject = "d_acct_cos"

if adw_target.rowcount() > 0 then
	lla_ids = adw_target.object.ds_billto_id.primary
	n_cst_anyarraysrv lnv_anyarray
	laa_ids1 = lla_ids
	lnv_anyarray.of_GetUnique( laa_ids1, laa_ids2 )
	lla_ids = laa_ids2
end if

for li_ndx = 1 to upperbound(lla_ids)

	lnv_Company.of_SetSourceId ( lla_Ids [ li_Ndx ] )

	IF lnv_Company.of_HasSource ( ) THEN

		ll_newrow = ads_acct_cos.insertrow(0)
		ads_acct_cos.object.co_id[ll_newrow] = lla_ids[li_ndx]
		ads_acct_cos.object.xx_acct_name[ll_newrow] = lnv_Company.of_GetBillingName ( )
		ads_acct_cos.object.co_bill_acctcode[ll_newrow] = lnv_Company.of_GetAccountingId ( )
		ads_acct_cos.Object.co_HiddenDiscount [ ll_NewRow ] = lnv_Company.of_GetHiddenDiscount ( )

	END IF

next

ads_acct_cos.resetupdate()
ads_acct_cos.sort()

DESTROY lnv_Company

return true

//failure:
//return false
end function

protected function boolean of_payment_due (string as_payment_terms, date ad_document_date, ref date ad_payment_due);//Return Values:  true if the terms are recognized and processed, false if they are not.
//A return of false doesn't indicate failure, per se : the ad_payment_due will just
//be set to the document date, which is the intended behavior for missing or unrecognized
//payment terms.


string ls_work
integer li_pos, li_span, li_relative_days

as_payment_terms = upper(trim(as_payment_terms))
ad_payment_due = ad_document_date

if match(as_payment_terms, "NET *[0-9]+") then
	li_pos = pos(as_payment_terms, "NET")
	if li_pos > 0 then
		li_pos += 3
		for li_span = len(as_payment_terms) - li_pos + 1 to 1 step -1
			ls_work = mid(as_payment_terms, li_pos, li_span)
			if isnumber(ls_work) then
				li_relative_days = integer(ls_work)
				exit
			end if
		next
		if li_relative_days > 0 then
			ad_payment_due = relativedate(ad_document_date, li_relative_days)
			return true
		end if
	end if
end if

return false
end function

private function string of_gettype (datawindow adw_target);u_Bills	luo_Bills
u_dw_Bill_Manifest	luo_Manifest
String	ls_Null

CHOOSE CASE Lower ( adw_Target.DataObject )

CASE "d_invoice"
	luo_Bills = adw_Target
	RETURN luo_Bills.of_Get_Type ( )

CASE "d_bill_manifest"
	luo_Manifest = adw_Target
	RETURN luo_Manifest.of_Get_Type ( )

CASE "d_bill_manifest_portrait"
	luo_Manifest = adw_Target
	RETURN luo_Manifest.of_Get_Type ( )

CASE ELSE
	SetNull ( ls_Null )
	RETURN ls_Null

END CHOOSE
end function

public function integer of_getrequiredimagetypes (ref string asa_imageTypes[]);//Returns:   1 = Success (value returned by reference in asa_imageTypes[])
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
String	lsa_ImageTypes[]
Integer	li_SqlCode

Integer	li_Return = 1

n_cst_string	lnv_String



//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 31 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( ls_Description ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	
	lnv_String.of_ParseToArray ( ls_Description , ";" , lsa_ImageTypes  )
   asa_imageTypes[] = lsa_ImageTypes
	
END IF
 

RETURN li_Return

end function

public function integer of_getwarningimagetypes (ref String asa_ImageTypes[]);//Returns:   1 = Success (value returned by reference in asa_imageTypes[])
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
String	lsa_ImageTypes[]
Integer	li_SqlCode

Integer	li_Return = 1

n_cst_string	lnv_String



//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 32 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( ls_Description ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	
	lnv_String.of_ParseToArray ( ls_Description , ";" , lsa_ImageTypes  )
   asa_imageTypes[] = lsa_ImageTypes
	
END IF
 

RETURN li_Return

end function

public function integer of_getimagestoprint (ref string asa_types[]);//Returns:   1 = Success (value returned by reference in asa_imageTypes[])
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
String	lsa_ImageTypes[]
Integer	li_SqlCode

Integer	li_Return = 1

n_cst_string	lnv_String



//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 34 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( ls_Description ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	
	lnv_String.of_ParseToArray ( ls_Description , ";" , lsa_ImageTypes  )
   asa_Types[] = lsa_ImageTypes
	
END IF
 

RETURN li_Return

end function

public function integer of_bill (ref n_cst_msg anv_msg);/* 
RDT 01-02-03  Validate accounts with QuickBooks Direct
RDT 01-30-03 Changes to Account Validation
RDT 02-05-03 Added checks for carriers
RDT 8-25-03  Checks the message object from the 210 processing for error messages
*/

/*
	No longer checking the anv_msg for ship ids (IDS). The id array will be loaded from
	the shipment beos that are passed in anv_msg. 
	
	There was a problem in some of the logic after the image checking logic. The imaging 
	logic was removing ids from the list with missing images but the beo array still
	contained all of the shipments. Some of the logic after that is using the beo array 
	instead of the id array.
	
	The imaging logic was changed to remove the same shipments from the beo array that
	are removed from the id list.
	
	nwl 12/16/04
	

*/

string	ls_message_header, &
			ls_notice, &
			ls_category, &
			ls_posting_company, &
			lsa_blank[], &
			lsa_company_list[], &
			lsa_sales_list[], &
			lsa_recv_list[], &
			ls_type, &
			ls_invoicesortorder, &
			ls_errorMessage, &
			ls_reject = "Could not process billing request.  Request cancelled."

string 	lsa_accounts[], &
			lsa_Error[], &
			ls_Error, &
			ls_sort, &
			ls_PosString, &
			ls_IdList

boolean	lb_link_open, &
			lb_create_batch, &
			lb_success, &
			lb_InstalledImaging, &
			lb_UseCustomInvoice, &
			lb_UseManifestCustomInvoice, &
			lb_StopBilling, &
			lb_ProcessEDI, &
			lb_batch_by_company = true, &
			lb_PrintImages = TRUE, &
			lb_createcarrierpayable, &
			lb_ForceImagePrinting, & 
			lb_nonDirect, &
		   lb_StopBillProcess  // zmc - 2-20-04
			
boolean 	lb_ReBatchingSuccessful=false

decimal	lca_blank[], &
			lca_aramount[], &
			lca_salesamount[], & 
			lc_PostingAmount, &
			lc_HiddenDiscount
			
long	ll_result, &
		ll_target_count, &
		lla_FilteredIDs [], &
		lla_type_list[], &
		lla_type_count[], &
		lla_company_count[], &
		lla_sales_count[], &
		lla_recv_count[], &
		lla_Ids[], &
		ll_index, &
		ll_arraycount, &
		ll_row, &  
		ll_Ship, &
		ll_shipid, &
		ll_ShipCount, &
		ll_ErrorCount

Integer	li_Retrieve
Int   	li_RtnVal  // zmc - 2-20-04
			
Int		li_FilterReturn, &
			li_PrintReturn, &
			li_ArBatch
Long		i

datawindow				ldw_target
datastore				lds_acct_cos

n_cst_bso_accountingmanager	lnv_accountingmanager
n_cst_accountingdata				lnva_accountingdata[]
n_cst_Beo_Shipment				lnva_Shipments[]

n_cst_acctlink						lnv_cst_acctlink
n_cst_anyarraysrv					lnv_anyarray
n_cst_BillServices				lnv_BillServices
n_cst_LicenseManager				lnv_LicenseManager
n_cst_string						lnv_String
n_cst_bso_EDIManager				lnv_EDIManager			
n_cst_setting_billingarbatch	lnv_CreateArBatch

n_cst_msg				lnv_Msg
n_cst_msg				lnv_cst_msg
n_cst_msg				lnv_DateMsg
n_cst_msg				lnv_errormsg
n_cst_msg				lnv_error
n_cst_msg				lnv_210msg
n_cst_msg				lnv_blank


s_anys					lstr_posting_lists
s_longs					lstr_selection
s_parm					lstr_parm
s_PageSetupattrib 	lstr_pageSetup

s_Accounting_Transaction   lstr_transaction
s_accounting_distribution 	lstr_distribution[], lstra_distribution[], lstra_blankdist[]


u_Bills					luo_Bills
u_dw_Bill_Manifest	luo_Manifest

n_cst_setting_produce210edi	lnv_setting			//added by dan
lnv_msg = anv_Msg

IF Not IsValid ( lnv_Msg ) THEN
	GOTO stop_billing
END IF

//	Request a lock for user
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Billing, "E" ) < 0 THEN
	ls_Reject = ""
	goto stop_billing
END IF

IF lnv_msg.of_Get_Parm ( "SHIPMENTS" , lstr_Parm ) <> 0 THEN
	lnva_Shipments = lstr_Parm.ia_Value
	
	FOR i = 1 TO UpperBound ( lnva_Shipments )
		IF IsValid ( lnva_Shipments[i] ) THEN 
			lla_IDs[i] = lnva_Shipments[i].of_GetID ( )
		ELSE			
			ls_Reject = "Encountered an invalid object. " + ls_Reject 
			GOTO Stop_billing
		END IF
	NEXT

n_cst_setting_edi204version	lnv_204Version
lnv_204Version = create n_cst_setting_edi204version
IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
	lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
	lb_nondirect = false
ELSE
	lb_nondirect = true
END IF	
destroy lnv_204Version	

//commented because this is no longer being set in wf_bill. The ids should 
//always come from the beos. nwl 12/16/04


//ELSEIF lnv_msg.of_Get_Parm ( "IDS" , lstr_Parm ) <> 0 THEN
//	lla_IDS = lstr_parm.ia_Value
//	this.of_getshipments( lla_IDS, lnva_Shipments )
END IF

IF lnv_msg.of_Get_Parm ( "TYPE" , lstr_Parm ) <> 0 THEN
	ls_Type = lstr_parm.ia_Value
END IF

IF lnv_msg.of_Get_Parm ( "PROCESSEDI" , lstr_Parm ) <> 0 THEN
	lb_ProcessEDI = lstr_parm.ia_Value
END IF

IF lnv_msg.of_Get_Parm ( "CATEGORY" , lstr_Parm ) <> 0 THEN
	ls_category = lstr_parm.ia_Value
END IF

IF lnv_Msg.of_get_parm( "ARBATCH", lstr_Parm) > 0 THEN
	ib_ARBatch = TRUE
END IF

ls_message_header = this.of_get_message_header(ls_type)

IF lnv_LicenseManager.of_GetLicenseExpired ( ) THEN
	MessageBox ( ls_message_header, lnv_LicenseManager.of_GetExpirationNotice ( ) +&
		"The billing function is suspended.  Please contact Profit Tools to extend your "+&
		"registration.", Exclamation!)
	ls_Reject = ""
	goto stop_billing
END IF

if not this.of_get_dw(ls_type, ldw_target, ldw_target) = 1 then goto stop_billing

setpointer(hourglass!)

lds_acct_cos = create datastore

if ib_ARBatch then
	//skip
else
	IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Imaging ) THEN
	
		// this will unlock pegasus if not already done
		n_cst_bso_ImageManager_pegasus	lnv_Imagemanager
		lnv_ImageManager = CREATE n_cst_bso_ImageManager_Pegasus
		
		IF lnv_ImageManager.of_CheckConnection ( )  <> 0 THEN
			MessageBox ("Image Printing" , "The controls needed to print the associated images could not be located or unlocked. Printing of the images will not occur." ) 
			lb_PrintImages = FALSE
		END IF
		
		IF isValid ( lnv_ImageManager ) THEN
			Destroy lnv_ImageManager
		END IF
		
		//n_cst_pegasus_Print 	lnv_PegPrint
		//lnv_PegPrint = CREATE n_cst_pegasus_Print
		
		// gets required image types. if image DNE the id is filtered so it is not processed
		// it also determines if there are any images that need to be printed
		IF UpperBound ( lnva_Shipments ) > 0 THEN
			
			//added 12/6/04 - nwl
			lla_FilteredIDs = lla_ids
			
			li_FilterReturn =  This.of_FilterIDsByImages( lnva_Shipments , lla_FilteredIDs ) 
				
			CHOOSE CASE li_FilterReturn
				CASE -1   // Failure
					lb_PrintImages = FALSE
					goto stop_billing
					
				CASE 0 // user canceled processing	
					ls_Reject = ""
					lb_PrintImages = FALSE
					goto stop_billing
					
				CASE 1 //success with no images
					lb_PrintImages = FALSE
					lla_ids = lla_FilteredIDs
					
				CASE 2 // sucess w/ images to print
					
					//lb_PrintImages = TRUE
					lla_ids = lla_FilteredIDs
					
				CASE ELSE // unexpected return
					lb_PrintImages = FALSE
					goto stop_billing
					
			END CHOOSE
		ELSE
			lb_PrintImages = FALSE
		END IF
	ELSE // imaging Not licensed
		lb_PrintImages = FALSE
			
	END IF // imaging installed?
end if

IF upperbound(lla_ids) = 0 THEN  // RPZ 6/12/03
	goto stop_billing
END IF

CHOOSE CASE ls_type
CASE "MANIFEST!"
	luo_Manifest = ldw_Target
	li_Retrieve = luo_Manifest.of_Retrieve ( lla_ids )
CASE ELSE
	
	//build sort
	lnv_String.of_arraytostring( lla_ids, ',', ls_IdList)
	ls_PosString = "," + ls_IdList + ","
	ls_Sort = "Pos ( '" + ls_PosString + "',  ',' + String ( ds_id ) + ',' ) A"

	luo_Bills = ldw_Target
	luo_Bills.of_setsort( ls_Sort )
	li_Retrieve = luo_Bills.of_Retrieve ( lla_ids )
	
END CHOOSE

if li_Retrieve = upperbound(lla_ids) then
	ll_target_count = ldw_target.rowcount()
else
	goto stop_billing
end if

// transplant from below
IF Not ib_Arbatch THEN
	lstr_Parm.is_Label = "TYPE"
	lstr_Parm.ia_Value = ls_Type
	lnv_DateMsg.of_Add_Parm ( lstr_Parm )

	IF THIS.of_GetInvoiceDate ( lnv_DateMsg ) <> 1 THEN
		ls_Reject = ""
		goto Stop_billing
	END IF
	
	IF THIS.of_ValidateInvoiceDateSelection ( ldw_Target ) <> 1 THEN
		ls_Reject = ""
		goto Stop_billing
	END IF
END IF

//RDT 8-25-03 - Validate 210 START 
IF lb_ProcessEDI THEN
	if lb_nondirect then
		lnv_EDIManager = CREATE n_cst_bso_EDIManager		
	
		lnv_210msg = lnv_msg
		
		lstr_Parm.is_Label = "VALIDATE" 						
		lstr_Parm.ia_Value = TRUE 
		lnv_210msg.of_Add_Parm ( lstr_Parm )					
		
		lnv_EDIManager.of_createtransactionset(lnv_EDIManager.cl_transaction_set_210 , lnv_210msg )
	
		If lnv_210msg.of_Get_Parm ( "210ERROR" , lstr_Parm ) <> 0 Then
			ls_Reject = lstr_parm.ia_Value
			
			If IsValid( lnv_EDIManager ) then Destroy( lnv_EDIManager )
			
			goto stop_billing
			
		End If
	end if
END IF

IF Len ( is_AcctLink ) > 0 THEN
	lnv_cst_AcctLink = CREATE USING is_AcctLink
ELSE
	//I'm not sure whether I should instantiate the base object here or not.... 4/18/06 Yup Need the object below 
	lnv_cst_AcctLink = CREATE n_cst_acctlink // doing this for the sole purpose of reocording the 'batching info'
	goto process_billing
END IF


if ib_ARBatch then
	//skip
else

	if this.of_validate_shipments(ldw_target) = -1 then
		ls_reject = ""
		goto stop_billing
	end if
	
	lnv_CreateArBatch = Create n_cst_setting_billingarbatch
	choose case lnv_CreateArBatch.of_GetValue()
	case lnv_CreateArBatch.cs_Yes
		li_ArBatch = 1
	case lnv_CreateArBatch.cs_No
		li_ArBatch = 2
	case lnv_CreateArBatch.cs_AskEachTime
		li_ArBatch = messagebox(ls_message_header, "Do you want to create an AR batch?", &
		question!, yesnocancel!, 1)
	end choose
	Destroy lnv_CreateArBatch
	
	
	choose case li_ArBatch
	case 2
		goto process_billing
	case 3
		ls_reject = "" //suppresses error message
		goto stop_billing
	end choose

end if

if not this.of_get_posting_lists(ldw_target, lstr_posting_lists) = 1 then goto stop_billing

lla_type_list = lstr_posting_lists.anys[1]
lla_type_count = lstr_posting_lists.anys[2]

lsa_company_list = lstr_posting_lists.anys[3]
lla_company_count = lstr_posting_lists.anys[4]

lsa_sales_list = lstr_posting_lists.anys[5]
lla_sales_count = lstr_posting_lists.anys[6]

lsa_recv_list = lstr_posting_lists.anys[7]
lla_recv_count = lstr_posting_lists.anys[8]

//It is important that all shipments be accounted for in each of the above categories, 
//with the possible exception of company_count, if not batch_by_company.

if lnv_anyarray.of_SummLong(lla_type_count) < ll_target_count then
	ls_reject = "One or more shipments in this batch do not have a shipment type "+&
		"specified.  Billing request cancelled."
	goto stop_billing
end if

//RDT 01-30-03 - Start 

lsa_sales_list = lsa_blank
lsa_recv_list  = lsa_blank

for ll_row = 1 to ldw_target.rowcount()

	//get items from shipment and total amounts by amount type
	ll_shipid = ldw_Target.Object.ds_id [ ll_Row ]
	lstra_distribution = lstra_blankdist
	ll_ShipCount = UpperBound( lnva_Shipments )
	for ll_index = 1 to ll_shipcount
		if lnva_Shipments[ll_index].of_getid() = ll_shipid then
			lc_PostingAmount = this.of_getdistribution(lnva_Shipments[ll_index], lstra_distribution, lc_HiddenDiscount, lnv_error )
			lnv_anyarray.of_appendstring(lsa_sales_list,isa_salesaccount)
			lnv_anyarray.of_appendstring(lsa_recv_list,isa_araccount)
			exit	
		end if	
	next

	IF lnv_error.of_Get_Parm ( "ERROR" , lstr_Parm ) <> 0 THEN
		lsa_error = lstr_parm.ia_Value
		ll_errorcount = upperbound(lsa_error)
		for ll_index = 1 to ll_errorcount
			ls_error += lsa_error[ll_index] + ' '
		next
	END IF
	if len(trim( ls_error ) ) > 0 then
		ls_reject = ls_error + " Could not create AR batch.  Billing request cancelled."
		goto stop_billing
	end if

next
//get rid of dupes
lnv_anyarray.of_getshrinked(lsa_sales_list,true,true)
lnv_anyarray.of_getshrinked(lsa_recv_list,true,true)

//RDT 01-30-03 - End

//RDT 01-02-03  Commented lines below replaced as of version 3.5.04 using of_prepare_batch to populate account list.
//lsa_sales_list = lsa_blank
//lsa_recv_list = lsa_blank
//lca_salesamount = lca_blank
//lca_aramount = lca_blank

for ll_index = 1 to ll_target_count
	lnv_accountingmanager = create n_cst_bso_accountingmanager
	if lnv_accountingmanager.of_checkforaccounts(lnva_shipments[ll_index], lnv_errormsg) = -1 then
		IF lnv_errormsg.of_Get_Parm ( "ERROR" , lstr_Parm ) <> 0 THEN
			ls_reject = "One or more shipment types used in this batch do not have posting "+&
				"accounts specified.  Please verify your shipment type setup."
			goto stop_billing
		END IF	
	end if
	destroy lnv_accountingmanager
next

if lb_batch_by_company then
	//The following function handles several checks at once, as well as attempting to
	//determine ls_posting_company.
	if not this.of_get_posting_company(lsa_company_list, lla_company_count, &
		ll_target_count, ls_posting_company) = 1 then
			ls_reject = "" //suppresses error message
			goto stop_billing
	end if
end if

if not this.of_get_acct_cos(ldw_target, lds_acct_cos) then goto stop_billing

choose case lnv_cst_acctlink.of_link_open(ls_posting_company)
case 1
	lb_link_open = true
case -2 //User chose No AR Batch
	goto process_billing
case -1, -3 //-1 = Error (or access failure), -3 = User chose Cancel Billing
	ls_reject = ""
	goto stop_billing
end choose

lnv_cst_msg.of_reset()

lstr_parm.is_label = "SALES"
lstr_parm.ia_value = lsa_sales_list
lnv_cst_msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "RECV"
lstr_parm.ia_value = lsa_recv_list
lnv_cst_msg.of_add_parm(lstr_parm)

if not lnv_cst_acctlink.of_validate_accounts(lnv_cst_msg, ls_notice) = 1 then
	ls_reject = "Cannot create an AR batch due to the following problems with your "+&
		"shipment type setup:~n" + ls_notice + "~n~nBilling request cancelled."
	goto stop_billing
end if

//Validate Customer List

lnv_cst_msg.of_reset()

lstr_parm.is_label = "TARGET"
lstr_parm.ia_value = lds_acct_cos
lnv_cst_msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "ACCTLINK"
lstr_parm.ia_value = lnv_cst_acctlink
lnv_cst_msg.of_add_parm(lstr_parm)

openwithparm(w_acct_cos_sync, lnv_cst_msg)
ll_result = message.doubleparm

choose case ll_result
case is >= 0  //Value is number of INVALID companies skipped by user
	if ll_result = lds_acct_cos.rowcount() then
		if messagebox(ls_message_header, "None of the companies being billed have a "+&
			"valid Accounting ID specified, so no AR batch will be created.  Do you want "+&
			"to proceed with billing anyway?", question!, yesno!, 2) = 2 then
				ls_reject = ""
				goto stop_billing
		else
				goto process_billing
		end if
	end if
case -1, -3 //-1 = Error, -3 = User chose cancel billing
	ls_reject = ""
	goto stop_billing
case else //Unexpected return value
	goto stop_billing
end choose


if ib_ARBatch then
	//skip
else
	if ls_category = "BROKERAGE" then
		if lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) then
			
			n_cst_bso_accountingmanager	lnv_AcctManager
			lnv_AcctManager = CREATE n_cst_bso_accountingmanager
			IF lnv_AcctManager.of_Createcarrierpayable( ) THEN			
				if this.of_createpayabledata(lnva_Shipments , lnva_accountingdata, ls_reject) > 0 then
					if upperbound(lnva_accountingdata) > 0 then
						lb_createcarrierpayable=true
						lstr_Parm.is_Label = "ACCOUNTINGDATA" 
						lstr_Parm.ia_Value = lnva_accountingdata
						lnv_Msg.of_Add_Parm ( lstr_Parm )
						if lnv_cst_acctlink.of_validatebatch ( lnva_accountingdata ) < 0 then
							goto stop_billing		
						end if	
					end if
				else
					//error returned in ls_reject
					goto stop_billing
				end if
				
				//create the batch
				if lb_createcarrierpayable then
					if upperbound(lnva_accountingdata) > 0 then
						//data already in lnv_msg		
						if lnv_cst_acctlink.of_BatchCreate ( lnv_Msg ) < 0 then	
							goto stop_billing		
						end if
					end if
				end if				
			end if	
		
		DESTROY ( lnv_AcctManager )
		END IF
	end if
end if

lb_create_batch = true

/* @@@@@@@@@@@@@@@@@@ PROCESS BILLING @@@@@@@@@@@@@@@@@@ */
process_billing:

if ib_ARBatch then
	//skip
else
	if this.of_process_bills(ldw_target) = -1 then goto stop_billing
	
	if lb_create_batch then
		lnv_cst_acctlink.of_recordARBatch(ldw_target, TRUE) //Already Validated
	else
		lnv_cst_acctlink.of_recordARBatch(ldw_target, FALSE) //Not Validated
	end if

end if


IF lb_ProcessEDI THEN

	lnv_EDIManager = CREATE n_cst_bso_EDIManager		
	
	if lb_nondirect then
		
		lnv_210msg = lnv_blank
		
		lstr_Parm.is_Label = "VALIDATE" 			 
		lstr_Parm.ia_Value = FALSE 							
		lnv_210msg.of_Add_Parm ( lstr_Parm )				
		
		lstr_Parm.is_Label = "SOURCE" 
		lstr_Parm.ia_Value = ldw_target
		lnv_210msg.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "IDS" 
		lstr_Parm.ia_Value = lla_IDs
		lnv_210msg.of_Add_Parm ( lstr_Parm )		
			
		lnv_EDIManager.of_createtransactionset(lnv_EDIManager.cl_transaction_set_210 , lnv_210msg)

	else	
		
		lnv_EDIManager.of_AddtoPendingCache ( lnva_Shipments, 'SHIPMENT', appeon_constant.cl_transaction_set_210, 'BILL' )
		if lnv_EDIManager.of_Saveeventcache( ) = 1 then
			lnv_setting = create n_cst_setting_produce210edi		//added by dan to stop aut send of 210
			IF lnv_setting.of_getValue() = lnv_setting.cs_yes THEN
				lnv_EDIManager.of_Generate ( appeon_constant.cl_transaction_set_210, lla_ids )
			END IF
			destroy lnv_setting
			lnv_EDIManager.of_SaveEventCache()
		else
			//do we stop process??
		end if
	end if

	IF isValid ( lnv_EDIManager ) THEN
		DESTROY lnv_EDIManager
	END IF	
	
END IF // process edi end

if lb_create_batch then

	lnv_cst_msg.of_reset()
	ls_reject = this.of_prepare_batch(ldw_target, lds_acct_cos, ls_posting_company, lnva_shipments, lnv_cst_msg)
	if len(trim(ls_reject)) > 0 then
		ls_reject += "Could not create AR batch.  Billing request cancelled."
		goto stop_billing
	end if

	choose case lnv_cst_acctlink.of_batch_create(lnv_cst_msg)
	case 1 //Success
		//No processing needed
	case -2 //User chose No AR Batch
		//No processing needed
	case -1 //Failure
		ls_reject = ""
		goto stop_billing
	case else //Unexpected return value
		goto stop_billing
	end choose

end if

if ib_ARBatch then
	//the rest is bills, we want to skip
	ls_reject = ""
	lb_ReBatchingSuccessful = true
	goto stop_billing
end if

//check system setting for custom invoices
// We are not going to allow the use of custom invoices if the user manifesting 
// invoices.
//MFS-12/05-Added ability for use of custom invoices while manifesting
IF ls_type <> "MANIFEST!" THEN
	IF lnv_BillServices.of_UseCustomInvoice ( lb_UseCustomInvoice ) = 0 THEN
		//user cancelled process
		lb_StopBilling = TRUE
	ELSE
		lb_StopBilling = FALSE
	END IF
ELSE
	IF lnv_BillServices.of_UseManifestCustomInvoice(lb_UseManifestCustomInvoice) = 0 THEN
		//user cancelled process
		lb_StopBilling = TRUE
	ELSE
		lb_StopBilling = FALSE
	END IF
END IF



//	IF Custom invoices, then they will be printed here
//	because of possible user errors during Word use. We don't
//	want to lose batch processing
IF NOT lb_StopBilling THEN

	IF lb_UseCustomInvoice THEN
		
		lb_PrintImages = FALSE
		// moving this here b.c. images for custom invoices are now going to be printed 
		// by the following code so they can be collated.
		
		IF lnv_BillServices.of_PrintCustomInvoices ( lla_Ids, TRUE ) < 0 THEN
			MessageBox ( "Print Custom Invoice", "Invoices have not been printed/sent but the bills have been processed.")
		END IF
	ELSEIF lb_UseManifestCustomInvoice THEN
		lb_PrintImages = FALSE
		IF lnv_BillServices.of_PrintManifestCustomInvoices ( lla_Ids, TRUE ) < 0 THEN
			MessageBox ( "Manifest Custom Invoice", "Manifest Invoice has not been printed/sent but the bills have been processed.")
		END IF
	ELSE // use old invoice style
	
		if this.of_get_copies(istr_billing_copies, lstr_selection) then
			istr_billing_copies = lstr_selection
			lb_StopBilling = FALSE
			THIS.of_Print ( ldw_target, lstr_selection )
			
		else
			
			IF lb_PrintImages THEN
				IF MessageBox( "Billing Images" , "Do you still want to print images?" , QUESTION! , YESNO! ) = 1 THEN
					lb_ForceImagePrinting = TRUE  // this was added since users may want to print images
															// even when not printing bills. 
					// I know this is not the best way but I don't want to risk bugs by doing any sort of
					// overhaul <<*>>
				END IF
			END IF
			lb_StopBilling = TRUE
		end if
		
	END IF

END IF

IF lb_PrintImages AND  ( NOT lb_StopBilling ) THEN
	THIS.of_PrintBillingImages ( ldw_target )
ELSEIF lb_ForceImagePrinting THEN
	THIS.of_PrintBillingImages ( ldw_target )
END IF


IF lb_StopBilling THEN
	ls_reject = ""
	goto stop_billing
END IF



if lb_link_open then
	do
		lb_success = lnv_cst_acctlink.of_link_close()
		if lb_success then
			lb_link_open = false
			exit
		else
			if messagebox("Close Accounting Link", "Could not close link to the accounting "+&
				"package.  Retry?", exclamation!, retrycancel!, 1) = 2 then exit
		end if
	loop while lb_success = false
end if

ldw_target.reset()  // ?? A better way ??
destroy lds_acct_cos
destroy lnv_cst_acctlink

ll_arraycount = upperbound(lnva_accountingdata)
for ll_index = 1 to ll_arraycount
	 destroy lnva_accountingdata[ll_index]
next

ll_ArrayCount = UpperBound ( lnva_Shipments ) 
FOR ll_Index = 1 TO ll_ArrayCount 
	DESTROY ( lnva_Shipments[ll_Index] )
NEXT

//IF ISValid ( lnv_PegPrint ) THEN
//	DESTROY lnv_PegPrint
//END IF

return 1

/* @@@@@@@@@@@@@@@@@@ STOP BILLING @@@@@@@@@@@@@@@@@@ */
stop_billing:

//Added By Dan 2-19-07 originally to report duplicate invoice error when batching.
IF this.of_getLastmessage( ls_errorMessage ) = 1 THEN
	ls_reject = ls_errorMessage + " " + ls_reject
	this.of_resetmessages( )		//this might not be necessary but there is no reason not to for now.
END IF
/////////////

lb_StopBillProcess = TRUE // zmc
if len(ls_reject) > 0 then messagebox(ls_message_header, ls_reject, exclamation!)

if lb_link_open then
	do
		lb_success = lnv_cst_acctlink.of_link_close()
		if lb_success then
			lb_link_open = false
			exit
		else
			if messagebox("Close Accounting Link", "Could not close link to the accounting "+&
				"package.  Retry?", exclamation!, retrycancel!, 1) = 2 then exit
		end if
	loop while lb_success = false
end if

ldw_target.setredraw(true) //??
ldw_target.reset() // ?? A better way ??
destroy lds_acct_cos
destroy lnv_cst_acctlink

ll_arraycount = upperbound(lnva_accountingdata)
for ll_index = 1 to ll_arraycount
	 destroy lnva_accountingdata[ll_index]
next

ll_ArrayCount = UpperBound ( lnva_Shipments ) 
FOR ll_Index = 1 TO ll_ArrayCount 
	DESTROY ( lnva_Shipments[ll_Index] )
NEXT


setpointer(arrow!) //hourglass was staying until user moved mouse

if ib_ARBatch then
	//I know this is a kluge but I have no choice, after all this is billing. NWL 6/15/2004
	if lb_ReBatchingSuccessful then
		return 1
	else
		return 0 
	end if
end if

// zmc 2-20-04
// Returning a -1 in case user bails out by clicking on the cancel button anywhere in the entire process of billing.
IF lb_StopBillProcess THEN
 li_RtnVal = -1
 Return li_RtnVal
END IF

return 0


end function

public function integer of_printimagesforcustominvoices (datawindow adw_target, n_cst_msg anv_imagemsg);integer 	li_return = 1, &
			li_PrintReturn
			
Boolean	lb_PegPrint = TRUE

long		ll_Tmp, &
			ll_RowCount, &
			ll_Ndx
n_cst_beo_shipment	lnv_Shipment
n_cst_msg	lnv_msg

n_cst_pegasus_print	lnv_pegPrint
lnv_PegPrint = CREATE n_cst_pegasus_print
lnv_Shipment = CREATE n_cst_beo_Shipment

IF  lnv_PegPrint.of_PrintSetup ( lnv_msg ) <> 1 THEN
	li_Return = -1
END IF

if printsetup() = -1 then
	messagebox("Image Printing", "Error executing printer setup. Request cancelled.", &
		exclamation!)
	li_return = -1
end if

if li_Return = 1 THEN
	
	ll_RowCount = adw_target.rowcount( )
	For ll_Ndx = 1 to ll_RowCount
		lnv_Shipment.of_SetSource ( adw_Target )
		lnv_Shipment.of_SetSourceRow ( ll_Ndx )
		
//		ll_tmp = adw_target.object.ds_id[ll_Ndx]
		li_PrintReturn = THIS.of_PrintImages ( lnv_Shipment , lnv_msg )
		IF li_PrintReturn <> 1 THEN
			messageBox( "Image Printing" , "An error occurred while attempting to print the images associated with the current invoice.")
			li_return = -1
		END IF
		
	NEXT

END IF

DESTROY lnv_PegPrint
DESTROY lnv_Shipment

return li_Return
end function

protected function integer of_getdesiredinvoicedate (ref n_cst_msg anv_Msg);Return 1
end function

private function integer of_getinvoicedate (n_cst_msg anv_msg);// returns   1 = got the date they wanted to use. could be that they did not want to be 
// 				  prompted for alternate date.
//				-1 = error
// 			 0 = user canceled processing 

n_cst_Settings	lnv_Settings
Any 		la_GetDate
Int		li_GetDate
String	ls_Type
Int		li_Return = 1
Boolean	lb_Continue
Boolean	lb_UseShipDate
Date		ld_InvoiceDate
Constant Int		ci_Yes = 1

n_cst_msg	lnv_Msg
S_Parm		lstr_parm

setnull(id_InvoiceDate)

IF anv_msg.of_Get_Parm ( "TYPE" , lstr_Parm ) <> 0 THEN
	ls_Type = Upper ( lstr_Parm.ia_Value )
END IF

IF lnv_Settings.of_GetSetting ( 69  , la_GetDate ) = 1 THEN
	li_GetDate = Int ( la_GetDate )
	
	IF li_GetDate = ci_Yes THEN
		IF ls_Type = "MANIFEST!" THEN
			lstr_parm.is_Label = "SHOWSHIPDATE"
			lstr_Parm.ia_Value = FALSE 
			lnv_Msg.of_Add_Parm ( lstr_Parm )
		END IF
		
		openWithParm ( w_InvoiceDate, lnv_Msg )
		
		lnv_msg = Message.PowerObjectParm
		
		IF lnv_Msg.of_Get_Parm ( "CONTINUE" , lstr_Parm ) <> 0 THEN
			IF lstr_Parm.ia_Value = TRUE THEN
				lb_Continue = TRUE			
			ELSE	
				li_Return = 0 // user canceled
			END IF
		ELSE
			li_Return = -1
		End IF
	END IF
END IF

IF lb_Continue THEN
	IF lnv_Msg.of_Get_Parm ( "USESHIPDATE", lstr_Parm ) <> 0 THEN
		lb_UseShipDate = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "DATE", lstr_Parm ) <> 0 THEN
		ld_InvoiceDate = lstr_parm.ia_Value
	END IF
	IF lb_UseShipDate THEN
		ib_UseShipDate = TRUE
	ELSEIF li_Return <> -1 THEN
		ib_UseShipDate = FALSE
		id_InvoiceDate = date(datetime(ld_InvoiceDate))
	END IF
ELSE
	id_InvoiceDate = date(datetime(today()))
END IF

Return li_Return


end function

protected function integer of_validateshipdates (readonly datawindow adw_target);//Returns: 1 (All Shipments have ship dates), -1 (At least one shipment has no ship date)

string ls_list, ls_reject, ls_type
long ll_row, ll_RowCount

Integer	li_Return = 1


ls_Type = This.of_GetType ( adw_Target )
ll_RowCount = adw_Target.RowCount ( )

FOR ll_row = 1 TO ll_RowCount

	IF IsNull ( adw_target.object.ds_Ship_date[ll_row] ) THEN
		if len(ls_list) > 0 then ls_list += ", "
		ls_list += adw_target.object.ds_pronum[ll_row]

		li_Return = -1
   END IF

NEXT


if li_Return = -1 then
	ls_reject = "Cannot process billing request due to missing shipment dates for the following "+&
		"shipments: " + ls_list 
	messagebox(This.of_get_message_header(ls_type), ls_reject)
end if


return li_Return



end function

protected function integer of_validateinvoicedateselection (readonly dataWindow adw_Target);
Int	li_Return = 1

IF ib_UseShipDate THEN
	IF THIS.of_ValidateShipDates ( adw_Target ) <> 1 THEN
		li_Return = -1
	END IF
END IF

RETURN li_Return
end function

public function integer of_printbillingimages (readonly datawindow adw_target);Boolean					lb_PegPrint
Long						ll_tmp
Int						li_PrintReturn
Int						i
Int						li_Return = 1
n_cst_msg				lnv_msg
n_cst_pegasus_print	lnv_pegPrint
n_cst_beo_Shipment	lnv_Shipment

lnv_PegPrint = CREATE n_cst_pegasus_print
lnv_Shipment = CREATE n_cst_beo_shipment

IF isValid ( lnv_PegPrint ) AND IsValid ( adw_target ) THEN
	IF lnv_PegPrint.of_PrintSetup ( lnv_msg ) <> 1 THEN
		lb_PegPrint = FALSE
	END IF

	For i = 1 to adw_target.rowcount( )
		lnv_Shipment.of_SetSource ( adw_target )
		lnv_Shipment.of_SetSourceRow ( i )
		//ll_tmp = adw_target.object.ds_id[i]
		li_PrintReturn = THIS.of_PrintImages ( lnv_Shipment , lnv_msg )
		IF li_PrintReturn <> 1 THEN
			messageBox( "Image Printing" , "An error occurred while attempting to print the images associated with the current invoice.")						
		END IF
	NEXT
ELSE 
	li_Return = -1
END IF

DESTROY lnv_PegPrint
DESTROY lnv_Shipment

RETURN li_Return

end function

public function integer of_printimages (n_cst_beo_shipment anv_shipment, n_cst_msg anv_msg);String	lsa_Types[]
Long		ll_ID
Int		i
Int		li_ReturnValue = 1


n_cst_beo_Company	lnv_Company
n_cst_pegasus_print	lnv_print
n_cst_Settings		lnv_Settings

lnv_print = create n_cst_pegasus_print
IF isValid ( anv_Shipment ) THEN
	anv_Shipment.of_GetBilltoCompany ( lnv_Company, TRUE )
	IF lnv_Company.of_OverridePrintingImageTypes ( ) THEN
		lnv_Company.of_getprintingImageTypes ( lsa_Types )
	ELSE
		lnv_Settings.of_GetPrintingImageTypes ( lsa_types )
	END IF
	
	ll_ID = anv_Shipment.of_GetID ( )
	
	FOR i = 1 TO Upperbound ( lsa_Types )
		
		li_ReturnValue = lnv_Print.of_Print ( lsa_Types[i], ll_ID, anv_msg )
		
	NEXT
ELSE
	li_ReturnValue = -1
	
END IF

DESTROY lnv_Print
DESTROY lnv_Company

return li_ReturnValue
end function

public function integer of_doimagesneedtoprint (n_cst_beo_shipment anva_shipments[]);/*  
Determines if any images need to be printed
Returns	1 = Success, but no images need to be printed
			2 = Success, Images need to be processed
			-1= FAILURE
*/

Int		li_ReturnValue = 1
Int 		li_PrintRtn
Long		ll_CurrentID
Long		ll_ShipmentCount
Long		ll_Index
Long 		ll_ParentId
String	lsa_Types[]

n_cst_beo_Shipment	lnv_CurrentShipment
n_cst_beo_Company		lnv_Company
n_cst_Settings			lnv_Settings

//zmc - start
n_cst_setting_includeparentinimagelookup lnv_ParentLookUp
lnv_ParentLookUp = CREATE n_cst_setting_includeparentinimagelookup
//zmc - end

//// check to see if there are any images that need to be processed when billing.

ll_ShipmentCount = UpperBound( anva_shipments )
FOR ll_Index = 1 TO ll_ShipmentCount
	
	lnv_CurrentShipment = anva_Shipments[ ll_Index ]
	IF IsValid ( lnv_CurrentShipment ) THEN
		lnv_CurrentShipment.of_GetBillTocompany ( lnv_Company , TRUE )
		
	  	// zmc
		IF Not IsValid(lnv_Company) THEN
      	lnv_Settings.of_GetPrintingImageTypes ( lsa_Types )
		ELSE
   		IF lnv_Company.of_OverridePrintingImageTypes ( ) THEN
				lnv_Company.of_GEtPrintingImageTypes ( lsa_Types )
		   ELSE
		   	lnv_Settings.of_GetPrintingImageTypes ( lsa_Types )
		   END IF
	  	END IF
		  
		ll_CurrentID = lnv_CurrentShipment.of_GetID ( )
		
		li_PrintRtn = This.of_DoImagesNeedToPrintForShipment(ll_CurrentID,lsa_Types)
		
		IF li_PrintRtn = 2 THEN 
			li_ReturnValue = 2
			EXIT
		END IF
		
		IF li_PrintRtn = -1 THEN 
			li_ReturnValue = -1
			EXIT
		END IF
		
	ELSE
		li_ReturnValue = -1
		EXIT
	END IF // is valid
	
	IF li_ReturnValue = 1 THEN
		// get parent id if the ParentLookUp property is set to 'Yes' in system settings.
		IF Upper(lnv_ParentLookUp.of_GetValue()) = Upper(lnv_ParentLookUp.cs_Yes) THEN
	     ll_ParentId = lnv_CurrentShipment.of_GetParentId()
		  // Check if images need to be printed for parentid
		  li_PrintRtn = This.of_DoImagesNeedToPrintForShipment(ll_ParentId,lsa_Types)
	     IF li_PrintRtn = 2 THEN
				li_ReturnValue = 2
				EXIT	
			END IF

	  	 IF li_PrintRtn = -1 THEN 
		 	li_ReturnValue = -1
			EXIT
		 END IF
		END IF
	END IF

NEXT  // each shipment

DESTROY lnv_Company
DESTROY lnv_ParentLookUp

RETURN li_ReturnValue
end function

private function long of_getshipments (long ala_id[], ref n_cst_beo_shipment anva_shipment[]);long 	ll_return = 1, &
		ll_beocount, &
		ll_ndx, &
		ll_shipcount
	
string	ls_errormessage

//n_cst_beo_item			lnva_item[]
n_cst_bso_dispatch	lnv_dispatch

n_ds	lds_itemcache, &
		lds_shipmentcache

ll_shipcount = upperbound(ala_id)

if ll_shipcount > 0 then
	lnv_dispatch = create n_cst_bso_dispatch
	
	lnv_Dispatch.of_RetrieveShipments ( ala_id )
	lds_ShipmentCache = lnv_Dispatch.of_GetShipmentCache ( )
	IF isValid ( lds_ShipmentCache ) THEN
	
		lds_ShipmentCache.SetSort ( "ds_id A" )
		lds_ShipmentCache.Sort ( )
		
		lds_ItemCache = lnv_Dispatch.of_GetItemCache ( )
		IF isValid ( lds_ItemCache ) THEN
			lds_ItemCache.SetSort ( "di_shipment_id A, di_item_type D, di_item_id A " )
			lds_ItemCache.Sort ( )
		END IF
	
		FOR ll_ndx = 1 TO ll_shipcount
			ll_BeoCount ++
			anva_Shipment [ ll_BeoCount ] = CREATE n_cst_beo_Shipment
			anva_Shipment [ ll_BeoCount ].of_SetSource ( lds_ShipmentCache )
			anva_Shipment [ ll_BeoCount ].of_SetSourceId ( ala_id [ ll_ndx ] )
			anva_Shipment [ ll_BeoCount ].of_SetItemSource ( lds_ItemCache )
		NEXT
		
	end if
end if

if isvalid(lnv_dispatch) then
	destroy lnv_dispatch
end if

 
return ll_return
end function

protected function decimal of_getdistribution (n_cst_beo_shipment anv_shipment, ref s_accounting_distribution astra_distribution[], decimal ac_hiddendiscount, ref n_cst_msg anv_errormsg);/*
	return posting amount for distributions
*/
long	ll_arraycount, &
		ll_ndx, &
		ll_distndx
	
string	lsa_ClearAccounts[]
			
decimal	lc_posting, &
			lc_amount, &
			lca_Clearamounts[]
			
s_parm		lstr_parm

isa_araccount = lsa_ClearAccounts
isa_freighttype = lsa_ClearAccounts
isa_salesaccount = lsa_ClearAccounts
ica_aramount = lca_Clearamounts
ica_salesamount = lca_Clearamounts

if isvalid(anv_shipment) then
	lc_posting=this.of_getdistributionaccounts(anv_shipment, anv_errormsg ) 
															 
	IF ac_HiddenDiscount > 0 AND ac_HiddenDiscount <= 1 THEN
		lc_Posting = lc_Posting * ( 1 - ac_HiddenDiscount )
	end if

end if

ll_arraycount = upperbound(isa_salesaccount)
for ll_ndx = 1 to ll_arraycount
	ll_distndx = upperbound(astra_distribution) + 1
	astra_distribution[ll_distndx].is_account = isa_SalesAccount[ll_ndx]
	astra_distribution[ll_distndx].ib_credit = true
	IF ac_HiddenDiscount > 0 AND ac_HiddenDiscount <= 1 THEN
		astra_distribution[ll_distndx].ic_amount = ica_Salesamount[ll_ndx] * ( 1 - ac_HiddenDiscount )
	ELSE
		astra_distribution[ll_distndx].ic_amount = ica_SalesAmount[ll_ndx]
	END IF
	
next

ll_arraycount = upperbound(isa_araccount)
for ll_ndx = 1 to ll_arraycount
	
	ll_distndx = upperbound(astra_distribution) + 1
	astra_distribution[ll_distndx].is_account = isa_arAccount[ll_ndx]
	astra_distribution[ll_distndx].ib_credit = false
	IF ac_HiddenDiscount > 0 AND ac_HiddenDiscount <= 1 THEN
		astra_distribution[ll_distndx].ic_amount = ica_arAmount[ll_ndx] * ( 1 - ac_HiddenDiscount )
	ELSE
		astra_distribution[ll_distndx].ic_amount = ica_arAmount[ll_ndx]
	END IF
	
next

return lc_posting


end function

protected function string of_prepare_batch (datawindow adw_target, datastore ads_acct_cos, string as_postingcompany, n_cst_beo_shipment anva_shipment[], ref n_cst_msg anv_cst_msg);//This function is currently only intended to be called at the expected point within
//of_bill, as an offloading of processing.  It is expected that shipment types and 
//posting accounts have already been validated, so failure on that basis below would
//constitute an unexpected error, not a validation issue.

//The function returns 1 if it succeeds, -1 if it fails.  The message object returned
//by reference is ready to be passed to n_cst_acctlink.of_batch_create()

n_cst_numerical lnv_numerical

n_cst_msg lnv_cst_msg
s_parm lstr_parm
string	ls_type, &
			ls_Tmp, &
			lsa_error[], &
			ls_error, &
			lsa_reflist[], &
			ls_reflist
			
integer	li_ndx, &
			li_ReferenceType
			
Int		i
Int		li_Count

boolean	lb_matched

long	ll_row, &
		ll_foundrow, &
		ll_company_id, &
		ll_num_acct_cos, &
		ll_shiptype, &
		ll_ndx, &
		ll_distcount,&
		ll_shipid, &
		ll_shipcount, &
		ll_errorcount, &
		ll_bbrow
		
s_accounting_transaction lstr_transaction, lstr_blank_transaction
s_accounting_distribution lstr_distribution, &
								  lstra_distribution[], &
								  lstra_blankdist[]

n_cst_shiptype lnv_shiptype

Decimal {2} lc_InvoiceAmount, &
				lc_PostingAmount, &
				lc_AccessorialAmount
				
Decimal {5}	lc_HiddenDiscount

n_cst_ShipmentManager	lnv_ShipmentMgr
s_ReferenceNumber	lstra_ReferenceNumbers[]
u_dw_Bill_Manifest	luo_Manifest
n_cst_msg			lnv_error
n_ds					lds_BillingBatchReport
n_cst_string		lnv_string
ls_Type = of_GetType ( adw_Target )
n_cst_beo_Company	lnv_Company

choose case ls_type
case "MANIFEST!"
	luo_Manifest = adw_Target
CASE "INVOICE!"
	//Type is valid.
case else
	ls_error = "FAILURE - Invalid Billing Type (Expected MANIFEST or INVOICE)"
end choose

if len(trim(ls_error)) = 0 then
	ll_num_acct_cos = ads_acct_cos.rowcount()
	if lnv_numerical.of_IsNullOrNotPos(adw_target.rowcount()) then 
		ls_error = "FAILURE - Invalid Posting Company"
	else
		if this.of_ready() = false then 
			ls_error = "FAILURE - Can't find Logo or Account Package in System Setting." 
		end if
	end if
end if
	
li_Count = UpperBound ( anva_shipment[] ) 
FOR i = 1 TO li_Count
	IF Not IsValid ( anva_shipment[i] ) THEN
		ls_error = "FAILURE - Invalid Shipments" 
		EXIT 
	END IF
NEXT
	
if len(trim(ls_error)) = 0 then

	lstr_parm.is_label = "BATCH_TYPE"
	lstr_parm.ia_value = "SALES!"
	lnv_cst_msg.of_add_parm(lstr_parm)
	
	lstr_parm.is_label = "POSTING_COMPANY"
	lstr_parm.ia_value = as_PostingCompany
	lnv_cst_msg.of_add_parm(lstr_parm)
	
	ll_shipcount = upperbound(anva_shipment)
	
	lds_BillingBatchReport = create n_ds
	lds_BillingBatchReport.dataobject="d_billingbatchreport"
	lds_BillingBatchReport.SetTransObject(SQLCA)

	for ll_row = 1 to adw_target.rowcount()
	
		ll_bbrow = lds_BillingBatchReport.insertrow(0)
		
		lc_InvoiceAmount = adw_target.object.ds_bill_charge[ll_row]
		lc_AccessorialAmount = adw_target.object.ds_ac_totamt[ll_row]
	
		if not (ls_type = "MANIFEST!" and ll_row > 1) then
	
			lstr_transaction = lstr_blank_transaction
			lstr_transaction.ic_document_amount = 0
			lc_HiddenDiscount = 0
	
			choose case ls_type
			case "INVOICE!"
				lstr_transaction.is_document_number = adw_target.object.ds_pronum[ll_row]
				lstr_transaction.id_document_date = adw_target.object.ds_bill_date[ll_row]
				ll_company_id = adw_target.object.ds_billto_id[ll_row]
			case "MANIFEST!"
				lstr_transaction.is_document_number = luo_Manifest.of_get_pronum()
				lstr_transaction.id_document_date = luo_Manifest.of_get_bill_date()
				ll_company_id = luo_Manifest.of_get_billto()
			end choose
		
			ll_foundrow = ads_acct_cos.find("co_id = " + string(ll_company_id), 1, ll_num_acct_cos)
			if ll_foundrow > 0 then
				if ads_acct_cos.object.approved[ll_foundrow] = "T" then
					lstr_transaction.is_company_name = ads_acct_cos.object.xx_acct_name[ll_foundrow]
					lstr_transaction.is_company_code = ads_acct_cos.object.co_bill_acctcode[ll_foundrow]
					lc_HiddenDiscount = ads_acct_cos.Object.co_HiddenDiscount [ ll_FoundRow ]
				end if
			end if
	
			lds_BillingBatchReport.object.invoiceno[ll_bbrow] = lstr_transaction.is_document_number
			lds_BillingBatchReport.object.invoicedate[ll_bbrow] = lstr_transaction.id_document_date
			lds_BillingBatchReport.object.accountingid[ll_bbrow] = lstr_transaction.is_company_code
			lds_BillingBatchReport.object.billtoname[ll_bbrow] = lstr_transaction.is_company_name
			
			lnv_Company = CREATE n_cst_beo_Company
			lnv_Company.of_SetUseCache ( TRUE )
			lnv_Company.of_SetSourceId ( ll_company_id )
			
			IF lnv_Company.of_HasSource ( ) THEN
				
				lds_BillingBatchReport.object.billtocodename[ll_bbrow] = lnv_Company.of_getcodename()
			END IF

			
		end if
	
	
		//Get TMP Number Info
	
		ls_Tmp = lnv_ShipmentMgr.of_ConvertTmp ( adw_Target.Object.ds_id [ ll_Row ] )
		lstr_Transaction.isa_Tmps [ UpperBound ( lstr_Transaction.isa_Tmps ) + 1 ] = ls_Tmp		
	
		lds_BillingBatchReport.object.shipid[ll_bbrow] = adw_Target.Object.ds_id [ ll_Row ]
		
		//Get Reference Number Info
	
		lstra_ReferenceNumbers[1].is_Type = "TMP #"
		lstra_ReferenceNumbers[1].is_Value = ls_Tmp
	
		li_ReferenceType = adw_Target.Object.ds_Ref1_Type [ ll_Row ]
		lstra_ReferenceNumbers[2].is_Type = lnv_ShipmentMgr.of_ConvertReference ( li_ReferenceType )
		lstra_ReferenceNumbers[2].is_Value = adw_Target.Object.ds_Ref1_Text [ ll_Row ]
	
		ls_reflist += lstra_ReferenceNumbers[2].is_Type + " " + lstra_ReferenceNumbers[2].is_Value
		
		li_ReferenceType = adw_Target.Object.ds_Ref2_Type [ ll_Row ]
		lstra_ReferenceNumbers[3].is_Type = lnv_ShipmentMgr.of_ConvertReference ( li_ReferenceType )
		lstra_ReferenceNumbers[3].is_Value = adw_Target.Object.ds_Ref2_Text [ ll_Row ]
	
		li_ReferenceType = adw_Target.Object.ds_Ref3_Type [ ll_Row ]
		lstra_ReferenceNumbers[4].is_Type = lnv_ShipmentMgr.of_ConvertReference ( li_ReferenceType )
		lstra_ReferenceNumbers[4].is_Value = adw_Target.Object.ds_Ref3_Text [ ll_Row ]
	
		FOR li_Ndx = 1 TO 4
	
			IF Len ( lstra_ReferenceNumbers [ li_Ndx ].is_Type ) > 0 AND &
				Len ( lstra_ReferenceNumbers [ li_Ndx ].is_Value ) > 0 THEN
		
				lstr_Transaction.istra_ReferenceNumbers [ UpperBound ( &
					lstr_Transaction.istra_ReferenceNumbers ) + 1 ] = lstra_ReferenceNumbers [ li_Ndx ]
		
			END IF
	
		NEXT
	
		lds_BillingBatchReport.object.freightcharges[ll_bbrow] = adw_Target.Object.ds_lh_totamt [ ll_Row ]
		lds_BillingBatchReport.object.accessorialcharges[ll_bbrow] = adw_Target.Object.ds_ac_totamt [ ll_Row ]
		lds_BillingBatchReport.object.discount[ll_bbrow] = adw_Target.Object.ds_disc_amt [ ll_Row ]
		lds_BillingBatchReport.object.totalcharges[ll_bbrow] = (adw_Target.Object.ds_lh_totamt [ ll_Row ] + &
																			adw_Target.Object.ds_ac_totamt [ ll_Row ]) - &
																			adw_Target.Object.ds_disc_amt [ ll_Row ]
		
		lsa_reflist [1] = lstra_ReferenceNumbers[2].is_Type + " " + lstra_ReferenceNumbers[2].is_Value
		lsa_reflist [2] = lstra_ReferenceNumbers[3].is_Type + " " + lstra_ReferenceNumbers[3].is_Value
		lsa_reflist [3] = lstra_ReferenceNumbers[4].is_Type + " " + lstra_ReferenceNumbers[4].is_Value

		lnv_String.of_ArrayToString ( lsa_reflist, ", ", ls_reflist )

		lds_BillingBatchReport.object.reference1text[ll_bbrow] = ls_reflist
  
		
		//Get Shipment Type Info  (This is done on a shipment-by-shipment basis, even for the
		//manifest, since the distributions will be broken out individually.)
	
		ll_shiptype = adw_target.object.ds_ship_type[ll_row]
		if lnv_numerical.of_IsNullOrNotPos(ll_shiptype) then 
			ls_error = "FAILURE - Ship Type Not Found in Ship Type Table" 
			exit
		end if
	
		if isvalid(lnv_shiptype) then
			if lnv_shiptype.ids_data.object.st_id[1] = ll_shiptype then
				//We've already got the matching object
			else
				//Destroy the existing object to force getting the matching one, below
				destroy lnv_shiptype
			end if
		end if
	
		if not isvalid(lnv_shiptype) then
			if not inv_cst_ship_type.of_get_object(ll_shiptype, lnv_shiptype) = 1 then
				ls_error = "FAILURE - Invalid Ship Type" 
				exit
			end if
		end if
	
		lds_BillingBatchReport.object.shiptype[ll_bbrow] = lnv_shiptype.ids_data.object.st_name[1]
		
		//Get payment terms and due date
	
		if not (ls_type = "MANIFEST!" and ll_row > 1) then

			//replace with new paymentterms column on disp_ship
			//lstr_transaction.is_payment_terms = lnv_shiptype.ids_data.object.st_terms[1]
			lstr_transaction.is_payment_terms = adw_Target.Object.paymentterms [ ll_Row ]

			this.of_payment_due(lstr_transaction.is_payment_terms, &
				lstr_transaction.id_document_date, lstr_transaction.id_payment_due)
	
		end if
	
		//get items from shipment and total amounts by amount type
		ll_shipid = adw_Target.Object.ds_id [ ll_Row ]
		lstra_distribution = lstra_blankdist
		for ll_ndx = 1 to ll_shipcount
			if anva_shipment[ll_ndx].of_getid() = ll_shipid then
				lc_PostingAmount = this.of_getdistribution(anva_shipment[ll_ndx], lstra_distribution, lc_HiddenDiscount, lnv_error )
				exit	
			end if	
		next
		
		IF lnv_error.of_Get_Parm ( "ERROR" , lstr_Parm ) <> 0 THEN
			lsa_error = lstr_parm.ia_Value
			ll_errorcount = upperbound(lsa_error)
			for ll_ndx = 1 to ll_errorcount
				ls_error += lsa_error[ll_ndx] + ' '
			next
		END IF
		
		ll_distcount = upperbound ( lstra_distribution ) 
		for ll_ndx = 1 to ll_distcount
			lstr_distribution = lstra_distribution[ll_ndx]
			lb_matched = false
			choose case ls_type
			case "INVOICE!"
				//No processing needed.  Distribution will be added below.
			case "MANIFEST!"	
				for li_ndx = 1 to upperbound(lstr_transaction.istra_distributions)
					if lstr_transaction.istra_distributions[li_ndx].is_account = lstr_distribution.is_account then
						lb_matched = true
						lstr_transaction.istra_distributions[li_ndx].ic_amount += lstr_distribution.ic_amount
						exit
					end if
				next
			end choose
			if not lb_matched then
				lstr_transaction.istra_distributions[upperbound(lstr_transaction.istra_distributions) + 1] = lstr_distribution
			end if
	
		next
	
		lstr_transaction.ic_document_amount += lc_PostingAmount
	
		choose case ls_type
		case "INVOICE!"
			lstr_parm.is_label = "TRANSACTION"
			lstr_parm.ia_value = lstr_transaction
			lnv_cst_msg.of_add_parm(lstr_parm)
	//	case "MANIFEST!"
			//No processing needed
		end choose
	
	next
	
	lstr_parm.is_label = "BILLING BATCH REPORT"
	lstr_parm.ia_value = lds_BillingBatchReport
	lnv_cst_msg.of_add_parm(lstr_parm)
	

end if

if len(trim(ls_error)) = 0 then
	choose case ls_type
	case "INVOICE!"
		//No processing needed.
	case "MANIFEST!"
		lstr_parm.is_label = "TRANSACTION"
		lstr_parm.ia_value = lstr_transaction
		lnv_cst_msg.of_add_parm(lstr_parm)
	end choose

	anv_cst_msg = lnv_cst_msg
	
end if

DESTROY lnv_Company

return ls_error

end function

protected function decimal of_getdistributionaccounts (n_cst_beo_shipment anv_shipment, ref n_cst_msg anv_errormsg);/*
	return posting amount for distributions
*/
any	la_value

integer	li_amounttype

long	ll_itemndx, &
		ll_itemcount, &
		ll_arraycount, &
		ll_ndx
	
string	ls_error, &
			lsa_error[]
			
decimal	lc_posting, &
			lc_amount, &
			lc_discountRemainder, &
			lc_grandtotal, &
			lc_freighttotal, &
			lc_accesstotal
			
boolean	lb_freightitem

Constant String	cs_LockId = "billing"

n_cst_beo_item	lnva_item[], &
					lnva_clearitem[]
					
n_cst_settings	lnv_settings
s_parm			lstr_parm

if isvalid(anv_shipment) then
	
	choose case anv_shipment.of_GetBillingFormat ( )
			
		case appeon_constant.cs_BillingFormat_Item
			//	loop thru items for amounttypes
			anv_shipment.of_LockItemList ( cs_LockId )
			lnva_item = lnva_clearitem
			ll_itemcount = anv_shipment.of_getitemlist(lnva_item)
			
			//If there is a discount, apply by percentage over all freight items
			lc_DiscountRemainder = anv_shipment.of_getdiscountamount()

		
			for ll_itemndx = 1 to ll_itemcount
				
				IF lnva_item[ll_itemndx].of_IsFreight ( ) THEN
					lb_freightitem=true
				else
					lb_freightitem=false
				end if
				
				lc_amount = lnva_item[ll_itemndx].of_getbillingamount()
				//allow zero amounts
//				if isnull(lc_amount) or lc_amount = 0 then
//					continue
//				end if
				
				li_amounttype = lnva_item[ll_itemndx].of_getamounttype()
				if isnull(li_amounttype) or li_amounttype = 0 then
					lsa_error[upperbound(lsa_error) + 1] = "Amount type missing for TMP " + string(anv_shipment.of_getid())
					continue
				end if
				
				this.of_SetDistribution(anv_shipment, lc_amount, lc_DiscountRemainder, li_amounttype, lb_freightitem, ls_error)
		
				if len(trim(ls_error)) > 0 then
					lsa_error[upperbound(lsa_error) + 1] = ls_error
					continue
				end if
				
				lc_posting += lc_amount
				
				DESTROY ( lnva_item[ ll_itemndx ] )
				
			next
			
			anv_shipment.of_ReleaseItemList ( cs_LockId )
			
		case appeon_constant.cs_BillingFormat_Category
			lc_freighttotal = anv_shipment.of_getfreightcharges()
			//If there is a discount, apply by percentage over all freight items
			lc_DiscountRemainder = anv_shipment.of_getdiscountamount()


			//FREIGHT
			if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
				li_amounttype = integer(la_value)
			end if
			if isnull(li_amounttype) or li_amounttype = 0 then
				lsa_error[upperbound(lsa_error) + 1] = "Amount type missing for TMP " + string(anv_shipment.of_getid())			
			else
				lb_freightitem = true
				this.of_SetDistribution(anv_shipment, lc_freighttotal, lc_DiscountRemainder, li_amounttype, lb_freightitem, ls_error)
		
				if len(trim(ls_error)) > 0 then
					lsa_error[upperbound(lsa_error) + 1] = ls_error
				else
					lc_posting += lc_freighttotal
				end if		
				
			end if

			lc_accesstotal = anv_shipment.of_getaccessorialcharges()		
			//ACCESS
			if lnv_Settings.of_GetSetting ( 99 , la_value ) > 0 then
				li_amounttype = integer(la_value)
			end if
			if isnull(li_amounttype) or li_amounttype = 0 then
				lsa_error[upperbound(lsa_error) + 1] = "Amount type missing for TMP " + string(anv_shipment.of_getid())			
			else
				lb_freightitem = false
				this.of_SetDistribution(anv_shipment, lc_accesstotal, lc_DiscountRemainder, li_amounttype, lb_freightitem, ls_error)
		
				if len(trim(ls_error)) > 0 then
					lsa_error[upperbound(lsa_error) + 1] = ls_error
				else
					lc_posting += lc_accesstotal
				end if		
				
			end if

		case appeon_constant.cs_BillingFormat_Total
			lc_grandtotal = anv_shipment.of_GetNetCharges()	
			//If there is a discount, apply by percentage over all freight items
			lc_DiscountRemainder = anv_shipment.of_getdiscountamount()


			//grand total goes to default freight account
			if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
				li_amounttype = integer(la_value)
			end if
			
			if isnull(li_amounttype) or li_amounttype = 0 then
				lsa_error[upperbound(lsa_error) + 1] = "Amount type missing for TMP " + string(anv_shipment.of_getid())			
			else
				lb_freightitem = true
				this.of_SetDistribution(anv_shipment, lc_grandtotal, lc_DiscountRemainder, li_amounttype, lb_freightitem, ls_error)
		
				if len(trim(ls_error)) > 0 then
					lsa_error[upperbound(lsa_error) + 1] = ls_error
				else
					lc_posting = lc_grandtotal
				end if		
				
			end if
			
	end choose
	
	//if any discount left take it from the first freight item
	if lc_DiscountRemainder > 0 then
		//find first freight item
		ll_arraycount = upperbound(isa_freighttype)
		for ll_ndx = 1 to ll_arraycount
			if isa_freighttype[ll_ndx] = "YES" then
				ica_salesamount[ll_ndx] -= lc_DiscountRemainder
				exit
			end if
		next
		
	end if
	
end if

if upperbound(lsa_error) > 0 then
	lstr_Parm.is_Label = "ERROR"
	lstr_Parm.ia_Value = lsa_error
	anv_errormsg.of_Add_Parm ( lstr_Parm )
end if

return lc_posting
end function

protected subroutine of_setdistribution (n_cst_beo_shipment anv_shipment, ref decimal ac_amount, ref decimal ac_discountremainder, integer ai_amounttype, boolean ab_freight, ref string as_error);integer	li_shiptype, &
			li_return = 1

decimal	lc_totalDiscount
			
string	ls_error, &
			ls_account

n_cst_shiptype 	lnv_shiptype	// RDT 02-05-03

n_cst_bso_accountingmanager	lnv_accountingmanager
lnv_accountingmanager = create n_cst_bso_accountingmanager

li_shiptype = anv_shipment.of_gettype()
	
//allow zero amounts
lc_totalDiscount = anv_shipment.of_getdiscountamount()

//do we have an amount?
//if isnull(ac_amount) or ac_amount = 0 then
//	li_return = -1
//end if

if li_return = 1 then
	//do we have an account?
	if	lnv_accountingmanager.of_getaccount(li_shiptype, ai_amounttype, "RECEIVABLES", FALSE /*CREDIT*/, ls_account ) = -1 then
		ls_error = lnv_accountingmanager.of_getaccounterror(ai_amounttype)

		inv_cst_ship_type.of_get_object(li_shiptype, lnv_shiptype)									// RDT 02-05-03 
		ls_error = ls_error + " in Ship Type "+lnv_shiptype.ids_data.object.st_Name[1]+ "~n" // RDT 02-05-03 
		li_return = -1
		
	end if
end if



if li_return = 1 then
	//apply any discounts to the freight item
	IF ab_freight and lc_totalDiscount > 0 THEN
		lnv_accountingmanager.of_applydiscount(anv_shipment, ac_amount, ac_DiscountRemainder )			
	END IF

	//add AR account and amount
	//Modified By Dan 12-20-07 to not add the item amount to quick books if the type is ppayable 4.1.26
	IF NOT (ai_amountType = integer(n_cst_constants.cs_AccountingType_Payable) AND ac_amount = 0) THEN
		lnv_accountingmanager.of_addtoarrays(ls_account, ac_amount, isa_ARaccount, ica_ARamount, ab_freight, isa_freighttype)
	END IF
end if

if li_return = 1 then
	//add sales account and amount
	if lnv_accountingmanager.of_getaccount(li_shiptype, ai_amounttype, "RECEIVABLES", TRUE /*CREDIT*/, ls_account ) = -1 then
		ls_error = lnv_accountingmanager.of_getaccounterror(ai_amounttype)

		inv_cst_ship_type.of_get_object(li_shiptype, lnv_shiptype)									// RDT 02-05-03 
		ls_error = ls_error + " in Ship Type "+lnv_shiptype.ids_data.object.st_Name[1] + "~n" // RDT 02-05-03 
		
		li_return = -1
	else
		//Modified By Dan 12-20-07 to not add the item amount to quick books if the type is ppayable 4.1.26
		IF NOT (ai_amountType = integer(n_cst_constants.cs_AccountingType_Payable) AND ac_amount = 0) THEN
			lnv_accountingmanager.of_addtoarrays(ls_account, ac_amount, isa_salesaccount, ica_salesamount, FALSE /*NON FREIGHT*/, isa_freighttype)		
		END IF
	end if
	
end if

destroy lnv_accountingmanager

as_error = ls_error

end subroutine

public function integer of_print (u_dw adw_target, s_longs astr_copies);//RDT 7-29-03 Changed adw_target from datawindow to u_dw
//RDT 7-29-03 Fix/Improve Cancel printing.

long ll_pj
integer li_choice, li_result, li_copy_type, li_copy_loop
string ls_message_header, ls_job_name, ls_type, ls_printer
boolean lb_jobless
boolean	lb_foundcopy
String	ls_OriginalPrinter


n_cst_numerical lnv_numerical
s_printdlgattrib astr_printdlg 							//RDT 7-29-03
n_cst_PrintSrvc lnv_PrintSrvc

ls_Type = of_GetType ( adw_Target )

choose case ls_type
case "MANIFEST!"
	ls_message_header = "Print Billing Manifest"
//	ls_job_name = "Profit Tools Billing Manifest"
	lb_jobless = true
case "DELIVERY_RECEIPT!"
	ls_message_header = "Print Delivery Receipt"
	ls_job_name = "Profit Tools Delivery Receipt"
case "INVOICE!"
	ls_message_header = "Print Invoice Copies"
	ls_job_name = "Profit Tools Invoices"
case else
	messagebox("Print", "Could not process print request.  Request cancelled.", exclamation!)
	return -1
end choose

// RDT 7-29-03 _START

//RDT 7-29-03 if printsetup() = -1 then
//RDT 7-29-03 	messagebox(ls_message_header, "Error executing printer setup. Request cancelled.", &
//RDT 7-29-03 		exclamation!)
//RDT 7-29-03 	return -1
//RDT 7-29-03 end if


//nwl - commenting these lines because print dialoq is causing problems
//astr_printdlg.b_allpages = TRUE
//If adw_Target.Event pfc_print() = -1 then 
//	If NOT lb_jobless Then printcancel(ll_pj)
//	return -1
//End if
//nwl - end of comments

// RDT 7-29-03 _END		

setpointer(hourglass!)

lb_foundcopy = false
for li_copy_type = 1 to upperbound(astr_copies.longar) 
	
	IF astr_copies.longar[li_copy_type] > 0 then
		lb_foundcopy = true
		EXIT
	END IF
	
next

if lb_FoundCopy then
	lnv_PrintSrvc = CREATE n_cst_PrintSrvc
	IF lnv_PrintSrvc.of_IsPrintDialogToBeShown( ) THEN
		ls_OriginalPrinter = PrintGetPrinter ( )
		ls_printer = lnv_PrintSrvc.of_selectprinter()
		if len(ls_printer) > 0 then
			PrintSetPrinter (ls_printer)
		end if
	end if
	destroy lnv_PrintSrvc
end if

//This was in the print_bills script in u_bills.  I think it will work OK without it.
//adw_target.dynamic scrollpage(0)

if lb_FoundCopy then
	if not lb_jobless then
		li_result = 0
		li_choice = 0
	
		do
			ll_pj = printopen(ls_job_name)
			if ll_pj = -1 then
				li_choice = messagebox(ls_message_header, "Could not open print job -- Retry?", &
					exclamation!, retrycancel!, 1)
			else
				li_result = 1
			end if
		loop until li_result = 1 or li_choice = 2
	
		if li_result = 0 then return -1
	end if
end if

li_result = 0
li_choice = 0

do
	
	if lb_foundcopy then
		//ok
	else
		li_result = 1
		EXIT
	end if


	for li_copy_type = 1 to upperbound(astr_copies.longar)

		if lnv_numerical.of_IsNullOrNotPos(astr_copies.longar[li_copy_type]) then continue

		if not ls_type = "DELIVERY_RECEIPT!" then
			choose case li_copy_type
			case 1
				adw_target.modify("p_logo.visible = 0 p_preview.visible = 1")
			
			case 2
				//No adjustments needed
			case 3
				adw_target.modify("txt_copy_1.text = '(' txt_copy_2.text = 'OFFICE' "+&
					"txt_copy_1.visible = 1 txt_copy_2.visible = 1 txt_copy_3.visible = 1")
				adw_target.modify("comp_tempnum.visible = 1")
			
			case 4
				adw_target.modify("txt_copy_1.text = '1' txt_copy_2.text = 'FILE' "+&
					"txt_copy_1.visible = 1 txt_copy_2.visible = 1 txt_copy_3.visible = 1")
				adw_target.modify("comp_tempnum.visible = 1")
			
			case 5
				adw_target.modify("txt_copy_1.text = '4' txt_copy_2.text = 'DUPLICATE' "+&
					"txt_copy_1.visible = 1 txt_copy_2.visible = 1 txt_copy_3.visible = 1")
				adw_target.modify("comp_tempnum.visible = 1")
			
			end choose
		end if
		

		for li_copy_loop = 1 to astr_copies.longar[li_copy_type]
			if lb_jobless then
				li_result = adw_target.print(false)
			else	
				li_result = printdatawindow(ll_pj, adw_target)
			end if
			if li_result = -1 then exit
		next

		if not ls_type = "DELIVERY_RECEIPT!" then
			adw_target.modify("txt_copy_1.visible = 0 txt_copy_2.visible = 0 "+&
				"txt_copy_3.visible = 0")
			adw_target.modify("p_preview.visible = 0 p_logo.visible = 1")
			adw_target.modify("comp_tempnum.visible = 0")
		end if

		if li_result = -1 then exit
	next

	if li_result = -1 then
		if not lb_jobless then printcancel(ll_pj)
		li_choice = messagebox(ls_message_header, "Error attempting to print -- Retry?", &
			exclamation!, retrycancel!, 1)
	elseif not lb_jobless then
		li_result = printclose(ll_pj)
		if li_result = -1 then
			printcancel(ll_pj)
			li_choice = messagebox(ls_message_header, "Error attempting to print -- Retry?", &
				exclamation!, retrycancel!, 1)
		end if
	end if

loop until li_result = 1 or li_choice = 2

IF Len ( ls_OriginalPrinter ) > 0 THEN
	PrintSetPrinter (ls_OriginalPrinter)
END IF

if li_result = 1 then return 1 else return -1
end function

public function long of_prevalidateimaging (n_cst_beo_shipment anva_shipment[], ref long ala_id[], ref boolean ab_value);integer	li_FilterReturn, &
			li_return
long		lla_FilteredIDs[]

n_cst_LicenseManager	lnv_LicenseManager

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Imaging ) THEN
	
	// this will unlock pegasus if not already done
	n_cst_bso_ImageManager_pegasus	lnv_Imagemanager
	lnv_ImageManager = CREATE n_cst_bso_ImageManager_Pegasus
	
	IF lnv_ImageManager.of_CheckConnection ( )  <> 0 THEN
		MessageBox ("Image Printing" , "The controls needed to print the associated images could not be located or unlocked. Printing of the images will not occur." ) 
		ab_Value = FALSE
	END IF
	
	IF isValid ( lnv_ImageManager ) THEN
		Destroy lnv_ImageManager
	END IF

	// gets required image types. if image DNE the id is filtered so it is not processed
	// it also determines if there are any images that need to be printed
	IF UpperBound ( anva_Shipment ) > 0 THEN
		li_FilterReturn =  This.of_FilterIDsByImages( anva_Shipment , lla_FilteredIDs )
			
		CHOOSE CASE li_FilterReturn
			CASE -1   // Failure
				ab_Value = FALSE
				li_Return = -1
				
			CASE 0 // user canceled processing
				ab_Value = FALSE
				li_Return = -1
				
			CASE 1 //success with no images
				ab_Value = FALSE
				ala_id = lla_FilteredIDs
				IF UpperBound ( ala_id ) = 0 THEN
					li_Return = -1 // RPZ<<*>> added to fix flowthrough
				END IF
				
				
			CASE 2 // sucess w/ images to print
				
				//lb_PrintImages = TRUE
				ala_id = lla_FilteredIDs
				
			CASE ELSE // unexpected return
				ab_Value = FALSE
				li_Return = -1
				
		END CHOOSE
	ELSE
		ab_Value = FALSE
	END IF
	
ELSE 
	// imaging Not licensed
	ab_Value = FALSE	
	
END IF 

return li_Return
end function

private function integer of_doimagesneedtoprintforshipment (long al_shipmentid, string asa_imagetypes[]);/*  
Determines if any images need to be printed
Returns	1 = Success, but no images need to be printed
			2 = Success, Images need to be processed
			-1= FAILURE
zmc : 3-22-04			
*/

Int i
Int k
Int li_ReturnValue = 1

String ls_CurrentType
String ls_SearchExpression

n_cst_bcm				lnv_Bcm
n_cst_bcmService		lnv_bcmService
n_cst_beo_ImageType	lnva_ImageTypes[]
n_cst_beo_ImageType	lnv_CurrentImageBeo

n_cst_bso_ImageManager_Pegasus	lnv_ImageManager
lnv_ImageManager = CREATE n_cst_bso_ImageManager_Pegasus

gnv_app.inv_cacheManager.of_GetCache ( "n_cst_dlkc_imagetype" , lnv_Bcm , TRUE , TRUE )

For i = 1 To upperBound  ( asa_imagetypes )
	ls_CurrentType = asa_imagetypes[ i ]

	ls_SearchExpression = "imagetype_type = '"  + ls_CurrentType + "'"

	IF isValid ( lnv_bcm ) THEN
		IF lnv_bcmService.of_getallbeo ( lnv_bcm, ls_SearchExpression , lnva_ImageTypes ) < 0 THEN
			li_ReturnValue = -1 
			EXIT
		END IF
	END IF
		
	IF li_ReturnValue = -1 THEN
		EXIT
	END IF
	
	FOR k = 1 TO upperBound ( lnva_ImageTypes )
		lnv_CurrentImageBEO = lnva_ImageTypes[ k ]
	
		IF lnv_Imagemanager.of_DoesImageExist ( lnv_currentImageBeo , al_shipmentid ) THEN
			li_ReturnValue = 2 
			EXIT
		END IF
	NEXT
		
	IF li_ReturnValue = 2 THEN
		EXIT
	END IF
NEXT

IF IsValid ( lnv_ImageManager ) THEN
	DESTROY lnv_ImageManager
END IF

Return li_ReturnValue
end function

public function long of_filteridsbyimages (ref n_cst_beo_shipment anv_shipments[], ref long ala_filteredids[]);// rtn 	-1 failure
//			0  user canceled
//			1 	success- no images to  print
// 		2 	success- images to print
INT		li_PrintReturn
Long		ll_returnValue = 1
String 	ls_SearchExpression
String	ls_CurrentType
String	lsa_Types []
String	lsa_WarningImageTypes[]
String	lsa_RequiredImageTypes []
Long		lla_EmptyArray [] 
Blob		lblob_FullState
Boolean	lb_Continue
Boolean	lb_OverRide
Boolean	lb_Process = TRUE
Boolean	lb_AddIT = TRUE
Boolean  lb_InsertError // zmc
Boolean  lb_WarningError // zmc
Int		li_TypeRtn
Long		i
Long		j
Long		k
Long		ll_ShipmentCount
Long		ll_TypeCount
Long		ll_NewRow
Long		ll_CurrentID
Long		lla_GoodIDs[]	// IDs With images
Long		lla_BadIDs[] 	// IDs Without Images
Long   	ll_ParentId  // zmc

n_cst_msg	lnv_msg
S_parm		lstr_Parm

n_cst_beo_Company	lnv_CurrentCompany
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Shipment	lnva_GoodShipments[]
n_cst_beo_Shipment	lnva_BadShipments[]
n_cst_Settings	lnv_Settings

//zmc - start
n_cst_setting_includeparentinimagelookup lnv_ParentLookUp
lnv_ParentLookUp = CREATE n_cst_setting_includeparentinimagelookup
//zmc - end

DataStore lds_RequiredImages
lds_RequiredImages = Create DataStore
lds_RequiredImages.dataObject = "d_billingImages"

DataStore lds_WarningImages
lds_WarningImages = Create DataStore
lds_WarningImages.dataObject = "d_billingImages"

n_cst_bcm	lnv_Bcm
n_cst_beo_ImageType	lnva_ImageTypes[]
n_cst_beo_ImageType		lnv_CurrentImageBeo
n_cst_bso_ImageManager_pegasus	lnv_ImageManager
lnv_ImageManager = Create n_cst_bso_ImageManager_Pegasus

n_cst_bcmService	lnv_bcmService
//ala_filteredids[] = ala_ids[]

ll_ShipmentCount = UpperBound ( anv_Shipments )

gnv_app.inv_cacheManager.of_GetCache ( "n_cst_dlkc_imagetype" , lnv_Bcm , TRUE , TRUE )
IF Not isValid ( lnv_bcm )  THEN
	RETURN -1 									/////// MID CODE RETURN 
END IF


// pre screen for invalid shipments
FOR j = 1 TO ll_ShipmentCount 
	IF Not isValid ( anv_shipments[ j ] ) THEN RETURN -1    /////// MID CODE RETURN 
NEXT


/*FOR EACH SHIPMENT*/
FOR j = 1 TO ll_ShipmentCount
	
	lnv_Shipment = anv_shipments[ j ]
	ll_CurrentID = lnv_shipment.of_GetID ( ) 
	lb_AddIT = TRUE
	
	/* GET THE COMPANY */
	lnv_Shipment.of_GetBillToCompany ( lnv_CurrentCompany , TRUE )
	
	/*Get the required and warning image types on a company by company basis*/
	IF lnv_CurrentCompany.of_OverrideRequiredImageTypes ( ) THEN
		lnv_CurrentCompany.of_getRequiredImageTypes ( lsa_RequiredImageTypes ) 
	ELSE
		lnv_Settings.of_GetRequiredImageTypes ( lsa_RequiredImageTypes )
	END IF
	
	IF lnv_CurrentCompany.of_OverrideWarningImageTypes ( ) THEN
		lnv_CurrentCompany.of_getWarningImageTypes ( lsa_WarningImageTypes  )
	ELSE
		lnv_Settings.of_GetWarningImageTypes ( lsa_WarningImageTypes )
	END IF
	


	// first process the required image types
	FOR i = 1 To upperBound  ( lsa_RequiredImageTypes )
		ls_CurrentType = lsa_RequiredImageTypes[ i ]
		ls_SearchExpression = "imagetype_type = '"  + ls_CurrentType + "'"
		
		IF isValid ( lnv_bcm ) THEN
			lnv_bcmService.of_getallbeo ( lnv_bcm, ls_SearchExpression , lnva_ImageTypes )
		END IF
		
		FOR k = 1 TO upperBound ( lnva_ImageTypes )
			
			lb_InsertError = FALSE
			
			lnv_CurrentImageBeo = lnva_ImageTypes[ k ]
			IF lnv_Imagemanager.of_DoesImageExist ( lnv_currentImageBeo , ll_CurrentID ) THEN
				// Do nothing
				
//				lnv_Shipment.of_SetSourceId(ll_CurrentID)
//				IF lnv_Shipment.of_HasSource() THEN
//					lnva_GoodShipments[ Upperbound ( lnva_GoodShipments )  + 1 ] = lnv_Shipment
//				END IF
				
			ELSE
				// zmc
				IF Upper(lnv_ParentLookUp.of_GetValue()) = Upper(lnv_ParentLookUp.cs_Yes) THEN
					ll_ParentId = lnv_Shipment.of_GetParentId()
					
					IF NOT IsNull(ll_ParentId) OR ll_ParentId > 0 THEN
						IF lnv_Imagemanager.of_DoesImageExist ( lnv_currentImageBeo , ll_ParentId ) THEN
							lnv_Shipment.of_SetSourceId(ll_ParentId)
							IF lnv_Shipment.of_HasSource() THEN
								lnva_GoodShipments[ Upperbound ( lnva_GoodShipments )  + 1 ] = lnv_Shipment  // this could be the problem																
							END IF
						ELSE
							lb_InsertError = TRUE  // we are looking to the parent and the parent image DNE
						END IF
					ELSE
						lb_InsertError = TRUE // we are looking to the parent but there is no parent
					END IF
					
				ELSE
					lb_InsertError = TRUE  // we are not looking to parent and the child image DNE
				END IF
				
				IF lb_InsertError THEN
					ll_NewRow = lds_RequiredImages.InsertRow (0)
					lds_RequiredImages.object.ID[ ll_NewRow ] = ll_CurrentID
					lds_RequiredImages.object.Type[ ll_NewRow ] = ls_CurrentType
					lds_RequiredImages.object.companyname[ ll_NewRow ] = lnv_CurrentCompany.of_GetName ( )
					lb_AddIT = FALSE
				END IF
				
				lnv_Shipment.of_SetSourceId(ll_CurrentID )
			END IF
		NEXT
			
	NEXT // required image types
	
		
	
	// the only way we are not going to add it, is if one of the required
	// images do not exist (if we don't add it we will add it to the 'bad ids')
	IF lb_AddIT THEN 
		lnva_GoodShipments[ Upperbound ( lnva_GoodShipments )  + 1 ] = lnv_Shipment
		lla_GoodIds [ upperbound ( lla_GoodIDs ) +  1 ]  = ll_CurrentID // ids w/ images
	ELSE
		lnva_BadShipments[ Upperbound ( lnva_BadShipments )  + 1 ] = lnv_Shipment
		lla_BadIDs [ upperbound ( lla_BadIDs ) + 1 ] = ll_CurrentID // ids w/o req. images
	END IF
	
	
	// now do the warning types
	For i = 1 To upperBound  ( lsa_WarningImageTypes )
		
		lnv_Shipment.of_SetSourceId ( ll_CurrentID )
		
		lb_WarningError = FALSE
		ls_CurrentType = lsa_WarningImageTypes[ i ]
		ls_SearchExpression = "imagetype_type = '"  + ls_CurrentType + "'"
		
		IF isValid ( lnv_bcm ) THEN
			lnv_bcmService.of_getallbeo ( lnv_bcm, ls_SearchExpression , lnva_ImageTypes )
		END IF
		
		FOR k = 1 TO upperBound ( lnva_ImageTypes )
			lnv_CurrentImageBEO = lnva_ImageTypes[ k ]
			IF lnv_Imagemanager.of_DoesImageExist ( lnv_currentImageBeo , ll_CurrentID ) THEN
				// Do nothing
//				lnv_Shipment.of_SetSourceId(ll_CurrentID)
//				IF lnv_Shipment.of_HasSource() THEN
//					lnva_GoodShipments[ Upperbound ( lnva_GoodShipments )  + 1 ] = lnv_Shipment
//				END IF
			ELSE
				// zmc
				IF Upper(lnv_ParentLookUp.of_GetValue()) = Upper(lnv_ParentLookUp.cs_Yes) THEN
					ll_ParentId = lnv_Shipment.of_GetParentId()
					IF NOT IsNull(ll_ParentId) OR ll_ParentId > 0 THEN
						IF lnv_Imagemanager.of_DoesImageExist ( lnv_currentImageBeo , ll_ParentId ) THEN
							lnv_Shipment.of_SetSourceId(ll_ParentId)
							IF lnv_Shipment.of_HasSource() THEN
								lnva_GoodShipments[ Upperbound ( lnva_GoodShipments )  + 1 ] = lnv_Shipment
							END IF
						ELSE
							lb_WarningError = TRUE
						END IF
					ELSE
						lb_WarningError = TRUE 
					END IF
				ELSE
					lb_WarningError = TRUE
				END IF
				
				IF lb_WarningError THEN 
					ll_NewRow = lds_WarningImages.InsertRow (0)
					lds_WarningImages.object.ID[ ll_NewRow ] = ll_CurrentID
					lds_WarningImages.object.Type[ ll_NewRow ] = ls_CurrentType
					lds_WarningImages.object.companyname[ ll_NewRow ] = lnv_CurrentCompany.of_GetName ( )    
				END IF	
				
			END IF 
			
			lnv_Shipment.of_SetSourceId ( ll_CurrentID )
		NEXT


	NEXT // Warning image types
	

NEXT //(FOR EACH SHIPMENT)



/* open window with the IDs and the image Types that will not be processed because
	the associated image DNE
	IF PTADMIN then provide a 'process anyway' Button
	IF process anyway is selected then append lla_BadIDs to lla_GoodIDs */	

///////////////////////////// REQUIRED IMAGES ////////////////////////////////////////////////
IF lds_RequiredImages.RowCount ( ) > 0 THEN
	lds_RequiredImages.getFullstate ( lblob_fullstate )
	
	lstr_parm.is_Label = "DATASTORE"
	lstr_Parm.ia_Value = lblob_FullState
	lnv_msg.of_Add_parm ( lstr_parm )
	
	lstr_parm.is_Label = "CONTEXT"
	lstr_Parm.ia_Value = "REQUIRED"
	lnv_msg.of_Add_parm ( lstr_parm )
	
	openWithParm ( w_BillingImages  , lnv_msg )
	
	lnv_msg = message.powerobjectparm
	
	IF lnv_Msg.of_Get_Parm ( "CONTINUE" , lstr_parm ) <> 0 THEN
		lb_Continue = lstr_Parm.ia_Value 
	END IF
	
	IF lnv_Msg.of_get_parm ( "OVERRIDE" , lstr_parm ) <> 0 THEN
		lb_Override = lstr_parm.ia_Value
	END IF
	
	IF lb_Override THEN
		/*
			The print order was being changed when seperating the bad ids from the good ids. 
			Send the array back out the way it came in so that the shipments will 
			print in the order selected.
			
			12/16/04 - nwl
		*/
		lla_GoodIDs = ala_filteredids
		
//		For j = 1 TO UpperBound ( lla_BadIDs )
//			lla_GoodIDs [ UpperBound ( lla_GoodIDs ) + 1 ] = lla_BadIDs [ j ]
//		NEXT
		
		FOR j = 1 To UpperBound ( lnva_BadShipments )			
			lnva_GoodShipments[ Upperbound ( lnva_GoodShipments )  + 1 ] = lnva_BadShipments[j]
		NEXT
		
	END IF	
	
ELSE
	lb_Continue = TRUE
END IF

IF NOT lb_Continue THEN  // user wants to Cancel processing of invoices 
	ala_filteredids[] = lla_EMPTYARRAY
	ll_ReturnValue = 0
END IF
	
	
///////////////////////////// WARINING IMAGES ////////////////////////////////////////////////	

lnv_msg.of_Reset ( )	
	
IF lds_WarningImages.RowCount ( ) > 0 AND ll_ReturnValue > 0 THEN
	
	lds_WarningImages.getFullstate ( lblob_fullstate )	

	lstr_parm.is_Label = "DATASTORE"
	lstr_Parm.ia_Value = lblob_FullState
	lnv_msg.of_Add_parm ( lstr_parm )

	lstr_parm.is_Label = "CONTEXT"
	lstr_Parm.ia_Value = "WARNING"
	lnv_msg.of_Add_parm ( lstr_parm )			

	openWithParm ( w_BillingImages  , lnv_msg )

	lnv_msg = message.powerobjectparm	
	
	IF lnv_Msg.of_Get_Parm ( "CONTINUE" , lstr_parm ) <> 0 THEN
		lb_Continue = lstr_Parm.ia_Value 
	END IF
	
	IF NOT lb_Continue THEN 
		ll_ReturnValue = 0 // user canceled
	END IF
	
ELSE
	lb_Continue = TRUE
END IF		

IF lb_Continue THEN
	anv_shipments = lnva_GoodShipments
	ala_filteredids[] = lla_GoodIDs
ELSE // user wants to Cancel processing of invoices 
	ala_filteredids[] = lla_EMPTYARRAY
	ll_ReturnValue = 0
END IF
	

// if there are not any images to print then signal so, as to go into old print code
IF ll_ReturnValue > 0 THEN
	li_PrintReturn = THIS.of_DoImagesNeedToPrint ( lnva_GoodShipments )  
	ll_ReturnValue = li_PrintReturn												
END IF


DESTROY lds_RequiredImages
DESTROY lds_WarningImages
DESTROY lnv_ImageManager
DESTROY lnv_CurrentCompany
DESTROY lnv_ParentLookUp   //zmc

Return ll_returnValue
	
end function

public function long of_createpayabledata (ref n_cst_beo_shipment anva_shipment[], ref n_cst_accountingdata anva_accountingdata[], ref string as_errormsg);long		ll_ndx, &
			ll_shipcount, &
			lla_ids[], &
			ll_return = 1

decimal	lc_payamount			
Boolean  lb_HavePayables

s_parm		lstr_parm

n_cst_accountingdata				lnva_accountingdata[]
n_cst_bso_accountingmanager	lnv_accountingmanager

ll_shipcount=UpperBound ( anva_Shipment ) 
FOR ll_ndx = 1 TO ll_shipcount
	IF isValid ( anva_Shipment[ll_ndx] ) THEN
		lla_IDs[ll_ndx] = anva_Shipment[ll_ndx].of_GetID ( )
	ELSE
		ll_Return = -1
	END IF
NEXT

IF ll_Return = 1 THEN
	//are there any payables
	ll_shipcount = upperbound(anva_shipment)
	for ll_ndx = 1 to ll_shipcount
		lc_payamount = anva_shipment[ll_ndx].of_getpayabletotal()
		if lc_payamount > 0 then
			lb_HavePayables = TRUE
			// Check That it has a carrierSpecified See issue 1992
			IF anva_Shipment[ll_ndx].of_GetPayableFormat ( ) <> appeon_constant.cs_PayableFormat_Total AND IsNull ( anva_shipment[ ll_ndx ].of_GetCarrier ( ) )  THEN
				ll_return = -1			
				as_errorMsg = "Shipment " + String ( anva_shipment[ll_ndx].of_GetID ( ) ) + " cannot be billed. Since it is a Brokerage Shipment with a payable amount, a carrier must be specified before it can be processed.~r~nRequest Cancelled."
				EXIT
			END IF
		end if
	next
	
END IF
	
IF ll_return = 1 THEN
	if lb_HavePayables  then
		lnv_accountingmanager = create n_cst_bso_accountingmanager

		if lnv_accountingmanager.of_createdata( anva_Shipment, id_invoicedate, "PAYABLES", lnva_accountingdata ) > 0 then
			if upperbound(lnva_accountingdata) > 0 then
				//are there any missing accounts
				if lnv_accountingmanager.of_blankpayablesaccount(lnva_accountingdata) then
					as_errormsg = "One of the AP amount types is missing an account."
					ll_return = -1
				else
					anva_accountingdata = lnva_accountingdata					
				end if
			end if
		end if
	
		if isvalid(lnv_accountingmanager) then
			destroy lnv_accountingmanager
		end if
	
	end if
END IF

return ll_return

end function

public function integer of_prebill (n_cst_msg anv_msg);/***************************************************************************************
NAME: of_PreBill		

ACCESS: Public
		
ARGUMENTS: 		(n_cst_Msg anv_Msg)

RETURNS:	Integer
	
DESCRIPTION:
			Returns 1 if billing process should continue
			Returns -1 if billing process should stop


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 12/20/05 Maury

***************************************************************************************/
Integer	li_Return = 1
Integer	li_RegSet
Long		i
Long		ll_Max
Long		ll_id
Boolean	lb_Email
String	ls_Msg
s_parm	lstr_Parm

n_cst_anyarraysrv			lnv_ArraySrv
n_cst_beo_Shipment		lnva_Shipments[]
n_cst_beo_Company			lnv_Company
String					   lsa_EmailCompanies[]
Environment					lenv_Object

lnv_company = CREATE n_cst_beo_company
lnv_company.of_SetUseCache(TRUE)

ls_Msg = "Error initializing auto email service."
IF anv_Msg.of_Get_Parm ( "SHIPMENTS" , lstr_Parm ) <> 0 THEN
	lnva_Shipments = lstr_Parm.ia_Value
	ll_Max = Upperbound(lnva_Shipments)
	FOR i = 1 TO ll_Max
		IF isValid(lnva_Shipments[i]) THEN
			ll_Id = lnva_Shipments[i].of_getBillTo( )
			lnv_Company.of_SetSourceId ( ll_Id )
			IF isValid(lnv_Company) THEN
				lb_Email = lnv_Company.of_EmailInvoices()
				IF lb_Email THEN
					lsa_EmailCompanies[i] = lnv_Company.of_GetBillingName( )
				END IF
			END IF
		END IF
	NEXT
	
	//Remove Duplicate Companies
	lnv_ArraySrv.of_getShrinked(lsa_EmailCompanies, TRUE, TRUE)
	

	IF UpperBound(lsa_EmailCompanies[]) > 0 THEN
		
		li_RegSet = This.of_SetGsRegistry()
		
		IF li_RegSet = 1 THEN //OK to go
			li_Return = 1
		ELSE //Auto email not set up
			ls_Msg = "Error initializing auto email for the following billto companies:~r~n"
			ll_Max = UpperBound(lsa_EmailCompanies[])
			FOR i = 1 TO ll_Max
				ls_Msg += "~t- " + lsa_EmailCompanies[i] + "~r~n"
			NEXT
			ls_Msg += "~r~nClick OK to process bill(s) anyway.~r~nClick Cancel to abort."
			li_Return = -1
		END IF
		
	END IF
	
END IF

IF li_Return = -1 THEN
	IF MessageBox("AutoEmail Error", ls_Msg, Information!, OkCancel!, 2) = 1 THEN
		li_Return = 1  //Process Anyway
	ELSE
		li_Return = -1
	END IF
END IF

Destroy lnv_Company

Return li_Return
end function

private function integer of_setgsregistry ();/***************************************************************************************
NAME: of_SetGsRegistry		

ACCESS: Private
		
ARGUMENTS: 		(none)

RETURNS:	Integer
	
DESCRIPTION:
			Returns 1 if Auto-email installed and path environment variable is set
			Returns -1 if not installed or path env var is not set


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 12/20/05 Maury

***************************************************************************************/

Integer	li_Return = 1
Integer	li_Pos
String	ls_GsPath
String   ls_RegPath
String	ls_NewRegPath
String	ls_Dir
String 	ls_Msg

ls_Msg = "Error initializing auto email client"
//Get Ghostscript Install Path
IF li_Return = 1 THEN
	li_Return = RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\GNU Ghostscript\7.06", "GS_DLL", RegString!, ls_Dir)
	
	IF li_Return = -1 THEN //GhostScript not installed
		ls_Msg = "Auto email not installed.~r~nPlease install auto email distiller and try again."
	END IF
END IF


//Get Current Path Environment Variable
IF li_Return = 1 THEN
	li_Return = RegistryGet("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment", "Path", RegExpandString!, ls_RegPath)
	//Find Winxp PATH var
	IF li_Return = -1 THEN
		li_Return = RegistryGet("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment", "PATH", RegString!, ls_RegPath)	
	END IF
	IF li_Return = -1 THEN
		ls_Msg = "Error initializing auto email client.~r~nSystem Path Environment variables could not be located."
	END IF
END IF


//Check if install path is in the environment variable
IF li_Return = 1 THEN
	li_Pos = LastPos(ls_Dir, "\") - 1
	ls_GSPath = Left(ls_Dir, li_Pos)
	IF Pos(Upper(ls_RegPath), Upper(ls_GSPath)) = 0 THEN
		ls_Msg = "Error initializing auto email client.~r~nAuto-email is not properly set up."
		li_Return = -1 
	END IF
END IF

IF li_Return = -1 THEN
	MessageBox("Auto Email Error", ls_Msg)
END IF

Return li_Return
end function

public function integer of_recordmessage (string as_message);/*
	Created by Dan 2-19-07
	
	This function logs a message in a nonvisual object.  To retrieve the last message logged call of_getLastMessage()

	I initially created this to capture when an invoice already exists for batching.
*/
Int	li_return = 1
IF isValid( inv_messages ) THEN
	
ELSE
	inv_messages = create n_cst_errormessages_accounting
END IF

inv_messages.of_logErrorMessage( as_message )

RETURN li_Return
end function

public function integer of_getlastmessage (ref string as_message);/*
	Created By dan 2-19-07
	
	This function will return the last message logged by of_RecordMessage by reference.
	
	It returns 1 if there is a message to get, -1 If there isn't
*/

Int	li_return = 1
String	ls_message

IF isValid( inv_messages ) THEN
	IF inv_messages.of_getLastMessage( ls_message ) = 1 THEN
		as_message = ls_message
	ELSE
		li_return = -1
	END IF
ELSE
	li_return = -1
END IF

as_message = ls_message

RETURN li_Return 


end function

public function integer of_resetmessages ();/*
	Created By Dan 2-19-07
	
	This function resets the nonvisual message service so that there are no messages.
*/

Int	li_Return = 1

IF isValid( inv_messages ) THEN
	inv_messages.of_reset()
END IF

RETURN 1


end function

on n_cst_billing.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_billing.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;destroy ids_graphic_definitions
Destroy inv_messages
end event

event constructor;integer li_ndx

istr_billing_copies.longar[5] = 0
for li_ndx = 2 to 4
	istr_billing_copies.longar[li_ndx] = 1
next
end event

