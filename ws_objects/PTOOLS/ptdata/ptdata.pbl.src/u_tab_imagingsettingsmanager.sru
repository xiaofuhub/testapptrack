$PBExportHeader$u_tab_imagingsettingsmanager.sru
forward
global type u_tab_imagingsettingsmanager from u_tab
end type
type tabpage_archive from u_tabpage_archive within u_tab_imagingsettingsmanager
end type
type tabpage_archive from u_tabpage_archive within u_tab_imagingsettingsmanager
end type
type tabpage_settings from u_tabpage_settings within u_tab_imagingsettingsmanager
end type
type tabpage_settings from u_tabpage_settings within u_tab_imagingsettingsmanager
end type
type tabpage_history from u_tabpage_history within u_tab_imagingsettingsmanager
end type
type tabpage_history from u_tabpage_history within u_tab_imagingsettingsmanager
end type
end forward

global type u_tab_imagingsettingsmanager from u_tab
integer width = 2066
integer height = 1740
tabpage_archive tabpage_archive
tabpage_settings tabpage_settings
tabpage_history tabpage_history
event ue_copyimages ( long al_startshipmentid,  long al_endshipmentid,  long al_maxarchivesize )
event ue_selectvolume ( long al_volumenumberid )
event type long ue_getmaxshipmentid ( )
event type long ue_getmaxarchivesize ( )
event type integer ue_refreshhistorytab ( )
event ue_recopyimages ( long al_startshipmentid,  long al_endshipmentid,  long al_maxarchivesize,  long al_volnum )
event ue_deleteimages ( long al_volumenumber )
event ue_getarchivefolder ( string as_archivefolder )
event ue_populatetab ( )
end type
global u_tab_imagingsettingsmanager u_tab_imagingsettingsmanager

forward prototypes
public function integer of_getimagingrootfolder (string as_imagingrootfolder)
public function integer of_refreshhistorytab ()
public function integer of_populatevolumenumbers (long ala_volumenum[])
public function integer of_populaterecopyvolume (long ala_recopyvolume[])
public function integer of_populaterecopyshipmentids (datastore ads_imagearchive)
public function integer of_archivetabpgvalidations (string as_errormessage, integer ai_returnvalue)
public function integer of_setendshipmentid (long al_endshipmentid)
public function integer of_setstartshipmentid (long al_startshipmentid)
public function integer of_setarchivefolder (string as_archivefolder)
public subroutine of_getarchivefolder (ref string as_archivefoldername)
public subroutine of_gettargetfolder (ref string as_targetfolder)
public subroutine of_getmaxarchivesettings (ref string as_maxarchivesettings)
public subroutine of_disablerecopyvolume ()
public subroutine of_enadisrecopyvolume (integer ai_flag)
public subroutine of_enadisvolume (integer ai_flag)
public subroutine of_resetvolume ()
public subroutine of_resetrecopyvolume ()
public function integer of_updatehistorytab ()
public function integer of_setmaxarchivesizeonupdate (long al_maxarchivesize)
public function boolean of_gettemporarytargetfolder (string as_targetfolder)
public subroutine of_makewaitmsgvisible ()
public subroutine of_makewaitmsginvisible ()
public subroutine of_makewaitrecopymsginvisible ()
public subroutine of_makewaitrecopymsgvisible ()
public subroutine of_setcursoronendshipmentid ()
end prototypes

public function integer of_getimagingrootfolder (string as_imagingrootfolder);RETURN tabpage_archive.of_GetImagingRootFolder(as_imagingrootfolder)


end function

public function integer of_refreshhistorytab ();Return tabpage_history.Event ue_refreshhistorytab( )
end function

public function integer of_populatevolumenumbers (long ala_volumenum[]);Return tabpage_archive.of_populatevolumenumbers(ala_volumenum[])





end function

public function integer of_populaterecopyvolume (long ala_recopyvolume[]);Return tabpage_archive.of_populaterecopyvolume(ala_recopyvolume[])
end function

public function integer of_populaterecopyshipmentids (datastore ads_imagearchive);Return tabpage_archive.of_populaterecopyshipmentids(ads_imagearchive)
end function

public function integer of_archivetabpgvalidations (string as_errormessage, integer ai_returnvalue);Return tabpage_archive.of_archivetabpgvalidations ( as_errormessage,ai_ReturnValue )


end function

public function integer of_setendshipmentid (long al_endshipmentid);Return tabpage_archive.of_setendshipmentid(al_endshipmentid)


end function

public function integer of_setstartshipmentid (long al_startshipmentid);Return tabpage_archive.of_SetStartShipmentId(al_startshipmentid)

end function

public function integer of_setarchivefolder (string as_archivefolder);Return tabpage_settings.of_Setarchivefolder(as_archivefolder)


end function

public subroutine of_getarchivefolder (ref string as_archivefoldername);tabpage_settings.of_getarchivefolder(as_ArchiveFoldername)


end subroutine

