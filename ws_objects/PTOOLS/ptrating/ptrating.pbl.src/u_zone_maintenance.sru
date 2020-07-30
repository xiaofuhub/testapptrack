$PBExportHeader$u_zone_maintenance.sru
forward
global type u_zone_maintenance from u_base
end type
type cb_newzone from commandbutton within u_zone_maintenance
end type
type cb_deletezone from commandbutton within u_zone_maintenance
end type
type gb_locations from groupbox within u_zone_maintenance
end type
type gb_1 from groupbox within u_zone_maintenance
end type
type cb_newlocation from commandbutton within u_zone_maintenance
end type
type cb_deletelocation from commandbutton within u_zone_maintenance
end type
type dw_zonelocation from u_dw_zonelocation within u_zone_maintenance
end type
type dw_zone from u_dw_zone within u_zone_maintenance
end type
type dw_1 from u_dw_ratelinkzone within u_zone_maintenance
end type
type uo_1 from u_cst_zonelocation within u_zone_maintenance
end type
end forward

global type u_zone_maintenance from u_base
integer width = 2738
integer height = 1928
long backcolor = 12632256
event type integer ue_savechanges ( string as_zone,  boolean ab_message )
cb_newzone cb_newzone
cb_deletezone cb_deletezone
gb_locations gb_locations
gb_1 gb_1
cb_newlocation cb_newlocation
cb_deletelocation cb_deletelocation
dw_zonelocation dw_zonelocation
dw_zone dw_zone
dw_1 dw_1
uo_1 uo_1
end type
global u_zone_maintenance u_zone_maintenance

type variables
private:
n_cst_bso_rating	inv_rating
String	is_Zone
datawindowchild		idwc_zonename
n_ds	ids_rate
n_ds	ids_locationcopy
string	is_OriginalSelect
end variables

forward prototypes
public function long of_retrievezones ()
public subroutine of_filterlocations (long al_row)
public subroutine of_setlocationzone (string as_zone)
public function integer of_allowclose ()
public function string of_getzone ()
public function n_ds of_getratecache ()
public function long of_getmodifiedcount ()
end prototypes

public function long of_retrievezones ();long	ll_rowcount
string	ls_zone

ll_rowcount = dw_zone.retrieve()
if ll_rowcount > 0 then
	dw_zonelocation.retrieve()
	commit;
	this.of_filterlocations(1)
else
	dw_zone.insertrow(0)
//	dw_zonelocation.insertrow(0)
	
end if

dw_zone.setrow(1)
dw_zone.setcolumn(1)
dw_zone.SetFocus()
this.of_setlocationzone(dw_zone.object.name[1])
// added this set item status on 10/19/06 for issue 2146
dw_zonelocation.SetItemStatus ( 1 ,0 ,Primary! , NotModified! )	

return ll_rowcount

end function

public subroutine of_filterlocations (long al_row);string	ls_zone, &
			ls_filter

ls_zone=dw_zone.object.name[al_row]
if isnull(ls_zone) then
	ls_zone = ''
end if
ls_filter = "zonename = '" + trim(ls_zone) + "'"
dw_zonelocation.setfilter(ls_filter)
dw_zonelocation.filter()

end subroutine

public subroutine of_setlocationzone (string as_zone);long	ll_rowcount, &
		ll_ndx

ll_rowcount = dw_zonelocation.rowcount()
is_Zone = as_Zone
if ll_rowcount > 0 then
	//zonename should already be set
//	for ll_ndx = 1 to ll_rowcount
//		dw_zonelocation.object.zonename[ll_ndx] = trim(as_zone)
//	next
else
	dw_zonelocation.insertrow(0)
	dw_zonelocation.object.zonename[1] = trim(as_zone)
end if 
end subroutine

public function integer of_allowclose ();RETURN dw_zone.of_AllowClose ( )
end function

public function string of_getzone ();return is_zone
end function

public function n_ds of_getratecache ();return ids_rate
end function

public function long of_getmodifiedcount ();long	ll_count

ll_count = dw_zone.modifiedcount()
ll_count += dw_zone.deletedcount()
ll_count += dw_zonelocation.modifiedcount()
ll_count += dw_zonelocation.deletedcount()
if isvalid(ids_rate) then
	ll_count += ids_rate.deletedcount()
