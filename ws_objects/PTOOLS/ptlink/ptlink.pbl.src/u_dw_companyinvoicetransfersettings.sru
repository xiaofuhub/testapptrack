$PBExportHeader$u_dw_companyinvoicetransfersettings.sru
forward
global type u_dw_companyinvoicetransfersettings from u_dw
end type
end forward

global type u_dw_companyinvoicetransfersettings from u_dw
integer width = 1906
integer height = 948
string dataobject = "d_companyinvoicesettings"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
event ue_preupdate ( )
event ue_toggleemailinvoice ( boolean ab_switch )
end type
global u_dw_companyinvoicetransfersettings u_dw_companyinvoicetransfersettings

type variables
Long	il_coid
end variables

forward prototypes
public function integer of_retrieve (long al_coid)
public function integer of_validate ()
end prototypes

event ue_toggleemailinvoice(boolean ab_switch);This.Enabled = ab_Switch

IF ab_Switch THEN
	This.Object.targetaddress.background.color = RGB(255,255,255)
	This.Object.bccaddress.background.color = RGB(255,255,255)
	This.object.subjectline.background.color = RGB(255,255,255)
	This.object.body.background.color = RGB(255,255,255)
	This.object.namingschema.background.color = RGB(255,255,255)
ELSE
	This.Object.targetaddress.background.color = 78682240
	This.Object.bccaddress.background.color = 78682240
	This.object.subjectline.background.color = 78682240
	This.object.body.background.color = 78682240
	This.object.namingschema.background.color = 78682240
END IF

//fix for target address field never getting focus//
This.SetRow(1)
This.SetColumn("targetaddress")
end event

public function integer of_retrieve (long al_coid);Int	li_Return
il_coid = al_coid
li_Return = THIS.Retrieve ( al_coid )
IF li_Return <= 0 THEN
	li_Return = THIS.InsertRow(0)
	IF li_Return > 0 THEN
		This.SetItem(1, "coid", al_CoID)
		THIS.SetItemStatus ( 1 , 0 , PRIMARY!,NotModified! )
	END IF
END IF
RETURN li_Return
	
end function

public function integer of_validate ();String 	ls_address
String	ls_Msg
String	ls_Body
Integer	li_Continue
Integer	li_Return

IF This.AcceptText() = 1 THEN	
	//Target address is mandatory
	ls_Msg = "Invalid data."
	ls_Address = This.GetItemString(1, "targetaddress")
	
	IF NOT isNull(ls_Address) AND Len(ls_Address) > 0 THEN
		li_Return = 1
	ELSE
		ls_Msg = "Target Address is required."
		li_Return = -1
	END IF
	
	IF li_Return = -1 THEN
		MessageBox("Invalid Data", ls_Msg)
	END IF
	
END IF

Return li_Return
end function

on u_dw_companyinvoicetransfersettings.create
end on

on u_dw_companyinvoicetransfersettings.destroy
end on

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA ) 
ib_Rmbmenu = FALSE
end event

event buttonclicked;call super::buttonclicked;String	ls_Body
String	ls_NewBody

n_cst_msg	lnv_msg
S_parm		lstr_Parm

IF dwo.Name = "b_body" THEN
	ls_Body = This.GetItemString(1,"body")
	
	lstr_Parm.is_label = "BODY"
	lstr_Parm.ia_Value = ls_Body
	lnv_Msg.of_Add_Parm( lstr_Parm )
	
	OpenWithParm(w_emailbody, lnv_Msg)
	
	IF isValid(Message.PowerObjectParm) THEN
		
		lnv_Msg = Message.PowerObjectParm
		
		IF lnv_msg.of_Get_Parm ( "NEWBODY" , lstr_Parm)  <> 0 THEN
			
			ls_NewBody = lstr_Parm.ia_Value
			IF ls_Body <> ls_NewBody OR isNull(ls_Body) THEN
				This.SetItem(1, "body", ls_NewBody)
				This.Event ItemChanged(1, dwo, ls_NewBody)
			END IF
			
		END IF
		
	END IF
	
	This.SetColumn("namingschema")
	
END IF
end event

