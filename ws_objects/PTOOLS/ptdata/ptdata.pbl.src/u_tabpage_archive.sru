$PBExportHeader$u_tabpage_archive.sru
forward
global type u_tabpage_archive from u_tabpage_imagearchive
end type
type st_3 from statictext within u_tabpage_archive
end type
type st_2 from statictext within u_tabpage_archive
end type
type ddlb_selectvol from dropdownlistbox within u_tabpage_archive
end type
type st_1 from statictext within u_tabpage_archive
end type
type cb_recopy from commandbutton within u_tabpage_archive
end type
type st_recopy2 from statictext within u_tabpage_archive
end type
type sle_recopyendshipmentnum from singlelineedit within u_tabpage_archive
end type
type sle_recopystartshipmentnum from singlelineedit within u_tabpage_archive
end type
type st_recopy1 from statictext within u_tabpage_archive
end type
type sle_imagingrootfolder from singlelineedit within u_tabpage_archive
end type
type st_imagingrootfolder from statictext within u_tabpage_archive
end type
type cb_delete from commandbutton within u_tabpage_archive
end type
type ddlb_volume from dropdownlistbox within u_tabpage_archive
end type
type st_volume from statictext within u_tabpage_archive
end type
type st_deleteimages3 from statictext within u_tabpage_archive
end type
type st_deleteimages2 from statictext within u_tabpage_archive
end type
type st_deleteimages1 from statictext within u_tabpage_archive
end type
type st_mb from statictext within u_tabpage_archive
end type
type sle_maxsizearchive from singlelineedit within u_tabpage_archive
end type
type st_maxarchivemediasize from statictext within u_tabpage_archive
end type
type cb_copy from commandbutton within u_tabpage_archive
end type
type sle_endshipmentnum from singlelineedit within u_tabpage_archive
end type
type st_to from statictext within u_tabpage_archive
end type
type sle_startshipmentnum from singlelineedit within u_tabpage_archive
end type
type st_shipmentnum from statictext within u_tabpage_archive
end type
type st_archiveimages2 from statictext within u_tabpage_archive
end type
type st_archiveimages1 from statictext within u_tabpage_archive
end type
type gb_archiveimages from groupbox within u_tabpage_archive
end type
type gb_deleteimages from groupbox within u_tabpage_archive
end type
type gb_recopy from groupbox within u_tabpage_archive
end type
type gb_3 from groupbox within u_tabpage_archive
end type
end forward

global type u_tabpage_archive from u_tabpage_imagearchive
integer height = 1436
event ue_copyimages ( long al_startshipmentid,  long al_endshipmentid,  long al_maxarchivesize )
event type long ue_getmaxshipmentid ( )
event type long ue_getmaxarchivesize ( )
event ue_recopyimages ( long al_startshipmentid,  long al_endshipmentid,  long al_maxarchivesize,  long al_volnum )
event ue_deleteimages ( long al_volumenumber )
st_3 st_3
st_2 st_2
ddlb_selectvol ddlb_selectvol
st_1 st_1
cb_recopy cb_recopy
st_recopy2 st_recopy2
sle_recopyendshipmentnum sle_recopyendshipmentnum
sle_recopystartshipmentnum sle_recopystartshipmentnum
st_recopy1 st_recopy1
sle_imagingrootfolder sle_imagingrootfolder
st_imagingrootfolder st_imagingrootfolder
cb_delete cb_delete
ddlb_volume ddlb_volume
st_volume st_volume
st_deleteimages3 st_deleteimages3
st_deleteimages2 st_deleteimages2
st_deleteimages1 st_deleteimages1
st_mb st_mb
sle_maxsizearchive sle_maxsizearchive
st_maxarchivemediasize st_maxarchivemediasize
cb_copy cb_copy
sle_endshipmentnum sle_endshipmentnum
st_to st_to
sle_startshipmentnum sle_startshipmentnum
st_shipmentnum st_shipmentnum
st_archiveimages2 st_archiveimages2
st_archiveimages1 st_archiveimages1
gb_archiveimages gb_archiveimages
gb_deleteimages gb_deleteimages
gb_recopy gb_recopy
gb_3 gb_3
end type
global u_tabpage_archive u_tabpage_archive

