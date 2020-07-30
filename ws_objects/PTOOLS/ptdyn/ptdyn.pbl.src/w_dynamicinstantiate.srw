$PBExportHeader$w_dynamicinstantiate.srw
forward
global type w_dynamicinstantiate from w_response
end type
type dw_objtypes from u_dw within w_dynamicinstantiate
end type
type st_1 from statictext within w_dynamicinstantiate
end type
type cb_cancel from commandbutton within w_dynamicinstantiate
end type
type cb_create from commandbutton within w_dynamicinstantiate
end type
type dw_abstracts from u_dw within w_dynamicinstantiate
end type
type cb_1 from commandbutton within w_dynamicinstantiate
end type
type gb_type from groupbox within w_dynamicinstantiate
end type
type ln_1 from line within w_dynamicinstantiate
end type
end forward

global type w_dynamicinstantiate from w_response
integer x = 214
integer y = 221
integer width = 2821
integer height = 2804
string title = "Create"
long backcolor = 12632256
boolean center = true
dw_objtypes dw_objtypes
st_1 st_1
cb_cancel cb_cancel
cb_create cb_create
dw_abstracts dw_abstracts
cb_1 cb_1
gb_type gb_type
ln_1 ln_1
end type
global w_dynamicinstantiate w_dynamicinstantiate

type variables
Window	iw_requester
int		ii_xpos
int		ii_ypos

PowerObject	ipo_Object
Datastore	ids_objProps
Datastore	ids_mouseOvers
PowerObject ipoa_createdObjects[]
w_child		iwa_createdWindows[]
String		isa_objectNames[]
end variables

forward prototypes
public function integer of_setrequester (window aw_window)
public function integer of_setposition (integer ai_xpos, integer ai_ypos)
public function long of_getinstancenumber (string as_objectname, string as_type)
public function integer of_setcontrol (datastore ads_objprops, window aw_window, string as_objectname, long al_instance)
public function integer of_setmouseovers (powerobject apo_object, window aw_window)
public function integer of_loadlinkages (w_master aw_window)
private function integer of_displayobject ()
end prototypes

public function integer of_setrequester (window aw_window);Int	li_return

IF isValid( aw_window ) THEN
	iw_requester = aw_window
	li_return = 1
ELSE
	li_return = -1
END IF

return li_return
end function

public function integer of_setposition (integer ai_xpos, integer ai_ypos);ii_xpos = ai_xpos
ii_ypos = ai_ypos

return 1
end function

public function long of_getinstancenumber (string as_objectname, string as_type);Int 	li_index
Int	li_max
Long	ll_instance
Long	ll_conInstance
Long	ll_foundInstance

String	ls_name


Boolean	lb_found

Window	lwa_children[]



IF as_type = "window" AND iw_requester.triggerEvent( "ue_haschildrenwindows" ) = 1 THEN
	
	iw_requester.dynamic of_getChildrenWindows( lwa_children )
	li_max = upperBound( lwa_children )
	
	
	lb_found = False
	ll_instance = 1

		
	FOR li_index = li_max TO 1 STEP -1
		
		IF isValid( lwa_children[li_index] ) THEN
			ls_name = lwa_children[li_index].dynamic of_getObjName()
			ll_conInstance = lwa_children[li_index].dynamic of_getObjInstance()
			
			
			//only look at instance numbers of objcts with matching names
			IF ls_name = as_objectName THEN 
				
				//if the instance numbers match, the instance is not unique, so we get a new number
				//and reset the looping index to see if that one is unique.
				//If it gets all the way through and lb_found is still false, then that means every
				//number from 1 to li_max is used. Since each numbre can only be used once on the window,
				//that means that there li_max + 1 couldn't have been used.
				IF ll_instance = ll_conInstance THEN
					lb_found = false
					ll_instance++
					li_index = li_max
				ELSE
					lb_found = true
				END IF
				
			ELSE
				//names don't match, get next object
			END IF
		END IF
		
	NEXT
		
		
	//either a unique instance from 1 to li_max was found, or li_max + 1 is unique

ELSE 
	li_max = upperBound( iw_requester.control )
	
	
	lb_found = False
	ll_instance = 1

		
	FOR li_index = li_max TO 1 STEP -1
		
		IF isValid( iw_requester.control[li_index] ) THEN
			
			IF iw_requester.control[li_index].triggerEvent("ue_hasIds") = 1 THEN
				ls_name = iw_requester.control[li_index].dynamic of_getObjName()
				ll_conInstance = iw_requester.control[li_index].dynamic of_getObjInstance()
			
			
				//only look at instance numbers of objcts with matching names
				IF ls_name = as_objectName THEN 
					
					//if the instance numbers match, the instance is not unique, so we get a new number
					//and reset the looping index to see if that one is unique.
					//If it gets all the way through and lb_found is still false, then that means every
					//number from 1 to li_max is used. Since each numbre can only be used once on the window,
					//that means that there li_max + 1 couldn't have been used.
					IF ll_instance = ll_conInstance THEN
						lb_found = false
						ll_instance++
						li_index = li_max
					ELSE
						lb_found = true
					END IF
					
				ELSE
					//names don't match, get next object
				END IF
			END IF
		END IF
		
	NEXT
		
		
	//either a unique instance from 1 to li_max was found, or li_max + 1 is unique

END IF



return ll_instance
end function

public function integer of_setcontrol (datastore ads_objprops, window aw_window, string as_objectname, long al_instance);/***************************************************************************************
NAME: 		of_setControl	

ACCESS:			public
		
ARGUMENTS: 		ads_objprops:   obsolete, not used
					aw_window:			the window the controllers are being set up on
					as_objectName:		the name of the object being created on teh window
					al_instance:		the instance number of the object being created on the window

RETURNS:			1
	
DESCRIPTION:	The following creates any objects on a created window and sets up there properties.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 	9-15-05
	

***************************************************************************************/
Long			ll_max
Long 			ll_index
Long			ll_instance
Int			li_result

