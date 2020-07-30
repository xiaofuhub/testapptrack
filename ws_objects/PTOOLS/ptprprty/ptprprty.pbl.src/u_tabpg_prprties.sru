$PBExportHeader$u_tabpg_prprties.sru
forward
global type u_tabpg_prprties from u_tabpg
end type
end forward

global type u_tabpg_prprties from u_tabpg
end type
global u_tabpg_prprties u_tabpg_prprties

forward prototypes
public function integer of_validatecontrols ()
end prototypes

public function integer of_validatecontrols ();Int li_ReturnValue = 0
Int li_UpperBound
Int li_Ctr 

li_UpperBound = UpperBound(This.Control[])

FOR li_Ctr = 1 TO li_UpperBound
	IF Left(This.Control[li_Ctr].ClassName(),2) = "uo" THEN	
		IF This.Control[li_Ctr].Dynamic Event ue_ValidateControls() = -1 THEN 
			li_ReturnValue = -1
		END IF
	END IF
NEXT

Return li_ReturnValue

end function

on u_tabpg_prprties.create
call super::create
end on

on u_tabpg_prprties.destroy
call super::destroy
end on

