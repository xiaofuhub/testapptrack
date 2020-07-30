$PBExportHeader$n_cst_edi_transaction_214.sru
forward
global type n_cst_edi_transaction_214 from n_cst_edi_transaction
end type
end forward

global type n_cst_edi_transaction_214 from n_cst_edi_transaction
end type
global n_cst_edi_transaction_214 n_cst_edi_transaction_214

type variables
CONSTANT String cs_StatusRole_ImTheSite = "IMTHESITE"
CONSTANT String cs_StatusRole_Billto = "BILLTO"
CONSTANT String cs_StatusRole_Origin = "ORIGIN"
CONSTANT String cs_StatusRole_Destination = "DESTINATION"
CONSTANT String cs_StatusRole_Carrier = "CARRIER"
CONSTANT String cs_StatusRole_Agent = "AGENT"
CONSTANT String cs_StatusRole_Forwarder = "FORWARDER"
CONSTANT String cs_StatusRole_any = "ANY"

CONSTANT String cs_SiteType_Origin = "ORIGIN"
CONSTANT String cs_SiteType_Destination = "DESTINATION"
CONSTANT String cs_SiteType_not_origdest = "NOTORIGINORDESTINATION"
CONSTANT String cs_SiteType_any = "ANY"

private:

string	is_path

n_ds		ids_edistatus, &
			ids_StatusProfile

end variables

forward prototypes
private subroutine of_getrecord4 ()
private subroutine of_getrecord5 ()
private subroutine of_getrecord6 ()
private subroutine of_getrecord1 (long al_row, ref string asa_column[], ref string asa_text[])
private subroutine of_getrecord3 (long al_row, ref string asa_column[], ref string asa_text[])
private function integer of_getrecord2 (long al_row, ref string asa_column[], ref string asa_text[])
public subroutine of_loadtransactions (ref n_cst_msg anv_msg)
private function integer of_getrecord7 (long al_row, ref string asa_column[], ref string asa_text[])
private subroutine of_sendadditionalstatus (n_cst_beo_event anv_event, string as_withstatus, string as_tz)
public function long of_getedistatuscache (ref n_ds ads_edistatus)
public subroutine of_setedistatuscache ()
public function string of_getedistatuscode (long al_id)
public subroutine of_sendtransaction (long ala_id[])
public function n_ds of_getstatusprofile ()
public subroutine of_setedicache ()
public function integer of_addtocache (long al_coid, long al_event)
public function string of_determinesitetype (long al_coid, n_cst_beo_shipment anv_shipment)
public function integer of_updateedicache ()
public function integer of_processededi (long al_id, string as_error)
public function integer of_loadevent (long al_eventid)
protected function long of_getstatusrole (ref string as_role, long al_coid, string as_eventtype, n_cst_beo_shipment anv_shipment, ref n_ds ads_statusprofile, long al_eventsiteid, string as_action)
public function boolean of_createedi (n_cst_beo_event anv_event, n_cst_beo_shipment anv_shipment, n_ds ads_edipending, long al_pendingrow, long al_coid, string as_rolematch, ref long ala_createid[])
protected function string of_getoutboundmappingfile ()
public function integer of_processalledi (string asa_header[], string asa_footer[], long ala_ids[], string as_outputfolder, string asa_templatearray[])
protected function string of_getidcolname ()
public function string of_geterrorcontext (long ala_ids[])
public subroutine of_sendtransaction (long ala_id[], datastore ads_edicache)
public subroutine of_createtransaction (ref n_ds ads_edipending, ref long ala_ediid[], ref long ala_sourceid[])
end prototypes

private subroutine of_getrecord4 ();/*           RECORD 4 - FREE FORM COMMENT RECORD(S)

        02 RECID              PIC X(1).    ! VALUE "4"
        02 COMMENTS           PIC X(60).

*/


end subroutine

private subroutine of_getrecord5 ();/*           RECORD 5 - INTERLINE SWITCH RECORD(S)  -  
           USED WHEN HANDING TO OR FROM ANOTHER CARRIER

        02 RECID              PIC X(1).    ! VALUE "5"
        02 SCAC               PIC X(4).
        02 CITY               PIC X(30).
        02 SPLC               PIC X(9).
        02 INVOICE-NUMBER     PIC X(15).
        02 BILLING-DATE       PIC X(6).

*/
end subroutine

private subroutine of_getrecord6 ();/*           RECORD 6 - LADING EXCEPTION RECORD(S)   OS&D INFO

        02 RECID              PIC X(1).    ! VALUE "6"
        02 EXCEPTION-CODE     PIC X(1).    "O" "S" "D"
        02 QUANTITY-QUAL      PIC X(3).    ! "PCS"  PIECES
        02 QUANTITY           PIC 9(6).    !

*/
end subroutine

private subroutine of_getrecord1 (long al_row, ref string asa_column[], ref string asa_text[]);/*            RECORD 1 - SHIPMENT HEADER

        02 RECID               String(1).    ! VALUE "1"
        02 SCAC                String(4).    ! YOUR SCAC
        02 INVOICE		       String(15).   ! YOUR PRO/INVOICE
		  02 ASSIGNED NUMBER		 String(12).
        02 SHIPPERNUMBER	  	 String(20).   ! SHIPPERS IDENTIFYING NUMBER
        02 PURCHASEORDER  		 String(15).   ! PURCHASE ORDER NUMBER
        02 REF2TEXT			    String(15).   ! 
*/
long	ll_eventid, &
		ll_seq, &
		ll_shipid

string	lsa_blank[], &
			lsa_value[], &
			ls_scac, &
			ls_ref1, &
			ls_ref2, &
			ls_ref3

n_cst_beo_event	lnv_event

asa_column = lsa_blank
asa_text = lsa_blank


asa_column = {&
					"RECID", &
					"SCAC", &
					"INVOICE", &
					"ASSIGNEDNUMBER", &
					"SHIPPERNUMBER", &
					"PURCHASEORDER", &
					"REF2TEXT"}
					
asa_text[1] = "01"

if this.of_mapdataout("SCAC", lsa_value) > 0 then
	ls_scac = lsa_value[1]
else
	//check system setting
	ls_scac = this.of_getscac()
end if

asa_text[2] = ls_scac
	
ll_shipid = ids_shipstatus.object.disp_events_de_shipment_id[al_row]
asa_text[3] = string(ll_shipid)

ll_eventid = ids_shipstatus.object.disp_events_de_id[al_row]

if this.of_geteventbeo(ll_eventid, lnv_event) = 1 then
	ll_seq = lnv_event.of_getshipseq ()
else
	ll_seq = 0
end if
	
asa_text[4] = string(ll_seq)
	
if this.of_mapdataout("SHIPPERNUMBER", lsa_value) > 0 then
	ls_ref1 = lsa_value[1]
else
	ls_ref1 = ''
end if

if this.of_mapdataout("PURCHASEORDER", lsa_value) > 0 then
	ls_ref2 = lsa_value[1]
else
	ls_ref2 = ''
end if
	
if this.of_mapdataout("REFERENCENUMBER", lsa_value) > 0 then
	ls_ref3 = lsa_value[1]
else
	ls_ref3 = ''
end if

asa_text[5] = ls_ref1
asa_text[6] = ls_ref2
asa_text[7] = ls_ref3



end subroutine

private subroutine of_getrecord3 (long al_row, ref string asa_column[], ref string asa_text[]);/*            RECORD 3 - STATUS RECORD(S)

        02 RECID             String(1).     ! VALUE "3"
        02 STATUSCODE        String(2).     ! VARIOUS CODES DETERMINED BY THE SHIPPER
                                            "AF" PICKUP"   "D" DELIVERY   ETC.
        02 STATUSDATE        String(6).     ! YYMMDD    CAN BE YYYYMMDD
        02 STATUSTIME        String(4).     ! HHMM
        02 TIMEZONE          String(2).      
        02 STATUSREASON      String(3).     ! LATE REASON CODE DETERMINED BY SHIPPER
                                              "A24"  ACCIDENT
		  02 STOPNUMBER	     string(3)    												 	
*/
string	lsa_blank[], &
			ls_tz, &
			ls_test, &
			ls_date, &
			ls_time
			
long		ll_eventid
			
boolean	lb_foundid, &
			lb_basetimezone
			
integer	li_timezone

n_cst_beo_event	lnv_event

asa_column = lsa_blank
asa_text = lsa_blank

asa_column = {&
					"RECID", &
					"STATUSCODE", &
					"STATUSDATE", &
					"STATUSTIME", &
					"TIMEZONE", &
					"STATUSREASON", &
					"STOPNUMBER"}

ll_eventid = ids_shipstatus.object.disp_events_de_id[al_row]
if this.of_geteventbeo(ll_eventid, lnv_event) = 1 then
	lb_foundid = true
end if

if lb_foundid then
	
		li_timezone = lnv_event.of_getlocaltimezone()
		if li_timezone = -1 then
			li_timezone = lnv_event.of_getbasetimezone()
			lb_basetimezone=true
		end if
		choose case li_timezone
			case 0
				ls_tz = "HWI"
			case 1
				ls_tz = "ALK"
			case 2
				ls_tz = "PAC"
			case 3
				ls_tz = "MTN"
			case 4
				ls_tz = "CTL"
			case 5
				ls_tz = "EST"
			case 6
				ls_tz = "ATL"
		end choose
	
		IF lb_basetimezone then
			ls_date = string (lnv_event.of_GetDateDeparted ( ),"yymmdd")
			ls_time = string (lnv_event.of_GetTimeDeparted ( ),"HH:MM")
		else
			ls_date = string (lnv_event.of_GetLocalDate ( lnv_event.of_GetDateDeparted ( ),  lnv_event.of_GetTimeDeparted ( ) ),"yymmdd")
			ls_time = string (lnv_event.of_GetLocalTime ( lnv_event.of_GetDatedeparted ( ), lnv_event.of_GetTimeDeparted ( ) ),"HH:MM")
		end if
