$PBExportHeader$n_cst_events.sru
forward
global type n_cst_events from nonvisualobject
end type
end forward

global type n_cst_events from nonvisualobject autoinstantiate
end type

forward prototypes
public function string of_getpassivetypes ()
public function boolean of_istypepassive (readonly character ach_type)
public function string of_gettypecodetable ()
public function string of_gettypedisplayvalue (char ach_datavalue)
public function char of_gettypedatavalue (string as_displayvalue)
public function boolean of_istypevalid (character ach_type)
public subroutine of_whatsleft (datastore ads_source, long al_sourcerow, integer ai_relativetotype, long al_relativetoid, ref s_longs astr_ids, ref string as_multilist)
public function integer of_sequencebyindex (integer ai_type, long al_id, datastore ads_target, long al_row, decimal ac_sequence)
public function decimal of_getsequencebyindex (integer ai_type, long al_id, datastore ads_source, long al_row, dwbuffer ae_buffer)
public function long of_sequencerange (readonly datastore ads_target, readonly long al_startrow, readonly long al_endrow, readonly integer ai_targettype, readonly long al_targetid, readonly datastore ads_min, readonly long al_minrow, readonly datastore ads_max, readonly long al_maxrow)
public function integer of_gettypeforindex (readonly integer ai_index)
public function string of_getassignmenttypes ()
public function boolean of_istypeassignment (readonly character ach_type)
public function string of_getlocationoptionaltypes ()
public function boolean of_istypelocationoptional (readonly character ach_type)
public function integer of_clearrouting (readonly datastore ads_target, readonly long al_row, readonly boolean ab_cleartimesandconf)
public function string of_getpickuptypes ()
public function string of_getdelivertypes ()
public function boolean of_evaluatetype (character ach_type, string as_typelist)
public function boolean of_istypepickupgroup (readonly character ach_type)
public function boolean of_istypedelivergroup (readonly character ach_type)
public function long of_sequencerange (datastore ads_target, long al_startrow, long al_endrow, integer ai_targettype, long al_targetid, decimal ac_lowerlimit, decimal ac_upperlimit)
public function integer of_getids (datastore ads_source, long al_row, ref long ala_ids[], boolean ab_cleararray, boolean ab_includeactive)
public function long of_getassignmentbyindex (datastore ads_source, long al_row, integer ai_index)
public function integer of_assign (datastore ads_target, long al_row, integer ai_type, long al_id)
public function integer of_assignbyindex (integer ai_index, long al_id, datastore ads_target, long al_row, boolean ab_sequence, decimal ac_sequence)
public function integer of_getminmaxindex (integer ai_type, ref integer ai_min, ref integer ai_max)
public function integer of_getfirstavailableindex (datastore ads_source, long al_row, integer ai_type, ref integer ai_index)
public function integer of_getminindex (integer ai_type, ref integer ai_min)
public function integer of_getmaxindex (integer ai_type, ref integer ai_max)
public function integer of_parsemultilist (string as_multilist, ref string as_trailerlist, ref string as_containerlist)
public function string of_assemblemultilist (ref string as_trailerlist, ref string as_containerlist, boolean ab_scruboriginals)
public function integer of_getfirstavailableindex (long ala_ids[], integer ai_type, ref integer ai_index)
public function integer of_getminmaxindex (ref integer ai_min, ref integer ai_max)
public function integer of_consolidatemultilist (string as_multilist, ref string as_consolidatedlist)
public function integer of_adjust (datastore ads_target, long al_row, integer ai_perspectivetype, long al_perspectiveid, long ala_ids[], integer ai_assignmenttype, long al_assignmentid, boolean ab_association, ref boolean ab_dissociated)
public function integer of_getremainder (datastore ads_source, long al_sourcerow, integer ai_relativetotype, long al_relativetoid, ref long ala_ids[])
public function integer of_getassignmentindex (datastore ads_target, long al_row, integer ai_type, long al_id, ref integer ai_index)
public function integer of_addtomultilist (string as_multilist, integer ai_type, long al_id, ref string as_newmultilist)
public function integer of_parsemultilist (string as_multilist, ref long ala_trailers[], ref long ala_containers[])
public function integer of_getassignmentindex (long ala_ids[], integer ai_type, long al_id, ref integer ai_index)
public function string of_assemblemultilist (string as_trailerlist, string as_containerlist)
public function boolean of_idlistfind (string as_idlist, long al_id)
public function integer of_unassign (datastore ads_target, long al_row, integer ai_type, long al_id)
public function integer of_removefrommultilist (string as_multilist, integer ai_type, long al_id, ref string as_newmultilist)
public function boolean of_isinmultilist (string as_multilist, integer ai_type, long al_id)
public function string of_getassociationtypes ()
public function string of_getdissociationtypes ()
public function boolean of_istypeassociation (readonly char ach_type)
public function boolean of_istypedissociation (readonly char ach_type)
public function string of_getcontainermap (string as_trailer1type, long al_trailer1length, string as_trailer2type, long al_trailer2length, string as_trailer3type, long al_trailer3length, long al_container1length, long al_container2length, long al_container3length, long al_container4length)
public function integer of_getinsertionpoint (datastore ads_target, integer ai_type, long al_id, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle, ref long al_insertionrow, ref string as_errormessage)
public function integer of_resettimes (datastore ads_target, string as_context, date ad_context)
public function integer of_getinsertionpoint (datastore ads_base, integer ai_basetype, long al_baseid, long al_baseevent, datastore ads_target, integer ai_targettype, long al_targetid, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle, ref long al_insertionrow, ref string as_errormessage)
public function string of_getinterchangecapabletypes ()
public function boolean of_istypeinterchangecapable (character ach_type)
public function string of_gettypedisplayvalueshort (character ach_datavalue)
public function string of_gettypecodetableshort ()
public function string of_gettypecodetableforshipment ()
public function boolean of_hasfrontchassissplit (powerObject apo_source)
public function boolean of_hasbackchassissplit (powerobject apo_source)
public function integer of_getbackchassissplitsites (ref long al_dismountid, ref long al_dropid, powerobject apo_source)
public function long of_getchassispulocation (powerobject apo_source)
public function long of_getchassisrtnlocation (powerobject apo_source)
public function integer of_getfrontchassissplitsites (ref long al_hookid, ref long al_mountid, powerobject apo_source)
public function integer of_setbackchassissplitsite (long al_id, powerobject apo_source)
public function integer of_setfrontchassissplitsite (long al_id, powerObject apo_source)
public function long of_gettrailerpulocation (powerobject apo_source)
public function long of_gettrailerrtnlocation (powerobject apo_source)
public function integer of_getsitesforeventflag (powerobject apo_source, string as_flag, ref long al_origin, ref long al_destination)
public function integer of_settrailerpusite (long al_site, powerobject apo_source)
public function integer of_settrailerrtnsite (long al_siteid, powerobject apo_source)
public function integer of_setchassispusite (long al_site, powerobject apo_source)
public function boolean of_hasnonroutablemarkedevents (long ala_eventids[], powerobject apo_source)
public function integer of_markalleventsasroutable (long ala_eventids[], powerobject apo_source)
public function n_cst_beo_event of_gettrailerpuevent (powerobject apo_source)
public function n_cst_beo_event of_gettrailerrtnevent (powerobject apo_source)
public function integer of_setpuapptdate (n_cst_beo_shipment anv_shipment, date ad_value)
public function integer of_setdeliverapptdate (n_cst_beo_shipment anv_shipment, date ad_value)
public function integer of_setpuappttime (n_cst_beo_shipment anv_shipment, time at_value)
public function integer of_setdeliverappttime (n_cst_beo_shipment anv_shipment, time at_value)
public function integer of_resettimes (datastore ads_target, string as_context, date ad_context, integer ai_routetype)
public function string of_gettypedatavalueshort (string as_displayvalue)
public function integer of_geteventcache (ref n_ds ads_eventcache)
public function integer of_getyardevents (n_cst_beo_event anv_anchorevent, ref n_cst_beo_event anv_dropevent, ref n_cst_beo_event anv_hookevent)
end prototypes

public function string of_getpassivetypes ();RETURN gc_Dispatch.cs_EventType_Bobtail + "~t" +&
	gc_Dispatch.cs_EventType_Deadhead + "~t" +&
	gc_Dispatch.cs_EventType_Reposition + "~t" +&
	gc_Dispatch.cs_EventType_Misc + "~t" +&
	gc_Dispatch.cs_EventType_CheckCall + "~t" +&
	gc_Dispatch.cs_EventType_PositionReport + "~t" +&
	gc_Dispatch.cs_EventType_Breakdown + "~t" +&
	gc_Dispatch.cs_EventType_PMService + "~t" +&
	gc_Dispatch.cs_EventType_Repairs + "~t" +&
	gc_Dispatch.cs_EventType_Accident + "~t" +&
	gc_Dispatch.cs_EventType_DOT + "~t" +&
	gc_Dispatch.cs_EventType_Scale + "~t" +&
	gc_Dispatch.cs_EventType_OffDuty + "~t" +&
	gc_Dispatch.cs_EventType_Sleeper //+ "~t" +&
end function

public function boolean of_istypepassive (readonly character ach_type);//Returns: TRUE, FALSE, NULL if cannot be determined (ach_Type is null or invalid)
//(Passthrough return of of_EvaluateType)

RETURN This.of_EvaluateType ( ach_Type, This.of_GetPassiveTypes ( ) )
end function

public function string of_gettypecodetable ();//Old Code Table -- LVSWX weren't used

//Constant String	ls_CodeTable = &
//	"PICKUP~tP/"+&
//	"DELIVER~tD/"+&
//	"HOOK~tH/"+&
//	"DROP~tR/"+&
//	"NEW TRIP~tO/"+&
//	"END TRIP~tF/"+&
//	"FUEL~tL/"+&
//	"SERVICE~tV/"+&
//	"SPECIAL~tS/"+&
//	"SWING OFF~tW/"+&
//	"SWING ON~tX/"+&
//	"MOUNT~tM/"+&
//	"DISMOUNT~tN/"


//New Suggestions

//OUT OF SVC  (Veh, Driv)


Constant String	ls_CodeTable = &
	"PICKUP~t" + gc_Dispatch.cs_EventType_Pickup + "/"+&
	"DELIVER~t" + gc_Dispatch.cs_EventType_Deliver + "/"+&
	"NEW TRIP~t" + gc_Dispatch.cs_EventType_NewTrip + "/"+&
	"END TRIP~t" + gc_Dispatch.cs_EventType_EndTrip + "/"+&
	"HOOK~t" + gc_Dispatch.cs_EventType_Hook + "/"+&
	"DROP~t" + gc_Dispatch.cs_EventType_Drop + "/"+&
	"MOUNT~t" + gc_Dispatch.cs_EventType_Mount + "/"+&
	"DISMOUNT~t" + gc_Dispatch.cs_EventType_Dismount + "/"+&
	"BOBTAIL~t" + gc_Dispatch.cs_EventType_Bobtail + "/"+&
	"DEADHEAD~t" + gc_Dispatch.cs_EventType_Deadhead + "/"+&
	"REPOSITION~t" + gc_Dispatch.cs_EventType_Reposition + "/"+&
	"MISC~t" + gc_Dispatch.cs_EventType_Misc + "/"+&
	"CHECK CALL~t" + gc_Dispatch.cs_EventType_CheckCall + "/"+&
	"POSN REPT~t" + gc_Dispatch.cs_EventType_PositionReport + "/"+&
	"BREAKDWN~t" + gc_Dispatch.cs_EventType_Breakdown + "/"+&
	"PM SERVICE~t" + gc_Dispatch.cs_EventType_PMService + "/"+&
	"REPAIRS~t" + gc_Dispatch.cs_EventType_Repairs + "/"+&
	"ACCIDENT~t" + gc_Dispatch.cs_EventType_Accident + "/"+&
	"DOT INSPECT~t" + gc_Dispatch.cs_EventType_DOT + "/"+&
	"SCALE~t" + gc_Dispatch.cs_EventType_Scale + "/"+&
	"OFF DUTY~t" + gc_Dispatch.cs_EventType_OffDuty + "/"+&
	"SLEEPER~t" + gc_Dispatch.cs_EventType_Sleeper + "/"


RETURN 	ls_CodeTable
end function

public function string of_gettypedisplayvalue (char ach_datavalue);n_cst_String	lnv_String

String	ls_DataValue, &
			ls_CodeTable, &
			ls_Display

ls_DataValue = String ( ach_DataValue )
ls_CodeTable = This.of_GetTypeCodeTable ( )

ls_Display = lnv_String.of_GetCodeTableDisplayValue ( ls_DataValue, ls_CodeTable )

RETURN ls_Display
end function

public function char of_gettypedatavalue (string as_displayvalue);String	ls_CodeTable, &
			ls_DataValue
n_cst_String	lnv_String

ls_CodeTable = This.of_GetTypeCodeTable ( )

ls_DataValue = lnv_String.of_GetCodeTableDataValue ( as_DisplayValue, ls_CodeTable )

RETURN Char ( ls_DataValue )
end function

public function boolean of_istypevalid (character ach_type);//Returns: TRUE, FALSE, Null (if ach_Type = Null)

String	ls_CodeTable
Boolean	lb_Return = FALSE

IF IsNull ( ach_Type ) THEN

	SetNull ( lb_Return )

ELSE

	//The the code table, and pad an extra "/" on the end just in case it doesn't end that
	//way, so the comparison won't get screwed up.
	ls_CodeTable = This.of_GetTypeCodeTable ( ) + "/"
	
	IF Pos ( ls_CodeTable, "~t" + ach_Type + "/" ) > 0 THEN
		lb_Return = TRUE
	END IF

END IF

RETURN lb_Return
end function

public subroutine of_whatsleft (datastore ads_source, long al_sourcerow, integer ai_relativetotype, long al_relativetoid, ref s_longs astr_ids, ref string as_multilist);//Temporary wrap to maintain compatibility.  Calls to this version should be phased out.
//Forward request to the new version, of_GetRemainder.
//The legacy parameter, as_MultiList, is not supported on the new version, and will be
//nulled out here.

SetNull ( as_MultiList )

This.of_GetRemainder ( ads_Source, al_SourceRow, ai_RelativeToType, al_RelativeToId, &
	astr_Ids.Longar )
end subroutine

public function integer of_sequencebyindex (integer ai_type, long al_id, datastore ads_target, long al_row, decimal ac_sequence);//Returns:  1, -1

//If request is by type, don't allow Null ids.  If is request is by assignment, it's ok.
if ai_Type >= 100 and isnull(al_Id) then return -1

if ai_Type = 1 or ai_Type = 100 then
	if ads_Target.getitemnumber(al_Row, "de_driver") = al_Id or isnull(al_Id) then &
		return ads_Target.setitem(al_Row, "de_driver_seq", ac_Sequence)
end if

if ai_Type = 2 or ai_Type = 200 then
	if ads_Target.getitemnumber(al_Row, "de_tractor") = al_Id or isnull(al_Id) then &
		return ads_Target.setitem(al_Row, "de_tractor_seq", ac_Sequence)
end if

if ai_Type = 3 or ai_Type = 300 then
	if ads_Target.getitemnumber(al_Row, "de_trailer1") = al_Id or isnull(al_Id) then &
		return ads_Target.setitem(al_Row, "de_trailer1_seq", ac_Sequence)
end if

if ai_Type = 4 or ai_Type = 300 then
	if ads_Target.getitemnumber(al_Row, "de_trailer2") = al_Id or isnull(al_Id) then &
		return ads_Target.setitem(al_Row, "de_trailer2_seq", ac_Sequence)
end if

if ai_Type = 5 or ai_Type = 300 then
	if ads_Target.getitemnumber(al_Row, "de_trailer3") = al_Id or isnull(al_Id) then &
		return ads_Target.setitem(al_Row, "de_trailer3_seq", ac_Sequence)
end if

if ai_Type = 6 or ai_Type = 400 then
	if ads_Target.getitemnumber(al_Row, "de_container1") = al_Id or isnull(al_Id) then &
		return ads_Target.setitem(al_Row, "de_container1_seq", ac_Sequence)
end if

if ai_Type = 7 or ai_Type = 400 then
	if ads_Target.getitemnumber(al_Row, "de_container2") = al_Id or isnull(al_Id) then &
		return ads_Target.setitem(al_Row, "de_container2_seq", ac_Sequence)
end if

if ai_Type = 8 or ai_Type = 400 then
	if ads_Target.getitemnumber(al_Row, "de_container3") = al_Id or isnull(al_Id) then &
		return ads_Target.setitem(al_Row, "de_container3_seq", ac_Sequence)
end if

if ai_Type = 9 or ai_Type = 400 then
	if ads_Target.getitemnumber(al_Row, "de_container4") = al_Id or isnull(al_Id) then &
		return ads_Target.setitem(al_Row, "de_container4_seq", ac_Sequence)
end if

if ai_Type = 10 or ai_Type = 300 or ai_Type = 400 then
	if ads_Target.getitemnumber(al_Row, "de_acteq") = al_Id or isnull(al_Id) then &
		return ads_Target.setitem(al_Row, "de_acteq_seq", ac_Sequence)
end if

if ai_Type = gc_Dispatch.ci_Assignment_Trip or ai_Type = gc_Dispatch.ci_ItinType_Trip then
	if ads_Target.getitemnumber(al_Row, gc_Dispatch.cs_Column_Trip) = al_Id or isnull(al_Id) then &
		return ads_Target.setitem(al_Row, gc_Dispatch.cs_Column_TripSeq, ac_Sequence)
end if

return -1
end function

public function decimal of_getsequencebyindex (integer ai_type, long al_id, datastore ads_source, long al_row, dwbuffer ae_buffer);if ai_Type >= 100 and isnull(al_Id) then return 0

if ai_Type = 1 or ai_Type = 100 then
	if ads_Source.getitemnumber(al_Row, "de_driver", ae_Buffer, false) = al_Id or &
		isnull(al_Id) then return ads_Source.getitemdecimal(al_Row, "de_driver_seq", &
		ae_Buffer, false)
end if

if ai_Type = 2 or ai_Type = 200 then
	if ads_Source.getitemnumber(al_Row, "de_tractor", ae_Buffer, false) = al_Id or &
		isnull(al_Id) then return ads_Source.getitemdecimal(al_Row, "de_tractor_seq", &
		ae_Buffer, false)
end if

if ai_Type = 3 or ai_Type = 300 then
	if ads_Source.getitemnumber(al_Row, "de_trailer1", ae_Buffer, false) = al_Id or &
		isnull(al_Id) then return ads_Source.getitemdecimal(al_Row, "de_trailer1_seq", &
		ae_Buffer, false)
end if

if ai_Type = 4 or ai_Type = 300 then
	if ads_Source.getitemnumber(al_Row, "de_trailer2", ae_Buffer, false) = al_Id or &
		isnull(al_Id) then return ads_Source.getitemdecimal(al_Row, "de_trailer2_seq", &
		ae_Buffer, false)
end if

if ai_Type = 5 or ai_Type = 300 then
	if ads_Source.getitemnumber(al_Row, "de_trailer3", ae_Buffer, false) = al_Id or &
		isnull(al_Id) then return ads_Source.getitemdecimal(al_Row, "de_trailer3_seq", &
		ae_Buffer, false)
end if

if ai_Type = 6 or ai_Type = 400 then
	if ads_Source.getitemnumber(al_Row, "de_container1", ae_Buffer, false) = al_Id or &
		isnull(al_Id) then return ads_Source.getitemdecimal(al_Row, "de_container1_seq", &
		ae_Buffer, false)
end if

if ai_Type = 7 or ai_Type = 400 then
	if ads_Source.getitemnumber(al_Row, "de_container2", ae_Buffer, false) = al_Id or &
		isnull(al_Id) then return ads_Source.getitemdecimal(al_Row, "de_container2_seq", &
		ae_Buffer, false)
end if

if ai_Type = 8 or ai_Type = 400 then
	if ads_Source.getitemnumber(al_Row, "de_container3", ae_Buffer, false) = al_Id or &
		isnull(al_Id) then return ads_Source.getitemdecimal(al_Row, "de_container3_seq", &
		ae_Buffer, false)
