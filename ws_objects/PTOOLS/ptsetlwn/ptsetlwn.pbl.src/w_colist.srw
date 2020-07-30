$PBExportHeader$w_colist.srw
forward
global type w_colist from w_popup
end type
type dw_list from u_dw within w_colist
end type
end forward

global type w_colist from w_popup
integer x = 786
integer y = 688
integer width = 2085
integer height = 652
string title = "Unrecognized Locations (double-click for details)"
boolean maxbox = false
dw_list dw_list
end type
global w_colist w_colist

type variables
Boolean		ib_CloseOnDoubleClick
end variables

event open;call super::open;int 	li_Count
int 	i 
long	ll_id
long 	lla_temp[]
String	lsa_Ids[]
any  	la_msg 
Blob	lblb_State

n_cst_msg lnv_msg
s_Parm	lstr_Parm

dw_list.settransobject(sqlca)
lnv_msg = message.powerobjectparm

IF ( lnv_msg.of_Get_Parm ( "TITLE" , lstr_Parm ) <> 0 ) THEN
	THIS.title = lstr_Parm.ia_Value
END IF

IF (lnv_Msg.of_Get_Parm( "CLOSEONDOUBLECLICK" , lstr_Parm) <> 0 ) THEN
	ib_CloseOnDoubleClick = TRUE
END IF

IF ( lnv_msg.of_Get_Parm ( "STATE" , lstr_Parm ) <> 0 ) THEN
		lblb_State = lstr_Parm.ia_Value
		dw_list.SetFullState ( lblb_State )
		
ELSE

	IF lnv_Msg.of_Get_Parm ( "IDS" , lstr_Parm ) <> 0 THEN
		lla_Temp = lstr_Parm.ia_Value
	END IF

	IF UpperBound ( lla_Temp ) > 0 THEN
		dw_list.retrieve(lla_Temp)
		commit ;
	END IF
	
END IF

dw_list.VScrollBar = TRUE
of_SetResize(TRUE)
inv_resize.of_SetMinSize(1300, 400)

//inv_resize.of_Register (dw_List, 'ScaleToRight')
//inv_resize.of_Register (dw_transactionamounts, 'ScaleToRight')
inv_resize.of_Register (dw_list, 'ScaleToRight&Bottom')


end event

on w_colist.create
int iCurrent
call super::create
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
end on

on w_colist.destroy
call super::destroy
destroy(this.dw_list)
end on

type dw_list from u_dw within w_colist
integer x = 32
integer y = 28
integer width = 1989
integer height = 496
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_companyrick"
boolean hscrollbar = true
end type

event rbuttondown;call super::rbuttondown;string lsa_parm_labels[]
any laa_parm_values[]

//if upper(dwo.type) = "DATAWINDOW" then
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "PRINT"
	lsa_parm_labels[2] = "PRINT_OBJECT"
	laa_parm_values[2] = this
	f_pop_standard(lsa_parm_labels, laa_parm_values)
//end if

RETURN AncestorReturnValue
end event

event doubleclicked;SetPointer ( HOURGLASS! ) 
n_cst_msg lnv_msg
s_parm lstr_parm
integer li_selrow
long 	ll_id

//if li_selrow < 1 then
//	this.enabled = false
//	return
//end if


if row > 0 then
 
	ll_id = dw_list.object.co_id[row]
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
	
	IF ib_CloseOnDoubleClick THEN
		Close(w_CoList)
	END IF

end if


end event

