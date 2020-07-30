$PBExportHeader$w_settlementbatchmanager.srw
forward
global type w_settlementbatchmanager from w_sheet
end type
type gb_includedshipmenttypes from groupbox within w_settlementbatchmanager
end type
type rb_errorlog from radiobutton within w_settlementbatchmanager
end type
type rb_shiptype from radiobutton within w_settlementbatchmanager
end type
type dw_division from u_dw_division within w_settlementbatchmanager
end type
type st_2 from statictext within w_settlementbatchmanager
end type
type uo_1 from u_batchlist within w_settlementbatchmanager
end type
type st_1 from statictext within w_settlementbatchmanager
end type
type gb_error from groupbox within w_settlementbatchmanager
end type
type gb_selection from groupbox within w_settlementbatchmanager
end type
type cb_find from commandbutton within w_settlementbatchmanager
end type
type cbx_failed from checkbox within w_settlementbatchmanager
end type
type uo_errorlog from u_cst_filedirectory within w_settlementbatchmanager
end type
type cbx_errorlog from checkbox within w_settlementbatchmanager
end type
type st_select from statictext within w_settlementbatchmanager
end type
type ddlb_1 from u_cst_drivertype_ddlb within w_settlementbatchmanager
end type
type cb_print from commandbutton within w_settlementbatchmanager
end type
type cb_export from commandbutton within w_settlementbatchmanager
end type
type st_printing from u_st within w_settlementbatchmanager
end type
type tab_1 from u_tab_batchmanager within w_settlementbatchmanager
end type
type tab_1 from u_tab_batchmanager within w_settlementbatchmanager
end type
type dw_errorlog from u_dw within w_settlementbatchmanager
end type
type cb_detail from commandbutton within w_settlementbatchmanager
end type
type cb_close from commandbutton within w_settlementbatchmanager
end type
type cb_1 from commandbutton within w_settlementbatchmanager
end type
type dw_includedshipmenttypes from u_dw_shiptype_amounts within w_settlementbatchmanager
end type
end forward

shared variables

end variables

global type w_settlementbatchmanager from w_sheet
integer x = 91
integer y = 80
integer width = 3611
integer height = 2040
string title = "Settlement Batch Manager"
string menuname = "m_sheets"
long backcolor = 12632256
event ue_find ( string as_cachetype )
event type integer ue_generate ( )
event type integer ue_preprocess ( )
event ue_fuelsurcharge ( )
event type integer ue_repair ( )
event ue_batchdetail ( )
event ue_print ( )
event ue_export ( )
event ue_addtransaction ( )
event type integer ue_periodic ( )
event ue_cancelautogen ( )
event ue_deletetransaction ( )
event ue_closetransaction ( )
event ue_printtransaction ( )
event ue_divisionchanged ( long al_value )
event ue_entitychanged ( n_cst_beo_transaction anv_transaction )
event type integer ue_incremental ( )
event ue_interactive ( )
event ue_setunassigned ( )
gb_includedshipmenttypes gb_includedshipmenttypes
rb_errorlog rb_errorlog
rb_shiptype rb_shiptype
dw_division dw_division
st_2 st_2
uo_1 uo_1
st_1 st_1
gb_error gb_error
gb_selection gb_selection
cb_find cb_find
cbx_failed cbx_failed
uo_errorlog uo_errorlog
cbx_errorlog cbx_errorlog
st_select st_select
ddlb_1 ddlb_1
cb_print cb_print
cb_export cb_export
st_printing st_printing
tab_1 tab_1
dw_errorlog dw_errorlog
cb_detail cb_detail
cb_close cb_close
cb_1 cb_1
dw_includedshipmenttypes dw_includedshipmenttypes
end type
global w_settlementbatchmanager w_settlementbatchmanager

type variables
private:
Constant string 	cs_newbatch_cache = 'd_driverlist_nobatch'
Constant string 	cs_oldbatch_cache = 'd_driverlist_batch'

Constant	string	cs_request_incremental	= 'INCREMENTAL'
Constant	string	cs_request_repair		  	= 'REPAIR'

n_cst_toolmenu_manager			inv_ToolMenuManager
n_cst_bso_TransactionManager	inv_TransactionManager
n_cst_bso_dispatch				inv_dispatch

date	id_preprocessstart, &
		id_preprocessend
		
n_ds	ids_drivers_batched, &
		ids_drivers_notbatched
		
Boolean  ib_IsClosedBatch
Boolean  ib_NewBatch
Boolean	ib_PeriodicOnly
Boolean	ib_WindowisClosing
boolean  ib_PreprocessAutogen
boolean	ib_interrupt

String   is_Batch
string	is_request


end variables

forward prototypes
public function long wf_loadentities (ref n_cst_beo_entity anva_entity[], boolean ab_selected)
public function long wf_importerrorlog ()
public subroutine wf_createtoolmenu ()
public subroutine wf_process_request (string as_request)
public subroutine wf_printbatch ()
public function integer wf_closebatch ()
public function long wf_gettransactionlist (ref long ala_ids[], ref n_cst_beo_transaction anva_transaction[], boolean ab_selected)
public function integer wf_validateselectionfilter (string as_messagetitle, boolean ab_completevalidation)
public function integer wf_preprocess (n_cst_beo_entity anva_entities[])
public function long wf_retrievedrivers (string as_cachetype)
public function long wf_geterrorlogpath (ref string as_pathname)
public function integer wf_generatetransactions (ref n_cst_beo_entity anva_entity[], n_cst_beo_transaction anva_transaction[])
private function integer wf_displayclosedbatch (readonly boolean ab_closed)
public function integer wf_getemployeetype (readonly long al_entityid)
public subroutine wf_findbatch ()
public function integer wf_pendingupdates ()
public function string wf_getcategorybydrivertype ()
public function string wf_getentityname (readonly long al_entityid)
public function boolean of_isnewbatch (readonly string as_batch)
public function integer wf_createemptybatch ()
public function long wf_getperiodictemplates (n_cst_bso_transactionmanager anv_transactionmanager, ref n_cst_beo_amounttemplate anva_templates[])
public function integer wf_getstartenddate (ref date ad_start, ref date ad_end)
public subroutine wf_settabpageheader (date ad_start, date ad_end)
public function long wf_loadentities (ref n_cst_beo_entity anva_entity[], long lla_id[])
private function long wf_getdivision ()
protected subroutine wf_setdivision (string as_cachetype)
protected function integer wf_getitinerary (long al_id, date ad_start, date ad_end, ref n_cst_beo_itinerary2 anv_itinerary)
public function integer wf_createnewtransaction (long al_entity, ref n_cst_beo_transaction anv_transaction)
public function long wf_setuptoautogen (n_cst_beo_entity anva_entities[], ref n_cst_bso_transactionmanager anv_transactionmanager, date ad_start, date ad_end, boolean ab_preprocessingperformed, n_cst_beo_transaction anva_transaction[])
private function boolean wf_doesbatchnameexist (string as_batch)
private function integer wf_validatedivisionselection (long al_division)
private function integer wf_validatedivsionsinbatch ()
end prototypes

event ue_find(string as_cachetype); string	ls_tabtext
date		ld_batch, &
			ld_start, &
			ld_end
Integer	li_result
long		lla_id[]

boolean	lb_retrieve

n_cst_beo_transaction	lnva_transaction[]

choose case as_cachetype
	case cs_newbatch_cache
		if this.wf_validateselectionfilter("Find Batch", FALSE /* ab_CompleteValidation*/) = 1 then
			lb_retrieve = true
		else
			lb_retrieve = false
		end if
		This.wf_DisplayClosedBatch(FALSE) 	// RDT 02-05-03
		
	case cs_oldbatch_cache
		if this.wf_validateselectionfilter("Find Batch", TRUE /* ab_CompleteValidation*/) = 1 then
			lb_retrieve = true
		else
			lb_retrieve = false
		end if
		This.wf_DisplayClosedBatch(TRUE)		// RDT 02-05-03
		
		
end choose

if lb_retrieve then
	if this.wf_RetrieveDrivers(as_cachetype) > 0 then
		this.wf_GetStartEndDate(ld_start, ld_end)
//		this.wf_SetDivision(as_cachetype)
		this.wf_settabpageheader(ld_start, ld_end)
		tab_1.tabpage_1.dw_1.event ue_setunassigned()
	else 
		tab_1.tabpage_1.text='Batch:     Date:     Driver Type:     Start Date:     End Date:'
	end if

end if
is_Batch = uo_1.of_Getbatchnumber()
ib_NewBatch = FALSE						// RDT 02-05-03

end event

event type integer ue_generate();

integer	li_return = 1
long		ll_rowcount, &
			ll_division
date		ld_batch
string	ls_batch, &
			ls_messagetitle = "Generate Batch"

datawindowchild	ldwc_batch
n_cst_beo_entity	lnva_entity[]
n_Cst_Beo_Transaction lnva_transaction[] /* Empty in this code path; used in 'repair */

if This.wf_validateselectionfilter(ls_messagetitle, FALSE /* ab_CompleteValidation*/) = - 1 then
	li_return = -1
end if

if li_return = 1 then
	//do we have a new batch number
	ls_batch = uo_1.of_GetBatchnumber()
	ldwc_Batch = uo_1.of_GetBatchlist()
	ll_rowcount = ldwc_Batch.rowcount()
	if ll_rowcount > 0 then
		if ldwc_Batch.find("batchnumber = '" + ls_batch + "'", 1, ll_Rowcount) > 0 or &
			len(trim(ls_batch)) = 0 then
			messagebox(ls_messagetitle, "Please enter a new batch number.")
			uo_1.event ue_setfocus("BATCHNUMBER")
			li_return = -1
		end if
	end if
end if

if li_return = 1 then
	//do we have a division
	ll_division = wf_GetDivision( )
//	if ll_division > 0 then
//		//got it 
//	else
//		messagebox(ls_messagetitle, "Please enter a division for the batch.")
//		li_return = -1
//	end if
end if


if li_return = 1 then
	if tab_1.tabpage_1.dw_1.Rowcount() > 0 then
		//already have a list
	else
		//populate the driverlist
		cb_find.event clicked()
		if tab_1.tabpage_1.dw_1.Rowcount() > 0 then
			//we have a list
		else
			messagebox(ls_messagetitle, "There are no drivers in the list.")
			li_return = -1
		end if
	end if
end if

if li_return = 1 then
	//generate transactions for the drivers
	//force a retrieval with new batch number and driver type
	choose case messagebox(ls_messagetitle, &
				"Are you sure you want to generate a batch for the driver type you have selected?",&
				Question!, YesNo!, 2)
		case 1
//			This.wf_RetrieveDrivers(cs_newbatch_cache)
			if This.wf_loadentities(lnva_entity,false) > 0 then
				This.wf_GenerateTransactions(lnva_entity, lnva_transaction) 				
				ib_NewBatch = TRUE 		// RDT 02-05-03	
			ELSE
//					messagebox("JMA", "load entities returns > 0", Stopsign!, OK!)				
			end if
		case 2
			//get out
	end choose

end if

long	ll_ndx, &
		ll_count
ll_count = upperbound(lnva_entity)
for ll_ndx = 1 to ll_count
	if isvalid(lnva_entity[ll_ndx]) then
		destroy(lnva_entity[ll_ndx])
	end if
next


return li_return
end event

event ue_preprocess;//ue_preprocess

// RDT 02-05-03 check for closed batch 



boolean lb_preprocessingperformed
integer	li_return = 1
long		ll_rowcount
date		ld_batch
string	ls_batch, &
			ls_messagetitle = "Preprocess Batch"



datawindowchild	ldwc_batch
n_cst_beo_entity	lnva_entity[]

if li_return = 1 then
	if tab_1.tabpage_1.dw_1.Rowcount() > 0 then
		//we already have a list
	else
		//populate the driverlist
		cb_find.event clicked()
		if tab_1.tabpage_1.dw_1.Rowcount() > 0 then
			//we have a list
		else
			messagebox(ls_messagetitle, "There are no drivers in the list.")
			li_return = -1
		end if
	end if
end if

if li_return = 1 then
	//generate transactions for the drivers
	//force a retrieval with new batch number and driver type
	choose case messagebox(ls_messagetitle, &
				"Are you sure you want to preprocess an autogen batch for the driver type you have selected?",&
				Question!, YesNo!, 2)
		case 1
			This.wf_RetrieveDrivers(cs_newbatch_cache)
//			if This.wf_loadentities(lnva_entity,false) > 0 then
//				if This.wf_GenerateTransactions(lnva_entity) = 1 then
//				end if
//			end if
			li_Return = wf_preprocess(lnva_entity)
			
		case 2
			//get out
	end choose
end if
	
return li_return


//li_return = wf_preprocess(lnva_entities[])



return li_return /* lb_preprocessingperformed */
end event

event ue_fuelsurcharge();
boolean 	lb_ContinueProcess = TRUE
		
dec	lc_surcharge

integer 	li_id 
			
long		ll_return=1, &
			ll_retval, &
			lla_transactionid[], &
			ll_CounterMax, &
			ll_AmountType, &
			ll_transcount, &
			ll_entitycount, &
			ll_index

string	ls_messagetitle = "Generate Payable Fuel Surcharge", &
			ls_Value, &
			lsa_RateList[]

n_cst_bso_Payable	lnv_payable
n_cst_setting_PayableFuelSurcharge%age	lnv_Surcharge
n_cst_beo_Transaction	lnva_Transaction[]

n_cst_Settings lnv_Settings

n_cst_beo_Amounttype	lnva_AmountType[]

N_cst_beo_entity	lnva_Entities[]

// Read system settings.  Pull out any fuel surcharge info.
//surcharge
lnv_Surcharge = create n_cst_setting_PayableFuelSurcharge%age	
lc_Surcharge = dec(lnv_surcharge.of_GetValue())
destroy lnv_Surcharge

CHOOSE CASE lc_Surcharge
	CASE is > 0
		ls_Value = "FUELSURCHARGE_PAYABLE"
		
		lnv_Payable = CREATE n_cst_bso_Payable
		ll_retval = lnv_payable.of_getAmountTag(ls_Value, lnva_amounttype)
		// get the amounttype.id from this beo.
		ll_CounterMax = upperbound(lnva_Amounttype)
		
		IF ll_CounterMax <= 0 THEN 
			
			//look for amounttype in code default
			n_cst_bso_Rating			lnv_Rating
			n_cst_RateData				lnv_RateData
			lnv_Rating = CREATE n_cst_bso_Rating
			lnv_RateData = CREATE n_cst_RateData
			IF lnv_Rating.of_GetCodeDefaultList ( 0 , appeon_constant.cl_FuelSurcharge_list , lsa_RateList ) > 0 THEN	
				lnv_RateData.of_SetCodeName ( lsa_RateList[1] )
				ll_AmountType = lnv_Rating.of_GetAmountType ( lnv_RateData )
			END IF	
			DESTROY	lnv_Rating
			DESTROY	lnv_RateData
			
			if ll_amounttype = 0 or isnull(ll_amounttype) then
				ll_Return = -2
				messagebox(ls_messagetitle, "You have not designated one of" + &
				" your amount types as FUELSURCHARGE_PAYABLE." + &
				" Please go to amount type setup and enter FUELSURCHARGE_PAYABLE in the tag column for" + &
				" the amount type to be used for fuel surcharge pay.")		
			else
				//i don't like this but the ll_amounttype source is a small int so there shouldn't be an overflow
				li_id = ll_amounttype
			end if
		ELSE
			li_id = lnva_amounttype[1].of_GetId() 
		end if
		
		if ll_return = 1 then
			//get selected transactions
			ll_Transcount = wf_GetTransactionList(lla_transactionid, lnva_Transaction, TRUE /* ab_Selected */)
			IF ll_Transcount > 0 THEN
				for ll_index = 1 to ll_transcount
					IF lnva_Transaction[ll_index].of_GetStatus() = appeon_constant.ci_status_audited THEN
						CONTINUE
					ELSE
						messagebox(ls_messagetitle, 'All highlighted transactions must have a status of Audited.')
						ll_return = -1
						EXIT
					END IF
				next
				IF ll_return = 1 then
					ll_EntityCount = this.wf_loadEntities(lnva_entities,TRUE)
					IF ll_EntityCount > 0 THEN	
						choose case messagebox(ls_messagetitle, &
								"This will create Fuel Surcharge amounts for the highlighted transactions in the list." +&
								" Are you sure you want to continue?", Question!,YesNo!)
							case 1
								ll_Return = lnv_payable.of_ProcessSurcharge(lnva_entities,  &
								inv_transactionmanager, lc_surcharge, li_id, lnva_transaction)	
								// update display
								tab_1.tabpage_1.dw_1.Event ue_updateTransaction(lnva_Transaction)					
							case 2
								ll_return = -1
						end choose									
					END IF
				END IF
			ELSE
				//if nothing was selected then take the whole list
				ll_Transcount = wf_GetTransactionList(lla_transactionid, lnva_Transaction, FALSE /* ab_Selected */)
				IF ll_Transcount > 0 THEN
					for ll_index = 1 to ll_transcount
						IF lnva_Transaction[ll_index].of_GetStatus() = appeon_constant.ci_status_audited THEN
							CONTINUE
						ELSE
							messagebox(ls_messagetitle, 'You are trying to create Fuel Surcharge amounts for all ' + &
													'the transactions in the list but not all transactions have a status of Audited.')
							ll_return = -1
							EXIT
						END IF
					next
					IF ll_return = 1 then
						ll_EntityCount = this.wf_loadEntities(lnva_entities,false)
						IF ll_EntityCount > 0 THEN	
							choose case messagebox(ls_messagetitle, &
									"This will create Fuel Surcharge amounts for all the transactions in the list." +&
									" Are you sure you want to continue?", Question!,YesNo!)
								case 1
									ll_Return = lnv_payable.of_ProcessSurcharge(lnva_entities,  &
									inv_transactionmanager, lc_surcharge, li_id, lnva_transaction)	
									// update display
									tab_1.tabpage_1.dw_1.Event ue_updateTransaction(lnva_Transaction)					
								case 2
									ll_return = -1
							end choose
						ELSE
						// no entities were loaded so we can't run.
						END IF
					END IF
				END IF
			END IF
			
			ll_Return = 0
			
		END IF 
		
	CASE ELSE
		messagebox(ls_messagetitle, "The Payable Fuel Surcharge Percentage is empty." + &
		" Please enter a value for payable fuel surcharge in the system" + &
		" settings if you wish to generate the fuel surcharge.")
		ll_Return = -2
		
