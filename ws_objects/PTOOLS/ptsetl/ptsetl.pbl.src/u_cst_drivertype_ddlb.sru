$PBExportHeader$u_cst_drivertype_ddlb.sru
forward
global type u_cst_drivertype_ddlb from dropdownlistbox
end type
end forward

global type u_cst_drivertype_ddlb from dropdownlistbox
int Width=704
int Height=448
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_cst_drivertype_ddlb u_cst_drivertype_ddlb

type variables
integer	ii_drivertype
end variables

forward prototypes
public subroutine of_setdrivertype (integer ai_value)
public function integer of_getdrivertype ()
public function string of_getdriverlabel ()
end prototypes

public subroutine of_setdrivertype (integer ai_value);ii_drivertype = ai_value
end subroutine

public function integer of_getdrivertype ();return ii_drivertype
end function

public function string of_getdriverlabel ();string	ls_label

choose case this.of_getdrivertype()
	case 0	//n_cst_Constants.ci_Employee_OwnerOperator 
		ls_label = "Owner Operator"
	CASE 1	//n_cst_Constants.ci_Employee_CompanyDriver
		ls_label = "Company Driver"
	CASE 2	//n_cst_Constants.ci_Employee_3rdParty
		ls_label = "Third Party"
	CASE 3	//n_cst_Constants.ci_Employee_Casual
		ls_label = "Casual"
end choose

return ls_label
end function

event constructor;
this.additem ( "Owner Operator" ) // 0
this.additem ( "Company" )			// 1
this.additem ( "Third Party" )		// 2
this.additem ( "Casual" )			// 3

This.SelectItem ( 1 )
This.Event SelectionChanged ( 1 )
end event

event selectionchanged;choose case index
	CASE 1
		ii_drivertype = n_cst_Constants.ci_Employee_OwnerOperator 
	CASE 2
		ii_drivertype = n_cst_Constants.ci_Employee_CompanyDriver
	CASE 3
		ii_drivertype = n_cst_Constants.ci_Employee_3rdParty
	CASE 4
		ii_drivertype = n_cst_Constants.ci_Employee_Casual
end choose

end event

