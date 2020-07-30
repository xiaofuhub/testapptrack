$PBExportHeader$w_dwapplylink.srw
forward
global type w_dwapplylink from w_response
end type
type cb_close from commandbutton within w_dwapplylink
end type
type cb_apply from commandbutton within w_dwapplylink
end type
type dw_linklist from u_dw within w_dwapplylink
end type
type dw_link from u_dw within w_dwapplylink
end type
type dw_linkargs from u_dw within w_dwapplylink
end type
type gb_link from groupbox within w_dwapplylink
end type
type gb_1 from groupbox within w_dwapplylink
end type
end forward

global type w_dwapplylink from w_response
integer x = 214
integer y = 221
integer width = 2597
integer height = 1504
string title = "Apply Links"
long backcolor = 12632256
boolean ib_isupdateable = false
boolean ib_disableclosequery = true
event ue_apply ( )
cb_close cb_close
cb_apply cb_apply
dw_linklist dw_linklist
dw_link dw_link
dw_linkargs dw_linkargs
gb_link gb_link
gb_1 gb_1
end type
global w_dwapplylink w_dwapplylink

type variables
PUBLIC:
Constant String	cs_TITLECOL = "detailname"
Constant String	cs_RETRIEVECOL = "retrieve"
Constant	String	cs_SCROLLCOL	= "scroll"
Constant String	cs_FILTERCOL	= "filter"
Constant String	cs_MASTERCOL = "mastercol"
Constant	String	cs_DETAILCOL = "detailcol"
Constant	String	cs_ORDERCOL = "order"
Constant	String	cs_ARGKEYCOL = "linkid"
Constant	String	cs_STYLECOL = "style"
Constant	String	cs_RETRIEVALTYPECOL = "retrievaltype"
Constant	String	cs_RETRIEVALNAMECOL = "retrievalname"
Constant	String	cs_MANDATORYCOL = "mandatory"


Window	iw_ParentWindow
u_dw		idw_MasterDw

u_dw		idw_CurrentDw
Boolean	ib_TitleBar 
Boolean	ib_Visible 
Boolean	ib_BringToTop
Boolean	ib_ProcessClick = TRUE

Long		il_Count //used in timer event

DataStore 	ids_MouseOvers //Retrieved in constructor of dw_link
end variables

forward prototypes
public function integer of_setparent (window aw_parentwindow)
public function integer of_getargkey ()
public function integer of_retrieveargs ()
public function u_dw of_getdwhandle (long al_handle)
public function integer of_setmouseovers (datawindow adw_currentdw, long al_linkid)
end prototypes

event ue_apply();/***************************************************************************************
NAME: 	ue_Apply() Event

ACCESS:	Public
		
ARGUMENTS: 	(None)  

RETURNS:		None
	
DESCRIPTION:
			Unlinks all old detail links for the Master and applies all links specified

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/23/05
	
***************************************************************************************/

Integer	li_Apply
Integer	li_Linked
Long		ll_Index
LOng		ll_Index2
Long		ll_NumLinks
Long		ll_NumArgs
Long		ll_FoundRow	
Long		ll_LinkId
Long		ll_MouseCount
String	ls_Style
String	ls_Filter
Long		ll_Handle
String	ls_MasterArg
String	ls_DetailArg
String	ls_Sort

u_dw		ldw_DwLink
u_dw		ldw_Master

DataStore	lds_LinkArgsCopy
DataStore	lds_LinksCopy


//Copy Primary and Filter Buffers of dw_LinkArgs to lds_LinkArgsCopy
lds_LinkArgsCopy = CREATE DataStore
lds_LinkArgsCopy.DataObject =	dw_LinkArgs.DataObject
dw_LinkArgs.RowsCopy(1,dw_LinkArgs.RowCount(), Primary!, lds_LinkArgsCopy, 1, Primary!)	
dw_LinkArgs.RowsCopy(1,dw_LinkArgs.FilteredCount(), Filter!, lds_LinkARgsCopy, lds_LinkArgsCopy.RowCount()+1, Primary!)
ll_NumArgs = lds_LinkArgsCopy.RowCount()

