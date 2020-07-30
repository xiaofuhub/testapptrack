$PBExportHeader$w_eq_newout.srw
$PBExportComments$Response window for entering new outside equipment.
forward
global type w_eq_newout from w_eq_base
end type
type cb_ok from commandbutton within w_eq_newout
end type
type cb_cancel from commandbutton within w_eq_newout
end type
end forward

global type w_eq_newout from w_eq_base
integer x = 818
integer y = 208
integer height = 2068
boolean controlmenu = false
boolean minbox = false
windowtype windowtype = response!
event ue_postopen ( )
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_eq_newout w_eq_newout

type variables
Protected Boolean	ib_SaveOnClose = TRUE

Private:
boolean   ib_FillInType = TRUE
end variables

event ue_postopen();String	ls_Type
String	ls_NewType
String	ls_determineNewType
String	ls_dummy
Long		ll_Length
Long		ll_Width
Long		ll_RowCount

ll_RowCount = tab_1.tabpage_lease.dw_equipment.RowCount ( )


IF ll_rowcount > 0 AND ib_FillInType THEN
	ll_Length = tab_1.tabpage_lease.dw_equipment.object.eq_length [ 1 ]
	IF ll_Length > 0 THEN
		dw_basics.SetItem ( 1 , "eq_length" , ll_Length )
	END IF
	
	ll_Width = tab_1.tabpage_lease.dw_equipment.object.eq_height [ 1 ]
	IF ll_Width > 0 THEN
		dw_basics.SetItem ( 1 , "eq_height" , ll_Width )
	END IF
	
	ls_Type = tab_1.tabpage_lease.dw_equipment.object.equipment_Type [ 1 ] 
	IF Len ( ls_Type ) > 0 THEN
		ls_determineNewType = ls_Type  		//DEK 5-22-07used for determining Ref Text on shipment
		CHOOSE CASE UPPER ( ls_Type )
				
			CASE 'C'
				ls_NewType = 'H'
			CASE 'H'
				ls_NewType = 'C'
		END CHOOSE
	END IF
	
	IF Len ( ls_NewType ) > 0 THEN
		dw_basics.SetItem ( 1 , "eq_type" , ls_NewType )
		ls_determineNewType = ls_newType		//DEK 5-22-07used for determining Ref Text on shipment
	END IF
	dw_basics.SetColumn ( "eq_ref" )
	ib_FillInType = FALSE  // we only do this when the window opens up.
	

ELSEIF ib_FillInType THEN
	
	ib_FillInType = FALSE  // we only do this when the window opens up.
	dw_basics.SetItem ( 1 , "eq_type" , 'C' )  // default to CNTN
	dw_basics.SetColumn ( "eq_ref" )
	dw_basics.object.eq_length[1] = 40
	dw_basics.object.eq_height[1] = 96
	ls_determineNewType = 'C'
END IF
//DEK 5-22-07
IF isValid(inv_shipment) THEN
	this.wf_changeshipreftexts( ls_dummy, dw_basics.getItemString ( 1,"eq_ref" ), ls_dummy,ls_determineNewType, 0)
END IF
//////////////////////////////

tab_1.event ue_typechanged(dw_basics.object.eq_type[1])



end event

event open;integer min_length
long		ll_shipid
String	as_dummy
Boolean	lb_OneWay
Boolean	lb_Import
Boolean	lb_Export
Boolean	lb_outside

s_eq_info eqstruct
s_co_Info	lstr_Pier, lstr_Cust , lstr_Co_Origin , lstr_Co_Term
n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

lnv_Msg = message.powerobjectparm

IF lnv_Msg.of_Get_Parm ( "EQSTRUCT" , lstr_Parm ) <> 0 THEN
	eqstruct = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "PIERSTRUCT" , lstr_Parm ) <> 0 THEN
	lstr_Pier = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "CUSTSTRUCT" , lstr_Parm ) <> 0 THEN
	lstr_Cust = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "ONEWAY" , lstr_Parm ) <> 0 THEN
	lb_OneWay = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "IMPORT" , lstr_Parm ) <> 0 THEN
	lb_Import = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "EXPORT" , lstr_Parm ) <> 0 THEN
	lb_Export = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "FROMSHIPMENT" , lstr_Parm ) <> 0 THEN
	ib_FromShipment = lstr_Parm.ia_Value
