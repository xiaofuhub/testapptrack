$PBExportHeader$u_dw_shipinfo.sru
forward
global type u_dw_shipinfo from u_dw
end type
end forward

global type u_dw_shipinfo from u_dw
integer width = 4302
integer height = 968
string dataobject = "d_ship_info"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
event type integer ue_showcompanymenu ( long al_coid,  dwobject dwo )
event ue_rightclickontmp ( )
event ue_rightclickonbillamount ( )
event type n_cst_beo_shipment ue_getshipment ( )
event ue_clearitemamounts ( string as_what )
event ue_rightclickonpayamount ( )
event type n_cst_bso_dispatch ue_getdispatchmanager ( )
event ue_changestatus ( )
event ue_statuschanged ( )
event type integer ue_validateref1text ( string as_reftext )
event processenter pbm_dwnprocessenter
event type n_cst_shiptype ue_getshiptype ( )
event type n_cst_ship_type ue_getshiptypemanager ( )
event type long ue_shiptypechanged ( long al_value )
event ue_shipmentchanged ( )
event type integer ue_recalcamounts ( integer ai_index,  string as_column )
event ue_sourcechanged ( )
event ue_ppcolchanged ( )
event type integer ue_specialdatetime ( dwobject dwo,  long row )
event ue_billformatchanged ( )
event ue_billtochanged ( long al_coid )
event ue_payformatchanged ( )
event wheel_vcroll pbm_vscroll
event ue_ref2textchanged ( n_cst_beo_shipment anv_shipment )
event ue_ref3textchanged ( n_cst_beo_shipment anv_shipment )
event ue_carrierchanged ( long al_id )
event ue_agentchanged ( long al_id )
event ue_forwarderchanged ( long al_id )
event type integer ue_ref1textchanged ( string as_value )
event ue_post204 ( boolean ab_checkededi )
end type
global u_dw_shipinfo u_dw_shipinfo

forward prototypes
public function long of_getbilltoid ()
public function long of_getpay1id ()
public function integer of_sharedata (powerobject apo_source)
public function integer of_determinedisplayrestrictions ()
public subroutine of_openadminwindow ()
public function long of_billtospecial (ref n_cst_beo_company anv_company, ref n_cst_beo_shipment anv_shipment)
public function integer of_hidecharges ()
end prototypes

event type integer ue_showcompanymenu(long al_coid, dwobject dwo);Any		laa_Parm_Values[]
String	lsa_Parm_Labels[]
String	ls_Name
Long	   ll_CompanyID

ll_CompanyID = al_coid
ls_Name = dwo.Name 

lsa_parm_labels[1] = "MENU_TYPE"
laa_parm_values[1] = "COMPANY"
lsa_parm_labels[2] = "CO_ID"
laa_parm_values[2] = ll_CompanyID

if ls_Name = "billto_name" then
	lsa_parm_labels[3] = "ADDRESS_TYPE"
	laa_parm_values[3] = "BILLING"
end if

f_pop_standard(lsa_parm_labels, laa_parm_values)

RETURN 1
end event

event ue_rightclickontmp();// RDT 6-26-03 Added "Paste Images" 
String	ls_Result
String	ls_iniFile
String	ls_lastpurpose
String	ls_lastcompany
String	lsa_Parm_labels[]
Any		laa_Parm_Values[]
Boolean	lb_Imaging
Boolean	lb_notification
Boolean	lb_CustomsBarcode
Boolean	lb_checkedEDI

Long	ll_coid
n_cst_ediExportshipmentmanager lnv_exportShipmentmanager
n_cst_LicenseManager	lnv_LicenseManager
n_cst_Msg	lnv_Msg
s_Parm	lstr_Parm
n_cst_beo_shipment	lnv_shipment
String	ls_scac

n_cst_bso_ImageManager_Pegasus lnv_ImageManager  // RDT 6-26-03 


ls_iniFile = gnv_app.of_getappinifile( )
ls_Result =  ProfileString ( ls_iniFile , "CUSTOMSTRANSFER", "ENABLED" , "-1" )

lb_CustomsBarcode = ls_Result = "1"
lb_Imaging = lnv_LIcenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Imaging )
lb_Notification = lnv_LIcenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Notification )

lsa_parm_labels[1] = "ADD_ITEM"
laa_parm_values[1] = "Mod Log"

IF lb_Imaging  THEN

	lsa_parm_labels[2] = "ADD_ITEM"
	laa_parm_values[2] = "&Imaging"
END IF

IF lb_Imaging OR lb_Notification THEN

	lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
	laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "&Missing Documents"

END IF

IF lb_Notification THEN

	lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
	laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "&View Documents"

END IF

lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "View &Notes"
Long	ll_countOut
string	ls_outbound = appeon_constant.cs_transaction_OUTBOUND
lnv_shipment = this.event ue_getshipment( )
IF lnv_shipment.of_isshiptypebrokerage()/*lnv_shipment.of_getShipmenttype( ) = "BROKERAGE" */AND lnv_shipment.of_isnonrouted( ) AND lnv_licenseManager.of_hasedi204license( ) THEN
	
	SELECT COUNT(*)
	into :ll_countOut
	FROM ediprofile
	WHERE transactionset = 204 and in_out = :ls_outbound and Not scac is NULL;
	
	CHOOSE CASE SQLCA.sqlcode
		CASE 0, 100
			commit;
		CASE -1
			rollback;
	END CHOOSE
	
	IF ll_countOut > 0 THEN
		lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"		
		laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "-"
		
		lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
		laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "EDI POST 204"
		
		//IF its got one posted that isn't cancelled...
		lnv_exportShipmentmanager = THIS.event ue_getdispatchmanager( ).of_getExportShipmentManager()
		IF lnv_exportShipmentmanager.of_getLastshipmentinfo( THIS.getitemNumber(1, "ds_id"), ls_lastcompany ,  ls_lastpurpose ) = 1 THEN
			IF ls_lastpurpose <> lnv_exportShipmentmanager.cs_gen204request_cancel THEN
				lsa_parm_labels[upperBound(lsa_parm_labels) + 1] = "CHECK"
				laa_parm_values[upperBound(laa_parm_Values) +1 ] = "EDI POST 204"
				lb_checkedEDI = true
			END IF
		ELSE
			//do nothing, no 204 was generated
		END IF
		
		lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
		laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "EDI POST CANCEL"
		lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"		
		laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "-"
	END IF	
END IF
///////////////////////////



lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "Add &Alert"

IF lnv_LicenseManager.of_HasEDI214License ( ) OR &
	lnv_LicenseManager.of_HasEDI322License ( ) THEN
	lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
	laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "&EDI Log"	
END IF


If lb_Imaging Then 
	// RDT 6-26-03 Added "Paste Images" 
	lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
	laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "Paste &Image"
End if



IF lb_CustomsBarcode THEN
	
	lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
	laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "-"
	
	lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
	laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "Export Customs Data"
	
END IF


CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )

	CASE "MOD LOG"
		g_tempstr = THIS.getitemstring(1, "ds_pronum")
		g_tempstr2 = THIS.getitemstring(1, "ds_mod_log")
		if len(g_tempstr2) > 0 then
		else
			g_tempstr2 = "NO MODIFICATION LOG IS AVAILABLE FOR THIS SHIPMENT."
		end if
		openwithparm(w_text_edit, -25)
	
	CASE "IMAGING"
	
		lstr_parm.is_label = "TOPIC"
		lstr_parm.ia_value = "SHIPMENT!"
		lnv_Msg.of_add_parm(lstr_parm)
	
		lstr_parm.is_label = "REQUEST"
		lstr_parm.ia_value = "IMAGES!"
		lnv_Msg.of_add_parm(lstr_parm)
	
		lstr_parm.is_label = "TARGET_ID"
		
		lstr_parm.ia_value = THIS.getitemNumber(1, "ds_id")
	//	lstr_parm.ia_value = inv_Shipment.of_GetSourceId ( )
		lnv_Msg.of_add_parm(lstr_parm)
	
		f_process_standard(lnv_Msg)
	
	
	CASE "MISSING DOCUMENTS"
	
		lstr_parm.is_label = "TOPIC"
		lstr_parm.ia_value = "SHIPMENT!"
		lnv_Msg.of_add_parm(lstr_parm)
	
		lstr_parm.is_label = "REQUEST"
		lstr_parm.ia_value = "MISSINGDOCUMENTS!"
		lnv_Msg.of_add_parm(lstr_parm)
	
		lstr_parm.is_label = "TARGET_ID"
		lstr_parm.ia_value = THIS.getitemNumber(1, "ds_id")
		lnv_Msg.of_add_parm(lstr_parm)
	
		f_process_standard(lnv_Msg)


	CASE "VIEW DOCUMENTS"
	
		lstr_parm.is_label = "TOPIC"
		lstr_parm.ia_value = "SHIPMENT!"
		lnv_Msg.of_add_parm(lstr_parm)
	
		lstr_parm.is_label = "REQUEST"
		lstr_parm.ia_value = "VIEWDOCUMENTS!"
		lnv_Msg.of_add_parm(lstr_parm)
	
		lstr_parm.is_label = "TARGET_ID"
		lstr_parm.ia_value = THIS.getitemNumber(1, "ds_id")
		lnv_Msg.of_add_parm(lstr_parm)
	
		f_process_standard(lnv_Msg)

	CASE "VIEW NOTES"
		
		lstr_parm.is_label = "TOPIC"
		lstr_parm.ia_value = "SHIPMENT!"
		lnv_Msg.of_add_parm(lstr_parm)
		
		lstr_parm.is_label = "DISPATCH"
		lstr_parm.ia_value = THIS.Event ue_GetDispatchManager ( )
		lnv_Msg.of_add_parm(lstr_parm)
	
		lstr_parm.is_label = "REQUEST"
		lstr_parm.ia_value = "VIEWNOTES!"
		lnv_Msg.of_add_parm(lstr_parm)
	
		lstr_parm.is_label = "TARGET_ID"
		lstr_parm.ia_value = THIS.getitemNumber(1, "ds_id")
		lnv_Msg.of_add_parm(lstr_parm)
	
		f_process_standard(lnv_Msg)

	CASE "EDI LOG"

		lstr_parm.is_label = "TOPIC"
		lstr_parm.ia_value = "SHIPMENT!"
		lnv_Msg.of_add_parm(lstr_parm)
	
		lstr_parm.is_label = "REQUEST"
		lstr_parm.ia_value = "EDILOG!"
		lnv_Msg.of_add_parm(lstr_parm)
	
		lstr_parm.is_label = "TARGET_ID"
		lstr_parm.ia_value = THIS.getitemNumber(1, "ds_id")
		lnv_Msg.of_add_parm(lstr_parm)
	
		f_process_standard(lnv_Msg)

		
	// RDT 6-26-03 Added "Paste Images" 
	CASE "PASTE IMAGE"
			lnv_ImageManager = CREATE n_cst_bso_ImageManager_Pegasus
			lnv_ImageManager.of_PasteImage ( { THIS.getitemNumber(1, "ds_id") } )
			DESTROY ( lnv_ImageManager	 ) // <<*>> added this
		
	CASE "EXPORT CUSTOMS DATA"
			Long	ll_NewID
			
			n_cst_bso_edimanager_camir lnv_Camir
			lnv_Camir = CREATE n_cst_bso_edimanager_camir
			
			ll_NewID = lnv_Camir.of_Exportdata( THIS.getitemNumber(1, "ds_id") )
			IF ll_NewID < 0 THEN
				lnv_Camir.of_Showerrormessages( )							
			ELSE
				MessageBox ( "New CAMIR Record" , "Record " + String ( ll_NewID ) + " has been successfully generated." )				
			END IF
			
			DESTROY ( lnv_Camir )
			
	CASE "ADD ALERT"
		THIS.event ue_getshipment( ).of_AddUserAlert ( )
		
	CASE "EDI POST 204"
		this.event ue_post204( lb_checkedEDI )
		
	CASE "EDI POST CANCEL"
		String	ls_dummy
		IF lnv_exportShipmentmanager.of_getLastshipmentinfo( THIS.getitemNumber(1, "ds_id") , ls_scac, ls_dummy) = 1 THEN
			lnv_exportShipmentmanager.of_addshiptopendingexport( THIS.getitemNumber(1, "ds_id"), ls_scac, lnv_exportShipmentmanager.cs_gen204request_cancel )
		ELSE
			Messagebox( "Post Cancel Order", "This shipment has no history in the exported shipments table.  A cancel order cannot be generated." )
		END IF
		
END CHOOSE
end event

event ue_rightclickonbillamount();n_cst_beo_Shipment	lnv_Shipment
m_fmtpop_ship 			lm_FormatPop
String					ls_BillFormat
Boolean					lb_Refresh

lnv_Shipment = THIS.Event ue_GetShipment ( ) 

//added condtion by dan to allow the menu to be displayed DEK 3-27-07
IF gnv_App.of_GetPrivsmanager( ).of_getuserpermissionfromfn( appeon_constant.cs_ModifyBilledShipRates, lnv_Shipment ) = 1 THEN
	//if this is 1 then then we know we have permission to change the format.
ELSE
	//this is old functionality, it displays a message if you don't have permission, so I cannot 'or' it 
	IF lnv_Shipment.of_ChangeFormat ( ) < 1   THEN 
		RETURN
	END IF
END IF
ls_BillFormat = lnv_Shipment.of_GetBillingFormat ( )

lm_FormatPop = create m_fmtpop_ship


choose case ls_BillFormat
	case "I"
		lm_FormatPop.m_specify.m_billing.m_itemamts_bill.checked = true
	case "L"
		lm_FormatPop.m_specify.m_billing.m_lhacamts_bill.checked = true
	case "G"
		lm_FormatPop.m_specify.m_billing.m_grandtotal_bill.checked = true
end choose

Int	li_pointerX
Int	li_pointerY

n_cst_appServices	lnv_AppServices
lnv_AppServices.of_GetPointerPosition ( li_PointerX, li_PointerY )

lm_FormatPop.m_specify.popmenu( li_pointerX  , li_PointerY )
destroy lm_FormatPop

choose case g_tempint
		
	case 1
		
		if ls_BillFormat = "I" then 
			return
		END IF
		
		if THIS.getitemdecimal(1, "ds_bill_charge") > 0 then
			if messagebox("Change Billing Format", "Current billing amounts will "+&
				"be cleared.  OK to change format?", exclamation!, okcancel!, 2) = 2 then 
				return
			END IF
		end if
		
		lb_Refresh = true
		ls_BillFormat = "I"
		THIS.setitem(1, "ds_lh_totamt", 0)
		THIS.setitem(1, "ds_disc_amt", 0)
		THIS.setitem(1, "ds_ac_totamt", 0)
		THIS.setitem(1, "ds_bill_charge", 0)
	case 2
		if ls_BillFormat = "L" then 
			return
		END IF
		
		if ls_BillFormat = "G" and THIS.getitemdecimal(1, "ds_bill_charge") > 0 then
		
			if messagebox("Change Billing Format", "The current billing total will "+&
				"be cleared.  OK to change format?", exclamation!, okcancel!, 2) = 2 then
				return
			END IF
		end if
		
		if ls_BillFormat = "I" and THIS.getitemdecimal(1, "ds_bill_charge") > 0 then
			
			if messagebox("Change Billing Format", "Items will have their current "+&
				"billing ratetypes, rates, and item amounts cleared.  OK to change "+&
				"format?", exclamation!, okcancel!, 2) = 2 then 
				return
			END IF
		end if
		
		if ls_BillFormat = "I" then 
			THIS.Event ue_ClearItemAmounts ( "CHARGES")
			lb_Refresh = true
		end if
		
		if ls_BillFormat = "G" then
			THIS.setitem(1, "ds_bill_charge", 0)
		END IF
		ls_BillFormat = "L"
		
	case 3
		
		if ls_BillFormat = "G" then 
			return
		END IF
		
		if ls_BillFormat = "I" and THIS.getitemdecimal(1, "ds_bill_charge") > 0 then

			if messagebox("Change Billing Format", "Items will have their current "+&
				"billing ratetypes, rates, and item amounts cleared.  OK to change "+&
				"format?", exclamation!, okcancel!, 2) = 2 then 
				Return
			END IF
		end if
		
		if ls_BillFormat = "I" then 
			THIS.Event ue_ClearItemAmounts ( "CHARGES")
			lb_refresh = true
		end if
		THIS.setitem(1, "ds_lh_totamt", 0)
		THIS.setitem(1, "ds_disc_amt", 0)
		THIS.setitem(1, "ds_disc_pct", 0)
		THIS.setitem(1, "ds_ac_totamt", 0)
		ls_BillFormat = "G"
		
	case else
		return
