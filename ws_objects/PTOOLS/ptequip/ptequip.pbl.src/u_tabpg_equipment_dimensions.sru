$PBExportHeader$u_tabpg_equipment_dimensions.sru
forward
global type u_tabpg_equipment_dimensions from u_tabpg_equipment
end type
type dw_compartment from u_dw_equipmentcompartment within u_tabpg_equipment_dimensions
end type
type dw_1 from u_dw_equipmentdimensions within u_tabpg_equipment_dimensions
end type
type gb_compartment from groupbox within u_tabpg_equipment_dimensions
end type
end forward

global type u_tabpg_equipment_dimensions from u_tabpg_equipment
dw_compartment dw_compartment
dw_1 dw_1
gb_compartment gb_compartment
end type
global u_tabpg_equipment_dimensions u_tabpg_equipment_dimensions

forward prototypes
public subroutine of_retrieve (long al_eqid)
public subroutine of_typechanged (string as_eqtype)
public function long of_getmodifiedcount ()
public subroutine of_setnewequipmentid (long al_value)
public subroutine of_clearblankrows ()
public subroutine of_initialize (long al_eqid)
end prototypes

public subroutine of_retrieve (long al_eqid);dw_1.retrieve(al_eqid)

dw_compartment.retrieve(al_eqid)


end subroutine

public subroutine of_typechanged (string as_eqtype);n_cst_EquipmentManager	lnv_EquipmentManager

dw_1.object.equipment_eq_length.visible=1
dw_1.object.equipment_eq_length_t.visible=1
dw_1.object.equipment_eq_length_ft_t.visible=1
dw_1.object.equipment_eq_length.TabSequence=10

dw_1.object.equipment_eq_height.visible=1
dw_1.object.equipment_eq_height_t.visible=1
dw_1.object.equipment_eq_height_in_t.visible=1
dw_1.object.equipment_eq_height.TabSequence=20

dw_1.object.insideheight.visible=0
dw_1.object.insideheight_t.visible=0
dw_1.object.insideheight_in_t.visible=0
dw_1.object.insideheight.TabSequence=0

dw_1.object.insidewidth.visible=0
dw_1.object.insidewidth_t.visible=0
dw_1.object.insidewidth_in_t.visible=0
dw_1.object.insidewidth.TabSequence=0

dw_1.object.doorheight.visible=0
dw_1.object.doorheight_t.visible=0
dw_1.object.doorheight_in_t.visible=0
dw_1.object.doorheight.TabSequence=0

dw_1.object.doorwidth.visible=0
dw_1.object.doorwidth_t.visible=0
dw_1.object.doorwidth_in_t.visible=0
dw_1.object.doorwidth.TabSequence=0

dw_1.object.frontdecklength.visible=0
dw_1.object.frontdecklength_t.visible=0
dw_1.object.frontdecklength_in_t.visible=0
dw_1.object.frontdecklength.TabSequence=0

dw_1.object.reardecklength.visible=0
dw_1.object.reardecklength_t.visible=0
dw_1.object.reardecklength_in_t.visible=0
dw_1.object.reardecklength.TabSequence=0

dw_1.object.welllength.visible=0
dw_1.object.welllength_t.visible=0
dw_1.object.welllength_in_t.visible=0
dw_1.object.welllength.TabSequence=0

dw_compartment.visible=false
gb_compartment.visible=false