END IF
//added by dan 2-26-07
IF lnv_Msg.of_Get_Parm ( "SHIPMENTBEO" , lstr_Parm ) <> 0 THEN
	inv_shipment = lstr_Parm.ia_value
END IF
/////////////////
//A null value for Id indicates to only pass the structure out on close, not save the new equipment.

IF IsNull ( eqstruct.eq_Id ) THEN
	ib_SaveOnClose = FALSE
END IF


if eqstruct.eq_length > 0 then max_length = eqstruct.eq_length

choose case eqstruct.eq_type
case "H"
	dw_basics.object.eq_type.values = "CHAS~tH"
case "3"
	dw_basics.object.eq_type.values = "TRLR~tV/FLBD~tF/REFR~tR/TANK~tK/RBOX~tB" +&
		"/CHAS~tH"
case "4"
	dw_basics.object.eq_type.values = "CNTN~tC"
case "CB"
	dw_basics.object.eq_type.values = "CNTN~tC/RBOX~tB"
case "34"
	dw_basics.object.eq_type.values = "TRLR~tV/FLBD~tF/REFR~tR/TANK~tK/RBOX~tB" +&
		"/CHAS~tH/CNTN~tC"
case else
	messagebox("New Outside Equipment", "Could not process request.~n~nRequest "+&
		"cancelled.", exclamation!)
	close(this)
	return
end choose

dw_basics.insertrow(0)
dw_basics.object.eq_id[1] = 0
dw_Basics.SetColumn ( "eq_type" )  //New in 3.5.0
//This indicates "new" to d_eq_basics.  Null displays an inaccessible, empty row.
//d_eq_outside currently does not react to this value (we leave it null).
//See the discussion in cb_ok for what the id value means in the return structure.

//This was formerly just being done in "H" condition, below.
if len(eqstruct.eq_ref) > 0 then 
	dw_basics.object.eq_ref[1] = eqstruct.eq_ref

END IF
choose case eqstruct.eq_type
case "H"
	dw_basics.object.eq_type[1] = "H"
	if min_length > 0 then dw_basics.object.eq_length[1] = min_length
//	if len(eqstruct.eq_ref) > 0 then dw_basics.object.eq_ref[1] = eqstruct.eq_ref
	if eqstruct.eq_height > 0 then dw_basics.object.eq_height[1] = eqstruct.eq_height &
		else dw_basics.object.eq_height[1] = 96
	dw_basics.object.eq_axles[1] = 2
	dw_basics.setcolumn("eq_ref")
case "3", "CB"
	//No processing needed
case "4"
	dw_basics.object.eq_type[1] = "C"
	if eqstruct.eq_length > 0 then
		dw_basics.object.eq_length[1] = eqstruct.eq_length
	else
		dw_basics.object.eq_length[1] = 40
	end if
	dw_basics.object.eq_height[1] = 96
	dw_basics.setcolumn("eq_ref")
end choose

dw_basics.object.eq_status[1] = "K"
dw_basics.object.eq_outside[1] = "T"

tab_1.of_Retrieve(eqstruct.eq_Id)
tab_1.of_Initialize(eqstruct.eq_Id)

tab_1.tabpage_lease.dw_1.insertrow(0)

if eqstruct.oe_from > 0 then
	tab_1.tabpage_lease.dw_1.object.oe_from[1] = eqstruct.oe_from
	tab_1.tabpage_lease.dw_1.object.from_name[1] = eqstruct.from_name
end if
if eqstruct.oe_for > 0 then
	tab_1.tabpage_lease.dw_1.object.oe_for[1] = eqstruct.oe_for
	tab_1.tabpage_lease.dw_1.object.for_name[1] = eqstruct.for_name
end if
if len(trim(eqstruct.oe_booknum)) > 0 then &
	tab_1.tabpage_lease.dw_1.object.oe_booknum[1] = eqstruct.oe_booknum

