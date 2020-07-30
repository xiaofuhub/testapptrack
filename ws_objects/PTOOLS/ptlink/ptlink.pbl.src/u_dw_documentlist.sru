$PBExportHeader$u_dw_documentlist.sru
$PBExportComments$[u_dw] Lists Document files found (d_ext_filelist )
forward
global type u_dw_documentlist from u_dw
end type
end forward

global type u_dw_documentlist from u_dw
int Width=1481
string DataObject="d_ext_filelist"
end type
global u_dw_documentlist u_dw_documentlist

event constructor;ib_rmbMenu = FALSE
// set sort service on List datawindow
This.of_SetAutoSort ( TRUE )
This.of_SetSort(TRUE)
This.inv_sort.of_SetColumnHeader(TRUE)
This.inv_sort.of_SetStyle(0)




end event