end if

asa_text[1] = "03"
asa_text[2] = ids_shipstatus.object.edi_status_a_code[al_row]
ls_test = string(ids_shipstatus.object.shipment_status_status_date[al_row],"yymmdd")
if len(trim(ls_test)) > 0 then
	ls_date = ls_test
	ls_time = string(ids_shipstatus.object.shipment_status_status_time[al_row],"HH:MM")
end if
asa_text[3] = ls_date
asa_text[4] = ls_time
asa_text[5] = ls_tz
asa_text[6] = ids_shipstatus.object.edi_reason_code[al_row]

asa_text[7] = string(lnv_event.of_getshipseq ())	//FORMAT?

//try sending appointment status
this.of_SendAdditionalStatus(lnv_Event, ids_shipstatus.object.edi_status_a_code[al_row], ls_tz)



end subroutine

private function integer of_getrecord2 (long al_row, ref string asa_column[], ref string asa_text[]);/*           RECORD 2 - NAME AND ADDRESS RECORD(S)

        02 RECID           String(1).     ! VALUE "2"
        02 CODE            String(2).     ! "SH" SHIPPER  "CN" CONSIGNEE  ETC.
        02 NAME            String(30).
        02 ADDRESS         String(30).
        02 CITY            String(30).
        02 STATE           String(2).
        02 ZIP             String(10).
		  02 IDQUALIFIER		String(2)    HARDCODED TO "91" FOR CHEP. NEED TO STORE THIS SOMEPLACE. COMES FROM 204.
		  02 IDCODE				String(20)
		  	
		possible codes
		BT - billto
		CN - consignee
		RE - remit to
		SE - selling party
		SH - shipper
		ST - ship to


*/
integer	li_return=1

string	lsa_blank[], &
			ls_name, &
			ls_code, &
			ls_identificationcode
			
long		ll_eventid
			
n_cst_beo_company	lnv_company
n_cst_beo_event	lnv_event

asa_column = lsa_blank
asa_text = lsa_blank

asa_column = {&
					"RECID", &
					"CODE", &
					"NAME", &
					"ADDRESS", &
					"CITY", &
					"STATE", &
					"ZIP", &
					"IDQUALIFIER", &
					"IDCODE"}

ll_eventid = ids_shipstatus.object.disp_events_de_id[al_row]
if this.of_geteventbeo(ll_eventid, lnv_event) = 1 then
	lnv_event.of_getsite(lnv_company)
	if isvalid(lnv_company) then
		ls_name = lnv_company.of_getname()
		ls_identificationcode = lnv_company.of_GetCodeName()
	end if
	IF lnv_event.of_IsPickupGroup( ) then
		ls_code = "SH"
	ELSEIF lnv_event.of_IsDeliverGroup( ) then
		ls_code = "CN"
	ELSE
		ls_code = ""
	END IF
end if

asa_text[1] = "02"
asa_text[2] = ls_code
asa_text[3] = ls_name
asa_text[4] = ""
asa_text[5] = ""
asa_text[6] = ""
asa_text[7] = ""
asa_text[8] = "91"
asa_text[9] = ls_identificationcode

DESTROY lnv_Company
return li_return
end function

public subroutine of_loadtransactions (ref n_cst_msg anv_msg);//multiple status records ( record 3)  can be sent with record 1 and 2

long	ll_RowCount, &
		ll_ndx, &
		ll_holdship, &
		ll_test, &
		ll_event, &
		ll_companyid, &
		ll_return = 1
		
string	lsa_column[], &
			lsa_text[], &
			lsa_blank[], &
			ls_hold214code
			
s_parm	lstr_parm
n_cst_filesrvwin32	lnv_filesrv

if isvalid(anv_msg) then
	IF anv_msg.Of_Get_Parm ( "SHIPMENTSTATUS" , lstr_Parm ) <> 0 THEN
		ids_shipstatus= lstr_Parm.ia_Value
	END IF

end if

if this.of_getsystemfilepath("EDI214", is_path) = 1 then
end if

if this.of_CacheDatamapping() = 1 then
	this.of_FilterDatamappingCache("EDI214")
end if

this.of_SetDatamappingdirection('O')	//output

ll_RowCount = ids_shipstatus.RowCount()
ids_transaction = this.of_createdatastore(9)

if ll_RowCount > 0 then
	
	for ll_ndx = 1 to ll_rowcount
	
		//break on shipper, seperate file for each shipper
		if ls_hold214code <> ids_shipstatus.object.shipment_status_edi_214_code[ll_ndx] then
			ls_hold214code = ids_shipstatus.object.shipment_status_edi_214_code[ll_ndx]
			ll_holdship = 0
			//write file 
			if ids_transaction.rowcount() > 0 then
				this.of_getTrailerRecord(lsa_column, lsa_text)
				this.of_writeToTransactionDatastore(lsa_column, lsa_text)
				//save as tab delimited
				if ids_transaction.SaveAs ( is_path + is_controlnumber + ".txt", Text!, FALSE) = 1 then
				end if
			end if
			//reset for new shipper
			ids_transaction.reset()
		end if
			
		//break on shipment
		ll_test = ids_shipstatus.object.disp_events_de_shipment_id[ll_ndx]
		ll_event = ids_shipstatus.object.disp_events_de_id[ll_ndx]
		if isnull(ll_test) then continue
		if ll_holdship <> ids_shipstatus.object.disp_events_de_shipment_id[ll_ndx] then
			ll_holdship = ids_shipstatus.object.disp_events_de_shipment_id[ll_ndx]
			if ll_ndx > 1 and ids_transaction.rowcount() > 0 then
				this.of_getTrailerRecord(lsa_column, lsa_text)
				this.of_writeToTransactionDatastore(lsa_column, lsa_text)
			end if
			if this.of_loadshipment(ll_holdship) = -1 then
				CONTINUE
			end if
			this.of_SetEDICompanyId(ls_hold214code)
			//shipment header
			this.of_getHeaderRecord(lsa_column, lsa_text, ls_hold214code)
			this.of_writeToTransactionDatastore(lsa_column, lsa_text)
			this.of_getrecord1(ll_ndx,lsa_column,lsa_text)
			this.of_writeToTransactionDatastore(lsa_column, lsa_text)
			
			/*	Note:
				Currrently we are not sending a shipper and consignee record together which
				is what some would like.  How do we determine these values?
			*/
		end if
		
		//shipper or consignee
		if this.of_getrecord2(ll_ndx, lsa_column,lsa_text) = 1 then
			this.of_writeToTransactionDatastore(lsa_column, lsa_text)
		end if
		
		this.of_getrecord3(ll_ndx,lsa_column,lsa_text)
		this.of_writeToTransactionDatastore(lsa_column, lsa_text)
		
		if this.of_getrecord7(ll_ndx,lsa_column,lsa_text) = 1 then
			this.of_writeToTransactionDatastore(lsa_column, lsa_text)
		end if

		//mark row as processed so it will be deleted after file creation
		ids_shipstatus.object.shipment_status_processed[ll_ndx] = "Y"
	next
	
	//last file
	if ids_transaction.rowcount() > 0 then
		this.of_getTrailerRecord(lsa_column, lsa_text)
		this.of_writeToTransactionDatastore(lsa_column, lsa_text)
		
		//do we have a valid path
		lnv_filesrv = create n_cst_filesrvwin32	
		if lnv_filesrv.of_Directoryexists ( is_path ) then
			//save as tab delimited
			if ids_transaction.SaveAs ( is_path + is_controlnumber + ".txt", Text!, FALSE) = 1 then
			end if
		else
			messagebox('Produce EDI 214 file','The directory ' + is_path + 'does not exist. ' +&
						'The 214 could not be produced. Please create the directory or change the system setting.')
						
			ll_return = -1
			
		end if
		destroy lnv_filesrv
		
	end if
	
	if ll_return = 1 then
		//delete rows from table 
		for ll_ndx = ll_rowcount to 1 step -1
			if ids_shipstatus.object.shipment_status_processed[ll_ndx] = "Y" then
				ids_shipstatus.RowsMove(ll_ndx, ll_ndx, Primary!, ids_shipstatus, 1, Delete!)
			end if
		next
		if ids_shipstatus.update() <> 1 then
			rollback;
		else
			commit;
		end if
	end if
	
end if

destroy ids_transaction

end subroutine

private function integer of_getrecord7 (long al_row, ref string asa_column[], ref string asa_text[]);/*           RECORD 7 - Equipment RECORD

        02 RECID           String(1).     ! VALUE "7"
        02 EQUIPMENT			String(10).     
        02 OWNERSCAC       String(4).
        02 CITY            String(30).
        02 STATE           String(2).
        02 COUNTRYCODE     String(3).
*/
Any		laa_beo[]
integer	li_return=1

string	lsa_blank[], &
			ls_equipment, &
			ls_city, &
			ls_state, &
			ls_country, &
			ls_scac, &
			lsa_value[]
			
long		ll_eventid
			
n_cst_beo_company	lnv_company
n_cst_beo_event	lnv_event

asa_column = lsa_blank
asa_text = lsa_blank

asa_column = {&
					"RECID", &
					"EQUIPMENT", &
					"OWNERSCAC", &
					"CITY", &
					"STATE", &
					"COUNTRY"}

