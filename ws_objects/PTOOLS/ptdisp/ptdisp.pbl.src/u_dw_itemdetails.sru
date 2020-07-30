$PBExportHeader$u_dw_itemdetails.sru
forward
global type u_dw_itemdetails from u_dw_shipmentitemlist
end type
end forward

global type u_dw_itemdetails from u_dw_shipmentitemlist
integer width = 1723
integer height = 1376
boolean titlebar = true
string title = "Item Details"
string dataobject = "d_item_details"
boolean controlmenu = true
boolean hscrollbar = false
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
event wheel_scroll pbm_vscroll
event ue_setredraw ( boolean ab_redraw )
end type
global u_dw_itemdetails u_dw_itemdetails

type variables
string	is_ratecodenameprotect, &
	is_ratetypeprotect, &
	is_rateprotect, &
	is_itemamtprotect

end variables

forward prototypes
public function long of_getmiles (long al_startrow, long al_endrow, ref decimal ac_miles)
public function string of_getcolumnfocus ()
public subroutine of_setcolumnfocus (long al_row)
public function integer of_setratingprotection (long al_row)
public function integer of_hidecharges ()
end prototypes

event wheel_scroll;Message.Processed = True
end event

public function long of_getmiles (long al_startrow, long al_endrow, ref decimal ac_miles);//The calculation part of this function can (and should) be generalized to a column 
//summing function.  I don't have time to deal with the decimal/non-decimal argument
//issues right now.

//!!Note!! The al_start_row value (which is correct from a point-to-point perspective) 
//needs to have one added to it in order to target the correct rows.

long 	ll_row, &
		ll_return = 1
decimal lc_miles, lc_total
boolean lb_all_ok

n_ds		lds_EventCache
n_cst_bso_dispatch	lnv_dispatch

lnv_dispatch = this.event ue_getdispatch()
lds_EventCache = lnv_dispatch.of_GetEventCache()

if isvalid(lds_EventCache) then
	if isnull(al_startrow) then al_startrow = 1
	if isnull(al_endrow) then al_endrow = lds_EventCache.rowcount()
else
	ll_return = 0
end if

IF al_startrow > lds_EventCache.Rowcount( ) OR al_EndRow > lds_EventCache.Rowcount( )  THEN
	ll_Return = 0
END IF

if ll_return = 1 then
	al_startrow ++
	
	lb_all_ok = true
	
	for ll_row = al_startrow to al_endrow
		lc_miles = lds_EventCache.object.leg_miles[ll_row]
		if isnull(lc_miles) then lb_all_ok = false else lc_total += lc_miles
	next
	
	ac_miles = lc_total
	
end if

if lb_all_ok then
	ll_return = 1
else
	ll_return = 0
end if

return ll_return
end function

public function string of_getcolumnfocus ();return is_setcolumn
end function

public subroutine of_setcolumnfocus (long al_row);//this.post setredraw(false)

this.post scrolltorow(al_row)
this.post setcolumn(is_setcolumn)

//this.post setredraw(true)


end subroutine

public function integer of_setratingprotection (long al_row);//MessageBox ( "Rating" , "Protection" )
n_cst_bso_rating	lnv_rating
lnv_rating = create n_cst_bso_rating
if lnv_rating.of_haseditrights(this.object.di_item_type[al_Row]) then
	//don't need to protect
