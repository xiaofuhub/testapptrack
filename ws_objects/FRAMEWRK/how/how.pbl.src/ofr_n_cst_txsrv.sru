$PBExportHeader$ofr_n_cst_txsrv.sru
$PBExportComments$Transaction service object to keep track of updateable controls and datastores.
forward
global type ofr_n_cst_txsrv from n_cst_base
end type
end forward

global type ofr_n_cst_txsrv from n_cst_base
end type
global ofr_n_cst_txsrv ofr_n_cst_txsrv

type variables
Protected:

integer ii_seq, ii_dwcount, ii_dscount, ii_bcmcount, ii_dbcount
datawindow idw_dwlist[]
int ii_dwseq[]
datastore ids_dslist[]
int ii_dsseq[]
n_cst_bcm inv_bcmlist[]
int ii_bcmseq[]
Boolean ib_loadupdatelist
powerobject ipo_presentationobject
n_cst_bcm inv_regbcm[]
int ii_regbcms
n_cst_database inv_dblist[]
n_cst_txmgr inv_txmgr
end variables

forward prototypes
public function integer loadupdatelist (readonly powerobject apo_control[])
public function integer save ()
public function integer loadupdatelist (readonly powerobject apo_control)
public function integer register (readonly n_cst_bcm anv_bcm)
public function integer register (readonly datawindow adw_datawindow)
public function integer register (readonly datastore ads_datastore)
protected function integer registerbcm (readonly n_cst_bcm anv_bcm)
protected function integer registerdatastore (readonly datastore ads_datastore)
protected function integer registerdatawindow (readonly datawindow adw_datawindow)
public function integer setloadupdatelist (boolean ab_flag)
public function integer setpresentationobject (powerobject apo_object)
public function integer clearupdatelist ()
public function integer updatespending ()
protected function integer processofrerror ()
protected function integer bcmresetupdate (readonly n_cst_bcm anv_bcm)
protected function integer dsresetupdate (readonly datastore ads_datastore)
protected function integer dwresetupdate (readonly datawindow adw_datawindow)
protected function n_cst_uilink_dw getuilink (readonly datastore ads_datastore)
protected function n_cst_uilink_dw getuilink (readonly datawindow adw_datawindow)
public function integer committransaction ()
protected function integer registermgrbcm (readonly n_cst_bcm anv_bcm)
protected function integer registermgrdatastore (readonly datastore ads_datastore)
protected function integer registermgrdatawindow (readonly datawindow adw_datawindow)
protected function integer registerdatabase (readonly n_cst_database anv_database)
public function integer begintransaction ()
public function integer aborttransaction ()
protected function n_cst_txmgr gettxmgr ()
end prototypes

