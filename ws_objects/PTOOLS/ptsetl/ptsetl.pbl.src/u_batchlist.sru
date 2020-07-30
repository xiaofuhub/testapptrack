$PBExportHeader$u_batchlist.sru
forward
global type u_batchlist from u_base
end type
type dw_1 from u_dw_batchselection within u_batchlist
end type
type sle_date from singlelineedit within u_batchlist
end type
type st_1 from statictext within u_batchlist
end type
type vsb_1 from vscrollbar within u_batchlist
end type
end forward

global type u_batchlist from u_base
integer width = 1001
integer height = 212
long backcolor = 12632256
event ue_postconstructor ( )
event ue_itemchanged ( string as_what )
event ue_setfocus ( string as_what )
event ue_gotfocus ( )
event ue_losefocus ( )
dw_1 dw_1
sle_date sle_date
st_1 st_1
vsb_1 vsb_1
end type
global u_batchlist u_batchlist

type variables
datawindowchild	idwca_batch
date		id_batch
boolean	ib_error
end variables

forward prototypes
public function string of_getbatchnumber ()
public function date of_getbatchdate ()
public function date of_getstartdate ()
public function date of_getenddate ()
public function datawindowchild of_getbatchlist ()
public subroutine of_refresh ()
public function long of_getentityid ()
public function integer of_setbatchnumber (readonly string as_batchnumber)
public function boolean of_anyspecialcharacters (string as_value)
end prototypes

event ue_postconstructor;long	ll_count, &
		ll_index, &
		ll_return
		
string	ls_batchnumber

dw_1.of_getchilddw(idwca_batch)
idwca_batch.settransobject(sqlca)
idwca_batch.retrieve()
idwca_batch.setfilter("enddate < " + string(id_batch) + " or isnull(enddate)")
idwca_batch.Filter()
dw_1.SetFocus ( )
this.event ue_itemchanged('')

end event

event ue_setfocus;choose case upper(as_what)
	case "BATCHNUMBER"
		dw_1.SetColumn("batchnumber")
		dw_1.Setfocus()
		
end choose

	
end event

public function string of_getbatchnumber ();string	ls_return

IF dw_1.RowCount ( ) > 0 THEN
	if dw_1.accepttext() = 1 then
		ls_return = dw_1.object.batchnumber[1]
	end if
END IF

return ls_return
end function

public function date of_getbatchdate ();date	ld_return

setnull(ld_return)

IF dw_1.RowCount ( ) > 0 THEN
	ld_return = dw_1.object.batchdate[1]
END IF

return ld_return
end function

public function date of_getstartdate ();date	ld_return

setnull(ld_return)

IF dw_1.RowCount ( ) > 0 THEN
	ld_return = dw_1.object.startdate[1]
END IF

return ld_return
end function

public function date of_getenddate ();date	ld_return

setnull(ld_return)

IF dw_1.RowCount ( ) > 0 THEN
	ld_return = dw_1.object.enddate[1]
END IF

return ld_return
end function

public function datawindowchild of_getbatchlist ();return idwca_batch
end function

public subroutine of_refresh ();dw_1.reset()
dw_1.insertrow(0)
dw_1.of_getchilddw(idwca_batch)
idwca_batch.settransobject(sqlca)
idwca_batch.retrieve()
dw_1.SetFocus ( )
this.event ue_itemchanged('')


end subroutine

public function long of_getentityid ();

Long		ll_Return = -1
String	ls_Batch


IF dw_1.RowCount ( ) > 0 THEN
	ls_Batch = this.of_GetBatchNumber()

  SELECT "transaction"."fkentity"  
    INTO :ll_Return 
    FROM "transaction"  
   WHERE "transaction"."batchnumber" = :ls_Batch   ;

// sqlca.sqlcode may be -1 if more than one row is returned. That's expected.

		if SQLCA.SqlCode = 100 Then 		// not found. 										
			SetNull ( ll_Return )
			ROLLBACK;
		else 
			COMMIT;
		end if
		

