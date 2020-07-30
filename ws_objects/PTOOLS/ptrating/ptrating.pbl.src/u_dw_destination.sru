$PBExportHeader$u_dw_destination.sru
forward
global type u_dw_destination from u_dw
end type
end forward

global type u_dw_destination from u_dw
integer width = 791
integer height = 172
string dataobject = "d_ratelinkdestzone"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
event ue_buildfilter ( )
event itemchanging pbm_dwnchanging
end type
global u_dw_destination u_dw_destination

type variables

DatawindowChild	idwc_Companies,&
		idwc_originzonename, &
		idwc_destinationzonename
end variables

forward prototypes
public function datawindowchild of_getdestinationzone ()
end prototypes

public function datawindowchild of_getdestinationzone ();return idwc_destinationzonename
end function

event constructor;THIS.SetTransObject ( Sqlca )
THIS.InsertRow ( 0 ) 
this.getchild("zone", idwc_destinationzonename)

//added by dan
of_SetDropDownSearch( TRUE )
inv_dropdownsearch.of_AddColumn( ) 


end event

on u_dw_destination.create
end on

on u_dw_destination.destroy
end on

event editchanged;call super::editchanged;//added by dan
If IsValid(inv_dropdownsearch) Then
	inv_dropdownsearch.event pfc_editchanged(row, dwo, data)
End If	
end event

event itemfocuschanged;call super::itemfocuschanged;//added by dan
IF IsValid(this.inv_dropdownsearch) THEN
   this.inv_dropdownsearch.Event pfc_ItemFocusChanged (row, dwo)
END IF
end event

