$PBExportHeader$n_cst_dwsrv_restrict_shipments.sru
forward
global type n_cst_dwsrv_restrict_shipments from n_cst_dwsrv_restrict
end type
end forward

global type n_cst_dwsrv_restrict_shipments from n_cst_dwsrv_restrict
end type
global n_cst_dwsrv_restrict_shipments n_cst_dwsrv_restrict_shipments

type variables
Long 	ila_unidentifiedLocators[]
end variables

forward prototypes
public function boolean of_outofcheck (long al_index, n_cst_restrictioncriteria anv_data)
public subroutine of_outofcachelogic (n_cst_restrictioncriteria anv_data)
public subroutine of_intocachelogic (n_cst_restrictioncriteria anv_data)
public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows)
public function boolean of_moverowoutofcachelogic (long al_index, n_cst_restrictioncriteria anv_data)
public function boolean of_moveintocachelogic (long al_index, n_cst_restrictioncriteria anv_data)
public function integer of_cachelogic (integer ai_mode, n_cst_restrictioncriteria anv_data)
public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows, ref boolean ab_keepgroup)
public function boolean of_intononcachecheck (long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows, ref boolean ab_keepgroup)
public function boolean of_outofnoncachecheck (long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows, ref boolean ab_keepgroup)
public function integer of_noncachelogic (integer ai_mode, n_cst_restrictioncriteria anv_data)
end prototypes

public function boolean of_outofcheck (long al_index, n_cst_restrictioncriteria anv_data);return true
end function

public subroutine of_outofcachelogic (n_cst_restrictioncriteria anv_data);/***************************************************************************************
NAME: 			of_outOfCacheLogic

ACCESS:			public
		
ARGUMENTS: 		
							anv_data:	the data in which to do restricions against.

RETURNS:			none
	
DESCRIPTION:	The following is logic that will restrict all rows of Idw_requestor against
					anv_data.  Restriction is based on getting a driver outof a location. The logic
					here is more involved then the noncache restrictions.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 11-16-2005
	enhanced on 11-18-05 by Dan, no longer does distance lookups if the name and city match.

***************************************************************************************/

Long	ll_index
Long	ll_rowNum
//Long	ll_siteid
//Long	ll_minutes
Long	ll_groupStart
Long	ll_groupEnd
//
//String	ls_PCM
//String	ls_nextEventType
//String	ls_nextEvent2Type
String	ls_columnTag
Boolean	lb_moveRows
Boolean	lb_moveGroup
Boolean	lb_oldCode
Boolean 	lb_checkAllRows
Boolean	lb_keepGroup

//s_co_info lstr_company
//decimal {1} lc_miles

n_cst_events	lnv_shipmentTypeCheck
ll_rowNum = idw_requestor.RowCount()
/*
IF isNumber(idw_requestor.describe("datawindow.header.1.height")) THEN
			
	IF ll_rowNum > 0 THEN
		ls_columnTag = idw_requestor.Describe("#1.tag")
	
		lb_checkAllRows = Match( lower(ls_columnTag), lower(cs_checkrowstag) )
		lb_KeepGroup = Match( lower(ls_columnTag), lower(cs_keepgrouptag) )
		
		ll_groupStart = 1
		ll_groupEnd = 1
		
		DO WHILE ll_groupStart > 0 AND ll_groupENd >= ll_groupStart
			lb_moveGroup = true
			
			IF ll_groupStart +1 <= ll_rowNum THEN
				ll_groupEnd = idw_requestor.FindGroupChange(ll_groupStart+1, 1) - 1
			ELSE
				ll_groupEnd = ll_rowNum
			END IF
			//check the first row for the tag "CHECKROWS" in the first column
			IF lb_checkAllRows THEN
				//CHECK for the tag "KEEPGROUP" in the first column
				IF lb_keepGroup THEN
					//if one row passed then keep the entire group
					//if no row passed then trash the entire group
					FOR ll_index = ll_groupStart TO ll_groupEnd
						//if we want to keep the row
						IF NOT this.of_moverowoutofcachelogic( ll_index, anv_data) THEN
							lb_moveGroup = false
							EXIT
						END IF
					NEXT
					
				ELSE
					//if row passes, keep just that row
					//if row fails, then move that row
					//old code
					lb_oldCode = true
					lb_moveGroup = false
					EXIT
				END IF
			ELSE
				//test the first row of the group
				//if the first row passes, keep the entire group
				//if the first row fails, trash the entire group
				IF NOT this.of_moverowoutofcachelogic( ll_groupStart, anv_data) THEN
					lb_moveGroup = false				//the first row in the group passed
				END IF
			END IF
			
			IF lb_moveGroup THEN
				idw_requestor.rowsmove(ll_groupStart, ll_groupEnd, primary!, idw_requestor, 9999, filter!)
				//ll_groupstart doesn't change, the next group will now be located at the current groupstart
				//row. IF the last group is removed, then making the following call should reset groupstart
				//to 0 and make it drop out of the loop
				ll_groupStart = idw_requestor.FindGroupChange(ll_groupStart, 1)
			ELSE
				//gets the next group starting index(must increment by 1 because if you call the function
				//on the first row of the group, it returns the same row that you pass in)
				ll_groupStart = idw_requestor.FindGroupChange(ll_groupStart+1, 1)
			END IF
		LOOP
	END IF
ELSE
	//not a group
	//do old code
	lb_oldCode = true
END IF


IF lb_oldCode THEN
	//----------------working old code

	FOR ll_index = ll_rowNum TO 1 Step -1
		lb_moveRows = this.of_moverowoutofcachelogic( ll_index, anv_data)
		
		IF lb_moveRows THEN
			idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
		END IF
		/*
		lb_moveRows = false
		ls_nextEventType = idw_requestor.getItemString( ll_index, "nextevent_type" )
		ls_nextEvent2Type = idw_requestor.getItemString( ll_index, "nextevent2_type" )
		
		//stored in the cashe is a 2 character value, this function converts it to the one character value
		ls_nextEventType = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEventType )
		ls_nextEvent2Type = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEvent2Type )
		//move rows into filter buffer if the type doesn't match
		If lnv_shipmentTypeCheck.of_istypedelivergroup( ls_nextEventType )  THEN
			
			IF ls_nextEvent2Type = "M" THEN			//mount
				ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent2_siteid" )
				IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
					ls_pcm = lstr_company.co_pcm
					
					
					//if null at this point and Quickmatch isValid , add to a list of siteIds
					IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
						idw_qm.of_addUnidentifiedId( ll_siteId )
					END IF
				ELSE
					setnull(ls_pcm)
				END IF
				
				//enhanced to keep from doing look up if the city and state names match
				IF NOT (lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState) THEN
					//if it is in the required distance, or if the state and city names are the same
					gf_calc_miles(anv_data.is_outOf_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
					IF  lc_miles <= anv_data.il_withinDistance /*OR ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState ) */ THEN 
						//MessageBox("1st del, 2nd mt", String(lc_miles))
					ELSE
						//move to filter
						//MessageBox("not del / 2nd MT", lc_Miles)
						lb_moveRows = true
						//idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
						
					END IF
				END IF	//end enhancement
			ELSE
				//move to filter
				//MessageBox("1st del, 2nd not mount", lc_Miles)
				lb_moveRows = true
				//idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
				
			END IF
		ELSE					//type is correct
			ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent_siteid" )
			IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
				ls_pcm = lstr_company.co_pcm
			ELSE
				setnull(ls_pcm)
			END IF
			
			//enhancement to not do location check if city and state matechs.
			//IF not ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState ) THEN
				gf_calc_miles( anv_data.is_outOf_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
				IF lc_miles <= anv_data.il_withinDistance OR ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState ) THEN 
						//nothing
						//MessageBox("1st PU (and within miles)", lc_Miles)
				ELSE
					
					IF ls_nextEvent2Type = "M" THEN
						ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent2_siteid" )
						IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
							ls_pcm = lstr_company.co_pcm
							
							//if null at this point and Quickmatch isValid , add to a list of siteIds
							IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
								idw_qm.of_addUnidentifiedId( ll_siteId )
							END IF
						ELSE
							setnull(ls_pcm)
						END IF
								
						//enhancement to not do lookup if state and city match
						IF NOT ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState ) THEN		
							//if it is in the required distance, or if the state and city names are the same
							gf_calc_miles( anv_data.is_outOf_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
							IF  lc_miles <= anv_data.il_withinDistance OR ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState )  THEN 
							
					
								//MessageBox("1st PU, 2nd MT", lc_Miles)
							ELSE
								lb_moveRows = true
								//idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
								//move to filter
								//MessageBox("1st pu, 2nd mt", lc_Miles)
								
							END IF
						END IF//end enhancement
		
					ELSE
						lb_moveRows = true
						//idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
					END IF
				END IF
			//END IF//end enhancement
		END IF //end else
		*/
		
	NEXT		
