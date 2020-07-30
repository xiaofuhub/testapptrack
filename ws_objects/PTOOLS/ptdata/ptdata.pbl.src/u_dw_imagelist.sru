$PBExportHeader$u_dw_imagelist.sru
$PBExportComments$ImageList (Data Control from PBL map PTData) //@(*)[51906108|1345]
forward
global type u_dw_imagelist from u_dw
end type
end forward

global type u_dw_imagelist from u_dw
integer width = 1390
integer height = 752
boolean bringtotop = true
string dataobject = "d_dlkc_image"
boolean hscrollbar = true
boolean hsplitscroll = true
event ue_printimage ( )
event processkey pbm_dwnkey
event ue_companylist ( )
event ue_emailimage ( )
event ue_copyimage ( )
event type integer ue_savelist ( )
event ue_addtotransferqueue ( )
event type long ue_getimageid ( )
end type
global u_dw_imagelist u_dw_imagelist

type variables
Public:
Long	ila_CompanyIds[]

CONSTANT STRING cs_functionSCAN	= "Scan Image"
Private:
boolean	ib_ShowCompanyList = TRUE
end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
protected function integer of_getselectedshipments (ref long ala_ids[])
public subroutine of_setshowcompanylist (boolean ab_show)
public function integer of_emailimages ()
private function integer of_copyimages ()
public function integer of_addtransferrequest ()
end prototypes

event ue_companylist;Long	lla_ShipmentIDs[]
Long	ll_Count
Long	lla_CompanyIds[]
Long	lla_Temp[]
Long	ll_TempCount
Long	ll_CompanyCount
Long 	j,i

n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment

n_cst_bso_Dispatch	lnv_Dispatch
lnv_Dispatch = CREATE n_cst_bso_Dispatch

n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

IF THIS.of_GetSelectedShipments ( lla_ShipmentIDs ) = 1 THEN
	ll_Count = UpperBound ( lla_ShipmentIDs ) 
	
	IF ll_Count > 0 THEN
		lnv_Dispatch.of_RetrieveShipments ( lla_ShipmentIds )
		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
		lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
		
		FOR i = 1 TO ll_Count
			lnv_Shipment.of_SetSourceID ( lla_ShipmentIDs[i] )
			lnv_Shipment.of_GetReferencedCompanies ( lla_Temp )
			
			ll_TempCount = upperbound ( lla_Temp )
			FOR j = 1 TO ll_TempCount
				ll_CompanyCount ++
				lla_CompanyIds [ ll_CompanyCount ] = lla_Temp[j]								
			NEXT
			
		NEXT
	END IF
END IF

DESTROY ( lnv_Dispatch )


lnv_ArraySrv.of_GetShrinked ( lla_CompanyIds , TRUE , TRUE )		

IF UpperBound ( lla_CompanyIds ) > 0 THEN
	
	
	lstr_Parm.is_Label = "COMPANYIDS"
	lstr_Parm.ia_Value = lla_CompanyIDs
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	ila_CompanyIds[] = lla_CompanyIDs			//RDT 3-12-03
	If ib_showcompanylist Then 					//RDT 3-12-03
		OpenWithParm ( w_CompanyList , lnv_Msg )
	End If												//RDT 3-12-03
	
END IF

DESTROY ( lnv_Shipment ) 
end event

event ue_emailimage();This.of_EmailImages()
end event

event ue_copyimage;This.of_Copyimages()
end event

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null


Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>

Return 1
//@(text)--

end function

protected function integer of_getselectedshipments (ref long ala_ids[]);Int	li_Return = 1
Long	lla_SelectedRows[]
Long	ll_Count
Long	i


IF isValid ( inv_rowselect ) THEN
	ll_Count = inv_rowselect.of_selectedCount ( lla_SelectedRows )
	
	FOR i = 1 TO ll_Count 
		lla_SelectedRows[i] = THIS.GetItemNumber ( lla_SelectedRows[i] , "image_id" )
	NEXT
ELSE
	li_Return = -1	
END IF

n_cst_AnyArraySrv	lnv_ArraySrv

lnv_ArraySrv.of_GetShrinked ( lla_SelectedRows , TRUE , TRUE )

ala_ids = lla_SelectedRows

RETURN li_Return
end function

