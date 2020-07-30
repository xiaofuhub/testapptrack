$PBExportHeader$u_tab.sru
$PBExportComments$Extension Tab class
forward
global type u_tab from pfc_u_tab
end type
type dynamicdescriptionarea_1 from dynamicdescriptionarea within u_tab
end type
end forward

global type u_tab from pfc_u_tab
integer width = 2075
integer height = 892
event ue_setidentifiers ( string as_objectname,  long al_objectinstance )
event ue_hasids ( )
event ue_propertiesdialog ( )
event ue_setdynpropmansrvc ( n_cst_bso_dynamicobjectmanager anv_propmanager )
event ue_setproperty ( )
event ue_setparentname ( string as_parentname )
event ue_savedynamicproperties ( integer ai_mode )
event type integer ue_savedefinition ( )
event type integer ue_savedefinitionas ( )
event ue_istab ( )
event type integer ue_newtab ( powerobject apo_object )
event ue_removeobject ( )
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_dropnotify ( powerobject apo_source )
event ue_closetab ( powerobject apo_object )
dynamicdescriptionarea_1 dynamicdescriptionarea_1
end type
global u_tab u_tab

type variables
//Dynamic stuff
Private String		is_parentName
Private String		is_objectName
Private Long		il_instance
Public  n_cst_bso_dynamicObjectManager inv_myPropManager
Constant String 						cs_myType = "tab"

Private Boolean 	ib_AllowProperties
Private Boolean	ib_AllowRemoveObject
Private Boolean	ib_AllowSaveDefinition
Private Boolean 	ib_AllowSaveDefinitionAs

Private Long		il_tabBackColor	= -1
Private Long		il_tabTextColor	=  0

Private Long		il_offSetX
Private Long		il_offSetY

Private Boolean	ib_selectionChanged
Private n_cst_dragService	inv_dragService

end variables

forward prototypes
public function string of_getparentname ()
public function string of_getobjname ()
public function long of_getobjinstance ()
public function integer of_allowproperties (boolean ab_switch)
public function integer of_allowremoveobject (boolean ab_switch)
public function integer of_allowsavedefinition (boolean ab_switch)
public function integer of_allowsavedefinitionas (boolean ab_switch)
public function string of_getmytype ()
public function integer of_setproperty (string as_property, string as_value)
public function integer of_settabpagebackcolor (long al_color)
public function integer of_settabpagetextcolor (long al_color)
public function integer of_setdragservice (boolean ab_switch)
public function integer of_settabtext (powerobject apo_object, string as_text)
private function boolean of_isadminmode ()
public function boolean of_isdynamiccontrol ()
end prototypes

event ue_setidentifiers(string as_objectname, long al_objectinstance);is_ObjectName = as_objectName
il_instance   = al_objectInstance

this.focusOnbuttondown = true
this.of_setDragService (true)


end event

event ue_hasids();//If this event exists, then this object has the functions 
//getObjName, and getObjInstance

end event

event ue_propertiesdialog();/***************************************************************************************
NAME: 	ue_propertiesDialog		

ACCESS:			public
		
ARGUMENTS: 		
							none
RETURNS:			none
	
DESCRIPTION:  Opens the property dialog for this window.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Maury 10-18-2005
	

***************************************************************************************/

Integer	li_Return = 0

//Open Properties Dialog box and pass This as the parm to hold the Master
IF NOT IsValid ( w_tabProperties ) THEN
	OpenWithParm(w_tabProperties, This)
	li_Return = 1
ELSE
	w_tabProperties.SetFocus ( )
	li_Return = 1
END IF

//Return li_Return
end event

event ue_setdynpropmansrvc(n_cst_bso_dynamicobjectmanager anv_propmanager);inv_myPropManager = anv_PropManager
end event

event ue_setproperty();//is here for trigger event
end event

event ue_setparentname(string as_parentname);is_parentName = as_parentName
end event

event ue_savedynamicproperties(integer ai_mode);/***************************************************************************************
NAME: 	ue_saveAsAbstact		

ACCESS:			public
		
ARGUMENTS: 		
							ai_mode: the mode of saving, legal values are 1, 2, and 3,
										but for tabs only 2 and 3 are valid because 1 is
										a user property.

RETURNS:			none
	
DESCRIPTION:	This event can be triggered to save instances as well as abstracts, based
					on three different modes.  
					
					Mode 1:  Doesn't make sense for tabs
					
					Mode 2:	Sends all of the abstract properties to the service object to be
								saved to the database.  The service object will know whether or not
								it is saving this object as a new abstract object, or if it is overwriting
								the old one.  Either way it is saved with null parent name, user name, and
								instance number.
								
					Mode 3:	Sends all of the information to the service object to save this object
								to the Database as an abstract definition of the u_tab for the abstract
								definition  of the parent.  In other words, it stores it with null userName,
								but non-null instance number and non null parent name.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created  By Dan 10-17-2005
	

***************************************************************************************/
Int		li_result
Int		li_index
Int		li_max
String 	ls_myClassName
String	ls_position

