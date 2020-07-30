$PBExportHeader$w_master.srw
$PBExportComments$Extension Master Window class
forward
global type w_master from ofr_w_master
end type
end forward

global type w_master from ofr_w_master
event ue_haschildrenwindows ( )
event ue_hasids ( )
event ue_savedynamicproperties ( integer ai_mode )
event ue_iswindow ( )
event ue_setdynpropmansrvc ( n_cst_bso_dynamicobjectmanager anv_propmanager )
event ue_setidentifiers ( string as_objectname,  long al_objectinstance )
event ue_setproperty ( )
event ue_setparentname ( string as_parentname )
event ue_savedefinition ( )
event ue_savedefinitionas ( )
event ue_removeobject ( powerobject apo_object )
event ue_refreshdws ( )
event type integer ue_tabdialog ( )
event ue_restrictdws ( n_cst_restrictioncriteria anv_criteria,  u_dw_quickmatch adw_qm )
event ue_clearrestriction ( string as_dwtype )
event ue_broadcastevent ( string as_eventname )
event ue_savedwwatchlists ( )
event ue_forcerefresh ( )
end type
global w_master w_master

type variables
Protected:
n_cst_windowstate inv_windowstate

W_Child 				iwa_childrenWindows[]
String				is_ObjectName
String				is_parentName
Long					il_Instance
Long					il_shipcacheRowCount


Public   String				is_LastShipmentCacheChange = ""

public 	n_cst_bso_dynamicObjectManager	inv_myPropManager
Constant String 						cs_myType = "window"
Constant String 						cs_saveAsClass = "w_master"

u_tab					itaba_myTab[]
end variables

forward prototypes
public function integer wf_setwindowstate (boolean ab_value)
public function integer wf_getinstance ()
public subroutine of_getchildrenwindows (ref window awa_children[])
public function integer of_addchildwindow (ref window aw_child)
public function String of_getmytype ()
public function string of_getobjname ()
public function long of_getobjinstance ()
public function string of_getparentname ()
public function integer of_setproperty (string as_label, string as_value)
public subroutine of_getdynpropmansrvc (ref n_cst_bso_dynamicobjectmanager anv_manager)
public function integer of_opendialogue (integer ai_x, integer ai_y)
public function string of_getmyclass ()
public function integer of_adjustprefilters (string as_name, string as_filterdef)
public function integer of_setmytab (u_tab atab_tab)
public function boolean of_isdynamiccontrol ()
public function boolean of_isadminmode ()
public subroutine of_gettab (ref u_tab ataba_tab[])
public function integer of_closecreatedobjects ()
end prototypes

event ue_haschildrenwindows();//if this event exists, then a call to of_getChildrenWindows can be made
end event

event ue_hasids();//if this event exists, then calls to of_getObjName, of_getObjInstance, 
//of_getMyType, and of_getParentName can be made on this object
end event

event ue_savedynamicproperties(integer ai_mode);/***************************************************************************************
NAME: 	ue_saveAsAbstact		

ACCESS:			public
		
ARGUMENTS: 		
							ai_mode: The mode being set, 1,2, or 3 are legal values.

RETURNS:			none
	
DESCRIPTION:	This event can't be triggered to save instances as well as abstracts, based
					on three different modes.  
					
					Mode 1:  "User Property" Sends all of the properties of this instance to the service object.
								The service object will save the property to the database, with
								user name, instance number, and parent name not equal to null.
					
					Mode 2:	"Save as Abstract" Sends all of the abstract properties to the service object to be
								saved to the database.  The service object will know whether or not
								it is saving this object as a new abstract object, or if it is overwriting
								the old one.  Either way it is saved with null parent name, null user name, and
								null instance number.
								
					Mode 3:	"Child WIndow, window Definition"Sends all of the information to the service object to save this object
								to the Database as an abstract definition of the w_child for the abstract
								definition  of the parent.  In other words, it stores it with null userName,
								but non-null instance number and non null parent name.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created  By Dan 8-24-2005
	

***************************************************************************************/


String 	ls_sort
String	ls_filter
String	ls_indicator
String	ls_dragScroll
String	ls_myClassName

Long		ll_handle
s_windowPlacement lstr_winPlaceMent
Long		ll_state
Long		ll_minPositionx
Long		ll_minPositiony
Long		ll_normalPositionTop
Long		ll_normalPositionLeft
Long		ll_normalPositionRight
Long		ll_normalPositionBottom

ls_myClassName = this.className()

