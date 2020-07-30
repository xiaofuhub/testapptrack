$PBExportHeader$u_tab_duplication.sru
forward
global type u_tab_duplication from u_tab
end type
type tabpage_equipment from u_tabpg_equipmentdup within u_tab_duplication
end type
type tabpage_equipment from u_tabpg_equipmentdup within u_tab_duplication
end type
type tabpage_options from u_tabpg_dupoptions within u_tab_duplication
end type
type tabpage_options from u_tabpg_dupoptions within u_tab_duplication
end type
type tabpage_multiple from u_tabpg_dupmultiple within u_tab_duplication
end type
type tabpage_multiple from u_tabpg_dupmultiple within u_tab_duplication
end type
end forward

global type u_tab_duplication from u_tab
integer width = 2482
integer height = 1096
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean boldselectedtext = true
tabpage_equipment tabpage_equipment
tabpage_options tabpage_options
tabpage_multiple tabpage_multiple
event ue_addrow ( long al_beforerow )
event type integer ue_deleterow ( long al_row )
event ue_nonroutedselected ( boolean ab_value )
event ue_getsourceshipments ( ref long ala_shipments[] )
event ue_initializeoptions ( )
end type
global u_tab_duplication u_tab_duplication

forward prototypes
public function integer of_retrieveshipments (Long ala_IDs[])
public function long of_getshipmentids (ref long ala_Ids[])
public function integer of_multipleshipments (boolean ab_value)
public function string of_getselectedshipmentstatus ()
public function integer of_highlightnonrouted ()
end prototypes

event ue_initializeOptions();tabpage_options.event ue_initialize( )
end event

public function integer of_retrieveshipments (Long ala_IDs[]);tabpage_multiple.of_RetrieveShipments ( ala_IDs[ ] )
RETURN 1
end function

public function long of_getshipmentids (ref long ala_Ids[]);RETURN tabpage_multiple.of_GetShipmentIDs ( ala_Ids[] )
end function

public function integer of_multipleshipments (boolean ab_value);tabpage_options.of_MultipleShipments ( ab_Value )
THIS.TabPage_Multiple.Visible = ab_Value
IF ab_Value THEN
	THIS.SelectTab ( 3 )
END IF
 
RETURN 1
end function

public function string of_getselectedshipmentstatus ();RETURN tabpage_options.of_GetSelectedStatus () 
end function

public function integer of_highlightnonrouted ();RETURN tabpage_options.of_highlightnonrouted( )
end function

on u_tab_duplication.create
this.tabpage_equipment=create tabpage_equipment
this.tabpage_options=create tabpage_options
this.tabpage_multiple=create tabpage_multiple
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_equipment
this.Control[iCurrent+2]=this.tabpage_options
this.Control[iCurrent+3]=this.tabpage_multiple
end on

on u_tab_duplication.destroy
call super::destroy
destroy(this.tabpage_equipment)
destroy(this.tabpage_options)
destroy(this.tabpage_multiple)
end on

type tabpage_equipment from u_tabpg_equipmentdup within u_tab_duplication
event type integer ue_deleterow ( long al_row )
integer x = 18
integer y = 112
integer width = 2446
integer height = 968
end type

event ue_deleterow;Parent.Event ue_DeleteRow ( al_row )
RETURN 1
end event

event ue_addrow;Parent.Event ue_AddRow ( al_beforerow  )
end event

type tabpage_options from u_tabpg_dupoptions within u_tab_duplication
integer x = 18
integer y = 112
integer width = 2446
integer height = 968
end type

event ue_nonroutedselected;call super::ue_nonroutedselected;Parent.Event ue_NonRoutedSelected ( ab_value )
end event

event ue_getsourceshipments;call super::ue_getsourceshipments;Parent.Event ue_getSourceShipments ( ala_shipments[] )
end event

type tabpage_multiple from u_tabpg_dupmultiple within u_tab_duplication
integer x = 18
integer y = 112
integer width = 2446
integer height = 968
string text = "Multiple Shipments"
end type