U_tabpg		ltpg_page
U_dw			ldw_ref
W_Child  	lw_ref
PowerObject	lpo_ref

li_result = 1
ls_myClassName = this.className()

IF ai_mode = 2 OR ai_mode = 3 THEN
	IF li_result = 1 AND isValid(inv_myPropManager) THEN
		
		IF this.tabPosition = tabsonbottom! THEN
			ls_position = "tabsonbottom"
		ELSEIF this.tabPosition = tabsonbottomandtop! THEN
			ls_position = "tabsonbottomandtop"
		ELSEIF this.tabPosition = tabsonleft! THEN
			ls_position = "tabsonleft"
		ELSeIF this.tabPosition = tabsonleftandright! THEN
			ls_position = "tabsonleftandright"
		ELSEIF this.tabPosition = tabsonright! THEN
			ls_position = "tabsonright"
		ELSEIF this.tabPosition = tabsonrightandleft! THEN
			ls_position = "tabsonrightandleft"
		ELSEIF this.tabPosition = tabsontop! THEN
			ls_position = "tabsontop"
		ELSEIF this.tabPosition = tabsontopandbottom! THEN
			ls_position = "tabsontopandbottom"
		END IF
		
		
		//dimensions
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "height", string(this.height), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "width", string(this.width), ls_myClassName, cs_myType)
	
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "boldselectedtext", string( this.boldselectedtext ), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "multiline", string(this.multiline ), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "position", ls_Position, ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "backcolor", string(this.backcolor) , ls_myClassName, cs_myType)
	
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "X", string(this.X), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "Y", string(this.Y), ls_myClassName, cs_myType)
		
		//IF il_tabBackColor > -1 THEN
			inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "tabbackcolor", string(il_tabBackColor), ls_myClassName, cs_myType)	
		//END IF
		
		//IF il_tabTextColor > -1 THEN
			inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, "tabtextcolor", string(il_tabTextColor), ls_myClassName, cs_myType)	
		//END IF
	
		//save as child, for a tab this is the only time the references should be saved
		IF ai_mode = 3 THEN
			li_max = upperBound( this.control )
			FOR li_index = 1 TO li_max
				IF isValid( this.control[li_index] ) THEN
					ltpg_page = this.control[li_index]
					lpo_ref = ltpg_page.of_getObject()
					//MessageBox("saving", "saving tab")
					IF isValid ( lpo_ref ) THEN
						IF typeOf( lpo_ref ) = DataWindow! THEN
							ldw_ref = lpo_ref
							inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName, string( li_index , "000" ), ldw_ref.of_getObjName()+":"+ string( ldw_ref.of_getObjInstance() ), ls_myClassName, cs_myType)
							//MessageBox("saving", "saving tab")
						ELSEIF typeOf( lpo_ref ) = Window! THEN
							lw_ref = lpo_ref
							inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instance, is_parentName,string( li_index , "000" ) , lw_ref.of_getObjName()+":"+ string( lw_ref.of_getObjInstance() ), ls_myClassName, cs_myType)
						END IF
					END IF
					
				END IF
			NEXT
			
		END IF
	
	END IF
	
END IF
end event

event type integer ue_savedefinition();/***************************************************************************************
NAME: 		ue_saveDefinition	

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			1 if the object was saved successfully , -1 otherwise
	
DESCRIPTION:  The following sends the object and info to the property manager to be
				  saved to the database over the old definition of the object.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :  Created By Dan 10-18-2005
	

***************************************************************************************/
Integer	li_Save
Integer	li_Return
String	ls_string

li_Save = Messagebox("Save Definition", "Save Definition for '" + is_ObjectName + "' ?", Question! , OKCancel!) 

IF li_Save = 1 THEN
	
	li_Return = inv_MyPropManager.of_SaveAbsdef( This , 0 , is_ObjectName, ls_string)
	
	IF li_Return = 1 THEN
		MessageBox("Definition Saved" , "'" + is_ObjectName + "' Definition Saved.")
	ELSE
		MessageBox("Error Saving!", "Error Saving Definition for '" + is_ObjectName + "'")
	END IF
	
END IF

Return li_Return
end event

event type integer ue_savedefinitionas();/***************************************************************************************
NAME: 		ue_saveDefinitionAs	

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			1 if the object was saved successfully , -1 otherwise
	
DESCRIPTION:  The following sends the object and info to the property manager to be
				  saved to the database over the old definition of the object.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :  Created By Dan 10-18-2005
	

***************************************************************************************/

Integer	li_Return

