$PBExportHeader$w_edishipmentreview.srw
forward
global type w_edishipmentreview from w_sheet
end type
type st_1 from statictext within w_edishipmentreview
end type
type dw_reason from u_dw_edistatus_dddw within w_edishipmentreview
end type
type cb_acceptselected from commandbutton within w_edishipmentreview
end type
type cb_acceptall from commandbutton within w_edishipmentreview
end type
type cb_declineall from commandbutton within w_edishipmentreview
end type
type cb_refresh from commandbutton within w_edishipmentreview
end type
type cb_apply from commandbutton within w_edishipmentreview
end type
type cb_declineselected from commandbutton within w_edishipmentreview
end type
type dw_shipmentlist from u_dw_edishipmentreview within w_edishipmentreview
end type
type gb_1 from groupbox within w_edishipmentreview
end type
type gb_2 from groupbox within w_edishipmentreview
end type
type gb_3 from groupbox within w_edishipmentreview
end type
end forward

global type w_edishipmentreview from w_sheet
integer width = 3625
integer height = 1136
string title = "Review EDI shipments to Accept or Decline"
string menuname = "m_sheets"
long backcolor = 12632256
st_1 st_1
dw_reason dw_reason
cb_acceptselected cb_acceptselected
cb_acceptall cb_acceptall
cb_declineall cb_declineall
cb_refresh cb_refresh
cb_apply cb_apply
cb_declineselected cb_declineselected
dw_shipmentlist dw_shipmentlist
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_edishipmentreview w_edishipmentreview

type variables
n_cst_edishipmentreview		inv_Review

end variables

forward prototypes
public function integer wf_acceptselected ()
public function integer wf_declineselected ()
end prototypes

public function integer wf_acceptselected ();Int	li_Return = -1
Long	ll_IDCount
Long	lla_SelectedIds[]

ll_IDCount = dw_shipmentlist.event ue_getselectedids( lla_SelectedIds  )
IF ll_IDCount > 0 THEN
	IF inv_Review.of_acceptshipments( lla_SelectedIds ) = 1 THEN
		li_Return = ll_IDCount
	END IF
END IF

RETURN li_Return
	
end function

public function integer wf_declineselected ();Int	li_Return = -1
Long	ll_IDCount
Long	lla_SelectedIds[]
String	ls_Reason

ls_Reason = dw_reason.of_Getstatus( )

IF Len (ls_Reason )> 0 THEN
	ll_IDCount = dw_shipmentlist.event ue_getselectedids( lla_SelectedIds  )
	IF ll_IDCount > 0 THEN
		IF inv_Review.of_Declineshipments( lla_SelectedIds ,ls_Reason ) = 1 THEN
			li_Return = ll_IDCount
		END IF
	END IF
ELSE
	MessageBox ( "Decline Shipments" , "You must provide a reason for declining the shipments." )
	dw_reason.SetFocus ( )
END IF

RETURN li_Return
	
end function

on w_edishipmentreview.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.st_1=create st_1
this.dw_reason=create dw_reason
this.cb_acceptselected=create cb_acceptselected
this.cb_acceptall=create cb_acceptall
this.cb_declineall=create cb_declineall
this.cb_refresh=create cb_refresh
this.cb_apply=create cb_apply
this.cb_declineselected=create cb_declineselected
this.dw_shipmentlist=create dw_shipmentlist
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_reason
this.Control[iCurrent+3]=this.cb_acceptselected
this.Control[iCurrent+4]=this.cb_acceptall
this.Control[iCurrent+5]=this.cb_declineall
this.Control[iCurrent+6]=this.cb_refresh
this.Control[iCurrent+7]=this.cb_apply
this.Control[iCurrent+8]=this.cb_declineselected
this.Control[iCurrent+9]=this.dw_shipmentlist
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_3
end on

on w_edishipmentreview.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_reason)
destroy(this.cb_acceptselected)
destroy(this.cb_acceptall)
destroy(this.cb_declineall)
destroy(this.cb_refresh)
destroy(this.cb_apply)
destroy(this.cb_declineselected)
destroy(this.dw_shipmentlist)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;//modified by dan 5-17-2006
n_Cst_Privileges	lnv_Privs
n_cst_msg	lnv_msg
s_parm 		lstr_parm 
Long			lla_shipIds[]
Boolean		lb_getPending = true

IF NOT lnv_Privs.of_hasentryrights( ) THEN
	Messagebox ( "Accept/Decline EDI Shipments" , "You are not authorized to perform this function." )
	CLOSE ( THIS )
	RETURN
END IF




THIS.of_SetResize( TRUE )
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_Register ( dw_shipmentlist , inv_resize.scalerightbottom )
inv_Resize.of_Register ( gb_3 , inv_resize.fixedright )
inv_Resize.of_Register ( cb_apply , inv_resize.fixedright )
inv_Resize.of_Register ( cb_refresh , inv_resize.fixedright )

inv_review = CREATE n_cst_edishipmentreview
inv_Review.of_Setshare( dw_shipmentlist )
//added by Dan to open with shipments from the remedy object rather than opening with pending values.
IF isValid( Message.PowerObjectParm	 ) THEN
	If UPPER( Message.PowerObjectParm.ClassName ( ) ) = "N_CST_MSG" Then 
		lnv_msg = Message.PowerObjectParm
		IF lnv_msg.of_get_parm( "REMEDY", lstr_parm ) > 0 THEN
			lla_shipIds = lstr_parm.ia_value
			lb_getpending = false
		END IF
	END IF
