$PBExportHeader$w_add_vios.srw
$PBExportComments$PTLOG
forward
global type w_add_vios from Window
end type
type mle_desc from multilineedit within w_add_vios
end type
type cb_cancel from commandbutton within w_add_vios
end type
type cb_add from commandbutton within w_add_vios
end type
type st_cover from statictext within w_add_vios
end type
type ddlb_type from dropdownlistbox within w_add_vios
end type
end forward

global type w_add_vios from Window
int X=833
int Y=361
int Width=1075
int Height=657
boolean TitleBar=true
string Title="Add Violation"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
mle_desc mle_desc
cb_cancel cb_cancel
cb_add cb_add
st_cover st_cover
ddlb_type ddlb_type
end type
global w_add_vios w_add_vios

type variables
protected:
integer vtype
boolean forced_closing
end variables

on w_add_vios.create
this.mle_desc=create mle_desc
this.cb_cancel=create cb_cancel
this.cb_add=create cb_add
this.st_cover=create st_cover
this.ddlb_type=create ddlb_type
this.Control[]={ this.mle_desc,&
this.cb_cancel,&
this.cb_add,&
this.st_cover,&
this.ddlb_type}
end on

on w_add_vios.destroy
destroy(this.mle_desc)
destroy(this.cb_cancel)
destroy(this.cb_add)
destroy(this.st_cover)
destroy(this.ddlb_type)
end on

event open;setnull(vtype)

ddlb_type.selectitem(0)
forced_closing = false


end event

event closequery;if forced_closing = true then return 0

if len(trim(mle_desc.text)) > 0 then
	choose case messagebox("Add Violation", "Add this violation before returning to "+&
		"log entry?", question!, yesnocancel!)
	case 1
		cb_add.event post clicked()
		return 1
	case 3
		return 1
	end choose
end if



end event

type mle_desc from multilineedit within w_add_vios
int X=19
int Y=125
int Width=1006
int Height=301
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;string checkstr
integer posret

checkstr = trim(this.text)


posret = pos(checkstr, "~r~n", 1)
if posret > 0 then 
	do 
		checkstr = replace(checkstr, posret, 2, " ")
		posret = pos(checkstr, "~r~n", posret)
	loop until posret = 0	
end if

this.text = trim(checkstr)




end event

type cb_cancel from commandbutton within w_add_vios
int X=549
int Y=453
int Width=247
int Height=89
int TabOrder=40
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;forced_closing = true
close(parent)
end event

type cb_add from commandbutton within w_add_vios
int X=243
int Y=453
int Width=247
int Height=89
int TabOrder=30
string Text="Add"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if len(trim(mle_desc.text)) = 0 or isnull(vtype) then 
	if isnull(vtype) then
		messagebox("Add Violation", "All added violations must have a type.  Please " +&
		"choose a type.")
		ddlb_type.setfocus()
	else
		messagebox("Add Violation", "All added violations must have a description.  Please " +&
		"enter a description.")
		mle_desc.setfocus()
	end if
	return
end if
forced_closing = true
closewithreturn(parent, string(vtype) + "x" + mle_desc.text)


end event

type st_cover from statictext within w_add_vios
event keydown pbm_keydown
int X=28
int Y=29
int Width=910
int Height=69
int TabOrder=10
string Text="Violation Type"
Alignment Alignment=Center!
long TextColor=128
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event keydown;if keydown(keyspacebar!) or keydown(keydownarrow!) or keydown(keyuparrow!) then
	send(handle(ddlb_type), 1039, 1, 0)
	if not keydown(keyspacebar!) then ddlb_type.setfocus()
end if
end event

event clicked;Send(Handle(ddlb_type), 1039, 1, 0)
ddlb_type.setfocus()
end event

type ddlb_type from dropdownlistbox within w_add_vios
event cbncloseup pbm_cbncloseup
event keydown pbm_keydown
int X=19
int Y=21
int Width=1006
int Height=841
BorderStyle BorderStyle=StyleRaised!
boolean Sorted=false
boolean VScrollBar=true
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Documentation -- No Signature",&
"Documentation -- Added Hours Incorrectly",&
"Documentation -- Did Not Add Hours",&
"Documentation -- Did Not Include Miles",&
"Documentation",&
"Other -- Brake Inspection",&
"Other -- Pre-Trip Inspection",&
"Other"}
end type

event cbncloseup;st_cover.post setfocus()
end event

event keydown;if keydown(keyspacebar!) then
	send(handle(this), 1039, 0, 0)
	return 1
end if
end event

event selectionchanged;if nullornotpos(index) then return
choose case index
	case 1
		vtype = 6
		mle_desc.text = "The driver did not sign the log."
	case 2
		vtype = 6
		mle_desc.text = "The driver did not correctly add the hours."
	case 3 
		vtype = 6
		mle_desc.text = "The driver failed to calculate and record the hours."
	case 4
		vtype = 6
		mle_desc.text =  "The driver failed to include the total miles driven for this day."
	case 5
		vtype = 6
		mle_desc.text = ""
	case 6
		vtype = 0
		mle_desc.text = "The driver failed to perform a brake inspection."
	case 7
		vtype = 0
		mle_desc.text = "The driver failed to perform a pre-trip inspection."
	case 8
		vtype = 0
		mle_desc.text = ""
end choose

//this.selectitem(0)
if vtype = 6 then
	st_cover.text = "Violation Type:  Documentation"
else
	st_cover.text = "Violation Type:  Other"
end if
//mle_desc.setfocus()
//return
end event

