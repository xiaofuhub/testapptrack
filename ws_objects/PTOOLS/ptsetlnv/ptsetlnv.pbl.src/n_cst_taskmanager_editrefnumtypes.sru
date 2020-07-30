$PBExportHeader$n_cst_taskmanager_editrefnumtypes.sru
$PBExportComments$EditRefnumTypes (Task Manager from PBL map PTSetl) //@(*)[73255157|664:t]<nosync>
forward
global type n_cst_taskmanager_editrefnumtypes from n_cst_taskmanager
end type
end forward

global type n_cst_taskmanager_editrefnumtypes from n_cst_taskmanager
end type
global n_cst_taskmanager_editrefnumtypes n_cst_taskmanager_editrefnumtypes

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

on n_cst_taskmanager_editrefnumtypes.create
TriggerEvent(this, "constructor")
end on

on n_cst_taskmanager_editrefnumtypes.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<Parameters>
//@(data)--

//@(data)(recreate=yes)<Navigations>
SetNavigationName( 1, "Entry to RefnumTypes1")
SetIsEntry( 1)
SetDestinationName( 1, "w_refnumtypes")
SetWindowType( 1, response!)
SetNavigationName( 2, "RefnumTypes to Exit1")
SetSourceName( 2, "w_refnumtypes")
SetIsExit( 2) //@(*)[]<Return Code>
SetCloseSource( 2, TRUE)
//@(data)--

end event

