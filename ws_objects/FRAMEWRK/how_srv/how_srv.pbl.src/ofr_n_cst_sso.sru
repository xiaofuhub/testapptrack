$PBExportHeader$ofr_n_cst_sso.sru
$PBExportComments$Shared Service Object
forward
global type ofr_n_cst_sso from n_cst_base
end type
end forward

global type ofr_n_cst_sso from n_cst_base
end type
global ofr_n_cst_sso ofr_n_cst_sso

type variables
protected:

boolean ib_intransaction = false
boolean ib_remote = false
boolean ib_connecttodatabase = true
n_cst_database inv_database
n_cst_bcmmgr   inv_bcmmgr
n_cst_bcm inv_bcm

end variables

forward prototypes
public function boolean setdatabase (readonly n_cst_database anv_database)
public subroutine aborttransaction ()
public subroutine begintransaction ()
public subroutine committransaction ()
public function n_cst_bcm getbcm ()
public function boolean setbcm (ref n_cst_bcm anv_bcm)
public function boolean setremote (readonly boolean ab_value)
public function integer save (ref s_bcmreference astr_bcmreference[])
public function boolean dbconnect ()
public function boolean dbdisconnect ()
public function long retrievebcmwithbeokey (readonly blob ab_beokey, ref s_bcmreference astr_bcmreference)
public function n_cst_bcm loaddefinition (readonly string as_query)
public function s_bcmreference newbeo (readonly string as_query, readonly string as_classname[])
public function boolean setconnecttodatabase (readonly boolean ab_value)
public function long retrievebcm (string as_query, string as_relationship, string as_dlk_relation, any aa_keyvalue1, any aa_keyvalue2, any aa_keyvalue3, any aa_keyvalue4, any aa_keyvalue5, any aa_keyvalue6, any aa_keyvalue7, any aa_keyvalue8, any aa_keyvalue9, any aa_keyvalue10, any aa_keyvalue11, any aa_keyvalue12, any aa_keyvalue13, any aa_keyvalue14, any aa_keyvalue15, any aa_keyvalue16, ref s_bcmreference astr_bcmreference, boolean ab_byref)
public function s_bcmreference getdefinition (readonly string as_query, boolean ab_byref)
public function long retrieveremotebcm (string as_query, string as_relationship, string as_dlk_relation, ref blob ablb_bcm, blob ablb_args)
public function integer getremotedefinition (string as_query, ref blob ablb_bcm)
public function integer saveremote (ref blob ablb_bcm1, ref blob ablb_bcm2, ref blob ablb_bcm3, ref blob ablb_bcm4, ref blob ablb_bcm5, ref blob ablb_bcm6, ref blob ablb_bcm7, ref blob ablb_bcm8, ref blob ablb_bcm9, ref blob ablb_bcm10, ref blob ablb_bcm11, ref blob ablb_bcm12, ref blob ablb_bcm13, ref blob ablb_bcm14, ref blob ablb_bcm15, ref blob ablb_bcm16)
public function integer newbeoremote (string as_query, string as_classname[], ref blob ablb_bcm)
end prototypes

public function boolean setdatabase (readonly n_cst_database anv_database);//
// Function:		SetDatabase
//
//	Arguments:		anv_database Instance of the n_cst_database object
//
//	Returns:			Boolean	True 	
//
//	Description:	Pointer to the database this SSO belong to
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

inv_database = anv_database

return true
end function

public subroutine aborttransaction ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AbortTransaction
//
//	Arguments:		None
//
//	Returns:			None
//
//	Description:	Turn off Transaction Flag
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

ib_intransaction = false

end subroutine

public subroutine begintransaction ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		BeginTransaction
//
//	Arguments:		None
//
//	Returns:			None
//
//	Description:	Turn Transaction Flag on
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

ib_InTransaction = TRUE

end subroutine

public subroutine committransaction ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CommitTransaction
//
//	Arguments:		None
//
//	Returns:			None
//
//	Description:	Turns transaction flag off
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

ib_InTransaction = false
end subroutine

public function n_cst_bcm getbcm ();//
// Function:		GetBCM
//
//	Arguments:		None
//
//	Returns:			BCM
//
//	Description:	Returns a BCM
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

return inv_bcm

end function

public function boolean setbcm (ref n_cst_bcm anv_bcm);//
// Function:		SetBCM
//
//	Arguments:		anv_bcm 	A valid bcm
//
//	Returns:			Boolean
//
//	Description:	Sets a valid BCM on the SSO.  This bcm will be used by the
//						sso instead of creating one in the RetrieveBCM function
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

