$PBExportHeader$w_transactionmanager.srw
$PBExportComments$TransactionManager (Window from PBL map PTSetl) //@(*)[79252215|1558]
forward
global type w_transactionmanager from w_sheet
end type
type cb_interactiverefresh from commandbutton within w_transactionmanager
end type
type dw_payable from u_dw_amountowedlist within w_transactionmanager
end type
type st_printing from u_st within w_transactionmanager
end type
type cb_accept from commandbutton within w_transactionmanager
end type
type cb_reject from commandbutton within w_transactionmanager
end type
type gb_amount from groupbox within w_transactionmanager
end type
type cb_generate from commandbutton within w_transactionmanager
end type
type uo_events from u_event_bracketing within w_transactionmanager
end type
type uo_template_selection from u_template_selection within w_transactionmanager
end type
type tab_transactionmanager from u_tab_transactionmanager within w_transactionmanager
end type
type tab_transactionmanager from u_tab_transactionmanager within w_transactionmanager
end type
type dw_1 from datawindow within w_transactionmanager
end type
type cb_toggle from commandbutton within w_transactionmanager
end type
end forward

global type w_transactionmanager from w_sheet
integer x = 14
integer y = 64
integer width = 3643
integer height = 2184
string title = "Transaction Manager"
string menuname = "m_sheets"
long backcolor = 12632256
event ue_open ( )
event ue_assign ( )
event ue_unassign ( )
event ue_new ( )
event ue_reset ( )
event type integer ue_autoassign ( )
event ue_exportbatch ( )
event ue_showamounts ( long ala_event[] )
event ue_hideamounts ( )
event ue_eventchanged ( long ala_event[] )
event ue_focus ( string as_what )
cb_interactiverefresh cb_interactiverefresh
dw_payable dw_payable
st_printing st_printing
cb_accept cb_accept
cb_reject cb_reject
gb_amount gb_amount
cb_generate cb_generate
uo_events uo_events
uo_template_selection uo_template_selection
tab_transactionmanager tab_transactionmanager
dw_1 dw_1
cb_toggle cb_toggle
end type
global w_transactionmanager w_transactionmanager

type variables
Private:
n_cst_Toolmenu_Manager  inv_ToolmenuManager
s_transaction_selection istr_transaction
n_cst_msg	inv_msg
n_cst_bso_TransactionManager inv_TransactionManager
n_cst_beo_Transaction inv_Transaction 
n_cst_bso_Dispatch	inv_Dispatch
n_cst_beo_itinerary2 	inv_Itinerary
Constant Integer ci_tabpage_transactions = 1
Constant Integer  ci_tabpage_amounts = 2
Constant Integer  ci_tabpage_unassignedamounts = 3
Integer ii_SaveTabIndex
Boolean   ib_Batchable
Boolean	ib_InteractiveLoaded
Boolean	ib_InteractiveMode
Boolean	ib_DateRangeTemplate
Boolean	ib_RefreshTab
Boolean	ib_frombatchmanager
Boolean	ib_DestroyMgr
String	is_BatchNumber
Long	il_EntityId
Long	il_ItineraryId
Long	ila_NewAmountId[]
Long	il_InteractiveTransactionid
Long	il_CurrentEvent
Integer	ii_ItineraryType
date	id_Start
date	id_End
string	is_OriginalTitle
string	isa_SaveBrackets[]
string	is_SaveFilter
n_ds	ids_PaySPlitCache

end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
private function integer wf_createtoolmenu ()
public subroutine wf_process_request (string as_request)
private function integer wf_updaterequestor (datawindow adw_target, boolean ab_updateinvisible)
protected subroutine wf_amounttemplates ()
public subroutine wf_autogeneratetransaction ()
protected function integer wf_loadtransactions (n_cst_msg anv_msg)
protected function integer wf_accepttext (integer ai_tabpage)
private subroutine wf_refresh (integer ai_tabpage)
protected function long wf_getcurrenttransactionrow (n_cst_beo_transaction anv_beo_transaction)
public function integer wf_unassignselectedbatch ()
public function integer wf_assigntobatch (string as_batchname)
public subroutine wf_closebatch ()
public function integer wf_printbatch ()
private subroutine wf_settemplateselectionfilter ()
public subroutine wf_loadcalculationdatastore (n_cst_eventblock anv_eventblock, ref datastore ads_calculation, ref n_cst_beo_event anv_event)
private function long wf_setitineraryrange (long al_start, long al_end, ref n_cst_msg anv_range)
private function integer wf_blockgeneration (boolean ab_manual)
public subroutine wf_splitamountowed ()
public subroutine wf_unassignedamountstatus ()
private function integer wf_blockmixedfilters ()
public subroutine wf_updatepaysplitcache ()
public function long wf_loadinteractivedata (boolean ab_refresh)
public function integer wf_oldtoolmenu ()
public subroutine wf_old_process_request (string as_request)
end prototypes

event ue_assign();SetPointer(HourGlass!)
n_cst_beo_AmountOwed		lnv_AmountOwed
n_cst_OFRError				lnv_Errors[]
n_cst_Privileges			lnv_Privileges
Long	lla_Rows[]
Long	ll_Count
Long	i

CHOOSE CASE tab_transactionmanager.SelectedTab
	CASE ci_tabpage_unassignedamounts
		//CONTINUE
	CASE ci_tabpage_amounts
		tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.SetFocus()
		return
		
	CASE ci_tabpage_transactions
		tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetFocus()
		IF lnv_Privileges.of_Settlements_AssignToBatch ( ) THEN
			String	ls_Title = "Batch Selection"
			String	ls_Message = "Please enter or select a batch to assign the selected transaction(s) to."
			String	ls_ButtonSet = "OKCANCEL!"
			String  	ls_DefaultBatch 
			
			IF IsValid ( inv_transactionmanager ) THEN
				IF inv_transactionmanager.of_BatchDialog ( ls_title , ls_Message, ls_ButtonSet, ls_DefaultBatch ) = 1 THEN
					IF Not isNull ( ls_DefaultBatch ) THEN // user selected a batch and wants to continue
						THIS.wf_AssignTobatch ( ls_DefaultBatch )
					ELSE  // user canceled
						
					END IF
				END IF
			END IF
		ELSE
			MessageBox( "Assignment to Batch " , "You do not have the required privileges to perform this operation." )
		END IF
		return
END CHOOSE

IF tab_TransactionManager.tabpage_UnassignedAmounts.PageCreated() = TRUE THEN
	
	
	ll_Count = tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.of_Getselectedrows( lla_Rows )
	
END IF

FOR i = 1 TO ll_Count
	
	lnv_AmountOwed = tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.inv_UILink.Getbeo( lla_Rows[i] )
	
	IF IsValid ( inv_Transaction ) AND &
		IsValid ( lnv_AmountOwed ) THEN
	
		IF lnv_AmountOwed.of_SetTransaction ( inv_Transaction ) = 1 THEN
			
		ELSE
	
			lnv_AmountOwed.GetOFRErrors ( lnv_Errors )
	
			IF IsValid ( tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.inv_UILink ) THEN
	
				tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.inv_UILink.ProcessOFRError ( lnv_Errors )
	
			END IF
			
			lnv_AmountOwed.ClearOFRErrors ( )
			EXIT
		END IF
	
	END IF
	
NEXT

tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.inv_UILink.RefreshFromBcm ( )
tab_transactionmanager.Event ue_transactionchanged ( inv_Transaction )
IF tab_TransactionManager.tabpage_UnassignedAmounts.dw_amounts.RowCount() > 0 THEN
	tab_TransactionManager.tabpage_UnassignedAmounts.dw_AmountDetail.inv_UILink.RefreshFromBcm ( )
END IF
IF tab_TransactionManager.tabpage_UnassignedAmounts.dw_amountdetail.visible THEN
	tab_TransactionManager.tabpage_UnassignedAmounts.dw_amountdetail.Hide ()
END IF


this.post wf_unassignedamountstatus()



end event

event ue_unassign();n_cst_beo_AmountOwed		lnv_AmountOwed
n_cst_OFRError				lnv_Errors[]
Long	lla_Rows[]
Long	ll_Count
Long  i

CHOOSE CASE tab_transactionmanager.SelectedTab
	CASE ci_tabpage_unassignedamounts
		tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.SetFocus()
		return
	CASE ci_tabpage_amounts
		//continue
	CASE ci_tabpage_transactions
		tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetFocus()
		THIS.wf_UnassignSelectedBatch ( )
		return
END CHOOSE

IF tab_TransactionManager.tabpage_transactionamounts.PageCreated() = TRUE THEN
	ll_Count = tab_TransactionManager.tabpage_transactionamounts.dw_Amounts.of_GetSelectedrows( lla_Rows )
	
//	lnv_AmountOwed = tab_TransactionManager.tabpage_transactionamounts.dw_Amounts.inv_UILink.GetBeo ( tab_TransactionManager.tabpage_transactionamounts.dw_Amounts.GetRow ( ) )
END IF

FOR i = 1 TO ll_Count
	lnv_AmountOwed = tab_TransactionManager.tabpage_transactionamounts.dw_Amounts.inv_UILink.Getbeo( lla_Rows[i] )
	IF IsValid ( lnv_AmountOwed ) THEN
	
		IF lnv_AmountOwed.of_Unassign ( ) = 1 THEN
	
			
		ELSE
	
			lnv_AmountOwed.GetOFRErrors ( lnv_Errors )
	
			IF IsValid ( tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.inv_UILink ) THEN
	
				tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.inv_UILink.ProcessOFRError ( lnv_Errors )
	
			END IF
	
			lnv_AmountOwed.ClearOFRErrors ( )
			EXIT
		END IF
	
	END IF
	
NEXT

tab_TransactionManager.tabpage_transactionamounts.dw_Amounts.inv_UILink.RefreshFromBcm ( )
IF IsValid ( inv_Transaction ) THEN
	tab_transactionmanager.Event ue_transactionchanged ( inv_Transaction )
END IF
IF tab_TransactionManager.tabpage_transactionamounts.dw_amounts.RowCount() > 0 THEN
	tab_TransactionManager.tabpage_transactionamounts.dw_AmountDetail.inv_UILink.RefreshFromBcm ( )
END IF
IF tab_TransactionManager.tabpage_transactionamounts.dw_amountdetail.visible THEN
	tab_TransactionManager.tabpage_transactionamounts.dw_amountdetail.Hide ()
END IF
	

this.post wf_unassignedamountstatus()


end event

event ue_new;CHOOSE CASE tab_transactionmanager.SelectedTab

CASE ci_tabpage_transactions
	tab_TransactionManager.tabpage_Transactions.dw_Transactions.Event Post pfc_AddRow ( )
	
CASE ci_tabpage_amounts
	tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.Event Post pfc_AddRow ( )

CASE Ci_tabpage_unassignedamounts
	tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.Event Post pfc_AddRow ( )

	this.post wf_unassignedamountstatus()

END CHOOSE

end event

event ue_reset;

IF tab_TransactionManager.tabpage_UnassignedAmounts.PageCreated ( ) THEN
	tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.RESET ( )
	tab_TransactionManager.tabpage_UnassignedAmounts.dw_AmountDetail.RESET ( )
END IF

IF tab_TransactionManager.tabpage_Transactions.PageCreated ( ) THEN
	tab_TransactionManager.tabpage_Transactions.dw_Transactions.RESET ( )
	tab_TransactionManager.tabpage_Transactions.dw_TransactionDetail.RESET ( )
END IF

IF tab_TransactionManager.tabpage_TransactionAmounts.PageCreated ( ) THEN
	tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.RESET ( )
	tab_TransactionManager.tabpage_TransactionAmounts.dw_AmountDetail.RESET ( )
END IF

IF dw_1.RowCount ( ) > 0 THEN
	dw_1.Reset ( )
END IF
end event

event ue_autoassign;SetPointer(HourGlass!)
integer li_Return
li_Return = -1 

CHOOSE CASE tab_transactionmanager.SelectedTab
	CASE ci_tabpage_unassignedamounts
		//CONTINUE
	CASE ci_tabpage_amounts
		tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.SetFocus()
		li_Return = 0
	CASE ci_tabpage_transactions
		tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetFocus()
		li_Return = 0
END CHOOSE

IF li_Return = -1 THEN
	IF IsValid ( inv_Transaction )THEN
	
		li_Return = inv_TransactionManager.of_AutoAssign ( inv_Transaction )
	
		IF li_Return > 0 THEN
			tab_transactionmanager.Event ue_transactionchanged ( inv_Transaction )
			
		END IF
	
	END IF
END IF

this.post wf_unassignedamountstatus()

return li_Return
end event

event ue_exportbatch;string	ls_AcctLink 

integer	li_Return
Int		li_UpdateRtn
Int		li_MBoxRtn
Int		li_SaveRtn
Int		i

Boolean  lb_Continue = TRUE
Boolean	lb_Batched
Boolean	lb_Mixed 
Boolean  lb_OpenTransactions


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


IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE THEN

	IF IsValid ( tab_TransactionManager.tabpage_Transactions.dw_Transactions ) THEN
		ll_RowCount = tab_TransactionManager.tabpage_Transactions.dw_Transactions.RowCount()
	Else
		lb_Continue = FALSE
		MessageBox ("Export Batch" , "An Error occurred while attempting to export the batch.")
	END IF
		
	IF NOT tab_transactionmanager.SelectedTab = ci_tabpage_transactions THEN
		MessageBox( "Export Batch" , "Please be on the Transaction Tab Page before exporting the batch." )
	ELSE	
						
		IF lb_continue THEN
			
			IF lnv_Privileges.of_Settlements_CreateBatch ( ) THEN
				
				IF ll_RowCount > 0 THEN
					
					IF ib_Batchable THEN // this flag is set in wf_LoadTransactions
					
						IF inv_transactionmanager.of_LoadReferencedAmounts ( ) = 1 AND &
							inv_transactionmanager.of_LoadReferencedEntities ( ) = 1   THEN
						/*********************************************/
						// check updates
			
							li_UpdateRtn = of_UpdateChecks()  
						
							CHOOSE CASE li_UpdateRtn 
									
								CASE is > 0  //There are changes pending.
						
									li_MboxRtn = MessageBox( "Export Batch", "Before you can export a batch you must save your changes. Do you want to save your changes now?", QUESTION!, YESNO! , 1)
								
									CHOOSE CASE li_MBoxRtn
										CASE 1  //Yes - Save first
											li_SaveRtn = This.Event pfc_Save( )
											lb_Continue = TRUE
											
											CHOOSE CASE li_SaveRtn
												CASE is < 0 // Save Failed
													MessageBox ( "Save Failure" , "Your batch has not be exported and processing will stop.", EXCLAMATION!)
													lb_Continue = FALSE
													
												//case 0 //no changes pending
												
											END CHOOSE
											
										CASE 2  //No - Stop processing
											lb_Continue =FALSE
										
										CASE ELSE //Unexpected return value
											lb_Continue = FALSE
											
									END CHOOSE
									
								CASE 0  //There are no changes pending.
									//Proceed with change.
									lb_Continue = TRUE
									
								CASE is < 0  //Changes are pending, but do not pass validation.
									MessageBox ( "Validation", "The information entered does not pass validation and "  + &
																"must be corrected before changes can be saved.")	
									lb_Continue = FALSE
									
								CASE 0 // no changes found
									
							END CHOOSE
									
								
						/*********************************************/	
							////////////////////////////////////// Do we want to put this somewhere????
							IF lb_Continue THEN
		
								IF lnv_Settings.of_GetAcctLink ( ls_AcctLink ) = 1 THEN
									lnv_cst_AcctLink = CREATE USING ls_AcctLink
								ELSE // error
									messageBox("Accounting" , "An error occurred while attempting to determine "+&
									+"what accounting software is being used. Please check your System Settings.")
								END IF
								
								//load selected batches into the message object
								//transactions need to be grouped by batch number and 
								//then passed to the aactlink
								
								
								IF IsValid (lnv_cst_AcctLink) THEN
									
									// load all the transaction that belong to the batch number that was loaded... 
									// don't process any trans. that had their batch number changed
									FOR ll_Index = 1 TO ll_RowCount
										lnv_CurrentTransaction = tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_index )
										IF IsValid ( lnv_CurrentTransaction	) THEN
											IF UPPER ( lnv_CurrentTransaction.of_GetBatchNumber ( ) ) = UPPER ( is_batchnumber ) THEN
												lnva_transaction [ UpperBound ( lnva_transaction ) + 1 ] = lnv_CurrentTransaction
											END IF
										END IF
									NEXT
									
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
										lstr_Parm.is_Label = "TRANSACTION_BEO_ARRAY"
										lstr_Parm.ia_Value = lnva_transaction
										lnv_msg.of_Add_Parm ( lstr_Parm ) 
										
										li_Return = lnv_cst_acctlink.of_BatchCreate ( lnv_Msg ) 
										IF isValid ( lnv_cst_acctlink ) THEN
											destroy lnv_cst_acctlink
										END IF
										
										//after successfully creating files,
										//update the batch columns
										
										IF li_Return = 1 THEN  // batch created successfully so update the status
											//update transaction batch columns
											ll_TransCount = UpperBound ( lnva_transaction )
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
											//
											THIS.wf_Refresh ( ci_tabpage_transactions ) 
										ELSE
											// nothing because batch create provides all error messages!
										END IF
										
										
									END IF // lb_Continue - re-batch
									
		//						ELSE
		//							// ACCTLINK ERROR
		//							MessageBox  ("Export Batch" , "Could not load information needed to export batch.")
								END IF
								
							END IF // lb_Continue
							
						ELSE //referenced amounts
							
							// bad things are about to happen
							MessageBox  ("Export Batch" , "Could not load information needed to export batch.")
						END IF
					ELSE // not batchable
						IF MessageBox( "Export Batch" , "You must retrieve an entire batch from the Transaction Selection window in order to export a batch.~n~rDo you want to open the Transaction Selection window now?", QUESTION!, YESNO!, 1) = 1 THEN
							wf_Process_Request ("GOTO!")
						END IF
					END IF		
				ELSE // rowcount = 0 
					MessageBox( "Export Batch" , "There are no transactions to export." )
					
				END IF
			ELSE // privileges
				MessageBox( "Export Batch" , "You do not have the required privileges to perform this operation." )
			END IF
		END IF
	END IF
END IF // tab created
end event

event ue_showamounts(long ala_event[]);long	lla_amount[], &
		ll_ndx, &
		ll_count

string	ls_idlist, &
			ls_eventlist, &
			ls_filter

n_ds		lds_paysplitcache

n_cst_string	lnv_String

dw_payable.SetTransactionManager(inv_TransactionManager)

ll_count = upperbound(ala_event)

lds_paysplitcache = inv_TransactionManager.of_getpaysplitcache( true )

lnv_String.of_ArrayToString(ala_event, ',', ls_eventlist) 
ls_filter = 'eventid in (' + ls_eventlist + ')'
lds_Paysplitcache.setfilter(ls_filter)
lds_Paysplitcache.filter()

