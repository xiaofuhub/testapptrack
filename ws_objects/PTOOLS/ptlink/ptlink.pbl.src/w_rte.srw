$PBExportHeader$w_rte.srw
$PBExportComments$Run window
forward
global type w_rte from Window
end type
type dw_1 from datawindow within w_rte
end type
type rte_1 from richtextedit within w_rte
end type
end forward

global type w_rte from Window
int X=0
int Y=4
int Width=3653
int Height=2284
boolean TitleBar=true
string MenuName="m_rte"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_newtemplate ( )
dw_1 dw_1
rte_1 rte_1
end type
global w_rte w_rte

type variables
String	is_FindNext, is_FileName 
Boolean	ib_HeadFoot, ib_DataSource
s_rate_confirmation istr_rc

end variables

forward prototypes
public function integer of_print ()
public function integer of_save ()
public function integer of_saveas ()
public function integer of_cut ()
public function integer of_copy ()
public function integer of_paste ()
public function integer of_delete ()
public function integer of_selectall ()
public function integer of_find ()
public function integer of_findnext ()
public function integer of_timedate ()
public function integer of_undo ()
public function boolean of_isprintpreview ()
public function integer of_replace ()
public subroutine of_insert_datafield (string as_column)
public function integer of_setfind (string as_find)
public function boolean of_showhf (boolean ab_query)
public function integer of_new ()
public subroutine of_insert_picture ()
public subroutine of_insertdocument ()
public subroutine of_deletedatafield ()
public function integer of_open (string as_filename)
public subroutine of_change_pickup ()
public function boolean of_canundo ()
end prototypes

event ue_newtemplate;//dw_1 contains the template. 
//This is for PT use only.
	datastore lds_pickups_deliveries
	lds_pickups_deliveries = Create datastore
	lds_pickups_deliveries.dataobject = "d_rate_confirmation_detail"
	lds_pickups_deliveries.InsertRow(0)
	lds_pickups_deliveries.Object.trip_TRIPid[1]=istr_rc.rc_tripdetail.Object.trip_id[1]
	lds_pickups_deliveries.Object.trip_tripdate[1]=istr_rc.rc_tripdetail.Object.trip_tripdate[1]
	lds_pickups_deliveries.Object.Trip_CarrierTripNumber[1]= istr_rc.rc_tripdetail.Object.Trip_CarrierTripNumber[1]
	lds_pickups_deliveries.Object.trip_driver[1]=istr_rc.rc_tripdetail.Object.trip_driver[1]
	lds_pickups_deliveries.Object.Trip_EquipmentType[1]=istr_rc.rc_tripdetail.Object.Trip_EquipmentType[1]
	lds_pickups_deliveries.Object.Trip_EquipmentNumber[1]=istr_rc.rc_tripdetail.Object.Trip_EquipmentNumber[1]
	lds_pickups_deliveries.Object.Trip_ChassisNumber[1]=istr_rc.rc_tripdetail.Object.Trip_ChassisNumber[1]
	lds_pickups_deliveries.Object.Trip_OriginId[1]=istr_rc.rc_tripdetail.Object.Trip_OriginId[1]
	lds_pickups_deliveries.Object.Trip_DestinationId[1]=istr_rc.rc_tripdetail.Object.Trip_DestinationId[1]
	lds_pickups_deliveries.Object.trip_miles[1]=istr_rc.rc_tripdetail.Object.trip_miles[1]
	lds_pickups_deliveries.Object.Trip_TotalWeight[1]=istr_rc.rc_tripdetail.Object.Trip_TotalWeight[1]
	lds_pickups_deliveries.Object.Trip_InternalNote[1]=istr_rc.rc_tripdetail.Object.Trip_InternalNote[1]
	lds_pickups_deliveries.Object.Trip_PayablesTotal[1]=istr_rc.rc_tripdetail.Object.Trip_PayablesTotal[1]
	lds_pickups_deliveries.Object.trip_status[1]=istr_rc.rc_tripdetail.Object.trip_status[1]
	lds_pickups_deliveries.Object.Trip_CarrierName[1]=istr_rc.rc_tripdetail.Object.Trip_CarrierName[1]
	lds_pickups_deliveries.Object.pickups[1]=istr_rc.rc_pickupdelivery
	lds_pickups_deliveries.Object.tempnumber[1]=istr_rc.rc_tempnumber
	lds_pickups_deliveries.sharedata ( dw_1 )
	rte_1.PasteRTF (dw_1.CopyRTF (False,header! ), Header!)
	rte_1.PasteRTF (dw_1.CopyRTF (False,detail! ), Detail!)
	rte_1.PasteRTF (dw_1.CopyRTF (False,footer! ), Footer!)