end if

return ll_count


end function

on u_zone_maintenance.create
int iCurrent
call super::create
this.cb_newzone=create cb_newzone
this.cb_deletezone=create cb_deletezone
this.gb_locations=create gb_locations
this.gb_1=create gb_1
this.cb_newlocation=create cb_newlocation
this.cb_deletelocation=create cb_deletelocation
this.dw_zonelocation=create dw_zonelocation
this.dw_zone=create dw_zone
this.dw_1=create dw_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_newzone
this.Control[iCurrent+2]=this.cb_deletezone
this.Control[iCurrent+3]=this.gb_locations
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_newlocation
this.Control[iCurrent+6]=this.cb_deletelocation
this.Control[iCurrent+7]=this.dw_zonelocation
this.Control[iCurrent+8]=this.dw_zone
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.uo_1
end on

on u_zone_maintenance.destroy
call super::destroy
destroy(this.cb_newzone)
destroy(this.cb_deletezone)
destroy(this.gb_locations)
destroy(this.gb_1)
destroy(this.cb_newlocation)
destroy(this.cb_deletelocation)
destroy(this.dw_zonelocation)
destroy(this.dw_zone)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event constructor;call super::constructor;inv_rating = create n_cst_bso_rating
dw_1.GetChild('zone',idwc_zonename)
dw_zone.sharedata(idwc_zonename)
ids_locationcopy = create n_ds
ids_locationcopy.dataobject='d_zonelocation'
ids_locationcopy.settransobject(sqlca)


end event

event destructor;call super::destructor;//if isvalid ( inv_bso_zonemanager ) then
//	destroy inv_bso_zonemanager
//end if
end event

type cb_newzone from commandbutton within u_zone_maintenance
integer x = 2126
integer y = 76
integer width = 247
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ne&w"
end type

event clicked;dw_zone.Event pfc_AddRow () 
end event

type cb_deletezone from commandbutton within u_zone_maintenance
integer x = 2418
integer y = 76
integer width = 247
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delet&e"
end type

event clicked;dw_zone.Event pfc_DeleteRow ( )
end event

type gb_locations from groupbox within u_zone_maintenance
event ue_settext ( )
integer x = 9
integer y = 388
integer width = 2697
integer height = 1116
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Locations"
end type

event ue_settext;String 	ls_Name

ls_name = dw_zone.GetItemString ( dw_zone.GetRow ( ) , "name" )
IF NOT isNull ( ls_Name ) THEN
	THIS.Text = "&Locations for " + ls_Name 
ELSE
	THIS.Text = "&Locations"
END IF
end event

type gb_1 from groupbox within u_zone_maintenance
integer x = 9
integer y = 8
integer width = 2697
integer height = 372
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Zones"
end type

type cb_newlocation from commandbutton within u_zone_maintenance
integer x = 2126
integer y = 464
integer width = 247
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&New"
end type

event clicked;long	ll_return

ll_return = dw_zonelocation.Event pfc_AddRow ( )

dw_zonelocation.ScrollToRow ( ll_Return ) 
dw_zonelocation.SetRow ( ll_Return )
dw_zonelocation.SetColumn ( "location" )
dw_zonelocation.SetFocus ( )
	

end event

type cb_deletelocation from commandbutton within u_zone_maintenance
integer x = 2418
integer y = 464
integer width = 247
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Delete"
end type

event clicked;dw_zonelocation.Event pfc_DeleteRow ( )
end event

type dw_zonelocation from u_dw_zonelocation within u_zone_maintenance
event type integer ue_locationchanged ( long al_row )
event type integer ue_typechanged ( long al_row )
event ue_addblankrow ( )
event ue_clearlocation ( long al_row )
integer x = 50
integer y = 464
integer width = 2039
integer height = 1008
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event ue_addblankrow;string	ls_name

ls_name = this.object.location[this.rowcount()]
if len(trim(ls_name)) > 0 then
	this.Event PFC_AddRow()
	this.scrolltorow(this.rowcount())
	this.setfocus()
end if

end event

event ue_clearlocation;string	ls_null
setnull(ls_null)

THIS.setItem ( al_row , "location" , '' )

end event

event constructor;this.settransobject(SQLCA)

