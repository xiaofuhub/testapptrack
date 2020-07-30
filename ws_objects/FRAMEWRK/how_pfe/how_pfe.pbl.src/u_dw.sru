$PBExportHeader$u_dw.sru
$PBExportComments$Extension DataWindow class
forward
global type u_dw from ofr_u_dw
end type
end forward

global type u_dw from ofr_u_dw
integer width = 448
integer height = 280
event syscommand pbm_syscommand
event ue_export ( )
event type integer ue_autofind ( )
event type integer ue_autosort ( )
event type integer ue_autofilter ( )
event type integer ue_setfocusindicator ( readonly boolean ab_switch )
event type integer ue_dropnotify ( dragobject adrg_target,  long al_row,  dwobject adwo_dwo,  n_cst_dragservice anv_targetdragservice )
event ue_setdragicon ( )
event ue_setidentifiers ( string as_objectname,  long al_objectinstance )
event ue_setdynpropmansrvc ( n_cst_bso_dynamicobjectmanager anv_propmanager )
event ue_hasids ( )
event ue_setproperty ( )
event ue_setparentname ( string as_parentname )
event ue_savedynamicproperties ( integer ai_mode )
event type integer ue_linkdialog ( )
event type integer ue_applylinkdialog ( )
event type integer ue_propertiesdialog ( )
event type integer ue_savedefinition ( )
event type integer ue_savedefinitionas ( )
event type integer ue_reload ( )
event type datastore ue_getcacheds ( )
event type integer ue_tabdialog ( )
event ue_restrict ( n_cst_restrictioncriteria anv_data,  u_dw_quickmatch adw_qm )
event ue_clearrestriction ( string as_dwtype )
end type
global u_dw u_dw

type prototypes


end prototypes

type variables
Public:

Constant int	ci_DisplayNameStyle_ColumnName = 0
Constant int 	ci_DisplayNameStyle_DBName = 1
Constant int	ci_DisplayNameStyle_Header = 2

Constant int	ci_SortStyle_System = 0
Constant int	ci_SortStyle_DragDrop = 1
Constant int	ci_SortStyle_Single = 2
Constant int	ci_SortStyle_Multi = 3

Constant int	ci_FilterStyle_System = 0
Constant int	ci_FilterStyle_Extended = 1
Constant int	ci_FilterStyle_Simple = 2
//paste
	n_cst_dragService_dw 	inv_dragService 
	String						is_ObjectName
	String						is_parentName
	String						is_borderStyle

	String						is_FilterDef
	Long							il_InstanceNum
	Long							il_minimumTimeBetweenReloadsForSQL =0	//the amount of time that must pass
																						//in seconds before this datawindow
																						//will do a sql retrieve
	
	Constant String 						cs_myType = "datawindow"
	Constant	int							ci_sql = 1
	Constant int							ci_cache = 2
	Constant int							ci_linkage = 3
	Constant string						cs_retrieveButton = "b_retrieve"
	n_cst_bso_dynamicObjectManager	inv_myPropManager
	n_cst_dwsrv_MouseOver				inv_MouseOver
	n_cst_dwsrv_restrict					inv_restriction
	
//paste
Private :
Boolean	ib_Insertable = TRUE
Boolean	ib_Deleteable = TRUE
Boolean	ib_AutoFind = FALSE
Boolean   ib_AutoSort = FALSE
Boolean 	ib_AutoFilter = FALSE

Boolean	ib_Linkable	 = FALSE
Boolean	ib_AllowProperties = FALSE
Boolean	ib_AllowSaveDefinition = FALSE
Boolean	ib_AllowSaveDefinitionAs = FALSE
Boolean	ib_AllowRemoveObject = FALSE
Boolean	ib_AllowTabPage = FALSE
Boolean	ib_isRestrictable = FALSE
Boolean	ib_Reloadable = TRUE

String	is_invalidDataobjectPath

Time		it_lastReload

u_p_FocusIndicator	ip_FocusIndicator
U_Tab		iTaba_tab[]


end variables

forward prototypes
public function integer of_setdeleteable (boolean ab_switch)
public function integer of_setinsertable (boolean ab_switch)
public function integer of_setautofind (boolean ab_switch)
public function integer of_setautosort (boolean ab_switch)
public function integer of_setautofilter (boolean ab_Switch)
public function long of_gettoprow ()
public function integer of_setproperty (string as_property, string as_value)
public function string of_getobjname ()
public function long of_getobjinstance ()
public function string of_getparentname ()
public function long of_getbottomrow ()
public function string of_getmytype ()
public function integer of_setmouseover (boolean ab_switch)
public function integer of_setlinkable (boolean ab_switch)
public function integer of_allowproperties (boolean ab_switch)
public function integer of_setdragservice (boolean ab_switch)
public function integer of_allowsavedefinition (boolean ab_switch)
public function integer of_allowsavedefinitionas (boolean ab_switch)
public function integer of_allowremoveobjet (boolean ab_switch)
public function integer of_setprefilter (string as_prefilter)
public function integer of_prefilter ()
public function integer of_dogrouprowcalculation ()
public function integer of_setabsprefilter (string as_absprefilter)
public function integer of_allowtabpage (boolean ab_switch)
public function integer of_settab (u_tab atab_tab)
public subroutine of_gettab (ref u_tab ataba_tab[])
public function integer of_setrestriction (boolean ab_switch)
public function integer of_setrestrictable (boolean ab_switch)
public function integer of_setreload (boolean ab_switch)
public function boolean of_isadminmode ()
public function boolean of_isdynamiccontrol ()
public function long of_calculateseconds (string as_time)
public function integer of_getretrievetype ()
public function integer of_showrefreshstatus (boolean ab_resetstatus)
public function boolean of_istimetorefresh ()
public function string of_getdefinitionprefilter ()
public function string of_getuniqueprefilter ()
public function integer of_focusindicatoron ()
end prototypes

event syscommand;//Intercept user close request for a popup dw, and perform validation.
//If validation fails, reject close and set focus.

Constant ULong USERCLOSE = 61536
Long	ll_Return

IF CommandType = USERCLOSE THEN

	Constant Boolean	lb_FocusOnError = TRUE
	IF This.Event pfc_AcceptText ( lb_FocusOnError ) = FAILURE THEN
		ll_Return = 1  //Reject Action
	END IF

END IF

RETURN ll_Return
end event

event ue_export;This.SaveAs ( )
end event

event ue_autofind;int li_rc = FAILURE

IF ib_AutoFind THEN
	IF of_SetFind ( TRUE ) = SUCCESS THEN		
		inv_Find.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_Header )
		li_rc = SUCCESS
	END IF
ELSE 
	li_rc = NO_ACTION 
END IF

RETURN li_rc
end event

event ue_autosort;int li_rc = FAILURE

IF ib_AutoSort THEN
	IF of_SetSort ( TRUE ) = SUCCESS THEN		
		inv_Sort.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_Header )
		inv_Sort.of_SetStyle ( ci_SortStyle_Multi  )
		inv_sort.of_SetColumnHeader ( TRUE )
		inv_Sort.of_SetVisibleOnly ( TRUE )
		inv_Sort.of_SetUseDisplay ( TRUE )
		li_rc = SUCCESS
	END IF
ELSE 
	li_rc = NO_ACTION 
END IF

RETURN li_rc


end event

event ue_autofilter;int li_rc = FAILURE

IF ib_AutoFilter THEN
	IF of_SetFilter ( TRUE ) = SUCCESS THEN		
		inv_Filter.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_Header )
		inv_Filter.of_SetStyle ( ci_FilterStyle_Simple  )
		inv_Filter.of_SetVisibleOnly ( TRUE )
		li_rc = SUCCESS
	END IF
ELSE 
	li_rc = NO_ACTION 
END IF

RETURN li_rc


end event

event type integer ue_setfocusindicator(readonly boolean ab_switch);//Instantiate or destroy the focus indicator, according to ab_Switch.
//The decendant instance must have a window parent for this to succeed.
//It may be possible to check the parent's parent, but I'm not going to get into that for now.