IF ai_mode = 1 OR ai_mode = 2 OR ai_mode = 3 THEN
	IF isValid(inv_myPropManager) THEN

		// Dimension
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "width", string(this.width), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "height", string(this.height), ls_myClassName, cs_myType)
		
		//TitleBars and Appearence
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "title", /*this.title*/is_ObjectName, ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "titleBar", string(this.titleBar), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "resizable", string(this.resizable), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "border", string(this.border), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "controlmenu", string(this.controlMenu), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "backcolor", string(this.backcolor) , ls_myClassName, cs_myType)	


		//When in mode 1 or 3, then we want to save the instance, so that means we need to save
		//the x and y coordinates.
		IF ai_mode <> 2 OR is_parentName = "" OR isNUll(is_parentName) THEN
			inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "X", string(this.X), ls_myClassName, cs_myType)
			inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "Y", string(this.Y), ls_myClassName, cs_myType)
		END IF


		//Save All window placement info
		ll_Handle = Handle(This)
		
		GetWindowPlacement( ll_Handle , lstr_WinPlacement )
		
		ll_State = lstr_WinPlacement.showCmd
		ll_MinPositionX = lstr_winPlacement.ptMinPosition.x
		ll_MinPositionY = lstr_winplacement.ptMinPosition.y
		ll_NormalPositionTop = lstr_WinPlacement.rcNormalPosition.top
		ll_NormalPositionLeft = lstr_WinPlacement.rcNormalPosition.left
		ll_NormalPositionRight = lstr_WinPlacement.rcNormalPosition.right
		ll_NormalPositionBottom = lstr_WinPlacement.rcNormalPosition.bottom 

		
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, inv_MyPropManager.cs_state, String(ll_State), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, inv_MyPropManager.cs_minposx, string(ll_MinPositionX), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, inv_MyPropManager.cs_minposy, string(ll_MinPositionY), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, inv_MyPropManager.cs_NormalPosTop , string(ll_NormalPositionTop), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, inv_MyPropManager.cs_NormalPosLeft , string(ll_NormalPositionLeft), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, inv_MyPropManager.cs_NormalPosRight , string(ll_NormalPositionRight), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, inv_MyPropManager.cs_NormalPosBottom , string(ll_NormalPositionBottom), ls_myClassName, cs_myType)
	END IF
	
ELSE
	// invalid mode entered, no action
END IF
end event

event ue_iswindow();//just here to know it is a window
end event

event ue_setdynpropmansrvc(n_cst_bso_dynamicObjectManager anv_propmanager);inv_myPropManager = anv_propManager
end event

event ue_setidentifiers(string as_objectname, long al_objectinstance);is_objectName = as_objectName
il_Instance		= al_objectInstance

//this.title = as_objectName
end event

event ue_setproperty();//means that of_serproperties can be called on this object
end event

event ue_setParentName;is_parentName = as_parentName
end event

event ue_savedefinition();Integer	li_Save
Integer	li_Return
String	ls_nullstring
String 	ls_message
String	ls_Name
Int	li_result

ls_Name = This.of_GetObjName()

li_Save = Messagebox("Save Definition", "Save Definition for '" + ls_Name + "' ?", Question! , OKCancel!) 

IF li_Save = 1 AND isValid( inv_myPropManager )THEN
	
	li_Return = inv_MyPropManager.of_SaveAbsdef( This , 0 , ls_Name, ls_nullString)
	
	IF li_Return = 1 THEN
		ls_message = "'" + ls_Name + "' definition "
	
	ELSE
		ls_message = "Error Saving Definition for '" + ls_Name + "'"

	END IF
	
	IF li_return = 1 THEN
			
		//ls_message = ls_message+ "and linkages "
		//since the linkages table may have been modified by deletions of
		//link definitions, I need to refresh the linkage data before I can
		//make modifictations to it for saving.
//		this.inv_myPropManager.ids_linkages.reset()
//		this.inv_myPropManager.ids_linkages.retrieve( this.inv_myPropManager.isa_ObjectNames )
		this.inv_myPropManager.of_refreshlinkagecache( )
		this.inv_myPropManager.of_saveLinkages( this )
	
		li_result = this.inv_myPropManager.ids_linkages.upDate()
	
		IF li_result = 1 THEN
			ls_message = ls_message + "and linkages successfully"  
			COMMIT;
			
		ELSE
			ls_message = ls_message + " error: linkages could not be "
			ROLLBACK;
			li_result = -1
			
		END IF
	END IF	
	ls_message = ls_message + " saved."
	MessageBox("Saving Window Definition", ls_message)
END IF


end event

event ue_savedefinitionas();Integer	li_Return

//Open Save Definition As Window and pass This as the parm to hold the This
IF NOT IsValid ( w_SaveDefinitionAs ) THEN
	li_Return = OpenWithParm(w_SaveDefinitionAs, This)
