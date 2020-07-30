$PBExportHeader$n_cst_taskmanager_selectleasetype.sru
$PBExportComments$SelectLeaseType (Task Manager from PBL map PTData) //@(*)[75818809|1004:t]<nosync>
forward
global type n_cst_taskmanager_selectleasetype from n_cst_taskmanager
end type
end forward

global type n_cst_taskmanager_selectleasetype from n_cst_taskmanager
end type
global n_cst_taskmanager_selectleasetype n_cst_taskmanager_selectleasetype

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
protected n_cst_beo_equipmentleasetype in_equipmentleasetype //@(*)[76473696|1035]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function n_cst_beo_equipmentleasetype wf_getequipmentleasetype ()
public function integer wf_setequipmentleasetype (n_cst_beo_equipmentleasetype an_equipmentleasetype)
end prototypes

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null

Choose Case Lower(as_name)
Case "equipmentleasetype"
     Return in_equipmentleasetype
End Choose

Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
any la_any
anv_parameters.GetParameterValue2(as_name, la_any)
Choose Case Lower(as_name)
   Case "equipmentleasetype"
     If IsNull(la_any) Or Not isValid(la_any) Then
           SetNull(in_equipmentleasetype)
     ElseIf ClassName(la_any) = "any" Then
           SetNull(in_equipmentleasetype)
     Else
           in_equipmentleasetype = la_any
     End If
End Choose

Return 1
//@(text)--

end function

public function n_cst_beo_equipmentleasetype wf_getequipmentleasetype ();//@(*)[76473696|1035:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
MessageBox( " Get " , "trying to get lease Type" )
return in_equipmentleasetype
//@(text)--

end function

public function integer wf_setequipmentleasetype (n_cst_beo_equipmentleasetype an_equipmentleasetype);//@(*)[76473696|1035:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>


MessageBox( "Here", "In Set Equipment lease type" )
in_equipmentleasetype = an_equipmentleasetype
return 1
//@(text)--

end function

on n_cst_taskmanager_selectleasetype.create
TriggerEvent( this, "constructor" )
end on

on n_cst_taskmanager_selectleasetype.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<Parameters>
inv_parameters.AddAttribute("EquipmentLeaseType", "n_cst_beo_equipmentleasetype", "In") //@(*)[76473696|1035]
//@(data)--

//@(data)(recreate=yes)<Navigations>
SetNavigationName( 1, "Entry to EquipmentLeaseTypes1")
SetIsEntry( 1)
SetDestinationName( 1, "w_selectequipmentleasetype")
SetWindowType( 1, response!)
SetNavigationName( 2, "EquipmentLeaseTypes to Exit1")
SetSourceName( 2, "w_selectequipmentleasetype")
SetIsExit( 2) //@(*)[]<Return Code>
//@(data)--

end event

