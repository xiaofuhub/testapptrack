$PBExportHeader$w_rate_query.srw
forward
global type w_rate_query from w_sheet
end type
type dw_query_results from u_dw within w_rate_query
end type
type dw_selection from u_dw within w_rate_query
end type
type dw_query from datawindow within w_rate_query
end type
type cb_retrieve from commandbutton within w_rate_query
end type
type cb_select from commandbutton within w_rate_query
end type
type cb_delete_selection from commandbutton within w_rate_query
end type
type cb_reset from commandbutton within w_rate_query
end type
type cb_import from commandbutton within w_rate_query
end type
type st_1 from u_st_label within w_rate_query
end type
type cbx_sourceshipmentsonly from checkbox within w_rate_query
end type
end forward

global type w_rate_query from w_sheet
integer x = 0
integer y = 156
integer width = 4133
integer height = 2076
string title = "Rate Lookup"
string menuname = "m_sheets"
long backcolor = 12632256
dw_query_results dw_query_results
dw_selection dw_selection
dw_query dw_query
cb_retrieve cb_retrieve
cb_select cb_select
cb_delete_selection cb_delete_selection
cb_reset cb_reset
cb_import cb_import
st_1 st_1
cbx_sourceshipmentsonly cbx_sourceshipmentsonly
end type
global w_rate_query w_rate_query

type variables
n_cst_rate_attribs inv_attribs
n_ds inv_ds
string is_OriginalSelect
long ila_BillToIds[]
long ila_ShipmentIds[]
long il_origin
long il_findest
long	il_AmountType
Boolean	ib_AlreadyClear = TRUE
end variables

forward prototypes
private function integer wf_setdefaultamounttype (long al_amounttype)
public function integer wf_cleartempvalues ()
end prototypes

private function integer wf_setdefaultamounttype (long al_amounttype);il_amounttype = al_amounttype
dw_query.Setitem ( 1 , "amounttype" , il_amounttype )
dw_Query.Modify ( "filter_column.visible = 0" )
dw_Query.Modify ( "amounttype.visible = 1" )
dw_Query.Modify ( "t_9.text= 'Amount Type'" )

// check the item type and make sure that the search is for matching item types only

Return 1
end function

public function integer wf_cleartempvalues ();IF Not ib_alreadyclear AND dw_query.RowCount ( ) > 0  THEN
	
	dw_query.SetItem ( 1 , "Origin_City" , "" )
	dw_query.SetItem ( 1 , "Origin_State" , "" )
	dw_query.SetItem ( 1 , "Pickup_Zip" , "" )
	dw_query.SetItem ( 1 , "FinDest_City" , "" )
	dw_query.SetItem ( 1 , "Findest_State" , "" )
	dw_query.SetItem ( 1 , "Deliver_zip" , "" )
	ib_alreadyclear = TRUE
END IF

RETURN 1
end function

on w_rate_query.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_query_results=create dw_query_results
this.dw_selection=create dw_selection
this.dw_query=create dw_query
this.cb_retrieve=create cb_retrieve
this.cb_select=create cb_select
this.cb_delete_selection=create cb_delete_selection
this.cb_reset=create cb_reset
this.cb_import=create cb_import
this.st_1=create st_1
this.cbx_sourceshipmentsonly=create cbx_sourceshipmentsonly
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_query_results
this.Control[iCurrent+2]=this.dw_selection
this.Control[iCurrent+3]=this.dw_query
this.Control[iCurrent+4]=this.cb_retrieve
this.Control[iCurrent+5]=this.cb_select
this.Control[iCurrent+6]=this.cb_delete_selection
this.Control[iCurrent+7]=this.cb_reset
this.Control[iCurrent+8]=this.cb_import
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.cbx_sourceshipmentsonly
end on

