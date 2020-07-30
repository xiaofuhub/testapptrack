$PBExportHeader$n_cst_edi_transaction.sru
forward
global type n_cst_edi_transaction from n_base
end type
end forward

global type n_cst_edi_transaction from n_base
end type
global n_cst_edi_transaction n_cst_edi_transaction

type variables
Constant string cs_transaction_edicache = 'd_edi'

protected:
long				li_EDICoid
datastore			ids_transaction
string			is_controlnumber, &
					is_direction
					
n_cst_beo_event		inva_event[], &
							inv_event  //Not Populated?
n_cst_beo_item		inva_item[]
n_cst_beo_shipment	inv_shipment
n_ds		ids_ShipStatus, &
			ids_datamapping, &
			ids_shipment, &
			ids_eventcache, &
			ids_itemcache, &
			ids_notification, &
			ids_profile, &
			ids_EDICache
			
n_cst_bso_dispatch		 inv_Dispatch

String	is_ouboundMappingFile

boolean	ib_Resend
Int		ii_TransactionSet

end variables

forward prototypes
protected subroutine of_writetotransactiondatastore (string asa_column[], string asa_text[])
protected function datastore of_createdatastore (integer ai_colcount)
public subroutine of_loadtransactions (ref n_cst_msg anv_msg)
public subroutine of_setshipmentstatuscache (n_ds ads_shipstatus)
public subroutine of_setdispatch (n_cst_bso_dispatch anv_dispatch)
public function integer of_loadshipment (long al_shipment)
public subroutine of_setedicompanyid (string as_edicode)
public function long of_getedicompanyid ()
protected function long of_cachedatamapping ()
protected function long of_getdatamappingcache (ref n_ds ads_datamapping)
protected function integer of_filterdatamappingcache (string as_filter)
protected function integer of_getsource (string as_target, ref string as_topic, ref string as_source)
protected subroutine of_setdatamappingdirection (string as_value)
protected function string of_getdatamappingdirection ()
public function long of_geteventbeo (long al_eventid, ref n_cst_beo_event anv_event)
protected subroutine of_getheaderrecord (ref string asa_column[], ref string asa_text[], string as_edicode)
protected subroutine of_gettrailerrecord (ref string asa_column[], ref string asa_text[])
public subroutine of_getshipmentbeo (ref n_cst_beo_shipment anv_shipment)
protected function integer of_mapdataout (string as_target, ref string asa_value[])
public function integer of_gettopicbeo (string as_topic, ref any aaa_beo[])
protected function integer of_mapdataout (long al_row, string as_target, ref string asa_value[])
protected function integer of_getsystemfilepath (string as_editype, ref string as_filepath)
public function integer of_loadevent (long al_eventid)
public subroutine of_setnotificationsettingcache ()
public function integer of_getnotificationsetting (string as_type, long al_coid, string as_direction, string as_action, ref string as_setting)
public subroutine of_processtemplate (long al_company, long al_transactionset)
public function n_ds of_getprofile ()
protected function string of_getcontrolnumber ()
public subroutine of_setedicache ()
public function integer of_processededi (long al_id, string as_error)
public function integer of_updateedicache ()
public subroutine of_sendtransaction (long ala_id[])
public function long of_getcompanyid (string as_scac)
protected subroutine of_createfile (string as_templatefile, string as_outputfolder, ref string as_outputfile, any aaa_beo[], n_cst_msg anv_tagmessage)
public function n_ds of_getedicache (boolean ab_retrieve)
public function boolean of_isaresend ()
public subroutine of_setresend (boolean ab_value)
public function unsignedlong test (integer n, ref integer result)
public function integer of_processsegments (string asa_segments[], pt_n_cst_beo anv_source, string asa_result[], n_cst_msg anv_msg)
private function integer of_processloopelements (ref string asa_loopconstruct[], pt_n_cst_beo anv_source, n_cst_msg anv_tagmsg)
public function integer of_processloop (string asa_loopconstructs[], ref string asa_processedloop[], n_cst_msg anv_tagmsg, pt_n_cst_beo anv_source)
public function integer of_getnextloop (string asa_source[], ref string asa_loopconstruct[], ref string as_datasource, ref integer ai_loopstart, ref integer ai_loopend)
private function integer of_replaceloop (ref string asa_target[], integer ai_start, integer ai_end, string asa_source[])
protected function integer of_writeresultstofile (string asa_results[], string as_outputfile)
protected function integer of_prewriteprocess (ref string asa_results[])
protected function string of_getoutboundmappingfile ()
protected function integer of_setedicompanyid (long al_coid)
public subroutine of_getheaderfootertags (ref n_cst_msg anv_tagmessage)
protected function integer of_loadtemplateintoarray (long al_filehandle, ref string asa_templateresults[], ref string asa_templateheader[], ref string asa_templatefooter[])
public function integer of_getfileformat (ref string as_fileformat)
protected function integer of_loadsegmentandvalidate (ref string as_segment)
protected function string of_getoutboundfileextension ()
protected function character of_getsegmentterminator (readonly string asa_records[])
public function integer of_writeerrorstofile (string as_file, string asa_ediwarnings[])
public function integer of_validateresultfile (string as_filepath, ref string asa_warnings[], ref oleobject anv_edidocument)
public function integer of_sendfile (oleobject anv_edidocument, string as_filepath, string as_topath, string as_fileformat)
protected function string of_getidcolname ()
protected function integer of_getidsfromcache (ref long ala_ids[], string as_columnname)
public function integer of_processalledi (string asa_header[], string asa_footer[], long ala_ids[], string as_outputfolder, string asa_templatearray[])
public function string of_geterrorcontext (long ala_ids[])
public function string of_getremedyobjectstring ()
protected function string of_geteditransactionfilename (any aa_beosource, string as_controlnumber)
public function string of_gettemplatefile (long al_set, long al_coid, string as_type)
public function string of_getoutputfolder (long al_set, long al_coid, string as_type)
public function string of_getscac ()
protected function integer of_addedientry (integer al_transactionset, string as_source, long al_sourceid, long al_company, date ad_processeddate, time at_processedtime, string as_errorstring, string as_inout)
public subroutine of_createtransaction (ref n_ds ads_edipending, ref long ala_ediid[], ref long ala_sourceid[])
public function string of_getseffile ()
end prototypes

protected subroutine of_writetotransactiondatastore (string asa_column[], string asa_text[]);long	ll_colcount, &
		ll_row, &
		ll_ndx

ll_colcount = upperbound(asa_text)
ll_row = ids_transaction.insertrow(0)
for ll_ndx = 1 to ll_colcount
	ids_transaction.setitem(ll_row, ll_ndx, asa_text[ll_ndx])
next	

end subroutine

protected function datastore of_createdatastore (integer ai_colcount);n_cst_Dws	lnv_Dws

RETURN lnv_Dws.of_CreateDataStore ( ai_colcount )
end function

public subroutine of_loadtransactions (ref n_cst_msg anv_msg);//The inherited working object must supply code for this function if it wants it to succeed.

end subroutine

public subroutine of_setshipmentstatuscache (n_ds ads_shipstatus);ids_shipstatus = ads_shipstatus
end subroutine

public subroutine of_setdispatch (n_cst_bso_dispatch anv_dispatch);inv_dispatch = anv_dispatch
end subroutine

public function integer of_loadshipment (long al_shipment);integer	li_Return = 1

if isvalid(inv_dispatch) then
	//already created, will be destroyed in tbe destructor
else
	inv_dispatch = create n_cst_bso_dispatch
end if

if li_return = 1 then
	DESTROY ( inv_Shipment )
	DESTROY ( inv_Event )  //Added 3.5.23 BKW -- this can now be populated by of_LoadEvent
	inv_shipment = CREATE n_cst_beo_Shipment
	
	IF al_shipment > 0 THEN
		IF inv_Dispatch.of_RetrieveShipment ( al_shipment ) = 1 THEN
			
			inv_Dispatch.of_FilterShipment ( al_shipment )
			
			ids_Shipment = inv_Dispatch.of_GetShipmentCache ( )
			ids_EventCache = inv_Dispatch.of_GetEventCache ( )
			ids_ItemCache = inv_Dispatch.of_GetItemCache ( )
			
			inv_Shipment.of_SetSource ( ids_Shipment )
			inv_Shipment.of_SetSourceID ( al_shipment )
			
			inv_Shipment.of_SetEventSource ( ids_EventCache )
			inv_Shipment.of_SetItemSource ( ids_ItemCache )
	
			// get event list will destroy inva_event
			inv_shipment.of_GetEventList ( inva_event )
			inv_shipment.of_GetItemList ( inva_item )
		
		ELSE
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF
end if

return li_return

end function

public subroutine of_setedicompanyid (string as_edicode);long	ll_coid

DECLARE edicursor CURSOR FOR  
	 SELECT "companies"."co_id"  
	 FROM "companies"  
	WHERE "companies"."edi214code" = :as_edicode   ;

OPEN edicursor;

FETCH edicursor INTO :ll_coid;
	
CLOSE edicursor;

COMMIT ;   //Added 3.5.19 BKW -- had been omitted previously.

if isnull(ll_coid) OR ll_coid = 0 then
	ll_Coid = 0
end if

THIS.of_SetEdicompanyID( ll_Coid )
end subroutine

public function long of_getedicompanyid ();return li_edicoid
end function

protected function long of_cachedatamapping ();long	ll_return

if isvalid ( ids_datamapping ) then
	destroy ids_datamapping
end if
													
ids_datamapping = CREATE n_ds
ids_datamapping.DataObject = "d_datamapping"
ids_datamapping.SetTransObject(SQLCA)

ll_return = ids_datamapping.retrieve()
Commit;

return ll_return



end function

protected function long of_getdatamappingcache (ref n_ds ads_datamapping);long	ll_return=0

if not isvalid(ids_datamapping) then
	ll_return = this.of_cachedatamapping()
end if

ads_datamapping = ids_datamapping

if ll_return = 0 then
	ll_return = ads_datamapping.rowcount()
end if

return ll_return


end function

protected function integer of_filterdatamappingcache (string as_filter);integer	li_return = 1

string	ls_filter

ls_filter = as_filter

li_return = ids_datamapping.SetFilter(ls_filter)
if  li_return = 1 then
	ids_datamapping.Filter()
end if
	
return li_return


end function

protected function integer of_getsource (string as_target, ref string as_topic, ref string as_source);/*
	filterdatamappingcache should be called by descendant to set specific transfer type 
	before calling this method	
	
	return value 1 = source is tag
					 0 = source is datavalue
	 				-1 = no source found
*/


integer	li_return=1
long		ll_rowcount, &
			ll_find
string	ls_findstring
			
n_ds		lds_Datamapping

ll_rowcount = this.of_GetDatamappingCache(lds_Datamapping)

IF ll_rowcount > 0 then
	ls_findstring = "direction = '" + this.of_getdatamappingdirection() + "' and companyid = " + string(this.of_GetEDICompanyId()) + " and target = '" + as_target + "'"
	ll_find = lds_datamapping.find(ls_findstring,1,ll_rowcount)
	if ll_find > 0 then
		as_source = lds_datamapping.object.source[ll_find]
		as_topic = lds_datamapping.object.topic[ll_find]
		if len(trim(as_topic)) = 0 OR IsNull ( as_Topic ) then   //Added Isnull condition 3.5.19 BKW
			//source is value
			li_return = 0
		end if
	else
		li_return = -1
	end if
else
	li_return = -1
end if

return li_return

end function

protected subroutine of_setdatamappingdirection (string as_value);is_direction = as_value
end subroutine

protected function string of_getdatamappingdirection ();return is_direction
end function

public function long of_geteventbeo (long al_eventid, ref n_cst_beo_event anv_event);long	ll_count, &
		ll_index, &
		ll_id, &
		ll_return
		
ll_Count = upperbound( inva_Event )

FOR ll_Index = 1 TO ll_Count

	if isvalid ( inva_event [ll_Index ] ) then
		ll_Id = inva_Event [ ll_Index ].of_GetId ( )
		if ll_id = al_eventid then
			anv_event = inva_Event [ ll_Index ]
			ll_return = 1
			exit
		end if
	end if
	
NEXT


return ll_return

end function

