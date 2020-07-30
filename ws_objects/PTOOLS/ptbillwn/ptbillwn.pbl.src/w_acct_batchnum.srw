$PBExportHeader$w_acct_batchnum.srw
forward
global type w_acct_batchnum from Window
end type
type cb_nobatch from commandbutton within w_acct_batchnum
end type
type cb_ok from commandbutton within w_acct_batchnum
end type
type mle_1 from multilineedit within w_acct_batchnum
end type
type st_2 from statictext within w_acct_batchnum
end type
type st_1 from statictext within w_acct_batchnum
end type
type lb_list from listbox within w_acct_batchnum
end type
type sle_bdate from singlelineedit within w_acct_batchnum
end type
type sle_bnum from singlelineedit within w_acct_batchnum
end type
end forward

global type w_acct_batchnum from Window
int X=713
int Y=652
int Width=2213
int Height=692
boolean TitleBar=true
string Title="Create AR Batch"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_nobatch cb_nobatch
cb_ok cb_ok
mle_1 mle_1
st_2 st_2
st_1 st_1
lb_list lb_list
sle_bdate sle_bdate
sle_bnum sle_bnum
end type
global w_acct_batchnum w_acct_batchnum

type variables

end variables

event open;n_cst_msg lnv_cst_msg
s_parm lstr_parm
string lsa_batch_list[]
integer li_ndx
string ls_base, ls_work

lnv_cst_msg = message.powerobjectparm

if lnv_cst_msg.of_get_parm("BATCH_LIST", lstr_parm) > 0 then
	lsa_batch_list = lstr_parm.ia_value
	lb_list.setredraw(false)
	for li_ndx = 1 to upperbound(lsa_batch_list)
		lb_list.additem(lsa_batch_list[li_ndx])
	next
	lb_list.setredraw(true)
end if

sle_bdate.text = string(today(), "m/d/yy")

ls_base = "S" + string(today(), "m/d/yy hh:mm")
if lb_list.finditem(ls_base, 0) = -1 then
	sle_bnum.text = ls_base
else
	if len(ls_base) = 15 then ls_base = "S" + string(today(), "m/d/yy hhmm")
	for li_ndx = 65 to 90  //A-Z
		ls_work = ls_base + char(li_ndx)
		if lb_list.finditem(ls_work, 0) = -1 then
			sle_bnum.text = ls_work
			exit
		end if
	next
end if
end event

on w_acct_batchnum.create
this.cb_nobatch=create cb_nobatch
this.cb_ok=create cb_ok
this.mle_1=create mle_1
this.st_2=create st_2
this.st_1=create st_1
this.lb_list=create lb_list
this.sle_bdate=create sle_bdate
this.sle_bnum=create sle_bnum
this.Control[]={this.cb_nobatch,&
this.cb_ok,&
this.mle_1,&
this.st_2,&
this.st_1,&
this.lb_list,&
this.sle_bdate,&
this.sle_bnum}
end on

on w_acct_batchnum.destroy
destroy(this.cb_nobatch)
destroy(this.cb_ok)
destroy(this.mle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.lb_list)
destroy(this.sle_bdate)
destroy(this.sle_bnum)
end on

type cb_nobatch from commandbutton within w_acct_batchnum
int X=1719
int Y=328
int Width=402
int Height=88
int TabOrder=40
string Text="No AR Batch"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;n_cst_msg lnv_cst_msg
s_parm lstr_parm

if messagebox("Skip AR Batch", "Are you sure you want to skip the AR batch?  " +&
	"(The bills have already been processed, and you will not be able to recreate "+&
	"an AR batch for them later.)", question!, yesno!, 2) = 2 then return

lstr_parm.is_label = "SELECTION"
lstr_parm.ia_value = "NO_BATCH!"
lnv_cst_msg.of_add_parm(lstr_parm)

closewithreturn(parent, lnv_cst_msg)
end event

type cb_ok from commandbutton within w_acct_batchnum
int X=1719
int Y=208
int Width=402
int Height=88
int TabOrder=30
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;n_cst_msg lnv_Msg
s_parm lstr_parm
integer match_index
string batch_number
date batch_date
Boolean	lb_Append

batch_number = trim(sle_bnum.text)
if isdate(sle_bdate.text) then batch_date = date(sle_bdate.text) else setnull(batch_date)

if len(batch_number) > 0 then
	if isnull(batch_date) then
		beep(1)
		sle_bdate.setfocus()
		return
	end if
	match_index = lb_list.finditem(batch_number, 0)
	if match_index > 0 then
		if lb_list.text(match_index) = batch_number then

			lb_list.selectitem(0)
			lb_list.selectitem(match_index)

			IF messagebox("Append AR Batch", "OK to append to the selected batch?  "+&
				"(The batch date will be updated.)", Question!, YesNo!, 1) = 1 THEN

				lb_Append = TRUE

			ELSE

				sle_bnum.setfocus()
				return

			END IF


		end if
	end if
else
	beep(1)
	sle_bnum.setfocus()
	return
end if

lstr_parm.is_label = "SELECTION"
lstr_parm.ia_value = "CREATE_BATCH!"
lnv_Msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "BATCH_NUMBER"
lstr_parm.ia_value = batch_number
lnv_Msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "BATCH_DATE"
lstr_parm.ia_value = batch_date
lnv_Msg.of_add_parm(lstr_parm)

IF lb_Append = TRUE THEN

	lstr_Parm.is_Label = "APPEND"
	lstr_Parm.ia_Value = lb_Append
	lnv_Msg.of_Add_Parm ( lstr_Parm )

END IF

closewithreturn(parent, lnv_Msg)
end event

type mle_1 from multilineedit within w_acct_batchnum
event lbuttondown pbm_lbuttondown
int X=64
int Y=40
int Width=2053
int Height=140
boolean Border=false
string Text="Please specify a batch number and batch date.  The box on the left displays a list of any existing receivables batches."
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event lbuttondown;DragObject	ldo_Current

ldo_Current = GetFocus ( )

IF IsValid ( ldo_Current ) THEN
	ldo_Current.Post SetFocus ( )
END IF
end event

type st_2 from statictext within w_acct_batchnum
int X=791
int Y=340
int Width=329
int Height=76
boolean Enabled=false
string Text="Batch Date:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_acct_batchnum
int X=709
int Y=216
int Width=411
int Height=76
boolean Enabled=false
string Text="Batch Number:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_list from listbox within w_acct_batchnum
int X=73
int Y=212
int Width=603
int Height=328
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;sle_bnum.Text = This.Text ( Index )
end event

type sle_bdate from singlelineedit within w_acct_batchnum
event getfocus pbm_ensetfocus
int X=1129
int Y=328
int Width=521
int Height=76
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event losefocus;if getfocus() = cb_nobatch then return

if len(trim(this.text)) > 0 then
	if not isdate(this.text) then
		beep(1)
		this.post selecttext(1, len(this.text))
		this.post setfocus()
	end if
end if
end event

event modified;date newdate
if len(trim(this.text)) = 0 then
	this.text = ""
	return
end if

n_cst_string lnv_string
newdate = lnv_string.of_SpecialDate(this.text)
if isnull(newdate) then return

this.text = string(newdate, "m/d/yy")
end event

type sle_bnum from singlelineedit within w_acct_batchnum
int X=1129
int Y=212
int Width=521
int Height=76
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Limit=15
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