end choose

choose case g_tempint
	case 1 to 3
		
//		dw_item_details.modify("txt_bill_ind.text = '" + ls_BillFormat + "'")
		THIS.setitem(1, "ds_bill_format", ls_BillFormat)
		THIS.Post Event ue_billFormatChanged ( )
end choose             

THIS.setcolumn("ds_ship_comment")
end event

event ue_clearitemamounts;int	li_ItemCount
Int	i

n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Item			lnva_ItemList[]

lnv_Shipment = THIS.Event ue_GetShipment ( )

IF isValid( lnv_Shipment ) THEN
	li_ItemCount = lnv_Shipment.of_GetItemList ( lnva_ItemList ) 
	FOR i = 1 TO li_ItemCount
		IF as_what = "CHARGES" THEN
			lnva_ItemList [ i ].of_ClearBillRateData ( )
		ELSE
			lnva_ItemList [ i ].of_ClearPayRateData ( )
		END IF
		DESTROY ( lnva_ItemList [ i ] )
	NEXT 
END IF


end event

event ue_rightclickonpayamount();String	ls_PayFormat
Int		li_pointerX
Int		li_pointerY

n_cst_appServices	lnv_AppServices
n_cst_beo_shipment		lnv_shipment
m_fmtpop_ship lm_FormatPopPayable

lnv_Shipment = THIS.Event ue_GetShipment ( ) 

IF Not isValid ( lnv_SHipment ) THEN
	RETURN 
END IF

//added condtion by dan to allow the menu to be displayed DEK 3-27-07
IF gnv_App.of_GetPrivsmanager( ).of_getuserpermissionfromfn( appeon_constant.cs_ModifyBilledShipRates, lnv_Shipment ) = 1 THEN
	//if this is 1 then then we know we have permission to change the format.
ELSE
	//this is old functionality, it displays a message if you don't have permission, so I cannot 'or' it 
	IF lnv_Shipment.of_ChangeFormat ( ) < 1 THEN
		RETURN
	END IF
END IF
ls_PayFormat = lnv_Shipment.of_GetPayableFormat ( )

lm_FormatPopPayable = create m_fmtpop_ship
lm_FormatPopPayable.m_specify.m_billing.text="&Payable: Specify"
choose case ls_PayFormat
	case "I"
		lm_FormatPopPayable.m_specify.m_billing.m_itemamts_bill.checked = true
	case "L"
		lm_FormatPopPayable.m_specify.m_billing.m_lhacamts_bill.checked = true
	case "G"
		lm_FormatPopPayable.m_specify.m_billing.m_grandtotal_bill.checked = true
end choose

lnv_AppServices.of_GetPointerPosition ( li_PointerX, li_PointerY )

lm_FormatPopPayable.m_specify.popmenu( li_PointerX   , li_PointerY )
destroy lm_FormatPopPayable

choose case g_tempint
	case 1
		if ls_PayFormat = "I" then
			return
		END IF
		if THIS.getitemdecimal(1, "ds_pay_totamt") > 0 then
			if messagebox("Change Payable Format", "Current payable amounts will "+&
				"be cleared.  OK to change format?", exclamation!, okcancel!, 2) = 2 then 
				return
			END IF
		end if
//		refresh = true
		ls_PayFormat = "I"
		THIS.setitem(1, "ds_pay_lh_totamt", 0)
		THIS.setitem(1, "ds_pay_ac_totamt", 0)
		THIS.setitem(1, "ds_pay_totamt", 0)
	case 2
		if ls_PayFormat = "L" then 
			return
		END IF
		
		if ls_PayFormat = "G" and THIS.getitemdecimal(1, "ds_pay_totamt") > 0 then
			if messagebox("Change Payable Format", "The current payable total will "+&
				"be cleared.  OK to change format?", exclamation!, okcancel!, 2) = 2 then 
				return
			END IF
		END IF
		
		if ls_PayFormat = "I" and THIS.getitemdecimal(1, "ds_pay_totamt") > 0 then
			if messagebox("Change Payable Format", "Items will have their current "+&
				"payable ratetypes, rates, and item amounts cleared.  OK to change "+&
				"format?", exclamation!, okcancel!, 2) = 2 then 
				return
			END IF
		end if
		if ls_PayFormat = "I" then 
			THIS.Event ue_ClearItemAmounts ( "PAYABLE" )
		//	refresh = true
		end if
		if ls_PayFormat = "G" then 
			THIS.setitem(1, "ds_pay_totamt", 0)
		END IF
		ls_PayFormat = "L"
		
	case 3
		if ls_PayFormat = "G" then 
			return
		END IF
		if ls_PayFormat = "I" and THIS.getitemdecimal(1, "ds_pay_totamt") > 0 then
			if messagebox("Change Payable Format", "Items will have their current "+&
				"payable ratetypes, rates, and item amounts cleared.  OK to change "+&
				"format?", exclamation!, okcancel!, 2) = 2 then return
		end if
		if ls_PayFormat = "I" then 
			THIS.Event ue_ClearItemAmounts ( "PAYABLE" )
//			refresh = true
		end if
		THIS.setitem(1, "ds_pay_lh_totamt", 0)
		THIS.setitem(1, "ds_pay_ac_totamt", 0)
		THIS.setitem(1, "ds_pay_totamt", 0)
		ls_PayFormat = "G"
	case else
		return
end choose

choose case g_tempint
	case 1 to 3
		//dw_item_details.modify("txt_pay_ind.text = '" + ls_PayFormat + "'")
		THIS.setitem(1, "ds_pay_format", ls_PayFormat)
		THIS.Post Event ue_payFormatChanged ( )
end choose
THIS.setcolumn("ds_status")
end event

event ue_changestatus;n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch


lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )

IF isValid ( lnv_Shipment ) AND isValid ( lnv_Dispatch ) THEN
	IF lnv_Shipment.of_ChangeStatus ( lnv_Dispatch ) = 1 THEN
		THIS.Event ue_StatusChanged ( )//wf_SetDisplayRestrictions ( TRUE )
	END IF
END IF
end event

event type integer ue_validateref1text(string as_reftext);Int	li_return
String	ls_Value
n_cst_beo_Shipment	lnv_Shipment
n_cst_shipmentManager	lnv_ShipmentManager

ls_value = as_reftext

lnv_Shipment = THIS.Event ue_GetShipment ( )


//IF isValid ( lnv_Shipment ) THEN
	CHOOSE CASE	lnv_SHipmentManager.of_ValidateRef1Text( lnv_Shipment.of_GetID(), "" , ls_value )
			
			
		CASE 1 // Everything oK
			li_Return = 1
			
		CASE 0 // opened a window for user interaction
			li_Return = -1
			
		CASE ELSE // -1 or unexpected return value
			li_return = -1
			
			
	END CHOOSE
//END IF




RETURN li_return



end event

event type long ue_shiptypechanged(long al_value);Boolean	lb_WasIntermodal
Long	ll_FoundRow
Long	ll_Return = 1
n_cst_LicenseManager	lnv_LicenseManager
n_cst_Ship_Type		lnv_ShipTypeManager
n_cst_ShipType			lnv_ShipType

