$PBExportHeader$u_dw_equipmentcompartment.sru
$PBExportComments$EquipmentList (Data Control from PBL map PTData) //@(*)[34034163|986]
forward
global type u_dw_equipmentcompartment from u_dw
end type
end forward

global type u_dw_equipmentcompartment from u_dw
integer width = 891
integer height = 276
string dataobject = "d_eq_compartment"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type
global u_dw_equipmentcompartment u_dw_equipmentcompartment

type variables

end variables

on u_dw_equipmentcompartment.create
end on

on u_dw_equipmentcompartment.destroy
end on

event constructor;call super::constructor;this.SetTransObject(SQLCA)

n_cst_Presentation_Equipment	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

end event

