$PBExportHeader$w_tabselection.srw
forward
global type w_tabselection from w_response
end type
type cb_ok from commandbutton within w_tabselection
end type
type st_info from statictext within w_tabselection
end type
type cb_cancel from commandbutton within w_tabselection
end type
type dw_tabselection from u_dw within w_tabselection
end type
type st_showing from statictext within w_tabselection
end type
end forward

global type w_tabselection from w_response
integer x = 214
integer y = 221
integer width = 1161
integer height = 536
string title = "Tab Selection"
long backcolor = 12632256
boolean ib_isupdateable = false
cb_ok cb_ok
st_info st_info
cb_cancel cb_cancel
dw_tabselection dw_tabselection
st_showing st_showing
end type
global w_tabselection w_tabselection

type variables
Private:
	w_Master			iw_ParentWindow
	PowerObject		ipo_CurrentObj
	
	u_tab		itab_CurrentTab
	
	Boolean	ib_ProcessClick = TRUE
	
	Long		il_Count
	
	TabPosition  	itp_tabposition
	
end variables

forward prototypes
public function integer of_setparent (window aw_parentwindow)
public function integer of_resize ()
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
REVISION HISTORY : Maury 10/17/05
	
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

public function integer of_resize ();String	ls_DetailHeight
String	ls_HeaderHeight
Long		ll_NumRows
Long		ll_DwHeight
Long		ll_ButtonY
Long		ll_WinHeight

This.SetRedraw(FALSE)
ls_DetailHeight = dw_tabselection.Describe("DataWindow.Detail.Height")
ls_HeaderHeight = dw_tabselection.Describe("DataWindow.Header.Height")

ll_NumRows = dw_tabselection.RowCount()

ll_DwHeight = (ll_Numrows * Long(ls_DetailHeight) + Long(ls_HeaderHeight)) + 10
dw_tabselection.Height = ll_DwHeight

ll_ButtonY = dw_tabselection.Height + 100
cb_cancel.Y = ll_ButtonY
cb_OK.Y = ll_ButtonY

ll_WinHeight = ll_DwHeight + 300
This.Height = ll_WinHeight

//Resize everything if it exceeds the height of its parent
IF This.Height > This.ParentWindow( ).Height THEN
	This.Height = This.ParentWindow( ).Height
	dw_tabselection.Height = This.Height - 300
	ll_ButtonY = dw_tabselection.Height + 100
	cb_cancel.Y = ll_ButtonY
	cb_OK.Y = ll_ButtonY
END IF


This.SetRedraw(TRUE)

return 1
end function

on w_tabselection.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.st_info=create st_info
this.cb_cancel=create cb_cancel
this.dw_tabselection=create dw_tabselection
this.st_showing=create st_showing
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.st_info
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.dw_tabselection
this.Control[iCurrent+5]=this.st_showing
end on

on w_tabselection.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.st_info)
destroy(this.cb_cancel)
destroy(this.dw_tabselection)
destroy(this.st_showing)
end on

event closequery;//Overriding Ancestor
Close(w_TabSelection)
end event

event open;call super::open;n_cst_msg	lnv_Msg
s_Parm		lstr_Parm
PowerObject lpo_Object
w_master		lw_Parent

IF isValid(Message.PowerObjectParm) THEN
	
	lnv_Msg = Message.PowerObjectParm 
	
	
	IF lnv_Msg.of_Get_parm("CURRENTOBJ", lstr_Parm ) > 0 THEN
		lpo_Object = lstr_Parm.ia_value
		IF lpo_Object.triggerEvent("ue_hasIds") = 1 THEN
			ipo_CurrentObj = lpo_Object
		END IF
	END IF
	
	IF lnv_Msg.of_Get_Parm("PARENTWINDOW", lstr_Parm) > 0 THEN
		lw_Parent = lstr_Parm.ia_Value
		of_SetParent(lw_Parent)
	END IF
	
	
	dw_tabselection.EVENT ue_InsertTabs()
	
	// Center window
	This.of_SetBase(TRUE) 
	This.inv_Base.Of_Center()
	
	This.of_Resize()
END IF



end event

event timer;call super::timer;
IF itab_CurrentTab.TabPosition <> TabsOnLeft! THEN
	itab_CurrentTab.TabPosition = TabsOnLeft!
ELSE
	itab_CurrentTab.TabPosition = TabsOnRight!
END IF

//Stop timer after 5 intervals
IF il_Count >= 5 THEN
	Timer(0)
	//Restore old values
	itab_CurrentTab.TabPosition = itp_TabPosition
	ib_ProcessClick = TRUE
	
	dw_tabselection.Object.b_show.Enabled = TRUE
	cb_ok.Enabled = TRUE
	cb_cancel.Enabled = TRUE
	This.enabled = TRUE
	st_showing.Visible = FALSE

END IF

il_Count ++
end event