ll_count = lds_Paysplitcache.rowcount()

for ll_ndx = 1 to ll_count
	lla_amount[ll_ndx] = lds_Paysplitcache.object.amountid[ll_ndx]
next

lnv_String.of_ArrayToString(lla_amount, ',', ls_IdList)

if len(ls_idlist) > 0 then
	dw_payable.SetFilter( "amountowed_id in ( " + ls_IdList + ")" )
	dw_payable.Filter()
else
	dw_payable.SetFilter( "amountowed_id = 0" )
	dw_payable.Filter()	
end if


dw_payable.triggerevent("task_retrieve")
dw_payable.Visible = TRUE



end event

event ue_hideamounts();
this.setredraw(false)
dw_payable.SetFilter( "" )
dw_payable.Filter()

if dw_payable.rowcount() > 0 then
	dw_payable.triggerevent("task_retrieve")
end if

dw_payable.Visible = FALSE

this.Setredraw(true)
end event

event ue_eventchanged(long ala_event[]);if upperbound(ala_event) > 0 then
	if ala_event[1] > 0 then
		il_CurrentEvent = ala_event[1]
	end if
end if

if dw_payable.visible = true then

	this.event ue_showamounts(ala_event)
	
end if
end event

event ue_focus(string as_what);choose case as_what
	case 'AVAILABLE TEMPLATE'
		uo_events.event ue_setfocus(as_what)
		
end choose

end event

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null


Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>

Return 1
//@(text)--

end function

private function integer wf_createtoolmenu ();//old code
s_toolmenu lstr_toolmenu
n_cst_privileges	lnv_Privileges

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)

inv_ToolmenuManager.of_add_standard("SAVE!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "GOTO!"
lstr_toolmenu.s_toolbutton_picture = "list.bmp"
lstr_toolmenu.s_toolbutton_text = "GO TO..."
lstr_toolmenu.s_menuitem_text = "&Go To..."
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "NEW!"
lstr_toolmenu.s_toolbutton_picture = "gridnew1.bmp"
lstr_toolmenu.s_toolbutton_text = "NEW"
lstr_toolmenu.s_menuitem_text = "&New"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "DELETE!"
lstr_toolmenu.s_toolbutton_picture = "griddel1.bmp"
lstr_toolmenu.s_toolbutton_text = "DELETE"
lstr_toolmenu.s_menuitem_text = "&Delete"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "CLOSETRANSACTION!"
//lstr_toolmenu.s_toolbutton_picture = "??"
//lstr_toolmenu.s_toolbutton_text = "CLOSE TRNS."
lstr_toolmenu.s_menuitem_text = "Clos&e Transaction"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "CLOSEBATCH!"
//lstr_toolmenu.s_toolbutton_picture = "??"
//lstr_toolmenu.s_toolbutton_text = "CLOSE TRNS."
lstr_toolmenu.s_menuitem_text = "Close Ba&tch "
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "PRINTTRANSACTION!"
//lstr_toolmenu.s_toolbutton_picture = "??"
//lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
lstr_toolmenu.s_menuitem_text = "&Print Transaction"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "PRINTBATCH!"
//lstr_toolmenu.s_toolbutton_picture = "??"
//lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
lstr_toolmenu.s_menuitem_text = "P&rint Batch"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "EXPORTBATCH!"
//lstr_toolmenu.s_toolbutton_picture = "export.bmp"
//lstr_toolmenu.s_toolbutton_text = "Export Batch"
lstr_toolmenu.s_menuitem_text = "E&xport Batch"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

IF lnv_Privileges.of_HasSysAdminRights ( ) THEN
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "MARKBATCHED!"
	//lstr_toolmenu.s_toolbutton_picture = "export.bmp"
	//lstr_toolmenu.s_toolbutton_text = "Export Batch"
	lstr_toolmenu.s_menuitem_text = "Mark as &Batched"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "MARKUNBATCHED!"
	//lstr_toolmenu.s_toolbutton_picture = "export.bmp"
	//lstr_toolmenu.s_toolbutton_text = "Export Batch"
	lstr_toolmenu.s_menuitem_text = "Mar&k as Unbatched"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
END IF


inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "AUTOASSIGN!"
lstr_toolmenu.s_toolbutton_picture = "lbolt1.bmp"
lstr_toolmenu.s_toolbutton_text = "AUTOASSIGN"
lstr_toolmenu.s_menuitem_text = "Aut&o-Assign"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "ASSIGN!"
lstr_toolmenu.s_toolbutton_picture = "brokassn.bmp"
lstr_toolmenu.s_toolbutton_text = "ASSIGN"
lstr_toolmenu.s_menuitem_text = "&Assign"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "UNASSIGN!"
lstr_toolmenu.s_toolbutton_picture = "brokunas.bmp"
lstr_toolmenu.s_toolbutton_text = "UNASSIGN"
lstr_toolmenu.s_menuitem_text = "&Unassign"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "AMOUNTTEMPLATES!"
//lstr_toolmenu.s_toolbutton_picture = "??"
//lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
lstr_toolmenu.s_menuitem_text = "Pa&yables Setup"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

//don't allow this from this window, can only autogen from batchmanager
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//lstr_toolmenu.s_name = "AUTOGENERATE!"
////lstr_toolmenu.s_toolbutton_picture = "??"
////lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
//lstr_toolmenu.s_menuitem_text = "Auto-Generate Settle&ment"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "ITINERARY!"
lstr_toolmenu.s_toolbutton_picture = "itin.bmp"
lstr_toolmenu.s_toolbutton_text = "ITINERARY"
lstr_toolmenu.s_menuitem_text = "&Itinerary (for Selected Item)"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1

//end old code


//current  code
//s_toolmenu lstr_toolmenu
//n_cst_privileges	lnv_Privileges
//
//if isvalid(inv_ToolmenuManager) then return 0
//
//if ib_InteractiveMode then
////	inv_ToolmenuManager = create n_cst_toolmenu_manager
////	inv_ToolmenuManager.of_set_parent(this)
////	
////	inv_ToolmenuManager.of_add_standard("DIVIDER!")
////	
////	inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
////	
////	lstr_toolmenu.s_name = "SAVE!"
////	lstr_toolmenu.s_menuitem_text = "&Save~tCtrl+S"
////	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
////	
////	inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)
//
//else
//	inv_ToolmenuManager = create n_cst_toolmenu_manager
//	inv_ToolmenuManager.of_set_parent(this)
//	
//	inv_ToolmenuManager.of_add_standard("SAVE!")
//	
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//	lstr_toolmenu.s_name = "GOTO!"
//	lstr_toolmenu.s_toolbutton_picture = "list.bmp"
//	lstr_toolmenu.s_toolbutton_text = "GO TO..."
//	lstr_toolmenu.s_menuitem_text = "&Go To..."
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//	inv_ToolmenuManager.of_add_standard("DIVIDER!")
//	
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//	lstr_toolmenu.s_name = "NEW!"
//	lstr_toolmenu.s_toolbutton_picture = "gridnew1.bmp"
//	lstr_toolmenu.s_toolbutton_text = "NEW"
//	lstr_toolmenu.s_menuitem_text = "&New"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//	lstr_toolmenu.s_name = "DELETE!"
//	lstr_toolmenu.s_toolbutton_picture = "griddel1.bmp"
//	lstr_toolmenu.s_toolbutton_text = "DELETE"
//	lstr_toolmenu.s_menuitem_text = "&Delete"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//	inv_ToolmenuManager.of_add_standard("DIVIDER!")
//	
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//	lstr_toolmenu.s_name = "AUTOASSIGN!"
//	lstr_toolmenu.s_toolbutton_picture = "lbolt1.bmp"
//	lstr_toolmenu.s_toolbutton_text = "AUTOASSIGN"
//	lstr_toolmenu.s_menuitem_text = "Aut&o-Assign"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//	lstr_toolmenu.s_name = "ASSIGN!"
//	lstr_toolmenu.s_toolbutton_picture = "brokassn.bmp"
//	lstr_toolmenu.s_toolbutton_text = "ASSIGN"
//	lstr_toolmenu.s_menuitem_text = "&Assign"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//	lstr_toolmenu.s_name = "UNASSIGN!"
//	lstr_toolmenu.s_toolbutton_picture = "brokunas.bmp"
//	lstr_toolmenu.s_toolbutton_text = "UNASSIGN"
//	lstr_toolmenu.s_menuitem_text = "&Unassign"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//	lstr_toolmenu.s_name = "SPLITAMOUNT!"
//	lstr_toolmenu.s_menuitem_text = "Split Amoun&t"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//	inv_ToolmenuManager.of_add_standard("DIVIDER!")
//	
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//	lstr_toolmenu.s_name = "PRINTTRANSACTION!"
//	lstr_toolmenu.s_menuitem_text = "&Print Transaction"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//	lstr_toolmenu.s_name = "AMOUNTTEMPLATES!"
//	lstr_toolmenu.s_menuitem_text = "Pa&yables Setup"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//	lstr_toolmenu.s_name = "ITINERARY!"
//	lstr_toolmenu.s_toolbutton_picture = "itin.bmp"
//	lstr_toolmenu.s_toolbutton_text = "ITINERARY"
//	lstr_toolmenu.s_menuitem_text = "&Itinerary (for Selected Item)"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//	inv_ToolmenuManager.of_add_standard("DIVIDER!")
//
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//	lstr_toolmenu.s_name = "REFRESHINTERACTIVE!"
//	lstr_toolmenu.s_menuitem_text = "Re&fresh Interactive"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//
//	inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)
//	
//end if
//
//return 1
end function

public subroutine wf_process_request (string as_request);//old code
SetPointer(HourGlass!)
long 			ll_row
n_cst_Msg	lnv_msg
S_parm		lstr_Parm
n_cst_beo_Transaction	lnv_Transaction

IF ib_InteractiveMode THEN
	messagebox("Transaction Manager", "This option is not available in the interactive settlements window.")
ELSE
	CHOOSE CASE as_Request
	
	CASE "SAVE!"
		PostEvent ( "pfc_Save" )
		
	CASE "GOTO!"
		//messagebox to save current work and clear window
		//for new selection
		//open transaction selection window
		Int	li_Rtn
		Int		li_selectedTab
		Boolean	lb_Continue = TRUE
	
		
		
		S_transaction_Selection lstr_transaction_selection
		li_SelectedTab = tab_TransactionManager.selectedTab  
		
		IF THIS.wf_AcceptText ( li_SelectedTab ) <> 0 THEN 
			lb_Continue = FALSE
		END IF
		
		//	Request a lock for user
		n_cst_LicenseManager lnv_LicenseManager 
		IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Settlements, "E" ) < 0 THEN
			lb_Continue = FALSE
		END IF
		
		IF lb_Continue THEN
			lstr_Parm.is_Label = "S_TRANSACTION_SELECTION"
			lstr_Parm.ia_Value = istr_transaction
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			OpenWithParm ( w_transaction_Selection , lnv_msg )
			
			lnv_msg = message.powerobjectParm
			IF isValid ( lnv_Msg ) THEN
				IF lnv_Msg.of_Get_Parm ( "S_TRANSACTION_SELECTION", lstr_Parm ) <> 0 THEN
					lstr_Transaction_Selection = lstr_parm.ia_Value
					IF isValid ( lstr_Transaction_Selection ) THEN
						istr_transaction = lstr_Transaction_Selection
						li_Rtn = THIS.wf_LoadTransactions ( lnv_Msg )
					END IF
				END IF
			END IF
			IF li_Rtn = -1 THEN
				MessageBox("Loading Transactions" , "An error occurred while attempting to load the selected transations.")
			END IF
			
		END IF
		
	CASE "NEW!"
		//Event ue_new ( )
		PostEvent ( "ue_new" )
		
	CASE "DELETE!"
		CHOOSE CASE tab_transactionmanager.SelectedTab
		
		CASE ci_tabpage_transactions
			
			IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.RowCount ( ) > 0 THEN
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.Event Post pfc_DeleteRow ( )
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.Function Post SetFocus ( )
			END IF
			
		CASE ci_tabpage_amounts
			
			tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.of_Deleteselectedrows( )
//			IF tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.RowCount( ) > 0 THEN
//				tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.Event Post pfc_DeleteRow ( )
				tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.Function Post SetFocus ( )
//			END IF
			
		CASE ci_tabpage_unassignedamounts
			
			tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.of_Deleteselectedrows( )
//			IF tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.RowCount ( ) > 0 THEN
//				tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.Event Post pfc_DeleteRow ( )
				tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.Function Post SetFocus ( )
//			END IF
			
		END CHOOSE
	
	CASE "PRINTTRANSACTION!"
		IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE AND &
			tab_transactionmanager.SelectedTab = ci_tabpage_transactions THEN
			
			ll_row = wf_GetCurrentTransactionRow ( inv_Transaction )
			IF ll_row > 0 THEN
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetRow ( ll_row )
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.Event ue_PrintTransaction ( )
			END IF
		ELSE
			MessageBox ("Print Transaction" , "Please be sure you are on the Transactions Tab before attempting to print the transaction.")
		END IF
		
	CASE "PRINTBATCH!"
		IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE AND & 
			tab_transactionmanager.SelectedTab = ci_tabpage_transactions THEN
			
			IF ib_Batchable THEN
				IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE THEN
					wf_PrintBatch ( )
				END IF
			ELSEIF MessageBox ("Print Batch" , "You must load an entire batch from the transaction selection window before you can perform this operation.~n~rDo you want to open the transaction selection window now?",QUESTION!, YESNO! , 1) = 1 THEN
				wf_Process_Request ("GOTO!")
			END IF
		ELSE
			
			MessageBox ("Print Batch" , "Please be sure you are on the Transactions Tab before attempting to print the batch.")
		END IF
		
	CASE "CLOSETRANSACTION!"
		IF wf_AcceptText ( tab_TransactionManager.SelectedTab ) = -1 THEN
			return
		END IF
		
		IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE AND &
			 tab_transactionmanager.SelectedTab = ci_tabpage_transactions THEN
			
			ll_row = wf_GetCurrentTransactionRow ( inv_Transaction )
			IF ll_row > 0 THEN
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetRow ( ll_row )
				IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.Event ue_CloseTransaction ( ) = 1 THEN
					IF MessageBox ( "Close Transactions", "Do you want to print the transaction now?", &
						Question!, YesNo!, 1 ) = 1 THEN
						IF IsValid ( tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink ) THEN
							lnv_Transaction = tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.GetBeo ( ll_row )	
							lnv_Transaction.of_Print ( )
						END IF
					END IF
					wf_Refresh ( tab_TransactionManager.SelectedTab ) 
				END IF
			END IF
		ELSE
			MessageBox ("Close Transaction" , "Please be sure you are on the Transactions Tab before attempting to close the transaction.")
		END IF
		
		
		
	CASE "CLOSEBATCH!"
		IF wf_AcceptText ( tab_TransactionManager.SelectedTab ) = -1 THEN
			return
		END IF
		
		IF ib_Batchable THEN
			
			IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE AND &
				tab_transactionmanager.SelectedTab = ci_tabpage_transactions THEN
				wf_CloseBatch ( )
			ELSE
				MessageBox ("Close Batch" , "Please be sure you are on the Transactions Tab before attempting to close the batch.")
			END IF
			
		ELSEIF MessageBox ("Close Batch" , "You must load an entire batch from the transaction selection window before you can perform this operation. ~n~rDo you want to open the transaction selection window now?",QUESTION!, YESNO! , 1) = 1 THEN
			THIS.wf_Process_Request ( "GOTO!" )
		END IF
	
		
	CASE "ASSIGN!"
		PostEvent ( "ue_Assign" )
	
	CASE "UNASSIGN!"
		PostEvent ( "ue_Unassign" )
		
	CASE "AUTOASSIGN!"
		CHOOSE CASE this.Event ue_autoAssign ( )
		CASE -1
			messagebox ( "Auto Assign", "No amounts were assigned to the selected transaction. ", Information! )
		CASE 0
			//NOT ON THE UNASSIGNED AMOUNT TAB
		CASE ELSE
			//REFRESH and go to amounts tab if not already there
			IF tab_TransactionManager.tabpage_TransactionAmounts.PageCreated() = TRUE THEN
				tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.inv_UILink.RefreshFromBcm ( )
			END IF
			tab_TransactionManager.SelectTab ( tab_TransactionManager.tabpage_TransactionAmounts )
		END CHOOSE
	
	CASE "AMOUNTTEMPLATES!"
		This.wf_AmountTemplates ( )
	
	CASE "AUTOGENERATE!"
	//	This.wf_AutoGenerateTransaction ( )
	
	CASE "ITINERARY!"
		This.Event pfc_MessageRouter ( "ue_Itinerary" )
		
	CASE "EXPORTBATCH!"
		
		String	ls_Title = "Batch Selection"
		String	ls_Message = "Please select the batch you wish to export."
		String	ls_ButtonSet = "OKCANCEL!"
		String  	ls_DefaultBatch 
		IF IsValid ( inv_transactionmanager ) THEN
	//		CHOOSE CASE inv_transactionmanager.of_BatchDialog ( ls_title , ls_Message, ls_ButtonSet, ls_DefaultBatch ) 
	//			CASE 1 // success w/ a batch number
	//				IF Not IsNull (ls_DefaultBatch) THEN
	//				// export the batch
					
						PostEvent ( "ue_Exportbatch" )
	//				END IF
	//			CASE 0 // user canceled
	//				
	//			CASE -1 // error
	//		END CHOOSE
	//			
				
		END IF
		
	CASE "MARKBATCHED!"
		
		IF tab_TransactionManager.tabpage_Transactions.PageCreated ( ) THEN
			IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( 0 ) = 0 THEN
				// no selected row so use the current
				ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetRow ( )
				IF ll_Row > 0 THEN
					lnv_Transaction = tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
					IF IsValid ( lnv_Transaction ) THEN
						lnv_Transaction.of_SetBatched ( true )
						tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
					END IF
				END IF
				
			ELSE
				DO
					ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( ll_Row )
					lnv_Transaction	= tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
					IF IsValid ( lnv_Transaction ) THEN
						lnv_Transaction.of_SetBatched ( true )
						tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
					END IF
					//Batch Selected transaction 
				LOOP UNTIL ll_Row = 0
			END IF
			
		END IF
		
	CASE "MARKUNBATCHED!"
		IF tab_TransactionManager.tabpage_Transactions.PageCreated ( ) THEN
		
			IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( 0 ) = 0 THEN
				// no selected row so use the current
				ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetRow ( )
				IF ll_Row > 0 THEN
					lnv_Transaction = tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
					IF IsValid ( lnv_Transaction ) THEN
						lnv_Transaction.of_SetBatched ( FALSE )
						tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
					END IF
				END IF
				
			ELSE
				DO
					ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( ll_Row )
					lnv_Transaction	= tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
					IF IsValid ( lnv_Transaction ) THEN
						lnv_Transaction.of_SetBatched ( FALSE )
						tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
					END IF
					//Batch Selected transaction 
				LOOP UNTIL ll_Row = 0
			END IF
		END IF
		
	END CHOOSE
