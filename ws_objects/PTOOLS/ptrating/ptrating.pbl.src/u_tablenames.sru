$PBExportHeader$u_tablenames.sru
forward
global type u_tablenames from u_base
end type
type dw_tablenames from u_dw_ratetablenames within u_tablenames
end type
type dw_1 from u_dw_newratetable within u_tablenames
end type
type cb_add from commandbutton within u_tablenames
end type
type cb_delete from commandbutton within u_tablenames
end type
end forward

global type u_tablenames from u_base
integer width = 3506
integer height = 328
long backcolor = 12632256
event ue_itemchanged ( string as_what )
event type string ue_getfilter ( )
event type string ue_getvalue ( )
event ue_retrieve ( )
event ue_gotfocus ( )
event ue_postconstructor ( )
event ue_codenamechanged ( string as_old,  string as_new )
event type integer ue_savechanges ( string as_table,  string as_message,  boolean ab_delete )
dw_tablenames dw_tablenames
dw_1 dw_1
cb_add cb_add
cb_delete cb_delete
end type
global u_tablenames u_tablenames

type variables
Private:
string		is_breakunit
Protected:
n_ds		ids_RateTableNames
datawindowchild	idwc_name, &
		idwc_codename
boolean		ib_codenamechanged
boolean		ib_addcode
string		is_originalcodename
end variables

forward prototypes
public function string of_getbreakunit ()
public function long of_setratetablenamecache ()
public function string of_gettypeindicator ()
public function string of_getcodename ()
public function long of_addrowtocache ()
public subroutine of_syncvalue (string as_column, string as_value)
public function n_ds of_getcache ()
public function string of_getoriginalcodename ()
public function long of_getcachemodifiedcount ()
public subroutine of_setcodename (string as_value)
public function string of_getitemtype ()
public function long of_rowsync (string as_column, string as_value)
public subroutine of_rowsync (long al_value)
end prototypes

event ue_getfilter;String	ls_Name
String	ls_Filter

ls_Name = THIS.Event ue_GetValue ( )

IF Len ( ls_name ) > 0 THEN
	ls_Filter = "ratetablename = '" + ls_Name + "'"
END IF

RETURN ls_Filter
end event

event ue_getvalue;IF dw_tablenames.RowCount ( ) > 0 THEN
	RETURN  dw_tablenames.GetItemString ( 1, "name" )
END IF
end event

event ue_postconstructor;//need to 
long	ll_count, &
		ll_index, &
		ll_return
		
datawindowchild	ldwca_names[]
n_cst_Presentation_RateTable	lnv_Pres
n_cst_Presentation_AmountType	lnv_amountpresentation

dw_tablenames.of_getchildddws(ldwca_names)
ll_count = upperbound(ldwca_names)
//for ll_index = 1 to ll_count
//	ll_return=ids_RateTableNames.sharedata(ldwca_names[ll_index])
//next

idwc_name = dw_tablenames.of_getnamechild()
idwc_codename = dw_tablenames.of_getcodenamechild()


this.of_syncvalue('', '')

lnv_Pres.of_SetPresentation ( ids_RateTableNames )
lnv_amountpresentation.of_SetPresentation ( ids_RateTableNames )
lnv_amountpresentation.of_SetPresentation ( dw_1 )

ids_RateTableNames.ShareData(dw_1)
dw_tablenames.SetFocus ( )
this.event ue_itemchanged('')

end event

public function string of_getbreakunit ();long	ll_row
		
string	ls_return		

ll_row = ids_RateTableNames.getrow()
if ll_row > 0 then
	ls_return = ids_RateTableNames.object.breakunit[ll_row]
end if

return ls_return 
end function

public function long of_setratetablenamecache ();SetPointer(HourGlass!)
long ll_row

if isvalid(ids_RateTableNames) then
	destroy ids_RateTableNames
else
	ids_RateTableNames = create n_ds
end if

ids_RateTableNames.dataobject='d_ratetablecodenames'
ids_RateTableNames.SetTransObject(SQLCA)
ll_row = ids_RateTableNames.retrieve()
commit;

return ll_row
end function

public function string of_gettypeindicator ();long	ll_row
string	ls_return

ll_row = ids_RateTableNames.getrow()
if ll_row > 0 then
	ls_return = ids_RateTableNames.object.amounttype_itemtype[ll_row]
	if isnull(ls_return) then
		ls_return = ''
	end if
end if

return ls_return
end function

public function string of_getcodename ();long	ll_row
string	ls_return
ll_row = ids_RateTableNames.getrow()
if ll_row > 0 then
	ls_return = ids_RateTableNames.object.codename.Primary.Current[ll_row]
end if