on w_rate_query.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_query_results)
destroy(this.dw_selection)
destroy(this.dw_query)
destroy(this.cb_retrieve)
destroy(this.cb_select)
destroy(this.cb_delete_selection)
destroy(this.cb_reset)
destroy(this.cb_import)
destroy(this.st_1)
destroy(this.cbx_sourceshipmentsonly)
end on

event open;call super::open;N_cst_privsManager	lnv_manager

inv_attribs = Message.PowerObjectParm
gf_mask_menu ( m_sheets ) 

//Enable the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize ( 1300, 400 )

//Register Resizable controls
inv_Resize.of_Register ( dw_query, 'ScaleToRight' )
inv_Resize.of_Register ( cb_reset, 'FixedToRight' )
inv_Resize.of_Register ( cb_select, 'FixedToRight' )
inv_Resize.of_Register ( cb_retrieve, 'FixedToRight' )
inv_Resize.of_Register ( dw_query_results, 'ScaleToRight' )
inv_Resize.of_Register ( cb_delete_selection, 'FixedToRight' )
inv_Resize.of_Register ( cb_import, 'FixedToRight' )
inv_Resize.of_Register ( dw_selection, 'ScaleToright&Bottom' )

dw_query.InsertRow(0)


this.Event Post pfc_open( )

//added by dan 1-30-07 
lnv_manager = gnv_app.of_getPrivsmanager( )
IF lnv_manager.of_getuserpermissionfromfn( "View Charges" ) <> 1 THEN
	Messagebox("Rate Lookup", "You do not have permission to view this window.")
	post close (this)
END IF
////////////////////

end event

event close;call super::close;close ( this )
end event

event pfc_open;/*
	Grab the values from n_cst_rate_attribs if any amd use for the initial
	query. If any values are obtained from n_cst_rate_attribs, then initialize
	them through the set methods after getting them.
	
*/
long lla_Ids []
n_Cst_beo_item	lnv_Item
n_cst_beo_Company	lnv_Company
lnv_Company = CREATE n_cst_beo_Company
inv_ds = create n_ds


inv_ds.dataObject="d_itemselection"
inv_ds = inv_attribs.Of_GetDatastore ( )
inv_ds.ShareData ( dw_selection )

// populate query dw

//billtoid
inv_attribs.of_GetBillToids ( ila_BillToIds )
IF upperbound ( ila_BillToIds ) > 0 THEN
	IF isnull ( ila_BillToIds ) or ila_BillToIds[1] = 0 THEN
		//DO NOTHING
	ELSE
		gnv_cst_Companies.of_Cache ( ila_BillToIds [1], FALSE )
		lnv_Company.of_SetUseCache ( TRUE )
		lnv_Company.of_SetSourceId ( ila_BillToIds [1] )
		dw_query.object.billtoid[1] = ila_BillToIds [1] 
		dw_query.object.billtoid_text[1] = lnv_Company.of_GetName ( )
		inv_attribs.of_SetBillToids ( lla_Ids [])
	END IF
END IF
//
inv_attribs.of_GetShipmentids ( ila_ShipmentIds )
IF upperbound ( ila_ShipmentIds ) > 0 THEN
	IF isnull ( ila_ShipmentIds ) or ila_ShipmentIds[1] = 0 THEN
		//DO NOTHING
	ELSE
		//Give user the option of restricting the search to just these shipments.  This is no longer done by default.
		cbx_SourceShipmentsOnly.Enabled = TRUE
		
		inv_attribs.of_SetShipmentids ( lla_Ids [])
	END IF
END IF

//originid
il_Origin = inv_attribs.of_GetOriginId ( )
IF isnull ( il_Origin ) or il_Origin = 0 THEN
		//DO NOTHING
ELSE
	gnv_cst_Companies.of_Cache ( il_Origin, FALSE )
	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_SetSourceId ( il_Origin )
	dw_query.object.origin[1] = il_Origin
	dw_query.object.origin_text[1] = lnv_Company.of_GetName ( )
	inv_attribs.of_SetOriginId ( 0 )
