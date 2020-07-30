$PBExportHeader$w_equipmentleasetypes.srw
$PBExportComments$EquipmentLeaseTypes (Window from PBL map PTData) //@(*)[146492691|993]
forward
global type w_equipmentleasetypes from w_sheet
end type
type dw_equipmentleasetypelist from u_dw_equipmentleasetypelist within w_equipmentleasetypes
end type
type cb_navigations from u_cbnavigate within w_equipmentleasetypes
end type
type st_1 from statictext within w_equipmentleasetypes
end type
type sle_dateout from u_sle_date within w_equipmentleasetypes
end type
type sle_timeout from u_sle_time within w_equipmentleasetypes
end type
type sle_timein from u_sle_time within w_equipmentleasetypes
end type
type sle_datein from u_sle_date within w_equipmentleasetypes
end type
type cb_2 from u_cb within w_equipmentleasetypes
end type
type st_2 from statictext within w_equipmentleasetypes
end type
type gb_1 from groupbox within w_equipmentleasetypes
end type
type cb_save from u_cb_save within w_equipmentleasetypes
end type
type cb_new from u_cb within w_equipmentleasetypes
end type
type cbx_deactivated from u_cbx within w_equipmentleasetypes
end type
end forward

global type w_equipmentleasetypes from w_sheet
integer x = 14
integer y = 32
integer width = 3511
integer height = 2152
string title = "Equipment Lease Types"
string menuname = "m_sheets"
long backcolor = 80269524
dw_equipmentleasetypelist dw_equipmentleasetypelist
cb_navigations cb_navigations
st_1 st_1
sle_dateout sle_dateout
sle_timeout sle_timeout
sle_timein sle_timein
sle_datein sle_datein
cb_2 cb_2
st_2 st_2
gb_1 gb_1
cb_save cb_save
cb_new cb_new
cbx_deactivated cbx_deactivated
end type
global w_equipmentleasetypes w_equipmentleasetypes

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.

//@(text)--

Private n_cst_Toolmenu_Manager	inv_ToolmenuManager


//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function integer wf_createtoolmenu ()
public subroutine wf_process_request (string as_request)
public function integer wf_filterdeactivated ()
private function integer wf_updateftx ()
end prototypes

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null


Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>

Return 1
//@(text)--

end function

public function integer wf_createtoolmenu ();s_toolmenu lstr_toolmenu

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "SAVE!"
lstr_toolmenu.s_menuitem_text = "&Save~tCtrl+S"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "UPDATEFTX!"
lstr_toolmenu.s_menuitem_text = "Update FTX Calculations"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1
end function

public subroutine wf_process_request (string as_request);CHOOSE CASE as_Request

CASE "SAVE!"
	This.PostEvent ( "pfc_Save" )

CASE "UPDATEFTX!"
	THIS.wf_updateftx( )
	
END CHOOSE
end subroutine

public function integer wf_filterdeactivated ();//RDT 08/23/02 Filter out Status = Deactivated 
string ls_filter

If cbx_deactivated.checked = True Then
	ls_Filter = ''
else
	ls_Filter = "equipmentleasetype_leasestatus <> 0 or IsNull(equipmentleasetype_leasestatus)"
end if

dw_equipmentleasetypelist.SetFilter(ls_filter)
dw_equipmentleasetypelist.Filter( )
return 1
end function

private function integer wf_updateftx ();Long		ll_ModCount
Long		ll_RowCount
Long 		i
Int		li_Return 
Long		ll_Probs
Boolean	lb_Continue = TRUE
n_cst_beo_equipmentlease2	lnv_EqLease
n_cst_beo_Equipment2	lnv_Eq
n_Cst_Privileges	lnv_PrivsMan
DataStore	lds_Eq



IF NOT lnv_PrivsMan.of_HasSysAdminRights ( ) THEN
	MessageBox ( "Update FTX" , "You are not authorized to do this." )
	lb_Continue = FALSE
END IF


IF lb_Continue THEN
	IF dw_equipmentleasetypelist.Modifiedcount( ) > 0 THEN
		IF MessageBox ( "Update FTX" , "The new FTX will be calculated with the saved values. Your pending changes WILL NOT be used. Are you sure you want to continue?" , QUESTION!, YESNO! , 1 ) = 2 THEN
			lb_Continue = FALSE
		END IF
	END IF
END IF
			

IF lb_Continue THEN
	IF MessageBox ( "Update FTX" , "This process will recalclate the Free Time Expiration FOR ALL ACTIVE LEASED EQUIPMENT. Are you sure you want to do this?" , QUESTION! , YESNO! , 1 ) = 2 THEN
		lb_Continue = FALSE
	END IF
