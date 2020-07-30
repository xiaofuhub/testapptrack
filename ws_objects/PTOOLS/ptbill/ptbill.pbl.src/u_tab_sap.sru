$PBExportHeader$u_tab_sap.sru
forward
global type u_tab_sap from u_tab
end type
type tabpage_dh from u_tabpg_sap within u_tab_sap
end type
type tabpage_dh from u_tabpg_sap within u_tab_sap
end type
type tabpage_dld from u_tabpg_sap within u_tab_sap
end type
type tabpage_dld from u_tabpg_sap within u_tab_sap
end type
type tabpage_dls from u_tabpg_sap within u_tab_sap
end type
type tabpage_dls from u_tabpg_sap within u_tab_sap
end type
end forward

global type u_tab_sap from u_tab
integer width = 1856
integer height = 1552
long backcolor = 12632256
tabpage_dh tabpage_dh
tabpage_dld tabpage_dld
tabpage_dls tabpage_dls
event ue_itemchanged ( )
end type
global u_tab_sap u_tab_sap

on u_tab_sap.create
this.tabpage_dh=create tabpage_dh
this.tabpage_dld=create tabpage_dld
this.tabpage_dls=create tabpage_dls
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_dh
this.Control[iCurrent+2]=this.tabpage_dld
this.Control[iCurrent+3]=this.tabpage_dls
end on

on u_tab_sap.destroy
call super::destroy
destroy(this.tabpage_dh)
destroy(this.tabpage_dld)
destroy(this.tabpage_dls)
end on

type tabpage_dh from u_tabpg_sap within u_tab_sap
integer x = 18
integer y = 100
integer width = 1819
string text = "DH"
end type

event constructor;call super::constructor;n_cst_Presentation_Sap	lnv_Pres
lnv_Pres.of_SetPresentation(dw_metadata)

dw_metadata.SetFilter("line_type = 'DH' AND field_status <> 'S' AND field_status <> 'F'")
dw_metadata.Filter()

dw_metadata.SetSort("field_num A")
dw_metadata.Sort()

end event

event ue_itemchanged;call super::ue_itemchanged;Parent.Event ue_ItemChanged()
end event

event pfc_updateprep;call super::pfc_updateprep;Integer	li_Return
li_Return = AncestorReturnValue

IF AncestorReturnValue = -1 THEN
	Parent.Selecttab(This)
END IF

Return li_Return
end event

type tabpage_dld from u_tabpg_sap within u_tab_sap
integer x = 18
integer y = 100
integer width = 1819
string text = "DL Customer"
end type

event constructor;call super::constructor;n_cst_Presentation_Sap	lnv_Pres
lnv_Pres.of_SetPresentation(dw_metadata)

dw_metadata.SetFilter("line_type = 'DLD' AND field_status <> 'S' AND field_status <> 'F'")
dw_metadata.Filter()
dw_metadata.SetSort("field_num A")
dw_metadata.Sort()
end event

event ue_itemchanged;call super::ue_itemchanged;Parent.Event ue_ItemChanged()
end event

event pfc_updateprep;call super::pfc_updateprep;Integer	li_Return
li_Return = AncestorReturnValue

IF AncestorReturnValue = -1 THEN
	Parent.Selecttab(This)
END IF

Return li_Return
end event

type tabpage_dls from u_tabpg_sap within u_tab_sap
integer x = 18
integer y = 100
integer width = 1819
string text = "DL GL"
end type

event constructor;call super::constructor;n_cst_Presentation_Sap	lnv_Pres
lnv_Pres.of_SetPresentation(dw_metadata)

dw_metadata.SetFilter("line_type = 'DLS' AND field_status <> 'S' AND field_status <> 'F'")
dw_metadata.Filter()
dw_metadata.SetSort("field_num A")
dw_metadata.Sort()
end event

event ue_itemchanged;call super::ue_itemchanged;Parent.Event ue_ItemChanged()
end event

event pfc_updateprep;call super::pfc_updateprep;Integer	li_Return
li_Return = AncestorReturnValue

IF AncestorReturnValue = -1 THEN
	Parent.Selecttab(This)
END IF

Return li_Return
end event

