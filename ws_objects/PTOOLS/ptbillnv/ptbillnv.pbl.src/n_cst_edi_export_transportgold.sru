$PBExportHeader$n_cst_edi_export_transportgold.sru
forward
global type n_cst_edi_export_transportgold from n_cst_edi_export
end type
end forward

global type n_cst_edi_export_transportgold from n_cst_edi_export
end type
global n_cst_edi_export_transportgold n_cst_edi_export_transportgold

type variables
PRIVATE:
Int	     ii_FileHandle


CONSTANT String cs_Mark = "\"
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
public function integer of_exportedifile (n_cst_msg anv_msg)
private function integer of_getfilehandle ()
private function integer of_formatinvoicenum (ref string as_invoicenum)
private function integer of_formatblnum (ref string as_blnum)
private function integer of_formatdate (date ad_date, ref string as_formateddate)
private function integer of_formatpo (ref string as_ponum)
private function integer of_formatppcol (ref string as_PPCol)
private function integer of_formatweight (long al_weight, ref string as_formatedwt)
private function integer of_formatcharges (dec adec_Charges, ref string as_FormatedCharges)
private function integer of_formatequipnum (ref string as_equipmentnum)
private function integer of_addfill (long al_len, ref string as_fill)
private function integer of_getmark (ref String as_Mark)
private function integer of_formateventcode (ref string as_eventcode)
private function integer of_formatlocationcode (ref string as_LocationCode)
private function integer of_formatname (ref string as_name)
private function integer of_formataddress (ref string as_Address)
private function integer of_parselocation (string as_location, ref string as_city, ref string as_state, ref string as_zip)
private function integer of_formatstate (ref String as_State)
private function integer of_formatzip (ref string as_zip)
private function integer of_formatcity (ref string as_city)
private function integer of_processrecordtypetwo (readonly datawindow adw_source, integer ai_row, integer ai_itinrow)
private function integer of_processrecordtypeone (readonly datawindow adw_source, integer ai_row)
private function integer of_processrecordtypethree (readonly datawindow adw_source, integer ai_row, integer ai_itemrow)
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
private function integer of_getfilename (ref string as_path)
private function integer of_formattradingpartner (readonly long al_coid, ref string as_formated)
private function integer of_getedifolder (ref string as_folderpath)
end prototypes

public function integer of_exportedifile (n_cst_msg anv_msg);// for each invoice being billed there will be 1 line in the exported file of type 01.
// for each PU/DEL in the associated shipment itinerary there will be a line of type 02. 
// 		this will detail the header info in line 1
// for line item of the Bill there will be a line of type 3 in the exported file. 
//			this also details he header info.


Int			li_ReturnValue = 1
Long			lla_IDs[]
Int  			lia_CoId[]
Int			lia_ItemID[]
Int			lia_Empty[]
Int			li_ProcessOneRtn
Int			li_ProcessTwoRtn
Int			li_FileHandle
Int			li_ItinCount
Int			li_ItemCount
Int			i,k

n_cst_msg	lnv_msg
S_Parm		lstr_parm
DataWindow	ldw_Source
n_cst_LicenseManager	lnv_LicenseManager


