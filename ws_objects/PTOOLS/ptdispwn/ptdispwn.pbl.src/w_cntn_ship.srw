$PBExportHeader$w_cntn_ship.srw
forward
global type w_cntn_ship from window
end type
type st_7 from statictext within w_cntn_ship
end type
type sle_equipment from u_sle within w_cntn_ship
end type
type rb_other from radiobutton within w_cntn_ship
end type
type sle_cust from singlelineedit within w_cntn_ship
end type
type sle_pier from singlelineedit within w_cntn_ship
end type
type st_freight from statictext within w_cntn_ship
end type
type st_pier from statictext within w_cntn_ship
end type
type rb_export from radiobutton within w_cntn_ship
end type
type rb_import from radiobutton within w_cntn_ship
end type
type cb_cancel from commandbutton within w_cntn_ship
end type
type cb_ok from commandbutton within w_cntn_ship
end type
type st_2 from statictext within w_cntn_ship
end type
type st_1 from statictext within w_cntn_ship
end type
type cbx_p from checkbox within w_cntn_ship
end type
type cbx_d from checkbox within w_cntn_ship
end type
type rb_pd from radiobutton within w_cntn_ship
end type
type rb_rh from radiobutton within w_cntn_ship
end type
type gb_2 from groupbox within w_cntn_ship
end type
type gb_1 from groupbox within w_cntn_ship
end type
type gb_shiptype from groupbox within w_cntn_ship
end type
type gb_routetype from groupbox within w_cntn_ship
end type
end forward

global type w_cntn_ship from window
integer x = 1134
integer y = 348
integer width = 1266
integer height = 1316
boolean titlebar = true
string title = "New Intermodal Shipment"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
event type integer ue_newequipment ( string as_ref )
event type integer ue_setequipmentselection ( s_eq_info astr_equipment )
event type integer ue_clearequipmentselection ( )
event ue_processnewshipment ( )
event type integer ue_processequipment ( )
st_7 st_7
sle_equipment sle_equipment
rb_other rb_other
sle_cust sle_cust
sle_pier sle_pier
st_freight st_freight
st_pier st_pier
rb_export rb_export
rb_import rb_import
cb_cancel cb_cancel
cb_ok cb_ok
st_2 st_2
st_1 st_1
cbx_p cbx_p
cbx_d cbx_d
rb_pd rb_pd
rb_rh rb_rh
gb_2 gb_2
gb_1 gb_1
gb_shiptype gb_shiptype
gb_routetype gb_routetype
end type
global w_cntn_ship w_cntn_ship

type variables
protected:
n_cst_ship_type inv_cst_ship_type
s_co_info istr_pier, istr_cust
s_eq_info	istr_Equipment
Boolean	ib_HasEquipmentSelection
Boolean	ib_NoChassis
Long	il_EquipmentNumber
String	is_EqType
String	is_EqRef
end variables

forward prototypes
protected subroutine wf_process_company (singlelineedit asle_target)
public function integer wf_createnewequipment (string as_ref)
public function character wf_getmovetype ()
end prototypes

event ue_processnewshipment;Long		ll_Freight
Long		ll_Pier
Long		ll_ID
String	ls_Direction 
String	ls_Event1Label
String	ls_Event2Label

n_Cst_shipmentManager	lnv_Manager
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm


ll_Pier = istr_Pier.co_id 
ll_Freight = istr_Cust.co_id
ls_Direction = THIS.wf_getMoveType ( )

CHOOSE CASE ls_Direction
		
	CASE "E"
		ls_Direction = "EXPORT"
		ls_Event1Label = "PIER"
		ls_Event2Label = "FREIGHTLOC"		
	CASE "O"
		ls_Direction = "ONEWAY"
		ls_Event1Label = "HOOK"
		ls_Event2Label = "DROP"		
	CASE "I"
		ls_Direction = "IMPORT"
		ls_Event1Label = "PIER"
		ls_Event2Label = "FREIGHTLOC"	
END CHOOSE


lstr_Parm.is_Label = "PICKUP"
lstr_Parm.ia_Value = cbx_p.checked
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "DELIVER"
lstr_Parm.ia_Value = cbx_d.Checked
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "STYLE"
lstr_Parm.ia_Value = "CONTAINER!"
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "DIRECTION"
lstr_Parm.ia_Value = ls_Direction
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = ls_Event1Label
lstr_Parm.ia_Value = ll_Pier
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = ls_Event2Label
lstr_Parm.ia_Value = ll_Freight
lnv_Msg.of_Add_Parm ( lstr_Parm )



