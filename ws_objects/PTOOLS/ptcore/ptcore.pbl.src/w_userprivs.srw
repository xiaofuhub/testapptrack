$PBExportHeader$w_userprivs.srw
forward
global type w_userprivs from w_response
end type
type uo_privs from u_cst_privs within w_userprivs
end type
type cb_save from commandbutton within w_userprivs
end type
type cb_close from commandbutton within w_userprivs
end type
type uo_1 from u_cst_syssettings_enumerated_cbx within w_userprivs
end type
end forward

global type w_userprivs from w_response
integer width = 3397
integer height = 1772
string title = "Privilege Settings"
long backcolor = 12632256
event ue_userchanged ( long al_userid )
event ue_privchanged ( long al_row,  dwobject adwo_dwo,  string as_data )
event ue_doubleclicked ( integer ai_xpos,  integer ai_ypos,  dwobject adwo_dwo,  long al_row )
event ue_detailchanged ( boolean ab_checked,  long al_functionid )
event ue_dwprivsdoubleclicked ( dwobject adwo_dwo,  long al_row )
event type integer ue_privschanged ( string as_module,  string as_division,  long al_userid,  string as_data )
event ue_getlatestchanges ( )
event ue_savesettings ( )
event ue_enable ( boolean ab_enable )
uo_privs uo_privs
cb_save cb_save
cb_close cb_close
uo_1 uo_1
end type
global w_userprivs w_userprivs

type variables
private n_cst_privsManager 	inv_privManager
private n_ds						ids_divisions
private n_ds						appeon_ids_defaultDivsCache
private n_cst_ship_type			inv_shipType

Constant Integer	ii_DefaultClass = 0
Constant Integer	ii_SubClass = -1
Constant Integer	ii_SuperClass = 1
Constant Integer	ii_SuperSubClass = 2

constant string	cs_Admin = "admin.bmp"
constant string	cs_Audit = "audit.bmp"
constant string	cs_lookup = "lookup.bmp"
constant string	cs_Entry	= "entry.bmp"

constant string	cs_AdminPlus = "admin+.bmp"
constant string	cs_AuditPlus = "audit+.bmp"
constant string	cs_lookupPlus = "lookup+.bmp"
constant string	cs_EntryPlus	= "entry+.bmp"

constant string	cs_AdminMinus = "admin-.bmp"
constant string	cs_AuditMinus = "audit-.bmp"
constant string	cs_lookupMinus = "lookup-.bmp"
constant string	cs_EntryMinus	= "entry-.bmp"

constant string	cs_AdminPM = "admin+-.bmp"
constant string	cs_AuditPM = "audit+-.bmp"
constant string	cs_lookupPM = "lookup+-.bmp"
constant string	cs_EntryPM	= "entry+-.bmp"


constant string	cs_ALL = "all.bmp"
constant string	cs_ALLDIVISIONS = "alldivisions.bmp"
constant string	cs_ALLMODULES	= "allmodules.bmp"



end variables

forward prototypes
private function integer of_loaddetails (dwobject adwo_dwo, long al_row)
public function n_cst_privdetails of_getdetail (string as_module, long al_division, long al_userid)
private function long of_getdivisionid (long al_index)
private function long of_getdivisionid (string as_division)
private function datastore of_getdivisions ()
private function long of_geticonid (string as_icon)
private function integer of_geticons (ref string asa_icons[])
private function string of_geticonstring (integer ai_icon, integer ai_class)
private function n_cst_privsmanager of_getprivmanager ()
private function integer of_loaduserprivs (long al_userid)
private function integer of_updatevisuals (n_cst_privdetails anva_privchanges[])
public function n_cst_privsManager of_getprivsmanager ()
public function integer of_copydivisionstouser (long al_fromuser, long ala_tousers[], ref string as_message)
public function integer of_getdefaultdivisioncache (ref n_ds ads_cache)
public function integer of_copytouser (long al_fromuserid, string as_division, string as_module, long al_touser, string as_todivs[])
public function integer of_copyprivstouser (long al_fromuserid, string as_division, string as_module, long ala_touser[], ref string as_message, string asa_todivs[])
end prototypes

event ue_userchanged(long al_userid);this.of_loadUserPrivs( al_userId )
end event

event ue_dwprivsdoubleclicked(dwobject adwo_dwo, long al_row);IF al_row > 0 THEN
	this.of_LoadDetails( adwo_dwo, al_row )
END IF
end event

event ue_getlatestchanges();//This event gets the last changes that were made on the manager object
//in the form of an array of nonvisuals. It then updates itself through a call
//to of_makeChanges() on itself.
n_cst_privDetails lnv_privChanges[]

if isValid( inv_privmanager ) THEN
	inv_privmanager.of_getLattestchanges( lnv_privChanges )
	
	IF this.of_updateVisuals( lnv_privChanges ) = 1 THEN
		inv_PrivManager.of_ClearLattestChanges()
	END IF
	
END IF
end event

