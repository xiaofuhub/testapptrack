$PBExportHeader$n_cst_invoicemanager.sru
forward
global type n_cst_invoicemanager from n_cst_base
end type
end forward

global type n_cst_invoicemanager from n_cst_base
end type
global n_cst_invoicemanager n_cst_invoicemanager

type variables
Private:
n_cst_Invoice	inva_Invoices[]

//Invoice types used to append to base class n_cst_invoice for CREATE purposes
//Example: n_cst_invoice_PSR_MANIFEST
Constant	string	cs_Invoicetype_PSR = "PSR"
Constant	string	cs_Invoicetype_WordDoc = "WORDDOC"
Constant	string	cs_Invoicetype_XlsDoc = "XLSDOC"
Constant string	cs_InvoiceType_EMAILABLE_PSR = "EMAILABLE_PSR"
Constant string	cs_InvoiceType_PSR_Manifest = "PSR_MANIFEST"
Constant string	cs_InvoiceType_Emailable_PSR_Manifest = "EMAILABLE_PSR_MANIFEST"


String	is_SourceTemplateFile

Boolean	ib_Manifest
Boolean	ib_AllowEmail = TRUE
Boolean	ib_ProgressBar = TRUE



end variables

forward prototypes
private function integer of_resetinvoices ()
private function integer of_populateinvoices (long ala_shipmentids[])
public function integer of_setsourcetemplatefile (string as_file)
protected function string of_getsourcetemplatefile ()
public function integer of_getcopiesfromdialog ()
private function integer of_getinvoicetype (ref string as_sourcefile, ref string as_type, long al_shipid)
public function integer of_displayerrors ()
public function integer of_generateindividualinvoices (long ala_shipmentids[])
private function integer of_generateinvoices (long ala_shipmentids[])
public function integer of_generatemanifestinvoices (long ala_shipmentids[])
public function integer of_setallowemail (boolean ab_allowemail)
public function integer of_setprogressbar (boolean ab_switch)
public function integer of_geterrors (ref string asa_errors[])
end prototypes

private function integer of_resetinvoices ();n_cst_Invoice	lnva_EMPTY[]
n_cst_AnyArraySrv	lnv_Array

lnv_Array.of_Destroy(  inva_invoices )
inva_invoices = lnva_EMPTY


RETURN 1

end function

private function integer of_populateinvoices (long ala_shipmentids[]);Int	li_Count
Int	i
String	ls_InvoiceType
String	ls_SourceFile
Boolean	lb_ValidType = TRUE

li_Count = UpperBound ( ala_shipmentids[] )

IF ib_Manifest THEN
	IF li_Count > 0 THEN
		/*Assumes that all shipments have the same billto at this point*/
		lb_ValidType = This.of_GetInvoiceType(ls_SourceFile, ls_InvoiceType, ala_ShipmentIds[1]) = 1
		IF lb_ValidType THEN
			inva_Invoices[1] = CREATE USING "n_cst_Invoice_" + ls_InvoiceType	
			inva_Invoices[1].of_SetSourceFile (ls_SourceFile)
			inva_Invoices[1].of_SetsourceShipmentIds(ala_ShipmentIds[])
		END IF
	END IF
ELSE
	
	FOR i = 1 TO li_Count
		
		lb_ValidType = THIS.of_Getinvoicetype( ls_SourceFile , ls_InvoiceType, ala_shipmentids[i] ) = 1
		IF lb_ValidType THEN
			inva_Invoices[i] = CREATE USING "n_cst_Invoice_" + ls_InvoiceType	
			inva_Invoices[i].of_SetSourceFile ( ls_SourceFile )
			inva_Invoices[i].of_Setsourceshipmentid( ala_shipmentids[i] )
		END IF	
		
	NEXT
		
END IF

li_Count = UpperBound(inva_Invoices[])

RETURN li_Count
end function

public function integer of_setsourcetemplatefile (string as_file);is_sourcetemplatefile = as_file
RETURN 1
end function

protected function string of_getsourcetemplatefile ();RETURN is_sourcetemplatefile
end function

public function integer of_getcopiesfromdialog ();Boolean	lb_Continue
Int		li_Count
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm
s_longs		lstr_Copies

SetNull ( lstr_Copies.longar[1] )
lstr_Copies.longar[2] = 1

openwithparm(w_bill_copies, lstr_Copies)
IF IsValid ( message.powerobjectparm ) THEN
	lnv_Msg = message.powerobjectparm
END IF

IF lnv_Msg.of_Get_Parm ( "CONTINUE" , lstr_parm ) <> 0 THEN
	lb_Continue = lstr_Parm.ia_value
END IF

IF lb_Continue THEN
	
	IF lnv_Msg.of_Get_Parm ( "COPIES" , lstr_parm ) <> 0 THEN
		lstr_Copies = lstr_Parm.ia_value
	ELSE
		lb_Continue = FALSE
	END IF

END IF

IF lb_Continue THEN
	
	
	li_Count = lstr_Copies.longar[2] 
	
END IF

RETURN li_Count
end function

private function integer of_getinvoicetype (ref string as_sourcefile, ref string as_type, long al_shipid);Int	li_Return = -1
String	ls_Template
String	ls_Test
String	ls_Type
Boolean	lb_Email
Long		ll_CoId
n_cst_beo_company		lnv_company
n_cst_LicenseManager	lnv_LicenseMan
lnv_company = CREATE n_cst_beo_company

Select ds_billto_id
Into :ll_CoId
From disp_ship
Where ds_id = :al_shipid;

