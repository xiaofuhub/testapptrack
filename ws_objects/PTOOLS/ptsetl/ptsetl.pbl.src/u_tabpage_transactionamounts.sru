$PBExportHeader$u_tabpage_transactionamounts.sru
$PBExportComments$TransactionAmounts (Tab Page from PBL map PTSetl) //@(*)[84545728|1568]
forward
global type u_tabpage_transactionamounts from u_tabpage_amounts
end type
end forward

global type u_tabpage_transactionamounts from u_tabpage_amounts
integer height = 784
long backcolor = 12632256
string text = "TransactionAmounts"
end type
global u_tabpage_transactionamounts u_tabpage_transactionamounts

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function integer of_autorate (ref n_cst_ratedata anva_ratedata[], string as_ratecode, decimal ac_quantity, long al_billto, string as_orig, string as_dest)
end prototypes

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null

Choose Case Lower(as_name)
Case "transactionmanager"
     Return in_transactionmanager
End Choose

Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
any la_any
anv_parameters.GetParameterValue2(as_name, la_any)
Choose Case Lower(as_name)
   Case "transactionmanager"
     If IsNull(la_any) Or Not isValid(la_any) Then
           SetNull(in_transactionmanager)
     ElseIf ClassName(la_any) = "any" Then
           SetNull(in_transactionmanager)
     Else
           in_transactionmanager = la_any
     End If
End Choose

Return 1
//@(text)--

end function

public function integer of_autorate (ref n_cst_ratedata anva_ratedata[], string as_ratecode, decimal ac_quantity, long al_billto, string as_orig, string as_dest);integer	li_return = 1
long	ll_errorcount
string	ls_errormessage
n_cst_bso_rating	lnv_rating
n_cst_ratedata		lnva_ratedata[]
n_cst_OFRError	lnva_Errors[]

//this will set substitutions and fallbacks
lnva_ratedata[1] = create n_cst_Ratedata
lnva_ratedata[1].of_SetCodename(as_ratecode)
lnva_ratedata[1].of_setCategory(n_cst_constants.ci_Category_Payables)
lnva_ratedata[1].of_setTotalQuantity (ac_quantity)
lnva_ratedata[1].of_settotalcount(ac_quantity)
lnva_ratedata[1].of_settotalweight(ac_quantity)
lnva_ratedata[1].of_settotalmiles(ac_quantity)

lnva_ratedata[1].of_setbilltoid(al_billto)
lnva_ratedata[1].of_setOriginzone(as_orig)
lnva_ratedata[1].of_setDestinationZone(as_dest)

lnv_rating = create n_cst_bso_rating

lnv_rating.ClearOFRErrors ( )
lnv_Rating.of_Initialize()
lnv_rating.of_autorate(lnva_ratedata, true)

SetPointer(HourGlass!)

lnv_rating.GetOFRErrors ( lnva_Errors )
ll_errorcount = lnv_rating.GetErrorCount()
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
	
	li_return = -1
else
	anva_ratedata = lnva_ratedata
	li_return = 1
end if

destroy lnv_rating

return li_return

end function

on u_tabpage_transactionamounts.create
call super::create
end on

on u_tabpage_transactionamounts.destroy
call super::destroy
end on

