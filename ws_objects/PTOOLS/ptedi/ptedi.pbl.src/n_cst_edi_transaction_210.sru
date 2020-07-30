$PBExportHeader$n_cst_edi_transaction_210.sru
forward
global type n_cst_edi_transaction_210 from n_cst_edi_transaction
end type
end forward

global type n_cst_edi_transaction_210 from n_cst_edi_transaction
end type
global n_cst_edi_transaction_210 n_cst_edi_transaction_210

type variables
PRIVATE:

string		is_path

datawindow	idw_invoice

CONSTANT Long  cl_InvoiceLen = 15
CONSTANT Long  cl_TPLen = 15
CONSTANT Long  cl_BLLen = 15
CONSTANT Long  cl_POLen = 6
CONSTANT Long  cl_QTYLen = 6
CONSTANT Long  cl_WTLen = 5
CONSTANT Long  cl_ChargesLen = 9
CONSTANT Long  cl_EquipLen = 10
CONSTANT Long  cl_LocCodeLen = 20
CONSTANT Long  cl_NameLen = 20
CONSTANT Long  cl_AddLen = 20
CONSTANT Long  cl_StateLen = 2
CONSTANT Long  cl_ZipLen = 9
CONSTANT Long  cl_CityLen = 15
CONSTANT Long  cl_DescLen = 20
CONSTANT Long  cl_BillRateQtyLen = 9
CONSTANT Long  cl_NMFCLen = 7
CONSTANT Long  cl_FreightLen = 7
end variables

forward prototypes
private function integer of_formatinvoicenum (ref string as_invoicenum)
private function integer of_formatblnum (ref string as_blnum)
private function integer of_formatdate (date ad_date, ref string as_formateddate)
private function integer of_formatpo (ref string as_ponum)
private function integer of_formatppcol (ref string as_PPCol)
private function integer of_formatweight (long al_weight, ref string as_formatedwt)
private function integer of_formatcharges (dec adec_Charges, ref string as_FormatedCharges)
private function integer of_formatequipnum (ref string as_equipmentnum)
private function integer of_addfill (long al_len, ref string as_fill)
private function integer of_formateventcode (ref string as_eventcode)
private function integer of_formatlocationcode (ref string as_LocationCode)
private function integer of_formatname (ref string as_name)
private function integer of_formataddress (ref string as_Address)
private function integer of_formatstate (ref String as_State)
private function integer of_formatzip (ref string as_zip)
private function integer of_formatcity (ref string as_city)
private function integer of_formatqty (int ai_quantity, ref string as_formatedqty)
private function integer of_getqty (readonly datawindow adw_source, integer ai_row, ref int ai_qty)
private function integer of_formatweightqual (ref string as_weightqual)
private function integer of_formatdescription (ref string as_Description)
private function integer of_formatqtyqual (ref string as_qtyqual)
private function integer of_formatchargesqual (ref string as_Qual)
private function integer of_formatbillrateqty (decimal adec_rate, ref string as_formated)
private function integer of_formatbillrtdqual (ref string as_Qual)
private function integer of_formatcommoditycode (ref string as_Code)
private function integer of_formatreasoncode (ref string as_code)
private function integer of_formatfreightclass (ref string as_class)
private function integer of_formattradingpartner (readonly long al_coid, ref string as_formated)
private subroutine of_getrecord1 (long al_row, ref string asa_column[], ref string asa_text[])
private subroutine of_getrecord2 (long al_row, ref string asa_column[], ref string asa_text[])
private subroutine of_getrecord5 (long al_row, ref string asa_column[], ref string asa_text[])
private subroutine of_getrecord6 (long al_row, ref string asa_column[], ref string asa_text[])
public subroutine of_loadtransactions (ref n_cst_msg anv_msg)
private subroutine of_getrecord3 (long al_row, ref string asa_column[], ref string asa_text[], string as_reftype)
private subroutine of_getrecord4 (long al_row, ref string asa_column[], ref string asa_text[], string as_which)
public function integer of_validate (ref n_cst_msg anv_msg)
public subroutine of_sendtransaction (long ala_id[])
protected function string of_getoutboundmappingfile ()
public function long of_get210companies (ref long ala_ids[])
public function string of_geterrorcontext (long ala_ids[])
public function string of_getremedyobjectstring ()
public subroutine of_createtransaction (ref n_ds ads_edipending, ref long ala_ediid[], ref long ala_sourceid[])
end prototypes

private function integer of_formatinvoicenum (ref string as_invoicenum);Long		ll_Len
Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source

n_cst_String	lnv_String
ls_Source = as_invoicenum
ll_len = cl_invoicelen  //15

IF Isnull (ls_Source ) THEN
	ls_Source = ""
END IF

ls_ReturnString = lnv_String.of_PadRight ( ls_Source, ll_len )
IF Len (ls_ReturnString ) <> ll_Len THEN
	li_ReturnValue = -1
ELSE
	as_InvoiceNum = ls_ReturnString
END IF

RETURN li_ReturnValue 
end function

private function integer of_formatblnum (ref string as_blnum);Long		ll_Len
Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source

n_cst_String	lnv_String
ls_Source = as_BLNum
ll_len = cl_bllen  //15

IF isNull ( ls_Source ) THEN
	ls_Source = " " 
END IF

IF Len ( ls_Source ) > 0 THEN

	ls_ReturnString = lnv_String.of_PadRight ( ls_Source, ll_len )
	IF IsNull ( ls_ReturnString ) OR LEN ( ls_ReturnString ) <> ll_len THEN
		li_ReturnValue = -1
	END IF
ELSE
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1 THEN
	as_BLNum = ls_ReturnString
END IF

RETURN li_ReturnValue 
end function

private function integer of_formatdate (date ad_date, ref string as_formateddate);String	ls_Date
string	lsa_Result[]
Int		li_ReturnValue = 1
Int	li_YY
Int	li_MM
Int	li_DD

n_cst_String	lnv_String

ls_Date = String ( ad_date )

lnv_String.of_ParseToArray ( ls_Date , "/" , lsa_Result)

ls_Date = ""

IF UpperBound ( lsa_Result ) = 3 THEN
	// i could not get the proper formating w/o casting to an int and then to a string 
	li_YY = Integer (lsa_Result[3] )
	li_MM = Integer (lsa_Result[2] )
	li_DD = Integer (lsa_Result[1] )
	ls_Date = String ( li_YY, "00" )
	ls_Date = ls_Date + String ( li_MM, "00" )
	ls_Date = ls_Date + String ( li_DD, "00" )
ELSE
	li_ReturnValue = -1
END IF
	
IF Len ( ls_Date ) = 6 THEN
	as_formateddate = ls_Date
END IF

RETURN li_ReturnValue 
end function

private function integer of_formatpo (ref string as_ponum);Long		ll_Len
Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source

n_cst_String	lnv_String
ls_Source = as_ponum
ll_len = cl_polen  //6

IF isNull ( ls_Source ) THEN
	ls_Source = " " 
END IF

IF Len ( ls_Source ) > 0 THEN

	ls_ReturnString = lnv_String.of_PadRight ( ls_Source, ll_len )
	IF IsNull ( ls_ReturnString ) OR LEN ( ls_ReturnString ) <> ll_len THEN
		li_ReturnValue = -1
	END IF
ELSE
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1 THEN
	as_ponum = ls_ReturnString
END IF

RETURN li_ReturnValue 
end function