ELSE
	w_SaveDefinitionAs.SetFocus ( )
	li_Return = 1
END IF
end event

event ue_removeobject(powerobject apo_object);String	ls_name
String	ls_parentName

Long		ll_instance
w_master lw_parent

//make sure that my prop manager knows to remove the object properties from the cache.
IF isValid( apo_object ) THEN
	IF apo_object.triggerEvent( "ue_hasIds" ) = 1 THEN
		
		ls_name = apo_object.dynamic of_getObjName()
		ls_parentName = apo_object.dynamic of_getParentName()
		ll_instance = apo_object.dynamic of_getObjInstance()
		
		IF isValid( inv_myPropManager ) THEN
			inv_myPropManager.of_addToDeleteCache( ls_name, ls_parentName, ll_instance)
		END IF
	
	
	END IF
	
	
	IF typeOf (apo_object ) <> window! THEN
		This.CloseUserObject(apo_object)
	ELSE
		close( apo_object )
		
	END IF
END IF
end event

event ue_refreshdws();//loop through controls and trigger ue_reload on them, then trigger
//ue_refreshDws on any subsequent windows if it is time for a refresh of the cache.

Int	li_index
Int 	li_max

DateTime	ldt_CurrentShipmentCacheUpdate
DateTime	ldt_lastShipmentCacheUpdate
String	ls_CurrentShipmentCacheChange
Boolean	lb_UpdateNeeded
u_dw		ldw_temp
n_ds	lds_temp
n_cst_ShipmentManager	lnv_ShipmentManager
n_Cst_employeeManager	lnv_employeeManager
//Get the current lastchange timestamp from the shipmentmanager.

ls_CurrentShipmentCacheChange = lnv_ShipmentManager.of_Get_Lastchange_Ships ( )

//If the current lastchange value is more recent than the last one refreshed into this window instance,
//OR there has been no prior refresh on this window instance (this is the initial load), then
//perform the refresh.

lnv_shipmentManager.of_refreshshipments( false)		//added 4-4-07
lnv_employeeManager.of_refreshemployees( )
IF ls_CurrentShipmentCacheChange > is_LastShipmentCacheChange OR is_LastShipmentCacheChange = ""  THEN
	lb_updateNeeded = true
	//added 4-6-07
	IF il_shipcacheRowCount = 0 THEN
		lds_temp = lnv_ShipmentManager.of_get_ds_ship( )
		IF isValid( lds_temp ) THEN		
			il_shipcacheRowCount = lds_temp.rowCOunt()		//initialize the initial rowcount of the cache.
		END IF
	END IF
ELSE
	//DEK:4-5-07No new shipments or changes have been made to the cache, so we check to see if the rowcount
	//is the same.
	lds_temp = lnv_ShipmentManager.of_get_ds_ship( )
	
	IF isValid( lds_temp ) THEN
		//DEK 4-5-07 If a shipment was deleted and nothing else triggered an update of the cache timestamp...we
		//can capture this by comparing the previous rowCount of the cache with the current row count
		//of the cache. 
		IF lds_temp.rowcount( ) < il_shipcacheRowCount THEN
			lb_updateNeeded = true
			il_shipcacheRowCount = lds_temp.rowCOunt()
		END IF
	END IF
END IF

IF this.windowState = Minimized! THEN
	lb_updateNeeded = false
END IF

IF lb_UpdateNeeded THEN
	
	li_max = upperBound( this.control )
	
	FOR li_index = 1 TO li_max
		IF isValid( this.control[li_index] ) THEN
			IF TYPEOF(this.control[li_index] ) = Datawindow! AND this.control[li_index].triggerEvent("ue_hasIds") = 1 THEN
				ldw_temp = this.control[li_index]
				IF ldw_temp.of_isTimetorefresh( ) THEN
					this.control[li_index].triggerEvent("ue_reload")
					ldw_temp.of_showrefreshstatus( TRUE )
				ELSE
					ldw_temp.of_showrefreshstatus( FALSE )
				END IF
			END IF
		END IF
	NEXT
	
	
	//trigger this event on all children windows
	li_max = upperBound( iwa_childrenWindows )
	FOR li_index = 1 TO li_max
		IF isValid( iwa_childrenWindows[li_index] ) THEN
			iwa_childrenWindows[li_index].is_LastShipmentCacheChange = ""
			iwa_childrenWindows[li_index].triggerEvent( "ue_refreshDws" )
		END IF	
	NEXT
	
	//If the processing above forced the initial retrieval of the cache, the lastchange_ships 
	//would not yet be set.  Get it here.
	
	IF ls_CurrentShipmentCacheChange = "" THEN
		ls_CurrentShipmentCacheChange = lnv_ShipmentManager.of_Get_Lastchange_Ships ( )
	END IF
	
	//Record the current value onto the instance variable for comparison the next time this is called.	
	is_LastShipmentCacheChange =  ls_CurrentShipmentCacheChange
	
	This.SetRedraw(True)
