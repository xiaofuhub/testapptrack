$PBExportHeader$u_tab_edilog.sru
forward
global type u_tab_edilog from u_tab
end type
end forward

global type u_tab_edilog from u_tab
integer width = 3442
integer height = 1724
long backcolor = 12632256
end type
global u_tab_edilog u_tab_edilog

type variables
private:

u_tabpg_edilog iuo_tabpage[]
string		isa_tabpage[]
end variables

forward prototypes
public subroutine of_buildtabpages (n_cst_msg anv_msg)
end prototypes

public subroutine of_buildtabpages (n_cst_msg anv_msg);Int li_ReturnValue = 1
Int li_Ctr
Int li_UpperBound
String lsa_TabPage[]

lsa_TabPage = isa_TabPage

li_UpperBound = UpperBound(lsa_TabPage)

IF li_UpperBound > 0 THEN
	For li_Ctr = 1 to li_UpperBound
		this.OpenTabWithParm(iuo_tabpage[li_Ctr],anv_msg,lsa_TabPage[li_Ctr],0)
	Next
	this.SelectTab(1)
	
ELSE
	li_ReturnValue = -1
END IF


end subroutine

event constructor;call super::constructor;integer	li_cnt

n_cst_LicenseManager	lnv_LicenseManager

if lnv_LicenseManager.of_HasEDI204License ( ) then
	li_cnt ++
	isa_tabpage[li_cnt] = 'u_tabpg_edilog_204'
end if

if lnv_LicenseManager.of_HasEDI210License ( ) then
	li_cnt ++
	isa_tabpage[li_cnt] = 'u_tabpg_edilog_210'
end if

if lnv_LicenseManager.of_HasEDI214License ( ) then
	li_cnt ++
	isa_tabpage[li_cnt] = 'u_tabpg_edilog_214'
end if

//not set up yet
//if lnv_LicenseManager.of_HasEDI322License ( ) then
//	li_cnt ++
//	isa_tabpage[li_cnt] = 'u_tabpg_edilog_322'
//end if

li_cnt ++
isa_tabpage[li_cnt] = 'u_tabpg_edilog_Pending'

end event

