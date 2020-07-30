$PBExportHeader$w_imagetypesetup.srw
forward
global type w_imagetypesetup from w_response
end type
type dw_1 from u_dw_imagetypelist within w_imagetypesetup
end type
type cb_1 from u_cbok within w_imagetypesetup
end type
type cb_2 from u_cbcancel within w_imagetypesetup
end type
end forward

global type w_imagetypesetup from w_response
integer x = 965
integer y = 592
integer width = 1806
integer height = 1160
string title = "Image Type Setup"
long backcolor = 12632256
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_imagetypesetup w_imagetypesetup

on w_imagetypesetup.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_imagetypesetup.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event pfc_default;Close ( THIS )
end event

event pfc_cancel;call super::pfc_cancel;ib_disableclosequery = TRUE
CLOSE ( THIS )
end event

event pfc_preupdate;call super::pfc_preupdate;String	ls_Error
int	li_Return 

li_Return = AncestorReturnValue
IF li_Return <> -1  THEN

	IF dw_1.of_Validatetypes( ls_Error ) = -1 THEN
		
		MessageBox ("Imagetypes" ,ls_Error )
		li_Return = -1  // prevent
		
	END IF
END IF

RETURN li_Return
end event

type cb_help from w_response`cb_help within w_imagetypesetup
end type

type dw_1 from u_dw_imagetypelist within w_imagetypesetup
integer x = 69
integer y = 48
integer height = 860
integer taborder = 10
end type

event constructor;call super::constructor;n_cst_bcm	lnv_bcm


gnv_app.inv_cacheManager.of_GetCache ( "n_cst_dlkc_imagetype" , lnv_Bcm , TRUE , TRUE )

dw_1.inv_UILink.setBcm ( lnv_Bcm )

n_cst_Presentation_image  lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )


n_cst_privileges lnv_Privs

if Not lnv_Privs.of_hasAdministrativeRights ( ) THEN
	THIS.Object.Imagetype_Type.protect = 1	
	THIS.Object.Imagetype_Category.Protect = 1
	THIS.Object.Imagetype_Topic.Protect = 1
END IF

end event

event pfc_predeleterow;call super::pfc_predeleterow;IF messageBox ( "Row Delete" , "By Deleting an image type you will no longer be able to reference images with this image type. Do you wish to delete this row anyway?" ,  EXCLAMATION!, YESNO! , 2 ) = 1 THEN 
	
	RETURN 1
ELSE 
	RETURN 0 
END IF
end event

type cb_1 from u_cbok within w_imagetypesetup
integer x = 571
integer y = 944
integer width = 233
integer taborder = 20
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_imagetypesetup
integer x = 905
integer y = 944
integer width = 233
integer taborder = 30
boolean bringtotop = true
end type

