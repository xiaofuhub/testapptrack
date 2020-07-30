$PBExportHeader$u_dw_shipment.sru
forward
global type u_dw_shipment from u_dw
end type
end forward

global type u_dw_shipment from u_dw
int Width=1952
int Height=444
string DataObject="d_shipmentlist"
event ue_rightclickontmp ( )
end type
global u_dw_shipment u_dw_shipment

event ue_rightclickontmp;// RDT 7-29-03 new
String	lsa_Parm_labels[]
Any		laa_Parm_Values[]
Boolean	lb_Imaging
Boolean	lb_notification
Long 		ll_index 

n_cst_msg 	lnv_Msg
s_Parm		lstr_Parm

n_cst_LicenseManager					lnv_LicenseManager
n_cst_bso_ImageManager_Pegasus	lnv_ImageManager  

lb_Imaging = lnv_LIcenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Imaging )

IF lb_Imaging  THEN

	ll_index ++
	lsa_parm_labels[ ll_index ] = "ADD_ITEM"
	laa_parm_values[ ll_index ] = "&Imaging"
	
	ll_index ++
	lsa_parm_labels[ ll_index ] = "ADD_ITEM"
	laa_parm_values[ ll_index ] = "Paste &Image"

	ll_index ++
	lsa_parm_labels [ ll_index ] = "XPOS"
	laa_parm_values [ ll_index ] = THIS.X + PointerX ( ) + 10
	ll_index ++
	lsa_parm_labels [ ll_index ] = "YPOS"
	laa_parm_values [ ll_index ] = THIS.Y + PointerY ( ) + 10

End if


CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
		CASE "IMAGING"
			
			Close(Parent)
			
			lstr_parm.is_label = "TOPIC"
			lstr_parm.ia_value = "SHIPMENT!"
			lnv_Msg.of_add_parm(lstr_parm)
		
			lstr_parm.is_label = "REQUEST"
			lstr_parm.ia_value = "IMAGES!"
			lnv_Msg.of_add_parm(lstr_parm)
		
			lstr_parm.is_label = "TARGET_ID"
			
			lstr_parm.ia_value = THIS.getitemNumber(this.GetRow(), "ds_id")

			lnv_Msg.of_add_parm(lstr_parm)
		
			f_process_standard(lnv_Msg)
			
		

	CASE "PASTE IMAGE"
			lnv_ImageManager = CREATE n_cst_bso_ImageManager_Pegasus
			lnv_ImageManager.of_PasteImage ( { THIS.getitemNumber(this.GetRow(), "ds_id") } )
	

End Choose
end event

event constructor;n_cst_ShipmentManager	lnv_ShipmentManager

This.Modify ( "ds_Status.Edit.CodeTable = Yes "+&
	"ds_Status.Values = '" + lnv_ShipmentManager.of_GetStatusCodeTable ( ) + "'" )

This.Event ue_setFocusIndicator ( TRUE )
end event

event ue_autosort;call super::ue_autosort;Int	li_Return

li_Return = AncestorReturnValue

IF li_Return = 1 AND isValid (inv_sort) THEN
	inv_sort.of_SetExclude ( {"cf_freighttotal","cf_accessorialtotal","cf_billingcharges"})
END IF

RETURN li_Return 
end event

event ue_autofilter;call super::ue_autofilter;Int li_Return
li_Return = AncestorReturnValue

IF li_Return = 1 AND isValid (inv_filter) THEN
	inv_filter.of_SetExclude ( {"cf_freighttotal","cf_accessorialtotal","cf_billingcharges"})
END IF

RETURN li_Return 
end event

event rbuttondown;call super::rbuttondown;
Long	ll_ID

CHOOSE CASE   dwo.name
		
	CASE "ds_id" 
		THIS.Event ue_RightclickonTmp ( )
		
END CHOOSE



RETURN ancestorReturnValue
end event

