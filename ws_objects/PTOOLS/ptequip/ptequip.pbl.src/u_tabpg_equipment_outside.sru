$PBExportHeader$u_tabpg_equipment_outside.sru
forward
global type u_tabpg_equipment_outside from u_tabpg_equipment
end type
type dw_equipment from u_dw_eqlist within u_tabpg_equipment_outside
end type
type st_1 from statictext within u_tabpg_equipment_outside
end type
type st_2 from statictext within u_tabpg_equipment_outside
end type
type dw_1 from u_dw_equipmentoutside within u_tabpg_equipment_outside
end type
end forward

global type u_tabpg_equipment_outside from u_tabpg_equipment
integer height = 1676
string text = "Leased"
long tabbackcolor = 12632256
event ue_typechange ( string as_value )
dw_equipment dw_equipment
st_1 st_1
st_2 st_2
dw_1 dw_1
end type
global u_tabpg_equipment_outside u_tabpg_equipment_outside

type variables
long	il_shipmentnumber
end variables

forward prototypes
public subroutine of_typechanged (string as_eqtype)
public subroutine wf_setnewshipment ()
public subroutine of_setnewshipment (long al_ship)
public function long of_getmodifiedcount ()
public subroutine of_setnewequipmentid (long al_value)
public function long of_getequipmentdw (ref u_dw adw_equipment)
end prototypes

public subroutine of_typechanged (string as_eqtype);
end subroutine

public subroutine wf_setnewshipment ();
end subroutine

public subroutine of_setnewshipment (long al_ship);IF al_ship > 0 THEN
	dw_equipment.of_RetrieveOnShipment ( al_ship )
	il_shipmentnumber = al_ship
ELSE 
	dw_Equipment.Reset ( )
END IF
dw_1.SetFocus ( )

end subroutine

public function long of_getmodifiedcount ();long	ll_count

ll_count = dw_1.modifiedcount()

ll_count = ll_count + dw_equipment.modifiedcount()

return ll_count
end function

public subroutine of_setnewequipmentid (long al_value);INT	li_Return

choose case dw_1.Getitemstatus(1,0,Primary!)
	case datamodified!
		dw_1.object.oe_id[1] = al_value
		dw_1.SetItemStatus(1, 'oe_id', Primary!, NotModified!)
		
	case notmodified! //, new!
		dw_1.object.oe_id[1] = al_value
		dw_1.SetItemStatus(1, 0, Primary!, NotModified!)
	case newModified!
		dw_1.object.oe_id[1] = al_value
	//li_Return =	dw_1.SetItemStatus(1, 0, Primary!, NEW!)
	li_Return =	dw_1.SetItemStatus(1, 0, Primary!, newModified!)
	case else
		dw_1.object.oe_id[1] = al_value
		
end choose
end subroutine

public function long of_getequipmentdw (ref u_dw adw_equipment);//created by Dan 5-21-07
adw_equipment = dw_equipment
RETURN dw_equipment.rowCount()
end function

on u_tabpg_equipment_outside.create
int iCurrent
call super::create
this.dw_equipment=create dw_equipment
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_equipment
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_1
end on

on u_tabpg_equipment_outside.destroy
call super::destroy
destroy(this.dw_equipment)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
end on

type dw_equipment from u_dw_eqlist within u_tabpg_equipment_outside
integer x = 174
integer y = 220
integer width = 1422
integer height = 288
integer taborder = 0
boolean bringtotop = true
end type

event dw_equipment::clicked;call super::clicked;Long	ll_NewShipID 

IF row > 0 THEN
	
	ll_NewShipID = THIS.Object.outside_equip_shipment [ ROW ]
	
	IF ll_NewShipID > 0 AND ll_NewShipID <> il_ShipmentNumber THEN
		il_ShipmentNumber = ll_NewShipID
		wf_SetNewShipment ( )
	END IF
	
END IF
	
end event

event losefocus;call super::losefocus;IF il_ShipmentNumber > 0 THEN
	this.of_RetrieveOnShipment ( il_ShipmentNumber )
ELSE 
	this.Reset ( )
END IF
//st_2.SetRedraw ( FALSE )
//
//st_2.Weight = 400
//st_2.TextColor = RGB ( 0,0,0 )
//st_2.Text = "Other equipment linked"
//
//st_1.Visible = TRUE 
//st_2.SetRedraw ( TRUE )
//dw_1.SetFocus ( )

end event

event constructor;this.settransobject( sqlca )

call super::constructor

end event

type st_1 from statictext within u_tabpg_equipment_outside
integer x = 933
integer y = 64
integer width = 663
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Other equipment linked"
boolean focusrectangle = false
end type

type st_2 from statictext within u_tabpg_equipment_outside
integer x = 933
integer y = 128
integer width = 494
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = " to this shipment. "
boolean focusrectangle = false
end type

