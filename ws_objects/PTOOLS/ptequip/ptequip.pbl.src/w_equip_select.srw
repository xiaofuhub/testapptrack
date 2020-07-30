$PBExportHeader$w_equip_select.srw
forward
global type w_equip_select from w_equip_base
end type
type cb_select from commandbutton within w_equip_select
end type
type cb_cancel from commandbutton within w_equip_select
end type
end forward

global type w_equip_select from w_equip_base
WindowType WindowType=response!
boolean TitleBar=true
string Title="Driver / Equipment Selection"
boolean MinBox=false
boolean MaxBox=false
cb_select cb_select
cb_cancel cb_cancel
end type
global w_equip_select w_equip_select

on w_equip_select.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.cb_cancel
end on

on w_equip_select.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.cb_cancel)
end on

event open;boolean lb_anyeq, lb_local_only
integer sel_type
string sel_list
n_cst_EquipmentManager lnv_EquipmentMgr

ds_local = message.powerobjectparm

setpointer(hourglass!)

if g_tempstr = "LOCAL_ONLY!" then
	lb_local_only = true
	cb_refresh.enabled = false
	//g_tempstr = substitute(g_tempstr, "LOCAL_ONLY!", "")
	g_tempstr = ""
	dw_List.Post SetRedraw ( TRUE )  //BF0003

else

	IF NOT lnv_EquipmentMgr.of_CopyCache ( dw_List ) = 1 THEN
		Messagebox ( This.Title, "Could not retrieve equipment list from database.~n~n"+&
			"Please retry.", Exclamation!)
		CloseWithReturn ( This, 0 )
		RETURN
	END IF

end if

if isvalid(ds_local) then 
	gf_rows_sync(ds_local, null_dw, null_ds, dw_list, primary!, true, true)
end if

if lb_local_only = false then
	if left(g_tempstr, 5) = "ANYEQ" then
		lb_anyeq = true
		g_tempstr = replace(g_tempstr, 1, 5, "")
	end if
	sel_type = integer(left(g_tempstr, 3))
	sel_list = replace(g_tempstr, 1, 3, "")
	g_tempstr = ""
	
	choose case sel_type
	case 200
		rb_200.checked = true
	case 300
		rb_300.checked = true
	case 400
		rb_400.checked = true
	end choose

	if len(sel_list) = 0 then
		choose case sel_type
		case 200
			sel_list = "TSN"
		case 300
			sel_list = "VFRKBH"
		case 400
			sel_list = "C"
		end choose
	end if
	
	dw_list.setfilter("eq_status = 'K' and pos('" + sel_list + "', eq_type) > 0")
	dw_list.filter()
	dw_list.sort()

end if

rb_100.enabled = false
if not lb_anyeq then
	rb_200.enabled = rb_200.checked
	rb_300.enabled = rb_300.checked
	rb_400.enabled = rb_400.checked
end if

st_refresh.text = string(time(lnv_EquipmentMgr.of_Get_RefreshTime_Equip( )), "h:mma/p")

cb_select.setfocus()

//dw_list.setrowfocusindicator(focusrect!)
//dw_list.setfocus()
end event

type uo_radius_ship from w_equip_base`uo_radius_ship within w_equip_select
int X=1010
end type

event cb_refresh::clicked;n_cst_EquipmentManager lnv_EquipmentMgr

if lnv_EquipmentMgr.of_RefreshActive ( ) = 1 then
	dw_list.setredraw(false)
	dw_list.reset()
	lnv_EquipmentMgr.of_CopyCache ( dw_List )
	if isvalid(ds_local) then &
		gf_rows_sync(ds_local, null_dw, null_ds, dw_list, primary!, true, true)
	dw_list.filter()
	dw_list.sort()
	dw_list.setredraw(true)
	uo_radius_ship.of_unapplied()
	st_refresh.text = string(time(lnv_EquipmentMgr.of_Get_RefreshTime_Equip( )), "h:mma/p")
else
	messagebox("Refresh", "Could not retrieve information from database." +&
		"~n~nPlease retry.", exclamation!)
end if
end event

event dw_list::doubleclicked;call super::doubleclicked;if row > 0 then cb_select.event post clicked()
end event

event dw_list::rbuttondown;//This is to override right-click functionality in the ancestor
end event

type cb_select from commandbutton within w_equip_select
event clicked pbm_bnclicked
int X=3072
int Y=432
int Width=247
int Height=88
int TabOrder=40
string Text="Select"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long selrow, selid

selrow = dw_list.getrow()

if selrow > 0 then selid = dw_list.object.eq_id[selrow]

if selid > 0 then
	closewithreturn(parent, selid)
else
	messagebox("Equipment Selection", "No equipment is selected.")
end if
end event

type cb_cancel from commandbutton within w_equip_select
event clicked pbm_bnclicked
int X=3351
int Y=432
int Width=247
int Height=88
int TabOrder=50
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn(parent, 0)
end event

