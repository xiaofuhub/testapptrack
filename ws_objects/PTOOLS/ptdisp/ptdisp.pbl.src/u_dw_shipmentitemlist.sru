$PBExportHeader$u_dw_shipmentitemlist.sru
forward
global type u_dw_shipmentitemlist from u_dw
end type
end forward

global type u_dw_shipmentitemlist from u_dw
integer width = 3067
integer height = 528
string dataobject = "d_intermodalitems"
boolean hscrollbar = true
event type integer ue_showdetails ( long al_row )
event type integer ue_ratelookup ( boolean ab_createnew )
event type n_cst_beo_shipment ue_getshipment ( )
event type n_cst_bso_dispatch ue_getdispatch ( )
event type long ue_additem ( string as_type )
event type integer ue_sethazmat ( boolean ab_value )
event type integer ue_showeventflagmenu ( long al_row )
event ue_showitemmenu ( long al_row )
event ue_deleteitem ( long al_row )
end type
global u_dw_shipmentitemlist u_dw_shipmentitemlist

type variables
String	is_Context
n_ds	ids_amounttype
String	is_SetColumn

Private:
Boolean	ib_NeedHighlight
end variables

forward prototypes
public function integer of_getselectedids (ref long ala_ids[])
public function integer of_selectrow (long al_row, boolean ab_highlight)
public function long of_getrow ()
public function long of_getselectedrows (ref long ala_Rows[])
public function int of_getitemcount ()
public function integer of_getfreightcount ()
public function integer of_setdisplayrestrictions ()
public function integer of_initializerestrictions ()
public function long of_getamountcache (ref n_ds ads_cache)
public subroutine of_scrollright ()
public subroutine of_scrollleft ()
end prototypes

event type integer ue_showeventflagmenu(long al_row);integer	li_Parmcount
string 	lsa_parm_labels[]
any 		laa_parm_values[]
String	ls_PopResult

int		li_result
String	ls_recalc
Constant string	lcs_resultNo = "No"

n_cst_beo_Item			lnv_Item
n_cst_beo_shipment	lnv_shipment
n_cst_setting_recalcFuelSurcharge lnv_recalcFsc
n_cst_ShipmentManager	lnv_ShipmentManager

Dec	lc_fscRate
Dec	lc_rate

lnv_recalcFsc = CREATE n_cst_setting_recalcFuelSurcharge

lnv_Item = CREATE n_cst_beo_item 


lnv_Item.of_SetSource ( THIS ) 
lnv_Item.of_SetSourceRow  ( al_Row )
lc_fscRate = lnv_item.of_getfscrate( )			//added by dan


lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_ShipmentManager.of_GetFuelSurcharge ( lc_rate , lnv_Shipment )		//added by dan


li_Parmcount ++
lsa_parm_labels[li_Parmcount] = "ADD_ITEM"
laa_parm_values[li_Parmcount] = "Rate as Stop off"

li_Parmcount ++
lsa_parm_labels[li_Parmcount] = "ADD_ITEM"
laa_parm_values[li_Parmcount] = "Rate as Chassis Pickup"
	
li_Parmcount ++
lsa_parm_labels[li_Parmcount] = "ADD_ITEM"
laa_parm_values[li_Parmcount] = "Rate as Chassis Return"
	

if isvalid(lnv_shipment) then
	lnv_Item.of_SetShipment ( lnv_Shipment )
	IF lnv_Item.of_GetType ( ) = "A" THEN
		IF NOT lnv_Shipment.of_HasFuelSurcharge ( ) OR & 
			lnv_Item.of_GetEventTypeFlag () = n_cst_Constants.cs_ItemEventType_FuelSurcharge  THEN

			li_Parmcount ++
			lsa_parm_labels[li_Parmcount] = "ADD_ITEM"
			laa_parm_values[li_Parmcount] = "Rate as Fuel Surcharge"
		END IF
	END IF
end if

ls_PopResult = f_pop_standard(lsa_parm_labels, laa_parm_values)

