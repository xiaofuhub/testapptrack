$PBExportHeader$w_company_import_result.srw
forward
global type w_company_import_result from w_popup
end type
type tab_importresults from u_tab_company_import within w_company_import_result
end type
type cb_close from commandbutton within w_company_import_result
end type
type cb_update from commandbutton within w_company_import_result
end type
type st_1 from statictext within w_company_import_result
end type
type tab_importresults from u_tab_company_import within w_company_import_result
end type
end forward

global type w_company_import_result from w_popup
int X=590
int Y=512
int Width=2478
int Height=1380
boolean TitleBar=true
string Title="Company Import Results"
boolean MaxBox=false
boolean Resizable=false
event ue_updatedata ( )
tab_importresults tab_importresults
cb_close cb_close
cb_update cb_update
st_1 st_1
end type
global w_company_import_result w_company_import_result

type variables
Private:
long	ila_totalids[]
Long	ila_NoLocs[]

n_cst_import_companies	inv_Co_Import
end variables

forward prototypes
public function integer wf_populatedisplay ()
end prototypes

event ue_updatedata;IF isValid (inv_co_import) THEN
	CHOOSE CASE inv_co_import.of_UpdateTable ( ) 
		CASE 1 	
			tab_importresults.tabpage_NoID.st_DoubleClick.Visible = TRUE		
			tab_importresults.tabpage_successful.st_DoubleClick.Visible = TRUE
			tab_importresults.tabpage_locators.st_DoubleClick.Visible = TRUE
				
			tab_importresults.tabpage_locators.dw_list.ib_allowDoubleClick = TRUE
			tab_importresults.tabpage_successful.dw_list.ib_allowDoubleClick = TRUE
			tab_importresults.tabpage_NoID.dw_list.ib_allowDoubleClick = TRUE
				
			cb_update.Enabled = FALSE
			
		CASE 0
			MessageBox("Save of Import", "There were no rows in the imort to save." )
		CASE ELSE
			MessageBox("Save of Import", "The imported file could not be saved. Process stopped." )
			
	END CHOOSE
	
ELSE
	MessageBox("Save of Import", "The imported file could not be saved. Process canceled." )
	cb_update.Enabled = FALSE
END IF
end event

public function integer wf_populatedisplay ();Blob	lblb_State

String	ls_NoIDFilter = "IsNull ( co_bill_acctcode )"
String	ls_NoLocatorFilter = "IsNull ( co_pcm ) OR Len ( Trim ( co_pcm ) ) = 0"

DataStore lds_Display

IF IsValid ( inv_co_import ) THEN
		
	lds_Display = inv_Co_Import.of_GetDisplayData ( )
	
	IF isValid ( lds_Display ) THEN
		
		 lds_Display.GetFullState ( lblb_State )
		 tab_importresults.tabpage_NoID.dw_list.SetFullState( lblb_State )
		 tab_importresults.tabpage_NoID.dw_list.SetFilter ( ls_NoIDFilter )
		 tab_importresults.tabpage_NoID.dw_list.Filter ( )
		 
		 tab_importresults.tabpage_locators.dw_list.SetFullState( lblb_State )
		 tab_importresults.tabpage_locators.dw_list.SetFilter ( ls_NoLocatorFilter )
		 tab_importresults.tabpage_locators.dw_list.Filter ( )
		 
		 tab_importresults.tabpage_successful.dw_list.SetFullState( lblb_State )
	END IF
	
END IF

RETURN 1
		
	
end function

on w_company_import_result.create
int iCurrent
call super::create
this.tab_importresults=create tab_importresults
this.cb_close=create cb_close
this.cb_update=create cb_update
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_importresults
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_update
this.Control[iCurrent+4]=this.st_1
end on

on w_company_import_result.destroy
call super::destroy
destroy(this.tab_importresults)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.st_1)
end on

event open;call super::open;Int		li_Initial
String 	lsa_Dups[]
Int		li_Dups
Long		lla_NoIds [] // accounting IDS
Int		li_NoIdCount
Int		li_TotalCount
Int		li_MissingLocatorCount
String	lsa_NonUnique[]
String	ls_NonUnique
String	ls_Dups
Int		li_NonUnique
n_cst_String	lnv_String

ib_DisableCloseQuery = TRUE

S_Parm	lstr_Parm
n_cst_msg	lnv_Msg

