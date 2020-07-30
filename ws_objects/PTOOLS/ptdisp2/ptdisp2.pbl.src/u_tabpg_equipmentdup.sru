$PBExportHeader$u_tabpg_equipmentdup.sru
forward
global type u_tabpg_equipmentdup from u_tabpg
end type
type dw_1 from u_dw_equipmentedit within u_tabpg_equipmentdup
end type
end forward

global type u_tabpg_equipmentdup from u_tabpg
integer width = 2464
integer height = 964
string text = "Equipment"
event ue_addrow ( long al_beforerow )
event type integer ue_deleterow ( long al_row )
dw_1 dw_1
end type
global u_tabpg_equipmentdup u_tabpg_equipmentdup

on u_tabpg_equipmentdup.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_equipmentdup.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw_equipmentedit within u_tabpg_equipmentdup
event ue_addrow ( long al_beforerow )
integer x = 27
integer y = 28
integer width = 2400
integer height = 904
integer taborder = 10
boolean bringtotop = true
end type

event ue_addrow;Parent.Event ue_AddRow ( 0 )
end event

event pfc_addrow;THIS.Event ue_AddRow ( 0 ) 
RETURN 1
end event

event pfc_insertrow;Long	ll_CurRow
// Get current row
ll_currow = this.GetRow()
if ll_currow < 0 then ll_currow = 0

Parent.Event ue_AddRow ( ll_CurRow )

RETURN 1
end event

event pfc_deleterow;Parent.event ue_DeleteRow ( THIS.GetRow ( ) )
RETURN 1
end event