n_cst_Presentation_zonelocation	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )
	
/* take this out when we want to support multiple types*/
//THIS.Object.type.protect = 1
end event

event itemchanged;//override ancestor
String	lsa_Result[]
Long	ll_Start
Long	ll_End
Long	ll_NewRow
Long	i
long 	ll_found
Long		ll_Return

string	lsa_zones[], &
			ls_zone, &
			ls_Name, &
			ls_city, &
			ls_state, &
			ls_codename, &
			ls_display, &
			ls_id, &
			ls_null

n_cst_bso_zonemanager lnv_zonemanager
n_cst_string	lnv_String
n_cst_beo_company	lnv_company

SetNull ( ls_Null )

CHOOSE CASE dwo.Name 
		
	CASE "location"
		IF THIS.Object.type [ row ] = 2 THEN
			lnv_String.of_ParseToArray ( data, "-" , lsa_Result ) 
			IF UpperBound ( lsa_Result ) = 2 THEN
				IF Len (  lsa_Result[1] ) = 5 AND Len ( lsa_Result [2] ) = 5 THEN
				
					IF isNumber ( lsa_Result[1] ) AND isNumber ( lsa_Result [2] ) THEN
						
						CHOOSE CASE Long ( lsa_Result[1] )
								
							CASE IS < Long ( lsa_Result [2] )
								
								ll_Start = Long( lsa_Result[1] )
								ll_End = Long ( lsa_Result[2] ) 
		
							CASE IS > Long ( lsa_Result [2] )
								
								ll_Start = Long( lsa_Result[2] )
								ll_End = Long ( lsa_Result[1] ) 
								
								
							CASE Long ( lsa_Result [2] )
								
								ll_Start = Long( lsa_Result[1] )
								ll_End = Long ( lsa_Result[2] )
								
						END CHOOSE
						
						THIS.SetRedraw ( FALSE )
						FOR i = ll_Start To ll_End 
							THIS.RowsCopy ( Row, row, PRIMARY!, THIS,99999,PRIMARY! )
							ll_NewRow = THIS.RowCount ( )
							this.object.location[ ll_NewRow ] = String ( i , "00000" )									
						NEXT
						THIS.DeleteRow ( Row )
						THIS.SetRedraw ( TRUE )
					END IF
				END IF
			END IF
		END IF
		
		ll_found = THIS.FInd ( "location = '" + data + "'" , 1 , this.rowcount() )
		if ll_found > 0 then
			if ll_found = row then
				ll_found = THIS.FInd ( "location = '" + data + "'" , ll_found + 1 , this.rowcount() )
				if ll_found > 0 then
					ll_Return = 1
					MessageBox ( "Zone Location" , "The location entered already exists." )
					THIS.object.location[row] = ls_Null
				end if
			else
				ll_Return = 1
				MessageBox ( "Zone Location" , "The location entered already exists." )
				THIS.object.location[row] = ls_Null
			end if
		END IF
			
		IF ll_Return = 0 THEN
			lnv_zonemanager = inv_rating.of_getzonemanager()
			lnv_zonemanager.of_findzoneforlocation(data, THIS.Object.type [row], lsa_zones)
			
			if upperbound(lsa_zones) > 0 then
				lnv_string.of_arraytostring(lsa_zones, ',', ls_zone)
				messagebox( 'Zone Location', "The location entered already exists in zone(s) " + ls_zone + "." )
			end if
		END IF
			
	CASE "display"
		IF THIS.GetItemNumber ( row , "type" ) = appeon_constant.ci_locationtype_site THEN
			ls_Name = THIS.of_GetSiteName ( data  , lnv_company ) 
			if isvalid(lnv_company) then
				ls_city = lnv_company.of_getcity()
				ls_state = lnv_company.of_getstate()
				ls_codename = lnv_company.of_getcodename()
				ls_id = String ( lnv_company.of_getid() )
			end if		
		
			IF len ( ls_Name ) > 0 THEN
				ll_found = THIS.FInd ( "location = '" + ls_id + "'" , 1 , this.rowcount() )
				if ll_found > 0 then
					if ll_found = row then
						ll_found = THIS.FInd ( "location = '" + ls_id + "'" , ll_found + 1 , this.rowcount() )
						if ll_found > 0 then
							ll_Return = 1
							MessageBox ( "Zone Location" , "The location entered already exists." )
							THIS.object.display[row] = ls_Null
						end if
					else
						ll_Return = 1
						MessageBox ( "Zone Location" , "The location entered already exists." )
						THIS.object.display[row] = ls_Null
					end if
				END IF
			
				if ll_return = 1 then
					//skip
				else
					if len(trim(ls_codename)) > 0 then
						ls_display = ls_codename + " : " + ls_name
					else
						ls_display = ls_name
					end if					
					ls_display = ls_display + " ("
					if len(trim(ls_city)) > 0 then
						ls_display = ls_display + ls_city
					end if
					if len(trim(ls_state)) > 0 then
						ls_display = ls_display + ", " + ls_state
					end if
					ls_display = ls_display + ")"
					
					THIS.post SetItem ( row, "display" , ls_display )
					THIS.post setItem ( row , "location" , String ( lnv_company.of_getid() ) )
				end if
				
			ELSE
				THIS.post SetItem ( row, "display" , "" )
				THIS.post setItem ( row , "location" , "" )
			END IF
		END IF

		if ll_return = 0 then
			if len ( ls_id ) > 0 then
				lnv_zonemanager = inv_rating.of_getzonemanager()
				lnv_zonemanager.of_findzoneforlocation(ls_id, THIS.Object.type [row], lsa_zones)
				
				if upperbound(lsa_zones) > 0 then
					lnv_string.of_arraytostring(lsa_zones, ',', ls_zone)
					messagebox( 'Zone Location', "The location entered already exists in zone(s) " + ls_zone + "." )
				end if
			
			end if		
		end if
		
		if this.rowcount() = row then	
			this.event post ue_addblankrow()
		end if		


	CASE "type"
		THIS.post SetItem ( row, "display" , "" )
		THIS.post setItem ( row , "location" , "" )
		