END IF	
//end old code

//current code
//
//SetPointer(HourGlass!)
//long 			ll_row
//n_cst_Msg	lnv_msg
//S_parm		lstr_Parm
//n_cst_beo_Transaction	lnv_Transaction
//
//IF ib_InteractiveMode THEN
//
//	CHOOSE CASE as_Request
//			
//		CASE "REFRESHINTERACTIVE!"
//			
//			cb_interactiverefresh.event clicked()
//			
//		CASE ELSE
//			messagebox("Transaction Manager", "This option is not available in the interactive settlements window.")
//			
//	END CHOOSE
//ELSE
//	CHOOSE CASE as_Request
//	
//	CASE "SAVE!"
//		PostEvent ( "pfc_Save" )
//		ib_interactiveloaded = false
//		
//	CASE "GOTO!"
//		//messagebox to save current work and clear window
//		//for new selection
//		//open transaction selection window
//		Int	li_Rtn
//		Int		li_selectedTab
//		Boolean	lb_Continue = TRUE
//	
//		
//		S_transaction_Selection lstr_transaction_selection
//		li_SelectedTab = tab_TransactionManager.selectedTab  
//		
//		IF THIS.wf_AcceptText ( li_SelectedTab ) <> 0 THEN 
//			lb_Continue = FALSE
//		END IF
//		
//		//	Request a lock for user
//		n_cst_LicenseManager lnv_LicenseManager 
//		IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Settlements, "E" ) < 0 THEN
//			lb_Continue = FALSE
//		END IF
//		
//		IF lb_Continue THEN
//			lstr_Parm.is_Label = "S_TRANSACTION_SELECTION"
//			lstr_Parm.ia_Value = istr_transaction
//			lnv_Msg.of_Add_Parm ( lstr_Parm )
//			OpenWithParm ( w_transaction_Selection , lnv_msg )
//			
//			lnv_msg = message.powerobjectParm
//			IF isValid ( lnv_Msg ) THEN
//				IF lnv_Msg.of_Get_Parm ( "S_TRANSACTION_SELECTION", lstr_Parm ) <> 0 THEN
//					lstr_Transaction_Selection = lstr_parm.ia_Value
//					IF isValid ( lstr_Transaction_Selection ) THEN
//						istr_transaction = lstr_Transaction_Selection
//						li_Rtn = THIS.wf_LoadTransactions ( lnv_Msg )
//					END IF
//				END IF
//			END IF
//			IF li_Rtn = -1 THEN
//				MessageBox("Loading Transactions" , "An error occurred while attempting to load the selected transations.")
//			END IF
//			
//		END IF
//		
//	CASE "NEW!"
//		//Event ue_new ( )
//		PostEvent ( "ue_new" )
//		
//	CASE "DELETE!"
//		CHOOSE CASE tab_transactionmanager.SelectedTab
//		
//		CASE ci_tabpage_transactions
//			
//			IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.RowCount ( ) > 0 THEN
//				tab_TransactionManager.tabpage_Transactions.dw_Transactions.Event Post pfc_DeleteRow ( )
//				tab_TransactionManager.tabpage_Transactions.dw_Transactions.Function Post SetFocus ( )
//			END IF
//			
//		CASE ci_tabpage_amounts
//			
//			IF tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.RowCount( ) > 0 THEN
//				tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.Event Post pfc_DeleteRow ( )
//				tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.Function Post SetFocus ( )
//			END IF
//			
//		CASE ci_tabpage_unassignedamounts
//			
//			IF tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.RowCount ( ) > 0 THEN
//				tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.Event Post pfc_DeleteRow ( )
//				tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.Function Post SetFocus ( )
//				
//				this.post wf_unassignedamountstatus()
//
//			END IF
//			
//		END CHOOSE
//	
//	CASE "ASSIGN!"
//		PostEvent ( "ue_Assign" )
//	
//	CASE "UNASSIGN!"
//		PostEvent ( "ue_Unassign" )
//	
//	CASE "AUTOASSIGN!"
//		CHOOSE CASE this.Event ue_autoAssign ( )
//		CASE -1
//			messagebox ( "Auto Assign", "No amounts were assigned to the selected transaction. ", Information! )
//		CASE 0
//			//NOT ON THE UNASSIGNED AMOUNT TAB
//		CASE ELSE
//			//REFRESH and go to amounts tab if not already there
//			IF tab_TransactionManager.tabpage_TransactionAmounts.PageCreated() = TRUE THEN
//				tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.inv_UILink.RefreshFromBcm ( )
//			END IF
//			tab_TransactionManager.SelectTab ( tab_TransactionManager.tabpage_TransactionAmounts )
//		END CHOOSE
//	CASE "SPLITAMOUNT!"
//		this.wf_splitAmountOwed()
//		
//	CASE "PRINTTRANSACTION!"
//		IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE AND &
//			tab_transactionmanager.SelectedTab = ci_tabpage_transactions THEN
//			
//			ll_row = wf_GetCurrentTransactionRow ( inv_Transaction )
//			IF ll_row > 0 THEN
//				tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetRow ( ll_row )
//				tab_TransactionManager.tabpage_Transactions.dw_Transactions.Event ue_PrintTransaction ( )
//			END IF
//		ELSE
//			MessageBox ("Print Transaction" , "Please be sure you are on the Transactions Tab before attempting to print the transaction.")
//		END IF
//		
//	CASE "AMOUNTTEMPLATES!"
//		This.wf_AmountTemplates ( )
//	
//	CASE "ITINERARY!"
//		This.Event pfc_MessageRouter ( "ue_Itinerary" )
//
//	END CHOOSE
//END IF	
end subroutine

private function integer wf_updaterequestor (datawindow adw_target, boolean ab_updateinvisible);//Returns : 1 = Success, -1 = Error, 
//				0 = No attempt made (control invisible and ab_UpdateInvisibles = FALSE )

//Note : Passing a non-ofr dw will crash this!

u_dw	ldw_Target
Integer	li_Return

ldw_Target = adw_Target

IF ldw_Target.Visible OR &
	ab_UpdateInvisible THEN

	li_Return = ldw_Target.inv_UILink.UpdateRequestor ( ldw_Target.GetRow ( ) )

ELSE
	li_Return = 0

END IF

RETURN li_Return
end function

protected subroutine wf_amounttemplates ();n_cst_bso_TransactionManager	lnv_TransactionManager
w_tv_AmountTemplates		lw_AmountTemplates

lnv_TransactionManager = tab_transactionmanager.wf_GetTransactionManager ( )

OpenSheetWithParm ( lw_AmountTemplates, lnv_TransactionManager.of_GetDefaultEntityId ( ), &
	gnv_App.of_GetFrame ( ), 0, Layered! )
	
	

end subroutine

public subroutine wf_autogeneratetransaction ();n_cst_bso_TransactionManager	lnv_TransactionManager

lnv_TransactionManager = tab_transactionmanager.wf_GetTransactionManager ( )


Date	ld_Min, &
		ld_Max
s_Anys	lstr_Result
s_Parm	lstr_Parm
n_cst_Msg	lnv_Msg
n_cst_beo_Transaction	lnv_Transaction
n_cst_bso_Dispatch		lnv_BlankDispatch
n_cst_beo_AmountTemplate lnva_Amount[]
Integer	li_Result, &
			li_Return = 1
			
boolean	lb_WholeDateRange

lstr_Parm.is_Label = "OPTIONAL"
lstr_Parm.ia_Value = "FALSE"
lnv_msg.of_add_Parm ( lstr_Parm )

OpenWithParm ( w_Date_Range, lnv_Msg )

lstr_result = message.powerobjectparm
li_result = lstr_result.anys[1]

if li_result = 1 then
	ld_min = lstr_result.anys[2]
	ld_max = lstr_result.anys[3]
	
	//If date range is more than one day then ask question
	IF daysafter(ld_min, ld_max ) > 0 THEN
		
		CHOOSE CASE	messagebox("Auto Generation",&
			"Do you want your aggregate amount templates to calculate for the selected date range ? " + &
			"If you answer no then the aggregates will be by day.", Question!, YesNoCancel!)
		CASE 1
			//PROCESS WHOLE RANGE
			lb_WholeDateRange = TRUE
		CASE 2
			//BREAK OUT THE DAYS
			lb_WholeDateRange = FALSE
		CASE 3
			//RETURN
			li_Return = -1
		END CHOOSE
		
	END IF
	
	SetPointer ( HourGlass! )
	IF li_Return = 1 THEN
		//get daterange templates
		
		IF lnv_TransactionManager.of_GeneratePayable (ld_Min, ld_Max, lnv_Transaction, lnva_Amount, lnv_BlankDispatch, lb_WholeDateRange) > 0 THEN
				
			n_ds	lds_PaySplitCache	
			lds_PaySplitCache = lnv_transactionmanager.of_GetPaySplitCache(TRUE)
//			lds_PaySplitCache.sharedata(dw_paysplit)
			
			IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE THEN
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.RefreshFromBcm ( )
				tab_TransactionManager.tabpage_Transactions.dw_TransactionDetail.inv_UILink.RefreshFromBcm ( )
			END IF
		
			//change instance transaction variable so tabs will know what transactin to filter by
			inv_Transaction = lnv_Transaction
		
			tab_transactionmanager.Event ue_TransactionChanged ( inv_Transaction )
			
			IF tab_transactionmanager.SelectedTab = ci_tabpage_unassignedamounts then
				
				IF tab_TransactionManager.tabpage_TransactionAmounts.PageCreated() = TRUE THEN
					tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.&
								SetFilter( "amountowed_fktransaction = " + string ( inv_Transaction.Of_GetId ( ) ) )
					tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.Filter( )
				END IF
			ELSE
				tab_TransactionManager.SelectTab ( tab_TransactionManager.tabpage_TransactionAmounts )
			END IF
		END IF
	END IF
END IF
end subroutine

protected function integer wf_loadtransactions (n_cst_msg anv_msg);  
// 1 = success , 0 = user canceled , -1 = failure

String 	ls_Status
String	ls_IDs
String	ls_EntityName
String	ls_Entity
String	ls_EntityType
String	ls_UnBatched
String	ls_batchNumber
Long		ll_EntityID
Long		ll_TmpID
Long		lla_Ids[]

Date 		ld_StartDate
Date 		ld_EndDate
Int		li_Status
Boolean	lb_HaveData
Boolean 	lb_Continue = TRUE
Int		li_MboxRtn
Int		li_UpdateRtn
Int		li_SaveRtn
Int		li_ReturnValue = 1

n_cst_msg	lnv_Msg	
s_Parm		lstr_Parm

S_Transaction_Selection  lstr_Selection

if ib_frombatchmanager then
	IF inv_msg.of_Get_Parm ( "S_TRANSACTION_SELECTION" , lstr_Parm ) <> 0 THEN
		lstr_Selection = lstr_Parm.ia_Value
		istr_transaction = lstr_Selection
	ELSE
		li_ReturnValue = -1
	END IF

ELSEIF IsValid ( anv_Msg ) THEN
	lnv_Msg = anv_Msg
	IF li_ReturnValue <> -1 THEN
		IF lnv_msg.of_Get_Parm ( "S_TRANSACTION_SELECTION" , lstr_Parm ) <> 0 THEN
			lstr_Selection = lstr_Parm.ia_Value
			istr_transaction = lstr_Selection
		ELSE
			li_ReturnValue = -1
		END IF
	END IF
	
	IF li_ReturnValue <> -1 THEN
		lla_ids       = lstr_Selection.la_Transactionids 
		ls_EntityName = lstr_Selection.s_EntityName 
		ls_EntityType = lstr_Selection.s_EntityType 
		ll_EntityID   = lstr_Selection.l_EntityID
		ld_StartDate  = lstr_Selection.d_StartDate
		ld_EndDate    = lstr_Selection.d_endDate 
		li_Status     = lstr_Selection.i_status 
		ls_UnBatched  = lstr_Selection.s_UnBatched
		ls_BatchNumber= lstr_Selection.s_BatchNumber
		lb_HaveData   = lstr_Selection.b_HaveData 
		ib_Batchable  = FALSE // prevents batching unless a batch is retrieved then flag is set below
	END IF

else
	li_ReturnValue = -1
END IF

IF li_ReturnValue <> -1 THEN
	lla_ids       = lstr_Selection.la_Transactionids 
	ls_EntityName = lstr_Selection.s_EntityName 
	ls_EntityType = lstr_Selection.s_EntityType 
	ll_EntityID   = lstr_Selection.l_EntityID
	ld_StartDate  = lstr_Selection.d_StartDate
	ld_EndDate    = lstr_Selection.d_endDate 
	li_Status     = lstr_Selection.i_status 
	ls_UnBatched  = lstr_Selection.s_UnBatched
	ls_BatchNumber= lstr_Selection.s_BatchNumber
	lb_HaveData   = lstr_Selection.b_HaveData 
	ib_Batchable  = FALSE // prevents batching unless a batch is retrieved then flag is set below
END IF


IF li_ReturnValue <> -1 THEN
	ll_TmpID = ll_EntityID
	IF IsValid (inv_transactionmanager) THEN
		ls_Entity = inv_transactionmanager.of_DescribeEntity ( ll_Tmpid , 0  ) // 0????
	ELSE 
		li_returnValue = -1
	END IF
	
END IF

IF li_ReturnValue <> -1 THEN  // then check updates

	li_UpdateRtn = of_UpdateChecks()  
	If li_UpdateRtn <= 0 Then 
		//	 0 = No pending changes found 
		//	-1 = AcceptText error
		//	-2 = UpdatesPending error was encountered
		//	-3 = Validation error was encountered		
	End If	

	CHOOSE CASE li_UpdateRtn 
			
		CASE is > 0  //There are changes pending.

			li_MboxRtn = MessageBox( "Change Selection", "By proceeding you will clear all existing transactions. "+&
				"Do you want to save changes before continuing?", QUESTION!, YESNOCANCEL! , 1)
		
			CHOOSE CASE li_MBoxRtn
				CASE 1  //Yes - Save first
					li_SaveRtn = This.Event pfc_Save( )
					
					CHOOSE CASE li_SaveRtn
						CASE is < 0 // Save Failed

							//I think we'll just go ahead and cancel.  If they want to change selection anyway, 
							//all they have to do is hit GOTO again, and their selection is there.

							//No option
							li_ReturnValue = 0
							lb_Continue = FALSE

					END CHOOSE
					
				CASE 2  //No - proceed without saving
					lb_Continue = TRUE
				CASE 3  //Cancel change
					lb_Continue = FALSE
					li_ReturnValue = 0
				CASE ELSE //Unexpected return value
					lb_Continue = FALSE
					li_ReturnValue = -1
			END CHOOSE
			
		CASE 0  //There are no changes pending.
			//Proceed with change.
			
		CASE is < 0  //Changes are pending, but do not pass validation.
			li_MboxRtn = MessageBox ( "Validation", "The information entered does not pass validation and "  + &
										"must be corrected before changes can be saved.~r~n~r~n" + &
										"Change selection without saving changes?", &
											exclamation!, YesNo!, 2)
			IF li_MboxRtn = 1 THEN
				lb_Continue = TRUE
			ELSE
				li_ReturnValue = 0 
				lb_Continue = FALSE
			END IF
			
	END CHOOSE
		
	IF lb_Continue THEN

		inv_transactionmanager.Event PT_Reset ( )
		THIS.EVENT ue_Reset ( )
		inv_transactionmanager.of_SetDefaultEntityId ( ll_EntityID )
		tab_TransactionManager.selectTab ( 1 )
		//inv_TransactionManager = tab_TransactionManager.wf_GetTransactionManager ( )
	
		IF UpperBound (lla_Ids)  > 0  THEN
			li_ReturnValue = inv_TransactionManager.of_loadTransactions ( lla_Ids )	
		ELSEIF Len ( ls_BatchNumber ) > 0  THEN
			
			// load batch is not case sensitive
			li_ReturnValue = inv_TransactionManager.of_loadBatch ( ls_batchnumber )		
			
			is_BatchNumber = UPPER ( ls_BatchNumber )
			ib_Batchable = TRUE // since a batch was loaded we will allow the user to export a batch
									// this flag is referenced in the  process request function
									
		ELSEIF li_Status = 1 THEN
			li_ReturnValue = inv_TransactionManager.of_loadopenTransactions ( ll_EntityID )			
		ELSEIF ls_UnBatched = "Y" THEN
			li_ReturnValue = inv_TransactionManager.of_loadUnBatchedTransactions ( ll_EntityID )			
		ELSE
			li_ReturnValue = inv_TransactionManager.of_loadTransactions ( ll_EntityID, ld_StartDate, ld_EndDate )
		END IF
		
		IF li_ReturnValue <> -1  THEN
			
				dw_1.InsertRow ( 0 )
				dw_1.object.entity_name [1] =  ls_Entity
				tab_TransactionManager.wf_SetTransactionManager ( inv_TransactionManager )
				//Should we retrieve both of these? -->  yes
				//Maybe you should do it in reverse order, since rowchanged on Transactions drives filter on 
				//detail.  You may not need the setrow then either.  BKW
			
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.TriggerEvent ( "task_retrieve" )
				tab_TransactionManager.tabpage_Transactions.dw_Transactiondetail.TriggerEvent ( "task_retrieve" )			
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetRow(1)
			
		END IF
		
		this.title = this.title + " - " + ls_EntityName
	END IF
END IF

RETURN li_ReturnValue
end function

protected function integer wf_accepttext (integer ai_tabpage);//You're hiding these after they've failed validation!

Integer li_Return

CHOOSE CASE ai_tabpage
	CASE 1
		IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.AcceptText ( ) = -1 THEN
	
			li_Return = -1
	
		END IF
		
		IF tab_TransactionManager.tabpage_Transactions.dw_TransactionDetail.AcceptText ( ) = -1 THEN
	
			li_Return = -1
	
		END IF
		
		IF li_Return <> -1 THEN
			IF tab_TransactionManager.tabpage_Transactions.dw_TransactionDetail.visible THEN
				tab_TransactionManager.tabpage_Transactions.dw_TransactionDetail.hide ()
			END IF
		END IF
	
	CASE 2
		IF tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.AcceptText ( ) = -1 THEN
	
			li_Return = -1
	
		END IF

		IF tab_TransactionManager.tabpage_TransactionAmounts.dw_AmountDetail.AcceptText ( ) = -1 THEN
	
			li_Return = -1
	
		END IF

		IF li_Return <> -1 THEN
			IF tab_TransactionManager.tabpage_TransactionAmounts.dw_AmountDetail.visible THEN
				tab_TransactionManager.tabpage_TransactionAmounts.dw_AmountDetail.hide ()
			END IF
		END IF

	CASE 3
		IF tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.AcceptText ( ) = -1 THEN
	
			li_Return = -1
	
		END IF

		IF tab_TransactionManager.tabpage_UnassignedAmounts.dw_AmountDetail.AcceptText ( ) = -1 THEN
	
			li_Return = -1
	
		END IF

		IF li_Return <> -1 THEN
			IF tab_TransactionManager.tabpage_UnassignedAmounts.dw_AmountDetail.visible THEN
				tab_TransactionManager.tabpage_UnassignedAmounts.dw_AmountDetail.hide ()
			END IF
		END IF
		