END IF
*/
end subroutine

public subroutine of_intocachelogic (n_cst_restrictioncriteria anv_data);/***************************************************************************************
NAME: 			of_IntoCacheLogic

ACCESS:			public
		
ARGUMENTS: 		
							anv_data:	the data in which to do restricions against.

RETURNS:			none
	
DESCRIPTION:	The following is logic that will restrict all rows of Idw_requestor against
					anv_data.  Restriction is based on getting a driver into a location. The logic
					here is more involved then the noncache restrictions.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 11-16-2005
						enhanced on 11-18-05 by Dan, no longer does distance lookups if the name and city match.
	

***************************************************************************************/


Long	ll_index
Long	ll_rowNum
//Long	ll_siteid
//Long	ll_minutes
//
//String	ls_PCM
//String	ls_nextEventType
//
//s_co_info lstr_company
//decimal {1} lc_miles
//
//Boolean	lb_considdered
//Boolean  lb_found
//Boolean	lb_stop

boolean	lb_oldcode
boolean lb_moveRows
boolean 	lb_moveGroup
Boolean	lb_checkallRows
Boolean	lb_keepGroup

Long	ll_groupStart
Long	ll_groupEnd

String	ls_columntag	


n_cst_events	lnv_shipmentTypeCheck
ll_rowNum = idw_requestor.RowCount()

/*
IF isNumber(idw_requestor.describe("datawindow.header.1.height")) THEN
			
	IF ll_rowNum > 0 THEN
		ls_columnTag = idw_requestor.Describe("#1.tag")
	
		lb_checkAllRows = Match( lower(ls_columnTag), lower(cs_checkrowstag) )
		lb_KeepGroup = Match( lower(ls_columnTag), lower(cs_keepgrouptag) )
		
		ll_groupStart = 1
		ll_groupEnd = 1
		
		DO WHILE ll_groupStart > 0 AND ll_groupENd >= ll_groupStart
			lb_moveGroup = true
			
			IF ll_groupStart +1 <= ll_rowNum THEN
				ll_groupEnd = idw_requestor.FindGroupChange(ll_groupStart+1, 1) - 1
			ELSE
				ll_groupEnd = ll_rowNum
			END IF
			//check the first row for the tag "CHECKROWS" in the first column
			IF lb_checkAllRows THEN
				//CHECK for the tag "KEEPGROUP" in the first column
				IF lb_keepGroup THEN
					//if one row passed then keep the entire group
					//if no row passed then trash the entire group
					FOR ll_index = ll_groupStart TO ll_groupEnd
						//if we want to keep the row
						IF NOT this.of_moveintocachelogic( ll_index, anv_data) THEN
							lb_moveGroup = false
							EXIT
						END IF
					NEXT
					
				ELSE
					//if row passes, keep just that row
					//if row fails, then move that row
					//old code
					lb_oldCode = true
					lb_moveGroup = false
					EXIT
				END IF
			ELSE
				//test the first row of the group
				//if the first row passes, keep the entire group
				//if the first row fails, trash the entire group
				IF NOT this.of_moveintocachelogic( ll_groupStart, anv_data) THEN
					lb_moveGroup = false				//the first row in the group passed
				END IF
			END IF
			
			IF lb_moveGroup THEN
				idw_requestor.rowsmove(ll_groupStart, ll_groupEnd, primary!, idw_requestor, 9999, filter!)
				//ll_groupstart doesn't change, the next group will now be located at the current groupstart
				//row. IF the last group is removed, then making the following call should reset groupstart
				//to 0 and make it drop out of the loop
				ll_groupStart = idw_requestor.FindGroupChange(ll_groupStart, 1)
			ELSE
				//gets the next group starting index(must increment by 1 because if you call the function
				//on the first row of the group, it returns the same row that you pass in)
				ll_groupStart = idw_requestor.FindGroupChange(ll_groupStart+1, 1)
			END IF
		LOOP
	END IF
ELSE
	//not a group
	//do old code
	lb_oldCode = true
END IF

IF lb_oldCode THEN
	
	FOR ll_index = ll_rowNum TO 1 Step -1
		//returns true if the row should be moved according to intocachelogic
		lb_moveRows = this.of_moveintocachelogic( ll_index, anv_data)
		
		IF lb_moveRows then
			idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
		END IF
	/*	
		ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent_siteid" )
		ls_nextEventType = idw_requestor.getItemString( ll_index, "nextevent_type" )
		
		//stored in the cashe is a 2 character value, this function converts it to the one character value
		ls_nextEventType = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEventType )
	
		IF lnv_shipmentTypeCheck.of_istypedelivergroup( ls_nextEventType ) AND ls_nextEventType <> "P" THEN
			lb_Considdered = TRUE
			
			IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
				ls_pcm = lstr_company.co_pcm
				//if null at this point and Quickmatch isValid , add to a list of siteIds
				IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
					idw_qm.of_addUnidentifiedId( ll_siteId )
				END IF
			ELSE
				
				setnull(ls_pcm)
			END IF
			
			//enhancement to stop processing before doing the lookup if the city and states match
			IF lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
				lb_found = true
			ELSE
				//get the distance between the two locations
				gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
		
				//if it is in the required distance, or if the state and city names are the same
				IF lc_miles <= anv_data.il_withinDistance /*OR ( lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState ) */THEN
					lb_Found = TRUE
					//MessageBox("Event1", lc_miles)
				END IF
			END IF//---end enhancement
		END IF
	
		IF NOT lb_found THEN
			//if next event 2 type 
			ls_nextEventType = idw_requestor.getItemString( ll_index, "nextevent2_type" )
			ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent2_siteid" )
			//stored in the cashe is a 2 character value, this function converts it to the one character value
			ls_nextEventType = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEventType )
			IF lnv_shipmentTypeCheck.of_istypedelivergroup( ls_nextEventType ) OR ls_nextEventType = "P" THEN
				lb_Considdered = TRUE
				IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
					ls_pcm = lstr_company.co_pcm
					
					
					//if null at this point and Quickmatch isValid , add to a list of siteIds
					IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected  THEN
						idw_qm.of_addUnidentifiedId( ll_siteId )
					END IF
				ELSE
					setnull(ls_pcm)
				END IF
			
				//enhancement
				IF lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
					lb_found = true
				ELSE
					//get the distance between the two locations
					gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
					IF lc_miles <= anv_data.il_withinDistance /*OR ( lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState ) */THEN
						lb_Found = TRUE
						//MessageBox("Event2", lc_miles)
					END IF
				END IF	//end enhancement
			ELSE
				IF lb_Considdered THEN 
					lb_Stop = TRUE
				END IF
			END IF
		END IF
		
		
		IF NOT lb_found AND NOT lb_stop THEN
			//if next event 3 type 
			ls_nextEventType = idw_requestor.getItemString( ll_index, "nextevent3_type" )
			ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent3_siteid" )
			//stored in the cashe is a 2 character value, this function converts it to the one character value
			ls_nextEventType = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEventType )
			IF lnv_shipmentTypeCheck.of_istypedelivergroup( ls_nextEventType ) OR ls_nextEventType = "P" THEN
				lb_Considdered = TRUE
				IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
					ls_pcm = lstr_company.co_pcm
					
					//if null at this point and Quickmatch isValid , add to a list of siteIds
					IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
						idw_qm.of_addUnidentifiedId( ll_siteId )
					END IF
	//									IF idw_requestor.getitemstring(ll_index, "nextevent3_city") = "INDIANAPOLIS" THEN
	//										MessageBox("3rd case", LS_PCM)
	//									END IF
				ELSE
					setnull(ls_pcm)
				END IF
			
				//enhancement
				IF lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
					lb_found = true
				ELSE
					
					//get the distance between the two locations
					gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
		
					//if it is in the required distance, or if the state and city names are the same
					IF lc_miles <= anv_data.il_withinDistance /*OR ( lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState ) */THEN
						//MessageBox("Event3", lc_miles)
						lb_Found = TRUE
					END IF
				END IF	//end enhancement
			ELSE 
				IF lb_Considdered THEN
					lb_Stop = TRUE
				END IF
			END IF
		END IF
		
		
		IF NOT lb_STOP AND NOT lb_found THEN
			//if next event 4 type 
			ls_nextEventType = idw_requestor.getItemString( ll_index, "nextevent4_type" )
			ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent4_siteid" )
			//stored in the cashe is a 2 character value, this function converts it to the one character value
			ls_nextEventType = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEventType )
			IF lnv_shipmentTypeCheck.of_istypedelivergroup( ls_nextEventType ) OR ls_nextEventType = "P" THEN
			
				lb_Considdered = TRUE
				IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
					ls_pcm = lstr_company.co_pcm
					
					//if null at this point and Quickmatch isValid , add to a list of siteIds
					IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
						idw_qm.of_addUnidentifiedId( ll_siteId )
					END IF
					
				ELSE
					setnull(ls_pcm)
				END IF
			
				//enhancement
				IF lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
					lb_found = true
				ELSE
					//get the distance between the two locations
					gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
		
					IF lc_miles <= anv_data.il_withinDistance /*OR ( lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState )*/ THEN
						lb_Found = TRUE
						//MessageBox("Event4", lc_miles)
					END IF
				END IF	//end enhancemnet
			END IF
		END IF
		
		IF NOT lb_Found THEN
			IF isNull(ls_pcm) THEN
				//MessageBox("Filtered", "null")
			END IF
			//MessageBox("Filtered", lc_miles)
			idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
		END IF
				
		lc_miles= 0
		ll_minutes = 0
		 
		lb_found = false
		lb_considdered = false
		lb_stop = false
	*/
	NEXT
