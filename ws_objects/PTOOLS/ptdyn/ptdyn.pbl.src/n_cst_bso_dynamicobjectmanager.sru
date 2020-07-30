$PBExportHeader$n_cst_bso_dynamicobjectmanager.sru
forward
global type n_cst_bso_dynamicobjectmanager from n_cst_bso
end type
end forward

global type n_cst_bso_dynamicobjectmanager from n_cst_bso
event type integer ue_requestrefresh ( )
event ue_adjustprefilterdef ( string as_name,  string as_filterdef )
event ue_restrictdws ( n_cst_restrictioncriteria anv_criteria,  u_dw_quickmatch adw_qm )
event ue_clearrestrictions ( string as_type )
end type
global n_cst_bso_dynamicobjectmanager n_cst_bso_dynamicobjectmanager

type prototypes
FUNCTION int ShowWindow(integer al_handle, integer ai_state) LIBRARY &
"user32.dll" 

end prototypes

type variables
PUBLIC:
	Datastore 	ids_settings				// saving/loading user settings cache
	Datastore	ids_dynamicObjects		// cache for creating new objects
	Datastore	ids_linkages				// cache for creating/saving linkages
	Datastore	ids_linkArgs				// cache for creating/saving abstract linkages
	Datastore	ids_MouseOvers				// cache for creating/saving mouseovers
	Datastore	ids_delete					// cache used to keep list of deleted instances
	W_master		iw_Window					// the window of_create is calle on
	String		is_loggedInUser			// the name of the outer or main window
	String		is_outerWindow
	Int			ii_saveAbsMode				// 0 - updates old definition
													// 1 - creates new definition
	String			isa_ObjectNames[]		// on creation this is populated with all object names that are created
	
												
	
	
	Constant String	cs_WindowTemplate = "Window Template"
	Constant String	cs_DataWindowTemplate = "DataWindow Template"
	Constant String	cs_ShipmentTemplate	= "Shipment Template"
	Constant String	cs_DriverTemplate = "Driver Template"
	Constant String	cs_EquipmentTemplate = "Equipment Template"
	Constant String	cs_TabTemplate	= "Tab Template"
	Constant String	cs_QuickMatchTool = "Quick Match Tool"
	Constant String	cs_adminTool = "Admin Tool"
	
	//Properties for window placement that manager must manage
	Constant String	cs_State = "state"
	Constant String	cs_MinPosX = "minposx"
	Constant String	cs_MinPosY = "minposy"
	Constant String   cs_NormalPosTop = "normalpostop"
	Constant String	cs_NormalPosLeft = "normalposleft"
	Constant	String	cs_NormalPosRight = "normalposright"
	Constant String	cs_NormalPosBottom = "normalposbottom"
	Constant String	cs_PlacementFlag = "placementflag"
	
	Constant String	cs_globalReplaceRN = "#^*"
	//return codes for validating the swapping of dataobjects
	Constant int		ci_FailedDOLinkageTest = -1
	Constant int		ci_FailedDOColArgTest = -2
	Constant int		ci_FailedDoMouseOverTest = -3
	Constant int		ci_FailedDOComputeTest = -4
	Constant int		ci_failedArgTest= -5
	Constant int		ci_AllertDOPathNonValid = 5

	//return code erros for save absdef
	Constant int		ci_failedupdateDynObjTable = -1
	Constant int		ci_failedupdateDynPropTable = -2
	
	Constant int		ci_invalidMode	= -3
	Constant int		ci_invalidObjName = -4
	Constant int		ci_nonDynamicObject = -5
PRIVATE:
	DragObject		idrg_openedUserObjects[]		


	Long			ila_dbLinkids[]			//these two arrays are used only for importing
	Long			ila_importlinkIds[]		//mouseovers.  They are initialized in importing
													//of links, and are intended to map the imported
													//id to the database linkid.
													
	String		isa_importDataObjectPaths[]		//the list of dataobjects that need 
																//to be copied over when an import
																//of an object definition occurs
	
	Boolean		ib_checkedPath				//this keeps track of wether or not the object manager
													//has already asked about where to put imported .psr
													//files. it is reset to false at the beginning of any import.
	
	String		is_importPSRPath
end variables

forward prototypes
public function integer of_loadusersettings (string as_name)
public function integer of_initialize ()
public function integer of_setmainwindow (string as_winname)
public function integer of_setloggedinuser (string as_username)
public function integer of_savesettings ()
public function string of_getmainwinname ()
public function String of_getcurrentuserid ()
protected function long of_setproperties (powerobject apo_object, long al_index)
public function integer of_saveobject (powerobject apo_object, string as_parentname)
public function integer of_saveproperty (string as_objname, long al_instance, string as_parentname, string as_proplabel, string as_propvalue, string as_classname, string as_type)
public function integer of_savepropasdef (string as_objname, string as_propname, string as_propvalue, string as_classname, string as_type)
public function integer of_tellchildrenfixparentname (powerobject apo_parent, string as_oldname, string as_newname)
public function integer of_fixsettings (string as_objname, long al_instance, string as_parentname, string as_newparentname)
public function integer of_changeobjectnameindb (string as_objname, long al_objinstance, string as_newname, string as_parentname)
public function integer of_savepropaschilddef (string as_objectname, long al_instance, string as_parentname, string as_label, string as_value, string as_classname, string as_type)
public function integer of_savetomode (integer ai_mode, string as_objname, long al_instance, string as_parent, string as_label, string as_value, string as_class, string as_type)
public function integer of_loadlinkages (window aw_window)
public function integer of_loadmouseovers (window aw_window)
public function integer of_savelinkages (window aw_window)
public function integer of_saveabsdef (powerobject apo_object, integer ai_savemode, string as_newobjname, string as_description)
public function boolean of_existsuserdef (string as_name, long al_instance, string as_parent)
public function integer of_addtodeletecache (string as_name, string as_parentname, long ll_instance)
public function boolean of_isdeletableobject (string as_name)
public function integer of_loadwindowdefinition ()
protected function integer of_create (ref powerobject apo_object, ref powerobject apo_parent, long al_objectindex)
public function integer of_loadtabs (window aw_window)
public function boolean of_deleteok (string as_objname, long al_instance, string as_parent)
public function integer of_removefromcache (string as_objectname, string as_parentname, long al_instance, boolean ab_removefromwindef)
public function integer of_removeunsavedprefiltersfromcache ()
public function integer of_getsystemdataobjects (ref string as_dataobjects[])
public function boolean of_ismanagerdefinedproperty (string as_label)
private function integer of_setwindowplacementprop (string as_label, string as_property, ref s_windowplacement astr_windowplacement)
private function boolean of_iswindowplacementset (s_windowplacement astr_winplacement)
public function integer of_savewatchlists ()
public function integer of_addobjnamestolist (string asa_names[])
public function integer of_refreshlinkagecache ()
public function integer of_discardprefilter ()
public function integer of_validatedataobjectchange (string as_objectname, string as_olddataobject, string as_newdataobject, ref string as_errormessage)
public function integer of_validatemouseoverexpression (string as_expression, n_ds ads_datastore)
private function boolean of_colnameexists (string as_colname, n_ds ads_source)
public function boolean of_compareargs (n_ds ads_source1, n_ds ads_source2)
private function integer of_refreshdetaillinks (window aw_window)
private function integer of_getexportobjlist (string as_objectname, ref string asa_names[])
public function integer of_exportobjectproperties (string as_parent, string as_object, integer ai_file)
public function boolean of_objectexists (string as_objectname)
private function integer of_getlabelandvalue (ref string as_label, ref string as_value, string as_parsestring)
private function boolean of_compareabstractproperties (string as_file, string as_objectname)
private function integer of_getuniquelinkidlist (ref long ala_linkids[], datastore ads_links)
public function integer of_exportlinks (string as_windowname, integer li_file)
private function integer of_importlinks (string as_file)
public function long of_linkagedefinitionexists (string as_mastername, string as_detailname, string as_style, string asa_mastercols[], string asa_detailcols[])
public function integer of_exportmouseovers (string asa_objectnames[], long al_file)
public function integer of_importmouseovers (string as_file, string asa_objectstoimport[])
public function long of_getstringindex (string as_name, string asa_namearray[])
private function integer of_adddataobjecttoimport (string as_dataobject)
private function integer of_copydataobjects (string as_path)
private function string of_getimportdataobjectpath ()
public function integer of_movepsrsto (string as_topath)
public function integer of_saveprefilter (powerobject apo_object, string as_name, ref string as_msg)
private function integer of_updatetabrefcachesettings (string as_objname, string as_newobjname, long al_instance, u_tab ataba_tab[])
public function integer of_exportallfordefinition (string as_objectname)
public function integer of_exportdynamicdefinitition (string as_objectname, string as_path, string as_file, ref string asa_windownames[], boolean ab_append)
public function integer of_getimportfilenames (string as_fromfile, ref string asa_filenames[])
private function integer of_writeobjecttofile (integer ai_filenum, string lsa_file[])
public function integer of_importalldynamicdefinitions (ref string as_error)
public function integer of_importdynamicdefinition (ref string as_errormessage, string as_pathname, string as_filename)
public function integer of_getcreatedobjects (ref dragobject adrg_objectscreated[])
public function integer of_addopeneduserobject (ref dragobject adrg_object)
public function long of_getsystemobjects (ref n_ds ads_systemobjects)
public function integer of_insertnewsystemobjectproperty (ref datastore ads_cache, string as_objectname, string as_proplabel, string as_propvalue)
end prototypes

event type integer ue_requestrefresh();//trigger event on iw_window to refresh itself
int li_return

IF isValid( iw_window ) THEN
	li_return = iw_window.triggerEvent( "ue_refreshDws" )

ELSE
	li_return  = -1
END IF

return li_return
end event

event ue_adjustprefilterdef(string as_name, string as_filterdef);//THe following calls an event on the main window to change the prefilter definitions on 
//all instances of object as_name, to the passed in as_filterDef.

Long	ll_index
Long	ll_max

IF isvalid( iw_window ) THEN
	
 	IF iw_window.triggerEvent( "ue_hasIds" )  = 1 THEN
		iw_window.dynamic of_adjustPrefilters( as_name, as_filterDef )
	END IF
	
END IF
end event

event ue_restrictdws(n_cst_restrictioncriteria anv_criteria, u_dw_quickmatch adw_qm);//forward info to the main window if it is valid
IF isValid( iw_window ) THEN
	iw_window.event ue_restrictDws( anv_criteria,adw_qm )
	
END IF
end event

event ue_clearrestrictions;IF isValid( iw_window ) THEN
	iw_window.event ue_clearRestriction( as_type )
END IF
end event

public function integer of_loadusersettings (string as_name);/***************************************************************************************
NAME: of_loadUserSettings()			

ACCESS:		public	
		
ARGUMENTS: 		
							as_name:	the name of the object being searched for to be created.

RETURNS:		Returns 1 if the outer most window was opened and -1 if it fails.
	
DESCRIPTION: The following will handle an object specified as an argument and populate
	it with the correct user data.
	It has a username that isn't null, and it has no parent container.
	
	

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created 8-3-05   By Dan
	

***************************************************************************************/

//This function initializes the population and settings for the currently logged 
//in user.  It should be called after a user has logged into the system.

long 		ll_RowCount
long		ll_index
long		ll_instance
int		li_createResult
string	ls_findString
string	ls_objectName
Window	lw_window				//this is only used for the purpose of having something to open objects
										//up on right now.  It is instantiated in the of_populate call.
										
PowerObject	lpo_placeHolder	//does nothing but hold a place in a function call.

SetPointer(HourGlass!)

ll_RowCount = ids_settings.rowCount()	
ll_instance = -1	//this way it will find the first instance number, since there is no -1 instance in db

//ls_findString = "(ISNULL(dynamicproperty_containername) " &
//						+" AND NOT ISNULL(dynamicproperty_userName )) " &
//						+" AND dynamicproperty_instance <> " + string(ll_instance) &
//						+" AND dynamicproperty_objectname = '" + as_name + "'"

ls_findString =  "dynamicproperty_objectname = '" + as_name + "'"
					

//trys to find at least one instance before populate call is made
ll_index = ids_settings.find(ls_findString,1, ll_rowCount)

IF ll_index > 0 THEN
	li_createResult = of_create(lw_window, lpo_placeHolder ,ll_index)		
	iw_window = lw_window
ELSE
	li_createResult = -1
END IF

IF li_createResult = 1 THEN
	this.of_loadLinkages( iw_window )
END IF

IF li_createResult = 1 THEN
	this.of_loadMouseovers( iw_window )
	this.of_loadTabs( iw_window )
END IF

IF isValid( iw_window ) THEN
	//forces refresh
	iw_window.is_lastshipmentcachechange = ""
	iw_window.triggerEvent( "ue_refreshDws" )
	iw_window.setredraw(true)
END IF

IF li_CreateResult = 1 THEN
	This.of_RefreshDetailLinks(iw_Window)
END IF


return li_createResult





end function

public function integer of_initialize ();/***************************************************************************************
NAME: 		open	

ACCESS:			public
		
ARGUMENTS: 		
							(none)

RETURNS:			returns 1 for now
	
DESCRIPTION: Does the retrieval for ids_settings.  Note that it takes parameters
	below in which "PTADMIN" will be a global function call to get the currently logged
	in user.
	
	Right now it assumes the Main Window is win1.  For actual retrieval,
	specify the user and window name using the functions setMainWindow() and setLoggedInUser.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : created 8-3-05 By Dan
	

***************************************************************************************/


is_loggedInUser = gnv_app.of_getUserId( )			//just for testing 

IF NOT IsValid( ids_settings )THEN
	ids_settings = create DataStore
	ids_settings.DataObject = "d_dynamicpropertycache"
	ids_settings.SetTransObject( SQLCA )	
END IF

//gets a retrieval for whatever user is currently logged in.
ids_settings.retrieve( is_outerWindow , "" , is_loggedInUser )
COMMIT;


//create datastore and set transobject for adding new object names 
//to the dynamicObjects table
IF NOT isValid( ids_dynamicObjects ) THEN
	ids_dynamicObjects = create Datastore
	ids_dynamicObjects.DataObject = "d_dynamicObjects"
	ids_dynamicObjects.SetTransObject( SQLCA )
END IF
setpointer( hourglass! )
of_loadUserSettings(is_outerWindow)

return 1

end function

public function integer of_setmainwindow (string as_winname);is_outerWindow = as_winName

return 1
end function

public function integer of_setloggedinuser (string as_username);is_loggedInUser = as_userName
return 1

end function

public function integer of_savesettings ();/***************************************************************************************
NAME: 			of_saveSettings

ACCESS:			
		
ARGUMENTS: 		
							(none)

RETURNS:			returns 1 if iw_window was saved and update to the db was a success.
								-1 otherwise
	
DESCRIPTION: Calls save of_saveObject on the iw_window
				That function recursively calls of_saveObject on them
				until all of the user's settings are saved 
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :Created By Dan  8-16-05
	

***************************************************************************************/
int li_result
String 	ls_message
Long	ll_index
Long	ll_max

String 	ls_name
String	ls_parentName
Long		ll_instance


//remove deleted objects from the cache
IF isValid( ids_delete ) THEN
	ll_max = ids_delete.rowCount()
	FOR ll_index = 1 TO ll_max
		
		ls_name = ids_delete.getItemString( ll_index, "dynamicproperty_objectname" )
		ls_parentName = ids_delete.getItemString( ll_index, "dynamicproperty_containername")
		ll_instance = ids_delete.getItemNumber( ll_index , "dynamicproperty_instance")
		
		this.of_removeFromCache( ls_name, ls_parentName, ll_instance, FALSE)
	
	NEXT
END IF

li_result = this.of_saveObject(iw_window, "")

IF li_result = 1 THEN
	
	//the arguments to this function no longer mean anything, the function discards
	//all prefilter rows.
	this.of_discardPrefilter( /*ls_name, ll_instance, ls_parentName*/)
	li_result = ids_settings.update()

	//do something to let them know if it worked or not

	//if update was successful, change the database
	IF li_result = 1 THEN	 
		ls_message = "User Settings Saved Successfully"
		IF isValid  ( ids_delete ) THEN
			ids_delete.reset()
		
		END IF
		COMMIT;
	ELSE
		ls_message = "Save Error, no settings were saved"
		ROLLBACK;	 
		li_result = -1
		MessageBox("Saving", ls_message)
	END IF

END IF






return li_result
end function

public function string of_getmainwinname ();return is_outerWindow
end function

public function String of_getcurrentuserid ();return is_loggedInUser
end function

protected function long of_setproperties (powerobject apo_object, long al_index);/***************************************************************************************
NAME: 	of_setProperties		

ACCESS:	protected
		
ARGUMENTS: 		
							apo_object:	 the object that is having its properties set.
							al_index: 	 the index containing the information about apo_object.

RETURNS:			integer( returns 1 for now )
	
DESCRIPTION: Takes an object apo_object, and loops through to find properties and set them
				For the object as defined by al_index in ids_settings.
					
				Also if the object has the ability to have its name and instance set, then 
				it does.  If the instance is null, then it sets its instance to -1.
				
				Also if the object can have its property manger set, then this sets it
				to this property manager.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	8-10-05
	

***************************************************************************************/

long 		ll_index
long 		ll_max
long		ll_Instance
long		ll_queriedInstance
long		ll_arrayMax

String 	ls_property
String	ls_value
String 	ls_ObjectName
String	ls_containerName
String 	ls_queriedObjectName
String	ls_queriedUserName
String	ls_queriedContainerName

int	li_return
Long	ll_Handle
Long	ll_State
Long	ll_Flags
Long	ll_MinPositionX
Long	ll_MinPositionY
Long	ll_NormalPositionTop
Long	ll_NormalPositionLeft
Long	ll_NormalPositionRight
Long	ll_NormalPositionBottom


Constant Long	WPF_SETMINPOSITION = 1

s_WindowPlacement	lstr_WinPlacement


GetWindowPlacement(Handle(apo_object), lstr_WinPlacement)
//Initialize winplacement struct so we can test values before we 
//call setwindowplacement()
lstr_WinPlacement.showCmd = -2
lstr_WinPlacement.flags = WPF_SETMINPOSITION
lstr_winPlacement.ptMinPosition.x = -2
lstr_winplacement.ptMinPosition.y = -2
lstr_WinPlacement.ptMaxPosition.x = -1//We are not setting maxpos
lstr_WinPlacement.ptMaxPosition.y = -1//We are not setting maxpos
lstr_WinPlacement.rcNormalPosition.top = -2
lstr_WinPlacement.rcNormalPosition.left = -2
lstr_WinPlacement.rcNormalPosition.right = -2
lstr_WinPlacement.rcNormalPosition.bottom = -2



ll_max = ids_settings.rowCount()

ls_objectName = ids_settings.getItemString(al_Index, "dynamicproperty_objectname")
ll_instance = ids_settings.getItemNumber(al_Index, "dynamicproperty_instance")
ls_containerName = ids_settings.getItemString(al_Index, "dynamicproperty_containername")

//anything created should have this event, otherwise it will not be saved
//since saving the object depends on having the identifiers being valid
IF apo_object.TriggerEvent("ue_setIdentifiers") = 1 THEN
	//if object created is not an outer window, then it has an instance number 
	IF NOT isNull(ll_instance) THEN
		apo_object.dynamic Event ue_setIdentifiers(ls_objectName, ll_instance)
	
	//otherwise we give it an invalid instance number to signify null being saved in the 
	//instanceNumber later on.
	ELSE
		apo_object.dynamic Event ue_setIdentifiers(ls_objectName, 1)
	END IF
	
	
	//adds the object name to the array of object names for linkage set up later on.
	ll_arrayMax = upperBound(isa_ObjectNames)
	isa_ObjectNames[ll_arrayMax+1] = ls_objectName
END IF


for ll_index = 1 to ll_max
	ls_queriedObjectName = ids_settings.getItemString(ll_index, "dynamicproperty_objectname")
	ls_queriedUserName = ids_settings.getItemString(ll_index, "dynamicproperty_username")
	ls_property = ids_settings.getItemString(ll_index, "dynamicproperty_propertylabel")
	ls_value = ids_settings.getItemString(ll_index, "dynamicproperty_propertyvalue")
	ll_queriedInstance = ids_settings.getItemNumber(ll_index, "dynamicproperty_instance")
	ls_queriedContainerName = ids_settings.getItemString(ll_index, "dynamicproperty_containername")
	
	ls_queriedContainerName = trim(ls_queriedContainerName)
	
	//ls_containername is null only if apo_object is the mainwindow.  When creating a main window
	//the index sent in is based on a find where the container name and instance can be null.  For all
	//other objects being created on the main window, the index passed in represents a row where the containername
	//and instance number cannot be null.  Setting the propeties of main windows requires different conditions
	//then setting properties on child objects.  The difference is a check to see if containername and
	//instance number matches.
	IF isNull(ls_ContainerName) THEN			//parent window properties being set
		
		IF isNULL(ls_queriedContainerName) THEN
			IF ls_ObjectName = ls_queriedObjectName THEN
				IF of_ismanagerdefinedproperty(ls_Property) THEN
					of_Setwindowplacementprop( ls_Property, ls_Value, lstr_WinPlacement)
				ELSE
					apo_object.dynamic of_setProperty(ls_property, ls_value)
				END IF
			END IF
		END IF
		
	ELSE						//childwindow, datawindows, all other non container objects
		
		IF isNULL(ls_queriedContainerName) THEN
			IF ls_ObjectName = ls_queriedObjectName AND (ll_instance = ll_queriedInstance OR isNull(ll_queriedInstance)) THEN
				IF of_ismanagerdefinedproperty(ls_Property) THEN
					of_Setwindowplacementprop( ls_Property, ls_Value, lstr_WinPlacement)
				ELSE
					apo_object.dynamic of_setProperty(ls_property, ls_value)
				END IF
			
			END IF
		ELSE
			IF ls_ObjectName = ls_queriedObjectName &
				AND (ll_instance = ll_queriedInstance OR isNull(ll_queriedInstance))  &
				AND ls_containerName = ls_queriedContainerName THEN
					IF of_ismanagerdefinedproperty(ls_Property) THEN	
						of_Setwindowplacementprop( ls_Property, ls_Value, lstr_WinPlacement)
					ELSE
						apo_object.dynamic of_setProperty(ls_property, ls_value)
					END IF
			END IF
		END IF
		
	END IF

next


IF of_isWindowPlacementSet( lstr_WinPlacement ) THEN
	li_return = SetWindowPlacement(Handle(apo_object), lstr_WinPlacement)
	IF apo_object.className() = "w_sheet_dynamiccontrol" THEN
		//Must set redraw back to false becuase setting of window placement resets redraw
		apo_object.Dynamic setredraw(FALSE)
	END IF
END IF



return 1

end function

public function integer of_saveobject (powerobject apo_object, string as_parentname);/***************************************************************************************
NAME: 			of_saveObject

ACCESS:			public
		
ARGUMENTS: 		
							apo_object:	the object being saved.
							as_parentName: the name of the parent being saved for apo_object into the cache.

RETURNS:			Returns 1 if apo_object was saved successfully.
								-1 if an error occurred.
	
DESCRIPTION:	This method saves all the properties of the object being passed in to 
					the database. It then makes a recursive call to all of the objects
					in the objects control(if it is a window), and also attempts to make
					a recursive call on all the children windows. In order for this function
					to work correctly and save the objects, the objects must have the following
					functions and events implemented.  
					
					
					-----------------------------------------------------------------
					<key event> implies	apo_object has <functions, events, instance>
					
					ue_hasIds() 	=> 	of_getObjName() AND of_getObjInstance() 
						
					ue_saveAllDynamicProperties(string parentName) => has this service object 


					If apo_object is a window with children
					
					ue_hasChildrenWindows() =>	of_getChildrenWindows(ref window [])

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 8-12-05
	

***************************************************************************************/
String 	ls_objectName
String	ls_userId
String	ls_findString
Long		ll_Instance
Long		ll_max
Long		ll_index
Long		ll_findIndex

int		li_deleteRes
int 		li_return
int		li_result

Window		lw_window
Window		lwa_childrenWindows[]
PowerObject	lpo_child
PowerObject lpoa_children[]
Window lpoa_children2[]
String		ls_lasterror


ii_saveabsmode = 0		//this is set so that we can be sure the objects x and y
								//coordinates get saved.

// if ue_hasIds fires for this object then it guarantees that
//	the following functions are created.
IF apo_object.triggerEvent( "ue_hasIds" ) = 1 THEN
	ls_objectName = apo_object.dynamic of_getObjName( )
	ll_instance = apo_object.dynamic of_getObjInstance( )
	
	IF isNull(ls_objectName) OR isNULL(ll_instance) THEN 
		li_return = -1
	ELSE
		li_return = 1
	END IF
	
ELSE
	li_return = -1
	
END IF

IF li_return = 1 THEN
	// triggering this event causes the object to give this service the savable data 
	// through a different function, and that function decides how to save the data.
	//li_return = apo_object.triggerEvent( "ue_saveAllDynamicProperties" )
	
	//First, verify that the event is defined on the object.  This call will not launch
	//any processing, because the required parameter is not supplied.
	li_return = apo_object.triggerEvent( "ue_savedynamicproperties" )
	
	//If the event is defined, call it with the save type parameter.
	IF li_return = 1 THEN
		//not really saving as abstract in this mode, just saving the instance
		apo_object.dynamic EVENT ue_savedynamicproperties(1 /*Save User Properties*/)	
		
	END IF
	
	
	// if the object being saved is a window and successful to this point, then
	// we want to try and save properties of all the objects that are in the control array
	// of the object, and also save the properties of children windows on the object.
	// (Child windows are not stored in the control array, so they need to be referenced separately.)
	
	IF typeOf(apo_object) = window! AND li_return = 1 THEN
		lw_window = apo_object
		lpoa_children = lw_window.Control
		ll_max = upperBound( lpoa_children )
		
		// recursive call on all objects that are in the control of this window
		for ll_index = 1 to ll_max
			IF isValid(lpoa_children[ll_index]) THEN
				this.of_saveObject( lpoa_children[ll_index], ls_objectName )
			END IF
			
		next

		// if this window had children windows 
		IF apo_object.triggerEvent("ue_hasChildrenWindows") = 1 THEN
			lw_window.dynamic of_getChildrenWindows(lpoa_children2)
			
			
			IF NOT isNull(lpoa_children2) THEN   //Probably not necessary, but j.i.c.
				ll_max = upperBound(lpoa_children2)
			ELSE
				ll_max = 0
			END IF
			
			// recursive call on all children windows that are on lw_window
			for ll_index = 1 to ll_max
				lpo_child = lpoa_children2[ll_index]
				IF isValid(lpo_child) AND NOT isNull(lpo_child) THEN
					this.of_saveObject( lpo_child, ls_objectName )
					
				END IF
				
			next
			
		END IF
		
	
	// if there are other types of objects that can have children, then 
	// it would have to be specified here as to how to get at them so that
	// a recursive call could be made to save the children 
	ELSE
		
		//no action
	
	END IF
	
END IF


return li_return
end function

