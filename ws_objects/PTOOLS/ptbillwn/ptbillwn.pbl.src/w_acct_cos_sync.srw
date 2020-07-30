$PBExportHeader$w_acct_cos_sync.srw
forward
global type w_acct_cos_sync from Window
end type
type st_billing from statictext within w_acct_cos_sync
end type
type st_physical from statictext within w_acct_cos_sync
end type
type st_bill_same from statictext within w_acct_cos_sync
end type
type cb_cancel from commandbutton within w_acct_cos_sync
end type
type cb_ok from commandbutton within w_acct_cos_sync
end type
type mle_instruct from multilineedit within w_acct_cos_sync
end type
type st_2 from statictext within w_acct_cos_sync
end type
type st_1 from statictext within w_acct_cos_sync
end type
type dw_acct_cos from datawindow within w_acct_cos_sync
end type
type st_verifying from statictext within w_acct_cos_sync
end type
end forward

global type w_acct_cos_sync from Window
int X=827
int Y=188
int Width=1838
int Height=2040
boolean TitleBar=true
string Title="Accounting ID Verification"
long BackColor=12632256
WindowType WindowType=response!
st_billing st_billing
st_physical st_physical
st_bill_same st_bill_same
cb_cancel cb_cancel
cb_ok cb_ok
mle_instruct mle_instruct
st_2 st_2
st_1 st_1
dw_acct_cos dw_acct_cos
st_verifying st_verifying
end type
global w_acct_cos_sync w_acct_cos_sync

type variables
protected:
long il_full_height, il_invalid_count
datastore ds_acct_source
n_cst_acctlink inv_cst_acctlink
end variables

forward prototypes
protected subroutine wf_verify (boolean ab_initial)
protected subroutine wf_get_details ()
end prototypes

protected subroutine wf_verify (boolean ab_initial);//This function may close the window, with the following return codes
//  -3 : User chose to cancel billing
//  -1 : There was an error that should halt billing
// >=0 : Validation complete.  All companies either validated or skipped by user.
//			Value is number of companies whose IDs are INVALID (0 = All OK).

string ls_acctcode, ls_origcode, ls_skiplist
long ll_row, ll_id

dw_acct_cos.setredraw(false)

if not ab_initial then

	dw_acct_cos.accepttext()

	ls_skiplist = ""

	for ll_row = 1 to ds_acct_source.rowcount()
		if ds_acct_source.getitemstatus(ll_row, "co_bill_acctcode", primary!) = datamodified! then
			ls_acctcode = ds_acct_source.object.co_bill_acctcode[ll_row]
			ls_origcode = ds_acct_source.getitemstring(ll_row, "co_bill_acctcode", primary!, true)
			if ls_acctcode = ls_origcode or (isnull(ls_acctcode) or len(trim(ls_acctcode)) = 0) then &
				ds_acct_source.setitemstatus(ll_row, "co_bill_acctcode", primary!, notmodified!)
		end if
		if ds_acct_source.getitemstatus(ll_row, "co_bill_acctcode", primary!) = notmodified! &
			then ls_skiplist += ds_acct_source.object.xx_acct_name[ll_row] + "~n"
	next

	if len(ls_skiplist) > 0 then
		if messagebox("Approve ID List", "You have not specified an ID for the following "+&
			"companies:~n~n" + ls_skiplist +  "~nShipments billed to these companies will "+&
			"not be included in the AR Batch.~n~nOK to proceed?", question!, &
			okcancel!, 2) = 2 then
				dw_acct_cos.setredraw(true)
				closewithreturn(this, -3)
				return
		end if

		for ll_row = ds_acct_source.rowcount() to 1 step -1
			if ds_acct_source.getitemstatus(ll_row, "co_bill_acctcode", primary!) = notmodified! then
				il_invalid_count ++
				ds_acct_source.rowsmove(ll_row, ll_row, primary!, ds_acct_source, 9999, filter!)
			end if
		next

	end if

end if


choose case inv_cst_acctlink.of_validate_customers(ds_acct_source)

case -1
	//Verification process failed.

	messagebox("Approve ID List", "Could not verify Customer ID's with the accounting "+&
		"package.~n~nBilling request cancelled.", exclamation!)
	dw_acct_cos.setredraw(true)
	closewithreturn(this, -1)
	return

case -3
	//User chose cancel billing (See QuickBooks implementation)

	dw_acct_cos.setredraw(true)
	closewithreturn(this, -3)
	return

end choose

if not ab_initial then

	ls_skiplist = ""

	for ll_row = 1 to ds_acct_source.rowcount()
		if ds_acct_source.object.approved[ll_row] = "T" and &
			ds_acct_source.object.save_change[ll_row] = "T" and &
			ds_acct_source.getitemstatus(ll_row, "co_bill_acctcode", primary!) = datamodified! then
				ll_id = ds_acct_source.object.co_id[ll_row]
				ls_acctcode = trim(ds_acct_source.object.co_bill_acctcode[ll_row])
				update companies set co_bill_acctcode = :ls_acctcode, co_intsig = co_intsig + 1 
					where co_id = :ll_id ;
				if sqlca.sqlcode = 0 then
					commit ;
				else
					rollback ;
					ls_skiplist += ds_acct_source.object.xx_acct_name[ll_row] + "~n"
				end if
		end if
	next

	if len(ls_skiplist) > 0 then
		messagebox("Approve ID List", "The IDs specified for the following companies "+&
			"could not be saved to the database:~n~n" + ls_skiplist + "~nBilling and the "+&
			"creation of the AR Batch will proceed normally.")
	end if

end if

