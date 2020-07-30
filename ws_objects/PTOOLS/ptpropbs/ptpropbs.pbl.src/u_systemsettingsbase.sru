$PBExportHeader$u_systemsettingsbase.sru
$PBExportComments$On this userobject which is inherited from u_base, we will drop the setiings userobject with pictures & the tab object
forward
global type u_systemsettingsbase from u_base
end type
type tab_properties from u_tab within u_systemsettingsbase
end type
type tab_properties from u_tab within u_systemsettingsbase
end type
type plb_1 from u_systemsettingscategorylistings within u_systemsettingsbase
end type
end forward

global type u_systemsettingsbase from u_base
integer width = 2720
integer height = 1736
event type integer ue_validatecontrols ( )
tab_properties tab_properties
plb_1 plb_1
end type
global u_systemsettingsbase u_systemsettingsbase

type variables
u_tabpg_prprties iuo_tabpage[]

Int ii_LastSelectedTab
end variables

forward prototypes
public function integer of_buildtabpages (n_cst_settingscategory anv_category)
public function integer of_destroytabpages ()
end prototypes

event type integer ue_validatecontrols();Int li_Ctr
Int li_RtnVal = 0
Long ll_UpperBound

IF iuo_tabpage[tab_properties.Selectedtab].of_ValidateControls() = -1 THEN
	li_RtnVal = -1
END IF	

Return li_RtnVal
end event

public function integer of_buildtabpages (n_cst_settingscategory anv_category);Int li_ReturnValue = 1
Int li_Ctr
Int li_UpperBound
String lsa_TabPages[]
anv_category.of_GetTabPages(lsa_TabPages[])

li_UpperBound = UpperBound(lsa_TabPages)

IF li_UpperBound > 0 THEN
	For li_Ctr = 1 to li_UpperBound
		tab_Properties.OpenTabWithParm(iuo_tabpage[li_Ctr],'',lsa_TabPages[li_Ctr],0)
	Next
	Tab_Properties.SelectTab(1)
	//Tab_Properties.SelectTab(ii_LastSelectedTab)
	
ELSE
	li_ReturnValue = -1
END IF

Return li_ReturnValue

end function

public function integer of_destroytabpages ();//close any previously created pages
Int li_ReturnValue = 1
Int li_Tab
Int li_tabcount

li_tabcount = upperbound(iuo_tabpage)
for li_tab = 1 to li_tabcount
	tab_properties.CloseTab ( iuo_tabpage[li_tab] )
next
 
Return li_ReturnValue
end function

on u_systemsettingsbase.create
int iCurrent
call super::create
this.tab_properties=create tab_properties
this.plb_1=create plb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_properties
this.Control[iCurrent+2]=this.plb_1
end on

on u_systemsettingsbase.destroy
call super::destroy
destroy(this.tab_properties)
destroy(this.plb_1)
end on

type tab_properties from u_tab within u_systemsettingsbase
integer x = 709
integer y = 20
integer width = 1998
integer height = 1708
integer taborder = 20
boolean multiline = true
end type

event selectionchanging;call super::selectionchanging;//0  Allow the selection to change
//1  Prevent the selection from changing

Long ll_SelChange

ll_SelChange = AncestorReturnValue

IF oldindex > 0 THEN 
	IF iuo_tabpage[oldindex].of_ValidateControls() = -1 THEN
		ll_SelChange = 1
	END IF
END IF	

Return ll_SelChange
end event

type plb_1 from u_systemsettingscategorylistings within u_systemsettingsbase
integer x = 5
integer y = 28
integer width = 695
integer height = 1700
integer taborder = 10
end type

event ue_categorychanged;call super::ue_categorychanged;//ii_LastSelectedTab = tab_properties.SelectedTab

IF UpperBound(iuo_tabpage) > 0 THEN 
	IF iuo_tabpage[tab_properties.SelectedTab].of_ValidateControls() <> -1 THEN
		of_destroytabpages( )
		of_buildtabpages(anv_category)
	END IF	
ELSE	
	of_destroytabpages( )
	of_buildtabpages(anv_category)
END IF
end event

