$PBExportHeader$u_tabpg_edi_214.sru
forward
global type u_tabpg_edi_214 from u_tabpg_edi
end type
type dw_profilestatus from u_dw_ediprofile_214 within u_tabpg_edi_214
end type
type cb_import from commandbutton within u_tabpg_edi_214
end type
type cb_export from commandbutton within u_tabpg_edi_214
end type
type dw_mappings from u_dw_mappingfiles within u_tabpg_edi_214
end type
end forward

global type u_tabpg_edi_214 from u_tabpg_edi
integer width = 3502
integer height = 1456
string text = "Outbound"
long il_coid = 37400160
event ue_clearblankrows ( )
dw_profilestatus dw_profilestatus
cb_import cb_import
cb_export cb_export
dw_mappings dw_mappings
end type
global u_tabpg_edi_214 u_tabpg_edi_214

event ue_clearblankrows();dw_profilestatus.event ue_ClearBlankRows()
end event

on u_tabpg_edi_214.create
int iCurrent
call super::create
this.dw_profilestatus=create dw_profilestatus
this.cb_import=create cb_import
this.cb_export=create cb_export
this.dw_mappings=create dw_mappings
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_profilestatus
this.Control[iCurrent+2]=this.cb_import
this.Control[iCurrent+3]=this.cb_export
this.Control[iCurrent+4]=this.dw_mappings
end on

on u_tabpg_edi_214.destroy
call super::destroy
destroy(this.dw_profilestatus)
destroy(this.cb_import)
destroy(this.cb_export)
destroy(this.dw_mappings)
end on

event constructor;call super::constructor;long	ll_coid, &
		ll_row

ll_coid = this.of_GetCompany()


if ll_coid > 0 then
	dw_profile.settransobject(sqlca)  
	dw_mappings.settransobject(sqlca)
	if dw_profile.retrieve(ll_coid, appeon_constant.cl_transaction_set_214, appeon_constant.cs_transaction_OUTBOUND) < 1 then
		ll_row = dw_profile.insertrow(0)
		if ll_row > 0 then
			dw_profile.object.companyid[ll_row] = ll_coid
			dw_profile.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_214
			dw_profile.object.in_out[ll_row] = "OUTBOUND"
		end if
	end if
	
	if dw_mappings.retrieve(ll_coid, appeon_constant.cl_transaction_set_214, appeon_constant.cs_transaction_OUTBOUND) < 1 then
		ll_row = dw_mappings.insertrow(0)
		if ll_row > 0 then
			dw_mappings.object.company[ll_row] = ll_coid
			dw_mappings.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_214
		end if
	end if
	
end if


this.of_setupdateobjects( {dw_Profile, dw_Mappings , dw_profilestatus  } )
	


if gnv_App.of_GetrestrictedView ( ) then
	//size ok
else
	this.width = this.width + 700
	cb_export.x = cb_export.x + 700
	cb_import.x = cb_import.x + 700
	dw_profilestatus.width = dw_profilestatus.width + 700
	//cbx_assignednumbers.x += 700
end if


end event

type dw_profile from u_tabpg_edi`dw_profile within u_tabpg_edi_214
end type

type st_title from u_tabpg_edi`st_title within u_tabpg_edi_214
string text = "Shipment Status Message"
end type

type dw_profilestatus from u_dw_ediprofile_214 within u_tabpg_edi_214
event type boolean ue_duplicaterow ( long al_coid,  string as_eventtype,  string as_sitetype,  string as_action,  long al_row )
integer x = 41
integer y = 672
integer width = 3355
integer height = 752
integer taborder = 60
string dataobject = "d_ediprofile_214_grid"
boolean hscrollbar = true
boolean border = true
end type

event type boolean ue_duplicaterow(long al_coid, string as_eventtype, string as_sitetype, string as_action, long al_row);string	ls_eventtype, &
			ls_action, &
			ls_sitetype, &
			ls_findstring
			
long		ll_found, &
			ll_coid, &
			ll_rowcount


boolean	lb_exists

		
ls_findstring = "companyid = " + string(al_coid) +& 
					 " and transactionset = 214" +&
					 " and eventtype = '" + as_eventtype + "'"+&
					 " and sitetype = '" + as_sitetype + "'" +&
					 " and action = '" + as_action + "'"

ll_rowcount = this.rowcount()
					 
ll_found = THIS.FInd ( ls_findstring , 1 , ll_rowcount )