choose case as_eqtype
	case lnv_EquipmentManager.cs_FLBD
		dw_1.object.frontdecklength.visible=1
		dw_1.object.frontdecklength_t.visible=1
		dw_1.object.frontdecklength_in_t.visible=1
		dw_1.object.reardecklength.visible=1
		dw_1.object.reardecklength_t.visible=1
		dw_1.object.reardecklength_in_t.visible=1
		dw_1.object.welllength.visible=1
		dw_1.object.welllength_t.visible=1
		dw_1.object.welllength_in_t.visible=1

		dw_1.object.frontdecklength.TabSequence=70
		dw_1.object.reardecklength.TabSequence=80
		dw_1.object.welllength.TabSequence=90

	case lnv_EquipmentManager.cs_STRT, lnv_EquipmentManager.cs_TRLR, lnv_EquipmentManager.cs_REFR, lnv_EquipmentManager.cs_VAN
		dw_1.object.insideheight.visible=1
		dw_1.object.insideheight_t.visible=1
		dw_1.object.insideheight_in_t.visible=1
		dw_1.object.insidewidth.visible=1
		dw_1.object.insidewidth_t.visible=1
		dw_1.object.insidewidth_in_t.visible=1
		dw_1.object.doorheight.visible=1
		dw_1.object.doorheight_t.visible=1
		dw_1.object.doorheight_in_t.visible=1
		dw_1.object.doorwidth.visible=1
		dw_1.object.doorwidth_t.visible=1
		dw_1.object.doorwidth_in_t.visible=1

		dw_1.object.insideheight.TabSequence=30
		dw_1.object.insidewidth.TabSequence=40
		dw_1.object.doorheight.TabSequence=50
		dw_1.object.doorwidth.TabSequence=60

	case lnv_EquipmentManager.cs_TANK
		dw_compartment.visible=true
		gb_compartment.visible=true
		dw_compartment.bringtotop = true
	
	case lnv_EquipmentManager.cs_TRAC
		dw_1.object.equipment_eq_length.visible=0
		dw_1.object.equipment_eq_length_t.visible=0
		dw_1.object.equipment_eq_length_ft_t.visible=0
		
		dw_1.object.equipment_eq_height.visible=0
		dw_1.object.equipment_eq_height_t.visible=0
		dw_1.object.equipment_eq_height_in_t.visible=0

		dw_1.object.equipment_eq_length.TabSequence=0
		dw_1.object.equipment_eq_height.TabSequence=0


end choose
	
	
	
	
end subroutine

public function long of_getmodifiedcount ();long	ll_count

ll_count = dw_1.modifiedcount( )

ll_count = ll_count + dw_compartment.modifiedcount()

return ll_count
end function

public subroutine of_setnewequipmentid (long al_value);long ll_row, ll_rowcount

choose case dw_1.Getitemstatus(1,0,Primary!)
	case datamodified!
		dw_1.object.equipmentid[1] = al_value
		dw_1.SetItemStatus(1, 'equipmentid', Primary!, notModified!)
		
	case notmodified!, new!
		dw_1.object.equipmentid[1] = al_value
		dw_1.SetItemStatus(1, 0, Primary!, notModified!)
		
	case else
		dw_1.object.equipmentid[1] = al_value
		
end choose

choose case dw_compartment.Getitemstatus(1,0,Primary!)
	case datamodified!

		ll_rowcount = dw_compartment.rowcount()
		for ll_row = 1 to ll_rowcount
			dw_compartment.object.equipmentid[ll_row] = al_value
			dw_compartment.SetItemStatus(ll_row, 'equipmentid', Primary!, NotModified!)
		next

case notmodified!, new!
	
		ll_rowcount = dw_compartment.rowcount()
		for ll_row = 1 to ll_rowcount
			dw_compartment.object.equipmentid[ll_row] = al_value
			dw_compartment.SetItemStatus(ll_row, 0, Primary!, NotModified!)
		next
		
	case else

		ll_rowcount = dw_compartment.rowcount()
		for ll_row = 1 to ll_rowcount
			dw_compartment.object.equipmentid[ll_row] = al_value
		next
		
end choose

end subroutine

public subroutine of_clearblankrows ();long	ll_rowcount, &
		ll_ndx

string	ls_id

ll_rowcount = dw_compartment.rowcount()

for ll_ndx = ll_rowcount to 1 step -1
	ls_id = dw_compartment.object.id[ll_ndx]
	if isnull(ls_id) or len(ls_id) = 0 then
		dw_compartment.RowsDiscard ( ll_ndx, ll_ndx, Primary! )
	end if
next
end subroutine

public subroutine of_initialize (long al_eqid);long	ll_row

