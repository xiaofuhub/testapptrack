$PBExportHeader$u_tabpage_company_import_dupcodenames.sru
forward
global type u_tabpage_company_import_dupcodenames from u_tabpg
end type
type mle_codenamelist from multilineedit within u_tabpage_company_import_dupcodenames
end type
type st_1 from statictext within u_tabpage_company_import_dupcodenames
end type
type st_2 from statictext within u_tabpage_company_import_dupcodenames
end type
type mle_accountingduplist from multilineedit within u_tabpage_company_import_dupcodenames
end type
type st_3 from statictext within u_tabpage_company_import_dupcodenames
end type
end forward

global type u_tabpage_company_import_dupcodenames from u_tabpg
int Width=2427
int Height=824
mle_codenamelist mle_codenamelist
st_1 st_1
st_2 st_2
mle_accountingduplist mle_accountingduplist
st_3 st_3
end type
global u_tabpage_company_import_dupcodenames u_tabpage_company_import_dupcodenames

on u_tabpage_company_import_dupcodenames.create
int iCurrent
call super::create
this.mle_codenamelist=create mle_codenamelist
this.st_1=create st_1
this.st_2=create st_2
this.mle_accountingduplist=create mle_accountingduplist
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_codenamelist
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.mle_accountingduplist
this.Control[iCurrent+5]=this.st_3
end on

on u_tabpage_company_import_dupcodenames.destroy
call super::destroy
destroy(this.mle_codenamelist)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.mle_accountingduplist)
destroy(this.st_3)
end on

type mle_codenamelist from multilineedit within u_tabpage_company_import_dupcodenames
int X=55
int Y=236
int Width=955
int Height=552
int TabOrder=10
boolean BringToTop=true
TextCase TextCase=Upper!
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_tabpage_company_import_dupcodenames
int X=494
int Y=44
int Width=1449
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Companies that were not imported because their "
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

type st_2 from statictext within u_tabpage_company_import_dupcodenames
int X=55
int Y=160
int Width=951
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Code Name already exists"
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

type mle_accountingduplist from multilineedit within u_tabpage_company_import_dupcodenames
int X=1371
int Y=236
int Width=955
int Height=552
int TabOrder=20
boolean BringToTop=true
TextCase TextCase=Upper!
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within u_tabpage_company_import_dupcodenames
int X=1371
int Y=164
int Width=951
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Accounting ID already exists"
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

