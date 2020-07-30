$PBExportHeader$w_eventconfirmationoptions.srw
forward
global type w_eventconfirmationoptions from w_response
end type
type dw_1 from u_dw_eventconfirmationoptions within w_eventconfirmationoptions
end type
type cb_1 from u_cbok within w_eventconfirmationoptions
end type
type cb_2 from u_cbcancel within w_eventconfirmationoptions
end type
type st_1 from statictext within w_eventconfirmationoptions
end type
type sle_1 from singlelineedit within w_eventconfirmationoptions
end type
type cb_3 from commandbutton within w_eventconfirmationoptions
end type
end forward

global type w_eventconfirmationoptions from w_response
integer x = 110
integer y = 400
integer width = 2592
integer height = 828
string title = "Event Confirmation Requirements"
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
st_1 st_1
sle_1 sle_1
cb_3 cb_3
end type
global w_eventconfirmationoptions w_eventconfirmationoptions

type variables
n_cst_EventConfirmationOptions	inv_Options
Boolean	ib_Cancel
end variables

forward prototypes
public function blob wf_getfullstate ()
end prototypes

public function blob wf_getfullstate ();Blob	lblb_State

dw_1.GetFullState ( lblb_State )

RETURN lblb_State
end function

on w_eventconfirmationoptions.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.cb_3
end on

on w_eventconfirmationoptions.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_3)
end on

event open;call super::open;

inv_Options = Message.PowerObjectParm
ib_DisableCloseQuery = TRUE
IF IsValid ( inv_Options ) THEN
	dw_1.SetFullState ( inv_Options.of_GetFullState ( ) ) 
ELSE
	MessageBox ( "Confirmation Options" , "An error occurred while attempting to initialize the display. Processing stopped." )
	CLOSE ( THIS )
END IF


end event

event pfc_default;
inv_options.of_SetFullState ( THIS.wf_GetFullState ( ) )
IF inv_Options.of_SaveSource ( ) <> 1 THEN
	MessageBox ( "Save Settings" , "An error occurred while attempting to save the current settings." )
ELSE
	ib_Cancel = TRUE
	CLOSE ( THIS )
END IF

end event

event pfc_cancel;call super::pfc_cancel;ib_Cancel = TRUE
CLOSE ( THIS )
end event

event close;call super::close;
IF NOT ib_Cancel THEN
	IF dw_1.ModifiedCount ( ) > 0 THEN
		inv_options.of_SetFullState ( THIS.wf_GetFullState ( ) )
		IF MessageBox ( "Save Changes" , "Do you want to save your changes?" , QUESTION! , YESNO! ,1 ) = 1 THEN
			IF inv_Options.of_SaveSource ( ) <> 1 THEN
				MessageBox ( "Save Settings" , "An error occurred while attempting to save the current settings." )
			END IF
		END IF
	END IF
END IF
end event

event pfc_postopen;dw_1.SetItemStatus ( 1, 0, PRIMARY!, NewModified!	 )
dw_1.SetItemStatus ( 2, 0, PRIMARY!, NewModified!	 )
dw_1.SetItemStatus ( 3, 0, PRIMARY!, NewModified!	 )

dw_1.SetItemStatus ( 1, 0, PRIMARY!, NotModified! )
dw_1.SetItemStatus ( 2, 0, PRIMARY!, NotModified! )
dw_1.SetItemStatus ( 3, 0, PRIMARY!, NotModified! )

end event

type cb_help from w_response`cb_help within w_eventconfirmationoptions
integer x = 2482
integer y = 672
end type

type dw_1 from u_dw_eventconfirmationoptions within w_eventconfirmationoptions
integer x = 14
integer y = 196
integer width = 2542
integer height = 380
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
borderstyle borderstyle = styleraised!
end type

event getfocus;call super::getfocus;THIS.BORDERSTYLE=STYLELOWERED!
end event

event losefocus;THIS.BORDERSTYLE=STYLERAISED!
end event

type cb_1 from u_cbok within w_eventconfirmationoptions
integer x = 823
integer y = 612
integer width = 233
integer taborder = 40
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_eventconfirmationoptions
integer x = 1111
integer y = 612
integer width = 233
integer taborder = 50
boolean bringtotop = true
end type

type st_1 from statictext within w_eventconfirmationoptions
integer x = 27
integer y = 56
integer width = 1298
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Enter password to remove Chassis Requirement:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_eventconfirmationoptions
integer x = 1339
integer y = 44
integer width = 507
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;if this.text = "@1521" then
	long ll_row, &
		  ll_rowcount, &
		  ll_tab
	dw_1.enabled=true
	ll_rowcount=dw_1.rowcount()
	for ll_row = 1 to ll_rowcount
		ll_tab ++
		dw_1.object.chassis.tabsequence = ll_tab
	next
	dw_1.setfocus()
end if
end event

type cb_3 from commandbutton within w_eventconfirmationoptions
integer x = 1390
integer y = 612
integer width = 334
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Require All"
end type

event clicked;long	ll_row, &
		ll_rowcount, &
		ll_col, &
		ll_colcount

//check all boxes
ll_rowcount = dw_1.rowcount()
ll_colcount = long(dw_1.Object.DataWindow.Column.Count)
for ll_row = 1 to ll_rowcount
	for ll_col = 1 to ll_colcount
		dw_1.SetItem ( ll_row , ll_col , 1 )
	next
next

end event

