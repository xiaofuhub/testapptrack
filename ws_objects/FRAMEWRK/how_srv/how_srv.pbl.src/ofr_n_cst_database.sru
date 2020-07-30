$PBExportHeader$ofr_n_cst_database.sru
forward
global type ofr_n_cst_database from n_cst_base
end type
end forward

global type ofr_n_cst_database from n_cst_base
event type boolean setserverparm ( )
end type
global ofr_n_cst_database ofr_n_cst_database

type variables

protected:

n_cst_sso	inv_sso
n_cst_query	inv_query
boolean		ib_remote = false
boolean 		ib_usestructureserialization = true

// Registered BCM's for update
n_cst_bcm	inv_regbcm[]

// Configuration Information
string 		is_inifilename
string		is_configuration = "local"
Boolean                  ib_usethinclient = false

// COM Information
string		is_ssoolename

// Distributed PB and Database  Information
connection              icn_client
string 		is_application
string		is_connectstring
string		is_driver
string		is_location
string		is_connectionoptions
string		is_userid
string		is_password
string		is_traceoptions
string                        is_DBMS
string                        is_autocommit




end variables

forward prototypes
public function boolean open ()
public function boolean createquery ()
public function n_cst_query getquery ()
public function integer destroysso (readonly n_cst_sso anv_sso)
public function integer save ()
public function boolean getremote ()
public function boolean isssovalid ()
public function boolean close ()
public function connection getconnection ()
protected function boolean setconfiguration (string as_configuration)
protected function boolean readinifile ()
public function boolean setinifile (string as_name)
public function string getssoolename ()
public function boolean dbconnect ()
public function boolean dbdisconnect ()
public function integer register (readonly n_cst_bcm anv_bcm)
protected function integer getssoerrors ()
public function integer unregister ()
public function boolean getthinclient ()
public subroutine setthinclient (boolean ab_flag)
public subroutine setremote (boolean ab_flag)
public function boolean getusestructureserialization ()
public subroutine setusestructureserialization (boolean ab_flag)
public function long thinclientnewbeo (n_cst_bcm anv_bcm)
public function string getinifile ()
public function boolean deactivate ()
end prototypes

event setserverparm;//////////////////////////////////////////////////////////////////////////////
//
// Event:			SetServerParm
//
//	Arguments:		None
//
//	Description:	This script is to be extended where server specific connection
//						parameter are set
//
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
icn_client.Driver = is_driver
icn_client.Application = is_application
icn_client.Location = is_location
return true
end event

public function boolean open ();//////////////////////////////////////////////////////////////////////////////
//
// Function:		Open
//
//	Arguments:		None
//
//	Returns:			Boolean	True 	Create of SSO succeeded
//									False	Create of SSO failed
//
//	Description:	Creates the SSO for this database class
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
environment le_environment
long 			ll_rc = -1
boolean 		lb_ret


if isValid(inv_sso) then
	return true
end if

GetEnvironment(le_environment)

if ib_remote and le_environment.PBMajorRevision >= 6 then
	if lower(is_configuration) = "distributed pb" then
		if not IsValid(icn_client) then
			// attempt to connect to the distributed server
			icn_client = CREATE connection
			This.Event SetServerParm()
			if icn_client.ConnectToServer() <> 0 THEN
				this.SetException("open", "24998", {icn_client.errtext})
				destroy icn_client
				return false
			else
				ll_rc = icn_client.dynamic CreateInstance(inv_sso, "n_cst_sso") //pb 6.0 only
				if ll_rc <> 0 then
					this.SetException("open", "24999", {String(ll_rc)})
				end if
			end if
		end if
	elseif lower(is_configuration) = "com" then
		inv_sso = create n_cst_sso
		if inv_sso.typeof() <> oleobject! then
			this.SetException("open", "24994")
		else
			ll_rc = inv_sso.dynamic ConnectToNewObject(is_ssoolename)
		end if
		if ll_rc <> 0 then
			this.SetException("open", "24995", {String(ll_rc)})
		end if
	end if			
end if

if not IsValid(inv_sso) then
	inv_sso = create n_cst_sso
end if

