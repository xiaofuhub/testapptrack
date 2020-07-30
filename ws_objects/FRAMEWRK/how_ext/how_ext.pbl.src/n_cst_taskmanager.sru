$PBExportHeader$n_cst_taskmanager.sru
forward
global type n_cst_taskmanager from task_n_cst_taskmanager
end type
end forward

global type n_cst_taskmanager from task_n_cst_taskmanager
end type
global n_cst_taskmanager n_cst_taskmanager

forward prototypes
public function integer navigate (string as_navigation)
end prototypes

public function integer navigate (string as_navigation);//Note : The following code is based on an excerpt from BeginTask().
//Differences : Argument navigation name, return value.

//Returns : 1 = Success, -1 = Failure (including navigation not found.)

n_cst_navigation ln_navigation
Integer	li_Return

// if a navigation was selected, then initialize it and perform the navigation
if as_Navigation > "" then 
   ln_navigation = InitNavigation(iw_frame, as_Navigation, inv_parameters)
   if isValid(ln_navigation) then
      li_Return = ln_navigation.Navigate()
   end if
end if

IF li_Return = 1 THEN
	//Success
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

on n_cst_taskmanager.create
TriggerEvent( this, "constructor" )
end on

on n_cst_taskmanager.destroy
TriggerEvent( this, "destructor" )
end on

