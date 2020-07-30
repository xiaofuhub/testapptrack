$PBExportHeader$w_document_display.srw
$PBExportComments$[w_sheet] Displays documents for review
forward
global type w_document_display from w_sheet
end type
type uo_documentlist from u_cst_documentselect within w_document_display
end type
type uo_mle from u_cst_mle within w_document_display
end type
type gb_content from u_gb within w_document_display
end type
end forward

global type w_document_display from w_sheet
int X=0
int Y=4
int Width=3621
int Height=2380
boolean TitleBar=true
string Title="Shipment Document Review "
string MenuName="m_sheets"
long BackColor=80269524
uo_documentlist uo_documentlist
uo_mle uo_mle
gb_content gb_content
end type
global w_document_display w_document_display

type variables
Private:
Long		il_Shipmentid[]
n_cst_msg 	inv_msg

end variables

forward prototypes
private function integer wf_showtext (string as_filepath)
public function integer wf_showimage (string as_filepath)
end prototypes

private function integer wf_showtext (string as_filepath);//
/***************************************************************************************
NAME			: ws_ShowText
ACCESS		: Private
ARGUMENTS	: String		(Filename with full path)
RETURNS		: Integer	(failure, success) 
DESCRIPTION	: Display the file contents on the window mle

REVISION		: RDT 092602
***************************************************************************************/
String	ls_Text[], &
			ls_MLEtext
			
Integer	li_Return, & 
			li_Result

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)				// Create file service

lnv_FileSrv.of_FileRead ( as_filepath, ls_text[] ) // read file

// show mle object
uo_mle.Visible = TRUE
// hide image object
//uo_image.Visible = FALSE 

If UpperBound(ls_text [] ) > 0 Then 
	li_Result = uo_mle.of_SetText(ls_Text[])
	li_Return = li_Result
Else
	li_Result = uo_mle.of_SetText("Error Reading file.")
	li_Return = Failure
End If

f_SetFileSrv(lnv_FileSrv, FALSE )			// Destroy file service

Return li_Return 

end function

public function integer wf_showimage (string as_filepath);//
/***************************************************************************************
NAME			: wf_showimage	
ACCESS		: public	
ARGUMENTS	: String 	(Filename w/ Path)
RETURNS		: Integer 	(Success, Failure)
DESCRIPTION	: 
					UO_IMAGE WAS DELETED 
REVISION		: RDT 092602
***************************************************************************************/
Integer 	li_Return = 1

//uo_mle.Visible = FALSE
//
//uo_image.Visible = TRUE
//
//// populate the image document
//
//uo_image.of_ShowImage(as_filepath)

Return li_Return 
end function

on w_document_display.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.uo_documentlist=create uo_documentlist
this.uo_mle=create uo_mle
this.gb_content=create gb_content
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_documentlist
this.Control[iCurrent+2]=this.uo_mle
this.Control[iCurrent+3]=this.gb_content
end on

on w_document_display.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_documentlist)
destroy(this.uo_mle)
destroy(this.gb_content)
end on

event open;call super::open;
inv_msg = Message.PowerObjectParm					// PowerObject contains msg with shipment id's
ib_disableclosequery = TRUE							// No Updates allowed in this window. 

//uo_image.Visible= FALSE

//Enable the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize ( 1300, 400 )

//Register Resizable controls
inv_Resize.of_Register ( uo_documentlist, 'FixedToRight&ScaleToBottom' )
inv_Resize.of_Register ( uo_mle, 'ScaleToRight&Bottom' )
//inv_Resize.of_Register ( uo_image, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( gb_content, 'ScaleToRight&Bottom' )


// 
gf_Mask_Menu(m_Sheets)

end event

event pfc_postopen;uo_documentlist.of_RetrieveDocs ( inv_msg )			// get list of document types and populate datawindow
uo_documentlist.of_SetFocus("List")
end event

type uo_documentlist from u_cst_documentselect within w_document_display
event destroy ( )
int X=1769
int Y=8
int Width=1787
int Height=2248
int TabOrder=10
boolean BringToTop=true
long BackColor=80269524
end type

on uo_documentlist.destroy
call u_cst_documentselect::destroy
end on

event ue_documentclicked;//get the file name. 
//figure out the extension / type and display 
String	ls_FilePath, &
			ls_FileExtension

ls_filePath = Trim( this.of_GetFilePath() )
ls_FileExtension = Upper ( Trim ( Right ( ls_filePath, 3 ) ) )

Choose Case ls_FileExtension 
	Case 	"TXT"
		Parent.wf_ShowText( ls_filePath )

//	Case	"TIF"
//		Parent.wf_ShowImage( ls_filePath )
End Choose

end event

type uo_mle from u_cst_mle within w_document_display
event destroy ( )
int X=27
int Y=60
int Width=1664
int Height=2092
int TabOrder=20
boolean BringToTop=true
long BackColor=80269524
end type

on uo_mle.destroy
call u_cst_mle::destroy
end on

event constructor;call super::constructor;//
this.mle_1.DisplayOnly = TRUE

end event

type gb_content from u_gb within w_document_display
int X=9
int Y=8
int Width=1701
int Height=2164
int TabOrder=0
string Text="Content"
BorderStyle BorderStyle=StyleBox!
long TextColor=0
end type

