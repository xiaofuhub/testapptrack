$PBExportHeader$w_itintemplatesetup.srw
forward
global type w_itintemplatesetup from w_response
end type
type uo_1 from u_cst_itinerarytemplates within w_itintemplatesetup
end type
type cb_save from commandbutton within w_itintemplatesetup
end type
type cb_close from commandbutton within w_itintemplatesetup
end type
end forward

global type w_itintemplatesetup from w_response
integer width = 1678
integer height = 1560
string title = "Itinerary Template Setup"
long backcolor = 12632256
uo_1 uo_1
cb_save cb_save
cb_close cb_close
end type
global w_itintemplatesetup w_itintemplatesetup

on w_itintemplatesetup.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.cb_save=create cb_save
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_close
end on

on w_itintemplatesetup.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.cb_save)
destroy(this.cb_close)
end on

event open;call super::open;n_cst_Privileges		lnv_PrivManager

// Center window
This.of_SetBase(TRUE) 
This.inv_Base.Of_Center()

uo_1.of_Retrieve()

IF NOT lnv_PrivManager.of_HasSysAdminRights( ) THEN
	MessageBox("Itinerary Templates", "Only the Profit Tools administrator (PTADMIN) can edit itinerary templates.")
	CLOSE(THIS)
END IF
end event

event pfc_postupdate;call super::pfc_postupdate;Integer	li_Return

li_Return = AncestorReturnValue

IF li_Return = 1 THEN
	cb_Save.Enabled = False
END IF

Return li_Return
end event

type cb_help from w_response`cb_help within w_itintemplatesetup
boolean visible = false
end type

type uo_1 from u_cst_itinerarytemplates within w_itintemplatesetup
integer x = 37
integer y = 32
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call u_cst_itinerarytemplates::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;Parent.cb_save.Enabled = True
end event

event ue_pendingupdate;call super::ue_pendingupdate;Parent.cb_Save.Enabled = True
end event

type cb_save from commandbutton within w_itintemplatesetup
integer x = 398
integer y = 1320
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Save"
end type

event clicked;Parent.Event pfc_Save()
end event

type cb_close from commandbutton within w_itintemplatesetup
integer x = 864
integer y = 1320
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