//Modified By Dan 2-7-07 to check a new priv if the shipment is billed
n_cst_beo_shipment 	lnv_shipment
String	ls_privFunction

lnv_shipment = THIS.event ue_getshipment( )
IF lnv_shipment.of_isbilled( ) THEN
	ls_privFunction = appeon_constant.cs_ModifyBilledShip
ELSE
	ls_privFunction = "ModifyShipment"
END IF
//////////////////////
IF gnv_App.of_getprivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction , lnv_shipment ) = appeon_constant.ci_FALSE THEN
	RETURN 2
END IF

if lnv_ShipTypeManager.of_find(long(al_value), ll_foundrow) = 1 then
	
	if gds_shiptype.object.st_expedite[ll_foundrow] = "T" then
		this.setitem(1, "ds_expedite", "T")
//	elseif this.getitemstring(1, "ds_expedite") = "T" and ich_expedite = "F" then
//		this.setitem(1, "ds_expedite", "F")
	end if
	
	if gds_shiptype.object.st_brokerage[ll_foundrow] = "T" and &
		lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) then
		this.object.billto_address.height=72
		this.object.ds_pronum_t.visible=0
		this.object.billdate_t.visible=0
		this.object.ds_pronum.visible=0
		this.object.ds_bill_date.visible=0
		
		this.object.carrier_t.visible=1
		this.object.dispatchedby_t.visible=1
		this.object.availableon_t.visible=1
		this.object.availableuntil_t.visible=1
		this.object.pay1_name.visible=1
		this.object.dispatchedby.visible=1
		this.object.availableon.visible=1
		this.object.availableuntil.visible=1
	else
		this.object.billto_address.height=252
		this.object.ds_pronum_t.visible=1
		this.object.billdate_t.visible=1
		this.object.ds_pronum.visible=1
		this.object.ds_bill_date.visible=1
		
		this.object.carrier_t.visible=0
		this.object.dispatchedby_t.visible=0
		this.object.availableon_t.visible=0
		this.object.availableuntil_t.visible=0
		this.object.pay1_name.visible=0
		this.object.dispatchedby.visible=0
		this.object.availableon.visible=0
		this.object.availableuntil.visible=0
	end if
	
	lnv_ShipType = THIS.Event ue_GetShipType ( )
	IF isValid ( lnv_ShipType ) THEN
		lb_WasIntermodal = lnv_ShipType.of_GetIntermodal ( ) 
		
		
		IF gnv_App.of_getprivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction, al_value  ) =  appeon_constant.ci_TRUE THEN
		
			IF lb_WasIntermodal THEN
				IF gds_shiptype.object.Intermodal[ll_foundrow] <> "T" THEN
					IF MessageBox ( "Shipment type", "You are changing from an intermodal shipment type to a non-intermodal shipment type. Are you sure you want to do this?" , QUESTION! , YESNO! , 2 ) = 1 THEN					
						ll_Return = 1
					ELSE
						ll_Return = 2
					END IF					
				END IF
			ELSE
				IF gds_shiptype.object.Intermodal[ll_foundrow] = "T" THEN
					IF MessageBox ( "Shipment type", "You are changing from a non intermodal shipment type to an intermodal shipment type. Are you sure you want to do this?" , QUESTION! , YESNO! , 2 ) = 1 THEN
						ll_Return = 1
					ELSE
						ll_Return = 2
					END IF
				END IF
			END IF
		ELSE
			MessageBox ( "Shipment type", "You cannot change the shipment type to one that you have not been granted rights to modify."  ) 
			ll_Return = 2
		END IF
	END IF
	
	DESTROY ( lnv_ShipType ) 
				
end if

	
Return ll_Return
end event

event ue_shipmentchanged();
CONSTANT String	ls_Restrict = "txt_restrict_ind.text = 'T'"
CONSTANT String	ls_NonRestrict = "txt_restrict_ind.text = 'F'"
CONSTANT String	ls_RestrictRates = "txt_restrictrates_ind.text = 'T'"
CONSTANT String	ls_NonRestrictRates = "txt_restrictrates_ind.text = 'F'"
String	ls_Context
String	ls_Modify
String	ls_modifyRateIndicator
String	ls_modfnId


n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.Event ue_GetShipment ( ) 

IF isValid ( lnv_Shipment ) THEN
	
	IF lnv_shipment.of_isBilled( ) THEN
		ls_modfnId = appeon_constant.cs_ModifyBilledShip
	ELSE
		ls_modFnId = "ModifyShipment"
	END IF
	
	IF gnv_App.of_GetPrivsmanager( ).of_getuserpermissionfromfn( ls_modFnId, lnv_Shipment ) = 1 THEN

		IF lnv_Shipment.of_AllowEditBill ( ) THEN
			ls_Modify = ls_NonRestrict
		ELSE
			THIS.SetColumn ( "ds_pronum" )
			ls_Modify = ls_Restrict
		END IF
	ELSE
		ls_Modify = ls_Restrict
	END IF
	//Added by dan 3-27-07 to allow editing of rates on billed shipments if the user has permission
	IF lnv_shipment.of_isBilled( ) THEN
		IF gnv_App.of_GetPrivsmanager( ).of_getuserpermissionfromfn( ls_modFnId, lnv_Shipment ) = 1 THEN
			ls_Modify = ls_NonRestrict
		ELSE
			ls_Modify = ls_Restrict
		END IF
		
		IF gnv_App.of_GetPrivsmanager( ).of_getuserpermissionfromfn( appeon_constant.cs_ModifyBilledShipRates, lnv_Shipment ) = 1 THEN
			ls_modifyRateIndicator = ls_NonRestrictRates
		ELSE
			ls_modifyRateIndicator = ls_restrictRates
		END IF
	ELSE
	END IF
END IF

THIS.Modify ( ls_Modify )	
THIS.Modify( ls_modifyRateIndicator )


end event

event wheel_vcroll;Message.Processed = True


end event

event ue_ref2textchanged(n_cst_beo_shipment anv_shipment);Int		li_MboxRet
Long		ll_Count
Long		lla_Ids []
Boolean	lb_CrossCheckRef2
Boolean	lb_OpenShipmentsOnly
ULong		lul_BitSwitch
ULong 	lul_SourceBitSwitch
String	ls_Where
String	ls_Ref
String	ls_Type

W_Search						lw_Search
n_cst_msg					lnv_Msg
n_cst_ShipmentManager	lnv_Manager
n_cst_beo_Shipment		lnv_Shipment
n_cst_sql					lnv_Sql
n_Cst_Settings				lnv_Settings
S_Parm						lstr_Parm

lb_OpenShipmentsOnly = lnv_Settings.of_ValidateOpenShipmentsOnly ( )

lnv_Shipment = anv_Shipment //THIS.Event ue_GetShipment ( )

CHOOSE CASE lnv_Settings.of_CrossCheck2ndAnd3rdRefFields ( ) 
		
	CASE "YES!"
		lb_CrossCheckRef2 = TRUE
	CASE "NO!"
		lb_CrossCheckRef2 = FALSE
	CASE "NULLREF1!"
		lb_CrossCheckRef2 = IsNull ( lnv_Shipment.of_GetRef1Text () )
		
END CHOOSE		

