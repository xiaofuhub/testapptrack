$PBExportHeader$w_search.srw
$PBExportComments$PT Data, Sheet
forward
global type w_search from w_sheet
end type
type uo_autorate from u_cst_autoratecombined within w_search
end type
type cb_arbatch from commandbutton within w_search
end type
type cbx_radius from checkbox within w_search
end type
type cb_bill from commandbutton within w_search
end type
type uo_radius from u_radius_ship within w_search
end type
type st_1 from statictext within w_search
end type
type st_no_match from statictext within w_search
end type
type cb_search from commandbutton within w_search
end type
type cb_clear from commandbutton within w_search
end type
type st_range from statictext within w_search
end type
type st_label from statictext within w_search
end type
type dw_search from datawindow within w_search
end type
type ddlb_ship_display from dropdownlistbox within w_search
end type
type ddlb_trip_display from dropdownlistbox within w_search
end type
type dw_ship_list from u_dw_shipmentlist within w_search
end type
type dw_trip_list from u_dw_triplist within w_search
end type
type cbx_retrieveextended from checkbox within w_search
end type
type gb_1 from groupbox within w_search
end type
end forward

global type w_search from w_sheet
integer width = 3662
integer height = 2096
string title = "Search"
string menuname = "m_search"
long backcolor = 12632256
event reset_range pbm_custom01
event ue_radiusrestriction ( )
event type long ue_shipmentsearch ( string as_whereclause )
event ue_mousemove pbm_ncmousemove
event ue_details ( )
event ue_autorateon ( )
event ue_autorateoff ( )
uo_autorate uo_autorate
cb_arbatch cb_arbatch
cbx_radius cbx_radius
cb_bill cb_bill
uo_radius uo_radius
st_1 st_1
st_no_match st_no_match
cb_search cb_search
cb_clear cb_clear
st_range st_range
st_label st_label
dw_search dw_search
ddlb_ship_display ddlb_ship_display
ddlb_trip_display ddlb_trip_display
dw_ship_list dw_ship_list
dw_trip_list dw_trip_list
cbx_retrieveextended cbx_retrieveextended
gb_1 gb_1
end type
global w_search w_search

type variables
protected:
int mboxret
string search_type, ship_select, trip_select, print_list
n_cst_ship_type inv_cst_ship_type

private:
Boolean	ib_HasResultSet = FALSE
Boolean	ib_RadiusMode = FALSE
end variables

forward prototypes
public function integer wf_sendtobilling ()
protected subroutine wf_arbatch ()
public function integer wf_resendedi ()
public function long wf_getcompanyid ()
public function boolean wf_criteriainput ()
end prototypes

event reset_range;integer frop, lrop, numrows

if search_type = "T" then
	numrows = dw_trip_list.rowcount()
	if numrows > 0 then
		frop = integer(dw_trip_list.describe("datawindow.firstrowonpage"))
		lrop = integer(dw_trip_list.describe("datawindow.lastrowonpage"))
	end if
//else
//	numrows = dw_ship_list.rowcount()
//	if numrows > 0 then
//		frop = integer(dw_ship_list.describe("datawindow.firstrowonpage"))
//		lrop = integer(dw_ship_list.describe("datawindow.lastrowonpage"))
//	end if
end if

st_range.text = string(frop) + " to " + string(lrop) + " of " + string(numrows)
end event

event ue_radiusrestriction;This.SetRedraw ( FALSE )

IF ib_RadiusMode THEN

	uo_Radius.of_Unapply ( )

	dw_Ship_List.Height += 160
	dw_Ship_List.Y -= 160

	dw_Trip_List.Height += 160
	dw_Trip_List.Y -= 160

ELSE

	dw_Ship_List.Height -= 160
	dw_Ship_List.Y += 160

	dw_Trip_List.Height -= 160
	dw_Trip_List.Y += 160

END IF

ib_RadiusMode = NOT ib_RadiusMode
uo_Radius.Visible = ib_RadiusMode

This.SetRedraw ( TRUE )

IF ib_RadiusMode THEN
	uo_Radius.gb_StopType.SetFocus ( )
END IF
end event

event ue_shipmentsearch;String	ls_Select
Long		ll_RowCount
n_cst_String	lnv_String

Long		ll_Return = 0

//Prepare any single quotes to be included in the Modify statement using tildes//as_WhereClause = lnv_String.of_GlobalReplace ( as_WhereClause, "'", "~~'" )

IF ll_Return = 0 THEN
	ls_Select = ship_select + " " + as_WhereClause
	dw_ship_list.modify("datawindow.table.select = '" + ls_Select + "'")
END IF


IF ll_Return = 0 THEN

	ll_RowCount = dw_ship_list.retrieve()
	commit ;

	CHOOSE CASE ll_RowCount

	CASE IS >= 0
		ll_Return = ll_RowCount

	CASE ELSE
		messagebox("Perform Search", "Error executing search request.")
		ll_Return = -1

	END CHOOSE


	if ll_RowCount > 0 then
		st_no_match.visible = false
	else
		st_no_match.visible = true
	end if

end if

ib_HasResultSet = TRUE
this.postevent("reset_range")

RETURN ll_Return
end event

event ue_mousemove;IF  ypos - THIS.Height  > -200 THEN
	IF dw_Ship_List.Visible = TRUE THEN
	
		IF isValid ( dw_ship_list.inv_Mediator ) THEN
			dw_ship_list.inv_Mediator.of_ShowDataManager ( )
		END IF
		
	ELSEIF dw_trip_list.Visible = TRUE THEN
		
		IF isValid ( dw_ship_list.inv_Mediator ) THEN
			dw_trip_list.inv_Mediator.of_ShowDataManager ( )
		END IF
		
	END IF
	
END IF
end event

event ue_details;n_cst_ShipmentManager	lnv_ShipmentMgr
long selrow, selid

if search_type = "T" then
	selrow = dw_trip_list.getselectedrow(0)
	if selrow < 1 then
		mboxret = 1
		messagebox("Show Trip Details", "No trip is selected.")
		return
	end if
	selid = dw_trip_list.getitemnumber(selrow, "bt_id")
	if selid < 1 then return
	lnv_ShipmentMgr.of_OpenTrip ( selid )
//else
//	dw_Ship_List.Event ue_ShipmentDetail ( 0 )
end if
end event

event ue_autorateon();IF dw_ship_list.Visible THEN
	dw_search.Enabled = FALSE
	cb_arbatch.Enabled = FALSE
	cb_bill.Enabled = FALSE
	cb_clear.Enabled = FALSE
	cb_search.Enabled = FALSE
	cbx_radius.Enabled = FALSE
	cbx_retrieveextended.Enabled = FALSE
	uo_radius.Enabled = FALSE
	uo_autorate.of_Setsource( dw_ship_list )
	uo_autorate.visible = TRUE
	uo_autorate.event ue_autorateon( )
ELSE 
	MessageBox ("Auto Rate Combined Freight" , "Trips cannot be Auto Rated in this manner." )
	
END IF
end event

event ue_autorateoff();dw_search.Enabled = TRUE
cb_arbatch.Enabled = TRUE
cb_bill.Enabled = TRUE
cb_clear.Enabled = TRUE
cb_search.Enabled = TRUE
cbx_radius.Enabled = TRUE
cbx_retrieveextended.Enabled = TRUE
uo_radius.Enabled = TRUE


uo_autorate.visible = FALSE
end event

public function integer wf_sendtobilling ();n_Cst_msg	lnv_Msg
S_Parm		lstr_Parm

Long			lla_ShipmentIds[]


dw_ship_list.event ue_getselectedids( lla_ShipmentIds )

IF UpperBound ( lla_ShipmentIds ) > 0 THEN
	lstr_Parm.ia_Value = lla_ShipmentIds
	lstr_Parm.is_label = "SHIPMENTIDS"
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	opensheetWithParm(w_billing, lnv_Msg ,gnv_App.of_GetFrame ( ), 0, original!)
ELSE
	MessageBox ( "Send to Billing" , "Please select the shipments to send to billing." )
END IF
RETURN 1
end function

protected subroutine wf_arbatch ();/*
	Take the first selected row. Find its AR batch number and then get all of the 
	shipments that belong to that batch.	
*/

string		ls_type = 'INVOICE!', &
				ls_pronum
String		ls_Validated
Boolean		lb_NoBatch
n_Cst_msg	lnv_Msg
S_Parm		lstr_Parm

