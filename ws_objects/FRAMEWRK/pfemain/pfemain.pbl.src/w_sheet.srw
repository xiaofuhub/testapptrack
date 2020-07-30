$PBExportHeader$w_sheet.srw
$PBExportComments$Extension Sheet Window class
forward
global type w_sheet from pfc_w_sheet
end type
end forward

global type w_sheet from pfc_w_sheet
event ue_hasreportcontext ( )
event pfc_cancel ( )
end type
global w_sheet w_sheet

forward prototypes
public function long wf_getreportcontexts (ref string asa_contexts[])
end prototypes

event ue_hasreportcontext();//here only for testing that this thing has the function getReportContexts
end event

public function long wf_getreportcontexts (ref string asa_contexts[]);//at this level it returns the number of items in the array that is set
//there is no items at this level so it returns 0
return 0
end function

on w_sheet.create
call super::create
end on

on w_sheet.destroy
call super::destroy
end on

