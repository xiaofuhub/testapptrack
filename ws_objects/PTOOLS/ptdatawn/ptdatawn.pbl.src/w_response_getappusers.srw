$PBExportHeader$w_response_getappusers.srw
forward
global type w_response_getappusers from w_response
end type
type dw_appusers from u_dw within w_response_getappusers
end type
type cb_ok from commandbutton within w_response_getappusers
end type
type cb_cancel from commandbutton within w_response_getappusers
end type
type st_1 from statictext within w_response_getappusers
end type
end forward

global type w_response_getappusers from w_response
integer width = 974
integer height = 1604
string title = "Select Users"
long backcolor = 12632256
dw_appusers dw_appusers
cb_ok cb_ok
cb_cancel cb_cancel
st_1 st_1
end type
global w_response_getappusers w_response_getappusers

type variables

end variables

forward prototypes
public function integer wf_getselectedids (ref long ala_ids[])
end prototypes

public function integer wf_getselectedids (ref long ala_ids[]);//returns by reference an array of ids of the selected employees
long	ll_index
long	lla_appUsers[]
DO
	ll_index = dw_appusers.getselectedrow( ll_index )
	
	IF ll_index > 0 THEN
		lla_appusers[upperBOund( lla_appusers )+ 1] = dw_appusers.getItemNumber( ll_index, "em_id" )
	END IF
LOOP WHILE ll_index > 0

ala_ids = lla_appusers

RETURN upperBOund( lla_appUsers )
end function

on w_response_getappusers.create
int iCurrent
call super::create
this.dw_appusers=create dw_appusers
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_appusers
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.st_1
end on

on w_response_getappusers.destroy
call super::destroy
destroy(this.dw_appusers)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_1)
end on

event open;call super::open;This.of_setBase( true ) 
This.inv_Base.Of_Center()
end event

event close;call super::close;this.of_setbase( FALSE)
end event

type cb_help from w_response`cb_help within w_response_getappusers
boolean visible = false
integer height = 52
end type

type dw_appusers from u_dw within w_response_getappusers
event ue_keydown pbm_dwnkey
integer x = 37
integer y = 128
integer width = 864
integer height = 1244
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_appusers"
end type

event ue_keydown;Long	ll_index
Long	ll_max
String	ls_key

ll_max = this.rowCOunt()

ls_key = char(key)	//doesn't do what i want, so i ahve to do the blasted choose case
//MessageBox(ls_key, ls_key)
CHOOSE CASE key
	CASE keyA!
		ls_key= "A"
	CASE keyB!
		ls_key= "B"
	CASE keyC!
		ls_key= "C"
	CASE keyD!
		ls_key= "D"
	CASE keyE!
		ls_key= "E"
	CASE keyF!
		ls_key= "F"
	CASE keyG!
		ls_key= "G"
	CASE keyH!
		ls_key= "H"
	CASE keyI!
		ls_key= "I"
	CASE keyJ!
		ls_key= "J"
	CASE keyK!
		ls_key= "K"
	CASE keyL!
		ls_key= "L"
	CASE keyM!
		ls_key= "M"
	CASE keyN!
		ls_key= "N"
	CASE keyO!
		ls_key= "O"
	CASE keyP!
		ls_key= "P"
	CASE keyQ!
		ls_key= "Q"
	CASE keyR!
		ls_key= "R"
	CASE keyS!
		ls_key= "S"
	CASE keyT!
		ls_key= "T"
	CASE keyU!
		ls_key= "U"
	CASE keyV!
		ls_key= "V"
	CASE keyW!
		ls_key= "W"
	CASE keyX!
		ls_key= "X"
	CASE keyY!
		ls_key= "Y"
	CASE keyZ!
		ls_key= "Z"
																												
END CHOOSE

FOR ll_index = 1 TO ll_max
	IF char(this.getItemString( ll_index, "em_ln" )) = LS_KEY THEN
		this.scrolltorow(ll_index)
		EXIT
	END IF
NEXT

return 1
end event

event constructor;call super::constructor;this.settransobject( SQLCA )
this.retrieve()
commit;

this.of_setrowselect( true )
inv_rowselect.of_setstyle( 1)

This.Modify("em_ln.protect = 1")
This.Modify("em_fn.protect = 1")

this.setsort("em_ln A, em_fn A")
this.sort()
end event

event destructor;call super::destructor;this.of_setrowselect( false )
end event

type cb_ok from commandbutton within w_response_getappusers
integer x = 187
integer y = 1404
integer width = 238
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
boolean default = true
end type

event clicked;//Return the list of selected ids in the messageobject
Long	lla_ids[]
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

parent.wf_getselectedids( lla_ids )

lstr_parm.is_label = "USERIDS"
lstr_Parm.ia_value =	lla_ids
lnv_msg.of_add_parm( lstr_parm )

CLOSEWITHRETURN( PARENT, lnv_msg )
end event

type cb_cancel from commandbutton within w_response_getappusers
integer x = 503
integer y = 1404
integer width = 279
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CLOSE(parent)
end event

type st_1 from statictext within w_response_getappusers
integer x = 41
integer y = 44
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Select users"
boolean focusrectangle = false
end type