ll_ID = lnv_Manager.of_NewShipment ( lnv_Msg )

IF ll_ID > 0 THEN
	CLOSE ( THIS )
ELSE
	MessageBox ( "New Intermodal Shipment" , "An error occurred while attempting to create the shipment. Please Retry." )
END IF





//SETPOINTER ( HOURGLASS! )
//
//
//long ship_id, ev_id, item_id, ll_NewEquipmentId, newrow, ll_ship_type, &
//	ll_row, ll_pu_event, ll_del_event, ll_site
//string pronum, mod_log, ls_expedite, ls_MessageHeader, ls_Ref1Text, ls_ShipmentStatus, ls_accountingtype
//integer markloop, num_events, ship_seq, li_Ref1Type, li_amounttypeid
//char event_type
//s_co_info lstr_origin, lstr_findest
//n_cst_ShipmentManager lnv_ShipmentMgr
//n_cst_EquipmentManager lnv_EquipmentMgr
//Long	lla_Ids []
//long	lla_Companies[]
//Boolean	lb_NewEquipment, &
//			lb_MountsDismounts
//			
//TIME		lt_Duration
//Time		lt_Now
//Char		lc_MoveType
//Date		ld_Today
//String	ls_User
//
//
//n_cst_msg	lnv_Msg
//S_Parm		lstr_parm
//
////Time	lt_DestinationDuration
//
//
//n_cst_beo_Company	lnv_Company
//
//lnv_Company = CREATE n_cst_beo_Company
//
//ls_MessageHeader = THIS.Title
//ld_Today = Date ( DateTime ( Today ( ) )  )
//lt_Now	= Now ( )
//
//ls_User = gnv_App.of_GetUserId ( )
//
////If live load/unload is selected, make sure they've chosen either pickup or delivery
//
//if rb_pd.checked and not (cbx_p.checked or cbx_d.checked) then
//	messagebox( ls_MessageHeader, "You must indicate whether the Live Load / "+&
//		"Unload at the customer will involve a delivery, a pickup, or both.")
//	cbx_d.setfocus()
//	return
//end if
//
//
////If one way is selected, make sure they've chosen either Import or Export (not Other).
////Otherwise, we don't know which way it's going.
//
////IF rb_OneWay.Checked AND rb_Other.Checked THEN
////
////	MessageBox ( ls_MessageHeader, "You must choose either import or export with this option." )
////	gb_ShipType.SetFocus ( )
////	RETURN
////
////END IF
//
//
////Determine the number of events in the routing sequence
//
//num_events = 4
//
//if rb_pd.checked then
//	if not cbx_d.checked then num_events --
//	if not cbx_p.checked then num_events --
//
//ELSEIF rb_OneWay.Checked THEN
//	num_events = 2
//
//end if
//
//
////Determine the origin and destination indicators based on they type of move.
////Import shows pier to customer, Export shows customer to pier.
//
//if rb_import.checked and (rb_rh.checked or rb_OneWay.Checked or (rb_pd.checked and cbx_d.checked)) then
//	ll_pu_event = 1
//	ll_del_event = 2
//	lstr_origin = istr_pier
//	lstr_findest = istr_cust
//elseif rb_export.checked and (rb_rh.checked or rb_OneWay.Checked or (rb_pd.checked and cbx_p.checked)) then
//	ll_pu_event = num_events - 1
//	ll_del_event = num_events
//	lstr_origin = istr_cust
//	lstr_findest = istr_pier
//else
//	ll_pu_event = 1
//	ll_del_event = num_events
//	lstr_origin = istr_pier
//	lstr_findest = istr_pier
//end if
//
//lla_Companies = { lstr_origin.co_id , lstr_findest.co_id } 
//gnv_cst_companies.of_Cache ( lla_Companies , TRUE )
//
////Create shipment, item, event, and equipment entries.
//
////These are the parameters of gf_new_ship
//char dorb = "T"
//long brok_trip
//Long pay1_id
//brok_trip = null_long
//setnull(pay1_id)
//
//ls_expedite = "F"
//
//
////<<*>> changed from dispatch to intermodal
//choose case inv_cst_ship_type.of_find_default("INTERMODAL", ll_row)
//case 1
//	ll_ship_type = gds_shiptype.object.st_id[ll_row]
//	if gds_shiptype.object.st_expedite[ll_row] = "T" then ls_expedite = "T"
//case 0
//	setnull(ll_ship_type)
//case -1
//	goto failure
//end choose
//
//mod_log = string(today(), "m/d/yy") + "~t" + string(now(), "h:mmA/P") + "~t" +&
//	"CREATED~t~t" + ls_User + "~r~n"
//
//select max(ds_id) into :ship_id from disp_ship ;
//if sqlca.sqlcode <> 0 then goto rollitback
//if ship_id < 0 or isnull(ship_id) then ship_id = 0
//
//select max(de_id) into :ev_id from disp_events ;
//if sqlca.sqlcode <> 0 then goto rollitback
//if ev_id < 0 or isnull(ev_id) then ev_id = 0
//
//select max(di_item_id) into :item_id from disp_items ;
//if sqlca.sqlcode <> 0 then goto rollitback
//if item_id < 0 or isnull(item_id) then item_id = 0
//
//
////select Defaultduration into :lt_OriginDuration From companies where co_id = :lstr_origin.co_id;
////select Defaultduration into :lt_DestinationDuration From companies where co_id = :lstr_findest.co_id;
//
//ship_id ++
//ev_id ++
//item_id ++
//datastore	lds_Companies
//
//lds_companies = gnv_cst_companies.of_GetCache ( )
//lnv_Company.of_SetSource ( lds_Companies )
//
//pronum = string(ship_id, "0000") + "-TMP"
//
//SetNull ( ls_Ref1Text )
//li_Ref1Type = 0  //[None]
//
//lc_MoveType = THIS.wf_GetMoveType ( )
//ls_ShipmentStatus = gc_Dispatch.cs_ShipmentStatus_Open
//
//insert into disp_ship (ds_id, ds_pronum, ds_origin_id, ds_findest_id, ds_pay1_id, 
//	ds_expedite, ds_status, ds_brok_trip, ds_dorb, ds_mod_log, 
//	ds_ref1_type, ds_ref1_text, ds_ship_type, movecode , prenotedate , prenotetime , prenoteuser)
//values (:ship_id, :pronum, :lstr_origin.co_id, :lstr_findest.co_id, :pay1_id, :ls_expedite, 
//	:ls_ShipmentStatus, :brok_trip, :dorb, :mod_log, :li_Ref1Type, :ls_Ref1Text, :ll_ship_type, :lc_MoveType , :ld_Today ,
//	:lt_now , :ls_User ) ;
//
//if sqlca.sqlcode <> 0 then goto rollitback
//
//ship_seq = 1
//
//for markloop = 1 to 4
//	//IMPORTANT!!!  This is looping through the four POSSIBLE events to create, 
//	//not the 3 or 4 actual events to be created!!!  (Thus, the drop at the pier
//	//is always markloop = 4)
//
//
//	if markloop = 1 or (markloop = 3 and ( rb_rh.checked or rb_OneWay.Checked ) ) then
//
//		IF rb_OneWay.Checked THEN
//
//			IF markloop = 1 AND rb_Export.Checked THEN
//				CONTINUE
//			ELSEIF markloop = 3 AND rb_Import.Checked THEN
//				CONTINUE
//			END IF
//
//		END IF
//
//		IF lb_MountsDismounts THEN
//			event_type = "M"
//		ELSE
//			event_type = "H"
//		END IF
//
//	elseif markloop = 4 or (markloop = 2 and ( rb_rh.checked or rb_OneWay.Checked ) ) then
//
//		IF rb_OneWay.Checked THEN
//
//			IF markloop = 2 AND rb_Export.Checked THEN
//				CONTINUE
//			ELSEIF markloop = 4 AND rb_Import.Checked THEN
//				CONTINUE
//			END IF
//
//		END IF
//
//		IF lb_MountsDismounts THEN
//			event_type = "N"
//		ELSE
//			event_type = "R"
//		END IF
//
//	elseif markloop = 2 then
//		if cbx_d.checked then event_type = "D" else continue
//
//	elseif markloop = 3 then
//		if cbx_p.checked then event_type = "P" else continue
//
//	else
//		goto rollitback
//
//	end if
//
//	if markloop = 1 or markloop = 4 then
//		ll_site = istr_pier.co_id 
//		lnv_Company.of_SetSourceID ( ll_Site ) 
//		lt_Duration = lnv_Company.of_GetDefaultDuration ()
//		IF isNull ( lt_Duration ) THEN
//			lt_Duration = 00:30:00
//		END IF
//	else 
//		ll_site = istr_cust.co_id
//		lnv_Company.of_SetSourceID ( ll_Site ) 
//		lt_Duration = lnv_Company.of_GetDefaultDuration ()
//		IF isNull ( lt_Duration ) THEN
//			lt_Duration = 00:30:00
//		END IF
//	END IF
//	
//	insert into disp_events (de_id, de_event_type, de_site, de_shipment_id, de_ship_seq , de_duration )
//	values (:ev_id, :event_type, :ll_site, :ship_id, :ship_seq, :lt_Duration ) ;
//
//	if sqlca.sqlcode <> 0 then goto rollitback
//
//	ev_id ++
//	ship_seq ++
//next
//
////get default freight amount type
//n_cst_settings		lnv_settings
//any	la_value
//
//if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
//	li_amounttypeid = integer(la_value)
//else
//	li_amounttypeid = 0
//end if
//ls_accountingtype = n_cst_constants.cs_AccountingType_Both
//insert into disp_items (di_item_id, di_shipment_id, di_item_type, amounttype, accountingtype)
//values (:item_id, :ship_id, 'L', :li_amounttypeid, :ls_accountingtype) ;
//
//if sqlca.sqlcode <> 0 then goto rollitback
//
//commit ;
//if sqlca.sqlcode <> 0 then goto rollitback
//
//n_cst_beo_Shipment	lnv_Shipment
//lnv_Shipment = CREATE n_Cst_beo_Shipment
//
//n_cst_bso_Dispatch	lnv_Dispatch
//lnv_Dispatch = CREATE n_cst_bso_Dispatch
//
//lnv_Dispatch.of_RetrieveShipment ( ship_id )
//lnv_Shipment.of_setSource ( lnv_Dispatch.of_GetShipmentCache( ) )
//lnv_Shipment.of_setSourceID ( ship_id )
//lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
//lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetitemCache ( ) )
//lnv_Shipment.of_SetAllowFilterSet ( TRUE )
////lnv_Shipment.of_SetRef1Type ( 20 ) // cntn
//
//lnv_Shipment.of_CleanContactList (  ) // sets the contacts 
//
//lnv_Dispatch.Event pt_Save( )
//
//DESTROY ( lnv_Shipment ) 
//DESTROY ( lnv_Dispatch )
//
////IF lb_NewEquipment THEN
////	lnv_EquipmentMgr.of_Cache ( ll_NewEquipmentId, TRUE )
////END IF
//
//IF lnv_ShipmentMgr.of_Get_Retrieved_Ships( ) THEN
//	gf_Refresh ( "SHIP" )
//END IF
//
//lstr_Parm.is_Label = "INTERMODAL"
//lstr_Parm.ia_Value = TRUE
//lnv_Msg.of_Add_Parm ( lstr_Parm ) 
//
//lnv_ShipmentMgr.of_OpenShipment ( ship_id , lnv_Msg )
//
//DESTROY lnv_Company
//
//close(THIS)
//return
//
//rollitback:
//rollback ;
//
//failure:
//DESTROY lnv_Company
//
//IF lb_NewEquipment THEN
////	SetNull ( istr_Equipment.eq_Id )
//END IF
//
//messagebox( ls_MessageHeader, "Could not add shipment to database.~n~n"+&
//	"Please retry.", exclamation!)
//
//
//
//
//
//
//
end event