type variables

end variables

forward prototypes
public function integer of_getimagingrootfolder (string as_getimagingrootfolder)
public function integer of_populatevolumenumbers (long ala_volumenumbers[])
public function integer of_populaterecopyvolume (long ala_recopyvolumenum[])
public function integer of_populaterecopyshipmentids (datastore ads_imagearchive)
public function integer of_archivetabpgvalidations (string as_errormessage, integer ai_returnvalue)
public function integer setfocus ()
public function integer of_setendshipmentid (long al_endshipmentid)
public function integer of_setstartshipmentid (long al_startshipmentid)
public subroutine of_enadisrecopyvolume (integer ai_flag)
public subroutine of_enadisvolume (integer ai_flag)
public subroutine of_resetvolume ()
public subroutine of_resetrecopyvolume ()
public function integer of_setmaxarchivesizeonupdate (long al_maxarchivesize)
public subroutine of_makewaitmsginvisible ()
public subroutine of_makewaitmsgvisible ()
public subroutine of_makewaitrecopymsginvisible ()
public subroutine of_makewaitrecopymsgvisible ()
public subroutine of_setcursoronendshipmentid ()
end prototypes

public function integer of_getimagingrootfolder (string as_getimagingrootfolder);/////////////////////////////////////////////////////////////////////
//
// Function		: of_getimagingrootfolder
// Arguments	: as_getimagingrootfolder - String by value
// Returns 		: 1 = Success 		-1 = Failure
// Description : This method is called to display Imaging root folder 
//						information stored in system settings table (Ss_is = 33)
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

Int li_ReturnValue = 1
String ls_GetImagingRootFolder

ls_GetImagingRootFolder = as_GetImagingRootFolder

sle_imagingrootfolder.Text = ls_GetImagingRootFolder

Return li_ReturnValue

end function

public function integer of_populatevolumenumbers (long ala_volumenumbers[]);/////////////////////////////////////////////////////////////////////
//
// Function		: of_populatevolumenumbers
// Arguments	: ala_volumenumbers[] - Long Array by value
// Returns 		: 1 = Success 		-1 = Failure
// Description : This method is called to populate DDLB in copy area
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////


Int li_ReturnValue = 1 
Int li_Ctr
Int li_UpperBound

Long ll_VolumeNumbers[]

ll_VolumeNumbers =  ala_volumenumbers

li_UpperBound = UpperBound(ll_VolumeNumbers)

IF li_UpperBound > 0 THEN
	ddlb_volume.Reset()
	
	FOR li_Ctr = 1 TO li_UpperBound
		ddlb_volume.AddItem(String(ll_VolumeNumbers [li_Ctr]))	
	NEXT 
	ddlb_volume.Text = String(ll_VolumeNumbers[1])
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue


end function

public function integer of_populaterecopyvolume (long ala_recopyvolumenum[]);/////////////////////////////////////////////////////////////////////
//
// Function		: of_populaterecopyshipmentids
// Arguments	: ala_recopyvolumenum[] - Long Array by value
// Returns 		: 1 = Success 		-1 = Failure
// Description : This method is called to populate DDLB in Recopy area
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

Int li_ReturnValue = 1 
Int li_UpperBound
Int li_Ctr

Long ll_recopyvolumenum[]

ll_recopyvolumenum[] = ala_recopyvolumenum[]
li_UpperBound = UpperBound(ll_recopyvolumenum[])

IF li_UpperBound > 0 THEN
	ddlb_selectvol.Reset()
	
	FOR li_Ctr = 1 TO li_UpperBound
		ddlb_selectvol.AddItem(String(ll_recopyvolumenum[li_Ctr]))
	NEXT
	
	ddlb_selectvol.Text = String(ll_recopyvolumenum[1])
ELSE
	li_ReturnValue = -1
END IF

Return li_ReturnValue


end function

public function integer of_populaterecopyshipmentids (datastore ads_imagearchive);/////////////////////////////////////////////////////////////////////
//
// Function		: of_populaterecopyshipmentids
// Arguments	: ads_imagearchive - DataStore by value
// Returns 		: 1 = Success 		-1 = Failure
// Description : This method is called to populate shipment id numbers
//					  for recopying images when a user selects appropriate
//					  volume number from the DDLB in Recopy area
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

