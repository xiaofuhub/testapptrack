$PBExportHeader$w_review_confirm.srw
$PBExportComments$[w_response] Displays a dw for review and allows user to cancel or continue
forward
global type w_review_confirm from w_response
end type
type dw_1 from u_dw within w_review_confirm
end type
type cb_ok from u_cb within w_review_confirm
end type
type st_1 from u_st within w_review_confirm
end type
type st_2 from u_st within w_review_confirm
end type
type cb_print from u_cb within w_review_confirm
end type
type cb_cancel from u_cb within w_review_confirm
end type
end forward

global type w_review_confirm from w_response
integer x = 14
integer y = 16
integer width = 3502
integer height = 2332
long backcolor = 80269524
dw_1 dw_1
cb_ok cb_ok
st_1 st_1
st_2 st_2
cb_print cb_print
cb_cancel cb_cancel
end type
global w_review_confirm w_review_confirm

forward prototypes
public function integer wf_centerbuttons ()
end prototypes

public function integer wf_centerbuttons ();
Long	 	ll_buttonCount, &
			ll_Return
Integer	li_WindowWidth	, &
			li_ObjectWidth , &
			li_Space, &
			li_xPosition 

ll_ButtonCount = 1

// Get width of visible buttons 			
If cb_ok.Visible = TRUE Then 
	ll_buttonCount ++	
	li_ObjectWidth += cb_ok.Width
End If

If cb_cancel.Visible = TRUE Then 
	ll_buttonCount ++	
	li_ObjectWidth += cb_cancel.Width
End If

If cb_print.Visible = TRUE Then 
		ll_buttonCount ++	
		li_ObjectWidth += cb_print.Width
End If

// get window width
li_WindowWidth	= this.WorkSpaceWidth ( )

// use average button width for spaceing buttons
li_Space = li_objectWidth / ll_buttonCount

li_xPosition = ( this.WorkSpaceWidth ( ) / ll_buttonCount) - (li_Space / 2)
ll_ButtonCount = 1
If cb_ok.Visible = TRUE Then 
	cb_ok.Move ( li_xPosition * ll_ButtonCount , 2124)
	ll_ButtonCount ++
End If	

If cb_cancel.Visible = TRUE Then 
	cb_cancel.Move ( li_xPosition * ll_ButtonCount , 2124)
	ll_ButtonCount ++
End If

If cb_print.Visible = TRUE Then 
	cb_print.Move ( li_xPosition * ll_ButtonCount , 2124)
	ll_ButtonCount ++
End If

Return ll_Return
end function

event open;call super::open;// RDT 7-10-03 Make window BIGGER and resize objects

String 	ls_Message1, &
			ls_Message2, &
			ls_Title

Blob		lblob_dw

// create objects
n_cst_msg	lnv_msg
s_parm		lstr_Parm

// get parms
lnv_msg = message.powerobjectparm

IF isValid ( lnv_msg ) THEN
	If lnv_Msg.of_Get_Parm ( "dw" , lstr_Parm ) <> 0 THEN
		lblob_dw = lstr_Parm.ia_Value
		// setup 
		dw_1.SetFullState( lblob_dw )
	End If

	If lnv_Msg.of_Get_Parm ( "message1" , lstr_Parm ) <> 0 THEN
		ls_message1 = lstr_Parm.ia_Value
	End If

	If lnv_Msg.of_Get_Parm ( "message2" , lstr_Parm ) <> 0 THEN
		ls_message2 = lstr_Parm.ia_Value
	End If

	If lnv_Msg.of_Get_Parm ( "title" , lstr_Parm ) <> 0 THEN
		ls_Title = lstr_Parm.ia_Value
	End If

	If lnv_Msg.of_Get_Parm ( "cb_cancel" , lstr_Parm ) <> 0 THEN
		if Upper( String(lstr_Parm.ia_Value) ) = "FALSE" then 
			cb_cancel.visible = FALSE
		end if
	End If

END IF