//Open Save Definition As Window and pass This as the parm to hold the This
IF NOT IsValid ( w_SaveDefinitionAs ) THEN
	
	li_Return = OpenWithParm(w_SaveDefinitionAs, This)
ELSE
	w_SaveDefinitionAs.SetFocus ( )
	li_Return = 1
END IF

Return li_Return
end event

event ue_istab();//here to test if it is a tab for triggerevent
end event

event type integer ue_newtab(powerobject apo_object);/***************************************************************************************
NAME: 			ue_newTab

ACCESS:			public
		
ARGUMENTS: 		
							powerobject apo_object: the object that is going to be set up
							as a reference to the tab page at the next available index

RETURNS:			1 if success -1 if failure
	
DESCRIPTION:  Sets up apo_object as a reference to a new tab page at the next available
					tab index.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	

***************************************************************************************/

u_TabPg		uo_TabPg
u_dw			ldw_Dw
w_master		lw_Win
Integer		li_Return

uo_TabPg = CREATE u_TabPg

li_Return = This.OpenTab( uo_TabPg, 0)

uo_TabPg.Text = apo_Object.Dynamic of_GetObjName()

//Set the Object that the tabpage will have a reference to
li_Return = uo_TabPg.of_SetRefToObject(apo_object)

IF isValid (apo_object) AND li_return = 1 THEN
	if typeOf( apo_object ) = datawindow! THEN
		ldw_dw = apo_object
		ldw_Dw.of_setTab( this )
		uo_TabPg.Text = ldw_dw.title
		ldw_dw.visible = false
	ELSEIF typeOF( apo_object ) = window! THEN
		lw_win = apo_object
		lw_win.of_setMyTab( this )
		uo_TabPg.Text = lw_win.title
		lw_win.visible = false
	END IF
	
	
END IF


IF li_Return = 1 THEN
	uo_TabPg.TabBackColor = il_tabBackColor
	uo_TabPg.TabTextColor = il_tabTextColor
	uo_TabPg.BackColor = il_tabBackColor
END IF

Return li_Return


end event

event ue_removeobject();/***************************************************************************************
NAME: 		ue_removeObject	

ACCESS:		public	
		
ARGUMENTS: 		
							none

RETURNS:			none
	
DESCRIPTION:  Removes this object from the screen and sends it to the parents delete properties
					buffer for deletion later on.  All references to this object are set to 
					visible once it has been removed.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan and Maury 10-18-2005
	

***************************************************************************************/

Int			li_index
Int			li_max

W_Master 	lw_Parent
Integer		li_Result
String		ls_message 

W_child		lw_ref
u_dw			ldw_ref
PowerObject lpo_object

U_tabpg		luo_page

IF is_objectName <> "Tab Template" THEN
	ls_message = "Removing this tab will cause all matching instances on "+is_parentName + " to be removed on the next save definition of "+is_parentName+"."
ELSE
	ls_message = ""
END IF
li_Result = MessageBox("Remove Object", ls_message+ "~r~nAre you sure you want to remove " +is_objectName + "?", &
				Question!, YesNo!, 2)
IF li_Result = 1 THEN
	lw_Parent = This.GetParent()
	
	li_max = upperBound( this.control )
	For li_index = 1 TO li_max
		IF isValid( this.control[li_index] )  THEN
			IF This.control[li_index].className() = "u_tabpg" THEN
				luo_page = this.control[li_index]
				lpo_object = luo_page.of_getObject( )
				
				//make references visible.
				If isValid( lpo_object ) THEN
					
					IF typeOf( lpo_object ) = dataWindow! THEN
						ldw_ref = lpo_object
						ldw_ref.visible = true
					ELSEIF typeOf( lpo_object ) = Window! THEN
						lw_ref = lpo_object
						lw_ref.visible = true
					END IF
				END IF
			END IF
		END IF
	NEXT
	
	//send to window for deletion later on
	lw_Parent.Event ue_RemoveObject(This)
END IF
end event

event ue_lbuttondown;//set the offsets and send this into drag mode so that we can move the tab page
//if it is dropped on a w_master
IF keyDown( KeyShift! ) THEN
	il_offSetx = this.PointerX( ) 
	il_offSetY = this.pointerY( )
	IF isValid( inv_dragservice ) THEN
		inv_dragService.event ue_begindrag( )
	END IF
END IF
end event

event ue_lbuttonup;//turn off the dragMode and reset the offsets
this.drag(end!)
il_offSetX = 0
il_offSetY = 0

end event

event ue_dropnotify(powerobject apo_source);/***************************************************************************************
NAME: 		ue_dropNotify	

ACCESS:		public	
		
ARGUMENTS: 		
							apo_source:  the thing that is calling this event
RETURNS:			none
	
DESCRIPTION:  If this thing was dropped on a w_master then the window calls this event
					passing itself as apo_source.  This will allow a tab to be moved on 
					the window to the position that it was dropped at.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 10-19-2005
	

***************************************************************************************/
Long	ll_newX
Long	ll_newY