type dw_amounts from u_tabpage_amounts`dw_amounts within u_tabpage_transactionamounts
integer y = 36
integer taborder = 10
end type

event dw_amounts::doubleclicked;wf_DisplayDetail ( This )
end event

event dw_amounts::itemchanged;call super::itemchanged;// If these columns change then we want the change 
// reflected in the total on the header dw on the top of the window
integer li_return
li_return = AncestorReturnValue

CHOOSE CASE DWO.NAME
	CASE "amountowed_rate", "amountowed_quantity", "amountowed_amount"
		this.Setitem(row, 'ratecodename', 'CUSTOM')
		PARENT.Event ue_TransactionModified (  )
		
	CASE "ratecodename"
			n_cst_ratedata	lnva_ratedata[]
			n_cst_AnyArraySrv	lnv_ArraySrv
			if parent.of_autorate(lnva_ratedata, data, this.object.amountowed_quantity[row], this.object.billtoid[row], &
										 this.object.originzone[row],this.object.destinationzone[row]) = 1 then
				if lnva_ratedata[1].of_getrate() > 0 then
					if lnva_ratedata[1].of_Getratetype() = appeon_constant.cs_RateUnit_Code_Flat then
						this.setitem(row,'amountowed_quantity',1)
					else
						this.setitem(row,'amountowed_quantity',lnva_ratedata[1].of_GetTotalCount())
					end if
					this.setitem(row,'amountowed_amount', 0)
					this.setitem(row,'amountowed_rate', lnva_ratedata[1].of_getrate())
				else
					this.setitem(row,'amountowed_amount', 0)
					this.setitem(row,'amountowed_rate', 0)
				end if
				if len(trim(lnva_ratedata[1].of_getdescription())) > 0 then
					this.setitem(row,'amountowed_description', lnva_ratedata[1].of_getdescription())
				end if
				this.setitem(row,'amountowed_type', lnva_ratedata[1].of_getamounttype())
				PARENT.Event ue_TransactionModified (  )
			else
				this.SetText (this.object.ratecodename.primary.original[row])
				dw_amountdetail.object.ratecodename[ dw_amountdetail.GetRow ( ) ] = this.object.ratecodename.primary.original[row]
				li_return = 1
			end if
			lnv_ArraySrv.of_Destroy ( lnva_RateData )
			
END CHOOSE

this.Setitem(row, 'lastmodifiedby', gnv_app.of_GetUserid())
dw_amountdetail.inv_UILink.UpdateRequestor ( dw_amountdetail.GetRow ( ) )


RETURN li_return
end event

event dw_amounts::pfc_deleterow;call super::pfc_deleterow;IF AncestorReturnValue = SUCCESS THEN
	PARENT.Event ue_TransactionModified (  )
	PARENT.Event ue_Refresh ( )
END IF

RETURN AncestorReturnValue
end event

event dw_amounts::pfc_insertrow;call super::pfc_insertrow;//THIS IS DIFFERENT FROM OLD CODE - NO EXTENSION OR OVERRIDE IN OLD CODE

//IF dw_amountdetail.AcceptText ( ) = -1 THEN
//
//	RETURN -1
//
//END IF
//
//dw_amountdetail.Hide ( )
//
//CALL Super::pfc_InsertRow
//
//IF AncestorReturnValue > 0 THEN  //rc = RowNumber
//	dw_amountdetail.inv_UILink.RefreshFromBcm ( )
//
//		
//		this.TriggerEvent ( "pfc_RowChanged" )
//		dw_amountdetail.inv_UILink.UpdateRequestor ( dw_amountdetail.GetRow ( ) )
//		dw_amountdetail.Show ( )
//		dw_amountdetail.SetFocus ( )
//		
//END IF
//
RETURN AncestorReturnValue
end event

event dw_amounts::pfc_predeleterow;call super::pfc_predeleterow;Integer li_Return

li_Return = AncestorReturnValue

IF li_Return = CONTINUE_ACTION THEN

	IF dw_amountdetail.AcceptText ( ) = -1 THEN

		RETURN PREVENT_ACTION

	END IF

	dw_amountdetail.Hide ( )

END IF

RETURN li_Return
end event

event dw_amounts::ue_prenew;//Determine the transaction that the new amount will be assigned to.
//See description and return specs in ancestor.

RETURN parent.event ue_GetActiveTransaction ( anv_transaction )


end event

event dw_amounts::rowfocuschanged;call super::rowfocuschanged;If currentrow > 0 and this.rowcount () > 0 THEN
	IF dw_amountdetail.visible=true THEN
		dw_amountdetail.SetFilter( "amountowed_id = " + string (this.object.amountowed_id [currentrow]) )
		dw_amountdetail.filter ( )
	END IF
END IF


end event

event dw_amounts::pfc_addrow;IF dw_amountdetail.AcceptText ( ) = -1 THEN
	RETURN -1
END IF

CALL Super::pfc_AddRow

IF AncestorReturnValue > 0 THEN
	
	string	ls_entity
	date		ld_start,ld_end
	n_cst_beo_transaction	lnv_Transaction
	
	PARENT.Event ue_GetActiveTransaction(lnv_Transaction)
	if isvalid(lnv_Transaction) then
		ld_start = lnv_Transaction.of_GetStartDate()
		ld_end = lnv_Transaction.of_GetEndDate()
		this.setitem(AncestorReturnValue,'amountowed_startdate',ld_start)
		this.setitem(AncestorReturnValue,'amountowed_enddate',ld_end)
	end if
		
	if isvalid(in_transactionmanager) then
		ls_Entity = in_transactionmanager.of_DescribeEntity ( this.object.amountowed_fkEntity[AncestorReturnValue]  , 0)
		if len(ls_entity) > 0 then
			this.setitem(AncestorReturnValue,'amountowed_driver',ls_entity)
		end if
	end if

	this.inv_UILink.UpdateRequestor ( AncestorReturnValue)
	PARENT.Event ue_TransactionModified (  )
	
	
	dw_amountdetail.inv_UILink.RefreshFromBcm ( )
	
	dw_amountdetail.setfilter ( "amountowed_id = " + string ( this.object.amountowed_id[AncestorReturnValue]) )
	dw_amountdetail.filter ( )
	dw_amountdetail.Show ( )
	dw_amountdetail.SetFocus ( )
		
END IF

RETURN AncestorReturnValue
end event

event dw_amounts::itemerror;call super::itemerror;integer	li_return

li_return = AncestorReturnValue

CHOOSE CASE DWO.NAME
	CASE "ratecodename"
		li_return = 1
end choose

IF li_return <> 0 THEN
//	dw_amountdetail.inv_UILink.UpdateRequestor ( dw_amountdetail.GetRow ( ) )	

END IF

return li_return
end event

type dw_amountdetail from u_tabpage_amounts`dw_amountdetail within u_tabpage_transactionamounts
event ue_transactionmodified ( )
boolean visible = false
integer x = 96
integer width = 3095
integer height = 1584
integer taborder = 20
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
end type