protected subroutine wf_process_company (singlelineedit asle_target);s_co_info lstr_company

if not isvalid(asle_target) then return

if gnv_cst_companies.of_select(lstr_company, "ANY!", true, asle_target.text, false, 0, false, true) = 1 then
	choose case asle_target
	case sle_pier
		istr_pier = lstr_company
	case sle_cust
		istr_cust = lstr_company
	end choose
	asle_target.text = substitute(lstr_company.co_name, null_str, "")
else
	choose case asle_target
	case sle_pier
		asle_target.text = substitute(istr_pier.co_name, null_str, "")
	case sle_cust
		asle_target.text = substitute(istr_cust.co_name, null_str, "")
	end choose
end if
end subroutine

public function integer wf_createnewequipment (string as_ref);S_Eq_info	lstr_NewEquipment
Int		li_Return = -1

n_cst_msg	lnv_msg
S_Parm		lstr_Parm	


lstr_NewEquipment.eq_Type = "34"  //Allow entry of TrailerChassis or Container
lstr_NewEquipment.eq_Ref = as_ref

//Indicate that we want to save the new equipment, not just pass the info out.
lstr_NewEquipment.eq_Id = 0  //Null = Pass info out, don't save ;  0 = Save new equipment

lstr_Parm.is_Label = "EQSTRUCT" 
lstr_Parm.ia_Value = lstr_NewEquipment
lnv_Msg.of_Add_Parm ( lstr_Parm )
	
