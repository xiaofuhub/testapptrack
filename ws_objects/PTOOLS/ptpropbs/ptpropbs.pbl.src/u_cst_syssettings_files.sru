$PBExportHeader$u_cst_syssettings_files.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings_files from u_cst_syssettings
end type
type st_1 from statictext within u_cst_syssettings_files
end type
type cb_1 from commandbutton within u_cst_syssettings_files
end type
type sle_1 from singlelineedit within u_cst_syssettings_files
end type
type st_2 from statictext within u_cst_syssettings_files
end type
end forward

global type u_cst_syssettings_files from u_cst_syssettings
integer width = 1600
integer height = 240
event ue_valuechanged ( string as_value )
st_1 st_1
cb_1 cb_1
sle_1 sle_1
st_2 st_2
end type
global u_cst_syssettings_files u_cst_syssettings_files

type variables
n_cst_FileSrv inv_FileSrv
String	is_Extension = ""
String	is_Filter = "All Files (*.*), *.*"
end variables

forward prototypes
public subroutine of_settext (string as_value)
public function integer of_setfilter (string as_filter)
public function integer of_setextension (string as_extension)
end prototypes

event ue_valuechanged(string as_value);inv_syssetting.of_savevalue( as_Value )
end event

public subroutine of_settext (string as_value);String ls_Value

ls_Value = as_Value

sle_1.text = ls_Value
event ue_valuechanged(ls_Value)




end subroutine

public function integer of_setfilter (string as_filter);is_Filter = as_Filter

Return 1
end function

public function integer of_setextension (string as_extension);is_Extension = as_Extension

Return 1
end function

on u_cst_syssettings_files.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.st_2
end on

on u_cst_syssettings_files.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.st_2)
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
Boolean lb_exist

ls_Path = Trim(Sle_1.Text)

IF IsNull(ls_Path) THEN
	ls_Path = ""	
END IF

lb_exist = FileExists(ls_Path)

IF NOT (LEN(ls_Path) = 0) THEN
	IF NOT lb_exist  THEN
		Messagebox("System Settings","File " + ls_Path + " does not exist.")
		Sle_1.SetFocus()
		li_Return = -1
	ELSE
		of_SetText(ls_Path)
	END IF
ELSE
	of_SetText(ls_Path)
END IF
	
Return li_Return
end event

type st_1 from statictext within u_cst_syssettings_files
integer x = 32
integer y = 76
integer width = 1275
integer height = 64
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

type cb_1 from commandbutton within u_cst_syssettings_files
integer x = 1307
integer y = 144
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

event clicked;Int li_rtn 
String ls_Filepath
String ls_Filename
String ls_CurrentPath
String ls_AppFolder

ls_CurrentPath = Trim(Sle_1.Text)

IF IsNull(ls_CurrentPath) OR Len(ls_CurrentPath) = 0 THEN
	ls_AppFolder = gnv_app.of_GetApplicationFolder( )
	li_rtn = GetFileOpenName("Select File",ls_Filepath, ls_Filename, is_Extension, &
		      + is_Filter,ls_AppFolder, 18)
ELSE
	li_rtn = GetFileOpenName("Select File",ls_Filepath, ls_Filename, is_Extension, &
		      + is_Filter,ls_CurrentPath, 18)
END IF	 

IF li_rtn > 0 THEN  	 
	of_SetText(ls_FilePath)
END IF
	 


end event

type sle_1 from singlelineedit within u_cst_syssettings_files
integer x = 32
integer y = 144
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

type st_2 from statictext within u_cst_syssettings_files
integer x = 32
integer y = 8
integer width = 1275
integer height = 64
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

