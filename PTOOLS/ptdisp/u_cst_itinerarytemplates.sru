$PBExportHeader$u_cst_itinerarytemplates.sru
forward
global type u_cst_itinerarytemplates from u_base
end type
type cb_delete from commandbutton within u_cst_itinerarytemplates
end type
type cb_new from commandbutton within u_cst_itinerarytemplates
end type
type cb_removeevent from commandbutton within u_cst_itinerarytemplates
end type
type cb_addevent from commandbutton within u_cst_itinerarytemplates
end type
type dw_itintemplateevents from u_dw within u_cst_itinerarytemplates
end type
type dw_itintemplates from u_dw within u_cst_itinerarytemplates
end type
end forward

global type u_cst_itinerarytemplates from u_base
integer width = 1591
integer height = 1248
long backcolor = 12632256
event ue_newtemplate ( )
event ue_removetemplate ( long al_row )
event type integer ue_addevent ( long al_templateid )
event ue_addeventrequest ( )
event ue_removeevent ( long al_row )
event ue_pendingupdate ( )
cb_delete cb_delete
cb_new cb_new
cb_removeevent cb_removeevent
cb_addevent cb_addevent
dw_itintemplateevents dw_itintemplateevents
dw_itintemplates dw_itintemplates
end type
global u_cst_itinerarytemplates u_cst_itinerarytemplates

forward prototypes
public function integer of_retrieve ()
public function boolean of_templateselected (ref long al_id)
public function integer of_validate ()
public function string of_gettypecodetableforitinerary ()
end prototypes

event ue_newtemplate();Long		ll_NewId
Long		ll_NewRow
String	cs_NewTemplate = "NEW TEMPLATE"

dw_itintemplates.SetFocus()

ll_NewRow =  dw_itintemplates.InsertRow(0) 
IF ll_NewRow > 0 THEN
	dw_itintemplates.ScrollNextPage()
	dw_itintemplates.ScrollToRow(ll_NewRow)
	//Allow editing and Setfocus
	dw_itintemplates.Modify("name.TabSequence = 10")
	dw_itintemplates.SetColumn("name")
	dw_itintemplates.SetRow(ll_NewRow)
	
	//Initialize id
	gnv_App.of_GetNextId("itintemplates", ll_NewId, True)
	dw_itintemplates.SetItem(ll_NewRow, "id", ll_NewId)
	dw_itintemplates.SetItem(ll_Newrow, "name", cs_NewTemplate )
	dw_itintemplates.SelectText( 1, Len(cs_NewTemplate))

	This.Event ue_PendingUpdate()
END IF
end event

event ue_removetemplate(long al_row);Long	ll_Rowcount
Long	i

IF al_Row > 0 THEN
	
	//Delete event rows
	ll_Rowcount = dw_itintemplateevents.RowCount()
	FOR i = ll_RowCount TO 1 STEP - 1
		dw_itintemplateevents.DeleteRow(i)
	NEXT
	
	//Delete Template
	dw_itintemplates.DeleteRow(al_Row)

	
	dw_itintemplates.Modify("name.TabSequence = 0")
	dw_itintemplates.SelectRow(dw_itintemplates.GetRow(), True)
	
	This.Event ue_PendingUpdate()
	
END IF
end event

event type integer ue_addevent(long al_templateid);Long	ll_NewRow

IF al_TemplateId > 0 THEN
	
	ll_NewRow = dw_itintemplateevents.InsertRow(0)
	IF ll_NewRow > 0 THEN
		dw_itintemplateevents.SetFocus()
		dw_itintemplateevents.SetRow(ll_NewRow)
		dw_itintemplateevents.SetItem(ll_NewRow, "id", al_TemplateId)
		dw_itintemplateevents.SetItem(ll_NewRow, "event_order", ll_NewRow)//trumped by pfc_preupdate
		dw_itintemplateevents.Setcolumn("event_type")
		dw_itintemplateevents.ScrollNextPage()
		dw_itintemplateevents.ScrollToRow(ll_NewRow)
	END IF

END IF

Return ll_NewRow






end event

event ue_addeventrequest();Long	ll_TemplateId
IF This.of_TemplateSelected(ll_TemplateId) THEN
	This.Event ue_AddEvent(ll_TemplateId)
