$PBExportHeader$w_communication_outbound.srw
forward
global type w_communication_outbound from w_response
end type
type dw_selection from u_dw_communication_outbound within w_communication_outbound
end type
type cbx_alldestinations from checkbox within w_communication_outbound
end type
type cb_5 from u_cbok within w_communication_outbound
end type
type cb_6 from u_cbcancel within w_communication_outbound
end type
type cb_editmsg from commandbutton within w_communication_outbound
end type
type cb_3 from commandbutton within w_communication_outbound
end type
type st_destination from statictext within w_communication_outbound
end type
type st_device from statictext within w_communication_outbound
end type
type st_topic from statictext within w_communication_outbound
end type
type dw_folders from u_dw within w_communication_outbound
end type
end forward

global type w_communication_outbound from w_response
integer x = 1010
integer y = 752
integer width = 1262
integer height = 688
string title = "Send Outbound Message"
long backcolor = 12632256
dw_selection dw_selection
cbx_alldestinations cbx_alldestinations
cb_5 cb_5
cb_6 cb_6
cb_editmsg cb_editmsg
cb_3 cb_3
st_destination st_destination
st_device st_device
st_topic st_topic
dw_folders dw_folders
end type
global w_communication_outbound w_communication_outbound

type variables
datawindowchild	idwc_Destination
datawindowchild	idwc_Device
datawindowchild	idwc_Template
DataStore	ids_Templates	
n_cst_msg	inv_msg
string		is_Filter
string		is_Employee
String		is_Equipment
Long		il_Employeeid
Long		il_Equipmentid
String		is_TemplatePath
//String		is_TemplateRoot
String		is_FreeFormText
String		is_selectedTopic
Int		ii_NumEvents
//String		is_SelectedDestination
String		is_SelectedDevice
Boolean		ib_FreeForm
Boolean    	ib_DisableState1 
any		iaa_Data[]
Int		ii_CurrentState 
n_cst_beo_company	inva_Companies[]
n_cst_beo_event		inva_Events[]

Constant String	cs_Template_Directions = "directns.doc"
end variables

forward prototypes
private function integer wf_assemblemsg (ref n_cst_msg anv_msg)
private function integer wf_populatedestinations ()
private function string wf_getselecteddestinationstring ()
private function integer wf_next ()
private function integer wf_back ()
private function integer wf_gotostate2 ()
private function integer wf_getsubfolder (ref string as_folder)
private function integer wf_getsystemtemplatepath (ref string as_path)
private function integer wf_gotostate3 ()
private function integer wf_gotostate1 ()
private function integer wf_lookforsubfolders (string as_folder)
protected function integer wf_senddata ()
public function integer wf_addmiscdevices ()
public function integer wf_autoselect ()
end prototypes

private function integer wf_assemblemsg (ref n_cst_msg anv_msg);n_cst_msg	lnv_msg
S_parm		lstr_Parm

lstr_Parm.is_Label = "SELECTEDTOPIC"
lstr_Parm.ia_Value = is_SelectedTopic
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "EQUIPMENTID"
lstr_Parm.ia_Value = il_EquipmentID
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "EMPLOYEEID"
lstr_Parm.ia_Value = il_EmployeeID
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "FREEFORM"
lstr_Parm.ia_Value = ib_FreeForm
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "TEMPLATEPATH"
lstr_Parm.ia_Value = is_TemplatePath
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "DEVICE"
lstr_Parm.ia_Value = is_SelectedDevice
lnv_Msg.of_Add_Parm ( lstr_Parm )

CHOOSE CASE is_selectedTopic
		
	CASE  n_cst_constants.cs_ReportTopic_COMPANY
		IF upperBound ( inva_companies[]) > 0 THEN
		
			lstr_Parm.is_Label = "DATA"
			lstr_Parm.ia_Value = inva_companies
			lnv_Msg.of_Add_Parm ( lstr_Parm )
		END IF

	CASE n_cst_constants.cs_ReportTopic_EVENT ,n_cst_constants.cs_ReportTopic_SHIPMENT
		
		IF upperBound ( inva_events[] ) > 0 THEN
			lstr_Parm.is_Label = "DATA"
			lstr_Parm.ia_Value = inva_events
			lnv_Msg.of_Add_Parm ( lstr_Parm )
		END IF
		
END CHOOSE

anv_msg = lnv_Msg

RETURN 1
end function

private function integer wf_populatedestinations ();// Returns 1, -1
// This function will transform the raw id into the desired display value it will 
// not insert duplicate values

Long	ll_EquipmentID
Long	ll_EmployeeID
Long	i
Long	ll_RowCount

String	ls_Value

Int		li_Return = 1

n_cst_equipmentManager	lnv_equipmentManager
n_cst_EmployeeManager	lnv_EmployeeManager

SetPointer ( HOURGLASS! )

IF isValid ( idwc_Destination ) THEN
	ll_RowCount = idwc_Destination.RowCount ( )
	For i = ll_RowCount TO 1 Step -1
			
		ls_Value = ""
		ll_EmployeeID = 0
		ll_EquipmentID = 0
			
		ll_EmployeeID = idwc_Destination.GetItemNumber ( i , "employeeid")
		ll_EquipmentID = idwc_Destination.GetItemNumber ( i , "equipmentid")
		IF ll_EmployeeID > 0 THEN
		
			lnv_EmployeeManager.of_DescribeEmployee ( ll_EmployeeID, ls_Value , 101 /*Lname 1st*/)
			
			IF idwc_Destination.Find ( "destination = '" + ls_Value +"'" , 1 , 999999) > 0 THEN
				idwc_Destination.DeleteRow ( i ) 
				CONTINUE
			END IF
			idwc_Destination.SetItem ( i , "destination" , ls_Value)
			
		ELSEIF ll_EquipmentID > 0 THEN
			
			lnv_EquipmentManager.of_Get_Description ( ll_EquipmentID , "SHORT_REF!", ls_Value )
			
			IF idwc_Destination.Find ( "destination = '" + ls_Value +"'" , 1 , 999999) > 0 THEN
				idwc_Destination.DeleteRow ( i )
				CONTINUE 
			END IF
			idwc_Destination.SetItem ( i , "destination" , ls_Value)
		END IF
		
		
		
	
	NEXT 
ELSE
	li_Return = -1
END IF
	
Return li_Return 

end function

private function string wf_getselecteddestinationstring ();// Returns 1, -1
// This function will transform the raw id into the desired display value it will 
// not insert duplicate values

Long	ll_EquipmentID
Long	ll_EmployeeID
Long	i
Long	ll_RowCount

String	ls_Value

Int		li_Return = 1

n_cst_equipmentManager	lnv_equipmentManager
n_cst_EmployeeManager	lnv_EmployeeManager

SetPointer ( HOURGLASS! )


IF ll_EmployeeID > 0 THEN

	lnv_EmployeeManager.of_DescribeEmployee ( ll_EmployeeID, ls_Value , 101 /*Lname 1st*/)
	
	
