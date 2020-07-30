$PBExportHeader$w_templateselection.srw
forward
global type w_templateselection from w_response
end type
type dw_selection from u_dw within w_templateselection
end type
type cb_1 from u_cbok within w_templateselection
end type
type cb_2 from u_cbcancel within w_templateselection
end type
type mle_1 from multilineedit within w_templateselection
end type
end forward

global type w_templateselection from w_response
integer x = 521
integer y = 288
integer width = 1152
integer height = 1308
string title = "Send Outbound Message"
dw_selection dw_selection
cb_1 cb_1
cb_2 cb_2
mle_1 mle_1
end type
global w_templateselection w_templateselection

type variables
string is_Folder
String	is_Device
n_cst_msg inv_msg
end variables

forward prototypes
private function integer wf_getsubfolder (string as_subfolder)
private function integer wf_getsystemtemplatepath (ref string as_filepath)
end prototypes

private function integer wf_getsubfolder (string as_subfolder);//test folder selection
integer	li_FolderCnt, &
			li_Index, &
			li_Ret, &
			li_SubFolders
			
long		ll_NewRow

string	ls_FolderName
			
//window lw_ActiveSheet

n_cst_filesrvwin32	lnv_filesrvwin32
n_cst_dirattrib		lnv_dirattrib[]

lnv_filesrvwin32 = CREATE n_cst_FileSrvwin32

dw_Selection.dataobject = "d_folders"
dw_Selection.SetTransObject ( SQLCA )

IF Right ( is_folder , 1 ) = "\" THEN
	is_Folder = is_folder  + as_subfolder
ELSE
	is_Folder = is_folder + "\" + as_subfolder
END IF

li_FolderCnt=lnv_filesrvwin32.of_dirlist ( is_Folder + "\*.*", 16, lnv_dirattrib ) 
	//DirList clears the array
	//16 Represents folders)  See PB DirList()

IF li_FolderCnt > 0 then

		mle_1.TEXT = "Send a message about:"
		FOR li_Index = 1 to li_FolderCnt
			
			IF lnv_dirAttrib[li_Index].ib_Subdirectory THEN
				ls_FolderName = lnv_dirAttrib[li_Index].is_FileName
				
				//remove folder brackets	
				ls_FolderName = mid ( ls_FolderName, 2, len ( ls_FolderName ) - 2 )
				
				IF ls_FolderName = ".." or ls_FolderName = "." THEN CONTINUE

				li_subfolders ++

				IF Len ( ls_FolderName ) > 0 THEN
					ll_NewRow = dw_Selection.InsertRow(0)
					
					IF ll_NewRow > 0 THEN
						dw_Selection.object.foldername [ll_NewRow] = ls_FolderName
						
					END IF
				END IF
				
			END IF
		
		NEXT
	
dw_Selection.SelectRow ( 1, TRUE )

END IF

DESTROY lnv_filesrvwin32

return li_SubFolders




end function

private function integer wf_getsystemtemplatepath (ref string as_filepath);Integer 	li_Return
String	ls_Path

n_cst_settings lnv_Settings

li_Return = 1

n_cst_setting_templatespathfolder	lnv_PathSetting
lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
ls_Path = lnv_PathSetting.of_Getvalue( )
DESTROY ( lnv_PathSetting )

IF Len ( ls_Path ) = 0 THEN
	li_Return = -1 
END IF

IF li_Return = 1 THEN
	as_FilePath = ls_Path + "MESSAGE\"+is_device+"\OUTBOUND\"
END IF

return li_return
end function

on w_templateselection.create
int iCurrent
call super::create
this.dw_selection=create dw_selection
this.cb_1=create cb_1
this.cb_2=create cb_2
this.mle_1=create mle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_selection
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.mle_1
end on

on w_templateselection.destroy
call super::destroy
destroy(this.dw_selection)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.mle_1)
end on

event open;call super::open;s_Parm		lstr_Parm

String	ls_Topic, &
			lsa_Topic[]

integer	li_TopicCnt, &
			li_Index, &
			li_Ret
			
long		ll_NewRow

string	ls_FolderName
			

n_cst_filesrvwin32	lnv_filesrvwin32
n_cst_dirattrib		lnv_dirattrib[]

lnv_filesrvwin32 = CREATE n_cst_FileSrvwin32
			
ib_disableCloseQuery = TRUE

IF IsValid ( Message.PowerObjectParm ) THEN
	inv_Msg = Message.PowerObjectParm
END IF

