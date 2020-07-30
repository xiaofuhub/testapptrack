$PBExportHeader$u_dw_driversettlementist.sru
forward
global type u_dw_driversettlementist from u_dw
end type
end forward

global type u_dw_driversettlementist from u_dw
integer width = 3429
integer height = 1232
string dataobject = "d_driverlist"
boolean hscrollbar = true
boolean hsplitscroll = true
event type integer ue_closetransaction ( n_cst_beo_transaction anva_transaction[] )
event type integer ue_printtransaction ( n_cst_beo_transaction anva_transaction[] )
event type integer ue_markbatched ( boolean ab_set,  n_cst_beo_transaction anva_transaction[] )
event type integer ue_updatetransaction ( n_cst_beo_transaction anva_transaction[] )
event ue_deletetransaction ( readonly n_cst_beo_transaction anva_transaction[] )
event ue_statuschanged ( )
event type n_cst_bso_transactionmanager ue_gettransactionmanager ( )
event ue_entitychanged ( long al_value )
event ue_setunassigned ( )
event ue_processkey pbm_dwnkey
end type
global u_dw_driversettlementist u_dw_driversettlementist

forward prototypes
public function long of_getselectedtransaction (ref long ala_id[])
public function long of_getcurrenttransactionid ()
end prototypes

event ue_closetransaction;string	ls_message, &
			ls_fn, &
			ls_ln
Long		ll_ndx, &
			ll_id, &
			ll_count, &
			ll_row, &
			ll_RowCount 
			
Integer	li_Return

Constant String	ls_MessageHeader = "Close Transaction"

li_Return = FAILURE

ll_count = upperbound(anva_transaction)
ll_RowCount = this.RowCount()

for ll_ndx = 1 to ll_count
	IF IsValid ( anva_transaction[ll_ndx] ) THEN

		ll_id = anva_transaction[ll_ndx].of_getid()
		ll_row = this.find("transaction_id = " + string(ll_id), 1, ll_RowCount )

		IF anva_transaction[ll_ndx].of_GetOpen ( ) = FALSE THEN
			//Transaction is already closed
			li_Return = NO_ACTION
	
		ELSE
			CHOOSE CASE anva_transaction[ll_ndx].of_SetOpen ( FALSE )
		
			CASE IS > 0  //Success (or no action)
	
				li_Return = SUCCESS
	
				//	 update display
				if ll_row > 0 then
					this.object.transaction_status[ll_row] = anva_transaction[ll_ndx].of_GetStatus()
				end if
				
			CASE ELSE
				//find the row, get entity name and show message
				if ll_row > 0 then
					ls_fn = this.object.em_fn[ll_row]
					ls_ln = this.object.em_ln[ll_row]
				end if
				
				ls_message = "Could not close the transaction for " + "" +&
						ls_ln + ', ' +  ls_fn +	".  Please check the following:~n~n"+&
						"The transaction or one of its transaction amounts may have a non-closeable status. "+&
						"(Hold or Audit Req.)~n~n"+&
						"Amount Type or Division may not have been specified for one or more amounts.~n~n"+&
						"Your user privileges may be insufficient to perform this operation."
						
				li_Return = FAILURE
				
				if ll_ndx < ll_count then
					ls_message += " Do you want to try to close the rest of the transactions ?"
					choose case MessageBox ( ls_MessageHeader, ls_message, Question!, YesNo! )
						case 1 
							//contiune
							li_Return = SUCCESS
						case 2
							exit
					end choose
				else
					 MessageBox ( ls_MessageHeader, ls_message)
				end if
			END CHOOSE
		END IF
	
	END IF
next

RETURN li_Return
end event

event type integer ue_printtransaction(n_cst_beo_transaction anva_transaction[]);//Returns : SUCCESS, NO_ACTION, FAILURE   (NO_ACTION not currently possible)

long		ll_ndx, &
			ll_count
			
Integer	li_Return

li_Return = FAILURE