IF lnv_msg.of_Get_Parm ( "SHIPMENT" , lstr_Parm ) <>  0 THEN
	tab_1.tabpage_lease.dw_1.object.shipment [ 1 ] = lstr_Parm.ia_Value
	il_ShipmentNumber = lstr_Parm.ia_Value
	tab_1.tabpage_lease.dw_equipment.of_RetrieveOnShipment ( lstr_Parm.ia_Value )
ELSE
	tab_1.tabpage_lease.dw_equipment.Object.Datawindow.color = RGB ( 192, 192, 192 )
END IF

if tab_1.tabpage_lease.dw_1.rowcount() > 0 then
	lb_Outside = TRUE
	tab_1.tabpage_lease.dw_equipment.BringToTop = TRUE
	tab_1.tabpage_lease.st_2.BringToTop = TRUE
	tab_1.tabpage_lease.st_1.BringToTop = TRUE

	tab_1.tabpage_lease.visible = true
	ll_ShipID = tab_1.tabpage_lease.dw_1.Object.Shipment [ 1 ] 
	
	IF ll_ShipID > 0 THEN
		tab_1.tabpage_lease.of_SetNewShipment ( ll_ShipID ) 
		tab_1.tabpage_lease.dw_Equipment.SetFilter ( "eq_id <> " + String ( dw_basics.object.eq_id [ 1 ] )   )
		tab_1.tabpage_lease.dw_Equipment.Filter ( )
	END IF
	
else
	tab_1.tabpage_lease.visible = false
end if

/// Now set up for the origination / termination stuff

IF lb_OneWay THEN
		
	IF lb_Export THEN
		lstr_Co_Origin = lstr_Cust
		lstr_Co_Term = lstr_Pier
	ELSE  // 'OTHER' OR 'Import' type
		lstr_co_Origin = lstr_Pier
		lstr_Co_Term = lstr_Cust
	END IF
ELSE
	
	lstr_Co_Origin = lstr_Pier
	lstr_Co_Term = lstr_Pier
	
END IF

IF lstr_Co_Origin.co_id > 0 THEN
	tab_1.tabpage_lease.dw_1.object.OriginationSite[1] = lstr_Co_Origin.co_id
	tab_1.tabpage_lease.dw_1.object.Origination_co_name[1] = lstr_Co_Origin.co_Name
	tab_1.tabpage_lease.dw_1.object.Origination_co_city[1] = lstr_Co_Origin.co_City
	tab_1.tabpage_lease.dw_1.object.Origination_co_State[1] = lstr_Co_Origin.co_state
END IF

IF lstr_Co_Term.co_id > 0 THEN
	tab_1.tabpage_lease.dw_1.object.TerminationSite[1] = lstr_Co_Term.co_id
	tab_1.tabpage_lease.dw_1.object.Termination_co_name[1] = lstr_Co_Term.co_Name
	tab_1.tabpage_lease.dw_1.object.Termination_co_city[1] = lstr_Co_Term.co_City
	tab_1.tabpage_lease.dw_1.object.Termination_co_State[1] = lstr_Co_Term.co_state

END IF



//tab_1.tabpage_lease.dw_1.object.Origination_co_name.tabsequence = 0
//tab_1.tabpage_lease.dw_1.object.Termination_co_name.tabsequence = 0
tab_1.tabpage_lease.dw_1.object.OriginationDate.tabsequence = 0
tab_1.tabpage_lease.dw_1.object.OriginationTime.tabsequence = 0
tab_1.tabpage_lease.dw_1.object.TerminationDate.tabsequence = 0
tab_1.tabpage_lease.dw_1.object.TerminationTime.tabsequence = 0

IF lb_Outside THEN
	tab_1.tabpage_lease.visible=true
	tab_1.Post Selecttab('tabpage_lease')
ELSE
	tab_1.tabpage_lease.visible=false
	tab_1.Post Selecttab('tabpage_extended')
END IF

THIS.Post Event ue_PostOpen ( ) 


end event

on w_eq_newout.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
end on

on w_eq_newout.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