ELSE
	MessageBox("Add Event", "Please create/select a template before adding an event.")
END IF
end event

event ue_removeevent(long al_row);
IF al_Row > 0 THEN
	dw_itintemplateevents.DeleteRow(al_Row)
	This.Event ue_PendingUpdate()
END IF
end event

public function integer of_retrieve ();Integer	li_Return = 1

/*dw_itintemplates.SetTransObject(SQLCA)
IF dw_itintemplates.Retrieve() = -1 THEN
	li_Return = -1
ELSE
	Commit;
END IF

IF li_Return = 1 THEN
	dw_itintemplateevents.SetTransObject(SQLCA)
	IF dw_itintemplateevents.Retrieve() = -1 THEN
		li_Return = -1
	ELSE
		Commit;
	END IF
END IF*/
IF isValid(dw_itintemplates.inv_Linkage) THEN
	IF dw_itintemplates.inv_Linkage.of_Retrieve() = -1 THEN
		li_Return = -1
	END IF
END IF

Return li_Return
end function

public function boolean of_templateselected (ref long al_id);Boolean	lb_Return
Long	ll_CurrentTemplateId
Long	ll_CurrentTemplateRow

ll_CurrentTemplateRow = dw_itintemplates.GetRow()


IF ll_CurrentTemplateRow > 0 THEN
	ll_CurrentTemplateId = dw_itintemplates.GetItemNumber(ll_CurrentTemplateRow, "id")
END IF

IF ll_CurrentTemplateId > 0 THEN
	lb_Return = TRUE
	al_id = ll_CurrentTemplateId
END IF

Return lb_Return
end function

public function integer of_validate ();Integer	li_Return = 1
Long		ll_FindRow
Long	 	ll_Id
Long	 	ll_eventSite
Long	 	ll_eventOrder
Long	 	ll_RowCount, i
String 	ls_eventType
String	ls_ErrMsg
String	ls_Column
String	ls_FindString

//validate current data
ll_RowCount = dw_itintemplateevents.RowCount()
FOR i = 1 TO ll_RowCount
	ll_Id = dw_itintemplateevents.GetItemNumber(i, "id")
	ll_EventSite = dw_itintemplateevents.GetItemNumber(i, "event_site")
	ll_EventOrder = dw_itintemplateevents.GetItemNumber(i, "event_order")
	ls_EventType = dw_itintemplateevents.GetItemString(i, "event_type")
	
	IF IsNull(ll_Id) OR ll_Id < 1 THEN //should not happen
		ls_ErrMsg = "Template id is required"
		li_Return = -1
	END IF
	
	IF IsNull(ll_EventOrder) OR ll_EventOrder < 1 THEN //should not happen
		ls_ErrMsg = "Event order is required"
		li_Return = -1
		EXIT
	END IF
	
	IF IsNull(ls_EventType) OR Len(ls_EventType) < 1 THEN
		ls_ErrMsg = "You must specify an event type for all events"
		li_Return = -1
		ls_Column = "event_type"
		EXIT
	END IF
	
	IF li_Return = -1 THEN
		EXIT
	END IF

	
NEXT

//validate filtered data
IF li_Return = 1 THEN
	ll_RowCount = dw_itintemplateevents.FilteredCount()
	FOR i = 1 TO ll_RowCount
		ll_Id = dw_itintemplateevents.GetItemNumber(i, "id", Filter!, False)
		ll_EventSite = dw_itintemplateevents.GetItemNumber(i, "event_site", Filter!, False)
		ll_EventOrder = dw_itintemplateevents.GetItemNumber(i, "event_order", Filter!, False)
		ls_EventType = dw_itintemplateevents.GetItemString(i, "event_type", Filter!, False)
		
		IF IsNull(ll_Id) OR ll_Id < 1 THEN //should not happen
			ls_ErrMsg = "Template id is required."
			li_Return = -1
		END IF
		
		IF IsNull(ll_EventOrder) OR ll_EventOrder < 1 THEN //should not happen
			ls_ErrMsg = "Event order is required."
			li_Return = -1
		END IF
		
		
		IF IsNull(ls_EventType) OR Len(ls_EventType) < 1 THEN
			ls_ErrMsg = "You must specify an event type for all events."
			ls_Column = "event_type"
			li_Return = -1
		END IF
		
		IF li_Return = -1 THEN
			EXIT
		END IF
	NEXT