END CHOOSE

IF IsValid(lnv_Payable) THEN
	DESTROY (lnv_Payable)
End IF




end event

event type integer ue_repair();setpointer(HourGlass!)

Boolean 	lb_TransactionNotFailed = FALSE
integer	li_return

long	ll_row, &
		ll_rowcount, &
		ll_id, &
		lla_tranIds[], &
		ll_TransCount, &
		ll_Index, &
		ll_Count

string	ls_batchnumber, &
			ls_messagetitle = 'Repair Transaction'


n_cst_beo_entity	lnva_Entity[]	
n_cst_beo_AmountOwed	lnva_amountOwedList[]
n_cst_beo_transaction lnva_Transaction[]

ls_batchnumber = uo_1.of_getbatchnumber()
is_request = cs_request_repair

if len(trim(ls_batchnumber)) = 0 or isnull(ls_batchnumber) then
	messagebox(ls_messagetitle, 'Please select a Transaction.')
	uo_1.event ue_setfocus("BATCHNUMBER")
	li_return = -1
else	
	if This.wf_getTransactionlist(lla_TranIds, lnva_transaction, TRUE) > 0 then
		
		ll_TransCount = upperbound(lnva_Transaction)	
		
		IF ll_TransCount > 0 THEN
			
			This.wf_loadentities(lnva_entity,lla_TranIds)
		
			// Check if these are all failed transactions.  If we have any that aren't failed tell user.
			FOR ll_Index = 1 TO ll_TransCount
				IF appeon_constant.ci_status_failed = lnva_transaction[ll_index].of_GetStatus() THEN
					
				ELSE
					lb_TransactionNotFailed = TRUE
					EXIT  /* Stop looking after finding one transaction that isn't 'failed' */
				END IF
			NEXT
			IF lb_TransactionNotFailed = TRUE THEN
				messagebox(ls_messagetitle, "Repairs can only be done on failed transactions." + &
				"  Deselect all transactions that have not failed before you run 'repair'" +&
				" or change the transaction status to 'failed'.")
			ELSE  // all the transactions did have a status of failed. So do the repair.
				// First delete any amount oweds on these transactions
				
				choose case messagebox(ls_messagetitle, &
						"This will clear all amounts from the transaction and generate new ones." +&
						" Are you sure you want to continue?", Question!,YesNo!)
					case 1
						FOR ll_Index = 1 TO ll_TransCount
							lnva_transaction[ll_index].Of_GetAmountsList(lnva_AmountOwedlist)
							FOR ll_Count = 1 TO Upperbound(lnva_AmountOwedList)
								lnva_AmountOwedList[ll_Count].DeleteBEO()
							NEXT
							// clean up the old transaction in preparation for creating new amount oweds.
							lnva_transaction[ll_index].Of_SetStatus(appeon_constant.ci_Status_Open)
							lnva_transaction[ll_index].Of_SetOpen(TRUE)					
						NEXT	
						This.wf_GenerateTransactions(lnva_entity, lnva_Transaction)				
					case 2
						li_return = -1
				end choose
				
			END IF 	// check if lb_TransactionNotFailed is TRUE
		ELSE  // ll_TransCount Not Greater than 0.
			messagebox(ls_messagetitle, 'No Transactions are highlighted.')  
			uo_1.event ue_setfocus("BATCHNUMBER")			
		END IF
	else
		messagebox(ls_messagetitle, 'No Transactions are highlighted.')
		uo_1.event ue_setfocus("BATCHNUMBER")
		li_return = -1
	end if
end if

long	ll_ndx
ll_count = upperbound(lnva_entity)
for ll_ndx = 1 to ll_count
	if isvalid(lnva_entity[ll_ndx]) then
		destroy(lnva_entity[ll_ndx])
	end if
next

is_request = ''
return li_return 
end event

event ue_batchdetail;string	ls_null, &
			ls_batchnumber
			
long		ll_entityid, &
			lla_ids[], &
			ll_null
date		ld_Null
w_transactionmanager	lw_TransactionManager
n_cst_msg	lnv_Msg	
s_Parm		lstr_Parm
S_Transaction_Selection  lstr_Selection

setnull(ld_Null)
setnull(ls_Null)
setnull(ll_null)
ls_batchnumber = uo_1.of_getbatchnumber()

if len(trim(ls_batchnumber)) = 0 or isnull(ls_batchnumber) then
	messagebox('Batch detail', "Please enter a batch number.")
	uo_1.event ue_setfocus("BATCHNUMBER")
else
	lstr_Selection.s_Transactionids = ls_Null
	lstr_Selection.la_Transactionids = lla_Ids
	lstr_Selection.s_EntityName = ls_Null
	lstr_Selection.l_EntityID = ll_null
	lstr_Selection.s_EntityType = 'E'
	lstr_Selection.d_StartDate = ld_Null
	lstr_Selection.d_endDate = ld_Null
	lstr_Selection.i_status = 1	//open status
	lstr_Selection.s_Unbatched = ls_Null
	lstr_Selection.s_batchNumber = TRIM ( Upper (ls_batchnumber) )
	lstr_Selection.b_HaveData = true
	
	lstr_Parm.is_Label = "S_TRANSACTION_SELECTION"
	lstr_Parm.ia_Value = lstr_Selection
	lnv_Msg.of_Add_Parm ( lstr_Parm ) 
	
	OpenSheetWithParm ( lw_TransactionManager, lnv_Msg, gnv_App.of_GetFrame ( ), 0, Layered! )
end if
end event

event ue_print;// Print entire batch

wf_PrintBatch()
end event

event ue_export();//RDT 02-18-03 Driver types define AP Catagory
/*
	Third Party 	= Payables
	Owner Operator = Payables
	Casual 			= PAYROLL
	Company			= PAYROLL
*/

Date		ld_Today, &
			ld_batchdate

string	ls_AcctLink, &
			lsa_company[]

integer	li_Return
Int		li_UpdateRtn
Int		li_MBoxRtn
Int		li_SaveRtn
Int		i

Boolean  lb_Continue = TRUE
Boolean	lb_Batched
Boolean	lb_Mixed 
Boolean  lb_OpenTransactions
Boolean	lb_success
Boolean	lb_ZeroDollarTransactions


long		lla_id [], &
			ll_Index, &
			ll_TransCount,&
			ll_RowCount

n_cst_msg	lnv_Msg
S_parm	lstr_Parm
n_cst_acctlink				lnv_cst_acctlink
n_cst_beo_transaction	lnva_transaction []
n_cst_beo_transaction	lnv_CurrentTransaction
n_cst_Bcm					lnv_Bcm
n_cst_Privileges			lnv_Privileges
n_cst_Settings				lnv_Settings

//make sure a batch is loaded and closed
IF lnv_Privileges.of_Settlements_CreateBatch ( ) THEN

	ll_RowCount = this.wf_GetTransactionList( lla_id, lnva_Transaction, FALSE /*selected*/ ) //rdt
	ll_TransCount = UpperBound ( lnva_transaction )
	
	IF ll_RowCount > 0 THEN
		IF inv_transactionmanager.of_LoadReferencedAmounts ( ) = 1 AND &
			inv_transactionmanager.of_LoadReferencedEntities ( ) = 1   THEN			

		// check for outstanding updates
		li_UpdateRtn = inv_transactionmanager.Event pt_UpdatesPending() 
			//pt_UpdatesPending Returns :	 1 = Yes (Updates Pending)	 0 = No (No Updates Pending)

			CHOOSE CASE li_UpdateRtn
				CASE 0  //There are no changes pending 
					lb_Continue = TRUE
					
				CASE 1  //There are changes pending.
	
					If MessageBox( "Export Batch", "Before you can export a batch you must save your changes. Do you want to save your changes now?", QUESTION!, YESNO! , 1) = 1 Then 
							If This.Event pfc_Save( ) < 0 Then 
								MessageBox ( "Save Failure" , "Your batch has not been exported and processing will stop.", EXCLAMATION!)
								lb_Continue = FALSE
							Else
								lb_Continue = TRUE
							End If
						Else			// user said NO Save
							lb_Continue =FALSE							
						End If							
				CASE is < 0  //Changes are pending, but do not pass validation.
					MessageBox ( "Validation", "The information entered does not pass validation and "  + &
												"must be corrected before changes can be saved.")	
					lb_Continue = FALSE
					
			END CHOOSE
 
 			IF lb_Continue THEN

				IF lnv_Settings.of_GetAcctLink ( ls_AcctLink ) = 1 THEN
					lnv_cst_AcctLink = CREATE USING ls_AcctLink
				ELSE // error
					messageBox("Accounting" , "An error occurred while attempting to determine "+&
					+"what accounting software is being used. Please check your System Settings.")
				END IF
	
				//transactions need to be grouped by batch number and 
				//then passed to the aactlink
				
				IF IsValid (lnv_cst_AcctLink) THEN
					// Only Closed Trasactions can be batched. Perform a check here.
					FOR ll_index = 1 TO UpperBound ( lnva_transaction ) 										
						IF lnva_transaction[ll_index].of_GetOpen ( ) THEN
							lb_OpenTransactions = TRUE
							EXIT
						END IF
					NEXT 
					
					IF lb_OpenTransactions THEN
						MessageBox ("Export Batch", "All the transactions must be closed before the batch can exported. Please close the transactions before attempting another export." )
						lb_Continue = FALSE
					END IF
					
					IF lb_Continue THEN
						// check to see if the batch has been exported. 
						IF UpperBound ( lnva_transaction ) > 0 THEN
							lb_Batched = lnva_transaction[1].of_GetBatched ( )
							FOR ll_index = 1 TO UpperBound ( lnva_transaction ) 									
								
								IF lnva_transaction[ll_index].of_GetBatched ( ) <> lb_Batched THEN
									lb_Mixed = TRUE
									EXIT
								END IF
							NEXT 
							
							IF lb_Mixed THEN
								IF MessageBox ("Export Batch" , "Some (but not all) of the selected batch has already been exported. Do you want to export it again?" , QUESTION!, YESNO! ) = 2 THEN
									lb_Continue = FALSE
								END IF
							ELSEIF lb_batched THEN
								IF MessageBox ("Export Batch" , "The selected batch has already been exported. Do you want to export it again?" , QUESTION!, YESNO! ) = 2 THEN
									lb_Continue = FALSE
								END IF
							END IF
						END IF // end check for re-batch
					END IF
					
					IF lb_Continue THEN
						
						//check for zero dollar transactions and warn
						FOR ll_index = 1 TO ll_TransCount 										
							IF lnva_transaction[ll_index].of_GetPreTaxNet ( ) > 0 THEN
								//OK
							ELSE
								lb_ZeroDollarTransactions = TRUE
								EXIT
							END IF
						NEXT 
						
						IF lb_ZeroDollarTransactions THEN
							IF MessageBox ("Export Batch" , "Not all of the transactions have amounts greater than zero. " +&
												"These transactions may not be acceptable in your accounting package. " +&
												"Do you still want to export the batch?" , QUESTION!, YESNO!, 2 ) = 2 THEN
								lb_Continue = FALSE
							END IF							
						END IF
						
					END IF
					
					IF lb_continue THEN
						//make sure all the driver divisions have the same posting company
						lnv_cst_AcctLink.of_validateaccountingcompany( lnva_transaction, lsa_company )
						
						IF UpperBound ( lsa_company ) = 0 THEN
							messagebox ( "Batch Error","One or more divisions do not have a posting company specified.  " + &
									"Please verify your shipment type setup.", StopSign!) 
							lb_Continue = FALSE
						ELSEIF UpperBound ( lsa_company ) > 1 THEN
							messagebox ( "Batch Error", &
							"The transactions do not all post to the same "+&
							"company (based on their shipment types).  In order to create " + &
							"the batch, only those transactions associated with ONE valid " + &
							"company can be batched together.  ", StopSign!)
							lb_Continue = FALSE
						END IF
						
					END IF
					
					IF lb_Continue THEN	
						lstr_Parm.is_Label = "TRANSACTION_BEO_ARRAY"
						lstr_Parm.ia_Value = lnva_transaction
						lnv_msg.of_Add_Parm ( lstr_Parm ) 
						
						// RDT 02-18-03 - add category to msg
						lstr_Parm.is_Label = "CATEGORY"
						lstr_Parm.ia_Value = this.wf_GetCategoryByDriverType()
						lnv_msg.of_Add_Parm ( lstr_Parm ) 
						
						li_Return = lnv_cst_acctlink.of_BatchCreate ( lnv_Msg ) 
							do
								lb_success = lnv_cst_acctlink.of_link_close()
								if lb_success then
									exit
								else
									if messagebox("Close Accounting Link", "Could not close link to the accounting "+&
										"package.  Retry?", exclamation!, retrycancel!, 1) = 2 then exit
								end if
							loop while lb_success = false

						IF isValid ( lnv_cst_acctlink ) THEN
							destroy lnv_cst_acctlink
						END IF
						
						//after successfully creating files,
						//update the batch columns
						
						IF li_Return = 1 THEN  // batch created successfully so update the status
							// update all transactions with batch date (today's date) J. Albert 12/18/02
							ld_Today = TODAY()
							FOR ll_Index = 1 TO Upperbound(lnva_Transaction)
								IF IsValid(lnva_Transaction[ll_index]) THEN
									ld_batchdate = lnva_Transaction[ll_index].of_GetBatchDate()
									if isnull(ld_batchdate) then
										lnva_Transaction[ll_index].of_SetBatchDate(ld_Today)
									end if
								END IF
							NEXT				
						
							//update transaction batch columns
							FOR ll_Index = 1 to ll_TransCount
								lnv_CurrentTransaction = lnva_transaction [ll_Index]
								lnv_CurrentTransaction.of_SetBatched ( true )
							NEXT
						
							//
							li_SaveRtn = This.Event pfc_Save( )
																
							CHOOSE CASE li_SaveRtn
								CASE is < 0 // Save Failed
									MessageBox ( "Save Failure" , "Your batch has successfully been exported but Profit Tools could not save the updates to the batch fields." &
												+" You may attempt another save. If that is unsuccessful, PTADMIN will need to re-retrieve the batch and update the batch status manually.", EXCLAMATION!)
									lb_Continue = FALSE
		
							END CHOOSE
						ELSE
							// nothing because batch create provides all error messages!
						END IF						
						
					END IF // lb_Continue - re-batch
					
				END IF
				
			END IF // lb_Continue
			
		ELSE //referenced amounts
			
			// bad things are about to happen
			MessageBox  ("Export Batch" , "Could not load information needed to export batch.")
		END IF
	ELSE // rowcount = 0 
		MessageBox( "Export Batch" , "There are no transactions to export." )
		
	END IF
ELSE // privileges
	MessageBox( "Export Batch" , "You do not have the required privileges to perform this operation." )
END IF

end event

event ue_addtransaction;
setpointer(HourGlass!)

integer	li_return

long	lla_tranIds[]

string	ls_batchnumber, &
			ls_messagetitle = 'Add Transaction'

n_cst_beo_entity	lnva_Entity[]	
n_cst_beo_AmountOwed	lnva_amountOwedList[]
n_cst_beo_transaction lnva_Transaction[]

ls_batchnumber = uo_1.of_getbatchnumber()

if len(trim(ls_batchnumber)) = 0 or isnull(ls_batchnumber) then
	messagebox(ls_messagetitle, 'Please select a batch.')
	uo_1.event ue_setfocus("BATCHNUMBER")
	li_return = -1
else	
	if This.wf_loadentities(lnva_entity,true) > 0 then
		This.wf_getTransactionlist(lla_TranIds, lnva_transaction, TRUE)
		IF upperbound(lnva_Transaction) > 0 THEN
			messagebox(ls_messagetitle, "You can only select rows which don't already have transactions.")
		ELSE  
			This.wf_GenerateTransactions(lnva_entity, lnva_Transaction)				
			// update display 
//			tab_1.tabpage_1.dw_1.Event ue_updateTransaction(lnva_Transaction)
		END IF 
	else
		messagebox(ls_messagetitle, 'No rows are highlighted.')
		uo_1.event ue_setfocus("BATCHNUMBER")
		li_return = -1
	end if
end if
//return li_return 
end event

event type integer ue_periodic();setpointer(HourGlass!)

integer	li_return = 1

long	ll_row, &
		ll_rowcount, &
		ll_id, &
		lla_tranIds[], &
		ll_TransCount, &
		ll_Index, &
		ll_Count

string	ls_batchnumber, &
			ls_messagetitle = 'Generate Periodics'


n_cst_beo_entity	lnva_Entity[]	
n_cst_beo_AmountOwed	lnva_amountOwedList[]
n_cst_beo_transaction lnva_Transaction[]

ls_batchnumber = uo_1.of_getbatchnumber()

if len(trim(ls_batchnumber)) = 0 or isnull(ls_batchnumber) then
	messagebox(ls_messagetitle, 'Please select a batch.')
	uo_1.event ue_setfocus("BATCHNUMBER")
	li_return = -1
else	
	This.wf_getTransactionlist(lla_TranIds, lnva_transaction, TRUE)
	ll_TransCount = upperbound(lnva_Transaction)	
	IF ll_TransCount > 0 THEN
		if This.wf_loadentities(lnva_entity,lla_TranIds) > 0 then
			// Check for any failed transactions.  If we have any tell user.
			FOR ll_Index = 1 TO ll_TransCount
				IF appeon_constant.ci_status_failed = lnva_transaction[ll_index].of_GetStatus() THEN
					messagebox(ls_messagetitle, "Periodic amounts cannot be done on failed transactions." + &
					"  Deselect all transactions that have failed before generating periodic amounts.")
					li_return = -1
					EXIT  /* Stop looking after finding one transaction that failed' */				
				END IF
			NEXT
			
			choose case messagebox(ls_messagetitle, &
					"This will create periodic amounts for the highlighted transactions in the list." +&
					" Are you sure you want to continue?", Question!,YesNo!)
				case 1
					This.wf_GenerateTransactions(lnva_entity, lnva_Transaction)			
				case 2
					li_return = -1
			end choose				
		
		else
			//shouldn't happen if we got selected transactions
			li_return = -1
		end if
	else
		//if nothing was selected then take the whole list
		if This.wf_getTransactionlist(lla_TranIds, lnva_transaction, FALSE) > 0 then
			
			This.wf_loadentities(lnva_entity,lla_TranIds)
			
			ll_TransCount = upperbound(lnva_Transaction)	

			IF ll_TransCount > 0 THEN
				choose case messagebox(ls_messagetitle, &
						"This will create periodic amounts for all the transactions in the list." +&
						" Are you sure you want to continue?", Question!,YesNo!)
					case 1
						This.wf_GenerateTransactions(lnva_entity, lnva_Transaction)				
					case 2
						li_return = -1
				end choose
				
			END IF 	// check if lb_TransactionNotFailed is TRUE
		else
			messagebox(ls_messagetitle, 'No Transactions in the batch.')
			uo_1.event ue_setfocus("BATCHNUMBER")
			li_return = -1
		end if
	END IF
