$PBExportHeader$w_autoratequery.srw
forward
global type w_autoratequery from w_sheet
end type
type dw_1 from u_dw within w_autoratequery
end type
type cb_rate from commandbutton within w_autoratequery
end type
type st_1 from statictext within w_autoratequery
end type
type cbx_base from checkbox within w_autoratequery
end type
type cb_apply from commandbutton within w_autoratequery
end type
type uo_destination from u_cst_ratinglocationzone within w_autoratequery
end type
type uo_origin from u_cst_ratinglocationzone within w_autoratequery
end type
type gb_1 from groupbox within w_autoratequery
end type
type gb_3 from groupbox within w_autoratequery
end type
type gb_2 from groupbox within w_autoratequery
end type
type uo_customer from u_cst_sle_company within w_autoratequery
end type
type cb_reset from commandbutton within w_autoratequery
end type
type uo_1 from u_ratetablequery within w_autoratequery
end type
type ddlb_1 from dropdownlistbox within w_autoratequery
end type
type rb_bill from radiobutton within w_autoratequery
end type
type rb_pay from radiobutton within w_autoratequery
end type
type st_2 from statictext within w_autoratequery
end type
end forward

global type w_autoratequery from w_sheet
integer x = 265
integer y = 160
integer width = 2889
integer height = 1888
string title = "Auto Rate Lookup"
string menuname = "m_sheets"
long backcolor = 12632256
dw_1 dw_1
cb_rate cb_rate
st_1 st_1
cbx_base cbx_base
cb_apply cb_apply
uo_destination uo_destination
uo_origin uo_origin
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
uo_customer uo_customer
cb_reset cb_reset
uo_1 uo_1
ddlb_1 ddlb_1
rb_bill rb_bill
rb_pay rb_pay
st_2 st_2
end type
global w_autoratequery w_autoratequery

type variables
long	il_CustomerID
long	il_itemid
n_cst_bso_rating		inv_rating
n_cst_bso_Dispatch	inv_Dispatch
n_cst_rateData		inv_RateData
n_cst_ratedata		inva_ratedata[]
integer			ii_selected
n_cst_beo_amountowed	inv_amountowed
boolean			ib_amountowed
n_cst_uilink_dw		inv_uilink
u_dw			idw_amountlist
u_dw			idw_amountdetail
long			il_row, &
			il_detailrow
integer			ii_category
end variables

forward prototypes
public subroutine wf_autorate ()
public function n_cst_ratedata wf_getratedataobject ()
end prototypes

public subroutine wf_autorate ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:wf_autorate
//  
//	Access		:public
//
//	Arguments	:none
//
//	Return		:none
//						
//	Description	:Create a ratedata object and set the properties with the
//					 values in the fields on the window. Send this ratedata object
//					 to the rating manager. If a rate was found then set the values
//					 on the window. Th object will be destroyed in the close event.
//
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

string	ls_origin, &
			ls_destination, &
			ls_errormessage
			
long		ll_billtoid, &
			ll_origin, &
			ll_destination, &
			ll_return = 0, &
			ll_errorcount

decimal	lc_rate

decimal{2}	lc_dec2
decimal{0}	lc_dec0

n_cst_OFRError	lnva_Errors[]

if dw_1.accepttext() <> 1 then
	ll_return = -1
end if

ll_billtoid = il_CustomerID

if isvalid(inv_ratedata) then
	destroy inv_Ratedata
end if
inv_RateData = THIS.wf_GetRateDataObject ( )

//validate company
if isnull(ll_billtoid) then
	//could be looking at base tables
	ll_billtoid = 0
end if

//validate origin
IF uo_origin.of_HasData ( ) = 0 AND ll_Return = 0 THEN
	//commented to allow zoneless table searches
//	MessageBox ( "Required" , "Please provide some origin information." ) 
//	ll_return = -1
END IF

//validate destination
IF uo_destination.of_HasData ( ) = 0 AND ll_Return = 0 THEN
	//commented to allow zoneless table searches
//	MessageBox ( "Required" , "Please provide some destination information." ) 
//	ll_return = -1
END IF


