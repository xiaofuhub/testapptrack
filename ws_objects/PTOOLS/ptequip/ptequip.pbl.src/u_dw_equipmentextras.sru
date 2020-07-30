$PBExportHeader$u_dw_equipmentextras.sru
$PBExportComments$EquipmentList (Data Control from PBL map PTData) //@(*)[34034163|986]
forward
global type u_dw_equipmentextras from u_dw
end type
end forward

global type u_dw_equipmentextras from u_dw
integer width = 1989
integer height = 848
string dataobject = "d_eq_extras"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
event ue_airchanged ( string as_value )
end type
global u_dw_equipmentextras u_dw_equipmentextras

type variables
private:

string	is_air
end variables

forward prototypes
public subroutine of_setair (string as_value)
public function string of_getair ()
end prototypes

public subroutine of_setair (string as_value);is_air = as_value
end subroutine

public function string of_getair ();return is_air
end function

on u_dw_equipmentextras.create
end on

on u_dw_equipmentextras.destroy
end on

event constructor;call super::constructor;this.SetTransObject(SQLCA)

n_cst_Presentation_Equipment	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

end event

event itemchanged;call super::itemchanged;choose case dwo.name
		
	case "equipment_eq_air"
		this.event ue_airchanged(data)
		this.SetItemStatus(row, "equipment_eq_air", Primary!, NotModified!)
		
end choose

end event