CHOOSE CASE ls_PopResult 
		
	CASE "RATE AS STOP OFF"
			lnv_Item.of_SetEventTypeFlag (n_cst_Constants.cs_ItemEventType_StopOff)
		
	CASE "RATE AS CHASSIS PICKUP"
			lnv_Item.of_SetEventTypeFlag (n_cst_Constants.cs_ItemEventType_FrontChassisSplit)
			
	CASE "RATE AS CHASSIS RETURN"
			lnv_Item.of_SetEventTypeFlag (n_cst_Constants.cs_ItemEventType_BackChassisSplit )
					
	CASE "RATE AS FUEL SURCHARGE"
		//added by Dan 12-28-2005 to make it so that a forced surcharge change warns them.
		ls_recalc =lnv_recalcFsc.Of_getvalue( )
		
		IF Upper ( ls_recalc ) = "YES" THEN
			lnv_Item.of_Makefuelsurcharge( )
		ELSE 
			IF not IsNull( lc_fscRate ) THEN
				IF lc_fscRate <> lc_rate THEN
					li_result = MessageBox( "Add Fuel Surcharge","The FSC rate used in the existing calculation is different than the rate being used in the pending change.Do you want to change the fsc rate?", QUESTION!,YESNO! )
				ELSE
					li_result = 1
				END IF
			ELSE
				li_result = 1
			END IF
			
			IF li_result = 1 THEN	
				lnv_Item.of_MakeFuelSurcharge ( )
			ELSE
				lnv_item.of_Makefuelsurcharge( TRUE )
			END IF
		
		END IF
		
		
		
		
		/*
		IF lnv_shipment.of_hasnewfuelsurcharge( )  THEN
			lnv_Item.of_MakeFuelSurcharge ( )	
		
		ELSEIF lnv_Shipment.of_HasFuelSurcharge ( ) AND ls_recalc = lcs_resultno THEN	
			
			
			
			IF not IsNull( lc_fscRate ) THEN
				IF lc_fscRate <> lc_rate THEN
					li_result = MessageBox( "Add Fuel Surcharge","The FSC rate used in the existing calculation is different than the rate being used in the pending change.Do you want to change the fsc rate?", QUESTION!,YESNO! )
				ELSE
					li_result = 1
				END IF
			ELSE
				li_result = 1
			END IF
//			li_result = MEssageBox("Add Fuel Surcharge","A fuel surcharge already exists for this shipment.  The rate may have changed since last update, calculate anyways?~r~nnote: answering yes will make the fuel surcharge recalculate until the next save. The row will be green to signify this.", QUESTION!,YESNO!)
			IF li_result = 1 THEN	
				lnv_Item.of_MakeFuelSurcharge ( )
			ELSE
				lnv_item.of_Makefuelsurcharge( TRUE )
			END IF
		END IF	
		
		*/
		
		//
END CHOOSE	
	
DESTROY ( lnv_Item ) 
DESTROY ( lnv_recalcFsc )	
RETURN 1
end event

event ue_showitemmenu(long al_row);String	lsa_labels[]
Any		laa_Values[]

lsa_labels[1] = "ADD_ITEM"
laa_Values[1] = "Delete Item"



lsa_labels[2] = "ADD_ITEM"
laa_Values[2] = "Add &Alert"



CHOOSE CASE f_Pop_Standard ( lsa_Labels, laa_Values )
		
	CASE "DELETE ITEM"
		THIS.Event ue_DeleteItem ( al_Row )
	CASE "ADD ALERT"
		n_cst_beo_item	lnv_Item
		lnv_Item = CREATE n_cst_beo_Item
		lnv_Item.of_SetSource ( THIS ) 
		lnv_Item.of_SetSourceID ( this.getitemNumber ( al_row , "di_item_id" ) )
		lnv_Item.of_Adduseralert( )
		DESTROY ( lnv_Item )
END CHOOSE


end event

public function integer of_getselectedids (ref long ala_ids[]);Long	ll_Count
Long	lla_Rows[]
Long	lla_Ids[]
Long	ll_i

ll_Count = THIS.of_GetSelectedRows ( lla_Rows )


For ll_i = 1 TO ll_Count
	lla_Ids [ ll_i ] = THIS.GetItemNumber ( lla_Rows [ ll_i ] , "di_item_id" )
NEXT

ala_ids[] = lla_Ids

RETURN UpperBound ( ala_ids[] )

end function

public function integer of_selectrow (long al_row, boolean ab_highlight);THIS.ScrollToRow ( al_Row )
THIS.SelectRow ( al_Row , ab_highlight ) 
RETURN 1
end function

public function long of_getrow ();RETURN THIS.GetRow ( )
end function

public function long of_getselectedrows (ref long ala_Rows[]);Long	ll_Selected = 0
long	ll_Counter = 0
Long	lla_SelectedRows[]

