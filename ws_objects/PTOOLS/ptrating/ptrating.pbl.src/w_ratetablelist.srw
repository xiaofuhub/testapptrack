$PBExportHeader$w_ratetablelist.srw
forward
global type w_ratetablelist from w_response
end type
type gb_1 from groupbox within w_ratetablelist
end type
type cb_ok from u_cbok within w_ratetablelist
end type
type ddlb_1 from dropdownlistbox within w_ratetablelist
end type
type uo_1 from u_picktable within w_ratetablelist
end type
end forward

global type w_ratetablelist from w_response
integer x = 5
integer y = 320
integer width = 3593
integer height = 1368
string title = "Rate Codename List"
long backcolor = 12632256
gb_1 gb_1
cb_ok cb_ok
ddlb_1 ddlb_1
uo_1 uo_1
end type
global w_ratetablelist w_ratetablelist

type variables
Private:




string	isa_itemlist[], &
	is_listtext, &
	isa_list1[], &
	isa_list2[], &
	isa_list3[], &
	isa_list4[], &
	isa_list5[], &
	isa_list6[], &
	isa_list7[]

long	ila_ListOrder[]

long	ila_itemlist[], &
	il_oldindex, &
	il_listschanged, &
	il_companyid
boolean	ib_message
n_cst_settings	inv_settings

end variables

forward prototypes
public subroutine wf_buildlist ()
public function long wf_getlist (long al_list, ref string asa_list[])
public function boolean wf_anychanges ()
public function long wf_getlist (readonly long al_uid, readonly long al_list, ref string asa_list[])
public subroutine wf_setlist (long al_list, string asa_list[])
public subroutine wf_setlist (readonly long al_uid, readonly long al_list, readonly string asa_list[])
end prototypes

public subroutine wf_buildlist ();
ila_ListOrder[1] = appeon_constant.cl_itemfreight_list
ila_ListOrder[2] = appeon_constant.cl_chassissplit_list
ila_ListOrder[3] = appeon_constant.cl_stopoff_list
ila_ListOrder[4] = appeon_constant.cl_FuelSurcharge_list
ila_ListOrder[5] = appeon_constant.cl_PerDiem_list
ila_ListOrder[6] = appeon_constant.cl_AutoCreatedAccessorialCharge_list
ila_ListOrder[7] = appeon_constant.cl_BobTail_list


//item 1
ddlb_1.InsertItem ( appeon_constant.cs_itemfreight_list,  1 )
isa_itemlist[1] = appeon_constant.cs_itemfreight_list
ila_itemlist[1] = appeon_constant.cl_itemfreight_list
if ib_message = true then
	this.wf_GetList(il_companyid, ila_itemlist[1], isa_list1)
else
	this.wf_GetList(0, ila_itemlist[1], isa_list1)
end if
		
//item 2
ddlb_1.InsertItem ( appeon_constant.cs_chassissplit_list,  2 )
isa_itemlist[2] = appeon_constant.cs_chassissplit_list
ila_itemlist[2] = appeon_constant.cl_chassissplit_list
if ib_message = true then
	this.wf_GetList(il_companyid, ila_itemlist[2], isa_list2)
else
	this.wf_GetList(0, ila_itemlist[2], isa_list2)
end if

//item 3
ddlb_1.InsertItem ( appeon_constant.cs_stopoff_list,  3 )
isa_itemlist[3] = appeon_constant.cs_stopoff_list
ila_itemlist[3] = appeon_constant.cl_stopoff_list
if ib_message = true then
	this.wf_GetList(il_companyid, ila_itemlist[3], isa_list3)
else
	this.wf_GetList(0, ila_itemlist[3], isa_list3)
end if

// item 4
ddlb_1.InsertItem ( appeon_constant.cs_FuelSurcharge_list,  4 )
isa_itemlist[4] = appeon_constant.cs_FuelSurcharge_list
ila_itemlist[4] = appeon_constant.cl_FuelSurcharge_list
if ib_message = true then
	this.wf_GetList(il_companyid, ila_itemlist[4], isa_list4)