///////			this.Modify("ratecodename.Protect='1~tIf(IsRowNew(),0,1)'")


	// I Uncommented this line to address issue 785
	this.Modify("ratecodename.Protect=" + is_ratecodenameprotect)
	
	this.Modify("di_our_ratetype.Protect=" + is_ratetypeprotect)
	this.Modify("di_our_rate.Protect=" + is_rateprotect)
	this.Modify("di_our_itemamt.Protect=" + is_itemamtprotect)
	
	this.Modify("ratecodename.background.color=" + String ( RGB ( 255, 255, 255)) )
	
	
	this.Modify("di_our_rate.background.color=~"12648447 ~tif( describe (~~~"txt_bill_ind.text~~~") = ~~~"I~~~", if ( describe ( ~~~"txt_restrict_ind.text~~~" ) = ~~~"T~~~" OR  accountingtype = ~~~"2~~~", 12648447, 16777215	 ), 12632256 )~"" )  
	this.Modify("di_our_ratetype.background.color=~"12648447 ~tif( describe (~~~"txt_bill_ind.text~~~") = ~~~"I~~~", if ( describe ( ~~~"txt_restrict_ind.text~~~" ) = ~~~"T~~~" OR  accountingtype = ~~~"2~~~", 12648447, 16777215	 ), 12632256 )~"" ) 
	this.Modify("di_our_itemamt.background.color=~"12648447 ~tif( describe (~~~"txt_bill_ind.text~~~") = ~~~"I~~~", if ( describe ( ~~~"txt_restrict_ind.text~~~" ) = ~~~"T~~~" OR  accountingtype = ~~~"2~~~", 12648447, 16777215	 ), 12632256 )~"" ) 
	
	//ADDED BY DAN 2-8-07
//	n_cst_privsManager lnv_manager
//	lnv_manager = gnv_app.of_getPrivsmanager( )
//	n_cst_beo_shipment lnv_shipment
//	lnv_shipment = this.event ue_getshipment( )
//	IF lnv_manager.of_getuserPermissionfromfn( lnv_manager.cs_modifybilledshiprates , lnv_shipment) = lnv_manager.ci_true THEN
//		this.object.ratecodename.protect=0
//		this.object.di_our_ratetype.protect=0
//		this.object.di_our_rate.protect=0
//		this.object.di_our_itemamt.protect=0
//		this.Modify("di_our_rate.background.color=" + String ( RGB ( 255, 255, 255))  )  
//		this.Modify("di_our_ratetype.background.color=" + String ( RGB ( 255, 255, 255))  ) 
//		this.Modify("di_our_itemamt.background.color=color=" + String ( RGB ( 255, 255, 255))  )
//		
//	END IF
	////////////////////
else
	this.object.ratecodename.protect=1
	this.object.di_our_ratetype.protect=1
	this.object.di_our_rate.protect=1
	this.object.di_our_itemamt.protect=1
	
	this.Modify("ratecodename.background.color=" + "12648447"  )
	this.Modify("di_our_ratetype.background.color=" + "12648447"  )
	this.Modify("di_our_rate.background.color=" + "12648447"  )
	this.Modify("di_our_itemamt.background.color=" + "12648447"  )

end if
destroy lnv_rating
RETURN 1
end function

public function integer of_hidecharges ();//created by dan 1-30-07 to hide charges

Int	li_return = 1 
Long		ll_Row
String	ls_itemType


this.modify("di_pay_rate.Visible=0")
this.modify("di_our_rate.Visible=0")
this.modify("di_our_itemamt.Visible=0")
this.modify("di_pay_itemamt.Visible=0")
//this.modify("di_our_ratetype.Visible=0")
ll_row = this.getRow()

//Need to hide the description when its a FSC becuase it displays the%
IF ll_Row > 0 THEN
	ls_itemType = this.getITemString(ll_Row,"di_item_type")
	IF ls_itemType = "A" THEN
		this.modify("di_description.Visible=0")
	ELSE
		this.modify("di_description.Visible=1")
	END IF
END IF

RETURN li_RETURN 
end function

event buttonclicked;setpointer(HourGlass!)
string	ls_codename
decimal lc_miles
long	ll_miles, &
		ll_pu_event, &
		ll_del_event, &
		ll_ItemCount

n_Cst_msg				lnv_Msg
S_Parm					lstr_Parm
n_cst_beo_company		lnv_company
n_cst_LicenseManager	lnv_LicenseManager
n_cst_beo_Item			lnv_Item, &
							lnva_item[]
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.Event ue_GetShipment ( ) 
ll_ItemCount = THIS.RowCount ( ) 
//modified 2-8-07 by dan to use new privilege function when the shipment status is billed
String	ls_privFunction
IF isvalid( lnv_shipment ) THEN
	IF lnv_shipment.of_isBilled( ) THEN
		ls_privFunction = appeon_constant.cs_ModifyBilledShip
	ELSE
		ls_privFunction = "ModifyShipment"
	END IF
