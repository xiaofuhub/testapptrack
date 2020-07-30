$PBExportHeader$w_importamounts.srw
$PBExportComments$ImportAmounts (Window from PBL map PTSetl) //@(*)[56004604|818]
forward
global type w_importamounts from w_sheet
end type
type dw_amountslist from u_dw_amountowedlist within w_importamounts
end type
type st_1 from u_st_label within w_importamounts
end type
type rb_unassigned from radiobutton within w_importamounts
end type
type rb_transaction from radiobutton within w_importamounts
end type
end forward

global type w_importamounts from w_sheet
int Width=2848
int Height=1364
boolean TitleBar=true
string Title="Fuel Card Import"
string MenuName="m_sheets"
event type integer ue_import ( )
event ue_filter ( )
dw_amountslist dw_amountslist
st_1 st_1
rb_unassigned rb_unassigned
rb_transaction rb_transaction
end type
global w_importamounts w_importamounts

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
protected n_cst_bso_transactionmanager in_transactionmanager //@(*)[68573903|825]
protected n_cst_bso_importmanager_comdata in_importmanager_comdata //@(*)[68659273|826]
protected n_cst_bso_importmanager_tchek in_importmanager_tchek //@(*)[68701538|827]
//@(text)--


Private n_cst_Toolmenu_Manager	inv_ToolmenuManager

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
private function integer wf_createtoolmenu ()
public subroutine wf_process_request (string as_request)
public function n_cst_bso_transactionmanager wf_GetTransactionmanager ()
public function Integer wf_SetTransactionmanager (n_cst_bso_transactionmanager an_transactionmanager)
public function n_cst_bso_importmanager_comdata wf_getimportmanager_comdata ()
public function Integer wf_SetImportmanager_comdata (n_cst_bso_importmanager_comdata an_importmanager_comdata)
public function n_cst_bso_importmanager_tchek wf_getimportmanager_tchek ()
public function Integer wf_SetImportmanager_tchek (n_cst_bso_importmanager_tchek an_importmanager_tchek)
end prototypes

event ue_import;pfc_n_cst_Selection		lnv_Selection
n_cst_bso_ImportManager	lnv_importManager

Any 	laa_ReturnValue[]
String	ls_Selection
String	ls_Type 
powerObject lpo_Empty[]
String	lsa_Empty[]
Integer	li_Return
SetPointer ( HOURGLASS! )
lnv_Selection.of_open("d_importFormat",laa_ReturnValue[], lpo_Empty[],lsa_Empty[],"Select File Type") 

If UpperBound(laa_ReturnValue) = 1 THEN
	ls_selection = laa_ReturnValue[1]
END IF


CHOOSE CASE ls_Selection

CASE "Comdata"
	lnv_ImportManager = wf_getImportManager_ComData()
	ls_Type = "COMDATA"
	
CASE "T-Chek"
	lnv_ImportManager = wf_getImportManager_Tchek()
	ls_Type = "TCHEK"
	
END CHOOSE


IF IsValid(lnv_ImportManager) THEN
	lnv_ImportManager.of_SetType ( ls_Type )

	CHOOSE CASE lnv_ImportManager.of_Import() 

	CASE 1  //Success
	
		dw_AmountsList.SetTransactionManager ( wf_GetTransactionManager ( ) )
		dw_AmountsList.Event pfc_retrieve ( )
		li_Return = 1

	CASE 0  //User cancel
		li_Return = 0

	CASE ELSE  //Failure
		MessageBox ( "Import", "Could not process import information.  Window will close.", &
			Exclamation! )
		ib_DisableCloseQuery = TRUE
		This.Event Post pfc_Close ( )
		li_Return = -1
	
	END CHOOSE
END IF


Return li_Return
end event

event ue_filter;String	ls_Filter

if ( rb_unassigned.Checked ) THEN
	ls_Filter = "isNull (amountowed_fktransaction ) " 
ELSE
	ls_Filter = " not isNull (amountowed_fktransaction ) " 
END IF

dw_amountslist.SetFilter ( ls_Filter )
dw_amountslist.Filter ( )
end event

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null

Choose Case Lower(as_name)
Case "transactionmanager"
     Return in_transactionmanager
Case "importmanager_comdata"
     Return in_importmanager_comdata
Case "importmanager_tchek"
     Return in_importmanager_tchek
End Choose

Return la_null
//@(text)--