if isValid(inv_sso) then
	inv_sso.SetRemote(ib_remote)
	if not ib_remote then
		inv_sso.SetDatabase(this)
	end if
else
	return false
end if


return true

end function

public function boolean createquery ();//////////////////////////////////////////////////////////////////////////////
//
// Function:		CreateQuery
//
//	Arguments:		None
//
//	Returns:			Boolean	True - Create of query succeeded
//									False - Create of query failed
//
//	Description:	Creates the query for this database class
//
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

if not isValid(inv_query) then
	inv_query = create n_cst_query

	if isValid(inv_query) then
		inv_query.SetDatabase(this)
		inv_query.SetSSO(inv_sso)
		return true
	else
		return false
	end if
end if

return true

end function

public function n_cst_query getquery ();//////////////////////////////////////////////////////////////////////////////
//
// Function:		GetQuery
//
//	Arguments:		None
//
//	Returns:			A query instance
//
//	Description:	Return an instance of the query object for the database
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
n_cst_query lnv_query

if this.open() then
	if not isvalid(inv_query) then
		this.CreateQuery()
	end if

	return inv_query
else
	return lnv_query
end if

end function

public function integer destroysso (readonly n_cst_sso anv_sso);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DestroySSO
//
//	Arguments:		anv_sso	SSO to destroy
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Destroys the specified SSO instance
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

DESTROY anv_sso

if not IsValid ( anv_sso ) then
	li_rc = 1
end if

return li_rc

end function

public function integer save ();//////////////////////////////////////////////////////////////////////////////
//
// Function:		Save
//
//	Arguments:		None
//
//	Returns:			1 Succeeded
//						-1 Failed
//
//	Description:	Calls the SSO to update the db through the transaction manager
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
integer li_rc = 1, li_bcm, li_bcms, li_bcmref
blob lblb_bcm1, lblb_bcm2, lblb_bcm3, lblb_bcm4, lblb_bcm5, lblb_bcm6, lblb_bcm7, lblb_bcm8
blob lblb_bcm9, lblb_bcm10, lblb_bcm11, lblb_bcm12, lblb_bcm13, lblb_bcm14, lblb_bcm15, lblb_bcm16
blob lblb_bcm[16] 
s_bcmreference lstr_bcmreference[]
any la_bcm, la_bcm_cast

if not isvalid(inv_sso) then
	this.open()
end if

this.ClearOFRErrors()

if isValid(inv_sso) then
	li_bcms = UpperBound(inv_regbcm)
	if this.GetRemote() and this.GetUseStructureSerialization() = false then
		for li_bcm = 1 to li_bcms
			la_bcm = la_bcm_cast
			if inv_regbcm[li_bcm].GetBCM(false, la_bcm) = 1 then
				lblb_bcm[li_bcm] = la_bcm
			else
				li_rc = -1
				exit
			end if
		next

		//can't pass arrays to mts so pass by reference
		lblb_bcm1 = lblb_bcm[1]
		lblb_bcm2 = lblb_bcm[2]
		lblb_bcm3 = lblb_bcm[3]
		lblb_bcm4 = lblb_bcm[4]
		lblb_bcm5 = lblb_bcm[5]
		lblb_bcm6 = lblb_bcm[6]
		lblb_bcm7 = lblb_bcm[7]
		lblb_bcm8 = lblb_bcm[8]
		lblb_bcm9 = lblb_bcm[9]
		lblb_bcm10 = lblb_bcm[10]
		lblb_bcm11 = lblb_bcm[11]
		lblb_bcm12 = lblb_bcm[12]
		lblb_bcm13 = lblb_bcm[13]
		lblb_bcm14 = lblb_bcm[14]
		lblb_bcm15 = lblb_bcm[15]
		lblb_bcm16 = lblb_bcm[16]
		
		if inv_sso.SaveRemote(ref lblb_bcm1, ref lblb_bcm2, ref lblb_bcm3, ref lblb_bcm4, ref lblb_bcm5, &
			ref lblb_bcm6, ref lblb_bcm7, ref lblb_bcm8, ref lblb_bcm9, ref lblb_bcm10, &
			ref lblb_bcm11, ref lblb_bcm12, ref lblb_bcm13, ref lblb_bcm14, ref lblb_bcm15, &
			ref lblb_bcm16) <> 1 then
			this.GetSSOErrors()
			li_rc = -1
		end if
	else
		for li_bcm = 1 to li_bcms
			if IsValid(inv_regbcm[li_bcm]) then
				li_bcmref++
				lstr_bcmreference[li_bcmref] = inv_regbcm[li_bcm].GetBCM()
			end if
		next
		if inv_sso.Save(lstr_bcmreference) <> 1 then
			this.GetSSOErrors()
			li_rc = -1
		end if
	end if
