$PBExportHeader$w_licensestatus.srw
forward
global type w_licensestatus from w_response
end type
type dw_summary from u_dw within w_licensestatus
end type
type dw_status from u_dw within w_licensestatus
end type
type rb_mystatus from radiobutton within w_licensestatus
end type
type rb_all from radiobutton within w_licensestatus
end type
type st_1 from statictext within w_licensestatus
end type
type st_2 from statictext within w_licensestatus
end type
type cb_1 from u_cbok within w_licensestatus
end type
type cb_2 from u_cbcancel within w_licensestatus
end type
type st_3 from statictext within w_licensestatus
end type
type uo_ops from u_cst_operations within w_licensestatus
end type
end forward

global type w_licensestatus from w_response
integer x = 901
integer y = 416
integer width = 1865
integer height = 2248
string title = "Modules in Use"
dw_summary dw_summary
dw_status dw_status
rb_mystatus rb_mystatus
rb_all rb_all
st_1 st_1
st_2 st_2
cb_1 cb_1
cb_2 cb_2
st_3 st_3
uo_ops uo_ops
end type
global w_licensestatus w_licensestatus

type variables

String	is_UserID
end variables

on w_licensestatus.create
int iCurrent
call super::create
this.dw_summary=create dw_summary
this.dw_status=create dw_status
this.rb_mystatus=create rb_mystatus
this.rb_all=create rb_all
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_3=create st_3
this.uo_ops=create uo_ops
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_summary
this.Control[iCurrent+2]=this.dw_status
this.Control[iCurrent+3]=this.rb_mystatus
this.Control[iCurrent+4]=this.rb_all
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.uo_ops
end on

on w_licensestatus.destroy
call super::destroy
destroy(this.dw_summary)
destroy(this.dw_status)
destroy(this.rb_mystatus)
destroy(this.rb_all)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_3)
destroy(this.uo_ops)
end on

event open;call super::open;
Long	ll_OpsCount
is_UserID = gnv_App.of_getuserID ( )

dw_summary.settransobject(sqlca)
dw_summary.Retrieve ()

dw_status.settransobject(sqlca)
dw_status.Retrieve ()

ll_OpsCount = uo_Ops.of_Retrieve()
commit;

uo_Ops.of_DiscardRemoteConnections()
uo_Ops.of_LoadIdleTimes( )
uo_Ops.of_LoadAppInfo( )
uo_Ops.of_Initialize()


dw_Status.SetFilter ("userid = '" + is_UserID + "'" )
dw_Status.Filter ( )
dw_Status.Sort ( )

This.of_SetUpdateObjects ( { dw_Status } )
end event

event pfc_cancel;call super::pfc_cancel;
Close ( THIS ) 
end event

event pfc_default;Close ( THIS ) 
end event

event pfc_save;call super::pfc_save;IF AncestorReturnValue = 1 THEN
	COMMIT ;
END IF

RETURN AncestorReturnValue
end event