type dw_basics from w_eq_base`dw_basics within w_eq_newout
integer y = 0
integer width = 1207
end type

event dw_basics::itemchanged;//Overriding ancestor, then calling super

Integer	li_Return
Long		ll_EqId
String	lsa_Dupes[]
String	ls_Dupes
String	ls_CurrentType
Long		ll_DupCount, i

n_cst_EquipmentManager	lnv_Manager


ls_CurrentType = this.object.eq_type[1]

/* NEW DUPE CHECK 2/26/07 */
ll_EqId = lnv_Manager.of_ExistsEquipment(data, lsa_Dupes) 

CHOOSE CASE ll_EqId
	CASE 0 //EQ DNE
		//proceed
	CASE IS > 0 //Exists
		
		IF ll_EqId = this.object.eq_id[row] THEN
			//exising equipment is this one, proceed
		ELSE
			MessageBox ( "Equipment" , "Active equipment already exists with the reference number specified.")
			li_Return = 1
		END IF
		
	CASE -2 //More than one exists, not good
		ll_DupCount = UpperBound(lsa_Dupes)
		FOR i = 1 TO ll_DupCount
			ls_Dupes += lsa_dupes[i] + "~r~n"
		NEXT
		MessageBox("Specified Equipment" , "More than one piece of equipment already exists with that reference number.~r~n" + & 
					  "Duplicate reference numbers:~r~n" + ls_Dupes, INFORMATION! )
		li_Return = 1
	CASE ELSE
		//Error
END CHOOSE


IF li_Return = 0 THEN 
	Super::Event itemchanged(row, dwo, data)
END IF

Return li_Return
end event

type tab_1 from w_eq_base`tab_1 within w_eq_newout
boolean enabled = true
end type

type cb_ok from commandbutton within w_eq_newout
event clicked pbm_bnclicked
integer x = 1586
integer y = 16
integer width = 251
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&OK"
end type

event clicked;if dw_basics.accepttext() = -1 then return
if tab_1.tabpage_lease.dw_1.accepttext() = -1 then return

s_eq_info eqstruct
Int	li_PreSaveRtn 
String	ls_Type 
String	ls_EqRef
String	ls_CdError
Long		ll_EqId
Long		ll_DupCount
Long		i
String	lsa_Dupes[]
String	ls_Dupes
n_cst_EquipmentManager	lnv_Manager


//MFS 4/10/07 - ***NEW Validation
ls_Type = dw_basics.object.eq_type[1]
ls_EqRef = dw_basics.object.eq_ref[1]

//Check that eq was entered
IF isNull(ls_EqRef) OR Len(Trim(ls_EqRef)) <= 0 OR IsNull(ls_Type) OR Len(Trim(ls_Type)) <= 0 THEN
	MessageBox("Add New Outside Equipment", "You must specify an Equipment Type and "+&
		"Reference # in order to add new equipment.")
	Return //****      mid code return  ********//
END IF

//Validate Check digit
IF UPPER(Mid(ls_EqRef, 4, 1)) = "U" THEN //4th letter 'U' denotes container
	IF lnv_Manager.of_ValidateCheckDigit(ls_EqRef, ls_CDerror) <> 1 THEN
		MessageBox ("Equipment Validation" , ls_CDerror )
		Return //****      mid code return  ********//
	END IF
END IF

//Make sure equipment Does not already exist
ll_EqId = lnv_Manager.of_ExistsEquipment(ls_EqRef, lsa_Dupes) 
CHOOSE CASE ll_EqId
	CASE 0 //EQ DNE
		//proceed
	CASE IS > 0 //Exists
		IF ll_EqId = dw_basics.object.eq_id [1] THEN
			//existing equipment is this one, allow save
		ELSE
			MessageBox ( "Equipment" , "Active equipment already exists with the reference number specified.")
			//****      mid code return  ********//
			Return
		END IF
	CASE -2 //More than one exists, not good
		ll_DupCount = UpperBound(lsa_Dupes)
		FOR i = 1 TO ll_DupCount
			ls_Dupes += lsa_dupes[i] + "~r~n"
		NEXT
		MessageBox("Specified Equipment" , "More than one piece of equipment already exists with that reference number.~r~n" + & 
					  "Duplicate reference numbers:~r~n" + ls_Dupes, INFORMATION! )
		//****      mid code return  ********//
		Return
	CASE ELSE
		//Error