openwithparm(w_eq_newout, lnv_Msg )
lstr_NewEquipment = Message.PowerObjectParm

IF lstr_NewEquipment.eq_Id > 0 THEN

	li_Return = 1
ELSE

	//User Cancelled
	li_Return = 0

END IF
RETURN li_Return

end function

public function character wf_getmovetype ();Char	lc_Rtn

SetNull ( lc_Rtn )

IF rb_export.Checked THEN
	lc_Rtn = "E"
ELSEIF rb_import.Checked THEN
	lc_Rtn = "I"
ELSE // other
	lc_Rtn = "O"
END IF


RETURN lc_Rtn
end function

on w_cntn_ship.create
this.st_7=create st_7
this.sle_equipment=create sle_equipment
this.rb_other=create rb_other
this.sle_cust=create sle_cust
this.sle_pier=create sle_pier
this.st_freight=create st_freight
this.st_pier=create st_pier
this.rb_export=create rb_export
this.rb_import=create rb_import
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_2=create st_2
this.st_1=create st_1
this.cbx_p=create cbx_p
this.cbx_d=create cbx_d
this.rb_pd=create rb_pd
this.rb_rh=create rb_rh
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_shiptype=create gb_shiptype
this.gb_routetype=create gb_routetype
this.Control[]={this.st_7,&
this.sle_equipment,&
this.rb_other,&
this.sle_cust,&
this.sle_pier,&
this.st_freight,&
this.st_pier,&
this.rb_export,&
this.rb_import,&
this.cb_cancel,&
this.cb_ok,&
this.st_2,&
this.st_1,&
this.cbx_p,&
this.cbx_d,&
this.rb_pd,&
this.rb_rh,&
this.gb_2,&
this.gb_1,&
this.gb_shiptype,&
this.gb_routetype}
end on

