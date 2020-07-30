$PBExportHeader$u_tabpg_equipment_registration.sru
forward
global type u_tabpg_equipment_registration from u_tabpg_equipment
end type
type dw_registration from u_dw_equipmentregistration within u_tabpg_equipment_registration
end type
type dw_apportion from u_dw within u_tabpg_equipment_registration
end type
type dw_permit from u_dw within u_tabpg_equipment_registration
end type
type gb_2 from groupbox within u_tabpg_equipment_registration
end type
type gb_1 from groupbox within u_tabpg_equipment_registration
end type
end forward

global type u_tabpg_equipment_registration from u_tabpg_equipment
dw_registration dw_registration
dw_apportion dw_apportion
dw_permit dw_permit
gb_2 gb_2
gb_1 gb_1
end type
global u_tabpg_equipment_registration u_tabpg_equipment_registration

forward prototypes
public subroutine of_retrieve (long al_eqid)
public function long of_getmodifiedcount ()
public subroutine of_setnewequipmentid (long al_value)
public subroutine of_typechanged (string as_eqtype)
public subroutine of_clearblankrows ()
public subroutine of_initialize (long al_eqid)
end prototypes

public subroutine of_retrieve (long al_eqid);dw_registration.retrieve(al_eqid)

dw_apportion.retrieve(al_eqid)

dw_permit.retrieve(al_eqid)

end subroutine

public function long of_getmodifiedcount ();long	ll_count

ll_count = dw_permit.modifiedcount( )
ll_count = ll_count + dw_apportion.modifiedcount()
ll_count = ll_count + dw_registration.modifiedcount()

ll_Count+= dw_apportion.DeletedCount ( )
ll_Count+= dw_Permit.DeletedCount ( )

return ll_count
end function

public subroutine of_setnewequipmentid (long al_value);long ll_row, ll_rowcount

choose case dw_registration.Getitemstatus(1,0,Primary!)
	case datamodified!
		dw_registration.object.equipmentid[1] = al_value
		dw_registration.SetItemStatus(1, 'equipmentid', Primary!, NotModified!)

	case notmodified!, new!
		dw_registration.object.equipmentid[1] = al_value
		dw_registration.SetItemStatus(1, 0, Primary!, NotModified!)

	case else
		dw_registration.object.equipmentid[1] = al_value
		
end choose


choose case dw_apportion.Getitemstatus(1,0,Primary!)
	case datamodified!
		ll_rowcount = dw_apportion.rowcount()
		for ll_row = 1 to ll_rowcount
			dw_apportion.object.equipmentid[ll_row] = al_value
			dw_apportion.SetItemStatus(ll_row, 'equipmentid', Primary!, NotModified!)
		next
		
	case notmodified!, new!
		ll_rowcount = dw_apportion.rowcount()
		for ll_row = 1 to ll_rowcount
			dw_apportion.object.equipmentid[ll_row] = al_value
			dw_apportion.SetItemStatus(ll_row, 0, Primary!, NotModified!)
		next

	case else
		ll_rowcount = dw_apportion.rowcount()
		for ll_row = 1 to ll_rowcount
			dw_apportion.object.equipmentid[ll_row] = al_value
		next

end choose

choose case dw_permit.Getitemstatus(1,0,Primary!)
	case datamodified!
		dw_permit.object.equipmentid[1] = al_value
		dw_permit.SetItemStatus(1, 'equipmentid', Primary!, NotModified!)
		
	case notmodified!, new!
		dw_permit.object.equipmentid[1] = al_value
		dw_permit.SetItemStatus(1, 0, Primary!, NotModified!)

	case else
		dw_permit.object.equipmentid[1] = al_value		

end choose





end subroutine

public subroutine of_typechanged (string as_eqtype);n_cst_EquipmentManager	lnv_EquipmentManager

dw_apportion.visible=false
dw_permit.visible=false

gb_1.visible=false
gb_2.visible=false

choose case as_eqtype
	case lnv_EquipmentManager.cs_TRAC, lnv_EquipmentManager.cs_STRT
		
		dw_apportion.visible=true
		dw_permit.visible=true
		
		gb_1.visible=true
		gb_2.visible=true

		dw_apportion.bringtotop=true
		dw_permit.bringtotop=true

end choose
	
end subroutine

public subroutine of_clearblankrows ();long	ll_rowcount, &
		ll_ndx

string	ls_id

ll_rowcount = dw_permit.rowcount()

