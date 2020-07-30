$PBExportHeader$ofr_n_cst_txmgr.sru
$PBExportComments$Handles transaction management for OFR.
forward
global type ofr_n_cst_txmgr from n_cst_base
end type
end forward

global type ofr_n_cst_txmgr from n_cst_base
end type
global ofr_n_cst_txmgr ofr_n_cst_txmgr

type variables
protected:
n_cst_bcm inv_bcm[]
int ii_bcms

end variables

forward prototypes
public function integer begintransaction (readonly transaction atr_tran)
public function integer committransaction (readonly transaction atr_tran)
public function integer register (readonly n_cst_bcm anv_bcm)
public function integer rollbacktransaction (readonly transaction atr_tran)
public function integer save ()
end prototypes

public function integer begintransaction (readonly transaction atr_tran);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		BeginTransaction
//
//	Arguments:		atr_tran		Database transaction object
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Starts a database update transaction.  Note that this
//						event can be overridden in the framework
//						specific descendent.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added default behavior
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1

//	See if we have a PFC transaction object
if atr_tran.TriggerEvent("pfc_descendant") = 1 then
	//	Call PFC n_tr begin function
	if atr_tran.dynamic of_Begin() <> 1 then
		li_rc = -1
	end if
end if

return li_rc

end function

public function integer committransaction (readonly transaction atr_tran);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CommitTransaction
//
//	Arguments:		atr_tran		Database transaction object
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Commits a database update transaction.  Note that this
//						event can be overridden in the framework
//						specific descendent.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added default behavior
// 1.2 	Fixed default behavior
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1

//	See if we have a PFC transaction object
if atr_tran.TriggerEvent("pfc_descendant") = 1 then
//		Call PFC n_tr commit function
	if atr_tran.dynamic of_Commit() <> 0 then
		li_rc = -1
	end if
else
	commit using atr_tran ;
	if atr_tran.SQLCode <> 0 then
		li_rc = -1
	end if
end if

return li_rc

end function

