$PBExportHeader$w_ratetable.srw
forward
global type w_ratetable from w_sheet
end type
type uo_1 from u_ratetable within w_ratetable
end type
type cb_save from commandbutton within w_ratetable
end type
type cb_close from commandbutton within w_ratetable
end type
end forward

global type w_ratetable from w_sheet
integer x = 5
integer y = 176
integer width = 3611
integer height = 2032
string title = "RateTable"
string menuname = "m_sheets"
long backcolor = 12632256
uo_1 uo_1
cb_save cb_save
cb_close cb_close
end type
global w_ratetable w_ratetable

type variables
n_cst_Toolmenu_Manager  inv_ToolmenuManager
boolean	ib_New
datawindow	idw_RateTable
String	is_TableName
Long	il_Customer
Int	ii_Break
String	is_Origin
String	is_Destination

end variables

forward prototypes
public function integer wf_createtoolmenu ()
public function integer wf_process_request (string as_value)
public subroutine wf_updatecodedefaults (string as_original, string as_new)
end prototypes

public function integer wf_createtoolmenu ();s_toolmenu lstr_toolmenu
n_cst_setting_advancedprivs lnv_setting
n_cst_privsmanager lnv_privsManager
boolean 	lb_createSaveMenu

lnv_privsManager = gnv_app.of_getprivsmanager( ) //create n_cst_privsmanager
lnv_setting = create n_cst_setting_advancedprivs

if isvalid(inv_ToolmenuManager) then 
	//already created
else
	inv_ToolmenuManager = create n_cst_toolmenu_manager
	inv_ToolmenuManager.of_set_parent(this)
	
	inv_ToolmenuManager.of_add_standard("DIVIDER!")
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
	
	//--Added by Dan to prevent save without permission
	IF lnv_setting.of_getValue() = "Yes" THEN
		lnv_privsManager = gnv_app.of_getprivsmanager( ) //create n_cst_privsManager
		
		//currently logged in user
		IF	lnv_privsManager.of_getuserpermissionFROMFn( lnv_privsManager.cs_modifyRateTable ) = 1 THEN
			lb_createSaveMenu = true
		ELSE
			//insufficient rights to save, do not create the menu item
		END IF
	
	ELSE
		lb_createSaveMenu = true
	END IF
	
	IF lb_createSaveMenu THEN
		lstr_toolmenu.s_name = "SAVE!"
		lstr_toolmenu.s_menuitem_text = "&Save~tCtrl+S"
		inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	END IF
	/////////////////////////////////////////////////////////
	lstr_toolmenu.s_name = "ZONES!"
	lstr_toolmenu.s_menuitem_text = "&Zones"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)
end if


DESTROY lnv_setting
RETURN 1
end function

public function integer wf_process_request (string as_value);SetPointer(HourGlass!)

CHOOSE CASE as_value
	case "SAVE!"
		this.event pfc_save()	
	CASE "ZONES!"
		Open ( w_ZoneManager )
		
END CHOOSE

RETURN 1
end function

public subroutine wf_updatecodedefaults (string as_original, string as_new);string	ls_list, &
			lsa_list[], &
			lsa_blank[]
long		ll_rowcount, &
			ll_row, &
			ll_listcount, &
			ll_list
boolean	lb_listchanged

n_ds				lds_settings
n_cst_settings	lnv_settings
n_cst_string	lnv_string

if as_original = as_new then
	//nothing to do
else
	ll_rowcount = lnv_settings.of_Getcodedefaultsetting ( lds_settings )
	
	for ll_row = 1 to ll_rowcount
		ls_list = ''
		ls_list = lds_settings.object.ss_String[ll_row]
		lsa_list = lsa_blank
		if lnv_string.of_ParseToArray(ls_list, ',', lsa_list ) > 0 then
			ll_listcount = upperbound(lsa_list)
			lb_listchanged = false
			for ll_list = 1 to ll_listcount
				if lsa_list[ll_list] = as_original then
					lsa_list[ll_list] = as_new
					lb_listchanged = true
				end if
			next
			if lb_listchanged then
				//move array back to list format
				if upperbound(lsa_list) > 0 then
					lnv_string.of_arraytostring(lsa_list, ',' , ls_list)
				end if
				//update list
				lnv_settings.of_SetCodeDefaultSetting( lds_settings.object.ss_uid[ll_row], &
													 lds_settings.object.ss_id[ll_row], ls_list )
			end if
		end if
	next
		lnv_settings.of_SaveSetting()
