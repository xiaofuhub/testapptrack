$PBExportHeader$w_authorization.srw
$PBExportComments$[w_Sheet] Processes authorization replies
forward
global type w_authorization from w_sheet
end type
type dw_shipments from u_dw within w_authorization
end type
type cb_process from u_cb within w_authorization
end type
type uo_mle from u_cst_mle within w_authorization
end type
type cb_getemails from u_cb within w_authorization
end type
type gb_authorization from u_gb within w_authorization
end type
type gb_replies from u_gb within w_authorization
end type
end forward

global type w_authorization from w_sheet
integer x = 5
integer y = 4
integer width = 3653
integer height = 2380
string title = "Authorization Processing"
string menuname = "m_Sheets"
long backcolor = 80269524
dw_shipments dw_shipments
cb_process cb_process
uo_mle uo_mle
cb_getemails cb_getemails
gb_authorization gb_authorization
gb_replies gb_replies
end type
global w_authorization w_authorization

type variables
String 	is_FilePathAuthIN
Constant String cs_Accept = "ACCEPTED"
Constant String cs_Deny = "DENIED"

end variables

forward prototypes
private function integer wf_retrieveauthorization (long al_shipment)
private function integer wf_processshipments ()
public function integer wf_retrievereplies (ref string as_shipment[], ref string as_filename[])
private function integer wf_processemails ()
private function integer wf_CheckEmails ()
public function integer wf_processreplies ()
private function integer wf_showreply (long al_shipment, string as_accept_deny)
private function string wf_getrefernumber (readonly string as_filename)
private function integer wf_deletefiles (readonly string as_directory, readonly string as_filename)
end prototypes

private function integer wf_retrieveauthorization (long al_shipment);//
/***************************************************************************************
NAME			: wf_RetrieveAuthorization
ACCESS		: private
ARGUMENTS	: Long		(Shipment ID)
RETURNS		: integer	(success, failure)
DESCRIPTION	: Finds and retrieves the authorization document for the shipment 

REVISION		: RDT 102602
***************************************************************************************/

DateTime	ldtm_Hold
Integer  li_Return, &
			li_Counter, &
			li_MarkIt, &
			li_Upper

Setpointer(Hourglass!)
Setnull( ldtm_Hold )
n_cst_Document lnv_Document[]

n_cst_bso_Document_Manager lnv_Document_Manager
lnv_Document_Manager = create n_cst_bso_Document_Manager

If lnv_Document_Manager.of_RetrieveDocuments ( al_shipment, lnv_Document_Manager.cs_authout, lnv_document ) = success then
	// populate the mle with the file contents.
	// look for the latest (date) file and display that one. 
	// there may be more than one auth out bound
	li_Upper = UpperBound( lnv_document[] ) 
	If li_Upper > 0 Then 
		For li_Counter = 1 to li_Upper 
			If IsNull( ldtm_Hold ) Then 
				ldtm_Hold = lnv_document[ li_Counter ].of_GetFileDateTime( ) // set hold to current dattime
				li_MarkIt = li_Counter 
			Else
				if lnv_document[ li_Counter ].of_GetFileDateTime( ) > ldtm_Hold Then  // if current > hold, then mark hold 
					li_MarkIt = li_Counter 
					ldtm_Hold = lnv_document[ li_Counter ].of_GetFileDateTime( )
				end If
			End If
		Next
		uo_mle.of_SetText(lnv_document[ li_MarkIt ].of_GetText( ) )
		
	Else
		uo_mle.of_SetText( "FILE NOT FOUND " )
	End If
Else
	uo_mle.of_SetText( "FILE NOT FOUND " )
End If	

destroy ( lnv_Document_Manager )

Return li_Return



end function