COMMIT;

//cache the row incase it hasnt been already
gnv_cst_companies.of_Cache( ll_CoId, False)

lnv_Company.of_SetUseCache(TRUE)
lnv_Company.of_SetSourceId(ll_CoId)

IF lnv_Company.of_HasSource() THEN

	ls_Template = THIS.of_Getsourcetemplatefile( )
	
	ls_Test = Upper ( Right (  TRIM ( ls_Template ) , 4 ) )
	
	CHOOSE CASE ls_Test
		
		CASE ".PSR"
			lb_Email = lnv_Company.of_EmailInvoices() AND ib_AllowEmail // I added the ib_AllowEmail <<*>>
			
			IF ib_Manifest THEN //Assumes that all shipments have the same billto now
				IF lb_Email THEN
					ls_Type = cs_InvoiceType_Emailable_Psr_Manifest
				ELSE	
					ls_Type = cs_InvoiceType_Psr_Manifest
				END IF
			ELSE
				IF lb_Email THEN
					ls_Type = cs_InvoiceType_emailable_psr
				ELSE	
					ls_Type = cs_invoicetype_psr
				END IF
			END IF
			
			li_Return = 1
			
		CASE ".DOC"
			ls_Type = cs_invoicetype_worddoc
			li_Return = 1
		
		CASE ".XLS"
			ls_Type = cs_invoicetype_xlsdoc
			li_Return = 1
			
		CASE ELSE
			
	END CHOOSE
	
	
	IF li_Return = 1 THEN
		
		as_sourcefile = ls_Template
		as_type = ls_Type
		
	END IF
	
END IF
Destroy lnv_Company

	
RETURN li_Return
end function

public function integer of_displayerrors ();Long	ll_NumErrors
Long	ll_NumInvoices
Long	i
Long	j
String	lsa_Errors[]
String	ls_ErrorString

ll_NumInvoices = UpperBound(inva_Invoices[])
FOR i = 1 TO ll_NumInvoices
	inva_invoices[i].of_GetErrors(lsa_Errors[])
	ll_NumErrors = UpperBound(lsa_Errors[])
	IF ll_NumErrors > 0 THEN
		
		FOR j = 1 TO ll_NumErrors
			ls_ErrorString += lsa_Errors[j] + "~r~n"
		NEXT
		
	END IF
NEXT

IF Len(ls_ErrorSTring) > 0 THEN
		MessageBox("Invoice Error", ls_ErrorString)
	END IF

Return ll_NumErrors

end function

public function integer of_generateindividualinvoices (long ala_shipmentids[]);ib_Manifest = FALSE

Return of_GenerateInvoices(ala_ShipmentIds[])


end function

private function integer of_generateinvoices (long ala_shipmentids[]);Int	li_Return = -1
Int	li_Count
Int	i
Int	li_PrintCount
String	ls_PbText
String	ls_OriginalPrinter

w_Pop_Progress		lw_Progress

THIS.of_Resetinvoices( )

li_Count = THIS.of_PopulateInvoices( ala_shipmentids[] )

IF ib_Manifest THEN
	ls_PbText = "Processing Manifest Invoice..."
ELSE
	ls_PBText = "Processing Individual Invoices..."
END IF

IF ib_Progressbar THEN
	Open(lw_Progress)
	lw_Progress.wf_SetTitle ( "Profit Tools Invoice Transfer" )
	lw_Progress.wf_SetText(ls_PbText)
	lw_Progress.wf_SetMax(li_Count)
	lw_Progress.wf_Setstep(1)
END IF

ls_OriginalPrinter = PrintGetPrinter()

FOR i = 1 TO li_Count
	
	IF inva_invoices[i].of_Generate() = 1 THEN
		li_PrintCount ++
		IF isValid(lw_Progress) THEN
			lw_Progress.wf_StepIt()
		END IF
	END IF
	
NEXT

//MFS 2/19/07 - reset default printer incase user has changed it via printsetup().
PrintSetPrinter(ls_OriginalPrinter)

IF ib_ProgressBar THEN
	CLOSE(lw_Progress)
END IF

IF li_PrintCount = li_count THEN
	li_Return = 1
END IF

RETURN li_Return
end function

public function integer of_generatemanifestinvoices (long ala_shipmentids[]);ib_Manifest = TRUE

Return of_GenerateInvoices(ala_ShipmentIds[])
end function

public function integer of_setallowemail (boolean ab_allowemail);ib_allowemail = ab_allowemail
RETURN 1
end function

public function integer of_setprogressbar (boolean ab_switch);ib_ProgressBar = ab_switch

Return 1
end function

public function integer of_geterrors (ref string asa_errors[]);Long	ll_NumErrors
Long	ll_NumInvoices
Long	i, j
String	lsa_Errors[]

String	lsa_totalErrors[]

ll_NumInvoices = UpperBound(inva_Invoices[])
FOR i = 1 TO ll_NumInvoices
	inva_invoices[i].of_GetErrors(lsa_Errors[])
	ll_NumErrors = UpperBound(lsa_Errors[])
		
	FOR j = 1 TO ll_NumErrors
		lsa_TotalErrors[UpperBound(lsa_TotalErrors) + 1] = lsa_Errors[j]
	NEXT
		
NEXT

asa_Errors = lsa_TotalErrors

Return ll_NumErrors
end function

on n_cst_invoicemanager.create
call super::create
end on

on n_cst_invoicemanager.destroy
call super::destroy
end on

