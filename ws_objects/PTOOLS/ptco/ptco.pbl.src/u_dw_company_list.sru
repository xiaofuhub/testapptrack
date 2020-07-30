$PBExportHeader$u_dw_company_list.sru
forward
global type u_dw_company_list from u_dw
end type
end forward

global type u_dw_company_list from u_dw
int Width=1893
int Height=304
string DataObject="d_companyrick"
end type
global u_dw_company_list u_dw_company_list

type variables

boolean	ib_AllowDoubleClick = TRUE
end variables

event doubleclicked;SetPointer ( HOURGLASS! ) 
n_cst_msg lnv_msg
s_parm lstr_parm
integer li_selrow
long 	ll_id

//if li_selrow < 1 then
//	this.enabled = false
//	return
//end if


if row > 0 AND ib_AllowDoubleClick then 
 
	ll_id = THIS.object.co_id[row]
	lstr_parm.is_label = "TOPIC"
	lstr_parm.ia_Value = "COMPANY!"
	lnv_msg.of_add_parm(lstr_parm)

	lstr_parm.is_label = "REQUEST"
	lstr_parm.ia_Value = "DETAILS!"
	lnv_msg.of_add_parm(lstr_parm)

	lstr_parm.is_Label = "TARGET_ID"
	lstr_parm.ia_Value = ll_id
	lnv_msg.of_add_parm(lstr_parm)
	
	f_process_standard(lnv_msg)

end if


end event

event constructor;settransobject ( sqlca )
ib_rmbMenu = FALSE

end event

