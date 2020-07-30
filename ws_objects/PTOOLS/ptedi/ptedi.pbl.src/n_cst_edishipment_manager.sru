$PBExportHeader$n_cst_edishipment_manager.sru
forward
global type n_cst_edishipment_manager from n_cst_base
end type
end forward

global type n_cst_edishipment_manager from n_cst_base
end type
global n_cst_edishipment_manager n_cst_edishipment_manager

type variables
CONSTANT	String	cs_EDIVersion_Pseudo = "1.0 (pseudo)"  		// mcst
CONSTANT	String	cs_EDIVersion_VanMapping = "2.0 (VAN mapping)"  // Toal WH
CONSTANT	String	cs_EDIVersion_DirectWithAutoReply = "3.0 (Direct auto accept)"
CONSTANT	String	cs_EDIVersion_Direct	= "4.0 (Direct)"


Protected:
n_cst_edisegment		inva_Segments[]
Int						ii_SegmentCount

DataStore				ids_ShipmentMapping
DataStore				ids_EquipmentMapping
DataStore				ids_EventMapping
DataStore				ids_ItemMapping
DataStore				ids_ValueMapping

DataStore				ids_CompanySettings


n_Cst_bso_Dispatch	inv_Dispatch
n_cst_beo_Shipment	inv_Shipment


Constant String	cs_Import = "I"
Constant String	cs_Export = "E"
Constant String	cs_OneWay = "O"




Long	il_SourceCompany
Long	il_ShipmentID


/// new for direct

String isa_Records[]

PUBLIC Constant	String	cs_SetPurpose_Original = "00"
PUBLIC Constant	String	cs_SetPurpose_Cancel = "01"
PUBLIC Constant	String	cs_SetPurpose_Change = "04"
n_cst_errorlog_manager	inv_errorLog

PRIVATE:
n_cst_EdiShipment_Manager	inv_CompareManager
end variables

forward prototypes
private function integer of_loadshipmentmapping ()
public function integer of_showerrormessages ()
private function integer of_processequipmentdata ()
private function integer of_loadequipmentmapping ()
private function integer of_loadeventmapping ()
private function integer of_loaditemmapping ()
private function boolean of_ismovelive ()
private function integer of_loadvaluemapping ()
private function integer of_cancelshipment ()
private function integer of_updateshipment ()
private function integer of_initailizenewshipmentbeo ()
private function integer of_prepareshipmentforupdate ()
private function integer of_loadcompanysettings ()
private function boolean of_allowupdates ()
private function boolean of_allowcancel ()
private function integer of_sendemailerrors ()
public function integer of_clearerrors ()
private function integer of_presetprocess (string as_pttarget, ref any aa_value)
private function integer of_addemailaddresses (ref n_cst_emailmessage anv_msg)
private function boolean of_allowemailstobesent ()
private function integer of_adderrorstolog ()
private function integer of_addintermodalitems ()
private function integer of_makeeventstructurechanges ()
private function string of_createsourcestring ()
private function integer of_addimportedshipmententry ()
public function integer of_processpendingshipments ()
public function integer of_import204filesintopending (string as_filename)
public function integer of_loadsegments (string asa_record[])
protected function integer of_getvalue (string as_segment, string as_element, string as_condition, n_cst_edisegment anva_segmentstosearch[], ref any aa_value)
public subroutine of_resetsegments ()
public function integer of_getelement (string as_segment, integer ai_element, ref string asa_value[])
private function integer of_addimportedshipmententry (n_cst_edisegment anva_segments[])
protected function integer of_addequipment ()
protected function long of_getsegments (string as_segment, ref n_cst_edisegment anva_requestedsegments[])
protected function long of_getsegments (string as_segment, n_cst_edisegment anva_segmentlisttosearch[], ref n_cst_edisegment anva_requestedsegments[])
protected function n_cst_beo_shipment of_getshipment ()
protected function n_cst_bso_dispatch of_getdispatch ()
protected function n_cst_beo_equipment2 of_getnewequipment ()
protected function integer of_geteventstructure (ref string asa_eventtypes[])
protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[])
protected function integer of_getstopgroup (integer ai_stop, ref n_cst_edisegment anva_segments[])
protected function integer of_setdataonbeo (pt_n_cst_beo anv_beo, datastore ads_mapping, n_cst_edisegment anva_sourcesegments[])
protected function integer of_setdataonbeo (pt_n_cst_beo anv_beo, datastore ads_mapping)
protected function integer of_initializenewevents (ref n_cst_beo_event anva_eventlist[])
protected function integer of_adderror (string as_error)
protected function integer of_addevents (ref n_cst_beo_event anva_events[])
public function integer of_importforcompany (long al_sourcecoid)
protected function integer of_determinesourcecompany ()
private function string of_getmappingfolder ()
private subroutine of_send997 (n_cst_edisegment anva_segment[])
protected function integer of_process204request (n_cst_edisegment anva_segments[])
protected function integer of_addnonintermodalitems ()
protected function integer of_getitemmatchingvalues (ref string as_segment, ref string as_element)
protected function boolean of_isstopdelivergroup (string as_stoptype)
protected function boolean of_isstoppickupgroup (string as_stoptype)
protected function integer of_getitemcount (n_cst_edisegment anva_stopsegments[], string as_keysegment, long al_keyelement, ref string asa_keyvalues[])
protected function integer of_setitemdatanonintermodal ()
protected function string of_getmovedirection ()
protected function boolean of_ismoveintermodal ()
protected function integer of_processeventdata ()
protected function integer of_getstopgroupbycondition (string as_segmenttoevaluate, string as_elementcondition, ref n_cst_edisegment anva_segments[])
protected function integer of_setitemdataintermodal ()
protected function integer of_additems ()
protected function integer of_addintermodalitemsifneeded ()
protected function integer of_processitemdata ()
protected function integer of_getequipmentsegments (ref n_cst_edisegment anva_eqsegments[])
protected function datastore of_getpendingdatastore ()
public function string of_geterrorstring ()
protected function integer of_getsegmentsbycondidtion (string as_segment, string as_condition, ref n_cst_edisegment anva_segments[])
protected function integer of_setcharges (n_cst_beo_item anv_targetitem)
protected function integer of_setacccharge (n_cst_beo_item anv_accitem)
public function integer of_applyrates ()
protected function integer of_initializeexistingshipment (string as_importreferenceid)
protected function integer of_processshipmentdata ()
public function string of_getsetpurpose ()
protected function string of_getonewaystopsites ()
protected function integer of_createshipment ()
protected function integer of_getfileformat (string as_filename, ref string as_filetype, ref string as_ediversion, string as_inout)
public function integer of_getreply (integer ai_replynumber, ref n_cst_edisegment anva_segments[])
public function integer of_getshipmentresponses (integer ai_index, ref long al_shipid, ref string as_response, ref string as_reason)
public function integer of_getgroupcontrol (ref long al_groupcontrolnumber, ref string as_sendingcompany)
public function integer of_geteventconfirmation (integer ai_stnumber, ref string as_at7element, ref string as_at7code, ref datetime adt_at7)
public function integer of_getshipeventid (integer ai_stnumber, ref long al_shipid, ref long al_eventid)
public function n_cst_errorlog_manager of_geterrorlogmanager ()
private subroutine of_autorateifneeded ()
private function integer of_preupdateprocess ()
private function integer of_initializemanagerforcompare (long al_shipment)
private function string of_getcomparetransaction (long al_shipment)
private function integer of_evaluateunwantedchanges (pt_n_cst_beo anv_targetbeo, pt_n_cst_beo anv_comparebeo, ref datastore ads_tags)
private function n_cst_beo_event of_getcorespondingevent (n_cst_beo_event anv_event)
end prototypes

private function integer of_loadshipmentmapping ();int	li_Return = -1
String	ls_MappingFile

ls_MappingFile = THIS.of_GetMappingFolder ( ) + "Shipmentmapping.psr"
IF Not IsValid ( ids_shipmentmapping ) THEN
	ids_shipmentmapping = CREATE DataStore
END IF
ids_shipmentmapping.DataObject = ls_MappingFile

IF ids_shipmentmapping.rowCount ( ) > 0 THEN
	li_Return = 1
ELSE
	THIS.of_AddError ("Profit Tools could not successfully load/locate: "+ ls_MappingFile )
END IF

RETURN li_Return
end function

public function integer of_showerrormessages ();int 		li_errorCount
int		i
String	ls_ErrorString

n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_Errorcollection.GetErrorcount( )

For i = 1 TO li_ErrorCount
	ls_ErrorString += string( lnva_Error[i].getErrorMessage() )
next

MessageBox("EDI Shipment" , ls_ErrorString , EXCLAMATION! )

RETURN 1
end function

private function integer of_processequipmentdata ();//MFS - 1/11/06: Added check digit validation

Int	li_Return = 1
Long	ll_EquipmentCount 
Long	i
Long	ll_ShipId
String	ls_EqRef, ls_CDerror
Boolean	lb_RequireCD, lb_ValidateCD
n_cst_beo_Shipment	lnv_Shipment
n_cst_Beo_Equipment2	lnva_equipment[]
n_cst_bso_Dispatch	lnv_Dispatch

n_cst_EquipmentManager	lnv_EqManager
n_cst_errorlog				lnv_Error
n_cst_errorlog_manager	lnv_errorlogmanager

n_cst_setting_requirecheckdigit	lnv_RequireCD
n_cst_setting_validatecheckdigit  lnv_ValidateCD

lnv_RequireCD = Create	n_cst_setting_requirecheckdigit
lb_RequireCD = lnv_RequireCD.of_GetValue() = lnv_RequireCD.cs_YES
Destroy lnv_RequireCD

lnv_ValidateCD = Create n_cst_setting_validatecheckdigit
lb_ValidateCD = lnv_ValidateCD.of_GetValue() = lnv_ValidateCD.cs_Yes
Destroy(lnv_ValidateCD)

