$PBExportHeader$w_tabproperties.srw
forward
global type w_tabproperties from w_response
end type
type uo_textcolor from u_cst_colors within w_tabproperties
end type
type uo_tabcolor from u_cst_colors within w_tabproperties
end type
type uo_color from u_cst_colors within w_tabproperties
end type
type cb_apply from commandbutton within w_tabproperties
end type
type dw_tabproperties from u_dw within w_tabproperties
end type
end forward

global type w_tabproperties from w_response
integer width = 1280
integer height = 1268
string title = "Tab Properties"
long backcolor = 12632256
boolean ib_disableclosequery = true
uo_textcolor uo_textcolor
uo_tabcolor uo_tabcolor
uo_color uo_color
cb_apply cb_apply
dw_tabproperties dw_tabproperties
end type
global w_tabproperties w_tabproperties

type variables
Integer ci_Checked = 1
Integer ci_UnChecked = 0

u_Tab		itab_CurrentTab
end variables

on w_tabproperties.create
int iCurrent
call super::create
this.uo_textcolor=create uo_textcolor
this.uo_tabcolor=create uo_tabcolor
this.uo_color=create uo_color
this.cb_apply=create cb_apply
this.dw_tabproperties=create dw_tabproperties
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_textcolor
this.Control[iCurrent+2]=this.uo_tabcolor
this.Control[iCurrent+3]=this.uo_color
this.Control[iCurrent+4]=this.cb_apply
this.Control[iCurrent+5]=this.dw_tabproperties
end on

on w_tabproperties.destroy
call super::destroy
destroy(this.uo_textcolor)
destroy(this.uo_tabcolor)
destroy(this.uo_color)
destroy(this.cb_apply)
destroy(this.dw_tabproperties)
end on