IF lnv_LicenseManager.of_HasEDI210License ( ) THEN

	li_FileHandle = THIS.of_GetFileHandle ( )
	IF li_FileHandle = 0 THEN
		li_ReturnValue = 0 
	END IF
	
	IF li_ReturnValue = 1 THEN
		lnv_msg = anv_msg
		
		IF NOT IsValid ( lnv_msg ) THEN
			li_ReturnValue = -1
		ELSE
			IF lnv_msg.Of_Get_Parm ( "SOURCE" , lstr_Parm ) <> 0 THEN
				ldw_Source= lstr_Parm.ia_Value
			ELSE
				li_ReturnValue = -1
			END IF
			
			IF lnv_msg.Of_Get_Parm ( "IDS" , lstr_Parm ) <> 0 THEN
				lla_IDS = lstr_Parm.ia_Value
			ELSE
				li_ReturnValue = -1
			END IF
		
		END IF
	END IF
	
	IF li_ReturnValue = 1 THEN
		IF NOT IsValid ( ldw_Source ) THEN
			li_ReturnValue = -1
		END IF
	END IF
	
	
	For i = 1 TO UpperBound ( lla_IDS )
		
		IF li_ReturnValue = 1 THEN		
			if integer(ldw_Source.object.nr_itin[i].object.datawindow.firstrowonpage) > 0 then
				lia_CoID = lia_empty
				lia_CoID = ldw_Source.object.nr_itin[i].object.de_site.primary
				IF upperbound(lia_CoID) > 0 THEN
					li_ItinCount = upperbound(lia_CoID)
				ELSE
					li_ReturnValue = -1
				END IF
			ELSE
				li_ReturnValue = -1
			END IF	
			
		END IF
		
		if integer(ldw_Source.object.nr_items[i].object.datawindow.firstrowonpage) > 0 then
			lia_itemID = lia_empty
			lia_ItemID = ldw_Source.object.nr_items[i].object.di_item_id.primary
			IF upperbound(lia_ItemID) > 0 THEN
				li_ItemCount = upperbound(lia_ItemID)
			ELSE
				li_ReturnValue = -1
			END IF
		ELSE
			li_ReturnValue = -1
		END IF	
		
		IF li_ReturnValue = 1 THEN
			li_ProcessOneRtn = THIS.of_ProcessRecordTypeOne( ldw_Source , i ) 
			IF li_ProcessOneRtn <> 1 THEN
				li_ReturnValue = -1
			END IF
		END IF
		
		
		IF li_ReturnValue = 1 THEN
			For k = 1 TO li_ItinCount
				li_ProcessTwoRtn = THIS.of_ProcessRecordTypeTwo( ldw_Source , i, k ) 
				IF li_ProcessTwoRtn <> 1 THEN
					li_ReturnValue = -1
				END IF
			NEXT
		END IF
		
		
		IF li_ReturnValue = 1 THEN
			For k = 1 TO li_ItemCount
				li_ProcessTwoRtn = THIS.of_ProcessRecordTypeThree( ldw_Source , i, k ) 
				IF li_ProcessTwoRtn <> 1 THEN
					li_ReturnValue = -1
				END IF
			NEXT
		END IF
		
	NEXT
	IF li_ReturnValue = -1 THEN
		MessageBox( "EDI Export" , "An error occurred while attempting to export the EDI file." , STOPSIGN!)
	END IF
	
	
	FileClose ( li_FileHandle )
	
ELSE  //EDI Module not licensed
	lnv_LicenseManager.of_DisplayModuleNotice ( "EDI Export" )

END IF

		

RETURN li_ReturnValue
	
end function

private function integer of_getfilehandle ();String 	ls_FileName
Int		li_FileHandle
Int		li_FileReturn


IF ii_filehandle = 0 THEN
	li_FileReturn = THIS.OF_GetFileName ( ls_FileName )
	IF li_FileReturn = 1 THEN
		IF ls_FileName <> "" THEN
			li_FileHandle = FileOpen ( ls_FileName, LineMode!, Write! )
			IF li_FileHandle > 0 AND ( NOT IsNull ( li_fileHandle )) THEN
				ii_FileHandle = li_FileHandle
			ELSE
				li_FileHandle = 0 
			END IF
		ELSE
			li_FileHandle = 0 
		END IF
	ELSEIF li_FileReturn = -1 THEN
		MessageBox("EDI Export" , "An error occurred while attempting to get the file save name.")
	END IF
	
ELSE
	li_FileHandle = ii_FileHandle
END IF

RETURN li_FileHandle

end function

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

private function integer of_getmark (ref String as_Mark);String	ls_Mark 
Int	li_ReturnValue = 1

ls_Mark = cs_mark