ELSEIF ll_EquipmentID > 0 THEN
	
	lnv_EquipmentManager.of_Get_Description ( ll_EquipmentID , "SHORT_REF!", ls_Value )
	
END IF
		
	
Return ls_Value


end function

private function integer wf_next ();// this is the method that should be called to move to the next state. Don't call the 
// specific state directly
//Returns 1 if successful, -1 if we do not make it to next state
Integer	li_Return = 1
String	lsa_Topic[]
String	ls_TemplateFolder
Long		ll_Row
Long		ll_Null
Long		ll_Destination
String	ls_Needed
String	ls_Template
String	lsa_NonMobileDevices[]


n_cst_Msg	lnv_Msg
s_parm		lstr_Parm
w_templateSelection lw_DataSelection


//n_cst_Beo_Event	lnva_Events[]
//n_cst_Beo_Event	lnv_Event
n_cst_LicenseManager	lnv_LicManager

SetNull (ll_Null)

lsa_Topic[1] = n_cst_constants.cs_ReportTopic_EVENT
lsa_Topic[2] = n_cst_constants.cs_ReportTopic_COMPANY
lsa_Topic[3] = n_cst_constants.cs_ReportTopic_SHIPMENT

CHOOSE CASE ii_CurrentState
		
	CASE 0 // just opened
		n_cst_bso_Communication_Manager	lnv_CommManager
		lnv_CommManager = CREATE n_cst_bso_Communication_Manager

		IF Not lnv_LicManager.of_HasMobileCommunicationsLicense ( ) THEN
			IF lnv_CommManager.of_GetLicensedNonMobileDevices ( lsa_NonMobileDevices )  = 1 THEN
				IF UpperBound ( lsa_NonMobileDevices ) > 0 THEN
					is_SelectedDevice = lsa_NonMobileDevices[1]
				END IF
			END IF
		END IF
		DESTROY ( lnv_CommManager )
		
		IF Len ( Trim ( is_SelectedDevice ) ) > 0 THEN
			ib_DisableState1 = true
			THIS.wf_GotoState2 ( )
		ELSE
			THIS.wf_GoToState1 ( )
		END IF
		
		
	CASE 1 // selecting dest. and device
		is_SelectedDevice = dw_Selection.GetItemString ( 1 , "device")
		ll_Destination = dw_Selection.GetItemNumber ( 1 , "destination")
		IF Len (is_SelectedDevice ) > 0 THEN
		ELSE
			ls_Needed = "device"
		END IF
		
		IF  (ll_Destination ) >0 OR is_SelectedDevice = n_cst_Constants.cs_ClipBoard THEN
		ELSE
			ls_Needed = "message destination"
		END IF
		
		IF len ( ls_Needed ) > 0 THEN
			MessageBox ( "Outbound Message" , "Please select a " + ls_Needed + "." )
			li_Return = -1
		ELSE
			IF ib_FreeForm THEN
				THIS.wf_GoToState3 ( )
			ELSE
				THIS.wf_GotoState2 ( )
			END IF
		END IF
			
	CASE 2 // select topic
		ll_Row = dw_Folders.GetRow()
		IF ll_Row > 0 THEN
			ls_TemplateFolder = dw_Folders.object.foldername[ll_Row]
	
			//drill down to lowest folder
			wf_Getsubfolder ( ls_TemplateFolder )
		END IF
		THIS.wf_GotoState3 ( )
				
		
	CASE 3 // select template
		
		ls_Template = dw_Selection.GetItemString ( 1 , "template")
		IF Len ( Trim ( ls_Template ) ) > 0 THEN
			cb_5.Enabled = False
			IF THIS.wf_SendData ( ) = 1 THEN
				Post Close ( THIS) // MFS 3/26/07 - Added post incase we are returning from wf_autoselect()
			END IF
			cb_5.Enabled = True
		ELSE
			MessageBox ( "Outbound Message" , "Please select a message template." )
			li_Return = -1
		END IF
	CASE ELSE // error 
		li_Return = -1
END CHOOSE

Return li_Return

end function

private function integer wf_back ();

CHOOSE CASE ii_CurrentState
		
	CASE 1 // open
		
		
	CASE 2 // select topic

		THIS.wf_GotoState1 ( )
		
	CASE 3 // select template
		IF ib_FreeForm THEN
			THIS.wf_GotoState1 ( )
		ELSE
			THIS.wf_GotoState2 ( )
		END IF
		
	CASE ELSE // error 
		
END CHOOSE
Return 1
end function

private function integer wf_gotostate2 ();
String	ls_Topic, &
			lsa_Topic[]

integer	li_TopicCnt, &
			li_Index, &
			li_Ret
			
long		ll_NewRow

string	ls_FolderName

s_Parm		lstr_Parm
n_cst_filesrvwin32	lnv_filesrvwin32
n_cst_dirattrib		lnv_dirattrib[]
lnv_filesrvwin32 = CREATE n_cst_FileSrvwin32

ii_CurrentState = 2
cbx_alldestinations.Visible = FALSE
cb_5.Text = "&Next >>"
st_topic.Visible = TRUE
cb_5.Enabled = TRUE
dw_Folders.Visible = TRUE
dw_Selection.Visible = FALSE
IF ib_DisableState1 THEN
	cb_3.Enabled = FALSE
ELSE
	cb_3.Enabled = TRUE	
END IF



IF inv_msg.of_Get_Parm ( "TOPICARRAY", lstr_Parm ) > 0 THEN
	
	lsa_Topic = lstr_Parm.ia_Value
ELSE
	IF ii_numevents = 1 THEN
		lsa_Topic[1] = n_cst_constants.cs_ReportTopic_EVENT
		lsa_Topic[2] = n_cst_constants.cs_ReportTopic_COMPANY
	ELSEIF ii_numevents > 1 THEN
		lsa_Topic[1] = n_cst_constants.cs_ReportTopic_SHIPMENT
	END IF
END IF

dw_Folders.dataobject = "d_folders"

//communication path  + topic

li_Ret = wf_GetSystemTemplatePath( is_templatepath )
IF li_Ret > 0 THEN
	
	// determine the number of events selected and limit the topic selection here
	
	
	li_TopicCnt = upperbound ( lsa_Topic ) 

	FOR li_Index = 1 to li_TopicCnt
		ls_FolderName = is_templatepath + lsa_Topic [li_Index]
		IF lnv_filesrvwin32.of_directoryexists ( ls_FolderName ) THEN
			ll_NewRow = dw_Folders.InsertRow(0)
			IF ll_NewRow > 0 THEN
				dw_Folders.object.foldername [ll_NewRow] = lsa_Topic [li_Index]
			END IF
		END IF
	NEXT
	
ELSE
	messagebox ( "Send OutBound Message", "Template folder path not defined in system settings.")
END IF
		
