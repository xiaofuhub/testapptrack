$PBExportHeader$n_cst_batchsrv_sap.sru
forward
global type n_cst_batchsrv_sap from n_base
end type
end forward

global type n_cst_batchsrv_sap from n_base
end type
global n_cst_batchsrv_sap n_cst_batchsrv_sap

type variables
Public:
Constant String cs_LINETYPE_DH = "DH"
Constant String cs_LINETYPE_DL_CUSTOMER = "DLD"
Constant String cs_LINETYPE_DL_GL = "DLS"
Constant String cs_LINETYPE_BH = "BH"

Constant String cs_STATUS_MANDATORY = "M"
Constant String cs_STATUS_OPTIONAL = "O"
Constant String cs_STATUS_FUTUREUSE = "F"
Constant String cs_STATUS_NA = "S"

Constant String cs_FIELD_RecordType = "RecordType"
Constant String cs_FIELD_DocumentDate = "DocumentDate"
Constant String cs_FIELD_DocumentType = "DocumentType"
Constant String cs_FIELD_Company = "Company"
Constant String cs_FIELD_PostingDate = "PostingDate"
Constant String cs_FIELD_Period = "Period"
Constant String cs_FIELD_Currency = "Currency"
Constant String cs_FIELD_ExchangeRate = "ExchangeRate"
Constant String cs_FIELD_DocumentNumber = "DocumentNumber"
Constant String cs_FIELD_TranslationDate = "TranslationDate"
Constant String cs_FIELD_ReferenceNumber = "ReferenceNumber"
Constant String cs_FIELD_DocHeaderText = "DocHeaderText" 
Constant String cs_FIELD_Reserved = "Reserved"
Constant String cs_FIELD_LineNumber = "LineNumber"
Constant String cs_FIELD_LineType = "LineType" 
Constant String cs_FIELD_PostingKey = "PostingKey"
Constant String cs_FIELD_NewCompany = "NewCompany"
Constant String cs_FIELD_Account = "Account"
Constant String cs_FIELD_GLIndecator = "GLIndecator"
Constant String cs_FIELD_TransactionType = "TransactionType"
Constant String cs_FIELD_DocumentAmount = "DocumentAmount"
Constant String cs_FIELD_LCAmount = "LCAmount"
Constant String cs_FIELD_BusinessArea = "BusinessArea"
Constant String cs_FIELD_Dpt = "Dpt" 
Constant String cs_FIELD_Svc = "Svc"
Constant String cs_FIELD_Vsl = "Vsl"
Constant String cs_FIELD_Voyage = "Voyage"
Constant String cs_FIELD_D = "D" 
Constant String cs_FIELD_YY = "YY" 
Constant String cs_FIELD_MM = "MM" 
Constant String cs_FIELD_Allocation = "Allocation" 
Constant String cs_FIELD_LineItemText = "LineItemText" 
Constant String cs_FIELD_ValueDate = "ValueDate" 
Constant String cs_FIELD_Taxcode = "Taxcode" 
Constant String cs_FIELD_PmntTerms = "PmntTerms" 
Constant String cs_FIELD_PmntMethod = "PmntMethod" 
Constant String cs_FIELD_PmntBlock = "PmntBlock"
Constant String cs_FIELD_CollectInvoice = "CollectInvoice"
Constant String cs_FIELD_HouseBank = "HouseBank"
Constant String cs_FIELD_PartnerBank = "PartnerBank" 
Constant String cs_FIELD_WhTaxCode = "WhTaxCode" 
Constant String cs_FIELD_WhTaxBaseAmount = "WhTaxBaseAmount" 
Constant String cs_FIELD_CustName = "CustName"
Constant String cs_FIELD_CustCity = "CustCity"

Long	il_DocumentNumber
end variables

