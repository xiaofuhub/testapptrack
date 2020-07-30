$PBExportHeader$w_billtopoints.srw
forward
global type w_billtopoints from w_sheet
end type
type dw_1 from u_dw within w_billtopoints
end type
type cb_add from commandbutton within w_billtopoints
end type
type cb_delete from commandbutton within w_billtopoints
end type
type cb_close from commandbutton within w_billtopoints
end type
type cb_save from commandbutton within w_billtopoints
end type
end forward

global type w_billtopoints from w_sheet
int X=174
int Y=208
int Width=3278
int Height=1868
boolean TitleBar=true
string Title="Billto Origin/Destination Points"
long BackColor=80269524
dw_1 dw_1
cb_add cb_add
cb_delete cb_delete
cb_close cb_close
cb_save cb_save
end type
global w_billtopoints w_billtopoints

type variables
long	il_billto, &
	il_origin, &
	il_destination
end variables

on w_billtopoints.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_close=create cb_close
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_save
end on

on w_billtopoints.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_close)
destroy(this.cb_save)
end on

event open;call super::open;this.height=1912
this.width=3565

dw_1.post Setfocus()

end event

event pfc_save;//override ancestor

long	ll_return

if dw_1.accepttext() = 1 then
	if dw_1.event ue_validate() = 1 then
		ll_return = super::event pfc_save()	
	end if
end if

return ll_return
end event

type dw_1 from u_dw within w_billtopoints
event ue_clearblankrows ( )
event type boolean ue_duplicate ( long al_origin,  long al_destination,  long al_row )
event type integer ue_validate ( )
int X=27
int Y=28
int Width=3168
int Height=1524
int TabOrder=10
boolean BringToTop=true
string DataObject="d_billtopoints"
end type

event ue_clearblankrows;this.setredraw(false)

Long	ll_RowCount
Long	i

ll_RowCount = THIS.RowCount ( )
FOR i = ll_RowCount TO 1 STEP -1
	IF IsNull (  THIS.GetItemString ( i , "origin_name", Primary!, true  )  ) or &
		IsNull (  THIS.GetItemString ( i , "destination_name", Primary!, true  )  ) or &
		IsNull (  THIS.GetItemString ( i , "billto_name", Primary!, true  )  ) THEN
		THIS.RowsDiscard ( i, i, Primary! ) 
	END IF	
NEXT
	
this.setredraw(true)
end event

event ue_duplicate;boolean lb_duplicate

long	ll_row, ll_rowcount	

if al_origin > 0 and al_destination > 0 then
	ll_rowcount = this.Rowcount()
	
	do
		ll_row = dw_1.find("BilltoPoints_origin = " + string(al_origin) +&
								" and BilltoPoints_destination = " + string(al_destination) , ll_row + 1, ll_rowcount)
		if ll_row > 0 then 
			if ll_row = al_row then
				lb_duplicate = false
				continue
			else
				//already there
				messagebox("Add BIllto Points", "The Origin, Destination you entered is already in the list")
				lb_duplicate = true	
				exit
			end if
		end if
			
	loop while ll_row > 0 and ll_row < ll_rowcount

end if

return lb_duplicate
end event

event ue_validate;integer	li_return=1

long	ll_row, &
		ll_billto, &
		ll_origin, &
		ll_destination

string	ls_messagetitle = 'Billto Origin/Destination Points'

ll_row = this.getrow()

if ll_row > 0 then
	ll_origin = this.object.BilltoPoints_origin[ll_row]
	ll_destination = this.object.BilltoPoints_destination[ll_row]
	ll_billto = this.object.BilltoPoints_id[ll_row] 
	if isnull(ll_origin) or ll_origin = 0 then
		messagebox(ls_messagetitle, 'Origin is required.')
		this.post setcolumn('origin_name')
		this.post Setfocus()
		li_return = -1
	elseif isnull(ll_destination) or ll_destination = 0 then
		messagebox(ls_messagetitle, 'Destination is required.')
		this.post setcolumn('destination_name')
		this.post Setfocus()
		li_return = -1
	elseif isnull(ll_billto) or ll_billto = 0 then
		messagebox(ls_messagetitle, 'Billto is required.')
		this.post setcolumn('billto_name')
		this.post Setfocus()
		li_return = -1
	end if
end if

return li_return
end event

event constructor;this.settransobject(sqlca)

THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (1) //2 = extended row select servic
of_setinsertable ( false )
of_setdeleteable ( false )
//inv_rowselect.of_add(false)

//of_SetAutoSort ( TRUE )