IF len ( ls_Mark ) <> 1 THEN
	li_ReturnValue = -1
ELSE
	as_Mark = ls_mark
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

private function integer of_parselocation (string as_location, ref string as_city, ref string as_state, ref string as_zip);Long		ll_Len
Int		li_ReturnValue = 1
String	ls_City
String	ls_Zip
String	ls_State
String	ls_Source
String	lsa_Result[]
String	lsa_Result2[]

n_cst_String	lnv_String

ls_Source = as_Location

lnv_String.of_ParseToArray ( ls_Source , "," ,lsa_Result )

IF upperBound (lsa_Result ) <> 2 THEN
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1 AND ( upperBound ( lsa_Result ) >= 1 ) THEN
	ls_City = lsa_Result[1]
END IF

IF li_ReturnValue = 1 AND ( upperBound ( lsa_Result ) >= 2 ) THEN
	lsa_Result[2] = leftTrim ( lsa_Result [2] )
	IF lsa_Result [2] <> "" THEN
		lnv_String.of_ParseToArray ( lsa_Result[2], " ", lsa_Result2[] )
	END IF
END IF

IF li_ReturnValue = 1 AND ( upperBound ( lsa_Result2 ) >= 1 ) THEN
	ls_State = lsa_Result2[1]
	IF Len ( ls_State ) <> 2 THEN
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 AND ( upperBound ( lsa_Result2 ) >= 3 ) THEN
	ls_Zip = lsa_Result2[3]
END IF


as_City = ls_City
as_State = ls_State
as_Zip = ls_Zip

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

private function integer of_processrecordtypetwo (readonly datawindow adw_source, integer ai_row, integer ai_itinrow);Int		li_ReturnValue  = -1
Int		li_Row
Int		li_ItinRow
Int		li_FileHandle
Int		lia_CoID[]
Int		lia_Empty[]
String	ls_InvNum
String	ls_BlNum
Date		ld_ShipDate
String	ls_Mark
String	ls_RecNum = "2"
String	ls_TP 
String	ls_work
String	ls_Formated
String	ls_AddCode
String	ls_Name
String	ls_Address
String	ls_State
String	ls_Zip
String	ls_LocationCode
String	ls_Location
String	ls_City
Long		ll_CoID

Int		li_WriteRtn

// add parm to function to indicate the itin row needed to access 

DataWindow	ldw_Source 
ldw_Source = adw_source

li_FileHandle = THIS.of_GetFileHandle ( ) 

IF NOT li_FileHandle = 0 THEN 
	li_ReturnValue = 1
END IF

li_Row = ai_row
li_ItinRow = ai_ItinRow

IF li_ReturnValue = 1 THEN		
	if integer(ldw_Source.object.nr_itin[li_Row].object.datawindow.firstrowonpage) > 0 then
		lia_CoID = lia_empty
		lia_CoID = ldw_Source.object.nr_itin[li_Row].object.de_site.primary
		IF upperbound(lia_CoID) > 0 THEN
			//
		ELSE
			li_ReturnValue = -1
		END IF
	ELSE
		li_ReturnValue = -1
	END IF	
	
END IF

IF li_ReturnValue = 1 THEN
	ld_ShipDate = ldw_Source.object.nr_itin[li_Row].object.de_arrDate[1]
	ls_AddCode = ldw_Source.object.nr_itin[li_Row].object.de_Event_Type[li_ItinRow]
	ls_InvNum = ldw_Source.object.ds_proNum[li_Row]  //ok
	ls_BLNum = ldw_Source.object.ds_Ref1_Text[li_Row] //null??
	ls_mark = cs_Mark
	ls_Name = ldw_Source.object.nr_itin[li_Row].object.co_Name[li_ItinRow]
	ls_Address = ldw_Source.object.nr_itin[li_Row].object.co_addr1[li_ItinRow]
	ls_Location = ldw_Source.object.nr_itin[li_Row].object.co_Location[li_ItinRow]
	ll_CoID = ldw_Source.object.ds_BillTo_ID[li_Row]