//		< 0 then
//		messagebox('Save', 'Could not save')
//	else

end if
end subroutine

event open;call super::open;
String	ls_Select
Long		ll_NewRow 

n_cst_msg	lnv_msg
S_Parm	lstr_Parm
PowerObject lpoa_UpdateControls[ ]

n_cst_privsManager lnv_privsManager
//n_cst_setting_advancedPrivs lnv_setting
int li_return
//lnv_setting = create n_cst_setting_advancedPrivs

lpoa_UpdateControls [ 1 ] = uo_1.uo_tablenames.of_getcache()
lpoa_UpdateControls [ 2 ] = uo_1.uo_rateoptions.dw_ratedefaults
lpoa_UpdateControls [ 3 ] = uo_1.dw_table

//added by dan to let the user know they can't save
lnv_privsManager =  gnv_app.of_getprivsmanager( ) //te n_cst_privsManager
IF lnv_privsManager.of_useadvancedprivs( ) THEN
	
	
	//currently logged in user
	IF	lnv_privsManager.of_getuserpermissionFromFn( lnv_privsManager.cs_modifyRateTable ) = 1 THEN

	ELSE
		MessageBox( "Rate", "You do not have permission to modify this window.  Changes made will not be saved.", exclamation!)
		cb_save.enabled = false
	END IF
	
END IF
//--------------------------------
of_SetUpdateObjects ( lpoa_UpdateControls )

//gf_mask_menu ( m_sheets )
This.wf_CreateToolmenu ( )

THIS.width = 3611
THIS.Height = 2032

This.of_SetResize ( TRUE )
//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize ( 3611, 2032 )
//THIS.x = 0
//THIS.y = 0

//Register Resizable controls
inv_Resize.of_Register ( uo_1, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( cb_save, 'FixedToRight' )
inv_Resize.of_Register ( cb_close, 'FixedToRight' )



end event

on w_ratetable.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.uo_1=create uo_1
this.cb_save=create cb_save
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_close
end on

on w_ratetable.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.cb_save)
destroy(this.cb_close)
end on

event pfc_cancel;call super::pfc_cancel;ib_DisableCloseQuery = TRUE
CLOSE ( THIS )
end event

event pfc_save;setpointer(hourglass!)
this.setredraw(false)
long	ll_return = 1

ll_return = uo_1.dw_Table.Event ue_AllowChangeFocus ( )

if ll_return = 1 then
	ll_return = uo_1.uo_rateoptions.dw_ratedefaults.Event ue_AllowChangeFocus ( )
end if

IF ll_return = 1 THEN 
	
	uo_1.dw_Table.Event ue_ClearBlankRows ( )

	uo_1.uo_rateoptions.dw_ratedefaults.event ue_clearblankrow ()

	ll_return = Super::Event pfc_save()
	if ll_return > 0 then
		commit;
		n_cst_bso_rating	lnv_rating
		lnv_rating = create n_cst_bso_rating
		
		lnv_rating.of_resetcache()
		
		destroy lnv_rating
	else
		rollback;
	end if
	
	uo_1.dw_Table.Event ue_Filter ( )
	
END IF
this.setredraw(true)
return ll_return
end event

event close;call super::close;if isvalid(inv_ToolMenuManager) then
	destroy inv_ToolMenuManager
end if


end event

event closequery;//Modified by dan so that it doesn't ask to save if the user doesn't 
//have permissions to save.

long	ll_return
Boolean lb_canSave

n_cst_privsManager lnv_privsManager
//n_cst_setting_advancedPrivs lnv_setting
int li_return
//lnv_setting = create n_cst_setting_advancedPrivs

lnv_privsManager =  gnv_app.of_getprivsmanager( ) //create n_cst_privsManager
IF lnv_privsManager.of_useadvancedprivs( ) THEN
	
	//currently logged in user
	IF	lnv_privsManager.of_getuserpermissionFROMFn( lnv_privsManager.cs_modifyRateTable ) = 1 THEN
		lb_canSave = true
	ELSE
		//Messagebox("Save", "You do not have sufficient rights.")
		li_return = 0		//allow window to close
	END IF

ELSE
	lb_canSave = true

END IF