END IF

//destinationid
il_FinDest = inv_attribs.of_GetDestinationId( )
IF isnull ( il_FinDest ) or il_FinDest = 0 THEN
		//DO NOTHING
ELSE
	gnv_cst_Companies.of_Cache ( il_FinDest, FALSE )
	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_SetSourceId ( il_FinDest )
	dw_query.object.FinDest[1] = il_FinDest
	dw_query.object.FinDest_text[1] = lnv_Company.of_GetName ( )
	inv_attribs.of_SetDestinationId( 0 )
END IF

lnv_item = inv_attribs.of_Gettargetitem( )
IF isValid ( lnv_Item ) THEN
	THIS.wf_setdefaultamounttype( lnv_Item.of_GetAmountType ( ) ) 
END IF


DESTROY lnv_Company
cb_retrieve.Event clicked()
end event

event pfc_postopen;call super::pfc_postopen;ib_alreadyclear = FALSE
end event

type dw_query_results from u_dw within w_rate_query
event ue_retrieve ( )
integer x = 5
integer y = 384
integer width = 4059
integer height = 792
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_itemselection"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event ue_retrieve();/*
		Check all of the columns in dw_query and build where clause.
*/
long		ll_rows, &
			lla_ids [], &
			ll_sql, &
			ll_cnt, &
			ll_OriginId, &
			ll_DestinationId, &
			ll_pos, &
			ll_ziplen
			
string	ls_sql, &
			ls_description, &
			ls_rc, &
			ls_ModString, &
			lsa_WhereClause[], &
			ls_ids, &
			ls_text, &
			ls_IdType, & 
			ls_Zip
			
n_cst_string	lnv_string

dw_query_results.SetRedraw(FALSE)

// Limit resultset
// This is equivalent to SET TEMPORARY OPTION.  Which means it
// is only for the duration of the current connection
ls_sql = "SET ROWCOUNT " + string ( dw_query.object.number_of_rows[1] )
execute immediate :ls_sql;

ls_sql = ""

//	Build where clause for columns that contain something

//	billtoids
IF upperbound ( ila_billtoids )  > 0 THEN
	lnv_string.of_ArraytoString ( ila_billtoids, ',', ls_ids)
	IF len ( trim ( ls_ids) ) > 0 THEN
		ll_sql ++
		ls_sql += ' and disp_ship.ds_billto_id in ( ' + ls_ids + ' )'
	END IF
END IF

//	shipmentids :  cbx_SourceShipmentsOnly condition added 3.5.18 BKW
IF upperbound ( ila_shipmentids )  > 0 AND cbx_SourceShipmentsOnly.Checked = TRUE THEN
	lnv_string.of_ArraytoString ( ila_shipmentids, ',', ls_ids)
	IF len ( trim ( ls_ids) ) > 0 THEN
		ll_sql ++
		ls_sql += ' and disp_ship.ds_id in ( ' + ls_ids + ' )'
	END IF
END IF

//	modify for type
ls_text = dw_query.object.filter_column[1] 
IF len ( trim ( ls_text ) ) > 0 THEN
		ll_sql ++
		ls_sql += " and disp_items.di_item_type = ~~'" + ls_text + "~~'"
END IF

//	Modify for billtoid
IF dw_query.object.billtoid[1] > 0 THEN
		ll_sql ++
		ls_sql += ' and disp_ship.ds_billto_id = ' + string ( dw_query.object.billtoid[1] )
END IF

//	Modify for Origin
IF dw_query.object.origin[1] > 0 THEN
	ll_sql ++
	ls_sql += ' and disp_ship.ds_id in (select de_shipment_id from disp_events '+ &
	"where de_site = " + string( dw_query.object.origin[1] ) + &
	" and de_event_type in (~~'P~~', ~~'H~~', ~~'M~~'))"
END IF

