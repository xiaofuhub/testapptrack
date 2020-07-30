$PBExportHeader$u_picktable.sru
forward
global type u_picktable from u_tablenames
end type
type gb_2 from groupbox within u_picktable
end type
type gb_1 from groupbox within u_picktable
end type
type st_1 from statictext within u_picktable
end type
type cb_insert from commandbutton within u_picktable
end type
type cbx_nocharges from checkbox within u_picktable
end type
end forward

global type u_picktable from u_tablenames
integer width = 3607
integer height = 1164
gb_2 gb_2
gb_1 gb_1
st_1 st_1
cb_insert cb_insert
cbx_nocharges cbx_nocharges
end type
global u_picktable u_picktable

type variables
private:

integer	ii_SelectedList
boolean	ib_nocharge
end variables

forward prototypes
public function long of_getlist (ref string asa_value[])
public subroutine of_setlist (string asa_value[])
public subroutine of_rowsync (long al_value)
public subroutine of_setlisttext (long al_whichlist)
public subroutine of_setnocharge (boolean ab_value)
public function boolean of_usenocharge ()
public subroutine of_setselectedlist (integer al_value)
public function integer of_getselectedlist ()
public subroutine of_filterratetablelist (integer al_value)
end prototypes

public function long of_getlist (ref string asa_value[]);long	ll_rowcount, &
		ll_index

string	lsa_value[]

ll_rowcount = dw_1.rowcount()	
if this.of_usenocharge( ) then
	if cbx_nocharges.checked then
		lsa_value[1] = 'N/A'
	else
		for ll_index = 1 to ll_rowcount
			lsa_value[ll_index] = dw_1.object.codename[ll_index]
		next	
	end if
else
	for ll_index = 1 to ll_rowcount
		lsa_value[ll_index] = dw_1.object.codename[ll_index]
	next	
end if
	
asa_value = lsa_value

return upperbound(asa_value)
end function

public subroutine of_setlist (string asa_value[]);long	ll_arraycount, &
		ll_rowcount, &
		ll_index, &
		ll_row
		
string	ls_table		

dw_1.Reset()

ll_arraycount = upperbound(asa_value)
ll_rowcount = ids_RateTableNames.rowcount()

//copy rows in reverse order so priority won't change
for ll_index = 1 to ll_arraycount
	
	ls_table = asa_value[ll_index]
	ll_row = ids_RateTableNames.find("codename = '" + ls_table + "'", 1, ll_rowcount)
	if ll_row > 0 then
		ids_RateTableNames.RowsCopy (ll_row, ll_row, Primary!, dw_1, dw_1.rowcount() + 1, Primary! )
	end if
next

if this.of_usenocharge() then
	if dw_1.rowcount() > 0 then
		cbx_nocharges.enabled = false
		cbx_nocharges.checked = false
	else
		if upperbound(asa_value) > 0 then
			if asa_value[1] = 'N/A' then
				cbx_nocharges.checked = true
			end if		
		end if
		cbx_nocharges.enabled = true
	end if
end if		

if dw_1.rowcount() > 0 then
	dw_1.post SelectRow(1,true)
end if
end subroutine

public subroutine of_rowsync (long al_value);//override ancestor method
if al_value > 0 then
	ids_RateTableNames.SetRow(al_value)
end if

end subroutine

public subroutine of_setlisttext (long al_whichlist);//based on the list type, change the text

choose case al_whichlist
		
	case appeon_constant.cl_AutoCreatedAccessorialCharge_list
		
		st_1.text = 'These Rate tables will be used to create items.'
		
	case else
		
		st_1.text = 'Rate tables are searched in the order they appear from top to bottom.'
		
end choose


end subroutine

public subroutine of_setnocharge (boolean ab_value);ib_nocharge = ab_value

if ib_nocharge then
	
	cbx_nocharges.visible = true
	
	if dw_1.rowcount() > 0 then		
		cbx_nocharges.enabled = false
		cbx_nocharges.checked = false
	else
		cbx_nocharges.enabled = true
	end if
else
	cbx_nocharges.visible = false
	cbx_nocharges.enabled = false
	cbx_nocharges.checked = false	
end if

end subroutine

public function boolean of_usenocharge ();return ib_nocharge
end function

public subroutine of_setselectedlist (integer al_value);ii_SelectedList = al_value

this.of_filterratetablelist( al_value )
end subroutine

public function integer of_getselectedlist ();return ii_SelectedList
end function

public subroutine of_filterratetablelist (integer al_value);//1 = appeon_constant.cl_itemfreight_list
//2 = appeon_constant.cl_chassissplit_list
//3 = appeon_constant.cl_stopoff_list
//4 = appeon_constant.cl_FuelSurcharge_list
//5 = appeon_constant.cl_PerDiem_list
//6 = appeon_constant.cl_AutoCreatedAccessorialCharge_list

choose case al_value
		
	case 1,2,3
			
		dw_tablenames.of_filterbyitemtype( n_cst_constants.cs_ItemType_Freight )
			
	case 4,5
			
		dw_tablenames.of_filterbyitemtype( n_cst_constants.cs_ItemType_Accessorial )
	CASE 6
		
		dw_tablenames.of_filterbyitemtype( "" ) // show all 
		
end choose




end subroutine

on u_picktable.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_1=create st_1
this.cb_insert=create cb_insert
this.cbx_nocharges=create cbx_nocharges
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_insert
this.Control[iCurrent+5]=this.cbx_nocharges
end on

