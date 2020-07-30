$PBExportHeader$u_dw_equipment.sru
$PBExportComments$Route equipment.
forward
global type u_dw_equipment from u_dw
end type
end forward

global type u_dw_equipment from u_dw
int Width=1833
int Height=552
string DataObject="d_equipmentinfo"
boolean HScrollBar=true
boolean HSplitScroll=true
end type
global u_dw_equipment u_dw_equipment

event constructor;//Instantiate the default row focus indicator
This.Event ue_SetFocusIndicator ( TRUE )
this.SetTransObject(SQLCA)
this.of_SetRowManager ( TRUE ) 

n_cst_Presentation_EquipmentSummary	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )


end event