ll_count = upperbound(anva_transaction)
PrintSetup ( ) // ADDED 2/17/06 Issue # 1890 <<*>>
for ll_ndx = 1 to ll_count	
	IF IsValid ( anva_Transaction[ll_ndx] ) THEN	
		IF anva_Transaction[ll_ndx].of_Print ( ) = 1 THEN
			li_Return = SUCCESS
		else
			li_Return = FAILURE
			exit
		END IF
	END IF
next

RETURN li_Return


end event

event ue_markbatched;Long		ll_ndx, &
			ll_id, &
			ll_count, &
			ll_row
			
Integer	li_Return

li_Return = FAILURE

ll_count = upperbound(anva_transaction)

for ll_ndx = 1 to ll_count

	IF IsValid ( anva_transaction[ll_ndx] ) THEN
		ll_id = anva_transaction[ll_ndx].of_getid()
		ll_row = this.find("transaction_id = " + string(ll_id), 1, ll_count)

		IF anva_transaction[ll_ndx].of_SetBatched ( ab_set ) = -1 then
			li_Return = FAILURE
		ELSE
			//	 update display
			if ll_row > 0 then
				this.object.transaction_status[ll_row] = ab_set
			end if
			
		END IF
	END IF
next

RETURN li_Return
end event

event ue_updatetransaction;
string	ls_message, &
			ls_fn, &
			ls_ln
Long		ll_ndx, &
			ll_id, &
			ll_count, &
			ll_rowcount, &
			ll_row
			
Integer	li_Return

Constant String	ls_MessageHeader = "Update Transaction Display"



li_Return = FAILURE

ll_count = upperbound(anva_transaction)
ll_rowcount = this.rowcount()

for ll_ndx = 1 to ll_count
	IF IsValid ( anva_transaction[ll_ndx] ) THEN

		ll_id = anva_transaction[ll_ndx].of_getfkentity()

   	ll_row = this.find("id = " + string(ll_id), 1, ll_rowcount)
		//	 update display
		if ll_row > 0 then
		
			this.object.transaction_id[ll_row] = anva_transaction[ll_ndx].of_Getid()
			this.object.transaction_status[ll_row] = anva_transaction[ll_ndx].of_GetStatus()
			this.object.batchnumber[ll_row] = anva_transaction[ll_ndx].of_Getbatchnumber()
			this.object.batchDate[ll_row] = anva_transaction[ll_ndx].of_GetbatchDate()
			this.object.startDate[ll_row] = anva_transaction[ll_ndx].of_GetStartDate()
			this.object.EndDate[ll_row] = anva_transaction[ll_ndx].of_GetEndDate()					
			this.object.taxablegross[ll_row] = anva_transaction[ll_ndx].of_GetTaxableGross()
			this.object.nontaxablegross[ll_row] = anva_transaction[ll_ndx].of_GetNonTaxableGross()
			this.object.pretaxnet[ll_row] = anva_transaction[ll_ndx].of_Getpretaxnet()					
			this.object.description[ll_row] = anva_transaction[ll_ndx].of_GetDescription()	
			this.object.ref1type[ll_row] = anva_transaction[ll_ndx].of_Getref1type()	
			this.object.ref1text[ll_row] = anva_transaction[ll_ndx].of_Getref1text()
			this.object.ref2type[ll_row] = anva_transaction[ll_ndx].of_Getref2type()	
			this.object.ref2text[ll_row] = anva_transaction[ll_ndx].of_Getref2text()
			this.object.ref3type[ll_row] = anva_transaction[ll_ndx].of_Getref3type()	
			this.object.ref3text[ll_row] = anva_transaction[ll_ndx].of_Getref3text()
			this.object.internalnote[ll_row] = anva_transaction[ll_ndx].of_GetInternalNote()
			this.object.publicnote[ll_row] = anva_transaction[ll_ndx].of_GetPublicNote()
//					this.object.modlog[ll_row] = anva_transaction[ll_ndx].of_GetModLog()
		end if			

	END IF
next

RETURN li_Return
end event

event ue_deletetransaction;long		ll_ndx, &
			ll_count, &
			ll_rowcount, &
			ll_found, &
			ll_id, &
			ll_ndx2, &
			ll_amounts
			
n_cst_beo_amountowed lnva_amountowed[]

