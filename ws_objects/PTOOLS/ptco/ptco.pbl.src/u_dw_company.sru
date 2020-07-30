$PBExportHeader$u_dw_company.sru
$PBExportComments$Route company.
forward
global type u_dw_company from u_dw
end type
end forward

global type u_dw_company from u_dw
int Width=1737
int Height=432
string DataObject="d_companyinfo"
end type
global u_dw_company u_dw_company

event constructor;//Instantiate the default row focus indicator
This.Event ue_SetFocusIndicator ( TRUE )
this.SetTransObject(SQLCA)
this.of_SetRowManager ( TRUE ) 



end event

