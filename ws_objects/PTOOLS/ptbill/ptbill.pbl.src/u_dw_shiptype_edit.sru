$PBExportHeader$u_dw_shiptype_edit.sru
forward
global type u_dw_shiptype_edit from u_dw
end type
end forward

global type u_dw_shiptype_edit from u_dw
integer width = 2523
integer height = 1176
string dataobject = "d_shiptype_edit"
boolean vscrollbar = false
event type integer ue_rowadded ( long al_row )
event ue_setredraw ( boolean ab_value )
event type long ue_getfirstrowonlistpage ( )
event ue_scrolllisttorow ( long al_row )
end type
global u_dw_shiptype_edit u_dw_shiptype_edit

type variables
//Handle to a list dw for this dw to stay in sync with.
//The attribute is optional, and may be set directly.
Public DataWindow idw_List
end variables

forward prototypes
public function integer of_setdefault (long al_row, boolean ab_value)
end prototypes

event ue_setredraw;THIS.SetRedraw ( ab_value )

end event

public function integer of_setdefault (long al_row, boolean ab_value);Boolean	lb_Continue = TRUE
String	ls_Context
String	ls_Category
String	ls_OldFilter
String	ls_Filter
Long		ll_ID
Long		ll_RowCount 
Long		ll_i
Int		li_Return	= 1

THIS.SetRedraw ( FALSE )

ll_RowCount = THIS.RowCount ( ) 
ls_OldFilter = THIS.object.datawindow.table.Filter
IF ls_OldFilter = "?" THEN
	ls_oldFilter = ""
END IF

IF al_Row <= 0 OR al_Row > ll_RowCount THEN
	lb_Continue = FALSE
END IF

IF lb_Continue THEN
	lb_Continue = this.object.st_status[al_row] = "K"
END IF

IF lb_Continue THEN
	lb_Continue =  ab_Value 
	// we can end here b/c we allow them to remove default 
END IF
	
IF lb_Continue THEN
	ll_ID = Long (  this.object.st_id[al_row] )
END IF
	
IF lb_Continue THEN
	IF this.object.st_brokerage[al_row] = 'T' THEN
		ls_Context = "BROKERAGE"
	ELSEIF this.object.intermodal[al_row] = 'T' THEN
		ls_Context = "INTERMODAL"
	ELSE
		ls_Context = "DISPATCH"
	END IF
END IF

IF lb_Continue THEN
	CHOOSE CASE ls_Context 
		CASE "BROKERAGE"
			ls_Filter = "st_status = 'K' and st_brokerage = 'T'"
		CASE "INTERMODAL"
			ls_Filter = "st_status = 'K' and intermodal = 'T'"
		CASE "DISPATCH"
			ls_Filter = "st_status = 'K' and st_brokerage <> 'T' AND intermodal <> 'T' "
		CASE ELSE
			lb_Continue = FALSE
			li_Return = -1
	END CHOOSE
END IF
			
IF lb_Continue THEN
	THIS.SetFilter( ls_Filter ) 
	THIS.Filter ( ) 
	ll_RowCount = THIS.RowCount ( )
	
	FOR ll_i = 1 TO ll_RowCount
		IF Long ( THIS.object.st_id [ ll_i ] ) = ll_id THEN
			this.object.st_default[ll_i] = "T"
		ELSE
			this.object.st_default[ll_i] = "F"
		END IF
	NEXT 
	
	THIS.SetFilter ( ls_OldFilter )
	THIS.Filter ( )
	
	
	IF IsValid ( idw_List ) THEN
		idw_list.post setredraw(true)
	END IF
	
	
END IF	
	
THIS.SetRedraw ( TRUE )

RETURN li_Return 





end function

event pfc_preupdate;call super::pfc_preupdate;//Extending Ancestor

Integer	li_Return
Long		ll_Row
String	ls_Work, &
			ls_New_DBString


li_Return = AncestorReturnValue