END IF	
*/
end subroutine

public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows);/***************************************************************************************
NAME: 			of_checkcriteria

ACCESS:			public
		
ARGUMENTS: 		
							ai_mode:		1	out of 
											0  into
							al_index:	the row that is being checked on idw_requestor
							anv_data:	the restriction criteria
							
							ab_checkComputes:  whether or not this thing is checking computed fields
RETURNS:			true if the row meets the criteria
					false otherwise
	
DESCRIPTION:	The following checks all the objects in the dataobject for tags and 
					does a location comparison using pcmiler with the data passed in.
					If it meets the requirement it keeps it.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan	11=-7-05
	

***************************************************************************************/
boolean	lb_dummy
return this.of_checkCriteria( ai_mode, al_index, anv_data, ab_checkComputes, ab_checkallrows, lb_dummy  ) 
/*
Long 	ll_index
Long	ll_max


Boolean	lb_checkComputes
Boolean	lb_return

String	ls_columnTag
String	ls_locator
String	ls_pcm


n_cst_routing	lnv_routing
s_co_info lstr_company
n_cst_licensemanager	lnv_licensemanager
decimal {1} lc_miles

Long		ll_id
Long		ll_minutes


IF isValid( idw_requestor )  AND al_index > 0 /* AND ib_pcMilerConnected*/ THEN

	lb_checkComputes = ab_checkComputes
	
	ll_max = Long(idw_Requestor.Object.DataWindow.Column.Count)	
	IF ai_mode = ci_outOfMode THEN
		
		IF this.of_outOfNonCacheCheck( al_index, anv_data, lb_checkComputes) THEN
			RETURN TRUE
		ELSE
			lb_return = false
		END IF
			
		  
	ELSEIF Ai_mode = ci_intoMode THEN
		
		IF this.of_intoNonCacheCheck( al_index, anv_data, lb_checkComputes ) THEN
			RETURN TRUE
		ELSE
			lb_return = false
		END IF

	END IF
	RETURN lb_return		//nothing found
END IF 

RETURN FALSE			//required objects not valid
*/
end function

public function boolean of_moverowoutofcachelogic (long al_index, n_cst_restrictioncriteria anv_data);Long	ll_index
Long	ll_rowNum
Long	ll_siteid
Long	ll_minutes
Long	ll_groupStart
Long	ll_groupEnd

String	ls_PCM
String	ls_nextEventType
String	ls_nextEvent2Type
String	ls_columnTag
Boolean	lb_moveRows
Boolean	lb_oldCode
Boolean 	lb_checkAllRows
Boolean	lb_keepGroup

s_co_info lstr_company
decimal {1} lc_miles

n_cst_events	lnv_shipmentTypeCheck

ll_index = al_index

ls_nextEventType = idw_requestor.getItemString( ll_index, "nextevent_type" )
ls_nextEvent2Type = idw_requestor.getItemString( ll_index, "nextevent2_type" )

//stored in the cashe is a 2 character value, this function converts it to the one character value
ls_nextEventType = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEventType )
ls_nextEvent2Type = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEvent2Type )
//move rows into filter buffer if the type doesn't match
If lnv_shipmentTypeCheck.of_istypedelivergroup( ls_nextEventType )  THEN
	
	IF ls_nextEvent2Type = "M" THEN			//mount
		ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent2_siteid" )
		IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
			ls_pcm = lstr_company.co_pcm
			
			
			//if null at this point and Quickmatch isValid , add to a list of siteIds
			IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
				idw_qm.of_addUnidentifiedId( ll_siteId )
			END IF
		ELSE
			setnull(ls_pcm)
		END IF
		
		//enhanced to keep from doing look up if the city and state names match
		IF NOT (lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState) THEN
			//if it is in the required distance, or if the state and city names are the same
			gf_calc_miles(anv_data.is_outOf_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
			IF  lc_miles <= anv_data.il_withinDistance /*OR ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState ) */ THEN 
				//MessageBox("1st del, 2nd mt", String(lc_miles))
			ELSE
				//move to filter
				//MessageBox("not del / 2nd MT", lc_Miles)
				lb_moveRows = true
				//idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
				
			END IF
		END IF	//end enhancement
	ELSE
		//move to filter
		//MessageBox("1st del, 2nd not mount", lc_Miles)
		lb_moveRows = true
		//idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
		
	END IF
ELSE					//type is correct
	ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent_siteid" )
	IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
		ls_pcm = lstr_company.co_pcm
	ELSE
		setnull(ls_pcm)
	END IF
	
	//enhancement to not do location check if city and state matechs.
	//IF not ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState ) THEN
		gf_calc_miles( anv_data.is_outOf_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
		IF lc_miles <= anv_data.il_withinDistance OR ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState ) THEN 
				//nothing
				//MessageBox("1st PU (and within miles)", lc_Miles)
		ELSE
			
			IF ls_nextEvent2Type = "M" THEN
				ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent2_siteid" )
				IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
					ls_pcm = lstr_company.co_pcm
					
					//if null at this point and Quickmatch isValid , add to a list of siteIds
					IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
						idw_qm.of_addUnidentifiedId( ll_siteId )
					END IF
				ELSE
					setnull(ls_pcm)
				END IF
						
				//enhancement to not do lookup if state and city match
				IF NOT ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState ) THEN		
					//if it is in the required distance, or if the state and city names are the same
					gf_calc_miles( anv_data.is_outOf_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
					IF  lc_miles <= anv_data.il_withinDistance OR ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState )  THEN 
					
			
						//MessageBox("1st PU, 2nd MT", lc_Miles)
					ELSE
						lb_moveRows = true
						//idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
						//move to filter
						//MessageBox("1st pu, 2nd mt", lc_Miles)
						
					END IF
				END IF//end enhancement

			ELSE
				lb_moveRows = true
				//idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
			END IF
		END IF
	//END IF//end enhancement
