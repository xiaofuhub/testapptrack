$PBExportHeader$u_tab_equipment.sru
forward
global type u_tab_equipment from u_tab
end type
type tabpage_extended from u_tabpg_equipment_extended within u_tab_equipment
end type
type tabpage_extended from u_tabpg_equipment_extended within u_tab_equipment
end type
type tabpage_registration from u_tabpg_equipment_registration within u_tab_equipment
end type
type tabpage_registration from u_tabpg_equipment_registration within u_tab_equipment
end type
type tabpage_description from u_tabpg_equipment_description within u_tab_equipment
end type
type tabpage_description from u_tabpg_equipment_description within u_tab_equipment
end type
type tabpage_dimensions from u_tabpg_equipment_dimensions within u_tab_equipment
end type
type tabpage_dimensions from u_tabpg_equipment_dimensions within u_tab_equipment
end type
type tabpage_extras from u_tabpg_equipment_extras within u_tab_equipment
end type
type tabpage_extras from u_tabpg_equipment_extras within u_tab_equipment
end type
type tabpage_lease from u_tabpg_equipment_outside within u_tab_equipment
end type
type tabpage_lease from u_tabpg_equipment_outside within u_tab_equipment
end type
end forward

global type u_tab_equipment from u_tab
integer width = 2098
integer height = 1712
long backcolor = 12632256
boolean boldselectedtext = true
tabpage_extended tabpage_extended
tabpage_registration tabpage_registration
tabpage_description tabpage_description
tabpage_dimensions tabpage_dimensions
tabpage_extras tabpage_extras
tabpage_lease tabpage_lease
event ue_typechanged ( string as_eqtype )
event ue_datachanged ( string as_what,  any aa_value )
end type
global u_tab_equipment u_tab_equipment

forward prototypes
public function integer of_update (boolean ab_accepttext, boolean ab_resetflag)
public subroutine of_retrieve (long al_eqid)
public subroutine of_initialize (long al_eqid)
public function long of_getmodifiedcount ()
public function integer of_getequipmentdw (ref u_dw adw_equipment)
end prototypes

event ue_typechanged(string as_eqtype);
//let tabs know type changed
tabpage_dimensions.of_typechanged(as_eqtype)
tabpage_description.of_typechanged(as_eqtype)
tabpage_extended.of_typechanged(as_eqtype)
tabpage_extras.of_typechanged(as_eqtype)
tabpage_registration.of_typechanged(as_eqtype)



end event

public function integer of_update (boolean ab_accepttext, boolean ab_resetflag);integer	li_return = 1

IF THIS.of_AcceptText ( TRUE ) <> 1 THEN
	li_Return = -1
END IF

if li_return = 1 then
	if	tabpage_description.of_update(TRUE,TRUE) < 0 then
		li_return = -1
	end if	
end if

if li_return = 1 then
	tabpage_dimensions.of_clearblankrows()
	if	tabpage_dimensions.of_update(TRUE,TRUE) < 0 then
		li_return = -1
	end if	
end if

if li_return = 1 then
	if	tabpage_extended.of_update(TRUE,TRUE) < 0 then
		li_return = -1
	end if	
end if

if li_return = 1 then
	tabpage_extras.of_clearblankrows()
	if	tabpage_extras.of_update(TRUE,TRUE) < 0 then
		li_return = -1
	end if	
end if

if li_return = 1 then
	tabpage_registration.of_clearblankrows()
	if	tabpage_registration.of_update(TRUE,TRUE) < 0 then
		li_return = -1
	end if	
end if

return li_return
end function

public subroutine of_retrieve (long al_eqid);tabpage_description.of_retrieve(al_eqid)
tabpage_dimensions.of_Retrieve(al_eqid)
tabpage_extended.of_Retrieve(al_eqid)
tabpage_registration.of_Retrieve(al_eqid)
tabpage_extras.of_Retrieve(al_eqid)


end subroutine

public subroutine of_initialize (long al_eqid);tabpage_description.of_initialize(al_eqid)
tabpage_dimensions.of_initialize(al_eqid)
tabpage_extended.of_initialize(al_eqid)
tabpage_registration.of_initialize(al_eqid)
tabpage_extras.of_initialize(al_eqid)

end subroutine

public function long of_getmodifiedcount ();long	ll_count

ll_count = tabpage_description.of_Getmodifiedcount( )
ll_count = ll_count + tabpage_dimensions.of_getmodifiedcount( )
ll_count = ll_count + tabpage_extended.of_Getmodifiedcount( )
ll_count = ll_count + tabpage_extras.of_Getmodifiedcount( )
ll_count = ll_count + tabpage_lease.of_Getmodifiedcount( )
ll_count = ll_count + tabpage_registration.of_Getmodifiedcount( )

return ll_count
end function

public function integer of_getequipmentdw (ref u_dw adw_equipment);//DEK 5-21-07
return tabpage_lease.of_getequipmentdw( adw_equipment )
end function

on u_tab_equipment.create
this.tabpage_extended=create tabpage_extended
this.tabpage_registration=create tabpage_registration
this.tabpage_description=create tabpage_description
this.tabpage_dimensions=create tabpage_dimensions
this.tabpage_extras=create tabpage_extras
this.tabpage_lease=create tabpage_lease
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_extended
this.Control[iCurrent+2]=this.tabpage_registration
this.Control[iCurrent+3]=this.tabpage_description
this.Control[iCurrent+4]=this.tabpage_dimensions
this.Control[iCurrent+5]=this.tabpage_extras
this.Control[iCurrent+6]=this.tabpage_lease
end on

on u_tab_equipment.destroy
call super::destroy
destroy(this.tabpage_extended)
destroy(this.tabpage_registration)
destroy(this.tabpage_description)
destroy(this.tabpage_dimensions)
destroy(this.tabpage_extras)
destroy(this.tabpage_lease)
end on

type tabpage_extended from u_tabpg_equipment_extended within u_tab_equipment
integer x = 18
integer y = 100
integer width = 2062
integer height = 1596
string text = "Detail"
long tabbackcolor = 12632256
end type

event ue_datachanged;call super::ue_datachanged;parent.event ue_datachanged(as_what, aa_value)
end event

type tabpage_registration from u_tabpg_equipment_registration within u_tab_equipment
integer x = 18
integer y = 100
integer width = 2062
integer height = 1596
string text = "Registration"
long tabbackcolor = 12632256
end type

type tabpage_description from u_tabpg_equipment_description within u_tab_equipment
integer x = 18
integer y = 100
integer width = 2062
integer height = 1596
string text = "Description"
long tabbackcolor = 12632256
end type

type tabpage_dimensions from u_tabpg_equipment_dimensions within u_tab_equipment
integer x = 18
integer y = 100
integer width = 2062
integer height = 1596
string text = "Dimensions"
long tabbackcolor = 12632256
end type

event ue_datachanged;call super::ue_datachanged;parent.event ue_datachanged(as_what, aa_value)
end event

type tabpage_extras from u_tabpg_equipment_extras within u_tab_equipment
integer x = 18
integer y = 100
integer width = 2062
integer height = 1596
string text = "Extras"
long tabbackcolor = 12632256
end type

event ue_datachanged;call super::ue_datachanged;parent.event ue_datachanged(as_what, aa_value)
end event

type tabpage_lease from u_tabpg_equipment_outside within u_tab_equipment
boolean visible = false
integer x = 18
integer y = 100
integer width = 2062
integer height = 1596
end type

