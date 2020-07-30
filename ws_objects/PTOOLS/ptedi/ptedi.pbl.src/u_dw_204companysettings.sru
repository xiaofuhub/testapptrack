$PBExportHeader$u_dw_204companysettings.sru
forward
global type u_dw_204companysettings from u_dw
end type
end forward

global type u_dw_204companysettings from u_dw
integer width = 2542
integer height = 1048
string dataobject = "d_204companysettings"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
event type long ue_getcompanyid ( )
event ue_versionchanged ( string as_newversion )
end type
global u_dw_204companysettings u_dw_204companysettings

forward prototypes
private function integer of_browsetomappingfolder ()
public function integer of_formatdisplay ()
end prototypes

event ue_versionchanged(string as_newversion);CHOOSE CASE as_newversion
		
	CASE "1.0 (pseudo)"
		THIS.Modify ( "edi204profile_itemmatchingsegment.protect = 1" )
		THIS.Modify ( "edi204profile_itemmatchingelement.protect = 1" )
		THIS.Modify ( "allowcancel.Visible = 0" )
		THIS.Modify ( "allowupdates.Visible = 1" )
		THIS.Modify ( "emailerrors.protect = 1" )
		THIS.Modify ( "emailaddress.protect = 1" )
		
		
	 	THIS.object.edi204profile_itemmatchingsegment.background.color = 12632256
		THIS.object.edi204profile_itemmatchingelement.background.color = 12632256
		
		THIS.object.edi204profile_processedfiles.background.color = 16777215
		THIS.object.edi204profile_pendingfiles.background.color = 16777215
		
		THIS.Modify ( "cb_browseprocessed.enabled=yes" )
		THIS.Modify ( "cb_browsepending.enabled=yes" )
		
	CASE "2.0 (VAN mapping)"
		THIS.Modify ( "edi204profile_itemmatchingsegment.protect = 1" )
		THIS.Modify ( "edi204profile_itemmatchingelement.protect = 1" )
		THIS.Modify ( "allowcancel.Visible = 1" )
		THIS.Modify ( "allowupdates.Visible = 1" )
		THIS.Modify ( "emailerrors.protect = 1" )
		THIS.Modify ( "emailaddress.protect = 1" )
		
		
		THIS.object.edi204profile_itemmatchingsegment.background.color = 12632256
		THIS.object.edi204profile_itemmatchingelement.background.color = 12632256
		
		THIS.object.edi204profile_processedfiles.background.color = 16777215
		THIS.object.edi204profile_pendingfiles.background.color = 16777215

		THIS.Modify ( "cb_browseprocessed.enabled=yes" )
		THIS.Modify ( "cb_browsepending.enabled=yes" )
		
	CASE "3.0 (Direct auto accept)"
		
		THIS.Modify ( "edi204profile_itemmatchingsegment.protect = 0" )
		THIS.Modify ( "edi204profile_itemmatchingelement.protect = 0" )
		THIS.Modify ( "allowcancel.Visible = 1" )
		THIS.Modify ( "allowupdates.Visible = 1" )
		THIS.Modify ( "emailerrors.protect= 0" )
		THIS.Modify ( "emailaddress.protect = 0" )
		
		THIS.object.edi204profile_itemmatchingsegment.background.color = 16777215
		THIS.object.edi204profile_itemmatchingelement.background.color = 16777215
		
		THIS.object.edi204profile_processedfiles.background.color = 16777215
		THIS.object.edi204profile_pendingfiles.background.color = 16777215
		
		THIS.Modify ( "cb_browseprocessed.enabled=yes" )
		THIS.Modify ( "cb_browsepending.enabled=yes" )

	CASE "4.0 (Direct)"
		
		THIS.Modify ( "edi204profile_itemmatchingsegment.protect = 0" )
		THIS.Modify ( "edi204profile_itemmatchingelement.protect = 0" )
		THIS.Modify ( "allowcancel.Visible = 1" )
		THIS.Modify ( "allowupdates.Visible = 1" )
		THIS.Modify ( "emailerrors.protect = 0" )
		THIS.Modify ( "emailaddress.protect = 0" )
		
		THIS.object.edi204profile_itemmatchingsegment.background.color = 16777215
		THIS.object.edi204profile_itemmatchingelement.background.color = 16777215	
		
		THIS.object.edi204profile_processedfiles.background.color = 16777215
		THIS.object.edi204profile_pendingfiles.background.color = 16777215
		
		THIS.Modify ( "cb_browseprocessed.enabled=yes" )
		THIS.Modify ( "cb_browsepending.enabled=yes" )
	
		
	CASE ELSE // none
		
		THIS.Modify ( "edi204profile_pendingfiles.protect = 1" )
		THIS.Modify ( "edi204profile_processedfiles.protect = 1" )
		THIS.Modify ( "edi204profile_itemmatchingsegment.protect = 1" )
		THIS.Modify ( "edi204profile_itemmatchingelement.protect = 1" )
		THIS.Modify ( "allowcancel.Visible = 0" )
		THIS.Modify ( "allowupdates.Visible = 0" )
		THIS.Modify ( "emailerrors.protect = 1" )
		THIS.Modify ( "emailaddress.protect = 1" )
		
		
		THIS.object.edi204profile_processedfiles.background.color = 12632256
		THIS.object.edi204profile_pendingfiles.background.color = 12632256
		
		THIS.object.edi204profile_itemmatchingsegment.background.color = 12632256
		THIS.object.edi204profile_itemmatchingelement.background.color = 12632256

		THIS.Modify ( "cb_browseprocessed.enabled=no" )
		THIS.Modify ( "cb_browsepending.enabled=no" )
		
		
	