Long			lla_ShipmentIds[], &
				lla_blank[], &
				ll_shipid, &
				ll_ARBatch, &
				ll_rowcount, &
				ll_row, &
				ll_return=1

n_ds				lds_arbatch

n_cst_Billing	lnv_Billing

dw_ship_list.event ue_getselectedids( lla_ShipmentIds )

if upperbound(lla_ShipmentIds) = 0 then
	ll_Return = -1
else
	
	ll_shipid = lla_ShipmentIds[1]
	
	  SELECT "join_dispship_arbatch"."arbatchid"  
    INTO :ll_arbatch  
    FROM "join_dispship_arbatch"  
   WHERE "join_dispship_arbatch"."dispshipid" = :ll_shipid;

	choose case SQLCA.sqlcode
		case 0
			//success
		case else
			ll_Return = -1
	end choose
	
	commit	;
	
end if

if ll_Return = 1 then
	
	lds_arbatch = create n_ds
	lds_arbatch.dataobject = 'd_arbatch'
	lds_arbatch.SetTransObject(SQLCA)
	ll_rowcount = lds_arbatch.retrieve(ll_arbatch)
	lla_ShipmentIds = lla_blank
	for ll_row = 1 to ll_rowcount
		lla_ShipmentIds[ll_row] = lds_arbatch.object.dispshipid[ll_row]
		ls_Validated = lds_arbatch.object.validated[ll_row]
		IF ls_Validated = "F" THEN
			lb_NoBatch = TRUE
		END IF
	next
	IF Not lb_NoBatch THEN
		IF UpperBound ( lla_ShipmentIds ) > 0 THEN
			
			//nwl - 12/14/04 wasn't setting correct invoice type
			//check invoice type
			lnv_Billing = create n_cst_billing
			
			ll_row = dw_ship_list.find('ds_id = ' + string(lla_ShipmentIds[1]), 1, dw_ship_list.rowcount( ) )
			
			if ll_row > 0 then
				ls_pronum = dw_ship_list.object.Shipment_InvoiceNumber[ll_row]
			
				if lnv_Billing.of_manifest_extract(ls_pronum) then
					ls_type = 'MANIFEST!'
				else
					ls_type = 'INVOICE!'
				end if
			end if
			
			destroy	lnv_Billing
			//end type checking
			
			lstr_Parm.ia_Value = lla_ShipmentIds
			lstr_Parm.is_label = "SHIPMENTIDS"
			lnv_Msg.of_Add_Parm ( lstr_Parm )
		
			lstr_Parm.is_label = "ARBATCH"
			lnv_Msg.of_Add_Parm ( lstr_Parm )
		
			lstr_Parm.ia_Value = ls_type
			lstr_Parm.is_label = "TYPE"
			lnv_Msg.of_Add_Parm ( lstr_Parm )
	
			IF IsValid(w_billing) THEN
				MessageBox ( "AR Batch" , "You cannot have the Billing window already open. Please close and try again." )
			ELSE				
				opensheetWithParm(w_billing, lnv_Msg ,gnv_App.of_GetFrame ( ), 0, original!)
			END IF
		ELSE
			MessageBox ( "AR Batch" , "Please select a shipment(invoice) for the batch." )
		END IF
	else
		/** Temporary until we can validate these batches **/
		MessageBox ( "AR Batch" , "The selected shipment(invoice) is not part of an AR batch. " +&
					"This functionality is only available for batches that have been exported from " +&
					"Profit Tools Version 3.9 or later")
	end if
else
	MessageBox ( "AR Batch" , "The selected shipment(invoice) is not part of an AR batch. " +&
					"This functionality is only available for batches that have been exported from " +&
					"Profit Tools Version 3.9 or later")

end if
end subroutine

public function integer wf_resendedi ();//written By dan 5-8-2006,  This is here to pick the first selected rows company and sned them
//to them to the billing window.  It will populate that window with the first selected companies
//batch files.

int li_return
Long	ll_index
Long	ll_max
Long	ll_tmp
//Long	ll_billtoId
Long	ll_arBatch
Long	ll_coId
n_Cst_msg	lnv_Msg
S_Parm		lstr_Parm
n_ds			lds_arbatch
Long			lla_ShipmentIds[]
Long			lla_blank[]

li_return  = 1

dw_ship_list.event ue_getselectedids( lla_ShipmentIds )

ll_index = dw_ship_list.getRow()//dw_ship_list.getselectedrow(ll_index)

//get the bill to id of the first selected shipment.  Find out the batch number as well
//Get all the shipments that are a part of that batch with the same bill to Id.
IF ll_index > 0 THEN
	ll_tmp = dw_ship_list.getItemNumber( ll_index, "ds_id" )
	
	//i do imbedded sql because when I did a get item nubmer it didn't recognize the column ds_billto_id.  
	//This is probalby because the data object/psr for the datawindow isn't defined.
	ll_coid = this.wf_getcompanyid( )
	
	IF li_return = 1 THEN
	//get the batch number
		SELECT "join_dispship_arbatch"."arbatchid"  
		 INTO :ll_arbatch  
		 FROM "join_dispship_arbatch"  
		WHERE "join_dispship_arbatch"."dispshipid" = :ll_tmp;
	
		choose case SQLCA.sqlcode
			case 0 
				//success
				li_return = 1
			CASE 100
				MessageBox("Resend EDI", "The selected shipment(invoice) is not part of an AR batch. " +&
					"This functionality is only available for batches that have been exported from " +&
					"Profit Tools Version 3.9 or later", exclamation!)
				li_return = -1
			case else
				li_Return = -1
		end choose
		
		commit	;
	END IF
END IF

//retrieve everything in that batch, and filter it down to 
if li_Return = 1 then
	
	lds_arbatch = create n_ds
	lds_arbatch.dataobject = 'd_resendBatchEdi'
	lds_arbatch.SetTransObject(SQLCA)
	ll_max = lds_arbatch.retrieve(ll_coid, ll_arbatch)
	lla_ShipmentIds = lla_blank
	for ll_index = 1 to ll_max
		lla_ShipmentIds[ll_index] = lds_arbatch.object.ds_id[ll_index]
	next
	
END IF
IF li_Return > 0 THEN
	IF UpperBound ( lla_ShipmentIds ) > 0 THEN
		lstr_Parm.ia_Value = lla_ShipmentIds
		lstr_Parm.is_label = "SHIPMENTIDS"
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_label = "RESENDEDI"
		lnv_Msg.of_add_parm( lstr_parm )
		
		opensheetWithParm(w_billing, lnv_Msg ,gnv_App.of_GetFrame ( ), 0, original!)
	ELSE
		MessageBox ( "Send to Billing" , "Please select the shipments to send to billing." )
	END IF
END IF

IF isValid(lds_arbatch ) THEN
	DESTROY lds_arbatch 
END IF

RETURN li_return
end function

public function long wf_getcompanyid ();//Written by dan REturns the first selected company id
Long	ll_index
Long	ll_tmp
Long	ll_billToId
Long	ll_return

ll_index = dw_ship_list.getselectedrow( 0 )

IF ll_index > 0 THEN
	ll_tmp = dw_ship_list.getItemNumber( ll_index, "ds_id" )
	
	//i do imbedded sql because when I did a get item nubmer it didn't recognize the column ds_billto_id.  
	//This is probalby because the data object/psr for the datawindow isn't defined.
	Select ds_billto_id
	INTO :ll_billToId
	FROM disp_ship 
	WHERE ds_id = : ll_tmp;
	COMMIT;
	
	CHOOSE CASE SQLCA.sqlcode
		CASE 0 
			ll_return = ll_billToId
		CASE ELSE
			ll_return = -1
	END CHOOSE
ELSE
	ll_return = -1
END IF

RETURN ll_return
end function

public function boolean wf_criteriainput ();Boolean	lb_CriteriaInput

String 	ls_RefType, &
			ls_RefText, &
			ls_Date1, &
			ls_Date2, &
			ls_Co2Type, &
			ls_Site1Type, &
			ls_Site2Type, &
			ls_RefNum2


Date 		ld_Date1, &
			ld_Date2

Long 		ll_ship_type, &
			ll_CoId, &
			ll_Co2Id, &
			ll_Site1Id, &
			ll_Site2Id, &
			ll_ShipType

IF NOT lb_CriteriaInput THEN
	ll_ship_type = dw_search.getitemnumber(1, "ss_ship_type")
	IF NOT isNull(ll_Ship_Type) AND ll_Ship_Type > 0 THEN
	 	lb_CriteriaInput = TRUE
	END IF
END IF