END IF
end event

event type integer ue_tabdialog();Integer		li_Return
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm


lstr_Parm.is_Label = "CURRENTOBJ"
lstr_Parm.ia_value = This
lnv_Msg.of_add_parm( lstr_Parm )

lstr_Parm.is_Label = "PARENTWINDOW"
lstr_Parm.ia_value = This.ParentWindow()
lnv_Msg.of_add_parm( lstr_Parm )

//Open Tab Dialog box and pass This as the parm to hold current obj
IF NOT IsValid ( w_TabSelection ) THEN
	li_Return = OpenWithParm(w_TabSelection, lnv_Msg, This.ParentWindow())
ELSE
	w_TabSelection.SetFocus ( )
	li_Return = 1
END IF

Return li_Return
end event

event ue_restrictdws(n_cst_restrictioncriteria anv_criteria, u_dw_quickmatch adw_qm);Long	ll_index
Long	ll_max

IF isValid( anv_criteria ) AND isValid( adw_qm ) THEN
	ll_max = upperBound( this.control )
	FOR ll_index = 1 TO ll_max
		IF isValid( this.control[ll_index] ) THEN
			IF this.control[ll_index].triggerEvent("ue_restrict") = 1 THEN
				this.control[ll_index].dynamic Event ue_restrict( anv_criteria, adw_qm )
				//Messagebox("", this.control[ll_index].className())
			END IF
			
		END IF
	NEXT
	
	//loop through all controls and sub windows to forward the restriction call on all of them.
		//trigger this event on all children windows
	ll_max = upperBound( iwa_childrenWindows )
	FOR ll_index = 1 TO ll_max
		IF isvalid( iwa_childrenWindows[ll_index] ) THEN
			IF iwa_childrenWindows[ll_index].triggerEvent( "ue_restrictDws" ) = 1 THEN
				
				iwa_childrenWindows[ll_index].EVENT ue_restrictDws( anv_criteria, adw_qm )
				
			END IF
		END IF
	NEXT
END IF

//MessageBox("w_master", "not implemented")
end event

event ue_clearrestriction(string as_dwtype);Long 	ll_index
Long	ll_max

u_dw	ldw_temp
w_master	lw_win

ll_max = upperBOund(  this.control  )
//undo restriction for all dws pending on the type of as_dwType,
FOR ll_index = 1 TO ll_max
	IF isValid( control[ll_index] ) THEN
		IF control[ll_index].typeOf( ) = datawindow! AND control[ll_index].triggerEvent("ue_hasIds") = 1 THEN 
			ldw_temp = control[ll_index]
			ldw_temp.Event ue_clearRestriction( as_dwType )
		END IF
	END IF
NEXT

ll_max = upperBOund( iwa_childrenWindows )

FOR ll_index = 1 TO ll_max
	IF isValid( iwa_childrenWindows[ll_index] ) THEN
		IF typeOf( iwa_childrenWindows[ll_index] ) = window! AND iwa_childrenWindows[ll_index].triggerEvent( "ue_hasIds" ) = 1 THEN
			lw_win = iwa_childrenWindows[ll_index]
			lw_win.event ue_clearRestriction( as_dwType )
		END IF
	END IF
NEXT


end event

event ue_broadcastevent(string as_eventname);/***************************************************************************************
NAME: 			ue_broadcastevent

ACCESS:			public
		
ARGUMENTS: 		(string as_EventName)

RETURNS:			none
	
DESCRIPTION:	
		Triggers an Event (as_EventName) on all Controls
		Recursively calls this event on all child windows
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 11/18/05
	

***************************************************************************************/
Long	ll_index
Long	ll_max

//loop through all controls and sub windows to forward event trigger on all of them.

ll_max = upperBound( this.control )
FOR ll_index = 1 TO ll_max
	IF isValid( this.Control[ll_index] ) THEN
		this.Control[ll_index].triggerEvent(as_EventName)
	END IF
NEXT

ll_max = upperBound( iwa_childrenWindows )
FOR ll_index = 1 TO ll_max
	IF isvalid( iwa_childrenWindows[ll_index] ) THEN
		iwa_childrenWindows[ll_index].Event ue_BroadCastEvent(as_EventName)
	END IF
NEXT
end event

event ue_savedwwatchlists();//loops through control and subwindows trying to save watchlist filters as user settings.
Long	ll_index
Long	ll_max