event dw_amountdetail::ue_transactionmodified;PARENT.Event ue_TransactionModified (  )

end event

event dw_amountdetail::itemchanged;call super::itemchanged;integer	li_return, &
			li_count, &
			li_ndx
			
string	ls_value, & 
			ls_container, &
			lsa_list[]

long		ll_ship, &
			lla_ship[], &
			ll_listcount
			
n_cst_bso_dispatch	lnv_dispatch
n_cst_beo_shipment	lnv_shipment
n_cst_beo_event		lnva_Event[]
n_ds						lds_shipmentcache, &
							lds_EventCache
n_cst_AnyArraysrv		lnv_Arraysrv
li_return = AncestorReturnValue

CHOOSE CASE DWO.NAME
	CASE "amountowed_shipment"
		//will work if only one valid shipment id is entered (not comma separated list)
		ll_ship = long(data)
		if ll_ship > 0 then
			lnv_dispatch = create n_cst_bso_dispatch
			if lnv_dispatch.of_retrieveshipment(ll_ship) = 1 then
				lnv_shipment = create n_cst_beo_shipment
				lds_shipmentcache = lnv_dispatch.of_getshipmentcache()
				lds_EventCache = lnv_Dispatch.of_GetEventCache()

				lnv_shipment.of_SetSourceid (ll_ship)
				lnv_shipment.of_SetSource ( lds_shipmentCache )
				lnv_Shipment.of_SetEventSource(lds_EventCache)
				
				li_count = lnv_Shipment.of_GetEventList(lnva_Event)

				for li_ndx = 1 to li_count		
					ls_value = lnva_event[li_ndx].of_GetcontainerList ( )
					if len(trim(ls_value)) > 0 then
						ll_listcount ++
						lsa_list[ll_listcount] = ls_value
					end if
				next
				
				li_count = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
				for li_ndx = 1 to li_count	
					if len(trim(ls_container)) > 0 then
						ls_container += ', '
					end if
					ls_container += lsa_List[li_ndx]			
				next
						
				if len(ls_container) > 0 then
					this.setitem(row,'amountowed_container', ls_container)
					PARENT.Event ue_TransactionModified (  )					
				end if
				
				destroy lnv_shipment
				
			end if		
				
			destroy lnv_Dispatch
				
		end if
		
	CASE "amountowed_rate", "amountowed_quantity", "amountowed_amount"
		this.Setitem(row, 'ratecodename', 'CUSTOM')
		PARENT.Event ue_TransactionModified (  )
		
	CASE "ratecodename"
			n_cst_ratedata	lnva_ratedata[]
			if parent.of_autorate(lnva_ratedata, data, this.object.amountowed_quantity[row], this.object.billtoid[row], &
									this.object.originzone[row], this.object.destinationzone[row]) = 1 then
				if lnva_ratedata[1].of_getrate() > 0 then
					if lnva_ratedata[1].of_Getratetype() = appeon_constant.cs_RateUnit_Code_Flat then
						this.setitem(row,'amountowed_quantity',1)
					else
						this.setitem(row,'amountowed_quantity',lnva_ratedata[1].of_GetTotalCount())
					end if
					this.setitem(row, 'amountowed_rate', lnva_ratedata[1].of_getrate())
					this.setitem(row, 'amountowed_amount', lnva_ratedata[1].of_gettotalcharge())
				else
					this.setitem(row, 'amountowed_rate', 0)
					this.setitem(row, 'amountowed_amount', 0)
				end if
				if len(trim(lnva_ratedata[1].of_getdescription())) > 0 then
					this.setitem(row,'amountowed_description', lnva_ratedata[1].of_getdescription())
				end if
				this.setitem(row,'amountowed_type', lnva_ratedata[1].of_getamounttype())
			else
				this.SetText (this.object.ratecodename.primary.original[row])
				dw_amounts.object.ratecodename[ dw_amountS.GetRow ( ) ] = this.object.ratecodename.primary.original[row]
				li_return = 1
			end if
			lnv_ArraySrv.of_Destroy ( lnva_RateData )

			PARENT.Event ue_TransactionModified (  )
