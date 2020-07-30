$PBExportHeader$n_cst_errorremedy_openshipment.sru
forward
global type n_cst_errorremedy_openshipment from n_cst_errorremedy
end type
end forward

global type n_cst_errorremedy_openshipment from n_cst_errorremedy
end type
global n_cst_errorremedy_openshipment n_cst_errorremedy_openshipment

forward prototypes
public function integer of_remedy ()
end prototypes

public function integer of_remedy ();Integer	li_Return
Long		i, ll_IdCount

n_cst_ShipmentManager		lnv_ShipManager

ll_Idcount = upperBound( ila_sourceids )
IF  ll_IdCount > 0 THEN
	FOR i = 1 TO ll_IdCount
		lnv_ShipManager.of_OpenShipment (ila_SourceIds[i])
	NEXT
END IF

Return li_Return
end function

on n_cst_errorremedy_openshipment.create
call super::create
end on

on n_cst_errorremedy_openshipment.destroy
call super::destroy
end on

