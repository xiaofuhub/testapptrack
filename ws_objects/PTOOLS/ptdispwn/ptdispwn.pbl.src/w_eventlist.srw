$PBExportHeader$w_eventlist.srw
forward
global type w_eventlist from w_popup
end type
type cb_1 from commandbutton within w_eventlist
end type
type rb_standardevents from radiobutton within w_eventlist
end type
type rb_yardsandpools from radiobutton within w_eventlist
end type
type lb_yardmoves from listbox within w_eventlist
end type
type lb_events from listbox within w_eventlist
end type
type st_othersite from statictext within w_eventlist
end type
type sle_newsite from u_sle within w_eventlist
end type
type st_multipleevents from statictext within w_eventlist
end type
type cb_splitfront from commandbutton within w_eventlist
end type
type cb_splitback from commandbutton within w_eventlist
end type
type cb_splitboth from commandbutton within w_eventlist
end type
type uo_multipleevents from u_cst_multievent within w_eventlist
end type
end forward

global type w_eventlist from w_popup
int X=1097
int Y=740
int Width=1294
int Height=1020
boolean MaxBox=false
boolean Resizable=false
cb_1 cb_1
rb_standardevents rb_standardevents
rb_yardsandpools rb_yardsandpools
lb_yardmoves lb_yardmoves
lb_events lb_events
st_othersite st_othersite
sle_newsite sle_newsite
st_multipleevents st_multipleevents
cb_splitfront cb_splitfront
cb_splitback cb_splitback
cb_splitboth cb_splitboth
uo_multipleevents uo_multipleevents
end type
global w_eventlist w_eventlist

forward prototypes
private function integer wf_yardschecked ()
private function integer wf_eventschecked ()
private function string wf_getsite ()
end prototypes

private function integer wf_yardschecked ();uo_multipleevents.Visible = FALSE
lb_events.Visible         = FALSE
st_multipleevents.Visible = FALSE

st_othersite.Visible  = TRUE
lb_yardmoves.Visible  = TRUE
sle_newsite.Visible   = TRUE
cb_SplitFront.Visible = TRUE
cb_SplitBack.Visible  = TRUE
cb_splitboth.Visible  = TRUE


RETURN 1
end function

private function integer wf_eventschecked ();uo_multipleevents.Visible = TRUE
lb_events.Visible = TRUE
st_multipleevents.Visible = TRUE
st_othersite.Visible = FALSE
lb_yardmoves.Visible = FALSE
sle_newsite.Visible = FALSE
cb_SplitFront.Visible = FALSE
cb_SplitBack.Visible = FALSE
cb_splitboth.Visible = FALSE


RETURN 1

end function

private function string wf_getsite ();string	ls_Site 
int		i

ls_Site = ""
IF Len ( sle_NewSite.Text ) > 0 THEN
	ls_Site = Upper ( sle_NewSite.Text ) 
ELSE
	ls_Site = lb_yardmoves.SelectedItem ( )
END IF
	
	

RETURN ls_Site
end function

on w_eventlist.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.rb_standardevents=create rb_standardevents
this.rb_yardsandpools=create rb_yardsandpools
this.lb_yardmoves=create lb_yardmoves
this.lb_events=create lb_events
this.st_othersite=create st_othersite
this.sle_newsite=create sle_newsite
this.st_multipleevents=create st_multipleevents
this.cb_splitfront=create cb_splitfront
this.cb_splitback=create cb_splitback
this.cb_splitboth=create cb_splitboth
this.uo_multipleevents=create uo_multipleevents
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.rb_standardevents
this.Control[iCurrent+3]=this.rb_yardsandpools
this.Control[iCurrent+4]=this.lb_yardmoves
this.Control[iCurrent+5]=this.lb_events
this.Control[iCurrent+6]=this.st_othersite
this.Control[iCurrent+7]=this.sle_newsite
this.Control[iCurrent+8]=this.st_multipleevents
this.Control[iCurrent+9]=this.cb_splitfront
this.Control[iCurrent+10]=this.cb_splitback
this.Control[iCurrent+11]=this.cb_splitboth
this.Control[iCurrent+12]=this.uo_multipleevents
end on

on w_eventlist.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.rb_standardevents)
destroy(this.rb_yardsandpools)
destroy(this.lb_yardmoves)
destroy(this.lb_events)
destroy(this.st_othersite)
destroy(this.sle_newsite)
destroy(this.st_multipleevents)
destroy(this.cb_splitfront)
destroy(this.cb_splitback)
destroy(this.cb_splitboth)
destroy(this.uo_multipleevents)
end on

event open;call super::open;THIS.of_SetResize ( TRUE )
inv_Resize.of_Register ( lb_events , "ScaleToRight&Bottom" )
inv_Resize.of_Register ( lb_yardmoves , "ScaleToRight&Bottom" )
inv_Resize.of_Register ( cb_1 , "FixedToBottom&ScaleToRight" )
inv_Resize.of_Register ( sle_newsite , "FixedToBottom&ScaleToRight" )
inv_Resize.of_Register ( st_othersite , "FixedToBottom" )

THIS.wf_EventsChecked ( )

end event

type cb_1 from commandbutton within w_eventlist
int X=142
int Y=808
int Width=379
int Height=80
int TabOrder=80
boolean BringToTop=true
string Text="Close"
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CLOSE ( PARENT )
end event

type rb_standardevents from radiobutton within w_eventlist
int X=32
int Y=20
int Width=558
int Height=76
string Text="&Standard Events"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF THIS.Checked THEN
	PARENT.wf_EventsChecked ( )
//	lb_events.Visible = TRUE 
//ELSE
//	lb_events.Visible = FALSE 
END IF
end event