//Returns:  FAILURE, NO_ACTION (requested state already set), SUCCESS

Window	lw_Target
Integer	li_Return = FAILURE

IF Parent.TypeOf ( ) = Window! THEN
	//We must be on a window to dynamically create the user object

	lw_Target = Parent

	IF ab_Switch = TRUE THEN

		IF IsValid ( ip_FocusIndicator ) THEN
			li_Return = NO_ACTION
		
		ELSE
			lw_Target.OpenUserObject ( ip_FocusIndicator, This.x + 16, This.y + 16 )
			This.SetRowFocusIndicator ( ip_FocusIndicator )
			li_Return = SUCCESS
		
		END IF

	ELSE

		IF NOT IsValid ( ip_FocusIndicator ) THEN
			li_Return = NO_ACTION

		ELSE
			lw_Target.CloseUserObject ( ip_FocusIndicator )
			li_Return = SUCCESS

		END IF

	END IF

END IF


RETURN li_Return
end event

event type integer ue_dropnotify(dragobject adrg_target, long al_row, dwobject adwo_dwo, n_cst_dragservice anv_targetdragservice);/***************************************************************************************
NAME: 			ue_dropNotify

ACCESS:			Public
		
ARGUMENTS: 		
							(dragobject, long, dwobject, n_cst_dragservice)

RETURNS:			integer
	
DESCRIPTION:	this method was called by the of_dragDrop of the service object that
	belongs to the object that this was dropped on.  The arguments at this point
	are all valid only if this was droppped on another datawindow, otherwise, 
	al_row and adwo_dwo are null, and so far we don't know what to do with it.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :	Dan and Maury	7-29-05
	

***************************************************************************************/




IF isNull(al_row) OR isNull(adwo_dwo) THEN
	//this was not dropped on a datawindow
ELSE 
	//this was dropped on a datawindow,
	// AND I HAVE ALL THE INFO!!!!
END IF

return 1
end event

event ue_setdragicon();//overridden by descendents with logic to choose their own
//drag icons based on the data they have
end event

event ue_setidentifiers(string as_objectname, long al_objectinstance);is_ObjectName = as_objectName
il_instanceNum   = al_objectInstance
String	lsa_temp[]

this.HScrollBar = True
this.HSplitscroll = true


//---hide and show right clickable menu buttons on dynamic creation.

//if this object is not a template then we can delete them
//and link them.
IF NOT inv_myPropManager.of_isdeletableobject( as_objectName ) THEN
	this.of_allowsavedefinition( false )
	this.of_setlinkable( false )

ELSE
	this.of_allowsavedefinition( true )
	this.of_setlinkable( true )

END IF


this.of_allowsavedefinitionas( true )
this.of_allowproperties( true )
this.of_allowremoveobjet( true )
this.of_allowtabpage( true )
this.of_setdeleteable( false )
this.of_setinsertable( false )
this.of_setRestrictable( TRUE )

of_setrestriction(TRUE)

//turn on filter and sort services as they are created dynamically
This.of_SetFilter ( TRUE )

IF IsValid ( This.inv_Filter ) THEN
	This.inv_Filter.of_SetStyle ( 2 )  //1, 2
	this.inv_filter.of_setVisibleonly( FALSE )
END IF

This.of_SetSort ( TRUE )

IF IsValid ( This.inv_Sort ) THEN
	This.inv_Sort.of_SetStyle ( 0 )  //1, 2, 3
END IF
end event

event ue_setdynpropmansrvc(n_cst_bso_dynamicObjectManager anv_propmanager);inv_myPropManager = anv_PropManager
end event

event ue_hasids();//If this event exists, then this object has the functions 
//getObjName, and getObjInstance


end event

event ue_setproperty();//is here for trigger event
end event

event ue_setparentname(string as_parentname);is_parentName = as_parentName
end event

event ue_savedynamicproperties(integer ai_mode);/***************************************************************************************
NAME: 	ue_saveAsAbstact		

ACCESS:			public
		
ARGUMENTS: 		
							ai_mode: the mode of saving, legal values are 1, 2, and 3

RETURNS:			none
	
DESCRIPTION:	This event can be triggered to save instances as well as abstracts, based
					on three different modes.  
					
					Mode 1:  Sends all of the properties of this instance to the service object.
								The service object will save the property to the database, with
								user name & instance number not equal to null, and parent specified
								if this object has a container, and null if it doesn't.
					
					Mode 2:	Sends all of the abstract properties to the service object to be
								saved to the database.  The service object will know whether or not
								it is saving this object as a new abstract object, or if it is overwriting
								the old one.  Either way it is saved with null parent name, user name, and
								instance number.
								
					Mode 3:	Sends all of the information to the service object to save this object
								to the Database as an abstract definition of the u_dw for the abstract
								definition  of the parent.  In other words, it stores it with null userName,
								but non-null instance number and non null parent name.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created  By Dan 8-19-2005
	

***************************************************************************************/


String 	ls_sort
String	ls_filter
String	ls_indicator
String	ls_dragScroll
String	ls_myClassName
String	ls_dataobject
int		li_result

Long	ll_Handle
Long	ll_State
Long	ll_MinPositionX
Long	ll_MinPositionY
Long	ll_NormalPositionTop
Long	ll_NormalPositionLeft
Long	ll_NormalPositionRight
Long	ll_NormalPositionBottom

Constant Long	WPF_SETMINPOSITION = 1

s_WindowPlacement	lstr_WinPlacement


li_result = 1

ls_myClassName = this.className()


//unique to datawindows
ls_filter = This.Describe("datawindow.table.filter")
ls_sort = This.Describe("datawindow.table.sort")


IF this.borderStyle = stylebox! THEN
	is_borderstyle = "stylebox"
ELSEIF this.borderStyle = stylelowered! THEN
	is_borderstyle = "stylelowered"
ELSEIF this.borderstyle = styleRaised! THEN
	is_borderstyle = "styleraised"
ELSEIF this.borderStyle = styleshadowbox! THEN
	is_borderstyle = "styleshadowbox"
END IF


