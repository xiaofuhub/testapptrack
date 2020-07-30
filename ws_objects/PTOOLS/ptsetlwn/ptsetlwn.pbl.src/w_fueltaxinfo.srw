$PBExportHeader$w_fueltaxinfo.srw
forward
global type w_fueltaxinfo from w_response
end type
type cb_1 from u_cbok within w_fueltaxinfo
end type
type cb_cancel from u_cbcancel within w_fueltaxinfo
end type
type startod from u_sle within w_fueltaxinfo
end type
type endod from u_sle within w_fueltaxinfo
end type
type cutoff from u_sle within w_fueltaxinfo
end type
type st_2 from statictext within w_fueltaxinfo
end type
type st_3 from statictext within w_fueltaxinfo
end type
type st_4 from statictext within w_fueltaxinfo
end type
type st_6 from statictext within w_fueltaxinfo
end type
type st_7 from statictext within w_fueltaxinfo
end type
end forward

global type w_fueltaxinfo from w_response
int X=1134
int Y=628
int Width=1143
int Height=632
boolean TitleBar=true
string Title="Fuel Tax Information"
cb_1 cb_1
cb_cancel cb_cancel
startod startod
endod endod
cutoff cutoff
st_2 st_2
st_3 st_3
st_4 st_4
st_6 st_6
st_7 st_7
end type
global w_fueltaxinfo w_fueltaxinfo

type variables
Private:
n_cst_msg  inv_Msg
end variables

on w_fueltaxinfo.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_cancel=create cb_cancel
this.startod=create startod
this.endod=create endod
this.cutoff=create cutoff
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_6=create st_6
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.startod
this.Control[iCurrent+4]=this.endod
this.Control[iCurrent+5]=this.cutoff
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.st_7
end on

on w_fueltaxinfo.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_cancel)
destroy(this.startod)
destroy(this.endod)
destroy(this.cutoff)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.st_7)
end on

event pfc_default;
s_parm lstr_Parm
string ls_Message
boolean	lb_Procede = TRUE
Dec{1} 	ldec_Temp

lstr_Parm.is_Label = "CutOff"
lstr_Parm.ia_Value = long(THIS.CutOff.Text)
if (lstr_Parm.ia_Value) > 0 AND isNumber(cutOff.text) THEN
	inv_msg.of_add_Parm(lstr_Parm)
ELSE
	ls_Message = "Please enter a valid percentage."
	lb_Procede = False
	CutOff.setFocus()
END IF

lstr_Parm.is_Label = "EndOD"
ldec_Temp = dec(THIS.EndOD.Text)
lstr_Parm.ia_Value = ldec_Temp
if lstr_Parm.ia_Value >= 0 AND isNumber(EndOD.text) AND dec(THIS.EndOD.Text) >= dec(THIS.StartOD.Text)THEN	
	inv_msg.of_add_Parm(lstr_Parm)
Else
	ls_Message = "Please enter a valid ending odometer reading."
	lb_Procede = False
	EndOD.setFocus()
END IF

lstr_Parm.is_Label = "StartOD"
ldec_Temp = dec(THIS.StartOD.Text)
lstr_Parm.ia_Value = ldec_Temp
if lstr_Parm.ia_Value >= 0 AND isNumber(startOD.text) THEN
	inv_msg.of_add_Parm(lstr_Parm)
ELSE
	ls_Message = "Please enter a valid begining odometer reading."
	lb_Procede = False
	StartOD.setFocus()
END IF



//lstr_Parm.is_Label = "EndDate"
//lstr_Parm.ia_Value = THIS.EndDate.of_Get_Date()
//
//if len(string(lstr_Parm.ia_Value)) > 0 AND isDate(EndDate.Text) AND (Date(EndDate.Text) >= Date(startDate.text))THEN
//	inv_msg.of_add_Parm(lstr_Parm)
//ElseIF Not (EndDate.Text >= startDate.text) THEN
//	ls_Message = "Please enter an ending date greater than or equal to starting date."
//	lb_Procede = False
//	EndDate.setFocus()
//ELSE
//	ls_Message = "Please enter a valid end date."
//	lb_Procede = False
//	EndDate.setFocus()
//END IF	

//lstr_Parm.is_Label = "StartDate"
//lstr_Parm.ia_Value = THIS.StartDate.of_Get_Date()
//if len(string(lstr_Parm.ia_Value)) > 0 And IsDate(startDate.text)  THEN
//	inv_msg.of_add_Parm(lstr_Parm)
//Else
//	ls_Message = "Please enter a valid start date"
//	lb_Procede = False
//	startDate.setFocus()
//END IF	
//
IF Not lb_Procede THEN
	MessageBox("Processing Fuel Tax Information", ls_message)
	inv_msg.of_Reset()
ELSE
	lstr_Parm.is_Label = "success"
	lstr_Parm.ia_Value = 1
	inv_msg.of_add_Parm(lstr_Parm)
	
	CloseWithReturn(This,inv_msg)
END IF
end event

event closequery;call super::closequery;s_parm	lstr_parm

IF inv_Msg.of_Get_Count ( ) = 0 THEN
	lstr_Parm.is_Label = "success"
	lstr_Parm.ia_Value = -1
	inv_msg.of_Add_Parm(lstr_Parm)
END IF

Message.PowerObjectParm = inv_msg
  
end event

event pfc_cancel;call super::pfc_cancel;ib_DisableCloseQuery = FALSE  //Ancestor sets it to true
close(this)
end event

type cb_1 from u_cbok within w_fueltaxinfo
int X=251
int Y=408
int TabOrder=40
boolean BringToTop=true
end type

type cb_cancel from u_cbcancel within w_fueltaxinfo
int X=603
int Y=408
int TabOrder=50
boolean BringToTop=true
end type

type startod from u_sle within w_fueltaxinfo
int X=73
int Y=92
int TabOrder=10
boolean BringToTop=true
end type

type endod from u_sle within w_fueltaxinfo
int X=608
int Y=92
int TabOrder=20
boolean BringToTop=true
end type

type cutoff from u_sle within w_fueltaxinfo
int X=786
int Y=256
int Width=155
int Height=72
int TabOrder=30
boolean BringToTop=true
end type

type st_2 from statictext within w_fueltaxinfo
int X=73
int Y=28
int Width=498
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="Begining Odometer"
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

type st_3 from statictext within w_fueltaxinfo
int X=608
int Y=28
int Width=453
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="Ending Odometer"
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

type st_4 from statictext within w_fueltaxinfo
int X=73
int Y=200
int Width=974
int Height=48
boolean Enabled=false
boolean BringToTop=true
string Text="Warn me if calculated and odometer mileage"
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

type st_6 from statictext within w_fueltaxinfo
int X=73
int Y=260
int Width=718
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="mileage differ by more than"
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

type st_7 from statictext within w_fueltaxinfo
int X=951
int Y=260
int Width=55
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text="%"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