END IF

IF of_ParseLocation ( ls_Location , ls_City , ls_State , ls_Zip ) <> 1 THEN
	li_ReturnValue = -1
END IF


IF li_ReturnValue = 1 THEN
	ls_Work = ls_RecNum
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatTradingPartner ( ll_CoID, ls_TP) = 1  THEN
		ls_Work += ls_TP
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatInvoiceNum ( ls_InvNum) = 1  THEN
		ls_Work += ls_InvNum
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatBLNum ( ls_BLNum) = 1  THEN
		ls_Work += ls_BLNum
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatDate ( ld_ShipDate, ls_Formated ) = 1  THEN
		ls_Work += ls_Formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
		IF THIS.OF_AddFill ( 46 , ls_Formated) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatEventCode ( ls_AddCode) = 1  THEN
		ls_Work += ls_AddCode
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	IF THIS.OF_FormatName ( ls_Name) = 1  THEN
		ls_Work += ls_Name
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
	IF THIS.OF_FormatAddress ( ls_Address) = 1  THEN
		ls_Work += ls_Address
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatState ( ls_State) = 1  THEN
		ls_Work += ls_State
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	IF THIS.OF_FormatZip ( ls_Zip) = 1  THEN
		ls_Work += ls_Zip
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
	IF THIS.OF_FormatLocationCode ( ls_LocationCode) = 1  THEN
		ls_Work += ls_LocationCode
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	IF THIS.OF_AddFill ( 52 , ls_Formated) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	IF THIS.OF_FormatCity ( ls_City) = 1  THEN
		ls_Work += ls_City
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_AddFill ( 12 , ls_Formated) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	IF THIS.OF_getMark ( ls_Mark ) = 1  THEN
		ls_Work += ls_Mark
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	li_WriteRtn = FileWrite ( li_FileHandle, ls_Work )
	IF li_WriteRtn < 0 AND isNull ( li_WriteRtn ) THEN
		li_ReturnValue = -1
	END IF
END IF

Return li_ReturnValue 

end function

private function integer of_processrecordtypeone (readonly datawindow adw_source, integer ai_row);Int		li_ReturnValue  = -1
Int		li_Row
Int		li_FileHandle
Int		lia_CoID[]
Int		lia_Empty[]
Int		li_QTY
date		ld_Amnt
String	ls_InvNum
String	ls_BlNum
String	ls_PONum  
Date		ld_ShipDate
Date		ld_DelDate
Long		ll_TOTWeight
Long		ll_CoId
Dec {2} 	ldec_TotCharge
String	ls_Corr
String	ls_Mark
String	ls_ppcol
String	ls_RecNum = "1"
String	ls_TP 
String	ls_work
String	ls_Formated
String	ls_EquipNum
Int		li_WriteRtn

DataWindow	ldw_Source 
ldw_Source = adw_source

li_FileHandle = THIS.of_GetFileHandle ( ) 

IF NOT li_FileHandle = 0 THEN 
	li_ReturnValue = 1
END IF

li_Row = ai_row	


IF li_ReturnValue = 1 THEN		
	if integer(ldw_Source.object.nr_itin[li_Row].object.datawindow.firstrowonpage) > 0 then
		lia_CoID = lia_empty
		lia_CoID = ldw_Source.object.nr_itin[li_Row].object.de_site.primary
		IF upperbound(lia_CoID) > 0 THEN
			//
		ELSE
			li_ReturnValue = -1
		END IF
	ELSE
		li_ReturnValue = -1
	END IF	
	
END IF


