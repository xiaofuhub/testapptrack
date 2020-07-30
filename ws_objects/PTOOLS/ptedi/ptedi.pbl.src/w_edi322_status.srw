$PBExportHeader$w_edi322_status.srw
$PBExportComments$Prompts the user for additional information during the 322 generation process if the event being notified is not part of shipment.  Added 3-9 BKW
forward
global type w_edi322_status from w_response
end type
type rb_rail from radiobutton within w_edi322_status
end type
type rb_imc from radiobutton within w_edi322_status
end type
type rb_billto from radiobutton within w_edi322_status
end type
type rb_badorder from radiobutton within w_edi322_status
end type
type rb_emptyavailable from radiobutton within w_edi322_status
end type
type rb_shipper from radiobutton within w_edi322_status
end type
type cb_1 from commandbutton within w_edi322_status
end type
type cb_2 from commandbutton within w_edi322_status
end type
end forward

global type w_edi322_status from w_response
integer x = 214
integer y = 221
integer width = 1051
integer height = 996
string title = "322 status"
boolean controlmenu = false
long backcolor = 12632256
boolean ib_isupdateable = false
event ue_close ( )
rb_rail rb_rail
rb_imc rb_imc
rb_billto rb_billto
rb_badorder rb_badorder
rb_emptyavailable rb_emptyavailable
rb_shipper rb_shipper
cb_1 cb_1
cb_2 cb_2
end type
global w_edi322_status w_edi322_status

forward prototypes
private function string wf_getselectedstatus ()
end prototypes

private function string wf_getselectedstatus ();String	ls_Return

IF rb_rail.Checked THEN
	ls_Return = n_cst_bso_EdiManager_322.cs_FlagStatus_Rail
ELSEIF rb_imc.Checked THEN
	ls_Return = n_cst_bso_EdiManager_322.cs_FlagStatus_TerminatedIMC
ELSEIF rb_billto.Checked THEN
	ls_Return = n_cst_bso_EdiManager_322.cs_FlagStatus_BillToYard
ELSEIF rb_badorder.Checked THEN
	ls_Return = n_cst_bso_EdiManager_322.cs_FlagStatus_BadOrder
ELSEIF rb_emptyavailable.Checked THEN
	ls_Return = n_cst_bso_EdiManager_322.cs_FlagStatus_EmptyAvailable
ELSEIF rb_shipper.Checked THEN
	ls_Return = n_cst_bso_EdiManager_322.cs_FlagStatus_DropEmptyAtShipper
END IF

RETURN ls_Return
	
	
end function

on w_edi322_status.create
int iCurrent
call super::create
this.rb_rail=create rb_rail
this.rb_imc=create rb_imc
this.rb_billto=create rb_billto
this.rb_badorder=create rb_badorder
this.rb_emptyavailable=create rb_emptyavailable
this.rb_shipper=create rb_shipper
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_rail
this.Control[iCurrent+2]=this.rb_imc
this.Control[iCurrent+3]=this.rb_billto
this.Control[iCurrent+4]=this.rb_badorder
this.Control[iCurrent+5]=this.rb_emptyavailable
this.Control[iCurrent+6]=this.rb_shipper
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
end on

on w_edi322_status.destroy
call super::destroy
destroy(this.rb_rail)
destroy(this.rb_imc)
destroy(this.rb_billto)
destroy(this.rb_badorder)
destroy(this.rb_emptyavailable)
destroy(this.rb_shipper)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;THIS.of_SetBase ( TRUE ) 
inv_Base.of_Center( )

end event

type cb_help from w_response`cb_help within w_edi322_status
end type

type rb_rail from radiobutton within w_edi322_status
integer x = 101
integer y = 104
integer width = 722
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
string text = "Terminated at Rail / Pier"
end type

type rb_imc from radiobutton within w_edi322_status
integer x = 101
integer y = 200
integer width = 663
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
string text = "Terminated Other IMC"
end type

type rb_billto from radiobutton within w_edi322_status
integer x = 101
integer y = 296
integer width = 585
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
string text = "Drop at Bill to Yard"
end type

type rb_badorder from radiobutton within w_edi322_status
integer x = 101
integer y = 392
integer width = 402
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
string text = "Bad Order"
end type

type rb_emptyavailable from radiobutton within w_edi322_status
integer x = 101
integer y = 488
integer width = 649
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
string text = "Drop Empty Available"
end type

type rb_shipper from radiobutton within w_edi322_status
integer x = 101
integer y = 584
integer width = 695
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
string text = "Drop Empty At Shipper"
end type

type cb_1 from commandbutton within w_edi322_status
integer x = 114
integer y = 716
integer width = 370
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;String	ls_Status 

ls_Status = wf_getselectedstatus( )

IF ls_Status = "" THEN
	Messagebox ( "322 Status" , "You must select a status to contiue." ) 
ELSE
	CloseWithReturn( parent , ls_Status )
END IF
end event

type cb_2 from commandbutton within w_edi322_status
integer x = 535
integer y = 716
integer width = 370
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;Close ( PARENT )

end event