type cb_help from w_response`cb_help within w_tabproperties
boolean visible = false
end type

type uo_textcolor from u_cst_colors within w_tabproperties
boolean visible = false
integer x = 736
integer y = 628
integer taborder = 40
end type

on uo_textcolor.destroy
call u_cst_colors::destroy
end on

event ue_colorchanged;call super::ue_colorchanged;dw_TabProperties.Modify("textcolor.Background.Color = '" + String(al_color) + "'")
dw_TabProperties.SetItemStatus( 1, "textcolor", Primary!, DataModified!)
This.Visible = FALSE
end event

type uo_tabcolor from u_cst_colors within w_tabproperties
boolean visible = false
integer x = 736
integer y = 532
integer taborder = 30
end type

event ue_colorchanged;call super::ue_colorchanged;dw_TabProperties.Modify("tabcolor.Background.Color = '" + String(al_color) + "'")
dw_TabProperties.SetItemStatus( 1, "tabcolor", Primary!, DataModified!)
This.Visible = FALSE
end event

on uo_tabcolor.destroy
call u_cst_colors::destroy
end on

type uo_color from u_cst_colors within w_tabproperties
boolean visible = false
integer x = 736
integer y = 140
integer height = 348
integer taborder = 30
end type

on uo_color.destroy
call u_cst_colors::destroy
end on

event ue_colorchanged;call super::ue_colorchanged;dw_TabProperties.Modify("backcolor.Background.Color = '" + String(al_color) + "'")
dw_TabProperties.SetItemStatus( 1, "backcolor", Primary!, DataModified!)
This.Visible = FALSE
end event

type cb_apply from commandbutton within w_tabproperties
integer x = 823
integer y = 1040
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Apply"
end type

event clicked;/***************************************************************************************
NAME: 			clicked()

ACCESS:			public
		
ARGUMENTS: 		(none)

RETURNS:			long
	
DESCRIPTION:  Checks Modified count of Properties Tab 
					Prompts for applying changes if anything is modified
					
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/17
	

***************************************************************************************/





Integer	li_Continue
Boolean	lb_TabModified = FALSE
String	ls_MessageText

//Check if changes have been made to dw_tabProperties
IF dw_tabProperties.AcceptText() = 1 THEN
	IF dw_tabProperties.ModifiedCount() > 0 THEN
		lb_TabModified = TRUE
	ELSE
		lb_tabModified = FALSE
	END IF
	
END IF

IF lb_TabModified THEN
	dw_tabProperties.Event ue_applyProperties()
	dw_tabProperties.ResetUpdate()
END IF
end event

type dw_tabproperties from u_dw within w_tabproperties
event ue_applyproperties ( )
integer x = 37
integer y = 4
integer width = 1189
integer height = 1016
integer taborder = 10
string dataobject = "d_tabproperties"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event ue_applyproperties();/***************************************************************************************
NAME: 			ue_ApplyProperties()

ACCESS:			public
		
ARGUMENTS: 		(none)

RETURNS:			none
	
DESCRIPTION:  Applies all Tab Properties to the current object (itab_CurrentTab)

				
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/17/05
	

***************************************************************************************/

Integer	li_TabPosition
Integer	li_MultiLine
Integer	li_BoldSelected
Long		ll_BackgroundColor
Long		ll_TabColor
Long		ll_TextColor
Long		ll_width
Long		ll_height
Long		ll_Max
Long		ll_Index


IF isValid( itab_CurrentTab) THEN
	
	ll_width = This.GetItemNumber(1, "width")
	IF not ISNULL(ll_width) THEN
		itab_CurrentTab.width = ll_width
	END IF
	
	ll_height = This.GetItemNumber(1, "height")
	IF not IsNull(ll_height) THEN
		itab_CurrentTab.height = ll_height
	END IF	

	
	li_TabPosition = This.GetItemNumber(1,"tabposition")
	IF li_TabPosition = 1 THEN
		itab_CurrentTab.TabPosition = TabsOnBottom! 
		itab_CurrentTab.PerpendicularText = FALSE
	ELSEIF li_TabPosition = 2 THEN
		itab_CurrentTab.TabPosition= TabsOnBottomAndTop! 
		itab_CurrentTab.PerpendicularText = FALSE
	ELSEIF li_TabPosition = 3 THEN
		itab_CurrentTab.TabPosition = TabsOnLeft! 
		itab_CurrentTab.PerpendicularText = TRUE
	ELSEIF li_TabPosition = 4 THEN
		itab_CurrentTab.TabPosition = TabsOnLeftAndRight! 
		itab_CurrentTab.PerpendicularText = TRUE
	ELSEIF li_TabPosition = 5 THEN
		itab_CurrentTab.TabPosition = TabsOnRight!
		itab_CurrentTab.PerpendicularText = TRUE
	ELSEIF li_TabPosition = 6 THEN
		itab_CurrentTab.TabPosition = TabsOnRightAndLeft!
		itab_CurrentTab.PerpendicularText = TRUE
	ELSEIF li_TabPosition = 7 THEN
		itab_CurrentTab.TabPosition = TabsOnTop!
		itab_CurrentTab.PerpendicularText = FALSE
	ELSEIF li_TabPosition = 8 THEN
		itab_CurrentTab.TabPosition = TabsOnTopAndBottom!
		itab_CurrentTab.PerpendicularText = FALSE
	END IF
	
	ll_BackgroundColor = Long(This.Describe("backcolor.Background.Color"))
	itab_CurrentTab.BackColor = ll_BackGroundColor
	//Loop Through Tab Controls and Set Text Color of any TabPages
	ll_TextColor = Long(This.Describe("textcolor.Background.Color"))
	ll_TabColor = Long(This.Describe("tabcolor.Background.Color"))
	IF ll_tabColor <> ll_textColor THEN
		//Loop Through Tab Controls and Set Tab Color of any TabPages
		ll_Max = UpperBound(itab_CurrentTab.Control)
		ll_TabColor = Long(This.Describe("tabcolor.Background.Color"))
		FOR ll_Index = 1 TO ll_Max
			IF isValid(itab_CurrentTab.Control[ll_Index]) THEN
				itab_CurrentTab.Control[ll_Index].TabBackColor = ll_TabColor
				itab_CurrentTab.Control[ll_Index].BackColor = ll_TabColor
			END IF
		NEXT
		
		itab_CurrentTab.of_SetTabPageBackColor( ll_TabColor )
	
		
		FOR ll_Index = 1 TO ll_Max
			IF isValid(itab_CurrentTab.Control[ll_Index]) THEN
				itab_CurrentTab.Control[ll_Index].TabTextColor = ll_TextColor
			END IF
		NEXT
	
		itab_CurrentTab.of_SetTabPageTextColor( ll_TextColor ) 
	END IF

	li_BoldSelected = This.GetItemNumber(1, "boldselected")
	IF li_BoldSelected = 1 THEN		
		itab_CurrentTab.BoldSelectedText = TRUE
	ELSE
		itab_CurrentTab.BoldSelectedText = FALSE
	END IF		
	
	li_MultiLine = This.GetItemNumber(1, "multiline")
	IF li_MultiLine = 1 THEN		
		itab_CurrentTab.MultiLine = TRUE
	ELSE
		itab_CurrentTab.MultiLine = FALSE
	END IF	
	
END IF
end event

event constructor;call super::constructor;/***************************************************************************************
NAME: 			contructor

ACCESS:			public
		
ARGUMENTS: 		(none)

RETURNS:			long
	
DESCRIPTION:  Inserts one row and updates all the properties values with properties	
					from itab_CurrentTab
					
				  Also resets update flags
					
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/17
	

***************************************************************************************/
Boolean	lb_BoldSelected
Boolean	lb_MultiLine

String	ls_BackColor
String	ls_Tabcolor
String	ls_TextColor

Long		ll_ControlLength

n_cst_privileges	lnv_priv 


IF isValid(Message.PowerObjectParm) THEN
	itab_CurrentTab = Message.PowerObjectParm
END IF

This.InsertRow(1)

This.of_Setdeleteable( FALSE )
This.of_SetInsertable( FALSE )


This.SetItem(1, "definition", itab_CurrentTab.of_GetObjName())
This.SetItem(1,"width", itab_CurrentTab.Width) 
This.SetItem(1,"height", itab_CurrentTab.Height) 

CHOOSE CASE itab_CurrentTab.TabPosition
CASE tabsonbottom!
	This.SetItem(1,"tabposition", 1)
	itab_CurrentTab.PerpendicularText = FALSE
CASE tabsonbottomandtop!
	This.SetItem(1,"tabposition", 2)
	itab_CurrentTab.PerpendicularText = FALSE
CASE tabsonleft!
	This.SetItem(1,"tabposition", 3)
	itab_CurrentTab.PerpendicularText = TRUE
CASE tabsonleftandright!
	This.SetItem(1,"tabposition", 4)
	itab_CurrentTab.PerpendicularText = TRUE
CASE tabsonright!
	This.SetItem(1,"tabposition", 5)
	itab_CurrentTab.PerpendicularText = TRUE
CASE tabsonrightandleft!
	This.SetItem(1,"tabposition", 6)
	itab_CurrentTab.PerpendicularText = TRUE
CASE tabsontop!
	This.SetItem(1,"tabposition", 7)
	itab_CurrentTab.PerpendicularText = FALSE
CASE tabsontopandbottom!
	This.SetItem(1,"tabposition", 8)
	itab_CurrentTab.PerpendicularText = FALSE
END CHOOSE

ls_BackColor = String(itab_CurrentTab.BackColor)
This.Modify("backcolor.Background.Color='" + ls_BackColor  + "'")

ll_ControlLength = UpperBound(itab_CurrentTab.Control)
IF ll_ControlLength > 0 THEN
	IF isValid(itab_CurrentTab.Control[1]) THEN
		ls_TabColor = String(itab_CurrentTab.Control[1].TabBackColor)
		ls_TextColor = String(itab_CurrentTab.Control[1].TabTextColor)
	ELSE
		ls_TabColor = String(RGB(204, 204, 204))
		ls_TextColor = String(0)
	END IF
	
	This.Modify("tabcolor.Background.Color='" + ls_TabColor  + "'")
	This.Modify("textcolor.Background.Color='" + ls_TextColor  + "'")
	
ELSE //Hide Tabpage properties
	This.Object.t_textcolor.Visible = FALSE
	This.Object.t_tabcolor.Visible = FALSE
	This.Object.textcolor.Visible = FALSE
	This.Object.tabcolor.Visible = FALSE
	This.Object.b_TextColor.Visible = FALSE
	This.Object.b_TabColor.Visible = FALSE
END IF


lb_BoldSelected = itab_CurrentTab.BoldSelectedText	
IF lb_BoldSelected = TRUE THEN
	This.SetItem(1,"boldselected",ci_Checked) 
ELSE 
	This.SetItem(1,"boldselected",ci_UnChecked)
END IF

lb_MultiLine = itab_CurrentTab.MultiLine
IF lb_MultiLine = TRUE THEN
	This.SetItem(1,"multiline",ci_Checked) 
ELSE 
	This.SetItem(1,"multiline",ci_UnChecked)
END IF

//Reset update flags to indicate that nothing needs to be updated
This.ResetUpdate()


end event

event buttonclicked;call super::buttonclicked;//Set All Color Controls to InVisible
uo_Color.Visible = FALSE
uo_TabColor.Visible = FALSE
uo_TextColor.Visible = FALSE

//Set Color Selector Visible Depending on button clicked 

IF dwo.Name = "b_color" THEN
	uo_Color.Visible = TRUE
END IF


IF dwo.Name = "b_tabcolor" THEN
	uo_TabColor.Visible = TRUE
END IF

IF dwo.Name = "b_textcolor" THEN
	uo_TextColor.Visible = TRUE
END IF
end event