forward prototypes
public function integer of_getbatchmetadata (string as_linetype, ref n_ds ads_metadata)
private function integer of_getvaluebytag (string as_tag, n_cst_beo_shipment anv_shipment, ref string as_value)
private function integer of_gettransactionvalue (string as_tag, s_accounting_transaction astr_transaction, ref string as_value)
private function integer of_getvaluefromfunction (string as_function, ref string as_value)
public function integer of_setnextdocumentnumber ()
public function integer of_getvalue (string as_fieldname, n_ds ads_metadata, n_cst_beo_shipment anv_shipment, s_accounting_transaction astr_transaction, integer ai_distributionindex, ref string as_value)
public function integer of_getvalue (string as_fieldname, n_ds ads_metadata, n_cst_beo_shipment anv_shipment, s_accounting_transaction astr_transaction, ref string as_value)
private function integer of_getdistributionvalue (string as_tag, s_accounting_distribution astr_distribution, ref string as_value)
public function integer of_restoresystemdefaults ()
end prototypes

public function integer of_getbatchmetadata (string as_linetype, ref n_ds ads_metadata);Integer	li_Return = 1

n_ds		lds_BatchMetaData

lds_BatchMetadata = Create n_ds
lds_BatchMetadata.DataObject = "d_batchmetadata_sap"
lds_BatchMetadata.SetTransObject(SQLCA)

IF IsValid ( ads_metadata ) THEN
	DESTROY ( ads_metadata ) 
END IF

IF lds_BatchMetadata.Retrieve() <> -1 THEN
	Commit;
ELSE
	li_Return = -1
	Rollback;
END IF

IF li_Return = 1 THEN
	//Filter line type
	IF as_linetype <> "*" THEN
		lds_BatchMetadata.SetFilter("line_type = '" + as_linetype + "'")
		lds_BatchMetadata.Filter()
	END IF
	//Sort
	lds_BatchMetadata.SetSort("line_num A")
	lds_BatchMetadata.Sort()
		
	ads_MetaData = lds_BatchMetadata	
END IF


Return li_Return
end function

private function integer of_getvaluebytag (string as_tag, n_cst_beo_shipment anv_shipment, ref string as_value);Integer	li_Return = 1
Integer	li_StartTag
Integer	li_EndTag
String	ls_Value
Any	 	la_Value

IF isNull(as_Tag) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	li_StartTag = Pos(as_Tag, "<")
	IF li_StartTag > 0 THEN
		li_EndTag = Pos(as_Tag, ">")
		IF li_EndTag > 0 THEN
			ls_Value = Mid(as_Tag, li_StartTag + 1, li_EndTag - li_StartTag - 1) 
		ELSE
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	Long	ll_ID
	CHOOSE CASE Lower ( ls_Value )
		CASE "interfacesequence"
			li_Return = 0
			IF gnv_app.of_GetNextid( "interfacesequence", ll_ID, TRUE) = 1 THEN
				as_Value = String ( ll_ID ) 
			END IF
			
		CASE "documentnumber"
			li_Return = 0		
			as_Value = String ( il_documentnumber, "00000000" ) 
		
	END CHOOSE	
END IF

IF li_Return = 1 THEN
	IF anv_Shipment.of_GetValueAny(ls_Value, la_Value) <> 1 THEN		
		li_Return = -1
	ELSE
		as_Value = String(la_Value)
	END IF
END IF

IF isNull ( as_Value ) THEN
	as_Value = ""
END IF

as_value = Replace ( as_Tag, li_StartTag, Len ( ls_Value ) + 2 , as_Value )

IF li_Return = 0 THEN
	li_Return = 1 
END IF

Return li_Return
end function

private function integer of_gettransactionvalue (string as_tag, s_accounting_transaction astr_transaction, ref string as_value);Integer	li_Return = 1
Integer	li_Pos
String	ls_GetValue
String	ls_Value
String	ls_Format

as_tag = Upper ( Trim ( as_tag ) )

li_Pos = Pos ( as_tag , "FORMAT=" )
IF li_Pos > 0 THEN
	ls_Format = Trim ( Right ( as_tag , Len ( as_tag ) - (  li_pos + 6 ) ) )
	as_tag = Replace ( as_tag , li_Pos - 1 , 8 + Len ( ls_Format) , "" )
END IF

li_Pos = Pos(as_tag, "TRANSACTION.") + 11
ls_GetValue = Right(as_Tag, Len(as_Tag) - li_Pos )