type cb_help from w_response`cb_help within w_licensestatus
boolean visible = false
end type

type dw_summary from u_dw within w_licensestatus
integer x = 18
integer y = 108
integer width = 1792
integer height = 468
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_modulelicenses"
end type

event constructor;This.of_SetAutoSort ( TRUE )
This.SetSort ( "Module A" )
ib_rmbMenu = FALSE
end event

event doubleclicked;String	ls_Module

IF Row > 0 THEN

	ls_Module = This.Object.Module [ Row ]

	dw_Status.SetFilter ("Module = '" + ls_Module + "'" )
	dw_Status.Filter ( )
	dw_Status.Sort ( )
	dw_Status.SetFocus ( )

END IF
end event

type dw_status from u_dw within w_licensestatus
event dwnkey pbm_dwnkey
integer x = 18
integer y = 800
integer width = 1797
integer height = 468
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_modulestatus"
end type

event dwnkey;IF KeyDown ( KeyDelete! ) AND This.GetSelectedRow ( 0 ) > 0 THEN

	This.Event pfc_DeleteRow ( )

END IF
end event

event constructor;This.of_SetAutoSort ( TRUE )
This.of_SetRowSelect ( TRUE ) 
This.of_setinsertable ( false )
end event

event doubleclicked;IF row > 0 THEN
	EVENT	pfc_DeleteRow ( )
END IF
end event

event pfc_predeleterow;call super::pfc_predeleterow;Int	li_Return
String	ls_Module
String	ls_UserId
long		ll_Row
long		ll_FoundRow
Int		li_CurrentCount

n_cst_Privileges	lnv_Privs

li_Return = AncestorReturnValue

IF li_Return = 1 THEN
	ll_Row = THIS.GetSelectedRow (0)
	ls_UserID = THIS.GetItemString( ll_Row , "userid" )
	IF Upper (ls_UserID) <> Upper (is_UserID) THEN
		IF lnv_Privs.of_HasAdministrativeRights ( ) THEN
			// NOTHING
		ELSE
			li_Return = 0 // prevent delete
			MessageBox ( "Release Lock" , "You are not authorized to release other users' locks.")
		END IF
	END IF
END IF


IF li_Return = 1 THEN // success
	///ll_Row = THIS.GetSelectedRow (0)
	IF ll_Row > 0 THEN
		ls_Module = THIS.GetItemString( ll_Row , "module" )
		
		ll_FoundRow = dw_summary.Find ( "module = '" + ls_module +"'", 0, dw_summary.RowCount() + 1 )
		li_CurrentCount = dw_summary.GetItemNumber ( ll_FoundRow , "inuse" )
		IF NOT li_CurrentCount - 1 < 0 THEN
			dw_summary.SetItem( ll_FoundRow , "inuse", li_CurrentCount - 1 )
		END IF			
		
	END IF
END IF


RETURN li_Return
end event

event pfc_deleterow;call super::pfc_deleterow;//Extending Ancestor, to make up for PFC deficiency.
//(If you delete a selected row, it usually doesn't reselect one.)

IF This.GetRow ( ) > 0 AND This.GetSelectedRow ( 0 ) = 0 THEN
	This.SelectRow ( This.GetRow ( ), TRUE )
END IF

RETURN AncestorReturnValue
end event

type rb_mystatus from radiobutton within w_licensestatus
integer x = 206
integer y = 712
integer width = 384
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&My Locks"
boolean checked = true
end type

event clicked;IF This.checked = TRUE THEN
	dw_Status.SetFilter ("userid = '" + is_UserID + "'" )
	dw_Status.Filter ( )
	dw_Status.Sort ( )
	dw_Status.SetFocus ( )
END IF
end event

type rb_all from radiobutton within w_licensestatus
integer x = 581
integer y = 712
integer width = 585
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Everyone~'s Locks"
end type

event clicked;IF This.checked = TRUE THEN
	dw_Status.SetFilter ("" )
	dw_Status.Filter ( )
	dw_Status.Sort ( )
	dw_Status.SetFocus ( )
END IF
end event

type st_1 from statictext within w_licensestatus
integer x = 18
integer y = 624
integer width = 1810
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Modules in Use (Double Click or hit ~"Delete~" to Release Lock)"
boolean focusrectangle = false
end type

type st_2 from statictext within w_licensestatus
integer x = 18
integer y = 24
integer width = 549
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Module Summary"
boolean focusrectangle = false
end type

type cb_1 from u_cbok within w_licensestatus
integer x = 658
integer y = 2028
integer width = 233
integer taborder = 20
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_licensestatus
integer x = 942
integer y = 2028
integer width = 233
integer taborder = 30
boolean bringtotop = true
end type

type st_3 from statictext within w_licensestatus
integer x = 18
integer y = 708
integer width = 178
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Show:"
boolean focusrectangle = false
end type

type uo_ops from u_cst_operations within w_licensestatus
integer x = 5
integer y = 1324
integer width = 1833
integer height = 672
integer taborder = 20
boolean bringtotop = true
end type

on uo_ops.destroy
call u_cst_operations::destroy
end on