IF ai_mode = 1 OR ai_mode = 2 OR ai_mode = 3 THEN

	// When saving a datawindow as a user object, it must have a valid parent name. If it doesn't,
	// than its properties should not be saved.  THe function of_saveToMode will return -1 if it fails
	//	to insert the first value as a result of this object being a datawindow with an invalid parentName.
	// If we fail on that first attempt, we know that we don't need to attempt the rest.
	IF ai_Mode = 1 AND isValid(inv_myPropManager) THEN
		//width
		li_result = inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "width", string(this.width), ls_myClassName, cs_myType)
	
	// For save mode 2, saving as an abstract, we don't need to know if the parent is valid because abstracts do 
	// not have parents values.  
	
	// For save mode 3, saving as a child, the fact that this thing is being saved as a child garantees that its
	// parent object exists and has already saved itself successfully, so we don't have to worry about the parent 
	// value.
	ELSEIF isValid(inv_myPropManager) THEN
		//width
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "width", string(this.width), ls_myClassName, cs_myType)
		li_result = 1
		
	END IF	
	
	// If li_result = 1 then we know it is safe to send the rest of the properties to the service object.
	IF li_result = 1 AND isValid(inv_myPropManager) THEN
		//height
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "height", string(this.height), ls_myClassName, cs_myType)
		//title
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "title", this.title, ls_myClassName, cs_myType)
		//titlebar
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "titleBar", string(this.titleBar), ls_myClassName, cs_myType)
		//resizable
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "resizable", string(this.resizable), ls_myClassName, cs_myType)
		//border
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "border", string(this.border), ls_myClassName, cs_myType)
		//controlmenu
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "controlmenu", string(this.controlMenu), ls_myClassName, cs_myType)
		
		IF IsValid ( inv_DragService ) THEN
			ls_indicator = inv_dragService.of_getindicatormode()
			ls_dragScroll = string(inv_dragService.of_getDragScrollMode())
			//dragscroll
			inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "dragscroll", ls_dragScroll, ls_myClassName, cs_myType)
			//focus indicator
			inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "indicator", ls_indicator, ls_myClassName, cs_myType)
		ELSE
			//dragscroll
			inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "dragscroll", "false", ls_myClassName, cs_myType)
		END IF
		
		//dataobject
		IF this.dataobject = "d_generic" AND this.RowCount() > 0 THEN
			//if this is true then it is because an invalid dataobject path was set on this object. We don't
			//actually want to save that to the database, we still want to save the invalid one so that we don't 
			//lose track of what it was suppose to be.
			ls_dataobject = is_invaliddataobjectpath
		ELSE
			ls_dataObject = this.dataobject
		END IF
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "dataobject", ls_dataObject, ls_myClassName, cs_myType)

		//borderstyle
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "borderstyle", is_borderStyle, ls_myClassName, cs_myType)
		
		//added by dan 3-7-06, timed refresh refresh rate if this datawindow does a sql retrieval.
		//timed sql refresh rate
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "sqlrefreshmintime", string(il_minimumtimebetweenreloadsforsql) , ls_myClassName, cs_myType )

		//inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "visible", string(this.visible), ls_myClassName, cs_myType)
		
		//when filter and sort is not set, describe returns results that we don't want to save.
		IF ls_sort <> "?" AND ls_sort <> "!" THEN
			//sort
			inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "sort", ls_sort, ls_myClassName, cs_myType)
		ELSE
			
		END IF
		
		IF ls_filter <> "?" AND ls_filter <> "!" THEN
			//filter
			inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "filter", ls_filter, ls_myClassName, cs_myType)
		ELSE
			//this has to be there to clear a watchlist filter
			inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "filter", "", ls_myClassName, cs_myType)
		END IF
		
		//X
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "X", string(this.X), ls_myClassName, cs_myType)
		//Y
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, "Y", string(this.Y), ls_myClassName, cs_myType)
	
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

		
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, inv_MyPropManager.cs_state, String(ll_State), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, inv_MyPropManager.cs_minposx, string(ll_MinPositionX), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, inv_MyPropManager.cs_minposy, string(ll_MinPositionY), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, inv_MyPropManager.cs_NormalPosTop , string(ll_NormalPositionTop), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, inv_MyPropManager.cs_NormalPosLeft , string(ll_NormalPositionLeft), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, inv_MyPropManager.cs_NormalPosRight , string(ll_NormalPositionRight), ls_myClassName, cs_myType)
		inv_myPropManager.of_saveToMode(ai_mode, is_ObjectName, il_instanceNum, is_parentName, inv_MyPropManager.cs_NormalPosBottom , string(ll_NormalPositionBottom), ls_myClassName, cs_myType)
		
END IF
ELSE
	// invalid mode entered.
	
END IF




end event

event type integer ue_linkdialog();Integer	li_Return
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm


lstr_Parm.is_Label = "MASTERDW"
lstr_Parm.ia_value = This
lnv_Msg.of_add_parm( lstr_Parm )

lstr_Parm.is_Label = "PARENTWINDOW"
lstr_Parm.ia_value = This.GetParent()
lnv_Msg.of_add_parm( lstr_Parm )


//Open Link Dialog box and pass This as the parm to hold the Master
IF NOT IsValid ( w_DwLink ) THEN
	OpenWithParm(w_DwLink, lnv_Msg, This.GetParent())
ELSE
	w_DwLink.SetFocus ( )
	li_Return = 1
END IF

Return li_Return
end event

event type integer ue_applylinkdialog();Integer	li_Return

n_cst_msg	lnv_Msg
s_Parm		lstr_Parm


lstr_Parm.is_Label = "MASTERDW"
lstr_Parm.ia_value = This
lnv_Msg.of_add_parm( lstr_Parm )

lstr_Parm.is_Label = "PARENTWINDOW"
lstr_Parm.ia_value = This.GetParent()
lnv_Msg.of_add_parm( lstr_Parm )


//Open Link Dialog box and pass This as the parm to hold the Master
IF NOT IsValid ( w_DwApplyLink ) THEN
	OpenWithParm(w_DwApplyLink, lnv_Msg , This.GetParent())
ELSE
	w_DwApplyLink.SetFocus ( )
	li_Return = 1
END IF

Return li_Return
end event

event type integer ue_propertiesdialog();Integer	li_Return = 0

//Open Properties Dialog box and pass This as the parm to hold the Master
IF NOT IsValid ( w_DwProperties ) THEN
	OpenWithParm(w_DwProperties, This, This.GetParent())
	li_Return = 1
ELSE
	w_DwProperties.SetFocus ( )
	li_Return = 1
END IF

Return li_Return
end event

event type integer ue_savedefinition();Integer	li_Save
Integer	li_Return
String	ls_string
String	ls_Name

ls_Name = This.of_GetObjName()

li_Save = Messagebox("Save Definition", "Save Definition for '" + ls_Name + "' ?", Question! , OKCancel!) 

IF li_Save = 1 THEN
	
	li_Return = inv_MyPropManager.of_SaveAbsdef( This , 0 , ls_Name, ls_string)
	
	IF li_Return = 1 THEN
		MessageBox("Definition Saved" , "'"+ ls_Name + "' Definition Saved.")
	ELSE
		MessageBox("Error Saving!", "Error Saving Definition for '" + ls_Name + "'")
	END IF
	
END IF

Return li_Return
end event

event type integer ue_savedefinitionas();Integer	li_Return

//Open Save Definition As Window and pass This as the parm to hold the This
IF NOT IsValid ( w_SaveDefinitionAs ) THEN
	
	li_Return = OpenWithParm(w_SaveDefinitionAs, This, This.GetParent())
ELSE
	w_SaveDefinitionAs.SetFocus ( )
	li_Return = 1
END IF

Return li_Return
end event

event type integer ue_reload();/***************************************************************************************
NAME: 	ue_reload	

ACCESS:		public	
		
ARGUMENTS: 		
							none

RETURNS:			integer
	
DESCRIPTION:   Gets the correct cash and refreshes itself with the updated cache
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : dan and maury 7-29-05
	

***************************************************************************************/


Datastore 	lds_Cache
String		ls_select
String		ls_oldFilter
Long			ll_RowCount
Long 			ll_row
Long 			ll_topRow
Long 			ll_rowClicked
Long			ll_lastRow
Long			ll_lastTimeInSecs
Long			ll_currentSeconds
int			li_retrieveType

String		ls_currentTime
String		lsa_argDataTypes[]
String		lsa_argNames[]

Integer	li_Return = 1
u_dw 			ldw_Master

IF ib_Reloadable THEN

	//find out if the dataobject has a select statement or not
	ls_select = describe("datawindow.table.select")
	
	li_retrieveType = this.of_getRetrievetype( )
	
	//edited out by dan after I wrote the above function
//	IF ls_select = "?" OR ls_select = "!" THEN
//		
//		ls_select = ""
//	END IF
	
	
	//preservation of old filter just in case any prefiltering is done.
	ls_oldFilter = this.describe( "datawindow.table.filter" )		
	this.of_setBase( true )
	
	
	ll_row = this.getRow()					//preservation of current row
	ll_rowClicked = ll_row					
	ll_toprow = this.of_getTopRow()		//gets the top visible row
	ll_lastRow = this.of_getBottomRow()
	this.setRedraw(FALSE)
	
	
	//-----
	// if the length lof ls_select is greater than 0 then we know its a retrieval.
	// If the number of args is 0 then we do nothing, linkage should take care of it, or
	// the dataobject will have a button to manually prompt for args.
	
	IF li_retrieveType <> ci_cache THEN
		IF li_retrieveType = ci_sql THEN
			//----------------------------
			//The following logic was added 3-7-06 to prevent SQL retrievals from going every time
			//the dynamic window refreshes.  
			IF this.dataobject <> "d_generic" THEN
				this.retrieve()
				commit;
			END IF
			it_lastreload = Now()