public function integer loadupdatelist (readonly powerobject apo_control[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		LoadUpdateList
//
//	Arguments:		apo_control[]	Presentation object control array
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Interrogates specified control array and
//						registers any DataWindow controls with the
//						transaction service.  If any additional 
//						presentation objects are found that contain 
//						a control array the function recursively calls
//						itself to interrogate those control arrays.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Int			li_rc = 1
Int 			li_max, li_i
DataWindow	ldw_dw
Tab			ltab_tab
UserObject	luo_controlgroup 

li_max = UpperBound ( apo_control )

For li_i = 1 to li_max
	Choose Case apo_control[li_i].TypeOf ()
		Case DataWindow! 
			ldw_dw = apo_control[li_i]	
			this.Register(ldw_dw)
		Case Tab!
			ltab_tab = apo_control[li_i]
			this.LoadUpdateList(ltab_tab.control)
		Case UserObject!
			luo_controlgroup = apo_control[li_i]
			if luo_controlgroup.ObjectType = CustomVisual! then
				this.LoadUpdateList(luo_controlgroup.control)
			end if
	End Choose
Next
 
return li_rc

end function

public function integer save ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Save
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Save the changes to the objects that have been
//						registered with the transaction service.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.0.2		Remove required checking, now done by TXMGR
//	1.0.2		Add BCM error service
// 1.20.03 	Clear old errors before doing the save.
// 2.0   	Remove Transaction Manager references and use n_cst_database
// 1.3	   Added  "and not isNull(ll_rc)" to check UpdateStart return code.
//				Compiled code thinks NULL <> 0 is TRUE.  Standard PB thinks it's FALSE.
// 2.1		Added code to call task_update event.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1
int li_dw, li_ds, li_bcm, li_seq
long ll_rc, ll_updated, ll_inserted, ll_deleted
ofr_n_cst_uilink_dw lnv_uilink
n_cst_database lnv_database
any la_rc

this.ClearOFRErrors()

if ib_loadupdatelist then
	if ii_bcmcount = 0 and ii_dscount = 0 and ii_dwcount = 0 then
		this.LoadUpdateList(ipo_presentationobject)
	end if
end if

//		Do accept text on each DW
for li_dw = 1 to ii_dwcount
	if idw_dwlist[li_dw].AcceptText() <> 1 then
		li_rc = -1
		exit
	end if
next

//		Register objects with TX manager
//		Note the objects must be registered in the same order
//		in which they were registered with the service.
//	Clear registered BCM array pointer
ii_regbcms = 0
if li_rc = 1 then
	li_dw = 1
	li_ds = 1
	li_bcm = 1
	for li_seq = 1 to ii_seq
		//	Register DW
		if li_dw <= ii_dwcount then
			if li_seq = ii_dwseq[li_dw] then
//				la_rc = idw_dwlist[li_dw].event dynamic task_update()
//				if isNull(la_rc) then
					li_rc = 1
					if this.RegisterMGRDatawindow(idw_dwlist[li_dw]) <> 1 then
						li_rc = -1
						exit
					end if
//				else
//					li_rc = la_rc
//				end if
				li_dw++
			end if
		end if
		//	Register DS
		if li_ds <= ii_dscount then
			if li_seq = ii_dsseq[li_ds] then
				if this.RegisterMGRDatastore(ids_dslist[li_ds]) <> 1 then
					li_rc = -1
					exit
				end if
				li_ds++
			end if
		end if
		//	Register BCM
		if li_bcm <= ii_bcmcount then
			if li_seq = ii_bcmseq[li_bcm] then
				if this.RegisterMGRBCM(inv_bcmlist[li_bcm]) <> 1 then
					li_rc = -1
					exit
				end if
				li_bcm++
			end if
		end if
	next
end if

if li_rc = -1 then
	return li_rc
end if

//		Fire updatestart on DW and DS
if li_rc = 1 then
	for li_dw = 1 to ii_dwcount
		ll_rc = idw_dwlist[li_dw].event UpdateStart()
		if ll_rc <> 0 and not isNull(ll_rc) then
			li_rc = -1
			exit
		end if
	next
end if
if li_rc = 1 then
	for li_ds = 1 to ii_dscount
		ll_rc = ids_dslist[li_ds].event UpdateStart()
		if ll_rc <> 0 and not isNull(ll_rc) then
			li_rc = -1
			exit
		end if
	next
end if

if li_rc = 1 then
	// Process local updates if there are any.
	if isValid(inv_txmgr) then
		if inv_txmgr.Save() <> 1 then
			this.PropagateErrors(inv_txmgr)
			this.ProcessOFRError()
			li_rc = -1
		end if
	end if
	if li_rc = 1 then 
		// Call each Database for distributed updates.
		for li_seq = 1 to ii_dbcount
			if inv_dblist[li_seq].Save() <> 1 then
				this.PropagateErrors(inv_dblist[li_seq])
				this.ProcessOFRError()
				inv_dblist[li_seq].Unregister()
				li_rc = -1
				exit
			end if
			inv_dblist[li_seq].Unregister()
		next
	end if
end if

//		UILink DW reset update flags
if li_rc = 1 then
	for li_dw = 1 to ii_dwcount
		if this.DWResetUpdate(idw_dwlist[li_dw]) <> 1 then
			li_rc = -1
			exit
		end if
	next
end if

//		UILink DS reset update flags
if li_rc = 1 then
	for li_ds = 1 to ii_dscount
		if this.DSResetUpdate(ids_dslist[li_ds]) <> 1 then
			li_rc = -1
			exit
		end if
	next
end if

//		Fire updateend on DW and DS
if li_rc = 1 then
	for li_dw = 1 to ii_dwcount
		lnv_uilink = this.Getuilink(idw_dwlist[li_dw])
		if IsValid(lnv_uilink) then
			if lnv_uilink.IsBCMCreated() then
				lnv_uilink.GetBCM().GetUpdateCount(ll_updated, ll_inserted, ll_deleted)
				idw_dwlist[li_dw].event UpdateEnd(ll_inserted, ll_updated, ll_deleted)
			end if
		end if
	next
	for li_ds = 1 to ii_dscount
		lnv_uilink = this.Getuilink(ids_dslist[li_ds])
		if IsValid(lnv_uilink) then
			if lnv_uilink.IsBCMCreated() then
				lnv_uilink.GetBCM().GetUpdateCount(ll_updated, ll_inserted, ll_deleted)
				ids_dslist[li_ds].event UpdateEnd(ll_inserted, ll_updated, ll_deleted)
			end if
		end if
	next
end if

if isValid(inv_txmgr) then
	destroy inv_txmgr
end if

return li_rc

end function

public function integer loadupdatelist (readonly powerobject apo_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		LoadUpdateList
//
//	Arguments:		apo_control		Presentation object to interrogate
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Interrogates specified control and
//						registers any DataWindow controls with the
//						transaction service.  If any additional 
//						presentation objects are found that contain 
//						a control array the function recursively calls
//						itself to interrogate those control arrays.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Int			li_rc = 1
Int 			li_max, li_i
Window		lw_win
Tab			ltab_tab
UserObject	luo_controlgroup 

choose case apo_control.TypeOf ()
	case Window! 
		lw_win = apo_control
		LoadUpdateList(lw_win.control)
	case Tab!
		ltab_tab = apo_control
		LoadUpdateList(ltab_tab.control)
	case UserObject!
		luo_controlgroup = apo_control
		if luo_controlgroup.ObjectType = CustomVisual! then
			LoadUpdateList(luo_controlgroup.control)
		end if
end choose
 
return li_rc

end function

public function integer register (readonly n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Register
//
//	Arguments:		anv_bcm		BCM object
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers a BCM with the transaction service.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1

if RegisterBCM(anv_bcm) = 1 then
	li_rc = 1
end if

return li_rc

end function

public function integer register (readonly datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Register
//
//	Arguments:		adw_datawindow		DataWindow object
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers a DataWindow with the transaction service.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1

n_cst_uilink_dw lnv_uilink

lnv_uilink = this.Getuilink(adw_datawindow)
if IsValid(lnv_uilink) then
	if RegisterDataWindow(adw_datawindow) = 1 then
		li_rc = 1
	end if
end if

return li_rc

end function

public function integer register (readonly datastore ads_datastore);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Register
//
//	Arguments:		ads_datastore	Datastore object
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers a Datastore with the transaction service.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.

//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1

n_cst_uilink_dw lnv_uilink

lnv_uilink = this.Getuilink(ads_datastore)
if IsValid(lnv_uilink) then
	if RegisterDataStore(ads_datastore) = 1 then
		li_rc = 1
	end if
end if

return li_rc

end function

protected function integer registerbcm (readonly n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterBCM
//
//	Arguments:		anv_bcm	BCM to register
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers a BCM
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Ignore duplicate registration
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_bcm

for li_bcm = 1 to ii_bcmcount
	if inv_bcmlist[li_bcm] = anv_bcm then
		return 1
	end if
next
ii_bcmcount++
inv_bcmlist[ii_bcmcount] = anv_bcm
ii_seq++
ii_bcmseq[ii_bcmcount] = ii_seq

return 1
end function

protected function integer registerdatastore (readonly datastore ads_datastore);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterDatastore
//
//	Arguments:		ads_datastore	Datastore to register
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers a Datastore
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Ignore duplicate registration
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_ds

for li_ds = 1 to ii_dscount
	if ids_dslist[li_ds] = ads_datastore then
		return 1
	end if
next
ii_dscount++
ids_dslist[ii_dscount] = ads_datastore
ii_seq++
ii_dsseq[ii_dscount] = ii_seq

return 1

end function

protected function integer registerdatawindow (readonly datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterDataWindow
//
//	Arguments:		adw_datawindow		DataWindow to register
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers a DataWindow
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Ignore duplicate registration
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_dw

for li_dw = 1 to ii_dwcount
	if idw_dwlist[li_dw] = adw_datawindow then
		return 1
	end if
next
ii_dwcount++
idw_dwlist[ii_dwcount] = adw_datawindow
ii_seq++
ii_dwseq[ii_dwcount] = ii_seq

return 1
end function

public function integer setloadupdatelist (boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetLoadUpdateList
//
//	Arguments:		ab_flag	Update load indicator
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets update load indicator
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ib_loadupdatelist = ab_flag

return 1

end function

public function integer setpresentationobject (powerobject apo_object);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetPresentationObject
//
//	Arguments:		apo_object	Presentation object to register from
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets the presentation object to register objects
//						from at save time.  See Save().
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ipo_presentationobject = apo_object

Return 1

end function

public function integer clearupdatelist ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ClearUpdateList
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Clears any registered objects
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ii_seq = 0
ii_dwcount = 0
ii_dscount = 0
ii_bcmcount = 0

Return 1


end function

public function integer updatespending ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		UpdatesPending
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		Changes pending
//						0		No changes pending
//						-1		Error
//
//	Description:	Returns indicator as to whether updates are pending
//						on any of the registered objects.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer li_rc
int li_dw, li_ds, li_bcm
ofr_n_cst_uilink_dw lnv_uilink

if ib_loadupdatelist then
	if ii_bcmcount = 0 and ii_dscount = 0 and ii_dwcount = 0 then
		LoadUpdateList(ipo_presentationobject)
	end if
end if

//		Do accept text on each DW
for li_dw = 1 to ii_dwcount
	if idw_dwlist[li_dw].AcceptText() <> 1 then
		li_rc = -1
		exit
	end if
next

//		Check DWs for updates
if li_rc = 0 then
	for li_dw = 1 to ii_dwcount
		lnv_uilink = this.Getuilink(idw_dwlist[li_dw])
		if IsValid(lnv_uilink) then
			if lnv_uilink.IsBCMCreated() then
				if lnv_uilink.GetBCM().UpdatesPending() > 0 then
					li_rc = 1
					exit
				end if
			end if
		end if
	next
end if

//		Check DSs for updates
if li_rc = 0 then
	for li_ds = 1 to ii_dscount
		lnv_uilink = this.Getuilink(ids_dslist[li_ds])
		if IsValid(lnv_uilink) then
			if lnv_uilink.IsBCMCreated() then
				if lnv_uilink.GetBCM().UpdatesPending() > 0 then
					li_rc = 1
					exit
				end if
			end if
		end if
	next
end if

//		Check BCMs for updates
if li_rc = 0 then
	for li_bcm = 1 to ii_bcmcount
		if IsValid(inv_bcmlist[li_bcm]) then
			if inv_bcmlist[li_bcm].UpdatesPending() > 0 then
				li_rc = 1
				exit
			end if
		end if
	next
end if

return li_rc

end function

protected function integer processofrerror ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ProcessOFRError
//
//	Arguments:		none
//
//	returns:			Integer
//						1		Success
//						-1		error
//
//	Description:	Process list of OFR errors.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2   Initial version
// 1.20.02	Propogate errors to the UI Link before asking it to process them.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1
n_cst_ofrerror lnv_ofrerror[]
n_cst_uilink_dw lnv_uilink
n_cst_bcm lnv_bcm
int li_dw, li_ds, li_count, i


li_count = this.GetOFRErrors(lnv_ofrerror)
if UpperBound(lnv_ofrerror) > 0 then
	lnv_bcm = lnv_ofrerror[1].GetBCM()
	for li_dw = 1 to ii_dwcount
		lnv_uilink = this.Getuilink(idw_dwlist[li_dw])
		if IsValid(lnv_uilink) then
			//if the bcm's are the same or the bcm was created remotely, clear the errors
			if lnv_bcm = lnv_uilink.GetBCM() then
				// 1.20.02 - Copy errors to the UI Link so it can process them.
				// Clear the errors from the UI Link.
				lnv_uilink.GetOFRErrorCollection().ClearErrors()
				for i = 1 to li_count
					lnv_uilink.GetOFRErrorCollection().AddError(lnv_ofrerror[i])
				next
				//
				lnv_uilink.ProcessOFRError(lnv_ofrerror)
				// Clear the errors from the UI Link.
				lnv_uilink.GetOFRErrorCollection().ClearPropagatedErrors()
				//
			end if
		end if
	next
	for li_ds = 1 to ii_dscount
		lnv_uilink = this.Getuilink(ids_dslist[li_ds])
		if IsValid(lnv_uilink) then
			if lnv_bcm = lnv_uilink.GetBCM() then
				// 1.20.02 - Copy errors to the UI Link so it can process them.
				// Clear the errors from the UI Link.
				lnv_uilink.GetOFRErrorCollection().ClearErrors()
				for i = 1 to li_count
					lnv_uilink.GetOFRErrorCollection().AddError(lnv_ofrerror[i])
				next
				//
				lnv_uilink.ProcessOFRError(lnv_ofrerror)
				// Clear the errors from the UI Link.
				lnv_uilink.GetOFRErrorCollection().ClearPropagatedErrors()
				//
			end if
		end if
	next
end if			

return li_rc


end function

protected function integer bcmresetupdate (readonly n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		BCMResetUpdate
//
//	Arguments:		anv_bcm	BCM to reset
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Resets a BCM's update flags
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1

if anv_bcm.ResetUpdate() <> 1 then
	li_rc = -1
end if

return li_rc

end function

protected function integer dsresetupdate (readonly datastore ads_datastore);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DSResetUpdate
//
//	Arguments:		ads_datastore	Datastore to reset
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Resets a Datastores update flags
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.2	Added check for result set changes
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1
n_cst_uilink_dw lnv_uilink

lnv_uilink = this.Getuilink(ads_datastore)
if IsValid(lnv_uilink) then
	if lnv_uilink.IsBCMCreated() then
		if lnv_uilink.GetBCM().HasDataChangedDuringUpdate() then
			lnv_uilink.RefreshFromBCM()
		end if
		if lnv_uilink.ResetUpdate() = 1 then
			li_rc = 1
		end if
	else
		li_rc = 1
	end if
end if

return li_rc

end function

protected function integer dwresetupdate (readonly datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DWResetUpdate
//
//	Arguments:		adw_datawindow		DataWindow to reset
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Resets a DataWindow update flags
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.2	Added check for result set changes
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1
n_cst_uilink_dw lnv_uilink

lnv_uilink = this.Getuilink(adw_datawindow)
if IsValid(lnv_uilink) then
	if lnv_uilink.IsBCMCreated() then
		if lnv_uilink.GetBCM().HasDataChangedDuringUpdate() then
			lnv_uilink.RefreshFromBCM()
		end if
		if lnv_uilink.ResetUpdate() = 1 then
			li_rc = 1
		end if
	else
		li_rc = 1
	end if
end if

return li_rc

end function

protected function n_cst_uilink_dw getuilink (readonly datastore ads_datastore);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Getuilink
//
//	Arguments:		ads_datastore	Datastore to get BO Service on
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Get BO service handle for a DataStore
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.

//
//////////////////////////////////////////////////////////////////////////////
n_cst_uilink_dw lnv_uilink

if ads_datastore.TriggerEvent("ofr_getuilink") = 1 then
	lnv_uilink = ads_datastore.dynamic Event ofr_getuilink()
end if

return lnv_uilink

end function

protected function n_cst_uilink_dw getuilink (readonly datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Getuilink
//
//	Arguments:		adw_datawindow		DataWindow to get BO Service on
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Get BO service handle for a DataWindow
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_uilink_dw lnv_uilink

if adw_datawindow.TriggerEvent("ofr_getuilink") = 1 then
	lnv_uilink = adw_datawindow.Dynamic Event ofr_getuilink()
end if

return lnv_uilink

end function

public function integer committransaction ();//////////////////////////////////////////////////////////////////////////////
//
// Function:		CommitTransaction
//
//	Arguments:		None
//
//	Returns:			Integer 1  Succeeded
//						        -1 Failed
//
//	Description:	Update the database of all registered bcms
//

//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_idx, li_rc = 1

//for li_idx = 1 to ii_dbcount
//	if inv_dblist[li_idx].Save() <> 1 then
//		this.PropagateErrors(inv_dblist[li_idx])
//		this.ProcessOFRError()
//		li_rc = -1
//		exit
//	end if
//next

return li_rc
end function

protected function integer registermgrbcm (readonly n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterMgrBCM
//
//	Arguments:		anv_txmgr	Transaction manager
//						anv_bcm		BCM to register
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers a BCM with the transaction manager.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.2	Make sure BCM is still valid before registering
// 2.0   Database communicates with SSO to register with Transaction Manager
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int            li_rc = -1, li_regbcm
boolean        ib_registered
n_cst_database lnv_database

if IsValid(anv_bcm) then
	//		Check to see if BCM has already been registered
	for li_regbcm = 1 to ii_regbcms
		if anv_bcm = inv_regbcm[li_regbcm] then
			ib_registered = true
			exit
		end if
	next
	if ib_registered = true then
		li_rc = 1
	else
		lnv_database = anv_bcm.GetDatabase()
		if IsValid(lnv_database) then
			if lnv_database.GetRemote() = FALSE then
				if this.GetTxMgr().Register(anv_bcm) <> 1 then
					return -1
				end if
			else
				this.RegisterDatabase(lnv_database)
				if lnv_database.Register(anv_bcm) <> 1 then
					return -1
				end if
			end if
		else 
			if this.GetTxMgr().Register(anv_bcm) <> 1 then
				return -1
			end if
		end if
		li_rc = 1
		ii_regbcms++
		inv_regbcm[ii_regbcms] = anv_bcm
	end if
else
	return -1
end if

return li_rc

end function

protected function integer registermgrdatastore (readonly datastore ads_datastore);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterMgrDatastore
//
//	Arguments:		anv_txmgr		Transaction manager
//						ads_datastore	Datastore to register
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers a Datastore with the transaction manager.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1
n_cst_uilink_dw lnv_uilink

lnv_uilink = this.Getuilink(ads_datastore)
if IsValid(lnv_uilink) then
	if this.RegisterMgrBCM(lnv_uilink.GetBCM()) = 1 then
		li_rc = 1
	elseif lnv_uilink.IsRequestorValid() = FALSE then
		// This control could never have a BCM, so just ignore it.
		li_rc = 1
	end if
end if

return li_rc

end function

protected function integer registermgrdatawindow (readonly datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterMgrDataWindow
//
//	Arguments:		anv_txmgr		Transaction manager
//						adw_datawindow	DataWindow to register
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers a DataWindow with the transaction manager.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1
n_cst_uilink_dw lnv_uilink

lnv_uilink = this.Getuilink(adw_datawindow)
if IsValid(lnv_uilink) then
	if this.RegisterMgrBCM(lnv_uilink.GetBCM()) = 1 then
		li_rc = 1
	elseif lnv_uilink.IsRequestorValid() = FALSE then
		// This control could never have a BCM, so just ignore it.
		li_rc = 1
	end if
end if

return li_rc


end function

protected function integer registerdatabase (readonly n_cst_database anv_database);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterDatabase
//
//	Arguments:		anv_database	Database to register
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers a database
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_idx

for li_idx = 1 to ii_dbcount
	if inv_dblist[li_idx] = anv_database then
		return 1
	end if
next
ii_dbcount++
inv_dblist[ii_dbcount] = anv_database

return 1
end function

public function integer begintransaction ();//////////////////////////////////////////////////////////////////////////////
//
// Function:		BeginTransaction
//
//	Arguments:		None
//
//	Returns:			Integer 1  Succeeded
//						        -1 Failed
//
//	Description:	Begin a transaction on a database instance
//

//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_idx

//for li_idx = 1 to ii_dbcount
//	inv_dblist[li_idx].BeginTransaction()
//next

return 1
end function

public function integer aborttransaction ();//////////////////////////////////////////////////////////////////////////////
//
// Function:		BeginTransaction
//
//	Arguments:		None
//
//	Returns:			Integer 1  Succeeded
//						        -1 Failed
//
//	Description:	Begin a transaction on a database instance
//

//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_idx

//for li_idx = 1 to ii_dbcount
//	inv_dblist[li_idx].AbortTransaction()
//next

return 1
end function

protected function n_cst_txmgr gettxmgr ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetTxnMgr
//
//	Returns:			n_cst_txnmgr
//
//	Description:	Creates and returns a Transaction Manager.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if not isValid(inv_txmgr) then
	inv_txmgr = create n_cst_txmgr
end if

return inv_txmgr
end function

on ofr_n_cst_txsrv.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_txsrv.destroy
TriggerEvent( this, "destructor" )
end on