//Copy Primary and Filter Buffers of dw_Link to lds_LinksCopy
lds_LinksCopy = CREATE DataStore
lds_LinksCopy.DataObject =	dw_Link.DataObject
dw_Link.RowsCopy(1,dw_Link.RowCount(), Primary!, lds_LinksCopy, 1, Primary!)	
dw_Link.RowsCopy(1,dw_Link.FilteredCount(), Filter!, lds_LinksCopy, lds_LinksCopy.RowCount()+1, Primary!)

//Sort by linked so that when linkage is removed, its removes unlinked ones first
ls_Sort = "linked A"
lds_LinksCopy.SetSort(ls_Sort)
lds_LinksCopy.Sort()
ll_NumLinks = lds_LinksCopy.RowCount()


IF NOT isValid(idw_MasterDW.inv_Linkage) THEN
	idw_MasterDw.of_SetLinkage(TRUE)
END IF

//Apply All Links
FOR ll_Index = 1 TO ll_NumLinks
		ll_Handle = lds_LinksCopy.GetItemNumber(ll_Index, "dwhandle")
		ldw_DwLink = This.of_GetDwHandle(ll_Handle)
		IF isValid(ldw_DwLink) THEN
			IF isValid(ldw_DwLink.inv_Linkage) THEN
				ldw_DwLink.inv_Linkage.of_ResetMaster()
			END IF
			li_Linked = lds_LinksCopy.GetItemNumber(ll_Index, "linked")
			IF li_Linked = 1 THEN
				ll_LinkId = lds_LinksCopy.GetItemNumber(ll_Index, "linkid")
				IF NOT isValid(ldw_DwLink.inv_Linkage) THEN
					ldw_DwLink.of_SetLinkage(TRUE)//Set New Linkage
				END IF
				ldw_DwLink.inv_Linkage.of_setMaster(idw_MasterDw,ll_LinkId)
				//Set the Link Style
				ll_FoundRow = dw_LinkList.Find("linkid = " + String(ll_LinkId) ,1, dw_LinkList.RowCount())
				ls_Style = dw_LinkList.GetItemString(ll_FoundRow, "style")
				IF ls_Style = "scroll" THEN
					ldw_DwLink.inv_Linkage.of_SetStyle(n_cst_dwsrv_Linkage.SCROLL)
				ELSEIF ls_Style = "filter" THEN
					ldw_DwLink.inv_Linkage.of_SetStyle(n_cst_dwsrv_Linkage.FILTER)
				ELSEIF ls_Style = "retrieve" THEN
					ldw_DwLink.inv_Linkage.of_SetStyle(n_cst_dwsrv_Linkage.RETRIEVE)
				END IF
					
				//Set Filter of LinkArgsCopy based on the current linkid
				ls_Filter = "linkid = "+ String(ll_LinkId)
				lds_LinkArgsCopy.SetFilter(ls_Filter)
				lds_LinkArgsCopy.Filter()
				lds_LinkArgsCopy.SetSort("order A")
				lds_LinkArgsCopy.Sort()
				ll_NumArgs = lds_LinkArgsCopy.RowCount()
				//Set Arguments
				FOR ll_Index2=1 TO ll_NumArgs
					ls_MasterArg = lds_LinkArgsCopy.GetItemString( ll_Index2, "mastercolumn")
					ls_DetailArg = lds_LinkArgsCopy.GetItemString( ll_Index2, "detailcolumn")
					ldw_DwLink.inv_Linkage.of_SetArguments( ls_MasterArg, ls_DetailArg)
				NEXT
				
				//Set any mouseovers that are now valid
				This.of_SetMouseOvers(ldw_DwLink, ll_linkid)
			ELSE  //Not linked
				IF isValid(idw_MasterDw.inv_MouseOver) THEN
					idw_MasterDw.inv_MouseOver.of_ResetPopup(ldw_DwLink)//if it was a popup, reset the popup
					IF idw_MasterDw.inv_MouseOver.of_GetDwResponse(ldw_DwLink) = 1 THEN
						IF isValid(ldw_DwLink.inv_Linkage) THEN
								ldw_DwLink.Visible = TRUE //Set visible if it is currently a mouseover
						END IF
					END IF
					
				END IF
			END IF
		END IF