END IF //end else

return lb_moveRows
end function

public function boolean of_moveintocachelogic (long al_index, n_cst_restrictioncriteria anv_data);//returns true if the row al_index should be moved to the filter do to into-cache-Logic
Long	ll_index
Long	ll_rowNum
Long	ll_siteid
Long	ll_minutes

String	ls_PCM
String	ls_nextEventType

s_co_info lstr_company
decimal {1} lc_miles

Boolean	lb_considdered
Boolean  lb_found
Boolean	lb_stop

n_cst_events	lnv_shipmentTypeCheck
ll_index = al_index
	
ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent_siteid" )
ls_nextEventType = idw_requestor.getItemString( ll_index, "nextevent_type" )

//stored in the cashe is a 2 character value, this function converts it to the one character value
ls_nextEventType = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEventType )

IF lnv_shipmentTypeCheck.of_istypedelivergroup( ls_nextEventType ) AND ls_nextEventType <> "P" THEN
	lb_Considdered = TRUE
	
	IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
		ls_pcm = lstr_company.co_pcm
		//if null at this point and Quickmatch isValid , add to a list of siteIds
		IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
			idw_qm.of_addUnidentifiedId( ll_siteId )
		END IF
	ELSE
		
		setnull(ls_pcm)
	END IF
	
	//enhancement to stop processing before doing the lookup if the city and states match
	IF lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
		lb_found = true
	ELSE
		//get the distance between the two locations
		gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)

		//if it is in the required distance, or if the state and city names are the same
		IF lc_miles <= anv_data.il_withinDistance /*OR ( lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState ) */THEN
			lb_Found = TRUE
			//MessageBox("Event1", lc_miles)
		END IF
	END IF//---end enhancement
END IF

IF NOT lb_found THEN
	//if next event 2 type 
	ls_nextEventType = idw_requestor.getItemString( ll_index, "nextevent2_type" )
	ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent2_siteid" )
	//stored in the cashe is a 2 character value, this function converts it to the one character value
	ls_nextEventType = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEventType )
	IF lnv_shipmentTypeCheck.of_istypedelivergroup( ls_nextEventType ) OR ls_nextEventType = "P" THEN
		lb_Considdered = TRUE
		IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
			ls_pcm = lstr_company.co_pcm
			
			
			//if null at this point and Quickmatch isValid , add to a list of siteIds
			IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected  THEN
				idw_qm.of_addUnidentifiedId( ll_siteId )
			END IF
		ELSE
			setnull(ls_pcm)
		END IF
	
		//enhancement
		IF lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
			lb_found = true
		ELSE
			//get the distance between the two locations
			gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
			IF lc_miles <= anv_data.il_withinDistance /*OR ( lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState ) */THEN
				lb_Found = TRUE
				//MessageBox("Event2", lc_miles)
			END IF
		END IF	//end enhancement
	ELSE
		IF lb_Considdered THEN 
			lb_Stop = TRUE
		END IF
	END IF
END IF


IF NOT lb_found AND NOT lb_stop THEN
	//if next event 3 type 
	ls_nextEventType = idw_requestor.getItemString( ll_index, "nextevent3_type" )
	ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent3_siteid" )
	//stored in the cashe is a 2 character value, this function converts it to the one character value
	ls_nextEventType = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEventType )
	IF lnv_shipmentTypeCheck.of_istypedelivergroup( ls_nextEventType ) OR ls_nextEventType = "P" THEN
		lb_Considdered = TRUE
		IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
			ls_pcm = lstr_company.co_pcm
			
			//if null at this point and Quickmatch isValid , add to a list of siteIds
			IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
				idw_qm.of_addUnidentifiedId( ll_siteId )
			END IF
//									IF idw_requestor.getitemstring(ll_index, "nextevent3_city") = "INDIANAPOLIS" THEN
//										MessageBox("3rd case", LS_PCM)
//									END IF
		ELSE
			setnull(ls_pcm)
		END IF
	
		//enhancement
		IF lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
			lb_found = true
		ELSE
			
			//get the distance between the two locations
			gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)

			//if it is in the required distance, or if the state and city names are the same
			IF lc_miles <= anv_data.il_withinDistance /*OR ( lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState ) */THEN
				//MessageBox("Event3", lc_miles)
				lb_Found = TRUE
			END IF
		END IF	//end enhancement
	ELSE 
		IF lb_Considdered THEN
			lb_Stop = TRUE
		END IF
	END IF
END IF


IF NOT lb_STOP AND NOT lb_found THEN
	//if next event 4 type 
	ls_nextEventType = idw_requestor.getItemString( ll_index, "nextevent4_type" )
	ll_siteId = idw_requestor.getItemNumber( ll_index, "nextEvent4_siteid" )
	//stored in the cashe is a 2 character value, this function converts it to the one character value
	ls_nextEventType = lnv_shipmentTypeCheck.of_getTypeDataValueShort( ls_nextEventType )
	IF lnv_shipmentTypeCheck.of_istypedelivergroup( ls_nextEventType ) OR ls_nextEventType = "P" THEN
	
		lb_Considdered = TRUE
		IF gnv_cst_companies.of_get_info(ll_siteId, lstr_company, false) = 1 THEN
			ls_pcm = lstr_company.co_pcm
			
			//if null at this point and Quickmatch isValid , add to a list of siteIds
			IF isNull( ls_pcm ) AND NOT isnULL(ll_siteId) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
				idw_qm.of_addUnidentifiedId( ll_siteId )
			END IF
			
		ELSE
			setnull(ls_pcm)
		END IF
	
		//enhancement
		IF lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
			lb_found = true
		ELSE
			//get the distance between the two locations
			gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)

			IF lc_miles <= anv_data.il_withinDistance /*OR ( lstr_company.co_city = anv_data.is_intoCity AND lstr_company.co_state = anv_data.is_IntoState )*/ THEN
				lb_Found = TRUE
				//MessageBox("Event4", lc_miles)
			END IF
		END IF	//end enhancemnet
	END IF
END IF
	
//	IF NOT lb_Found THEN
//		IF isNull(ls_pcm) THEN
//			//MessageBox("Filtered", "null")
//		END IF
//		//MessageBox("Filtered", lc_miles)
//		//idw_requestor.rowsmove(ll_index, 
//, primary!, idw_requestor, 9999, filter!)
//	END IF
return not lb_found
end function