protected subroutine of_getheaderrecord (ref string asa_column[], ref string asa_text[], string as_edicode);/*    
			EACH GROUP OF STATUS MESSAGES IS PROCEEDED BY A HEADER RECORD
        AND SUCCEEDED BY A TRAILER RECORD.  THE HEADER RECORD
        DESCRIBES THE TYPE OF INFORMATION, THE SENDER, THE RECEIVER,
        THE DATE AND TIME, AND THE CONTROL NUMBER.

        #SHIPMENTS FROM <SCAC> TO <SHIPPER-CODE> 010830 1245 00001
*/
long	ll_nextid
		
string	lsa_blank[], &
			ls_scac, &
			lsa_value[]

CONSTANT Boolean cb_Commit	= TRUE	


asa_column = lsa_blank
asa_text = lsa_blank

asa_column =  {&
					"#SHIPMENTS FROM ", &
					"<SCAC>", &
					" TO ", &
					"<SHIPPER-CODE>", &
					" ", &
					"<date>", &
					" ", &
					"<time>", &
					" ", &
					"<control number>"}

IF gnv_App.of_GetNextId ( "edicontrol", ll_NextId, cb_Commit ) = 1 THEN
	//edi system can't handle number larger than 99999
	if ll_nextid > 99999 then
		//	Reset next id for 'EDICONTROL'
		 UPDATE "nextids" SET "nextid" = 2 WHERE "nextids"."classid" = 12   ;
		commit;
		is_controlnumber = "00001"
	else
		is_controlnumber = string(ll_NextId,"00000")		
	end if
END IF

if this.of_mapdataout("SCAC", lsa_value) > 0 then
	ls_scac = lsa_value[1]
else
	ls_scac = this.of_getscac()
end if

asa_text[1] = "#SHIPMENTS FROM " + ls_scac + " TO " + &
						as_edicode + " " + string(today(),"yymmdd") + " " + &
						string(now(),"HH:MM") + " " +  is_controlnumber
						
end subroutine

protected subroutine of_gettrailerrecord (ref string asa_column[], ref string asa_text[]);/*
 THE TRAILER DENOTES END OF shipment.   #EOT
*/
string	lsa_blank[]

asa_column = lsa_blank
asa_text = lsa_blank

asa_column = {&
					"#EOT"}
					
asa_text[1] = "#EOT"

end subroutine

public subroutine of_getshipmentbeo (ref n_cst_beo_shipment anv_shipment);anv_shipment = inv_shipment
end subroutine

protected function integer of_mapdataout (string as_target, ref string asa_value[]);any		laa_beo[]

integer	li_retval

string	ls_topic, &
			ls_source, &
			ls_value, &
			lsa_value[], &
			lsa_blank[]
			
long		ll_beocount, &
			ll_parmcount, &
			ll_parmindex, &
			ll_beoindex

asa_value = lsa_blank

// look at datamapping for source and topic
choose case this.of_getsource(as_target, ls_topic, ls_source)
		
	case 0		//	source is value
		lsa_value[1] = ls_source   //BUG FIX 3.5.19 BKW  This was using asa_value, which was getting stepped on below.
		
	case 1		//	source is beo
		ll_beocount = this.of_gettopicbeo(ls_topic, laa_beo)
		for ll_beoindex = 1 to ll_beocount
			li_RetVal = laa_beo[ll_beoindex].Dynamic of_GetValueString ( ls_source, ls_value )
			CHOOSE CASE li_RetVal
				CASE -1	
					
				CASE 1
					IF isnull( ls_Value ) THEN
						ls_Value = ""
					END IF
			END CHOOSE
			lsa_value[ll_beoindex] = ls_value
		next
		
	case else	//	couldn't find a source
		
end choose

asa_value = lsa_value

return upperbound(asa_value)
end function

public function integer of_gettopicbeo (string as_topic, ref any aaa_beo[]);integer	li_return = 1

n_cst_beo_company	lnv_company
ANY					laa_Objectbeo[]

choose case upper(as_topic)
		
	case "SHIPMENT"
		aaa_beo[1] = inv_shipment
		
	case "EVENT"
		aaa_beo = inva_event
		
	case "COMPANY"
		IF IsValid ( inv_Event ) THEN    //IsValid check added 3.5.23 BKW, as a precaution.
													//Nothing prior to 3.5.23 was populating inv_Event
			if inv_event.of_getsite(lnv_company,true) = 1 then
				aaa_beo[1] = lnv_company
			end if
		END IF	
			
	case "ITEM"
		aaa_beo = inva_item
		
	case else
		if IsValid ( inv_shipment ) then
			if inv_shipment.Dynamic of_GetObject ( as_topic, laa_ObjectBeo ) = 1 then
				aaa_beo = laa_ObjectBeo
			else
				li_return = -1
			end if
		else
			li_return = -1
		end if
				
end choose
if li_return = 1 then
	li_return = upperbound(aaa_beo)	
end if

return li_return
end function

protected function integer of_mapdataout (long al_row, string as_target, ref string asa_value[]);any		laa_beo[]

integer	li_retval

string	ls_topic, &
			ls_source, &
			ls_value, &
			lsa_value[], &
			lsa_blank[]
			
asa_value = lsa_blank

// look at datamapping for source and topic
choose case this.of_getsource(as_target, ls_topic, ls_source)
		
	case 0		//	source is value
		lsa_value[1] = ls_source   //BUG FIX 3.5.19 BKW  This was using asa_value, which was getting stepped on below.
		
	case 1		//	source is beo
		if this.of_gettopicbeo(ls_topic, laa_beo) > 0 then
			li_RetVal = laa_beo[al_row].Dynamic of_GetValueString ( ls_source, ls_value )
			CHOOSE CASE li_RetVal
				CASE -1	
					
				CASE 1
					IF isnull( ls_Value ) THEN
						ls_Value = ""
					END IF
			END CHOOSE
			lsa_value[1] = ls_value
		end if
	case else	//	couldn't find a source
		
end choose

asa_value = lsa_value

return upperbound(asa_value)
end function

protected function integer of_getsystemfilepath (string as_editype, ref string as_filepath);Integer	li_Return
string	ls_path
any		la_Path
long		ll_setting
n_cst_settings lnv_Settings
n_cst_string	lnv_string

li_Return = 1
choose case as_editype
	case "EDI214"
		ll_setting = 60
	case "EDI210"
		ll_setting = 116
end choose

IF lnv_Settings.of_GetSetting ( ll_setting , la_path ) <> 1 THEN
	li_Return = -1
else
	ls_path = lnv_string.of_RemoveNonPrint ( String ( la_Path ) )
	
	if len(trim(ls_path)) > 0 then
		li_Return = 1
	else
		li_Return = 0
	end if
	
END IF

IF li_Return = 1 THEN
	if right(ls_path,1) = "\" then
		as_filepath = ls_path
	else
		as_FilePath = ls_path + "\"
	end if
END IF

return li_return
end function

public function integer of_loadevent (long al_eventid);//Created 3.5.23  3-12-2003  BKW 
//This function serves as an alternative to of_LoadShipment, when we are processing for an event
//that is not part of a shipment.  This is a modified copy of existing code in of_LoadShipment

n_cst_beo_Event	lnva_EmptyEvents[], &
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
			
			ids_Shipment = inv_Dispatch.of_GetShipmentCache ( )
			ids_EventCache = inv_Dispatch.of_GetEventCache ( )
			ids_ItemCache = inv_Dispatch.of_GetItemCache ( )
			
			lnv_Event = CREATE n_cst_beo_Event

			lnv_Event.of_SetSource ( ids_EventCache )
			lnv_Event.of_SetSourceId ( al_EventId )
			
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

public subroutine of_setnotificationsettingcache ();if isvalid(ids_notification) THEN
	DESTROY ids_notification
end if

ids_notification = CREATE n_ds
ids_notification.DataObject = "d_notificationsettings"
ids_notification.SetTransObject(SQLCA)
ids_notification.retrieve()
Commit;

end subroutine

public function integer of_getnotificationsetting (string as_type, long al_coid, string as_direction, string as_action, ref string as_setting);long		ll_find, &
			ll_rowcount
			
string	ls_findstring
integer	li_return=1

if isvalid(ids_notification) then
	this.of_SetNotificationSettingCache()
end if

ll_rowcount = ids_notification.rowcount()
if ll_rowcount > 0 then
	ls_findstring = "transfertype = '" + as_type + "' and direction = '" + as_direction + "' and companyid = " + &
						string(al_coid) + " and action = '" + as_action + "'"
	
	ll_find = ids_notification.find(ls_findstring,1,ll_rowcount)
	if ll_find > 0 then
		as_setting = ids_notification.object.setting[ll_find]
	else
		li_return = -1
	end if
else
	li_return = -1
end if

return li_return
end function

public subroutine of_processtemplate (long al_company, long al_transactionset);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ProcessTemplate
//
//	Access:  private
//
//	Arguments:  al_company
//					al_TransactionSet
//
// Returns:		
//
//	Description:	
//		Open file template. Read one line at a time. Search and replace tags.
//		We need to look for loops for itmes and events. Need something in the 	
//		message object to indicate that we need to handle looping. 
//						
//
// Written by: Norm LeBlanc
// 		Date: 11/21/03
//		Version: 3.8
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//	
//////////////////////////////////////////////////////////////////////////////

integer	li_FileNum, &
			li_FileRet

string	ls_line, &
			ls_Filename, &
			ls_NewFile[], &
			lsa_Tags []

boolean	lb_NoMoreLines

//get the file

if FileExists ( ls_filename ) then
	li_FileNum = FileOpen(ls_filename, LineMode!, Read!, Shared!)
	
	do until lb_NoMoreLines
		
		li_fileRet = FileRead ( li_FileNum, ls_line )
		
		choose case li_FileRet
				
			case is > 0
				//process line
				
			case is < 0
				lb_NoMoreLines = true
			
			case 0
				lb_NoMoreLines = true
				
			case else //null
				lb_NoMoreLines = true
				
		end choose
		
		
	loop
	
		
end if


end subroutine

public function n_ds of_getprofile ();if isvalid(ids_profile) then
	//already created
else
	ids_profile = create n_ds
	ids_profile.dataobject = "d_ediprofile_ds"
	ids_profile.SetTransObject(SQLCA)
	ids_profile.Retrieve()
	Commit;
end if

return ids_profile
end function

protected function string of_getcontrolnumber ();//Moved to n_cst_bso_ediManager By dan on 2-7-2006 so it can be called from the edishipmentprocessmanager

N_cst_bso_ediManager  lnv_manager
String	ls_controlnum

lnv_manager = Create N_cst_bso_ediManager

ls_controlNum = lnv_manager.of_getcontrolnumber( )

DESTROY lnv_manager

RETURN  ls_controlNum


/*
long		ll_nextid
string	ls_ControlNumber		

CONSTANT Boolean cb_Commit	= TRUE	

IF gnv_App.of_GetNextId ( "edicontrol", ll_NextId, cb_Commit ) = 1 THEN
	//edi system can't handle number larger than 99999
	if ll_nextid > 99999 then
		//	Reset next id for 'EDICONTROL'
		 UPDATE "nextids" SET "nextid" = 2 WHERE "nextids"."classid" = 12   ;
		commit;
		ls_controlnumber = "000000001"
	else
		ls_controlnumber = string(ll_NextId,"000000000")		
	end if
END IF

return ls_controlnumber
*/
end function

public subroutine of_setedicache ();ids_ediCache = create n_ds
ids_ediCache.dataobject = cs_Transaction_EDICache
ids_ediCache.settransobject(SQLCA)



end subroutine

public function integer of_processededi (long al_id, string as_error);integer	li_return=1
string	ls_findstring
long		ll_foundrow
date		ld_Processed
time		lt_processed

n_ds 	lds_EDICache

lds_EDICache = this.of_getEDICache(false)

ld_Processed = date(now())
lt_Processed = time(now())

ls_findstring = "id = " + string(al_id)
ll_foundrow = lds_EDICache.find(ls_findstring, 1, lds_EDICache.rowcount())
if ll_foundrow > 0 then
	lds_EDICache.object.processeddate[ll_foundrow] = ld_Processed
	lds_EDICache.object.processedtime[ll_foundrow] = lt_Processed
	lds_EDICache.object.errormessage[ll_foundrow] = as_error
else
	li_return = -1
end if	

return li_return

end function

public function integer of_updateedicache ();integer	li_return = 1

n_ds	lds_EDICache 