public subroutine of_setshowcompanylist (boolean ab_show);ib_showcompanylist = ab_show
end subroutine

public function integer of_emailimages ();/* of_EmailImages
Get all selected Temp/Shipment Numbers 
Get create shipment BEO's 
Populate an array with the shipment BEO's
*/
// RDT 7-25-03 Changed subject line and email text to include equipment data
// RDT 8-21-03 Add File extension to the file name of the attachment. 

String 	lsa_Address[], &
			ls_EmailBody , & 
			ls_EmailSubject, &
			lsa_Type[], &
			ls_FilePath , &
			ls_drive, &
			ls_dirpath, &
			ls_filename, &
			ls_FileExtension 

MailFileDescription lsa_MailFile[]

n_cst_FileSrv lnv_FileSrv				//RDT 8-21-03 
f_SetFileSrv( lnv_FileSrv , TRUE)	//RDT 8-21-03 

Long		lla_ShipID[], &
			ll_RowCount

Integer	li_Count, &
			li_ArrayCount, &
			li_Return = 1

// RDT 7-25-03 
String 	ls_RefLabel, &
			ls_RefText, &
			ls_Container
// RDT 7-25-03 

Integer 	li_Upper

s_parm 					lstr_parm			
n_cst_msg				lnv_Msg
n_cst_beo_image 		lnv_Beo 
n_cst_anyarraysrv		lnv_AnyArraySrv
n_cst_bso_Dispatch	lnv_Dispatch	
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Shipment	lnva_ShipmentArray[]

n_cst_beo_Equipment2		lnva_Equipment2[]			// RDT 7-25-03 
n_cst_equipmentmanager lnv_equipmentmanager 		// RDT 7-25-03 

ll_RowCount = This.RowCount()
li_ArrayCount = 0

If ll_RowCount > 0 Then 
	// loop thru This and get shipmentId's from selected rows.
	ll_RowCount = This.RowCount()
	
	For li_Count = 1 to ll_RowCount
		If This.IsSelected( li_Count ) Then 
			lnv_beo = This.inv_uilink.getBeo( li_Count )
	
			IF IsValid ( lnv_beo ) THEN
				li_ArrayCount ++
				lla_ShipId[ li_ArrayCount ] = lnv_Beo.of_getid ( )
				lsa_Type[ li_ArrayCount ] 	 = lnv_beo.of_gettype ( )
				
				// setup attachments
				ls_FilePath = lnv_Beo.of_getfilepath ( )																				//RDT 8-21-03 
				lnv_FileSrv.of_parsepath ( ls_FilePath , ls_drive, ls_dirpath, ls_filename, ls_FileExtension )		//RDT 8-21-03 

				//lsa_MailFile[li_ArrayCount].Filename = String( lla_ShipId[ li_ArrayCount ] ) + lsa_Type[ li_ArrayCount ] //RDT 8-21-03 
				lsa_MailFile[li_ArrayCount].Filename = String( lla_ShipId[ li_ArrayCount ] ) + lsa_Type[ li_ArrayCount ] + "." + ls_FileExtension //RDT 8-21-03 

				lsa_MailFile[li_ArrayCount].FileType = mailAttach!

				//lsa_MailFile[li_ArrayCount].PathName = lnv_Beo.of_getfilepath ( )		//RDT 8-21-03 
				lsa_MailFile[li_ArrayCount].PathName = ls_FilePath 							//RDT 8-21-03 
				
			END IF
	
		End IF
	
	Next 
Else
	li_Return = -1 
End If

If (li_Return = 1) and (li_ArrayCount = 0) Then 
	MessageBox("Email Images","No Images were highlighted to email.")
	li_Return = -1
End IF

