$PBExportHeader$u_tabpg_edi_gen.sru
forward
global type u_tabpg_edi_gen from u_tabpg_edi
end type
type tab_1 from u_tab within u_tabpg_edi_gen
end type
type tab_1 from u_tab within u_tabpg_edi_gen
end type
end forward

global type u_tabpg_edi_gen from u_tabpg_edi
integer width = 3488
integer height = 1612
tab_1 tab_1
end type
global u_tabpg_edi_gen u_tabpg_edi_gen

type variables
protected:

u_tabpg_edi iuo_tabpage[]
string		isa_Tabpage[]
end variables

forward prototypes
public function integer of_buildtabpages (n_cst_msg anv_msg)
end prototypes

public function integer of_buildtabpages (n_cst_msg anv_msg);Int li_ReturnValue = 1
Int li_Ctr
Int li_UpperBound
String lsa_TabPage[]

lsa_TabPage = isa_TabPage

li_UpperBound = UpperBound(lsa_TabPage)

IF li_UpperBound > 0 THEN
	For li_Ctr = 1 to li_UpperBound
		tab_1.OpenTabWithParm(iuo_tabpage[li_Ctr],anv_msg,lsa_TabPage[li_Ctr],0)
	Next
	tab_1.SelectTab(1)
	
ELSE
	li_ReturnValue = -1
END IF

RETURN li_ReturnValue

end function

on u_tabpg_edi_gen.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on u_tabpg_edi_gen.destroy
call super::destroy
destroy(this.tab_1)
end on

type dw_profile from u_tabpg_edi`dw_profile within u_tabpg_edi_gen
boolean visible = false
integer x = 23
integer y = 1244
boolean ib_isupdateable = false
end type

type st_title from u_tabpg_edi`st_title within u_tabpg_edi_gen
boolean visible = false
integer x = 142
integer y = 1192
end type

type tab_1 from u_tab within u_tabpg_edi_gen
integer x = 9
integer y = 16
integer width = 3451
integer height = 1564
integer taborder = 10
long backcolor = 12632256
end type

event constructor;call super::constructor;if gnv_App.of_GetrestrictedView ( ) then
   //size ok
else
   this.width = this.width + 700
END IF
end event