ELSE
	ls_privFunction = "ModifyShipment"
END IF
////////////////////////////
IF gnv_app.of_getprivsmanager( ).of_getuserpermissionfromfn( ls_privFunction, lnv_Shipment ) = appeon_constant.ci_True THEN

	lnv_Item = CREATE n_cst_beo_Item
	lnv_Item.of_SetSource ( this )
	lnv_Item.of_SetSourceRow ( row )
	lnv_Item.of_SetShipment ( lnv_Shipment )
	
	
	CHOOSE CASE dwo.Name
		case "cb_leg_miles", "cb_total_miles"
			choose case dwo.name
			case "cb_leg_miles"
				ll_pu_event = this.object.di_pu_event[row]
				ll_del_event = this.object.di_del_event[row]
				
				if IsNull (ll_pu_event ) OR isNull ( ll_Del_event ) and lnv_Shipment.of_isintermodal( ) THEN
					Open ( w_StopSelection )	
					If IsValid  ( Message.PowerobjectParm ) THEN
						lnv_Msg = Message.PowerobjectParm
						IF lnv_Msg.of_get_Parm ( "START" , lstr_Parm ) > 0 THEN
							ll_pu_event = lstr_Parm.ia_Value
						END IF
						
						IF lnv_Msg.of_get_Parm ( "END" , lstr_Parm ) > 0 THEN
							ll_del_event = lstr_Parm.ia_Value			
						END IF
					END IF							
				END IF
				
	
				if ll_pu_event > 0 and ll_del_event > 0 then
					this.of_getmiles(ll_pu_event, ll_del_event, lc_miles)
				end if
			case "cb_total_miles"
				this.of_getmiles(null_long, null_long, lc_miles)	
			end choose
			lc_miles = round(lc_miles, 0)
			this.setfocus()
			if this.getcolumnname() = "di_miles" then
			else
				if this.setcolumn("di_miles") = 1 then
				else
					return
				end if
			end if
			this.settext(string(lc_miles, "0"))
			this.selecttext(1, len(this.gettext()))
		
		CASE "cb_fuelsurcharge", "cb_autorate", "cb_ratelookup"
		
			if dwo.name = "cb_fuelsurcharge" then
				lnv_Item.of_MakeFuelSurcharge ( )	
				
			elseif dwo.name = "cb_autorate" then
				if lnv_LicenseManager.of_HasAutoRatingLicensed ( ) then
					n_cst_bso_rating	lnv_rating
					lnv_rating = create n_cst_bso_rating
					if lnv_rating.of_haseditrights(this.object.di_item_type[row]) then
						IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_AutoRating, "E" ) >= 0 THEN
							long	ll_ratedatacount, &
									ll_ndx
							
							n_cst_RateData		lnva_rateData[]
							ls_codename = this.object.ratecodename[row]
				
							lnv_Item.of_setRatecodename('')
							if lnv_Item.of_autorate ( lnva_rateData) = -1 then
								//error, set codename back
								this.object.ratecodename[row] = ls_codename
							else
								setpointer(HourGlass!)
								lnva_item[1] = lnv_item
								lnv_Item.of_applyautorate ( lnva_rateData)
								ll_ratedatacount = upperbound(lnva_ratedata)
								for ll_ndx = 1 to ll_ratedatacount
									destroy lnva_rateData[ll_ndx]
								next
							END IF
						END IF
					else
						messagebox('Auto Rate',  "Your current user privileges do not allow you to " +&
						"perform this operation.", exclamation!)
					end if
					destroy lnv_rating
				end if			
				
			elseif dwo.name = "cb_ratelookup" then			

				w_AutoRateQuery		lw_autoratequery
		
				lstr_Parm.is_Label = "DISPATCH"
				lstr_Parm.ia_Value = this.event ue_getdispatch()
				lnv_Msg.of_Add_Parm (lstr_Parm)
		
				lstr_Parm.is_Label = "ITEMID"
				lstr_Parm.ia_Value = lnv_item.of_getid()
				lnv_Msg.of_Add_Parm (lstr_Parm)
				OpenSheetWithParm ( lw_autoratequery, lnv_msg, gnv_App.of_GetFrame ( ), 0, Layered! )
			end if
		
		CASE "cb_newfreight"
			THIS.Event ue_AddItem ( n_cst_constants.cs_itemtype_freight )
			
			
		CASE "cb_newacc"
			THIS.Event ue_AddItem ( n_cst_constants.cs_itemtype_accessorial )
	
		
	END CHOOSE	


	DESTROY ( lnv_Item )