END CHOOSE 

if isvalid(lnv_company) then
	destroy lnv_company
end if

Return ll_Return		

end event

event pfc_insertrow;////this needs to be changed for inserting in the beginning of the list
//String	ls_name
//Long		ll_Return
//
//ll_Return = AncestorReturnValue 
//
//IF ll_Return > 0 THEN
//	
//	if this.rowcount() > 1 then
//		ls_name = this.object.zonename[1]
//		this.object.zonename[ll_return] = ls_name
//	end if
//
//	this.ScrollToRow ( ll_Return ) 
//	
//END IF
//
//RETURN ll_Return


//
String	ls_name
Long		ll_Return
IF Len ( is_Zone ) > 0 THEN
	ll_Return = SUPER::Event pfc_InsertRow ( )
ELSE
	MessageBox ( "Zone Location"  , "Please select a Zone Name.")
END IF

//ll_Return = AncestorReturnValue 

IF ll_Return > 0 THEN
	
	if this.rowcount() > 1 then
		ls_name = this.object.zonename[1]
		this.object.zonename[ll_return] = ls_name		
	end if
	
	this.object.zonename[ll_return] = is_Zone
	
	IF ll_Return > 1 THEN
		THIS.SetItem ( ll_Return ,"type" , THIS.GetItemNumber ( ll_Return - 1  , "type" ) )
	ELSE
		THIS.SetItem ( ll_Return , "type" , appeon_constant.ci_locationtype_zip )	
	END IF
	
	
	/*Remove this when supporting multiple types*/
	THIS.SetItem ( ll_Return , "type" , appeon_constant.ci_locationtype_zip )
	
	this.ScrollToRow ( ll_Return ) 
	THIS.SetRow ( ll_Return )
	THIS.SetColumn ( "location" )
	THIS.SetFocus ( )
	
END IF

RETURN ll_Return

end event

event pfc_addrow;String	ls_name
Long		ll_Return

IF Len ( is_Zone ) > 0 THEN
	ll_Return = SUPER::Event pfc_AddRow ( )
ELSE
	MessageBox ( "Zone Location"  , "Please select a Zone Name.")
END IF