CHOOSE CASE ls_GetValue
	CASE "DOCUMENTNUMBER"
		ls_Value = String ( astr_transaction.is_document_number , ls_Format )
	CASE "DOCUMENTDATE"
		ls_Value = String(astr_transaction.id_document_date , ls_Format )
	CASE "DOCUMENTAMOUNT"
		ls_Value = String(astr_transaction.ic_document_amount, ls_Format )
	CASE "COMPANYNAME"
		ls_Value = String(astr_transaction.is_company_name , ls_Format )
	CASE "COMPANYCODE"
		ls_Value = String(astr_transaction.is_company_code , ls_Format )
	CASE "PAYMENTTERMS"
		ls_Value = String( astr_transaction.is_payment_terms , ls_Format )
	CASE "PAYMENTDUE"
		ls_Value = String(astr_transaction.id_payment_due, ls_Format )
	CASE ELSE
		ls_Value = ""
		li_Return = 0
END CHOOSE

as_Value = ls_Value

Return li_Return
end function

private function integer of_getvaluefromfunction (string as_function, ref string as_value);Integer	li_Return = 1
Integer	li_Pos
String	ls_GetValue
String	ls_Value

String	ls_Function
String	ls_Format

as_function = Upper ( Trim ( as_function ) )

li_Pos = Pos(as_function, "(")
ls_Function = Trim ( left ( as_function , li_Pos - 1 ) )

li_Pos = Pos ( as_Function , "FORMAT=" )
IF li_Pos > 0 THEN
	ls_Format = Trim ( Right ( as_Function , Len ( as_Function ) - (  li_pos + 6 ) ) )
END IF

CHOOSE CASE ls_Function
	CASE "TODAY"
		ls_Value = STRING ( TODAY(), ls_Format )
	
	CASE "MONTH"
		ls_Value = STRING ( Month ( TODAY ( ) ) , ls_Format )
		
	CASE "YEARSHORT"
		ls_Value = Right ( String ( Today ()  , "DDMMYYYY" ), 2 )
	
	CASE "NOW"
		ls_Value = STRING ( NOW (), ls_Format )
	
END CHOOSE

as_Value = ls_Value

Return li_Return
end function

public function integer of_setnextdocumentnumber ();Long	ll_NextID
Int	li_Return
IF gnv_app.of_GetNextid( "documentnumber", ll_NextID, TRUE ) = 1 THEN
	il_documentnumber = ll_NextID
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_getvalue (string as_fieldname, n_ds ads_metadata, n_cst_beo_shipment anv_shipment, s_accounting_transaction astr_transaction, integer ai_distributionindex, ref string as_value);Integer	li_Return = 1
Long		ll_FindRow
Long		ll_RowCount
String	ls_Value
String	ls_FindString
n_cst_string	lnv_String
ll_RowCount = ads_Metadata.RowCount()

ls_FindString = "field_name = '" + as_fieldname + "'"
ll_FindRow = ads_Metadata.Find(ls_FindString, 1, ll_RowCount)
IF ll_FindRow > 0 THEN
	ls_Value = ads_Metadata.GetItemString(ll_FindRow, "value")
	IF isNull ( ls_Value ) THEN
		ls_Value = ""
	END IF
ELSE
	li_Return = -1
END IF

IF li_Return = 1 THEN
	
	//Tag value, look up and replace
	IF Pos(ls_Value, "<") > 0 AND Pos(ls_Value, ">") > 0 THEN
		IF This.of_GetValueByTag(ls_Value, anv_shipment, ls_Value) <> 1 THEN
			li_Return = -1
		END IF
	ELSEIF Pos(ls_Value, "transaction.") > 0 THEN //transaction obj
		IF This.of_GetTransactionValue(ls_Value, astr_transaction, ls_Value) <> 1 THEN
			li_Return = -1
		END IF
	ELSEIF Pos(ls_Value, "distribution.") > 0 THEN //distribution obj
		IF This.of_GetDistributionValue(ls_Value, astr_transaction.istra_Distributions[ai_distributionindex ], ls_Value) <> 1 THEN
			li_Return = -1
		END IF
	ELSEIF pos (ls_Value, "(" ) + Pos ( ls_Value , ")" ) > 2 THEN // this is a function
		IF THIS.of_Getvaluefromfunction( ls_Value/*Function tag*/, ls_Value /* returned */ ) <> 1 THEN
			li_Return = -1
		END IF				
	END IF