If li_Return = 1 Then 
	lnv_Dispatch = CREATE n_cst_bso_Dispatch
	lnv_Shipment = Create n_cst_beo_Shipment

	lnv_AnyArraySrv.of_GetShrinked ( lla_ShipId, TRUE, TRUE) // remove dupes in array

	li_ArrayCount  = UpperBound( lla_ShipId )

	For li_Count = 1 to li_ArrayCount
	
		lnv_Dispatch.of_RetrieveShipment ( lla_ShipId[ li_Count ] )
		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetshipmentCache ( )  )
		lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
		lnv_Shipment.of_SetSourceID ( lla_ShipId[ li_Count ] ) 
		
		lnva_ShipmentArray[ li_Count ] = lnv_Shipment  
		
		ls_EmailSubject = ls_EmailSubject + String(lla_ShipId [li_Count] )+" "
		ls_EmailBody 	 = ls_EmailBody 	 + "~r~n"+String(lla_ShipId [li_Count] )

	Next
	//// Open Shipment notification window	to get addresses
	lstr_parm.is_label = "SHIPMENTARRAY"
	lstr_parm.ia_value = lnva_ShipmentArray[]
	lnv_msg.of_add_parm(lstr_parm)
	
	OpenWithParm (w_ShipmentNotification, lnv_msg) 

	//// Get returned addresses 
	lnv_Msg = Message.PowerObjectParm	
	If IsValid ( lnv_Msg ) Then 
		IF lnv_msg.of_Get_Parm ( "ADDRESSARRAY" , lstr_Parm ) <> 0 THEN
			lsa_Address[] = lstr_Parm.ia_Value 
		Else
			messagebox("Email Images","No Email Addresses were selected")
			li_Return = -1
		End If
	Else
		li_Return = -1 // window closed without sending a message object 
	End If		
	
	//// Create emails
	If li_Return = 1 Then 
		
		n_cst_EmailMessage  lnv_EmailMessage
		
		n_cst_bso_Email_Manager lnv_Email_Manager
		lnv_Email_Manager = Create n_cst_bso_Email_Manager 
	
		lnv_EmailMessage.of_addtargets ( lsa_Address[] )
// RDT 7-25-03 lnv_EmailMessage.of_setbody ( "Please see the attached Image for Shipment: "+ls_EmailBody )
		



// I am replacing the code below with the Select  <<*>>
// I am not analyzing what the entire script is doing, just replacing the 
// commented code.
////////////////////////////////////////////////////////////////////
/*li_Upper = lnv_shipment.of_getLinkedequipment ( lnva_equipment2[] ) 

If li_Upper > 0 then 
	// loop thru looking for a container
	For li_Count = 1 to li_Upper
		if lnva_Equipment2[li_count].of_GetType() = lnv_equipmentmanager.cs_cntn Then 
			ls_Container = lnva_Equipment2[li_count].of_GetNumber()
			Exit
		end if
	Next
	If Len(Trim( ls_Container)) > 0 then
		ls_EmailSubject  = "Container "+ls_Container + " "
	End if
		
End If
*/
/////////////////////////////////////////////////////////////////////
Long	ll_Shipment
String	ls_Cntn = lnv_equipmentmanager.cs_cntn

ll_Shipment = lnv_shipment.of_GetID ( )
 

SELECT First "equipment"."eq_ref"  
 INTO :ls_Container  
 FROM "equipment",   
		"outside_equip"  
WHERE (  "outside_equip"."oe_id" = "equipment"."eq_id" ) and  
		(  "equipment"."eq_type" = :ls_Cntn ) AND  
		(( "outside_equip"."shipment" = :ll_Shipment OR  
			"outside_equip"."reloadshipment" = :ll_Shipment) ) 
ORDER BY "oe_id"   ;
Commit;

If Len(Trim( ls_Container)) > 0 then
	ls_EmailSubject  = "Container "+ls_Container + " "
End if
///////////////////////////////////////////////////////////////////////


ls_RefLabel = lnv_shipment.of_GetRef2Label ( )
ls_RefText  = lnv_shipment.of_GetRef2Text( )
If Len(Trim( ls_RefLabel ) ) < 1 or IsNull( ls_RefLabel ) or ls_RefLabel = "[NONE]" then 
		ls_RefLabel = ""
End If
If Len(Trim( ls_RefText ) ) < 1 or IsNull( ls_RefText ) then 
		ls_RefText = ""
End If

lnv_AnyArraySrv.of_Destroy( lnva_equipment2[] ) 