IF ll_Return > 0 THEN
	
	if ll_Return > 1 then
		ls_name = this.object.zonename[1]
		this.object.zonename[ll_return] = ls_name		
	end if
	
	this.object.zonename[ll_return] = is_Zone
	
	IF ll_Return > 1 THEN
		THIS.SetItem ( ll_Return ,"type" , THIS.GetItemNumber ( ll_Return - 1  , "type" ) )
	ELSE
		THIS.SetItem ( ll_Return , "type" , appeon_constant.ci_locationtype_zip )	
	END IF
	
END IF

RETURN ll_Return

end event

event editchanged;choose case dwo.name 
	case 'location'
		if this.rowcount() = row then
				this.Event PFC_AddRow()
		end if
end choose


end event

event itemerror;long ll_return

	choose case dwo.name
		case 'location', 'display'
			ll_return = 1
	end choose

return ll_return
end event

type dw_zone from u_dw_zone within u_zone_maintenance
integer x = 50
integer y = 188
integer width = 2610
integer height = 160
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_zone_grid"
boolean vscrollbar = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;IF currentrow > 0 THEN
	PARENT.of_filterlocations(currentrow)
	ids_locationcopy.reset()
	dw_zonelocation.rowscopy(1, dw_zonelocation.rowcount(), primary!, ids_locationcopy, 1, primary!)
	long	ll_count, ll_ndx
	for ll_ndx = 1 to ll_count
		ids_locationcopy.setitemstatus(ll_ndx, 0, primary!, datamodified!)
		ids_locationcopy.setitemstatus(ll_ndx, 0, primary!, notmodified!)
	next
	gb_Locations.Event ue_SetText ( ) 
	is_Zone = dw_zone.object.name[currentrow]
END IF
end event

event constructor;call super::constructor;this.settransobject(SQLCA)
ib_rmbmenu=false
//SetRowFocusIndicator ( HAND! )

end event

event itemchanged;call super::itemchanged;Long		ll_Return , &
			ll_row

ll_Return = AncestorReturnValue

choose case dwo.name
	case "name"
		choose case this.getitemstatus(row, 0, primary!)
			case new!, newmodified!
				//allow change
			case else
				choose case messagebox('Zone', 'Are you sure you want to change this zone name? ' + &
									'This will also change any references to this zone name.', Question!, yesno!, 1)
					case 1
						ll_return = 0
					case 2
						ll_return = 2
				end choose
			end choose
		
		IF ll_return = 2 then
			//don't change
		else
			parent.Post of_setlocationzone(data)
			gb_Locations.Post Event ue_SetText ( ) 
			is_Zone = data
			dw_1.object.zone[1] = data
		end if
end choose

return ll_return
end event

event pfc_addrow;call super::pfc_addrow;String	ls_name
Long		ll_Return

ll_Return = AncestorReturnValue 

IF ll_Return > 0 THEN

	this.ScrollToRow ( ll_Return ) 
	THIS.SetRow ( ll_Return )
	THIS.SetColumn ( "name" )
	THIS.SetFocus ( )
		
		
		
END IF

RETURN ll_Return

end event

event pfc_deleterow;parent.SetRedraw(false)

long 	ll_return = 1, &
		ll_ratecount
		
string	ls_name, &
			ls_whereclause, &
			ls_message

boolean	lb_deletedrates

//get rate ids
if not isvalid(ids_rate) then
	ids_rate = create n_ds
	ids_rate.dataobject = "d_rate"
	ids_rate.SetTransObject(SQLCA)
	is_originalselect = ids_rate.Describe("DataWindow.Table.Select")
end if

ls_name = this.object.name[this.getrow()]

ls_whereclause =  " WHERE ratelinkorigzone.zone = '" + ls_name + "' OR ratelinkdestzone.zone = '" + ls_name + "'"
						
ids_rate.object.datawindow.table.select = is_originalselect + ls_whereclause
ll_ratecount=ids_rate.Retrieve()
commit;
if ll_ratecount > 0 then
	ls_message = 'Are you sure you want to delete this zone? ' + &
						'This will also delete rates for this zone.'
else
	ls_message = "'Are you sure you want to delete this zone? "
end if

choose case messagebox('Zone', ls_message, Question!, yesno!, 1)
	case 1
		if ll_ratecount > 0 then
			//delete rates
			ids_rate.rowsmove(1, ids_rate.rowcount(), Primary!, ids_rate, 1, Delete!)
		end if
	case 2
		ll_return = -1