END IF	
	
	
IF lb_Continue THEN
	
	SetPointer ( Hourglass! ) 
	
	lds_Eq = CREATE DataStore
	lds_Eq.DataObject = "d_outsideequip_list"
	lds_Eq.SetTransObject ( SQLCA ) 

	lds_Eq.Retrieve ( )
	Commit;
	
	lds_Eq.SetFilter ( "eq_outside = 'T'" ) 
	lds_Eq.Filter ( )
	
	
	lnv_Eq = CREATE n_cst_beo_Equipment2
	lnv_Eq.of_SetSource ( lds_Eq )

	
	ll_RowCount = lds_Eq.RowCount ( )
	
	FOR i = 1 TO ll_RowCount 
		
		lnv_Eq.of_SetSourceROW ( i )
		lnv_Eq.of_getequipmentlease( lnv_EqLease )
		IF isValid ( lnv_EqLease ) THEN
			lnv_EqLease.of_Calculateftx( )
		ELSE
			//Error
			ll_Probs ++
			li_Return = -1
		END IF
		Destroy ( lnv_EqLease )
		
	NEXT
	
	IF ll_Probs >0 THEN 
		MessageBox ( "Attention" , String ( ll_Probs ) + "pieces of equipment could not have their ftx calculated." )
		
	END IF

	ll_ModCount = lds_Eq.Modifiedcount( )
	IF ll_ModCount > 0 THEN
		IF MessageBox ( "Update Equipment" , "Do you want to update " + String ( ll_ModCount )+ " Records? " , Question!, YesNo! , 1 ) = 1 THEN
			IF lds_Eq.update ( ) = 1 THEN
				Commit;
			Else
				RollBack;
				MessageBox ( "Update" , "An error occured, Transaction rolled back." )
			END IF
		END IF
	END IF
	
	DESTROY ( lnv_Eq ) 
	DESTROY ( lds_Eq ) 
END IF

RETURN 1
	
	
	
end function

on w_equipmentleasetypes.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_equipmentleasetypelist=create dw_equipmentleasetypelist
this.cb_navigations=create cb_navigations
this.st_1=create st_1
this.sle_dateout=create sle_dateout
this.sle_timeout=create sle_timeout
this.sle_timein=create sle_timein
this.sle_datein=create sle_datein
this.cb_2=create cb_2
this.st_2=create st_2
this.gb_1=create gb_1
this.cb_save=create cb_save
this.cb_new=create cb_new
this.cbx_deactivated=create cbx_deactivated
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_equipmentleasetypelist
this.Control[iCurrent+2]=this.cb_navigations
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_dateout
this.Control[iCurrent+5]=this.sle_timeout
this.Control[iCurrent+6]=this.sle_timein
this.Control[iCurrent+7]=this.sle_datein
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.cb_save
this.Control[iCurrent+12]=this.cb_new
this.Control[iCurrent+13]=this.cbx_deactivated
end on

on w_equipmentleasetypes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_equipmentleasetypelist)
destroy(this.cb_navigations)
destroy(this.st_1)
destroy(this.sle_dateout)
destroy(this.sle_timeout)
destroy(this.sle_timein)
destroy(this.sle_datein)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.cb_save)
destroy(this.cb_new)
destroy(this.cbx_deactivated)
end on

event open;call super::open;
gf_Mask_Menu ( m_Sheets )
wf_CreateToolmenu ( )


//@(data)(recreate=yes)<Parameters>
//@(data)--

//@(data)(recreate=yes)<Links>
Setlinkage(TRUE)
//@(data)--

//@(data)(recreate=yes)<GenerationOptions>
of_SetResize(TRUE)
SetTransactionManagement(TRUE)
inv_txsrv.SetLoadUpdateList(TRUE)
//@(data)--

//@(text)(recreate=yes)<RetrieveNoArgs>

//@(text)--

inv_Linkage.Retrieve ( dw_EquipmentLeaseTypeList )


//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )


//@(text)(recreate=yes)<resizevalues>

inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (dw_equipmentleasetypelist, 'ScaleToRight&Bottom')

//@(text)--

inv_resize.of_Register (cb_Save, 'FixToRight')
inv_resize.of_Register (cb_New, 'FixToRight')
inv_resize.of_Register (cbx_deactivated, 'FixToRight')


n_cst_Privileges	lnv_Privileges

IF lnv_Privileges.of_EquipmentLeaseType_Setup ( ) = TRUE THEN
	//no protection
ELSE
	long	ll_colcount, &
			ll_ndx
	
	ll_colcount = long(dw_EquipmentLeaseTypeList.Object.DataWindow.Column.Count)
	for ll_ndx = 1 to ll_colcount
		dw_EquipmentLeaseTypeList.SetTabOrder ( ll_ndx, 0 )
	next
	
	cb_new.enabled=false
	cb_save.enabled=false
		
