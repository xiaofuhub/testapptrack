$PBExportHeader$w_response_getdivisions.srw
forward
global type w_response_getdivisions from w_response
end type
type dw_divisions from u_dw within w_response_getdivisions
end type
type cb_ok from commandbutton within w_response_getdivisions
end type
type cb_cancel from commandbutton within w_response_getdivisions
end type
end forward

global type w_response_getdivisions from w_response
integer width = 795
integer height = 1516
string title = "Select Divisions"
long backcolor = 12632256
boolean ib_isupdateable = false
dw_divisions dw_divisions
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_response_getdivisions w_response_getdivisions

forward prototypes
public function integer wf_getselecteddivisions (ref string asa_divisions[])
end prototypes

public function integer wf_getselecteddivisions (ref string asa_divisions[]);//returns by reference an array of ids of the selected employees
long	ll_index
String	lsa_divisions[]
DO
	ll_index = dw_divisions.getselectedrow( ll_index )
	
	IF ll_index > 0 THEN
		lsa_divisions[upperBOund( lsa_divisions )+ 1] = dw_divisions.getItemString( ll_index, "name" )
	END IF
LOOP WHILE ll_index > 0

asa_divisions = lsa_divisions

RETURN upperBOund( lsa_divisions )
end function

on w_response_getdivisions.create
int iCurrent
call super::create
this.dw_divisions=create dw_divisions
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_divisions
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_response_getdivisions.destroy
call super::destroy
destroy(this.dw_divisions)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event open;call super::open;This.of_setBase( true ) 
This.inv_Base.Of_Center()

n_cst_msg	lnv_msg
s_parm		lstr_parm

String		lsa_divisions[]

Long			ll_max
Long			ll_index

IF IsValid ( Message.PowerobjectParm ) THEN
			If UPPER( Message.PowerObjectParm.ClassName ( ) ) = "N_CST_MSG" Then 
		lnv_Msg = Message.PowerobjectParm
		
		IF isValid ( lnv_Msg ) THEN
			IF lnv_Msg.of_get_parm( "ALLDIVISIONS", lstr_Parm) > 0 THEN
				lsa_divisions = lstr_Parm.ia_Value
			END IF
		END IF
	End IF
END IF

ll_max = upperBound( lsa_divisions )

FOR ll_index = 1 TO ll_max
	dw_divisions.insertRow(0)
	dw_divisions.setitem( ll_index, "name", lsa_divisions[ll_index])
NEXT
end event

event close;call super::close;This.of_setBase( false ) 
end event

type cb_help from w_response`cb_help within w_response_getdivisions
end type

type dw_divisions from u_dw within w_response_getdivisions
event ue_keydown pbm_dwnkey
integer x = 41
integer y = 28
integer width = 704
integer height = 1244
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_generic_list"
end type

event ue_keydown;call super::ue_keydown;Long	ll_index
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
	IF upper(char(this.getItemString( ll_index, "name" ))) = LS_KEY THEN
		this.scrolltorow(ll_index)
		EXIT
	END IF
NEXT

RETURN 1 //ancestorReturnvalue
end event

event constructor;call super::constructor;this.settransobject( SQLCA )
//this.retrieve()
commit;

this.of_setrowselect( true )
inv_rowselect.of_setstyle( 1)
//
//This.Modify("em_ln.protect = 1")
//This.Modify("em_fn.protect = 1")
//
//this.setsort("em_ln A, em_fn A")
//this.sort()
end event

event destructor;call super::destructor;this.of_setrowselect( false )
end event

type cb_ok from commandbutton within w_response_getdivisions
integer x = 101
integer y = 1308
integer width = 238
integer height = 96
integer taborder = 30
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
String	lsa_divs[]
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

parent.wf_getselecteddivisions( lsa_divs )

lstr_parm.is_label = "ALLDIVS"
lstr_Parm.ia_value =	lsa_divs
lnv_msg.of_add_parm( lstr_parm )

CLOSEWITHRETURN( PARENT, lnv_msg )
end event

type cb_cancel from commandbutton within w_response_getdivisions
integer x = 430
integer y = 1308
integer width = 279
integer height = 96
integer taborder = 40
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