Int li_ReturnValue = 1
Int li_RowFound

String ls_SearchStr
String ls_MsgHeader = 'Imaging Archive'

Long ll_StartShipmentId
Long ll_EndShipmentId

Long ll_VolumeNumber
Long ll_RowCount

DataStore lds_ImageArchive

lds_ImageArchive = ads_ImageArchive

lds_ImageArchive.SetTransObject(SQLCA)
lds_ImageArchive.Retrieve()

ll_RowCount = lds_ImageArchive.Rowcount( )

IF ll_RowCount < 0 THEN
	li_ReturnValue = -1
	MessageBox(ls_MsgHeader,'Error retrieving rows to populate shipment id range')
END IF

IF	li_ReturnValue = 1 THEN
	IF ll_RowCount > 0 THEN
	
		ll_VolumeNumber = Long(ddlb_SelectVol.Text)
	
		ls_SearchStr = "volumenumberid = " + String(ll_VolumeNumber)
	
		li_RowFound = lds_ImageArchive.Find(ls_SearchStr,1,ll_RowCount)
	
		IF li_RowFound > 0 THEN
			ll_StartShipmentId	= lds_ImageArchive.Object.startshipmentid	[li_RowFound]
			ll_EndShipmentId		= lds_ImageArchive.Object.endshipmentid	[li_RowFound]
		
			sle_recopystartshipmentnum.Text 	=  String(ll_StartShipmentId)
			sle_recopyendshipmentnum.Text		=	String(ll_EndShipmentId)
		
		ELSE
			IF li_RowFound < 0 THEN
				li_ReturnValue = -1
				MessageBox(ls_MsgHeader,'Error finding shipment id range to recopy')
			END IF
	
			IF li_RowFound = 0 THEN
				li_ReturnValue = -1
				MessageBox(ls_MsgHeader,'Shipment id range was not found to recopy')
			END IF
		END IF
	ELSE
//		li_ReturnValue = -1
//		MessageBox(ls_MsgHeader,'No rows found to populate shipment id range')
	END IF
END IF

Return li_ReturnValue
end function

public function integer of_archivetabpgvalidations (string as_errormessage, integer ai_returnvalue);/////////////////////////////////////////////////////////////////////
//
// Function		: of_archivetabpgvalidations
// Arguments	: as_errormessage - String  by value
//					  ai_returnvalue	- Integer by value
// Returns 		: 1 = Success 		-1 = Failure
// Description : This method is called to throw error messages
//						to the user for editable columns on archive tab page
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

Int li_Ctr
Int li_ReturnValue = 1
Int li_RtnVal
String ls_errmsg
String ls_MsgHeader = 'Imaging Archive'

ls_errmsg = as_errormessage 
li_RtnVal = ai_ReturnValue

CHOOSE CASE li_RtnVal
	CASE -1
		MessageBox(ls_MsgHeader,ls_errmsg)
		sle_maxsizearchive.SelectText(1,Len((sle_maxsizearchive.Text)))
		sle_maxsizearchive.SetFocus()
	CASE -2
		MessageBox(ls_MsgHeader,ls_errmsg)		
		sle_endshipmentnum.SelectText(1,Len((sle_endshipmentnum.Text)))		
		sle_endshipmentnum.SetFocus()
	CASE -3
		MessageBox(ls_MsgHeader,ls_errmsg)
		sle_endshipmentnum.SelectText(1,Len((sle_endshipmentnum.Text)))				
		sle_endshipmentnum.SetFocus()
	CASE ELSE
		li_ReturnValue = -1 
END CHOOSE

Return li_ReturnValue

end function

public function integer setfocus ();/////////////////////////////////////////////////////////////////////
//
// Function		: setfocus
// Arguments	: None
// Returns 		: Integer - 1 = Success 2 = Not Success
// Description : This method is called to set focus on the end shipment #
//					  soon after the wondow is opened  
// Author		: Zach
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