END IF



end event

event close;call super::close;DESTROY inv_ToolmenuManager
RETURN AncestorReturnValue
end event

type dw_equipmentleasetypelist from u_dw_equipmentleasetypelist within w_equipmentleasetypes
string tag = ";objectid=[146628859|994]"
integer x = 23
integer y = 308
integer width = 3410
integer height = 1620
integer taborder = 10
end type

on dw_equipmentleasetypelist.create
call u_dw_equipmentleasetypelist::create
end on

on dw_equipmentleasetypelist.destroy
call u_dw_equipmentleasetypelist::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
//@(data)--

//Use default behavior for retrieval (retrieve from database.)

//RDT 08/23/02 Filter out Status = Deactivated (1)
cbx_deactivated.TriggerEvent(Clicked!)

n_cst_Privileges	lnv_privileges

IF lnv_Privileges.of_EquipmentLeaseType_Setup ( ) = TRUE THEN
	ib_rmbmenu=true
ELSE
	ib_rmbmenu=false
end if
end event

event pfc_addrow;call super::pfc_addrow;// rdt 8/26/02
If ancestorreturnvalue > 0 then 
	this.SetColumn("equipmentleasetype_line")
	this.ScrolltoRow(ancestorreturnvalue)
	this.setfocus()
End if
return ancestorreturnvalue 
end event

type cb_navigations from u_cbnavigate within w_equipmentleasetypes
boolean visible = false
integer width = 329
integer height = 92
integer taborder = 80
boolean bringtotop = true
end type

on cb_navigations.create
call u_cbnavigate::create
end on

on cb_navigations.destroy
call u_cbnavigate::destroy
end on

type st_1 from statictext within w_equipmentleasetypes
integer x = 37
integer y = 136
integer width = 425
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Date/Time &Out:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_dateout from u_sle_date within w_equipmentleasetypes
integer x = 466
integer y = 128
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer accelerator = 111
end type

type sle_timeout from u_sle_time within w_equipmentleasetypes
integer x = 782
integer y = 128
integer width = 297
integer height = 80
integer taborder = 40
boolean bringtotop = true
end type

type sle_timein from u_sle_time within w_equipmentleasetypes
integer x = 1810
integer y = 132
integer width = 297
integer height = 80
integer taborder = 60
boolean bringtotop = true
end type

type sle_datein from u_sle_date within w_equipmentleasetypes
integer x = 1490
integer y = 132
integer height = 80
integer taborder = 50
boolean bringtotop = true
end type

type cb_2 from u_cb within w_equipmentleasetypes
integer x = 2158
integer y = 128
integer width = 270
integer height = 88
integer taborder = 70
boolean bringtotop = true
string text = "&Test"
end type

event clicked;
IF Not sle_DateOut.text = "" THEN
	IF sle_timeOut.text = "" THEN
		sle_TimeOut.text = string( now ( ), "hh:mm")
	END IF
	IF sle_TimeIn.text = "" THEN
		sle_TimeIn.text = string( ( Now() ), "hh:mm")
	END IF

	IF sle_DateIn.text = "" THEN
		sle_DateIn.text = string( Today()  )
	END IF 

	
	dw_equipmentleasetypelist.Event ue_CalcTestResults &
		(  sle_DateOut.of_Get_Date ( ) ,  sle_TimeOut.of_GetTime ( ) , sle_DateIn.of_Get_Date ( ) , sle_TimeIn.of_GetTime ( ) ) 
Else
	MessageBox("Test Values" , "You must at least provide a Date Out to run test values." )
	sle_DateOut.setFocus()
END IF
end event

type st_2 from statictext within w_equipmentleasetypes
integer x = 1106
integer y = 136
integer width = 375
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Date/Time In:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_equipmentleasetypes
integer x = 23
integer y = 44
integer width = 2446
integer height = 200
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Perform Test Calculations"
end type

type cb_save from u_cb_save within w_equipmentleasetypes
integer x = 2848
integer y = 76
integer width = 270
integer taborder = 20
boolean bringtotop = true
end type

type cb_new from u_cb within w_equipmentleasetypes
integer x = 2519
integer y = 76
integer width = 270
integer taborder = 11
boolean bringtotop = true
string text = "&New"
end type

event clicked;dw_equipmentleasetypelist.Trigger Event pfc_AddRow()
end event

type cbx_deactivated from u_cbx within w_equipmentleasetypes
integer x = 2565
integer y = 212
integer width = 553
boolean bringtotop = true
string text = "Show Deactivated"
boolean lefttext = true
end type

event clicked;//RDT 08/23/02 Filter out Status = Deactivated (1)
parent.wf_filterdeactivated()

end event

