$PBExportHeader$u_tv_settings.sru
$PBExportComments$took a copy to add 94, norm had it out when i made my copy
forward
global type u_tv_settings from treeview
end type
end forward

global type u_tv_settings from treeview
int Width=1499
int Height=680
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
string PictureName[]={"Custom039!"}
long PictureMaskColor=536870912
long StatePictureMaskColor=536870912
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event ue_selection ( long al_setting )
end type
global u_tv_settings u_tv_settings

type variables
Private:
Window		iw_Requestor
PowerObject	ipo_Source
u_cst_Setting	iuo_Setting
DataStore	ids_Cache
end variables

forward prototypes
public function integer of_setrequestor (window aw_requestor)
private function powerobject of_getsource ()
private function window of_getrequestor ()
public function boolean of_ready ()
private function integer of_setsource (powerobject apo_source)
private subroutine of_closecurrentobject ()
public function integer of_update ()
public function boolean of_ismodified ()
end prototypes

event ue_selection;// RDT 112202 Added Full Path to GL Payables and Receivables file 
// RDT 120202 Added Groups who can send TIR & LFD Notices
// RDT 012103 Added QuickBooks direct options
// RDT 7-21-03 Added QuickBooks File Path
// NWL 9-4-03 Removed 92 (commented out)
Window	lw_Requestor
PowerObject	lpo_Source
Integer	li_X, &
			li_Y
Long		ll_Handle
TreeViewItem	ltvi_Current
String	ls_CurrentLabel
String	ls_NewLabel

string	ls_list
	string	lsa_result[], &
				lsa_type[]
			
	long		ll_ndx,&
				ll_arraycount,&
				ll_value

	n_cst_string	lnv_string
	n_cst_presentation_amounttype lnv_presentationamounttype
	
u_cst_Setting_Enumerated	luo_Setting_Enumerated

of_CloseCurrentObject ( )

lw_Requestor = of_GetRequestor ( )
lpo_Source = of_GetSource ( )

li_X = This.X
li_Y = This.Y + This.Height + 50

ll_Handle = FindItem ( CurrentTreeItem!, 0 )
IF GetItem ( ll_Handle, ltvi_Current ) = 1 THEN
	ls_CurrentLabel = ltvi_Current.Label
END IF

CHOOSE CASE al_Setting

CASE 10, 11, 26, 69 //PC*Miler Server, PC*Miler Mapping, Allow Force Billing,
								// Prompt for alternative invoice date
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeLong! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( 0, "No" )
	luo_Setting_Enumerated.of_AddValue ( 1, "Yes" )

	iuo_Setting = luo_Setting_Enumerated

CASE 12  //"Mileage Type for Settlements"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeLong! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( 0, "Practical" )
	luo_Setting_Enumerated.of_AddValue ( 1, "Short" )
	luo_Setting_Enumerated.of_AddValue ( 2, "National Network" )
	luo_Setting_Enumerated.of_AddValue ( 3, "Avoid Toll" )
	luo_Setting_Enumerated.of_AddValue ( 4, "Air" )

	iuo_Setting = luo_Setting_Enumerated

CASE 20  //"Accounting Package"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "BUSINESSWORKS!", "BusinessWorks" )
	luo_Setting_Enumerated.of_AddValue ( "PEACHTREE!", "Peachtree" )
	luo_Setting_Enumerated.of_AddValue ( "QUICKBOOKS!", "QuickBooks " )
	// RDT 012103 - start
	luo_Setting_Enumerated.of_AddValue ( "QUICKBOOKSDIRECT2002!", "QuickBooks 2002 Direct" )
	luo_Setting_Enumerated.of_AddValue ( "QUICKBOOKSDIRECT2003!", "QuickBooks 2003 Direct" )
	// RDT 012103 - end

	luo_Setting_Enumerated.of_AddValue ( "DYNAMICS4AND5!", "Dynamics ver. 4 and 5" )
	luo_Setting_Enumerated.of_AddValue ( "DYNAMICS6!", "Dynamics ver. 6" )
	//Note that if adding more Dynamics types, there are conditions in the constructor
	//of n_cst_acctlink_dynamics that reference these values, that will need to be 
	//updated to indicate how to handle the new version you're adding.
	luo_Setting_Enumerated.of_AddValue ( "DACEASY!", "DacEasy" )
	luo_Setting_Enumerated.of_AddValue ( "FLATFILE!", "Flat File Export" )
	luo_Setting_Enumerated.of_AddValue ( "NONE!", "None" )

	iuo_Setting = luo_Setting_Enumerated

