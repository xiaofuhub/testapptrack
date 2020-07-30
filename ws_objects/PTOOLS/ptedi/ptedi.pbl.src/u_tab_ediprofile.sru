$PBExportHeader$u_tab_ediprofile.sru
forward
global type u_tab_ediprofile from u_tab
end type
end forward

global type u_tab_ediprofile from u_tab
integer width = 2482
integer height = 1352
integer textsize = -10
long backcolor = 12632256
end type
global u_tab_ediprofile u_tab_ediprofile

type variables
private:

//u_tabpg_edi iuo_tabpage[]
string		isa_Tabpage[]

u_tabpg_edi_gen iuo_tabpage[]

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
		iuo_tabpage[li_Ctr].of_buildTabPages(anv_msg)
	Next
	this.SelectTab(1)
	
ELSE
	li_ReturnValue = -1
END IF


end subroutine

event constructor;call super::constructor;integer	li_cnt

n_cst_LicenseManager	lnv_LicenseManager
n_cst_setting_edi204version	lnv_204Version
n_cst_setting_editransport		lnv_transportSetting

//lnv_204Version = CREATE n_cst_setting_edi204version

lnv_transportSetting = CREATE n_cst_setting_editransport
/*
// I am going to show this all of the time since we need
// access to the SCAC. I don't have the time to go and figure out
// all of the places the other transaction sets use the 204 SCAC
li_cnt ++
isa_tabpage[li_cnt] = 'u_tabpg_edi_204'


if lnv_LicenseManager.of_HasEDI204License ( ) then	
//	IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct THEN
		li_cnt ++
		isa_tabpage[li_cnt] = 'u_tabpg_edi_990'
		
		li_cnt ++
		isa_tabpage[li_cnt] = 'u_tabpg_edi_997'
//	END IF
	
end if

if lnv_LicenseManager.of_HasEDI210License ( ) then
	li_cnt ++
	isa_tabpage[li_cnt] = 'u_tabpg_edi_210'
end if

if lnv_LicenseManager.of_HasEDI214License ( ) then
	li_cnt ++
	isa_tabpage[li_cnt] = 'u_tabpg_edi_214'
end if

if lnv_LicenseManager.of_HasEDI322License ( ) then
	li_cnt ++
	isa_tabpage[li_cnt] = 'u_tabpg_edi_322'
end if
	
//maybe there is a test here
IF lnv_transportSetting.of_getValue() = "Yes" THEN
	li_cnt++
	isa_tabpage[li_cnt] = 'u_tabpg_edi_transportsettings'
END IF
*/
//ADDED BY DAN for testing 3-5-07

// I am going to show this all of the time since we need
// access to the SCAC. I don't have the time to go and figure out
// all of the places the other transaction sets use the 204 SCAC
li_cnt++
isa_tabpage[li_cnt] = 'u_tabpg_edi_gen_204'

if lnv_LicenseManager.of_HasEDI210License ( ) then
	li_cnt++
	isa_tabpage[li_cnt] = 'u_tabpg_edi_210'
END IF

if lnv_LicenseManager.of_HasEDI214License ( ) then
	li_cnt++
	isa_tabpage[li_cnt] = 'u_tabpg_edi_gen_214'
END IF

if lnv_LicenseManager.of_HasEDI322License ( ) then
	li_cnt++
	isa_tabpage[li_cnt] = 'u_tabpg_edi_322'
END IF

if lnv_LicenseManager.of_HasEDI204License ( ) then	
	li_cnt++
	isa_tabpage[li_cnt] = 'u_tabpg_edi_gen_990'
	
	li_cnt++
	isa_tabpage[li_cnt] = 'u_tabpg_edi_gen_997'
END IF

IF lnv_transportSetting.of_getValue() = "Yes" THEN
	li_cnt++
	isa_tabpage[li_cnt] = 'u_tabpg_edi_transportsettings'
END IF
////////////

DESTROY ( lnv_204Version )
DESTROY lnv_transportSetting 
end event

on u_tab_ediprofile.create
end on

on u_tab_ediprofile.destroy
call super::destroy
end on