Long 	ll_objX
Long	ll_objY

Int	li_index
Int 	li_max
Int	li_result
Int	li_move

u_dw			ldw_ref
w_master		lw_ref
PowerObject	lpo_object
U_tabPg		luo_page

W_master	lw_parent
W_master	lw_win
IF isValid( apo_source )  THEN
	
	//the object dropped was this object itself, in this case we do not ask them
	//if they want to move it
	IF apo_source = THIS THEN
		lw_win = this.GetParent()
		IF isValid( lw_win ) THEN
			ll_newX = lw_win.PointerX( ) - il_offSetX	
			ll_newY = lw_win.PointerY( ) - il_offSetY
			li_move = 1
		END IF
	ELSEIF typeOf( apo_source ) = window! And apo_source.triggerEvent( "ue_hasIds" ) = 1 THEN
		lw_win = apo_source
		
		IF lw_win = this.getParent( ) THEN 
			ll_newX = lw_win.PointerX( ) - il_offSetX	
			ll_newY = lw_win.PointerY( ) - il_offSetY
			li_move = 1

		END IF
	ELSEIF apo_Source.ClassName() = "u_tabpg" THEN
		luo_page = apo_Source
		IF luo_page.getparent()  = This THEN //IF the tab page belongs to this tab, move it
			lw_win = this.GetParent()
			IF isValid( lw_win ) THEN
				ll_newX = lw_win.PointerX( ) - il_offSetX	
				ll_newY = lw_win.PointerY( ) - il_offSetY
				li_move = 1
			END IF
		END IF
	END IF
END IF	
	
IF li_move = 1 THEN
	//move datawindows and window logic
	li_max = upperBound( this.control )
	IF li_max > 0 THEN
		li_result = MessageBox("Move Tab", "Do you want to move all of the tab controls with the tab?", question!, yesnocancel! ) 
	ELSE
		li_result = 2
	END IF	
	
	IF li_result = 1 THEN
		
		FOR li_index = 1 TO li_max
			IF isValid( this.control[li_index] ) THEN
				luo_page = this.control[li_index] 
				lpo_object = luo_page.of_getObject()
				
				//logic for moving the dws and windows for the tabs
				IF isValid( lpo_object ) THEN
					IF lpo_object.typeOf() = dataWindow! THEN
						ldw_ref = lpo_object
						
						ll_objX = ldw_ref.X + (ll_newX - this.X)
						lw_parent = ldw_ref.getParent( )
						
						
						IF ll_objX <= ( lw_parent.width - 75 ) AND ll_objX >= 0 THEN
							ldw_ref.X = ll_objX
						END IF
					
						ll_objY = ldw_ref.Y + (ll_newY - this.Y)
						IF ll_objY <= ( lw_parent.height  - 75 )AND ll_objY >= 0 THEN
							ldw_ref.Y = ll_objY
						END IF
						
					
					ELSEIF lpo_object.typeOf() = window! THEN
						lw_ref = lpo_object
						
						ll_objX = lw_ref.X + (ll_newX - this.X)
						lw_parent = lw_ref.ParentWindow( )
						
						
						IF ll_objX <= (lw_parent.width -75) AND ll_objX >= 0 THEN
							lw_ref.X = ll_objX
						END IF
					
						ll_objY = lw_ref.Y + (ll_newY - this.Y)
						//MessageBox(string(lw_parent.height), ll_objY)
						IF ll_objY <= (lw_parent.height - 75) AND ll_objY >= 0 THEN
							lw_ref.Y = ll_objY
						END IF
						
					END IF
						
				END IF
			END IF
		NEXT
		//il_offset set on ue_lbuttondown
		this.X = ll_newX		
		this.Y = ll_newY
	ELSEIF li_Result = 2 THEN
		//il_offset set on ue_lbuttondown
		this.X = ll_newX		
		this.Y = ll_newY
	ELSEIF li_Result = 3 THEN
		//Do Nothing
		
	END IF

END IF

end event

event ue_closetab(powerobject apo_object);Int	li_max
Int 	li_index

u_tabPg	luo_page
w_master	lw_ref
u_dw		ldw_ref

li_max = upperbound( this.control )
FOR li_index = 1 TO li_max
	IF isValid( this.control[li_index] ) THEN
		IF this.control[li_index].className() = "u_tabpg" THEN
			luo_page = this.control[li_index]
			
			IF luo_page.of_getObject( ) = apo_object THEN
				IF typeOf( apo_object ) = dataWindow! THEN
					ldw_ref = luo_page.of_getObject( )
					ldw_ref.visible = true
				ELSEIF typeOF( apo_object ) = window! THEN
					lw_ref = luo_page.of_getObject( )
					lw_ref.visible = true
				END IF
				this.closetab( luo_page ) 
				li_max --
				ib_SelectionChanged = FALSE
			END IF
		END IF
	END IF