//Loop and count the number of selected rows.
DO
	ll_selected = THIS.GetSelectedRow ( ll_selected )
	IF ll_selected > 0 THEN
		ll_counter++
		lla_SelectedRows[ll_counter] = ll_selected
	END IF
LOOP WHILE ll_selected > 0

ala_Rows[] = lla_SelectedRows

RETURN UpperBound ( ala_Rows )
end function

public function int of_getitemcount ();RETURN THIS.RowCount ( ) 
end function

public function integer of_getfreightcount ();//Int	li_Count
//Int	li_i
//Int	li_RowCount
//
//li_RowCount = THIS.of_GetItemCount ( ) 
//
//FOR li_i = 1 TO li_RowCount
//	IF THIS.GetItemString ( "di_item_type" 
//	
//	
//	
//NEXT

RETURN -1 
end function

public function integer of_setdisplayrestrictions ();CONSTANT String	ls_Restrict = "txt_restrict_ind.text = 'T'"
CONSTANT String	ls_NonRestrict = "txt_restrict_ind.text = 'F'"
String	ls_Context

n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.Event ue_GetShipment ( ) 
  
IF isValid ( lnv_Shipment ) THEN

	IF lnv_Shipment.of_AllowItemEdit ( ) THEN
		THIS.Modify ( ls_NonRestrict )
	ELSE 	
		//THIS.Object.txt_restrict_ind.text = 'T'
		THIS.Modify ( ls_Restrict )		
	END IF
ELSE

END IF
//messageBox( "A" , "Set2" )

RETURN 1
end function

public function integer of_initializerestrictions ();
Long		ll_ColumnCount	
Long		ll_i
String	ls_ColumnName
String	ls_ModifyRtn

ll_ColumnCount = Long ( THIS.Object.DataWindow.Column.Count )

FOR ll_i = 1 TO ll_ColumnCount
	ls_ColumnName = String (  THIS.Describe("#"+ String (ll_i)+ ".Name") )
	
	CHOOSE CASE ls_ColumnName 
		CASE "di_qty" , "di_pay_ratetype" , "di_pay_rate" , "di_pay_itemamt" , "di_our_ratetype" , "di_our_rate" , "di_our_itemamt" 
			CONTINUE
	END CHOOSE
	ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".protect=~"0~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 1, 0 )~"" )
	//ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".background.color=~"16777215~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 12648447, 16777215 )~"" )	
		
NEXT

// computed fields are not accounted for in get column count
THIS.Modify( "comp_pu.protect=~"0~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 1, 0 )~"" )
//THIS.Modify( "comp_pu.background.color=~"16777215~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 12648447, 16777215 )~"" )	

THIS.Modify( "comp_del.protect=~"0~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 1, 0 )~"" )
//THIS.Modify( "comp_del.background.color=~"16777215~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 12648447, 16777215 )~"" )	

THIS.SetRedraw ( TRUE ) 

RETURN 1
end function

public function long of_getamountcache (ref n_ds ads_cache);long	ll_rowcount

if isvalid(ids_amounttype) then
	ads_cache=ids_amounttype
else
	ids_amounttype = create n_ds
	ids_amounttype.dataobject="d_dlkc_amounttype"
	ids_amounttype.SetTransobject(sqlca)
	ll_rowcount =  ids_amounttype.retrieve()
	if ll_rowcount > 0 then
		ads_cache = ids_amounttype
	end if
end if

return ll_rowcount
	
end function

public subroutine of_scrollright ();IF THIS.RowCount() <> 0 THEN 
	Send(Handle(THIS), 276, 3, 0) 
END IF

end subroutine

public subroutine of_scrollleft ();IF THIS.RowCount() <> 0 THEN 
	Send(Handle(THIS), 276, 2, 0) 
END IF

end subroutine

event constructor;Long	ll_columnCount
Long	ll_i
String	ls_columnName
String 	ls_modifyrtn
n_cst_setting_recalcfuelsurcharge lnv_recalc
lnv_recalc = create n_cst_setting_recalcfuelsurcharge


ib_Rmbfocuschange = FALSE
ib_rmbMenu = FALSE
n_cst_Dws	lnv_Dws
String	ls_CodeTable
//lnv_Dws.of_CreateHighlight ( This )
ib_needhighlight = TRUE 

is_Context = "TL"
THIS.Post of_InitializeRestrictions ( )


