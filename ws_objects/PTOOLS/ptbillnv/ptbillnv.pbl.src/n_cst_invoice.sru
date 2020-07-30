$PBExportHeader$n_cst_invoice.sru
forward
global type n_cst_invoice from n_cst_base
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//n_cst_pegasus_print	snv_print
//Boolean					sb_NeedsImageSetUp = TRUE
//Boolean					sb_NeedsInvoicePrintSetup = TRUE
//n_Cst_Msg				snv_PrintSetupMsg
//Int						si_Copies
////end modification Shared Variables by appeon  20070730
//
end variables

global type n_cst_invoice from n_cst_base
end type
global n_cst_invoice n_cst_invoice

type variables
Protected:
Long	il_SourceShipmentID
String	is_SourceFile				// template file, .psr file

//begin modification Shared Variables by appeon  20070730
//n_cst_pegasus_print	snv_print
Boolean					sb_NeedsImageSetUp = TRUE
Boolean					sb_NeedsInvoicePrintSetup = TRUE
//n_Cst_Msg				snv_PrintSetupMsg
Int						si_Copies
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public function integer of_print ()
protected function integer of_printimages ()
public function integer of_setsourceshipmentid (long al_shipmentid)
public function long of_getsourceshipmentid ()
protected function integer of_populateinvoicedata ()
protected function integer of_initailizedatasource ()
protected function n_cst_msg of_getimageprintsettings ()
protected function n_cst_pegasus_print of_getimageprintcontrol ()
protected function boolean of_needsinvoiceprintsetup ()
protected function integer of_setneedsinvoiceprintsetup (boolean ab_value)
public function integer of_setsourcefile (string as_source)
protected function string of_getsourcefile ()
public function integer of_setcopies (integer ai_copies)
public function integer of_getcopies ()
public function integer of_generate ()
public function long of_getbilltoid ()
public function integer of_adderror (string as_errortext)
public function integer of_geterrors (ref string asa_errors[])
public function integer of_setsourceshipmentids (long ala_shipids[])
public function integer of_getsourceshipmentids (ref long ala_shipids[])
end prototypes

public function integer of_print ();//implemented in desc.
RETURN -1
end function

protected function integer of_printimages ();Long	ll_BillToID
Long	ll_ShipmentID
Long	ll_NumPaths
String	lsa_Types[]
String	lsa_ImagePaths[]
String	ls_Path
Int	i, j
Boolean	lb_NeedToPrintImages


n_cst_Msg	lnv_Msg


n_cst_Settings		lnv_Settings
n_cst_beo_Company	lnv_Company

n_cst_beo_ImageType 		lnva_ImageTypes[]

n_cst_bso_ImageManager_Pegasus lnv_ImageManager


lnv_Company = CREATE n_cst_beo_Company

lnv_ImageManager = Create n_cst_bso_ImageManager_Pegasus

ll_ShipmentID = THIS.of_Getsourceshipmentid( )

Select ds_Billto_id
INTO :ll_BillToID
From disp_Ship
Where ds_Id = :ll_ShipmentID;

Commit;


IF ll_BillToID > 0 THEN
	lnv_Company.of_SetUsecache( TRUE )
	lnv_Company.of_SetSourceID ( ll_BillToID ) 
	IF lnv_Company.of_OverridePrintingImageTypes ( ) THEN
		lnv_Company.of_getprintingImageTypes ( lsa_Types )
	ELSE
		lnv_Settings.of_GetPrintingImageTypes ( lsa_types )
	END IF

ELSE 
	lnv_Settings.of_GetPrintingImageTypes ( lsa_types )
END IF

//Find out if image(s) actually exist for the shipment
FOR i = 1 TO UpperBound( lsa_Types )
	lnv_ImageManager.of_GetImageTypesForType( lsa_Types[i], lnva_ImageTypes[] )
	
	lnv_ImageManager.of_GetImagelist( lnva_ImageTypes, {ll_ShipmentID}, lsa_ImagePaths )
	
	ll_NumPaths = UpperBound(lsa_ImagePaths)
	FOR j = 1 TO ll_NumPaths
		IF lnv_ImageManager.of_DoesImageExist( lsa_ImagePaths[j] ) THEN
			lb_NeedToPrintImages = TRUE
			EXIT
		END IF
	NEXT
	IF lb_NeedToPrintImages = TRUE THEN
		EXIT
	END IF
