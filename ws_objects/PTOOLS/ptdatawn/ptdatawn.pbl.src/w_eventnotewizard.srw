$PBExportHeader$w_eventnotewizard.srw
forward
global type w_eventnotewizard from w_response
end type
type rb_bill from radiobutton within w_eventnotewizard
end type
type rb_dontbill from radiobutton within w_eventnotewizard
end type
type em_amount from editmask within w_eventnotewizard
end type
type st_1 from statictext within w_eventnotewizard
end type
type st_user from statictext within w_eventnotewizard
end type
type cb_1 from u_cbok within w_eventnotewizard
end type
type cb_2 from u_cbcancel within w_eventnotewizard
end type
type st_4 from statictext within w_eventnotewizard
end type
type rb_append from radiobutton within w_eventnotewizard
end type
type rb_insert from radiobutton within w_eventnotewizard
end type
type gb_2 from groupbox within w_eventnotewizard
end type
type gb_1 from groupbox within w_eventnotewizard
end type
type sle_customer from singlelineedit within w_eventnotewizard
end type
type st_2 from statictext within w_eventnotewizard
end type
type sle_2 from singlelineedit within w_eventnotewizard
end type
type ddlb_1 from dropdownlistbox within w_eventnotewizard
end type
type mle_note from multilineedit within w_eventnotewizard
end type
type sle_1 from singlelineedit within w_eventnotewizard
end type
type st_3 from statictext within w_eventnotewizard
end type
end forward

global type w_eventnotewizard from w_response
int X=1038
int Y=148
int Width=1079
int Height=1648
boolean TitleBar=true
string Title="Event Note"
rb_bill rb_bill
rb_dontbill rb_dontbill
em_amount em_amount
st_1 st_1
st_user st_user
cb_1 cb_1
cb_2 cb_2
st_4 st_4
rb_append rb_append
rb_insert rb_insert
gb_2 gb_2
gb_1 gb_1
sle_customer sle_customer
st_2 st_2
sle_2 sle_2
ddlb_1 ddlb_1
mle_note mle_note
sle_1 sle_1
st_3 st_3
end type
global w_eventnotewizard w_eventnotewizard

type variables
n_cst_EventNote	inv_EventNote

PRIVATE:
String	is_Move

end variables

forward prototypes
public function integer wf_selectmove ()
end prototypes

public function integer wf_selectmove ();String	ls_Find
Long		ll_Index
Any		la_Value

n_cst_Settings	lnv_Setting

IF Len ( is_Move ) > 0 THEN
	CHOOSE CASE UPPER ( is_Move )
			
		CASE "CHASSIS" 
			IF lnv_Setting.of_GetSetting ( 88 , la_Value ) = 1 THEN
				ls_Find = TRIM ( String ( la_Value ) )
			END IF
		
		CASE "YARD"
			IF lnv_Setting.of_GetSetting ( 89 , la_Value ) = 1 THEN
				ls_Find = TRIM ( String ( la_Value ) )
			END IF
		
	END CHOOSE
	
	
	IF Len ( ls_Find ) > 0 THEN
		
		ll_Index = ddlb_1.FindItem ( ls_Find , 0)
		IF ll_Index > 0 THEN
			ddlb_1.SelectItem ( ll_Index )
			inv_EventNote.of_SetType ( ddlb_1.Text )
		END IF
		
	END IF
	
	
END IF


RETURN -1
end function

on w_eventnotewizard.create
int iCurrent
call super::create
this.rb_bill=create rb_bill
this.rb_dontbill=create rb_dontbill
this.em_amount=create em_amount
this.st_1=create st_1
this.st_user=create st_user
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_4=create st_4
this.rb_append=create rb_append
this.rb_insert=create rb_insert
this.gb_2=create gb_2
this.gb_1=create gb_1
this.sle_customer=create sle_customer
this.st_2=create st_2
this.sle_2=create sle_2
this.ddlb_1=create ddlb_1
this.mle_note=create mle_note
this.sle_1=create sle_1
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_bill
this.Control[iCurrent+2]=this.rb_dontbill
this.Control[iCurrent+3]=this.em_amount
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_user
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.rb_append
this.Control[iCurrent+10]=this.rb_insert
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.sle_customer
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.sle_2
this.Control[iCurrent+16]=this.ddlb_1
this.Control[iCurrent+17]=this.mle_note
this.Control[iCurrent+18]=this.sle_1
this.Control[iCurrent+19]=this.st_3
end on

on w_eventnotewizard.destroy
call super::destroy
destroy(this.rb_bill)
destroy(this.rb_dontbill)
destroy(this.em_amount)
destroy(this.st_1)
destroy(this.st_user)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_4)
destroy(this.rb_append)
destroy(this.rb_insert)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.sle_customer)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.ddlb_1)
destroy(this.mle_note)
destroy(this.sle_1)
destroy(this.st_3)
end on

event open;call super::open;is_Move = Message.Stringparm
inv_EventNote	= CREATE n_cst_EventNote
sle_2.Text = gnv_App.of_GetUserID (  )
inv_EventNote.of_SetUser ( gnv_App.of_GetUserID (  ))

THIS.wf_SelectMove ( )
inv_EventNote.of_BuildNote ( )
mle_note.text = inv_EventNote.of_GetNote ( )


end event