ls_CodeTable = &
	"BILLABLE~t" + n_cst_constants.cs_accountingtype_billable + "/"+&
	"PAYABLE~t" + n_cst_constants.cs_accountingtype_payable + "/"+&
	"BOTH~t" + n_cst_constants.cs_accountingtype_both + "/"
	
	
This.Modify ( "accountingtype.Edit.CodeTable = Yes	accountingtype.Values = '" +  ls_CodeTable+ "' accountingtype.ddlb.allowedit=yes accountingtype.ddlb.UseAsBorder=no accountingtype.ddlb.case=upper accountingtype.ddlb.required=yes accountingtype.ddlb.autohscroll=yes accountingtype.ddlb.vscrollbar=yes " )             


//added by dan to change the color of the surcharge row if the setting for recalculating the
//surcharge is off.  If the surcharge row is modified, then it is green, otherwise it is black.
//IF lnv_recalc.of_getValue( ) = "No" THEN
//	ll_ColumnCount = Long ( THIS.Object.DataWindow.Column.Count )
//	//start at 3 because the first two rows of the data object are not text.
//	FOR ll_i = 3 TO ll_ColumnCount
//		ls_ColumnName = String (  THIS.Describe("#"+ String (ll_i)+ ".Name") )	
//		ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".color=~"0~tif (eventflag = 'FUEL SURCHARGE' AND isRowModified(), RGB( 34,139,34), 0 )~"" )	
//	NEXT
//END IF		
// DESTROY lnv_recalc
 //--------------------------------------------------------------

end event

event doubleclicked;THIS.Event ue_ShowDetails ( row )


end event

event rowfocuschanged;call super::rowfocuschanged;//if currentrow > 0 then
//	if dw_item_details.visible then dw_item_details.setredraw(false)
//	dw_item_details.setcolumn("di_item_type")
//	dw_item_details.scrolltorow(currentrow)
//	dw_item_details.setcolumn("di_qty")
//	if dw_item_details.visible then dw_item_details.setredraw(true)
//	if dw_item_details.visible then dw_item_details.setfocus()
//end if
//
//
This.Post SetRedraw ( TRUE )  //To force redraw of highlight
end event

event rowfocuschanging;call super::rowfocuschanging;This.SetRedraw ( FALSE )  //Needed for proper redraw of highlight
end event

event scrollvertical;parent.postevent("reset_range", 1, 0)
end event

event itemchanged;call super::itemchanged;this.setredraw(false)

long	ll_Pos, &
		ll_return = 0, &
		ll_rowcount, &
		ll_found
		
Long	ll_ItemCount

decimal	lc_rate, &
			lc_percent
string 	changed_col, &
			ls_payratetype, &
			ls_taglist, &
			ls_changed, &
			ls_newvalue, &
			ls_ratecode			

integer checkloop, hashaz
integer currow, oldval_index
boolean lb_rate


currow = this.getrow()
changed_col = dwo.name



//n_ds	lds_amounttype
n_cst_string			lnv_string
n_cst_beo_SHipment	lnv_SHipment
n_cst_beo_item		lnv_setitem
n_cst_ratedata		lnva_Ratedata[]
n_cst_AnyArraysrv	lnv_ArraySrv

lnv_Shipment = THIS.Event ue_GetShipment ( ) 

ll_ItemCount = THIS.RowCount ( ) 

lnv_SetItem = CREATE n_cst_beo_Item
lnv_SetItem.of_SetSource ( this )
lnv_SetItem.of_SetSourceRow ( row )
lnv_SetItem.of_SetShipment ( lnv_Shipment )

ls_taglist=lnv_SetItem.of_gettaglist()
if len(trim(ls_taglist)) > 0 then
	ls_taglist += ','
end if

//is_Setcolumn = THIS.GetColumnName ( )

