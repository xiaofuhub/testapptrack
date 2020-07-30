$PBExportHeader$w_edi322_dialog.srw
$PBExportComments$Prompts the user for additional information during the 322 generation process if the event being notified is not part of shipment.  Added 3-9 BKW
forward
global type w_edi322_dialog from w_response
end type
type dw_data from u_dw within w_edi322_dialog
end type
type cb_ok from u_cb within w_edi322_dialog
end type
type mle_1 from multilineedit within w_edi322_dialog
end type
end forward

global type w_edi322_dialog from w_response
integer width = 2391
integer height = 2384
string title = "EDI 322 -- Transmission Data Confirmation"
boolean controlmenu = false
dw_data dw_data
cb_ok cb_ok
mle_1 mle_1
end type
global w_edi322_dialog w_edi322_dialog

type variables
Private:
DataStore	ids_Source	//Reference to source datastore passed in as a parm to the window, and used as the source
								//for the display dw via ShareData
end variables

on w_edi322_dialog.create
int iCurrent
call super::create
this.dw_data=create dw_data
this.cb_ok=create cb_ok
this.mle_1=create mle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.mle_1
end on

on w_edi322_dialog.destroy
call super::destroy
destroy(this.dw_data)
destroy(this.cb_ok)
destroy(this.mle_1)
end on

event open;call super::open;//A datastore with dataobject d_edi322_dialog is expected to be passed in as the OpenWithParm parameter.

//This datastore will be used as the source for the display via ShareData, automatically allowing the changes
//the user makes in the window to be conveyed out to the calling script

ids_Source = Message.PowerObjectParm

ids_Source.ShareData ( dw_Data )
end event

event pfc_default;call super::pfc_default;CHOOSE CASE dw_Data.AcceptText ( )
		
	CASE 1  //Data was accepted and passed validation.
		
		//The datawindow is linked to the datastore passed in via sharedata, so the results the user has entered are already
		//being passed out, so no return value is needed.
		
		//Turn off sharing before closing (?)
		ids_Source.ShareDataOff ( )
		
		Close ( This )
		
END CHOOSE
end event

type cb_help from w_response`cb_help within w_edi322_dialog
integer x = 2217
integer y = 2220
integer taborder = 30
end type

type dw_data from u_dw within w_edi322_dialog
integer x = 78
integer y = 300
integer width = 2226
integer height = 1696
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_edi322_dialog"
end type

type cb_ok from u_cb within w_edi322_dialog
integer x = 1001
integer y = 2112
integer taborder = 20
boolean bringtotop = true
string text = "&OK"
end type

event clicked;call super::clicked;Parent.Event pfc_Default ( )
end event

type mle_1 from multilineedit within w_edi322_dialog
integer x = 78
integer y = 36
integer width = 2217
integer height = 228
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "EDI Field Limits are listed under ~"Max Length~" -- this indicates how may characters you can type.  Each field automatically restricts entry to this number of characters.  Columbus Lines only reads the 1st 20 chars of Notes Line 1 and ignores Line 2."
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