END CHOOSE

RETURN li_return
end function

private subroutine wf_refresh (integer ai_tabpage);CHOOSE CASE ai_tabpage
	CASE 1
		tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.RefreshFromBcm ( )
		tab_TransactionManager.tabpage_Transactions.dw_TransactionDetail.inv_UILink.RefreshFromBcm ( )
	
	CASE 2
		tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.inv_UILink.RefreshFromBcm ( )
		tab_TransactionManager.tabpage_TransactionAmounts.dw_AmountDetail.inv_UILink.RefreshFromBcm ( )

	CASE 3
		tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.inv_UILink.RefreshFromBcm ( )
		tab_TransactionManager.tabpage_UnassignedAmounts.dw_AmountDetail.inv_UILink.RefreshFromBcm ( )
		
END CHOOSE

end subroutine

protected function long wf_getcurrenttransactionrow (n_cst_beo_transaction anv_beo_transaction);long		lla_id [], &
			ll_row
			
string	ls_find

lla_id [1] = anv_beo_transaction.Of_GetId ( )

IF lla_id [1] > 0 THEN
	ls_find = "transaction_id = " + string(lla_id [1])
	ll_row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.Find &
										( ls_find , &
											1, &
											tab_TransactionManager.tabpage_Transactions.dw_Transactions.RowCount() )
END IF

Return ll_row
end function

public function integer wf_unassignselectedbatch ();Long	ll_Row

String ls_NullString

n_cst_bcm	lnv_Bcm
n_cst_Beo_Transaction lnv_Transaction
n_cst_Privileges 	lnv_Privileges
   //lnv_Privileges.of_Settlements_AssignToBatch ( )
IF lnv_Privileges.of_Settlements_AssignToBatch ( ) THEN
	SetNull ( ls_NullString )
	
	lnv_Bcm = inv_transactionmanager.of_GetTransactions ( )
	IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( 0 ) = 0 THEN
		// then no row is selected so use teh current row
		ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetRow ( )
		IF ll_Row > 0 THEN
			lnv_Transaction	= tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
			IF IsValid ( lnv_Transaction ) THEN
				lnv_Transaction.of_SetBatchNumber ( ls_NullString )
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
			END IF
		END IF
		
	ELSE	
		
		DO
			ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( ll_Row )
			
			lnv_Transaction	= tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
			IF IsValid ( lnv_Transaction ) THEN
				lnv_Transaction.of_SetBatchNumber ( ls_NullString )
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
			END IF
			
		LOOP UNTIL ll_Row = 0
	END IF
			
ELSE
	MessageBox( "Unassign From Batch" , "You do not have the required privileges to perform this operation." )
END IF

RETURN 1
end function

public function integer wf_assigntobatch (string as_batchname);Long	ll_Row

//n_cst_bcm	lnv_Bcm
n_cst_Beo_Transaction lnv_Transaction

n_cst_Privileges 	lnv_Privileges
IF lnv_Privileges.of_Settlements_AssignToBatch ( ) THEN

//	lnv_Bcm = inv_transactionmanager.of_GetTransactions ( )
	IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( 0 ) = 0 THEN
		// no selected row so use the current
		ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetRow ( )
		IF ll_Row > 0 THEN
			lnv_Transaction = tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
			IF IsValid ( lnv_Transaction ) THEN
				lnv_Transaction.of_SetBatchNumber ( as_batchname )
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
			END IF
		END IF
		
	ELSE
		DO
			ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( ll_Row )
			lnv_Transaction	= tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
			IF IsValid ( lnv_Transaction ) THEN
				lnv_Transaction.of_SetBatchNumber ( as_batchname )
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
			END IF
			//Batch Selected transaction 
		LOOP UNTIL ll_Row = 0
	END IF
ELSE
	MessageBox( "Assign To Batch" , "You do not have the required privileges to perform this operation." )
END IF
RETURN 1
end function

public subroutine wf_closebatch ();Int i 
Long	ll_Rows
n_cst_beo_Transaction	lnv_Transaction


IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE THEN
	ll_Rows = tab_TransactionManager.tabpage_Transactions.dw_Transactions.RowCount ( )
	
	st_printing.Visible = TRUE
	FOR i = 1 TO ll_Rows
		st_printing.text = "Closing Transaction "+String (i) + " of " + String ( ll_rows )
		tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetRow ( i )
		IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.Event ue_CloseTransaction ( ) = -1 THEN
			EXIT
		END IF
	NEXT
		
	IF i = ll_Rows + 1 THEN
		IF isValid ( tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink ) THEN
			IF MessageBox ( "Close Transactions", "Do you want to print all of the transactions in the batch now?", &
									Question!, YesNo!, 1 ) = 1 THEN
				THIS.wf_PrintBatch ( )
			END IF	
		END IF
	END IF
	
	st_printing.Visible = FALSE
END IF
end subroutine

public function integer wf_printbatch ();Int	i
Long	ll_Rows

n_cst_beo_Transaction	lnv_transaction

IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE AND & 
		tab_transactionmanager.SelectedTab = ci_tabpage_transactions THEN
		
	IF isValid ( tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink ) THEN
		
		ll_Rows =  tab_TransactionManager.tabpage_Transactions.dw_Transactions.RowCount ( )
		st_printing.Visible = True
		FOR i = 1 TO ll_Rows	
			st_printing.text = "Printing "+String (i) + " of " + String ( ll_rows )
			lnv_Transaction = tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.GetBeo ( i )					
			lnv_Transaction.of_Print ( )
		NEXT
		
		st_printing.Visible = False
	END IF
ELSE
	// goto page
END IF
Return 1
end function

private subroutine wf_settemplateselectionfilter ();/*
	Get the locked blocks from uo_events.  Load the the calculation datastore one block at a
	time and apply the selection filters to find candidate templates.
*/

long	lla_Id[], &
		ll_Row, &
		ll_FirstRow, &
		ll_LastRow, &
		ll_ArrayCount, & 
		ll_BlockCount, &
		ll_ArrayMax, &
		ll_index

string	lsa_Expression[], &
			lsa_DataPoint[], &
			lsa_Blank[], &
			ls_Condition, &
			ls_Filter, &
			ls_InList
			
n_ds	lds_EventCache, &
		lds_BlockData
		
n_cst_EventBlock	lnva_EventBlock[]
n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

IF isvalid ( inv_Itinerary ) THEN
	//ok proceed
ELSE
	inv_Itinerary = CREATE n_cst_beo_Itinerary2
	//destroyed in close of window
END IF

lds_BlockData = CREATE n_ds
lds_BlockData.DataObject = "d_ItineraryData"
lds_EventCache = inv_Itinerary.of_GetEventCache ( )
IF IsValid ( lds_EventCache ) THEN

	lnv_Event.of_SetSource ( lds_EventCache )

	//loop for each event block
	ll_ArrayCount = uo_events.of_GetEventBlock ( lnva_EventBlock )
	
	FOR ll_BlockCount = 1 to ll_ArrayCount

		lds_BlockData.Reset()
		this.wf_LoadCalculationDatastore ( lnva_EventBlock[ll_BlockCount], lds_BlockData, lnv_Event)
		
		//get all selectionfilter expressions from all of the available templates
		lsa_Expression = lsa_Blank
		uo_template_selection.of_getAvailableSelectionFilter ( lsa_Expression, lla_Id, TRUE )		//Include filtered buffer	
		ll_ArrayMax = upperbound(lsa_Expression)	
		
		//Load data points from the expressions 
		lsa_DataPoint = lsa_Blank
		FOR ll_Index = 1 TO ll_ArrayMax
			
			lds_BlockData.Object.cf_Numeric.Expression = lsa_Expression[ ll_Index ]
			ls_Condition = lds_BlockData.GetItemString ( 1, "cf_Numeric" )
			IF upper(ls_Condition) = "TRUE" THEN
				//don't filter out
				ls_InList += string ( lla_Id[ll_Index] ) + ','
			ELSE
				//filter out

			END IF

		NEXT
	
		IF len ( ls_InList ) > 0 THEN
			uo_template_selection.of_SetInList ( left ( ls_InList, len ( ls_InList ) - 1 ) )
		ELSE
			uo_template_selection.of_SetInList ( '0' )
		END IF

	NEXT
	
	//if qualifying templates are found then add them to the n_cst_eventblock as available templates
						

END IF

//	ls_Return = lnv_Event.of_GetLocation ( )

DESTROY ( lnv_Event )

end subroutine

public subroutine wf_loadcalculationdatastore (n_cst_eventblock anv_eventblock, ref datastore ads_calculation, ref n_cst_beo_event anv_event);long	ll_ArrayMax, &
		lla_EventIdlist[], &
		ll_EventIdCount, & 
		ll_firstsourcerow, &
		ll_lastsourcerow, &
		ll_ndx, &
		j, &
		ll_FirstRow, &
		ll_LastRow, &
		ll_Row, &
		ll_FindRow, &
		ll_BlockRowCount, &
		ll_ShipmentId, &
		ll_Return = 0

string	ls_EventSequence, &
			ls_ShipmentType

integer	li_DisplayType

n_ds	lnv_ShipmentCache
n_ds	lds_EventCache
n_cst_beo_Company	 lnv_Company
n_cst_beo_Shipment lnv_Shipment

n_cst_msg	lnv_Range

lnv_shipment = CREATE n_cst_beo_shipment

ll_BlockRowCount = anv_eventblock.of_GetRowCount()
li_DisplayType = uo_template_selection.of_GetDisplayType ( )
anv_EventBlock.of_GetEventIdList ( lla_EventIdlist )
ll_EventIdCount = upperbound ( lla_EventIdlist )
ll_FirstRow = anv_EventBlock.of_GetFirstDisplayRow()
ll_LastRow = anv_EventBlock.of_GetLastDisplayRow()
If wf_SetItineraryRange(ll_FirstRow, ll_LastRow, lnv_Range) > 0 THEN
	inv_TransactionManager.of_SetInitialItineraryRange(lnv_Range)
END IF

//system setting to set first id to the one before the eventblock
n_cst_setting_InteractiveSelectionFilter	lnv_SelectionFilter

lnv_SelectionFilter = create n_cst_setting_InteractiveSelectionFilter

IF lnv_SelectionFilter.of_Getvalue( ) = lnv_SelectionFilter.cs_Yes THEN
	inv_Itinerary.of_SetRange ( lnv_Range )
	ll_firstsourcerow = anv_EventBlock.of_GetFirstSourceRow()
	ll_lastsourcerow = anv_EventBlock.of_GetLastSourceRow()
	lds_EventCache = inv_Itinerary.of_GetEventCache ()
	if ll_firstsourcerow - 1 > 0 then
		for ll_ndx = ll_firstsourcerow - 1 to ll_lastsourcerow
			j++
			lla_EventIdlist[j] = lds_EventCache.object.de_id[ll_ndx]
		next
	end if
	ll_EventIdCount = upperbound ( lla_EventIdlist )
	
END IF

destroy lnv_SelectionFilter

ads_calculation.Insertrow(0)

FOR ll_Row = 1 to ll_BlockRowCount

	IF li_DisplayType = appeon_constant.ci_Type_Point_to_Point OR &
		li_DisplayType = appeon_constant.ci_Type_All THEN
		
		//1st row, get it from the itinerary
		anv_Event.of_SetSourceId ( lla_EventIdlist[1] )
		
		//get site info
		IF anv_Event.of_GetSite ( lnv_Company ) = 1 THEN
			IF isvalid ( lnv_Company )  THEN
				ads_calculation.object.OriginId[1] = lnv_Company.of_GetId ( )
				ads_calculation.object.OriginRef[1] = lnv_Company.of_GetCodeName ( )
				ads_calculation.object.OriginCity[1] = lnv_Company.of_GetCity ( )
				ads_calculation.object.OriginState[1] = lnv_Company.of_GetState ( )
			END IF
		END IF
		
		//last row
		anv_Event.of_SetSourceId ( lla_EventIdlist[ll_EventIdCount] )
		//get site info
		IF anv_Event.of_GetSite ( lnv_Company ) = 1 THEN
			IF isvalid ( lnv_Company )  THEN
				ads_calculation.object.DestinationId[1] = lnv_Company.of_GetId ( )
				ads_calculation.object.DestinationRef[1] = lnv_Company.of_GetCodeName ( )
				ads_calculation.object.DestinationCity[1] = lnv_Company.of_GetCity ( )
				ads_calculation.object.DestinationState[1] = lnv_Company.of_GetState ( )
			END IF
		END IF
		
	END IF
	
	IF li_DisplayType = appeon_constant.ci_Type_Shipment OR &
		li_DisplayType = appeon_constant.ci_Type_All THEN

		FOR ll_Row = 1 to ll_EventIdCount
			anv_Event.of_SetSourceId ( lla_EventIdlist[ll_Row] )
			ll_ShipmentId = anv_Event.of_GetShipment ( )
			inv_Dispatch.of_RetrieveShipment ( ll_ShipmentId )
			lnv_ShipmentCache = inv_Dispatch.of_GetShipmentCache ( )
			lnv_Shipment.Of_SetSource ( lnv_ShipmentCache )
			lnv_Shipment.of_SetSourceId ( ll_ShipmentId )
			ls_ShipmentType = lnv_Shipment.of_GetShipmentType ( )
			ads_calculation.object.ShipmentType[1] = ls_ShipmentType	
			//all events, search eventblock and if there is only one shipment
			//then we can get shipmnent data
			
		NEXT
	
	END IF
			
	IF	li_DisplayType = appeon_constant.ci_Type_Move OR &
		li_DisplayType = appeon_constant.ci_Type_All THEN
		
		//parse filter expression and match sequence of event types
		FOR ll_Row = 1 to ll_EventIdCount
			anv_Event.of_SetSourceId ( lla_EventIdlist[ll_Row] )
			anv_Event.of_GetType ( )
			ls_EventSequence += anv_Event.of_GetType ( ) + ","				
		NEXT
		//strip last comma
		ls_EventSequence = left ( ls_EventSequence, len ( ls_EventSequence ) - 1 )
		IF len ( ls_EventSequence ) > 0 THEN
			ads_calculation.object.EventSequence[1] = ls_EventSequence			
		END IF
		
	END IF
					
NEXT
decimal lc_miles
lc_miles= inv_Itinerary.of_GetTotalMiles()
ads_calculation.object.TotalMiles[1] = inv_Itinerary.of_GetTotalMiles()
ads_Calculation.Object.LoadedMiles[1] = inv_Itinerary.of_GetLoadedMiles()
ads_Calculation.Object.EmptyMiles[1] = inv_Itinerary.of_GetEmptyMiles()
ads_Calculation.Object.BobTailMiles[1] = inv_Itinerary.of_GetBobTailMiles()
ads_Calculation.Object.DeadHeadMiles[1] = inv_Itinerary.of_GetDeadHeadMiles()
inv_Itinerary.of_Resetstopdata( )  // total wt and revenue use diferent dataobject for
											// payables calculation. this payables object removes 'Shipment Only' items.
ads_calculation.object.TotalWeight[1] = inv_Itinerary.of_GetTotalWeight( TRUE, TRUE)
ads_calculation.object.FreightRevenue[1] = inv_Itinerary.of_GetFreightRevenue(TRUE )
inv_Itinerary.of_Resetstopdata( )

ads_calculation.object.Shipments[1] = inv_Itinerary.of_GetShipmentCount()
ads_calculation.object.Hooks[1] = inv_Itinerary.of_GetHookCount()
ads_calculation.object.Drops[1] = inv_Itinerary.of_GetDropCount()
ads_calculation.object.Pickups[1] = inv_Itinerary.of_GetPickupCount()
ads_calculation.object.Deliveries[1] = inv_Itinerary.of_GetDeliveryCount()
ads_calculation.object.WorkingStops[1] = inv_Itinerary.of_GetWorkingStopCount()
ads_calculation.object.Stops[1] = inv_Itinerary.of_GetStopCount()
ads_calculation.object.StartDate[1] = inv_Itinerary.of_GetStartDate()
ads_calculation.object.EndDate[1] = inv_Itinerary.of_GetEndDate()
ads_calculation.object.itineraryhours[1] = inv_Itinerary.of_Getitineraryhourstotal()
	

DESTROY ( lnv_Shipment )
DESTROY lnv_Company
end subroutine

private function long wf_setitineraryrange (long al_start, long al_end, ref n_cst_msg anv_range);long	ll_RangeCount
		
integer	li_RouteType

date		ld_NullDate

boolean	lb_routetype

s_Parm		lstr_Parm
n_cst_msg	lnv_Range
n_cst_Events	lnv_Events
n_ds			lds_EventCache

setnull(ld_NullDate)

//inv_Dispatch.of_ResetTimes ( 'ITIN!', ld_NullDate )

	
//routetype

if inv_transactionmanager.of_GetRouteTypeSettlements(li_RouteType) = 1 then
	lb_routetype = true
	lds_eventcache = inv_Dispatch.of_GetEventCache ( )
	lnv_Events.of_ResetTimes ( lds_eventcache, 'ITIN!', ld_NullDate, li_RouteType )	
	inv_Dispatch.of_SetEventCache (lds_eventcache)

end if

inv_Itinerary.of_SetDispatchManager ( inv_Dispatch )
		

lnv_Range.of_Reset ( )
IF al_Start = 0 THEN
	lstr_Parm.is_Label = "StartDate"
	lstr_Parm.ia_Value = id_start
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "EndDate"
	lstr_Parm.ia_Value = id_end
	lnv_Range.of_Add_Parm ( lstr_Parm )
ELSE
	lstr_Parm.is_Label = "StartRow"
	lstr_Parm.ia_Value = al_start
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "EndRow"
	lstr_Parm.ia_Value = al_end
	lnv_Range.of_Add_Parm ( lstr_Parm )
END IF

if lb_routetype then
	inv_itinerary.of_SetRouteType(li_RouteType)
end if
		
lstr_Parm.is_Label = "ItinType"
lstr_Parm.ia_Value = ii_itinerarytype
lnv_Range.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "ItinId"
lstr_Parm.ia_Value = il_itineraryid
lnv_Range.of_Add_Parm ( lstr_Parm )

IF isvalid ( inv_Itinerary ) THEN
	//ok proceed
ELSE
	inv_Itinerary = CREATE n_cst_beo_Itinerary2
	//destroyed in close of window
END IF

inv_Itinerary.of_SetRange ( lnv_Range )

anv_Range = lnv_Range

ll_RangeCount = inv_Itinerary.of_GetEventCount ( )
//
return ll_RangeCount
end function

private function integer wf_blockgeneration (boolean ab_manual);setpointer(Hourglass!)

long	lla_Id[], &
		ll_IdCount, &
		ll_BlockCount, &
		ll_StartRow, &
		ll_EndRow, &
		ll_Origin, &
		ll_Destination, &
		ll_Ndx, &
		ll_NbrAmountOweds, &
		j, &
		ll_Templatecount, &
		ll_TransactionId
		
