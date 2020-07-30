$PBExportHeader$w_response.srw
$PBExportComments$Extension Response Window class
forward
global type w_response from pfc_w_response
end type
type cb_help from commandbutton within w_response
end type
end forward

global type w_response from pfc_w_response
cb_help cb_help
end type
global w_response w_response

on w_response.create
int iCurrent
call super::create
this.cb_help=create cb_help
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_help
end on

on w_response.destroy
call super::destroy
destroy(this.cb_help)
end on

event pfc_postopen;call super::pfc_postopen;cb_help.x = this.width - 110
cb_help.y = this.height - 170

end event

type cb_help from commandbutton within w_response
integer x = 2409
integer y = 1356
integer width = 73
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "?"
end type

event clicked;
integer	li_topic
string	ls_helpfile

n_cst_helptopic	lnv_help

lnv_help = create n_cst_helptopic

li_topic = lnv_help.of_GetTopic(parent.classname())

if li_topic > 0 then
	ls_helpfile = lnv_help.of_GetHelpFile()
	ShowHelp(ls_helpfile, Topic!, li_topic)
end if

destroy lnv_help
end event

