$PBExportHeader$w_loadbuilder.srw
forward
global type w_loadbuilder from w_popup
end type
type uo_loadbuilder from u_cst_loadbuilder within w_loadbuilder
end type
end forward

global type w_loadbuilder from w_popup
integer x = 73
integer y = 348
integer width = 3525
integer height = 1172
string title = "Load Builder"
long backcolor = 12632256
boolean ib_disableclosequery = true
uo_loadbuilder uo_loadbuilder
end type
global w_loadbuilder w_loadbuilder

forward prototypes
public function integer wf_setshipmentlist (long ala_ids[])
public function integer wf_seteventscompleted (long ala_ids[])
public function integer wf_setevents (long ala_ids[])
public function integer wf_setcurrentevent (long al_id)
public function integer wf_setreporttitle (string as_title)
public function integer wf_setdispatchmanager (n_cst_bso_dispatch anv_dispatch)
end prototypes

public function integer wf_setshipmentlist (long ala_ids[]);RETURN uo_LoadBuilder.of_SetShipmentList ( ala_Ids )
end function

public function integer wf_seteventscompleted (long ala_ids[]);RETURN uo_LoadBuilder.of_SetEventsCompleted ( ala_Ids )
end function

public function integer wf_setevents (long ala_ids[]);RETURN uo_LoadBuilder.of_SetEvents ( ala_Ids )
end function

public function integer wf_setcurrentevent (long al_id);RETURN uo_LoadBuilder.of_SetCurrentEvent ( al_Id )
end function

public function integer wf_setreporttitle (string as_title);RETURN uo_LoadBuilder.of_SetReportTitle ( as_Title )
end function

public function integer wf_setdispatchmanager (n_cst_bso_dispatch anv_dispatch);RETURN uo_LoadBuilder.of_SetDispatchManager ( anv_Dispatch )
end function

on w_loadbuilder.create
int iCurrent
call super::create
this.uo_loadbuilder=create uo_loadbuilder
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_loadbuilder
end on

on w_loadbuilder.destroy
call super::destroy
destroy(this.uo_loadbuilder)
end on

event open;call super::open;THIS.of_SetResize ( TRUE )
inv_Resize.of_Register( uo_loadbuilder, inv_Resize.scalerightbottom )
end event

type uo_loadbuilder from u_cst_loadbuilder within w_loadbuilder
integer x = 23
integer y = 28
integer taborder = 1
end type

on uo_loadbuilder.destroy
call u_cst_loadbuilder::destroy
end on