inv_bcm = anv_bcm

return true

end function

public function boolean setremote (readonly boolean ab_value);//
// Function:		SetRemote
//
//	Arguments:		ab_value False - The sso is not a remote nvo
//									True    The sso is a remote nvo, meaning it is independant
//											  of the client requestor
//
//	Returns:			Boolean
//
//	Description:	Set ib_remote.  
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

ib_remote = ab_value

return true
end function

public function integer save (ref s_bcmreference astr_bcmreference[]);//////////////////////////////////////////////////////////////////////////////
//
// Function:		Save
//
//	Arguments:		astr_bcmreference[]	Array of BCM's to update
//
//	Returns:			1 Succeeded
//						-1 Failed
//
//	Description:	Calls the transaction Manager to update the database
//

//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1 	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer li_rc = 1, li_bcm, li_bcms
n_cst_bcm lnv_bcm[]
n_cst_txmgr lnv_txmgr

if not this.dbconnect() then
	this.PushException("save")
	return -1
end if

li_bcms = UpperBound(astr_bcmreference)
lnv_txmgr = CREATE n_cst_txmgr
for li_bcm = 1 to li_bcms
	if not IsValid(astr_bcmreference[li_bcm]) then
		this.SetException("save", "29985")
		return -1
	end if
	lnv_bcm[li_bcm] = this.GetBCMMgr().CreateBCM(astr_bcmreference[li_bcm], TRUE)
	lnv_txmgr.Register(lnv_bcm[li_bcm])
next

if lnv_txmgr.Save() <> 1 then
	this.PropagateErrors(lnv_txmgr)
	li_rc = -1
end if

DESTROY lnv_txmgr

return li_rc

end function

public function boolean dbconnect ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DBConnect
//
//	Arguments:		none
//
//	Returns:			Boolean
//						true		success
//						false		error
//
//	Description:	Creates database connection object and connects to database
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

if this.ib_connecttodatabase then
	if not IsValid(inv_database) then
		inv_database = this.GetBCMMGR().GetDatabase()
	end if
	
	if not IsValid(inv_database) then
		return false
	end if
	
	return inv_database.DBConnect()
else
	return true
end if

end function

public function boolean dbdisconnect ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DBDisconnect
//
//	Arguments:		none
//
//	Returns:			Boolean
//						true		success
//						false		error
//
//	Description:	Disconnects from the database
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if ib_connecttodatabase then
	if inv_database.DBDisconnect() then
		return true
	else
		return false
	end if
else
	return true
end if

end function

public function long retrievebcmwithbeokey (readonly blob ab_beokey, ref s_bcmreference astr_bcmreference);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RetrieveBCMWithBEOKey
//
//	Arguments:		ab_beokey  			Blob - BEO key values 
//						astr_bcmreference	BCM represented as a structure
//
//	Returns:			Long - # of retrieved rows
//
//	Description:	Retrieve a BCM result set
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_beokey 	lnv_beokey
n_cst_bcm 		lnv_bcm
long 				ll_rows = -1
any				la_beokey_value[]
string 			ls_dlk_prefix, ls_query
integer			li_len

if not this.DBConnect() then
	this.PushException("retrievebcmwithbeokey")
	return -1
end if

//the bcm was created by getdefinition()
if IsValid(inv_bcm) then
	lnv_bcm = inv_bcm
else
	lnv_bcm = this.GetBCMMGR().CreateBCM()
end if

if isValid(lnv_bcm) then
	lnv_bcm.SetLocal(true)
	lnv_bcm.SetAppend(FALSE) //appends are client side only
	lnv_bcm.SetDatabase(inv_database)
	lnv_bcm.SetDLKRelation("")
		
	lnv_beokey = create n_cst_beokey
	If lnv_beokey.Deserialize(ab_beokey) then
		lnv_beokey.GetValues(la_beokey_value)
		
		li_len = len(this.GetBCMMgr().GetBEOPrefix())
		ls_dlk_prefix = this.GetBCMMgr().GetDLKPrefix()
		ls_query = lnv_beokey.GetClass()
		ls_query = ls_dlk_prefix + "c" + Mid( ls_query, li_len + 1 )  //use a class dlk
		lnv_bcm.SetQuery(ls_query)

		ll_rows = lnv_bcm.Retrieve(la_beokey_value[1], la_beokey_value[2],la_beokey_value[3],&
			la_beokey_value[4],la_beokey_value[5],la_beokey_value[6],la_beokey_value[7],&
			la_beokey_value[8],la_beokey_value[9], la_beokey_value[10], la_beokey_value[11], &
			la_beokey_value[12], la_beokey_value[13], la_beokey_value[14], la_beokey_value[15], &
			la_beokey_value[16], "")
	end if
	
	destroy lnv_beokey

	if ll_rows <> -1 then
		astr_bcmreference = lnv_bcm.GetBCM(FALSE)
	end if

	astr_bcmreference.l_rows = ll_rows  //indicate status back to query object