IF lb_CrossCheckRef2 THEN
	lul_BitSwitch = 6 // 110 check second and third ref 
	lul_SourceBitSwitch = 2  // 10  use the second ref as the source
	//																					   source      		 target
	ll_Count = lnv_Manager.of_CrossCheckRefFields ( lnv_Shipment , lul_SourceBitSwitch ,lul_BitSwitch , lb_OpenShipmentsOnly , lla_Ids ) 
	
	IF ll_Count > 0 THEN
		li_MboxRet =  MessageBox ( "Reference Values" , "Reference values entered in this shipment have been found in " + &
			 String (ll_Count) + " other shipment(s). Do you want to see a list of these shipments?",Question! , YesNo! , 1)
	ELSE
				
		ls_Type = lnv_Manager.of_GetEqtypeForRefType ( lnv_Shipment.of_GetRef2Type ( ) )
		
		IF Len ( Trim ( ls_Type ) ) > 0 THEN
			ll_Count = lnv_Manager.of_checkequipmentbysmartsearch ( lnv_Shipment.of_GetRef2Text ( ) , ls_Type , {lnv_Shipment.of_GetID ( )} ,lla_Ids )			
		
		
			IF ll_Count > 0 THEN
				li_MboxRet =  MessageBox ( "Reference Values" , "Reference values entered in this shipment have been found to be very similar to equipment numbers in " + &
				 String (ll_Count) + " other shipment(s). Do you want to see a list of these shipments?",Question! , YesNo! , 1)
			END IF
			
		END IF
		
			
			
	END IF	
	
	IF li_MboxRet = 1 THEN
		
		ls_Where = " WHERE ds_id " + lnv_Sql.of_MakeInClause ( lla_Ids )
		lstr_Parm.is_Label = "ShipmentWhereClause"
		lstr_Parm.ia_Value = ls_Where
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		OpenSheetWithParm ( lw_Search, lnv_Msg, gnv_App.of_GetFrame ( ), 0, Layered! )
		
	END IF
	
END IF
		
		

end event

event ue_ref3textchanged(n_cst_beo_shipment anv_shipment);Int	li_MboxRet
Long	ll_Count
Long	lla_Ids []
Boolean	lb_CrossCheckRef2and3
Boolean	lb_OpenShipmentsOnly
ULong		lul_BitSwitch
ULong		lul_SourceBitSwitch
String	ls_Where
String	ls_Ref
String	ls_Type
		
W_Search						lw_Search
n_cst_msg					lnv_Msg
n_cst_ShipmentManager	lnv_Manager
n_cst_beo_Shipment		lnv_Shipment
n_cst_sql					lnv_Sql
n_Cst_Settings				lnv_Settings
S_Parm						lstr_Parm


lb_OpenShipmentsOnly = lnv_Settings.of_ValidateOpenShipmentsOnly ( )
lnv_Shipment = anv_Shipment //THIS.Event ue_GetShipment ( )

CHOOSE CASE lnv_Settings.of_CrossCheck2ndAnd3rdRefFields( )		
	CASE "YES!"
		lb_CrossCheckRef2and3 = TRUE
	CASE "NO!"
		lb_CrossCheckRef2and3 = FALSE
	CASE "NULLREF1!"
		lb_CrossCheckRef2and3 = IsNull ( lnv_Shipment.of_GetRef1Text() )
END CHOOSE		

IF lb_CrossCheckRef2and3 THEN
	lul_BitSwitch = 6 // 110 check second and third ref 
	lul_SourceBitSwitch = 4  // 100 use the 3rd ref field as our source
	//		 																				source   			 target
	ll_Count = lnv_Manager.of_CrossCheckRefFields ( lnv_Shipment , lul_SourceBitSwitch ,lul_BitSwitch , lb_OpenShipmentsOnly , lla_Ids ) 
	
	IF ll_Count > 0 THEN
		li_MboxRet =  MessageBox ( "Reference Values" , "Reference values entered in this shipment have been found in " + &
			 String (ll_Count) + " other shipment(s). Do you want to see a list of these shipments?",Question! , YesNo! , 1)
	ELSE
						
		ls_Type = lnv_Manager.of_GetEqtypeForRefType ( lnv_Shipment.of_GetRef3Type ( ) )
		
		IF Len ( Trim ( ls_Type ) ) > 0 THEN
			ll_Count = lnv_Manager.of_checkequipmentbysmartsearch ( lnv_Shipment.of_GetRef3Text ( ) , ls_Type, {lnv_Shipment.of_GetID ( )} , lla_Ids )			
				
			IF ll_Count > 0 THEN
				li_MboxRet =  MessageBox ( "Reference Values" , "Reference values entered in this shipment have been found to be very similar to equipment numbers in " + &
				 String (ll_Count) + " other shipment(s). Do you want to see a list of these shipments?",Question! , YesNo! , 1)
			END IF
			
		END IF
		
		
	END IF	
	
	IF li_MboxRet = 1 THEN
		
		ls_Where = " WHERE ds_id " + lnv_Sql.of_MakeInClause ( lla_Ids )
		lstr_Parm.is_Label = "ShipmentWhereClause"
		lstr_Parm.ia_Value = ls_Where
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		OpenSheetWithParm ( lw_Search, lnv_Msg, gnv_App.of_GetFrame ( ), 0, Layered! )
		
	END IF
	
END IF
		
		

end event

event ue_carrierchanged(long al_id);n_Cst_beo_Company	lnv_Company	
lnv_Company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID (al_id ) 
THIS.event ue_getdispatchmanager( ).of_GetAlertmanager( ).of_ShowAlerts( {lnv_Company} )

DESTROY ( lnv_Company )

end event

event ue_agentchanged(long al_id);n_Cst_beo_Company	lnv_Company	
lnv_Company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID (al_id ) 
THIS.event ue_getdispatchmanager( ).of_GetAlertmanager( ).of_ShowAlerts( {lnv_Company} )

DESTROY ( lnv_Company )

end event

event ue_forwarderchanged(long al_id);n_Cst_beo_Company	lnv_Company	
lnv_Company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE ) 
lnv_Company.of_SetSourceID (al_id ) 
THIS.event ue_getdispatchmanager( ).of_GetAlertmanager( ).of_ShowAlerts( {lnv_Company} )

DESTROY ( lnv_Company )

end event

event type integer ue_ref1textchanged(string as_value);Boolean	lb_ProcessedAsEquipment

integer	li_Return = 1
Int		li_RefType
string	ls_WhereClause, ls_Value,ls_SQL,ls_OriginalSelect, ls_ModString
Boolean	lb_ValidateRef
Boolean	lb_ValidateBL

String	ls_Status
String	ls_Type
String	lsa_Dupes[]
String	ls_Dupes
String	ls_CDerror

long		lla_Ids[], ll_RowCount, i, ll_ArrayCount, ll_DupCount, ll_EqId
datastore 	lds_Ship, lds_Item
//				
n_cst_Sql	lnv_Sql
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
w_Search		lw_Search
n_Cst_ShipmentManager	lnv_ShipMan
n_cst_LicenseManager	lnv_LicenseMgr
n_cst_EquipmentManager 	lnv_Equip
n_cst_beo_Shipment		lnv_Shipment
n_ds		lds_EquipmentCache
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Shipment = THIS.event ue_getshipment( )
ls_Value = as_value
IF isnull (ls_Value) or len ( trim ( ls_Value ) ) = 0 THEN
	RETURN 1
END IF
	

IF lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) = TRUE OR &
	lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch ) = TRUE THEN
	IF lnv_Shipment.of_IsNonRouted ( ) = FALSE THEN
		li_RefType = lnv_Shipment.of_GetRef1Type ( ) 
		IF ( li_RefType = 20 OR li_RefType = 26 OR li_RefType = 28 ) AND Len ( Trim ( ls_Value ) ) > 0 THEN
			S_eq_Info	lstr_equip
			IF li_RefType = 20 THEN
				ls_Type = 'C'
			ELSEIF li_RefType = 26  THEN
				ls_Type = 'B'
			ELSE 
				ls_Type = 'H'
			END IF
			lb_ProcessedAsEquipment = TRUE	
		END IF
	END IF
END IF
IF Not lb_ProcessedAsEquipment THEN
	IF this.Event ue_validateref1text(as_Value ) <> 1 THEN
		li_Return = 2
	ELSE 
		lnv_Shipment.of_SetRef1text( as_Value )
	END IF
END IF
IF IsValid ( lds_Item ) THEN
	DESTROY lds_Item
END IF

IF IsValid ( lds_Ship ) THEN
	DESTROY lds_Ship
END IF