Int li_ReturnValue
Sle_endshipmentnum.SetFocus()
Return li_ReturnValue
end function

public function integer of_setendshipmentid (long al_endshipmentid);/////////////////////////////////////////////////////////////////////
//
// Function		: of_setendshipmentid
// Arguments	: al_endshipmentid[] - Long 
// Returns 		: 1 = Success 		-1 = Failure
// Description : This method is called to set End Shipment id number
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

Int li_ReturnValue = 1 
Long ll_EndShipmentId
ll_EndShipmentId = al_endshipmentid
sle_endshipmentnum.Text = String(ll_EndShipmentId)
sle_endshipmentnum.SelectText(1,Len(sle_endshipmentnum.Text))
sle_endshipmentnum.SetFocus()

Return li_ReturnValue

end function

public function integer of_setstartshipmentid (long al_startshipmentid);/////////////////////////////////////////////////////////////////////
//
// Function		: of_setstartshipmentid
// Arguments	: 1. al_startshipmentid - Long by value
// Returns 		: 1 = Success 		-1 = Failure
// Description : This method is called to set Start Shipment id number
// Author		: Zach
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

Int li_ReturnValue = 1 
Long ll_StartShipmentId

ll_StartShipmentId = al_startshipmentid

sle_StartShipmentNum.Text = String(ll_StartShipmentId)
sle_EndShipmentNum.Text	  = ''
sle_EndShipmentNum.SetFocus()

Return li_ReturnValue
end function

public subroutine of_enadisrecopyvolume (integer ai_flag);/* ////////////////////////////////////////////////////////
 
   Function		: of_enadisrecopyvolume
   Arguments 	: ai_flag, Integer
   Returns 		: None
   Description : Depending on the flag value received, this method 
					  enables or disables ddlb_SelectVol which is used to 
					  select volume numbers for recopying images
   Author		: ZMC
   Created on 	: 10-15-03
   Modified by : Add Author here	TimeStamp
				
///////////////////////////////////////////////////////// */

Int li_Flag

li_flag = ai_flag

IF ai_flag = 1 THEN 
	ddlb_selectvol.Enabled = TRUE
ELSE
	ddlb_selectvol.Enabled = FALSE
	sle_recopystartshipmentnum.Text = ''
	sle_recopyEndshipmentnum.Text = ''
END IF
end subroutine

public subroutine of_enadisvolume (integer ai_flag);/* ////////////////////////////////////////////////////////
 
   Function		: of_enadisvolume
   Arguments 	: ai_flag, Integer
   Returns 		: None
   Description : Depending on the flag value received, this method 
					  enables or disables ddlb_Volume which is used to 
					  select volume numbers for deleting images
   Author		: ZMC
   Created on 	: 10-15-03
   Modified by : Add Author here	TimeStamp
				
///////////////////////////////////////////////////////// */

Int li_flag

li_flag = ai_flag

IF li_flag = 1 THEN
	ddlb_volume.Enabled = TRUE
ELSE
	ddlb_volume.Enabled = FALSE
END IF
	
end subroutine

public subroutine of_resetvolume ();/* ////////////////////////////////////////////////////////
 
   Function		: of_resetrecopyvolume
   Arguments 	: None 
   Returns 		: None
   Description : Resets the values in ddlb_selectvol, used to 
					  delete images for given volume number
   Author		: ZMC
   Created on 	: 10-15-03
   Modified by : Add Author here	TimeStamp
				
///////////////////////////////////////////////////////// */

ddlb_volume.Reset()
end subroutine

public subroutine of_resetrecopyvolume ();/* ////////////////////////////////////////////////////////
 
   Function		: of_resetrecopyvolume
   Arguments 	: None 
   Returns 		: None
   Description : Resets the values in ddlb_selectvol, used to 
					  recopy images for a TmpId range 	
   Author		: ZMC
   Created on 	: 10-15-03
   Modified by : Add Author here	TimeStamp
				
///////////////////////////////////////////////////////// */

ddlb_selectvol.Reset()
end subroutine

public function integer of_setmaxarchivesizeonupdate (long al_maxarchivesize);Int li_ReturnValue = 1
Long ll_MaxArchiveSize