end if

long	ll_ndx
ll_count = upperbound(lnva_entity)
for ll_ndx = 1 to ll_count
	if isvalid(lnva_entity[ll_ndx]) then
		destroy(lnva_entity[ll_ndx])
	end if
next


return li_return 
end event

event ue_cancelautogen;ib_interrupt = true

end event

event ue_deletetransaction();setpointer(HourGlass!)

integer	li_return = 1

long	ll_id, &
		lla_tranIds[], &
		ll_TransCount, &
		ll_Index, &
		ll_Count

string	ls_batchnumber, &
			ls_messagetitle = 'Delete Transaction'

n_cst_beo_transaction lnva_Transaction[]

ls_batchnumber = uo_1.of_getbatchnumber()

if len(trim(ls_batchnumber)) = 0 or isnull(ls_batchnumber) then
	messagebox(ls_messagetitle, 'Please select a batch.')
	uo_1.event ue_setfocus("BATCHNUMBER")
	li_return = -1
else	
	This.wf_getTransactionlist(lla_TranIds, lnva_transaction, TRUE)
	ll_TransCount = upperbound(lnva_Transaction)	
	IF ll_TransCount > 0 THEN
		choose case messagebox(ls_messagetitle, &
				"This will delete all amounts for the highlighted transaction(s) " +&
				"including any periodics or manual amounts added to the transaction(s). " +&
				"Do you want to delete the transaction(s)?", Question!,YesNo!)
			case 1
				tab_1.tabpage_1.dw_1.Event ue_DeleteTransaction ( lnva_Transaction )			
			case 2
				li_return = -1
		end choose				
	
	else
		//if nothing was selected then take the whole list
		if This.wf_getTransactionlist(lla_TranIds, lnva_transaction, FALSE) > 0 then
			
			ll_TransCount = upperbound(lnva_Transaction)	

			IF ll_TransCount > 0 THEN
				choose case messagebox(ls_messagetitle, &
						"This will delete all amounts for all the transactions in the list " +&
						"including any periodics or manual amounts added to the transactions. " +&
						"Do you want to delete the transactions?", Question!,YesNo!)
					case 1
						tab_1.tabpage_1.dw_1.Event ue_DeleteTransaction ( lnva_Transaction )		
					case 2
						li_return = -1
				end choose
				
			END IF 	
		else
			messagebox(ls_messagetitle, 'No Transactions in the batch.')
			uo_1.event ue_setfocus("BATCHNUMBER")
			li_return = -1
		end if
	END IF
end if


end event

event ue_closetransaction();setpointer(HourGlass!)

integer	li_return = 1

long	ll_id, &
		lla_tranIds[], &
		ll_TransCount, &
		ll_Index, &
		ll_Count

string	ls_batchnumber, &
			ls_messagetitle = 'Close Transaction'

n_cst_beo_transaction lnva_Transaction[]

ls_batchnumber = uo_1.of_getbatchnumber()

if len(trim(ls_batchnumber)) = 0 or isnull(ls_batchnumber) then
	messagebox(ls_messagetitle, 'Please select a batch.')
	uo_1.event ue_setfocus("BATCHNUMBER")
	li_return = -1
else	
	This.wf_getTransactionlist(lla_TranIds, lnva_transaction, TRUE)
	ll_TransCount = upperbound(lnva_Transaction)	
	IF ll_TransCount > 0 THEN
		choose case messagebox(ls_messagetitle, &
				"This will close the highlighted transactions. " +&
				"Do you want to close the transactions?", Question!,YesNo!)
			case 1
				if tab_1.tabpage_1.dw_1.Event ue_CloseTransaction ( lnva_Transaction ) = 1 then	
					IF MessageBox ( "Close Transactions", "Do you want to print the transactions now?", &
						Question!, YesNo!, 1 ) = 1 THEN
							tab_1.tabpage_1.dw_1.Event ue_PrintTransaction ( lnva_Transaction )
					END IF
				END IF
			case 2
				li_return = -1
		end choose				
	else
		//if nothing was selected then take the whole list
		if This.wf_getTransactionlist(lla_TranIds, lnva_transaction, FALSE) > 0 then
		
			ll_TransCount = upperbound(lnva_Transaction)	

			IF ll_TransCount > 0 THEN
				choose case messagebox(ls_messagetitle, &
						"This will close all the transactions in the list. " +&
						"Do you want to close the transactions?", Question!,YesNo!)
					case 1
						if tab_1.tabpage_1.dw_1.Event ue_CloseTransaction ( lnva_Transaction ) = 1 then	
							IF MessageBox ( "Close Transactions", "Do you want to print the transactions now?", &
								Question!, YesNo!, 1 ) = 1 THEN
									tab_1.tabpage_1.dw_1.Event ue_PrintTransaction ( lnva_Transaction )
							END IF
						END IF
					case 2
						li_return = -1
				end choose
				
			END IF 	
		else
			messagebox(ls_messagetitle, 'No Transactions in the batch.')
			uo_1.event ue_setfocus("BATCHNUMBER")
			li_return = -1
		end if
	END IF
end if




end event

event ue_printtransaction();setpointer(HourGlass!)

integer	li_return = 1

long	ll_id, &
		lla_tranIds[], &
		ll_TransCount, &
		ll_Index, &
		ll_Count

string	ls_batchnumber, &
			ls_messagetitle = 'Print Transaction'

n_cst_beo_transaction lnva_Transaction[]

ls_batchnumber = uo_1.of_getbatchnumber()

if len(trim(ls_batchnumber)) = 0 or isnull(ls_batchnumber) then
	messagebox(ls_messagetitle, 'Please select a batch.')
	uo_1.event ue_setfocus("BATCHNUMBER")
	li_return = -1
else	
	This.wf_getTransactionlist(lla_TranIds, lnva_transaction, TRUE)
	ll_TransCount = upperbound(lnva_Transaction)	
	IF ll_TransCount > 0 THEN
		choose case messagebox(ls_messagetitle, &
				"This will print the highlighted transaction(s). " +&
				"Do you want to print the transaction(s)?", Question!,YesNo!)
			case 1
				tab_1.tabpage_1.dw_1.Event ue_PrintTransaction ( lnva_Transaction )
			case 2
				li_return = -1
		end choose				
	else
		//if nothing was selected then take the whole list
		if This.wf_getTransactionlist(lla_TranIds, lnva_transaction, FALSE) > 0 then
			
			ll_TransCount = upperbound(lnva_Transaction)	

			IF ll_TransCount > 0 THEN
				choose case messagebox(ls_messagetitle, &
						"This will print all the transactions in the list " +&
						"Do you want to print the transactions?", Question!,YesNo!)
					case 1
						tab_1.tabpage_1.dw_1.Event ue_PrintTransaction ( lnva_Transaction )	
					case 2
						li_return = -1
				end choose
				
			END IF 	
		else
			messagebox(ls_messagetitle, 'No Transactions in the batch.')
			uo_1.event ue_setfocus("BATCHNUMBER")
			li_return = -1
		end if
	END IF
end if


end event

event ue_divisionchanged(long al_value);///////////////////////////////////////////////////////////////////////////////
//
//	Function		:ue_divisionchanged
//  
//	Access		:public
//
//	Arguments	:division type long
//
//	Return		:none   
//					
//
//	Description	:Let the tab know that the division changed.
//
// Written by: n. LeBlanc
// 		Date: 07/02/2004
//		Version: 4.0.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

tab_1.event ue_divisionchanged(al_value)
end event

event ue_entitychanged(n_cst_beo_transaction anv_transaction);long	ll_Return = 1, &
		ll_EmployeeID

date	ld_start, &
		ld_end
		
n_cst_beo_Itinerary2		lnv_Itinerary
n_cst_Beo_Entity		lnv_Entity
n_cst_beo_transaction	lnv_Transaction

lnv_Transaction = anv_Transaction

if isvalid(lnv_Transaction) then
	ld_start = lnv_Transaction.of_GetStartDate()
	ld_end = lnv_Transaction.of_GetEndDate()

	lnv_Entity = lnv_Transaction.of_GetEntity()
	
	IF isValid ( lnv_Entity ) THEN	
		ll_EmployeeID	= lnv_Entity.of_GetFKEmployee ( )
	END IF

	
	If IsNull ( ll_EmployeeID ) Then 
		ll_Return = -1
	End IF

else
	ll_return = -1
end if

if ll_return = 1 then
	this.wf_GetItinerary(ll_EmployeeID, ld_start, ld_end, lnv_Itinerary)
	if isvalid(lnv_Itinerary) then
		ll_Return = dw_includedshipmenttypes.of_Entitychanged(lnv_itinerary)
		//set group box text
		gb_Includedshipmenttypes.text = "Processed " + &
							string(dw_includedshipmenttypes.of_getprocessedcount( )) + " of " + &
							string(dw_includedshipmenttypes.of_getincludedcount( )) + " Shipment Type"
		
	end if
	destroy inv_dispatch
end if

destroy lnv_Itinerary

end event

event type integer ue_incremental();integer	li_return = 1
long		ll_rowcount, &
			ll_id, &
			ll_division, &
			ll_drivercount, &
			ll_driverindex, &
			lla_TranIds[], &
			ll_TransCount, &
			ll_combinedcount, &
			ll_TransIndex
			
date		ld_batch
string	ls_batch, &
			ls_messagetitle = "Incremental Generation"

boolean	lb_AddBlank

datawindowchild			ldwc_batch
n_cst_AnyArraySrv			lnv_ArraySrv
n_cst_beo_entity			lnva_entity[]
n_Cst_Beo_Transaction	lnv_Transaction, &
								lnva_transaction[], &
								lnva_TransactionCombined[]

if This.wf_validateselectionfilter(ls_messagetitle, FALSE /* ab_CompleteValidation*/) = - 1 then
	li_return = -1
end if

if li_return = 1 then
	//do we have a division
	ll_division = wf_GetDivision( )
end if

if li_return = 1 then
	//do we have a new batch number
	ls_batch = uo_1.of_GetBatchnumber()
	ldwc_Batch = uo_1.of_GetBatchlist()
	ll_rowcount = ldwc_Batch.rowcount()
	if ll_rowcount > 0 then
		if ldwc_Batch.find("batchnumber = '" + ls_batch + "'", 1, ll_Rowcount) > 0 or len(trim(ls_batch)) = 0 then
			//Batch has already been created, need to get the transactions
			is_request = cs_request_incremental
			if This.wf_getTransactionlist(lla_TranIds, lnva_transaction, FALSE) > 0 then
				
				ll_TransCount = upperbound(lnva_Transaction)	
				
				// If an entity has no transaction, then create a blank one (fill in the holes)
				//build a new transaction list in the same order as the entity list
				
				//load all entities
			//	This.wf_loadentities(lnva_entity,false)  // changing with the following code to only get the drives for the transactions that
																		// have already been generated.
				//<<*>> Load only the entities with transactions.														
				THIS.wf_loadentities( lnva_entity, lla_TranIds )	
				
				ll_drivercount = upperbound(lnva_entity)
				
				for ll_driverindex = 1 to ll_drivercount
					
					lb_AddBlank = false
					
					ll_id = lnva_entity[ll_driverindex].of_Getid()
					
					ll_TransIndex ++
					
					if ll_TransIndex > ll_TransCount then
						lb_AddBlank = true
					else
						if lnva_Transaction[ll_TransIndex].of_GetFkEntity() = ll_id then
							//already there
							ll_combinedcount ++
							lnva_TransactionCombined[ll_combinedcount] = lnva_Transaction[ll_TransIndex]
						else
							//add blank
							lb_addBlank = true
						end if
					end if
					
					if lb_addBlank then
						ll_combinedcount ++
						if this.wf_CreateNewtransaction( ll_id, lnva_TransactionCombined[ll_combinedcount]) = 1 then
							lnva_TransactionCombined[ll_combinedcount].of_setBatchNumber(ls_batch)
							lnva_TransactionCombined[ll_combinedcount].of_SetStartDate(lnva_Transaction[ll_TransIndex - 1].of_getstartdate())
							lnva_TransactionCombined[ll_combinedcount].of_SetEndDate(lnva_Transaction[ll_TransIndex - 1].of_getenddate())
						end if

						//realign array
						ll_TransIndex --
					end if
										
				next
	
				// clean up the old transaction in preparation for creating new amount oweds.
				//we may wnat do this only if ne amounts are added
//				lnva_transaction[ll_index].Of_SetStatus(appeon_constant.ci_Status_Open)

//				lnva_transaction[ll_index].Of_SetOpen(TRUE)	
						
			end if
			
		else
			//new batch
			if tab_1.tabpage_1.dw_1.Rowcount() > 0 then
				//already have a list
			else
				//populate the driverlist
				cb_find.event clicked()
				if tab_1.tabpage_1.dw_1.Rowcount() > 0 then
					//we have a list
				else
					messagebox(ls_messagetitle, "There are no drivers in the list.")
					li_return = -1
				end if
			end if
			
			if li_return = 1 then
				This.wf_loadentities(lnva_entity,false)
			end if

		end if
	end if
end if

if li_return = 1 then
	//generate transactions for the drivers
	//force a retrieval with new batch number and driver type
	
	choose case messagebox(ls_messagetitle, &
				"Are you sure you want to do an Incremental Generation for the drivers with existing transactions?",&
				Question!, YesNo!, 2)
		case 1
				This.wf_GenerateTransactions(lnva_entity, lnva_TransactionCombined) 						
		case 2
			//get out
	end choose

end if

lnv_ArraySrv.of_Destroy(lnva_entity)
is_request = ''

return li_return

end event

event ue_interactive();setpointer(Hourglass!)
string	ls_null
long		ll_return = 1, &
			ll_entityid, &
			lla_Tranids[], &
			ll_null
date		ld_Null

n_cst_beo_transaction	lnva_Transaction[]
n_cst_beo_entity			lnva_Entity[]
n_cst_beo_employee		lnv_Employee

If inv_transactionmanager.Event pt_UpdatesPending() = 1 then 

	MessageBox("Updates Are Pending",&
		"You must save the batch before going to interactive settlements.") 

else
	
	choose case This.wf_getTransactionlist(lla_TranIds, lnva_transaction, TRUE)
		case 0
			messagebox("Goto Interactive Settlements", "Please select a driver.")
			ll_return = 0
			
		case 1
			ll_return = 1

		case else
			messagebox("Goto Interactive Settlements", "You can only select one driver at a time.")
			ll_return = 0 
end choose

if ll_return = 1 then
	w_transactionmanager	lw_TransactionManager
	n_cst_msg	lnv_Msg	
	s_Parm		lstr_Parm
	S_Transaction_Selection  lstr_Selection
	
	setnull(ld_Null)
	setnull(ls_Null)
	setnull(ll_null)
	
	This.wf_loadentities(lnva_entity,lla_TranIds)
	
	ll_entityid = lnva_entity[1].of_GetId()
	lnv_employee = lnva_Entity[1].of_GetEmployee()
	
	if isnull(ll_entityid) or ll_entityid = 0 then
		//don't open window
	else
	
		lstr_Selection.s_Transactionids = ls_Null
		lstr_Selection.la_Transactionids = lla_TranIds
		if isvalid(lnv_Employee) then
			lstr_Selection.s_EntityName = lnv_employee.of_GetFirstName() + ' ' + lnv_employee.of_GetLastName()
		end if
		lstr_Selection.l_EntityID = ll_entityid
		lstr_Selection.s_EntityType = 'E'
		lstr_Selection.d_StartDate = ld_Null
		lstr_Selection.d_endDate = ld_Null
		lstr_Selection.i_status = 1	//open status
		lstr_Selection.s_Unbatched = ls_Null
		lstr_Selection.s_batchNumber = ls_Null
		lstr_Selection.b_HaveData = true
		
		lstr_Parm.is_Label = "S_TRANSACTION_SELECTION"
		lstr_Parm.ia_Value = lstr_Selection
		lnv_Msg.of_Add_Parm ( lstr_Parm ) 
		
		lstr_Parm.is_Label = "INTERACTIVE"
		lnv_Msg.of_Add_Parm ( lstr_Parm ) 
		
		OpenSheetWithParm ( lw_TransactionManager, lnv_Msg, gnv_App.of_GetFrame ( ), 0, Layered! )
		
	end if
	

end if
End If


end event

event ue_setunassigned();tab_1.Event ue_SetUnassigned()
end event

public function long wf_loadentities (ref n_cst_beo_entity anva_entity[], boolean ab_selected);setpointer(HourGlass!)

long	ll_row, &
		ll_rowcount, &
		ll_id, &
		ll_arraycount, &
		ll_return=1
		
n_cst_beo_entity	lnva_entity[]
n_cst_beo			lnv_Beo
n_cst_bcm			lnv_Cache
n_cst_database		lnv_database
n_cst_query			lnv_query

lnva_entity = anva_entity
ll_arraycount = upperbound(lnva_entity)

//gnv_App.inv_CacheManager.of_SetAutoCache ( TRUE )
//IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_entity", lnv_Cache, TRUE, TRUE ) = 1 THEN
//	//proceed
//else
//	ll_return = -1
//end if