CASE 21  //"Invoice Size"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "FULL_PAGE!", "Full Sheet" )
	luo_Setting_Enumerated.of_AddValue ( "HALF_PAGE!", "Half Sheet" )

	iuo_Setting = luo_Setting_Enumerated

CASE 22  //"Invoice Billto Alignment"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "BILLTO_LEFT!", "Left Side" )
	luo_Setting_Enumerated.of_AddValue ( "BILLTO_RIGHT!", "Right Side" )

	iuo_Setting = luo_Setting_Enumerated
	
	
CASE 65 //"Enable Split Billing
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	

CASE 43  //"Billing Manifest Print Orientation"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "Landscape!", "Landscape" )
	luo_Setting_Enumerated.of_AddValue ( "Portrait!", "Portrait" )

	iuo_Setting = luo_Setting_Enumerated

CASE 24, 40, 30  //"Delivery Receipt Comment", "Dock IDs", "Custom Fuel Surcharge Description"								 
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )
	
CASE 45, 37, 100 //"Use Custom Delivery Receipt", "Use Custom Invoice", "Create Carrier Payables Batch during Billing"		

	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	luo_Setting_Enumerated.of_AddValue ( "ASK!", "Ask Each Time" )

	iuo_Setting = luo_Setting_Enumerated
	
CASE 46, 38 //Full path and filename for "Delivery Receipt Template"
				//Full path and filename for "Custom Invoice Template"
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )

CASE 50 		//customer validation file location
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )	

CASE 51 		//Location of receivables batch folder
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )	
	
CASE 52  //Use Default Batch Name
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Always" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "Never" )
	luo_Setting_Enumerated.of_AddValue ( "ASK!", "Always Ask" )
	iuo_Setting = luo_Setting_Enumerated
	
CASE 53 		//Location of BW Access File
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )	
		
CASE 54 		//Location of Payables batch folder
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )			
	
CASE 55 		//Location of Vendor validation file
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )			
	
CASE 56 		//Location of Employee validation file
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )		

CASE 60, 101, 102,103, 116
	// Full path to EDI 214 and 210 export Folder , Path to 204 import , imported 204s, 204 log
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )				
	
CASE 58	//create payables batches -- yes no 
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	
	
CASE 59 // create payroll batches -- yes no 
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated
	
CASE 31, 32, 34   //"Required Image Types for Billing" , "Warning of Non-Existing Image Types for Billing"	
						// "Images to be printed w/ invoices"
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	ls_NewLabel = "Add values separated by a semicolon"
	iuo_Setting.of_SetLabel ( ls_NewLabel )
	
CASE 35 // Quadrant for image title
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "UR!", "Upper Right" )
	luo_Setting_Enumerated.of_AddValue ( "UL!", "Upper Left" )
	luo_Setting_Enumerated.of_AddValue ( "LL!", "Lower Left" )
	luo_Setting_Enumerated.of_AddValue ( "LR!", "Lower Right" )

	iuo_Setting = luo_Setting_Enumerated


CASE 36 // groups who can scan documents
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "ALL!", "ALL" )
	luo_Setting_Enumerated.of_AddValue ( "ENTRY!", "ENTRY" )
	luo_Setting_Enumerated.of_AddValue ( "AUDIT!", "AUDIT" )
	luo_Setting_Enumerated.of_AddValue ( "ADMIN!", "ADMIN" )
	
	iuo_Setting = luo_Setting_Enumerated
	
CASE 64 //"Enable Imaging External Exception Notification By Default"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated
		
	
CASE 25, 41, 42
	//"Delivery Receipt Charges", "Crossdock Events on Invoice", "Crossdock Events on Delivery Receipt"

	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "HIDE!", "Always Hide" )
	luo_Setting_Enumerated.of_AddValue ( "SHOW!", "Always Show" )
	luo_Setting_Enumerated.of_AddValue ( "ASK!", "Ask Each Time" )

	iuo_Setting = luo_Setting_Enumerated