NEXT
end event

public function string of_getparentname ();return is_parentName
end function

public function string of_getobjname ();return is_objectName
end function

public function long of_getobjinstance ();return il_instance
end function

public function integer of_allowproperties (boolean ab_switch);ib_AllowProperties = ab_Switch

RETURN 1
end function

public function integer of_allowremoveobject (boolean ab_switch);ib_AllowRemoveObject = ab_Switch

Return SUCCESS
end function

public function integer of_allowsavedefinition (boolean ab_switch);ib_AllowSaveDefinition = ab_Switch

Return SUCCESS
end function

public function integer of_allowsavedefinitionas (boolean ab_switch);ib_AllowSaveDefinitionAs = ab_Switch

Return SUCCESS
end function

public function string of_getmytype ();return cs_myType
end function

public function integer of_setproperty (string as_property, string as_value);/***************************************************************************************
NAME: 			of_setProperty

ACCESS:			public
		
ARGUMENTS: 		
							as_property: identifier of property to be set.

							as_value:	 value to set the property as.

RETURNS:			1 if it succeeds, -1 otherwise.
	
DESCRIPTION:	Takes a string representing the property field to be set to the value as_value.
		Returns 1 if it sets the value, -1 otherwise.  It is meant to be used when loading user
		Settings.  If a setting is can not be set, it returns -1.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created	8-4-2005		By Dan
	

***************************************************************************************/
Int	li_return
Int	li_index
Int	li_max
u_tabpg	ltpg_tab


IF as_property = "backcolor" THEN
	this.backcolor = Long( as_value )
	li_return = 1
	
ELSEIF as_property = "boldselectedtext" THEN
	IF as_value = "true" THEN
		this.boldSelectedText = true
		
	ELSE
		this.boldSelectedText = false
	END IF
	li_return = 1
	
ELSEIF as_property = "multiline" THEN
	IF as_value = "true" THEN
		this.multiline = true
	ELSE
		this.multiline = false
	END IF
	li_return = 1
ELSEIF as_property = "position" THEN
	IF as_value = "tabsonbottom" THEN
		this.tabPosition = tabsonbottom!
		this.PerpendicularText = FALSE
	ELSEIF as_value = "tabsonbottomandtop" THEN
		this.tabPosition = tabsonbottomandtop!
		this.PerpendicularText = FALSE
	ELSEIF as_value = "tabsonleft" THEN
		this.tabPosition = tabsonleft!
		this.PerpendicularText = TRUE
	ELSeIF as_value = "tabsonleftandright" THEN
		this.tabPosition = tabsonleftandright!
		this.PerpendicularText = TRUE
	ELSEIF as_value = "tabsonright" THEN
		this.tabPosition = tabsonright!
		this.PerpendicularText = TRUE
	ELSEIF as_value = "tabsonrightandleft" THEN
		this.tabPosition = tabsonrightandleft!
		this.PerpendicularText = TRUE
	ELSEIF as_value = "tabsontop" THEN
		this.tabPosition = tabsontop!
		this.PerpendicularText = FALSE
	ELSEIF as_value = "tabsontopandbottom" THEN
		this.tabPosition = tabsontopandbottom!
		this.PerpendicularText = FALSE
	END IF
	li_return = 1
ELSEIF as_property = "width" THEN
	this.width = long( as_value )
	li_return = 1
ELSEIF as_property = "height" THEN
	this.height = long( as_value )
	
	li_return = 1
	
ELSEIF as_property = "X" THEN
	this.X = long( as_value )
	li_return = 1
ELSEIF as_property = "Y" THEN
	this.Y = long(as_value)
	li_return = 1
	
ELSEIF Match( as_property, "^[0-9]+$" ) THEN	
	this.OpenTab ( ltpg_tab, long(as_property) )
	
	IF as_property = "1" THEN
		this.selectedTab = 1
	END IF
		
	
	//function for making the thing a tab
	ltpg_tab.text = as_value
	IF il_tabBackColor > -1 THEN
		ltpg_tab.tabbackcolor = this.il_tabBackColor
		ltpg_tab.backcolor = this.il_tabBackColor
	END IF
	
	IF il_tabTextColor > -1 THEN
		ltpg_tab.tabTextColor = long( il_tabTextColor )
	END IF
	
ELSEIF as_property = "tabbackcolor" THEN
	li_max = upperBound( this.control )
	il_tabBackColor = long( as_value )
	
	FOR li_index = 1 TO li_max
		IF isValid( this.control[li_index] ) THEN
			ltpg_tab = this.control[li_index]
			ltpg_tab.tabbackColor = long( as_value )
			ltpg_tab.backcolor = long( as_value) 
		END IF
	NEXT
	