IF lnv_Shipment.of_AllowEditBill ( ) THEN
	

	n_cst_LicenseManager	lnv_LicenseManager
	if lnv_LicenseManager.of_HasAutoRatingLicensed ( ) then
		//ok
		lb_rate = true
	else
		//no license, no rating - no message will be displayed
		lb_rate = false
	end if

	choose case changed_col
	
		CASE "amounttype" 
			lnv_SetItem.of_setAmountType ( Integer ( data ) )
	
		case "di_hazmat"
			if this.getitemstring(currow, "di_hazmat") = "F" then
				THIS.Event ue_SetHazmat ( TRUE )
			else
				
				for checkloop = 1 to ll_ItemCount
					if this.getitemstring(checkloop, "di_hazmat") = "T" and checkloop <> currow then
						hashaz = 1
						exit
					end if
				next
				if hashaz = 1 then
					THIS.Event ue_SetHazmat ( TRUE )
				else
					THIS.Event ue_SetHazmat ( FALSE )
				end if
			end if
	
		case "di_qty"
			IF isNull ( Data ) THEN
				Data = "0"
			END IF
			lnv_SetItem.of_SetQuantity ( dec(data) )
			if lb_rate then
				ls_ratecode = this.Getitemstring(row, 'ratecodename')
				if len(trim(ls_ratecode)) > 0 then
					if upper(ls_ratecode) = "CUSTOM" then
						//don't autorate
					else
						if	lnv_SetItem.of_autorate(lnva_Ratedata) < 0 then
							this.setitem(row, 'ratecodename','')
						else
							lnv_SetItem.of_applyautorate(lnva_Ratedata)
						end if
						lnv_ArraySrv.of_Destroy ( lnva_RateData )
					end if
				end if
			end if
			
			if lnv_SetItem.of_getEventTypeFlag ( ) = n_Cst_Constants.cs_ItemEventType_FuelSurcharge then
				lnv_SetItem.of_MakeFuelSurcharge()
			end if
			
		case "di_weightperunit"
			IF isNull ( Data ) THEN
				Data = "0"
			END IF
			lnv_SetItem.of_SetWeightPerUnit ( dec(data) )
			if lb_rate then
				ls_ratecode = this.Getitemstring(row, 'ratecodename')
				if len(trim(ls_ratecode)) > 0 then
					if upper(ls_ratecode) = "CUSTOM" then
						//don't autorate
					else
						if	lnv_SetItem.of_autorate(lnva_Ratedata) < 0 then
							this.setitem(row, 'ratecodename','')
						else
							lnv_SetItem.of_applyautorate(lnva_Ratedata)
						end if
						lnv_ArraySrv.of_Destroy ( lnva_RateData )
					end if
				end if
			end if
			if lnv_SetItem.of_getEventTypeFlag ( ) = n_Cst_Constants.cs_ItemEventType_FuelSurcharge then
				lnv_SetItem.of_MakeFuelSurcharge()
			end if
			
		case "di_totitemweight"
			IF isNull ( Data ) THEN
				Data = "0"
			END IF
			lnv_SetItem.of_SettotalWeight ( dec(data) )
			if lb_rate then
				ls_ratecode = this.Getitemstring(row, 'ratecodename')
				if len(trim(ls_ratecode)) > 0 then
					if upper(ls_ratecode) = "CUSTOM" then
						//don't autorate
					else
						if	lnv_SetItem.of_autorate(lnva_Ratedata) < 0 then
							this.setitem(row, 'ratecodename','')
						else
							lnv_SetItem.of_applyautorate(lnva_Ratedata)
						end if
						lnv_ArraySrv.of_Destroy ( lnva_RateData )
					end if
				end if
			end if
			if lnv_SetItem.of_getEventTypeFlag ( ) = n_Cst_Constants.cs_ItemEventType_FuelSurcharge then
				lnv_SetItem.of_MakeFuelSurcharge()
			end if
			
		case "di_miles"
			IF isNull ( Data ) THEN
				Data = "0"
			END IF
			lnv_SetItem.of_SetMiles ( dec(data) )
			if lb_rate then
				ls_ratecode = this.Getitemstring(row, 'ratecodename')
				if len(trim(ls_ratecode)) > 0 then
					if upper(ls_ratecode) = "CUSTOM" then
						//don't autorate
					else
						if	lnv_SetItem.of_autorate(lnva_Ratedata) < 0 then
							this.setitem(row, 'ratecodename','')
						else
							lnv_SetItem.of_applyautorate(lnva_Ratedata)
						end if
						lnv_ArraySrv.of_Destroy ( lnva_RateData )
					end if
				end if
			end if
			if lnv_SetItem.of_getEventTypeFlag ( ) = n_Cst_Constants.cs_ItemEventType_FuelSurcharge then
				lnv_SetItem.of_MakeFuelSurcharge()
			end if
			
		case "di_our_ratetype"
			lnv_SetItem.of_SetRateType ( data )
			if lb_rate then
				this.setitem(row, 'ratecodename','CUSTOM')
				
				ls_changed = lnv_string.of_GetKeyValue(ls_taglist,'Changed',',')
				ls_newvalue = 'rate type'
				if len(trim(ls_changed)) > 0 then
					//replace old value
					lnv_String.of_SetKeyvalue(ls_taglist,'Changed,', ls_newvalue, ',')
				else
					//new value
					ls_taglist += 'Changed=' + ls_newvalue
				end if
				lnv_SetItem.of_settaglist(ls_taglist)
				lnv_SetItem.of_setlastratedby(gnv_app.of_getuserid())
			end if
			
		case "di_our_rate"
			
			IF isNull ( Data ) THEN
				Data = "0"
			END IF
			
			lnv_SetItem.of_SetRate ( dec(data) ) 
			if lb_rate then
				this.setitem(row, 'ratecodename','CUSTOM')
				
				ls_changed = lnv_string.of_GetKeyValue(ls_taglist,'Changed',',')
				ls_newvalue = 'rate'
				if len(trim(ls_changed)) > 0 then
					//replace old value
					lnv_String.of_SetKeyvalue(ls_taglist,'Changed,', ls_newvalue, ',')
				else
					//new value
					ls_taglist += 'Changed=' + ls_newvalue
				end if
				lnv_SetItem.of_settaglist(ls_taglist)
				lnv_SetItem.of_setlastratedby(gnv_app.of_getuserid())
			end if
			
		case "di_our_itemamt"
			IF isNull ( Data ) THEN
				Data = "0"
			END IF
			if lnv_SetItem.of_SetAmount ( dec(data) ) < 0 then
				messagebox("Item Amount", lnv_SetItem.of_GetErrorString ( ))	
				ll_return = 2
			else
				if lb_rate then
					this.setitem(row, 'ratecodename','CUSTOM')
					
					ls_changed = lnv_string.of_GetKeyValue(ls_taglist,'Changed',',')
					ls_newvalue = 'amount'
					if len(trim(ls_changed)) > 0 then
						//replace old value
						lnv_String.of_SetKeyvalue(ls_taglist,'Changed,', ls_newvalue, ',')
					else
						//new value
						ls_taglist += 'Changed=' + ls_newvalue
					end if
					lnv_SetItem.of_settaglist(ls_taglist)
					lnv_SetItem.of_setlastratedby(gnv_app.of_getuserid())
				end if
			end if
			
		case "ratecodename"
			if isnull(data) then
				lnv_SetItem.of_SetRateType ( appeon_constant.cs_RateUnit_Code_None )
			elseif upper(data) = 'CUSTOM' or len(trim(data)) = 0 then
				//don't perform rating			
			else
				lnv_SetItem.of_SetRateCodename(data)
				if lb_rate then
					if	lnv_SetItem.of_autorate(lnva_Ratedata) < 0 then
						if this.object.di_our_itemamt[row] > 0  then
							this.setitem(row, 'ratecodename','CUSTOM')
							ll_return = 2
						else
							this.setitem(row, 'ratecodename','')
							ll_return = 2
							lnv_SetItem.of_SetRateType ( appeon_constant.cs_RateUnit_Code_None )
						end if
					else
						lnv_SetItem.of_applyautorate(lnva_Ratedata)
					end if
					lnv_ArraySrv.of_Destroy ( lnva_RateData )			
				end if
			end if
			
		case "di_pay_ratetype"
			lnv_SetItem.of_SetPayRateType ( data )
			
		case "di_pay_rate"
			IF isNull ( Data ) THEN
				Data = "0"
			END IF
			//if % found then multiply by di_our_rate
			ll_Pos = pos(data,'%',1)
			if ll_pos > 0 then
				if ll_pos = 1 then
					lc_percent = dec(right(data,len(data) - 1))
				elseif ll_pos = len(data) then
					lc_percent = dec(left(data,len(data) - 1))
				else
					lc_percent = 0
				end if
				
				lc_rate = this.object.di_our_rate[row]
				lnv_SetItem.of_SetPayRateType (this.object.di_our_ratetype[row])
	
				if lc_rate > 0 then
					lc_rate = lc_rate * (lc_percent/100)
				end if			
			else
				ls_payratetype = this.object.di_pay_ratetype[row]
				if isnull(ls_payratetype) or len(ls_payratetype) = 0 or &
					ls_payratetype = appeon_constant.cs_RateUnit_Code_None then
					lnv_SetItem.of_SetPayRateType (this.object.di_our_ratetype[row])
				end if
				lc_rate = dec(data)
			end if
			
			lnv_SetItem.of_SetPayRate ( lc_rate ) 
			
			if ll_pos > 0 then
				ll_return = 2
			end if
			
		case "di_pay_itemamt"
			IF isNull ( Data ) THEN
				Data = "0"
			END IF
			if lnv_SetItem.of_SetPayableAmount ( dec(data) ) < 0 then
				messagebox("Item Pay Amount", lnv_SetItem.of_GetErrorString ( ))	
				ll_return = 2
			end if
					
		case "di_description"
			
		CASE "accountingtype"	
		lnv_SetItem.of_SetaccountingType ( (data) )
	
	end choose