IF NOT lb_CriteriaInput THEN
	ls_RefText = trim(dw_search.getitemstring(1, "ss_ref_num"))
	IF NOT isNull(ls_RefText) AND Len(ls_RefText) > 0 THEN
		lb_CriteriaInput = TRUE
	END IF
END IF

IF NOT lb_CriteriaInput THEN
	ls_RefNum2 = trim(dw_search.getitemstring(1, "ss_ref_num2"))
	IF NOT isNull(ls_RefNum2) AND Len(ls_RefNum2) > 0 THEN
		lb_CriteriaInput = TRUE
	END IF
END IF

IF NOT lb_CriteriaInput THEN
	ld_Date1 = dw_search.getitemdate(1, "ss_date_1")
	IF NOT isNull(ld_Date1) THEN
		lb_CriteriaInput = TRUE
	END IF
END IF

IF NOT lb_CriteriaInput THEN
	ld_Date2 = dw_search.getitemdate(1, "ss_date_2")
	IF NOT isNull(ld_Date2) THEN
		lb_CriteriaInput = TRUE
	END IF
END IF

IF NOT lb_CriteriaInput THEN
	ll_ShipType = dw_search.getitemnumber(1, "ss_ship_type")
	IF NOT isNull(ll_shipType) AND ll_ShipType > 0 THEN
		lb_CriteriaInput = ll_ShipType > 0
	END IF
END IF

IF NOT lb_CriteriaInput THEN
	ll_CoId = dw_search.getitemnumber(1, "ss_co")
	IF NOT isNull(ll_CoId) AND ll_CoId > 0 THEN
		lb_CriteriaInput = TRUE
	END IF
END IF

IF NOT lb_CriteriaInput THEN
	ll_Co2Id = dw_search.getitemnumber(1, "ss_co2")
	IF NOT isNull(ll_Co2Id) AND ll_Co2Id > 0 THEN
		lb_CriteriaInput = TRUE
	END IF
END IF

IF NOT lb_CriteriaInput THEN
	ll_Site1Id = dw_search.getitemnumber(1, "ss_site_1")
	IF NOT isNull(ll_Site1Id) AND ll_Site1Id > 0 THEN
		lb_CriteriaInput = TRUE
	END IF
END IF

IF NOT lb_CriteriaInput THEN
	ll_Site2Id = dw_search.getitemnumber(1, "ss_site_2")
	IF NOT isNull(ll_Site2Id) AND ll_Site2Id > 0 THEN
		lb_CriteriaInput = TRUE
	END IF
END IF

Return lb_CriteriaInput
end function

event open;call super::open;dwobject ldwo_type
integer li_setloop
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
String		ls_WhereClause

//The window may be opened either with or without a message object.
//At present, the message object is used to provide a ShipmentWhereClause, 
//if we want the window to open with a list of shipments displayed.

//If a message object was passed in, grab it.
IF IsValid ( Message.PowerObjectParm ) THEN
	IF Lower ( Message.PowerObjectParm.ClassName ( ) ) = "n_cst_msg" THEN
		lnv_Msg = Message.PowerObjectParm
	END IF
END IF

//CHANGED BY DAN  COMMENTED OUT GF MASK MENU BECUASE I CHANGED THE MENU TO M_SEARCH
//AND IT USED TO BE M_SHEETS.
//gf_mask_menu(m_sheets)
/////////////////////////////////////////

//Commented for Custom View revision.
//This is now handled in u_dw_ShipmentList.ue_ChangeView
//
//n_cst_ShipmentManager	lnv_ShipmentMgr
//lnv_ShipmentMgr.of_PopulateReferenceLists ( dw_Ship_List )
//
/////////////////////////////////
////Populate shipment type list
//
//n_cst_Ship_Type			lnv_ShipType
//DWObject						ldwo_ShipType
//
//ldwo_ShipType = dw_Ship_List.Object.Shipment_ShipTypeId
//lnv_ShipType.of_Populate ( ldwo_ShipType )
//DESTROY ldwo_ShipType

///////////////////////////////

dw_trip_list.settransobject(sqlca)
dw_ship_list.settransobject(sqlca)
dw_search.settransobject(sqlca)
//dw_bills.settransobject(sqlca)

dw_search.insertrow(0)
search_type = "SE"
ldwo_type = dw_search.object.ss_type
dw_search.event trigger itemchanged(1, ldwo_type, "SE")
destroy ldwo_type

ship_select = dw_ship_list.describe("datawindow.table.select")
trip_select = dw_trip_list.describe("datawindow.table.select")
trip_select = replace(trip_select, pos(trip_select, "WHERE"), 9999, "")

ddlb_ship_display.selectitem(1)
ddlb_trip_display.selectitem(1)

dw_ship_list.setsort("shipment_invoicenumber A")
dw_trip_list.setsort("bt_tripnum A")

//Check the message object for possible parameters being passed in.

IF lnv_Msg.of_Get_Parm ( "ShipmentWhereClause", lstr_Parm ) > 0 THEN
	//Load the shipment list using the where clause provided.
	ls_WhereClause = lstr_Parm.ia_Value
	This.Event Post ue_ShipmentSearch ( ls_WhereClause )
END IF

THIS.of_SetResize ( TRUE )
//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_Register ( dw_ship_list , 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( dw_trip_list , 'ScaleToRight&Bottom' )


end event

on w_search.create
int iCurrent
call super::create
if this.MenuName = "m_search" then this.MenuID = create m_search
this.uo_autorate=create uo_autorate
this.cb_arbatch=create cb_arbatch
this.cbx_radius=create cbx_radius
this.cb_bill=create cb_bill
this.uo_radius=create uo_radius
this.st_1=create st_1
this.st_no_match=create st_no_match
this.cb_search=create cb_search
this.cb_clear=create cb_clear
this.st_range=create st_range
this.st_label=create st_label
this.dw_search=create dw_search
this.ddlb_ship_display=create ddlb_ship_display
this.ddlb_trip_display=create ddlb_trip_display
this.dw_ship_list=create dw_ship_list
this.dw_trip_list=create dw_trip_list
this.cbx_retrieveextended=create cbx_retrieveextended
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_autorate
this.Control[iCurrent+2]=this.cb_arbatch
this.Control[iCurrent+3]=this.cbx_radius
this.Control[iCurrent+4]=this.cb_bill
this.Control[iCurrent+5]=this.uo_radius
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_no_match
this.Control[iCurrent+8]=this.cb_search
this.Control[iCurrent+9]=this.cb_clear
this.Control[iCurrent+10]=this.st_range
this.Control[iCurrent+11]=this.st_label
this.Control[iCurrent+12]=this.dw_search
this.Control[iCurrent+13]=this.ddlb_ship_display
this.Control[iCurrent+14]=this.ddlb_trip_display
this.Control[iCurrent+15]=this.dw_ship_list
this.Control[iCurrent+16]=this.dw_trip_list
this.Control[iCurrent+17]=this.cbx_retrieveextended
this.Control[iCurrent+18]=this.gb_1
end on

on w_search.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_autorate)
destroy(this.cb_arbatch)
destroy(this.cbx_radius)
destroy(this.cb_bill)
destroy(this.uo_radius)
destroy(this.st_1)
destroy(this.st_no_match)
destroy(this.cb_search)
destroy(this.cb_clear)
destroy(this.st_range)
destroy(this.st_label)
destroy(this.dw_search)
destroy(this.ddlb_ship_display)
destroy(this.ddlb_trip_display)
destroy(this.dw_ship_list)
destroy(this.dw_trip_list)
destroy(this.cbx_retrieveextended)
destroy(this.gb_1)
end on

type uo_autorate from u_cst_autoratecombined within w_search
boolean visible = false
integer x = 46
integer y = 40
integer width = 3506
integer height = 492
integer taborder = 60
end type

event ue_stop;call super::ue_stop;Parent.event ue_autorateoff( )
end event

on uo_autorate.destroy
call u_cst_autoratecombined::destroy
end on

type cb_arbatch from commandbutton within w_search
integer x = 3159
integer y = 400
integer width = 375
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "AR Batch"
end type

event clicked;Parent.wf_ARBatch( )
end event

type cbx_radius from checkbox within w_search
integer x = 55
integer y = 584
integer width = 571
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "&Radius Restriction"
end type

event clicked;Parent.Event ue_RadiusRestriction ( )
end event

type cb_bill from commandbutton within w_search
integer x = 3159
integer y = 300
integer width = 375
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Bill Selected"
end type

event clicked;Parent.wf_Sendtobilling( )
end event

