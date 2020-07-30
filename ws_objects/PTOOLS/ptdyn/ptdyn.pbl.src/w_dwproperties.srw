$PBExportHeader$w_dwproperties.srw
forward
global type w_dwproperties from w_response
end type
type tab_dwproperties from tab within w_dwproperties
end type
type tabpage_general from userobject within tab_dwproperties
end type
type dw_generalproperties from u_dw within tabpage_general
end type
type tabpage_general from userobject within tab_dwproperties
dw_generalproperties dw_generalproperties
end type
type tabpage_mouseover from userobject within tab_dwproperties
end type
type st_note from statictext within tabpage_mouseover
end type
type st_instructions from statictext within tabpage_mouseover
end type
type cbx_viewall from checkbox within tabpage_mouseover
end type
type dw_mouseoverresponses from u_dw within tabpage_mouseover
end type
type dw_columndisplay from u_dw within tabpage_mouseover
end type
type tabpage_mouseover from userobject within tab_dwproperties
st_note st_note
st_instructions st_instructions
cbx_viewall cbx_viewall
dw_mouseoverresponses dw_mouseoverresponses
dw_columndisplay dw_columndisplay
end type
type tab_dwproperties from tab within w_dwproperties
tabpage_general tabpage_general
tabpage_mouseover tabpage_mouseover
end type
type cb_applyall from commandbutton within w_dwproperties
end type
end forward

global type w_dwproperties from w_response
integer x = 214
integer y = 221
integer width = 3159
integer height = 1764
string title = "DataWindow Properties"
long backcolor = 12632256
boolean ib_disableclosequery = true
event ue_undo ( )
tab_dwproperties tab_dwproperties
cb_applyall cb_applyall
end type
global w_dwproperties w_dwproperties

type variables
Integer ci_Checked = 1
Integer ci_UnChecked = 0

String	is_Filter
Boolean	ib_IsWatchList

u_dw		idw_CurrentProp

n_cst_string 	inv_StringService
n_cst_dwsrv		inv_dwsrv

DataStore		ids_Mouseovers
DataStore		ids_Links

Constant	String	cs_Template = "DataWindow Template"
Constant String	cs_WindowTemplate = "Window Template"

n_cst_stack		inv_Stack
n_cst_LinkedListNode		inv_LLNode




end variables

forward prototypes
public function integer of_resetcache ()
public function integer of_recreatemouseovers (window aw_window)
public function integer of_updatefilter (string as_absprefilter, string as_instprefilter)
public function integer of_validateexpression (string as_expression)
public function integer of_validatemouseovertextexpression (string as_expression)
public function boolean of_focusitem (string as_objname)
public function boolean wf_generalmodified ()
public function boolean wf_mouseovermodified ()
private function integer wf_apply ()
private function integer of_applymouseover ()
private function integer of_applygeneral ()
end prototypes

event ue_undo();/***************************************************************************************
NAME: 			ue_Undo

ACCESS:			public
		
ARGUMENTS: 		(none)

RETURNS:			none
	
DESCRIPTION: Pops the last dw state off the stack and sets the state of dw_generalproperties
					to the last state. 
					
				Also Forces a column to modified status for saving purposes
					
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/17
	

***************************************************************************************/
ANY	la_LastState
BLOB	lbb_LastState
n_cst_LinkedListNode		lnv_LLNode

lnv_LLNode = CREATE n_cst_LinkedListNode

IF inv_Stack.of_Count() > 0 THEN
	inv_Stack.of_Pop(lnv_LLNode)
	
	//Messagebox("poped",  "popped " + String(inv_Stack.of_Count()))
	
	IF inv_Stack.of_count( ) = 0 THEN
		//Always preserve last state
		inv_Stack.of_Push(lnv_LLNode)
		m_edit_properties.m_edititem.m_undo.enabled = false
	END IF
	IF isValid(lnv_LLNode) THEN
		lnv_LLNode.of_GetData(la_LastState)
		IF NOT isNULL(la_lastState) THEN
			lbb_LastState = la_LastState
		END IF
	END IF
	
	IF NOT isNull(lbb_LastState)  THEN
		tab_dwproperties.tabpage_general.dw_generalproperties.SetFullState(lbb_LastState)
		
		//Force dw_generalproperties to be modified so that it will ask if you want to save on apply
		tab_dwproperties.tabpage_general.dw_generalproperties.SetItemStatus(1, "note", Primary!, DataModified!)
	END IF


	//Set inv_Node to current state
	IF NOT isNull(inv_LLNode) THEN
		inv_LLNode.of_SetData( lbb_LastState )
	END IF


END IF

end event

public function integer of_resetcache ();/***************************************************************************************
NAME: 			of_resetCache

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			returns 1 if the cache we are updating is valid, -1 othwise
	
DESCRIPTION:  THe following updates the cache so that it contains the user settings for mouseovers.
					First it removes any old mouseovers from the cache, and then it inserts the new ones.
					
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 	9-1202005
	

***************************************************************************************/
Int	li_return
Long	ll_index
Long	ll_max
Long	ll_linkId
Long	ll_newRow

String	ls_objName
String	ls_response
String	ls_responseType
String	ls_expression
String	ls_colName
u_dw		ldw_MouseoverResponses

ldw_MouseoverResponses = tab_dwproperties.tabpage_mouseover.dw_mouseoverresponses

ldw_MouseOverResponses.AcceptText()

ll_max = ids_mouseOvers.rowCount()

IF isValid( ids_mouseOvers ) THEN
	li_return = 1

	
	//delete all previous mouseOver settings in the cache
	FOR ll_index = ll_max TO 1 STEP -1
		ids_mouseOvers.deleteRow( ll_index )
	NEXT
	
	//reset ll_max for next loop
	ll_max = ldw_MouseoverResponses.rowCount( )
	
	//save visible data to cache
	FOR  ll_index = ll_max TO 1 STEP -1
		//insert the new ones.
		//dw_mouseOverResponses
		
		ls_objName = idw_CurrentProp.of_getObjName()
		
		//if the object name is valid, then there are two possible inserts to the cache per 
		//row in the visible window.  One is a text response, and the other is a dw response.
		
		IF NOT isNULL( ls_objName ) THEN
			ls_colName = ldw_MouseoverResponses.getItemString( ll_index, "columnname" )
			ls_expression = ldw_MouseoverResponses.getItemString( ll_index, "textexpression" )
			ll_linkId = ldw_MouseoverResponses.getItemNumber( ll_index, "linkid" )
			
			//if the col name has "row" in it, then the response type is row, otherwise
			//it is column, and the actual columnname is stored.
			
			IF ls_colName = "Row" THEN
				ls_responseType = "row"
				setNull(ls_colName)
				
			ELSEIF NOT ISNULL( ls_colName ) THEN
				ls_responseType = "col"
				
			END IF
			
			//if there is something listed in ls_expression, then we need to insert a row
			//in the cache for a text response
			
			IF not ISNULL( ls_expression ) AND Len ( ls_expression ) > 0 THEN
				ll_newRow = ids_mouseOvers.insertRow( 0 )
				
				ids_mouseOvers.setItem( ll_newRow, "textexpression", ls_expression )
				ids_mouseovers.setItem( ll_newRow, "response", ls_responseType )
				ids_mouseovers.setItem( ll_newRow, "responseType", "text" )
				ids_mouseovers.setItem( ll_newRow, "objectname", ls_objName )
				ids_mouseOvers.setItem( ll_newRow, "columnname", ls_colName )
				
			END IF
			
			//if there is a linkId listed, then we need to insert a row in the cache
			//for a datawindow response.
			
			IF not ISNULL( ll_linkId ) AND ll_linkId <> 0 THEN
				ll_newRow = ids_mouseOvers.insertRow( 0 )
				
				ids_mouseOvers.setItem( ll_newRow, "linkid", ll_linkId )
				ids_mouseovers.setItem( ll_newRow, "response", ls_responseType)
				ids_mouseovers.setItem( ll_newRow, "responseType", "dw" )
				ids_mouseovers.setItem( ll_newRow, "objectname", ls_objName )
				ids_mouseOvers.setItem( ll_newRow, "columnname", ls_colName )
				
			END IF
			
		END IF
	NEXT
		
	ll_max = ldw_MouseoverResponses.filteredCount()	
		
	//save filtered data to the cache
	FOR  ll_index = ll_max TO 1 STEP -1
		//insert the new ones.
		//ldw_MouseoverResponses
		
		ls_objName = idw_CurrentProp.of_getObjName()
		
		//if the object name is valid, then there are two possible inserts to the cache per 
		//row in the visible window.  One is a text response, and the other is a dw response.
		
		IF NOT isNULL( ls_objName ) THEN
			ls_colName = ldw_MouseoverResponses.getItemString( ll_index, "columnname", filter!, false )
			ls_expression = ldw_MouseoverResponses.getItemString( ll_index, "textexpression", filter!, false)
			ll_linkId = ldw_MouseoverResponses.getItemNumber( ll_index, "linkid", filter!, false )
			
			//if the col name has "row" in it, then the response type is row, otherwise
			//it is column, and the actual columnname is stored.
			
			IF ls_colName = "Row" THEN
				ls_responseType = "row"
				setNull(ls_colName)
				
			ELSEIF NOT ISNULL( ls_colName ) THEN
				ls_responseType = "col"
				
			END IF
			
			//if there is something listed in ls_expression, then we need to insert a row
			//in the cache for a text response
			
			IF not ISNULL( ls_expression ) AND Len( ls_Expression ) > 0 THEN
				ll_newRow = ids_mouseOvers.insertRow( 0 )
				
				ids_mouseOvers.setItem( ll_newRow, "textexpression", ls_expression )
				ids_mouseovers.setItem( ll_newRow, "response", ls_responseType )
				ids_mouseovers.setItem( ll_newRow, "responseType", "text" )
				ids_mouseovers.setItem( ll_newRow, "objectname", ls_objName )
				ids_mouseOvers.setItem( ll_newRow, "columnname", ls_colName )
				
			END IF
			
			
			//if there is a linkId listed, then we need to insert a row in the cache
			//for a datawindow response.
			
			IF not ISNULL( ll_linkId ) AND ll_linkId <> 0 THEN
				ll_newRow = ids_mouseOvers.insertRow( 0 )
				
				ids_mouseOvers.setItem( ll_newRow, "linkid", ll_linkId )
				ids_mouseovers.setItem( ll_newRow, "response", ls_responseType)
				ids_mouseovers.setItem( ll_newRow, "responseType", "dw" )
				ids_mouseovers.setItem( ll_newRow, "objectname", ls_objName )
				ids_mouseOvers.setItem( ll_newRow, "columnname", ls_colName )
				
			END IF
			
		END IF
	NEXT	
	