END IF

end event

event constructor;// RDT 6-30-03 
//OVER RIDE ANCESTOR ( for highlight )
ib_rmbMenu = FALSE
is_Context = "TL"
string ls_x
String	ls_CodeTable


n_cst_presentation_RateTable 	lnv_PresentationRate
n_cst_Presentation_AmountType	lnv_amountpresentation
n_cst_licensemanager				lnv_licensemanager

lnv_Presentationrate.of_SetPresentation ( THIS )

lnv_amountpresentation.of_setcategory(n_cst_constants.ci_category_receivables)
//lnv_amountpresentation.of_filterbyitemtype()
lnv_amountpresentation.of_setPresentation ( this )

ls_CodeTable = &
	"BILLABLE~t" + n_cst_constants.cs_accountingtype_billable + "/"+&
	"PAYABLE~t" + n_cst_constants.cs_accountingtype_payable + "/"+&
	"BOTH~t" + n_cst_constants.cs_accountingtype_both + "/"
	
	
This.Modify ( "accountingtype.Edit.CodeTable = Yes	accountingtype.Values = '" +  ls_CodeTable+ "' accountingtype.ddlb.allowedit=no accountingtype.ddlb.UseAsBorder=no accountingtype.ddlb.case=upper accountingtype.ddlb.autohscroll=yes accountingtype.ddlb.vscrollbar=yes " )             

is_ratecodenameprotect = this.Describe("ratecodename.Protect")
is_ratetypeprotect = this.Describe("di_our_ratetype.Protect")
is_rateprotect = this.Describe("di_our_rate.Protect")
is_itemamtprotect = this.Describe("di_our_itemamt.Protect")

// RDT 6-30-03 This will eliminate the changing of rows when the right mouse is clicked on a field.
this.ib_rmbfocuschange = FALSE 


end event

event ue_sethazmat;n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.Event ue_GetShipment ( )
IF isValid ( lnv_Shipment ) THEN
	lnv_Shipment.of_SetHazmat ( ab_value )
END IF

RETURN 1
end event

event rowfocuschanged;call super::rowfocuschanged;n_cst_privsManager	lnv_manager
if currentrow > 0 then
	string 	ls_type, &
				lsa_list[], &
				lsa_result[], &
				ls_setting
				
	long	ll_count, &
			ll_found, &
			ll_row, &
			ll_ndx, &
			ll_amounttype
			
	boolean	lb_found
	
	datawindowchild	ldwc_amounttype
	n_cst_Presentation_AmountType	lnv_amountpresentation
	n_cst_String		lnv_String
	n_cst_licensemanager	lnv_licensemanager
	
	
	ls_type = this.object.di_item_type[currentrow]
	lnv_amountpresentation.of_setcategory(n_cst_constants.ci_category_receivables)
	lnv_amountpresentation.of_setamounttypefilter(ls_type)
	lnv_amountpresentation.of_setPresentation ( this )

	ll_amounttype = this.object.amounttype[currentrow]