type uo_radius from u_radius_ship within w_search
event destroy ( )
boolean visible = false
integer y = 664
integer taborder = 90
end type

on uo_radius.destroy
call u_radius_ship::destroy
end on

event constructor;//Set target columns 
This.of_SetPickupColumn ( "Origin_Id", "COMPANY!" )
This.of_SetDeliveryColumn ( "Destination_Id", "COMPANY!" )

//Set target dw
This.of_Set_Target ( dw_Ship_List )
end event

type st_1 from statictext within w_search
integer x = 2711
integer y = 580
integer width = 256
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Displ&ay:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_no_match from statictext within w_search
boolean visible = false
integer x = 1531
integer y = 1068
integer width = 549
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "No Matches Found"
boolean focusrectangle = false
end type

type cb_search from commandbutton within w_search
integer x = 3159
integer y = 92
integer width = 375
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Search"
end type

event clicked;String 	ls_Select, &
			ls_Message, &
			ls_Work, &
			ls_Status, &
			ls_RefType, &
			ls_TripRefType, &
			ls_RefText, &
			ls_ReverseRouting, &
			ls_DateType, &
			ls_RangeType, &
			ls_Date1, &
			ls_Date2, &
			ls_TypeList, &
			ls_Category, &
			ls_Co2Type, &
			ls_Site1Type, &
			ls_Site2Type, &
			ls_SubSelect, &
			ls_RefNum2

Integer	li_DaysInRange

Date 		ld_Date1, &
			ld_Date2

Long 		ll_ship_type, &
			ll_CoId, &
			ll_Co2Id, &
			ll_Site1Id, &
			ll_Site2Id, &
			ll_billtoid, &
			ll_ndx, &
			ll_rowcount

Boolean	lb_valid

n_cst_String	lnv_String

String	ls_MessageHeader = "Perform Search"

if dw_search.accepttext() = -1 then return

if ib_HasResultSet = TRUE then goto retrieval

//Warn user if there is no search criteria
IF NOT Parent.wf_CriteriaInput( )  THEN
	IF MessageBox(ls_MessageHeader, "Are you sure you want to perform the search with no criteria?~r~n" + &
			  "This operation could take several minutes.", Question!, YesNo!, 2) = 2 THEN
			  Return
	END IF
END IF			
				  
ll_ship_type = dw_search.getitemnumber(1, "ss_ship_type")
ls_Status = dw_search.getitemstring(1, "ss_status")
ls_RefType = dw_search.getitemstring(1, "ss_ref_type")
ls_TripRefType = dw_search.getitemstring(1, "ss_trip_ref_type")
ls_RefText = lnv_String.of_GlobalReplace ( trim(dw_search.getitemstring(1, "ss_ref_num")), "*", "%" )
	//Substitute the SQL wildcard "%" for "*" so the user can use "*"
ls_RefNum2 = trim(dw_search.getitemstring(1, "ss_ref_num2"))
ls_ReverseRouting = dw_search.getitemstring(1, "ss_site_type")
ls_DateType = dw_search.getitemstring(1, "ss_date_type")
ls_RangeType = dw_search.getitemstring(1, "ss_range_type")

ls_Co2Type = dw_Search.GetItemString ( 1, "ss_co2_type" )
ls_Site1Type = dw_Search.GetItemString ( 1, "ss_site_1_type" )
ls_Site2Type = dw_Search.GetItemString ( 1, "ss_site_2_type" )

ll_CoId = dw_search.getitemnumber(1, "ss_co")
ll_Co2Id = dw_search.getitemnumber(1, "ss_co2")
ll_Site1Id = dw_search.getitemnumber(1, "ss_site_1")
ll_Site2Id = dw_search.getitemnumber(1, "ss_site_2")

ld_Date1 = dw_search.getitemdate(1, "ss_date_1")
ld_Date2 = dw_search.getitemdate(1, "ss_date_2")
ls_Date1 = "~~'" + string(ld_Date1, "yyyy-mm-dd") + "~~'"
ls_Date2 = "~~'" + string(ld_Date2, "yyyy-mm-dd") + "~~'"


//if ls_RefType = "Z" then   Commented 3.6.00 (elimination of "detail match")

	if isnull(ld_Date1) and not ls_RangeType = "Z" then

		li_DaysInRange = -1

	elseif ls_RangeType = "T" then

		if isnull(ld_Date2) then
			li_DaysInRange = -1
		elseif ld_Date1 > ld_Date2 then
			li_DaysInRange = -1
		end if

	end if

	if li_DaysInRange = -1 then goto range_check

	if ls_RangeType = "Z" then
		if isnull(ld_Date1) then li_DaysInRange = 0 else li_DaysInRange = 1
	elseif ls_RangeType = "T" then
		li_DaysInRange = daysafter(ld_Date1, ld_Date2) + 1
	elseif ls_RangeType = "L" then
		li_DaysInRange = daysafter(ld_Date1, today()) + 1
	elseif ls_RangeType = "E" then
		li_DaysInRange = 9999
	else
		goto eval_error
	end if

	range_check:

	if li_DaysInRange < 0 then

		messagebox(ls_MessageHeader, "The date range you have entered is invalid -- "+&
			"request cancelled.")

		return

	end if

//end if


if search_type = "T" then		//"T" = Trip Search

	ls_Select = trip_select + " WHERE 1 = 1"
	//The code below was originally written to build on an existing where clause.
	//The use of the outer join took that away, so the expression above gets things rolling.

	if ll_CoId > 0 then ls_Select += " and bt_carrier_id = " + string(ll_CoId)

	choose case ls_TripRefType

	case "bt_id"	//Trip # search

		ls_RefText = Trim ( ls_RefText )

		IF Len ( ls_RefText ) > 0 THEN

			IF IsNumber ( ls_RefText ) THEN

				ls_Select += " and bt_id = " + ls_RefText

			ELSE

				MessageBox ( ls_MessageHeader, "The Trip # you have entered is invalid." )
				RETURN

			END IF

		END IF

	case "bt_tripnum"   //Carrier Trip # search

		if len(ls_RefText) > 0 then

			ls_RefText = "~~'" + ls_RefText + "~~'"
			ls_Select += " and bt_tripnum like " + ls_RefText

		end if

	end choose

	////////////////////

	if ls_Status <> "Z" then
		ls_Select += " and bt_pmtstatus = ~~'" + ls_Status + "~~'"
	end if

	if li_DaysInRange > 0 then

		ls_Work = "bt_tripdate"

		choose case ls_RangeType

		case "Z"
			ls_Select += " and " + ls_Work + " = " + ls_Date1

		case "E"
			ls_Select += " and " + ls_Work + " <= " + ls_Date1

		case "L"
			ls_Select += " and " + ls_Work + " >= " + ls_Date1

		case "T"
			ls_Select += " and (" + ls_Work + " between " + ls_Date1 + &
				" and " + ls_Date2 + ")"

		case else
			goto eval_error

		end choose

	end if

	if ll_Site1Id > 0 or ll_Site2Id > 0 then

		ls_Select += " and (("

		if ll_Site1Id > 0 then

			CHOOSE CASE ls_Site1Type

			CASE "ORIG_DEST"

				ls_Select += "bt_origin_id = " + String ( ll_Site1Id )

			CASE "EVENT"

				ls_Select += "bt_id in (select de_trailer from "+&
				"disp_events where de_site = " + string(ll_Site1Id) +&
				" and de_event_type = ~~'P~~')"

			END CHOOSE

		end if

		if ll_Site2Id > 0 then

			if ll_Site1Id > 0 then
				ls_Select += " and "
			end if

			CHOOSE CASE ls_Site2Type

			CASE "ORIG_DEST"

				ls_Select += "bt_findest_id = " + String ( ll_Site2Id )

			CASE "EVENT"

				ls_Select += "bt_id in (select de_trailer from "+&
					"disp_events where de_site = " + string(ll_Site2Id) +&
					" and de_event_type = ~~'D~~')"

			END CHOOSE

		end if


		ls_Select += ")"  //Close the inner double parenthesis


		if ls_ReverseRouting = "PD" then   //"PD" = Don't use reverse routing

			ls_Select += ")"   //Close the outer double parenthesis

			goto set_trip_retr

		end if


		ls_Select += " or ("


		if ll_Site2Id > 0 then

			CHOOSE CASE ls_Site2Type

			CASE "ORIG_DEST"

				ls_Select += "bt_origin_id = " + String ( ll_Site2Id )

			CASE "EVENT"

				ls_Select += "bt_id in (select de_trailer from "+&
					"disp_events where de_site = " + string(ll_Site2Id) +&
					" and de_event_type = ~~'P~~')"

			END CHOOSE

		end if

		if ll_Site1Id > 0 then

			if ll_Site2Id > 0 then
				ls_Select += " and "
			end if


			CHOOSE CASE ls_Site1Type

			CASE "ORIG_DEST"

				ls_Select += "bt_findest_id = " + String ( ll_Site1Id )

			CASE "EVENT"

				ls_Select += "bt_id in (select de_trailer from "+&
					"disp_events where de_site = " + string(ll_Site1Id) +&
					" and de_event_type = ~~'D~~')"

			END CHOOSE

		end if

		ls_Select += "))"  //Close 2nd clause parenthesis and entire clause parenthesis

	end if

	///////////////

	set_trip_retr:

	dw_trip_list.modify("datawindow.table.select = '" + ls_Select + "'")