END CHOOSE 
end event

private function integer of_browsetomappingfolder ();String	ls_Title
String	ls_Directory


IF GetFolder ( ls_Title, ls_Directory ) = 1 THEN
	THIS.SetItem ( 1 , "mappingfolder" , ls_Directory )
END IF


RETURN 1
end function

public function integer of_formatdisplay ();N_cst_licensemanager lnv_licensemanager  //added by dan
IF THIS.getrow ( ) > 0 THEN
	THIS.event ue_versionchanged( THIS.GetItemString ( 1 , "edi204profile_ediversion" ) )
END IF 

//added by dan to hide the column if they don't have the license
//IF  NOT lnv_licensemanager.of_hasautoratinglicensed( ) THEN
//    	this.Object.edi204profile_autorate.visible = false
//END IF


return 1
end function

on u_dw_204companysettings.create
end on

on u_dw_204companysettings.destroy
end on

event buttonclicked;call super::buttonclicked;
String	ls_Folder
CHOOSE CASE Lower ( dwo.name )
		
	CASE "cb_browsepending"
	
		IF GetFolder("Select a Folder", ls_Folder ) > 0 THEN
			if row > 0 then
				this.object.edi204profile_pendingfiles[row] = ls_Folder
			end if
		END IF	
	
	
	CASE "cb_browseprocessed"
		IF GetFolder("Select a Folder", ls_Folder ) > 0 THEN
			if row > 0 then
				this.object.edi204profile_processedfiles[row] = ls_Folder
			end if
		END IF
		
		
	CASE ELSE
		
END CHOOSE

end event

event constructor;call super::constructor;Long	ll_CompanyID
Long	ll_RetrieveCount
ib_rmbmenu = FALSE

THIS.SetTransObject ( SQLCA ) 

ll_CompanyID = THIS.event ue_GetCompanyID( )

IF ll_CompanyID > 0 THEN
	ll_RetrieveCount = THIS.Retrieve ( ll_CompanyID )
	
	IF ll_RetrieveCount = 0 THEN
		ll_RetrieveCount = THIS.insertRow ( 0 ) 
		THIS.SetItem ( ll_RetrieveCount , "edi204profile_companyid" , ll_CompanyID )
	END IF
	
END IF


end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	case "edi204profile_ediversion"
		this.event ue_versionchanged( data )
END CHOOSE

RETURN AncestorReturnValue
		
end event