//	ll_count = this.GetChild('amounttype', ldwc_amounttype)
	ls_setting = this.Object.amounttype.Values
	if ls_setting = '?' then
		ls_setting = ''
	end if
	ll_count = lnv_String.of_Parsetoarray(ls_setting,'/', lsa_list)
	if ll_count > 0 then
		for ll_ndx = 1 to ll_count
			if lnv_String.of_Parsetoarray(lsa_list[ll_ndx],'~t', lsa_result) > 0 then
				if upperbound(lsa_result) > 1 then
					if ll_amounttype = long(lsa_result[2]) then
						lb_found = true
						exit
					end if
				end if
			end if	
		next
	end if
	if not lb_found then
		//add to list
		lnv_amountpresentation.of_getbyitemtype('', lsa_list)
		ll_count = upperbound(lsa_list)
		for ll_ndx = 1 to ll_count
			if lnv_String.of_Parsetoarray(lsa_list[ll_ndx],'~t', lsa_result) > 0 then
				if upperbound(lsa_result) > 1 then
					if ll_amounttype = long(lsa_result[2]) then
						lb_found = true
						exit
					end if
				end if
			end if	
		next
		if lb_found then
			if len(trim(ls_setting)) > 0 then
				ls_setting = "***" + lsa_result[1] + "***" + '~t' + lsa_result[2] + "/" + this.Object.amounttype.Values
			else
				ls_setting = "***" + lsa_result[1] + "***" + '~t' + lsa_result[2] + "/"
			end if
			this.Object.amounttype.Values = ls_setting
		end if
	end if
		
	//autorating
//	if lnv_LicenseManager.of_HasAutoRatingLicensed ( ) then
// I commented this out because the setting is on the dispatch tab so it leads users to think that they can 
// protect the fields even it they do not have autoRating
		THIS.of_Setratingprotection( currentrow )
		
//	end if		
	
//ADDED BY DAN 1-30-07 to hide rates / charges
lnv_manager = gnv_app.of_getPrivsmanager( )
IF lnv_manager.of_getUserpermissionfromfn( "View Charges") <> 1 THEN
	this.of_hidecharges( )
END IF
/////////////////////////////	

end if

end event

event clicked;call super::clicked;string	ls_billto, &
			ls_orig, &
			ls_dest, &
			ls_changed, &
			ls_taglist, &
			ls_message

long		ll_billto

n_cst_string		lnv_string
n_cst_beo_company	lnv_company
n_cst_licensemanager	lnv_licensemanager

choose case dwo.name
		
	case 'lastratedby'
	
	ls_taglist = this.object.TagList[row]
	
	if len(trim(ls_taglist)) > 0 then
		ll_billto = long(lnv_string.of_GetKeyValue(ls_taglist,'BillTo',','))
		if ll_billto = 0 or isnull(ll_billto) then
			//no billto
		else
			lnv_company = create	n_cst_beo_company
			gnv_cst_Companies.of_Cache ( ll_billto, FALSE )
			lnv_Company.of_SetUseCache ( TRUE )
			IF lnv_Company.of_SetSourceId ( ll_billto ) = 1 THEN
				IF lnv_Company.of_HasSource ( ) THEN
					ls_billto = lnv_company.of_GetName()
				else
					ls_billto = string(ll_billto)
				END IF
			end if
			if isvalid(lnv_company) then
				destroy lnv_company
			end if
		end if
		
		ls_orig = lnv_string.of_GetKeyValue(ls_taglist,'Originzone',',')
		ls_dest = lnv_string.of_GetKeyValue(ls_taglist,'Destinationzone',',')
		ls_changed = lnv_string.of_GetKeyValue(ls_taglist,'Changed',',')
		
		if len(trim(ls_billto)) > 0 then
			ls_message = 'BillTo = ' + ls_billto + "   ~n" 
		end if 
		if len(trim(ls_orig)) > 0 then
			ls_message += 'OriginZone = ' + ls_orig + "   ~n"
		end if
		if len(trim(ls_dest)) > 0 then
			ls_message += 'DestinationZone = '  + ls_Dest
		end if
		if len(trim(ls_message)) > 0 then
			ls_message = 'Rated using' + "~n~n" + ls_message
		end if
		
		this.object.formatedtaglist[row] = ls_message
		messagebox('Rated as - ' + ls_changed, ls_message)	// + " was changed"
		
	end if
	
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;is_setcolumn = dwo.name


