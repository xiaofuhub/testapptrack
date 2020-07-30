$PBExportHeader$w_bill_preview.srw
$PBExportComments$PTBILL.
forward
global type w_bill_preview from window
end type
type st_1 from u_st_label within w_bill_preview
end type
type cb_print from commandbutton within w_bill_preview
end type
type dw_bills from u_bills within w_bill_preview
end type
type dw_bill_manifest from u_dw_bill_manifest within w_bill_preview
end type
end forward

global type w_bill_preview from window
integer x = 402
integer y = 356
integer width = 2848
integer height = 1828
boolean titlebar = true
string title = "Invoice Viewer"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
st_1 st_1
cb_print cb_print
dw_bills dw_bills
dw_bill_manifest dw_bill_manifest
end type
global w_bill_preview w_bill_preview

type variables
protected:
n_cst_billing inv_cst_billing
string is_type
s_longs istr_copies
Long	ila_Ids[]
n_cst_bso_Dispatch	inv_Dispatch
n_cst_beo_Shipment	inva_Shipments[]
end variables

forward prototypes
protected function integer wf_retrieve (long ala_ids[], string as_type)
end prototypes

protected function integer wf_retrieve (long ala_ids[], string as_type);integer li_setloop
string ls_message_header
long lla_ids[]
string	ls_PosString
string	ls_IdList
string	ls_Sort
n_cst_String	lnv_String

if UpperBound ( ala_Ids ) = 0 then goto close_window

lla_ids = ala_ids
is_type = as_type

choose case is_type
case "INVOICE!"
	ls_message_header = "View Invoice"
	

	//NOTE: of_Manifest_Check may change the values of lla_ids and is_type
	CHOOSE CASE inv_cst_billing.of_manifest_check(lla_ids, is_type)

	CASE -1  //Failure
		goto failure

	CASE -2  //Either more than one manifest, or a mix of manifest and non-manifest shipments.
		MessageBox ( ls_Message_Header, "At least one of the shipments you requested was billed on "+&
			"a manifest, and others you requested were billed either on different manifests or on "+&
			"standard invoices.  A manifest must be viewed by itself.~n~nRequest cancelled." )
		GOTO Close_Window

	END CHOOSE


case "DELIVERY_RECEIPT!"
	ls_message_header = "Delivery Receipt"
	cb_print.text = "&Print"
	this.title = "Delivery Receipt"
	dw_bills.of_set_layout("DELIVERY_RECEIPT!")
end choose


//Build Sort
lnv_String.of_arraytostring( lla_ids, ',', ls_IdList)
ls_PosString = "," + ls_IdList + ","
ls_Sort = "Pos ( '" + ls_PosString + "',  ',' + String ( ds_id ) + ',' ) A"
dw_Bills.of_SetSort(ls_Sort)


if inv_cst_billing.of_retrieve(lla_ids, is_type) = 1 then
	if is_type = "MANIFEST!" then
		dw_Bills.Hide ( )  //new
		dw_bill_manifest.show()  //old
	else
		dw_Bill_Manifest.Hide ( )  //new
		dw_bills.show()  //old
	end if
else
	goto failure
end if

ila_Ids = lla_Ids

return 1

failure:
messagebox(ls_message_header, "Could not retrieve information from database."+&
	"~n~nRequest cancelled.", exclamation!)

close_window:
close(this)
return -1
end function

event open;s_anys lstr_open_parms
string ls_type
long lla_ids[]
Long	ll_IDCount
Long	i
Long	ll_FindRow
n_cst_beo_shipment	lnv_Shipment
lstr_open_parms = message.powerobjectparm
ls_type = lstr_open_parms.anys[1]
lla_ids = lstr_open_parms.anys[2]

n_cst_PrivsManager	lnv_PrivManager

lnv_PrivManager = gnv_App.of_GetPrivsManager( )

inv_Dispatch = CREATE n_cst_Bso_Dispatch

DataStore	lds_Cache