boolean	lb_Taxable

decimal	lc_Amount

Date	ld_BlockStartDate, &
		ld_BlockEndDate

n_ds							lds_PeriodicUpdates
n_cst_EventBlock			lnva_EventBlock[]
n_cst_beo_event			lnva_event[]
n_cst_beo_AmountTemplate lnva_AmountTemplate[], &
								 lnva_processTemplate[]
n_cst_msg					lnv_Range, &
								lnv_MsgOfTemplates
								
s_Parm		lstr_Parm

n_cst_beo_transaction	lnv_transaction
n_cst_beo_entity			lnv_entity
n_cst_bso_payable		lnv_payable
n_cst_AnyArraySrv	lnv_Array

Integer	li_Result, &
			li_Return = 1, &
			li_AmountType
			
boolean	lb_WholeDateRange = TRUE //Block ranges will not be subdivided

lds_PeriodicUpdates = CREATE n_ds
lds_PeriodicUpdates.DataObject = "d_PeriodicSubset"

inv_transactionmanager.of_ResetNewAmountID()

IF ab_Manual THEN

	lc_Amount = uo_template_selection.of_GetManualAmount()
	li_AmountType = uo_template_selection.of_GetManualAmountType()
	lb_Taxable = uo_template_selection.of_GetManualAmountTaxable()
	
	ll_BlockCount = uo_Events.of_GetEventBlock(lnva_EventBlock) 
	
	if uo_template_selection.of_isDateRangeSelected() THEN
		IF wf_SetItineraryRange (0, 0, lnv_Range ) > 0 THEN
			//Range was successfully set
			inv_TransactionManager.of_SetInitialItineraryRange(lnv_Range)
			inv_TransactionManager.of_ManualAmount(inv_Transaction, inv_dispatch, lc_Amount, li_AmountType, lb_Taxable, id_start, id_end)
		end if
	else
		FOR ll_Ndx = 1 to ll_BlockCount			
			ll_Startrow = lnva_EventBlock[ll_Ndx].of_GetFirstSourceRow()
			ll_Endrow = lnva_EventBlock[ll_Ndx].of_GetLastSourceRow()
			ld_BlockStartDate = lnva_EventBlock[ll_Ndx].of_GetStartDate()
			ld_BlockEndDate = lnva_EventBlock[ll_Ndx].of_GetEndDate()
			IF wf_SetItineraryRange(ll_Startrow, ll_Endrow, lnv_Range) > 0 THEN
				//Range was successfully set
				inv_TransactionManager.of_SetInitialItineraryRange(lnv_Range)
				inv_TransactionManager.of_ManualAmount(inv_Transaction, inv_dispatch, lc_Amount, li_AmountType, lb_Taxable, ld_BlockStartDate, ld_BlockEndDate)
			END IF					
		NEXT
	end if
ELSE
	inv_transactionmanager.of_getEntity(il_EntityId, lnv_entity )
	lnv_payable = CREATE n_cst_bso_payable
	lnv_payable.ClearOFRErrors()
	//get selected templates
	ll_IdCount = uo_template_selection.of_GetSelectedtemplate(lla_Id)
	
	IF ll_IdCount > 0 THEN
		
		inv_TransactionManager.of_GetAmountTemplate(lla_Id, lnva_AmountTemplate)
		
	END IF
	
	IF uo_template_selection.of_isDateRangeSelected() THEN
		
		CHOOSE CASE	messagebox("Auto Generation",&
			"Do you want your aggregate amount templates to calculate for the selected date range ? " + &
			"If you answer no then the aggregates will be by day.", Question!, YesNoCancel!)
		CASE 1
			//PROCESS WHOLE RANGE
			lb_WholeDateRange = TRUE
		CASE 2
			//BREAK OUT THE DAYS
			lb_WholeDateRange = FALSE
		CASE 3
			//RETURN
			li_Return = -1
		END CHOOSE
		
		IF li_Return = 1 THEN
			IF wf_SetItineraryRange (0, 0, lnv_Range ) > 0 THEN
				//Range was successfully set
				inv_TransactionManager.of_SetInitialItineraryRange(lnv_Range)
				setpointer(hourglass!)
				lnv_Payable.of_Generate(inv_Transaction, lnva_AmountTemplate, inv_itinerary, lnv_entity, inv_transactionmanager, &
												inv_dispatch, ll_NbrAmountOweds, lds_PeriodicUpdates)
				setpointer(hourglass!)
			END IF		
		END IF		
		
	ELSE
	
		SetPointer ( HourGlass! )
		IF li_Return = 1 THEN
			//generate payables for locked blocks 
			//
			/*
			If a block is selected then we can assume that there will be a 
			beginning and ending event to be used for setting the range 
			on the itinerary.
			*/
		
			ll_BlockCount = uo_Events.of_GetEventBlock(lnva_EventBlock) 
			
			FOR ll_Ndx = 1 to ll_BlockCount
				
				ll_Startrow = lnva_EventBlock[ll_Ndx].of_GetFirstSourceRow()
				ll_Endrow = lnva_EventBlock[ll_Ndx].of_GetLastSourceRow()

				ld_BlockStartDate = lnva_EventBlock[ll_Ndx].of_GetStartDate()
				ld_BlockEndDate = lnva_EventBlock[ll_Ndx].of_GetEndDate()
				IF wf_SetItineraryRange(ll_Startrow, ll_Endrow, lnv_Range) > 0 THEN
					//Range was successfully set
					inv_TransactionManager.of_SetInitialItineraryRange(lnv_Range)
					inv_TransactionManager.of_SetItineraryObject(inv_itinerary)
					setpointer(Hourglass!)
					ll_templatecount = upperbound(lnva_AmountTemplate)
					ll_TransactionID = inv_Transaction.of_GetId()
					for j = 1 to ll_templatecount
						
						/*
							I moved this into the loop becaus the range was not being calculated
							when multiple templates are being payed for the same block.
							
						*/
						wf_SetItineraryRange(ll_Startrow, ll_Endrow, lnv_Range)  
						//Range was successfully set
						inv_TransactionManager.of_SetInitialItineraryRange(lnv_Range)
						inv_TransactionManager.of_SetItineraryObject(inv_itinerary)
						
						
						
						lnva_processTemplate[1] = lnva_AmountTemplate[j]
						//if template is day or daterange
						CHOOSE CASE lnva_processTemplate[1].of_gettype()
							CASE 1	//point-to-point
								
								//get points
								ll_Origin = lnva_EventBlock[ll_Ndx].of_GetOriginId()
								ll_Destination = lnva_EventBlock[ll_Ndx].of_GetDestinationId()
								
								//check system setting
								n_cst_setting_PointtoPointPrompt	lnv_Setting							
								lnv_Setting = create n_cst_setting_PointtoPointPrompt
								IF lnv_Setting.of_Getvalue( ) = lnv_Setting.cs_Yes THEN
									if uo_Events.of_Getpoints( ll_origin, ll_Destination) = -1 then
										continue
									end if
								END IF								
								destroy lnv_Setting
								
								if ll_origin = 0 or ll_Destination = 0 then
									//prompt anyway
									if uo_Events.of_Getpoints( ll_origin, ll_Destination) = -1 then
										continue
									end if
								end if
									
								inv_itinerary.of_Geteventlist( lnva_Event )
								lnv_Payable.of_ProcessPointtoPoint(lnva_Event, inv_itinerary, inv_dispatch, &
											ll_origin, ll_destination, inv_transaction, inv_transactionmanager, lnva_processTemplate)
														
							CASE 2	//shipment
								lnv_Payable.of_ProcessShipmentPay(lnva_processTemplate, inv_itinerary, inv_dispatch, &
										ld_BlockStartDate, ld_BlockEndDate, inv_transaction, inv_transactionmanager, ll_NbrAmountOweds)
										
							CASE 3 //Move
								lstr_Parm.is_Label = "MOVE"
								lstr_Parm.ia_Value = lnva_processTemplate
								lnv_MsgOfTemplates.of_Add_Parm(lstr_Parm)

								lnv_Payable.of_SubdivideMove(inv_itinerary, lnv_MsgOfTemplates, inv_dispatch, &
	        						 inv_transaction, inv_transactionmanager, lnv_entity, ll_NbrAmountOweds, false/* search previous */)
										
							CASE 4, 5	//day, daterange
								lnv_Payable.of_ProcessInteractiveDayorDateRange(lnva_processTemplate, inv_itinerary, &
										inv_dispatch, ld_BlockStartDate, ld_BlockEndDate, inv_Transaction, inv_transactionmanager, ll_NbrAmountOweds)
														
							CASE 6	//Leg
								lnv_Payable.of_ProcessLeg(lnva_processTemplate, inv_itinerary, inv_dispatch, &
										ll_Startrow, ll_Endrow, inv_transaction, inv_transactionmanager, ll_NbrAmountOweds)
										
							CASE ELSE
								lnv_Payable.of_Generate(inv_Transaction, lnva_processTemplate, inv_itinerary, lnv_entity, inv_transactionmanager, &
									inv_dispatch, ll_NbrAmountOweds, lds_PeriodicUpdates)
							
						END CHOOSE
						//
						
					next
					
					setpointer(Hourglass!)
				END IF		
				

				lnv_Array.of_Destroy( lnva_Event  )
				inv_Itinerary.of_Reseteventlist( )
				
				
			NEXT
			
		END IF	
		
	END IF
	destroy lnv_Payable
END IF

IF li_Return = 1 THEN
	n_ds	lds_PaySplitCache	
	lds_PaySplitCache = inv_TransactionManager.of_GetPaySplitCache(TRUE)
	
	//save for scroll after refresh
	lnv_transaction = inv_transaction 
	
	IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE THEN
		tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.RefreshFromBcm()
		tab_TransactionManager.tabpage_Transactions.dw_TransactionDetail.inv_UILink.RefreshFromBcm()
	END IF
	
	//change instance transaction variable so tabs will know what transaction to filter by
	inv_Transaction = lnv_Transaction 
	
	tab_transactionmanager.Event ue_TransactionChanged(inv_Transaction)
	
	IF tab_transactionmanager.SelectedTab = ci_tabpage_unassignedamounts then
		
		IF tab_TransactionManager.tabpage_TransactionAmounts.PageCreated() = TRUE THEN
			tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.&
						SetFilter( "amountowed_fktransaction = " + string( inv_Transaction.Of_GetId() ) )
			tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.Filter( )
		END IF
	ELSE
//		tab_TransactionManager.SelectTab ( tab_TransactionManager.tabpage_TransactionAmounts )
	END IF
END IF



RETURN li_Return
end function

public subroutine wf_splitamountowed ();long	ll_row, &
		ll_rowcount
		
decimal	lc_amount, &
			lc_newamount
boolean	lb_taxable
n_cst_bso_TransactionManager	lnv_TransactionManager
n_cst_beo_AmountOwed				lnv_AmountOwed
n_cst_msg	lnv_msg
s_parm		lstr_parm

IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE AND &
	tab_transactionmanager.SelectedTab = ci_tabpage_amounts  THEN
	
	ll_row = tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.GetRow ( )

	IF ll_row > 0 THEN
		lc_amount = tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_amount[ll_row]
		if lc_amount > 0 then
			lstr_Parm.is_Label = "AMOUNT"
			lstr_Parm.ia_Value = lc_amount
			lnv_Msg.of_Add_Parm (lstr_Parm)
	
			OpenWithParm ( w_amountowedsplit, lnv_Msg  )
	
			lnv_Msg = message.powerobjectparm
			if isvalid(lnv_msg) then
				IF lnv_msg.of_Get_Parm ("CANCELLED", lstr_Parm ) <> 0 THEN
					//no split
				ELSE
					IF lnv_msg.of_Get_Parm ("AMOUNT", lstr_Parm ) <> 0 THEN
						lc_newamount = lstr_Parm.ia_Value 
						tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_amount[ll_row] = lc_newamount
						//Create unnassigned amount
						lnv_TransactionManager = tab_transactionmanager.wf_GetTransactionManager()
						if isvalid(lnv_TransactionManager) then
							lnv_AmountOwed = lnv_TransactionManager.of_NewAmountOwed ( )
							IF IsValid ( lnv_AmountOwed ) THEN
								long	ll_id
								string ls_find
								lnv_amountowed.of_Setamount(lc_amount - lc_newamount)
								lnv_amountowed.of_SetType(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_type[ll_row])
								if tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_taxable[ll_row] = 1 then
									lb_taxable = true
								else
									lb_taxable = false
								end if
								lnv_amountowed.of_SetTaxable(lb_taxable)
								lnv_amountowed.of_SetDivision(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_division[ll_row])
								lnv_amountowed.of_SetStartDate(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_startdate[ll_row])
								lnv_amountowed.of_SetEndDate(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_enddate[ll_row])
								lnv_amountowed.of_SetDescription(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_description[ll_row])
								lnv_amountowed.of_SetRatetype(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_ratetype[ll_row])
	//							lnv_amountowed.of_Setrate(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_Rate[ll_row])
	//							lnv_amountowed.of_SetQuantity(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.Amountowed_Quantity[ll_row])
								lnv_amountowed.of_SetStatus(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_status[ll_row])
								lnv_amountowed.of_Setref1type(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_ref1type[ll_row])
								lnv_amountowed.of_Setref1text(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_ref1text[ll_row])
								lnv_amountowed.of_Setref2type(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_ref2type[ll_row])
								lnv_amountowed.of_Setref2text(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_ref2text[ll_row])
								lnv_amountowed.of_Setref3type(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_ref3type[ll_row])
								lnv_amountowed.of_Setref3text(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_ref3text[ll_row])
								lnv_amountowed.of_SetInternalNote(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_internalnote[ll_row])
								lnv_amountowed.of_SetPublicNote(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_publicnote[ll_row])
								lnv_amountowed.of_SetDriver(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_driver[ll_row])
								lnv_amountowed.of_Settruck(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_truck[ll_row])
								lnv_amountowed.of_Settrailer(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_trailer[ll_row])
								lnv_amountowed.of_Setcontainer(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_container[ll_row])
								lnv_amountowed.of_Setshipment(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_shipment[ll_row])
								lnv_amountowed.of_Settrip(tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.object.amountowed_trip[ll_row])
					
								ll_id = lnv_AmountOwed.Of_GetId ( )
								IF ll_id > 0 THEN
									ll_rowcount = tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.rowcount()
									ls_find = "amountowed_id = " + string(ll_id)
									ll_row = tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.Find ( ls_find, 1, ll_rowcount )
								END IF
						
								IF ll_Row > 0 THEN 
									tab_TransactionManager.SelectTab ( tab_TransactionManager.tabpage_UnassignedAmounts )
									tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.SetFocus()
									tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.inv_UILink.RefreshFromBcm ( )
									tab_TransactionManager.tabpage_UnassignedAmounts.dw_AmountDetail.inv_UILink.RefreshFromBcm ( )
													
									tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.ScrollToRow ( ll_Row )
								END IF
								//update change
								lnv_AmountOwed = tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.inv_UILink.GetBeo ( tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.GetRow ( ) )
								if IsValid ( lnv_AmountOwed ) THEN
									lnv_AmountOwed.of_SetAmount ( lc_newamount )
									lnv_AmountOwed.of_Setrate ( 0 )
									lnv_AmountOwed.of_SetQuantity ( 0 )
									tab_TransactionManager.Event ue_TransactionChanged ( inv_transaction )
									tab_TransactionManager.tabpage_TransactionAmounts.dw_amountdetail.inv_UILink.UpdateRequestor ( tab_TransactionManager.tabpage_TransactionAmounts.dw_amountdetail.GetRow ( ) )
								end if
							END IF				
						end if
					end if
				end if
			else
				//don't replace 
			end if
		end if
	END IF
			
ELSE
	MessageBox ("Split Transaction Amount" , "Please be sure you are on the Transaction Amounts Tab.")
END IF
		
	

end subroutine

public subroutine wf_unassignedamountstatus ();if isvalid(inv_transactionmanager) then
	if isvalid(inv_transaction) then
		if inv_transactionmanager.of_unassignedamountcount(inv_transaction) > 0 then
			tab_TransactionManager.tabpage_UnassignedAmounts.TabTextColor = rgb(255,0,0)
		else
			tab_TransactionManager.tabpage_UnassignedAmounts.TabTextColor = rgb(0,0,0)
		end if
	end if
end if

end subroutine

private function integer wf_blockmixedfilters ();/*
	Get the locked blocks from uo_events.  Load the the calculation datastore one block at a
	time and apply the selected templates. Report any blocks that don't match the
	selected tempates.
*/

long	ll_ArrayCount, & 
		ll_BlockCount, &
		ll_ArrayMax, &
		ll_index, &
		ll_RowNdx, &
		ll_Newarray
		
integer	li_Return

string	lsa_Expression[], &
			lsa_Blank[], &
			ls_Condition, &
			ls_Filter
			
n_ds	lds_EventCache, &
		lds_BlockData
		
n_cst_EventBlock	lnva_EventBlock[], &
						lnva_shrinkblock[]
n_cst_beo_Event	lnv_Event


lnv_Event = CREATE n_cst_beo_Event

IF isvalid ( inv_Itinerary ) THEN
	//ok proceed
ELSE
	inv_Itinerary = CREATE n_cst_beo_Itinerary2
	//destroyed in close of window
END IF

lds_BlockData = CREATE n_ds
lds_BlockData.DataObject = "d_ItineraryData"
lds_EventCache = inv_Itinerary.of_GetEventCache ( )

IF IsValid ( lds_EventCache ) THEN

	lnv_Event.of_SetSource ( lds_EventCache )

	//loop for each event block
	ll_ArrayCount = uo_events.of_GetEventBlock ( lnva_EventBlock )
	
	FOR ll_BlockCount = 1 to ll_ArrayCount

		lds_BlockData.Reset()
		this.wf_LoadCalculationDatastore ( lnva_EventBlock[ll_BlockCount], lds_BlockData, lnv_Event)
		
		//get all selectionfilter expressions from all of the SELECTED templates
		lsa_Expression = lsa_Blank
		uo_template_selection.of_getSelectedSelectionFilter ( lsa_Expression )			
		ll_ArrayMax = upperbound(lsa_Expression)	
		//Load data points from the expressions 
		FOR ll_Index = 1 TO ll_ArrayMax
			
			lds_BlockData.Object.cf_Numeric.Expression = lsa_Expression[ ll_Index ]
			ls_Condition = lds_BlockData.GetItemString ( 1, "cf_Numeric" )
			IF upper(ls_Condition) = "TRUE" THEN
				//block matches filter 
								
			ELSE
				//does't match
				messagebox ( "Lock multiple blocks","Selected block does not match all of the selected templates.")
				//remove block from lnva_EventBLock
				uo_events.of_Removelock(TRUE, ll_Index)
				li_return = -1
				exit
			END IF
			if li_return < 0 then
				exit
			end if
		NEXT
	NEXT

END IF

