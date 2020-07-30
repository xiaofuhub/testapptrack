$PBExportHeader$u_cst_multievent.sru
forward
global type u_cst_multievent from u_base
end type
type lb_multipleevents from listbox within u_cst_multievent
end type
end forward

global type u_cst_multievent from u_base
int Width=603
int Height=432
string DragIcon="grab.ico"
lb_multipleevents lb_multipleevents
end type
global u_cst_multievent u_cst_multievent

forward prototypes
public function integer of_getevents (ref string asa_events[])
public function integer of_addevent (string as_Event)
public function integer of_reset ()
end prototypes

public function integer of_getevents (ref string asa_events[]);Int		i
Int		li_count
String	lsa_Events[]

n_cst_Events	lnv_Events

li_Count = lb_multipleevents.TotalItems ( )

FOR i = 1 To li_Count
	lsa_Events[i] = lnv_Events.of_getTypeDataValue ( lb_multipleevents.Text ( i ) )
NEXT

asa_events[] = lsa_Events
RETURN UpperBound ( asa_events )
end function

public function integer of_addevent (string as_Event);lb_multipleevents.AddItem ( as_Event )
RETURN 1
end function

public function integer of_reset ();lb_multipleevents.Reset ( )
RETURN 1
end function

on u_cst_multievent.create
int iCurrent
call super::create
this.lb_multipleevents=create lb_multipleevents
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lb_multipleevents
end on

on u_cst_multievent.destroy
call super::destroy
destroy(this.lb_multipleevents)
end on

type lb_multipleevents from listbox within u_cst_multievent
event ue_lbuttondown pbm_lbuttondown
int Width=594
int Height=432
int TabOrder=10
string DragIcon="grab.ico"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean Sorted=false
boolean MultiSelect=true
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_lbuttondown;
THIS.DRAG ( BEGIN! )

end event

event dragdrop;CHOOSE CASE Source.Classname ( )
			
	CASE "lb_events"
		
		ListBox llb_Temp
		llb_Temp = Source
		Int i
		String lsa_Types[]
		
		FOR i = 1 TO llb_Temp.TotalItems ( )
			IF llb_Temp.State ( i ) = 1 THEN
				THIS.AddItem ( llb_Temp.Text ( i ) )			
			END IF
		NEXT
		
END CHOOSE
end event

event doubleclicked;THIS.DeleteItem ( index )
end event

event rbuttondown;//String	lsa_Label[]
//Any		laa_Value[]
//
//lsa_Label [1] = "ADD_ITEM"
//laa_Value [1] = "Clear"
//
//lsa_Label [2] = "XPOS"
//laa_Value [2] = xpos
//
//lsa_Label [3] = "YPOS"
//laa_Value [3] = ypos
//
//
//
//IF f_Pop_Standard ( lsa_Label , laa_Value ) = "CLEAR" THEN
//	PARENT.of_Reset ( )
//END IF

PARENT.Event rbuttonDown ( flags , xpos , ypos )
end event

event dragleave;Int i
lb_multipleevents.SetRedraw ( FALSE )
FOR i = 1 TO lb_multipleevents.TotalItems ( )
	lb_multipleevents.SetState ( i, TRUE )
NEXT
lb_multipleevents.SetRedraw ( TRUE )
end event