IF li_ReturnValue = 1 THEN
	ld_ShipDate = ldw_Source.object.nr_itin[li_Row].object.de_arrDate[1]
	ld_DelDate = ldw_Source.object.nr_itin[li_Row].object.de_arrDate[UpperBound ( lia_CoID )]
	ls_InvNum = ldw_Source.object.ds_proNum[li_Row]    //ok
	ls_BLNum = ldw_Source.object.ds_Ref1_Text[li_Row] //null??
	ls_poNum = ldw_Source.object.ds_Ref2_Text[li_Row] //null??
	ll_TotWeight = ldw_Source.object.ds_Total_Weight[li_Row]
	ldec_TotCharge = ldw_Source.object.ds_bill_Charge[li_Row]
	ll_CoID = ldw_Source.object.ds_BillTo_ID[li_Row] // used to get trading partner
	ls_ppcol = ldw_Source.object.ds_ppcol[li_Row]
	ls_Corr = "00"
	ls_mark = cs_Mark
	
	IF THIS.of_getQTY ( ldw_Source , li_row, li_Qty ) <> 1 THEN
		li_ReturnValue = -1 
	END IF

END IF

IF li_ReturnValue = 1 THEN
	ls_Work = ls_RecNum
END IF

IF li_ReturnValue = 1 THEN
	IF THIS.OF_FormatTradingPartner ( ll_CoID, ls_TP) = 1  THEN
		ls_Work += ls_TP
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
	IF THIS.OF_FormatInvoiceNum ( ls_InvNum) = 1  THEN
		ls_Work += ls_InvNum
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN 
	IF THIS.OF_FormatBLNum ( ls_BLNum) = 1  THEN
		ls_Work += ls_BLNum
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN 
	IF THIS.OF_FormatDate ( ld_ShipDate, ls_Formated ) = 1  THEN
		ls_Work += ls_Formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN 
	IF THIS.OF_FormatDate ( ld_DelDate, ls_Formated ) = 1  THEN
		ls_Work += ls_Formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN 
	IF THIS.OF_FormatPO ( ls_PONum ) = 1  THEN
		ls_Work += ls_PONum
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN 
	IF THIS.OF_FormatPPcol ( ls_PPCol ) = 1  THEN
		ls_Work += ls_PPCol
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN 
	IF THIS.OF_FormatQTY ( li_QTY, ls_formated ) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF

// burp !!
IF li_ReturnValue = 1 THEN 
	IF THIS.OF_FormatWeight ( ll_TotWeight, ls_formated ) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN 
	IF THIS.OF_FormatCharges ( ldec_TotCharge, ls_formated ) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
	ls_Work += ls_Corr //00
END IF

IF li_ReturnValue = 1 THEN 
	IF THIS.OF_FormatEquipNum ( ls_EquipNum ) = 1  THEN
		ls_Work += ls_EquipNum
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN 
	IF THIS.OF_AddFill ( 152 , ls_Formated) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
	IF THIS.OF_getMark ( ls_Mark ) = 1  THEN
		ls_Work += ls_Mark
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
	li_WriteRtn = FileWrite ( li_FileHandle, ls_Work )
	IF li_WriteRtn = -1 OR isNull ( li_WriteRtn )  THEN
		li_ReturnValue = -1
	END IF
END IF

Return li_ReturnValue 
end function

private function integer of_processrecordtypethree (readonly datawindow adw_source, integer ai_row, integer ai_itemrow);Int		li_ReturnValue  = -1
Int		li_Row
Int		li_ItemRow
Int		li_FileHandle
Int		lia_CoID[]
Int		lia_Empty[]
String	ls_InvNum
String	ls_BlNum
Date		ld_ShipDate
Dec{5}	ldec_BillRateQty
Dec{2} 	ldec_Charges
Int		li_Qty
Long		ll_CoID
String	ls_Mark
String	ls_Description
String	ls_RecNum = "3"
String	ls_TP 
String	ls_work
String	ls_Formated
String	ls_QtyQual
String	ls_FreightCode
String	ls_ChargesQual
String	ls_RTDQual
String	ls_CommodityCode
String	ls_ReasonCode
String	ls_WeightQual
Int		li_WriteRtn