for ll_ndx = ll_rowcount to 1 step -1
	ls_id = dw_permit.object.description[ll_ndx]
	if isnull(ls_id) or len(ls_id) = 0 then
		dw_permit.RowsDiscard ( ll_ndx, ll_ndx, Primary! )
	end if
next


ll_rowcount = dw_apportion.rowcount()

for ll_ndx = ll_rowcount to 1 step -1
	ls_id = dw_apportion.object.state[ll_ndx]
	if isnull(ls_id) or len(ls_id) = 0 then
		dw_apportion.RowsDiscard ( ll_ndx, ll_ndx, Primary! )
	end if
next
end subroutine

public subroutine of_initialize (long al_eqid);long	ll_row

if dw_registration.rowcount() > 0 then
	//ok
else
	ll_row = dw_registration.insertrow(0)
	if ll_row > 0 then
		dw_registration.object.equipmentid[ll_row] = al_eqid
		dw_registration.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	end if
end if

//add  a new row at end
ll_row = dw_apportion.insertrow(0)
if ll_row > 0 then
	dw_apportion.object.equipmentid[ll_row] = al_eqid
	dw_apportion.object.state[ll_row] = " "
	dw_apportion.SetItemStatus(ll_row, 0, Primary!, NotModified!)
end if

//add a new row at end
ll_row = dw_permit.insertrow(0)
if ll_row > 0 then
	dw_permit.object.equipmentid[ll_row] = al_eqid
	dw_permit.SetItemStatus(ll_row, 0, Primary!, NotModified!)
end if

end subroutine

on u_tabpg_equipment_registration.create
int iCurrent
call super::create
this.dw_registration=create dw_registration
this.dw_apportion=create dw_apportion
this.dw_permit=create dw_permit
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_registration
this.Control[iCurrent+2]=this.dw_apportion
this.Control[iCurrent+3]=this.dw_permit
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.gb_1
end on

on u_tabpg_equipment_registration.destroy
call super::destroy
destroy(this.dw_registration)
destroy(this.dw_apportion)
destroy(this.dw_permit)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event constructor;call super::constructor;PowerObject lpoa_UpdateControls[ ]

lpoa_UpdateControls [ 1 ] = dw_registration

lpoa_UpdateControls [ 2 ] = dw_apportion

lpoa_UpdateControls [ 3 ] = dw_permit
			
of_SetUpdateObjects ( lpoa_UpdateControls )

end event

type dw_registration from u_dw_equipmentregistration within u_tabpg_equipment_registration
integer x = 55
integer y = 12
integer height = 788
integer taborder = 10
end type

type dw_apportion from u_dw within u_tabpg_equipment_registration
integer x = 411
integer y = 864
integer width = 750
integer height = 268
integer taborder = 20
string dataobject = "d_eq_apportion"
boolean border = false
end type

event constructor;call super::constructor;this.SetTransObject(SQLCA)

n_cst_Presentation_State	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )


end event

event itemchanged;call super::itemchanged;long	ll_found, &
		ll_return

choose case dwo.name 
	case 'state'
//		ll_found = THIS.FInd ( "state = '" + data + "'" , 1 , this.rowcount() )
//		if ll_found > 0 then
//			if ll_found = row then
//				ll_found = THIS.FInd ( "location = '" + data + "'" , ll_found + 1 , this.rowcount() )
//				if ll_found > 0 then
//					ll_Return = 1
//					MessageBox ( "Apportion State" , "The state selected already exists." )
//					THIS.object.state[row] = ' '
//				end if
//			else
//				ll_Return = 1
//				MessageBox ("Apportion State" , "The state selected already exists." )
//				THIS.object.state[row] = ' '
//			end if
//		END IF
			
		if ll_return = 1 then
			//don't add row
		else
			if this.rowcount() = row then
					this.Event PFC_AddRow()
			end if
		end if
		
end choose

return ll_return
end event

event pfc_addrow;call super::pfc_addrow;String	ls_name
Long		ll_Return

ll_return = AncestorReturnValue

IF ll_Return > 0 THEN
	
	this.object.equipmentid[ll_return] = this.object.equipmentid[1]
	this.object.state[ll_return] = " "
	
END IF

RETURN ll_Return

end event

event pfc_preupdate;call super::pfc_preupdate;long	ll_return, &
		ll_row, &
		ll_rowcount

ll_return = AncestorReturnValue