public function integer of_cachelogic (integer ai_mode, n_cst_restrictioncriteria anv_data);Int	li_return

Long	ll_index
Long	ll_rowNum
//Long	ll_siteid
//Long	ll_minutes
//
//String	ls_PCM
//String	ls_nextEventType
//
//s_co_info lstr_company
//decimal {1} lc_miles
//
//Boolean	lb_considdered
//Boolean  lb_found
//Boolean	lb_stop

boolean	lb_oldcode
boolean lb_moveRows
boolean 	lb_moveGroup
Boolean	lb_checkallRows
Boolean	lb_keepGroup

Long	ll_groupStart
Long	ll_groupEnd

String	ls_columntag	

Long	ll_groupfiltered

n_cst_events	lnv_shipmentTypeCheck
ll_rowNum = idw_requestor.RowCount()

IF ai_mode = ci_intomode OR ai_mode = ci_outofmode THEN
	li_return = 1
ELSE
	li_return = -1
END IF
	
IF li_return = 1 THEN
	
	IF isNumber(idw_requestor.describe("datawindow.header.1.height")) THEN
				
		IF ll_rowNum > 0 THEN
			ls_columnTag = idw_requestor.Describe("#1.tag")
		
			lb_checkAllRows = Match( lower(ls_columnTag), lower(cs_checkrowstag) )
			lb_KeepGroup = Match( lower(ls_columnTag), lower(cs_keepgrouptag) )
			
			ll_groupStart = 1
			ll_groupEnd = 1
			
			DO WHILE ll_groupStart > 0 AND ll_groupENd >= ll_groupStart
				lb_moveGroup = true
				
				IF ll_groupStart +1 <= ll_rowNum THEN
					ll_groupEnd = idw_requestor.FindGroupChange(ll_groupStart+1, 1) - 1
				ELSE
					ll_groupEnd = ll_rowNum
				END IF
				//check the first row for the tag "CHECKROWS" in the first column
				IF lb_checkAllRows THEN
					//CHECK for the tag "KEEPGROUP" in the first column
					IF lb_keepGroup THEN
						//if one row passed then keep the entire group
						//if no row passed then trash the entire group
						FOR ll_index = ll_groupStart TO ll_groupEnd
							//if we want to keep the row
							IF ai_mode = ci_intomode THEN
								lb_moveGroup = this.of_moveintocachelogic( ll_index, anv_data)
							ELSE
								lb_moveGroup = this.of_moverowoutofcachelogic( ll_index, anv_data )
							END IF
							IF NOT lb_moveGroup THEN
								EXIT
							END IF
						NEXT
						
					ELSE
						//if row passes, keep just that row
						//if row fails, then move that row
						//old code
						lb_oldCode = true
						lb_moveGroup = false
						EXIT
					END IF
				ELSE
					//test the first row of the group
					//if the first row passes, keep the entire group
					//if the first row fails, trash the entire group
					
					IF ai_mode = ci_intomode THEN
						lb_moveGroup = this.of_moveintocachelogic( ll_groupStart, anv_data)
					ELSE
						lb_moveGroup = this.of_moverowoutofcachelogic( ll_groupStart, anv_data )
					END IF
				END IF
				
				IF lb_moveGroup THEN
					//MessageBox("Move Rows", string(ll_groupStart)+ " "+ string(ll_groupEnd) )
					idw_requestor.rowsmove(ll_groupStart, ll_groupEnd, primary!, idw_requestor, 1, filter!)
					//ll_groupstart doesn't change, the next group will now be located at the current groupstart
					//row. IF the last group is removed, then making the following call should reset groupstart
					//to 0 and make it drop out of the loop
					ll_groupfiltered++
					ll_groupStart = idw_requestor.FindGroupChange(ll_groupStart, 1)
				ELSE
					//gets the next group starting index(must increment by 1 because if you call the function
					//on the first row of the group, it returns the same row that you pass in)
					//MessageBox("Keep Rows", string(ll_groupStart)+ " "+ string(ll_groupEnd) )
					ll_groupStart = idw_requestor.FindGroupChange(ll_groupStart+1, 1)
				//	MessageBox("Keep Rows", string(ll_groupStart)+ " "+ string(ll_groupEnd) )
				END IF
				ll_groupEnd = idw_requestor.FindGroupChange(ll_groupStart+1, 1) - 1
			LOOP
			//messagebox("total groups filtered",ll_groupfiltered)
		END IF
	ELSE
		//not a group
		//do old code
		lb_oldCode = true
	END IF
	
	IF lb_oldCode THEN
		
		FOR ll_index = ll_rowNum TO 1 Step -1
			//returns true if the row should be moved according to intocachelogic
			IF ci_intomode = ai_mode THEN
				lb_moveRows = this.of_moveintocachelogic( ll_index, anv_data)
			ELSE
				lb_moveRows = this.of_moverowoutofcachelogic( ll_index, anv_data)	
			END IF
			
			IF lb_moveRows then
				idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
			END IF
	
		NEXT
	END IF	
END IF

return li_return
end function

public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows, ref boolean ab_keepgroup);/***************************************************************************************
NAME: 			of_checkcriteria

ACCESS:			public
		
ARGUMENTS: 		
							ai_mode:		1	out of 
											0  into
							al_index:	the row that is being checked on idw_requestor
							anv_data:	the restriction criteria
							
							ab_checkComputes:  whether or not this thing is checking computed fields
RETURNS:			true if the row meets the criteria
					false otherwise
	
DESCRIPTION:	The following checks all the objects in the dataobject for tags and 
					does a location comparison using pcmiler with the data passed in.
					If it meets the requirement it keeps it.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan	11=-7-05
	

***************************************************************************************/

Long 	ll_index
Long	ll_max


Boolean	lb_checkComputes
Boolean	lb_return

String	ls_columnTag
String	ls_locator
String	ls_pcm


n_cst_routing	lnv_routing
s_co_info lstr_company
n_cst_licensemanager	lnv_licensemanager
decimal {1} lc_miles

Long		ll_id
Long		ll_minutes


IF isValid( idw_requestor )  AND al_index > 0 /* AND ib_pcMilerConnected*/ THEN

	lb_checkComputes = ab_checkComputes
	
	ll_max = Long(idw_Requestor.Object.DataWindow.Column.Count)	
	IF ai_mode = ci_outOfMode THEN
		
		IF this.of_outOfNonCacheCheck( al_index, anv_data, lb_checkComputes, ab_checkAllRows, ab_keepGroup) THEN
			RETURN TRUE
		ELSE
			lb_return = false
		END IF
			
		  
	ELSEIF Ai_mode = ci_intoMode THEN
		
		IF this.of_intoNonCacheCheck( al_index, anv_data, lb_checkComputes, ab_checkallrows, ab_keepgroup ) THEN
			RETURN TRUE
		ELSE
			lb_return = false
		END IF

	END IF
	RETURN lb_return		//nothing found
END IF 

RETURN FALSE			//required objects not valid
end function

public function boolean of_intononcachecheck (long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows, ref boolean ab_keepgroup);/***************************************************************************************
NAME: 		of_intoNonCacheCheck	

ACCESS:			public
		
ARGUMENTS: 		
							al_index:	the row you are looking at
							anv_data:	the data restricting against
							ab_checkComputes:	true if we are checking computed fields as well.

RETURNS:			True if the object matched the criteria
					False otherwise
	
DESCRIPTION:	The following checks the row against columns and sometimes computes that
					have the into tag in them.  
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 11-16-2005
	enhanced on 11-18-05 by Dan, no longer does distance lookups if the name and city match.

***************************************************************************************/

Long 	ll_index
Long	ll_max


Boolean	lb_checkComputes
Boolean	lb_return

