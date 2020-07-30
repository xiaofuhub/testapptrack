$PBExportHeader$ofr_n_cst_bcmmgr.sru
forward
global type ofr_n_cst_bcmmgr from n_cst_base
end type
end forward

global type ofr_n_cst_bcmmgr from n_cst_base
end type
global ofr_n_cst_bcmmgr ofr_n_cst_bcmmgr

type variables
public:
n_cst_beolog inv_beolog

protected:
boolean                       ib_pb_row_id
n_cst_bcm                  inv_bcm[]
n_cst_database          inv_database[]
n_cst_database          inv_default_database
long                             ll_bcm_index
string is_businesscollectionmanager = "n_cst_bcm"
string is_default_database_name = "n_cst_database"
string                           is_inifilename
string                           is_dlk_prefix = 'n_cst_dlk'
string                           is_beo_prefix = 'n_cst_beo'
string		   is_classdlk_prefix = 'n_cst_dlkc'
Boolean 		ib_KeepListofBCMs = TRUE
end variables

forward prototypes
public function n_cst_bcm createbcm (readonly string as_bcm_classname, readonly string as_beo_classname)
public function n_cst_bcm_init getbcminit (readonly string as_bcm_classname, readonly string as_beo_classname)
public function integer GetBCMs (ref n_cst_bcm anv_bcms[])
public function nonvisualobject getexception ()
public function n_cst_bcm initbcm (readonly n_cst_bcm_init anv_bcm_init)
public function integer registerbcm (readonly nonvisualobject anv_bcm, readonly long al_bcm_index)
public function integer SetDebug (readonly boolean ab_flag)
public function integer SetLog (readonly boolean ab_switch)
public function integer destroybcm (n_cst_bcm anv_bcm)
protected function ofr_n_cst_bcm createthebcm (readonly string as_bcmname)
public function n_cst_bcm createbcm ()
public function n_cst_bcm createdescendantbcm (readonly string as_bcm_classname)
public function n_cst_database getdatabase (string as_name)
public function integer setdefaultdatabase (n_cst_database anv_database)
public function n_cst_database createdatabase ()
public function integer registerdatabase (n_cst_database anv_database)
public function n_cst_database createdatabase (string as_name)
public function integer destroydatabase (n_cst_database anv_database)
public subroutine getdatabase (ref n_cst_database anv_database[])
public function n_cst_database getdefaultdatabase ()
public function boolean setbcmclassname (string as_bcmclassname)
public function boolean getpbrowidind ()
public function boolean setpbrowidind (readonly boolean ab_flag)
public function n_cst_bcm createbcm (any any_bcm)
public function n_cst_database getdatabase ()
public subroutine setdefaultdatabase (string as_name)
public subroutine setinifile (string as_name)
public function string getbeoprefix ()
public function string getdlkprefix ()
public function string getbcmclassname ()
public function boolean setdlkprefix (readonly string as_dlk_prefix)
public function boolean setbeoprefix (readonly string as_beo_prefix)
public function n_cst_bcm getbcmbyindex (long al_bcmindex)
public function string getclassdlkprefix ()
public subroutine setkeeplistofbcms (boolean ab_flag)
protected function string getbcmtypefromblob (ref blob ablb_bcm)
public function n_cst_bcm createbcm (any any_bcm, boolean ab_islocal)
public function boolean ispbrowidon ()
end prototypes

