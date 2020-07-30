$PBExportHeader$w_dwlink.srw
forward
global type w_dwlink from w_response
end type
type st_instruct from statictext within w_dwlink
end type
type cb_apply from commandbutton within w_dwlink
end type
type dw_linklist from u_dw within w_dwlink
end type
type dw_link from u_dw within w_dwlink
end type
type dw_linkargs from u_dw within w_dwlink
end type
type cb_cancel from commandbutton within w_dwlink
end type
type gb_details from groupbox within w_dwlink
end type
type gb_args from groupbox within w_dwlink
end type
end forward

global type w_dwlink from w_response
integer x = 214
integer y = 221
integer width = 2629
integer height = 1944
string title = "Define Links"
long backcolor = 12632256
boolean ib_isupdateable = false
boolean ib_savestatus = true
st_instruct st_instruct
cb_apply cb_apply
dw_linklist dw_linklist
dw_link dw_link
dw_linkargs dw_linkargs
cb_cancel cb_cancel
gb_details gb_details
gb_args gb_args
end type
global w_dwlink w_dwlink

type variables
PUBLIC:
Constant String	cs_TITLECOL = "detailname"
Constant String	cs_OBJECTNAMECOL = "objectname"
Constant String	cs_RETRIEVECOL = "retrieve"
Constant	String	cs_SCROLLCOL	= "scroll"
Constant String	cs_FILTERCOL	= "filter"
Constant String	cs_MASTERCOL = "mastercolumn"
Constant	String	cs_DETAILCOL = "detailcolumn"
Constant	String	cs_ORDERCOL = "argumentorder"
Constant	String	cs_ARGKEYCOL = "linkid"
Constant	String	cs_STYLECOL = "style"
Constant	String	cs_RETRIEVALTYPECOL = "retrievaltype"
Constant	String	cs_RETRIEVALNAMECOL = "retrievalname"
Constant	String	cs_MANDATORYCOL = "mandatory"
Constant	String	cs_DWTITLESCOL = "dwtitles"



Window	iw_ParentWindow
u_dw		idw_MasterDw

end variables

forward prototypes
public function integer of_setparent (window aw_parentwindow)
public function integer of_getargkey ()
public function integer of_retrieveargs ()
public function integer of_destroylinks (integer ai_linkid, window aw_window)
end prototypes

public function integer of_setparent (window aw_parentwindow);/***************************************************************************************
NAME: 	of_setparent

ACCESS:	Public
		
ARGUMENTS: 	(Window aw_ParentWindow)

RETURNS:		String
	
DESCRIPTION:
			Sets iw_ParentWindow
			
			Returns 1 If sucessful
			Returns -1 If fails

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/17/05
	
***************************************************************************************/

Integer li_Return
IF isValid(aw_ParentWindow) THEN	
	iw_ParentWindow = aw_ParentWindow
	li_Return = 1
ELSE
	li_Return = -1
END IF

Return li_Return
end function

public function integer of_getargkey ();//Returns current linkid
Long ll_CurrentRow
Integer li_Return

	ll_CurrentRow = This.dw_link.GetRow()
IF ll_CurrentRow > 0 THEN
	li_Return = This.dw_link.GetItemNumber(ll_CurrentRow, "linkid")
END IF
Return li_Return
end function

public function integer of_retrieveargs ();/***************************************************************************************
NAME: 	of_RetrieveArgs

ACCESS:	Public
		
ARGUMENTS: 	(none)

RETURNS:		None
	
DESCRIPTION:
			Stores an array of Link ids in dw_LinkList
			Retrieves dw_linkargs with the link id array as the retrieval argument


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/23/05
	
***************************************************************************************/



Long	ll_Max
Long	ll_Index
Long	ll_LinkIds[]
Long	ll_LinkId

ll_Max = dw_LinkList.RowCount()
FOR ll_Index = 1 TO ll_Max
	ll_LinkId = dw_LinkList.GetItemNumber(ll_Index, "linkid")
	ll_LinkIds[ll_Index] = ll_LinkId
NEXT

IF upperBound(ll_LinkIds) > 0 THEN
	dw_linkargs.Retrieve(ll_LinkIds)
END IF

Return 1
end function

public function integer of_destroylinks (integer ai_linkid, window aw_window);Int 		li_index
Int		li_max


Long		ll_linkid
Long		li_Return


u_dw 		ldw_currentDw

Window	lwa_childrenWindows[]

li_max = upperBound(aw_window.control)

FOR li_index = 1 TO li_max
	
	IF typeOf(aw_window.control[li_index] ) = datawindow! AND aw_window.control[li_index].triggerEvent("ue_hasIds") = 1 THEN
		ldw_currentDw = aw_window.control[li_index ]
		
		IF isValid( ldw_currentDw.inv_linkage ) THEN
			ll_linkId = ldw_currentDw.inv_Linkage.of_getLinkId()
			
			IF ll_linkId = ai_linkId THEN
				//DESTROY the link
				li_Return = ldw_currentDw.inv_Linkage.of_ResetMaster()
			END IF
			
		END IF
		
	END IF
	
NEXT

