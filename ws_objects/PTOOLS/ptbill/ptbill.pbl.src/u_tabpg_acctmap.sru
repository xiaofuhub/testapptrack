$PBExportHeader$u_tabpg_acctmap.sru
forward
global type u_tabpg_acctmap from u_tabpg
end type
type dw_acctmap from u_dw_acctmap within u_tabpg_acctmap
end type
end forward

global type u_tabpg_acctmap from u_tabpg
int Width=2880
int Height=1272
event type integer ue_deleterow ( long al_row )
dw_acctmap dw_acctmap
end type
global u_tabpg_acctmap u_tabpg_acctmap

on u_tabpg_acctmap.create
int iCurrent
call super::create
this.dw_acctmap=create dw_acctmap
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_acctmap
end on

on u_tabpg_acctmap.destroy
call super::destroy
destroy(this.dw_acctmap)
end on

event constructor;call super::constructor;//Extending Ancestor

//If the Settlements (Payables) module is not licensed, disable this tabpage.

n_cst_LicenseManager	lnv_LicenseManager

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Settlements ) = TRUE OR &
	lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) = TRUE THEN
	This.Enabled = TRUE
ELSE
	This.Enabled = FALSE
END IF
end event

type dw_acctmap from u_dw_acctmap within u_tabpg_acctmap
int X=9
int Y=12
int Width=2839
int Height=1232
int TabOrder=10
boolean BringToTop=true
end type

event itemerror;call super::itemerror;RETURN AncestorRETURNValue
end event

event ue_deleterow;return parent.event ue_deleterow(al_row)
end event

