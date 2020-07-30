$PBExportHeader$w_beolog.srw
$PBExportComments$BO Logging Services Display window.
forward
global type w_beolog from Window
end type
type cb_refresh from commandbutton within w_beolog
end type
type cb_clear from commandbutton within w_beolog
end type
type dw_log_beo from datawindow within w_beolog
end type
type dw_log_bcm from datawindow within w_beolog
end type
end forward

global type w_beolog from Window
int X=5
int Y=5
int Width=2903
int Height=1745
boolean TitleBar=true
string Title="BO Log"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=minimized!
cb_refresh cb_refresh
cb_clear cb_clear
dw_log_beo dw_log_beo
dw_log_bcm dw_log_bcm
end type
global w_beolog w_beolog

type variables
n_cst_bcmmgr inv_bcmmgr

end variables

forward prototypes
public function integer setbcmmgr (readonly n_cst_bcmmgr anv_bcmmgr)
end prototypes

public function integer setbcmmgr (readonly n_cst_bcmmgr anv_bcmmgr);this.inv_bcmmgr = anv_bcmmgr

return 1

end function

event resize;Long ll_Height

ll_height = (This.WorkSpaceHeight() - dw_log_bcm.y) / 2
dw_log_bcm.Resize(This.WorkSpaceWidth(), ll_height)
dw_log_beo.y = dw_log_bcm.y + ll_height + 1
dw_log_beo.Resize(This.WorkSpaceWidth(), ll_height)

end event

on w_beolog.create
this.cb_refresh=create cb_refresh
this.cb_clear=create cb_clear
this.dw_log_beo=create dw_log_beo
this.dw_log_bcm=create dw_log_bcm
this.Control[]={ this.cb_refresh,&
this.cb_clear,&
this.dw_log_beo,&
this.dw_log_bcm}
end on

on w_beolog.destroy
destroy(this.cb_refresh)
destroy(this.cb_clear)
destroy(this.dw_log_beo)
destroy(this.dw_log_bcm)
end on

event open;cb_refresh.Event Clicked()

end event

type cb_refresh from commandbutton within w_beolog
int X=311
int Width=247
int Height=109
int TabOrder=11
string Text="Refresh"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String ls_data

if IsValid(inv_bcmmgr.inv_beolog) then
	dw_log_bcm.Reset()
	dw_log_beo.Reset()
	inv_bcmmgr.inv_beolog.GetBCMData(ls_data)
	dw_log_bcm.ImportString(ls_data)
	ls_data = ""
	inv_bcmmgr.inv_beolog.GetBEOData(ls_data)
	dw_log_beo.ImportString(ls_data)
	if dw_log_bcm.RowCount() > 0 then
		dw_log_bcm.Event RowFocusChanged(1)
	end if
end if

end event

type cb_clear from commandbutton within w_beolog
int X=19
int Width=247
int Height=109
int TabOrder=10
string Text="Clear"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if IsValid(inv_bcmmgr.inv_beolog) then
	inv_bcmmgr.inv_beolog.clearlog()
end if

end event

type dw_log_beo from datawindow within w_beolog
int Y=561
int Width=1921
int Height=481
int TabOrder=30
string DataObject="d_log_beo"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_log_bcm from datawindow within w_beolog
int Y=113
int Width=1921
int Height=433
int TabOrder=20
string DataObject="d_log_bcm"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;if currentrow > 0 then
	This.SelectRow(0, FALSE)
	This.SelectRow(currentrow, TRUE)
	dw_log_beo.SetFilter("bcm_index=" + String(This.GetItemNumber(currentrow, "index")))
	dw_log_beo.Filter()
end if

end event

