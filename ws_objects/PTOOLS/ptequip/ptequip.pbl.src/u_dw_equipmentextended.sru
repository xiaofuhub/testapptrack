$PBExportHeader$u_dw_equipmentextended.sru
$PBExportComments$EquipmentList (Data Control from PBL map PTData) //@(*)[34034163|986]
forward
global type u_dw_equipmentextended from u_dw
end type
end forward

global type u_dw_equipmentextended from u_dw
integer width = 2030
integer height = 1284
string dataobject = "d_eq_detail"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
event ue_axlechanged ( long al_value )
event ue_noteschanged ( string as_value )
end type
global u_dw_equipmentextended u_dw_equipmentextended

type variables
private:

long		il_axle

string	is_note
end variables

forward prototypes
public subroutine of_setaxle (long al_value)
public subroutine of_setnote (string as_value)
public function string of_getnote ()
public function long of_getaxle ()
end prototypes

public subroutine of_setaxle (long al_value);il_axle = al_value
end subroutine

public subroutine of_setnote (string as_value);is_note = as_value
end subroutine

public function string of_getnote ();return is_note
end function

public function long of_getaxle ();return il_axle
end function

on u_dw_equipmentextended.create
end on

on u_dw_equipmentextended.destroy
end on

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

event itemerror;call super::itemerror;Boolean	lb_Processed
string errcol
errcol = dwo.name
n_cst_string lnv_string

date compdate
time comptime

choose case errcol

case "outofservicedate", "inservicedate" /*, "de_depdate"*/

	//Attempt to convert the text typed to a date
	compdate = lnv_string.of_SpecialDate(data)

	if isnull(compdate) then
		//Value is really invalid

	ELSE
		this.setitem(row, errcol, compdate)
	
	
		lb_Processed = TRUE

	END IF

case "outofservicetime", "inservicetime"

	//Attempt to convert the text typed to a time
	comptime = lnv_string.of_SpecialTime(data)

	if isnull(comptime) then
		//Value is really invalid

	ELSE
		this.setitem(row, errcol, comptime)
	
		lb_Processed = TRUE

	END IF

end choose


IF NOT lb_Processed THEN
	messagebox("Edit Value", "The value you have entered is invalid.  It will be "+&
		"replaced by the previous value.")
END IF

return 3
end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case "equipment_eq_axles"
		this.event ue_axlechanged(long(data))
		this.SetItemStatus(row, "equipment_eq_axles", Primary!, NotModified!)
				
	case "equipment_notes"
		this.event ue_noteschanged(data)
		this.SetItemStatus(row, "equipment_notes", Primary!, NotModified!)
		
end choose
end event

