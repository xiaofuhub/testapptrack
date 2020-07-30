$PBExportHeader$u_dw_billingimages.sru
forward
global type u_dw_billingimages from u_dw
end type
end forward

global type u_dw_billingimages from u_dw
int Width=1339
int Height=400
string DataObject="d_billingimages"
end type
global u_dw_billingimages u_dw_billingimages

event constructor;ib_rmbmenu = TRUE
of_SetAutoSort ( TRUE )
end event