ELSE
	li_return = -1
END IF

RETURN li_return
end function

public function integer of_recreatemouseovers (window aw_window);/***************************************************************************************
NAME: 			of_recreateMouseOvers

ACCESS:			public
		
ARGUMENTS: 		
							aw_window:  the window on which this function will loop through controls,
							resetting mouseOvers, and then recursing on its children.

RETURNS:			1 if it sets up a mouseOver, -1 otherwise
	
DESCRIPTION:    The following function loops through the controls to find objects of the same type
					 as idw_currentProp, and shuts off all the old mouseOvers, and resets them with 
					 the new mouseOvers.  It then recurses on any children windows.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :	Created By Dan	9-9-05
	

***************************************************************************************/
Int	li_index
Int	li_max
Int	li_return
Int	li_max2
Int	li_index2

long	ll_findIndex
long	ll_linkId
long	ll_findMax
Int	li_result

String	ls_respType
String	ls_response
String	ls_textExpr
String	ls_colName
String	ls_detailName

String	ls_ColTextSet
String	ls_ColDwSet 
String	ls_RowTextSet
String	ls_RowDwSet

Window 	lwa_children[]
u_dw		ldw_dataWindow
u_dw		ldwa_Details[]

IF isValid( aw_window ) AND NOT isNULL( aw_window ) THEN
	li_return = 1
	
	//loop through the controls looking for 
	
	li_max = upperBound( aw_window.control )
	FOR li_index = 1 TO li_max
		IF typeOf( aw_window.control[li_index] ) = dataWindow! AND aw_window.control[li_index].triggerEvent("ue_hasIds") = 1 THEN
			ldw_dataWindow = aw_window.control[li_index]
			IF ldw_dataWindow.of_GetObjName() = idw_currentProp.of_getObjName() THEN
			
				//Set Details to visible state
				IF isValid(ldw_dataWindow.inv_Linkage) THEN
					ldw_dataWindow.inv_linkage.of_getDetails(ldwa_details)
					li_max2 = upperBound( ldwa_details )
					
					for li_index2 = 1 to li_max2
						IF isValid(ldwa_details[li_index2]) THEN
							ldwa_details[li_index2].Visible = TRUE
						END IF
					next
				END IF
			
				//destroy the mouseover
				li_return = ldw_dataWindow.of_setMouseOver( FALSE )
				
				//recreate the mouse over and set it up again.
				IF li_return <> -1 THEN
					ll_findMax = ids_MouseOvers.RowCount()
					FOR ll_findIndex = 1 TO ll_findMax    //here
						li_result = ldw_dataWindow.of_setMouseOver( TRUE )
						IF  li_result = 1 OR li_result = 0 OR IsValid (ldw_dataWindow.inv_MouseOver) THEN
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
									ls_textExpr = ids_MouseOvers.getItemString( ll_findIndex, "textexpression" )
					
									IF NOT isNULL( ls_textExpr ) THEN
										ldw_dataWindow.inv_mouseOver.of_mouseOverOn( )
										li_Result = ldw_dataWindow.inv_mouseOver.of_setTextResponse( "[row]", ls_textExpr)
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
									IF isValid( ldw_dataWindow.inv_linkage ) THEN
													
										ldw_dataWindow.inv_linkage.of_getDetails(ldwa_details)
										li_max2 = upperBound( ldwa_details )
										
										for li_index2 = 1 to li_max2
											IF isValid(ldwa_details[li_index2]) THEN
												IF NOT isNull(ll_LinkId)THEN
													IF ll_linkID = ldwa_details[li_index2].inv_linkage.of_getLinkId()  THEN
														ldw_dataWindow.inv_mouseOver.of_mouseOverOn( )
														li_Result = ldw_dataWindow.inv_mouseOver.of_setDwResponse( "[row]", ldwa_details[li_index2])
														//Hide detail window
														ldwa_details[li_index2].Visible = FALSE
													END IF
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
									IF NOT isNULL( ls_colName ) AND isValid( ldw_dataWindow.inv_linkage ) THEN
										ldw_dataWindow.inv_linkage.of_getDetails(ldwa_details)
										li_max2 = upperBound( ldwa_details )
										for li_index2 = 1 to li_max2
											IF isValid(ldwa_details[li_index2]) THEN
												IF NOT isNull(ll_LinkId) THEN
													IF ll_linkID = ldwa_details[li_index2].inv_linkage.of_getLinkId()  THEN
														ldw_dataWindow.inv_mouseOver.of_mouseOverOn( )
														li_result = ldw_dataWindow.inv_mouseOver.of_setDwResponse( ls_colName, ldwa_details[li_index2])	
														//Hide detal window
														ldwa_details[li_index2].Visible = FALSE
													END IF
												END IF
											END IF
										next
										
										li_return  = 1
									ELSE
										//
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
				END IF	
			END IF
		END IF
	NEXT
	
		
	// if the window passed in has children windows, make the recursive call on 
	// each of them to try and set up linkages from within those tables.
	IF aw_window.triggerEvent( "ue_hasChildrenWindows" ) = 1 THEN
		aw_window.dynamic of_getChildrenWindows(lwa_children)
		
		li_max = upperBound(lwa_children)
		for li_index = 1 to li_max
			IF NOT isNULL( lwa_children[li_index] ) THEN
				this.of_reCreateMouseOvers( lwa_children[li_index] )
				
			END IF
			
		next
		
	END IF
	
ELSE
	li_return = -1
END IF

return li_return
end function

public function integer of_updatefilter (string as_absprefilter, string as_instprefilter);/***************************************************************************************
NAME: 		of_updeateFilter	

ACCESS:		public	
		
ARGUMENTS: 		
							as_absPrefilter    the abstract portion of the prefilter
							as_instprefilter	 the instance level part of the prefilter

RETURNS:			1 if update successful
					-1 otherwise
	
DESCRIPTION:  The following inserts two rows into the database for the current
					object with the specified prefilter.  If the update succeeds, 
					it makes sure that the rows are discarded from the property managers
					cache.				
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 9=-22-2005
	

***************************************************************************************/

Datastore	lds_temp
String		ls_name
String		ls_user
String		ls_parent
String		ls_Label
String		ls_queriedName
String		ls_queriedParent
Long			ll_instance
Long			ll_Index
Long			ll_Max
Long			ll_ThisInstance
Int			li_return


lds_temp = create Datastore
lds_temp.dataObject = "d_dynamicpropertycache"
lds_temp.setTransObject( SQLCA )


ls_name = idw_CurrentProp.of_getObjname( )
ls_parent =  idw_CurrentProp.of_getparentname( )
ll_instance = idw_currentprop.of_getObjinstance( )
ls_user = gnv_app.of_getuserid( )

//delete old pre-filter rows
lds_temp.Retrieve(ls_name,"",ls_user)
ll_Max = lds_temp.RowCount()
FOR ll_Index = ll_Max To 1 STEP -1
	ll_ThisInstance = lds_temp.GetItemNumber(ll_Index, "dynamicproperty_instance")
	ls_Label = lds_temp.GetItemString(ll_Index, "dynamicproperty_propertylabel")
	ls_queriedName = lds_temp.GetItemString(ll_Index, "dynamicproperty_objectname")
	ls_queriedParent = lds_temp.GetItemString(ll_Index, "dynamicproperty_containername")
	IF ls_Label = "prefilter" THEN
		IF ls_name = ls_queriedName AND (ll_ThisInstance = ll_instance OR isNull(ll_ThisInstance)) THEN

			
			IF ll_ThisInstance = ll_instance THEN
				IF  ls_parent = ls_queriedParent THEN
					lds_temp.DeleteRow(ll_Index)		//delete the instance on the parent
				END IF
			ELSE
				lds_temp.DeleteRow(ll_Index)			//instances must be null, delete abstract
			END IF
		END IF
	END IF
NEXT

IF ls_parent <> cs_WindowTemplate THEN
	ll_Index = lds_temp.insertRow( 0 )			//row for abstract
END IF
ll_Index = lds_temp.insertRow( 0 )			//row for instance
//set row for instance
IF ls_parent <> cs_WindowTemplate THEN
	lds_temp.setItem( ll_Index -1, "dynamicproperty_objectname", ls_name )
	lds_temp.setItem( ll_Index -1, "dynamicproperty_containername", ls_parent )
	//lds_temp.setItem( 1, "dynamicproperty_username", ls_name )
	lds_temp.setItem( ll_Index -1, "dynamicproperty_instance", ll_instance )
	lds_temp.setItem( ll_Index -1, "dynamicproperty_propertylabel", "prefilter" )
	lds_temp.setItem( ll_Index -1, "dynamicproperty_propertyvalue", as_instprefilter )