lnv_errorlogmanager = Create n_cst_errorlog_manager
lnv_error = Create n_cst_errorlog		

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_getShipment ( )
	IF NOT isValid ( lnv_SHipment ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_getDispatch ( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	ll_ShipId = lnv_Shipment.of_getID ( )
	ll_EquipmentCount = lnv_Dispatch.of_GetEquipmentforshipment( ll_ShipId , lnva_equipment )
	
	FOR i = 1 TO ll_EquipmentCount
		
		IF li_Return = 1 THEN
			// this is where the data gets processed and set
			IF THIS.of_Setdataonbeo( lnva_equipment[i] , ids_Equipmentmapping ) <> 1 THEN  
				li_Return = -1
			END IF
			
			//validate check digit on containers
			IF li_Return = 1 THEN
				ls_EqRef = lnva_equipment[i].of_GetNumber()
				IF UPPER(Mid(ls_EqRef, 4, 1)) = "U" THEN //4th letter 'U' denotes container
					IF lnv_EqManager.of_ValidateCheckDigit(ls_EqRef, ls_CDerror, lb_RequireCD, lb_ValidateCD) <> 1 THEN
						This.of_AddError("Warning: " + ls_CDError)
						lnv_error.of_setlogdata( "EDI", "Invalid Container", "Warning: " + ls_CDError, n_cst_Constants.ci_ErrorLog_Urgency_Low, {ll_ShipId}, "n_cst_errorremedy_openshipment")	
						lnv_errorLogManager.of_logerror( lnv_error )
					END IF
				END IF
			END IF
			
		END IF	
		
		DESTROY ( lnva_Equipment[i] )
		
	NEXT
END IF

Destroy(lnv_error)
Destroy(lnv_errorlogmanager)

RETURN li_Return
end function

private function integer of_loadequipmentmapping ();int	li_Return = -1
String	ls_MappingFile


ls_MappingFile = THIS.of_GetMappingFolder ( ) + "Equipmentmapping.psr"
IF Not isValid ( ids_equipmentmapping ) THEN 
	ids_Equipmentmapping = CREATE DataStore
END IF

ids_Equipmentmapping.DataObject = ls_MappingFile

IF ids_Equipmentmapping.rowCount ( ) > 0 THEN
	li_Return = 1
ELSE
	THIS.of_AddError ("Profit Tools could not successfully load/locate: "+ ls_MappingFile )
END IF

RETURN li_Return
end function

private function integer of_loadeventmapping ();int		li_Return = 1
String	ls_MappingFile

ls_MappingFile = THIS.of_GetMappingFolder ( ) + "Eventmapping"
ls_MappingFile += ".psr"	
IF Not IsValid ( ids_eventmapping ) THEN
	ids_Eventmapping = CREATE DataStore
END IF
ids_Eventmapping.DataObject = ls_MappingFile

IF NOT ids_Eventmapping.rowCount ( ) > 0 THEN
	THIS.of_AddError ("Profit Tools could not successfully load/locate: "+ ls_MappingFile )
	li_Return = -1
END IF


RETURN li_Return
end function

private function integer of_loaditemmapping ();int	li_Return = -1
String	ls_MappingFile

ls_MappingFile = THIS.of_GetMappingFolder ( ) + "Itemmapping.psr"
IF Not IsValid ( ids_ItemMapping ) THEN
	ids_ItemMapping = CREATE DataStore
END IF
ids_ItemMapping.DataObject = ls_MappingFile

IF ids_ItemMapping.rowCount ( ) > 0 THEN
	li_Return = 1
ELSE
	THIS.of_AddError ("Profit Tools could not successfully load/locate: "+ ls_MappingFile )
END IF

RETURN li_Return
end function

private function boolean of_ismovelive ();
/////   NOT USED

Boolean	lb_Return
Int		li_SegmentCount
String	ls_Value

n_cst_edisegment	lnva_Segments[]

li_SegmentCount = THIS.of_Getsegments( "S5", lnva_Segments )

IF li_SegmentCount > 0 THEN
	lnva_Segments[1].of_getvalue( {2} , ls_Value )
	
	CHOOSE CASE ls_Value
		
		CASE	"LE" /*"Spot for Load Exchange (Export)"*/ , &
			  	"SL" /*"Spot for Load"*/ , &
			  	"SU" /*"Spot for Unload"*/ , &
				"DT" /*"Drop Trailer"*/ , &
				"RT" /*"Retrieval of Trailer"*/									
				
		CASE ELSE
			lb_Return = TRUE
						
	END CHOOSE
	
END IF

RETURN lb_Return

/*
AL "Advance Loading"
CL "Complete"
CN "Consolidate"
CU "Complete Unload"
DR "Deramp and Ramp for Subsequent Loading"
DT "Drop Trailer"
HT "Heat the Shipment"
IN "Inspection"
LD "Load"
LE "Spot for Load Exchange (Export)"
PA "Pick-up Pre-loaded Equipment"
PL "Part Load"
PU "Part Unload"
RT "Retrieval of Trailer"
SL "Spot for Load"
SU "Spot for Unload"
TL "Transload"
UL "Unload"
WL "Weigh Loaded"
*/
end function

private function integer of_loadvaluemapping ();int	li_Return = -1
String	ls_MappingFile

ls_MappingFile = THIS.of_GetMappingFolder ( ) + "Valuemapping.psr"
IF Not IsValid ( ids_valuemapping ) THEN
	ids_ValueMapping = CREATE DataStore
END IF
ids_ValueMapping.DataObject = ls_MappingFile

IF ids_ValueMapping.rowCount ( ) > 0 THEN
	li_Return = 1
ELSE
	THIS.of_AddError ("Profit Tools could not successfully load/locate: "+ ls_MappingFile )
END IF

RETURN li_Return
end function

private function integer of_cancelshipment ();Int		li_Return
String	ls_ImportReference

n_Cst_beo_Shipment	lnv_Shipment
n_Cst_EDIsegment		lnva_Segment[]

li_Return = 1

IF li_Return = 1 THEN
	IF THIS.of_GetSegments ( "B2" , lnva_Segment ) > 0 THEN
		IF lnva_Segment[1].of_Getvalue( {4}, ls_ImportReference ) <> 1 THEN
			li_Return = -1
		END IF		
	ELSE
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF THIS.of_Initializeexistingshipment( ls_ImportReference ) <> 1 THEN
		li_Return = -1 
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_Getshipment( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF lnv_Shipment.of_SetStatus ( gc_dispatch.cs_shipmentstatus_cancelled ) <> 1 THEN
		THIS.of_AddError ( "Could not set the status to cancelled for shipment " + String ( lnv_Shipment.of_GetID ( ) )+ "." )
	END IF
END IF


RETURN li_Return
end function

private function integer of_updateshipment ();Int		li_Return
String	ls_ImportReference

n_Cst_beo_Shipment	lnv_Shipment
n_Cst_EDIsegment		lnva_Segment[]
n_cst_bso_Dispatch	lnv_Dispatch

li_Return = 1

IF li_Return = 1 THEN
	IF THIS.of_Prepareshipmentforupdate( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

// equipment level
IF li_Return = 1 THEN
	IF THIS.of_ProcessEquipmentData ( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

// event level
IF li_Return = 1 THEN	
	IF THIS.of_ProcessEventData ( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

// item level
IF li_Return = 1 THEN	
	IF THIS.of_ProcessItemData ( ) <> 1 THEN  // this adds items
		li_Return = -1
	END IF
END IF

// shipment level
IF li_Return = 1 THEN
	IF THIS.of_ProcessShipmentData ( ) <> 1 THEN
		li_Return = -1
	END IF
END IF


RETURN li_Return

end function

private function integer of_initailizenewshipmentbeo ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_initailizenewshipmentbeo
//  
//	Access		: Private
//
//	Arguments	: NONE
//			
//
//	Return		: Int
//					
//						
//	Description	: Create a new/empty shipment and add the items 
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Long	ll_ShipID
Int	li_Return = 1
n_cst_shipmentmanager	lnv_ShipmentManager
n_cst_bso_Dispatch		lnv_Dispatch	
n_cst_beo_SHipment		lnv_Shipment

n_cst_msg				lnv_Msg
S_Parm					lstr_Parm

lstr_Parm.is_Label = "Display"
lstr_Parm.ia_Value = FALSE
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Notify"  // upon failure 
lstr_Parm.ia_Value = FALSE
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "FreightItemCount"
lstr_Parm.ia_Value = 0
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Style"
lstr_Parm.ia_Value = "EMPTY!"
lnv_Msg.of_Add_Parm ( lstr_Parm )

ll_ShipID = lnv_ShipmentManager.of_Newshipment( lnv_Msg )

IF ll_ShipID <= 0 THEN
	li_Return = -1
	THIS.of_AddError ("Could not initialize new shipment." )
END IF

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_getdispatch( )
	IF lnv_Dispatch.of_retrieveshipment( ll_ShipID ) <> 1 THEN
		li_Return = -1
		THIS.of_AddError ( "Could not retrieve shipment." )
	ELSE
		lnv_Dispatch.of_FilterShipment ( ll_ShipID )
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_GetShipment ( )
	IF Not isValid ( lnv_Shipment ) THEN
		li_Return = -1
		THIS.of_Adderror( "Could not get a valid shipment." )
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment.of_SetSource ( lnv_Dispatch.of_getshipmentcache( ) )
	lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_getItemcache( ) )
	lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_getEventcache( ) )
	lnv_Shipment.of_SetSourceID ( ll_ShipID )
	lnv_Shipment.of_SetStatus( gc_Dispatch.cs_ShipmentStatus_Offered )
	lnv_Shipment.of_SetAllowFilterSet ( TRUE )
	lnv_Shipment.of_SetContext ( lnv_Dispatch )
END IF

//IF li_Return = 1 THEN
//	IF THIS.of_ISMoveintermodal( ) THEN
//		IF THIS.of_addintermodalitemsifneeded( ) <> 1 THEN
//			li_Return = -1
//		END IF
//	ELSE
//		IF THIS.of_AddNonintermodalitems( ) <> 1 THEN
//			li_Return = -1
//		END IF
//	END IF
//END IF
//


RETURN li_Return
end function

private function integer of_prepareshipmentforupdate ();Int		li_Return
Int		li_ItemCount
Int		i
String	ls_ImportReference
Long		ll_NewID

n_Cst_beo_Shipment	lnv_Shipment
n_Cst_EDIsegment		lnva_Segment[]
n_cst_beo_Item			lnva_Items[]
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnv_Event

lnv_Event = CREATE n_cst_beo_Event

li_Return = 1
IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_GetDispatch ( )
	IF NOT IsValid( lnv_Dispatch) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_GetShipment ( )
	IF NOT IsValid( lnv_Shipment) THEN
		li_Return = -1
	END IF
END IF
		

IF li_Return = 1 THEN
	IF THIS.of_GetSegments ( "B2" , lnva_Segment ) > 0 THEN
		IF lnva_Segment[1].of_Getvalue( {4}, ls_ImportReference ) <> 1 THEN
			li_Return = -1
		END IF		
	ELSE
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF THIS.of_Initializeexistingshipment( ls_ImportReference ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	THIS.of_AddIntermodalitemsifneeded( )
END IF

DESTROY ( lnv_Event ) 

RETURN li_Return
end function

private function integer of_loadcompanysettings ();Int	li_Return = 1
IF Not isValid ( ids_companysettings ) THEN
	ids_companysettings = CREATE DataStore
	ids_Companysettings.Dataobject = "d_complete204settings"
	ids_Companysettings.SetTransObject ( SQLCA )
END IF


IF il_Sourcecompany > 0 THEN
	IF ids_Companysettings.Retrieve( il_sourcecompany ) < 1 THEN
		li_Return = -1
		THIS.of_AddError( "The company settings could not be retrieved.")
	END IF
END IF

RETURN li_Return


end function

private function boolean of_allowupdates ();Boolean	lb_Return 

IF isValid ( ids_companysettings ) THEN
	IF ids_companysettings.RowCount ( ) > 0 THEN
		IF ids_companysettings.GetItemString ( 1 , "edi204profile_AllowUpdates" ) = "T" THEN
			lb_Return = TRUE
		END IF
	END IF
END IF
RETURN lb_Return
end function

private function boolean of_allowcancel ();Boolean	lb_Return 

IF isValid ( ids_companysettings ) THEN
	IF ids_companysettings.RowCount ( ) > 0 THEN
		IF ids_companysettings.GetItemString ( 1 , "edi204profile_Allowcancel" ) = "T" THEN
			lb_Return = TRUE
		END IF
	END IF
END IF
RETURN lb_Return
end function

private function integer of_sendemailerrors ();Int		li_Return = 1
int 		li_errorCount
int		i
String	ls_ErrorString

n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_bso_email_manager lnv_EmailManager
n_cst_emailmessage	lnv_EmailMsg
n_cst_beo_Shipment	lnv_Shipment

lnv_EmailManager = CREATE n_cst_bso_email_manager
lnv_Shipment = THIS.of_GetShipment ( )

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_ErrorCollection.geterrorcount( )

ls_ErrorString = "The following errors occurred while attempting to import a EDI204 Load Tender file:~r~n--~r~n"
IF isValid ( lnv_Shipment ) THEN
	IF NOT IsNull ( lnv_Shipment.of_getID ( ) ) THEN
		ls_ErrorString += "TMP: " + String (  lnv_Shipment.of_getID ( ) ) + "~r~n"
	END IF
END IF 
For i = 1 TO li_ErrorCount
	ls_ErrorString += string( lnva_Error[i].getErrorMessage() ) + "~r~n"
next

IF THIS.of_Addemailaddresses( lnv_EmailMsg ) > 0 THEN
	lnv_EmailMsg.of_Setsubject( "Profit Tools EDI204 Error message")
	lnv_EmailMsg.of_setbody( ls_ErrorString )
	
	IF lnv_EmailManager.of_sendmail( lnv_EmailMsg ) <> 1 THEN
		li_Return = -1
	END IF
END IF

DESTROY ( lnv_EmailManager )

RETURN li_Return
end function

public function integer of_clearerrors ();THIS.Clearofrerrors( )
RETURN 1
end function

private function integer of_presetprocess (string as_pttarget, ref any aa_value);n_Cst_String	lnv_String
String	ls_Temp
Time		lt_Temp
Date		ld_Temp
Boolean	lb_Continue


// DATE Processing
IF Pos ( Upper (as_pttarget) , "DATE"  ) > 0 THEN
	IF not isDate ( aa_value ) THEN
		ld_Temp = lnv_String.of_Makedate( String ( aa_value ) )
		//IF NOT isNull ( ld_Temp ) THEN
			aa_value = ld_Temp
		//END IF
	END IF
END IF 

// Time Processing
IF Pos ( Upper (as_pttarget) , "TIME"  ) > 0 THEN
	IF not isTime ( aa_value ) THEN
		lt_Temp = lnv_String.of_MakeTime( String ( aa_value ) )
		//IF NOT isNull ( lt_Temp ) THEN
			aa_value = lt_Temp
		//END IF
	ELSEIF Left ( String ( aa_value ) , 2 ) = "00" THEN
		aa_value = "00:" + right (  String ( aa_value ) , 2 )
		
	END IF
END IF 


//alias Processing
IF Pos ( Upper (as_pttarget) , "BYALIAS"  ) > 0 THEN
	
	Long	ll_PTCoId
	ll_PTCoId = gnv_cst_companies.of_GetCompanyByAlias ( il_sourcecompany , String ( aa_value )  )
	IF ll_PTCoId > 0 THEN
		gnv_cst_companies.of_Cache( ll_PTCoId , FALSE )
		aa_value = ll_PTCoId
	ELSE
		aa_value = -1
	END IF

END IF


//IF Upper ( as_pttarget ) = "EQREFNUMBER" THEN
//	IF IsNumber ( aa_value ) THEN
//		IF Integer ( aa_value ) = 0 THEN
//			IF isValid ( inv_shipment ) AND isValid ( inv_dispatch ) THEN
//				lb_Continue = TRUE
//			END IF
//		END IF
//	END IF
//	
//	IF lb_Continue THEN
//		String	ls_OldFiter
//		
//		
//		
//		
//	END IF
//	
//END IF


RETURN 1
end function

private function integer of_addemailaddresses (ref n_cst_emailmessage anv_msg);///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_addemailaddresses
//  
//	Access		: Private
//	
//	Arguments	: n_cst_emailmessage
//			
//
//	Return		: int, # of addressed added
//					
//						
//	Description	: this method will add the addresses specified on the company setup
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
String	lsa_Addresses[]
String	ls_Value

n_cst_String	lnv_String

IF isValid ( ids_companysettings ) THEN
	IF ids_companysettings.RowCount ( ) > 0 THEN
		ls_Value = ids_companysettings.GetItemString ( 1 , "edi204profile_emailaddress" ) 
	END IF
END IF

IF lnv_String.of_Parsetoarray( ls_Value,";" , lsa_Addresses) > 0 THEN
	anv_Msg.of_addtargets( lsa_Addresses )
END IF

RETURN UpperBound ( lsa_Addresses )



end function

private function boolean of_allowemailstobesent ();Boolean	lb_Return 

IF isValid ( ids_companysettings ) THEN
	IF ids_companysettings.RowCount ( ) > 0 THEN
		IF ids_companysettings.GetItemString ( 1 , "edi204profile_emailerrors" ) = "T" THEN
			lb_Return = TRUE
		END IF
	END IF
END IF
RETURN lb_Return
end function

private function integer of_adderrorstolog ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_adderrorstolog
//  
//	Access		: Private
//
//	Arguments	: NONE
//			
//
//	Return		: Int
//					
//						
//	Description	: takes all of the errors that have been added to the error object and puts them into the 
//						EDI log 
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
int 		li_errorCount
int		i
String	ls_ErrorString
String	ls_SourceString

Long		ll_ShipmentID

n_cst_OFRError 				lnva_Error[]
n_cst_OFRError_Collection 	lnv_ErrorCollection
n_cst_edi_transaction_204	lnv_Transaction204
n_Cst_beo_Shipment			lnv_Shipment
lnv_Transaction204 = CREATE n_cst_edi_transaction_204

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_ErrorCollection.geterrorcount( )


lnv_Shipment = THIS.of_GetShipment ( ) 
IF isValid ( lnv_Shipment ) THEN
	ll_ShipmentID = lnv_Shipment.of_GetID ( )
END IF


For i = 1 TO li_ErrorCount
	ls_ErrorString += string( lnva_Error[i].getErrorMessage() ) + ", "
next
ls_SourceString = THIS.of_createsourcestring( )
lnv_Transaction204.of_addedientry( ll_ShipmentID , ls_SourceString  , il_sourcecompany , ls_ErrorString, appeon_constant.cs_transaction_INBOUND )


DESTROY ( lnv_Transaction204 )


RETURN 1
end function

private function integer of_addintermodalitems ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_addintermodalitems
//  
//	Access		:Private
//
//	Arguments	:NONE
//			
//
//	Return		:Int
//						1 success
//						-1 failure
//						
//	Description	: For every L3 segment the freight and accessorial items are extracted. If their value is greater than 0 an item 
//						is added. 
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int	li_ItemCount
Int	li_Return = 1
Int	i
Long	ll_NewItemID
String	ls_Freight
String	ls_Acc
Dec {2}	lc_Freight  // EDI Standard for the L3 segment id [N2]
Dec {2}	lc_Acc

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_csT_beo_Item			lnv_Item
n_cst_ediSegment		lnva_ItemSegments[]

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_GetShipment ( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_GetDispatch ( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Item = Create n_Cst_beo_Item
	lnv_Item.of_SetSource ( lnv_Dispatch.of_GetItemCache ( ) )
	lnv_Item.of_SetShipment ( lnv_Shipment )
	lnv_Item.of_SetAllowFilterSet ( TRUE ) 
END IF

IF li_Return = 1 THEN
	li_ItemCount = THIS.of_GetSegments( "L3",lnva_ItemSegments)
	FOR i = 1 TO li_ItemCount	
		
		lnva_Itemsegments[ li_ItemCount ].of_getvalue( {3}, ls_Freight)
		lnva_Itemsegments[ li_ItemCount ].of_getvalue( {6}, ls_Acc)
		
		IF IsNumber ( ls_Freight ) THEN
			lc_Freight = Dec ( ls_Freight )
		END IF
		IF lc_Freight > 0 THEN
			ll_NewItemID = lnv_Shipment.of_AddItem ( "L" , lnv_Dispatch ) 
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetEventtypeflag( n_Cst_Constants.cs_itemeventtype_importedfreight )			
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not create a freight item. " )
			END IF
		END IF
		
		IF IsNumber ( ls_Acc ) THEN
			lc_Acc = Dec (ls_Acc ) 
		END IF
		IF lc_Acc > 0 THEN
			ll_NewItemID = lnv_Shipment.of_AddItem ( "A" , lnv_Dispatch ) 
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetEventtypeflag( n_Cst_Constants.cs_itemeventtype_importedacc )			
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not create an accessorial item. " )
			END IF
		END IF
			
	NEXT
END IF


DESTROY ( lnv_Item )
RETURN li_Return
end function

private function integer of_makeeventstructurechanges ();RETURN 0

/////////  NOT USING ANY MORE // 

//Int		li_Return
//Int		li_ShipmentEventCount
//Int		li_FileEventCount
//Int		i
//String 	lsa_eventTypes[]
//String	ls_value
//String	ls_FileEventType
//String	lsa_FileEventTypes[]
//String	ls_ShipmentEventType
//Long		ll_NewEventID
//Int		li_Isp
//Int		li_ImportRef
//
//
//n_Cst_EdiSegment		lnva_Segment[]
//n_cst_beo_Event		lnva_TempList[]
//n_cst_beo_Event		lnva_EventList[]
//n_cst_beo_Event		lnv_Event
//n_cst_bso_Dispatch	lnv_Dispatch
//n_Cst_beo_Shipment 	lnv_Shipment
//
//
//lnv_Shipment = THIS.of_GetShipment( )
//lnv_Dispatch = THIS.of_GetDispatch( )
//
//lnv_Event = CREATE n_cst_beo_Event
//lnv_Event.of_setSource ( lnv_Dispatch.of_GetEventCache ( ) ) 
//lnv_Event.of_setAllowFilterset(TRUE)
//
//li_ShipmentEventCount = lnv_Shipment.of_GetEventList ( lnva_TempList )
//FOR i = 1 TO li_ShipmentEventCount	
//	IF  lnva_TempList[ i ].of_GetImportreference( ) > 0 THEN
//		lnva_EventList[ UpperBound( lnva_EventList) + 1 ] = lnva_TempList[ i ] 
//	ELSE
//		DESTROY ( lnva_TempList[ i ]  )
//	END IF
//NEXT
//
//// right now, lnva_Eventlist has only the events that have importreference numbers.
//li_ShipmentEventCount = UpperBound ( lnva_EventList )
//
//
//THIS.of_GetSegments ( "S5" , lnva_Segment )
//li_FileEventCount = THIS.of_GetEventstructure( lsa_FileEventTypes )
//
//
//FOR i = 1 TO li_FileEventCount 
//	ls_FileEventType = lsa_FileEventTypes[i]
//	lnva_Segment[i].of_GetValue ( {1} , ls_value )
//	li_ImportRef = Integer ( ls_Value )
//	IF i <= li_shipmentEventCount THEN
//		
//		ls_ShipmentEventType = lnva_EventList[i].of_GetType( )
//		
//		CHOOSE CASE ls_ShipmentEventType
//			
//			// if we are being instructed to turn a drop into a pick up we are going to add a hook after the existing
//			// drop.
//			CASE gc_dispatch.cs_eventtype_drop
//				IF ls_FileEventType = gc_dispatch.cs_eventtype_pickup THEN
//					li_Isp = lnva_EventList[i].of_getshipseq( ) + 1
//					lnv_Shipment.of_AddEvent( gc_dispatch.cs_eventtype_Hook , li_Isp , lnv_Dispatch , ll_NewEventID )
//					lnv_Event.of_SetSourceId ( ll_NewEventID )					
//					lnv_Event.of_SetImportreference( li_ImportRef )
//				END IF
//				
//		END CHOOSE
//	ELSE
//		// add the event
//		li_Isp ++
//		lnv_Shipment.of_AddEvent( ls_FileEventType , li_Isp , lnv_Dispatch , ll_NewEventID )
//		lnv_Event.of_SetSourceId ( ll_NewEventID )					
//		lnv_Event.of_SetImportreference( li_ImportRef )
//	END IF
//NEXT
//
//
//DESTROY ( lnv_Event )
//
//RETURN li_Return
//
//
//
end function

private function string of_createsourcestring ();String	ls_Return
int		i
For i = 1 TO ii_segmentcount
	ls_Return += inva_segments[i].of_GetRecordString ( ) +"~r~n"
NEXT

RETURN ls_Return
end function

private function integer of_addimportedshipmententry ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_addimportedshipmententry
//  
//	Access		: Private
//
//	Arguments	: NONE
//			
//
//	Return		: Int
//					
//						
//	Description	: Loops through the segments and identifies transaction groups from within a file that contains multiple groups.
//						calls the overloaded version with segments that make up a single group.
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////


Int		li_Return
Long		ll_SegmentCount
Long		i
String	ls_SendingCompany
String	ls_FileString
String	ls_SegID
Long		ll_GroupControlNumber	// one per file
Long		ll_TransactionControlNumber // one for every shipment in the file
Any		la_Temp
String	ls_Temp


n_cst_EDISegment	lnva_Segment[]
n_cst_EDISegment	lnva_EMPTYSegments[]

n_cst_AnyArraySrv	lnv_ArraySrv

ll_SegmentCount = UpperBound ( inva_segments )

FOR i = 1 TO ll_SegmentCount
	CHOOSE CASE inva_segments[i].of_GetSegmentID ( )
			
		CASE "IEA" 
			
			// add the segment and process what we have
			lnva_Segment[ UpperBound ( lnva_Segment ) + 1 ]  = inva_Segments[i]
			
			IF THIS.of_AddImportedShipmentEntry ( lnva_Segment ) = -1 THEN
				li_Return = -1 // could not save to db
			END IF
			//lnv_ArraySrv.of_Destroy ( lnva_Segment ) 
			lnva_Segment = lnva_EMPTYSegments


		CASE 	ELSE  // just add the segment 
			lnva_Segment[ UpperBound ( lnva_Segment ) + 1 ]  = inva_Segments[i]
			
	END CHOOSE
	
NEXT

RETURN li_Return 

end function

public function integer of_processpendingshipments ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_processpendingshipments
//  
//	Access		: Public
//
//	Arguments	: NONE
//			
//
//	Return		: int 
//						1 success
//						-1 failure
//					
//						
//	Description	:  get all of the shipments from the imported shipment table that do not have a shipment id and process them
//						of_import204FilesIntoPending will most likely need to be call prior to calling this.
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
// get all of the shipments from the imported shipment table that do not have a shipment id
Long			ll_Count
Long			i,j
Long			ll_RecordCount
Long			ll_ShipmentID
Long			ll_CompanyID
Long			ll_groupControlNumber
Long			ll_transactionNumber
Int			li_Return = 1
String		ls_Scac
String		ls_Text
String		ls_fileContents
String		lsa_File[]
String		lsa_ParsedRecord[]
String		lsa_Empty[]
Boolean		lb_CheckErrors

DataStore				lds_Shipments
n_cst_String			lnv_String
n_Cst_beo_Shipment	lnv_Shipment
n_cst_AnyArraySrv		lnv_Array
n_cst_EdiSegment		lnva_Segments_EMPTY[]
n_cst_errorlog_manager	lnv_errorLog

lds_Shipments = THIS.of_GetPendingdatastore( )
IF Not IsValid ( lds_Shipments ) THEN
	RETURN -1
END IF
ll_Count = lds_Shipments.Retrieve ( )
Commit;


//Parse out the source string with the goal of creating populated edi_segments
FOR i = 1 TO ll_Count
	
	li_Return = 1
	
	// destroy the disp so that we don't hang on to the shipment
	If IsValid ( inv_dispatch ) THEN
		Destroy ( inv_Dispatch ) 
	END IF
	
	IF isValid ( inv_shipment ) THEN
		Destroy ( inv_Shipment )
	END IF
	
	
	
	lnv_Array.of_destroy( inva_segments )
	inva_segments = lnva_Segments_EMPTY
	
	GarbageCollect ( )
	
	
	ls_Text = lds_Shipments.GetItemString ( i , "FileContents" )
	lsa_file = lsa_Empty
	lnv_String.of_parseToArray( ls_Text , "~r~n" , lsa_File )
	ll_RecordCount = UpperBound ( lsa_File )
	FOR j = 1 TO ll_RecordCount
		IF Len ( lsa_File[j] ) > 0 THEN
			lsa_ParsedRecord = lsa_Empty
			lnv_String.of_ParseToArray ( lsa_File[j] , n_cst_Edi_Transaction_204.cs_FieldDelimiter , lsa_ParsedRecord ) 
			inva_segments[ UpperBound ( inva_Segments ) + 1 ]= CREATE n_cst_EdiSegment 
			IF inva_segments[ UpperBound ( inva_segments ) ].of_SetSegment ( lsa_ParsedRecord ) <> 1 THEN				
				THIS.of_Adderror( inva_segments[UpperBound ( inva_segments )].of_GetErrorString() )				
				li_Return = -1
				lb_CheckErrors = TRUE
			END IF
		END IF
	NEXT
	
	IF li_Return = 1 THEN
		
	  ls_Scac = lds_Shipments.GetItemstring( i, "sendersCode" )
	  
	  SELECT "ediprofile"."companyid"  
		 INTO :ll_CompanyID  
		 FROM "ediprofile"  
		WHERE "ediprofile"."SCAC" = :ls_Scac   ;
	
		COMMIT;
	
	END IF
	
	IF li_Return = 1 THEN
		il_sourcecompany = ll_CompanyID
	END IF
	
// Pass the segments to the of_process204Request
		
	IF THIS.of_Process204request( inva_segments ) = 1 THEN
		lnv_Shipment = THIS.of_GetShipment( )
		
		IF isValid ( lnv_Shipment ) THEN
			ll_ShipmentID = lnv_Shipment.of_getID ( )
		END IF
		
		lds_Shipments.SetItem ( i , "shipmentID" , ll_ShipmentID )	
		lds_Shipments.SetItem ( i , "processed" , 1 )
	ELSE
		lnv_Shipment = THIS.of_GetShipment( )			
		IF isValid ( lnv_Shipment ) THEN
			ll_ShipmentID = lnv_Shipment.of_getID ( )
		END IF
		lds_Shipments.SetItem ( i , "processed" , -1 )	
		//DEK 5-14-07///////////////
		ls_fileContents = lds_Shipments.getITemString( i, "fileContents" )
		//lds_Shipments.SetItem ( i , "shipmentID" , ll_ShipmentID )	//DEK 5-14-07
		ll_groupControlNumber = lds_shipments.getITemNumber( i, "groupcontrolnumber" )
		ll_transactionNumber = lds_shipments.getITemNumber( i, "transactioncontrolnumber" )
		lnv_errorLog = this.of_getErrorlogmanager( )
		//the context string is important for the remedy object.  It contains the key value for the imported shipments table delimited by '|'.
		lnv_errorLog.of_logerror( "EDI", "Imported Shipment '"+ls_scac+ "|" +string(ll_groupControlNumber)+"|"+string(ll_transactionNumber) +"'", "There was an error importing the contents for shipment "+ string(ll_ShipmentID)+".~r~nTo repair or open the shipment, click trouble shoot.~r~nProcessed status = -1.~r~n"+ ls_fileCOntents  , n_cst_constants.ci_ErrorLog_Urgency_Severe, { ll_shipmentId }, "n_cst_errorremedy_edi_importedshipments")
		//////////////////////////
		lb_CheckErrors = TRUE
	END IF
	
	IF lds_Shipments.Update ( ) = 1 THEN
		COMMIT;
	ELSE
		RollBack;
	END IF
	
		
NEXT

DESTROY ( lds_Shipments )

IF lb_CheckErrors THEN
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_import204filesintopending (string as_filename);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_import204filesintopending
//  
//	Access		:Public
//
//	Arguments	:string - as_filename, the file to process
//			
//
//	Return		: int 
//						1 = success 
//						-1 failure
//					
//						
//	Description	: this method will import any files into the importedShipment Table. of_processPendingShipments
//						needs to be called after this if the shipments are to be created.
//						the 997s are also processed at this point
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////


String	ls_FilePath
Long     i
Long		ll_FileHandle = -1
Int		li_Return = 1
String	lsa_Records[]
String	lsa_Streams[]
String	ls_Version
String	ls_DirectLinemode
//Boolean	lb_StreamMode
String	ls_FileType
Int		li_FileTypeRtn
Long	ll_StreamCount
String	lsa_Temp[]
String	lsa_EMPTY[]
Long		j
String	ls_mySefFile
Int		li_rtn
n_cst_setting_edi204sefPath lnv_setting

/*
	DEK modified to get the file format for inbound 204  3-8-07
*/ 

OleObject	lnv_xmlDocument
OleObject	lnv_ediDocument
OleObject	lnv_schemas
OleObject   lnv_schema

n_Cst_AnyArraySrv	lnv_Array
n_cst_String	lnv_String
n_cst_edisegment		lnva_segment[]

ls_FilePath = as_FileName

li_FileTypeRtn = THIS.of_GetFileformat( ls_FilePath , ls_FileType, ls_Version, appeon_constant.cs_transaction_INBOUND )

//IF len ( ls_FileType ) > 0 THEN
//	IF Upper ( ls_FileType ) = "STREAM!" THEN
//		lb_StreamMode = TRUE
//	ELSEIF Upper ( ls_FileType ) = "LINE!" THEN
//		lb_StreamMode = FALSE
//	END IF
//END IF

ls_fileType = Upper(ls_fileType)

IF /*lb_StreamMode*/ ls_fileType = "STREAM!" THEN
	IF Len ( ls_FilePath ) > 0 THEN
		ll_FileHandle = FileOpen ( ls_FilePath , StreamMode! )
	END IF
	
	IF ll_FileHandle >= 0 THEN
		DO
			i++
		LOOP WHILE ( FileRead ( ll_FileHandle, lsa_Streams[i] ) >= 0 )
	END IF
	
//	<<*>> I changed the approach to concatinating the long streams 8/17/05
	
	String	ls_Temp
	// put the steams togehter
	lnv_String.of_arraytostring( lsa_Streams, '', ls_Temp)	
	lnv_String.of_parsetoarray(ls_Temp , '~~', lsa_Records)

ELSEIF ls_fileType = "LINE!"  THEN// read the file in line mode

	IF Len ( ls_FilePath ) > 0 THEN
		ll_FileHandle = FileOpen ( ls_FilePath )
	END IF
	
	IF ll_FileHandle >= 0 THEN
		DO
			i++
		LOOP WHILE ( FileRead ( ll_FileHandle, lsa_Records[i] ) >= 0 )
	END IF

//Modified By Dan 1-25-2006 to handle the new XML type
ELSEIF ls_fileType = "XML!" THEN			
	ll_fileHandle = -1  			//we do not open the file so we don't need to close it later
	IF len( ls_filePath ) > 0 THEN
			lnv_ediDocument = CREATE oleObject
			IF lnv_ediDocument.ConnectToNewObject ( "Fredi.ediDocument" ) = 0 THEN
				li_rtn = 1 
				lnv_setting = create n_cst_setting_edi204sefPath
				ls_mySefFile = lnv_setting.of_getvalue( )
				
				
				IF li_Rtn = 1 THEN
					lnv_schemas = lnv_ediDocument.getschemas( )
					lnv_schemas.EnableStandardReference = False
					
					IF FileExists( ls_mySefFile ) THEN
						lnv_schema = lnv_ediDocument.LoadSchema(ls_mySefFile, 0) 
					ELSE
						li_rtn = -1
					END IF
				END IF	
				
				IF li_rtn = 1 THEN
					lnv_xmlDocument = lnv_ediDocument.GetXmlDocument( )		//instantiates xmldocument
					lnv_xmlDocument.loadEdi( ls_FilePath )							//loads edidocument with xml file
					lsa_Streams[1] = lnv_ediDocument.getEdiString( ) 			//gets edi string
					lnv_String.of_parsetoarray( lsa_Streams[1], '~~', lsa_Records)
				END IF
			END IF
	END IF
END IF
//MessageBox( "of_import204filesintopending", il_sourcecompany  )
//-------------------------------------------------------
IF ll_FileHandle >= 0 THEN
	FileClose (  ll_FileHandle )
END IF

this.of_resetsegments( )

if this.of_loadSegments( lsa_Records ) = -1 then
	li_return = -1
end if

IF li_Return = 1 THEN
	THIS.of_AddImportedShipmentEntry ( ) 
	this.of_send997(inva_Segments)	
END IF

IF isValid(  lnv_ediDocument ) THEN
	DESTROY lnv_ediDocument
END IF

If isvalid( lnv_setting ) THEN
	Destroy lnv_setting
END IF

RETURN li_Return
end function

public function integer of_loadsegments (string asa_record[]);integer	li_return=1, &
			li_Recordcount, &
			i

string	lsa_ParsedRecord[], &
			lsa_Empty[]
			
n_cst_string	lnv_String			


li_RecordCount = UpperBound ( asa_Record[] )
IF li_RecordCount > 0 THEN
	
	FOR i = 1 TO li_RecordCount
		
		lsa_ParsedRecord = lsa_Empty
		IF Len ( asa_Record[i] ) > 0 THEN
			lnv_String.of_ParseToArray ( asa_Record[i] , n_cst_Edi_Transaction_204.cs_FieldDelimiter , lsa_ParsedRecord ) 
			
			inva_segments[ UpperBound ( inva_segments ) + 1 ] = CREATE n_cst_edisegment
			IF inva_segments[ UpperBound ( inva_segments ) ].of_SetSegment ( lsa_ParsedRecord ) <> 1 THEN
				THIS.of_AddError ( inva_segments[ UpperBound ( inva_segments ) ].of_GetErrorString ( ) )
				li_Return = -1
			END IF
		END IF
			
	NEXT
	
END IF


return li_return

end function

protected function integer of_getvalue (string as_segment, string as_element, string as_condition, n_cst_edisegment anva_segmentstosearch[], ref any aa_value);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_getvalue
//  
//	Access		:Protected
//
//	Arguments	: string - as_segment, this is the target segment
//					  string - as_element, this is the element in the target segment
//					  string	- as_condition, this is the condition that the segment must satisfy in order to get the value
//					  n_cst_edisegment - anva_segmentstosearch, these are the segements to search in
//					  Any - aa_value, the resulting value
//			
//
//	Return		: int 
//							1 success
//							-1 failure
//						
//	Description	: gets the value in the element position of the specified segment if the condition is met.
//						If the 'use all' indicator is not present (*) then the fist value where the condition is met will be returned
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

Int		li_Return = 0
Long		i
Long		ll_candidatesCount
Long		lla_Elements[]
Long		ll_FindRow
String	ls_Value
String	ls_Return
String	ls_Segment
String	ls_Literal
String	ls_Element
Boolean	lb_UseAll
Boolean	lb_Literal
Boolean	lb_UseElement
 
n_cst_String		lnv_String
n_cst_EDISegment	lnva_Segmentcandidates[]

ls_Element = as_Element
lnv_String.of_Parsetoarray( ls_Element ,",", lla_Elements )
ls_Segment = as_Segment

IF Right ( ls_Segment , 1 ) = "*" THEN  // the * means to include all for that segment that meet the conditions specified
	lb_UseAll = TRUE
	ls_Segment = LEFT ( ls_Segment , LEN ( ls_Segment ) - 1 )
END IF

IF Left ( ls_Element , 1 ) = "!" THEN  // the ! means to use the value in Element as a literal
	lb_Literal = TRUE
	ls_Literal = Replace ( ls_Element, 1, 1,'')
END IF

ll_candidatesCount = THIS.of_GetSegments( ls_Segment , anva_SegmentsToSearch[] ,lnva_Segmentcandidates )

IF ll_candidatesCount > 0 THEN
	
	
	lb_UseElement = ids_valuemapping.Describe( "element.id") <> "!"
	
	
	FOR i = 1 TO ll_candidatesCount
		IF lnva_Segmentcandidates[i].of_MeetsCondition ( as_condition ) = 1 THEN
			
			li_Return = 1
			IF lb_Literal THEN
				ls_Return = ls_Literal
			ELSE
			
				IF lnva_Segmentcandidates[i].of_Getvalue( lla_Elements , ls_Value ) = 1 THEN
					//  4/24/2006 , Sam , Need to narrow down the replacement of PTValues to a specific Element within the Segment.
					IF NOT lb_UseElement THEN
						ll_FindRow = ids_valuemapping.Find( "segment = '" + ls_Segment + "' and edivalue = '" + ls_Value + "'" , 1 , ids_valuemapping.RowCount ( ) + 1 )
					ELSE
						ll_FindRow = ids_valuemapping.Find( "segment = '" + ls_Segment + "' and element = '" + ls_Element + "' and edivalue = '" + ls_Value + "'" , 1 , ids_valuemapping.RowCount ( ) + 1 )
					END IF
					
					IF ll_FindRow > 0 THEN
						ls_Value = ids_Valuemapping.GetItemString ( ll_FindRow , "PTValue" )
					END IF
					IF len ( ls_Return ) > 0 THEN
						ls_Return += "~r~n"
					END IF
					ls_Return +=  ls_Value
					
					IF NOT lb_UseAll THEN			
						EXIT
					END IF
					
				ELSE
					li_Return = -1
					THIS.of_AddError ( "Could not get the value from the candidate segment." )
				END IF
				
			END IF
			
		END IF
	NEXT
	
ELSE
	
	IF UpperBound ( inva_segments ) = UpperBound ( anva_segmentstosearch[] ) THEN
		li_Return = -1
		THIS.of_AddError ( "There were no candidates for the " + ls_Segment + " segment." )	
	END IF
END IF

IF li_Return = 1 THEN	
	aa_Value = ls_Return
END IF

RETURN li_Return
end function

public subroutine of_resetsegments ();n_cst_edisegment	lnva_blankSegment[]

n_cst_AnyArraySrv		lnv_Array

lnv_Array.of_destroy( inva_segments )

inva_segments = lnva_BlankSegment
end subroutine

public function integer of_getelement (string as_segment, integer ai_element, ref string asa_value[]);long		ll_ndx, &
			ll_count
			
integer	li_return=0, &
			lia_element[]

string	ls_value

n_cst_edisegment				lnva_segment[]

this.of_GetSegments(as_segment, lnva_segment)

ll_count = upperbound(lnva_segment)

for ll_ndx = 1 to ll_count
	
	if isvalid(lnva_segment[ll_ndx]) then
		
		lia_element[1] = ai_element
		ls_value = ''
		lnva_segment[ll_ndx].of_getvalue(lia_element,ls_value)
		asa_value[ll_ndx] = ls_value
	
	end if
	
next

if upperbound(asa_value) > 0 then
	li_return = 1
end if

return li_return

end function

private function integer of_addimportedshipmententry (n_cst_edisegment anva_segments[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_addimportedshipmententry
//  
//	Access		: Private
//
//	Arguments	: n_cst_edisegment []
//							segments that make up a transaction group
//
//	Return		: Int
//					
//						
//	Description	: extracts the group control number, Senders SCAC, and transaction control number from the segments.
//					  For each shipment an entry will be added to the imported shipment table. 
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//Loop through all of the segments and add an entry for each shipment


Int		li_Return = 1
Long		ll_SegmentCount
Long		i
String	ls_SendingCompany
String	ls_FileString
String	ls_SegID
Long		ll_GroupControlNumber	// one per file
Long		ll_TransactionControlNumber // one for every shipment in the file
Any		la_Temp
String	ls_Temp
String 	ls_Value
String	ls_Date
String	ls_Time
Date		ld_Date
Time		lt_Time


n_cst_EDISegment	lnva_Segment[]

IF THIS.of_GetSegments ( "GS" , anva_segments[] ,lnva_Segment ) = 1 THEN	
	IF lnva_Segment[1].of_Getvalue( {6}, ls_Temp) = 1 THEN
		ll_GroupControlNumber = Long ( ls_Temp )
	END IF	
	IF lnva_Segment[1].of_Getvalue( {2}, ls_Temp) = 1 THEN
		ls_SendingCompany = String ( ls_Temp )
	END IF		
END IF

ll_SegmentCount = UpperBound ( anva_segments )
FOR i = 1 TO ll_SegmentCount
	
	
	ls_SegID = anva_segments[i].of_GetSegmentID ( )
	IF ls_SegID = "ST" THEN  // start building the string
	
		SetNull ( ld_Date )
		SetNull ( lt_Time )
		ls_Date = ""
		ls_Time = ""
		
		ls_FileString = ""  // clear out the string
		IF anva_segments[i].of_Getvalue(  {2} , ls_Temp ) = 1 THEN
			ll_TransactionControlNumber = Long ( ls_Temp )
		END IF
		
		ls_FileString += anva_segments [ i ].of_GetRecordString ( ) + "~r~n"
		
	ELSEIF ls_SegID = "SE" THEN // we are at the end of this shipment record so add the entry 
										// to the ds
		
		ls_FileString += anva_segments[ i ].of_GetRecordString ( ) + "~r~n"
		
		
		 INSERT INTO "importedshipments"  
         ( "senderscode",   
           "groupcontrolnumber",   
           "transactioncontrolnumber",              
           "filecontents",
			  "processed",
			  "respondbydate",
			  "respondbytime")  
 		 VALUES ( :ls_SendingCompany,   
           :ll_GroupControlNumber,   
           :ll_TransactionControlNumber,        
           :ls_FileString ,
			  0,
			  :ld_Date,
			  :lt_Time)  ;

		IF SQLCA.sqlcode <> 0 THEN
			RollBack;
			li_Return = -1  // most likely that the shipment already exists. (could not move the import file and is being processes again)
		ELSE
			Commit;
		END IF
		
		
	ELSE
		

		//  SAT 01/15/2007  Want to check the G62 segments for a respond by date and time G62*64*date*1*time
		IF ls_SegID = "G62" THEN
			IF anva_segments[i].of_Getvalue(  {1} , ls_Temp ) = 1 THEN
				IF ls_Temp = "64" THEN
					IF anva_segments[i].of_Getvalue ( {2} , ls_Value ) = 1 THEN
						IF len (ls_Value) = 8 THEN
							ls_Date = Left (ls_Value, 4) + '-' + Mid(ls_Value, 5, 2) + '-' + Right (ls_Value, 2)
						ELSEIF len (ls_Value) = 6 THEN
							ls_Date = Left (ls_Value, 2) + '-' + Mid(ls_Value, 3, 2) + '-' + Right (ls_Value, 2)
						END IF
						IF isDate ( ls_Date) THEN
							ld_Date = Date ( ls_Date)
						END IF
					END IF
					IF anva_segments[i].of_Getvalue ( {4} , ls_Value ) = 1 THEN
						IF len (ls_Value) = 4 THEN
							ls_Time = left (ls_Value, 2) + ':' + right (ls_value, 2)
						END IF	
						IF isTime (ls_Time) THEN
							lt_Time = Time (ls_Time)
						END IF
					END IF
				END IF
			END IF
		END IF
		//  END SAT 01/15/2007
		
		ls_FileString += anva_segments [ i ].of_GetRecordString ( ) + "~r~n"
	END IF
	
NEXT

RETURN li_Return
end function

protected function integer of_addequipment ();Long	ll_EquipmentCount
Long	i
Int	li_Return = 1
String	ls_temp
String	ls_Prefix
String	ls_Number
Long		ll_Number
Boolean	lb_CreateTemp
Int		li_tempCount
Long		ll_ShipmentID
String	ls_CheckType
String	lsa_Dupes[]

n_cst_equipmentmanager	lnv_EqMan
n_cst_beo_Equipment2	lnv_Equipment
n_Cst_edisegment		lnva_EquipmentSegments[]

IF isValid ( inv_shipment ) THEN
	ll_ShipmentID = inv_shipment.of_GetID ( ) 
END IF

ll_EquipmentCount = THIS.of_GetEquipmentsegments( lnva_EquipmentSegments )
//ll_EquipmentCount = THIS.of_Getsegments( "N7" , lnva_EquipmentSegments )
FOR i = 1 TO ll_EquipmentCount
	
	IF lnva_EquipmentSegments[i].of_getvalue( {1}, ls_temp) = 1 THEN
		ls_Prefix = Upper ( ls_temp )
	END IF
	
	IF lnva_EquipmentSegments[i].of_getvalue( {2}, ls_temp) = 1 THEN
		ls_Number = ls_temp
	END IF
		
	// now we are going to be creating a temp piece of equipment
	// if the number they are sending in already exists.
		
	CHOOSE CASE lnv_EqMan.of_Existsequipment(  ls_Prefix + ls_Number ,"", 'K', lsa_Dupes ) 
		CASE 0
			//DNE
	   CASE IS > 0, -2 //One or more exists
			lb_CreateTemp = TRUE
		CASE ELSE
			//Error
	END CHOOSE		
	
	IF Len ( ls_Prefix ) = 0 THEN
		IF Len ( ls_Number ) > 0 THEN
			IF isNumber ( ls_Number ) THEN
				ll_Number = Long ( ls_Number )
				IF ll_Number = 0 THEN
					lb_CreateTemp = TRUE
				END IF
			END IF
		ELSE
			lb_CreateTemp = TRUE
		END IF
	END IF
	
	lnv_equipment = THIS.of_getnewequipment( )
	
	IF lb_CreateTemp THEN
		li_tempCount ++
		ls_Temp = "UNK" + String ( li_tempCount ) + "-" + String ( ll_ShipmentID )
	END IF
	
	IF isValid ( lnv_Equipment ) AND lb_CreateTemp THEN
		lnv_Equipment.of_SetNumber( ls_Temp )
	END IF
		
	DESTROY ( lnv_Equipment )
NEXT


RETURN li_Return
end function

protected function long of_getsegments (string as_segment, ref n_cst_edisegment anva_requestedsegments[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_getsegments
//  
//	Access		: Private
//
//	Arguments	: string - as_segment, this is the edi segment you want
//					  n_cst_edi_segment [] - anva_requestedsegments - these are the segments you asked for.
//
//	Return		: int	# of segments
//					
//						
//	Description	: gets a list of EDI segments. All segments will be searched when using this version
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
RETURN THIS.of_Getsegments( as_segment , inva_segments , anva_RequestedSegments[] )
end function

protected function long of_getsegments (string as_segment, n_cst_edisegment anva_segmentlisttosearch[], ref n_cst_edisegment anva_requestedsegments[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_getsegments
//  
//	Access		: Private
//
//	Arguments	: string - as_segment, this is the edi segment you want
//					  n_cst_edi_segment [] - anv_segmentlisttosearch - this is list to look in 
//					  n_cst_edi_segment [] - anva_requestedsegments - these are the segments you asked for.
//
//	Return		: int	# of segments
//					
//						
//	Description	: gets a list of EDI segments
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int	li_Return = 1
Long	ll_SegmentCount
Long	i
Long	ll_CanidateCount
String	ls_Value
n_cst_EDISegment	lnva_SegmentCanidates[]

ll_SegmentCount = UpperBound ( anva_SegmentListToSearch[] )

FOR i = 1 TO ll_SegmentCount
	IF anva_SegmentListToSearch[i].of_getsegmentid( ) = as_segment THEN
		ll_CanidateCount ++
		lnva_SegmentCanidates[ ll_CanidateCount ] = anva_SegmentListToSearch[i]
	END IF	
NEXT

anva_RequestedSegments[] = lnva_SegmentCanidates

RETURN ll_CanidateCount

end function

protected function n_cst_beo_shipment of_getshipment ();IF NOT isValid ( inv_Shipment ) THEN
	inv_Shipment = CREATE n_cst_beo_Shipment 
END IF

RETURN inv_Shipment
end function

protected function n_cst_bso_dispatch of_getdispatch ();IF NOT isValid ( inv_dispatch ) THEN
	inv_dispatch = CREATE n_Cst_bso_Dispatch 
END IF

RETURN inv_dispatch
	
end function

protected function n_cst_beo_equipment2 of_getnewequipment ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_getnewequipment
//  
//	Access		: Private
//
//	Arguments	:NONE
//			
//
//	Return		:n_cst_beo_Equipment2	- the newly created equipment
//					
//						
//	Description	: creates a new piece of equipment and initialize it
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Long						ll_NewRow
Long						ll_TempID

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Equipment2	lnv_Equipment
n_Cst_EquipmentManager	lnv_EquipmentManager

n_ds	lds_EquipmentCache

lnv_Dispatch = THIS.of_GetDispatch( )
lnv_Shipment = THIS.of_getshipment( )

lnv_Equipment = CREATE n_cst_beo_Equipment2
lnv_Equipment.of_SetAllowFilterset( TRUE )

lds_EquipmentCache = lnv_Dispatch.of_getEquipmentcache( )

ll_NewRow = lds_EquipmentCache.InsertRow ( 0 )
ll_TempID = lnv_Dispatch.of_GetTempEqID ( )
lds_EquipmentCache.SetItem ( ll_NewRow ,"eq_id" , ll_TempID ) // dirty... I know

lnv_Equipment.of_SetSource( lds_EquipmentCache )
lnv_Equipment.of_SetSourceID  ( ll_TempID )
lnv_Equipment.of_SetId( ll_TempID )
lnv_Equipment.of_SetOEID ( ll_TempID )
lnv_Equipment.of_Setstatus( lnv_EQuipmentManager.cs_status_active )
lnv_Equipment.of_Setleased( 'T' )
lnv_Equipment.of_Setwidth( 96.0 )
lnv_Equipment.of_SetLength( 40.0 )
lnv_Equipment.of_SetShipment ( lnv_Shipment.of_GetID ( ) )	

RETURN lnv_Equipment
end function

protected function integer of_geteventstructure (ref string asa_eventtypes[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_geteventstructure
//  
//	Access		:Private
//
//	Arguments	:string[]
//						types of events making up the shipment
//			
//
//	Return		:int # of events
//					
//						
//	Description	:translates the types of stops in the file to event types
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

String	lsa_Events[]
Int		li_EventCount
Long		ll_RowCount
Long		i
String	ls_CurrentEvent
String	ls_Temp
Int		li_SegmentCount
	
n_cst_edisegment	lnva_Segments[]
	

//IF THIS.of_Ismoveintermodal( ) THEN
//
//	ll_RowCount = ids_Eventmapping.RowCount ( )
//	FOR i = 1 TO ll_RowCount 
//		ls_Temp =  ids_eventmapping.GetItemString ( i , "eventtype" ) 
//		IF ls_Temp <> ls_CurrentEvent THEN
//			ls_CurrentEvent = ls_Temp
//			li_EventCount ++
//			lsa_Events[ li_EventCount ] = LEFT ( ls_CurrentEvent , 1 )
//		END IF
//	NEXT
//
//ELSE  // not intermodal
	
	li_SegmentCount = THIS.of_Getsegments( "S5", lnva_Segments )
	
	FOR i = 1 TO li_SegmentCount
		
		lnva_Segments[i].of_getvalue( {2}, ls_Temp )
		
		CHOOSE CASE ls_Temp
								
			CASE  "LD" ,"PL" ,"CL"
				ls_CurrentEvent = gc_dispatch.cs_eventtype_pickup
				
			CASE	"CU" , "PU" , "UL"
				ls_CurrentEvent =	gc_dispatch.cs_eventtype_deliver	
				
			CASE "PA" , "AL" ,"RT"
				ls_CurrentEvent = gc_dispatch.cs_eventtype_hook
				
			CASE "LE" , "SL", "SU" ,"DT" 
				
				ls_CurrentEvent = gc_dispatch.cs_eventtype_drop
				
			CASE "DR" 
				// this is not good, i know, but such is the world of EDI
				// since HUB uses DR for deramp and ramp for loading
				IF i = 1 THEN
					ls_CurrentEvent = gc_dispatch.cs_eventtype_hook
				ELSE
					ls_CurrentEvent = gc_dispatch.cs_eventtype_drop
				END IF
				
			CASE ELSE
				ls_CurrentEvent = gc_dispatch.cs_eventtype_misc
		END CHOOSE 
		
		li_EventCount ++
		lsa_Events[ li_EventCount ] = ls_CurrentEvent
		
	NEXT
	
//END IF


asa_eventtypes[] = lsa_Events

RETURN li_EventCount


/*
//AL "Advance Loading"
CL "Complete"
CN "Consolidate"
//CU "Complete Unload"
DR "Deramp and Ramp for Subsequent Loading"
//DT "Drop Trailer"
HT "Heat the Shipment"
IN "Inspection"
//LD "Load"
//LE "Spot for Load Exchange (Export)"
//PA "Pick-up Pre-loaded Equipment"
//PL "Part Load"
//PU "Part Unload"
//RT "Retrieval of Trailer"
//SL "Spot for Load"
//SU "Spot for Unload"
TL "Transload"
//UL "Unload"
WL "Weigh Loaded"
*/
	




end function

protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_applyeventstructurelogic
//  
//	Access		:Private
//
//	Arguments	:n_Cst_beo_event[]
//						this is the list of events existing in the shipment
//			
//
//	Return		:int
//						1 success
//						-1 falure
//			
//						
//	Description	: this where we try to figure out what type of move we are being sent and create the correct event structure in the 
//					  shipment. I.E. if we are only sent a Drop stop, we will then add the first implied hook and the implied Hook and drop 
//					  at the end of the shipment.
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int		li_Return = 1
Int		li_EventCount
Int		i
Long		lla_NewEventIds[]
String	ls_ExistingEvents

n_cst_Beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnva_EventList[]
n_cst_beo_Event		lnv_Event
n_cst_edisegment 		lnva_segments[]
n_cst_edisegment 		lnva_segmentsResults[]

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_GetShipment( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_GetDispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnva_EventList = anva_events[]
	li_EventCount = UpperBound ( lnva_EventList )
	
	FOR i = 1 TO li_EventCount 
		ls_ExistingEvents += UPPER ( lnva_EventList[i].of_GetType ( ) )
	NEXT
	
	IF len ( ls_ExistingEvents ) = 0 OR isNull ( ls_ExistingEvents ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	
	lnv_Event = CREATE n_Cst_beo_Event
	lnv_Event.of_SetSource ( lnv_Dispatch.of_GetEventcache( ) )
	lnv_Event.of_SetAllowFilterSet ( TRUE ) 
	
	CHOOSE CASE ls_ExistingEvents
			
		CASE "R" // DROP
			
			lnv_Shipment.of_Addevents( {'H'} , 1 , lnv_Dispatch , lla_NewEventIds )
			lnv_Shipment.of_Addevents( {'H','R'} , 3 , lnv_Dispatch , lla_NewEventIds )
			
			IF UpperBound ( lla_NewEventIds ) = 2 THEN
				
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] ) 				
				lnv_Event.of_Setimportreference( 1 )
				
				THIS.of_GetStopgroup( 2 , lnva_segments )
				THIS.of_GetSegments( "N1",lnva_segments, lnva_segmentsResults )
				
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
				
				lnv_Event.of_SetSourceID ( lla_NewEventIds[2] )
				lnv_Event.of_Setimportreference( 2 )
				THIS.of_GetSegments( "MS3", lnva_segmentsResults )				
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
				
			END IF
			
		CASE "HR" // HOOK DROP
			// Add second Hook and DROP  
			// only if this is not a one way
			IF lnv_Shipment.of_getMovecode( ) <> "O" THEN
			
			
				lnv_Shipment.of_Addevents( {'H','R'} , 3 , lnv_Dispatch , lla_NewEventIds )
				
				IF UpperBound ( lla_NewEventIds ) = 2 THEN
					
					lnv_Event.of_SetSourceID ( lla_NewEventIds[1] ) 				
					lnv_Event.of_Setimportreference( 2 )
					
					THIS.of_GetStopgroup( 2 , lnva_segments )
					THIS.of_GetSegments( "N1",lnva_segments, lnva_segmentsResults )
					
					THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
					
					lnv_Event.of_SetSourceID ( lla_NewEventIds[2] )
					THIS.of_GetSegments( "MS3", lnva_segmentsResults )				
					THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
									
				ELSE				
					li_Return = -1
				END IF
			END IF
			
		CASE "HD"  /*HOOK DELIVER*/ , "HP" // Hook Pickup
			// add drop
			lnv_Shipment.of_Addevents ( {'R'} , 3 , lnv_Dispatch , lla_NewEventIds )
			IF UpperBound ( lla_NewEventIds ) = 1 THEN
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
				THIS.of_GetSegments( "MS3", lnva_segmentsResults )				
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )				
			END IF
			
		CASE "PR" // PickUp Drop
			// Add First hook
			lnv_Shipment.of_Addevents ( {'H'} , 1 , lnv_Dispatch , lla_NewEventIds )
			IF UpperBound ( lla_NewEventIds ) = 1 THEN					
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
				THIS.of_GetSegments( "MS3", lnva_segmentsResults )				
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )					
			END IF
			
		CASE ELSE // do nothing
			
			
	END CHOOSE
	
	
	DESTROY ( lnv_Event )
	
END IF

RETURN li_Return
end function

protected function integer of_getstopgroup (integer ai_stop, ref n_cst_edisegment anva_segments[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_getstopgroup
//  
//	Access		:Private
//
//	Arguments	: int - stop group you want
//						n_cst_edisegment [] -  the EDI segements that make up the requested stop group.
//
//	Return		: int # of segments that make up the stop group.
//					
//						
//	Description	: gets all the EDI segments that make up a specific stop group. (site, reason, items...)
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int		li_Return
Int		li_StopSegments
Long		ll_SegmentCount
Long		i
Boolean	lb_TakeSegment
String	ls_CurrentSegment
string	ls_StopNumber


n_cst_edisegment	lnva_StopSegments[]


ll_SegmentCount = UpperBound ( inva_segments )
FOR i = 1 TO ll_SegmentCount
	
	ls_CurrentSegment = inva_segments[i].of_getsegmentid( )
	IF ls_CurrentSegment = "S5" THEN
		inva_segments[i].of_getValue ( {1} , ls_StopNumber  )
		IF Integer ( ls_StopNumber ) = ai_stop THEN
			lb_TakeSegment = TRUE
		ELSE
			lb_TakeSegment = FALSE
		END IF
	ELSEIF ls_CurrentSegment = "L3" OR ls_CurrentSegment = "SE" THEN
		lb_TakeSegment = FALSE
	END IF
	
	IF lb_TakeSegment THEN
		li_StopSegments ++
		lnva_StopSegments [ li_StopSegments ] =  inva_segments[i]
	END IF

NEXT

anva_segments[] = lnva_StopSegments

RETURN li_StopSegments

end function

protected function integer of_setdataonbeo (pt_n_cst_beo anv_beo, datastore ads_mapping, n_cst_edisegment anva_sourcesegments[]);// we do not rtn -1 if the set fails. this is b.c. the call to this method is called in loops and will bail
// it it 'fails' 

String	ls_Segment
String	ls_Element
String	ls_Condition
String	ls_PTTarget
String	ls_TempValue
Any		la_Value
Any		la_Clear
Any		la_TempValue
Int		li_Return = 1 
Long		i
Long		ll_MappingCount
Boolean	lb_Append


pt_n_cst_beo	lnv_Beo

lnv_Beo = anv_beo

IF li_Return = 1 THEN
	IF NOT isValid ( lnv_Beo ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF NOT isValid ( ads_mapping ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	ll_MappingCount = ads_Mapping.RowCount ( )
	FOR i = 1 TO ll_MappingCount
		lb_Append = FALSE
		la_Value = la_Clear
		ls_Segment = ads_Mapping.GetItemString ( i , "Segment" )
		ls_Element = ads_Mapping.GetItemString ( i , "Element" )
		ls_Condition = ads_Mapping.GetItemString ( i , "Condition" )
		ls_PTTarget = ads_Mapping.GetItemString ( i , "pttarget" )
		
		IF Right ( ls_PTTarget , 1 ) = "+" THEN  // the + means to Apppend to existing value
			lb_Append = TRUE
			ls_PTTarget = Replace ( ls_PTTarget, Len (ls_PTTarget), 1,'')
		END IF

		CHOOSE CASE THIS.of_GetValue ( ls_Segment , ls_Element , ls_Condition, anva_SourceSegments ,la_Value )
				
			CASE 1 
				
				IF lb_Append THEN
					lnv_Beo.event ue_getvalueany( ls_PTTarget, la_TempValue )
					ls_TempValue = String ( la_TempValue )
					IF not isNull ( ls_TempValue ) THEn
						ls_TempValue += " " + String (la_Value )
						la_Value = ls_tempValue
					END IF					
				END IF
					
				
				THIS.of_Presetprocess( ls_PTTarget , la_Value )
				
				IF lnv_Beo.event ue_setvalueany( ls_PTTarget , la_Value ) <> 1 THEN
					THIS.of_AddError ( "Could not set: " + ls_PTTarget + " to: " + String (la_Value) +"." )				
				END IF	
				
			CASE 0 
				// none of the canidates meet the specified conditions
				
			CASE ELSE
				
				THIS.of_AddError ( "Could not get a value for: " + ls_PTTarget + "." )		
				
		END CHOOSE	

	NEXT
END IF
	
RETURN li_Return	
end function

protected function integer of_setdataonbeo (pt_n_cst_beo anv_beo, datastore ads_mapping);RETURN THIS.of_Setdataonbeo( anv_beo , ads_mapping , inva_segments )


end function

protected function integer of_initializenewevents (ref n_cst_beo_event anva_eventlist[]);Int		li_Return = 1
Int		li_EventCount
Int		i
Int		li_Seq
String	ls_Filter
String	ls_type
Boolean	lb_Intermodal

lb_Intermodal =THIS.of_IsmoveIntermodal ( )
li_EventCount = UpperBound ( anva_eventlist )

FOR i = 1 TO li_EventCount
	anva_eventlist[i].of_setAllowFilterSet ( TRUE )
	anva_EventList[i].of_Setimportreference ( i )	
NEXT

THIS.of_Applyeventstructurelogic( anva_EventList )


RETURN li_Return



end function

protected function integer of_adderror (string as_error);String				ls_ErrorMessage
n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

ls_ErrorMessage = as_error 

lnv_Error.SetErrorMessage( ls_ErrorMessage )
lnv_Error.SetMessageHeader ( "EDI Data" )

RETURN 1
end function

protected function integer of_addevents (ref n_cst_beo_event anva_events[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_addevents
//  
//	Access		: Private
//
//	Arguments	: n_cst_beo_Event	[] by reference
//			
//
//	Return		: Int # of events
//					
//						
//	Description	: this does the acual addition of the events to the shipment and initializes them
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
String	lsa_Events[]
Int	li_EventCount 
Int	li_Return = 1
Long	ll_NewID
Int	i

n_cst_bso_Dispatch	lnv_Dispatch
n_Cst_beo_Shipment	lnv_Shipment



IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_Getdispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
		THIS.of_AddError ( "Could not create dispatch object." )
	END IF
END IF


IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_Getshipment( )
	IF Not IsValid ( lnv_Shipment ) THEN
		li_Return = -1
		THIS.of_AddError ( "Shipment returned was not valid.")
	END IF
END IF


IF li_Return = 1 THEN
	li_EventCount = THIS.of_GetEventStructure( lsa_Events )
	FOR i = 1 TO li_EventCount
		lnv_SHipment.of_Addevent(lsa_Events[i] , i, lnv_Dispatch ,ll_NewID )
	NEXT
END IF

IF li_Return = 1 THEN
	lnv_SHipment.of_GetEventlist( anva_events[] )
	li_Return = UpperBound ( anva_events )
	THIS.of_Initializenewevents( anva_events[] )		
END IF
	
RETURN li_Return  
end function

public function integer of_importforcompany (long al_sourcecoid);DataStore	lds_Settings
lds_Settings = Create DataStore
lds_Settings.DataObject = "d_204companysettings"


RETURN -1
end function

protected function integer of_determinesourcecompany ();int		li_Return = 1
String	ls_CoScac
Long		ll_CompanyID

n_cst_EdiSegment	lnva_Segments[]
n_cst_bso_EdiManager	lnv_EDIManger

lnv_EDIManger = CREATE n_cst_bso_EdiManager

IF il_sourcecompany <= 0 THEN

	IF THIS.of_GetSegments( "GS", lnva_Segments ) > 0 THEN
		IF lnva_Segments[1].of_GetValue ( {2} , ls_CoScac ) <> 1 THEN
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF 
	
	IF li_Return = 1 THEN
	//	IF lnv_EDIManger.of_GetCompanyID ( "204" , ls_CoScac , ll_CompanyID ) <> 1 THEN
	//		li_Return = -1
	//	END IF	
	
	  SELECT "ediprofile"."companyid"  
		 INTO :ll_CompanyID  
		 FROM "ediprofile"  
		WHERE "ediprofile"."SCAC" = :ls_CoScac   ;
	
		COMMIT;
	
	END IF
	
	IF li_Return = 1 THEN
		il_sourcecompany = ll_CompanyID
	END IF
END IF


Destroy ( lnv_EDIManger )

RETURN li_Return
end function

private function string of_getmappingfolder ();String	ls_Folder

SetNull (ls_Folder)
IF isValid ( ids_companysettings ) THEN
	IF ids_companysettings.RowCount ( ) > 0 THEN
		ls_Folder = ids_companysettings.GetItemString ( 1 , "ediprofile_folder" )
	END IF
END IF
IF IsNull ( ls_Folder  ) THEN
	ls_Folder = gnv_app.of_Getappdirectory( )
END IF

IF Right ( ls_Folder , 1 ) <> "\" THEN
	ls_Folder += "\"
END IF


RETURN ls_Folder
end function

private subroutine of_send997 (n_cst_edisegment anva_segment[]);long		i, &
			ll_segmentcount
			
string	ls_temp, &
			ls_groupcontrolnumber, &
			ls_SegID, &
			lsa_TransactionControlNumber[], &
			lsa_blank[]

n_cst_setting_edi204version	lnv_204Version
n_cst_edisegment					lnva_segment[]
										
lnv_204Version = CREATE n_cst_setting_edi204version

IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct THEN
	
	//send 997
	n_cst_edi_transaction_997	lnv_EDI
	lnv_EDI = create n_cst_edi_transaction_997
 
	IF THIS.of_GetSegments ( "GS" , anva_segment[] ,lnva_Segment ) = 1 THEN	
		IF lnva_Segment[1].of_Getvalue( {6}, ls_Temp) = 1 THEN
			//ls_GroupControlNumber = String ( Integer (ls_Temp ) , "000000000" )
			ls_GroupControlNumber = ls_Temp
		END IF	
	END IF
	
	ll_SegmentCount = UpperBound ( anva_segment )
	
	FOR i = 1 TO ll_SegmentCount
		
		ls_SegID = anva_segment[i].of_GetSegmentID ( )
		
		IF ls_SegID = "ST" THEN  // start building
			
			IF anva_segment[i].of_Getvalue(  {2} , ls_Temp ) = 1 THEN
				lsa_TransactionControlNumber[upperbound(lsa_TransactionControlNumber) + 1] = ls_Temp
			END IF			
			
		END IF
		
	NEXT
	
	if this.of_Determinesourcecompany( ) = 1 then
		lnv_EDI.of_SendTransaction(ls_GroupControlNumber, lsa_TransactionControlNumber, il_sourcecompany)
	end if
	
	destroy lnv_EDI

END IF

DESTROY lnv_204Version
end subroutine

protected function integer of_process204request (n_cst_edisegment anva_segments[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_process204request
//  
//	Access		: Public
//
//	Arguments	: n_cst_edisegment - anva_segments[], list of EDI segments that make up a file
//			
//
//	Return		: Int 
//						1 success
//						-1 failure
//					
//						
//	Description	: prosesses the segments, whether it is a new shipment, update to an existing shipment, or the canceling of a shipment.
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int	li_Return = 1 
String	ls_SetPurpose

inva_segments = anva_segments[]

ii_segmentcount = UpperBound ( inva_segments )

// we will clear all existing errors upon the start of new process request
THIS.of_Clearerrors( )

IF ii_segmentcount <= 0 THEN
	li_Return = -1
	THIS.of_AddError ( "There are no segments to process." )
END IF

IF li_Return = 1 THEN
	IF THIS.of_Determinesourcecompany( ) <> 1 THEN
		li_Return = -1
	END IF	
END IF

IF li_Return = 1 THEN
	IF THIS.of_Loadcompanysettings( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	ls_SetPurpose = THIS.of_GetSetPurpose ( )	
END IF

IF ls_SetPurpose = THIS.cs_SetPurpose_Cancel THEN
	
	IF THIS.of_AllowCancel( ) THEN
		IF THIS.of_CancelShipment( ) <> 1 THEN
			li_Return = 0
		END IF
	ELSE
		li_Return = 0
		THIS.of_AddError( "The settings do not permit shipments to be canceled.")
	END IF

ELSE
	IF THIS.of_LoadEventmapping( ) <> 1 THEN
		li_Return = -1
	END IF
	IF THIS.of_LoadEquipmentmapping( ) <> 1 THEN
		li_Return = -1
	END IF
	IF THIS.of_Loaditemmapping( )  <> 1 THEN
		li_Return = -1 
	END IF
	IF THIS.of_Loadshipmentmapping( ) <> 1 THEN
		li_Return = -1
	END IF
	IF THIS.of_Loadvaluemapping( ) <> 1 THEN
		li_Return = -1
	END IF

	IF li_Return = 1 THEN
	
		CHOOSE CASE ls_SetPurpose
			
			CASE THIS.cs_Setpurpose_Original 
				IF THIS.of_Createshipment( ) <> 1 THEN
					li_Return = 0
				END IF
				
			
			CASE THIS.cs_SetPurpose_Change 	
				IF THIS.of_AllowUpdates( ) THEN
					
					IF THIS.of_Prepareshipmentforupdate( ) <> 1 THEN
						li_Return = -1
					END IF
				
				
					IF li_Return = 1 THEN
						IF THIS.of_PreUpdateProcess ( ) <> 1 THEN
							li_Return = -1
						END IF
					END IF
					
					IF THIS.of_UpdateShipment( ) <> 1 THEN
						li_Return = 0
					END IF
				ELSE
					li_Return = 0
					THIS.of_AddError( "The settings do not permit shipments to be updated.")
				END IF
					
			CASE ELSE
				THIS.of_AddError ( "The set purpose could not be resolved. [" + ls_SetPurpose + "]" )
				li_Return = 0
				
		END CHOOSE
	END IF
END IF

If li_Return = 1 THEN 
	THIS.of_autorateifneeded( )	
END IF

IF li_return >= 0 THEN//IF li_Return = 1 THEN  DEK 5-11-07  this was commented out to address issue 2891.
	IF THIS.of_GetDispatch( ).Event pt_Save ( ) <> 1 THEN
		li_Return = -1 
	END IF
END IF

IF this.geterrorcount( ) > 0 THEN
	IF THIS.of_Allowemailstobesent( ) THEN
		THIS.of_SendEmailErrors( )
	END IF
END IF

THIS.of_AddErrorstolog( )  // this will also add the source text to the log


RETURN li_Return






end function

protected function integer of_addnonintermodalitems ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_addnonintermodalitems
//  
//	Access		:Private
//
//	Arguments	:NONE
//			
//
//	Return		:Int
//						1 success
//						-1 failure					
//						
//	Description	: 
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int	li_StopCount
Int	li_Return = 1
Int	i
Int	li_KeyCount
Int	li_KeyIndex
Any	la_Value
String	ls_StopType
Long	ll_NewItemID
Long	lla_ItemIds[]
String	lsa_KeyValue[]
String	ls_KeyValue

String	ls_KeySegment
String	ls_KeyElement


n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_csT_beo_Item			lnv_Item
n_cst_ediSegment	lnva_StopSegments[]

IF li_Return = 1 THEN
	IF THIS.of_Getitemmatchingvalues( ls_KeySegment , ls_KeyElement ) <> 1 THEN
		li_Return = -1
		THIS.of_AddError ( "Could not get the item matching values from the company profile." ) 
	END IF
END IF


IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_GetShipment ( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_GetDispatch ( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Item = Create n_Cst_beo_Item
	lnv_Item.of_SetSource ( lnv_Dispatch.of_GetItemCache ( ) )
	lnv_Item.of_SetShipment ( lnv_Shipment )
	lnv_Item.of_SetAllowFilterSet ( TRUE ) 
END IF

IF li_Return = 1 THEN
	li_StopCount = THIS.of_GetSegments( "S5",lnva_StopSegments)
	
	
	
	FOR i = 1 TO li_StopCount	
		
		THIS.of_GetStopgroup( i , lnva_StopSegments )
		IF THIS.of_Getvalue( "S5" , "2", "", lnva_StopSegments , la_Value ) = 1 THEN
			ls_StopType = STRING ( la_Value )
		ELSE
			CONTINUE
		END IF
		
		
		// for each stop see if it is a pu type 
		IF THIS.of_ISstoppickupgroup( ls_StopType ) THEN
		// if it is then create an item. 
			ll_NewItemID = lnv_Shipment.of_AddItem ( "L" , lnv_Dispatch ) 
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetEventtypeflag( n_cst_Constants.cs_ItemEventType_ImportedFreight )
				lnv_Item.of_SetPuevent( i )
				IF THIS.of_Getvalue( ls_KeySegment , ls_KeyElement , "", lnva_StopSegments , la_Value ) = 1 THEN
					ls_KeyValue = STRING ( la_Value )
				ELSE
					li_Return = -1
					THIS.of_Adderror( "Could not create all items by the key value. " )
				END IF
				li_KeyCount ++
				lla_ItemIds [ li_KeyCount] = ll_NewItemID
				lsa_KeyValue [ li_KeyCount ] = ls_KeyValue
				
				
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not create all items. " )
			END IF
			//THIS.of_Setdataonbeo( lnv_Item, /*datastore ads_mapping*/, /*n_cst_edisegment anva_sourcesegments[] */)
			
		// if it is not then see if it is a deliver
		ELSEIF  THIS.of_ISstopdelivergroup( ls_StopType ) THEN
			
		// if it is then find the corresponding item and set its deliver index.
			IF THIS.of_Getvalue( ls_KeySegment , ls_KeyElement , "", lnva_StopSegments , la_Value ) = 1 THEN
				ls_KeyValue = STRING ( la_Value )
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not populate stop index by the key value. " )
			END IF
			
			FOR li_KeyIndex = 1 TO li_KeyCount  // i intentionally do not bail once i find it.
				IF lsa_KeyValue [li_KeyIndex] = ls_KeyValue THEN
					ll_NewItemID = lla_ItemIds [li_KeyIndex]
				END IF
			NEXT
			
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetDelevent( i )
			END IF
		END IF
		

	NEXT
END IF

Int	li_ItemCount
n_Cst_EdiSegment	lnva_ItemSegments[]
Dec	lc_Acc
String	ls_Acc
// add an accessorial item if an accessorial amount exists in the L5 segment
li_ItemCount = THIS.of_GetSegments( "L3",lnva_ItemSegments)
	FOR i = 1 TO li_ItemCount	
		
		
		lnva_Itemsegments[ li_ItemCount ].of_getvalue( {6}, ls_Acc)
		
		
		
		
		IF IsNumber ( ls_Acc ) THEN
			lc_Acc = Dec (ls_Acc ) 
		END IF
		IF lc_Acc > 0  THEN
			ll_NewItemID = lnv_Shipment.of_AddItem ( "A" , lnv_Dispatch ) 
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetEventtypeflag( n_Cst_Constants.cs_itemeventtype_importedAcc )			
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not create an accessorial item. " )
			END IF
		END IF

	NEXT


DESTROY ( lnv_Item )
RETURN li_Return
end function

protected function integer of_getitemmatchingvalues (ref string as_segment, ref string as_element);String	ls_Segment
String	ls_Element
int		li_Return = -1

//ls_Segment = "S5"
//ls_Element = "03"

IF isValid ( ids_companysettings ) THEN
	IF ids_companysettings.RowCount ( ) > 0 THEN
		ls_Segment = ids_companysettings.GetItemString ( 1 , "edi204profile_ItemmatchingSegment" )
		ls_Element = ids_companysettings.GetItemString ( 1 , "edi204profile_ItemMatchingElement" )
	END IF
END IF

IF Len ( ls_Element ) > 0 AND Len ( ls_Segment ) > 0 THEN
	li_Return = 1
END IF

as_segment = ls_Segment
as_Element = ls_Element

RETURN li_Return
end function

protected function boolean of_isstopdelivergroup (string as_stoptype);


Boolean	lb_Return

CHOOSE CASE as_stoptype
		
		
	CASE "CU" , "PU" , "UL"
		lb_Return = TRUE
		
	CASE ELSE
		lb_Return = FALSE
		
END CHOOSE

RETURN lb_Return
		
		
		
end function

protected function boolean of_isstoppickupgroup (string as_stoptype);


Boolean	lb_Return

CHOOSE CASE as_stoptype
		
		
	CASE "LD" ,"PL","PA" , "AL" ,"RT" , "CL"
		lb_Return = TRUE
		
	CASE ELSE
		lb_Return = FALSE
		
END CHOOSE

RETURN lb_Return
		
		
		
end function

protected function integer of_getitemcount (n_cst_edisegment anva_stopsegments[], string as_keysegment, long al_keyelement, ref string asa_keyvalues[]);String	lsa_KeyValues[]
String	ls_Value
Int		li_KeepCount
Int		li_KeyIndex
Int		i
Int		li_SegCount
n_cst_AnyArraySrv	lnv_Array
n_cst_edisegment lnva_requestedsegments[]


// search through the Stop Segments for all of the segments that match the passed in segment key value


li_SegCount = this.of_Getsegments( as_keysegment ,anva_stopsegments[] , lnva_requestedsegments )

// lnva_Requestedsegments should now have all of the OID segment from the stop (for example)

// now loop get all of the unique Elements that match the passed-in Element


FOR i = 1 TO li_SegCount
	
	IF lnva_requestedsegments[i].of_GetValue( {al_keyelement} , ls_value) = 1 THEN
		FOR li_KeyIndex = 1 TO li_KeepCount  
			IF lsa_KeyValues [li_KeyIndex] = ls_value THEN
				EXIT // we already have it
			END IF
		NEXT
		
		IF li_KeyIndex > li_KeepCount THEN
			// we need to add it
			li_KeepCount ++
			lsa_KeyValues[ li_keepCount ] = ls_Value
		END IF
	
	END IF
NEXT

asa_keyvalues[] = lsa_KeyValues

RETURN li_KeepCount
end function

protected function integer of_setitemdatanonintermodal ();Int		li_Return = 1
Int		li_SegmentCount
Int		li_ItemCount
Int		li_ItemGroup
String	ls_StopType
Int		li_Null
Int		li_EventCount
Int		li_EventIndex
Int		li_EDIStop
Int		li_FreightInd

n_cst_edisegment	lnva_StopSegments[]

n_cst_beo_Event		lnva_EventList[]
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Item			lnva_ItemList[]
n_cst_beo_Item			lnva_EmptyItemList[]
n_cst_beo_Item			lnv_CurrentItem

SetNull ( li_Null )

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_Getdispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_Getshipment( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF	
END IF


IF li_Return = 1 THEN
	ids_itemmapping.SetFilter ( "itemtype = 'L'" )
	ids_itemmapping.Filter ()
	lnv_Shipment.of_Getitemsforeventtype( n_cst_constants.cs_ItemEventType_ImportedFreight  , lnva_ItemList)
	li_ItemCount = UpperBound ( lnva_ItemList ) 
	
	FOR li_ItemGroup = 1 TO li_ItemCount
		
		lnv_CurrentItem = lnva_ItemList[li_ItemGroup]
		
		IF li_ItemGroup = 1 THEN
			THIS.of_SetCharges( lnv_CurrentItem )
		END IF
		
				
		/* I added this block on March 3rd because the old processing was not getting
		the correct stop group in the case where users were putting in yard moves or 
		cross docks. The old processing was doing this:
			IF THIS.of_GetStopgroup( nv_CurrentItem.of_getdeliverevent( ) , lnva_StopSegments ) > 0 THEN	
		and in the event that the user put in a yard move, the freight that was pointing to ship_seq 2
		would now be pointing to 4 and there might not be a stop group 4 */
			
		// get the pickup event number
		// then get the edi stop number from that event
		// then get the stop segments for that stop number.
		li_EDIStop = 0
		li_FreightInd = lnv_CurrentItem.of_getpickupevent( )
		li_EventCount = lnv_Shipment.of_GetEventList(lnva_EventList )  // Added 7/10/06  S.A.T
		For li_EventIndex = 1 TO li_EventCount
			IF lnva_EventList[li_EventIndex].of_Getshipseq( ) = li_FreightInd THEN
				li_EdiStop = lnva_EventList[li_EventIndex].of_Getimportreference( )
				EXIT
			END IF
		NEXT
		IF li_EDIStop = 0 THEN
			li_EDIStop = li_FreightInd
		END IF
					
		IF THIS.of_GetStopgroup( li_EDIStop , lnva_StopSegments ) > 0 THEN		
			THIS.of_setdataonbeo( lnv_CurrentItem , ids_itemmapping , {lnva_StopSegments[li_ItemGroup]} )
		END IF
		
		
		// get the pickup event number
		// then get the edi stop number from that event
		// then get the stop segments for that stop number.
		li_EDIStop = 0
		li_FreightInd = lnv_CurrentItem.of_getdeliverevent( )
		For li_EventIndex = 1 TO li_EventCount
			IF lnva_EventList[li_EventIndex].of_Getshipseq( ) = li_FreightInd THEN
				li_EdiStop = lnva_EventList[li_EventIndex].of_Getimportreference( )
				EXIT
			END IF
		NEXT
		IF li_EDIStop = 0 THEN
			li_EDIStop = li_FreightInd
		END IF
		
		IF THIS.of_GetStopgroup( li_EDIStop , lnva_StopSegments ) > 0 THEN		
			THIS.of_setdataonbeo( lnv_CurrentItem , ids_itemmapping )
		END IF
		
		DESTROY ( lnv_CurrentItem )
				
//		IF THIS.of_GetStopgroup( lnv_CurrentItem.of_getpickupevent( ) , lnva_StopSegments ) > 0 THEN		
//			THIS.of_setdataonbeo( lnv_CurrentItem , ids_itemmapping , {lnva_StopSegments[li_ItemGroup]} )
//		END IF
//		
//		IF THIS.of_GetStopgroup( lnv_CurrentItem.of_getdeliverevent( ) , lnva_StopSegments ) > 0 THEN		
//			THIS.of_setdataonbeo( lnv_CurrentItem , ids_itemmapping )
//		END IF
//		
//		DESTROY ( lnva_ItemList [li_ItemGroup] )

	NEXT
	
END IF

IF li_Return = 1 THEN
	
	lnva_ItemList = lnva_EmptyItemList
	lnv_Shipment.of_Getitemsforeventtype( n_cst_constants.cs_ItemEventType_Importedacc  , lnva_ItemList)
	li_ItemCount = UpperBound ( lnva_ItemList ) 
	
	ids_itemmapping.SetFilter ( "itemtype = 'A'" )
	ids_itemmapping.Filter ()
	
	FOR li_ItemGroup = 1 TO li_ItemCount
		THIS.of_setacccharge( lnva_ItemList[li_ItemGroup] )
		
		IF li_ItemGroup <= UpperBound ( lnva_StopSegments[] ) THEN // added this on March 3rd too.
			THIS.of_setdataonbeo( lnva_ItemList[li_ItemGroup] , ids_itemmapping , {lnva_StopSegments[li_ItemGroup]} )
		END IF
		
		DESTROY ( lnva_ItemList [li_ItemGroup] )
	NEXT
	
END IF


ids_itemmapping.SetFilter ( "" )
ids_itemmapping.Filter ()

RETURN li_Return
end function

protected function string of_getmovedirection ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_getmovedirection
//  
//	Access		:Private
//
//	Arguments	:NONE
//			
//
//	Return		:String
//						one of 3 constant values representing the direction on the intermodal move.
//						
//	Description	: look for the position of the DR (deramp) event in the stop list. this, is assume, is pretty HUB specific.
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int					li_SegmentCount
Int					i
String				ls_Value
String				ls_Direction
String				ls_OneWaySites

n_cst_edisegment	lnva_Segments[]
n_cst_edisegment	lnva_StopSegments[]

li_SegmentCount = THIS.of_Getsegments( "S5", lnva_Segments )
// populate stop list
ls_OneWaySites = THIS.of_Getonewaystopsites( )

IF li_SegmentCount > 0 THEN

	THIS.of_Getstopgroup ( 1 , lnva_StopSegments )	
	IF THIS.of_Getsegments( "S5", lnva_StopSegments ,lnva_Segments) > 0 THEN
		lnva_Segments[1].of_getvalue( {2} , ls_Value )		
		IF ls_Value = "DT" THEN // Drop Trailer as first stop
			ls_Direction = cs_Export
		END IF
	END IF

// if that did not tell us anything then check for origin/destination ramps
	IF Len ( ls_Direction ) = 0 THEN
		li_SegmentCount = THIS.of_GetSegments( "S5", lnva_Segments)
	
		IF li_SegmentCount > 0 THEN
			lnva_Segments[1].of_getvalue( {2} , ls_Value )
			IF ls_Value = "DR" THEN
				ls_Direction = cs_Import
				
				lnva_Segments[li_SegmentCount].of_getvalue( {2} , ls_Value )
				IF ls_Value = "DR" THEN
					ls_Direction = cs_OneWay
				END IF
			ELSE
				lnva_Segments[li_SegmentCount].of_getvalue( {2} , ls_Value )
				IF ls_Value = "DR" THEN
					ls_Direction = cs_Export
				END IF
			END IF
		END IF
	END IF	
	
END IF

// if we still did not find it them default to oneway
IF Len ( ls_Direction ) = 0 THEN
	ls_Direction = cs_OneWay
END IF

RETURN  ls_Direction	

end function

protected function boolean of_ismoveintermodal ();Boolean	lb_Return
Int		li_SegmentCount
String	ls_Value

n_cst_edisegment	lnva_Segments[]

li_SegmentCount = THIS.of_Getsegments( "MS3", lnva_Segments )

IF li_SegmentCount > 0 THEN
	lnva_Segments[1].of_getvalue( {4}, ls_Value )
	IF Upper ( ls_Value ) = "X" THEN 
		lb_Return = TRUE
	END IF
END IF


RETURN lb_Return

end function

protected function integer of_processeventdata ();Int		li_Return = 1
Int		li_EventCount
String	ls_Filter
String	ls_type
Int		li_Seq
Int		i
Boolean	lb_Intermodal
String	ls_Zip
String	ls_Name
Any		la_Value
Long		ll_Site

n_cst_edisegment	lnva_Segments[]
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Event		lnva_Events[]
n_cst_beo_Event		lnv_CorrespondingEvent


IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_getshipment( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF
END IF


IF li_Return = 1 THEN 
	li_EventCount = lnv_SHipment.of_GetEventList ( lnva_Events )	
END IF

IF li_Return = 1 THEN
	
	lb_Intermodal = THIS.of_Ismoveintermodal( )
	
	FOR i = 1 TO li_EventCount
		
		IF lnva_Events[i].of_IsConfirmed( ) THEN
			CONTINUE 
		END IF
		lnva_Events[i].of_SetAllowFilterSet ( TRUE )
		
		THIS.of_Getstopgroup( lnva_Events[i].of_GetImportReference( ) , lnva_Segments )					


		///////  HERE I want take the event that I am going to be setting values on and
		//////   compare it to the coresponding event from the 'compare' shipment 
		//////   and remove any tags that are undesireable
		IF isValid ( inv_comparemanager ) THEN // the fact that this is valid or not is used to determine if the ini file switch is set to compare and validate 204 changes.
			lnv_CorrespondingEvent = THIS.of_GetCorespondingevent( lnva_Events[i]	)
			THIS.of_EvaluateUnwantedChanges( lnva_Events[i], lnv_CorrespondingEvent,ids_eventmapping )
			DESTROY ( lnv_CorrespondingEvent )
		END IF
		
		
		
		// this is where the data gets processed and set
		IF THIS.of_Setdataonbeo( lnva_Events[i] , ids_Eventmapping , lnva_Segments) <> 1 THEN  
			li_Return = -1
		END IF
		
		// this gets access to the specific stop group
		THIS.of_Getstopgroup( lnva_Events[i].of_GetImportReference( ) , lnva_Segments )	
		IF THIS.of_Setdataonbeo( lnva_Events[i] , ids_Eventmapping , lnva_Segments) <> 1 THEN  
			li_Return = -1
		END IF
		
		///// special processing to try and set the site if it is null
		IF IsNull ( lnva_Events[i].of_GetSite ( ) ) THEN
			THIS.of_getvalue( "N1", "2", "", lnva_Segments, la_Value)	
			ls_Name = String ( la_Value )
			THIS.of_getvalue( "N4", "3", "", lnva_Segments, la_Value)	
			ls_Zip = String ( la_Value )
			ll_Site = gnv_cst_companies.of_Find ( ls_Name , ls_Zip )
			IF ll_Site > 0 THEN
				lnva_Events[i].of_SetSite( ll_Site )
			END IF		
		END IF
		
		///// THEN I want to reload the event mapping and start fresh for the
		/////	next event.
		THIS.of_LoadEventmapping( )

	NEXT
END IF

n_cst_AnyArraySrv	lnv_Array
lnv_Array.of_Destroy( lnva_Events )

RETURN li_Return










end function

protected function integer of_getstopgroupbycondition (string as_segmenttoevaluate, string as_elementcondition, ref n_cst_edisegment anva_segments[]);/*
	THIS is used to get stop group by means other than the stop number ( S5 ) 



*/

int	li_GroupCount
Int	i
Int	j
Int	li_TestCount
Int	li_Return 

n_cst_EDISegment	lnva_Segments[]
n_cst_EDISegment	lnva_TestSegments[]

li_GroupCount = THIS.of_Getsegments( "S5", lnva_Segments )

FOR i = 1 TO li_GroupCount
	
	THIS.of_Getstopgroup( i, lnva_Segments )
	li_TestCount = THIS.of_Getsegments( as_segmenttoevaluate , lnva_Segments, lnva_TestSegments )
	FOR j = 1 TO li_TestCount
		IF lnva_TestSegments[j].of_Meetscondition( as_elementcondition ) = 1 THEN
			anva_segments[] = lnva_Segments
			li_Return = 1
			EXIT 
		END IF
		
	NEXT
	
NEXT


RETURN li_Return
end function

protected function integer of_setitemdataintermodal ();// not used ??????????????
//MessageBox ( "A" , "A" ) 
Int		li_Return = 1
Int		li_SegmentCount
Int		li_ItemCount
Int		li_ItemGroup
String	ls_StopType
Int		li_Null
String	ls_Freight
String	ls_Acc
Dec {2}	lc_Freight
Dec {2}	lc_Acc

n_cst_edisegment	lnva_ItemSegments[]

n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Item			lnva_ItemList[]
n_cst_beo_Item			lnva_EmptyItemList[]
SetNull ( li_Null )

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_Getdispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_Getshipment( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF	
END IF

// this needs to be re-thought
IF li_Return = 1 THEN

	
	IF THIS.of_GetSegments( "L3",lnva_ItemSegments) > 0 THEN
		/////////////////////////  FREIGHT ITEMS
		lnva_Itemsegments[ 1 ].of_getvalue( {3}, ls_Freight)
		IF IsNumber ( ls_Freight ) THEN
			lc_Freight = Dec ( Left ( ls_Freight , Len ( ls_Freight ) - 2 ) + "." + Right ( ls_Freight , 2 ) )		
		END IF
	
		IF lc_Freight > 0 THEN
			
			ids_itemmapping.SetFilter ( "itemtype = 'L'" )
			ids_itemmapping.Filter ()
			
			lnv_Shipment.of_Getitemsforeventtype( n_cst_Constants.cs_ItemEventType_ImportedFreight , lnva_ItemList)
			li_ItemCount = UpperBound ( lnva_ItemList ) 
			IF li_ItemCount > 0 THEN	// there should only be one of these
				
				IF THIS.of_setdataonbeo( lnva_ItemList[1], ids_itemmapping ) <> 1 THEN
					li_Return = -1
					THIS.of_AddError( "Data could not be set on the Freight item" )
				END IF
				
				lnva_ItemList[1].of_Setratetype( appeon_constant.cs_RateUnit_Code_Flat)
				lnva_ItemList[1].of_setamount( lc_Freight )	
				DESTROY ( lnva_ItemList[1] )				
			END IF
				
		END IF
	
		/////////////////////////  ACC ITEMS
		
		lnva_ItemList = lnva_EmptyItemList
		lnva_Itemsegments[ 1 ].of_getvalue( {6}, ls_Acc)		
		IF IsNumber ( ls_Acc ) THEN
			lc_Acc = Dec ( Left ( ls_Acc , Len ( ls_Acc ) - 2 ) + "." + Right ( ls_Acc , 2 ) )
		END IF
		
		IF lc_Acc > 0 THEN
			ids_itemmapping.SetFilter ( "itemtype = 'A'" )
			ids_itemmapping.Filter ()
			
			lnv_Shipment.of_Getitemsforeventtype( n_cst_Constants.cs_ItemEventType_ImportedAcc , lnva_ItemList)
			li_ItemCount = UpperBound ( lnva_ItemList ) 
			IF li_ItemCount > 0 THEN	// there should only be one of these
				
				IF THIS.of_setdataonbeo( lnva_ItemList[1], ids_itemmapping ) <> 1 THEN
					li_Return = -1
					THIS.of_AddError( "Data could not be set on the Accessorial item" )
				END IF
				lnva_ItemList[1].of_Setratetype( appeon_constant.cs_RateUnit_Code_Flat)
				lnva_ItemList[1].of_setamount( lc_Acc )	
				DESTROY ( lnva_ItemList[1] )
			END IF
			
		END IF
	
	END IF
	
	//
	
	
END IF
ids_itemmapping.SetFilter ( "" )
ids_itemmapping.Filter ()


RETURN li_Return


end function

protected function integer of_additems ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_additems
//  
//	Access		:Private
//
//	Arguments	:NONE
//			
//
//	Return		: Int 
//						1 success
//						-1 Failure
//						
//	Description	:  curently just a wrapper to abstract the call to add items regardless of whether the shipment is an intermodal shipment
//						or not.
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int	li_return = 1

IF THIS.of_Ismoveintermodal( ) THEN
	IF THIS.of_addintermodalitemsifneeded( ) <> 1 THEN
		li_Return = -1
	END IF
ELSE
	IF THIS.of_AddNonIntermodalItems ( ) <> 1 THEN
		li_Return = -1
	END IF
END IF
//
RETURN li_Return




end function

protected function integer of_addintermodalitemsifneeded ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_addintermodalitemsifneeded
//  
//	Access		:Private
//
//	Arguments	:NONE
//			
//
//	Return		:Int 
//					1 = success
//					-1 = Failure
//					
//						
//	Description	: This is designed to be called during an update request. It will see if more items have been added to the tender 
//						and therefore more items need to be added to the shipment.
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int	li_ItemCount
Int	li_Return = 1
Int	i
Long	ll_NewItemID
Int	li_FreightCount
Int	li_AccCount

String	ls_Acc

Dec {2}	lc_Acc	// EDI Standard for the L3 segment id [N2]

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_csT_beo_Item			lnv_Item
n_csT_beo_Item			lnva_Items[]
n_cst_ediSegment		lnva_ItemSegments[]
n_cst_AnyArraySrv		lnv_ArraySrv

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_GetShipment ( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_GetDispatch ( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	li_FreightCount = lnv_Shipment.of_GetItemsforeventtype( n_Cst_Constants.cs_itemeventtype_importedfreight, lnva_Items )
	lnv_ArraySrv.of_Destroy( lnva_Items )
	li_AccCount	= lnv_Shipment.of_GetItemsforeventtype( n_Cst_Constants.cs_itemeventtype_importedacc , lnva_Items )
	lnv_ArraySrv.of_Destroy( lnva_Items )
END IF

IF li_Return = 1 THEN
	lnv_Item = Create n_Cst_beo_Item
	lnv_Item.of_SetSource ( lnv_Dispatch.of_GetItemCache ( ) )
	lnv_Item.of_SetShipment ( lnv_Shipment )
	lnv_Item.of_SetAllowFilterSet ( TRUE ) 
END IF

IF li_Return = 1 THEN
	li_ItemCount = THIS.of_GetSegments( "L3",lnva_ItemSegments)
	FOR i = 1 TO li_ItemCount	
		
		
		lnva_Itemsegments[ li_ItemCount ].of_getvalue( {6}, ls_Acc)
		
		
		IF li_FreightCount = 0 THEN
			ll_NewItemID = lnv_Shipment.of_AddItem ( "L" , lnv_Dispatch ) 
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetEventtypeflag( n_Cst_Constants.cs_itemeventtype_importedfreight )			
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not create a freight item. " )
			END IF
		END IF
		
		IF IsNumber ( ls_Acc ) THEN
			lc_Acc = Dec (ls_Acc ) 
		END IF
		IF lc_Acc > 0 AND li_AccCount = 0 THEN
			ll_NewItemID = lnv_Shipment.of_AddItem ( "A" , lnv_Dispatch ) 
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetEventtypeflag( n_Cst_Constants.cs_itemeventtype_importedacc )			
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not create an accessorial item. " )
			END IF
		END IF
			
	NEXT
END IF


DESTROY ( lnv_Item )
RETURN li_Return

end function

protected function integer of_processitemdata ();Int	li_Return = 1

IF THIS.of_ismoveintermodal( ) THEN
	IF THIS.of_SetItemDataIntermodal( ) <> 1 THEN
		li_Return = -1
	END IF
ELSE 
	IF THIS.of_SetItemdataNONintermodal( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

RETURN li_Return
end function

protected function integer of_getequipmentsegments (ref n_cst_edisegment anva_eqsegments[]);// by default we will not be creating equipment for non-intermodal shipments
Int	li_Return = 0
n_Cst_edisegment		lnva_EquipmentSegments[]

IF THIS.of_ismoveintermodal( ) THEN
	li_Return = THIS.of_Getsegments( "N7" , lnva_EquipmentSegments )
	anva_eqsegments[] = lnva_EquipmentSegments
END IF

RETURN li_Return
end function

protected function datastore of_getpendingdatastore ();DataStore		lds_Pending

lds_Pending = CREATE Datastore
lds_Pending.DataObject = "d_importedshipments"
lds_Pending.SetTransObject(SQLCA )

lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 ")


RETURN lds_Pending
end function

public function string of_geterrorstring ();int 		li_errorCount
int		i
String	ls_ErrorString

n_cst_OFRError 				lnva_Error[]
n_cst_OFRError_Collection 	lnv_ErrorCollection

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_ErrorCollection.geterrorcount( )

For i = 1 TO li_ErrorCount
	ls_ErrorString += string( lnva_Error[i].getErrorMessage() ) + ", "
next

RETURN ls_ErrorString
end function

protected function integer of_getsegmentsbycondidtion (string as_segment, string as_condition, ref n_cst_edisegment anva_segments[]);Int	li_Count
Int	li_Keep
Int	i
n_cst_EdiSegment	lnva_Segments[]
n_Cst_EdiSegment	lnva_KeepSegments[]

li_Count = THIS.of_GetSegments( as_segment, lnva_Segments)

FOR i = 1 TO li_Count
	
	IF lnva_Segments[i].of_Meetscondition( as_condition ) = 1 THEN
		li_Keep ++
		lnva_KeepSegments[ li_Keep ] = lnva_Segments[i]
	END IF
	
NEXT

anva_segments[] = lnva_KeepSegments

RETURN li_Keep
end function

protected function integer of_setcharges (n_cst_beo_item anv_targetitem);Int	li_Count
Int	li_
String	ls_RateType
Int	li_Return
String	ls_Charges
String	ls_Rate
String	ls_Advance
String	ls_Weight
String	ls_Qty
Dec		lc_Rate
Dec		lc_Charge
Dec		lc_Advance
Long		ll_Weight
Long		ll_Qty
String	ls_WeightQual


n_cst_EdiSegment	lnva_Segments[]

li_Count = THIS.of_Getsegments( "L3" , lnva_Segments )

IF li_Count > 0 THEN
	
	
	
	lnva_Segments[ 1 ].of_getvalue( {5}, ls_Charges)
	IF IsNumber ( ls_Charges ) THEN
		lc_Charge = Dec ( Left ( ls_Charges , Len ( ls_Charges ) - 2 ) + "." + Right ( ls_Charges , 2 ) )		
	END IF
	
	lnva_Segments[ 1 ].of_getvalue( {4}, ls_RateType )

	lnva_Segments[ 1 ].of_getvalue( {3}, ls_Rate )
	IF IsNumber ( ls_Rate ) THEN
		lc_Rate = Dec ( ls_Rate ) 
	END IF
	
//	lnva_Segments[ 1 ].of_getvalue( {6}, ls_Advance )
//	IF IsNumber ( ls_Advance ) THEN
//		lc_Advance = Dec ( Left ( ls_Advance , Len ( ls_Advance ) - 2 ) + "." + Right ( ls_Advance , 2 ) )				
//	END IF
	
	lnva_Segments[ 1 ].of_getvalue( {1}, ls_Weight )
	IF IsNumber ( ls_Weight ) THEN
		ll_Weight = Long ( ls_Weight ) 
	END IF
	
	lnva_Segments[ 1 ].of_getvalue( {2}, ls_WeightQual )
	
	
	lnva_Segments[ 1 ].of_getvalue( {11}, ls_Qty )
	IF IsNumber ( ls_Qty ) THEN
		ll_Qty = Dec ( ls_Qty ) 
	END IF
	
	
	anv_targetitem.of_SetrateType ( 'F' )
	anv_targetitem.of_SetRate ( lc_Charge ) 
	anv_Targetitem.of_SetAmount ( lc_Charge ) 
	
//	IF isValid ( inv_shipment ) THEN
//		inv_Shipment.of_SetDiscountAmount ( lc_Advance )
//	END IF
	
	
END IF

RETURN li_Return

end function

protected function integer of_setacccharge (n_cst_beo_item anv_accitem);Int		li_Return = 1
Int		li_ItemCount
String	ls_TotalCharge
String	ls_Acc
Dec {2}	lc_Acc
Int		li_Qty

n_cst_edisegment	lnva_ItemSegments[]

n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Item			lnv_AccItem
n_cst_beo_Item			lnva_EmptyItemList[]

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_Getdispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_Getshipment( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF	
END IF

lnv_AccItem = anv_accitem

IF li_Return = 1 THEN
	
			
	IF THIS.of_GetSegments( "L3",lnva_ItemSegments) > 0 THEN
		/////////////////////////  Total Charge - Acc Charge = FREIGHT charge
		lnva_Itemsegments[ 1 ].of_getvalue( {5}, ls_TotalCharge)
		lnva_Itemsegments[ 1 ].of_getvalue( {6}, ls_Acc )
		
		IF IsNumber ( ls_TotalCharge ) AND IsNumber ( ls_Acc ) THEN
		
			lc_Acc = Dec ( Left ( ls_Acc , Len ( ls_Acc ) - 2 ) + "." + Right ( ls_Acc , 2 ) )		
					
		END IF
		
		IF lc_Acc > 0 AND isValid ( lnv_AccItem ) THEN	
			
			lnv_AccItem.of_setquantity( 1 )
			
			lnv_AccItem.of_Setratetype( appeon_constant.cs_RateUnit_Code_Flat)
			lnv_AccItem.of_setamount( lc_Acc )	
				
		END IF

	END IF
		
END IF


RETURN li_Return


end function

public function integer of_applyrates ();//Created By Dan 2-2-2006 to allow autorrates to be done on imported shipments.
n_cst_ratedata lnva_ratedata[]
N_cst_beo_shipment lnv_shipment
Int	li_return

lnv_shipment = this.of_getShipment( )
if lnv_shipment.of_autorate(lnva_ratedata, lnv_shipment.cs_action_changedbillto) = 1 then
	lnv_shipment.of_ApplyFreightRate(lnva_ratedata, lnv_shipment.cs_action_changedbillto)
	lnv_shipment.of_ApplyAccessRate(lnva_ratedata) 
	li_return = 1
end if
return li_return
end function

protected function integer of_initializeexistingshipment (string as_importreferenceid);Int		li_Return
String	ls_ImportReference
String	ls_OpenStatus
String	ls_PendingStatus
Long		ll_Count
Long		ll_ShipID

n_cst_beo_Item			lnva_Items[]
n_cst_beo_Shipment	lnv_Shipment
n_Cst_Bso_Dispatch	lnv_Dispatch

li_Return = 1
ls_OpenStatus = gc_Dispatch.cs_shipmentstatus_open
ls_PendingStatus = gc_Dispatch.cs_shipmentstatus_Offered
ls_ImportReference = as_importreferenceid

IF li_Return = 1 THEN
	Select Count ( ds_id ) Into :ll_Count From disp_Ship where edireference = :ls_ImportReference AND ( ds_Status = :ls_OpenStatus OR ds_Status = :ls_PendingStatus); 

	CHOOSE CASE sqlca.sqlCode
		CASE 0,100
			Commit;
		CASE ELSE 
			RollBack;
			li_Return = -1
		END CHOOSE
END IF

IF li_Return = 1 THEN
	CHOOSE Case ll_Count			
		CASE is > 1 //Error, Won't be able to resovle shipment							
			li_Return = -1
			THIS.of_Adderror( "More than one active shipment contains the import reference number " + ls_ImportReference + "." )
		CASE 1 
			Select ds_id into :ll_ShipID From disp_Ship where edireference = :ls_ImportReference AND ( ds_Status = :ls_OpenStatus OR ds_Status = :ls_PendingStatus);
			IF sqlca.sqlCode = 0 THEN
				Commit;
			ELSE 
				RollBack;
				li_Return = -1
				THIS.of_Adderror( "Shipment " + String ( ll_ShipID ) + " was found but could not be successfully selected for modification.[select failed]" )
			END IF
		CASE ELSE
			THIS.of_Adderror( "The existing shipment could not be found using " + ls_ImportReference + "." )
			li_Return = -1
	END CHOOSE
END IF

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_getdispatch( )
	IF lnv_Dispatch.of_retrieveshipment( ll_ShipID ) <> 1 THEN
		li_Return = -1
		THIS.of_AddError ( "Could not retrieve shipment." )
	ELSE
		lnv_Dispatch.of_FilterShipment ( ll_ShipID )
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_GetShipment ( )
	IF Not isValid ( lnv_Shipment ) THEN
		li_Return = -1
		THIS.of_Adderror( "Could not get a valid shipment." )
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment.of_SetSource ( lnv_Dispatch.of_getshipmentcache( ) )
	lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_getItemcache( ) )
	lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_getEventcache( ) )
	lnv_Shipment.of_SetSourceID ( ll_ShipID )
	lnv_Shipment.of_SetAllowFilterSet ( TRUE )
	lnv_Shipment.of_SetContext ( lnv_Dispatch )
END IF

IF li_Return = 1 THEN
	IF NOT THIS.of_IsMoveintermodal( ) THEN
		
		// delete all of the imported items
		lnv_Shipment.of_GetItemsforeventtype( n_Cst_constants.cs_ItemEventType_Imported, lnva_Items )
		int	li_ItemCount
		Int	i
		li_ItemCount = upperBound ( lnva_Items )
		FOR i = 1 TO li_ItemCount 
			lnv_Shipment.of_Removeitem( lnva_Items[i])
			DESTROY ( lnva_Items[i] )
		NEXT
	END IF
		
END IF
	
Return li_Return
end function

protected function integer of_processshipmentdata ();Int		li_Return = 1
String	ls_MoveDirection
n_cst_bso_Dispatch	lnv_Dispatch
n_Cst_beo_Shipment	lnv_Shipment



IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_Getdispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
		THIS.of_AddError ( "Could not create dispatch object." )
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_Getshipment( )
	IF Not IsValid ( lnv_Shipment ) THEN
		li_Return = -1
		THIS.of_AddError ( "Shipment returned was not valid.")
	END IF
END IF


IF li_Return = 1 THEN
	//IF THIS.of_IsMoveIntermodal ( ) THEN
		CHOOSE CASE THIS.of_GetMoveDirection ( )
				
			CASE cs_export
				ls_MoveDirection = "E"
				
			CASE cs_import
				ls_MoveDirection = "I"
				
			CASE cs_Oneway
				ls_MoveDirection = "O"
				
			CASE ELSE
				ls_MoveDirection = ""
		END CHOOSE
		lnv_SHipment.of_SetMoveCode ( ls_MoveDirection )
	//END IF
END IF


IF li_Return = 1 THEN
	lnv_Dispatch.of_filtershipment( lnv_SHipment.of_GetID ( ) )		
END IF

IF IsValid ( inv_comparemanager ) THEN
	THIS.of_Evaluateunwantedchanges(lnv_Shipment , inv_comparemanager.of_getshipment( ) , ids_shipmentmapping )
END IF

IF li_Return = 1 THEN
// this is where the data gets processed and set
	IF THIS.of_Setdataonbeo( lnv_Shipment , ids_shipmentmapping , inva_segments ) <> 1 THEN  
		li_Return = -1
	END IF
END IF

RETURN li_Return


end function

public function string of_getsetpurpose ();Int		li_Return = 1 
String	ls_Return
String	ls_SetPurpose
n_Cst_EDISegment	lnva_EdiSegment[]

IF THIS.of_GetSegments( "B2A", lnva_EdiSegment ) > 0 THEN
	IF lnva_EdiSegment[1].of_GetValue ( {1} , ls_SetPurpose ) <> 1 THEN
		li_Return = -1
	END IF
ELSE
	li_Return = -1
END IF

IF li_Return = 1 THEN
	CHOOSE CASE ls_SetPurpose
			
		CASE "00"
			ls_Return = THIS.cs_SetPurpose_Original
			
		CASE "01" , "03"			// Added 03 "Delete" 6/22/06 S.A.T
			ls_Return = THIS.cs_SetPurpose_Cancel
			
		CASE "04" , "05" , "15" , "20"  //Added 05 "Replace" 4/27/06 S.A.T -- Added 20 "Final Transmission" 6/22/06 S.A.T 
			ls_Return = THIS.cs_SetPurpose_Change
			
	END CHOOSE
		
END IF

RETURN ls_Return
end function

protected function string of_getonewaystopsites ();String	ls_Return 

IF isValid ( ids_companysettings ) THEN
	IF ids_companysettings.RowCount ( ) > 0 THEN
		ls_Return = ids_companysettings.GetItemString ( 1 , "edi204profile_onewaytypes" ) 
	END IF
END IF

RETURN ls_Return
end function

protected function integer of_createshipment ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_createshipment
//  
//	Access		:Private
//
//	Arguments	:NONE
//			
//
//	Return		: int 
//						1 Success
//						-1 Failure
//					
//						
//	Description	: this is basically the wrapper to hold all the calls to the methods that prosess the diferent levels of 
//						information within a shipment. i.e. event, equipment, items and the shipment level info itself 
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

n_cst_beo_Event			lnva_Events[]
n_cst_AnyArraySrv			lnv_Array
n_cst_beo_shipment		lnv_shipment

Int	li_Return = 1 

IF li_Return = 1 THEN
	IF THIS.of_Determinesourcecompany( ) <> 1 THEN   // I don't think we need this here
		li_Return = -1											// since it is called in process 204 request
	END IF	
END IF


IF li_Return = 1 THEN
	IF THIS.of_InitailizeNewShipmentbeo( ) <> 1 THEN
		li_Return = -1
	ELSE
		//added by dan 8-21-2006 for autorating edi shipments
		//this will set a boolean on the shipment that i can check later to see
		//if the company has the setting to autorate or not.
		lnv_Shipment = THIS.of_GetShipment ( )
		IF isValid( lnv_Shipment ) THEN
			lnv_shipment.of_setautoratingforedicompany( il_sourcecompany )
		END IF
		//---------------------------------------------------
	END IF
END IF

// equipment level
IF li_Return = 1 THEN
	IF THIS.of_AddEquipment( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF THIS.of_ProcessEquipmentData ( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF THIS.of_ProcessShipmentData ( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

// event level
IF li_Return = 1 THEN
	THIS.of_AddEvents ( lnva_Events ) 
	lnv_Array.of_destroy( lnva_Events )
	IF THIS.of_ProcessEventData ( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

// item level
IF li_Return = 1 THEN	
	THIS.of_additems( )
	IF THIS.of_ProcessItemData ( ) <> 1 THEN
		li_Return = -1
	END IF
END IF


RETURN li_Return
end function

protected function integer of_getfileformat (string as_filename, ref string as_filetype, ref string as_ediversion, string as_inout);/*
	DEK: Modified arguments so that you must specify Inbound or outbound file format for the transaction
*/

Int	li_File
String	ls_Data
long	ll_ReadReturn
Long	li_Return = 1
Long	ll_CompanyID
String	ls_GSSM = "GS*SM*"
String	ls_Scac
String	ls_Return = "LINE!"
String	ls_EDIVersion
String	ls_FileFormat
Int	li_Pos1
Int	li_Pos2
Int	li_FileClose

li_File = FileOpen ( as_filename , StreamMode! )

If li_File >= 0 THEN
	ll_ReadReturn = FileRead ( li_File , ls_Data )
	IF ll_ReadReturn <= 0 THEN
		li_Return = -1
	END IF
	
	li_FileClose = FILEClose ( li_File )
ELSE
	li_Return = -1
END IF

IF li_Return = 1 THEN
	IF Left ( ls_Data , 3 ) <> "ISA"  THEN  // this will screen out the old formats
		//added by dan to account for xml document imports on 2-2-2006
		IF lower(RIGHT( as_fileName, 3 )) = "xml" THEN
			ls_fileFormat = "XML!"
		ELSE
		//---------------------------
			ls_FileFormat = "LINE!" 
		END IF
		li_Return = 0 //no need to continue processing  !! this will be set back to 1 at the end to return success
		// but we do need to see what version the EDI should be processed By
		
		IF LEFT ( ls_Data , 6 ) = "R204*F" THEN
			ls_EDIVersion = appeon_constant.cs_ediversion_pseudo
		ELSE 
			ls_EDIVersion = appeon_constant.cs_ediversion_VanMapping
		END IF
		
	END IF
END IF

IF li_Return = 1 THEN
	li_Pos1 = Pos ( ls_Data , ls_GSSM )
	IF IsNull(li_Pos1) OR li_Pos1 = 0 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	li_Pos2 = Pos ( ls_Data , "*" , li_Pos1 + Len ( ls_GSSM ) )
	IF IsNull(li_Pos2) OR li_Pos2 = 0 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	ls_Scac = Mid ( ls_Data , li_Pos1 + Len ( ls_GSSM ) , li_Pos2 - ( li_Pos1 + Len ( ls_GSSM ) )  )
	IF Len ( ls_Scac ) <= 0 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	
	  SELECT "edi204profile"."ediversion",   
         "ediprofile"."fileformat"  
    INTO :ls_EDIVersion,   
         :ls_FileFormat  
    FROM "edi204profile",   
         "ediprofile"  
   WHERE ( "edi204profile"."companyid" = "ediprofile"."companyid" ) AND
				"ediprofile"."SCAC" = :ls_Scac AND
				"ediprofile"."transactionset" = 204 AND
				"ediprofile"."in_out" =:as_inout ;  
		COMMIT;
				

END IF

IF li_Return = 1 THEN
	
	IF Len ( ls_EDIVersion ) > 0 THEN
	ELSE
		n_cst_setting_edi204version	lnv_Version
		lnv_Version = CREATE n_cst_setting_edi204version
		ls_EDIVersion = lnv_Version.of_GetValue( )
		DESTROY ( lnv_Version )
	END IF
		
	
END IF

IF Len ( ls_FileFormat ) > 0 AND Len ( ls_EDIVersion  ) > 0 AND li_Return <> -1 THEN
	li_Return = 1
	as_filetype = ls_FileFormat
	as_ediversion = ls_EDIVersion
ELSE
	li_Return = -1
END IF


RETURN li_Return
end function

public function integer of_getreply (integer ai_replynumber, ref n_cst_edisegment anva_segments[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_getreply
//  
//	Access		:Private
//
//	Arguments	: int - the reply I want
//						n_cst_edisegment [] -  the EDI segements that make up the requested reply.
//
//	Return		: int # of segments that make up the stop group.
//					
//						
//	Description	: gets all the EDI segments between a specified st se loop inclusively. 
//
//
//
// 	Written by	:Dan Kimball
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int		li_Return
Int		li_RepSegments
Long		ll_SegmentCount
Long		i
Boolean	lb_TakeSegment
String	ls_CurrentSegment
string	ls_StNumber


n_cst_edisegment	lnva_RepSegments[]


ll_SegmentCount = UpperBound ( inva_segments )
FOR i = 1 TO ll_SegmentCount
	
	ls_CurrentSegment = inva_segments[i].of_getsegmentid( )
	IF ls_CurrentSegment = "ST" THEN
		inva_segments[i].of_getValue ( {2} , ls_StNumber  )
		IF Integer ( ls_StNumber ) = ai_replyNumber THEN
			lb_TakeSegment = TRUE
		ELSE
			lb_TakeSegment = FALSE
		END IF
	ELSEIF ls_CurrentSegment = "SE" THEN
		//get the last piece of the se
		li_RepSegments ++
		lnva_RepSegments [ li_RepSegments ] =  inva_segments[i]
		lb_TakeSegment = FALSE
	END IF
	
	IF lb_TakeSegment THEN
		li_RepSegments ++
		lnva_RepSegments [ li_RepSegments ] =  inva_segments[i]
	END IF

NEXT

anva_segments[] = lnva_RepSegments

RETURN li_RepSegments

end function

public function integer of_getshipmentresponses (integer ai_index, ref long al_shipid, ref string as_response, ref string as_reason);/*
	DEK
		
	DESCRIPTION:  Meant for processing 990s. This will find the reply specified by index ai_index
	and return the shipment id and the response by reference.  It returns 1 if they are valid
	-1 otherwise		as_reason only if declined.
*/


Int	 li_Return = 1
Int	li_SegNum

String	ls_shipId
String	ls_response
String	ls_reason
n_cst_edisegment 		lnva_segments[]
n_cst_edisegment 		lnva_b1segments[]
n_cst_ediSegment		lnva_v9Segments[]

li_SegNum = this.of_getReply( ai_index, lnva_segments)
IF li_segNum > 0 THEN
	this.of_getsegments( "B1", lnva_segments, lnva_b1segments[])
	this.of_getsegments( "V9", lnva_segments, lnva_v9segments[])
	
	//
	IF upperBound( lnva_b1segments ) > 0  THEN
		lnva_b1segments[1].of_getvalue( {2}, ls_shipId)
		//DEK 4-17-07  changed to read it from the B1 segment, I am not sure about the response info at this moment.
		lnva_b1Segments[1].of_getValue( {4}, ls_response )		
		//lnva_v9Segments[1].of_getValue( {1}, ls_response )
		//lnva_v9Segments[1].of_getValue( {8}, ls_reason )	//only populated if declined.
		
		//DEK 4-17-07 I made this an optional condition. I originally thought it was required
		IF upperBound( lnva_v9Segments ) > 0 THEN
			lnva_v9Segments[1].of_getValue( {8}, ls_reason )
		END IF
	ELSE
		li_return = -1
	END IF
	
	IF isNumber( ls_shipId ) THEN
		al_shipid = long( ls_shipId )
		as_response = ls_response
		IF as_response = "D" THEN		//DEK 4-17-07Changed it to look for a D instead of DEC
			as_reason = ls_reason
		END IF
	ELSE 
		li_return = -1
	END IF
ELSE
	li_Return = -1
END IF


RETURN li_REturn
end function

public function integer of_getgroupcontrol (ref long al_groupcontrolnumber, ref string as_sendingcompany);/*
	DEK: this returns by reference the group control number and sending company.
*/

Long	ll_groupControlNumber
String	ls_sendingCompany
String	ls_temp
n_cst_edisegment	lnva_segment[]

IF this.of_GetSegments ( "GS" , inva_segments ,lnva_segment ) = 1 THEN	
	IF lnva_Segment[1].of_Getvalue( {6}, ls_Temp) = 1 THEN
		ll_GroupControlNumber = Long ( ls_Temp )
	END IF	
	IF lnva_Segment[1].of_Getvalue( {2}, ls_Temp) = 1 THEN
		ls_SendingCompany = String ( ls_Temp )
	END IF		
END IF

al_groupcontrolnumber = ll_groupControlNumber
as_sendingcompany = ls_sendingCompany


RETURN 1
end function

public function integer of_geteventconfirmation (integer ai_stnumber, ref string as_at7element, ref string as_at7code, ref datetime adt_at7);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_EventConfirmation
//  
//	Access		:Private
//
//	Arguments	: int - the reply I want
//						n_cst_edisegment [] -  the EDI segements that make up the requested reply.
//
//	Return		: 1 if we got reference values, -1 otherwise
//					
//						
//	Description	: gets all the EDI segments between a specified st se loop inclusively. 
//					
//					meant for use with 214 inbound.
//
// 	Written by	:Dan Kimball
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int	li_Return =1
Long	ll_segCount
n_cst_edisegment lnva_segments[]
n_cst_edisegment lnva_at7segments[]
String	ls_edi
String	ls_at7elementID
String	ls_at7code
String	ls_at7date
String	ls_at7Time
String	ls_year
String	ls_month
String	ls_day
String	ls_hour
String	ls_min
date		ld_at7Date
time		lt_at7Time
ll_segCount = this.of_getReply( ai_stNumber, lnva_segments )

IF ll_segCount > 0 THEN
	this.of_getSegments( "AT7", lnva_segments,lnva_at7segments)
ELSE 
	li_Return = -1
END IF

IF li_Return = 1 THEN
	ll_segCount = upperBound(lnva_at7segments)
	IF ll_segCount > 0 THEN
		//ok
	ELSE
		li_return = -1 
	END IF
END IF

IF li_return = 1 THEN
	lnva_at7segments[1].of_GetValue( {1}, ls_at7Code)	//see if we get something in the first field, if we don't , try for the third.
	IF len( ls_at7Code ) > 0 THEN
		AS_at7element = "AT7_01"
	ELSE
		as_at7element = "AT7_03"
		lnva_at7segments[1].of_GetValue( {3}, ls_at7Code)
		IF len(ls_at7Code) = 0 THEN
			li_Return = -1					//if we dont' get it in the first or third, then it is invalid and can't use it.
		END IF
	END IF
END IF

//get the date and time.
IF li_Return = 1 THEN
	lnva_at7segments[1].of_GetValue( {5}, ls_at7date)
	lnva_at7segments[1].of_GetValue( {6}, ls_at7time)
	ls_at7date = trim( ls_at7date )
	IF len(ls_at7date) = 8 THEN
		ls_year = left( ls_at7date, 4 )
		ls_month = Mid( ls_at7date, 5, 2)
		ls_day = RIGHT( ls_at7date, 2 )
		
		ld_at7Date = date(ls_year+"-"+ls_month+"-"+ ls_day)
	END IF
	
	ls_at7Time = trim( ls_at7Time )
	
	IF len( ls_at7Time ) = 4 THEN
		ls_hour = left( ls_at7Time, 2 )
		ls_min = right( ls_at7Time, 2 )
		lt_at7Time = time( ls_hour +":"+ls_min )
	END IF
	
END IF



IF li_Return =1 THEN
	as_at7code = ls_at7Code
	IF not isNull( datetime( ld_at7Date , lt_at7Time ) ) THEN
		adt_at7 = datetime( ld_at7Date , lt_at7Time )
	ELSE
		li_return = -1
	END IF
END IF



RETURN li_Return


end function

public function integer of_getshipeventid (integer ai_stnumber, ref long al_shipid, ref long al_eventid);/*
	DEK 3-13-07
	Intended for use with inbound 214s.  This function will look in the specifie St loop for the
	B10 and L11 segments. From the B10 we can get the shipment number, and from the L11 we 
	can get the event ID.
	
	Returns 1 if the event id returned is valid, -1 otherwise
*/

Int	li_Return = 1
Long	ll_segCount
String	ls_shipId
String	ls_eventId
n_cst_edisegment lnva_segments[]
n_cst_edisegment lnva_B10segments[]
n_cst_edisegment lnva_L11segments[]

ll_segCount = this.of_getReply( ai_stNumber, lnva_segments )

IF ll_segCount > 0 THEN
	this.of_getSegments( "B10", lnva_segments,lnva_B10segments)
	this.of_getSegments( "L11", lnva_segments,lnva_L11segments)
ELSE 
	li_Return = -1
END IF

IF upperBound( lnva_B10segments ) > 0 AND upperBound( lnva_L11segments ) > 0 THEN
	lnva_B10segments[1].of_getValue( {2}, ls_shipID)
	lnva_L11segments[1].of_getValue( {1}, ls_eventId )
	
	IF isNumber( ls_shipId ) THEN
		al_shipid = long(ls_shipID)
	END IF
	
	IF isNumber( ls_eventId ) THEN
		al_eventId = long( ls_eventId )
	ELSE
		li_return = -1
	END IF
ELSE
	li_return =-1
END IF

RETURN li_Return
end function

public function n_cst_errorlog_manager of_geterrorlogmanager ();IF not isValid( inv_errorLog  ) THEN
	inv_errorLog = create n_cst_errorlog_manager
END IF

RETURN inv_errorLog
end function

private subroutine of_autorateifneeded ();/*
Rick moved this to its own function. it was in of process 204 request. it worked but did not follow the pattern that
had been established. 
There was no return code checking when it was in of_Process204Request so I didn't code any here.
*/


String	ls_AutoRate
n_cst_LicenseManager	lnv_LicenseManager

IF ids_companySettings.rowCount() > 0 THEN
	ls_autorate = ids_CompanySettings.getItemString( 1, "edi204profile_autorate" )
ELSE
	ls_autorate = "No"
END IF

IF lnv_licensemanager.of_hasautoratinglicensed( ) AND ls_autorate = "Yes" THEN
	this.of_applyrates( )
END IF

end subroutine

private function integer of_preupdateprocess ();/*
	Even if we don't end up creating the manager here
	I am still going to return success since a failure
	return code could stop processing.
	All other scripts check to see if the compare manager is valid
	before referencing it. In the event that it comes accross
	one that is not valid it just moves on gracefully.
*/
Int	li_Return
li_Return = 1
n_cst_setting_validate204changes	lnv_Validate
lnv_Validate = CREATE n_cst_setting_validate204changes

IF lnv_Validate.of_GetValue () = lnv_Validate.cs_yes THEN
	
	IF IsValid ( inv_Comparemanager ) THEN
		DESTROY ( inv_Comparemanager )
	END IF
	
	inv_CompareManager = CREATE USING THIS.Classname( )
	inv_CompareManager.of_Initializemanagerforcompare( inv_Shipment.of_GetID  ( ) )
	
END IF

DESTROY ( lnv_Validate )

RETURN li_Return
end function

private function integer of_initializemanagerforcompare (long al_shipment);Int		li_Return = 1
String	ls_RawCompareString
String	lsa_Records[]

n_cst_String   lnv_String

IF li_Return = 1 THEN
	ls_RawCompareString = THIS.of_GetcompareTransaction( al_Shipment )
	IF len ( ls_RawCompareString ) = 0 OR IsNull ( ls_RawCompareString ) THEN
		li_Return = -1	
	END IF
END IF

IF li_Return = 1 THEN
	lnv_String.of_parsetoarray(ls_RawCompareString , '~r~n', lsa_Records)
	IF THIS.of_loadsegments( lsa_Records ) <> 1 THEN
		li_Return = -1
	END IF
END IF

ii_segmentcount = UpperBound ( inva_segments )

THIS.of_Clearerrors( )

IF ii_segmentcount <= 0 THEN
	li_Return = -1
	THIS.of_AddError ( "There are no segments to process." )
END IF

IF li_Return = 1 THEN
	IF THIS.of_Loadcompanysettings( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF THIS.of_LoadEventmapping( ) <> 1 THEN
	li_Return = -1
END IF
IF THIS.of_LoadEquipmentmapping( ) <> 1 THEN
	li_Return = -1
END IF
IF THIS.of_Loaditemmapping( )  <> 1 THEN
	li_Return = -1 
END IF
IF THIS.of_Loadshipmentmapping( ) <> 1 THEN
	li_Return = -1
END IF
IF THIS.of_Loadvaluemapping( ) <> 1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	IF THIS.of_Prepareshipmentforupdate( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF THIS.of_UpdateShipment( ) <> 1 THEN
	li_Return = 0
END IF
					
IF li_return = 1 THEN
	THIS.of_Autorateifneeded( )
END IF

RETURN li_Return
end function

private function string of_getcomparetransaction (long al_shipment);Int	li_Return
String	ls_EDIString
String	ls_SendersCode
Long		ll_CompanyID
Int	ll_RowCount

dataStore	lds_EdiCompare
lds_EdiCompare = CREATE dataStore
lds_EdiCompare.DataObject= "d_204compare" 
lds_EdiCompare.SetTransObject ( SQLCA ) 
ll_RowCount = lds_EdiCompare.Retrieve( al_Shipment )
Commit;

IF ll_RowCount > 0 THEN 
	ls_EDIString = lds_EdiCompare.getitemstring( 1, "FileContents" )
	ls_SendersCode = lds_EdiCompare.getitemstring( 1, "SendersCode" )
	
	SELECT "ediprofile"."companyid"  
       INTO :ll_CompanyID  
       FROM "ediprofile"  
      WHERE "ediprofile"."SCAC" = :ls_SendersCode   ;   
      COMMIT;
		
	IF ll_CompanyID > 0 THEN
		il_sourcecompany = ll_CompanyID
	END IF	
END IF


Destroy ( lds_EdiCompare )

RETURN ls_EDIString
end function

private function integer of_evaluateunwantedchanges (pt_n_cst_beo anv_targetbeo, pt_n_cst_beo anv_comparebeo, ref datastore ads_tags);Int	li_Return 
Long	ll_RowCount
Long	i
String	ls_Tag
Any		la_ExistingValue
Any		la_CompareValue

ll_RowCount = ads_Tags.RowCount ()

IF IsValid ( anv_comparebeo ) AND isValid (Anv_targetbeo ) THEN
	
	FOR i = ll_RowCount To 1 STEP -1
			
		ls_Tag = TRIM ( ads_Tags.GetItemString ( i , "pttarget" )	 )
		IF Right ( ls_Tag , 1 ) = "+" THEN
			CONTINUE // the + means to apend and there is no way that they will be equal
		END IF
			
		anv_TargetBeo.event ue_getvalueany( ls_Tag , la_ExistingValue )
		anv_CompareBeo.event ue_getvalueany( ls_Tag , la_CompareValue )
		
		IF String ( la_CompareValue ) <> String ( la_ExistingValue ) THEN
			ads_Tags.DeleteRow ( i )
		END IF
	NEXT
END IF

RETURN li_Return
end function

private function n_cst_beo_event of_getcorespondingevent (n_cst_beo_event anv_event);Int	li_ImportRef
Int	li_Count
Int	i
String	ls_Type

n_cst_beo_Event	lnv_Event
n_cst_beo_Event	lnva_Eventlist[]
n_cst_beo_Shipment	lnv_CompareShipment


li_ImportRef = anv_event.of_GetImportReference()
ls_Type = anv_event.of_GetType ( )

n_cst_AnyArraySrv	lnv_Array
IF iSValid ( inv_comparemanager ) THEN
	lnv_CompareShipment = inv_comparemanager.of_GetShipment( )
	lnv_CompareShipment.of_GetEventlist( lnva_Eventlist )
END IF

li_Count = UpperBound ( lnva_Eventlist )
FOR i = 1 TO li_Count
	
	IF lnva_Eventlist[i].of_getImportreference( ) = li_ImportRef AND lnva_Eventlist[i].of_getType( ) = ls_Type THEN
		lnv_Event = lnva_Eventlist[i]
		EXIT
	END IF
	
NEXT

RETURN lnv_Event
end function

on n_cst_edishipment_manager.create
call super::create
end on

on n_cst_edishipment_manager.destroy
call super::destroy
end on

event destructor;call super::destructor;DESTROY ( ids_ShipmentMapping )
DESTROY ( inv_dispatch )
DESTROY ( inv_shipment )
DESTROY ( ids_EquipmentMapping )
DESTROY ( ids_EventMapping )
DESTROY ( ids_ItemMapping )
DESTROY ( ids_ValueMapping )
DESTROY ( ids_CompanySettings )
DESTROY ( inv_errorLog )
DESTROY ( inv_CompareManager )

n_cst_AnyArraySrv		lnv_Array
lnv_Array.of_destroy( inva_segments )

end event