END CHOOSE

this.Setitem(row, 'lastmodifiedby', gnv_app.of_GetUserid())

dw_amounts.inv_UILink.UpdateRequestor ( dw_amounts.GetRow ( ) )
	
RETURN li_return

end event

event dw_amountdetail::itemerror;call super::itemerror;integer	li_return

li_return = AncestorReturnValue
CHOOSE CASE DWO.NAME
	CASE "ratecodename"
		li_return = 3
end choose

IF li_return = 3 THEN
	
//	dw_amounts.inv_UILink.UpdateRequestor ( dw_amounts.GetRow ( ) )	

END IF

return li_return
end event

event dw_amountdetail::buttonclicked;n_cst_msg	lnv_msg
decimal		lc_quantity
s_parm		lstr_parm
w_AutoRateQuery		lw_autoratequery

n_cst_beo_AmountOwed		lnv_Beo

CHOOSE CASE dwo.Name
	CASE "cb_ratelookup"
		if NOT isValid(in_transactionmanager) then
			 in_transactionmanager = create n_cst_bso_transactionmanager
		end if
		if isValid(in_transactionmanager)  then

			IF row > 0 AND IsValid ( inv_UILink ) THEN

				lnv_Beo = inv_UILink.GetBeo ( row )

				IF IsValid ( lnv_Beo ) THEN
							
					lstr_Parm.is_Label = "AMOUNTOWED"
					lstr_Parm.ia_Value = lnv_Beo
					lnv_Msg.of_Add_Parm (lstr_Parm)
					
					lstr_Parm.is_Label = "AMOUNTLIST"
					lstr_Parm.ia_Value = dw_amounts
					lnv_Msg.of_Add_Parm (lstr_Parm)
					
					lstr_Parm.is_Label = "QUANTITY"
					lc_quantity = this.object.amountowed_quantity[row]
					if isnull(lc_quantity) then
						lc_quantity = 0
					end if
					lstr_Parm.ia_Value = lc_quantity
					lnv_Msg.of_Add_Parm (lstr_Parm)
					
					lstr_Parm.is_Label = "AMOUNTDETAIL"
					lstr_Parm.ia_Value = dw_amountdetail
					lnv_Msg.of_Add_Parm (lstr_Parm)
					
					lstr_Parm.is_Label = "CATEGORY"
					lstr_Parm.ia_Value = n_cst_constants.ci_Category_Payables
					lnv_Msg.of_Add_Parm (lstr_Parm)
					
					OpenSheetWithParm ( lw_autoratequery, lnv_msg, gnv_App.of_GetFrame ( ), 0, Layered! )
				
				END IF
			end if
		END IF
		
END CHOOSE	


end event