ELSE
	ll_Return = 2

END IF

THIS.AcceptText ( )  // <<*>> moved from top b.c. i need the original value for surcharge processing

DESTROY ( lnv_SetItem )

this.setredraw(true)


return ll_return
	
	

end event

event resize;call super::resize;IF ib_NeedHighlight THEN
	n_cst_Dws		lnv_Dws
	lnv_Dws.Post of_CreateHighlight ( This )
	ib_NeedHighlight = FALSE
END IF

RETURN AncestorReturnValue

end event

event itemerror;call super::itemerror;long 		ll_return
string	ls_column

ll_Return = ancestorReturnValue

IF ll_Return = 0 THEN

	choose case dwo.name
			
		case "di_weightperunit", "di_totitemweight", "di_miles", "di_our_rate", &
			  "di_our_itemamt", "di_pay_ratetype", "di_pay_rate", "di_pay_itemamt"
			if isnull(data) or len(trim(data)) = 0 then
				ls_column = dwo.name
				this.setitem(row, ls_column, 0)
				ll_return = 3	
			end if	
			
		case "di_qty"
			if isnull(data) or len(trim(data)) = 0 then
				this.setitem(row, "di_qty", 1)
				ll_return = 3	
			end if	

	end choose
end  if

return ll_return

end event