private function integer of_formatppcol (ref string as_PPCol);
String 	ls_ReturnString
String	ls_Source
Int		li_ReturnValue = 1

ls_Source = as_PPCol

Choose Case ls_Source
	CASE "T"
		ls_ReturnString = "TP"
	CASE "P"
		ls_ReturnString = "PP"
	CASE "C"
		ls_ReturnString = "CC"
	CASE "Z"
		ls_ReturnString = "US"
	CASE ELSE
		ls_ReturnString = "  "
END CHOOSE

IF Len ( ls_ReturnString ) = 2 THEN
	li_ReturnValue = 1
	as_PPCol = ls_ReturnString
ELSE
	li_ReturnValue = -1
	as_PPCol = "  "
END IF

RETURN li_ReturnValue

end function

private function integer of_formatweight (long al_weight, ref string as_formatedwt);Int		li_ReturnValue = 1
String	ls_FormatedWT
Long		ll_WT

ll_WT = al_Weight
IF isNull ( ll_WT ) THEN
	ll_WT = 0
END IF

ls_FormatedWT = string ( ll_WT, "00000" ) 
IF Len ( ls_FormatedWT) <> cl_wtlen THEN
	li_ReturnValue = -1
ELSE
	as_FormatedWT = ls_FormatedWT
END IF

RETURN li_ReturnValue 

end function

private function integer of_formatcharges (dec adec_Charges, ref string as_FormatedCharges);Int		li_ReturnValue = 1
String	ls_FormatedCharges
Dec {2}  ldec_Charges 

ldec_Charges = adec_Charges
IF isNull ( ldec_Charges ) THEN
	ldec_Charges = 0
END IF

ls_FormatedCharges = string ( ldec_Charges, "000000.00" ) 
IF Len ( ls_FormatedCharges) <> cl_chargeslen THEN
	li_ReturnValue = -1
ELSE
	as_FormatedCharges = ls_FormatedCharges
END IF

RETURN li_ReturnValue 

end function

private function integer of_formatequipnum (ref string as_equipmentnum);Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source


n_cst_string	lnv_String

ls_Source = as_equipmentNum


IF isNull ( ls_Source ) THEN
	ls_Source = ""
END IF

ls_ReturnString = lnv_String.of_PadRight ( ls_Source, cl_equiplen ) 

IF Len (ls_ReturnString) <> cl_equiplen THEN
	li_ReturnValue = -1
ELSE
	as_equipmentNum = ls_ReturnString
END IF

RETURN li_ReturnValue

end function

private function integer of_addfill (long al_len, ref string as_fill);String	ls_Fill
Int		li_ReturnValue = 1


n_cst_String	lnv_String

ls_Fill = lnv_String.of_PadRight( ls_Fill, al_Len )

IF Len ( ls_Fill ) <> al_len THEN
	li_ReturnValue = -1
ELSE
	as_Fill = ls_Fill
END IF
	

RETURN li_ReturnValue
end function

private function integer of_formateventcode (ref string as_eventcode);
String 	ls_ReturnString
String	ls_Source
Int		li_ReturnValue = 1

ls_Source = Upper ( as_EventCode )

Choose Case ls_Source
	CASE "P", "H", "M"        
		ls_ReturnString = "SF" // ship From
	CASE "D", "R" , "N"
		ls_ReturnString = "ST" // Ship Tp
	CASE ELSE
		ls_ReturnString = "  "
END CHOOSE

IF Len ( ls_ReturnString ) = 2 THEN
	li_ReturnValue = 1
	as_EventCode = ls_ReturnString
ELSE
	li_ReturnValue = -1
	as_EventCode = "  "
END IF

RETURN li_ReturnValue

end function

private function integer of_formatlocationcode (ref string as_LocationCode);Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source


n_cst_string	lnv_String

ls_Source = as_LocationCode


IF isNull ( ls_Source ) THEN
	ls_Source = ""
END IF

ls_ReturnString = lnv_String.of_PadRight ( ls_Source, cl_locCodeLen ) 

IF Len (ls_ReturnString) <> cl_locCodeLen THEN
	li_ReturnValue = -1
ELSE
	as_LocationCode = ls_ReturnString
END IF

RETURN li_ReturnValue

end function

private function integer of_formatname (ref string as_name);Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source

n_cst_string	lnv_String

ls_Source = as_name

IF isNull ( ls_Source ) THEN
	ls_Source = ""
END IF

ls_ReturnString = lnv_String.of_PadRight ( ls_Source,cl_namelen) 
IF Len (ls_ReturnString ) > cl_namelen THEN
	ls_ReturnString = MID ( ls_ReturnString , 1, cl_namelen )
END IF


IF Len (ls_ReturnString) <> cl_namelen THEN
	li_ReturnValue = -1
ELSE
	as_name = ls_ReturnString
END IF

RETURN li_ReturnValue

end function

private function integer of_formataddress (ref string as_Address);Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source

n_cst_string	lnv_String

ls_Source = as_Address

IF isNull ( ls_Source ) THEN
	ls_Source = ""
END IF

ls_ReturnString = lnv_String.of_PadRight ( ls_Source,cl_addlen) 
IF Len (ls_ReturnString ) > cl_addlen THEN
	ls_ReturnString = MID ( ls_ReturnString , 1, cl_addlen )
END IF

IF Len (ls_ReturnString) <> cl_addlen THEN
	li_ReturnValue = -1
ELSE
	as_Address = ls_ReturnString
END IF

RETURN li_ReturnValue

end function

private function integer of_formatstate (ref String as_State);Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source

n_cst_string	lnv_String

ls_Source = as_State

IF isNull ( ls_Source ) THEN
	ls_Source = ""
END IF

ls_ReturnString = lnv_String.of_PadRight ( ls_Source, cl_statelen) 

IF Len (ls_ReturnString) <> cl_statelen THEN
	li_ReturnValue = -1
ELSE
	as_State = ls_ReturnString
END IF

RETURN li_ReturnValue

end function

private function integer of_formatzip (ref string as_zip);Int		li_ReturnValue = 1
Int		i
String	ls_ReturnString
String	ls_Source
String	lsa_Result[]

n_cst_string	lnv_String

ls_Source = as_Zip

IF isNull ( ls_Source ) THEN
	ls_Source = ""
END IF

lnv_String.of_ParseToArray ( ls_Source ,"-" , lsa_Result )
IF UpperBound ( lsa_Result ) >= 1 THEN
	IF upperBound ( lsa_Result ) > 1 THEN
		For i = 1 TO UpperBound ( lsa_Result  )
			ls_ReturnString += lsa_Result[i]
		NEXT
	END IF
ELSE
	ls_ReturnString = ls_Source
END IF



ls_ReturnString = lnv_String.of_PadRight ( ls_Source, cl_ziplen) 

IF Len (ls_ReturnString) <> cl_ziplen THEN
	li_ReturnValue = -1
ELSE
	as_Zip = ls_ReturnString
END IF

RETURN li_ReturnValue

end function

private function integer of_formatcity (ref string as_city);Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source

n_cst_string	lnv_String

ls_Source = as_City

IF isNull ( ls_Source ) THEN
	ls_Source = ""
END IF

ls_ReturnString = lnv_String.of_PadRight ( ls_Source, cl_citylen ) 
IF Len (ls_ReturnString ) >cl_citylen THEN
	ls_ReturnString = MID ( ls_ReturnString , 1, cl_addlen )
