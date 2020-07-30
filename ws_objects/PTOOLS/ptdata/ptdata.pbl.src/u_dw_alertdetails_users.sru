$PBExportHeader$u_dw_alertdetails_users.sru
forward
global type u_dw_alertdetails_users from u_dw
end type
end forward

global type u_dw_alertdetails_users from u_dw
integer width = 1733
integer height = 632
end type
global u_dw_alertdetails_users u_dw_alertdetails_users

forward prototypes
public function integer of_getselectedrows (ref long ala_rows[])
end prototypes

public function integer of_getselectedrows (ref long ala_rows[]);Long	ll_Selected = 0
long	ll_Counter = 0
Long	lla_SelectedRows[]

//Loop and count the number of selected rows.
DO
	ll_selected = THIS.GetSelectedRow ( ll_selected )
	IF ll_selected > 0 THEN
		ll_counter++
		lla_SelectedRows[ll_counter] = ll_selected
	END IF
LOOP WHILE ll_selected > 0

ala_Rows[] = lla_SelectedRows

RETURN UpperBound ( ala_Rows )

end function

on u_dw_alertdetails_users.create
end on

on u_dw_alertdetails_users.destroy
end on

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA ) 
THIS.of_setrowselect ( TRUE )
inv_Rowselect.of_Setstyle( inv_rowselect.extended )
THIS.of_Setinsertable( FALSE )
THIS.of_SetDeleteable( FALSE )
THIS.of_Setautosort( TRUE )
THIS.of_Setautofilter( TRUE )
end event