on u_dw_shipmentitemlist.create
end on

on u_dw_shipmentitemlist.destroy
end on

event rbuttonup;call super::rbuttonup;// RDT 6-30-03 Added check for txt_Restrict.ind before calling ue_ShowEventFlagMenu
string lsa_parm_labels[]
any laa_parm_values[]
String	ls_PopResult

if upper(dwo.type) = "DATAWINDOW" then
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "PRINT"
	lsa_parm_labels[2] = "PRINT_OBJECT"
	laa_parm_values[2] = this
	lsa_parm_labels[3] = "ADD_ITEM"
	laa_parm_values[3] = "Paste From &Rate List~tPASTEITEM"
	lsa_parm_labels[4] = "ADD_ITEM"
	laa_parm_values[4] = "Add Fr&om Rate List~tADDITEM"
	
	ls_PopResult = f_pop_standard(lsa_parm_labels, laa_parm_values)	
	CHOOSE CASE ls_PopResult
		CASE "PASTEITEM"
			
			THIS.event ue_RateLookup ( FALSE )
			
		CASE "ADDITEM"
			
			THIS.event ue_RateLookup ( TRUE )
			
	END CHOOSE 

elseif UPPER ( dwo.name ) = "EVENTFLAG" THEN

	If THIS.Object.txt_restrict_ind.text = 'F' Then // RDT 6-30-03
		THIS.Event ue_ShowEventFlagMenu ( row )
	End if 														// RDT 6-30-03
ELSE
	
	IF row > 0 THEN
		THIS.Post event ue_showitemmenu( row )		
	END IF
		
end if


//IF this.getItemstatus( row, 0, PRIMARY!) = NEWMODIFIED! THEN
//MessageBox("rbuttonup u_dw_eventList","new mod" )
//ELSEIF this.getItemstatus( row, 0, PRIMARY!) = NEW! THEN
//	MessageBox("clicked u_dw_eventList","new " )
//ELSEIF this.getItemstatus( row, 0, PRIMARY!) = datamodified! THEN
//	MessageBox("clicked u_dw_eventList","data mod" )
//ELSEIF this.getItemstatus( row, 0, PRIMARY!) = NOTMODIFIED! THEN
//	MessageBox("clicked u_dw_eventList","nnot mod" )
//END IF
end event

event rbuttondown;call super::rbuttondown;THIS.SetRow ( row )
THIS.SetRedraw ( TRUE ) 

end event