String 		ls_type
String		ls_className
String		ls_name
String 		ls_parentName
String		ls_queriedParentName
String		ls_label
String		ls_value
DragObject	ldrg_object
Datastore 	lds_objProps

DataStore	lds_abstracts


n_cst_bso_dynamicObjectManager lnv_manager

//= lds_abstracts.rowCount()


//retrieve the properties of the object being created
IF not ISNULL( as_objectName ) THEN

	lds_abstracts = Create Datastore
	lds_abstracts.dataobject = "d_dynamicobjects"
	lds_abstracts.setTransObject( SQLCA )
	ll_max = lds_abstracts.retrieve()


	lds_objProps = Create datastore
	lds_objProps.dataObject = "d_dynamiccreateproperties"
	lds_objProps.setTransObject( SQLCA )
	
	lds_objProps.retrieve( as_objectName )
	COMMIT;
	
	//must return a row in order for the object to be created
	ll_index = lds_abstracts.find("name = '"+ as_objectName+"'" ,1, ll_max)
//MessageBox(as_objectName, string( ll_index ))
END IF

IF ll_index > 0 THEN
	
	ls_type = lds_abstracts.getItemString( ll_index, "type")
	ls_className = lds_abstracts.getItemString( ll_index, "classname")

	
	IF isValid( aw_window ) AND ls_type <> "window" THEN
		
		ls_parentName = aw_window.dynamic of_getObjName()
		
		
		//if its a datawindow then create it on the window being passed in , and
		//set its properties
		IF ls_type = "datawindow" OR ls_type = "tab" THEN
			aw_window.OpenUserObject ( ldrg_object, ls_className )
			
			
			IF isValid( ldrg_object ) THEN
				
				iw_requester.dynamic of_getDynPropManSrvc(lnv_manager )
				
				ldrg_object.dynamic EVENT ue_setdynpropmansrvc( lnv_manager )
				
				//added all things on the window as a list of objects that need to be closed
				lnv_manager.of_addopeneduserobject( ldrg_object )
				
				//set up identifiers and give it a propmanager service.
				ldrg_object.dynamic EVENT ue_setIdentifiers( as_objectName, al_instance )
				ldrg_object.dynamic EVENT ue_setParentName( ls_parentName )
				
				
				lds_objProps.setSort( "objectname A, instance A, containername A" )
				lds_objProps.sort()
				
				
				//set the properties
				ll_max = lds_objProps.rowCount()
				FOR ll_index = 1 TO ll_max 
					
					
					ll_instance = lds_objProps.getItemNumber( ll_index, "instance" )
					ls_name = lds_objProps.getItemString( ll_index, "objectname" )
					ls_queriedParentName = lds_objProps.getItemString( ll_index,"containername")
					
					//if the property goes with the object we just created, set all the property on the object
					IF ls_name = as_ObjectName AND (ll_instance = al_instance OR isNULL( ll_instance )) AND (ls_queriedParentName = ls_parentName OR isNULL( ls_queriedparentName )) THEN
					
						ls_label = lds_objProps.getItemString( ll_index, "propertylabel")
						ls_value = lds_objProps.getItemString( ll_index, "propertyvalue")

						IF not ISNULL( ls_label ) AND not ISNULL( ls_value ) THEN
							ldrg_object.dynamic of_setProperty( ls_label, ls_value )
							
						END IF	
									
					END IF
				NEXT
				
			END IF
		END IF
	END IF
END IF
Destroy lds_objProps
return 1
end function

public function integer of_setmouseovers (powerobject apo_object, window aw_window);/***************************************************************************************
NAME: 			of_setMouseOvers

ACCESS:			public
		
ARGUMENTS: 		
							apo_object:	the object created to have mouse overs set up on it
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
					
					
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :	By Dan 9-01-2005
	

***************************************************************************************/


Int	li_return
int	li_result
int 	ll_findMax
int	li_max2
int	li_index2

String 	ls_response
String	ls_respType
String	ls_textExpr
String	ls_rowTextSet
String	ls_colTextSet
String	ls_colName
String	ls_colDwSet
String	ls_rowDwSet

Long	ll_findIndex
Long	ll_linkid
u_dw 	ldw_dataWindow

u_dw	ldwa_details[]
Window	lw_window