public function integer of_saveproperty (string as_objname, long al_instance, string as_parentname, string as_proplabel, string as_propvalue, string as_classname, string as_type);/***************************************************************************************
NAME: 	of_saveProperty()		

ACCESS:			public
		
ARGUMENTS: 		
							as_objName: the name being inserted into the cache.
							al_instance: the instance # being inserted into the cache
							as_parentName: the parent name being inserted into the cache.
											(must be a valid name if the object is a datawindow,
											this function doesn't check it though)
							as_proplabel: the property identifier being saved to the cache.
							as_propValue: the value corresponding to as_propLabel being inserted into the cache.
							as_className: the name of the class being inserted into the cache.
							as_type:			the typ of the object being inserted into the cache.
											

RETURNS:			integer(returns 1 right now)
	
DESCRIPTION: This function is used to save the specified property only if there isn't
				 already an abstract property definition with the same value stored in 
				 the database for an object with the same name and instance number.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	

***************************************************************************************/
String 	ls_findString
String	ls_valueFound
Long		ll_index
Long		ll_index2
Long 		ll_max
Long		ll_newRow
Boolean	lb_checkAbsDef

int 		li_test

if as_proplabel = cs_State then
	li_test = li_test
end if

//we don't want to save the x and y settings in the event that it is being saved as part of
//the abstract definition mode 1
IF ii_saveAbsMode <> 1 OR isNULL(as_parentName) OR as_parentName = "" THEN
	//----Delete old property--------------------------------------------------------------------
	
	ll_max = ids_settings.rowCount()				
	
	//looks for property already defined for this instance of an object even if it has no parent
	ls_findString = "dynamicproperty_objectname = '" +as_objName + "'" &
						+" AND dynamicproperty_propertylabel = '" + as_propLabel + "'" &
						+" AND dynamicproperty_instance = " +string(al_instance) &
						+" AND dynamicproperty_username = '" +gnv_app.of_getUserId( ) +"'"
	
	// parent, then it checks for parent name match as well
	IF NOT isNull(as_parentName) AND as_parentName <> "" THEN
		ls_findString = ls_findString+ " AND dynamicproperty_containername = '" + as_parentName +"'"
	ELSE
		ls_findString = ls_findString + "AND isNULL(dynamicproperty_containername)" 
	END IF
	
	ll_index2 = 1
	
	ll_index2 = ids_settings.find( ls_findString, ll_index2, ll_max )	
	IF ll_index2 > 0 THEN
		ids_settings.deleteRow( ll_index2 )
		ll_max = ll_max -1
	END IF
	
	
	//discard all matching property names, we don't want them there anymore
	DO WHILE ll_index2 > 0 
		// find it
		ll_index2 = ids_settings.find( ls_findString, ll_index2, ll_max )	
		ids_settings.rowsDiscard( ll_index, ll_index2 , PRIMARY! )
		ll_max = ll_max -1
		
		IF ll_index2 > ll_max THEN
			ll_index2 = 0 
		END IF
		
		//MessageBox("ofSaveprop", ll_index2)
	LOOP
	
	//----Add the new property--------------------------------------------------------------------
	ll_max = ids_settings.rowCount()
	ll_index = 0
	
	IF NOT isNull(as_parentName) and as_parentName <> "" THEN
		//looks for an abstract definition for the object as an instance of the abstract parent definition
		ls_findString = "dynamicproperty_objectname = '" +as_objName + "'" &
						  + " AND isNull( dynamicproperty_username )" &
						  + " AND dynamicproperty_containername = '"+ as_parentname +"'" &
						  + " AND dynamicproperty_instance = " + string(al_instance) &
						  + " AND dynamicproperty_propertylabel = '" + as_propLabel + "'" 
						 // + " AND dynamicproperty_propertyvalue = '" + as_propValue + "'" 
		
		//result of first find				  
		ll_index = ids_settings.find( ls_findString, 1, ll_max )		
	END IF
	
	//if ll_index is 0 then there is no abstract definition for this object's parent definition.
	//That means I have to look for an abstract definition of just this object.
	IF ll_index = 0 THEN
		//looks for abstract definition of the same property that equals the one passed in
		ls_findString = "dynamicproperty_objectname = '" +as_objName + "'" &
						  + " AND isNull( dynamicproperty_username )" &
						  + " AND isNull( dynamicproperty_containername )" &
						  + " AND isNull( dynamicproperty_instance )" &
						  + " AND dynamicproperty_propertylabel = '" + as_propLabel + "'" &
						  + " AND dynamicproperty_propertyvalue = '" + as_propValue + "'" 
		
		//result of second find				  
		ll_index = ids_settings.find( ls_findString, 1, ll_max )		
			
	ELSE
		//ll_index > 0
		IF as_propValue = ids_settings.getItemString(ll_index,"dynamicproperty_propertyvalue") THEN
			//lb_checkAbsDef = false
			ll_index = 1
		ELSE
			ll_index = 0		//not the same so save the setting
		END IF
	END IF
	
	//if no abstract entry to compare to, OR the property is different than the abstract
	//add the property to the db. To be saved as a user property, at least properties
	//x and y have to be saved as a user property.
	IF ll_index <= 0  /*OR as_propLabel = "X" OR as_propLabel = "Y" */THEN
		IF Trim ( as_parentName ) = "" THEN
			setNull(as_parentName)
		END IF
		
		ll_newRow = ids_settings.insertRow(0)
		
		ids_settings.setItem( ll_newRow , "dynamicproperty_objectname", as_objName )
		
		//if the object is an outer window when created, its instance number was set to -1 to signify it.
		//no instance number for the outer window
		IF al_instance <> -1 THEN
			ids_settings.setItem( ll_newRow , "dynamicproperty_instance", al_instance )
		END IF
		ids_settings.setItem( ll_newRow , "dynamicproperty_propertylabel", as_propLabel )
		ids_settings.setItem( ll_newRow , "dynamicproperty_propertyvalue", as_propValue )
		ids_settings.setItem( ll_newRow , "dynamicobject_classname", as_className )
		ids_settings.setItem( ll_newRow , "dynamicproperty_username", gnv_app.of_getUserId( )	)
		ids_settings.setItem( ll_newRow , "dynamicobject_type", as_type )
	//MESSAGEBOX("userid", gnv_app.of_getUserId( ))
		// only set the parent column if it has one specified already
		IF NOT isNull(as_parentName) THEN
			 ids_settings.setItem( ll_newRow , "dynamicproperty_containername", as_parentName )
			
		END IF
		//MessageBox("of Save Property"+as_objName, string(li_test)+" "+as_propLabel+as_propvalue)
	END IF	
END IF
return 1
end function

public function integer of_savepropasdef (string as_objname, string as_propname, string as_propvalue, string as_classname, string as_type);/***************************************************************************************
NAME: 		of_savePropAsDef()	

ACCESS:			Public
		
ARGUMENTS: 		
							as_objectName: the name of the object being saved.
							as_propName:	the name of the property label.
							as_propValue: 	the string value corresponding to the label.	
							as_className:	the name of the class being saved to the cache.
							as_type:			the name of the type being saved to the cache.

RETURNS:			1 if the change was made to the cache.
					-1 if it fails.
	
DESCRIPTION: THe following saves the arguments passed in as the abstract definition 
				 of the dynamic object.  Abstract definitions do have null as instance
				 numbers and containers.  
				 
				 It saves the abstract definition differently depending on the current
				 status of the variable ii_saveAbsMode.  If ii_saveAbsMode is 0 then it
				 overwrites the abstract definition of for the specified object, and 
				 saves all other properties not cache, into the cache as well.  
				 
				 If ii_saveAbsMode is 1 then it creates new rows for all of the properties,
				 and inserts them into rows with the newly created object name which was set
				 and created in saveAbstractDefinition, making no changes to the former 
				 abstract definition for the object.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created 8-16-05 By Dan
	

***************************************************************************************/

Long 		ll_max
Long		ll_newRow
Long 		ll_index
int		li_return
int		li_result
String 	ls_findString



ll_max = ids_settings.rowCount()

// if creating a new abstract definition, then save the new settings to the cache.
// If the objects name isn't found in the database, then add it to the database.
IF (ii_saveAbsMode = 1 AND as_propName <> "X" AND as_propName <> "Y") OR ii_saveAbsMode = 3 THEN

	ll_newRow = ids_settings.insertRow(0)
	
	ids_settings.setItem( ll_newRow , "dynamicproperty_objectname", as_objName )
	ids_settings.setItem( ll_newRow , "dynamicproperty_propertylabel", as_propName )
	ids_settings.setItem( ll_newRow , "dynamicproperty_propertyvalue", as_propValue )
	ids_settings.setItem( ll_newRow , "dynamicobject_classname", as_className )
	ids_settings.setItem( ll_newRow , "dynamicobject_type", as_type	)
	
	li_return = 1
	
//Overwrites the previous abstract definition of the object.  IT already exists
//in the database.
ELSEIF ii_saveAbsMode = 0 THEN
	
	//Find the old abstract defintion for the specified object and property if it exists in
	//the cache.  Saves the new value if it is their, inserts a new row and value if it isn't.
	
	ls_findString = "dynamicproperty_objectname = '"+as_objName+"'" &
						+ " AND isNull(dynamicproperty_containername) " &
						+ " AND isNUll(dynamicproperty_instance) " &
						+ " AND isNull(dynamicproperty_username) " &
						+ " AND dynamicproperty_propertylabel = '"+ as_propName+ "'"
	
	ll_index = ids_settings.find(ls_findstring, 1, ll_max)
		
		IF as_propName <> "X" AND as_propName <> "Y" THEN
		// if found, then just change whats there
		IF ll_index > 0 THEN
			ids_settings.setItem( ll_index, "dynamicproperty_propertyvalue", as_propValue )
			
		// otherwise create new row and insert all columns into the row	
		ELSE
			ll_newRow = ids_settings.insertRow(0)
			
			ids_settings.setItem( ll_newRow , "dynamicproperty_objectname", as_objName )
			ids_settings.setItem( ll_newRow , "dynamicproperty_propertylabel", as_propName )
			ids_settings.setItem( ll_newRow , "dynamicproperty_propertyvalue", as_propValue )
			ids_settings.setItem( ll_newRow , "dynamicobject_classname", as_className )
			
		END IF
	END IF
	li_return = 1
	
ELSE
	li_return = -1			//invalid save type for abstract definition
	
END IF


return li_return
end function

public function integer of_tellchildrenfixparentname (powerobject apo_parent, string as_oldname, string as_newname);
/***************************************************************************************
NAME: 			of_tellChildrenFixParentName

ACCESS:			public
		
ARGUMENTS: 		
							apo_parent: the object whos children we need to tell about its new name
							as_oldName: the old name to look for in the cache that must be changed.
							as_newName: The name to give the child objects as a parent name, and the
											name to put in the cache to replace the old name.

RETURNS:			integer
	
DESCRIPTION:	If apo_parent is a window, it can have controller children, and children
					windows.  This function is called after the parents name has changed, and
					when it needs to tell its children what its new name is.  It loops through
					all of the children, and tries to reset the parent name on each of them by
					calling an event called ue_setParentName on them.  It also attempts to fix the
					settings of containerName for the children in ids_settings.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	8-17-2005
	

***************************************************************************************/
Int 		li_index
Int 		li_max
String	ls_childName
Long		ll_childInstance

Window	lw_window
Window	lwa_childWindows[]

//only windows can have children so far
IF typeOf(apo_parent) = window! THEN
	lw_window = apo_parent

	li_max = upperBound(lw_window.control)

	//set the parent name on all of the children if they can
	for li_index = 1 to li_max
		//this garantees that it can be done
		IF lw_window.control[li_index].triggerEvent("ue_setParentName") = 1 THEN
			lw_window.control[li_index].dynamic ue_setParentName(as_NewName)
		END IF
		
		IF lw_window.control[li_index].triggerEvent("ue_hasIds") = 1 THEN
			ls_childName = lw_window.control[li_index].dynamic of_getObjName()
			ll_childInstance = lw_window.control[li_index].dynamic of_getObjInstance()
			this.of_fixSettings(ls_childName, ll_childInstance, as_oldName, as_newName)
		END IF
		
	next
	
	//get the children windows if it has them
	IF lw_window.triggerEvent("ue_hasChildrenWindows") = 1 THEN
		lw_window.dynamic of_getChildrenWindows(lwa_childWindows)
	END IF
	
	
	li_max = upperBound(lwa_childWindows)
	
	//do the same for children windows
	for li_index = 1 to li_max
		IF lwa_childWindows[li_index].triggerEvent("ue_setParentName") = 1 THEN
			lwa_childWindows[li_index].dynamic ue_setParentName(as_NewName)
			
		END IF
		
		
		IF lwa_childWindows[li_index].triggerEvent("ue_hasIds") = 1 THEN
			ls_childName = lwa_childWindows[li_index].dynamic of_getObjName()
			ll_childInstance = lwa_childWindows[li_index].dynamic of_getObjInstance()
			this.of_fixSettings(ls_childName, ll_childInstance, as_oldName, as_newName)
			
		END IF
	next
	
END IF

return 1

end function

public function integer of_fixsettings (string as_objname, long al_instance, string as_parentname, string as_newparentname);/***************************************************************************************
NAME: 			of_fixSettings

ACCESS:			public
		
ARGUMENTS: 		
							as_objName: the object whos parent name is changing
							al_instance: the instance whos parent name is changing
							as_parentName: the old parent name for as_objName
							as_newParentName: the name replacing the old name.

RETURNS:			returns 1 for now.
	
DESCRIPTION:	This function loops through ids_settings looking for matches to as_objName, 
					al_instance, and as-parentName. For everyone it finds, it replaces the old
					parent name with the new parent Name.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 8-16-2005
	

***************************************************************************************/
String 	ls_findString
Long		ll_index
Long		ll_max


// i think all of these need to be valid if this is going to work
IF NOT isNull(as_objName) AND NOT isNull(al_instance) AND NOT isNull(as_parentName) AND NOT isNull(as_newParentName) THEN
	ll_index = 1
	ll_max = ids_settings.RowCount()
	
	//find in ids settings something that matches as_objname, old parent name, and instance #
	ls_findString = "dynamicproperty_objectname = '"+as_objName +"'" &
					 	+" AND dynamicproperty_containername = '" + as_parentName + "'" &
					 	+" AND dynamicproperty_instance = "+string(al_instance)

	//find everthing that matches the findstring
	DO WHILE ll_index > 0
		ll_index = ids_settings.find(ls_findString, ll_index, ll_max)
	
		//if found a valid index, change the parent name to the new parent name
		IF ll_index > 0 THEN
			ids_settings.setItem(ll_index, "dynamicproperty_containername", as_newParentName)
		END IF
						 
	LOOP
	
END IF

return 1
end function

public function integer of_changeobjectnameindb (string as_objname, long al_objinstance, string as_newname, string as_parentname);/***************************************************************************************
NAME: 			of_changeObjectNameInDb

ACCESS:			Public
		
ARGUMENTS: 		
							as_objName: the name of the object we want to remove.
							al_objInstance: the instance number we want to remove.
							as_newName:  NOT USED ANYMORE
							as_parentName: the parent of the object we want to remove.

RETURNS:			returns 1 for now.
	
DESCRIPTION:	This function looks for a match in ids_settings to as_objName, al_objInstance
					and as_parentName, for every one it finds, it removes it.  
					This function is used to remove an instance from ids_settings.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created 8-17-2005 By Dan
	

***************************************************************************************/
String	ls_findString
Long		ll_index
Long		ll_max


ll_max = ids_settings.rowCount()

//findstring to find matches in ids_settings of objName, parentName, and instance #
ls_findString = "dynamicproperty_objectname = '"+ as_objName +"'" &
					+" AND dynamicproperty_containername = '"+ as_parentName +"'" &
					+" AND dynamicproperty_instance = "+string(al_objInstance)

ll_index = 1

//loop through ids_settings
DO WHILE ll_index >0 
	ll_index = ids_settings.find(ls_findString, ll_index, ll_max)

	//if found a match, remove it
	IF ll_index > 0 THEN
		ids_settings.deleteRow(ll_index)
	END IF
LOOP

return 1
end function

public function integer of_savepropaschilddef (string as_objectname, long al_instance, string as_parentname, string as_label, string as_value, string as_classname, string as_type);/***************************************************************************************
NAME: 			of_savePropAsChildDef

ACCESS:			
		
ARGUMENTS: 		
							as_objName: the name being inserted into the cache.
							al_instance: the instance # being inserted into the cache
							as_parentName: the parent name being inserted into the cache.
											(must be a valid name if the object is a datawindow,
											this function doesn't check it though)
							as_proplabel: the property identifier being saved to the cache.
							as_propValue: the value corresponding to as_propLabel being inserted into the cache.
							as_className: the name of the class being inserted into the cache.
							as_type:			the typ of the object being inserted into the cache.

RETURNS:			returns 1 for now
	
DESCRIPTION: This function saves the property to ids_settings as a child of an abstract
				 save of the parent.  Parent name and instance number are not null, but user 
				 name is.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	8-19-2005
	

***************************************************************************************/
Long 		ll_newRow
Long		ll_max
Long		ll_index
Int 		li_return
String 	ls_findString

	ll_max = ids_settings.rowCount()

	ls_findString = "dynamicproperty_objectname = '" +as_objectName + "'" &
					  + " AND isNull( dynamicproperty_username )" &
					  + " AND isNULL( dynamicproperty_instance )" &
					  + " AND isNULL( dynamicproperty_containername )" &
					  + " AND dynamicproperty_propertylabel = '" + as_Label + "'" &
					  + " AND dynamicproperty_propertyvalue = '" + as_Value + "'" 
	
	//result of  find				  
	ll_index = ids_settings.find( ls_findString, 1, ll_max )		

//**modified 11-8-05 so that x and y are always saved even if they are the same as the abstract
//definition, this is so that when someone saves a new object as part of settings, it becomes part
//of window definition.
//**modified again to be sure that prefilter is always added.  This is ok, because it can never
//be updated from ids_settings cache.
   IF ll_index = 0 OR as_label = "X" OR as_label = "Y" OR as_label = "prefilter" THEN

		IF as_label = "prefilter" THEN
			ls_findString = "dynamicproperty_objectname = '" +as_objectName + "'" &
					  + " AND isNull( dynamicproperty_username )" &
					  + " AND dynamicproperty_instance ="+string( al_instance ) &
					  + " AND dynamicproperty_containername ='"+ as_parentName+"'" &
					  + " AND dynamicproperty_propertylabel = '" + as_Label + "'" &
					  + " AND dynamicproperty_propertyvalue = '" + as_Value + "'" 

			ll_index = ids_settings.find( ls_findString, 1, ll_max )
			
		END IF
		
		IF ll_index = 0 OR as_label = "X" OR as_label = "Y" THEN
			ll_newRow = ids_settings.insertRow(0)
			
			
			//this version saves the instance and new parent name
			ids_settings.setItem( ll_newRow , "dynamicproperty_objectname", as_objectName )
			ids_settings.setItem( ll_newRow , "dynamicproperty_propertylabel", as_label )
			ids_settings.setItem( ll_newRow , "dynamicproperty_propertyvalue", as_value )
			ids_settings.setItem( ll_newRow , "dynamicobject_classname", as_className )
			ids_settings.setItem( ll_newRow , "dynamicobject_type", as_type	)
			ids_settings.setItem( ll_newRow , "dynamicproperty_instance", al_instance)
			ids_settings.setItem( ll_newRow , "dynamicproperty_containername", as_parentName)
		END IF
	END IF
	
	li_return = 1
	
return li_return
end function

public function integer of_savetomode (integer ai_mode, string as_objname, long al_instance, string as_parent, string as_label, string as_value, string as_class, string as_type);/***************************************************************************************
NAME: 		of_saveToMode	

ACCESS:		Public	
		
ARGUMENTS: 		
							ai_mode: 1 save as user object
										2 save as abstract property
										3 save as child abstract

RETURNS:			integer 1 if a valid mode with valid arguments is passed
								-1 otherwise.
	
DESCRIPTION:	This function takes all the information about an object that is necessary to save
					its properties, and forwards the necessary information based on the mode sent in.
					If ai_mode is 1 then it is saving the property as an instance and forwards the call
					to of_saveProperty.
					If ai_mode is 2 then it is saving the property as an abstract, and forwards the call
					to of_savePropAsDef.
					If ai_mode is 3 then it is saving the property as an abstract child property.
					
					If in mode 1, and saving a datawindow, and the parent name isn't valid, then it is an 
					error, and the property will not be saved.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 8-24-05
	

***************************************************************************************/

Int 	li_return

IF ai_mode = 1 THEN
	
	//datawindows saved in mode one must have a valid parent name. Otherwise it cannot
	//be saved.
	IF as_type = "datawindow" THEN
		IF NOT isNULL( as_parent )  AND trim(as_Parent) <> "" THEN
			li_return = 1
		ELSE
			li_return = -1
		END IF
	ELSE
		li_return = 1
		
	END IF
	
	//save property as an instance, with parent name, user id, and instance numbers all valid
	//(main windows with no parents do not need to have a parent name)
	IF li_return = 1 THEN
		this.of_saveProperty( as_objName, al_instance, as_parent, as_label, as_value, as_class, as_type)
	END IF
	
ELSEIF ai_mode = 2 THEN
	//save property as an abstract definition with user name, instance, and parent all set to null.
	this.of_savePropAsDef( as_objName, as_label, as_value, as_class, as_type)
	li_return = 1
	
ELSEIF ai_mode = 3 THEN
	//save property as an abstract instance of the parent, name is null, but parent and instance are valid.
	this.of_savePropAsChildDef( as_objName, al_instance, as_parent, as_label, as_value, as_class, as_type)	
	li_return = 1
	
ELSE

	li_return = -1
END IF

return li_return
end function

public function integer of_loadlinkages (window aw_window);/***************************************************************************************
NAME: 			of_loadLinkages

ACCESS:			public

		
ARGUMENTS: 		
							aw_window:	the window that is going to have is control looked through
											and children windows recursed on, to try to set up linkages
											between datawindows on them.


RETURNS:		 Im not sure that the value means anything right now
	
DESCRIPTION: 	The following loads linkages from a cache that does a retrieval looking for
					any possible linkages for objects that have already been created on the window.
					Right now the object names are loaded by of_create as they are created on the window.
					
					The function looks for possible linkages for all datawindows in the control.
					Then it tries to find corresponding details on the same window. If it finds them,
					then it attempts to set up the linkage, and then tries to find the arguments for 
					that kind of link.  It then sets up those arguments.
					
					After setting up linkages for all objects on aw_window, it then tries to set up
					all possible linkages on child windows if it has them. This is done by recursion.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 8-31-2005
	

***************************************************************************************/
Long	ll_linkageRowCount
Long	ll_argsRowCount
Long	ll_findIndex
Long	ll_detailIndex
Long	ll_linkId
Long	ll_ArgIndex

Int 	li_max
Int	li_index
Int	li_return
Int	li_instance
Int	li_detailInstance

String	ls_dwName
String	ls_parentName
String 	ls_findString
String	ls_findDetail
String	ls_findStyle
String	ls_findArgs
String	ls_detailName
String	ls_detailParent
String	ls_linkStyle
String	ls_MasterColumn
String	ls_DetailColumn

u_dw 		ldw_dataWindow
u_dw		ldw_detailDw

Window	lwa_childWindows[]

//initialize caches, the first one contains details of linkages between 
//u_dw's on the window passed in
IF NOT IsValid( ids_linkages )THEN
	ids_linkages = create DataStore
	ids_linkages.DataObject = "d_dynamiclinkages"
	ids_linkages.SetTransObject( SQLCA )	
END IF

//this cache contains information about all of the arguments for any links possible
//for u_dw's on the window.
IF NOT IsValid( ids_linkArgs )THEN
	ids_linkArgs = create DataStore
	ids_linkArgs.DataObject = "d_dynamiclinkargs"
	ids_linkArgs.SetTransObject( SQLCA )	
END IF


COMMIT;

//sets up both data stores
//isa_ObjectNames is an array loaded with all of the names of objects as 
//they are initialized 
ll_linkageRowCount = ids_linkages.retrieve( isa_ObjectNames )
ll_argsRowCount = ids_linkArgs.retrieve( isa_ObjectNames )
COMMIT;
li_max = upperBound(aw_window.control)

