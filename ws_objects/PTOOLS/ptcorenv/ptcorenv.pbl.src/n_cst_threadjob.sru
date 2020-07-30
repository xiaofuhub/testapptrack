$PBExportHeader$n_cst_threadjob.sru
forward
global type n_cst_threadjob from n_base
end type
end forward

global type n_cst_threadjob from n_base autoinstantiate
end type

type variables
n_ds    		 ids_Data
Long			 ila_SourceIds[]
String    	 is_DataObject
String    	 is_ErrorMessage
String    	 is_ProgressMessage 
end variables

on n_cst_threadjob.create
call super::create
end on

on n_cst_threadjob.destroy
call super::destroy
end on