end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
any la_any
anv_parameters.GetParameterValue2(as_name, la_any)
Choose Case Lower(as_name)
   Case "transactionmanager"
     If IsNull(la_any) Or Not isValid(la_any) Then
           SetNull(in_transactionmanager)
     ElseIf ClassName(la_any) = "any" Then
           SetNull(in_transactionmanager)
     Else
           in_transactionmanager = la_any
     End If
   Case "importmanager_comdata"
     If IsNull(la_any) Or Not isValid(la_any) Then
           SetNull(in_importmanager_comdata)
     ElseIf ClassName(la_any) = "any" Then
           SetNull(in_importmanager_comdata)
     Else
           in_importmanager_comdata = la_any
     End If
   Case "importmanager_tchek"
     If IsNull(la_any) Or Not isValid(la_any) Then
           SetNull(in_importmanager_tchek)
     ElseIf ClassName(la_any) = "any" Then
           SetNull(in_importmanager_tchek)
     Else
           in_importmanager_tchek = la_any
     End If
End Choose

Return 1
//@(text)--



end function

private function integer wf_createtoolmenu ();s_toolmenu lstr_toolmenu

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)

inv_ToolmenuManager.of_add_standard("SAVE!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "IMPORT!"
lstr_toolmenu.s_toolbutton_picture = "lbolt1.bmp"
lstr_toolmenu.s_toolbutton_text = "IMPORT..."
lstr_toolmenu.s_menuitem_text = "&Import..."
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

//inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1
end function

public subroutine wf_process_request (string as_request);CHOOSE CASE as_Request

CASE "SAVE!"
	This.PostEvent ( "pfc_Save" )

CASE "IMPORT!"
	This.PostEvent ( "ue_Import" )

END CHOOSE
end subroutine

public function n_cst_bso_transactionmanager wf_GetTransactionmanager ();//@(*)[68573903|825:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_transactionmanager
//@(text)--

end function

public function Integer wf_SetTransactionmanager (n_cst_bso_transactionmanager an_transactionmanager);//@(*)[68573903|825:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_transactionmanager = an_transactionmanager
return 1
//@(text)--

end function

public function n_cst_bso_importmanager_comdata wf_getimportmanager_comdata ();//@(*)[68659273|826:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>


//@(text)--
IF NOT IsValid(in_ImportManager_ComData) THEN
	n_cst_bso_ImportManager_ComData lnv_ImportManager
	lnv_ImportManager = Create n_cst_bso_ImportManager_ComData
	lnv_ImportManager.of_SetTransactionManager( This.wf_GetTransactionManager() )
	in_ImportManager_ComData = lnv_ImportManager
END IF

return in_importmanager_comdata
end function

public function Integer wf_SetImportmanager_comdata (n_cst_bso_importmanager_comdata an_importmanager_comdata);//@(*)[68659273|826:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_importmanager_comdata = an_importmanager_comdata
return 1
//@(text)--

end function

public function n_cst_bso_importmanager_tchek wf_getimportmanager_tchek ();//@(*)[68701538|827:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>

 
//@(text)--
IF NOT IsValid(in_ImportManager_Tchek) THEN
	n_cst_bso_ImportManager_Tchek lnv_ImportManager
	lnv_ImportManager = Create n_cst_bso_ImportManager_Tchek
	lnv_ImportManager.of_SetTransactionManager( This.wf_GetTransactionManager() )
	in_ImportManager_Tchek = lnv_ImportManager
END IF

return in_importmanager_Tchek
end function

public function Integer wf_SetImportmanager_tchek (n_cst_bso_importmanager_tchek an_importmanager_tchek);//@(*)[68701538|827:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_importmanager_tchek = an_importmanager_tchek
return 1
//@(text)--

end function

on w_importamounts.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_amountslist=create dw_amountslist
this.st_1=create st_1
this.rb_unassigned=create rb_unassigned
this.rb_transaction=create rb_transaction
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_amountslist
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.rb_unassigned
this.Control[iCurrent+4]=this.rb_transaction
end on

on w_importamounts.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_amountslist)
destroy(this.st_1)
destroy(this.rb_unassigned)
destroy(this.rb_transaction)
end on

event open;call super::open;//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Settlements, "E" ) < 0 THEN
	ib_DisableCloseQuery = TRUE
	close (this)
	return
END IF

gf_Mask_Menu ( m_Sheets )
wf_CreateToolmenu ( )

//@(data)(recreate=yes)<Parameters>
inv_parameters.AddAttribute("TransactionManager", "n_cst_bso_transactionmanager", "In") //@(*)[68573903|825]
inv_parameters.AddAttribute("ImportManager_ComData", "n_cst_bso_importmanager_comdata", "In") //@(*)[68659273|826]
inv_parameters.AddAttribute("ImportManager_Tchek", "n_cst_bso_importmanager_tchek", "In") //@(*)[68701538|827]
//@(data)--