//If there is at least one linkage possible given the object names, 
//attempt to set up all of them.
IF ll_linkageRowCount > 0 AND NOT isNULL(aw_window) THEN
	
	//loop through all window controls to find datawindows, if they are dynamic,
	//get their name and see if it has any linkages. Try to find the corresponding
	//detail if such a linkage is a possibility.  If we find the specified detail
	// to go with the master, then Set all those linkages.
	//Once a linkage is set up, attempt to set the arguments for the linkage.
	for li_index = 1 to li_max
		IF aw_window.control[li_index].triggerEvent("ue_hasIds") = 1 AND typeOf(aw_window.control[li_index]) = datawindow! AND aw_window.control[li_index].triggerEvent("ue_isTab") <> 1 THEN
			ldw_dataWindow = aw_window.control[li_index]


			//all the info for the datawindow
			ls_dwName = ldw_dataWindow.dynamic of_getObjName()
			ls_parentName = ldw_dataWindow.dynamic of_getParentName()
			li_instance = ldw_dataWindow.dynamic of_getObjInstance()
			
			
			ls_findString = ""
			ll_findIndex = 1
			
			DO WHILE ll_findIndex > 0
				
				//find a linkage in the cache that corresponds to ldw_datawindow found on the window.
				//If success, look for detail object in the window control, and set up the linkages
				//between the two datawindows.
				ls_findString = "objectname = '"+ls_dwName +"'" &
									+" AND containername = '"+ ls_parentName+"'" &
									+" AND objectinstance = "+string(li_instance)
				
				ll_findIndex = ids_linkages.find(ls_findString, ll_findIndex, ll_linkageRowCount)
				
				//if we found a linkage that matches ldw_dataWindow, it is a master.
				//Now try to find its detail
				IF ll_findIndex > 0 THEN
					
				
					//all the detail data for the detail on the window that we need to find
					ls_detailName = ids_linkages.getItemString(ll_findIndex, "detailName")
					ls_detailParent = ids_linkages.getItemString(ll_findIndex, "detailContainer")
					li_detailInstance = ids_linkages.getItemNumber(ll_findIndex, "detailInstance")
					ll_linkId	= ids_linkages.getItemNumber(ll_findIndex, "linkid")
					
					//loop through control of the window to find the correct detail.
					for ll_detailINdex = 1 to li_max
						
						IF aw_window.control[ll_detailIndex].triggerEvent("ue_hasIds") = 1 AND typeOf(aw_window.control[li_index]) = datawindow! AND aw_window.control[ll_detailIndex].triggerEvent("ue_isTab") <> 1 THEN

							
							ldw_detailDw = aw_window.control[ll_detailIndex]
							
							//if all this is true then we found the master and the detail objects
							//now set up linkages							
							IF ls_detailName = ldw_detailDw.dynamic of_getObjName() &
								AND	ls_detailParent = ldw_detailDw.dynamic of_getParentName() &
								AND 	li_detailInstance = ldw_detailDw.dynamic of_getObjInstance() THEN
									
									//find the first occurence of the link in the argrument cache, 
									//find out the link style, and set it.
									//Get all the args if any and set them.
									ll_ArgIndex = 1									//initialize to a valid index
									ls_findStyle = "dynamiclinks_linkid = "+string(ll_linkId)
									
									ll_ArgIndex = ids_linkArgs.find(ls_findStyle, ll_ArgIndex, ll_argsRowCount)
									
									
									//if we found it, then set the linkages between the two objects with the correct
									//style.
									IF ll_argIndex > 0 THEN		
										ls_linkStyle = ids_linkArgs.getItemString(ll_argIndex, "dynamiclinks_style")
												
										IF NOT isNull(ls_linkStyle) THEN								
											IF ls_linkStyle = "retrieve" THEN
												//turn on linkage service, and link master to detail
												ldw_dataWindow.of_setLinkage(true)
												ldw_detailDw.of_setLinkage(true)
												ldw_detailDw.inv_linkage.of_setMaster( ldw_dataWindow, ll_linkId )
												ldw_detailDw.inv_linkage.of_setStyle(n_cst_dwsrv_Linkage.RETRIEVE)
												li_return = 1
												
											ELSEIF ls_linkStyle = "scroll" THEN
												//turn on linkage service, and link master to detail
												ldw_dataWindow.of_setLinkage(true)
												ldw_detailDw.of_setLinkage(true)
												ldw_detailDw.inv_linkage.of_setMaster( ldw_dataWindow, ll_linkId )
												ldw_detailDw.inv_linkage.of_setStyle(n_cst_dwsrv_Linkage.SCROLL)
												li_return = 1
												
												
											ELSEIF ls_linkStyle = "filter" THEN
												//turn on linkage service, and link master to detail
												ldw_dataWindow.of_setLinkage(true)
												ldw_detailDw.of_setLinkage(true)
												ldw_detailDw.inv_linkage.of_setMaster( ldw_dataWindow, ll_linkId )
												ldw_detailDw.inv_linkage.of_setStyle(n_cst_dwsrv_Linkage.FILTER)
												li_return = 1
												
											ELSE
												//invalid style
												li_return = -1
												
											END IF
											
										Else
											//invalid style
											li_return  = -1
										END IF
									ELSE
										//didn't find style
										li_return = -1
									END IF
									
									//if the linkage was set up with the right style, look for arguments
									//and set them in the correct order.
									IF li_return = 1 THEN
						
										//needed argument information if there are arguments
										//ls_MasterColumn = ids_linkArgs.getItemString(ll_argIndex, "dynamicdetailarguments_mastercolumn")
										//ls_detailColumn = ids_linkArgs.getItemString(ll_argIndex, "dynamicdetailarguments_detailColumn")	
										
										//if at least one argument has to be set, then there could be more, 
										//set the argument we have, then look for more and set those.
										IF not ISNULL(ls_MasterColumn) AND not ISNULL(ls_detailColumn) THEN
											//ldw_detailDw.inv_linkage.of_setArguments(ls_MasterColumn, ls_detailColumn)
													
											//finds the next argument matching link id
									
											DO WHILE ll_ArgIndex > 0 
	
												IF ll_argINdex > 0 THEN
													ls_MasterColumn = ids_linkArgs.getItemString(ll_argIndex, "dynamicdetailarguments_masterColumn")
													ls_detailColumn = ids_linkArgs.getItemString(ll_argIndex, "dynamicdetailarguments_detailColumn")	
													ldw_detailDw.inv_linkage.of_setArguments(ls_MasterColumn, ls_detailColumn)
					
												END IF
												
												ll_argIndex ++
												IF ll_argIndex > ll_argsRowCount THEN 
													ll_argIndex = 0
												END IF
												
												IF ll_argIndex > 0 THEN
													ll_ArgIndex = ids_linkArgs.find(ls_findStyle, ll_ArgIndex, ll_argsRowCount)
												END IF
											LOOP
										END IF
									END IF
							ELSE
								//not found 
							END IF
							
						END IF
						
					next
				END IF
				
				
				//prevent infinite loop
				IF ll_findIndex > 0 THEN
					ll_findIndex ++
				END IF
	
				//after done processing the object, drop out of this loop by 
				//setting ll_findIndex = 0
				IF ll_findIndex > ll_linkageRowCount THEN
					ll_findIndex = 0
				END IF
				
			LOOP
		
		END IF
	next
	
	//if the window passed in has children windows, then set up all possible linkages
	//between datawindows on those windows.
	IF aw_window.triggerEvent("ue_hasChildrenWindows") = 1 THEN
		aw_window.dynamic of_getChildrenWindows(lwa_childWindows)
		li_max = upperBound(lwa_childWindows)
		
		//loop through all children windows and recurse on them to set up linkages on children
		//windows
		for li_index = 1 to li_max
			IF Not ISNULL(lwa_childWindows[li_index]) THEN
				this.of_loadLinkages(lwa_childWindows[li_index])
			END IF
		next

	END IF
	

	li_return = 1
ELSE 
	li_return = ll_linkageRowCount
END IF


return li_return
end function

public function integer of_loadmouseovers (window aw_window);/***************************************************************************************
NAME: 			of_loadMouseOvers

ACCESS:			public
		
ARGUMENTS: 		
							aw_window:	the window who's controls we loop through to try and 
											set up mouseovers on the datawindows.
											

RETURNS:			this doesn't really mean much since some controls may succeed while
					others it may not, the only return will be that of the last control
					it looks at.
					1 if it succeeds
					-1 may imply the argument passed in wasn't valid.
	
DESCRIPTION:	This function initializes a cache of mouseovers from an array of object names
					that is generated when of_create is called.
					
					This function loops through the passed in window's control array and attempts
					to set all mouse overs appropriate to datawindows that are listed in the cache.
					
					This function assumes that linkages have already been set up.
					
					This function calls itself recursively on any children windows of the window
					being passed in.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :	By Dan 9-01-2005
	

***************************************************************************************/
int 	li_return		
int	li_max
int 	li_index
int	li_index2
int	li_instance
int	li_max2

long	ll_rowCount
long	ll_findIndex
long	ll_linkId

String	ls_dwName
String	ls_findString
String	ls_response
String	ls_respType
String	ls_textExpr
string	ls_colName
String	ls_detailName

u_dw		ldw_dataWindow
u_dw		ldwa_details[]
Window 	lwa_children[]
		
	int li_result
//initialize the cache.  The retrieve that the data object does
//is based on an array of object names initialized when of_create 
//was called.
IF NOT IsValid( ids_MouseOvers )THEN
	ids_MouseOvers = create DataStore
	ids_MouseOvers.DataObject = "d_dynamicmouseover"
	ids_MouseOvers.SetTransObject( SQLCA )	
END IF
ll_rowCount = ids_mouseOvers.retrieve( isa_ObjectNames )

COMMIT;


//if the window passed in is valid and there are potential mouseovers to set up, 
//then proceed otherwise return -1


IF not ISNULL(aw_window) AND ll_rowCount > 0 THEN
	
	li_max = upperBound(aw_window.control)
	//loop through aw_windows control array to find dynamic datawindows, and try to set up 
	//all the mouseovers on those windows.
	
	for li_index = 1 to li_max
		
		IF aw_window.control[li_index].triggerEvent("ue_hasIds") = 1 AND typeOf(aw_window.control[li_index]) = datawindow! THEN
			ldw_dataWindow = aw_window.control[li_index]
			ldw_dataWindow.setRedraw( true )
			
			//all the info for the datawindow
			ls_dwName = ldw_dataWindow.of_getObjName()
			ll_findIndex = 1
			
			//look for all mouseovers defined for the current datawindow in the cache,
			//and set them   if we find them.
			
			DO WHILE ll_findIndex > 0
				ls_findString = "mouse_objectname = '" + ls_dwName + "'"
				
				ll_findIndex = ids_MouseOvers.find(ls_findString, ll_findIndex, ll_rowCount)
				
				
				//found one now set it up
				IF ll_findIndex > 0 THEN
					IF ldw_dataWindow.of_setMouseOver( TRUE ) = 1 OR IsValid (ldw_dataWindow.inv_MouseOver) THEN
						ldw_dataWindow.inv_mouseOver.of_setParentWindow( aw_window )
						
						//get the response type and set it
						ls_response = ids_MouseOvers.getItemString(ll_findIndex, "response" )
						ls_respType = ids_MouseOvers.getItemString(ll_findIndex, "responsetype")
						
						//rest of the needed information
						//and set the row mouseover.
						IF ls_response = "row" THEN
							
							//if the response is text, then get the text expression, and  set the mouseover
							//to a row/text response.
							IF ls_respType = "text" THEN
								ls_textExpr = ids_MouseOvers.getItemString( ll_findIndex, "textexrpression" )
					
								IF NOT isNULL( ls_textExpr ) THEN
									ldw_dataWindow.inv_mouseOver.of_mouseOverOn( )
									ldw_dataWindow.inv_mouseOver.of_setTextResponse( "[row]", ls_textExpr)
							
									li_return = 1
								ELSE
									//invalid expression
									li_return = -1
								END IF
								
								
							//set the mouseover as a row and datawindow response
							ELSEIF ls_respType = "dw" THEN
								ls_colName = ids_MouseOvers.getItemString( ll_findIndex, "columnname" )
								ls_detailName = ids_MouseOvers.getItemString( ll_findIndex, "dynamiclinks_detailname" )
								ll_linkId = ids_MouseOvers.getItemNumber( ll_findIndex, "links_linkid" )
								
								
								//if the information is valid, look through the current dw's details, and find 
								//the correct linkid. Once that link id is found, set up the mouseover dw response.
								IF NOT isNULL(ls_detailName ) AND NOT isNULL(ll_linkId) AND isValid( ldw_dataWindow.inv_linkage ) THEN
												
									ldw_dataWindow.inv_linkage.of_getDetails(ldwa_details)
									li_max2 = upperBound( ldwa_details )
									
									
									for li_index2 = 1 to li_max2
										
										IF ll_linkID = ldwa_details[li_index2].inv_linkage.of_getLinkId()  THEN
											ldw_dataWindow.inv_mouseOver.of_mouseOverOn( )
											ldw_dataWindow.inv_mouseOver.of_setDwResponse( "[row]", ldwa_details[li_index2])
											ldwa_details[li_index2].visible = false
									 	END IF
									next
										
										
									li_return = 1
									
								ELSE
									li_return = -1
								END IF
								
							ELSE
								//invalid response type
								li_return = -1
							END IF
						
						//set up the column response
						ELSEIF ls_response = "col" THEN
							
							//set up the col/text response after getting the text expression
							IF ls_respType = "text" THEN
								ls_textExpr = ids_MouseOvers.getItemString( ll_findIndex, "textexrpression" )
								ls_colName = ids_MouseOvers.getItemString( ll_findIndex, "columnname" )
								
								IF NOT isNULL( ls_textExpr ) THEN
									ldw_dataWindow.inv_mouseOver.of_mouseOverOn( )
									ldw_dataWindow.inv_mouseOver.of_setTextResponse( ls_colName, ls_textExpr)
							
									li_return = 1
								ELSE
									//invalid expression
									li_return = -1
								END IF
									
							//set up the col/dw response		
							ELSEIF ls_respType = "dw" THEN
								ls_colName = ids_MouseOvers.getItemString( ll_findIndex, "columnname" )
								ls_detailName = ids_MouseOvers.getItemString( ll_findIndex, "dynamiclinks_detailname" )
								ll_linkId = ids_MouseOvers.getItemNumber( ll_findIndex, "links_linkid" )
						
								//get the details of the current dw and look for the correct link id.
								//Once its found, set up the dw mouseover.
								IF NOT isNULL( ls_colName ) AND NOT isNULL(ls_detailName ) AND NOT isNULL(ll_linkId) AND isValid( ldw_dataWindow.inv_linkage ) THEN
									
									
									ldw_dataWindow.inv_linkage.of_getDetails(ldwa_details)
									li_max2 = upperBound( ldwa_details )
									
									for li_index2 = 1 to li_max2
										IF ll_linkID = ldwa_details[li_index2].inv_linkage.of_getLinkId()  THEN
											ldw_dataWindow.inv_mouseOver.of_mouseOverOn( )
											ldw_dataWindow.inv_mouseOver.of_setDwResponse( ls_colName, ldwa_details[li_index2])
											ldwa_details[li_index2].visible = false
										
										END IF
									next
									
									li_return  = 1
										
								END IF
								
							ELSE
								//invalid response type
								li_return = -1
							END IF
							
						ELSE
							//invalid response type
							li_return = -1
						END IF
						
					END IF
				END IF
				
				
				//prevent infinite loop
				IF ll_findIndex > 0 THEN
					ll_findIndex ++
				END IF
	
				//after done processing the object, drop out of this loop by 
				//setting ll_findIndex = 0
				IF ll_findIndex > ll_RowCount THEN
					ll_findIndex = 0
				END IF
				
				
			LOOP
			
		END IF
		
	next
	
	
	// if the window passed in has children windows, make the recursive call on 
	// each of them to try and set up linkages from within those tables.
	IF aw_window.triggerEvent( "ue_hasChildrenWindows" ) = 1 THEN
		aw_window.dynamic of_getChildrenWindows(lwa_children)
		
		li_max = upperBound(lwa_children)
		for li_index = 1 to li_max
			IF NOT isNULL( lwa_children[li_index] ) THEN
				this.of_loadMouseOvers( lwa_children[li_index] )
				
			END IF
			
		next
		
	END IF
	
ELSE
	//aw_window isn't valid or there are no mouseovers to load
	li_return  = -1
END IF

return li_return
end function

public function integer of_savelinkages (window aw_window);/***************************************************************************************
NAME: 			of_saveLinkages

ACCESS:			public	
		
ARGUMENTS: 		
							aw_window:	the window whos controls will be looped through.

RETURNS:			1 if succeeds, -1 if error
	
DESCRIPTION:	The following function loops through all the  controls on the window passed 
					in and saves all of the linkage information for those instances.  The only 
					cache it updates is the ids_linkages cash.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 	 9-7-2005
	

**************************************************

*************************************/
	
	
	
int 		li_max
int		li_max2
int 		li_index
int		li_index2
int		li_style
int 		li_return

String	ls_parentName
String	ls_objName
String	ls_detName
String	ls_findString
String	ls_findArg
String	ls_masterArg
String	ls_detArg
String	ls_style
String	ls_find

long		ll_currentMax
long		ll_instance
long		ll_detInstance
long		ll_linkId
long		ll_findIndex
long		ll_findMax
long		ll_newRow
long		ll_argIndex
long		ll_argMax

u_dw		ldw_dataWindow
u_dw		ldwa_details[]
u_dw		ldwa_invalid[]

Window	lwa_childWindows[]
n_cst_linkageAttrib	inv_attributes

li_return = 1


LONG	test

//IF the window passed in is valid and is of a type that has a name then we can continue, otherwise
//nothing can be done

IF isValid( aw_window ) THEN
	IF NOT isNULL( aw_window ) AND aw_window.triggerEvent( "ue_hasIds" ) = 1 THEN
	
		li_max = upperbound( aw_window.control )	
	
	
		//for all the datawindows that are dynamic u_dw's in the control of the window, get any linkages that they have
		//and save them to the cache.
		FOR li_index = 1 TO li_max
			
			IF isValid( aw_window.control[li_index] ) THEN
				IF typeOf( aw_window.control[li_index] ) = datawindow! AND aw_window.control[li_index].triggerEvent( "ue_HasIds") = 1 THEN
					ldw_dataWindow = aw_window.control[li_index]
					
					ls_parentName = aw_window.dynamic of_getObjName( )
					ls_objName = ldw_dataWindow.of_getObjName( )
					ll_instance = ldw_dataWindow.of_getObjInstance( )
					
					IF isValid( ldw_dataWindow.inv_linkage ) THEN
						ldw_dataWindow.inv_linkage.of_getdetails( ldwa_details )
					ELSE
						ldwa_details = ldwa_invalid
					END IF
					
				
					//if all the data recieved is valid for the dw we are checking,
					//remove any instances of this object from the cache so that the new linkages can be saved.
					IF NOT isNUll( ls_parentName ) AND NOT isNull( ls_objName ) AND NOT isNULL( ll_instance ) THEN
					
						ll_findIndex = 1
					
						//clean up all old linkages of this object from the cache
						ls_findString = " objectname = '"+ ls_objName +"'" &
										+ " AND containerName = '"+ ls_parentName + "'" &
										+ " AND objectinstance = " + string( ll_instance )
					
						ll_findMax = ids_linkages.rowCount( )

						ll_findIndex = ids_linkages.find( ls_findString, ll_findIndex, ll_findMax )
							
						DO WHILE ll_findIndex > 0 
			//	Messagebox("find string for delete", ls_findstring)
							ids_linkages.deleteRow( ll_findIndex )
							ll_findMax --
							
							// Prevent endless loop
				
				
							IF ll_findIndex > ll_findMax THEN 
								ll_findIndex = 0
							ELSE
								
								ll_findIndex = ids_linkages.Find( ls_findString, ll_findIndex, ll_findMax )
							END IF
							
						LOOP
						
						li_max2 = upperBound( ldwa_details )
						
						//for all the details that this window has, get the link information, and save it 
						//to the cache
						IF upperBound(ldwa_details) > 0 THEN
							FOR li_index2 = 1 TO li_max2 
								
								IF NOT iSNull( ldwa_details[li_index2] ) AND isValid(ldwa_details[li_index2])THEN
									IF isValid (ldwa_details[li_index2].inv_linkage) THEN
										ls_detName = ldwa_details[li_index2].of_getObjName( )
										ll_detInstance = ldwa_details[li_index2].of_getObjInstance( )
										ll_linkId = ldwa_details[li_index2].inv_linkage.of_getLinkId( )
										li_style =  ldwa_details[li_index2].inv_linkage.of_getStyle( )
										
										
										// li_style is stored as a constant on the u_dw linkage service, in the cache 
										// they are strings.
										IF li_style = 1 THEN
											ls_style = "filter"
										ELSEIF li_style = 2 THEN
											ls_style = "retrieve"
										ELSEIF li_style = 3 THEN
											ls_style = "scroll"
					
										END IF
										
										
										//insert a row and put it in the dynamic linkage cache for the instance on the window.
										IF not ISNULL(ls_detName) AND not ISNULL(ll_detInstance) AND not ISNULL(ll_linkid) THEN
										
											ll_currentMax = ids_linkages.rowcount( )
											
											ls_find = "objectName = '" + ls_objName + "'" &  
														+" AND containerName = '" + ls_parentName + "'" &  
														+" AND objectinstance = " + string(ll_instance)  & 
														+" AND detailName = '" + ls_detName + "'" & 
														+" AND detailContainer = '" + ls_parentName + "'" & 
														+" AND detailInstance = " + string(ll_detInstance) & 
														+" AND linkId = " + string(ll_linkId)   
											
											//Dan added 1-5-2007 to try and put an end to dups in the linkage db.
											//it is still a mystery to me how they got there, and I am unable
											//to reproduce it.  For now this is my last line of defense to make sure
											//it doesn't happen.
											ll_newRow = ids_linkages.find( ls_find, 1, ll_currentMax)
											IF ll_newRow = 0 THEN
												ll_newRow = ids_linkages.insertRow( 0 )
												
												ids_linkages.setItem( ll_newRow, "objectName", ls_objName )
												ids_linkages.setItem( ll_newRow, "containerName", ls_parentName )
												ids_linkages.setItem( ll_newRow, "objectinstance", ll_instance )
												ids_linkages.setItem( ll_newRow, "detailName", ls_detName )
												ids_linkages.setItem( ll_newRow, "detailContainer", ls_parentName )
												ids_linkages.setItem( ll_newRow, "detailInstance", ll_detInstance )
												ids_linkages.setItem( ll_newRow, "linkId", ll_linkId )
												
											END IF
											
											li_return = 1
										ELSE
											li_return = -1
										END IF	
									END IF
								ELSE
									li_return = -1
								END IF
							NEXT
						ELSE
							//there are no valid links to save
							li_return = -1
						END IF
					ELSE
						//some data wasn't valid
						li_return = -1
					END IF
				ELSE
					//not a savable datawindow
					li_return = -1
				END IF
			END IF
		NEXT
		
		
		//recursive call on any children windows
		aw_window.dynamic of_getChildrenWindows( lwa_childWindows )
		li_max = upperBound( lwa_childWindows )
		
		FOR li_index = 1 TO li_max
			this.of_saveLinkages( lwa_childWindows[li_index] )
		NEXT
		
	ELSE
		//parent window is not dynamic, and isn't valid for saving as a container
		li_return = -1
	END IF
END IF
return li_return
end function

public function integer of_saveabsdef (powerobject apo_object, integer ai_savemode, string as_newobjname, string as_description);/***************************************************************************************
NAME: 			of_saveAbsDef

ACCESS:			public
		
ARGUMENTS: 		
					apo_object:  	the object that is having its abstract definition saved.
					
					ai_saveMode:	1 if you want to create a new abstract definition, 0 if you want
										to save over the old abstract definition. 3 does the same as 1 plus
										saves the instance as well.
										
					as_newObjName:	The name of the new object that is being defined abstractly.
							

RETURNS:			1 if apo_object settings were saved successfully to the database.
					-1 if it fails.
	
DESCRIPTION:	This function  works in conjunction with
					an event called on a dynamic object apo_object "ue_savedynamicproperties".  Depending on the
					result this function wants, it sends one of three different modes to the event.
					The modes for the event are specified in the definition of the event for u_dw.
					
					This function has two possible modes specified by ai_saveMode.  
					Mode 1:	In this mode the function attempts to create a new definition for
								a dynamic object by giving it a new unique name as_newObjName.  First it checks
								to see if it is unique, and then adding the abstract definition to the
								dynamicProperty table. It then saves the abstract properties of the instance so 
								it can be created later on.
								
					Mode 0:	In this mode the function is overriding the old abstract definition of the object
								specified by apo_object.  It works similarly to mode 1 in how it makes its changes.
								If mode 0 is called, as_newObjName can be anything, and procession shouldn't
								be affected. I recommend passing in "" when using mode 0 because checks are
								done to make sure names are not empty strings.
								
					Mode 3:	In this mode, it does everything it normally does in mode 1, and it also removes the old 
								instance that was being saved from, and saves the new instance of the new object.
					
					In all modes, if apo_object is a container object with no parent, then it will also save the abstract
					definitions of any children it has, by making similar calls to ue_savedynamicproperties(3) on each of the children.
					
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 8-18-2005
	

***************************************************************************************/

int 			li_return

String 		ls_objectName
String		ls_newObjName
String		ls_parentName
String		ls_findString
String		ls_Type
String		ls_tempname
String		ls_property
String		ls_checkObject

Long			ll_objInstance
Long			ll_index	
Long			ll_randomNumber
Long			ll_max
Long			ll_newRow
Long			ll_checkInstance

Int			li_result
Int			li_index2
Int			li_max2

Window 		lw_window
Window		lwa_childWindows[]
w_master		lw_masterw
u_dw			ldw_dw
u_tab			ltaba_tab[]

li_return = 1
//if ai_saveMode is a valid mode then proceed with processing, otherwise do nothing.
IF ai_saveMode = 0 OR ai_saveMode = 1 OR ai_saveMode = 3 THEN
	ii_saveAbsMode = ai_saveMode			//sets for use in another function
ELSE
	li_return = ci_invalidMode //-3
END IF				

// If saving a new object definition then the new name cannot be null.
IF (ai_saveMode = 1 OR ai_saveMode = 3 )AND isNULL( as_newObjName ) THEN
	li_return = ci_invalidObjName		//-4 stops processing
END IF


//Triggering this event guarantees the following two function calls can be made on the
//object.  Gets the name and instance number of the object being passed in.

IF apo_object.triggerEvent( "ue_hasIds" ) = 1 AND li_return = 1 THEN
	ls_objectName = apo_object.dynamic of_getObjName( )
	ll_objInstance = apo_object.dynamic of_getObjInstance( )
	ls_type = apo_object.dynamic of_getMyType()
	IF isNULL( ls_objectName ) OR trim( ls_objectName ) = "" THEN
		li_return = ci_nonDynamicObject//-5
	END IF
ELSE
	li_return = ci_nonDynamicObject//-5
END IF



// If in mode 1, then we want to save apo_object's definition as a new abstract 
// definition.  To do this we first have to make sure that the new name for the object
// is unique, then we need to save it into the dynamic Object table of the database.

IF (ai_saveMode = 1 OR ai_saveMode = 3 ) AND li_return = 1 AND trim(as_newObjName) <> "" AND NOT isNull(as_newObjName) THEN
	ls_findString = "name = '"+ as_newObjName + "'"
	
	ll_max = ids_dynamicObjects.rowCount()
	
	ll_index = ids_dynamicObjects.find( ls_findString, 1, ll_max)
	
	
	//add the object to d_dynamicObjects if it isn't already there
	IF ll_index = 0 THEN
		ls_newObjName = as_newObjName
		ll_newRow = ids_dynamicObjects.insertRow(0)
		ids_dynamicObjects.setItem( ll_newRow , "name", as_newObjName )
		
		IF ls_type = "window" THEN
			ids_dynamicObjects.setItem( ll_newRow , "classname", apo_object.dynamic of_getMyClass() )
		ELSE
			ids_dynamicObjects.setItem( ll_newRow , "classname", apo_object.className() )
		END IF
		ids_dynamicObjects.setItem( ll_newRow , "type", ls_type	)
		
		IF not isNULL(as_description) THEN
			ids_dynamicObjects.setItem( ll_newRow , "description", as_description	)
		END IF
		
		li_return = ids_dynamicObjects.update()
		IF li_return = 1 THEN
			
			COMMIT;
			ll_max = 0
			ls_findString =""				//successfully added new object to the database
		ELSE
			ROLLBACK;
			li_return = ci_failedupdateDynObjTable //-1
		END IF
	END IF
END IF
//---



// Finally we will want to save the properties of the newly created object to the 
// cache.  Once the abstract properties are saved, the instance of the object is saved as well.