end if

if this.ib_remote then
	destroy lnv_bcm
end if

return ll_rows

end function

public function n_cst_bcm loaddefinition (readonly string as_query);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		LoadDefinition
//
//	Arguments:		as_dlk  		dlk to use for this bcm
//
//	Returns:			BCM
//
//	Description:	Creates a valid DLK
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   	Initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_bcm lnv_bcm

if not this.DBConnect() then
	this.PushException("loaddefinition")
	return lnv_bcm
end if

if IsValid(inv_bcm) then
	lnv_bcm = inv_bcm
else
	lnv_bcm = this.GetBCMMGR().CreateBCM()
end if

if IsValid(lnv_bcm) then
	
	if IsValid(lnv_bcm) then  //  Make sure bcm did not get destroyed from previous code block
		lnv_bcm.Setlocal(true)
		lnv_bcm.SetQuery(as_query)
		lnv_bcm.SetDatabase(inv_database)	
		if lnv_bcm.CreateDLK() = -1 then
			this.PushException("loaddefinition")
			this.GetBCMMgr().DestroyBCM(lnv_bcm)
		end if
	end if
end if

return lnv_bcm

end function

public function s_bcmreference newbeo (readonly string as_query, readonly string as_classname[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		NewBEO
//
//	Arguments:		as_query  		dlk to use for this bcm
//						as_classname   class to create.
//
//	Returns:			BCM Reference - Serialized BCM
//
//	Description:	When using Thin Client mode, we need to add the row on the
//						server side and then serialize it back.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   	Initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_bcm 		lnv_bcm
s_bcmreference lstr_bcmreference
n_cst_beo 		lnv_beo
integer li_pos, li_total

lnv_bcm = this.LoadDefinition(as_query)
if isValid(lnv_bcm) then
	li_total = UpperBound(as_classname)
	for li_pos = 1 to li_total
		lnv_bcm.AddClass(as_classname[li_pos])	
	next
	if lnv_bcm.NewBEO(lnv_beo) = -1 then
		lstr_bcmreference.l_rows = -1  
	end if
	lstr_bcmreference = lnv_bcm.GetBCM(FALSE)
	this.GetBCMMgr().DestroyBCM(lnv_bcm)
else
	lstr_bcmreference.l_rows = -1  
end if

return lstr_bcmreference

end function

public function boolean setconnecttodatabase (readonly boolean ab_value);//
// Function:		SetRemote
//
//	Arguments:		ab_value False - The sso should not connect to the database.
//									True - The sso should connect to the database.
//
//	Returns:			Boolean
//
//	Description:	Set ib_connecttodatabase.  
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

ib_connecttodatabase = ab_value

return true
end function

public function long retrievebcm (string as_query, string as_relationship, string as_dlk_relation, any aa_keyvalue1, any aa_keyvalue2, any aa_keyvalue3, any aa_keyvalue4, any aa_keyvalue5, any aa_keyvalue6, any aa_keyvalue7, any aa_keyvalue8, any aa_keyvalue9, any aa_keyvalue10, any aa_keyvalue11, any aa_keyvalue12, any aa_keyvalue13, any aa_keyvalue14, any aa_keyvalue15, any aa_keyvalue16, ref s_bcmreference astr_bcmreference, boolean ab_byref);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RetrieveBCM
//
//	Arguments:		as_query  			string dlk, dataobject or beo
//						as_relationship   Relationship name for Class DLK retrievals
//						aa_keyvalue1 THRU aa_keyvalue16  Argument values
//						astr_bcmreference	BCM represented as a structure
//						ab_byref 			Return BCM by reference. Don't serialize it.
//
//	Returns:			Long - # of retrieved rows
//
//	Description:	Retrieve a BCM result set
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_bcm 		lnv_bcm
long 				ll_rows

if not this.DBConnect() then
	this.PushException("retrievebcm")
	return -1
end if

//the bcm was created by getdefinition()
if IsValid(inv_bcm) then
	lnv_bcm = inv_bcm
else
	lnv_bcm = this.GetBCMMGR().CreateBCM()
end if

if isValid(lnv_bcm) then
	lnv_bcm.SetLocal(true)
	lnv_bcm.SetAppend(FALSE) //done client side
	lnv_bcm.SetDatabase(inv_database)
	lnv_bcm.SetQuery(as_query)
	lnv_bcm.SetDLKRelation(as_dlk_relation)
			
	ll_rows = lnv_bcm.Retrieve( aa_keyvalue1, aa_keyvalue2, aa_keyvalue3, aa_keyvalue4, &
			aa_keyvalue5, aa_keyvalue6, aa_keyvalue7, aa_keyvalue8, aa_keyvalue9, aa_keyvalue10, &
			aa_keyvalue11, aa_keyvalue12, aa_keyvalue13, aa_keyvalue14, aa_keyvalue15, aa_keyvalue16, as_relationship)

	if ll_rows <> -1 then
		astr_bcmreference = lnv_bcm.GetBCM(ab_byref)
	end if

	astr_bcmreference.l_rows = ll_rows  //indicate status back to query object

end if

if this.ib_remote then
	destroy lnv_bcm
end if

return ll_rows

end function

public function s_bcmreference getdefinition (readonly string as_query, boolean ab_byref);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDefinition
//
//	Arguments:		as_query  		dlk to use for this bcm
//						ab_byref 			Return BCM by reference. Don't serialize it.
//
//	Returns:			BCM Reference - Serialized BCM
//
//	Description:	Creates an empty BCM based on for a class
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   	Initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_bcm 		lnv_bcm
s_bcmreference lstr_bcmreference

lnv_bcm = this.LoadDefinition(as_query)
if isValid(lnv_bcm) then
	lstr_bcmreference = lnv_bcm.GetBCM(ab_byref)
	if NOT ab_byref then
		this.GetBCMMgr().DestroyBCM(lnv_bcm)
	end if
else
	lstr_bcmreference.l_rows = -1  
end if

return lstr_bcmreference

end function

public function long retrieveremotebcm (string as_query, string as_relationship, string as_dlk_relation, ref blob ablb_bcm, blob ablb_args);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RetrieveRemoteBCM
//
//	Arguments:		as_query  			string dlk, dataobject or beo
//						as_relationship   Relationship name for Class DLK retrievals
//						lblb_args		   Blob Argument values to be deserialized
//						ablb_bcm				Serialized BCM in blob for remote calls
//
//	Returns:			Long - # of retrieved rows
//
//	Description:	Retrieve a BCM result set
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_bcm 		lnv_bcm
long 				ll_rows
any				la_bcm, la_args[]

if not this.DBConnect() then
	this.PushException("retrieveremotebcm")
end if

//the bcm was created by getdefinition()
if IsValid(inv_bcm) then
	lnv_bcm = inv_bcm
else
	lnv_bcm = this.GetBCMMGR().CreateBCM()
end if

if isValid(lnv_bcm) then
	lnv_bcm.SetAppend(FALSE) //done client side
	lnv_bcm.SetLocal(true)
	lnv_bcm.SetDatabase(inv_database)
	this.DeserializeArgs(la_args, ablb_args)
	lnv_bcm.SetQuery(as_query)
	lnv_bcm.SetDLKRelation(as_dlk_relation)
	
	ll_rows = lnv_bcm.Retrieve( la_args[1], la_args[2], la_args[3], la_args[4], &
			la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], &
			la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], &
			as_relationship)

	if lnv_bcm.GetBCM(false, la_bcm) = 1 then
		ablb_bcm = la_bcm
	else
		this.PushException("retrievebcm")
	end if