type rb_bill from radiobutton within w_eventnotewizard
int X=187
int Y=76
int Width=219
int Height=60
boolean BringToTop=true
string Text="&Bill"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF THIS.Checked THEN
	inv_EventNote.of_SetBill ( TRUE ) 
END IF

inv_EventNote.of_BuildNote ( )
mle_note.text = inv_EventNote.of_GetNote ( )
end event

type rb_dontbill from radiobutton within w_eventnotewizard
int X=498
int Y=76
int Width=343
int Height=60
boolean BringToTop=true
string Text="&Don't Bill"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF THIS.Checked THEN
	inv_EventNote.of_SetBill ( FALSE ) 
END IF

inv_EventNote.of_BuildNote ( )
mle_note.text = inv_EventNote.of_GetNote ( )
end event

type em_amount from editmask within w_eventnotewizard
int X=78
int Y=400
int Width=352
int Height=76
int TabOrder=20
boolean BringToTop=true
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="[currency(7)]###,###.00"
int Accelerator=97
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;inv_EventNote.of_SetAmount ( THIS.Text  )
inv_EventNote.of_BuildNote ( )
mle_note.text = inv_EventNote.of_GetNote ( )
end event

type st_1 from statictext within w_eventnotewizard
int X=457
int Y=320
int Width=187
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="&For:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_user from statictext within w_eventnotewizard
int X=82
int Y=700
int Width=370
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="&User Name:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from u_cbok within w_eventnotewizard
int X=247
int Y=1424
int TabOrder=80
boolean BringToTop=true
int TextSize=-10
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;inv_EventNote.of_setNote ( mle_note.Text 	 )
CloseWithReturn ( PARENT , inv_EventNote )
end event

type cb_2 from u_cbcancel within w_eventnotewizard
int X=535
int Y=1424
int TabOrder=90
boolean BringToTop=true
int TextSize=-10
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;close ( parent )
end event

type st_4 from statictext within w_eventnotewizard
int X=82
int Y=320
int Width=279
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="&Amount:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_append from radiobutton within w_eventnotewizard
int X=553
int Y=1280
int Width=425
int Height=76
boolean BringToTop=true
string Text="Append to &End"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF THIS.Checked THEN
	inv_Eventnote.of_SetAppend ( TRUE )
END IF
end event

type rb_insert from radiobutton within w_eventnotewizard
int X=46
int Y=1280
int Width=489
int Height=76
boolean BringToTop=true
string Text="&Insert at Beginning"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF THIS.Checked THEN
	inv_Eventnote.of_SetAppend ( FALSE )
END IF
end event

type gb_2 from groupbox within w_eventnotewizard
int X=87
int Y=20
int Width=891
int Height=128
int TabOrder=100
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

type gb_1 from groupbox within w_eventnotewizard
int X=27
int Y=888
int Width=983
int Height=500
int TabOrder=70
string Text="&Resulting Note"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_customer from singlelineedit within w_eventnotewizard
int X=82
int Y=580
int Width=887
int Height=76
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Accelerator=99
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;inv_EventNote.of_SetAuthorization ( THIS.Text )
inv_EventNote.of_BuildNote ( )
mle_note.text = inv_EventNote.of_GetNote ( )
end event

type st_2 from statictext within w_eventnotewizard
int X=82
int Y=512
int Width=695
int Height=64
boolean Enabled=false
string Text="&Customer Authorization:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_eventnotewizard
int X=82
int Y=772
int Width=887
int Height=76
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Accelerator=117
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;inv_EventNote.of_SetUser ( THIS.Text )
inv_EventNote.of_BuildNote ( )
mle_note.text = inv_EventNote.of_GetNote ( )
end event

type ddlb_1 from dropdownlistbox within w_eventnotewizard
int X=457
int Y=392
int Width=517
int Height=676
int TabOrder=30
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
int Accelerator=102
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;inv_Eventnote.of_SetType ( THIS.Text )
inv_EventNote.of_BuildNote ( )
mle_note.text = inv_EventNote.of_GetNote ( )
end event

event constructor;any	la_Value
Long	ll_Count
Long	i
String	lsa_Result[]
n_cst_Settings	lnv_Setting
n_cst_String	lnv_String

IF lnv_Setting.of_GetSetting ( 87 , la_Value ) = 1 THEN
	lnv_String.of_ParseToArray ( String ( la_Value ) , "," , lsa_Result ) 
END IF

ll_Count = UpperBound ( lsa_Result )

FOR i = ll_Count TO 1 STEP -1
	
	ddlb_1.AddItem ( Trim ( lsa_Result[i] ) )
	
	
NEXT



 

end event

type mle_note from multilineedit within w_eventnotewizard
int X=59
int Y=976
int Width=919
int Height=284
int TabOrder=60
boolean BringToTop=true
TextCase TextCase=Upper!
BorderStyle BorderStyle=StyleLowered!
int Accelerator=114
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_eventnotewizard
int X=82
int Y=236
int Width=887
int Height=76
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;inv_EventNote.of_SetBillWho ( THIS.Text )
inv_EventNote.of_BuildNote ( )
mle_note.text = inv_EventNote.of_GetNote ( )
end event

type st_3 from statictext within w_eventnotewizard
int X=82
int Y=172
int Width=151
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text="&Who"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