END IF


//Display results if invalid
IF li_Return = -1 THEN
	//Select the correct template
	ls_FindString = "id = " + String(ll_Id)
	ll_FindRow = dw_itintemplates.Find(ls_FindString, 1, dw_itintemplates.RowCount())
	IF ll_FindRow > 0 THEN
		dw_itintemplates.SetRow(ll_FindRow)
	END IF
	
	//Select the correct event
	ls_FindString = "id = " + String(ll_Id) + " AND event_order = " + String(ll_EventOrder)
	ll_FindRow = dw_itintemplateevents.Find(ls_FindString, 1, dw_itintemplateevents.RowCount())
	IF ll_FindRow > 0 THEN
		dw_itintemplateevents.SetFocus()
		IF Len(ls_Column) > 0 THEN
			dw_itintemplateevents.SetColumn(ls_Column)
		END IF
		dw_itintemplateevents.SetRow(ll_FindRow)
		dw_itintemplateevents.ScrollToRow(ll_FindRow)
	END IF
	MessageBox("Save Templates", ls_ErrMsg)
END IF



Return li_Return
end function

public function string of_gettypecodetableforitinerary ();//This fn should be ported over to n_cst_events

Constant String	ls_CodeTable = &
	"NEW TRIP~t" + gc_Dispatch.cs_EventType_NewTrip + "/"+&
	"END TRIP~t" + gc_Dispatch.cs_EventType_EndTrip + "/"+&
	"HOOK~t" + gc_Dispatch.cs_EventType_Hook + "/"+&
	"DROP~t" + gc_Dispatch.cs_EventType_Drop + "/"+&
	"MOUNT~t" + gc_Dispatch.cs_EventType_Mount + "/"+&
	"DISMOUNT~t" + gc_Dispatch.cs_EventType_Dismount + "/"+&
	"BOBTAIL~t" + gc_Dispatch.cs_EventType_Bobtail + "/"+&
	"DEADHEAD~t" + gc_Dispatch.cs_EventType_Deadhead + "/"+&
	"REPOSITION~t" + gc_Dispatch.cs_EventType_Reposition + "/"+&
	"MISC~t" + gc_Dispatch.cs_EventType_Misc + "/"+&
	"CHECK CALL~t" + gc_Dispatch.cs_EventType_CheckCall + "/"+&
	"POSN REPT~t" + gc_Dispatch.cs_EventType_PositionReport + "/"+&
	"BREAKDWN~t" + gc_Dispatch.cs_EventType_Breakdown + "/"+&
	"PM SERVICE~t" + gc_Dispatch.cs_EventType_PMService + "/"+&
	"REPAIRS~t" + gc_Dispatch.cs_EventType_Repairs + "/"+&
	"ACCIDENT~t" + gc_Dispatch.cs_EventType_Accident + "/"+&
	"DOT INSPECT~t" + gc_Dispatch.cs_EventType_DOT + "/"+&
	"SCALE~t" + gc_Dispatch.cs_EventType_Scale + "/"+&
	"OFF DUTY~t" + gc_Dispatch.cs_EventType_OffDuty + "/"+&
	"SLEEPER~t" + gc_Dispatch.cs_EventType_Sleeper + "/"
Return 	ls_CodeTable
end function

on u_cst_itinerarytemplates.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
this.cb_new=create cb_new
this.cb_removeevent=create cb_removeevent
this.cb_addevent=create cb_addevent
this.dw_itintemplateevents=create dw_itintemplateevents
this.dw_itintemplates=create dw_itintemplates
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
this.Control[iCurrent+2]=this.cb_new
this.Control[iCurrent+3]=this.cb_removeevent
this.Control[iCurrent+4]=this.cb_addevent
this.Control[iCurrent+5]=this.dw_itintemplateevents
this.Control[iCurrent+6]=this.dw_itintemplates
end on

