$PBExportHeader$w_deviceselection.srw
forward
global type w_deviceselection from w_response
end type
type st_1 from statictext within w_deviceselection
end type
type cb_1 from u_cbok within w_deviceselection
end type
type cb_2 from u_cbcancel within w_deviceselection
end type
type dw_device from u_dw_deviceselection within w_deviceselection
end type
end forward

global type w_deviceselection from w_response
int X=1097
int Y=612
int Width=1065
int Height=896
boolean TitleBar=true
string Title="Communication Devices"
st_1 st_1
cb_1 cb_1
cb_2 cb_2
dw_device dw_device
end type
global w_deviceselection w_deviceselection

forward prototypes
private function long wf_getsource (ref datastore ads_Source)
end prototypes

private function long wf_getsource (ref datastore ads_Source);Long	ll_RowCount = -1
DataStore	lds_DeviceSelection

lds_DeviceSelection = Create dataStore
lds_DeviceSelection.DataObject = "d_DeviceSelection"

IF isValid ( lds_DeviceSelection ) THEN
	
	lds_DeviceSelection.SetTransObject ( sqlca )
	lds_DeviceSelection.Retrieve ( )
	ll_RowCount = lds_DeviceSelection.RowCount ( )
END IF

ads_Source = lds_DeviceSelection
RETURN ll_RowCount


end function

on w_deviceselection.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_device=create dw_device
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_device
end on

on w_deviceselection.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_device)
end on

event pfc_default;
Long	ll_Row
String	ls_Device


ll_Row = dw_device.GetRow ( )

IF ll_Row > 0 THEN
	ls_Device = dw_device.GetItemString ( ll_Row , "type" )
	CloseWithReturn ( THIS, ls_Device )
ELSEIF dw_device.RowCount ( ) > 0 THEN
	MessageBox ( "Device Selection" , "Please select a device.")
END IF


end event

event pfc_cancel;call super::pfc_cancel;CLOSE ( THIS )
end event

event open;call super::open;Blob	lblb_State
DataStore	lds_Devices

IF IsValid ( Message.powerobjectParm ) THEN
	lds_Devices = Message.powerobjectParm
ELSE
	THIS.wf_GetSource (lds_Devices )
END IF

lds_Devices.GetFullState (lblb_State )
dw_device.SetFullState ( lblb_State )




end event

type st_1 from statictext within w_deviceselection
int X=32
int Y=32
int Width=942
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="Select a Communication Device"
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from u_cbok within w_deviceselection
int X=247
int Y=672
int TabOrder=20
boolean BringToTop=true
end type

type cb_2 from u_cbcancel within w_deviceselection
int X=539
int Y=672
int TabOrder=30
boolean BringToTop=true
end type

type dw_device from u_dw_deviceselection within w_deviceselection
int X=32
int Y=108
int Width=969
int Height=520
int TabOrder=10
boolean BringToTop=true
string DataObject="d_deviceselection"
end type

event doubleclicked;parent.TriggerEvent("pfc_default")
end event

event constructor;

This.of_SetRowManager ( TRUE )
This.of_SetRowSelect ( TRUE )
This.SetRowFocusIndicator ( FocusRect! )

ib_rmbmenu = FALSE
end event

