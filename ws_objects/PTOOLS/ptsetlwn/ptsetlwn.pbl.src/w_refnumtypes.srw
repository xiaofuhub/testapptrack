$PBExportHeader$w_refnumtypes.srw
$PBExportComments$RefnumTypes (Window from PBL map PTSetl) //@(*)[73264606|669]
forward
global type w_refnumtypes from w_response
end type
type dw_refnumtypelist from u_dw_refnumtypelist within w_refnumtypes
end type
type cb_cancel from u_cbcancel within w_refnumtypes
end type
type cb_ok from u_cbok within w_refnumtypes
end type
type mle_1 from u_mle_gridnotice within w_refnumtypes
end type
end forward

global type w_refnumtypes from w_response
integer x = 1056
integer y = 720
integer width = 1495
integer height = 1092
string title = "Reference Number Types"
dw_refnumtypelist dw_refnumtypelist
cb_cancel cb_cancel
cb_ok cb_ok
mle_1 mle_1
end type
global w_refnumtypes w_refnumtypes

forward prototypes
public function any gettaskattribute (string as_name)
public function integer settaskattribute (string as_name, n_cst_parameters anv_parameters)
end prototypes

public function any gettaskattribute (string as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null


Return la_null
//@(text)--



//begin comment by appeon 20070727
//any x; return x
//end comment by appeon 20070727
//@(-)--

end function

public function integer settaskattribute (string as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>

Return 1
//@(text)--
//begin comment by appeon 20070727
//@(-)
//integer x; return x
//end comment by appeon 20070727
//@(-)--

end function

on w_refnumtypes.create
int iCurrent
call super::create
this.dw_refnumtypelist=create dw_refnumtypelist
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.mle_1=create mle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_refnumtypelist
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.mle_1
end on

on w_refnumtypes.destroy
call super::destroy
destroy(this.dw_refnumtypelist)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.mle_1)
end on

event open;call super::open;//@(data)(recreate=yes)<Parameters>
//@(data)--

//@(data)(recreate=yes)<Links>
Setlinkage(TRUE)
//@(data)--

//@(data)(recreate=yes)<GenerationOptions>
of_SetResize(TRUE)
SetTransactionManagement(TRUE)
inv_txsrv.SetLoadUpdateList(TRUE)
//@(data)--

//@(text)(recreate=yes)<RetrieveNoArgs>

//@(text)--
inv_Linkage.Retrieve ( dw_RefnumTypeList )

//@(text)(recreate=yes)<resizevalues>
inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (dw_refnumtypelist, 'ScaleToRight')
//@(text)--

end event

event pfc_default;call super::pfc_default;if isValid(this) then 
   if this.Event pfc_Save() >= 0 then
      this.Event task_SetOutputParameters()
      Close(this)
   end if
end if
end event

event pfc_cancel;call super::pfc_cancel;Close(this)
end event

event task_setinputparameters;call super::task_setinputparameters;//@(+)(recreate=opt)<ValueMaps-EditRefnumTypes>
Choose Case an_navigation.GetName()
Case "RefnumTypes to Exit1"
//@(data)(recreate=yes)<RefnumTypes to Exit1>
//@(data)--

//@(text)(recreate=no)<RefnumTypes to Exit1 User Code>

//@(text)--
End Choose
//@(+)--

return 1
end event

type cb_help from w_response`cb_help within w_refnumtypes
end type

type dw_refnumtypelist from u_dw_refnumtypelist within w_refnumtypes
string tag = ";objectid=[73344906|670]"
integer x = 41
integer y = 204
integer width = 1394
integer taborder = 10
end type

on dw_refnumtypelist.create
call u_dw_refnumtypelist::create
end on

on dw_refnumtypelist.destroy
call u_dw_refnumtypelist::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
//@(data)--

end event

type cb_cancel from u_cbcancel within w_refnumtypes
integer x = 750
integer y = 856
integer width = 233
integer taborder = 20
end type

on cb_cancel.create
call u_cbcancel::create
end on

on cb_cancel.destroy
call u_cbcancel::destroy
end on

type cb_ok from u_cbok within w_refnumtypes
integer x = 471
integer y = 856
integer width = 233
integer taborder = 30
end type

on cb_ok.create
call u_cbok::create
end on

on cb_ok.destroy
call u_cbok::destroy
end on

type mle_1 from u_mle_gridnotice within w_refnumtypes
integer x = 41
integer y = 56
integer taborder = 10
boolean bringtotop = true
end type