public function n_cst_bcm createbcm (readonly string as_bcm_classname, readonly string as_beo_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateBCM
//
//	Arguments:		as_bcm_classname	BCM class name
//						as_beo_classname	BO class name
//
//	Returns:			n_cst_bcm	Returns created BCM - null if error
//
//	Description:	Creates a BCM based on the specified BCM class.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.0.1		Correct exception error number
//	1.02.5	Add GetBCMInit and InitBCM calls
// 2.00 		Class name not required.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_bcm lnv_ret_bcm
n_cst_bcm_init lnv_bcm_init

// make sure a classname was passed in
//svh commented out????
//if ( as_beo_classname = "" ) then return lnv_ret_bcm

lnv_bcm_init = this.GetBCMInit(as_bcm_classname, as_beo_classname)

lnv_ret_bcm = this.InitBCM(lnv_bcm_init)
if not IsValid(lnv_ret_bcm) then
	this.PushException("createbcm")
end if

return lnv_ret_bcm

end function

public function n_cst_bcm_init getbcminit (readonly string as_bcm_classname, readonly string as_beo_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCMInit
//
//	Arguments:		as_bcm_classname	BCM class name
//						as_beo_classname	BO class name
//
//	Returns:			n_cst_bcm_init		Returns BCM initialization object
//
//	Description:	Creates a BCM initialization object.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.02.5   Initial version
//	1.2		Add ll_bcm_index
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_bcm_init lnv_bcm_init

// make sure a classname was passed in
//svh commented out????
//if ( as_beo_classname = "" ) then return lnv_bcm_init

lnv_bcm_init = create n_cst_bcm_init
this.ll_bcm_index++
lnv_bcm_init.ll_bcm_index = this.ll_bcm_index
lnv_bcm_init.is_bcm_classname = as_bcm_classname
if as_beo_classname <> "" then
	lnv_bcm_init.is_beo_classname[1] = as_beo_classname
end if

return lnv_bcm_init

end function

public function integer GetBCMs (ref n_cst_bcm anv_bcms[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCMs
//
//	Arguments:		anv_bcms[]		Reference array of BCMs
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Gets pointer to BCM array
//						for INTERNAL OFR USE ONLY.
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
anv_bcms = inv_bcm

return 1

end function

public function nonvisualobject getexception ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetException
//
//	Arguments:		none
//
//	Returns:			Exception service (n_cst_exception)
//
//	Description:	Returns exception service
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
return inv_exception

end function

public function n_cst_bcm initbcm (readonly n_cst_bcm_init anv_bcm_init);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		InitBCM
//
//	Arguments:		anv_bcm_init
//
//	Returns:			n_cst_bcm	Returns created BCM - null if error
//
//	Description:	Creates a BCM using passed initialization object.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.02.5   Initial version
//	1.2		Moved BCM registration to RegisterBCM
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ofr_n_cst_bcm lnv_ret_bcm
ofr_n_cst_bcm_init lnv_bcm_init
PowerObject lpo_parm

if not IsValid(anv_bcm_init) then
	return lnv_ret_bcm
end if

lpo_parm = Message.PowerObjectParm
Message.PowerObjectParm = anv_bcm_init
lnv_ret_bcm = this.CreateTheBCM(anv_bcm_init.is_bcm_classname)
destroy anv_bcm_init
Message.PowerObjectParm = lpo_parm

if not IsValid ( lnv_ret_bcm ) then
	this.SetException("initbcm", "26999", {anv_bcm_init.is_bcm_classname, lnv_bcm_init.is_beo_classname[1]})
else
	lnv_ret_bcm.SetDatabase(this.GetDatabase())
end if

return lnv_ret_bcm

end function

public function integer registerbcm (readonly nonvisualobject anv_bcm, readonly long al_bcm_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterBCM
//
//	Arguments:		anv_bcm			BCM to register
//						al_bcm_index	BCM Index
//
//	Returns:			Integer	1	Success
//									-1	Error
//
//	Description:	Registers BCM, called from BCM constructor event
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version

//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// The Developer can choose not to keep track of BCMs so that PB garbage collection
// can clean them up as needed.
if ib_keeplistofbcms = TRUE then
	inv_bcm[al_bcm_index] = anv_bcm
	
	//		This can happen when BCM's are copied from other machines
	if al_bcm_index > ll_bcm_index then
		ll_bcm_index = al_bcm_index
	end if
end if

return 1

end function

public function integer SetDebug (readonly boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDebug
//
//	Arguments:		Boolean	-	ab_flag
//
//	returns:			None
//
//	Description:	Turns debugging on/off.
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


return inv_exception.SetDebug(ab_flag)

end function

public function integer SetLog (readonly boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetLog
//
//	Arguments:		ab_switch	Switch to turn log on or off
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Turns log service on or off.
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
Int li_rc = 1

if ab_switch = TRUE then
	if not IsValid(inv_beolog) then
		inv_beolog = Create n_cst_beolog
		if not IsValid(inv_beolog) then
			li_rc = -1
		end if
	end if
else
	if IsValid(inv_beolog) then
		Destroy inv_beolog
	end if
end if

return li_rc

end function

public function integer destroybcm (n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DestroyBCM
//
//	Arguments:		anv_bcm	BCM to destroy
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Destroys the specified BCM instance
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 2.1   Unregister the bcm's with  the database object
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_end, li_obj

DESTROY anv_bcm

if IsValid ( anv_bcm ) then
	return -1
end if

return 1
end function

protected function ofr_n_cst_bcm createthebcm (readonly string as_bcmname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateTheBCM
//
//	Arguments:		as_bcmname	BCM class name
//
//	Returns:			n_cst_bcm	Returns created BCM - null if error
//
//	Description:	Creates a BCM based on the specified BCM class.  Overridden in 
//						dbf_n_cst_bommgr to fix PB5.0.02 bug.
//                FOR INTERNAL USE ONLY
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
ofr_n_cst_bcm lnv_bcm

lnv_bcm = create using as_bcmname

return lnv_bcm
end function

public function n_cst_bcm createbcm ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateBCM
//
//	Arguments:		none
//
//	Returns:			n_cst_bcm	Returns created BCM - null if error
//
//	Description:	Creates a BCM based on n_cst_bcm
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.02.5	Changes to support BCMCopy
// 2.00 		Class name not required.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.CreateBCM(is_businesscollectionmanager, "")

end function

public function n_cst_bcm createdescendantbcm (readonly string as_bcm_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateDescendantBCM
//
//	Arguments:		as_bcm_classname	BCM class name
//
//	Returns:			n_cst_bcm	Returns created BCM - null if error
//
//	Description:	Creates a BCM based on the specified BCM class.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.0.1		Correct exception error number
//	1.02.5	Add GetBCMInit and InitBCM calls
// 2.00 		Class name not required.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return this.CreateBCM(as_bcm_classname, "")

end function

public function n_cst_database getdatabase (string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDatabase
//
//	Arguments:		as_name		Name of the Database to return
//
//	Returns:			n_cst_database instance or uninstanciated object if name not found.
//
//	Description:	Returns an instance of an database in which the name is 
//						equal to as_name
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

integer  li_end, li_idx

li_end = UpperBound(inv_database)

for li_idx = 1 to li_end
	if inv_database[li_idx].ClassName() = as_name then
		return inv_database[li_idx]
	end if
next

return this.CreateDatabase(as_name)
end function

public function integer setdefaultdatabase (n_cst_database anv_database);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetdefaultDatabase
//
//	Arguments:		anv_database	The database uilink should use as the default
//
//	Returns:			integer     	1 success
//									  		-1 invalid database passed in
//
//	Description:	Sets the database to be used by uilink when an specific
//						database is not defined for a uilink.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

if isValid(anv_database) then
	inv_default_database = anv_database
	return 1
else
	return -1
end if
end function

public function n_cst_database createdatabase ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateDatabase
//
//	Arguments:		None
//
//	Returns:			n_cst_database
//
//	Description:	Creates an database and registers it in the array.  Use this function
//						when you only need one database. A name is not required to 
//						distinguish it.
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

return this.CreateDatabase(is_default_database_name)
end function

public function integer registerdatabase (n_cst_database anv_database);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterDatabase
//
//	Arguments:		anv_database		Database to add to the registration array
//
//	Returns:			Integer
//						1		success
//						-1		invalid database
//
//	Description:	Adds database instance to inv_database array

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

integer li_element

if not isValid(anv_database) then
	return -1
else
	li_element = UpperBound(inv_database)
	li_element++
	inv_database[li_element] = anv_database
	return 1
end if
end function

public function n_cst_database createdatabase (string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateDatabase
//
//	Arguments:		as_name     		Name of the database
//
//	Returns:			n_cst_database    An instance of the database
//
//	Description:	Creates an database, sets the name of it and registers it.
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

n_cst_database   lnv_database

lnv_database = create using as_name

this.RegisterDatabase(lnv_database)
lnv_database.SetIniFile(is_inifilename)

return lnv_database
end function

public function integer destroydatabase (n_cst_database anv_database);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DestroyDatabase
//
//	Arguments:		anv_database	database to destroy
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Destroys the specified database instance
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
int li_rc = -1

DESTROY anv_database

if not IsValid ( anv_database ) then
	li_rc = 1
end if

return li_rc

end function

public subroutine getdatabase (ref n_cst_database anv_database[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDatabase
//
//	Arguments:		anv_database[] by reference
//
//	Returns:			None
//
//	Description:	Sets a pointer to the array of registered databases.
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

anv_database = inv_database

end subroutine

public function n_cst_database getdefaultdatabase ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDefaultDatabase
//
//	Arguments:		None.
//
//	Returns:			n_cst_database
//
//	Description:	Return the default database. If it doesn't exist then create one
//						and return that.
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

if isvalid(inv_default_database) then
	return inv_default_database
else
	inv_default_database = this.CreateDatabase()
	return inv_default_database
end if
end function

public function boolean setbcmclassname (string as_bcmclassname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBCMClassName
//
//	Arguments:		as_bcmclassname
//
//	Returns:			boolean  True
//
//	Description:	Sets the default classname for the BCM.	
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


is_businesscollectionmanager = as_bcmclassname

return true
end function

public function boolean getpbrowidind ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetPBRowIDInd
//
//	Arguments:		None
//
//	returns:			Boolean
//
//	Description:	Return indicator for OFR BEO Indexing on/off.  PB 6.0 has 
//						function GetRowIDfromRow to get the equivalent of our beo_index
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

return ib_pb_row_id 

end function

public function boolean setpbrowidind (readonly boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetPBRowIDInd
//
//	Arguments:		Boolean	-	ab_flag
//
//	returns:			Boolean
//
//	Description:	Turns OFR BEO Indexing on/off.  PB 6.0 has function GetRowIDfromRow
//						to get the equivalent of our beo_index
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


return ib_pb_row_id = ab_flag

end function

public function n_cst_bcm createbcm (any any_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateBCM
//
//	Arguments:		any_bcm		Serialized BCM or BCM reference
//
//	Returns:			n_cst_bcm	Returns created BCM - null if error
//
//	Description:	Creates a BCM based on the specified BCM class.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return this.CreateBCM(any_bcm, false)

end function

public function n_cst_database getdatabase ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDatabase
//
//	Returns:			n_cst_database instance or uninstanciated object if name not found.
//
//	Description:	Returns an instance of an database in which the name is 
//						equal to as_name
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

return this.GetDatabase(is_default_database_name)
end function

public subroutine setdefaultdatabase (string as_name);is_default_database_name = as_name
end subroutine

public subroutine setinifile (string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateBCM
//
//	Arguments:		Name of ini file.
//
//	Returns:			none
//
//	Description:	Sets name of ini file that contains application information.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

is_inifilename = as_name

is_default_database_name = ProfileString(as_name, "Default Database", "Name", "n_cst_database")
end subroutine

public function string getbeoprefix ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOPrefix
//
//	Returns:			String	The prefix for the beo
//
//	Description:	Returns the prefix for beo's (ie n_cst_beo_)
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

return is_beo_prefix
end function

public function string getdlkprefix ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDLKPrefix
//
//	Returns:			String	The prefix for the dlk
//
//	Description:	Returns the prefix for dlk's (ie n_cst_dlk_)
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

return is_dlk_prefix
end function

public function string getbcmclassname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCMClassname
//
//	Returns:			String	The BCM class name
//
//	Description:	Returns the class name for bcms (ie n_cst_bcm_)
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

return is_businesscollectionmanager
end function

public function boolean setdlkprefix (readonly string as_dlk_prefix);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDLKPrefix
//
//	Returns:			Boolean
//
//	Description:	Sets the prefix for DLK's
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

is_dlk_prefix = as_dlk_prefix

return true
end function

public function boolean setbeoprefix (readonly string as_beo_prefix);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBEOPrefix
//
//	Returns:			Boolean
//
//	Description:	Sets the prefix for BEO's
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

is_beo_prefix = as_beo_prefix

return true
end function

public function n_cst_bcm getbcmbyindex (long al_bcmindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCMByIndex
//
//	Arguments:		al_bcm_index
//
//	Returns:			n_cst_bcm
//
//	Description:	Returns the BCM which has the index passed in.
//						for INTERNAL OFR USE ONLY.
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
n_cst_bcm lnv_bcm 
long i, ll_bcmcount

if al_bcmindex > 0 then
	ll_bcmcount = UpperBound(inv_bcm[])
	// BCM can often be found at its index position.
	if al_bcmindex <= ll_bcmcount then
		if isValid(inv_bcm[al_bcmindex]) then
			if inv_bcm[al_bcmindex].GetBCMIndex() = al_bcmindex then
				return inv_bcm[al_bcmindex]
			end if
		end if
	end if
	
	// Search the array for the BCM.
	for i = 1 to ll_bcmcount
		if isValid(inv_bcm[i]) then
			if inv_bcm[i].GetBCMIndex() = al_bcmindex then
				return inv_bcm[i]
			end if
		end if
	next
end if

return lnv_bcm
end function

public function string getclassdlkprefix ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetClassDLKPrefix
//
//	Returns:			String	The prefix for the class dlk
//
//	Description:	Returns the prefix for class dlk's (ie n_cst_dlkc_)
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
//	Copyright © 1996-1999 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return is_classdlk_prefix
end function

public subroutine setkeeplistofbcms (boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetKeepListofBCMs
//
//	Arguments:		ab_flag - TRUE/FALSE
//
//	Returns:			none
//
//	Description:	Indicates whether or not the BCM Manager should maintain a 
//						list of BCMs which have been created.  This can be set to FALSE
//						to allow PB garbage collection to clean up unused BCMs.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ib_KeepListofBCMs = ab_flag
end subroutine

protected function string getbcmtypefromblob (ref blob ablb_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCMTypeFromBlob
//
//	Arguments:		blob
//
//	Returns:			String	ClassName of the BCM that we need to create.
//
//	Description:	ClassName of the BCM that we need to create.
//                FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
// 2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
unsignedlong ul_rc = 1
string ls_temp

//		Metadata length
ls_temp = String(BlobMid(ablb_bcm, ul_rc, 40))
ul_rc = ul_rc + len(ls_temp) + 1

// The first item in the blob is either the length or the BCM Class.
if isNumber(ls_temp) then
	//		BCM Class
	ls_temp = String(BlobMid(ablb_bcm, ul_rc, 40))
end if

return ls_temp
end function

public function n_cst_bcm createbcm (any any_bcm, boolean ab_islocal);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateLocalBCM
//
//	Arguments:		any_bcm		Serialized BCM or BCM reference
//						ab_islocal	Indicates if this BCM must be local (ie - has access to DLKs).
//
//	Returns:			n_cst_bcm	Returns created BCM - null if error
//
//	Description:	Creates a BCM based on the specified BCM class.  
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_bcm lnv_bcm
blob lblb_bcm
s_bcmreference lstr_bcmref
string ls_arg_class, ls_bcm_class, ls_beo_class

ls_arg_class = ClassName(any_bcm)
if left(ls_arg_class, Len(is_businesscollectionmanager)) = is_businesscollectionmanager then
	lnv_bcm = any_bcm
elseif ls_arg_class = "string" then
	ls_beo_class = any_bcm
	lnv_bcm = this.CreateBCM(is_businesscollectionmanager, ls_beo_class)
elseif ls_arg_class = "blob" then
	lblb_bcm = any_bcm
	ls_bcm_class = this.GetBCMTypeFromBlob(lblb_bcm)
	if ls_bcm_class = "" then
		this.PushException("createbcm")
		return lnv_bcm		
	end if
	lnv_bcm = this.CreateBCM(ls_bcm_class, "")
	if not IsValid(lnv_bcm) then
		this.PushException("createbcm")
		return lnv_bcm
	end if
	if ab_islocal = TRUE then
		lnv_bcm.SetLocal(TRUE)
	end if
	if lnv_bcm.SetBCM(lblb_bcm) <> 1 then
		this.PushException("createbcm")
		SetNull(lnv_bcm) //avoid gpf downstream
	end if
elseif ls_arg_class = "s_bcmreference" then
	lstr_bcmref = any_bcm
	if IsValid(lstr_bcmref.nv_bcm) then
		lnv_bcm = lstr_bcmref.nv_bcm
	else
		lblb_bcm = lstr_bcmref.blb_bcm
		ls_bcm_class = this.GetBCMTypeFromBlob(lblb_bcm)
		if ls_bcm_class = "" then
			this.PushException("createbcm")
			return lnv_bcm		
		end if
		lnv_bcm = this.CreateBCM(ls_bcm_class, "")
		if not IsValid(lnv_bcm) then
			this.PushException("createbcm")
			return lnv_bcm
		end if
		if ab_islocal = TRUE then
			lnv_bcm.SetLocal(TRUE)
		end if
		if lnv_bcm.SetBCM(lstr_bcmref) <> 1 then
			this.PushException("createbcm")
			SetNull(lnv_bcm) //avoid gpf downstream
		end if
	end if
end if

return lnv_bcm

end function

public function boolean ispbrowidon ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsPBRowIDOn
//
//	Arguments:		none
//
//	Returns:			Boolean
//
//	Description:	Returns true if ofr is to use PB 6.0 RowID functions instead of
//						beoindex.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1		Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
environment lenv

GetEnvironment(lenv)

if lenv.PBMajorRevision < 6 then
	return false
end if

return ib_pb_row_id
end function

on ofr_n_cst_bcmmgr.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_bcmmgr.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Destructor
//
//	Description:	Destroy BCM's, turn log off, destroy exception
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
int li_i, li_count

li_count = UpperBound(inv_bcm)
// destroy all bcm's
for li_i = 1 to li_count
	if IsValid ( inv_bcm [ li_i ] ) then
		this.DestroyBCM ( inv_bcm [ li_i ] )
	end if
next

SetLog(FALSE)

// destroy all databases
li_count = UpperBound(inv_database)
for li_i = 1 to li_count
	if IsValid ( inv_database [ li_i ] ) then
		this.DestroyDatabase ( inv_database [ li_i ] )
	end if
next

if IsValid(inv_exception) then
	destroy(inv_exception)
end if

end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Constructor
//
//	Description:	Create exception service
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
inv_exception = CREATE n_cst_exception
this.SetBCMMGR(this)

end event