//

end event

public function integer of_print ();//	can't print while showing headers and footers
IF ib_headfoot THEN
	this.of_Showhf ( false )
END IF

//rte_1.BottomMargin = 0.250
//rte_1.TopMargin = 0.250
//rte_1.LeftMargin = 0.500
//rte_1.RightMargin = 0.500

Return rte_1.print(1, "", False, True)

end function

public function integer of_save ();//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_module_Brokerage, "S" ) < 0 THEN
	return 0 
END IF

If is_FileName = "Untitled" Then
	Return of_saveas()
Else
	rte_1.modified = False
	Return rte_1.savedocument(is_FileName, FileTypeRichText!)
End If
end function

public function integer of_saveas ();String	ls_File, ls_Path

ls_Path = is_FileName
Int	li_SaveRtn

li_SaveRtn = GetFileSaveName("Select File", ls_Path, ls_File, "rtf", "Rich Text (*.rtf), *.rtf") 

If li_SaveRtn = 1  Then
	is_FileName = ls_Path
	This.Title = ls_File + " - Richpad"
	
	Return This.of_save()
	
Else//IF li_SaveReturn = 0 THEN
	Return 0
End If

end function

public function integer of_cut ();Return rte_1.cut()

end function

public function integer of_copy ();STRING LS_PICKUP
LS_PICKUP=RTE_1.COPYRTF()
Return rte_1.copy()

end function

public function integer of_paste ();Return rte_1.paste()

end function

public function integer of_delete ();Return rte_1.clear()

end function

public function integer of_selectall ();Return rte_1.selecttextall()

end function

public function integer of_find ();OpenWithParm(w_rte_find, rte_1)

Return 1

end function

public function integer of_findnext ();If is_FindNext = "" Then
	of_find()
Else
	rte_1.findnext()
End If

Return 0

end function

public function integer of_timedate ();DateTime	ldt_Now

ldt_Now = DateTime(Today(), Now())

rte_1.replacetext(String(ldt_Now, "mm/dd/yy hh:mm:ss"))

Return 1

end function

public function integer of_undo ();Return rte_1.Undo()

end function

public function boolean of_isprintpreview ();Return rte_1.ispreview() 

end function

public function integer of_replace ();OpenWithParm(w_rte_replace, rte_1)

Return 1

end function

public subroutine of_insert_datafield (string as_column);// This function will insert a datafield into the current document.

// Insert the data field.
integer li_Return
li_Return = rte_1.inputfieldinsert(as_Column)


end subroutine

public function integer of_setfind (string as_find);is_FindNext = as_Find

Return 1

end function

public function boolean of_showhf (boolean ab_query);If ab_Query Then Return ib_HeadFoot

If ib_HeadFoot Then
	ib_HeadFoot = False
Else
	ib_HeadFoot = True
End If

rte_1.showheadfoot(ib_HeadFoot)

Return ib_HeadFoot

end function

public function integer of_new ();String	ls_File, ls_Path
Integer	li_RC

If rte_1.modified Then
	li_RC = MessageBox("Richpad", "The Text in " + is_FileName + &
								" has changed.~r~nDo you want to save the changes?", &
								Question!, YesNoCancel!)

	Choose Case li_RC
		Case 1
			This.of_save()
		Case 3
			Return 0
	End Choose
End If

// Display empty rte
rte_1.SetRedraw(False)

of_selectall()
of_delete()
is_FileName = "Untitled"
This.Title = "Untitled - Richpad"
rte_1.modified = False

rte_1.SetRedraw(True)

Return 1

end function

public subroutine of_insert_picture ();// This function will insert a picture into the current document.

String	ls_File, ls_Path
Integer	li_RC

GetFileOpenName("Select File", ls_Path, ls_File, "bmp", "Bitmap files, *.BMP")
//If GetFileOpenName("Select File", ls_Path, ls_File, "bmp", "Bitmap files, *.BMP") = 1 Then
//	is_FileName = ls_Path
//	rte_1.insertdocument(is_FileName, True, FileTypeRichText!)
//	This.Title = ls_File + " - Richpad"
//	rte_1.modified = False
//	Return 1
//Else
//	Return 0
//End If


rte_1.InsertPicture (ls_file)


end subroutine

public subroutine of_insertdocument ();// This function will insert a picture into the current document.

String	ls_File, ls_Path
Integer	li_RC