IF ( ai_saveMode = 1 OR ai_saveMode = 3 ) AND li_return = 1 THEN
	
	//if the name passed in is unique then set apo_object's name to the new name.
		
	//changes the name of the object being saved to the new name
	apo_object.dynamic EVENT ue_setIdentifiers( ls_newObjName, ll_objInstance )
	ls_parentName = apo_object.dynamic of_getParentName()
	ls_tempName = apo_object.dynamic of_getObjName()
	IF of_isDeletableObject( ls_tempName ) THEN
		this.of_addToDeleteCache( ls_tempName, ls_parentName, ll_objInstance )
		
	END IF
	
	//the object can only be saved as abstract if this event succeeds
	//the saving continues in the function called by the event triggered.
	//This logic will attempt to insert the new object name into the dynamicObject table 
	//on the first of_SetPropAsDef attempt, and so that name will be in the table by by the 
	//time the event finishes.
	IF apo_object.triggerEvent( "ue_savedynamicproperties" ) = 1 AND li_return = 1 THEN
		apo_object.dynamic EVENT ue_savedynamicproperties( 2 /* saves apo_object as abstract to the cache */)

	ELSE
		li_return  = ci_nonDynamicObject	//error
	END IF
		
	//If we are in saveMode 3, then the user has opted to save the instance as well as 
	//the abstract definition.	This means that the previous user instance has to be removed from the parent
	//window, if the object is not a main window itself. If it is a main window, then the instance doesn't
	//have to be removed. In both cases we need to save the instance.
		
	//The following trigger event is here to be sure it exists on the object. No processing is
	//done without the correct parms. 
	IF apo_object.triggerEvent( "ue_savedynamicproperties" ) = 1 AND li_return = 1 AND ai_savemode = 3 THEN
		
		//if the object is sitting on a parent, then remove all properties of the user object from the cache.
		IF ls_parentName <> "" AND NOT isNULL( ls_parentName ) THEN
			
			//remove all user properties of the object on its parent
			
			ls_findString = "dynamicproperty_containername = '"+ ls_parentName +"'" &
							+" AND dynamicproperty_objectname = '" + ls_objectName + "'"&
							+" AND dynamicproperty_instance = " + string( ll_objInstance )//&
							
							//11/8-05***removed so that all old properties including the definition ones are removed. **//
							//+" AND dynamicproperty_username = '" +gnv_app.of_getUserId( )+ "'"
		
			ll_index = 1
			ll_max = ids_settings.rowCount( )
		
			DO WHILE ll_index > 0
				
				ll_index = ids_settings.find( ls_findString, ll_index, ll_max )
				IF ll_index <> 0 THEN
						
					//--//modified to get rid of prefilters if the object was removed but not if it wsasn't
					ls_property = ids_settings.getItemString(ll_index, "dynamicproperty_propertylabel")
					IF ls_property <> "prefilter" THEN
						ids_settings.deleteRow( ll_index )		
					ELSE
						ls_checkObject = ids_settings.getItemString(ll_index, "dynamicproperty_objectname")
						ll_checkInstance = ids_settings.getItemNumber(ll_index, "dynamicproperty_instance")
						IF this.of_deleteok( ls_checkObject, ll_checkInstance, ls_objectName ) THEN
							ids_settings.deleteRow( ll_index )
						ELSE
							ll_index++
						END IF
					END IF
					//--
					
				END IF
			LOOP
		END IF
		
		//**modified 11-8-05 to save the instance as part of window def, becuase an object cannot
		//exist on a window without being part of the window definition****//
		apo_object.dynamic EVENT ue_savedynamicproperties( 3 /* saves a child of parent object */)
	END IF
	
	//mode 1 is different from mode 0 at this point because mode 0 requires removal of children objects
	//if apo_object is a container object.  Since mode 1 causes the creation of a brand new object, and isn't
	//changing the old object defintion, there is no need to change the definition of the old object in the cache.
	
	
// In mode 0, we need to save over the old abstract definition of apo_object. 
//	To do this we save all of the abstract properties without changing the name of 
// apo_object.  If the apo_object is a container object, then all of the old children
// objects need to be romoved from the cache. No updates are done to the database in 
// this block of code.

ELSEIF ai_saveMode = 0 AND li_return = 1 THEN
	//the object can only be saved as abstract if this event succeeds
	//the saving continues in the function called by the event triggered.
	//updates to the dynamicObject table are made by the time the event finishes.
	IF apo_object.triggerEvent( "ue_savedynamicproperties" ) = 1  THEN		
		apo_object.dynamic EVENT ue_savedynamicproperties( 2 /* save apo_object as abstract to the cache */)
	ELSE
		li_return  = ci_nonDynamicObject//-1	
	END IF
	
	//if object is a container with no parent, then we need to remove all of its children from 
	//the cache.
	IF ( isNull( ls_parentName ) OR ls_parentName = "" ) AND li_return = 1 THEN
		
		
		// Finds all abstract object instances with apo_object as their containerName,
		// and removes them.
	
		ls_findString = "dynamicproperty_containername = '"+ ls_objectName +"'" &
							+" AND NOT isNull( dynamicproperty_instance ) " &
							//+" AND isNULL( dynamicproperty_username ) "    this is commented because if it is removed from a window definition we want to remove it from all user settings as well
		
		ll_index = 1
		ll_max = ids_settings.rowCount( )
		
		DO WHILE ll_index > 0
			ll_index = ids_settings.find( ls_findString, ll_index, ll_max )
			IF ll_index > 0 THEN
				//--//modified to get rid of prefilters if the object was removed but not if it wsasn't
				ls_property = ids_settings.getItemString(ll_index, "dynamicproperty_propertylabel")
				IF ls_property <> "prefilter" THEN
					ids_settings.deleteRow( ll_index )
					ll_max = ll_max - 1
				ELSE
					ls_checkObject = ids_settings.getItemString(ll_index, "dynamicproperty_objectname")
					ll_checkInstance = ids_settings.getItemNumber(ll_index, "dynamicproperty_instance")
					IF this.of_deleteok( ls_checkObject, ll_checkInstance, ls_objectName ) THEN
						//--prefilter gets moved to delete buffer twice cuasing update failiure
						ids_settings.setItemStatus( ll_index, 0, PRIMARY!, DATAMODIFIED!)
						ids_settings.rowsMove( ll_index, ll_index, PRIMARY!, ids_settings, 1, DELETE! )
						
						ll_max = ll_max - 1
					ELSE
						ll_index++
					END IF
				END IF
				//-------------
				IF ll_index > ll_max THEN
					ll_index = 0
				END IF
			END IF
		LOOP
		
	END IF
	
ELSE
	//li_return = ci_invalidmode  				//invalid mode passed in
END IF


//-----For both modes, if the object passed in is a container, then we want to 
//		 save the objects it contains to the cache, as part of the abstract definition
//		 of the container-object. In other words we want to change the container name field
// 	 for all of the container-object's children, and make them aware of the parents
//		 new name if necessary.


IF li_return = 1 THEN
	
	// Right now the only kind of container object we have is a window object
	IF typeOf( apo_object ) = window! THEN
		lw_window = apo_object
		
		li_max2 = upperBound( lw_window.control )
		
		//---added 11-13-05
		//Since prefilter properties aren't removed, at the same time as other objects from 
		//the cache, we need to check the delete cache to see if they should be, and then
		//delete them.
		IF isValid( ids_delete ) THEN
			ll_max = ids_delete.rowCount()
			FOR ll_index = 1 TO ll_max
				
				ls_objectName = ids_delete.getItemString( ll_index, "dynamicproperty_objectname" )
				ls_parentName = ids_delete.getItemString( ll_index, "dynamicproperty_containername")
				ll_objInstance = ids_delete.getItemNumber( ll_index , "dynamicproperty_instance")
				
				this.of_removeFromCache( ls_objectName, ls_parentName, ll_objInstance, TRUE /*remove from window definition as well*/)
			NEXT
		END IF
		//-------------------------------------------------------------------

		//have child objects save themselves as instances on
		//the new abstract window definition
		
		for li_index2 = 1 to li_max2
		
			//  This event does no processing since the appropriate args. are not passed in.
			//  It is triggered here just to make sure the event exists on the object before
			//  the real call is made.
			IF isValid( lw_window.control[li_index2] ) THEN
				IF lw_window.control[li_index2].triggerEvent( "ue_savedynamicproperties" ) = 1 THEN
					
					// IF we are saving a new container-object definition, then the child object needs to know the 
					// new name of its parent.
					IF ai_saveMode = 1 OR ai_saveMode = 3 THEN
						
						lw_window.control[li_index2].dynamic EVENT ue_setparentname( ls_newObjName )
					END IF
					
					//saves the child object to the cache as an abstract instance of the container-object.
					lw_window.control[li_index2].dynamic EVENT ue_savedynamicproperties( 3 )
				END IF
			END IF
			
		next
	
		//If there are children windows, do the same as we did for the control array above.
		IF lw_window.triggerEvent( "ue_haschildrenwindows" ) = 1 THEN
			lw_window.dynamic of_getchildrenwindows( lwa_childWindows )
			li_max2 = upperBound( lwa_childWindows )
			
			for li_index2 = 1 to li_max2 
				IF isValid( lwa_childWindows[li_index2] ) THEN
					IF lwa_childWindows[li_index2].triggerEvent( "ue_savedynamicproperties" ) = 1 THEN
						
						IF ai_saveMode = 1 OR ai_saveMode = 3 THEN
							lwa_childWindows[li_index2].dynamic EVENT ue_setParentName( ls_newObjName )
							
						END IF
						
						lwa_childWindows[li_index2].dynamic EVENT ue_savedynamicproperties( 3 )
						
					END IF
				END IF
				
			next
			
		END IF
		
	END IF
END IF
//----


//this part was added so that if we are saving a new abstract definition, then
//and if the object is on a tab, then the tab property representing that object
//reference has to be updated as well. 4-11-06 By Dan
IF ai_savemode = 3 AND li_return = 1 THEN
	IF apo_object.TriggerEvent("ue_hasIds") = 1 THEN
		IF typeOf( apo_object ) = window! THEN
			lw_masterw = apo_object
			lw_masterw.of_getTab( ltaba_tab )
		ELSEIF typeOf( apo_object ) = datawindow! THEN
			ldw_dw = apo_object
			ldw_dw.of_getTab(ltaba_tab)
		END IF
		
		this.of_updateTabRefCacheSettings( ls_objectName, as_newObjName, ll_objInstance, ltaba_tab )
	END IF
END IF

//if changes were made  to ids_settings
IF li_return = 1 THEN
	
	//the arguments mean nothing anymore, the function discards all rows that 
	//have the word prefilter in the label.
	this.of_discardprefilter(/*ls_newObjName, ll_objInstance , ls_parentName*/)
	
	li_result = ids_settings.update()
	
   
	//if update was successful, change the database
	IF li_result =  1 THEN
		COMMIT;
		this.of_RemoveUnsavedPrefiltersFromCache()
		IF isValid( ids_delete ) THEN
			
			ids_delete.reset()
		END IF
		
	ELSE
		ROLLBACK;		
		li_return = ci_failedupdateDynPropTable
	END IF
	
END IF


return li_return

end function

public function boolean of_existsuserdef (string as_name, long al_instance, string as_parent);//Returns true if there is a user definition in the cache for this object being described
//Currently the function is not used.
Int	ll_index
Int	ll_max

String 	ls_name
String	ls_parent
String	ls_user
Long		ll_instance

ll_max = ids_settings.rowCount()

//in order for this to return true, there must be at least one property in the 
//settings cache that matches the object, and has a username not equal to null
FOR ll_index = ll_max TO 1 Step -1
	
	ls_Name = ids_settings.getItemString( ll_Index, "dynamicproperty_objectname")
	ll_Instance = ids_settings.getItemNumber( ll_Index, "dynamicproperty_instance")
	ls_parent = ids_settings.getItemString( ll_Index, "dynamicproperty_containername")
	ls_user = ids_settings.getItemString( ll_Index, "dynamicproperty_username")
	
	
	
	IF ls_Name = as_Name AND ll_instance = al_instance THEN
		IF not ISNULL( as_parent ) THEN
			IF as_parent = ls_parent THEN
				IF not IsNULL( ls_user ) THEN
					return true
				END IF
			END IF
		
		ELSE  
			
			IF isNULL( ls_Parent ) THEN
				IF not IsNULL( ls_user ) THEN
					return TRUE
					
				END IF
			END IF
			
		END IF
		
		
	END IF
	
NEXT

RETURN FALSE
end function

public function integer of_addtodeletecache (string as_name, string as_parentname, long ll_instance);//inserts the sent in items into a new row for remembering which items to delete
//before saving user settings.
Long	ll_newRow


IF not IsValid( ids_delete ) THEN
	ids_delete = create Datastore
	ids_delete.dataObject = "d_dynamicPropertyCache"
	
END IF


//IF this.of_isDeletableObject( as_name ) THEN
IF not isNULL( as_parentName ) and as_ParentName <> "" THEN
	ll_newRow = ids_delete.insertRow( 0 )
	
	ids_delete.setItem( ll_newRow, "dynamicproperty_objectname", as_name )
	ids_delete.setItem( ll_newRow, "dynamicproperty_containername", as_parentName )
	ids_delete.setItem( ll_newRow, "dynamicproperty_instance", ll_instance )
END IF
return 1

end function

public function boolean of_isdeletableobject (string as_name);// If the name of the object does not match the name of any of the template names, then
// it is a deletable object, and this returns true.

IF not isNULL( as_name ) THEN
	IF as_name = cs_windowTemplate OR as_name = cs_dataWindowTemplate &
		OR as_name = cs_ShipmentTemplate OR as_name = cs_EquipmentTemplate & 
		OR	as_name = cs_DriverTemplate OR as_name = cs_TabTemplate &
		OR as_name = cs_quickmatchtool OR as_name = cs_adminTool THEN
			return false
	ELSE
			REturn true
		
	END IF
ELSE
	return false
END IF

end function

public function integer of_loadwindowdefinition ();//The following function loads the window definition of whatever window is the current main window.
//Basically all it does is make the user-settings retrieval, and then filters out any user settings,
//and calls of_loadusersettings without any user setttings in the cache.
Long	ll_filterCount

is_loggedInUser = gnv_app.of_getUserId( )			//just for testing 

//any deleted items waiting to be deleted on a save user setting call can be cleared.
IF isValid  ( ids_delete ) THEN
	ids_delete.reset()
		
END IF

IF isValid( ids_settings ) THEN
	destroy ids_settings
END IF

//Fresh cache retrieval.
IF NOT IsValid( ids_settings )THEN
	ids_settings = create DataStore
	ids_settings.DataObject = "d_dynamicpropertycache"
	ids_settings.SetTransObject( SQLCA )	
END IF

//gets a retrieval for whatever user is currently logged in.
ids_settings.retrieve( is_outerWindow , "" , is_loggedInUser )
COMMIT;


//create datastore and set transobject for adding new object names 
//to the dynamicObjects table
IF NOT isValid( ids_dynamicObjects ) THEN
	ids_dynamicObjects = create Datastore
	ids_dynamicObjects.DataObject = "d_dynamicObjects"
	ids_dynamicObjects.SetTransObject( SQLCA )
END IF

//get rid of all user defined properties and move them into the delete buffer in case the user
//wants to get rid of their user settings.

ids_settings.setFilter("isNULL(dynamicproperty_username)")
ids_settings.filter()


ll_filterCount = ids_settings.filteredcount( )
IF ll_filterCount > 0 THEN
	ids_settings.RowsMove ( 1, ll_filterCount , filter!, ids_settings, 1, Delete! )
END IF

//Load the window with only the window definition settings in the cache.
this.of_loadUsersettings( is_outerWindow )

ids_settings.rowsMove(1, ll_filterCount, Delete!, ids_settings, 1, primary!)
ids_settings.sort()
return 1
end function

protected function integer of_create (ref powerobject apo_object, ref powerobject apo_parent, long al_objectindex);/***************************************************************************************
NAME: 	of_create	

ACCESS:	public
		
ARGUMENTS: 		
							apo_object:  reference to the object that is being created.
							apo_parent:	 parent object that apo_object is being created on if it is valid.
							al_objectIndex: the index of ids_settings that describes the object being created.

RETURNS:			Returns 1 if apo_object is createed successfully.
							  -1 otherwise.
	
DESCRIPTION: Creates an object in the reference variable apo_object on apo_parent, sets 
				 its properties if created successfully, and then creates all objects on  
				 the newly created object with a recursive call.
				 
				 This method may need to be modified if it is desirable to open objects up
				 on other objects besides windwos.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	8-10-05
		modified: 11-15-05 TO delete user settings if the object is not created yet.
	

***************************************************************************************/

Window 		lw_parent

String		ls_Type
String 		ls_parentType
String		ls_parentName
String		ls_className
String		ls_objectName
String		ls_findstring
String 		ls_targetObject
String		ls_user

Int			li_return
Int			li_CreateResult

long			ll_index
long			ll_max
long			ll_instance

w_master		lw_window
w_sheet_dynamiccontrol  lw_control

PowerObject				lpo_child
DragObject				ldrg_new

SetPointer(HourGlass!)

ll_max = ids_settings.rowCount()

// if al_objectIndex describes an invalid object entry, than no action
IF al_objectIndex <= 0 THEN
	return -1
END IF

//-------1.a.---------Testing to find out what type parent is-----------------------


//find out what kind of object the user is trying to create
ls_TargetObject = ids_settings.getItemString(al_objectIndex, "dynamicproperty_objectname")
ls_className = ids_settings.getItemString(al_objectIndex, "dynamicobject_classname")
ll_instance = ids_settings.getItemNumber(al_objectIndex, "dynamicproperty_instance")
ls_parentName = ids_settings.getItemString(al_objectIndex, "dynamicproperty_containername")
ls_user = ids_settings.getItemString(al_objectIndex, "dynamicproperty_username")

//if this object has no parent window then it is a main window and needs
//to be opened as a sheet?  complications could come up, since the help file
//says that sheets cannot be parents to other windows

//if apo_parent isn't valid, then that means we are opening up an outermost
//window of the application.  The parent of this window is actually the frame of the App.
IF NOT isValid(apo_parent) THEN
	opensheet(lw_window, "w_sheet_dynamiccontrol" /*"w_testchild""w_sheet_"*/, gnv_App.of_GetFrame())
	apo_object = lw_window
	ls_Type = "window"
	li_return =  1		 

 	lw_window.parentwindow().setredraw(true)
//apo_parent is valid, we are opening an object up on it, the object we are opening
//is described by al_objectIndex
ELSE 	
	//Sets variables so that we know which open calls to make in part 2.
	//for now the only thing we can open an object up on is another window.
	IF apo_Parent.TypeOf ( ) = Window! THEN
		lw_Parent = apo_Parent
		ls_parentType = "window"
		li_return = 1
		setNull(apo_Object) 				//if this doesn't get set to null, no userObjects will be
												//created ? For some reason it isn't already null when called.
		
	ELSE
		ls_parentType = "unknown"
		//if there are other types of parents that can have something opened up
		//on it, this is where you would assign apo_parent to whatever actual type it
		//is so that apropriate function calls can be made to open up apo_Object
		//on  it
		li_return = -1
	END IF
END IF

//-----2.------Opening apo_object on the apo_parent-------------------------------

//if parent is window, it will open apo_object using the window
//function openUserObject() or open(), depending on they type of the object.
IF li_return = 1 THEN
	
	CHOOSE CASE ls_parentType
			
	CASE "window"
	
		// apo_object eneds to be opened.
		IF NOT isValid(apo_object) OR isNull(apo_object) THEN
			// *** set the object variable depending on what as_type is    *************
			// *** this piece will have to be expanded if other types end up having  ***
			// *** dynamic user settings.	 
			
			
			//if ls_type is window, then we need to open apo_object using open(), passing
			//the object, the type of window it will be, and the parent it will be created on.
			IF ls_className = "w_master"	THEN
				IF isValid(lw_parent) AND NOT isNull(lw_parent) THEN 
					//-------------
					// If object isn't created and the property is not a user property
					// create it.
					IF isNULL( ls_user ) THEN
						IF lw_parent.classname( ) <> "w_child" THEN
							li_return = open(lw_window, "w_Child",lw_parent)
						ELSE
							li_return = -1
						END IF
						//if success opening child, add the child reference to the parent object
						IF li_return = 1 THEN
							lw_parent.dynamic of_addChildWindow(lw_window)
						END IF
						apo_object = lw_Window
					
					ELSE		//object not created, and property is a user property, 
								//we delete the property because the object no longer exists
								//on the window definition.  It is deleted from the database on 
								//the next update of Ids_settings.
						ids_settings.deleteRow( al_objectIndex )
						li_return = -1
					END IF
					//--------------------
				
				//if the parent isn't valid at this point, then an error has occured.
				ELSE
					li_return = -1
					
				END IF
				
			//the object we are opening is a userObject, so we need to call openUserObject() to open
			//the object on the parent window.
			ELSE
	
	
				//if parent is valid, we open an object of type ls_className into ldrg_new, a dragObject.
				//This way, we will beable to trigger an event later on to try and set the properties
				//on ldrg_new, which will only work if the object implements the ue.
				IF isValid(lw_parent)  THEN
					// If object isn't created and the property is not a user property
					// create it.
					IF isNULL( ls_user ) THEN 
						
						li_return = lw_parent.openUserObject(ldrg_new,ls_className )
						
						this.of_addopeneduserobject( ldrg_new )
						apo_object = ldrg_new			//sets reference variable for use in calling function
					ELSE
								//object not created, and property is a user property, 
								//we delete the property because the object no longer exists
								//on the window definition.  It is deleted from the database on 
								//the next update of Ids_settings.
								
						ids_settings.deleteRow( al_objectIndex )
						li_return = -1
					END IF
				//if parent is not valid at this point an error has occured
				ELSE
					li_return = -1
				END IF
			End IF
			
		ELSE
			//apo_object already exists and is on a parent window
			//it does not fail because the object can still have setProperties called on it
			//or could have objects that need to be created on it.
			li_return = 1
			
		END IF
		
	END CHOOSE
	
END IF


//----------3.------------------------------------------------------------------


//set properties on the newly created object
//recurse on any objects that have their container names = newlyCreatedObjectName
//if the set property event fires, then it is safe to call of_setproperty on the object

IF li_Return = 1 THEN
		//if the dynamic object can set it's property manager service, 
	//then it sets it to this manager.
	IF apo_object.triggerEvent("ue_setdynpropmansrvc") = 1 THEN
		apo_object.dynamic EVENT ue_setDynPropManSrvc(this)
	END IF
	
	IF apo_object.triggerEvent("ue_setParentName") = 1 THEN
		apo_object.dynamic EVENT ue_setParentName(ls_parentName)
	END IF
	
	IF apo_object.triggerEvent("ue_setProperty")  = 1  THEN 
		 This.of_setProperties(apo_object,al_objectIndex)
		
	END IF



//Find all distinct instances whose container is the object we just created.
//Call of_Create for them (recursively.)

//IF li_Return = 1 THEN

	//Initialize variables for first pass through the loop
	ls_ObjectName = ""
	ll_Instance = 0
	ll_Index = 1
	
	DO WHILE ll_Index > 0
		
		ls_FindString = "dynamicproperty_containername = '" +ls_TargetObject+ "' " 
		
		IF ls_ObjectName > "" AND ll_Instance > 0 THEN
			
			ls_FindString += " AND ( dynamicproperty_objectname <> '" + ls_ObjectName + "' OR " +&
				"dynamicproperty_instance <> " + String ( ll_Instance ) + " ) " 
				
	
		END IF
	
		ls_FindString = ls_findstring + " AND NOT isNull(dynamicproperty_instance)"   //We want this at the end bc of the "NOT"
		
	//	IF NOT isNULL( ls_user ) THEN
	//		ls_findString = ls_findString + " AND dynamicproperty_username = '"+ ls_user+"'"
	//	END IF
		
		
		
		ll_Index = ids_settings.find( ls_findString, ll_index, ll_max)
		
		IF ll_Index > 0 THEN
			
			ls_ObjectName = ids_settings.getItemString( ll_Index, "dynamicproperty_objectname")
			ll_Instance = ids_settings.getItemNumber( ll_Index, "dynamicproperty_instance")


			//IF  this.of_existsUserDef( ls_objectName, ll_instance, ls_targetObject ) THEN
				li_CreateResult = This.of_Create ( lpo_child, apo_object, ll_index)
			//END IF
		END IF
		
	LOOP
	
END IF

return li_return
end function

public function integer of_loadtabs (window aw_window);/***************************************************************************************
NAME: 			of_loadTabs

ACCESS:			public
		
ARGUMENTS: 		
							window aw_window: the window you want tabs to be loaded on.

RETURNS:			returns 1 if at least one tab was on the page to load, -1 if it fails
	
DESCRIPTION:	The following loops through the controls on the specified window and tries
					to find properties for those tabs that are for the tab pages.  If it finds them,
					it tries to find the object on the screen that goes with the property, and sets
					up a tab reference to that function.  The tab pages get the name of the object
					that it is referencing.  This makes recursive calls to any windows on it.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 10-18-2005
	

***************************************************************************************/
int 	li_return

Long	ll_index
Long	ll_max
Long	ll_propIndex
Long	ll_propMax
Long	ll_index2
Long	ll_max2
Long	ll_index3

String	ls_objName
String	ls_parent
Long		ll_instance

String	ls_name
String	ls_container
String	ls_label
String	ls_type
String	ls_value
Long		ll_objInstance

String	ls_tabName
Int		li_tabInstance

String	ls_parseName
Int		li_parseInstance
Boolean 	lb_found

U_Tab		lt_tab
u_dw		ldw_dw
PowerObject	lpo_ref
PowerObject lpo_null
w_master lw_coolWindow
w_child	lw_child
Window	lwa_children[]