ls_EmailSubject += ls_RefLabel + ls_RefText
lnv_EmailMessage.of_setbody ( "Please see the attached Image for " + ls_EmailSubject )
// RDT 7-25-03 - end
		lnv_EmailMessage.of_setsubject ( "Image for " + ls_EmailSubject )
		lnv_EmailMessage.of_processattachments (  lsa_MailFile[ ]  )

		IF lnv_Email_Manager.Of_SendMail(lnv_EmailMessage) = -1 Then 
			MessageBox("Email Image", "Email Failed to send.~r~n~r~n" + lnv_Email_Manager.of_GetErrorstring( ) )
			li_Return = -1
		End If
		
		Destroy ( lnv_Email_Manager )
		
	end If
	
	
	Destroy ( lnv_Dispatch )
	Destroy ( lnv_Shipment )
	
End IF

f_SetFileSrv( lnv_FileSrv , FALSE )	//RDT 8-21-03 

Return li_Return

end function

private function integer of_copyimages ();//
/***************************************************************************************
NAME			: of_CopyImages
ACCESS		: Private 
ARGUMENTS	: None
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: 

REVISION		: RDT 3-12-03
***************************************************************************************/
Integer	li_Return, &
			li_Counter, &
			li_Beo_Count

Long 		ll_RowCount

n_cst_beo_image   	lnv_Beo
n_cst_beo_image   	lnva_Beo[]

// loop thru This and get selected rows.
ll_RowCount = This.RowCount()

For li_Counter = 1 to ll_RowCount
	If This.IsSelected( li_Counter ) Then 
		lnv_beo = This.inv_uilink.getBeo( li_Counter )

		IF IsValid ( lnv_beo ) THEN
			li_Beo_Count ++
			lnva_Beo[ li_Beo_Count ] = lnv_Beo
		END IF

	End IF
Next 

If li_BEO_Count > 0 then 
	If gnv_app.inv_ClipBoard.of_SetContents( lnva_Beo[] , gnv_app.inv_ClipBoard.cs_Image ) = -1 then 
		MessageBox("ClipBoard", "Copy to Clipboard Failed.") 
	Else
		MessageBox("ClipBoard", String(li_Beo_Count)+" Images Copied to Clipboard.") 
	End If
Else
	MessageBox("ClipBoard", "No Images Selected to Copy.") 
	li_Return = -1
End If

Return li_Return

end function

public function integer of_addtransferrequest ();Long	i
Long	ll_Count
Int	li_Return
Long	lla_SelectedRows[]
Int	li_SuccessCount
String	ls_Error
Long	ll_Source
String	ls_Type

SetPointer ( Hourglass! )

n_cst_beo_Image	lnv_Image
n_cst_bso_Document_Manager	lnv_DocMan
lnv_DocMan = CREATE n_cst_bso_Document_Manager

IF isValid ( inv_rowselect ) THEN
	ll_Count = inv_rowselect.of_selectedCount ( lla_SelectedRows )
	
	FOR i = 1 TO ll_Count
		IF isValid ( THIS.inv_uilink ) THEN
			lnv_Image = This.inv_uilink.getBeo( lla_SelectedRows[i] )
		ELSE
			li_Return = -1
		END IF
		IF IsValid ( lnv_Image ) THEN
			
			IF lnv_DocMan.of_Addtransferrequest( lnv_Image ) < 0 THEN
				ll_Source = lnv_Image.of_GetID ( )
				ls_type = lnv_Image.of_GetType ( )
				ls_Error += "~t" + String ( ll_Source ) + "~t" + ls_Type + "~r~n"
				
			END IF
						
		END IF
		
	NEXT
	lnv_DocMan.event pt_save( )
ELSE
	li_Return = -1	
END IF



IF Len ( ls_Error ) > 0 THEN
	ls_Error = "The following documents could not be added:~r~n" + ls_Error
	MessageBox ( "Error adding Documents to Queue " ,ls_Error )
ELSE 
	MessageBox ( "Transfer Queue" , String ( ll_count ) + " Document(s) added." )
END IF
	

RETURN li_Return
end function

on u_dw_imagelist.destroy
end on

event constructor;//@(data)(recreate=yes)<GenerationOptions>
SetUILink(TRUE)
inv_uilink.SetClass("n_cst_beo_image")
inv_uilink.SetDLK("n_cst_dlkc_image")
of_SetTransObject(SQLCA)
this.SetUseTaskRetrieve(FALSE)
//@(data)--

THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (2 ) 
ib_rmbmenu = FALSE


