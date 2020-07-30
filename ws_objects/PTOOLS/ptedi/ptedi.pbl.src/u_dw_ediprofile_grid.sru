$PBExportHeader$u_dw_ediprofile_grid.sru
forward
global type u_dw_ediprofile_grid from u_dw
end type
end forward

global type u_dw_ediprofile_grid from u_dw
integer width = 2894
integer height = 320
string dataobject = "d_ediprofile_grid"
boolean hscrollbar = true
boolean border = false
boolean livescroll = false
event ue_keydown pbm_dwnkey
event ue_clearblankrows ( )
end type
global u_dw_ediprofile_grid u_dw_ediprofile_grid

forward prototypes
public function long of_retrieve (long al_coid)
public subroutine of_settemplate (string as_template)
end prototypes

event ue_keydown;Int li_rtn 
String ls_Filepath, ls_Filename
		
IF key = KeyDownArrow! THEN
	if upper(this.getcolumnname( )) = 'TEMPLATE' THEN
		li_rtn = GetFileOpenName("Select File",ls_Filepath, ls_Filename, "", &
			 + "All Files (*.*), *.*", &
			 "C:\", 18)
		IF li_rtn > 0 THEN  	 
			this.of_Settemplate(ls_FilePath)
		END IF
	END IF
END IF

RETURN li_rtn


end event

event ue_clearblankrows();if this.accepttext() = 1 then
	this.setredraw(false)
	
	Long	ll_RowCount
	Long	i
	
	ll_RowCount = THIS.RowCount ( )
	FOR i = ll_RowCount TO 1 STEP -1
		IF IsNull (  THIS.GetItemNumber ( i , "companyid", Primary!, false )  ) or &
			THIS.GetItemNumber ( i , "companyid", Primary!, false ) = 0 THEN
			THIS.RowsDiscard ( i, i, Primary! ) 
		END IF	
	NEXT
		
	ll_RowCount = THIS.FilteredCount ( )
	FOR i = ll_RowCount TO 1 STEP -1
		IF IsNull (  THIS.GetItemNumber ( i , "companyid", Filter!, false )  ) or &
			THIS.GetItemNumber ( i , "companyid", Filter!, false ) = 0 THEN
			THIS.RowsDiscard ( i, i, Filter! ) 
		END IF	
	NEXT
		
	this.setredraw(true)
end if
end event

public function long of_retrieve (long al_coid);return this.retrieve( al_coid )
end function

public subroutine of_settemplate (string as_template);long	ll_row

ll_row = this.getrow()

if ll_row > 0 then
	this.object.template[ll_row] = as_template
end if
end subroutine

on u_dw_ediprofile_grid.create
end on

on u_dw_ediprofile_grid.destroy
end on

event constructor;call super::constructor;this.SetTransobject(SQLCA)
end event