END IF

IF Len (ls_ReturnString) <> cl_citylen THEN
	li_ReturnValue = -1
ELSE
	as_City = ls_ReturnString
END IF

RETURN li_ReturnValue

end function

private function integer of_formatqty (int ai_quantity, ref string as_formatedqty);Int		li_ReturnValue = 1
String	ls_FormatedQTY
Int		li_QTY

li_QTY = ai_quantity

IF isNull ( li_QTY ) THEN
	li_QTY = 0
END IF

ls_FormatedQTY = string ( li_QTY, "000000" ) 
IF Len ( ls_FormatedQTY ) <> cl_qtylen THEN
	li_ReturnValue = -1
ELSE
	as_FormatedQTY = ls_FormatedQTY
END IF

RETURN li_ReturnValue 


end function

private function integer of_getqty (readonly datawindow adw_source, integer ai_row, ref int ai_qty);ai_qty = 0
Return 1

end function

private function integer of_formatweightqual (ref string as_weightqual);
String 	ls_ReturnString
String	ls_Source
Int		li_ReturnValue = 1

ls_Source = Upper ( as_weightqual )

//Choose Case ls_Source
//	CASE         
//		ls_ReturnString =  
//	CASE 
//		ls_ReturnString = 
//	CASE ELSE
		ls_ReturnString = "  "
//END CHOOSE



IF Len ( ls_ReturnString ) = 2 THEN
	li_ReturnValue = 1
	as_weightqual = ls_ReturnString
ELSE
	li_ReturnValue = -1
	as_weightqual = "  "
END IF

RETURN li_ReturnValue

end function

private function integer of_formatdescription (ref string as_Description);Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source

n_cst_string	lnv_String

ls_Source = as_Description

IF isNull ( ls_Source ) THEN
	ls_Source = ""
END IF

ls_ReturnString = lnv_String.of_PadRight ( ls_Source, cl_desclen) 
IF Len (ls_ReturnString ) > cl_desclen THEN
	ls_ReturnString = MID ( ls_ReturnString , 1, cl_desclen )
END IF

IF Len (ls_ReturnString) <> cl_desclen THEN
	li_ReturnValue = -1
ELSE
	as_Description = ls_ReturnString
END IF

RETURN li_ReturnValue

end function

private function integer of_formatqtyqual (ref string as_qtyqual);
String 	ls_ReturnString
String	ls_Source
Int		li_ReturnValue = 1

ls_Source = Upper ( as_QtyQual )

//Choose Case ls_Source
//	CASE         
//		ls_ReturnString =  
//	CASE 
//		ls_ReturnString = 
//	CASE ELSE
		ls_ReturnString = "   "
//END CHOOSE



IF Len ( ls_ReturnString ) = 3 THEN
	li_ReturnValue = 1
	as_QtyQual = ls_ReturnString
ELSE
	li_ReturnValue = -1
	as_QtyQual = "   "
END IF

RETURN li_ReturnValue

end function

private function integer of_formatchargesqual (ref string as_Qual);

Int li_ReturnValue = 1

as_Qual = " " //1 space

IF Len ( as_Qual ) <> 1 THEN
	li_ReturnValue = -1
	as_Qual = " "
END IF

RETURN li_ReturnValue
	


end function

private function integer of_formatbillrateqty (decimal adec_rate, ref string as_formated);Int		li_ReturnValue = 1
String	ls_FormatedRate
Dec {5}  ldec_Rate

ldec_Rate = adec_Rate
IF isNull ( ldec_Rate ) THEN
	ldec_Rate = 0
END IF

ls_FormatedRate = string ( ldec_Rate, "000.00000" ) 
IF Len ( ls_FormatedRate) <> cl_billrateqtylen THEN
	li_ReturnValue = -1
ELSE
	as_Formated = ls_FormatedRate
END IF

RETURN li_ReturnValue 
end function

private function integer of_formatbillrtdqual (ref string as_Qual);
String 	ls_ReturnString
String	ls_Source
Int		li_ReturnValue = 1

ls_Source = Upper ( as_Qual )

//Choose Case ls_Source
//	CASE         
//		ls_ReturnString =  
//	CASE 
//		ls_ReturnString = 
//	CASE ELSE
		ls_ReturnString = "  "
//END CHOOSE



IF Len ( ls_ReturnString ) = 2 THEN
	li_ReturnValue = 1
	as_Qual = ls_ReturnString
ELSE
	li_ReturnValue = -1
	as_Qual = "  "
END IF

RETURN li_ReturnValue

end function

private function integer of_formatcommoditycode (ref string as_Code);Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source

n_cst_string	lnv_String

ls_Source = as_Code 

IF isNull ( ls_Source ) THEN
	ls_Source = ""
END IF

ls_ReturnString = lnv_String.of_PadRight ( ls_Source, cl_nmfclen) 

IF Len (ls_ReturnString ) > cl_nmfclen THEN
	ls_ReturnString = MID ( ls_ReturnString , 1, cl_nmfclen)
END IF


IF Len (ls_ReturnString) <> cl_nmfclen THEN
	li_ReturnValue = -1
ELSE
	as_Code = ls_ReturnString
END IF

RETURN li_ReturnValue

end function

private function integer of_formatreasoncode (ref string as_code);
String 	ls_ReturnString
String	ls_Source
Int		li_ReturnValue = 1

ls_Source = Upper ( as_code )

//Choose Case ls_Source
//	CASE         
//		ls_ReturnString =  
//	CASE 
//		ls_ReturnString = 
//	CASE ELSE
		ls_ReturnString = "  "
//END CHOOSE



IF Len ( ls_ReturnString ) = 2 THEN
	li_ReturnValue = 1
	as_code = ls_ReturnString
ELSE
	li_ReturnValue = -1
	as_code = "  "
END IF

RETURN li_ReturnValue

end function

private function integer of_formatfreightclass (ref string as_class);Int		li_ReturnValue = 1
String	ls_ReturnString
String	ls_Source

n_cst_string	lnv_String

ls_Source = as_class

IF isNull ( ls_Source ) THEN
	ls_Source = ""
END IF

ls_ReturnString = lnv_String.of_PadRight ( ls_Source,cl_freightlen) 
IF Len (ls_ReturnString ) > cl_freightlen THEN
	ls_ReturnString = MID ( ls_ReturnString , 1, cl_freightlen )
END IF

IF Len (ls_ReturnString) <> cl_freightlen THEN
	li_ReturnValue = -1
ELSE
	as_class = ls_ReturnString
END IF

RETURN li_ReturnValue

end function

private function integer of_formattradingpartner (readonly long al_coid, ref string as_formated);Int		li_ReturnValue = 1
Int		li_CacheRtn
String	ls_ReturnString
String	ls_Source


n_cst_Beo_Company	lnv_Company
n_cst_string	lnv_String

li_CacheRtn = lnv_Company.of_SetUseCache ( TRUE ) 

lnv_Company.of_SetSourceid ( al_coid )

ls_Source = lnv_Company.of_GetCodeName ( )

IF isNull ( ls_Source ) THEN
	ls_Source = ""
//	li_ReturnValue = -1
END IF

ls_ReturnString = lnv_String.of_PadRight ( ls_Source, cl_tplen) 

IF Len (ls_ReturnString ) > cl_tplen THEN
	ls_ReturnString = MID ( ls_ReturnString , 1, cl_tplen )
END IF


