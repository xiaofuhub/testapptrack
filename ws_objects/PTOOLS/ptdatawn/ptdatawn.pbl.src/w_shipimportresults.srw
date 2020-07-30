$PBExportHeader$w_shipimportresults.srw
forward
global type w_shipimportresults from w_sheet
end type
type dw_1 from u_dw_shipimportresults within w_shipimportresults
end type
type cb_importlog from commandbutton within w_shipimportresults
end type
end forward

global type w_shipimportresults from w_sheet
int Width=3506
int Height=1140
boolean TitleBar=true
string Title="Import Log"
string MenuName="m_sheets"
dw_1 dw_1
cb_importlog cb_importlog
end type
global w_shipimportresults w_shipimportresults

type variables
n_cst_EDI_204_Record	inva_204Records[]

end variables

on w_shipimportresults.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_1=create dw_1
this.cb_importlog=create cb_importlog
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_importlog
end on

on w_shipimportresults.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.cb_importlog)
end on

event open;call super::open;n_cst_Msg	lnv_msg
S_Parm		lstr_Parm

lnv_Msg = Message.PowerobjectParm 

ib_DisableCloseQuery = TRUE

IF isValid ( lnv_Msg ) THEN
	IF lnv_Msg.of_Get_Parm ( "RECORDS" , lstr_Parm ) <> 0 THEN
		inva_204Records = lstr_Parm.ia_Value
		dw_1.of_Populate ( inva_204Records )
	ELSEIF lnv_Msg.of_Get_Parm ( "FILE" , lstr_Parm ) <> 0 THEN
		dw_1.of_importFile ( lstr_Parm.ia_Value )
		
	END IF
	
	
	
END IF


This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize ( 1300, 400 )
THIS.x = 0
THIS.y = 0

//Register Resizable controls
inv_Resize.of_Register ( dw_1, 'ScaleToRight&Bottom' )
//inv_Resize.of_Register ( cb_close, 'FixedToBottom' )
//inv_Resize.of_Register ( cb_importlog, 'FixedToRight' )
//inv_Resize.of_Register ( cb_importshipment, 'FixedToBottom' )

gf_Mask_Menu ( m_Sheets )
end event

type dw_1 from u_dw_shipimportresults within w_shipimportresults
int X=9
int Y=136
int Width=3447
int Height=816
int TabOrder=10
boolean BringToTop=true
boolean HScrollBar=true
end type

type cb_importlog from commandbutton within w_shipimportresults
int X=9
int Y=16
int Width=489
int Height=100
int TabOrder=20
boolean BringToTop=true
string Text="&Import Log File"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_Path
Any 		la_Result

n_cst_filesrvWin32	lnv_FileSrv
n_cst_Settings	lnv_Settings
lnv_FileSrv = Create n_cst_filesrvWin32 

 
IF lnv_Settings.of_GetSetting ( 103 , la_Result ) = 1 THEN
	ls_Path = Trim ( String  (la_Result)) 
	
	IF Right ( ls_Path , 1 ) <> "\" THEN
		ls_Path += "\"
	END IF

	lnv_FileSrv.of_ChangeDirectory ( ls_Path ) 
END IF

dw_1.Reset ( )
dw_1.of_importFile ( null_str ) 

Destroy ( lnv_FileSrv ) 

end event