if ll_found > 0 then
	if ll_found = al_row then
		ll_found = THIS.FInd ( ls_findstring , ll_found + 1 , ll_rowcount )
		if ll_found > 0 then
			lb_exists =  true
		end if
	else
		lb_exists =  true
	end if
END IF							 

return lb_exists
end event

event constructor;call super::constructor;long	ll_row
datawindowchild	ldwc_status, &
						ldwc_AdditionalStatus
n_cst_Events	lnv_Events

//THIS.of_SetRowSelect ( TRUE ) 
//inv_RowSelect.of_SetStyle ( 2 )

This.Modify ( "eventtype.Edit.CodeTable = Yes eventtype.Values = '" +  lnv_Events.of_GetTypeCodeTableForShipment ( ) + "' eventtype.ddlb.allowedit=no eventtype.ddlb.UseAsBorder=no eventtype.ddlb.case=upper eventtype.ddlb.required=yes eventtype.ddlb.autohscroll=yes eventtype.ddlb.vscrollbar=yes " )  

this.SetTransObject(SQLCA)

THIS.GetChild ( "status" , ldwc_status )
ldwc_status.SetTransObject ( SQLCA )
ldwc_status.Retrieve ( )
ldwc_status.SetFilter ( "segmentid = 'AT7' AND referenceid = '01'" )
ldwc_status.Filter ( ) 
ldwc_status.insertrow(1)

THIS.GetChild ( "additionalstatus" , ldwc_AdditionalStatus )
ldwc_AdditionalStatus.SetTransObject ( SQLCA )
ldwc_AdditionalStatus.Retrieve ( )
ldwc_AdditionalStatus.SetFilter ( "segmentid = 'AT7' AND referenceid = '01'" )
ldwc_AdditionalStatus.Filter ( ) 
ldwc_AdditionalStatus.Insertrow(1)

if This.Retrieve(parent.of_GetCompany(), appeon_constant.cl_transaction_set_214, "OUTBOUND") < 1 then
//	ll_row = this.insertrow(0)	
//	if ll_row > 0 then
//		this.object.companyid[ll_row] = parent.of_GetCompany()
//		this.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_214
//	end if
end if

//DEK 5-3-07 removed the button and moved the ability to check the requirement row by row
//////////Added by Dan on 2-27-07
//Sam requested that if the data is inconsistant( there are 1's and 0's ) Then if there
//is at least one 0 then leave it unchecked.
//Long	ll_needStopNum
//Long	ll_index
//FOR ll_index = 1 TO  this.rowcount( )
//	ll_needStopNum = this.getItemNumber( 1, "needsstopindicator")
//	IF isNull(ll_needStopNum) OR  ll_needStopNum = 0 THEN
//	//	cbx_assignednumbers.checked = false
//		EXIT
//	END IF
//NEXT
//cbx_assignednumbers.checked = (ll_needStopNum = 1)
/////////////

THIS.of_SetAutoSort(TRUE)
end event

event pfc_addrow;call super::pfc_addrow;long	ll_row

ll_row = AncestorReturnValue

if ll_row > 0 then
	this.object.companyid[ll_row] = parent.of_GetCompany()
	this.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_214
//DEK 5-3-07 removed the button from the tab and moved the checkbox into the datawindow.	
//	IF cbx_assignednumbers.Checked  THEN
//		THIS.SetItem ( ll_row , "needsstopindicator" , 1  )
//	ELSE
//		THIS.SetItem ( ll_row , "needsstopindicator" , 0  )
//	END IF

end if

return ll_row
end event

event itemchanged;call super::itemchanged;string	ls_eventtype, &
			ls_action, &
			ls_sitetype, &
			ls_move, &
			ls_role, &
			ls_FindString
			
long		ll_return, &
			ll_coid, &
			ll_found, &
			ll_rowcount

ll_return = ancestorreturnvalue