if ll_return = 0 then
	dw_1.object.minimum[1] = ""
	dw_1.object.maximum[1] = ""


	inva_ratedata[1] = inv_RateData
	inva_ratedata[1].of_setbilltoid(ll_billtoid)
	if rb_pay.checked then
		inva_ratedata[1].of_setCategory(n_cst_constants.ci_Category_Payables)
	else
		inva_ratedata[1].of_setCategory(n_cst_constants.ci_Category_Receivables)
	end if
	
	inva_ratedata[1].of_setTotalQuantity (dw_1.object.itemcount[1])
	inva_ratedata[1].of_settotalcount(dw_1.object.itemcount[1])
	inva_ratedata[1].of_settotalweight(dw_1.object.weight[1])
	inva_ratedata[1].of_settotalmiles(dw_1.object.miles[1])
	
	ll_origin = inva_ratedata[1].of_GetOriginID ( )
	if ll_origin > 0 then
		inv_rating.of_setorigin(ll_origin, inva_ratedata[1])
	end if
	ll_destination = inva_ratedata[1].of_GetDestinationID (  )
	if ll_destination > 0 then
		inv_rating.of_setdestination(ll_destination, inva_ratedata[1])
	end if

	choose case ii_selected
		case 1//'Freight Items'	
			inv_ratedata.of_SetItemEventType('')
		case 2//'Chassis Pickup/Return' 		//	cs_ItemEventType_BackChassisSplit = "CHASSIS RETURN"
			inv_ratedata.of_SetItemEventType(n_cst_constants.cs_ItemEventType_FrontChassisSplit)
		case 3//'Stopoff'
			inv_ratedata.of_SetItemEventType(n_cst_constants.cs_ItemEventType_StopOff) 	//"STOP OFF"

	end choose
	
	
	inva_ratedata[1].of_SetCodeName(uo_1.of_getcodename())
	if len(trim(uo_1.of_getcodename())) > 0 then
		inv_ratedata.of_SetItemType(uo_1.of_getItemType())
	else
		inv_ratedata.of_SetItemType(n_cst_constants.cs_itemtype_freight)
	end if
	
	inv_rating.ClearOFRErrors ( )
	inv_Rating.of_Initialize()
	inv_rating.of_autorate(inva_ratedata, true)
	
	SetPointer(HourGlass!)
	
	inv_rating.GetOFRErrors ( lnva_Errors )
	ll_errorcount = inv_rating.GetErrorCount()
	if ll_errorcount > 0 then
		if isvalid(lnva_Errors [ ll_errorcount ]) then
			ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )
		end if
		if Len ( ls_errormessage ) > 0 then
			//OK
		else
			ls_errormessage = "Unspecified error on rating."
		end if
	
		if len(ls_errormessage) > 0 then
			if ls_errormessage = "Cancelled" then
				//no messagebox
			else
				messagebox("Auto Rating", ls_errormessage)
			end if
		end if

		dw_1.object.RateUnit[1] = ''
		dw_1.object.rate[1] = 0
		dw_1.object.totalcharge[1] = 0

	else
		
		if inva_ratedata[1].of_useminimum() then
			dw_1.object.minimum[1] = "y"
		end if
		if inva_ratedata[1].of_usemaximum() then
			dw_1.object.maximum[1] = "y"
		end if
		
		dw_1.object.RateUnit[1] = inva_RateData[1].of_GetRateType ( )	
		dw_1.object.Ratecode[1] = inva_ratedata[1].of_GetCodeName()
		dw_1.object.origzone[1] = inva_ratedata[1].of_GetOriginZone()
		dw_1.object.destzone[1] = inva_ratedata[1].of_GetDestinationZone()
		if inva_ratedata[1].of_UsedBilltoOverride() then
			dw_1.object.billtooverride[1] = 'Billto Override'
		else
			dw_1.object.billtooverride[1] = 'Base Rate'
		end if
		
		lc_rate = inva_ratedata[1].of_getrate(false/*don't set lastuseddate*/)
		if lc_rate > 0 then
			dw_1.object.rate[1] = lc_rate
			dw_1.object.totalcharge[1] = inva_ratedata[1].of_gettotalcharge()
		else
			dw_1.object.rate[1] = 0
			dw_1.object.totalcharge[1] = 0
		end if

	end if

