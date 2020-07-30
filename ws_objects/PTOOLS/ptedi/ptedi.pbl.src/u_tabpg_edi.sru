$PBExportHeader$u_tabpg_edi.sru
forward
global type u_tabpg_edi from u_tabpg
end type
type dw_profile from u_dw_ediprofile within u_tabpg_edi
end type
type st_title from statictext within u_tabpg_edi
end type
end forward

global type u_tabpg_edi from u_tabpg
integer width = 2587
integer height = 1600
long backcolor = 12632256
long tabbackcolor = 12632256
dw_profile dw_profile
st_title st_title
end type
global u_tabpg_edi u_tabpg_edi

type variables
protected:

long	il_coid
end variables

forward prototypes
public subroutine of_setcompany (long al_coid)
public function long of_getcompany ()
end prototypes

public subroutine of_setcompany (long al_coid);il_coid = al_coid
end subroutine

public function long of_getcompany ();return il_coid
end function

on u_tabpg_edi.create
int iCurrent
call super::create
this.dw_profile=create dw_profile
this.st_title=create st_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_profile
this.Control[iCurrent+2]=this.st_title
end on

on u_tabpg_edi.destroy
call super::destroy
destroy(this.dw_profile)
destroy(this.st_title)
end on

event constructor;call super::constructor;long	ll_coid

n_cst_msg	lnv_msg
s_parm		lstr_Parm

IF IsValid( Message.PowerObjectParm ) Then 
	If UPPER( Message.PowerObjectParm.ClassName ( ) ) = "N_CST_MSG" Then 
		lnv_msg = Message.PowerObjectParm	
	End If
END IF

if isvalid(lnv_msg) then
	IF lnv_msg.of_Get_Parm ( "COMPANYID" , lstr_Parm ) <> 0 THEN
		ll_coid = lstr_Parm.ia_Value
		this.of_setcompany(ll_coid) 
	END IF
end if
end event

type dw_profile from u_dw_ediprofile within u_tabpg_edi
integer x = 9
integer y = 136
integer height = 408
integer taborder = 10
end type

event constructor;call super::constructor;this.SetTransobject(SQLCA)
ib_rmbmenu=false
end event

type st_title from statictext within u_tabpg_edi
integer x = 146
integer y = 36
integer width = 1591
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
boolean focusrectangle = false
end type