DESTROY ( lnv_Event ) 

return li_return
end function

public subroutine wf_updatepaysplitcache ();long		ll_amountid, &
			ll_ndx, &
			ll_Paycount

integer	li_count, &
			li_ndx
			
string	ls_Filterstring			
			
decimal	lc_amounttosplit, &
			lc_amount, &
			lc_RunningTotal

n_cst_beo_amountowed	lnva_amount[]
n_ds		lds_PaySplitCache

lds_PaySplitCache = inv_TransactionManager.of_GetPaySplitCache(true)

//may have been deleted
if isvalid(inv_transaction) then
	li_count = inv_transaction.of_GetAmountslist(lnva_Amount)
end if

for li_ndx = 1 to li_count
	
	ll_amountid = lnva_amount[li_ndx].of_GetId()
	lc_amounttosplit = lnva_amount[li_ndx].of_Getamount()

	ls_FilterString = "amountid = " + string(ll_amountid)	
	lds_PaySplitCache.SetFilter(ls_FilterString)
	lds_PaySplitCache.filter()
	ll_PayCount = lds_PaySplitCache.rowcount()

	lc_Amount = 0
	lc_RunningTotal = 0
	
	for ll_ndx = 1 to ll_PayCount

		IF ll_ndx = ll_PayCount THEN
			lc_Amount = lc_amounttosplit - lc_RunningTotal
		ELSE
			IF Abs ( lc_RunningTotal + lc_Amount ) > Abs ( lc_amounttosplit ) THEN
				lc_Amount = lc_amounttosplit - lc_RunningTotal
			END IF
		END IF
	
		IF lc_Amount <> 0 THEN
			
			lds_PaySplitCache.object.paysplit[ll_ndx] = lc_Amount
			
			lc_RunningTotal += lc_Amount

		END IF

	next

	
next

end subroutine

public function long wf_loadinteractivedata (boolean ab_refresh);Date	ld_NullDate

Integer	li_Result, &
			li_RouteType

long	lla_Id[], &
		lla_AmountId[], &
		ll_LastRow, &
		ll_FirstRow, &
		al_CurrentEvent, &
		ll_Return = 1
			
boolean	lb_routetype

n_ds			lds_EventCache
	
s_Anys					lstr_Result
s_Parm					lstr_Parm
n_cst_Msg				lnv_Msg, &
							lnv_Range
n_cst_events			lnv_events

n_cst_beo_transaction	lnv_Transaction

setnull(ld_nulldate)
setnull(id_start)
setnull(id_end)

lstr_Parm.is_Label = "OPTIONAL"
lstr_Parm.ia_Value = "FALSE"
lnv_msg.of_add_Parm ( lstr_Parm )

this.setredraw(false)

al_CurrentEvent = il_CurrentEvent
//check selected transaction row for date range
IF isvalid ( inv_transaction ) THEN
	
	lla_id [1] = inv_Transaction.Of_GetId ( )
	il_interactivetransactionid = lla_id[1]
	id_start = inv_Transaction.Of_GetStartDate ( )
	id_end = inv_Transaction.Of_GetEndDate ( )
	lnv_transaction = inv_transaction
end if	

if isnull(id_start) and isnull(id_end) then
	//if no date range then open date range window
	OpenWithParm ( w_Date_Range, lnv_Msg )
	
	lstr_result = message.powerobjectparm
	li_result = lstr_result.anys[1]
	
	IF li_result = 1 THEN
		id_Start = lstr_result.anys[2]
		id_End = lstr_result.anys[3]
		
	else
		ll_return = -1
	end if	
end if

IF ll_return = 1 THEN

	if inv_transactionmanager.of_GetRouteTypeSettlements(li_RouteType) = 1 then
		lb_routetype = true
	end if
	
	
	ii_itinerarytype = gc_Dispatch.ci_ItinType_Driver
	
	//doing this temporarily
	il_EntityId = inv_TransactionManager.of_GetDefaultEntityId ()
	
	SELECT fkEmployee INTO :il_ItineraryId FROM Entity WHERE Id = :il_EntityId ;
	
	COMMIT ;
	
	//Create the dispatch manager and get the itineraries for the selected range
	if isvalid(inv_Dispatch) then
		DESTROY (inv_Dispatch)
	end if

	inv_Dispatch = CREATE n_cst_bso_Dispatch
	
	IF not isnull ( il_ItineraryId ) THEN
	
		IF inv_Dispatch.of_RetrieveItinerary (ii_itinerarytype, il_ItineraryId, RelativeDate ( id_Start, -7 ), id_End, TRUE /*NeedsPrior*/ ) < 0 THEN
			//
		ELSE
			inv_Dispatch.of_FilterItinerary (ii_itinerarytype, il_ItineraryId, ld_nulldate, ld_nulldate )	
		END IF
	
	END IF

	
	IF isvalid ( inv_Dispatch ) THEN
		
//		inv_Dispatch.of_ResetTimes ( 'ITIN!', ld_NullDate )

		if lb_routetype then
			lds_eventcache = inv_Dispatch.of_GetEventCache ( )
			lnv_Events.of_ResetTimes ( lds_eventcache, 'ITIN!', ld_NullDate, li_RouteType )	
			inv_Dispatch.of_SetEventCache (lds_eventcache)
		end if
		
		IF isvalid ( inv_Itinerary ) THEN
			//ok proceed
		ELSE
			inv_Itinerary = CREATE n_cst_beo_Itinerary2
			//destroyed in close of window
		END IF

		inv_Itinerary.of_SetDispatchManager ( inv_Dispatch )
		
		lnv_Range.of_Reset ( )
		
		lstr_Parm.is_Label = "StartDate"
		lstr_Parm.ia_Value = id_Start
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "EndDate"
		lstr_Parm.ia_Value = id_End
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		//routetype
		if lb_routetype then
			inv_itinerary.of_SetRouteType(li_RouteType)
		end if
		
		lstr_Parm.is_Label = "ItinType"
		lstr_Parm.ia_Value = ii_itinerarytype
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ItinId"
		lstr_Parm.ia_Value = il_itineraryid
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		inv_Itinerary.of_SetRange ( lnv_Range )
		
		if inv_itinerary.of_geteventcount() > 0 then
			//we have events
			uo_Events.of_SetItinerary ( inv_Itinerary ) 
			uo_Events.of_SetEventDisplay ( ) 
			
			// set paysplit column
			lnv_transaction.of_GetAmountsList(lla_amountid)
			uo_events.of_SetPaySplitColumn(inv_TransactionManager, lla_amountid)
			uo_events.of_SetAccessorialindicator(inv_TransactionManager, lla_amountid)
			uo_events.of_Seteventcounts( )

			if ab_refresh then
				//don't want window to jump
				uo_events.post of_SetEventRow(al_CurrentEvent)
			else
				uo_events.dw_list.setfocus()
				//start in single lock mode
				uo_Events.of_SetMultiModeLock ( FALSE )
				uo_template_selection.of_SetEntityId( il_EntityId )
				uo_template_selection.of_DisableControls()
				uo_template_selection.of_Initialize()
			end if

		else
			messagebox("Date Range", "There are no events in the selected date range.")
			ll_Return = -1
		end if
	END IF
	
ELSE
	
	ll_Return = -1
	
END IF

if ll_return = 1 then
	if lla_id [1] > 0 then 
		//have transaction
	else
		lnv_Transaction = inv_transactionmanager.of_NewTransaction ( )	
				lnv_Transaction.of_SetStartDate ( id_Start )
		lnv_Transaction.of_SetEndDate ( id_End )

	end if
	
	IF IsValid ( lnv_Transaction ) THEN
		inv_Transaction = lnv_Transaction	
	ELSE
		ll_Return = -1
	END IF
	
end if

this.setredraw(true)

return ll_Return
end function

public function integer wf_oldtoolmenu ();s_toolmenu lstr_toolmenu
n_cst_privileges	lnv_Privileges

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)

inv_ToolmenuManager.of_add_standard("SAVE!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "GOTO!"
lstr_toolmenu.s_toolbutton_picture = "list.bmp"
lstr_toolmenu.s_toolbutton_text = "GO TO..."
lstr_toolmenu.s_menuitem_text = "&Go To..."
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "NEW!"
lstr_toolmenu.s_toolbutton_picture = "gridnew1.bmp"
lstr_toolmenu.s_toolbutton_text = "NEW"
lstr_toolmenu.s_menuitem_text = "&New"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "DELETE!"
lstr_toolmenu.s_toolbutton_picture = "griddel1.bmp"
lstr_toolmenu.s_toolbutton_text = "DELETE"
lstr_toolmenu.s_menuitem_text = "&Delete"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "CLOSETRANSACTION!"
//lstr_toolmenu.s_toolbutton_picture = "??"
//lstr_toolmenu.s_toolbutton_text = "CLOSE TRNS."
lstr_toolmenu.s_menuitem_text = "Clos&e Transaction"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "CLOSEBATCH!"
//lstr_toolmenu.s_toolbutton_picture = "??"
//lstr_toolmenu.s_toolbutton_text = "CLOSE TRNS."
lstr_toolmenu.s_menuitem_text = "Close Ba&tch "
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "PRINTTRANSACTION!"
//lstr_toolmenu.s_toolbutton_picture = "??"
//lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
lstr_toolmenu.s_menuitem_text = "&Print Transaction"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "PRINTBATCH!"
//lstr_toolmenu.s_toolbutton_picture = "??"
//lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
lstr_toolmenu.s_menuitem_text = "P&rint Batch"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "EXPORTBATCH!"
//lstr_toolmenu.s_toolbutton_picture = "export.bmp"
//lstr_toolmenu.s_toolbutton_text = "Export Batch"
lstr_toolmenu.s_menuitem_text = "E&xport Batch"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

IF lnv_Privileges.of_HasSysAdminRights ( ) THEN
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "MARKBATCHED!"
	//lstr_toolmenu.s_toolbutton_picture = "export.bmp"
	//lstr_toolmenu.s_toolbutton_text = "Export Batch"
	lstr_toolmenu.s_menuitem_text = "Mark as &Batched"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "MARKUNBATCHED!"
	//lstr_toolmenu.s_toolbutton_picture = "export.bmp"
	//lstr_toolmenu.s_toolbutton_text = "Export Batch"
	lstr_toolmenu.s_menuitem_text = "Mar&k as Unbatched"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
END IF


inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "AUTOASSIGN!"
lstr_toolmenu.s_toolbutton_picture = "lbolt1.bmp"
lstr_toolmenu.s_toolbutton_text = "AUTOASSIGN"
lstr_toolmenu.s_menuitem_text = "Aut&o-Assign"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "ASSIGN!"
lstr_toolmenu.s_toolbutton_picture = "brokassn.bmp"
lstr_toolmenu.s_toolbutton_text = "ASSIGN"
lstr_toolmenu.s_menuitem_text = "&Assign"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "UNASSIGN!"
lstr_toolmenu.s_toolbutton_picture = "brokunas.bmp"
lstr_toolmenu.s_toolbutton_text = "UNASSIGN"
lstr_toolmenu.s_menuitem_text = "&Unassign"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)


inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "AMOUNTTEMPLATES!"
//lstr_toolmenu.s_toolbutton_picture = "??"
//lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
lstr_toolmenu.s_menuitem_text = "Pa&yables Setup"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

//don't allow this from this window, can only autogen from batchmanager
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//lstr_toolmenu.s_name = "AUTOGENERATE!"
////lstr_toolmenu.s_toolbutton_picture = "??"
////lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
//lstr_toolmenu.s_menuitem_text = "Auto-Generate Settle&ment"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "ITINERARY!"
lstr_toolmenu.s_toolbutton_picture = "itin.bmp"
lstr_toolmenu.s_toolbutton_text = "ITINERARY"
lstr_toolmenu.s_menuitem_text = "&Itinerary (for Selected Item)"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1
end function

public subroutine wf_old_process_request (string as_request);SetPointer(HourGlass!)
long 			ll_row
n_cst_Msg	lnv_msg
S_parm		lstr_Parm
n_cst_beo_Transaction	lnv_Transaction

IF ib_InteractiveMode THEN
	messagebox("Transaction Manager", "This option is not available in the interactive settlements window.")
ELSE
	CHOOSE CASE as_Request
	
	CASE "SAVE!"
		PostEvent ( "pfc_Save" )
		
	CASE "GOTO!"
		//messagebox to save current work and clear window
		//for new selection
		//open transaction selection window
		Int	li_Rtn
		Int		li_selectedTab
		Boolean	lb_Continue = TRUE
	
		
		
		S_transaction_Selection lstr_transaction_selection
		li_SelectedTab = tab_TransactionManager.selectedTab  
		
		IF THIS.wf_AcceptText ( li_SelectedTab ) <> 0 THEN 
			lb_Continue = FALSE
		END IF
		
		//	Request a lock for user
		n_cst_LicenseManager lnv_LicenseManager 
		IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Settlements, "E" ) < 0 THEN
			lb_Continue = FALSE
		END IF
		
		IF lb_Continue THEN
			lstr_Parm.is_Label = "S_TRANSACTION_SELECTION"
			lstr_Parm.ia_Value = istr_transaction
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			OpenWithParm ( w_transaction_Selection , lnv_msg )
			
			lnv_msg = message.powerobjectParm
			IF isValid ( lnv_Msg ) THEN
				IF lnv_Msg.of_Get_Parm ( "S_TRANSACTION_SELECTION", lstr_Parm ) <> 0 THEN
					lstr_Transaction_Selection = lstr_parm.ia_Value
					IF isValid ( lstr_Transaction_Selection ) THEN
						istr_transaction = lstr_Transaction_Selection
						li_Rtn = THIS.wf_LoadTransactions ( lnv_Msg )
					END IF
				END IF
			END IF
			IF li_Rtn = -1 THEN
				MessageBox("Loading Transactions" , "An error occurred while attempting to load the selected transations.")
			END IF
			
		END IF
		
	CASE "NEW!"
		//Event ue_new ( )
		PostEvent ( "ue_new" )
		
	CASE "DELETE!"
		CHOOSE CASE tab_transactionmanager.SelectedTab
		
		CASE ci_tabpage_transactions
			
			IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.RowCount ( ) > 0 THEN
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.Event Post pfc_DeleteRow ( )
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.Function Post SetFocus ( )
			END IF
			
		CASE ci_tabpage_amounts
			
			IF tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.RowCount( ) > 0 THEN
				tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.Event Post pfc_DeleteRow ( )
				tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.Function Post SetFocus ( )
			END IF
			
		CASE ci_tabpage_unassignedamounts
			
			IF tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.RowCount ( ) > 0 THEN
				tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.Event Post pfc_DeleteRow ( )
				tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.Function Post SetFocus ( )
			END IF
			
		END CHOOSE
	
	CASE "PRINTTRANSACTION!"
		IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE AND &
			tab_transactionmanager.SelectedTab = ci_tabpage_transactions THEN
			
			ll_row = wf_GetCurrentTransactionRow ( inv_Transaction )
			IF ll_row > 0 THEN
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetRow ( ll_row )
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.Event ue_PrintTransaction ( )
			END IF
		ELSE
			MessageBox ("Print Transaction" , "Please be sure you are on the Transactions Tab before attempting to print the transaction.")
		END IF
		
	CASE "PRINTBATCH!"
		IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE AND & 
			tab_transactionmanager.SelectedTab = ci_tabpage_transactions THEN
			
			IF ib_Batchable THEN
				IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE THEN
					wf_PrintBatch ( )
				END IF
			ELSEIF MessageBox ("Print Batch" , "You must load an entire batch from the transaction selection window before you can perform this operation.~n~rDo you want to open the transaction selection window now?",QUESTION!, YESNO! , 1) = 1 THEN
				wf_Process_Request ("GOTO!")
			END IF
		ELSE
			
			MessageBox ("Print Batch" , "Please be sure you are on the Transactions Tab before attempting to print the batch.")
		END IF
		
	CASE "CLOSETRANSACTION!"
		IF wf_AcceptText ( tab_TransactionManager.SelectedTab ) = -1 THEN
			return
		END IF
		
		IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE AND &
			 tab_transactionmanager.SelectedTab = ci_tabpage_transactions THEN
			
			ll_row = wf_GetCurrentTransactionRow ( inv_Transaction )
			IF ll_row > 0 THEN
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetRow ( ll_row )
				IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.Event ue_CloseTransaction ( ) = 1 THEN
					IF MessageBox ( "Close Transactions", "Do you want to print the transaction now?", &
						Question!, YesNo!, 1 ) = 1 THEN
						IF IsValid ( tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink ) THEN
							lnv_Transaction = tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.GetBeo ( ll_row )	
							lnv_Transaction.of_Print ( )
						END IF
					END IF
					wf_Refresh ( tab_TransactionManager.SelectedTab ) 
				END IF
			END IF
		ELSE
			MessageBox ("Close Transaction" , "Please be sure you are on the Transactions Tab before attempting to close the transaction.")
		END IF
		
		
		
	CASE "CLOSEBATCH!"
		IF wf_AcceptText ( tab_TransactionManager.SelectedTab ) = -1 THEN
			return
		END IF
		
		IF ib_Batchable THEN
			
			IF tab_TransactionManager.tabpage_Transactions.PageCreated() = TRUE AND &
				tab_transactionmanager.SelectedTab = ci_tabpage_transactions THEN
				wf_CloseBatch ( )
			ELSE
				MessageBox ("Close Batch" , "Please be sure you are on the Transactions Tab before attempting to close the batch.")
			END IF
			
		ELSEIF MessageBox ("Close Batch" , "You must load an entire batch from the transaction selection window before you can perform this operation. ~n~rDo you want to open the transaction selection window now?",QUESTION!, YESNO! , 1) = 1 THEN
			THIS.wf_Process_Request ( "GOTO!" )
		END IF
	
		
	CASE "ASSIGN!"
		PostEvent ( "ue_Assign" )
	
	CASE "UNASSIGN!"
		PostEvent ( "ue_Unassign" )
	
	CASE "AUTOASSIGN!"
		CHOOSE CASE this.Event ue_autoAssign ( )
		CASE -1
			messagebox ( "Auto Assign", "No amounts were assigned to the selected transaction. ", Information! )
		CASE 0
			//NOT ON THE UNASSIGNED AMOUNT TAB
		CASE ELSE
			//REFRESH and go to amounts tab if not already there
			IF tab_TransactionManager.tabpage_TransactionAmounts.PageCreated() = TRUE THEN
				tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.inv_UILink.RefreshFromBcm ( )
			END IF
			tab_TransactionManager.SelectTab ( tab_TransactionManager.tabpage_TransactionAmounts )
		END CHOOSE
	
	CASE "AMOUNTTEMPLATES!"
		This.wf_AmountTemplates ( )
	