else
	this.wf_GetList(0, ila_itemlist[4], isa_list4)
end if


//Item 5
ddlb_1.InsertItem ( appeon_constant.cs_PerDiem_list,  5 )
isa_itemlist[5] = appeon_constant.cs_PerDiem_list
ila_itemlist[5] = appeon_constant.cl_PerDiem_list
if ib_message = true then
	this.wf_GetList(il_companyid, ila_itemlist[5], isa_list5)
else
	this.wf_GetList(0, ila_itemlist[5], isa_list5)
end if

//Item 6
ddlb_1.InsertItem ( appeon_constant.cs_AutoCreatedAccessorialCharge_list,  6 )
isa_itemlist[6] = appeon_constant.cs_AutoCreatedAccessorialCharge_list
ila_itemlist[6] = appeon_constant.cl_AutoCreatedAccessorialCharge_list
if ib_message = true then
	this.wf_GetList(il_companyid, ila_itemlist[6], isa_list6)
else
	this.wf_GetList(0, ila_itemlist[6], isa_list6)
end if


//Item 7
ddlb_1.InsertItem ( appeon_constant.cs_BobTail_list,  7 )
isa_itemlist[7] = appeon_constant.cs_BobTail_list
ila_itemlist[7] = appeon_constant.cl_BobTail_list
if ib_message = true then
	this.wf_GetList(il_companyid, ila_itemlist[7], isa_list7)
else
	this.wf_GetList(0, ila_itemlist[7], isa_list7)
end if


//cb_ok.visible=false
//cb_cancel.visible=false
//cb_save.visible=true



end subroutine

public function long wf_getlist (long al_list, ref string asa_list[]);any	la_value

string	ls_list, &
			lsa_list[]
			
n_cst_string	lnv_string

IF inv_Settings.of_GetSetting ( al_list , la_value ) <> 1 THEN
	//no default
else
	ls_list = string ( la_Value )
	if lnv_string.of_ParseToArray(ls_list, ',', lsa_list ) > 0 then
		asa_list = lsa_list
	end if
end if 

return upperbound(lsa_list)
end function

public function boolean wf_anychanges ();//did anything change
//set lists and find out
boolean lb_changed
long		ll_list
string	lsa_list[], &
			lsa_blank[], &
			ls_list, &
			ls_oldlist

//first get last list modified
ll_list = uo_1.of_getlist(lsa_list)
choose case il_oldindex
	case 1
		isa_list1 = lsa_list		
	case 2
		isa_list2 = lsa_list
	case 3
		isa_list3 = lsa_list	
	case 4
		isa_list4 = lsa_list	
	case 5
		isa_list5 = lsa_list	
	case 6
		isa_list6 = lsa_list		
	case 7
		isa_list7 = lsa_list		
end choose

il_listschanged=0

n_cst_string	lnv_string

//proposed

//item 1
//get original list for comparison
ila_itemlist[1] = appeon_constant.cl_itemfreight_list
lsa_list = lsa_blank
if ib_message = true then
	this.wf_GetList(il_companyid, ila_itemlist[1], lsa_list)
else
	this.wf_GetList(0, ila_itemlist[1], lsa_list)
end if

if upperbound(lsa_list) > 0 then
	lnv_string.of_arraytostring(lsa_list, ',' , ls_oldlist)
end if
	
if upperbound(isa_list1) > 0 then
	lnv_string.of_arraytostring(isa_list1, ',' , ls_list)
end if

if trim(ls_oldlist) <> trim(ls_list) then
	lb_changed=true
	il_listschanged ++
end if
		
if not lb_changed then
	//item 2
	//get original list for comparison
	ila_itemlist[2] = appeon_constant.cl_chassissplit_list
	lsa_list = lsa_blank
	if ib_message = true then
		this.wf_GetList(il_companyid, ila_itemlist[2], lsa_list)
	else
		this.wf_GetList(0, ila_itemlist[2], lsa_list)
	end if

	if upperbound(lsa_list) > 0 then
		lnv_string.of_arraytostring(lsa_list, ',' , ls_oldlist)
	end if
		
	if upperbound(isa_list2) > 0 then
		lnv_string.of_arraytostring(isa_list2, ',' , ls_list)
	end if
	
	if trim(ls_oldlist) <> trim(ls_list) then
		lb_changed=true
		il_listschanged ++
	end if
			