on u_picktable.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.cb_insert)
destroy(this.cbx_nocharges)
end on

event ue_postconstructor;Super::Event ue_postconstructor()

//turn off share
dw_1.ShareDataOff()

end event

type dw_tablenames from u_tablenames`dw_tablenames within u_picktable
integer x = 965
integer y = 88
integer height = 124
end type

type dw_1 from u_tablenames`dw_1 within u_picktable
integer x = 23
integer y = 560
integer width = 3488
integer height = 476
integer taborder = 50
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;integer	li_count, &
			li_index

THIS.of_SetRowSelect ( TRUE ) 

//remove taborder
li_count = integer(this.Object.DataWindow.Column.Count)

for li_index = 1 to li_count
	this.SetTabOrder ( li_index, 0 )
next

ib_Rmbmenu = FALSE

if dw_1.rowcount() > 0 then
	dw_1.post SelectRow(1,true)
else
end if

end event

event dw_1::ue_keydown;//overriding the ancestor which prevents the use of the arrows
end event

type cb_add from u_tablenames`cb_add within u_picktable
integer x = 3273
integer y = 104
integer width = 229
integer height = 80
integer taborder = 20
end type

event cb_add::clicked;long	ll_row, &
		ll_rowcount, &
		ll_found

string	ls_table

ls_table = dw_tablenames.object.codename[dw_tablenames.getrow()]

if len(trim(ls_table)) > 0 then
	if dw_1.find("codename = '" + ls_table + "'", 1, dw_1.Rowcount()) > 0 then
		//already there
	else
		ll_rowcount = ids_RateTableNames.rowcount()
		if ll_rowcount > 0 then
			ll_found = ids_RateTableNames.find("codename = '" + ls_table + "'", 1, ll_rowcount)
			if ll_found > 0 then
				ids_RateTableNames.RowsCopy (ll_found, ll_found, Primary!, dw_1, dw_1.rowcount() + 1, Primary! )
				dw_1.Scrolltorow(dw_1.rowcount())
				dw_1.SelectRow(0, false)
				dw_1.SelectRow(dw_1.rowcount(), true)
				dw_1.SetFocus()
			end if
		end if
	end if
	if parent.of_usenocharge() then
		if dw_1.rowcount( ) > 0 then
			cbx_nocharges.enabled = false
			cbx_nocharges.checked = false
		else
			cbx_nocharges.enabled = true
		end if
	end if
end if



end event

type cb_delete from u_tablenames`cb_delete within u_picktable
integer x = 3273
integer y = 428
integer width = 229
integer taborder = 40
end type

event cb_delete::clicked;long	ll_row, &
		ll_rowcount

if dw_1.IsSelected(1) then
	ll_row = 1 
else
	ll_row = dw_1.GetSelectedRow(1)
end if

if ll_row > 0 then
				
	dw_1.deleteRow(ll_Row)
	ll_rowcount = dw_1.rowcount()
	if ll_rowcount > 0 then
		if ll_row > ll_rowcount then
			ll_row = ll_rowcount
		end if
	
		dw_1.selectrow(0,false)
		dw_1.selectrow(ll_row,true)
		dw_1.post scrolltorow(ll_row)
		dw_1.post setfocus()
	end if	
	
	if parent.of_usenocharge() then
		if ll_rowcount > 0 then
			cbx_nocharges.enabled = false
		else
			cbx_nocharges.enabled = true
		end if
	end if
	
end if

end event

type gb_2 from groupbox within u_picktable
integer y = 360
integer width = 3534
integer height = 724
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Selected rate tables"
end type

type gb_1 from groupbox within u_picktable
integer x = 951
integer y = 24
integer width = 2583
integer height = 320
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Select a rate &table"
end type

type st_1 from statictext within u_picktable
integer x = 997
integer y = 444
integer width = 1842
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Rate tables are searched in the order they appear from top to bottom."
boolean focusrectangle = false
end type

type cb_insert from commandbutton within u_picktable
integer x = 3273
integer y = 224
integer width = 229
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Insert"
end type

event clicked;long	ll_row, &
		ll_rowcount, &
		ll_found, &
		ll_selectedrow

string	ls_table

ls_table = dw_tablenames.object.codename[dw_tablenames.getrow()]

if len(trim(ls_table)) > 0 then
	if dw_1.find("codename = '" + ls_table + "'", 1, dw_1.Rowcount()) > 0 then
		//already there
	else
		ll_rowcount = ids_RateTableNames.rowcount()
		if ll_rowcount > 0 then
			ll_found = ids_RateTableNames.find("codename = '" + ls_table + "'", 1, ll_rowcount)
			if ll_found > 0 then
				if dw_1.IsSelected(1) then
					ll_selectedrow = 1
				else
					ll_selectedrow = dw_1.GetSelectedRow(1)
				end if
				if ll_selectedrow > 0 then
					ids_RateTableNames.RowsCopy (ll_found, ll_found, Primary!, dw_1, ll_selectedrow, Primary! )
			//		dw_1.SetRow(dw_1.rowcount())
					dw_1.Scrolltorow(ll_selectedrow)
					dw_1.SelectRow(0, false)
					dw_1.SelectRow(ll_selectedrow + 1, true)
					dw_1.SetFocus()
				else
					messagebox('Code Defaults', 'The new code will be inserted before the highlighted row.')
				end if
			end if
		end if
	end if
end if

end event

type cbx_nocharges from checkbox within u_picktable
integer x = 174
integer y = 444
integer width = 411
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "No Charges"
end type

event constructor;this.visible = false
end event