end choose

if ll_return = 1 then
	//discard rows from locations 
	dw_zonelocation.RowsDiscard(1, dw_zonelocation.rowcount(), primary!)
	ll_return = Super::Event pfc_deleterow()
	if ll_return = 1 then
		choose case parent.event ue_savechanges(ls_name, false)
			case 1	//success
				ls_name = this.object.name[this.getrow()]
				parent.Post of_setlocationzone(ls_name)
				gb_Locations.Post Event ue_SetText ( ) 
				is_Zone = ls_name
				dw_1.object.zone[1] = ls_name
				this.event rowfocuschanged(this.getrow())
	//			this.setrow(ll_row)
	//			this.scrolltorow(ll_row)
	
			case 0	//don't save
				
			case -1	//error saving
				
			case -2	//cancel save
				
		end choose
	end if
	
end if

parent.SetRedraw(TRUE)
return ll_return


end event

type dw_1 from u_dw_ratelinkzone within u_zone_maintenance
integer x = 50
integer y = 76
integer height = 96
integer taborder = 10
boolean bringtotop = true
end type

event itemchanged;call super::itemchanged;long	ll_return, &
		ll_row, &
		ll_ndx, &
		ll_rowcount
		
string	ls_return, &
			ls_message

ll_Return = AncestorReturnValue
if ll_return = 0 then
	CHOOSE CASE UPPER(dwo.name)
		CASE "ZONE"
			ll_row = dw_zone.find("name = '" + data + "'", 1, dw_zone.rowcount())
			if ll_row > 0 then	
				ls_return = this.object.zone.primary.current[row]
				choose case parent.event ue_savechanges(ls_return, true)
					
					case 1	//success
						dw_zone.scrolltorow(ll_row)
			
					case 0	//don't save
						dw_zonelocation.rowsdiscard(1, dw_zonelocation.rowcount(), primary!)
						dw_zonelocation.rowsdiscard(1, dw_zonelocation.deletedcount(), delete!)
						ll_rowcount = ids_locationcopy.rowcount()
						ids_locationcopy.rowscopy(1, ll_rowcount, primary!, dw_zonelocation, 1, primary!)
						for ll_ndx = 1 to ll_rowcount
							dw_zonelocation.setitemstatus(ll_ndx, 0, primary!, datamodified!)
							dw_zonelocation.setitemstatus(ll_ndx, 0, primary!, notmodified!)
						next
						dw_zone.scrolltorow(ll_row)
			
					case -1, -2	//error saving, cancel save
						this.settext(this.object.ZONE.primary.original[1])	
//						this.setitem(1, 'ZONE', this.object.ZONE.primary.original[1])
						ll_return = 1
				end choose
			end if
					
	END CHOOSE
end if

return ll_Return

end event

event constructor;call super::constructor;ib_rmbmenu=false
this.Object.zone.Accelerator='z'
this.Object.DataWindow.header.height=0
end event

event getfocus;call super::getfocus;long	ll_length, &
		ll_row

string	ls_zone

ll_row = this.getrow()

if ll_row > 0 then

	ls_zone = this.object.zone[ll_row]
	if isnull(ls_zone) then
		ll_length = 30
	else
		ll_length = len(ls_zone)
	end if
	
else
	ll_length = 30
end if

This.Post selecttext(1, ll_length)
end event

event itemerror;call super::itemerror;long	ll_return

CHOOSE CASE UPPER(dwo.name)
	CASE "ZONE"
		ll_return = 1
END CHOOSE

return ll_return
end event

type uo_1 from u_cst_zonelocation within u_zone_maintenance
integer x = 5
integer y = 1504
integer width = 2363
integer height = 412
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call u_cst_zonelocation::destroy
end on

event ue_findzone;string	lsa_zones[], &
			ls_zone
n_cst_bso_zonemanager lnv_zonemanager

lnv_zonemanager = inv_rating.of_getzonemanager()
lnv_zonemanager.of_findzoneforlocation(as_location, ai_type, lsa_zones)

dw_zones.event ue_filter(lsa_zones)
end event

event ue_selectzone;call super::ue_selectzone;dw_1.settext(as_zone)
dw_1.accepttext()

end event