end if

if not lb_changed then
	//item 3
	//get original list for comparison
	ila_itemlist[3] = appeon_constant.cl_stopoff_list
	lsa_list = lsa_blank
	if ib_message = true then
		this.wf_GetList(il_companyid, ila_itemlist[3], lsa_list)
	else
		this.wf_GetList(0, ila_itemlist[3], lsa_list)
	end if

	if upperbound(lsa_list) > 0 then
		lnv_string.of_arraytostring(lsa_list, ',' , ls_oldlist)
	end if
		
	if upperbound(isa_list3) > 0 then
		lnv_string.of_arraytostring(isa_list3, ',' , ls_list)
	end if
	
	if trim(ls_oldlist) <> trim(ls_list) then
		lb_changed=true
		il_listschanged ++
	end if
			
end if

if not lb_changed then
	//item 4
	//get original list for comparison
	ila_itemlist[4] = appeon_constant.cl_FuelSurcharge_list
	lsa_list = lsa_blank
	if ib_message = true then
		this.wf_GetList(il_companyid, ila_itemlist[4], lsa_list)
	else
		this.wf_GetList(0, ila_itemlist[4], lsa_list)
	end if

	if upperbound(lsa_list) > 0 then
		lnv_string.of_arraytostring(lsa_list, ',' , ls_oldlist)
	end if
		
	if upperbound(isa_list4) > 0 then
		lnv_string.of_arraytostring(isa_list4, ',' , ls_list)
	end if
	
	if trim(ls_oldlist) <> trim(ls_list) then
		lb_changed=true
		il_listschanged ++
	end if
			
end if

if not lb_changed then
	//item 5
	//get original list for comparison
	ila_itemlist[5] = appeon_constant.cl_PerDiem_list
	lsa_list = lsa_blank
	if ib_message = true then
		this.wf_GetList(il_companyid, ila_itemlist[5], lsa_list)
	else
		this.wf_GetList(0, ila_itemlist[5], lsa_list)
	end if

	if upperbound(lsa_list) > 0 then
		lnv_string.of_arraytostring(lsa_list, ',' , ls_oldlist)
	end if
		
	if upperbound(isa_list5) > 0 then
		lnv_string.of_arraytostring(isa_list5, ',' , ls_list)
	end if
	
	if trim(ls_oldlist) <> trim(ls_list) then
		lb_changed=true
		il_listschanged ++
	end if
			
end if

if not lb_changed then
	//item 6
	//get original list for comparison
	ila_itemlist[6] = appeon_constant.cl_AutoCreatedAccessorialCharge_list
	lsa_list = lsa_blank
	if ib_message = true then
		this.wf_GetList(il_companyid, ila_itemlist[6], lsa_list)
	else
		this.wf_GetList(0, ila_itemlist[6], lsa_list)
	end if

	if upperbound(lsa_list) > 0 then
		lnv_string.of_arraytostring(lsa_list, ',' , ls_oldlist)
	end if
		
	if upperbound(isa_list6) > 0 then
		lnv_string.of_arraytostring(isa_list6, ',' , ls_list)
	end if
	
	if trim(ls_oldlist) <> trim(ls_list) then
		lb_changed=true
		il_listschanged ++
	end if
			
end if


if not lb_changed then
	//item 7
	//get original list for comparison
	ila_itemlist[7] = appeon_constant.cl_Bobtail_list
	lsa_list = lsa_blank
	if ib_message = true then
		this.wf_GetList(il_companyid, ila_itemlist[7], lsa_list)
	else
		this.wf_GetList(0, ila_itemlist[7], lsa_list)
	end if

	if upperbound(lsa_list) > 0 then
		lnv_string.of_arraytostring(lsa_list, ',' , ls_oldlist)
	end if
		
	if upperbound(isa_list7) > 0 then
		lnv_string.of_arraytostring(isa_list7, ',' , ls_list)
	end if
	
	if trim(ls_oldlist) <> trim(ls_list) then
		lb_changed=true
		il_listschanged ++
	end if
			