CASE 27  //"Groups Who See Shipment List Sales Totals"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "ALL!", "ALL" )
	luo_Setting_Enumerated.of_AddValue ( "AUDIT!", "AUDIT / ADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "ADMIN!", "ADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "NONE!", "NONE" )
	//These values are referenced in n_cst_Privileges.of_ShipmentSummary_ViewTotalCharges

	iuo_Setting = luo_Setting_Enumerated

CASE 28  //"Fuel Surcharge Percentage"
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Sle", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeDecimal! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )	

CASE 33   //Full Path to Imaging Root
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	ls_NewLabel = "Limit Folder Lengths To 8 Letters"
	iuo_Setting.of_SetLabel ( ls_NewLabel )	

CASE 44, 132, 133		//FULL PATH AND FILENAME OF RATE CONFIRMATION TEMPLATE - GL Payables and Receivables file added by RDT 112202
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )	
	
CASE 57 		//Full Path to LiveLoad Folder
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )	
		
CASE 61    //Full Path to Equipment Summary Views 
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )	
	
CASE 62    //Full Path to Saved Rates File
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )		
	
CASE 63  // Set Appt. dates to ship date
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	
	iuo_Setting = luo_Setting_Enumerated
	
CASE 66 // communication path
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )
	
CASE 67 // Path to templates
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )
	
CASE 68 // Path to Cache Files
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )
	
CASE 70 //Validate Primary Reference number against Primary	Reference number.

	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	

CASE 71 //Validate Primary Reference number against item BL#/Ref#

	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	

CASE 72	//Validate against History / Open / All

	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "OPEN!", "Open" )
	luo_Setting_Enumerated.of_AddValue ( "ALL!", "All" )

	iuo_Setting = luo_Setting_Enumerated

CASE 74 //Generate Payable to fuel card entity

	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated
	
CASE 75 //Generate Fuel Deductions for employees

	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	
	
	
CASE  76  // markup fees to drivers

	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated
	
CASE 73 // markup amount for fuel card fees
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	ls_NewLabel = "Use a % at the end of the value to represent a percent."
	iuo_Setting.of_SetLabel ( ls_NewLabel )


CASE  77, 78, 130
	// Groups who can cancel shipments, Groups who can delete shipments, 
	// Groups who can convert shipments to Non-Routed

	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "ENTRY!", "ENTRY" )
	luo_Setting_Enumerated.of_AddValue ( "AUDIT!", "AUDIT" )
	luo_Setting_Enumerated.of_AddValue ( "ADMIN!", "ADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "PTADMIN!", "PTADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "NONE!", "NONE" )
	iuo_Setting = luo_Setting_Enumerated	
	
	
CASE 82  // unlinked creation of OE
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	
	
CASE 83	//Company SCAC code
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )
	
CASE 84	//Produce EDI 214 file on each save
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated
	
CASE 85	//List of Pools and Yards
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	ls_NewLabel = "comma separated list of Pools and Yards (quick ref)."
	iuo_Setting.of_SetLabel ( ls_NewLabel )

CASE 86	//open event note window automatically
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated

CASE 87	//List of Types For event notes
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	ls_NewLabel = "comma separated list of types."
	iuo_Setting.of_SetLabel ( ls_NewLabel )

CASE 88	//default type for "chassis move"
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	ls_NewLabel = "Enter a value from the type list above"
	iuo_Setting.of_SetLabel ( ls_NewLabel )
	
CASE 89	//default type for "Yard drop"
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	ls_NewLabel = "Enter a value from the type list above"
	iuo_Setting.of_SetLabel ( ls_NewLabel )	
	
CASE 90	//use today's date when using goto
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated
	
CASE 91	//Deactivate Equipment on Terminataion
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated

CASE 92  //Only Convert only the first hook on chassis move
	
	//** no longer needed **//
	
//	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
//	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
//	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
//	
//	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
//	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
//	iuo_Setting = luo_Setting_Enumerated

// norm has 93 in his copy


CASE 94 // groups who manually  deactivate equipment.
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "ALL!", "ALL" )
	luo_Setting_Enumerated.of_AddValue ( "ENTRY!", "ENTRY" )
	luo_Setting_Enumerated.of_AddValue ( "AUDIT!", "AUDIT" )
	luo_Setting_Enumerated.of_AddValue ( "ADMIN!", "ADMIN" )
	iuo_Setting = luo_Setting_Enumerated

