$PBExportHeader$w_alertlist.srw
forward
global type w_alertlist from w_popup
end type
type cb_save from commandbutton within w_alertlist
end type
type st_1 from statictext within w_alertlist
end type
type cb_1 from commandbutton within w_alertlist
end type
type dw_1 from u_dw_alertlist within w_alertlist
end type
type cb_delete from commandbutton within w_alertlist
end type
end forward

global type w_alertlist from w_popup
integer width = 3543
integer height = 1892
string title = "User Alerts"
boolean minbox = false
boolean maxbox = false
long backcolor = 12632256
cb_save cb_save
st_1 st_1
cb_1 cb_1
dw_1 dw_1
cb_delete cb_delete
end type
global w_alertlist w_alertlist

on w_alertlist.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_delete
end on

on w_alertlist.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_delete)
end on

event open;call super::open;THIS.of_SetBase( TRUE )
inv_Base.of_center( )
THIS.of_Setresize( TRUE )
inv_Resize.of_Register( dw_1 ,inv_resize.scalerightbottom )
inv_Resize.of_Register( cb_1 ,inv_resize.fixedbottom )
inv_Resize.of_Register( cb_delete ,inv_resize.fixedbottom )
inv_Resize.of_Register( cb_save ,inv_resize.fixedbottom )

n_cst_Privileges lnv_Privs

cb_delete.Visible = lnv_Privs.of_HasSysadminrights( ) 



end event

event pfc_postopen;call super::pfc_postopen;dw_1.Retrieve  ( )
end event

event pfc_save;call super::pfc_save;IF ancestorReturnValue = 1 THEN
	Commit;
END IF

RETURN AncestorReturnValue
end event

type cb_save from commandbutton within w_alertlist
integer x = 1787
integer y = 1656
integer width = 379
integer height = 96
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Save"
end type

event clicked;Parent.event pfc_save( )
THIS.Enabled = FALSE
end event

type st_1 from statictext within w_alertlist
integer x = 27
integer y = 40
integer width = 1321
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "This is a list of all the alerts stored in Profit Tools."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_alertlist
integer x = 1367
integer y = 1656
integer width = 379
integer height = 96
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
boolean cancel = true
boolean default = true
end type

event clicked;Close ( Parent ) 
end event

type dw_1 from u_dw_alertlist within w_alertlist
integer x = 27
integer y = 128
integer width = 3438
integer height = 1488
integer taborder = 10
end type

event ue_itemchanged;call super::ue_itemchanged;cb_save.Enabled = TRUE
end event

type cb_delete from commandbutton within w_alertlist
integer x = 27
integer y = 1656
integer width = 617
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Delete Selected Alerts"
end type

event clicked;Long	lla_Rows[]
Long	i
Long	ll_Count
Boolean	lb_Delete = TRUE

ll_Count = dw_1.of_Getselectedrows( lla_Rows )
	
FOR i = 1 TO ll_Count
	IF dw_1.GetItemNumber( lla_Rows[i], "status" ) = 1 THEN
		EXIT
	END IF
NEXT

IF i <= ll_Count THEN
	lb_Delete = MessageBox ( "Delete Alerts" , "The rows selected to be deleted contain alerts that are still active. Do you want to continue?" , QUESTION! , YESNO! , 2 ) = 1	
END IF


IF lb_Delete THEN
	dw_1.of_Deleteselectedrows( )
END IF

cb_Save.Enabled = TRUE
end event