lds_EDICache = this.of_GetEDICache(false)

if isvalid(lds_EDICache) then
	
	if lds_EDICache.update() = 1 then
		commit;
		li_return = 1
	else
		li_return = -1
	end if
end if

return li_return
end function

public subroutine of_sendtransaction (long ala_id[]);
end subroutine

public function long of_getcompanyid (string as_scac);string	ls_findstring
long		ll_found, &
			ll_coid

n_ds		lds_Profile

lds_profile = this.of_GetProfile()

ls_findstring = "scac = '" + as_scac + "'"

if isvalid(lds_profile) then
	ll_found = lds_profile.find(ls_findstring, 1, lds_profile.rowcount())
end if

if ll_found > 0 then
	ll_coid = lds_profile.object.companyid[ll_found]
end if

return ll_coid

end function

protected subroutine of_createfile (string as_templatefile, string as_outputfolder, ref string as_outputfile, any aaa_beo[], n_cst_msg anv_tagmessage);integer	li_InputFile
string	ls_outputfile
string	ls_controlnumber
String	lsa_TemplateArray[]
String	lsa_Results[]
Int		li_ResultCount
Int		i
Int		li_Return = 1

s_parm	lstr_Parm

//Set additional tag values 
IF len ( as_templatefile ) > 0 THEN
	this.of_GetHeaderFooterTags(anv_TagMessage)
ELSE 
	li_Return = -1
END IF

////Read template file and load into array
//IF li_Return = 1 THEN
//	if FileExists ( as_templatefile ) then	
//		//input file, read
//		li_InputFile = FileOpen(as_templatefile, LineMode!, Read!, Shared!)
//		THIS.of_loadtemplateintoarray( li_InputFile , lsa_TemplateArray )
//		Fileclose(li_InputFile)
//	ELSE
//		li_Return = -1
//	END IF
//END IF

//process template array for the number of rows in the datastore,
//appending values to results array
IF li_Return = 1 THEN
	IF THIS.of_Processloop( lsa_TemplateArray , lsa_Results , anv_TagMessage , aaa_beo [ 1 ] ) <> 1 THEN
		li_Return = -1
	END IF
END IF
	
//create results file
IF li_Return = 1 THEN
	if len(trim(as_outputfile)) = 0 then
		if isvalid(anv_TagMessage) then
			IF anv_TagMessage.Of_Get_Parm ( "CONTROLNUMBER" , lstr_Parm ) <> 0 THEN
				ls_controlnumber = string(lstr_Parm.ia_Value)
			END IF
		
		end if
//		as_outputfile = ls_controlnumber + ".txt"
		as_outputfile = ls_controlnumber + THIS.of_Getoutboundfileextension( )
	end if
	ls_outputfile = as_outputfolder + "\" + as_outputfile
	
	THIS.of_Writeresultstofile( lsa_Results , ls_outputfile )
	
END IF

end subroutine

public function n_ds of_getedicache (boolean ab_retrieve);long	ll_return=0

if not isvalid(ids_ediCache) then
	this.of_SetEdicache()
	if ab_retrieve then
		ids_edicache.retrieve()
		Commit;
	end if
end if

return ids_ediCache


end function

public function boolean of_isaresend ();return ib_Resend
end function

public subroutine of_setresend (boolean ab_value);ib_resend = ab_value
end subroutine

public function unsignedlong test (integer n, ref integer result);//if n <= 1 THEN
//	return 1
//else
//    Return Fact( n - 1) * n 
//END IF
//
//Write a function using Recursion to print numbers from n to 0.
//
Int	li_Result	
//IF n <= 0 THEN
//	RETURN 0
//ELSE
//	MessageBox( "Result" , n )
//	li_Result = test ( n - 1 )
//	RETURN li_Result
//END IF

//Write a function using Recursion to print numbers from 0 to n.
IF n <= 0 THEN
	RETURN 0
ELSE
	test ( n - 1 , li_Result )
	li_Result = n
	MessageBox( "Result" ,li_Result )
	RETURN li_Result
END IF
	
	

	
	
end function

public function integer of_processsegments (string asa_segments[], pt_n_cst_beo anv_source, string asa_result[], n_cst_msg anv_msg);RETURN 1
end function

private function integer of_processloopelements (ref string asa_loopconstruct[], pt_n_cst_beo anv_source, n_cst_msg anv_tagmsg);int		li_SourceCount
Int		i
String	lsa_Result[]
String	ls_Working
String	ls_Modified
int		li_ConstructCount
int		li_ConstructIndex
Int		li_ResultIndex
Int		li_InLoop
Int		li_Return = 1


pt_n_cst_beo	lnv_Beo
n_cst_bso_ReportManager	lnv_ReportManager

li_ConstructCount = UpperBound ( asa_loopconstruct[] )

lnv_Beo = anv_source

	// Process the every element of the construct array
FOR li_ConstructIndex = 1 TO li_ConstructCount
	IF Left ( asa_Loopconstruct[li_ConstructIndex ] , 2 ) = "<+" THEN
		li_InLoop ++
	END IF
	
	IF Left ( asa_Loopconstruct[li_ConstructIndex ] , 2 ) = "<-" THEN
		li_InLoop --
	END IF

	IF li_InLoop = 0 THEN
		ls_Modified = ""
		ls_Working = asa_loopconstruct[li_ConstructIndex]
		
		IF IsValid ( lnv_Beo ) THEN
			lnv_ReportManager.of_ProcessString( ls_Working , ls_Modified , {lnv_Beo} , anv_TagMsg )
		ELSE
			lnv_ReportManager.of_ProcessString( ls_Working , ls_Modified , anv_TagMsg )
		END IF
		
	ELSE
		ls_Modified = asa_loopconstruct[li_ConstructIndex]
	END IF
	li_ResultIndex ++
	lsa_Result [ li_ResultIndex ] = ls_Modified 
NEXT

asa_loopconstruct[] = lsa_Result

RETURN li_Return

end function

public function integer of_processloop (string asa_loopconstructs[], ref string asa_processedloop[], n_cst_msg anv_tagmsg, pt_n_cst_beo anv_source);Int		li_Return = 1
Int		li_Count
Int		i
Int		li_NextLoopReturn
Int		li_LoopStart
Int		li_LoopEnd
String	lsa_NextLoop[]
string	ls_Source
Any		laa_Source[]
pt_n_cst_beo	lnva_Source[]

// take the loop construct passed in and see if it has any nested loops.
li_NextLoopReturn = THIS.of_GetNextloop( asa_loopconstructs[] , lsa_NextLoop, ls_Source , li_LoopStart , li_LoopEnd )

IF li_NextLoopReturn = 1 THEN  // we got a new nested loop

	anv_Source.Event ue_GetObject ( ls_Source , laa_Source )
	
	IF UpperBound ( laa_Source ) = 0 THEN
		// USE THE BEO SENT IN
		laa_Source[1] = anv_source
	END IF
	String	lsa_Keep[]
	
	//String	lsa_Empty[]
	lnva_Source = laa_Source
	li_Count = UpperBound ( lnva_Source )
	int j
	FOR i = 1 TO li_Count
		THIS.of_Processloop( lsa_NextLoop,  asa_processedloop[], anv_tagmsg, lnva_Source[i] )
//		lsa_Temp = lsa_Empty
		
		FOR j = 1 TO UpperBound ( asa_processedloop )
			lsa_Keep[ UpperBound ( lsa_Keep )  + 1 ] = asa_processedloop[] [j]
		NEXT
	NEXT
	
	
	// Put the result of asa_ProcessedLoop in asa_LoopConstruct
//	THIS.of_Processloopelements( asa_loopconstructs[], anv_source , anv_tagmsg )
	THIS.of_Replaceloop( asa_loopconstructs, li_LoopStart , li_LoopEnd, lsa_Keep)
	THIS.of_Processloop( asa_loopconstructs,  asa_processedloop[], anv_tagmsg, anv_Source )
	// call process elements on asa_Loop Construc
	
	//asa_Processedloop[] = asa_loopconstructs[]
	

ELSE
	
	THIS.of_Processloopelements( asa_loopconstructs[], anv_source , anv_tagmsg )		
	asa_processedloop[] = asa_loopconstructs[]
	
END IF

RETURN 1








































//pt_n_cst_beo	lnv_beo
//
//lsa_ExistingLoop = asa_loopconstructs[]
//
//li_NextLoopReturn = THIS.of_GetnextLoop ( lsa_ExistingLoop, lsa_NextLoop , ls_Source )
//
//IF li_NextLoopReturn = 0 THEN // no more Loops found
//	asa_processedloop[] = lsa_ExistingLoop
//	//process the existing loop ???
//
//ELSEIF li_NextLoopReturn = -1 THEN // we failed
//	
//	//
//	
//ELSE
//	//THIS.of_processloopelements( lsa_NextLoop , lnv_beos , anv_tagmsg )
//	THIS.of_processloop( lsa_NextLoop , lsa_ProcessedLoop , anv_tagmsg )
//	// get the array of ptbeos
//	THIS.of_processloopelements( lsa_ProcessedLoop , lnv_beo , anv_tagmsg )
//	asa_processedloop[] = lsa_ProcessedLoop
////process the existing loop
//END IF
//
//RETURN li_Return
//
//
end function

public function integer of_getnextloop (string asa_source[], ref string asa_loopconstruct[], ref string as_datasource, ref integer ai_loopstart, ref integer ai_loopend);Constant	String	lcs_LoopStart = "<+"
Constant	String	lcs_LoopEnd = "<-"
Int		li_Return = 1
Long		i
Long		ll_ResultIndex
Int		li_LoopStartIndex
Int		li_loopEndIndex
Boolean	lb_LoopStartFound
Boolean	lb_LoopEndFound
String	lsa_loopConstruct[]
String	ls_DataSource // Event, Items ...
String	lsa_Source[]

lsa_Source = asa_Source 
li_LoopEndIndex = UpperBound ( lsa_Source )


FOR i = 1 TO li_LoopEndIndex	
	IF Left ( Trim ( lsa_Source[i] ) , 2 ) = lcs_LoopStart THEN
		lb_LoopStartFound = TRUE
		li_LoopStartIndex = i
		ls_DataSource = Mid ( lsa_Source[li_LoopStartIndex], 3  , Len (lsa_Source[li_LoopStartIndex] ) - 3  ) // 3 = <+...>
		EXIT
	END IF	
NEXT
	
IF lb_LoopStartFound THEN
	FOR i = li_LoopStartIndex TO li_LoopEndIndex
		IF Upper ( lsa_Source[i] )  = lcs_LoopEnd + Upper (ls_DataSource) + ">" THEN
			lb_LoopEndFound = TRUE
			li_LoopEndIndex = i 
			EXIT
		END IF	
	NEXT
END IF

IF (NOT ( lb_LoopstartFound AND lb_LoopEndFound )) AND (lb_LoopStartFound OR lb_LoopEndFound) THEN
		// We have a problem because we found one but not the other
		li_Return = -1
	
ELSEIF lb_LoopStartFound THEN // Extract the segments for the loop and identify the loop source. i.e. Event,Item,Company 

//	ls_DataSource = Mid ( lsa_Source[li_LoopStartIndex], 3  , Len (lsa_Source[li_LoopStartIndex] ) - 3  ) // 3 = <+...>
	// Looking to extract 'Event' from '<+Event>'

	FOR i = li_LoopStartIndex + 1 TO li_LoopEndIndex - 1
		ll_ResultIndex ++
		lsa_loopConstruct [ll_ResultIndex] = lsa_Source[i]
	NEXT	
	
ELSE
	li_Return = 0 // no loops
END IF

IF li_Return <> -1 THEN
	asa_Loopconstruct[] = lsa_loopConstruct
	as_Datasource = ls_DataSource
	ai_loopstart = li_LoopStartIndex
	ai_loopend = li_loopEndIndex
END IF

RETURN li_Return

