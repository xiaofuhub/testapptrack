$PBExportHeader$u_cst_syssettings_sle_pwd.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings_sle_pwd from u_cst_syssettings_sle
end type
end forward

global type u_cst_syssettings_sle_pwd from u_cst_syssettings_sle
end type
global u_cst_syssettings_sle_pwd u_cst_syssettings_sle_pwd

on u_cst_syssettings_sle_pwd.create
call super::create
end on

on u_cst_syssettings_sle_pwd.destroy
call super::destroy
end on

type st_1 from u_cst_syssettings_sle`st_1 within u_cst_syssettings_sle_pwd
end type

type sle_1 from u_cst_syssettings_sle`sle_1 within u_cst_syssettings_sle_pwd
boolean password = true
end type

type st_2 from u_cst_syssettings_sle`st_2 within u_cst_syssettings_sle_pwd
end type