ll_MaxArchiveSize = al_maxarchivesize

Sle_maxsizearchive.Text = String(ll_MaxArchiveSize)

Return li_ReturnValue
end function

public subroutine of_makewaitmsginvisible ();st_2.Visible 		= FALSE
cb_copy.Enabled 	= TRUE

end subroutine

public subroutine of_makewaitmsgvisible ();st_2.Visible = True
cb_copy.Enabled = FALSE

end subroutine

public subroutine of_makewaitrecopymsginvisible ();st_3.Visible 			= FALSE
cb_recopy.Enabled 	= TRUE

end subroutine

public subroutine of_makewaitrecopymsgvisible ();st_3.Visible 			= TRUE
cb_recopy.Enabled 	= FALSE

end subroutine

public subroutine of_setcursoronendshipmentid ();sle_endshipmentnum.SetFocus()
end subroutine

on u_tabpage_archive.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_2=create st_2
this.ddlb_selectvol=create ddlb_selectvol
this.st_1=create st_1
this.cb_recopy=create cb_recopy
this.st_recopy2=create st_recopy2
this.sle_recopyendshipmentnum=create sle_recopyendshipmentnum
this.sle_recopystartshipmentnum=create sle_recopystartshipmentnum
this.st_recopy1=create st_recopy1
this.sle_imagingrootfolder=create sle_imagingrootfolder
this.st_imagingrootfolder=create st_imagingrootfolder
this.cb_delete=create cb_delete
this.ddlb_volume=create ddlb_volume
this.st_volume=create st_volume
this.st_deleteimages3=create st_deleteimages3
this.st_deleteimages2=create st_deleteimages2
this.st_deleteimages1=create st_deleteimages1
this.st_mb=create st_mb
this.sle_maxsizearchive=create sle_maxsizearchive
this.st_maxarchivemediasize=create st_maxarchivemediasize
this.cb_copy=create cb_copy
this.sle_endshipmentnum=create sle_endshipmentnum
this.st_to=create st_to
this.sle_startshipmentnum=create sle_startshipmentnum
this.st_shipmentnum=create st_shipmentnum
this.st_archiveimages2=create st_archiveimages2
this.st_archiveimages1=create st_archiveimages1
this.gb_archiveimages=create gb_archiveimages
this.gb_deleteimages=create gb_deleteimages
this.gb_recopy=create gb_recopy
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.ddlb_selectvol
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_recopy
this.Control[iCurrent+6]=this.st_recopy2
this.Control[iCurrent+7]=this.sle_recopyendshipmentnum
this.Control[iCurrent+8]=this.sle_recopystartshipmentnum
this.Control[iCurrent+9]=this.st_recopy1
this.Control[iCurrent+10]=this.sle_imagingrootfolder
this.Control[iCurrent+11]=this.st_imagingrootfolder
this.Control[iCurrent+12]=this.cb_delete
this.Control[iCurrent+13]=this.ddlb_volume
this.Control[iCurrent+14]=this.st_volume
this.Control[iCurrent+15]=this.st_deleteimages3
this.Control[iCurrent+16]=this.st_deleteimages2
this.Control[iCurrent+17]=this.st_deleteimages1
this.Control[iCurrent+18]=this.st_mb
this.Control[iCurrent+19]=this.sle_maxsizearchive
this.Control[iCurrent+20]=this.st_maxarchivemediasize
this.Control[iCurrent+21]=this.cb_copy
this.Control[iCurrent+22]=this.sle_endshipmentnum
this.Control[iCurrent+23]=this.st_to
this.Control[iCurrent+24]=this.sle_startshipmentnum
this.Control[iCurrent+25]=this.st_shipmentnum
this.Control[iCurrent+26]=this.st_archiveimages2
this.Control[iCurrent+27]=this.st_archiveimages1
this.Control[iCurrent+28]=this.gb_archiveimages
this.Control[iCurrent+29]=this.gb_deleteimages
this.Control[iCurrent+30]=this.gb_recopy
this.Control[iCurrent+31]=this.gb_3
end on

