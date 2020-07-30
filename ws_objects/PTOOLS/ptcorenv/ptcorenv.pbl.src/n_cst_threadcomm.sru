$PBExportHeader$n_cst_threadcomm.sru
forward
global type n_cst_threadcomm from n_base
end type
end forward

global type n_cst_threadcomm from n_base
end type
global n_cst_threadcomm n_cst_threadcomm

type variables
Window	iw_requestor
end variables

forward prototypes
public subroutine of_sendmessage (string as_message)
public function integer of_setrequestor (window aw_reqwestor)
public subroutine of_showmessagebox (string as_title, string as_message)
public subroutine of_setfocus ()
end prototypes

public subroutine of_sendmessage (string as_message);//Dynamic event will fail gracfully on a spawned thread
iw_requestor.Event Dynamic ue_message( as_message )
end subroutine

public function integer of_setrequestor (window aw_reqwestor);IF NOT IsValid( aw_reqwestor ) THEN
	Return -1
ELSE
	iw_requestor= aw_reqwestor
	Return 1
END IF
end function

public subroutine of_showmessagebox (string as_title, string as_message);IF isValid(iw_requestor) THEN
	iw_Requestor.Event Dynamic ue_ShowMessageBox(as_title, as_Message)
END IF
end subroutine

public subroutine of_setfocus ();iw_requestor.Event Dynamic ue_setfocus()
end subroutine

on n_cst_threadcomm.create
call super::create
end on

on n_cst_threadcomm.destroy
call super::destroy
end on