dw_Folders.SelectRow ( 1, TRUE )
dw_Folders.SetFocus()
dw_folders.Visible = TRUE


DESTROY lnv_filesrvwin32
Return 1
end function

private function integer wf_getsubfolder (ref string as_folder);//test folder selection
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

dw_Folders.dataobject = "d_folders"
dw_Folders.SetTransObject ( SQLCA )

//IF Right ( is_path , 1 ) = "\" THEN
//	is_path = is_path  + as_folder
//ELSE
//	is_path = is_path + "\" + as_folder
//END IF

IF Right ( is_templatepath , 1 ) = "\" THEN
	is_templatepath = is_templatepath  + as_folder
ELSE
	is_templatepath = is_templatepath + "\" + as_folder
END IF

li_FolderCnt=lnv_filesrvwin32.of_dirlist ( is_templatepath + "\*.*", 16, lnv_dirattrib ) 
	//DirList clears the array
	//16 Represents folders)  See PB DirList()

IF li_FolderCnt > 0 then

//		mle_1.TEXT = "Send a message about:"
		FOR li_Index = 1 to li_FolderCnt
			
			IF lnv_dirAttrib[li_Index].ib_Subdirectory THEN
				ls_FolderName = lnv_dirAttrib[li_Index].is_FileName
				
				//remove folder brackets	
				ls_FolderName = mid ( ls_FolderName, 2, len ( ls_FolderName ) - 2 )
				
				IF ls_FolderName = ".." or ls_FolderName = "." THEN CONTINUE

				li_subfolders ++

				IF Len ( ls_FolderName ) > 0 THEN
					ll_NewRow = dw_Folders.InsertRow(0)
					
					IF ll_NewRow > 0 THEN
						dw_Folders.object.foldername [ll_NewRow] = ls_FolderName
						
					END IF
				END IF
				
			END IF
		
		NEXT
	
dw_Folders.SelectRow ( 1, TRUE )

END IF

CHOOSE CASE as_folder
		
	CASE n_cst_constants.cs_ReportTopic_EVENT, &
		  n_cst_constants.cs_ReportTopic_COMPANY, &
	     n_cst_constants.cs_ReportTopic_SHIPMENT
		  
		

			is_SelectedTopic = as_folder

END CHOOSE

DESTROY lnv_filesrvwin32

//is_templatePath = is_Path

return li_SubFolders




end function

private function integer wf_getsystemtemplatepath (ref string as_path);Integer 	li_Return
String	ls_Path

li_Return = 1

n_cst_setting_templatespathfolder	lnv_PathSetting
lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
ls_Path = lnv_PathSetting.of_Getvalue( )
DESTROY ( lnv_PathSetting )

IF len ( ls_Path ) = 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	as_Path = ls_Path + "MESSAGE\"+is_selecteddevice+"\OUTBOUND\"
END IF

return li_return
end function

private function integer wf_gotostate3 ();String 	ls_Folder
Long		ll_Row
Boolean	lb_Continue = TRUE
Int		li_Return 

ii_CurrentState = 3
dw_Folders.Visible = FALSE	
st_topic.Visible = FALSE
cbx_alldestinations.Visible = FALSE
cb_3.Enabled = TRUE
dw_Selection.Visible = TRUE
dw_selection.object.st_template.visible = 1
dw_selection.object.template.visible = 1

dw_selection.object.st_destination.visible = 0
dw_selection.object.destination.visible = 0

dw_selection.object.st_device.visible = 0
dw_selection.object.device.visible = 0
dw_Selection.SetFocus ( )


cb_5.Text = "&Send"

dw_Selection.Event ue_FilterTemplates ( ) //MFS 3/26/07 - Removed Post of event
dw_Selection.Event ue_AutoSelectTemplate()



RETURN li_Return 
end function

private function integer wf_gotostate1 ();
boolean	lb_ShowDest
Int		li_ShowDest



ii_CurrentState = 1

cb_5.Text = "&Next >>"
cb_5.Enabled = TRUE
cb_3.Enabled = FALSE
st_topic.Visible = FALSE
// set visible
dw_Folders.Visible = FALSE
dw_Selection.Visible = TRUE
cbx_alldestinations.Visible = TRUE

dw_selection.object.destination.object.destination.visible = 1
dw_selection.object.destination.object.type.visible = 0

dw_selection.object.device.object.destination.visible = 0
dw_selection.object.device.object.type.visible = 1


dw_selection.object.st_template.visible = 0
dw_selection.object.template.visible = 0

dw_selection.object.st_destination.visible = 1
dw_selection.object.destination.visible = 1

dw_selection.object.st_device.visible = 1
dw_selection.object.device.visible = 1

dw_Selection.SetFocus ( )
idwc_device.SetFilter ( "" )
idwc_device.Filter ( )

return 1

end function

private function integer wf_lookforsubfolders (string as_folder);//test folder selection
integer	li_FolderCnt, &
			li_Index, &
			li_Ret, &
			li_SubFolders
			
long		ll_NewRow
String	ls_TempPath

string	ls_FolderName
			
//window lw_ActiveSheet

n_cst_filesrvwin32	lnv_filesrvwin32
n_cst_dirattrib		lnv_dirattrib[]

lnv_filesrvwin32 = CREATE n_cst_FileSrvwin32

//dw_Folders.dataobject = "d_folders"
dw_Folders.SetTransObject ( SQLCA )

//IF Right ( is_path , 1 ) = "\" THEN
//	ls_TempPath = is_path  + as_folder
//ELSE
//	ls_TempPath = is_path + "\" + as_folder
//END IF

IF Right ( is_templatepath , 1 ) = "\" THEN
	ls_TempPath = is_templatepath  + as_folder
ELSE
	ls_TempPath = is_templatepath + "\" + as_folder
END IF


li_FolderCnt=lnv_filesrvwin32.of_dirlist ( ls_TempPath + "\*.*", 16, lnv_dirattrib ) 
	//DirList clears the array
	//16 Represents folders)  See PB DirList()

IF li_FolderCnt > 0 then

//		mle_1.TEXT = "Send a message about:"
		FOR li_Index = 1 to li_FolderCnt
			
			IF lnv_dirAttrib[li_Index].ib_Subdirectory THEN
				ls_FolderName = lnv_dirAttrib[li_Index].is_FileName
				
				//remove folder brackets	
				ls_FolderName = mid ( ls_FolderName, 2, len ( ls_FolderName ) - 2 )
				
				IF ls_FolderName = ".." or ls_FolderName = "." THEN CONTINUE

				li_subfolders ++

//				IF Len ( ls_FolderName ) > 0 THEN
//					ll_NewRow = dw_Folders.InsertRow(0)
//					
//					IF ll_NewRow > 0 THEN
//						dw_Folders.object.foldername [ll_NewRow] = ls_FolderName
//						
//					END IF
//				END IF
//				
			END IF
		
		NEXT
	