//modify for pickup zipcode
ls_description = trim ( dw_query.object.pickup_zip[1] )
ll_ziplen = len ( ls_Description )
IF ll_ziplen > 0 AND UPPER ( ls_description ) <> "ZIP" THEN
	ll_sql ++
	ls_sql += " and disp_ship.ds_origin_id  in ( " + &
	"select co_id from companies where co_zip like ~~'" + ls_description + "%~~')"
END IF

//	MOdify for Destination
IF dw_query.object.findest[1] > 0 THEN
	ll_sql ++
	ls_sql += ' and disp_ship.ds_id in (select de_shipment_id from disp_events ' +&
		"where de_site = " + string( dw_query.object.findest[1] ) + &
	" and de_event_type in (~~'D~~', ~~'R~~', ~~'N~~'))"
END IF

//	modify for deliver zipcode
ls_description = trim ( dw_query.object.deliver_zip[1] )
ll_ziplen = len ( ls_Description )
IF ll_ziplen > 0 AND UPPER ( ls_description ) <> "ZIP" THEN
	ll_sql ++
	ls_sql += " and disp_ship.ds_findest_id in ( " + &
	"select co_id from companies where co_zip like ~~'" + ls_description + "%~~')"
END IF

//	Modify for weight range
IF dw_query.object.weight_from[1] = 0 AND &
	dw_query.object.weight_to[1] > 0 THEN
	ll_sql ++
	ls_sql += ' and disp_items.di_totitemweight <= ' + &
		string ( dw_query.object.weight_to[1] ) 
END IF
	
IF dw_query.object.weight_to[1] = 0 AND &
	dw_query.object.weight_from[1] > 0 THEN
	ll_sql ++
	ls_sql += ' and disp_items.di_totitemweight >= ' + &
		string ( dw_query.object.weight_from[1] ) 
END IF
	
IF dw_query.object.weight_to[1] > 0 AND &
	dw_query.object.weight_from[1] > 0 THEN
		ll_sql ++
		ls_sql += ' and disp_items.di_totitemweight between ' + &
			string ( dw_query.object.weight_from[1] ) + ' and ' + &
			string ( dw_query.object.weight_to[1] ) 
END IF

//	Modify for miles
IF dw_query.object.miles_from[1] = 0 AND &
	dw_query.object.miles_to[1] > 0 THEN
	ll_sql ++
	ls_sql += ' and disp_items.di_miles <= ' + &
		string ( dw_query.object.miles_to[1] ) 
END IF
	
IF dw_query.object.miles_to[1] = 0 AND &
	dw_query.object.miles_from[1] > 0 THEN
	ll_sql ++
	ls_sql += ' and disp_items.di_miles >= ' + &
		string ( dw_query.object.weight_from[1] ) 
END IF
	
IF dw_query.object.miles_to[1] > 0 AND &
	dw_query.object.miles_from[1] > 0 THEN
		ll_sql ++
		ls_sql += ' and disp_items.di_miles between ' + &
			string ( dw_query.object.miles_from[1] ) + ' and ' + &
			string ( dw_query.object.miles_to[1] ) 	
END IF


//	modify for  rate type
ls_text = dw_query.object.rate_type[1] 
IF len ( trim ( ls_text ) ) > 0 THEN
		ll_sql ++
		ls_sql += " and disp_items.di_our_ratetype = ~~'" + ls_text + "~~'"
END IF

// modify for item amount type

IF il_amounttype > 0 THEN
	ls_text = String (il_amounttype)
	ll_sql ++
	ls_sql += " and disp_items.amounttype = ~~'" + ls_text + "~~'"
END IF


ls_text = dw_query.object.Origin_City[1] 
IF len ( trim ( ls_text ) ) > 0 AND UPPER ( ls_text ) <> "CITY" THEN
		ll_sql ++
		ls_sql += " and companies_b.co_city = ~~'" + ls_text + "~~'"
END IF

