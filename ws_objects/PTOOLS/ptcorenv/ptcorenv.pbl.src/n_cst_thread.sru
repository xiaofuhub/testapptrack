$PBExportHeader$n_cst_thread.sru
forward
global type n_cst_thread from n_base
end type
end forward

global type n_cst_thread from n_base
end type
global n_cst_thread n_cst_thread

type variables
Protected:
Integer	ii_progress
String	is_RegisterId
String	is_Description = "Unknown process" //should be set on decendents constructor
n_cst_threadmanager	inv_mgr
n_cst_threadComm		inv_ThreadComm

end variables

forward prototypes
public function integer of_setmanager (readonly n_cst_threadmanager anv_mgr)
public function integer of_done (boolean ab_success)
public function integer of_executejob (n_cst_threadjob anv_job)
public function integer of_setregisterid (string as_registerid)
public function string of_getregisterid ()
public function integer of_setthreadcomm (n_cst_threadcomm anv_threadcomm)
public function string of_getdescription ()
end prototypes

public function integer of_setmanager (readonly n_cst_threadmanager anv_mgr);inv_mgr = anv_mgr
Return 1
end function

public function integer of_done (boolean ab_success);IF isValid(inv_Mgr) THEN
	inv_Mgr.of_Done(is_RegisterId, ab_Success)
END IF

Return 1
end function

public function integer of_executejob (n_cst_threadjob anv_job);//Implemented at decendents
Integer	li_Return = 0


Return li_Return
end function

public function integer of_setregisterid (string as_registerid);is_RegisterId = as_registerId

Return 1
end function

public function string of_getregisterid ();Return is_RegisterId
end function

public function integer of_setthreadcomm (n_cst_threadcomm anv_threadcomm);inv_ThreadComm = anv_ThreadComm

//give the threadContainer on the Manager a reference to the threadcomm object
IF isValid(inv_Mgr) THEN
	inv_Mgr.of_SetThreadComm(is_RegisterId, anv_ThreadComm)
END IF

Return 1
end function

public function string of_getdescription ();Return is_Description
end function

on n_cst_thread.create
call super::create
end on

on n_cst_thread.destroy
call super::destroy
end on

event destructor;call super::destructor;//Destroy the comminicatin broker
IF isValid(inv_ThreadComm) THEN
	Destroy(inv_ThreadComm)
END IF
end event