//dw_Folders.SelectRow ( 1, TRUE )

END IF

DESTROY lnv_filesrvwin32

return li_SubFolders



RETURN 1
end function

protected function integer wf_senddata ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	wf_SendData
//
//	Access:  Protected
//
//	Arguments:  None
//
//
//	Description:	This will round up the selected data from dw_selection.
//						It will populate arrays of structures 'S_outboundMessage'. one structure
//						for each message, and one array for each message device
//						(Qualcomm , nextel, intouch)					
//						Each array will be sent to the appropriate object via a message
//						object to process the outbound message.
//				
//						Returns: 1, success - message sent successfully to file
//									-1, error - message could not be sent 	( default )
//
//						In the case that a communication device needs to be added
// 					an array for that device must be added as well as an addition to
//						to case statement, and the logic needed to send it to the appropriate 
//						object.
//
//
// Written by: Rick Zacher
// 		Date: 11/17/00
//		Version: 3.0.4
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////



Long		ll_RowCount
Long		ll_Row
Long		ll_FoundRow
Int		li_QualRtn
Long		ll_Destination
Long		ll_EmployeeID
Long		ll_EquipmentID
//String 	ls_Path 
String	ls_Topic
String	ls_DocName
String	ls_Needed = ""
String	ls_SentToDevice
String	ls_Device, &
			ls_CommunicationObject
			
Boolean	lb_Continue = TRUE
Int		li_Return = -1

n_cst_msg	lnv_Msg
S_Parm		lstr_Parm
n_cst_bso_Communication_Manager lnv_Communication
S_outboundMessage	lstra_QualOutbound[],&
						lstra_NextOutbound[],&
						lstra_InTouchOutbound[],&
						lstra_AtRoadOutbound[],&
						lstr_Outbound, &
						lstra_outBound[ ]
						
SetPointer(HourGlass!)

IF ib_FreeForm AND Len ( Trim ( is_FreeFormText )) = 0 THEN
	IF MessageBox ( "Free Form Text" , "You have not entered any text. Would you like to send the message anyway?" , QUESTION! , YesNo! , 2 ) = 2 THEN
		lb_Continue = FALSE
	END IF
END IF
	

ll_RowCount = dw_Selection.RowCount ( ) 

IF ll_RowCount > 0 AND lb_Continue THEN
	FOR ll_Row = 1 TO ll_RowCount 
		ls_Needed = ""
		
		ls_DocName = dw_Selection.GetItemString (ll_Row ,  "template")
		
		ls_Device = is_SelectedDevice
		ll_Destination = dw_Selection.GetItemNumber ( ll_Row , "destination")
		
		IF ib_FreeForm THEN
			lstr_Outbound.is_Template = is_TemplatePath + "message\" + ls_Device + "\outbound\" + ls_DocName
		ELSE
			IF Right ( is_TemplatePath , 1 ) <> "\" THEN
				is_TemplatePath += "\"
			END IF
			lstr_Outbound.is_Template = is_TemplatePath + ls_DocName
		END IF
		
		lstr_Outbound.is_device = ls_Device 
		lstr_Outbound.is_Topic = is_SelectedTopic
		
		ll_FoundRow = idwc_device.Find ( "id = " + String (ll_Destination) , 1, 99999) 

		IF ll_FoundRow > 0 THEN		
			ll_EmployeeID = idwc_device.GetItemNumber ( ll_FoundRow , "employeeid" )
			ll_EquipmentID = idwc_device.GetItemNumber ( ll_FoundRow , "equipmentid" )
			
			IF ll_EmployeeID > 0 THEN
				lstr_Outbound.il_Destination = ll_EmployeeID
			ELSEIF   ll_EquipmentID > 0 THEN
				lstr_Outbound.il_Destination = ll_EquipmentID
			END IF

		END IF
	
		IF Len ( Trim ( ls_DocName ) ) < 1 THEN
			ls_needed = "template"
		END IF
		
		IF  Len ( Trim ( ls_Device  ) ) < 1  OR IsNull (ls_Device ) THEN
			ls_Needed = "device"
		END IF
		
		IF ls_Device <> n_cst_constants.cs_Clipboard THEN
			IF lstr_Outbound.il_Destination = 0    THEN
				ls_Needed = "destination"
			END IF
		END IF
		
		IF Len ( ls_Needed ) > 0 THEN
			MessageBox ( "Outbound Message" , "Please select a message " + ls_Needed + "." )
			lb_Continue = FALSE
			EXIT
		END IF
	
		CHOOSE CASE lstr_Outbound.is_device
				
			CASE n_cst_constants.cs_CommunicationDevice_Qualcomm 
				lstra_QualOutbound [ UpperBound ( lstra_QualOutbound ) + 1 ] = lstr_OutBound
				ls_CommunicationObject = "n_cst_bso_Communication_QualComm"
				ls_SentToDevice = " to Qualcomm."
					
			CASE n_cst_constants.cs_CommunicationDevice_Nextel
				lstra_NextOutbound [ UpperBound ( lstra_NextOutbound ) + 1 ] = lstr_OutBound
				ls_CommunicationObject = "n_cst_bso_Communication_Nextel"
				ls_SentToDevice = " to Nextel."

			CASE n_cst_constants.cs_CommunicationDevice_InTouch
				lstra_InTouchOutbound [ UpperBound ( lstra_InTouchOutbound ) + 1 ] = lstr_OutBound
				ls_CommunicationObject = "n_cst_bso_Communication_Intouch"
				ls_SentToDevice = " to InTouch."
				
			CASE n_cst_constants.cs_CommunicationDevice_AtRoad
				lstra_AtRoadOutbound [ UpperBound ( lstra_AtRoadOutbound ) + 1 ] = lstr_OutBound
				ls_CommunicationObject = "n_cst_bso_Communication_AtRoad"			
				ls_SentToDevice = " to AtRoad."
				
			CASE n_cst_constants.cs_ClipBoard
				
				ls_CommunicationObject = "n_cst_bso_Communication_Manager"
				
				lstr_parm.is_Label = n_cst_constants.cs_ClipBoard
				lstr_Parm.ia_Value = TRUE
				lnv_msg.of_Add_Parm ( lstr_Parm )
				ls_SentToDevice = " to the clipboard."
				
		END CHOOSE
		
	NEXT
	
END IF