ll_max = upperBound( this.control )
FOR ll_index = 1 TO ll_max	
	IF isValid( this.control[ll_index] ) THEN
		 this.control[ll_index].triggerEvent("ue_saveWatchlist")	
	END IF
NEXT

ll_max = upperBOund( iwa_childrenwindows ) 
FOR ll_index = 1 TO ll_max
	if isValid( iwa_childrenwindows[ll_index] ) THEN
		iwa_childrenwindows[ll_index].triggerEvent("ue_saveDwWatchLists")
	END IF
NEXT
end event

event ue_forcerefresh();//loop through controls and trigger ue_reload on them, then trigger
//ue_refreshDws on any subsequent windows

Int	li_index
Int 	li_max

DateTime	ldt_CurrentShipmentCacheUpdate
String	ls_CurrentShipmentCacheChange

n_cst_ShipmentManager	lnv_ShipmentManager


//Get the current lastchange timestamp from the shipmentmanager.
ls_CurrentShipmentCacheChange = lnv_ShipmentManager.of_Get_Lastchange_Ships ( )

//refresh all datawindows in the control array if they support
//ue_reload

li_max = upperBound( this.control )

FOR li_index = 1 TO li_max
	IF isValid( this.control[li_index] ) THEN
		this.control[li_index].triggerEvent("ue_reload")
	END IF
NEXT


//trigger this event on all children windows
li_max = upperBound( iwa_childrenWindows )
FOR li_index = 1 TO li_max
	IF isValid( iwa_childrenWindows[li_index] ) THEN
		iwa_childrenWindows[li_index].is_LastShipmentCacheChange = ""
		iwa_childrenWindows[li_index].triggerEvent( "ue_forceRefresh" )
	END IF	
NEXT


//If the processing above forced the initial retrieval of the cache, the lastchange_ships 
//would not yet be set.  Get it here.

IF ls_CurrentShipmentCacheChange = "" THEN
	ls_CurrentShipmentCacheChange = lnv_ShipmentManager.of_Get_Lastchange_Ships ( )
END IF

//Record the current value onto the instance variable for comparison the next time this is called.	
is_LastShipmentCacheChange = ls_CurrentShipmentCacheChange

This.SetRedraw(True)
end event

public function integer wf_setwindowstate (boolean ab_value);CHOOSE CASE ab_value
		
	CASE TRUE
		IF Not IsValid ( inv_windowstate ) THEN
			inv_windowstate = CREATE n_cst_windowstate
		END IF
		
		inv_windowstate.of_Setrequestor( THIS )
		
	CASE FALSE
		DESTROY ( inv_windowstate )
		
END CHOOSE


RETURN 1
end function

public function integer wf_getinstance ();RETURN 0
end function

public subroutine of_getchildrenwindows (ref window awa_children[]);awa_children = iwa_childrenWindows
end subroutine

public function integer of_addchildwindow (ref window aw_child);/***************************************************************************************
NAME: 			of_addChildWindow

ACCESS:			public
		
ARGUMENTS: 		
							(Window)

RETURNS:			integer
	
DESCRIPTION: This function adds an already defined child window of this window
				 to its array so that it is aware that it has a child window.  Child
				 windows are not considdered part of a windows control.  Returns
				 the index of the child window.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 8-15-2005
	

***************************************************************************************/

long	ll_index

ll_index = upperBound(iwa_childrenWindows)

iwa_childrenWindows[ll_index +1] = aw_child

return ll_index + 1
end function

public function String of_getmytype ();return cs_myType
end function

public function string of_getobjname ();return is_ObjectName
end function

public function long of_getobjinstance ();return il_instance
end function

public function string of_getparentname ();return is_parentName
end function

public function integer of_setproperty (string as_label, string as_value);/***************************************************************************************
NAME: 	of_setProperty()		

ACCESS:			public
		
ARGUMENTS: 		
							as_label:  the identifier of the property to be set.
							as_value:  the value to set the property to.

RETURNS:			1 if succeeds at setting the property,
					-1 if it doesn't.
	
DESCRIPTION: sets the property of this window matched by as_label to the value
				 specified by as_value.
				  
				  Returns 1 if success, -1 if no property is set.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : created by Dan	8-16-2005
	

***************************************************************************************/
Int li_return

IF as_label = "X" THEN
	this.X = long(as_value)

	li_return = 1
	
ELSEIF as_label = "Y" THEN
	this.Y = long(as_value)
	li_return = 1
	
ELSEIF as_label = "title" THEN
	//this.title = as_value
	this.title = is_ObjectName

	IF this.ClassName() = "w_sheet_dynamiccontrol" THEN
		This.dynamic of_SetAdminMode( FALSE )
	END IF
	
	li_return = 1
	