event ue_savesettings();n_cst_Syssettings lnv_Settings
lnv_Settings = CREATE n_cst_Syssettings

IF IsValid(lnv_Settings) THEN
   lnv_Settings.of_SaveSetting( )
END IF

DESTROY(lnv_Settings)
end event

event ue_enable(boolean ab_enable);uo_privs.event ue_Enable(ab_Enable)

end event

private function integer of_loaddetails (dwobject adwo_dwo, long al_row);//Calls nonvisual object of_getDetails
Int		li_return
String	ls_module
String	ls_DivisionCol
Long		ll_Division
Long		ll_UserId
Long		ll_Col
n_cst_privDetails lnv_currentDetails

li_return = 1 
//get and set the nonvisual object for the the currently selected item.

//Check for valid row/column
IF isValid(adwo_dwo) THEN
	IF adwo_dwo.Type = "column" THEN
		ll_Col = Long(adwo_dwo.Id)
		IF ll_Col = 1 THEN
			li_Return = -1 //First col is module list, no action
		END IF
	ELSE
		li_Return = -1
	END IF
ELSE
	li_Return = -1
END IF

IF li_Return <> -1 THEN
	
	IF isValid( inv_privmanager ) THEN
		ll_userId = uo_privs.of_getuserid( )
		ls_module = uo_privs.of_getModule( al_Row )
		
		ls_DivisionCol = uo_privs.of_getDivission( ll_Col )
		IF al_Row > 0 THEN
			ls_module = uo_privs.dw_PrivSummary.GetItemString(al_row, 1)
			
			ll_Division = this.of_getdivisionid( ls_DivisionCol )
			lnv_currentDetails = inv_privmanager.of_getDetails( ll_userId, ls_module, ll_division )
		END IF
		IF Not Isvalid( lnv_currentDetails ) THEN
			li_return = -1
		END IF
	ELSE
		li_return = -1
	END IF
	
	//forward the currently selected item to the user object so that it can
	//load the details.
	IF li_return  = 1 THEN
		li_return = uo_privs.of_setprivdetail( lnv_currentDetails ) //of_loadDetails( lnv_currentDetails )	
	END IF
	
END IF

RETURN li_return
end function

public function n_cst_privdetails of_getdetail (string as_module, long al_division, long al_userid);//gets the specified detail from the priv manager
n_cst_privDetails lnv_detail

IF isValid( inv_privmanager ) THEN
	lnv_detail = inv_privmanager.of_getDetails( al_userId, as_module, al_division )
END IF

RETURN lnv_detail
end function

private function long of_getdivisionid (long al_index);//Returns -1 if there is no cache to look in
Long	ll_row
Long	ll_id

Long	ll_index
Long	ll_max


IF isValid( ids_divisions ) THEN
	
	//can't use a find string because the value coming is going to be all lower case.
	//this is because  a describe statement returns the string this way off the dwo.
	//So instead I have to convert the database value to all lowercase for the comparision.
	//ll_row = ids_divisions.Find("st_name = '"+as_division+"'", 0, ids_divisions.RowCount())
	ll_max = ids_divisions.RowCount()

	//clicked column 2 is actually row 1 in the cache becuase of the module column offset
	IF (al_index - 1) > 0 AND (al_index - 1) <= ll_max THEN
		
		ll_id = ids_divisions.getItemNumber( al_index - 1, "st_id" )
	END IF
ELSE
	ll_id = -1
END IF

RETURN ll_id
end function

private function long of_getdivisionid (string as_division);//Returns -1 if there is no cache to look in
Long	ll_row
Long	ll_id

Long	ll_index
Long	ll_max

String	ls_value

IF isValid( ids_divisions ) THEN
	
	//can't use a find string because the value coming is going to be all lower case.
	//this is because  a describe statement returns the string this way off the dwo.
	//So instead I have to convert the database value to all lowercase for the comparision.
	//ll_row = ids_divisions.Find("st_name = '"+as_division+"'", 0, ids_divisions.RowCount())
	ll_max = ids_divisions.RowCount()
	FOR ll_index = 1 TO ll_max
		ls_value = lower(ids_divisions.getItemString( ll_index, "st_name" ))
		
		IF ls_value = lower( as_division ) THEN
			ll_row = ll_index
			exit
		END IF
	NEXT
	IF ll_row > 0 THEN
		ll_id = ids_divisions.getItemNumber( ll_row, "st_id" )
	END IF
ELSE
	ll_id = -1
END IF

RETURN ll_id
end function

private function datastore of_getdivisions ();return ids_divisions
end function

private function long of_geticonid (string as_icon);Long	ll_icon

IF as_icon = cs_admin THEN
	//begin midification by appeon 
//invoke constant form n_cst_appeon_constant
//ll_icon = n_cst_privsManager.cl_admin
ll_icon = appeon_constant.cl_admin
//end midification by appeon 
	
ELSEIF as_icon = cs_audit THEN
	//begin midification by appeon 
//invoke constant form n_cst_appeon_constant
//ll_icon = n_cst_privsManager.cl_audit
ll_icon = appeon_constant.cl_audit
//end midification by appeon 
	