NEXT

cb_apply.Enabled = FALSE

Destroy lds_LinkArgsCopy
Destroy lds_LinksCopy
end event

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

ll_CurrentRow = This.dw_linkList.GetRow()

li_Return = This.dw_linkList.GetItemNumber(ll_CurrentRow, "linkid")

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
Long	lla_LinkIds[]
Long	ll_LinkId

ll_Max = dw_LinkList.RowCount()
FOR ll_Index = 1 TO ll_Max
	ll_LinkId = dw_LinkList.GetItemNumber(ll_Index, "linkid")
	lla_LinkIds[ll_Index] = ll_LinkId
NEXT

IF UpperBound(lla_LinkIds) > 0 THEN
	dw_linkargs.Retrieve(lla_LinkIds)
END IF

Return 1
end function

public function u_dw of_getdwhandle (long al_handle);/***************************************************************************************
NAME: 	of_GetDwHandle() Event

ACCESS:	Public
		
ARGUMENTS: 	(string	as_Choice)

RETURNS:		u_dw
	
DESCRIPTION:
			Loops through all the datawindows on the Parent Control
				If the handle of the Dw Matches the ai_handle, that datawindow is returned.
				Otherwise, returns null dw
			
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/24/05
	
***************************************************************************************/

Long	 		ll_Index
Long			ll_MaxControls
u_dw			ldw_CurrentDw
u_dw			ldw_Return

ll_MaxControls = UpperBound(iw_ParentWindow.Control)

FOR ll_Index = 1 TO ll_MaxControls
	IF iw_ParentWindow.Control[ll_Index].TypeOf() = DataWindow! AND iw_ParentWindow.Control[ll_Index].TriggerEvent("ue_HasIds") = 1 THEN
		ldw_CurrentDw = iw_ParentWindow.Control[ll_Index]
		//If the current object in the control matches the chosen dwtitle
		//Then exit the loop and return the dw
		IF Handle(ldw_CurrentDw)  = al_handle THEN
			ldw_Return = ldw_CurrentDw
			EXIT
		END IF
	END IF
NEXT

Return ldw_Return
end function

public function integer of_setmouseovers (datawindow adw_currentdw, long al_linkid);/***************************************************************************************
NAME: 	of_SetMouseOvers() Event

ACCESS:	Public
		
ARGUMENTS: 	(datawindow	adw_currentdw, long al_linkid)  

RETURNS:		integer
	
DESCRIPTION:
			Compares al_linkid to all the linkids in lds_Mousovers
			If the linkids match, the proper mouseover is set for this master window 
			
			Returns 1 if a mouseovers were successfully set
			Return -1 if an error occurs in setting mouseovers

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/19/05
	
***************************************************************************************/



String 	ls_Response
String	ls_ColName
String	ls_ResponseType
Long		ll_MOLinkid
Long		ll_MouseCount
Long		ll_Index
Integer	li_Return = 1
Integer	li_Retrieve

ll_MouseCount = ids_MouseOvers.RowCount()


