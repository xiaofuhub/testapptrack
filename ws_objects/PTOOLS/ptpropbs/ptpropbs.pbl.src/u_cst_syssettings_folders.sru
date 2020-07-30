$PBExportHeader$u_cst_syssettings_folders.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings_folders from u_cst_syssettings
end type
type st_2 from statictext within u_cst_syssettings_folders
end type
type st_1 from statictext within u_cst_syssettings_folders
end type
type cb_1 from commandbutton within u_cst_syssettings_folders
end type
type sle_1 from singlelineedit within u_cst_syssettings_folders
end type
end forward

global type u_cst_syssettings_folders from u_cst_syssettings
integer width = 1623
integer height = 236
event ue_valuechanged ( string as_value )
st_2 st_2
st_1 st_1
cb_1 cb_1
sle_1 sle_1
end type
global u_cst_syssettings_folders u_cst_syssettings_folders

forward prototypes
public subroutine of_settext (string as_value)
end prototypes

event ue_valuechanged(string as_value);inv_syssetting.of_savevalue( as_Value )
end event

public subroutine of_settext (string as_value);String ls_Value
ls_Value = as_Value
IF Not IsNull(ls_Value) THEN
	Sle_1.Text = ls_Value
	event ue_valuechanged(ls_Value)
END IF


end subroutine

on u_cst_syssettings_folders.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.sle_1
end on

on u_cst_syssettings_folders.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.sle_1)
end on

event ue_setproperty;call super::ue_setproperty;String ls_Label
Long ll_Pos
IF IsValid(inv_sysSetting) THEN 
	ls_Label = Trim(inv_sysSetting.of_getlabel( )) 
	IF Len(ls_Label) <= 50 THEN
		This.st_1.Text = inv_SysSetting.of_getlabel( ) 
	ELSE
		// Checks for the first period (.) and breaks the text line
		ll_Pos = Pos(ls_Label,".")
		This.st_2.Text = Trim(Left(ls_Label,ll_Pos))
		This.st_1.Text = Trim(Mid(ls_Label,ll_Pos + 1))
	END IF	
END IF	

Return AncestorReturnValue
end event

event ue_setvalue;call super::ue_setvalue;Integer li_Return = -1 

IF IsValid(inv_syssetting) THEN
	sle_1.Text = inv_syssetting.of_getvalue( )
	li_Return = 1 
END IF

Return li_Return
end event

event ue_validatecontrols;call super::ue_validatecontrols;Int li_Return = 1
String ls_Path

ls_Path = Trim(Sle_1.Text)

IF IsNull(ls_Path) THEN 
	ls_Path = ""	
END IF

IF NOT inv_syssetting.of_ShouldValidate( ) THEN
	pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
	lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32
	IF NOT (Len(ls_Path) = 0) THEN
		IF Not lnv_FileSrvWin32.of_Directoryexists(ls_Path) THEN
			Messagebox("System Settings","Directory " + ls_Path + " does not exist.")
			Sle_1.SetFocus()
			li_Return = -1
		ELSE
			of_SetText(ls_Path)
		END IF
		DESTROY(lnv_FileSrvWin32)	
	ELSE
		of_SetText(ls_Path)
	END IF	
ELSE
	of_SetText(ls_Path)
END IF	

Return li_Return
end event

type st_2 from statictext within u_cst_syssettings_folders
integer x = 32
integer y = 8
integer width = 1577
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_1 from statictext within u_cst_syssettings_folders
integer x = 32
integer y = 64
integer width = 1577
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_1 from commandbutton within u_cst_syssettings_folders
integer x = 1307
integer y = 140
integer width = 270
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Browse..."
end type

event clicked;String ls_Path 
String ls_GetAppFolder

ls_Path = Trim(Sle_1.Text)

IF IsNull(ls_Path) OR Len(ls_Path) = 0 THEN
	ls_GetAppFolder = gnv_app.of_GetApplicationFolder()
	IF  GetFolder("",ls_GetAppFolder) > 0 THEN
		of_SetText(ls_GetAppFolder)
	END IF	
ELSE
	IF GetFolder("",ls_Path) > 0 THEN 
		of_SetText(ls_path)
	END IF	
END IF
end event

type sle_1 from singlelineedit within u_cst_syssettings_folders
integer x = 32
integer y = 140
integer width = 1262
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

