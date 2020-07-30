$PBExportHeader$u_cst_syssettings_employee_populate.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings_employee_populate from u_cst_syssettings_generic_populate
end type
end forward

global type u_cst_syssettings_employee_populate from u_cst_syssettings_generic_populate
end type
global u_cst_syssettings_employee_populate u_cst_syssettings_employee_populate

on u_cst_syssettings_employee_populate.create
int iCurrent
call super::create
end on

on u_cst_syssettings_employee_populate.destroy
call super::destroy
end on

event ue_setproperty;call super::ue_setproperty;Long	lla_Ids[]
Long	ll_Ctr
Long	ll_Count
String	ls_Name

n_Cst_EmployeeManager	lnv_EmpMan

anv_setting.of_GetValue ( lla_Ids )


ll_Count = UpperBound(lla_Ids)


FOR ll_Ctr = 1 TO ll_Count

	lnv_EmpMan.of_describeemployee( lla_Ids[ll_Ctr] , ls_Name)
	uo_1.of_insertitem( ls_Name, lla_Ids[ll_Ctr] )
NEXT

uo_1.event ue_SetColumnHeader(inv_syssetting.of_getcolheader( ))


RETURN 1


end event

type uo_1 from u_cst_syssettings_generic_populate`uo_1 within u_cst_syssettings_employee_populate
end type

event uo_1::ue_addrow;Long	ll_EmpID
Int	li_Return = 1
Long	ll_Row
String	ls_EmpName
s_emp_info find_ems

n_Cst_EmployeeManager	lnv_EmpMan

find_ems.em_type = 1
find_ems.em_status = "K"

openwithparm(w_emp_list, find_ems)
find_ems = message.powerobjectparm

ll_EmpID = find_ems.em_id

if ll_EmpID > 0 then
	IF dw_1.Find ( "hidden_values = '" +String ( ll_EmpID ) +"'", 1 , dw_1.RowCount ( ) ) > 0 THEN
		MessageBox ( "Add Employee" , "The employee you selected already exists." )
		li_Return = 0 
	END IF
END IF

	
IF li_Return = 1 THEN
	dw_1.SetReDraw(False)
	ll_Row = dw_1.insertRow( 0 )
	dw_1.Modify("Values.Edit.DisplayOnly = 'Yes'")
	dw_1.ScrollToRow(ll_Row)
	dw_1.SetRow(ll_Row)
	dw_1.SetFocus()
	lnv_EmpMan.of_Describeemployee( ll_EmpID, ls_EmpName )
	dw_1.SetItem ( ll_Row , "hidden_values" , String ( ll_EmpID ) )
	dw_1.SetItem ( ll_Row , "values" , String ( ls_EmpName ) ) 
	dw_1.SetRedraw (TRUE)
	event ue_savevalues("")
END IF
	
	
RETURN li_Return
end event

event uo_1::ue_savevalues;Long	lla_EmpIDS[]
Long	ll_Temp
Long	ll_EmpCount
Long	i,li_Count

li_Count = dw_1.RowCOunt ( )
FOR i = 1 TO li_Count
	ll_Temp= Long ( dw_1.GetItemString ( i,"hidden_values") )
	IF ll_Temp > 0 THEN
		ll_EmpCount ++
		lla_EmpIDS[ll_EmpCount] = ll_Temp 
	END IF

	
NEXT

inv_syssetting.of_Savevalues( lla_EmpIDS )
end event

event uo_1::ue_removerow;// override
Long	ll_Row
ll_Row = dw_1.GetRow ( )
IF ll_Row > 0 THEN
	dw_1.SelectRow ( ll_Row , TRUE ) 
	IF MessageBox ("Delete Row" , "Are you sure you want to delete the selected row?" , Question!, YesNo! , 1 ) = 1 THEN
		Parent.event ue_deleterow( dw_1.GetRow ( ) ) 
		THIS.event ue_savevalues( "" ) // "" will pull the values from the dw
	END IF		
	
	dw_1.SelectRow ( 0 , FALSE ) 
END IF




end event