END IF

as_Value = ls_Value


Return li_Return
end function

public function integer of_getvalue (string as_fieldname, n_ds ads_metadata, n_cst_beo_shipment anv_shipment, s_accounting_transaction astr_transaction, ref string as_value);Return THIS.of_GetValue( as_FieldName, ads_metadata, anv_shipment, astr_transaction , 0, as_value )
/*
Integer	li_Return = 1
Long		ll_FindRow
Long		ll_RowCount
String	ls_Value
String	ls_FindString
n_cst_string	lnv_String
ll_RowCount = ads_Metadata.RowCount()

ls_FindString = "field_name = '" + as_fieldname + "'"
ll_FindRow = ads_Metadata.Find(ls_FindString, 1, ll_RowCount)
IF ll_FindRow > 0 THEN
	ls_Value = ads_Metadata.GetItemString(ll_FindRow, "value")
	IF isNull ( ls_Value ) THEN
		ls_Value = ""
	END IF
ELSE
	li_Return = -1
END IF

IF li_Return = 1 THEN
	
	//Tag value, look up and replace
	IF Pos(ls_Value, "<") > 0 AND Pos(ls_Value, ">") > 0 THEN
		IF This.of_GetValueByTag(ls_Value, anv_shipment, ls_Value) <> 1 THEN
			li_Return = -1
		END IF
	ELSEIF Pos(ls_Value, "transaction.") > 0 THEN //transaction obj
		IF This.of_GetTransactionValue(ls_Value, astr_transaction, ls_Value) <> 1 THEN
			li_Return = -1
		END IF
	ELSEIF pos (ls_Value, "(" ) + Pos ( ls_Value , ")" ) > 2 THEN // this is a function
		IF THIS.of_Getvaluefromfunction( ls_Value/*Function tag*/, ls_Value /* returned */ ) <> 1 THEN
			li_Return = -1
		END IF
		
		
		
	END IF

END IF

as_Value = ls_Value


Return li_Return
*/
end function

private function integer of_getdistributionvalue (string as_tag, s_accounting_distribution astr_distribution, ref string as_value);Integer	li_Return = 1
Integer	li_Pos
String	ls_GetValue
String	ls_Value
String	ls_Format



as_tag = Upper ( Trim ( as_tag ) )

li_Pos = Pos ( as_tag , "FORMAT=" )
IF li_Pos > 0 THEN
	ls_Format = Trim ( Right ( as_tag , Len ( as_tag ) - (  li_pos + 6 ) ) )
	as_tag = Replace ( as_tag , li_Pos - 1 , 8 + Len ( ls_Format) , "" )
END IF

li_Pos = Pos(as_tag, "DISTRIBUTION.") + 12
ls_GetValue = Right(as_Tag, Len(as_Tag) - li_Pos )

CHOOSE CASE ls_GetValue
	CASE "ACCOUNT"
		ls_Value = String ( astr_Distribution.is_Account , ls_Format )	
	CASE "AMOUNT"
		ls_Value = String ( astr_Distribution.ic_Amount  , ls_Format )	
	CASE ELSE
		ls_Value = ""
		li_Return = 0
END CHOOSE

as_Value = ls_Value

Return li_Return
end function

public function integer of_restoresystemdefaults ();Int		li_Return = 1
Int		li_Count 
Int		i
Int		li_FileHandle
String	lsa_Values[]
String	ls_Value 
String	ls_FileName
String	ls_Sql

IF li_Return = 1 THEN
	ls_Sql = "Drop Table batchmetadata_sap"
	Execute Immediate :ls_Sql;
	IF SQLCA.SQLcode = -1 THEN
		RollBack;
		li_Return = -1	
	END IF	
END IF