for ll_row = ds_acct_source.rowcount() to 1 step -1
	ds_acct_source.setitemstatus(ll_row, "co_bill_acctcode", primary!, notmodified!)
	if ds_acct_source.object.approved[ll_row] = "T" then
		ds_acct_source.rowsmove(ll_row, ll_row, primary!, ds_acct_source, 9999, filter!)
	end if
next

dw_acct_cos.setredraw(true)

if ds_acct_source.rowcount() > 0 then //Some IDs are not valid (they are left in the list.)
	if ab_initial then
		this.height = il_full_height
		st_verifying.visible = false
		mle_instruct.visible = true
		cb_ok.visible = true
		cb_cancel.visible = true
	else
		mle_instruct.text = "The following companies still do not have a match.  "+&
			"You may revise some or all of your entries.  Bills for companies whose "+&
			"IDs you do not revise will not be included in the AR batch."
	end if
else //All companies have either been approved or skipped (there are 0 left in the list.)
	closewithreturn(this, il_invalid_count)
end if

return
end subroutine

protected subroutine wf_get_details ();long ll_id, ll_listrow
string ls_address
n_cst_numerical lnv_numerical

st_bill_same.visible = false

st_physical.text = ""
st_billing.text = ""

ll_listrow = dw_acct_cos.getrow()
if lnv_numerical.of_IsNullOrNotPos(ll_listrow) then return

ll_id = dw_acct_cos.object.co_id[ll_listrow]

gnv_cst_companies.of_get_address(ll_id, "PHYSICAL!", true, ls_address)
st_physical.text = substitute(ls_address, null_str, "")

gnv_cst_companies.of_get_address(ll_id, "BILLING!", true, ls_address)
st_billing.text = substitute(ls_address, null_str, "")
end subroutine

on w_acct_cos_sync.create
this.st_billing=create st_billing
this.st_physical=create st_physical
this.st_bill_same=create st_bill_same
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.mle_instruct=create mle_instruct
this.st_2=create st_2
this.st_1=create st_1
this.dw_acct_cos=create dw_acct_cos
this.st_verifying=create st_verifying
this.Control[]={this.st_billing,&
this.st_physical,&
this.st_bill_same,&
this.cb_cancel,&
this.cb_ok,&
this.mle_instruct,&
this.st_2,&
this.st_1,&
this.dw_acct_cos,&
this.st_verifying}
end on

on w_acct_cos_sync.destroy
destroy(this.st_billing)
destroy(this.st_physical)
destroy(this.st_bill_same)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.mle_instruct)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_acct_cos)
destroy(this.st_verifying)
end on

event open;n_cst_msg lnv_cst_msg
s_parm lstr_parm

lnv_cst_msg = message.powerobjectparm

if lnv_cst_msg.of_get_parm("TARGET", lstr_parm) > 0 then
	ds_acct_source = lstr_parm.ia_value
end if

if lnv_cst_msg.of_get_parm("ACCTLINK", lstr_parm) > 0 then
	inv_cst_acctlink = lstr_parm.ia_value
end if

if not (isvalid(ds_acct_source) and isvalid(inv_cst_acctlink)) then closewithreturn(this, 0)

if ds_acct_source.rowcount() > 0 then
else
	closewithreturn(this, 0)
end if

ds_acct_source.sharedata(dw_acct_cos)

il_full_height = this.height
this.height = 429

post wf_verify(true)
end event

event close;dw_acct_cos.setfilter("")
dw_acct_cos.filter()
dw_acct_cos.sharedataoff()
end event

type st_billing from statictext within w_acct_cos_sync
int X=219
int Y=1560
int Width=1303
int Height=348
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_physical from statictext within w_acct_cos_sync
int X=219
int Y=1096
int Width=1303
int Height=348
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_bill_same from statictext within w_acct_cos_sync
int X=745
int Y=1696
int Width=247
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="SAME"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_acct_cos_sync
int X=901
int Y=436
int Width=402
int Height=88
int TabOrder=30
boolean Visible=false
string Text="Cancel Billing"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn(parent, -3)
end event

type cb_ok from commandbutton within w_acct_cos_sync
int X=448
int Y=436
int Width=402
int Height=88
int TabOrder=20
boolean Visible=false
string Text="OK"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;boolean lb_initial = false
wf_verify(lb_initial)
end event

type mle_instruct from multilineedit within w_acct_cos_sync
event lbuttondown pbm_lbuttondown
int X=37
int Y=28
int Width=1746
int Height=352
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean DisplayOnly=true
string Text="The following companies either have no accounting ID specified, or they have an ID that has no match in the accounting package. Please specify the correct accounting ID's for these companies. Invoices billed to companies whose ID's you don't correct will be printed, but they will not be included in the AR batch."
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

type st_2 from statictext within w_acct_cos_sync
int X=219
int Y=1480
int Width=576
int Height=76
boolean Enabled=false
string Text="Billing Address"
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_acct_cos_sync
int X=219
int Y=1016
int Width=576
int Height=76
boolean Enabled=false
string Text="Physical Address"
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_acct_cos from datawindow within w_acct_cos_sync
event processenter pbm_dwnprocessenter
int X=37
int Y=580
int Width=1746
int Height=384
int TabOrder=10
string DataObject="d_acct_cos"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event processenter;send(handle(this), 256, 9, long(0, 0))
return 1
end event

event clicked;choose case dwo.name
case "save_change"
	if ds_acct_source.object.save_change[row] = "T" then
		ds_acct_source.object.save_change[row] = "F"
	else
		ds_acct_source.object.save_change[row] = "T"
	end if
	this.setredraw(true)
end choose
end event

event rowfocuschanged;post wf_get_details()
end event

type st_verifying from statictext within w_acct_cos_sync
int X=398
int Y=140
int Width=983
int Height=76
boolean Enabled=false
string Text="Verifying Customer Accounting ID's ..."
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