IF lb_Continue THEN
	
	lstra_outBound [ upperbound ( lstra_outBound ) + 1 ] = lstr_outBound
	
	IF len ( ls_CommunicationObject ) > 0 THEN
		
		lnv_Communication = CREATE USING ls_CommunicationObject
		
	END IF

	THIS.wf_assembleMsg ( lnv_Msg )

	lstr_parm.is_Label = "MESSAGES"
	lstr_Parm.ia_Value = lstra_OutBound
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
	IF ib_FreeForm THEN
		lstr_parm.is_Label = "FREEFORMTEXT"
		lstr_Parm.ia_Value = is_freeformtext
		lnv_msg.of_Add_Parm ( lstr_Parm )
	END IF
	
	IF isValid ( lnv_Communication ) THEN
		IF lnv_Communication.of_SendOutBound ( lnv_Msg ) = 1 THEN
			li_Return = 1
		END IF
	ELSE
		li_Return = -1
	END IF
	
	IF li_Return = 1 THEN
		
		MessageBox( "Outbound Message" , "Profit Tools has successfully exported the message" + ls_SentToDevice )
		li_Return = 1
		// success here!
		
	ELSE
		MessageBox( "Outbound Message" , "An error occurred while attempting to export the requested message" + ls_SentToDevice ) 
	END IF
	
	DESTROY lnv_Communication
	
END IF








//
//IF UpperBound ( lstra_NextOutbound ) > 0 AND lb_Continue THEN
//	
//END IF
//
//IF upperbound ( lstra_InTouchOutbound ) > 0 AND lb_Continue THEN
//	
//	IF len ( ls_CommunicationObject ) > 0 THEN
//		
//		lnv_Communication = CREATE USING ls_CommunicationObject
//		
//	END IF
//	
////	lnv_QualComm = CREATE n_cst_bso_Communication_QualComm
//	THIS.wf_assembleMsg ( lnv_Msg )
//	
//	lstr_parm.is_Label = "MESSAGES"
//	lstr_Parm.ia_Value = lstra_InTouchOutbound
//	lnv_Msg.of_Add_Parm ( lstr_Parm )
//	
//	IF ib_FreeForm THEN
//		lstr_parm.is_Label = "FREEFORMTEXT"
//		lstr_Parm.ia_Value = is_freeformtext
//		lnv_Msg.of_Add_Parm ( lstr_Parm )
//	END IF
//	
//	IF lnv_Communication.of_SendOutBound ( lnv_Msg ) = 1 THEN
//		li_QualRtn = 1
//	END IF
//	
//	IF li_QualRtn = 1 THEN
//		MessageBox( "Outbound Message" , "Profit Tools has successfully exported the message. Transmission will be completed at the next scheduled interval." )
//		li_Return = 1
//		// success here!
//		
//	ELSE
//		MessageBox( "Outbound Message" , "An error occurred while attempting to export the requested message." ) 
//	END IF
//	
//	DESTROY lnv_Communication
//		
//	
//END IF

RETURN li_Return 
end function

public function integer wf_addmiscdevices ();// this method will return the number if additional devices added

Long		ll_NewDeviceRow
Int		li_Return = 0
Int		i
Int		li_NumDevices
String 	lsa_Devices[]


n_cst_bso_Communication_Manager	lnv_Manager
n_cst_LicenseManager	lnv_LicManager

lnv_manager = CREATE n_cst_bso_Communication_manager

IF lnv_LicManager.of_GetLicensed ( n_cst_Constants.cs_Module_Clipboard ) THEN
	IF isValid ( idwc_device ) THEN
		
		li_NumDevices = lnv_Manager.of_GetMiscDevices ( lsa_Devices ) 
		For i = 1 To li_NumDevices
			ll_NewDeviceRow = idwc_device.InsertRow (0)
			idwc_device.setitem( ll_newDeviceRow ,"type", lsa_Devices[i] )
			li_Return ++
		Next
		
	END IF
END IF

RETURN li_Return
end function

public function integer wf_autoselect ();//Returns the state we have auto-selected to
String	ls_SelectedTemplate
//We are not going to drill down to sub-folders during state 2 here

DO until ii_currentstate = 3

	IF THIS.wf_Next ( ) <> 1 THEN
		EXIT //Could not get to next state, exit loop
	END IF
			
LOOP

//If we are sending directions, autosend
IF ii_currentstate = 3 AND is_SelectedTopic = n_cst_Constants.cs_ReportTopic_Company THEN
	
	ls_SelectedTemplate = dw_Selection.GetItemString ( 1 , "template")
	
	IF Lower(ls_SelectedTemplate) = Lower(cs_Template_Directions) THEN
		This.wf_Next() //Send
	END IF
	
END IF


Return ii_CurrentState
end function

on w_communication_outbound.create
int iCurrent
call super::create
this.dw_selection=create dw_selection
this.cbx_alldestinations=create cbx_alldestinations
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_editmsg=create cb_editmsg
this.cb_3=create cb_3
this.st_destination=create st_destination
this.st_device=create st_device
this.st_topic=create st_topic
this.dw_folders=create dw_folders
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_selection
this.Control[iCurrent+2]=this.cbx_alldestinations
this.Control[iCurrent+3]=this.cb_5
this.Control[iCurrent+4]=this.cb_6
this.Control[iCurrent+5]=this.cb_editmsg
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.st_destination
this.Control[iCurrent+8]=this.st_device
this.Control[iCurrent+9]=this.st_topic
this.Control[iCurrent+10]=this.dw_folders
end on

on w_communication_outbound.destroy
call super::destroy
destroy(this.dw_selection)
destroy(this.cbx_alldestinations)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_editmsg)
destroy(this.cb_3)
destroy(this.st_destination)
destroy(this.st_device)
destroy(this.st_topic)
destroy(this.dw_folders)
end on

event open;call super::open;inv_Msg = message.powerobjectParm
ib_DisableCloseQuery = TRUE 

dw_selection.object.st_template.visible = 0
dw_selection.object.template.visible = 0

S_Parm 	lstr_Parm
n_cst_msg	lnv_msg

Long		ll_FindRtn 
Long		ll_ID
String	ls_Device
String	ls_Text
Long     i
Long		ll_NewRow
Long		ll_NewDeviceRow
Long		ll_RowCount
Boolean	lb_Continue = TRUE
Boolean	lb_AutoSelect
String	ls_Null
String	ls_TemplatePath
Any		la_String
Integer	li_Return = 1
 

s_BeoArrays	lstr_Beos
s_emp_info	lstr_Employee
DataStore	lds_Null
SetNull ( ls_Null )
n_cst_Settings	lnv_settings


n_cst_EmployeeManager	lnv_EmployeeManager
n_cst_EquipmentManager	lnv_EquipmentManager

IF lnv_Equipmentmanager.of_Get_Retrieved_Equip ( ) = FALSE THEN
	
	lnv_Equipmentmanager.of_RefreshActive ( )
	
END IF


