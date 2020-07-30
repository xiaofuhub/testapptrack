$PBExportHeader$u_cst_sle_company.sru
forward
global type u_cst_sle_company from u_base
end type
type sle_1 from singlelineedit within u_cst_sle_company
end type
type st_accelerator from statictext within u_cst_sle_company
end type
end forward

global type u_cst_sle_company from u_base
integer width = 887
integer height = 84
event type integer ue_companychanged ( long al_companyid )
event ue_setfocus ( )
event ue_mousemove pbm_mousemove
event ue_billtospecial ( string as_value )
sle_1 sle_1
st_accelerator st_accelerator
end type
global u_cst_sle_company u_cst_sle_company

type variables
s_co_info	    istr_Company
String	is_OriginalName
Boolean	ib_ShowPop
Boolean	ib_BillToMode
long	il_CoID
end variables

forward prototypes
public function s_co_info of_getcompanyinfo ()
public function long of_getid ()
public subroutine of_enable (boolean ab_value)
public subroutine of_settext (string as_Text)
public function integer of_setwidth (long al_Width)
public function integer of_setid (long al_id)
public function integer of_setbilltoid (long al_id)
public function integer of_setbilltomode (boolean ab_Value)
public subroutine of_setaccelerator (readonly string as_Value)
public function integer of_getcompany (ref n_cst_beo_company anv_company)
end prototypes

event ue_setfocus;sle_1.Post SetFocus ( )
end event

public function s_co_info of_getcompanyinfo ();
RETURN istr_Company

end function

public function long of_getid ();RETURN il_coid
end function

public subroutine of_enable (boolean ab_value);CHOOSE CASE ab_value
	
	CASE FALSE
		sle_1.Backcolor = RGB ( 192 , 192 , 192 ) 
	CASE TRUE
		sle_1.Backcolor = RGB ( 255 , 255 , 255 ) 
		
END CHOOSE

sle_1.DisplayOnly = NOT ab_value


end subroutine

public subroutine of_settext (string as_Text);sle_1.Text = as_Text
end subroutine

public function integer of_setwidth (long al_Width);sle_1.Width = al_Width
THIS.Width = al_Width + 5
RETURN 1
end function

public function integer of_setid (long al_id);
gnv_cst_Companies.of_get_info ( al_id, istr_company, TRUE )

IF istr_Company.co_id > 0 THEN
	il_CoID = al_ID
	sle_1.Text = istr_Company.Co_Name
//	THIS.Event ue_CompanyChanged ( istr_Company.co_id )	
ELSE 
	sle_1.Text = ""
END  IF
	

RETURN 1
end function

public function integer of_setbilltoid (long al_id);
gnv_cst_Companies.of_get_info ( al_id, istr_company, TRUE )

sle_1.Text = ""

IF istr_Company.co_id > 0 THEN
	il_CoID = al_ID
	Long	ll_Length
	Select length (co_comments) into :ll_Length From companies where co_id = :il_coid;
	Commit;
	
	IF ll_Length > 0 THEN
		
		sle_1.Text = "*"
		
	END IF
	
	
	IF Upper ( istr_Company.co_Bill_Same ) = "T" THEN
		sle_1.Text += istr_Company.Co_Name
	ELSE
		sle_1.Text += istr_Company.Co_Bill_Name
	END IF
	
END  IF
	

RETURN 1
end function

public function integer of_setbilltomode (boolean ab_Value);// when a id is set we will check this value to see if we need to display the bill to name
ib_BillToMode = ab_Value
RETURN 1
end function

public subroutine of_setaccelerator (readonly string as_Value);st_accelerator.Text = "&" + as_Value
end subroutine

public function integer of_getcompany (ref n_cst_beo_company anv_company);integer	li_return


DESTROY anv_company

anv_company = CREATE n_cst_beo_Company

gnv_cst_Companies.of_Cache ( il_CoID, TRUE )				
anv_Company.of_SetUseCache ( TRUE )

IF anv_Company.of_SetSourceId ( il_CoID ) = 1 THEN
	IF anv_Company.of_HasSource ( ) THEN
		li_Return = 1
	ELSE 
		li_Return = 0
	END IF
END IF

RETURN li_Return


end function

on u_cst_sle_company.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_accelerator=create st_accelerator
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_accelerator
end on

on u_cst_sle_company.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_accelerator)
end on

event constructor;call super::constructor;SetNull ( il_CoID )
end event

type sle_1 from singlelineedit within u_cst_sle_company
event ue_mousemove pbm_mousemove
integer width = 882
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;Parent.Event ue_MouseMove ( flags , xpos , ypos )
end event

event modified;integer	li_Return = 1
Boolean	lb_Notify = TRUE
Boolean	lb_AllowHold = TRUE
String	ls_Search
String	ls_DisplayName
Long		ll_CoID
String	ls_Type
Long		ll_Length

n_cst_beo_Company	lnv_Company

ls_Search = Trim ( THIS.Text  )
lb_AllowHold = NOT ib_billtomode
SetNull ( ll_CoID )

IF Len  ( ls_Search ) > 0 THEN

	choose case ls_search
		case '?'
			if ib_BillToMode then
				parent.Event ue_BilltoSpecial(ls_search)
			end if
			li_return = -1
		case else
			ls_DisplayName = is_OriginalName
			IF ib_billtomode THEN
				ls_Type = "BILLTO!"
			END IF
			lnv_Company = gnv_cst_Companies.of_Select ( ls_Search , lb_AllowHold, lb_Notify, ls_Type	)
			IF IsValid ( lnv_Company ) THEN
				ls_DisplayName = ""
				ll_CoID = lnv_Company.of_GetID ( )
				
				Select length (co_comments) into :ll_Length From companies where co_id = :ll_CoID;
				Commit;
				
				IF ll_Length > 0 THEN					
					ls_DisplayName = "*"					
				END IF
				
				IF ib_BillToMode THEN
					ls_DisplayName += lnv_Company.of_GetBillingName ( ) 
				ELSE 
					ls_DisplayName += lnv_Company.of_GetName ( ) 
				END IF
				
				destroy lnv_company
		
			ELSE 
				li_Return = -1 
			END IF
			
			THIS.Text = ls_DisplayName 
			
	end choose
	
END IF


IF li_Return = 1 THEN
	il_COID = ll_CoID 
	Parent.Event ue_CompanyChanged ( ll_CoID )	
END IF
end event

event rbuttondown;Any		laa_Parm_Values[]
String	lsa_Parm_Labels[]
Long	   ll_CompanyID

ll_CompanyID = Parent.of_getID ( )

IF ll_CompanyID > 0 THEN
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "COMPANY"
	lsa_parm_labels[2] = "CO_ID"
	laa_parm_values[2] = ll_CompanyID
END IF

f_pop_Standard ( lsa_parm_labels , laa_parm_values )
		
		
end event

event getfocus;IF Len ( THIS.Text ) > 0 THEN
	THIS.Post SelectText ( 1, Len ( this.Text )  )
END IF

is_OriginalName = THIS.Text
end event

event losefocus;THIS.SelectText ( 1, 0  )
end event

type st_accelerator from statictext within u_cst_sle_company
integer x = 421
integer y = 104
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

event getfocus;sle_1.SetFocus ( )
end event

