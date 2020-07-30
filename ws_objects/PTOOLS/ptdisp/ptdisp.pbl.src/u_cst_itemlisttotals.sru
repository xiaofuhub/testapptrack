$PBExportHeader$u_cst_itemlisttotals.sru
forward
global type u_cst_itemlisttotals from userobject
end type
type st_2 from statictext within u_cst_itemlisttotals
end type
type st_1 from statictext within u_cst_itemlisttotals
end type
type st_charges from statictext within u_cst_itemlisttotals
end type
type st_weight from statictext within u_cst_itemlisttotals
end type
type gb_itemlisttotals from groupbox within u_cst_itemlisttotals
end type
end forward

global type u_cst_itemlisttotals from userobject
integer width = 645
integer height = 320
long backcolor = 12632256
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_2 st_2
st_1 st_1
st_charges st_charges
st_weight st_weight
gb_itemlisttotals gb_itemlisttotals
end type
global u_cst_itemlisttotals u_cst_itemlisttotals

forward prototypes
public function integer of_setweight (long al_value)
public function integer of_setcharges (decimal ac_value)
public function integer of_setgrouplabel (string as_value)
public function integer of_hidecharges ()
end prototypes

public function integer of_setweight (long al_value);Integer	li_Return

IF al_Value >= 0 THEN
	st_Weight.Text = String ( al_Value, "#,##0" )
	li_Return = 1
ELSE
	st_Weight.Text = ""
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_setcharges (decimal ac_value);Integer	li_Return

IF ac_Value >= 0 THEN
	st_Charges.Text = String ( ac_Value, "$#,##0.00" )
	li_Return = 1
ELSE
	st_Charges.Text = ""
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_setgrouplabel (string as_value);gb_ItemListTotals.Text = as_Value

RETURN 1
end function

public function integer of_hidecharges ();//Created by dan 1-30-07

Int	li_Return = 1

st_charges.visible = false

RETURN li_Return
end function

on u_cst_itemlisttotals.create
this.st_2=create st_2
this.st_1=create st_1
this.st_charges=create st_charges
this.st_weight=create st_weight
this.gb_itemlisttotals=create gb_itemlisttotals
this.Control[]={this.st_2,&
this.st_1,&
this.st_charges,&
this.st_weight,&
this.gb_itemlisttotals}
end on

on u_cst_itemlisttotals.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_charges)
destroy(this.st_weight)
destroy(this.gb_itemlisttotals)
end on

event constructor;//Added by dan 1-30-07
n_cst_privsmanager lnv_manager

lnv_manager = gnv_app.of_getPrivsmanager( )
IF lnv_manager.of_getuserpermissionfromfn( "View Charges") <> 1 THEN
	this.of_hidecharges()
END IF

end event

type st_2 from statictext within u_cst_itemlisttotals
integer x = 27
integer y = 196
integer width = 251
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Charges:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within u_cst_itemlisttotals
integer x = 32
integer y = 88
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Weight:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_charges from statictext within u_cst_itemlisttotals
integer x = 288
integer y = 192
integer width = 293
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 29425663
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_weight from statictext within u_cst_itemlisttotals
integer x = 288
integer y = 84
integer width = 293
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 29425663
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_itemlisttotals from groupbox within u_cst_itemlisttotals
integer y = 4
integer width = 635
integer height = 304
integer taborder = 1
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Totals"
end type

