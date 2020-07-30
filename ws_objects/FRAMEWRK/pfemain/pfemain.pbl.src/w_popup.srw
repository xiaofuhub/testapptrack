$PBExportHeader$w_popup.srw
$PBExportComments$Extension Popup Window class
forward
global type w_popup from pfc_w_popup
end type
end forward

global type w_popup from pfc_w_popup
event pfc_default ( )
end type
global w_popup w_popup

on w_popup.create
call super::create
end on

on w_popup.destroy
call super::destroy
end on

