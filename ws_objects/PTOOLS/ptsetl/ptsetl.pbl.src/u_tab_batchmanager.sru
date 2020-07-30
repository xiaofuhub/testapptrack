$PBExportHeader$u_tab_batchmanager.sru
$PBExportComments$TransactionManager (Tab Control from PBL map PTSetl) //@(*)[78612670|1555]
forward
global type u_tab_batchmanager from u_tab
end type
type tabpage_1 from u_tabpage_driversettlementlist within u_tab_batchmanager
end type
type tabpage_1 from u_tabpage_driversettlementlist within u_tab_batchmanager
end type
end forward

global type u_tab_batchmanager from u_tab
integer width = 3525
integer height = 1468
long backcolor = 12632256
tabpage_1 tabpage_1
event ue_statuschanged ( readonly long al_row )
event type integer ue_dwenabled ( readonly boolean ab_enable )
event type n_cst_bso_transactionmanager ue_gettransactionmanager ( )
event ue_divisionchanged ( long al_value )
event ue_entitychanged ( n_cst_beo_transaction anv_transaction )
event ue_setfocus ( )
event ue_setunassigned ( )
end type
global u_tab_batchmanager u_tab_batchmanager

event ue_dwenabled;

Integer li_Return 

li_Return = tabpage_1.Event ue_dwenabled(ab_enable)

Return li_Return 
end event

event ue_divisionchanged(long al_value);tabpage_1.event ue_divisionchanged(al_value)
end event

event ue_setfocus();tabpage_1.event ue_setfocus()

end event

event ue_setunassigned();tabpage_1.Event ue_SetUnassigned()
end event

on u_tab_batchmanager.create
this.tabpage_1=create tabpage_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
end on

on u_tab_batchmanager.destroy
call super::destroy
destroy(this.tabpage_1)
end on

event constructor;This.of_SetResize ( TRUE )

inv_Resize.of_SetMinSize ( 3525, 1468)

//Register Resizable controls
inv_Resize.of_Register ( tabpage_1, 'ScaleToRight&Bottom' )

end event

type tabpage_1 from u_tabpage_driversettlementlist within u_tab_batchmanager
integer x = 18
integer y = 100
integer width = 3488
integer height = 1352
integer taborder = 1
string text = "Batch:     Date:     Driver Type:     Start Date:     End Date:"
long tabbackcolor = 12632256
end type

event ue_statuschanged;parent.event ue_statuschanged(al_row)
end event

event ue_gettransactionmanager;return parent.event ue_gettransactionmanager()
end event

event ue_entitychanged;call super::ue_entitychanged;parent.event ue_entitychanged(lnv_transaction)
end event

