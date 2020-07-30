$PBExportHeader$u_cst_filedirectory.sru
forward
global type u_cst_filedirectory from u_base
end type
type ddlb_filelist from dropdownlistbox within u_cst_filedirectory
end type
type cb_more from commandbutton within u_cst_filedirectory
end type
end forward

global type u_cst_filedirectory from u_base
integer width = 1285
integer height = 132
long backcolor = 12632256
event ue_selectionchanged ( )
ddlb_filelist ddlb_filelist
cb_more cb_more
end type
global u_cst_filedirectory u_cst_filedirectory

type variables
protected:
string		is_filename, &
		is_Path, &
		is_fileextension, &
		is_filtername
end variables

forward prototypes
public function string of_getselectedfile ()
public subroutine of_loadfilelist ()
public function string of_getfileextension ()
public subroutine of_setfileextension (string as_value)
public subroutine of_setpath (long al_systemsetting)
public function string of_getpath ()
public subroutine of_setpath (string as_value)
public function string of_getfullname ()
public subroutine of_selectfile (readonly string as_file)
public subroutine of_setfilename (readonly string as_value)
public subroutine of_selectfile (readonly long al_item)
public subroutine of_setfiltername (string as_value)
end prototypes

public function string of_getselectedfile ();string	ls_filename

ls_filename = is_filename

if len(trim(ls_filename)) = 0 then
	//get first file in list
	ls_filename = ddlb_filelist.Text (1)
end if

return ls_filename
end function

public subroutine of_loadfilelist ();String	ls_FileName 

long		ll_NewRow, &
			ll_Count, &
			ll_FileCount

n_cst_dirattrib		lnv_DirAttrib[]
n_cst_FileSrvwin32 	lnv_FileSrv

lnv_FileSrv = CREATE n_cst_FileSrvwin32
ddlb_filelist.Reset ( )

lnv_FileSrv.of_DirList ( this.of_getpath() + this.of_getfileextension() , 39, lnv_DirAttrib )
ll_FileCount =  UpperBound( lnv_DirAttrib ) 

For ll_Count = 1 TO ll_FileCount
	if len(is_filtername) > 0 then
		//match batch name
		if pos(lnv_dirAttrib[ll_Count].is_FileName, is_filtername) > 0 then
			ls_FileName = lnv_dirAttrib[ll_Count].is_FileName
		else
			ls_filename = ''
		end if
	else
		//all files
		ls_filename = lnv_dirAttrib[ll_Count].is_FileName
	end if 
	
	IF Len ( ls_FileName ) > 0 THEN				
		ddlb_filelist.AddItem (ls_FileName )
	END IF
NEXT

DESTROY lnv_FileSrv

ddlb_filelist.SetFocus()

end subroutine

public function string of_getfileextension ();string	ls_fileextension

ls_fileextension = is_fileextension

if len(trim(ls_fileextension)) = 0 then
	ls_fileextension = "/*.*"
else
	ls_fileextension = "/*." + is_fileextension
end if

return ls_fileextension
end function

public subroutine of_setfileextension (string as_value);is_fileextension = as_value
end subroutine

public subroutine of_setpath (long al_systemsetting);//get the folder from the system setting if no setting supplied then 
//return current folder location
any		la_Setting
String	ls_folderlocation

n_cst_fileSrvwin32	lnv_fileSrv
n_cst_Settings lnv_Settings 

lnv_FileSrv = CREATE n_cst_fileSrvwin32

CHOOSE CASE lnv_Settings.of_GetSetting( al_systemsetting, la_Setting )
	CASE 0
		
	CASE 1
		ls_folderlocation = String ( la_Setting )
							
	CASE ELSE
		
END CHOOSE

IF Len ( ls_folderlocation ) > 0 THEN
	//Value is OK 
ELSE
	ls_folderlocation = lnv_fileSrv.of_GetCurrentDirectory()
END IF

IF Right ( ls_folderlocation , 1 ) <> "\" THEN
	ls_folderlocation += "\"
END IF

IF Not lnv_FileSrv.of_DirectoryExists( ls_folderlocation ) THEN
	
	ls_folderlocation = lnv_fileSrv.of_GetCurrentDirectory()

END IF

