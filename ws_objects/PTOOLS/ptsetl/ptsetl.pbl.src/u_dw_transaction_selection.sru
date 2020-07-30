$PBExportHeader$u_dw_transaction_selection.sru
forward
global type u_dw_transaction_selection from u_dw
end type
end forward

global type u_dw_transaction_selection from u_dw
int Width=1751
int Height=1056
string DataObject="d_transaction_selection"
boolean VScrollBar=false
event ue_keydown pbm_dwnkey
event type integer ue_reset ( )
end type
global u_dw_transaction_selection u_dw_transaction_selection

event ue_reset;Long	ll_Row

THIS.Reset()

ll_Row = THIS.InsertRow ( 0 )

IF ll_row <> 1 THEN
	
	MessageBox("Window Reset" , "An error occurred while resetting the window." ) 
	
ELSE
	
	THIS.SetColumn ( "entity" )
	THIS.SetFocus( )

END IF

RETURN ll_Row
end event

event itemerror;call super::itemerror;
Boolean	lb_Processed
string 	ls_errcol
Long		ll_Return
date 		ld_compdate
Int		li_SetItemRtn

n_cst_string lnv_string

ls_errcol = dwo.name
ll_Return = ancestorReturnValue
IF ll_Return = 0 THEN

	choose case ls_errcol
	
		case "begin_date" , "end_date"
		
			//Attempt to convert the text typed to a date
			ld_compdate = lnv_string.of_SpecialDate(data)
		
			if isnull(ld_compdate) then
				//Value is really invalid
				ll_return = 0 //  Reject the data value and show an error message box
				
			ELSE
				li_SetItemRtn = this.setitem(row, ls_errcol, ld_compdate)
				IF li_SetItemRtn > 0 THEN // HOW's extention retruns -1, maybe 0 , 1, 2 
					ll_Return = 3  //Reject the data value but allow focus to change
				ELSE
					ll_return = 0 
				END IF
		
			END IF
		
	end choose
	
END IF

return ll_Return
end event

event itemchanged;call super::itemchanged;
//Boolean	lb_Processed
string 	ls_changeCol
Long		ll_Return
//date 		ld_compdate
//Int		li_SetItemRtn

n_cst_string lnv_string

ls_Changecol = dwo.name
ll_Return = ancestorReturnValue

	choose case ls_Changecol
	
		case "entity_type" 
			This.setColumn ( "entity" )
			THIS.SetFocus ( )
		
		
	end choose
	


return ll_Return
end event