if dw_1.rowcount() > 0 then
	//ok
else
	ll_row = dw_1.insertrow(0)
	if ll_row > 0 then
		dw_1.object.equipmentid[ll_row] = al_eqid
		dw_1.object.equipment_eq_length[ll_row] = dw_1.of_getlength()
		dw_1.object.equipment_eq_height[ll_row] = dw_1.of_getwidth()
		dw_1.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	end if
end if

//add  a new row at end
ll_row = dw_compartment.insertrow(0)
if ll_row > 0 then
	dw_compartment.object.equipmentid[ll_row] = al_eqid
	dw_compartment.SetItemStatus(ll_row, 0, Primary!, NotModified!)
end if


end subroutine

on u_tabpg_equipment_dimensions.create
int iCurrent
call super::create
this.dw_compartment=create dw_compartment
this.dw_1=create dw_1
this.gb_compartment=create gb_compartment
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_compartment
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_compartment
end on

on u_tabpg_equipment_dimensions.destroy
call super::destroy
destroy(this.dw_compartment)
destroy(this.dw_1)
destroy(this.gb_compartment)
end on

event constructor;call super::constructor;PowerObject lpoa_UpdateControls[ ]

lpoa_UpdateControls [ 1 ] = dw_1

lpoa_UpdateControls [ 2 ] = dw_compartment
			
of_SetUpdateObjects ( lpoa_UpdateControls )

end event

type dw_compartment from u_dw_equipmentcompartment within u_tabpg_equipment_dimensions
integer x = 471
integer y = 812
integer height = 488
integer taborder = 20
boolean vscrollbar = true
end type

event constructor;call super::constructor;this.visible=false
gb_compartment.visible=false

end event

event itemchanged;call super::itemchanged;choose case dwo.name 
	case 'id'
		if this.rowcount() = row then
				this.Event PFC_AddRow()
		end if
end choose

end event

event pfc_addrow;call super::pfc_addrow;String	ls_name
Long		ll_Return

ll_return = AncestorReturnValue

IF ll_Return > 0 THEN
	
	this.object.equipmentid[ll_return] = this.object.equipmentid[1]
	
END IF

RETURN ll_Return

end event

type dw_1 from u_dw_equipmentdimensions within u_tabpg_equipment_dimensions
integer x = 50
integer y = 32
integer width = 1682
integer height = 668
integer taborder = 10
end type

event constructor;call super::constructor;this.object.equipment_eq_length.visible=1
this.object.equipment_eq_length_t.visible=1
this.object.equipment_eq_length_ft_t.visible=1

this.object.equipment_eq_height.visible=1
this.object.equipment_eq_height_t.visible=1
this.object.equipment_eq_height_in_t.visible=1

this.object.insideheight.visible=0
this.object.insideheight_t.visible=0
this.object.insideheight_in_t.visible=0

this.object.insidewidth.visible=0
this.object.insidewidth_t.visible=0
this.object.insidewidth_in_t.visible=0

this.object.doorheight.visible=0
this.object.doorheight_t.visible=0
this.object.doorheight_in_t.visible=0

this.object.doorwidth.visible=0
this.object.doorwidth_t.visible=0
this.object.doorwidth_in_t.visible=0

this.object.frontdecklength.visible=0
this.object.frontdecklength_t.visible=0
this.object.frontdecklength_in_t.visible=0

this.object.reardecklength.visible=0
this.object.reardecklength_t.visible=0
this.object.reardecklength_in_t.visible=0

this.object.welllength.visible=0
this.object.welllength_t.visible=0
this.object.welllength_in_t.visible=0


end event

event ue_lengthchanged;call super::ue_lengthchanged;parent.event ue_datachanged('length',ac_value)
end event

event ue_widthchanged;call super::ue_widthchanged;parent.event ue_datachanged('width',ac_value)
end event

type gb_compartment from groupbox within u_tabpg_equipment_dimensions
integer x = 306
integer y = 704
integer width = 1125
integer height = 680
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = " Compartments"
end type

