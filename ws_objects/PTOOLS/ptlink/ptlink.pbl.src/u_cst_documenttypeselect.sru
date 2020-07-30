$PBExportHeader$u_cst_documenttypeselect.sru
$PBExportComments$[u_base]
forward
global type u_cst_documenttypeselect from u_base
end type
type dw_documentlist from u_dw_documenttypelist within u_cst_documenttypeselect
end type
end forward

global type u_cst_documenttypeselect from u_base
int Width=1216
int Height=1184
dw_documentlist dw_documentlist
end type
global u_cst_documenttypeselect u_cst_documenttypeselect

forward prototypes
public function integer of_setrowchecked (readonly long al_row, readonly boolean ab_checked)
end prototypes

public function integer of_setrowchecked (readonly long al_row, readonly boolean ab_checked);
Integer  li_checked, &
			li_return 
/// 
If ab_checked Then 
	li_checked = 1
Else
	li_checked = 0
End If

li_return = dw_documentlist.SetItem(al_Row, "typechecked", li_Checked)

Return li_return 
end function

on u_cst_documenttypeselect.create
int iCurrent
call super::create
this.dw_documentlist=create dw_documentlist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_documentlist
end on

on u_cst_documenttypeselect.destroy
call super::destroy
destroy(this.dw_documentlist)
end on

event constructor;call super::constructor;	

// set row selection on List datawindow
dw_documentlist.of_SetRowSelect ( TRUE ) 
dw_documentlist.inv_rowselect.of_SetStyle ( 0 ) 



end event

type dw_documentlist from u_dw_documenttypelist within u_cst_documenttypeselect
int X=18
int Y=24
int Width=1161
int Height=1132
int TabOrder=10
boolean BringToTop=true
end type

