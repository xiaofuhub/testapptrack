$PBExportHeader$w_amountowedsearch.srw
forward
global type w_amountowedsearch from w_sheet
end type
type dw_amounts from u_dw within w_amountowedsearch
end type
type cb_reset from commandbutton within w_amountowedsearch
end type
type cb_cancelquerymode from commandbutton within w_amountowedsearch
end type
type cb_retrieve from commandbutton within w_amountowedsearch
end type
type cb_querymode from commandbutton within w_amountowedsearch
end type
end forward

global type w_amountowedsearch from w_sheet
int Width=2501
int Height=1576
boolean TitleBar=true
string Title="Amount Owed Search"
string MenuName="m_sheets"
event type integer ue_setquerymode ( boolean ab_switch )
dw_amounts dw_amounts
cb_reset cb_reset
cb_cancelquerymode cb_cancelquerymode
cb_retrieve cb_retrieve
cb_querymode cb_querymode
end type
global w_amountowedsearch w_amountowedsearch

event ue_setquerymode;//Returns : 1, -1

Integer	li_Return = 1

IF NOT IsNull ( ab_Switch ) THEN

	IF NOT IsNull ( dw_Amounts.inv_QueryMode ) THEN
		cb_QueryMode.Visible = NOT ab_Switch
		cb_Retrieve.Visible = ab_Switch
		IF ab_Switch THEN
			cb_Reset.Text = "R&eset Criteria"
		ELSE
			cb_Reset.Text = "R&eset Data"
		END IF
		cb_CancelQueryMode.Visible = ab_Switch
		dw_Amounts.inv_QueryMode.of_SetEnabled ( ab_Switch )

		IF ab_Switch = TRUE THEN
			dw_Amounts.SetRow ( 99 )
			dw_Amounts.SetRow ( 1 )
		END IF

	ELSE
		li_Return = -1
	END IF

ELSE
	li_Return = -1

END IF

RETURN li_Return
end event

on w_amountowedsearch.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_amounts=create dw_amounts
this.cb_reset=create cb_reset
this.cb_cancelquerymode=create cb_cancelquerymode
this.cb_retrieve=create cb_retrieve
this.cb_querymode=create cb_querymode
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_amounts
this.Control[iCurrent+2]=this.cb_reset
this.Control[iCurrent+3]=this.cb_cancelquerymode
this.Control[iCurrent+4]=this.cb_retrieve
this.Control[iCurrent+5]=this.cb_querymode
end on

on w_amountowedsearch.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_amounts)
destroy(this.cb_reset)
destroy(this.cb_cancelquerymode)
destroy(this.cb_retrieve)
destroy(this.cb_querymode)
end on

event open;call super::open;//The window is not updateable -- disable CloseQuery processing.
ib_DisableCloseQuery = TRUE

gf_Mask_Menu ( m_Sheets )
//wf_CreateToolmenu ( )

This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )

inv_Resize.of_SetMinSize ( 1300, 400 )
inv_Resize.of_Register ( dw_Amounts, 'ScaleToRight&Bottom' )

end event

type dw_amounts from u_dw within w_amountowedsearch
int X=50
int Y=184
int Width=2400
int Height=1212
int TabOrder=10
boolean BringToTop=true
string DataObject="d_amountowedlistwithentity"
boolean HScrollBar=true
boolean HSplitScroll=true
end type

event constructor;String	lsa_QueryColumns[]
n_cst_Presentation_AmountOwed	lnv_Presentation

This.of_SetTransObject ( SQLCA )
lnv_Presentation.of_SetNoProtect ( TRUE )  //Tell presentation object not to
	//protect columns -- we need them editable for query mode.
lnv_Presentation.of_SetPresentation ( THIS )

n_cst_presentation_amounttype lnv_presentationamounttype
lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_payables)
lnv_presentationamounttype.of_setpresentation(this)

This.of_SetQueryMode ( TRUE )
This.inv_QueryMode.of_SetResetCriteria ( FALSE ) //Do not clear criteria between toggles

This.of_SetBase ( TRUE )
inv_Base.of_GetObjects ( lsa_QueryColumns, "column", "detail", TRUE /*Not VisOnly*/ )
This.inv_QueryMode.of_SetQueryCols ( lsa_QueryColumns )

This.of_SetInsertable ( FALSE )
This.of_SetDeleteable ( FALSE )

//This.SetSort ( "company_name A, company_status D" )

This.of_SetAutoFilter ( TRUE )
This.of_SetAutoSort ( TRUE )
This.of_SetAutoFind ( TRUE )
end event

type cb_reset from commandbutton within w_amountowedsearch
int X=782
int Y=52
int Width=681
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="R&eset Data"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF dw_Amounts.Object.DataWindow.QueryMode = "yes" THEN
	dw_Amounts.Object.DataWindow.QueryClear = "yes"
ELSE
	dw_Amounts.Reset ( )
END IF
end event

type cb_cancelquerymode from commandbutton within w_amountowedsearch
int X=1513
int Y=52
int Width=681
int Height=88
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
string Text="&Cancel"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Event ue_SetQueryMode ( FALSE )
end event

type cb_retrieve from commandbutton within w_amountowedsearch
int X=50
int Y=52
int Width=681
int Height=88
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string Text="Sea&rch"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF dw_Amounts.Event pfc_AcceptText ( TRUE /*FocusOnError*/ ) = -1 THEN

ELSE
	Parent.Event ue_SetQueryMode ( FALSE )
	dw_Amounts.Retrieve ( )
END IF
end event

type cb_querymode from commandbutton within w_amountowedsearch
int X=50
int Y=52
int Width=681
int Height=88
int TabOrder=10
boolean BringToTop=true
string Text="Enter Sea&rch Criteria"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Event ue_SetQueryMode ( TRUE )
end event