CASE 95 //Dynamics on MS SQL Server
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated

CASE 96  // Payables for New Dispatch Shipment, default freight and accessorial
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "ITEM!", "ITEM" )
	luo_Setting_Enumerated.of_AddValue ( "FREIGHTACCESSORIAL!", "FREIGHT/ACC TOTAL" )
	luo_Setting_Enumerated.of_AddValue ( "GRANDTOTAL!", "GRAND TOTAL" )
	iuo_Setting = luo_Setting_Enumerated	
	
CASE 97  // Payables for New Brokerage Shipment, default item
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "ITEM!", "ITEM" )
	luo_Setting_Enumerated.of_AddValue ( "FREIGHTACCESSORIAL!", "FREIGHT/ACC TOTAL" )
	luo_Setting_Enumerated.of_AddValue ( "GRANDTOTAL!", "GRAND TOTAL" )
	iuo_Setting = luo_Setting_Enumerated	

CASE 98 // Default Freight Amount Type
	
	lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_receivables)
	lnv_presentationamounttype.of_SetAmountTypeFilter ( n_cst_constants.cs_itemtype_freight )
	
	ls_list = lnv_presentationamounttype.of_settypelist()
	
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeLong! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	IF lnv_String.of_ParseToArray ( ls_list, '/' , lsa_Result ) > 0 THEN
		ll_arraycount = upperbound(lsa_result)
		for ll_ndx = 1 to ll_arraycount
			IF lnv_String.of_ParseToArray ( lsa_result[ll_ndx], '~t' , lsa_type ) > 0 THEN
				ll_value = long(lsa_type[2])
				luo_Setting_Enumerated.of_AddValue ( ll_value, lsa_type[1] )
			end if
		next
	end if

	iuo_Setting = luo_Setting_Enumerated
	
CASE  99  //  Default Accessorial Amount Type
		
	lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_receivables)
	lnv_presentationamounttype.of_SetAmountTypeFilter ( n_cst_constants.cs_itemtype_Accessorial )
	
	ls_list = lnv_presentationamounttype.of_settypelist()
	
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeLong! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	IF lnv_String.of_ParseToArray ( ls_list, '/' , lsa_Result ) > 0 THEN
		ll_arraycount = upperbound(lsa_result)
		for ll_ndx = 1 to ll_arraycount
			IF lnv_String.of_ParseToArray ( lsa_result[ll_ndx], '~t' , lsa_type ) > 0 THEN
				ll_value = long(lsa_type[2])
				luo_Setting_Enumerated.of_AddValue ( ll_value, lsa_type[1] )
			end if
		next
	end if

	iuo_Setting = luo_Setting_Enumerated
	
	
	
CASE 104 // orfin calculation 
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated
	
	
CASE 105 // "Default for new ship button"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "DISPATCH!", "DISPATCH" )
	luo_Setting_Enumerated.of_AddValue ( "INTERMODAL!", "INTERMODAL" )
	luo_Setting_Enumerated.of_AddValue ( "CROSSDOCK!", "CROSSDOCK" )
	luo_Setting_Enumerated.of_AddValue ( "NONROUTED!", "NONROUTED" )
	luo_Setting_Enumerated.of_AddValue ( "BROKERAGE!", "BROKERAGE" )
	luo_Setting_Enumerated.of_AddValue ( "NONROUTEDBROKERAGE!", "NONROUTEDBROKERAGE" )
	luo_Setting_Enumerated.of_AddValue ( "TEMPLATE!", "TEMPLATE" )
	luo_Setting_Enumerated.of_AddValue ( "3RDPARTYTRIP!", "3RDPARTYTRIP" )

	iuo_Setting = luo_Setting_Enumerated

CASE 106	//Default type to route
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	luo_Setting_Enumerated.of_AddValue ( gc_Dispatch.cs_RouteType_Any , gc_Dispatch.cs_RouteType_Any )
	luo_Setting_Enumerated.of_AddValue ( gc_Dispatch.cs_RouteType_Pickup, gc_Dispatch.cs_RouteType_Pickup )
	luo_Setting_Enumerated.of_AddValue ( gc_Dispatch.cs_RouteType_Deliver, gc_Dispatch.cs_RouteType_Deliver )
	luo_Setting_Enumerated.of_AddValue ( "NONE!", "NONE" )
	
	iuo_Setting = luo_Setting_Enumerated