RETURN li_Return
end event

event ue_post204(boolean ab_checkededi);
Long	ll_coid
String ls_scac
String	ls_companyName
String	ls_message
Long	ll_shipId 
n_cst_msg	lnv_msg
s_parm		lstr_parm

ll_shipId =THIS.getitemNumber(1, "ds_id")

n_cst_ediExportshipmentmanager lnv_exportShipmentmanager
//ll_coid = this.event ue_getShipment().of_getCarrier()
lnv_exportShipmentmanager = this.event ue_getdispatchmanager( ).of_getExportShipmentManager()

OPENWITHPARM( w_getScac, this.event ue_getSHipment() )
IF isvalid( message.powerobjectparm ) THEN
	IF message.powerobjectparm.classname() = "n_cst_msg"  THEN
		lnv_msg = message.powerobjectparm
		IF lnv_msg.of_get_parm( "SCAC", lstr_parm ) > 0 THEN
			ls_scac = lstr_parm.ia_value
			lnv_exportShipmentmanager.of_addshiptopendingexport( ll_shipId, ls_scac, appeon_constant.cs_gen204request_original )
		END IF
	END IF
END IF




end event

public function long of_getbilltoid ();Long	ll_ID = -1
Long	ll_Row

ll_Row = THIS.GetRow ( )

IF ll_Row > 0 THEN
	ll_ID = THIS.GetItemNumber ( ll_Row , "ds_billto_id" ) 
END IF

RETURN ll_ID
end function

public function long of_getpay1id ();Long	ll_ID = -1
Long	ll_Row

ll_Row = THIS.GetRow ( )

IF ll_Row > 0 THEN
	ll_ID =  THIS.GetItemNumber ( ll_Row , "ds_pay1_id" ) 
END IF

RETURN ll_ID 

end function

public function integer of_sharedata (powerobject apo_source);n_cst_Dws	lnv_dws
DataStore	lds_Source
DataWindow	ldw_Source


apo_source.Dynamic ShareData ( THIS )
THIS.Post Event ue_SourceChanged ( )

RETURN 1
end function

public function integer of_determinedisplayrestrictions ();CONSTANT String	ls_Restrict = "txt_restrict_ind.text = 'T'"
CONSTANT String	ls_NonRestrict = "txt_restrict_ind.text = 'F'"
String	ls_Context

n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.Event ue_GetShipment ( ) 

IF isValid ( lnv_Shipment ) THEN

	IF lnv_Shipment.of_AllowEditBill ( ) THEN
		THIS.Modify ( ls_NonRestrict )
	ELSE
		THIS.SetColumn ( "ds_pronum" )
		THIS.Modify ( ls_Restrict )	
	END IF
END IF

RETURN 1
end function

public subroutine of_openadminwindow ();n_CsT_bso_Dispatch	lnv_Disp
n_Cst_beo_SHipment	lnv_SHip
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm

lnv_Ship = THIS.Event ue_GetShipment ( )
lnv_Disp = THIS.Event ue_GetDispatchManager ( )

lstr_Parm.is_Label = "DISPATCH"
lstr_Parm.ia_Value = lnv_Disp
lnv_Msg.of_Add_Parm ( lstr_Parm ) 

lstr_Parm.is_Label = "SHIPMENT"
lstr_Parm.ia_Value = lnv_Ship
lnv_Msg.of_Add_Parm ( lstr_Parm ) 


OpenWithParm ( w_IntermodalAdmin , lnv_Msg )


end subroutine

public function long of_billtospecial (ref n_cst_beo_company anv_company, ref n_cst_beo_shipment anv_shipment);long	ll_return = 1, &
		ll_billto, &
		ll_origin, &
		ll_destination
		
n_cst_beo_company	lnv_company

IF isValid ( anv_Shipment ) THEN
	
	ll_Origin = anv_Shipment.Of_GetOrigin()
		
	if isnull(ll_origin) or ll_origin = 0 then
		messagebox('Billto Selection', "The shipment must have an origin when using the '?' to assign the Billto.")
		ll_return = -1
	else
		ll_Destination = anv_Shipment.Of_GetDestination()
		if isnull(ll_Destination) or ll_Destination = 0 then
			messagebox('Billto Selection', "The shipment must have a destination when using the '?' to assign the Billto.")
			ll_return = -1
		end if
	end if
	
	if ll_return = 1 then
				
		ll_Origin = anv_Shipment.Of_GetOrigin()
		ll_Destination = anv_Shipment.Of_GetDestination()
		
		if ll_origin > 0 and ll_Destination > 0 then
			
		  SELECT "billtopoints"."id"  
			 INTO :ll_Billto  
			 FROM "billtopoints"  
			WHERE ( "billtopoints"."origin" = :ll_origin ) AND  
					( "billtopoints"."destination" = :ll_destination )   ;
			
			if sqlca.sqlcode = 0 then
				anv_company = CREATE n_cst_beo_Company
				
				gnv_cst_Companies.of_Cache ( ll_Billto, TRUE )				
				anv_company.of_SetUseCache ( TRUE )
				
				IF anv_company.of_SetSourceId ( ll_Billto ) = 1 THEN
					IF anv_company.of_HasSource ( ) THEN
						//ok
					ELSE
						ll_billto = 0
					END IF
				END IF
				
			ELSE
				
				messagebox('Billto Selection', 'No Billto has been specified for the shipment origin/destination. '+&
				'You can add one in the Billto Origin/Destination Points window.')			
	
			END IF
			
			commit;
			
		END IF	
	
	END IF
	
END IF

return ll_billto
end function

public function integer of_hidecharges ();
Int	li_Return = 1

this.Modify("ds_lh_totamt.Visible=0")
this.Modify("ds_ac_totamt.Visible=0")
this.Modify("ds_bill_charge.Visible=0")
this.Modify("ds_pay_lh_totamt.Visible=0")
this.Modify("ds_pay_ac_totamt.Visible=0")
this.Modify("ds_pay_totamt.Visible=0")
this.Modify("ds_disc_amt.Visible=0")
this.Modify("ds_disc_pct.Visible=0")
this.Modify("ds_lh_totamt_t.Visible=0")
this.Modify("ds_salescom_amt.Visible=0")
this.Modify("t_5.Visible=0")

RETURN li_Return
end function

event rbuttondown;call super::rbuttondown;
Long	ll_ID



CHOOSE CASE   dwo.name
		
	CASE "billto_name"
		ll_ID = THIS.of_GetBilltoID ( )		
		IF ll_ID > 0 THEN
			THIS.Event ue_ShowCompanyMenu ( ll_ID , dwo )
		END IF
		
	CASE "pay1_name"
		ll_ID = THIS.of_GetPay1Id ( )
		IF ll_ID > 0 THEN
			THIS.Event ue_ShowCompanyMenu ( ll_ID , dwo )
		END IF
		
	CASE "ds_id" 
		THIS.Event ue_RightclickonTmp ( )
		
	CASE "ds_lh_totamt", "ds_disc_amt", "ds_disc_pct", "ds_ac_totamt", "ds_bill_charge"
		
		THIS.Event ue_RightClickonBillAmount ( )
		
	CASE "ds_pay_lh_totamt", "ds_pay_ac_totamt", "ds_pay_totamt"
		
		THIS.Event ue_RightClickOnPayAmount ( )
		
	case "ds_status"
		
		THIS.Event ue_ChangeStatus  ( )
			
		
END CHOOSE



RETURN ancestorReturnValue
end event

event constructor;THIS.of_SetInsertable( FALSE )
THIS.of_Setdeleteable( FALSE )
THIS.of_Setfilter( FALSE )
THIS.of_setautosort( FALSE )
THIS.of_SetAutofilter( FALSE )



n_cst_privsManager			lnv_privManager
n_cst_ShipmentManager	lnv_ShipmentManager


This.Modify ( "ds_Status.Edit.CodeTable = Yes "+&
	"ds_Status.Values = '" + lnv_ShipmentManager.of_GetStatusCodeTable ( ) + "'" )
	