//Above commented code was replaced with this code because if an entity is added after the list is initially retreived
//then the new entity is not included in the autogeneration
//nwl- 10/22/04
lnv_database = gnv_bcmmgr.GetDatabase()
If IsValid(lnv_database) Then
	lnv_query = lnv_database.GetQuery()
	lnv_Cache = lnv_query.ExecuteQuery("n_cst_dlkc_entity","","")
	
End If
	
if ll_return = 1 then
	
	ll_rowcount = tab_1.tabpage_1.dw_1.rowcount()
	
	for ll_row = 1 to ll_rowcount
		
		if ab_selected then
			if not tab_1.tabpage_1.dw_1.isSelected(ll_row) then
				continue
			end if
		end if
	
		ll_id = tab_1.tabpage_1.dw_1.object.id[ll_row]
		
		lnv_Beo = lnv_Cache.GetBeo ( "entity_id = " + String ( ll_Id ) )
	
		IF IsValid ( lnv_Beo ) THEN
			ll_arraycount ++
			lnva_entity[ll_arraycount] = lnv_beo
		END IF
		
	next
	
END IF

anva_entity = lnva_entity

RETURN upperbound(anva_entity)

end function

public function long wf_importerrorlog ();setpointer(HourGlass!)
long		ll_return=1
string	ls_file, &
			ls_messagetitle = "Open error log"

ls_file = uo_errorlog.of_getFullname()
if len(trim(ls_file)) > 0 then
	//get rid of old 
	dw_errorlog.reset()
	//import new
	choose case dw_errorlog.Importfile(ls_file)
		case 0
			messagebox(ls_messagetitle, 'End of file; too many rows')	
			ll_return = -1
		case -1
			messagebox(ls_messagetitle, 'No rows')	
			ll_return = -1
		case -2
			messagebox(ls_messagetitle, 'Empty file')
			ll_return = -1
		case -3
			messagebox(ls_messagetitle, 'Invalid argument')					
			ll_return = -1
		case -4
			messagebox(ls_messagetitle, 'Invalid input')
			ll_return = -1
		case -5  
			messagebox(ls_messagetitle, 'Could not open the file')
			ll_return = -1
		case -6  
			messagebox(ls_messagetitle, 'Could not close the file')
			ll_return = -1
		case -7  
			messagebox(ls_messagetitle, 'Error reading the text')
			ll_return = -1
		case -8  
			messagebox(ls_messagetitle, 'Not a TXT file')
			ll_return = -1
		case -9  
			messagebox(ls_messagetitle, 'The user canceled the import')
			ll_return = -1
		case -10 
			messagebox(ls_messagetitle, 'Unsupported dBase file format (not version 2 or 3)')
			ll_return = -1
			
	end choose
	if ll_return = 1 then
		ll_return = dw_errorlog.rowcount()
	end if
else
	messagebox('Display error log', 'Select an error file.')
	ll_return = 0
end if

return ll_return
end function

public subroutine wf_createtoolmenu ();// RDT 2-27-03 added Create Empty batch
s_toolmenu lstr_toolmenu
n_cst_privileges	lnv_Privileges

if isvalid(inv_ToolmenuManager) then 
	//already created
else
	inv_ToolmenuManager = create n_cst_toolmenu_manager
	inv_ToolmenuManager.of_set_parent(this)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "SAVE!"
	lstr_toolmenu.s_menuitem_text = "&Save"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_add_standard("DIVIDER!")
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "PREPROCESS!"
	lstr_toolmenu.s_menuitem_text = "&Preprocess"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "GENERATE!"
	lstr_toolmenu.s_menuitem_text = "&Generate "
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "INCREMENTAL!"
	lstr_toolmenu.s_menuitem_text = "Incre&mental Generation "
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "FUELSURCHARGE!"
	lstr_toolmenu.s_menuitem_text = "&Fuel surcharge"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "PERIODIC!"
	lstr_toolmenu.s_menuitem_text = "Pr&ocess Periodic Templates"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

	inv_ToolmenuManager.of_add_standard("DIVIDER!")
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "BATCHDETAIL!"
	lstr_toolmenu.s_menuitem_text = "Batch &Detail"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "BATCHPRINT!"
	lstr_toolmenu.s_menuitem_text = "Pr&int Batch"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "BATCHCLOSE!"
	lstr_toolmenu.s_menuitem_text = "Close Batc&h"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "BATCHEXPORT!"
	lstr_toolmenu.s_menuitem_text = "E&xport Batch"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "EMPTYBATCH!"
	lstr_toolmenu.s_menuitem_text = "Create &Empty Batch "
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

	inv_ToolmenuManager.of_add_standard("DIVIDER!")
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "REPAIR!"
	lstr_toolmenu.s_menuitem_text = "&Repair Transaction"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "ADDTRANSACTION!"
	lstr_toolmenu.s_menuitem_text = "&Add Transaction"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "DELETETRANSACTION!"
	lstr_toolmenu.s_menuitem_text = "De&lete Transaction"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "INTERACTIVE!"
	lstr_toolmenu.s_menuitem_text = "Goto Interacti&ve"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "CLOSETRANSACTION!"
	lstr_toolmenu.s_menuitem_text = "Close &Transaction"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "PRINTTRANSACTION!"
	lstr_toolmenu.s_menuitem_text = "Pri&nt Transaction"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)
end if
end subroutine

public subroutine wf_process_request (string as_request);// RDT 2-27-03 added EMPTYBATCH!

SetPointer(HourGlass!)
long 			ll_row, &
				lla_id[]

String 		ls_MessageTitle 
				
n_cst_Msg	lnv_msg
S_parm		lstr_Parm
n_cst_beo_Transaction	lnv_Transaction, &
								lnva_Transaction[]

CHOOSE CASE as_Request

CASE "SAVE!"
	PostEvent ( "pfc_Save" )
	
CASE "PREPROCESS!"
	if ib_IsClosedBatch then 
		Messagebox("Preprocess","Can not perform Preprocess on a closed batch")
	else
		this.Event ue_Preprocess()
	end if
CASE "GENERATE!"
	if ib_IsClosedBatch then 
		Messagebox("Batch Generate","Can not Generate a closed batch.")
	else
		this.Event ue_Generate()
	end if
		
CASE "INCREMENTAL!"
	if ib_IsClosedBatch then 
		Messagebox("Incremental Generation","The Batch is already closed.")
	else
		this.Event ue_Incremental()
	end if
	
CASE "FUELSURCHARGE!"
	if ib_IsClosedBatch then 
		Messagebox("Fuel Surcharge","Can not perform Fuel Surcharge on a closed batch.")
	else
		this.Event ue_Fuelsurcharge()
	end If

CASE "PERIODIC!"
	if ib_IsClosedBatch then 
		Messagebox("Batch Generate","Can not add periodic amounts to a closed batch.")
	else
		ib_PeriodicOnly = true
		this.Event ue_Periodic()
		ib_PeriodicOnly = false
	end if
	
CASE "BATCHDETAIL!"
	this.Event ue_BatchDetail()
	
CASE "BATCHPRINT!"
	wf_PrintBatch ( )

CASE "BATCHCLOSE!"
	if ib_IsClosedBatch then 
		Messagebox("Close Batch","Batch is already closed.")
	else
		wf_CloseBatch ( )
	end if

CASE "BATCHEXPORT!"
	THIS.Event ue_Export( )

CASE "REPAIR!"
	if ib_IsClosedBatch then 
		Messagebox("Repair Transaction","Can not Repair a Transaction on a closed batch.")
	else
		this.Event ue_Repair()
	end if

CASE "ADDTRANSACTION!"
	if ib_IsClosedBatch then 
		Messagebox("Add Transaction","Can not Add a Transaction to a closed batch.")
	else
		this.Event ue_AddTransaction()
	end if

CASE "DELETETRANSACTION!"
	if ib_IsClosedBatch then 
		Messagebox("Delete Transaction","Can not Delete a Transaction from a closed batch.")
	else
		this.Event ue_deleteTransaction()
	end if

CASE "INTERACTIVE!"
	if ib_IsClosedBatch then 
		Messagebox("Goto Interactive","Can not modify a Transaction in a closed batch.")
	else
		this.Event ue_interactive()
	end if
	
CASE "CLOSETRANSACTION!"
	if ib_IsClosedBatch then 
		Messagebox("Close Transaction","Can not Close a Transaction On a closed batch.")
	else
		this.Event ue_closeTransaction()
	end if
	
CASE "PRINTTRANSACTION!"
	this.Event ue_printTransaction()

CASE "EMPTYBATCH!"
	THIS.wf_CreateEmptyBatch() 

END CHOOSE

end subroutine

public subroutine wf_printbatch ();
Long lla_id[]
n_cst_beo_transaction lnva_transaction[]

If this.wf_GetTransactionList( lla_id, lnva_Transaction, FALSE /*get all ids*/ ) > 0 Then 
	tab_1.tabpage_1.dw_1.Event ue_PrintTransaction ( lnva_Transaction )
Else
	MessageBox("Print Batch","No Transactions To Print On This Batch")
	
End If

end subroutine

public function integer wf_closebatch ();Long	ll_Row, &
		ll_rowcount, &
		lla_id[]
Integer li_Return 		

n_cst_beo_Transaction	lnv_Transaction, &
								lnva_Transaction[]

IF ib_IsClosedBatch Then 
	MessageBox("Close Batch","Batch is Already Closed.")
	li_return = failure
ELSE
	
	choose case messagebox("Close Batch", "Are you sure you want to close this batch?",Question!, YesNo!, 2)
		case 1
			//close batch
			ll_rowcount = this.wf_GetTransactionList( lla_id, lnva_Transaction, false /*selected*/ )
			
			if ll_rowcount > 0 then
				st_printing.Visible = TRUE
				st_printing.text = "Closing All Transactions "
				li_return = tab_1.tabpage_1.dw_1.Event ue_CloseTransaction ( lnva_Transaction )	
				st_printing.Visible = FALSE
				
			Else
				li_return = failure	
			end if
			
			If li_Return = success then 
				if Messagebox("Transactions Closed","Do you want to Print the Batch?", Question!, YesNo!, 1) = 1 Then 
					This.wf_PrintBatch()
				end if
			End If
	
		case 2
			//get out
			
	end choose	
	
END IF 
	
Return li_Return 
	
end function

public function long wf_gettransactionlist (ref long ala_ids[], ref n_cst_beo_transaction anva_transaction[], boolean ab_selected);long	ll_rowcount, &
		ll_row, &
		ll_Arraycount, &
		ll_transaction, &
		ll_return=1

boolean	lb_getid
Long	lla_IDs[]

n_cst_beo_Transaction	lnv_Transaction, &
								lnva_Transaction[]

ll_rowcount = tab_1.tabpage_1.dw_1.rowcount()

if isvalid(inv_TransactionManager) then
	//ok
else
	ll_return = -1 
end if

if ll_return = 1 then
	
	
	IF ab_selected	THEN
		Long	ll_Count
		
		ll_Count = tab_1.tabpage_1.dw_1.of_Getselectedtransaction( lla_IDs )
		/*MFS - 6/7/07 - Commented out replaced with logic below
			FOR i = 1 TO ll_Count 
			ll_Transaction = lla_IDs[i]
			
			inv_TransactionManager.of_GetTransaction( ll_Transaction , lnv_transaction)
			if isvalid(lnv_Transaction) then
				ll_ArrayCount ++
				lnva_Transaction[ll_ArrayCount] = lnv_Transaction
				ala_ids[upperbound(ala_ids) + 1] = ll_transaction
			end if
			NEXT
		 */
	ELSE
		
		/*MFS - 6/7/07 - Commented out replaced with logic below
		for ll_row = 1 to ll_rowcount
			
	
			ll_transaction = tab_1.tabpage_1.dw_1.object.transaction_id[ll_row]
			
			if isnull(ll_transaction) or ll_transaction = 0 then
				//don't add
			else
				inv_TransactionManager.of_GetTransaction(ll_transaction, lnv_transaction)
				if isvalid(lnv_Transaction) then
					ll_ArrayCount ++
					lnva_Transaction[ll_ArrayCount] = lnv_Transaction
					ala_ids[upperbound(ala_ids) + 1] = ll_transaction
				end if
			end if
		next
		*/
		
		FOR ll_Row = 1 TO ll_RowCount
			
			ll_Transaction = tab_1.tabpage_1.dw_1.object.transaction_id[ll_row]
			
			IF IsNull(ll_Transaction) OR ll_Transaction = 0 THEN
				//Dont't Add
			ELSE
				lla_Ids[UpperBound(lla_Ids) + 1] = ll_Transaction
			END IF
		NEXT
		
	END IF
	
	//MFS - 6/7/07 - Getting all the transactions at once yields better performance
	IF UpperBound(lla_Ids) > 0 THEN
		
		IF inv_TransactionManager.of_GetTransaction(lla_Ids, lnva_Transaction) <> 1 THEN
			ll_Return = -1
		ELSE
			ala_Ids = lla_Ids
			anva_Transaction = lnva_Transaction
		END IF
		
	END IF
	
END IF

return upperbound(ala_ids)
end function

public function integer wf_validateselectionfilter (string as_messagetitle, boolean ab_completevalidation);// ab_CompleteValidation = TRUE, validate batch name and date
// ab_CompleteValidation = FALSE, there should not be a batch date,
//						only batch name

long		ll_rowcount
integer	li_return = 1, &
			li_drivertype
date		ld_batch
string	ls_batch, &
			ls_messagetitle

if len(trim(as_messagetitle)) = 0 then
	ls_messagetitle = "Selection Filter"
else
	ls_messagetitle = as_messagetitle
end if

ls_batch = uo_1.of_GetBatchnumber()


if li_return = 1 then
	if len(trim(ls_batch)) = 0 or isnull(ls_batch) then
		messagebox(as_messagetitle, "Please enter a batch number.")
		uo_1.event ue_setfocus("BATCHNUMBER")
		li_return = -1
	end if
end if

if li_return = 1 then
	//do we have a batch date
	ld_batch = uo_1.of_GetBatchdate()
	if isnull(ld_batch) then
		if ab_Completevalidation then
			messagebox(as_messagetitle, "Please enter a date for the batch.")
			uo_1.event ue_setfocus("BATCHDATE")
			li_return = -1
		else
			//ok don't want one
		end if
	else
		if ab_Completevalidation then
			//ok we want one
		else
			messagebox(as_messagetitle, "Please clear the batch date.")
			uo_1.event ue_setfocus("BATCHDATE")
			li_return = -1
		end if
	end if
ELSE
	// clear batch date, ld_batch
	SetNull(ld_batch)
end if

return li_return
end function

public function integer wf_preprocess (n_cst_beo_entity anva_entities[]);// wf_preprocess
//

setpointer(HourGlass!)
boolean	lb_preprocessed = FALSE

integer	li_return = 1, &
			li_result
			
long		ll_intermediateReturn, &
			ll_rowcount, &
			ll_ndx

date	ld_min, &
		ld_max, &
		ld_start, &
		ld_end
		
string 	ls_messagetitle = "Preprocess Autogen"	, &
			ls_filename, &
			ls_fullfilename, &
			ls_tempname, &
			ls_ErrorPathName, &
			ls_entityname, &
			ls_batch

s_Anys	lstr_Result
n_cst_msg	lnv_msg
s_parm	lstr_parm

n_cst_beo_entity	lnva_entity[]

n_ds	lds_EntityInfo

lstr_Parm.is_Label = "OPTIONAL"
lstr_Parm.ia_Value = "FALSE"
lnv_msg.of_add_Parm ( lstr_Parm )

//added 11/19/04 - nwl
//if we are preprocessing for an incremental batch then don't allow the start date to be changed

if this.wf_getstartenddate(ld_start, ld_end) = 1 then
	lstr_Parm.is_Label = "START"
	lstr_Parm.ia_Value = ld_start
	lnv_msg.of_add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "END"
	lstr_Parm.ia_Value = ld_end
	lnv_msg.of_add_Parm ( lstr_Parm )

	lstr_Parm.is_Label = "DISABLESTART"
	lnv_msg.of_add_Parm ( lstr_Parm )

end if


OpenWithParm ( w_Date_Range, lnv_Msg )

setpointer(HourGlass!)

lstr_result = message.powerobjectparm
li_result = lstr_result.anys[1]

if li_result = 1 then
	ld_min = lstr_result.anys[2]
	ld_max = lstr_result.anys[3]
	id_preprocessstart = ld_min
	id_preprocessend = ld_max
ELSE						
	li_Return = -1		
	Return li_Return  // ***** MID-CODE RETURN **** //
end if

//perform preprocessing for the drivers
//force a retrieval with  driver type
IF li_result = 1 THEN
	ib_PreprocessAutogen = FALSE  /* clear flag in case it was set previously */
	lb_Preprocessed = FALSE
	// using the drivers selected in the window, load the entities.
	if This.wf_loadentities(lnva_entity,false) > 0 then
//			if This.wf_GenerateTransactions(lnva_entity) = 1 then

		ll_IntermediateReturn = this.wf_GetErrorLogPath(ls_ErrorPathname)
		IF IsNull(ls_ErrorPathname) OR ll_Intermediatereturn < 1 THEN
			li_Return = -1
		ELSE
			ls_filename = uo_1.of_getbatchnumber()
			ls_TempName = String(Now())
			ls_TempName = Replace(ls_Tempname,3,1,"-")
			ls_TempName = Replace(ls_Tempname,6,1,"-")
			ls_fullfilename = ls_ErrorPathName + ls_filename + "PreP-" + ls_Tempname + ".txt"
//			inv_TransactionManager = CREATE n_cst_bso_TransactionManager
			lds_EntityInfo = CREATE n_ds
			lds_EntityInfo.DataObject = "d_Preprocess"

			li_Return = inv_Transactionmanager.of_preprocessautogen(lnva_entity, & 
			ld_Min, ld_Max, inv_Transactionmanager, lb_preprocessed, lds_EntityInfo )	
			ib_preprocessautogen = lb_preprocessed				

			// code to save file
			ll_rowcount = lds_EntityInfo.RowCount()
			If  ll_rowcount > 0 Then 
				//add name to rows
				for ll_ndx = 1 to ll_rowcount
					ls_entityname = This.wf_GetEntityName( lds_EntityInfo.object.entityid[ll_ndx] ) 
					lds_EntityInfo.object.entityname[ll_ndx] = ls_entityname
				next
				
				if lds_EntityInfo.SaveAs(ls_fullfilename, TEXT!, FALSE /* no column headers */) = -1 then
					li_return = -1
				end if
			Else												
				ls_fullfilename = "EMPTY"					
			End if										

		end if
	ELSE 
		li_Return = -1
	END IF
