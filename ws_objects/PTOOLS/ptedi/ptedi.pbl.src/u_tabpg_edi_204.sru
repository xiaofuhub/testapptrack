$PBExportHeader$u_tabpg_edi_204.sru
forward
global type u_tabpg_edi_204 from u_tabpg_edi
end type
type dw_1 from u_dw_204companysettings within u_tabpg_edi_204
end type
end forward

global type u_tabpg_edi_204 from u_tabpg_edi
integer width = 2793
string text = "Inbound"
dw_1 dw_1
end type
global u_tabpg_edi_204 u_tabpg_edi_204

on u_tabpg_edi_204.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_edi_204.destroy
call super::destroy
destroy(this.dw_1)
end on

event constructor;call super::constructor;long	ll_coid, &
		ll_row

ll_coid = this.of_GetCompany()

if ll_coid > 0 then
	dw_profile.settransobject(sqlca)
	if dw_profile.retrieve(ll_coid, 204, "INBOUND") < 1 then
		ll_row = dw_profile.insertrow(0)
		if ll_row > 0 then
			dw_profile.object.companyid[ll_row] = ll_coid
			dw_profile.object.transactionset[ll_row] = 204
			dw_profile.object.in_out[ll_row] = "INBOUND"
		end if
	end if
	dw_1.post of_formatdisplay( )
end if

end event

type dw_profile from u_tabpg_edi`dw_profile within u_tabpg_edi_204
integer x = 27
integer width = 2459
integer height = 336
string dataobject = "d_ediprofile_204"
end type

type st_title from u_tabpg_edi`st_title within u_tabpg_edi_204
integer x = 1079
integer width = 489
string text = "204 - Load Tender"
end type

type dw_1 from u_dw_204companysettings within u_tabpg_edi_204
integer x = 18
integer y = 472
integer width = 2450
integer height = 992
integer taborder = 11
boolean bringtotop = true
end type

event ue_getcompanyid;call super::ue_getcompanyid;RETURN PARENT.of_Getcompany( )
end event

event ue_versionchanged;call super::ue_versionchanged;CHOOSE CASE as_newversion
		
	CASE "1.0 (pseudo)"
		dw_profile.Modify ( "folder.protect = 1" )
		dw_profile.object.folder.background.color = 12632256
		
		dw_profile.Modify ( "scac.protect = 0" )
		dw_profile.object.scac.background.color = 16777215
		
		dw_profile.Modify ( "FileFormat.protect = 1" )
		dw_profile.object.FileFormat.background.color = 12632256
		
		dw_profile.Modify ( "cb_browsefolder.enabled=no" )
		
	CASE "2.0 (VAN mapping)"
		dw_profile.Modify ( "folder.protect = 1" )
		dw_profile.object.folder.background.color = 12632256
		
		dw_profile.Modify ( "scac.protect = 0" )
		dw_profile.object.scac.background.color = 16777215
		
		dw_profile.Modify ( "FileFormat.protect = 1" )
		dw_profile.object.FileFormat.background.color = 12632256
		
		dw_profile.Modify ( "cb_browsefolder.enabled=no" )
		
	CASE "3.0 (Direct auto accept)"
		
		dw_profile.Modify ( "folder.protect = 0" )
		dw_profile.object.folder.background.color = 16777215
		
		dw_profile.Modify ( "scac.protect = 0" )
		dw_profile.object.scac.background.color = 16777215
		
		dw_profile.Modify ( "FileFormat.protect = 0" )
		dw_profile.object.FileFormat.background.color = 16777215
		
		dw_profile.Modify ( "cb_browsefolder.enabled=yes" )

	CASE "4.0 (Direct)"
		
		dw_profile.Modify ( "folder.protect = 0" )
		dw_profile.object.folder.background.color = 16777215
		
		dw_profile.Modify ( "scac.protect = 0" )
		dw_profile.object.scac.background.color = 16777215
		
		dw_profile.Modify ( "FileFormat.protect = 0" )
		dw_profile.object.FileFormat.background.color = 16777215
		
		dw_profile.Modify ( "cb_browsefolder.enabled=yes" )
	
		
	CASE ELSE // none
		
		dw_profile.Modify ( "folder.protect = 1" )
		dw_profile.object.folder.background.color = 12632256
		
		dw_profile.Modify ( "scac.protect = 1" )
		dw_profile.object.scac.background.color = 12632256
		
		dw_profile.Modify ( "FileFormat.protect = 1" )
		dw_profile.object.FileFormat.background.color = 12632256
		
		dw_profile.Modify ( "cb_browsefolder.enabled=no" )
				
	
END CHOOSE 
end event