end if



end subroutine

public function n_cst_ratedata wf_getratedataobject ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:wf_GetRateDataObject
//  
//	Access		:public
//
//	Arguments	:none
//
//	Return		:n_cst_ratedata
//						
//	Description	:Create the ratadata object and set the origin and destination 
//					 properties with the values on the window.
//
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

n_cst_RateData 	lnv_RateData
lnv_RateData = CREATE n_cst_RateData

lnv_RateData.of_SetOriginState ( uo_origin.of_GetState ( ) )
lnv_RateData.of_SetOriginZip ( uo_origin.of_GetZip ( ) )
lnv_RateData.of_SetOriginID ( uo_origin.of_GetSiteID ( ) )
lnv_RateData.of_SetOriginZone ( uo_origin.of_GetZone ( ) )

lnv_RateData.of_SetDestinationState ( uo_destination.of_GetState ( ) )
lnv_RateData.of_SetDestinationZip ( uo_destination.of_GetZip ( ) )
lnv_RateData.of_SetDestinationID ( uo_destination.of_GetSiteID ( ) )
lnv_RateData.of_SetDestinationZone ( uo_destination.of_GetZone ( ) )


RETURN lnv_RateData
end function

on w_autoratequery.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_1=create dw_1
this.cb_rate=create cb_rate
this.st_1=create st_1
this.cbx_base=create cbx_base
this.cb_apply=create cb_apply
this.uo_destination=create uo_destination
this.uo_origin=create uo_origin
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.uo_customer=create uo_customer
this.cb_reset=create cb_reset
this.uo_1=create uo_1
this.ddlb_1=create ddlb_1
this.rb_bill=create rb_bill
this.rb_pay=create rb_pay
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_rate
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cbx_base
this.Control[iCurrent+5]=this.cb_apply
this.Control[iCurrent+6]=this.uo_destination
this.Control[iCurrent+7]=this.uo_origin
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.uo_customer
this.Control[iCurrent+12]=this.cb_reset
this.Control[iCurrent+13]=this.uo_1
this.Control[iCurrent+14]=this.ddlb_1
this.Control[iCurrent+15]=this.rb_bill
this.Control[iCurrent+16]=this.rb_pay
this.Control[iCurrent+17]=this.st_2
end on

on w_autoratequery.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.cb_rate)
destroy(this.st_1)
destroy(this.cbx_base)
destroy(this.cb_apply)
destroy(this.uo_destination)
destroy(this.uo_origin)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.uo_customer)
destroy(this.cb_reset)
destroy(this.uo_1)
destroy(this.ddlb_1)
destroy(this.rb_bill)
destroy(this.rb_pay)
destroy(this.st_2)
end on

event open;call super::open;integer	li_MsgCount, &
			li_Ndx
		
decimal	lc_qty
long		ll_wt, &
			ll_mi
string	ls_ratecode

n_cst_msg	lnv_msg
s_parm	lstr_parm
n_ds		lds_itemcache
n_cst_beo_item	lnv_item
n_cst_privsmanager	lnv_manager

//added the next two conditions on 2-2-06 by dan
IF isValid( message.powerObjectParm ) THEN
	IF message.powerObjectParm.classname() = "n_cst_msg" THEN
		lnv_Msg = message.powerobjectparm
	END IF
END IF
///////////////////////////////////////////
if isvalid(lnv_Msg) then
	li_MsgCount = 	lnv_msg.of_get_count()
	FOR li_Ndx = 1 to li_MsgCount
		lnv_msg.of_get_parm(li_ndx, lstr_parm)
		
		CHOOSE CASE upper(lstr_parm.is_label)
					
			CASE "DISPATCH"
				if isvalid(lstr_Parm.ia_Value) then
					inv_dispatch = lstr_Parm.ia_Value 
				end if
			CASE "ITEMID"
				il_itemid = lstr_Parm.ia_Value 
				
			CASE "AMOUNTOWED"
				inv_amountowed = lstr_Parm.ia_Value
				ib_amountowed = true
				
			CASE "AMOUNTLIST"
				idw_amountlist = lstr_parm.ia_value
				il_row = idw_amountlist.getrow()	
				
			CASE "QUANTITY"
				lc_qty = lstr_Parm.ia_Value

			CASE "AMOUNTDETAIL"
				idw_amountdetail = lstr_Parm.ia_Value
				il_detailrow = idw_amountdetail.getrow()
				
			case "CATEGORY"
				ii_category = lstr_parm.ia_value
				if ii_category = n_cst_constants.ci_Category_Payables then
					rb_pay.checked= true
				else
					rb_bill.checked=false				
				end if
				
		END CHOOSE
	NEXT