CASE 107	//Default leg to route
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( "Enter 0 for all legs" )

CASE 108 // "Route shipments created by mobile comm." 
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	

// 109 - 114 are taken
CASE 115	// "Print order for invoices."
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	ls_NewLabel = "Call Tech Support for syntax."
	iuo_Setting.of_SetLabel ( ls_NewLabel )	

CASE 121  //"Types for Quickbooks PO# (AR only)."
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	ls_NewLabel = "Add double quoted values separated by a comma."
	iuo_Setting.of_SetLabel ( ls_NewLabel )

CASE 122 // "Reverse Origin/Destination search for Autorating." 
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	

//123,124,125 are taken

CASE 126 // "Generate pay for Accessorials" 
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	

CASE 131  //"Payable Fuel Surcharge Percentage"
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Sle", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeDecimal! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )	

CASE 129   //"Path to Payable Batch Error Logs."
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )
	
CASE 127  //"Groups Who Can Modify Freight Rate Information"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "ALL!", "ALL" )
	luo_Setting_Enumerated.of_AddValue ( "ENTRY!", "ENTRY" )
	luo_Setting_Enumerated.of_AddValue ( "AUDIT!", "AUDIT / ADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "ADMIN!", "ADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "NONE!", "NONE" )

	iuo_Setting = luo_Setting_Enumerated

CASE 128  //"Groups Who Can Modify Accessorial Rate Information"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "ALL!", "ALL" )
	luo_Setting_Enumerated.of_AddValue ( "ENTRY!", "ENTRY" )
	luo_Setting_Enumerated.of_AddValue ( "AUDIT!", "AUDIT / ADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "ADMIN!", "ADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "NONE!", "NONE" )

	iuo_Setting = luo_Setting_Enumerated


CASE 134  //"Groups Who Can Send TIR & Last Free Date Notifications "	// RDT 120202 
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "ALL!", "ALL" )
	luo_Setting_Enumerated.of_AddValue ( "ENTRY!", "ENTRY" )
	luo_Setting_Enumerated.of_AddValue ( "AUDIT!", "AUDIT / ADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "ADMIN!", "ADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "NONE!", "NONE" )

	iuo_Setting = luo_Setting_Enumerated
	
CASE 138 // allow switching the shipment equipment is linked to 
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	


CASE 139 // add stopoff item
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	luo_Setting_Enumerated.of_AddValue ( "ASK!", "Ask Each Time" )
	iuo_Setting = luo_Setting_Enumerated
	
CASE 142 // automatically add fuel surcharge
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated
	
CASE 143 //	"Cross Check 2nd & 3rd ref"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	ls_NewLabel = "Cross Check 2nd and 3rd ref"
	luo_Setting_Enumerated.of_SetLabel ( ls_NewLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NULLREF1!", "Only If Ref1 is Empty" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated
	
	
CASE 144 //	Paste Per Diem Format
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	ls_NewLabel = "Format of Paste Per Diem Charges"
	luo_Setting_Enumerated.of_SetLabel ( ls_NewLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "TOTAL!", "Total Amount" )
	luo_Setting_Enumerated.of_AddValue ( "BYPERIOD!", "By Period" )
	iuo_Setting = luo_Setting_Enumerated
	

CASE 145 //	"Billto Required to Save Shipment"
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	
	
CASE 146 //	"Holiday counts as free day
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	

CASE 147 //	Shipment Note Format
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "ONENOTE!", "One Single Note" )
	luo_Setting_Enumerated.of_AddValue ( "INDIVIDUAL!", "Individual Notes" )
	iuo_Setting = luo_Setting_Enumerated	