IF isValid( aw_window ) THEN
	IF aw_window.triggerEvent( "ue_hasIds" ) = 1 THEN
		lw_coolWindow = aw_window
		
		ls_parent = lw_coolWindow.of_getObjName( )
		
		//loop through the windows control to find all tab controls
		
		ll_max = upperBound( lw_coolWindow.control )
		FOR ll_index = 1 TO ll_max
			
			IF isValid( lw_coolWindow.control[ll_index] ) THEN
				
				IF lw_coolWindow.control[ll_index].triggerEvent( "ue_isTab" ) = 1 THEN
					li_return = 1 
					lt_tab =  lw_coolWindow.control[ll_index]
					
					ls_objName = lt_tab.of_getObjName( )
					ll_instance = lt_tab.of_getObjInstance( )
					
					//loop through properties cache to find tab references to the current tab
					
					ll_propMax = ids_settings.rowCount()
					
					FOR ll_propIndex = ll_propMax TO 1 STEP -1
						
						ls_name = ids_settings.getItemString( ll_propIndex, "dynamicproperty_objectname")
						ls_container = ids_settings.getItemString( ll_propIndex, "dynamicproperty_containername")
						ll_objInstance = ids_settings.getItemNumber( ll_propIndex, "dynamicproperty_instance") 
						ls_label = ids_settings.getItemString( ll_propIndex, "dynamicproperty_propertylabel")
						ls_value = ids_settings.getItemString( ll_propIndex, "dynamicproperty_propertyvalue")
						
						//seperates the name from the instance number
						ls_parseName = left( ls_value, pos( ls_value, ":" ) - 1 )	
						li_parseInstance = integer ( right ( ls_value, (len(ls_value) - pos(ls_value, ":")) ) )
										
						
						//if found, loop through the windows controls and children windows to set the tabs
				
					
						IF ls_objName = ls_name AND ls_parent = ls_container AND ll_instance = ll_objInstance AND Match( ls_label, "^[0-9]+$" ) THEN
						
							//ls_type = ids_settings.getItemString( ll_propIndex, "dynamicobject_type")
								lb_found = false
								//look for the object as a child window
								lw_coolWindow.of_getChildrenWindows( lwa_children )
								ll_max2 = upperBound( lwa_children )
								FOR ll_index2 = 1 TO ll_max2
									IF isValid( lwa_children[ll_index2] ) THEN
										lw_child = lwa_children[ll_index2]
										
										ls_tabName = lw_child.of_getObjName( ) 
										li_tabInstance = lw_child.of_getObjInstance( )	
										
										IF ls_parseName = ls_tabName AND li_tabInstance = li_parseInstance THEN
											IF isValid( lt_tab.control [long(ls_label)]) THEN
												lt_tab.control[long(ls_label)].dynamic of_setRefToObject( lw_child )
												lt_tab.control[long(ls_label)].text = lw_child.title//ls_tabName
												lw_child.of_setMyTab( lt_tab )
												
												lb_found = TRUE
												//this logic makes non-selected tabs invisible.
												IF long(ls_label) = 1 THEN
												//	lw_child.visible = true
												ELSE
													lw_child.visible = false
												END IF
											END IF
										END IF
											
										//recursive call	
										this.of_loadTabs( lw_child )	
									END IF
								NEXT
						
								//look for the object as a datawindow
								IF not lb_found THEN

									FOR ll_index2 = 1 TO ll_max
										
										IF isValid( lw_coolWindow.control[ll_index2] ) THEN
											//MessageBox("containername", ls_type)
											IF typeOf( lw_coolWindow.control[ll_index2] ) = dataWindow! AND lw_coolWindow.control[ll_index2].triggerEvent( "ue_isTab") <> 1 THEN
												ldw_dw = lw_coolWindow.control[ll_index2]
												
												ls_tabName = ldw_dw.of_getObjName( ) 
												li_tabInstance = ldw_dw.of_getObjInstance( )
	
										
												IF ls_parseName = ls_tabName AND li_tabInstance = li_parseInstance THEN
													IF isValid( lt_tab.control [long(ls_label)]) THEN
														lt_tab.control[long(ls_label)].dynamic of_setRefToObject( ldw_dw )
														lt_tab.control[long(ls_label)].text = ldw_dw.title//ls_tabName
														ldw_dw.of_setTab( lt_tab )
														
														lb_found = TRUE
														//this logic makes non selected tabs invisible
														IF long(ls_label) = 1 THEN
														//	ldw_dw.visible = true
														ELSE
															ldw_dw.visible = false
														END IF
													END IF
												END IF
											END IF	
										END IF
									NEXT
								END IF
								
						ELSE
							
						END IF
						
					NEXT
					
					//Go through the tabs control, any controls that couldn't find a reference to the object,
					//cose the tab
					FOR ll_index3 = upperBound( lt_tab.control ) TO 1 Step -1	
						IF isValid( lt_tab.control[ll_index3] ) THEN
							lpo_ref = lt_tab.Control[ll_index3].dynamic of_getObject()
							IF NOT isValid( lpo_ref ) THEN
								lt_tab.closeTab( lt_tab.control[ll_index3] )
							ELSE
								lpo_ref = lpo_null
							END IF
						END IF	
					NEXT
				
					lt_tab.selecttab( 1 )		//added 1-4-06, this defaults the tab control to the first tab
				ELSE
					li_return = -1			// no tabs on page
				END IF
			END IF
		NEXT
	ELSE
		li_return = -1		//window is not a w_master
	END IF
ELSE
	li_return = -1			//window not valid
		
END IF
return li_return
end function

public function boolean of_deleteok (string as_objname, long al_instance, string as_parent);//returns true if the specified thing is in the delete datastore
//intended for use on checking whether or not we can delete a prefilter window property.
Long	ll_index
Long	ll_max

Long		ll_instance
String	ls_name
String	ls_parent

IF isValid( ids_delete ) THEN
	ll_max = ids_delete.rowcount()
	FOR ll_index = 1 TO ll_max
		
		ll_instance = ids_delete.getItemNumber( ll_index , "dynamicproperty_instance")
		ls_name	= ids_delete.getItemString( ll_index, "dynamicproperty_objectname" )
		ls_parent = ids_delete.getItemString( ll_index, "dynamicproperty_containername")
		IF as_objName = ls_name AND ll_instance = al_instance AND ls_parent = as_parent THEN
			return TRUE			//we can delete it
		END IF
	NEXT
END IF
RETURN FALSE
end function

public function integer of_removefromcache (string as_objectname, string as_parentname, long al_instance, boolean ab_removefromwindef);//this is intended to remove all matching instances, including instances on the window definition.

Long	ll_max
Long	ll_index
Long	ll_instance
Long	ll_findIndex

String	ls_name
String	ls_parentName
String	ls_userName
String	ls_label

String	ls_findString
ll_max = ids_settings.rowCount()

//delete the object that matches the matching variables from the cache
IF Not isNULL( as_objectName ) AND not ISNULL( al_instance ) THEN

	FOR ll_index = ll_max TO 1 STEP -1
		ls_name = ids_settings.getItemString( ll_index, "dynamicproperty_objectname" )
		ls_parentName = ids_settings.getItemString( ll_index, "dynamicproperty_containername")
		ll_instance = ids_settings.getItemNumber( ll_index , "dynamicproperty_instance")
		ls_userName = ids_settings.getItemString( ll_index, "dynamicproperty_username")
		ls_label = ids_settings.getItemString( ll_index, "dynamicproperty_propertylabel")
		IF ls_Name = "Active IM" THEN
			ls_Name = ls_Name
		END IF
		//normal removal of user settings
		IF ls_name = as_objectName AND ls_parentName = as_parentname AND ll_instance = al_instance THEN
			IF not ISNULL( ls_userName ) THEN
				ids_settings.deleteRow( ll_index )
				
			ELSEIF ab_removeFromWinDef OR ls_label = "prefilter" THEN
				//remove the window definition of the property
				IF ls_label = "prefilter" AND NOT ab_removeFromWinDef THEN
					
					// IF we are removing from the window def becuase the property is prefilter, then
					// we only want to remove it if it doesn't currently window definition properties other
					// than prefilter.
					
					IF ls_name = as_objectName AND ls_parentName = as_parentname AND ll_instance = al_instance THEN
						//we only remove it if there are other properties of the window that we have to remove
						ls_findString = "dynamicproperty_objectname = '" +as_objectName + "'" &
						  + " AND dynamicproperty_instance = "+ string( al_instance ) &
						  + " AND dynamicproperty_containername = '" +as_parentName + "'" &
						  + " AND dynamicproperty_propertylabel <> 'prefilter'" &
						  + " AND isNull( dynamicproperty_username )" 
						
						ll_findIndex = ids_settings.Find( ls_findString, 1, ll_max)
					
						IF ll_findIndex = 0 THEN
							ids_settings.setItemStatus( ll_index, 0, PRIMARY!, DATAMODIFIED!)
							ids_settings.rowsMove( ll_index, ll_index, PRIMARY!, ids_settings, 1, DELETE! )
						END IF
					END IF
				ELSE				//remove because ab_removeFromwindef is on
					IF ls_name = as_objectName AND ls_parentName = as_parentname AND ll_instance = al_instance THEN
					
						ids_settings.deleteRow( ll_index )
					
					END IF
				END IF
			END IF
		END IF
		
	NEXT

END IF
return 1
end function

public function integer of_removeunsavedprefiltersfromcache ();//the following is called when a window is closed and they answer no to save user settings,
//IT prevents new objects from being left on the screen because of an applied property.  If this
//didn't happen than there would be a var in the database for unique prefilter that wouldn't
//be removed, causing the old one to come back.
Long	ll_max
Long	ll_index
Long	ll_instance
Long	ll_findIndex

String	ls_name
String	ls_parentName
//String	ls_userName
String	ls_label
Int		li_result

String	ls_findString

Datastore lds_settings
//delete the object that matches the matching variables from the cache 

IF NOT IsValid( lds_settings )THEN
	lds_settings = create DataStore
	lds_settings.DataObject = "d_dynamicpropertycache"
	lds_settings.SetTransObject( SQLCA )	
END IF

//gets a retrieval for whatever user is currently logged in.
lds_settings.retrieve( is_outerWindow , "" , is_loggedInUser )
COMMIT;

ll_max = lds_settings.rowCount()

FOR ll_index = ll_max TO 1 STEP -1
	ls_name = lds_settings.getItemString( ll_index, "dynamicproperty_objectname" )
	ls_parentName = lds_settings.getItemString( ll_index, "dynamicproperty_containername")
	ll_instance = lds_settings.getItemNumber( ll_index , "dynamicproperty_instance")
	ls_label = lds_settings.getItemString( ll_index, "dynamicproperty_propertylabel")
	
	//normal removal of user settings
	IF  Not IsNULL( ls_parentName ) AND NOT isNull( ll_instance ) AND ls_label = "prefilter" THEN
		//remove the window definition of the property
		
	
		// IF we are removing from the window def becuase the property is prefilter, then
		// we only want to remove it if it doesn't currently window definition properties other
		// than prefilter.
		//we only remove it if there are other properties of the window that we have to remove
		ls_findString = "dynamicproperty_objectname = '" +ls_Name + "'" &
		  + " AND dynamicproperty_instance = "+ string( ll_instance ) &
		  + " AND dynamicproperty_containername = '" +ls_parentName + "'" &
		  + " AND dynamicproperty_propertylabel <> 'prefilter'" &
		  + " AND isNull( dynamicproperty_username )" 
		
		ll_findIndex = lds_settings.Find( ls_findString, 1, ll_max)
	
		IF ll_findIndex = 0 THEN
			lds_settings.setItemStatus( ll_index, 0, PRIMARY!, DATAMODIFIED!)
			lds_settings.rowsMove( ll_index, ll_index, PRIMARY!, lds_settings, 1, DELETE! )
		END IF

	END IF
		

NEXT

li_result = lds_settings.update()

IF li_result = 1 THEN
	COMMIT;
	
ELSE
	ROLLBACK;
END IF
Destroy lds_settings
return li_result
end function

public function integer of_getsystemdataobjects (ref string as_dataobjects[]);/***************************************************************************************
NAME: 		of_getSystemDataObjects	

ACCESS:		public	
		
ARGUMENTS: 		
							as_dataobjects:  array passed in by reference in which to 
													add the dataobjects

RETURNS:			1
	
DESCRIPTION:	Returns an array of strings that represent valid dataobjects.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 11-15-2005
	

***************************************************************************************/

String	lsa_dataObjects[]
long		ll_count

ll_count++
lsa_dataObjects[ll_count] = "d_generic"

ll_count++
lsa_dataObjects[ll_count] = "d_emp_list"

ll_count++
lsa_dataObjects[ll_count] = "d_shipmentlist_inbound_demo"

ll_count++
lsa_dataObjects[ll_count] = "d_equip_list"

ll_count++
lsa_dataObjects[ll_count] = "d_driver_info"

ll_count++
lsa_dataObjects[ll_count] = "d_shipmentlist_groupby_origdest"


ll_count++
lsa_dataObjects[ll_count] = "d_shipmentlist_sql"



as_dataObjects = lsa_dataObjects
Return 1 

end function

public function boolean of_ismanagerdefinedproperty (string as_label);Boolean lb_Return

IF as_label = cs_State THEN
	lb_Return = TRUE
ELSEIF as_label = cs_MinPosX THEN
	lb_Return = TRUE
ELSEIF as_label = cs_MinPosY THEN
	lb_Return = TRUE
ELSEIF as_label = cs_normalpostop THEN
	lb_Return = TRUE
ELSEIF as_label = cs_normalposleft THEN
	lb_Return = TRUE
ELSEIF as_label = cs_normalposright THEN
	lb_Return = TRUE
ELSEIF as_label = cs_normalposbottom THEN
	lb_Return = TRUE
END IF

Return lb_Return
end function

private function integer of_setwindowplacementprop (string as_label, string as_property, ref s_windowplacement astr_windowplacement);Integer	li_Return = -1

IF as_label = cs_State THEN
	astr_WindowPlacement.ShowCmd = Long(as_Property)
	li_Return = 1
ELSEIF as_label = cs_MinPosX THEN
	astr_WindowPlacement.PtMinPosition.X = Long(as_Property)
	li_Return = 1
ELSEIF as_label = cs_MinPosY THEN
	astr_WindowPlacement.PtMinPosition.Y = Long(as_Property)
	li_Return = 1
ELSEIF as_label = cs_normalpostop THEN
	astr_WindowPlacement.rcNormalPosition.Top = Long(as_Property)
	li_Return = 1
ELSEIF as_label = cs_normalposleft THEN
	astr_WindowPlacement.rcNormalPosition.Left = Long(as_Property)
	li_Return = 1
ELSEIF as_label = cs_normalposright THEN
	astr_WindowPlacement.rcNormalPosition.Right = Long(as_Property)
	li_Return = 1
ELSEIF as_label = cs_normalposbottom THEN
	astr_WindowPlacement.rcNormalPosition.Bottom = Long(as_Property)
	li_Return = 1
END IF

Return li_Return
end function

private function boolean of_iswindowplacementset (s_windowplacement astr_winplacement);Return astr_WinPlacement.showCmd <> -2 AND &
		 astr_winPlacement.ptMinPosition.x <> -2 AND &
		 astr_winplacement.ptMinPosition.y <> -2 AND &
		 astr_WinPlacement.rcNormalPosition.top <> -2 AND &
		 astr_WinPlacement.rcNormalPosition.left <> -2 AND &
		 astr_WinPlacement.rcNormalPosition.right <> -2 AND &
		 astr_WinPlacement.rcNormalPosition.bottom <> -2 
end function

public function integer of_savewatchlists ();Int	 li_return = 1
IF isValid( iw_window ) THEN
	iw_window.triggerEvent( "ue_savedwWatchLists" )
	
	li_return = ids_settings.update()
	IF li_return = 1 THEN
		commit;
	ELSE
		rollback;
	END IF
	
else
	li_return = -1
END IF
RETURN li_Return
end function

public function integer of_addobjnamestolist (string asa_names[]);//Created by dan 3-17-06 as a patch to a problem with saving linkages.
//The problem is that when a window is opened, it generates a list of names of objects on which it has
//to retrieve the linkage definitions.  In the case where a window with nothing on it is opened
//nothing ends up in the linkage cache.  If a user creates a window on that window that does have linkages
//on it, the w_dynamicInstantiate doesn't update the linkage cache on this manager with the new links it retrieved.
//SO.....if the user saves the definition of the window at this point, it thinks that all of the linkages
//are brand new linkages on the window, since they aren't already in the cache.  We were ending up with duplicate
//rows in the database.   If I am ever givin permission to redo saving, I would like to make it so that it retrieves
//links based on container name instead of a list of all the objects.
Long	ll_index
Long	ll_max
Long	k
Boolean 	lb_exists

ll_max = upperBOund( asa_names )
FOR ll_index = 1 TO ll_max
	lb_exists = false
	
	//look for the name to see if it already exists in the array
	FOR k= 1 TO upperBound( isa_ObjectNames )
		IF asa_names[ll_index] = isa_objectNames[k] THEN
			lb_exists = true
			EXIT
		END IF
	NEXT
	
	IF NOT lb_exists THEN
		isa_objectNames[upperBound( isa_objectNames )+ 1] = asa_names[ll_index]
	END IF
NEXT

RETURN 1
end function

public function integer of_refreshlinkagecache ();//added by dan 3-17-06 so that the linkage cache can be refreshed with any new objects that might
//have been created where linkages already existed on them.  Before it wasn't doing this, so 
//if a window was created on another window, linkages would get loaded, but the cache wasn't updated.
//When the user went to save the window definition, it created duplicate rows in the database for linkages.
IF isValid( ids_linkages ) THEN
	ids_linkages.reset()
	ids_linkages.retrieve( isa_objectnames )
END IF
RETURN 1
end function

public function integer of_discardprefilter ();/***************************************************************************************
NAME: 			of_discardPrefilter

ACCESS:			public
		
ARGUMENTS: 		
							as_name			the name of the object being looked for
							al_instance		the instance of the object being looked for
							as_parent		the parent name of the object being looked for

RETURNS:			1	
	
DESCRIPTION:  The following searches for rows that match the parameters in the ids_settings
					cache, as well as abstract rows of the property prefilter, and then deletes them.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	9-22-2005
	

***************************************************************************************/

Long	ll_index
Long	ll_max

String	ls_name
String	ls_parent
String	ls_label
Long		ll_instance

IF isValid( ids_settings ) THEN
//	ll_max = ids_settings.rowCount( )
//	
//
//	FOR ll_index = ll_max TO 1 Step -1
//		ls_name = ids_settings.getItemString( ll_index, "dynamicproperty_objectname" ) 
//		ls_parent = ids_settings.getItemString( ll_index, "dynamicproperty_containername")
//		ll_instance = ids_settings.getItemNumber( ll_index, "dynamicproperty_instance")
//		ls_label = ids_settings.getItemString( ll_index, "dynamicproperty_propertylabel")
//		
//
//	
//		IF ls_name = as_name AND ls_label = "prefilter" AND ((ls_parent = as_parent AND al_instance = ll_instance) OR &
//			( isNULL(ls_parent) AND isNULL(ll_instance) )) THEN
//			ids_settings.Rowsdiscard   ( ll_index , ll_index, primary!)
//		END IF
//		
//	NEXT 
	
	//it is ok to discard all prefilter rows because none of them are saved to the db
	//as part of the update of ids_settings, they are saved when apply is clicked on 
	//the properties dialogue.  IF an object was removed from the cache, it is in the delete
	//buffer, so that is a good thing as well.
	ll_max = ids_settings.rowCount( )
	FOR ll_index = ll_max TO 1 Step -1
		ls_label = ids_settings.getItemString( ll_index, "dynamicproperty_propertylabel")
		IF ls_label = "prefilter" THEN
			ids_settings.RowsDiscard( ll_index, ll_index, PRIMARY! )
		END IF
	NEXT
	

END IF

return 1
end function

public function integer of_validatedataobjectchange (string as_objectname, string as_olddataobject, string as_newdataobject, ref string as_errormessage);/*Failing validation causes:
		1.  Defined linkages.  Since Link definitions can be changed, and dataobjects can
										be overriden, we dont ever want to allow
										the changing of dataobjects in this case.  No other checks
										are performed if this fails.
										
		2.	 Column and Compute Structures.  Every column in the original dataobject must
										show up as a column in the new dataobject.
										
										Every compute in the original must show up as a compute
										or a column in the new dataobject.
										
		3.  Mouseovers,         If mouseover expressions exist, than they must be valid 
										on the new dataobject.
										
		4.  Argument structure must match, arg1 on source1 must match arg1 on source 2 by name and type.
										All args on source1 must exist on source 2 and source 2 on source 1.
										
		Numbers 2 and 3 may not be critical errors, a warning message will be returned
		explaining why the validation failed.

*/
Long	ll_index
Long	ll_newIndex
Long	ll_max
Long	ll_oldColCount
Long	ll_newColCount
Long	ll_oldComputeCount
Long	ll_newComputeCount
INt	li_return	= 1

String	ls_message
String	ls_expr
String	ls_oldName
String	ls_newName

Boolean	lb_colFound = true
Boolean	lb_computeFound = true
Boolean	lb_argMatch = true
Boolean	lb_continue = true

n_ds	lds_old
n_ds	lds_new
Datastore	lds_linkages
Datastore	lds_mouseovers

String		lsa_OldcomputedObjects[]
String		lsa_NewcomputedObjects[]

lds_old = CREATE n_ds
lds_new = CREATE n_ds

lds_old.dataobject = as_olddataobject
lds_new.dataobject = as_newdataobject

lds_new.settransobject(SQLCA)
lds_new.retrieve()
commit;

lds_old.of_setBase(true)
lds_new.of_setBase(true)


//Retrieve All Linkages, we do this because a the window definition manager may have been initialized
//by the definition manager, which would be doing this check.
lds_Linkages = CREATE datastore
lds_Linkages.DataObject = "d_link_definitions"
lds_Linkages.SetTransObject(SQLCA)
lds_Linkages.Retrieve()
commit;

lds_mouseovers = CREATE datastore
lds_mouseovers.DataObject = "d_dynamicmouseover"
lds_mouseovers.SetTransObject(SQLCA)
lds_mouseovers.Retrieve({as_objectName})
commit;

lds_mouseOvers.setFilter("not isNull(textexrpression)")
lds_mouseOvers.filter()

