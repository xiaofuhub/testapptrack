$PBExportHeader$u_tabpg_equipment_extras.sru
forward
global type u_tabpg_equipment_extras from u_tabpg_equipment
end type
type dw_device from u_dw within u_tabpg_equipment_extras
end type
type dw_1 from u_dw_equipmentextras within u_tabpg_equipment_extras
end type
type gb_device from groupbox within u_tabpg_equipment_extras
end type
end forward

global type u_tabpg_equipment_extras from u_tabpg_equipment
dw_device dw_device
dw_1 dw_1
gb_device gb_device
end type
global u_tabpg_equipment_extras u_tabpg_equipment_extras

forward prototypes
public subroutine of_retrieve (long al_eqid)
public subroutine of_typechanged (string as_eqtype)
public function long of_getmodifiedcount ()
public subroutine of_setnewequipmentid (long al_value)
public subroutine of_clearblankrows ()
public subroutine of_initialize (long al_eqid)
end prototypes

public subroutine of_retrieve (long al_eqid);dw_1.retrieve(al_eqid)
dw_device.retrieve(al_eqid)


end subroutine

public subroutine of_typechanged (string as_eqtype);n_cst_EquipmentManager	lnv_EquipmentManager

dw_1.object.equipment_eq_air.visible=0
dw_1.object.equipment_eq_air.x=133
dw_1.object.equipment_eq_air.y=56
dw_1.object.equipment_eq_air.TabSequence=0

dw_1.object.liftgate.x=1207
dw_1.object.liftgate.visible=0
dw_1.object.liftgate.TabSequence=0

dw_1.object.sidedoor.x=1175
dw_1.object.sidedoor.visible=0
dw_1.object.sidedoor.TabSequence=0

dw_1.object.Etrack.visible=0
dw_1.object.Etrack.TabSequence=0

dw_1.object.logisticsposts.visible=0
dw_1.object.logisticsposts.TabSequence=0

dw_1.object.logisticsbars.visible=0
dw_1.object.logisticsbars_t.visible=0
dw_1.object.logisticsbars.TabSequence=0

dw_1.object.straps.visible=0
dw_1.object.straps_t.visible=0
dw_1.object.straps.TabSequence=0

dw_1.object.loadbars.visible=0
dw_1.object.loadbars_t.visible=0
dw_1.object.loadbars.TabSequence=0

dw_1.object.chains.visible=0
dw_1.object.chains.y=320
dw_1.object.chains_t.visible=0
dw_1.object.chains_t.y=320
dw_1.object.chains.TabSequence=0

dw_1.object.binders.visible=0
dw_1.object.binders.y=408
dw_1.object.binders_t.visible=0
dw_1.object.binders_t.y=408
dw_1.object.binders.TabSequence=0

dw_1.object.tarp.visible=0
dw_1.object.tarp_t.visible=0
dw_1.object.tarp.y=496
dw_1.object.tarp_t.y=496
dw_1.object.tarp.TabSequence=0

dw_1.object.powersource.visible=0
dw_1.object.powersource_t.visible=0
dw_1.object.powersource.TabSequence=0

dw_device.visible=false
gb_device.visible=false