private function integer wf_processshipments ();//
/***************************************************************************************
NAME			: wf_ProcessShipments
ACCESS		: Private
ARGUMENTS	: none
RETURNS		: Integer	(success, failure)
DESCRIPTION	: 

create filesrv
create dispatch object n_cst_BSO_dispatch
create an array of selected shipment id's
Use bso_dispatch to retrieve shipment id's []
create n_cst_beo_shipment
set source on beo_shipment to bso_dispatch shipment cache 
change shipment status to audited

REVISION		: RDT 102602
RDT 3-5-03 changed status to Authorized instead of Audited.
RDT 3-6-03 If Reference # is checked on dw, add the reference number to the bill notes. 

***************************************************************************************/
String	lsa_FileName[], &
			ls_Reply[], &
			ls_DocType, &
			ls_FilePath, &
			ls_SourcePathFile, &
			ls_TargetPathFile, &
			ls_Comments, & 
			ls_Append_Ref[], &
			ls_Temp

		
Long		ll_ShipID[]

Integer	li_Return, &
			li_Result, &
			li_RowFound, &
			li_ShipCount, &			
			li_ArrayCount, &
			li_Occur

// set variable defaults 
li_Return   = this.Success

// create objects
n_cst_bso_Document_Manager lnv_Document_Manager
lnv_Document_Manager = create n_cst_bso_Document_Manager //  used to get file path 

n_cst_Document lnv_Document

n_cst_String	 lnv_String
n_cst_DirAttrib lnva_DirAttrib[] 

n_cst_filesrv   lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)										// Create file service

n_cst_bso_Dispatch lnv_Dispatch 
lnv_Dispatch = Create n_cst_bso_Dispatch 

n_cst_beo_Shipment lnv_Shipment
lnv_Shipment = create n_cst_beo_Shipment

// loop thru dw. selected rows & put the shipmentid & replies into arrays
li_RowFound = dw_Shipments.GetSelectedRow( 0 )		
DO WHILE li_RowFound <> 0 
	li_ShipCount ++
	ll_ShipID[ li_ShipCount ] 	 	= dw_Shipments.GetItemNumber( li_RowFound, "disp_Ship_ds_id" )	// get ship
	ls_Reply [ li_ShipCount ] 	 	= dw_Shipments.GetItemString( li_RowFound, "computed_Reply" )	
	lsa_FileName[ li_ShipCount ] 	= dw_Shipments.GetItemString( li_RowFound, "computed_FileName" )	
	ls_Append_Ref[ li_ShipCount ] = dw_Shipments.GetItemString( li_RowFound, "refchecked" )	// RDT 3-6-03
	li_RowFound = dw_Shipments.GetSelectedRow( li_RowFound )		// get next selected row
LOOP 

// Retrieve shipments thru dispatch object
lnv_Dispatch.of_RetrieveShipments ( ll_ShipID[] )

lnv_Shipment.of_SetContext ( lnv_Dispatch )

// set the sources on the shipment to the dispatch caches
lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
lnv_Shipment.of_SetItemSource( lnv_Dispatch.of_GetItemCache ( ) ) 
lnv_Shipment.of_SetEventSource( lnv_Dispatch.of_GetEventCache ( ) ) 

