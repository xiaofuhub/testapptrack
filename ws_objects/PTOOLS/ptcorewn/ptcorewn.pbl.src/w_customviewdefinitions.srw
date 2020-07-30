$PBExportHeader$w_customviewdefinitions.srw
forward
global type w_customviewdefinitions from w_sheet
end type
type dw_definitions from u_dw within w_customviewdefinitions
end type
type dw_displaynames from u_dw within w_customviewdefinitions
end type
type lb_viewnames from u_lb within w_customviewdefinitions
end type
type st_1 from u_st_label within w_customviewdefinitions
end type
type st_2 from u_st_label within w_customviewdefinitions
end type
type cb_import from u_cb within w_customviewdefinitions
end type
end forward

global type w_customviewdefinitions from w_sheet
int Width=2464
int Height=1476
boolean TitleBar=true
string Title="Custom View Definitions"
string MenuName="m_sheets"
event type integer ue_importdefinition ( )
event type integer ue_refresh ( )
dw_definitions dw_definitions
dw_displaynames dw_displaynames
lb_viewnames lb_viewnames
st_1 st_1
st_2 st_2
cb_import cb_import
end type
global w_customviewdefinitions w_customviewdefinitions

event ue_importdefinition;//Returns : 1 = Success, 0 = User Cancelled, -1 = Error

String	ls_ViewName, &
			ls_QuotedViewName, &
			ls_DisplayName, &
			ls_QuotedDisplayName, &
			ls_Pathname, &
			ls_Filename, &
			lsa_Sections[], &
			lsa_Keys[], &
			lsa_Definitions[], &
			lsa_Empty[]

Integer	li_SectionCount, &
			li_KeyCount, &
			li_DefCount, &
			li_Key, &
			li_Def, &
			li_Section, &
			li_SqlCode

Boolean	lb_InsertFailed

n_cst_IniFile	lnv_IniFile

String	ls_ErrorMessage

Integer	li_Return = 1


//This value is not being used, so I've commented it, but this is how to get it if needed.
//
//IF li_Return = 1 THEN
//
//	ls_SelectedViewName = lb_ViewNames.SelectedItem ( )
//
//END IF


IF li_Return = 1 THEN

	CHOOSE CASE GetFileOpenName ( "Select Import File", ls_Pathname, ls_Filename, &
		"TXT", "Text Files (*.txt),*.txt,All Files (*.*),*.*" )
	
	CASE 1
		//Success - file selected
	
	CASE 0
		//User cancelled
		li_Return = 0
	
	CASE -1
		ls_ErrorMessage = "Error selecting import file."
		li_Return = -1
	
	CASE ELSE
		ls_ErrorMessage = "Unexpected return error selecting import file."
		li_Return = -1
	
	END CHOOSE

END IF


IF li_Return = 1 THEN

	li_SectionCount = lnv_IniFile.of_GetSections ( ls_Pathname, lsa_Sections )

	CHOOSE CASE li_SectionCount

	CASE IS > 0
		//OK

	CASE 0

		ls_ErrorMessage = "There are no custom view definitions in the file you selected."
		li_Return = -1

	CASE ELSE

		ls_ErrorMessage = "Error reading import file."
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	FOR li_Section = 1 TO li_SectionCount

		ls_DisplayName = Trim ( lsa_Sections [ li_Section ] )
		ls_QuotedDisplayName = "~"" + ls_DisplayName + "~""
		//Note : File access functions like ProfileString below should use the original
		//value lsa_Sections [ li_Section ], not the trimmed value ls_DisplayName, in
		//case they're different.

		ls_ViewName = Trim ( ProfileString ( ls_Pathname, lsa_Sections [ li_Section ], "ViewName", "" ) )

		IF Len ( ls_ViewName ) > 0 THEN
			//OK
		ELSE
			MessageBox ( "Import View", "The ViewName was not specified for " +&
				ls_QuotedDisplayName + ".  This view will be skipped." )
			CONTINUE
		END IF

		ls_QuotedViewName = "~"" + ls_ViewName + "~""

		IF MessageBox ( "Verify Import", "OK to import " + ls_QuotedDisplayName + " as a "+&
			"custom view for " + ls_QuotedViewName + "?  (Any existing view definition with this name "+&
			"and type will be replaced.)", Question!, OKCancel! ) = 2 THEN

			CONTINUE

		END IF

		DELETE FROM CustomView WHERE ViewName = :ls_ViewName AND DisplayName = :ls_DisplayName ;

		li_SqlCode = SQLCA.SqlCode

		CHOOSE CASE li_SqlCode

		CASE 0, 100

			COMMIT ;

		CASE ELSE

			ROLLBACK ;

			MessageBox ( "Database Error", "Error clearing existing view definition for " +&
				ls_QuotedDisplayName + ".  This view will be skipped." )

			CONTINUE

		END CHOOSE


		li_KeyCount = lnv_IniFile.of_GetKeys ( ls_Pathname, lsa_Sections [ li_Section ], lsa_Keys )

		lsa_Definitions = lsa_Empty
		li_DefCount = 0

		FOR li_Key = 1 TO li_KeyCount

			//Screen off any special entries that don't become object definitions.

			CHOOSE CASE Upper ( lsa_Keys [ li_Key ] )

			CASE Upper ( "ViewName" )
				CONTINUE

			END CHOOSE

			//Okay, it's an object definition.  Increment the defcount and add the value to
			//the definitions array.

			li_DefCount ++
			lsa_Definitions [ li_DefCount ] = ProfileString ( ls_Pathname, lsa_Sections [ li_Section], lsa_Keys [ li_Key ], "" )

		NEXT


		//Initialize the flag for use in the loop, below.
		lb_InsertFailed = FALSE


		FOR li_Def = 1 TO li_DefCount

			INSERT INTO CustomView (ViewName, DisplayName, ObjectNumber, ObjectDefinition)
			VALUES (:ls_ViewName, :lsa_Sections [ li_Section ], :li_Def, :lsa_Definitions [ li_Def ] ) ;

			CHOOSE CASE SQLCA.SqlCode

			CASE 0
				//OK

			CASE ELSE
				ROLLBACK ;

				MessageBox ( "Database Error", "Error loading new view definition for " +&
					ls_QuotedDisplayName + ".  This view will be skipped." )

				//Flag failure to skip COMMIT, below
				lb_InsertFailed = TRUE

				EXIT

			END CHOOSE

		NEXT


		IF lb_InsertFailed = FALSE AND li_DefCount > 0 THEN
	
			COMMIT ;

		END IF

	NEXT

