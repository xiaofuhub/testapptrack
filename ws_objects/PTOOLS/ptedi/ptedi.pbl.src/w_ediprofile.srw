$PBExportHeader$w_ediprofile.srw
forward
global type w_ediprofile from w_response
end type
type cb_3 from commandbutton within w_ediprofile
end type
type cb_2 from u_cbcancel within w_ediprofile
end type
type cb_1 from u_cbok within w_ediprofile
end type
type tab_1 from u_tab_ediprofile within w_ediprofile
end type
type tab_1 from u_tab_ediprofile within w_ediprofile
end type
type st_1 from statictext within w_ediprofile
end type
end forward

global type w_ediprofile from w_response
integer x = 5
integer y = 200
integer width = 3602
integer height = 2124
string title = "EDI Profile"
long backcolor = 12632256
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
tab_1 tab_1
st_1 st_1
end type
global w_ediprofile w_ediprofile

type variables
private:

long	il_coid
end variables

on w_ediprofile.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.tab_1=create tab_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.tab_1
this.Control[iCurrent+5]=this.st_1
end on

on w_ediprofile.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.tab_1)
destroy(this.st_1)
end on

event open;call super::open;long		ll_rowcount

n_cst_msg	lnv_msg
s_parm		lstr_Parm

IF IsValid( Message.PowerObjectParm ) Then 
	If UPPER( Message.PowerObjectParm.ClassName ( ) ) = "N_CST_MSG" Then 
		lnv_msg = Message.PowerObjectParm	
	End If
END IF

if gnv_App.of_GetrestrictedView ( ) then
	//size ok
else
	this.width = this.width + 700
	cb_1.x = cb_1.x + 700
	cb_2.x = cb_2.x + 700
	cb_3.x = cb_3.x + 700
	tab_1.width = tab_1.width + 700
end if

IF lnv_msg.of_Get_Parm ( "COMPANYID" , lstr_Parm ) <> 0 THEN
	il_coid = lstr_Parm.ia_Value
END IF

tab_1.of_BuildTabPages(lnv_msg)


end event

type cb_help from w_response`cb_help within w_ediprofile
end type

type cb_3 from commandbutton within w_ediprofile
integer x = 3214
integer y = 1872
integer width = 343
integer height = 92
integer taborder = 31
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Apply"
end type

event clicked;parent.event pfc_save()
end event

type cb_2 from u_cbcancel within w_ediprofile
integer x = 2839
integer y = 1872
integer width = 343
integer height = 92
integer taborder = 31
integer weight = 400
fontcharset fontcharset = ansi!
end type

event clicked;call super::clicked;close(parent)
end event

type cb_1 from u_cbok within w_ediprofile
integer x = 2464
integer y = 1872
integer width = 343
integer height = 92
integer taborder = 21
integer weight = 400
fontcharset fontcharset = ansi!
end type

event clicked;call super::clicked;close(parent)
end event

type tab_1 from u_tab_ediprofile within w_ediprofile
integer x = 46
integer y = 116
integer width = 3511
integer height = 1736
integer taborder = 11
end type

type st_1 from statictext within w_ediprofile
integer x = 50
integer y = 36
integer width = 517
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Transaction Set"
boolean focusrectangle = false
end type