END CHOOSE
//END ***NEW Validation

IF ib_SaveOnClose THEN

	//Note : 1 does not necessarily indicate success

	IF wf_save_if_needed("CLOSE_WINDOW!") = -1 THEN
		RETURN
	ELSEIF dw_Basics.Object.eq_Id [ 1 ] > 0 THEN
		//OK
	ELSE
		//Save didn't go through (by error or by choice), but user wants to close anyway.
		CloseWithReturn ( Parent, eqstruct )
		RETURN
	END IF
	
END IF

//eqstruct.eq_id = dw_basics.object.eq_id[1]
//Calling scripts expect id = null or > 0
// 0 (which is used in the d_eq_basics to mean new) means cancel when returned in the structure

IF ib_SaveOnClose THEN
	eqstruct.eq_id = dw_Basics.Object.eq_Id [ 1 ]
ELSE
	SetNull ( eqstruct.eq_id )
END IF

eqstruct.eq_type = dw_basics.object.eq_type[1]
eqstruct.eq_ref = dw_basics.object.eq_ref[1]
eqstruct.eq_outside = dw_basics.object.eq_outside[1]
eqstruct.eq_status = dw_basics.object.eq_status[1]
eqstruct.eq_length = dw_basics.object.eq_length[1]
eqstruct.eq_height = dw_basics.object.eq_height[1]
eqstruct.eq_axles = dw_basics.object.eq_axles[1]
eqstruct.eq_air = dw_basics.object.eq_air[1]
eqstruct.eq_spec1 = dw_basics.object.eq_spec1[1]
eqstruct.eq_spec2 = dw_basics.object.eq_spec2[1]
eqstruct.eq_spec3 = dw_basics.object.eq_spec3[1]
eqstruct.eq_spec4 = dw_basics.object.eq_spec4[1]
eqstruct.eq_spec5 = dw_basics.object.eq_spec5[1]
eqstruct.eq_cur_event = dw_basics.object.eq_cur_event[1]
eqstruct.eq_next_event = dw_basics.object.eq_next_event[1]

eqstruct.oe_from = tab_1.tabpage_lease.dw_1.object.oe_from[1]
eqstruct.oe_for = tab_1.tabpage_lease.dw_1.object.oe_for[1]
eqstruct.oe_booknum = tab_1.tabpage_lease.dw_1.object.oe_booknum[1]
SetNull ( eqstruct.oe_out ) //= null_datetime
SetNull ( eqstruct.oe_in ) //= null_datetime
SetNull ( eqstruct.oe_orig_event ) //= null_long
SetNull ( eqstruct.oe_term_event ) //= null_long
eqstruct.from_name = tab_1.tabpage_lease.dw_1.object.from_name[1]
eqstruct.for_name = tab_1.tabpage_lease.dw_1.object.for_name[1]
eqstruct.fkequipmentleasetype = long ( tab_1.tabpage_lease.dw_1.object.equipmentlease_fkequipmentleasetype[1] )

if len(trim(eqstruct.eq_ref)) > 0 then
	closewithreturn(parent, eqstruct)
elseif isnull(eqstruct.eq_type) then
	messagebox("Add New Outside Equipment", "You must specify an Equipment Type and "+&
		"Reference # in order to add the equipment to the database.")
	dw_basics.setcolumn("eq_type")
	dw_basics.setfocus()
else
	messagebox("Add New Outside Equipment", "You must specify a Reference # in order "+&
		"to add the equipment to the database.")
	dw_basics.setcolumn("eq_ref")
	dw_basics.setfocus()
end if

end event

type cb_cancel from commandbutton within w_eq_newout
event clicked pbm_bnclicked
integer x = 1893
integer y = 16
integer width = 251
integer height = 88
integer taborder = 50
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;s_eq_info eqstruct
closewithreturn(parent, eqstruct)
end event