IF Len (ls_ReturnString) <> cl_tplen THEN
	li_ReturnValue = -1
ELSE
	as_Formated = ls_ReturnString
END IF

RETURN li_ReturnValue

end function

private subroutine of_getrecord1 (long al_row, ref string asa_column[], ref string asa_text[]);/*
             RECORD 1 - THE INVOICE SUMMARY RECORD,
                         INFORMATION PERTAINING TO THE
                         ENTIRE SHIPMENT

         RECID                         string (1).    ! VALUE 1
         INVOICE NUMBER (PRO)          string (22).
         METHOD OF PAYMENT		         string (2).    ! PP, CC, TP
			SHIP DATE							string (8).    ! YYYYMMDD
         BILLING DATE                  string (8).    ! YYYYMMDD
         SHIPMENT-WEIGHT               string (5).		00000
         TOTAL-CHARGE                  string (7). ! "0010025"   $100.25
			BANK CLIENT							string (1)	C2
			ID CODE TYPE						string (2)	C2
			CLIENT NUMBER						STRING (4)	C2
			POD RECEPIENT						STRING (35)	

// RDT 7-08-03 Added Shipment number Shipment Number & Deliver Date 
			Shipment Number					STRING (30) 	
			Deliver Date						STRING (8) 	!YYYYMMDD
			
// RDT 7-08-03
asa_Text[13] = String( ld_DelDate, "YYYYMMDD" )

// RDT 8-25-03 Use the SHIPPERNUMBER as the shipment number if it exists.

*/

long	ll_totweight

integer	lia_CoId[]

decimal	lc_TotCharge

date		ld_BillDate, &
			ld_ShipDate, &
			ld_DelDate
			
string	lsa_blank[], &
			ls_ppcol, &
			ls_invoicenumber, &
			ls_formated, &
			lsa_value[], &
			ls_ref

asa_column = lsa_blank
asa_text = lsa_blank


asa_column = {&
					"RECID", &
					"INVOICE-NUMBER", &
					"METHOD OF PAYMENT", &
					"SHIP DATE", &
					"BILLING DATE", &
					"SHIPMENT-WEIGHT", &
					"TOTAL-CHARGE", &
					"CLIENT", &
					"ID CODE TYPE", &
					"CLIENT NUMBER", &
					"POD RECEPIENT"}
					
if integer(idw_invoice.object.nr_itin[al_Row].object.datawindow.firstrowonpage) > 0 then
	lia_CoID = idw_invoice.object.nr_itin[al_Row].object.de_site.primary
	IF upperbound(lia_CoID) > 0 THEN
		ld_DelDate = idw_invoice.object.nr_itin[al_row].object.de_arrDate[UpperBound ( lia_CoID )]
	END IF
END IF	
					
ld_BillDate	=	idw_invoice.object.ds_bill_date[al_row]
ld_ShipDate = idw_invoice.object.nr_itin[al_row].object.de_arrDate[1]
ls_invoicenumber = idw_invoice.object.ds_proNum[al_row] 
ll_TotWeight = idw_invoice.object.ds_Total_Weight[al_row]
lc_TotCharge = idw_invoice.object.ds_bill_Charge[al_row]
ls_ppcol = idw_invoice.object.ds_ppcol[al_row]

asa_text[1] = "01"

IF THIS.OF_FormatInvoiceNum ( ls_invoicenumber) = 1  THEN
	asa_text[2] = ls_invoicenumber
END IF

IF THIS.OF_FormatPPcol ( ls_PPCol ) = 1  THEN
	asa_text[3] = ls_ppcol
END IF

asa_text[4] = string(ld_shipdate, "yyyymmdd")

asa_text[5] = string(ld_Billdate, "yyyymmdd")

IF THIS.OF_FormatWeight ( ll_TotWeight, ls_formated ) = 1  THEN
	asa_text[6] = ls_formated
END IF

IF THIS.OF_FormatCharges ( lc_TotCharge, ls_formated ) = 1  THEN
	asa_text[7] = ls_formated
END IF

