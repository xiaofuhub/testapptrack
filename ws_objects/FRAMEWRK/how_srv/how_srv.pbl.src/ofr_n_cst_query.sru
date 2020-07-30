$PBExportHeader$ofr_n_cst_query.sru
$PBExportComments$Handles communication to sso for retrieves
forward
global type ofr_n_cst_query from n_cst_base
end type
end forward

global type ofr_n_cst_query from n_cst_base
end type
global ofr_n_cst_query ofr_n_cst_query

type variables
protected:

  any                    ia_args[] 
  n_cst_sso          inv_sso 
  n_cst_database inv_database
  n_cst_bcm         inv_bcm

end variables

forward prototypes
public function integer setargument (readonly any aa_argument)
public subroutine setsso (n_cst_sso anv_sso)
public subroutine setdatabase (n_cst_database anv_database)
public function integer cleararguments ()
public function boolean setbcm (n_cst_bcm anv_bcm)
public function n_cst_bcm getdefinition (readonly string as_query)
public function n_cst_bcm executequery (string as_query, readonly string as_relationship, readonly string as_dlk_relation)
public function n_cst_bcm executebeokeyquery (readonly blob ab_key)
public function n_cst_bcm executequery (string as_query)
public function integer setarguments (readonly any aa_arguments[])
end prototypes

public function integer setargument (readonly any aa_argument);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetArgument
//
//	Arguments:		aa_argument		Retrieval argument
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Saves retrieval argument
//						FOR INTERNAL USE ONLY
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
int li_arg

li_arg = UpperBound(ia_args) + 1
ia_args[li_arg] = aa_argument

return 1

end function

public subroutine setsso (n_cst_sso anv_sso);//////////////////////////////////////////////////////////////////////////////
//
// Function:		SetSSO
//
//	Arguments:		anv_sso  An instanciated SSO
//
//	Returns:			None
//
//	Description:	Sets an instance of sso on the query object
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

inv_sso = anv_sso

end subroutine

public subroutine setdatabase (n_cst_database anv_database);//////////////////////////////////////////////////////////////////////////////
//
// Function:		SetDatabase
//
//	Arguments:		anv_database	Valid database instance
//
//	Returns:			None
//
//	Description:	Set the database reference for this query
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

this.inv_database = anv_database
end subroutine

public function integer cleararguments ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ClearArguments
//
//	Arguments:		None
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Clears the argument array (ia_args[] ) for the Query object
//						FOR INTERNAL USE ONLY
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
integer li_rc = 1
any la_init[]

ia_args = la_init

if UpperBound(ia_args) > 0 then
	li_rc = -1
end if

return li_rc
end function