n_cst_ShipmentManager	lnv_ShipmentMgr
lnv_ShipmentMgr.of_PopulateReferenceLists ( THIS )

n_cst_Presentation_Shipment	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

n_cst_ship_type			lnv_ShipTypeManager
dwobject						ldwo_ShipType
Long							lla_RequiredShipTypes[]

lnv_ShipTypeManager = THIS.Event ue_GetShipTypeManager ( )
IF IsValid ( lnv_ShipTypeManager ) THEN
	ldwo_ShipType = THIS.object.ds_ship_type
		lnv_ShipTypeManager.of_populate(ldwo_ShipType, "ALL", true, &
			lla_RequiredShipTypes)
END IF

lnv_privmanager = gnv_app.of_getPrivsmanager( )

//added by dan 1-30-07 to hide charges
iF lnv_privmanager.of_getUSerpermissionfromfn( "View Charges" ) <> 1 THEN
	this.of_hidecharges( )
END IF
end event

event itemchanged;call super::itemchanged;Boolean	lb_WasIntermodal
long ll_foundrow
decimal	lc_work
string ls_column, ls_address, ls_text, ls_user
s_co_info lstr_company
integer li_oldval_index  //This is a remnant of some very bad old code
n_cst_licensemanager	lnv_licensemanager
n_cst_ShipType	lnv_ShipType

String	ls_Label, &
			ls_StringFormat
Long		ll_NextValue

n_cst_ShipmentManager	lnv_ShipmentManager
n_cst_beo_Shipment lnv_Shipment
n_cst_Ship_type	lnv_ShipTypeManager

Long	ll_Return = 0
Long	ll_CoID
String	ls_CoName

ls_column = dwo.name

lnv_ShipTypeManager = THIS.Event ue_GetShipTypeManager ( )
lnv_Shipment = THIS.Event ue_GetShipment ( )


CHOOSE CASE ls_Column

CASE "ds_ref1_text", "ds_ref2_text", "ds_ref3_text"

	IF data = "X" THEN

		CHOOSE CASE ls_Column

		CASE "ds_ref1_text"
			ls_Label = lnv_Shipment.of_GetRef1Label ( )

		CASE "ds_ref2_text"
			ls_Label = lnv_Shipment.of_GetRef2Label ( )

		CASE "ds_ref3_text"
			ls_Label = lnv_Shipment.of_GetRef3Label ( )

		END CHOOSE


		CHOOSE CASE SQLCA.of_GetCustomSeriesValue ( "SHIPMENT", ls_Label, ll_NextValue, &
			ls_StringFormat, FALSE /*Don't Auto Insert if not set up previously*/, TRUE /*Commit*/ )
		
		CASE 1
			Data = String ( ll_NextValue )
			This.SetItem ( Row, ls_Column, Data )
			ll_Return = 2
		CASE -1
			IF MessageBox ( "Custom Series Value", "Could not determine the next series value.  Do you want to check "+&
				"the setup now?", Question!, YesNo! ) = 1 THEN

				OpenSheet ( w_CustomSeries_Setup, gnv_App.of_GetFrame ( ), 0, Original! )

			END IF

			RETURN 2   //Clear the value and leave.  We do NOT want this to flow through to the processing below.
		
		CASE ELSE  //Unexpected return value.
			IF MessageBox ( "Custom Series Value", "Unexpected return error attempting to determine the next series value.  "+&
				"Do you want to check the setup now?", Question!, YesNo! ) = 1 THEN
				OpenSheet ( w_CustomSeries_Setup, gnv_App.of_GetFrame ( ), 0, Original! )

			END IF
	
			RETURN 2   //Clear the value and leave.  We do NOT want this to flow through to the processing below.
		
		END CHOOSE

	ELSEIF Data = "XSETUP" THEN

		OpenSheet ( w_CustomSeries_Setup, gnv_App.of_GetFrame ( ), 0, Original! )
		RETURN 2   //Clear the value and leave.  We do NOT want this to flow through to the processing below.

	END IF

END CHOOSE



choose case ls_column
		
CASE "ds_ref1_text"
choose case this.object.ds_ref1_type[row]
		case 15
			this.object.masterbl[row] = data
		case 18
			this.object.booking[row] = data
		case 21
			this.object.seal[row] = data
		case 22
			this.object.forwarderref[row] = data
		case 24
			this.object.pickupnumber[row] = data
	end choose
//
	THIS.event ue_ref1textchanged( data )

case "ds_ref2_text"
	
	lnv_Shipment.of_SetRef2text( data )
	this.Event ue_Ref2TextChanged(lnv_Shipment )
	//sync value
	choose case this.object.ds_ref2_type[row]
		case 15
			this.object.masterbl[row] = data
		case 18
			this.object.booking[row] = data
		case 21
			this.object.seal[row] = data
		case 22
			this.object.forwarderref[row] = data
		case 24
			this.object.pickupnumber[row] = data
	end choose
	THIS.SetRedraw ( TRUE ) 
case "ds_ref3_text"
	
	lnv_Shipment.of_SetRef3text( data )
	this.Event ue_Ref3TextChanged(lnv_Shipment)
	//sync value
	choose case this.object.ds_ref3_type[row]
		case 15
			this.object.masterbl[row] = data
		case 18
			this.object.booking[row] = data
		case 21
			this.object.seal[row] = data
		case 22
			this.object.forwarderref[row] = data
		case 24
			this.object.pickupnumber[row] = data
	end choose
	THIS.SetRedraw ( TRUE ) 
	
case "ds_ship_type"
	
	Int li_Temp1
	li_Temp1 = THIS.Event ue_ShipTypeChanged( long(data) )
	
	IF li_Temp1 <> 1 THEN
		ll_Return = 2
	END IF


case "ds_ref1_type"
	lnv_Shipment.of_SetRef1Type ( Integer ( data ) )
	lnv_ShipmentManager.Post of_refTypeChanged ( 1 , lnv_Shipment )   
	
CASE	"ds_ref2_type"
	lnv_Shipment.of_SetRef2Type ( Integer ( data ) )
	lnv_ShipmentManager.Post of_refTypeChanged ( 2 , lnv_Shipment ) 
	
CASE "ds_ref3_type"
	lnv_Shipment.of_SetRef3Type ( Integer ( data ) )
	lnv_ShipmentManager.Post of_refTypeChanged ( 3 , lnv_Shipment ) 
												
case "ds_ship_date", "availableon", "availableuntil"
	parent.postevent("date_response", 0, ls_column)

case "ds_total_miles"
	this.object.ds_total_miles[row] = dec(data)
	
case "ds_lh_totamt"
	this.object.ds_lh_totamt[row] = dec(data)
	lnv_shipment.of_setfreightamount(dec(data))
	this.object.ds_bill_charge[row] = lnv_shipment.of_GetNetCharges ( )
	this.object.ds_disc_amt[row] = lnv_shipment.of_GetDiscountAmount ( )
	
case "ds_disc_amt"
	this.object.ds_disc_amt[row] = dec(data)
	this.object.ds_disc_pct[row] = 0
	lnv_shipment.of_setdiscountamount(dec(data))

	this.object.ds_bill_charge[row] = lnv_Shipment.of_GetNetCharges ( )
	this.object.ds_disc_pct[row] = lnv_Shipment.of_GetDiscountPercent ( )
	
case "ds_disc_pct"
	lc_work = dec(data)
	if lc_work >= 1 and lc_work < 100 then
		lc_work = round(lc_work / 100, 5)
	end if

	this.object.ds_disc_pct[row] = lc_work
	
	lnv_shipment.of_setdiscountPercent(lc_work)
	this.object.ds_disc_amt[row] = lnv_Shipment.of_Getdiscountamount ( )
	THIS.object.ds_bill_charge[row] = lnv_shipment.of_GetNetCharges ( )
	ll_Return = 2