type dw_1 from u_dw_equipmentoutside within u_tabpg_equipment_outside
event type integer ue_clearorigdatetime ( long al_row )
event ue_clearoriginationevent ( long al_row )
event type integer ue_cleartermdatetime ( long al_row )
event ue_clearterminationevent ( long al_row )
event processenter pbm_dwnprocessenter
integer x = 151
integer y = 28
integer taborder = 10
end type

event type integer ue_clearorigdatetime(long al_row);Date ld_null
Time	lt_Null

SetNull ( ld_null )
ld_Null =  Date ( DateTime ( ld_null ) ) 

SetNull ( lt_Null )

THIS.object.originationDate [ al_Row ] = ld_Null
THIS.object.originationTime [ al_Row ] = lt_Null


RETURN 1

end event

event ue_clearoriginationevent(long al_row);Long	ll_Null
SetNull ( ll_Null )

THIS.Object.oe_Orig_Event [ al_row ] = ll_Null

end event

event type integer ue_cleartermdatetime(long al_row);Date ld_null
Time	lt_Null
SetNull ( ld_null )
ld_Null =  Date ( DateTime ( ld_null ) ) 
SetNull ( lt_Null )

THIS.object.TerminationDate [ al_Row ] = ld_Null
THIS.object.TerminationTime [ al_Row ] = lt_Null

RETURN 1

end event

event ue_clearterminationevent(long al_row);Long	ll_Null
SetNull ( ll_Null )

THIS.Object.oe_Term_Event [ al_row ] = ll_Null

end event

event processenter;send(handle(this), 256, 9, long(0, 0))
return 1

end event

event buttonclicked;call super::buttonclicked;CHOOSE CASE Lower ( dwo.Name )

CASE Lower ( "cb_Type" )
	n_cst_taskmanager_SelectLeaseType	lnv_TaskManager
	n_cst_beo_EquipmentLeaseType			lnv_EquipmentLeaseType

	lnv_TaskManager = CREATE n_cst_taskmanager_SelectLeaseType
	lnv_TaskManager.BeginTask ( )

//	This might be another way to accomplish the same thing as BeginTask??
//	It didn't get a beo back either, though.
//	lnv_TaskManager.Navigate ( "Entry to EquipmentLeaseTypes1" )

	
	lnv_EquipmentLeaseType = message.powerobjectParm
	
	IF IsValid ( lnv_EquipmentLeaseType ) THEN
		This.Object.EquipmentLease_fkEquipmentLeaseType [ 1 ] = lnv_EquipmentLeaseType.of_GetId ( )
		This.Object.EquipmentLeaseType_Line [ 1 ] = lnv_EquipmentLeaseType.of_GetLine ( )
		This.Object.EquipmentLeaseType_Type [ 1 ] = lnv_EquipmentLeaseType.of_GetType ( )
	END IF

	DESTROY lnv_TaskManager

END CHOOSE
end event

event constructor;call super::constructor;Boolean	lb_deactivationAllowed

n_cst_privileges	lnv_Privs
lb_deactivationAllowed = lnv_Privs.of_HasEquipmentDeactivationRights ( )



IF lb_deactivationAllowed THEN
	
	this.object.originationDate.Protect = 0
	this.object.OriginationTime.Protect = 0
	this.object.TerminationTime.Protect = 0
	this.object.TerminationDate.Protect = 0
	
	this.object.originationDate.Background.Color = RGB ( 255,255,255 )
	this.object.OriginationTime.Background.Color = RGB ( 255,255,255 )
	this.object.TerminationTime.Background.Color = RGB ( 255,255,255 )
	this.object.TerminationDate.Background.Color = RGB ( 255,255,255 )
	
END IF


IF lnv_Privs.of_HasSysAdminRights ( ) THEN
	this.object.Shipment.Protect = 0
	this.object.Shipment.Background.Color = RGB ( 255,255,255 )
END IF
end event

event itemchanged;call super::itemchanged;s_co_info lstr_company
Time	lt_null
SetNull ( lt_Null )
choose case Lower ( dwo.name )

CASE "equipmentleasetype_line"
	THIS.object.equipmentleasetype_type[row] =  data 
	This.Object.EquipmentLease_fkEquipmentLeaseType [ 1 ] = Long ( data )
	This.Object.EquipmentLeaseType_Line [ 1 ] = data