ELSEIF as_icon = cs_entry THEN
	//begin midification by appeon 
//invoke constant form n_cst_appeon_constant
//ll_icon = n_cst_privsManager.cl_entry
ll_icon = appeon_constant.cl_entry
//end midification by appeon 
	
ELSEIF as_icon = cs_lookup THEN
	//begin midification by appeon 
//invoke constant form n_cst_appeon_constant
//ll_icon = n_cst_privsManager.cl_lookup
ll_icon = appeon_constant.cl_lookup
//end midification by appeon 
	
END IF

RETURN ll_icon
end function

private function integer of_geticons (ref string asa_icons[]);Int	 li_return = 1
String	lsa_icons[]
IF isValid( inv_privmanager ) THEN
	lsa_icons[1] = cs_admin
	lsa_icons[2] = cs_audit
	lsa_icons[3] = cs_entry
	lsa_icons[4] = cs_lookup
	asa_icons = lsa_icons
	//inv_PrivManager.of_getStringIcons( asa_icons )
else
	li_return = -1
END IF

RETURN li_return
end function

private function string of_geticonstring (integer ai_icon, integer ai_class);//begin midification by appeon 20070731
//invoke constant form n_cst_appeon_constant
//String	ls_icon
//
//IF ai_class = n_cst_constants.ci_defaultClass THEN
//	IF ai_icon = n_cst_privsManager.cl_admin THEN
//		ls_icon = cs_admin
//	ELSEIF  ai_icon = n_cst_privsManager.cl_audit THEN
//		ls_icon = cs_audit
//	ELSEIF  ai_icon = n_cst_privsManager.cl_entry THEN
//		ls_icon = cs_entry	
//	ELSEIF  ai_icon = n_cst_privsManager.cl_lookup THEN
//		ls_icon = cs_lookup
//	ELSE
//		ls_icon = "Unknown"
//	END IF
//ELSEIF ai_class = n_cst_constants.ci_superClass THEN
//	IF ai_icon = n_cst_privsManager.cl_admin THEN
//		ls_icon = cs_adminplus
//	ELSEIF  ai_icon = n_cst_privsManager.cl_audit THEN
//		ls_icon = cs_auditplus
//	ELSEIF  ai_icon = n_cst_privsManager.cl_entry THEN
//		ls_icon = cs_entryplus	
//	ELSEIF  ai_icon = n_cst_privsManager.cl_lookup THEN
//		ls_icon = cs_lookupplus
//	ELSE
//		ls_icon = "Unknown"
//	END IF
//ELSEIF ai_class = n_cst_constants.ci_subClass THEN
//	IF ai_icon = n_cst_privsManager.cl_admin THEN
//		ls_icon = cs_adminminus
//	ELSEIF  ai_icon = n_cst_privsManager.cl_audit THEN
//		ls_icon = cs_auditminus
//	ELSEIF  ai_icon = n_cst_privsManager.cl_entry THEN
//		ls_icon = cs_entryminus	
//	ELSEIF  ai_icon = n_cst_privsManager.cl_lookup THEN
//		ls_icon = cs_lookupminus
//	ELSE
//		ls_icon = "Unknown"
//	END IF
//ELSEIF ai_class = n_cst_constants.ci_supersubClass THEN
//	IF ai_icon = n_cst_privsManager.cl_admin THEN
//		ls_icon = cs_adminpm
//	ELSEIF  ai_icon = n_cst_privsManager.cl_audit THEN
//		ls_icon = cs_auditpm
//	ELSEIF  ai_icon = n_cst_privsManager.cl_entry THEN
//		ls_icon = cs_entrypm	
//	ELSEIF  ai_icon = n_cst_privsManager.cl_lookup THEN
//		ls_icon = cs_lookuppm
//	ELSE
//		ls_icon = "Unknown"
//	END IF
//END IF
//
//RETURN ls_icon
String	ls_icon

IF ai_class = n_cst_constants.ci_defaultClass THEN
	IF ai_icon = appeon_constant.cl_admin THEN
		ls_icon = cs_admin
	ELSEIF  ai_icon = appeon_constant.cl_audit THEN
		ls_icon = cs_audit
	ELSEIF  ai_icon = appeon_constant.cl_entry THEN
		ls_icon = cs_entry	
	ELSEIF  ai_icon = appeon_constant.cl_lookup THEN
		ls_icon = cs_lookup
	ELSE
		ls_icon = "Unknown"
	END IF
ELSEIF ai_class = n_cst_constants.ci_superClass THEN
	IF ai_icon = appeon_constant.cl_admin THEN
		ls_icon = cs_adminplus
	ELSEIF  ai_icon = appeon_constant.cl_audit THEN
		ls_icon = cs_auditplus
	ELSEIF  ai_icon = appeon_constant.cl_entry THEN
		ls_icon = cs_entryplus	
	ELSEIF  ai_icon = appeon_constant.cl_lookup THEN
		ls_icon = cs_lookupplus
	ELSE
		ls_icon = "Unknown"
	END IF