on u_cst_itinerarytemplates.destroy
call super::destroy
destroy(this.cb_delete)
destroy(this.cb_new)
destroy(this.cb_removeevent)
destroy(this.cb_addevent)
destroy(this.dw_itintemplateevents)
destroy(this.dw_itintemplates)
end on

event constructor;call super::constructor;//Initialize linkage
dw_itintemplates.of_SetLinkage(True)


dw_itintemplateevents.of_SetLinkage(True)


dw_itintemplateevents.inv_Linkage.of_SetMaster(dw_itintemplates)
dw_itintemplateevents.inv_Linkage.of_SetStyle(n_cst_dwsrv_Linkage.FILTER)
dw_itintemplateevents.inv_Linkage.of_Register("id", "id")

//	Updates the datawindows in the linked chain, starting with
// the bottom-level datawindow and going up the chain (deletes).
// The second pass will be top-level datawindow going down the 
//	chain (inserts and Updates)
dw_itintemplates.inv_Linkage.of_SetUpdateStyle(n_cst_dwsrv_Linkage.BOTTOMUP_TOPDOWN)

dw_itintemplates.inv_Linkage.of_SetTransObject(SQLCA)

//Set sorts, linkage service will sort accordingly
dw_itintemplateevents.SetSort("event_order A")
dw_itintemplates.SetSort("name A")

end event

event pfc_validation;call super::pfc_validation;Integer	li_Return

li_Return = AncestorReturnValue

IF This.of_Validate() <> 1 THEN
	li_Return = -1
END IF

Return li_Return


end event

type cb_delete from commandbutton within u_cst_itinerarytemplates
integer x = 1207
integer y = 184
integer width = 338
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Delete"
end type

event clicked;Parent.Event ue_RemoveTemplate(dw_itintemplates.GetRow())
end event

type cb_new from commandbutton within u_cst_itinerarytemplates
integer x = 1207
integer y = 20
integer width = 338
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&New"
end type

event clicked;Parent.Event ue_NewTemplate()
end event

type cb_removeevent from commandbutton within u_cst_itinerarytemplates
integer x = 791
integer y = 1140
integer width = 777
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Remove Event"
end type

event clicked;Parent.Event ue_RemoveEvent(dw_itintemplateevents.GetRow())
end event

type cb_addevent from commandbutton within u_cst_itinerarytemplates
event ue_removeevent ( )
integer x = 23
integer y = 1140
integer width = 768
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Add Event"
end type

event clicked;Parent.Event ue_AddEventRequest()
end event

type dw_itintemplateevents from u_dw within u_cst_itinerarytemplates
integer x = 23
integer y = 552
integer width = 1541
integer height = 584
integer taborder = 40
string dataobject = "d_itintemplateevents"
boolean livescroll = false
end type

event constructor;call super::constructor;n_cst_Events		lnv_Events

This.of_SetInsertable(False)

This.Modify ("event_type.Values = '" + Parent.of_GetTypeCodeTableForItinerary() + "'" )
end event

event itemchanged;call super::itemchanged;Integer	li_Return
Long		ll_EventSite
Long		ll_Newrow
Char		lc_EventType

s_co_Info	lstr_Company

li_Return = AncestorReturnValue

CHOOSE CASE dwo.Name 
	CASE "companies_co_name"
		
		IF gnv_cst_Companies.of_Select(lstr_company, "ANY!", True, data, False, 0, False, False) = 1 THEN
				This.SetItem(row, "event_site", lstr_Company.co_Id )
				This.SetItem(row, "companies_co_name", lstr_Company.co_Name)
				Parent.Event ue_PendingUpdate()
				li_Return = 2 //Reject and replace with new value, allow focus to change
		ELSE
			li_Return = 1 //Reject value, do not allow focus to change
		END IF
		
END CHOOSE

IF li_Return = 0 THEN
	Parent.Event ue_PendingUpdate()
END IF

Return li_Return

end event

event pfc_retrieve;//Overriding ancestor

Integer	li_Return

li_Return =  This.Retrieve()

Commit;

Return li_Return
end event

event getfocus;call super::getfocus;Long	ll_Dummy

IF This.RowCount() = 0 THEN
	IF Parent.of_TemplateSelected(ll_Dummy) THEN
		Parent.Event ue_AddEventRequest()
	END IF
END IF
end event