end if

if ai_Type = 9 or ai_Type = 400 then
	if ads_Source.getitemnumber(al_Row, "de_container4", ae_Buffer, false) = al_Id or &
		isnull(al_Id) then return ads_Source.getitemdecimal(al_Row, "de_container4_seq", &
		ae_Buffer, false)
end if

if ai_Type = 10 or ai_Type = 300 or ai_Type = 400 then
	if ads_Source.getitemnumber(al_Row, "de_acteq", ae_Buffer, false) = al_Id or &
		isnull(al_Id) then return ads_Source.getitemdecimal(al_Row, "de_acteq_seq", &
		ae_Buffer, false)
end if

if ai_Type = gc_Dispatch.ci_Assignment_Trip or ai_Type = gc_Dispatch.ci_ItinType_Trip then
	if ads_Source.getitemnumber(al_Row, gc_Dispatch.cs_Column_Trip, ae_Buffer, false) = al_Id or &
		isnull(al_Id) then return ads_Source.getitemdecimal(al_Row, gc_Dispatch.cs_Column_TripSeq, &
		ae_Buffer, false)
end if

return 0
end function

public function long of_sequencerange (readonly datastore ads_target, readonly long al_startrow, readonly long al_endrow, readonly integer ai_targettype, readonly long al_targetid, readonly datastore ads_min, readonly long al_minrow, readonly datastore ads_max, readonly long al_maxrow);//Returns : 1, -1  (Passing a NullOrNotPos al_TargetId returns 1, with no action taken)

integer dateloop, firstdayrow, lastdayrow
decimal {12} seqmin, seqmax
date loopdate, prevdate, folldate, firstdate, lastdate
n_cst_numerical lnv_numerical

Long	ll_Return = 1

if lnv_numerical.of_IsNullOrNotPos(al_TargetId) then return ll_Return

setnull(prevdate)
setnull(folldate)

if isvalid(ads_Min) then
	if al_MinRow > 0 and al_MinRow <= ads_Min.rowcount() then &
		prevdate = ads_Min.object.de_arrdate[al_MinRow]
end if

if isvalid(ads_Max) then
	if al_MaxRow > 0 and al_MaxRow <= ads_Max.rowcount() then &
		folldate = ads_Max.object.de_arrdate[al_MaxRow]
end if

firstdate = ads_Target.object.de_arrdate[al_StartRow]
lastdate = ads_Target.object.de_arrdate[al_EndRow]

for dateloop = 0 to daysafter(firstdate, lastdate)
	loopdate = relativedate(firstdate, dateloop)
	firstdayrow = ads_Target.find("de_arrdate = " + string(loopdate, "yyyy-mm-dd"), &
		al_StartRow, al_EndRow)
	if firstdayrow < 1 then continue
	lastdayrow = ads_Target.find("de_arrdate = " + string(loopdate, "yyyy-mm-dd"), &
		al_EndRow, al_StartRow)

	SetNull ( seqmin )
	SetNull ( seqmax )

	if prevdate = loopdate then
		seqmin = This.of_GetSequenceByIndex (ai_TargetType, al_TargetId, ads_Min, al_MinRow, primary!)
		if seqmin <= 0 then SetNull ( seqmin )
	end if

	if folldate = loopdate then
		seqmax = This.of_GetSequenceByIndex (ai_TargetType, al_TargetId, ads_Max, al_MaxRow, primary!)
		if seqmax <= 0 then SetNull ( seqmax )
	end if

	CHOOSE CASE This.of_SequenceRange ( ads_Target, FirstDayRow, LastDayRow, ai_TargetType, al_TargetId, &
		SeqMin, SeqMax )
	CASE 1
		//OK
	CASE ELSE
		ll_Return = -1
		//Don't exit : Attempt the other sequences anyway
	END CHOOSE

next

return ll_Return
end function

public function integer of_gettypeforindex (readonly integer ai_index);//Returns the Type constant for the requested index, or Null if Type cannot be determined.

Integer	li_Type

CHOOSE CASE ai_Index

CASE gc_Dispatch.ci_MinIndex_Driver TO gc_Dispatch.ci_MaxIndex_Driver
	li_Type = gc_Dispatch.ci_ItinType_Driver

CASE gc_Dispatch.ci_MinIndex_PowerUnit TO gc_Dispatch.ci_MaxIndex_PowerUnit
	li_Type = gc_Dispatch.ci_ItinType_PowerUnit

CASE gc_Dispatch.ci_MinIndex_TrailerChassis TO gc_Dispatch.ci_MaxIndex_TrailerChassis
	li_Type = gc_Dispatch.ci_ItinType_TrailerChassis

CASE gc_Dispatch.ci_MinIndex_Container TO gc_Dispatch.ci_MaxIndex_Container
	li_Type = gc_Dispatch.ci_ItinType_Container

CASE ELSE  //Unexpected Index Value
	SetNull ( li_Type )

END CHOOSE

RETURN li_Type
end function

public function string of_getassignmenttypes ();RETURN 	gc_Dispatch.cs_EventType_NewTrip + "~t" +&
			gc_Dispatch.cs_EventType_EndTrip + "~t" +&
			gc_Dispatch.cs_EventType_Hook + "~t" +&
			gc_Dispatch.cs_EventType_Drop + "~t" +&
			gc_Dispatch.cs_EventType_Mount + "~t" +&
			gc_Dispatch.cs_EventType_Dismount //+ "~t"
end function

public function boolean of_istypeassignment (readonly character ach_type);//Returns: TRUE, FALSE, NULL if cannot be determined (ach_Type is null or invalid)
//(Passthrough return of of_EvaluateType)

RETURN This.of_EvaluateType ( ach_Type, This.of_GetAssignmentTypes ( ) )
end function

public function string of_getlocationoptionaltypes ();RETURN gc_Dispatch.cs_EventType_Misc + "~t" +&
	gc_Dispatch.cs_EventType_CheckCall + "~t" +&
	gc_Dispatch.cs_EventType_PositionReport + "~t" +&
	gc_Dispatch.cs_EventType_Breakdown + "~t" +&
	gc_Dispatch.cs_EventType_Repairs + "~t" +&
	gc_Dispatch.cs_EventType_Accident + "~t" +&
	gc_Dispatch.cs_EventType_DOT + "~t" +&
	gc_Dispatch.cs_EventType_OffDuty + "~t" +&
	gc_Dispatch.cs_EventType_Sleeper //+ "~t" +&


// Passive types not designated as location optional include:
//	gc_Dispatch.cs_EventType_Bobtail + "~t" +&
//	gc_Dispatch.cs_EventType_Deadhead + "~t" +&
//	gc_Dispatch.cs_EventType_Reposition + "~t" +&
//	gc_Dispatch.cs_EventType_PMService + "~t" +&
//	gc_Dispatch.cs_EventType_Scale + "~t" +&
end function

public function boolean of_istypelocationoptional (readonly character ach_type);//Returns: TRUE, FALSE, NULL if cannot be determined (ach_Type is null or invalid)
//(Passthrough return of of_EvaluateType)

RETURN This.of_EvaluateType ( ach_Type, This.of_GetLocationOptionalTypes ( ) )
end function

public function integer of_clearrouting (readonly datastore ads_target, readonly long al_row, readonly boolean ab_cleartimesandconf);Integer		li_Assignment

Integer		li_Return = 1

Integer	li_Min, &
			li_Max

Long		ll_Null
String	ls_Null
Date		ld_Null
Time		lt_Null

SetNull ( ll_Null )
SetNull ( ls_Null )
SetNull ( ld_Null )
SetNull ( lt_Null )

This.of_GetMinMaxIndex ( li_Min, li_Max )

FOR li_Assignment = li_Min TO li_Max
	This.of_AssignByIndex ( li_Assignment, ll_Null, ads_Target, al_Row, TRUE, 0 )
NEXT

li_Assignment = gc_Dispatch.ci_Assignment_Trip
This.of_AssignByIndex ( li_Assignment, ll_Null, ads_Target, al_Row, TRUE, 0 )

ads_Target.Object.de_actpos[al_Row] = 0
ads_Target.Object.de_multi_list[al_Row] = ls_Null

IF ab_ClearTimesAndConf THEN

	IF ads_Target.Object.de_Conf[al_Row] = "T" THEN

		IF IsNull ( ads_Target.Object.de_Shipment_Id[al_Row] ) THEN
			ads_Target.Object.de_Conf[al_Row] = "F"
			ads_Target.Object.de_WhoConf[al_Row] = ls_Null
		ELSE
			li_Return = -1
		END IF

	END IF

	ads_Target.Object.de_arrdate[al_Row] = ld_Null
	ads_Target.Object.de_arrtime[al_Row] = lt_Null
	//ads_Target.Object.de_depdate[al_Row] = ld_Null
	ads_Target.Object.de_deptime[al_Row] = lt_Null

END IF

RETURN li_Return
end function

public function string of_getpickuptypes ();RETURN 	gc_Dispatch.cs_EventType_Pickup + "~t" +&
			gc_Dispatch.cs_EventType_Hook + "~t" +&
			gc_Dispatch.cs_EventType_Mount
end function

public function string of_getdelivertypes ();RETURN 	gc_Dispatch.cs_EventType_Deliver + "~t" +&
			gc_Dispatch.cs_EventType_Drop + "~t" +&
			gc_Dispatch.cs_EventType_Dismount
end function

public function boolean of_evaluatetype (character ach_type, string as_typelist);//Returns: TRUE, FALSE, NULL if cannot be determined (ach_Type is null or invalid)

Boolean	lb_Return = FALSE

IF This.of_IsTypeValid ( ach_Type ) THEN

	//Pad an extra tab on either end, so the comparison is easy.
	as_TypeList = "~t" + as_TypeList + "~t"

	IF Pos ( as_TypeList, "~t" + ach_Type + "~t" ) > 0 THEN
		lb_Return = TRUE
	END IF

ELSE

	SetNull ( lb_Return )

END IF

RETURN lb_Return
end function

public function boolean of_istypepickupgroup (readonly character ach_type);//Returns: TRUE, FALSE, NULL if cannot be determined (ach_Type is null or invalid)
//(Passthrough return of of_EvaluateType)

RETURN This.of_EvaluateType ( ach_Type, This.of_GetPickupTypes ( ) )
end function

public function boolean of_istypedelivergroup (readonly character ach_type);//Returns: TRUE, FALSE, NULL if cannot be determined (ach_Type is null or invalid)
//(Passthrough return of of_EvaluateType)

RETURN This.of_EvaluateType ( ach_Type, This.of_GetDeliverTypes ( ) )
end function

public function long of_sequencerange (datastore ads_target, long al_startrow, long al_endrow, integer ai_targettype, long al_targetid, decimal ac_lowerlimit, decimal ac_upperlimit);//Returns:  1, -1   
//Note : This version does not automatically return 1 for NullOrNotPos al_TargetId, 
//the way the other version of the function does.  This one doesn't screen it at all.

Long		ll_RangeCount, &
			ll_Row
Decimal {12}	lc_Increment
Decimal {12}	lc_SequenceValue
Decimal {12}	lc_Span
Decimal {12}	lc_Work
Integer	li_Places, &
			li_FullNum, &
			li_BaseNum, &
			li_SeqNum

Long		ll_Return = 1


IF ll_Return = 1 THEN

	ll_RangeCount = al_EndRow - al_StartRow + 1

	IF ll_RangeCount > 0 THEN
		//OK
	ELSE
		ll_Return = -1
	END IF

END IF


IF ac_LowerLimit < 1 OR ac_LowerLimit >= 99 THEN
	ll_Return = -1
ELSEIF ac_UpperLimit <= 1 OR ac_UpperLimit > 99 THEN
	ll_Return = -1
ELSEIF ac_LowerLimit >= ac_UpperLimit THEN
	ll_Return = -1
END IF


IF ll_Return = 1 THEN

	IF IsNull ( ac_LowerLimit ) AND IsNull ( ac_UpperLimit ) THEN  //No lower or upper limit
		//Specify arbitrary lower and upper limit.
		IF ll_RangeCount = 2 THEN
			ac_LowerLimit = 1
			ac_UpperLimit = 90
		ELSE
			ac_LowerLimit = 1
			ac_UpperLimit = 60
		END IF
	ELSEIF IsNull ( ac_UpperLimit ) THEN  //No upper limit
		//Go 1/4 of the way up from the lower limit to 99
		ac_UpperLimit = ac_LowerLimit + .25 * ( 99 - ac_LowerLimit )
	ELSEIF IsNull ( ac_LowerLimit ) THEN  //No lower limit
		//Go 1/4 of the way down from the upper limit to 1
		ac_LowerLimit = ac_UpperLimit - .25 * ( ac_Upperlimit - 1 )
	ELSE  //Both limits present
		//Go 1/4 of the way between the lower limit and the upper limit.
		ac_UpperLimit = ac_LowerLimit + .25 * ( ac_UpperLimit - ac_LowerLimit )
	END IF

	lc_Span = ac_UpperLimit - ac_LowerLimit

	IF lc_Span > 0 AND ac_LowerLimit >= 1 AND ac_UpperLimit <= 99 THEN
		//OK
	ELSE
		ll_Return = -1
	END IF

END IF


IF ll_Return = 1 THEN

	lc_Increment = lc_Span / (ll_RangeCount + 1)
	li_Places = Abs ( Int ( LogTen ( lc_Increment ) ) - 1 )
	li_FullNum = Int ( lc_Increment * ( 10 ^ li_Places ) )
	li_BaseNum = Int ( li_FullNum / 10 ) * 10

	if li_BaseNum / li_FullNum >= .8 then
		li_SeqNum = li_BaseNum
	elseif li_FullNum - li_BaseNum >= 5 then
		li_SeqNum = li_BaseNum + 5
	else
		li_SeqNum = li_FullNum
	end if

	lc_Increment = li_SeqNum / (10 ^ li_Places)
	lc_SequenceValue = ac_LowerLimit

	IF lc_Increment > 0 THEN

		for ll_Row = al_StartRow to al_EndRow
	
			lc_SequenceValue += lc_Increment
			This.of_SequenceByIndex  ( ai_TargetType, al_TargetId, ads_Target, ll_Row, lc_SequenceValue )
	
		next

	ELSE
		ll_Return = -1

	END IF

END IF

RETURN ll_Return
end function

public function integer of_getids (datastore ads_source, long al_row, ref long ala_ids[], boolean ab_cleararray, boolean ab_includeactive);//Returns : 1, -1 (-1 currently not implemented)

//ab_ClearArray controls whether the array is first cleared to empty, guaranteeing
//that there is no leftovers in the array.

//ab_IncludeActive controls whether to include a tenth entry for ActEq.

Long	lla_Empty [ ]

IF ab_ClearArray THEN
	ala_Ids = lla_Empty
END IF

ala_Ids [ 1 ] = ads_Source.Object.de_driver [ al_Row ]
ala_Ids [ 2 ] = ads_Source.Object.de_tractor [ al_Row ]
ala_Ids [ 3 ] = ads_Source.Object.de_trailer1 [ al_Row ]
ala_Ids [ 4 ] = ads_Source.Object.de_trailer2 [ al_Row ]
ala_Ids [ 5 ] = ads_Source.Object.de_trailer3 [ al_Row ]
ala_Ids [ 6 ] = ads_Source.Object.de_container1 [ al_Row ]
ala_Ids [ 7 ] = ads_Source.Object.de_container2 [ al_Row ]
ala_Ids [ 8 ] = ads_Source.Object.de_container3 [ al_Row ]
ala_Ids [ 9 ] = ads_Source.Object.de_container4 [ al_Row ]

IF ab_IncludeActive THEN
	ala_Ids [ 10 ] = ads_Source.Object.de_acteq [ al_Row ]
END IF

RETURN 1
end function

public function long of_getassignmentbyindex (datastore ads_source, long al_row, integer ai_index);//Returns : The requested id value for the assignment index provided, 
//or null if the index value is invalid.

//Note : We are not trapping for an invalid datastore or row value.
//If invalid values are supplied, the program will crash.  In addition
//to performance considerations, this will be more helpful to debug the
//problem than an ambiguous null return would be.

Long	ll_Return

CHOOSE CASE ai_Index

CASE 1
	ll_Return = ads_Source.Object.de_driver [ al_Row ]

CASE 2
	ll_Return = ads_Source.Object.de_tractor [ al_Row ]

CASE 3
	ll_Return = ads_Source.Object.de_trailer1 [ al_Row ]

CASE 4
	ll_Return = ads_Source.Object.de_trailer2 [ al_Row ]

CASE 5
	ll_Return = ads_Source.Object.de_trailer3 [ al_Row ]

CASE 6
	ll_Return = ads_Source.Object.de_container1 [ al_Row ]

CASE 7
	ll_Return = ads_Source.Object.de_container2 [ al_Row ]

CASE 8
	ll_Return = ads_Source.Object.de_container3 [ al_Row ]

CASE 9
	ll_Return = ads_Source.Object.de_container4 [ al_Row ]

//CASE 10
//	ll_Return = ads_Source.Object.de_acteq [ al_Row ]

CASE ELSE
	SetNull ( ll_Return )

END CHOOSE

RETURN ll_Return
end function

public function integer of_assign (datastore ads_target, long al_row, integer ai_type, long al_id);//Returns : 1, -1

String	ls_EventType, &
			ls_MultiList
Integer	li_Index, &
			li_Min, &
			li_Max
Boolean	lb_Association = TRUE  //We'll check later if it's actually a dissociation.

Integer	li_Return = 1


IF li_Return = 1 THEN

	li_Return = -1  //If parameters are valid, value will be set back to 1, below.

	IF IsValid ( ads_Target ) THEN

		IF al_Row > 0 AND al_Row <= ads_Target.RowCount ( ) THEN
			li_Return = 1
		END IF

	END IF

END IF


IF li_Return = 1 THEN

	ls_EventType = ads_Target.Object.de_Event_Type [ al_Row ]

	CHOOSE CASE ls_EventType

	CASE gc_Dispatch.cs_EventType_NewTrip, gc_Dispatch.cs_EventType_EndTrip

		CHOOSE CASE ai_Type

		CASE gc_Dispatch.ci_ItinType_Driver, gc_Dispatch.ci_ItinType_PowerUnit
			//OK

		CASE ELSE
			li_Return = -1

		END CHOOSE

	CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Drop

		CHOOSE CASE ai_Type

		CASE gc_Dispatch.ci_ItinType_TrailerChassis, gc_Dispatch.ci_ItinType_Container

			//OK

			//Note : You can't assign a tractor to a hook.  In order for the routing to be valid,
			//the event would have to be routed to a driver, and in this case, you'd have to 
			//assign the driver from the New Trip, not from the hook.

		CASE ELSE
			li_Return = -1

		END CHOOSE


	CASE gc_Dispatch.cs_EventType_Mount, gc_Dispatch.cs_EventType_Dismount

		CHOOSE CASE ai_Type

		CASE gc_Dispatch.ci_ItinType_Container
			//OK

		CASE ELSE
			//We have to assign the container to a mount already routed on the other
			//equipment, not vice-versa.
			li_Return = -1

		END CHOOSE


	CASE ELSE
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	IF This.of_GetMinMaxIndex ( ai_Type, li_Min, li_Max ) = 1 THEN
		//OK
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF This.of_IsTypeDeliverGroup ( ls_EventType ) THEN
		lb_Association = FALSE
	END IF

	CHOOSE CASE This.of_GetAssignmentIndex ( ads_Target, al_Row, ai_Type, al_Id, li_Index )

	CASE 1  //Id is already assigned

		//If we're performing an association, the id shouldn't already be in the list.

		IF lb_Association = TRUE THEN
			li_Return = -1
		END IF

	CASE 0  //Id is not already assigned

		//If we're performing a dissociation, the id must already be in the list.

		IF lb_Association = FALSE THEN
			li_Return = -1
		END IF

	CASE ELSE  //-1 : Error
		li_Return = -1

	END CHOOSE

END IF