ls_text = dw_query.object.Origin_State[1] 
IF len ( trim ( ls_text ) ) > 0 AND UPPER ( ls_text ) <> "ST"  THEN
		ll_sql ++
		ls_sql += " and companies_b.co_state = ~~'" + ls_text + "~~'"
END IF

ls_text = dw_query.object.findest_City[1] 
IF len ( trim ( ls_text ) ) > 0  AND UPPER ( ls_text ) <> "CITY" THEN
		ll_sql ++
		ls_sql += " and companies_c.co_city = ~~'" + ls_text + "~~'"
END IF

ls_text = dw_query.object.findest_State[1] 
IF len ( trim ( ls_text ) ) > 0 AND UPPER ( ls_text ) <> "ST"  THEN
		ll_sql ++
		ls_sql += " and companies_c.co_state = ~~'" + ls_text + "~~'"
END IF


//	Modify where clause if description was entered, surround with wildcards
ls_description = trim ( dw_query.object.like_clause[1] )
IF len ( ls_Description ) > 0 THEN
		ll_sql ++
		ls_sql += " and disp_items.di_description like ~~'%" + ls_description + "%~~'"
END IF

choose case ll_sql
	case 0, 1
		//do nothing
	case else
		//strip off first and
		ll_pos = pos ( ls_sql, "and" )
		if ll_pos > 0 then
			ls_sql = right ( ls_sql, len ( ls_sql ) - ( ll_pos + 3 ) ) 
		end if
		ls_sql = " and ( " + ls_sql + ") "
end choose

ls_sql += " order by disp_ship.ds_id desc"

ls_ModString = "DataWindow.Table.Select='" &
	+ is_OriginalSelect + ls_sql + "'"

ls_rc = dw_query_results.Modify(ls_ModString)
IF ls_rc = "" THEN
ELSE
	MessageBox("Status", "Modify Failed" + ls_rc)
END IF

// Retrieve result data
ll_rows = dw_query_results.Retrieve( )

if ll_rows > 0 then
	//	If suppress repeating values checked then delete duplicate rows from display 
	IF dw_query.Object.suppress_repeating_values[1] = 'Y' THEN
		string ls_saved_sort
		ls_saved_sort = dw_query_results.Describe("DataWindow.Table.Sort")
		dw_query_results.SetSort("di_our_ratetype A, di_our_rate A, di_description A, di_item_id A")
		long ll_index = 1
		string ls_prev_descr, ls_descr, ls_prev_ratetype, ls_ratetype
		decimal ld_prev_rate, ld_rate
		do while TRUE
			if ll_index > dw_query_results.RowCount() then exit
			ls_descr = dw_query_results.GetItemString( ll_index, "di_description" )
			ls_ratetype = dw_query_results.GetItemString( ll_index, "di_our_ratetype" )
			ld_rate = dw_query_results.GetItemDecimal( ll_index, "di_our_rate" )
			if ll_index = 1 then
				ls_prev_descr = ls_descr
				ls_prev_ratetype = ls_ratetype
				ld_prev_rate = ld_rate
				ll_index++
				continue
			end if
			if ls_descr = ls_prev_descr and ls_ratetype = ls_prev_ratetype and ld_rate = ld_prev_rate then
				dw_query_results.DeleteRow(ll_index)
				continue
			else			
				ls_prev_descr = ls_descr
				ls_prev_ratetype = ls_ratetype
				ld_prev_rate = ld_rate
				ll_index++
				continue
			end if
		loop
		dw_query_results.SetSort(ls_saved_sort)
		dw_query_results.ResetUpdate()
	end if
end if

// Set limit back to unlimited
ls_sql = "SET ROWCOUNT 0"
execute immediate :ls_sql;
commit;

dw_query_results.SetRedraw(TRUE)


end event

event constructor;// enable multi-row-select-ability
THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (2) //2 = extended row select service

of_setinsertable ( false )
of_setDeleteable ( false )

of_SetAutoSort ( TRUE )