//get the events
ll_eventid = ids_shipstatus.object.disp_events_de_id[al_row]
if this.of_geteventbeo(ll_eventid, lnv_event) = 1 then
	lnv_event.of_getsite(lnv_company)
	ls_equipment = lnv_event.of_getContainerList()
	if len(trim(ls_equipment)) = 0 then
		ls_equipment = lnv_event.of_getTrailerList()
	end if
	if isvalid(lnv_company) then
		ls_city = lnv_company.of_getcity()
		ls_state = lnv_company.of_getstate()
		ls_country = lnv_company.of_getcountry()
	end if
else
	li_return = -1
end if

if li_return = 1 then
	if this.of_mapdataout("OWNERSCAC", lsa_value) > 0 then
			ls_scac = lsa_value[1]
		else
			//check system setting
			ls_scac = this.of_getscac()
	end if
end if

if li_return = 1 then
	//if no equipment is found then don't send record
	if len(trim(ls_equipment)) = 0 or isnull(ls_equipment) then
		li_return = -1
	end if
end if

if li_return = 1 then
	asa_text[1] = "07"
	asa_text[2] = right(ls_equipment,len(ls_equipment) - 5)
	asa_text[3] = ls_scac
	asa_text[4] = ls_city
	asa_text[5] = ls_state
	asa_text[6] = ls_country
end if

DESTROY lnv_Company

return li_return
end function

private subroutine of_sendadditionalstatus (n_cst_beo_event anv_event, string as_withstatus, string as_tz);string	lsa_column[], &
			lsa_text[], &
			ls_test, &
			ls_date, &
			ls_time, &
			ls_eventtype, &
			ls_action, &
			ls_setting, &
			ls_status
			
long		ll_statusid, &
			ll_return=1

n_cst_events	lnv_Events

//right now hardcoded for appointment status and reason code
//could add system setting

ls_action = "APPOINTMENT"
ls_eventtype = Anv_event.of_gettype()

if ll_return = 1 then
	if lnv_Events.of_IsTypePickupGroup ( ls_EventType ) THEN
		ls_action = ls_action + "PICKUP"
	elseif lnv_Events.of_IsTypeDeliverGroup ( ls_EventType ) THEN
			ls_action = ls_action + "DELIVER"
	else
		//no additional status
		ll_return = -1
	end if
end if

if ll_return = 1 then
	if this.of_getnotificationsetting("EDI214", this.of_GetEDICompanyId(), this.of_GetDatamappingdirection(), &
												ls_action, ls_setting) = 1 then
	
		ll_statusid = long(ls_setting)
		
		if isnull(ll_statusid) then
			//no edi update
			ll_return = -1
		else
			ls_status = this.of_GetEDIStatusCode(ll_StatusID)
			if len(trim(ls_status)) > 0 then
				//ok
			else
				ll_return = -1
			end if
		end if
	else
		ll_return = -1
	end if
end if

if ll_return = 1 then
	/*    same format as record 3		*/
	//if the user is manually sending AB or AA then don't send this one
	if len(trim(ls_status)) > 0 then
		if ls_status = as_withstatus then
			//don't send same status twice
		else
			lsa_column = {&
								"RECID", &
								"STATUSCODE", &
								"STATUSDATE", &
								"STATUSTIME", &
								"TIMEZONE", &
								"STATUSREASON", &
								"STOPNUMBER"}
			
			lsa_text[1] = "03"
			lsa_text[2] = ls_status
			lsa_text[3] = string (anv_event.of_GetScheduledDate ( ),"yymmdd")
			lsa_text[4] = string (anv_event.of_GetScheduledTime ( ),"HH:MM")
			lsa_text[5] = as_tz
			if this.of_getnotificationsetting("EDI214", this.of_GetEDICompanyId(), this.of_GetDatamappingdirection(), &
														"APPOINTMENTREASON", ls_setting) = 1 then
				ll_statusid = long(ls_setting)		
				if isnull(ll_statusid) then
					//no edi update
					lsa_text[6] = 'NS'	//DEFAULT normal status
				else
					lsa_text[6] = this.of_GetEDIStatusCode(ll_StatusID)
				end if	
			else
				lsa_text[6] = 'NS'	//DEFAULT normal status
			end if
			
			lsa_text[7] = string(anv_event.of_getshipseq ())	//FORMAT?
	
			this.of_writeToTransactionDatastore(lsa_column, lsa_text)
	
		end if
	end if
end if
end subroutine

public function long of_getedistatuscache (ref n_ds ads_edistatus);long	ll_return=0

if not isvalid(ids_edistatus) then
	this.of_SetEdiStatuscache()
end if

ads_edistatus = ids_edistatus

if ll_return = 0 then
	ll_return = ads_edistatus.rowcount()
end if

return ll_return

end function

public subroutine of_setedistatuscache ();if isvalid(ids_edistatus) then
	destroy ids_edistatus
end if

ids_edistatus = create n_ds

n_cst_setting_edi204version	lnv_204Version

lnv_204Version = CREATE n_cst_setting_edi204version
IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
	lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
	ids_edistatus.dataobject = 'd_edistatuspending_ds'
ELSE
	ids_edistatus.dataobject = 'd_Edi_EventCache'
END IF	
DESTROY ( lnv_204Version )

ids_edistatus.settransobject(SQLCA)

ids_edistatus.Retrieve()
Commit;

end subroutine

public function string of_getedistatuscode (long al_id);long	ll_count, &
		ll_found
		
string	ls_findstring, &
			ls_code

n_ds	lds_edistatus

ll_count = this.of_GetEDIStatusCache(lds_EDIStatus)
ls_findstring = "id = " + string(al_id)
ll_found = lds_EDIStatus.find(ls_findstring, 1, ll_count)

if ll_found > 0 then
	ls_code = lds_EDIStatus.object.code[ll_found]
end if

return ls_code

end function

public subroutine of_sendtransaction (long ala_id[]);Integer	li_InputFile

long		ll_row, &
			ll_rowcount, &
			ll_eventid, &
			ll_ediid, &
			ll_coid, &
			lla_Coid[], &
			ll_CompanyCount, &
			ll_Index, &
			ll_Count, &
			i
			
			
Long		lla_idSubset1[]
Long		lla_idSubset2[]
Long		ll_subSize
Long		ll_subIndex
Long		ll_subSizeDividedby2
Long		ll_ediTempId
			
string	ls_filter, &
			ls_outputfolder, &
			ls_outputfile, &
			ls_templatefile, &
			ls_value, &
			ls_error, &
			ls_ControlNumber, &
			lsa_Transaction[], &
			lsa_Blank[], &
			lsa_Results[], &
			lsa_TemplateArray[], &
			lsa_TemplateHeader[], &
			lsa_TemplateFooter[]

boolean	lb_error
boolean	lb_validated

n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_sql			lnv_Sql
n_ds					lds_edistatus
s_parm 				lstr_parm	
n_cst_msg			lnv_tagmessage, &
						lnv_BlankMessage
				
if this.of_IsaResend( ) then
	lds_edistatus = create n_ds
	lds_edistatus.dataobject = 'd_edistatus_ds'
	lds_edistatus.settransobject(SQLCA)
	lds_edistatus.Retrieve(ala_id)
	Commit;
else	
	lds_edistatus = this.of_GetEDICache(true)
end if

//added by Dan 9-18-06, when we added the recusion, we didn't want to get
//the edi cache for every recursive call ( it was having duplicate information for some reason ).
//Instead we pass in the cache and use that through out the entire recursive process.
this.of_sendtransaction( ala_id, lds_ediStatus )

this.of_updateedicache( )

destroy lds_edistatus