case "from_name", "for_name", "origination_co_name" , "termination_co_name"
	
	if gnv_cst_companies.of_select(lstr_company, "ANY!", true, data, false, 0, false, true) = 1 then
		choose case dwo.name
		case "from_name"
			this.object.oe_from[row] = lstr_company.co_id
		case "for_name"
			this.object.oe_for[row] = lstr_company.co_id
		case "termination_co_name"
			this.object.terminationSite[row] = lstr_company.co_id
			this.object.termination_co_City[row] = lstr_company.co_city
			this.object.termination_co_State[row] = lstr_company.co_State
			this.object.termination_co_Zip[row] = lstr_company.co_Zip
			THIS.Event ue_ClearTerminationEvent ( row )
			// WE decided to take this out because it was a pain in the neck to have to fill 
			// them back in ( 3.5.0 12/28/2001 )
			//THIS.Event ue_ClearTermDateTime ( Row )
			
		case "origination_co_name"
			this.object.originationSite[row] = lstr_company.co_id
			this.object.origination_co_City[row] = lstr_company.co_City
			this.object.origination_co_State[row] = lstr_company.co_State
			this.object.origination_co_Zip[row] = lstr_company.co_Zip
			THIS.Event ue_ClearOriginationEvent ( row )
			//THIS.Event ue_ClearOrigDateTime ( Row )
			
		
		end choose
		dwo.primary[row] = lstr_company.co_name
	
		
	else
		this.settext(substitute(dwo.primary[row], null_str, ""))
	end if


	return 2
CASE "terminationdate"
	IF IsNull ( data )  THEN
		THIS.object.terminationtime [ row ] = lt_Null
	END IF
	
CASE "originationdate"
	IF IsNull ( data ) THEN
		THIS.object.originationtime [ row ] = lt_Null
	END IF
	
Case "shipment"
	
	n_cst_ShipmentManager	lnv_ShipmentManager
	IF Len ( Data ) > 0 THEN
	
		dw_equipment.Reset ( )
	
	ELSEIF isNumber ( data ) THEN
		IF lnv_ShipmentManager.of_ShipmentExists ( Long ( data ) ) THEN
		
			IF THIS.acceptText () = 1 THEN
				dw_Equipment.of_RetrieveOnShipment ( Long ( data ) )
				THIS.Event ue_ClearTerminationEvent ( row )
				THIS.Event ue_ClearOrigDateTime ( Row )
				THIS.Event ue_ClearOriginationEvent ( row )
				THIS.Event ue_ClearTermDateTime ( Row )
				
				return 0
			ELSE
				RETURN 2
			END IF
			
		ELSE
			MessageBox ( "Associated Shipment" , "The shipment you specified does not exist." )
			RETURN 2
		END IF
		
	ELSE
		
		IF left(data, 2) = "//" and len(data) > 2 then  // searching on container
			data = TRIM ( right(data, len(data) - 2) )
			IF dw_equipment.of_Retrieve ( data ) <> -1 THEN
				dw_equipment.SetFocus ( )
			ELSE
				MessageBox ( "Equipment Lookup" , "An error occurred while attempting to find an associated shipment." )
			END IF

		END IF
		
	END IF
end choose

end event

event itemerror;call super::itemerror;/* 0  (Default) Reject the data value and show an error message box
	1  Reject the data value with no message box
	2  Accept the data value
	3  Reject the data value but allow focus to change

*/
n_cst_string lnv_string

date compdate
time comptime
Boolean	lb_Processed
Long	ll_Rtn

CHOOSE CASE LOWER ( dwo.Name )
	CASE "shipment"
		
		lb_Processed = TRUE
		
		IF left(data, 2) = "//" and len(data) > 2 then  // searching on container
			data = right(data, len(data) - 2)
			IF dw_equipment.of_Retrieve ( data ) <> -1 THEN
				st_2.Text = "Search Results"
				st_1.Visible = FALSE
				st_2.TextColor = RGB( 255, 0, 0 )
				st_2.weight = 700
				dw_equipment.SetFocus ( )
		
				ll_Rtn = 3
				
			ELSE
				MessageBox ( "Equipment Lookup" , "An error occurred while attempting to find an associated shipment." )
			END IF
		END IF
	CASE "originationdate" , "terminationdate"
		
		ll_Rtn = 3
		
		//Attempt to convert the text typed to a date
		compdate = lnv_string.of_SpecialDate(data)

		if isnull(compdate) then
			//Value is really invalid
	
		ELSE
			this.setitem(row, String (dwo.Name), compdate)
				
			lb_Processed = TRUE
	
		END IF

	CASE "originationtime" , "terminationtime"
		ll_Rtn = 3
		//Attempt to convert the text typed to a time
		comptime = lnv_string.of_SpecialTime(data)

		if isnull(comptime) then
			//Value is really invalid
	
		ELSE
			this.setitem(row, String (dwo.Name), comptime)
		
			lb_Processed = TRUE
	
		END IF
		
END CHOOSE




IF NOT lb_Processed THEN
	messagebox("Edit Value", "The value you have entered is invalid.  It will be "+&
		"replaced by the previous value.")
		
END IF


RETURN ll_Rtn

end event

