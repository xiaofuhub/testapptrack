﻿$PBExportHeader$n_cst_aboutattrib.sru
$PBExportComments$Extension About window attributes
forward
global type n_cst_aboutattrib from pfc_n_cst_aboutattrib
end type
end forward

global type n_cst_aboutattrib from pfc_n_cst_aboutattrib
end type
global n_cst_aboutattrib n_cst_aboutattrib

on n_cst_aboutattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_aboutattrib.destroy
TriggerEvent( this, "destructor" )
end on