//If we're performing an association, the id must be added to the list.
//If we're performing a dissociation, the id is already in the list.

IF li_Return = 1 AND lb_Association THEN

	IF This.of_GetFirstAvailableIndex ( ads_Target, al_Row, ai_Type, li_Index ) = 1 THEN

		IF This.of_AssignByIndex ( li_Index, al_Id, ads_Target, al_Row, TRUE, 0 ) = 1 THEN
			//OK
		ELSE
			li_Return = -1
		END IF

	ELSE  //0 = No Position Available, -1 = Error
		li_Return = -1

	END IF

END IF


//Whether we're performing an association or a dissociation, we need to add the id to
//the multilist.

IF li_Return = 1 THEN

	CHOOSE CASE ai_Type

	CASE gc_Dispatch.ci_ItinType_TrailerChassis, gc_Dispatch.ci_ItinType_Container

		ls_MultiList = ads_Target.Object.de_Multi_List [ al_Row ]

		CHOOSE CASE This.of_AddToMultiList ( ls_MultiList, ai_Type, al_Id, ls_MultiList )

		CASE 1  //The id was successfully added to the multilist.  Set the new multilist onto the row.

			ads_Target.Object.de_Multi_List [ al_Row ] = ls_MultiList

		CASE 0  //The id was already in the multilist.  Fail.  (Note : We could conceivably ignore this, but...)
			li_Return = -1

		CASE ELSE  //-1

			li_Return = -1

		END CHOOSE

	END CHOOSE

END IF


RETURN li_Return
end function

public function integer of_assignbyindex (integer ai_index, long al_id, datastore ads_target, long al_row, boolean ab_sequence, decimal ac_sequence);//Returns:  1, -1

Integer	li_Return = 1

choose case ai_Index
case 1
	ads_Target.setitem(al_Row, "de_driver", al_Id)
	if ab_Sequence then ads_Target.setitem(al_Row, "de_driver_seq", ac_Sequence)
case 2
	ads_Target.setitem(al_Row, "de_tractor", al_Id)
	if ab_Sequence then ads_Target.setitem(al_Row, "de_tractor_seq", ac_Sequence)
case 3
	ads_Target.setitem(al_Row, "de_trailer1", al_Id)
	if ab_Sequence then ads_Target.setitem(al_Row, "de_trailer1_seq", ac_Sequence)
case 4
	ads_Target.setitem(al_Row, "de_trailer2", al_Id)
	if ab_Sequence then ads_Target.setitem(al_Row, "de_trailer2_seq", ac_Sequence)
case 5
	ads_Target.setitem(al_Row, "de_trailer3", al_Id)
	if ab_Sequence then ads_Target.setitem(al_Row, "de_trailer3_seq", ac_Sequence)
case 6
	ads_Target.setitem(al_Row, "de_container1", al_Id)
	if ab_Sequence then ads_Target.setitem(al_Row, "de_container1_seq", ac_Sequence)
case 7
	ads_Target.setitem(al_Row, "de_container2", al_Id)
	if ab_Sequence then ads_Target.setitem(al_Row, "de_container2_seq", ac_Sequence)
case 8
	ads_Target.setitem(al_Row, "de_container3", al_Id)
	if ab_Sequence then ads_Target.setitem(al_Row, "de_container3_seq", ac_Sequence)
case 9
	ads_Target.setitem(al_Row, "de_container4", al_Id)
	if ab_Sequence then ads_Target.setitem(al_Row, "de_container4_seq", ac_Sequence)
//case 10
//	ads_Target.setitem(al_Row, "de_acteq", al_Id)
//	if ab_Sequence then ads_Target.setitem(al_Row, "de_acteq_seq", ac_Sequence)

CASE gc_Dispatch.ci_Assignment_Trip
	ads_Target.setitem(al_Row, "de_Trailer", al_Id)
	if ab_Sequence then ads_Target.setitem(al_Row, "de_Trailer_Seq", ac_Sequence)

CASE ELSE  //Unexpected Type
	li_Return = -1

end choose

RETURN li_Return
end function

public function integer of_getminmaxindex (integer ai_type, ref integer ai_min, ref integer ai_max);//Get the min and max routing index for the requested ItinType

//Returns : 1, -1

Integer	li_Return = 1

CHOOSE CASE ai_Type

CASE gc_Dispatch.ci_ItinType_Driver
	ai_Min = gc_Dispatch.ci_MinIndex_Driver
	ai_Max = gc_Dispatch.ci_MaxIndex_Driver

CASE gc_Dispatch.ci_ItinType_PowerUnit
	ai_Min = gc_Dispatch.ci_MinIndex_PowerUnit
	ai_Max = gc_Dispatch.ci_MaxIndex_PowerUnit

CASE gc_Dispatch.ci_ItinType_TrailerChassis
	ai_Min = gc_Dispatch.ci_MinIndex_TrailerChassis
	ai_Max = gc_Dispatch.ci_MaxIndex_TrailerChassis

CASE gc_Dispatch.ci_ItinType_Container
	ai_Min = gc_Dispatch.ci_MinIndex_Container
	ai_Max = gc_Dispatch.ci_MaxIndex_Container

CASE ELSE
	SetNull ( ai_Min )
	SetNull ( ai_Max )
	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function integer of_getfirstavailableindex (datastore ads_source, long al_row, integer ai_type, ref integer ai_index);//Returns : 1 = Available position determined, passed out in ai_Index
//0 = No position available for the requested type
//-1 = Error

//FirstAvailableIndex is passed out in ai_Index if determined, 
//ai_Index is set to null for return values 0 and -1

Integer	li_Index, &
			li_Min, &
			li_Max

Integer	li_Return = 0
SetNull ( ai_Index )

IF This.of_GetMinMaxIndex ( ai_Type, li_Min, li_Max ) = 1 THEN

	FOR li_Index = li_Min TO li_Max

		IF IsNull ( This.of_GetAssignmentByIndex ( ads_Source, al_Row, li_Index ) ) THEN

			ai_Index = li_Index
			li_Return = 1
			EXIT

		END IF

	NEXT

	//If no available index value was determined above, return value will remain 0, 
	//and ai_Index will remain null.

ELSE
	li_Return = -1

END IF

RETURN li_Return
end function

public function integer of_getminindex (integer ai_type, ref integer ai_min);//Get the min routing index for the requested ItinType

Integer	li_Return = 1

CHOOSE CASE ai_Type

CASE gc_Dispatch.ci_ItinType_Driver
	ai_Min = gc_Dispatch.ci_MinIndex_Driver

CASE gc_Dispatch.ci_ItinType_PowerUnit
	ai_Min = gc_Dispatch.ci_MinIndex_PowerUnit

CASE gc_Dispatch.ci_ItinType_TrailerChassis
	ai_Min = gc_Dispatch.ci_MinIndex_TrailerChassis

CASE gc_Dispatch.ci_ItinType_Container
	ai_Min = gc_Dispatch.ci_MinIndex_Container

CASE ELSE
	SetNull ( ai_Min )
	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function integer of_getmaxindex (integer ai_type, ref integer ai_max);//Get the max routing index for the requested ItinType

Integer	li_Return = 1

CHOOSE CASE ai_Type

CASE gc_Dispatch.ci_ItinType_Driver
	ai_Max = gc_Dispatch.ci_MaxIndex_Driver

CASE gc_Dispatch.ci_ItinType_PowerUnit
	ai_Max = gc_Dispatch.ci_MaxIndex_PowerUnit

CASE gc_Dispatch.ci_ItinType_TrailerChassis
	ai_Max = gc_Dispatch.ci_MaxIndex_TrailerChassis

CASE gc_Dispatch.ci_ItinType_Container
	ai_Max = gc_Dispatch.ci_MaxIndex_Container

CASE ELSE
	SetNull ( ai_Max )
	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function integer of_parsemultilist (string as_multilist, ref string as_trailerlist, ref string as_containerlist);//Returns : 1, -1  (-1 Currently not implemented)
//as_TrailerList and as_ContainerList will be set to empty string if the
//respective list element is missing from the multilist string.

n_cst_String	lnv_String

IF Len ( as_MultiList ) > 0 THEN

	//of_GetKeyValue returns empty string if the key requested is not found.
	as_TrailerList = lnv_String.of_GetKeyValue ( as_MultiList, "T", ";" )
	as_ContainerList = lnv_String.of_GetKeyValue ( as_MultiList, "C", ";" )

ELSE

	as_TrailerList = ""
	as_ContainerList = ""

END IF

RETURN 1
end function

public function string of_assemblemultilist (ref string as_trailerlist, ref string as_containerlist, boolean ab_scruboriginals);String	ls_MultiList, &
			ls_Work
Integer	li_Loop

FOR li_Loop = 1 TO 2

	CHOOSE CASE li_Loop

	CASE 1
		ls_Work = as_TrailerList

	CASE 2
		ls_Work = as_ContainerList

	END CHOOSE
	
	
	IF Left ( ls_Work, Len ( gc_Dispatch.cs_MultiListDelimiter ) ) = gc_Dispatch.cs_MultiListDelimiter THEN
		ls_Work = Mid ( ls_Work, 2 )
	END IF
	
	IF Right ( ls_Work, Len ( gc_Dispatch.cs_MultiListDelimiter ) ) = gc_Dispatch.cs_MultiListDelimiter THEN
		ls_Work = Left ( ls_Work, Len ( ls_Work ) - 1 )
	END IF


	CHOOSE CASE li_loop

	CASE 1

		IF Len ( ls_Work ) > 0 THEN
			ls_MultiList += "T=" + ls_Work
		END IF

		IF ab_ScrubOriginals THEN
			as_TrailerList = ls_Work
		END IF

	CASE 2

		IF Len ( ls_Work ) > 0 THEN

			IF Len ( ls_MultiList ) > 0 THEN
				ls_MultiList += ";"
			END IF

			ls_MultiList += "C=" + ls_Work

		END IF

		IF ab_ScrubOriginals THEN
			as_ContainerList = ls_Work
		END IF

	END CHOOSE

NEXT

RETURN ls_MultiList
end function

public function integer of_getfirstavailableindex (long ala_ids[], integer ai_type, ref integer ai_index);//Returns : 1 = Available position determined, passed out in ai_Index
//0 = No position available for the requested type
//-1 = Error

//FirstAvailableIndex is passed out in ai_Index if determined, 
//ai_Index is set to null for return values 0 and -1

Integer	li_Index, &
			li_Min, &
			li_Max

Integer	li_Return = 0
SetNull ( ai_Index )

IF This.of_GetMinMaxIndex ( ai_Type, li_Min, li_Max ) = 1 THEN

	IF UpperBound ( ala_Ids ) >= li_Max THEN

		FOR li_Index = li_Min TO li_Max
	
			IF IsNull ( ala_Ids [ li_Index ] ) THEN
	
				ai_Index = li_Index
				li_Return = 1
				EXIT
	
			END IF
	
		NEXT

		//If no available index value was determined above, return value will remain 0, 
		//and ai_Index will remain null.

	ELSE
		li_Return = -1

	END IF

ELSE
	li_Return = -1

END IF

RETURN li_Return
end function

public function integer of_getminmaxindex (ref integer ai_min, ref integer ai_max);//Get the absolute min and max routing index

//Returns : 1, -1  (-1 not currently implemented)

ai_Min = gc_Dispatch.ci_MinIndex_Driver
ai_Max = gc_Dispatch.ci_MaxIndex_Container

RETURN 1
end function

public function integer of_consolidatemultilist (string as_multilist, ref string as_consolidatedlist);//Consolidates the id lists embedded in the multilist into one list of ids, 
//with no "T=" and "C=" markers

//Returns : 1, -1
//The consolidated id list (which may be the empty string) is passed out in as_ConsolidatedList, 
//or null is passed out if an error occurs (return value -1).

String	ls_TrailerList, &
			ls_ContainerList, &
			ls_ConsolidatedList

Integer	li_Return = 1

IF This.of_ParseMultiList ( as_MultiList, ls_TrailerList, ls_ContainerList ) = 1 THEN

	ls_ConsolidatedList = ls_TrailerList

	IF Len ( ls_ContainerList ) > 0 THEN
		
		IF Len ( ls_ConsolidatedList ) > 0 THEN

			ls_ConsolidatedList += gc_Dispatch.cs_MultiListDelimiter

		END IF

		ls_ConsolidatedList += ls_ContainerList

	END IF

ELSE  //Error
	li_Return = -1

END IF


IF li_Return = 1 THEN
	as_ConsolidatedList = ls_ConsolidatedList
ELSE
	SetNull ( as_ConsolidatedList )
END IF

RETURN li_Return
end function

public function integer of_adjust (datastore ads_target, long al_row, integer ai_perspectivetype, long al_perspectiveid, long ala_ids[], integer ai_assignmenttype, long al_assignmentid, boolean ab_association, ref boolean ab_dissociated);String	ls_EventType
Long		lla_ExistingIds[], &
			lla_Ids[], &
			lla_Work[], &
			lla_Trailers[], &
			lla_Containers[], &
			ll_Null
String	ls_ExistingMultiList, &
			ls_MultiList, &
			ls_TrailerList, &
			ls_ContainerList, &
			ls_Work
Integer	li_Count, &
			li_Index, &
			li_Type, &
			li_Loop, &
			li_Work, &
			li_Min, &
			li_Max, &
			li_AbsoluteMin, &
			li_AbsoluteMax
Boolean	lb_Change, &
			lb_AddToList, &
			lb_Slotted
Decimal {12}	lca_Seqs[]
n_cst_String	lnv_String

Integer	li_Return = 1
Boolean	lb_Finished = FALSE

SetNull ( ll_Null )

//Initialized the ab_Dissociated reference variable.  This will be flagged to true if the
//"assignment" is dissociated by this event.  This has a different meaning depending on
//the value of ab_Association.  

//If ab_Association is TRUE, we have assigned al_AssignmentId and are carrying forward that 
//assignment.  If we are able to unassign al_AssignmentId with this event, ab_Dissociated will
//be set to TRUE.  This will inform the calling script that the assignment has now been undone.

//If ab_Association is FALSE, we have unassigned al_AssignmentId, and are carrying that 
//unassignment forward.  If this event had previously carried out that unassignment, 
//ab_Dissociated will be set to TRUE.  This will let the calling script know that the 
//assignment being undone did not carry beyond this event previously.

ab_Dissociated = FALSE

//Initialize lla_Ids (which will be the work variable),
//to the inbound values from the previous row.
lla_Ids = ala_Ids

//Initialize the values for AbsoluteMin and AbsoluteMax index.
This.of_GetMinMaxIndex ( li_AbsoluteMin, li_AbsoluteMax )

//Initialize the seqs array with zeroes.
lca_Seqs [ li_AbsoluteMax ] = 0


IF lb_Finished = FALSE THEN

	li_Return = -1  //Will be reset to 1 if validation conditions are met
	lb_Finished = TRUE  //Will be reset to FALSE if validation conditions are met

	IF IsValid ( ads_Target ) THEN

		IF al_Row > 0 AND al_Row <= ads_Target.RowCount ( ) THEN
			li_Return = 1
			lb_Finished = FALSE
		END IF

	END IF

END IF


IF lb_Finished = FALSE THEN

	ls_EventType = ads_Target.Object.de_Event_Type [ al_Row ]

	This.of_GetIds ( ads_Target, al_Row, lla_ExistingIds, &
		FALSE /*Don't clear the array - No need to clear it, it's empty*/, &
		FALSE /*This option will be eliminated*/ )

	ls_ExistingMultiList = ads_Target.Object.de_Multi_List [ al_Row ]

END IF