//don't allow this from this window, can only autogen from batchmanager
//	CASE "AUTOGENERATE!"
//		This.wf_AutoGenerateTransaction ( )
	
	CASE "ITINERARY!"
		This.Event pfc_MessageRouter ( "ue_Itinerary" )
		
	CASE "EXPORTBATCH!"
		
		String	ls_Title = "Batch Selection"
		String	ls_Message = "Please select the batch you wish to export."
		String	ls_ButtonSet = "OKCANCEL!"
		String  	ls_DefaultBatch 
		IF IsValid ( inv_transactionmanager ) THEN
	//		CHOOSE CASE inv_transactionmanager.of_BatchDialog ( ls_title , ls_Message, ls_ButtonSet, ls_DefaultBatch ) 
	//			CASE 1 // success w/ a batch number
	//				IF Not IsNull (ls_DefaultBatch) THEN
	//				// export the batch
					
						PostEvent ( "ue_Exportbatch" )
	//				END IF
	//			CASE 0 // user canceled
	//				
	//			CASE -1 // error
	//		END CHOOSE
	//			
				
		END IF
		
	CASE "MARKBATCHED!"
		
		IF tab_TransactionManager.tabpage_Transactions.PageCreated ( ) THEN
			IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( 0 ) = 0 THEN
				// no selected row so use the current
				ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetRow ( )
				IF ll_Row > 0 THEN
					lnv_Transaction = tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
					IF IsValid ( lnv_Transaction ) THEN
						lnv_Transaction.of_SetBatched ( true )
						tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
					END IF
				END IF
				
			ELSE
				DO
					ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( ll_Row )
					lnv_Transaction	= tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
					IF IsValid ( lnv_Transaction ) THEN
						lnv_Transaction.of_SetBatched ( true )
						tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
					END IF
					//Batch Selected transaction 
				LOOP UNTIL ll_Row = 0
			END IF
			
		END IF
		
	CASE "MARKUNBATCHED!"
		IF tab_TransactionManager.tabpage_Transactions.PageCreated ( ) THEN
		
			IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( 0 ) = 0 THEN
				// no selected row so use the current
				ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetRow ( )
				IF ll_Row > 0 THEN
					lnv_Transaction = tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
					IF IsValid ( lnv_Transaction ) THEN
						lnv_Transaction.of_SetBatched ( FALSE )
						tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
					END IF
				END IF
				
			ELSE
				DO
					ll_Row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.GetSelectedRow ( ll_Row )
					lnv_Transaction	= tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UIlink.getBeo( ll_Row )
					IF IsValid ( lnv_Transaction ) THEN
						lnv_Transaction.of_SetBatched ( FALSE )
						tab_TransactionManager.tabpage_Transactions.dw_Transactions.inv_UILink.UpdateRequestor ( ll_Row )
					END IF
					//Batch Selected transaction 
				LOOP UNTIL ll_Row = 0
			END IF
		END IF
		
	END CHOOSE
END IF	
end subroutine

on w_transactionmanager.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.cb_interactiverefresh=create cb_interactiverefresh
this.dw_payable=create dw_payable
this.st_printing=create st_printing
this.cb_accept=create cb_accept
this.cb_reject=create cb_reject
this.gb_amount=create gb_amount
this.cb_generate=create cb_generate
this.uo_events=create uo_events
this.uo_template_selection=create uo_template_selection
this.tab_transactionmanager=create tab_transactionmanager
this.dw_1=create dw_1
this.cb_toggle=create cb_toggle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_interactiverefresh
this.Control[iCurrent+2]=this.dw_payable
this.Control[iCurrent+3]=this.st_printing
this.Control[iCurrent+4]=this.cb_accept
this.Control[iCurrent+5]=this.cb_reject
this.Control[iCurrent+6]=this.gb_amount
this.Control[iCurrent+7]=this.cb_generate
this.Control[iCurrent+8]=this.uo_events
this.Control[iCurrent+9]=this.uo_template_selection
this.Control[iCurrent+10]=this.tab_transactionmanager
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.cb_toggle
end on

on w_transactionmanager.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_interactiverefresh)
destroy(this.dw_payable)
destroy(this.st_printing)
destroy(this.cb_accept)
destroy(this.cb_reject)
destroy(this.gb_amount)
destroy(this.cb_generate)
destroy(this.uo_events)
destroy(this.uo_template_selection)
destroy(this.tab_transactionmanager)
destroy(this.dw_1)
destroy(this.cb_toggle)
end on

event open;call super::open;/*IF IsValid( Message.PowerObjectParm ) Then 
	If UPPER( Message.PowerObjectParm.ClassName ( ) ) = "N_CST_MSG" Then 
		inv_msg = Message.PowerObjectParm	
		ib_frombatchmanager = true
	End If
END IF

//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Settlements, "E" ) < 0 THEN
	ib_DisableCloseQuery = TRUE
	close (this)
	return
END IF

gf_Mask_Menu ( m_Sheets )

This.wf_CreateToolmenu ( )

inv_Itinerary = CREATE n_cst_beo_Itinerary2

s_Parm	lstr_Parm


IF inv_msg.of_Get_parm ( "TRANSACTIONMGR" , lstr_Parm ) > 0 THEN
	inv_Transactionmanager = lstr_Parm.ia_value
	ib_DestroyMgr = FALSE
END IF

IF Not IsValid ( inv_transactionmanager ) THEN
	ib_Destroymgr = TRUE
	inv_TransactionManager = CREATE n_cst_bso_TransactionManager
	
	inv_TransactionManager.of_SetDefaultCategory ( n_cst_Constants.ci_Category_Payables )
	inv_TransactionManager.of_SetNewRequiresEntity ( TRUE )
END IF

tab_TransactionManager.wf_SetTransactionManager ( inv_TransactionManager )

//@(data)(recreate=yes)<Parameters>
//@(data)--

//@(data)(recreate=yes)<Links>
//@(data)--

//@(data)(recreate=yes)<GenerationOptions>
of_SetResize(TRUE)
//@(data)--

//@(text)(recreate=yes)<RetrieveNoArgs>
//@(text)--

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )

//@(text)(recreate=no)<resizevalues>
inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (tab_transactionmanager, 'ScaleToRight&Bottom')
inv_resize.of_Register (uo_template_selection, 'FixedToBottom&ScaleToRight')
inv_resize.of_Register (dw_payable, 'FixedToBottom&ScaleToRight')
//inv_resize.of_Register (uo_events, 'FixedToBottom&ScaleToRight')
inv_resize.of_Register (uo_events, 'ScaleToRight&Bottom')
inv_resize.of_Register (cb_toggle, 'FixedToRight')
inv_resize.of_Register (cb_interactiveRefresh, 'FixedToRight')
inv_resize.of_Register (cb_generate, 'FixedToRight&Bottom')
inv_resize.of_Register (cb_reject, 'FixedToRight&Bottom')
inv_resize.of_Register (cb_accept, 'FixedToRight&Bottom')
inv_resize.of_Register (gb_amount, 'FixedToRight&Bottom')
//@(text)--

*/
IF IsValid( Message.PowerObjectParm ) Then 
	If UPPER( Message.PowerObjectParm.ClassName ( ) ) = "N_CST_MSG" Then 
		inv_msg = Message.PowerObjectParm	
		ib_frombatchmanager = true
	End If
END IF

//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Settlements, "E" ) < 0 THEN
	ib_DisableCloseQuery = TRUE
	close (this)
	return
END IF

gf_Mask_Menu ( m_Sheets )

This.wf_CreateToolmenu ( )

inv_Itinerary = CREATE n_cst_beo_Itinerary2

inv_TransactionManager = CREATE n_cst_bso_TransactionManager
inv_TransactionManager.of_SetDefaultCategory ( n_cst_Constants.ci_Category_Payables )
inv_TransactionManager.of_SetNewRequiresEntity ( TRUE )
tab_TransactionManager.wf_SetTransactionManager ( inv_TransactionManager )

//@(data)(recreate=yes)<Parameters>
//@(data)--

//@(data)(recreate=yes)<Links>
//@(data)--

//@(data)(recreate=yes)<GenerationOptions>
of_SetResize(TRUE)
//@(data)--

//@(text)(recreate=yes)<RetrieveNoArgs>
//@(text)--

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )

//@(text)(recreate=no)<resizevalues>
inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (tab_transactionmanager, 'ScaleToRight&Bottom')
inv_resize.of_Register (uo_template_selection, 'FixedToBottom&ScaleToRight')
inv_resize.of_Register (dw_payable, 'FixedToBottom&ScaleToRight')
//inv_resize.of_Register (uo_events, 'FixedToBottom&ScaleToRight')
inv_resize.of_Register (uo_events, 'ScaleToRight&Bottom')
inv_resize.of_Register (cb_toggle, 'FixedToRight')
inv_resize.of_Register (cb_interactiveRefresh, 'FixedToRight')
inv_resize.of_Register (cb_generate, 'FixedToRight&Bottom')
inv_resize.of_Register (cb_reject, 'FixedToRight&Bottom')
inv_resize.of_Register (cb_accept, 'FixedToRight&Bottom')
inv_resize.of_Register (gb_amount, 'FixedToRight&Bottom')
//@(text)--


end event

event close;call super::close;/*//Extending ancestor
IF ib_destroymgr THEN
	IF ISVALID ( inv_TransactionManager ) THEN
		DESTROY inv_TransactionManager
	END IF
END IF

IF ISVALID ( inv_Itinerary ) THEN
	DESTROY inv_Itinerary
END IF

if isvalid(inv_Dispatch) then
	DESTROY inv_Dispatch
end if

DESTROY inv_ToolmenuManager
RETURN AncestorReturnValue
*/
//Extending ancestor

IF ISVALID ( inv_TransactionManager ) THEN
	DESTROY inv_TransactionManager
END IF

IF ISVALID ( inv_Itinerary ) THEN
	DESTROY inv_Itinerary
END IF

if isvalid(inv_Dispatch) then
	DESTROY inv_Dispatch
end if

DESTROY inv_ToolmenuManager
RETURN AncestorReturnValue
end event

event pfc_save;//////////////////////////////////////////////////////////////////////////////
//
// OVERRIDING ANCESTOR SCRIPT
//
//	Event:  pfc_save
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	 0 = No pending changes found 
//	-1 = AcceptText error
//	-2 = UpdatesPending error was encountered
//	-3 = Validation error was encountered
// -9 = The pfc_updateprep process failed
//	-4 = The pfc_preupdate process failed
//	-5 = The pfc_begintran process failed
//	-6 = The pfc_update process failed
//	-7 = The pfc_endtran process failed
//	-8 = The pfc_postsave process failed
//
//	Description:
//	Performs a save operation on the window.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.02 Prevent datawindow dberror messages from appearing while the window
// 		PFC_Save is in progress.
// 6.0	Enhanced to allow updates of specific objects.
// 6.0	Enhanced for pfc_updateprep process.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


//Note:  PFC has this structured with in-code returns, so I'm going with that.

Integer		li_rc
Integer		li_save_rc
Integer		li_endtran_rc


IF NOT IsValid ( inv_TransactionManager ) THEN
	//TM not valid -- nothing to update
	RETURN 0  //(No pending changes)
END IF

//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Settlements, "S" ) < 0 THEN
	return -1
END IF


// Check if the CloseQuery process is in progress
If Not ib_closestatus Then
	
//	li_rc = of_UpdateChecks(lpo_updatearray)
	li_rc = of_UpdateChecks()  //Use this version instead.
	If li_rc <= 0 Then 
		//	 0 = No pending changes found 
		//	-1 = AcceptText error
		//	-2 = UpdatesPending error was encountered
		//	-3 = Validation error was encountered		
		Return li_rc
	End If

End If


// Prevent datawindow dberror messages from appearing while PFC_Save 
// updates are in progress. 
ib_savestatus = True				//??Should we still do this

// Update the changed objects.
//li_save_rc = This.Event pfc_Update (ipo_pendingupdates) 


//the amounts may have been changed so we need to redo the paysplit cache
this.wf_UpdatePaysplitCache()

li_save_rc = inv_TransactionManager.Event pt_Save ( )

// PFC_Save Updates are no longer in progress.
ib_savestatus = False			//??See above.

// PFC does this:
// If appropriate, display dberror message.
//If li_save_rc<=0 Then This.Event pfc_dberror()

// We'll do this:
// If appropriate, display an error message.
IF li_save_rc <= 0 THEN
	MessageBox ( "Save Changes", "Could not save changes to database.  One or more "+&
		"required fields (Type and Taxable on Amount) may not have been entered, or a "+&
		"save conflict or error may have ocurred.", Exclamation! )
END IF

// Check for a successful save before performing any post operation.
If li_save_rc <> 1 Then Return -6

//We made it -- return success.
Return 1
end event

event pfc_updatespendingref;//////////////////////////////////////////////////////////////////////////////
//
// OVERRIDING ANCESTOR
//
//	Event:  pfc_UpdatesPendingRef
//
//	Arguments:	
//	apo_control[]	The controls on which to perform functionality.
//	apo_pending[] (by ref) The controls which have updates pending.
//
//	Returns:  integer
//	 1 = updates are pending (no errors found)
//	 0 = No updates pending (no errors found)
//	-1 = error
//
//	Description:
//	Request the Logical Unit of Work service to determine which objects have
//	UpdatesPending. 
//
// Note:
//	Simulated Event overloading.
//	This event does NOT store the objects with updates pending in inv_pendingupdates.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

constant integer NO_UPDATESPENDING =0
Integer	li_rc, &
			li_updatespending_rc
PowerObject lpo_empty[]
PowerObject lpo_pending[]
powerobject lpo_updatearray[]

// Clear the pending by reference array.
apo_pending = lpo_empty

// Make sure there is something to take action on.
If UpperBound(apo_control) = 0 Then Return NO_UPDATESPENDING
If Not of_IsUpdateable() Then Return NO_UPDATESPENDING

// Let Logical Unit of Work Service perform the functionality (create if necessary).
//If IsNull(inv_luw) Or Not IsValid (inv_luw) Then of_SetLogicalUnitofWork(True)
//If IsValid(inv_luw) Then
//	li_rc = inv_luw.of_UpdatesPending(apo_control, lpo_pending)
//	apo_pending = lpo_pending
//	If li_rc > 0 Then li_rc = 1
//	Return li_rc
//End If


// Perform the Update Checks to determine if there are any updates 
// pending and if they pass the standard validation

//Check if there are any updates pending
li_updatespending_rc = inv_TransactionManager.Event pt_UpdatesPending ( )

CHOOSE CASE li_UpdatesPending_rc

CASE 1  //Updates are pending
	//??Should we set apo_pending to anything??
	li_rc = 1

CASE 0  //No updates pending
	li_rc = 0

CASE ELSE //-1
	li_rc = -1

END CHOOSE


Return li_rc
end event

event pfc_postopen;Int	li_Rtn
boolean	lb_closing

n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

if ib_frombatchmanager then
	IF inv_msg.of_Get_Parm ( "INTERACTIVE" , lstr_Parm ) <> 0 THEN
		this.SetReDraw(false)
	end if

	//don't open response an entity was passed in
	li_Rtn = THIS.wf_LoadTransactions ( inv_Msg )
	ib_frombatchmanager = false
	IF inv_msg.of_Get_Parm ( "INTERACTIVE" , lstr_Parm ) <> 0 THEN
		cb_toggle.event clicked()
		this.SetReDraw(true)
	end if
else
	open ( w_Transaction_selection )
	lnv_Msg = message.powerobjectParm
	If IsValid (Lnv_Msg ) THEN
		li_Rtn = THIS.wf_LoadTransactions ( lnv_Msg )
	//	uo_events.event ue_showitems(FALSE)
	ELSE
		// user canceled 
		lb_closing = true
		CLOSE ( THIS )
	END IF
end if

IF li_Rtn = -1 THEN
	MessageBox("Loading Transactions" , "An error occurred while attempting to load the selected transactions.")
else
	if lb_closing then
		//skip
	else
		this.post wf_unassignedamountstatus()
	end if
END IF

end event

type cb_interactiverefresh from commandbutton within w_transactionmanager
boolean visible = false
integer x = 3205
integer y = 152
integer width = 343
integer height = 92
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Re&fresh"
end type

event clicked;n_cst_eventblock	lnva_EventBlock[]

if uo_Events.of_GetEventBlock(lnva_EventBlock) > 0 then
	
	messagebox('Interactive Refresh', 'Refresh not allowed if there are locked block(s)')
	
else
	
	IF parent.wf_LoadInteractiveData ( TRUE ) > 0 THEN
		ib_InteractiveLoaded = TRUE			
	END IF							

end if
end event

type dw_payable from u_dw_amountowedlist within w_transactionmanager
boolean visible = false
integer x = 9
integer y = 1336
integer width = 3127
integer taborder = 20
end type

type st_printing from u_st within w_transactionmanager
boolean visible = false
integer x = 2112
integer y = 180
integer width = 1408
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 128
string text = "Closing Transaction 0 of 9999 "
alignment alignment = right!
end type

type cb_accept from commandbutton within w_transactionmanager
boolean visible = false
integer x = 3205
integer y = 1076
integer width = 343
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Accept"
end type

event clicked;long	lla_Id[]

// set paysplit column
inv_TransactionManager.of_GetNewAmountIdList(lla_Id)

//the amounts may have been changed so we need to redo the paysplit cache
parent.wf_UpdatePaysplitCache()

uo_events.of_SetPaySplitColumn(inv_TransactionManager, lla_Id)
uo_events.of_SetAccessorialindicator(inv_TransactionManager, lla_Id)

//amounts accepted, go ahead and save
inv_TransactionManager.event pt_save()

uo_Events.of_ProcessBlock()

dw_payable.Visible = FALSE
uo_template_selection.Visible = TRUE
this.enabled = FALSE
cb_reject.enabled = FALSE
cb_toggle.enabled = TRUE
cb_generate.enabled = TRUE
cb_interactiverefresh.enabled = TRUE
uo_events.enabled = TRUE
ib_RefreshTab = TRUE
//	clear blocks
uo_events.of_ClearEventblock() 
uo_template_selection.of_ResetSelected()
uo_template_selection.of_ResetManualOptions()
uo_events.of_SetMultiModeLock(FALSE)
uo_Events.of_NextAvailableBlock()



end event

type cb_reject from commandbutton within w_transactionmanager
boolean visible = false
integer x = 3205
integer y = 1196
integer width = 343
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Reject"
end type

event clicked;long	lla_Id[], &
		ll_row, &
		ll_rowcount

dw_payable.Visible = FALSE

ll_rowcount = dw_payable.rowcount()
for ll_row = 1 to ll_rowcount
	dw_payable.Event pfc_DeleteRow ( )
next

//When toggling back to the tab object, the toggle button will force the 
//changes to be reflected.
ib_RefreshTab = TRUE

uo_template_selection.Visible = TRUE
cb_accept.enabled = FALSE
this.enabled = FALSE
uo_events.of_LockFeature ( TRUE )
cb_toggle.enabled = TRUE
cb_generate.enabled = TRUE
cb_interactiverefresh.enabled = TRUE
uo_events.enabled = TRUE
uo_template_selection.of_ResetSelected()
uo_template_selection.of_ResetManualOptions()
 
IF uo_Events.of_GetMultiModeLock () THEN
	uo_Events.of_ProcessBlock()
	uo_events.of_ClearEventblock() 
	uo_events.of_SetMultiModeLock(FALSE)