end event

on u_dw_itemdetails.create
end on

on u_dw_itemdetails.destroy
end on

event getfocus;call super::getfocus;IF THIS.Getrow( ) > 0 THEN
	THIS.of_Setratingprotection( THIS.GetRow ( ) )
END IF
RETURN AncestorReturnValue
end event

event ue_showeventflagmenu;// Override with call to super
Int	li_Return

n_cst_bso_rating	lnv_rating
lnv_rating = create n_cst_bso_rating
if lnv_rating.of_haseditrights(this.object.di_item_type[al_Row]) then
	li_Return = Super::Event ue_ShowEventFlagMenu ( al_row )
END IF
DESTROY lnv_rating 
RETURN li_Return
end event

event itemchanged;call super::itemchanged;/*Modified By Dan 8-1-06
	Addressed a problem where when the setting for recalcfsc and autoaddfsc were both set to yes
	and changing the last item amount or ratetype(anything that would delete FSC rows) would cause the program to
	crash.  Basically it appeared as though moving the row into the delete buffer through
	the of_removeitem function on n_cst_beo_shipment wwould cause the program to crash
	at the end of executing this event.
	
	The only feasable fix I could find was inserting a row and discarding it with a post call
	as the last thing to do in this script.  Because of some undesired flickering I also added a new event
	ue_setredraw, which is implemented on w_ship.
*/
long		ll_return
long		li_deleteRow

Boolean	lb_ADDROW
Long		ll_scrollRow
lONG		LL_MAX
Long		ll_currentRow
String	ls_ratecodeName


n_cst_setting_recalcfuelsurcharge lnv_setting1
n_cst_setting_autoaddfuelsurcharge lnv_setting2
ll_return = AncestorReturnValue

lnv_setting1 = create n_cst_setting_recalcfuelsurcharge
lnv_setting2 = create n_cst_setting_autoaddfuelsurcharge

ll_max = this.rowCount()

//The only time we have to add and delete a row is when the following conditions hold true:
/*
		1. RecalcFuelSurcharge = yes
		2. AutoAddFuelSurcharge = yes
		3. Something has changed that caused FSC to become 0, and therefore deleted from the list. (Zeroing out the total surchargeable amount or changing rate type)
		4. The item that changed was the last one in the item list.
		5. The item changed was not a FSC item.

*/



if ll_return = 0 then
	ll_currentRow = this.getRow()
	ls_rateCodename = this.getItemString( ll_currentRow, "ratecodename")
	lb_addRow = lnv_setting1.of_getValue( ) = lnv_setting1.cs_yes AND lnv_setting2.of_getValue( ) = lnv_setting2.cs_yes &
					and ll_max < row and ls_rateCodeName <> "FSC"

	//only inserts the row if the conditions listed above are true
	IF lb_addROW THEN
		this.event ue_setredraw( false )
		this.insertrow( 1 )
		ll_scrollRow = ll_max 		//at the beginning of the script ll_max is one less then 'row' because at this point FSC has already been deleted. So ll_max is also equal to row - 1
	ELSE
		ll_scrollRow = this.getrow( )		//in any other situation this should be the same as 'row'. But just to be safe I set it to the current row.
	END IF

	this.post of_setcolumnfocus(row)		//does a scroll to row and a set column
	
	//only discards a row if one was added above.
	IF lb_addRow THEN
		this.post rowsdiscard( 1, 1, PRIMARY! )
		this.post  event ue_setredraw( true )
	END IF
END IF



DESTROY lnv_setting1
DESTROY lnv_setting2
return ll_return

/* old code
if ll_return = 0 then
	

	this.post of_setcolumnfocus(row)
	

END IF
*/
end event