END IF


CHOOSE CASE li_Return

CASE 1
	//Import was successful -- need to refresh the screen to reflect imported data.
	This.Event ue_Refresh ( )
	dw_DisplayNames.SetFocus ( )

CASE 0
	//User cancelled -- no action needed.

CASE -1
	//Import failed -- display error message.
	MessageBox ( "Import View", ls_ErrorMessage )

END CHOOSE

RETURN li_Return
end event

event ue_refresh;dw_DisplayNames.Reset ( )

dw_DisplayNames.Retrieve ( lb_ViewNames.SelectedItem ( ) )
COMMIT ;

RETURN 1
end event

on w_customviewdefinitions.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_definitions=create dw_definitions
this.dw_displaynames=create dw_displaynames
this.lb_viewnames=create lb_viewnames
this.st_1=create st_1
this.st_2=create st_2
this.cb_import=create cb_import
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_definitions
this.Control[iCurrent+2]=this.dw_displaynames
this.Control[iCurrent+3]=this.lb_viewnames
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_import
end on

on w_customviewdefinitions.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_definitions)
destroy(this.dw_displaynames)
destroy(this.lb_viewnames)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_import)
end on

event open;call super::open;//Extending Ancestor Script

gf_Mask_Menu ( m_Sheets )

IF This.of_SetResize ( TRUE ) = 1 THEN

	//Set size so that proper alignment will be kept when opening as layered (full screen)
	This.inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
	
	This.inv_Resize.of_SetMinSize ( 1300, 400 )
	This.inv_Resize.of_Register ( dw_Definitions, 'ScaleToRight&Bottom' )
	This.inv_Resize.of_Register ( cb_Import, 'FixedToRight' )

END IF
end event

type dw_definitions from u_dw within w_customviewdefinitions
int X=55
int Y=660
int Width=2322
int Height=624
int TabOrder=30
boolean BringToTop=true
string DataObject="d_customviewdefinitions"
boolean HScrollBar=true
end type

event constructor;This.SetTransObject ( SQLCA )

This.of_SetInsertable ( FALSE )
This.of_SetDeleteable ( FALSE )
end event

type dw_displaynames from u_dw within w_customviewdefinitions
int X=823
int Y=108
int Width=919
int Height=440
int TabOrder=20
boolean BringToTop=true
string DataObject="d_customviewlist"
end type

event rowfocuschanged;call super::rowfocuschanged;IF CurrentRow > 0 THEN

	dw_Definitions.Retrieve ( lb_ViewNames.SelectedItem ( ), This.Object.DisplayName [ CurrentRow ] )

ELSE

	dw_Definitions.Reset ( )

END IF
end event

event constructor;This.SetTransObject ( SQLCA )

This.SetRowFocusIndicator ( FocusRect! )

This.of_SetRowSelect ( TRUE )
end event

type lb_viewnames from u_lb within w_customviewdefinitions
int X=59
int Y=112
int Width=649
int Height=432
int TabOrder=10
boolean BringToTop=true
boolean Sorted=false
int TextSize=-10
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
string Item[]={"ShipmentList"}
end type

event selectionchanged;Parent.Event ue_Refresh ( )
end event

event constructor;//Select the first item in the list, and force selectionchanged processing to occur.

This.Post SelectItem ( 1 )
This.Post Event SelectionChanged ( 1 )
end event

type st_1 from u_st_label within w_customviewdefinitions
int X=73
int Y=32
int Width=375
boolean BringToTop=true
string Text="Views"
end type

type st_2 from u_st_label within w_customviewdefinitions
int X=832
int Y=32
int Width=553
boolean BringToTop=true
string Text="Custom Definitions"
end type

type cb_import from u_cb within w_customviewdefinitions
int X=1801
int Y=108
int Width=544
int TabOrder=40
boolean BringToTop=true
string Text="&Import from File..."
end type

event clicked;Parent.Event ue_ImportDefinition ( )
end event