if ll_return = 1 then
	ll_RowCount = this.RowCount ( )
	FOR ll_row = ll_RowCount TO 1 STEP -1
		IF len ( trim ( this.GetItemString ( ll_row , "state", Primary!, false ) ) ) = 0 THEN
			this.RowsDiscard ( ll_row, ll_row, Primary! ) 
		END IF	
	NEXT
end if

return ll_return

end event

event itemerror;call super::itemerror;long ll_return

	choose case dwo.name
		case 'state'
			ll_return = 1
	end choose

return ll_return
end event

event rowfocuschanging;call super::rowfocuschanging;long 	ll_found, &
		ll_return
		
string	ls_state


if currentrow > 0 then
	if this.rowcount() > 0 and currentrow < this.rowcount() then
		ls_state = this.object.state[currentrow]
		
		ll_found = THIS.FInd ( "state = '" + ls_state + "'" , 1 , this.rowcount() )
		if ll_found > 0 then
			if ll_found = currentrow then
				if ll_found <> this.rowcount() then
					ll_found = THIS.FInd ( "state = '" + ls_state + "'" , ll_found + 1 , this.rowcount() )
					if ll_found > 0 then
						ll_Return = 1
						MessageBox ( "Apportion State" , "The state selected already exists." )
						THIS.object.state[currentrow] = ' '
					end if
				end if
			else
				ll_Return = 1
				MessageBox ("Apportion State" , "The state selected already exists." )
				THIS.object.state[currentrow] = ' '
			end if
		END IF
	end if
end if

return ll_return

end event

type dw_permit from u_dw within u_tabpg_equipment_registration
integer x = 114
integer y = 1284
integer width = 1559
integer height = 248
integer taborder = 30
string dataobject = "d_eq_permit"
boolean border = false
end type

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

event editchanged;call super::editchanged;choose case dwo.name 
	case 'permitnumber'
		if this.rowcount() = row then
				this.Event PFC_AddRow()
		end if
end choose

end event

event itemerror;call super::itemerror;Boolean	lb_Processed
string errcol
errcol = dwo.name
n_cst_string lnv_string

date compdate
time comptime

choose case errcol

case "expirationdate"

	//Attempt to convert the text typed to a date
	compdate = lnv_string.of_SpecialDate(data)

	if isnull(compdate) then
		//Value is really invalid

	ELSE
		this.setitem(row, errcol, compdate)
	
	
		lb_Processed = TRUE

	END IF

end choose


IF NOT lb_Processed THEN
	messagebox("Edit Value", "The value you have entered is invalid.  It will be "+&
		"replaced by the previous value.")
END IF

return 3
end event

event pfc_addrow;call super::pfc_addrow;String	ls_name
Long		ll_Return

ll_return = AncestorReturnValue

IF ll_Return > 0 THEN
	
	this.object.equipmentid[ll_return] = this.object.equipmentid[1]
	
END IF

RETURN ll_Return

end event

event pfc_accepttext;call super::pfc_accepttext;String	ls_Sort
String	ls_Filter
Long		ll_Row
Long		ll_RowID
Int		li_Return = 1

ls_Sort = "description A"
ls_Filter = "description = description[1] OR description = description[-1]"

THIS.SetRedraw ( FALSE )

THIS.SetSort ( ls_Sort )
THIS.Sort ( )

THIS.SetFilter( ls_Filter )
THIS.Filter ( ) 

IF THIS.RowCount ( ) > 0 THEN
	li_Return = -1
	ll_RowID = THIS.GetRowIDFromrow( 1 )
	MessageBox ( "Permit Descriptions" , "Unique descriptions are required for each permit." )
END IF

THIS.SetFilter ( "" )
THIS.Filter ( )

IF ll_RowID > 0 And ab_focusonerror THEN
	ll_Row = THIS.GetRowfromrowid( ll_RowID )
	IF ll_Row > 0 THEN
		THIS.ScrollToRow ( ll_Row ) 
		THIS.SetRow ( ll_Row ) 
		THIS.SetColumn ( "description" )
		THIS.SelectText(1, Len(THIS.GetText()))
		THIS.Post Setfocus ( )
	END IF
END IF

THIS.SetRedraw ( TRUE )

RETURN li_Return
end event

type gb_2 from groupbox within u_tabpg_equipment_registration
integer x = 73
integer y = 1200
integer width = 1614
integer height = 380
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Permits"
end type

type gb_1 from groupbox within u_tabpg_equipment_registration
integer x = 73
integer y = 796
integer width = 1614
integer height = 380
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Apportion"
end type

