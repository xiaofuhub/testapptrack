$PBExportHeader$w_ratetypes.srw
$PBExportComments$RateTypes (Window from PBL map PTSetl) //@(*)[59620730|574]
forward
global type w_ratetypes from w_response
end type
type dw_ratetypelist from u_dw_ratetypelist within w_ratetypes
end type
type cb_cancel from u_cbcancel within w_ratetypes
end type
type cb_ok from u_cbok within w_ratetypes
end type
type mle_1 from u_mle_gridnotice within w_ratetypes
end type
end forward

global type w_ratetypes from w_response
int X=1056
int Y=720
int Width=1495
int Height=1092
boolean TitleBar=true
string Title="RateTypes"
dw_ratetypelist dw_ratetypelist
cb_cancel cb_cancel
cb_ok cb_ok
mle_1 mle_1
end type
global w_ratetypes w_ratetypes

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
end prototypes

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null


Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>

Return 1
//@(text)--

end function

on w_ratetypes.create
int iCurrent
call super::create
this.dw_ratetypelist=create dw_ratetypelist
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.mle_1=create mle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ratetypelist
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.mle_1
end on

on w_ratetypes.destroy
call super::destroy
destroy(this.dw_ratetypelist)
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
inv_Linkage.Retrieve ( dw_RateTypeList )

//@(text)(recreate=yes)<resizevalues>
inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (dw_ratetypelist, 'ScaleToRight')
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

type dw_ratetypelist from u_dw_ratetypelist within w_ratetypes
int X=41
int Y=204
int Width=1394
int TabOrder=10
string Tag=";objectid=[59632351|575]"
boolean BringToTop=true
end type

on dw_ratetypelist.create
call u_dw_ratetypelist::create
end on

on dw_ratetypelist.destroy
call u_dw_ratetypelist::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
//@(data)--

end event

type cb_cancel from u_cbcancel within w_ratetypes
int X=750
int Y=856
int TabOrder=30
end type

on cb_cancel.create
call u_cbcancel::create
end on

on cb_cancel.destroy
call u_cbcancel::destroy
end on

type cb_ok from u_cbok within w_ratetypes
int X=471
int Y=856
int TabOrder=20
end type

on cb_ok.create
call u_cbok::create
end on

on cb_ok.destroy
call u_cbok::destroy
end on

type mle_1 from u_mle_gridnotice within w_ratetypes
int X=41
int Y=56
int TabOrder=0
boolean BringToTop=true
end type