//Loop through all ids_Mouseover rows and set proper mouseovers
FOR ll_Index = 1 TO ll_MouseCount
	ll_MOLinkid = ids_MouseOvers.GetItemNumber(ll_Index, "linkid")
	IF ll_MOlinkid = al_Linkid THEN
		ls_Response = ids_MouseOvers.GetItemString(ll_Index, "response")
		IF ls_Response = "[row]" THEN
			li_Return = idw_MasterDw.inv_MouseOver.of_SetDwResponse(adw_currentdw)
		ELSE
			ls_ColName = ids_MouseOvers.GetItemString(ll_Index, "columnname")
			IF NOT isValid(idw_MasterDw.inv_MouseOver) THEN
				idw_MasterDw.of_SetMouseover(True)
			END IF
			li_Return = idw_MasterDw.inv_MouseOver.of_SetDwResponse(ls_ColName, adw_currentdw)
		END IF
	END IF
NEXT


Return li_Return
end function

on w_dwapplylink.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_apply=create cb_apply
this.dw_linklist=create dw_linklist
this.dw_link=create dw_link
this.dw_linkargs=create dw_linkargs
this.gb_link=create gb_link
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_apply
this.Control[iCurrent+3]=this.dw_linklist
this.Control[iCurrent+4]=this.dw_link
this.Control[iCurrent+5]=this.dw_linkargs
this.Control[iCurrent+6]=this.gb_link
this.Control[iCurrent+7]=this.gb_1
end on

on w_dwapplylink.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_apply)
destroy(this.dw_linklist)
destroy(this.dw_link)
destroy(this.dw_linkargs)
destroy(this.gb_link)
destroy(this.gb_1)
end on

event open;call super::open;/***************************************************************************************
NAME: 	Open (Extends Ancestor)

ACCESS:	Public
		
ARGUMENTS: 	(none)

RETURNS:		None
	
DESCRIPTION:
			Gets A list of all Details that are defined for  Master DataWindow
			
			For Each Detail, dw_LinkList and dw_LinkArgs are updated appropriately 


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/23/05
	
***************************************************************************************/

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


IF isValid(idw_MasterDw)THEN
	dw_linklist.Retrieve(idw_MasterDw.of_GetObjName())
END IF

This.of_RetrieveArgs()

dw_link.Event ue_InsertPossibleLinks()

//Load Mouseover definitions

ids_Mouseovers = CREATE DataStore
ids_MouseOvers.DataObject = "d_mouseoverresponses"
ids_MouseOvers.SetTransObject(SQLCA)
ids_MouseOvers.Retrieve(idw_MasterDw.of_GetObjName())
end event

event closequery;call super::closequery;//Overriding Ancestor
Integer	li_Apply
Integer	li_Return

IF cb_apply.Enabled = TRUE THEN //If cb_apply is enabled, then a change has been made

	li_Apply = MessageBox("Apply Links?", "Would you like to apply changes?", &
					Question!, YesNoCancel!, 2)
	
	IF li_Apply = 1 THEN
		li_Return = 0
		This.Event ue_Apply()
	ELSEIF li_Apply = 2 THEN
		li_Return = 0
	ELSEIF li_Apply = 3 THEN
		li_Return = 1
	END IF
END IF

Return li_Return
end event

event timer;call super::timer;IF idw_CurrentDw.TitleBar = TRUE THEN
	idw_CurrentDw.TitleBar = FALSE
ELSE
	idw_CurrentDw.TitleBar = TRUE
END IF

//Stop timer after 5 intervals
IF il_Count >= 5 THEN
	Timer(0)
	//Restart the Master timer
	IF IsValid(idw_MasterDw.inv_MouseOver) THEN
		idw_MasterDw.inv_MouseOver.of_MouseOverOn()
	END IF
	//Restore old values
	idw_CurrentDw.TitleBar = ib_TitleBar
	idw_CurrentDw.Visible = ib_Visible
	idw_CurrentDw.BringToTop = ib_BringToTop
	ib_ProcessClick = TRUE
	
	dw_link.Object.b_show.Enabled = TRUE
END IF

il_Count ++
end event