CASE 148  //groups that can edit image assignments
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "ALL!", "ALL" )
	luo_Setting_Enumerated.of_AddValue ( "ENTRY!", "ENTRY" )
	luo_Setting_Enumerated.of_AddValue ( "AUDIT!", "AUDIT / ADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "ADMIN!", "ADMIN" )
	luo_Setting_Enumerated.of_AddValue ( "SYSADMIN!", "PT ADMIN" )

	iuo_Setting = luo_Setting_Enumerated

CASE 149 //	Add stopoff automatically when running 204
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	
	
CASE 150 		//Full Path to QuickBooks file folder
	lw_Requestor.OpenUserObject ( iuo_Setting, "u_cst_Setting_Text", li_X, li_Y )
	iuo_Setting.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	iuo_Setting.of_SetLabel ( ls_CurrentLabel )			


CASE 151 //	Exclude chassis from invoice equipment list
	lw_Requestor.OpenUserObject ( luo_Setting_Enumerated, li_X, li_Y )
	luo_Setting_Enumerated.of_SetTarget ( lpo_Source, al_Setting, TypeString! )
	luo_Setting_Enumerated.of_SetLabel ( ls_CurrentLabel )
	
	luo_Setting_Enumerated.of_AddValue ( "YES!", "Yes" )
	luo_Setting_Enumerated.of_AddValue ( "NO!", "No" )
	iuo_Setting = luo_Setting_Enumerated	


END CHOOSE


IF IsValid ( iuo_Setting ) THEN
	iuo_Setting.TabOrder = This.TabOrder + 1
END IF
	


	

end event

public function integer of_setrequestor (window aw_requestor);iw_Requestor = aw_Requestor

RETURN 1
end function

private function powerobject of_getsource ();RETURN ipo_Source
end function

private function window of_getrequestor ();RETURN iw_Requestor
end function

public function boolean of_ready ();Boolean	lb_Ready

IF NOT IsValid ( ids_Cache ) THEN

	ids_Cache = CREATE DataStore
	ids_Cache.DataObject = "d_Settings"
	ids_Cache.SetTransObject ( SQLCA )

	IF ids_Cache.Retrieve ( ) >= 0 THEN
		COMMIT ;
		of_SetSource ( ids_Cache )
	ELSE
		ROLLBACK ;
		DESTROY ids_Cache
	END IF

END IF

lb_Ready = IsValid ( ids_Cache )

RETURN lb_Ready
end function

private function integer of_setsource (powerobject apo_source);ipo_Source = apo_Source

RETURN 1
end function

private subroutine of_closecurrentobject ();Window	lw_Requestor

lw_Requestor = of_GetRequestor ( )

IF IsValid ( iuo_Setting ) THEN
	lw_Requestor.CloseUserObject ( iuo_Setting )
END IF
end subroutine

public function integer of_update ();Integer	li_Return

CHOOSE CASE ids_Cache.Update ( )

CASE 1
	COMMIT ;
	li_Return = 1

CASE ELSE
	ROLLBACK ;
	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function boolean of_ismodified ();IF ids_Cache.ModifiedCount ( ) > 0 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
end function

event constructor;//Note:  In order to create a system setting, you need to make two entries:
//One here, and one in ue_Selection
// RDT 11-22-02 added 132 Full Path to GL Payables  Validation 
// RDT 11-22-02 added 133 Full Path to GL Receivables Validation 
// RDT 12-02-02 Added 134 - Groups who can send TIR & LFD Notices
// RDT 7-21-03 Added System Setting for QuickBooks File path for background connection.
// NWL 9-4-03 Removed 92 (commented out)
Long	ll_Handle
TreeViewItem	ltvi_Work

of_SetRequestor ( This.GetParent ( ) )
of_Ready ( )

ltvi_Work.PictureIndex = 1
ltvi_Work.SelectedPictureIndex = 1

ltvi_Work.Label = "Accounting Package"
ltvi_Work.Data = 20
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Invoice Size"
ltvi_Work.Data = 21
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Invoice Billto Alignment"
ltvi_Work.Data = 22
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Print order for invoices."
ltvi_Work.Data = 115
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Use Custom Invoice"
ltvi_Work.Data = 37
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Custom Invoice Template"
ltvi_Work.Data = 38
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Crossdock on Invoice"
ltvi_Work.Data = 41
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )
	
