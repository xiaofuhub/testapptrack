$PBExportHeader$w_zonemanager.srw
forward
global type w_zonemanager from w_sheet
end type
type uo_zones from u_zone_maintenance within w_zonemanager
end type
type cb_1 from commandbutton within w_zonemanager
end type
end forward

global type w_zonemanager from w_sheet
integer x = 5
integer y = 48
integer width = 2789
integer height = 2132
string title = "Zones and Locations"
string menuname = "m_sheets"
long backcolor = 12632256
event ue_refreshcache ( )
uo_zones uo_zones
cb_1 cb_1
end type
global w_zonemanager w_zonemanager

type variables
boolean	ib_cancel
end variables

event ue_refreshcache;//refresh cache
n_cst_bso_rating	lnv_Rating
lnv_Rating = create n_cst_bso_rating
setpointer(hourglass!)
lnv_rating.of_ResetZoneCache()
lnv_Rating.of_ResetRateCache()
destroy lnv_Rating


end event

on w_zonemanager.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.uo_zones=create uo_zones
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_zones
this.Control[iCurrent+2]=this.cb_1
end on

on w_zonemanager.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_zones)
destroy(this.cb_1)
end on

event open;call super::open;uo_zones.of_retrieveZones()
PowerObject lpoa_UpdateControls[ ]

lpoa_UpdateControls [ 1] = uo_zones.dw_zonelocation
lpoa_UpdateControls [ 2] = uo_zones.dw_Zone
of_SetUpdateObjects ( lpoa_UpdateControls )

THIS.Width = 2789
THIS.Height = 2124


gf_Mask_Menu ( m_Sheets )

uo_zones.dw_1.object.zone[1] = uo_zones.of_getzone()
uo_zones.dw_1.setfocus()

end event

event closequery;// override with call to super.
uo_zones.dw_zone.Event ue_ClearBlankRows ( )
uo_zones.dw_zonelocation.Event ue_ClearBlankRows ( )

IF uo_zones.of_AllowClose ( ) <> 1 AND Not ib_Cancel THEN
//	MessageBox ( "Zones Names are required" , "Please enter a name for every zone or delete the zones that you no longer want to use." )
//	Return 1
	
	CHOOSE CASE MessageBox ( "Zone Names are required" , "There are zones without names specifed. These modifications cannot be saved. Do you want to close the window and discard all unsaved modifications?" , Question! , YESNO!, 2 )
		CASE 1
			RETURN 0
		CASE 2
			RETURN 1
	END CHOOSE
	
	
ELSE
	RETURN Super::Event CloseQuery ( )
END IF
end event

event pfc_save;setpointer(hourglass!)
long	ll_return = 1





IF uo_zones.of_AllowClose ( ) <> 1 THEN
	MessageBox ( "Zones Names are required" , "Please enter a name for every zone or delete the zones that you no longer want to use." )
	Return -1
ELSEIF uo_zones.of_getmodifiedcount() > 0 then
	uo_zones.dw_zone.Event ue_ClearBlankRows ( )
	uo_zones.dw_zonelocation.Event ue_ClearBlankRows ( )
	
	ll_return = Super::Event pfc_save()
	if ll_return > 0 then
		commit;
		n_cst_bso_zonemanager	lnv_zonemanager
		lnv_zonemanager = create n_cst_bso_zonemanager
		lnv_zonemanager.of_resetcache()
		destroy lnv_zonemanager
	end if
	
end if

return ll_return
end event

event pfc_postupdate;setpointer(hourglass!)
long	ll_return = 1
n_ds	lds_rate

lds_rate = uo_zones.of_getratecache()

if isvalid(lds_rate) then
	if lds_rate.update() = 1 then
		//success
	else
		ll_return = -1
	end if
end if

if ll_return = 1 then
	ll_return = Super::Event pfc_postupdate(apo_control)
	if ll_return = 1 then
		commit;
		if isvalid(lds_rate) then
			lds_rate.reset()
		end if
		this.event post ue_refreshcache()
	end if
else
	rollback;
end if

return ll_return
end event

type uo_zones from u_zone_maintenance within w_zonemanager
event destroy ( )
integer width = 2734
integer taborder = 10
boolean bringtotop = true
end type

on uo_zones.destroy
call u_zone_maintenance::destroy
end on

event ue_savechanges;/*
	return   1  - success
			   0  - don't save
			  -2  - cancel save
			  -1  - error saving
*/

integer	li_return = 1, &
			li_ret
string	ls_message

ls_message = 'Changes have been made to the ' + as_zone + &
				" zone table. Do you wish to save the changes?"

if ab_message then
	if this.of_getmodifiedcount() > 0 then
	
		choose case messagebox("Save Changes", ls_message, information!, yesnocancel!, 3)
			case 1
				li_return = 1
			case 2
				li_return  = 0
			case else
				li_return = -2
				
		end choose
	
	end if
end if

if li_return = 1 then
	li_ret = parent.event pfc_save()
	if li_ret = 1 then
		li_return = 1 
	else
		li_return = -1
	end if 
end if

return li_return 





//return parent.event pfc_save()
end event

type cb_1 from commandbutton within w_zonemanager
integer x = 2446
integer y = 1808
integer width = 261
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Save"
end type

event clicked;Parent.Event pfc_Save ( )
end event

