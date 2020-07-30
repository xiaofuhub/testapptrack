$PBExportHeader$n_cst_shiptype.sru
forward
global type n_cst_shiptype from n_cst_object
end type
end forward

global type n_cst_shiptype from n_cst_object
end type
global n_cst_shiptype n_cst_shiptype

forward prototypes
public function integer of_get_remit (ref string as_remit)
public function boolean of_getintermodal ()
public function boolean of_isbrokerage ()
public function boolean of_isdivision ()
end prototypes

public function integer of_get_remit (ref string as_remit);integer li_ndx
string ls_remit, ls_work

setnull(as_remit)

//Some sort of ready verification?
	for li_ndx = 1 to 5
		ls_work = ids_data.getitemstring(1, "st_remit_0" + string(li_ndx))
		ls_work = substitute(ls_work, null_str, "")
		ls_remit += ls_work
		if li_ndx < 5 then ls_remit += "~r~n"
	next
	as_remit = ls_remit
	return 1
//
end function

public function boolean of_getintermodal ();Boolean	lb_Return
IF ids_Data.RowCount ( ) > 0 THEN
	lb_Return = ids_data.getitemstring(1, "intermodal" ) = "T"
END IF

RETURN lb_Return


end function

public function boolean of_isbrokerage ();Boolean	lb_Return
IF ids_Data.RowCount ( ) > 0 THEN
	lb_Return = ids_data.getitemstring(1, "st_brokerage" ) = "T"
END IF

RETURN lb_Return
end function

public function boolean of_isdivision ();Boolean	lb_Return
IF ids_Data.RowCount ( ) > 0 THEN
	if ids_data.getitemstring(1, "st_typeonly" ) = "T" then
		lb_Return = false
	else
		lb_Return = true
	end if
END IF

RETURN lb_Return
end function

event constructor;call super::constructor;ids_data.dataobject = "d_shiptype_list"
end event

on n_cst_shiptype.create
TriggerEvent( this, "constructor" )
end on

on n_cst_shiptype.destroy
TriggerEvent( this, "destructor" )
end on

