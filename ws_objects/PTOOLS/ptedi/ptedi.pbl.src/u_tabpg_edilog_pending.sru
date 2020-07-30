$PBExportHeader$u_tabpg_edilog_pending.sru
forward
global type u_tabpg_edilog_pending from u_tabpg_edilog
end type
end forward

global type u_tabpg_edilog_pending from u_tabpg_edilog
string text = "Pending"
end type
global u_tabpg_edilog_pending u_tabpg_edilog_pending

forward prototypes
public function long of_getselectedid (ref long ala_id[])
public subroutine of_send ()
public subroutine of_delete (long ala_id[])
end prototypes

public function long of_getselectedid (ref long ala_id[]);//override ancestor and send row number, id doesn't make sense for this table
long	ll_row, &
		ll_rowcount, &
		ll_count, &
		lla_id[]
		
ll_rowcount = dw_1.rowcount()

for ll_row = 1 to ll_rowcount
	if dw_1.isSelected(ll_row) then
		ll_count ++
		lla_id[ll_count] = ll_row
	end if
next
	
if upperbound(lla_id) > 0 then
	ala_id = lla_id
end if

return upperbound(ala_id)

end function

public subroutine of_send ();messagebox('Send Pending','Function not allowed.')

end subroutine

public subroutine of_delete (long ala_id[]);//ignore argument, just delete selected row
long 	ll_ndx, &
		ll_count

n_cst_Privileges	lnv_Privileges
n_cst_LicenseManager	lnv_LicenseManager

ll_count = upperbound(ala_id)

IF lnv_Privileges.of_HasAdministrativeRights ( ) = TRUE THEN
	if messagebox("Delete EDI", "Are you sure you want to delete the selected rows?", Question!, Yesno!) = 1 then
		for ll_ndx = ll_count to 1 step -1
			dw_1.deleterow(ala_id[ll_ndx])
		next
		if dw_1.update(true,true) = 1 then
			commit;
		end if
		
	end if
		
ELSE
	MessageBox ( "Delete Pending", lnv_Privileges.of_GetRestrictMessage ( ) )
END IF

dw_1.Selectrow(0,false)
	

end subroutine

on u_tabpg_edilog_pending.create
call super::create
end on

on u_tabpg_edilog_pending.destroy
call super::destroy
end on

event constructor;call super::constructor;dw_1.SetTransObject(SQLCA)
dw_1.retrieve()

//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_1
inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
	ldo_Reference.Y + ldo_Reference.Height + li_Border )

//Register resizable controls
This.inv_resize.of_Register ( dw_1, 'ScaleToRight&Bottom' )

//Trigger resize event to perform initial resize of tabpage contents
This.TriggerEvent ( "Resize" )


RETURN AncestorReturnValue
end event

type dw_1 from u_tabpg_edilog`dw_1 within u_tabpg_edilog_pending
integer width = 2345
integer height = 1520
string dataobject = "d_edipending_grid"
end type

