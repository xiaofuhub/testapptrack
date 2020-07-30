$PBExportHeader$u_tabpg_equipment_extended.sru
forward
global type u_tabpg_equipment_extended from u_tabpg_equipment
end type
type dw_purchase from u_dw_equipmentpurchased within u_tabpg_equipment_extended
end type
type dw_extended from u_dw_equipmentextended within u_tabpg_equipment_extended
end type
type gb_1 from groupbox within u_tabpg_equipment_extended
end type
end forward

global type u_tabpg_equipment_extended from u_tabpg_equipment
dw_purchase dw_purchase
dw_extended dw_extended
gb_1 gb_1
end type
global u_tabpg_equipment_extended u_tabpg_equipment_extended

forward prototypes
public subroutine of_retrieve (long al_eqid)
public function long of_getmodifiedcount ()
public subroutine of_setnewequipmentid (long al_value)
public subroutine of_typechanged (string as_eqtype)
public subroutine of_initialize (long al_eqid)
end prototypes

public subroutine of_retrieve (long al_eqid);dw_extended.retrieve(al_eqid)
dw_purchase.retrieve(al_eqid)

end subroutine

public function long of_getmodifiedcount ();long	ll_count

ll_count = dw_extended.modifiedcount( )

ll_count = ll_count + dw_purchase.modifiedcount()

return ll_count
end function

public subroutine of_setnewequipmentid (long al_value);choose case dw_extended.Getitemstatus(1,0,Primary!)
	case datamodified!
		dw_extended.object.equipmentid[1] = al_value
		dw_extended.SetItemStatus(1, 'equipmentid', Primary!, NotModified!)
				
	case notmodified!, new!
		dw_extended.object.equipmentid[1] = al_value
		dw_extended.SetItemStatus(1, 0, Primary!, NotModified!)
		
	case else
		dw_extended.object.equipmentid[1] = al_value

end choose

choose case dw_purchase.Getitemstatus(1,0,Primary!)
	case datamodified!
		dw_purchase.object.equipmentid[1] = al_value
		dw_purchase.SetItemStatus(1, 'equipmentid', Primary!, NotModified!)
				
	case notmodified!, new!
		dw_purchase.object.equipmentid[1] = al_value
		dw_purchase.SetItemStatus(1, 0, Primary!, NotModified!)
		
	case else
		dw_purchase.object.equipmentid[1] = al_value
			
end choose



end subroutine

public subroutine of_typechanged (string as_eqtype);n_cst_EquipmentManager	lnv_EquipmentManager

dw_extended.object.gvw.visible=0
dw_extended.object.gvw_t.visible=0

choose case as_eqtype
	case lnv_EquipmentManager.cs_STRT, lnv_EquipmentManager.cs_TRAC, lnv_EquipmentManager.cs_VAN
		dw_extended.object.gvw.visible=1
		dw_extended.object.gvw_t.visible=1

end choose

end subroutine

public subroutine of_initialize (long al_eqid);long	ll_row

if dw_extended.rowcount() > 0 then
	//ok
else
	ll_row = dw_extended.insertrow(0)
	if ll_row > 0 then
		dw_extended.object.equipmentid[ll_row] = al_eqid
		dw_extended.object.equipment_eq_axles[ll_row] = dw_extended.of_getaxle()
		dw_extended.object.equipment_notes[ll_row] = dw_extended.of_getnote()
		dw_extended.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	end if
end if

if dw_purchase.rowcount() > 0 then
	//ok
else
	ll_row = dw_purchase.insertrow(0)
	if ll_row > 0 then
		dw_purchase.object.equipmentid[ll_row] = al_eqid
		dw_purchase.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	end if
end if


end subroutine

on u_tabpg_equipment_extended.create
int iCurrent
call super::create
this.dw_purchase=create dw_purchase
this.dw_extended=create dw_extended
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_purchase
this.Control[iCurrent+2]=this.dw_extended
this.Control[iCurrent+3]=this.gb_1
end on

on u_tabpg_equipment_extended.destroy
call super::destroy
destroy(this.dw_purchase)
destroy(this.dw_extended)
destroy(this.gb_1)
end on

event constructor;call super::constructor;PowerObject lpoa_UpdateControls[ ]

lpoa_UpdateControls [ 1 ] = dw_extended

lpoa_UpdateControls [ 2 ] = dw_purchase
			
of_SetUpdateObjects ( lpoa_UpdateControls )

end event

type dw_purchase from u_dw_equipmentpurchased within u_tabpg_equipment_extended
integer x = 41
integer y = 1380
integer width = 1961
integer height = 168
integer taborder = 20
end type

type dw_extended from u_dw_equipmentextended within u_tabpg_equipment_extended
integer x = 37
integer y = 8
integer width = 1998
integer height = 1272
integer taborder = 10
end type

event ue_noteschanged;call super::ue_noteschanged;parent.event ue_datachanged('notes',as_value)
end event

event ue_axlechanged;call super::ue_axlechanged;parent.event ue_datachanged('axle',al_value)
end event

type gb_1 from groupbox within u_tabpg_equipment_extended
integer x = 18
integer y = 1296
integer width = 2007
integer height = 276
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Purchase Information"
end type