IF lb_canSave THEN
	uo_1.dw_Table.Event ue_ClearBlankRows ( )
	uo_1.uo_rateoptions.dw_ratedefaults.event ue_clearblankrow ()
	
	if uo_1.of_getmodifiedcount() > 0 then
		ll_return = Super::Event closequery()
	else
		ll_return = 0	//allow window to close
	end if
END IF


//DESTROY lnv_setting

RETURN li_return





//-old code
//uo_1.dw_Table.Event ue_ClearBlankRows ( )
//uo_1.uo_rateoptions.dw_ratedefaults.event ue_clearblankrow ()
//
//if uo_1.of_getmodifiedcount() > 0 then
//	ll_return = Super::Event closequery()
//else
//	ll_return = 0
//end if
//
//RETURN ll_return
//
end event

type uo_1 from u_ratetable within w_ratetable
integer y = 8
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call u_ratetable::destroy
end on

event ue_savechanges;integer	li_return = 0, &
			li_ret
string	ls_message, &
			ls_originalcodename
Dec	lc_rate
Long	ll_index
Long	ll_max
if len(trim(as_message)) > 0 then
	ls_message = as_message
else
	ls_message = 'Changes have been made to the ' + as_tablename + &
						" rate table. Do you wish to save the changes?"
end if

if this.of_deletetable() then
	//don't clear
	ls_message = '**** YOU ARE ABOUT TO DELETE THE ENTIRE RATE TABLE [' + as_tablename + '], ' +&
					 'INCLUDING ANY BILLTO OVERRIDES. ****' +&
					 '~n~n' +&
					 'IF YOU PROCEED, THIS IS NOT REVERSIBLE.' +&
					 '~n~n' +&
					 'OK TO PROCEED??'

else
	uo_1.dw_Table.Event ue_ClearBlankRows ( )
	uo_1.uo_rateoptions.dw_ratedefaults.event ue_allowchangefocus ()
	uo_1.uo_rateoptions.dw_ratedefaults.event ue_clearblankrow ()	
end if

if this.of_deletetable() then
	
	choose case messagebox("Deleting Table", ls_message, Exclamation!, okcancel!, 2)
		case 1
			li_return = 1
		case 2
			li_return  = 0
	end choose
	
else
	if uo_1.of_getmodifiedcount() > 0 then
	
		choose case messagebox("Save Changes", ls_message, Exclamation!, yesnocancel!, 3)
			case 1
				li_return = 1
			case 2
				if this.of_deletetable() then
					//don't flush
				else
					//flush table from cache
					this.of_flushcache(as_tablename)
				end if
				li_return  = 0
			case else
				if this.of_deletetable() then
					//don't add row
				else
					uo_1.dw_Table.Event pfc_addrow ( )
				end if
				li_return = -2
	
		end choose
	end if
end if

if li_return = 1 then
	
	li_ret = parent.event pfc_save()
	if li_ret = 1 then
		//Modified by Dan 1-13-2006 to remove empty rate rows when saving.
			ll_max = uo_1.dw_table.rowCount()
			For ll_index = ll_max TO 1  STEP -1
				lc_Rate = uo_1.dw_table.Object.rate [ll_index]
		
				IF isNULL( lc_rate ) THEN
						uo_1.dw_table.post rowsdiscard( ll_index, ll_index, PRIMARY!)
				END IF
			NEXT
		//----------------------------------------------------------------
		if uo_1.of_codenamechanged(ls_originalcodename) then
			//loop thru settings
			parent.wf_updatecodedefaults(ls_originalcodename, as_tablename)
		end if
		
		if this.of_deletetable() then
			parent.wf_updatecodedefaults(as_tablename, '')
		end if
		
		li_return = 1 
		uo_1.dw_Table.Event pfc_addrow ( )
	else
		li_return = -1
	end if
end if

this.of_setdelete(false)


return li_return 


		

end event

type cb_save from commandbutton within w_ratetable
integer x = 3022
integer y = 1756
integer width = 233
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sa&ve"
end type

event clicked;parent.event pfc_save()

end event

type cb_close from commandbutton within w_ratetable
integer x = 3301
integer y = 1756
integer width = 242
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;//CLOSE ( parent )
//modified by Dan
//IF parent.event closeQuery()  = 0 THEN
	CLOSE( parent )
//END IF

end event