If Len( Trim( ls_Message1 ) ) > 0 Then 
	st_1.Text = ls_Message1
End If
If Len( Trim( ls_Message2 ) ) > 0 Then 
	st_2.Text = ls_Message2
End If

If Len( Trim( ls_Title ) ) > 0 Then 
	This.Title = ls_Title
End If

This.wf_CenterButtons()

ib_disableclosequery = TRUE							// No Updates allowed in this window. 

// set sort service on datawindow
dw_1.of_SetSort(TRUE)
dw_1.inv_sort.of_SetStyle(0)
dw_1.inv_sort.of_SetColumnHeader(TRUE)

// RDT 7-10-03 - Start 
of_SetResize(TRUE)
inv_Resize.of_Register( dw_1 , "Scale")
inv_Resize.of_Register( st_1 , "Scale")
inv_Resize.of_Register( st_2 , "Scale")

inv_Resize.of_Register( cb_cancel , inv_Resize.fixedbottom )
inv_Resize.of_Register( cb_ok , 		inv_Resize.fixedbottom )
inv_Resize.of_Register( cb_print ,  inv_Resize.fixedbottom )


// FixedToBottom&ScaleToRight = wide & at bottom 

This.Width  = ( gnv_app.of_Getframe().width - 500  ) 
This.Height = ( gnv_app.of_Getframe().height - 800 ) 

//gnv_app.of_getrestrictedview( )


THIS.of_SetBase ( TRUE ) 

IF isValid ( inv_Base ) THEN
	inv_Base.of_Center ( )
END IF

// RDT 7-10-03 - End 



Dec	ld_Offset
Dec 	lc_halfWay

lc_halfWay = THIS.Width / 2
cb_ok.x = lc_halfWay - ( ( cb_print.Width / 2 ) + cb_OK.Width + 100 )
cb_print.x = lc_halfWay - cb_print.Width / 2 
cb_cancel.x = lc_halfWay + ( ( cb_print.Width / 2 ) + 100 )

//ld_Offset = THIS.Width / 4
//cb_ok.x = ld_Offset
//cb_print.x = ld_Offset * 2
//cb_cancel.x = ld_Offset * 3






end event

on w_review_confirm.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.st_1=create st_1
this.st_2=create st_2
this.cb_print=create cb_print
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.cb_cancel
end on

on w_review_confirm.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_print)
destroy(this.cb_cancel)
end on

type dw_1 from u_dw within w_review_confirm
integer x = 18
integer y = 228
integer width = 3442
integer height = 1800
integer taborder = 40
boolean bringtotop = true
boolean hscrollbar = true
end type

event constructor;ib_rmbMenu = FALSE

end event

type cb_ok from u_cb within w_review_confirm
integer x = 846
integer y = 2132
integer taborder = 10
boolean bringtotop = true
string text = "&OK"
boolean default = true
end type

event clicked;CloseWithReturn(Parent, "OK")
end event

type st_1 from u_st within w_review_confirm
integer x = 27
integer y = 32
integer width = 3442
integer height = 88
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string text = ""
alignment alignment = center!
end type

type st_2 from u_st within w_review_confirm
integer x = 27
integer y = 128
integer width = 3442
integer height = 88
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string text = ""
alignment alignment = center!
end type

type cb_print from u_cb within w_review_confirm
integer x = 1582
integer y = 2132
integer taborder = 20
boolean bringtotop = true
string text = "&Print"
end type

event clicked;n_cst_PrintSrvc lnv_PrintSrvc
lnv_PrintSrvc = CREATE n_cst_PrintSrvc

lnv_PrintSrvc.of_Print(dw_1)

DESTROY(lnv_PrintSrvc)


/*
If PrintSetup ( ) = 1 then 
	dw_1.Print()
End if
*/
end event

type cb_cancel from u_cb within w_review_confirm
integer x = 2318
integer y = 2132
integer taborder = 30
boolean bringtotop = true
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,"CANCEL")
end event

