$PBExportHeader$u_tabpg_equipment_description.sru
forward
global type u_tabpg_equipment_description from u_tabpg_equipment
end type
type dw_1 from u_dw_equipmentdescription within u_tabpg_equipment_description
end type
end forward

global type u_tabpg_equipment_description from u_tabpg_equipment
dw_1 dw_1
end type
global u_tabpg_equipment_description u_tabpg_equipment_description

forward prototypes
public subroutine of_retrieve (long al_eqid)
public subroutine of_typechanged (string as_eqtype)
public function long of_getmodifiedcount ()
public subroutine of_setnewequipmentid (long al_value)
public subroutine of_initialize (long al_eqid)
end prototypes

public subroutine of_retrieve (long al_eqid);dw_1.retrieve(al_eqid)


end subroutine

public subroutine of_typechanged (string as_eqtype);
n_cst_EquipmentManager	lnv_EquipmentManager
n_cst_Presentation_Equipment	lnv_Presentation

lnv_Presentation.of_SetPresentation ( dw_1, as_eqtype )

dw_1.object.description.visible=0
dw_1.object.description_t.visible=0
dw_1.object.description.TabSequence=0

dw_1.object.doortype.visible=0
dw_1.object.doortype_t.visible=0
dw_1.object.doortype.TabSequence=0

dw_1.object.floortype.visible=0
dw_1.object.floortype_t.visible=0
dw_1.object.floortype.TabSequence=0

dw_1.object.sleeper.y=308
dw_1.object.sleeper.visible=0
dw_1.object.sleeper.TabSequence=0

dw_1.object.construction.visible=0
dw_1.object.construction_t.visible=0
dw_1.object.construction.TabSequence=0

dw_1.object.dischargetype.visible=0
dw_1.object.dischargetype_t.visible=0
dw_1.object.dischargetype.TabSequence=0

choose case as_eqtype
		
	case lnv_EquipmentManager.cs_TRAC
		dw_1.object.sleeper.y=116
		dw_1.object.sleeper.visible=1
		dw_1.object.sleeper.TabSequence=40
		
	case lnv_EquipmentManager.cs_STRT
		dw_1.object.description.visible=1
		dw_1.object.description_t.visible=1
		dw_1.object.sleeper.visible=1
		dw_1.object.doortype.visible=1
		dw_1.object.doortype_t.visible=1
		dw_1.object.floortype.visible=1
		dw_1.object.floortype_t.visible=1
		
		dw_1.object.description.TabSequence=10
		dw_1.object.doortype.TabSequence=20
		dw_1.object.floortype.TabSequence=30
		dw_1.object.sleeper.TabSequence=40
		
	case lnv_EquipmentManager.cs_RBOX
		dw_1.object.doortype.visible=1
		dw_1.object.doortype_t.visible=1
		dw_1.object.floortype.visible=1
		dw_1.object.floortype_t.visible=1

		dw_1.object.doortype.TabSequence=20
		dw_1.object.floortype.TabSequence=30

	case lnv_EquipmentManager.cs_TRLR, lnv_EquipmentManager.cs_REFR
		dw_1.object.description.visible=1
		dw_1.object.description_t.visible=1
		dw_1.object.doortype.visible=1
		dw_1.object.doortype_t.visible=1
		dw_1.object.floortype.visible=1
		dw_1.object.floortype_t.visible=1

		dw_1.object.description.TabSequence=10
		dw_1.object.doortype.TabSequence=20
		dw_1.object.floortype.TabSequence=30

	case lnv_EquipmentManager.cs_TANK
		dw_1.object.description.visible=1
		dw_1.object.description_t.visible=1
		dw_1.object.dischargetype.y=116
		dw_1.object.dischargetype_t.y=116
		dw_1.object.dischargetype.visible=1
		dw_1.object.dischargetype_t.visible=1

		dw_1.object.description.TabSequence=10
		dw_1.object.dischargetype.TabSequence=60

	case lnv_EquipmentManager.cs_CNTN
		dw_1.object.description.visible=1
		dw_1.object.description_t.visible=1
		dw_1.object.construction.y=116
		dw_1.object.construction_t.y=116
		dw_1.object.construction.visible=1
		dw_1.object.construction_t.visible=1

		dw_1.object.description.TabSequence=10
		dw_1.object.construction.TabSequence=50

	case lnv_EquipmentManager.cs_VAN
		
	case lnv_EquipmentManager.cs_FLBD, lnv_EquipmentManager.cs_CHAS
		dw_1.object.description.visible=1
		dw_1.object.description_t.visible=1

		dw_1.object.description.TabSequence=10
		
end choose
	
		
end subroutine

public function long of_getmodifiedcount ();long	ll_count

ll_count = dw_1.modifiedcount( )

return ll_count
end function

public subroutine of_setnewequipmentid (long al_value);choose case dw_1.Getitemstatus(1,0,Primary!)
	case datamodified!
		dw_1.object.equipmentid[1] = al_value
		dw_1.SetItemStatus(1, 'equipmentid', Primary!, NotModified!)
		
	case notmodified!, new!
		dw_1.object.equipmentid[1] = al_value
		dw_1.SetItemStatus(1, 0, Primary!, NotModified!)
		
	case else
		dw_1.object.equipmentid[1] = al_value
		
end choose
end subroutine

public subroutine of_initialize (long al_eqid);long	ll_row

if dw_1.rowcount() > 0 then
	//ok
else
	ll_row = dw_1.insertrow(0)
	if ll_row > 0 then
		dw_1.object.equipmentid[ll_row] = al_eqid
		dw_1.SetItemStatus(ll_row, 0, Primary!, NotModified!)	
	end if
end if


end subroutine

on u_tabpg_equipment_description.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_equipment_description.destroy
call super::destroy
destroy(this.dw_1)
end on

event constructor;call super::constructor;PowerObject lpoa_UpdateControls[ ]

lpoa_UpdateControls [ 1 ] = dw_1
			
of_SetUpdateObjects ( lpoa_UpdateControls )

end event

type dw_1 from u_dw_equipmentdescription within u_tabpg_equipment_description
integer x = 41
integer y = 32
integer width = 1947
integer height = 736
integer taborder = 10
end type

event constructor;call super::constructor;this.object.sleeper.y=308
this.object.sleeper.visible=0
this.object.doortype.visible=0
this.object.doortype_t.visible=0
this.object.floortype.visible=0
this.object.floortype_t.visible=0
this.object.dischargetype.visible=0
this.object.dischargetype_t.visible=0
this.object.construction.visible=0
this.object.construction_t.visible=0

end event

