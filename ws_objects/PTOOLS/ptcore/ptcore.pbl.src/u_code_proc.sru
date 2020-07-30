$PBExportHeader$u_code_proc.sru
forward
global type u_code_proc from nonvisualobject
end type
end forward

global type u_code_proc from nonvisualobject autoinstantiate
end type

type variables
protected:
string cstr = ""
end variables

forward prototypes
public function string process_a (string target, integer ndx)
public function string process_b (string target, integer ndx)
public function integer process_c (string target, integer ndx)
public function string process_d (string target, integer ndx)
public function string process_e (string target, integer ndx)
public function long process_f (string target, integer ndx)
public function long process_g (string target, integer ndx)
end prototypes

public function string process_a (string target, integer ndx);return ""
end function

public function string process_b (string target, integer ndx);return ""
end function

public function integer process_c (string target, integer ndx);return 0
end function

public function string process_d (string target, integer ndx);return ""
end function

public function string process_e (string target, integer ndx);return ""
end function

public function long process_f (string target, integer ndx);return 0
end function

public function long process_g (string target, integer ndx);return 0
end function

on u_code_proc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_code_proc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