ELSEIF ai_class = n_cst_constants.ci_subClass THEN
	IF ai_icon = appeon_constant.cl_admin THEN
		ls_icon = cs_adminminus
	ELSEIF  ai_icon = appeon_constant.cl_audit THEN
		ls_icon = cs_auditminus
	ELSEIF  ai_icon = appeon_constant.cl_entry THEN
		ls_icon = cs_entryminus	
	ELSEIF  ai_icon = appeon_constant.cl_lookup THEN
		ls_icon = cs_lookupminus
	ELSE
		ls_icon = "Unknown"
	END IF
ELSEIF ai_class = n_cst_constants.ci_supersubClass THEN
	IF ai_icon = appeon_constant.cl_admin THEN
		ls_icon = cs_adminpm
	ELSEIF  ai_icon = appeon_constant.cl_audit THEN
		ls_icon = cs_auditpm
	ELSEIF  ai_icon = appeon_constant.cl_entry THEN
		ls_icon = cs_entrypm	
	ELSEIF  ai_icon = appeon_constant.cl_lookup THEN
		ls_icon = cs_lookuppm
	ELSE
		ls_icon = "Unknown"
	END IF
END IF

RETURN ls_icon
//end midification by appeon 
end function

private function n_cst_privsmanager of_getprivmanager ();return this.inv_privManager
end function

private function integer of_loaduserprivs (long al_userid);Int li_return

uo_Privs.Event ue_loaddetails()

RETURN li_return

end function

private function integer of_updatevisuals (n_cst_privdetails anva_privchanges[]);//forwards the changes to the userobject
Int	li_return

IF uo_privs.of_updateVisuals( anva_privchanges[] ) = 1 THEN
	li_Return = 1
END IF

Return li_Return
end function

public function n_cst_privsManager of_getprivsmanager ();return inv_privmanager
end function

public function integer of_copydivisionstouser (long al_fromuser, long ala_tousers[], ref string as_message);Int	li_return
Int	li_continue
Long	ll_fromIndex
Long	ll_toIndex
Long	ll_fromMax
Long	ll_toMax
Long	ll_numToUsers
Long ll_index
Long	ll_max
Long	ll_numPossibleDefined
Boolean lb_hasBrokerageLicense

String	ls_find
String	ls_fromuser
String	ls_toUser
String	lsa_shiptypes[]
n_ds  lds_copyFromCache
n_ds	lds_copyToCache

n_cst_licenseManager lnv_licenseManager
n_cst_setting_defaultnewshipbutton lnv_setting

int	li_res

String	ls_message

lnv_setting = CREATE n_cst_setting_defaultnewshipbutton

//needed to know whether or not to prepopulate the display with shiptypes 
//that would apply only to those who have brokerage liscenses.
lb_hasBrokerageLicense = lnv_licensemanager.of_getlicensed( n_cst_Constants.cs_Module_Brokerage )

lnv_setting.of_getarray( lsa_shipTypes )

IF al_fromUser > 0 AND upperBound( ala_toUsers )  > 0 THEN
	
	//find out the total number of possible default divisions for an employee
	ll_max = upperBOund( lsa_shipTypes )
	FOR ll_index = 1 TO ll_max
		//do not list template or brokerage shiptypes if they don't have license for it
		IF NOT lb_hasBrokerageLicense AND (Pos( UPPER(lsa_shipTypes[ll_index]), "BROKERAGE" ) > 0 OR UPPER(lsa_shipTypes[ll_index]) = "3RDPARTYTRIP" ) OR UPPER(lsa_shipTypes[ll_index]) = "TEMPLATE" THEN
			//not available
		ELSE
			IF UPPER(lsa_shipTypes[ll_index]) <> "3RDPARTYTRIP" THEN
				ll_numPossibleDefined++
			END IF
		END IF
	NEXT
	
	ls_fromUser = uo_privs.of_getcopyfromusername( )
	ls_toUser = uo_privs.of_getCopyTouserName( )
	
	//initialize the from and to cache
			//--copying the to cache into the from cache and filtering the from cache to the from user
			//--
	ll_toMax = inv_shipType.of_getdefaultdivisionscache( lds_copyToCache )

	lds_copyFromCache = create n_ds
	lds_copyFromCache.dataObject = "d_employeedivisiondefaults"
	lds_copyFromCache.settransobject( SQLCA )
	li_res = lds_copyToCache.rowsCOpy( 1, ll_toMax, PRIMARY!, lds_copyFromCache, 1, PRIMARY!)
	li_res = lds_copyFromCache.setFilter( "em_id = " +string( al_fromUser ) )
	li_res = lds_copyFromCache.filter()

	ll_fromMax = lds_copyFromCache.rowCount()
	
	IF ll_FromMax > 0 AND ll_toMax <> -1 THEN
		
		IF ll_FromMax < ll_numPossibleDefined THEN
			li_continue = MEssageBox( "Copy", "The user '"+ls_fromUser+"' doesn't have all their default divisions defined. Do you want to continue copying default divisions? This could clear default divisions for the user(s) being copied to." , question!, yesno!)
		ELSE
			li_continue = 1
			
		END IF
		
		//copy the from users privs to every user
		// i delete the old ones however many there are, so that it can be cleared, and then
		// i insert new rows for the new ones.
		IF li_continue = 1 THEN
			ll_numToUsers = upperBOund( ala_tousers )
			FOR ll_fromindex = 1 TO ll_numToUsers
				IF ala_toUsers[ll_fromIndex] <> al_fromUser THEN
					lds_copyToCache.setFilter( "em_id = "+string( ala_toUsers[ll_fromIndex] ) )
					lds_copyToCache.filter()
					
					//delete there old divisions
					ll_toMax = lds_copyToCache.rowCount()
					lds_copyToCache.rowsMove( 1, ll_toMax, PRIMARY!, lds_copyToCache, 1, DELETE!)
					
					//copy the rows and change the id to the user we are copying to
					IF lds_copyFromCache.rowsCopy( 1, ll_fromMax , PRIMARY!, lds_copyToCache, 1, PRIMARY!) = 1 THEN
						FOR ll_index = 1 TO ll_fromMax
							lds_copyToCache.setItem( ll_index, "em_id", ala_tousers[ll_fromIndex] )	
						NEXT
					END IF
				END IF
			NEXT
			lds_copyToCache.setFilter("")
			lds_copytocache.filter()
			ls_message = "The user '"+ ls_fromUser +"' default divisions copied successfully to '"+ls_toUser+"'."
		END IF
	ELSE
		ls_message = "The user '"+ ls_fromUser +"' doesn't have defined default divisions."
	END IF

	destroy lds_copyFromCache