if this.of_mapdataout("BANKCLIENT", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[8] = ls_ref

if this.of_mapdataout("IDCODETYPE", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[9] = ls_ref

if this.of_mapdataout("CLIENTNUMBER", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[10] = ls_ref

if this.of_mapdataout("PODRECEPIENT", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[11] = ls_ref

// RDT 7-08-03 
//asa_Text[12] = String( idw_invoice.object.cf_tmp[al_row] )

// RDT 8-25-03 -Start
If this.of_mapdataout("SHIPPERNUMBER", lsa_value) > 0 then
	ls_ref = lsa_value[1]
Else
	ls_ref = ''
End if

//If len( ls_Ref ) < 1 OR IsNull( ls_Ref ) Then 
//	ls_Ref = idw_invoice.object.edireference[al_row] 
//End if

If len( ls_Ref ) < 1 OR IsNull( ls_Ref ) Then 
	// ERROR. No ShipperNumber mapped or identified.
Else
	asa_Text[12] = ls_Ref 
End If
// RDT 8-25-03 -End


// RDT 7-08-03
asa_Text[13] = String( ld_DelDate, "YYYYMMDD" )
end subroutine

private subroutine of_getrecord2 (long al_row, ref string asa_column[], ref string asa_text[]);/*
              RECORD 2 - DATE RECORD(S)
              CUSTOMARILY 1 IS SUPPLIED PER DATE

				RECID						string (1)    VALUE 2
	         DATE                 string (8).    ! YYYYMMDD
	         DATE QUALIFIER   		string (3).   
				
DELIVERY = 035
PICKUP = 086

*/
string	lsa_blank[], &
			lsa_value[], &
			ls_ref

asa_column = lsa_blank
asa_text = lsa_blank


asa_column = {&
					"RECID", &
					"DATE", &
					"DATE QUALIFIER"}
					
asa_text[1] = "02"

if this.of_mapdataout("210DATE", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[2] = ls_ref

if this.of_mapdataout("210DATEQUALIFIER", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[3] = ls_ref



end subroutine

private subroutine of_getrecord5 (long al_row, ref string asa_column[], ref string asa_text[]);/*
              RECORD 5 - THE LINE ITEM RECORD(S)
              CUSTOMARILY 1 IS SUPPLIED PER LINE ITEM CHARGE

         RECID                    string (1).   ! VALUE 5
			ASSIGNED NUMBER			 STRING (4)
         LINE-WEIGHT              string (5).	00000
         WEIGHT-QUALIFIER         string (1).   ! "G" GROSS, "N"  NET
         DESCRIPTION              string (20).
         LINE-QUANTITY            string (6).	000000
         LINE-CHARGE              string 7.		0010025	100.25
         BILLED-RATED-QUANTITY    string (5).	00000
         RATE                     string 7.		0010025	100.25
         RATE-QUALIFIER           string (2).   ! "PM" PER MILE, "LB" PER POUND
         NMFC                     string (7).   ! NATIONAL MOTOR FREIGHT CLASS
         FREIGHT-CLASS            string (7).


RATE QUALIFIER - 
PH = PER HUNDRED
PM = PER MILE
PG = PER GALLAON
PU = PER UNIT
PF = PER CUBIC FOOT
MN = MINIMUM

*/


string	lsa_blank[], &
			lsa_value[], &
			ls_ref
			
long		ll_count, &
			ll_index
			
n_cst_bso_rating	lnv_rating

asa_column = lsa_blank
asa_text = lsa_blank

asa_column = {&
					"RECID", &
					"ASSIGNEDNUMBER", &
					"LINEWEIGHT", &
					"WEIGHTQUALIFIER", &
					"DESCRIPTION", &
					"LINEQUANTITY", &
					"LINECHARGE", &
					"BILLEDRATEDQUANTITY", &
					"RATE", &
					"RATEQUALIFIER", &
					"NMFC", &
					"FREIGHTCLASS"}

lnv_Rating = CREATE n_cst_bso_Rating  //Will be used for getting rate type display values


/*
	This is not the best way to process multiple lines but I don't
	have time to finish it.  of_mapdataout should pass back a msg object
	which contains an array of values for all of the rows for a multiple row beo.
	For now this method is going to get the number of beos and call the overloaded
	of_mapdataout with a row loop.
*/

ll_count = upperbound(inva_item)
for ll_index = 1 to 1
	
	asa_text[1] = "05"

	asa_text[2] = string(ll_index)
	
	if this.of_mapdataout(ll_index, "LINEWEIGHT", lsa_value) > 0 then
		ls_ref = lsa_value[1]
	else
		ls_ref = ''
	end if
	
	asa_text[3] = ls_ref


	if this.of_mapdataout(ll_index, "WEIGHTQUALIFIER", lsa_value) > 0 then
		ls_ref = lsa_value[1]
	else
		ls_ref = ''
	end if
	
	asa_text[4] = ls_ref

	if this.of_mapdataout(ll_index, "DESCRIPTION", lsa_value) > 0 then
		ls_ref = lsa_value[1]
	else
		ls_ref = ''
	end if
	
	asa_text[5] = ls_ref

	if this.of_mapdataout(ll_index, "LINEQUANTITY", lsa_value) > 0 then
		ls_ref = lsa_value[1]
	else
		ls_ref = ''
	end if
	
	asa_text[6] = ls_ref

	if this.of_mapdataout(ll_index, "LINECHARGE", lsa_value) > 0 then
		ls_ref = lsa_value[1]
	else
		ls_ref = ''
	end if
	
	asa_text[7] = ls_ref

	if this.of_mapdataout(ll_index, "BILLEDRATEDQUANTITY", lsa_value) > 0 then
		ls_ref = lsa_value[1]
	else
		ls_ref = ''
	end if
	
	asa_text[8] = ls_ref

	if this.of_mapdataout(ll_index, "RATE", lsa_value) > 0 then
		ls_ref = lsa_value[1]
	else
		ls_ref = ''
	end if
	
	asa_text[9] = ls_ref

	if this.of_mapdataout(ll_index, "RATEQUALIFIER", lsa_value) > 0 then
		//getratetype()
		ls_ref = lnv_Rating.of_GetUnitLabel ( lsa_value[1] )
		ls_ref = lsa_value[1]
	else
		ls_ref = ''
	end if
	
	asa_text[10] = ls_ref

	
	if this.of_mapdataout(ll_index, "NMFC", lsa_value) > 0 then
		ls_ref = lsa_value[1]
	else
		ls_ref = ''
	end if
	
	asa_text[11] = ls_ref

	if this.of_mapdataout(ll_index, "FREIGHTCLASS", lsa_value) > 0 then
		ls_ref = lsa_value[1]
	else
		ls_ref = ''
	end if
	
	asa_text[12] = ls_ref

	this.of_writeToTransactionDatastore(asa_column, asa_text)

next

destroy lnv_rating

end subroutine

private subroutine of_getrecord6 (long al_row, ref string asa_column[], ref string asa_text[]);/*
              RECORD 6 - EQUIPMENT INFORMATION
              CUSTOMARILY 1 IS SUPPLIED FOR EACH PIECE OF EQUIPMENT

         RECID                         string (1).   ! VALUE 6
         INITIAL 				            string (4).   
         NUMBER            				string (10).
         WEIGHT                       	string (10).
         WEIGHT QUALIFIER              string (2).  G - GROSS, N - NET WEIGHT
         CHECK DIGIT                   string (1).


*/


string	lsa_blank[], &
			lsa_value[]
			
long		ll_count, &
			ll_index, &
			ll_eventid, &
			ll_id
			
boolean	lb_foundid

n_cst_beo_equipment2	lnva_equipment[]
n_cst_beo_shipment	lnv_shipment

asa_column = lsa_blank
asa_text = lsa_blank

asa_column = {&
					"RECID", &
					"INITIAL", &
					"NUMBER", &
					"WEIGHT", &
					"WEIGHT QUALIFIER ", &
					"CHECK DIGIT"}

this.of_getshipmentbeo(lnv_shipment)
if isvalid(lnv_shipment) then
	ll_count = 	lnv_shipment.of_getequipmentlist(lnva_equipment)
	for ll_index = 1 to ll_count
		lsa_value[ll_index] =lnva_equipment[ll_index].of_getnumber()
	next
	
end if

for ll_index = 1 to ll_count
	asa_text = lsa_blank

	asa_text[1] = "06"
	asa_text[2] = ""
	asa_text[3] = lsa_value[ll_index]
	asa_text[4] = ""
	asa_text[5] = ""
	asa_text[6] = ""
	this.of_writeToTransactionDatastore(asa_column, asa_text)
	
next


end subroutine

public subroutine of_loadtransactions (ref n_cst_msg anv_msg);//multiple status records ( record 3)  can be sent with record 1 and 2
// RDT 7-24-03 Remove ":" from header line 
// RDT 8-05-03 Change "#SHIPMENTS" to "#INVOICES" on header line
/* RDT 8-25-03 Added validation section 
					If no message parm is passed, validation will not be done.
					Only one process will be done, Validate or create, not both.
*/

long	ll_RowCount, &
		ll_ndx, &
		ll_holdbilltoid, &
		ll_holdship, &
		ll_test, &
		ll_event, &
		ll_companyid, &
		ll_Billtoid
		
			
string	lsa_column[], &
			lsa_text[], &
			lsa_blank[], &
			ls_edi210code, &
			ls_which, &
			ls_Filter

Boolean 	lb_Validate 
			
n_cst_beo_Company	lnv_Company
n_cst_beo_item		lnva_Emptyitem[]

s_parm				lstr_parm

n_cst_string		lnv_String  // RDT 7-24-03 

//RDT 8-25-03 - validation section  Start
If anv_msg.of_Get_Parm ( "VALIDATE" , lstr_Parm ) <> 0 Then
	lb_Validate = lstr_parm.ia_Value
Else
	lb_Validate = FALSE
End If

IF lb_Validate Then 

	This.of_Validate( anv_msg ) 
	
Else
	//RDT 8-25-03 - validation section End 
	
	lnv_Company	= CREATE n_cst_beo_company
	
	if isValid (anv_msg ) THEN
		If anv_msg.Of_Get_Parm ( "SOURCE" , lstr_Parm ) <> 0 THEN
			idw_invoice = lstr_Parm.ia_Value
		End If
	end if
	
	if this.of_getsystemfilepath("EDI210", is_path) = 1 then
	end if
	
	if this.of_CacheDatamapping() > 1 then
		ls_Filter = "transfertype = 'EDI210'"
		this.of_FilterDatamappingCache( ls_Filter )
//		this.of_FilterDatamappingCache("EDI210")
	end if
	
	this.of_SetDatamappingdirection('O')	//output
	
	ll_RowCount = idw_invoice.RowCount()
	ids_transaction = this.of_createdatastore(14)
		
	if ll_RowCount > 0 then
		
//commented because it messes up the nr_itin
		//sort by billto
//		idw_invoice.setsort('ds_billto_id A')
//		idw_invoice.sort()
		
		for ll_ndx = 1 to ll_rowcount
		
			//break on billto_id, seperate file for each billto_id
			ll_Billtoid = idw_invoice.object.ds_billto_id[ll_ndx]
			If ll_holdbilltoid <> ll_billtoid then
				
				gnv_cst_Companies.of_Cache ( ll_Billtoid, FALSE )
				lnv_Company.of_SetUseCache ( TRUE )
				lnv_Company.of_SetSourceId (ll_Billtoid)
				ls_EDI210code = lnv_Company.of_GetEDI210Code ( )

				if len(trim(ls_edi210code)) = 0 then
					CONTINUE
				end if
				//write file 
				if ids_transaction.rowcount() > 0 then
					this.of_getTrailerRecord(lsa_column, lsa_text)
					this.of_writeToTransactionDatastore(lsa_column, lsa_text)
					//save as tab delimited
					if ids_transaction.SaveAs ( is_path + is_controlnumber + ".txt", Text!, FALSE) = 1 then
					end if
				end if
				//set up new shipper
				ids_transaction.reset()
				
			End if
			
			//break on ds_id
			ll_test = idw_invoice.object.ds_id[ll_ndx]
			if isnull(ll_test) then continue
			if ll_holdship <> ll_test then
				ll_holdship = ll_test
				
				//shipment header
				inva_item = lnva_Emptyitem
				if this.of_loadshipment(ll_holdship) = -1 then
					CONTINUE
				end if
				
				//this.of_SetEDICompanyId(ls_EDI210code) 	//RDT 8-26-03 
				this.of_SetEDICompanyId(ll_Billtoid) 		//RDT 8-26-03 
				
				this.of_getHeaderRecord(lsa_column, lsa_text, ls_edi210code)
	
				lsa_text[1] = lnv_string.of_globalreplace ( lsa_text[1], ":", "")							// RDT 7-24-03 
				lsa_text[1] = lnv_string.of_globalreplace ( lsa_text[1], "#SHIPMENTS", "#INVOICES")	// RDT 8-05-03 
				
				this.of_writeToTransactionDatastore(lsa_column, lsa_text)
				this.of_getrecord1(ll_ndx,lsa_column,lsa_text)
				this.of_writeToTransactionDatastore(lsa_column, lsa_text)
			end if
			
			//dates
			this.of_getrecord2(ll_ndx, lsa_column,lsa_text)
			this.of_writeToTransactionDatastore(lsa_column, lsa_text)
	
			//reference #s
			this.of_getrecord3(ll_ndx,lsa_column,lsa_text, ls_which)
			this.of_writeToTransactionDatastore(lsa_column, lsa_text)
			
			//name and address
			this.of_getrecord4(ll_ndx,lsa_column,lsa_text, ls_which)
			this.of_writeToTransactionDatastore(lsa_column, lsa_text)
	
			//line item
			this.of_getrecord5(ll_ndx,lsa_column,lsa_text)
	
			//equipment info
			this.of_getrecord6(ll_ndx,lsa_column,lsa_text)
	
		next
		
		//last file
		If ids_transaction.rowcount() > 0 then
			this.of_getTrailerRecord(lsa_column, lsa_text)
			this.of_writeToTransactionDatastore(lsa_column, lsa_text)
			//save as tab delimited
			if ids_transaction.SaveAs ( is_path + is_controlnumber + ".txt", Text!, FALSE) = 1 then
			end if
		End if
	
	End if //rowcount > 0
	
	if isvalid(lnv_Company) then
		destroy lnv_Company
	end if
	
End If //RDT 8-25-03
end subroutine

private subroutine of_getrecord3 (long al_row, ref string asa_column[], ref string asa_text[], string as_reftype);/*
              RECORD 3 - REFERENCE NUMBER RECORD(S)

         RECID                         string (1).   ! VALUE 3
         QUALIFIER                     string (2).
         NUMBER	                     string (30).

PO  
RZ = RMA
ZZ = MUTUALLY DEFINED  (CARRIER FOR NTS)
EQ = TRAILER
BN = BOOKING
SI = SID
V3 = VESSEL
BM = BILL OF LADING
IO = INBOUND - TO OR OUTBOUND-FROM PARTY



	Get all 3 ref fields and vessel, voyage, booking, 
*/
any		laa_beo[]

string	lsa_blank[], &
			ls_ref, &
			lsa_value[]

asa_column = lsa_blank
asa_text = lsa_blank

asa_column = {&
					"RECID", &
					"QUALIFIER", &
					"NUMBER"}

asa_text[1] = "03"

if this.of_mapdataout("210REFQUALIFIER", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[2] = ls_ref

if this.of_mapdataout("210REFERENCE", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[3] = ls_ref


end subroutine

private subroutine of_getrecord4 (long al_row, ref string asa_column[], ref string asa_text[], string as_which);/*
              RECORD 4 - THE NAME AND ADDRESS RECORD(S)
              CUSTOMARILY 1 IS SUPPLIED FOR EACH (CODES "SH", "CN", "BT")

         RECID                         string (1).   ! VALUE 4
         CODE                          string (2).   ! "SH" SHIPPER, "CN" CONSIGNEE
         NAME                          string (35).
         ADDRESS                       string (35).
         STATE                         string (2).
         CITY                          string (30).
         ZIP                           string 9).
         LOCATION-CODE (IF NECESSARY)  string (20).  ! PLANT CODE, STORE NUMBER,

*/
string	lsa_blank[], &
			lsa_value[], &
			ls_ref

asa_column = lsa_blank
asa_text = lsa_blank

asa_column = {&
					"RECID", &
					"CODE", &
					"NAME", &
					"ADDRESS", &
					"STATE", &
					"CITY", &
					"ZIP", &
					"LOCATION-CODE"}

asa_text[1] = "04"

if this.of_mapdataout("210NAMECODE", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[2] = ls_ref

if this.of_mapdataout("210NAME", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[3] = ls_ref

if this.of_mapdataout("210ADDRESS", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[4] = ls_ref

if this.of_mapdataout("210STATE", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[5] = ls_ref

if this.of_mapdataout("210CITY", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[6] = ls_ref

if this.of_mapdataout("210ZIP", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[7] = ls_ref

if this.of_mapdataout("210LOCATIONCODE", lsa_value) > 0 then
	ls_ref = lsa_value[1]
else
	ls_ref = ''
end if

asa_text[8] = ls_ref


end subroutine

public function integer of_validate (ref n_cst_msg anv_msg);// RDT 8-25-03 
// for each shipment check for required fields
Integer	li_Return = 1, &
			li_Error = 0, &
			li_Required_Index, &
			li_Required_Upper

Long		ll_Index, &
			ll_Upper, &
			lla_ShipID[], &
			ll_BillToId 
			
String 	ls_ref, &
			lsa_Value[], &
			ls_Error = "EDI 210 Errors:", &
			ls_EDI210code , &
			ls_Filter
			
String	lsa_Required[]

li_Required_Upper ++
lsa_Required[ li_Required_Upper ] = "SHIPPERNUMBER"

li_Required_Upper ++
lsa_Required[ li_Required_Upper ] = "SCAC"


//n_cst_msg 	lnv_msg
s_parm		lstr_Parm
n_ds  		lds_shipbillinfo

n_cst_beo_company		lnv_Company	

// get ids from message object
IF anv_msg.of_Get_Parm ( "IDS" , lstr_Parm ) <> 0 THEN
	lla_ShipId[]= lstr_Parm.ia_Value
Else
	// "No Id's to validate"
	li_Return = -1
End If	

IF li_Return = 1 then 

	lds_shipbillinfo = Create n_ds
	lds_shipbillinfo.DataObject = "d_shipmentbillinginfo"
	lds_shipbillinfo.SetTransObject( SQLCA ) 
	
	ll_Upper = UpperBound( lla_ShipId )
	if this.of_getsystemfilepath("EDI210", is_path) = 1 then
	end if

	if this.of_CacheDatamapping() > 1 then
		ls_Filter = "transfertype = 'EDI210'"
		this.of_FilterDatamappingCache( ls_Filter )
	end if

	This.of_setdatamappingdirection ( "O" )
			
	// loop thru each shipment id and validate 
	If li_Return = 1 then 
		
		For ll_Index = 1 to ll_Upper

			lds_shipbillinfo.Retrieve( lla_ShipId[ll_index] )
			
			// get the bill to id for the shipment
			ll_BillToId = lds_shipbillinfo.GetItemNumber(lds_shipbillinfo.GetRow(), "ds_billto_id")
			
			This.of_SetEdiCompanyID ( ll_BillToId )
			
			if this.of_loadshipment(lla_ShipId[ll_index] ) = -1 then
				CONTINUE
			end if

			For li_Required_Index = 1 to li_Required_Upper
				
				If this.of_mapdataout(lsa_Required[li_Required_index] , lsa_value) > 0 then
					ls_ref = lsa_value[1]
//					Messagebox("RICH","BilltoID: "+string ( ll_BillToId ) +"~nShip id: " + String(lla_ShipId[ll_index] ) +" ~nmapdataout = "+ lsa_Required[li_Required_index] +": "+ls_ref)
				Else
					SetNull( ls_ref )
				End if

				If len( Trim( ls_Ref ) ) < 1 OR IsNull( ls_Ref ) Then 
					ls_Error += "~n"+String( lla_ShipId[ll_index] ) + " Missing "+ lsa_Required[li_Required_index] 
					li_Error ++ 
				End If
				
			Next // lsa_required[]
		
		Next // lla_ShipId[]
	
	End If	
	
	If li_Error > 0  Then 
	
		lstr_Parm.is_Label = "210ERROR" 
		lstr_Parm.ia_Value = ls_Error
		anv_Msg.of_Add_Parm ( lstr_Parm )
		li_Return = -1
	
	End If	
	
	Destroy ( lds_shipbillinfo ) 
	
END IF 


Return	li_Return
end function

public subroutine of_sendtransaction (long ala_id[]);
long		ll_row, &
			ll_rowcount, &
			ll_shipid, &
			ll_ediid, &
			ll_coid, &
			lla_coid[], &
			ll_CompanyCount, &
			ll_Pos, &
			ll_Index, &
			ll_count
			
Integer	li_InputFile

string	ls_filter, &
			ls_outputfolder, &
			ls_outputfile, &
			ls_templatefile, &
			ls_value, &
			ls_error, &
			ls_ControlNumber, &
			lsa_TemplateArray[], &
			lsa_TemplateHeader[], &
			lsa_TemplateFooter[], &
			lsa_transaction[], &
			lsa_results[], &
			lsa_blank[]
			
			
Long		ll_CoIndex
boolean	lb_error

n_cst_AnyArraySrv	lnv_Arraysrv
n_cst_sql			lnv_Sql
n_ds					lds_edistatus
s_parm 				lstr_parm	
n_cst_msg			lnv_tagmessage, &
						lnv_BlankMessage
				
lds_edistatus = this.of_GetEDICache(false)

if upperbound(ala_id) > 0 then
	ls_filter = "transactionset = 210 and id" + lnv_sql.of_makeinclause(ala_id)
else
	ls_filter = "transactionset = 210 and isnull(processeddate)"
end if

lds_edistatus.setfilter(ls_filter)
lds_edistatus.filter()

ls_controlnumber = this.of_GetControlNumber()

ll_rowcount = lds_edistatus.rowcount()

//	load company id array, shrink array to unique ids, 
//	loop thru companies filtering datastore to the company and 
//	create a seperate file for each company
for ll_row = 1 to ll_rowcount
	lla_coid[ll_row] = lds_edistatus.object.company[ll_row]
next

ll_CompanyCount = lnv_ArraySrv.of_getshrinked( lla_coid, true, true) 

for ll_CoIndex = 1 to ll_CompanyCount
	
	ls_outputfile = ""
	lsa_results = lsa_blank
	//set up next company file
	
	ls_filter = "transactionset = 210 and company = " + string(lla_coid[ll_CoIndex])
	lds_edistatus.setfilter(ls_filter)
	lds_edistatus.filter()
	
	
	
	if lds_edistatus.rowcount() > 0 then
		ll_coid =  lds_edistatus.object.company[1]
		ll_ediid = lds_edistatus.object.id[1]
	else
		CONTINUE
	end if
	
	THIS.of_Setedicompanyid( ll_Coid )
	ls_controlnumber = this.of_GetControlNumber()	
		
	ls_outputfolder = this.of_GetOutputFolder( n_cst_bso_edimanager.cl_transaction_set_210, ll_coid, "OUTBOUND" )
	
	if len(trim(ls_outputfolder)) > 0 then
		//ok
	else
		if this.of_getsystemfilepath("EDI210", ls_outputfolder) = 1 then
			//ok
		else
			lb_error = true
			ls_error = "No output folder in company profile or system settings. Message not sent"
		end if
	end if
			
	
	//get the file	
	ls_templatefile = this.of_GetTemplateFile( n_cst_bso_edimanager.cl_transaction_set_210, ll_coid, "OUTBOUND" )
		
	//Read template file and load into array
	if FileExists ( ls_templatefile ) then	
		//input file, read
		li_InputFile = FileOpen(ls_templatefile, LineMode!, Read!, Shared!)
		THIS.of_loadtemplateintoarray( li_InputFile , lsa_TemplateArray, lsa_TemplateHeader, lsa_TemplateFooter )
		Fileclose(li_InputFile)
	ELSE
		CONTINUE
	END IF
	
	ll_RowCount = lds_edistatus.RowCount ( )
	
	//loop thru all rows for this company
	for ll_row = 1 to ll_rowcount
		
		lb_error = false
		ls_error = ''	
		lsa_transaction = lsa_blank
		lnv_tagmessage = lnv_BlankMessage	
		ll_shipid = lds_edistatus.object.sourceid[ll_row]
		ll_ediid = lds_edistatus.object.id[ll_row]
				
		this.of_LoadShipment(ll_ShipId)
		
		inv_Shipment.of_Setcontextcompany( ll_coid ) // this is used to resolve aliases (i thought I had put this in once before but I Guess not)
		
		ls_value = string(inv_Shipment.of_getNetcharges( ))
		ll_pos = pos(ls_value,'.')
		ls_value = replace(ls_value,ll_pos,1,'')
		
		lstr_parm.is_Label = "NETCHARGENODECIMAL"			
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
			
		//Set additional tag values 
		this.of_GetHeaderFooterTags(lnv_TagMessage)

		lstr_parm.is_Label = "CONTROLNUMBER"
		lstr_Parm.ia_Value = ls_controlnumber
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
		
		//DEK 5-23-07 NEW TAG
		lstr_parm.is_Label = "CONTROLNUMBERNOLEADINGZEROS"
		lstr_Parm.ia_Value = STRING(LONG(ls_controlnumber))
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )	

		lstr_parm.is_Label = "TRANSACTIONCONTROLNUMBER"
		lstr_Parm.ia_Value = string(ll_row, '0000')
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
	

		//replace this
//			this.of_Createfile( ls_templatefile, ls_outputfolder, ls_outputfile, {inv_Shipment}, lnv_tagmessage )

		//with this
		
		if ll_row = 1 then 
			//start with header
			THIS.of_Processloop( lsa_TemplateHeader , lsa_transaction , lnv_TagMessage , inv_Shipment )
			ll_count = upperbound(lsa_transaction)
			for ll_index = 1 to ll_count
				lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
			next			
		end if
		
		THIS.of_Processloop( lsa_TemplateArray , lsa_transaction , lnv_TagMessage , inv_Shipment )
		//move to the results array
		ll_count = upperbound(lsa_transaction)
		for ll_index = 1 to ll_count
			lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
		next
		
		this.of_ProcessedEDI(ll_EDIId, ls_error)
		
	next
	//end of rows for this company
	
	//processloopelements
	THIS.of_Processloop( lsa_TemplateFooter , lsa_transaction , lnv_TagMessage , inv_Shipment )
	ll_count = upperbound(lsa_transaction)
	for ll_index = 1 to ll_count
		lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
	next			
	
	//create results file
	if len(trim(ls_outputfile)) = 0 then
		if isvalid(lnv_TagMessage) then
			IF lnv_TagMessage.Of_Get_Parm ( "CONTROLNUMBER" , lstr_Parm ) <> 0 THEN
				ls_controlnumber = string(lstr_Parm.ia_Value)
			END IF
		
		end if
		//ls_outputfile = ls_controlnumber + ".txt"
		//if they have a specified schema, this will create  a file name for it
		ls_outputFile = this.of_getEditransactionfilename( inv_Shipment, ls_controlNumber )
		IF isNull( ls_outputFile ) OR ls_outputfile = "" THEN
			ls_outputfile = ls_controlnumber + this.of_GetOutboundfileextension( )
		END IF
	end if
	
	ls_outputfile = ls_outputfolder + "\" + ls_outputfile
	
	THIS.of_Writeresultstofile( lsa_Results , ls_outputfile )
	
next

this.of_updateedicache( )

destroy lds_edistatus


end subroutine

protected function string of_getoutboundmappingfile ();Long	ll_RowCount
String	ls_File
Long		ll_CoID

DataStore	lds_Mappings
lds_Mappings = CREATE DataStore

lds_Mappings.DataObject = "d_mappingfiles"
lds_Mappings.SetTransobject ( SQLCA )

ll_CoID = THIS.of_GetEdicompanyid( )

IF ll_CoID > 0 THEN
	ll_RowCount = lds_Mappings.Retrieve ( ll_CoID , 210 )
	
	IF ll_RowCount> 0 THEN
		
		ls_File = lds_Mappings.GetItemString ( 1 , "MappingFile" )
		
	END IF
END IF

DESTROY ( lds_Mappings )

RETURN ls_File
end function

public function long of_get210companies (ref long ala_ids[]);DataStore	lds_Companies
lds_Companies = THIS.of_Getprofile()

Long	lla_CoIds[]
Long	ll_Count
Long	i

String	ls_Filter 

ls_Filter = "transactionset = 210 And Not ( IsNull( template ) OR IsNull (Folder ) )"
lds_Companies.SetFilter ( ls_Filter ) 
lds_Companies.Filter ( ) 

ll_Count = lds_Companies.RowCount ( )

FOR i = 1 TO ll_Count
	
	lla_CoIds[i] = lds_Companies.object.CompanyID[i]
	
	
NEXT

ala_ids[] = lla_CoIds

RETURN ll_Count
end function

public function string of_geterrorcontext (long ala_ids[]);Long	ll_index
Long	ll_max
Long	lla_ids[]
String	ls_return

THIS.of_getidsfromcache( lla_ids, this.of_getidcolname( ) )

ls_return =  String(Today(), "m/d/yy hh:mm")+"~r~nCould not send 210. Fix errors and resend. ~r~nFind one of the shipments in the batch through the search menu,~r~nand click the current menu to resend, or click troubleshoot.~r~n"

ll_max = upperBOund(lla_ids)
FOR ll_index = 1 TO ll_max
	IF ll_index = 1 THEN
		ls_return += "    Relevent Shipment ids: "+ string( lla_ids[ll_index] )
	ELSE
		ls_return += " "+ string( lla_ids[ll_index] )
	END IF
NEXT
RETURN ls_return

end function

public function string of_getremedyobjectstring ();return "n_cst_errorremedy_edi_210"
end function

public subroutine of_createtransaction (ref n_ds ads_edipending, ref long ala_ediid[], ref long ala_sourceid[]);//check for edi updates to company

long	ll_shipid, &
		ll_coId, &
		ll_row, &
		ll_count, &
		ll_rowcount, &
		ll_newrow, &
		ll_nextid, &
		ll_return=1
		
CONSTANT Boolean cb_Commit	= TRUE	

n_ds						lds_EDICache	
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_shipment	lnv_shipment

lnv_Dispatch = Create n_cst_bso_Dispatch		
lnv_Shipment = CREATE n_cst_beo_Shipment

lds_EDICache = this.of_GetEDICache(false)
		
ll_rowcount = ads_EDIPending.rowcount()

for ll_row = 1 to ll_rowcount
	ll_ShipId = ads_EDIPending.object.sourceid[ll_row]
	lnv_dispatch.of_retrieveshipments({ll_shipid})
	lnv_shipment.of_setsource(lnv_dispatch.of_getshipmentcache())
	lnv_shipment.of_setsourceid(ll_shipid)
	
	if lnv_shipment.of_hassource() then
		
		ll_coid = lnv_shipment.of_getbillto()

		IF gnv_App.of_GetNextId ( "edi", ll_NextId, cb_Commit ) = 1 THEN
			
			ll_NewRow = lds_EDICache.InsertRow ( 0 )
		
			if ll_Newrow > 0 then
				lds_EDICache.SetItem ( ll_NewRow , "transactionSet" , 210 )
				lds_EDICache.SetItem ( ll_NewRow , "sourceid" , ll_ShipID )
				lds_EDICache.SetItem ( ll_NewRow , "source" , 'SHIPMENT' )
				lds_EDICache.SetItem ( ll_NewRow , "Company" , ll_coid)		
				lds_EDICache.SetItem ( ll_NewRow , "id" , ll_NextId )
			
			end if
		
		end if
		
		if ll_Nextid > 0 then
			ll_count ++
			ala_EDIid[ll_count] = ll_nextid
			ala_Sourceid[ll_count] = ll_ShipID
		end if

	end if
next

DESTROY lnv_Dispatch
DESTROY lnv_Shipment


end subroutine

on n_cst_edi_transaction_210.create
call super::create
end on

on n_cst_edi_transaction_210.destroy
call super::destroy
end on

event constructor;call super::constructor;ii_transactionset = 210
end event