IF isValid (inv_msg ) THEN
	// these are set as instances so they can be reassembled later in wf_assembleMsg()
	IF inv_Msg.of_Get_Parm ( "SELECTEDTOPIC" , lstr_Parm ) <> 0 THEN
		is_SelectedTopic = lstr_Parm.ia_Value 
	END IF
	
	IF inv_msg.of_Get_Parm ( "EQUIPMENTID" , lstr_Parm ) <> 0 THEN
		il_EquipmentID = Long (lstr_Parm.ia_Value)
	END IF
	
	IF inv_msg.of_Get_Parm ( "EMPLOYEEID" , lstr_Parm ) <> 0 THEN
		il_EmployeeID = Long (lstr_Parm.ia_Value)
	END IF
	
	IF inv_msg.of_Get_Parm ( "DEVICE" , lstr_Parm ) <> 0 THEN
		ls_Device = lstr_Parm.ia_Value
	END IF
	
	IF inv_msg.of_Get_Parm ( "FREEFORM" , lstr_Parm ) <> 0 THEN
		ib_FreeForm = lstr_Parm.ia_Value
	END IF
	
	IF inv_msg.of_Get_Parm ( "TEMPLATEPATH" , lstr_Parm ) <> 0 THEN
		is_TemplatePath = lstr_Parm.ia_Value
	END IF
	
	IF inv_msg.of_Get_Parm ( "NUMEVENTS" , lstr_Parm ) <> 0 THEN
		ii_numEvents = lstr_Parm.ia_Value
	END IF
	
	IF inv_msg.of_Get_Parm ( "BEOS" , lstr_Parm ) <> 0 THEN
		lstr_Beos = lstr_Parm.ia_Value
		inva_companies[] = lstr_Beos.inva_Companies
		inva_events[] = lstr_Beos.inva_Events
	END IF
	
	IF inv_msg.of_Get_Parm ( "AUTOSELECT" , lstr_Parm ) <> 0 THEN
		lb_AutoSelect = lstr_Parm.ia_Value
	END IF
	
END IF
	
IF ib_FreeForm THEN
	Open ( w_FreeForm_text )
	IF isValid ( message.powerobjectparm ) THEN
		lnv_msg = Message.powerobjectParm
		
		IF lnv_Msg.of_GEt_Parm ( "CONTINUE" , lstr_Parm ) <> 0 THEN
			lb_Continue = lstr_Parm.ia_Value
		END IF
		
		IF lnv_Msg.of_Get_Parm ( "TEXT" , lstr_parm ) <> 0 THEN
			ls_Text = lstr_Parm.ia_Value
		END IF
		
		IF lb_Continue THEN
			is_freeformtext = ls_Text
		END IF
		
	END IF
	cb_EditMsg.Visible = TRUE
	
END IF
	
IF lb_Continue THEN
	dw_selection.getchild ("destination" , idwc_Destination )
	dw_selection.getchild ("template" , idwc_Template )
	dw_selection.getchild ("device" , idwc_Device )
	
	dw_selection.settransObject (sqlca )
	ll_NewRow = dw_selection.InsertRow (0)
	
	THIS.wf_PopulateDestinations ( )
	THIS.wf_AddMiscDevices ( )  // ie clipboard, e-mail
	
	
	IF il_EmployeeID > 0 THEN
		is_Filter =  "employeeid = " + String (il_Employeeid)
	END IF
	
	IF Len (is_Filter ) > 0 THEN 
		is_Filter += " OR "
	END IF
	
	IF il_Equipmentid > 0 THEN
		is_Filter += "equipmentid = " + String(il_Equipmentid)  
	END IF
	
	IF Len ( is_Filter ) > 0 THEN
		idwc_Destination.SetFilter (is_Filter )
	END IF
	
	idwc_Destination.Filter( )
	idwc_Destination.sort ( )
	
	IF idwc_Destination.RowCount ( ) = 0 THEN
		is_Filter = "" 
		idwc_Destination.SetFilter (is_Filter )
		idwc_Destination.Filter( )
		cbx_alldestinations.Enabled = FALSE
	END IF
	
//	 i start my find backwards in an attempt to have a successful match when i set the id.
//	 since i delete duplicates in the populateDestination ( ) function i was not getting a 
//	 successful match and the id could no be resolved. so i was ending up with the id in the 
//	 display. however the backwards find approach seems to work.
	IF Not IsNull ( il_EquipmentID ) THEN
		
		ll_FindRtn = idwc_Device.Find ( "equipmentid = " + STring ( il_EquipmentID ),999999,1 )
		IF ll_FindRtn > 0 THEN
			ll_ID = idwc_Device.GetItemNumber ( ll_FindRtn , "id" )
			dw_Selection.SetItem ( ll_NewRow , "Destination" , ll_ID )
		END IF
		
	END IF
		
	IF Not IsNull ( il_EmployeeID  ) THEN
		
		ll_FindRtn = idwc_Device.Find ( "employeeid = " + STring ( il_EmployeeID ),999999,1 )
		IF ll_FindRtn > 0 THEN
			ll_ID = idwc_Device.GetItemNumber ( ll_FindRtn , "id" )
			dw_Selection.SetItem ( ll_NewRow , "Destination" , ll_ID )
		END IF
	
	END IF
	
	
	
	IF ll_FindRtn > 0 THEN
		ls_Device = idwc_Device.GetItemString ( ll_FindRtn , "type" )
		dw_Selection.SetItem ( ll_NewRow , "Device" , ls_Device)
	END IF
	
	
	IF is_Filter = "" THEN
		cbx_alldestinations.Checked = TRUE
	END IF
	 
END IF


IF Not lb_Continue THEN
	CLOSE ( THIS )
ELSE
	IF lb_AutoSelect THEN
		This.Post wf_AutoSelect()
	ELSE
		THIS.wf_Next ( )
	END IF
END IF



end event

event pfc_cancel;call super::pfc_cancel;Close ( THIS ) 
end event

event pfc_default;string	ls_TemplateFolder
integer	li_Ret
Long	ll_Row

IF ii_currentState = 2 THEN
	ll_Row = dw_Folders.GetRow()
	if ll_row > 0 then
		ls_TemplateFolder = dw_Folders.object.foldername[ll_Row]
		
		li_Ret = wf_LookForsubfolders ( ls_TemplateFolder )
		
		IF li_Ret > 0 THEN  // subfolders exist 
			//drill down to lowest folder
			wf_Getsubfolder ( ls_TemplateFolder )
		ELSE
			THIS.wf_Next ( )
		END IF
	end if
ELSE
	
	THIS.wf_Next ( )
	
END IF
	

end event

