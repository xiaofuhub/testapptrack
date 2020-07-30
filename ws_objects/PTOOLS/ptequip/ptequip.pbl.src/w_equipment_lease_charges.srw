$PBExportHeader$w_equipment_lease_charges.srw
forward
global type w_equipment_lease_charges from w_response
end type
type st_3 from statictext within w_equipment_lease_charges
end type
type st_2 from statictext within w_equipment_lease_charges
end type
type sle_in from singlelineedit within w_equipment_lease_charges
end type
type sle_out from singlelineedit within w_equipment_lease_charges
end type
type dw_1 from u_dw_equipment_lease_charges within w_equipment_lease_charges
end type
type cb_1 from u_cbok within w_equipment_lease_charges
end type
type cb_2 from u_cbcancel within w_equipment_lease_charges
end type
type st_1 from statictext within w_equipment_lease_charges
end type
end forward

global type w_equipment_lease_charges from w_response
integer x = 901
integer y = 728
integer width = 2185
integer height = 908
string title = "Equipment Lease Charges"
boolean controlmenu = false
st_3 st_3
st_2 st_2
sle_in sle_in
sle_out sle_out
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
st_1 st_1
end type
global w_equipment_lease_charges w_equipment_lease_charges

type variables


Private:
Long	ila_Ids[]
Long	ila_EventIds[]
Long	ila_LinkedIds[]
Long	ila_ParentEventIDs[]
Long	ila_ParentLinkedIDs[]
end variables

forward prototypes
public function integer wf_setlabelassociation ()
public function integer wf_findinarray (long ala_Array[], long al_Value)
public function integer wf_concatinatearrays (ref long ala_Result[])
end prototypes

public function integer wf_setlabelassociation ();
String	ls_Label
String	ls_Test
Long		i
Long		ll_CurrentID

n_cst_Beo_Equipment	lnv_Equipment

For i = 1 TO dw_1.RowCount ( ) 
	
	lnv_Equipment = dw_1.inv_UiLink.GetBeo ( i, "n_cst_beo_equipment" )
	ll_CurrentID = lnv_Equipment.of_GetID( )

	IF THIS.wf_FindInArray ( ila_linkedids , ll_CurrentID ) > 0 THEN
		ls_Label =  "Shipment"
	END IF
	
	IF THIS.wf_FindInArray ( ila_parentlinkedids , ll_CurrentID ) > 0 THEN
		IF Len ( ls_label ) > 0 THEN
			ls_Label += ", "
		END IF
		ls_Label +=  "Parent Shipment"
	END IF
	
	IF THIS.wf_FindInArray ( ila_eventids , ll_CurrentID ) > 0 THEN
		IF Len ( ls_label ) > 0 THEN
			ls_Label += ", "
		END IF
		ls_Label +=  "Events"
	END IF
	
	IF THIS.wf_FindInArray ( ila_parenteventids , ll_CurrentID ) > 0 THEN
		IF Len ( ls_label ) > 0 THEN
			ls_Label += ", "
		END IF
		ls_Label +=  "Parent Events"
	END IF

	
	IF Len ( ls_Label ) > 0 THEN
		dw_1.SetItem ( i , "AssociatedBy" , ls_Label )
	END IF
	
	ls_Label = ""
	

NEXT


dw_1.SetSort ( "AssociatedBy D" ) 
dw_1.Sort ( )

RETURN 1
end function

public function integer wf_findinarray (long ala_Array[], long al_Value);Long	ll_Count
Long	i
Long	ll_Rtn

ll_Count = UpperBound ( ala_Array )

FOR i = 1 TO ll_Count 
	
	IF ala_Array [ i ] = al_Value THEN
		ll_Rtn = i
		EXIT
	END IF
	
Next

RETURN ll_Rtn

end function

public function integer wf_concatinatearrays (ref long ala_Result[]);Long	i
Long	ll_Count
Long	lla_Result[]
Long	ll_ResultCount = 1
Long	lla_Empty[]


lla_Result = lla_Empty

ll_Count = UpperBound ( ila_eventids )
FOR i = 1 TO ll_Count 
	lla_Result [ll_ResultCount] = ila_eventids [ i ]
	ll_ResultCount ++
NEXT

ll_Count = UpperBound ( ila_linkedids )
FOR i = 1 TO ll_Count 
	lla_Result [ll_ResultCount] = ila_linkedids [ i ]
	ll_ResultCount ++