ltvi_Work.Label = "Prompt for alternative invoice date"
ltvi_Work.Data = 69
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Exclude chassis from invoice equipment list"
ltvi_Work.Data = 151
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Enable Split Billing"
ltvi_Work.Data = 65
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Billing Manifest Print Orientation"
ltvi_Work.Data = 43
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Location of Customer Validation File"
ltvi_Work.Data = 50
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Location of Vendor Validation File"
ltvi_Work.Data = 55
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Location of Employee Validation File"
ltvi_Work.Data = 56
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Location of Receivables Batch Folder"
ltvi_Work.Data = 51
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Location of Payables Batch Folder"
ltvi_Work.Data = 54
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Types for Quickbooks PO# (AR only)."
ltvi_Work.Data = 121
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

// RDT 7-21-03 
ltvi_Work.Label = "Full Path to QuickBooks Files"
ltvi_Work.Data = 150
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Full Path to EDI 210 Export Folder"
ltvi_Work.Data = 116
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Full Path to EDI 214 Export Folder"
ltvi_Work.Data = 60
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Your company SCAC"
ltvi_Work.Data = 83
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Produce 214 EDI file on each save"
ltvi_Work.Data = 84
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Use Default Batch Name"
ltvi_Work.Data = 52
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Path To Business Works Access File"
ltvi_Work.Data = 53
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Dynamics on MS SQL Server"
ltvi_Work.Data = 95
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Create Payables Batches"
ltvi_Work.Data = 58
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Create Payroll Batches"
ltvi_Work.Data = 59
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Full Path to Imaging Root"
ltvi_Work.Data = 33
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Images to be printed with invoices"
ltvi_Work.Data = 34
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Quadrant for Image Title"
ltvi_Work.Data = 35
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Groups Who Can Scan Documents"
ltvi_Work.Data = 36
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Groups Who Can Change Image Assignments"
ltvi_Work.Data = 148
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Required Image Types for Billing"
ltvi_Work.Data = 31
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Warning of Non-Existing Image Types for Billing"
ltvi_Work.Data = 32
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Display External Imaging Error Messages By Default"
ltvi_Work.Data = 64
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )


ltvi_Work.Label = "Delivery Receipt Comment"
ltvi_Work.Data = 24
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Delivery Receipt Charges"
ltvi_Work.Data = 25
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Crossdock on Delivery Receipt"
ltvi_Work.Data = 42
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Use custom Delivery Receipt"
ltvi_Work.Data = 45
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Delivery Receipt Template"
ltvi_Work.Data = 46
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Allow Force Billing"
ltvi_Work.Data = 26
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "PC*Miler Server Installed"
ltvi_Work.Data = 10
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "PC*Miler Mapping Installed"
ltvi_Work.Data = 11
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Mileage Type for Settlements"
ltvi_Work.Data = 12
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Dock IDs"
ltvi_Work.Data = 40
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Groups Who See Shipment List Sales Totals"
ltvi_Work.Data = 27
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Fuel Surcharge Percentage"
ltvi_Work.Data = 28
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Custom Fuel Surcharge Description"
ltvi_Work.Data = 30
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Automatically add Fuel Surcharge"
ltvi_Work.Data = 142
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Rate Confirmation Template"
ltvi_Work.Data = 44
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Set Initial Appt. Dates to ShipDate"
ltvi_Work.Data = 63
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Groups Who Can Cancel Shipments"
ltvi_Work.Data = 77
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Groups Who Can Delete Shipments"
ltvi_Work.Data = 78
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Groups Who Can Convert Shipments to Non-Routed"
ltvi_Work.Data = 130
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Full Path to LiveLoad Folder"
ltvi_Work.Data = 57
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Full Path to Equipment Summary Views"
ltvi_Work.Data = 61
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Full Path to Saved Rates File"
ltvi_Work.Data = 62
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Full Path to QualComm Folder"
ltvi_Work.Data = 66
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Full Path to Templates Folder"
ltvi_Work.Data = 67
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Full Path to Cache Files"
ltvi_Work.Data = 68
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Validate Prim Ref Against Prim Ref"
ltvi_Work.Data = 70
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Validate Prim Ref Against Item BL/Ref"
ltvi_Work.Data = 71
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Shipments to Validate Against Prim Ref"
ltvi_Work.Data = 72
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Cross Check 2nd & 3rd ref"
ltvi_Work.Data = 143
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Generate Payable to Fuel Card Entity"
ltvi_Work.Data = 74
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Generate Fuel Deductions For Employees"
ltvi_Work.Data = 75
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Auto Generate pay for Accessorials."
ltvi_Work.Data = 126
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Payable Fuel Surcharge Percentage"
ltvi_Work.Data = 131
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Path to Payable Batch Error Logs."
ltvi_Work.Data = 129
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Markup Fees to Drivers"
ltvi_Work.Data = 76
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Default Markup Amount For Fuel Card Fees"
ltvi_Work.Data = 73
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Is Unlinked Equipment Creation Allowed"
ltvi_Work.Data = 82
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Allow Relinking of Linked Equipment"
ltvi_Work.Data = 138
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "List of Pools and Yards"
ltvi_Work.Data = 85
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Open Event Note Wizard Automatically"
ltvi_Work.Data = 86
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "List of Types For Event Note"
ltvi_Work.Data = 87
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Default Type For ~"Chassis Move~""
ltvi_Work.Data = 88
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Default Type For ~"Yard Drop~""
ltvi_Work.Data = 89
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Use Today's Date When Using Goto In Shipment"
ltvi_Work.Data = 90
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Deactivate Equipment on Termination"
ltvi_Work.Data = 91
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

	//** no longer needed **//
	