//				//reset the possible refresh to not missing a refresh
			this.of_showrefreshstatus( true )

			/////////////////////////////////
			li_return = 1		
		ELSE								
			li_return = 1
			//linkage or manual prompte for args
		END IF
		
	ELSE														//refresh from cache
		
		lds_Cache = This.EVENT ue_GetCacheDs ( )
	
		IF IsValid ( lds_Cache ) THEN
			
			ll_rowcount = lds_Cache.rowcount()
			
			//this way there are no duplicate rows
			This.Reset()
			
			lds_Cache.RowsCopy ( 1, ll_RowCount, Primary!, This, 1, Primary! )
			//lds_Cache.resetUpdate()
			this.resetUpdate()
		
		ELSE
			
			li_Return = -1
			
		END IF
	
	END IF		
	
	
	//prefiltering, followed by normal filtering, followed by sort, then group calc
	
	This.of_PreFilter()
	IF ls_oldFilter <> "?" AND ls_oldFilter <> "!" THEN
		this.setFilter( ls_oldFilter )
	ELSE
		this.setFilter( "" )
	END IF
	this.filter()
	this.sort()
	this.GroupCalc()
	
	//calculates the row to scroll to
	//if the toprow is the first row that can be displayed, then
	//scrolling isn't necessary,
	//otherwise, ll_row = ll_row - difference between current row and top row
	//the difference between them = ll_row -ll_topRow
	IF ll_topRow = 1 THEN		
			ll_row =0      
		ELSE
			ll_row = ll_topRow
	END IF
	
	
	//before scrolling to the row desired, it is necessary to scroll
	//to the last row no the page first, to fix the problem of having
	//not scrolled at all, when the drop row clicked on is in the original view
	//of the data window
	This.scrolltoRow(ll_lastRow)
	THIS.scrolltoRow(ll_row)		//sets the top row
	This.setRow(ll_rowClicked)		//sets the pointer
	
	IF isValid(This.inv_Linkage) THEN
	  	//Refresh Linkage for current row of master
	  	This.inv_Linkage.of_getMaster(ldw_Master)
	  	IF isValid(ldw_Master)THEN
			This.inv_linkage.of_Refresh(ldw_Master.GetRow())
	  	END IF
	END IF
	
	
	this.setRedraw(True)
ELSE
	li_return = -1
				
END IF
return li_return
end event

event type Datastore ue_getcacheds();//meant to be overidden by ancestors

Datastore 	lds_temp
return lds_temp
end event

event type integer ue_tabdialog();Integer		li_Return
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm


lstr_Parm.is_Label = "CURRENTOBJ"
lstr_Parm.ia_value = This
lnv_Msg.of_add_parm( lstr_Parm )

lstr_Parm.is_Label = "PARENTWINDOW"
lstr_Parm.ia_value = This.GetParent()
lnv_Msg.of_add_parm( lstr_Parm )

//Open Tab Dialog box and pass This as the parm to hold Current Dw
IF NOT IsValid ( w_TabSelection ) THEN
	OpenWithParm(w_TabSelection, lnv_Msg, This.GetParent())
ELSE
	w_TabSelection.SetFocus ( )
	li_Return = 1
END IF

Return li_Return
end event

event ue_restrict(n_cst_restrictioncriteria anv_data, u_dw_quickmatch adw_qm);//implemented at lower levels for now
//MessageBox("tcard shipments", "RESTRICTED")

IF isValid( inv_restriction ) THEN
	//MessageBox("tcard shipments", "RESTRICTED")
	inv_restriction.event ue_restrict( anv_data, adw_qm )
END IF
end event

event ue_clearrestriction(string as_dwtype);IF isValid( inv_restriction ) THEN
	inv_restriction.event ue_clearRestriction( as_dwType )
END IF
end event

public function integer of_setdeleteable (boolean ab_switch);ib_Deleteable = ab_Switch
RETURN SUCCESS
end function

public function integer of_setinsertable (boolean ab_switch);ib_Insertable = ab_Switch
RETURN SUCCESS
end function

public function integer of_setautofind (boolean ab_switch);ib_AutoFind = ab_Switch
RETURN SUCCESS


end function

public function integer of_setautosort (boolean ab_switch);ib_AutoSort = ab_switch
RETURN SUCCESS
end function

public function integer of_setautofilter (boolean ab_Switch);ib_AutoFilter = ab_Switch
RETURN SUCCESS
end function

public function long of_gettoprow ();return Long(this.describe("datawindow.firstrowonPage"))
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
String	ls_select
String	lsa_argNames[]
String	lsa_argDataTypes[]
String	ls_groupRes
int 		li_return
Long 		ll_newRow

as_property = trim(as_property)
as_value = trim(as_value)
IF as_property = "border" THEN
	IF as_value = "true" THEN
	 	this.border = true
	ELSE
		this.border = false
	END IF
	li_return = 1
	
ELSEIF as_property = "borderstyle" THEN
	IF as_value = "stylebox" THEN
		this.borderstyle = styleBox! 
		//is_borderStyle = "stylebox"
		li_return = 1
	//	MessageBox("set border style", is_borderStyle)
		
	ELSEIF as_value = "stylelowered" THEN
		this.borderstyle = stylelowered!
		//is_borderStyle = "stylelowered"
		li_return = 1
		
	ELSEIF as_value = "styleraised" THEN
		this.borderstyle = styleraised!
		//is_borderStyle = "styleraised"
		li_return = 1
		
	ELSEIF as_value = "styleshadowbox" THEN
		this.borderstyle = styleshadowbox!
		//is_borderStyle = "styleshadowbox"
		li_return = 1
	
	ELSE
		li_return = -1
	END IF
	IF this.borderStyle = stylebox! THEN
		is_borderstyle = "stylebox"
	ELSEIF this.borderStyle = stylelowered! THEN
		is_borderstyle = "stylelowered"
	ELSEIF this.borderstyle = styleRaised! THEN
		is_borderstyle = "styleraised"
	ELSEIF this.borderStyle = styleshadowbox! THEN
		is_borderstyle = "styleshadowbox"
	END IF
		
ELSEIF as_property = "bringtotop" THEN
	li_return = -1
	
ELSEIF as_property = "visible" THEN
	
	IF as_value = "true" THEN
		this.visible = true
		li_return = 1
	ELSEIF as_value = "false" THEN
		this.visible = false
		
		li_return = 1
	ELSE
		li_return = -1
	END IF
	
ELSEIF as_property = "controlmenu" THEN
	this.minbox = true
	this.maxbox = false
	IF as_value = "true" THEN
		this.controlMenu = true
		li_return = 1
	ELSE
		this.controlMenu = false
		li_return = 1
	END IF
	
	