NEXT

ll_Count = UpperBound ( ila_parenteventids )
FOR i = 1 TO ll_Count 
	lla_Result [ll_ResultCount] = ila_parenteventids [ i ]
	ll_ResultCount ++
NEXT

ll_Count = UpperBound ( ila_parentlinkedids )
FOR i = 1 TO ll_Count 
	lla_Result [ll_ResultCount] = ila_parentlinkedids [ i ]
	ll_ResultCount ++
NEXT

ala_Result = lla_Result

RETURN 1

	
end function

event open;call super::open;n_cst_bcm 		lnv_bcm
n_cst_database lnv_database
n_cst_query 	lnv_query
n_cst_Msg		lnv_Msg
S_Parm			lstr_Parm
Long				ll_RowCount
Long				i
Long				lla_Ids[]
Boolean			lb_HaveEquip


lnv_Msg = Message.powerobjectParm

dw_1.of_SetRowSelect ( TRUE ) 



ib_DisableCloseQuery = TRUE
dw_1.SetUILink ( TRUE )



IF lnv_Msg.of_Get_Parm ( "EVENT" , lstr_Parm ) <> 0 THEN
	ila_eventids = lstr_Parm.ia_Value 
END IF
IF lnv_Msg.of_Get_Parm ( "LINKED" , lstr_Parm ) <> 0 THEN
	ila_linkedids = lstr_Parm.ia_Value 
END IF
IF lnv_Msg.of_Get_Parm ( "PARENTEVENT" , lstr_Parm ) <> 0 THEN
	ila_parenteventids = lstr_Parm.ia_Value 
END IF
IF lnv_Msg.of_Get_Parm ( "PARENTLINKED" , lstr_Parm ) <> 0 THEN
	ila_parentlinkedids = lstr_Parm.ia_Value 
END IF

THIS.wf_ConcatinateArrays ( lla_Ids )

lb_HaveEquip =  UpperBound ( lla_Ids ) > 0

IF lb_HaveEquip THEN
	lnv_database = gnv_bcmmgr.GetDatabase()
	If IsValid(lnv_database) Then
		lnv_query = lnv_database.GetQuery()
		lnv_query.SetArgument(lla_Ids)
		
		
		lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlk_equipmentcache","","Ids")
	End If
	
	
	IF isValid ( dw_1.inv_UILink ) THEN
		dw_1.inv_UILink.SetBcm ( lnv_Bcm )
	END IF


	For i = dw_1.RowCount ( )  TO 1 STEP -1
		
		IF IsNull (dw_1.object.EquipmentLease_Charges[i] )THEN
			dw_1.DeleteRow ( i )
		ELSE
			dw_1.object.Selected[i] = "1"
		END IF
		dw_1.SelectRow ( i , FALSE )
		
	NEXT
END IF

IF dw_1.RowCount () <= 0 THEN
	MEssageBox ( "Lease Charges" , "No charges were found." )
	THIS.Event pfc_Cancel ( )
ELSE
	dw_1.SetRedraw ( FALSE )
	THIS.wf_SetLabelAssociation ( )
	dw_1.SelectRow ( 1 , TRUE )
	dw_1.SetRow ( 1 )
	dw_1.SetRedraw ( TRUE )
	dw_1.SetFocus ( )	
END IF


end event

on w_equipment_lease_charges.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_2=create st_2
this.sle_in=create sle_in
this.sle_out=create sle_out
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.sle_in
this.Control[iCurrent+4]=this.sle_out
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.st_1
end on

on w_equipment_lease_charges.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_in)
destroy(this.sle_out)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
end on

event pfc_default;Long			i
Date			ld_Out
Date			ld_IN
n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm
n_cst_Beo_Equipmentlease	lnva_Equipmentlease[]
n_cst_Beo_Equipmentlease	lnv_Equipmentlease
n_cst_Beo_Equipment			lnva_Equipment[]
n_cst_Beo_Equipment			lnv_Equipment



lstr_Parm.is_Label = "CONTINUE"
lstr_parm.ia_Value = TRUE
lnv_Msg.of_Add_Parm ( Lstr_Parm )