event close;call super::close;IF isValid(idw_CurrentDw) THEN
	idw_CurrentDw.TitleBar = ib_TitleBar
	idw_CurrentDw.Visible = ib_Visible
	idw_CurrentDw.BringToTop = ib_BringToTop
END IF

//Turn Mouseover on (incase show button turned it off)
IF isValid( idw_MasterDw ) THEN
	IF isValid(idw_MasterDw.inv_MouseOver) THEN
		idw_MasterDw.inv_MouseOver.of_MouseOverOn() 
	END IF
END IF

IF isValid(ids_MouseOvers) THEN
	Destroy ids_MouseOvers
END IF
end event

type cb_help from w_response`cb_help within w_dwapplylink
boolean visible = false
integer x = 2597
integer y = 1440
end type

type cb_close from commandbutton within w_dwapplylink
integer x = 2213
integer y = 1292
integer width = 338
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(w_DwApplyLink)
end event

type cb_apply from commandbutton within w_dwapplylink
integer x = 1861
integer y = 1292
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
string text = "&Apply"
end type

event clicked;Parent.Event ue_Apply()
end event

type dw_linklist from u_dw within w_dwapplylink
integer x = 82
integer y = 64
integer width = 2427
integer height = 428
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_linklistapply"
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)

This.of_SetRowSelect(TRUE)
This.inv_RowSelect.of_SetRequestor(THIS)
This.inv_RowSelect.of_SetStyle(0)


This.of_setinsertable( FALSE)
This.of_setdeleteable( FALSE)

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
REVISION HISTORY : Maury 9/06/05
	
***************************************************************************************/

This.ScrollToRow(CurrentRow)
This.SetRow(CurrentRow)

Parent.dw_linkargs.Event ue_FilterArguments()
Parent.dw_link.Event ue_FilterLinks()


end event

type dw_link from u_dw within w_dwapplylink
event ue_insertpossiblelinks ( )
event ue_filterlinks ( )
event type long ue_checkfiltered ( long al_handle )
integer x = 663
integer y = 944
integer width = 1339
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_linkpropertiesapply"
boolean border = false
string icon = "AppIcon!"
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event ue_insertpossiblelinks();/***************************************************************************************
NAME: 	ue_InsertPossibleLinks

ACCESS:	Public
		
ARGUMENTS: 	()

RETURNS:		None
	
DESCRIPTION:
			Inserts all Possible Details that the Master can link to
			
			If a detail is already linked to a different master, it will not be inserted/viewable

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/24/05
	
***************************************************************************************/


Long		ll_Index
Long		ll_Index2
Long		ll_Index3
Long		ll_NumDetails 
Long		ll_MaxControls
Long		ll_LinkDefCount 
Long		ll_NewRow
Long		ll_LinkId
Integer	li_HasMaster
string	ls_DetailName
String	ls_ObjName  //temp (remove)
u_dw		ldw_CurrentDw
u_dw		ldw_Master

u_dw						ldwa_Details[]
n_cst_LinkageAttrib	lnv_LinkArgs


IF isValid(idw_MasterDw) AND isValid(idw_MasterDw.inv_Linkage) THEN
	//Pass ldwa_Details by ref to get A list of Linked Details
	idw_MasterDw.inv_Linkage.of_GetDetails(ldwa_Details[])
END IF

ll_NumDetails = UpperBound(ldwa_Details[]) 
ll_MaxControls = UpperBound(iw_ParentWindow.Control)  
ll_LinkDefCount = dw_linklist.RowCount()

//Loop through all Controls
FOR ll_Index = 1 TO ll_MaxControls
	IF iw_ParentWindow.Control[ll_Index].TypeOf() = DataWindow! AND iw_ParentWindow.Control[ll_Index].TriggerEvent("ue_HasIds") = 1 THEN
		ldw_CurrentDw = iw_ParentWindow.Control[ll_Index]
		ls_objName = ldw_CurrentDw.Title
		//Iterate Link definitions
		FOR ll_Index2 = 1 TO ll_LinkDefCount
			dw_linklist.SetRow(ll_Index2)
			dw_linklist.ScrollToRow(ll_Index2)
			ls_DetailName = dw_linklist.GetItemString(ll_Index2, "detailname")
			//If the Control object name is equal to a Link definition detail name, Insert row
			IF ls_DetailName = ldw_CurrentDw.of_GetObjName() THEN
				IF isValid(ldw_CurrentDw.inv_Linkage) THEN
					li_HasMaster = ldw_CurrentDw.inv_Linkage.of_getMaster(ldw_Master)
				ELSE
					li_HasMaster = -1 
					SetNull(ldw_Master)
				END IF
				//IF Detail has no Master OR its Master = idw_MasterDw, insert a row
				IF li_HasMaster <> 1 OR ldw_Master = idw_MasterDw THEN
						ll_NewRow = This.InsertRow(0)
						IF ll_NewRow > 0 THEN
							This.SetRow(ll_NewRow)
							This.ScrollToRow(ll_NewRow)
							ll_LinkId = dw_linklist.GetItemNumber(ll_Index2, "linkid")
							This.SetItem(ll_NewRow, "linkid", ll_LinkId)
							This.SetItem(ll_NewRow, "dwtitle", ldw_CurrentDw.Title)
							This.SetItem(ll_NewRow, "dwhandle", Handle(iw_Parentwindow.Control[ll_Index]))
						END IF
						//If the detail is already linked to this master, check the linked checkbox
						FOR ll_Index3 = 1 TO ll_NumDetails
							IF isValid(ldwa_Details[ll_Index3])  AND NOT isNull(ldwa_Details[ll_Index3]) THEN
								IF isValid(ldwa_Details[ll_Index3].inv_Linkage) THEN
									IF Handle(iw_ParentWindow.Control[ll_Index]) = Handle(ldwa_details[ll_Index3]) THEN
										IF ll_LinkId = ldwa_details[ll_Index3].inv_Linkage.of_GetLinkId() THEN
											This.SetItem(ll_NewRow, "linked", 1)
										END IF
									END IF
								END IF
							END IF
						NEXT
				END IF
			END IF
		NEXT
	END IF
NEXT
end event

event ue_filterlinks();/***************************************************************************************
NAME: 	ue_FilterLinks

ACCESS:	Public
		
ARGUMENTS: 	()

RETURNS:		None
	
DESCRIPTION:
			Filter dw_Links based on the linkid

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
	//Set Sort to dwtitle ascending
	This.SetSort("dwtitle A")
	This.Sort()
END IF
end event

event type long ue_checkfiltered(long al_handle);/***************************************************************************************
NAME: 	ue_checkfiltered

ACCESS:	Public
		
ARGUMENTS: 	(long al_handle)

RETURNS:		None
	
DESCRIPTION:
				Checks the filter buffer for any links that already exist for al_handle
				
				Returns the row index of the found link if a link is found
				Return -1 if no link is found for al_handle 
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/24/05
	
***************************************************************************************/




Long		ll_Handle
Long		ll_linked
Long	  	ll_FilterCount
Long		ll_Index


ll_filterCount = This.FilteredCount()
FOR ll_Index = 1 TO ll_FilterCount
	ll_Handle = GetItemNumber(ll_Index, "dwHandle", Filter!, FALSE)
	ll_linked = GetItemNumber(ll_Index, "linked", Filter!, FALSE)
	IF al_handle = ll_Handle AND ll_Linked = 1 THEN
		Return ll_Index
	END IF
NEXT

RETURN -1

end event

event itemchanged;call super::itemchanged;/***************************************************************************************
NAME: 	itemchanged event

ACCESS:	Public
		
ARGUMENTS: 	(long al_handle)

RETURNS:		None
	
DESCRIPTION:
			If the "linked" checkbox is changed,  the filtered buffer must be checked
			to see if there is already a link applied for that detail
			
			(this pervents setting up a link to a detail that is already linked to this master)
			
			If the user wants to replace the old link, then the linked checkbox for the old link 
				in the filtered buffer is unchecked
			If the user does not want to replace the old link, the linked checkbox for the
				current detail in the primary buffer is set to unchchecked. 
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/24/05
	
***************************************************************************************/


Long		ll_Handle
Long		ll_ThisHandle
Long		ll_ChangeRow
Integer	li_Response

u_dw		ldw_CurrentDw

ll_Handle = This.GetItemNumber(row, "dwHandle")
ldw_CurrentDw = Parent.of_GetDwHandle(ll_Handle)

//If linked checkbox has changed 
IF String(dwo.Name) = This.Object.Linked.Name THEN
	ll_ChangeRow = This.Event ue_CheckFiltered(ll_Handle)
	IF ll_ChangeRow <> -1 THEN
		li_Response = MessageBox("Replace detail link?", "This detail is already linked via another link definition.~r~nReplace old link?",Question!,YesNo!,2)
		IF li_Response = 2 THEN
			This.POST SetItem(row, "linked", 0)
		ELSEIF li_Response = 1 THEN
			This.Object.Linked.Filter [ ll_ChangeRow ] = 0
		END IF
	ELSE
		//A link was not found in filter buffer, so do nothing
	END IF
	cb_apply.Enabled = TRUE
END IF





end event

event constructor;call super::constructor;This.of_setinsertable( FALSE)
This.of_setdeleteable( FALSE)

end event

event buttonclicked;call super::buttonclicked;Long		ll_Handle
Boolean	lb_TitleBar
Boolean	lb_Visible
Boolean	lb_BringToTop
Time		lt_TimeBegin
Time		lt_TimeEnd
Long		ll_Difference

n_cst_datetime		lnv_time


IF dwo.Name = "b_show" THEN
	IF ib_ProcessClick = TRUE THEN
		ll_Handle = This.GetItemNumber(row, "dwhandle")
		IF NOT isNull(ll_Handle) THEN
			idw_CurrentDw = Parent.of_GetDwHandle(ll_Handle)
			
			//Store current settings in variables
			ib_TitleBar = idw_CurrentDw.TitleBar
			ib_Visible = idw_CurrentDw.Visible
			ib_BringToTop = idw_CurrentDw.BringToTop
			
			idw_CurrentDw.Visible = True
			idw_CurrentDw.BringToTop = True
			//Stop the Master timer
			IF IsValid(idw_MasterDw.inv_MouseOver) THEN
				idw_MasterDw.inv_MouseOver.of_MouseOverOff()
			END IF
			//Start blinking title bar
			il_Count = 0
			This.Object.b_show.Enabled = FALSE
			ib_ProcessClick = FALSE
			Timer(1)
		END IF
	END IF
END IF
end event

type dw_linkargs from u_dw within w_dwapplylink
event ue_insertargumentrows ( datawindow adw_currentdw,  integer ai_argkey,  string as_style )
event ue_filterarguments ( )
event type integer ue_updatedetailcodetable ( datawindow adw_currentdw )
event type integer ue_updatemastercodetable ( )
event ue_ ( )
integer x = 622
integer y = 556
integer width = 1490
integer height = 296
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_linkargsapply"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

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
	This.SetSort("order A")
	This.Sort()
END IF


end event

event constructor;call super::constructor;This.SetTransObject(SQLCA)

This.of_setinsertable( FALSE)
This.of_setdeleteable( FALSE)
end event

type gb_link from groupbox within w_dwapplylink
integer x = 498
integer y = 508
integer width = 1627
integer height = 364
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Arguments"
end type

type gb_1 from groupbox within w_dwapplylink
integer x = 645
integer y = 884
integer width = 1371
integer height = 352
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