DataWindow	ldw_Source 
ldw_Source = adw_source

li_FileHandle = THIS.of_GetFileHandle ( ) 

IF NOT li_FileHandle = 0 THEN 
	li_ReturnValue = 1
END IF

li_Row = ai_row
li_ItemRow = ai_ItemRow

IF li_ReturnValue = 1 THEN		
	if integer(ldw_Source.object.nr_items[li_Row].object.datawindow.firstrowonpage) > 0 then
		lia_CoID = lia_empty
		lia_CoID = ldw_Source.object.nr_items[li_Row].object.di_item_id.primary
		IF upperbound(lia_CoID) > 0 THEN
			//
		ELSE
			li_ReturnValue = -1
		END IF
	ELSE
		li_ReturnValue = -1
	END IF	
	
END IF

IF li_ReturnValue = 1 THEN
	ld_ShipDate = ldw_Source.object.nr_itin[li_Row].object.de_arrDate[1]
	ls_InvNum = ldw_Source.object.ds_proNum[li_Row]  //ok
	ls_BLNum = ldw_Source.object.ds_Ref1_Text[li_Row] //null??
	ls_mark = cs_Mark
	li_qty = ldw_Source.object.nr_items[li_Row].object.di_Qty[li_ItemRow]
	ls_Description = ldw_Source.object.nr_items[li_Row].object.di_description[li_ItemRow]
	ldec_Charges = ldw_Source.object.nr_items[li_Row].object.di_Our_ItemAmt[li_ItemRow]
	ll_CoID = ldw_Source.object.ds_BillTo_ID[li_Row]
END IF

IF li_ReturnValue = 1 THEN
	ls_Work = ls_RecNum
END IF

IF li_ReturnValue = 1 THEN 
	IF THIS.OF_FormatTradingPartner (ll_CoId, ls_TP) = 1  THEN
		ls_Work += ls_TP
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatInvoiceNum ( ls_InvNum) = 1  THEN
		ls_Work += ls_InvNum
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatBLNum ( ls_BLNum) = 1  THEN
		ls_Work += ls_BLNum
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatDate ( ld_ShipDate, ls_Formated ) = 1  THEN
		ls_Work += ls_Formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
		IF THIS.OF_AddFill ( 14 , ls_Formated) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatQTY ( li_QTY, ls_formated ) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_AddFill ( 99 , ls_Formated) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatWeightQual ( ls_WeightQual ) = 1  THEN
		ls_Work += ls_WeightQual
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatDescription ( ls_Description) = 1  THEN
		ls_Work += ls_Description
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatQtyQual ( ls_QtyQual) = 1  THEN
		ls_Work += ls_QtyQual
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
	IF THIS.OF_FormatCharges ( ldec_Charges, ls_formated ) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN 
		IF THIS.OF_FormatChargesQual ( ls_ChargesQual) = 1  THEN
		ls_Work += ls_ChargesQual
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN 
		IF THIS.OF_AddFill ( 2 , ls_Formated) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN 
		IF THIS.OF_FormatBillRateQty ( ldec_BillRateQty, ls_formated) = 1  THEN
		ls_Work += ls_Formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatBillRTDQual ( ls_RTDQual) = 1  THEN
		ls_Work += ls_RTDQual
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatCommodityCode ( ls_CommodityCode) = 1  THEN
		ls_Work += ls_CommodityCode
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_AddFill ( 15 , ls_Formated) = 1  THEN
		ls_Work += ls_formated
	ELSE
		li_ReturnValue = -1
	END IF
END IF


IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatReasonCode ( ls_ReasonCode) = 1  THEN
		ls_Work += ls_ReasonCode
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_FormatFreightClass ( ls_FreightCode) = 1  THEN
		ls_Work += ls_FreightCode
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
		IF THIS.OF_getMark ( ls_Mark ) = 1  THEN
		ls_Work += ls_Mark
	ELSE
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	li_WriteRtn = FileWrite ( li_FileHandle, ls_Work )
	IF li_WriteRtn < 0 AND isNull ( li_WriteRtn ) THEN
		li_ReturnValue = -1
	END IF