end if

if il_itemid > 0 or ib_amountowed then
	cb_apply.visible=true
else
	cb_rate.x=2117
	cb_reset.x=2478
	cb_apply.visible=false
end if

this.height=1888
this.width=2889

//authorization checked in menu script
ib_disableclosequery = true
dw_1.insertrow(0)

if ib_amountowed then
	if isvalid(inv_amountowed) then
		lc_qty =inv_amountowed.of_getquantity()
		ls_ratecode = inv_amountowed.of_getratecodename()
	end if
else
	if isvalid(inv_Dispatch) then
		lds_itemcache = inv_Dispatch.of_GetItemCache ( )
		
		if isvalid(lds_itemcache) then
			lnv_item = CREATE n_cst_Beo_Item
			
			lnv_item.of_SetSource ( lds_itemcache )
			lnv_item.of_SetSourceId (il_itemid)			
			
			IF lnv_item.of_HasSource ( ) THEN
				
				lc_qty = lnv_item.of_getquantity()
				ll_wt = lnv_item.of_gettotalweight()
				ll_mi = lnv_item.of_getmiles()
				ls_ratecode = lnv_item.of_getratecodename()
				
			end if
			
			destroy lnv_item
			
		end if
	end if
end if

if isnull(lc_qty) then
	dw_1.object.itemcount[1] = 0
else
	dw_1.object.itemcount[1] = lc_qty
end if

if isnull(ll_wt) then
	dw_1.object.weight[1] = 0
else
	dw_1.object.weight[1] = ll_wt
end if
if isnull(ll_mi) then
	dw_1.object.miles[1] = 0
else
	dw_1.object.miles[1] = ll_mi
end if

if len(trim(ls_ratecode)) > 0 then
	uo_1.post of_setcodename(ls_ratecode)
end if

inv_rating = create n_cst_bso_rating
gf_Mask_Menu ( m_sheets )
cbx_base.triggerevent(clicked!)
uo_origin.dw_1.setfocus()

//ADDED BY DAN 1-30-07
lnv_manager = gnv_app.of_getPRivsmanager( )
IF lnv_manager.of_getuserpermissionfromfn( "View Charges") <> 1 THEN
	Messagebox("Auto Rate Lookup", "You do not have permission to view this window.")
	post close(this)
END IF
end event

event close;call super::close;long	ll_ndx, &
		ll_count
		
if isvalid(inv_Rating) then
	destroy inv_Rating
end if

if isvalid(inv_ratedata) then
	destroy inv_ratedata
end if

ll_count = upperbound(inva_Ratedata)
for ll_ndx = 1 to ll_count
	if isvalid(inva_ratedata[ll_ndx]) then
		destroy inva_ratedata[ll_ndx]
	end if
next

end event

type dw_1 from u_dw within w_autoratequery
integer x = 59
integer y = 988
integer width = 2729
integer height = 536
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_autoratelookup"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;n_cst_presentation_RateTable 	lnv_Presentation 
lnv_Presentation.of_SetPresentation ( THIS )
THIS.SetTransObject ( SQLCA )
ib_Rmbmenu = FALSE
end event

event itemerror;call super::itemerror;choose case dwo.name
		
	case "itemcount"
		this.object.itemcount[row] = 0
		return 1
		
end choose

end event

event itemchanged;call super::itemchanged;choose case dwo.name
		
	case "itemcount"
		if isnull(data) or len(trim(data)) = 0 then
			this.object.itemcount[row] = 0
		end if
		this.object.rateunit[row] = ''
		this.object.rate[row] = 0
		this.object.totalcharge[row] = 0
