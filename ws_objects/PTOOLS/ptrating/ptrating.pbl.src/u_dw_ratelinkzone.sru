$PBExportHeader$u_dw_ratelinkzone.sru
forward
global type u_dw_ratelinkzone from u_dw
end type
end forward

global type u_dw_ratelinkzone from u_dw
int Width=1038
int Height=172
string DataObject="d_ratelinkdestzone"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
event ue_buildfilter ( )
end type
global u_dw_ratelinkzone u_dw_ratelinkzone

type variables
DatawindowChild	idwc_zone
end variables

forward prototypes
public function datawindowchild of_getzone ()
public subroutine of_setzone (string as_value)
public function string of_getselectedzone ()
end prototypes

public function datawindowchild of_getzone ();return idwc_zone
end function

public subroutine of_setzone (string as_value);THIS.dataobject=as_value
THIS.SetTransObject ( Sqlca )
THIS.InsertRow ( 0 ) 
this.getchild("zone", idwc_zone)

end subroutine

public function string of_getselectedzone ();return this.object.zone[1]
end function

event constructor;THIS.SetTransobject(SQLCA)

of_SetDropDownSearch(true)
inv_dropdownsearch.of_Register()

this.insertrow(0)
end event

event editchanged;If IsValid(inv_dropdownsearch) Then
	inv_dropdownsearch.event pfc_editchanged(row, dwo, data)
End If	
end event

event itemfocuschanged;call super::itemfocuschanged;if IsValid(inv_dropdownsearch) then
	inv_dropdownsearch.event pfc_itemfocuschanged(row, dwo)
end if

end event