ELSEIF as_property = "dataobject" THEN
	//if we are looking for a psr
	IF POS( as_value, "\" ) > 0 THEN
	 	IF FILEEXISTS( as_value ) THEN	
			li_return = 1
			
		ELSE
			li_return = 0
			this.ib_isupdateable = false
		END IF
	ELSE
		li_return = 1
	END IF
	
	IF li_return = 1 THEN
		IF as_value <> this.dataObject OR isNull( this.dataObject ) THEN
			this.dataObject = as_value
			this.setTransObject( SQLCA)
			
			IF isValid( inv_sort ) THEN
				ls_groupRes = this.describe("Datawindow.header.1.height")
				IF ls_groupRes <> "!" THEN
					This.inv_Sort.of_setColumnheader( false )
				ELSE
					This.inv_Sort.of_setColumnheader( true )
				END IF
			END IF
		END IF
	ELSEIF li_return = 0 THEN		//psr path specified is not valid
		
		this.dataobject = "d_generic"
		this.setTransObject( SQLCA)
		ll_newRow = this.insertRow( 0 )
		this.setItem( ll_newRow, "custom1", "Invalid Path for Dataobject "+as_value )
		is_invalidDataobjectPath = as_value	
	END IF
	
ELSEIF as_property = "dragauto" THEN
	li_return = -1
	
ELSEIF as_property = "dragicon" THEN
	li_return = -1

ELSEIF as_property = "enabled" THEN
	li_return = -1
	
ELSEIF as_property = "height" THEN
	this.Height = long(as_value)
	li_return = 1

ELSEIF as_property = "hscrollbar" THEN
	li_return = -1
	
ELSEIF as_property = "hsplitscroll" THEN
li_return = -1

ELSEIF as_property = "icon" THEN
	li_return = -1
	
ELSEIF as_property = "livescroll" THEN
	li_return = -1
	
ELSEIF as_property = "maxbox" THEN
	li_return = -1
	
ELSEIF as_property = "minbox" THEN
	li_return = -1
	
ELSEIF as_property = "object" THEN
	li_return = -1
	
ELSEIF as_property = "resizable" THEN
	IF as_value = "true" THEN
		this.resizable = true
	ELSE
		this.resizable = false
	END IF
	li_return = 1
	
ELSEIF as_property = "righttoleft" THEN
	li_return = -1
	
ELSEIF as_property = "taborder" THEN
	li_return = -1
	
ELSEIF as_property = "tag" THEN
	li_return = -1
	
ELSEIF as_property = "title" THEN
	this.title = as_value
	li_return = 1
	
ELSEIF as_property = "titleBar" THEN
	IF as_value = "true" THEN
		this.titleBar = true
	ELSE
		this.titleBar = false
	END IF
	
	li_return = 1
	
ELSEIF as_property = "visible" THEN
	li_return = -1
	
ELSEIF as_property = "vscrollbar" THEN
	li_return = -1
	
ELSEIF as_property = "width" THEN
	this.Width = long(as_value)
	li_return = 1
	
	
ELSEIF as_property = "X" THEN								//as of 3-8-06, we don't think we need
	this.X = long(as_value)									//to have x and y in here anymore, and 
	li_return = 1												//we also don't need to save x and y for
																	//windows and datawindows because
																	//they will be stored with the window state instead
																	//..however it is still here until all the new properties
																	//are in the database for old stuff that doesn't
																	//yet have the state information in the databases
ELSEIF as_property = "Y" THEN
	this.Y = long(as_value)
	li_return = 1
	
ELSEIF as_property = "filter" THEN
	li_return = this.setFilter(as_value)
	
	this.filter()
ELSEIF as_property = "sort"	THEN
	li_return = this.setSort(as_value)
	this.sort()
	
ELSEIF as_property = "indicator" AND isValid( this.inv_dragService) THEN
	If isValid( inv_dragservice ) THEN
		inv_dragService.of_setIndicatorMode(as_value)
	END IF
	li_return = 1
	
ELSEIF as_property = "dragscroll"  THEN
	IF as_value = "true" THEN
		this.of_setDragService( true )
		inv_dragService.of_setDragScroll(true)
	ELSE
		this.of_setDragService( false)
		//inv_dragService.of_setDragScroll(false)
	END IF
	li_return = 1
	
ELSEIF as_property = "prefilter" THEN
	
	//prefilter should only exist in the data base 2 times.
	//once for the abstract, and once for the instance.
	//The abstract one will have '[AND]' in it.
	//The instance will just have the expression.
	
	//Because of the way properties are loaded, the abstract
	//will always come first, so we just assign it.
	//The instance will always come second, so we append it to 
	//whatever it was before.
	IF len( is_filterDef ) > 0 THEN
		
			is_filterDef = is_filterDef + as_value

	ELSE
		is_filterDef = as_value
		
	END IF
	li_return = 1
ELSEIF as_property = "sqlrefreshmintime" THEN
	IF isNumber( as_value ) THEN
		il_minimumtimebetweenreloadsforsql = long( as_value )
	END IF
ELSE
	li_return = -1
END IF

return li_return
end function

public function string of_getobjname ();return is_ObjectName

end function

public function long of_getobjinstance ();return il_InstanceNum
end function

public function string of_getparentname ();return is_parentName
end function

public function long of_getbottomrow ();return	Long(this.describe("datawindow.lastrowonPage"))
end function

public function string of_getmytype ();return cs_myType
end function

public function integer of_setmouseover (boolean ab_switch);Integer	li_Return = NO_ACTION


//Check arguments
If IsNull(ab_switch) Then
	li_Return = FAILURE
ELSEIF ab_Switch THEN
	IF IsNull(inv_MouseOver) Or Not IsValid (inv_MouseOver) THEN
		inv_MouseOver = Create n_cst_dwsrv_MouseOver
		inv_MouseOver.of_SetRequestor ( THIS )
		li_Return = SUCCESS
	END IF
ELSE 
	IF IsValid (inv_MouseOver) THEN
		Destroy inv_MouseOver
		Return SUCCESS
	END IF	
END IF

Return li_Return
end function

public function integer of_setlinkable (boolean ab_switch);ib_Linkable = ab_switch
Return SUCCESS

end function

public function integer of_allowproperties (boolean ab_switch);ib_AllowProperties = ab_Switch

RETURN 1
end function

public function integer of_setdragservice (boolean ab_switch);Integer	li_Return = NO_ACTION

//Check arguments
If IsNull(ab_switch) Then
	li_Return = FAILURE
ELSEIF ab_Switch THEN
	IF IsNull(inv_DragService) Or Not IsValid (inv_DragService) THEN
		inv_DragService = Create n_cst_dragService_Dw
		inv_DragService.of_SetRequester ( THIS )
		inv_dragService.of_SetIndicatorMode("OFF")
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

public function integer of_allowsavedefinition (boolean ab_switch);ib_AllowSaveDefinition = ab_Switch

Return SUCCESS
end function

public function integer of_allowsavedefinitionas (boolean ab_switch);ib_AllowSaveDefinitionAs = ab_Switch

Return SUCCESS
end function

public function integer of_allowremoveobjet (boolean ab_switch);ib_AllowRemoveObject = ab_Switch

Return SUCCESS
end function

public function integer of_setprefilter (string as_prefilter);is_FilterDef = as_preFilter
return 1

end function

public function integer of_prefilter ();/***************************************************************************************
NAME: 			of_preFilter

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			1
	
DESCRIPTION: This function takes whatever is defined in the instance is_filterDef and
				 filters the data based on that.  It discards the rows after it filters them
				 out.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Maury	9-28-2005
	

***************************************************************************************/

String	ls_PreFilter
Long		ll_Max
Integer	li_Index
is_FilterDef = Trim(is_FilterDef)






li_Index = Pos( is_FilterDef, "~r~n[AND]~r~n" )

//take out the delimeter
IF li_Index = 1 THEN //no def filter
	ls_PreFilter = Replace(is_FilterDef, li_Index, 9, "")  
ELSEIF li_Index + 8 = Len(is_FilterDef) THEN //no unique filter
	ls_PreFilter = Replace(is_FilterDef, li_Index, 9, "")

//if the delimeter exists then we want to replace it with " and " so that both
//the abstract and instance portion of it are part of prefiltering.
ELSEIF li_Index > 0 THEN
	ls_PreFilter = Replace(is_FilterDef, li_Index, 9, ") AND (")  
ELSE
	ls_preFilter = is_filterDef
END IF

ls_PreFilter = Trim(ls_PreFilter)
IF Len(ls_PreFilter) > 0 THEN 
	ls_PreFilter = "(" + ls_PreFilter + ")"
ELSE
	ls_PreFilter = ""
END IF

This.SetFilter(ls_PreFilter)
This.Filter()

ll_Max = This.FilteredCount()

This.rowsdiscard( 1, ll_Max, Filter!)


Return 1
end function

public function integer of_dogrouprowcalculation ();//returns the row the current row is set to, -1 otherwise

//should only be called if row = 0


String	ls_BandInfo
String	ls_temp
Long		ll_firstGroupRow
Int		li_tabPosition
Int		li_return

//This logic is for dealing with groups.
//It calculates the first row of the group and sets the current row 
//of the dw to that row.

	
ls_BandInfo = This.GetBandAtPointer ( )


//we only need to do this if it is not the regular header or trailer of the dw
IF POS( ls_bandInfo, "header.") > 0 OR POS( ls_bandInfo, "trailer." ) > 0 THEN
	
	li_tabPosition = POS( ls_bandInfo, "~t" )
	ls_temp = right( ls_BandInfo, (len( ls_bandInfo ) - li_tabPosition) )
	ll_firstGroupRow = long( ls_temp )		
	
	this.setRow( ll_firstGroupRow )
	
	li_return = ll_firstGroupRow
ELSE
	li_return = -1
END IF
	
	
return li_return
end function

public function integer of_setabsprefilter (string as_absprefilter);String 	ls_UpdatedPF
Long		ll_Pos
Long		ll_DefLength

IF isNull(is_FilterDef) THEN
	is_FilterDef = ""
END IF

ll_Pos = Pos(is_FilterDef, "~r~n[AND]~r~n")
IF ll_Pos > 0 THEN

	ll_DefLength = ll_Pos - 1
		
	IF ll_DefLength <> 0 THEN //replace the old prefilter
		ls_UpdatedPF = Replace(is_FilterDef, 1, ll_DefLength, as_absprefilter)
	ELSE //insert the new def prefiliter
		ls_UpdatedPF = as_AbsPreFilter + is_FilterDef
	END IF
ELSE
	ls_UpdatedPF = as_absprefilter + "~r~n[AND]~r~n" + is_FilterDef
END IF

is_FilterDef = ls_UpdatedPF
Return 1
end function

public function integer of_allowtabpage (boolean ab_switch);ib_AllowTabPage = ab_Switch

return 1
end function

public function integer of_settab (u_tab atab_tab);itaba_tab[upperbound(itaba_tab)+ 1] = atab_tab

return 1
end function

public subroutine of_gettab (ref u_tab ataba_tab[]);ataba_tab = itaba_tab
end subroutine

public function integer of_setrestriction (boolean ab_switch);//meant to be implemented at lower levels
return -1
end function

public function integer of_setrestrictable (boolean ab_switch);this.ib_isRestrictable = ab_switch
return 1
end function

public function integer of_setreload (boolean ab_switch);ib_Reloadable = ab_switch
return 1
end function

public function boolean of_isadminmode ();Boolean		lb_AdminMode
w_Master		lw_Win

w_Sheet_DynamicControl	lw_Dynamic

IF This.of_isDynamicControl( ) THEN 
	
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
	
END IF



Return lb_AdminMode
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
Return il_InstanceNum > 0 AND Len(is_ObjectName) > 0
end function

public function long of_calculateseconds (string as_time);//written by dan 3-7-06
//the following will take a time in the form "hh:mm:ss" and return the number of seconds it represents

Long	ll_hours
Long	ll_min
Long	ll_sec
Long	ll_totalSeconds
IF len( as_time ) = 8 THEN
	ll_hours = Long( Mid(as_time,1,2 ))		//returns hh
	
	ll_min =  Long( Mid(as_time,4,2 ))
	
	ll_sec =  Long( Mid(as_time,7,2 ))
	
	ll_totalSeconds = (ll_hours*3600) + (ll_min*60) + ll_sec 

END IF

RETURN ll_totalSeconds
end function

public function integer of_getretrievetype ();//
String	ls_select
String	lsa_argdatatypes[]
String	lsa_argNames[]
Int	li_retrieveType

ls_select = describe("datawindow.table.select")

IF ls_select = "?" OR ls_select = "!" THEN
	
	ls_select = ""
END IF

this.of_setBase( true )

//-----
// if the length lof ls_select is greater than 0 then we know its a retrieval.
// If the number of args is 0 then we do nothing, linkage should take care of it, or
// the dataobject will have a button to manually prompt for args.

IF len( ls_select ) > 0 AND not isNULL( this.inv_base ) AND isValid( this.inv_base ) THEN
	this.inv_base.of_dwarguments( lsa_argNames, lsa_argDataTypes )
	
	IF upperBound( lsa_argNames ) < 1 THEN			//normal retrieve
		li_retrieveType = ci_sql	
	ELSE								
		//linkage or manual prompte for args
		li_retrieveType = ci_linkage
	END IF
	
ELSE														//refresh from cache
	li_retrieveType = ci_cache
END IF
		
return li_retrieveType

end function

public function integer of_showrefreshstatus (boolean ab_resetstatus);//this function only happens conditionally
//its purpose for now is to show that a refresh was called(ue_reload) on this window, but this window
//has not refreshed for whatever reason. 

//Possible reasons:  this is a dynamic object, where il_minimumTimeBetweenReloadsForSQL is a greater amount
//of time then it has been since the last time this thing retrieved as a result of the dynamic window 
//trying to refresh itself.

//IF ab_resetStatus is true, then it looks for a control button called b_retrieve in the dataobject and
//changes its background color to white and text to black.

//If it is false then it changes the buttons color to a darker shade of gray.  It gets darker and darker
//and eventually the text turns white.
Int 		li_return
Long		ll_index
Long		ll_max
Boolean	lb_continue
String	lsa_objList[]

n_cst_dwSrv	lnv_srv

//make sure this only works for dynamic objects
IF isValid( inv_mypropmanager ) THEN

	lnv_srv = create n_cst_dwSrv
	
	lnv_srv.of_setrequestor( this )
	
	lnv_srv.of_getobjects( lsa_objList )
	
	ll_max = upperBound( lsa_objList )
	FOR ll_index = 1 TO ll_max
		IF lsa_objList[ll_index] = cs_retrievebutton THEN
			lb_continue = true
			EXIT
		END IF
	NEXT
	destroy lnv_srv
END IF

IF lb_continue THEN
	IF ab_resetStatus THEN
		this.object.b_retrieve.Background.Color = RGB(255, 255, 255)	//white
		this.object.b_retrieve.color = 0 //black
	ELSE
		//MessageBox("",string(this.object.b_retrieve.Background.Color) )
		this.object.b_retrieve.Background.Color = long(this.object.b_retrieve.Background.Color) - 17*65536 - 17*256 -17
		IF Long( this.object.b_retrieve.backGround.color ) < RGB(175,175,175) THEN
			this.object.b_retrieve.color = RGB( 255,255,255 ) 				//white
		END IF
	END IF
END IF

RETURN li_return

end function

public function boolean of_istimetorefresh ();//Implemented 3-24-2006, this was intended for dynamic SQL retrievals

Long	ll_lastTimeInSecs
Long	ll_currentSeconds
String	ls_currentTime
Boolean lb_return = true

IF this.of_getretrievetype( ) = THIS.ci_sql THEN
	
	ll_lastTimeInSecs = this.of_calculateseconds( string( it_lastreload ) )
	
	ls_currentTime = String(Now(), "hh:mm:ss")
	ll_currentSeconds = this.of_calculateseconds( ls_currentTime )
	
	lb_return = ( ll_currentSeconds - ll_lastTimeInSecs ) >= il_minimumtimebetweenreloadsforsql 
END IF

RETURN lb_return
end function

public function string of_getdefinitionprefilter ();Integer	li_Pos
String	ls_Prefilter

ls_PreFilter = is_FilterDef

li_pos = POS(ls_preFilter,"~r~n[AND]~r~n")
IF li_Pos > 0 THEN
	ls_PreFilter = left( ls_prefilter , (li_pos -1 ) )
ELSE
	ls_PreFilter = ""
END If


return ls_PreFilter


end function

public function string of_getuniqueprefilter ();String	ls_PreFilter
Integer	li_Pos

ls_PreFilter = is_FilterDef

li_pos = POS(ls_preFilter,"~r~n[AND]~r~n")
IF li_pos > 0 THEN
	ls_PreFilter = right( ls_prefilter , (len( ls_preFilter ) - ( li_pos+ 8 )) )
ELSE
	ls_PreFilter = ""
END IF

Return ls_Prefilter
end function

public function integer of_focusindicatoron ();Window	lw_Target
Integer	li_Return = FAILURE

//Open User Object if not valid

IF Parent.TypeOf ( ) = Window! THEN
	//We must be on a window to dynamically create the user object

	IF NOT IsValid ( ip_FocusIndicator ) THEN
	
		lw_Target = Parent
		lw_Target.OpenUserObject ( ip_FocusIndicator, This.x + 16, This.y + 16 )
		ip_FocusIndicator.Hide()
	END IF
	
END IF

//Set focus indicator mode to blue bar
IF IsValid ( ip_FocusIndicator ) THEN
	This.SetRowFocusIndicator ( ip_FocusIndicator )
	li_Return = SUCCESS
ELSE
	li_Return = NO_ACTION
END IF


Return li_Return
end function

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//   Event:  Clicked
//   OVERRIDE OF ANCESTOR EVENT TO FIX BUG: IF ROW WAS 0 WITH LINKAGE ON, 
//   WAS NOT ALLOWING PROCESSING TO FLOW THROUGH TO SORT SERVICE, WHICH USES
//   HEADER CLICKS (WHICH HAVE ROW = 0)
//
//   ALSO, NEED TO PROVIDE AUTO-SORT CAPABILITY IN CASE HEADER COLUMN IS
//   CLICKED AND SORT HAS NOT YET BEEN INSTANTIATED ELSEWHERE.
//
//   Description:  DataWindow clicked
//
//////////////////////////////////////////////////////////////////////////////
//   
//   Revision History
//
//   Version
//   5.0   Initial version
// 6.0    Added Linkage service notification
// 6.0    Introduced non zero return value
//
//////////////////////////////////////////////////////////////////////////////
//
//   Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//   Any distribution of the PowerBuilder Foundation Classes (PFC)
//   source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
    
integer li_rc
    
// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
   Return
END IF
    
//IF IsValid (inv_linkage) THEN					/*PFC VERSION*/
IF IsValid (inv_linkage) AND Row <> 0 THEN	/*BUG FIX VERSION*/
   If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
      inv_linkage.CONTINUE_ACTION Then
      // The user or a service action prevents from going to the clicked row.
      Return 1
   End If
END IF

IF IsValid (inv_RowSelect) THEN
   inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

////AUTO-SORT EXTENSION
IF NOT IsValid ( inv_Sort ) THEN
	
	//IF clicked object is in the header, attempt to auto-start sort service
	IF dwo.Name = 'datawindow' THEN
		//Screen for dwo's without Band attribute, which would crash
		//Clicked object was not a column header -- Ignore
	ELSEIF dwo.Band = "header" THEN
		This.Event ue_AutoSort ( )
	END IF

END IF
////END AUTO-SORT EXTENSION
    
IF IsValid (inv_Sort) THEN 
   inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 


//***************** Added Functionality (Maury/Dan)************************
//************(Group Row Calc, DragService Click, MouseOver Click)******

//this is for logic for dealing with groups
IF row = 0 THEN
	this.of_doGroupRowCalculation( )
END IF
	
//logic for dragservice
IF isValid(inv_dragService) THEN
	 inv_dragService.post of_Clicked(xpos, ypos, row, dwo)
END IF

IF isValid( inv_mouseOver ) THEN
	
	IF inv_mouseOver.of_isMouseOverOn() THEN
		inv_mouseOver.Event ue_clicked()		
	END IF

END IF


end event

event itemchanged;//////////////////////////////////////////////////////////////////////////////
//
//   Event:         Itemchanged
//
//   OVERRIDE OF ANCESTOR EVENT TO ALLOW BETTER HANDLING OF li_rc = 2.
//   THIS ALLOWS li_rc = 2 TO INDICATE THAT THE VALUE NOW STORED IN THE 
//   EDITED COLUMN IS DIFFERENT FROM WHAT THE USER TYPED  (ie, THE EDITED
//   COLUMN HAPPENS TO BE ONE OF THE "OTHER" COLUMNS CHANGED).  THE STORED VALUE
//   IS BEING REFRESHED ALONG WITH ALL THE OTHERS BY UpdateRequestor ANYWAY, SO
//   WE SHOULD JUST LET THAT VALUE STICK, RATHER THAN "OVERWRITING" IT WITH
//   THE TYPED VALUE, WHICH IS WHAT HAPPENS WITH il_retnval = 0.
//
//   Arguments:      Long      -   row
//                  dwobject   -   dwo
//                  String   -   data
//
//   returns:         Long
//
//   Description:   Capture any changes made by the user for business object
//                  services to communicate to the BCM.
//
//////////////////////////////////////////////////////////////////////////////
//   
//   Revision History
//
//   Version
//   1.0   Initial version
//   1.0.2   BTR 6760 - Add BCM error serice call
//   1.0.2   BTR 6759 - check for warnings
//   1.0.2   Add ib_ofritemchangederror setting for itemerror event notification
//
//////////////////////////////////////////////////////////////////////////////
//
//   Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//   Any distribution of the HOW OpenFrame (OFR)
//   source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_ofrerror lnv_ofrerror[]
il_rtnval = 0
int li_rc
    
if IsValid(inv_uilink) then         // business object services
   li_rc = this.inv_uilink.SetText( row, dwo.name, data)
   if li_rc < 0 then
      il_rtnval = 1
      ib_ofritemchangederror = true
      //      Check for warning and process
      this.inv_uilink.GetOFRErrors(lnv_ofrerror)
      if UpperBound(lnv_ofrerror) > 0 then
         if IsValid(lnv_ofrerror[1]) then
            if lnv_ofrerror[1].GetWarning() = true then
               this.inv_uilink.ProcessOFRError(lnv_ofrerror)
               il_rtnval = 0
               ib_ofritemchangederror = false
            end if
         end if
      end if

	/*OVERRIDE BEGINS HERE*/
	ELSEIF li_rc = 2 THEN
		il_RtnVal = 2
	/*OVERRIDE ENDS HERE*/

   end if
end if
    
return il_rtnval

end event

event pfc_filterdlg;SetPointer( HourGlass! )

//If filter service has not been started, attempt to autostart it.

IF Not IsValid ( inv_Filter ) THEN
	This.Event ue_AutoFilter ( ) 
END IF

// ches //
// Fix side effect if the button is clicked 

If IsValid( inv_filter ) Then
	long ll_retval
	ll_retval = inv_filter.Event pfc_filterdlg( )
	this.SetFocus( )
	Return ll_retval
end if

Return FAILURE
// ches //
end event

event pfc_sortdlg;SetPointer( HourGlass! )

//If sort service has not been started, attempt to autostart it.

IF Not IsValid ( inv_Sort ) THEN
	This.Event ue_AutoSort ( )
END IF

// ches //
// Fix side effect if the button is clicked 

If IsValid (inv_sort) Then
	long ll_retval
	ll_retval = inv_sort.Event pfc_SortDlg()
	this.SetFocus( )
	Return ll_retval
end if
Return FAILURE

// ches //
end event

event pfc_prermbmenu;// ches //
// Hide or show Insert and Delete capability
am_dw.m_table.m_insert.visible = am_dw.m_table.m_insert.enabled and ib_insertable
am_dw.m_table.m_delete.visible = am_dw.m_table.m_delete.enabled and ib_deleteable
am_dw.m_table.m_addrow.visible = am_dw.m_table.m_addrow.enabled and ib_insertable
am_dw.m_table.m_dash11.visible = am_dw.m_table.m_insert.visible or &
	am_dw.m_table.m_delete.visible or am_dw.m_table.m_addrow.visible
// ches //


// ches //
// Taking into account additional menu items for DW services
am_dw.m_table.m_sort.Visible = IsValid( inv_Sort ) OR ib_AutoSort
am_dw.m_table.m_filter.Visible = IsValid ( inv_Filter ) OR ib_AutoFilter
am_dw.m_table.m_find.Visible = IsValid ( inv_Find ) OR ib_AutoFind
am_dw.m_table.m_print.Visible = TRUE
am_dw.m_table.m_export.Visible = TRUE
// ches //

n_cst_privileges	lnv_priv  


//Dynamic menu options - maury

am_dw.m_table.m_link.Visible = ib_Linkable AND lnv_priv.of_dynamic_createlinkdefinition( )
am_dw.m_table.m_applylink.Visible = ib_Linkable AND lnv_priv.of_dynamic_applylinks( ) 
am_dw.m_table.m_dwproperties.Visible = ib_AllowProperties AND lnv_priv.of_dynamic_changeproperties( )
am_dw.m_table.m_dash15.visible = am_dw.m_table.m_link.Visible OR &
										  am_dw.m_table.m_applylink.Visible OR &
										  am_dw.m_table.m_dwproperties.Visible

am_dw.m_table.m_savedefinition.Visible = ib_AllowSaveDefinition AND lnv_priv.of_dynamic_createabstract( ) 
am_dw.m_table.m_savedefinitionas.Visible = ib_AllowSaveDefinitionAs AND lnv_priv.of_dynamic_createabstract( ) 
am_dw.m_table.m_dash16.visible = am_dw.m_table.m_savedefinition.Visible OR &
											am_dw.m_table.m_savedefinitionas.Visible
											
am_dw.m_table.m_removeobject.Visible = ib_AllowRemoveObject AND lnv_priv.of_dynamic_createinstance( )
am_dw.m_table.m_tabpage.Visible = ib_AllowTabPage AND lnv_priv.of_dynamic_changeProperties( ) 
am_dw.m_table.m_dash17.visible = am_dw.m_table.m_removeobject.Visible OR am_dw.m_table.m_tabpage.Visible


// end Dyanmic menu options

end event

event pfc_finddlg;//Override Ancestor to autostart service, if permitted, 
//then proceed with ancestor processing

IF Not IsValid ( inv_Find ) THEN
	This.Event ue_AutoFind ( )
END IF

Super::Event pfc_FindDlg ( )
end event

event destructor;call super::destructor;destroy inv_dragService
destroy inv_mouseOver
int li_max
int li_index



IF IsValid ( ip_FocusIndicator ) THEN
	//Check IsValid here to avoid loading window variable in user event
	//unnecessarily, for performance reasons
	This.Event ue_SetFocusIndicator ( FALSE )
END IF

//If part of tab page, remove the tab
li_max = upperBound( itaba_Tab ) 

FOR li_index = 1 TO li_max
	IF iSValid( itaba_Tab[li_index] ) THEN
		
		itaba_Tab[li_index].event ue_closeTab( this )
	END IF

NEXT


end event

on u_dw.create
end on

on u_dw.destroy
end on

event dragleave;call super::dragleave;//forwards dragleave event to service object if it is valid
IF isValid(inv_dragService) THEN
	IF source <> this THEN
		inv_dragService.EVENT ue_dragleave(source)
	END IF
END IF
end event

event dragwithin;call super::dragwithin;//forwards the dragwithin to the service if service is valid
IF isValid(inv_dragService) AND source <> this THEN
	inv_dragService.EVENT ue_dragWithin(source,row, dwo)
END IF
end event

event dragdrop;call super::dragdrop;
/***************************************************************************************
NAME: 	dragDrop		

ACCESS:		public	
		
ARGUMENTS: 		
							(default)

RETURNS:			default
	
DESCRIPTION:		
	
	forwards the call to the drag service for mechanical functionality
	and also informs the source what it was dropped on if the service.
	

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : dan and maury 7-29-05
	

***************************************************************************************/

Datawindow		ldw_source
u_dw				ldw_source2
Long				ll_sourceRow

//this is logic for dealing with groups, it will reset the current row
//if the thing dropped on is a header or trailer and set the current row
//to the first row in the group.
IF row = 0 THEN
	row = this.of_doGroupRowCalculation( )
	IF row = -1 THEN
		row = 0
	END IF
END IF

// forwards information to the of_dragDrop of the DragService
IF isValid( inv_dragService ) THEN
	inv_dragService.of_hideIndicator()
	inv_dragService.of_dragDrop(source, row, dwo)
END IF

// if the thing being dropped is a datawindow then assign it to a normal Datawindow variable.
IF typeOF( source ) = datawindow!  THEN
	ldw_source = source
	ll_sourceRow = ldw_source.getRow()
END IF

//If the manager is valid, and the dropped item was dropped on a valid row or object.
//Then trigger a refresh just in case any processing is done down the line.
IF isValid( inv_myPropManager ) AND NOT ( source = this AND ll_sourceRow = row )  AND row <> 0 THEN
	//update centralized cache with information from dropped object
	
	//call refresh on the main window
//*******Refresh only if the cache has been updated********
	this.inv_myPropManager.EVENT post ue_requestRefresh()
		
	//if the thing being dropped on this has a propmanager with a different main window
	//as its property, then refresh that window as well.
	IF typeOF( source ) = datawindow! AND source.triggerEvent( "ue_hasids" ) = 1 THEN
		ldw_source2 = source
		
		
		IF isValid( ldw_source2.inv_myPropManager ) THEN
			
			IF Handle( this.inv_MyPropManager.iw_Window ) = Handle( ldw_source2.inv_myPropManager.iw_Window ) THEN
				//they are the same, so we do nothing
				
			ELSE 
			//*******Refresh only if the cache has been updated********
				ldw_source2.inv_myPropManager.EVENT  post ue_requestRefresh( )
			END IF
			
		END IF
	END IF
	
	
END IF

//MessageBox("u_dw script", "udw dragdrop")
end event

event rbuttonup;//OVERRIDING (as of 11/17/05 MFS) ancestor to provide limited RMB support when in print preview mode.
//The PFC provides no RMB support in this situaiton.

//Overriding (more as of 3-13-06) same reason as for print preview mode as it is for graphs.

//Changed To OVERRIDE Ancestor to allow implementaion of Admin Mode check for dynamic environments

m_dw					lm_dw
window				lw_parent
sTRING		LS_TYPE
Long			ll_Return
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

//Disable menu when object is dynamic and not in admin mode
IF lb_DynamicControl AND NOT lb_DisplayMenu THEN
	//Do not display any menus
ELSE

	//beats me why this makes sense!
	IF isValid(this) THEN
		ls_type = dwo.type
		
		If this.object.datawindow.print.preview = "yes"  or ls_type = "graph"  then
		
			//The following are all the essential actions from the pfc_rbuttonup event
			//needed to get the basic, appropriate RMB options to display
			
			// Create popup menu
			lm_dw = create m_dw
			lm_dw.of_SetParent (this)
		
			this.of_GetParentWindow (lw_parent)
			
			// DataWindow property entries. (isolate calls to shared variable)
			this.event pfc_prermbmenuproperty (lm_dw)
			
			// Allow for any other changes to the popup menu before it opens
			this.event pfc_prermbmenu (lm_dw)
			
		//	// Send rbuttonup notification to row selection service
		//	if IsValid (inv_rowselect) then
		//		inv_rowselect.event pfc_rbuttonup (xpos, ypos, row, dwo)
		//	end if
			
			// Popup menu
			lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
			
			//Now, prevent the sort / filter / find popup.
			ll_Return = 1
			
			destroy lm_dw
			
		end if
	END IF
	
	IF ll_Return = 0 THEN

		ll_Return = Super::Event rButtonUp ( xpos, ypos, row, dwo )

	END IF
	
END IF
return ll_Return
end event

event buttonclicked;call super::buttonclicked;//for future retrieve buttons that are on datawindows with sql refresh

IF isValid( this.inv_mypropmanager ) and len( this.is_objectname ) > 0 THEN
	IF this.of_getretrievetype( ) = ci_sql THEN
		IF dwo.name = cs_retrieveButton THEN
			dwo.color = 0
			dwo.background.color = RGB( 255, 255,255 )
		END IF
	END IF
END IF
end event

event dragenter;call super::dragenter;//forwards the dragenter to the service if service is valid
IF isValid(inv_dragService) AND source <> this THEN
	inv_dragService.EVENT ue_dragEnter(source)
END IF
end event