IF li_Return = 1 THEN

	do
		ll_row = This.getnextmodified(ll_row, primary!)

		if ll_row > 0 then
			ls_new_dbstring = ""
	
			ls_work = This.object.st_name[ll_row]
			if isnull(ls_work) then ls_work = ""
			ls_new_dbstring += "NAME~t" + ls_work + "~n"
	
			ls_work =This.object.st_status[ll_row]
			if isnull(ls_work) then ls_work = ""
			ls_new_dbstring += "STATUS~t" + ls_work + "~n"
	
			//An entry for LOGO_ID is only included if a value has been specified
			ls_work = string(This.object.st_logo[ll_row])
			if not isnull(ls_work) then &
				ls_new_dbstring += "LOGO_ID~t" + ls_work + "~n"
	
			//An entry for ACCT_AR is only included if a value has been specified
			ls_work = This.object.st_accounting_ar[ll_row]
			if not isnull(ls_work) then &
				ls_new_dbstring += "ACCT_AR~t" + ls_work + "~n"
	
			//An entry for ACCT_SLS is only included if a value has been specified
			ls_work = This.object.st_accounting_sales[ll_row]
			if not isnull(ls_work) then &
				ls_new_dbstring += "ACCT_SLS~t" + ls_work + "~n"
	
			//An entry for ACCT_ACCESSORIALSALES is only included if a value has been specified
			ls_work = This.object.st_accounting_accessorialsales[ll_row]
			if not isnull(ls_work) then &
				ls_new_dbstring += "ACCT_ACCESSORIALSALES~t" + ls_work + "~n"
	
			//An entry for BROKERAGE is only included if it is true (=T)
			ls_work = This.object.st_brokerage[ll_row]
			if ls_work = "T" then &
				ls_new_dbstring += "BROKERAGE~t" + ls_work + "~n"
	
			//An entry for DEFAULT is only included if it is true (=T)
			ls_work = This.object.st_default[ll_row]
			if ls_work = "T" then &
				ls_new_dbstring += "DEFAULT~t" + ls_work + "~n"
	
			//An entry for EXPEDITE is only included if it is true (=T)
			ls_work = This.object.st_expedite[ll_row]
			if ls_work = "T" then &
				ls_new_dbstring += "EXPEDITE~t" + ls_work + "~n"

			//An entry for TYPEONLY is only included if it is true (=T)
			ls_work = This.object.st_TypeOnly[ll_row]
			if ls_work = "T" then &
				ls_new_dbstring += "TYPEONLY~t" + ls_work + "~n"

			//An entry for DIVISIONONLY is only included if it is true (=T)
			ls_work = This.object.st_DivisionOnly[ll_row]
			if ls_work = "T" then &
				ls_new_dbstring += "DIVISIONONLY~t" + ls_work + "~n"
	
			//An entry for TERMS is only included if a value has been specified
			ls_work = This.object.st_terms[ll_row]
			if not isnull(ls_work) then &
				ls_new_dbstring += "TERMS~t" + ls_work + "~n"
	
			//An entry for REMIT_01 is only included if a value has been specified
			ls_work = This.object.st_remit_01[ll_row]
			if not isnull(ls_work) then &
				ls_new_dbstring += "REMIT_01~t" + ls_work + "~n"
	
			//An entry for REMIT_02 is only included if a value has been specified
			ls_work = This.object.st_remit_02[ll_row]
			if not isnull(ls_work) then &
				ls_new_dbstring += "REMIT_02~t" + ls_work + "~n"
	
			//An entry for REMIT_03 is only included if a value has been specified
			ls_work = This.object.st_remit_03[ll_row]
			if not isnull(ls_work) then &
				ls_new_dbstring += "REMIT_03~t" + ls_work + "~n"
	
			//An entry for REMIT_04 is only included if a value has been specified
			ls_work = This.object.st_remit_04[ll_row]
			if not isnull(ls_work) then &
				ls_new_dbstring += "REMIT_04~t" + ls_work + "~n"
	
			//An entry for REMIT_05 is only included if a value has been specified
			ls_work = This.object.st_remit_05[ll_row]
			if not isnull(ls_work) then &
				ls_new_dbstring += "REMIT_05~t" + ls_work + "~n"
	
			//An entry for ACCT_CO is only included if a value has been specified
			ls_work = This.object.st_accounting_company[ll_row]
			if not isnull(ls_work) then &
				ls_new_dbstring += "ACCT_CO~t" + ls_work + "~n"
	
			//An entry for BILLSEQ is only included if a value has been specified
			ls_work = string(This.object.st_billing_sequence[ll_row])
			if not isnull(ls_work) then &
				ls_new_dbstring += "BILLSEQ~t" + ls_work + "~n"
				
			ls_work = This.object.intermodal[ll_row]
			if isnull(ls_work) then ls_work = ""
			ls_new_dbstring += "INTERMODAL~t" + ls_work + "~n"	
	
			This.object.st_dbstring[ll_row] = ls_new_dbstring
		end if
	loop while ll_row > 0