ELSEIF as_property = "tabtextcolor" THEN
	this.il_tabTextColor = long( as_value )
	li_max = upperBound( this.control )
	il_tabTextColor = long( as_value )
	
	FOR li_index = 1 TO li_max
		IF isValid( this.control[li_index] ) THEN
			ltpg_tab = this.control[li_index]
			ltpg_tab.tabTextColor = long( as_value )
		END IF
	NEXT
ELSE
	
	li_return = -1
END IF

return li_return
end function

public function integer of_settabpagebackcolor (long al_color);il_tabBackColor = al_Color

Return 1
end function

public function integer of_settabpagetextcolor (long al_color);il_tabTextColor = al_Color

Return 1
end function

public function integer of_setdragservice (boolean ab_switch);// turn on drag service since this was created dynamically
Integer	li_Return = NO_ACTION

//Check arguments
If IsNull(ab_switch) Then
	li_Return = FAILURE
ELSEIF ab_Switch THEN
	IF IsNull(inv_DragService) Or Not IsValid (inv_DragService) THEN
		inv_DragService = Create n_cst_dragService_Dw
		inv_DragService.of_SetRequester ( THIS )
//		inv_dragService.of_SetIndicatorMode("HAND")
		li_Return = SUCCESS
	END IF
ELSE 
	IF IsValid (inv_DragService) THEN
		Destroy inv_DragService
		Return SUCCESS
	END IF	
END IF

Return li_Return
end function

public function integer of_settabtext (powerobject apo_object, string as_text);// searches for the tab page where the reference to its oobject is the same as
//the passed in object, If they match the text of the tabpage becomes as_text
//returns 1 if it sets it, 0 otherwise
Int 	li_index
Int	li_max

PowerObject	lpo_object
u_dw			ldw_dw
u_tabPg  	ltpg_page

li_max = upperBound( this.control )

FOR li_index = 1 TO li_max
	IF isValid( this.control[li_index] ) THEN
		ltpg_page = this.control[li_index]
		
		lpo_object = ltpg_page.of_getObject( )

		IF isValid ( lpo_object ) AND apo_object = lpo_object THEN
			ltPg_page.text = as_text
			return 1
		END IF
	END IF

NEXT

return 0
end function

private function boolean of_isadminmode ();Boolean		lb_AdminMode
w_Master		lw_Win

w_Sheet_DynamicControl	lw_Dynamic

//Get Parent Mode (Admin or Dispatch)
IF This.GetParent().ClassName() = "w_sheet_dynamiccontrol" THEN
	lw_Dynamic = This.GetParent()
	lb_AdminMode = lw_Dynamic.of_GetAdminMode()
ELSEIF This.GetParent().Typeof() = Window! THEN //Logic for subwindows
	lw_Win = This.GetParent()
	IF lw_Win.ParentWindow().ClassName() = "w_sheet_dynamiccontrol" THEN
		lw_Dynamic = lw_Win.ParentWindow()
		lb_AdminMode = lw_Dynamic.of_GetAdminMode()
	END IF
END IF
	
Return lb_AdminMode
end function

public function boolean of_isdynamiccontrol ();/***************************************************************************************
NAME: 	of_isDynamicControl	

ACCESS:		private	
		
ARGUMENTS: 	(none)
					

RETURNS:		Boolean

DESCRIPTION:   
				Returns True if u_tab is currently a dynamic control
				Returns False if u_tab is not a dynamic control


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 4-13-06
	

***************************************************************************************/
Return il_Instance > 0 AND Len(is_ObjectName) > 0
end function

event rightclicked;call super::rightclicked;/***************************************************************************************
NAME: 		rightclicked

ACCESS:		public	
		
ARGUMENTS: 		
							default
RETURNS:			none
	
DESCRIPTION:  A right click on the tab will give a menu of things that the user
					can do if they have the permissions to do them.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan ANd Maury 10-18-2005
	

***************************************************************************************/

String 	ls_result 
n_cst_privileges	lnv_priv  

int		li_length
String	ls_message
String 	lsa_parm_labels[]
Any		laa_parm_values[] 

int		li_result
Window	lw_parent
u_dw		ldw_Ref
w_Child	lw_Ref

PowerObject lpo_Ref
u_tabPg		luo_TabPg
Boolean		lb_DynamicControl
Boolean		lb_DisplayMenu

lb_DynamicControl = This.of_isDynamicControl()
IF lb_DynamicControl THEN
	//Check if admin mode is on
	lb_DisplayMenu = This.of_isAdminMode() 
	
	//If in admin mode, do not allow menu on child window controls
	//Unless 'super admin' mode key sequence is pressed
	IF lb_DisplayMenu THEN
		IF This.GetParent().ClassName() <> "w_sheet_dynamiccontrol" THEN //child window control
			//Unless user is holding down 'super admin' key sequence
			IF NOT KeyDown( KeyF2! ) THEN
				lb_DisplayMenu = FALSE
			END IF
		END IF	
	END IF