END IF
	

Return ll_Return

end function

public function integer of_setbatchnumber (readonly string as_batchnumber);
dw_1.object.batchnumber[1] = as_batchnumber

Return 1
end function

public function boolean of_anyspecialcharacters (string as_value);long	ll_ndx, &
		ll_length
		
string	ls_char

boolean	lb_specialcharacter

ll_length = len(as_value)

for ll_ndx = 1 to ll_length
	
	ls_char = mid(as_value, ll_ndx, 1)
	if match(ls_char, "[A-Za-z0-9]") then
		continue
	else
		lb_specialcharacter = true
		exit
	end if
next

return lb_specialcharacter
end function

on u_batchlist.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.sle_date=create sle_date
this.st_1=create st_1
this.vsb_1=create vsb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.sle_date
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.vsb_1
end on

on u_batchlist.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.sle_date)
destroy(this.st_1)
destroy(this.vsb_1)
end on

event constructor;call super::constructor;This.of_SetResize ( TRUE )

inv_Resize.of_SetMinSize ( 1125, 328 )

//Register Resizable controls
//inv_Resize.of_Register ( dw_2, 'FixedToRight' )
this.event post ue_postconstructor()

end event

type dw_1 from u_dw_batchselection within u_batchlist
integer x = 18
integer y = 12
integer width = 946
integer height = 104
integer taborder = 10
boolean bringtotop = true
end type

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA )

of_SetDropDownSearch(true)
inv_dropdownsearch.of_Register()

THIS.InsertRow ( 0 )

end event

event editchanged;If IsValid(inv_dropdownsearch) Then
	inv_dropdownsearch.event pfc_editchanged(row, dwo, data)
End If	
end event

event itemchanged;call super::itemchanged;integer	li_return
date		ld_null
setnull(ld_null)

li_return = AncestorReturnValue

ib_error = false

if li_Return = 0 then

	CHOOSE CASE UPPER(dwo.name)
		CASE "BATCHNUMBER"
			if idwca_batch.getrow() > 0 then
				if idwca_batch.getitemstring(idwca_batch.getrow(),'batchnumber') = data then
					this.setitem(row, 'batchdate',idwca_batch.getitemdate(idwca_batch.getrow(),'batchdate'))
				else
					this.setitem(row, 'batchdate',ld_null)
					if parent.of_Anyspecialcharacters(data) then
						messagebox('Batch Number', 'Only letters and numbers are allowed in the name')
						ib_error = true
						li_return = 1
					end if
				end if
			else
				if parent.of_Anyspecialcharacters(data) then
					messagebox('Batch Number', 'Only letters and numbers are allowed in the name')
					ib_error = true
					li_return = 1
				else
					this.setitem(row, 'batchdate',ld_null)			
				end if

			end if
			
			if li_return = 0 then
				parent.Event post ue_ItemChanged ('BATCHNUMBER')
			end if

		CASE "BATCHDATE"
			parent.Event post ue_ItemChanged ('BATCHDATE')
	END CHOOSE
end if


return li_return
end event

event itemfocuschanged;call super::itemfocuschanged;if IsValid(inv_dropdownsearch) then
	inv_dropdownsearch.event pfc_itemfocuschanged(row, dwo)
end if

long		ll_length
string	ls_value

choose case upper(dwo.name)
	case "BATCHNUMBER"
		ls_value = this.object.batchnumber[row]
	case "BATCHDATE"
		ls_value = string(this.object.batchdate[row])
	case "STARTDATE"
		ls_value = string(this.object.startdate[row])
	case "ENDDATE"
		ls_value = string(this.object.enddate[row])
end choose

if isnull(ls_value) then
	ll_length = 30
else
	ll_length = len ( ls_value)
end if

post SelectText ( 1, ll_length )
end event

event getfocus;call super::getfocus;PARENT.Event ue_GotFocus ( ) 
end event