//	destroy lds_copyToCache
ELSE
	IF upperBOund( ala_tousers )  = 0 THEN
		ls_message = "No users selected."
	END IF
END IF

as_message = ls_message

DESTROY lnv_setting

IF li_continue <> 1 THEN
	li_return = 0		//process cancelled
ELSE
	li_Return = 1
END IF

RETURN li_Return
end function

public function integer of_getdefaultdivisioncache (ref n_ds ads_cache);//returns the cache of default divisions for  all the app users.
Long	ll_toMax
Long	lla_ids[]
IF not isValid( appeon_ids_defaultDivsCache ) THEN
	appeon_ids_defaultDivsCache = create n_ds
	appeon_ids_defaultDivsCache.dataObject = "d_employeedivisiondefaults"
	appeon_ids_defaultDivsCache.settransobject( SQLCA )
	
	uo_privs.of_getalluser( lla_ids ) 
	ll_toMax = appeon_ids_defaultDivsCache.retrieve( lla_ids )
	commit;
ELSE
	ll_tomax = appeon_ids_defaultDivsCache.rowCount()
END IF

appeon_ids_defaultDivsCache.setFilter( "" )
appeon_ids_defaultDivsCache.filter()
ads_cache = appeon_ids_defaultDivsCache

RETURN ll_toMax

end function

public function integer of_copytouser (long al_fromuserid, string as_division, string as_module, long al_touser, string as_todivs[]);String		ls_message
String		ls_divMessage
n_cst_msg	lnv_msg
S_parm		lstr_parm

Long		lla_ids[]
Int		ll_copyDivsRes
Int		li_return = 1

IF uo_privs.cbx_copyprivs.checked OR uo_privs.cbx_copydivs.checked THEN
	
	IF al_FromUserid <= 0 THEN
		li_Return = -1
		ls_Message = "Select a user to copy from."
	END IF
	
	IF al_ToUser <= 0 THEN
		li_Return = -1 
		ls_Message = "Select user(s) to copy to."
	END IF
	
	IF uo_privs.cbx_copyprivs.checked THEN
		IF isNull(as_Division) OR Len(as_Division) <= 0 THEN
			li_Return = -1 
			ls_Message = "Select a division to copy."
		END IF

		IF isNull(as_Module) OR Len(as_Module) <= 0 THEN
			li_Return = -1 
			ls_Message = "Select a module to copy."
		END IF
	END IF
ELSE
	ls_message = "Select a mode to copy."
	li_Return = -1
END IF