////lb_Finished is used as an interior condition in this sequence, to simplify the condition
////structure.
//
//CHOOSE CASE ai_AssignmentType
//
//CASE gc_Dispatch.ci_ItinType_Driver
//
////	IF lb_Finished = FALSE THEN
////
////		CHOOSE CASE ai_PerspectiveType
////
////		CASE gc_Dispatch.ci_ItinType_PowerUnit
////			//OK
////
////		CASE ELSE
////			li_Return = -1
////			lb_Finished = TRUE
////
////		END CHOOSE
////
////	END IF
//
//	IF lb_Finished = FALSE THEN
//
//		CHOOSE CASE ls_EventType
//
//		CASE gc_Dispatch.cs_EventType_NewTrip
//
//			//If we encounter a NewTrip when assigning a Driver, disallow, 
//			//since allowing it to go through would constitute a double assignment,
//			//either of the same Driver or a different one.
//
//			//If we encounter a NewTrip when unassigning a Driver, disallow, 
//			//since there would have had to be a double assignment for this to happen, 
//			//ie, something's wrong with the event sequence.
//
//			li_Return = -1
//			lb_Finished = TRUE
//
//		END CHOOSE
//
//	END IF
//	
//CASE gc_Dispatch.ci_ItinType_PowerUnit
//
////	IF lb_Finished = FALSE THEN
////
////		CHOOSE CASE ai_PerspectiveType
////
////		CASE gc_Dispatch.ci_ItinType_Driver  //and possibly, TrailerChassis and Container,
////														//but not yet.
////			//OK
////
////		CASE ELSE
////			li_Return = -1
////			lb_Finished = TRUE
////
////		END CHOOSE
////
////	END IF
//
//	IF lb_Finished = FALSE THEN
//	
//		CHOOSE CASE ls_EventType
//	
//		CASE gc_Dispatch.cs_EventType_NewTrip
//	
//			//If we encounter a NewTrip when assigning a PowerUnit, disallow, 
//			//since allowing it to go through would constitute a double assignment,
//			//either of the same PowerUnit or a different one.
//
//			//If we encounter a NewTrip when unassigning a PowerUnit, disallow, 
//			//since there would have had to be a double assignment for this to happen, 
//			//ie, something's wrong with the event sequence.
//
//			li_Return = -1
//			lb_Finished = TRUE
//	
//		END CHOOSE
//
//	END IF
//
//CASE gc_Dispatch.ci_ItinType_TrailerChassis
//
////	IF lb_Finished = FALSE THEN
////
////		CHOOSE CASE ai_PerspectiveType
////
////		CASE gc_Dispatch.ci_ItinType_PowerUnit
////			//OK
////
////		CASE ELSE
////			li_Return = -1
////			lb_Finished = TRUE
////
////		END CHOOSE
////
////	END IF
////
////	IF lb_Finished = FALSE THEN    //Not sure what we were going to do here
////	
////		CHOOSE CASE ls_EventType
////	
////		CASE gc_Dispatch.cs_EventType_Hook
////
////		END CHOOSE
////
////	END IF
//
//CASE gc_Dispatch.ci_ItinType_Container
//
////	IF lb_Finished = FALSE THEN
////
////		CHOOSE CASE ai_PerspectiveType
////
////		CASE gc_Dispatch.ci_ItinType_PowerUnit
////			//OK
////
////		CASE ELSE
////			li_Return = -1
////			lb_Finished = TRUE
////
////		END CHOOSE
////
////	END IF
//
////CASE ELSE
//	//We're not assigning anything.  So be it.
//
//END CHOOSE

			
IF lb_Finished = FALSE THEN

	CHOOSE CASE ls_EventType

	CASE gc_Dispatch.cs_EventType_NewTrip

		CHOOSE CASE ai_AssignmentType

		CASE gc_Dispatch.ci_ItinType_Driver, gc_Dispatch.ci_ItinType_PowerUnit

			//If we encounter a NewTrip when assigning a Driver or PowerUnit, disallow, 
			//since allowing it to go through would constitute a double assignment,
			//either of the same Driver / PowerUnit or a different one.

			//If we encounter a NewTrip when unassigning a Driver or PowerUnit, disallow, 
			//since there would have had to be a double assignment for this to happen, 
			//ie, something's wrong with the event sequence.

			li_Return = -1
			lb_Finished = TRUE

		CASE gc_Dispatch.ci_ItinType_TrailerChassis, gc_Dispatch.ci_ItinType_Container

			CHOOSE CASE ai_PerspectiveType

			CASE gc_Dispatch.ci_ItinType_PowerUnit

				This.of_GetMinMaxIndex ( gc_Dispatch.ci_ItinType_Driver, li_Min, li_Max )
				li_Work = li_Min
	
				FOR li_Index = li_Min TO li_Max
	
					//If there's no existing id to set on this pass, continue.
	
					IF IsNull ( lla_ExistingIds [ li_Index ] ) THEN
						CONTINUE
					END IF
	
					//If the existing id is already in lla_Ids, continue.
	
					FOR li_Work = li_Min TO li_Max
	
						IF lla_Ids [ li_Work ] = lla_ExistingIds [ li_Index ] THEN
							CONTINUE
						END IF
	
					NEXT
	
					//The existing id isn't in lla_Ids.  We need to put it there.
					//lb_Slotted will be used to flag if we've found a place for it or not.

	
					lb_Slotted = FALSE
	
					FOR li_Work = li_Min TO li_Max
	
						IF IsNull ( lla_Ids [ li_Work ] ) THEN
							lla_Ids [ li_Work ] = lla_ExistingIds [ li_Index ]
							lb_Slotted = TRUE
							EXIT
						END IF
	
					NEXT
	
					//If we failed to find a slot for the existing id, we must fail.
	
					IF lb_Slotted = FALSE THEN
						li_Return = -1
						lb_Finished = TRUE
					END IF
	
				NEXT

			END CHOOSE

		END CHOOSE

	CASE gc_Dispatch.cs_EventType_EndTrip

		//If we're handling the assignment of a driver or power unit, that assignment will be ended by this
		//event.  So, flag that in ab_Dissociated.

		//If we're handling the unassignment of a driver or power unit, this event would have formerly 
		//performed the unassignment.  So, flag that in ab_Dissociated.

		//So, if we have an ai_AssignmentType of Driver or PowerUnit, whether we're processing an assignment 
		//or an unassignment, flag ab_Dissociated as TRUE.

		CHOOSE CASE ai_AssignmentType

		CASE gc_Dispatch.ci_ItinType_Driver, gc_Dispatch.ci_ItinType_PowerUnit

			ab_Dissociated = TRUE

		END CHOOSE

	CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Mount

		//If ab_Association = FALSE (ie, we're processing an unassignment) of a trailer or
		//container, and that trailer or container was being associated by this event, this 
		//constitutes a routing problem, so we'll fail.

		IF lb_Finished = FALSE AND ab_Association = FALSE THEN

			CHOOSE CASE ai_AssignmentType

			CASE gc_Dispatch.ci_ItinType_TrailerChassis, gc_Dispatch.ci_ItinType_Container

				IF This.of_IsInMultiList ( ls_ExistingMultiList, ai_AssignmentType, al_AssignmentId ) = TRUE THEN
					li_Return = -1
					lb_Finished = TRUE
				END IF

			END CHOOSE

		END IF

		//If we're hooking a trailer or container that's already in the incoming list,
		//we need to remove that trailer or container from the multilist assignment, 
		//UNLESS we're working from that trailer or container's perspective.

		IF lb_Finished = FALSE THEN

			IF Len ( ls_ExistingMultiList ) > 0 THEN
	
				This.of_ParseMultiList ( ls_ExistingMultiList, ls_TrailerList, ls_ContainerList )
	
				FOR li_Loop = 1 TO 2
	
					CHOOSE CASE li_Loop
		
					CASE 1
						This.of_GetMinMaxIndex ( gc_Dispatch.ci_ItinType_TrailerChassis, li_Min, li_Max )
						ls_Work = gc_Dispatch.cs_MultiListDelimiter + ls_TrailerList + gc_Dispatch.cs_MultiListDelimiter
	
					CASE 2
						This.of_GetMinMaxIndex ( gc_Dispatch.ci_ItinType_Container, li_Min, li_Max )
						ls_Work = gc_Dispatch.cs_MultiListDelimiter + ls_ContainerList + gc_Dispatch.cs_MultiListDelimiter
	
					END CHOOSE
	
					IF ls_Work = gc_Dispatch.cs_MultiListDelimiter + gc_Dispatch.cs_MultiListDelimiter THEN  //Just the two commas
						CONTINUE
					END IF
	
		
					FOR li_Index = li_Min TO li_Max
		
						IF IsNull ( lla_Ids [ li_Index ] ) THEN
	
							CONTINUE
	
						ELSEIF lla_Ids [ li_Index ] = al_PerspectiveId THEN
	
							//We potentially have an id/perpective id match, but we could be crossed up on driver/equipment.
							//Crosscheck the types, too.  If the types match, then the incoming id is the perspective id --
							//if that's in the multilist, fine -- continue if that's the case.
	
							IF This.of_GetTypeForIndex ( li_Index ) = ai_PerspectiveType THEN
								CONTINUE
							END IF						
	
						END IF
	
						//Replace the id in the work string (if present), as well as the padding commas, with just a comma
						ls_Work = lnv_String.of_GlobalReplace ( ls_Work, gc_Dispatch.cs_MultiListDelimiter +&
							String ( lla_Ids [ li_Index ] ) + gc_Dispatch.cs_MultiListDelimiter, &
							gc_Dispatch.cs_MultiListDelimiter )
	
					NEXT
	
					//Write the modified value back into the appropriate list variable.
					//Note : These will not be in a "clean" format -- they will have leading and/or trailing commas.
					//Those leading and trailing commas will be scrubbed by of_AssembleMultiList, below.
	
					CHOOSE CASE li_Loop
	
					CASE 1
						ls_TrailerList = ls_Work
	
					CASE 2
						ls_ContainerList = ls_Work
	
					END CHOOSE
	
				NEXT
	
				//Reassemble the new multilist from its two list parts
				ls_MultiList = This.of_AssembleMultiList ( ls_TrailerList, ls_ContainerList, &
					TRUE /*Scrub Originals -- Will affect values here!*/ )
	
			ELSE
				//Existing MultiList was empty -- the new one will be too.
				ls_MultiList = ""
	
			END IF

		END IF


		//Now, we need to write any trailers and containers actually being added to the id array.

		IF lb_Finished = FALSE THEN
	
			//First, the Trailers
	
			IF Len ( ls_TrailerList ) > 0 THEN
	
				//Note : of_ParseToArray WILL clear any existing values in lla_Work
				li_Count = lnv_String.of_ParseToArray ( ls_TrailerList, gc_Dispatch.cs_MultiListDelimiter, lla_Work )
	
				FOR li_Loop = 1 TO li_Count
	
					IF This.of_GetFirstAvailableIndex ( lla_Ids, gc_Dispatch.ci_ItinType_TrailerChassis, li_Index ) = 1 THEN
	
						lla_Ids [ li_Index ] = lla_Work [ li_Loop ]
	
					ELSE  //0, -1
						//There is no open slot in which to complete the assignment (or there was an error)
						li_Return = -1
						lb_Finished = TRUE
	
					END IF
	
				NEXT
	
			END IF

		END IF


		IF lb_Finished = FALSE THEN

			//Now, the Containers
	
			IF Len ( ls_ContainerList ) > 0 THEN
	
				//Note : of_ParseToArray WILL clear any existing values in lla_Work
				li_Count = lnv_String.of_ParseToArray ( ls_ContainerList, gc_Dispatch.cs_MultiListDelimiter, lla_Work )
	
				FOR li_Loop = 1 TO li_Count
	
					IF This.of_GetFirstAvailableIndex ( lla_Ids, gc_Dispatch.ci_ItinType_Container, li_Index ) = 1 THEN
	
						lla_Ids [ li_Index ] = lla_Work [ li_Loop ]
	
					ELSE  //0, -1
						//There is no open slot in which to complete the assignment (or there was an error)
						li_Return = -1
						lb_Finished = TRUE
	
					END IF
	
				NEXT
	
			END IF

		END IF

	CASE gc_Dispatch.cs_EventType_Drop, gc_Dispatch.cs_EventType_Dismount

		//If anything in the existing multilist has dropped out of the incoming list, we need to 
		//remove it from the multilist.  

		//If ab_Association = FALSE and that something is the AssignmentId (ie, the thing we're processing 
		//an unassignment of) then we need to flag ab_Dissociated to TRUE.

		//Parse the existing multilist into arrays of TrailerIds and ContainerIds

		IF lb_Finished = FALSE THEN

			IF This.of_ParseMultiList ( ls_ExistingMultiList, lla_Trailers, lla_Containers ) = 1 THEN
				//OK
			ELSE
				li_Return = -1
				lb_Finished = TRUE
			END IF

		END IF


		//Loop through the MultiList arrays and make sure that the ids there are still in the incoming
		//id list.  If they're not, we need to drop them from the multilist, so we'll null the value
		//in the multilist array, which will drop it from the list when it's reassembled.

		IF lb_Finished = FALSE THEN

			FOR li_Loop = 1 TO 2

				CHOOSE CASE li_Loop

				CASE 1
					li_Type = gc_Dispatch.ci_ItinType_TrailerChassis
					lla_Work = lla_Trailers
					li_Count = UpperBound ( lla_Work )

				CASE 2
					li_Type = gc_Dispatch.ci_ItinType_Container
					lla_Work = lla_Containers
					li_Count = UpperBound ( lla_Work )

				END CHOOSE

				FOR li_Work = 1 TO li_Count

					CHOOSE CASE This.of_GetAssignmentIndex ( lla_Ids, li_Type, lla_Work [ li_Work ], li_Index )

					CASE 1  
						//Id in MultiList was found in the incoming array, so it can stay in the MultiList
						//No action needed.

					CASE 0
						//Id in MultiList was not found in the incoming array, so it has to be removed.

						//But first, if we're processing an unassignment and the id in the multilist is the 
						//(un)assignment id then we need to flag ab_Dissociated = TRUE.

						IF ab_Association = FALSE AND li_Type = ai_AssignmentType AND &
							lla_Work [ li_Work ] = al_AssignmentId THEN

							ab_Dissociated = TRUE

						END IF

						//Now, we'll null the id in the work array, and it will then be ommitted when we reassemble 
						//the multilist from the work array, below.
						lla_Work [ li_Work ] = ll_Null

					CASE ELSE  //Error
						li_Return = -1
						lb_Finished = TRUE
						EXIT

					END CHOOSE

				NEXT

				//Assemble the updated multilist array into the respective list components
				//of the multilist string.  

				IF lb_Finished = FALSE THEN

					CHOOSE CASE li_Loop

					CASE 1
						lnv_String.of_ArrayToString ( lla_Work, gc_Dispatch.cs_MultiListDelimiter, ls_TrailerList )

					CASE 2
						lnv_String.of_ArrayToString ( lla_Work, gc_Dispatch.cs_MultiListDelimiter, ls_ContainerList )

					END CHOOSE

				END IF

			NEXT

		END IF


		//Assemble the two list components generated above into the new multilist string.

		IF lb_Finished = FALSE THEN

			ls_MultiList = This.of_AssembleMultiList ( ls_TrailerList, ls_ContainerList )

		END IF


		//If we're processing an assignment and that assignment should be dissociated by this event,
		//add the assignment id to the multilist.

		IF lb_Finished = FALSE AND ab_Association = TRUE THEN

			lb_AddToList = FALSE

			CHOOSE CASE ls_EventType
	
			CASE gc_Dispatch.cs_EventType_Drop
	
				CHOOSE CASE ai_AssignmentType

				CASE gc_Dispatch.ci_ItinType_TrailerChassis, gc_Dispatch.ci_ItinType_Container

					lb_AddToList = TRUE
					ab_Dissociated = TRUE

				END CHOOSE
	
			CASE gc_Dispatch.cs_EventType_Dismount

				CHOOSE CASE ai_AssignmentType

				CASE gc_Dispatch.ci_ItinType_Container

					//If no containers are already being dismounted by this event, dismount the
					//one were assigning.  (There's no reason we COULDN'T dismount the one we're
					//assigning even if there are others being dismounted, but I don't think that's
					//the routing functionality the user would want to have.)

					IF Len ( ls_ContainerList ) = 0 THEN

						lb_AddToList = TRUE
						ab_Dissociated = TRUE

					END IF

				END CHOOSE

			END CHOOSE

			IF lb_AddToList = TRUE THEN

				This.of_AddToMultiList ( ls_MultiList, ai_AssignmentType, al_AssignmentId, ls_MultiList )

			ELSE

				CHOOSE CASE ai_PerspectiveType

				CASE gc_Dispatch.ci_ItinType_TrailerChassis

					//If we're working from the perspective of a trailer that's being dropped,
					//then whatever has been assigned is being dissociated.
					//Otherwise, it's not.

					IF This.of_IdListFind ( ls_TrailerList, al_PerspectiveId ) = TRUE THEN
						ab_Dissociated = TRUE
					END IF

				CASE gc_Dispatch.ci_ItinType_Container

					//If we're working from the perspective of a container that's being dropped,
					//then whatever has been assigned is being dissociated.
					//Otherwise, it's not.

					IF This.of_IdListFind ( ls_ContainerList, al_PerspectiveId ) = TRUE THEN
						ab_Dissociated = TRUE
					END IF

				END CHOOSE

			END IF

		END IF


	END CHOOSE

END IF				


IF lb_Finished = FALSE THEN

	FOR li_Index = li_AbsoluteMin TO li_AbsoluteMax

		IF IsNull ( lla_ExistingIds [ li_Index ] ) AND IsNull ( lla_Ids [ li_Index ] ) THEN
			//Flag that we don't have to set the sequence for this index later.
			SetNull ( lca_Seqs [ li_Index ] )
			CONTINUE

		ELSEIF lla_ExistingIds [ li_Index ] = lla_Ids [ li_Index ] THEN
			//Flag that we don't have to set the sequence for this index later.
			SetNull ( lca_Seqs [ li_Index ] )
			CONTINUE

		ELSEIF IsNull ( lla_Ids [ li_Index ] ) THEN

			lca_Seqs [ li_Index ] = 0

		ELSE

			li_Type = This.of_GetTypeForIndex ( li_Index )

			lca_Seqs [ li_Index ] = This.of_GetSequenceByIndex &
				( li_Type, lla_Ids [ li_Index ], ads_Target, al_Row, Primary! )

//			This check would require multiple "exceptions" in the case of assgning a tractor
//			to an existing trailer range, since the driver and tractor would need to be assigned.
//			So, I'm going to skip this check and leave it up to the calling script to validate
//			that everything with an id ends up with a sequence number, once it's all done.

//			IF lca_Seqs [ li_Index ] = 0 THEN  //It didn't find a value
//
//				//If the id we're working on is the one that's just been assigned, then not
//				//finding a sequence value on the existing row is ok.  Otherwise, its not.
//
//				IF li_Type = ai_AssignmentType AND lla_Ids [ ll_Index ] = al_AssignmentId THEN
//					//OK
//				ELSE
//					li_Return = -1
//					lb_Finished = TRUE
//					EXIT
//				END IF
//
//			END IF

		END IF

	NEXT

END IF


IF lb_Finished = FALSE THEN

	FOR li_Index = li_AbsoluteMin TO li_AbsoluteMax

		IF NOT IsNull ( lca_Seqs [ li_Index ] ) THEN

			This.of_AssignByIndex ( li_Index, lla_Ids [ li_Index ], ads_Target, al_Row, &
				TRUE /*Assign Seq*/, lca_Seqs [ li_Index ] )

		END IF

	NEXT

	IF ls_MultiList = ls_ExistingMultiList THEN
		//No change -- no need to update it.
	ELSE
		ads_Target.Object.de_Multi_List [ al_Row ] = ls_MultiList
	END IF

END IF


RETURN li_Return
end function

public function integer of_getremainder (datastore ads_source, long al_sourcerow, integer ai_relativetotype, long al_relativetoid, ref long ala_ids[]);//Returns : 1, -1 (Error can be an outright processing error, or due to the fact that the
//event assignment isn't possible or doesn't make sense -- hooking a trailer when there
//are already 3 assigned, for example.)  In an error condition, what will be passed back
//is the remainder as if the event is a non-assignment event.

//For now, I'm staying with the old code's precedent of not clearing the reference array, 
//but instead just writing the first 9 entries into it.  I don't know if any code out
//there ever submitted a 10-entry array to of_WhatsLeft where it wouldn't want that tenth
//entry cleared, so until I can boil down the routing code and see for sure, I'm reluctant
//to mess with it.

Char		lch_Type
Integer	li_Index, &
			li_Count, &
			li_Loop, &
			li_Min, &
			li_Max
String	ls_MultiList, &
			ls_Work
n_cst_numerical	lnv_numerical

Long	ll_Null
SetNull ( ll_Null )

Boolean	lb_RelativeToOnly = FALSE
Boolean	lb_Finished = FALSE
Integer	li_Return = 1


IF lb_Finished = FALSE THEN

	if lnv_numerical.of_IsNullOrNotPos(al_SourceRow) or al_SourceRow > ads_Source.rowcount() then

		//The request is off the front or back end of what exists for the RelativeTo id.
		//So, just load al_RelativeToId into the result array at the appropriate position
		//based on its type.

		//Question : Why do we handle this this way for requests off the back end?
		//Wouldn't it make sense to just backtrack to the end and give that.
		//We'll have to look at situations where this might come up.
	
		lb_RelativeToOnly = TRUE
		lb_Finished = TRUE
	
	end if

END IF


IF lb_Finished = FALSE THEN

	//Read out all the values from the existing row that will be used below.
	//If the event in question is not an assignment event requiring special handling,
	//the values read into ala_Ids and as_MultiList will be the actual final results.
	//If the event is an assignment event needing special handling, these values will
	//be modified to get the final result, below.

	This.of_GetIds ( ads_Source, al_SourceRow, ala_Ids, FALSE /*Don't clear the array*/, &
		FALSE /*Don't include an entry for ActEq*/ )
	
	lch_Type = ads_Source.object.de_event_type[al_SourceRow]

END IF


IF lb_Finished = FALSE THEN

	CHOOSE CASE lch_Type
	
	//CASE gc_Dispatch.cs_EventType_NewTrip, gc_Dispatch.cs_EventType_Hook, &
		//gc_Dispatch.cs_EventType_Mount

		//No special handling is needed for these assignments.
	
	CASE gc_Dispatch.cs_EventType_EndTrip
	
		if ai_RelativeToType = gc_Dispatch.ci_ItinType_Driver then
			lb_RelativeToOnly = TRUE
		else
			FOR li_Index = gc_Dispatch.ci_MinIndex_Driver TO gc_Dispatch.ci_MaxIndex_Driver
				ala_Ids [ li_Index ] = ll_Null
			NEXT
		end if

	CASE gc_Dispatch.cs_EventType_Dismount, gc_Dispatch.cs_EventType_Drop

		//MultiList values indicate what to remove (TrailerChassis or Container)

		IF lb_Finished = FALSE THEN

			ls_MultiList = ads_Source.Object.de_Multi_List [ al_SourceRow ]

			IF This.of_ConsolidateMultiList ( ls_MultiList, ls_Work ) = 1 THEN
				//OK
			ELSE
				li_Return = -1
				lb_Finished = TRUE
			END IF

		END IF


		IF lb_Finished = FALSE THEN

			IF Len ( ls_Work ) > 0 THEN

				//Something to work on -- something to remove

				CHOOSE CASE ai_RelativeToType

				CASE gc_Dispatch.ci_ItinType_TrailerChassis, gc_Dispatch.ci_ItinType_Container

					//Request COULD BE relative to something being removed -- we need to check

					IF This.of_IdListFind ( ls_Work, al_RelativeToId ) = TRUE THEN

						//Reqest IS relative to something being removed -- only that will be left,
						//from it's perspective.

						lb_RelativeToOnly = TRUE
						lb_Finished = TRUE

					END IF

				END CHOOSE				

			ELSE
				lb_Finished = TRUE  //Nothing to remove
			END IF

		END IF


		IF lb_Finished = FALSE THEN

			//We need everything that's left with the things being removed taken out.
	
			FOR li_Loop = 1 TO 2   //2 ranges of the id list will be affected.

				CHOOSE CASE li_Loop

				CASE 1  //First, check the TrailerChassis range.
					This.of_GetMinMaxIndex ( gc_Dispatch.ci_ItinType_TrailerChassis, li_Min, li_Max )

				CASE 2  //Second, check the Container range.
					This.of_GetMinMaxIndex ( gc_Dispatch.ci_ItinType_Container, li_Min, li_Max )

				END CHOOSE

				li_Count = 0  //Count will track how many things have been retained this pass.
		
				FOR li_Index = li_Min TO li_Max  //Step through the respective ranges.
		
					IF IsNull ( ala_Ids [ li_Index ] ) THEN
						//Can't retain that -- Skip it
					ELSE

						//See if the id in question is in the removal list.

						IF This.of_IdListFind ( ls_Work, ala_Ids [ li_Index ] ) = TRUE THEN
							//It is to be removed -- Skip over writing it back into the list.
						ELSE
							//It is to be retained. Write it back into the list at the first
							//unoccupied position (we're overwriting the existing array as we go --
							//we'll clear any leftover positions after we're done with this loop.
							ala_Ids [ li_Min + li_Count ] = ala_Ids [ li_Index ]
							li_Count ++
						END IF
					END IF

				NEXT

				li_Min = li_Min + li_Count  //Point at the first unused position in the range
					//If the whole range was used, this pointer will be off the end of the range.

				FOR li_Index = li_Min TO li_Max  //Clear any unused portion of the range.

					ala_Ids [ li_Index ] = ll_Null

				NEXT

			NEXT

		END IF

	//CASE ELSE
		//For all other event types, do nothing (retain everything)

	END CHOOSE

