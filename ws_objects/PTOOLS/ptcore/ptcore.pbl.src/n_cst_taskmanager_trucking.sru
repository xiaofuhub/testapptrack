$PBExportHeader$n_cst_taskmanager_trucking.sru
$PBExportComments$Trucking (Task Manager from PBL map PTApp) //@(*)[8916340|47:t]<nosync>
forward
global type n_cst_taskmanager_trucking from n_cst_taskmanager
end type
end forward

global type n_cst_taskmanager_trucking from n_cst_taskmanager
end type
global n_cst_taskmanager_trucking n_cst_taskmanager_trucking

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
end prototypes

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null


Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>

Return 1
//@(text)--

end function

on n_cst_taskmanager_trucking.create
TriggerEvent(this, "constructor")
end on

on n_cst_taskmanager_trucking.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<Parameters>
//@(data)--

//@(data)(recreate=yes)<Navigations>
SetNavigationName( 1, "Entry to EditSettlements1")
SetIsEntry( 1)
SetDestinationSubtask( 1, "n_cst_taskmanager_editsettlements")
SetNavigationName( 2, "EditSettlements to Exit1")
SetSourceSubtask( 2, "n_cst_taskmanager_editsettlements")
SetIsExit( 2) //@(*)[]<Return Code>
SetNavigationName( 3, "Entry to EditRateTypes1")
SetIsEntry( 3)
SetDestinationSubtask( 3, "n_cst_taskmanager_editratetypes")
SetNavigationName( 4, "EditRateTypes to Exit1")
SetSourceSubtask( 4, "n_cst_taskmanager_editratetypes")
SetIsExit( 4) //@(*)[]<Return Code>
SetNavigationName( 5, "Entry to EditAmountTypes1")
SetIsEntry( 5)
SetDestinationSubtask( 5, "n_cst_taskmanager_editamounttypes")
SetNavigationName( 6, "EditAmountTypes to Exit1")
SetSourceSubtask( 6, "n_cst_taskmanager_editamounttypes")
SetIsExit( 6) //@(*)[]<Return Code>
SetNavigationName( 7, "Entry to ContainerTest1")
SetIsEntry( 7)
SetDestinationSubtask( 7, "n_cst_taskmanager_containertest")
SetNavigationName( 8, "ContainerTest to Exit1")
SetSourceSubtask( 8, "n_cst_taskmanager_containertest")
SetIsExit( 8) //@(*)[]<Return Code>
SetNavigationName( 9, "Entry to EditRefnumTypes1")
SetIsEntry( 9)
SetDestinationSubtask( 9, "n_cst_taskmanager_editrefnumtypes")
SetNavigationName( 10, "EditRefnumTypes to Exit1")
SetSourceSubtask( 10, "n_cst_taskmanager_editrefnumtypes")
SetIsExit( 10) //@(*)[]<Return Code>
SetNavigationName( 11, "Entry to ImportAmounts1")
SetIsEntry( 11)
SetDestinationSubtask( 11, "n_cst_taskmanager_importamounts")
SetNavigationName( 12, "ImportAmounts to Exit1")
SetSourceSubtask( 12, "n_cst_taskmanager_importamounts")
SetIsExit( 12) //@(*)[]<Return Code>
SetNavigationName( 13, "Entry to EquipmentSummary1")
SetIsEntry( 13)
SetDestinationSubtask( 13, "n_cst_taskmanager_equipmentsummary")
SetNavigationName( 14, "EquipmentSummary to Exit1")
SetSourceSubtask( 14, "n_cst_taskmanager_equipmentsummary")
SetIsExit( 14) //@(*)[]<Return Code>
//@(data)--

end event

