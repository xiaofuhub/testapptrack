$PBExportHeader$u_dw_equipmentpurchased.sru
$PBExportComments$EquipmentList (Data Control from PBL map PTData) //@(*)[34034163|986]
forward
global type u_dw_equipmentpurchased from u_dw
end type
end forward

global type u_dw_equipmentpurchased from u_dw
integer width = 2053
integer height = 192
string dataobject = "d_eq_purchased"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type
global u_dw_equipmentpurchased u_dw_equipmentpurchased

on u_dw_equipmentpurchased.create
end on

on u_dw_equipmentpurchased.destroy
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

case "purchasedate", "mileageasof" /*, "de_depdate"*/

	//Attempt to convert the text typed to a date
	compdate = lnv_string.of_SpecialDate(data)

	if isnull(compdate) then
		//Value is really invalid

	ELSE
		this.setitem(row, errcol, compdate)
	
	
		lb_Processed = TRUE

	END IF

end choose


IF NOT lb_Processed THEN
	messagebox("Edit Value", "The value you have entered is invalid.  It will be "+&
		"replaced by the previous value.")
END IF

return 3
end event

