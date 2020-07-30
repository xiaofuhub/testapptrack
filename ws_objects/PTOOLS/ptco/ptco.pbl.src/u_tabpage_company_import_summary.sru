$PBExportHeader$u_tabpage_company_import_summary.sru
forward
global type u_tabpage_company_import_summary from u_tabpg
end type
type st_4 from statictext within u_tabpage_company_import_summary
end type
type st_initialcount from statictext within u_tabpage_company_import_summary
end type
type st_nolocators from statictext within u_tabpage_company_import_summary
end type
type st_7 from statictext within u_tabpage_company_import_summary
end type
type st_noids from statictext within u_tabpage_company_import_summary
end type
type st_9 from statictext within u_tabpage_company_import_summary
end type
type st_totalimport from statictext within u_tabpage_company_import_summary
end type
type st_11 from statictext within u_tabpage_company_import_summary
end type
type st_2 from statictext within u_tabpage_company_import_summary
end type
type st_duplicateids from statictext within u_tabpage_company_import_summary
end type
type st_1 from statictext within u_tabpage_company_import_summary
end type
type st_dupcodenames from statictext within u_tabpage_company_import_summary
end type
end forward

global type u_tabpage_company_import_summary from u_tabpg
int Width=2418
int Height=896
st_4 st_4
st_initialcount st_initialcount
st_nolocators st_nolocators
st_7 st_7
st_noids st_noids
st_9 st_9
st_totalimport st_totalimport
st_11 st_11
st_2 st_2
st_duplicateids st_duplicateids
st_1 st_1
st_dupcodenames st_dupcodenames
end type
global u_tabpage_company_import_summary u_tabpage_company_import_summary

on u_tabpage_company_import_summary.create
int iCurrent
call super::create
this.st_4=create st_4
this.st_initialcount=create st_initialcount
this.st_nolocators=create st_nolocators
this.st_7=create st_7
this.st_noids=create st_noids
this.st_9=create st_9
this.st_totalimport=create st_totalimport
this.st_11=create st_11
this.st_2=create st_2
this.st_duplicateids=create st_duplicateids
this.st_1=create st_1
this.st_dupcodenames=create st_dupcodenames
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.st_initialcount
this.Control[iCurrent+3]=this.st_nolocators
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.st_noids
this.Control[iCurrent+6]=this.st_9
this.Control[iCurrent+7]=this.st_totalimport
this.Control[iCurrent+8]=this.st_11
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_duplicateids
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_dupcodenames
end on

on u_tabpage_company_import_summary.destroy
call super::destroy
destroy(this.st_4)
destroy(this.st_initialcount)
destroy(this.st_nolocators)
destroy(this.st_7)
destroy(this.st_noids)
destroy(this.st_9)
destroy(this.st_totalimport)
destroy(this.st_11)
destroy(this.st_2)
destroy(this.st_duplicateids)
destroy(this.st_1)
destroy(this.st_dupcodenames)
end on

type st_4 from statictext within u_tabpage_company_import_summary
int X=192
int Y=88
int Width=1239
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Companies were in the initial import file."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_initialcount from statictext within u_tabpage_company_import_summary
int X=18
int Y=88
int Width=146
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_nolocators from statictext within u_tabpage_company_import_summary
int X=18
int Y=456
int Width=146
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within u_tabpage_company_import_summary
int X=192
int Y=456
int Width=1888
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Companies could not have PC*Miler locators assigned to them."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_noids from statictext within u_tabpage_company_import_summary
int X=18
int Y=568
int Width=146
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within u_tabpage_company_import_summary
int X=192
int Y=568
int Width=1550
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Companies did not have an Accounting ID specified."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_totalimport from statictext within u_tabpage_company_import_summary
int X=18
int Y=724
int Width=146
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within u_tabpage_company_import_summary
int X=192
int Y=724
int Width=1467
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Companies will be added upon saving the import."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_tabpage_company_import_summary
int X=192
int Y=232
int Width=2213
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Companies were not processed because their Accounting ID already exists."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_duplicateids from statictext within u_tabpage_company_import_summary
int X=18
int Y=232
int Width=146
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_tabpage_company_import_summary
int X=192
int Y=344
int Width=2213
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Companies were not processed because their Code Name already exists."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dupcodenames from statictext within u_tabpage_company_import_summary
int X=18
int Y=344
int Width=146
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