else

	ls_Select = ship_select + " WHERE 1 = 1"

	//The code below was originally written to build on an existing where clause.
	//The use of the outer join took that away, so the expression above gets things rolling.

//	if search_type = "SD" then
//		ls_Select += " and ds_dorb in (~~'D~~', ~~'T~~')"
//	elseif search_type = "SB" then
//		ls_Select += " and ds_dorb = ~~'B~~'"
//	end if

	if search_type = "SD" then

		ls_Category = "DISPATCH"

	elseif search_type = "SB" then

		ls_Category = "BROKERAGE"

	ELSE

		ls_Category = ""

	end if

	IF ls_Category = "" THEN

		//No processing needed

	ELSE

		CHOOSE CASE inv_cst_Ship_Type.of_GetTypeList ( ls_Category, FALSE, ls_TypeList )

		CASE IS > 0
			ls_Select += " and ds_ship_type in ( " + ls_TypeList + " )"

		CASE 0
			MessageBox ( ls_MessageHeader, "You have not defined any shipment types for the category indicated." )
			RETURN

		CASE ELSE
			GOTO Eval_Error

		END CHOOSE

	END IF


	if ll_CoId > 0 then
		ls_Select += " and ds_billto_id = " + string(ll_CoId)
	end if


	IF ll_Co2Id > 0 THEN
		ls_Select += " and " + ls_Co2Type + " = " + String ( ll_Co2Id )
	END IF


	if len(ls_RefText) > 0 then

		CHOOSE CASE ls_RefType
	
		CASE "ds_id"
			lb_valid = false
			
			ls_RefText = Trim ( ls_RefText )
	
			IF Len ( ls_RefText ) > 0 THEN
	
				IF IsNumber ( ls_RefText ) THEN
					lb_valid = true
//					ls_Select += " and ds_id = " + ls_RefText
				ELSE
					MessageBox ( ls_MessageHeader, "The shipment number you have entered is invalid." )
					RETURN
				END IF
	
			END IF
			
			IF Len ( ls_RefNum2 ) > 0 THEN
	
				IF IsNumber ( ls_RefNum2 ) THEN
					lb_valid = true
				ELSE
					MessageBox ( ls_MessageHeader, "The ending shipment number you have entered is invalid." )
					RETURN
				END IF

				ls_Select += " and ( ds_id between ~~'" + ls_RefText + "~~'" +&
						" and ~~'" + ls_RefNum2 + "~~' )"

			ELSE
				
				ls_Select += " and ds_id = " + ls_RefText
				
			END IF
	
	
		CASE "ds_pronum"
			
			if pos(ls_RefText,'%') > 0 then
				//can't use between
				ls_Select += " and ( ds_pronum like ~~'" + ls_RefText + "~~'" +&
								" or ds_pronum like ~~'" + ls_RefText + "--%~~' )"
			else
				if len(ls_RefNum2) > 0 then
					ls_Select += " and ( ds_pronum between ~~'" + ls_RefText + "~~'" +&
											" and ~~'" + ls_RefNum2 + "~~' )"
				else
					ls_Select += " and ( ds_pronum like ~~'" + ls_RefText + "~~'" +&
								" or ds_pronum like ~~'" + ls_RefText + "--%~~' )"
				end if
			end if

		CASE "ref123"

			ls_Select += " and ( ds_ref1_text like ~~'" + ls_RefText + "~~' or " +&
				"ds_ref2_text like ~~'" + ls_RefText + "~~' or " +&
				"ds_ref3_text like ~~'" + ls_RefText + "~~' )"

		CASE "di_blnum"

			ls_Select += " and ds_id in ( select di_shipment_id from disp_items where " +&
				"di_blnum like ~~'" + ls_RefText + "~~')"
				
		CASE "trailerchassis"
			
			
			//Because of the potentially huge processing time of this search (the trailer columns are unindexed)
			//we are going to require that a movedate range accompany the search request.
			
			//NOTE:  If we use this option, we will NOT use the normal MOVEDATE syntax later...
			
			IF li_DaysInRange > 0 AND ls_DateType = "MOVEDATE" THEN
				
				//OK
				
			ELSE
				
				MessageBox ( "Trailer-Chassis Search Request", "Due to the heavy processing requirements of this search, "+&
					"you must also specify a MOVEDATE range when using the Trailer-Chassis search option.  Making the "+&
					"date range you specify as narrow as possible will improve search speed.")
				RETURN
				
			END IF
					
			
			//Build the de_arrdate syntax for the MOVEDATE criteria

			ls_Work = "SELECT de_shipment_id FROM disp_events WHERE ( de_arrdate "

			CHOOSE CASE ls_RangeType

			CASE "Z"  //Equals
				ls_Work += " = " + ls_Date1

			CASE "E"  //Or Eariler
				ls_Work += " <= " + ls_Date1

			CASE "L"  //Or Later
				ls_Work += " >= " + ls_Date1

			CASE "T"  //Through
				ls_Work += " between " + ls_Date1 + " and " + ls_Date2

			CASE ELSE
				GOTO eval_error

			END CHOOSE

			ls_Work += ")"
			
			
			ls_SubSelect = "SELECT eq_id FROM equipment WHERE eq_ref LIKE ~~'" + ls_RefText + "~~'"

			ls_Select += " and (ds_id in ( "+&
				ls_Work + " and de_trailer1 IN (" + ls_SubSelect + ") UNION ALL "+&
				ls_Work + " and de_trailer2 IN (" + ls_SubSelect + ") UNION ALL "+&
				ls_Work + " and de_trailer3 IN (" + ls_SubSelect + ") "+&
				" ) )"
			
	
		CASE ELSE
	
//			Eliminating this restriction 3.6.00
//			if ls_RefType = "ref123" and ll_CoId < 1 then
//				messagebox(ls_MessageHeader, "You must specify the Billto before "+&
//					"performing the search.")
//				return
//			end if