on u_tabpage_archive.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ddlb_selectvol)
destroy(this.st_1)
destroy(this.cb_recopy)
destroy(this.st_recopy2)
destroy(this.sle_recopyendshipmentnum)
destroy(this.sle_recopystartshipmentnum)
destroy(this.st_recopy1)
destroy(this.sle_imagingrootfolder)
destroy(this.st_imagingrootfolder)
destroy(this.cb_delete)
destroy(this.ddlb_volume)
destroy(this.st_volume)
destroy(this.st_deleteimages3)
destroy(this.st_deleteimages2)
destroy(this.st_deleteimages1)
destroy(this.st_mb)
destroy(this.sle_maxsizearchive)
destroy(this.st_maxarchivemediasize)
destroy(this.cb_copy)
destroy(this.sle_endshipmentnum)
destroy(this.st_to)
destroy(this.sle_startshipmentnum)
destroy(this.st_shipmentnum)
destroy(this.st_archiveimages2)
destroy(this.st_archiveimages1)
destroy(this.gb_archiveimages)
destroy(this.gb_deleteimages)
destroy(this.gb_recopy)
destroy(this.gb_3)
end on

event constructor;call super::constructor;Long ll_MaxShipmentId
Long ll_MaxArchiveSize

ll_MaxShipmentId = THIS.Event ue_getMaxShipmentId ( )
sle_startshipmentnum.Text = String(ll_MaxShipmentId)

ll_MaxArchiveSize = This.Event ue_GetMaxArchiveSize ( )
sle_maxsizearchive.Text = String(ll_MaxArchiveSize)

end event

type st_3 from statictext within u_tabpage_archive
boolean visible = false
integer x = 1394
integer y = 540
integer width = 530
integer height = 92
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please Wait......"
boolean focusrectangle = false
end type

type st_2 from statictext within u_tabpage_archive
boolean visible = false
integer x = 1394
integer y = 364
integer width = 530
integer height = 92
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please Wait......"
boolean focusrectangle = false
end type

type ddlb_selectvol from dropdownlistbox within u_tabpage_archive
integer x = 969
integer y = 540
integer width = 379
integer height = 312
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;DataStore lds_ImageArchive

IF NOT IsValid(lds_ImageArchive) THEN
	lds_ImageArchive = CREATE DATASTORE
	lds_ImageArchive.DataObject = 'd_imagingsettingsmanagerhistory'
END IF
Parent.of_populaterecopyshipmentids(lds_ImageArchive)

DESTROY lds_ImageArchive



end event

type st_1 from statictext within u_tabpage_archive
integer x = 626
integer y = 552
integer width = 311
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Select Volume"
boolean focusrectangle = false
end type

type cb_recopy from commandbutton within u_tabpage_archive
integer x = 1467
integer y = 692
integer width = 265
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Recopy"
end type

event clicked;Long ll_StartShipmentId
Long ll_EndShipmentId
Long ll_MaxArchiveSize
Long ll_VolumeNumber

ll_StartShipmentId = Long(sle_recopystartshipmentnum.Text)
ll_EndShipmentId	 = Long(sle_recopyendshipmentnum.Text)	
ll_MaxArchiveSize	 = Long(sle_maxsizearchive.Text)	
ll_VolumeNumber	 = Long(ddlb_selectvol.Text)

Parent.Event ue_recopyimages(ll_StartShipmentId,ll_EndShipmentId,ll_MaxArchiveSize,ll_VolumeNumber)
end event

type st_recopy2 from statictext within u_tabpage_archive
integer x = 891
integer y = 708
integer width = 46
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "to"
boolean focusrectangle = false
end type

type sle_recopyendshipmentnum from singlelineedit within u_tabpage_archive
integer x = 969
integer y = 692
integer width = 379
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_recopystartshipmentnum from singlelineedit within u_tabpage_archive
integer x = 480
integer y = 692
integer width = 379
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_recopy1 from statictext within u_tabpage_archive
integer x = 219
integer y = 708
integer width = 265
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Shipment #"
boolean focusrectangle = false
end type

type sle_imagingrootfolder from singlelineedit within u_tabpage_archive
integer x = 1074
integer y = 1336
integer width = 361
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean border = false
end type