END IF


IF lb_RelativeToOnly = TRUE AND li_Return = 1 THEN

	//The only thing left from al_RelativeToId's perspective is itself.

	//Null out the full possible range
	for li_Index = gc_Dispatch.ci_MinIndex_Driver to gc_Dispatch.ci_MaxIndex_Container
		ala_Ids[li_Index] = ll_Null
	next

	IF This.of_GetMinIndex ( ai_RelativeToType, li_Index ) = 1 THEN

		//Just write al_RelativeToId in at the first approprate position, based on its type.
		ala_Ids [ li_Index ] = al_RelativeToId

	ELSE
		li_Return = -1

	END IF

END IF

RETURN li_Return
end function

public function integer of_getassignmentindex (datastore ads_target, long al_row, integer ai_type, long al_id, ref integer ai_index);//Returns : 1 = Assignment index found, passed out in ai_Index
//0 = Not assigned, -1 = Error  (Null passed out in ai_Index for 0 and -1)

Integer	li_Min, &
			li_Max, &
			li_Index

Integer	li_Return = 0

SetNull ( ai_Index )

IF This.of_GetMinMaxIndex ( ai_Type, li_Min, li_Max ) = 1 THEN

	FOR li_Index = li_Min TO li_Max

		IF This.of_GetAssignmentByIndex ( ads_Target, al_Row, li_Index ) = al_Id THEN

			ai_Index = li_Index
			li_Return = 1

			EXIT

		END IF

	NEXT

	//If we go all the way through the loop without finding a match, allow li_Return 
	//to be 0 and ai_Index to be null.

ELSE
	li_Return = -1

END IF

RETURN li_Return
end function

public function integer of_addtomultilist (string as_multilist, integer ai_type, long al_id, ref string as_newmultilist);//Returns : 1 = Id successfully added, 0 = Id was already in list, no action taken, 
//-1 = Error, could not add id to list  (as_NewMultilist will be set to null in this case)

