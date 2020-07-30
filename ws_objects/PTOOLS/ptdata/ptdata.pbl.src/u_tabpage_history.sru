$PBExportHeader$u_tabpage_history.sru
forward
global type u_tabpage_history from u_tabpage_imagearchive
end type
type dw_imagingsettingsmanagerhistory from u_dw within u_tabpage_history
end type
type st_notes from statictext within u_tabpage_history
end type
end forward

global type u_tabpage_history from u_tabpage_imagearchive
integer width = 2025
integer height = 1404
event type integer ue_refreshhistorytab ( )
event of_gethistorynotes ( ref string as_notes,  integer ai_rownum,  datastore ads_imagearchive )
dw_imagingsettingsmanagerhistory dw_imagingsettingsmanagerhistory
st_notes st_notes
end type
global u_tabpage_history u_tabpage_history

forward prototypes
public function integer of_populatehistorytab ()
public function integer setfocus ()
public function integer of_updatehistorytab ()
end prototypes

event type integer ue_refreshhistorytab();////////////////////////////////////////////////////////////////////
//
// Event			: ue_refreshhistorytab
// Arguments 	: None
// Returns 		: 1 = Success, -1= Failure
// Description : Invoked to call of_populatehistorytab method to 
// 				  history tab
// Author		: Zach
// Created on 	: 2003-10-15
// Modified by : Add Author here	TimeStamp
//				
////////////////////////////////////////////////////////////////////

Int li_ReturnValue = 1

li_ReturnValue = This.of_populatehistorytab ( )

IF li_ReturnValue <> 1 THEN
	li_ReturnValue = -1
END IF

Return li_ReturnValue
end event

public function integer of_populatehistorytab ();/////////////////////////////////////////////////////////////////////
//
// Function		: of_populatehistorytab
// Arguments	: None
// Returns 		: 1 - Success,  -1 Failure
// Description : This method is called to retrieve the history tab page 
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

Int li_ReturnValue = 1
Int li_RetrieveSuccess

dw_imagingsettingsmanagerhistory.SetTransObject(SQLCA)
li_RetrieveSuccess = dw_imagingsettingsmanagerhistory.Retrieve()

IF li_RetrieveSuccess < 0 THEN
	li_ReturnValue = -1
END IF	

Return li_ReturnValue

end function

public function integer setfocus ();Int li_ReturnValue = 1
dw_imagingsettingsmanagerhistory.Setfocus()
Return li_ReturnValue
end function

public function integer of_updatehistorytab ();/////////////////////////////////////////////////////////////////////
//
// Function		: of_updatehistorytab
// Arguments	: None
// Returns 		: 1 - Success,  -1 Failure
// Description : This method is called to update changes to 
// 				  the history tab page information	
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

Int li_ReturnValue = 1 

dw_ImagingSettingsManagerHistory.SetTransObject(SQLCA)

IF dw_ImagingSettingsManagerHistory.Update()  = 1 THEN
	Commit using SQLCA;
ELSE
	Rollback using SQLCA;
	MessageBox('Error updating','Failed to apply changes to Image archive table.')
	li_ReturnValue = - 1
END IF

RETURN li_ReturnValue
end function

on u_tabpage_history.create
int iCurrent
call super::create
this.dw_imagingsettingsmanagerhistory=create dw_imagingsettingsmanagerhistory
this.st_notes=create st_notes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imagingsettingsmanagerhistory
this.Control[iCurrent+2]=this.st_notes
end on

on u_tabpage_history.destroy
call super::destroy
destroy(this.dw_imagingsettingsmanagerhistory)
destroy(this.st_notes)
end on

event constructor;call super::constructor;This.Event ue_refreshHistoryTab ( )
end event

type dw_imagingsettingsmanagerhistory from u_dw within u_tabpage_history
integer x = 5
integer y = 4
integer width = 1975
integer height = 1392
integer taborder = 20
string dataobject = "d_imagingsettingsmanagerhistory"
boolean hscrollbar = true
end type

event constructor;call super::constructor;ib_rmbmenu = FALSE // Disables the right click menu option(s)
end event

type st_notes from statictext within u_tabpage_history
integer x = 82
integer y = 116
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

