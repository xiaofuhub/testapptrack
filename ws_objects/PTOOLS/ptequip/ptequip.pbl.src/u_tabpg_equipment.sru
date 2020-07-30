$PBExportHeader$u_tabpg_equipment.sru
forward
global type u_tabpg_equipment from u_tabpg
end type
end forward

global type u_tabpg_equipment from u_tabpg
integer width = 2098
integer height = 1612
long backcolor = 12632256
event ue_typechange ( string as_value )
event ue_datachanged ( string as_what,  any aa_value )
end type
global u_tabpg_equipment u_tabpg_equipment

forward prototypes
public subroutine of_typechanged (string as_eqtype)
public function long of_getmodifiedcount ()
public subroutine of_clearblankrows ()
public subroutine of_retrieve (long al_eqid)
public subroutine of_initialize (long al_eqid)
end prototypes

public subroutine of_typechanged (string as_eqtype);
end subroutine

public function long of_getmodifiedcount ();//put code in descendants

return 0
end function

public subroutine of_clearblankrows ();
end subroutine

public subroutine of_retrieve (long al_eqid);
end subroutine

public subroutine of_initialize (long al_eqid);
end subroutine

on u_tabpg_equipment.create
call super::create
end on

on u_tabpg_equipment.destroy
call super::destroy
end on

