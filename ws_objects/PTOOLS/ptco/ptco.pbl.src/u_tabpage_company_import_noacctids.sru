$PBExportHeader$u_tabpage_company_import_noacctids.sru
forward
global type u_tabpage_company_import_noacctids from u_tabpg
end type
type dw_list from u_dw_company_list within u_tabpage_company_import_noacctids
end type
type st_1 from statictext within u_tabpage_company_import_noacctids
end type
type st_doubleclick from statictext within u_tabpage_company_import_noacctids
end type
end forward

global type u_tabpage_company_import_noacctids from u_tabpg
int Width=1989
int Height=1024
dw_list dw_list
st_1 st_1
st_doubleclick st_doubleclick
end type
global u_tabpage_company_import_noacctids u_tabpage_company_import_noacctids

on u_tabpage_company_import_noacctids.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.st_1=create st_1
this.st_doubleclick=create st_doubleclick
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_doubleclick
end on

on u_tabpage_company_import_noacctids.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.st_1)
destroy(this.st_doubleclick)
end on

type dw_list from u_dw_company_list within u_tabpage_company_import_noacctids
int X=50
int Y=184
int Height=652
int TabOrder=10
boolean BringToTop=true
end type

type st_1 from statictext within u_tabpage_company_import_noacctids
int X=334
int Y=32
int Width=1413
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Companies Without Specified Accounting IDs"
boolean FocusRectangle=false
long TextColor=128
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_doubleclick from statictext within u_tabpage_company_import_noacctids
int X=622
int Y=100
int Width=718
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="(double-click for details)"
boolean FocusRectangle=false
long TextColor=128
long BackColor=67108864
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