ll_count = upperbound(anva_transaction)
ll_rowcount = this.rowcount()

for ll_ndx = 1 to ll_count	
	IF IsValid (anva_Transaction[ll_ndx] ) THEN	
		ll_id = anva_Transaction[ll_ndx].of_getid()
		ll_found = this.find("transaction_id = " + string(ll_id), 1, ll_rowcount) 
		if ll_found > 0 then
			this.deleterow(ll_found)
			ll_amounts = anva_Transaction[ll_ndx].of_GetAmountsList(lnva_amountowed)
			for ll_ndx2 = 1 to ll_amounts
				lnva_amountowed[ll_ndx2].deletebeo()
			next
			
			anva_Transaction[ll_ndx].DeleteBeo ( )
			
		end if
	END IF
next

end event

event ue_setunassigned();Long		ll_RowCount, &
			ll_Transaction, &
			ll_EntityId, &
			ll_UnassignedCount, &
			i, j
			
Integer	li_Return

Long		lla_AllUnassigned[]
Boolean	lb_SetUnassinged

n_cst_bso_TransactionManager	lnv_TransactionManager

lnv_transactionmanager = this.event ue_GetTransactionmanager()

/* MFS - 6/6/07 - Replaced with code below for performance reasons 
for ll_row = 1 to ll_rowcount
	
	ll_transaction = this.object.transaction_id[ll_row]
	ll_Entityid = this.object.id[ll_row]
	
	if isnull(ll_transaction) or ll_transaction = 0 then
		//don't add
	else
		lnv_TransactionManager.of_GetTransaction(ll_transaction, lnv_transaction)
		if isvalid(lnv_Transaction) then
			lnv_Amounts = lnv_TransactionManager.of_retrieveunassignedamounts(ll_Entityid)
			if lnv_Amounts.GetCount() > 0  then
				this.object.unassignedcount[ll_row] = 1
			end if
		END IF
	
	END IF
next*/

IF isValid(lnv_TransactionManager) THEN
	IF lnv_transactionmanager.of_GetAllUnassingedEntities(lla_AllUnassigned) = 1 THEN
		
		ll_UnassignedCount = UpperBound(lla_AllUnassigned)
		ll_RowCount = This.RowCount()
		
		FOR i = 1 TO ll_RowCount
			lb_SetUnassinged = False
			ll_transaction = this.object.transaction_id[i]
			ll_Entityid = this.object.id[i]
			
			IF NOT IsNull(ll_transaction) AND ll_transaction > 0 THEN
			
				FOR j = 1 TO ll_UnassignedCount
					
					IF ll_EntityId = lla_AllUnassigned[j] THEN
						lb_SetUnassinged = True
						EXIT
					END IF
					
				NEXT
				
			END IF
			
			IF lb_SetUnassinged THEN
				This.object.unassignedcount[i] = 1
			ELSE
				This.object.unassignedcount[i] = 0
			END IF
			
			
		NEXT
		
	END IF
END IF
end event

event ue_processkey;Long		ll_Return

CHOOSE CASE Key 
	CASE keyapps!	

	CASE keydownarrow! , keypagedown! , keyuparrow! , keypageup!
		
	CASE keytab!
		
	CASE keyenter!
		
		this.triggerevent(doubleclicked!)
		
	CASE ELSE

			
END CHOOSE

RETURN ll_Return 

end event

public function long of_getselectedtransaction (ref long ala_id[]);
Long	ll_SelectedRows[]
Long	ll_Count
Long	i
Long	lla_id[]

ll_Count = inv_rowselect.of_selectedcount( ll_SelectedRows )

FOR i = 1 TO ll_Count
	
	lla_id[i] = this.object.transaction_id[ll_SelectedRows[i]]
	
	
NEXT

ala_id[] = lla_id

RETURN ll_Count
end function

public function long of_getcurrenttransactionid ();//	returns the transaction of the current row
long	ll_row, &
		ll_id 

ll_row = this.GetRow()
if ll_row > 0 then
	ll_id = this.object.transaction_id[ll_row]
end if

return ll_id
end function

