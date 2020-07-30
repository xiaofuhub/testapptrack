$PBExportHeader$n_cst_errorremedy.sru
forward
global type n_cst_errorremedy from n_cst_base
end type
end forward

global type n_cst_errorremedy from n_cst_base
end type
global n_cst_errorremedy n_cst_errorremedy

type variables
Protected:

String	is_InitialMessage

Long		ila_SourceIds[]
n_cst_errorLog	inv_errorLog
end variables

forward prototypes
public function integer of_remedy ()
public function integer of_setsourceids (long ala_sourceids[])
public function integer of_setsource (n_cst_errorlog anv_errorlog)
end prototypes

public function integer of_remedy ();// Implemented in Decendent
Return -1
end function

public function integer of_setsourceids (long ala_sourceids[]);ila_SourceIds[] = ala_SourceIds[]

Return 1
end function

public function integer of_setsource (n_cst_errorlog anv_errorlog);inv_errorLog = anv_errorLog

RETURN 1
end function

on n_cst_errorremedy.create
call super::create
end on

on n_cst_errorremedy.destroy
call super::destroy
end on

