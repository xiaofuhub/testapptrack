$PBExportHeader$u_dw_companycontact_detail.sru
forward
global type u_dw_companycontact_detail from u_dw
end type
end forward

global type u_dw_companycontact_detail from u_dw
integer width = 1650
integer height = 1136
string dataobject = "d_contact_info"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type
global u_dw_companycontact_detail u_dw_companycontact_detail

type variables
Long	il_CoID

Constant String	cs_Color_Disabled = "78682240"
end variables

forward prototypes
public function integer of_update ()
public function long of_getmaxid ()
public function integer of_setcoid (long al_id)
public function integer of_setenablenotifydefaults (boolean ab_enable)
end prototypes

public function integer of_update ();Long	ll_ID
Long	ll_CompanyID
Long	Row
String	ls_Address
Int	li_Return = 1

IF THIS.RowCount ( ) = 1 THEN
	
	THIS.AcceptText ( )
	
	THIS.SetItem( 1 , "ct_status" , appeon_constant.cs_status_Active )
	
	ll_ID = THIS.GetItemNumber ( 1 , "ct_ID" ) 
	IF IsNull ( ll_ID ) THEN
		ll_ID = THIS.of_GetMaxID ( )
		THIS.SetItem ( 1 , "ct_ID" , ll_ID )
	END IF
	
	ll_CompanyID = THIS.GetItemNumber ( 1 , "ct_co" ) 
	IF IsNull ( ll_CompanyID ) THEN
		ll_CompanyID = il_CoID
		THIS.SetItem ( 1 , "ct_co" , ll_CompanyID )
	END IF
	
	ls_Address = THIS.GetItemString ( 1 , "ct_emailaddress" ) 
	IF IsNull ( ls_Address ) THEN
		MessageBox( "Contact Properties" , "you must enter an e-mail address." )
		THIS.SetColumn ( "ct_emailaddress" )
		THIS.SetFocus ( )
		li_Return = -1
	END IF
	
ELSE
	li_Return = -1
END IF

IF li_Return = 1 THEN
	li_Return = THIS.Update ( )
END IF
	
RETURN li_Return
end function

public function long of_getmaxid ();long	ll_Return

SELECT Max ( "id" )INTO :ll_Return FROM companyContacts;

IF SQLCA.SqlCode = 0 THEN
	COMMIT ;
ELSE		
	ROLLBACK ;
END IF

IF isNull ( ll_Return ) THEN
	ll_Return = 0
END IF

ll_Return ++

RETURN ll_Return


end function

public function integer of_setcoid (long al_id);il_CoID = al_ID
IF il_CoID = 0 THEN
	SetNull ( il_CoID )
END IF

RETURN 1
end function

public function integer of_setenablenotifydefaults (boolean ab_enable);String	ls_Enable
String	ls_Scale
String	ls_Protect
String	ls_return

IF ab_Enable THEN
	ls_Protect = "0"
	ls_Enable = 'Yes'
	ls_Scale = 'No'
ELSE
	ls_Protect = "1"
	ls_Enable = 'No'
	ls_Scale = 'Yes'
END IF

This.Modify("ct_notifyonshipment.Protect=" + ls_Protect)
This.Modify("ct_notifyonshipment.CheckBox.3D=" + ls_Enable)

This.Modify("ct_notifyonaccnote.Protect=" + ls_Protect)
This.Modify("ct_notifyonaccnote.CheckBox.3D=" + ls_Enable)

This.Modify("ct_notifyonaccauth.Protect=" + ls_Protect)
This.Modify("ct_notifyonaccauth.CheckBox.3D=" + ls_Enable)

This.Modify("ct_notifyonevent.Protect=" + ls_Protect)
This.Modify("ct_notifyonevent.CheckBox.3D=" + ls_Enable)

This.Modify("ct_notifyonlfd.Protect=" + ls_Protect)
This.Modify("ct_notifyonlfd.CheckBox.3D=" + ls_Enable)

This.Modify("ct_notifyontir.Protect=" + ls_Protect)
This.Modify("ct_notifyontir.CheckBox.3D=" + ls_Enable)


Return 1
end function

event constructor;String	lsa_Objects[]
String	ls_Type
			
Long	ll_ObjectCount, &
			ll_Index

ib_rmbmenu = FALSE
n_cst_licenseManager	lnv_LicenseManager

n_cst_dws	lnv_Dws



n_cst_Privileges					lnv_Privileges

IF NOT lnv_LicenseManager.of_GetLicensed ( n_cst_constants.cs_Module_Notification ) THEN
	THIS.object.ct_notifyonevent.Protect = 1
	THIS.object.ct_notifyonaccnote.Protect = 1
	THIS.object.ct_notifyonaccauth.Protect = 1
	THIS.object.ct_notifyonshipment.Protect = 1
	THIS.object.ct_notifyonlfd.Protect = 1
	THIS.object.ct_notifyontir.Protect = 1
END IF


IF NOT lnv_Privileges.of_HasEntryRights ( ) THEN
	This.of_SetBase ( TRUE )
	
	ll_ObjectCount = This.inv_Base.of_GetObjects ( lsa_Objects )
	
	FOR ll_Index = 1 TO ll_ObjectCount
	
		ls_Type =  This.Describe ( lsa_Objects [ ll_Index ] + ".type" )
		
		IF ls_Type = "column" THEN
			This.Modify(lsa_Objects[ll_Index] + ".Protect = 1")
			This.Modify (lsa_Objects [ ll_Index ] + ".Background.Color = " + cs_Color_Disabled )				
		END iF		

	NEXT

END IF
end event

on u_dw_companycontact_detail.create
end on

on u_dw_companycontact_detail.destroy
end on