THIS.SetTransObject (  sqlca ) 
is_OriginalSelect =dw_query_results.Describe("DataWindow.Table.Select")

n_cst_presentation_RateTable 	lnv_Presentation 
lnv_Presentation.of_SetPresentation ( THIS )


end event

event doubleclicked;cb_select.Event clicked()
n_Cst_beo_Item	lnv_Item
Long	ll_itemId

lnv_Item = inv_attribs.of_GetTargetitem( ) 

IF isValid ( lnv_Item ) THEN
	ll_itemId = THIS.GetitemNumber ( row , "di_item_id" )
	inv_attribs.of_Setapplyid( ll_itemId )
	lnv_Item.of_applyratelookupresults(  inv_attribs )
	CLOSE (Parent)
END IF

end event

event rbuttondown;call super::rbuttondown;string 	lsa_parm_labels[]
any 		laa_parm_values[]


IF dwo.name = "di_shipment_id" AND row > 0 THEN

	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "SHIPMENT_PERFORM_OPEN"
	lsa_parm_labels[2] = "TARGET_ID"
	laa_parm_values[2] = this.getitemnumber(row, "di_shipment_id")
	
	IF This.GetSelectedRow ( 0 ) > 0 THEN
		
		lsa_parm_labels[3] = "TARGET_IDS"
		laa_parm_values[3] = This.Object.di_shipment_id.Selected
		
	END IF
	
	f_pop_standard(lsa_parm_labels, laa_parm_values)
END IF
end event

type dw_selection from u_dw within w_rate_query
event ue_import ( )
integer x = 5
integer y = 1316
integer width = 4059
integer height = 540
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_itemselection"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event ue_import();// parm of "" will force getFileOpenName ( )

IF inv_attribs.of_LoadDatastoreFromFile ("") = 1 THEN 

	THIS.SelectRow( THIS.RowCount( ),TRUE )
	IF Isvalid ( inv_attribs ) THEN
		inv_attribs.OF_SetCurrentRow ( THIS.RowCount( ) )
	END IF
	THIS.ScrollToRow( THIS.RowCount( ) )
END IF
end event

event pfc_deleterow;//long ll_CurrentRow
//
//ll_currentRow = this.GetselectedRow(0)
//
//CALL Super::pfc_deleteRow
//
//IF AncestorReturnValue = 1 THEN
//	inv_attribs.Of_DeleteRow ( ll_currentRow )
//END IF
//
//return AncestorReturnValue


long 	ll_row, &
		ll_RowCount
		
integer	il_ndx

ll_RowCount = this.RowCount()

FOR il_ndx = 0 to ll_RowCount

	ll_Row = this.GetSelectedRow ( 0 )
	if ll_row > 0 then
		this.RowsDiscard ( ll_row, ll_row, Primary! ) 
		il_ndx = ll_Row -1
	else
		il_ndx = ll_RowCount
	end if

NEXT

IF this.RowCount() > 0 THEN
	this.SelectRow ( 1, true )
END IF

return 0
end event

event constructor;// enable multi-row-select-ability
THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (2) //2 = extended row select service
ib_disableclosequery = true
of_SetAutoSort ( TRUE )
of_setinsertable ( false ) 

n_cst_presentation_RateTable 	lnv_Presentation 
lnv_Presentation.of_SetPresentation ( THIS )


end event

event clicked;call super::clicked;
IF Row > 0 THEN
	inv_attribs.OF_SetCurrentRow ( row ) 
ELSE 
	inv_attribs.OF_SetCurrentRow ( THIS.GetselectedRow (0) )
END IF

end event

event doubleclicked;dw_Selection.Event pfc_DeleteRow()
end event

event rowfocuschanged;call super::rowfocuschanged;IF ISValid ( inv_attribs ) AND currentrow > 0 THEN
	inv_attribs.of_SetCurrentRow ( currentrow ) 
END IF
end event