IF li_return = 1 THEN

	//if multiple users then we open a window to get multiple ids
	IF al_touser = uo_privs.ici_multipleuserid THEN
		OPEN( w_response_getAppUsers, this )
		
		IF IsValid ( Message.PowerobjectParm ) THEN
			If UPPER( Message.PowerObjectParm.ClassName ( ) ) = "N_CST_MSG" Then 
				lnv_Msg = Message.PowerobjectParm
				
				IF isValid ( lnv_Msg ) THEN
					IF lnv_Msg.of_get_parm( "USERIDS", lstr_Parm) > 0 THEN
						lla_ids = lstr_Parm.ia_Value
					END IF
				END IF
			End IF
		END IF
	ELSE
		lla_ids[1] = al_toUser
	END IF	

	//copy divisions
	IF uo_privs.cbx_copydivs.checked THEN
		IF li_return = 1 THEN
			ll_copyDivsRes = this.of_copydivisionstouser( al_fromUserId, lla_ids, ls_divMessage )
		END IF
	ELSE
		ll_copyDivsRes = 1 //proceed with copy of privs
	END IF


	//copy privileges
	IF uo_privs.cbx_copyprivs.checked THEN
		IF li_Return = 1 THEN
			//if they canceled during defualt divs copying, cancel the whole process
			IF ll_copyDivsRes = 1 THEN
				this.of_copyprivstouser( al_fromuserid , as_division, as_module, lla_ids, ls_message, as_todivs )
			END IF
		END IF
	END IF
	
	

END IF

IF ls_message <> "" OR ls_divMessage <> "" THEN
	IF ls_message <> ls_divMessage THEN
		MESSAGEBOX( "Copy", ls_message + "~r~n"+ ls_divMessage )
	ELSE
		MESSAGEBOX( "Copy", ls_message )
	END IF
END IF
RETURN li_RETURN

end function

public function integer of_copyprivstouser (long al_fromuserid, string as_division, string as_module, long ala_touser[], ref string as_message, string asa_todivs[]);Int 			li_return = 1
Int 			li_Copy
String		ls_fromuserName
String		ls_touserName
String		ls_message
Long			ll_divisionId
Long			lla_ids[]
Long			ll_index
Long			ll_max
Long			ll_toDiv

Long			ll_divIndex
Long			ll_divMax

String		ls_ErrorMsg

n_cst_msg	lnv_msg
S_parm		lstr_Parm


lla_ids = ala_toUser[]

IF li_Return = 1 THEN
	
	IF isValid( inv_privmanager ) THEN
		
		ll_divMax = upperBOund( asa_toDivs )
		ll_divisionId = this.of_getDivisionid(as_division)
		FOR ll_divIndex = 1 TO ll_divMax
			ll_toDiv = this.of_getDivisionId( asa_toDivs[ll_divIndex] )
			
				
			ll_max = upperBOund( lla_ids )
			FOR ll_index = 1 TO ll_max		
				IF NOT (ll_divisionId = ll_toDiv AND al_fromuserid = lla_ids[ll_index] )THEN
					li_Copy = inv_privmanager.of_copyuserprivs( al_fromUserId, ll_divisionId, as_module, lla_ids[ll_index], ll_toDiv )			
				END IF
			NEXT
		NEXT
		
		//need another error here
		IF ll_divMax = 0 THEN
			ls_message = "No division selected for copying to."
		ELSEIF upperBOund( lla_ids ) = 0 THEN
			ls_message = "No users selected."
		ELSE
			ls_fromuserName = uo_privs.of_getCopyfromusername( )
			ls_touserName = uo_privs.of_getCopyToUserName()
			
			IF len( ls_message ) = 0 THEN
				IF li_Copy = 1 THEN
					ls_Message = "Privileges Copied from '" + ls_fromuserName + "' to '"+ ls_toUserName + "' for division "+ as_division +" and "+ as_module+" module."		
					ls_message = "Copied~r~nFrom: "+ ls_fromUserName+"~r~nDivision: "+ as_division+"~r~nModule: "+as_module+"~r~nTo: "+ls_toUsername+"~r~nDivision(s):"
					FOR ll_index = 1 to ll_divMax
						ls_message += asa_todIvs[ll_index]+ "   "
					NEXT
				ELSE
					ls_Message = "Failed to copy privileges from '" + ls_fromuserName + "' to '"+ ls_toUserName + "' for division "+ as_division +" and "+ as_module+" module."
					li_Return = -1
				END IF
			END IF
		END IF
	ELSE 
		li_return = -1
	END IF
	
END IF

as_message = ls_message
//Messagebox( "Copy Privileges",  ls_Message  )


RETURN li_return
end function

on w_userprivs.create
int iCurrent
call super::create
this.uo_privs=create uo_privs
this.cb_save=create cb_save
this.cb_close=create cb_close
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_privs
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.uo_1
end on

on w_userprivs.destroy
call super::destroy
destroy(this.uo_privs)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.uo_1)
end on

event open;call super::open;String	lsa_modules[]
String	lsa_divisions[]
Long		ll_FoundAll
Long		ll_empId
datastore	lds_divisions
int		li_return
w_frame	lw_frame
n_cst_setting_advancedprivs	lnv_setting

n_cst_privileges		lnv_Privileges