END IF
//set row for abstract
lds_temp.setItem( ll_Index , "dynamicproperty_objectname", ls_name )
//lds_temp.setItem( 2, "dynamicproperty_username", ls_name )
lds_temp.setItem( ll_Index , "dynamicproperty_propertylabel", "prefilter" )
IF Len(as_absprefilter) > 0 AND NOT isNull(as_absprefilter) THEN
	as_absprefilter = as_absprefilter + "~r~n[AND]~r~n"
END IF
lds_temp.setItem( ll_Index , "dynamicproperty_propertyvalue", as_absprefilter )


li_return = lds_temp.update()
IF li_return = 1 THEN
	COMMIT;
	li_return = 1
ELSE
	li_return = -1
	ROLLBACK;
END IF


//if update succeeds, discard the rows from the objectmanagers cache
//IF li_return = 1 THEN
//	IF isValid( idw_CurrentProp.inv_mypropmanager ) THEN
//		idw_CurrentProp.inv_mypropmanager.of_discardPrefilter( ls_name, ll_instance, ls_parent )
//	END IF	
//END IF

//----------Edited 11-14-05----if update proceeds than add the row to the cache, this is only done
// because the object manage will not actually try to insert the rows into the db a second time.
// Instead the object manager will discard all prefilter rows before it tries to update the database
// with ids_settings.  We add the object to the cache so that if the user tries to remove the object,
// the delete call will be made on the row, and all of the rows for the instance of the prefilter will
// be removed with the other instance properties of the object.

IF li_return = 1 THEN
	IF isValid( idw_CurrentProp.inv_myPropManager ) AND ls_Parent <> cs_WindowTemplate THEN
		idw_CurrentProp.inv_mypropmanager.of_savePropAsChildDef( ls_name, ll_instance, ls_parent, "prefilter", as_instprefilter, idw_CurrentProp.className( ), "datawindow")
		
	END IF
END IF


return li_return
end function

public function integer of_validateexpression (string as_expression);/***************************************************************************************
NAME: 			of_ValidateExpression

ACCESS:			public
		
ARGUMENTS: 		(string as_expression)

RETURNS:			integer
	
DESCRIPTION:  Validates a string that is passed as an argument
					Used to validate sort and filter expressions
					
					Returns 1 if an expression is valid
					Returns -1 if an expressin is invalid
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/5
	

***************************************************************************************/


Integer	li_Result

Integer	li_Return
DataStore	lds_TempDs

lds_TempDs = CREATE DataStore
lds_TempDs.DataObject = idw_CurrentProp.DataObject

IF Len(as_Expression) > 0 THEN
	//If Set filter returns -1, the filter must be invalid
	li_Result = lds_TempDs.SetFilter(as_Expression)
	IF li_Result = 1 THEN
		li_Return = 1
	ELSE
		MessageBox("Invalid Expression", "Expression is not valid!")
		li_Return = -1
	END IF
ELSE
	li_Return = 1 //empty string is valid
END IF

Destroy lds_TempDs


Return li_Return
end function

public function integer of_validatemouseovertextexpression (string as_expression);/***************************************************************************************
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
	

***************************************************************************************/


n_cst_String	lnv_String
String	ls_Result
Integer	li_Return

IF isValid(idw_CurrentProp) THEN
	IF Len(Trim(as_Expression)) > 0 THEN
		
		

		as_Expression = lnv_String.of_GlobalReplace ( as_Expression, "'", "~~~'" )
		
		ls_Result = idw_CurrentProp.Describe ( "Evaluate('" + as_Expression + "'," + String(1) + ")")
		
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

public function boolean of_focusitem (string as_objname);// the following must be pushed if they are clicked
IF as_objName = "dataobject" OR as_objName = "borderstyle" OR as_objName = "titlebar" &
OR as_objName = "resizeable" OR as_objName = "border" OR as_objName = "closebutton" &
OR	as_objName = "dragscroll" OR as_objName = "indicator" OR as_objName = "watchlist" THEN
	
	RETURN TRUE
	
ELSE
	RETURN FALSE
END IF
end function

public function boolean wf_generalmodified ();Boolean	lb_GeneralModified
u_dw		ldw_GeneralProperties 

//Reference to General Properties dw
ldw_GeneralProperties = tab_dwproperties.tabpage_general.dw_GeneralProperties

IF ldw_GeneralProperties.AcceptText() = 1 THEN
	IF ldw_GeneralProperties.ModifiedCount() > 0 THEN
		lb_GeneralModified = TRUE
	END IF
END IF

Return lb_GeneralModified
end function

public function boolean wf_mouseovermodified ();Boolean	lb_MouseoverModified
u_dw		ldw_MouseOverResponses


//Reference to MouseoverResponses dw
ldw_MouseOverResponses = tab_dwproperties.tabpage_mouseover.dw_MouseOverResponses

//Check if changes have been made to dw_MouseOverResponses
IF ldw_MouseOverResponses.AcceptText() = 1 THEN
	IF ldw_MouseOverResponses.ModifiedCount() > 0 THEN
		lb_MouseOverModified = TRUE
	END IF
END IF

Return lb_MouseOverMOdified
end function

private function integer wf_apply ();/***************************************************************************************
NAME: 			wf_Apply()

ACCESS:			Private
		
ARGUMENTS: 		(none)

RETURNS:			Integer
	
DESCRIPTION:  Checks Modified count of Properties Tab and MouseOver Tab
					IF anything is modified, changes are applied
					
					Return 1 : Success
					Return 0: No Action
					
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/3
	

***************************************************************************************/
Integer	li_Return = 0
Integer	li_Continue = 1
Boolean	lb_GeneralModified
Boolean	lb_MouseOverModified

lb_GeneralModified = wf_GeneralMOdified()
lb_MouseOverModified = wf_MouseOverModified()


IF lb_GeneralModified THEN
	of_applyGeneral()
	li_Return = 1
END IF

IF lb_MouseOverModified THEN
	of_applyMouseOver()
	li_Return = 1
END IF


Return li_Return
	
end function

private function integer of_applymouseover ();/***************************************************************************************
NAME: 	of_ApplyMouseOver	

ACCESS:			private
		
ARGUMENTS: 		
							none

RETURNS:			Integer
	
DESCRIPTION:	causes mouseovers to be saved for the current datawindow
					stored in an instance variable.  First the event finds the outermost window or
					main window.  Then the cache is updated to hold the mouseOver settings defined
					by the user, and the changes are made to the database.  If the update succeeds,
					all the mouseovers are reset for any data windows on the screen that have the same
					name as the one that was just changed.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	9-12-05
	

***************************************************************************************/
Int		li_Return
Int		li_result
Int		li_Continue
Int		li_Valid
Long		ll_ModCount

Window	lw_currentParent
Window	lw_nextParent
u_dw		ldw_MouseOverResponses

ldw_MouseOverResponses = tab_dwproperties.tabpage_mouseover.dw_MouseOverResponses

IF ldw_MouseOverResponses.AcceptText ( ) = 1 THEN
			
	//The following gets the outermost window, the outer most window
	//can then be referenced as lw_currentParent
	
	lw_CurrentParent = idw_currentProp.getParent()
	lw_NextParent = lw_currentParent.ParentWindow()	
	DO WHILE isValid(lw_NextParent)
		IF isValid(lw_NextParent.ParentWindow()) THEN
			lw_CurrentParent = lw_NextParent
		END IF
		lw_NextParent = lw_NextParent.ParentWindow()
	LOOP
	
	
	//remove all old mouseover settings from the cache, insert the new ones,
	//and update the database
	
	IF of_resetCache() = 1 THEN
		li_result = ids_mouseOvers.update()
	ELSE
		li_Return = -1
	END IF
	
	IF li_result = 1 THEN
		COMMIT;			//update worked
		
		//change the mouseOvers for all existing dw windows that are of the same type as
		//idw_currentProp
		of_reCreateMouseOvers( lw_currentParent )
		ldw_MouseOverResponses.ResetUpdate()
		li_Return = 1
	ELSE
		ROLLBACK;
		MessageBox("Mouseover Apply Error", "Error Updating Mouseover Responses.")
		li_Return = -1
	END IF
		
ELSE
	MessageBox("Mouseover Apply Error", "Unable to update Mouseover Properties. Possible invalid expression.")
	ldw_MouseOverResponses.SelectText(ldw_MouseOverResponses.GetRow(), Len(ldw_MouseOverResponses.GetText()))
	li_Return = 0
END IF

Return li_Return
end function

private function integer of_applygeneral ();/***************************************************************************************
NAME: 			of_ApplyGeneral()

ACCESS:			private
		
ARGUMENTS: 		(none)

RETURNS:			Integer
	
DESCRIPTION:  Applies all General Properties to the current object (idw_CurrentProp)
					
				  Returns 1
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/3/05
	

***************************************************************************************/
Int 		li_index
Int		li_max

Long		ll_width
Long		ll_height
Long		ll_ModCount
String	ls_dataObject
String	ls_filter
String	ls_preFilter
String	ls_sort
String	ls_title
Integer	li_AcceptText
String	ls_oldFilter
String	ls_oldSort

int		li_borderStyle
int		li_titleBar
int		li_resizable
int		li_border
int		li_closeButton
int		li_indicator
int 		li_dragScroll
int		li_tempResult
int		li_WatchList
Long		ll_timedRefresh

Integer	li_posRes 
String	ls_absPreFilter
String	ls_instPreFilter 

