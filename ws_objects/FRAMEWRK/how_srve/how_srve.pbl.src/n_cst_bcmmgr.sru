$PBExportHeader$n_cst_bcmmgr.sru
$PBExportComments$BOM Manager Root Class
forward
global type n_cst_bcmmgr from ofr_n_cst_bcmmgr
end type
end forward

global type n_cst_bcmmgr from ofr_n_cst_bcmmgr
end type
global n_cst_bcmmgr n_cst_bcmmgr

forward prototypes
public function boolean setpbrowidind (readonly boolean ab_flag)
end prototypes

public function boolean setpbrowidind (readonly boolean ab_flag);//OVERRIDE FOR BUG FIX

ib_pb_row_id = ab_flag

RETURN TRUE



//Rivertons code didn't set anything.  Their code was:

//return ib_pb_row_id = ab_flag
end function

on n_cst_bcmmgr.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bcmmgr.destroy
TriggerEvent( this, "destructor" )
end on