end if

destroy lnv_bcm


return ll_rows


end function

public function integer getremotedefinition (string as_query, ref blob ablb_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetRemoteDefinition
//
//	Arguments:		as_query  		dlk to use for this bcm
//						as_class			class to get definition for
//						ablb_bcm			Blob containing BCM.
//
//	Returns:			integer	
//
//	Description:	Creates an empty BCM that will be serialized back to the client.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   	Initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_rc
n_cst_bcm 		lnv_bcm
any la_bcm


lnv_bcm = this.LoadDefinition(as_query)
if isValid(lnv_bcm) then
	li_rc = lnv_bcm.GetBCM(false, la_bcm)
	if li_rc = 1 then
		ablb_bcm = la_bcm
	end if
	this.GetBCMMgr().DestroyBCM(lnv_bcm)
else
	li_rc = -1  
end if

return li_rc

end function

public function integer saveremote (ref blob ablb_bcm1, ref blob ablb_bcm2, ref blob ablb_bcm3, ref blob ablb_bcm4, ref blob ablb_bcm5, ref blob ablb_bcm6, ref blob ablb_bcm7, ref blob ablb_bcm8, ref blob ablb_bcm9, ref blob ablb_bcm10, ref blob ablb_bcm11, ref blob ablb_bcm12, ref blob ablb_bcm13, ref blob ablb_bcm14, ref blob ablb_bcm15, ref blob ablb_bcm16);//////////////////////////////////////////////////////////////////////////////
//
// Function:		SaveRemote
//
//	Arguments:		ablb_bcm1 thru ablb_bcm16	BCM's to update
//
//	Returns:			1 Succeeded
//						-1 Failed
//
//	Description:	Calls the transaction Manager to update the database
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
integer 		li_rc = 1, li_bcm, li_bcms
blob	  		lblb_bcm[16]
n_cst_bcm   lnv_bcm[16]
n_cst_txmgr lnv_txmgr


if not this.dbconnect() then
	this.PushException("saveremote")
	return -1
end if

lnv_txmgr = CREATE n_cst_txmgr

//can't pass arrays to mts so set up array now
lblb_bcm[1] = ablb_bcm1
lblb_bcm[2] = ablb_bcm2
lblb_bcm[3] = ablb_bcm3
lblb_bcm[4] = ablb_bcm4
lblb_bcm[5] = ablb_bcm5
lblb_bcm[6] = ablb_bcm6
lblb_bcm[7] = ablb_bcm7
lblb_bcm[8] = ablb_bcm8
lblb_bcm[9] = ablb_bcm9
lblb_bcm[10] = ablb_bcm10
lblb_bcm[11] = ablb_bcm11
lblb_bcm[12] = ablb_bcm12
lblb_bcm[13] = ablb_bcm13
lblb_bcm[14] = ablb_bcm14
lblb_bcm[15] = ablb_bcm15
lblb_bcm[16] = ablb_bcm16


for li_bcm = 1 to 16
	if len(lblb_bcm[li_bcm]) > 0 then
		lnv_bcm[li_bcm] = this.GetBCMMgr().CreateBCM(lblb_bcm[li_bcm], TRUE)
		if isValid(lnv_bcm[li_bcm]) then
			lnv_txmgr.Register(lnv_bcm[li_bcm])
		end if
	end if
next

li_rc = lnv_txmgr.Save()
if li_rc <> 1 then
	this.PropagateErrors(lnv_txmgr)
	li_rc = -1
end if

DESTROY lnv_txmgr

return li_rc

end function

public function integer newbeoremote (string as_query, string as_classname[], ref blob ablb_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		NewBEORemote
//
//	Arguments:		as_query  		dlk to use for this bcm
//						as_classname   class to create.
//						ablb_bcm			Serialized BCM by reference.
//
//	Returns:			Integer 
//
//	Description:	When using Thin Client mode, we need to add the row on the
//						server side and then serialize it back.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   	Initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_bcm 		lnv_bcm
s_bcmreference lstr_bcmreference
n_cst_beo 		lnv_beo
integer li_pos, li_total, li_rc = -1
any la_bcm

lnv_bcm = this.LoadDefinition(as_query)
if isValid(lnv_bcm) then
	li_total = UpperBound(as_classname)
	for li_pos = 1 to li_total
		lnv_bcm.AddClass(as_classname[li_pos])	
	next
	if lnv_bcm.NewBEO(lnv_beo) = -1 then
		li_rc = -1  
	end if
	li_rc = lnv_bcm.GetBCM(FALSE, la_bcm)
	if li_rc > 0 then
		ablb_bcm = la_bcm
	end if
	this.GetBCMMgr().DestroyBCM(lnv_bcm)
else
	li_rc = -1  
end if

return li_rc

end function

on ofr_n_cst_sso.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_sso.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;if not isValid(this.GetBCMMGR()) then
	inv_bcmmgr = create n_cst_bcmmgr
end if
end event

event destructor;call super::destructor;//destroy inv_bcmmgr

this.dbdisconnect()



end event

