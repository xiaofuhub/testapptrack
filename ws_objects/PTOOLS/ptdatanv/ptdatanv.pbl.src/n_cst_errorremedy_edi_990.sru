$PBExportHeader$n_cst_errorremedy_edi_990.sru
forward
global type n_cst_errorremedy_edi_990 from n_cst_errorremedy_edi
end type
end forward

global type n_cst_errorremedy_edi_990 from n_cst_errorremedy_edi
end type
global n_cst_errorremedy_edi_990 n_cst_errorremedy_edi_990

forward prototypes
public function integer of_remedy ()
end prototypes

public function integer of_remedy ();//opens the window with the shipment ids that need to be redone.
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm
Int			li_return

IF upperBound( ila_sourceids ) > 0 THEN
	lstr_Parm.is_Label = "REMEDY"
	lstr_Parm.ia_value = ila_sourceids
	lnv_Msg.of_add_parm( lstr_Parm )
	
	IF not isValid( w_ediShipmentReview ) THEN
		OpenSHEETWithParm ( w_ediShipmentReview, lnv_msg, gnv_app.of_getFrame() )
	ELSE
		setfocus( w_ediShipmentReview )
	END IF
	li_return  = 1
ELSE
	li_return = -1
END IF

RETURN li_return
end function

on n_cst_errorremedy_edi_990.create
call super::create
end on

on n_cst_errorremedy_edi_990.destroy
call super::destroy
end on

