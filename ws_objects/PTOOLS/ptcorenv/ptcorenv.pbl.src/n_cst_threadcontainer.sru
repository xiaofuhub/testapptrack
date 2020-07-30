$PBExportHeader$n_cst_threadcontainer.sru
forward
global type n_cst_threadcontainer from n_base
end type
end forward

global type n_cst_threadcontainer from n_base
end type
global n_cst_threadcontainer n_cst_threadcontainer

type variables
Private:
n_cst_Thread	inv_Thread
String			is_Description
String			is_ClassName
String			is_RegisterId

Boolean			ib_Busy

n_cst_ThreadComm	inv_ThreadComm
end variables

forward prototypes
public function string of_getclassname ()
public function string of_getregisterid ()
public function boolean of_busy ()
public function integer of_setbusy (boolean ab_busy)
public function integer of_setclassname (string as_classname)
public function n_cst_thread of_getthread ()
public function integer of_setthread (n_cst_thread anv_thread)
public function integer of_setregisterid (string as_registerid)
public function integer of_setdescription (string as_description)
public function string of_getdescription ()
public function integer of_setthreadcomm (n_cst_threadcomm anv_threadcomm)
public function n_cst_threadcomm of_getthreadcomm ()
end prototypes

public function string of_getclassname ();Return is_ClassName
end function

public function string of_getregisterid ();Return is_RegisterId
end function

public function boolean of_busy ();Return ib_Busy
end function

public function integer of_setbusy (boolean ab_busy);ib_Busy = ab_busy

Return 1
end function

public function integer of_setclassname (string as_classname);is_ClassName = as_ClassName

Return 1
end function

public function n_cst_thread of_getthread ();Return inv_Thread
end function

public function integer of_setthread (n_cst_thread anv_thread);inv_Thread = anv_Thread

Return 1
end function

public function integer of_setregisterid (string as_registerid);is_RegisterId = as_RegisterId

Return 1
end function

public function integer of_setdescription (string as_description);is_Description = as_Description

Return 1
end function

public function string of_getdescription ();Return is_Description
end function

public function integer of_setthreadcomm (n_cst_threadcomm anv_threadcomm);inv_threadcomm = anv_Threadcomm

Return 1
end function

public function n_cst_threadcomm of_getthreadcomm ();Return inv_threadComm
end function

on n_cst_threadcontainer.create
call super::create
end on

on n_cst_threadcontainer.destroy
call super::destroy
end on

event destructor;call super::destructor;//Cleanup
SharedObjectUnRegister( is_RegisterId )
Destroy(inv_Thread)

IF isValid(inv_ThreadComm) THEN
	Destroy(inv_ThreadComm)
END IF




end event

