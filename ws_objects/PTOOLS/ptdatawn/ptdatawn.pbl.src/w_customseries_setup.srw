$PBExportHeader$w_customseries_setup.srw
forward
global type w_customseries_setup from w_sheet
end type
type dw_list from u_dw within w_customseries_setup
end type
type cb_save from u_cb within w_customseries_setup
end type
type st_instruct from u_st_label within w_customseries_setup
end type
end forward

global type w_customseries_setup from w_sheet
int Width=3122
int Height=1536
boolean TitleBar=true
string Title="Custom Series Setup"
string MenuName="m_sheets"
long BackColor=80269524
dw_list dw_list
cb_save cb_save
st_instruct st_instruct
end type
global w_customseries_setup w_customseries_setup

on w_customseries_setup.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_list=create dw_list
this.cb_save=create cb_save
this.st_instruct=create st_instruct
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.st_instruct
end on

on w_customseries_setup.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.cb_save)
destroy(this.st_instruct)
end on

event open;call super::open;Long	ll_Result
n_cst_Privileges	lnv_Privileges

This.X = 1
This.Y = 1

gf_Mask_Menu ( m_Sheets )

//Enable the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize ( 1300, 400 )

//Register Resizable controls
inv_Resize.of_Register ( dw_List, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( cb_Save, 'FixedToRight' )

IF lnv_Privileges.of_HasAdministrativeRights ( ) THEN

	//OK

ELSE

	ib_DisableCloseQuery = TRUE
	cb_Save.Enabled = FALSE
	dw_List.Modify ( "DataWindow.ReadOnly = Yes" )
	st_Instruct.Text = "READ ONLY MODE"

END IF


ll_Result = dw_List.Retrieve ( )

COMMIT ;

CHOOSE CASE ll_Result

CASE IS >= 0

	//OK

CASE -1

	MessageBox ( This.Title, "Error retrieving data.  Window will close." )
	Close ( This )

CASE ELSE

	MessageBox ( This.Title, "Unexpected return error retrieving data.  Window will close." )
	Close ( This )

END CHOOSE
end event

type dw_list from u_dw within w_customseries_setup
int X=32
int Y=140
int Width=3013
int Height=1196
int TabOrder=10
boolean BringToTop=true
string DataObject="d_customseries_list"
boolean HScrollBar=true
boolean HSplitScroll=true
end type

event constructor;This.SetTransObject ( SQLCA )
end event

type cb_save from u_cb within w_customseries_setup
int X=2688
int Y=20
int TabOrder=20
boolean BringToTop=true
string Text="&Save"
end type

event clicked;Parent.Event pfc_Save ( )
end event

type st_instruct from u_st_label within w_customseries_setup
int X=37
int Y=32
int Width=1102
int Height=80
boolean BringToTop=true
string Text="Right click to add or delete rows."
end type

