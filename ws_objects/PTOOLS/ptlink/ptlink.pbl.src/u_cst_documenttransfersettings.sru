$PBExportHeader$u_cst_documenttransfersettings.sru
forward
global type u_cst_documenttransfersettings from u_base
end type
type dw_1 from u_dw_companydocumenttransfersettings within u_cst_documenttransfersettings
end type
end forward

global type u_cst_documenttransfersettings from u_base
integer width = 1856
integer height = 924
long backcolor = 12632256
event ue_itemchanged ( )
dw_1 dw_1
end type
global u_cst_documenttransfersettings u_cst_documenttransfersettings

forward prototypes
public function integer of_retrieve (long al_coid)
end prototypes

public function integer of_retrieve (long al_coid);RETURN dw_1.of_Retrieve ( al_coid )
end function

on u_cst_documenttransfersettings.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_cst_documenttransfersettings.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw_companydocumenttransfersettings within u_cst_documenttransfersettings
integer taborder = 10
end type

event itemchanged;call super::itemchanged;Parent.event ue_itemchanged( )
end event

event editchanged;call super::editchanged;Parent.event ue_itemchanged( )

end event