String	lsa_argNames[]
String	lsa_argDataTypes[]


u_tab		ltaba_tab[]
u_dw			ldw_GeneralProperties 
u_dw_tcard	ldw_CurrentTcard


//Reference to General Properties dw
ldw_GeneralProperties = tab_dwproperties.tabpage_general.dw_GeneralProperties


IF idw_CurrentProp.TriggerEvent("ue_isTcard") = 1 THEN
	ldw_CurrentTcard = idw_CurrentProp
	IF ldw_CurrentTcard.of_IsWatchList() THEN
		ib_isWatchList = TRUE	
	ELSE
		ib_isWatchList = FALSE
	END IF
END IF

IF isValid( idw_currentProp) THEN
	
	ls_Title = ldw_GeneralProperties.GetItemString(1, "title")
	IF NOT isNULL(ls_title) THEN
		idw_CurrentProp.Title = ls_Title
	//put this logic on the u_dw
	//IF object is part of a tab, update the tabpage title
//		idw_CurrentProp.of_getTab( ltaba_tab )
//		IF isValid(ltaba_tab) THEN
//			li_max = upperBound(  ltaba_tab )
//			FOR li_index = 1 TO li_max
//				IF isValid( ltaba_tab[li_index] ) THEN
//					ltaba_tab[li_index].of_setTabText( idw_CurrentProp, ls_title )
//				END IF
//			NEXT
//	//	END IF
	END IF
	
	ll_width = ldw_GeneralProperties.GetItemNumber(1, "width")
	IF not ISNULL(ll_width) THEN
		idw_CurrentProp.width = ll_width
	END IF
	
	ll_height = ldw_GeneralProperties.GetItemNumber(1, "height")
	IF NOT IsNull(ll_height) THEN
		idw_currentProp.height = ll_height
	END IF	


	ls_dataObject = ldw_GeneralProperties.GetItemString(1, "dataobject")
	
	IF idw_currentProp.dataObject <> ls_dataObject THEN
		idw_currentProp.dataObject = ls_dataObject
		idw_currentProp.SetTransObject(SQLCA)
		idw_currentProp.Event ue_reload()
	END IF

	li_WatchList = ldw_GeneralProperties.GetItemNumber(1, "watchlist")
	ls_filter = ldw_GeneralProperties.GetItemString(1, "filter")
	
	IF li_WatchList <> 1 THEN
		IF NOT IsNull(ls_filter) THEN
				idw_CurrentProp.SetFilter(ls_filter)
				idw_currentProp.filter()
				
				IF idw_CurrentProp.TriggerEvent("ue_istcard") = 1 THEN
					ldw_CurrentTcard = idw_CurrentProp
					ldw_CurrentTcard.of_SetWatchList()
				END IF
		END IF
	ELSE
		IF NOT ib_IsWatchList THEN
			idw_CurrentProp.SetFilter("4=3")
			idw_CurrentProp.Filter()
			IF idw_CurrentProp.TriggerEvent("ue_istcard") = 1 THEN
				ldw_CurrentTcard = idw_CurrentProp
				ldw_CurrentTcard.of_SetWatchList()
			END IF
		ELSE
			IF idw_CurrentProp.TriggerEvent("ue_istcard") = 1 THEN
				ldw_CurrentTcard = idw_CurrentProp
				ldw_CurrentTcard.of_SetWatchList()
			END IF
		END IF
			
	END IF

	ls_sort = ldw_GeneralProperties.GetItemString(1, "sort")
	IF NOT IsNull(ls_sort) THEN
			idw_CurrentProp.SetSort(ls_Sort)
			idw_currentProp.sort()
	END IF
	
	li_borderStyle = ldw_GeneralProperties.getItemNumber(1,"borderstyle")
	IF li_borderStyle = 1 THEN
		idw_currentProp.borderStyle = styleShadowBox! 
		
	ELSEIF li_borderStyle = 2 THEN
		idw_currentProp.borderStyle = styleBox! 
		
	ELSEIF li_borderSTyle = 3 THEN
		idw_currentProp.borderStyle = stylelowered! 
	
	ELSEIF li_borderStyle = 4 THEN
		idw_currentProp.borderStyle = styleRaised! 
	
	END IF
	
 
	//prefilter stuff
	IF idw_CurrentProp.inv_MyPropManager.of_IsDeletableObject( idw_CurrentProp.of_GetObjName()) THEN// Do not allow prefilter to update on a template object
		
		ls_preFilter = ldw_GeneralProperties.getItemString(1,"prefilter")
		
		idw_CurrentProp.of_SetPreFilter(ls_PreFilter)
		li_posRes = POS(ls_preFilter,"~r~n[AND]~r~n")
		ls_absPreFilter = left( ls_prefilter , (li_posRes -1 ) )
		ls_instPreFilter = right( ls_prefilter , (len( ls_preFilter ) - ( li_posRes+ 8 )) )
		of_updatefilter( ls_absPreFilter, ls_instPreFilter )
		idw_currentProp.inv_MyPropManager.Event ue_adjustPrefilterDef(  idw_CurrentProp.of_getObjName(), ls_absPreFilter )
	END IF
	
	//Boolean values---------------------------------------------------
	li_titleBar =  ldw_GeneralProperties.GetItemNumber(1, "titlebar")
	idw_currentProp.titleBar = (li_TitleBar = 1)

	li_resizable =  ldw_GeneralProperties.GetItemNumber(1, "resizeable")
	idw_currentProp.resizable = (li_resizable = 1)

	
	li_border = ldw_GeneralProperties.GetItemNumber(1, "border")
	idw_currentProp.border = (li_border = 1)

	
	li_closeButton = ldw_GeneralProperties.GetItemNumber(1, "closebutton")
	idw_currentProp.controlMenu = (li_CloseButton = 1)

	//advanced  ----------------------------------------------------------

	li_dragscroll = ldw_GeneralProperties.GetItemNumber(1, "dragscroll")
	IF li_dragScroll = 1 THEN		
		idw_currentProp.of_setDragService( True )
		idw_currentProp.inv_dragService.of_setDragScroll(True) 
	ELSE
		idw_currentProp.of_setDragService( False )
	END IF
	
	
	li_indicator = ldw_GeneralProperties.GetItemNumber(1, "indicator")
	IF isValid(idw_currentProp.inv_dragService) THEN
		IF li_indicator = 1 THEN
			idw_currentProp.inv_dragService.of_setIndicatorMode("RECTANGLE")
		ELSEIF li_indicator = 2 THEN
			idw_currentProp.inv_dragService.of_setIndicatorMode("HAND")
		ELSEIF li_Indicator = 3 THEN
			idw_CurrentProp.inv_DragService.of_SetindicatorMode("BB")
		ELSE
			idw_currentProp.inv_dragService.of_setIndicatorMode("OFF")
		END IF
	END IF
	
	//added 3-7-06 for timed refresh
	ll_timedRefresh = ldw_generalProperties.GetItemNumber( 1,"sqlrefreshmintime" )
	idw_currentprop.il_minimumtimebetweenreloadsforsql = ll_timedRefresh
	//since the dataobject may have been changed this may have to be done
	IF idw_currentprop.of_getRetrievetype( ) = idw_currentProp.ci_sql THEN
		ldw_generalProperties.object.sqlrefreshmintime.visible = true
		ldw_generalProperties.object.t_refresh.visible = true
	ELSE
		ldw_generalProperties.object.sqlrefreshmintime.visible = false
		ldw_generalProperties.object.t_refresh.visible = false
	END IF
	idw_currentprop.il_minimumtimebetweenreloadsforsql = ll_timedRefresh
	
	
	ldw_GeneralProperties.ResetUpdate()
END IF

Return 1
end function

on w_dwproperties.create
int iCurrent
call super::create
this.tab_dwproperties=create tab_dwproperties
this.cb_applyall=create cb_applyall
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_dwproperties
this.Control[iCurrent+2]=this.cb_applyall
end on

on w_dwproperties.destroy
call super::destroy
destroy(this.tab_dwproperties)
destroy(this.cb_applyall)
end on

event closequery;call super::closequery;Integer li_Apply

IF wf_GeneralModified() OR wf_MouseOverModified() THEN
	li_Apply = MessageBox ( "Closing Properties...", "Apply changes made to properties?" , Question!, YesNoCancel!, 2)
END IF

IF li_Apply = 1 THEN
	wf_Apply()
ELSEif li_Apply = 3 THEN
	Return 1 //Do not close
END IF
end event

event open;call super::open;BLOB	lbl_CurrentState

//ChangeMenu(m_edit_properties)

inv_LLNode = CREATE n_cst_LinkedListNode

tab_dwproperties.tabpage_general.dw_generalproperties.GetFullState(lbl_CurrentState)
inv_LLNode.of_SetData( lbl_CurrentState)

// Center window
This.of_SetBase(TRUE) 
This.inv_Base.Of_Center()

end event