end if

return lb_changed
end function

public function long wf_getlist (readonly long al_uid, readonly long al_list, ref string asa_list[]);any	la_value

string	ls_list, &
			lsa_list[]
			
n_cst_string	lnv_string

IF inv_Settings.of_GetCodeDefaultSetting ( il_companyid, al_list , la_value ) <> 1 THEN
	//no default
else
	ls_list = string ( la_Value )
	if lnv_string.of_ParseToArray(ls_list, ',', lsa_list ) > 0 then
		asa_list = lsa_list
	end if
end if 

return upperbound(lsa_list)
end function

public subroutine wf_setlist (long al_list, string asa_list[]);string	ls_list

n_cst_string	lnv_string

if upperbound(asa_list) > 0 then
	lnv_string.of_arraytostring(asa_list, ',' , ls_list)
end if

if len(ls_list) > 0 then
	inv_settings.of_SetSetting( al_list, ls_list, inv_settings.cs_datatype_string )
else 
	inv_settings.of_Deletesetting( al_list )
end if

end subroutine

public subroutine wf_setlist (readonly long al_uid, readonly long al_list, readonly string asa_list[]);string	ls_list

n_cst_string	lnv_string

if upperbound(asa_list) > 0 then
	lnv_string.of_arraytostring(asa_list, ',' , ls_list)
end if

if len(ls_list) > 0 then
	inv_settings.of_SetCodeDefaultSetting(al_uid, al_list, ls_list)
else 
	inv_settings.of_Deletesetting( al_list, al_uid )
end if

end subroutine

on w_ratetablelist.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.cb_ok=create cb_ok
this.ddlb_1=create ddlb_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.ddlb_1
this.Control[iCurrent+4]=this.uo_1
end on

on w_ratetablelist.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.cb_ok)
destroy(this.ddlb_1)
destroy(this.uo_1)
end on

event pfc_cancel;call super::pfc_cancel;n_cst_Msg	lnv_Msg
s_parm		lstr_Parm
	
lstr_Parm.is_Label = "CANCELLED"
//lstr_Parm.ia_Value = sle_1.TEXT
lnv_Msg.of_Add_Parm (lstr_Parm)

closewithreturn(this, lnv_Msg)

end event

event pfc_default;long	ll_list
string	lsa_list[]

n_cst_Msg	lnv_Msg
s_parm		lstr_Parm

ll_list = uo_1.of_getlist(lsa_list)
	
lstr_Parm.is_Label = "LIST"
lstr_Parm.ia_Value = lsa_list
lnv_Msg.of_Add_Parm (lstr_Parm)

CloseWithReturn ( THIS, lnv_msg )


end event

event open;call super::open;string	lsa_list[]

n_cst_msg	lnv_msg
s_parm	lstr_parm

lnv_Msg = message.powerobjectparm

//ib_disableclosequery = true

if isvalid(lnv_msg) then
	//only 1 list
//	IF lnv_msg.of_Get_Parm ("LIST", lstr_Parm ) <> 0 THEN
//		lsa_list = lstr_Parm.ia_Value 
//		isa_list1 = lsa_list
//	END IF
	IF lnv_msg.of_Get_Parm ("COMPANY", lstr_Parm ) <> 0 THEN
		il_companyid = lstr_Parm.ia_Value 
	END IF

	IF lnv_msg.of_Get_Parm ("TITLE", lstr_Parm ) <> 0 THEN
		is_listtext = lstr_Parm.ia_Value 
	END IF
	ib_message=true
else
	ib_message=false
end if

this.wf_buildlist()

this.post event pfc_open()

end event

event pfc_open;
//set for first in list
uo_1.of_setlist(isa_list1)
il_oldindex = 1
ddlb_1.SelectItem ( 1 )
ddlb_1.post setfocus()


