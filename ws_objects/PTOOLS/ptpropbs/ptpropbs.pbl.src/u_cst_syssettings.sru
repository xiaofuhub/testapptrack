$PBExportHeader$u_cst_syssettings.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings from u_base
end type
end forward

global type u_cst_syssettings from u_base
event type integer ue_setproperty ( n_cst_syssettings anv_setting )
event type integer ue_setvalue ( n_cst_syssettings anv_setting )
event type integer ue_validatecontrols ( )
end type
global u_cst_syssettings u_cst_syssettings

type variables
n_Cst_SysSettings	inv_sysSetting
end variables

forward prototypes
public function integer of_setproperty (n_cst_syssettings anv_setting)
public function integer of_setvalue (n_cst_syssettings anv_setting)
public function integer of_setrb1text (n_cst_syssettings anv_setting)
public function integer of_setrb2text (n_cst_syssettings anv_setting)
public function integer of_savevalue (n_cst_syssettings anv_setting, string as_value)
public function integer of_enable (boolean ab_enable)
end prototypes

event type integer ue_setproperty(n_cst_SysSettings anv_setting);Int	li_Return = -1

IF IsValid ( anv_setting ) THEN
	inv_syssetting = anv_setting
	li_Return = 1
END IF

RETURN li_Return


end event

event type integer ue_validatecontrols();// Implemented in decendants. 

Return 0 
end event

public function integer of_setproperty (n_cst_syssettings anv_setting);// implemented by descendents

RETURN -1
end function

public function integer of_setvalue (n_cst_syssettings anv_setting);// implemented by descendents

RETURN -1
end function

public function integer of_setrb1text (n_cst_syssettings anv_setting);// implemented by descendents

RETURN -1
end function

public function integer of_setrb2text (n_cst_syssettings anv_setting);// implemented by descendents

RETURN -1
end function

public function integer of_savevalue (n_cst_syssettings anv_setting, string as_value);// implemented by descendents

RETURN -1
end function

public function integer of_enable (boolean ab_enable);//implemeted at decendants
Return -1
end function

on u_cst_syssettings.create
call super::create
end on

on u_cst_syssettings.destroy
call super::destroy
end on

event destructor;call super::destructor;DESTROY ( inv_syssetting )
end event