on w_cntn_ship.destroy
destroy(this.st_7)
destroy(this.sle_equipment)
destroy(this.rb_other)
destroy(this.sle_cust)
destroy(this.sle_pier)
destroy(this.st_freight)
destroy(this.st_pier)
destroy(this.rb_export)
destroy(this.rb_import)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cbx_p)
destroy(this.cbx_d)
destroy(this.rb_pd)
destroy(this.rb_rh)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_shiptype)
destroy(this.gb_routetype)
end on

event open;//Initialize blank company structures
gnv_cst_companies.of_get_info(null_long, istr_pier, false)
gnv_cst_companies.of_get_info(null_long, istr_cust, false)

Long	ll_Row 
IF inv_cst_ship_type.of_find_default("INTERMODAL", ll_row) <> 1 THEN
	MessageBox ( "Intermodal Shipment Type","Please designate a default intermodal shipment type in Shipment Type Setup before creating intermodal shipments." )
	CLOSE ( THIS ) 
	RETURN
END IF


  
end event

type st_7 from statictext within w_cntn_ship
boolean visible = false
integer x = 41
integer y = 1876
integer width = 544
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "E&quipment Number :"
boolean focusrectangle = false
end type

type sle_equipment from u_sle within w_cntn_ship
boolean visible = false
integer x = 590
integer y = 1872
integer width = 466
integer height = 84
integer taborder = 0
boolean autohscroll = true
integer limit = 15
integer accelerator = 113
end type

type rb_other from radiobutton within w_cntn_ship
integer x = 827
integer y = 232
integer width = 329
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "One &Way"
end type

event clicked;IF THIS.Checked THEN	
	cbx_d.Enabled = FALSE
	cbx_p.Enabled = FALSE
	cbx_d.Checked = FALSE
	cbx_p.Checked = FALSE
	rb_pd.Enabled = FALSE
	rb_rh.Enabled = FALSE
	sle_pier.SetFocus ( )
	st_pier.Text = "&Hook Loc.:"
	st_freight.Text = "Drop Lo&c.:"	
END IF
end event

type sle_cust from singlelineedit within w_cntn_ship
event getfocus pbm_ensetfocus
integer x = 402
integer y = 920
integer width = 745
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
textcase textcase = upper!
integer accelerator = 99
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;//Focus on this is not working.  I've tried several things.

boolean lb_advance

if getfocus() = cb_cancel then return
if keydown(keyenter!) then lb_advance = true

wf_process_company(this)

if lb_advance then
	Parent.SetFocus ( )
end if
end event