type st_imagingrootfolder from statictext within u_tabpage_archive
integer x = 594
integer y = 1336
integer width = 471
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Imaging Root Folder :"
boolean focusrectangle = false
end type

type cb_delete from commandbutton within u_tabpage_archive
integer x = 1467
integer y = 1164
integer width = 265
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Delete"
end type

event clicked;Long ll_VolumeNumber

ll_VolumeNumber = Long(ddlb_volume.Text)
SetPointer(HourGlass!)

Parent.event ue_deleteimages(ll_VolumeNumber)

end event

type ddlb_volume from dropdownlistbox within u_tabpage_archive
integer x = 448
integer y = 1164
integer width = 411
integer height = 312
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_volume from statictext within u_tabpage_archive
integer x = 256
integer y = 1172
integer width = 174
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Volume"
boolean focusrectangle = false
end type

type st_deleteimages3 from statictext within u_tabpage_archive
integer x = 219
integer y = 1068
integer width = 1413
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "from the Archive Folder"
boolean focusrectangle = false
end type

type st_deleteimages2 from statictext within u_tabpage_archive
integer x = 219
integer y = 1000
integer width = 1413
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "from the Imaging Root Folder. These images will only be available"
boolean focusrectangle = false
end type

type st_deleteimages1 from statictext within u_tabpage_archive
integer x = 219
integer y = 932
integer width = 1531
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Delete all images for the selected volume. This will delete all images"
boolean focusrectangle = false
end type

type st_mb from statictext within u_tabpage_archive
integer x = 1253
integer y = 372
integer width = 105
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "(MB)"
boolean focusrectangle = false
end type

type sle_maxsizearchive from singlelineedit within u_tabpage_archive
integer x = 969
integer y = 356
integer width = 274
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_maxarchivemediasize from statictext within u_tabpage_archive
integer x = 219
integer y = 372
integer width = 690
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Maximum size of archive media"
boolean focusrectangle = false
end type

type cb_copy from commandbutton within u_tabpage_archive
integer x = 1467
integer y = 252
integer width = 265
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Copy"
boolean default = true
end type

event clicked;Long ll_StartShipmentId
Long ll_EndShipmentId
Long ll_MaxArchiveSize

ll_StartShipmentId = Long(sle_startshipmentnum.Text)
ll_EndShipmentId	 = Long(sle_endshipmentnum.Text)	
ll_MaxArchiveSize	 = Long(sle_maxsizearchive.Text)	

Parent.Event ue_copyimages(ll_StartShipmentId,ll_EndShipmentId,ll_MaxArchiveSize)


end event

type sle_endshipmentnum from singlelineedit within u_tabpage_archive
integer x = 969
integer y = 256
integer width = 379
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

type st_to from statictext within u_tabpage_archive
integer x = 891
integer y = 268
integer width = 46
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "to"
boolean focusrectangle = false
end type

type sle_startshipmentnum from singlelineedit within u_tabpage_archive
integer x = 480
integer y = 256
integer width = 379
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_shipmentnum from statictext within u_tabpage_archive
integer x = 219
integer y = 268
integer width = 283
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Shipment #"
boolean focusrectangle = false
end type

type st_archiveimages2 from statictext within u_tabpage_archive
integer x = 219
integer y = 176
integer width = 690
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "designated on the settings tab."
boolean focusrectangle = false
end type

type st_archiveimages1 from statictext within u_tabpage_archive
integer x = 219
integer y = 108
integer width = 1531
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Copy all images for the shipment range to the Temporary Target Folder"
boolean focusrectangle = false
end type

type gb_archiveimages from groupbox within u_tabpage_archive
integer x = 37
integer y = 48
integer width = 1902
integer height = 416
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Archive Images"
end type

type gb_deleteimages from groupbox within u_tabpage_archive
integer x = 37
integer y = 844
integer width = 1902
integer height = 440
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Delete Images"
end type

type gb_recopy from groupbox within u_tabpage_archive
integer x = 37
integer y = 480
integer width = 1902
integer height = 348
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Recopy Images"
end type

type gb_3 from groupbox within u_tabpage_archive
integer x = 37
integer y = 928
integer width = 1902
integer height = 220
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Recopy Images"
end type