IF lnv_Privileges.of_HasSysAdminRights() THEN

	lnv_setting = create n_cst_setting_advancedprivs
	
	ll_empId = Message.doubleParm
	
	inv_privmanager = create n_cst_privsManager
	
	inv_privManager.of_setInterface( this )
	
	inv_privmanager.of_getmodules( lsa_modules )
	 
	li_return = inv_privmanager.of_getDivisions( lds_divisions )
	
	IF li_return > 0 THEN
		lds_divisions.insertRow( 1 )	//put a divsion id and text to represent all divisions...it is not stored in the database
		lds_divisions.setItem( 1, "st_id", inv_privmanager.cl_alldivisions )
		lds_divisions.setItem( 1, "st_name","ALL DIVISIONS" )
		//begin midification by appeon 20070731
		//invoke constant form n_cst_appeon_constant
		//ll_FoundAll = lds_divisions.Find("st_id = " + String(n_cst_PrivsManager.cl_AllDivisions) , 0, lds_divisions.RowCount())
		ll_FoundAll = lds_divisions.Find("st_id = " + String(appeon_constant.cl_AllDivisions) , 0, lds_divisions.RowCount())
		
		//end midification by appeon 
		IF ll_FoundAll > 0 THEN	
			li_return = lds_divisions.RowsMove ( ll_foundAll, ll_foundAll, PRIMARY!, lds_divisions, 1, PRIMARY! )		
		END IF
		
	
		ids_divisions = lds_divisions
		
		uo_privs.of_getdivisionlistfromds( ids_divisions, lsa_divisions )
	
		uo_privs.of_initialize( lsa_modules, lsa_divisions )
	
		uo_privs.post of_initializelistbox( )
	
		uo_privs.of_setuser( ll_empId )
	END IF
	
	IF lnv_setting.of_getValue() = "No" THEN
		This.Event ue_Enable(FALSE)
	END IF
	
	of_setResize(TRUE)
	inv_resize.of_Register( uo_privs , inv_resize.scalerightbottom )
	inv_resize.of_Register( cb_close , inv_resize.fixedrightbottom )
	inv_resize.of_Register( cb_save ,  inv_resize.fixedrightbottom )
	
	
	lw_frame = gnv_app.of_getframe( )
	
	this.height = lw_frame.height - 400
	this.width = lw_frame.width - 400

	DESTROY lnv_setting
ELSE
	MessageBox ("System Settings" , "Only PTADMIN can edit User Privileges.", Exclamation!)
	CLOSE(this)
END IF
end event

event close;call super::close;IF isvalid( inv_privmanager ) THEN
	DESTROY inv_privmanager 
END IF

IF isValid( ids_divisions ) THEN
	DESTROY ids_divisions
END IF
of_setresize( FALSE)
end event

event closequery;Int	li_result
Boolean lb_ask



IF isValid( inv_privmanager ) THEN
	lb_ask  = inv_privmanager.of_updatesPending( )
	
	IF not lb_ask THEN
		IF isValid( inv_shiptype ) THEN
			lb_ask = inv_shiptype.of_divsmodifiedcount( ) > 0 
		END IF
	END IF
	
	IF lb_ask THEN
		
		li_result = MessageBox( "Close", "Do you want to save your changes?",QUESTION!, YesNoCancel!) 
		
		IF li_result = 1 THEN
			inv_privmanager.of_save()
			inv_shiptype.of_savedivisiondefaults( )
			li_result = 0					//close the window after save
		ELSEIF li_result = 2 THEN
			li_result = 0					//close the window
		ELSE
			li_result = 1   //keep the window from closing
		END IF
			
	ELSE
		li_result = 0
	END IF
END IF

RETURN li_result
end event