END IF

IF li_Return >= 0 THEN
	if ls_fullfilename = "EMPTY" Then 	
		MessageBox(ls_Messagetitle, "Autogen preprocessing has finished.  No Errors found." )
	else
		MessageBox(ls_Messagetitle, "Autogen preprocessing has finished.  Check the errors" + &
		" in the error log file: " + ls_fullfilename, information!, ok!)
		
		ls_batch = uo_1.of_GetBatchnumber()
		if len(trim(ls_batch)) > 0 then
			// populate file list and select the first file 
			uo_errorlog.of_setfiltername(ls_batch)
			uo_errorlog.of_setpath( ls_ErrorPathName )
			uo_errorlog.of_LoadfileList()
			uo_errorlog.of_SelectFile(ls_filename + "PreP-" + ls_Tempname + ".txt")
		end if
	end if
	this.wf_settabpageheader(id_preprocessstart, id_preprocessend)
ELSE
			MessageBox(ls_Messagetitle, "Autogen preprocessing has failed to finish.")			
END IF

Return li_Return
end function

public function long wf_retrievedrivers (string as_cachetype);//assuming that the validation of the inputs for arguments has already been done
setpointer(HourGlass!)

long		ll_rowcount, &
			ll_row, &
			ll_id, &
			ll_division
			
string	ls_batchnumber, &
			ls_filter
			
date		ld_batch
integer	li_drivertype

Boolean	lb_LookingUpExistingbatch
Boolean	lb_PostValidate
Boolean	lb_Continue = TRUE

ls_batchnumber = uo_1.of_getbatchnumber()
ld_batch = uo_1.of_GetBatchDate()
li_drivertype = ddlb_1.of_GetDriverType()
ll_division = wf_getdivision()

// if they are creating a new batch then we will need to pre-screen the  division selected
// wf_ValidateDivisionSelection require that they select a division if they are using the 
// advanced privs.

lb_PostValidate =  THIS.wf_DoesBatchNameExist ( ls_batchnumber )
	
IF NOT lb_PostValidate THEN
	lb_Continue = THIS.wf_ValidateDivisionSelection ( ll_division ) = 1
END IF
		

IF lb_Continue THEN
	tab_1.tabpage_1.dw_1.reset ( )
	
	choose case as_cachetype
		case cs_newbatch_cache
			//don't need batchdate
			ids_drivers_notbatched.reset()
			ids_drivers_notbatched.setfilter('')
			ids_drivers_notbatched.filter()
			ll_rowcount = ids_drivers_notbatched.retrieve(ls_batchnumber, li_drivertype)
			Commit; // <<*>> 9.1.2006
			
			if ll_rowcount > 0 then
				if ll_division > 0 then
					ls_filter = "division = " + string(ll_division)
					ids_drivers_notbatched.setfilter(ls_filter)
					ids_drivers_notbatched.filter()
				end if
				if ids_drivers_notbatched.RowsCopy (1, ll_rowcount, Primary!, tab_1.tabpage_1.dw_1 , 1, Primary! ) = 1 then
					//newrow
				end if
			end if
		case cs_oldbatch_cache
			if isnull(ld_batch) then
				//don't retrieve
			else
				ids_drivers_batched.reset()
				ids_drivers_batched.setfilter('')
				ids_drivers_batched.filter()
				ll_rowcount = ids_drivers_batched.retrieve(ls_batchnumber, li_drivertype, ld_batch)
				Commit; // <<*>> 9.1.2006
				if ll_rowcount > 0 then
					if ll_division > 0 then
						ls_filter = "division = " + string(ll_division)
						ids_drivers_batched.setfilter(ls_filter)
						ids_drivers_batched.filter()
					end if
					if ids_drivers_batched.RowsCopy (1, ll_rowcount, Primary!, tab_1.tabpage_1.dw_1 , 1, Primary! ) = 1 then
						ll_id = tab_1.tabpage_1.dw_1.object.transaction_id[1]
						if isnull(ll_id) then
							//leave as new row
						else
							tab_1.tabpage_1.dw_1.setitemstatus(ll_row, 0, primary!, datamodified!)
							tab_1.tabpage_1.dw_1.setitemstatus(ll_row, 0, primary!, notmodified!)
						end if				
					end if
				end if
			end if	
	end choose
END IF

IF lb_PostValidate THEN
	// we need to filter out/Identify any drivers that are not supposed to be included based on user privs.
	IF THIS.wf_validatedivsionsinbatch( ) <> 1 THEN
		tab_1.tabpage_1.dw_1.reset ( )
		uo_1.of_Refresh( )
		ll_RowCount = 0
	END IF
END IF

return ll_rowcount

end function

public function long wf_geterrorlogpath (ref string as_pathname);//
//  
//
//	Function:  Wf_GetErrorLogPath
//  
//	Access:  public
//
//	Arguments: 
//					as_filename by reference
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for w_settlementbatchmanager
//
//  Obtain the system setting that specifies the path to the 
// payable batch error logs.  These error logs were designed to
// give users info about autogen failures.
//
// Written by: J. Albert
// 		Date: 12.05.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

any 	la_path

long	ll_return = 1

String	ls_MessageHeader = "Autogen Info Log Path", &
			ls_message, &
			ls_path
			
n_cst_settings	lnv_Settings		
n_cst_fileSrvwin32	lnv_fileSrv
lnv_FileSrv = CREATE n_cst_fileSrvwin32

IF lnv_Settings.of_Getsetting(129, la_path) = 1 THEN	
	ls_path = trim(string(la_path))
	IF len(ls_path) > 0 THEN
		IF Right(ls_path, 1) = "\" THEN
		ELSE
			ls_path += "\"
		END IF
	END IF
	
	IF Not lnv_FileSrv.of_DirectoryExists( ls_path ) THEN
		
		messageBox ( "Folder Location" , "The folder specified in the system settings '" + ls_Path + &
		    "' does not exist. Please enter a path in the system settings for the error logs." )
		ll_return = -1
		
	END IF


ELSE
	ls_Message = "Autogen needs an information log path to contain" +&
	" a list of any truck drivers that could not be settled.  Please" + &
	" setup the 'Path To Payable Batch Error Log' system setting."
	MessageBox(ls_messageHeader, ls_message)
	ll_Return = -1
END IF
as_pathname = ls_path			
			
destroy lnv_FileSrv

RETURN ll_return
end function

public function integer wf_generatetransactions (ref n_cst_beo_entity anva_entity[], n_cst_beo_transaction anva_transaction[]);setpointer(HourGlass!)

boolean lb_TellMe
Boolean	lb_NeedDate = TRUE

integer	li_return = 1, &
			li_result, &
			ll_Counter
date	ld_start, &
		ld_end
		
Int	li_DateRtn

s_Anys	lstr_Result
n_cst_msg	lnv_msg
s_parm	lstr_parm

lstr_Parm.is_Label = "OPTIONAL"
lstr_Parm.ia_Value = "FALSE"
lnv_msg.of_add_Parm ( lstr_Parm )

//modified - 11/19/04 nwl
//Use to check for the preprocess date before looking for a current batch date.
//Now looking for a start/end date from the batch. If proprocess was run then substitute the 
//end date. 
li_DateRtn = this.wf_getstartenddate(ld_start, ld_end)
if li_DateRtn = 1 then
	lstr_Parm.is_Label = "START"
	lstr_Parm.ia_Value = ld_start
	lnv_msg.of_add_Parm ( lstr_Parm )
	
	if ib_PreprocessAutogen then
		lstr_Parm.is_Label = "END"
		lstr_Parm.ia_Value = id_preprocessend
		lnv_msg.of_add_Parm ( lstr_Parm )
	else
		lstr_Parm.is_Label = "END"
		lstr_Parm.ia_Value = ld_end
		lnv_msg.of_add_Parm ( lstr_Parm )
	end if
	
elseif ib_PreprocessAutogen then
	//we have date range
	lstr_Parm.is_Label = "START"
	lstr_Parm.ia_Value = id_preprocessstart
	lnv_msg.of_add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "END"
	lstr_Parm.ia_Value = id_preprocessend
	lnv_msg.of_add_Parm ( lstr_Parm )
end if
//end new code

//////  restricting the USER FROM CHANGING THE DATE range if the date has already been defined on the batch/





choose case is_request
	case cs_request_incremental
		lstr_Parm.is_Label = "DISABLESTART"
		lnv_msg.of_add_Parm ( lstr_Parm )
		
	case cs_request_repair
		
		n_cst_setting_EnableStartEndDate	lnv_Setting
		
		lnv_Setting = create n_cst_setting_EnableStartEndDate
		
		IF lnv_Setting.of_Getvalue( ) = lnv_Setting.cs_Yes THEN
			//don't disable
		ELSE
			//default
			lstr_Parm.is_Label = "DISABLESTART"
			lnv_msg.of_add_Parm ( lstr_Parm )
			lstr_Parm.is_Label = "DISABLEEND"
			lnv_msg.of_add_Parm ( lstr_Parm )
		END IF
		
		destroy lnv_setting
	
	CASE ELSE
		IF li_DateRtn = 1 THEN
			lb_NeedDate = FALSE
		END IF
				
end choose
IF lb_NeedDate THEN
	OpenWithParm ( w_Date_Range, lnv_Msg )
	
	lstr_result = message.powerobjectparm
	li_result = lstr_result.anys[1]
	
	if li_result = 1 then
		ld_start = lstr_result.anys[2]
		ld_end = lstr_result.anys[3]
	else						//User must have hit Cancel on the w_date_Range Window. 
		li_Return = -1		
	end if
END IF
setpointer(HourGlass!)

If li_Return = 1	Then 
	ll_Counter = Upperbound(anva_entity)
	//li_Return = this.wf_setuptoautogen(anva_entity, inv_transactionmanager, &
	//   ld_start, ld_end, ib_preprocessautogen)
	li_Return = this.wf_setuptoautogen(anva_entity, inv_transactionmanager, &
		ld_start, ld_end, ib_preprocessautogen, anva_transaction)
End if 						

return li_return
end function

private function integer wf_displayclosedbatch (readonly boolean ab_closed);// //
/***************************************************************************************
NAME			: wf_DisplayClosedBatch
ACCESS		: Private 
ARGUMENTS	: Boolean (True = Closed, False = Open)
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Sets window to displayt closed batch.

REVISION		: RDT 02-05-03
***************************************************************************************/
Integer	li_Return = 1

ib_IsClosedBatch = ab_closed

If ab_closed then 
	// DISable the dw	
	li_Return = tab_1.Event ue_dwEnabled(FALSE)
	
Else
	// ENable the dw
	li_Return = tab_1.Event ue_dwEnabled(TRUE)


End If

Return li_Return 
end function

public function integer wf_getemployeetype (readonly long al_entityid);
Long 		ll_EmployeeID
Integer	li_EmployeeType, &
			li_Return 
			
n_cst_Beo_Entity		lnv_Entity

If IsValid( inv_TransactionManager ) Then 
		inv_TransactionManager.of_GetEntity( al_EntityId, lnv_Entity )
	
	IF isValid ( lnv_Entity ) THEN	
		ll_EmployeeID	= lnv_Entity.of_GetFKEmployee ( )
		li_EmployeeType = lnv_Entity.of_GetEmployeeType ( ll_EmployeeID )
	END IF
	
	If IsNull ( ll_EmployeeID ) Then 
		li_Return = -1
	Else
		li_Return = li_EmployeeType 
	End IF
Else
	li_Return = -1
End If

if isvalid(lnv_Entity) then
	destroy lnv_Entity
end if

Return li_Return 
end function

public subroutine wf_findbatch ();
Date		ld_batch
String 	ls_Batch
Integer  li_Result = 1
boolean	lb_Continue = TRUE

ld_batch = uo_1.of_GetBatchDate()
ls_Batch = uo_1.of_GetBatchnumber()

Choose Case wf_PendingUpdates() 
		Case 1
			lb_Continue = TRUE
		Case 2
			lb_Continue = TRUE
		Case 3
			lb_Continue = FALSE
			uo_1.of_SetBatchNumber ( is_Batch )   
End Choose
	
If lb_Continue Then 
	if isnull(ld_batch) then
		This.Event ue_Find(cs_newbatch_cache)
	else
		This.Event ue_Find(cs_oldbatch_cache)
	end if
End if

tab_1.post event ue_setfocus()

end subroutine

public function integer wf_pendingupdates ();
// wf_PendingUpdates() 
// check for pending updates and ask to save
// Return Codes: 1 = Saved  2 = NO, 3 = Cancel OR Save Failed

integer 	li_Return = 1

if isvalid(inv_transactionmanager) then
	If inv_transactionmanager.Event pt_UpdatesPending() = 1 then 
	
		Choose Case MessageBox("Updates Are Pending","Do You Want To Save Changes ?",Question!,YesNoCancel!) 
				
			Case 1
				If This.Event pfc_Save( ) < 0 Then 
					MessageBox ( "Save" , "Save Failed", EXCLAMATION!)
					li_Return = 3
				Else			
					li_Return = 1
				End if
			Case 2
				inv_transactionmanager.Event pt_ReSet() // NEED TO CLEAR UPDATE FLAG and continue
				li_Return = 2
			Case 3
				uo_1.of_SetBatchNumber ( is_Batch )   
				li_Return = 3
		End Choose
		
	End If
end if

Return li_Return 
end function

public function string wf_getcategorybydrivertype ();// checks the driver type and returns the catagory

Integer 	li_DriverType 
String	ls_Return = ""

li_DriverType = this.ddlb_1.of_Getdrivertype ( )

Choose Case li_DriverType 
	Case 0					// 0 = "Owner Operator" 
		ls_Return = "PAYABLES"
	Case 1					//1 = "Company" 
		ls_Return = "PAYROLL"
	Case 2 					//2 = "Third Party" 
		ls_Return = "PAYABLES"
	Case 3					//3 = "Casual" 		
		ls_Return = "PAYROLL"
	Case Else
		MessageBox("Settlemt Batch Manager wf_GetCatagoryByDriverType","Case not coded for driver type:"+String( li_DriverType) )
End Choose


Return ls_Return
end function

public function string wf_getentityname (readonly long al_entityid);// wf_GetEntityName

// finds the entity id on the datawindow and returns the name

String	ls_Return, &
			ls_Find
Long 		ll_Result

ls_Find = "id = "+String( al_entityID )

ll_Result = tab_1.tabpage_1.dw_1.Find (ls_Find , 1, tab_1.tabpage_1.dw_1.RowCount() )

If ll_Result < 1  OR IsNull( ll_Result ) Then 
	ls_Return = ""
Else
	ls_Return =  tab_1.tabpage_1.dw_1.GetItemString(ll_Result, 'last_first_name' )
End If

Return ls_Return
end function

public function boolean of_isnewbatch (readonly string as_batch);
Boolean 	lb_Return = TRUE

Long		ll_RowCount

datawindowchild	ldwc_batch

IF Len( TRim( as_batch) ) < 1 or IsNull( as_batch ) Then 
	lb_Return = False
Else
	ldwc_Batch = uo_1.of_GetBatchlist()
	ll_rowcount = ldwc_Batch.rowcount()
	if ll_rowcount > 0 then
		if ldwc_Batch.find("batchnumber = '" + as_Batch + "'", 1, ll_Rowcount) > 0 or &
			len(trim(as_Batch)) = 0 then
			uo_1.event ue_setfocus("BATCHNUMBER")
			lb_Return = FALSE
		Else
			lb_Return = TRUE
			ib_newbatch = TRUE
		end if
		
	end if
End if
Return lb_Return 
end function

public function integer wf_createemptybatch ();// open date window 
// Create beo Transaction for each driver
// Set start date and end date for each transaction
// set batch name on each transaction

setpointer(HourGlass!)

String	ls_BatchNumber, &
			ls_MessageTitle = "Create Empty Batch"

integer	li_return = 1, &
			li_result, &
			li_Counter

Long 		ll_RowCount, &
			ll_EntityId 
			
date		ld_min, &
			ld_max

n_cst_beo_transaction lnva_Transaction[], lnv_NullTransaction

s_Anys	lstr_Result
n_cst_msg	lnv_msg
s_parm	lstr_parm

//// Check for a new batch number
If li_Return = 1	Then 
	ls_BatchNumber = uo_1.of_getbatchnumber ( )	
	If NOT This.of_IsNewBatch( ls_BatchNumber )  Then 
		MessageBox(ls_MessageTitle, "Please Enter a New Batch Number")
		li_Return = -1 
	End If
End If

//// Retrieve Driver List
If li_Return = 1	Then 
	cb_find.TriggerEvent( Clicked! )
End If	


// Confirm with user
If li_Return = 1	Then 
	If MessageBox(ls_MessageTitle,"Do You Want to Create an Empty Batch for These Drivers?",Question!,YesNo!,2) = 2 Then 
		li_Return = -1
	End If
End If

//// open date range window
If li_Return = 1	Then 
	lstr_Parm.is_Label = "OPTIONAL"
	lstr_Parm.ia_Value = "FALSE"
	lnv_msg.of_add_Parm ( lstr_Parm )
	
	OpenWithParm ( w_Date_Range, lnv_Msg )
		
	lstr_result = message.powerobjectparm
	li_result = lstr_result.anys[1]
End If

If li_result = 1 then	// user hit OK on w_date_Range window
	ld_min = lstr_result.anys[2]
	ld_max = lstr_result.anys[3]
Else							//User hit Cancel on the w_date_Range Window. 
	li_Return = -1		
End if