//@(data)(recreate=yes)<Links>
Setlinkage(TRUE)
//@(data)--

//@(data)(recreate=yes)<GenerationOptions>
of_SetResize(TRUE)
SetTransactionManagement(TRUE)
inv_txsrv.SetLoadUpdateList(TRUE)
//@(data)--


n_cst_bso_TransactionManager	lnv_TransactionManager
lnv_TransactionManager = CREATE n_cst_bso_TransactionManager
lnv_TransactionManager.of_SetDefaultCategory ( n_cst_Constants.ci_Category_Payables )
//lnv_TransactionManager.of_RetrieveOpen ( 0 )
wf_SetTransactionManager ( lnv_TransactionManager )




//@(text)(recreate=yes)<RetrieveNoArgs>
//inv_linkage.Retrieve(dw_amountslist)
//@(text)--

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )

//@(text)(recreate=no)<resizevalues>
inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (dw_amountslist, 'ScaleToRight&Bottom')
inv_resize.of_Register (rb_transaction, 'FixedToRight')
inv_resize.of_Register (rb_unassigned, 'FixedToRight')
//@(text)--

any la_Value
n_cst_Settings	lnv_Setting 
lnv_Setting.of_getSetting ( 74 , la_Value )  // create payable to Fuel card vendor

CHOOSE CASE STRING ( la_Value )
		
	CASE "YES!"
		rb_transaction.Enabled = TRUE
	CASE ELSE 
		rb_transaction.Enabled = FALSE
		
END CHOOSE
Event ue_Filter ( )

end event

event task_setinputparameters;call super::task_setinputparameters;//@(+)(recreate=opt)<ValueMaps-ImportAmounts>
Choose Case an_navigation.GetName()
Case "FuelCardImport to Exit1"
//@(data)(recreate=yes)<FuelCardImport to Exit1>
//@(data)--

//@(text)(recreate=no)<FuelCardImport to Exit1 User Code>

//@(text)--
End Choose
//@(+)--

return 1
end event

event close;call super::close;
DESTROY inv_ToolmenuManager
DESTROY in_importmanager_comdata
DESTROY	in_importmanager_tchek
DESTROY	in_transactionmanager
RETURN AncestorReturnValue
end event

event pfc_save;//////////////////////////////////////////////////////////////////////////////
//
// OVERRIDING ANCESTOR SCRIPT
//
//	Event:  pfc_save
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	 0 = No pending changes found 
//	-1 = AcceptText error
//	-2 = UpdatesPending error was encountered
//	-3 = Validation error was encountered
// -9 = The pfc_updateprep process failed
//	-4 = The pfc_preupdate process failed
//	-5 = The pfc_begintran process failed
//	-6 = The pfc_update process failed
//	-7 = The pfc_endtran process failed
//	-8 = The pfc_postsave process failed
//
//	Description:
//	Performs a save operation on the window.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.02 Prevent datawindow dberror messages from appearing while the window
// 		PFC_Save is in progress.
// 6.0	Enhanced to allow updates of specific objects.
// 6.0	Enhanced for pfc_updateprep process.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


//Note:  PFC has this structured with in-code returns, so I'm going with that.

Integer		li_rc
Integer		li_save_rc
Integer		li_endtran_rc


IF NOT IsValid ( in_TransactionManager ) THEN
	//TM not valid -- nothing to update
	RETURN 0  //(No pending changes)
END IF

//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Settlements, "S" ) < 0 THEN
	return -1
END IF


// Check if the CloseQuery process is in progress
If Not ib_closestatus Then
	
//	li_rc = of_UpdateChecks(lpo_updatearray)
	li_rc = of_UpdateChecks()  //Use this version instead.
	If li_rc <= 0 Then 
		//	 0 = No pending changes found 
		//	-1 = AcceptText error
		//	-2 = UpdatesPending error was encountered
		//	-3 = Validation error was encountered		
		Return li_rc
	End If

End If


// Prevent datawindow dberror messages from appearing while PFC_Save 
// updates are in progress. 
ib_savestatus = True				//??Should we still do this

// Update the changed objects.
//li_save_rc = This.Event pfc_Update (ipo_pendingupdates) 
li_save_rc = in_TransactionManager.Event pt_Save ( )

// PFC_Save Updates are no longer in progress.
ib_savestatus = False			//??See above.

// PFC does this:
// If appropriate, display dberror message.
//If li_save_rc<=0 Then This.Event pfc_dberror()

