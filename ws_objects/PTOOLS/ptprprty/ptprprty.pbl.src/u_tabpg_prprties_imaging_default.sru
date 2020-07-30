$PBExportHeader$u_tabpg_prprties_imaging_default.sru
forward
global type u_tabpg_prprties_imaging_default from u_tabpg_prprties_imaging
end type
type uo_zoomtofit from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_imaging_default
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_imaging_default
end type
end forward

global type u_tabpg_prprties_imaging_default from u_tabpg_prprties_imaging
integer width = 2011
integer height = 1280
string text = "Defaults"
uo_zoomtofit uo_zoomtofit
uo_1 uo_1
end type
global u_tabpg_prprties_imaging_default u_tabpg_prprties_imaging_default

on u_tabpg_prprties_imaging_default.create
int iCurrent
call super::create
this.uo_zoomtofit=create uo_zoomtofit
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_zoomtofit
this.Control[iCurrent+2]=this.uo_1
end on

on u_tabpg_prprties_imaging_default.destroy
call super::destroy
destroy(this.uo_zoomtofit)
destroy(this.uo_1)
end on

type uo_zoomtofit from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_imaging_default
integer x = 27
integer y = 192
integer height = 176
integer taborder = 20
end type

on uo_zoomtofit.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event constructor;call super::constructor;//this setting is only available if they have imaging version 7
n_cst_bso_imagemanager lnv_ImageManager
n_cst_imagingversioncontrol	lnv_ImageVersion

inv_syssetting = CREATE n_cst_setting_imagezoomtofit

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)


lnv_ImageManager	 = CREATE n_cst_bso_imagemanager


IF lnv_ImageManager.of_Getimagingversioncontrol( lnv_ImageVersion ) = 1 THEN
	CHOOSE CASE lnv_ImageVersion.ir_version
			
		CASE appeon_constant.cr_version_7
		
		CASE ELSE
			this.visible = false
	END CHOOSE	
END IF
DESTROY lnv_ImageManager
end event

event destructor;call super::destructor;destroy inv_syssetting
end event

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_imaging_default
integer x = 27
integer y = 48
integer width = 1861
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DispExtImagingErrMsg

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