//ltvi_Work.Label = "Only Convert First Hook on a Chassis Move"
//ltvi_Work.Data = 92
//ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Groups Who Can Manually Terminate Equipment"
ltvi_Work.Data = 94
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Payables format for New Dispatch Shipment"
ltvi_Work.Data = 96
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Payables format for New Brokerage Shipment"
ltvi_Work.Data = 97
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Default Freight Amount Type"
ltvi_Work.Data = 98
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Default Accessorial Amount Type"
ltvi_Work.Data = 99
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Create Carrier Payables Batch During Billing"
ltvi_Work.Data = 100
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Path to 204 Import Folder"
ltvi_Work.Data = 101
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Path to Folder For Processed 204 Files"
ltvi_Work.Data = 102
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Path to Folder For 204 log"
ltvi_Work.Data = 103
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Automatically add/remove Stopoff Item During 204"
ltvi_Work.Data = 149
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Determine Origin/Destination Automatically"
ltvi_Work.Data = 104
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Default for New Ship Button"
ltvi_Work.Data = 105
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Default Type for Auto Route"
ltvi_Work.Data = 106
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Default Leg for Auto Route"
ltvi_Work.Data = 107
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Route Shipments Created by Mobile Comm."
ltvi_Work.Data = 108
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

// 109 - 114 are taken

ltvi_Work.Label = "Reverse Origin/Destination search for Autorating."
ltvi_Work.Data = 122
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

// 123,124,125 are taken

ltvi_Work.Label = "Groups Who Can Modify Freight Rate Information"
ltvi_Work.Data = 127
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Groups Who Can Modify Accessorial Rate Information"
ltvi_Work.Data = 128
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

// RDT 11-22-02 added 132
ltvi_Work.Label = "Full Path to GL Payables Validation File"
ltvi_Work.Data = 132
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

// RDT 11-22-02 added 133
ltvi_Work.Label = "Full Path to GL Receivables Validation File"
ltvi_Work.Data = 133
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

// RDT 12-02-02 Added 134 
ltvi_Work.Label = "Groups Who Can Send TIR and LFD Notifications"
ltvi_Work.Data = 134
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Automatically add/remove Stopoff Item"
ltvi_Work.Data = 139
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Format of Paste Per Diem Charges"
ltvi_Work.Data = 144
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Holiday Counts as Extra Free Day"
ltvi_Work.Data = 146
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Billto Required to Save Shipment"
ltvi_Work.Data = 145
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

ltvi_Work.Label = "Shipment Note Format"
ltvi_Work.Data = 147
ll_Handle = This.InsertItemLast ( 0, ltvi_Work )

end event

event selectionchanged;TreeViewItem	ltvi_Work
Long	ll_Data

This.GetItem ( NewHandle, ltvi_Work )

IF IsValid ( ltvi_Work ) THEN

	IF Upper ( ClassName ( ltvi_Work.Data ) ) = "LONG" THEN
		ll_Data = ltvi_Work.Data
	END IF

END IF


Event Post ue_Selection ( ll_Data )
end event

event destructor;of_CloseCurrentObject ( )

DESTROY ids_Cache
end event