String	ls_columnTag
String	ls_locator
String	ls_pcm


n_cst_routing	lnv_routing
s_co_info lstr_company
n_cst_licensemanager	lnv_licensemanager
decimal {1} lc_miles

Long		ll_id
Long		ll_minutes

//checks columns for tags
lb_checkComputes = ab_checkComputes

ll_max = Long(idw_Requestor.Object.DataWindow.Column.Count)	

//check columns for the tags
FOR ll_index = 1 TO ll_max
	ls_columnTag = idw_requestor.Describe("#"+String(ll_Index)+".tag")
	
	IF ls_ColumnTag <> "?" AND ls_ColumnTag <> "!" THEN
		
		IF match( ls_columnTag, cs_checkrowstag ) THEN
			ab_checkAllrows = true
		END IF
		
		IF match( ls_columnTag, cs_keepgrouptag ) THEN
			ab_keepgroup = true
		END IF
			
		IF Match( ls_columnTag, "Restrict[ ]*=[ ]*Into" ) THEN

			//get locationVariable
			IF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Id" ) THEN
				ll_id = idw_requestor.getItemNumber( al_index, ll_index ) 
				IF ll_id > 0 THEN 
					IF gnv_cst_companies.of_get_info(ll_Id, lstr_company, false) = 1 THEN
						
						ls_locator = lstr_company.co_pcm
						
						//if null at this point and Quickmatch isValid , add to a list of siteIds
						IF isNull( ls_locator ) AND NOT isnULL(ll_Id) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
							idw_qm.of_addUnidentifiedId( ll_Id )
						END IF
					ELSE
						setnull( ls_pcm )
					END IF
				END IF
			ELSEIF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Locator" ) THEN
				ls_locator = idw_requestor.getItemString( al_index, ll_index )
			END IF
			IF NOT isNull(ls_Locator) AND Len(ls_Locator) > 0 THEN
				IF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
					RETURN TRUE						//PCMiler doesn't have to be not connected.
				ELSEIF ib_PCMilerConnected THEN
					IF inv_routing.of_locationcheck(ls_locator, ls_pcm, false) > 0 THEN
						
						gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
			
						//if it is in the required distance, or if the state and city names are the same
						IF anv_data.il_withinDistance >= lc_miles /*OR ( lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState )*/THEN
							return TRUE
						ELSE
							lb_return = FALSE	//not found keep looking
						END IF
					END IF
//				ELSEIF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
//					RETURN TRUE						//PCMiler not connected.
				END IF
			END iF
		END IF
	END IF
NEXT

IF lb_checkComputes  THEN
	ll_max = upperBound( isa_computedObjects )
	FOR ll_index = 1 TO ll_max
		ls_columnTag = idw_requestor.Describe( isa_computedObjects[ll_index]+".tag")
		IF ls_ColumnTag <> "?" AND ls_ColumnTag <> "!" THEN
			
			IF match( ls_columnTag, cs_checkrowstag ) THEN
				ab_checkAllrows = true
			END IF
			
			IF match( ls_columnTag, cs_keepgrouptag ) THEN
				ab_keepgroup = true
			END IF
			
			
			IF Match( ls_columnTag, "Restrict[ ]*=[ ]*Into" ) THEN

				//get locationVariable
				IF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Id" ) THEN
					ll_id = idw_requestor.getItemNumber( al_index, isa_computedObjects[ll_index] ) 
					IF ll_id > 0 THEN 
						IF gnv_cst_companies.of_get_info(ll_Id, lstr_company, false) = 1 THEN
							ls_locator = lstr_company.co_pcm
							
							//if null at this point and Quickmatch isValid , add to a list of siteIds
							IF isNull( ls_locator ) AND NOT isnULL(ll_Id) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
								idw_qm.of_addUnidentifiedId( ll_Id )
							END IF
						ELSE
							setnull( ls_pcm )
						END IF
					END IF
				ELSEIF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Locator" ) THEN
					ls_locator = idw_requestor.getItemString( al_index, isa_computedObjects[ll_index] )
				END IF
				
				IF NOT isNull(ls_Locator) AND Len(ls_Locator) > 0 THEN
					IF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
						RETURN TRUE								//PCMiler doesn't have to be connected.	
					ELSEIF IB_PCMilerConnected THEN
						IF inv_routing.of_locationcheck(ls_locator, ls_pcm, false) > 0 THEN
							
							gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
				
							//if it is in the required distance, or if the state and city names are the same
							IF anv_data.il_withinDistance >= lc_miles /*OR ( lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState )*/THEN
								return TRUE
							ELSE
								lb_return = FALSE	//not found keep looking
							END IF
						END IF
//					ELSEIF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
//						RETURN TRUE								//PCMiler not connected.		
					END IF
				END IF
			END IF
		END IF
	NEXT
END IF

RETURN lb_return
end function

public function boolean of_outofnoncachecheck (long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows, ref boolean ab_keepgroup);/***************************************************************************************
NAME: 		of_outofNonCacheCheck	

ACCESS:			public
		
ARGUMENTS: 		
							al_index:	the row you are looking at
							anv_data:	the data restricting against
							ab_checkComputes:	true if we are checking computed fields as well.

RETURNS:			True if the object matched the criteria
					False otherwise
	
DESCRIPTION:	The following checks the row against columns and sometimes computes that
					have the outof tag in them.  
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 11-16-2005
	enhanced on 11-18-05 by Dan, no longer does distance lookups if the name and city match.

***************************************************************************************/
Long 	ll_index
Long	ll_max


Boolean	lb_checkComputes
Boolean	lb_return

String	ls_columnTag
String	ls_locator
String	ls_pcm


n_cst_routing	lnv_routing
s_co_info lstr_company
n_cst_licensemanager	lnv_licensemanager
decimal {1} lc_miles

Long		ll_id
Long		ll_minutes

//checks columns for tags
lb_checkComputes = ab_checkComputes

