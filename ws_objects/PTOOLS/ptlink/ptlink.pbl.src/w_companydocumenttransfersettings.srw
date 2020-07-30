$PBExportHeader$w_companydocumenttransfersettings.srw
forward
global type w_companydocumenttransfersettings from w_response
end type
type cb_1 from commandbutton within w_companydocumenttransfersettings
end type
type tab_transfer from u_tab_documenttransfer within w_companydocumenttransfersettings
end type
type tab_transfer from u_tab_documenttransfer within w_companydocumenttransfersettings
end type
type cb_save from commandbutton within w_companydocumenttransfersettings
end type
end forward

global type w_companydocumenttransfersettings from w_response
integer width = 2834
integer height = 1188
string title = "Document Transfer Settings"
long backcolor = 12632256
cb_1 cb_1
tab_transfer tab_transfer
cb_save cb_save
end type
global w_companydocumenttransfersettings w_companydocumenttransfersettings

type variables
Long	il_CoID
Boolean	ib_AskAboutApply
end variables

on w_companydocumenttransfersettings.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.tab_transfer=create tab_transfer
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.tab_transfer
this.Control[iCurrent+3]=this.cb_save
end on

on w_companydocumenttransfersettings.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.tab_transfer)
destroy(this.cb_save)
end on

event open;call super::open;
il_CoID = Message.DoubleParm

IF il_CoID > 0 THEN
	tab_transfer.of_Retrieve( il_CoID )
END IF
end event

event pfc_postupdate;call super::pfc_postupdate;IF ib_askaboutapply THEN
	IF MessageBox("Apply Changes" , "Do you want to generate transfer requests for the document mappings?" , QUESTION! , YESNO! , 1 ) = 1 THEN


		n_cst_bso_document_manager	lnv_DocMan
		lnv_DocMan = CREATE n_cst_bso_document_manager
		
		lnv_DocMan.of_Addtransferrequestforcurrentshipments( il_coid )
		
		lnv_DocMan.event pt_save( )
		
		DESTROY ( lnv_DocMan )
	END IF
END IF

RETURN 1
end event

event pfc_preupdate;call super::pfc_preupdate;ib_askaboutapply = tab_transfer.of_Werechangesmadetomapping( ) 
RETURN AncestorReturnValue
end event

type cb_help from w_response`cb_help within w_companydocumenttransfersettings
end type

type cb_1 from commandbutton within w_companydocumenttransfersettings
integer x = 997
integer y = 928
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;Parent.event pfc_close( )
end event

type tab_transfer from u_tab_documenttransfer within w_companydocumenttransfersettings
integer x = 9
integer width = 2789
integer taborder = 11
boolean bringtotop = true
end type

event ue_itemchanged;call super::ue_itemchanged;cb_save.Enabled = TRUE
end event

type cb_save from commandbutton within w_companydocumenttransfersettings
integer x = 1417
integer y = 928
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Save"
end type

event clicked;Parent.event pfc_save( )
THIS.Enabled = FALSE
end event