//checking to see if its a psr.  If it is, we will make sure that the data
//object exists at the path specified. If It doesn't we will let them change the dataobject.
IF POS(as_oldDataObject, "\") > 0 THEN
 	IF FILEEXISTS( as_oldDataObject ) THEN
	 ELSE
		lb_continue = false
		li_return = ci_AllertDOPathNonValid
	END IF
END IF

IF lb_continue THEN
	ll_max = lds_linkages.rowCount()
	//IF links are going to be messed up then fail it
	FOR ll_Index = 1 TO ll_Max
		IF as_objectname = lds_linkages.getItemString(ll_index, "objectname" ) OR  as_objectname = lds_linkages.getItemString(ll_index, "detailname" )THEN
			li_return = ci_FailedDOLinkageTest
			ls_message = "Error: Either column structure must match the target dataobject, or no linkage can be defined."
			EXIT
		END IF
	NEXT
	
	//Since a failed linkage test will prevent them from being able to change the dataobject,
	//there is not need to validate anything else.
	//If it fails for some other reason before this test, then we still want to do this test
	//so that we can warn the user if it does not pass this test, but for now it isn't
	//our intention to keep them from changing the dataobject.
	IF li_return <> ci_faileddolinkagetest THEN
		//get a list of computed field object names, in the detail, both visible and nonvisible
			lds_old.inv_base.of_getobjects( lsa_OldcomputedObjects[], "compute", "*", FALSE)
			lds_new.inv_base.of_getobjects( lsa_NewcomputedObjects[], "compute", "*", FALSE)
			
			ll_oldComputeCount = upperBound( lsa_OldcomputedObjects )
			ll_newComputeCount = upperBound( lsa_NewcomputedObjects )
			
			ll_oldColCount = Long(lds_old.Object.DataWindow.Column.Count)
			ll_newColCount = Long(lds_new.Object.DataWindow.Column.Count)
			
			
			//check to see if all columns exist in the new dataobject
			IF ll_oldColCount <= ll_newColCount THEN
				FOR ll_index = 1 TO ll_oldColCount
					lb_colFound = false
					ls_oldName = lds_old.Describe("#" + String(ll_Index) + ".Name")
					
					lb_colFound = this.of_colnameexists( ls_oldName, lds_new )
					
					//if it didn't find it then not all the columns exist in the new dataobject,so it fails
					IF NOT lb_colFound THEN
						li_Return = ci_failedDocolargtest
						EXIT
					END IF			
				NEXT
			ELSE
				//not all columns exist in the new dataobject
				li_return = ci_faileddocolargtest
				lb_colFound = false
			END IF
			
			IF li_return = 1 THEN
				//check to see that all computes exist in the new dataobject, either as computes, or
				//as columns
				IF ll_oldComputeCount <= (ll_newComputeCount + ll_newColCount )THEN
					FOR ll_Index = 1 TO ll_oldComputeCount
						ls_oldName = lsa_OldcomputedObjects[ll_Index]
						lb_computeFound = false
						
						//look for the old compute as a new compute in the dataobject first
						FOR ll_newIndex = 1 TO ll_newComputeCount
							ls_newName = lsa_newComputedObjects[ll_newIndex]	
						
							IF ls_newName = Ls_oldName THEN
								lb_ComputeFound = true
								EXIT
							END IF
						NEXT
						
						//if we didn't find it as a computed field then we need to check the columns
						IF NOT lb_ComputeFound THEN
							lb_computeFound = this.of_colnameexists( ls_oldName, lds_old )
							
							IF not lb_computeFOund THEN
								li_return = ci_failedDoComputeTest
								lb_computeFound = false
							END IF
						END IF
						
						//if it didn't find the compute, then we fail validation with the ci_failedDoCompute test code
						IF li_return < 0 THEN
							EXIT
						END IF
					NEXT
				ELSE
					//we fail because if there are more computes in the old do, than columns and computes combined in the 
					//new do, then there is no way they all exist in the New DO.
					li_return  = ci_failedDOComputeTest
					lb_computeFound = false
				END IF
			END IF	
			//old columns cannot be computes in the new dataobject
			//old computes can be columns in the new dataobject
	END IF
	
	IF li_return <> ci_failedDolinkagetest THEN
		lb_argMatch = this.of_compareargs( lds_new, lds_old )
		IF not lb_argMatch THEN
			li_return = ci_failedargtest
		END IF
	END IF
	
	//Since a failed linkage test will prevent them from being able to change the dataobject,
	//there is not need to validate anything else.  Linkage failing is the only reason right
	//now where we will always keep them from changing the dataobject, we will give them a list
	//of warnings otherwise, but will not keep them from changing the dataobject.
	IF li_return <> ci_faileddolinkagetest THEn
		
		ll_max = lds_mouseOvers.rowCount()
		FOR ll_index = 1 TO ll_max
			ls_expr = lds_mouseOvers.getItemString( ll_index, "textexrpression")
			IF this.of_validatemouseoverexpression( ls_expr, lds_new ) <> 1 THEN
				li_Return = ci_faileddomouseovertest
				EXIT
			END IF
		NEXT
	END IF
	
	//create error message
	IF li_return <> 1 THEN
		IF li_return = ci_faileddolinkagetest THEN
			as_errormessage = "--Links are defined for "+ as_objectName +" for its current dataobject." 
		END IF
		
		IF not lb_colFound THEN
			as_errormessage = "--Columns found on dataobject "+ as_oldDataObject+" were not found on "+as_newDataObject+"."
		END IF
		
		IF not lb_computeFound THEN
			IF len( as_errormessage ) > 0 THEN
				as_errorMessage +="~r~n--Computes found on dataobject "+as_oldDataobject+ " were not found on" + as_newDataObject+"."
			ELSE
				as_errorMessage = "--Computes found on dataobject "+as_oldDataobject+ " were not found on" + as_newDataObject+"."
			END IF
		END IF
		
		IF not lb_argMatch THEN
			IF len( as_errormessage ) > 0 THEN
				as_errorMessage +="~r~n--The retrieval argument structures did not match."
			ELSE
				as_errorMessage = "--The retrieval argument structures did not match."
			END IF		
		END IF
		
		IF li_return = ci_faileddomouseovertest THEN
			IF len( as_errormessage ) > 0 THEN
				as_errorMessage +="~r~n--Mouseover expressions exist on "+as_olddataobject +" that did not validate on "+as_newDataObject+"."
			ELSE
				as_errorMessage = "--Mouseover expressions exist on "+as_olddataobject +" that did not validate on "+as_newDataObject+"."
			END IF	
		END IF
	END IF
END IF

Destroy	lds_linkages
DESTROY	lds_old
Destroy 	lds_new
Destroy 	lds_mouseovers

return li_return




end function

public function integer of_validatemouseoverexpression (string as_expression, n_ds ads_datastore);/***************************************************************************************
NAME: 			of_ValidateMouseOverExpression

ACCESS:			public
		
ARGUMENTS: 		(string as_expression)

RETURNS:			integer
	
DESCRIPTION:  Validates a string that is passed as an argument
					Used to validate mouseover expressions
					
					Returns 1 if an expression is valid
					Returns -1 if an expressin is invalid
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/5
			***copied from w_dwproperties on 3-30-06 by Dan for dataobject validation purposes
	

***************************************************************************************/


n_cst_String	lnv_String
String	ls_Result
Integer	li_Return

IF isValid(ads_datastore) THEN
	IF Len(Trim(as_Expression)) > 0 THEN
		
		

		as_Expression = lnv_String.of_GlobalReplace ( as_Expression, "'", "~~~'" )
		
		ls_Result = ads_datastore.Describe ( "Evaluate('" + as_Expression + "'," + String(1) + ")")
		
		IF Len(ls_Result) > 0 THEN
			IF ls_Result = "?" OR ls_Result = "!" THEN
				li_Return = -1
			ELSE
				li_Return = 1
			END IF
		ELSE
			li_Return = 1
		END IF
	ELSE
		li_Return = 1
	END IF

ELSE
	li_Return = -1
END IF

Return li_Return
end function

private function boolean of_colnameexists (string as_colname, n_ds ads_source);//returns true if it finds the colname in the dataobject of ads_source
Boolean lb_return
String	ls_newName

Long	ll_newIndex
Long	ll_newColCount

IF isValid( ads_source ) THEN
	IF isValid( ads_source.object ) THEN
		ll_newColCount = Long(ads_source.Object.DataWindow.Column.Count)
		FOR ll_newIndex = 1 TO ll_newColCount
			ls_newName = ads_source.Describe("#" + String(ll_newIndex) + ".Name")
			IF ls_newName = as_colName THEN
				lb_return = true
				EXIT
			END IF
		NEXT
	END IF
END IF
RETURN lb_return


end function

public function boolean of_compareargs (n_ds ads_source1, n_ds ads_source2);//Returns true if the argument structure matches for the two datastores

String	lsa_source1ArgNames[]
String	lsa_source1ArgTypes[]

String	lsa_source2ArgNames[]
String	lsa_source2ArgTypes[]

Long		ll_source1ArgMax
Long		ll_source2ArgMax
Long		ll_source1ArgTMax
Long		ll_source2ArgTMax
Long		ll_index

Boolean	lb_return = true

IF isValid(ads_source1) AND isValid(ads_source2) THEN
	//Get the Argument names and types for idw_currentProp and lds_temp
	ads_source1.of_Setbase(TRUE)
	ads_source2.of_setBase( TRUE )
	
	ads_source1.inv_base.of_dwarguments( lsa_Source1ArgNames, lsa_Source1ArgTypes)
	ads_source2.inv_base.of_dwarguments( lsa_Source2ArgNames, lsa_Source2ArgTypes)
	
	ll_source1ArgMax = UpperBound( lsa_source1Argnames )
	ll_source2ArgMax = UpperBound( lsa_source2ArgNames )
	//IF idw_CurrentProp and lds_temp have the same number of ArgNames, check if the names match
	IF ll_source1ArgMax = ll_source2ArgMax THEN
		
		FOR ll_Index = 1 TO ll_source1ArgMax
			IF lsa_Source1ArgNames[ll_Index] = lsa_Source2ArgNames[ll_Index] THEN
				//lb_Return remains TRUE
			ELSE
				lb_Return = FALSE
				EXIT
			END IF
		NEXT
	ELSE
		lb_Return = FALSE
	END IF
	
	ll_source1ArgTMax = UpperBound(lsa_source1ArgTypes)
	ll_source2ArgTMax = UpperBound(lsa_source2ArgTypes)
	
	//IF idw_CurrentProp and lds_temp have the same number of ArgDataTypes, check if the types match
	IF ll_source1ArgTMax = ll_source2ArgTMax THEN
		
		FOR ll_Index = 1 TO ll_source1ArgTMax
			IF lsa_source1ArgTypes[ll_Index] = lsa_source2ArgTypes[ll_Index] THEN
				//lb_Return remains TRUE
			ELSE
	
				lb_Return = FALSE
				EXIT
			END IF
		NEXT
	ELSE
		lb_Return = FALSE
	END IF
END IF
return lb_return
end function

private function integer of_refreshdetaillinks (window aw_window);/***************************************************************************************
NAME: 			of_refreshdetaillinks

ACCESS:			private

		
ARGUMENTS: 		
					aw_window:	the window that is going to be refreshed


RETURNS:		 Number of successful refreshes
	
DESCRIPTION: 	Loops through window and refreshes all detail links based on the current
					Master Row
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 3/31/06
	

***************************************************************************************/

Integer	li_Return
Integer	li_Refresh
Long		ll_Max
Long		ll_Index

u_dw	ldw_DataWindow
u_dw	ldw_Master

ll_Max = UpperBound(aw_Window.Control)

FOR ll_index = 1 to ll_Max
	IF aw_window.control[ll_index].triggerEvent("ue_hasIds") = 1 AND typeOf(aw_window.control[ll_index]) = datawindow! AND aw_window.control[ll_index].triggerEvent("ue_isTab") <> 1 THEN
		ldw_dataWindow = aw_window.control[ll_index]
		IF isValid(ldw_DataWindow.inv_Linkage) THEN
			ldw_DataWindow.inv_Linkage.of_GetMaster(ldw_Master)
			IF isValid(ldw_Master) THEN
				li_Refresh = ldw_DataWindow.inv_Linkage.of_Refresh(ldw_Master.GetRow())
				IF li_Refresh = 1 THEN
					li_Return ++
				END IF
			END IF
		END IF

	END IF
	
NEXT

Return li_Return
end function

private function integer of_getexportobjlist (string as_objectname, ref string asa_names[]);//the following will get a list of object names that need to be created as part
//of the object Named as_objectName.  EG:  'Demo Window' as as_objecct name will 
//return a list of all the objects that are created on 'Demo Window'
String	lsa_names[]
n_ds		lds_props
long		ll_max
long		ll_index

lds_props = CREATE n_ds
//this gets a list of all the distinct children objects of as_objectName
lds_props.dataobject = "d_dynamicchildrenobjects"
lds_props.setTransObject(SQLCA)

ll_max = lds_props.retrieve( as_objectName )
commit;

IF len(as_objectName) > 0 THEN
	lsa_names[1] = as_objectName
	FOR ll_index = 1 TO ll_max
		lsa_names[ll_index+1] = lds_props.getItemString( ll_index, "objectname" )
	NEXT
	
END IF
asa_names = lsa_names

DESTROY n_ds
RETURN upperBound( asa_names )
end function

public function integer of_exportobjectproperties (string as_parent, string as_object, integer ai_file);//the following is meant to export the abstract object properties into the file for as_object

//get all the properites for the one object, if as_parent is null, then we want the abstract
//properties for as_object, if there is a value for as_parent, then we want only the window
//definition properties.

//get all props for the object
//set filter by as_parent

//for all propertiesoutput the object.instance.
n_ds	lds_objectProps
Long	ll_rows
Long	ll_index
Long	ll_instance
Long	ll_tempInstance
Long	ll_firstOccurance
String	ls_writeString
String	ls_label
String	ls_value
String	ls_temp
n_cst_string	lnv_string

//ls_temp = profileString("C:\test export object.txt" ,"Active IM.property","prop.6", "didn'twork" )
//MessageBox("", ls_temp)
lds_objectProps = CREATE n_ds
lds_objectProps.dataobject = "d_objectpropertiesnonuser"
lds_objectProps.setTransobject( SQLCA )
ll_rows = lds_objectProps.retrieve( as_object )

IF as_parent = "" THEN
	setnull(as_parent)
END IF

IF ll_rows > 0 THEN
	
	lds_objectProps.setSort("instance A")
	
	// output the object definition props if as_parent is null
	// output the window definition/instance props if the parent has a value
	IF isNULL( as_parent ) THEN		
		lds_objectProps.setFilter( "isNULL(containername)" )
	ELSE
		lds_objectProps.setFilter( "containername = '"+as_parent+"'" )
	END IF
	lds_objectProps.filter()
	lds_objectProps.sort( )
	
	ll_rows = lds_objectProps.rowCount()
	IF isNULL( as_parent ) THEN		
		FileWrite( ai_file,"["+as_object+".property]" )
	
		FOR ll_index = 1 TO ll_rows
			ls_label = lds_objectProps.getItemString( ll_index, "propertylabel" )
			ls_value = lds_objectProps.getItemString( ll_index, "propertyvalue" )
			
			//because of the way we parsed prefilter, i have to strip out the ~r~n[AND]~r~n
			//only when as parent is null.  I have to remember to put it back in when importing
			//the values.  The reason it has to be parsed out is becuase the function profileString()
			//will misread [AND] as another section of the file.
			IF ls_label = "prefilter" THEN
				ls_value = Left(ls_value, POS(ls_value,"~r~n[AND]~r~n") - 1)
			ELSEIF ls_label = "dataobject" THEN 			//we want to build a list of dataobjectpaths so that we can copy them to the same 
																		//folder as that the exported file is going.
				this.of_adddataobjecttoimport( ls_value )
			END IF
			
			
			//If the user typed the 'Enter' key while making a filter or prefilter, it enters a ~r~n into
			//the string making the value multiline in the file....This is here to prevent that.
			IF ls_label = "prefilter" OR ls_label ="filter" THEN
				ls_value = lnv_string.of_GlobalReplace(ls_value, "~r~n" , " ")
			END IF
			
			ls_writeString = "prop."+string(ll_index)+"='"+ls_label+"="+ls_value+"'"	//prop.1='width=500'
			FileWrite( ai_File, ls_writeString )
			
		NEXT
	ELSE
		ll_index = 1
		ll_firstOccurance = ll_index -1
		//outputting the instance property overrides of the object for the specified parent
		DO WHILE ll_index > 0 AND ll_index < ll_rows
			ll_instance = lds_objectProps.getItemNumber(ll_index, "instance")
			
			//writes out the section title eg:  dw1.1.property  for dw1 instance 1
			FileWrite( ai_file,"["+as_object+"."+string(ll_instance)+".property]" )
			
			FOR ll_index = ll_index TO ll_rows
				ll_tempInstance = lds_objectProps.getItemNumber(ll_index, "instance")
				
				IF ll_tempInstance = ll_instance THEN
					ls_label = lds_objectProps.getItemString( ll_index, "propertylabel" )
					ls_value = lds_objectProps.getItemString( ll_index, "propertyvalue" )
					
					IF ls_label = "dataobject" THEN			//we want to build a list of dataobjectpaths so that we can copy them to the same 
																		//folder as that the exported file is going.
						this.of_adddataobjecttoimport( ls_value )	
					END IF
					
					//If the user typed the 'Enter' key while making a filter or prefilter, it enters a ~r~n into
					//the string making the value multiline in the file....This is here to prevent that.
					IF ls_label = "prefilter" OR ls_label ="filter" THEN
						ls_value = lnv_string.of_GlobalReplace(ls_value, "~r~n" , " ")
					END IF
					
					ls_writeString = "prop."+string(ll_index - ll_firstOccurance)+"='"+ls_label+"="+ls_value+"'"	//prop.1='width=500'
					FileWrite( ai_File, ls_writeString )
				ELSE
					ll_firstOccurance = ll_index - 1
					EXIT			//it found the next instance so loop around and do it for that instance
				END IF
			NEXT
		LOOP
	END IF
END IF


DESTROY lds_objectProps
return 1


end function

public function boolean of_objectexists (string as_objectname);//returns true if an object of this name already exists in the database for dynamic objects
boolean 	lb_return
String 	ls_objName
Int 		li_count

ls_objname = as_objectName

  SELECT Count ( * ) 
    INTO :li_Count
    FROM "DynamicObject"  
   WHERE "DynamicObject"."name" = :ls_objName
           ;
COMMIT;

IF li_count > 0 THEN
	lb_return = true
ELSE
	lb_return = false
END IF
	

RETURN lb_return
end function

private function integer of_getlabelandvalue (ref string as_label, ref string as_value, string as_parsestring);//takes a property string from an exported file and returns out the value and the label
String	ls_value
String	ls_label
int		li_return

IF POS( as_parseString, "=" )> 0 THEN
	ls_label = left( as_parseString, ( POS( as_parseString, "=" ))-1)		//left of equals
	ls_value = RIGHT( as_parseString, len(as_parseString) -  POS( as_parseString, "=" ) )	//right of equals
END IF

as_label = ls_label
as_value = ls_value
RETURN li_Return
end function

private function boolean of_compareabstractproperties (string as_file, string as_objectname);//The following will look at the object as_objectName in the DB and compare
//its properties with the abstract properties of the object being imported.
//If they all match, then we will return true.
Boolean 	lb_return
n_ds		lds_dbProps
String	ls_objectName
String	ls_result
String	ls_label
String	ls_value
String	ls_find
String	ls_prefilter
String	ls_psrPath
String	ls_psrFileName
String	ls_storedFileName
Long		ll_propNum
Long		ll_max
Long		ll_res
n_cst_string lnv_string

lb_return = true 

lds_dbProps = create n_ds
lds_dbProps.dataobject = "d_objectpropertiesnonuser"
lds_dbProps.setTransobject( SQLCA )
lds_dbProps.retrieve( as_objectName )
commit;

//only look at abstract definition properties
lds_dbProps.setFilter( "isnull( containername ) and isnull( instance )" )
lds_dbProps.filter()

ll_max = lds_dbProps.rowCount()

ls_objectName = as_objectName
ls_result = ProfileString(as_file, ls_objectName+".property", "prop.1", "nullvalue" )
ll_propNum = 1

IF ll_max > 0 THEN
	DO WHILE ls_result <> "nullvalue"
		ls_result = ProfileString(as_file, ls_objectName+".property", "prop."+string(ll_propNum), "nullvalue" )
		IF ls_result <> "nullvalue" THEN
			this.of_getlabelandvalue( ls_label, ls_value, ls_result )
			
			//these are properties that I don't believe are important enought to check to 
			//see if they match. They are all position and size based
			IF ls_label <> "width" AND ls_label <> "height" AND ls_label <> "X" AND &
				ls_label <> "Y" AND ls_label <> "minposy" AND ls_label <> "minposx" AND &
				ls_label	<> "normalposleft" AND ls_label <> "normalposright" AND &
				ls_label <> "normalposbottom" AND ls_label <> "normalpostop" THEN
				
					//this had to be stripped out on export so i have to put it back in
					IF ls_label = "prefilter" THEN
						ls_find = "propertylabel = '"+ls_label+"'"
						ll_res = lds_dbProps.find( ls_find, 1, ll_max )
						IF ll_res > 0 THEN
							ls_prefilter = lds_dbProps.getItemString( ll_res, "propertyvalue" )
							ls_prefilter = left( ls_prefilter, len(ls_prefilter) - 9)
							
							IF ls_prefilter <> ls_value THEN
								ll_res = 0
							END IF
						END IF
					ELSEIF	ls_label = "dataobject" AND POS( ls_value, "\") > 0 THEN
						//when looking at the dataobjects that happen to be psrs, it is possible
						//that the path name is different but the psr is the same.  I have
						//to instead parse out the psr names from each of the values and compare those
						ls_find = "propertylabel = '"+ls_label+"'"
						ll_res = lds_dbProps.find( ls_find, 1, ll_max )
						
						//gets the psr name from the value brought in from the cache
						ls_psrFileName = RIGHT( ls_value, len(ls_value) - lastPOS(ls_value, "\") )
						
						IF ll_res > 0 THEN
							
							ls_psrPath = lds_dbProps.getItemString( ll_res, "propertyvalue" )
							
							//gets the psr name from the value in the db
							ls_storedFileName = RIGHT(ls_psrPath, len(ls_psrPath) - lastPOS(ls_psrPath,"\"))
							IF ls_storedFileName <> ls_psrFileName THEN
								ll_res = 0		//force a failure
							END IF
						END IF
					ELSE
						/******Added Enhancement - Maury 3/31/06********************/
						/*Replaced single quotes with special chars single to avoid*/
						/*invalid expression on columns that may have single quotes*/
						
						If Pos(ls_value, '~~~"') =0 And Pos(ls_value, "~~~'") =0 Then
							// No special characters found.
							If Pos(ls_value, "'") >0 Then
								// Replace single quotes with special chars single quotes.
								ls_value = lnv_string.of_GlobalReplace(ls_value, "'", "~~~'")				
							End If
						End If
						
						ls_find = "propertylabel = '"+ls_label+"'" &
									+" AND propertyvalue = '" + ls_value+"'"
						ll_res = lds_dbProps.find( ls_find, 1, ll_max )
					END IF
				
					
									
					
					
					IF ll_res <= 0 THEN
						lb_return = false
						EXIT
					END IF
			END IF
		END IF
		ll_propNum ++
	LOOP
ELSE
	lb_return = false
END IF

DESTROY	lds_dbProps
RETURN lb_return
end function

private function integer of_getuniquelinkidlist (ref long ala_linkids[], datastore ads_links);//from the datastore passed in it gets a list of unique link ids and returns
//them in an array.
Long	lla_linkIds[]
String	ls_find
Long		ll_id
Long		ll_max
Long		ll_index


IF isValid( ads_links ) THEN
	
	
	ll_max = ads_links.rowCount( )
	ll_index = 1
	
	DO WHILE ll_index > 0 AND ll_index <= ll_max
		ls_find = "linkid <> "+string( ll_id )
		ll_index = ads_links.find( ls_find, ll_index, ll_max )
		
		IF ll_index > 0 THEN
			ll_id = ads_links.getItemNumber( ll_index, "linkid" )
			lla_linkids[upperBound(lla_linkIds)+1] = ll_id
		END IF
	LOOP	
END IF

ala_linkIds = lla_linkIds

RETURN upperBOund( ala_linkIds )
end function

public function integer of_exportlinks (string as_windowname, integer li_file);//The following is for outputing link definitions from a specified window name
//to a file li_file.  It exports the definitions necessary for links on the 
//window to be recreated.

Int	li_return
Long	ll_rows
Long	ll_numToWrite
Long	ll_numDefs
Long	ll_index
Long	ll_argCount
Long	ll_argIndex
Long	ll_masterInstance
Long	ll_detailInstance
Long	lla_linkIds[]
Long	ll_id
String	ls_master
String	ls_detail
String	ls_style
String	ls_description
String	ls_masterArg
String	ls_detailArg
String	ls_writeString
n_ds	lds_links
n_ds  lds_linkDefs
n_ds	lds_linkargs


//get the links between objects specified on the container
lds_links = create n_ds
lds_links.dataobject = "d_linksoncontainer"
lds_links.settransobject( SQLCA )
ll_rows = lds_links.retrieve( as_windowName )
commit;

//the link definitions
lds_linkDefs = create n_ds
lds_linkDefs.dataobject = "d_link_definitions"
lds_linkDefs.settransobject( SQLCA )
ll_numDefs = lds_linkDefs.retrieve( )
commit;

//the arguments to the links
lds_linkargs = create n_ds
lds_linkargs.dataobject = "d_linkargs"
lds_linkargs.settransobject( SQLCA )


IF ll_rows > 0 AND li_File > 0 THEN
	lds_links.setSort("linkid A")
	lds_links.sort()
	
	this.of_getuniquelinkidlist( lla_linkIds, lds_links )
	
	lds_linkargs.retrieve( lla_linkIds ) 
	commit;
	
	lds_linkargs.setSort("argumentorder A")
	lds_linkargs.sort()
	
	ll_numToWrite = upperBound( lla_linkIds )
	IF ll_numToWrite > 0 THEN
		//output the links section of the file
		FileWrite( li_file, "[Links]" )
		FOR ll_index = 1 TO ll_numToWrite
			lds_linkDefs.setFilter("linkid = "+string( lla_linkIds[ll_index] ))
			lds_linkdefs.filter()
			
			ls_master = lds_linkDefs.getItemString( 1, "objectname")
			ls_detail = lds_linkDefs.getItemString( 1, "detailName" )
			ls_style = lds_linkDefs.getitemstring( 1, "style")
			ls_description = lds_linkDefs.getitemstring( 1, "description")
			
			FILEWRITE( li_file, "link."+string(ll_index)+".id="+string(lla_linkIds[ll_index]) )
			FILEWRITE( li_file,  "link."+string(ll_index)+".master="+ls_master)
			FILEWRITE( li_file,  "link."+string(ll_index)+".detail="+ls_detail)
			FILEWRITE( li_file,  "link."+string(ll_index)+".style="+ls_style)
			IF len( ls_description ) > 0 THEN
				FILEWRITE( li_file,  "link."+string(ll_index)+".description="+ls_description )
			END IF
			
		NEXT
		
		//now the args need to be written out for each link
		FOR ll_index = 1 TO ll_numToWrite
			lds_linkDefs.setFilter("linkid = "+string( lla_linkIds[ll_index] ))
			lds_linkdefs.filter()
			//lds_linkargs.sort()
			ll_argCount = lds_linkDefs.rowCount( )

			IF ll_argCount > 0 THEN
				FILEWRITE( li_file, "[link."+string(lla_linkIds[ll_index])+"]" )
				FOR ll_argIndex= 1 TO ll_argCount
					lds_linkargs.setfilter( "linkid = "+string( lla_linkIds[ll_index] ))
					lds_linkargs.filter()
					lds_linkargs.sort()
					
					ls_masterArg = lds_linkargs.getItemstring( ll_argIndex, "mastercolumn" )
					ls_detailArg = lds_linkargs.getItemstring( ll_argIndex, "detailcolumn" )
					
					FILEWRITE( li_file, "arg."+string(ll_argIndex)+".mastercolumn="+ls_masterArg )
					FILEWRITE( li_file, "arg."+string(ll_argIndex)+".detailcolumn="+ls_detailArg )
				NEXT
			END IF
		NEXT
		
		
		//finally, I need to write out the links that apply to as_windowName
		ll_rows = lds_links.rowCount()
		IF ll_rows > 0 THEN
			FILEWRITE( li_file, "["+as_windowName+".links]" )
			FOR ll_index = 1 TO ll_rows
				ls_writeString = "link."+string(ll_index)+"."
				
				ll_id = lds_links.getItemNumber( ll_index,"linkid" )
				ls_master = lds_links.getItemString( ll_index,"objectname" )
				ls_detail =  lds_links.getItemString( ll_index,"detailname" )
				ll_masterInstance = lds_links.getItemNumber( ll_index,"objectinstance" )
				ll_detailInstance = lds_links.getItemNumber( ll_index,"detailinstance" )
				
				FILEWRITE( li_file, ls_writeString+"id="+string(ll_id))
				FILEWRITE( li_file, ls_writeString+"master="+ls_master)
				FILEWRITE( li_file, ls_writeString+"detail="+ls_detail)
				FILEWRITE( li_file, ls_writeString+"masterinstance="+string(ll_masterinstance) )
				FILEWRITE( li_file, ls_writeString+"detailinstance="+string(ll_detailinstance) )
			NEXT
		END IF
	END IF
END IF

DESTROY lds_linkDefs
Destroy lds_links
RETURN li_Return


end function

private function integer of_importlinks (string as_file);//The following imports all the link defs if they don't exist, the arguments, and the links
//for the object being imported, should only be a main window.
//Returns  1 if updates succeed, -1 if definition update failed, -2 if link arg update failed
//-3 if links on the window update failed

Int	li_return
String	ls_master
String	ls_detail
String	ls_style
String	ls_description
String	lsa_masterCols[]
String	lsa_detailCols[]
String	ls_value
String	ls_arg
String	ls_masterInstance
String	ls_detailInstance
String	ls_windowName

Long		lla_importedLinkIds[]			//these two  arrays is how i am going to keep track
Long		lla_DatabaseLinkIds[]			//of imported linkIds vs the linkids that already
												//exist in the db or the new ids of the ones being
												//saved in the db.
Long		ll_newLinkId
Long		ll_newRow
Long		ll_linkId
Long		ll_masterInstance
Long		ll_detailInstance

Long		ll_index
Long		ll_argIndex
Long		ll_max
Long		ll_argmax
Long		ll_existingId
Long		ll_mapIndex

n_ds 		lds_links
n_ds		lds_linkdefs
n_ds		lds_linkArgs

//links between objects specified on the container
lds_links = create n_ds
lds_links.dataobject = "d_linksoncontainer"
lds_links.settransobject( SQLCA )

//the link definitions
lds_linkDefs = create n_ds
lds_linkDefs.dataobject = "d_link_definitions"
lds_linkDefs.settransobject( SQLCA )

//the arguments to the links
lds_linkargs = create n_ds
lds_linkargs.dataobject = "d_linkargs"
lds_linkargs.settransobject( SQLCA )


ls_value = ProfileString(as_file,"Links", "link.1.id", "nullvalue" )
ll_index = 1
//import all of the link definitions that aren't already existing

DO WHILE ls_value <> "nullvalue"
	ls_value = ProfileString(as_file,"Links", "link."+string(ll_index)+".id", "nullvalue" )
	IF ls_value <> "nullvalue" THEN
		ll_linkId = long(ls_value)
		ls_master = ProfileString(as_file,"Links", "link."+string(ll_index)+".master", "nullvalue" )
		ls_detail = ProfileString(as_file,"Links", "link."+string(ll_index)+".detail", "nullvalue" )
		ls_style = ProfileString(as_file,"Links", "link."+string(ll_index)+".style", "nullvalue" )
		ls_description = ProfileString(as_file,"Links", "link."+string(ll_index)+".description", "nullvalue" )
		
		//get all of the arguments, the order that they are suppose to go in corresponds to the order in which
		//they are in the file
		ll_argIndex = 1
		ls_arg = ProfileString(as_file, "link." +ls_Value +"", "arg."+string(ll_argIndex)+".mastercolumn", "nullvalue" )
		DO WHILE ls_arg <> "nullvalue"
			ls_arg = ProfileString(as_file, "link." +ls_Value, "arg."+string(ll_argIndex)+".mastercolumn", "nullvalue" )
			IF ls_arg <> "nullvalue" THEN			
				lsa_masterCols[ll_argindex] = ls_arg
				
			END IF
			ls_arg = ProfileString(as_file, "link." +ls_Value, "arg."+string(ll_argIndex)+".detailcolumn", "nullvalue" )
			IF ls_arg <> "nullvalue" THEN			
				lsa_detailCols[ll_argindex] = ls_arg
				
			END IF
			ll_argIndex++
			
		LOOP
		
		//find out if the definition already exists, if not import it
		ll_existingId = this.of_linkagedefinitionexists( ls_master, ls_detail, ls_style, lsa_mastercols, lsa_detailcols )
		IF ll_existingId = -1 THEN
			//we need to import the next link id, not the one stored in the file.
			gnv_app.of_getnextid( "dwlink", ll_newLinkId, true )
		
			//map the new linkid to the imported link id 
			ll_mapIndex = upperBound(lla_databaseLinkIds) +1
			lla_DatabaseLinkIds[ ll_mapIndex ] = ll_newLinkId
			lla_importedLinkIds[ ll_mapIndex ] = ll_linkId			
			
			ll_newRow = lds_linkDefs.insertRow( 0 )
		
			lds_linkdefs.setItem( ll_newRow, "linkid", ll_newLinkId)
			lds_linkdefs.setItem( ll_newRow, "objectname", ls_master )
			lds_linkdefs.setItem( ll_newRow, "detailname", ls_detail )
			lds_linkdefs.setItem( ll_newRow, "style", ls_style )
			IF ls_description <> "nullvalue" THEN
				lds_linkdefs.setItem( ll_newRow, "description", ls_description )
			END IF
			
			ll_argMax = upperBOund( lsa_masterCols )
			IF ll_argMax = upperBound( lsa_detailCols ) THEN
				FOR ll_argIndex = 1 TO ll_argmax
					ll_newRow = lds_linkArgs.insertRow( 0 )
					
					lds_linkArgs.setitem( ll_newRow, "linkid", ll_newlinkId )
					lds_linkArgs.setITem( ll_newRow, "mastercolumn", lsa_masterCols[ll_argIndex] )
					lds_linkArgs.setITem( ll_newRow, "detailcolumn",  lsa_detailCols[ll_argindex] )
					lds_linkArgs.setITem( ll_newRow, "argumentorder", ll_argIndex )
				NEXT
			END IF
		ELSE
			//it does exist, but I still have to map the id
			ll_mapIndex = upperBound(lla_databaseLinkIds) +1
			lla_DatabaseLinkIds[ ll_mapIndex ] = ll_existingId
			lla_importedLinkIds[ ll_mapIndex ] = ll_linkId	
		END IF
		//after all the link definitions are imported, import the links
		//for the object that is being imported.
		
	END IF
	ll_index++
	
LOOP

//import all the links for the correct window that they will be created on
ls_windowName = ProfileString( as_file, "dynamicobject", "object.1.name", "" )		//garantee that this object is the one being imported(the main object)
IF len( ls_windowName ) > 0 THEN
	ls_value = ProfileString(as_file, ls_windowName+".links", "link.1.id", "nullvalue" )
	ll_index = 1
	DO WHILE ls_value <> "nullvalue"
		ls_value = ProfileString(as_file,ls_windowName+".links", "link."+string(ll_index)+".id", "nullvalue" )
		IF ls_value <> "nullvalue" THEN
			ll_linkId = long( ls_value )
			ls_master = ProfileString(as_file,ls_windowName+".links", "link."+string(ll_index)+".master", "nullvalue" )
			ls_detail = ProfileString(as_file,ls_windowName+".links", "link."+string(ll_index)+".detail", "nullvalue" )
			ls_masterInstance = ProfileString(as_file,ls_windowName+".links", "link."+string(ll_index)+".masterinstance", "nullvalue" )
			ls_detailInstance = ProfileString(as_file,ls_windowName+".links", "link."+string(ll_index)+".detailinstance", "nullvalue" )

			IF ls_masterInstance <> "nullvalue" THEN
				ll_masterInstance = long( ls_masterInstance )
			END IF
			IF ls_detailInstance <> "nullValue" THEN
				ll_detailInstance = long( ls_detailInstance )
			END IF
			
			//find the new database linkid that maps to the imported one
			ll_max = upperBound( lla_DatabaseLinkIds )
			FOR ll_mapindex = 1 TO ll_max
				IF lla_importedLinkIds[ll_mapIndex] = ll_linkId	 THEN
					ll_newLinkId = lla_DatabaseLinkIds[ll_mapIndex]
					EXIT
				ELSE
					ll_newLinkId = -1
				END IF
			NEXT
			
			IF ll_newLinkId <> -1 THEN
				ll_newRow = lds_links.insertRow( 0 )
				lds_links.setItem( ll_newRow, "linkid", ll_newLinkId )
				lds_links.setItem( ll_newRow, "objectname", ls_master )
				lds_links.setItem( ll_newRow, "containername", ls_windowName )
				lds_links.setItem( ll_newRow, "detailname", ls_detail )
				lds_links.setItem( ll_newRow, "detailcontainer", ls_windowName )
				lds_links.setItem( ll_newRow, "objectinstance", ll_masterInstance )
				lds_links.setItem( ll_newRow, "detailinstance", ll_detailInstance )
			END IF
			
		END IF
		ll_index ++
		
	LOOP
	
	//update the database
	li_return = lds_linkdefs.update()
	
	IF li_return = 1 THEN
		commit;
		li_Return = lds_linkArgs.update()
		IF li_return = 1 THEN
			commit;
			li_return = lds_links.update()
			IF li_return = 1 THEN
				commit;
			ELSE
				rollback;
				li_return = -3
			END IF
		ELSE
			rollback;
			li_return = -2
		END IF
	ELSE
		rollback;
		//returns -1 
	END IF
	
	ila_dblinkids = lla_DatabaseLinkIds
	ila_importlinkids = lla_importedLinkIds
	
END IF
Destroy lds_linkargs
Destroy lds_linkdefs
Destroy lds_links

RETURN li_return
end function

public function long of_linkagedefinitionexists (string as_mastername, string as_detailname, string as_style, string asa_mastercols[], string asa_detailcols[]);//the following compares the passed in variables to with link definitions in the database
//to determine whether or not the definition already exists. Returns -1 if it doesn't
//returns the link id if it does

boolean lb_return
Long		lla_ids[]
Long		ll_index
Long		ll_max
Long		ll_id
Long		ll_argIndex
Long		ll_argMax
Long		ll_return

String	ls_master
String	ls_detail
String	ls_style
String	ls_masterCol
String	ls_detailCol
n_ds 		lds_linkDefs
n_ds		lds_linkArgs

//the link definitions

lds_linkDefs = create n_ds
lds_linkDefs.dataobject = "d_link_definitions"
lds_linkDefs.settransobject( SQLCA )
ll_max = lds_linkDefs.retrieve( )
commit;

//the arguments to the links
lds_linkargs = create n_ds
lds_linkargs.dataobject = "d_linkargs"
lds_linkargs.settransobject( SQLCA )
lds_linkargs.setsort( "linkid A" )

this.of_getuniquelinkidlist( lla_ids, lds_linkDefs )
IF upperBound( lla_ids ) > 0 THEN
	lds_linkargs.retrieve( lla_ids )
	commit;
END IF

lb_return  = true

IF ll_max > 0 THEN
	//loop through definitions
	FOR ll_index = 1 TO ll_max
		ll_id = lds_linkDefs.getItemnumber( ll_index, "linkid" )
		lds_linkargs.setFilter( "linkid ="+string(ll_id) )
		lds_linkargs.filter()
		lds_linkArgs.sort()
		
		ls_master = lds_linkDefs.getItemstring( ll_index, "objectname" )
		ls_detail = lds_linkDefs.getItemstring( ll_index, "detailname" )
		ls_style = lds_linkDefs.getItemstring( ll_index, "style" )
		
		IF ls_master = as_mastername AND ls_detail = as_detailName AND ls_style = as_style THEN
			ll_argMax = lds_linkargs.rowCount()
			IF ll_argMax = upperBound( asa_mastercols[] ) AND ll_argMax = upperBound( asa_detailcols[] ) THEN
				FOR ll_argindex = 1 TO ll_argMax
					ls_detailCol = lds_linkArgs.getItemString( ll_argIndex, "detailcolumn" )
					ls_masterCol = lds_linkArgs.getItemString( ll_argIndex, "mastercolumn" )
					IF ls_detailCol <> asa_detailcols[ll_argIndex] OR ls_masterCol <> asa_mastercols[ll_argIndex] THEN
						lb_return = false
						EXIT
					END IF
				NEXT
			END IF
		ELSE		
			lb_return = false
		END IF
	NEXT
ELSE
	lb_return = false		//if there are no definitions it can't possibly exist
END IF

IF lb_return THEn
	ll_return = ll_id
ELSE
	ll_return = -1
END IF
	

DESTROY	lds_linkDefs
Destroy	lds_linkargs
RETURN ll_return
end function

public function integer of_exportmouseovers (string asa_objectnames[], long al_file);Int	li_return
Long	ll_rows
Long	ll_index

String	ls_objectname
String	ls_response
String	ls_responseType
String	ls_columnName
String	ls_text
Long		ll_linkid
n_ds	lds_mouseOvers
n_Cst_string	lnv_string

lds_mouseOvers = create n_ds
lds_mouseOvers.dataobject = "d_dynamicmouseover"
lds_mouseOvers.settransobject( SQLCA )

IF al_file > 0 AND upperBOund( asa_objectNames ) > 0 THEN
	ll_rows = lds_mouseOvers.retrieve( asa_objectnames[] )
	commit;
	
	IF ll_rows > 0 THEN
		FILEWRITE( al_file, "[Mouseovers]" )
		FOR ll_index =1 TO ll_Rows
			ls_objectName = lds_mouseOvers.getItemString( ll_index, "mouse_objectname")
			ls_response = lds_mouseOvers.getItemString( ll_index, "response")	//col or row
			ls_responseType = lds_mouseOvers.getItemString( ll_index, "responsetype")
			
			FILEWRITE( al_file, "mouse."+string(ll_index)+".objectname="+ls_objectName )
			FILEWRITE( al_file, "mouse."+string(ll_index)+".response="+ls_response )
			FILEWRITE( al_file, "mouse."+string(ll_index)+".responsetype="+ls_responseType )
			
			IF ls_response = "col" THEN
				ls_columnName = lds_mouseOvers.getItemString( ll_index, "columnname")
				FILEWRITE( al_file, "mouse."+string(ll_index)+".columnname="+ls_columnName )
			END IF
			
			IF ls_responseType = "dw" THEN
				ll_linkId = lds_mouseOvers.getItemNumber( ll_index, "links_linkid")
				FILEWRITE( al_file, "mouse."+string(ll_index)+".linkid="+string(ll_linkId) )
			ELSE
				ls_text = lds_mouseOvers.getItemString( ll_index, "textexrpression")
				ls_text = lnv_string.of_GlobalReplace(ls_text, "~r~n" , cs_globalreplacern)
				FILEWRITE( al_file, "mouse."+string(ll_index)+".text='"+ls_text+"'"  )
			END IF
		NEXT
	END IF
END IF

DESTROY lds_mouseOvers
RETURN li_Return
end function

public function integer of_importmouseovers (string as_file, string asa_objectstoimport[]);//updates the file as_file with all of the imported mouseovers that exist in the string array asa_objectstoimport.

int li_return
long	ll_max
long	ll_index
Long	ll_importIndex
String	ls_objectName
String	ls_response
String	ls_ResponseType
String	ls_text
String	ls_columnName
String	ls_value
String	ls_linkId
Long		ll_linkid
Long		ll_newRow
Long		ll_linkMax

n_cst_string	lnv_string
n_ds	lds_mouseOvers

lds_mouseOvers = create n_ds
lds_mouseOvers.dataobject = "d_mouseoverresponses"
lds_mouseOvers.settransobject( SQLCA )

ll_max = upperBOund( asa_objectsToImport )
ll_importIndex = 1

IF ll_max > 0 THEN
	ls_value = ProfileString(as_file,"Mouseovers", "mouse."+string(ll_importIndex)+".objectname", "nullvalue" )
	DO WHILE ls_value <> "nullvalue"
		ls_value = ProfileString(as_file,"Mouseovers", "mouse."+string(ll_importIndex)+".objectname", "nullvalue" )
		//if the name is in the list of things to import than import it.
		IF this.of_getstringindex( ls_value, asa_objectsToImport ) > 0 AND ls_value <> "nullvalue" THEN
			ls_objectName = ProfileString(as_file,"Mouseovers", "mouse."+string(ll_importIndex)+".objectname", "nullvalue" )
			ls_response = ProfileString(as_file,"Mouseovers", "mouse."+string(ll_importIndex)+".response", "nullvalue" )
			ls_responseType = ProfileString(as_file,"Mouseovers", "mouse."+string(ll_importIndex)+".responsetype", "nullvalue" )
			
			ll_newRow = lds_mouseOVers.insertRow( 0 )
			lds_mouseOvers.setItem( ll_newRow, "objectname", ls_objectname )
			lds_mouseOvers.setItem( ll_newRow, "response", ls_response )
			lds_mouseOvers.setItem( ll_newRow, "responsetype", ls_responsetype )
			
			IF ls_response = "col" THEN
				ls_columnName = ProfileString(as_file,"Mouseovers", "mouse."+string(ll_importIndex)+".columnname", "nullvalue" )
				lds_mouseOvers.setItem( ll_newRow, "columnname", ls_columnName )
			END IF
			
			IF ls_responseType = "dw" THEN
				ls_linkId = ProfileString(as_file,"Mouseovers", "mouse."+string(ll_importIndex)+".linkid", "nullvalue" )
				IF ls_linkId <> "nullvalue" THEN
					ll_linkMax = upperBOund( ila_importlinkids )
					FOR ll_index = 1 TO ll_linkMax
						//get the mapped index, this was initialized in the links
						IF ila_importlinkids[ll_index] = long(ls_linkId) THEN
							lds_mouseOvers.setItem( ll_newRow, "linkid", ila_dblinkids[ll_index] )
							EXIT
						END IF
					NEXT
				END IF
			ELSE
				ls_text = ProfileString(as_file,"Mouseovers", "mouse."+string(ll_importIndex)+".text", "nullvalue" )
				lds_mouseOvers.setItem( ll_newRow, "textexpression", ls_text )
			END IF
		END IF
		ll_importIndex ++
	LOOP
	
	li_return  = lds_mouseOVers.update( )
	IF li_return = 1 THEN
		commit;
	ELSE
		rollback;
	END IF
	
END IF	

RETURN li_Return
end function

public function long of_getstringindex (string as_name, string asa_namearray[]);//Returns the index where as_name is found in asa_nameArray, returns -1 if not there

Long	ll_index
Long	ll_max
Long	li_return

ll_max = upperBOund( asa_nameArray )
FOR ll_index = 1 TO ll_max
	IF asa_namearray[ll_index] = as_name THEN
		li_return = ll_index
		exit
	END IF
NEXT

IF li_return = 0 THEN
	li_Return = -1
END IF

RETURN li_Return
end function

private function integer of_adddataobjecttoimport (string as_dataobject);//Since systemdataobjects are not represented as a path we don't add them if they don't exist.														
//returns the index it can be found at. or -1 if it couldn't be inserted.
Long	li_max
Long	li_index
int	li_return
IF FILEEXISTS( as_dataobject ) THEN
	li_max = upperBound(isa_importDataObjectPaths)
	FOR li_index = 1 TO li_max
		IF isa_importDataObjectPaths[li_index] = as_dataobject THEN
			li_return = li_index
			EXIT
		END IF
	NEXT
	
	//not found
	IF li_return = 0 THEN
		isa_importDataObjectPaths[li_max + 1] = as_dataobject
		li_return = li_max + 1
	END IF
ELSE
	li_return = -1
END IF

RETURN li_return
end function

private function integer of_copydataobjects (string as_path);//this function will copy a list of dataobjects represented at the paths 
//from isa_importDataObjectPaths, which is populated on exporting of dynamic objects.
//It will copy the files to the location specified by as_path.
Int	li_return = 1
Long	ll_index
Long	ll_max
Long	ll_pos
String	ls_psrName
IF DirectoryExists( as_path ) THEN
	ll_max = upperBound(isa_importDataObjectPaths)
	
	FOR ll_index = 1 TO ll_max
		IF FILEEXISTS( isa_importDataObjectPaths[ll_index] ) THEN
			ll_pos = LastPos( isa_importDataObjectPaths[ll_index], "\" )
			ls_psrName = RIGHT(isa_importDataObjectPaths[ll_index], len(isa_importDataObjectPaths[ll_index] ) - ll_pos )
			FILECOPY( isa_importDataObjectPaths[ll_index] , as_path+"\"+ls_psrName, FALSE )			
		END IF
	NEXT
ELSE 
	li_return  = -1
END IF
RETURN li_return
end function

private function string of_getimportdataobjectpath ();//see if they want the psrs to be placed in the template
//path/dynamic folder or specify there own.  This will only be asked once
//for the entire import. Returns null if they hit cancel
Int	li_res2
String	ls_systemTemplatePath
String	ls_importpsrPath
n_cst_setting_templatesPathFolder lnv_tempPath

lnv_tempPath = create n_cst_setting_templatesPathFolder
ls_systemTemplatePath = lnv_tempPath.of_getValue()

IF DirectoryExists( ls_systemTemplatePath ) THEN
	ls_systemTemplatePath += "Dynamic"
	li_res2 = MessageBox("Import Definition", "Import dataobjects to "+ ls_systemTemplatePath+"? (Click No to select a path)", QUESTION!, yesno!, 1 )
ELSE
	li_res2 = 2		//pop a select folder
END IF
	
	
IF li_res2 = 2 THEN
	li_res2 = GetFolder("Select a path for .psrs to be moved to. (cancel aborts the import process)", ls_importPSRPath )
	IF li_res2 = 0 THEN		//cancel
		setnull( ls_importPSRPath ) 
	END IF
ELSE
	ls_importPsrPath = ls_systemTemplatePath
END IF

DESTROY lnv_tempPath
return ls_importPsrPath
end function

public function integer of_movepsrsto (string as_topath);//the following takes the list of paths populated by either import or export and moves
//them to as_toPath.  If as_toPath doesn't exist it attempts to create it.
Long	ll_max
Long	ll_index
Int	li_res
String	ls_directory
String	ls_psrName
int	li_pos
String	lsa_existingFiles[]
String	ls_movePsrMessage = ""

li_res = 1
ll_max = upperBound( isa_importdataobjectpaths )  
FOR ll_index = 1 TO ll_max
	IF FILEEXISTS( isa_importdataobjectpaths[ll_index] ) THEN
		li_pos = LASTPOS( isa_importdataobjectpaths[ll_index], "\" )
		ls_psrName = RIGHT( isa_importdataobjectpaths[ll_index], Len(isa_importdataobjectpaths[ll_index]) - li_pos )
		ls_directory = LEFT( isa_importdataobjectpaths[ll_index], li_pos - 1 )


		IF NOT DIRECTORYEXISTS( as_toPath ) THEN
			li_res = CREATEDIRECTORY( As_toPath )
		END IF
		
		//if path exists add to the message 
		IF FILEEXISTS( as_toPath+"\"+ls_psrName ) THEN
			lsa_existingFiles[upperBound(lsa_existingFiles) + 1] = ls_psrName
			ls_movePsrMessage += ls_psrName+"~r~n"
		ELSE
			//path doesn't exist, move the file
			IF li_Res = 1  THEN
				FILECOPY( isa_importdataobjectpaths[ll_index], as_toPath+"\"+ls_psrName )
			END IF
		END IF
	END IF
NEXT

IF len(ls_movePsrMessage) > 0 THEN
	//MessageBox("Import PSRs", "The following .psr files were not imported becuase they already exist.~r~n~r~n"+ls_movePsrMessage)
END IF
RETURN 1
end function

public function integer of_saveprefilter (powerobject apo_object, string as_name, ref string as_msg);/***************************************************************************************
NAME: 		of_SavePreFilter

ACCESS:			public
		
ARGUMENTS: 	(PowerObject apo_object, string as_name, ref string as_msg )

RETURNS:			Integer
	
DESCRIPTION: If object being saved is a datawindow, saves abstract definition prefilter
					directly to database
					
				If object being saved is a window, saves window instance unique prefilter
					directly to database
					
				**The object should be saved abstractly before this function is called to maintain
				  database dependencies. 
	

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created 4/10/06 - Maury
	

***************************************************************************************/

Integer		li_Return = 1
Integer		li_Instance
Long			i, ll_Max
String		ls_Name
String		ls_PreFilter
String		ls_InstanceName
String		ls_Msg

PowerObject	lpo_Instance
W_Master		lw_Window
W_Master		lwa_ChildWindows[]
u_dw			ldw_Dw


SetPointer(HourGlass!)

	
IF apo_object.TypeOf() = DataWindow! THEN
	//Insert Rows for the definition prefilter
	ldw_Dw = apo_object
	ls_PreFilter = ldw_Dw.of_GetDefinitionPreFilter()
	IF len( ls_prefilter ) > 0 THEN
		ls_Prefilter += "~r~n[AND]~r~n" //Tac on Definition/Instance delimiter
	ELSE
		ls_prefilter = ""
	END IF
	INSERT INTO "DynamicProperty" ("ObjectName","PropertyLabel","PropertyValue")  
	VALUES ( :as_Name, 'prefilter', :ls_PreFilter )  ;
	
	IF SQLCA.Sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
		li_Return = -1
		ls_Msg = "Error saving Definition prefilter for " + as_Name
	END IF
ELSEIF apo_object.TypeOf() = Window! THEN
	lw_Window = apo_object
	ll_Max = UpperBound(lw_Window.Control)
	FOR i = 1 TO ll_Max 
		//Insert Rows for all datawindow unique prefilters
		lpo_Instance = lw_Window.Control[i]
		IF lpo_Instance.TypeOf() = DataWindow! THEN
			ldw_Dw = lpo_Instance
			ls_InstanceName = ldw_Dw.of_GetObjName( )
			li_Instance = ldw_Dw.of_GetObjInstance( )
			ls_PreFilter = ldw_Dw.of_GetUniquePreFilter()
			INSERT INTO "DynamicProperty" 
			("ObjectName",
			 "ContainerName",
			 "Instance",
			 "PropertyLabel",
			 "PropertyValue",
			 )  
  			VALUES (:ls_InstanceName, :as_Name, :li_Instance, 'prefilter', :ls_PreFilter )  ;
	
			IF SQLCA.Sqlcode = 0 THEN
					COMMIT;
			ELSE
				ROLLBACK;
				li_Return = -1
				ls_Msg = "Error saving unique prefilter for " + ls_InstanceName &
							+ " on window " + as_Name
				EXIT
			END IF
			
		END IF
	NEXT
	
ELSE
	li_Return = -1 //Invalid object 
END IF

as_msg = ls_Msg

Return li_Return
end function

private function integer of_updatetabrefcachesettings (string as_objname, string as_newobjname, long al_instance, u_tab ataba_tab[]);//the following will go through the cache ids_settings and look for settings for all
//the tabs represented in the array ataba_tab[].  It will look at the properties where
//the value = the parsed out value for tabpage number properties objectname:instance and
//change it to NEWObjName:instance
Long 	ll_index
Long	ll_max
Long	ll_settingIndex
Long	ll_settingsMax
Int	li_pos
String	ls_tabName
Long		ll_tabInstance
String	ls_cacheName
String	ls_value
String	ls_cacheParent
String	ls_tabParent
Long	ll_cacheInstance
String	ls_oldDbObjValue
String	ls_DbInstanceStored
String	ls_label

u_tab ltab_tab

ll_max = upperBound( ataba_tab )
ll_settingsMax = ids_settings.rowcount( )


FOR ll_index = 1 TO ll_max
	IF isValid( ataba_tab[ll_index] ) THEN
		ltab_tab = ataba_tab[ll_index]
		ls_tabName = ltab_tab.of_getobjname( )      //is_objectName
		ll_tabInstance = ltab_tab.of_getObjinstance( )
		ls_tabparent = ltab_tab.of_getParentname( )
		FOR ll_settingIndex = 1 TO ll_settingsMax
			ls_cacheName = ids_settings.getItemString( ll_settingIndex, "dynamicproperty_objectname" )
			ll_cacheInstance = ids_settings.getItemNumber( ll_settingIndex, "dynamicproperty_instance" )
			ls_cacheParent = ids_settings.getItemString( ll_settingIndex, "dynamicproperty_containername" )
			ls_label = ids_settings.getItemString( ll_settingIndex, "dynamicproperty_propertylabel" )
			//make sure we are looking at the correct tab in the cache
		   IF isNumber( ls_label ) AND ls_cacheName = ls_tabName AND ll_cacheInstance = ll_tabInstance AND ls_tabParent = ls_cacheParent THEN
				ls_value = ids_settings.getItemString( ll_settingIndex, "dynamicproperty_propertyvalue" )
				
				li_pos = POS( ls_value, ":" )
				//if we are looking at a property that represents an objectname:instance
				IF li_pos > 0 THEN
					ls_oldDbObjValue = left( ls_Value, li_pos - 1 )
					ls_DbInstanceStored = RIGHT( ls_value, len(ls_Value) - li_pos )
					IF ls_oldDbObjValue = as_objName AND long(ls_DbInstanceStored) = al_instance THEN
						ids_settings.setItem( ll_settingIndex, "dynamicproperty_propertyvalue", as_newObjName+":"+ string( al_instance )  )
					END IF
				END IF
			END IF
		NEXT
	END IF
NEXT
RETURN 1
end function

public function integer of_exportallfordefinition (string as_objectname);String	lsa_windows[]
String	lsa_dummy[]
String	ls_filePath
String	ls_file
String	ls_path
Int	 li_outPutFile
Int li_return
Int	li_max
Int	li_index
Int	li_pos

li_return = GetFileSaveName ( "Save As", ls_path, ls_file, "txt",  "All Files (*.*),*.*" )

IF li_return = 1 THEN
	//package the file with all other files as a result of the export, into a folder
	//named after the object.
	li_pos = LASTPOS( ls_path, ls_file )
	ls_path = left( ls_path, li_pos - 1 )
	
	IF NOT directoryexists( ls_path+as_objectName ) THEN
		createDirectory( ls_path+as_objectname )
	END IF
	
	ls_path +=as_objectname
	
	this.of_exportdynamicdefinitition( as_objectName, ls_path, ls_file, lsa_windows, false/*replace */ )
	
	li_max = upperBOund( lsa_windows )
	FOR li_index = 1 TO li_max
		//prevent exporting the same object twice.
		IF lsa_windows[li_index] <> as_objectName THEN
			//append other objects to the same file
			li_OutputFile = FileOpen( ls_path +"\"+ ls_file, LineMode!, Write!, LockWrite!, append!)
			IF li_outPutFile > 0 THEN
				
				//output delimeter between objects that are exported
				FILEWRITE(li_outPutFile, "----------")
				FILECLOSE( li_outputFile )
				
				//we aren't doing anything with the array of windows returned from this call.
				this.of_exportdynamicdefinitition( lsa_windows[li_index], ls_path, ls_file, lsa_dummy, true/*append*/ )	
				
			END IF
		END IF
	NEXT
	
	MessageBox("Export Definition", "Definition Exported to "+ls_path +"\"+ ls_file)
END IF


return 1
end function

public function integer of_exportdynamicdefinitition (string as_objectname, string as_path, string as_file, ref string asa_windownames[], boolean ab_append);//the following is code that will first export all of the properties for as_objectname. If
//as_objectname represents an object of type window, then it will export all of the objects
//on that window as well, and any window definition overrides for that window.  It will then
//find any links that exist on that window, export those definitions, and then export the links
//between objects on that window. Then it will export any mouseOvers for those objects that
//could exist on the window.  It will copy any psrs that are being used by datawindows into
//the location where the exported text file is placed.  The user can save the exported file as
//anything they want, but it will be located in a folder named after the object, along with 
//all of the Psrs that were successfully copied over.

Int		li_return
Int		li_outputFile
Long		ll_rowCount
Long		ll_max
Long		ll_index
Int		li_pos
String	ls_path
String	ls_file
String	ls_type
String	ls_className
String	ls_description
String	lsa_objects[]
String	ls_writeString
String	ls_parent
String	lsa_clearArray[]
String	lsa_windowNames[]
n_ds		lds_dynamicObject

lds_dynamicObject = Create n_ds
lds_dynamicObject.dataobject = "d_dynamicobjectsmanage"
lds_dynamicObject.setTransObject(SQLCA)

lds_dynamicObject.retrieve( )
commit;

isa_importdataobjectpaths = lsa_clearArray

ll_rowCount = lds_dynamicObject.rowCount()

li_return = 1 

ls_path = as_path
ls_file = as_file


IF li_return = 1 AND ll_rowCount > 0 THEN
	
	IF ab_append THEN
		li_OutputFile = FileOpen( ls_path +"\"+ ls_file, LineMode!, Write!, LockWrite!, append! )
	ELSE
		li_OutputFile = FileOpen( ls_path +"\"+ ls_file, LineMode!, Write!, LockWrite!, Replace! )
	END IF
	
	IF li_outputFile > 0 THEN
		
		this.of_getexportobjlist( as_objectName, lsa_objects )		//gets an array of all objects that need to be exported.
		
		FileWrite( li_outputFile, "[dynamicobject]" )
		
		//output the [dynamicobject] section of the file
		//--the part of the file that contains a list of all the objects that we need abstract props for.
		ll_max = upperBound( lsa_objects )
		FOR ll_index = 1 TO ll_max
			//get the classname and type for the object
			lds_dynamicObject.setFilter( "name = '"+lsa_objects[ll_index]+"'" )
			lds_dynamicObject.filter()
			ls_type = lds_dynamicObject.getItemString( 1, "type" )
			ls_classname = lds_dynamicObject.getItemString( 1,"classname" )
			ls_description = lds_dynamicObject.getItemString( 1, "description" )
			
			ls_writeString = "object."+string( ll_index ) +".name="+lsa_objects[ll_index]
			FileWrite( li_outPutFile, ls_writeString )		//object.1.name=Demo Window
			
			ls_writeString = "object."+string( ll_index ) +".class="+ls_className	
			FileWrite( li_outpuTFile, ls_writeString )		//object.1.class=u_dw_tcard_shipment
			
			ls_writeString = "object."+string( ll_index ) +".type="+ls_type
			FileWrite( li_outpuTFile, ls_writeString )		//object.1.type=datawindow
		
			IF len( ls_description ) > 1 THEN
				ls_writeString = "object."+string( ll_index ) +".description="+ls_description
				FileWrite( li_outpuTFile, ls_writeString )		//object.1.description=blabla bal
			END IF
			
			
			//add any windows to the array that will be passed back so that we can know ,
			//which other windows need to be exported for this object.
			IF ls_type = "window" THEN
				IF lsa_objects[ll_index] <> as_objectName THEN
					lsa_windowNames[upperBound(lsa_windowNames)+ 1] = lsa_objects[ll_index]
				END IF
			END IF
		NEXT
		
		//output the properties for all of the objects
		FOR ll_index = 1 TO ll_max
			//sends in a dummy  ls_parent so that it knows its looking for definition properties
			//of the object itself, and not the object on a window
			this.of_exportobjectproperties( ls_parent, lsa_objects[ll_index], li_outputFile )	
		NEXT
		
		//output window level definition properties for all the objects if more then one was returned
		IF ll_max > 0 THEN
			FOR ll_index = 1 TO ll_max
				IF as_objectName <> lsa_objects[ll_index] THEN
					this.of_exportobjectproperties( as_objectname, lsa_objects[ll_index], li_outputFile )
				END IF
			NEXT		
		END IF
	END IF
END IF


IF li_return <> 0 THEN
	this.of_exportlinks( as_objectName, li_outputFile )
	this.of_exportMouseOvers( lsa_objects, li_outputFile )
	this.of_copyDataObjects(ls_path)
	asa_windowNames = lsa_windowNames
END IF


IF li_outputFile > 0 THEN
	FileClose(li_outputFile)
END IF

Destroy 	lds_dynamicObject
REturn li_return
end function

public function integer of_getimportfilenames (string as_fromfile, ref string asa_filenames[]);//this function previously had no meaningful return value.  Since we only want
//to find out about the psr path if there are some psrs in the file, we will 
//return the value of 2 if there are psrs.  This seemed like a decent place to 
//look for psrs because i am scanning the whole file.

String	lsa_fileNames[]
String	lsa_file[]
String	lsa_clearArray[]

String	ls_line
String	ls_path

Int		li_fileNum
Int		li_outputfileNum
Int		li_tempIndex
Int		li_max
int		li_return
Long		ll_index


IF FILEEXISTS( as_fromFile ) THEN
	
	li_fileNum = FileOpen ( as_fromFile, linemode!, read!)
	ls_path = LEFT( as_FromFile, LASTPOS(as_FromFile, "\") )		//eg  C:\blabla\demo window\
	
	
	IF li_fileNum > 0 THEN
		ll_index = 1
		li_tempIndex = 1	
		DO WHILE FILEREAD( li_fileNum, ls_Line ) > 0
			
			//10  dashes is the delimiter i am using in the file to seperate different windows 
			//that need to be imported. Bring the file into an array.
			IF ls_line <> "----------" THEN
				lsa_file[upperBound(lsa_file)+1] = ls_line
			ELSE
				//write the file to a temp file name, make sure the name we are writing doesn't match the name of the file that already existts
				IF as_fromFile <> ls_path +"temp."+string(li_tempIndex) THEN
					lsa_fileNames[li_tempIndex] = ls_path +"temp."+string(li_tempIndex)
				ELSE
					li_tempIndex ++
					lsa_fileNames[li_tempIndex] = ls_path +"temp."+string(li_tempIndex)
				END IF
				li_outputFileNum = FileOpen ( lsa_fileNames[li_tempIndex], linemode!, write!, LockReadWrite!, REPLACE!)
				
				//output the array into the file
				this.of_writeObjectTofile( li_outputFileNum, lsa_file )
				
				FILECLOSE( li_outputFileNum )
				//clear out the array so that I can use it for the next file
				lsa_file = lsa_clearArray
				li_tempINdex ++
			END IF
			
			//check to see if the line contains a data object property and a "\"
			//which means it is a psr.  Return the code for that.
			IF pos(ls_line , "dataobject") > 0 AND pos(ls_line, "\") > 0 THEN
				li_return = 2
			END IF
			
		LOOP
		
		//if we stopped because of EOF
		IF upperBound(lsa_File) > 0 THEN
			IF as_fromFile <> ls_path +"temp."+string(li_tempIndex) THEN
				lsa_fileNames[li_tempIndex] = ls_path +"temp."+string(li_tempIndex)
			ELSE
				li_tempIndex ++
				lsa_fileNames[li_tempIndex] = ls_path +"temp."+string(li_tempIndex)
			END IF
			li_outputFileNum = FileOpen ( lsa_fileNames[li_tempIndex], linemode!, write!, LockReadWrite!, REPLACE!)
				
			//output the array into the file
			this.of_writeObjectTofile( li_outputFileNum, lsa_file )
			
			FILECLOSE( li_outputFileNum )
		END IF
		
		FILECLOSE( li_fileNum )
	END IF
END IF

li_max = upperBOund(lsa_fileNames)
IF li_max > 0 THEN
	ll_index = 1
	//put the files in the order in which they have to be imported.
	FOR li_tempIndex = li_max TO 1 step -1
		asa_fileNames[ll_index] = lsa_fileNames[li_tempIndex]
		ll_index ++
	NEXT
END IF

RETURN li_return
end function

private function integer of_writeobjecttofile (integer ai_filenum, string lsa_file[]);//assumes the file number is open for write mode

Long	ll_index
Long	ll_max
int	li_return

ll_max = upperBound( lsa_file )
li_return = 1
IF ai_fileNum > 0 THEN
	FOR ll_index = 1 TO ll_max
		FILEWRITE( ai_fileNum, lsa_file[ll_index] )
	NEXT
ELSE
	li_return  = -1
END IF

RETURN li_return
end function

public function integer of_importalldynamicdefinitions (ref string as_error);//the following imports a file of objects by splitting it up into as many tempory files as
//there are windows to be imported, and imports them in the order that they need to be imported.
String	ls_pathName
String	ls_fileName
String	lsa_fileNames[]
String	lsa_clearArray[]

int		li_return

String	ls_error
int		li_index
int		li_max
int		li_res

li_return = GetFileOpenName ( "Import Dynamic Object", ls_pathName, ls_fileName, ".txt", "Text Files (*.TXT),*.TXT"  )

//these two lines are here for management of messageboxes that could pop up while importing.
//Basically the function builds an array of all the psrs that need to be imported along
//with the objects, and on the first time only, it will ask where to put the psrs.  
isa_importDataObjectPaths = lsa_clearArray
ib_checkedPath = false
//

IF li_return = 1 THEN
	//this call will break up the file into temp files and return there paths in teh array lsa_fileNames
	li_res = this.of_getimportfilenames( ls_pathName, lsa_fileNames )
	
	//if the result of the preceeding function is 2, that means that it found
	//a property that was referencing a psr.  This means that I have to find out where
	//they want the psrs to be imported to.  IF they cancel( result of the psr path question ) returns
	//a null value, than we know that we want abort the whole import process.
	IF li_Res = 2 THEN
		is_importPSRPath = this.of_getImportdataobjectpath( )
		ib_checkedPath = true
	END IF
	
	IF not IsNull( is_importPSRPath ) THEN
		li_max = upperBound( lsa_fileNames )
		
		FOR li_index = 1 TO li_max
			IF FILEEXISTS( lsa_fileNames[li_index] ) THEN
				ls_fileName = RIGHT( lsa_fileNames[li_index], len(lsa_fileNames[li_index]) - LASTPOS(lsa_fileNames[li_index],"\") )
				li_return =	this.of_importdynamicdefinition( ls_error, lsa_fileNames[li_index], ls_fileName )
				
				IF li_return <> -1 THEN
					IF li_index = li_max THEN					//its only an error importing if the main window fails to be imported.
						IF len(ls_error) = 0 THEN
							
						ELSE
							as_error += ls_error+"~r~n"
						END IF
					ELSE
						ls_error = ""				//clear out any messeges unless it is for the main object.
					END IF
					FILEDELETE(lsa_fileNames[li_index])
				ELSE
					EXIT		//bailed on import
				END IF
			END IF
		NEXT
	END IF
END IF

RETURN li_return
end function

public function integer of_importdynamicdefinition (ref string as_errormessage, string as_pathname, string as_filename);//The following imports the a dynamic object definition.  
// If the import is of a window, than it is required that the window doesn't already exist.
// If the window doesn't exist, and some of the objects on the window do exist than, it does
// a check to see if the objects appear to have the same definition.  IF they do, then
// it lists the duplicates and asks if you want to proceed.  IF they don't than it will
// not allow you to do the update and will send an errormessage back.  

String	ls_pathName
String	ls_fileName
String	ls_objectName
String	ls_class
String	ls_type
String	ls_description
String	ls_label
String	ls_value
String 	ls_result
String	ls_MainObjectName
String	ls_warningMessage
String	lsa_clearArray[]
String	lsa_instanceObjectNamesToImport[]
String	lsa_objectMouseOversToImport[]

String	ls_systemTemplatePath 
//String	ls_importPSRPath
String	ls_psrName
String	ls_currentPath


Int		li_res2
Int		li_return
Int		li_res
Int		li_pos
long		ll_index
Long		ll_max
Long		ll_newRow
Long		ll_propnum
Long		ll_instance
Long		ll_instanceMax				//since instance 1 may exist, but not an instance 3 then instance 4
Long		ll_total
Int		li_linkimportResult

n_ds		lds_dynamicObjects
n_ds		lds_properties



ls_warningmessage = ""
ll_instanceMax = 30

lds_dynamicObjects = create N_ds
lds_dynamicObjects.dataobject = "d_dynamicObjects"
lds_dynamicObjects.setTransObject( SQLCA )

lds_properties = create N_Ds
lds_properties.dataobject = "d_dynamicpropertyCache"
lds_properties.setTransobject(SQLCA)

ls_pathname = as_pathName
ls_fileName = as_filename

li_return = 1//GetFileOpenName ( "Import Dynamic Object", ls_pathName, ls_fileName, ".txt", "Text Files (*.TXT),*.TXT"  )
ls_currentPath = LEFT( ls_pathName, POS(ls_pathName, ls_fileName ) -1 )		//the location where the current shipsum.psr is, should be the same as the path to the imported file 

//Messagebox(ls_pathName, ls_filename)
IF li_return = 1 THEN
	ls_objectName = ProfileString(ls_pathName, "dynamicobject", "object.1.name", "" )
	ls_mainObjectName = ls_objectName			//i garantee that the first object listed is the one that export was called on.
	ll_index = 1
	
	//import all the objects necessary
	DO WHILE ls_objectName <> ""
		ls_objectName = ProfileString(ls_pathName, "dynamicobject", "object."+string(ll_index)+".name", "" )
		ls_class = ProfileString(ls_pathName, "dynamicobject", "object."+string(ll_index)+".class", "" )
		ls_type = ProfileString(ls_pathName, "dynamicobject", "object."+string(ll_index)+".type", "" )
		ls_description = ProfileString(ls_pathName, "dynamicobject", "object."+string(ll_index)+".name", "" )

		IF ls_objectName <> "" THEN
			//if its not a template than we want to see if the object already exists.
			//if it does, we will not allow the import to continue.
			IF this.of_isDeletableObject( ls_objectName )   THEN
				IF NOT this.of_objectexists( ls_objectName ) THEN
					IF ls_objectName <> ls_mainObjectName AND ls_type = "window" THEN
						as_errorMessage = "The window, "+ls_objectname+" exists on the import definition, and must be imported before this import can complete."
						li_return = -1
						EXIT
					ELSE
						lsa_objectMouseOversToImport[upperBound(lsa_objectMouseOversToImport)+ 1] = ls_objectName
						li_return = 1
					END IF
				ELSE
					//check to see if the abstract properties that already exist
					//match the ones we are about to import for the object, if so
					//then it is safe for us to continue importing, but we will warn them.
					//If not, then we will prevent the import.
					IF ls_objectName <> ls_MainObjectName THEN
						IF this.of_compareabstractproperties( ls_pathName, ls_objectName ) THEN
							//ok to import instance props
							
							
//removed the following line when we decided to not warn them about objects being the same							
//							ls_warningMessage +="The Object "+ ls_objectName + " already exists.~r~n"
							li_return = 0
							//we only import mouseovers for objects that do not exist arleady.
							lsa_objectMouseOversToImport[upperBound(lsa_objectMouseOversToImport)+ 1] = ls_objectName
							lsa_instanceObjectNamesToImport[upperBound(lsa_instanceObjectNamesToImport)+1] = ls_objectName
						ELSE
							//stop import process
							as_errorMessage = "The object '"+ ls_objectName+"' already exists and has different properties than the one being imported."
							li_return = -1
							EXIT
						END IF
					ELSE
						as_errorMessage = "The main object '"+ ls_objectName+ "' already has a definition that cannot be overwritten."
						li_return = -1
						EXIT
					END IF
					//perhaps give some kind of warning saying that the file can't be imported because
					//an object of that name alreadyexists
				END IF
			ELSE
				lsa_instanceObjectNamesToImport[upperBound(lsa_instanceObjectNamesToImport)+1] = ls_objectName
				li_return = 0 //don't import the object but don't fail
			END IF
		ELSE
			li_return = 0	//don't import the object, but don't fail
		END IF
		
		//import the object into the cache
		IF li_return = 1 THEN
			ll_newRow = lds_dynamicObjects.insertRow( 0 )
			lds_dynamicObjects.setItem( ll_newRow, "name", ls_objectName )
			lds_dynamicObjects.setItem( ll_newRow, "classname", ls_class )
			lds_dynamicObjects.setItem( ll_newRow, "type", ls_type )
			IF ls_description <> "" THEN
				lds_dynamicObjects.setItem( ll_newRow, "description", ls_description )
			END IF
		END IF

		ll_index++
	LOOP
	
	//if everything is ok so far
	IF li_return <> -1 THEN
		ll_max = lds_dynamicObjects.rowCount( )
		
		//for all the objects we actually want to import,  put the abstract properties
		//in the property table.
		FOR ll_index = 1 TO ll_max
			ls_objectName = lds_dynamicObjects.getItemString( ll_index, "name" )
			ls_result = ProfileString(ls_pathName, ls_objectName+".property", "prop.1", "nullvalue" )
			ll_propNum = 1
			DO WHILE ls_result <> "nullvalue"
				ls_result = ProfileString(ls_pathName, ls_objectName+".property", "prop."+string(ll_propNum), "nullvalue" )
				IF ls_result <> "nullvalue" THEN
					this.of_getlabelandvalue( ls_label, ls_value, ls_result )
					
					//this had to be stripped out on export so i have to put it back in
					IF ls_label = "prefilter" AND len( trim(ls_value) ) > 0 THEN
						ls_value += "~r~n[AND]~r~n"	
					ELSEIF ls_label = "dataobject" AND  not ib_checkedPath THEN
						//this is the  first time a dataobject property has been reached
						//so we need to see if they want the psrs to be placed in the template
						//path/dynamic folder or specify there own.  This will only be asked once
						//for the entire import.
						
						li_pos = LASTPOS( ls_value, "\" )

						//we know its a Psr so we want to check where they want them to be moved.
						IF li_pos > 0 THEN
							//is_importPSRPath = this.of_getImportdataobjectpath( )			//the folder where the psr will be moved to
							ib_checkedPath = true
							IF isNull(is_importPsrPath) THEN						//abort the import process
								li_return = -1
								EXIT
							END IF
						END IF
					END IF
					
					//this code is in two spots, once below
					IF ls_label = "dataobject" THEN		//at this point we know the path of where to put it,
																	//if its a psr then i have to adjust the value stored in the db.
						//we know its a Psr
						li_pos = LASTPOS( ls_value, "\" )
						IF li_pos > 0 THEN
							ls_psrName = RIGHT( ls_value, Len(ls_value) - li_pos )		//the psr file name to be imported eg. shipsum.ps
							ls_value = is_importPSRPath+"\"+ ls_psrName				//adjusted path location of the psr. to be stored in the db
							This.of_adddataobjecttoimport( ls_currentPath + ls_psrName )
						END IF
					END IF
					
					ll_newRow = lds_properties.insertRow(0)
					
					lds_properties.setItem( ll_newRow, "dynamicproperty_objectname", ls_objectName )
					lds_properties.setItem( ll_newRow, "dynamicproperty_propertylabel", ls_label )
					lds_properties.setItem( ll_newRow, "dynamicproperty_propertyvalue", ls_value )
				END IF
				
				ll_propNum++
			LOOP
			
			IF li_return = -1 THEN
				EXIT
			END IF
		NEXT
		
	END IF
	
	IF li_return <> -1 THEN
		//for all the objects that have window definition overrides get the props and
		//add them to the cache.
		ll_total = ll_max + upperBOund( lsa_instanceObjectNamesToImport )
		FOR ll_index = 1 TO ll_total
			IF ll_index <= ll_max THEN
				ls_objectName = lds_dynamicObjects.getItemString( ll_index, "name" )
			ELSE
				ls_objectName = lsa_instanceObjectNamesToImport[ll_index - ll_max ]
			END IF
			FOR ll_instance = 1 TO ll_instanceMax
				ls_result = ProfileString(ls_pathName, ls_objectName+"."+string( ll_instance )+".property", "prop.1", "nullvalue" )
				ll_propNum = 1
				DO WHILE ls_result <> "nullvalue"
					ls_result = ProfileString(ls_pathName, ls_objectName+"."+string( ll_instance )+".property", "prop."+string(ll_propNum), "nullvalue" )
					IF ls_result <> "nullvalue" THEN
						this.of_getlabelandvalue( ls_label, ls_value, ls_result )
						
						IF ls_label = "dataobject" AND NOT ib_checkedPath THEN
							//this is the  first time a dataobject property has been reached
							//so we need to see if they want the psrs to be placed in the template
							//path/dynamic folder or specify there own.  This will only be asked once
							//for the entire import.
							li_pos = LASTPOS( ls_value, "\" )

							//we know its a Psr so we want to check where they want them to be moved.
							IF li_pos > 0 THEN
								//is_importPSRPath = this.of_getImportdataobjectpath( )			//the folder where the psr will be moved to
								ib_checkedPath = true
								IF isNull( is_importPsrPath ) THEN		//abort the import process
									li_Return = -1
									EXIT
								END IF
							END IF
						END IF	
						
						//this code is in two spots, once above
						IF ls_label = "dataobject" THEN		//at this point we know the path of where to put it,
																	//if its a psr then i have to adjust the value stored in the db.
							//we know its a Psr
							li_pos = LASTPOS( ls_value, "\" )
							IF li_pos > 0 THEN
								ls_psrName = RIGHT( ls_value, Len(ls_value) - li_pos )		//the psr file name to be imported eg. shipsum.ps
								ls_value = is_importPSRPath+"\"+ ls_psrName				//adjusted path location of the psr. to be stored in the db
								This.of_adddataobjecttoimport( ls_currentPath + ls_psrName )
							END IF
						END IF
		IF  ll_instance = 5 THEN
			ls_value = ls_value
		END IF
		
						ll_newRow = lds_properties.insertRow(0)
						
						lds_properties.setItem( ll_newRow, "dynamicproperty_objectname", ls_objectName )
						lds_properties.setItem( ll_newRow, "dynamicproperty_propertylabel", ls_label )
						lds_properties.setItem( ll_newRow, "dynamicproperty_propertyvalue", ls_value )
						lds_properties.setItem( ll_newRow, "dynamicproperty_containername", ls_MainObjectName )
						lds_properties.setItem( ll_newRow, "dynamicproperty_instance", ll_instance )
					END IF
					
					ll_propNum++
				LOOP
				
				IF li_return = -1 THEN
					EXIT
				END IF
			NEXT
			
			IF li_return = -1 THEN
				EXIT
			END IF
		NEXT
	END IF
END IF

IF li_return <> -1 THEN
	IF ls_warningMessage <> "" THEN
		li_res = MessageBox("Import Dynamic Object", ls_warningMessage+ "~r~nSaying yes will only import window overrides. Do you wish to continue?", exclamation!, yesNo!, 2)
	ELSE
		li_res = 1
	END IF
	
	IF li_res = 1 THEN
		li_Res = lds_dynamicObjects.update()
		IF li_res = 1 THEN
			li_res = lds_properties.update()
		ELSE
			ROLLBACK;
		END IF
		
		IF li_res = 1 THEN
			commit;
			
			//properties and objects imported successfully, now move the .psrs.
			this.of_movePSRSTo( is_importPSRPath )
			
		ELSE
			rollback;
		END IF
	END IF
END IF

//if successful at importing so far, import any links
IF li_res = 1 THEN
	li_linkImportResult = this.of_importLinks( ls_pathName )
	CHOOSE CASE li_linkimportResult
		CASE -1
			as_errormessage = "Failed to import link definitions.~r~n"
			li_return = -1
		CASE -2
			as_errormessage = "Failed to import link arguments.~r~n"
			li_return = -1
		CASE -3
			as_errorMessage = "Failed to import links for the object being imported.~r~n"
			li_return = -1
	END CHOOSE
	
	//if links succeed import mouseovers
	IF li_linkImportResult = 1 THEN
		li_return = this.of_importMouseOvers( ls_pathName, lsa_objectMouseOversToImport )
		
		IF li_return <> 1 THEN
			as_errorMessage += "Failed to import mouseovers."
		END IF
	END IF
	
END IF


DESTROY lds_dynamicObjects
Destroy	lds_properties
RETURN li_return
end function

public function integer of_getcreatedobjects (ref dragobject adrg_objectscreated[]);adrg_objectsCreated = idrg_openeduserObjects
return upperbound(idrg_openeduserObjects)
end function

public function integer of_addopeneduserobject (ref dragobject adrg_object);IF isValid(adrg_object) THEN
	this.idrg_openedUserObjects[upperBOund(idrg_openedUserObjects) + 1] = adrg_object
END IF
return 1
end function

public function long of_getsystemobjects (ref n_ds ads_systemobjects);//the following returns a datastore of all the system dynamic objects that may or may not 
//exist in the database.  


//the returned datastore is updatable.  The idea is that if some of these already in the database
//then they can be discarded and the datastore can have update called on it.
n_ds		lds_systemObjects
long		k

constant	string	cs_col_name = "name"
constant string	cs_col_class = "classname"
constant string	cs_col_type	= "type"
constant string	cs_col_description = "description"

lds_systemObjects = create n_ds
lds_systemObjects.dataobject = "d_dynamicobjects"
lds_systemObjects.settransobject( SQLCA )

//just add these 5 lines for each system object that we want to add

//-----Error log object
k = lds_systemObjects.insertRow( 0 )
lds_systemObjects.setItem( k,cs_col_name, "Error Log" )
lds_systemObjects.setItem( k, cs_col_class, "u_dw_errorlog" )
lds_systemObjects.setItem( k, cs_col_type, "datawindow" )
lds_systemObjects.setItem( k, cs_col_description, "Error Log" )

//-----EDI 322 user interaction
k = lds_systemObjects.insertRow( 0 )
lds_systemObjects.setItem( k, cs_col_name, "EDI 322 User Interaction" )
lds_systemObjects.setItem( k, cs_col_class, "u_dw_322userinteraction" )
lds_systemObjects.setItem( k, cs_col_type, "datawindow" )
lds_systemObjects.setItem( k, cs_col_description, "EDI 322 User Interaction" )

//-----New EDI
k = lds_systemObjects.insertRow( 0 )
lds_systemObjects.setItem( k, cs_col_name, "New EDI Shipments" )
lds_systemObjects.setItem( k, cs_col_class, "u_dw_newedishipments" )
lds_systemObjects.setItem( k, cs_col_type, "datawindow" )
lds_systemObjects.setItem( k, cs_col_description, "New EDI Shipments" )

//-----Equipment Tracing Errors
k = lds_systemObjects.insertRow( 0 )
lds_systemObjects.setItem( k, cs_col_name, "Equipment Tracing Errors" )
lds_systemObjects.setItem( k, cs_col_class, "u_dw_Equipmenttracingerrors" )
lds_systemObjects.setItem( k, cs_col_type, "datawindow" )
lds_systemObjects.setItem( k, cs_col_description, "Display equipment tracing errors" )




ads_systemobjects = lds_systemObjects
RETURN  lds_systemObjects.rowCount()
end function

public function integer of_insertnewsystemobjectproperty (ref datastore ads_cache, string as_objectname, string as_proplabel, string as_propvalue);//this function takes a cache that has the same columns as ids_settings and inserts and abstract property into
//it.  The purpose of this originally was for inserting rows for new system objects.
Int	li_return = 1
Long	ll_index

IF isValid( ads_cache ) THEN
	ll_index = ads_cache.insertrow( 0 )
	ads_cache.setItem( ll_index,"dynamicproperty_objectname", as_objectName )
	ads_cache.setItem( ll_index,"dynamicproperty_propertylabel", as_propLabel )
	ads_cache.setItem( ll_index,"dynamicproperty_propertyvalue", as_propValue )
END IF

RETURN li_return
end function

on n_cst_bso_dynamicobjectmanager.create
call super::create
end on

on n_cst_bso_dynamicobjectmanager.destroy
call super::destroy
end on