type cb_help from w_response`cb_help within w_userprivs
boolean visible = false
integer x = 3227
integer y = 1564
string text = ""
end type

type uo_privs from u_cst_privs within w_userprivs
event ue_test ( integer as_a )
integer x = 37
integer y = 132
integer taborder = 10
boolean bringtotop = true
end type

event ue_test(integer as_a);messagebox("",as_a)
messagebox("",as_a)
messagebox("",as_a)
end event

on uo_privs.destroy
call u_cst_privs::destroy
end on

event ue_detailchanged;call super::ue_detailchanged;parent.event ue_detailchanged( ab_checked, al_functionId)
end event

event ue_privchanged;call super::ue_privchanged;parent.event ue_privchanged(al_row, adwo_dwo, as_data)
end event

event ue_userchanged;call super::ue_userchanged;IF this.of_inititcomplete( ) THEN
	parent.event ue_userchanged( al_userId )
END IF
end event

event ue_dwprivsdoubleclicked;call super::ue_dwprivsdoubleclicked;parent.event ue_dwprivsdoubleclicked( adwo_object, al_row)
end event

event ue_loaddetails;call super::ue_loaddetails;//IF the current user is selected, than it sets up the visual components with
//that users privileges for every module/division combination.

Long		ll_module
Long		ll_max
Long		ll_row
Long		ll_colCount
Long		ll_division

long		ll_userId
long		li_icon
long		ll_divisionColumn
String	ls_module
String	ls_icon
String	ls_Division

Integer	li_Override


n_cst_privDetails	lnv_currentDetail


ll_userId = this.of_getUserId( )

dw_privsummary.setRedraw( FALSE )
IF ll_userId > 0 THEN
	ll_colCount = Long( dw_privsummary.Object.DataWindow.Column.Count)
	ll_max = dw_privsummary.RowCount( )
	
	
	//for all modules, and all division combos
	
	FOR ll_module = 1 TO ll_max
		//we start at column to because the first column is the module column
		ls_module = dw_privSummary.getItemString( ll_module, 1 )
		
		FOR ll_divisionColumn = 2 TO ll_colCount
			ls_division = dw_privSummary.Describe("#"+String(ll_divisionColumn)+".name")
				
			/// convert the String Division Name to a Long
			//ll_division = parent.of_getdivisionid( ls_division )
			ll_division = parent.of_getdivisionid( ll_divisionColumn )
			//ll_Division = 2201  // this is here for testing ......
			
			IF ll_division > 0 THEN
				IF ll_Module = 1 AND ll_divisionColumn = 2 THEN
					ls_Icon = CS_ALL
				ELSEIF ll_divisionColumn = 2 THEN
					ls_Icon = CS_ALLDIVISIONS
				ELSEIF ll_Module = 1 AND ll_divisionColumn > 2 THEN
					ls_Icon = CS_ALLMODULES
				ELSE
					
					lnv_currentDetail = parent.of_getdetail( ls_module, ll_division, ll_userId ) 
					
					IF isValid( lnv_currentDetail ) THEN

						lnv_CurrentDetail.of_GetUserClass(li_Icon, li_Override)
				
						ls_icon = parent.of_getIconString( li_icon, li_override )

						Destroy lnv_currentDetail
					END IF
				END IF
				dw_privsummary.SetItem( ll_module, ls_division, ls_icon )
			END IF
		NEXT
	NEXT
ELSE
	
END IF

dw_privsummary.setRedraw( TRUE )

end event

event ue_geticons;call super::ue_geticons;parent.of_getIcons( asa_icons )
end event

event ue_copytouser;call super::ue_copytouser;Long	ll_fromUser
Long	ll_toUser
String	ls_module	
String	ls_division
String	lsa_copyToDivisions[]

n_cst_msg	lnv_msg
s_parm		lstr_parm


ll_fromUser = this.of_getuserid( )
ll_toUser = this.of_getCopyToUser( )
ls_module = sle_currentmodule.text
ls_division = sle_currentdivision.text


//here i need to get a list of divisions that  are being copied to
this.of_getcopytodivs( lsa_copyToDivisions )
parent.of_copytouser( ll_fromUser, ls_division, ls_module, ll_toUser, lsa_copyToDivisions )






end event

event ue_getdivisioncol;call super::ue_getdivisioncol;Long	 ll_index
Long	 ll_max
Long	 ll_return
Long	 ll_id

Datastore lds_divisions 
//dan
lds_divisions = parent.of_getDivisions( )

IF isValid( lds_divisions ) THEN
	ll_max = lds_divisions.rowCount( )
	FOR ll_index = 1 TO Ll_max
		ll_id = lds_divisions.getitemNumber( ll_index, "st_id" )
		IF ll_id = al_divisionId THEN
			ll_return = ll_index + 1    //offset for the module row
			EXIT
		END IF
	NEXT
END IF

RETURN ll_return

end event

event ue_getprivmanager;call super::ue_getprivmanager;anv_privManager = parent.of_getPrivmanager( )
end event

event ue_getdivisionid;call super::ue_getdivisionid;al_divisionId = parent.of_getDivisionid( as_division )
end event

event ue_geticonid;call super::ue_geticonid;ai_iconId = parent.of_geticonid( as_icon )
end event

event ue_geticon;call super::ue_geticon;as_icon = parent.of_getIconString( al_iconId, ai_class )
end event

event ue_getmyprivmanager;RETURN parent.of_getPrivsManager()
end event

type cb_save from commandbutton within w_userprivs
integer x = 2821
integer y = 1544
integer width = 242
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;
if isValid( inv_privManager ) THEN
	IF uo_privs.enabled THEN
		inv_privManager.of_save( )
	END IF
	
END IF

parent.event ue_saveSettings()

IF inv_shiptype.of_savedivisiondefaults( ) = 1 THEN
	
ELSE
	MessageBox("Copied Divisions", "Error Saving default divisions.")
END IF
end event

type cb_close from commandbutton within w_userprivs
integer x = 3086
integer y = 1544
integer width = 238
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
boolean cancel = true
end type

event clicked;close( parent )
end event

type uo_1 from u_cst_syssettings_enumerated_cbx within w_userprivs
integer x = 32
integer y = 20
integer taborder = 10
boolean bringtotop = true
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_advancedprivs

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_cbx::destroy
end on

event destructor;call super::destructor;Destroy inv_syssetting
end event

event ue_choicechanged;call super::ue_choicechanged;IF as_Value = "Yes" THEN
	//uo_privs.Enabled = TRUE
	Parent.Event ue_Enable(TRUE)
ELSE
	//uo_privs.Enabled = FALSE
	Parent.Event ue_Enable(FALSE)
END IF


	
end event