//Create transactions 
If li_Return = 1	Then 
	ll_RowCount = tab_1.tabpage_1.dw_1.RowCount()
	inv_transactionmanager.Event PT_Reset ( )
	// loop thru all drivers in dw. get their entity id. create transactions. set values
	For li_Counter = 1 to ll_RowCount
		ll_EntityId = tab_1.tabpage_1.dw_1.object.id[li_Counter]
		
		if this.wf_CreateNewtransaction( ll_EntityId, lnva_Transaction[ li_Counter ]) = -1 then
			li_Return = -1 
			Exit
		end if

		If lnva_Transaction[ li_Counter ].of_setfkentity ( ll_EntityId ) = -1 Then 
			Messagebox(ls_MessageTitle,"Entity ID Not Set "+String(ll_entityId) )
			li_Return = -1	
			Exit
		End If
		
		If lnva_Transaction[ li_Counter ].of_setBatchNumber(ls_batchNumber) = -1 Then 
			Messagebox(ls_MessageTitle,"Batch Number Not Set "+ ls_Batchnumber )
			li_Return = -1		
			Exit			
		End If
		
		If lnva_Transaction[ li_Counter ].of_setstartdate ( ld_min ) = -1 Then 
			Messagebox(ls_MessageTitle,"Start Date Not Set "+String(ld_min, "mm/dd/yyyy") )
			li_Return = -1		
			Exit			
		End If
		
		If lnva_Transaction[ li_Counter ].of_setenddate ( ld_max ) = -1 Then 
			Messagebox(ls_MessageTitle,"End Date Not Set "+String(ld_max, "mm/dd/yyyy"))
			li_Return = -1		
			Exit			
		End If
		
		If lnva_Transaction[ li_Counter ].of_setopen ( TRUE ) = -1 Then 
			Messagebox(ls_MessageTitle,"Open Status Not Set " )
			li_Return = -1		
			Exit			
		End If

	Next 		// li_Counter 

End if 	// li_Return = 1	

if li_return = 1 then
	// Update display
	tab_1.tabpage_1.dw_1.Event ue_updateTransaction(lnva_Transaction)
	this.wf_settabpageheader(ld_min, ld_max)
end if

Return li_Return 
end function

public function long wf_getperiodictemplates (n_cst_bso_transactionmanager anv_transactionmanager, ref n_cst_beo_amounttemplate anva_templates[]);long	ll_ndx, &
		ll_count
n_cst_beo_amounttemplate	lnva_amounttemplate[], &
									lnva_periodictemplate[]
									
anv_TransactionManager.of_GetAmountTemplate(lnva_amounttemplate)

ll_count = upperbound(lnva_amounttemplate)

FOR ll_ndx = 1 to ll_Count 
	CHOOSE CASE lnva_amounttemplate[ll_ndx].of_gettype()
		// yes, we are resetting the booleans repeatedly, otherwise we'd have to add additional 
		// conditional logic.
	CASE 1	//point to point
		//ignore
	CASE 2	//shipment
		//ignore
	CASE 3 //Move
		//ignore
	CASE 4	//range
		//ignore
	CASE 5	//day
		//ignore
	CASE 6	//leg
		//ignore
	CASE 7	//periodic
		lnva_periodictemplate[Upperbound(lnva_periodictemplate) + 1] = lnva_amounttemplate[ll_ndx]			
	CASE ELSE
//		ls_ErrMsg = "10325|Amount template type, " + string(lla_AmountTemplateType[ll_TemplateIndex]) + &
//		 ", is invalid for autogen process."
//		 ll_Return = this.of_inserterrorMsg(ls_ErrMsg)
	END CHOOSE		
NEXT  
anva_templates = lnva_periodictemplate

return Upperbound(anva_templates)
end function

public function integer wf_getstartenddate (ref date ad_start, ref date ad_end);/*
	try to get a startand end date from the transaction
	
	return -1 failure
			1 success
*/
integer	li_return = 1
long		ll_transcount, &
			ll_ndx, &
			lla_transid[]
date		ld_start, &
			ld_end
			
n_cst_beo_transaction	lnva_transaction[]

//assume we don't get it
li_return = -1

This.wf_getTransactionlist(lla_TransId, lnva_transaction, FALSE)
ll_TransCount = upperbound(lnva_Transaction)	

for ll_ndx = 1 to ll_transcount
	IF isvalid(lnva_Transaction[ll_ndx]) THEN	
	// does the transaction have the start and end dates?
		ld_start = lnva_Transaction[ll_ndx].of_GetStartDate()
		ld_end = lnva_Transaction[ll_ndx].of_GetEndDate()
		IF IsNull(ld_start) or IsNull(ld_end) THEN
			continue
		else
			//they should all be the same just take the first one
			li_return = 1
			exit
		end if	
	end if
next

if li_return = 1 then
	
	if is_request = cs_request_incremental then
		ad_start = RelativeDate ( ld_end, 1 )
		ad_end = ad_start
	else
		ad_start = ld_start
		ad_end = ld_end
	end if
	
end if


return li_return
			
end function

public subroutine wf_settabpageheader (date ad_start, date ad_end);string	ls_tabtext
date		ld_batch

ls_tabtext = "Batch: "
ls_tabtext += uo_1.of_Getbatchnumber()
ls_tabtext += "     Batch Date: "
ld_batch = uo_1.of_getbatchdate()
if isnull(ld_batch) then
	ls_tabtext += "   "
else
	ls_tabtext += string(uo_1.of_getbatchdate(), 'mm/dd/yy')
end if
ls_tabtext += "     Driver type: "
ls_tabtext += ddlb_1.of_GetDriverLabel()
if isnull(ad_start) or isnull(ad_end) or ad_start = date('1/1/1900') or ad_end = date('1/1/1900') then
	ls_tabtext += "     Start Date: " +	"     End Date: "
else	
	ls_tabtext += "     Start Date: " + string(ad_start,'mm/dd/yy') + &
				"     End Date: " + string(ad_end,'mm/dd/yy')
end if

tab_1.tabpage_1.text=ls_tabtext

end subroutine

public function long wf_loadentities (ref n_cst_beo_entity anva_entity[], long lla_id[]);setpointer(HourGlass!)

long	ll_ndx, &
		ll_count, &
		ll_rowcount, &
		ll_arraycount, &
		ll_found, &
		ll_entity, &
		ll_return=1
		
n_cst_beo_entity	lnva_entity[]
n_cst_beo	lnv_Beo
n_cst_bcm	lnv_Cache

lnva_entity = anva_entity
ll_arraycount = upperbound(lnva_entity)

gnv_App.inv_CacheManager.of_SetAutoCache ( TRUE )
IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_entity", lnv_Cache, TRUE, TRUE ) = 1 THEN
	//proceed
else
	ll_return = -1
end if

if ll_return = 1 then
	
	ll_count = upperbound(lla_id)
	ll_rowcount = tab_1.tabpage_1.dw_1.rowcount()
	
	for ll_ndx = 1 to ll_count
		
		ll_found = tab_1.tabpage_1.dw_1.find('transaction_id = ' + string(lla_id[ll_ndx]), 1, ll_rowcount)
		
		if ll_found > 0 then
			
			ll_entity = tab_1.tabpage_1.dw_1.object.id[ll_found]
			lnv_Beo = lnv_Cache.GetBeo ( "entity_id = " + String ( ll_entity ) )
			IF IsValid ( lnv_Beo ) THEN
				ll_arraycount ++
				lnva_entity[ll_arraycount] = lnv_beo
			END IF
			
		end if
		
	next
	
END IF

anva_entity = lnva_entity

RETURN upperbound(anva_entity)

end function

private function long wf_getdivision ();///////////////////////////////////////////////////////////////////////////////
//
//	Function		:wf_GetDivision
//  
//	Access		:private
//
//	Arguments	:none
//
//	Return		:division type long    
//					
//
//	Description	:Ask the division object for division
//
// Written by: n Leblanc
// 		Date: 07/02/2004
//		Version: 4.0.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
return dw_division.of_GetDivision()
end function

protected subroutine wf_setdivision (string as_cachetype);///////////////////////////////////////////////////////////////////////////////
//
//	Function		:wf_SetDivision
//  
//	Access		:private
//
//	Arguments	:none
//
//	Return		:none   
//					
//
//	Description	:Get a division from the driver list ( should all be the same ) 
//					 and send it to the division object.
//
// Written by: n. LeBlanc
// 		Date: 07/02/2004
//		Version: 4.0.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

long		ll_Drivercount, &
			ll_ndx, &
			lla_transid[], &
			ll_division, &
			lla_TranIds[]
			
n_cst_beo_transaction	lnva_transaction[]		
			
setnull(ll_division)

choose case as_cachetype
	case cs_newbatch_cache
		//don't set it, the user is allowed to change it
		ll_Drivercount = ids_drivers_notbatched.rowcount()
		for ll_ndx = 1 to ll_Drivercount
			ll_division = ids_drivers_notbatched.object.division[ll_ndx]
			IF IsNull(ll_division) THEN
				continue
			else
				//they should all be the same just take the first one
				exit
			end if	
		next

	case cs_oldbatch_cache
		ll_Drivercount = ids_drivers_batched.rowcount()
		for ll_ndx = 1 to ll_Drivercount
			ll_division = ids_drivers_batched.object.division[ll_ndx]
			IF IsNull(ll_division) THEN
				continue
			else
				//they should all be the same just take the first one
				exit
			end if	
		next

end choose

if ll_division > 0 then 
	if This.wf_getTransactionlist(lla_TranIds, lnva_transaction, false) > 0 then
		dw_division.of_SetDivision(ll_division)
		this.event ue_divisionchanged(ll_division)
	end if
end if




end subroutine

protected function integer wf_getitinerary (long al_id, date ad_start, date ad_end, ref n_cst_beo_itinerary2 anv_itinerary);integer	li_return = 1, &
			li_RouteType

n_cst_beo_itinerary2	lnv_itinerary

n_cst_msg	lnv_Range
s_parm		lstr_Parm

if isvalid(inv_Dispatch) then
	//already created
else
	inv_dispatch = CREATE n_cst_bso_Dispatch
end if

lnv_itinerary = inv_dispatch.of_GetItinerary(gc_Dispatch.ci_ItinType_Driver, &
	al_id, RelativeDate(ad_start, -7), ad_End) 
	
IF NOT IsValid(lnv_itinerary) THEN
	li_return = -1

ELSE
	
	lnv_Itinerary.of_SetDiscardOptional(TRUE) 

	CHOOSE CASE inv_transactionmanager.of_GetRouteTypeSettlements(li_RouteType)
		CASE 0 // 
			//no
		CASE 1
			lnv_itinerary.of_SetRouteType(li_RouteType)
	END CHOOSE
	
	lstr_Parm.is_Label = "StartDate"
	lstr_Parm.ia_Value = ad_start
	lnv_Range.of_Add_Parm(lstr_Parm)
	
	lstr_Parm.is_Label = "EndDate"
	lstr_Parm.ia_Value = ad_end
	lnv_Range.of_Add_Parm(lstr_Parm)
	
	lstr_Parm.is_Label = "ItinType"
	lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_Driver
	lnv_Range.of_Add_Parm(lstr_Parm)
	
	lstr_Parm.is_Label = "ItinId"
	lstr_Parm.ia_Value = lnv_itinerary.of_GetItinId()
	lnv_Range.of_Add_Parm(lstr_Parm)
	
	lnv_itinerary.of_SetRange(lnv_Range)
	
	anv_itinerary = lnv_itinerary
	
END IF

return li_return

end function

public function integer wf_createnewtransaction (long al_entity, ref n_cst_beo_transaction anv_transaction);// Create beo Transaction for entity

setpointer(HourGlass!)

integer	li_return = -1

n_cst_beo_transaction lnva_Transaction[], lnv_NullTransaction

inv_Transactionmanager.of_setdefaultentityid(al_Entity)
inv_Transactionmanager.of_setdefaultCategory(n_cst_constants.ci_Category_Payables)	
inv_TransactionManager.of_LoadOpenTransactions ( al_Entity )

anv_Transaction = inv_Transactionmanager.of_newTransaction()

if isvalid(anv_Transaction) then
	li_return = 1
end if

Return li_Return 
end function

public function long wf_setuptoautogen (n_cst_beo_entity anva_entities[], ref n_cst_bso_transactionmanager anv_transactionmanager, date ad_start, date ad_end, boolean ab_preprocessingperformed, n_cst_beo_transaction anva_transaction[]);///////////////////////////////////////////////////////////////////////////////
//
//  
//
//	Function:  Wf_SetUpToAutogen
//  
//	Access:  private
//
//	Arguments: 
//					anva_entities[]
//					anv_transactionmanager by reference
//					ad_start
//					ad_end
//					ab_preprocessingperformed
//					anva_transaction[]
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for w_settlementBatchManager
//
//  	Checks if the entities were preprocessed.  Notifies users if the 
//    entities were not preprocessed.  Loop through all the entities
//    passed in as an arg; send out the entities one at a time to be
//    autogened.  Send out one entitiy, one valid itinerary, and one 
//    empty transaction.  Also send the supporting objects: dispatch,
//    transaction manager.
//
// Written by: J. Albert
// 		Date: 10.22.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

boolean lb_ContinueProcess, &
			lb_routetypedefined, &
			lb_NoFatalErrors, &
			lb_TransactionsPassedIn

date	ld_nulldate, &
		ld_testdate, &
		ld_first

Int	li_PipePos
integer	li_routetype, n

long ll_Return, &
		ll_Count, &
		ll_entitymax, &
		ll_errmsgcounter, &
		ll_entityid, &
		lla_EntityIds[], &
		ll_row, &
		ll_invaliditincounter, &
		ll_EmployeeId, &
		ll_RowCount, &
		ll_RowNbr, &
		ll_CountAmountOwed, &
		ll_UpdateMax, &
		ll_index, &
		lla_id[], &
		ll_MaxErrors, &
		ll_NbrAmountOweds, &
		ll_CountDestroy, &
		ll_Junk, &
		ll_ErrMsgSize, &
		ll_TotalNbrAmountOwed, &
		ll_GrandTotalNbrAmountOwed, &
		ll_debugCount
//		ll_debugfirstrow, &
//		ll_Debuglastrow, &

String ls_ErrMsg, &
			ls_ErrorPathName, &
			ls_FullErrorName, &
			ls_errorfile, &
			ls_TimeStamp, &
			ls_BatchNumber, &
			ls_entityname

n_ds	lds_EntityInfo, &
		lds_EntityItinInfo, &
		lds_PeriodicUpdates		
//datastore	lds_PeriodicUpdate
s_parm	lstr_Parm
n_cst_msg	lnv_Range
n_cst_OFRError		lnva_Error[], &
						lnv_Error
n_cst_beo_entity	lnv_Entity, &
						lnva_Entities[]
						
n_cst_bcm	lnv_BCM

n_cst_beo_amountowed	lnva_amountowedlist[]
							
n_cst_beo_amounttemplate	lnva_Amounttemplate[], &
									lnva_PAT[] //periodic amount template				
									
n_cst_beo_transaction	lnv_Transaction, &
								lnva_Transaction[], &
								lnv_NullTransaction
								
n_cst_bso_dispatch	lnv_dispatch
n_cst_beo_itinerary2	lnv_itinerary
n_cst_bso_payable		lnv_payable
n_cst_bso_transactionmanager	lnv_transactionmanager

w_autogen_progress	lw_progress

lb_ContinueProcess = TRUE


// Normally, there are no transactions passed thru anva_transaction. 
// However, if the user is doing a 'repair', the entities and 
// transactions that match them (1:1) are also passed into this
// method. That's because we want to reuse (that is 'repair') the
// existing transaction instead of creating a new transaction.
IF Upperbound(anva_transaction) > 0 THEN /* J. Albert, 12/18/02 */
	lb_TransactionsPassedIn = TRUE
	lnva_Transaction = anva_Transaction	
Else
	inv_transactionmanager.Event PT_Reset ( )			
END IF



lnva_entities = anva_entities
//IF ab_preprocessingperformed = FALSE THEN
IF ib_preprocessautogen = FALSE THEN	
	if ib_PeriodicOnly then
		//skip message
	else
		CHOOSE CASE messagebox("Auto Generation",&
			"You have not run the preprocessing for autogen since" + &
			" entering settlements." + &
			"  Mileage values may be zero and any calculations based " + &
			" on mileage may be affected.  Do you still with to generate" + &
			" the settlement?", Question!, YesNo!)
			CASE 1  // Proceed without preprocessing. Dangerous!
				lb_ContinueProcess = TRUE
			CASE 2 // Don't autogen.
				lb_ContinueProcess = FALSE
			CASE ELSE // Don't autogen.  Bogus situation
				lb_ContinueProcess = FALSE
		END CHOOSE
	end if
ELSE  
	IF IsValid(anv_TransactionManager) THEN
		inv_Transactionmanager = anv_transactionmanager
	END IF
END IF

IF lb_ContinueProcess = TRUE THEN
	ll_Return = this.wf_GetErrorLogPath(ls_ErrorPathname)
	IF IsNull(ls_ErrorPathname) OR ll_Return < 1 THEN
		lb_ContinueProcess = FALSE
	ELSE
		// create file name. Use Batchname plus modified time stamp. Replace ':' with '-'.
		ls_TimeStamp = String(Now())
		ls_TimeStamp = Replace(ls_TimeStamp,3,1,"-")
		ls_TimeStamp = Replace(ls_TimeStamp,6,1,"-")
		ls_BatchNumber = uo_1.of_getbatchnumber()
		ls_errorfile = ls_BatchNumber + "-" + ls_TimeStamp + ".txt"
		ls_FullErrorNAme = ls_ErrorPathName + ls_errorfile
		
	END IF	
END IF
IF lb_ContinueProcess = TRUE THEN
	// Holds error info for later display on screen 
	lds_EntityInfo = CREATE n_ds
	lds_EntityInfo.DataObject = "d_Preprocess"

	IF IsValid(lds_EntityInfo) THEN
	ELSE
		lb_ContinueProcess = FALSE
	END IF
END IF

IF lb_ContinueProcess = TRUE THEN
//	lnv_transactionmanager = anv_transactionmanager
	CHOOSE CASE inv_transactionmanager.of_GetRouteTypeSettlements(li_RouteType)
		CASE 0 // 
			lb_RouteTypeDefined = FALSE
		CASE 1
			lb_RouteTypeDefined = TRUE
	END CHOOSE
END IF

IF lb_ContinueProcess = TRUE THEN
	IF IsValid(lnv_Dispatch) THEN
	// this should fail; we don't have one yet
	ELSE
		lnv_Dispatch = CREATE n_cst_bso_Dispatch
		IF IsValid(lnv_Dispatch) THEN
			// continue processing
		ELSE 
			lb_ContinueProcess = FALSE
		END IF
	END IF