GetFileOpenName("Select File", ls_Path, ls_File, "*.txt, *.*",  &
			"Text Files (*.TXT), *.TXT, All Files (*.*), *.*")


li_RC = rte_1.InsertDocument (ls_Path, FALSE)
li_RC = 0

end subroutine

public subroutine of_deletedatafield ();rte_1.InputFieldDeleteCurrent ( )
end subroutine

public function integer of_open (string as_filename);String	ls_File, &
			ls_Path, &
			ls_filter
			
Integer	li_Return = 1

n_cst_FileSrvWin32 lnv_FileSrv
lnv_FileSrv = CREATE n_cst_FileSrvWin32

If rte_1.modified Then
	li_Return = MessageBox("Rate Confirmation", "The Text in " + is_FileName + &
								" has changed.~r~nDo you want to save the changes?", &
								Question!, YesNoCancel!)

	Choose Case li_Return
		Case 1
			This.of_save()
		Case 2
			li_Return = 1
		Case 3
			li_Return = -1
	End Choose
End If

IF li_Return = 1 THEN
	IF isnull ( as_filename ) or &
		len ( as_filename ) = 0 or &
		as_filename = "TEMPLATE" THEN
		IF GetFileOpenName("Select File", ls_Path, ls_File, "rtf", "Rich Text (*.rtF), *.rtf") = 1 THEN
			as_FileName = ls_Path
		ELSE
			li_Return = -1
		END IF
	END IF
END IF
IF li_Return = 1 THEN
	IF Mid ( as_FileName , Len ( as_FileName ) , Len (as_FileName ) ) ="\" THEN
		lnv_FileSrv.of_ChangeDirectory ( as_FileName ) 
		IF GetFileOpenName("Select File", ls_Path, ls_File, "rtf", "Rich Text (*.rtF), *.rtf") = 1 THEN
			as_FileName = ls_Path
		ELSE
			li_Return = -1
		END IF
		
	END IF
	
	IF li_Return = 1 THEN
		rte_1.insertdocument(as_FileName, True, FileTypeRichText!)
		This.Title = ls_File + " - Rate Confirmation"
		rte_1.modified = False
	END IF
END IF

IF li_Return = 1 THEN
	IF istr_rc.rc_template <> "TEMPLATE" THEN
		datastore lds_pickups_deliveries
		lds_pickups_deliveries = Create datastore
		lds_pickups_deliveries.dataobject = "d_rate_confirmation_detail"
		lds_pickups_deliveries.InsertRow(0)
		lds_pickups_deliveries.Object.trip_TRIPid[1]=istr_rc.rc_tripdetail.Object.trip_id[1]
		lds_pickups_deliveries.Object.trip_tripdate[1]=istr_rc.rc_tripdetail.Object.trip_tripdate[1]
		lds_pickups_deliveries.Object.Trip_CarrierTripNumber[1]= istr_rc.rc_tripdetail.Object.Trip_CarrierTripNumber[1]
		lds_pickups_deliveries.Object.trip_driver[1]=istr_rc.rc_tripdetail.Object.trip_driver[1]
		lds_pickups_deliveries.Object.Trip_EquipmentType[1]=istr_rc.rc_tripdetail.Object.Trip_EquipmentType[1]
		lds_pickups_deliveries.Object.Trip_EquipmentNumber[1]=istr_rc.rc_tripdetail.Object.Trip_EquipmentNumber[1]
		lds_pickups_deliveries.Object.Trip_ChassisNumber[1]=istr_rc.rc_tripdetail.Object.Trip_ChassisNumber[1]
		lds_pickups_deliveries.Object.Trip_OriginId[1]=istr_rc.rc_tripdetail.Object.Trip_OriginId[1]
		lds_pickups_deliveries.Object.Trip_DestinationId[1]=istr_rc.rc_tripdetail.Object.Trip_DestinationId[1]
		lds_pickups_deliveries.Object.trip_miles[1]=istr_rc.rc_tripdetail.Object.trip_miles[1]
		lds_pickups_deliveries.Object.Trip_TotalWeight[1]=istr_rc.rc_tripdetail.Object.Trip_TotalWeight[1]
		lds_pickups_deliveries.Object.Trip_InternalNote[1]=istr_rc.rc_tripdetail.Object.Trip_InternalNote[1]
		lds_pickups_deliveries.Object.Trip_PayablesTotal[1]=istr_rc.rc_tripdetail.Object.Trip_PayablesTotal[1]
		lds_pickups_deliveries.Object.trip_status[1]=istr_rc.rc_tripdetail.Object.trip_status[1]
		lds_pickups_deliveries.Object.Trip_CarrierName[1]=istr_rc.rc_tripdetail.Object.Trip_CarrierName[1]
		lds_pickups_deliveries.Object.pickups[1]=istr_rc.rc_pickupdelivery
		lds_pickups_deliveries.Object.tempnumber[1]=istr_rc.rc_tempnumber
		lds_pickups_deliveries.sharedata ( dw_1 )
		li_Return = rte_1.datasource(lds_pickups_deliveries)
	END IF
