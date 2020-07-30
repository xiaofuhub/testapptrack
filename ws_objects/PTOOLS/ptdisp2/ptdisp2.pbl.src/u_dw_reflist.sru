$PBExportHeader$u_dw_reflist.sru
forward
global type u_dw_reflist from u_dw
end type
end forward

global type u_dw_reflist from u_dw
int Width=2674
string DataObject="d_reflist"
event type integer ue_selectionchanged ( long al_id )
event ue_key pbm_dwnkey
end type
global u_dw_reflist u_dw_reflist

forward prototypes
public function integer of_retrievewithref (string as_ref1text)
end prototypes

event ue_key;Long	ll_Row
IF Key = KeyEnter! THEN
	
	Long	ll_ID
	ll_Row = THIS.GetRow ( )
	
	IF ll_Row > 0 THEN
		
		ll_ID = THIS.GetItemNumber( ll_Row , "ds_id" )
		
		THIS.Event ue_SelectionChanged ( ll_ID )
		
	END IF
ELSEIF Key = KeyEscape! THEN
	THIS.Event LoseFocus ( )
	
END IF
RETURN 0

end event

public function integer of_retrievewithref (string as_ref1text);THIS.SetTransObject ( SQLCA )
Long	ll_Retrieve

ll_Retrieve = THIS.Retrieve( (as_ref1Text + "%" ))
THIS.Visible = TRUE

IF THIS.RowCount ( ) > 0 THEN
	THIS.SelectRow ( 1, TRUE )
END IF

RETURN ll_Retrieve

end function

event clicked;call super::clicked;Long	ll_ID

IF Row > 0 THEN
	
	ll_ID = THIS.GetItemNumber( Row , "ds_id" )
	
	THIS.Event ue_SelectionChanged ( ll_ID )
	
END IF

RETURN AncestorReturnValue

	
end event

event constructor;ib_rmbMenu = FALSE
THIS.of_SetRowSelect ( TRUE )
inv_RowSelect.of_SetStyle ( 0 )
end event

