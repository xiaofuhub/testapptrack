$PBExportHeader$w_invoicedate.srw
forward
global type w_invoicedate from w_response
end type
type rb_date from radiobutton within w_invoicedate
end type
type rb_shipdate from radiobutton within w_invoicedate
end type
type sle_date from u_sle_date within w_invoicedate
end type
type cb_ok from u_cbok within w_invoicedate
end type
type cb_cancel from u_cbcancel within w_invoicedate
end type
type ln_1 from line within w_invoicedate
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//date	sd_lastdate
//int	si_SelectedRB
////end modification Shared Variables by appeon  20070730
end variables

global type w_invoicedate from w_response
integer x = 1184
integer y = 992
integer width = 983
integer height = 524
string title = "Select Desired Invoice Date"
boolean controlmenu = false
long backcolor = 12632256
rb_date rb_date
rb_shipdate rb_shipdate
sle_date sle_date
cb_ok cb_ok
cb_cancel cb_cancel
ln_1 ln_1
end type
global w_invoicedate w_invoicedate

type variables
n_cst_Msg	inv_msg
//begin modification Shared Variables by appeon  20070730
date	sd_lastdate
int	si_SelectedRB
//end modification Shared Variables by appeon  20070730
end variables

on w_invoicedate.create
int iCurrent
call super::create
this.rb_date=create rb_date
this.rb_shipdate=create rb_shipdate
this.sle_date=create sle_date
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_date
this.Control[iCurrent+2]=this.rb_shipdate
this.Control[iCurrent+3]=this.sle_date
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.ln_1
end on

on w_invoicedate.destroy
call super::destroy
destroy(this.rb_date)
destroy(this.rb_shipdate)
destroy(this.sle_date)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.ln_1)
end on

event open;call super::open;n_cst_msg	lnv_Msg
S_Parm		lstr_parm
Boolean		lb_ShowShipDate = TRUE

THIS.of_setbase ( TRUE ) 
inv_Base.of_Center( )


lnv_Msg = Message.PowerobjectParm
if lnv_Msg.of_Get_Parm ( "SHOWSHIPDATE" , lstr_Parm ) <> 0 THEN
	lb_ShowShipDate = lstr_Parm.ia_Value
END IF

if ( IsNull ( sd_LastDate ) OR String( sd_LastDate , "MM/DD/YY" ) = "01/01/00" ) THEN
	sd_LastDate = Today ( )
END IF

sle_date.Text = String ( sd_LastDate )

IF si_SelectedRB = 1 THEN
	rb_ShipDate.Checked = TRUE
	rb_ShipDate.SetFocus ( )
ELSE
	rb_Date.Checked = TRUE
	sle_date.SetFocus ( )
END IF
rb_shipdate.Visible = lb_ShowShipDate

IF Not lb_ShowShipDate THEN
	rb_Date.Checked = TRUE
	rb_Date.Visible = FALSE
	sle_date.SetFocus ( )
END IF

end event

event pfc_default;inv_Msg.of_Reset ( )
S_Parm	lstr_Parm

Boolean	lb_Close = TRUE
Boolean  lb_AllowDatesPastExpiration = FALSE
Date		ld_SelectedDate

Int		li_CurrentYear
Int		li_TypedYear

IF rb_Date.Checked = True THEN
	
	IF Len ( sle_date.Text ) = 0 THEN
		MessageBox ( "Entered Date" , "Please enter a valid date." )
		lb_Close = FALSE
	ELSE

		ld_SelectedDate = sle_date.of_get_Date ( lb_AllowDatesPastExpiration )
		IF isNull ( ld_SelectedDate ) THEN
			lb_Close = FALSE	
		ELSE
			sd_LastDate =  ld_SelectedDate
		END IF
		
		IF lb_Close THEN // check the date to make sure the date the user typed in is 
							 // what they really wanted

			li_CurrentYear = Year ( Today ( ) )
			li_TypedYear = Year ( ld_SelectedDate )
							 
			IF li_TypedYear <> li_CurrentYear THEN
				CHOOSE CASE MessageBox ( "Date Entered" , "The date you have entered is not in the current year. Do you want to keep this date anyway?" , QUESTION! , YESNO!,  2 )

					CASE 1 // keep the date
						// don't do anything
						
					CASE else	// don't close
						lb_Close = FALSE
				END CHOOSE
						
			END IF		
							 
		END IF
		
	END IF
	
END IF

lstr_Parm.is_Label = "USESHIPDATE"
lstr_Parm.ia_Value = rb_ShipDate.Checked
Inv_Msg.of_add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "DATE"
lstr_Parm.ia_Value = sd_LastDate
Inv_Msg.of_add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "CONTINUE"
lstr_Parm.ia_Value = TRUE
Inv_Msg.of_add_Parm ( lstr_Parm )


	
IF lb_Close THEN
	CloseWithReturn ( THIS, inv_msg )
END IF
end event

event pfc_cancel;call super::pfc_cancel;inv_Msg.of_Reset ( )
S_Parm	lstr_Parm

lstr_Parm.is_Label = "CONTINUE"
lstr_Parm.ia_Value = FALSE
Inv_Msg.of_add_Parm ( lstr_Parm )

CloseWithReturn ( THIS, inv_msg )
end event

event close;call super::close;S_Parm	lstr_Parm

IF inv_Msg.of_Get_Count ( ) = 0 THEN
	lstr_Parm.is_Label = "CONTINUE"
	lstr_Parm.ia_Value = FALSE
	inv_msg.of_Add_Parm ( lstr_parm )
	CloseWithReturn ( THIS, inv_Msg )
END IF
end event

type cb_help from w_response`cb_help within w_invoicedate
end type

type rb_date from radiobutton within w_invoicedate
integer x = 114
integer y = 48
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Custom"
end type

event getfocus;si_SelectedRB = 2
THIS.Checked = TRUE
sle_Date.Post SetFocus ( )

end event

type rb_shipdate from radiobutton within w_invoicedate
integer x = 114
integer y = 148
integer width = 658
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Use &shipment date"
end type

event getfocus;si_SelectedRB = 1
end event

type sle_date from u_sle_date within w_invoicedate
integer x = 421
integer y = 48
integer width = 311
integer taborder = 30
boolean bringtotop = true
end type

event constructor;This.of_suspend_list_add ( cb_cancel )
this.text = String ( today ( ) )
end event

event modified;call super::modified;rb_date.checked = true
si_SelectedRB = 2
end event

type cb_ok from u_cbok within w_invoicedate
integer x = 224
integer y = 312
integer width = 233
integer taborder = 10
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
end type

type cb_cancel from u_cbcancel within w_invoicedate
integer x = 512
integer y = 312
integer width = 233
integer taborder = 20
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
end type

type ln_1 from line within w_invoicedate
integer linethickness = 4
integer beginx = 55
integer beginy = 260
integer endx = 910
integer endy = 260
end type