return ls_return
end function

public function long of_addrowtocache ();long		ll_nextid, &
			ll_row, &
			ll_currentrow
			
string	ls_codename

CONSTANT Boolean cb_Commit	= TRUE	

ll_currentrow = ids_RateTableNames.GetRow()
ll_row = ids_RateTableNames.InsertRow(1)

if ll_row > 0 then
	
	ids_RateTableNames.rowscopy(1, ids_RateTableNames.rowcount(), primary!, idwc_name, 1, primary!)
	ids_RateTableNames.rowscopy(1, ids_RateTableNames.rowcount(), primary!, idwc_codename, 1, primary!)

	
	if ll_currentrow > 0 then
		//set breakunits to same as previous
		ids_RateTableNames.object.breakunit[ll_row] = ids_RateTableNames.object.breakunit[ll_currentrow]
	end if

	IF gnv_App.of_GetNextId ( "ratecodename", ll_NextId, cb_Commit ) = 1 THEN
		ls_codename = string(ll_NextId)		
	END IF

	ids_RateTableNames.object.codename[ll_row] = ls_codename
	dw_tablenames.object.codename[1] = ids_RateTableNames.object.codename[ll_row]
	dw_tablenames.object.name[1] = ids_RateTableNames.object.name[ll_row]

end if
	
return ll_row
end function

public subroutine of_syncvalue (string as_column, string as_value);long	ll_row

ll_row = ids_RateTableNames.GetRow()

if ll_row > 0 then
	if len(trim(as_value)) > 0 then
		choose case upper(as_column)
			case 'CODENAME'
				ids_RateTableNames.object.codename[ll_row] = as_value
			case 'NAME'
				ids_RateTableNames.object.name[ll_row] = as_value
		end choose
	end if
	
	idwc_codename.reset()
	
	ids_RateTableNames.rowscopy(1, ids_RateTableNames.rowcount(), primary!, idwc_codename, 1, primary!)
	idwc_codename.sort()
	
	dw_tablenames.object.codename[1] = ids_RateTableNames.object.codename[ll_row]

	idwc_name.reset()
	
	ids_RateTableNames.rowscopy(1, ids_RateTableNames.rowcount(), primary!, idwc_name, 1, primary!)
	idwc_name.sort()
	dw_tablenames.object.name[1] = ids_RateTableNames.object.name[ll_row]

end if

end subroutine

public function n_ds of_getcache ();return ids_RateTableNames
end function

public function string of_getoriginalcodename ();long	ll_row
string	ls_return
ll_row = ids_RateTableNames.getrow()
if ll_row > 0 then
	ls_return = ids_RateTableNames.object.codename.Primary.Original[ll_row]
end if

return ls_return
end function

public function long of_getcachemodifiedcount ();long	ll_return

ll_return = ids_RateTableNames.ModifiedCount ( )
ll_return += ids_RateTableNames.DeletedCount ( )

return ll_return
end function

public subroutine of_setcodename (string as_value);dw_tablenames.object.codename[1] = as_value
end subroutine

public function string of_getitemtype ();long	ll_row
string	ls_return
ll_row = dw_1.getrow()
if ll_row > 0 then
	ls_return = dw_1.object.amounttype_itemtype.Primary.Current[ll_row]
end if

return ls_return
end function

public function long of_rowsync (string as_column, string as_value);long		ll_row 
string	ls_findstring

ls_findstring = as_column + " = '" + as_value + "'"
ll_row=ids_RateTableNames.find(ls_findstring,1,ids_RateTableNames.rowcount())
if ll_row > 0 then
	this.of_rowsync(ll_row)
end if

return ll_row
end function

public subroutine of_rowsync (long al_value);long	ll_row

if al_value = 0 then
	//adding new row
	al_value = this.of_AddRowToCache()
	if al_value > 0 then
	end if
	// what if not successful ??
	
end if

if al_value > 0 then
	ids_RateTableNames.SetRow(al_value)
	dw_1.ShareDataoff()
	dw_1.ScrollToRow(al_value)
	ids_RateTableNames.ShareData(dw_1)
	
end if

end subroutine

on u_tablenames.create
int iCurrent
call super::create
this.dw_tablenames=create dw_tablenames
this.dw_1=create dw_1
this.cb_add=create cb_add
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tablenames
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.cb_delete
end on

on u_tablenames.destroy
call super::destroy
destroy(this.dw_tablenames)
destroy(this.dw_1)
destroy(this.cb_add)
destroy(this.cb_delete)
end on

event constructor;call super::constructor;this.of_setratetablenamecache()

This.of_SetResize ( TRUE )

inv_Resize.of_SetMinSize ( 3506, 328 )