type cb_help from w_response`cb_help within w_dwproperties
boolean visible = false
integer y = 1212
end type

type tab_dwproperties from tab within w_dwproperties
integer x = 41
integer y = 36
integer width = 3049
integer height = 1492
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_general tabpage_general
tabpage_mouseover tabpage_mouseover
end type

on tab_dwproperties.create
this.tabpage_general=create tabpage_general
this.tabpage_mouseover=create tabpage_mouseover
this.Control[]={this.tabpage_general,&
this.tabpage_mouseover}
end on

on tab_dwproperties.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_mouseover)
end on

type tabpage_general from userobject within tab_dwproperties
integer x = 18
integer y = 104
integer width = 3013
integer height = 1372
long backcolor = 12632256
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_generalproperties dw_generalproperties
end type

on tabpage_general.create
this.dw_generalproperties=create dw_generalproperties
this.Control[]={this.dw_generalproperties}
end on

on tabpage_general.destroy
destroy(this.dw_generalproperties)
end on

type dw_generalproperties from u_dw within tabpage_general
event type boolean ue_validatedataobject ( string as_path,  ref string as_error )
event ue_updateprefilter ( string as_newfilter,  integer ai_filtertype )
event ue_getvaliddataobjects ( ref string asa_dataobjects[] )
event ue_enablecheckbox ( string as_col,  boolean as_enable )
integer x = 55
integer y = 32
integer width = 2994
integer height = 1124
integer taborder = 20
string title = "General Properties"
string dataobject = "d_generalproperties"
boolean vscrollbar = false
boolean border = false
end type

event type boolean ue_validatedataobject(string as_path, ref string as_error);/***************************************************************************************
NAME: 			ue_validateDataObject

ACCESS:			public
		
ARGUMENTS: 		
							String as_path

RETURNS:			Boolean
	
DESCRIPTION:  Compares the Column Names and Argument Names of the current idw_CurrentProp 
					dataobject, and the dataobject of the file (as_path)
					
					Returns TRUE If All Column Names AND Argument Names/Types are the same 
					Retruns FALSE if Any Col Names or Argument Names/Types don't match

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Maury 	9/14/2005
	

***************************************************************************************/
Boolean		lb_Return = TRUE
Long			ll_Index
Long			ll_CurrentColCount
Long			ll_TempColCount
Long			ll_CurrentArgNameMax
Long			ll_TempArgNameMax
Long			ll_CurrentArgDTMax
Long			ll_TempArgDTMax 
String		ls_CurrentColName
String		ls_TempColName
String		lsa_CurrentArgNames[]
String		lsa_CurrentArgDataTypes[]
String		lsa_TempArgNames[]
String		lsa_TempArgDataTypes[]
n_ds			lds_temp
INt			li_res

String		ls_error

n_cst_dssrv  lnv_dssrv
n_cst_bso_dynamicobjectmanager	lnv_manager
lnv_manager = Create n_cst_bso_dynamicobjectmanager

//Allow any dataobject change to a template object
IF idw_CurrentProp.of_GetObjName() <> cs_Template AND idw_CurrentProp.DataObject <> "d_generic"THEN

	lnv_dssrv = CREATE n_cst_dssrv
	
	lds_temp = CREATE n_ds
	lds_temp.DataObject = as_Path
	
	//Check to See if all the columns are the same as the existing dataobject on idw_CurrentProp
	IF isValid(idw_CurrentProp.Object) THEN
		
		li_res = lnv_manager.of_validatedataobjectchange( idw_CurrentProp.is_objectname, idw_currentProp.dataobject, as_path, ls_error)

		IF li_res <> 1 THEN
			as_error = ls_error
		END IF
		
		lb_return = (li_res = 1)
		/*-----
		ll_CurrentColCount = Long(idw_CurrentProp.Object.DataWindow.Column.Count)
		IF NOT isNull(as_Path) AND isValid(lds_temp.Object)THEN
			ll_TempColCount = Long(lds_temp.Object.DataWindow.Column.Count)
			
			//IF lds_temp and idw_CurrentProp have the same number of columns, check if the names match
			IF ll_CurrentColCount = ll_TempColCount THEN
				//Loop through columns and test if the names are equal
				//If one of the names are not equal, exit the loop and return false
				IF ll_CurrentColCount > 0 THEN
					FOR ll_Index = 1 TO ll_CurrentColCount
						ls_CurrentColName = idw_CurrentProp.Describe("#" + String(ll_Index) + ".Name")
						ls_TempColName = lds_temp.Describe("#" + String(ll_Index) + ".Name")
						IF ls_CurrentColName = ls_TempColName THEN
							// lb_Return remains true
						ELSE
							lb_Return = FALSE
							EXIT
						END IF
					NEXT
				END IF	
			ELSE
				lb_Return = FALSE
			END IF
			
			//IF lb_Return is not false yet, Check if the retrieve arguments are the same
			IF lb_Return <> FALSE THEN
				//Get the Argument names and types for idw_currentProp and lds_temp
				This.of_Setbase(TRUE)
				inv_base.of_setRequestor(idw_CurrentProp)
				inv_base.of_dwarguments( lsa_CurrentArgNames, lsa_CurrentArgDataTypes)
				lnv_dssrv.of_setrequestor(lds_temp)
				lnv_dssrv.of_dwarguments( lsa_TempArgNames, lsa_TempArgDataTypes)
				
				ll_CurrentArgNameMax = UpperBound(lsa_CurrentArgnames)
				ll_TempArgNameMax = UpperBound(lsa_TempArgNames)
				//IF idw_CurrentProp and lds_temp have the same number of ArgNames, check if the names match
				IF ll_CurrentArgNameMax = ll_TempArgNameMax THEN
					
					FOR ll_Index = 1 TO ll_CurrentArgNameMax 
						IF lsa_CurrentArgNames[ll_Index] = lsa_TempArgNames[ll_Index] THEN
							//lb_Return remains TRUE
						ELSE
							lb_Return = FALSE
							EXIT
						END IF
					NEXT
				ELSE
					lb_Return = FALSE
				END IF
				
				ll_CurrentArgDTMax = UpperBound(lsa_CurrentArgDataTypes)
				ll_TempArgDTMax = UpperBound(lsa_TempArgDataTypes)
				
				//IF idw_CurrentProp and lds_temp have the same number of ArgDataTypes, check if the types match
				IF ll_CurrentArgDTMax = ll_TempArgDTMax THEN
					
					FOR ll_Index = 1 TO ll_CurrentArgDTMax 
						IF lsa_CurrentArgDataTypes[ll_Index] = lsa_TempArgDataTypes[ll_Index] THEN
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
		END IF
		Destroy lds_temp
		Destroy lnv_dssrv
		*/
	ELSE
		lb_Return = FALSE //bad dataobject (no columns)
	END IF
ELSE
	lb_Return = TRUE //any template dataobject OR d_generic is valid
END IF

Destroy lnv_manager
Return lb_Return
end event

event ue_updateprefilter(string as_newfilter, integer ai_filtertype);/***************************************************************************************
NAME: 			ue_UpdatePreFilter

ACCESS:			public
		
ARGUMENTS: 		(string as_newfilter, int ai_filtertype)

RETURNS:			none
	
DESCRIPTION:  Updates the prefilter field
					Passing in 0 for the filter type will update the definition prefilter part
					Passing in 1 for the filter type will update the unique prefilter part
					
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/1
	

***************************************************************************************/
String	ls_CurrentPF
String 	ls_UpdatedPF
Long		ll_Pos
Long		ll_DefLength
Long		ll_UniqueStart

ls_CurrentPF = This.GetItemString(1, "prefilter")
ll_Pos = Pos(ls_CurrentPF, "~r~n[AND]~r~n")

IF ai_FilterType = 0 THEN //update prefilter definition part
	ll_DefLength = ll_Pos - 1
	IF ll_DefLength <> 0 THEN //replace the old prefilter
		ls_UpdatedPF = Replace(ls_CurrentPF, 1, ll_DefLength, as_newFilter)
	ELSE //insert the new def prefiliter
		ls_UpdatedPF = as_newFilter + ls_CurrentPF
	END IF
ELSEIF ai_FilterType = 1 THEN //update the prefilter unique part
	ll_UniqueStart = ll_Pos + 9 //starting pos of unique filter
	ls_UpdatedPF = Replace(ls_CurrentPF, ll_UniqueStart, Len(ls_CurrentPF), as_newFilter)
END IF

This.SetItem(1, "prefilter", ls_UpdatedPF) //set updated PF

//ItemChanged called to allow the change to get pushed onto the undo stack
This.Event itemchanged(1, This.Object.PreFilter, ls_UpdatedPF)
end event

event ue_getvaliddataobjects(ref string asa_dataobjects[]);Long		ll_Index
Long		ll_Index2 = 1
Long		ll_Max
Boolean	lb_Valid
String	lsa_SystemDataObjects[]
String	ls_error

IF isValid(idw_CurrentProp) THEN
	idw_CurrentProp.inv_MyPropManager.of_GetSystemDataObjects(lsa_SystemDataObjects[])
	ll_Max = UpperBound(lsa_SystemDataObjects[])
	FOR ll_Index = 1 TO ll_Max
		lb_Valid = This.Event ue_ValidateDataObject(lsa_SystemDataObjects[ll_Index],ls_error)
		IF lb_Valid THEN
			asa_DataObjects[ll_Index2] = lsa_SystemDataObjects[ll_Index]
			ll_Index2++
		END IF
	NEXT
END IF
end event

event ue_enablecheckbox(string as_col, boolean as_enable);IF as_enable THEN
	This.Modify( as_col + ".protect=0 " + as_col + ".Checkbox.3D=YES " + as_Col + ".Checkbox.scale=NO" )
ELSE
	This.Modify( as_col + ".protect=1 " + as_col + ".Checkbox.3D=NO " + as_Col + ".Checkbox.scale=YES" ) 
END IF
end event

event constructor;/***************************************************************************************
NAME: 			contructor

ACCESS:			public
		
ARGUMENTS: 		(none)

RETURNS:			long
	
DESCRIPTION:  Inserts one row and updates all the properties values with properties	
					from idw_CurrentProp
					
				  Also resets update flags
					
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/1
	

***************************************************************************************/

LOng			ll_Index
Long			ll_Max
String		ls_DataObjectCodeTable
String 		ls_IndicatorMode
String		ls_Filter
String		ls_Sort
String		ls_CombinedPreFilter
String		ls_Path
String		ls_Drive
String		ls_DirPath
String		ls_FileName
String		lsa_DataObjects[]
Boolean		lb_DragScroll
Integer		li_DragService
Integer		li_WatchList
Integer		li_retrieveType

u_dw					ldw_CurrentProp
u_dw_tcard			ldw_CurrentTcard
n_cst_privileges	lnv_priv 

n_cst_FileSrvWin32	lnv_FileSrv

lnv_FileSrv = Create n_cst_FileSrvWin32

idw_CurrentProp = Message.PowerObjectParm
ldw_CurrentProp = idw_CurrentProp
This.InsertRow(1)

This.of_Setdeleteable( FALSE )
This.of_SetInsertable( FALSE )


//Set Mouseover on to allow prefilter mouseover
This.SetItem(1, "note", "Note: All text above '[AND]' is for prefilter defintion.~r~n" &
+ "Text below '[AND]' is specific to the current datawindow.")
This.of_Setmouseover( true )
This.inv_MouseOver.of_SetParentwindow( w_dwProperties )
This.inv_MouseOver.of_Mouseoveron( )

//pre-filter visible based on privileges
This.Object.prefilter_t.Visible = lnv_priv.of_dynamic_createabstract( ) &
										OR lnv_Priv.of_dynamic_createinstance( )
This.Object.prefilter.Visible = lnv_priv.of_dynamic_createabstract( ) &
										OR lnv_Priv.of_dynamic_createinstance( )
This.Object.b_defprefilter.Visible = lnv_Priv.of_dynamic_createabstract( )
This.Object.b_uniqueprefilter.Visible = lnv_Priv.of_dynamic_createinstance( )

//Do not allow prefilter setting on template objects
IF NOT idw_CurrentProp.inv_mypropmanager.of_isdeletableobject(idw_CurrentProp.of_GetObjName()) THEN						
	This.Object.b_defprefilter.Enabled = FALSE
	This.Object.b_uniqueprefilter.Enabled = FALSE
END IF

IF NOT idw_CurrentProp.inv_mypropmanager.of_isdeletableobject(idw_CurrentProp.of_GetParentName()) THEN	
	This.Object.b_uniqueprefilter.Enabled = FALSE
END IF

//Show/Hide watchlist checkbox 
IF idw_CurrentProp.TriggerEvent("ue_isTcard") = 1 THEN
	ldw_CurrentTcard = idw_CurrentProp
	This.Object.WatchList.Visible = TRUE
	IF(ldw_CurrentTcard.of_isWatchList()) THEN
		ib_isWatchList = TRUE
	ELSE	
		ib_isWatchList = FALSE
	END IF
ELSE
	This.Object.WatchList.Visible = FALSE
END IF

//show/hide sql refresh
li_retrieveType = idw_currentprop.of_getRetrievetype( )
IF li_retrieveType = idw_currentprop.ci_sql THEN
	this.object.sqlrefreshmintime.visible = true
	this.object.t_refresh.visible = true
ELSE
	this.object.sqlrefreshmintime.visible = false
	this.object.t_refresh.visible = false
END IF


//------------Load General Tab Properties-----------------------
This.SetItem(1, "definition", ldw_CurrentProp.of_GetObjName())
This.SetItem(1,"title", ldw_CurrentProp.Title) 
This.SetItem(1,"width", ldw_CurrentProp.Width) 
This.SetItem(1,"height", ldw_CurrentProp.Height) 
This.SetItem(1,"dataobject", ldw_CurrentProp.DataObject)
//added by Dan 3-7-06
This.SetItem(1,"sqlrefreshmintime", ldw_CurrentProp.il_minimumTimeBetweenReloadsForSQL)

//--Commented out until we determine which system dataobjects to populate
//IF ldw_CurrentProp.of_GetObjName() = "DataWindow Template" OR ldw_CurrentProp.DataObject = "d_generic" THEN
//	idw_CurrentProp.inv_mypropmanager.of_GetSystemDataObjects(lsa_DataObjects[])
//ELSE
//	This.Event ue_GetValidDataObjects(lsa_DataObjects[])
//END IF
//ll_Max = UpperBound(lsa_DataObjects[])
////If no system objects, only allow selection of current dataobject
//IF ll_Max = 0 THEN
// ls_DataObjectCodeTable =  ls_FileName + "~t" + ls_Path + "/"
//END IF
//FOR ll_Index = 1 TO ll_Max
//	ls_DataObjectCodeTable += lsa_DataObjects[ll_Index] + "~t" + lsa_DataObjects[ll_Index] + "/"
//NEXT
//--

//Populate Dataobject
ls_Path = ldw_CurrentProp.DataObject
lnv_FileSrv.of_ParsePath(ls_Path, ls_Drive, ls_DirPath, ls_FileName)
ls_DataObjectCodeTable =  ls_FileName + "~t" + ls_Path + "/"
This.Object.dataobject.Values = ls_DataObjectCodeTable

IF ldw_CurrentProp.Titlebar THEN
	This.SetItem(1,"titlebar",ci_Checked)
ELSE
	This.SetItem(1,"titlebar",ci_Unchecked)
END IF

IF ldw_CurrentProp.Border THEN
	This.SetItem(1,"border",ci_Checked)
ELSE
	This.SetItem(1,"border",ci_UnChecked)
END IF

IF ldw_CurrentProp.Resizable THEN
	This.SetItem(1,"resizeable",ci_Checked)
	This.Event ue_EnableCheckbox("border", False)
	This.SetItem(1,"border",ci_UnChecked)
ELSE
	This.SetItem(1,"resizeable",ci_UnChecked)
END IF

IF ldw_CurrentProp.Controlmenu THEN
	This.SetItem(1,"closebutton",ci_Checked)
ELSE
	This.SetItem(1,"closebutton",ci_UnChecked)
END IF


CHOOSE CASE ldw_CurrentProp.BorderStyle
CASE StyleShadowBox!
	This.SetItem(1,"borderstyle", 1)
CASE StyleBox!
	This.SetItem(1,"borderstyle", 2)
CASE StyleLowered!
	This.SetItem(1,"borderstyle", 3)
CASE StyleRaised!
	This.SetItem(1,"borderstyle", 4)
CASE ELSE
	This.SetItem(1,"borderstyle", 2)
END CHOOSE

//Watch list
IF ib_IsWatchList = TRUE THEN
	This.SetItem(1, "watchlist", 1)
ELSE
	This.SetItem(1, "watchlist", 0)
END IF

ls_Filter = ldw_CurrentProp.Describe("DataWindow.Table.Filter")
IF ls_Filter <> "?" AND ls_Filter <> "!"THEN
	IF NOT ib_IsWatchList THEN
		This.SetItem(1,"filter", ls_Filter) 
	ELSE
		This.SetItem(1,"filter", "")
	END IF
END IF

ls_CombinedPreFilter = ldw_CurrentProp.is_filterdef

//IF the [AND] delimter is not there, tac it on
IF Pos(ls_CombinedPreFilter, "~r~n[AND]~r~n") > 0 THEN
	//dont tac on delimiter
ELSE
	ls_CombinedPreFilter = "~r~n[AND]~r~n" + ls_CombinedPreFilter
END IF
This.SetItem(1,"prefilter", ls_CombinedPreFilter) 

ls_Sort = ldw_CurrentProp.Describe("DataWindow.Table.Sort")
IF ls_Sort <> "?" AND ls_Sort <> "!"THEN
	This.SetItem(1,"sort", ls_Sort) 
END IF

IF isValid(ldw_CurrentProp.inv_DragService) THEN
	ls_IndicatorMode = ldw_CurrentProp.inv_dragService.of_getIndicatorMode()
	IF ls_IndicatorMode = "OFF" THEN
		This.SetItem(1,"indicator",0) 
	ELSEIF ls_IndicatorMode = "RECTANGLE" THEN
		This.SetItem(1,"indicator",1) 
	ELSEIF ls_IndicatorMode = "HAND" THEN
		This.SetItem(1,"indicator",2) 
	ELSEIF ls_IndicatorMOde = "BB" THEN
		This.SetItem(1, "indicator", 3)
	END IF
// if the dragservice is not valid, set indicator to OFF
ELSE
	This.SetItem(1,"indicator",0) 
END IF

IF isValid(ldw_CurrentProp.inv_dragService)THEN
	lb_DragScroll = ldw_CurrentProp.inv_dragService.of_getDragScrollMode()
	IF lb_DragScroll = TRUE THEN
		This.SetItem(1,"dragscroll",ci_Checked) 
	ELSE 
		This.SetItem(1,"dragscroll",ci_UnChecked)
	END IF
ELSE
	This.SetItem(1,"dragscroll",ci_UnChecked)
END IF


//Hide/Show Drag INdicator
//li_DragService = This.GetItemNumber(1, "dragscroll")
//IF li_DragService <> 1 THEN
//	This.Object.indicator.Visible = FALSE
//	This.Object.t_indicator.Visible = FALSE
//ELSE
//	This.Object.indicator.Visible = TRUE
//	This.Object.t_indicator.Visible = TRUE
//END IF

//Reset update flags to indicate that nothing needs to be updated
This.ResetUpdate()
This.SetFocus()
//this.of_

Destroy lnv_FileSrv
end event

event buttonclicked;/***************************************************************************************
NAME: 			buttonclicked event

ACCESS:			public
		
ARGUMENTS: 		(long row, long actionreturncode, dwobject dwo)

RETURNS:			none
	
DESCRIPTION:  Processes button clicks for dataobject button, definition prefilter button
						and unique prefilter button
					
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/1
	

***************************************************************************************/


Integer 	li_rtn
LOng		ll_Pos
Long		ll_DefLength
Long		ll_UniqueLength
String	ls_Path
String	ls_DocPath
String	ls_DocName
String	ls_FileValues
String	ls_CombinedPrefilter
String	ls_DefPrefilter
String	ls_UniquePreFilter
String	ls_DataObjectCodeTable
String	lsa_CombinedPreFilter[]
Boolean	lb_ValidDo
s_parm	lstr_Parm
String	ls_error

n_cst_setting_templatespathfolder 	lnv_Root

lnv_Root = CREATE n_cst_setting_templatespathfolder

IF dwo.Name = "b_datobject" THEN
	
	ls_Path = This.GetItemString(1,"dataobject")
	//If the current dataobject is not a psr, use default template path
	IF Pos(ls_Path, ".psr") <= 0 THEN
		ls_Path = lnv_Root.of_getValue()
	END IF
	//Browse data object dialog box
	IF NOT isNull( ls_Path ) THEN
		 li_rtn = GetFileOpenName("DataObject", &
		 ls_docpath, ls_docname, "PSR", "PSR FILES (*.PSR),*.PSR,", ls_Path, 18)
	END IF
	
	IF NOT isNull(ls_DocPath) AND Len(ls_DocPath) > 0 THEN
		lb_ValidDO = This.Event ue_ValidateDataObject(ls_DocPath, ls_error)
	END IF
	
	IF lb_ValidDO THEN
		//Set the dataobject to the selected file
		ls_DataObjectCodeTable = ls_DocName + "~t" + ls_DocPath + "/"
		This.Object.dataobject.Values = ls_DataObjectCodeTable
		This.SetItem(1, "dataobject", ls_DocPath)
		
		
	ELSEIF NOT isNull(ls_DocPath) AND Len(ls_DocPath) > 0 THEN
		MessageBox("Invalid DataObject", ls_error )
	END IF
END IF



IF dwo.Name = "b_defprefilter" THEN
	ls_CombinedPrefilter = This.GetItemString(1, "prefilter")
	ll_Pos = Pos(ls_CombinedPreFilter, "~r~n[AND]~r~n")
	ll_DefLength = ll_Pos - 1 //ending pos of the definition prefilter 
	IF ll_DefLength > 0 THEN
		ls_DefPreFilter = Left(ls_CombinedPreFilter, ll_DefLength)
	ELSE
		//no defprefilter
	END IF
	
	lstr_Parm.is_label = "Definition"
	lstr_Parm.ia_Value = ls_DefPreFilter
	IF NOT isValid(w_prefilter) THEN
		OpenWithParm(w_prefilter, lstr_Parm)
	ELSE
		Setfocus(w_prefilter)
	END IF
	
END IF

IF dwo.Name = "b_uniqueprefilter" THEN
	ls_CombinedPrefilter = This.GetItemString(1, "prefilter")
	ll_Pos = Pos(ls_CombinedPreFilter, "~r~n[AND]~r~n")
	ll_uniqueLength = Len(ls_CombinedPreFilter) - (ll_Pos + 8) //starting point of unique prefilter 
	IF ll_uniqueLength > 0 THEN
		ls_UniquePreFilter = Right(ls_CombinedPrefilter, ll_uniqueLength)
	ELSE
		//no uniqueprefilter
	END IF
	lstr_Parm.is_label = "Unique"
	lstr_Parm.ia_Value = ls_UniquePreFilter
	IF NOT isValid(w_prefilter) THEN
		OpenWithParm(w_prefilter, lstr_Parm)
	ELSE
		Setfocus(w_prefilter)
	END IF
END IF


end event

event itemchanged;call super::itemchanged;Integer	li_dragService
Integer	li_WatchList

IF dwo.Name = "dragscroll" THEN
	IF data = "0" THEN
		This.SetItem(row, "indicator", 0)
	END IF
END IF

IF dwo.Name = "watchlist" THEN 
	li_WatchList = This.GetItemNumber(row, "watchlist")
	IF li_WatchList = 1 THEN
		is_Filter = GetItemString(row, "filter")
		This.SetItem(row, "filter", "") //Set Filter to empty string
	ELSE
		This.SetItem(row, "filter", is_Filter) //Set filter back to what is was before
	END IF
END IF

IF dwo.Name = "resizeable" THEN
	IF data = "1" THEN
		This.Event ue_EnableCheckbox("border", FALSE)
		This.SetItem(row, "border", 0)
	ELSE
		This.Event ue_EnableCheckbox("border", TRUE)
	END IF
END IF

IF isValid(inv_LLNode) THEN
	IF of_focusItem(dwo.Name) THEN
		This.Event ItemFocusChanged(row, dwo)
	END IF
	inv_Stack.of_push( inv_LLNode)
	//m_edit_properties.m_edititem.m_undo.enabled = true
END IF




end event

event itemfocuschanged;call super::itemfocuschanged;Blob		lbl_CurrentState
inv_LLNode = CREATE n_cst_LinkedListNode
	
This.GetFullState(lbl_CurrentState)
inv_LLNode.of_SetData( lbl_CurrentState)


end event

type tabpage_mouseover from userobject within tab_dwproperties
integer x = 18
integer y = 104
integer width = 3013
integer height = 1372
long backcolor = 12632256
string text = "MouseOver"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_note st_note
st_instructions st_instructions
cbx_viewall cbx_viewall
dw_mouseoverresponses dw_mouseoverresponses
dw_columndisplay dw_columndisplay
end type

on tabpage_mouseover.create
this.st_note=create st_note
this.st_instructions=create st_instructions
this.cbx_viewall=create cbx_viewall
this.dw_mouseoverresponses=create dw_mouseoverresponses
this.dw_columndisplay=create dw_columndisplay
this.Control[]={this.st_note,&
this.st_instructions,&
this.cbx_viewall,&
this.dw_mouseoverresponses,&
this.dw_columndisplay}
end on

on tabpage_mouseover.destroy
destroy(this.st_note)
destroy(this.st_instructions)
destroy(this.cbx_viewall)
destroy(this.dw_mouseoverresponses)
destroy(this.dw_columndisplay)
end on

event constructor;
//If the object is a template, disable mouseovers
IF idw_CurrentProp.inv_mypropmanager.of_isdeletableobject( idw_CurrentProp.of_GetObjName()) = FALSE THEN						
	This.Enabled = FALSE
END IF
end event

type st_note from statictext within tabpage_mouseover
integer x = 123
integer y = 664
integer width = 2693
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Note: Mouseover properties get saved immediately when apply button is clicked (not on ~'save window definition~'). "
boolean focusrectangle = false
end type

type st_instructions from statictext within tabpage_mouseover
integer x = 114
integer y = 24
integer width = 1115
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Click on an object below to set a column response"
boolean focusrectangle = false
end type

type cbx_viewall from checkbox within tabpage_mouseover
integer x = 2395
integer y = 744
integer width = 306
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "View All"
boolean lefttext = true
end type

event clicked;IF dw_MouseOverResponses.AcceptText ( ) = 1 THEN

	IF This.Checked = TRUE THEN
		//Unfilter 
		dw_MouseOverResponses.Event ue_unfilterrows()
	ELSE
		dw_MouseOverResponses.Event ue_FilterRows("none")
	END IF
	
ELSE
	
	This.Checked = NOT This.Checked
	dw_MouseOverResponses.SetFocus ( )
	
END IF

end event

type dw_mouseoverresponses from u_dw within tabpage_mouseover
event ue_insertrows ( )
event type integer ue_filterrows ( string as_column )
event ue_updatelinkcodetable ( )
event ue_initializedata ( )
event type integer ue_unfilterrows ( )
event ue_updatetextexpression ( long al_row,  string as_expression )
integer x = 114
integer y = 732
integer width = 2702
integer height = 596
integer taborder = 20
string title = "none"
string dataobject = "d_mouseoverresponses"
borderstyle borderstyle = stylebox!
end type

event ue_insertrows();/***************************************************************************************
NAME: 	ue_InsertRows() Event

ACCESS:	Public
		
ARGUMENTS: 	(NONE)

RETURNS:	
	
DESCRIPTION:
	Inserts a row for every visible object in dw_columnDisplay
				
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/12/05
	
***************************************************************************************/



Integer 	li_Index
Long		ll_ObjCount
Long		ll_Row
String	ls_ObjName
String	as_ObjList[]

IF NOT isValid(inv_dwsrv) THEn
	inv_dwsrv = CREATE n_cst_dwsrv
	inv_dwsrv.of_SetRequestor(dw_columndisplay)
END IF

//Get an array list of currently visible objects on dw_columndisplay
inv_dwsrv.of_GetObjects( as_ObjList,"*", "*", TRUE)
ll_ObjCount = UpperBound(as_ObjList)

IF NOT isNull(ll_ObjCount) AND ll_ObjCount > 0 THEN
	//Insert 1 row for a row response
	This.InsertRow(0)
	This.SetItem(1, "columnname", "Row")
	
	//Insert 1 rows for every object in dw_columndisplay
	FOR li_Index = 1 TO ll_ObjCount
		ls_ObjName = as_ObjList[li_Index]
		IF NOT isNull(ls_ObjName) THEN
			ll_Row = This.InsertRow(0)
			This.SetItem(ll_Row, "columnname", ls_ObjName)
		END IF
	NEXT
END IF

end event

event type integer ue_filterrows(string as_column);/***************************************************************************************
NAME: 	ue_FilterRows

ACCESS:	Public
		
ARGUMENTS: 	(string	as_Column)

RETURNS:		None
	
DESCRIPTION:
			Filter rows based on the column clicked (as_column)

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/12/05
	
***************************************************************************************/


Integer	li_Return
String	ls_Filter
ls_Filter = "columnname = 'Row' OR columnname = '"+ as_Column + "'"

IF NOT isNull(ls_Filter) THEN
	li_Return = This.SetFilter(ls_Filter) 
	This.Filter()
END IF

Return li_Return
end event

event ue_updatelinkcodetable();/***************************************************************************************
NAME: 	UpdateLinkCodeTable() Event

ACCESS:	Public
		
ARGUMENTS: 	(NONE)

RETURNS:	
	
DESCRIPTION:
	Updates the linkid code table with all the pre-defined links
				
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/12/05
	
***************************************************************************************/
Long	 		ll_Index
String 		ls_LinkValues
Long			ll_LinkId
String		ls_LinkName
Long			ll_LinkCount



//Stores a list of possible links for idw_CurrentProp
IF NOT isValid(ids_Links) THEN
	ids_Links = CREATE DataStore
	ids_Links.DataObject = "d_linklist"
	ids_Links.SetTransObject(SQLCA)
	ids_Links.Retrieve(idw_CurrentProp.of_GetObjName())
END IF

ll_LinkCount = ids_Links.RowCount()

IF ll_LinkCount > 0 THEN
	//Add a link id of 0 representing no link chosen
	ls_LinkValues += "" + "~t" + String(0) +"/"
	
	//For each possible link in ids_Links, Add linkid to code table

	FOR ll_Index = 1 TO ll_LinkCount
		
		ls_LinkName = ids_Links.GetItemString(ll_Index, "detailname")
		ll_LinkId	= ids_Links.GetItemNumber(ll_Index, "linkid")
		ls_LinkValues += ls_LinkName + "~t" + String(ll_LinkId) + "/"
	NEXT
	
	
	This.Object.linkid.Values = ls_LinkValues
END IF

end event

event ue_initializedata();/***************************************************************************************

NAME: 	ue_InitializeData() Event

ACCESS:	Public
		
ARGUMENTS: 	(NONE)

RETURNS:	
	
DESCRIPTION:
		Retrieves from ids_MouseOvers to get a list of Mouseovers that are defined for the 
			current ojbect (idw_CurrentProp)
		
		dw_MouseOverResponses is then initialized with the correct reponses
				
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/12/05
	
***************************************************************************************/

Long		ll_MouseCount
Long		ll_RowCount
Long		ll_Index
LOng		ll_Index2
String	ls_ColName
String	ls_Expression	
Long		ll_Linkid
String	ls_ThisColName
String	ls_Response
ids_Mouseovers = CREATE DataStore

//ids_Mouseovers retrieves a list of all Mousovers defined for this object (idw_CurrentProp)
ids_Mouseovers.DataObject = "d_mouseoverresponses"
ids_Mouseovers.SetTransObject(SQLCA)
ids_Mouseovers.Retrieve(idw_CurrentProp.of_GetObjName())
ll_MouseCount = ids_Mouseovers.RowCount()

//Loop through all ids_Mouseover rows
FOR ll_Index = 1 TO ll_MouseCount
	ls_ColName = ids_Mouseovers.GetItemString(ll_Index, "columnname")
	ls_Response = ids_Mouseovers.GetItemString(ll_Index, "response")
	
	//Loop through all the rows in dw_MouseOverResponses 
	//dw_MouseovrResponses contains all mouseovers that could potentially be set up 
	FOR ll_Index2 = 1 TO This.RowCount()
		ls_Expression = ids_MouseOvers.GetItemString(ll_Index, "textexpression")
		ll_Linkid	= ids_MouseOvers.GetItemNumber(ll_Index, "linkid")
		ls_ThisColName = This.GetItemString(ll_Index2, "columnname")
		
		//The folling code sets values for dw_MouseOverResponses
		
		//If there is a row responses defined in ids_MouseOvers, Set the corresponding value
		IF ls_Response = "row" AND ls_ThisColName = "Row" THEN
			IF NOT isNull(ls_Expression) THEN
				This.SetItem(ll_Index2, "textexpression", ls_Expression)
			END IF
			IF NOT isNull(ll_LinkId) THEN
				This.SetItem(ll_Index2, "linkid", ll_Linkid)
			END IF
		//If there is a col responses defined in ids_MouseOvers, Set the corresponding value
		ELSEIF ls_Response = "col"THEN

			IF ls_ColName = ls_ThisColName THEN
				IF NOT isNull(ls_Expression) THEN
					This.SetItem(ll_Index2, "textexpression", ls_Expression)
				END IF
				IF NOT isNull(ll_LinkId) THEN
					This.SetItem(ll_Index2, "linkid", ll_Linkid)
				END IF
			END IF
		END IF
	NEXT
	
NEXT
end event

event type integer ue_unfilterrows();
Integer	li_Return
String	ls_Filter
ls_Filter = "4=4" //Filter nothing

IF NOT isNull(ls_Filter) THEN
	li_Return = This.SetFilter(ls_Filter) 
	This.Filter()
END IF

Return li_Return
end event

event ue_updatetextexpression(long al_row, string as_expression);IF al_Row > 0 AND NOT isNull(as_expression) THEN
	This.SetItem(al_row, "textexpression", as_Expression)
END IF
end event

event constructor;This.of_Setdeleteable( FALSE )
This.of_SetInsertable( FALSE )


//Post to allow dw_columndisplay constructor to execute first
This.Event POST ue_InsertRows()
This.Event POST ue_UpdateLinkCodeTable( )

This.Event POST ue_InitializeData()

//reset update flags to indicate nothing needs to be updated
This.POST ResetUpdate()

This.Event POST ue_FilterRows("none")






end event

event itemchanged;call super::itemchanged;//Validates the text expression before another item gets focus
//If the text expression is invalid, Returns 1 to Reject the data value 
//and do not allow focus to change


Integer	li_Result

IF dwo.Name = "textexpression" THEN
	li_Result = of_ValidateMouseOverTextExpression(data)
	IF li_Result <> 1 THEN
		This.SelectText(1, Len(This.GetText()))
		Return 1
	END IF
END IF

end event

event itemerror;call super::itemerror;IF dwo.Name = "textexpression" THEN
	Return 1  //Error message is handled by ItemChanged Event
END IF
end event

event buttonclicked;call super::buttonclicked;String	ls_Expression
String	ls_NewExpression

n_cst_msg	lnv_Msg
s_Parm		lstr_Parm



IF dwo.Name = "b_expression" THEN
	
	ls_Expression = This.GetItemString(row, "textexpression")
	
	lstr_Parm.is_Label = "CURRENTDW"
	lstr_Parm.ia_value = idw_currentprop
	lnv_Msg.of_add_parm( lstr_Parm )
	
	lstr_Parm.is_Label = "EXPRESSION"
	lstr_Parm.ia_value = ls_Expression
	lnv_Msg.of_add_parm( lstr_Parm )
	
	OpenWithParm(w_Expression, lnv_Msg)
	IF NOT isNull(Message.StringParm) THEN
		ls_NewExpression = Message.StringParm
		IF ls_NewExpression <> "CANCEL!" THEN
			This.SetItem(row, "textexpression", ls_NewExpression)
		END IF
	END IF
	

END IF





end event

type dw_columndisplay from u_dw within tabpage_mouseover
integer x = 114
integer y = 104
integer width = 2702
integer height = 520
integer taborder = 20
string title = "none"
boolean hscrollbar = true
end type

event constructor;/***************************************************************************************
NAME: 			constructor

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			none
	
DESCRIPTION:  Sets the dataobject to dataobject of the Dw that was right clicked (idw_CurrentProp)
					And enforces a sharedata
					
					Protects All Columns on This Ojbect
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/13
	

***************************************************************************************/

Integer	li_Index
String	ls_Result
Long		ll_RowCount

This.of_Setdeleteable( FALSE )
This.of_SetInsertable( FALSE )



This.DataObject = idw_CurrentProp.DataObject
idw_CurrentProp.ShareData (This)

ll_RowCount = This.RowCount()
IF ll_RowCount > 0 THEN
	//Protect All Columns
	FOR li_Index = 1 TO Integer(This.Object.DataWindow.Column.Count)
		ls_Result = This.Modify("#" + String(li_Index) + ".Protect = 1")
	NEXT
END IF





end event

event clicked;/***************************************************************************************
NAME: 			clicked Event

ACCESS:			public
		
ARGUMENTS: 		(integer xpos, integer ypos, long row, dwoobject dwo)

RETURNS:			Long
	
DESCRIPTION:  Gets the Ojbect at pointer and calls ue_FilterRows with the Object as
				  a param
					
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/13
	

***************************************************************************************/


String	ls_CurrentObject
Integer	li_CurrentObjectSize
String	la_CurrentObject[]
String	ls_CurrentColumn
ls_CurrentObject = This.GetObjectAtPointer()

//parse the ls_CurrentObject into an array that will hold the column in [1]
li_CurrentObjectSize = inv_StringService.of_parsetoarray( ls_CurrentObject,"~t", la_CurrentObject )

IF li_CurrentObjectSize > 0 THEN
	ls_CurrentColumn = la_CurrentObject[1]
END IF


IF NOT isNull(ls_CurrentColumn)THEN
	dw_MouseOverResponses.Event ue_FilterRows(ls_CurrentColumn)
END IF
end event

type cb_applyall from commandbutton within w_dwproperties
integer x = 2743
integer y = 1556
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Apply"
end type

event clicked;wf_Apply()
end event

