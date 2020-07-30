$PBExportHeader$w_itin_diag.srw
forward
global type w_itin_diag from Window
end type
type cb_4 from commandbutton within w_itin_diag
end type
type st_delete from statictext within w_itin_diag
end type
type st_filter from statictext within w_itin_diag
end type
type st_primary from statictext within w_itin_diag
end type
type cb_3 from commandbutton within w_itin_diag
end type
type cb_2 from commandbutton within w_itin_diag
end type
type cbx_delete from checkbox within w_itin_diag
end type
type cbx_filter from checkbox within w_itin_diag
end type
type cbx_primary from checkbox within w_itin_diag
end type
type cb_1 from commandbutton within w_itin_diag
end type
type dw_list from datawindow within w_itin_diag
end type
end forward

global type w_itin_diag from Window
int X=161
int Y=601
int Width=3347
int Height=1265
boolean TitleBar=true
string Title="Itinerary Diagnostics"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_4 cb_4
st_delete st_delete
st_filter st_filter
st_primary st_primary
cb_3 cb_3
cb_2 cb_2
cbx_delete cbx_delete
cbx_filter cbx_filter
cbx_primary cbx_primary
cb_1 cb_1
dw_list dw_list
end type
global w_itin_diag w_itin_diag

type variables
protected:
datawindow dw_source
datastore ds_source
long bufrows[3]
end variables

event open;choose case message.powerobjectparm.typeof()
	case datawindow!
		dw_source = message.powerobjectparm
		bufrows[1] = dw_source.rowcount()
		bufrows[2] = dw_source.filteredcount()
		bufrows[3] = dw_source.deletedcount()
	case datastore!
		ds_source = message.powerobjectparm
		bufrows[1] = ds_source.rowcount()
		bufrows[2] = ds_source.filteredcount()
		bufrows[3] = ds_source.deletedcount()
end choose

st_primary.text = string(bufrows[1])
st_filter.text = string(bufrows[2])
st_delete.text = string(bufrows[3])
end event

on w_itin_diag.create
this.cb_4=create cb_4
this.st_delete=create st_delete
this.st_filter=create st_filter
this.st_primary=create st_primary
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cbx_delete=create cbx_delete
this.cbx_filter=create cbx_filter
this.cbx_primary=create cbx_primary
this.cb_1=create cb_1
this.dw_list=create dw_list
this.Control[]={ this.cb_4,&
this.st_delete,&
this.st_filter,&
this.st_primary,&
this.cb_3,&
this.cb_2,&
this.cbx_delete,&
this.cbx_filter,&
this.cbx_primary,&
this.cb_1,&
this.dw_list}
end on

on w_itin_diag.destroy
destroy(this.cb_4)
destroy(this.st_delete)
destroy(this.st_filter)
destroy(this.st_primary)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cbx_delete)
destroy(this.cbx_filter)
destroy(this.cbx_primary)
destroy(this.cb_1)
destroy(this.dw_list)
end on

type cb_4 from commandbutton within w_itin_diag
int X=993
int Y=185
int Width=330
int Height=89
int TabOrder=1
string Text="Special"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;this.text = string(dw_list.find("de_arrdate = 1997-03-19", 1, dw_list.rowcount()))
end event

type st_delete from statictext within w_itin_diag
int X=46
int Y=221
int Width=115
int Height=77
boolean Enabled=false
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_filter from statictext within w_itin_diag
int X=46
int Y=133
int Width=115
int Height=77
boolean Enabled=false
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_primary from statictext within w_itin_diag
int X=46
int Y=45
int Width=115
int Height=77
boolean Enabled=false
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_itin_diag
int X=993
int Y=57
int Width=330
int Height=89
string Text="Reset"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_list.reset()
end event

type cb_2 from commandbutton within w_itin_diag
int X=590
int Y=185
int Width=330
int Height=89
string Text="RowsSync"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_delete from checkbox within w_itin_diag
int X=220
int Y=213
int Width=252
int Height=77
string Text="Delete"
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_filter from checkbox within w_itin_diag
int X=220
int Y=125
int Width=247
int Height=77
string Text="Filter"
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_primary from checkbox within w_itin_diag
int X=220
int Y=37
int Width=289
int Height=77
string Text="Primary"
boolean Checked=true
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_itin_diag
int X=590
int Y=57
int Width=330
int Height=89
string Text="RowsCopy"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if isvalid(dw_source) then
	if cbx_primary.checked and bufrows[1] > 0 then
		dw_source.rowscopy(1, bufrows[1], primary!, dw_list, dw_list.rowcount() + 1, primary!)
	end if
	if cbx_filter.checked and bufrows[2] > 0 then
		dw_source.rowscopy(1, bufrows[2], filter!, dw_list, dw_list.rowcount() + 1, primary!)
	end if
	if cbx_delete.checked and bufrows[3] > 0 then
		dw_source.rowscopy(1, bufrows[3], delete!, dw_list, dw_list.rowcount() + 1, primary!)
	end if
elseif isvalid(ds_source) then
	if cbx_primary.checked and bufrows[1] > 0 then
		ds_source.rowscopy(1, bufrows[1], primary!, dw_list, dw_list.rowcount() + 1, primary!)
	end if
	if cbx_filter.checked and bufrows[2] > 0 then
		ds_source.rowscopy(1, bufrows[2], filter!, dw_list, dw_list.rowcount() + 1, primary!)
	end if
	if cbx_delete.checked and bufrows[3] > 0 then
		ds_source.rowscopy(1, bufrows[3], delete!, dw_list, dw_list.rowcount() + 1, primary!)
	end if
end if
end event

type dw_list from datawindow within w_itin_diag
int X=33
int Y=361
int Width=3251
int Height=769
string DataObject="d_itin_diag"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