ELSEIF as_label = "width" THEN
	this.width = long(as_value)
	li_return = 1	
	
ELSEIF as_label = "height" THEN
	this.height = long(as_value)
	li_return = 1	
	
ELSEIF as_label = "titlebar" THEN
//	this.titlebar = as_label

	li_return = -1
	
	
//ELSEIF as_label = "resizable" THEN
//	IF as_value = "true" THEN
//		this.resizable = true
//		li_return = 1
//		
//	ELSEIF as_value = "false" THEN
//		this.resizable = false
//		li_return = 1
//		
//	ELSE
//		li_return = -1
//		
//	END IF
	
	
//ELSEIF as_label = "border" THEN
//	IF as_value = "true" THEN
//		this.border = true
//		li_return = 1
//		
//	ELSEIF as_value = "false" THEN
//		this.border = false
//		li_return = 1
//		
//	ELSE
//		li_return = -1
//		
//	END IF
//
//ELSEIF as_label = "controlmenu" THEN
//	IF as_value = "true" THEN
//		this.controlMenu = true
//		li_return = 1
//		
//	ELSEIF as_value = "false" THEN
//		this.controlMenu = false
//		li_return = 1
//		
//	ELSE
//		li_return = -1
//		
//	END IF
	
ELSEIF as_label = "backcolor" THEN
	this.backColor = long(as_value)

ELSE
	li_return = -1
END IF


return li_return
end function

public subroutine of_getdynpropmansrvc (ref n_cst_bso_dynamicobjectmanager anv_manager);anv_manager = inv_myPropManager
end subroutine

public function integer of_opendialogue (integer ai_x, integer ai_y);/***************************************************************************************
NAME: 		of_openDialogue	

ACCESS:			public
		
ARGUMENTS: 		
					The position x and y that the object will be opened up on.
							ai_x
							ai_y  		

RETURNS:			1 if it is opened
					0 if it just resets the focus
DESCRIPTION:	Opens a dialogue for creating objects on the window dynamically.  
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	9-18-2005
	

***************************************************************************************/

int 	li_return
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm


lstr_Parm.is_Label = "REQUESTOR"
lstr_Parm.ia_value = This
lnv_Msg.of_add_parm( lstr_Parm )

lstr_Parm.is_Label = "X"
lstr_Parm.ia_value = ai_x
lnv_Msg.of_add_parm( lstr_Parm )

lstr_Parm.is_Label = "Y"
lstr_Parm.ia_value = ai_y
lnv_Msg.of_add_parm( lstr_Parm )


IF not isValid( w_dynamicInstantiate ) THEN
	openWithParm( w_dynamicinstantiate , lnv_Msg)
	li_return = 1 
ELSE
	w_dynamicInstantiate.setFocus()
	li_return = 0
END IF

//
return li_return
end function

public function string of_getmyclass ();return cs_saveAsClass
end function

public function integer of_adjustprefilters (string as_name, string as_filterdef);Int 	li_max
Int	li_index
u_dw  ldw_temp
String	ls_name

li_max = upperBOund( this.control )
FOR li_index = 1 TO li_max
	
	IF isValid(this.control[li_index]) THEN
		IF this.control[li_index].triggerEvent( "ue_hasIds" ) = 1 AND typeOf(this.control[li_index]) = datawindow! THEN  
			ldw_temp = this.control[li_index]
			ls_name = ldw_temp.of_getObjName()
			IF ls_name = as_name THEN
				ldw_temp.of_setabsprefilter( as_filterDef )
				ldw_temp.Event ue_Reload()
			END IF
		END IF
	END IF
NEXT

li_max = upperBound( this.iwa_childrenWindows )
FOR li_index = 1 TO li_max
	IF isValid( this.iwa_childrenWindows[li_index] ) THEN
		this.iwa_childrenWindows[li_index].of_adjustPrefilters(as_name, as_filterDef)
	END IF
NEXT

return 1

end function

public function integer of_setmytab (u_tab atab_tab);itaba_myTab[upperBound( itaba_myTab )+1] = atab_tab
return 1
end function

public function boolean of_isdynamiccontrol ();/***************************************************************************************
NAME: 	of_isDynamicControl	

ACCESS:		public	
		
ARGUMENTS: 	(none)
					

RETURNS:		Boolean

DESCRIPTION:   
				Returns True if u_dw is currently a dynamic control
				Returns False if u_dw is not a dynamic control


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 11-17-05
	

***************************************************************************************/

Boolean	lb_Return
IF NOT isNull(This.of_GetObjInstance()) AND NOT isNull(This.of_GetObjName()) THEN
	lb_Return = TRUE
ELSE
	lb_Return = FALSE
END IF

Return lb_Return
end function