IF aw_window.triggerEvent("ue_hasChildrenWindows") = 1 THEN
	aw_window.dynamic of_getChildrenWindows( lwa_childrenWindows )
	
	li_max = upperBound( lwa_childrenWindows )
	
	FOR li_index = 1 TO li_max
		
		IF isValid( lwa_childrenWindows[li_index] )  THEN
			this.of_destroyLinks( ai_linkId , lwa_childrenWindows[li_index] )
		
		END IF
	NEXT
END IF

IF isNull(li_Return) THEN
	li_Return = -1 //No links destroyed
END IF

Return li_REturn
end function

on w_dwlink.create
int iCurrent
call super::create
this.st_instruct=create st_instruct
this.cb_apply=create cb_apply
this.dw_linklist=create dw_linklist
this.dw_link=create dw_link
this.dw_linkargs=create dw_linkargs
this.cb_cancel=create cb_cancel
this.gb_details=create gb_details
this.gb_args=create gb_args
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_instruct
this.Control[iCurrent+2]=this.cb_apply
this.Control[iCurrent+3]=this.dw_linklist
this.Control[iCurrent+4]=this.dw_link
this.Control[iCurrent+5]=this.dw_linkargs
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.gb_details
this.Control[iCurrent+8]=this.gb_args
end on

on w_dwlink.destroy
call super::destroy
destroy(this.st_instruct)
destroy(this.cb_apply)
destroy(this.dw_linklist)
destroy(this.dw_link)
destroy(this.dw_linkargs)
destroy(this.cb_cancel)
destroy(this.gb_details)
destroy(this.gb_args)
end on

event open;call super::open;/***************************************************************************************
NAME: 	Open (Extends Ancestor)

ACCESS:	Public
		
ARGUMENTS: 	(none)

RETURNS:		None
	
DESCRIPTION:
			Sets idw_MasterDw
			Retrieves link definitions for current Master (idw_MasterDw)


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/23/05
	
***************************************************************************************/
Long		ll_NumRows


n_cst_msg	lnv_Msg
s_Parm		lstr_Parm
u_dw 			ldw_Master
w_master		lw_Parent

IF isValid(Message.PowerObjectParm) THEN
	
	lnv_Msg = Message.PowerObjectParm 
	
	
	IF lnv_Msg.of_Get_parm("MASTERDW", lstr_Parm ) > 0 THEN
		ldw_Master = lstr_Parm.ia_value
		IF ldw_Master.triggerEvent("ue_hasIds") = 1 THEN
			idw_MasterDw = ldw_Master
		END IF
	END IF
	
	IF lnv_Msg.of_Get_Parm("PARENTWINDOW", lstr_Parm) > 0 THEN
		lw_Parent = lstr_Parm.ia_Value
		of_SetParent(lw_Parent)
	END IF
	
	
END IF


ll_NumRows = dw_linklist.Retrieve(idw_MasterDw.of_GetObjName())

//Called to updated detailcodetable 
dw_linklist.Event RowFocusChanged( dw_linklist.GetRow() )

dw_Link.Event ue_UpdateDwCodeTable()

This.of_RetrieveArgs()

IF ll_NumRows > 0 THEN
	This.gb_details.Visible = TRUE
	This.gb_args.Visible = TRUE
	This.dw_Link.Visible = TRUE
	This.dw_LinkArgs.Visible = TRUE
ELSE
	This.gb_details.Visible = FALSE
	This.gb_args.Visible = FALSE
	This.dw_Link.Visible = FALSE
	This.dw_linkargs.Visible = FALSE
END IF

This.cb_Apply.Enabled = FALSE
end event

event closequery;call super::closequery;//Overriding Ancestor
Integer	li_Save
Integer	li_Return

IF cb_apply.Enabled = TRUE THEN  //If apply button is enabled, a new link was defined, so ask if they want to save changess

	li_Save = MessageBox("Save Changes?", "Would you like to save changes?", &
					Question!, YesNoCancel!, 2)
	
	IF li_Save = 1 THEN
		li_Return = 0
		This.cb_apply.Event Clicked( )
	ELSEIF li_Save = 2 THEN
		li_Return = 0
	ELSEIF li_Save = 3 THEN

		li_Return = 1
	END IF
END IF
	
Return li_Return
end event