end event

event pfc_save;			
if il_listschanged > 0 then
	//already set
else
	wf_anychanges()
end if

if il_listschanged > 0 then
	//now update
	if ib_message then
		this.wf_SetList(il_companyid, ila_itemlist[1], isa_list1)
		this.wf_SetList(il_companyid, ila_itemlist[2], isa_list2)
		this.wf_SetList(il_companyid, ila_itemlist[3], isa_list3)
		this.wf_SetList(il_companyid, ila_itemlist[4], isa_list4)
		this.wf_SetList(il_companyid, ila_itemlist[5], isa_list5)
		this.wf_SetList(il_companyid, ila_itemlist[6], isa_list6)
		this.wf_SetList(il_companyid, ila_itemlist[7], isa_list7)
	else
		this.wf_SetList(0, ila_itemlist[1], isa_list1)
		this.wf_SetList(0, ila_itemlist[2], isa_list2)
		this.wf_SetList(0, ila_itemlist[3], isa_list3)	
		this.wf_SetList(0, ila_itemlist[4], isa_list4)
		this.wf_SetList(0, ila_itemlist[5], isa_list5)	
		this.wf_SetList(0, ila_itemlist[6], isa_list6)
		this.wf_SetList(0, ila_itemlist[7], isa_list7)
	end if

	if inv_settings.of_SaveSetting() < 0 then
		messagebox('Save', 'Could not save')
	else
		il_listschanged = 0
	end if
end if

return 0
end event

event closequery;long	ll_return = 0

//ll_return = AncestorReturnValue

//if ib_message then
//	//no qustion
//else
	if ll_return = 0 then
	//	//did anything change
		if wf_anychanges() then
			choose case messagebox('Save Changes', &
								'Do you want to save any changes made to the lists?', &
								question!, yesnocancel!)
				case 1
					this.event pfc_save()
					ll_return = 0
				case 2
					ll_return = 0
				case 3
					ll_return = 1
			end choose
		end if
	end if
//end if

return ll_return

end event

type cb_help from w_response`cb_help within w_ratetablelist
end type

type gb_1 from groupbox within w_ratetablelist
integer x = 14
integer y = 24
integer width = 933
integer height = 204
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Select &List"
end type

type cb_ok from u_cbok within w_ratetablelist
integer x = 1618
integer y = 1140
integer width = 343
integer taborder = 30
boolean bringtotop = true
string text = "Close"
end type

type ddlb_1 from dropdownlistbox within w_ratetablelist
integer x = 37
integer y = 100
integer width = 887
integer height = 472
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
integer accelerator = 108
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;long	ll_list

string	lsa_list[]

//get old index save the list before presenting next selection

ll_list = uo_1.of_getlist(lsa_list)

choose case il_oldindex
	case 1 
		isa_list1 = lsa_list

	case 2
		isa_list2 = lsa_list
		
	case 3
		isa_list3 = lsa_list
		
	case 4
		isa_list4 = lsa_list
		
	case 5
		isa_list5 = lsa_list
				
	case 6
		isa_list6 = lsa_list
	
	case 7
		isa_list7 = lsa_list
				
end choose

uo_1.of_Setnocharge( false )
choose case index
	case 1
		lsa_list = isa_list1
		
	case 2
		lsa_list = isa_list2
		
	case 3
		lsa_list = isa_list3
		
	case 4
		lsa_list = isa_list4
		
	case 5
		lsa_list = isa_list5
		
	case 6
		lsa_list = isa_list6
		IF ib_Message THEN
			uo_1.of_Setnocharge( true )
		END IF
		
	case 7	
		lsa_list = isa_list7
end choose
il_oldindex = index
uo_1.of_SetSelectedList(index)
uo_1.of_setlist(lsa_list)
uo_1.of_SetListText(ila_ListOrder[index])
end event

type uo_1 from u_picktable within w_ratetablelist
integer x = 9
integer width = 3557
integer height = 1112
integer taborder = 20
end type

on uo_1.destroy
call u_picktable::destroy
end on