String	ls_TrailerList, &
			ls_ContainerList, &
			ls_Work

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF IsNull ( al_Id ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF This.of_ParseMultiList ( as_MultiList, ls_TrailerList, ls_ContainerList ) = 1 THEN
		//OK

	ELSE
		li_Return = -1

	END IF

END IF


IF li_Return = 1 THEN

	CHOOSE CASE ai_Type
	
	CASE gc_Dispatch.ci_ItinType_TrailerChassis

		ls_Work = ls_TrailerList
	
	CASE gc_Dispatch.ci_ItinType_Container
	
		ls_Work = ls_ContainerList
	
	CASE ELSE
	
		li_Return = -1
	
	END CHOOSE

END IF


IF li_Return = 1 THEN

	IF Len ( ls_Work ) > 0 THEN

		IF This.of_IdListFind ( ls_Work, al_Id ) = TRUE THEN
			li_Return = 0
		END IF

	END IF

	IF li_Return = 1 THEN

		ls_Work += gc_Dispatch.cs_MultiListDelimiter + String ( al_Id  )

	END IF

END IF


CHOOSE CASE li_Return

CASE 1

	CHOOSE CASE ai_Type
	
	CASE gc_Dispatch.ci_ItinType_TrailerChassis

		ls_TrailerList = ls_Work
	
	CASE gc_Dispatch.ci_ItinType_Container
	
		ls_ContainerList = ls_Work
	
	END CHOOSE

	as_NewMultiList = This.of_AssembleMultiList ( ls_TrailerList, ls_ContainerList, &
		FALSE /*Don't need to pass out scrubbed values*/ )

CASE 0
	as_NewMultiList = as_MultiList

CASE ELSE
	SetNull ( as_NewMultiList )

END CHOOSE


RETURN li_Return
end function

public function integer of_parsemultilist (string as_multilist, ref long ala_trailers[], ref long ala_containers[]);//Returns : 1, -1

String	ls_TrailerList, &
			ls_ContainerList
Long		lla_Trailers[], &
			lla_Containers[]
n_cst_String	lnv_String

Integer	li_Return = 1

IF This.of_ParseMultiList ( as_MultiList, ls_TrailerList, ls_ContainerList ) = 1 THEN

	lnv_String.of_ParseToArray ( ls_TrailerList, gc_Dispatch.cs_MultiListDelimiter, lla_Trailers )
	lnv_String.of_ParseToArray ( ls_ContainerList, gc_Dispatch.cs_MultiListDelimiter, lla_Containers )

ELSE
	li_Return = -1

END IF

//Regardless of whether we succeeded or failed, set the reference arrays (they'll be 
//empty if we failed.)
ala_Trailers = lla_Trailers
ala_Containers = lla_Containers

RETURN li_Return
end function

public function integer of_getassignmentindex (long ala_ids[], integer ai_type, long al_id, ref integer ai_index);//Returns : 1 = Assignment index found, passed out in ai_Index
//0 = Not assigned, -1 = Error  (Null passed out in ai_Index for 0 and -1)

Integer	li_Min, &
			li_Max, &
			li_Index

Integer	li_Return = 0

SetNull ( ai_Index )

IF This.of_GetMinMaxIndex ( ai_Type, li_Min, li_Max ) = 1 THEN

	FOR li_Index = li_Min TO li_Max

		IF ala_Ids [ li_Index ] = al_Id THEN

			ai_Index = li_Index
			li_Return = 1

			EXIT

		END IF

	NEXT

	//If we go all the way through the loop without finding a match, allow li_Return 
	//to be 0 and ai_Index to be null.

ELSE
	li_Return = -1

END IF

RETURN li_Return
end function

public function string of_assemblemultilist (string as_trailerlist, string as_containerlist);//Forward the request to the overloaded version, with the "pass scrubbed values"
//option turned off.

RETURN This.of_AssembleMultiList ( as_TrailerList, as_ContainerList, &
	FALSE /*Don't need to pass out scrubbed values*/ )
end function

public function boolean of_idlistfind (string as_idlist, long al_id);//Pads the leading and trailing ends of the IdList and the search string with the delimiter,
//so that the pos search will be accurate

Boolean	lb_Return

as_IdList = gc_Dispatch.cs_MultiListDelimiter + as_IdList + gc_Dispatch.cs_MultiListDelimiter

IF Pos ( as_IdList, gc_Dispatch.cs_MultiListDelimiter + String ( al_Id ) + gc_Dispatch.cs_MultiListDelimiter ) > 0 THEN
	lb_Return = TRUE
END IF

RETURN lb_Return
end function

public function integer of_unassign (datastore ads_target, long al_row, integer ai_type, long al_id);//Clears the assignment (or unassignment) of al_Id from the requested event, including 
//the reference in the multilist, if applicable, and the reference in the ids on the row.

//This means "clear the assignment (or unassignment) that this event is currently making 
//of this id.  It does not mean "clear this id from this event, even if it's not involved in
//an assignment."  If it turns out that the id is not on the event at all, or that it's not
//in the multilist for trailer/chassis or container on hooks/drops/mounts/dismounts, then
//we'll fail.

//Returns : 1, -1

String	ls_EventType, &
			ls_MultiList
Integer	li_Index, &
			li_Min, &
			li_Max, &
			li_Loop
Long		ll_Id, &
			ll_Null
Boolean	lb_AssignmentEvent = TRUE  //Assume true, but we'll check later.
Decimal {12}	lc_Seq

Integer	li_Return = 1

SetNull ( ll_Null )


IF li_Return = 1 THEN

	li_Return = -1  //If parameters are valid, value will be set back to 1, below.

	IF IsValid ( ads_Target ) THEN

		IF al_Row > 0 AND al_Row <= ads_Target.RowCount ( ) THEN
			li_Return = 1
		END IF

	END IF

END IF


IF li_Return = 1 THEN

	ls_EventType = ads_Target.Object.de_Event_Type [ al_Row ]

	CHOOSE CASE ls_EventType

	CASE gc_Dispatch.cs_EventType_NewTrip, gc_Dispatch.cs_EventType_EndTrip

		CHOOSE CASE ai_Type

		CASE gc_Dispatch.ci_ItinType_Driver, gc_Dispatch.ci_ItinType_PowerUnit
			//OK

		CASE ELSE
			li_Return = -1

		END CHOOSE

	CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Drop

		CHOOSE CASE ai_Type

		CASE gc_Dispatch.ci_ItinType_TrailerChassis, gc_Dispatch.ci_ItinType_Container

			//OK

			//Note : You can't unassign a tractor from a hook.  In order for the routing to be valid,
			//the event would have to be routed to a driver, and in this case, you'd have to 
			//unassign the driver from the New Trip, not from the hook.

		CASE ELSE
			li_Return = -1

		END CHOOSE


	CASE gc_Dispatch.cs_EventType_Mount, gc_Dispatch.cs_EventType_Dismount

		CHOOSE CASE ai_Type

		CASE gc_Dispatch.ci_ItinType_Container, gc_Dispatch.ci_ItinType_TrailerChassis //Allow Trailer/Chassis???
			//OK

		CASE ELSE
			li_Return = -1

		END CHOOSE


	CASE ELSE
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	IF This.of_IsTypeDeliverGroup ( ls_EventType ) THEN
		lb_AssignmentEvent = FALSE
	END IF

END IF


IF li_Return = 1 THEN

	IF This.of_GetMinMaxIndex ( ai_Type, li_Min, li_Max ) = 1 THEN
		//OK
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	CHOOSE CASE This.of_GetAssignmentIndex ( ads_Target, al_Row, ai_Type, al_Id, li_Index )

	CASE 1  //Id is assigned
		//OK -- The assignment value will be overwritten in the loop below.

	CASE 0  //Id is not assigned
		li_Return = -1

	CASE ELSE  //-1 : Error
		li_Return = -1

	END CHOOSE

END IF


//If we're unassigning from an AssignmentEvent, remove the id from the event, and shift the other ids 
//of the same type down to compensate.  

//If we're unassigning from an UnAssignmentEvent, we need to leave the id in, so we won't do this step.

IF li_Return = 1 AND lb_AssignmentEvent = TRUE THEN

	//If the position we're clearing is lower than the max, slide the Id and Seq values in the next-higher position
	//down to fill it, and so on until we've slid all the available values down.  If the position we're clearing
	//is the max, this loop will do nothing, and the max value will be cleared in the code that follows the loop.

	FOR li_Loop = li_Index TO ( li_Max - 1 )  //If li_Index = li_Max, loop won't do anything (see explanation above).

		//Pull the Id and Seq from the next-higher position index (the upper limit of the loop assures there is a higher index.)
		ll_Id = This.of_GetAssignmentByIndex ( ads_Target, al_Row, li_Loop + 1 )
		lc_Seq = This.of_GetSequenceByIndex ( li_Loop + 1, ll_Null, ads_Target, al_Row, Primary! )

		//Assign that Id and Seq to the position we're replacing.
		This.of_AssignByIndex ( li_Loop, ll_Id, ads_Target, al_Row, TRUE, lc_Seq )

	NEXT

	//Now that all the values are slid down, clear the Max position.)
	This.of_AssignByIndex ( li_Max, ll_Null, ads_Target, al_Row, TRUE, 0 )

END IF


IF li_Return = 1 THEN

	CHOOSE CASE ai_Type

	CASE gc_Dispatch.ci_ItinType_TrailerChassis, gc_Dispatch.ci_ItinType_Container

		ls_MultiList = ads_Target.Object.de_Multi_List [ al_Row ]

		CHOOSE CASE This.of_RemoveFromMultiList ( ls_MultiList, ai_Type, al_Id, ls_MultiList )

		CASE 1
			//The id was in the multilist, and was successfully removed.  Set the revised 
			//multilist back onto the target row.

			ads_Target.Object.de_Multi_List [ al_Row ] = ls_MultiList

		CASE 0
			//The id wasn't in the multilist, and so was not actually being assigned or unassigned
			//by this event.  Fail.

			li_Return = -1

		CASE ELSE
			//-1 (error), or unexpected return.  Fail.

			li_Return = -1

		END CHOOSE

	END CHOOSE

END IF


RETURN li_Return
end function

public function integer of_removefrommultilist (string as_multilist, integer ai_type, long al_id, ref string as_newmultilist);//Returns : 1 = Id successfully removed, 0 = Id was not in multilist, no action taken, 
//-1 = Error, could not remove id from list  (as_NewMultilist will be set to null in this case)

String	ls_TrailerList, &
			ls_ContainerList, &
			ls_Work
Integer	li_OldLen, &
			li_NewLen
n_cst_String	lnv_String

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF IsNull ( al_Id ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF This.of_ParseMultiList ( as_MultiList, ls_TrailerList, ls_ContainerList ) = 1 THEN
		//OK

	ELSE
		li_Return = -1

	END IF

END IF


IF li_Return = 1 THEN

	CHOOSE CASE ai_Type
	
	CASE gc_Dispatch.ci_ItinType_TrailerChassis

		ls_Work = ls_TrailerList
	
	CASE gc_Dispatch.ci_ItinType_Container
	
		ls_Work = ls_ContainerList
	
	CASE ELSE
	
		li_Return = -1
	
	END CHOOSE

END IF


IF li_Return = 1 THEN

	IF Len ( ls_Work ) > 0 THEN

		//Pad both ends of the work string with the delimiter character, so globalreplace will be simple.
		ls_Work = gc_Dispatch.cs_MultiListDelimiter + ls_Work + gc_Dispatch.cs_MultiListDelimiter

		//Record the work string's length before the replace operation, so we can compare to the length
		//after the operation, to see if we actually removed anything.
		li_OldLen = Len ( ls_Work )

		//Replace the sequence "Delimiter + Id + Delimiter" with just "Delimiter"
		ls_Work = lnv_String.of_GlobalReplace ( ls_Work, &
			gc_Dispatch.cs_MultiListDelimiter + String ( al_Id ) + gc_Dispatch.cs_MultiListDelimiter, &
			gc_Dispatch.cs_MultiListDelimiter )

		//Record the new length after the operation.
		li_NewLen = Len ( ls_Work )

		//Compare the two lengths.  If they're the same, we didn't change anything, ie the id wasn't in the list.
		IF li_OldLen = li_NewLen THEN
			li_Return = 0
		END IF

	ELSE
		//The id can't be in the list, since the list is empty.
		li_Return = 0

	END IF

END IF


CHOOSE CASE li_Return

CASE 1

	//We did remove the id from one of the two id lists.  We need to reassemble the multilist.

	CHOOSE CASE ai_Type
	
	CASE gc_Dispatch.ci_ItinType_TrailerChassis

		ls_TrailerList = ls_Work
	
	CASE gc_Dispatch.ci_ItinType_Container
	
		ls_ContainerList = ls_Work
	
	END CHOOSE

	as_NewMultiList = This.of_AssembleMultiList ( ls_TrailerList, ls_ContainerList, &
		FALSE /*Don't need to pass out scrubbed values*/ )

CASE 0
	//The id wasn't in the multilist.  So, we can pass out the original multilist, unchanged.
	as_NewMultiList = as_MultiList

CASE ELSE
	//We failed.  Pass out a null.
	SetNull ( as_NewMultiList )

END CHOOSE


RETURN li_Return
end function

public function boolean of_isinmultilist (string as_multilist, integer ai_type, long al_id);//Returns : TRUE, FALSE, Null  (Error, can't be determined.)

//The approach we use is to attemp an of_AddToMultiList, because that will tell
//us whether the requested id is already in the multilist.

String	ls_Work

Boolean	lb_Return = FALSE

CHOOSE CASE This.of_AddToMultiList ( as_MultiList, ai_Type, al_Id, ls_Work )

CASE 1

	//Added ok -- it wasn't in multilist
	//Allow lb_Return to be FALSE

CASE 0

	//Was already in multilist
	lb_Return = TRUE

CASE ELSE  //-1

	SetNull ( lb_Return )

END CHOOSE


RETURN lb_Return
end function

public function string of_getassociationtypes ();RETURN 	gc_Dispatch.cs_EventType_NewTrip + "~t" +&
			gc_Dispatch.cs_EventType_Hook + "~t" +&
			gc_Dispatch.cs_EventType_Mount
end function

public function string of_getdissociationtypes ();RETURN 	gc_Dispatch.cs_EventType_EndTrip + "~t" +&
			gc_Dispatch.cs_EventType_Drop + "~t" +&
			gc_Dispatch.cs_EventType_Dismount
end function

public function boolean of_istypeassociation (readonly char ach_type);//Returns: TRUE, FALSE, NULL if cannot be determined (ach_Type is null or invalid)
//(Passthrough return of of_EvaluateType)

RETURN This.of_EvaluateType ( ach_Type, This.of_GetAssociationTypes ( ) )
end function

public function boolean of_istypedissociation (readonly char ach_type);//Returns: TRUE, FALSE, NULL if cannot be determined (ach_Type is null or invalid)
//(Passthrough return of of_EvaluateType)

RETURN This.of_EvaluateType ( ach_Type, This.of_GetDissociationTypes ( ) )
end function

public function string of_getcontainermap (string as_trailer1type, long al_trailer1length, string as_trailer2type, long al_trailer2length, string as_trailer3type, long al_trailer3length, long al_container1length, long al_container2length, long al_container3length, long al_container4length);String	lsa_Segments[], &
			ls_Work
Long		lla_ContainerLengths[]
Integer	li_Count, &
			li_Index, &
			li_Segment
n_cst_String	lnv_String

lsa_Segments = { "00", "00", "00" }

lla_ContainerLengths [ 1 ] = al_Container1Length
lla_ContainerLengths [ 2 ] = al_Container2Length
lla_ContainerLengths [ 3 ] = al_Container3Length
lla_ContainerLengths [ 4 ] = al_Container4Length
li_Count = UpperBound ( lla_ContainerLengths )


CHOOSE CASE as_Trailer1Type

CASE "H", "F"  //Chassis, Flatbed

	//Can take containers.  How many?

	IF al_Trailer1Length >= 40 THEN

		//Stick with "00"

	ELSEIF al_Trailer1Length > 0 THEN

		lsa_Segments [ 1 ] = "05"

	//ELSE

		//Stick with "00"

	END IF

CASE IS > ""

	lsa_Segments [ 1 ] = "55"

END CHOOSE


CHOOSE CASE as_Trailer2Type

CASE "H", "F"  //Chassis, Flatbed

	//Can take containers.  How many?

	IF al_Trailer2Length >= 40 THEN

		//Stick with "00"

	ELSEIF al_Trailer2Length > 0 THEN

		lsa_Segments [ 2 ] = "05"

	//ELSE

		//Stick with "00"

	END IF

CASE IS > ""

	lsa_Segments [ 2 ] = "55"

END CHOOSE


CHOOSE CASE as_Trailer3Type

CASE "H", "F"  //Chassis, Flatbed

	//Can take containers.  How many?

	IF al_Trailer3Length >= 40 THEN

		//Stick with "00"

	ELSEIF al_Trailer3Length > 0 THEN

		lsa_Segments [ 3 ] = "05"

	//ELSE

		//Stick with "00"

	END IF

CASE IS > ""

	lsa_Segments [ 3 ] = "55"

END CHOOSE


FOR li_Index = 1 TO li_Count

	CHOOSE CASE lla_ContainerLengths [ li_Index ]

	CASE IS >= 40

		FOR li_Segment = 1 TO 3

			IF lsa_Segments [ li_Segment ] = "00" THEN
				lsa_Segments [ li_Segment ] = "11"
				EXIT
			END IF

		NEXT

	CASE IS > 0

		FOR li_Segment = 1 TO 3

			ls_Work = lsa_Segments [ li_Segment ]

			IF Left ( ls_Work, 1 ) = "0" THEN
				lsa_Segments [ li_Segment ] = "1" + Right ( ls_Work, 1 )
				EXIT
			ELSEIF Right ( ls_Work, 1 ) = "0" THEN
				lsa_Segments [ li_Segment ] = Left ( ls_Work, 1 ) + "2"
				EXIT
			END IF

		NEXT

	END CHOOSE

NEXT


FOR li_Segment = 1 TO 3
	lsa_Segments [ li_Segment ] = lnv_String.of_GlobalReplace ( lsa_Segments [ li_Segment ], "5", "0" )
NEXT

RETURN lsa_Segments [ 1 ] + lsa_Segments [ 2 ] + lsa_Segments [ 3 ]
end function

public function integer of_getinsertionpoint (datastore ads_target, integer ai_type, long al_id, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle, ref long al_insertionrow, ref string as_errormessage);//Determines the InsertionRow based on the insertion criteria supplied.

//ads_Target must contain a sequenced itinerary for the appropriate date range for ai_Type/al_Id.
//al_InsertionRow will be one greater than the number of rows in the datastore if the insertion
//point is off the end.  If there are no rows, it will be 1 (it should never be 0).  
//It will be null if we return -1.

//Returns : 1, -1

Long		ll_Row, &
			ll_InsertionCount
dwBuffer	le_Buffer

n_cst_beo_Event	lnv_FollowingEvent, &
						lnv_PreviousEvent, &
						lnv_Event
n_cst_OFRError		lnv_Error
String	ls_ErrorMessage = "Error determining insertion point."


Long		ll_InsertionRow
Integer	li_Return = 1


lnv_FollowingEvent = CREATE n_cst_beo_Event
lnv_PreviousEvent = CREATE n_cst_beo_Event
lnv_Event = CREATE n_cst_beo_Event

//Validate ads_Target, and get a RowCount

IF li_Return = 1 THEN

	IF IsValid ( ads_Target ) THEN
		ll_InsertionCount = ads_Target.RowCount ( )
	ELSE
		ls_ErrorMessage += "~n(Invalid target datastore.)"
		li_Return = -1
	END IF

END IF


//Find the insertion point

IF li_Return = 1 THEN

	CHOOSE CASE ai_InsertionStyle

	CASE gc_Dispatch.ci_InsertionStyle_Before

		//Any check to insure that the ad_InsertionDate makes sense for the event position indicated????
		//(This could be tricky with trips, when ad_InsertionDate is a dummy value.)

		lnv_FollowingEvent.of_SetSource ( ads_Target )
		lnv_FollowingEvent.of_SetSourceId ( al_InsertionEvent )

		IF lnv_FollowingEvent.of_GetSourceRow ( ll_Row, le_Buffer, FALSE /*Don't create*/ ) = 1 THEN

			IF le_Buffer = Primary! AND ll_Row > 0 THEN
				ll_InsertionRow = ll_Row  //The row to insert before is the FollowingEvent row
			ELSE
				ls_ErrorMessage += "~n(Invalid beo buffer/row -- Following Event, Pre-RM.)"
				li_Return = -1
			END IF

		ELSE
			ls_ErrorMessage += "~n(Could not resolve beo source -- Following Event, Pre-RM.)"
			li_Return = -1

		END IF

	CASE gc_Dispatch.ci_InsertionStyle_After

		//Any check to insure that the ad_InsertionDate makes sense for the event position indicated????
		//(This could be tricky with trips, when ad_InsertionDate is a dummy value.)

		lnv_PreviousEvent.of_SetSource ( ads_Target )
		lnv_PreviousEvent.of_SetSourceId ( al_InsertionEvent )

		IF lnv_PreviousEvent.of_GetSourceRow ( ll_Row, le_Buffer, FALSE /*Don't create*/ ) = 1 THEN

			IF le_Buffer = Primary! AND ll_Row > 0 THEN
				ll_InsertionRow = ll_Row + 1  //The row to insert before is the row after the PreviousEvent
			ELSE
				ls_ErrorMessage += "~n(Invalid beo buffer/row -- Previous Event, Pre-RM.)"
				li_Return = -1
			END IF

		ELSE
			ls_ErrorMessage += "~n(Could not resolve beo source -- Previous Event, Pre-RM.)"
			li_Return = -1

		END IF

	//Note:  Difference between StartOfDay and EndOfDay script is >= vs >

	CASE gc_Dispatch.ci_InsertionStyle_StartOfDay

		//Note:  ad_InsertionDate value is required for this route style, except for ItinType Trip.

		IF IsNull ( ad_InsertionDate ) THEN

			CHOOSE CASE ai_Type

			CASE gc_Dispatch.ci_ItinType_Trip
				//Route at the beginning of the trip
				ll_InsertionRow = 1

			CASE ELSE
				ls_ErrorMessage += "~n(Target Date is required for Start-of-Day routing.)"
				li_Return = -1

			END CHOOSE

		ELSE
			ll_Row = ads_Target.Find ( "de_arrdate >= " + String ( ad_InsertionDate, "yyyy-mm-dd" ), &
				1, ll_InsertionCount )

			IF ll_Row > 0 THEN
				ll_InsertionRow = ll_Row  //Insert before the row we just found.
			ELSEIF ll_Row = 0 THEN
				IF ai_Type = gc_Dispatch.ci_ItinType_Trip THEN
					//Insert at the beginning of the trip.
					ll_InsertionRow = 1
				ELSE
					//There aren't any events that should come after the ones to be inserted.  Put them at the end.
					ll_InsertionRow = ll_InsertionCount + 1
				END IF
			ELSE  //Error
				ls_ErrorMessage += "~n(Error finding Start-of-Day.)"
				li_Return = -1
			END IF

		END IF

	CASE gc_Dispatch.ci_InsertionStyle_EndOfDay

		//Note:  ad_InsertionDate value is required for this route style, except for ItinType Trip.

		IF IsNull ( ad_InsertionDate ) THEN

			CHOOSE CASE ai_Type

			CASE gc_Dispatch.ci_ItinType_Trip
				ll_InsertionRow = ll_InsertionCount + 1  //Add to the end of the trip

			CASE ELSE
				ls_ErrorMessage += "~n(Target Date is required for End-of-Day routing.)"
				li_Return = -1

			END CHOOSE

		ELSE
			ll_Row = ads_Target.Find ( "de_arrdate > " + String ( ad_InsertionDate, "yyyy-mm-dd" ), &
				1, ll_InsertionCount )

			IF ll_Row > 0 THEN
				ll_InsertionRow = ll_Row  //Insert before the row we just found.
			ELSEIF ll_Row = 0 THEN
				ll_InsertionRow = ll_InsertionCount + 1  //Add at the end.
			ELSE  //Error
				ls_ErrorMessage += "~n(Error finding End-of-Day.)"
				li_Return = -1
			END IF

		END IF

	CASE gc_Dispatch.ci_InsertionStyle_StartOfRoute

		ls_ErrorMessage += "~n(Start-of-Route not yet supported.)"
		li_Return = -1

	CASE gc_Dispatch.ci_InsertionStyle_StartOfTrip

		ls_ErrorMessage += "~n(Start-of-Trip not yet supported.)"
		li_Return = -1

	CASE gc_Dispatch.ci_InsertionStyle_EndOfRoute, gc_Dispatch.ci_InsertionStyle_EndOfTrip

		//EndOfRoute is intended for non-assignment events.  It will choose an insertion point inside the 
		//final drop or dismount, if there is one, or inside the final end trip, if no drop/dismount is present.

		//EndOfTrip can be used for both assignment and non-assignment events, although it should typically be used
		//instead of EndOfRoute when asssignment events are involved.  It will choose an insertionpoint inside the
		//final EndTrip, if there is one.

		IF IsNull ( ad_InsertionDate ) THEN
			ll_InsertionRow = 0
		ELSE
			ll_InsertionRow = ads_Target.Find ( "de_arrdate > " + String ( ad_InsertionDate, "yyyy-mm-dd" ), &
				1, ll_InsertionCount )
		END IF

		IF ll_InsertionRow = 0 THEN
			//There aren't any events after the insertion date.  Add at the end.
			ll_InsertionRow = ll_InsertionCount + 1
		END IF

		IF ll_InsertionRow > 1 THEN   

			//There are rows ahead of the insertion row (although not necessarily on the target day.)
			//Look at the end of the day to see if there are events we should route inside of.

			DO

				lnv_Event.of_SetSource ( ads_Target )
				lnv_Event.of_SetSourceRow ( ll_InsertionRow - 1 )

				IF lnv_Event.of_HasSource ( ) = FALSE THEN
					EXIT
				END IF

				IF lnv_Event.of_GetDateArrived ( ) < ad_InsertionDate THEN
					EXIT
					//Note: If DateArrived is null in a trip, this will not evaluate to true.
					//So, insertion will be able to happen ahead of events with null dates, 
					//if the types are right.  Of course, right now we can't have the "right"
					//types in trips anyway, so it's a moot point.
				END IF

				IF lnv_Event.of_IsType ( gc_Dispatch.cs_EventType_EndTrip ) THEN
					//Route before this event for both EndOfRoute and EndOfTrip -- proceed to next cycle in loop.
				ELSEIF ai_InsertionStyle = gc_Dispatch.ci_InsertionStyle_EndOfTrip THEN
					//We don't want to go inside of any other event types for this insertionstyle.
					//Exit the loop and insert where we are.
					EXIT
				ELSEIF lnv_Event.of_IsType ( gc_Dispatch.cs_EventType_Drop ) THEN
					//Route before this event for EndOfRoute style -- proceed to next cycle in loop.
				ELSEIF lnv_Event.of_IsType ( gc_Dispatch.cs_EventType_Dismount ) THEN
					//Route before this event for EndOfRoute style -- proceed to next cycle in loop.
				ELSE
					//We don't want to go inside of any other event types for this insertionstyle.
					//Exit the loop and insert where we are.
					EXIT
				END IF

				ll_InsertionRow --

			LOOP WHILE ll_InsertionRow > 1


		ELSEIF ll_InsertionRow = 1 THEN

			//That's the only legitimate insertion point.  Use it.

		ELSE  //Error  -- Insertion row should not be zero or negative, based on logic above.
			ls_ErrorMessage += "~n(Error finding End-of-Route.)"
			li_Return = -1

		END IF

	CASE gc_Dispatch.ci_InsertionStyle_EmptyDay

		//If there are no rows in the target itinerary on the insertion date, we'll insert at
		//that point in the itinerary (ie, between any events on prior and following days.)
		//If there are rows in the target itinerary on the insertion date, we'll have to fail --
		//the calling script must supply an insertion point in this scenario.

		//So, we'll see if we can come up with a valid insertion point, as described above.


		IF ai_Type = gc_Dispatch.ci_ItinType_Trip THEN
			//Not supported -- (although it could be ??)
			ls_ErrorMessage += "~n(Empty-Day routing is not supported for trips.)"
			li_Return = -1

		ELSEIF IsNull ( ad_InsertionDate ) THEN
			ls_ErrorMessage += "~n(Target Date is required for Empty-Day routing.)"
			li_Return = -1

		ELSE

			//Find the first event on or after the insertion date.

			ll_Row = ads_Target.Find ( "de_arrdate >= " + String ( ad_InsertionDate, "yyyy-mm-dd" ), &
				1, ll_InsertionCount )

	
			//Evaluate what we found.
	
			CHOOSE CASE ll_Row
	
			CASE IS > 0
	
				//We found an event.  See whether it's on, or after, the assignment date.
	
				IF DaysAfter ( ad_InsertionDate, ads_Target.Object.de_ArrDate [ ll_Row ] ) > 0 THEN
					//It's after the assignment date, so we're ok.  Insert before the row we just found.
					ll_InsertionRow = ll_Row
				ELSE
					//The event we found is routed on the day we want to assign to.  This is not allowed.
					//The calling script must provide an insertion point in this scenario.
	
					ls_ErrorMessage += "~n(There are events in the target itinerary on the "+&
						"requested date.  An insertion point is required.) (IPRQ)"  //(IPRQ) is a flag
						//that the calling script can check to see if the assignment failed for this reason.
					li_Return = -1
	
				END IF

			CASE 0
	
				//There are no rows in the target itinerary on or after the assignment date.
				//So, we'll route to the end of the itinerary.
				ll_InsertionRow = ll_InsertionCount + 1

			CASE ELSE  //Error
				ls_ErrorMessage += "~n(Error finding Empty-Day insertion point.)"
				li_Return = -1

			END CHOOSE

		END IF

	CASE ELSE
		//Unexpected InsertionStyle value
		ls_ErrorMessage += "~n(Unexpected insertion style value.)"
		li_Return = -1

	END CHOOSE

END IF


//Set the reference parameters, depending on our results.

IF li_Return = 1 THEN
	al_InsertionRow = ll_InsertionRow
	as_ErrorMessage = ""
ELSE
	SetNull ( al_InsertionRow )
	as_ErrorMessage = ls_ErrorMessage
END IF


DESTROY lnv_FollowingEvent 
DESTROY lnv_PreviousEvent 
DESTROY lnv_Event

RETURN li_Return
end function

public function integer of_resettimes (datastore ads_target, string as_context, date ad_context);//this method was overloaded to allow calling the overloaded with a route type

//this one calls the overloaded with a route type = 0 which was the 'normal' processing


RETURN this.of_ResetTimes(ads_target, as_context, ad_context, 0 )
end function

public function integer of_getinsertionpoint (datastore ads_base, integer ai_basetype, long al_baseid, long al_baseevent, datastore ads_target, integer ai_targettype, long al_targetid, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle, ref long al_insertionrow, ref string as_errormessage);//Returns : 1, -1

Long		ll_BaseRow, &
			ll_BaseCount, &
			ll_AfterEvent, &
			ll_BeforeEvent, &
			ll_Row, &
			ll_InsertionRow, &
			ll_BestCandidate, &
			lla_Ids[]
Integer	li_AssignmentIndex
Date		ld_BaseDate
String	ls_Work, &
			ls_ErrorMessage = "Error determining insertion point for assignment."
n_cst_beo_Event	lnv_BaseEvent, &
						lnv_Event
n_cst_AnyArraySrv	lnv_Arrays

Boolean	lb_Finished = FALSE
Integer	li_Return = 1

lnv_BaseEvent = CREATE n_cst_beo_Event
lnv_Event = CREATE n_cst_beo_Event


IF li_Return = 1 AND lb_Finished = FALSE THEN

	CHOOSE CASE ai_InsertionStyle

	CASE gc_Dispatch.ci_InsertionStyle_Assignment
		//OK

	CASE ELSE
		//The requested insertion style is not supported by this version of the function.
		ls_ErrorMessage += "~n(Invalid insertion style.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_Finished = FALSE THEN

	IF IsValid ( ads_Base ) THEN
		ll_BaseCount = ads_Base.RowCount ( )
	ELSE
		ls_ErrorMessage += "~n(Invalid base datastore.)"
		li_Return = -1
	END IF

END IF


IF li_Return = 1 AND lb_Finished = FALSE THEN

	IF IsValid ( ads_Target ) THEN
		//OK
	ELSE
		ls_ErrorMessage += "~n(Invalid target datastore.)"
		li_Return = -1
	END IF

END IF


IF li_Return = 1 AND lb_Finished = FALSE THEN

	lnv_BaseEvent.of_SetSource ( ads_Base )
	lnv_BaseEvent.of_SetSourceId ( al_BaseEvent )

	//Try to get a source row, allowing only the primary buffer.

	ll_BaseRow = lnv_BaseEvent.of_GetSourceRow ( )

	IF ll_BaseRow > 0 THEN
		//OK
	ELSE
		ls_ErrorMessage += "~n(Could not identify base row.)"
		li_Return = -1
	END IF

END IF


IF li_Return = 1 AND lb_Finished = FALSE THEN

	ld_BaseDate = lnv_BaseEvent.of_GetDateArrived ( )

	IF IsNull ( ld_BaseDate ) THEN
		ls_ErrorMessage += "~n(Null base event date.)"
		li_Return = -1
	ELSE
		ld_BaseDate = Date ( DateTime ( ld_BaseDate ) )
	END IF

END IF


//This section was part of the original logic, but was commented in 4.0.b16 10-26-04 BKW.
//If we routed the first leg of a container & chassis move to one driver, the 2nd leg to another driver, 
//and the third leg to the first driver, all on the same day, the sequencing in the container & chassis
//itineraries would come out 1-3-2, not 1-2-3, because the assignment of the container & chassis to leg 2
//would find an insertion point after the drop event of leg 1, using this logic.  In addition to being wrong 
//in the container & chassis itineraries if someone looked at them or you ran reports, this was causing a problem
//in the equipment summary because the confirmations would then be out of sequence and the position at leg 3
//would not be reflected in the summary -- it would keep showing at the drop in leg 2, because that was the
//"last" event in the trailer & container itineraries.

/*
//Walk backwards through the day the base event is on to see if the target is associated earlier
//in the day.

IF li_Return = 1 AND lb_Finished = FALSE THEN

	lnv_Event.of_SetSource ( ads_Base )

	FOR ll_Row = ll_BaseRow TO 1 STEP -1

		lnv_Event.of_SetSourceRow ( ll_Row )

		IF lnv_Event.of_GetDateArrived ( ) < ld_BaseDate THEN
			EXIT
		END IF

		IF This.of_GetAssignmentIndex ( ads_Base, ll_Row, ai_TargetType, al_TargetId, &
			li_AssignmentIndex ) > 0 THEN

			//The target is assigned on this row.  Try inserting after this event on the target.

			ll_AfterEvent = lnv_Event.of_GetId ( )
			EXIT

		END IF

	NEXT

END IF


//If the target was associated earlier in the day, find an IP after that point.

IF li_Return = 1 AND lb_Finished = FALSE AND ll_AfterEvent > 0 THEN

	CHOOSE CASE This.of_GetInsertionPoint ( ads_Target, ai_TargetType, al_TargetId, ad_InsertionDate, &
		ll_AfterEvent, gc_Dispatch.ci_InsertionStyle_After, ll_InsertionRow, ls_Work )

	CASE 1

		//We could add another step that will look forward in the target to see if we should move the IP forward at all.
		//But, for now, I'm going to use this as-is.

		//ll_InsertionRow contains the desired IP
		lb_Finished = TRUE

	CASE -1
		ls_ErrorMessage += "~n(Could not locate after-IP in target datastore.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return value.
		ls_ErrorMessage += "~n(Unexpected return value attempting to locate after-IP in target datastore.)"
		li_Return = -1

	END CHOOSE

END IF
*/


//If we don't have an IP yet, walk forwards through the day the base event is on to see if the target
//is associated later in the day.

IF li_Return = 1 AND lb_Finished = FALSE THEN

	lnv_Event.of_SetSource ( ads_Base )

	FOR ll_Row = ll_BaseRow + 1 TO ll_BaseCount

		lnv_Event.of_SetSourceRow ( ll_Row )

		IF Date ( DateTime ( lnv_Event.of_GetDateArrived ( ) ) ) > ld_BaseDate THEN
			EXIT
		END IF

		IF This.of_GetAssignmentIndex ( ads_Base, ll_Row, ai_TargetType, al_TargetId, &
			li_AssignmentIndex ) > 0 THEN

			//The target is assigned on this row.  Try inserting before this event on the target.

			ll_BeforeEvent = lnv_Event.of_GetId ( )
			EXIT

		END IF

	NEXT

END IF


//If we don't have an IP yet and the target was associated later in the day, find an IP before that point.

IF li_Return = 1 AND lb_Finished = FALSE AND ll_BeforeEvent > 0 THEN

	CHOOSE CASE This.of_GetInsertionPoint ( ads_Target, ai_TargetType, al_TargetId, ad_InsertionDate, &
		ll_BeforeEvent, gc_Dispatch.ci_InsertionStyle_Before, ll_InsertionRow, ls_Work )

	CASE 1

		//We could add another step that will look backward in the target to see if we should move the IP back at all.
		//But, for now, I'm going to use this as-is.

		//ll_InsertionRow contains the desired IP
		lb_Finished = TRUE

	CASE -1
		ls_ErrorMessage += "~n(Could not locate before-IP in target datastore.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return value.
		ls_ErrorMessage += "~n(Unexpected return value attempting to locate before-IP in target datastore.)"
		li_Return = -1

	END CHOOSE

END IF


//If nothing else has worked, look for points at which nothing is assigned to the target, 
//going from the end-of-day backwards.  If you get a point like this, use it.

//Note : I considered comparing the locations for the row prior to the potential IP and the 
//base event.  If the locations matched up, I would use the IP.  If the locations didn't match,
//I'd keep looking, but come back to the first match if I didn't get a better one.  I didn't use 
//this because it would only work for inserting a block after another block based on location, 
//but would not be able to determine that a block should go ahead of another block, because we
//only have the first base row, not the last base row, so we can't tell where the base block 
//ends up.  The user would be unlikely to be able to distinguish/predict this behavior, so it's
//probably better that it just goes to the first open slot (from the bottom) on the day of the base event.

IF li_Return = 1 AND lb_Finished = FALSE THEN

	//Get the end-of-day row.

	CHOOSE CASE This.of_GetInsertionPoint ( ads_Target, ai_TargetType, al_TargetId, ad_InsertionDate, &
		0 /*Event*/, gc_Dispatch.ci_InsertionStyle_EndOfDay, ll_InsertionRow, ls_Work )

	CASE 1

		//Initialize the ll_BestCandidate variable for use in the loop below.
		ll_BestCandidate = 0

		lnv_Event.of_SetSource ( ads_Target )

		//Loop backwards from the row before the end-of-day point, checking the remainder to see if it 
		//consists only of the target (ie, the target is not assigned to anything there.)

		FOR ll_Row = ll_InsertionRow - 1 TO 0 STEP -1

			CHOOSE CASE This.of_GetRemainder ( ads_Target, ll_Row, ai_TargetType, al_TargetId, lla_Ids )

			CASE 1

				IF lnv_Arrays.of_GetShrinked ( lla_Ids, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ ) = 1 THEN

					//There's only one element in the shrunk array, ie. the target is all by itself.
					//This is a candidate to be the IP.

					//Since we're not checking locations or any other criteria, this IS the IP.

					//The insertion point will be the row after the IP.  Record it and exit.
					ll_BestCandidate = ll_Row + 1
					EXIT

				END IF

			//CASE ELSE ????

			END CHOOSE


			//If the event we just checked is prior to the base date, we have to stop, 
			//because it would not be acceptable to insert ahead of it.

			lnv_Event.of_SetSourceRow ( ll_Row )
	
			IF lnv_Event.of_GetDateArrived ( ) < ld_BaseDate THEN
				EXIT
			END IF

		NEXT

		IF ll_BestCandidate > 0 THEN
			ll_InsertionRow = ll_BestCandidate
			lb_Finished = TRUE
		ELSE
			ls_ErrorMessage = "Cannot assign target."+&
				"~n(The target is already assigned on the date requested.)"
			li_Return = -1
		END IF

	CASE -1
		ls_ErrorMessage += "~n(Could not locate end-of-day in target datastore.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return value.
		ls_ErrorMessage += "~n(Unexpected return value attempting to locate end-of-day in target datastore.)"
		li_Return = -1

	END CHOOSE

END IF


//This probably shouldn't happen, but j.i.c.

IF li_Return = 1 AND lb_Finished = FALSE THEN
	ls_ErrorMessage += "~n(No options were successful.)"
	li_Return = -1
END IF


//Set the reference parameters, depending on our results.

IF li_Return = 1 THEN
	al_InsertionRow = ll_InsertionRow
	as_ErrorMessage = ""
ELSE
	SetNull ( al_InsertionRow )
	as_ErrorMessage = ls_ErrorMessage
END IF

DESTROY lnv_BaseEvent 
DESTROY lnv_Event

RETURN li_Return
end function

public function string of_getinterchangecapabletypes ();RETURN 	gc_Dispatch.cs_EventType_Hook + "~t" +&
			gc_Dispatch.cs_EventType_Drop + "~t" +&
			gc_Dispatch.cs_EventType_Mount + "~t" +&
			gc_Dispatch.cs_EventType_Dismount
end function

public function boolean of_istypeinterchangecapable (character ach_type);//Returns: TRUE, FALSE, NULL if cannot be determined (ach_Type is null or invalid)
//(Passthrough return of of_EvaluateType)

RETURN This.of_EvaluateType ( ach_Type, This.of_GetInterchangeCapableTypes ( ) )
end function

public function string of_gettypedisplayvalueshort (character ach_datavalue);n_cst_String	lnv_String

String	ls_DataValue, &
			ls_CodeTable, &
			ls_Display

ls_DataValue = String ( ach_DataValue )
ls_CodeTable = This.of_GetTypeCodeTableShort ( )

ls_Display = lnv_String.of_GetCodeTableDisplayValue ( ls_DataValue, ls_CodeTable )

RETURN ls_Display
end function

public function string of_gettypecodetableshort ();Constant String	ls_CodeTable = &
	"PU~t" + gc_Dispatch.cs_EventType_Pickup + "/"+&
	"DL~t" + gc_Dispatch.cs_EventType_Deliver + "/"+&
	"NT~t" + gc_Dispatch.cs_EventType_NewTrip + "/"+&
	"ET~t" + gc_Dispatch.cs_EventType_EndTrip + "/"+&
	"HK~t" + gc_Dispatch.cs_EventType_Hook + "/"+&
	"DR~t" + gc_Dispatch.cs_EventType_Drop + "/"+&
	"MT~t" + gc_Dispatch.cs_EventType_Mount + "/"+&
	"DM~t" + gc_Dispatch.cs_EventType_Dismount + "/"+&
	"BT~t" + gc_Dispatch.cs_EventType_Bobtail + "/"+&
	"DH~t" + gc_Dispatch.cs_EventType_Deadhead + "/"+&
	"RE~t" + gc_Dispatch.cs_EventType_Reposition + "/"+&
	"MS~t" + gc_Dispatch.cs_EventType_Misc + "/"+&
	"CC~t" + gc_Dispatch.cs_EventType_CheckCall + "/"+&
	"PR~t" + gc_Dispatch.cs_EventType_PositionReport + "/"+&
	"BD~t" + gc_Dispatch.cs_EventType_Breakdown + "/"+&
	"PM~t" + gc_Dispatch.cs_EventType_PMService + "/"+&
	"RS~t" + gc_Dispatch.cs_EventType_Repairs + "/"+&
	"AC~t" + gc_Dispatch.cs_EventType_Accident + "/"+&
	"DT~t" + gc_Dispatch.cs_EventType_DOT + "/"+&
	"SC~t" + gc_Dispatch.cs_EventType_Scale + "/"+&
	"OD~t" + gc_Dispatch.cs_EventType_OffDuty + "/"+&
	"SL~t" + gc_Dispatch.cs_EventType_Sleeper + "/"


RETURN 	ls_CodeTable
end function

public function string of_gettypecodetableforshipment ();
Constant String	ls_CodeTable = &
	"PICKUP~t" + gc_Dispatch.cs_EventType_Pickup + "/"+&
	"DELIVER~t" + gc_Dispatch.cs_EventType_Deliver + "/"+&
	"HOOK~t" + gc_Dispatch.cs_EventType_Hook + "/"+&
	"DROP~t" + gc_Dispatch.cs_EventType_Drop + "/"+&
	"MOUNT~t" + gc_Dispatch.cs_EventType_Mount + "/"+&
	"DISMOUNT~t" + gc_Dispatch.cs_EventType_Dismount + "/"+&
	"YARD DROP~t" + gc_Dispatch.cs_EventAction_YardMove + "/"+&
	"CHASSIS SPLIT~t" + gc_Dispatch.cs_EventAction_ChassisSplit + "/"+&
	"CROSS DOCK~t" + gc_Dispatch.cs_EventAction_CrossDock + "/"

RETURN 	ls_CodeTable
end function

public function boolean of_hasfrontchassissplit (powerObject apo_source);Long		ll_RowCount
Boolean	lb_Return
Boolean	lb_Continue = TRUE

n_cst_beo_Event	lnv_Event1
n_cst_beo_Event	lnv_Event2
n_cst_Dws			lnv_Dws
PowerObject			lpo_Source

lpo_Source = apo_source


lnv_Event1 = CREATE n_cst_beo_Event
lnv_Event2 = CREATE n_cst_beo_Event

lb_Continue = isValid ( lpo_Source )


IF lb_Continue THEN
	ll_RowCount = lnv_Dws.of_RowCount ( lpo_Source )

	IF ll_RowCount > 1 THEN
		lnv_Event1.of_SetSource ( lpo_Source )
		lnv_Event1.of_SetSourceRow ( 1 ) 
		
		lnv_Event2.of_SetSource ( lpo_Source )
		lnv_Event2.of_SetSourceRow ( 2 ) 
			
		lb_Return =  ( lnv_Event1.of_GetType ( ) = gc_Dispatch.cs_EventType_HOOK AND &
		               lnv_Event2.of_GetType ( ) = gc_Dispatch.cs_EventType_MOUNT	)
		
	END IF
END IF


DESTROY ( lnv_Event1 ) 
DESTROY ( lnv_Event2 ) 

RETURN lb_Return
	
	





end function

public function boolean of_hasbackchassissplit (powerobject apo_source);Long					ll_RowCount
Boolean				lb_Return
Boolean				lb_Continue = TRUE
n_cst_dws			lnv_Dws
n_cst_beo_Event	lnv_Event1
n_cst_beo_Event	lnv_Event2
PowerObject			lpo_Source

lpo_Source = apo_source

lnv_Event1 = CREATE n_cst_beo_Event
lnv_Event2 = CREATE n_cst_beo_Event

lb_Continue = isValid ( apo_source )


IF lb_Continue THEN
	ll_RowCount = lnv_Dws.of_RowCount ( apo_source ) 

	IF ll_RowCount >= 3 THEN
		lnv_Event1.of_SetSource ( apo_source )
		lnv_Event1.of_SetSourceRow ( ll_RowCount - 1 ) 
		
		lnv_Event2.of_SetSource ( apo_source )
		lnv_Event2.of_SetSourceRow ( ll_RowCount ) 
			
		lb_Return = lnv_Event1.of_GetType ( ) = gc_Dispatch.cs_EventType_Dismount AND &
		            lnv_Event2.of_GetType ( ) = gc_Dispatch.cs_EventType_Drop	
	
	END IF
END IF


DESTROY ( lnv_Event1 ) 
DESTROY ( lnv_Event2 ) 

RETURN lb_Return
	
	





end function

public function integer of_getbackchassissplitsites (ref long al_dismountid, ref long al_dropid, powerobject apo_source);// Returns -1 on error
//				0 if there is no split
//				1 on success
//

Long	ll_DismountID
Long	ll_DropID
Int	li_Return = 0

IF Not isValid ( apo_Source ) THEN
	li_Return = -1
ELSE
	
	IF THIS.of_HasBackChassisSplit ( apo_Source ) THEN
		li_Return = 1
	
		ll_DismountID = THIS.of_GetTrailerRtnLocation ( apo_source )
		ll_DropID = THIS.of_GetChassisRtnLocation ( apo_source )	

		al_DismountID = ll_DismountID
		al_DropID = ll_DropID
		
	END IF
END IF

RETURN li_Return





end function

public function long of_getchassispulocation (powerobject apo_source);Long			ll_Return

n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( apo_source ) 

IF THIS.of_HasFrontChassisSplit ( apo_source ) THEN
	lnv_Event.of_SetSourceRow ( 1 )
	ll_Return = lnv_Event.of_GetSite ( )
END IF

DESTROY ( lnv_Event ) 

RETURN ll_Return





end function

public function long of_getchassisrtnlocation (powerobject apo_source);Long			ll_Return
Boolean		lb_Continue = TRUE
n_cst_beo_Event	lnv_Event
n_cst_dws	lnv_Dws
lnv_Event = CREATE n_cst_beo_Event


IF THIS.of_HasBackChassisSplit ( apo_source ) THEN
	lnv_Event.of_SetSource ( apo_source ) 
	lnv_Event.of_SetSourceRow ( lnv_Dws.of_RowCount( apo_source ) )
	
	ll_Return = lnv_Event.of_GetSite ( )
END IF

DESTROY ( lnv_Event ) 

RETURN ll_Return





end function

public function integer of_getfrontchassissplitsites (ref long al_hookid, ref long al_mountid, powerobject apo_source);// Returns -1 on error
//				0 = not a split
//				1 on success 



Long	ll_HookID
Long	ll_MountID
Int	li_Return = 0

IF Not isValid ( apo_source ) THEN
	li_Return = -1
ELSE
	
	IF THIS.of_HasFrontChassisSplit ( apo_source ) THEN
		li_Return = 1
		ll_HookID = THIS.of_GetChassisPuLocation ( apo_source )
		ll_MountID = THIS.of_GetTrailerPuLocation ( apo_source )
	
		al_hookid = ll_HookID
		al_mountid = ll_MountID
		
	END IF
END IF

RETURN li_Return



end function

public function integer of_setbackchassissplitsite (long al_id, powerobject apo_source);Int		li_Return = -1
boolean	lb_Continue = TRUE
n_cst_dws	lnv_Dws
n_cst_beo_Event	lnv_Event

lnv_Event = Create n_cst_beo_event

lb_Continue = IsValid ( apo_source )

IF lb_Continue THEN
	lb_Continue = THIS.of_hasBackChassisSplit ( apo_source )
END IF

IF lb_Continue THEN
	lnv_Event.of_SetSource ( apo_source )
	lnv_Event.of_SetSourceRow ( lnv_Dws.of_RowCount ( apo_source ) )
	lb_Continue = lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_drop // this is just to make sure																								
END IF
	
IF lb_Continue THEN
	lnv_Event.of_SetSite ( al_ID )
	li_Return = 1
END IF

DESTROY ( lnv_Event ) 

RETURN li_Return
end function

public function integer of_setfrontchassissplitsite (long al_id, powerObject apo_source);Int		li_Return = -1
boolean	lb_Continue = TRUE
n_cst_beo_Event	lnv_Event
lnv_Event = Create n_cst_beo_event

lb_Continue = IsValid ( apo_source )

IF lb_Continue THEN
	lb_Continue = THIS.of_hasFrontChassisSplit ( apo_source )
END IF

IF lb_Continue THEN
	lnv_Event.of_SetSource ( apo_source )
	lnv_Event.of_SetSourceRow ( 1 )
	lb_Continue = lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_hook // this is just to make sure																								
END IF
	
IF lb_Continue THEN
	lnv_Event.of_SetSite ( al_ID )
	li_Return = 1
END IF

DESTROY ( lnv_Event ) 

RETURN li_Return
end function

public function long of_gettrailerpulocation (powerobject apo_source);Long			ll_Return
n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( apo_source ) 

IF THIS.of_HasFrontChassisSplit ( apo_source ) THEN	
	lnv_Event.of_SetSourceRow ( 2 )	
	ll_Return = lnv_Event.of_GetSite ( )	
ELSE
	lnv_Event.of_SetSourceRow ( 1 )
	IF lnv_Event.of_GetType () = gc_dispatch.cs_eventType_Hook OR lnv_Event.of_GetType () = gc_dispatch.cs_eventType_Mount THEN
		ll_Return = lnv_Event.of_GetSite ( )
	END IF	
END IF

DESTROY ( lnv_Event ) 

RETURN ll_Return





end function

public function long of_gettrailerrtnlocation (powerobject apo_source);Long			ll_Return
Long			ll_RowCount
n_cst_dws	lnv_Dws
n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

ll_RowCount = lnv_Dws.of_RowCount ( apo_source )
lnv_Event.of_SetSource ( apo_source ) 


IF THIS.of_HasBackChassisSplit ( apo_source ) THEN  	
	lnv_Event.of_SetSourceRow ( ll_RowCount - 1  ) 	
	ll_Return = lnv_Event.of_GetSite ( )
ELSE
	IF ll_RowCount >= 2 THEN // else it is a one-way   <<*>> changed to >= to support one way
		lnv_Event.of_SetSourceRow ( ll_RowCount ) 
		IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Drop OR lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Dismount THEN
			ll_Return = lnv_Event.of_GetSite ( )
		END IF
	END IF
	
END IF

DESTROY ( lnv_Event ) 

RETURN ll_Return





end function

public function integer of_getsitesforeventflag (powerobject apo_source, string as_flag, ref long al_origin, ref long al_destination);Long	ll_Origin
Long	ll_Dest
Int	li_Return = -1

CHOOSE CASE as_Flag
		
	CASE n_cst_constants.cs_ItemEventType_FrontChassisSplit
		THIS.of_GetFrontChassisSplitSites (  ll_Origin , ll_Dest , apo_source  )		
		
	CASE n_cst_constants.cs_ItemEventType_BackChassisSplit
		THIS.of_GetBackChassisSplitSites (  ll_Origin , ll_Dest , apo_source  )		
		
	CASE n_cst_constants.cs_ItemEventType_StopOff
		
END CHOOSE 

IF ll_Origin > 0 AND ll_Dest > 0 THEN
	li_Return = 1
END IF

al_origin = ll_Origin
al_destination = ll_Dest

RETURN li_Return
end function

public function integer of_settrailerpusite (long al_site, powerobject apo_source);n_cst_dws				lnv_Dws
n_cst_beo_Event		lnv_Event

lnv_Event = Create n_cst_beo_event

IF THIS.of_HasFrontChassisSplit ( apo_Source ) THEN
	
	lnv_Event.of_SetSource ( apo_source )
	lnv_Event.of_SetSourceRow ( 2 )
	lnv_Event.of_SetSite ( al_site ) 
	
ELSE
	
	lnv_Event.of_SetSource ( apo_source )
	lnv_Event.of_SetSourceRow ( 1 )
	IF lnv_Event.of_HasSource ( ) AND lnv_Event.of_GEtType ( ) = gc_Dispatch.cs_EventType_Hook THEN		
		lnv_Event.of_SetSite ( al_site ) 
	END IF
	
END IF

DESTROY ( lnv_Event ) 

RETURN 1


end function

public function integer of_settrailerrtnsite (long al_siteid, powerobject apo_source);Long						ll_RowCount
n_cst_dws				lnv_Dws
n_cst_beo_Event		lnv_Event


ll_RowCount = lnv_Dws.of_RowCount ( apo_Source )
lnv_Event = Create n_cst_beo_event

IF THIS.of_HasBackChassisSplit ( apo_Source ) THEN
	
	lnv_Event.of_SetSource ( apo_source )
	lnv_Event.of_SetSourceRow ( ll_RowCount - 1 )
	lnv_Event.of_SetSite ( al_SiteID ) 
	
ELSE
	
	lnv_Event.of_SetSource ( apo_source )
	lnv_Event.of_SetSourceRow ( ll_RowCount )
	IF lnv_Event.of_HasSource ( ) AND lnv_Event.of_GEtType ( ) = gc_Dispatch.cs_EventType_Drop AND ll_RowCount > 2 THEN//	>2 b/c of one way
		lnv_Event.of_SetSite ( al_SiteID ) 
	END IF
	
END IF

DESTROY ( lnv_Event ) 

RETURN 1


end function

public function integer of_setchassispusite (long al_site, powerobject apo_source);n_cst_dws				lnv_Dws
n_cst_beo_Event		lnv_Event

lnv_Event = Create n_cst_beo_event

IF THIS.of_HasFrontChassisSplit ( apo_Source ) THEN
	
	lnv_Event.of_SetSource ( apo_source )
	lnv_Event.of_SetSourceRow ( 1 )
	lnv_Event.of_SetSite ( al_site ) 
	
END IF

DESTROY ( lnv_Event ) 

RETURN 1


end function

public function boolean of_hasnonroutablemarkedevents (long ala_eventids[], powerobject apo_source);Long	ll_EventCount
Long	ll_i
Boolean	lb_Return

n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( apo_Source )

ll_EventCount = UpperBound ( ala_eventids[ ] )

FOR ll_i = 1 TO ll_EventCount
	lnv_Event.of_SetSourceID ( ala_Eventids[ ll_i ] )
	IF lnv_Event.of_GetRoutable ( ) = 'F' THEN
		lb_Return = TRUE
		EXIT 
	END IF
NEXT
	
	
DESTROY ( lnv_Event ) 

RETURN lb_Return
	
	
end function

public function integer of_markalleventsasroutable (long ala_eventids[], powerobject apo_source);Long	ll_EventCount
Long	ll_i
Int	li_Return = 1
n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

ll_EventCount = UpperBound ( ala_eventids[] )

lnv_Event.of_SetSource ( apo_Source )
lnv_Event.of_SetAllowFilterSet ( TRUE ) 
FOR ll_i = 1 TO ll_EventCount
	lnv_Event.of_SetSourceID ( ala_Eventids[ ll_i ] )
	lnv_Event.of_SetRoutable ( 'T' ) 
NEXT
	
DESTROY ( lnv_Event ) 

RETURN li_Return
	
end function

public function n_cst_beo_event of_gettrailerpuevent (powerobject apo_source);Long			ll_Return
n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( apo_source ) 

IF THIS.of_HasFrontChassisSplit ( apo_source ) THEN	
	lnv_Event.of_SetSourceRow ( 2 )	
	ll_Return = lnv_Event.of_GetSite ( )	
ELSE
	lnv_Event.of_SetSourceRow ( 1 )
	IF lnv_Event.of_GetType () = gc_dispatch.cs_eventType_Hook OR lnv_Event.of_GetType () = gc_dispatch.cs_eventType_Mount THEN
		ll_Return = lnv_Event.of_GetSite ( )
	END IF	
END IF

RETURN  lnv_Event 







end function

public function n_cst_beo_event of_gettrailerrtnevent (powerobject apo_source);Long			ll_Return
Long			ll_RowCount
n_cst_dws	lnv_Dws
n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

ll_RowCount = lnv_Dws.of_RowCount ( apo_source )
lnv_Event.of_SetSource ( apo_source ) 


IF THIS.of_HasBackChassisSplit ( apo_source ) THEN  	
	lnv_Event.of_SetSourceRow ( ll_RowCount - 1  ) 	
	ll_Return = lnv_Event.of_GetSite ( )
ELSE
	IF ll_RowCount >= 2 THEN // else it is a one-way  <<*>> changed to >= to support one-way
		lnv_Event.of_SetSourceRow ( ll_RowCount ) 
		IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Drop OR  lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Drop THEN
			ll_Return = lnv_Event.of_GetSite ( )
		END IF
	END IF
	
END IF

RETURN  lnv_Event 






end function

public function integer of_setpuapptdate (n_cst_beo_shipment anv_shipment, date ad_value);// zmc - 1/22/04

Int	li_Return = 1
Int li_Ctr

Long ll_UpperBound
Long ll_Origin
 
n_cst_beo_Shipment lnv_Shipment

lnv_Shipment = anv_Shipment 
 
n_cst_AnyArraySrv lnv_Array 
 
n_cst_Beo_Event lnva_Events [] 

IF Not IsValid(lnv_Shipment) THEN
	li_Return = -1
END IF	
 
IF li_Return = 1 THEN
	ll_Origin = lnv_Shipment.of_GetOrigin ( )
	lnv_Shipment.of_GetEventList( lnva_Events [] )
	ll_UpperBound = UpperBound(lnva_Events[])
	IF ll_UpperBound > 0 THEN
		IF Not IsNull(ll_Origin) THEN		
		
			FOR li_Ctr = 1 TO ll_UpperBound
				IF lnva_Events[li_Ctr].of_GetSite ( ) =  ll_Origin AND & 
					lnva_Events[li_Ctr].of_IsPickupGroup ( ) THEN
					lnva_Events[li_Ctr].of_SetScheduledDate(ad_value)
					EXIT
				END IF 
			
			NEXT
		ELSE
			
//			FOR li_Ctr = 1 TO ll_UpperBound
//				IF	lnva_Events[li_Ctr].of_IsPickupGroup ( ) THEN
//					lnva_Events[li_Ctr].of_SetScheduledDate(ad_value)
//					EXIT
//				END IF 			
//			NEXT	
			li_Return = -1
		END IF
		
		
	ELSE			
		li_Return = -1
	END IF	
END IF

lnv_Array.of_Destroy(lnva_Events)

RETURN li_Return
end function

public function integer of_setdeliverapptdate (n_cst_beo_shipment anv_shipment, date ad_value);// zmc - 1/22/04

Int li_Return = 1
Int li_Ctr

Long ll_UpperBound
//Long ll_Dest
 
n_cst_beo_Shipment lnv_Shipment

lnv_Shipment = anv_Shipment 
 
n_cst_AnyArraySrv lnv_Array 
 
n_cst_Beo_Event lnva_Events [] 

IF Not IsValid(lnv_Shipment) THEN
	li_Return = -1	
END IF
 
IF li_Return = 1 THEN
	// Issue 2080
	Long	ll_Site
	lnv_Shipment.of_GetEventList( lnva_Events [] )
	ll_UpperBound = UpperBound(lnva_Events[])
	IF ll_UpperBound > 0 THEN
		CHOOSE CASE lnv_Shipment.of_getmovecode( )
				
			CASE "E" 
				ll_Site = lnv_Shipment.of_getorigin( )
							
			CASE ELSE
				ll_Site = lnv_Shipment.of_GetDestination ( )
							
		END CHOOSE
		
		IF ll_Site > 0 THEN
					
			FOR li_Ctr = 1 TO ll_UpperBound
				IF lnva_Events[li_Ctr].of_GetSite ( ) =  ll_Site AND &
					lnva_Events[li_Ctr].of_IsDeliverGroup( ) THEN
					lnva_Events[li_Ctr].of_SetScheduledDate(ad_value)
					EXIT
				END IF 
			NEXT
			
		ELSE
//			FOR li_Ctr = 1 TO ll_UpperBound
//				IF lnva_Events[li_Ctr].of_IsDeliverGroup( ) THEN
//					lnva_Events[li_Ctr].of_SetScheduledDate(ad_value)
//					EXIT
//				END IF 
//			NEXT

			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF	
	
	/*
	ll_Dest = lnv_Shipment.of_GetDestination ( )
	
	IF Not IsNull(ll_Dest) THEN
		lnv_Shipment.of_GetEventList( lnva_Events [] )
		ll_UpperBound = UpperBound(lnva_Events[])
		
		IF ll_UpperBound > 0 THEN
			FOR li_Ctr = 1 TO ll_UpperBound
			 IF lnva_Events[li_Ctr].of_GetSite ( ) =  ll_Dest AND &
				 lnva_Events[li_Ctr].of_IsDeliverGroup( ) THEN
				lnva_Events[li_Ctr].of_SetScheduledDate(ad_value)
				EXIT
			 END IF 

			NEXT
		ELSE
			li_Return = -1 // Event list is blank, hence Return -1
		END IF
	ELSE	
		li_Return = -1 // No Destination company selected, hence Return -1
	END IF	
	
	*/
END IF	

lnv_Array.of_Destroy(lnva_Events)

RETURN li_Return
end function

public function integer of_setpuappttime (n_cst_beo_shipment anv_shipment, time at_value);// zmc - 1/22/04

Int	li_Return = 1
Int li_Ctr

Long ll_UpperBound
Long ll_Origin
 
n_cst_beo_Shipment lnv_Shipment

lnv_Shipment = anv_Shipment 
 
n_cst_AnyArraySrv lnv_Array 
 
n_cst_Beo_Event lnva_Events [] 
 
IF Not IsValid(lnv_Shipment) THEN
	li_Return = -1	
END IF
 
IF li_Return = 1 THEN	

	ll_Origin = lnv_Shipment.of_GetOrigin ( )
	lnv_Shipment.of_GetEventList( lnva_Events [] )
	ll_UpperBound = UpperBound(lnva_Events[])
	
	IF ll_UpperBound > 0 THEN
		IF Not IsNull(ll_Origin) THEN
			
						
			FOR li_Ctr = 1 TO ll_UpperBound
				IF lnva_Events[li_Ctr].of_GetSite ( ) =  ll_Origin AND & 
					lnva_Events[li_Ctr].of_IsPickupGroup ( ) THEN
					lnva_Events[li_Ctr].of_SetScheduledTime(at_value)
					EXIT
				END IF 
			NEXT
				
			
		ELSE	
			
//			FOR li_Ctr = 1 TO ll_UpperBound
//				IF lnva_Events[li_Ctr].of_IsPickupGroup ( ) THEN
//					lnva_Events[li_Ctr].of_SetScheduledTime(at_value)
//					EXIT
//				END IF 
//			NEXT
//			
			li_Return = -1
		END IF	
	ELSE
		li_Return = -1
	END IF
END IF	

lnv_Array.of_Destroy(lnva_Events)

RETURN li_Return
end function

public function integer of_setdeliverappttime (n_cst_beo_shipment anv_shipment, time at_value);// zmc - 1/22/04

Int	li_Return = 1
Int li_Ctr

Long ll_UpperBound
Long ll_Dest
 
n_cst_beo_Shipment lnv_Shipment

lnv_Shipment = anv_Shipment 
 
n_cst_AnyArraySrv lnv_Array 
 
n_cst_Beo_Event lnva_Events [] 

IF Not IsValid(lnv_Shipment) THEN
	li_Return = -1	
END IF
 
IF li_Return = 1 THEN 
	Long	ll_Site
	lnv_Shipment.of_GetEventList( lnva_Events [] )
	ll_UpperBound = UpperBound(lnva_Events[])
	
	// Issue 2080
	IF ll_UpperBound > 0 THEN
		CHOOSE CASE lnv_Shipment.of_getmovecode( )
				
			CASE "E" 
				ll_Site = lnv_Shipment.of_getorigin( )
							
			CASE ELSE
				ll_Site = lnv_Shipment.of_GetDestination ( )
							
		END CHOOSE
		
		IF ll_Site > 0 THEN
					
			FOR li_Ctr = 1 TO ll_UpperBound
				IF lnva_Events[li_Ctr].of_GetSite ( ) =  ll_Site AND &
					lnva_Events[li_Ctr].of_IsDeliverGroup( ) THEN
					lnva_Events[li_Ctr].of_SetScheduledTime(at_value)
					EXIT
				END IF 
			NEXT
			
		ELSE		
//			FOR li_Ctr = 1 TO ll_UpperBound
//				IF lnva_Events[li_Ctr].of_IsDeliverGroup( ) THEN
//					lnva_Events[li_Ctr].of_SetScheduledTime(at_value)
//					EXIT
//				END IF 
//			NEXT
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF	
	
	
	
	/*
	ll_Dest = lnv_Shipment.of_GetDestination ( )
	
	IF Not IsNull(ll_Dest) THEN
		lnv_Shipment.of_GetEventList( lnva_Events [] )
		ll_UpperBound = UpperBound(lnva_Events[])
		
		IF ll_UpperBound > 0 THEN
			FOR li_Ctr = 1 TO ll_UpperBound
			 IF lnva_Events[li_Ctr].of_GetSite ( ) =  ll_Dest AND & 
				 lnva_Events[li_Ctr].of_ISDeliverGroup( ) THEN
				 lnva_Events[li_Ctr].of_SetScheduledTime(at_value)
				EXIT
			 END IF 
			NEXT
		ELSE
			li_Return = -1 // Event list is blank, hence Return -1
		END IF
	ELSE	
		li_Return = -1 // No Destination company selected, hence Return -1 
	END IF	
	
	*/
END IF	

lnv_Array.of_Destroy(lnva_Events)

RETURN li_Return
end function

public function integer of_resettimes (datastore ads_target, string as_context, date ad_context, integer ai_routetype);//Returns : 1, -1

// n_cst_numerical lnv_numerical
//if lnv_numerical.of_IsNullOrNotPos(itinevents) then return 1

//start_row was not being referenced in the script copied over from w_itin.  I'm not
//sure at what point this feature got dropped, and whether there was a problem using it
//or if I just dropped it for safety's sake at some point.

long ll_markloop, ll_minutes, ll_RowCount
decimal {1} lc_miles
string ls_pcm, ls_arr, ls_dep, ls_pcm_prev, ls_dep_prev
time lt_appt, lt_arr, lt_dep, lt_duration
date ld_appt

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF NOT IsValid ( ads_Target ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	setnull(ls_pcm_prev)
	setnull(ls_dep_prev)
	
	ll_RowCount = ads_Target.RowCount ( )
	
	for ll_markloop = 1 to ll_RowCount
		ls_pcm = ads_Target.object.co_pcm[ll_markloop]
		lt_arr = ads_Target.object.de_arrtime[ll_markloop]
		lt_dep = ads_Target.object.de_deptime[ll_markloop]
		ld_appt = ads_Target.object.de_apptdate[ll_markloop]
		lt_appt = ads_Target.object.de_appttime[ll_markloop]
		lt_duration = ads_Target.object.de_duration[ll_markloop]
		if isnull(lt_duration) then lt_duration = 00:30:00
		if len(ls_pcm_prev) > 0 and len(ls_pcm) > 0 then
			gf_calc_miles(ls_pcm_prev, ls_pcm, lc_miles, ll_minutes, ai_routetype)
		else
			setnull(lc_miles)
			setnull(ll_minutes)
		end if
		ads_Target.object.leg_miles[ll_markloop] = lc_miles
		ads_Target.object.leg_mins[ll_markloop] = ll_minutes
		choose case as_context
		case "ITIN!"
			if isnull(ls_dep_prev) then
				if not isnull(lt_arr) then
					ls_arr = string(lt_arr)
				elseif datetime(ld_appt) = datetime(ad_Context) and not isnull(lt_appt) then
					ls_arr = string(lt_appt)
				else
					setnull(lt_arr)
				end if
			elseif isnull(ll_minutes) then
				if not isnull(lt_arr) then
					if secondsafter(time(ls_dep_prev), lt_arr) > 0 then
						ls_arr = string(lt_arr)
					else
						ls_arr = ls_dep_prev
					end if
				elseif datetime(ld_appt) = datetime(ad_Context) and not isnull(lt_appt) then
					if secondsafter(time(ls_dep_prev), lt_appt) > 0 then
						ls_arr = string(lt_appt)
					else
						ls_arr = ls_dep_prev
					end if
				else
					ls_arr = ls_dep_prev
				end if
			else
				ls_arr = string(reltime_ext(ls_dep_prev, ll_minutes * 60))
			end if
			ads_Target.object.cc_arrstr[ll_markloop] = ls_arr
			if not isnull(lt_arr) then ls_arr = string(lt_arr)
			if ld_appt = ad_Context and not isnull(lt_appt) then
				if isnull(ls_arr) then
					ls_arr = string(lt_appt)
				elseif secondsafter(time(ls_arr), lt_appt) > 0 then
					ls_arr = string(lt_appt)
				end if
			end if
			if isnull(ls_arr) then
				setnull(ls_dep)
			else
				ls_dep = string(reltime_ext(ls_arr, secondsafter(00:00:00, lt_duration)))
			end if
			ads_Target.object.cc_depstr[ll_markloop] = ls_dep
			if isnull(lt_dep) then
				if len(ls_dep) > 0 then
					ls_dep_prev = ls_dep
				elseif len(ls_dep_prev) > 0 then
					ls_dep_prev = string(reltime_ext(ls_dep_prev, secondsafter(00:00:00, lt_duration)))
				end if
			else
				ls_dep_prev = string(lt_dep)
			end if
		case else //i.e., SHIP!
			ads_Target.object.cc_arrstr[ll_markloop] = null_str
			ads_Target.object.cc_depstr[ll_markloop] = null_str
		end choose
	
		if len(ls_pcm) > 0 then ls_pcm_prev = ls_pcm
	
	next

END IF

RETURN li_Return
end function

public function string of_gettypedatavalueshort (string as_displayvalue);String	ls_CodeTable, &
			ls_DataValue
n_cst_String	lnv_String

ls_CodeTable = This.of_GetTypeCodeTableShort ( )

ls_DataValue = lnv_String.of_GetCodeTableDataValue ( as_DisplayValue, ls_CodeTable )

RETURN ls_DataValue
end function

public function integer of_geteventcache (ref n_ds ads_eventcache);RETURN -1
end function

public function integer of_getyardevents (n_cst_beo_event anv_anchorevent, ref n_cst_beo_event anv_dropevent, ref n_cst_beo_event anv_hookevent);Int	li_Return = 1

N_cst_beo_Event	lnv_Drop
n_cst_beo_Event	lnv_Hook
n_cst_beo_Event	lnv_AnchorEvent

Powerobject	lpo_Source

lnv_AnchorEvent = anv_anchorevent

IF Not isValid ( lnv_AnchorEvent )THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	lpo_Source = lnv_anchorEvent.of_GetSource ( ) 

	IF Not isValid ( lpo_Source ) THEN
		li_RETURN = -1
	END IF		
END IF

IF li_Return = 1 THEN
	Long	ll_Site	
	String	ls_Type
	ll_Site = lnv_AnchorEvent.of_GetSite ( )
	ls_Type = lnv_anchorEvent.of_getType ( )
	IF ll_Site = 0 OR isNull ( ll_Site ) THEN
		li_Return = 0
	END IF
END IF

IF li_Return = 1 THEN

Boolean	lb_SearchForward
	CHOOSE CASE ls_Type
			
		CASE 'H'
			// ok, we will use the default value for lb_SearchForeard
		CASE 'R'

			lb_SearchForward = TRUE
		CASE ELSE
			li_return = -1
	END CHOOSE
	
	Long	ll_StartRow
	Long	ll_RowCount
	
	ll_StartRow = lnv_AnchorEvent.of_GetSourceRow ( )
		
END IF

IF li_Return = 1 THEN
	Long	ll_FoundRow 
	IF lb_SearchForward THEN
		ll_FoundRow = lpo_Source.Dynamic find( "de_event_type = 'H' and de_Site = "+ String ( ll_Site ) , ll_StartRow , lpo_Source.Dynamic RowCount ( ) ) 
	ELSE
		ll_FoundRow = lpo_Source.Dynamic find( "de_event_type = 'R' and de_Site = "+ String ( ll_Site ) , ll_StartRow , 1 ) 		
	END IF
		
	IF ll_FoundRow <= 0 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF lb_SearchForward THEN  /// the anchor event (the one that they clicked on) that was sent in was the Drop evetn in the yard move
									// so assign that to the Drop event to pass out and the initialize the Hook
		lnv_Drop = lnv_AnchorEvent
		lnv_Hook = CREATE n_cst_Beo_Event
		lnv_Hook.of_SetSource (lpo_Source )
		lnv_Hook.of_SetSourceRow ( ll_FoundRow )
		anv_dropevent = lnv_Drop
		anv_hookevent = lnv_Hook
	ELSE

		lnv_Hook = lnv_anchorEvent
		lnv_Drop = CREATE n_cst_beo_Event
		lnv_Drop.of_SetSource ( lpo_Source ) 
		lnv_Drop.of_SetSourceRow ( ll_FoundRow )
		anv_dropevent = lnv_Drop
		anv_Hookevent = lnv_Hook
	END IF
	
END IF


RETURN li_Return











end function

on n_cst_events.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_events.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