public subroutine of_gettargetfolder (ref string as_targetfolder);tabpage_settings.of_GetTargetFolder(as_targetfolder)
end subroutine

public subroutine of_getmaxarchivesettings (ref string as_maxarchivesettings);tabpage_settings.of_getmaxarchivesettings(as_maxarchivesettings)
end subroutine

public subroutine of_disablerecopyvolume ();
end subroutine

public subroutine of_enadisrecopyvolume (integer ai_flag);tabpage_archive.of_enadisrecopyvolume(ai_flag)
end subroutine

public subroutine of_enadisvolume (integer ai_flag);tabpage_archive.of_EnaDisVolume(ai_flag)
end subroutine

public subroutine of_resetvolume ();tabpage_archive.of_ResetVolume()
end subroutine

public subroutine of_resetrecopyvolume ();tabpage_archive.of_Resetrecopyvolume( )
end subroutine

public function integer of_updatehistorytab ();Return tabpage_history.of_updatehistorytab( )
end function

public function integer of_setmaxarchivesizeonupdate (long al_maxarchivesize);Return Tabpage_archive.of_Setmaxarchivesizeonupdate( al_maxarchivesize)
end function

public function boolean of_gettemporarytargetfolder (string as_targetfolder);RETURN tabpage_settings.of_gettemporarytargetfolder(as_targetfolder)


end function

public subroutine of_makewaitmsgvisible ();tabpage_archive.of_Makewaitmsgvisible( )
end subroutine

public subroutine of_makewaitmsginvisible ();tabpage_archive.of_Makewaitmsginvisible( )
end subroutine

public subroutine of_makewaitrecopymsginvisible ();tabpage_archive.of_Makewaitrecopymsginvisible( )
end subroutine

public subroutine of_makewaitrecopymsgvisible ();tabpage_archive.of_Makewaitrecopymsgvisible( )
end subroutine

public subroutine of_setcursoronendshipmentid ();tabpage_archive.of_SetCursoronendshipmentid( )
end subroutine

on u_tab_imagingsettingsmanager.create
this.tabpage_archive=create tabpage_archive
this.tabpage_settings=create tabpage_settings
this.tabpage_history=create tabpage_history
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_archive
this.Control[iCurrent+2]=this.tabpage_settings
this.Control[iCurrent+3]=this.tabpage_history
end on

on u_tab_imagingsettingsmanager.destroy
call super::destroy
destroy(this.tabpage_archive)
destroy(this.tabpage_settings)
destroy(this.tabpage_history)
end on

event selectionchanged;call super::selectionchanged;CHOOSE CASE This.SelectedTab 
	CASE 1
		tabpage_archive.Setfocus( )
	CASE 2
		tabpage_settings.Setfocus( )
	CASE 3
		tabpage_history.Setfocus( )
END CHOOSE
end event

event selectionchanging;call super::selectionchanging;/*
//0  Allow the selection to change
//1  Prevent the selection from changing

Long	ll_Return

ll_Return = AncestorReturnValue

CHOOSE CASE oldindex
	CASE 1
		
	CASE 2
		IF NOT tabpage_settings.event ue_allowpagechange( ) THEN
			ll_Return = 1
			MessageBox('Image Archive Settings','All values are required to continue.')				
		END IF
		
	CASE 3
		

END CHOOSE

RETURN ll_Return
*/
end event

type tabpage_archive from u_tabpage_archive within u_tab_imagingsettingsmanager
integer x = 18
integer y = 100
integer width = 2030
integer height = 1624
string text = "Archive"
end type

event ue_copyimages;call super::ue_copyimages;Parent.Event ue_copyimages(al_startshipmentid,al_endshipmentid,al_maxarchivesize)
end event

event ue_getmaxshipmentid;call super::ue_getmaxshipmentid;RETURN Parent.Event ue_GetMaxShipmentId ( ) 
end event

event ue_getmaxarchivesize;call super::ue_getmaxarchivesize;Return Parent.Event ue_GetMaxArchiveSize ( ) 
end event

event ue_recopyimages;call super::ue_recopyimages;Parent.Event ue_recopyimages (al_startshipmentid,al_endshipmentid,al_maxarchivesize,al_volnum)
end event

event ue_deleteimages;call super::ue_deleteimages;Parent.Event ue_DeleteImages(al_volumenumber)
end event

type tabpage_settings from u_tabpage_settings within u_tab_imagingsettingsmanager
integer x = 18
integer y = 100
integer width = 2030
integer height = 1624
string text = "Settings"
end type

event ue_getmaxarchivesize;call super::ue_getmaxarchivesize;Return Parent.Event ue_GetMaxArchiveSize ( )  
end event

event ue_getarchivefolder;call super::ue_getarchivefolder;Parent.Event ue_getarchivefolder(as_archivefolder)
end event

type tabpage_history from u_tabpage_history within u_tab_imagingsettingsmanager
integer x = 18
integer y = 100
integer width = 2030
integer height = 1624
string text = "History"
end type

