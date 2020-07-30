$PBExportHeader$w_sortsingle.srw
$PBExportComments$Extension Simple Sort dialog window
forward
global type w_sortsingle from pfc_w_sortsingle
end type
end forward

global type w_sortsingle from pfc_w_sortsingle
end type
global w_sortsingle w_sortsingle

on w_sortsingle.create
call super::create
end on

on w_sortsingle.destroy
call super::destroy
end on

type cb_ok from pfc_w_sortsingle`cb_ok within w_sortsingle
boolean BringToTop=true
end type

type ddlb_sort from pfc_w_sortsingle`ddlb_sort within w_sortsingle
boolean Sorted=true
end type

