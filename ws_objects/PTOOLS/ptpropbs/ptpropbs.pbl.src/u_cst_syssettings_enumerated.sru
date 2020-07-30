$PBExportHeader$u_cst_syssettings_enumerated.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings_enumerated from u_cst_syssettings
end type
end forward

global type u_cst_syssettings_enumerated from u_cst_syssettings
event of_delete ( )
end type
global u_cst_syssettings_enumerated u_cst_syssettings_enumerated

on u_cst_syssettings_enumerated.create
call super::create
end on

on u_cst_syssettings_enumerated.destroy
call super::destroy
end on