END IF

//Disable menu when object is dynamic and displaymenu is false
IF lb_DynamicControl THEN
	
	IF NOT lb_DisplayMenu THEN
		//Do not display any menus
	ELSE
	
		//if it was dynamically created
		IF len( is_objectName ) > 0 AND il_instance > 0 THEN
			IF lnv_priv.of_dynamic_createabstract( ) THEN
				li_length = upperBound ( lsa_parm_labels )
				lsa_parm_labels[li_length + 1] = "ADD_ITEM"
				laa_parm_values[li_length + 1] = "Properties"
			END IF
			
			IF lnv_priv.of_dynamic_createInstance( ) THEN
				li_length = upperBound ( lsa_parm_labels )
				lsa_parm_labels[li_length + 1] = "ADD_ITEM"
				laa_parm_values[li_length + 1] = "Close Tab"
			END IF
			
			IF lnv_priv.of_dynamic_deleteabstract( )  AND  is_ObjectName <> "Tab Template" THEN
				li_length = upperBound ( lsa_parm_labels )
				lsa_parm_labels[li_length + 1] = "ADD_ITEM"
				laa_parm_values[li_length + 1] = "-"
				lsa_parm_labels[li_length + 2] = "ADD_ITEM"
				laa_parm_values[li_length + 2] = "Save Tab Definition"
			END IF
			
			IF lnv_priv.of_dynamic_createabstract( ) THEN
				li_length = upperBound ( lsa_parm_labels )
				lsa_parm_labels[li_length + 1] = "ADD_ITEM"
				laa_parm_values[li_length + 1] = "Save Tab Definition As"
			END IF
			
			
			IF  lnv_priv.of_dynamic_createInstance( ) THEN
				li_length =upperBound( lsa_parm_labels )
				lsa_parm_labels[li_length + 1] = "ADD_ITEM"
				laa_parm_values[li_length + 1] = "-"
				lsa_parm_labels[li_length + 2] = "ADD_ITEM"
				laa_parm_values[li_length + 2] = "Remove Object"
			END IF
			
			
			ls_result = f_pop_standard(lsa_parm_labels, laa_parm_values)
				
			IF ls_result = "PROPERTIES" THEN
			
				this.event ue_propertiesdialog( )
				
				
			//Removes a tab page and makes the reference visible	
			ELSEIF ls_result = "CLOSE TAB" THEN
				IF index < 1 THEN
					//index = This.Event getselection( )//comment by liulihua
				END IF
				IF index > 0 THEN
					IF isValid(This.Control[index]) THEN
						IF this.Control[index].className() = "u_tabpg" THEN
							luo_TabPg = This.Control[index]
							lpo_Ref = luo_TabPg.of_GetObject()
							
							IF isValid(lpo_Ref) THEN
								IF lpo_Ref.TypeOf() = DataWindow! THEN
									ldw_Ref = lpo_Ref
									ldw_Ref.Visible = TRUE
								ELSEIF lpo_Ref.TypeOf() = Window! THEN
									lw_Ref = lpo_Ref
									lw_Ref.Visible = TRUE
								END IF
							END IF
						END IF
						This.CloseTab( This.Control[index] )
						This.SelectedTab = UpperBound(This.Control) //Set the selected tab to the last tab in the control
						
					END IF
				END IF
				
			//removes the tab from the page and puts it in the remove buffer	
			ELSEIF ls_result = "REMOVE OBJECT" THEN
				This.Event ue_RemoveObject( )
				
			//save the definition of the tab	
			ELSEIF ls_result = "SAVE TAB DEFINITION" THEN
				This.Event ue_saveDefinition( )
			
			//save as a new kind of tab
			ELSEIF ls_result = "SAVE TAB DEFINITION AS" THEN
				This.Event ue_saveDefinitionAs( )
			END IF
		END IF
		
	END IF
	
END IF //end if lb_dynamiccontrol
end event

event selectionchanged;call super::selectionchanged;/***************************************************************************************
NAME: 			selectionChanged

ACCESS:			public
		
ARGUMENTS: 		
							default

RETURNS:			default
	
DESCRIPTION:  When the tab is changed it makes the reference of the oldindex become
					invisible, and the reference of the page at the newIndex visible.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 10-17-2005
	

***************************************************************************************/

u_dw		ldw_dw
w_master	lw_window
u_tabpg 	ltpg_page
PowerObject	lpo_object