For li_ArrayCount = 1 to li_ShipCount
	Choose Case ls_reply [ li_ArrayCount ] 
			
		Case cs_accept
			lnv_Shipment.of_SetSourceId ( ll_ShipID[ li_ArrayCount ] )
			lnv_Shipment.of_SetAllowFilterSet(TRUE)
			//RDT 3-5-03 li_Result = lnv_Shipment.of_ChangeStatus ( gc_Dispatch.cs_ShipmentStatus_Audited, lnv_dispatch ) 
			li_Result = lnv_Shipment.of_ChangeStatus ( gc_dispatch.cs_shipmentstatus_authorized, lnv_dispatch ) 

			// RDT 3-6-03 Refer #  - Start 
			If ls_Append_Ref[ li_ArrayCount ] = "1" Then 
				
				ls_Comments = lnv_shipment.of_GetBillingComments ( )
				If IsNull( ls_Comments ) OR Len( Trim( ls_Comments ) ) = 0 Then 
					ls_Comments = ""
				Else
					ls_Comments = ls_Comments + "~r~n" 
				End if
				
				// find reference number in file 
				ls_Temp = This.wf_GetReferNumber( is_filepathauthin + lsa_FileName[ li_ArrayCount ] )
				If Len ( ls_Temp ) > 0 Then 
					ls_Comments = ls_Comments + ls_temp
					lnv_shipment.of_SetBillingComments  ( ls_Comments )
				End If
				
			End If
			// RDT 3-6-03 Refer #  - End 

			If li_Result = 1 Then 											 
				li_Result = lnv_Dispatch.TriggerEvent("pt_save") 
				if li_Result <> 1 then 
					messageBox("Process Shipment Reply","Error saving Shipment changes.")
				end if			
			End If

			ls_DocType = lnv_Document_Manager.cs_AuthACCEPT 

		Case cs_deny
			ls_DocType = lnv_Document_Manager.cs_AuthDENY
			li_Result = 1
			
		End Choose
		
		// Copy and Delete files
		If li_Result = 1 then
			lnv_Document_Manager.of_SetCatagory("UNSECURE")
			lnv_Document_Manager.of_SetTopic("SHIPMENT")
			lnv_Document_Manager.of_CalculatePath( ll_ShipID[ li_ArrayCount ], ls_FilePath, ls_DocType)

			//check for existance of directory and create if needed.
			if lnv_FileSrv.of_DirectoryExists( ls_FilePath ) = FALSE Then 
				lnv_Document_Manager.of_CreatePath( ls_FilePath ) 
			end if

			ls_SourcePathFile = is_filepathauthin + lsa_FileName[ li_ArrayCount ] 
			ls_TargetPathFile = ls_FilePath + MID(lsa_FileName[ li_ArrayCount ],2 )  // strip off first character ("A"/"D")

			li_result = lnv_filesrv.of_filecopy ( ls_SourcePathFile , ls_TargetPathFile ) 

			Choose Case li_Result
				Case 1
					// Delete the source file and all like it (?shipmentid*.txt)

					// replace first char with "?"
					lsa_FileName[ li_ArrayCount ] = "?" + MID(lsa_FileName[ li_ArrayCount ] , 2) 
					
					// find shipment number in string and replace rest with *.txt
					li_Occur = lnv_String.of_CountOccurrences( lsa_FileName[ li_ArrayCount ] , "-" )
					If li_Occur > 0 Then 
						lsa_FileName[ li_ArrayCount ] = lnv_String.of_GetToken( lsa_FileName[ li_ArrayCount ] , "-")
						ls_SourcePathFile  				= lsa_FileName[ li_ArrayCount ] + "*.txt"
					End If
					
					// this Allows the use of wildcards in the file name FileDelete() does not. 
					wf_DeleteFiles(is_filepathauthin , ls_SourcePathFile )
						
				Case -1
						messageBox("Processing Shipment Replies.","Copy Failed. Error Reading File "+ls_SourcePathFile )
				Case -2
						messageBox("Processing Shipment Replies.","Copy Failed. Error Writing File "+ls_TargetPathFile )
			End Choose

		Else 
			// don't move files 'cause an error occured
		End If
			
Next

//
//// destroy objects
Destroy lnv_Document_Manager
Destroy lnv_Dispatch 
Destroy lnv_Shipment 
f_SetFileSrv(lnv_FileSrv, TRUE)										

Return li_Return 
end function

public function integer wf_retrievereplies (ref string as_shipment[], ref string as_filename[]);//
/***************************************************************************************
NAME			: wf_RetrieveReplies
ACCESS		: Public
ARGUMENTS	: String[]	(ShipmentId) by ref
				: String[]	(Result) 	 by ref
RETURNS		: Integer 	(number of files in directory)

DESCRIPTION	: Read the appeon_constant.cs_authin directory and load arrays with file name 
				  and reply 

REVISION		: RDT 102602
***************************************************************************************/
String	ls_Separator

Long		ll_Count, &
			ll_FileCount
			
// Create objects			
n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)										

n_cst_bso_Document_Manager lnv_Document_Manager					
lnv_Document_Manager = Create n_cst_bso_Document_Manager 

n_cst_DirAttrib anv_dirlist[] 

// get seperator from file service
ls_Separator = lnv_FileSrv.of_GetSeparator ( )  				

// get file directory
is_FilePathAuthin = lnv_Document_Manager.of_GetDocumentDirPath(lnv_Document_Manager.cs_authin)  

// get all files
ll_FileCount = lnv_FileSrv.of_DirList ( is_FilePathAuthin + lnv_FileSrv.of_GetAllFilesSpecifier() , 0, anv_dirlist[] ) 