public function boolean setbcm (n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBCM
//
//	Arguments:		None
//
//	Returns:			boolean true
//
//	Description:	Set the bcm to be used by the SSO.  The sso will not create
//						a bcm if this bcm exists.
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
if inv_database.GetRemote() = FALSE then
	if not isValid(inv_sso) then
		if not inv_database.Open() then
			return false
		end if
	end if
	inv_sso.SetBCM(anv_bcm)
end if

inv_bcm = anv_bcm

return true
end function

public function n_cst_bcm getdefinition (readonly string as_query);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDefinition
//
//	Arguments:		as_query		A class dlk
//
//	Returns:			n_cst_bcm
//
//	Description:	Invokes sso.GetDefinition to return an empty bcm
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
///////////////////////////////////////////////////////////////////////////////
n_cst_bcm 		lnv_bcm
s_bcmreference lstr_bcm
string 			ls_class, ls_query
blob lblb_bcm

if not isValid(inv_database) then
	return lnv_bcm
end if

if not isValid(inv_sso) then
	if not inv_database.Open() then
		return lnv_bcm
	end if
end if

if not inv_database.GetRemote() then
	if not IsValid(inv_bcm) then
		lnv_bcm = this.GetBCMMgr().CreateBCM()
		if isValid(lnv_bcm) then
			lnv_bcm.SetDLK(as_query)
		end if
	else
		lnv_bcm = inv_bcm
	end if
else
	if isValid(inv_bcm) then
		lnv_bcm = inv_bcm
		ls_query = inv_bcm.GetQueryName()
	end if
	
	if inv_database.GetUseStructureSerialization() = TRUE then
		lstr_bcm = inv_sso.GetDefinition(ls_query, not inv_database.GetRemote())
		If IsValid(lnv_bcm) then 
			if lstr_bcm.l_rows <> -1 then
				if not isValid(lstr_bcm.nv_bcm) then
					if lnv_bcm.SetBCM(lstr_bcm) <> 1 then
						this.PushException("GetDefinition")
						SetNull(lnv_bcm) //avoid gpf
					end if
				end if
			else
				this.PushException("GetDefinition")
			end if
		Else
			lnv_bcm = this.GetBCMMgr().CreateBCM(lstr_bcm, FALSE)
			if isValid(lnv_bcm) then
				lnv_bcm.SetDatabase(this.inv_database)
			end if
		end if
	else
		if inv_sso.GetRemoteDefinition(ls_query, ref lblb_bcm) = 1 then
			If IsValid(lnv_bcm) then 
				if Len(lblb_bcm) > 0 then
					if lnv_bcm.SetBCM(lblb_bcm) <> 1 then
						this.PushException("GetDefinition")
						SetNull(lnv_bcm) //avoid gpf
					end if
				else
					this.PushException("GetDefinition")
				end if
			Else
				lnv_bcm = this.GetBCMMgr().CreateBCM(lblb_bcm, FALSE)
				if isValid(lnv_bcm) then
					lnv_bcm.SetDatabase(this.inv_database)
				end if
			end if
		end if
	end if
end if

return lnv_bcm
end function

public function n_cst_bcm executequery (string as_query, readonly string as_relationship, readonly string as_dlk_relation);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ExecuteQuery
//
//	Arguments:		as_query				string - Either class dlk used for retrieval or 
//												the beo prefix will be changed to a class dlk - cdlk
//						as_relationship	string - BEO class relationship
//						as_dlk_relation	string - <relation> for <role>  Example: "Department" for Employee
//										
//	Returns:			n_cst_bcm
//
//	Description:	Invokes the sso and retrieves through it
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
///////////////////////////////////////////////////////////////////////////////
long				ll_rows
string 			ls_query
string			ls_beo_prefix
string			ls_classdlk_prefix
s_bcmreference lstr_bcm
any 				la_bcm, la_null
blob				lblb_bcm, lblb_args
n_cst_bcm      lnv_bcm
integer        li_len

//if a beo is passed in get the associated dlk

//  If a beo is passed in as the query than replace the beo prefix with
//  class dlk prefix.  i.e. n_cst_beo_expense_report --> n_cst_dlkc_expensereport
ls_beo_prefix = this.GetBCMMgr().GetBEOPrefix()
ls_classdlk_prefix = this.GetBCMMgr().GetClassDLKPrefix()
li_len = len(ls_beo_prefix) 
if Left(as_query, li_len) = ls_beo_prefix then
	ls_query = ls_classdlk_prefix + Mid(as_query, li_len + 1)
else
	ls_query = as_query
end if

if not isValid(inv_database) then
	return lnv_bcm
end if

if not isValid(inv_sso) then
	if not inv_database.Open() then
		return lnv_bcm
	end if
end if

lnv_bcm = inv_bcm
SetNull(inv_bcm)

if UpperBound(ia_args) < 16 then
	ia_args[18] = la_null
end if

if inv_database.GetRemote() = FALSE then
	inv_sso.SetConnectToDataBase(false)
end if

if inv_database.GetRemote() and inv_database.GetUseStructureSerialization() = false then
	lblb_args = SerializeArgs(ia_args)
	ll_rows = inv_sso.RetrieveRemoteBCM( ls_query, as_relationship, as_dlk_relation, ref lblb_bcm, lblb_args)

	// Deserialize into BCM that we already have.	
	if IsValid(lnv_bcm) then
		if lnv_bcm.SetBCM(lblb_bcm) <> 1 then
			this.PushException("executequery")
			SetNull(lnv_bcm)  //avoid gpf
		end if
	else
		lnv_bcm = this.GetBCMMgr().CreateBCM(lblb_bcm, FALSE)
		lnv_bcm.SetDatabase(inv_database)
	end if
else
	if IsValid(lnv_bcm) and inv_database.GetUseStructureSerialization() = false then
		inv_sso.SetBCM(lnv_bcm)
	end if
	
	ll_rows = inv_sso.RetrieveBCM( ls_query, as_relationship, as_dlk_relation, ia_args[1], ia_args[2], &
			ia_args[3], ia_args[4], ia_args[5], ia_args[6], ia_args[7], ia_args[8], &
			ia_args[9], ia_args[10], ia_args[11], ia_args[12], ia_args[13], ia_args[14], ia_args[15], &
			ia_args[16], ref lstr_bcm, not inv_database.GetRemote())
	
	if ll_rows <> -1 then
		
		// Deserialize into BCM that we already have.	
		if IsValid(lnv_bcm) then
			if not isValid(lstr_bcm.nv_bcm) then
				if lstr_bcm.l_rows <> -1 then
					if lnv_bcm.SetBCM(lstr_bcm) <> 1 then
						this.PushException("executequery")
						SetNull(lnv_bcm) //avoid gpf
					end if
				end if
			end if
		else
			lnv_bcm = this.GetBCMMgr().CreateBCM(lstr_bcm, FALSE)
			lnv_bcm.SetDatabase(inv_database)
		end if
	end if
end if

this.ClearArguments()
		
return lnv_bcm

end function

public function n_cst_bcm executebeokeyquery (readonly blob ab_key);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ExecuteBEOKeyQuery
//
//	Arguments:		ab_key				Blob - Serialized BEO Key's
//										
//	Returns:			n_cst_bcm
//
//	Description:	Invokes the sso and retrieves through it
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
///////////////////////////////////////////////////////////////////////////////
long				ll_rows
string 			ls_query, ls_beo_prefix, ls_dlk_prefix
s_bcmreference lstr_bcm
any 				la_bcm, la_null
n_cst_bcm      lnv_bcm
integer        li_len


if not isValid(inv_database) then
	return lnv_bcm
end if

if not isValid(inv_sso) then
	if not inv_database.Open() then
		return lnv_bcm
	end if
end if

if not IsValid(inv_sso) then
	return lnv_bcm
end if

lnv_bcm = inv_bcm
SetNull(inv_bcm)

if UpperBound(ia_args) < 16 then
	ia_args[18] = la_null
end if

if IsValid(lnv_bcm) and inv_database.GetUseStructureSerialization() = false then
		inv_sso.SetBCM(lnv_bcm)
end if
	
ll_rows = inv_sso.RetrieveBCMWithBEOKey( ab_key, lstr_bcm )

if ll_rows <> -1 then
	// Deserialize into BCM that we already have.	
	if IsValid(lnv_bcm) then
		if not isValid(lstr_bcm.nv_bcm) then
			if lstr_bcm.l_rows <> -1 then
				if lnv_bcm.SetBCM(lstr_bcm) <> 1 then
					this.PushException("executequery")
					SetNull(lnv_bcm) //avoid gpf
				end if
			end if
		end if
	else
		lnv_bcm = this.GetBCMMgr().CreateBCM(lstr_bcm)
		lnv_bcm.SetDatabase(inv_database)
	end if
end if

return lnv_bcm

end function

public function n_cst_bcm executequery (string as_query);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ExecuteQuery
//
//	Arguments:		as_query				string - Either class dlk used for retrieval or 
//												the beo prefix will be changed to a class dlk - cdlk
//										
//	Returns:			n_cst_bcm
//
//	Description:	Invokes the sso and retrieves through it
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
///////////////////////////////////////////////////////////////////////////////
return this.ExecuteQuery(as_query, "", "")
end function

public function integer setarguments (readonly any aa_arguments[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetArguments
//
//	Arguments:		aa_argument		Retrieval argument array
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Saves retrieval arguments
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
ia_args[] = aa_arguments

return 1

end function

on ofr_n_cst_query.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_query.destroy
TriggerEvent( this, "destructor" )
end on

