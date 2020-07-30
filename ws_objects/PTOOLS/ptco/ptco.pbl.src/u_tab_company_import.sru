$PBExportHeader$u_tab_company_import.sru
forward
global type u_tab_company_import from u_tab
end type
type tabpage_summary from u_tabpage_company_import_summary within u_tab_company_import
end type
type tabpage_dupcodenames from u_tabpage_company_import_dupcodenames within u_tab_company_import
end type
type tabpage_locators from u_tabpage_company_import_missinglocators within u_tab_company_import
end type
type tabpage_noid from u_tabpage_company_import_noacctids within u_tab_company_import
end type
type tabpage_successful from u_tabpage_company_import_total within u_tab_company_import
end type
end forward

global type u_tab_company_import from u_tab
int Width=2446
int Height=964
string Tag="tabpage_Total"
boolean BoldSelectedText=true
tabpage_summary tabpage_summary
tabpage_dupcodenames tabpage_dupcodenames
tabpage_locators tabpage_locators
tabpage_noid tabpage_noid
tabpage_successful tabpage_successful
end type
global u_tab_company_import u_tab_company_import

on u_tab_company_import.create
this.tabpage_summary=create tabpage_summary
this.tabpage_dupcodenames=create tabpage_dupcodenames
this.tabpage_locators=create tabpage_locators
this.tabpage_noid=create tabpage_noid
this.tabpage_successful=create tabpage_successful
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_summary
this.Control[iCurrent+2]=this.tabpage_dupcodenames
this.Control[iCurrent+3]=this.tabpage_locators
this.Control[iCurrent+4]=this.tabpage_noid
this.Control[iCurrent+5]=this.tabpage_successful
end on

on u_tab_company_import.destroy
call super::destroy
destroy(this.tabpage_summary)
destroy(this.tabpage_dupcodenames)
destroy(this.tabpage_locators)
destroy(this.tabpage_noid)
destroy(this.tabpage_successful)
end on

type tabpage_summary from u_tabpage_company_import_summary within u_tab_company_import
int X=18
int Y=100
int Width=2409
int Height=848
string Text="Summary"
end type

type tabpage_dupcodenames from u_tabpage_company_import_dupcodenames within u_tab_company_import
int X=18
int Y=100
int Width=2409
int Height=848
string Text="Duplicate Data"
end type

type tabpage_locators from u_tabpage_company_import_missinglocators within u_tab_company_import
int X=18
int Y=100
int Width=2409
int Height=848
string Text="Missing Locators"
end type

type tabpage_noid from u_tabpage_company_import_noacctids within u_tab_company_import
int X=18
int Y=100
int Width=2409
int Height=848
string Text="No Acct. ID"
end type

type tabpage_successful from u_tabpage_company_import_total within u_tab_company_import
int X=18
int Y=100
int Width=2409
int Height=848
string Tag="tabpage_total"
string Text="Successful Imports"
end type