END IF


uo_Events.of_EnableControls ( )

end event

type gb_amount from groupbox within w_transactionmanager
boolean visible = false
integer x = 3159
integer y = 852
integer width = 421
integer height = 492
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Amount(s)"
end type

type cb_generate from commandbutton within w_transactionmanager
boolean visible = false
integer x = 3205
integer y = 956
integer width = 343
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Generate"
end type

event clicked;
//generate payables for selected block of events using the selected templates

long	ll_Return, &
		ll_Ndx, &
		ll_BlockCount, &
		ll_FirstEventId, &
		ll_LastEventId, &
		ll_Start, &
		ll_End, &
		lla_Id[]

string	ls_IdList

decimal	lc_Amount

date	ld_BlockStartDate, &
		ld_BlockEndDate
		
boolean	lb_Manual

n_cst_String		lnv_String
n_cst_EventBlock	lnva_EventBlock[]

//Has a block been locked?

IF uo_Events.of_IsBlockLocked() THEN
	//continue  
ELSE
	messagebox ( "Generate Amounts", "You must lock a block before you can Generate amounts for the selected templates.")
	ll_Return = -1
END IF

IF ll_Return = 0 THEN
	IF uo_Template_selection.of_IsManualOptionSelected ( ) THEN
		lc_Amount = uo_Template_selection.of_GetManualAmount ( )
		IF lc_Amount = 0 THEN
			messagebox ( "Generation", "The manual amount option has been selected but no amount has been entered. " + &
							"Please enter an amount." )
			ll_Return = -1
		ELSE
			lb_Manual = TRUE
		END IF
	ELSE
		IF uo_Template_selection.of_IsAutoOptionSelected() THEN
			//Have templates been selected?
			IF uo_template_selection.of_GetSelectedTemplate(lla_Id) = 0 THEN
				IF uo_template_selection.of_GetAvailableId(lla_Id, FALSE) = 1 THEN
					//select template
					uo_template_selection.event ue_addtemplate(1)
				ELSE
					messagebox ( "Generate Amounts", "No templates have been selected.")
					ll_Return = -1
				END IF
			END IF
		ELSE
			//RADIO BUTTON BROKEN
		END IF
	END IF
END IF

IF ll_Return = 0 THEN

	IF parent.wf_BlockGeneration (lb_Manual) = 1 THEN	
		setpointer(hourglass!)
		dw_payable.SetTransactionManager(inv_TransactionManager)
		inv_TransactionManager.of_GetNewAmountIdList(lla_Id)
		lnv_String.of_ArrayToString(lla_Id, ',', ls_IdList) 
		if len(ls_idlist) > 0 then
			dw_payable.SetFilter( "amountowed_id in ( " + ls_IdList + ")" )
			dw_payable.Filter()
			cb_accept.post setfocus()
		else
			//no list
			dw_payable.SetFilter( "amountowed_id in (0)" )
			dw_payable.Filter()
			cb_reject.post setfocus()
		end if
		dw_payable.triggerevent("task_retrieve")
		
		this.enabled = FALSE
		uo_events.of_LockFeature(FALSE)
		dw_payable.Visible = TRUE
		cb_accept.enabled = TRUE
		cb_reject.enabled = TRUE
		uo_template_selection.Visible = FALSE
		cb_toggle.enabled = FALSE
		cb_interactiverefresh.enabled = FALSE
		uo_events.enabled = FALSE
		cb_toggle.post SetPosition(ToTop!)
		uo_Events.of_DisableControls()
	END IF	
END IF

//If the generated amounts have been accepted then mark the blocks as processed


end event

type uo_events from u_event_bracketing within w_transactionmanager
event destroy ( )
boolean visible = false
integer width = 3154
integer height = 1956
integer taborder = 30
boolean border = false
end type

on uo_events.destroy
call u_event_bracketing::destroy
end on

event ue_lockblock;//get block(s) selected and apply the the selection filter

long	ll_BlockCount, &
		ll_Pos

string	ls_Title

n_cst_EventBlock	lnva_EventBlock[]

ll_BlockCount = of_GetEventBlock ( lnva_EventBlock )
IF uo_Events.of_IsBlockLocked ( ) THEN
	IF ll_BlockCount > 1 THEN
		//Warn if block does not fit selected templates
		if parent.wf_blockmixedfilters() = -1 then
			//don't disable
		else
			/*
				If in multimode then then template/amount selection is disabled.
				This is to control picking mixed block templates while selecting
				additional blocks.
			*/
			uo_template_selection.of_DisableControls ( )
		end if
	ELSE
		cb_generate.enabled = TRUE
		parent.wf_SetTemplateSelectionFilter ( )
		uo_template_selection.of_SetTemplateFilter(TRUE)	
		uo_template_selection.of_EnableControls ( )
		event ue_hideamounts( )
		event ue_showitems( false)
		this.EVENT POST ue_setfocus("AVAILABLE TEMPLATE")
	END IF
ELSE
	//unlocked a block
	CHOOSE CASE ll_BlockCount
		CASE 0
			uo_template_selection.of_DisableControls ( )
			uo_Template_Selection.of_Initialize()
			cb_generate.enabled = FALSE
		CASE IS > 0
			uo_template_selection.of_EnableControls ( )
			uo_template_selection.dw_templatetype.SetFocus ( )
		
	END CHOOSE
END IF
ls_Title = parent.title
IF uo_Events.of_GetMultiModeLock () THEN
	ll_Pos = Pos ( ls_Title, " (Single Block Lock Mode)" ,1 )
	IF ll_Pos > 0 THEN
		parent.title = Replace ( ls_Title, ll_Pos, len ( " (Single Block Lock Mode)" ) , " (Multi-Block Lock Mode)" )
	END IF
ELSE
	ll_Pos = Pos ( ls_Title, " (Multi-Block Lock Mode)" ,1 )
	IF ll_Pos > 0 THEN
		parent.title = Replace ( ls_Title, ll_Pos, len ( " (Multi-Block Lock Mode)" ) , " (Single Block Lock Mode)" )
	END IF
END IF


end event

event ue_showitems;IF ab_show THEN 
	uo_template_selection.visible=false
ELSE
	uo_template_selection.visible=true
END IF


end event

event ue_showamounts;call super::ue_showamounts;parent.event ue_showamounts(ala_event)
end event

event ue_hideamounts;call super::ue_hideamounts;parent.event ue_hideamounts()
end event

event ue_eventchanged;call super::ue_eventchanged;parent.event ue_eventchanged(ala_event)
end event

type uo_template_selection from u_template_selection within w_transactionmanager
event destroy ( )
boolean visible = false
integer x = 9
integer y = 1344
integer width = 3634
integer taborder = 40
boolean bringtotop = true
boolean border = false
end type

on uo_template_selection.destroy
call u_template_selection::destroy
end on

event ue_selected;long	ll_IdCount, &
		lla_Id[]
		
ll_IdCount = uo_template_selection.of_GetSelectedtemplate ( lla_Id )

IF uo_template_selection.of_IsManualOptionSelected ( ) THEN
	IF uo_template_selection.of_GetManualAmount ( ) > 0 THEN
		uo_events.of_SetMultiModeLock ( TRUE )
	END IF
ELSE
	IF uo_template_selection.of_IsAutoOptionSelected ( ) THEN
		IF ll_IdCount > 0 THEN
			uo_events.of_SetMultiModeLock ( TRUE )
		ELSE
			IF uo_events.of_GetMultiModeLock() THEN	
				//	If in multimode and more than one block locked then
				// warn user that all blocks will be unlocked
				uo_events.of_RemoveLock ( TRUE, 0 )
				uo_events.of_SetMultiModeLock ( FALSE )	
			END IF
		END IF
	END IF
END IF
end event

event ue_generate;call super::ue_generate;cb_generate.event clicked()
end event

event ue_gotfocus;call super::ue_gotfocus;parent.event ue_focus(as_what)
end event

type tab_transactionmanager from u_tab_transactionmanager within w_transactionmanager
string tag = ";objectid=[79307271|1563]"
integer x = 315
integer y = 176
integer width = 3264
integer height = 1816
integer taborder = 10
end type

on tab_transactionmanager.create
call u_tab_transactionmanager::create
end on

on tab_transactionmanager.destroy
call u_tab_transactionmanager::destroy
end on

event selectionchanged;SetPointer(HourGlass!)
string ls_find
long	lla_id [], &
		ll_row
		
ii_SaveTabIndex = newindex

this.SetRedraw ( false ) 

CHOOSE CASE newindex
		
CASE 1	//	tabpage_Transactions

	IF isvalid ( inv_Transaction ) THEN
		ll_row = wf_GetCurrentTransactionRow ( inv_Transaction )
//		lla_id [1] = inv_Transaction.Of_GetId ( )
//		IF lla_id [1] > 0 THEN
//			ls_find = "transaction_id = " + string(lla_id [1])
//			ll_row = tab_TransactionManager.tabpage_Transactions.dw_Transactions.Find &
//												( ls_find , &
//													1, &
//													tab_TransactionManager.tabpage_Transactions.dw_Transactions.RowCount() )
//		END IF	
		IF oldindex = 0 then
			tab_TransactionManager.tabpage_Transactions.TriggerEvent ("ue_refresh")
		ELSE
			IF ll_row > 0 THEN
				tab_TransactionManager.tabpage_Transactions.dw_transactions.inv_UILink.UpdateRequestor ( ll_row )	
				IF tab_TransactionManager.tabpage_Transactions.dw_transactiondetail.visible=TRUE THEN
					tab_TransactionManager.tabpage_Transactions.dw_transactiondetail.inv_UILink.UpdateRequestor ( tab_TransactionManager.tabpage_Transactions.dw_transactiondetail.GetRow () )	
				END IF
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.ScrollToRow ( ll_row )	
				tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetRow ( ll_row )
			END IF
		END IF
//		IF lla_id [1] > 0 THEN									
//			tab_TransactionManager.tabpage_Transactions.dw_Transactions.ScrollToRow ( ll_row )	
//			tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetRow ( ll_row )
//		END IF
	END IF

	tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetColumn ( "transaction_startdate" )
	tab_TransactionManager.tabpage_Transactions.dw_Transactions.SetFocus ( )
	
	cb_toggle.visible=true
	
CASE 2	//	tabpage_TransactionAmounts
	
	IF isvalid ( inv_transaction ) THEN
		
		lla_id [1] = inv_Transaction.Of_GetId ( )
		
		IF lla_id [1] > 0 THEN
			
			
			inv_TransactionManager = tab_TransactionManager.wf_GetTransactionManager ( )
			inv_TransactionManager.of_LoadTransactionAmounts ( lla_id )
			tab_TransactionManager.wf_SetTransactionManager ( inv_TransactionManager )
			tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.&
										SetFilter( "amountowed_fktransaction = " + string(lla_id [1]))

			tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.TriggerEvent ( "task_retrieve" )
			tab_TransactionManager.tabpage_TransactionAmounts.dw_AmountDetail.TriggerEvent ( "task_retrieve" )
	
		END IF
		
		tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.SetColumn ( "amountowed_startdate" )
		tab_TransactionManager.tabpage_TransactionAmounts.dw_Amounts.SetFocus ( )
		
	END IF
	
	cb_toggle.visible=false
	
CASE 3	//	tabpage_UnassignedAmounts
 
	IF isvalid ( inv_transaction ) THEN
		lla_id [1] = inv_Transaction.Of_GetfkEntity ( )
	ELSE	//	Entity from selection dialog
		lla_id [1] = istr_transaction.l_EntityId
	END IF
		
		IF lla_id [1] > 0 THEN
			
			inv_TransactionManager = tab_TransactionManager.wf_GetTransactionManager ( )
			
			inv_TransactionManager.of_LoadUnassignedAmounts ( lla_id [1] )
			
			tab_TransactionManager.wf_SetTransactionManager ( inv_TransactionManager )
			
			tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.&
										SetFilter( "isnull ( amountowed_fktransaction ) " + &
													  "and amountowed_fkentity = "+ &
													  string(lla_id [1]))		

			tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.TriggerEvent ( "task_retrieve" )
			tab_TransactionManager.tabpage_UnassignedAmounts.dw_AmountDetail.TriggerEvent ( "task_retrieve" )
	
		END IF
		
		tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.SetColumn ( "amountowed_startdate" )
		tab_TransactionManager.tabpage_UnassignedAmounts.dw_Amounts.SetFocus ( )
	
	cb_toggle.visible=false
	
END CHOOSE

this.SetRedraw ( true ) 


end event

event ue_transactionchanged;String	ls_Entity
Long		ll_ID, &
			ll_Pos
Dec 		ldec_Amount
String	ls_Amount

IF IsValid ( anv_beo_transaction ) THEN
	inv_Transaction = anv_beo_transaction
	
	ll_id = inv_transaction.of_GetfkEntity ( )
	IF IsValid (inv_transactionmanager) THEN
		ls_Entity = inv_transactionmanager.of_DescribeEntity ( ll_id , 1)
		ll_pos = pos ( ls_Entity, "~t", 1 )
		IF ll_pos > 0 THEN
			dw_1.Object.entity_name_t.text = "Entity (" + right ( ls_Entity , len ( ls_Entity ) - ll_Pos )  +")"
			//strip out type
			ls_Entity = left ( ls_Entity, ll_Pos - 1 )

		END IF
		
	END IF
	
	dw_1.object.entity_name [1] =  ls_Entity
	dw_1.object.transaction_id [1] = inv_Transaction.of_GetID ( )
	dw_1.object.startdate [1] = inv_transaction.of_GetStartDate ( )
	dw_1.object.enddate [1] = inv_transaction.of_GetEndDate ( )
	dw_1.object.pretaxnet [1] = inv_transaction.of_GetPreTaxNet ( )

	inv_transactionmanager.of_SetDefaultEntityId ( ll_id ) 
	
END IF


end event

event selectionchanging;SetPointer ( HourGlass! )
long	lla_id [], &
		ll_row

string	ls_find


IF oldindex > 0 THEN

	IF wf_AcceptText ( oldindex ) = -1 THEN
		RETURN 1
	END IF
	
	CHOOSE CASE newindex
		
	CASE 1
		
	CASE 2
		//IF THERE ARE NO TRANSACTIONS, THEN THERE ARE NO AMOUNTS
		IF tab_TransactionManager.tabpage_Transactions.dw_Transactions.Rowcount() = 0 THEN
			RETURN 1
		END IF

	CASE 3
		
	END CHOOSE

END IF
end event

event ue_transactionmodified;this.Event ue_transactionchanged ( inv_transaction )



end event

type dw_1 from datawindow within w_transactionmanager
integer x = 334
integer width = 3237
integer height = 148
string dataobject = "d_transaction_heading"
boolean border = false
boolean livescroll = true
end type

type cb_toggle from commandbutton within w_transactionmanager
integer x = 3205
integer y = 24
integer width = 343
integer height = 92
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "In&teractive"
end type

event clicked;long ll_return = 1

IF THIS.text = "&Txn Mgr"  THEN
	
	PARENT.SetReDraw(FALSE)

	THIS.text = "In&teractive"
	ib_InteractiveMode = FALSE
	
	//interactive objects
	uo_events.visible = FALSE
	uo_template_selection.visible = FALSE
	cb_generate.visible = FALSE
	cb_accept.visible = FALSE
	cb_reject.visible = FALSE
	cb_interactiveRefresh.visible = FALSE
	gb_amount.visible = FALSE
	
	//transaction manager objects
	dw_1.visible = TRUE
	tab_transactionmanager.visible = TRUE
	parent.title = is_OriginalTitle
	
	IF ib_RefreshTab THEN
		ib_RefreshTab = FALSE
		parent.tab_TransactionManager.SelectTab ( tab_TransactionManager.tabpage_Transactions )
		parent.tab_TransactionManager.SelectTab ( tab_TransactionManager.tabpage_TransactionAmounts )
	END IF
	
	inv_ToolmenuManager.of_Mask_ToolButtons(false)

	PARENT.SetReDraw(TRUE)

ELSE
	long	ll_id
	
	if isvalid(inv_transaction) then
		ll_id = inv_transaction.of_GetId()
	else
		ll_id = 0
	end if
	
	if isnull(ll_id) or ll_id = 0 then
		messagebox('Interactive','Please highlight a transaction.')
	else
		IF ib_InteractiveLoaded THEN
			if il_InteractiveTransactionID > 0 then
				if il_InteractiveTransactionID <> ll_id then
					choose case messagebox("Interactive", "Transaction " + string(il_InteractiveTransactionId) + &
						" is currently loaded in the Interactive window. Do you want to clear" + &
						" and load transaction " + string(ll_id) + "." + &
						" Previously generated amounts for transaction " + string(il_InteractiveTransactionId) + &
						" will not be lost",Question!, YesNoCancel!)
						case 1
							IF parent.wf_LoadInteractiveData ( FALSE ) > 0 THEN
								ib_InteractiveLoaded = TRUE	
								uo_events.of_ClearEventblock() 
								uo_events.of_SetMultiModeLock(FALSE)

							ELSE
								ll_return = -1
							END IF							
						case 2
							ib_InteractiveLoaded = true
						case 3
							ll_return = -1
					end choose
				end if
			end if
		else
			setpointer(HourGlass!)
			IF parent.wf_LoadInteractiveData ( FALSE ) > 0 THEN
				ib_InteractiveLoaded = TRUE			
			END IF							
		end if
			
		if ll_return = 1 then
			PARENT.SetReDraw(FALSE)
			
			//interactive objects
			IF ib_InteractiveLoaded THEN
				
				uo_events.visible = TRUE
				uo_template_selection.visible = TRUE
				gb_amount.visible = TRUE
				cb_generate.visible = TRUE
				cb_accept.visible = TRUE
				cb_reject.visible = TRUE
				cb_interactiveRefresh.visible = TRUE
				
				is_OriginalTitle = parent.Title
				parent.title = "Interactive Settlements for " + inv_Itinerary.of_GetItineraryFor() +&
								" Range from " + string ( id_Start ) + " to " + string ( id_End )
				IF uo_Events.of_GetMultiModeLock () THEN
					parent.title += " (Multi-Block Lock Mode)"
				ELSE
					parent.title += " (Single Block Lock Mode)"
				END IF
		
				//transaction manager objects
				dw_1.visible = FALSE
				tab_transactionmanager.visible = FALSE
			
				THIS.text = "&Txn Mgr"
				ib_InteractiveMode = TRUE
			
				inv_ToolmenuManager.of_Mask_ToolButtons(true)
				inv_ToolmenuManager.of_SetgroupboxTaborder( 0 )
							
//				uo_events.of_ClearEventblock() 
				uo_template_selection.of_ResetSelected()
				uo_template_selection.of_ResetManualOptions()
//				uo_events.of_SetMultiModeLock(FALSE)
			
			END IF
		
			
			PARENT.SetReDraw(TRUE)
			
		end if
	end if
END IF

cb_toggle.bringtotop=true

end event