END IF

IF lb_ContinueProcess = TRUE THEN
	SetNull(ld_nulldate)
	ll_EntityMax = upperbound(lnva_entities)
// We will use this array of entity ids (ll_entityIds[]) to retrieve
//  the entity & itinerary info and to place
// an upperboundary (ll_Rowcount) on the .find used to get the employee Id
// (which is then used to get the correct itinerary obj.)
	FOR ll_Count = 1 TO ll_EntityMax
		lla_EntityIds[ll_Count] = lnva_Entities[ll_Count].of_getId()
	NEXT
// holds the link between entity id and employee
	lds_EntityItinInfo =  CREATE n_ds
	lds_EntityItinInfo.DataObject = "d_entitylist"
	lds_EntityItinInfo.SetTransObject(SQLCA)
	IF Upperbound(lla_EntityIDs) > 0 THEN
		ll_Rowcount= lds_EntityItinInfo.Retrieve(lla_EntityIds)
	ELSE
		lb_ContinueProcess = FALSE
	END IF
END IF
IF lb_ContinueProcess = TRUE THEN	
	
	if ll_EntityMax > 1 then
		openwithparm(lw_progress,this )
	end if
	
	ib_interrupt = FALSE

	FOR ll_Count =  1 TO ll_EntityMax
		
		FOR n = 1 to 10
		GarbageCollect( )
			Yield()
			IF ib_interrupt THEN // set in lw_progress
				EXIT
			END IF
		next
		
		IF ib_interrupt THEN 
			ib_interrupt = FALSE
			EXIT
		END IF
		
		if isvalid(lw_progress) then	
			lw_progress.wf_updateprogress(This.wf_GetEntityName( lla_Entityids[ll_Count] ) )
		end if
		
		//	lnv_Dispatch.ClearOFRErrors()
		ll_TotalNbrAmountOwed = 0 // this is total for this entity
		ll_ErrMsgCounter = 1	 
		ll_Entityid = lla_Entityids[ll_Count]
		IF IsNull(ll_Entityid) OR (ll_EntityId = 0 ) THEN
			// place entity id and msg into datastore  
			ll_Row = lds_EntityInfo.InsertRow(0)
			IF ll_Row > 0 THEN  
				lds_EntityInfo.object.entityid[ll_Row] = ll_EntityId
				lds_EntityInfo.object.msgnbr[ll_Row] =ll_ErrMsgCounter
				lds_EntityInfo.object.severity[ll_Row] = 10201
				lds_EntityInfo.object.msg[ll_Row]  = "This entity must be" + &
				" corrected before it can be settled in autogen."
				ll_ErrMsgCounter ++			
			END IF 
			CONTINUE
		ELSE
			ll_RowNbr= lds_EntityItinInfo.find(" entity_id = " + string(ll_entityId),1, ll_RowCount)
			IF ll_RowNbr > 0 THEN
				ll_EmployeeId=lds_EntityItinInfo.object.entity_fkemployee[ll_RowNbr]
				IF (IsNull(ll_EmployeeId)) OR (ll_EmployeeId < 1) THEN  
					ll_Row = lds_EntityInfo.InsertRow(0)
					IF ll_Row > 0 THEN  
						lds_EntityInfo.object.entityid[ll_Row] = ll_EntityId
						lds_EntityInfo.object.msgnbr[ll_Row] =ll_ErrMsgCounter
						lds_EntityInfo.object.severity[ll_Row] = 10205
						lds_EntityInfo.object.fkemployee[ll_Row] = ll_EmployeeID
						lds_EntityInfo.object.msg[ll_Row]  = "This employee identification" + &
						" must be corrected before this entity can be settled in autogen."
						ll_ErrMsgCounter ++							
						CONTINUE  // don't process this one - it's corrupt
					END IF
				END IF
				lnv_itinerary = lnv_Dispatch.of_GetItinerary(gc_Dispatch.ci_ItinType_Driver, &
					ll_EmployeeId, RelativeDate(ad_start, -7), ad_End)  
				IF NOT IsValid(lnv_itinerary) THEN
					ll_InvalidItinCounter ++	  // helped debugging, 	
				ELSE
					lnv_Itinerary.of_SetDiscardOptional(TRUE) 
				
					IF lb_RouteTypeDefined THEN
						lnv_itinerary.of_SetRouteType(li_RouteType)
					END IF
					// Do this set range for the special case of unassigned amounts with a 0 
					//  transaction - this guarantees that the dates show up correctly
					//  on the w_transaction window in the transaction tab.
					lstr_Parm.is_Label = "StartDate"
					lstr_Parm.ia_Value = ad_start
					lnv_Range.of_Add_Parm(lstr_Parm)
	
					lstr_Parm.is_Label = "EndDate"
					lstr_Parm.ia_Value = ad_end
					lnv_Range.of_Add_Parm(lstr_Parm)
			
					lstr_Parm.is_Label = "ItinType"
					lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_Driver
					lnv_Range.of_Add_Parm(lstr_Parm)
			
					lstr_Parm.is_Label = "ItinId"
					lstr_Parm.ia_Value = lnv_itinerary.of_GetItinId()
					lnv_Range.of_Add_Parm(lstr_Parm)
	
					lnv_itinerary.of_SetRange(lnv_Range)
					
				END IF
			END IF // ll_RowNbr > 0
		END IF
		// set the defaultentityid in the  local transactionmanager 
		// to make it easier to reuse code in later modules.
		inv_transactionmanager.of_setdefaultentityid(ll_EntityId)
		// Set the default category too. (It's needed to create new amount oweds)
		inv_Transactionmanager.of_setdefaultCategory(n_cst_constants.ci_Category_Payables)	
		inv_TransactionManager.of_loadopenTransactions ( ll_EntityId )			
	
		IF IsValid(lds_PeriodicUpdates) THEN
		ELSE
			lds_PeriodicUpdates = CREATE n_ds
			lds_PeriodicUpdates.DataObject = "d_PeriodicSubset"
			lds_PeriodicUpdates.Reset()
		END IF
		// Call the generation code.  Pass local transaction manager,
		//  the current entity, one corresponding valid itinerary, one transaction,
		//  empty anva_amounttemplate, dispatch, and lds_PeriodicUpdates)
		lnv_payable = CREATE n_cst_bso_payable
		lnv_payable.ClearOFRErrors()
		lb_NoFatalErrors = TRUE
		
		IF lb_TransactionsPassedIn = TRUE THEN   
			// we've done the set up earlier in code; we placed the arg into the local array.
			if is_request = cs_request_incremental then
				ld_testdate = lnva_transaction[ll_Count].of_GetStartDate()
				if isnull(ld_testdate) then
					lnva_transaction[ll_Count].of_SetStartDate(ad_start)
				end if
				lnva_transaction[ll_Count].of_SetEndDate(ad_end)
			end if
		ELSE
			// Create a new transaction here	if we aren't doing repairs.
			IF IsValid(lnv_TRansaction) THEN
				lnv_TRansaction = lnv_NullTransaction
			END IF
			lnv_Transaction = inv_Transactionmanager.of_newTransaction()
			IF IsValid ( lnv_transaction ) THEN
			
				ll_Return = lnv_transaction.of_setBatchNumber(ls_batchNumber)
				if is_request = cs_request_incremental then
					ld_testdate = lnv_Transaction.of_GetStartDate()
					if isnull(ld_testdate) then
						lnv_Transaction.of_SetStartDate(ad_start)
					end if
				else
					lnv_Transaction.of_SetStartDate(ad_start)					
				end if
				lnv_Transaction.of_SetEndDate(ad_end)
				lnva_TRansaction[ll_Count] = lnv_Transaction
			ELSE
				MessageBox ( "Severe Error" , "Transaction object could not be created. Contact Profit Tools." )
				lb_NoFatalErrors = FALSE
			END IF
		END IF	// ok, we have a transaction 
		
		if ib_PeriodicOnly AND lb_NoFatalErrors then
			//pass in the templates
			if this.wf_getperiodictemplates(inv_transactionmanager, lnva_AmountTemplate) > 0 then
				//ok
			else
				//on to next entity
				continue
			end if
		END IF
		
		IF lb_NoFatalErrors THEN
			ll_NbrAmountOweds = 0
			ll_Return = lnv_payable.of_Generate(lnva_transaction[ll_Count], lnva_amounttemplate, lnv_itinerary, &
			lnva_entities[ll_Count], inv_transactionmanager, lnv_dispatch, ll_NbrAmountOweds, lds_PeriodicUpdates)
			ll_TotalNbrAmountOwed = ll_NbrAmountOweds + ll_TotalNbrAmountOwed
		END IF
		
		//
		//lb_NoFatalErrors = TRUE  // We don't know this yet - but set flag anyway
		// Were there any severe errors in this transaction? (Any error > 10,000 is a severe error.)
		// If so, delete the transaction and all the amount oweds associated with this entity.
		lnv_payable.GetOFRErrors(lnva_Error)
		ll_MaxErrors = lnv_payable.GetErrorCount()
	
		FOR ll_Index = 1 to ll_MaxErrors
			// get the first char of the error.  Is it a 1? If so, this is a severe error.
			ls_ErrMsg = trim(lnva_Error[ll_index].GetErrorMessage())
			IF Dec(char(ls_ErrMsg)) >= 1 and ll_NbrAmountOweds = 0 THEN
				lb_NoFatalErrors = FALSE
			END IF  // no severe errors
		
			// Keep all of the errors for this entity and place them into the 
			// lds_EntityInfo object to be displayed if the user wishes to see
			// them later.  At this point I have one trimmed, error msg. 
			ll_ErrMsgSize = len(ls_ErrMsg)
			ll_Row = lds_EntityInfo.InsertRow(0)	
//			IF ll_Row > 0 THEN
//				ls_entityname = This.wf_GetEntityName( lnva_Entities[ll_Count].of_getID( ) ) 
//				lds_EntityInfo.object.entityname[ll_Row] = ls_entityname
//				lds_EntityInfo.object.entityid[ll_Row] = ll_EntityId
//				lds_EntityInfo.object.msgnbr[ll_Row] =ll_ErrMsgCounter
//				lds_EntityInfo.object.severity[ll_Row] = mid(ls_ErrMsg, 1, 5)
//				lds_EntityInfo.object.fkemployee[ll_Row] = ll_EmployeeID
//				lds_EntityInfo.object.msg[ll_Row]  = mid(ls_ErrMsg, 7, ll_ErrMsgSize)
//				ll_ErrMsgCounter ++							
//			END IF 

//	MOST of the errors passed around will have a XXXXX| prefix. but with the above code
// if an object adds an ofr error with out one, the first 6 chars are striped. So I will
// use some highly advanced programming techniques to determine if there is a prefix and
// strip it out if there is.

			IF ll_Row > 0 THEN
				li_PipePos = Pos ( ls_ErrMsg , '|' )
				ls_entityname = This.wf_GetEntityName( lnva_Entities[ll_Count].of_getID( ) ) 
				lds_EntityInfo.object.entityname[ll_Row] = ls_entityname
				lds_EntityInfo.object.entityid[ll_Row] = ll_EntityId
				lds_EntityInfo.object.msgnbr[ll_Row] =ll_ErrMsgCounter
				IF li_PipePos > 0 THEN
					lds_EntityInfo.object.severity[ll_Row] = mid(ls_ErrMsg, 1, li_PipePos - 1 )
				END IF
				lds_EntityInfo.object.fkemployee[ll_Row] = ll_EmployeeID
				lds_EntityInfo.object.msg[ll_Row]  = mid(ls_ErrMsg, li_PipePos + 1 , ll_ErrMsgSize)
				ll_ErrMsgCounter ++							
			END IF 




		NEXT		// End of looping thru all errors for this entity
		
		IF lb_NoFatalErrors = TRUE THEN
			// Were there any periodic amountoweds?  
			// If so, update the amount template(s) for that entity.
			ll_UpdateMax = lds_PeriodicUpdates.RowCount()
			// Is is possible for me to have only an id here, not really anything
			// else - preset runningcount to neg value as way of notifying me?
			FOR ll_Index = 1 to ll_UpdateMax
				lla_id[1] = lds_PeriodicUpdates.object.id[ll_Index]
				// get amount template for this amount template id. Update it.  
				//  Existing method requires arrays - but I want to do them 
				// singly.  There are other ways - but this is easy to maintain
				// PAT = Periodic Amount Template
				ll_Return = inv_Transactionmanager.of_getamounttemplate(lla_id, lnva_PAT) 							
				ll_Return = lnva_PAT[1].of_SetLastDate(lds_PeriodicUpdates.object.lastdate[ll_Index])
				ll_Return = lnva_PAT[1].of_SetLastAmount(lds_PeriodicUpdates.object.lastamount[ll_Index])
				ll_Return = lnva_PAT[1].of_SetRunningTotal(lds_PeriodicUpdates.object.RunningTotal[ll_Index]	)			
				ll_Return = lnva_PAT[1].of_SetRunningCount(lds_PeriodicUpdates.object.RunningCount[ll_Index])	
				ld_first = lnva_Pat[1].of_GetFirstDAte()
				IF IsNull(ld_first) THEN
					ll_Return = lnva_PAT[1].of_SetFirstDate(lds_PeriodicUpdates.object.Firstdate[ll_Index])
				END IF
				destroy lnva_pat[1]
			NEXT  // end of loop thru periodic templates	
			lds_PeriodicUpdates.Reset()
		END IF  // No Fatal Errors
		
		IF IsValid(lnv_itinerary) THEN
			DESTROY lnv_itinerary
		END IF
	//	IF ll_TotalNbrAmountOwed = 0 THEN
			if ib_PeriodicOnly then 
				//no failure
			else
				if ll_TotalNbrAmountOwed = 0 then
					IF IsValid (lnva_Transaction[ll_Count]) THEN					
						ll_Return = lnva_Transaction[ll_Count].of_SetStatus(appeon_constant.ci_Status_Failed)					
					END IF
				else
					IF IsValid (lnva_Transaction[ll_Count]) THEN					
						ll_Return = lnva_Transaction[ll_Count].of_SetStatus(appeon_constant.ci_Status_Open)					
					END IF				
				END IF
			end if
	//	ELSE
			ll_GrandTotalNbrAmountOwed = ll_GrandTotalNbrAMountOwed + ll_TotalNbrAmountOwed
	//	END IF
		
		IF IsValid(lnv_payable) THEN
			DESTROY lnv_payable
		END IF
	
	GarbageCollect( )
	
	NEXT  // go to next entity (For ll_Count = 1 TO ll_EntityMax)

	if isvalid(lw_progress) then	
		close(lw_progress)
	end if

END IF
// update display 
if upperbound(lnva_Transaction) > 0 then
	tab_1.tabpage_1.dw_1.Event ue_updateTransaction(lnva_Transaction)
	if isvalid(lnva_transaction[1]) then
		this.wf_settabpageheader(lnva_transaction[1].of_GetStartDate(), lnva_transaction[1].of_GetEndDate())
	end if
end if
// save to file

IF IsValid(lds_EntityInfo) THEN
	If lds_EntityInfo.RowCount() > 0 Then 	//	RDT 022803 
		ll_Return= lds_EntityInfo.SaveAs(ls_FullErrorName, TEXT!, FALSE /* no column headers */)
		
		// populate file list and select the first file 
		uo_errorlog.of_setfiltername(ls_batchnumber)
		uo_errorlog.of_setpath( ls_ErrorPathName )
		uo_errorlog.of_LoadfileList()
		uo_errorlog.of_SelectFile(ls_errorfile)

	End If											//	RDT 022803 
	DESTROY lds_EntityInfo

END IF

// destroy anything else, save the dispatch object, and the anva_templates! 

IF IsValid(lds_entityItinInfo) THEN
	DESTROY lds_entityItinInfo
END IF

IF IsValid(lds_PeriodicUpdates) THEN
	DESTROY lds_PeriodicUpdates
END IF

ll_count = upperbound(lnva_AmountTemplate)
for ll_index = 1 to ll_count
	if isvalid(lnva_AmountTemplate[ll_index]) then
		destroy lnva_AmountTemplate[ll_index]
	end if
next

//not sure if these have been updated yet
//ll_count = upperbound(lnva_PAT)
//for ll_index = 1 to ll_count
//	if isvalid(lnva_PAT[ll_index]) then
//		destroy lnva_PAT[ll_index]
//	end if
//next

IF IsValid(lnv_Dispatch) THEN 
	destroy lnv_dispatch
end if

IF lb_ContinueProcess = FALSE THEN
	ll_Return = -1
ELSE
	ll_Return = ll_GrandTotalNbrAmountOwed
END IF

Return ll_Return
end function

private function boolean wf_doesbatchnameexist (string as_batch);Int	li_Count

Select Count ( "id" ) 
INTO :li_Count
FROM "Transaction"
WHERE "Batchnumber" = :as_batch;
Commit;

RETURN li_Count > 0


end function

private function integer wf_validatedivisionselection (long al_division);
INT	li_Return


li_Return = 1 // selection OK

IF gnv_app.of_Getprivsmanager( ).of_Useadvancedprivs( ) THEN
	IF al_division > 0 THEN

		IF gnv_app.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( appeon_constant.cs_SettleDrivers, al_division ) <> appeon_constant.ci_True THEN
			li_Return = -1
			MessageBox ("Settle Drivers for Division" , "You do not have rights to settle drivers for the selected divsion." )	
		END IF
		
	ELSE
		
		MessageBox ( "Settle Drivers" , "You must select a division to settle." )
		li_Return = -1
		
	END IF
	
END IF



RETURN li_Return

		
		
end function

private function integer wf_validatedivsionsinbatch ();Int	li_Return = 1
Long	ll_Count
Long	lla_Divisions[]
Long	i

n_cst_AnyArraySrv	lnv_Array

