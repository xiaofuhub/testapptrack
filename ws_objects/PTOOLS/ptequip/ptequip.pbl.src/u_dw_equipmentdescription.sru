$PBExportHeader$u_dw_equipmentdescription.sru
$PBExportComments$EquipmentList (Data Control from PBL map PTData) //@(*)[34034163|986]
forward
global type u_dw_equipmentdescription from u_dw
end type
end forward

global type u_dw_equipmentdescription from u_dw
integer width = 2245
integer height = 632
string dataobject = "d_eq_description"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type
global u_dw_equipmentdescription u_dw_equipmentdescription

type variables
private:

string	is_type

end variables

forward prototypes
public subroutine of_settype (string as_value)
end prototypes

public subroutine of_settype (string as_value);is_type = as_value

//reset display

n_cst_Presentation_Equipment	lnv_Presentation

lnv_Presentation.of_SetPresentation ( This, is_type)

end subroutine

on u_dw_equipmentdescription.create
end on

on u_dw_equipmentdescription.destroy
end on

event constructor;call super::constructor;this.SetTransObject(SQLCA)

n_cst_Presentation_Equipment	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

end event