END IF
//-----------------------------------------


IF lb_getpending THEN
	inv_Review.of_Retrivepending( )
ELSE
	//added by dan
	inv_review.of_retrieveids( lla_shipIds )
	inv_review.ila_990shipid = lla_shipIds
	cb_refresh.enabled = false
	This.title+= " *******RESEND ALL*********"
	cb_acceptall.enabled = false
	cb_acceptselected.enabled = false
	cb_declineall.enabled = false
	cb_declineselected.enabled = false
END IF

THIS.of_SetUpdateobjects( {inv_review.of_GetCache ()} )

gf_Mask_Menu ( m_Sheets )




end event

event close;call super::close;DESTROY ( inv_Review )
end event

event pfc_save;call super::pfc_save;inv_review.of_Save( )
RETURN 1
end event

type st_1 from statictext within w_edishipmentreview
integer x = 1522
integer y = 80
integer width = 224
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Reason"
boolean focusrectangle = false
end type

type dw_reason from u_dw_edistatus_dddw within w_edishipmentreview
integer x = 1509
integer y = 136
integer width = 850
integer height = 88
integer taborder = 50
end type

event constructor;call super::constructor;THIS.of_Retrieve ( "V9" )
end event

type cb_acceptselected from commandbutton within w_edishipmentreview
integer x = 123
integer y = 116
integer width = 288
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = " Selected"
end type

event clicked;THIS.SetRedraw( False )
PARENT.wf_acceptselected( )
THIS.SetRedraw( TRUE )
end event

type cb_acceptall from commandbutton within w_edishipmentreview
integer x = 443
integer y = 116
integer width = 288
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "All"
end type

event clicked;dw_shipmentlist.SetRedraw ( FALSE ) 
dw_shipmentlist.SelectRow ( 0 , TRUE ) 

Parent.wf_acceptselected( )

dw_shipmentlist.SetRedraw ( TRUE ) 

end event

type cb_declineall from commandbutton within w_edishipmentreview
integer x = 1198
integer y = 116
integer width = 288
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "All"
end type

event clicked;dw_shipmentlist.SetRedraw ( FALSE ) 
dw_shipmentlist.SelectRow ( 0 , TRUE ) 

Parent.wf_DeclineSelected( )
dw_shipmentlist.SelectRow ( 0 , FALSE ) 
dw_shipmentlist.SetRedraw ( TRUE ) 

end event

type cb_refresh from commandbutton within w_edishipmentreview
integer x = 3150
integer y = 116
integer width = 334
integer height = 96
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Refresh"
end type

event clicked;
inv_Review.of_Retrivepending( )
end event

type cb_apply from commandbutton within w_edishipmentreview
integer x = 2775
integer y = 116
integer width = 334
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Apply"
end type

event clicked;inv_review.of_Save( )
inv_Review.of_Retrivepending( )
end event

type cb_declineselected from commandbutton within w_edishipmentreview
integer x = 878
integer y = 116
integer width = 288
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = " Selected"
end type

event clicked;THIS.SetRedraw( False )
Parent.wf_Declineselected( )
THIS.SetRedraw( TRUE )
end event

type dw_shipmentlist from u_dw_edishipmentreview within w_edishipmentreview
integer x = 69
integer y = 304
integer width = 3479
integer height = 604
integer taborder = 80
end type

event rbuttonup;//Override w. call to super

Long	ll_Return = 1
String	ls_Data
Long		ll_Source
String	lsa_labels[]
any		laa_values[]

s_Parm	lstr_parm
n_cst_msg	lnv_Msg
	
IF dwo.name <> "ds_id" THEN
	ll_Return = SUPER::event rbuttonup(  xpos,  ypos, row,  dwo ) 
ELSE
	
	lsa_labels [ 1 ] = "ADD_ITEM"
	laa_values [ 1 ] = "&View source"
			
	IF Row > 0 THEN
		IF f_pop_standard(lsa_labels, laa_values) = "VIEW SOURCE" THEN
			ls_Data = THIS.GetItemString ( row , "importedshipments_filecontents" )
			lstr_parm.ia_value = ls_Data
			lstr_parm.is_label = "TEXT"
			lnv_Msg.of_Add_parm( lstr_parm)
			
			lstr_parm.ia_value = "EDI 204 Data"
			lstr_parm.is_label = "TITLE"
			lnv_Msg.of_Add_parm( lstr_parm)
			
			OpenWithParm ( W_mle , lnv_Msg )
		END IF
	END IF

END IF

RETURN ll_Return
end event

type gb_1 from groupbox within w_edishipmentreview
integer x = 827
integer y = 28
integer width = 1554
integer height = 220
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "Decline"
end type

type gb_2 from groupbox within w_edishipmentreview
integer x = 69
integer y = 28
integer width = 713
integer height = 220
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12632256
string text = "Accept"
end type

type gb_3 from groupbox within w_edishipmentreview
integer x = 2729
integer y = 28
integer width = 809
integer height = 220
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12632256
end type