If ll_FileCount > 0 then 
	For ll_Count = 1 to ll_FileCount
		as_Shipment[ll_Count] = Mid( anv_dirlist[ll_Count].is_filename,2 , Pos( anv_dirlist[ll_Count].is_filename,"-" ) - 2)		// get shipment number 
		as_FileName[ll_Count] = anv_dirlist[ll_Count].is_filename
	Next
End If

// Destroy Obects
f_SetFileSrv(lnv_FileSrv, FALSE )								
Destroy lnv_Document_Manager


Return ll_FileCount 
end function

private function integer wf_processemails ();//
/***************************************************************************************
NAME			: wf_ProcessEmails	
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: checks for emails in users inbox

REVISION		: RDT 110702
***************************************************************************************/

Integer	li_Return = 1

n_cst_bso_Notification_Manager lnv_NoteMan
lnv_NoteMan = Create n_cst_bso_Notification_Manager

lnv_NoteMan.of_ProcessStatusRequests()

Destroy ( lnv_NoteMan )

dw_Shipments.Retrieve()

This.TriggerEvent("pfc_PostOpen")

Return li_Return 

end function

private function integer wf_CheckEmails ();//
/***************************************************************************************
NAME			: wf_CheckEmails	
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: checks for emails in users inbox

REVISION		: RDT 110702
***************************************************************************************/

Integer	li_Return = 1

n_cst_bso_Notification_Manager lnv_NoteMan
lnv_NoteMan = Create n_cst_bso_Notification_Manager

lnv_NoteMan.of_ProcessStatusRequests()

Destroy ( lnv_NoteMan )

dw_Shipments.Retrieve()

This.TriggerEvent("pfc_PostOpen")

Return li_Return 

end function

public function integer wf_processreplies ();//
/***************************************************************************************
NAME			: ws_ProcessReplies
ACCESS		: Private 
ARGUMENTS	: 
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: 

REVISION		: RDT 110702
***************************************************************************************/

Integer	li_Return = 1


If dw_shipments.GetSelectedRow( 0 ) > 0 Then 
	This.wf_ProcessShipments( )
	dw_Shipments.Retrieve()
	This.TriggerEvent("pfc_PostOpen")
Else
	MessageBox("Process Replies Error", "Please select at least 1 reply to process")
	
End If


Return li_Return 
end function

private function integer wf_showreply (long al_shipment, string as_accept_deny);//
/***************************************************************************************
NAME			: wf_ShowReply
ACCESS		: private
ARGUMENTS	: al_shipment		(Shipment ID)
RETURNS		: integer	(success, failure)
DESCRIPTION	: Finds, retrieves, and shows the Current Reply document for the shipment 

REVISION		: RDT 12-16-02
				  RDT 3-6-03 if accept is found then keep it. Don't display denies even if
				  they are later date and times. 
***************************************************************************************/

String 	ls_FilePrefix

DateTime	ldtm_Hold

Integer  li_Return, &
			li_Counter, &
			li_MarkIt, &
			li_Upper

Setpointer(Hourglass!)

Setnull( ldtm_Hold )

n_cst_Document lnv_Document[]

n_cst_bso_Document_Manager lnv_Document_Manager
lnv_Document_Manager = create n_cst_bso_Document_Manager

If lnv_Document_Manager.of_RetrieveDocuments ( al_shipment, lnv_Document_Manager.cs_authin, lnv_document ) = success then
	// populate the mle with the file contents.
	// look for the latest (date) file and display that one. 
	li_Upper = UpperBound( lnv_document[] ) 
	
	If li_Upper > 0 Then 
		
		For li_Counter = 1 to li_Upper 