ll_max = Long(idw_Requestor.Object.DataWindow.Column.Count)	
FOR ll_index = 1 TO ll_max
	ls_columnTag = idw_requestor.Describe("#"+String(ll_Index)+".tag")
	IF ls_ColumnTag <> "?" AND ls_ColumnTag <> "!" THEN
		
		IF match( ls_columnTag, cs_checkrowstag ) THEN
			ab_checkAllrows = true
		END IF
		
		IF match( ls_columnTag, cs_keepgrouptag ) THEN
			ab_keepgroup = true
		END IF
		
		IF Match( ls_columnTag, "Restrict[ ]*=[ ]*Outof" ) THEN

			//get locationVariable
			IF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Id" ) THEN
				ll_id = idw_requestor.getItemNumber( al_index, ll_index ) 
				IF ll_id > 0 THEN 
					IF gnv_cst_companies.of_get_info(ll_Id, lstr_company, false) = 1 THEN
						ls_locator = lstr_company.co_pcm
						
						//if null at this point and Quickmatch isValid , add to a list of siteIds
						IF isNull( ls_locator ) AND NOT isnULL(ll_Id) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
							idw_qm.of_addUnidentifiedId( ll_Id )
						END IF
					ELSE
						setnull( ls_pcm )
					END IF
				END IF
			ELSEIF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Locator" ) THEN
				ls_locator = idw_requestor.getItemString( al_index, ll_index )
			END IF
			
			IF NOT isNull(ls_Locator) AND Len(ls_Locator) > 0 THEN
				IF lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState THEN
					RETURN TRUE			//PCMiler doesn't have to be connected.
				ELSEIF ib_pcMilerConnected THEN
					IF inv_routing.of_locationcheck(ls_locator, ls_pcm, false) > 0 THEN
						
						gf_calc_miles( anv_data.is_outof_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
			
						//if it is in the required distance, or if the state and city names are the same
						IF anv_data.il_withinDistance >= lc_miles /*OR ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState )*/THEN
							return TRUE
						ELSE
							lb_return = FALSE	//not found keep looking
						END IF
					END IF
//				ELSEIF lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState THEN
//					RETURN TRUE			//PCMiler not connected.
				END IF
			END IF
		END IF
	END IF
NEXT

//not found in column values, look at computed fields.

IF lb_checkComputes  THEN
	ll_max = upperBound( isa_computedObjects )
	FOR ll_index = 1 TO ll_max
		ls_columnTag = idw_requestor.Describe( isa_computedObjects[ll_index]+".tag")
		IF ls_ColumnTag <> "?" AND ls_ColumnTag <> "!" THEN
			
			IF match( ls_columnTag, cs_checkrowstag ) THEN
				ab_checkAllrows = true
			END IF
			
			IF match( ls_columnTag, cs_keepgrouptag ) THEN
				ab_keepgroup = true
			END IF
			
			IF Match( ls_columnTag, "Restrict[ ]*=[ ]*Outof" ) THEN

				//get locationVariable
				IF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Id" ) THEN
					ll_id = idw_requestor.getItemNumber( al_index, isa_computedObjects[ll_index] ) 
					IF ll_id > 0 THEN 
						IF gnv_cst_companies.of_get_info(ll_Id, lstr_company, false) = 1 THEN
							ls_locator = lstr_company.co_pcm
							
							//if null at this point and Quickmatch isValid , add to a list of siteIds
							IF isNull( ls_locator ) AND NOT isnULL(ll_Id) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
								idw_qm.of_addUnidentifiedId( ll_Id )
							END IF
						ELSE
							setnull( ls_pcm )
						END IF
					END IF
				ELSEIF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Locator" ) THEN
					ls_locator = idw_requestor.getItemString( al_index, isa_computedObjects[ll_index] )
				END IF
				
				IF NOT isNull(ls_Locator) AND Len(ls_Locator) > 0 THEN
					IF lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState THEN
						RETURN TRUE					//PCMiler doesn't have to be connected.
					ELSEIF ib_PCMilerConnected THEN
						IF inv_routing.of_locationcheck(ls_locator, ls_pcm, false) > 0 THEN
							
							gf_calc_miles( anv_data.is_outof_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
				
							//if it is in the required distance, or if the state and city names are the same
							IF anv_data.il_withinDistance >= lc_miles /*OR ( lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState )*/THEN
								return TRUE
							ELSE
								lb_return = FALSE	//not found keep looking
							END IF
						END IF
//					ELSEIF lstr_company.co_city = anv_data.is_outOfCity AND lstr_company.co_state = anv_data.is_outOfState THEN
//						RETURN TRUE					//PCMiler not connected.
					END IF
				END IF
			END IF
		END IF
	NEXT
END IF

Return lb_return
end function

public function integer of_noncachelogic (integer ai_mode, n_cst_restrictioncriteria anv_data);Long	ll_rowNum
Long	ll_groupStart
Long	ll_groupEnd
Boolean 	lb_checkRows
Boolean	lb_keepgroup
Boolean	lb_moveGroup
Boolean	lb_oldCode
Boolean	lb_checkComputes
Long		ll_index
Int	li_return
IF ai_mode = ci_intomode OR ai_mode = ci_outofmode THEN
	li_return = 1
	
ELSE
	li_return  = -1
	
END IF

IF li_return = 1 THEN
	ll_rowNum = idw_requestor.rowCount()
	IF upperBound( isa_computedObjects ) > 0 THEN
		//get a list of computed field object names, in the detail, both visible and nonvisible
		lb_checkComputes = true
	END IF
	
	IF isNumber(idw_requestor.describe("datawindow.header.1.height")) THEN

		IF ll_rowNum > 0 THEN
			ll_groupStart = 1
			ll_groupEnd = 1
			
			DO WHILE ll_groupStart > 0 AND ll_groupENd >= ll_groupStart
				lb_moveGroup = true
				
				IF ll_groupStart +1 <= ll_rowNum THEN
					ll_groupEnd = idw_requestor.FindGroupChange(ll_groupStart+1, 1) - 1
				ELSE
					ll_groupEnd = ll_rowNum
				END IF
				//check the first row, this check will also return by reference, lb_checkRows if it finds a tag
				//that says that it should.
				IF NOT of_checkCriteria( ai_mode, ll_groupStart, anv_data, lb_checkComputes, lb_checkRows, lb_keepGroup  ) THEN
					IF lb_checkRows THEN
						lb_checkComputes = false
						
						IF lb_keepGroup THEN
							//loop through all other rows, if we find a row that meets the criteria then keep the group 
							FOR ll_index = ll_groupStart + 1 TO ll_groupEnd
								IF this.of_checkCriteria( ai_mode, ll_index, anv_data, lb_checkComputes, lb_keepGroup) THEN
									lb_moveGroup = false
									exit
								END IF
							NEXT
						ELSE
							//do old code, throwing away and keeping row by row
							lb_moveGroup = false
							lb_oldCode = true
							EXIT				//drop out of do while loop and evaluate every row
						END IF
					ELSE
						//first row failed, not checking rows.
						//filter the entire group
						lb_moveGroup = true
					END IF
				ELSE									//first row we are keeping
					IF lb_checkRows THEN
						IF lb_keepGroup THEN
							//don't move the group
							lb_moveGroup = false
						ELSE
							//first row passed, chekcing all rows, but we aren't keeping the group
							//that means do old code, filtering out row by row
							lb_moveGroup = false
							lb_oldCode = true
							EXIT
						END IF
						//check all the rows
					ELSE
						//keep the group
						lb_moveGroup = false
					END IF
				END IF
				
				IF lb_moveGroup THEN
					//filter the entire group
					idw_requestor.rowsmove(ll_groupStart, ll_groupEnd, primary!, idw_requestor, 9999, filter!)
					//ll_groupstart doesn't change, the next group will now be located at the current groupstart
					//row. IF the last group is removed, then making the following call should reset groupstart
					//to 0 and make it drop out of the loop
					ll_groupStart = idw_requestor.FindGroupChange(ll_groupStart, 1)
				ELSE
					//gets the next group starting index(must increment by 1 because if you call the function
					//on the first row of the group, it returns the same row that you pass in)
					ll_groupStart = idw_requestor.FindGroupChange(ll_groupStart+1, 1)
				END IF
				ll_groupEnd = idw_requestor.FindGroupChange(ll_groupStart+1, 1) - 1
			LOOP
		END IF
	ELSE
		//Get out of location from criteria
		//Get distance from criteria 
		lb_oldCode = true
	END IF
	
	//-----old code---------------
	//Get out of location from criteria
	//Get distance from criteria 
	IF lb_oldCode THEN
		For ll_index = ll_rowNum TO 1 Step -1
			IF NOT this.of_checkCriteria( ai_mode, ll_index, anv_data, lb_checkComputes ) THEN
				idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
			END IF			
		NEXT
	END IF
END IF

RETURN LI_RETURN
	
end function

on n_cst_dwsrv_restrict_shipments.create
call super::create
end on

on n_cst_dwsrv_restrict_shipments.destroy
call super::destroy
end on

event ue_restrict;call super::ue_restrict;/***************************************************************************************
NAME: 	ue_restrict		

ACCESS:		public	
		
ARGUMENTS: 		
							anv_data:  		 the data in which this will be restricted on
							anv_quickmatch: The dw that called this.	

RETURNS:			none
	
DESCRIPTION:	Restricts all shipment dws based on criteria specified in anv_data.

					The algorithm for cache is different than it is for non cache.
					Cache uses a combination of all the events and does different things
					depending on whether or not your trying to find shipments that get you
					into or out of or possibly into and out of an area.
					
					Non cache uses tags, that are specified in of_checkcriteria
	
					
					
					

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan	11-7-05
						modified 3-10-06 to handle groups and do different things depending on tags.
							Tags:  CHECKROWS, and KEEPGROUP

***************************************************************************************/

Long	ll_rowNum
Long	ll_index

Long		ll_siteId
Long		ll_minutes
String	ls_nextEventType
String	ls_nextEvent2Type
String	ls_location

Boolean	lb_considdered
Boolean	lb_found
Boolean	lb_stop
Boolean	lb_checkComputes

String 	ls_pcm
String	lsa_resetArray[]

s_co_info lstr_company
decimal {1} lc_miles

n_cst_events	lnv_shipmentTypeCheck
n_cst_routing	lnv_routing
n_cst_licensemanager	lnv_licensemanager

Long	ll_groupStart
Long	ll_groupEnd
Boolean 	lb_checkRows
Boolean	lb_keepgroup
Boolean	lb_moveGroup
Boolean	lb_oldCode


Long	lla_temp[]

//reset the array
ila_unidentifiedLocators = lla_temp

//IF adw_quickMatch is valid it tries to set it.
this.of_setQuickMatch( adw_quickMatch )

IF isValid( anv_data ) THEN

	IF isValid( idw_requestor ) /*AND ib_pcmilerconnected */THEN
		
		isa_computedObjects = lsa_resetarray
		IF isValid( idw_requestor.inv_base ) THEN
			//get a list of computed field object names, in the detail, both visible and nonvisible
			idw_requestor.inv_base.of_getobjects( isa_computedObjects[], "compute", "*", FALSE)
			
		END IF
		
		IF anv_data.is_tab = "SHIPMENTS" THEN
			idw_requestor.setredraw( FALSE )
			idw_requestor.rowsmove(1, idw_requestor.filteredcount(), filter!, idw_requestor, &
			idw_requestor.rowcount() + 1, primary!)
			idw_requestor.filter()
			idw_requestor.sort()
			idw_requestor.groupCalc( )
			ll_rowNum = idw_requestor.RowCount()
			//move rows into filter buffer based on outOf criteria	
			IF of_loadsFromCache( ) THEN
				IF anv_data.ib_outOf then
					this.of_cachelogic( ci_outofmode , anv_data )
					//this.of_outOfCacheLogic( anv_data )
	
				END IF
				//move rows into filter buffer based on into criteria			
				If anv_data.ib_into THEN
					this.of_cachelogic( ci_intomode , anv_data )
					//this.of_intoCacheLogic( anv_data )
				END IF
	
			ELSEIF  of_loadsFromDb( ) THEN
		
//				IF upperBound( isa_computedObjects ) > 0 THEN
//					//get a list of computed field object names, in the detail, both visible and nonvisible
//					lb_checkComputes = true
//				END IF
		
				IF anv_data.ib_outOf then
					this.of_noncachelogic( ci_outofmode , anv_data )
					/*
					IF isNumber(idw_requestor.describe("datawindow.header.1.height")) THEN
			
						IF ll_rowNum > 0 THEN
							ll_groupStart = 1
							ll_groupEnd = 1
							
							DO WHILE ll_groupStart > 0 AND ll_groupENd >= ll_groupStart
								lb_moveGroup = true
								
								IF ll_groupStart +1 <= ll_rowNum THEN
									ll_groupEnd = idw_requestor.FindGroupChange(ll_groupStart+1, 1) - 1
								ELSE
									ll_groupEnd = ll_rowNum
								END IF
								//check the first row, this check will also return by reference, lb_checkRows if it finds a tag
								//that says that it should.
								IF NOT of_checkCriteria( ci_outofmode, ll_groupStart, anv_data, lb_checkComputes, lb_checkRows, lb_keepGroup  ) THEN
									IF lb_checkRows THEN
										lb_checkComputes = false
										
										IF lb_keepGroup THEN
											//loop through all other rows, if we find a row that meets the criteria then keep the group 
											FOR ll_index = ll_groupStart + 1 TO ll_groupEnd
												IF this.of_checkCriteria( ci_outofMode, ll_index, anv_data, lb_checkComputes, lb_keepGroup) THEN
													lb_moveGroup = false
													exit
												END IF
											NEXT
										ELSE
											//do old code, throwing away and keeping row by row
											lb_moveGroup = false
											lb_oldCode = true
											EXIT				//drop out of do while loop and evaluate every row
										END IF
									ELSE
										//first row failed, not checking rows.
										//filter the entire group
										lb_moveGroup = true
									END IF
								ELSE									//first row we are keeping
									IF lb_checkRows THEN
										IF lb_keepGroup THEN
											//don't move the group
											lb_moveGroup = false
										ELSE
											//first row passed, chekcing all rows, but we aren't keeping the group
											//that means do old code, filtering out row by row
											lb_moveGroup = false
											lb_oldCode = true
											EXIT
										END IF
										//check all the rows
									ELSE
										//keep the group
										lb_moveGroup = false
									END IF
								END IF
								
								IF lb_moveGroup THEN
									//filter the entire group
									idw_requestor.rowsmove(ll_groupStart, ll_groupEnd, primary!, idw_requestor, 9999, filter!)
									//ll_groupstart doesn't change, the next group will now be located at the current groupstart
									//row. IF the last group is removed, then making the following call should reset groupstart
									//to 0 and make it drop out of the loop
									ll_groupStart = idw_requestor.FindGroupChange(ll_groupStart, 1)
								ELSE
									//gets the next group starting index(must increment by 1 because if you call the function
									//on the first row of the group, it returns the same row that you pass in)
									ll_groupStart = idw_requestor.FindGroupChange(ll_groupStart+1, 1)
								END IF
							LOOP
						END IF
					ELSE
						//Get out of location from criteria
						//Get distance from criteria 
						lb_oldCode = true
					END IF
					
					//-----old code---------------
					//Get out of location from criteria
					//Get distance from criteria 
					IF lb_oldCode THEN
						For ll_index = ll_rowNum TO 1 Step -1
							IF NOT this.of_checkCriteria( ci_outofmode, ll_index, anv_data, lb_checkComputes ) THEN
								idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
							END IF			
						NEXT
					END IF
					*/
				END IF	
				
				IF anv_data.ib_into THEN
					this.of_noncachelogic( ci_intomode , anv_data )
					/*
					ll_rowNum = idw_Requestor.RowCount()
					FOR ll_index = ll_rowNum TO 1 Step -1	
						IF NOT this.of_checkCriteria( ci_intomode , ll_index, anv_data, lb_checkComputes ) THEN
							idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
						END IF
					NEXT
					*/
				END IF
			END IF //end if loads from db
		END IF// end if SHIPMENTS
		idw_requestor.setredraw( TRUE )
	END IF	//end if isvalid(idw_requestor) and ib_pcmiler connected
END IF
end event

event ue_clearrestriction;call super::ue_clearrestriction;IF (as_dwType = "SHIPMENT" OR as_dwTYPE = "ALL" ) AND isValid( idw_requestor ) THEN
//	IF idw_requestor.title = "Orig Dest List" THEN
//	Messagebox("before",idw_requestor.rowCOunt())
//END IF
	idw_requestor.rowsMove( 1, idw_requestor.filteredCount() , FILTER!, idw_requestor, 99999, PRIMARY! )
	idw_requestor.filter()
	idw_requestor.sort()
	idw_requestor.groupCalc( )
//	IF idw_requestor.title = "Orig Dest List" THEN
//	Messagebox("after",idw_requestor.rowCOunt())
//END IF
END IF
end event

