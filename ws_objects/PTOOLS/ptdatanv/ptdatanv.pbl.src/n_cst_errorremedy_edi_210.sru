$PBExportHeader$n_cst_errorremedy_edi_210.sru
forward
global type n_cst_errorremedy_edi_210 from n_cst_errorremedy_edi
end type
end forward

global type n_cst_errorremedy_edi_210 from n_cst_errorremedy_edi
end type
global n_cst_errorremedy_edi_210 n_cst_errorremedy_edi_210

forward prototypes
public function integer of_remedy ()
end prototypes

public function integer of_remedy ();//opens the window with the shipment ids that need to be redone.
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm
Int			li_return

IF upperBound( ila_sourceids ) > 0 THEN
		lstr_Parm.ia_Value = ila_sourceids
		lstr_Parm.is_label = "SHIPMENTIDS"
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_label = "RESENDEDI"
		lnv_Msg.of_add_parm( lstr_parm )
		
	IF not isValid( w_billing ) THEN
		opensheetWithParm(w_billing, lnv_Msg ,gnv_App.of_GetFrame ( ), 0, original!)
	ELSE
		setfocus( w_billing )
	END IF
	li_return  = 1
ELSE
	li_return = -1
END IF

RETURN li_return
end function

on n_cst_errorremedy_edi_210.create
call super::create
end on

on n_cst_errorremedy_edi_210.destroy
call super::destroy
end on

