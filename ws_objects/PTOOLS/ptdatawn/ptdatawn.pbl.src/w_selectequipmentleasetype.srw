$PBExportHeader$w_selectequipmentleasetype.srw
$PBExportComments$SelectEquipmentLeaseType (Window from PBL map PTData) //@(*)[49928084|981]
forward
global type w_selectequipmentleasetype from w_response
end type
type dw_equipmentleasetypelist from u_dw_equipmentleasetypelist within w_selectequipmentleasetype
end type
type cb_cancel from u_cbcancel within w_selectequipmentleasetype
end type
type cb_ok from u_cbok within w_selectequipmentleasetype
end type
end forward

global type w_selectequipmentleasetype from w_response
int X=27
int Y=224
int Width=3607
int Height=2056
boolean TitleBar=true
string Title="Select Equipment Lease Type"
dw_equipmentleasetypelist dw_equipmentleasetypelist
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_selectequipmentleasetype w_selectequipmentleasetype

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

on w_selectequipmentleasetype.create
int iCurrent
call super::create
this.dw_equipmentleasetypelist=create dw_equipmentleasetypelist
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_equipmentleasetypelist
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
end on

on w_selectequipmentleasetype.destroy
call super::destroy
destroy(this.dw_equipmentleasetypelist)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;call super::open;//@(data)(recreate=yes)<Parameters>
//@(data)--

//@(data)(recreate=yes)<Links>
Setlinkage(TRUE)
//@(data)--

//@(data)(recreate=yes)<GenerationOptions>
of_SetResize(TRUE)
SetTransactionManagement(TRUE)
//@(data)--

//@(text)(recreate=yes)<RetrieveNoArgs>

//@(text)--

inv_Linkage.Retrieve ( dw_EquipmentLeaseTypeList )

//@(text)(recreate=yes)<resizevalues>
inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (dw_equipmentleasetypelist, 'ScaleToRight')
//@(text)--

end event

event pfc_default;n_cst_beo_EquipmentLeaseType	lnv_EquipmentLeaseType

Long		ll_Row

if isValid(this) then 
   if this.Event pfc_Save() >= 0 then
      this.Event task_SetOutputParameters()
		ll_Row = dw_equipmentleasetypelist.getRow()
		lnv_EquipmentLeaseType = dw_equipmentleasetypelist.inv_UILink.GetBeo ( ll_Row )

   	 CloseWithReturn(this, lnv_EquipmentLeaseType)
   end if
end if


end event

event pfc_cancel;call super::pfc_cancel;Close(this)
end event

event task_setinputparameters;//@(+)(recreate=opt)<ValueMaps-SelectLeaseType>
Choose Case an_navigation.GetName()
Case "EquipmentLeaseTypes to Exit1"
//@(data)(recreate=yes)<EquipmentLeaseTypes to Exit1>
an_navigation.inv_parameters.NewMap("In")
an_navigation.inv_parameters.SetSourceControl(dw_equipmentleasetypelist)
an_navigation.inv_parameters.SetMapItem("n_cst_beo_equipmentleasetype", "BEO", "EquipmentLeaseType", "Parameter")
//@(data)--

//@(text)(recreate=no)<EquipmentLeaseTypes to Exit1 User Code>

//@(text)--
End Choose
//@(+)--

return 1
end event

type dw_equipmentleasetypelist from u_dw_equipmentleasetypelist within w_selectequipmentleasetype
int X=41
int Y=36
int Width=3502
int Height=1744
string Tag=";objectid=[49986039|983]"
boolean BringToTop=true
end type

on dw_equipmentleasetypelist.create
call u_dw_equipmentleasetypelist::create
end on

on dw_equipmentleasetypelist.destroy
call u_dw_equipmentleasetypelist::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
//@(data)--

This.SetUseTaskRetrieve ( TRUE )
This.of_SetInsertable ( FALSE )
This.of_SetDeleteable ( FALSE )
This.of_SetUpdateable ( FALSE )

This.of_SetAutoFind ( FALSE )  //Find hangs from response windows
end event

event doubleclicked;IF Row > 0 THEN
	Parent.TriggerEvent ( "pfc_default" )
END IF
end event

type cb_cancel from u_cbcancel within w_selectequipmentleasetype
int X=1723
int Y=1828
int Width=352
end type

on cb_cancel.create
call u_cbcancel::create
end on

on cb_cancel.destroy
call u_cbcancel::destroy
end on

type cb_ok from u_cbok within w_selectequipmentleasetype
int X=1312
int Y=1828
int Width=352
end type

on cb_ok.create
call u_cbok::create
end on

on cb_ok.destroy
call u_cbok::destroy
end on