public function integer register (readonly n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Register
//
//	Arguments:		anv_bcm	BCM to register
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Register a BCM with the transaction manager.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 1.2 	GK - Use DLK.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1


//  Force local mode on any bcm being registered with txmgr
//  If not forced to local mode, dlk's that were created will not
//  be available when serialized back and will cause an null object reference
//  in function save in txmgr when invoking this line of code lnv_dlk[li_bcm].ResetUpdateCount()
//  (mp 1/13/99)
anv_bcm.SetLocal(true)

ii_bcms++
inv_bcm[ii_bcms] = anv_bcm

return li_rc

end function

public function integer rollbacktransaction (readonly transaction atr_tran);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RollbackTransaction
//
//	Arguments:		atr_tran		Database transaction object
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Rolls back a database update transaction.  Note that this
//						event can be overridden in the framework
//						specific descendent.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added default behavior
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1

//	See if we have a PFC transaction object
if atr_tran.TriggerEvent("pfc_descendant") = 1 then
//		Call PFC n_tr rollback function
	if atr_tran.dynamic of_Rollback() <> 0 then
		li_rc = -1
	end if
else
	rollback using atr_tran ;
	if atr_tran.SQLCode <> 0 then
		li_rc = -1
	end if
end if

return li_rc

end function

public function integer save ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Save
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Updates all of the registered BCM's as a single
//						transaction (logical unit of work).
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added rc checks on transaction function calls
//	1.0.2	BTR 6784 - Do deletes before inserts/updates
//	1.0.2	BTR 6760 - Add calls to BCM.Validate
// 1.2 	GK - Include DLKs.
// 1.20.03 Clear old errors before doing the save.
// 1.3   Propagate errors from PostSave.
// 2.1   BTR #11858 - Don't destroy the dlk.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer	li_rc = 1
integer 	li_bcm
integer	li_tran
integer  li_updtype
integer 	li_uniquetrans
integer	li_dlks
boolean	lb_found
string	ls_class
string	ls_attribute
transaction ltr_bcm_tran
transaction	ltr_uniquetrans[]
n_cst_dlk lnv_dlk[]
n_cst_ofrerror lnv_ofrerror[]

this.ClearOFRErrors()

// Validate all registered BCM's
for li_bcm = 1 to ii_bcms
	if inv_bcm[li_bcm].Validate() <> 1 then
		this.PropagateErrors(inv_bcm[li_bcm])
		li_rc = -1
		exit
	end if
next

// Invoke PreSave on all registered BCM's
if li_rc = 1 then
	for li_bcm = 1 to ii_bcms
		if inv_bcm[li_bcm].PreSave() <> 1 then
			this.PropagateErrors(inv_bcm[li_bcm])
			li_rc = -1
			exit
		end if
	next
end if

//	Uniquely identify each database transaction object for all registered BCM's
if li_rc = 1 then
	for li_bcm = 1 to ii_bcms
		if inv_bcm[li_bcm].GetTrans(ltr_bcm_tran) <> 1 then
			// Exception! Could not get transaction object on
			// BCM.  End save process and return failure
			li_rc = -1
			exit
		end if
		lb_found = FALSE
		// Serach array of unique transaction objects and see if the
		// the current BCM's transaction object has already been added
		for li_tran = 1 to li_uniquetrans
			if ltr_bcm_tran = ltr_uniquetrans[li_tran] then
				lb_found = TRUE
				exit
			end if
		next
		if lb_found = FALSE then
			// BCM's transaction was not found in the list of unique
			// transaction objects so add it to the list
			li_uniquetrans++
			ltr_uniquetrans[li_uniquetrans] = ltr_bcm_tran
		end if
	next
end if

// Create DLK's for each registered bcm
if li_rc = 1 then
	for li_bcm = 1 to ii_bcms
		if inv_bcm[li_bcm].CreateDLK(lnv_dlk[li_bcm]) = 1 then
			lnv_dlk[li_bcm].ResetUpdateCount()
		else
			// Exception! - DLK was not created.  End save process
			// and return failure
			li_rc = -1
			exit
		end if
	next
end if

// Issue begin transaction for each database transaction
if li_rc = 1 then
	for li_tran = 1 to li_uniquetrans
		if this.BeginTransaction(ltr_uniquetrans[li_tran]) <> 1 then
			// Exception! - Could not begin transaction. End Save Process
			// and return failure
			li_rc = -1
			exit
		end if
	next
end if

//	If only a single registered BCM then only do a single update
if li_rc = 1 then
	if ii_bcms = 1 then
		if inv_bcm[1].UpdatesPending() > 0 then
			if lnv_dlk[1].Save() <> 1 then
				this.PropagateErrors(lnv_dlk[1])
				//		Identify which BCM had error
				this.GetOFRErrors(lnv_ofrerror)
				if UpperBound(lnv_ofrerror) > 0 then
					lnv_ofrerror[1].SetBCM(inv_bcm[1])
				end if
				li_rc = -1
			end if
		end if
	else
		//	Perform Deletes Bottom/Up
		for li_bcm = ii_bcms to 1 step -1
			//a return code from updatespending = 1 indicates no deletes pending
			if inv_bcm[li_bcm].UpdatesPending() > 1 then
				if lnv_dlk[li_bcm].PerformDeletes() <> 1 then
					this.PropagateErrors(lnv_dlk[li_bcm])
					//		Identify which BCM had error
					this.GetOFRErrors(lnv_ofrerror)
					if UpperBound(lnv_ofrerror) > 0 then
						lnv_ofrerror[1].SetBCM(inv_bcm[li_bcm])
					end if
					li_rc = -1
					exit
				end if
			end if
		next
		//	Perform Inserts and Updates Top/Down
		if li_rc = 1 then
			for li_bcm = 1 to ii_bcms
				li_updtype = inv_bcm[li_bcm].UpdatesPending()
				if (li_updtype = 1 or li_updtype = 3) then
					if lnv_dlk[li_bcm].PerformUpdates() <> 1 then
						this.PropagateErrors(lnv_dlk[li_bcm])
						//		Identify which BCM had error
						this.GetOFRErrors(lnv_ofrerror)
						if UpperBound(lnv_ofrerror) > 0 then
							lnv_ofrerror[1].SetBCM(inv_bcm[li_bcm])
						end if
						li_rc = -1
						exit
					end if
				end if
			next
		end if
	end if
end if

//	Destroy DLK's for each registered BCM (Clean-Up)
//li_dlks = UpperBound(lnv_dlk)
//for li_bcm = 1 to li_dlks
//	if IsValid(lnv_dlk[li_bcm]) then
//		inv_bcm[li_bcm].DestroyDLK(lnv_dlk[li_bcm])
//	end if
//next

if li_rc = 1 then
	//	Issue commit transaction for each database transaction
	for li_tran = 1 to li_uniquetrans
		if this.CommitTransaction(ltr_uniquetrans[li_tran]) <> 1 then
			// Exception! - Could not commit transaction.  End save process 
			// and return failure.
			li_rc = -1
			exit
		end if
	next
else
	//	Issue rollback transaction for each database transaction
	for li_tran = 1 to li_uniquetrans
		if this.RollbackTransaction(ltr_uniquetrans[li_tran]) <> 1 then
			// Exception! - Could not commit transaction.  End save process 
			// and return failure.
			li_rc = -1
			exit
		end if
	next
end if

// Invoke PostSave on all registered BCM's
if li_rc = 1 then
	for li_bcm = 1 to ii_bcms
		// This is only an informational message to a beo to indicate
		// that it was successfully saves
		// Changed for 1.3
		if inv_bcm[li_bcm].PostSave() <> 1 then
			this.PropagateErrors(inv_bcm[li_bcm])
			return -1
		end if
	next
end if

//		Reset BCM datastore flags
if li_rc = 1 then
	for li_bcm = 1 to ii_bcms
		if inv_bcm[li_bcm].ResetUpdate() <> 1 then
			li_rc = -1
			exit
		end if
	next
end if

return li_rc

end function

on ofr_n_cst_txmgr.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_txmgr.destroy
TriggerEvent( this, "destructor" )
end on