END IF

DESTROY lnv_FileSrv

ib_DataSource = True
is_filename = as_filename
Return li_Return
end function

public subroutine of_change_pickup ();rte_1.InputFieldChangeData ( "pickups", "company:                             phone:                ~r," + &
													"company name                          contact:              ," + &
													"address 1                                                   ,"  + &
													"address 2                                                   ,")
end subroutine

public function boolean of_canundo ();Return rte_1.canundo()
end function

on w_rte.create
if this.MenuName = "m_rte" then this.MenuID = create m_rte
this.dw_1=create dw_1
this.rte_1=create rte_1
this.Control[]={this.dw_1,&
this.rte_1}
end on

on w_rte.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.rte_1)
end on

event resize;rte_1.Resize(newwidth - (rte_1.X * 2), newheight - (rte_1.Y * 2))

end event

event open;/*
	This window can be opened in two different states.
	
	If the template being passed thru the structure is = to "TEMPLATE"
	then use openfile dialog to select file.
	
	If a template is passed then save the document as text and 
	insert then saved document.
	
	This will only replace the body of the document not the header and footer.
	The document will then be completely editable.
	
*/

//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_module_Brokerage, "E" ) < 0 THEN
	close ( this ) 
	return 
END IF


long	ll_LeftRight = .5
long	ll_TopBottom = .25
string	ls_CurrentDirectory, &
			ls_TextFile

n_cst_filesrvwin32	lnv_filesrvwin32

istr_rc = message.PowerObjectparm

//dw_1 contains the template. 
//To create a new template uncomment the following line.
//This is for PT use only.
//this.trigger Event ue_newtemplate()
//return
//

IF istr_rc.rc_template = "TEMPLATE" THEN
	is_filename = istr_rc.rc_template
	this.of_open ( is_filename )
ELSE
	lnv_filesrvwin32 = Create n_cst_filesrvwin32
	ls_CurrentDirectory = lnv_filesrvwin32.of_getcurrentdirectory ( ) 
	ls_textFile = ls_CurrentDirectory + "\test.txt"
	rte_1.SetRedraw(False)
	is_filename = istr_rc.rc_template
	this.of_open ( is_filename )
	rte_1.savedocument(ls_textFile, FileTypeText!)
	rte_1.SelectTextAll ( detail! )
	rte_1.Clear ( )
	rte_1.insertdocument(ls_textFile, false, FileTypeText!)
	rte_1.SetRedraw(true)	
	m_rte.m_file.m_new.enabled=false
	m_rte.m_file.m_open.enabled=false
	m_rte.m_file.m_save.enabled=false
	IF FileExists ( ls_textFile ) THEN
		FileDelete ( ls_textFile )
	END IF
END IF

IF isvalid(lnv_filesrvwin32) then
	DESTROY lnv_filesrvwin32
END IF


end event

event closequery;Integer	li_RC

//	If the structure is empty then we came from the menu
//	and we are saving the template otherwise we are working with
//	the actual rate confirmation and will not query to save changes
//

IF istr_rc.rc_template = "TEMPLATE" THEN
	If rte_1.modified Then
		li_RC = MessageBox("Rate Confirmation", &
				"Do you want to save this as your rate confirmation template?", &
									Question!, YesNoCancel!)
	
		Choose Case li_RC
			Case 1
				
				IF This.of_saveas() = 0 THEN
					RETURN 1 // prevent window from closing
				END IF
				
				Return 0
			Case 2
				Return 0
			Case 3
				Return 1
		End Choose
	End If
END IF
end event

type dw_1 from datawindow within w_rte
int X=133
int Y=196
int Width=3406
int Height=1780
boolean Visible=false
string DataObject="d_rate_confirmation_template"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type rte_1 from richtextedit within w_rte
int X=14
int Width=3625
int Height=2104
int TabOrder=10
boolean Border=false
end type

on rte_1.create
HScrollBar=true
VScrollBar=true
HeaderFooter=true
PopMenu=true
RulerBar=true
TabBar=true
ToolBar=true
WordWrap=true
UndoDepth=100
BackColor=16777215
InputFieldBackColor=16777215
end on