/*
Constant	String	lcs_LoopStart = "<+"
Constant	String	lcs_LoopEnd = "<-"
Int		li_Return = 1
Long		i
Long		ll_ResultIndex
Int		li_LoopStartIndex
Int		li_loopEndIndex
Boolean	lb_LoopStartFound
Boolean	lb_LoopEndFound
String	lsa_loopConstruct[]
String	ls_DataSource // Event, Items ...
String	lsa_Source[]

lsa_Source = asa_Source 
li_LoopEndIndex = UpperBound ( lsa_Source )


FOR i = 1 TO li_LoopEndIndex	
	IF Left ( Trim ( lsa_Source[i] ) , 2 ) = lcs_LoopStart THEN
		lb_LoopStartFound = TRUE
		li_LoopStartIndex = i
		EXIT
	END IF	
NEXT
	
IF lb_LoopStartFound THEN
	FOR i = li_LoopEndIndex TO li_LoopStartIndex+1 STEP -1
		IF Left ( Trim ( lsa_Source[i] ) , 2 ) = lcs_LoopEnd THEN
			lb_LoopEndFound = TRUE
			li_LoopEndIndex = i 
			EXIT
		END IF	
	NEXT
END IF

IF (NOT ( lb_LoopstartFound AND lb_LoopEndFound )) AND (lb_LoopStartFound OR lb_LoopEndFound) THEN
		// We have a problem because we found one but not the other
		li_Return = -1
	
ELSEIF lb_LoopStartFound THEN // Extract the segments for the loop and identify the loop source. i.e. Event,Item,Company 

	ls_DataSource = Mid ( lsa_Source[li_LoopStartIndex], 3  , Len (lsa_Source[li_LoopStartIndex] ) - 3  ) // 3 = <+...>
	// Looking to extract 'Event' from '<+Event>'

	FOR i = li_LoopStartIndex + 1 TO li_LoopEndIndex - 1
		ll_ResultIndex ++
		lsa_loopConstruct [ll_ResultIndex] = lsa_Source[i]
	NEXT	
	
ELSE
	li_Return = 0 // no loops
END IF

IF li_Return <> -1 THEN
	asa_Loopconstruct[] = lsa_loopConstruct
	as_Datasource = ls_DataSource
	ai_loopstart = li_LoopStartIndex
	ai_loopend = li_loopEndIndex
END IF

RETURN li_Return

*/

end function

private function integer of_replaceloop (ref string asa_target[], integer ai_start, integer ai_end, string asa_source[]);// stick source into target at specified start point
// replacing that between start and end
int		i
int		li_CopyIndex
String	lsa_Copy []
String	lsa_Source[]

lsa_Source = asa_Target
FOR i = 1 to ai_Start - 1
	li_CopyIndex ++
	lsa_Copy [ li_CopyIndex ] = lsa_Source[i]
NEXT


lsa_Source = asa_Source
FOR i = 1 TO UpperBound ( lsa_Source )
	li_CopyIndex ++
	lsa_Copy [ li_CopyIndex ] = lsa_Source[i]	
NEXT

lsa_Source = asa_Target
FOR i = ai_End + 1 TO UpperBound ( lsa_Source )
	li_CopyIndex ++
	lsa_Copy [ li_CopyIndex ] = lsa_Source[i]		
NEXT

asa_Target = lsa_Copy

RETURN 1
end function

protected function integer of_writeresultstofile (string asa_results[], string as_outputfile);//modified by Dan 1-20-2006
//as_outputfile represents the final resting place of for the newly created and successfully
//validated EDI file.  I modified this so that it writes the new file into a temp folder
//where it can be validated from.  If it is validated successfully, then it is moved to 
//as_outputfile.  If it fails to pass validation, it is moved into a 'Bad Files' with the errors
//appended onto the end of the file.



String	ls_FileFormat
Int		li_OutputFile = -1
Int		li_ResultCount
Int		i
Int		li_Return = 1 
Int		li_validationResult
Int		li_rc
Long		lla_sourceIds[]
String	lsa_warnings[]
String	ls_tempFile		
String	ls_tempPath
String	ls_folder
String 	ls_file
String	ls_badFiles
String	ls_outBoundFolder
String	ls_columnName
String	ls_contextError
String	ls_remedy
DateTime	ldt_now

n_cst_errorlog_manager		lnv_errorLogManager
n_cst_errorlog					lnv_error
	
Long		ll_coId
Int	li_rtn
OleObject	lnv_ediDocument

IF UpperBound ( asa_results[] ) = 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	THIS.of_Prewriteprocess( asa_results[] )
END IF

lnv_errorLogManager = create n_cst_errorlog_manager

