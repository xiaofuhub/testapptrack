$PBExportHeader$u_dw_co_location.sru
forward
global type u_dw_co_location from u_dw
end type
end forward

global type u_dw_co_location from u_dw
integer width = 896
integer height = 352
string dataobject = "d_co_name_location"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
event type integer ue_companychanged ( long al_id )
event ue_keydown pbm_dwnkey
end type
global u_dw_co_location u_dw_co_location

type variables

end variables

forward prototypes
public function integer of_setenable (boolean ab_value)
public function integer of_loadcompany (long al_id)
end prototypes

public function integer of_setenable (boolean ab_value);

THIS.Enabled = ab_Value

CHOOSE CASE ab_Value 
		
	CASE TRUE 
		THIS.Object.co_name.Background.color  = RGB ( 255 , 255, 255 ) 
		
	CASE FALSE
		
		THIS.Object.co_name.Background.color = 12648447
		
END CHOOSE

RETURN 1
end function

public function integer of_loadcompany (long al_id);IF al_ID > 0 THEN
	THIS.Retrieve ( al_ID ) 
	
ELSE
	THIS.SetRedraw ( FALSE ) 
	THIS.Reset ( ) 
	THIS.InsertRow ( 0 )
	THIS.SetRedraw ( TRUE ) 
END IF

RETURN 1
end function

event constructor;this.settransobject(sqlca)
ib_RmbMenu = FALSE

end event

event itemchanged;call super::itemchanged;long ll_Return
Long	ll_Null
SetNull ( ll_null )
s_co_info lstr_company
choose case Lower ( dwo.name )
	case "co_name"
		IF Len ( Trim ( data ) ) > 0 THEN

			if gnv_cst_companies.of_select(lstr_company, "ANY!", true, data, false, 0, false, true) = 1 then
				THIS.Post of_LoadCompany (  lstr_company.co_id  )
				THIS.Post Event ue_CompanyChanged ( lstr_company.co_id )
			else
				this.settext(substitute(dwo.primary[row], null_str, ""))
			end if
			
		ELSE
			//this.settext(substitute(dwo.primary[row], null_str, ""))
			THIS.Post of_LoadCompany (  ll_null  )
			THIS.Post Event ue_CompanyChanged (ll_null )
		END IF
		ll_return = 2
		
end choose
return ll_return

end event

event rbuttondown;call super::rbuttondown;Long	ll_CoID
Any		laa_Parm_Values[]
String	lsa_Parm_Labels[]

IF Row > 0 THEN

	ll_CoID = THIS.GetItemNumber	( row , "co_id" )
	IF ll_CoID > 0 THEN
			
		lsa_parm_labels[1] = "MENU_TYPE"
		laa_parm_values[1] = "COMPANY"
		lsa_parm_labels[2] = "CO_ID"
		laa_parm_values[2] = ll_CoID
			
		f_pop_standard(lsa_parm_labels, laa_parm_values)
		
			
	END IF
	
	
END IF
end event

on u_dw_co_location.create
end on

on u_dw_co_location.destroy
end on