type cb_help from w_response`cb_help within w_tabselection
boolean visible = false
end type

type cb_ok from commandbutton within w_tabselection
integer x = 603
integer y = 340
integer width = 233
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;Long		ll_Row

ll_Row = Parent.dw_tabselection.GetRow()

IF ll_row > 0 THEN
	dw_tabselection.Event ue_SetTab(ll_row)
	CLOSE(w_tabSelection)
END IF
end event

type st_info from statictext within w_tabselection
boolean visible = false
integer x = 46
integer y = 52
integer width = 800
integer height = 136
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "A tab must be created to set an object as a tab page!"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_tabselection
integer x = 855
integer y = 340
integer width = 233
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;Close(w_tabselection)
end event

type dw_tabselection from u_dw within w_tabselection
event ue_inserttabs ( )
event type integer ue_settab ( long al_row )
integer x = 37
integer y = 32
integer width = 1051
integer height = 272
integer taborder = 10
string dataobject = "d_tabcontrols"
borderstyle borderstyle = stylebox!
end type

event ue_inserttabs();Long		ll_MaxControls
Long		ll_Index
Long		ll_Row
String	ls_Name
String	ls_Description
u_tab		ltab_CurrentTab

ll_MaxControls = UpperBound(iw_ParentWindow.Control)  

//Loop through all Controls
FOR ll_Index = 1 TO ll_MaxControls
	IF iw_ParentWindow.Control[ll_Index].TriggerEvent("ue_isTab") = 1 AND iw_ParentWindow.Control[ll_Index].TriggerEvent("ue_HasIds") = 1 THEN
		ltab_CurrentTab = iw_ParentWindow.Control[ll_Index]
		ll_Row = This.InsertRow(0)
		ls_Name = ltab_CurrentTab.of_GetObjName()
		//ls_Description = ltab_CurrentTab.of_GetObjDescription()
		This.SetItem(ll_Row, "name", ls_Name)
		This.SetItem(ll_Row, "description", ls_Description)
		This.SetItem(ll_Row, "handle", Handle(ltab_CurrentTab))
	END IF
NEXT

//Hide if there are no Rows
IF This.RowCount() < 1 THEN
	THIS.Visible = FALSE
	Parent.cb_ok.Visible = FALSE
	Parent.st_Info.Visible = TRUE
END IF
end event

event type integer ue_settab(long al_row);Integer 		li_Return = -1
Long	 		ll_Index
Long			ll_MaxControls
Long			ll_SelectedHandle
u_tab			ltab_CurrentTab

ll_MaxControls = UpperBound(iw_ParentWindow.Control)

ll_SelectedHandle = This.GetItemNumber(al_row, "handle")


FOR ll_Index = 1 TO ll_MaxControls
	IF iw_ParentWindow.Control[ll_Index].TypeOf() = Tab! AND iw_ParentWindow.Control[ll_Index].TriggerEvent("ue_HasIds") = 1 THEN
		ltab_CurrentTab = iw_ParentWindow.Control[ll_Index]
		//If the current object in the control matches the handle, set the dw to that tab
		IF Handle(ltab_CurrentTab)  = ll_SelectedHandle THEN
			ltab_CurrentTab.Event ue_NewTab(ipo_CurrentObj)
			li_Return = 1
			EXIT
		END IF
	END IF
NEXT


Return li_Return
end event

event constructor;call super::constructor;This.of_SetRowSelect(TRUE)
This.inv_RowSelect.of_SetRequestor(THIS)
This.inv_RowSelect.of_SetStyle(0)

This.of_setinsertable( FALSE)
This.of_setdeleteable( FALSE)

end event

event rowfocuschanged;call super::rowfocuschanged;This.ScrollToRow(CurrentRow)
This.SetRow(CurrentRow)
end event

event doubleclicked;call super::doubleclicked;IF row > 0 THEN
	This.Event ue_SetTab(row)
	CLOSE(w_tabSelection)
END IF
end event

event buttonclicked;call super::buttonclicked;Long		ll_Handle
Long		ll_Index
Long		ll_MaxControls
u_tab		ltab_CurrentTab

n_cst_datetime		lnv_time


IF dwo.Name = "b_show" THEN
	IF ib_ProcessClick = TRUE THEN
		ll_Handle = This.GetItemNumber(row, "handle")

		IF NOT isNull(ll_Handle) THEN
			ll_MaxControls = UpperBound(iw_ParentWindow.Control)
			//Find the Tab on the control that matches the handle
			FOR ll_Index = 1 TO ll_MaxControls
				IF iw_ParentWindow.Control[ll_Index].TriggerEvent("ue_isTab") = 1 AND iw_ParentWindow.Control[ll_Index].TriggerEvent("ue_HasIds") = 1 THEN
					ltab_CurrentTab = iw_ParentWindow.Control[ll_Index]
					//If the current object in the control matches the handle, exit the loop
					IF Handle(ltab_CurrentTab)  = ll_Handle THEN
						//Found the correct tab
						itab_CurrentTab = ltab_CurrentTab
						EXIT
					END IF
				END IF
			NEXT
			
			IF NOT isNull(itab_CurrentTab) THEN
				//Store current tab position
				itp_TabPosition = ltab_CurrentTab.TabPosition
				
				itab_CurrentTab.Visible = True
				
				//Start toggleing the tab position
				il_Count = 0
				This.Object.b_show.Enabled = FALSE
				cb_ok.Enabled = FALSE
				cb_cancel.Enabled = FALSE
				This.Enabled = FALSE
				st_showing.Visible = TRUE
				ib_ProcessClick = FALSE
				Timer(1)
			END IF
		END IF
	END IF
END IF
end event

type st_showing from statictext within w_tabselection
boolean visible = false
integer x = 37
integer y = 316
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Showing..."
boolean focusrectangle = false
end type

