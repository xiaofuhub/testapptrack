$PBExportHeader$u_dw_equipmentdimensions.sru
$PBExportComments$EquipmentList (Data Control from PBL map PTData) //@(*)[34034163|986]
forward
global type u_dw_equipmentdimensions from u_dw
end type
end forward

global type u_dw_equipmentdimensions from u_dw
integer width = 1929
integer height = 1120
string dataobject = "d_eq_dimensions"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
event ue_lengthchanged ( decimal ac_value )
event ue_widthchanged ( decimal ac_value )
end type
global u_dw_equipmentdimensions u_dw_equipmentdimensions

type variables
private:

decimal	ic_length,&
			ic_width
end variables

forward prototypes
public subroutine of_setlength (decimal ac_value)
public subroutine of_setwidth (decimal ac_value)
public function decimal of_getlength ()
public function decimal of_getwidth ()
end prototypes

public subroutine of_setlength (decimal ac_value);ic_length = ac_value
end subroutine

public subroutine of_setwidth (decimal ac_value);ic_width = ac_value
end subroutine

public function decimal of_getlength ();return ic_length
end function

public function decimal of_getwidth ();return ic_width
end function

on u_dw_equipmentdimensions.create
end on

on u_dw_equipmentdimensions.destroy
end on

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

event itemchanged;call super::itemchanged;Long	ll_Return

ll_Return = AncestorReturnValue

choose case dwo.name
		
	case "equipment_eq_length"
		If Dec ( Data ) > 99.9 THEN
			ll_Return = 1 
		ELSE
			this.event ue_lengthchanged(dec(data))	
			this.SetItemStatus(row, "equipment_eq_length", Primary!, NotModified!)
		END IF
		
	case "equipment_eq_height"
		If Dec ( Data ) > 9999.9 THEN
			ll_Return = 1 
		ELSE		
			this.event ue_widthchanged(dec(data))
			this.SetItemStatus(row, "equipment_eq_height", Primary!, NotModified!)
		END IF
		
	CASE "insideheight" , "insidewidth" , "doorheight" , "doorwidth" ,"frontdecklength" , "reardecklength" ,"welllength"
		If Dec ( Data ) > 999 THEN
			ll_Return = 1 
		END IF
		
end choose


RETURN ll_Return
end event