ll_IDCount = UpperBound ( lla_Ids )
inv_Dispatch.of_RetrieveShipments ( lla_Ids )
lds_Cache = inv_Dispatch.of_GetShipmentCache ( )
FOR i = 1 TO ll_IDCount
	
	
	//lnv_Shipment.of_SetSource ( lds_Cache )
//	lnv_Shipment.of_SetSourceid ( lla_Ids[i]  )
	inva_Shipments[ Upperbound ( inva_Shipments ) + 1 ] = CREATE n_cst_beo_Shipment
	inva_Shipments[ Upperbound ( inva_Shipments ) ].of_SetSource ( lds_Cache )
	inva_Shipments[ Upperbound ( inva_Shipments ) ].of_SetSourceid ( lla_Ids[i]  )
	

NEXT

//Check permissions
IF lnv_PrivManager.of_GetUserPermissionFromFn(lnv_PrivManager.cs_ViewBilling) <> 1 THEN
	
	Messagebox("View Invoice", "You do not have permission to view billing information.")
	Close(This)
	
ELSEIF lnv_PrivManager.of_GetUserPermissionFromFn(lnv_PrivManager.cs_ViewCharges) <> 1 THEN
	
	Messagebox("View Invoice", "You do not have permission to view charges.")
	Close(This)
	
ELSE
	inv_cst_billing = create n_cst_billing
	dw_bills.of_set_manager(inv_cst_billing)
	dw_bill_manifest.of_set_manager(inv_cst_billing)

	post wf_retrieve(lla_ids, ls_type)
END IF
end event

event key;//choose case is_type
//case "INVOICE!", "DELIVERY_RECEIPT!"
//	if keydown(keyleftarrow!) then
//		dw_bills.scrollpage(-1)
//	elseif keydown(keyrightarrow!) then
//		dw_bills.scrollpage(1)
//	end if
//end choose
end event

on w_bill_preview.create
this.st_1=create st_1
this.cb_print=create cb_print
this.dw_bills=create dw_bills
this.dw_bill_manifest=create dw_bill_manifest
this.Control[]={this.st_1,&
this.cb_print,&
this.dw_bills,&
this.dw_bill_manifest}
end on

on w_bill_preview.destroy
destroy(this.st_1)
destroy(this.cb_print)
destroy(this.dw_bills)
destroy(this.dw_bill_manifest)
end on

event close;destroy inv_cst_billing
Destroy inv_Dispatch

Int	i 
Int	li_Count

li_Count = UpperBound ( inva_shipments )
FOR i = 1 TO li_Count 
	DESTROY ( inva_shipments [i] )
NEXT
end event

type st_1 from u_st_label within w_bill_preview
integer x = 114
integer y = 36
integer width = 1865
string text = "Use PgUp, PgDn, arrow keys, or scroll bar to change page view."
end type

type cb_print from commandbutton within w_bill_preview
integer x = 2208
integer y = 28
integer width = 535
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Print Copies ..."
end type

event clicked;// RDT 6-16-03 bug fix
// RDT 7-15-03 bug fix
s_longs lstr_starting_copies, lstr_selected_copies
string ls_billing_type

boolean	lb_preview_only, &
			lb_PrintImages

integer	li_ndx, &
			li_ImageReturn
Long	ll_RowCount, &
		ll_Row
		
n_cst_LicenseManager	lnv_LicenseManager


