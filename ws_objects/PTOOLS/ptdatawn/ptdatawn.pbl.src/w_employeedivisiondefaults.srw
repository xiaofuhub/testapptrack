$PBExportHeader$w_employeedivisiondefaults.srw
forward
global type w_employeedivisiondefaults from w_response
end type
type cb_2 from u_cbok within w_employeedivisiondefaults
end type
type cb_1 from u_cbcancel within w_employeedivisiondefaults
end type
type uo_defaults from u_cst_employeedivisiondefaults within w_employeedivisiondefaults
end type
type st_1 from statictext within w_employeedivisiondefaults
end type
end forward

global type w_employeedivisiondefaults from w_response
integer width = 1655
integer height = 1112
long backcolor = 12632256
boolean ib_disableclosequery = true
cb_2 cb_2
cb_1 cb_1
uo_defaults uo_defaults
st_1 st_1
end type
global w_employeedivisiondefaults w_employeedivisiondefaults

type variables
long	il_empId
end variables

on w_employeedivisiondefaults.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_defaults=create uo_defaults
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_defaults
this.Control[iCurrent+4]=this.st_1
end on

on w_employeedivisiondefaults.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_defaults)
destroy(this.st_1)
end on

event open;call super::open;Integer	li_Return = 1 //Allow to open
String	ls_Msg
String	ls_EmpName
Boolean	lb_AdvancedPrivs

n_cst_setting_AdvancedPrivs	lnv_AdvancedPrivSetting
n_cst_Privileges	lnv_Privs
n_cst_privsManager lnv_manager
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm	


lnv_AdvancedPrivSetting	= CREATE n_cst_setting_AdvancedPrivs 
lnv_manager = gnv_app.of_getPrivsmanager( )
//must be ptadmin to open
IF lnv_Privs.of_HasSysAdminRights() THEN
	//continue
ELSE
	li_Return = -1
	ls_Msg = "Only PTADMIN can edit employee division defaults."
END IF

//must be using advanced privs to open
IF li_Return = 1 THEN
	//modified by dan 5-31-2006
	IF lnv_AdvancedPrivSetting.of_GetValue( ) = n_cst_setting_AdvancedPrivs.cs_Yes THEN
		//continue
	ELSE
		li_Return = -1
		ls_Msg = "Must enable extended privilege settings to set up division defaults."
	END IF
END IF


IF li_Return = 1 THEN
	
	IF isValid ( Message.Powerobjectparm ) THEN
		lnv_Msg = Message.Powerobjectparm
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "EM_NAME" , lstr_Parm ) > 0 THEN
		ls_empName = lstr_Parm.ia_value
		This.Title = "Division defaults for:  " + ls_EmpName
	END IF	

	IF lnv_Msg.of_Get_Parm ( "EM_ID" , lstr_Parm ) > 0 THEN
		il_empId = lstr_Parm.ia_value
		uo_defaults.event ue_retrieve( il_empId  )
	END IF
	
ELSE
	CLOSE(this)
	MessageBox ("System Settings" , ls_Msg, Exclamation!)
END IF


Destroy	lnv_AdvancedPrivSetting
end event

event pfc_default;call super::pfc_default;uo_defaults.Event pfc_Update(uo_defaults.Control, true, true)

CLOSE(This)

end event

event pfc_cancel;call super::pfc_cancel;ib_DisableCloseQuery =  TRUE 
Close ( THIS )
end event

type cb_help from w_response`cb_help within w_employeedivisiondefaults
boolean visible = false
integer y = 1240
end type

type cb_2 from u_cbok within w_employeedivisiondefaults
integer x = 1088
integer y = 916
integer width = 233
integer taborder = 20
end type

type cb_1 from u_cbcancel within w_employeedivisiondefaults
integer x = 1339
integer y = 916
integer width = 233
integer taborder = 20
end type

event clicked;CLOSE(Parent)
end event

type uo_defaults from u_cst_employeedivisiondefaults within w_employeedivisiondefaults
integer x = 27
integer y = 76
integer width = 1650
integer taborder = 20
end type

on uo_defaults.destroy
call u_cst_employeedivisiondefaults::destroy
end on

type st_1 from statictext within w_employeedivisiondefaults
integer x = 69
integer y = 32
integer width = 1495
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Select a default shipment type for each new shipment template."
boolean focusrectangle = false
end type

