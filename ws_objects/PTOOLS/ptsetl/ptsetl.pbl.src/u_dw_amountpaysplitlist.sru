$PBExportHeader$u_dw_amountpaysplitlist.sru
forward
global type u_dw_amountpaysplitlist from u_dw
end type
end forward

global type u_dw_amountpaysplitlist from u_dw
int Width=1129
int Height=368
string DataObject="d_amountpaysplitlist"
end type
global u_dw_amountpaysplitlist u_dw_amountpaysplitlist

event constructor;// enable multi-row-select-ability
//THIS.of_SetRowSelect ( TRUE ) 
//inv_rowselect.of_SetStyle (2) //2 = extended row select service

of_setinsertable ( FALSE )
of_setDeleteable ( FALSE )

of_SetAutoSort ( FALSE )

this.SetTransObject(SQLCA)

n_cst_Presentation_amountOwed	lnv_Presentation

lnv_Presentation.of_SetPresentation ( THIS )
end event