li_rtn = 1
IF THIS.of_Getfileformat( ls_FileFormat ) = 1 AND li_Return = 1 THEN
	
	//Added by dan to create a temp folder for the file if it doesn't already exist
	
	IF len( as_outputFile ) > 0 THEN
		
		//if the path looks like C:\Program Files\Profit Tools\EDI\997\data.txt
		
		ls_tempPath = left( as_outputfile, LastPos (as_outPutFile, "\") - 1 )		//C:\Program Files\Profit Tools\EDI\997\data.txt becomes C:\Program Files\Profit Tools\EDI\997
		ls_folder =  RIGHT( ls_tempPath, len(ls_tempPath) - LastPos( ls_tempPath, "\" ) )	//becomes 997
		ls_tempPath = left( ls_tempPath, LastPos (ls_tempPath, "\") - 1 )				//C:\Program Files\Profit Tools\EDI\997 becomes C:\Program Files\Profit Tools\EDI
		ls_badFiles = ls_tempPath+"\Bad Files"
		ls_tempPath += "\TEMP"
		IF not DirectoryExists( ls_tempPath ) THEN
			CreateDirectory( ls_tempPath )
		END IF
		
		ls_tempPath += "\"+ls_folder				//becomes C:\Program Files\Profit Tools\EDI\TEMP\997

		IF NOT DirectoryExists( ls_tempPath ) THEN
			li_rtn = CreateDirectory( ls_tempPath )
		END IF
	
		IF li_rtn = 1 Then
			//gets the file name from the as_outputfile
			ls_File = RIGHT( as_outputfile, len(as_outPutFile) - LastPos (as_outPutFile, "\") )
			ls_tempFile = ls_tempPath +"\"+ls_file
			
		END IF
		
	END IF
	//--------------------------------------------------
	
	if ls_FileFormat = "STREAM!" then
		//stream mode				.. changed to output to tempfile instead
		li_OutputFile = FileOpen( ls_tempFile, StreamMode!, Write!, LockWrite!, replace!)
	else
		//line mode					..changed to output to tempfile instead
		li_OutputFile = FileOpen( ls_tempFile, LineMode!, Write!, LockWrite!, replace!)
	end if	
	
	IF li_OutputFile = -1 THEN
		li_Return = -1
	END IF
	
ELSE 
	li_Return = -1 
END IF

IF li_Return = 1 THEN

	li_ResultCount = UpperBound ( asa_results[] )
	
	FOR i = 1 TO li_ResultCount	
		FileWrite(li_OutputFile, asa_results[i])	
	NEXT

	Fileclose(li_OutputFile)
	
END IF

//added by Dan 1-20-2006 to validate the created file
IF li_return = 1 THEN
	li_validationResult = this.of_validateresultfile( ls_tempFile, lsa_warnings, lnv_ediDocument )
END IF

IF li_validationResult = 1 THEN
	
	this.of_sendfile( lnv_ediDocument, ls_tempFile, as_outputFile, ls_FileFormat )

	//if the file failed to be sent then it will still be in the temp folder.
	//We will move it to the outbound location in this case.
	IF FileExists( ls_tempFILE ) THEN
		ll_coID = this.of_getedicompanyid( )
		ls_outBoundFolder = this.of_getOutputfolder( ii_transactionset, ll_coid, "OUTBOUND")
		IF directoryExists( ls_outBoundFolder ) THEN
			FileMove( ls_tempFile, ls_outBoundFolder+"\"+ls_File )
		END IF
	END IF

ELSEIF li_validationResult = -1 THEN
	//there was an error with creating filepaths or setup of the oleobject
	lnv_error = CREATE n_cst_errorlog	
	
	ls_columnName = this.of_getIdColName()
	this.of_getIdsfromcache( lla_sourceids, ls_columnName )
	
	ls_remedy = this.of_getRemedyobjectstring( )
	lnv_error.of_setlogdata( "EDI", string( ii_transactionset )+" EDI Validation" ,  String(Today(), "m/d/yy hh:mm")+" EDI file could not be sent, error setting up Freddi object. ", 1, lla_sourceIds[], ls_remedy )
	
	lnv_errorLogManager.of_logerror( lnv_error )
	Destroy lnv_error
	
ELSEIF li_validationResult = -2 THEN
	//the file validated had warnings in it.
	//we will create a directory for the bad file if it doesn't exist already, and 
	//move the bad file into it.  Errors are written to the file before it is moved.
	
	this.of_writeErrorsToFile( ls_tempFile, lsa_warnings )
	
	//create path for bad files if they don't exist
	IF not DirectoryExists( ls_badFiles ) THEN
		 CreateDirectory( ls_badFiles )
	END IF
	
	ls_badFiles += "\"+ ls_folder					//becomes C:\Program Files\Profit Tools\EDI\Bad Files\997
	
	IF not DirectoryExists( ls_badFiles ) THEN
		CreateDirectory( ls_badFiles )
	END IF
	
	IF directoryExists( ls_badFiles ) THEN
		ls_badFiles += "\"+ls_file					//becomes C:\Program Files\Profit Tools\EDI\Bad Files\997\<filename>
		FileMove( ls_tempfile, ls_badfiles )
	END IF
	
	
	lnv_error = CREATE n_cst_errorlog	
	ls_columnName = this.of_getIdColName()
	this.of_getIdsfromcache( lla_sourceids, ls_columnName )
	ls_contextError = this.of_geterrorcontext( lla_sourceIds )
	
	//This check is here because the 214 and 322 will return null if its the first pass through and it hasn't tried to resend them again.
	//It is here to prevent multiple error loggings while trying to send one process.  214 and 322 will only log an error if there is one id.
	IF not IsNull( ls_contextError ) AND ls_contextError <>  "" THEN
		ls_remedy = this.of_getRemedyobjectstring( )
		//DEK 5-14-07  I changed the message a bit to have "File::" in it.  For transaction sets that use the default remedy object, having
		//it will open the file in notepad when they hit trouble shoot.  THe logic looks at all the text to the right of "File::" which should
		//be a file path, and tries to open that.
		lnv_error.of_setlogdata( "EDI",  string( ii_transactionset )+" EDI Validation" , ls_contextError+"~r~nFile with errors located at:~r~nFile::"+ls_badfiles, 1, lla_sourceIds[], ls_remedy )
		lnv_errorLogManager.of_logerror( lnv_error )
	END IF
	
	
	Destroy lnv_error
	li_return  = -2		//file didn't validate
END IF

IF li_return = 1 THEN
	FileClose( li_outputFile )
END IF

IF isValid ( lnv_ediDocument ) THEN
	lnv_edidocument.disconnectobject( )
	Destroy lnv_ediDocument
END IF

IF isValid( lnv_errorLogManager ) THEN
	DESTROY( lnv_errorLogManager )
END IF

IF isValid( lnv_error ) THEN
	DESTROY lnv_error
END IF


RETURN li_Return
end function

protected function integer of_prewriteprocess (ref string asa_results[]);// this is where we can evaluate the results and fill in any 'holes' that 
// were not previously known, like segment count (from loops).
// also if there is any logic that needs to be applied to the results it can be done here.
Int		i
Int		li_TotalCount
li_TotalCount = UpperBound (asa_results[])
FOR i = 1 TO li_TotalCount
	THIS.of_loadsegmentandvalidate( asa_results[i])
NEXT

n_cst_AnyArraySrv	lnv_Array
lnv_Array.of_getshrinked( asa_results, TRUE, FALSE ) // only shrinking nulls NOT dupes




/*  					//\\//\\//\\	NOTE:		\\//\\//\\//

	If any 'pre-write' processing is going to change, or potentialy change the number of 
	segments it should be done BEFORE here since we are counting the segments next.
	
*/


//Int		li_HeaderandFooterCount = 4 // 2 header segments and 2 footer segments
String	ls_ReplaceString
//li_TotalCount = UpperBound (asa_results[])
//ls_ReplaceString = "SE*" + String ( li_TotalCount - li_HeaderandFooterCount) + "*"
//
//
//// when sending an outbound file we need to indicate the number of segments.
//// this is sent in the SE record. We are going to assume that the number of segments can 
//// be calculated by counting the total number of elements in the array and subtracting 
//// the header and footer records.
//
//
////we need to find the SE* record. At this point in the processing it should look
//// like SE** because the <SEGMENTCOUNT> tag should always be included, however in the 
//// case of 214 adn 210 it cannot be resolved so it will be collapsed.
//FOR i = 1 TO  li_TotalCount
//	IF LEFT ( asa_Results[i] , 4  ) = "SE**"THEN 
//		asa_Results[i] = Replace ( asa_Results[i], 1, 4, ls_ReplaceString )
//		EXIT
//	END IF
//NEXT

integer	li_count, &
			li_SegmentCount, &
			li_TransactionCount
//			li_Totalcount, &


string	lsa_Results[], &
			ls_line

lsa_Results = asa_Results[]
li_Totalcount = upperbound(lsa_Results)
IF li_TotalCount > 0 THEN
	do until UPPER(left(ls_line,2)) = 'GE'
		
		li_Count ++
		ls_line = lsa_Results[li_Count]
		if UPPER(left(ls_line,2)) = 'GE' then
			CONTINUE
		end if
		
		//find the Beginning of a transaction set
		do until UPPER(left(ls_line,2)) = 'ST'
			li_Count ++
			if li_Count > li_TotalCount then
				EXIT
			else
				ls_line = lsa_Results[li_Count]
			end if
		loop
		
		if li_Count > li_TotalCount then
			//array done
		else
			//now find the end of the transaction set and count the lines
			do until UPPER(left(ls_line,2)) = 'SE'
				li_SegmentCount ++
				li_Count ++
				if li_Count > li_TotalCount then
					EXIT
				else
					ls_line = lsa_Results[li_Count]
				end if
			loop
		end if
		
		//add 1 for the SE
		li_SegmentCount ++	
		ls_ReplaceString = "SE*" + String (li_SegmentCount) + "*"
		lsa_Results[li_Count] = Replace ( lsa_Results[li_Count], 1, 4, ls_ReplaceString )
		li_SegmentCount = 0
		li_TransactionCount ++
			
	loop
	
	if UPPER(left(lsa_Results[li_Count],4)) = "GE**" then
		ls_ReplaceString = "GE*" + String (li_TransactionCount) + "*"
		lsa_Results[li_Count] = Replace ( lsa_Results[li_Count], 1, 4, ls_ReplaceString )
	elseif UPPER(left(lsa_Results[li_Count],5)) = "GE*1*" then
		ls_ReplaceString = "GE*" + String (li_TransactionCount) + "*"
		lsa_Results[li_Count] = Replace ( lsa_Results[li_Count], 1, 5, ls_ReplaceString )
	end if
END IF


////// I am going to make sure that all of the segments have the terminator set at the end
/////  I am assuming that the terminator can be found at the end of the 1st line

String ls_Term
ls_Term = THIS.of_GetSegmentterminator( lsa_Results )

li_SegmentCount = UpperBound ( lsa_Results )

IF Len ( ls_Term ) > 0 THEN
	FOR i = 1 To li_SegmentCount
		IF Right  ( trim ( lsa_Results[i] ) , 1) <> ls_Term THEN
			lsa_Results[i] = Trim ( lsa_Results[i] ) + ls_Term
		END IF	
	NEXT
END IF

asa_Results = lsa_Results
RETURN 1


end function

protected function string of_getoutboundmappingfile ();RETURN "" // Implemented in the descendant
end function

protected function integer of_setedicompanyid (long al_coid);li_edicoid = al_coid

is_ouboundmappingfile = THIS.of_Getoutboundmappingfile( )

RETURN 1	
end function

public subroutine of_getheaderfootertags (ref n_cst_msg anv_tagmessage);string	ls_Value, &
			ls_ControlNumber

s_parm	lstr_Parm


lstr_parm.is_Label = "TODAYLONG"
ls_value = string(today(),"yyyymmdd")
if isnull(ls_value) then
	ls_value = ''
end if
lstr_Parm.ia_Value = ls_value
anv_TagMessage.of_Add_Parm ( lstr_Parm )


lstr_parm.is_Label = "TODAY"
ls_value = string(today(),"yymmdd")
if isnull(ls_value) then
	ls_value = ''
end if
lstr_Parm.ia_Value = ls_value
anv_TagMessage.of_Add_Parm ( lstr_Parm )

lstr_parm.is_Label = "NOW"
ls_value = string(now(),"hhmm")
if isnull(ls_value) then
	ls_value = ''
end if
lstr_Parm.ia_Value = ls_value
anv_TagMessage.of_Add_Parm ( lstr_Parm )


end subroutine

protected function integer of_loadtemplateintoarray (long al_filehandle, ref string asa_templateresults[], ref string asa_templateheader[], ref string asa_templatefooter[]);//	modified to seperate the header and trailer rows from the
//	template nwl 1/10/2005

Int	li_FileRet
String	ls_Line
Int	li_TemplateHandle
Int	li_Count
String	lsa_Results[], &
			lsa_header[], &
			lsa_footer[]
			
Boolean	lb_noMoreLines

li_TemplateHandle = al_filehandle

//	st = transaction set header
li_FileRet = 0
li_Count = 0
do until UPPER(left(ls_line,2)) = 'ST'
	IF li_FileRet > 0 THEN
		li_Count ++
		lsa_header[li_Count] = ls_Line
	end if
	li_fileRet = FileRead ( li_TemplateHandle, ls_line )
loop

//transaction set
//DON'T RESET li_FileRet
li_Count = 0
do until UPPER(left(ls_line,2)) = 'GE'
	IF li_FileRet > 0 THEN
		li_Count ++
		lsa_Results[li_Count] = ls_Line
	END IF
	li_fileRet = FileRead ( li_TemplateHandle, ls_line )
loop

//	se = transaction set trailer
//DON'T RESET li_FileRet
li_Count = 0
do until lb_NoMoreLines
	IF li_FileRet > 0 THEN
		li_Count ++
		lsa_footer[li_Count] = ls_Line
	ELSE
		lb_noMoreLines = TRUE
	END IF		
	li_fileRet = FileRead ( li_TemplateHandle, ls_line )
loop

asa_templateresults[] = lsa_Results
asa_templateheader[] = lsa_header
asa_templatefooter[] = lsa_footer

RETURN 1
end function

public function integer of_getfileformat (ref string as_fileformat);//THis returns only the outbound format!!!! 
//Changed by dan 3-8-07
int	li_Return = 1
String	ls_Format
String	ls_outbound = appeon_constant.cs_transaction_OUTBOUND

IF li_edicoid > 0 THEN
  SELECT "ediprofile"."fileformat"  
    INTO :ls_Format  
    FROM "ediprofile"  
   WHERE "ediprofile"."companyid" = :li_edicoid and
			"ediprofile"."transactionset" = :ii_transactionset and "ediprofile"."in_out" =:ls_outbound ;
    Commit;
	 
	 IF IsNull ( ls_Format ) OR ls_Format = "" THEN
		li_Return = -1
	ELSE
		as_Fileformat = ls_Format
	END IF
	 
ELSE
	li_Return = -1
END IF


RETURN li_Return
end function

protected function integer of_loadsegmentandvalidate (ref string as_segment);String	ls_Segment
String	lsa_Segments[]
String	ls_RuleFile
String	ls_SegmentID
Long		ll_RuleCount
Long		i
String	ls_CurrentRule
Int		li_Element
String	ls_Value
Boolean	lb_DeleteSegment 
Boolean	lb_SetValue

n_cst_String	lnv_String
n_cst_EdiSegment	lnv_Segment
DataStore	lds_Rules
lds_Rules = CREATE DataStore

ls_RuleFile = is_ouboundmappingfile


ls_Segment = as_segment
lds_Rules.DataObject = ls_RuleFile

lnv_Segment = CREATE n_cst_EDISegment
lnv_String.of_parsetoarray( ls_Segment, "*" , lsa_Segments )

lnv_Segment.of_Setsegment( lsa_Segments )
ls_SegmentID = lnv_Segment.of_Getsegmentid( )

lds_Rules.SetFilter ( "SourceSegment = '" + ls_SegmentID + "'" )
lds_Rules.Filter ( ) 

ll_RuleCount = lds_Rules.RowCount ( )

FOR i = 1 TO ll_RuleCount
	ls_CurrentRule = lds_Rules.GetItemString ( i , "Condition" )
	IF lnv_Segment.of_meetscondition( ls_CurrentRule ) = 1 THEN
		// apply that shiznit to the string
		lb_DeleteSegment = lds_Rules.GetItemNumber ( i , "Action_DeleteSegment" ) = 1
		IF lb_DeleteSegment THEN
			SetNull ( ls_Segment )
			EXIT
		END IF
		
		lb_SetValue = lds_Rules.GetItemNumber ( i , "Action_Set" ) = 1
		IF lb_SetValue THEN
			li_Element = lds_Rules.GetItemNumber ( i , "Action_SetElement" ) 
			ls_Value = lds_Rules.GetItemString ( i , "Action_SetValue" )
			lnv_Segment.of_SetValue( li_Element, ls_Value)
		
		END IF
		
	END IF
NEXT

IF Not lb_DeleteSegment THEN
	ls_Segment = lnv_Segment.of_Getrecordstring( )
//	lnv_String.of_Arraytostring( lsa_Segments, "*", ls_segment , TRUE /*include empty strings*/)
//	IF Right ( ls_segment  , 1 ) <> '~~' THEN
//		ls_segment  += '~~'  // the replace stripped off the needed ~
//	END IF
END IF
	
as_segment = ls_Segment
	
DESTROY ( lds_Rules )
DESTROY ( lnv_Segment )

RETURN 1

end function

protected function string of_getoutboundfileextension ();Long	ll_CoID
Int	li_TransactionSet
String	ls_Template
String	lsa_Parts[]
Int	li_Pos

String	ls_Return = ".txt"
String	ls_outBound

li_TransactionSet = ii_transactionset
ll_CoId = li_edicoid
ls_outbound = appeon_constant.cs_transaction_OUTBOUND
//DEK 4-4-07 Modified to get the extension off the template of the edi_outbound template. Was a bug in 4.1.29.
  SELECT "ediprofile"."template"  
    INTO :ls_Template  
    FROM "ediprofile"  
   WHERE ( "ediprofile"."companyid" = :ll_CoID ) AND  
         ( "ediprofile"."transactionset" = :li_TransactionSet ) AND
			("ediprofile"."in_out" = :ls_outbound);
			
	COMMIT;
	
IF Len ( ls_Template ) > 0 THEN
	li_Pos = LastPos ( ls_Template , "." )
	IF li_Pos > 0 THEN
		ls_Return = Right ( ls_Template , (Len ( ls_Template ) - li_Pos) + 1 )	// + 1 to get the '.'
	END IF
END IF

RETURN ls_Return
end function

protected function character of_getsegmentterminator (readonly string asa_records[]);String ls_Term
String ls_Test
Char	lca_Test[]
Char	lc_Return
Int	i
Int	li_Bound
Long	ll_Count

ll_Count = UpperBound ( asa_records[] ) 

IF ll_Count > 0 THEN
	ls_Test = asa_records[1]
END IF

IF Len ( ls_Test ) > 0 THEN
	lca_Test = ls_Test
END IF

li_Bound = UpperBound ( lca_Test )
FOR i = li_Bound TO 1 STEP -1	// i know the thing I am looking for is at the end
	IF lca_Test[i] = '>' THEN
		
		IF i + 1 <= li_Bound THEN
			lc_Return = lca_Test[ i + 1 ]
			EXIT
		END IF
	END IF
NEXT
	
RETURN lc_Return
end function

public function integer of_writeerrorstofile (string as_file, string asa_ediwarnings[]);//written by Dan 1-20-2006 to write the error results into the specified file.
Int 	li_return
INt	li_outPutFile

Long	ll_warnCount
Long	ll_index
OleObject	lnv_warning
String	ls_warnings

IF FileExists( as_file )  THEN
	li_OutputFile = FileOpen( as_file, LineMode!, Write!, LockWrite!, append!)
	IF li_outPutFile > 0 THEN
		li_return = 1
	ELSE
		li_return = -1
	END IF
ELSE
	li_return = -1
END IF

//gets the errors out of an array. Then
//outputs them to the file.
IF li_return = 1 THEN
	ll_warnCount = upperBound( asa_ediWarnings)
	FileWrite( li_outPutFile, "" )
	FileWrite( li_outPutFile, string(ll_warnCount)+" ERROR(S)-------------------------" )
	FOR ll_index = 1 TO ll_warncount
		FileWrite( li_outPutFile, asa_ediwarnings[ll_index])
	NEXT
	FileClose( li_outPutFile )
END IF


RETURN li_return
end function

public function integer of_validateresultfile (string as_filepath, ref string asa_warnings[], ref oleobject anv_edidocument);//Created by dan to use the Fredi objects to validate an ediFile located at as_filePath

//returns 1 if everything works ok and the file is valid. Also returns 1 if there is no setting for a SEF FILE. This signifies duplication of old functionality.
//returns -1 if the sef file doesn't exist or the specified file doesn't exist. Or if there
// is an error loading the files.
//Returns -2 if the file was validated and has 1 or more errors.

//If -2 is returned, then the error information can be found in the returned anv_warnings
// 						by reference.
oleobject	lnv_ediDocument
Int	li_Rtn
n_cst_setting_editransport	lnv_setting
//OleObject lnv_Interchage
OleObject	lnv_schemas
OleObject	lnv_schama
OleObject	lnv_warnings
OleObject	lnv_warning

Long			ll_warnCount
Long			ll_index
String		ls_warnings
String		ls_mySefFile
String		lsa_warnings[]

li_rtn = 1

//lnv_setting = create n_cst_setting_editransport

ls_mySefFile = this.of_getSEFfile()

IF isNULL( ls_mySefFile ) THEN
	RETURN 1						//this is the duplication of old functionality.
END IF

lnv_ediDocument = CREATE oleObject
IF FileExists( as_filePath ) THEN
	li_rtn = 1
ELSE
	li_rtn = -1
END IF

IF li_rtn = 1 THEN
	li_Rtn = lnv_ediDocument.ConnectToNewObject ( "Fredi.ediDocument" ) 
	
	//it returns 0 when successful, but I am testing for 1 later on.
	IF li_rtn = 0 THEN
		li_rtn = 1
	ELSE
		li_rtn = -1
	END IF

END IF

IF li_Rtn = 1 THEN
	lnv_schemas = lnv_ediDocument.getschemas( )
	lnv_schemas.EnableStandardReference = False
	
	IF FileExists( ls_mySefFile ) THEN
		lnv_schama = lnv_ediDocument.LoadSchema(ls_mySefFile, 0) 
	ELSE
		li_rtn = -1
	END IF
END IF	
	
IF li_rtn = 1 THEN
	IF lnv_ediDocument.LoadEDI( as_filePath/*"C:\EDI\997.x12"*/ ) = 1 THEN
		//ok
	ELSE
		li_Rtn = -1
	END IF
END IF	
	
IF li_rtn = 1 THEN	
	lnv_warnings = lnv_ediDocument.getWarnings()
	
	ll_warnCount = lnv_warnings.count()
	IF ll_warnCount > 0 THEN
		li_rtn = -2
	END IF
	
	//put all the warnings from the OLEobject into an array instead.
	FOR ll_index = 1 TO ll_warncount 
		lnv_warning = lnv_warnings.warning( ll_index )
		lsa_warnings[ll_index] = String(lnv_warning.description)
	NEXT

END IF

//DESTROY lnv_setting
anv_edidocument = lnv_ediDocument	// returns the lnv_ediDocument
asa_warnings = lsa_warnings			// returns by reference an array of strings containing
												// all of the errors and warnings for the file.
RETURN li_rtn
end function

public function integer of_sendfile (oleobject anv_edidocument, string as_filepath, string as_topath, string as_fileformat);/***************************************************************************************
NAME: 		of_sendFile	

ACCESS:			public
		
ARGUMENTS: 		
							anv_edidocument: oleobject from freddi.  IF this isn't valid when sent in,
												  then this function will send the file through FTP the old way.
												  EG. by moving the written file into a folder where other software
												  handles the move.
												  IF the object is good, and they don't have any transport settings,
												  then it also sends it the old way.
												  
							as_filepath: 	  the path of the edi file that is being sent
							
							as_toPath:			IF it isn't using Profit Tools to send the file, then we need to know
													the location of the folder where it will be picked up by another piece
													of software to be sent.  It will be moved into this location.
													
							as_fileformat:	   If they don't want profit tools to send the file, then they have the option
													of saving the file to XML format for the other software to send.  Anv_edidocument
													must be valid in order to do this.
RETURNS:			
	1 if it successfully moves the file into a folder where it will be picked up, or 1 if it is successfully sent
	by profit tools.  Not 1 if something fails.
DESCRIPTION:
		The following is responsible for putting the edi file where it needs to be in the format it should be in, if
		profit tools isn't sending the file.
		
		IF profit tools is sending the file, then it does that.  (Note that XML files cannot be sent if profit tools
		handles the sending, this is because the Freddi object can only doe one of the following.  It can save the
		document to XML format, in which case another program can send it.  Or it can Send the document in EDI format.)
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 1-27-2006

				****: REDONE By Dan 1-5-2007  -Moved send logic into a nonvisual object.
														-No longer uses Fredi, uses wininet.		

***************************************************************************************/

int 	li_return
int	li_res

Long	ll_coId
Long	ll_index 
Long	lla_sourceIds[]

String	ls_value
String	ls_Name
String	ls_remedy
String	ls_donePath
String	ls_errormessage

Boolean 		lb_putInOutBoundFolder
Boolean		lb_sendByProfitTools

Datastore	lds_transportSettings

n_cst_wininet_ftp        	lnv_ftp

n_cst_errorlog					lnv_error
n_cst_errorlog_manager		lnv_errorlogManager
n_cst_bso_ediManager 		lnv_ediManager
n_cst_setting_editransport lnv_transportsetting


n_cst_errorremedy_edi_resendfile	lnv_resendRemedie			//added 1-4-2006

n_cst_ftp_edi lnv_ftpTransport 


lnv_transportSetting = create n_cst_setting_editransport
lnv_ediManager = create n_cst_bso_ediManager

ls_value = lnv_transportsetting.of_getValue( )

li_return = 1
ll_coId = this.of_getEdicompanyid( )
ls_remedy = "n_cst_errorremedy_edi_resendFile"

lds_transportSettings = CREATE datastore
lds_transportSettings.dataobject = "d_transportsettings"
lds_transportSettings.setTransobject( SQLCA )

ll_index = lds_transportSettings.Retrieve( ll_coId )		//there should be 1 row retrieved

IF ll_index > 0 THEN
	lb_sendByProfitTools = (ls_value = "Yes")
END IF

lnv_errorLogManager = create n_cst_errorlog_manager

IF lb_sendByProfitTools THEN
	
	lnv_ftpTransport = create n_cst_ftp_edi
	li_return = lnv_ftpTransport.of_sendfile( as_filepath, ii_transactionset, ls_errorMessage, ll_coId, as_FileFormat)
	DESTROY lnv_ftpTransport

	IF li_return = -1 THEN
		//-----------------Handle Error-------------------------------------
		//failed to send we want to log an error and move the file to the outbound folder: as_topath
		lb_putInOutBoundFolder = true
		lnv_error = CREATE n_cst_errorlog	

		lla_sourceIds[1] = ll_coId

		lnv_error.of_setlogdata( "EDI", string( ii_transactionset )+" Send EDI" ,  String(Today(), "m/d/yy hh:mm")+" "+ls_errorMessage+"~r~nFile::"+as_toPath, 1, lla_sourceIds[], ls_remedy )
		
		lnv_errorLogManager.of_logerror( lnv_error )
		Destroy lnv_error
	
		//if it failed to be sent for any reason it is moved to the outboundfolder.
		li_return = FileMove( as_filePath, as_toPath )
		//------------------END Handle Error-----------------------------------
	ELSE
		//------------------Handle Success-------------------------------------
		//if it was sent successfully then we want to put the file into its done location
		//which is created if it doesn't exist.
		//FileDelete( as_filePath )
		ls_Name = right( as_toPath, len( as_toPath ) - lastpos(as_toPath,"\") )
		ls_donePath = left( as_toPath, Lastpos( as_toPath, "\" ) - 1 )  //should change 'C:\ediwhatever\filname.txt' to 'C:\ediwhatever done'
		ls_donePath += " done"
		IF not DirectoryExists( ls_donePath ) THEN
			li_res = Createdirectory( ls_donePath )
		ELSE
			li_Res = 1
		END IF
		
		
		//once the file has been sent we keep a copy of the sent file locally
		IF li_res = 1 THEN
			ls_donePath = lnv_ediManager.of_appendtoprocessedlocationpath( ls_donePath )
			ls_donePath += "\" +ls_Name
			li_res = FileMove( as_filePath, ls_donePath )
		END IF
		//--------------------END Handle Success --------------------------------
	END IF

ELSE			
	//-----------------FTP not handled by Profit Tools-----------------
	
	IF isValid( anv_ediDocument ) THEN
		//if the oleobject is valid, then we can save the file to the correct location.
		//(it will always be valid if Validation is Being done on the object)
		li_return = anv_ediDocument.Save( as_toPath, 1/*binary*/ )
	ELSE
		//we just move the file
		li_return = FileMove( as_filePath, as_toPath )
	END IF
	
	IF li_return <> 1 THEN
		//File failed to be moved 
	ELSE
		//success, we can delete the old file if it exists
		IF FileExists(as_filePath) THEN
			FileDelete( as_filePath )
		END IF
	END IF
	//------------------end old Processing-------------------------------
END IF

IF isValid( lnv_errorlogManager ) THEN
	destroy lnv_errorlogManager
END IF

DESTROY lds_transportSettings
DESTROY lnv_transportsetting
DESTROY lnv_ediManager
DESTROY lnv_ftp

return li_return

/*  commented out on 1-4-2007, includes changes to send using remedy object if fredi fails to send.
int 	li_return
int	li_res
int	li_Rc
int	li_passiveTransfer
Long	ll_coId
Long	ll_index 

Long	li_mode
Long	ll_port
Long	ll_timeout
Long	lla_sourceIds[]
String	ls_userId
String	ls_password
String	ls_protocol
String	ls_address
String	ls_value
String	ls_targetPath
String	ls_Name
String	ls_extension
String	ls_columnName
String	ls_remedy

String	ls_donePath
String	ls_errormessage
Boolean 	lb_putInOutBoundFolder
Boolean	lb_FrediFailed

Long			ll_rows
OleObject   lnv_ftpConfig
OleObject	lnv_transports
OleObject	lnv_transport
Boolean		lb_sendByProfitTools
Datastore	lds_transportSettings
Datastore	lds_transactionPaths
n_cst_wininet_ftp        lnv_ftp

n_cst_errorlog			lnv_error
n_cst_errorlog_manager	lnv_errorlogManager
n_cst_bso_ediManager lnv_ediManager
n_cst_setting_editransport lnv_transportsetting


n_cst_errorremedy_edi_resendfile	lnv_resendRemedie			//added 1-4-2006

lnv_ftp = create n_cst_wininet_ftp

lnv_transportSetting = create n_cst_setting_editransport
lnv_ediManager = create n_cst_bso_ediManager

ls_value = lnv_transportsetting.of_getValue( )

lds_transportSettings = CREATE datastore
lds_transportSettings.dataobject = "d_transportsettings"
lds_transportSettings.setTransobject( SQLCA )

lds_transactionPaths = CREATE datastore
lds_transactionPaths.dataobject = "d_transactionpaths"
lds_transactionPaths.settransobject( SQLCA )

li_return = 1
ll_coId = this.of_getEdicompanyid( )
ls_remedy = "n_cst_errorremedy_edi_resendFile"

ll_index = lds_transportSettings.Retrieve( ll_coId )		//there should be 1 row retrieved
ll_rows = lds_transactionPaths.retrieve( ll_coid )
IF ll_index > 0 THEN
	lb_sendByProfitTools = (ls_value = "Yes")
END IF

lnv_errorLogManager = create n_cst_errorlog_manager
IF lb_sendByProfitTools THEN
	
	//use the Fredi objects to send the data as specified by settings
	
	li_mode = lds_transportSettings.getItemNumber( ll_index, "mode_text" )
	ll_port = lds_transportSettings.getItemNumber( ll_index, "port" )
	ll_timeout = lds_transportSettings.getItemNumber( ll_index, "timeout" )
	ls_userId = lds_transportSettings.getItemString( ll_index, "userid" )
	ls_password = lds_transportSettings.getItemString( ll_index, "password" )
	ls_protocol = lds_transportSettings.getItemString( ll_index, "protocol" )
	ls_address = lds_transportSettings.getItemString( ll_index, "address" )
	li_passiveTransfer = lds_transportSettings.getItemNumber( ll_index, "passive_transfer" )
	
	FOR ll_index = 1 TO ll_rows 
		IF lds_transactionPaths.getItemNumber( ll_index, "transactionset") = ii_transactionset THEN
			ls_targetPath = lds_transactionPaths.getItemstring( ll_index, "remotepaths" )
			EXIT
		END IF
	NEXT
		
	IF isValid( anv_edidocument ) THEN
		lnv_transports = anv_ediDocument.getTransports( )
		
		IF NOT isValid( lnv_transports ) THEN
			li_return = -1
		END IF
		
		IF li_return = 1 THEN
			lnv_transport = lnv_transports.CreateTransport( )
		END IF
		
		IF not isValid( lnv_transport ) THEN
			li_return  = -1
		END IF
		
		IF li_return = 1 THEN

			//set up the method of transport
			CHOOSE CASE ls_protocol
				CASE "FTP"
					li_return = lnv_transport.setFTP()
					IF li_return = 1 THEN
						lnv_transport.Address = ls_address
						lnv_transport.Password = ls_password
						lnv_transport.User = ls_userId
						lnv_transport.serverport = ll_port
						lnv_transport.timeout = ll_timeout				//seconds
						
						//if ls_target path IS null, and the rest of the info is valid
						//FREDI drops the file at the connecting directory.
						IF not IsNull( ls_targetPath ) THEN
							lnv_transport.TargetPath = ls_targetPath
						END IF
						
						IF li_passiveTransfer = 1 THEN
							lnv_ftpConfig = lnv_transport.GetFtpCfg()
							IF isValid( lnv_ftpConfig ) THEN
								lnv_ftpConfig.EnablePassive = true		//default is false
							END IF
						END IF	
					END IF
			
				CASE "SMTP"
					li_return = lnv_transport.setSMTP()
					IF li_return = 1 THEN
						lnv_transport.Address = ls_address
						lnv_transport.DisplayName = ls_userid
						lnv_transport.Message = "Please see EDI file"
						lnv_transport.Subject = "EDI file"
					END IF
				CASE "HTTP"
					li_return = lnv_transport.setHTTP()
					IF li_return = 1 THEN
						lnv_transport.address = ls_address
						IF not IsNull( ls_targetPath ) THEN
							lnv_transport.TargetPath = ls_targetPath
						END IF
					END IF
				CASE ELSE
					li_return = -1
			END CHOOSE
		END IF
		
		//send the file, we use a different object to test the connection first because
		//FREDI crashes if we try to send to an invalid path.
		IF li_return = 1 THEN
			li_Rc = lnv_ftp.of_internetautodial( )
			
			//if success initialize the object
			//IF li_rc = 1 THEN
				lnv_ftp.event ue_init( )
			//END IF
			
			//if connected to the internet try to connect to server
			IF li_rc > -1 THEN 

				//already connected or connects
				IF li_passiveTransfer = 1 THEN
					li_rc = lnv_ftp.of_connect( ls_address, ls_userId, ls_password, ll_port, appeon_constant.InternetConnect_Passive )
				ELSE
					li_rc = lnv_ftp.of_connect( ls_address, ls_userId, ls_password, ll_port )
				END IF			
				
				IF li_rc > 0 THEN
					ls_Name = right( as_toPath, len( as_toPath ) - lastpos(as_toPath,"\") )
					ls_extension = this.of_getoutboundfileextension( )
					
					
					IF len( ls_targetPath ) > 0 THEN
						//this function fails if ls_targetpath is null, but fredi will not
						//fail because when ls_targetPath is null, it doesn't set the transferobject target path.
						//this results in fredi's target path being the one that it is currently connected to.
						IF lnv_ftp.of_changedirectory( ls_targetPath ) = 1 THEN
							TRY //added try on 1-4-2006
								li_return = lnv_transport.send( ls_Name )
							CATCH( oleruntimeerror olerr)
								lb_FrediFailed = true
								DESTROY olerr
							END TRY
						ELSE
							//directory doesn't exist, we fail to send
							lb_putInoutBoundFolder = true
							lnv_error = CREATE n_cst_errorlog	
				
							lla_sourceIds[1] = ll_coId
							
							//ls_remedy = this.of_getremedyobjectstring( )
							lnv_error.of_setlogdata( "EDI", string( ii_transactionset )+" Send EDI" ,  String(Today(), "m/d/yy hh:mm")+" EDI file could not be sent, the specified path on the ftp server doesn't exist.~r~nFile::"+ as_topath, 1, lla_sourceIds[], ls_remedy )
							
							lnv_errorLogManager.of_logerror( lnv_error )
							Destroy lnv_error
						END IF
					ELSE
						TRY	//added try catch on 1-4-2006
							li_return = lnv_transport.send( ls_Name )
						CATCH( oleruntimeerror olerr2)
							lb_frediFailed = true
							DESTROY olerr2
						END TRY
					END IF
					
					//added 1-4-2006
					//this is my solution to failed sends using the fredi object, its a backup send that uses
					//the wininet stuff instead.
					IF lb_frediFailed THEN
						lnv_resendRemedie = create n_cst_errorremedy_edi_resendfile
						li_return = lnv_resendRemedie.of_sendfile( as_filepath, ii_transactionset, ls_errorMessage, ll_coId, as_FileFormat )
						destroy lnv_resendRemedie
						
						IF li_Return = -1 THEN
							lnv_error = CREATE n_cst_errorlog	
			
							lla_sourceIds[1] = ll_coId
					
							//ls_remedy = this.of_getremedyobjectstring( )
							lnv_error.of_setlogdata( "EDI", string( ii_transactionset )+" Send EDI" ,  String(Today(), "m/d/yy hh:mm")+" Ole error, fredi failed on call send().~r~nAttempt to send using wininet failed as well."+"~r~nFile::"+as_toPath, 1, lla_sourceIds[], ls_remedy )
							
							lnv_errorLogManager.of_logerror( lnv_error )
							Destroy lnv_error
						END IF
					END IF
					//--------------
				ELSE
					//failed to connect to FTP server
					lb_putInOutBoundFolder = true
					lnv_error = CREATE n_cst_errorlog	
			
					lla_sourceIds[1] = ll_coId
					
					//ls_remedy = this.of_getremedyobjectstring( )
					lnv_error.of_setlogdata( "EDI", string( ii_transactionset )+" Send EDI" ,  String(Today(), "m/d/yy hh:mm")+" EDI file could not be sent, error connecting to specified FTP server.~r~nFile::"+ as_topath, 1, lla_sourceIds[], ls_remedy )
					
					lnv_errorLogManager.of_logerror( lnv_error )
					Destroy lnv_error
				END IF
			ELSE
				//Failed to connect to the internet
				lb_putInOutBoundFolder = true
				lnv_error = CREATE n_cst_errorlog	
			
				lla_sourceIds[1] = ll_coId
				
				//ls_remedy = this.of_getremedyobjectstring( )
				lnv_error.of_setlogdata( "EDI", string( ii_transactionset )+" Send EDI" ,  String(Today(), "m/d/yy hh:mm")+" EDI file could not be sent, failed to connect to internet.~r~nFile::"+ as_topath, 1, lla_sourceIds[], ls_remedy )
				
				lnv_errorLogManager.of_logerror( lnv_error )
				Destroy lnv_error
				END IF
		ELSE
			//for some reason the transaction couldn't be sent by profit tools.
			//we will put it int the outbound folder specified on the transaction page.
			lb_putInOutBoundFolder = true
			lnv_error = CREATE n_cst_errorlog	
			
			lla_sourceIds[1] = ll_coId
			
			//ls_remedy = this.of_getremedyobjectstring( )
			lnv_error.of_setlogdata( "EDI", string( ii_transactionset )+" Send EDI" ,  String(Today(), "m/d/yy hh:mm")+" EDI file could not be sent, error setting up Freddi object.~r~nFile::"+ as_topath, 1, lla_sourceIds[], ls_remedy )
			
			lnv_errorLogManager.of_logerror( lnv_error )
			Destroy lnv_error
		END IF		
		
		IF lb_putInOutBoundFolder THEN
			li_return = FileMove( as_filePath, as_toPath )
		END IF
		
		IF li_return = 1 THEN
			//if it was sent successfully then we want to put the file into its done location
			//which is created if it doesn't exist.
			//FileDelete( as_filePath )
			ls_donePath = left( as_toPath, Lastpos( as_toPath, "\" ) - 1 )  //should change 'C:\ediwhatever\filname.txt' to 'C:\ediwhatever done'
			ls_donePath += " done"
			IF not DirectoryExists( ls_donePath ) THEN
				li_res = Createdirectory( ls_donePath )
			ELSE
				li_Res = 1
			END IF
			
			
			//once the file has been sent we keep a copy of the sent file locally
			IF li_res = 1 THEN
			   ls_donePath = lnv_ediManager.of_appendtoprocessedlocationpath( ls_donePath )
				ls_donePath += "\" +ls_Name
				li_res = FileMove( as_filePath, ls_donePath )
			END IF
			
		END IF
	ELSE
		li_return = -1
	END IF
ELSE
	//if the validation really passed the validator
	//then a valid edidocument should be passed back, meaning we can
	//save it as XML if they have that setting selected.  It is possible
	//that it passed validation without actually getting sent through
	//the validator in the event that they don't want to run it through the validator
	//and still send it.  This is because we didnt' want to break old stuff that 
	//worked.  We know it didn't actually get run through the validator if
	//it passes the validation function but returns an invalid oleobject.
	IF isValid( anv_ediDocument ) THEN
		IF as_FileFormat = "XML!" THEN
			li_return = anv_ediDocument.Save( as_toPath+".xml", 2/*xml*/ )
		ELSE
			//I am unsure if this will do line or stream, I may have to test it.
			//If it doesn't, then I will have to move the deletefile call to only 
			//work in the xml portion.  ANd change the save to a File Move for 
			//
			li_return = anv_ediDocument.Save( as_toPath, 1/*binary*/ )
		END IF
	ELSE
		//old functionality doesn't support XML.
		li_return = FileMove( as_filePath, as_toPath )
	END IF
	
	IF li_return <> 1 THEN
		//MessageBox("Edi Save",  "File failed to be moved successfully to "+as_topath+".~r~nIt can be found at "+ as_filePath )
	ELSE
		//success, we can delete the old file if it exists
		IF FileExists(as_filePath) THEN
			FileDelete( as_filePath )
		END IF
	END IF
END IF

IF isValid( lnv_errorlogManager ) THEN
	destroy lnv_errorlogManager
END IF

DESTROY lnv_ftpConfig
Destroy lnv_transportsetting
DESTROY lds_transactionPaths
DESTROY lds_transportSettings
DESTROY lnv_ediManager
DESTROY lnv_ftp
return li_return */
end function

protected function string of_getidcolname ();//this is the column that the cache has its shipment....or other relevent id in for error remedies.
//The 322 and 990 use a different column name.
return "sourceid"
end function

protected function integer of_getidsfromcache (ref long ala_ids[], string as_columnname);//written by Dan, 5-10-06
//This function expects that cache is filtered to the relevent shipments or events or etc....for the
//edi file that is being written in of_writeResultstoFile.  The id's returned are intended to represent
//the ids necessary for the remedy objects, if for some reason the validation fails.

Long lla_ids[]
Long	ll_index
Long	ll_max

n_ds	lds_cache

lds_cache = this.of_GetEDICache(false)

ll_max = lds_cache.rowcount()
FOR ll_index = 1 TO ll_max
	lla_ids[ll_index] = lds_cache.getItemNumber( ll_index, as_columnName ) 
NEXT


ala_ids = lla_ids

RETURN upperBound( lla_ids )




end function

public function integer of_processalledi (string asa_header[], string asa_footer[], long ala_ids[], string as_outputfolder, string asa_templatearray[]);//Created By Dan 5-15-06, intended to be implemented on descendents.
//The 322 and the 214 will use it.
RETURN 0
end function

public function string of_geterrorcontext (long ala_ids[]);//Dan 5-16-06 intended to be implemented on descendents to return a message based on the ids passed in,
//to give information about what went wrong and how to fix the problem.

RETURN String(Today(), "m/d/yy hh:mm")+" Could not send EDI file. Fix errors and resend. "
end function

public function string of_getremedyobjectstring ();//written by dan 5-17-06
return "n_cst_errorremedy_edi"
end function

protected function string of_geteditransactionfilename (any aa_beosource, string as_controlnumber);/*
//written by dan 6-2-2006
//The following  checks the companies fileNaming schema to generate a fileName
//for the edi transaction.

DEK: modified filter to look for only outbound transactions file naming schemas on 3-5-07.

*/
Long			ll_index
Long			ll_max
Int			li_pos

String		ls_value
Boolean		lb_oldWay
String		ls_fileName
String		lS_schema
String		ls_lengthOFNumber
String		ls_controlNum
String		ls_firstPart
String		ls_lastPart
String		ls_controlNumber
Datastore	lds_profile
S_parm		lstr_parm
n_cst_msg 	lnv_tagmessage
n_cst_bso_reportManager	lnv_reportmanager
n_cst_string	lnv_string

lds_profile = this.of_getprofile( )

IF isValid( lds_profile ) THEN
	
	lds_profile.setFilter( "companyid = "+string( li_edicoid ) + " AND transactionset = "+string( ii_transactionset ) +" and in_out = '"+ "OUTBOUND" + "'" ) //Dek changed filter 3-5-07
	lds_profile.filter()
	ll_max = lds_profile.rowcount( )
	
	IF ll_max > 0 THEN
		ls_schema = lds_profile.getItemString( 1, "filenameschema" )
		IF isNull( ls_schema ) OR ls_schema = "" THEN
			//old way
			lb_oldway = true
		ELSE
			
			lstr_parm.is_Label = "TODAYLONG"
			ls_value = string(today(),"yyyymmdd")
			if isnull(ls_value) then
				ls_value = ''
			end if
			lstr_Parm.ia_Value = ls_value
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )
			
			lstr_parm.is_Label = "TODAY"
			ls_value = string(today(),"yymmdd")
			if isnull(ls_value) then
				ls_value = ''
			end if
			lstr_Parm.ia_Value = ls_value
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )
			
			lstr_parm.is_Label = "NOW"
			ls_value = string(now(),"hhmm")
			if isnull(ls_value) then
				ls_value = ''
			end if
			lstr_Parm.ia_Value = ls_value
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )
			
			lstr_parm.is_Label = "CONTROLNUMBER"
			ls_controlnumber = as_controlnumber//this.of_GetControlNumber()
			lstr_Parm.ia_Value = ls_controlnumber
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
			
			
			//if the user requested a sequential number that is a certain number of characters long
			//(at least 4 less than 9), then i need to find out how long it will be.
			//The beo will have to look at the message object to determin what the tag value is.
			//I must tack on teh tag value <number> instead, which will be the tag that is searched for
			//in the message object.  FOr the value in the message object, I will put in the control number string
			//which will be truncated to the appropriate length.
			IF MATCH( lower( ls_schema), "<number[4-9]>" ) THEN
				//---parses out the number and length
				li_pos = POS( lower(ls_schema), "<number" )
				li_pos += 7		//the position of the length the control number will have
				ls_lengthOfNumber = mid( ls_schema, li_pos, 1 )   //should be any nubmer between 4 and 9
				//ls_schema += "<number>"		
				ls_controlNum = RIGHT( as_controlNumber, Integer(ls_lengthOfNumber) )
				
				lstr_parm.is_label = "number4"
				ls_controlNum = RIGHT( as_controlNumber, 4 )
				lstr_parm.ia_value = ls_controlNum
				lnv_tagMessage.of_add_parm( lstr_parm )
				
				lstr_parm.is_label = "number5"
				ls_controlNum = RIGHT( as_controlNumber, 5 )
				lstr_parm.ia_value = ls_controlNum
				lnv_tagMessage.of_add_parm( lstr_parm )
				
				lstr_parm.is_label = "number6"
				ls_controlNum = RIGHT( as_controlNumber, 6 )
				lstr_parm.ia_value = ls_controlNum
				lnv_tagMessage.of_add_parm( lstr_parm )
				
				lstr_parm.is_label = "number7"
				ls_controlNum = RIGHT( as_controlNumber, 7 )
				lstr_parm.ia_value = ls_controlNum
				lnv_tagMessage.of_add_parm( lstr_parm )
				
				lstr_parm.is_label = "number8"
				ls_controlNum = RIGHT( as_controlNumber, 8 )
				lstr_parm.ia_value = ls_controlNum
				lnv_tagMessage.of_add_parm( lstr_parm )
				
				lstr_parm.is_label = "number9"
				ls_controlNum = RIGHT( as_controlNumber, 9 )
				lstr_parm.ia_value = ls_controlNum
				lnv_tagMessage.of_add_parm( lstr_parm )
				//------------------------------
				//   Replace the <number[4-9]> with <number>
//				li_pos = POS( lower(ls_schema), "<number" )
//				ls_firstPart = left( ls_schema, li_pos - 1 )  
//				ls_lastPart = RIGHT( ls_schema, len(ls_schema) - (li_pos + 8) )	//subtracting the last posisiont of the tag <number8> whcih happens to be the start position + 8
//				ls_schema = ls_firstpart +"<number>"+ ls_lastPart
			END IF
			
			IF ii_transactionset <> 997  THEN
				lnv_reportManager.of_processstring( ls_schema, ls_fileName, {aa_beoSource}, lnv_tagmessage )
			ELSE
				//997 doesn't use a valid beo so we have to call the tagged version
				lnv_reportManager.of_processstring( ls_schema, ls_fileName,lnv_tagMessage)
			END IF  
		END IF	
	ELSE
		//old way
		lb_oldway = true
	END IF
ELSE
	//do the old way
	lb_oldway = true
END IF

IF lb_oldway THEN
	ls_fileName = as_controlNumber 
END IF
ls_fileName += this.of_getoutboundfileextension( )

lds_profile.setFilter( "" )
lds_profile.filter()

RETURN ls_fileName



end function

public function string of_gettemplatefile (long al_set, long al_coid, string as_type);/*
	DEK: changed function to take additional argument as_type so we can distinguish between in and out bound settings. 3-5-07
*/
string	ls_findstring, &
			ls_filename

long		ll_found

n_ds		lds_Profile

lds_profile = this.of_GetProfile()

//Changed 3-5-07 to search based on type as well for inbound or outbound.
ls_findstring = "transactionset = " + string(al_set) + " and companyid = " + string(al_coid) + " and in_out = '"+ as_type +"'"

if isvalid(lds_profile) then
	ll_found = lds_profile.find(ls_findstring, 1, lds_profile.rowcount())
end if

if ll_found > 0 then
	ls_filename = lds_profile.object.template[ll_found]
end if

return ls_filename

end function

public function string of_getoutputfolder (long al_set, long al_coid, string as_type);/*
	DEK: changed to take additional argument so we can specify inbound or outbound 3-5-07
*/
string	ls_findstring, &
			ls_folder

long		ll_found

n_ds		lds_Profile

lds_profile = this.of_GetProfile()

ls_findstring = "transactionset = " + string(al_set) + " and companyid = " + string(al_coid) + " and in_out = '"+ as_type +"'"

if isvalid(lds_profile) then
	ll_found = lds_profile.find(ls_findstring, 1, lds_profile.rowcount())
end if

if ll_found > 0 then
	ls_folder = lds_profile.object.folder[ll_found]
end if

return ls_folder

end function

public function string of_getscac ();Integer	li_Return
string	ls_scac
any		la_scac

n_cst_settings lnv_Settings
n_cst_string	lnv_string

li_Return = 1

IF lnv_Settings.of_GetSetting ( 83 , la_scac ) <> 1 THEN
	li_Return = -1
else
	ls_scac = String ( la_scac )
END IF

IF li_Return <> 1 THEN
	ls_scac = ""
END IF

return ls_scac
end function

protected function integer of_addedientry (integer al_transactionset, string as_source, long al_sourceid, long al_company, date ad_processeddate, time at_processedtime, string as_errorstring, string as_inout);/*
	DEK: added another paramter to this function to specify if the entry is inbound or outbound. 3-8-07
*/
Long	ll_NextId
Long	ll_NewRow
Int	li_Return = 1
Constant	boolean	cb_Commit = TRUE

DataStore	lds_EDI
lds_Edi = CREATE DataStore

lds_EDI.DataObject = "d_edi"
lds_EDI.SetTransObject ( SQLCA )

IF gnv_App.of_GetNextId ( "edi", ll_NextId, cb_Commit ) <> 1 THEN
	li_Return = -1
END IF
		
IF li_Return = 1 THEN
	ll_NewRow = lds_EDI.InsertRow ( 0 ) 
	IF ll_NewRow <= 0 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF lds_EDI.Setitem ( ll_NewRow , "id" ,ll_NextId  ) <> 1 THEN
		li_Return = -1
	END IF
END IF
IF li_Return = 1 THEN
	IF lds_EDI.Setitem ( ll_NewRow , "transactionset" ,al_transactionset  ) <> 1 THEN
		li_Return = -1
	END IF
END IF	
IF li_Return = 1 THEN
	IF lds_EDI.Setitem ( ll_NewRow , "source" ,as_Source )<> 1 THEN
		li_Return = -1
	END IF
END IF
IF li_Return = 1 THEN
	IF lds_EDI.Setitem ( ll_NewRow , "sourceid" ,al_sourceid  )<> 1 THEN
		li_Return = -1
	END IF
END IF
IF li_Return = 1 THEN			
	IF lds_EDI.Setitem ( ll_NewRow , "company" ,al_company  ) <> 1 THEN
		li_Return = -1
	END IF
END IF
IF li_Return = 1 THEN
	IF lds_EDI.Setitem ( ll_NewRow , "processeddate" ,ad_processeddate  ) <> 1 THEN
		li_Return = -1
	END IF
END IF
IF li_Return = 1 THEN
	IF lds_EDI.Setitem ( ll_NewRow , "processedtime" ,at_processedtime  ) <> 1 THEN
		li_Return = -1
	END IF
END IF
IF li_Return = 1 THEN
	IF lds_EDI.Setitem ( ll_NewRow , "errormessage" ,as_errorstring  ) <> 1 THEN
		li_Return = -1
	END IF
END IF
////////Added By Dan 3-8-07
//IF li_Return = 1 THEN
//	IF lds_EDI.Setitem ( ll_NewRow , "in_out" ,as_inout  ) <> 1 THEN
//		li_Return = -1
//	END IF
//END IF
//////////////////////	
IF li_Return = 1 THEN
	IF lds_EDI.update ( ) <> 1 THEN
		rollback;
		li_Return = -1
	else
		commit;
	END IF
END IF

DESTROY ( lds_EDI )
RETURN li_Return
	

end function

public subroutine of_createtransaction (ref n_ds ads_edipending, ref long ala_ediid[], ref long ala_sourceid[]);
end subroutine

public function string of_getseffile ();//Created By Dan 1-20-2006
//Returns the path of the seffile for the EDI transaction object to use on validation.
Long		ll_coid
Long		ll_rows
String	ls_file


Datastore	lds_transactionPaths
lds_transactionPaths = Create datastore
lds_transactionPaths.dataobject = "d_ediprofile"
lds_transactionPaths.setTransobject( SQLCA )

ll_coid = this.of_getEdicompanyid( )

ll_rows = lds_transactionPaths.retrieve( ll_coid, ii_transactionset, appeon_constant.cs_transaction_OUTBOUND  )

IF ll_rows > 0 THEN
	ls_file = lds_transactionPaths.getItemString( 1, "seffilepath" )
	
	IF len( ls_file ) = 0 THEN
		setnull( ls_file )
	END IF	

END IF

Destroy lds_transactionPaths

RETURN ls_file
end function

on n_cst_edi_transaction.create
call super::create
end on

on n_cst_edi_transaction.destroy
call super::destroy
end on

event destructor;if isvalid(inv_dispatch) then
	destroy inv_Dispatch
end if

if isvalid(ids_datamapping) then
	destroy ids_datamapping
end if

if isvalid(ids_notification) then
	destroy ids_notification
end if

if isvalid(ids_profile) then
	destroy ids_profile
end if

end event