IF gnv_app.of_Getprivsmanager( ).of_useadvancedprivs( ) THEN

	ll_Count = tab_1.tabpage_1.dw_1.RowCount ( )
	
	FOR i = 1 TO ll_Count 
		
		lla_Divisions[i] =  tab_1.tabpage_1.dw_1.object.division[i]
			
	NEXT
		
	lnv_Array.of_Getshrinked( lla_Divisions, TRUE , TRUE )
	
	ll_Count = UpperBound ( lla_Divisions )
	
	FOR i = 1 TO ll_Count
		
		IF gnv_app.of_Getprivsmanager( ).of_Getuserpermissionfromfn( appeon_constant.cs_SettleDrivers, lla_Divisions[i] ) <> appeon_constant.ci_True THEN
			li_Return = -1
			EXIT
		END IF
			
	NEXT
END IF

IF li_Return = -1 THEN
	
	MessageBox ( "Settle Drivers" , "The batch you have selected has drivers in it that you are not authorized to modify.~r~nYour request has been cancelled." )
	
END IF

RETURN li_Return


end function

event open;call super::open;String ls_ErrorPathname
Long 	 ll_return

//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 

ib_DisableCloseQuery = TRUE 

IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Settlements, "E" ) < 0 THEN
	close (this)
	return
END IF

gf_Mask_Menu ( m_sheets )
This.wf_CreateToolmenu ( )
of_SetResize(TRUE)

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_resize.of_SetMinSize(1300, 400)
inv_Resize.of_Register ( dw_errorlog, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( tab_1, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( uo_errorlog, 'FixedToRight' )
inv_resize.of_Register (gb_error, 'FixedToRight')
inv_resize.of_Register (cbx_errorlog, 'FixedToRight')
inv_resize.of_Register (st_select, 'FixedToRight')


// populate file list and select the first file 
//ll_Return = this.wf_GetErrorLogPath(ls_ErrorPathname) 
//IF IsNull(ls_ErrorPathname) OR ll_Return < 1 THEN
//	// do nothing 
//ELSE
//	uo_errorlog.of_setpath( ls_ErrorPathName )
//	uo_errorlog.of_LoadfileList()
//	uo_errorlog.of_SelectFile(1)
//End IF
end event

on w_settlementbatchmanager.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.gb_includedshipmenttypes=create gb_includedshipmenttypes
this.rb_errorlog=create rb_errorlog
this.rb_shiptype=create rb_shiptype
this.dw_division=create dw_division
this.st_2=create st_2
this.uo_1=create uo_1
this.st_1=create st_1
this.gb_error=create gb_error
this.gb_selection=create gb_selection
this.cb_find=create cb_find
this.cbx_failed=create cbx_failed
this.uo_errorlog=create uo_errorlog
this.cbx_errorlog=create cbx_errorlog
this.st_select=create st_select
this.ddlb_1=create ddlb_1
this.cb_print=create cb_print
this.cb_export=create cb_export
this.st_printing=create st_printing
this.tab_1=create tab_1
this.dw_errorlog=create dw_errorlog
this.cb_detail=create cb_detail
this.cb_close=create cb_close
this.cb_1=create cb_1
this.dw_includedshipmenttypes=create dw_includedshipmenttypes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_includedshipmenttypes
this.Control[iCurrent+2]=this.rb_errorlog
this.Control[iCurrent+3]=this.rb_shiptype
this.Control[iCurrent+4]=this.dw_division
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.gb_error
this.Control[iCurrent+9]=this.gb_selection
this.Control[iCurrent+10]=this.cb_find
this.Control[iCurrent+11]=this.cbx_failed
this.Control[iCurrent+12]=this.uo_errorlog
this.Control[iCurrent+13]=this.cbx_errorlog
this.Control[iCurrent+14]=this.st_select
this.Control[iCurrent+15]=this.ddlb_1
this.Control[iCurrent+16]=this.cb_print
this.Control[iCurrent+17]=this.cb_export
this.Control[iCurrent+18]=this.st_printing
this.Control[iCurrent+19]=this.tab_1
this.Control[iCurrent+20]=this.dw_errorlog
this.Control[iCurrent+21]=this.cb_detail
this.Control[iCurrent+22]=this.cb_close
this.Control[iCurrent+23]=this.cb_1
this.Control[iCurrent+24]=this.dw_includedshipmenttypes
end on

on w_settlementbatchmanager.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_includedshipmenttypes)
destroy(this.rb_errorlog)
destroy(this.rb_shiptype)
destroy(this.dw_division)
destroy(this.st_2)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.gb_error)
destroy(this.gb_selection)
destroy(this.cb_find)
destroy(this.cbx_failed)
destroy(this.uo_errorlog)
destroy(this.cbx_errorlog)
destroy(this.st_select)
destroy(this.ddlb_1)
destroy(this.cb_print)
destroy(this.cb_export)
destroy(this.st_printing)
destroy(this.tab_1)
destroy(this.dw_errorlog)
destroy(this.cb_detail)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.dw_includedshipmenttypes)
end on

event close;call super::close;ib_WindowisClosing = true

if isvalid(inv_TransactionManager) then
	destroy inv_TransactionManager
end if

if isvalid(inv_ToolMenuManager) then
	destroy inv_ToolMenuManager
end if

if isvalid(inv_dispatch) then
	destroy inv_dispatch
end if
end event

event pfc_save;//// OVERRIDING ANCESTOR SCRIPT
setpointer(hourglass!)
long		ll_return = 1, &
			ll_currentrow
String 	ls_Batch

n_cst_ofrerror anv_ofrerror[]
Int	li_ErrorCount	

ll_return = inv_TransactionManager.Event pt_Save ( ) 

IF ll_Return <> 1 THEN
	IF inv_transactionmanager.geterrorcount( ) > 0 THEN
		inv_Transactionmanager.getofrerrors( anv_ofrerror )
		
		MessageBox ( "Error Saving" ,anv_ofrerror[1].geterrormessage( ) )
	END IF
END IF 

// RDT refresh and retreieve batch 
if ib_WindowisClosing then 
	//skip
else
	If ll_return = 1 then //and ib_NewBatch Then	
		ll_currentrow = tab_1.tabpage_1.dw_1.GetRow()
		ls_Batch = uo_1.of_GetBatchNumber()
		this.setredraw(false)
		uo_1.of_Refresh()		
		uo_1.of_SetBatchNumber( ls_Batch ) 
		cb_find.TriggerEvent(Clicked!)
		tab_1.tabpage_1.dw_1.post ScrolltoRow(ll_currentrow)
		tab_1.tabpage_1.dw_1.post setfocus()
		this.post setredraw(true)
	End If						
end if
setpointer(Arrow!)

return ll_return

end event

event pfc_postopen;//PowerObject lpoa_UpdateControls[ ]
//
//lpoa_UpdateControls [ 1] = tab_1.tabpage_1.dw_1
//of_SetUpdateObjects ( lpoa_UpdateControls )

ids_drivers_batched = create n_ds
ids_drivers_batched.dataobject=cs_oldbatch_cache 
ids_drivers_batched.SetTransObject(SQLCA)

ids_drivers_notbatched = create n_ds
ids_drivers_notbatched.dataobject=cs_newbatch_cache 
ids_drivers_notbatched.SetTransObject(SQLCA)

IF IsValid(inv_TransactionManager) THEN
	DESTROY inv_TransactionManager
END IF
		
inv_TransactionManager = CREATE n_cst_bso_TransactionManager
inv_TransactionManager.of_SetNewRequiresEntity ( TRUE )
end event

event closequery;call super::closequery;Integer	li_Return = 0
Boolean 	lb_Continue = TRUE

ib_WindowisClosing = true

Choose Case wf_PendingUpdates() 
		Case 1
			lb_Continue = TRUE
		Case 2
			lb_Continue = TRUE
		Case 3
			ib_WindowisClosing = false
			lb_Continue = FALSE
			uo_1.of_SetBatchNumber ( is_Batch )   
			li_Return = 1 
End Choose

Return li_Return
end event

event doubleclicked;call super::doubleclicked;tab_1.tabpage_1.dw_1.Sort ( )
end event

event activate;call super::activate;//Refresh unassinged entities
This.Event ue_SetUnassigned()
end event

type gb_includedshipmenttypes from groupbox within w_settlementbatchmanager
integer x = 2203
integer y = 12
integer width = 997
integer height = 436
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Included Shipment Type"
end type

type rb_errorlog from radiobutton within w_settlementbatchmanager
integer x = 3205
integer y = 260
integer width = 343
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Error Log"
end type

event clicked;if this.checked then
	gb_error.visible = true
	uo_Errorlog.visible = true
	cbx_errorlog.visible = true
	st_Select.visible = true
	
	this.bringtotop = true
	rb_shiptype.bringtotop = true
	
	
	dw_includedshipmenttypes.visible = false
	gb_includedshipmenttypes.visible = false
	
else
	dw_includedshipmenttypes.visible = true
	gb_includedshipmenttypes.visible = true

	gb_error.visible = false
	uo_Errorlog.visible = false
	cbx_errorlog.visible = false
	st_Select.visible = false
	
end if
end event

event constructor;if gnv_App.of_GetrestrictedView ( ) then
	this.visible = true
	this.bringtotop=true
else
	this.visible = false
	
end if

end event

type rb_shiptype from radiobutton within w_settlementbatchmanager
integer x = 3205
integer y = 348
integer width = 343
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ship Type"
end type

event clicked;if this.checked then
	dw_includedshipmenttypes.visible = true
	gb_includedshipmenttypes.visible = true
	dw_includedshipmenttypes.bringtotop = true

	gb_error.visible = false
	uo_Errorlog.visible = false
	cbx_errorlog.visible = false
	st_Select.visible = false
	
else
	gb_error.visible = true
	uo_Errorlog.visible = true
	cbx_errorlog.visible = true
	st_Select.visible = true
	
	
	dw_includedshipmenttypes.visible = false
	gb_includedshipmenttypes.visible = false
	
end if
end event

event constructor;if gnv_App.of_GetrestrictedView ( ) then
	this.visible = true
	this.bringtotop=true
	this.checked = true
	this.event clicked()
else
	this.visible = false
	
end if

end event

type dw_division from u_dw_division within w_settlementbatchmanager
integer x = 1394
integer y = 72
integer width = 754
integer height = 96
integer taborder = 20
end type

event constructor;call super::constructor;this.settransobject(SQLCA)
this.insertrow(0)
end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case "division"
		//let the parent know that the division has changed
		parent.event ue_divisionchanged(long(data))
		
End choose

end event

type st_2 from statictext within w_settlementbatchmanager
integer x = 1138
integer y = 84
integer width = 261
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Divi&sion:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_1 from u_batchlist within w_settlementbatchmanager
integer x = 41
integer y = 64
integer width = 942
integer height = 200
integer taborder = 10
end type

on uo_1.destroy
call u_batchlist::destroy
end on

event ue_losefocus;if ib_WindowisClosing then
	return
end if

// Get driver type

Integer li_Result, &
			li_EmployeeType
			
long		ll_return			
string	ls_batch, &
			ls_ErrorPathname	
			
if ib_error then
	//skip
else
	
	li_result	= uo_1.of_GetEntityId()

	if is_batch = uo_1.of_GetBatchnumber() then
		//no data change
	else
		If IsNull( li_result ) Then 
			ddlb_1.Enabled = TRUE
			tab_1.tabpage_1.dw_1.reset()
			dw_division.post setfocus()
		
		Else
		
			li_EmployeeType = Parent.wf_GetEmployeeType(li_Result)
		
			If isNull( li_EmployeeType ) OR li_EmployeeType = -1 Then 
				// Entity is a Company
				ddlb_1.Enabled = TRUE
		
			Else
				ddlb_1.Enabled = TRUE
				ddlb_1.of_setdrivertype ( li_EmployeeType )
				ddlb_1.SelectItem ( li_EmployeeType + 1 )   // select item in ddlb
				ddlb_1.Enabled = False
				parent.wf_findbatch()
//				cb_find. post setfocus()
				
			End If
			
		End If
		ls_batch = uo_1.of_GetBatchnumber()
		if len(trim(ls_batch)) > 0 then
			// populate file list and select the first file 
			ll_Return = parent.wf_GetErrorLogPath(ls_ErrorPathname) 
			IF IsNull(ls_ErrorPathname) OR ll_Return < 1 THEN
				// do nothing 
			ELSE
				uo_errorlog.of_setfiltername(ls_batch)
				uo_errorlog.of_setpath( ls_ErrorPathName )
				uo_errorlog.of_LoadfileList()
				uo_errorlog.of_SelectFile(1)
			End IF
		end if
	end if
end if
end event

type st_1 from statictext within w_settlementbatchmanager
integer x = 1083
integer y = 180
integer width = 311
integer height = 64
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
string text = "Driver Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_error from groupbox within w_settlementbatchmanager
integer x = 2199
integer y = 8
integer width = 1358
integer height = 436
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Error Log"
end type

type gb_selection from groupbox within w_settlementbatchmanager
integer x = 9
integer y = 12
integer width = 2167
integer height = 436
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Batch Selection"
end type

type cb_find from commandbutton within w_settlementbatchmanager
integer x = 1966
integer y = 176
integer width = 169
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Find"
end type

event clicked;Parent.wf_FindBatch()


end event

type cbx_failed from checkbox within w_settlementbatchmanager
integer x = 1312
integer y = 332
integer width = 823
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
string text = "&Select failed transactions"
end type

event clicked;long	ll_row, &
		ll_rowcount
		
ll_rowcount = tab_1.tabpage_1.dw_1.rowcount()

if this.text = '&Select failed transactions' then
	
	//first deselect all rows
	tab_1.tabpage_1.dw_1.SelectRow(0, False)
	
	for ll_row = 1 to ll_rowcount
		if tab_1.tabpage_1.dw_1.find('transaction_status = ' + string(appeon_constant.ci_status_failed),ll_row, ll_row) > 0 then
			tab_1.tabpage_1.dw_1.SelectRow(ll_row, True)
		end if
	next
	
	this.text = 'De&select failed transactions'
	
else
	
	for ll_row = 1 to ll_rowcount
		if tab_1.tabpage_1.dw_1.find('transaction_status = ' + string(appeon_constant.ci_status_failed),ll_row, ll_row) > 0 then
			tab_1.tabpage_1.dw_1.SelectRow(ll_row, False)
		end if
	next
	this.text = '&Select failed transactions'
	
end if
	
end event

type uo_errorlog from u_cst_filedirectory within w_settlementbatchmanager
integer x = 2240
integer y = 136
integer height = 120
boolean bringtotop = true
end type

on uo_errorlog.destroy
call u_cst_filedirectory::destroy
end on

event ue_selectionchanged;if cbx_errorlog.checked then
	cbx_errorlog.triggerevent(clicked!)
end if
end event

type cbx_errorlog from checkbox within w_settlementbatchmanager
integer x = 2254
integer y = 268
integer width = 544
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
string text = "Display &error log  "
end type

event clicked;long		ll_return=1
string	ls_file, &
			ls_messagetitle = "Open error log"

if this.checked then
	if Parent.wf_importerrorlog() > 0 then
//		tab_1.tabpage_1.dw_1.visible=false
		dw_errorlog.visible=true
	end if
else
	dw_errorlog.visible=false
//	tab_1.tabpage_1.dw_1.visible=true
	
end if
end event

type st_select from statictext within w_settlementbatchmanager
integer x = 2245
integer y = 84
integer width = 251
integer height = 68
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
string text = "Select file"
boolean focusrectangle = false
end type

type ddlb_1 from u_cst_drivertype_ddlb within w_settlementbatchmanager
integer x = 1408
integer y = 176
integer width = 498
integer taborder = 30
boolean bringtotop = true
end type

type cb_print from commandbutton within w_settlementbatchmanager
integer x = 283
integer y = 312
integer width = 215
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Print"
end type

event clicked;Parent.Event ue_print ()
end event

type cb_export from commandbutton within w_settlementbatchmanager
integer x = 750
integer y = 312
integer width = 215
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "E&xport"
end type

event clicked;Parent.Event ue_Export( )
end event

type st_printing from u_st within w_settlementbatchmanager
boolean visible = false
integer x = 2135
integer y = 464
integer width = 1408
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 128
string text = "Closing Transaction 0 of 9999 "
alignment alignment = right!
end type

type tab_1 from u_tab_batchmanager within w_settlementbatchmanager
integer x = 5
integer y = 460
integer width = 3538
integer height = 1372
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

event ue_statuschanged;long		ll_transaction, &
			ll_status

n_cst_beo_transaction	lnv_transaction

ll_transaction = tab_1.tabpage_1.dw_1.object.transaction_id[al_row]
if isnull(ll_transaction) or ll_transaction = 0 then
	//don't do anything
else
	inv_TransactionManager.of_GetTransaction(ll_transaction, lnv_transaction)
	if isvalid(lnv_Transaction) then
		ll_status = tab_1.tabpage_1.dw_1.object.transaction_status[al_row]
		lnv_transaction.of_SetStatus(ll_status)

	end if
end if


end event

event ue_gettransactionmanager;return inv_transactionmanager
end event

event ue_entitychanged;call super::ue_entitychanged;parent.event ue_entitychanged(anv_transaction)
end event

type dw_errorlog from u_dw within w_settlementbatchmanager
boolean visible = false
integer x = 64
integer y = 1096
integer width = 3419
integer height = 688
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_batcherrorlog"
boolean hscrollbar = true
end type

type cb_detail from commandbutton within w_settlementbatchmanager
integer x = 50
integer y = 312
integer width = 215
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Detail"
end type

event clicked;Parent.Event ue_BatchDetail( )
end event

type cb_close from commandbutton within w_settlementbatchmanager
integer x = 517
integer y = 312
integer width = 233
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cl&ose"
end type

event clicked;wf_CloseBatch ( )

end event

type cb_1 from commandbutton within w_settlementbatchmanager
integer x = 983
integer y = 312
integer width = 265
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Refresh"
end type

event clicked;wf_Findbatch( )

IF IsValid(inv_TransactionManager) THEN
	DESTROY inv_TransactionManager
END IF
		
inv_TransactionManager = CREATE n_cst_bso_TransactionManager
inv_TransactionManager.of_SetNewRequiresEntity ( TRUE )


end event

type dw_includedshipmenttypes from u_dw_shiptype_amounts within w_settlementbatchmanager
integer x = 2231
integer y = 72
integer width = 933
integer height = 360
integer taborder = 0
boolean bringtotop = true
end type

event constructor;call super::constructor;n_cst_Presentation_Shipment	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

this.of_loadshiptypes()
ib_rmbmenu = FALSE


end event

