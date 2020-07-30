$PBExportHeader$w_carrierlanesearch.srw
forward
global type w_carrierlanesearch from w_sheet
end type
type uo_search from u_cst_carrierlanesearch within w_carrierlanesearch
end type
type cb_close from u_cbcancel within w_carrierlanesearch
end type
end forward

global type w_carrierlanesearch from w_sheet
int X=329
int Y=112
int Width=3241
int Height=2132
boolean TitleBar=true
string Title="Carrier Lane Search"
long BackColor=80269524
uo_search uo_search
cb_close cb_close
end type
global w_carrierlanesearch w_carrierlanesearch

on w_carrierlanesearch.create
int iCurrent
call super::create
this.uo_search=create uo_search
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_search
this.Control[iCurrent+2]=this.cb_close
end on

on w_carrierlanesearch.destroy
call super::destroy
destroy(this.uo_search)
destroy(this.cb_close)
end on

event open;call super::open;ib_DisableCloseQuery = TRUE

THIS.Width = 3241
THIS.Height = 2132

THIS.of_SetResize ( TRUE ) 
inv_Resize.of_Register ( uo_search , appeon_constant.scalerightbottom )
inv_Resize.of_Register ( cb_close , appeon_constant.fixedbottom )

end event

type uo_search from u_cst_carrierlanesearch within w_carrierlanesearch
int X=0
int Y=0
int TabOrder=10
boolean BringToTop=true
long BackColor=80269524
end type

on uo_search.destroy
call u_cst_carrierlanesearch::destroy
end on

type cb_close from u_cbcancel within w_carrierlanesearch
int X=1385
int Y=1904
int Width=425
int TabOrder=20
boolean BringToTop=true
string Text="Close"
end type

event clicked;call super::clicked;Close ( PARENT )
end event