if ll_return = 0 then
	
	choose case upper(dwo.name)
		case 'EVENTTYPE'
			if len(trim(data)) = 0 then
				ll_return = 1
			end if

			ll_coid = this.object.companyid[row]
			ls_eventtype = data
			ls_sitetype = this.object.sitetype[row]
			ls_action = this.object.action[row]
			ls_move = this.object.movecode[row]
			ls_role = this.object.statusrole[row]
	
		case 'SITETYPE'
			ll_coid = this.object.companyid[row]
			ls_eventtype = this.object.eventtype[row]
			ls_sitetype = data
			ls_action = this.object.action[row]
			ls_move = this.object.movecode[row]
			ls_role = this.object.statusrole[row]
			
		case 'ACTION'
			
			ll_coid = this.object.companyid[row]
			ls_eventtype = this.object.eventtype[row]
			ls_sitetype = this.object.sitetype[row]
			ls_action = data
			ls_move = this.object.movecode[row]
			ls_role = this.object.statusrole[row]
					
		case 'MOVECODE'
			ll_coid = this.object.companyid[row]
			ls_eventtype = this.object.eventtype[row]
			ls_sitetype = this.object.sitetype[row]
			ls_action = this.object.action[row]
			ls_move = data
			ls_role = this.object.statusrole[row]
			
		case 'STATUSROLE'
			ll_coid = this.object.companyid[row]
			ls_eventtype = this.object.eventtype[row]
			ls_sitetype = this.object.sitetype[row]
			ls_action = this.object.action[row]
			ls_move = this.object.movecode[row]
			ls_role = data
			
			
	end choose
	
	choose case upper(dwo.name)
		case 'EVENTTYPE', 'SITETYPE', 'ACTION', 'MOVECODE', 'STATUSROLE'
			//check duplicate row		
			ls_findstring = "companyid = " + string(ll_coid) +& 
								 " and transactionset = 214" +&
								 " and eventtype = '" + ls_eventtype + "'"+&
								 " and sitetype = '" + ls_sitetype + "'" +&
								 " and action = '" + ls_action + "'" +&
								 " and movecode = '" + ls_move + "'" +&
								 " and statusrole = '" + ls_role + "'" 
			
			ll_rowcount = this.rowcount()
								 
			ll_found = THIS.FInd ( ls_findstring , 1 , ll_rowcount )
			
			if ll_found > 0 then
				if ll_found = row then
					ll_found = THIS.FInd ( ls_findstring , ll_found + 1 , ll_rowcount )
					if ll_found > 0 then
						ll_return = 1
					end if
				else
					ll_return = 1
				end if
			END IF				
	end choose
	
	
end if

return ll_return

end event

event pfc_insertrow;call super::pfc_insertrow;long	ll_row

ll_row = AncestorReturnValue

if ll_row > 0 then
	this.object.companyid[ll_row] = parent.of_GetCompany()
	this.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_214
end if

return ll_row
end event

event itemerror;call super::itemerror;long		ll_return

string	ls_null, &
			ls_column, &
			ls_original
			
setnull(ls_null)

if ll_return = 0 then
	choose case upper(dwo.name)
		case 'EVENTTYPE', 'SITETYPE', 'ACTION', 'MOVECODE', 'STATUSROLE'
			
			MessageBox ( "214 Profile" , "This already exists." )
			ls_column = dwo.name
			ls_original = this.GetItemString(row, ls_column, Primary!, TRUE)
			this.SetItem(row, dwo.name, ls_original)
//			this.SetItem(row, dwo.name, ls_Null)
			ll_return = 1
			
	end choose
end if

return ll_return
end event

event pfc_updatespending;long	ll_return

this.event ue_clearblankrows( )

	ll_return = super::event pfc_updatespending( )

return ll_return

end event

type cb_import from commandbutton within u_tabpg_edi_214
integer x = 3049
integer y = 268
integer width = 343
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Import"
end type

event clicked;long		ll_row, &
			ll_rowcount
			
string	ls_PathName, &
			ls_FileName

if GetFileOpenName ( "Open Profile" , ls_PathName, ls_FileName, "txt", "Text Files (*.txt),*.txt", dw_profile.object.folder[1] ) = 1 then
	dw_profilestatus.ImportFile(ls_FileName)
	ll_rowcount = dw_profilestatus.rowcount()
	for ll_row = 1 to ll_rowcount
		dw_profilestatus.object.companyid[ll_row] = parent.of_getcompany()
	next
end if

end event

type cb_export from commandbutton within u_tabpg_edi_214
integer x = 3049
integer y = 152
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Export"
end type

event clicked;string	ls_path, &
			ls_file

if GetFileSaveName ( "Save Profile" , ls_Path, ls_File, "txt", "Text Files (*.txt),*.txt", dw_profile.object.folder[1] ) = 1 then
	dw_profilestatus.saveas(ls_Path, TEXT!, FALSE)
end if


end event

type dw_mappings from u_dw_mappingfiles within u_tabpg_edi_214
integer x = 46
integer y = 544
integer width = 1723
integer height = 104
integer taborder = 20
boolean bringtotop = true
boolean vscrollbar = false
end type