type sle_pier from singlelineedit within w_cntn_ship
integer x = 402
integer y = 812
integer width = 745
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
textcase textcase = upper!
integer accelerator = 114
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;boolean lb_advance

if getfocus() = cb_cancel then return
if keydown(keyenter!) or keydown(keytab!) then lb_advance = true

wf_process_company(this)
if lb_advance then sle_cust.post setfocus()
end event

type st_freight from statictext within w_cntn_ship
integer x = 82
integer y = 924
integer width = 389
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Freight Lo&c:"
boolean focusrectangle = false
end type

type st_pier from statictext within w_cntn_ship
integer x = 82
integer y = 820
integer width = 389
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pie&r / Ramp:"
boolean focusrectangle = false
end type

type rb_export from radiobutton within w_cntn_ship
integer x = 471
integer y = 232
integer width = 288
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Expor&t "
end type

event clicked;st_pier.Text = "Pie&r / Ramp:"
st_freight.Text = "Freight Lo&c:"

rb_pd.Enabled = THIS.Checked
rb_rh.Enabled = THIS.Checked
cbx_d.Enabled = rb_pd.Checked
cbx_p.Enabled = rb_pd.Checked
	
if cbx_d.checked and not cbx_p.checked then
	cbx_d.checked = false
	cbx_p.checked = true
end if
end event

type rb_import from radiobutton within w_cntn_ship
integer x = 160
integer y = 232
integer width = 279
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "&Import "
end type

event clicked;st_pier.Text = "Pie&r / Ramp:"
st_freight.Text = "Freight Lo&c:"

rb_pd.Enabled = THIS.Checked
rb_rh.Enabled = THIS.Checked
cbx_d.Enabled = rb_pd.Checked
cbx_p.Enabled = rb_pd.Checked
if cbx_p.checked and not cbx_d.checked then
	cbx_p.checked = false
	cbx_d.checked = true
end if
end event

type cb_cancel from commandbutton within w_cntn_ship
integer x = 658
integer y = 1096
integer width = 270
integer height = 88
integer taborder = 80
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_cntn_ship
integer x = 320
integer y = 1096
integer width = 270
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&OK"
end type

event clicked;SetPointer ( HOURGLASS! )

if rb_pd.checked and not (cbx_p.checked or cbx_d.checked) then
	messagebox( "New Shipment", "You must indicate whether the Live Load / "+&
		"Unload at the customer will involve a delivery, a pickup, or both.")
	cbx_d.setfocus()
	return
ELSE
	PARENT.EVENT ue_ProcessNewShipment ( )
end if


end event

type st_2 from statictext within w_cntn_ship
integer x = 379
integer y = 108
integer width = 466
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "want to create?"
boolean focusrectangle = false
end type

type st_1 from statictext within w_cntn_ship
integer x = 160
integer y = 40
integer width = 910
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Which type of shipment do you"
boolean focusrectangle = false
end type

type cbx_p from checkbox within w_cntn_ship
integer x = 581
integer y = 496
integer width = 325
integer height = 76
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "&Pickup "
end type

type cbx_d from checkbox within w_cntn_ship
integer x = 242
integer y = 496
integer width = 315
integer height = 76
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "&Deliver "
end type

type rb_pd from radiobutton within w_cntn_ship
integer x = 96
integer y = 420
integer width = 1042
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "&Live Load / Unload at Freight Location"
end type

event clicked;if cbx_p.enabled = false and cbx_p.checked = false and &
	cbx_d.enabled = false and cbx_d.checked = false then
		if rb_import.checked then
			cbx_d.checked = true
		elseif rb_export.checked then
			cbx_p.checked = true
		end if
end if

cbx_p.enabled = true
cbx_d.enabled = true
end event

type rb_rh from radiobutton within w_cntn_ship
integer x = 96
integer y = 600
integer width = 955
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Drop and Hoo&k at Freight Location"
boolean checked = true
end type

event clicked;cbx_p.enabled = false
cbx_d.enabled = false

cbx_p.checked = false
cbx_d.checked = false
end event

type gb_2 from groupbox within w_cntn_ship
integer x = 46
integer y = 748
integer width = 1147
integer height = 292
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_cntn_ship
boolean visible = false
integer x = 9
integer y = 1792
integer width = 1070
integer height = 200
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_shiptype from groupbox within w_cntn_ship
integer x = 46
integer y = 176
integer width = 1147
integer height = 148
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_routetype from groupbox within w_cntn_ship
integer x = 46
integer y = 344
integer width = 1147
integer height = 388
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