type cb_help from w_response`cb_help within w_dwlink
boolean visible = false
integer x = 2350
end type

type st_instruct from statictext within w_dwlink
integer x = 69
integer y = 52
integer width = 1243
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Right click below to add/delete link Definitions"
boolean focusrectangle = false
end type

type cb_apply from commandbutton within w_dwlink
integer x = 1847
integer y = 1720
integer width = 338
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Save"
end type

event clicked;/***************************************************************************************
NAME: 	Clicked() Event

ACCESS:	Public
		
ARGUMENTS: 	(None)  

RETURNS:		None
	
DESCRIPTION:
			Updates DataBase with proper Links and Detail Arguments
			
			Returns 1 if updated succeeded
			Returns -1 if updated failed
			Returns 0 if apply was canceled

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/3/05
	
***************************************************************************************/
Integer		li_Apply
Integer		li_Result
Integer 		li_LinkUpdate
Integer		li_ArgsUpdate
Long			ll_Index
String		ls_CurrentMaster
String		ls_CurrentDetail
String		ls_CurrentStyle
String		ls_MessageString
String		ls_Note
Long			ll_LinkId
Long			ll_MaxLinks
u_dw		   ldw_LinkArgs
u_dw		   ldw_LinkList

Window		lw_currentParent
Window		lw_nextParent

ldw_LinkArgs = Parent.dw_LinkArgs
ldw_LinkList = Parent.dw_LinkList

//Build a MessageBox String to Output which links are being defined
ll_MaxLinks = ldw_LinkList.RowCount()
IF ll_MaxLinks > 0 THEN
	ls_CurrentMaster = ldw_LinkList.GetItemString(Parent.dw_LinkList.GetRow(), cs_OBJECTNAMECOL)
	ls_MessageString = "Link " + ls_CurrentMaster + " To:~n"
	FOR ll_Index = 1 TO ll_MaxLinks
		ls_CurrentDetail = ldw_LinkList.GetItemString(ll_Index, cs_TITLECOL)
		ls_CurrentStyle = ldw_LinkList.GetItemString(ll_Index, cs_STYLECOL)
		ls_MessageString += "  - " + ls_CurrentDetail + "(" + ls_CurrentStyle + ")"+"~n"
	NEXT
ELSE
	ls_MessageString = "No Links will be defined"
END IF

ls_Note = "Note:~nSaving a link definition does not apply any links.~nTo apply links " + &
				"right click on the object and choose 'Apply Link'"
li_Apply = MessageBox("Define Links", ls_MessageString + "~n" + ls_Note ,&
Exclamation!,OKCancel!,2)
IF li_Apply = 2 THEN
	//Do Nothing

ELSEIF li_Apply = 1 THEN
	//Destroy All links that use definitions in the delete buffer
	FOR ll_Index = 1 TO ldw_linklist.DeletedCount()
		ll_Linkid = ldw_linklist.GetItemNumber( ll_Index,"linkid", DELETE!, FALSE)
		lw_CurrentParent = iw_ParentWindow
		lw_NextParent = iw_ParentWindow.ParentWindow()	
		DO WHILE isValid(lw_NextParent)
			IF isValid(lw_NextParent.ParentWindow()) THEN
				lw_CurrentParent = lw_NextParent
			END IF
			lw_NextParent = lw_NextParent.ParentWindow()
		LOOP
		Parent.of_destroyLinks(ll_linkId, lw_CurrentParent)
	NEXT
	
	//Updates Link and Argument tables
	li_LinkUpdate = ldw_LinkList.Update(TRUE, FALSE)

	IF li_LinkUpdate = 1 THEN
		li_ArgsUpdate = Parent.dw_LinkArgs.Update(TRUE, FALSE)
		IF li_LinkUpdate = 1 AND li_ArgsUpdate = 1 THEN
			COMMIT;
			ldw_LinkList.ResetUpdate ( )
			ldw_LinkArgs.ResetUpdate ( )
			li_Result = 1
		ELSE
			ROLLBACK;
			li_Result = -1
		END IF
	END IF
This.Enabled = FALSE
ELSE
	li_Result = 0
END IF

Return li_Result
end event

type dw_linklist from u_dw within w_dwlink
event type long ue_rowadded ( long al_row )
integer x = 69
integer y = 128
integer width = 2473
integer height = 476
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_linklist"
end type

event type long ue_rowadded(long al_row);/***************************************************************************************
NAME: 	ue_RowAdded 

ACCESS:	Public
		
ARGUMENTS: 	(Long al_row)  

RETURNS:		None
	
DESCRIPTION:
			Sets the Style and Linkid Fields And Sets/Scrolls to the current added row
			
			Triggers ue_UpdateDwCodeTable() to Set the Dwtitle code table


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/23/05
	
***************************************************************************************/
Long			ll_CurrentRow = 1
Long			ll_NextId


ll_CurrentRow = al_row

Parent.dw_Link.Event ue_UpdateDwCodeTable()
Parent.dw_LinkArgs.Visible = FALSE
Parent.gb_args.Visible = FALSE


//Set the linkid value to the row number that inserted
//linkid value will be used to filter the link arguments datawindow
gnv_app.of_getNextId("dwlink", ll_NextId, FALSE)
This.SetItem(ll_CurrentRow, "linkid", ll_NextId)

//Set the style to scroll as default
This.SetItem(ll_CurrentRow,"style","scroll") 

//Set the Object name to Master
This.SetItem(ll_CurrentRow,"objectname", idw_MasterDw.of_GetObjName()) 


This.SetRow(ll_CurrentRow)
This.ScrollToRow(ll_CurrentRow)

//Disable Apply Button
Parent.cb_Apply.Enabled = FALSE

Return ll_CurrentRow
end event

event constructor;call super::constructor;This.SetTransObject(SQLCA)
This.ShareData (Parent.dw_link)

This.of_SetRowSelect(TRUE)
This.inv_RowSelect.of_SetRequestor(THIS)
This.inv_RowSelect.of_SetStyle(0)


end event

event pfc_addrow;call super::pfc_addrow;//ll_AncestorReturn is the row number actually added
//Extends Ancestor and Triggers ue_RowAdded


Long	ll_Return
Long 	ll_AncestorReturn

ll_AncestorReturn = AncestorReturnValue

ll_Return = This.Event ue_RowAdded(ll_AncestorReturn)

Return ll_Return
end event

event pfc_insertrow;//Overrides Ancestor
//A row will be Added (appended) instead of Inserted 

Long	ll_Return
Long 	ll_AncestorReturn

ll_Return = This.Event pfc_addrow()

Return ll_Return

end event

event rowfocuschanged;call super::rowfocuschanged;/***************************************************************************************
NAME: 	ue_RowFocusChanged

ACCESS:	Public
		
ARGUMENTS: 	(Long currentrow)  

RETURNS:		None
	
DESCRIPTION:
			Scrolls/SetRow to CurrentRow
			
			Triggers ue_FilterArguments to display correct dw_LinkArg argument rows
			


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/24/05
	
***************************************************************************************/


Long		ll_Row
Long		ll_MaxControls	
Integer	li_Index
String	ls_Column
String	ls_Value
String	ls_Detail
String	ls_CurrentStyle
String	ls_LastTitle
u_dw		ldw_CurrentDw

This.ScrollToRow(CurrentRow)
This.SetRow(CurrentRow)


Parent.dw_link.ScrollToRow(CurrentRow)
Parent.dw_link.SetRow(CurrentRow)


Parent.dw_linkargs.Event ue_FilterArguments()

IF currentRow > 0 THEN
	ls_Detail = This.GetItemString(currentRow, cs_TITLECOL)
	IF NOT isNull(ls_Detail) AND Len(ls_Detail) > 0 THEN
		
		ldw_CurrentDw = Parent.dw_link.Event ue_GetDwHandle(ls_Detail)
		//Update Code Tables
		Parent.dw_linkargs.Event ue_UpdateDetailCodeTable(ldw_CurrentDw)
		Parent.dw_linkargs.Event ue_UpdateMastercodeTable()
END IF
	
	
	//List all titles with the detailname that will be affected
	ll_MaxControls = UpperBound(iw_ParentWindow.Control)
	This.SetItem(currentRow, cs_DWTITLESCOL, "")
	FOR li_Index = 1 TO ll_MaxControls
		IF iw_ParentWindow.Control[li_Index].TypeOf() = DataWindow! AND iw_ParentWindow.Control[li_Index].triggerEvent("ue_hasIds") = 1 THEN
			ldw_CurrentDw = iw_ParentWindow.Control[li_Index]
			IF ldw_CurrentDw.of_GetObjName() = ls_Detail THEN
				ls_LastTitle = This.GetItemString(currentRow, cs_DWTITLESCOL)
				This.SetItem(currentRow, cs_DWTITLESCOL, ls_LastTitle + ldw_CurrentDw.Title + "~r~n")
			END IF
		END IF
	NEXT
END IF



//Hide Add/Remove if style is retireve
IF currentrow > 0 THEN
	Parent.gb_details.Visible = TRUE
	Parent.dw_link.Visible = TRUE
	ls_CurrentStyle = GetItemString(CurrentRow, cs_STYLECOL)
	IF ls_CurrentStyle = cs_RETRIEVECOL THEN
		Parent.dw_linkargs.Object.b_add.visible = FALSE
		Parent.dw_linkargs.Object.b_remove.visible = FALSE
	ELSE
		Parent.dw_linkargs.Object.b_add.visible = TRUE
		Parent.dw_linkargs.Object.b_remove.visible = TRUE
	END IF
ELSE
	Parent.dw_link.Visible = FALSE
	Parent.gb_details.Visible = FALSE
END IF
end event

event pfc_deleterow;call super::pfc_deleterow;//Hides link arguments datawindow if there are no rows
//Extends Ancestor


Integer li_Return
Long	  ll_ArgumentKey

IF This.RowCount() = 0 THEN
	IF isValid(dw_linkargs) THEN
		Parent.dw_linkargs.visible = FALSE
		Parent.gb_args.Visible = FALSE
		Parent.cb_apply.enabled = TRUE
		li_Return = 1
	ELSE
		li_Return = -1
	END IF
ELSE
	Parent.cb_apply.enabled = TRUE
	This.Event RowFocusChanged(1)
END IF


Return li_Return


end event

event pfc_predeleterow;call super::pfc_predeleterow;/***************************************************************************************
NAME: 	pfc_predeleterow Event

ACCESS:	Public
		
ARGUMENTS: 	(None)  

RETURNS:		integer
	
DESCRIPTION:
			IF li_Continue is 1 then
				Discards all arguments rows that match the current linkid
				Return 1 (continue with deleteing)
			IF li_Continue is not 1 then
				return 0 (do not continue with deleting)
				
			Note about discarding:	
			This dicarding rows instead of deleting will prevent an update error
			when dw_linklist is updated.
			(In other words, the update will not cascade a delete on rows
			that were already deleted becuase they will be discarded instead)
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/3/05
	
***************************************************************************************/


Long		ll_ArgumentKey
Long		ll_RowCount
Long		ll_Index
Integer	li_Return
Integer 	li_Continue
String	ls_FindString
String	ls_DetailName
String	ls_Style

ls_DetailName = This.GetItemString(This.GetRow(), "detailname")
ls_Style = This.GetItemString(This.GetRow(), "style")

IF NOT isNull(ls_DetailName) AND NOT isNull(ls_Style) THEN
	li_Continue = MessageBox("Warning!", "Deleteing this link definition will destroy any " + ls_DetailName + "(" + ls_Style + ")  links " + &
				"that are currently applied for all " + idw_MasterDw.of_GetObjName() + " objects.~n" + & 
				"Delete Definition Anyway?", Exclamation!, YesNo! , 2)
	IF li_Continue = 1 THEN 
		
		//Discard All argument rows that match the dw argkey
		//Using Discard instead of DeleteRow so that the LinkArgsCopy Update
		//will not try to delete rows that were already deleted from the LinkList Updated cascade
		ll_ArgumentKey = This.GetItemNumber(This.GetRow(), "linkid")
		ll_RowCount = Parent.dw_LinkArgs.RowCount()
		FOR ll_Index = ll_RowCount TO 1 STEP -1
			IF Parent.dw_LinkArgs.GetItemNumber(ll_Index, "linkid") = ll_ArgumentKey THEN
				Parent.dw_LinkArgs.RowsDiscard( ll_Index, ll_Index, Primary!)
			END IF
		NEXT
		
		//Discard all rows that match the linkid in the Delete buffer
		ll_RowCount = Parent.dw_LinkArgs.DeletedCount()

		FOR ll_Index = ll_RowCount TO 1 STEP -1
			IF Parent.dw_LinkArgs.GetItemNumber(ll_Index, "linkid", Delete!, TRUE) = ll_ArgumentKey THEN
				Parent.dw_LinkArgs.RowsDiscard( ll_Index, ll_Index, Delete!)
			END IF
		NEXT
		
		li_Return = 1
	ELSE
		li_Return = 0
	END IF
ELSE
	li_Return = 1 //No detail name was chosen yet, so procceed with delete
END IF

Return li_Return
end event

type dw_link from u_dw within w_dwlink
event type datawindow ue_getdwhandle ( string as_dwchoice )
event ue_updatedwcodetable ( )
integer x = 87
integer y = 696
integer width = 2450
integer height = 412
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_linkproperties"
boolean vscrollbar = false
boolean border = false
string icon = "AppIcon!"
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event type datawindow ue_getdwhandle(string as_dwchoice);/***************************************************************************************
NAME: 	GetDwHandle() Event

ACCESS:	Public
		
ARGUMENTS: 	(string	as_Choice)

RETURNS:		u_dw
	
DESCRIPTION:
			Loops through all the datawindows on the Parent Control
				If the object name of the Dw Matches the as_dwChoice, that datawindow is returned.
				Otherwise, returns null dw
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/24/05
	
***************************************************************************************/

Integer 		li_Index = 1
Long			ll_MaxControls
u_dw			ldw_CurrentDw
u_dw			ldw_Return

ll_MaxControls = UpperBound(iw_ParentWindow.Control)
FOR li_Index = 1 TO ll_MaxControls
	IF iw_ParentWindow.Control[li_Index].TypeOf() = DataWindow! AND iw_ParentWindow.Control[li_Index].triggerEvent("ue_hasIds") = 1 THEN
		ldw_CurrentDw = iw_ParentWindow.Control[li_Index]
		
		//If the current object in the control matches the desired object name
		//Then exit the loop and return the dw
		IF ldw_CurrentDw.of_GetObjName() = as_DwChoice THEN
			ldw_Return = ldw_CurrentDw
			EXIT
		END IF
	END IF
NEXT

Return ldw_Return
end event

event ue_updatedwcodetable();/***************************************************************************************
NAME: 	UpdateDwCodeTable() Event

ACCESS:	Public
		
ARGUMENTS: 	(NONE)

RETURNS:	
	
DESCRIPTION:
			Loops through all the datawindows on the parent control and
			Updates the detailname Code Table 
					Display Value = dw detail name
					Data Value = dw detail
				
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/24/05
	
***************************************************************************************/
Integer 		li_Index
String 		ls_DetailValues
String		ls_Detail
u_dw			ldw_CurrentDw	


FOR li_Index = 1 TO UpperBound(iw_ParentWindow.Control) 
	
	IF iw_ParentWindow.Control[li_Index].TypeOf() = DataWindow! AND iw_ParentWindow.Control[li_Index].triggerEvent("ue_hasIds") = 1THEN
		ldw_CurrentDw = iw_ParentWindow.Control[li_Index]
		ls_Detail = ldw_CurrentDw.of_GetObjName( )
		//Make sure the Master does not get added to the list of possible links
		IF ls_Detail <> idw_MasterDw.of_GetObjName() THEN
			//Set  Display Value to ls_Title
			//Set  Data Value to ls_Detail
			ls_DetailValues += ls_Detail + "~t" + ls_Detail + "/"
		END IF
	END IF
	
NEXT

This.Object.detailname.Values = ls_DetailValues
Parent.dw_LinkList.Object.detailname.Values = ls_DetailValues
end event

event itemchanged;call super::itemchanged;/***************************************************************************************
NAME: 	itemchanged() Event

ACCESS:	Public
		
ARGUMENTS: 	()

RETURNS:		None
	
DESCRIPTION:
			IF the DwTitle has Changed,
				trigger ue_InsertArgumentRows to insert correct argument rows
				and list details that will be affected
				
			IF the Style Radio button has changed, Call ue_InserArgumentRows to insert 
				correct rows. Also sets the add/remove buttons to invisible if retrieve is chosen

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/24/05
	
***************************************************************************************/

Integer 	li_Index = 1
Integer	li_LinkLineReturn
Long		ll_MaxColumns
Long		ll_MaxControls
Long		ll_RowCount
String	ls_Style
String	ls_LastTitle

u_dw		ldw_CurrentDw


//If the detailname list has changed 
IF String(dwo.Name) = "detailname" THEN
	Parent.gb_args.Visible = TRUE
	Parent.dw_linkargs.visible = TRUE
	
	//List all titles with the detailname that will be affected
	ll_MaxControls = UpperBound(iw_ParentWindow.Control)
	This.SetItem(row, cs_DWTITLESCOL, "")
	FOR li_Index = 1 TO ll_MaxControls
		IF iw_ParentWindow.Control[li_Index].TypeOf() = DataWindow! AND iw_ParentWindow.Control[li_Index].triggerEvent("ue_hasIds") = 1 THEN
			ldw_CurrentDw = iw_ParentWindow.Control[li_Index]
			IF ldw_CurrentDw.of_GetObjName() = data THEN
				ls_LastTitle = This.GetItemString(row, cs_DWTITLESCOL)
				This.SetItem(row, cs_DWTITLESCOL, ls_LastTitle + ldw_CurrentDw.Title + "~r~n")
			END IF
		END IF
	NEXT

	
	ls_Style = This.GetItemString(row, cs_STYLECOL)
	ldw_CurrentDw = This.Event ue_getDwHandle(data)
	//Insert Argument Rows for Chosen Dw
	Parent.dw_linkargs.Event ue_InsertArgumentRows(ldw_CurrentDw, Parent.of_GetArgKey(), ls_Style)
END IF


//If style radio button has changed 
IF dwo.Name = cs_STYLECOL THEN

	IF data = "scroll" THEN
		Parent.dw_linkargs.Object.b_add.visible = TRUE
		Parent.dw_linkargs.Object.b_remove.visible = TRUE
		Parent.dw_linkargs.Event ue_InsertArgumentRows(ldw_CurrentDw, Parent.of_GetArgKey(), cs_SCROLLCOL)
	ELSEIF data = "retrieve" THEN
		ldw_CurrentDw = This.Event ue_GetDwHandle(This.GetItemString(row, cs_TITLECOL))
		Parent.dw_linkargs.Event ue_InsertArgumentRows(ldw_CurrentDw, Parent.of_GetArgKey(), cs_RETRIEVECOL)
		Parent.dw_linkargs.Object.b_add.visible = FALSE
		Parent.dw_linkargs.Object.b_remove.visible = FALSE
	ELSEIF data = "filter" THEN
		Parent.dw_linkargs.Object.b_add.visible = TRUE
		Parent.dw_linkargs.Object.b_remove.visible = TRUE
		Parent.dw_linkargs.Event ue_InsertArgumentRows(ldw_CurrentDw, Parent.of_GetArgKey(), cs_FILTERCOL)
	END IF
	
END IF




end event

event constructor;call super::constructor;This.of_SetDeleteable( FALSE )
This.of_SetInsertable( FALSE )
end event

type dw_linkargs from u_dw within w_dwlink
event ue_insertargumentrows ( datawindow adw_currentdw,  integer ai_argkey,  string as_style )
event ue_filterarguments ( )
event type integer ue_updatedetailcodetable ( datawindow adw_currentdw )
event type integer ue_updatemastercodetable ( )
event ue_ ( )
integer x = 101
integer y = 1224
integer width = 2437
integer height = 400
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_linkargs"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event ue_insertargumentrows(datawindow adw_currentdw, integer ai_argkey, string as_style);/***************************************************************************************
NAME: 	ue_InsertArgumentRows

ACCESS:	Public
		
ARGUMENTS: 	(DataWindow adw_CurrentDw, Integer ai_ArgKey)  

RETURNS:		None
	
DESCRIPTION:
			Stores Argument types and names of adw_CurrentDw
			Inserts Argument Rows and Sets the linkid field for that row to ai_argkey
			(ai_argkey should match the detail row linkid field in linklist and link

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/23/05
	
***************************************************************************************/
Integer 	li_Index
Integer	li_Index2 
Long		ll_MaxArgs
Long		ll_MaxColumns
Long		ll_CurrentRow = 0
Long		ll_RowCount
String	ls_Style
String	ls_ArgNames[]
String	ls_ArgDataTypes[]


n_cst_dwsrv		lnv_dwsrv
lnv_dwsrv = CREATE n_cst_dwsrv


//Delete All argument rows that match the dw argkey
ll_RowCount = This.RowCount()
FOR li_Index = ll_RowCount TO 1 STEP -1
	IF This.GetItemNumber(li_Index, "linkid") = ai_ArgKey THEN
		This.DeleteRow(li_Index)
	END IF
NEXT

IF as_Style = cs_RETRIEVECOL THEN
	//Get Retrieval Argument Names and Types
	lnv_dwsrv.of_SetRequestor(adw_CurrentDw)
	lnv_dwsrv.of_DwArguments (ls_ArgNames[], ls_ArgDataTypes[])
	ll_MaxArgs = UpperBound(ls_ArgNames[])

	
	//Insert Argument Rows
	FOR li_Index = 1 TO ll_MaxArgs
		//Insert Argument Row and set retrievalname and retrievaltype
		ll_CurrentRow = This.InsertRow(0)
		This.SetItem(ll_CurrentRow,"retrievalname",ls_ArgNames[li_Index]) 
		This.SetItem(ll_CurrentRow,"retrievaltype",ls_ArgDataTypes[li_Index]) 
		//Mandatory means it cannot be deleted by remove button
		This.SetItem(ll_CurrentRow,"mandatory", 1)
		This.SetItem(ll_CurrentRow,"argumentorder", li_Index)
		This.SetItem(ll_CurrentRow,"linkid", ai_argkey)
		This.SetItem(ll_CurrentRow,"detailcolumn", "")
		This.SetItem(ll_CurrentRow,"mastercolumn", "")
	NEXT
	
ELSEIF as_Style = cs_SCROLLCOL OR as_Style = cs_FILTERCOL THEN
		//Insert one row for as_Style = scroll or filter
		ll_CurrentRow = This.InsertRow(0)
		This.SetItem(ll_CurrentRow,"retrievalname","-") 
		This.SetItem(ll_CurrentRow,"retrievaltype","-") 
		This.SetItem(ll_CurrentRow,"linkid", ai_argkey)
		This.SetItem(ll_CurrentRow,"argumentorder", ll_CurrentRow)
		This.SetItem(ll_CurrentRow,"mandatory", 1)
		This.SetItem(ll_CurrentRow,"detailcolumn", "")
		This.SetItem(ll_CurrentRow,"mastercolumn", "")
END IF

//Update MasterCol and DetailCol Code Tables
This.Event ue_UpdateMasterCodeTable()
This.Event ue_UpdateDetailCodeTable(adw_CurrentDw) 

Parent.cb_Apply.Enabled = FALSE

//If no rows were inserted, enable the apply button (with no retrieval args) 
IF ll_CurrentRow = 0 AND isValid(adw_CurrentDw) THEN
	Parent.cb_Apply.Enabled = TRUE
END IF


end event

event ue_filterarguments();/***************************************************************************************
NAME: 	ue_FilterArguments

ACCESS:	Public
		
ARGUMENTS: 	()

RETURNS:		None
	
DESCRIPTION:
			Filter dw_LinkArgs based on the linkid
			Sort by order field, ascending

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/24/05
	
***************************************************************************************/



Integer	li_LinkListArgKey 
Integer	li_Return
String	ls_Filter
li_LinkListArgKey = Parent.of_GetArgKey()
ls_Filter = "linkid = "+ String(li_LinkListArgKey)


//ls_Filter is Null on first row addition
//Do not setfilter if the filter is null
IF NOT isNull(ls_Filter) THEN
	li_Return = This.SetFilter(ls_Filter) 
	This.Filter()
	//Set Sort so that the mandatory retrival args are at the top
	This.SetSort("argumentorder A")
	This.Sort()
END IF



end event

event type integer ue_updatedetailcodetable(datawindow adw_currentdw);/***************************************************************************************
NAME: 	ue_UpdateDetailColTable

ACCESS:	Public
		
ARGUMENTS: 	(DataWindow adw_CurrentDW)  

RETURNS:		None
	
DESCRIPTION:
			Updates the DetailCol field Code TAble to the Columns of adw_currentDw

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/23/05
	
***************************************************************************************/



Long		ll_MaxColumns
Integer	li_Index
Integer	li_Return
String	ls_DetailCol
String	ls_DetailColValues

IF isValid(adw_CurrentDw) THEN
	//Populate the Detail Columns List Box
	IF isValid( adw_CurrentDw.Object ) THEN 
		ll_MaxColumns = Long(adw_CurrentDw.Object.DataWindow.Column.Count)
		FOR li_Index = 1 to ll_MaxColumns
			ls_DetailCol = adw_CurrentDw.Describe("#"+String(li_Index)+".Name")
			ls_DetailColValues += ls_DetailCol + "~t" + ls_DetailCol + "/"
		NEXT
		This.Object.detailcolumn.Values = ls_DetailColValues
		li_Return = 1
	ELSE
		li_Return = -1
	END IF
ELSE
	li_Return = -1
END IF

Return li_Return
end event

event type integer ue_updatemastercodetable();/***************************************************************************************
NAME: 	ue_UpdateMasterCodeTable

ACCESS:	Public
		
ARGUMENTS: 	(none)  

RETURNS:		None
	
DESCRIPTION:
			Updates the MasterCol field Code TAble to the Columns of idw_MasterDw

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/23/05
	
***************************************************************************************/


Long 		ll_MaxColumns
String	ls_Mastercol
String	ls_MasterColValues
Integer	li_Index

//Update Master Column Code Table
ll_MaxColumns = Long(idw_MasterDw.Object.DataWindow.Column.Count)
FOR li_Index = 1 to ll_MaxColumns
	ls_MasterCol = idw_MasterDw.Describe("#"+String(li_Index)+".Name")
	ls_MasterColValues += ls_MasterCol + "~t" + ls_MasterCol + "/"
NEXT
This.Object.mastercolumn.Values = ls_MasterColValues

Return 1
end event

event buttonclicked;call super::buttonclicked;/***************************************************************************************
NAME: 	ButtonClicked Event

ACCESS:	Public
		
ARGUMENTS: 	()

RETURNS:		None
	
DESCRIPTION:
			If the Add button is clicked, an argument row is inserted 
			(does not set mandatory to 1, so it can be deleted)
			
			If remove button is clicked and mandtory field = 1, then row is deleted

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/24/05
	
***************************************************************************************/

LOng	ll_Return
Long	ll_Count

Long ll_RowInserted
//IF the Add button is clicked, Insert Row
IF dwo.Name = "b_add" THEN
	ll_RowInserted = This.InsertRow(0)
	This.SetItem(ll_RowInserted, cs_RETRIEVALNAMECOL,"-") 
	This.SetItem(ll_RowInserted, cs_RETRIEVALTYPECOL,"-") 
	This.Setitem(ll_RowInserted, cs_ARGKEYCOL, Parent.of_GetArgKey())
	This.SetItem(ll_RowInserted, cs_ORDERCOL, ll_RowInserted)
	This.SetItem(ll_RowInserted, cs_MASTERCOL, "")
	This.SetItem(ll_RowInserted, cs_DETAILCOL, "")
END IF
//If the remove button is clicked and there are rows, delete the row
IF dwo.Name = "b_remove" THEN
	IF This.RowCount() > 0 THEN
		IF This.GetItemNumber(This.RowCount(), cs_MANDATORYCOL) <> 1 THEN
			This.DeleteRow(This.RowCount())
		END IF
	END IF
END IF

end event

event itemchanged;call super::itemchanged;/***************************************************************************************
NAME: 	itemchanged

ACCESS:	Public
		
ARGUMENTS: 	()

RETURNS:		None
	
DESCRIPTION:
			Copys Primary and Filter buffers of dw_LinkArgs to Primary buffer of ldw_LinkArgsCopy
			so that we can loop through one primary buffer of the copy
			
			IF any detailcolumn or mastercolumn fields are empty, the Apply button is disabled

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/24/05
	
***************************************************************************************/


Long			ll_Index
String		ls_MasterArg
String		ls_DetailArg
Boolean		lb_ApplyEnabled = TRUE
DataStore	lds_LinkArgsCopy
u_dw			ldw_LinkArgs



ldw_LinkArgs = Parent.dw_LinkArgs


//Copy Primary and Filter Buffers of ldw_LinkArgs to lds_LinkArgsCopy
lds_LinkArgsCopy = CREATE DataStore
lds_LinkArgsCopy.DataObject =	ldw_LinkArgs.DataObject
ldw_LinkArgs.RowsCopy(1,ldw_LinkArgs.RowCount(), Primary!, lds_LinkArgsCopy, 1, Primary!)	
ldw_LinkArgs.RowsCopy(1,ldw_LinkArgs.FilteredCount(), Filter!, lds_LinkARgsCopy, lds_LinkArgsCopy.RowCount()+1, Primary!)

//IF any Argument rows are equal to "", Disable Apply Button
FOR ll_Index=1 TO lds_LinkArgsCopy.RowCount()
	ls_MasterArg = lds_LinkArgsCopy.GetItemString( ll_Index, cs_MASTERCOL)
	ls_DetailArg = lds_LinkArgsCopy.GetItemString( ll_Index, cs_DETAILCOL)
	IF ls_MasterArg = "" OR ls_DetailArg = "" THEN
		lb_ApplyEnabled = FALSE
	END IF
NEXT


Parent.cb_Apply.Enabled = lb_ApplyEnabled

DESTROY lds_LinkArgsCopy
end event

event constructor;call super::constructor;This.of_SetDeleteable( FALSE )
This.of_SetInsertable( FALSE )


This.SetTransObject(SQLCA)

end event

type cb_cancel from commandbutton within w_dwlink
integer x = 2222
integer y = 1720
integer width = 338
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;Close(w_DwLink)
end event

type gb_details from groupbox within w_dwlink
boolean visible = false
integer x = 73
integer y = 644
integer width = 2473
integer height = 476
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylebox!
end type

type gb_args from groupbox within w_dwlink
boolean visible = false
integer x = 78
integer y = 1156
integer width = 2473
integer height = 476
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Link Arguments"
borderstyle borderstyle = stylebox!
end type