/*Integer	li_InputFile

long		ll_row, &
			ll_rowcount, &
			ll_eventid, &
			ll_ediid, &
			ll_coid, &
			lla_Coid[], &
			ll_CompanyCount, &
			ll_Index, &
			ll_Count
			
string	ls_filter, &
			ls_outputfolder, &
			ls_outputfile, &
			ls_templatefile, &
			ls_value, &
			ls_error, &
			ls_ControlNumber, &
			lsa_Transaction[], &
			lsa_Blank[], &
			lsa_Results[], &
			lsa_TemplateArray[], &
			lsa_TemplateHeader[], &
			lsa_TemplateFooter[]

boolean	lb_error

n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_sql			lnv_Sql
n_ds					lds_edistatus
s_parm 				lstr_parm	
n_cst_msg			lnv_tagmessage, &
						lnv_BlankMessage
				
if this.of_IsaResend( ) then
	lds_edistatus = create n_ds
	lds_edistatus.dataobject = 'd_edistatus_ds'
	lds_edistatus.settransobject(SQLCA)
	lds_edistatus.Retrieve(ala_id)
	Commit;
else	
	lds_edistatus = this.of_GetEDICache(true)
end if

ls_controlnumber = this.of_GetControlNumber()

if upperbound(ala_id) > 0 then
	ls_filter = "edi_transactionset = 214 and edistatus_ediid" + lnv_sql.of_makeinclause(ala_id)
else
	ls_filter = "edi_transactionset = 214 and isnull(edi_processeddate)"
end if

lds_edistatus.setfilter(ls_filter)
lds_edistatus.filter()

ll_rowcount = lds_edistatus.rowcount()

//	load company id array, shrink array to unique ids, 
//	loop thru companies filtering datastore to the company and 
//	create a seperate file for each company
for ll_row = 1 to ll_rowcount
	lla_coid[ll_row] = lds_edistatus.object.edi_company[ll_row]
next

ll_CompanyCount = lnv_ArraySrv.of_getshrinked( lla_coid, true, true) 
Long	ll_CoIndex
for ll_CoIndex = 1 to ll_CompanyCount
	
	//set up next company file
	
	lsa_Results = lsa_Blank
	ls_outputfile = ""
	
	
	ls_filter = "edi_transactionset = 214 and edistatus_ediid" + lnv_sql.of_makeinclause(ala_id) +" and edi_company = " + string(lla_coid[ll_CoIndex])
	lds_edistatus.setfilter(ls_filter)
	lds_edistatus.filter()
	
	ll_rowcount = lds_edistatus.rowcount()
	
	if ll_rowcount > 0 then
		ll_coid =  lds_edistatus.object.edi_company[1]
		ll_ediid = lds_edistatus.object.edistatus_ediid[1]
	else
		CONTINUE
	end if
	
	THIS.of_Setedicompanyid( ll_Coid )
		
	ls_outputfolder = this.of_GetOutputFolder( appeon_constant.cl_transaction_set_214, ll_coid )
	
	if len(trim(ls_outputfolder)) > 0 then
		//ok
	else
		if this.of_getsystemfilepath("EDI214", ls_outputfolder) = 1 then
			//ok
		else
			lb_error = true
			ls_error = "No output folder in company profile or system settings. Message not sent"
		end if
	end if
			
	
	//get the file	
	ls_templatefile = this.of_GetTemplateFile( appeon_constant.cl_transaction_set_214, ll_coid )
		
	//Read template file and load into array
	if FileExists ( ls_templatefile ) then	
		//input file, read
		li_InputFile = FileOpen(ls_templatefile, LineMode!, Read!, Shared!)
		THIS.of_loadtemplateintoarray( li_InputFile , lsa_TemplateArray, lsa_TemplateHeader, lsa_TemplateFooter )
		Fileclose(li_InputFile)
	ELSE
		CONTINUE
	END IF
	
	//loop thru all rows for this company
	for ll_row = 1 to ll_rowcount
		
		lb_error = false
		ls_error = ''
		lsa_transaction = lsa_blank
		lnv_tagmessage = lnv_BlankMessage			
		ll_eventid = lds_edistatus.object.edi_sourceid[ll_row]
		ll_ediid = lds_edistatus.object.edistatus_ediid[ll_row]
		
		//THIS.li_edicoid = ll_Coid // li_EDICode is a misnamed instance var.
		THIS.of_SetEDIcompanyid( ll_coid )			
			
		this.of_LoadEvent(ll_EventId)
		inv_Shipment.of_Setcontextcompany( ll_coid ) // this is used to resolve aliases (i thought I had put this in once before but I Guess not)
		inv_Event.of_Setcontextcompany( ll_coid ) // this is used to resolve aliases (i thought I had put this in once before but I Guess not)
			
		lstr_parm.is_Label = "STATUS"
		ls_value = lds_edistatus.object.edistatus_status[ll_row]
		if isnull(ls_value) then
			ls_value = ''
		end if
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
		lstr_parm.is_Label = "REASON"
		ls_value = lds_edistatus.object.edistatus_reason[ll_row]
		if isnull(ls_value) then
			ls_value = ''
		end if
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
		lstr_parm.is_Label = "STATUSDATE"
		ls_value = string(lds_edistatus.object.edistatus_statusDate[ll_row],"yyyymmdd")
		if isnull(ls_value) then
			ls_value = ''
		end if
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
		lstr_parm.is_Label = "STATUSTIME"
		ls_value = string(lds_edistatus.object.edistatus_statusTime[ll_row],"hhmm")
		if isnull(ls_value) then
			ls_value = ''
		end if
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
		//Set additional tag values 
		this.of_GetHeaderFooterTags(lnv_TagMessage)

		lstr_parm.is_Label = "CONTROLNUMBER"
		lstr_Parm.ia_Value = ls_controlnumber
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
	
		lstr_parm.is_Label = "TRANSACTIONCONTROLNUMBER"
		lstr_Parm.ia_Value = string(ll_row, '0000')
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
	
		//replace this
//		this.of_Createfile( ls_templatefile, ls_outputfolder, ls_outputfile, {inv_event}, lnv_tagmessage )

		//with this
		
		if ll_row = 1 then 
			//start with header
			THIS.of_Processloop( lsa_TemplateHeader , lsa_transaction , lnv_TagMessage , inv_Event )
			ll_count = upperbound(lsa_transaction)
			for ll_index = 1 to ll_count
				lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
			next			
		end if
		
		THIS.of_Processloop( lsa_TemplateArray , lsa_transaction , lnv_TagMessage , inv_Event )
		//move to the results array
		ll_count = upperbound(lsa_transaction)
		for ll_index = 1 to ll_count
			lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
		next
		
		this.of_ProcessedEDI(ll_EDIId, ls_error)
				
	next
	//end of rows for this company
	
	//processloopelements
	THIS.of_Processloop( lsa_TemplateFooter , lsa_transaction , lnv_TagMessage , inv_Event )
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
		ls_outputfile = ls_controlnumber + THIS.of_getOutboundfileextension( )
	end if
	
	ls_outputfile = ls_outputfolder + "\" + ls_outputfile
	
	THIS.of_Writeresultstofile( lsa_Results , ls_outputfile )
	
next

this.of_updateedicache( )

destroy lds_edistatus

*/
end subroutine

public function n_ds of_getstatusprofile ();
if isvalid(ids_profile) then
	//already created
else
	ids_StatusProfile = create n_ds
	ids_StatusProfile.dataobject = "d_ediprofile_214_grid"
	ids_StatusProfile.SetTransObject(SQLCA)
//	ids_StatusProfile.Retrieve()
end if

return ids_StatusProfile
end function

public subroutine of_setedicache ();if isvalid(ids_ediCache) then
	destroy ids_ediCache
end if

ids_ediCache = create n_ds
n_cst_setting_edi204version	lnv_204Version

lnv_204Version = CREATE n_cst_setting_edi204version
IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct or &
	lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_EDIVersion_DirectWithAutoReply THEN
	ids_ediCache.dataobject = 'd_edistatuspending_ds'
ELSE
	ids_ediCache.dataobject = 'd_Edi_EventCache'
END IF	
DESTROY ( lnv_204Version )


ids_ediCache.settransobject(SQLCA)
ids_ediCache.Retrieve()
Commit;

end subroutine

public function integer of_addtocache (long al_coid, long al_event);/*
THIS method look for dups

*/

integer	li_Return

String	ls_Status, &
			ls_Reason, &
			ls_FindString
			
Long		ll_EventID, &
			ll_NextId, &
			ll_NewRow, &
			ll_FindRtn, &
			ll_Rtn = 1

Date		ld_Date, &
			ld_StatusDate

Time		lt_StatusTime

Boolean	lb_NewRow

CONSTANT Boolean cb_Commit	= TRUE	

n_ds			lds_Cache

lds_Cache  = THIS.of_GetEDICache (false)

IF ll_Rtn = 1 then

	ls_FindString = "edistatus_status = '" + ls_Status + "'" + &
						" AND edi_sourceid = " + String ( ll_EventID ) + &
						" AND edi_source = 'EVENT'" + &
						" AND edi_TransactionSet = " + string(appeon_constant.cl_transaction_set_214) + &
						" AND edi_company = " + string(al_coid) 
						
	ll_FindRtn = lds_Cache.Find (ls_FindString, 1, lds_Cache.rowcount() )

	if ll_FindRtn > 0 then
		//was it already processed
		ld_Date = lds_cache.GetItemDate ( ll_Findrtn ,  "EDI_ProcessedDate" )
			
		if isnull(ld_date) then
		
			// replace row that was found in the cache
			lds_Cache.SetItem ( ll_FindRtn , "edistatus_reason" , ls_Reason )
			lds_Cache.SetItem ( ll_FindRtn , "edistatus_statusdate", ld_statusDate )
			lds_Cache.SetItem ( ll_FindRtn , "edistatus_statustime", lt_StatusTime )
		
			lb_newrow = false
		else
			//already processed, add new row
			lb_newrow = true
		end if
		
	else
		lb_NewRow = true
	end if
	
	if lb_newrow then
		
		IF gnv_App.of_GetNextId ( "edi", ll_NextId, cb_Commit ) = 1 THEN
			
			ll_NewRow = lds_Cache.InsertRow ( 0 )
	
			if ll_Newrow > 0 then
				lds_Cache.SetItem ( ll_NewRow , "edi_transactionSet" , 214 )
				lds_Cache.SetItem ( ll_NewRow , "edi_sourceid" , ll_EventID )
				lds_Cache.SetItem ( ll_NewRow , "edi_source" , 'EVENT' )
				lds_Cache.SetItem ( ll_NewRow , "edi_Company" , al_CoId)
			
				lds_Cache.SetItem ( ll_NewRow , "edistatus_EDIid" , ll_NextId )
				lds_Cache.SetItem ( ll_NewRow , "edistatus_status" , ls_Status )
				lds_Cache.SetItem ( ll_NewRow , "edistatus_reason" , ls_Reason )
				lds_Cache.SetItem ( ll_NewRow , "edistatus_statusdate", ld_statusDate )
				lds_Cache.SetItem ( ll_NewRow , "edistatus_statustime", lt_StatusTime )
			end if
					
		end if
		
	END IF
END IF

RETURN ll_Rtn

end function

public function string of_determinesitetype (long al_coid, n_cst_beo_shipment anv_shipment);string	ls_sitetype

if al_coid = anv_shipment.of_getorigin() then
	ls_SiteType = cs_SiteType_Origin
elseif al_coid = anv_shipment.of_getDestination() then
	ls_SiteType = cs_SiteType_destination			
else
	ls_SiteType = cs_SiteType_not_origdest		
end if

return ls_SiteType
end function

public function integer of_updateedicache ();long		ll_row, &
			ll_rowcount, &
			ll_EDIid, &
			ll_EventId, &
			ll_Coid

integer	li_return = 1

date		ld_processed

time		lt_processed

n_ds	lds_EDICache 

