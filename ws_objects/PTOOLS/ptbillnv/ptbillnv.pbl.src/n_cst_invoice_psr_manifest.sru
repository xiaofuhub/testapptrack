$PBExportHeader$n_cst_invoice_psr_manifest.sru
forward
global type n_cst_invoice_psr_manifest from n_cst_invoice_psr
end type
end forward

shared variables
//begin modification Shared Variables by appeon  20070730

//n_ds	sds_Source//modified global variables

//Integer		si_Count
//end modification Shared Variables by appeon  20070730
end variables

global type n_cst_invoice_psr_manifest from n_cst_invoice_psr
end type
global n_cst_invoice_psr_manifest n_cst_invoice_psr_manifest

type variables
Long	ila_SourceShipmentIDs[]
////begin modification Shared Variables by appeon  20070730
//Integer		si_Count
////end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public function integer of_setsourceshipmentids (long ala_shipmentids[])
protected function integer of_initailizedatasource ()
public function integer of_getsourceshipmentids (ref long ala_shipids[])
public function long of_getbilltoid ()
public function integer of_print ()
protected function integer of_printimages ()
end prototypes

public function integer of_setsourceshipmentids (long ala_shipmentids[]);Integer	li_Return = -1

ila_SourceShipmentIds = ala_ShipmentIds

IF THIS.of_initailizedatasource( ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return

end function

protected function integer of_initailizedatasource ();Int		li_Return = -1
String	ls_Template
IF Not IsValid ( sds_source ) THEN
	
	ls_Template = THIS.of_GetSourcefile( )
	
	// verrify that it is a .psr
	IF Upper ( Right (  TRIM ( ls_Template ) , 4 ) ) = ".PSR" THEN
		// set it on the source
		sds_source = CREATE n_ds
		sds_source.DataObject = ls_Template
		sds_source.SetTransObject ( SQLCA )
	END IF


END IF

IF IsValid ( sds_source ) THEN
	IF Len ( sds_source.DataObject ) > 0 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return
end function

public function integer of_getsourceshipmentids (ref long ala_shipids[]);ala_ShipIds = ila_SourceShipmentIds

Return 1
end function

public function long of_getbilltoid ();Long	ll_Return
Long	ll_BillToID
Long	ll_ShipmentID
Long	lla_ShipIds[]

This.of_Getsourceshipmentids(lla_ShipIds[])
ll_ShipmentID = lla_ShipIds[1]  //Bill to id should be the same for all shipments in a manifest

Select ds_Billto_id
Into :ll_BillToID
From disp_Ship
Where ds_Id = :ll_ShipmentID;

Commit;

ll_Return = ll_BillToId


Return ll_Return
end function

public function integer of_print ();Long	ll_SourceShipment
Long	ll_RetrieveRtn
Long	lla_SourceShipments[]
Int	li_Copies
Int	i

n_cst_invoicemanager	lnv_InvoiceMan
lnv_InvoiceMan = CREATE n_cst_invoicemanager

This.of_GetSourceShipmentIds(lla_SourceShipments[])
IF UpperBound(lla_SourceShipments[]) > 0 THEN
	IF isValid(sds_Source) THEN	
		ll_RetrieveRtn = sds_source.Retrieve( lla_SourceShipments[] )
		Commit;
	END IF
END IF

li_Copies = THIS.of_Getcopies( )

IF THIS.of_needsinvoiceprintsetup( ) THEN
	li_Copies = lnv_InvoiceMan.of_Getcopiesfromdialog( )
	IF li_Copies > 0 THEN
		THIS.of_Setcopies( li_Copies )
		PrintSetup ( )
		THIS.of_setneedsinvoiceprintsetup( FALSE )
	END IF
END IF

IF ll_RetrieveRtn > 0 THEN
	FOR i = 1 TO li_Copies
		sds_source.Print()
	NEXT
END IF


DESTROY ( lnv_InvoiceMan )

RETURN 1
end function

protected function integer of_printimages ();Long	ll_BillToID
Long	lla_ShipmentIDs[]
String	lsa_Types[]
Int	i, j


n_cst_Msg	lnv_Msg


n_cst_Settings		lnv_Settings
n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

THIS.of_GetSourceShipmentIds(lla_ShipmentIds[])

IF UpperBound(lla_ShipmentIds[]) > 0 THEN
	
	Select ds_Billto_id
	INTO :ll_BillToID
	From disp_Ship
	Where ds_Id = :lla_ShipmentIds[1]; 
	//Assuming all shipments have same billto
	
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
	
	
	// we are going to have to keep this suff around in a shared variable so it
	// only needs to be set up once per session.
	n_cst_pegasus_print	lnv_print
	lnv_print = THIS.of_Getimageprintcontrol( )
	lnv_Msg = THIS.of_Getimageprintsettings( )
	
	// Check return code
	FOR j = 1 TO UpperBound(lla_ShipmentIds[])
		FOR i = 1 TO Upperbound ( lsa_Types )
			lnv_Print.of_Print ( lsa_Types[i], lla_ShipmentIDs[j], lnv_Msg )
		NEXT
	NEXT
END IF
		
//DESTROY lnv_Print
DESTROY lnv_Company
		
RETURN 1
end function

on n_cst_invoice_psr_manifest.create
call super::create
end on

on n_cst_invoice_psr_manifest.destroy
call super::destroy
end on