// We'll do this:
// If appropriate, display an error message.
IF li_save_rc <= 0 THEN
	MessageBox ( "Save Changes", "Could not save changes to database.  One or more "+&
		"required fields (Type and Taxable on Amount) may not have been entered, or a "+&
		"save conflict or error may have ocurred.", Exclamation! )
END IF

// Check for a successful save before performing any post operation.
If li_save_rc <> 1 Then Return -6

//We made it -- return success.
Return 1
end event

event pfc_updatespendingref;//////////////////////////////////////////////////////////////////////////////
//
// OVERRIDING ANCESTOR
//
//	Event:  pfc_UpdatesPendingRef
//
//	Arguments:	
//	apo_control[]	The controls on which to perform functionality.
//	apo_pending[] (by ref) The controls which have updates pending.
//
//	Returns:  integer
//	 1 = updates are pending (no errors found)
//	 0 = No updates pending (no errors found)
//	-1 = error
//
//	Description:
//	Request the Logical Unit of Work service to determine which objects have
//	UpdatesPending. 
//
// Note:
//	Simulated Event overloading.
//	This event does NOT store the objects with updates pending in inv_pendingupdates.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

constant integer NO_UPDATESPENDING =0
Integer	li_rc, &
			li_updatespending_rc
PowerObject lpo_empty[]
PowerObject lpo_pending[]
powerobject lpo_updatearray[]

// Clear the pending by reference array.
apo_pending = lpo_empty

// Make sure there is something to take action on.
If UpperBound(apo_control) = 0 Then Return NO_UPDATESPENDING
If Not of_IsUpdateable() Then Return NO_UPDATESPENDING

// Let Logical Unit of Work Service perform the functionality (create if necessary).
//If IsNull(inv_luw) Or Not IsValid (inv_luw) Then of_SetLogicalUnitofWork(True)
//If IsValid(inv_luw) Then
//	li_rc = inv_luw.of_UpdatesPending(apo_control, lpo_pending)
//	apo_pending = lpo_pending
//	If li_rc > 0 Then li_rc = 1
//	Return li_rc
//End If


// Perform the Update Checks to determine if there are any updates 
// pending and if they pass the standard validation

//Check if there are any updates pending
li_updatespending_rc = in_TransactionManager.Event pt_UpdatesPending ( )

CHOOSE CASE li_UpdatesPending_rc

CASE 1  //Updates are pending
	//??Should we set apo_pending to anything??
	li_rc = 1

CASE 0  //No updates pending
	li_rc = 0

CASE ELSE //-1
	li_rc = -1

END CHOOSE


Return li_rc
end event

type dw_amountslist from u_dw_amountowedlist within w_importamounts
int X=357
int Y=220
int Width=2405
int Height=876
int TabOrder=30
string Tag=";objectid=[56064029|819]"
boolean BringToTop=true
end type

on dw_amountslist.create
call u_dw_amountowedlist::create
end on

on dw_amountslist.destroy
call u_dw_amountowedlist::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
this.SetUseTaskRetrieve(TRUE)
//@(data)--

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;//Prevent Add/Insert functionality for now  (see also: pfc_AddRow).
//Note:  This was mistakenly overridden, and fixed in 2.3.00

am_dw.m_Table.m_AddRow.Enabled = FALSE
am_dw.m_Table.m_Insert.Enabled = FALSE
end event

event pfc_addrow;//Override Ancestor
//Prevent Add/Insert functionality for now  (see also: pfc_PreRmbMenu).

RETURN -1
end event

type st_1 from u_st_label within w_importamounts
int X=357
int Y=144
int Width=544
boolean BringToTop=true
string Text="Imported Amounts"
end type

on st_1.create
call u_st_label::create
end on

on st_1.destroy
call u_st_label::destroy
end on

type rb_unassigned from radiobutton within w_importamounts
int X=1614
int Y=56
int Width=1147
int Height=76
int TabOrder=10
boolean BringToTop=true
string Text="Show &Unassigned Amounts Generated"
boolean Automatic=false
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean LeftText=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;THIS.Checked = TRUE
rb_transaction.Checked = FALSE
Event ue_Filter ( )
end event

type rb_transaction from radiobutton within w_importamounts
int X=1614
int Y=136
int Width=1147
int Height=76
int TabOrder=20
boolean BringToTop=true
string Text="Show &Transaction Amounts Generated"
boolean Automatic=false
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;THIS.Checked = TRUE
rb_unassigned.Checked = FALSE
event ue_Filter ( )
end event