choose case is_type
case "INVOICE!", "MANIFEST!"

	if g_max_permit >= "T" then
		//User has reprint authorization.  Availability will depend on status.
		if is_type = "INVOICE!" then

			ll_RowCount = dw_Bills.RowCount ( )

			FOR ll_Row = 1 TO ll_RowCount
				if isnull(dw_bills.getitemdate(ll_Row, "ds_bill_date")) then
					lb_preview_only = true
					EXIT
				else
					//Shipment has been billed.
					//Leave lb_preview_only = false
				end if
			NEXT

		elseif is_type = "MANIFEST!" then
			lb_preview_only = false
			//A manifest, by virtue of its existence here, has been billed
		end if
	else
		lb_preview_only = true
		//Status is irrelevant.  User does not have reprint authorization.
	end if

	if lb_preview_only then
		lstr_starting_copies.longar[1] = 1
		if upperbound(istr_copies.longar) > 0 then
			if istr_copies.longar[1] > 0 then &
				lstr_starting_copies.longar[1] = istr_copies.longar[1]
		end if
		for li_ndx = 2 to 5
			lstr_starting_copies.longar[li_ndx] = 0
			setnull(lstr_starting_copies.longar[li_ndx])
		next
	else
		for li_ndx = 1 to 5
			lstr_starting_copies.longar[li_ndx] = 0
			if upperbound(istr_copies.longar) >= li_ndx then
				if istr_copies.longar[li_ndx] > 0 then &
					lstr_starting_copies.longar[li_ndx] = istr_copies.longar[li_ndx]
			end if
		next
	end if

	if not inv_cst_billing.of_get_copies(lstr_starting_copies, lstr_selected_copies) then return
case "DELIVERY_RECEIPT!"
	lstr_selected_copies.longar[1] = 1
end choose

istr_copies = lstr_selected_copies

choose case is_type
case "MANIFEST!"
	inv_cst_billing.of_print(dw_bill_manifest, istr_copies)
case "INVOICE!", "DELIVERY_RECEIPT!"
	inv_cst_billing.of_print(dw_bills, istr_copies)
end choose


CHOOSE CASE is_type
		
	CASE "INVOICE!", "MANIFEST!"

		IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Imaging ) THEN
		
			// this will unlock pegasus if not already done
			n_cst_bso_ImageManager_pegasus	lnv_Imagemanager
			lnv_ImageManager = CREATE n_cst_bso_ImageManager_Pegasus
			
			IF lnv_ImageManager.of_CheckConnection ( )  <> 0 THEN
				MessageBox ("Image Printing" , "The controls needed to print the associated images could not be located or unlocked. Printing of the images will not occur." ) 
				lb_PrintImages = FALSE
			ELSE 									// RDT 6-16-03
				lb_PrintImages = TRUE 		// RDT 6-16-03
			END IF
			
			IF isValid ( lnv_ImageManager ) THEN
				Destroy lnv_ImageManager
			END IF

			If lb_PrintImages Then  		// RDT 6-16-03
				li_ImageReturn =  inv_cst_billing.of_DoImagesNeedToPrint ( inva_Shipments[] ) 
				
				CHOOSE CASE li_ImageReturn
						
					CASE -1 // failure
						
					CASE 1 // success, but no images to be printed
							lb_PrintImages = FALSE
							
					CASE 2 // success and there are images to print
						
						IF MessageBox ( "Document Imaging" , "Would you like to print the associated images" , QUESTION!, YESNO!, 1 ) = 1 THEN
							lb_PrintImages = TRUE				
						Else									// RDT 7-15-03 bug fix
							lb_PrintImages = FALSE		// RDT 7-15-03 bug fix
						END IF
						
					CASE ELSE // unexpected Return
						
				END CHOOSE 
			End If  								// RDT 6-16-03 		
		END IF
		
		IF lb_PrintImages THEN
			CHOOSE CASE is_type
				CASE "INVOICE!"
					inv_cst_billing.of_PrintBillingImages ( dw_bills )
				CASE 	"MANIFEST!"
					inv_cst_billing.of_PrintBillingImages ( dw_bill_manifest )
			END CHOOSE
		END IF

END CHOOSE

end event

type dw_bills from u_bills within w_bill_preview
integer x = 9
integer y = 140
integer taborder = 10
end type

type dw_bill_manifest from u_dw_bill_manifest within w_bill_preview
integer x = 9
integer y = 140
integer width = 2811
integer height = 1588
integer taborder = 20
end type