event rbuttondown;call super::rbuttondown;string 	lsa_parm_labels[]
any 		laa_parm_values[]


IF dwo.name = "di_shipment_id" THEN

	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "SHIPMENT_PERFORM_OPEN"
	lsa_parm_labels[2] = "TARGET_ID"
	laa_parm_values[2] = this.getitemnumber(row, "di_shipment_id")
	
	IF This.GetSelectedRow ( 0 ) > 0 THEN
		
		lsa_parm_labels[3] = "TARGET_IDS"
		laa_parm_values[3] = This.Object.di_shipment_id.Selected
		
	END IF
	
	f_pop_standard(lsa_parm_labels, laa_parm_values)
END IF
end event

type dw_query from datawindow within w_rate_query
integer x = 5
integer y = 8
integer width = 4055
integer height = 376
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_itemselection_hdr"
boolean border = false
boolean livescroll = true
end type

event itemchanged;/*
	If the text fields are changed, then we must change the
	corresponding id field which will be used in the query.
*/
integer 	li_return
string	ls_work = "ANY!", &
			ls_text

s_co_info lstr_company


choose case dwo.name
		
	case "billtoid_text"
		IF len ( trim ( data ) ) > 0 THEN
			ls_work = "BILLTO!"
			if gnv_cst_companies.of_select(lstr_company, ls_work, true, data, false, 0, true, true) = 1 then
				this.object.billtoid[row] = lstr_company.co_id
				this.setitem(row, dwo.name, lstr_company.co_name)
				li_return = 2
			else
				li_return = 2
			end if
		ELSE
			this.object.billtoid[row] = 0
			long lla_NullIds[]
			ila_billtoids=lla_NullIds
		END IF
		
	case "origin_text"
		IF len ( trim ( data ) ) > 0 THEN
			if gnv_cst_companies.of_select(lstr_company, ls_work, true, data, false, 0, true, true) = 1 then
				this.object.origin[row] = lstr_company.co_id
				this.setitem(row, dwo.name, lstr_company.co_name)
				this.object.pickup_zip[row] = ''
				li_return = 2
			else
				li_return = 2
			end if
		ELSE
			this.object.origin[row] = 0
			il_Origin = 0
		END IF
		
	case "findest_text"
		IF len ( trim ( data ) ) > 0 THEN
			if gnv_cst_companies.of_select(lstr_company, ls_work, true, data, false, 0, true, true) = 1 then
				this.object.findest[row] = lstr_company.co_id
				this.setitem(row, dwo.name, lstr_company.co_name)
				this.object.deliver_zip[row] = ''
				li_return = 2
			else
				li_return = 2
			end if
		ELSE
			this.object.findest[row] = 0
			il_FinDest = 0
		END IF
		
	case "pickup_zip"
		ls_text = this.object.origin_text[row]
		IF len ( ls_text ) > 0 THEN
			this.object.origin_text[row] = ''
		END IF
		
	case "deliver_zip"
		ls_text = this.object.findest_text[row]
		IF len ( ls_text ) > 0 THEN
			this.object.findest_text[row] = ''
		END IF

		
end choose

return li_return

end event

event itemfocuschanged;string ls_name

ls_name = dwo.name

choose case ls_name

	case "weight_from", "weight_to", "miles_from", "miles_to", "number_of_rows"
		SelectText ( 1, len ( ls_name ) )
	
end choose

PARENT.wf_cleartempvalues( )
end event

event constructor;n_cst_presentation_RateTable 	lnv_Presentation 
lnv_Presentation.of_SetPresentation ( THIS )
n_cst_Presentation_AmountType	lnv_ATPres
lnv_ATPres.of_SetPresentation ( THIS )


end event

type cb_retrieve from commandbutton within w_rate_query
integer x = 3099
integer y = 284
integer width = 338
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrie&ve"
end type

event clicked;IF dw_query.AcceptText ( ) = 1 THEN
	dw_query_results.Event ue_retrieve()