END IF

RETURN li_Return
end event

event pfc_postupdate;call super::pfc_postupdate;Int		li_Return

li_Return = AncestorReturnValue

IF li_Return = 1 THEN

	gds_shiptype.reset()
	
	if THIS.rowcount() > 0 then
		if THIS.rowscopy(1, THIS.rowcount(), primary!, gds_shiptype, 9999, primary!) = 1 &
			then gstr_list_settings.b_shiptypes_retrieved = true &
			else gstr_list_settings.b_shiptypes_retrieved = false
	end if
	

END IF

Return li_Return
end event

event pfc_validation;call super::pfc_validation;String 	ls_Work
Int		li_Rtn

li_Rtn = AncestorReturnValue

IF li_Rtn = 1 THEN
	
	ls_work = "len(st_name) = 0 or isnull(st_name) or st_name = '" +&
	THIS.object.st_name.initial + "'"
	
	if THIS.find(ls_work, 1, THIS.rowcount()) > 0 then
		messagebox("Data Validation", "Required information is missing: "+&
			"Not all entries have a Display Name.")
		li_Rtn = -1
	end if
END IF

Return li_Rtn
end event

event pfc_retrieve;

datawindowchild ldwc_logo_list, ldwc_billseq_list
long ll_result, ll_rowcount
n_cst_ship_type lnv_cst_ship_type
n_cst_billseq lnv_cst_billseq

if lnv_cst_ship_type.of_ready(true) = false then return -1
if lnv_cst_billseq.of_ready(true) = false then return -1

ll_result = THIS.getchild("st_billing_sequence", ldwc_billseq_list)
if ll_result = -1 then return -1

ll_rowcount = lnv_cst_billseq.ids_billseq.rowcount()
ldwc_billseq_list.reset()

if ll_rowcount > 0 then
	lnv_cst_billseq.ids_billseq.rowscopy(1, ll_rowcount, primary!, ldwc_billseq_list, &
		9999, primary!)
end if

if ldwc_billseq_list.insertrow(1) = 1 then
	ldwc_billseq_list.setitem(1, "bs_id", null_long)
	ldwc_billseq_list.setitem(1, "bs_name", "[NONE]")
	ldwc_billseq_list.setitem(1, "bs_definition", "[NONE]")
else
	return -1
end if

ll_result = THIS.getchild("st_logo", ldwc_logo_list)
if ll_result = -1 then return -1

ldwc_logo_list.settransobject(sqlca)
ll_result = ldwc_logo_list.retrieve()

if ll_result = -1 then
	rollback ;
	return -1
else
	commit ;
end if

if ldwc_logo_list.insertrow(1) = 1 then
	ldwc_logo_list.setitem(1, "gd_id", null_long)
	ldwc_logo_list.setitem(1, "gd_name", "[NONE]")
else
	return -1
end if

//dw_list.setredraw(false)
THIS.setredraw(false)
THIS.reset()

if gds_shiptype.rowcount() > 0 then
	gds_shiptype.rowscopy(1, gds_shiptype.rowcount(), primary!, THIS, 9999, primary!)
	THIS.sort()
	THIS.resetupdate()
end if

THIS.setredraw(true)
//dw_list.setredraw(true)


return 1
end event

event constructor;
THIS.EVENT PFC_Retrieve ( )

of_SetDeleteable ( False )
end event

event pfc_addrow;call super::pfc_addrow;//Extending Ancestor to set Id for the new row.

long 	ll_row, ll_checkloop, ll_new_id
Long	ll_RowCount 


IF AncestorReturnValue > 0 THEN

	ll_Row = AncestorReturnValue
	ll_RowCount = THIS.rowcount()
	
	ll_new_id = 2200  //2201 is the start of the valid id range for shipment types in system_settings.
	for ll_checkloop = 1 to ll_RowCount
		if THIS.object.st_id[ll_checkloop] > ll_new_id then &
			ll_new_id =THIS.object.st_id[ll_checkloop]
	next
	ll_new_id ++
	
	THIS.object.st_id[ll_row] = ll_new_id
	THIS.scrolltorow(ll_row)

	THIS.setcolumn("st_name")
	THIS.Event ue_RowAdded ( ll_Row )

ELSE

	messagebox("Create New Shipment Type / Division", "Could not process request.  Request cancelled.", &
		exclamation!)

END IF


Return AncestorReturnValue
end event