//			//Dropping support for this matching 3.6.00	
//			if ls_RefType = "ds_id" and match(ls_RefText, "^[0-9]+-TMP$") then &
//				ls_RefText = left(ls_RefText, len(ls_RefText) - 4)
	
	
			ls_Select += " and ( " + ls_RefType + " like ~~'" + ls_RefText + "~~' )"
	
	
		end choose

	END IF


	//////////////////////

	//Modified 3.8.00 BKW to allow for "[Unbilled Active]" search option, representing Open, Auth, AudReq, & Audited

	//Old expression was as follows:
	//if ls_Status <> "Z" then ls_Select += " and ds_status = ~~'" + ls_Status + "~~'"

	CHOOSE CASE ls_Status
			
	CASE "Z"  //[NONE]
		//Status is not a part of search criteria.  No addition to search string needed.
		
	CASE "U"  //[Unbilled Active]
		ls_Select += " and ds_status in ( ~~'K~~', ~~'N~~', ~~'Q~~', ~~'T~~' )"
		
	CASE ELSE 
		ls_Select += " and ds_status = ~~'" + ls_Status + "~~'"
		
	END CHOOSE
	
	//////

	if ll_ship_type > 0 then ls_Select += " and ds_ship_type = " + string(ll_ship_type)

	if li_DaysInRange > 0 then

		IF ls_DateType =  "MOVEDATE" THEN

			//This option was added in 3.6.00 (after b3)  7/18/03  BKW

			//Look for shipments with any events having a routing date that meets the criteria

			//"MOVEDATE" is singled out for special handling because it is not a column on the shipment,
			//like the other date selections are

			//The ls_RefType <> "trailerchassis" condition was added 3-8-00 BKW.  If the trailerchassis option is
			//in use, the MOVEDATE condition will have been applied in combination with the trailerchassis condition, above.
			//The Len condition is there because the "trailerchassis" option can be selected with no text, in which 
			//case that logic is not used, so the MOVEDATE should still be used here, by itself.

			IF ls_RefType = "trailerchassis" AND Len ( ls_RefText ) > 0 THEN
				
				//Already processed the MOVEDATE criteria, as part of the trailerchassis criteria.  Don't repeat here.
				
			ELSE

				ls_Select += " and (ds_id in (select de_shipment_id from disp_events "+&
					"where de_arrdate "
	
				CHOOSE CASE ls_RangeType
	
				CASE "Z"  //Equals
					ls_Select += " = " + ls_Date1
	
				CASE "E"  //Or Eariler
					ls_Select += " <= " + ls_Date1
	
				CASE "L"  //Or Later
					ls_Select += " >= " + ls_Date1
	
				CASE "T"  //Through
					ls_Select += " between " + ls_Date1 + " and " + ls_Date2
	
				CASE ELSE
					GOTO eval_error
	
				END CHOOSE
	
				ls_Select += ")) "
				
			END IF

		ELSE

			//The date selection is on the shipment, and can be handled here.

			choose case ls_RangeType
	
			case "Z"  //Equals
				ls_Select += " and " + ls_DateType + " = " + ls_Date1
	
			case "E"  //Or Earlier
				ls_Select += " and " + ls_DateType + " <= " + ls_Date1
	
			case "L"  //Or Later
				ls_Select += " and " + ls_DateType + " >= " + ls_Date1
	
			case "T"  //Through
				ls_Select += " and (" + ls_DateType + " between " + ls_Date1 + &
					" and " + ls_Date2 + ")"
	
			case else
				goto eval_error
	
			end choose

		END IF

	end if

	if ll_Site1Id > 0 or ll_Site2Id > 0 then

		ls_Select += " and (("

		if ll_Site1Id > 0 then

			CHOOSE CASE ls_Site1Type

			CASE "ORIG_DEST"

				ls_Select += "("

				ls_Select += "ds_origin_id = " + String ( ll_Site1Id )

				IF ls_ReverseRouting = "PD" THEN
					//Don't allow reverse routing
				ELSE
					ls_Select += " or ds_findest_id = " + String ( ll_Site1Id )
				END IF

				ls_Select += ")"

			CASE "EVENT"

				ls_Select += "ds_id in (select de_shipment_id from disp_events "+&
					"where de_site = " + string(ll_Site1Id)
	
				if ls_ReverseRouting = "PD" then		//"PD" means don't allow reverse routing
					ls_Select += " and de_event_type in (~~'P~~', ~~'H~~', ~~'M~~')"
				end if

				ls_Select += ")"   //Close parenthesis for the "in" clause

			END CHOOSE

		end if

		if ll_Site2Id > 0 then

			if ll_Site1Id > 0 then
				ls_Select += " and "
			end if

			CHOOSE CASE ls_Site2Type

			CASE "ORIG_DEST"

				ls_Select += "("

				ls_Select += "ds_findest_id = " + String ( ll_Site2Id )

				IF ls_ReverseRouting = "PD" THEN
					//Don't allow reverse routing
				ELSE
					ls_Select += " or ds_origin_id = " + String ( ll_Site2Id )
				END IF

				ls_Select += ")"

			CASE "EVENT"

				ls_Select += "ds_id in (select de_shipment_id from disp_events " +&
					"where de_site = " + string(ll_Site2Id)
	
				if ls_ReverseRouting = "PD" then		//"PD" means don't allow revers routing
					ls_Select += " and de_event_type in (~~'D~~', ~~'R~~', ~~'N~~')"
				end if
	
				ls_Select += ")"   //Close parenthesis for the "in" clause

			END CHOOSE

		end if

		ls_Select += "))"

	end if

	/////////////////////////

	dw_ship_list.modify("datawindow.table.select = '" + ls_Select + "'")

end if

retrieval:

uo_Radius.of_Unapplied ( )

if search_type = "T" then

	if dw_trip_list.retrieve() = -1 then goto rollitback

	commit ;

	if sqlca.sqlcode <> 0 then goto rollitback

	if dw_trip_list.rowcount() > 0 then 
		st_no_match.visible = false
	else 
		st_no_match.visible = true
	END IF

else

	if dw_ship_list.retrieve() = -1 then goto rollitback

	commit ;

	if sqlca.sqlcode <> 0 then goto rollitback

	//If the option to retrieve extended data has been selected, attempt the retrieval.

	IF cbx_RetrieveExtended.Checked = TRUE THEN

		cbx_RetrieveExtended.TextColor = Rgb ( 0, 255, 0 )  //Green

		CHOOSE CASE dw_Ship_List.Event ue_RetrieveExtended ( )
	
		CASE 1
			//Success
	
		CASE -1
			//Retrieval failed
			MessageBox ( ls_MessageHeader, "Error retrieving extended shipment data.  Basic data will be displayed." )
	
		CASE ELSE
			//Unexpected return
			MessageBox ( ls_MessageHeader, "Unexpected return error retrieving extended shipment data." )
	
		END CHOOSE

		cbx_RetrieveExtended.TextColor = 0   //Black

	ELSE
		//still need to fix the billto name even if they don't ask for extended data
		n_cst_beo_Company	lnv_Company
		lnv_Company = CREATE n_cst_beo_Company
		ll_rowcount = dw_ship_list.rowcount()
		
		for ll_ndx = 1 to ll_rowcount
			ll_billtoid = dw_ship_list.object.billto_id [ ll_ndx ]
			IF NOT IsNull ( ll_billtoid ) THEN
				gnv_cst_Companies.of_Cache ( ll_BillToId, FALSE )
				lnv_Company.of_SetUseCache ( TRUE )
				lnv_Company.of_SetSourceId ( ll_billtoid )
				dw_ship_list.object.billto_name [ ll_ndx ] = lnv_Company.of_GetBillingName ( )
			END IF
		next
		
		destroy lnv_Company
		
	END IF

	if dw_ship_list.rowcount() > 0 then 
		st_no_match.visible = false
	else
		st_no_match.visible = true
	END IF

end if

ib_HasResultSet = TRUE
parent.postevent("reset_range")

return

eval_error:
messagebox(ls_MessageHeader, "Could not evaluate search request -- request cancelled.")
return

rollitback:
rollback ;
messagebox(ls_MessageHeader, "Error executing search request -- please retry.")
return
end event

type cb_clear from commandbutton within w_search
integer x = 3159
integer y = 196
integer width = 375
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Clear"
end type

event clicked;
mboxret = 1
if messagebox("Clear Search", "OK to clear the current search criteria?", question!, &
	okcancel!, 2) = 2 then return

if ib_HasResultSet = TRUE then
	st_no_match.visible = false
	dw_ship_list.reset()
	dw_trip_list.reset()
	st_range.text = "0 to 0 of 0"
	ib_HasResultSet = FALSE
end if

uo_Radius.of_Unapplied ( )

dw_search.deleterow(1)
dw_search.insertrow(0)

//if search_type = "T" then dw_search.setitem(1, "ss_ref_type", "T") else search_type = "SE"
//dw_search.setitem(1, "ss_type", search_type)

dw_search.setitem(1, "ss_type", search_type)
//if search_type = "T" then dw_search.setitem(1, "ss_ref_type", "T")  Commented 3.6.00

end event

type st_range from statictext within w_search
integer x = 2139
integer y = 580
integer width = 558
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "0 to 0 of 0"
boolean focusrectangle = false
end type

type st_label from statictext within w_search
integer x = 1893
integer y = 580
integer width = 233
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Trips"
boolean focusrectangle = false
end type

event clicked;//Provide accelerator functionality for dw_ship_list.

IF dw_Ship_List.Visible THEN
	dw_Ship_List.SetFocus ( )
END IF
end event

type dw_search from datawindow within w_search
integer x = 32
integer y = 48
integer width = 3063
integer height = 492
integer taborder = 10
string dataobject = "d_search"
boolean border = false
boolean livescroll = true
end type

on dberror;mboxret = 1
end on

event itemchanged;dwobject ldwo_ship_type
string ls_category, ls_work, ls_StatusList
integer li_return
long lla_dummy[]
s_co_info lstr_company
n_cst_ShipmentManager	lnv_ShipmentManager

string changed_col
changed_col = dwo.name

choose case changed_col