event constructor;This.of_SetResize ( TRUE )

inv_Resize.of_SetMinSize ( 3429, 1232 )

// enable multi-row-select-ability
THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (2) //2 = extended row select service

of_setinsertable ( false )
of_setDeleteable ( false )

of_SetAutoFind ( TRUE ) 
of_SetAutoSort ( TRUE )

this.SetTransobject(sqlca)

n_cst_Presentation_AmountTemplate	lnv_Presentation_Amount
n_cst_Presentation_Transaction		lnv_Presentation_Transaction

lnv_Presentation_Amount.of_SetPresentation ( THIS )
lnv_Presentation_Transaction.of_SetPresentation ( THIS )

//set protection after presentation
this.object.transaction_status.protect = &
				'0~tIF ( isnull(transaction_status) or isNull( batchdate ) or isNull( transaction_id ) or transaction_id = 0, 0, 1 )'
this.object.transaction_id.protect = 0
end event

event doubleclicked;setpointer(Hourglass!)
string	ls_null
long		ll_entityid, &
			lla_ids[], &
			ll_id, &
			ll_row, &
			ll_null
date		ld_Null
n_cst_bso_transactionmanager	lnv_transactionmanager
IF row = 0 or isnull(row) then
	ll_row = this.getrow()
	if ll_row > 0 then
		row = ll_row
	end if
end if

If row > 0 Then
	lnv_transactionmanager =  this.event ue_getTransactionManager()
	
	If lnv_transactionmanager.Event pt_UpdatesPending() = 1 then 

		MessageBox("Updates Are Pending",&
			"You must save the batch before going to the detail window.") 

	else
		
		w_transactionmanager	lw_TransactionManager
		n_cst_msg	lnv_Msg	
		s_Parm		lstr_Parm
		S_Transaction_Selection  lstr_Selection
		
		setnull(ld_Null)
		setnull(ls_Null)
		setnull(ll_null)
		
		ll_id = THIS.object.transaction_id[row]
		if isnull(ll_id) or ll_id = 0 then
			//don't open window
		else
			lla_Ids[1] = ll_id
		
			lstr_Selection.s_Transactionids = ls_Null
			lstr_Selection.la_Transactionids = lla_Ids
			lstr_Selection.s_EntityName = this.object.em_fn[row] + ' ' + this.object.em_ln[row]
			lstr_Selection.l_EntityID = THIS.object.id[row]
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
			
			lstr_Parm.is_Label = "TRANSACTIONMGR"
			lstr_Parm.ia_Value = lnv_transactionmanager
			lnv_Msg.of_Add_Parm ( lstr_Parm ) 
			
			OpenSheetWithParm ( lw_TransactionManager, lnv_Msg, gnv_App.of_GetFrame ( ), 0, Layered! )
			
		end if
		
	End If

End if
end event

event itemchanged;call super::itemchanged;// Extending Ancestor

// J. Albert, 12/20/02 - CST project -   THIS ISN'T WORKING ......

String	ls_ColChanged

Long 		ll_Return, &
			ll_Row, &
			ll_Transactionid, &
			ll_TransactionStatus

n_cst_beo_Transaction 	lnv_Transaction
ll_Return = AncestorReturnValue
ls_ColChanged = dwo.name

CHOOSE CASE lower(ls_ColChanged)
		
	CASE  "transaction_status"
		this.event post ue_statuschanged()
		
		// pull value set on screen by user
////		ll_Row = dwo.GetRow()
////		ll_TransactionId = dwo.GetItemNumber(1, "transaction_id")
////		ll_TransactionStatus = dwo.GetItemNumber(1, "transaction_status")
		// Do I have a transaction manager with me here?  
//		ll_Return = inv_TransactionManager.of_GetTransaction(ll_TransactionId, lnv_Transaction)
//		// somehow get the transaction and set the status 
//		This.SetColumn (  // don't use setcolumn in itemchanged - can be recursive!!
		// store somewhere until it's saved by user
		
END CHOOSE
end event

on u_dw_driversettlementist.create
end on

on u_dw_driversettlementist.destroy
end on