// RDT 6-27-03 Added sort
This.of_SetSort(TRUE)
This.inv_sort.of_SetColumnHeader(TRUE)
This.inv_sort.of_SetStyle(0)


end event

event rbuttonup;call super::rbuttonup;String	lsa_parm_labels[]
Any		laa_parm_values[]
Long		ll_ModCount
Long		ll_imageId

Integer	li_Return
		n_cst_msg	lnv_Msg
		s_Parm		lstr_Parm

n_cst_LicenseManager	lnv_LicMan

ll_ModCount = THIS.Modifiedcount( )

	
lsa_parm_labels[1] = "ADD_ITEM"
laa_parm_values[1] = "Company List"
	
lsa_parm_labels[2] = "ADD_ITEM"
laa_parm_values[2] = "Email Images"

lsa_parm_labels[3] = "ADD_ITEM"
laa_parm_values[3] = "Copy Images"

IF lnv_LicMan.of_hasdocumentttansfer( ) THEN
	lsa_parm_labels[4] = "ADD_ITEM"
	laa_parm_values[4] = "Add to Transfer Queue"
END IF	

//added by Dan 1-9-2006
//IF row > 0 THEN
//	IF this.getItemNumber( row, "image_id" ) > 0 THEN
		lsa_parm_labels[upperBound(lsa_parm_labels)+1] = "ADD_ITEM"
		laa_parm_values[upperBound(laa_parm_values)+1] = "Image Log"
//	END IF
//END IF

//-----------------

Choose Case f_pop_standard(lsa_parm_labels, laa_parm_values) 
	Case "COMPANY LIST" 
		THIS.Event ue_CompanyList ( )
	Case "EMAIL IMAGES" 
		IF ll_ModCount > 0 THEN
			IF MessageBox ( "E-Mail Images" , "Changes to the Image List need to be saved before images can be e-mailed. Do you want to save the list now?" , QUESTION! , YESNO!, 1 ) = 1 THEN
				IF THIS.event ue_savelist( ) = 1 THEN
					ll_ModCount = 0
				END IF
			END IF
		END IF
		
		IF ll_ModCount = 0 THEN
			THIS.Event ue_EmailImage ( )
		END IF
	Case "COPY IMAGES" 
		IF ll_ModCount > 0 THEN
			IF MessageBox ( "Copy Images" , "Changes to the Image List need to be saved before images can be copied. Do you want to save the list now?" , QUESTION! , YESNO!, 1 ) = 1 THEN
				IF THIS.event ue_savelist( ) = 1 THEN
					ll_ModCount = 0
				END IF
			END IF
		END IF
		
		IF ll_ModCount = 0 THEN
			THIS.Event ue_CopyImage ( )
		END IF
		
	Case Upper ( "Add to Transfer Queue"  )
		IF ll_ModCount > 0 THEN
			IF MessageBox ( "Transfer Documents" , "Changes to the Image List need to be saved before images can be added to the queue. Do you want to save the list now?" , QUESTION! , YESNO!, 1 ) = 1 THEN
				IF THIS.event ue_savelist( ) = 1 THEN
					ll_ModCount = 0
				END IF
			END IF
		END IF
		
		IF ll_ModCount = 0 THEN
			THIS.Event ue_Addtotransferqueue( )
		END IF
	CASE	"IMAGE LOG"						//added by Dan 1-9-2006
		IF row > 0 THEN
			ll_imageId = this.getitemNumber( row, "image_id")
		ELSE 
			ll_imageId = THIS.event ue_getimageid( )
		END IF
		
		
		lstr_Parm.is_Label = "IMAGEID"
		lstr_Parm.ia_value = ll_imageId
		lnv_Msg.of_add_parm( lstr_Parm )
		
		//Open Link Dialog box and pass This as the parm to hold the Master
		IF NOT IsValid ( w_imageModLog ) THEN
			OpenWithParm(w_imagemodLog, lnv_Msg)
		ELSE
			w_imageModLog.SetFocus ( )
			
		END IF



//		IF isValid( w_imagemodLog ) THEN
//			w_imagemodLog.setFocus()
//			//w_imagemodLog.wf_filter( ll_imageId )
//		ELSE
//			OPEN (w_imagemodLog) 
//			//w_imagemodLog.wf_filter( ll_imageId )
//		END IF
		
		//---------------------------------------------------