IF isValid( apo_object ) AND isValid( aw_window ) THEN
	IF typeOf( apo_Object ) = datawindow! AND apo_object.triggerEvent("ue_hasIds") = 1 THEN
	
		ldw_dataWindow = apo_object
	
		IF isValid( ids_Mouseovers ) THEN
			DESTROY ids_mouseOvers
		END IF
		
		ids_Mouseovers = CREATE DataStore

		ids_Mouseovers.DataObject = "d_mouseoverresponses"
		ids_Mouseovers.SetTransObject(SQLCA)
		ids_Mouseovers.Retrieve( ldw_dataWindow.of_GetObjName() )
			
		ll_findMax = ids_MouseOvers.RowCount()
		FOR ll_findIndex = 1 TO ll_findMax    //here
			li_result = ldw_dataWindow.of_setMouseOver( TRUE )
			
			IF  li_result = 1 OR li_result = 0 OR IsValid (ldw_dataWindow.inv_MouseOver) THEN
				ldw_dataWindow.inv_mouseOver.of_setParentWindow( aw_window )
				
				ldw_dataWindow.setRedraw( true )
				
				//get the response type and set it
				ls_response = ids_MouseOvers.getItemString(ll_findIndex, "response" )
				ls_respType = ids_MouseOvers.getItemString(ll_findIndex, "responsetype")
				//rest of the needed information
				//and set the row mouseover.
				IF ls_response = "row" THEN
						
					//if the response is text, then get the text expression, and  set the mouseover
					//to a row/text response.
					IF ls_respType = "text" THEN
						ls_textExpr = ids_MouseOvers.getItemString( ll_findIndex, "textexpression" )
		
						IF NOT isNULL( ls_textExpr ) THEN
							ldw_dataWindow.inv_mouseOver.of_mouseOverOn( )
							li_Result = ldw_dataWindow.inv_mouseOver.of_setTextResponse( "[row]", ls_textExpr)
							IF li_Result = 1 THEN
								ls_RowTextSet = "Text:'" + ls_textExpr +  "'"  +" Mouseover " + "ROW~n"
							END IF
							li_return = 1
						ELSE
							//invalid expression
							li_return = -1
						END IF
						
						
					//set the mouseover as a row and datawindow response
					ELSEIF ls_respType = "dw" THEN
						ls_colName = ids_MouseOvers.getItemString( ll_findIndex, "columnname" )
						ll_linkId = ids_MouseOvers.getItemNumber( ll_findIndex, "linkid" )
						
						
						//if the information is valid, look through the current dw's details, and find 
						//the correct linkid. Once that link id is found, set up the mouseover dw response.
						IF NOT isNULL(ll_linkId) AND isValid( ldw_dataWindow.inv_linkage ) THEN
										
							ldw_dataWindow.inv_linkage.of_getDetails(ldwa_details)
							li_max2 = upperBound( ldwa_details )
							
							
							for li_index2 = 1 to li_max2
								
								IF ll_linkID = ldwa_details[li_index2].inv_linkage.of_getLinkId()  THEN
									ldw_dataWindow.inv_mouseOver.of_mouseOverOn( )
									li_Result = ldw_dataWindow.inv_mouseOver.of_setDwResponse( "[row]", ldwa_details[li_index2])
									IF li_Result = 1 THEN
										ldwa_details[li_index2].visible = false
										ls_RowDWSet += "DataWindow: " + ldwa_details[li_index2].Title +" Mouseover " + "ROW~n"
									END IF
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
						ls_textExpr = ids_MouseOvers.getItemString( ll_findIndex, "textexpression" )
						ls_colName = ids_MouseOvers.getItemString( ll_findIndex, "columnname" )
						
						IF NOT isNULL( ls_textExpr ) THEN
							ldw_dataWindow.inv_mouseOver.of_mouseOverOn( )
							li_Result = ldw_dataWindow.inv_mouseOver.of_setTextResponse( ls_colName, ls_textExpr)
							IF li_Result = 1 THEN
								ls_ColTextSet += "Text:'" + ls_textExpr + "'" +" Mouseover " + ls_ColName + "~n"
							END IF
							li_return = 1
						
						ELSE
							//invalid expression
							li_return = -1
						END IF
							
					//set up the col/dw response		
					ELSEIF ls_respType = "dw" THEN
						ls_colName = ids_MouseOvers.getItemString( ll_findIndex, "columnname" )
					//	ls_detailName = ids_MouseOvers.getItemString( ll_findIndex, "dynamiclinks_detailname" )
						ll_linkId = ids_MouseOvers.getItemNumber( ll_findIndex, "linkid" )
				
						//get the details of the current dw and look for the correct link id.
						//Once its found, set up the dw mouseover.
						IF NOT isNULL( ls_colName ) AND NOT isNULL(ll_linkId) AND isValid( ldw_dataWindow.inv_linkage ) THEN
							ldw_dataWindow.inv_linkage.of_getDetails(ldwa_details)
							li_max2 = upperBound( ldwa_details )
							for li_index2 = 1 to li_max2
								//MessageBox("detail anme", ldwa_details[li_index2].ClassName())
								IF ll_linkID = ldwa_details[li_index2].inv_linkage.of_getLinkId()  THEN
									ldw_dataWindow.inv_mouseOver.of_mouseOverOn( )
									li_result = ldw_dataWindow.inv_mouseOver.of_setDwResponse( ls_colName, ldwa_details[li_index2])
									IF li_result = 1 THEN
										ldwa_details[li_index2].visible = false
										ls_ColDwSet += "DataWindow: " + ldwa_details[li_index2].Title +" Mouseover " + ls_ColName + "~n"
									END IF	
								END IF
							next
							
							li_return  = 1
						ELSE
							//there is no current link with a " )//+ ldw_DataWindow.ClassName())
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
		NEXT //inserted here	
	
	ELSEIF typeOf( apo_object ) = window! THEN
		
		
		lw_window = apo_object
		li_max2 = upperBound( lw_window.control )
		FOR li_index2 = 1 TO li_max2
			of_setMouseOvers( lw_window.control[li_index2], lw_window )
		NEXT	
	END IF
ELSE
	li_return = -1
END IF	



return li_return
end function

public function integer of_loadlinkages (w_master aw_window);/***************************************************************************************
NAME: 		of_loadlinkages	

ACCESS:			public
		
ARGUMENTS: 		
							aw_window: the window having linkages set up on it's controlers

RETURNS:			
	
DESCRIPTION:  Sets up linkages between datawindows that were created on aw_window.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 	9-27-2006
	

***************************************************************************************/

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

Long 		ll_linkageRowCount
Long		ll_argsRowCount
Long		ll_linkID

int		li_max
int		li_index
int		li_instance
long		ll_findIndex
long		ll_detailIndex
int		li_detailInstance
long		ll_argIndex
int		li_return


u_dw 		ldw_dataWindow
u_dw		ldw_detailDw

