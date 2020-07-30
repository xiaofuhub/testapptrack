$PBExportHeader$w_amountowedsplit.srw
forward
global type w_amountowedsplit from w_response
end type
type st_1 from statictext within w_amountowedsplit
end type
type st_2 from statictext within w_amountowedsplit
end type
type cb_1 from u_cbok within w_amountowedsplit
end type
type cb_2 from u_cbcancel within w_amountowedsplit
end type
type dw_1 from u_dw within w_amountowedsplit
end type
end forward

global type w_amountowedsplit from w_response
int X=1042
int Y=964
int Width=1390
int Height=568
boolean TitleBar=true
string Title="Split Transaction Amount"
long BackColor=12632256
st_1 st_1
st_2 st_2
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_amountowedsplit w_amountowedsplit

on w_amountowedsplit.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_1
end on

on w_amountowedsplit.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event pfc_default;n_cst_msg	lnv_msg
S_Parm 		lstr_Parm
SetPointer ( HOURGLASS! )

lstr_Parm.is_Label = "AMOUNT"
lstr_Parm.ia_Value = dw_1.object.amountowed_amount[1]
lnv_Msg.of_Add_Parm (lstr_Parm )

CloseWithReturn ( THIS , lnv_Msg )

end event

event open;call super::open;integer		li_MsgCount, &
				li_ndx
long			ll_row
decimal		lc_amount
n_cst_msg	lnv_msg
s_parm		lstr_parm
lnv_Msg = message.powerobjectparm

if isvalid(lnv_Msg) then
	li_MsgCount = 	lnv_msg.of_get_count()
	FOR li_Ndx = 1 to li_MsgCount
		lnv_msg.of_get_parm(li_ndx, lstr_parm)
		
		CHOOSE CASE upper(lstr_parm.is_label)
					
			CASE "AMOUNT"
				lc_amount = dec(lstr_Parm.ia_Value)
				
		END CHOOSE
	NEXT
end if
ib_disableclosequery=true
ll_row = dw_1.insertrow(0)
dw_1.object.amountowed_amount[ll_row] = lc_amount
dw_1.post setfocus()


end event

event pfc_cancel;call super::pfc_cancel;n_cst_msg	lnv_msg
S_Parm 		lstr_Parm
SetPointer ( HOURGLASS! )

lstr_Parm.is_Label = "CANCEL"
lnv_Msg.of_Add_Parm (lstr_Parm )

CloseWithReturn ( THIS , lnv_Msg )

end event

type st_1 from statictext within w_amountowedsplit
int X=96
int Y=40
int Width=763
int Height=84
boolean Enabled=false
boolean BringToTop=true
string Text="What should the amount be ?"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_amountowedsplit
int X=96
int Y=152
int Width=1266
int Height=144
boolean Enabled=false
boolean BringToTop=true
string Text="An unnassigned amount will be created for the remaining balance."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from u_cbok within w_amountowedsplit
int X=434
int Y=348
int TabOrder=20
boolean BringToTop=true
end type

type cb_2 from u_cbcancel within w_amountowedsplit
int X=731
int Y=348
int TabOrder=30
boolean BringToTop=true
end type

type dw_1 from u_dw within w_amountowedsplit
int X=855
int Y=12
int Width=448
int Height=120
int TabOrder=10
string DataObject="d_amountowedsplit"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event getfocus;call super::getfocus;long	ll_length, &
		ll_row

decimal	lc_amount

ll_row = this.getrow()

if ll_row > 0 then
	lc_amount = this.object.amountowed_amount[ll_row]
	ll_length = len(string(lc_amount,'[general];[red][general];0.00;0.00'))
else
	ll_length = 4
end if

if ll_length > 0 then
	This.Post selecttext(1, ll_length)
end if
end event

event constructor;n_cst_presentation_amountowed	lnv_presentation

lnv_presentation.of_SetPresentation(this)
end event