//ib_Rmbmenu = FALSE

if this.retrieve() > 0 then
	//ok
else
	this.insertrow(0)
end if


end event

event itemchanged;call super::itemchanged;integer	li_return
String	ls_Return
String	ls_Search = ""

n_cst_beo_company	lnv_company

li_return = AncestorReturnValue

if li_return = 0 then
	choose case dwo.name
			
		case 'origin_name', 'destination_name', 'billto_name'
			
			ls_Search = Trim ( data  )
			
			IF Len  ( ls_Search ) > 0 THEN
				
				lnv_company = gnv_cst_Companies.of_Select(ls_Search)
				
				if isvalid(lnv_company) then
					this.settext(lnv_company.of_getname())
					choose case dwo.name
						case 'origin_name'
							if this.event ue_duplicate(lnv_company.of_getid(),this.object.BilltoPoints_destination[row], row) then
								li_return = 1
								this.settext('')
							else
								this.object.origin_name[row] = lnv_company.of_getname()
								this.object.BilltoPoints_origin[row] = lnv_company.of_getid()
							end if
						case 'destination_name'
							if this.event ue_duplicate(this.object.BilltoPoints_origin[row],lnv_company.of_getid(), row) then
								li_return = 1
								this.settext('')
							else
								this.object.destination_name[row] = lnv_company.of_getname()
								this.object.BilltoPoints_destination[row] = lnv_company.of_getid()
							end if
						case 'billto_name'
							this.object.billto_name[row] = lnv_company.of_getname()
							this.object.BilltoPoints_id[row] = lnv_company.of_getid()
					end choose
				else
					this.settext('')
					li_return = 1
				end if
				
				if li_return = 0 then
	
					li_return = 2
					destroy lnv_company
				
					choose case dwo.name
						case 'origin_name'
							this.setcolumn('destination_name')
						case 'destination_name'
							this.setcolumn('billto_name')
						case 'billto_name'
							if row = this.rowcount() then
								this.Event post PFC_AddRow()
								this.post setcolumn('origin_name')
							end if
					end choose
					
				end if
				
			ELSE
				li_return = 1
			END IF
			
	end choose
end if

return li_return
end event

event itemerror;call super::itemerror;integer	li_return

li_return = AncestorReturnValue

choose case dwo.name
	case 'origin_name', 'destination_name', 'billto_name'
		if len(trim(data)) = 0 then
			choose case dwo.name
				case 'orgin_name'
					messagebox('Origin/Destination Points', 'Origin is required.')
				case 'destination_name'
										messagebox('Origin/Destination Points', 'Destination is required.')
				case 'billto_name'
					messagebox('Origin/Destination Points', 'Billto is required.')					
			end choose
		end if	
		li_return = 1
//		li_return = 3
		
end choose

return li_return
end event

event pfc_addrow;//override ancestor

long	ll_return

if this.accepttext() = 1 then
	if this.event ue_validate() = 1 then
		ll_return = super::event pfc_addrow()
		
		if ll_Return > 0 then
			this.ScrolltoRow(ll_return)
			this.setcolumn('origin_name')
		end if
	end if
end if

this.post setfocus()

return ll_return
end event

event clicked;//override

end event

type cb_add from commandbutton within w_billtopoints
int X=841
int Y=1608
int Width=343
int Height=88
int TabOrder=20
boolean BringToTop=true
string Text="&Add"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long	ll_row		

ll_row = dw_1.event pfc_addrow()
if ll_row > 0 then	
	dw_1.Scrolltorow(ll_row)
	dw_1.SetFocus()
end if

end event

type cb_delete from commandbutton within w_billtopoints
int X=1230
int Y=1608
int Width=343
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="&Delete"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long	ll_row, &
		ll_rowcount, &
		ll_selectedcount

ll_rowcount = dw_1.rowcount()
for ll_row = ll_rowcount to 1 step -1

	if dw_1.IsSelected(ll_row) then
		ll_selectedcount ++
		dw_1.setrow(ll_row)
		dw_1.event pfc_deleterow()
	end if
		
next

if ll_selectedcount = 0 then
	//If no selected rows then delete the current row
	dw_1.event pfc_deleterow()
end if
end event

type cb_close from commandbutton within w_billtopoints
int X=1618
int Y=1608
int Width=343
int Height=88
int TabOrder=40
boolean BringToTop=true
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_billtopoints
int X=2011
int Y=1608
int Width=343
int Height=88
int TabOrder=50
boolean BringToTop=true
string Text="&Save"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;parent.event pfc_save()
end event