//			MessageBox("RICH","Name: "+ lnv_document[ li_Counter].of_GetFileName() + &
//			"~nDate: "+ String( lnv_document[ li_Counter].of_GetFileDateTime() ))
		
			If IsNull( ldtm_Hold ) Then 
				ls_FilePreFix = Left( lnv_document[ li_Counter].of_GetFileName() , 1)
				ldtm_Hold = lnv_document[ li_Counter ].of_GetFileDateTime( ) // set hold to current datetime
				li_MarkIt = li_Counter 
			Else
				If ( ls_FilePreFix = "D" AND Left( lnv_document[ li_Counter].of_GetFileName() , 1) = "A" ) OR &
					( ls_FilePreFix = Left( lnv_document[ li_Counter].of_GetFileName() , 1) ) Then 

					ls_FilePreFix = Left( lnv_document[ li_Counter].of_GetFileName() , 1)
					
					if lnv_document[ li_Counter ].of_GetFileDateTime( ) > ldtm_Hold Then  // if current > hold, then mark hold 
						li_MarkIt = li_Counter 
						ldtm_Hold = lnv_document[ li_Counter ].of_GetFileDateTime( )
					end If
					
				End If
			End If
			
		Next
		
		uo_mle.of_SetText(lnv_document[ li_MarkIt ].of_GetText( ) )
		
	Else
		uo_mle.of_SetText( "FILE NOT FOUND " )
	End If
	
Else
	uo_mle.of_SetText( "FILE NOT FOUND " )
End If	

destroy ( lnv_Document_Manager )

Return li_Return



end function

private function string wf_getrefernumber (readonly string as_filename);//
/***************************************************************************************
NAME			: wf_GetReferNumber
ACCESS		: Private 
ARGUMENTS	: String		File name to find number in
RETURNS		: String 	Reference number
DESCRIPTION	: Opens the file and parses through to find the reference number.
REVISION		: RDT 3-6-03

Create file service
Open file
read each line and look for "REF:" OR "COMMENT:"
If either one is found append to ls_Return 
Return reference number tag and value 
***************************************************************************************/
String 	ls_Return, &
			lsa_FileLine[], &
			lsa_ParsedLine[], &
			ls_Tag1, &
			ls_Tag2, &
			ls_Delimiter

Long		ll_LineCount, &
			ll_i, &
			ll_p, &
			ll_ParseCount
			
ls_Tag1 = "AUTHORIZATION:"
ls_Tag2 = "COMMENT:"
ls_Return = ""
ls_Delimiter = "~r~n"

n_cst_String	lnv_String									
n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)														// Create file service

ll_lineCount = lnv_FileSrv.of_FileRead( as_filename, lsa_FileLine[] )	// read file into string array

If ll_LineCount > 0 then 

	For ll_i = 1 to ll_lineCount 

		lsa_FileLine[ll_i]  = Upper( lsa_FileLine[ll_i]  )						// convert line to uppercase
			
		ll_ParseCount = lnv_String.of_ParseToArray ( lsa_FileLine [ ll_i ], ls_Delimiter , lsa_ParsedLine )	

		IF ll_ParseCount > 0 Then 

			For ll_p = 1 to ll_ParseCount 
				// Look for Tag1
				If Pos ( lsa_ParsedLine[ ll_p ] , ls_Tag1 ) > 0 Then
					ls_Return = ls_Return + lsa_ParsedLine[ ll_p ] + "  "							// string found
				End If

				// Look for tag2
				If Pos ( lsa_ParsedLine[ ll_p ] , ls_Tag2 ) > 0 		Then
					ls_Return = ls_Return + lsa_ParsedLine[ ll_p ] 									// string found
					ls_Return = lnv_String.of_GlobalReplace( ls_Return , ls_tag2, "", TRUE )// Replace Tag with empty string 
				End If
			Next
			
		End If
	
	Next 

End If

f_SetFileSrv(lnv_FileSrv, FALSE)														// Destroy file service

Return ls_Return 
end function

private function integer wf_deletefiles (readonly string as_directory, readonly string as_filename);//
/***************************************************************************************
NAME			: wf_DeleteFiles
ACCESS		: Private 
ARGUMENTS	: String	as_Directory
				  String	as_FileName
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Reads Directory for files matching as_FileName (WildCards allowed) and deletes
					all files found that match.

REVISION		: RDT 01-02-03
***************************************************************************************/
String	ls_FileName

Integer 	li_Count, &
			li_Upper, &
			li_Return 

n_cst_dirattrib lnv_dirlist[] 

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)											// Create file service

li_Return = 1