//Commented 3.6.00
//case "ss_ref_type"
//	if this.getitemstring(1, changed_col) = "Z" then
//		this.setitem(1, "ss_date_2", null_date)
//		this.setitem(1, "ss_range_type", "Z")
//		this.setitem(1, "ss_date_1", null_date)
//		this.setitem(1, "site_1_name", null_str)
//		this.setitem(1, "site_2_name", null_str)
//		this.setitem(1, "ss_Status", "Z")
//		this.setitem(1, "ss_ship_type", 0)
//		this.setitem(1, "ss_site_type", "PD")
//		this.setitem(1, "ss_site_1", null_long)
//		this.setitem(1, "ss_site_2", null_long)
//	elseif data = "Z" then
//		this.setitem(1, "ss_ref_num", null_str)
//	end if
//	if (data = "S" or this.getitemstring(1, changed_col) = "S") &
//		or (search_type = "T") then
//			this.setitem(1, "ss_ref_num", null_str)
//			this.setitem(1, "co_name", null_str)
//			this.setitem(1, "ss_co", null_long)
//	end if

case "ss_range_type"
	if this.getitemstring(1, changed_col) = "T" then &
		this.setitem(1, "ss_date_2", null_date)
case "ss_ref_type"
	if data = 'ds_id' or data = 'ds_pronum' then
		n_cst_Privileges	lnv_Privileges

		IF lnv_Privileges.of_HasSysAdminRights ( )  THEN
			cb_arbatch.visible = true
		ELSE
			cb_arbatch.visible=false
		END IF

	else
		this.setitem(1, "ss_ref_num2", null_str)
		cb_arbatch.visible = false
	end if
case "ss_type"
	this.setredraw(false)
	ldwo_ship_type = this.object.ss_ship_type
	ls_category = ""
	choose case data
	case "SB"
		ls_category = "BROKERAGE"
	case "SD"
		ls_category = "DISPATCH"
	case "SE"
		ls_category = "ALL"
	end choose
	if len(ls_category) > 0 then
		inv_cst_ship_type.of_populate(ldwo_ship_type, ls_category, false, lla_dummy)
		ls_work = ldwo_ship_type.values
	else
		ls_work = ""
	end if
	if len(ls_work) > 0 then 
		if right(ls_work,1) = "/" then
			//ok
		else
			ls_work += "/"
		end if
	end if
	ls_work += "[ANY TYPE]~t0"
	ldwo_ship_type.values = ls_work
	destroy ldwo_ship_type
	if this.describe("evaluate('lookupdisplay(ss_ship_type)', 1)") = &
		string(this.getitemnumber(1, "ss_ship_type")) then &
			this.setitem(1, "ss_ship_type", 0)
	if data = "T" or search_type = "T" or This.Describe ( "ss_Status.Values" ) = "?" then
		this.setitem(1, "ss_co", null_long)
		this.setitem(1, "co_name", null_str)
		this.setitem(1, "ss_ref_num", null_str)
		This.SetItem(1, "ss_Status", "Z" )  //Set to "ANY STATUS"
		if data = "T" then
			dw_trip_list.show()
			dw_ship_list.hide()
			ddlb_ship_display.hide()
			ddlb_trip_display.show()

//			Commented 3.6.00
//			this.clearvalues("ss_ref_type")
//			this.setvalue("ss_ref_type", 1, "DETAIL MATCH~tZ")
//			this.setvalue("ss_ref_type", 2, "TRIP # :~tT")
//			if not this.getitemstring(1, "ss_ref_type") = "Z" then &
//				this.setitem(1, "ss_ref_type", "T")
			This.SetItem ( 1, "ss_trip_ref_type", "bt_id" )  //New in 3.6.00, replacing commented portions above.


			ls_StatusList = appeon_constant.cs_Status_ValueList
			st_label.Visible = TRUE
			st_Range.Visible = TRUE
			cb_Bill.Enabled = FALSE
//			cb_Details.Visible = TRUE   Removed button 3.6.00
			cbx_RetrieveExtended.Visible = FALSE  //Applies only to shipment data

			//Set target columns for radius restriction
			uo_Radius.of_SetPickupColumn ( "bt_Origin_Id", "COMPANY!" )
			uo_Radius.of_SetDeliveryColumn ( "bt_Findest_Id", "COMPANY!" )
			
			//Set target dw for radius restriction
			uo_Radius.of_Set_Target ( dw_Trip_List )

		else
			dw_ship_list.show()
			dw_trip_list.hide()
			ddlb_trip_display.hide()
			ddlb_ship_display.show()

//			Commented 3.6.00
//			this.clearvalues("ss_ref_type")
//			this.setvalue("ss_ref_type", 1, "DETAIL MATCH~tZ")
//			this.setvalue("ss_ref_type", 2, "SHIPMENT # :~tS")
//			this.setvalue("ss_ref_type", 3, "CUSTOMER REF # :~tC")
//			this.setvalue("ss_ref_type", 4, "BL # :~tB")
//			if not this.getitemstring(1, "ss_ref_type") = "Z" then &
//				this.setitem(1, "ss_ref_type", "S")
			This.SetItem ( 1, "ss_ref_type", "ds_id" )  //New in 3.6.00, replacing commented portions above.

			//[UNBILLED ACTIVE] Option added 3.8.00 BKW
			ls_StatusList = "[UNBILLED ACTIVE]~tU/" + lnv_ShipmentManager.of_GetStatusCodeTable ( )

			st_label.Visible = FALSE
			st_Range.Visible = FALSE
			cb_Bill.Enabled = TRUE
//			cb_Details.Visible = FALSE   Removed button 3.6.00
			cbx_RetrieveExtended.Visible = TRUE  //Applies only to shipment data

			//Set target columns for radius restriction
			uo_Radius.of_SetPickupColumn ( "Origin_Id", "COMPANY!" )
			uo_Radius.of_SetDeliveryColumn ( "Destination_Id", "COMPANY!" )
			
			//Set target dw for radius restriction
			uo_Radius.of_Set_Target ( dw_Ship_List )

		end if

		ls_StatusList = "[ANY STATUS]~tZ/" + ls_StatusList

		This.Modify ( "ss_Status.ddlb.UseAsBorder = Yes ss_Status.ddlb.VScrollBar = Yes "+&
			"ss_Status.Values = '" + ls_StatusList + "'" )

	end if

	this.setredraw(true)
	search_type = data
case "co_name", "co2_name", "site_1_name", "site_2_name"   //Co2 added 3.6.00
	if changed_col = "co_name" then
		if search_type = "T" then ls_work = "CARRIER!" else ls_work = "BILLTO!"
	elseif changed_col = "co2_name" AND This.GetItemString ( This.GetRow ( ), "ss_co2_type" ) = "ds_pay1_id" THEN
		ls_Work = "CARRIER!"
	else
		ls_work = "ANY!"
	end if
	if gnv_cst_companies.of_select(lstr_company, ls_work, true, data, false, 0, true, true) = 1 then
		ls_work = "ss_" + substitute(changed_col, "_name", "")
		this.setitem(row, ls_work, lstr_company.co_id)
		this.setitem(row, changed_col, lstr_company.co_name)
		li_return = 2
	else
		this.settext(substitute(this.getitemstring(row, changed_col), null_str, ""))
		return 2
	end if
end choose


if ib_HasResultSet = TRUE then
	st_no_match.visible = false
	dw_ship_list.reset()
	dw_trip_list.reset()
	st_range.text = "0 to 0 of 0"
	ib_HasResultSet = FALSE
end if

uo_Radius.of_Unapplied ( )

return li_return
end event

event itemerror;string changed_col, textstr
n_cst_string lnv_string
changed_col = this.getcolumnname()
textstr = this.gettext()
Int	li_Return = 3

choose case changed_col
	case "ss_date_1", "ss_date_2"
		date newdate, otherdate
		if len(trim(textstr)) = 0 then
			this.setitem(1, changed_col, null_date)
			goto actcode
		end if
		
		newdate = lnv_String.of_Makedate( textstr )
		IF isDate ( String ( newdate ) ) THEN
			this.setitem(1, changed_col, Date ( newdate) )
			goto actcode
		END IF
		
		newdate = lnv_string.of_SpecialDate(textstr)
		if isnull(newdate) then goto invalid
		if this.getitemstring(1, "ss_range_type") = "T" then
			if changed_col = "ss_date_1" then
				otherdate = this.getitemdate(1, "ss_date_2")
				if otherdate < newdate then this.setitem(1, "ss_date_2", null_date)
			else
				otherdate = this.getitemdate(1, "ss_date_1")
				if otherdate > newdate then this.setitem(1, "ss_date_1", null_date)
			end if
		end if
		this.setitem(1, changed_col, newdate)
		goto actcode