IF NOT isNull( is_parentName ) THEN
	
	IF oldindex > 0 THEN
		IF this.control[newIndex].className() = "u_tabpg" THEN
			ltpg_page = this.control[ oldIndex ]
			lpo_object = ltpg_page.of_getObject( )
			
			
			//make newIndex ref invisible
			IF isValid( lpo_object ) THEN
				IF typeOf( lpo_object ) = datawindow! THEN
					ldw_dw = lpo_object
					ldw_dw.visible = false	
					
				ELSEIF typeOF ( lpo_object ) = window! THEN
					lw_window = lpo_object
					lw_window.visible = false
				END IF
				
			END IF
		END IF
	END IF

	
	//make newIndex ref visible
	IF newIndex > 0 THEN
		IF this.control[newIndex].className() = "u_tabpg" THEN
			ltpg_page = this.control [ newIndex ]
			lpo_object = ltpg_page.of_getObject( )
			
			IF isValid( lpo_object ) THEN
				IF typeOf( lpo_object ) = datawindow! THEN
					ldw_dw = lpo_object
					ldw_dw.visible = true			
				ELSEIF typeOF ( lpo_object ) = window! THEN
					lw_window = lpo_object
					lw_window.visible = true
				END IF
				
			END IF
		END IF
	END IF
	ib_selectionChanged = true
END IF

end event

event clicked;call super::clicked;u_dw			ldw_ref
w_master		lw_ref
Long			ll_controlMax
PowerObject	lpo_object
U_tabPg		luo_page


//logic for dragservice
IF isValid(inv_dragService) THEN
	 inv_dragService.post of_Clicked(0 , 0)		//just there because it should be, no functional purpose
	
END IF

//if not clicked on a tab, make the reference to the page go invisible and make the current
//selected no longer the current selected.
IF index = -1 AND NOT ib_selectionChanged THEN
	ll_controlMax = UpperBound( this.control )
	IF this.selectedTab > 0 AND  ll_controlMax > 0 THEN
		IF this.selectedTab <= ll_controlMax THEN 
			IF isValid( this.control[this.selectedTab] ) THEN
				IF this.control[this.selectedTab].className() = "u_tabpg" THEN
					luo_page = this.control[this.selectedTab]
					
					lpo_object = luo_page.Of_getObject()
					
					IF isValid( lpo_object ) then
						IF lpo_object.typeoF() = dataWindow! THEN
							ldw_ref = lpo_object
							ldw_ref.visible = false
						ELSEIF lpo_object.typeOf() = window! THEN
							lw_ref = lpo_object
							lw_ref.visible = false
						END IF
					end if
				END IF
			END IF
		END IF
	END IF
	
	this.selectedtab = 0
ELSE
	IF this.selectedTab > 0 THEN
		IF isValid( this.control[this.selectedTab] ) THEN
			IF this.control[this.selectedTab].className() = "u_tabpg" THEN
				luo_page = this.control[this.selectedTab]
				
				lpo_object = luo_page.Of_getObject()
				
				IF isValid( lpo_object ) then
					IF lpo_object.typeoF() = dataWindow! THEN
						ldw_ref = lpo_object
						ldw_ref.visible = true
					ELSEIF lpo_object.typeOf() = window! THEN
						lw_ref = lpo_object
						lw_ref.visible = true
					END IF
				end if
			END IF
		END IF
	END IF
END IF
ib_selectionChanged = false

end event

event destructor;call super::destructor;destroy inv_dragService

end event

event key;call super::key;//Resize the tab
IF KeyDown( KeyShift! ) THEN			
	IF KeyDown( KeyLeftArrow! ) AND this.width > 110 THEN		//shift and leftkey shrinks width
		This.width -= 20
	ELSEIF KeyDown( KeyRightArrow! ) THEN  //shift and Rightkey makes it wider
		This.width += 20
	END IF
	IF KeyDown( KeyUpArrow! ) AND this.height > 110 THEN  //shift and upkey shrinks height
		This.height -= 20

	ELSEIF KeyDown( KeyDownArrow! )THEN  //shift and downkey makes height bigger
		This.height += 20
	END IF
END IF



end event

event selectionchanging;call super::selectionchanging;//u_dw			ldw_ref
//w_master		lw_ref
//PowerObject	lpo_object
//U_tabPg		luo_page
//
IF keyDown( KeyShift! ) AND not isNUll( is_objectName ) THEN
	return 1
END IF



end event

on u_tab.create
this.dynamicdescriptionarea_1=create dynamicdescriptionarea_1
end on

on u_tab.destroy
call super::destroy
destroy(this.dynamicdescriptionarea_1)
end on

event dragdrop;call super::dragdrop;IF source = this THEN
	this.event ue_dropnotify( this )
END IF
end event

type dynamicdescriptionarea_1 from dynamicdescriptionarea within u_tab descriptor "pb_nvo" = "true" 
event create ( )
event destroy ( )
end type

on dynamicdescriptionarea_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dynamicdescriptionarea_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

