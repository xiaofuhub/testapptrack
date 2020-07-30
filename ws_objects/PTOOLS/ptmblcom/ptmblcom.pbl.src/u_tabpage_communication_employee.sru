$PBExportHeader$u_tabpage_communication_employee.sru
forward
global type u_tabpage_communication_employee from u_tabpg
end type
type dw_employee from u_dw_communication_setup_employee within u_tabpage_communication_employee
end type
end forward

global type u_tabpage_communication_employee from u_tabpg
int Width=3131
int Height=928
dw_employee dw_employee
end type
global u_tabpage_communication_employee u_tabpage_communication_employee

on u_tabpage_communication_employee.create
int iCurrent
call super::create
this.dw_employee=create dw_employee
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_employee
end on

on u_tabpage_communication_employee.destroy
call super::destroy
destroy(this.dw_employee)
end on

event constructor;call super::constructor;//Extending Ancestor


//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_employee
inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
	ldo_Reference.Y + ldo_Reference.Height + li_Border )

//Register resizable controls
This.inv_resize.of_Register ( dw_employee, 'ScaleToRight&Bottom' )

//Trigger resize event to perform initial resize of tabpage contents
This.TriggerEvent ( "Resize" )


RETURN AncestorReturnValue
end event

type dw_employee from u_dw_communication_setup_employee within u_tabpage_communication_employee
event ue_employee_added ( )
int X=37
int Y=28
int Width=3026
int TabOrder=10
boolean BringToTop=true
string DataObject="d_communication_setup_employee"
boolean HScrollBar=true
end type

event ue_employee_added;Long	ll_Row


s_emp_info find_ems
		
ll_Row = THIS.GetRow () 
IF ll_Row > 0 THEN
	openwithparm(w_emp_list, find_ems)

	find_ems = message.powerobjectparm
	
	if find_ems.em_id > 0 then
	
		THIS.SetItem ( ll_Row , "employees_em_fn" ,  find_ems.em_fn )
		THIS.SetItem ( ll_Row , "employees_em_mn" , find_ems.em_mn )
		THIS.SetItem ( ll_Row , "employees_em_ln" ,  find_ems.em_ln )
		THIS.SetItem ( ll_Row , "employeeid" ,  find_ems.em_id )
		THIS.SetItem ( ll_Row , "type", n_cst_constants.cs_communicationDevice_Qualcomm )
	ELSE
		THIS.Event pfc_DeleteRow ( )
	end if
END IF
end event

event pfc_addrow;call super::pfc_addrow;Long	ll_Return

ll_Return = AncestorReturnValue

IF ll_Return > 0 THEN
//	this.ScrollToRow ( ll_Return ) 
	THIS.SetRow ( ll_Return )
	EVENT ue_Employee_Added( )
END IF

RETURN ll_Return
end event

event ue_autofilter;call super::ue_autofilter;Int	li_Return 

li_Return = AncestorReturnValue 

//IF li_Return = success  THEN
	IF inv_Filter.of_SetExclude ( { "employees_em_fn" , "employees_em_mn" , "employees_em_ln" , "employeeid" , "equipmentid" } ) = 1 THEN
//		li_Return = success
	END IF
//END IF

RETURN li_Return
end event

event pfc_insertrow;call super::pfc_insertrow;Long	ll_Return

ll_Return = AncestorReturnValue

IF ll_Return > 0 THEN
//	this.ScrollToRow ( ll_Return ) 
	THIS.SetRow ( ll_Return )
	EVENT ue_Employee_Added( )
END IF

RETURN ll_Return
end event