lds_EDICache = this.of_GetEDICache(false)
lds_EDICache.SetFilter('')
lds_EDICache.filter()
ll_rowcount = lds_EDICache.rowcount()

if ll_rowcount > 0 then

	for ll_row = 1 to ll_rowcount

		ll_ediid = lds_EDICache.object.edistatus_ediid[ll_row]
		
		if lds_EDICache.GetItemStatus(ll_row, 0, Primary!) = newmodified! then
			
			ll_eventid = lds_EDICache.object.edi_sourceid[ll_row]
			ll_coid = lds_EDICache.object.edi_company[ll_row]
			ld_Processed = date(string(today(), "mm/dd/yyyy"))
			lt_Processed = time(string(now(), "hh:mm:ss"))


		  INSERT INTO "edi"  
					( "id",   
					  "transactionset",   
					  "sourceid",   
					  "source",   
					  "company",   
					  "processeddate",   
					  "processedtime",
					  "errormessage")  
		  VALUES ( :ll_ediId,   
					  214,   
					  :ll_EventId,   
					  'EVENT',   
					  :ll_coId,   
					  :ld_Processed,   
					  :lt_Processed,
					  null)  ;
		
			if sqlca.sqlcode <> 0 then
				li_return = -1
			end if
			
		else
			if lds_EDICache.GetItemStatus(ll_row, 0, Primary!) = datamodified! then
				ld_processed = lds_EDICache.object.edi_processeddate[ll_row]
				lt_processed = lds_EDICache.object.edi_processedtime[ll_row]

				  UPDATE "edi"  
					  SET "processeddate" = :ld_processed,   
							"processedtime" = :lt_processed  
					WHERE "edi"."id" = :ll_ediid ;
					
			end if
			
		end if
		
	next
end if

if isvalid(lds_EDICache) then
	commit;
	if lds_EDICache.update() = 1 then
		commit;
		li_return = 1
	else
		li_return = -1
	end if
end if

return li_return

end function

public function integer of_processededi (long al_id, string as_error);integer	li_return=1
string	ls_findstring
long		ll_foundrow
date		ld_Processed
time		lt_processed

n_ds 	lds_EDICache

lds_EDICache = this.of_getEDICache(false)

ld_Processed = date(now())
lt_Processed = time(now())

ls_findstring = "edistatus_EDIid = " + string(al_id)
ll_foundrow = lds_EDICache.find(ls_findstring, 1, lds_EDICache.rowcount())
if ll_foundrow > 0 then
	lds_EDICache.object.edi_processeddate[ll_foundrow] = ld_Processed
	lds_EDICache.object.edi_processedtime[ll_foundrow] = lt_Processed
	lds_EDICache.object.edi_errormessage[ll_foundrow] = as_error
else
	li_return = -1
end if	

return li_return

end function

public function integer of_loadevent (long al_eventid);n_cst_beo_Event	lnva_EmptyEvents[], &
						lnv_Event
n_cst_beo_Item		lnva_EmptyItems[]

integer	li_Return = 1

if isvalid(inv_dispatch) then
	//already created, will be destroyed in tbe destructor
else
	inv_dispatch = create n_cst_bso_dispatch
end if

if li_return = 1 then

	DESTROY ( inv_Shipment )
	
	inva_Event = lnva_EmptyEvents
	inva_Item = lnva_EmptyItems
	
	IF NOT IsNull ( al_EventId ) THEN

		IF inv_Dispatch.of_RetrieveEvents ( { al_EventId } ) = 1 THEN
			
			ids_EventCache = inv_Dispatch.of_GetEventCache ( )		
			lnv_Event = CREATE n_cst_beo_Event
			lnv_Event.of_SetSource ( ids_EventCache )
			lnv_Event.of_SetSourceId ( al_EventId )
			if inv_Dispatch.of_RetrieveShipment( lnv_Event.of_GetShipment() ) = 1 then
				ids_Shipment = inv_Dispatch.of_GetShipmentCache ( )
				ids_ItemCache = inv_Dispatch.of_GetItemCache ( )
				inv_Shipment = CREATE n_cst_beo_Shipment
				inv_Shipment.of_SetSource ( ids_Shipment )
				inv_Shipment.of_SetSourceId ( lnv_Event.of_GetShipment() )

				//nwl added 11/02/04
				inv_Shipment.of_SetEventSource ( ids_EventCache )
				inv_Shipment.of_SetItemSource ( ids_ItemCache )
				//
				
				lnv_Event.of_SetShipment(inv_Shipment)
			end if
			
			inva_Event [ 1 ] = lnv_Event
			inv_Event = lnv_Event	//Note: This variable existed prior to 3.5.23, but nothing 
											//prior to 3.5.23 that I could see was populating it.
		
		ELSE
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF

end if

return li_return

end function

protected function long of_getstatusrole (ref string as_role, long al_coid, string as_eventtype, n_cst_beo_shipment anv_shipment, ref n_ds ads_statusprofile, long al_eventsiteid, string as_action);string	ls_Find, &
			ls_EventType, &
			ls_SiteType, &
			ls_movecode
			
long		ll_Found			
	
ads_StatusPRofile = this.of_GetStatusProfile()

ads_StatusProfile.retrieve(al_coid, appeon_constant.cl_transaction_set_214)
Commit;
if ads_StatusPRofile.rowcount() > 0  then
	choose case anv_shipment.of_GetMoveCode()
		case 'I'
			ls_movecode = 'I'
		case 'E'
			ls_movecode = 'E'
		case 'O'
			ls_movecode = 'O'
		case else
			ls_movecode = ''
	end choose
	
	ls_SiteType = this.of_DetermineSiteType(al_eventSiteId, anv_Shipment)
	
	choose case ls_SiteType
			
		case cs_SiteType_Origin, cs_SiteType_Destination, cs_SiteType_not_origdest
			
			if as_action = 'UPDATE' then
				//don't include action in find
				ls_find = "transactionset = " + string(appeon_constant.cl_transaction_set_214) + &
						 	 " and companyid = " + string(al_coid) + &
					 		 " and eventtype = '" + as_eventtype + "'" +& 
							 " and sitetype = '" + ls_SiteType + "'" +&
							 " and movecode = '" + ls_movecode + "'" 
			else
				
				ls_find = "transactionset = " + string(appeon_constant.cl_transaction_set_214) + &
							 " and companyid = " + string(al_coid) + &
							 " and eventtype = '" + as_eventtype + "'" +& 
							 " and sitetype = '" + ls_SiteType + "'" +&
							 " and movecode = '" + ls_movecode + "'" +&
							 " and action = '" + as_action + "'"
							 
			end if
			
			ll_found = ads_StatusProfile.find(ls_find, 1, ads_StatusProfile.rowcount())
	
	end choose		 
	if ll_found > 0 then
		as_role = ads_StatusProfile.object.statusrole[ll_found]
	else
		//try any
		if as_action = 'UPDATE' then
			//don't include action in find
			ls_find = "transactionset = " + string(appeon_constant.cl_transaction_set_214) + &
						 " and companyid = " + string(al_coid) + &
						 " and eventtype = '" + as_eventtype + "'" + &
						 " and sitetype = '" + cs_SiteType_any + "'" +&
						 " and movecode = '" + ls_movecode + "'" 

		else
			ls_find = "transactionset = " + string(appeon_constant.cl_transaction_set_214) + &
						 " and companyid = " + string(al_coid) + &
						 " and eventtype = '" + as_eventtype + "'" + &
						 " and sitetype = '" + cs_SiteType_any + "'" +&
						 " and movecode = '" + ls_movecode + "'" +&
						 " and action = '" + as_action + "'"
		end if
		
		 ll_found = ads_StatusProfile.find(ls_find, 1, ads_StatusProfile.rowcount())

		 if ll_found > 0 then

			as_role = ads_StatusProfile.object.statusrole[ll_found]
		end if
	end if 
	
end if

return ll_found


end function

public function boolean of_createedi (n_cst_beo_event anv_event, n_cst_beo_shipment anv_shipment, n_ds ads_edipending, long al_pendingrow, long al_coid, string as_rolematch, ref long ala_createid[]);long		ll_eventid, &
			ll_coid, &
			ll_EventSiteId, &
			ll_NextId, &
			ll_newrow, &
			ll_ProfileRow
		
String	ls_eventtype, &
			ls_Role, &
			ls_Status, &
			ls_Reason, &
			ls_Action, &
			ls_AdditionalStatus
			
Integer	li_MinuteOffset			
			
Date		ld_status

Time		lt_Status, &
			lt_Additional
			
boolean	lb_create

CONSTANT Boolean cb_Commit	= TRUE	
Boolean	lb_Continue = TRUE
Boolean	lb_NeedAssignmentNumber
n_ds		lds_EDICache, &
			lds_StatusProfile

lds_EDICache = this.of_GetEDICache(false)