end choose

end event

event getfocus;call super::getfocus;long	ll_length, &
		ll_row

decimal	lc_item

ll_row = this.getrow()

if ll_row > 0 then
	lc_item = this.object.itemcount[ll_row]
	ll_length = len(string(lc_item))
	This.Post selecttext(1, ll_length)	
end if


end event

type cb_rate from commandbutton within w_autoratequery
integer x = 1755
integer y = 1580
integer width = 343
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Rate"
end type

event clicked;SetPointer(HourGlass!)
parent.wf_autorate()

end event

type st_1 from statictext within w_autoratequery
integer x = 1769
integer y = 172
integer width = 311
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "C&ustomer"
boolean focusrectangle = false
end type

event getfocus;uo_customer.Event ue_SetFocus ( ) 
end event

type cbx_base from checkbox within w_autoratequery
integer x = 2400
integer y = 172
integer width = 379
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Base Table"
boolean checked = true
boolean lefttext = true
end type

event clicked;IF THIS.Checked THEN
	uo_customer.of_SetText ( "[BASE]" )
	uo_customer.of_Enable ( FALSE )
	il_customerid = 0
ELSE
	uo_customer.of_SetText ( "" )
	uo_customer.of_Enable ( TRUE )
	uo_customer.Event ue_SetFocus ( )
	SetNull ( il_customerid )
END IF

//PARENT.Event ue_ItemChanged ( )
end event

event getfocus;//PARENT.Event ue_GotFocus ( ) 
end event

type cb_apply from commandbutton within w_autoratequery
integer x = 2478
integer y = 1580
integer width = 338
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Apply"
end type

event clicked;long	ll_foundrow, &
		ll_itemcount, &
		ll_index, &
		ll_owedcount, &
		ll_billtoid, &
		ll_amounttype
		
string	ls_taglist

n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment
			
n_ds	lds_itemcache
n_cst_beo_item	lnv_item
n_cst_LicenseManager	lnv_LicenseManager

if upperbound(inva_ratedata) > 0 then
	if inva_ratedata[1].of_GetTotalCharge() > 0 then
		if lnv_LicenseManager.of_HasAutoRatingLicensed ( ) then
			n_cst_bso_rating	lnv_rating
			lnv_rating = create n_cst_bso_rating
			if ib_amountowed then
				if isvalid(inv_amountowed) then
					if isvalid(inva_ratedata[1]) then
						inv_amountowed.of_applyautorate(inva_ratedata[1])	
						if isvalid(idw_amountdetail) then
							idw_amountdetail.inv_UILink.UpdateRequestor ( il_detailrow )
							idw_amountdetail.triggerevent('ue_transactionmodified')
							idw_amountdetail.setcolumn('amountowed_amount')
							
						end if
						if isvalid(idw_amountlist) then
							idw_amountlist.inv_UILink.UpdateRequestor ( il_row )
						end if
					end if
				end if		
			else
				if il_itemid > 0 then
					if isvalid(inv_Dispatch) then
						if isvalid(inva_ratedata[1]) then
			
							lds_itemcache = inv_Dispatch.of_GetItemCache ( )
							
							if isvalid(lds_itemcache) then
								lnv_item = CREATE n_cst_Beo_Item
								
								lnv_item.of_SetSource ( lds_itemcache )
								lnv_item.of_SetSourceId (il_itemid)			
								
								IF lnv_item.of_HasSource ( ) THEN
									
									lnv_Shipment.of_SetSource  ( inv_Dispatch.of_GetShipmentCache ( ) )
									lnv_Shipment.of_SetSourceID ( lnv_item.of_GetShipment ( ) ) 
									lnv_Shipment.of_SetItemSource ( lds_itemcache )
									lnv_Shipment.of_SetContext ( inv_Dispatch )
									lnv_item.of_SetShipment ( lnv_Shipment )
															
									if lnv_rating.of_haseditrights(lnv_item.of_gettype()) then	
										//set new values
										lnv_item.of_setquantity(inva_ratedata[1].of_gettotalquantity())
										lnv_item.of_settotalweight(inva_ratedata[1].of_gettotalweight())
										lnv_item.of_setmiles(inva_ratedata[1].of_gettotalmiles())
										
										if lnv_item.of_applyautorate(inva_ratedata) > 0 then		
											ls_taglist = 'Changed=Ratecode,' 
											if isnull(inva_ratedata[1].of_getbilltoid()) then
												//skip
											else
												ls_taglist += 'BillTo=' + string(inva_ratedata[1].of_getbilltoid()) + "," 
											end if
											
											ls_taglist += 'Originzone=' + inva_ratedata[1].of_getOriginZone() + "," + &
																'Destinationzone=' + inva_ratedata[1].of_getDestinationZone()
						
											lnv_item.of_settaglist(ls_taglist)
											
										end if
				
									else
										messagebox('Auto Rate',  "Your current user privileges do not allow you to " +&
										"perform this operation.", exclamation!)	
									end if
								END IF
								destroy lnv_item
							end if
						end if
					end if
				end if
			end if
			close(parent)
			destroy lnv_rating
		end if			
	end if