Datastore	lds_linkages
Datastore	lds_linkArgs
Window	lwa_childWindows[]

//initialize caches, the first one contains details of linkages between 
//u_dw's on the window passed in
IF NOT IsValid( lds_linkages )THEN
	lds_linkages = create DataStore
	lds_linkages.DataObject = "d_dynamiclinkages"
	lds_linkages.SetTransObject( SQLCA )	
END IF

//this cache contains information about all of the arguments for any links possible
//for u_dw's on the window.
IF NOT IsValid( lds_linkargs )THEN
	lds_linkargs = create DataStore
	lds_linkargs.DataObject = "d_dynamiclinkargs"
	lds_linkargs.SetTransObject( SQLCA )	
END IF

COMMIT;

//sets up both data stores
//isa_ObjectNames is an array loaded with all of the names of objects as 
//they are initialized 
ll_linkageRowCount = lds_linkages.retrieve( isa_ObjectNames )
ll_argsRowCount = lds_linkargs.retrieve( isa_ObjectNames )
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
		IF aw_window.control[li_index].triggerEvent("ue_hasIds") = 1 AND typeOf(aw_window.control[li_index]) = datawindow! AND aw_window.control[li_index].triggerEvent( "ue_isTab" ) <> 1 THEN
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
				
				ll_findIndex = lds_linkages.find(ls_findString, ll_findIndex, ll_linkageRowCount)
				
				//if we found a linkage that matches ldw_dataWindow, it is a master.
				//Now try to find its detail
				IF ll_findIndex > 0 THEN
					
				
					//all the detail data for the detail on the window that we need to find
					ls_detailName = lds_linkages.getItemString(ll_findIndex, "detailName")
					ls_detailParent = lds_linkages.getItemString(ll_findIndex, "detailContainer")
					li_detailInstance = lds_linkages.getItemNumber(ll_findIndex, "detailInstance")
					ll_linkId	= lds_linkages.getItemNumber(ll_findIndex, "linkid")
					
					//loop through control of the window to find the correct detail.
					for ll_detailINdex = 1 to li_max
						
						IF aw_window.control[ll_detailIndex].triggerEvent("ue_hasIds") = 1 AND typeOf(aw_window.control[li_index]) = datawindow! AND aw_window.control[ll_detailIndex].triggerEvent( "ue_isTab" ) <> 1 THEN
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
									
									ll_ArgIndex = lds_linkargs.find(ls_findStyle, ll_ArgIndex, ll_argsRowCount)
									
									
									//if we found it, then set the linkages between the two objects with the correct
									//style.
									IF ll_argIndex > 0 THEN		
										ls_linkStyle = lds_linkargs.getItemString(ll_argIndex, "dynamiclinks_style")
												
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
										ls_MasterColumn = lds_linkargs.getItemString(ll_argIndex, "dynamicdetailarguments_mastercolumn")
										ls_detailColumn = lds_linkargs.getItemString(ll_argIndex, "dynamicdetailarguments_detailColumn")	
										
										//if at least one argument has to be set, then there could be more, 
										//set the argument we have, then look for more and set those.
										IF not ISNULL(ls_MasterColumn) AND not ISNULL(ls_detailColumn) THEN
											ldw_detailDw.inv_linkage.of_setArguments(ls_MasterColumn, ls_detailColumn)
													
											//finds the next argument matching link id
									
											DO WHILE ll_ArgIndex > 0 
	
												IF ll_argINdex > 0 THEN
													ls_MasterColumn = lds_linkargs.getItemString(ll_argIndex, "dynamicdetailarguments_masterColumn")
													ls_detailColumn = lds_linkargs.getItemString(ll_argIndex, "dynamicdetailarguments_detailColumn")	
													ldw_detailDw.inv_linkage.of_setArguments(ls_MasterColumn, ls_detailColumn)
					
												END IF
												
												ll_argIndex ++
												IF ll_argIndex > ll_argsRowCount THEN 
													ll_argIndex = 0
												END IF
												
												IF ll_argIndex > 0 THEN
													ll_ArgIndex = lds_linkargs.find(ls_findStyle, ll_ArgIndex, ll_argsRowCount)
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
	li_return = 1
ELSE 
	li_return = ll_linkageRowCount
END IF

Destroy lds_linkages
Destroy lds_linkArgs
return li_return
end function

private function integer of_displayobject ();/***************************************************************************************
NAME: 			of_DisplayObject

ACCESS:			private
		
ARGUMENTS: 		
							none

RETURNS:		Integer
	
DESCRIPTION:  	Allows the user to preview the selected object 
					before creating it on the screen.  
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created by dan 9-14-2005
Modified 4/4/06 Maury - Check return codes and added error checking		     
	

***************************************************************************************/
Integer	li_Return = 1
Long		ll_currentRow
Long		ll_index
Long		ll_max

u_dw		ldw_temp

String	ls_objectName
String	ls_className
String	ls_type
String	ls_label
String	ls_value

String	ls_requesterParentName

//String	ls_parentName
W_master		lw_window
DragObject	ldrg_object

//if there is an object being viewed already, then we want to close that object 
//before opening up a new one for viewing
IF NOT isNULL( ipo_object ) THEN
	iw_requester.closeUserObject( ipo_object )
END IF


ll_currentRow = dw_abstracts.getRow( )

IF ll_CurrentRow > 0 THEN
	//all necessary info to create the object
	ls_objectName = dw_abstracts.getItemString( ll_currentRow, "name")
	ls_className = dw_abstracts.getItemString( ll_currentRow, "classname")
	ls_type = dw_abstracts.getItemString( ll_currentRow, "type")
	IF isNull(ls_ClassName) OR ls_Type = "window" THEN //Cannot view windows
		li_Return = -1
	END IF
