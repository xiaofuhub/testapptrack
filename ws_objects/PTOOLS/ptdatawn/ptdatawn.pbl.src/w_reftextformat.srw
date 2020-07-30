$PBExportHeader$w_reftextformat.srw
forward
global type w_reftextformat from w_response
end type
type mle_1 from multilineedit within w_reftextformat
end type
type sle_delimiter from singlelineedit within w_reftextformat
end type
type cb_apply from commandbutton within w_reftextformat
end type
type cbx_return from checkbox within w_reftextformat
end type
type cbx_tab from checkbox within w_reftextformat
end type
type cb_3 from commandbutton within w_reftextformat
end type
type gb_1 from groupbox within w_reftextformat
end type
end forward

global type w_reftextformat from w_response
int X=1134
int Y=388
int Width=937
int Height=1652
boolean TitleBar=true
string Title="Send To Clipboard"
event ue_format ( )
mle_1 mle_1
sle_delimiter sle_delimiter
cb_apply cb_apply
cbx_return cbx_return
cbx_tab cbx_tab
cb_3 cb_3
gb_1 gb_1
end type
global w_reftextformat w_reftextformat

type variables
String	isa_Text[]
String	is_Delimiter

end variables

forward prototypes
private function string wf_getdelimiter ()
end prototypes

event ue_format;n_cst_String	lnv_String
String	ls_Result

String	ls_Delimiter

ls_Delimiter = wf_GetDelimiter ( )

lnv_String.of_ArrayToString ( isa_Text , ls_Delimiter , ls_Result )

mle_1.Text = ls_Result



end event

private function string wf_getdelimiter ();String	ls_Delimiter

ls_Delimiter  = sle_delimiter.Text

IF cbx_return.Checked THEN
	ls_Delimiter += "~r~n"
ELSEIF cbx_tab.checked THEN
	ls_Delimiter += "~t"
END IF

RETURN ls_Delimiter
end function

on w_reftextformat.create
int iCurrent
call super::create
this.mle_1=create mle_1
this.sle_delimiter=create sle_delimiter
this.cb_apply=create cb_apply
this.cbx_return=create cbx_return
this.cbx_tab=create cbx_tab
this.cb_3=create cb_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_1
this.Control[iCurrent+2]=this.sle_delimiter
this.Control[iCurrent+3]=this.cb_apply
this.Control[iCurrent+4]=this.cbx_return
this.Control[iCurrent+5]=this.cbx_tab
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.gb_1
end on

on w_reftextformat.destroy
call super::destroy
destroy(this.mle_1)
destroy(this.sle_delimiter)
destroy(this.cb_apply)
destroy(this.cbx_return)
destroy(this.cbx_tab)
destroy(this.cb_3)
destroy(this.gb_1)
end on

event open;call super::open;n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

lnv_Msg = Message.PowerobjectParm

IF lnv_Msg.of_Get_Parm ( "TEXT" , lstr_Parm ) <> 0 THEN
	isa_Text = lstr_Parm.ia_Value
END IF


end event

event pfc_postopen;THIS.Event ue_Format ( )
end event

type mle_1 from multilineedit within w_reftextformat
event ue_sendtoclipboard ( )
int X=50
int Y=368
int Width=805
int Height=1028
int TabOrder=50
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean AutoHScroll=true
boolean AutoVScroll=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_sendtoclipboard;n_cst_ClipBoard	lnv_Clipboard

lnv_ClipBoard.of_SetContents ( THIS.Text )
end event

type sle_delimiter from singlelineedit within w_reftextformat
int X=91
int Y=104
int Width=306
int Height=84
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Accelerator=100
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_apply from commandbutton within w_reftextformat
int X=498
int Y=104
int Width=311
int Height=88
int TabOrder=40
boolean BringToTop=true
string Text="&Apply"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Event ue_Format ( )
end event

type cbx_return from checkbox within w_reftextformat
int X=91
int Y=204
int Width=494
int Height=76
int TabOrder=20
boolean BringToTop=true
string Text="Carrige Return"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF THIS.Checked THEN
	cbx_tab.Checked = FALSE
END IF
	
end event

type cbx_tab from checkbox within w_reftextformat
int X=631
int Y=200
int Width=201
int Height=76
int TabOrder=30
boolean BringToTop=true
string Text="Tab "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF THIS.Checked THEN
	cbx_return.Checked = FALSE
END IF
end event

type cb_3 from commandbutton within w_reftextformat
int X=101
int Y=1436
int Width=709
int Height=96
int TabOrder=60
boolean BringToTop=true
string Text="&Clipboard and Close"
boolean Default=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;mle_1.Event ue_SendToClipboard ( )
Close ( PARENT )
end event

type gb_1 from groupbox within w_reftextformat
int X=50
int Y=12
int Width=805
int Height=328
string Text="&Delimiter"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