event itemerror;call super::itemerror;integer	li_return

li_return = AncestorReturnValue

if li_Return = 0 then
	choose case upper(dwo.name)
		CASE "BATCHNUMBER"
//			This.post Setcolumn('batchnumber')
			li_return = 1
			
		case "BATCHDATE"
			date	ld_batch, &
					ld_new	
			setnull(ld_batch)
			n_cst_string	lnv_string
			
			if len(trim(data)) = 0 then
				this.setitem(row, 'batchdate', null_date)
				li_return = 3
			else
				ld_new = lnv_string.of_SpecialDate(data)
				if isnull(ld_new) then 
					messagebox("Batch Date", "The value you have entered is invalid.  It will be "+&
					"replaced by the previous value.")
					li_return = 3
				else
					this.setitem(row, 'batchdate', ld_new)
					li_return = 3
				end if
			end if
	end choose
end if

return li_return
end event

event rowfocuschanged;call super::rowfocuschanged;//if currentrow > 0 then
//	messagebox('row',string(currentrow))
//	messagebox('idw',string(idwca_batch.getrow()))
//	this.setitem(currentrow, 'batchdate',idwca_batch.getitemdate(idwca_batch.getrow(),'batchdate'))
//end if
end event

event losefocus;if ib_error then
	//skip
else
	Parent.post TriggerEvent ("ue_losefocus")
end if
end event

type sle_date from singlelineedit within u_batchlist
integer x = 439
integer y = 112
integer width = 375
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;string	ls_filter
date 		ld_new
n_cst_string lnv_string
ld_new = lnv_string.of_SpecialDate(this.text)

if isnull(ld_new) then
	beep(1)
	this.text = upper(string(today(), "MM/DD/YYYY"))
	this.setfocus()
else
	id_batch = ld_new
	this.text = upper(string(id_batch, "MM/DD/YYYY"))
end if

ls_filter = "enddate > date('" + string(id_batch) + "') or isnull(enddate)"
idwca_batch.setfilter(ls_filter)
idwca_batch.Filter()

end event

event constructor;this.text = string(RelativeDate ( today(), -90 ),'MM/DD/YYYY')
end event

type st_1 from statictext within u_batchlist
integer x = 64
integer y = 120
integer width = 370
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Batches since"
boolean focusrectangle = false
end type

type vsb_1 from vscrollbar within u_batchlist
integer x = 846
integer y = 112
integer width = 73
integer height = 84
boolean bringtotop = true
boolean stdwidth = false
end type

event linedown;date new_date
n_cst_string lnv_string
new_date = lnv_string.of_SpecialDate(sle_date.text)

if isnull(new_date) then
	if isdate(left(sle_date.text, 8)) then
		new_date = date(left(sle_date.text, 8))
	elseif isdate(left(sle_date.text, 7)) then
		new_date = date(left(sle_date.text, 7))
	elseif isdate(left(sle_date.text, 6)) then
		new_date = date(left(sle_date.text, 6))
	else
		beep(1)
		return
	end if
end if

new_date = relativedate(new_date, -30)
id_batch = new_date
sle_date.text = upper(string(id_batch, "mm/dd/yyyy"))
sle_date.triggerevent(modified!)
end event

event lineup;date new_date
n_cst_string lnv_string
new_date = lnv_string.of_SpecialDate(sle_date.text)

if isnull(new_date) then
	if isdate(left(sle_date.text, 8)) then
		new_date = date(left(sle_date.text, 8))
	elseif isdate(left(sle_date.text, 7)) then
		new_date = date(left(sle_date.text, 7))
	elseif isdate(left(sle_date.text, 6)) then
		new_date = date(left(sle_date.text, 6))
	else
		beep(1)
		return
	end if
end if

new_date = relativedate(new_date, 30)
id_batch = new_date
sle_date.text = upper(string(id_batch, "mm/dd/yyyy"))
sle_date.triggerevent(modified!)

end event