end if

DESTROY ( lnv_Shipment )

end event

type uo_destination from u_cst_ratinglocationzone within w_autoratequery
integer x = 55
integer y = 720
integer taborder = 50
boolean bringtotop = true
end type

on uo_destination.destroy
call u_cst_ratinglocationzone::destroy
end on

type uo_origin from u_cst_ratinglocationzone within w_autoratequery
integer x = 55
integer y = 436
integer width = 2738
integer height = 184
integer taborder = 40
boolean bringtotop = true
end type

on uo_origin.destroy
call u_cst_ratinglocationzone::destroy
end on

event constructor;call super::constructor;this.dw_1.dataobject="d_ratelinkorigzone"
this.dw_1.SetTransObject(SQLCA)
end event

type gb_1 from groupbox within w_autoratequery
integer x = 27
integer y = 936
integer width = 2789
integer height = 600
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_autoratequery
integer x = 27
integer y = 384
integer width = 2789
integer height = 272
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_autoratequery
integer x = 27
integer y = 660
integer width = 2789
integer height = 272
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type uo_customer from u_cst_sle_company within w_autoratequery
event destroy ( )
integer x = 1765
integer y = 244
integer width = 1015
integer height = 100
boolean bringtotop = true
long backcolor = 12632256
end type

on uo_customer.destroy
call u_cst_sle_company::destroy
end on

event ue_companychanged;IF al_companyid > 0 THEN
	il_CustomerID = al_companyid
	uo_origin.event post ue_setfocus("ZONE")
	uo_origin.post setfocus()
ELSE
	SetNull ( il_CustomerID )
END IF

RETURN 1


end event

event constructor;call super::constructor;this.sle_1.width=1015
//this.sle_1.height=72

end event

type cb_reset from commandbutton within w_autoratequery
integer x = 2117
integer y = 1580
integer width = 343
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Re&set"
end type

event clicked;uo_customer.of_settext('')
cbx_base.checked=true
cbx_base.triggerevent(clicked!)
uo_origin.of_initialize()
uo_destination.of_initialize()
dw_1.Reset()
dw_1.Insertrow(0)
uo_origin.dw_1.setfocus()
end event

type uo_1 from u_ratetablequery within w_autoratequery
integer x = 32
integer y = 144
integer width = 1719
integer height = 224
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call u_ratetablequery::destroy
end on

type ddlb_1 from dropdownlistbox within w_autoratequery
integer x = 69
integer y = 24
integer width = 1408
integer height = 472
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Freight Items","Chassis Pickup/Return","Stopoff"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.SelectItem ( 'Freight', 1 )
end event

event selectionchanged;ii_selected = index
end event

type rb_bill from radiobutton within w_autoratequery
integer x = 2057
integer y = 32
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12632256
string text = "Bil&l"
boolean checked = true
end type

type rb_pay from radiobutton within w_autoratequery
integer x = 2336
integer y = 32
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "&Pay"
end type

type st_2 from statictext within w_autoratequery
integer x = 1769
integer y = 36
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Category"
boolean focusrectangle = false
end type