End Choose	
		


RETURN AncestorReturnValue


//IF f_pop_standard(lsa_parm_labels, laa_parm_values) = "COMPANY LIST" THEN
//	THIS.Event ue_CompanyList ( )
//END IF
//
//IF f_pop_standard(lsa_parm_labels, laa_parm_values) = "EMAIL IMAGES" THEN
//	THIS.Event ue_EmailImage ( )
//END IF
//
//IF f_pop_standard(lsa_parm_labels, laa_parm_values) = "COPY IMAGES" THEN
//	THIS.Event ue_CopyImage ( )
//END IF
//
end event

event itemchanged;// Override with call to Super
// ZMC. 10-31-03 
// Coded to disallow users from assignning an archived TmpId to a freshly scanned image.

// Modified by Dan 5-5-2006 to dissallow users from assigning a tmpID to a division that
// they do not have permission to scan to.

Int li_RtnVal
String ls_ErrMsg
Int	li_TmpStatus
Long	ll_division
N_cst_privsManager	lnv_privsManager

lnv_privsManager = gnv_app.of_getprivsmanager( )	//will be replaced by a global privs manager

IF Lower(dwo.name) = "image_id" THEN
	
	n_cst_shipmentManager lnv_ShipmentManager
	n_cst_bso_ImageManager lnv_ImageManager
	lnv_ImageManager = CREATE n_cst_bso_ImageManager
	IF NOT lnv_ShipmentManager.of_ShipmentExists ( long ( data ) ) THEN
		li_RtnVal = 1
		ls_ErrMsg = "The specified shipment does not exist. ~r~nrequest cancelled." 
		MessageBox(lnv_ImageManager.cs_ErrMsgHeader,ls_ErrMsg)
	ELSE
		
		li_TmpStatus = lnv_ImageManager.of_GetTmpArchiveStatus ( long ( data ) )
		IF li_TmpStatus = -1 THEN // archived
			li_RtnVal = 1
			ls_ErrMsg = "The specified shipment has had its images archived. ~r~nrequest cancelled." 
			MessageBox(lnv_ImageManager.cs_ErrMsgHeader,ls_ErrMsg)
		ELSEIF li_TmpStatus = -2 THEN// only copied not deleted
			ls_ErrMsg = "The specified shipment has had its images copied to be archived. By making this assignment you will have to recopy the shipment range to include this in the archive. Are you sure you want to do this?"
			IF MessageBox(lnv_ImageManager.cs_ErrMsgHeader,ls_ErrMsg,  QUESTION! , YESNO!, 2 ) = 2 THEN
				li_RtnVal = 1
			END IF
		ELSE
			// let the change happen
			//--modified By dan- let change happen if they have permission to scan the image to the shipment.
			ll_division = lnv_shipmentManager.of_getDivision( long(data) )	//data= tmpnumber
			IF lnv_privsManager.of_getuserpermissionfromfn( cs_functionSCAN, ll_division ) = 1 THEN
				//let the change happen
			ELSE
				ls_errMsg = "You do not sufficient rights to scan images for that division."
				li_rtnVal = 1	//prevent the change
				MessageBox( lnv_ImageManager.cs_ErrMsgHeader,ls_errmsg, EXCLAMATION! )
			END IF
			//-------------------------------------------------------------------------------------
		END IF
	END IF
	
//	IF lnv_ImageManager.of_doesarchiveimagesexists(Long(data)) = 1 THEN
//		ls_ErrMsg = "Image(s) have been archived for Tmp No. "  +  String(data) + "."
//		MessageBox(lnv_ImageManager.cs_ErrMsgHeader,ls_ErrMsg)
//		li_RtnVal = 1 // Do not allow focus to change & reject changed value.
//	END IF								
	

	
END IF

//DESTROY lnv_privsManager

IF li_RtnVal <> 1 THEN
	li_RtnVal = Super::event itemchanged(row,dwo,data)
END IF	

Return li_RtnVal
end event

on u_dw_imagelist.create
end on

event itemerror;call super::itemerror;Int li_RtnVal

li_RtnVal = AncestorReturnValue

IF Lower(dwo.name) = "image_id" THEN
	li_RtnVal = 1 // Error Message is handled by Itemchanged
END IF

Return li_RtnVal
end event