event pfc_insertrow;//override
Return THIS.Event pfc_AddRow ( )

end event

event itemchanged;call super::itemchanged;Integer	li_rowloop
char	lch_brokerage, &
		lch_default_check, &
		lch_brokerage_check
Long	ll_Return

ll_Return = AncestorReturnValue


CHOOSE CASE Lower ( dwo.name )

CASE "st_status"
	if data = "D" then
		this.object.st_default[row] = "F"
		IF IsValid ( idw_List ) THEN
			idw_list.post setredraw(true)
		END IF
	end if

CASE "st_default"
	Long	ll_FirstRow
	ll_FirstRow = Long ( THIS.Event ue_GetFirstRowOnListPage ( ) )
	THIS.Event ue_SetRedraw ( FALSE ) 
	
	IF THIS.of_SetDefault ( row , data = 'T' ) <> 1 THEN
		ll_Return = 2
	END IF
	
	THIS.Event ue_ScrollListToRow ( ll_FirstRow )
	
	// In Ver PB 9.0 ScrollToRow scrolls the detail row same as master
	// unlike 6.5, hence the detail row needs to be seperately scrolled to the current row
	// as coded below. 
	This.ScrollToRow(Row) // zmc - 2-3-04
	
	THIS.SetRow ( row )
	THIS.Event ue_SetRedraw (  TRUE ) 
	
//	if this.object.st_status[row] = "K" then
//		if data = "T" then
//			lch_brokerage = this.object.st_brokerage[row]
//			for li_rowloop = 1 to this.rowcount()
//				if li_rowloop = row then continue
//				lch_default_check = this.object.st_default[li_rowloop]
//				lch_brokerage_check = this.object.st_brokerage[li_rowloop]
//				if lch_default_check = "T" then
//					if lch_brokerage = "T" then
//						if lch_brokerage_check = "T" then &
//							this.object.st_default[li_rowloop] = "F"
//					else
//						if lch_brokerage_check = "T" then continue
//						this.object.st_default[li_rowloop] = "F"
//					end if
//				end if
//			next
//			IF IsValid ( idw_List ) THEN
//				idw_list.post setredraw(true)
//			END IF
//		end if
//	else
//		beep(1)
//		ll_Return = 2
//	end if

CASE "st_brokerage"
	if this.object.st_status[row] = "K" then
		choose case this.getitemstatus(row, 0, primary!)
		case new!, newmodified!
			this.object.st_default[row] = "F"
			THIS.object.Intermodal[row] = "F"
			IF IsValid ( idw_List ) THEN
				idw_list.post setredraw(true)
			END IF
			
		case else
			messagebox("Change Brokerage Designation", "The brokerage designation cannot "+&
				"be changed once the shipment type has been saved.")
			ll_Return = 2
		end choose
	else
		beep(1)
		ll_Return = 2
	end if

CASE "st_expedite"
	if this.object.st_status[row] = "K" then
	else
		beep(1)
		ll_Return = 2
	end if

//Enforce the rule that "TypeOnly" and "DivisionOnly" can't both be true for one row.

CASE Lower ( "st_TypeOnly" )

	IF Data = "T" THEN
		This.SetItem ( Row, "st_DivisionOnly", "F" )
	END IF

CASE Lower ( "st_DivisionOnly" )

	IF Data = "T" THEN
		This.SetItem ( Row, "st_TypeOnly", "F" )
	END IF
	
CASE "intermodal"
	
	IF data = "T" THEN
		IF this.object.st_brokerage[row] = "T" THEN
			choose case this.getitemstatus(row, 0, primary!)
				case new!, newmodified!	
					THIS.SetItem ( Row , "st_Brokerage" , "F" )
				CASE ELSE
					messagebox("Change Brokerage Designation", "This change would require the brokerage designation to be changed. The brokerage designation cannot "+&
					"be changed once the shipment type has been saved.")
					ll_Return = 2
			END CHOOSE
		END IF
	END IF
	IF IsValid ( idw_List ) THEN
		idw_list.post setredraw(true)
	END IF


END CHOOSE

RETURN ll_Return
end event

event rowfocuschanged;call super::rowfocuschanged;//Scroll the list dw, if one has been specified.

IF CurrentRow > 0 AND IsValid ( idw_List ) THEN
	idw_List.ScrollToRow ( CurrentRow )
END IF
end event

on u_dw_shiptype_edit.create
end on

on u_dw_shiptype_edit.destroy
end on

