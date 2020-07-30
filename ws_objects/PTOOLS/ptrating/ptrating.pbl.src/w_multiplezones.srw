$PBExportHeader$w_multiplezones.srw
forward
global type w_multiplezones from w_response
end type
type dw_zones from u_dw_zone within w_multiplezones
end type
type st_1 from statictext within w_multiplezones
end type
type sle_1 from singlelineedit within w_multiplezones
end type
type sle_origin from singlelineedit within w_multiplezones
end type
type st_2 from statictext within w_multiplezones
end type
type st_3 from statictext within w_multiplezones
end type
type cb_1 from commandbutton within w_multiplezones
end type
type cb_2 from u_cbok within w_multiplezones
end type
type cb_3 from u_cbcancel within w_multiplezones
end type
type gb_1 from groupbox within w_multiplezones
end type
end forward

global type w_multiplezones from w_response
integer x = 539
integer y = 436
integer width = 2190
integer height = 1544
string title = "Duplicate Table"
long backcolor = 12632256
dw_zones dw_zones
st_1 st_1
sle_1 sle_1
sle_origin sle_origin
st_2 st_2
st_3 st_3
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
gb_1 gb_1
end type
global w_multiplezones w_multiplezones

type variables
PRIVATE:
Long    il_CompanyID
s_co_info	istr_Company
end variables

on w_multiplezones.create
int iCurrent
call super::create
this.dw_zones=create dw_zones
this.st_1=create st_1
this.sle_1=create sle_1
this.sle_origin=create sle_origin
this.st_2=create st_2
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_zones
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.sle_origin
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.gb_1
end on

on w_multiplezones.destroy
call super::destroy
destroy(this.dw_zones)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.sle_origin)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.gb_1)
end on

event open;call super::open;ib_DisableCloseQuery = TRUE
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

lnv_Msg = Message.PowerObjectParm 

IF lnv_Msg.of_Get_Parm ( "ORIGIN" , lstr_Parm ) <> 0 THEN
	sle_origin.Text = lstr_Parm.ia_Value
END IF
end event

event pfc_default;Long	ll_RowCount 
Long	i 
String	lsa_Names[]
n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

IF istr_company.co_id > 0 THEN

	ll_RowCount = dw_zones.RowCount ( ) 
	
	FOR i = 1 TO ll_RowCount
		IF dw_zones.object.include[i] = 1 THEN
			lsa_Names [ UpperBound ( lsa_Names )  + 1 ] = dw_zones.GetItemString ( i , "name" )
		END IF
	NEXT
	
	lstr_Parm.is_Label = "DESTINATIONS"
	lstr_Parm.ia_Value = lsa_Names
	lnv_Msg.of_Add_Parm  ( lstr_Parm )
	
	lstr_Parm.is_Label = "COMPANY"
	lstr_Parm.ia_Value = istr_company
	lnv_Msg.of_Add_Parm  ( lstr_Parm )
	
	CloseWithReturn ( THIS, lnv_Msg )
ELSE
	MessageBox ( "Copy Table" , "Please select a company." )
END IF
end event

event pfc_cancel;call super::pfc_cancel;CLOSE ( THIS )
end event

type cb_help from w_response`cb_help within w_multiplezones
end type

type dw_zones from u_dw_zone within w_multiplezones
integer x = 105
integer y = 408
integer width = 1947
integer height = 800
integer taborder = 30
boolean bringtotop = true
end type

event constructor;call super::constructor;THIS.of_Setinsertable ( FALSE )
THIS.of_Setdeleteable ( FALSE )
THIS.Retrieve ( )

THIS.Object.include.visible = TRUE
end event

event getfocus;call super::getfocus;THIS.SetColumn ( 1 )
end event

type st_1 from statictext within w_multiplezones
integer x = 110
integer y = 52
integer width = 782
integer height = 64
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
string text = "Enter the Company to Copy to."
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_multiplezones
integer x = 105
integer y = 124
integer width = 933
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Long		ll_ValidateId = 0
Boolean	lb_Search = false
Boolean  lb_Employee 
Boolean	lb_Company
Boolean	lb_validate
String	ls_Search = ""
String	ls_type
Long		ll_EntityId
String	ls_MessageHeader
integer	li_Return
Long		ll_RowCount
Long		i
S_co_info	lstr_Company

IF Len  ( THIS.Text ) > 0 THEN
	ls_Search = THIS.Text 
	lb_Search = TRUE
END IF
	

li_Return = gnv_cst_Companies.of_Select &
	( istr_company, ls_Type, lb_Search, ls_Search, lb_Validate, &
	  ll_ValidateId, lb_AllowHold, lb_Notify )
IF istr_Company.co_id > 0 THEN
	il_CompanyID = istr_Company.co_id
	THIS.Text = istr_Company.Co_Name
ELSE 
	THIS.Text = ""
END  IF

end event

type sle_origin from singlelineedit within w_multiplezones
integer x = 1147
integer y = 124
integer width = 745
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 29425663
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_multiplezones
integer x = 1157
integer y = 52
integer width = 247
integer height = 64
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
string text = "Origin"
boolean focusrectangle = false
end type

type st_3 from statictext within w_multiplezones
integer x = 123
integer y = 332
integer width = 1449
integer height = 76
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
string text = "Check the boxes for the destinations you want to copy."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_multiplezones
integer x = 1637
integer y = 320
integer width = 311
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Select &All"
end type

event clicked;Long	ll_RowCount
Long	i

ll_RowCount = dw_zones.RowCount ( )

FOR i = 1 TO ll_RowCount 
	dw_zones.object.include [i] = 1
NEXT
end event

type cb_2 from u_cbok within w_multiplezones
integer x = 773
integer y = 1332
integer width = 233
integer taborder = 40
boolean bringtotop = true
end type

type cb_3 from u_cbcancel within w_multiplezones
integer x = 1111
integer y = 1332
integer width = 233
integer taborder = 50
boolean bringtotop = true
end type

type gb_1 from groupbox within w_multiplezones
integer x = 69
integer y = 240
integer width = 2053
integer height = 1060
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Destinations"
end type