ll_EventId = anv_event.of_Getid()
ll_EventSiteId = anv_event.of_GetSite()
ls_eventtype = anv_event.of_Gettype()
ls_Action = ads_EDIPending.object.action[al_Pendingrow]
ll_ProfileRow = this.of_GetStatusRole(ls_role, al_coid, ls_eventtype, anv_shipment, lds_StatusPRofile, ll_EventSiteId, ls_action)
if ll_ProfileRow > 0 then			
	
	// check to see if we are only to send files for events that have stop assignment numbers on them
	lb_NeedAssignmentNumber = lds_StatusProfile.GetItemNumber ( ll_ProfileRow, "needsstopindicator" ) = 1
	
	IF lb_NeedAssignmentNumber THEN 
		IF isNull ( anv_event.of_GetImportReference ( )) THEN
			lb_Continue = FALSE
		END IF
	END IF
	
	if lb_Continue AND (  ls_role = as_RoleMatch or ls_role = cs_StatusRole_any )then
		choose case UPPER(ls_Action)
			case "ARRIVE"
				ld_status = anv_Event.of_GetDateArrived ( )
				lt_status = anv_Event.of_GetTimeArrived ( )
				ls_status = lds_StatusPRofile.object.Status[ll_ProfileRow]
				ls_reason = lds_StatusPRofile.object.reason[ll_ProfileRow]
			case "DEPART"
				ld_status = anv_Event.of_GetDateDeparted ( )
				lt_status = anv_Event.of_GetTimeDeparted ( )
				ls_status = lds_StatusPRofile.object.Status[ll_ProfileRow]
				ls_reason = lds_StatusPRofile.object.reason[ll_ProfileRow]
			case "SCHEDULE"
				ld_status = anv_Event.of_GetScheduledDate ( )
				lt_status = anv_Event.of_GetScheduledTime ( )
				ls_status = lds_StatusPRofile.object.Status[ll_ProfileRow]
				ls_reason = lds_StatusPRofile.object.reason[ll_ProfileRow]
				
			case "UPDATE"
				ls_status = ads_EDIPending.object.status[al_Pendingrow]
				ls_reason = ads_EDIPending.object.reason[al_Pendingrow]
				ld_status = ads_EDIPending.object.statusdate[al_Pendingrow]
				lt_status = ads_EDIPending.object.statustime[al_Pendingrow]		
		end choose
	
		IF gnv_App.of_GetNextId ( "edi", ll_NextId, cb_Commit ) = 1 THEN
			
			ll_NewRow = lds_EDICache.InsertRow ( 0 )
		
			if ll_Newrow > 0 then
				lds_EDICache.SetItem ( ll_NewRow , "edi_transactionSet" , 214 )
				lds_EDICache.SetItem ( ll_NewRow , "edi_sourceid" , ll_EventID )
				lds_EDICache.SetItem ( ll_NewRow , "edi_source" , 'EVENT' )
				lds_EDICache.SetItem ( ll_NewRow , "edi_Company" , al_coid)		
				lds_EDICache.SetItem ( ll_NewRow , "edistatus_EDIid" , ll_NextId )
				lds_EDICache.SetItem ( ll_NewRow , "edistatus_statusdate", ld_status )
				lds_EDICache.SetItem ( ll_NewRow , "edistatus_statustime", lt_Status )		
				lds_EDICache.SetItem ( ll_NewRow , "edistatus_status" , ls_Status )
				lds_EDICache.SetItem ( ll_NewRow , "edistatus_reason" , ls_reason )
			
				ala_createid[upperbound(ala_Createid) + 1] = ll_NextId
				lb_create = true
				
			end if
		
		end if
		//check for an additional status
		ls_AdditionalStatus = lds_StatusPRofile.object.AdditionalStatus[ll_ProfileRow]
		if len(trim(ls_AdditionalStatus)) > 0 then
			li_MinuteOffset = lds_StatusPRofile.object.MinuteOffset[ll_ProfileRow]
			if li_MinuteOffset <> 0 then
				lt_Additional = RelativeTime ( lt_Status, li_MinuteOffset * 60 )
				IF gnv_App.of_GetNextId ( "edi", ll_NextId, cb_Commit ) = 1 THEN
					
					ll_NewRow = lds_EDICache.InsertRow ( 0 )
				
					if ll_Newrow > 0 then
						lds_EDICache.SetItem ( ll_NewRow , "edi_transactionSet" , 214 )
						lds_EDICache.SetItem ( ll_NewRow , "edi_sourceid" , ll_EventID )
						lds_EDICache.SetItem ( ll_NewRow , "edi_source" , 'EVENT' )
						lds_EDICache.SetItem ( ll_NewRow , "edi_Company" , al_coid)		
						lds_EDICache.SetItem ( ll_NewRow , "edistatus_EDIid" , ll_NextId )
						lds_EDICache.SetItem ( ll_NewRow , "edistatus_statusdate", ld_status )
						lds_EDICache.SetItem ( ll_NewRow , "edistatus_statustime", lt_Additional )		
						lds_EDICache.SetItem ( ll_NewRow , "edistatus_status" , ls_AdditionalStatus )
						lds_EDICache.SetItem ( ll_NewRow , "edistatus_reason" , ls_reason )
					
						ala_createid[upperbound(ala_Createid) + 1] = ll_NextId
						lb_create = true
						
					end if
				
				end if
			end if
		end if	
	end if
end if
						
return lb_Create

end function

protected function string of_getoutboundmappingfile ();Long	ll_RowCount
String	ls_File
Long	ll_CoID

DataStore	lds_Mappings
lds_Mappings = CREATE DataStore
lds_Mappings.DataObject = "d_mappingfiles"
lds_Mappings.SetTransobject ( SQLCA )


ll_CoID = THIS.of_Getedicompanyid( )

IF ll_CoID > 0 THEN

	ll_RowCount = lds_Mappings.Retrieve ( ll_CoID , 214 )
	Commit;
	IF ll_RowCount> 0 THEN
		
		ls_File = lds_Mappings.GetItemString ( 1 , "MappingFile" )
		
	END IF

END IF

DESTROY ( lds_Mappings )

RETURN ls_File
end function

public function integer of_processalledi (string asa_header[], string asa_footer[], long ala_ids[], string as_outputfolder, string asa_templatearray[]);return 1
end function

protected function string of_getidcolname ();//uses d_ediStatuspending_ds
return "edi_sourceId"
end function

public function string of_geterrorcontext (long ala_ids[]);//Dan 5-16-06 Only returns an error if there is one  id.  Returns null otherwise.
//...Uses d_ediStatusPending_ds
String	ls_null
String	ls_return
SetNull( ls_null )
n_ds		lds_cache
Long		ll_max
Long		ll_index

Long		ll_coId				//to resolve company name
Long		ll_ediSourceId		//to resolve shipment
String	ls_ediSource		//to resolve shipment
String	ls_ediStatus		//to resolve the definition from edi_status table.

Long		ll_shipId
String	ls_statusDefinition
String	ls_companyName

String	ls_find

String	ls_ship
String	ls_companyError
String	ls_event
String	ls_codeMessage

ls_return = String(Today(), "m/d/yy hh:mm")+"~r~n214 could not be sent. Problem Related to: ~r~n"

//Since the 214 tries to keep sending events by splitting the ids in half over and over,
//until only one event doesn't go, we don't want an error message to be logged if there
//is more then one id.  
IF upperBound( ala_ids ) = 1 THEN
	lds_cache = this.of_getEdicache( FALSE )
	
	IF isValid( lds_cache ) THEN
		ll_max = lds_cache.rowCount()
		
		ls_find = "edi_sourceId = "+ string( ala_ids[1] )
		
		ll_index = lds_cache.find( ls_find, 1, ll_max )
		
		IF ll_index > 0 THEN
	
			ll_coId = lds_cache.GetItemNumber( ll_index, "edi_company" )
			ll_ediSourceId = lds_cache.GetItemNumber( ll_index, "edi_sourceid" )
			ls_ediSource = lds_cache.getitemString( ll_index, "edi_source" )  //should be "EVENT"
			ls_ediStatus = lds_cache.getItemString( ll_index, "edistatus_status" )
			
			ls_companyName = this.of_getScac( )
			ll_shipId = inv_shipment.of_getid( )		//not sure if this is right
			
			//get the shipment that is related to the event that was just confirmed.
			SELECT de_shipment_id
				 	INTO :ll_shipId
				 	FROM "disp_events"  
					WHERE "disp_events"."de_id" = :ll_ediSourceId;
			COMMIT;
			
			CHOOSE CASE SQLCA.sqlcode
				CASE 100
					//not found
					ls_ship = "Shipment: not found."
				CASE -1
					//error
					ls_ship = "Shipment: error retrieving shipment."
				CASE 0
					//success
					ls_ship = "Shipment: "+ string( ll_shipId )
			END CHOOSE
			
			
			//get the company name.
			SELECT co_name
				 	INTO :ls_companyName
				 	FROM "companies"  
					WHERE "companies"."co_id" = :ll_coid;
			COMMIT;
			
			CHOOSE CASE SQLCA.sqlcode
				CASE 100
					//not found
					ls_companyError ="Company Name: not found"
				CASE -1
					//error
					ls_companyError ="Company Name: error retrieving company name."
				CASE 0
					//success
					ls_companyError ="Company Name: "+ ls_companyName
			END CHOOSE
				
			//get the meaning behind the code of the event.
			SELECT definition
				 	INTO :ls_statusDefinition
				 	FROM "edi_status"  
					WHERE "edi_status"."code" = :ls_edistatus;
			COMMIT;
			
			CHOOSE CASE SQLCA.sqlcode
				CASE 100
					//not found
					IF not Isnull( ls_ediStatus ) THEN
						ls_codeMessage = "EDI Code definition: not found. Code in file '"+ls_edistatus+"'"
					ELSE
						ls_codeMessage = "EDI Code definition: not found. Code in file was null."
					END IF
				CASE -1
					//error
					ls_codeMessage = "EDI Code definition: Error retrieving definition."
				CASE 0
					//success
					IF ls_statusDefinition <> "" THEN
						ls_codeMessage = "EDI Code definition: "+ ls_StatusDefinition
					ELSE
						IF not IsNull( ls_ediStatus ) THEN
							ls_codeMessage = "EDI Code definition: no description for '"+ ls_ediStatus+"'"
						ELSE
							ls_codeMessage = "EDI Code definition: description was null"
						END IF
					END IF
			END CHOOSE
			
			
			IF not IsNull(ll_ediSourceId) THEN
				ls_event = "Event Id: "+ string( ll_ediSourceId )
			ELSE
				ls_event = "Event Id: Null"
			END IF
		END IF
	END IF
	
	ls_return += ls_event + "~r~n" + ls_ship + "~r~n" + ls_companyError + "~r~n" + ls_codeMessage 
	ls_return += "~r~nTry opening the shipment and check the event data.  The original steps to confirm the event~r~n should be recompleted, ie: uncheck confirm event, change time/date, and check confirm."
