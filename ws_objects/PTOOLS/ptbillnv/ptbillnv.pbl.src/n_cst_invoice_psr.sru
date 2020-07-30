$PBExportHeader$n_cst_invoice_psr.sru
forward
global type n_cst_invoice_psr from n_cst_invoice
end type
end forward

shared variables
//begin modification Shared Variables by appeon  20070730

//n_ds	sds_Source//modified global variables, but duplicate n_cst_invoice_psr_manifest
//Int			si_Count
//end modification Shared Variables by appeon  20070730



end variables

global type n_cst_invoice_psr from n_cst_invoice
end type
global n_cst_invoice_psr n_cst_invoice_psr

type variables
//begin modification Shared Variables by appeon  20070730

Int			si_Count
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
protected function integer of_initailizedatasource ()
public function integer of_print ()
protected function boolean of_usearray ()
public function integer of_generate ()
end prototypes

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

public function integer of_print ();Long	ll_SourceShipment
Long	ll_RetrieveRtn
Int	li_Copies
Int	i

n_cst_invoicemanager	lnv_InvoiceMan
lnv_InvoiceMan = CREATE n_cst_invoicemanager

ll_SourceShipment = THIS.of_Getsourceshipmentid( )

IF THIS.of_UseArray ( ) THEN
	ll_RetrieveRtn = sds_source.Retrieve( {ll_SourceShipment} )
ELSE
	ll_RetrieveRtn = sds_source.Retrieve( ll_SourceShipment )
END IF

Commit;
li_Copies = THIS.of_Getcopies( )

IF THIS.of_needsinvoiceprintsetup( ) THEN
	li_Copies = lnv_InvoiceMan.of_Getcopiesfromdialog( )
	IF li_Copies >= 0 THEN
		THIS.of_Setcopies( li_Copies )
		IF li_Copies > 0 THEN
			PrintSetup ( )
		END IF
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

protected function boolean of_usearray ();Boolean	lb_Return
String	lsa_ArgNames[]
String	lsa_ArgTypes[]

n_Cst_Dssrv	lnv_Dssrv
lnv_Dssrv = CREATE n_Cst_dssrv
lnv_Dssrv.of_SetRequestor( sds_source )

IF lnv_Dssrv.of_dwarguments( lsa_ArgNames, lsa_ArgTypes ) > 0 THEN
	lb_Return = Upper ( lsa_ArgTypes[1] ) = "NUMBERLIST"
END IF

Destroy ( lnv_Dssrv )

RETURN lb_Return
	
end function

public function integer of_generate ();Integer	li_Return = 1

IF This.of_Print() <> 1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	IF THIS.of_Printimages( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

Return	li_Return 
end function

on n_cst_invoice_psr.create
call super::create
end on

on n_cst_invoice_psr.destroy
call super::destroy
end on

event constructor;call super::constructor;si_Count ++
end event

event destructor;call super::destructor;si_count --
IF si_count = 0 THEN
	Destroy ( sds_source ) 
END IF
end event