END IF
end event

type cb_select from commandbutton within w_rate_query
integer x = 3470
integer y = 284
integer width = 279
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sele&ct"
end type

event clicked;long 	ll_row, &
		ll_RowCount
		
integer	il_ndx
n_ds	lds_addrow
lds_addrow = Create n_ds
lds_addrow.Dataobject = "d_itemselection"
ll_RowCount = dw_query_results.RowCount()

FOR il_ndx = 0 to ll_RowCount

	ll_Row = dw_query_results.GetSelectedRow ( il_ndx )
	if ll_row > 0 then
//		dw_query_results.RowsCopy( ll_row, ll_row, Primary!, dw_selection, 1, Primary! )
		dw_query_results.RowsCopy( ll_row, ll_row, Primary!, lds_addrow, 1, Primary! )
		inv_attribs.of_addrow ( lds_addrow )	
		lds_addrow.Reset ()
		dw_query_results.SelectRow ( ll_row, FALSE )
		il_ndx = ll_Row -1
	else
		il_ndx = ll_RowCount
	end if

NEXT
//inv_ds.Reset()
inv_ds = inv_attribs.Of_GetDatastore ( )
inv_attribs.OF_SetCurrentRow ( dw_selection.RowCount() ) 
dw_Selection.SelectRow ( 0, false )
dw_selection.SelectRow ( dw_selection.RowCount(), true )
dw_selection.ScrollToRow ( dw_selection.RowCount() ) 
destroy lds_addrow
end event

type cb_delete_selection from commandbutton within w_rate_query
integer x = 3776
integer y = 1212
integer width = 283
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Delete"
end type

event clicked;/*
	This button is a keyboard alternative for deleting rows
	from dw_selection (selected rows).
*/
dw_Selection.Event pfc_DeleteRow()


end event

type cb_reset from commandbutton within w_rate_query
integer x = 3781
integer y = 284
integer width = 279
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Res&et"
end type

event clicked;string 	ls_null
long		lla_NullIds[]

setnull(ls_null)

dw_Query.Reset()
dw_Query.InsertRow ( 0 )
//dw_query.object.number_of_rows[1] = 20
//dw_query.object.like_clause[1] = ls_null
//dw_query.object.filter_column[1] = ls_null
//dw_query.Object.suppress_repeating_values[1] = 'N'
//dw_query.object.weight_from[1] = 0
//dw_query.object.weight_to[1] = 0
//dw_query.object.miles_from[1] = 0
//dw_query.object.miles_to[1]  = 0
//dw_query.object.billtoid[1] = 0
//dw_query.object.origin[1] = 0 
//dw_query.object.findest[1] = 0 
//dw_query.object.billtoid_text[1] = ls_null
//dw_query.object.origin_text[1] = ls_null 
//dw_query.object.findest_text[1] = ls_null 
dw_query_results.Reset ( )
il_findest = 0
il_origin = 0
ila_billtoids[] = lla_NullIDs

ib_alreadyclear = FALSE

//3.5.18 BKW  with the addition of cbx_SourceShipmentsOnly, it's no longer necessary to
//null this.  This way, user can reset criteria, but still have option of referencing the shipments.
//ila_shipmentids[] = lla_NullIDs

dw_Query.SetFocus()
end event

type cb_import from commandbutton within w_rate_query
integer x = 3470
integer y = 1212
integer width = 279
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Import"
end type

event clicked;dw_selection.Event ue_Import ( )
end event

type st_1 from u_st_label within w_rate_query
integer x = 9
integer y = 1244
integer width = 1138
boolean bringtotop = true
long backcolor = 12632256
string text = "Selected Rates (available for pasting)"
end type

type cbx_sourceshipmentsonly from checkbox within w_rate_query
integer x = 3209
integer y = 200
integer width = 850
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Show Source Shipments Only"
boolean lefttext = true
end type

