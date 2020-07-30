$PBExportHeader$n_cst_bso_imagecontrol.sru
forward
global type n_cst_bso_imagecontrol from n_cst_bso_imagemanager
end type
end forward

global type n_cst_bso_imagecontrol from n_cst_bso_imagemanager
end type
global n_cst_bso_imagecontrol n_cst_bso_imagecontrol

forward prototypes
public function integer of_saveimage ()
end prototypes

public function integer of_saveimage ();Return -1

end function

on n_cst_bso_imagecontrol.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bso_imagecontrol.destroy
TriggerEvent( this, "destructor" )
end on