case "ds_ac_totamt"
	this.object.ds_ac_totamt[row] = dec(data)
	lnv_shipment.of_setaccessorialamount(dec(data))
	this.object.ds_bill_charge[row] = lnv_shipment.of_GetNetCharges ( )
	
case "ds_bill_charge"
	this.object.ds_bill_charge[row] = dec(data)
	
case "ds_pay_lh_totamt"
	this.object.ds_pay_lh_totamt[row] = dec(data)
	lnv_Shipment.of_calculatepayable()
	this.object.ds_pay_totamt[row] = lnv_Shipment.of_getpayabletotal()
	
case "ds_pay_ac_totamt"
	this.object.ds_pay_ac_totamt[row] = dec(data)
	lnv_Shipment.of_calculatepayable()
	this.object.ds_pay_totamt[row] = lnv_Shipment.of_getpayabletotal()

case "ds_pay_totamt"
	this.object.ds_pay_totamt[row] = dec(data)
	
case "ds_salescom_amt"
	this.object.ds_salescom_amt[row] = dec(data)

								
case "ds_ppcol"
	lnv_Shipment.of_SetPrepaidcollect( data ) // zmc - 2-9-04 
	THIS.Post Event ue_PPcolChanged (  )

case "billto_name"
	if trim(data) = '?' then
		n_cst_beo_company	lnv_company
		
		if this.of_BilltoSpecial(lnv_company, lnv_shipment) > 0 then
			if lnv_company.of_GetBillSame() = "F" then
				THIS.SetItem ( 1, "billto_name" , lnv_company.of_getbillingname() )			
			else
				THIS.SetItem ( 1, "billto_name" , lnv_company.of_getname() )
			end if
			
			gnv_cst_companies.of_get_address(lnv_company.of_getId(), "BILLING_OR_WARNING!", &
				false, ls_address)
			//No checking is done here b.c. if it fails, ls_address is set to null, which is ok
			this.setitem(1, "billto_address", ls_address)
			
			lnv_Shipment.Of_SetBillToID ( lnv_company.of_getId()	)
			THIS.Event Post ue_BillToChanged (lnv_company.of_getId())
			
		END IF
		
		destroy lnv_company
		
	else
		Int	li_Temp
		if gnv_cst_companies.of_select(lstr_company, "BILLTO!", true, data, false, 0, false, true) = 1 then
			
			ll_CoID =  lstr_company.co_id
			
			IF ll_CoID > 0 THEN
				Long	ll_Length
				Select length (co_comments) into :ll_Length From companies where co_id = :ll_CoID;
				Commit;
				
				IF ll_Length > 0 THEN		
					ls_CoName = "*"		
				END IF
		
			END IF
			
			if lstr_company.co_bill_same = "F" then 
				ls_CoName += lstr_company.co_bill_name 
			else
				ls_CoName +=  lstr_company.co_name 
			end if
			
			li_Temp = THIS.SetItem ( 1, "billto_name" , ls_CoName )
			
	
			gnv_cst_companies.of_get_address(lstr_company.co_id, "BILLING_OR_WARNING!", &
				false, ls_address)
			//No checking is done here b.c. if it fails, ls_address is set to null, which is ok
			this.setitem(1, "billto_address", ls_address)
			//Using dot notation here doesn't display the new address without a setredraw
	
			lnv_Shipment.of_SetBilltoid (lstr_company.co_id )
			THIS.Event Post ue_BillToChanged ( lstr_company.co_id )
	
		else
			this.settext(substitute(this.object.billto_name[row], null_str, ""))
		end if
	end if
	
	ll_Return = 2

case "pay1_name"
	if gnv_cst_companies.of_select(lstr_company, "CARRIER_WITH_WARNINGS!", true, data, false, 0, false, true) = 1 then
		this.object.ds_pay1_id[1] = lstr_company.co_id
		this.object.pay1_name[1] = lstr_company.co_name
		
		//if dispatchedby not populated default to userid
		ls_user = this.object.dispatchedby[row]
		if len(trim(ls_user)) = 0 or isnull(ls_user) then
			this.object.dispatchedby[row] = gnv_app.of_getuserid()
		end if
		THIS.SetRedraw ( TRUE )
		
		THIS.Post event ue_CarrierChanged ( lstr_company.co_id )
		
	else
		this.settext(substitute(this.object.pay1_name[row], null_str, ""))
	end if
	ll_Return = 2

CASE "masterbl" 
	lnv_Shipment.of_SetMasterBL ( data )
	ll_Return = 2
CASE "booking"
	lnv_Shipment.of_SetBookingNumber ( data )
	ll_Return = 2
CASE "seal"
	lnv_Shipment.of_SetSeal ( data )
	ll_Return = 2
CASE "forwarderref"
	lnv_Shipment.of_SetForwarderRef ( data )
	ll_Return = 2
CASE	"pickupnumber"	
	lnv_Shipment.of_SetPickUpNumber ( data )
	ll_Return = 2
	
	

end choose

RETURN ll_Return
end event

event itemerror;call super::itemerror;n_cst_String	lnv_String
String			ls_ColumnType
Date				ld_Test
Time				lt_Test
Long				ll_Return 
Dec				lda_OldVals[]
string ls_column
decimal lc_work
long ll_limit
integer li_oldval_index

ll_Return = AncestorReturnValue

ls_column = dwo.name
data = trim(data)

CHOOSE CASE ls_column

case "ds_disc_pct"
	
	IF NOT isnumber(data) THEN
		lc_work = lnv_string.of_SpecialNumber(data)
		//if isnull(lc_work) then goto reject
	else
		lc_work = dec(data)
	end if
	
	IF NOT isNull ( lc_work ) THEN
		
		lc_work = round(lc_work, 5)
		if lc_work >= 0 and lc_work < 1 then
			
			li_oldval_index = upperbound(lda_OldVals) + 1
			lda_OldVals[li_oldval_index] = this.getitemdecimal(row, ls_column)
			this.setitem(row, ls_column, lc_work)
			THIS.postevent("ue_recalcamounts", li_oldval_index, ls_column)
			ll_Return = 3
			
		ELSEIF lc_work >= 1 and lc_work < 100 THEN
			
			lc_work = round(lc_work / 100, 5)
						
			IF lc_Work <> 100 THEN
			
				li_oldval_index = upperbound(lda_OldVals) + 1
				lda_OldVals[li_oldval_index] = this.getitemdecimal(row, ls_column)
				this.setitem(row, ls_column, lc_work)
				THIS.postevent("ue_recalcamounts", li_oldval_index, ls_column)
				ll_Return = 3
				
			END IF
		end if
	END IF
END CHOOSE


IF Upper ( String ( dwo.type ) )  = "COLUMN" THEN
	ls_ColumnType = dwo.colType
	
	CHOOSE CASE UPPER ( ls_ColumnType )
			
		CASE  "DATE" 
			ld_test = lnv_string.of_SpecialDate(data)
			if not isnull(ld_test) then
				this.setitem(row, String ( dwo.name ), ld_test)
				ll_Return = 3
				THIS.Event ue_SpecialDateTime ( dwo , row )
				THIS.event itemchanged( row , dwo, String ( ld_Test ) )
		//		parent.postevent("date_response", 0, ls_column)

			end if
			
		CASE "TIME"
			lt_Test = lnv_string.of_SpecialTime(data)
			if not isnull(lt_Test) then
				this.setitem(row, String ( dwo.name ), lt_Test)
				ll_Return = 3
				THIS.Event ue_SpecialDateTime ( dwo , row )
				THIS.event itemchanged( row , dwo, String ( lt_Test ) )
		//		parent.postevent("date_response", 0, ls_column)

			end if			
	END CHOOSE
END IF

RETURN ll_Return


end event

event clicked;call super::clicked;IF Row > 0 THEN
	IF dwo.Name = "po_info" THEN
		SetPointer ( HOURGLASS! )
		THIS.of_OpenAdminWindow  ( )
	END IF	
END IF
		

end event

on u_dw_shipinfo.create
call super::create
end on

on u_dw_shipinfo.destroy
call super::destroy
end on