public function boolean of_isadminmode ();Boolean		lb_AdminMode

w_Sheet_DynamicControl	lw_Dynamic

//Get Parent Mode (Admin or Dispatch)
IF This.ClassName() = "w_sheet_dynamiccontrol" THEN
	lb_AdminMode = This.Dynamic of_GetAdminMode()
ELSEIF isValid(This.ParentWindow()) THEN //Logic for child windows
		IF This.ParentWindow().ClassName() = "w_sheet_dynamiccontrol" THEN
			lw_Dynamic = This.ParentWindow()
			lb_AdminMode = lw_Dynamic.of_GetAdminMode()
		END IF
END IF



Return lb_AdminMode
end function

public subroutine of_gettab (ref u_tab ataba_tab[]);ataba_tab = itaba_mytab
end subroutine

public function integer of_closecreatedobjects ();dragObject ldrg_openedUserObjects[]
Long	ll_index
Long	ll_max
Long	ll_childMax
Long	ll_childIndex
Long	ll_controlIndex
Long	ll_controlmax

//clean up all created objects and save watchlists.
IF isValid( inv_mypropmanager ) THEN
	ll_max = inv_myPropmanager.of_getcreatedobjects( ldrg_openedUserObjects )
	
	FOR ll_index = 1 TO ll_max
		IF isValid( ldrg_openedUserObjects[ll_index] ) THEN
			ll_controlMax = upperBOund( this.control )
			FOR ll_controlIndex = ll_controlMax TO 1 Step -1
				
				IF ISValid( this.control[ll_controlIndex] ) THEN
					IF ldrg_openedUserObjects[ll_index] = this.control[ll_controlIndex] THEN
						this.CloseUserObject( ldrg_openedUserObjects[ll_index] )  
						
					END IF
				END IF
			NEXT
		END IF
	NEXT
END IF

RETURN 1
end function

on w_master.create
call super::create
end on

on w_master.destroy
call super::destroy
end on

event dragdrop;call super::dragdrop;U_tab	luo_tab
IF source.triggerEvent( "ue_isTab") = 1 THEN
	luo_tab = source
	luo_tab.event ue_dropNotify( this )
END IF
end event

event close;call super::close;Int   li_index
Int	li_max

IF isValid( inv_myPropManager ) THEN
	li_max = upperBound( itaba_myTab ) 
	
	FOR li_index = 1 TO li_max
		IF iSValid( itaba_myTab[li_index] ) THEN
			itaba_myTab[li_index].event ue_closeTab( this )
		END IF
	NEXT

	//close all the created objects.
	this.of_closecreatedobjects( )

END IF
end event

event rbuttondown;call super::rbuttondown;/***************************************************************************************
NAME: 			rbutton down

ACCESS:			public
		
ARGUMENTS: 		
							same

RETURNS:			long
	
DESCRIPTION:	Pops open a menu for creating new objects on the window as well as the 
					setting up of properties( in future ).
					
					It also gives the option to save abstract definitions.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	9-18-2005
	

***************************************************************************************/
String 	ls_result 
n_cst_privileges	lnv_priv  

int		li_length
String	ls_message
String 	lsa_parm_labels[]
Any		laa_parm_values[] 

int		li_result
Window	lw_parent

Boolean		lb_DynamicControl
Boolean		lb_DisplayMenu

lb_DynamicControl = This.of_isDynamicControl()
IF lb_DynamicControl THEN
	//Check if admin mode is on
	lb_DisplayMenu = This.of_isAdminMode() 
	
	//If in admin mode, do not allow menu on child window controls
	//Unless 'super admin' mode key sequence is pressed
	IF lb_DisplayMenu THEN
		IF This.ClassName() <> "w_sheet_dynamiccontrol" THEN //child window control
			//Unless user is holding down 'super admin' key sequence
			IF NOT KeyDown( KeyF2! ) THEN
				lb_DisplayMenu = FALSE
			END IF
		END IF	
	END IF
END IF