IF isValid ( lnv_fileSrv ) THEN
	DESTROY lnv_FileSrv
END IF

is_path = ls_folderlocation


end subroutine

public function string of_getpath ();string	ls_path

n_cst_fileSrvwin32	lnv_fileSrv

ls_path = is_path

if len(trim(ls_path)) = 0 then
	//return currentdirectory
	ls_path = lnv_filesrv.of_getcurrentdirectory()
end if

return ls_path
end function

public subroutine of_setpath (string as_value);is_path = as_value
end subroutine

public function string of_getfullname ();string	ls_filename

ls_filename = is_filename

if len(trim(ls_filename)) = 0 then
	//get first file in list
	ls_filename = ddlb_filelist.Text (1)
end if

if len(ls_filename) > 0 then
	ls_filename = this.of_getpath() + ls_filename
end if

return ls_filename
end function

public subroutine of_selectfile (readonly string as_file);integer	li_selected

li_selected = ddlb_filelist.SelectItem ( as_file, 1 )
if li_selected > 0 then
	ddlb_filelist.event selectionchanged(li_selected)
	this.of_Setfilename(as_file)
end if

end subroutine

public subroutine of_setfilename (readonly string as_value);is_filename = as_value
end subroutine

public subroutine of_selectfile (readonly long al_item);Integer li_selected

li_selected = ddlb_filelist.SelectItem ( al_item )

if li_selected > 0 then
	ddlb_filelist.event selectionchanged( al_item )
	this.of_Setfilename(ddlb_filelist.Text( al_item ) )
	
end if


end subroutine

public subroutine of_setfiltername (string as_value);is_filtername = as_value
end subroutine

on u_cst_filedirectory.create
int iCurrent
call super::create
this.ddlb_filelist=create ddlb_filelist
this.cb_more=create cb_more
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_filelist
this.Control[iCurrent+2]=this.cb_more
end on

on u_cst_filedirectory.destroy
call super::destroy
destroy(this.ddlb_filelist)
destroy(this.cb_more)
end on

event constructor;call super::constructor;This.of_SetResize ( TRUE )

//inv_Resize.of_SetMinSize ( 3561, 1824)
inv_Resize.of_SetMinSize ( 1481, 148)
//Register Resizable controls
inv_Resize.of_Register ( ddlb_filelist, 'ScaleToRight' )
inv_Resize.of_Register ( cb_more, 'FixedToRight' )

end event

type ddlb_filelist from dropdownlistbox within u_cst_filedirectory
integer x = 9
integer y = 20
integer width = 983
integer height = 884
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Parent.of_SetFilename(this.text(index))
parent.event ue_selectionchanged()

end event

type cb_more from commandbutton within u_cst_filedirectory
integer x = 1029
integer y = 20
integer width = 233
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&More"
end type

event clicked;// Change directory to one in system settings #
string	ls_Drive, &
			ls_DirPath, &
			ls_FileName, &
			ls_Ext, &
			ls_type, &
			ls_path

ANY 		la_Path			
			
n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)										// Create file service

/* 
	Attempted to change directory to the one in system setting. 
	The code below works but has not effect on GetFileOpenName
*/
 
//n_cst_Settings	lnv_Settings
//n_cst_String 	lnv_string						
//
//If lnv_Settings.of_GetSetting ( 129 , la_Path) = 1 Then 
//	ls_Path = la_Path
//End If
//
//If Len( Trim( ls_Path ) ) > 0  Then 
//	If lnv_FileSrv.of_ChangeDirectory( ls_Path ) = -1 Then 
//		// change directory failed.
//		MessageBox("Caution","Could not change directory to one listed in system settings. ~n" + ls_Path +"~nPlease verify setting.")
//	End If
//End if

IF GetFileOpenName("Select File", ls_path, ls_filename, "TXT","Text Files (*.TXT),*.TXT," )  = 1 THEN
	
	lnv_FileSrv.of_ParsePath(ls_path, ls_Drive, ls_DirPath, ls_FileName, ls_Ext)
	parent.of_setpath( ls_Drive + ls_DirPath )
	Parent.of_LoadfileList()
	Parent.of_SelectFile(ls_filename)
	
END IF

f_SetFileSrv(lnv_FileSrv, FALSE)										// Destroy file service


end event