ELSE
	ls_return = ls_null
END IF

RETURN 	ls_return
end function

public subroutine of_sendtransaction (long ala_id[], datastore ads_edicache);//created by dan 9-18-2006,  This code was taken from the other version of of_sendtrasaction.
//There was a problem with getting edi cache for every recursive call and ending up with duplicate edi_ids
//in it.  

/*
		What to expect for failed results:  
		
			EG:  Confirm an event with 7 events  yields 7 errors, 1 per event.
			
					 	Results:
						 		7 errors in the dynamic window error log, (1 for each event that had an error)
								 
								 
								 
								13 files are created in this order
								
								File#			Event IDs Total passed in				Errors #			Logged
								-----			-------------------------				---------		------
								1.				7 												7 errors			no
								2.					3 											3 errors			no
								3. 					1 										1 error		 	yes
								4.						2										2 errors			no
								5.							1									1 error			yes
								6.							1									1 error			yes
								7.					4											4 errors			no
								8.						2										2 errors			no
								9.							1									1 error			yes
								10.						1									1 error			yes
								11.					2										2 errors			no
								12.						1									1 error			yes
								13.						1									1 error 			yes
								----------------------------------------------------------------------
*/

Integer	li_InputFile

long		ll_row, &
			ll_rowcount, &
			ll_eventid, &
			ll_ediid, &
			ll_coid, &
			lla_Coid[], &
			ll_CompanyCount, &
			ll_Index, &
			ll_Count, &
			i
			
			
Long		lla_idSubset1[]
Long		lla_idSubset2[]
Long		ll_subSize
Long		ll_subIndex
Long		ll_subSizeDividedby2
Long		ll_ediTempId
			
string	ls_filter, &
			ls_outputfolder, &
			ls_outputfile, &
			ls_templatefile, &
			ls_value, &
			ls_error, &
			ls_ControlNumber, &
			lsa_Transaction[], &
			lsa_Blank[], &
			lsa_Results[], &
			lsa_TemplateArray[], &
			lsa_TemplateHeader[], &
			lsa_TemplateFooter[]

boolean	lb_error
boolean	lb_validated

n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_sql			lnv_Sql
s_parm 				lstr_parm	
n_cst_msg			lnv_tagmessage, &
						lnv_BlankMessage
				

//ls_controlnumber = this.of_GetControlNumber()

if upperbound(ala_id) > 0 then
	ls_filter = "edi_transactionset = 214 and edistatus_ediid" + lnv_sql.of_makeinclause(ala_id)
else
	ls_filter = "edi_transactionset = 214 and isnull(edi_processeddate)"
end if

ads_edicache.setfilter(ls_filter)
ads_edicache.filter()

ll_rowcount =ads_edicache.rowcount()

//	load company id array, shrink array to unique ids, 
//	loop thru companies filtering datastore to the company and 
//	create a seperate file for each company
for ll_row = 1 to ll_rowcount
	lla_coid[ll_row] = ads_edicache.object.edi_company[ll_row]
next

ll_CompanyCount = lnv_ArraySrv.of_getshrinked( lla_coid, true, true) 
Long	ll_CoIndex
for ll_CoIndex = 1 to ll_CompanyCount
	
	//set up next company file
	
	lsa_Results = lsa_Blank
	ls_outputfile = ""
	
	
	ls_filter = "edi_transactionset = 214 and edistatus_ediid" + lnv_sql.of_makeinclause(ala_id) +" and edi_company = " + string(lla_coid[ll_CoIndex])
	ads_edicache.setfilter(ls_filter)
	ads_edicache.filter()
	
	ll_rowcount = ads_edicache.rowcount()
	
	if ll_rowcount > 0 then
		ll_coid =  ads_edicache.object.edi_company[1]
		ll_ediid = ads_edicache.object.edistatus_ediid[1]
		
		FOR i = ll_rowCount TO 1 STEP -1
			IF i > 1 THEN
				//Dan - 9-7-06 for the 2nd recursive call, there manages to be more then
				// 				one row with the same ll_ediId, so it was duplicating information.
				//					This makes sure there is no duplicate information.
				IF ll_ediid = ads_edicache.getItemNumber( i, "edistatus_ediid" ) THEN
					ads_edicache.rowsDiscard( i, i,PRIMARY! )
				END IF
			END IF
		NEXT
		ll_rowCount = ads_edicache.rowcount()
	else
		CONTINUE
	end if
	
	THIS.of_Setedicompanyid( ll_Coid )
	ls_controlnumber = this.of_GetControlNumber()		
		
	ls_outputfolder = this.of_GetOutputFolder( appeon_constant.cl_transaction_set_214, ll_coid, "OUTBOUND" )
	
	if len(trim(ls_outputfolder)) > 0 then
		//ok
	else
		if this.of_getsystemfilepath("EDI214", ls_outputfolder) = 1 then
			//ok
		else
			lb_error = true
			ls_error = "No output folder in company profile or system settings. Message not sent"
		end if
	end if
			
	
	//get the file	
	ls_templatefile = this.of_GetTemplateFile( appeon_constant.cl_transaction_set_214, ll_coid, "OUTBOUND" )
		
	//Read template file and load into array
	if FileExists ( ls_templatefile ) then	
		//input file, read
		li_InputFile = FileOpen(ls_templatefile, LineMode!, Read!, Shared!)
		THIS.of_loadtemplateintoarray( li_InputFile , lsa_TemplateArray, lsa_TemplateHeader, lsa_TemplateFooter )
		Fileclose(li_InputFile)
	ELSE
		CONTINUE
	END IF
	
	//loop thru all rows for this company
	for ll_row = 1 to ll_rowcount
		
		lb_error = false
		ls_error = ''
		lsa_transaction = lsa_blank
		lnv_tagmessage = lnv_BlankMessage			
		ll_eventid = ads_edicache.object.edi_sourceid[ll_row]
		ll_ediid = ads_edicache.object.edistatus_ediid[ll_row]
		
		//THIS.li_edicoid = ll_Coid // li_EDICode is a misnamed instance var.
		THIS.of_SetEDIcompanyid( ll_coid )			
			
		this.of_LoadEvent(ll_EventId)
		inv_Shipment.of_Setcontextcompany( ll_coid ) // this is used to resolve aliases (i thought I had put this in once before but I Guess not)
		inv_Event.of_Setcontextcompany( ll_coid ) // this is used to resolve aliases (i thought I had put this in once before but I Guess not)
			
		lstr_parm.is_Label = "STATUS"
		ls_value = ads_edicache.object.edistatus_status[ll_row]
		if isnull(ls_value) then
			ls_value = ''
		end if
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
		lstr_parm.is_Label = "REASON"
		ls_value = ads_edicache.object.edistatus_reason[ll_row]
		if isnull(ls_value) then
			ls_value = ''
		end if
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
		lstr_parm.is_Label = "STATUSDATE"
		ls_value = string(ads_edicache.object.edistatus_statusDate[ll_row],"yyyymmdd")
		if isnull(ls_value) then
			ls_value = ''
		end if
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
		lstr_parm.is_Label = "STATUSTIME"
		ls_value = string(ads_edicache.object.edistatus_statusTime[ll_row],"hhmm")
		if isnull(ls_value) then
			ls_value = ''
		end if
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
//		this.of_Createfile( ls_templatefile, ls_outputfolder, ls_outputfile, {inv_event}, lnv_tagmessage )

		//with this
		
		if ll_row = 1 then 
			//start with header
			THIS.of_Processloop( lsa_TemplateHeader , lsa_transaction , lnv_TagMessage , inv_Event )
			ll_count = upperbound(lsa_transaction)
			for ll_index = 1 to ll_count
				lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
			next			
		end if
		
		THIS.of_Processloop( lsa_TemplateArray , lsa_transaction , lnv_TagMessage , inv_Event )
		//move to the results array
		ll_count = upperbound(lsa_transaction)
		for ll_index = 1 to ll_count
			lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
		next
		
		this.of_ProcessedEDI(ll_EDIId, ls_error)
				
	next
	//end of rows for this company
	
	//processloopelements
	THIS.of_Processloop( lsa_TemplateFooter , lsa_transaction , lnv_TagMessage , inv_Event )
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
		
		//gets the edi file name from the schema if it has one otherwise does the old way
		ls_outputFile = this.of_getEditransactionfilename( inv_event, ls_controlNumber )
		IF isNull( ls_outputFile ) OR ls_outputfile = "" THEN
			ls_outputfile = ls_controlnumber + this.of_GetOutboundfileextension( )
		END IF
	end if
	
	ls_outputfile = ls_outputfolder + "\" + ls_outputfile
	
	IF THIS.of_Writeresultstofile( lsa_Results , ls_outputfile ) = -2 THEN
		//did not validate, we want to split the ids in half and send it again.
		
		ll_subSize = upperBound( ala_id ) 
		
		IF ll_subSize = 1 THEN
			//then we exit because we found a bad event
		ELSE
			//split the ids and resend for each.
			FOR ll_subIndex = 1 TO ll_subSize		
				IF ll_subIndex <= (ll_subSize/2) THEN
					lla_idSubset1[ll_subIndex] = ala_id[ll_subIndex]
				ELSE
					ll_subSizeDividedby2 = ll_subSize/2
					lla_idSubset2[ll_subIndex - ll_subSizeDividedby2] = ala_id[ll_subIndex]
				END IF
			NEXT
		END IF
		
		IF upperBound( lla_idSubset1 )  > 0 THEN
			this.of_sendTransaction( lla_idSubset1, ads_edicache )
		END IF
		
		IF upperBound( lla_idSubset2 ) > 0 THEN
			this.of_sendTransaction( lla_idSubset2, ads_ediCache )
		END IF
		
	END IF
	//---------------
