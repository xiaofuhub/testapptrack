$PBExportHeader$n_cst_bso_specialops_manager.sru
forward
global type n_cst_bso_specialops_manager from n_cst_bso
end type
end forward

global type n_cst_bso_specialops_manager from n_cst_bso
event ue_1 ( )
end type
global n_cst_bso_specialops_manager n_cst_bso_specialops_manager

type variables
boolean	ib_ConversionDone
end variables

forward prototypes
public function integer of_initiate (long al_from, long al_to)
public function boolean of_conversiondone ()
end prototypes

event ue_1;n_cst_SpecialOps	lnv_SpecialOps

lnv_SpecialOps = create n_cst_SpecialOps

lnv_SpecialOps.triggerevent('ue_1')
IF Not lnv_SpecialOps.of_ConversionDone ( ) THEN
	ib_conversiondone = FALSE
END IF

destroy lnv_SpecialOps


end event

public function integer of_initiate (long al_from, long al_to);integer	li_return = 1
string	ls_triggerevent
long		ll_index

for ll_index = al_from to al_to
	ls_triggerevent = "ue_" + string(ll_index)
	this.triggerevent(ls_triggerevent)
next

IF Not THIS.of_ConversionDone ( ) THEN
	li_Return = -1
END IF
 
return li_return
end function

public function boolean of_conversiondone ();RETURN ib_conversiondone
end function

on n_cst_bso_specialops_manager.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bso_specialops_manager.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;ib_conversiondone = TRUE
end event

