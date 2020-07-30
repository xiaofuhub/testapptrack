$PBExportHeader$u_dw_privdetail.sru
forward
global type u_dw_privdetail from u_dw
end type
end forward

global type u_dw_privdetail from u_dw
integer width = 1207
integer height = 364
end type
global u_dw_privdetail u_dw_privdetail

type variables
public n_cst_privDetails		inv_currentDetails
end variables

forward prototypes
public function n_cst_privDetails of_getprivdetail ()
public function integer of_setprivdetail (n_cst_privdetails anv_privdetails, integer ai_ypos)
end prototypes

public function n_cst_privDetails of_getprivdetail ();return inv_currentDetails
end function

public function integer of_setprivdetail (n_cst_privdetails anv_privdetails, integer ai_ypos);//the following sets the instance variable current details to the passed in variable
//It also sets its own display according to the nonvisual properties.
//Returns 1 if anv_privDetails was valid, -1 otherwise

int 			li_return
Long			ll_max
Datastore	lds_details

IF isValid( anv_privDetails ) THEN
	
	IF isValid( inv_currentDetails ) THEN
		Destroy inv_currentDetails
	END IF
	
	inv_currentDetails = anv_privDetails
	
	lds_details = inv_currentDetails.of_getDetails()
	IF isValid( lds_details ) THEN
		this.dataObject = lds_details.dataObject
		
		ll_max = lds_details.rowCount( )
		
		IF ll_max > 0 THEN
			IF NOT isNULL(lds_details.getItemString( 1, "function" )) THEN
				li_return = lds_details.sharedata(this)
				
				IF this.y <> ai_ypos THEN
					this.y = ai_ypos
				END IF
				this.visible = true
			END IF
		ELSE
			this.visible = false
		END IF	
		
	END IF
	li_return = 1
ELSE
	li_return = -1
END IF

return li_return
end function

on u_dw_privdetail.create
end on

on u_dw_privdetail.destroy
end on

event constructor;call super::constructor;This.of_SetInsertable(False)
This.of_SetDeleteable(False)
end event