//Disable menu when window is dynamic and not in admin mode
IF lb_DynamicControl THEN
	//filtered if not keyed down
	IF lb_DisplayMenu THEN
		IF lnv_priv.of_dynamic_createabstract( ) THEN
			li_length = upperBound ( lsa_parm_labels )
			lsa_parm_labels[li_length + 1] = "ADD_ITEM"
			laa_parm_values[li_length + 1] = "Create Object"
		END IF
		
		IF lnv_priv.of_dynamic_createabstract( ) AND  is_ObjectName <> "Window Template" AND is_ObjectName <> "SubWindow Template" THEN
			li_length =upperBound( lsa_parm_labels )
			lsa_parm_labels[li_length + 1] = "ADD_ITEM"
			laa_parm_values[li_length + 1] = "Save Window Definition"
		END IF
		
		IF lnv_priv.of_dynamic_createabstract( ) THEN
			li_length =upperBound( lsa_parm_labels )
			lsa_parm_labels[li_length + 1] = "ADD_ITEM"
			laa_parm_values[li_length + 1] = "Save Window Definition As"
		END IF
	END IF	
	
	//menu items that are added no matter what
	IF lnv_priv.of_dynamic_changeproperties( ) AND NOT isNull(is_ParentName) AND is_ParentName <> "" THEN
		li_length =upperBound( lsa_parm_labels )
		lsa_parm_labels[li_length + 1] = "ADD_ITEM"
		laa_parm_values[li_length + 1] = "Tab Page"
	END IF
	
	IF lnv_priv.of_dynamic_createinstance( )  THEN
		IF is_objectName <> "Window Template" AND trim( is_parentname )<>"" AND not Isnull(is_parentName ) THEN 
			li_length =upperBound( lsa_parm_labels )
			lsa_parm_labels[li_length + 1] = "ADD_ITEM"
			laa_parm_values[li_length + 1] = "Remove"
		ELSE
			IF trim( is_parentname )<>"" AND not Isnull(is_parentName ) THEN
				li_length =upperBound( lsa_parm_labels )
				lsa_parm_labels[li_length + 1] = "ADD_ITEM"
				laa_parm_values[li_length + 1] = "Remove"
			END IF
		END IF
	END IF
	//-----------------------------------------------------
	
	//filtered if not keydown
	IF lb_DisplayMenu THEN	
		IF  (IsNULL( is_parentName ) OR is_parentName = "")THEN
			li_length =upperBound( lsa_parm_labels )
			lsa_parm_labels[li_length + 1] = "ADD_ITEM"
			laa_parm_values[li_length + 1] = "-"
			lsa_parm_labels[li_length + 2] = "ADD_ITEM"
			laa_parm_values[li_length + 2] = "Revert Settings"
		END IF
	END IF	
	
	ls_result = f_pop_standard(lsa_parm_labels, laa_parm_values)
		
	IF ls_result = "CREATE OBJECT" THEN
	
		this.of_openDialogue( xpos, ypos )
		
	ELSEIF ls_result = "SAVE WINDOW DEFINITION" THEN
		
		Event ue_saveDefinition()
		
	ELSEIF ls_result = "SAVE WINDOW DEFINITION AS" THEN
		
		EVENT ue_saveDefinitionAs()
		
	ELSEIF ls_result ="REMOVE" THEN
		
		lw_parent = this.parentwindow( )
		ls_message = "Removing '"+is_ObjectName+"', instance "+string( il_Instance )+" to be removed permanantly the next time the main window definiton is saved. "
		li_result = messageBox("Remove Window", ls_message+" Are you sure you want to permanantly remove "+ is_objectName + "?", Question!, yesno! )
		
		IF lw_parent.triggerEvent( "ue_removeObject") = 1 AND li_result = 1 THEN
			lw_parent.dynamic EVENT ue_removeobject( this )
			
		END IF
		
	ELSEIF ls_result = "REVERT SETTINGS" THEN
		//lw_parent.dynamic of_removeUserSettings( is_objectName, il_instance, is_parentName )
		IF isValid( inv_myPropManager ) THEN
			//ls_message = "Reverting "+is_ObjectName+", instance "+string( il_Instance )+" to be removed permanantly the next time user settings are saved. "
			li_result = messageBox("Revert Settings","Reverting to defaults will lose any unsaved user settings, continue?.", Question!, yesno! )
	
			IF li_result = 1 THEN
				inv_myPropManager.of_loadWindowDefinition()
				//this.event CloseQuery( )
				close(this)
				MessageBox("Revert Settings", "Default settings loaded successfully, to get back your settings, close this window without saving, and relaunch the window.")
			END IF
		ELSE 
			MessageBox("Revert Settings", "Error: Reverting settings")
		END IF
	ELSEIF ls_result ="TAB PAGE" THEN
		EVENT ue_TabDialog()

	END IF
END IF
end event

event resize;call super::resize;//edited by Dan 3-7-06
//so that when a dynamic window returns from minimized, it will attempt to refresh
//this had to be added when we decided that minimized windows wouldn't be refreshed.

//sizetype  0 = restored			refresh
//				1 = minimized
//				2 = maximized			refresh
//				3 = maxShow
//				4 = maxHide

IF isValid( inv_mypropmanager ) AND len(is_objectname) > 0 THEN
	IF sizeType = 0 OR sizeType <> 2 THEN
		this.event ue_refreshdws( )
	END IF
END IF
end event