choose case as_eqtype
	case lnv_EquipmentManager.cs_TRAC
		dw_1.object.equipment_eq_air.visible=1
		dw_1.object.equipment_eq_air.TabSequence=80
		dw_device.visible=true
		gb_device.visible=true
		dw_device.bringtotop = true

	case lnv_EquipmentManager.cs_TANK
		dw_1.object.equipment_eq_air.visible=1
		dw_1.object.equipment_eq_air.TabSequence=80
		
	case lnv_EquipmentManager.cs_FLBD
		dw_1.object.equipment_eq_air.visible=1
		dw_1.object.equipment_eq_air.x=379
		dw_1.object.equipment_eq_air.y=52
		
		dw_1.object.straps.visible=1
		dw_1.object.straps_t.visible=1
		
		dw_1.object.chains.visible=1
		dw_1.object.chains.y=232
		dw_1.object.chains_t.visible=1
		dw_1.object.chains_t.y=232

		dw_1.object.binders.visible=1
		dw_1.object.binders.y=320
		dw_1.object.binders_t.visible=1
		dw_1.object.binders_t.y=320
		
		dw_1.object.tarp.y=408
		dw_1.object.tarp_t.y=408

		dw_1.object.tarp.visible=1
		dw_1.object.tarp_t.visible=1
		
		dw_1.object.equipment_eq_air.TabSequence=10
		dw_1.object.straps.TabSequence=20
		dw_1.object.chains.TabSequence=40
		dw_1.object.binders.TabSequence=50
		dw_1.object.tarp.TabSequence=60
		
	case lnv_EquipmentManager.cs_STRT 
		dw_1.object.equipment_eq_air.visible=1
		dw_1.object.equipment_eq_air.x=1198
		dw_1.object.equipment_eq_air.y=408
		dw_1.object.liftgate.visible=1
		dw_1.object.sidedoor.visible=1
		dw_1.object.Etrack.visible=1
		dw_1.object.logisticsposts.visible=1
		dw_1.object.logisticsbars.visible=1
		dw_1.object.logisticsbars_t.visible=1
		dw_1.object.straps.visible=1
		dw_1.object.straps_t.visible=1
		dw_1.object.loadbars.visible=1
		dw_1.object.loadbars_t.visible=1
		dw_device.visible=true
		gb_device.visible=true
		dw_device.bringtotop = true

		dw_1.object.logisticsbars.TabSequence=10
		dw_1.object.straps.TabSequence=20
		dw_1.object.loadbars.TabSequence=30
		dw_1.object.liftgate.TabSequence=90
		dw_1.object.sidedoor.TabSequence=100
		dw_1.object.Etrack.TabSequence=110
		dw_1.object.logisticsposts.TabSequence=120
		dw_1.object.equipment_eq_air.TabSequence=130
		
	case lnv_EquipmentManager.cs_TRLR
		dw_1.object.equipment_eq_air.visible=1
		dw_1.object.equipment_eq_air.x=1198
		
		dw_1.object.liftgate.visible=1
		dw_1.object.sidedoor.visible=1
		dw_1.object.Etrack.visible=1
		dw_1.object.logisticsposts.visible=1
		dw_1.object.logisticsbars.visible=1
		dw_1.object.logisticsbars_t.visible=1
		dw_1.object.straps.visible=1
		dw_1.object.straps_t.visible=1
		dw_1.object.loadbars.visible=1
		dw_1.object.loadbars_t.visible=1

		dw_1.object.logisticsbars.TabSequence=10
		dw_1.object.straps.TabSequence=20
		dw_1.object.loadbars.TabSequence=30
		dw_1.object.liftgate.TabSequence=90
		dw_1.object.sidedoor.TabSequence=100
		dw_1.object.Etrack.TabSequence=110
		dw_1.object.logisticsposts.TabSequence=120
		dw_1.object.equipment_eq_air.TabSequence=130
		
	case lnv_EquipmentManager.cs_VAN
		dw_1.object.liftgate.x=174
		dw_1.object.sidedoor.x=142
		dw_1.object.liftgate.visible=1
		dw_1.object.sidedoor.visible=1
		dw_device.visible=true
		gb_device.visible=true
		dw_device.bringtotop = true

		dw_1.object.liftgate.TabSequence=90
		dw_1.object.sidedoor.TabSequence=100

	case lnv_EquipmentManager.cs_REFR
		dw_1.object.equipment_eq_air.visible=1
		dw_1.object.equipment_eq_air.x=1198
		dw_1.object.equipment_eq_air.y=408
		
		dw_1.object.liftgate.visible=1
		dw_1.object.sidedoor.visible=1
		dw_1.object.Etrack.visible=1
		dw_1.object.logisticsposts.visible=1
		dw_1.object.logisticsbars.visible=1
		dw_1.object.logisticsbars_t.visible=1
		dw_1.object.straps.visible=1
		dw_1.object.straps_t.visible=1
		dw_1.object.loadbars.visible=1
		dw_1.object.loadbars_t.visible=1

		dw_1.object.powersource.y=320
		dw_1.object.powersource_t.y=320
		dw_1.object.powersource.visible=1
		dw_1.object.powersource_t.visible=1

		dw_1.object.logisticsbars.TabSequence=10
		dw_1.object.straps.TabSequence=20
		dw_1.object.loadbars.TabSequence=30
		dw_1.object.powersource.TabSequence=70
		dw_1.object.liftgate.TabSequence=90
		dw_1.object.sidedoor.TabSequence=100
		dw_1.object.Etrack.TabSequence=110
		dw_1.object.logisticsposts.TabSequence=120
		dw_1.object.equipment_eq_air.TabSequence=130

end choose




end subroutine

public function long of_getmodifiedcount ();long	ll_count

ll_count = dw_1.modifiedcount( )

ll_count = ll_count + dw_device.modifiedcount()

ll_Count += dw_device.Deletedcount( )

return ll_count
end function

public subroutine of_setnewequipmentid (long al_value);choose case dw_1.Getitemstatus(1,0,Primary!)
	case datamodified!
		dw_1.object.equipmentid[1] = al_value
		dw_1.SetItemStatus(1, 'equipmentid', Primary!, notModified!)
		
	case notmodified!, new!
		dw_1.object.equipmentid[1] = al_value
		dw_1.SetItemStatus(1, 0, Primary!, notModified!)
			
	case else
		dw_1.object.equipmentid[1] = al_value
		