type cb_help from w_response`cb_help within w_communication_outbound
end type

type dw_selection from u_dw_communication_outbound within w_communication_outbound
event ue_removerow ( )
event ue_filterdevice ( )
event ue_filtertemplates ( )
event ue_freeform ( )
event ue_autoselecttemplate ( )
integer x = 96
integer y = 120
integer width = 791
integer height = 400
integer taborder = 60
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_removerow;Long	ll_CurrentRow
Int	li_MBoxRtn

IF THIS.RowCount( ) > 0 THEN

	ll_CurrentRow = THIS.GetRow( )

	IF ll_CurrentRow > 0 THEN
		
		li_MBoxRtn = MessageBox( "Delete Row" , "Are you sure you want to remove this message destination?", QUESTION! , YESNO! , 2 ) 
		IF li_MBoxRtn = 1 THEN
			THIS.DeleteRow ( ll_CurrentRow) 
		END IF
		
	ELSE
		MessageBox ( "Delete Row" , "Please select a row to remove." )
	END IF
END IF
	
	
end event

event ue_filterdevice;Long		ll_Employeeid , ll_EquipmentID, ll_CurrentRow
Int		li_FilterRtn
String	ls_Destination
String	ls_Filter 
String	ls_Type 
Long		ll_ChildRow
Long		ll_RowCount
String	ls_OldDevice
String	ls_NewDevice
Long		ll_FindRtn 

ll_CurrentRow = THIS.GetRow ( )
IF ll_CurrentRow > 0 THEN

	ll_ChildRow = idwc_destination.GetRow ( )
	IF ll_ChildRow > 0 THEN
		
		ls_OldDevice = idwc_device.GetItemString ( idwc_device.GetRow( ) , "type" )
		
		ll_EmployeeID = idwc_destination.GetItemNumber ( ll_ChildRow ,"employeeid")
		ll_EquipmentID = idwc_destination.GetItemNumber ( ll_ChildRow ,"equipmentid")
		
		IF ll_EmployeeID > 0 THEN
			ls_Filter = "employeeid = " + String (ll_employeeID )
		ELSE
			ls_Filter = "equipmentid = " + String (ll_EquipmentID)
		END IF
		
		IF Len ( ls_Filter ) > 0 THEN
			ls_Filter += " OR  " 
		END IF
		
		ls_Filter += " type = '" + n_cst_Constants.cs_ClipBoard +"'"	
		idwc_device.SetFilter ( ls_Filter )
		idwc_device.Filter () 
		
		ll_RowCount = idwc_Device.RowCount ( )
		IF ll_RowCount > 0 THEN
			idwc_Device.setRow ( 1 )
			
			IF Len ( Trim ( ls_OldDevice ) ) > 0 THEN
				ll_FindRtn = idwc_Device.Find ( "type = '" + ls_OldDevice + "'", 1, 99999 )
			END IF
			
			IF ll_FindRtn > 0 THEN
				This.SetItem ( ll_CurrentRow , "device" , ls_OldDevice )
			ELSEIF ll_RowCount = 1 THEN
				ls_NewDevice = idwc_device.GetItemString ( 1 , "type" )	
				This.SetItem ( ll_CurrentRow , "device" , ls_NewDevice )
			ELSE
				This.SetItem ( ll_CurrentRow , "device" , "" )
			END IF
		END IF
	
		
	END IF

END IF

end event

event ue_filtertemplates();Boolean	lb_FreeFormFound
String	ls_Device

Int 		i
Int		li_ShareRtn
Long		ll_NewRow
Long	ll_CurrentRow
String	ls_FileName 

Long	ll_ChildRow
n_cst_dirattrib	lnv_DirAttrib[]
n_cst_FileSrvwin32 lnv_FileSrv
n_cst_Settings	lnv_Settings



ll_CurrentRow = THIS.GEtRow ( )
IF ll_CurrentRow > 0 THEN

	lnv_FileSrv = CREATE n_cst_FileSrvwin32

	
	IF Not IsValid( ids_Templates ) THEN
		ids_Templates = CREATE dataStore
	END IF
	
	ids_Templates.dataobject = "d_communication_template_list"
	
	ll_ChildRow = idwc_device.GetRow( )
	IF ll_ChildRow > 0 THEN
		ls_Device = idwc_device.GetItemString ( ll_ChildRow , "type" )
		IF ib_Freeform THEN
			lnv_FileSrv.of_DirList (  is_TemplatePath + "message\" +ls_Device + "\outbound\*.*" , 39, lnv_DirAttrib )

		ELSE
			lnv_FileSrv.of_DirList (  is_TemplatePath + "\*.*" , 39, lnv_DirAttrib )
		END IF
		
		ids_Templates.Reset ( )
		For i = 1 TO UpperBound( lnv_DirAttrib ) 
			ls_FileName = lnv_dirAttrib[i].is_FileName
			IF Len ( ls_FileName ) > 0 THEN
				IF ib_FreeForm THEN
					IF Pos ( Upper ( ls_FileName ) , "FREEFORM" ) > 0 THEN
						lb_FreeFormFound = TRUE
					ELSE
						CONTINUE
					END IF
				END IF
						
				ll_NewRow = ids_templates.InsertRow(0)
				
				IF ll_NewRow > 0 THEN
					ids_Templates.setitem ( ll_NewRow, "device" , ls_Device )
					ids_Templates.setitem ( ll_NewRow, "template" ,UPPER ( ls_FileName ))
				END IF
			END IF
		NEXT
		
		
	END IF
	
	DESTROY lnv_FileSrv
	
	IF ids_templates.rowcount() > 0 THEN
		li_ShareRtn = ids_templates.ShareData ( idwc_Template )
		this.object.template[ll_CurrentRow] = ids_templates.object.template[1]
	END IF
	
	IF ib_FreeForm AND ( NOT lb_FreeFormFound ) THEN
		THIS.SetItem ( ll_CurrentRow , "template" , "" )
		MessageBox ( "Free Form Message" , "Your selected device of " + ls_Device +" does not have any FreeForm templates available. Please create a free form template or select a different device." )
		THIS.SetRow ( ll_CurrentRow )
		THIS.SetColumn ( "device" )
	END IF
	
END IF

end event

event ue_freeform;String	ls_Text 
n_cst_msg	lnv_msg
s_Parm lstr_Parm
Boolean	lb_Continue
Long		ll_Row

ll_Row = THIS.GetRow() 
IF ll_Row > 0 THEN
	ls_Text = THIS.GetItemString ( ll_Row, "text" )
	
	openWithParm ( w_FreeForm_Text , ls_Text )
	
	IF IsValid ( Message.PowerobjectParm ) THEN
		lnv_msg = Message.PowerobjectParm
		IF lnv_Msg.of_Get_Parm ("CONTINUE" ,lstr_Parm )<> 0 THEN
			lb_Continue = lstr_Parm.ia_Value
		END IF
		
		IF lb_Continue THEN
			IF lnv_Msg.of_Get_Parm ("TEXT" ,lstr_Parm )<> 0 THEN
				ls_Text = lstr_Parm.ia_Value
			END IF
			IF Len(ls_Text ) > 0 THEN
				THIS.SetItem ( ll_Row , "text" , ls_Text )
			END IF
			
		END IF
	END IF
		
END IF
end event

event ue_autoselecttemplate();Long		ll_RowCount
Long		i
String	ls_Template

//Select the proper event template if they have the
//correct filename convention 

ll_RowCount = idwc_Template.RowCount()

IF is_SelectedTopic = n_cst_Constants.cs_ReportTopic_Company THEN
	
	FOR i = 1 TO ll_RowCount
		ls_Template = idwc_Template.GetItemString(i, "template")
		IF Lower(ls_Template) = Lower(cs_Template_Directions) THEN
			idwc_Template.SetRow(i)
			This.SetItem(1, "template", ls_Template)
			EXIT
		END IF
	NEXT
	
ELSE
	
	FOR i = 1 TO ll_RowCount
		ls_Template = idwc_Template.GetItemString(i, "template")
		IF Left(ls_Template, 1) = String(ii_numevents) THEN
			idwc_Template.SetRow(i)
			This.SetItem(1, "template", ls_Template)
			EXIT
		END IF
	NEXT
	
END IF


end event

event itemchanged;call super::itemchanged;Long		ll_Return
Long		ll_EmployeeID
Long		ll_EquipmentID
String 	ls_Filter

ll_Return = AncestorReturnValue

IF ll_Return = 0 THEN
	
	CHOOSE CASE Lower ( dwo.Name )
			
		CASE "destination"
			
			THIS.Event Post ue_FilterDevice ( )

		CASE "device"
			
			THIS.Event post ue_FilterTemplates ( )
			
		CASE "template"

	END CHOOSE
	
END IF

RETURN ll_Return
end event

event constructor;//Event ue_SetFocusIndicator( TRUE ) 
//THIS.SetRowFocusIndicator ( HAND! )
ib_rmbMenu = FALSE
end event

event pfc_addrow;call super::pfc_addrow;
Long	li_Return 

li_Return  = AncestorReturnValue

IF li_Return > 0 THEN
	THIS.SetRow( li_Return ) 
END IF

RETURN li_Return 
end event

event buttonclicked;

//THIS.Event ue_FreeForm ( )
	

end event

event pfc_preinsertrow;call super::pfc_preinsertrow;//Long	ll_Row
//String	ls_Destination
//String	ls_Device
//String	ls_Template
//String	ls_ErrorMessage
//
Int	li_Return 
//
li_Return = AncestorReturnValue
//IF li_Return = 1 THEN
//
//	ll_Row = THIS.GetRow ( )
//	
//	IF ll_Row > 0 THEN
//		ls_Destination = THIS.GetItemString( ll_Row , "destination")
//		ls_Device = THIS.GetItemString( ll_Row , "device")
//		ls_Template = THIS.GetItemString( ll_Row , "template")
//		
//		if isNull ( ls_Destination ) OR len ( ls_Destination ) < 1 THEN
//			ls_ErrorMessage = "Please select a message destination "
//		END IF
//		
//		if isNull ( ls_Device ) OR len ( ls_Device ) < 1 THEN
//			ls_ErrorMessage = "Please select a device "
//		END IF
//		
//		if isNull ( ls_Template ) OR len ( ls_Template ) < 1 THEN
//			ls_ErrorMessage = "Please select a message template "
//		END IF
//		
//	END IF 
//	
//	IF len (ls_ErrorMessage ) > 0 THEN
//		MessageBox ( "New Row" , ls_ErrorMessage + "before adding a new row" )
//		li_Return = -1
//	END IF
//
//END IF
//
RETURN li_Return 
end event

event rowfocuschanged;call super::rowfocuschanged;THIS.Event  post ue_FilterDevice ( )
THIS.Event  post ue_FilterTemplates ( )
end event

type cbx_alldestinations from checkbox within w_communication_outbound
integer x = 23
integer y = 20
integer width = 795
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Drop down &all destinations "
end type

event clicked;IF THIS.Checked = TRUE THEN
	idwc_Destination.SetFilter ( "" )
	idwc_Destination.Filter( )
ELSE
	IF idwc_Destination.SetFilter (is_Filter ) = -1 THEN
		idwc_Destination.SetFilter ( "" )
	END IF
	idwc_Destination.Filter( )
END IF
end event

type cb_5 from u_cbok within w_communication_outbound
integer x = 891
integer y = 124
integer width = 293
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
string text = "&Next >>"
end type

type cb_6 from u_cbcancel within w_communication_outbound
integer x = 891
integer y = 348
integer width = 293
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
end type

type cb_editmsg from commandbutton within w_communication_outbound
boolean visible = false
integer x = 891
integer y = 460
integer width = 293
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Edit &Msg"
end type

event clicked;String		ls_Text
Boolean		lb_Continue
n_cst_msg	lnv_msg
S_Parm		lstr_Parm

openWithParm ( w_Freeform_Text , is_freeformtext )

IF isValid ( message.powerobjectparm ) THEN
	lnv_msg = Message.powerobjectParm
	
	IF lnv_Msg.of_GEt_Parm ( "CONTINUE" , lstr_Parm ) <> 0 THEN
		lb_Continue = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "TEXT" , lstr_parm ) <> 0 THEN
		ls_Text = lstr_Parm.ia_Value
	END IF
	
	IF lb_Continue THEN
		is_freeformtext = ls_Text
	END IF
	
END IF
end event

type cb_3 from commandbutton within w_communication_outbound
integer x = 891
integer y = 236
integer width = 293
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "<< &Back"
end type

event clicked;Parent.wf_Back ( )
end event

type st_destination from statictext within w_communication_outbound
boolean visible = false
integer x = 37
integer y = 44
integer width = 471
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "destination"
boolean focusrectangle = false
end type

type st_device from statictext within w_communication_outbound
boolean visible = false
integer x = 37
integer y = 96
integer width = 471
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "device"
boolean focusrectangle = false
end type

type st_topic from statictext within w_communication_outbound
boolean visible = false
integer x = 27
integer y = 12
integer width = 818
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pick a message topic"
boolean focusrectangle = false
end type

type dw_folders from u_dw within w_communication_outbound
boolean visible = false
integer x = 23
integer y = 80
integer width = 791
integer height = 424
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_folders"
end type

event constructor;//Instantiate the default row focus indicator
//This.Event ue_SetFocusIndicator ( TRUE )

This.of_SetRowManager ( TRUE )
This.of_SetRowSelect ( TRUE )
This.inv_RowSelect.of_SetStyle ( 2 )
This.SetRowFocusIndicator ( FocusRect! )

This.of_SetInsertable ( FALSE )

end event

event doubleclicked;//Modified 4/5/05 BKW to add GetRow validation.  Norm was not checking this, and would cause crash if no templates.

s_Parm	lstr_Parm
string	ls_TemplateFolder
integer	li_Ret
Long		ll_Row

ll_Row = dw_Folders.GetRow()

IF ll_Row > 0 THEN
	
	ls_TemplateFolder = dw_Folders.object.foldername [ ll_Row ]

	//drill down to lowest folder
	li_Ret = wf_Getsubfolder ( ls_TemplateFolder )
	//is_path = is_path + "\"
	is_templatepath += "\"

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
		dw_Folders.SetFocus()
	ELSE
		cb_5.Enabled = TRUE
		//is_TemplatePath = is_Path
		Parent.wf_Next ( )
		
	END IF
	
END IF
end event