IF isValid ( Message.powerobjectparm ) THEN
	lnv_Msg = Message.powerobjectparm
	
	IF lnv_Msg.of_Get_Parm ( "INITIAL" , lstr_Parm ) <> 0 THEN
		li_Initial = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "MISSING" , lstr_Parm ) <> 0 THEN
		ila_nolocs[] = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "DUPS" , lstr_Parm ) <> 0 THEN
		lsa_Dups = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "TOTAL" , lstr_Parm ) <> 0 THEN
		ila_totalids = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "NOIDS" , lstr_Parm ) <> 0 THEN
		lla_NoIds = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ("NONUNIQUE" , lstr_Parm ) <> 0 THEN
		lsa_NonUnique = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ("OBJECT" , lstr_Parm ) <> 0 THEN
		inv_co_import = lstr_Parm.ia_Value
	END IF
	
	
	li_Dups = UpperBound ( lsa_Dups )
	li_NonUnique = UpperBound ( lsa_NonUnique )
	li_NoIdCount = upperBound ( lla_NoIds )
	li_TotalCount = UpperBound ( ila_totalids )
	li_MissingLocatorCount = UpperBound ( ila_nolocs[] )
	
	IF li_Dups > 0 THEN
		lnv_String.of_ArrayToString ( lsa_Dups, "~r~n" , ls_Dups )
	END IF
	
	IF li_NonUnique > 0 THEN
		lnv_String.of_ArrayToString ( lsa_NonUnique, "~r~n" , ls_NonUnique )
	END IF
	

	IF li_NoIdCount = 0 THEN
		tab_importresults.tabpage_NoID.Enabled = FALSE
	ELSE
		tab_importresults.tabpage_summary.st_noids.Text = String ( li_NoIdCount )
		tab_importresults.tabpage_summary.st_noids.TextColor = RGB(255,0,0)
	//	tab_importresults.tabpage_NoID.dw_list.retrieve ( lla_NoIds )
	END IF
	
	IF li_TotalCount = 0 THEN
		tab_importresults.tabpage_successful.Enabled = FALSE
	ELSE
		tab_importresults.tabpage_summary.st_totalimport.Text = String ( li_TotalCount )
	//	tab_importresults.tabpage_successful.dw_list.retrieve ( ila_TotalIDs )
	END IF
	
	IF li_MissingLocatorCount = 0 THEN
		tab_importresults.tabpage_locators.Enabled = FALSE
	ELSE
		tab_importresults.tabpage_summary.st_nolocators.Text = String ( li_MissingLocatorCount )
		tab_importresults.tabpage_summary.st_nolocators.TextColor = RGB(255,0,0)
	//	tab_importresults.tabpage_locators.dw_list.retrieve ( ila_nolocs )
	END IF
	
	IF li_Dups = 0 AND li_NonUnique = 0 THEN
		tab_importresults.tabpage_dupcodenames.Enabled = FALSE
	ELSE
		IF li_NonUnique = 0 THEN
			tab_importresults.tabpage_dupcodenames.mle_CodeNameList.Enabled = FALSE
		ELSE
			tab_importresults.tabpage_summary.st_DupCodeNames.Text = String ( li_NonUnique )
			tab_importresults.tabpage_summary.st_DupCodeNames.TextColor = RGB(255,0,0)
			tab_importresults.tabpage_dupcodenames.mle_CodeNameList.text = ls_NonUnique
		END IF
		
		IF li_Dups = 0 THEN
			tab_importresults.tabpage_dupcodenames.mle_AccountingDupList.Enabled = FALSE
		ELSE
			tab_importresults.tabpage_summary.st_duplicateids.Text = String ( li_Dups )
			tab_importresults.tabpage_summary.st_duplicateids.TextColor = RGB(255,0,0)
			tab_importresults.tabpage_dupcodenames.mle_AccountingDupList.text = ls_Dups
		END IF
		
	END IF
	
	tab_importresults.tabpage_summary.st_initialcount.Text = String (li_Initial )

	THIS.wf_PopulateDisplay ( )

ELSE
	MessageBox( "Import Statistics" , "An error occurred while attempting to display the import statistics." )
END IF
end event

event pfc_postopen;tab_importresults.tabpage_NoID.st_DoubleClick.Visible = FALSE		
tab_importresults.tabpage_successful.st_DoubleClick.Visible = FALSE
tab_importresults.tabpage_locators.st_DoubleClick.Visible = FALSE
	
tab_importresults.tabpage_locators.dw_list.ib_allowDoubleClick = FALSE
tab_importresults.tabpage_successful.dw_list.ib_allowDoubleClick = FALSE
tab_importresults.tabpage_NoID.dw_list.ib_allowDoubleClick = FALSE
end event

type tab_importresults from u_tab_company_import within w_company_import_result
int X=9
int Y=116
int Height=968
int TabOrder=10
boolean BringToTop=true
FontCharSet FontCharSet=Ansi!
end type

type cb_close from commandbutton within w_company_import_result
int X=1289
int Y=1132
int Width=462
int Height=92
int TabOrder=30
boolean BringToTop=true
string Text="Close"
boolean Cancel=true
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close ( PARENT )
end event

type cb_update from commandbutton within w_company_import_result
int X=741
int Y=1132
int Width=462
int Height=92
int TabOrder=20
boolean BringToTop=true
string Text="&Save Import"
boolean Default=true
boolean Cancel=true
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Event ue_UpdateData ( )
end event

type st_1 from statictext within w_company_import_result
int X=434
int Y=24
int Width=1499
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="Click on 'Save Import' to save the imported information."
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