IF inv_msg.of_Get_Parm ( "TOPICARRAY", lstr_Parm ) > 0 THEN
	
	lsa_Topic = lstr_Parm.ia_Value
	
END IF

IF inv_msg.of_Get_Parm ( "DEVICE", lstr_Parm ) > 0 THEN
	
	is_device = lstr_Parm.ia_Value
	
END IF

dw_Selection.dataobject = "d_folders"
dw_Selection.SetTransObject ( SQLCA )

//communication path  + topic
li_Ret = wf_GetSystemTemplatePath( is_Folder )

IF li_Ret > 0 THEN
	mle_1.TEXT = "Send a message about:"
	
	li_TopicCnt = upperbound ( lsa_Topic ) 

	FOR li_Index = 1 to li_TopicCnt
				
		ls_FolderName = is_Folder + lsa_Topic [li_Index]
		
		IF lnv_filesrvwin32.of_directoryexists ( ls_FolderName ) THEN
	
			ll_NewRow = dw_Selection.InsertRow(0)
			
			IF ll_NewRow > 0 THEN
				dw_Selection.object.foldername [ll_NewRow] = lsa_Topic [li_Index]
				
			END IF
			
		END IF
	

	NEXT
	
ELSE
	
	messagebox ( "Send OutBound Message", "Template folder path not defined in system settings.")
	
	
END IF
		
dw_Selection.SelectRow ( 1, TRUE )
dw_Selection.SetFocus()

DESTROY lnv_filesrvwin32


//Long			lla_Selected[], &
//				ll_SelectedCount, &
//				ll_Index

//IF inv_msg.of_Get_Parm ( "FULLSTATE", lstr_Parm ) > 0 THEN
//	dw_Selection.SetFullState ( lstr_Parm.ia_Value )
//END IF
//
//IF inv_msg.of_Get_Parm ( "SELECTION", lstr_Parm ) > 0 THEN
//
//	lla_Selected = lstr_Parm.ia_Value
//	ll_SelectedCount = UpperBound ( lla_Selected )
//
//	FOR ll_Index = 1 TO ll_SelectedCount
//		dw_Selection.SelectRow ( lla_Selected [ ll_Index ], TRUE )
//	NEXT
//
//END IF
//
//
//
//
end event

event pfc_default;s_Parm		lstr_Parm

string	ls_TemplateFolder

integer	li_Ret

ls_TemplateFolder = dw_selection.object.foldername[dw_Selection.GetRow()]

//drill down to lowest folder
li_Ret = wf_Getsubfolder ( ls_TemplateFolder )
is_Folder = is_Folder + "\"

CHOOSE CASE ls_TemplateFolder
		
	CASE n_cst_constants.cs_ReportTopic_EVENT, &
		  n_cst_constants.cs_ReportTopic_COMPANY, &
	     n_cst_constants.cs_ReportTopic_SHIPMENT
		  
		lstr_Parm.is_Label = "SELECTEDTOPIC"
		lstr_Parm.ia_Value = ls_TemplateFolder
		inv_Msg.of_Add_Parm ( lstr_Parm )

END CHOOSE

IF li_Ret > 0 THEN
	//more sub folders go to display
	dw_Selection.SetFocus()
ELSE
	
	lstr_Parm.is_Label = "Folder"
	lstr_Parm.ia_Value = is_Folder
	inv_Msg.of_Add_Parm ( lstr_Parm )

	CloseWithReturn ( This, inv_Msg )
	
END IF
end event

type cb_help from w_response`cb_help within w_templateselection
end type

type dw_selection from u_dw within w_templateselection
integer x = 69
integer y = 244
integer width = 1010
integer height = 744
integer taborder = 10
boolean bringtotop = true
end type

event constructor;//Instantiate the default row focus indicator
//This.Event ue_SetFocusIndicator ( TRUE )

This.of_SetRowManager ( TRUE )
This.of_SetRowSelect ( TRUE )
This.inv_RowSelect.of_SetStyle ( 2 )
This.SetRowFocusIndicator ( FocusRect! )

This.of_SetInsertable ( FALSE )

end event

event doubleclicked;
parent.TriggerEvent("pfc_default")


end event

type cb_1 from u_cbok within w_templateselection
integer x = 288
integer y = 1068
integer width = 233
integer taborder = 20
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_templateselection
integer x = 640
integer y = 1068
integer width = 233
integer taborder = 30
boolean bringtotop = true
end type

event clicked;call super::clicked;CLOSE(PARENT)
end event

type mle_1 from multilineedit within w_templateselection
integer x = 69
integer y = 48
integer width = 1010
integer height = 144
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