NEXT

IF lb_NeedToPrintImages THEN
	// we are going to have to keep this suff around in a shared variable so it
	// only needs to be set up once per session.
	n_cst_pegasus_print	lnv_print
	lnv_print = THIS.of_Getimageprintcontrol( )
	lnv_Msg = THIS.of_Getimageprintsettings( )
	
	// Check return code
	FOR i = 1 TO Upperbound ( lsa_Types )
		
		lnv_Print.of_Print ( lsa_Types[i], ll_ShipmentID, lnv_Msg )
		
	NEXT
	
END IF		
		
//DESTROY lnv_Print
DESTROY lnv_Company
		
	
	

RETURN 1
end function

public function integer of_setsourceshipmentid (long al_shipmentid);Int	li_Return = -1

il_Sourceshipmentid = al_shipmentid

IF THIS.of_initailizedatasource( ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return
end function

public function long of_getsourceshipmentid ();RETURN il_sourceshipmentid
end function

protected function integer of_populateinvoicedata ();// Imp in Desc
RETURN -1
end function

protected function integer of_initailizedatasource ();return -1
end function

protected function n_cst_msg of_getimageprintsettings ();IF sb_needsimagesetup THEN
	THIS.of_getimageprintcontrol( ).of_PrintSetup ( snv_printsetupmsg ) 
	sb_needsimagesetup = FALSE
END IF

RETURN snv_printsetupmsg
end function

protected function n_cst_pegasus_print of_getimageprintcontrol ();IF NOT IsValid ( snv_print ) THEN
	snv_print = create n_cst_pegasus_print
END IF

RETURN snv_print


end function

protected function boolean of_needsinvoiceprintsetup ();RETURN sb_Needsinvoiceprintsetup
end function

protected function integer of_setneedsinvoiceprintsetup (boolean ab_value);sb_needsinvoiceprintsetup = ab_value
RETURN 1
end function

public function integer of_setsourcefile (string as_source);THIS.is_SourceFile = as_source
RETURN 1
end function

protected function string of_getsourcefile ();RETURN is_sourcefile
end function

public function integer of_setcopies (integer ai_copies);si_copies = ai_copies
RETURN 1
end function

public function integer of_getcopies ();Return si_copies
end function

public function integer of_generate ();// Implemented in Decendent
Return -1
end function

public function long of_getbilltoid ();Long	ll_Return
Long	ll_BillToID
Long	ll_ShipmentID


ll_ShipmentID = This.of_Getsourceshipmentid( )

Select ds_Billto_id
Into :ll_BillToID
From disp_Ship
Where ds_Id = :ll_ShipmentID;

Commit;

ll_Return = ll_BillToId


Return ll_Return
end function

public function integer of_adderror (string as_errortext);String				ls_ErrorMessage
n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

ls_ErrorMessage = as_errortext 

lnv_Error.SetErrorMessage( ls_ErrorMessage )
lnv_Error.SetMessageHeader ( "Billing" )

RETURN 1
end function

public function integer of_geterrors (ref string asa_errors[]);int 		li_errorCount
int		i
String	ls_ErrorString
String	lsa_Errors[]

n_cst_OFRError 				lnva_Error[]
n_cst_OFRError_Collection 	lnv_ErrorCollection

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_ErrorCollection.geterrorcount( )

FOR i = 1 TO li_ErrorCount
	ls_ErrorString = string( lnva_Error[i].getErrorMessage() )
	lsa_Errors[i] = ls_ErrorString
NEXT

asa_Errors = lsa_Errors

RETURN li_ErrorCount
end function

public function integer of_setsourceshipmentids (long ala_shipids[]);/*implemented at maifest decendents*/

Return 1
end function

public function integer of_getsourceshipmentids (ref long ala_shipids[]);/*implemented at manifest decendents*/

Return 1
end function

on n_cst_invoice.create
call super::create
end on

on n_cst_invoice.destroy
call super::destroy
end on

event destructor;call super::destructor;sb_needsimagesetup = TRUE
sb_needsinvoiceprintsetup = TRUE
si_copies = 0
end event