else
	li_rc = -1
end if

return li_rc
end function

public function boolean getremote ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetRemote
//
//	Arguments:		None
//
//	Returns:			Remote flag indicator
//
//	Description:	Indicates if the application is accessing an application
//						server.
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
return this.ib_remote
end function

public function boolean isssovalid ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsSSOValid
//
//	Arguments:		None
//
//	Returns:			Boolean True - Database object has valid sso
//								  False - Databae object does not have valid sso
//
//	Description:	Return whether sso is valid or not
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
if isValid(inv_sso) then
	return true
end if

return false


end function

public function boolean close ();//	Arguments:		none
//
//	Returns:			Boolean
//						true		success
//						false		error
//
//	Description:	Disconnects from an application server
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


if isValid(icn_client) then
	icn_client.DisconnectServer()
	destroy icn_client
end if

if lower(is_configuration) = 'com' and isValid(inv_sso) then
	inv_sso.dynamic DisconnectObject()
end if

if IsValid(inv_sso) then
	destroy inv_sso
end if


return true
end function

public function connection getconnection ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetConnection
//
//	Arguments:		None
//
//	Returns:			Connection, The Dist PB connection.
//
//	Description:	Only valid when using Distributed PB.  Returns the Connection object.
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

return icn_client
end function

protected function boolean setconfiguration (string as_configuration);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetConfiguration
//
//	Arguments:		as_configuration - Name of configuration.
//
//	Returns:			Boolean
//
//	Description:	Which configuration should this database class operate in.
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

Choose Case Lower(as_configuration)
	Case "local"
		this.ib_remote = false
	Case "distributed pb"
		this.ib_remote = true
		this.ib_usestructureserialization = true
	Case "com"
		this.ib_remote = true
		this.ib_usestructureserialization = false
	Case Else
		return false
End Choose

is_configuration = as_configuration

return true
end function

protected function boolean readinifile ();string ls_classname

if is_inifilename = "" then
	return false
end if

ls_classname = this.ClassName()

if this.SetConfiguration(ProfileString(is_inifilename, ls_classname, "Configuration", "")) = false then 
	return false
end if

is_ssoolename = ProfileString(is_inifilename, ls_classname, "SSOOLEName", "")
if is_ssoolename = "" then
	is_ssoolename = "n_cst_sso"
end if

if ib_remote then
	if Lower(ProfileString(is_inifilename, ls_classname, "ThinClient", "")) = "true" then
		ib_usethinclient = true
	end if
end if

is_application = ProfileString(is_inifilename, ls_classname, "Application", "")
is_connectstring = ProfileString(is_inifilename, ls_classname, "ConnectString", "")
is_driver = ProfileString(is_inifilename, ls_classname, "Driver", "")
is_location = ProfileString(is_inifilename, ls_classname, "Location", "")
is_connectionoptions = ProfileString(is_inifilename, ls_classname, "ConnectionOptions", "")
is_userid = ProfileString(is_inifilename, ls_classname, "UserID", "")
is_password = ProfileString(is_inifilename, ls_classname, "Password", "")
is_traceoptions = ProfileString(is_inifilename, ls_classname, "TraceOptions", "")
is_DBMS = ProfileString(is_inifilename, ls_classname, "DBMS", "")
is_autocommit = ProfileString(is_inifilename, ls_classname, "autocommit", "")

return true
end function

