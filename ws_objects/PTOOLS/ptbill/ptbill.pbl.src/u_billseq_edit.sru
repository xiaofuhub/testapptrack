$PBExportHeader$u_billseq_edit.sru
forward
global type u_billseq_edit from UserObject
end type
type mle_instruct from multilineedit within u_billseq_edit
end type
type dw_detail from datawindow within u_billseq_edit
end type
end forward

global type u_billseq_edit from UserObject
int Width=2341
int Height=881
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
mle_instruct mle_instruct
dw_detail dw_detail
end type
global u_billseq_edit u_billseq_edit

type variables
protected:
window iw_parent
end variables

forward prototypes
public function long of_retrieve_list ()
public subroutine of_new ()
public function integer of_save_if_needed (string as_context)
public function integer of_set_parent (window aw_new_parent)
end prototypes

public function long of_retrieve_list ();long ll_rowcount
n_cst_billseq lnv_cst_billseq

if lnv_cst_billseq.of_ready(true) = false then return -1

ll_rowcount = lnv_cst_billseq.ids_billseq.rowcount()

dw_detail.setredraw(false)
dw_detail.reset()

if ll_rowcount > 0 then
	lnv_cst_billseq.ids_billseq.rowscopy(1, ll_rowcount, primary!, dw_detail, &
		9999, primary!)
	dw_detail.sort()
	dw_detail.resetupdate()
end if

dw_detail.setredraw(true)

return 1
end function

public subroutine of_new ();long ll_row, ll_checkloop, ll_new_id

if dw_detail.accepttext() = -1 then return

ll_new_id = 2400
for ll_checkloop = 1 to dw_detail.rowcount()
	if dw_detail.object.bs_id[ll_checkloop] > ll_new_id then &
		ll_new_id = dw_detail.object.bs_id[ll_checkloop]
next
ll_new_id ++

ll_row = dw_detail.insertrow(0)

if ll_row > 0 then
	dw_detail.object.bs_id[ll_row] = ll_new_id
	dw_detail.scrolltorow(ll_row)
	dw_detail.setcolumn("bs_name")
else
	messagebox("Create New Invoice Series", "Could not process request.  Request cancelled.", &
		exclamation!)
end if
end subroutine

public function integer of_save_if_needed (string as_context);//Return Values: 	-1 : Do not proceed,  1 : Proceed
//
//Note:  This doesn't indicate success or failure.  It indicates whether the user would
//object to the calling script disposing of the current edit info.  If the save goes
//through, or if there were no changes, the value is always 1, but if the save fails, 
//the value can be -1 or 1, depending on whether the user has approved abandoning the 
//changes.  A conflict that prevents the save attempt will always return -1.

string ls_new_dbstring, ls_work, ls_message_header
long ll_row

if as_context = "CLOSE_WINDOW!" and isvalid(iw_parent) then
	iw_parent.setfocus()
	iw_parent.show()
end if

if dw_detail.accepttext() = -1 then return -1
if dw_detail.modifiedcount() = 0 then return 1

if isvalid(iw_parent) then ls_message_header = iw_parent.title &
	else ls_message_header = "Close Window"

choose case as_context
case "SAVE_REQUEST!"
	//No processing needed
case "CLOSE_WINDOW!"
	choose case messagebox(ls_message_header, "Save changes before closing?", &
		question!, yesnocancel!)
	case 2
		return 1
	case 3
		return -1
	end choose
end choose

ls_work = "len(bs_name) = 0 or isnull(bs_name) or bs_name = '" +&
	dw_detail.object.bs_name.initial + "' or isnull(bs_definition) or isnull(bs_next)"

if dw_detail.find(ls_work, 1, dw_detail.rowcount()) > 0 then
	messagebox("Save Changes", "You must provide a Name, Definition, and Next # Value "+&
		"for each Invoice Series before your changes can be saved.")
	return -1
end if

ll_row = 0

do
	ll_row = dw_detail.getnextmodified(ll_row, primary!)
	if ll_row > 0 then
		ls_new_dbstring = ""

		ls_work = dw_detail.object.bs_name[ll_row]
		if isnull(ls_work) then ls_work = ""
		ls_new_dbstring += "NAME~t" + ls_work + "~n"

		ls_work = dw_detail.object.bs_definition[ll_row]
		if isnull(ls_work) then ls_work = ""
		ls_new_dbstring += "DEFINITION~t" + ls_work + "~n"

		dw_detail.object.bs_dbstring[ll_row] = ls_new_dbstring
	end if
loop while ll_row > 0

if dw_detail.update() = 1 then
	commit ;
else
	rollback ;
	goto failure
end if

return 1

failure:

choose case as_context
case "SAVE_REQUEST!"
	messagebox("Save Changes", "Could not save changes to database.~n~nPlease retry.", &
		exclamation!)
	return -1
case "CLOSE_WINDOW!"
	if messagebox("Save Changes", "Could not save changes to database.  Press OK "+&
		"to abandon changes and close window, or Cancel to return to the Invoice "+&
		"Series Setup screen and preserve changes for now.", exclamation!, okcancel!) = 2 &
		then return -1
end choose

return 1
end function

public function integer of_set_parent (window aw_new_parent);if isvalid(aw_new_parent) then
	iw_parent = aw_new_parent
	return 1
else
	return -1
end if
end function

event constructor;dw_detail.settransobject(sqlca)

mle_instruct.text = "Invoice Series allow you to customize the Invoice Numbers that are assigned to bills when they are printed.  Each Invoice Series Definition indicates how a sequentially generated Number Value should be combined with other letters, numbers, or special characters to form an Invoice Number.~r~n~r~nTo create the definition, just type the base characters along with one or more # signs where the sequential number value should go.  For example, the Definition FZ#AF will convert a Number Value of 123 to the Invoice Number FZ123AF.~r~n~r~nYou can use multiple # signs to indicate a minimum number of digits for the Number Value.  For example, the Definition FZ####AF will convert 123 to FZ0123AF, but will convert 12345 to FZ12345AF.~r~n~r~nOnce you have created an Invoice Series, you can then use the Shipment Type Setup window to assign it to one or more shipment types.  When bills of that type are printed, the invoice number will be generated automatically according to your definition."
end event

on u_billseq_edit.create
this.mle_instruct=create mle_instruct
this.dw_detail=create dw_detail
this.Control[]={ this.mle_instruct,&
this.dw_detail}
end on

on u_billseq_edit.destroy
destroy(this.mle_instruct)
destroy(this.dw_detail)
end on

type mle_instruct from multilineedit within u_billseq_edit
event lbuttondown pbm_lbuttondown
int Width=2332
int Height=285
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean DisplayOnly=true
string Text="Invoice Series allow you to customize the Invoice Numbers that are assigned to bills when they are printed..."
string Pointer="Arrow!"
long BackColor=16777215
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

type dw_detail from datawindow within u_billseq_edit
int Y=341
int Width=2332
int Height=537
int TabOrder=20
string DataObject="d_billseq_edit"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemerror;this.selecttext(1, 999)
this.setfocus()
beep(1)
return 1
end event