ELSE
	li_Return = -1
END IF

//i need to know what the requester parent name is for later on,
//if the requester has a valid parent name, then it isn't possible
//to open up a window on it.
IF li_Return = 1 THEN
	IF iw_requester.triggerEvent( "ue_hasids" ) = 1 THEN
		ls_requesterParentName = iw_requester.dynamic of_getObjName()
		IF trim( ls_requesterParentName ) = "" THEN
			setNull( ls_requesterParentName )
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	//if it is valid, then the data may be invalid, so we should destroy it
	IF isValid( ids_objProps ) THEN
		Destroy ids_objProps
	END IF
	
	//set up the datastore for the currently selected object to be viewed
	ids_objProps = Create datastore
	ids_objProps.dataObject = "d_dynamiccreateproperties"
	ids_objProps.setTransObject( SQLCA )
	
	IF not ISNULL( ls_objectName ) THEN
		IF ids_objProps.retrieve( ls_objectName ) <= 0 THEN
			li_Return = -1
		ELSE
			commit;
		END IF
	END IF

END IF

//this makes sure that at least one abstract property is defined in order for the
//object to be created.
IF li_Return = 1 THEN
	ll_max = ids_objProps.rowCount()
	
	// open up the select object in the preview position
	IF ls_type = "datawindow" OR ls_type = "tab" THEN
		OpenUserObject ( ldrg_object, ls_className, 60, 1320 )
		
		ipo_Object = ldrg_object
		
		//turn of rbutton menus and dragservice on the previewed window.
		IF ls_type = "datawindow" THEN
			ldw_temp = ipo_object
			ldw_temp.of_setdeleteable( false )
			ldw_temp.of_setinsertable( FALSE )
			ldw_temp.of_setdragservice( FALSE )
		END IF
		
	ELSE
		li_Return = -1
	END IF
	
	
END IF

IF li_Return = 1 THEN//set up all the properties of the viewable object
	
	FOR ll_index = ll_max TO 1 step -1
		
		ls_label = ids_objProps.getItemString( ll_index, "propertylabel")
		ls_value = ids_objProps.getItemString( ll_index, "propertyvalue")
		
		
		//we the only properties we don't want to set are positional properties
		//since we want the object to appear in the viewable area
		IF not ISNULL( ls_label ) AND not ISNULL( ls_value ) THEN
			IF ls_label <> "X" AND ls_label <> "Y" and ls_label <> "visible" AND NOT match(ls_label, "^[0-9]+$" ) THEN
				IF isValid(ipo_object) THEN
					ipo_object.dynamic of_setProperty( ls_label, ls_value )
				END IF
			END IF
		END IF		
	NEXT
		
END IF

Return li_Return

end function

on w_dynamicinstantiate.create
int iCurrent
call super::create
this.dw_objtypes=create dw_objtypes
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_create=create cb_create
this.dw_abstracts=create dw_abstracts
this.cb_1=create cb_1
this.gb_type=create gb_type
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_objtypes
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_create
this.Control[iCurrent+5]=this.dw_abstracts
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_type
this.Control[iCurrent+8]=this.ln_1
end on

on w_dynamicinstantiate.destroy
call super::destroy
destroy(this.dw_objtypes)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_create)
destroy(this.dw_abstracts)
destroy(this.cb_1)
destroy(this.gb_type)
destroy(this.ln_1)
end on

event open;call super::open;Long		li_X
Long		li_Y
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm


IF isValid(Message.PowerObjectParm) THEN
	
	lnv_Msg = Message.PowerObjectParm 
	
	
	IF lnv_Msg.of_Get_parm("REQUESTOR", lstr_Parm ) > 0 THEN
		This.of_SetRequester(lstr_Parm.ia_value)
	END IF
	
	
	
	IF lnv_Msg.of_Get_Parm("X", lstr_Parm) > 0 THEN
		li_X = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm("Y", lstr_Parm) > 0 THEN
		li_Y = lstr_Parm.ia_Value
	END IF
	
	This.of_SetPosition(li_X, li_Y)
	
	
END IF


dw_abstracts.setTransObject( SQLCA )

dw_abstracts.post retrieve()

COMMIT;

dw_objtypes.SetItem(1, "obj_type", 1)

end event

event close;call super::close;//adds all children windows that may have ben created dynamically to the requester children window array.

Int	li_index
Int 	li_max
n_cst_bso_dynamicObjectManager lnv_manager

li_max = upperBound( iwa_createdWindows )
//set up linkages and mouseovers for windows that are created.
FOR li_index = 1 TO li_max
	IF isValid( iwa_createdWindows[li_index] ) THEN
		//added 3-17-06 to so that the linkage cache can be updated with the newlinkages that may have been created
		IF not IsValid( lnv_manager ) THEN
			iwa_createdwindows[li_index].of_getdynpropmansrvc( lnv_manager )
			IF isValid( lnv_manager ) THEN
				lnv_manager.of_addobjnamestolist( isa_objectnames )
			END IF
		END IF
		
		iw_requester.dynamic of_addChildWindow( iwa_createdWindows[li_index] )
		this.of_loadLinkages( iwa_createdWindows[li_index] )
		this.of_setMouseOvers( iwa_createdWindows[li_index], iw_requester )
		iwa_createdWindows[li_index].triggerEvent("ue_refreshDws")
	END IF	
NEXT




//set up mouseovers for objects that are created
li_max = upperBound( ipoa_createdObjects )
FOR li_index = 1 TO li_max
	IF isValid( ipoa_createdObjects[li_index] ) THEN
		this.of_setMouseOvers( ipoa_createdObjects[li_index], iw_requester )
		ipoa_createdObjects[li_index].triggerEvent("ue_reload")
	END IF