//Register Resizable controls
inv_Resize.of_Register ( dw_1, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( cb_add, 'FixedToRight' )
inv_Resize.of_Register ( cb_delete, 'FixedToRight' )
this.event post ue_postconstructor()

end event

event destructor;call super::destructor;if isvalid(ids_RateTableNames) then
	ids_RateTableNames.ShareData(dw_1)
	ids_RateTableNames.sharedataoff()
	destroy ids_RateTableNames
end if
end event

type dw_tablenames from u_dw_ratetablenames within u_tablenames
event editchanging pbm_dwnchanging
integer x = 14
integer y = 12
integer width = 2286
integer height = 108
integer taborder = 10
boolean bringtotop = true
end type

event editchanging;If IsValid(inv_dropdownsearch) Then
	//essageBox("changing", "changing")
	inv_dropdownsearch.event pfc_editchanged(row, dwo, data)
End If	
end event

event itemchanged;call super::itemchanged;long	ll_return, &
		ll_retrow
string	ls_table

ll_Return = AncestorReturnValue
if ll_return = 0 then
	
	CHOOSE CASE UPPER(dwo.name)
		CASE "NAME", "CODENAME"
			
			long		ll_row, &
						ll_retval = 1
						
			string	ls_return
			
			ll_row = ids_RateTableNames.getrow()
			ls_table = data
			
			if ll_row > 0 then
				ls_return = ids_RateTableNames.object.codename.Primary.current[ll_row]
				if len(trim(ls_return)) > 0 then
					choose case parent.event ue_savechanges(ls_return, '', false /*not deleting*/)
						
						case 1	//success
							ll_retval = 0
							
						case 0	//don't save
							ll_retval = 0
							
						case -1, -2	//error saving, cancel save
							this.settext(this.object.CODENAME.primary.original[1])	
							ls_table = this.object.CODENAME.primary.original[1]
							ll_return = 1
							ll_retval = 0
			
					end choose

				end if
			end if
	
			if ll_retval = 0 then
				ll_retrow = parent.of_rowsync(dwo.name,ls_table)
				if ll_retrow > 0 then
					dw_1.ScrollToRow(ll_retrow)
				end if
		
				parent.Event post ue_ItemChanged ('TABLENAME')
			
			end if
	END CHOOSE
end if

return ll_Return


end event

event constructor;call super::constructor;long	ll_row = 1

THIS.SetTransObject ( SQLCA )
ib_rmbmenu=false
of_SetDropDownSearch(true)
inv_dropdownsearch.of_Register()

THIS.InsertRow ( 0 )
IF ids_RateTableNames.GetRow () > 0 THEN
	this.object.name[ll_row] = ids_RateTableNames.object.name[ll_row]
	this.object.codename[ll_row] = ids_RateTableNames.object.codename[ll_row]
	parent.of_rowsync(ll_row)
END IF


end event

event getfocus;call super::getfocus;PARENT.Event ue_GotFocus ( ) 
end event

event editchanged;If IsValid(inv_dropdownsearch) Then
	inv_dropdownsearch.event pfc_editchanged(row, dwo, data)
End If	
end event

event itemfocuschanged;call super::itemfocuschanged;if IsValid(inv_dropdownsearch) then
	inv_dropdownsearch.event pfc_itemfocuschanged(row, dwo)
end if

long		ll_length
string	ls_value

choose case dwo.name
	case "codename"
		ls_value = this.object.codename[row]
	case "name"
		ls_value = this.object.name[row]
end choose

if isnull(ls_value) then
	ll_length = 30
else
	ll_length = len ( ls_value)
end if

post SelectText ( 1, ll_length )

end event

type dw_1 from u_dw_newratetable within u_tablenames
event ue_keydown pbm_dwnkey
integer x = 9
integer y = 148
integer width = 3479
integer height = 160
integer taborder = 20
boolean bringtotop = true
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_keydown;IF key = KeyDownArrow! or key = KeyUpArrow! or key = keyPageDown! or key = KeyPageUp! THEN
	this.setredraw(false)
	this.post scrolltorow(this.getrow())
	this.post setredraw(true)
END IF

RETURN 0
end event

event constructor;call super::constructor;this.SetTransObject(SQLCA)
ib_rmbmenu=false




end event

event itemchanged;call super::itemchanged;Long	ll_Return, &
		ll_findrow, &
		ll_rowcount
string	ls_find, &
			ls_column, &
			ls_original	

ll_Return = AncestorReturnValue

ls_column = dwo.name
choose case upper(ls_column)
	case 'CODENAME'
		choose case this.getitemstatus(row, 0, primary!)
			case new!, newmodified!
				ls_Find = "codename = '" + data + "'"
				ll_rowcount = this.rowcount()
				ll_FindRow = THIS.Find ( ls_Find , 1 , ll_rowcount ) 
				
				IF ll_FindRow > 0 THEN
					if ll_findrow <> row then
					//allow change
					MessageBox ( "Rate Table" , "The codename entered already exists. Please change your entry." )
					ls_original = this.object.codename.primary.original[row]
					this.setitem(row, ls_column, ls_original)
					this.selecttext(1,len(ls_original))
					ll_Return = 1
					end if
				END IF
		
			case else
				choose case messagebox('Rate Table', 'Are you sure you want to change this code name? ' + &
												'This will also change any references to this code name.', Question!, yesno!, 1)
					case 1
						ll_return = 0
						if ib_codenamechanged = false then
							ib_codenamechanged=true
							is_originalcodename = this.object.codename.primary.original[row]
						end if
					case 2
						ll_return = 2
				end choose
		end choose
		
		IF ll_return > 0 then
			//don't change
		else
			//let parent know so related rates will be changed
			if len(trim(data)) > 0 then
				parent.event ue_codenamechanged(this.object.codename.primary.original[row],data)
			else
				messagebox('Codename', 'Codename is required.')
				ll_return = 1
			end if
			parent.of_syncvalue(dwo.name, data)
		end if
		
	CASE 'NAME'
		parent.of_syncvalue(dwo.name, data)
	case 'BREAKUNIT'
		parent.event ue_itemchanged('BREAKUNIT')
	case 'AMOUNTTYPE'
		parent.event ue_itemchanged('AMOUNTTYPE')
end choose

Return ll_Return

end event

event itemerror;call super::itemerror;Long	ll_Return

ll_Return = AncestorReturnValue

CHOOSE CASE dwo.name
		
	CASE "codename" 
		
			ll_Return = 1
		

END CHOOSE

RETURN ll_Return
end event

type cb_add from commandbutton within u_tablenames
integer x = 2693
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Add"
end type

event clicked;long		ll_row, &
			ll_sync, &
			ll_return = 1
			
string	ls_return

ll_row = ids_RateTableNames.getrow()
if ll_row > 0 then
	ls_return = ids_RateTableNames.object.codename.Primary.current[ll_row]
	if len(trim(ls_return)) > 0 then
		choose case parent.event ue_savechanges(ls_return, '', false /* not deleting*/)
			
			case 1	//success
				ll_return = 1
				
			case 0	//don't save
				ll_return = 0
				
			case -1, -2	//error saving, cancel save
				ll_return = -1

		end choose

		
	end if
end if


choose case ll_return
	case 1, 0 //1=saved, 0=flushed
		ll_sync = 0
		parent.of_rowsync(ll_sync)
		parent.Event ue_ItemChanged ('TABLENAME')
end choose

dw_1.SetFocus()


end event

type cb_delete from commandbutton within u_tablenames
integer x = 2953
integer y = 36
integer width = 247
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "D&elete"
end type

event clicked;//when a table is deleted we want to scroll to the next table in the list
long	ll_row, &
		ll_rowcount, &
		ll_foundrow
		
string	ls_string, &
			ls_return, &
			ls_message

ll_row = ids_RateTableNames.GetRow()
parent.SetRedraw(false)
if ll_row > 0 then
	ls_message = 'Are you sure you want to delete this table?' + &
									' All rates for this table will also be deleted.'
								
		ls_return = ids_RateTableNames.object.codename.Primary.current[ll_row]
		ids_RateTableNames.deleteRow(ll_Row)
		choose case parent.event ue_savechanges(ls_return, ls_message, true /*delete*/)
			
			case 1	//success
				parent.Event post ue_ItemChanged ('TABLENAME')
				ll_rowcount = ids_RateTableNames.rowcount()
				
				if ll_rowcount > 0 then
					
					if ll_row > ll_rowcount then
						ll_row = ll_rowcount
					end if
						
					ids_RateTableNames.SetRow(ll_row)

					of_syncvalue('','')
					of_rowsync(ll_row)
					if ll_row > 0 then
						dw_1.ScrollToRow(ll_row)
					end if

					
				else
					dw_tablenames.object.codename[1] = ''
					dw_tablenames.object.name[1] = ''
				
				end if
	
			case else	//don't save
				//cache flushed in the ue_savechanges script
				ids_RateTableNames.rowsmove(1, 1, delete!, ids_RateTableNames, ll_row, primary!)
				ids_RateTableNames.SetRow(ll_row)

		end choose

end if
parent.SetRedraw(true)
dw_tablenames.setcolumn('codename')
dw_tablenames.setfocus()



end event