end choose

choose case dw_device.Getitemstatus(1,0,Primary!)
	case datamodified!
		dw_device.object.equipmentid[1] = al_value
		dw_device.SetItemStatus(1, 'equipmentid', Primary!, NotModified!)
		
	case notmodified!, new!
		dw_device.object.equipmentid[1] = al_value
		dw_device.SetItemStatus(1, 0, Primary!, NotModified!)
		
	case else
		dw_device.object.equipmentid[1] = al_value
		
end choose


end subroutine

public subroutine of_clearblankrows ();long	ll_rowcount, &
		ll_ndx

string	ls_id

ll_rowcount = dw_device.rowcount()

for ll_ndx = ll_rowcount to 1 step -1
	ls_id = dw_device.object.device[ll_ndx]
	if isnull(ls_id) or len(ls_id) = 0 then
		dw_device.RowsDiscard ( ll_ndx, ll_ndx, Primary! )
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
		dw_1.object.equipment_eq_air[ll_row] = dw_1.of_getair()
		dw_1.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	end if
end if

//add  a new row at end
ll_row = dw_device.insertrow(0)
if ll_row > 0 then
	dw_device.object.equipmentid[ll_row] = al_eqid
	dw_device.SetItemStatus(ll_row, 0, Primary!, NotModified!)
end if

end subroutine

on u_tabpg_equipment_extras.create
int iCurrent
call super::create
this.dw_device=create dw_device
this.dw_1=create dw_1
this.gb_device=create gb_device
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_device
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_device
end on

on u_tabpg_equipment_extras.destroy
call super::destroy
destroy(this.dw_device)
destroy(this.dw_1)
destroy(this.gb_device)
end on

event constructor;call super::constructor;PowerObject lpoa_UpdateControls[ ]

lpoa_UpdateControls [ 1 ] = dw_1

lpoa_UpdateControls [ 2 ] = dw_device
			
of_SetUpdateObjects ( lpoa_UpdateControls )

end event

type dw_device from u_dw within u_tabpg_equipment_extras
integer x = 302
integer y = 824
integer width = 1403
integer height = 292
integer taborder = 20
string dataobject = "d_eq_auxiliarydevice"
boolean border = false
end type

event itemchanged;call super::itemchanged;Long	ll_RowCount
Long	ll_Return

ll_Return = AncestorReturnValue
ll_RowCount = THIS.RowCount ()
choose case dwo.name 
	case 'device'
		IF THIS.Find ( "device = '" + data + "'" , 1 , ll_RowCount ) > 0 THEN
			MessageBox ( "Auxiliary Device" , "The selected device has already been entered. Duplicates are not allowed." )
			ll_Return = 2
		ELSE
			if ll_RowCount = row then
				this.Event PFC_AddRow()
			end if
		END IF
end choose


RETURN ll_Return
end event

event constructor;call super::constructor;this.SetTransObject(SQLCA)

n_cst_Presentation_Equipment	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

this.visible=false
gb_device.visible=false

this.of_Setinsertable( FALSE )

end event

event pfc_addrow;call super::pfc_addrow;String	ls_name
Long		ll_Return

ll_return = AncestorReturnValue

IF ll_Return > 0 THEN
	
	this.object.equipmentid[ll_return] = this.object.equipmentid[1]

END IF

RETURN ll_Return

end event

type dw_1 from u_dw_equipmentextras within u_tabpg_equipment_extras
integer x = 64
integer y = 32
integer width = 1934
integer height = 684
integer taborder = 10
end type

event constructor;call super::constructor;this.object.equipment_eq_air.visible=0
this.object.liftgate.x=1129
this.object.sidedoor.x=1097
this.object.liftgate.visible=0
this.object.sidedoor.visible=0
this.object.Etrack.visible=0
this.object.logisticsposts.visible=0

this.object.logisticsbars.visible=0
this.object.logisticsbars_t.visible=0
this.object.straps.visible=0
this.object.straps_t.visible=0
this.object.loadbars.visible=0
this.object.loadbars_t.visible=0
this.object.chains.visible=0
this.object.chains_t.visible=0
this.object.binders.visible=0
this.object.binders_t.visible=0
this.object.tarp.visible=0
this.object.tarp_t.visible=0
this.object.powersource.visible=0
this.object.powersource_t.visible=0


end event

event ue_airchanged;call super::ue_airchanged;parent.event ue_datachanged('air',as_value)
end event

type gb_device from groupbox within u_tabpg_equipment_extras
integer x = 210
integer y = 716
integer width = 1563
integer height = 428
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Auxiliary Device"
end type