lnv_FileSrv.of_DirList(as_directory+as_fileName, 0 , lnv_dirlist[] )
li_Upper = UpperBound( lnv_dirlist[] )

For li_Count = 1 to li_Upper 
		ls_FileName = 	lnv_dirList[ li_Count ].is_filename
		if NOT FileDelete( as_Directory+ls_FileName ) then 
			messageBox("File Delete failed.", as_Directory+ls_FileName )// delete failed
			li_Return = -1
		end if
Next
	
	
f_SetFileSrv(lnv_FileSrv, FALSE )											// Destroy file service

Return li_Return 
end function

on w_authorization.create
int iCurrent
call super::create
if this.MenuName = "m_Sheets" then this.MenuID = create m_Sheets
this.dw_shipments=create dw_shipments
this.cb_process=create cb_process
this.uo_mle=create uo_mle
this.cb_getemails=create cb_getemails
this.gb_authorization=create gb_authorization
this.gb_replies=create gb_replies
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_shipments
this.Control[iCurrent+2]=this.cb_process
this.Control[iCurrent+3]=this.uo_mle
this.Control[iCurrent+4]=this.cb_getemails
this.Control[iCurrent+5]=this.gb_authorization
this.Control[iCurrent+6]=this.gb_replies
end on

on w_authorization.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_shipments)
destroy(this.cb_process)
destroy(this.uo_mle)
destroy(this.cb_getemails)
destroy(this.gb_authorization)
destroy(this.gb_replies)
end on

event open;call super::open;// allow multiselect on dw
// do not allow add/edit/delete on dw
ib_disableclosequery = TRUE							// No Updates allowed in this window. 

//Enable the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize ( 1300, 400 )

//Register Resizable controls
inv_Resize.of_Register ( uo_mle, 'Scale' )
inv_Resize.of_Register ( gb_authorization, 'Scale' )

inv_Resize.of_Register ( dw_Shipments, 'FixedToRight&ScaleToBottom' )
inv_Resize.of_Register ( gb_replies, 'FixedToRight&ScaleToBottom' )

inv_Resize.of_Register ( cb_process, 'FixedToRight&Bottom' )
inv_Resize.of_Register ( cb_getemails, 'FixedToRight&Bottom' )


dw_Shipments.SetTransObject(SQLCA)
dw_Shipments.Retrieve()

// set sort service on datawindow
dw_Shipments.of_SetSort(TRUE)
dw_Shipments.inv_sort.of_SetStyle(0)
dw_Shipments.inv_sort.of_SetColumnHeader(TRUE)

// set row selection on List datawindow
dw_Shipments.of_SetRowSelect ( TRUE ) 
dw_Shipments.inv_rowselect.of_SetStyle ( 2 ) 

// 
gf_Mask_Menu(m_Sheets)

end event

event pfc_postopen;/***************************************************************************************
DESCRIPTION	: get files in directory and set values in dw_Shipments.
REVISION		: RDT 102602
					RDT 3-5-03 Set Reference number to checked
***************************************************************************************/
String	ls_Shipment[], &
			ls_FileName[], &
			ls_Find, &
			ls_Reply

Long 		ll_Result, &
			ll_Count, &
			ll_FoundRow

SetPointer(Hourglass!)

ll_Result = This.wf_RetrieveReplies( ls_Shipment[], ls_FileName[] )	// load arrays with results 

For ll_Count = 1 to ll_Result 
	ls_Find = " disp_Ship_ds_id = "+ls_Shipment[ ll_Count ]
	ll_FoundRow = dw_Shipments.Find( ls_Find, 0, dw_shipments.RowCount() ) 
	
	If ll_FoundRow > 0 Then 
		
		If dw_Shipments.GetItemString(ll_FoundRow, "computed_reply") = cs_accept Then 
			// DO NOT change an "Accept" reply to a "Deny"
			dw_Shipments.SetItem(ll_FoundRow, "refchecked","1") 	// RDT 3-5-06
		Else
			Choose Case Left( ls_FileName[ ll_Count ], 1 ) 
				Case "A"
					ls_Reply = cs_accept
					dw_Shipments.SetItem(ll_FoundRow, "refchecked","1") 	// RDT 3-5-06
				Case "D"
					ls_Reply = cs_deny
					dw_Shipments.SetItem(ll_FoundRow, "refchecked","0") 	// RDT 3-5-06					
				Case Else
					ls_Reply = "Unknown"								
			End Choose

			If dw_Shipments.SetItem(ll_FoundRow, "computed_reply", ls_Reply) = -1 Then 
				MessageBox("Program Error","SetItem failed in postopen of w_auhorization. ")
			Else
				dw_Shipments.SetItem(ll_FoundRow, "computed_FileName", ls_FileName[ ll_Count ]) 
			End IF		

		End IF
		
	End If	