For i = 1 TO dw_1.RowCount () 
	
	IF dw_1.Object.Selected[i] = "1" THEN
		lnv_Equipmentlease = dw_1.inv_UiLink.GetBeo ( i, "n_cst_beo_equipmentLease" )
		lnv_Equipment = dw_1.inv_UiLink.GetBeo ( i, "n_cst_beo_equipment" )
		
		lnv_Equipment.of_SetEquipmentLeaseDirectly ( lnv_Equipmentlease )
		lnv_EquipmentLease.of_SetEquipmentDirectly ( lnv_Equipment )
		
		lnva_Equipmentlease [  upperBound ( lnva_Equipmentlease ) + 1 ] =  lnv_Equipmentlease
	END IF

NEXT


IF len ( Trim ( sle_out.Text ) ) > 0 THEN		
	lstr_Parm.is_Label = "DATEOUT"
	lstr_parm.ia_Value = Date ( sle_out.Text )
	lnv_Msg.of_Add_Parm ( Lstr_Parm )	
END IF

IF len (  Trim ( sle_IN.Text ) ) > 0 THEN		
	lstr_Parm.is_Label = "DATEIN"
	lstr_parm.ia_Value = Date ( sle_IN.Text )
	lnv_Msg.of_Add_Parm ( Lstr_Parm )	
END IF


lstr_Parm.is_Label = "BEOS"
Lstr_Parm.ia_Value = lnva_Equipmentlease
lnv_Msg.of_Add_Parm ( Lstr_Parm )

CloseWithReturn ( THIS , lnv_Msg )
end event

event pfc_cancel;call super::pfc_cancel;n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

lstr_Parm.is_Label = "CONTINUE"
lstr_parm.ia_Value = FALSE

lnv_Msg.of_Add_Parm ( Lstr_Parm )

CloseWithReturn ( THIS , lnv_Msg )
end event

type st_3 from statictext within w_equipment_lease_charges
integer x = 1774
integer y = 60
integer width = 59
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "IN"
boolean focusrectangle = false
end type

type st_2 from statictext within w_equipment_lease_charges
integer x = 1065
integer y = 60
integer width = 379
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Modify date OUT"
boolean focusrectangle = false
end type

type sle_in from singlelineedit within w_equipment_lease_charges
integer x = 1833
integer y = 48
integer width = 306
integer height = 72
integer taborder = 20
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

event modified;n_cst_string	lnv_String
Date	ld_Value

IF Not isDate ( this.text ) AND Len ( Trim ( THIS.Text )) > 0 THEN
	
	ld_Value = lnv_String.of_Specialdate( this.text  )
	IF isNull ( ld_Value ) THEN
		MessageBox( "Modify Dates" , "Please enter dates here." )
		THIS.Text = ""
	ELSE
		THIS.Text = String ( ld_Value )
	END IF
END IF
end event

type sle_out from singlelineedit within w_equipment_lease_charges
integer x = 1445
integer y = 48
integer width = 306
integer height = 72
integer taborder = 10
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

event modified;n_cst_string	lnv_String
Date	ld_Value

IF Not isDate ( this.text ) AND Len ( Trim ( THIS.Text )) > 0 THEN
	
	ld_Value = lnv_String.of_Specialdate( this.text  )
	IF isNull ( ld_Value ) THEN
		MessageBox( "Modify Dates" , "Please enter dates here." )
		THIS.Text = ""
	ELSE
		THIS.Text = String ( ld_Value )
	END IF
END IF
end event

type dw_1 from u_dw_equipment_lease_charges within w_equipment_lease_charges
integer x = 27
integer y = 128
integer width = 2117
integer height = 516
integer taborder = 30
boolean bringtotop = true
end type

event constructor;
n_cst_Presentation_LeaseCharges lnv_Presentation

lnv_Presentation.of_SetPresentation ( THIS )

end event

event clicked;call super::clicked;IF Row > 0 AND Upper (dwo.Name) <> "SELECTED"THEN
	CHOOSE CASE THIS.Object.Selected[row]
			
		CASE "1"
			THIS.object.Selected[row] = "0"
			
		CASE "0"
			THIS.object.Selected[row] = "1"
	END CHOOSE
END IF

RETURN AncestorReturnValue
end event

type cb_1 from u_cbok within w_equipment_lease_charges
integer x = 818
integer y = 680
integer width = 233
integer taborder = 40
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_equipment_lease_charges
integer x = 1125
integer y = 680
integer width = 233
integer taborder = 50
boolean bringtotop = true
end type

type st_1 from statictext within w_equipment_lease_charges
integer x = 32
integer y = 52
integer width = 782
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select charges to be applied."
boolean focusrectangle = false
end type