next

//this.of_updateedicache( )




end subroutine

public subroutine of_createtransaction (ref n_ds ads_edipending, ref long ala_ediid[], ref long ala_sourceid[]);//check for edi updates to company

long	ll_shipid, &
		ll_EventId, &
		ll_SiteId, &
		ll_coId, &
		lla_coid[], &
		lla_CreateEDI[], &
		lla_Blank[], &
		ll_row, &
		ll_count, &
		ll_rowcount, &
		ll_newrow, &
		ll_nextid, &
		ll_return=1
		

string	ls_SiteType, &
			ls_role, &
			ls_status, &
			ls_reason
			
date		ld_status
time		lt_status
	
boolean	lb_createdEDI

CONSTANT Boolean cb_Commit	= TRUE	

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_shipment	lnv_shipment
n_cst_beo_event		lnv_event

n_cst_anyarraysrv			lnv_ArraySrv

n_ds		lds_EDICache

lds_EDICache = this.of_GetEDICache(false)

lnv_Dispatch = Create n_cst_bso_Dispatch		
lnv_Shipment = CREATE n_cst_beo_Shipment
lnv_event = CREATE n_cst_beo_Event

ll_rowcount = ads_EDIPending.rowcount()

for ll_row = 1 to ll_rowcount
	
	GARBAGECOLLECT ( )
	
	ll_EventId = ads_EDIPending.object.sourceid[ll_row]
	lnv_Dispatch.of_RetrieveEvents({ll_eventid})
	lnv_Event.of_SetSource ( lnv_dispatch.of_GetEventCache ( ) )
	lnv_Event.of_SetSourceId ( ll_EventId )
	ala_Sourceid[ll_row] = ll_EventId
		
	lb_createdEDI = false
	
	ll_CoId = ads_EDIPending.object.company[ll_row]
	
	if ll_CoId > 0 then
		//send only to designated company
		ls_status = ads_EDIPending.object.status[ll_row]
		ls_reason = ads_EDIPending.object.reason[ll_row]
		ld_status = ads_EDIPending.object.statusdate[ll_row]
		lt_status = ads_EDIPending.object.statustime[ll_row]		

		IF gnv_App.of_GetNextId ( "edi", ll_NextId, cb_Commit ) = 1 THEN
			
			ll_NewRow = lds_EDICache.InsertRow ( 0 )
		
			if ll_Newrow > 0 then
				lds_EDICache.SetItem ( ll_NewRow , "edi_transactionSet" , 214 )
				lds_EDICache.SetItem ( ll_NewRow , "edi_sourceid" , ll_EventID )
				lds_EDICache.SetItem ( ll_NewRow , "edi_source" , 'EVENT' )
				lds_EDICache.SetItem ( ll_NewRow , "edi_Company" , ll_coid)		
				lds_EDICache.SetItem ( ll_NewRow , "edistatus_EDIid" , ll_NextId )
				lds_EDICache.SetItem ( ll_NewRow , "edistatus_statusdate", ld_status )
				lds_EDICache.SetItem ( ll_NewRow , "edistatus_statustime", lt_Status )		
				lds_EDICache.SetItem ( ll_NewRow , "edistatus_status" , ls_Status )
				lds_EDICache.SetItem ( ll_NewRow , "edistatus_reason" , ls_reason )
			

				lla_CreateEDI[upperbound(lla_CreateEDI) + 1] = ll_NextId
				lb_CreatedEDI = true
				
			end if
		
		end if
		
	else
		if lnv_Event.of_HasSource ( ) THEN
		
			ll_SiteId = lnv_event.of_getsite()
			ll_Shipid = lnv_event.of_GetShipment( )
			
			if isnull(ll_ShipId) then
				//no good
			else
				lnv_dispatch.of_retrieveshipments({ll_shipid})
				lnv_shipment.of_setsource(lnv_dispatch.of_getshipmentcache())
				lnv_shipment.of_setsourceid(ll_shipid)
			end if
		
		End if
		
		if lnv_shipment.of_hassource() then
			
			lla_coid = lla_blank
			
			//site
			ll_CoId = ll_SiteId
			if ll_coid > 0 then
				
				if this.of_CreateEDI(lnv_event, lnv_shipment, ads_EDIPending, ll_row, ll_CoId, cs_StatusRole_ImTheSite, lla_CreateEDI ) then
					ll_count ++
					lla_coid[ll_count] = ll_coid
					lb_CreatedEDI = TRUE
				end if
				
			end if
	
			//billto
			ll_coid = lnv_Shipment.of_GetBillto()
			if ll_coid > 0 then
				if lnv_Arraysrv.of_Findlong(lla_coid, ll_coid, 1, upperbound(lla_coid)) > 0 then
					//already getting message
				else
					if this.of_CreateEDI(lnv_event, lnv_shipment, ads_EDIPending, ll_row, ll_CoId, cs_StatusRole_Billto, lla_CreateEDI ) then
						ll_count ++
						lla_coid[ll_count] = ll_coid
						lb_CreatedEDI = TRUE
					end if
	
				end if
				
			end if
			
			//origin
			ll_coid = lnv_Shipment.of_Getorigin()
			if ll_coid > 0 then
				if lnv_Arraysrv.of_Findlong(lla_coid, ll_coid, 1, upperbound(lla_coid)) > 0 then
					//already getting message
				else		
					if this.of_CreateEDI(lnv_event, lnv_shipment, ads_EDIPending, ll_row, ll_CoId, cs_StatusRole_Origin, lla_CreateEDI ) then
						ll_count ++
						lla_coid[ll_count] = ll_coid
						lb_CreatedEDI = TRUE
					end if
	
				end if
			end if
			
			//destination
			ll_coid = lnv_Shipment.of_GetDestination()
			if ll_coid > 0 then
				if lnv_Arraysrv.of_Findlong(lla_coid, ll_coid, 1, upperbound(lla_coid)) > 0 then
					//already getting message
				else				
					if this.of_CreateEDI(lnv_event, lnv_shipment, ads_EDIPending, ll_row, ll_CoId, cs_StatusRole_Destination, lla_CreateEDI ) then
						ll_count ++
						lla_coid[ll_count] = ll_coid
						lb_CreatedEDI = TRUE
					end if
	
				end if
			end if
			
			//Carrier
			ll_coid = lnv_Shipment.of_getcarrier()
			if ll_coid > 0 then
				if lnv_Arraysrv.of_Findlong(lla_coid, ll_coid, 1, upperbound(lla_coid)) > 0 then
					//already getting message
				else
					if this.of_CreateEDI(lnv_event, lnv_shipment, ads_EDIPending, ll_row, ll_CoId, cs_StatusRole_carrier, lla_CreateEDI ) then
						ll_count ++
						lla_coid[ll_count] = ll_coid
						lb_CreatedEDI = TRUE
					end if
	
				end if
			end if
	
			//Agent
			ll_coid = lnv_Shipment.of_getagent()
			if ll_coid > 0 then
				if lnv_Arraysrv.of_Findlong(lla_coid, ll_coid, 1, upperbound(lla_coid)) > 0 then
					//already getting message
				else
					if this.of_CreateEDI(lnv_event, lnv_shipment, ads_EDIPending, ll_row, ll_CoId, cs_StatusRole_agent, lla_CreateEDI ) then
						ll_count ++
						lla_coid[ll_count] = ll_coid
						lb_CreatedEDI = TRUE
					end if
	
				end if
			end if
	
			//Forwarder
			ll_coid = lnv_Shipment.of_getforwarder()	
			if ll_coid > 0 then
				if lnv_Arraysrv.of_Findlong(lla_coid, ll_coid, 1, upperbound(lla_coid)) > 0 then
					//already getting message
				else
					if this.of_CreateEDI(lnv_event, lnv_shipment, ads_EDIPending, ll_row, ll_CoId, cs_StatusRole_Forwarder, lla_CreateEDI ) then
						ll_count ++
						lla_coid[ll_count] = ll_coid
						lb_CreatedEDI = TRUE
					end if
	
				end if
			end if
		end if
	end if
	
next

if upperbound(ala_Sourceid) > 1 then
	lnv_Arraysrv.of_GetShrinked ( ala_Sourceid, TRUE /*Shrink Nulls */, TRUE /*Shrink dupes */)	
end if

if upperbound(lla_CreateEDI) > 0 then
	ala_EDIid = lla_CreateEDI
end if

DESTROY lnv_Dispatch
DESTROY lnv_Shipment
DESTROY lnv_event 


end subroutine

on n_cst_edi_transaction_214.create
call super::create
end on

on n_cst_edi_transaction_214.destroy
call super::destroy
end on

event destructor;DESTROY inv_Shipment

Int i
Long	ll_EventCount
ll_EventCount = UpperBound ( inva_event[] )
FOR i = 1 TO ll_EventCount 
	DESTROY ( inva_event[i] )
NEXT

if isvalid(ids_edistatus) then
	destroy ids_edistatus
end if

if isvalid(ids_StatusProfile) then
	destroy ids_StatusProfile
end if


end event

event constructor;inv_Shipment = CREATE n_cst_beo_shipment
this.of_setedistatuscache()
this.of_SetNotificationSettingCache()
ii_Transactionset = 214

end event