Next




end event

type dw_shipments from u_dw within w_authorization
integer x = 1751
integer y = 120
integer width = 1824
integer height = 1916
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_shipmentauditrequired"
end type

event constructor;ib_rmbMenu = FALSE

end event

event rowfocuschanged;call super::rowfocuschanged;// get the authorization document that was sent to the customer.
If This.GetRow() > 0 then 
	gb_authorization.Text = "Authorization Sent"
	Parent.wf_RetrieveAuthorization( This.GetItemNumber(This.GetRow(), "disp_ship_ds_id") )
End If


end event

event doubleclicked;// RDT 12-16-02 all new code

Choose Case this.GetClickedColumn()
	Case 1
		// COMPANY Clicked
		// this will display the auth outbound message
		This.TriggerEvent("rowfocuschanged") // 
	Case 2
		// open the shipment window
		n_cst_ShipmentManager lnv_ShipmentManager 		// autoinstantiated
		lnv_ShipmentManager.of_OpenShipment ( This.GetItemNumber( This.GetRow(), "disp_Ship_ds_id" ) )

	Case 3
		If Len( Trim( this.GetItemString( this.GetRow(), "computed_reply") ) ) > 0  Then 
			If gb_authorization.Text = "Authorization Sent" Then 
				Parent.wf_ShowReply( This.GetItemNumber(This.GetRow(), "disp_Ship_ds_id"),this.GetItemString( this.GetRow(), "computed_reply")  )
				gb_authorization.Text = "Reply Received"
			Else
				This.TriggerEvent("rowfocuschanged")
			End If
		End If

End Choose
end event

event clicked;call super::clicked;// RDT 3-5-03 all new code

	Choose Case this.GetClickedColumn()
		Case 1
			// COMPANY Clicked
			// this will display the auth outbound message
			This.TriggerEvent("rowfocuschanged") // 

		Case 2
			// shipment clicked
			
		Case 3
			// reply clicked
			If Len( Trim( this.GetItemString( this.GetRow(), "computed_reply") ) ) > 0  Then 
				If gb_authorization.Text = "Authorization Sent" Then 
					Parent.wf_ShowReply( This.GetItemNumber(This.GetRow(), "disp_Ship_ds_id"),this.GetItemString( this.GetRow(), "computed_reply")  )
					gb_authorization.Text = "Reply Received"
				Else
					This.TriggerEvent("rowfocuschanged")
				End If
			End If
	
	End Choose

end event

type cb_process from u_cb within w_authorization
integer x = 2720
integer y = 2064
integer width = 713
integer taborder = 30
boolean bringtotop = true
string text = "&Process Selected Replies"
end type

event clicked;
Parent.wf_ProcessReplies()

end event

type uo_mle from u_cst_mle within w_authorization
integer x = 32
integer y = 92
integer width = 1669
integer height = 2052
integer taborder = 40
boolean bringtotop = true
long backcolor = 80269524
end type

on uo_mle.destroy
call u_cst_mle::destroy
end on

type cb_getemails from u_cb within w_authorization
integer x = 1861
integer y = 2064
integer width = 713
integer taborder = 20
boolean bringtotop = true
string text = "&Retrieve Replies"
end type

event clicked;
Parent.wf_CheckEmails()
end event

type gb_authorization from u_gb within w_authorization
integer x = 23
integer y = 32
integer width = 1687
integer height = 2152
integer taborder = 0
string text = "Authorization Sent"
end type

type gb_replies from u_gb within w_authorization
integer x = 1728
integer y = 32
integer width = 1865
integer height = 2152
integer taborder = 0
string text = "Authorization Replies"
end type