END IF

Return li_ReturnValue 

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

private function integer of_getfilename (ref string as_path);String	ls_title
String	ls_PathName
String	ls_Rfilename
String	ls_Extension
String	ls_Filter
String	ls_ReturnString
String	ls_FolderPath
Int		li_SaveReturn
Boolean	lb_Again
Int		li_MBoxRtn
Int		li_ReturnValue = 1

ls_Title = "EDI File Export Locatation"
ls_PathName = "C:\Untitled"
ls_Extension = ".dat"
ls_Filter = "Dat Files (*.dat),*.dat"


// try to get the folder specified in the s.s.. 
IF of_getEDIFolder( ls_FolderPath ) = 1 THEN 
	ls_PathName = ls_FolderPath + "Untitled"
END IF

DO
	
	lb_Again = FALSE
	li_SaveReturn = GetFileSaveName ( ls_title, ls_pathname, ls_rfilename , ls_extension , ls_filter )
	
	IF li_SaveReturn = 0 THEN
		IF	MessageBox( "EDI Billing" , "Please note that the bills have already been processed. You will not have another chance to export the file. Are you sure you want to cancel?" , QUESTION! , YESNO!, 2 ) = 1 THEN
			lb_again = FALSE
			li_ReturnValue = 0
			ls_ReturnString = ""
		ELSE
			lb_Again = TRUE
		END IF
		
	END IF
	
	IF li_SaveReturn = 1 THEN
		
		IF Len ( ls_rFileName ) > 12 THEN
			MessageBox( "EDI File Name", "Please limit the file name to 8 characters.",EXCLAMATION! )
			lb_Again = TRUE
			ls_ReturnString = ""
			
		ELSE
			ls_ReturnString = ls_PathName
		END IF
		
		IF FileExists ( ls_ReturnString ) THEN 
			li_MBoxRtn = MessageBox( "EDI File Name" , "The file name you specified already exists. Do you want to over write it?" , QUESTION!, YESNO! , 2 )
			CHOOSE CASE li_MBoxRtn
				CASE 1
					IF NOT FileDelete ( ls_PathName ) THEN
						MessageBox( "File Over Write" , "An error occurred while attempting to over write the existing file." , STOPSIGN! )
						ls_ReturnString = ""
						lb_Again = TRUE
					ELSE
						ls_ReturnString = ls_pathName
					END IF
					
				CASE 2
					lb_Again = TRUE
					ls_ReturnString = ""
					
	//			CASE 3
	//				ls_ReturnString = ""
	//				lb_Again = FALSE
	//				li_ReturnValue = 0
					
				CASE ELSE
					li_ReturnValue = -1
									
			END CHOOSE
		END IF		
	END IF

LOOP UNTIL ( lb_again = FALSE ) OR ( Len ( ls_ReturnString ) > 0 )

as_Path = ls_ReturnString



Return li_ReturnValue

end function

private function integer of_formattradingpartner (readonly long al_coid, ref string as_formated);Int		li_ReturnValue = 1
Int		li_CacheRtn
String	ls_ReturnString
String	ls_Source


n_cst_Beo_Company	lnv_Company
n_cst_string	lnv_String

lnv_Company = CREATE n_cst_beo_Company

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

DESTROY lnv_Company

RETURN li_ReturnValue

end function

private function integer of_getedifolder (ref string as_folderpath);//Returns:   1 = Success 
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1


//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 60 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( trim ( ls_Description )  ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	IF Right ( ls_Description , 1 ) <> "\" THEN
		ls_Description += "\"
	END IF
	
	as_FolderPath = ls_description
	
END IF
 

RETURN li_Return


end function

on n_cst_edi_export_transportgold.create
call super::create
end on

on n_cst_edi_export_transportgold.destroy
call super::destroy
end on