IF li_Return = 1 THEN

	ls_Sql = "CREATE TABLE ~"dba~".~"batchmetadata_sap~" (~"field_num~" integer NOT NULL DEFAULT NULL, ~"line_type~" varchar(3) NOT NULL DEFAULT NULL, ~"field_name~" long varchar NOT NULL DEFAULT NULL, ~"field_width~" integer NOT NULL DEFAULT NULL, ~"field_status~" char(1) NOT NULL DEFAULT NULL, ~"pad_side~" char(1) NOT NULL DEFAULT NULL, ~"value~" long varchar DEFAULT NULL , PRIMARY KEY (~"field_num~", ~"line_type~")) ;"
	Execute Immediate :ls_Sql;
	IF SQLCA.SQLcode = -1 THEN
		RollBack;
		li_Return = -1
	END IF
END IF
	
	
IF li_Return = 1 THEN
	lsa_Values [ UpperBound (lsa_Values) + 1] = "1,'DH','RecordType',2,'M','L','DH'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "2,'DH','DocumentDate',10,'M','R','transaction.documentdate;format=DDMMYYYY'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "3,'DH','DocumentType',2,'M','L','IS'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "4,'DH','Company',4,'M','L','3997'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "5,'DH','PostingDate',10,'M','R','TODAY();FORMAT=DDMMYYYY'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "6,'DH','Period',2,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "7,'DH','Currency',5,'M','R','USD'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "8,'DH','ExchangeRate',10,'O','L',"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "9,'DH','DocumentNumber',10,'M','L','40<documentnumber>'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "10,'DH','TranslationDate',10,'O','L',"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "11,'DH','ReferenceNumber',16,'M','R','<invoicenumber>'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "12,'DH','DocHeaderText',25,'O','R',"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "13,'DH','Reserved',20,'F','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "14,'DH','LineCount',3,'M','L','-'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "15,'DH','LineType',1,'M','L','H'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "16,'DH','AmountCount',15,'M','L','-'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "1,'DLD','RecordType',2,'M','L','DL'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "2,'DLD','DocumentDate',10,'M','R','transaction.documentdate;format=DDMMYYYY'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "3,'DLD','DocumentType',2,'M','L','IS'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "4,'DLD','Company',4,'M','L','3997'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "5,'DLD','PostingDate',10,'M','R','TODAY();FORMAT=DDMMYYYY'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "6,'DLD','Period',2,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "7,'DLD','Currency',5,'M','R','USD'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "8,'DLD','ExchangeRate',10,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "9,'DLD','DocumentNumber',10,'M','L','40<documentNumber>'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "10,'DLD','TranslationDate',10,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "11,'DLD','ReferenceNumber',16,'M','R','<invoicenumber>'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "12,'DLD','DocHeaderText',25,'O','R',"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "13,'DLD','Reserved',20,'F','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "14,'DLD','LineNumber',3,'M','L','001'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "15,'DLD','LineType',1,'M','L','D'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "16,'DLD','PostingKey',2,'M','L','01'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "17,'DLD','NewCompany',4,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "18,'DLD','Account',17,'M','R','transaction.companycode'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "19,'DLD','GLIndicator',1,'F','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "20,'DLD','TransactionType',3,'F','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "21,'DLD','DocumentAmount',12,'M','L','distribution.amount'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "22,'DLD','BLANK',1,'S','L',"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "23,'DLD','LCAmount',13,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "24,'DLD','BusinessArea',4,'O','R','NAT'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "25,'DLD','Dpt',3,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "26,'DLD','Svc',4,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "27,'DLD','Vsl',3,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "28,'DLD','Voyage',10,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "29,'DLD','D',1,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "30,'DLD','YY',2,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "31,'DLD','MM',2,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "32,'DLD','Assignment',18,'O','R','<Ref1Text>'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "33,'DLD','LineItemText',50,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "34,'DLD','ValueDate',10,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "35,'DLD','TaxCode',2,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "36,'DLD','PmntTerms',4,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "37,'DLD','PmntMethod',1,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "38,'DLD','PmntBlock',1,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "39,'DLD','CollectInvoice',8,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "40,'DLD','HouseBank',5,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "41,'DLD','PartnerBank',4,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "42,'DLD','WhTaxCode',2,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "43,'DLD','WhTaxBaseAmt',13,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "1,'DLS','RecordType',2,'M','L','DL'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "2,'DLS','DocumentDate',10,'M','R','transaction.documentdate;format=DDMMYYYY'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "3,'DLS','DocumentType',2,'M','L','IS'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "4,'DLS','Company',4,'M','L','3997'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "5,'DLS','PostingDate',10,'M','R','TODAY();FORMAT=DDMMYYYY'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "6,'DLS','Period',2,'O','L',"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "7,'DLS','Currency',5,'M','R','USD'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "8,'DLS','ExchangeRate',10,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "9,'DLS','DocumentNumber',10,'M','L','40<documentNumber>'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "10,'DLS','TranslationDate',10,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "11,'DLS','ReferenceNumber',16,'M','R','<invoicenumber>'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "12,'DLS','DocHeaderText',25,'O','R',"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "13,'DLS','Reserved',20,'F','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "14,'DLS','LineNumber',3,'M','L','-'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "15,'DLS','LineType',1,'M','L','S'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "16,'DLS','PostingKey',2,'M','L','50'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "17,'DLS','NewCompany',4,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "18,'DLS','Account',17,'M','R','distribution.account'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "19,'DLS','GLIndicator',1,'F','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "20,'DLS','TransactionType',3,'F','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "21,'DLS','DocumentAmount',12,'M','L','distribution.amount'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "22,'DLS','BLANK',1,'S','L',"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "23,'DLS','LCAmount',13,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "24,'DLS','BusinessArea',4,'M','R','NAT'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "25,'DLS','Dpt',3,'O','L','173'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "26,'DLS','Svc',4,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "27,'DLS','Vsl',3,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "28,'DLS','Voyage',10,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "29,'DLS','D',1,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "30,'DLS','YY',2,'M','L','YearShort()'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "31,'DLS','MM',2,'M','L','Month();Format=00'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "32,'DLS','Assignment',18,'O','R','<Ref1Text>'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "33,'DLS','LineItemText',50,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "34,'DLS','ValueDate',10,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "35,'DLS','TaxCode',2,'O','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "36,'DLS','PmntTerms',4,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "37,'DLS','PmntMethod',1,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "38,'DLS','PmntBlock',1,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "39,'DLS','CollectInvoice',8,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "40,'DLS','HouseBank',5,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "41,'DLS','PartnerBank',4,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "42,'DLS','WhTaxCode',2,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "43,'DLS','WhTaxBaseAmt',13,'S','L',''"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "1,'BH','RecordType',2,'M','L','BH'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "2,'BH','BatchID',8,'M','R','MDS'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "3,'BH','InterfaceSeq',4,'M','L','<InterfaceSequence>'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "4,'BH','InterfaceType',2,'M','L','AR'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "5,'BH','ExtractionDate',8,'M','L','TODAY();FORMAT=DDMMYYYY'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "6,'BH','ExtractionTime',6,'M','L','NOW();FORMAT=HHMMSS'"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "7,'BH','DocumentCount',8,'M','L',"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "8,'BH','LineCount',12,'M','L',"
	lsa_Values [ UpperBound (lsa_Values) + 1] = "9,'BH','ControlTotal',20,'M','L',"
	
	li_Count = UpperBound ( lsa_Values ) 
		
	ls_FileName = "c:\\tmpsap" + string ( Now () ,"HHMMSSFF" )
	
	li_FileHandle = FileOpen ( ls_FileName , LineMode! , write! )
	IF li_FileHandle >= 0 THEN
		FOR i = 1 TO li_Count
			FileWrite ( li_FileHandle , lsa_Values[i] )
		NEXT
	END IF
	FileClose ( li_FileHandle ) 

	ls_Sql = "LOAD TABLE batchmetadata_sap FROM '" + ls_FileName +"' Format ASCII"
	Execute Immediate :ls_Sql;
	IF SQLCA.SQLcode = 0 THEN
		Commit;
	ELSE
		RollBack;
		li_Return = -1
	END IF
	
	FileDelete ( ls_FileName )

END IF

Return 1
end function

on n_cst_batchsrv_sap.create
call super::create
end on

on n_cst_batchsrv_sap.destroy
call super::destroy
end on

