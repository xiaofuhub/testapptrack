$PBExportHeader$n_cst_msg.sru
forward
global type n_cst_msg from nonvisualobject
end type
end forward

global type n_cst_msg from nonvisualobject autoinstantiate
end type

type variables
protected:
s_parm istra_parms[]
end variables

forward prototypes
public function integer of_get_count ()
public function integer of_get_parm (integer ai_ndx, ref s_parm astr_parm)
public function integer of_add_parm (s_parm astr_parm)
public function integer of_get_parm (string as_label, ref s_parm astr_parm)
public subroutine of_reset ()
end prototypes

public function integer of_get_count ();return upperbound(istra_parms)
end function

public function integer of_get_parm (integer ai_ndx, ref s_parm astr_parm);//Returns:  > 0 : The index requested (ai_Ndx), if that index was valid
//			0 if no matching entry is found

if upperbound(istra_parms) >= ai_ndx then
	astr_parm = istra_parms[ai_ndx]
	return ai_ndx
else
	return 0
end if
end function

public function integer of_add_parm (s_parm astr_parm);istra_parms[upperbound(istra_parms) + 1] = astr_parm

return 1
end function

public function integer of_get_parm (string as_label, ref s_parm astr_parm);//Returns:  > 0 : The index of the first entry matching as_Label
//			0 if no matching entry is found

integer li_ndx

for li_ndx = 1 to upperbound(istra_parms)
	if upper(istra_parms[li_ndx].is_label) = upper(as_label) then
		astr_parm = istra_parms[li_ndx]
		return li_ndx
	end if
next

return 0
end function

public subroutine of_reset ();s_parm lstra_parms[]

istra_parms = lstra_parms
end subroutine

on n_cst_msg.create
TriggerEvent( this, "constructor" )
end on

on n_cst_msg.destroy
TriggerEvent( this, "destructor" )
end on