public function boolean setinifile (string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetIniFile
//
//	Arguments:		as_name - Name of ini file with path.
//
//	Returns:			None
//
//	Description:	Set ini file name and read information.
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
if fileexists(as_name) and is_inifilename <> as_name then
	is_inifilename = as_name
	return this.ReadIniFile()
else
	return false
end if
end function

public function string getssoolename ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetSSOOLEName
//
//	Arguments:		None
//
//	Returns:			String
//
//	Description:	OLE Name of SSO to be used with ConnectToNewObject.
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


return is_ssoolename
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
//	Description:	Connects to database
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

string ls_inifile, ls_autocommit
ls_inifile = this.GetIniFile()

if sqlca.DBHandle() <> 0 then return true

// Check arguments
if IsNull (ls_inifile) or Len (Trim (ls_inifile))=0 or (not FileExists (ls_inifile)) then
	return false
end if

SQLCA.DBMS= ProfileString (ls_inifile, "Database", 'DBMS', '')
SQLCA.Database = ProfileString (ls_inifile, "Database", 'Database', '')
SQLCA.LogID = ProfileString (ls_inifile, "Database", 'LogID', '')
SQLCA.LogPass = ProfileString (ls_inifile, "Database", 'LogPassword', '')
SQLCA.ServerName = ProfileString (ls_inifile, "Database", 'ServerName', '')
SQLCA.UserID = ProfileString (ls_inifile, "Database", 'UserID', '')
SQLCA.DBPass =ProfileString (ls_inifile, "Database", 'DatabasePassword', '')
SQLCA.Lock =ProfileString (ls_inifile, "Database", 'Lock', '')
SQLCA.DBParm =ProfileString (ls_inifile, "Database", 'DBParm', '')
ls_autocommit = ProfileString (ls_inifile, "Database", 'AutoCommit', 'false')
if lower(ls_autocommit) = "false" then
	SQLCA.autocommit = false
else
	SQLCA.autocommit = true
end if

connect using SQLCA;
if SQLCA.SQLCode = -1 then
	this.SetException("dbconnect", "24996", {SQLCA.SQLErrText})
	return false
end if

return true


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
//	Description:	Disconnects from a database
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
if isValid(SQLCA) then
	if SQLCA.DBHandle() > 0 then
		Disconnect using SQLCA;
		if SQLCA.SQLCode <> 0 then
			return false
		end if
	end if
end if

return true
end function

public function integer register (readonly n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
// Function:		Register
//
//	Arguments:		BCM
//
//	Returns:			1 Succeeded
//
//	Description:	Register this BCM
//
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
integer li_start, li_end

if not IsValid(anv_bcm) then
	this.SetException("register", "29985")
	return -1
end if

//check to see if already registered
li_end = UpperBound(inv_regbcm) 
for li_start = 1 to li_end
	if anv_bcm = inv_regbcm[li_start] then
		return 1
	end if
next

inv_regbcm[li_end + 1] = anv_bcm

return 1

end function

protected function integer getssoerrors ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetSSOErrors
//
//	Arguments:		none
//
//	Returns:			Integer
//
//	Description:	Propagates errors from SSO to this.
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

ofr_s_error_collection lstr_errors
blob lbl_errors
any la_bcm

if isValid(inv_sso) then
	if this.GetRemote() = false then
		return this.dynamic PropagateErrors(inv_sso) //sso could be an ole object
	elseif this.GetUseStructureSerialization() = false then
		inv_sso.GetSerializedBlobErrors(ref lbl_errors)
		inv_sso.GetOFRErrorCollection().ClearErrors()
		return this.GetOFRErrorCollection().Deserialize(lbl_errors)
	else
		lstr_errors = inv_sso.GetSerializedErrors()
		inv_sso.GetOFRErrorCollection().ClearErrors()
		return this.GetOFRErrorCollection().Deserialize(lstr_errors)
	end if
end if

return 1
end function

public function integer unregister ();//////////////////////////////////////////////////////////////////////////////
//
// Function:		Unregister
//
//	Arguments:		None
//
//	Returns:			Integer	1 Succeeded
//									-1 Failed
//
//	Description:	Unregister BCM's
//
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

n_cst_bcm   lnv_regbcm_reset[]

inv_regbcm = lnv_regbcm_reset

return 1



end function

public function boolean getthinclient ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetThinClient
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Returns whether or not to operate in Thin Client mode.
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
return ib_usethinclient


end function

public subroutine setthinclient (boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetThinClient
//
//	Arguments:		ab_flag
//
//	Returns:			none
//
//	Description:	Indicates whether or not to operate in Thin Client mode.
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
ib_usethinclient = ab_flag
end subroutine

public subroutine setremote (boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetRemote
//
//	Arguments:		ab_flag = Remote flag indicator
//
//	Returns:			none
//
//	Description:	Indicates if the application is accessing an application
//						server.
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
this.ib_remote = ab_flag
end subroutine

public function boolean getusestructureserialization ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetUseStructureSerialization 
//
//	Arguments:		None
//
//	Returns:			Serialization flag indicator
//
//	Description:	TRUE = Serialize using BCM Reference structure. 
//						FALSE = Serialize using Blobs.
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
return ib_usestructureserialization 
end function

public subroutine setusestructureserialization (boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetUseStructureSerialization 
//
//	Arguments:		ab_flag
//
//	Returns:			Serialization flag indicator
//
//	Description:	TRUE = Serialize using BCM Reference structure. 
//						FALSE = Serialize using Blobs.
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
ib_usestructureserialization = ab_flag
end subroutine

public function long thinclientnewbeo (n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
// Function:		ThinClientNewBEO
//
//	Arguments:		anv_bcm - Client side BCM that needs a row inserted.
//
//	Returns:			Long - row in BCM where row was added.
//
//	Description:	Client side BCM that needs a row inserted.
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
s_bcmreference bcmref
n_cst_bcm lnv_bcm
datastore lds_view1, lds_view2
string ls_classes[]
blob lblb_bcm

long ll_rc = -1
if isValid(anv_bcm) then
	if not isValid(inv_sso) then
		this.open()
	end if
	if isValid(inv_sso) then
		anv_bcm.GetBEOClass(ls_classes)
		if this.ib_usestructureserialization = TRUE then
			bcmref = inv_sso.NewBEO(anv_bcm.GetQueryName(), ls_classes)
			lnv_bcm = this.GetBCMMgr().CreateBCM(bcmref)
		else
			ll_rc = inv_sso.NewBEORemote(anv_bcm.GetQueryName(), ls_classes, ref lblb_bcm)
			lnv_bcm = this.GetBCMMgr().CreateBCM(lblb_bcm)		
		end if
		if isValid(lnv_bcm) then
			if lnv_bcm.GetErrorCount() > 0 then
				anv_bcm.PropagateErrors(lnv_bcm)
				ll_rc = -1
			else
				lds_view1 = lnv_bcm.GetView()
				lds_view2 = anv_bcm.GetView()
				if lds_view1.RowsCopy(1, 1, Primary!, lds_view2, lds_view2.RowCount() + 1, Primary!) > 0 then
					ll_rc = lds_view2.RowCount()
				else
					ll_rc = -1
				end if
			end if
		end if
	end if
end if
	if isValid(lnv_bcm) then
		this.GetBCMMgr().DestroyBCM(lnv_bcm)
	end if

return ll_rc
end function

public function string getinifile ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetIniFile
//
//	Arguments:		none
//
//	Returns:			name of ini file.
//
//	Description:	Get ini file name .
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

return is_inifilename
end function

public function boolean deactivate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Deactivate
//
//	Arguments:		none
//
//	Returns:			Boolean
//						true		success
//						false		error
//
//	Description:	Deactivate may be extended to disconnect from the application 
//						server after a bcm retrieve
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

return true
end function

on ofr_n_cst_database.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_database.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Destructor
//
//	Description:	Destroy SSO and Query objects
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
if not this.DBDisconnect() then
	this.SetException("destructor", "24997" )
end if

this.close()

if isValid(inv_query) then
	Destroy inv_query
end if


end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Constructor
//
//	Description:	
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

application lapp
string      ls_ini

lapp = GetApplication() 
ls_ini = lapp.AppName + ".ini"

this.SetINIFile(ls_ini)

end event