event rbuttondown;call super::rbuttondown;String	lsa_Parm_labels[]
Any		laa_Parm_Values[]
Long 		ll_index 

ll_index ++
lsa_parm_labels[ ll_index ] = "ADD_ITEM"
laa_parm_values[ ll_index ] = "&Add Event"

ll_index ++
lsa_parm_labels[ ll_index ] = "ADD_ITEM"
laa_parm_values[ ll_index ] = "&Remove Event"

ll_index ++
lsa_parm_labels [ ll_index ] = "XPOS"
laa_parm_values [ ll_index ] = Parent.X + Parent.PointerX ( ) + 10
ll_index ++
lsa_parm_labels [ ll_index ] = "YPOS"
laa_parm_values [ ll_index ] = Parent.Y + Parent.PointerY ( ) + 10


CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
	CASE "ADD EVENT"
		Parent.Event ue_AddEventRequest()
	CASE "REMOVE EVENT"
		Parent.Event ue_RemoveEvent(row)
END CHOOSE
end event

event pfc_preupdate;call super::pfc_preupdate;//Make sure all the event_orders are unique
Long		ll_RowCount
Long		i

ll_RowCount = This.RowCount()

FOR i = 1 TO ll_RowCount
	//Set the order to the row number
	This.SetItem(i, "event_order", i)
NEXT

Return AncestorReturnValue
end event

type dw_itintemplates from u_dw within u_cst_itinerarytemplates
integer x = 37
integer y = 20
integer width = 1129
integer height = 484
integer taborder = 30
string dataobject = "d_itintemplates"
end type

event constructor;call super::constructor;This.of_SetDeleteable( False )
This.of_SetInsertable( False )

This.of_SetRowSelect(True)
This.inv_RowSelect.of_SetRequestor(This)
This.inv_RowSelect.of_SetStyle(0)
end event

event itemchanged;call super::itemchanged;Integer	li_Return

li_Return = AncestorReturnValue

IF dwo.Name = "name" THEN
	IF isNull(data) OR Len(data) < 1 THEN
		//MessageBox("Itinerary Template", "Please specify a template name.")
		li_Return = 1 //Do not allow focus to change
	ELSE
		This.Modify("name.TabSequence = 0")
	END IF
	
END IF

//Notify parent
IF li_Return = 0 THEN
	Parent.Event ue_PendingUpdate()
END IF

Return li_Return
end event

event doubleclicked;call super::doubleclicked;//Allow edit
//This.Modify("name.TabSequence = 10")
//This.SetRow(row)
end event

event losefocus;call super::losefocus;//
This.Modify("name.TabSequence = 0")
end event

event pfc_retrieve;//Overriding ancestor

Integer	li_Return

li_Return =  This.Retrieve()

Commit;

Return li_Return
end event

event rbuttondown;call super::rbuttondown;String	lsa_Parm_labels[]
Any		laa_Parm_Values[]
Long 		ll_index 

ll_index ++
lsa_parm_labels[ ll_index ] = "ADD_ITEM"
laa_parm_values[ ll_index ] = "&New Template"

IF row > 0 THEN
	ll_index ++
	lsa_parm_labels[ ll_index ] = "ADD_ITEM"
	laa_parm_values[ ll_index ] = "Re&name Template"
	
	ll_index ++
	lsa_parm_labels[ ll_index ] = "ADD_ITEM"
	laa_parm_values[ ll_index ] = "&Delete Template"
END IF

ll_index ++
lsa_parm_labels [ ll_index ] = "XPOS"
laa_parm_values [ ll_index ] = Parent.X + Parent.PointerX ( ) + 10
ll_index ++
lsa_parm_labels [ ll_index ] = "YPOS"
laa_parm_values [ ll_index ] = Parent.Y + Parent.PointerY ( ) + 10


CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
	CASE "NEW TEMPLATE"
		Parent.Event ue_NewTemplate()
	CASE "DELETE TEMPLATE"
		Parent.Event ue_RemoveTemplate(row)
	CASE "RENAME TEMPLATE"
		This.SetRedraw(False)
		This.Modify("name.TabSequence = 10")
		This.SetRow(row)
		This.SetRedraw(True)
END CHOOSE
end event