end choose


invalid:

mboxret = 1
messagebox("Search Criteria", "The value you have entered is invalid." )//  It will be "+&
//	"replaced by the previous value.")
//This.SetColumn ( String ( dwo.name ) )
This.SetFocus ( )

li_Return = 1

actcode:

if ib_HasResultSet = TRUE then
	st_no_match.visible = false
	dw_ship_list.reset()
	dw_trip_list.reset()
	st_range.text = "0 to 0 of 0"
	ib_HasResultSet = FALSE
end if

uo_Radius.of_Unapplied ( )

return li_Return
end event

event losefocus;//if mboxret = 0 then this.accepttext()
end event

event constructor;//Load the Custom Field labels into the RefType listbox

Integer	li_Index
String	ls_Column, &
			ls_Label
n_cst_Presentation_Shipment	lnv_Presentation

FOR li_Index = 1 TO 10

	//Handles "Custom1" through "Custom10"

	ls_Column = "Custom" + String ( li_Index )

	IF lnv_Presentation.Event ue_GetCustomLabel ( ls_Column, ls_Label ) = 1 THEN

		This.SetValue ( "ss_ref_type", 30 /*Arbitrary #, has to be more than existing # of entries*/ + li_Index, &
			Upper ( ls_Label ) + "~t" + "disp_ship." + ls_Column )  //Must specify correlation name to avoid sql error

	END IF

NEXT

n_cst_Privileges	lnv_Privileges

IF lnv_Privileges.of_HasSysAdminRights ( )  THEN
	cb_arbatch.visible = true
ELSE
	cb_arbatch.visible=false
END IF

end event

type ddlb_ship_display from dropdownlistbox within w_search
integer x = 2981
integer y = 564
integer width = 622
integer height = 1348
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Overview","Appointments","Billing Info","Inbound Pending","Inbound Loads","Inbound Returns","Outbound Empties","Outbound Loading","Outbound Ready","One Ways"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//Forward the request to the datawindow for handling.
dw_Ship_List.Event ue_SetView ( This.Text )
end event

event constructor;n_cst_Dws		lnv_Dws
String			lsa_ViewList[]
Long				ll_Count, &
					ll_Index

//Add any custom view definitions to the display option list.

//Get the list.
ll_Count = lnv_Dws.of_GetCustomViewList ( "ShipmentList", lsa_ViewList )

//Add them to the dropdown.

FOR ll_Index = 1 TO ll_Count

	This.AddItem ( lsa_ViewList [ ll_Index ] )

NEXT

//Set the selection, and force the SelectionChanged event, which will 
//trigger setup of the display view.  (SelectionChanged does not get 
//triggered on its own by the SelectItem call)
This.SelectItem ( 1 )
This.Event SelectionChanged ( 1 )
end event

event rbuttondown;String	lsa_Parm_Labels[]
Any		laa_Parm_Values[]

w_CustomViewDefinitions	lw_ViewDefs

lsa_Parm_Labels [ 1 ] = "ADD_ITEM"
laa_Parm_Values [ 1 ] = "&Define Custom Views"

CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )

CASE "DEFINE CUSTOM VIEWS"

	OpenSheet ( lw_ViewDefs, gnv_App.of_GetFrame ( ), 0, Layered! )

END CHOOSE
end event

type ddlb_trip_display from dropdownlistbox within w_search
boolean visible = false
integer x = 2981
integer y = 564
integer width = 471
integer height = 240
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Locations","Other Info"}
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;choose case this.text
	case "Locations"
		dw_trip_list.modify("txt_disp_ind.text = 'L'")
	case "Other Info"
		dw_trip_list.modify("txt_disp_ind.text = 'E'")
end choose

dw_trip_list.setredraw(true)
end on

type dw_ship_list from u_dw_shipmentlist within w_search
event ue_mousemove pbm_dwnmousemove
event ue_filterchanged ( )
event type integer ue_retrieveextended ( )
integer x = 23
integer y = 672
integer width = 3579
integer height = 1228
integer taborder = 20
end type

event ue_mousemove;IF isValid ( THIS.inv_Mediator ) THEN
	inv_Mediator.of_HideDataManager ( )
END IF
end event

event ue_filterchanged;uo_Radius.of_Unapplied ( )

end event

event ue_retrieveextended;Long		ll_RowCount, &
			ll_FilteredCount, &
			ll_TotalCount

DataStore	lds_Copy
n_cst_ShipmentManager	lnv_ShipmentManager


Integer	li_Return = 1
Boolean	lb_Finished = FALSE

IF lb_Finished = FALSE THEN

	ll_RowCount = This.RowCount ( )
	ll_FilteredCount = This.FilteredCount ( )

	IF ll_RowCount = 0 AND ll_FilteredCount = 0 THEN

		lb_Finished = TRUE

	END IF

END IF


IF lb_Finished = FALSE THEN

	lds_Copy = CREATE DataStore
	lds_Copy.DataObject = "d_current_shipments"  //Same as that used for cache retrieval
	lds_Copy.SetTransObject ( SQLCA )

	IF ll_RowCount > 0 THEN
		This.RowsCopy ( 1, ll_RowCount, Primary!, lds_Copy, 9999, Primary! )
	END IF

	IF ll_FilteredCount > 0 THEN
		This.RowsCopy ( 1, ll_FilteredCount, Filter!, lds_Copy, ll_RowCount + 1, Primary! )
	END IF

	CHOOSE CASE lnv_ShipmentManager.of_PopulateExtendedShipmentData ( lds_Copy )

	CASE 1

		//Success

	CASE ELSE

		li_Return = -1
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	//Reload the rows, all into the primary buffer, and then re-filter and re-sort.
	//This is done because the filter result set may change by virtue of the extended 
	//data being populated, so we need to re-filter.

	This.SetRedraw ( FALSE )

	ll_TotalCount = lds_Copy.RowCount ( )

	IF ll_RowCount > 0 THEN
		This.RowsDiscard ( 1, ll_RowCount, Primary! )
	END IF

	IF ll_FilteredCount > 0 THEN
		This.RowsDiscard ( 1, ll_FilteredCount, Filter! )
	END IF

	lds_Copy.RowsCopy ( 1, ll_TotalCount, Primary!, This, 9999, Primary! )

	This.Filter ( )
	This.Sort ( )

	This.SetRedraw ( TRUE )

END IF


DESTROY lds_Copy

RETURN li_Return
end event

event ue_setview;call super::ue_setview;//Extending Ancestor Script

//Flag that there is no longer a valid where clause on this datawindow for retrieval.
//(The where clause is not necessarily gone here, but it could be, and we can't tell,
//so we have to assume that its changed.)
ib_HasResultSet = FALSE

RETURN AncestorReturnValue
end event

type dw_trip_list from u_dw_triplist within w_search
event ue_mousemove pbm_dwnmousemove
event ue_filterchanged ( )
integer x = 23
integer y = 672
integer width = 3579
integer height = 1228
integer taborder = 100
end type

event ue_mousemove;
IF isValid ( THIS.inv_Mediator ) THEN
	inv_Mediator.of_HideDataManager ( )
END IF
end event

event ue_filterchanged;uo_Radius.of_Unapplied ( )
end event

event ue_details;parent.Event ue_Details ( )
end event

type cbx_retrieveextended from checkbox within w_search
integer x = 677
integer y = 584
integer width = 686
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
string text = "Retrieve E&xtended Data "
end type

event clicked;String	ls_MessageHeader = "Retrieve Extended Shipment Data"


IF This.Checked = FALSE THEN

	//User unchecked the control -- no action needed

ELSEIF search_type = "T" THEN

	//Trip search -- no action needed

ELSE

	This.TextColor = Rgb ( 0, 255, 0 )  //Green

	CHOOSE CASE dw_Ship_List.Event ue_RetrieveExtended ( )

	CASE 1
		//Success

	CASE -1
		//Retrieval failed
		MessageBox ( ls_MessageHeader, "Error retrieving extended shipment data.  Basic data will be displayed." )

	CASE ELSE
		//Unexpected return
		MessageBox ( ls_MessageHeader, "Unexpected return error retrieving extended shipment data." )

	END CHOOSE

	This.TextColor = 0  //Black

END IF
end event

type gb_1 from groupbox within w_search
integer x = 14
integer width = 3584
integer height = 548
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

