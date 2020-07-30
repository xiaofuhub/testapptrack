$PBExportHeader$w_getscac.srw
forward
global type w_getscac from w_response
end type
type cb_ok from commandbutton within w_getscac
end type
type st_1 from statictext within w_getscac
end type
type dw_1 from u_dw within w_getscac
end type
end forward

global type w_getscac from w_response
integer x = 214
integer y = 221
integer width = 1609
integer height = 1128
string title = "Post 204"
long backcolor = 12632256
cb_ok cb_ok
st_1 st_1
dw_1 dw_1
end type
global w_getscac w_getscac

type variables
n_ds	ids_204OutCompanies
end variables

on w_getscac.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_getscac.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;call super::open;Long	ll_index
Long	ll_max
Long	ll_newRow
Long	ll_coId
Long	ll_defaultRow
String	ls_defaultScac
String	ls_scac
String	ls_defaultName

n_cst_beo_shipment	lnv_shipment

this.of_setbase( true )
inv_base.of_center( )

IF isvalid( message.powerobjectparm ) THEN
	//default to carrier if possible
	IF message.powerobjectparm.classname() = "n_cst_beo_shipment"  THEN
		lnv_shipment = message.powerobjectparm
		ll_coid = lnv_shipment.of_getcarrier( )
	END IF
END IF
dw_1.retrieve( )
commit;
	
dw_1.setSort( "scac A")
dw_1.sort()

dw_1.inv_rowselect.of_setStyle( 0 )

FOR ll_index = 1 TO dw_1.rowCount()

	IF ll_coId = dw_1.getITemNumber( ll_index, "companyid" ) THEN
		dw_1.inv_rowselect.of_rowSelect( ll_index )
		dw_1.setRow( ll_index)
		EXIT
	END IF
NEXT

	







end event

event close;call super::close;destroy ids_204OutCompanies
end event

type cb_help from w_response`cb_help within w_getscac
end type

type cb_ok from commandbutton within w_getscac
integer x = 613
integer y = 908
integer width = 329
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;dw_1.event ue_select()
end event

type st_1 from statictext within w_getscac
integer x = 37
integer y = 40
integer width = 1413
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Select a company"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_getscac
event ue_select ( )
integer x = 18
integer y = 124
integer width = 1513
integer height = 740
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_204companyscacs"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event ue_select();n_cst_msg	lnv_msg
s_parm		lstr_parm
Long	row
row = dw_1.getrow( )
IF row > 0 THEN
	lstr_parm.ia_value = this.getItemstring( row, "scac" )
	lstr_parm.is_label = "SCAC"
	lnv_msg.of_add_parm( lstr_parm )
ELSEIF dw_1.rowcount( ) > 0 THEN
	lstr_parm.ia_value = this.getItemstring( 1, "scac" )
	lstr_parm.is_label = "SCAC"
	lnv_msg.of_add_parm( lstr_parm )
END IF

closewithReturn(parent, lnv_msg )
end event

event constructor;call super::constructor;this.settransobject(SQLCA)
this.of_setrowselect( true )
end event

event doubleclicked;call super::doubleclicked;this.event ue_select()
end event