NEXT

//close previewed objects
IF isValid( ipo_object ) THEN
	IF typeOf( ipo_object ) <> WINDOW! THEN
		this.closeUserObject( ipo_object )
	END IF
END IF
end event

event closequery;//overriding ancestor
end event

type cb_help from w_response`cb_help within w_dynamicinstantiate
boolean visible = false
integer x = 2683
integer y = 1344
end type

type dw_objtypes from u_dw within w_dynamicinstantiate
integer x = 46
integer y = 60
integer width = 2693
integer height = 176
integer taborder = 0
string dataobject = "d_objtypes"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;Long	ll_Index
Long	ll_Max
String	ls_ObjName
Boolean	lb_Template

dw_abstracts.SelectRow(0, FALSE)
//cb_Create.Enabled = FALSE
//cb_View.Enabled = FALSE

IF dwo.Name = "obj_type" THEN
	This.Object.l_1.Visible = FALSE
	This.Object.l_2.Visible = FALSE
	This.Object.obj_subtype.Visible = FALSE
	CHOOSE CASE data
		CASE "1"
			dw_abstracts.SetFilter("")
		CASE "2"
			dw_abstracts.SetFilter("pos(name , 'Template') > 0")
			dw_abstracts.Filter()
			lb_Template = TRUE
		CASE "3"
			dw_Abstracts.SetFilter("Type = 'datawindow'")
			This.Object.l_1.Visible = TRUE
			This.Object.l_2.Visible = TRUE
			This.Object.obj_subtype.Visible = TRUE
			This.SetItem(1, "obj_SubType", 0 ) 
		CASE "4"
			dw_Abstracts.SetFilter("Type = 'window'")
		CASE "5"
			dw_Abstracts.SetFilter("Type = 'tab'")
		CASE "6"
			dw_Abstracts.SetFilter("ClassName = 'u_dw_quickmatch' OR ClassName = 'u_dw_admintool'")
	END CHOOSE
	
END IF

IF dwo.Name = "obj_subtype" THEN
		CHOOSE CASE data
		CASE "1"
			dw_Abstracts.SetFilter("ClassName = 'u_dw_tcard_shipments'")
		CASE "2"
			dw_Abstracts.SetFilter("ClassName = 'u_dw_tcard_equipment'")
		CASE "3"
			dw_Abstracts.SetFilter("ClassName = 'u_dw_tcard_drivers'")
	END CHOOSE
END IF

IF NOT lb_Template THEN
	dw_abstracts.Filter()
END IF
dw_abstracts.Sort()

IF dw_Abstracts.RowCount() > 0 THEN
	dw_Abstracts.SetRow(1)
	dw_abstracts.SelectRow(1, TRUE)
	dw_Abstracts.Event rowFocusChanged(1)
END IF

end event

event constructor;call super::constructor;This.InsertRow(0)
end event

type st_1 from statictext within w_dynamicinstantiate
integer x = 50
integer y = 1040
integer width = 1010
integer height = 248
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_dynamicinstantiate
integer x = 2350
integer y = 1060
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cance&l"
boolean cancel = true
end type

event clicked;/***************************************************************************************
NAME: 			cancel click

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			none
	
DESCRIPTION:  Clicking the cancel button closes all created objects that were created in 
					the lifetime of this dialogue, and closes the dialogue itself.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	9-15-2005
	

***************************************************************************************/
Int 	li_index
Int	li_max
Int 	li_result

li_max = upperBound( ipoa_createdObjects )


IF upperBound( ipoa_createdObjects ) > 0 OR upperBound( iwa_createdWindows )> 0 THEN
	IF li_max > 0 OR upperBound(iwa_createdWindows) > 0 THEN
		li_result = MessageBox("Create", "Cancel will cause all created objects in this session to be destroyed. Do you wish to continue?", &
						question!, yesno!)
	END IF	
	
	IF li_result = 1 THEN 
		FOR li_index = 1 TO li_max
			IF isValid( ipoa_createdObjects[li_index] ) THEN
				parent.closeUserObject( ipoa_createdObjects[li_index] )
			END IF
		NEXT
		
		li_max = upperBound( iwa_createdWindows )
		
		FOR li_index = 1 TO li_max
			IF isValid( iwa_createdWindows[li_index] ) THEN
				close ( iwa_createdWindows[li_index] )
			END IF
		NEXT
		
		close( w_dynamicInstantiate )
	
	ELSE
		st_1.text = "To keep newly created objects, close this window"
	END IF
ELSE
	close( this.getParent() )
END IF
end event

type cb_create from commandbutton within w_dynamicinstantiate
integer x = 1486
integer y = 1060
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Create"
boolean default = true
end type

event clicked;/***************************************************************************************
NAME: 			clicked create

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			none
	
DESCRIPTION:	CLicking of this button is disabled when trying to create an instance of a window
					on itself.
					
					The object is created where the user clicked to open up the window on the parent
					window that they want the object created on.  
					
					Mouseovers are set up however for any object that can have text mouseovers on them
					once they are created.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	9-14-2005
	

***************************************************************************************/

Long		ll_currentRow
Long		ll_index
Long		ll_max
Int		li_arrayIndex
Long		ll_instance
Long		ll_queryInst
Int		li_openResult

String	ls_objectName
String	ls_className
String	ls_queryName
String	ls_type
String	ls_label
String	ls_value
String	ls_controlName
String	ls_findString
Long		ll_controlInstance

String	ls_requesterParentName

//String	ls_parentName
W_master		lw_window
DragObject	ldrg_object

PowerObject lpo_nullObject
n_cst_bso_dynamicObjectManager lnv_manager


parent.closeUserObject( ipo_object ) 

ll_currentRow = dw_abstracts.getRow( )


//all necessary info to create the object
ls_objectName = dw_abstracts.getItemString( ll_currentRow, "name")
ls_className = dw_abstracts.getItemString( ll_currentRow, "classname")
ls_type = dw_abstracts.getItemString( ll_currentRow, "type")

//i need to know what the requester parent name is for later on,
//if the requester has a valid parent name, then it isn't possible
//to open up a window on it.
IF iw_requester.triggerEvent( "ue_hasids" ) = 1 THEN
	ls_requesterParentName = iw_requester.dynamic of_getParentName()
	IF trim( ls_requesterParentName ) = "" THEN
		setNull( ls_requesterParentName )
	END IF
END IF

//if it is valid, then the data may be invalid, so we should destroy it
IF isValid( ids_objProps ) THEN
	Destroy ids_objProps
END IF

//set up the datastore for the currently selected object to be viewed

ids_objProps = Create datastore
ids_objProps.dataObject = "d_dynamiccreateproperties"
ids_objProps.setTransObject( SQLCA )

IF not ISNULL( ls_objectName ) THEN
	ids_objProps.retrieve( ls_objectName )
	COMMIT;

END IF

ll_max = ids_objProps.rowCount()


//this makes sure that at least one abstract property is defined in order for the
//object to be created.
IF ll_max > 0 THEN
	
	//this closes the previewed object 
	IF NOT isNULL( ipo_object ) THEN
		iw_requester.closeUserObject( ipo_object )
	END IF
	
	IF NOT isNULL( ls_className ) AND NOT isNULL( ii_xpos ) AND NOT isNULL( ii_ypos )THEN 
	
	
		//opening procedure for a datawindow
		IF ls_type = "datawindow" OR ls_type = "tab" THEN
			li_openResult = iw_requester.OpenUserObject ( ldrg_object, ls_className, ii_xpos, ii_ypos )
			
			ipo_Object = ldrg_object
			
			
			IF isValid( ipo_object ) THEN
				//add the object to the array of created objects in case they press cancel
				li_arrayIndex = upperBound( ipoa_createdObjects )
				ipoa_createdObjects[ li_arrayIndex + 1 ] = ipo_object
			
				//we must get the parents dynamic property manager and give it to the newly created
				//object so that it can be saved later on.
				iw_requester.dynamic of_getDynPropManSrvc( lnv_manager )
				
				//add the object to a list of objects that may have to be closed
				lnv_manager.of_addopeneduserobject( ldrg_object )
				
				ipo_object.dynamic EVENT ue_setdynpropmansrvc( lnv_manager )
			
			
				//get and give the new object a unique instance number, then set all the identifiers
				ll_instance = of_getinstancenumber( ls_objectName, ls_type )
				
				ipo_object.dynamic EVENT ue_setidentifiers( ls_objectName, ll_instance)
				ipo_object.dynamic EVENT ue_setParentName( iw_requester.dynamic of_getObjName() )
				
				st_1.Text = "Created '" + ls_ObjectName + "' (instance " + String(ll_instance) + ") sucessfully."
			
			ELSE
				MessageBox( "Creation Error", "'"+ls_objectName+"'" + " could not be created" )
			END IF
			
			
		//opening a window procedure	
		ELSEIF ls_type = "window" AND isNULL( ls_requesterParentName ) THEN
			li_openResult = open( lw_window, "w_child", iw_requester )
			ipo_object = lw_window
			
			IF isValid( ipo_object ) THEN
				//add it to the array of created windows in case a cancel call is made
				li_arrayIndex = upperBound( iwa_createdWindows )
				iwa_createdWindows[ li_arrayIndex + 1 ] = ipo_object
			
			   //we must get the parents dynamic property manager and give it to the newly created
				//object so that it can be saved later on.
				iw_requester.dynamic of_getDynPropManSrvc( lnv_manager )
				ipo_object.dynamic EVENT ue_setdynpropmansrvc( lnv_manager )
			
			
				//get and assign a unique instance number to the window
				ll_instance = of_getinstancenumber( ls_objectName, ls_type )
				ipo_object.dynamic EVENT ue_setidentifiers( ls_objectName, ll_instance)
				ipo_object.dynamic EVENT ue_setParentName( iw_requester.dynamic of_getObjName() )
				
				st_1.Text = "Created '" + ls_ObjectName + "' (instance " + String(ll_instance) + ") sucessfully."
			ELSE
				MessageBox( "Creation Error", "'"+ls_objectName+"'" + " could not be created" )
			END IF
		END IF
		
		
		//set all the properties of the viewable object
		FOR ll_index = ll_max TO 1 Step -1
			
			ls_queryName = ids_objProps.getItemString( ll_index, "objectname" )
			
			//only set properties for the newly created object
			IF ls_objectName = ls_queryName THEN
				ls_label = ids_objProps.getItemString( ll_index, "propertylabel")
				ls_value = ids_objProps.getItemString( ll_index, "propertyvalue")
				
				//Tac on instance number to title
				IF ls_Label = "title" THEN
					IF ll_Instance > 1 THEN
						ls_Value += "("+String(ll_Instance)+")"
					END IF
				END IF
				
				IF not ISNULL( ls_label ) AND not ISNULL( ls_value ) AND not ISNULL( ipo_object ) AND isValid( ipo_object ) THEN
					//we don't want to load any abstract saved settings for x and y, we want to open the object
					//where the user specified by clicking.
					IF ls_label <> "X" AND ls_label <> "Y" AND ls_label <> "visible" AND NOT match(ls_label, "^[0-9]+$" ) THEN
						
						//when creating a dw, only the abstract part of the prefilter should be loaded.
						//Since of_setProperty expects the abstract first, then the instance second, it 
						//appends the second thing onto the first.  This is what we wanted for loading
						//user settings, but not for recreation.
						IF ls_label = "prefilter" THEN
											
							ipo_object.dynamic of_setPrefilter( ls_value )
							
						ELSE
							ipo_object.dynamic of_setProperty( ls_label, ls_value )
						END IF
					END IF
				END IF	
				
			END IF	
			
			
		NEXT
		
		//If the object created is a window, then we need to create instances that are part of that windows
		//abstract definition.  Children windows can't have children, so types of "window" will not be recreated.
		IF ls_type = "window" THEN
			ll_index = 1
			
			//find all children objects of the newly created object and get all there properties for
			//creation of those children on the newly created window.
			
			ls_findString = "containername = '"+ ls_objectName + "'" &
								 +" AND isNULL( username ) " &
								 +" AND NOT isNULL( instance )" 
			//ll_index = ids_objprops.find( ls_findString, ll_index, ll_max )
			
			//ll_index = 1
			ls_queryName = ""
			ll_queryInst = -1
			ls_controlName = ""
			
			ll_controlInstance = -1
			
			
			ids_objProps.setSort ("objectname A, containername D, instance D")
			ids_objProps.sort()
			
	
			FOR ll_index = 1 TO ll_max
				
				IF ll_index <> 1 AND( ls_controlName <> ls_queryName OR ll_controlInstance <> ll_queryInst )THEN
					ll_queryInst = ll_controlInstance
					ls_queryName = ls_controlName
				END IF
				
				IF not isnull(ids_objProps.getItemNumber( ll_index, "instance")) THEN
				
					ls_controlName = ids_objProps.getItemString( ll_index, "objectname")
					ll_controlInstance = ids_objProps.getItemNumber( ll_index, "instance")
				END IF
				
				IF ls_controlName <> ls_queryName OR ll_controlInstance <> ll_queryInst THEN
		
					of_setControl(ids_objProps, lw_window, ls_controlName, ll_controlInstance)
					
					//add them to the name array so that the linkages can be loaded on them
					isa_objectNames[ upperBound(isa_objectNames) + 1] = ls_controlName
				END IF
				
				
			NEXT
			lw_window.inv_mypropmanager.of_loadTabs( lw_window )
			ipo_object.triggerEvent( "ue_forceRefresh")
		END IF

		//once an object is created we don't want to have access to it from this window through
		//any means besides cancelation.
		ipo_object = lpo_nullObject	
	END IF
END IF
end event

type dw_abstracts from u_dw within w_dynamicinstantiate
integer x = 41
integer y = 276
integer width = 2706
integer height = 728
integer taborder = 0
string dataobject = "d_dynamicobjects"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;This.of_SetInsertable(FALSE)
This.of_SetDeleteable(FALSE)

this.of_setRowSelect( true )
this.inv_rowSelect.of_setRequestor( this )
this.inv_rowSelect.of_setStyle( 0 )
end event

event rowfocuschanged;call super::rowfocuschanged;/***************************************************************************************
NAME: 		rowFocusChanged	

ACCESS:		public	
		
ARGUMENTS: 		
							currentrow

RETURNS:			long
	
DESCRIPTION:  The following will enable and disable certain buttons on the dialogue
					based on the selection that is made in this datawindow.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	9-13-2005
	

***************************************************************************************/

String 	ls_type
String	ls_name
String	ls_parentName
String	ls_grandParentName

this.setRow( currentRow )

//it the type is a window


ls_type = dw_abstracts.getItemString( currentRow, "type" )
ls_name = dw_abstracts.getItemString( currentRow, "name" )


Parent.of_DisplayObject()


IF not isNULL( iw_requester ) AND isValid( iw_requester ) THEN
	IF iw_requester.triggerEvent( "ue_hasids" ) = 1 THEN
		ls_parentName = iw_requester.dynamic of_getObjName( )
		ls_grandParentName = iw_requester.dynamic of_getParentName( )
		
		IF trim( ls_parentName ) = "" THEN
			setNull(ls_parentName)
		END IF
		
		
		//we don't want to beable to create a win1 on a win1, so make the enabled condition fail 
		//in following script
		IF  ls_parentName <> ls_name THEN
			setNull( ls_parentName )
			st_1.text = ""
		ELSE
			st_1.text = ls_name + " cannot be created on another "+ls_name
		END IF

		IF ls_grandParentName = "" THEN
			setNull( ls_grandParentName )

		END IF

		
	END IF
	
	IF isNULL( ls_parentName ) THEN
		cb_create.enabled = true
	ELSE
		cb_create.enabled = false
	END IF
	
	
	//if the window that was clicked on is a child window, 
	//and the item selected is of type window then they cannot
	//create the item.
	
	IF not isNULL( ls_grandParentName ) AND ls_type = "window" THEN
		cb_create.enabled = false
		st_1.text = "A window cannot be created on a child window"
	ELSE

	//	st_1.text = ""
	//	cb_create.enabled = true
	END IF
	
END IF
end event

event doubleclicked;call super::doubleclicked;IF cb_create.enabled THEN
	cb_create.event clicked( )
END IF
end event

type cb_1 from commandbutton within w_dynamicinstantiate
integer x = 1920
integer y = 1060
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Do&ne"
end type

event clicked;Close(w_DynamicInstantiate)
end event

type gb_type from groupbox within w_dynamicinstantiate
integer x = 37
integer width = 2711
integer height = 260
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Display"
end type

type ln_1 from line within w_dynamicinstantiate
integer linethickness = 4
integer beginx = 59
integer beginy = 1308
integer endx = 2752
integer endy = 1308
end type