type rb_yardsandpools from radiobutton within w_eventlist
int X=32
int Y=96
int Width=562
int Height=60
string Text="&Yards and Pools"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF THIS.Checked THEN
	PARENT.wf_YardsChecked ( )
//	lb_events.Visible = FALSE 
//ELSE
//	lb_events.Visible = TRUE 
END IF 
end event

type lb_yardmoves from listbox within w_eventlist
event ue_lbuttondown pbm_lbuttondown
int X=23
int Y=188
int Width=594
int Height=428
int TabOrder=10
string DragIcon="grab.ico"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_lbuttondown;this.Drag ( Begin!  )
sle_newsite.Text = ""
end event

event constructor;any	la_Value
n_cst_Settings		lnv_Settings
n_cst_String		lnv_String
String				lsa_Values[]
Long					ll_TypeCount
Long					ll_Index

IF lnv_Settings.of_GEtSetting ( 85 , la_Value ) = 1 THEN
	ll_TypeCount = lnv_String.of_ParseToArray ( String ( la_Value ) , "," , lsa_Values )
END IF
	
This.SetRedraw ( FALSE )

FOR ll_Index = 1 TO ll_TypeCount	
	This.AddItem (  lsa_Values [ ll_Index ] ) 
NEXT
This.SetRedraw ( TRUE )

end event

type lb_events from listbox within w_eventlist
event ue_lbuttondown pbm_lbuttondown
int X=23
int Y=188
int Width=594
int Height=492
int TabOrder=60
string DragIcon="grab.ico"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean Sorted=false
boolean ExtendedSelect=true
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_lbuttondown;this.Drag ( Begin!  )

end event

event constructor;
n_cst_Events	lnv_Events


This.AddItem ( lnv_Events.of_GetTypeDisplayValue ( gc_Dispatch.cs_EventType_Pickup ) )
This.AddItem ( lnv_Events.of_GetTypeDisplayValue ( gc_Dispatch.cs_EventType_Deliver ) )
This.AddItem ( lnv_Events.of_GetTypeDisplayValue ( gc_Dispatch.cs_EventType_Hook ) )
This.AddItem ( lnv_Events.of_GetTypeDisplayValue ( gc_Dispatch.cs_EventType_DROP ) )
This.AddItem ( lnv_Events.of_GetTypeDisplayValue ( gc_Dispatch.cs_EventType_Mount ) )
This.AddItem ( lnv_Events.of_GetTypeDisplayValue ( gc_Dispatch.cs_EventType_Dismount ) )
end event

event doubleclicked;String	ls_Event

ls_Event = THIS.Text ( index ) 

IF Len ( ls_Event ) > 0 THEN
	uo_multipleevents.of_addEvent ( ls_Event )
END IF

end event

type st_othersite from statictext within w_eventlist
int X=27
int Y=628
int Width=270
int Height=64
boolean Enabled=false
string Text="&Other Site"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_newsite from u_sle within w_eventlist
event ue_lbuttondown pbm_lbuttondown
int X=23
int Y=692
int Width=594
int TabOrder=20
string DragIcon="grab.ico"
end type

event ue_lbuttondown;THIS.Drag ( BEGIN! )
end event

event modified;//Int i
//
//FOR i = 1 TO lb_yardmoves.TotalItems ( )
//	lb_yardmoves.SetState ( i, FALSE )
//NEXT

lb_yardmoves.SelectItem ( 0 )
end event

type st_multipleevents from statictext within w_eventlist
int X=667
int Y=172
int Width=539
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="Add Multiple Events"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_splitfront from commandbutton within w_eventlist
int X=699
int Y=208
int Width=485
int Height=104
int TabOrder=30
boolean BringToTop=true
string Text="Split &Front End"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Window	lw_Active
String	ls_Site	

ls_Site = wf_GetSite ( )


lw_Active = gnv_App.of_GEtFrame ( ).GetActiveSheet ( )

IF isValid ( lw_Active ) THEN

	lw_Active.TriggerEvent ( "ue_splitfront" , 0 , ls_Site )

END IF

end event

type cb_splitback from commandbutton within w_eventlist
int X=699
int Y=344
int Width=485
int Height=104
int TabOrder=40
boolean BringToTop=true
string Text="Split Bac&k End"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Window	lw_Active
String	ls_Site	

ls_Site = wf_GetSite ( )

lw_Active = gnv_App.of_GEtFrame ( ).GetActiveSheet ( )

IF isValid ( lw_Active ) THEN

	lw_Active.TriggerEvent ( "ue_splitback" , 0 , ls_Site )

END IF

end event

type cb_splitboth from commandbutton within w_eventlist
int X=699
int Y=480
int Width=485
int Height=104
int TabOrder=50
boolean BringToTop=true
string Text="Split &Both Ends"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Window	lw_Active
String	ls_Site	

ls_Site = wf_GetSite ( )

lw_Active = gnv_App.of_GEtFrame ( ).GetActiveSheet ( )

IF isValid ( lw_Active ) THEN

	lw_Active.TriggerEvent ( "ue_splitboth" , 0 , ls_Site )

END IF

end event

type uo_multipleevents from u_cst_multievent within w_eventlist
int X=654
int Y=244
int Width=599
int Height=452
int TabOrder=70
end type

on uo_multipleevents.destroy
call u_cst_multievent::destroy
end on

event rbuttondown;String	lsa_Label[]
Any		laa_Value[]

lsa_Label [1] = "ADD_ITEM"
laa_Value [1] = "Clear"

lsa_Label [2] = "XPOS"
laa_Value [2] = xpos + THIS.X

lsa_Label [3] = "YPOS"
laa_Value [3] = ypos + THIS.y



IF f_Pop_Standard ( lsa_Label , laa_Value ) = "CLEAR" THEN
	THIS.of_Reset ( )
END IF

end event

