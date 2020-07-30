$PBExportHeader$n_cst_dwsrv_restrict_driverequip.sru
forward
global type n_cst_dwsrv_restrict_driverequip from n_cst_dwsrv_restrict
end type
end forward

global type n_cst_dwsrv_restrict_driverequip from n_cst_dwsrv_restrict
end type
global n_cst_dwsrv_restrict_driverequip n_cst_dwsrv_restrict_driverequip

forward prototypes
public function boolean of_checkcurrentlocation (long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes)
public function boolean of_checkfirstandlast (long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes)
public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows)
public function boolean of_checkalllocations (long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows)
public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows, ref boolean ab_keepgroup)
end prototypes

public function boolean of_checkcurrentlocation (long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes);/**************************************************************************************
ACCESS:			public
		
ARGUMENTS: 		
							al_index:	the index of the row for idw_requestor we are looking at
							anv_data:	the criteria we are matching against
							ab_checkComputes:	true if we are checking computed fields as well as 
													columns.

RETURNS:			true if it meets the criteria
					false otherwise
	
DESCRIPTION:	The following logic works for a noncache drivers and equipment dataobjects 
					only the current or last confirmed location of the driver.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	11-16-2005
		Enhanced 11-18-05 so that it checks for exact city state matches before it bothers to nake
				lookups in pcmiler.

***************************************************************************************/


Long 	ll_index
Long	ll_max
Long	ll_id
Long	ll_minutes


String	ls_columnTag
String	ls_locator
String	ls_PCM

Boolean	lb_checkComputes
Boolean	lb_return

decimal {1} lc_miles
s_co_info lstr_company

ll_max = Long(idw_Requestor.Object.DataWindow.Column.Count)

lb_checkComputes = ab_checkComputes

FOR ll_index = 1 TO ll_max
	ls_columnTag = idw_requestor.Describe("#"+String(ll_Index)+".tag")

	IF Match( ls_columnTag, "Restrict[ ]*=[ ]*Current[ ]*Position" ) OR Match( ls_columnTag, "Restrict[ ]*=[ ]*Last[ ]*Reported" ) THEN
		
		//get the location variable
		//Find restriction type in tag (id, locator)	
		IF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Id" ) THEN
			ll_id = idw_requestor.getItemNumber( al_index, ll_index ) 
			IF gnv_cst_companies.of_get_info(ll_Id, lstr_company, false) = 1 THEN
				ls_locator = lstr_company.co_pcm
				
				//if null at this point and Quickmatch isValid , add to a list of siteIds
				IF isNull( ls_locator ) AND NOT isnULL(ll_Id) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
					idw_qm.of_addUnidentifiedId( ll_Id )
				END IF
			ELSE
				setnull( ls_pcm )
			END IF
		
		ELSEIF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Locator" ) THEN
			ls_locator = idw_requestor.getItemString( al_index, ll_index )
		END IF	
		
		
		IF NOT isNull(ls_Locator) AND Len(ls_Locator) > 0 THEN
			//enhancement
			IF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
					RETURN TRUE
			ELSEIF ib_pcMilerConnected THEN
				IF inv_routing.of_locationcheck(ls_locator, ls_pcm, false) > 0 THEN					
							
					gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
		
					
					IF anv_data.il_withinDistance >= lc_miles /*OR ( lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState )*/THEN
						RETURN TRUE
					ELSE
						lb_return = FALSE
					END IF
				END IF
			//if pcmiler is not connected we try to do a limited match based on city and state being equal
//			ELSEIF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
//					RETURN TRUE
				
			END IF
		END IF
		
	END IF
NEXT

IF lb_checkComputes THEN
	ll_max = upperBound( isa_computedObjects )
	FOR ll_index = 1 TO ll_max
		ls_columnTag = idw_requestor.Describe( isa_computedObjects[ll_index]+".tag")

		IF Match( ls_columnTag, "Restrict[ ]*=[ ]*Current[ ]*Position" ) OR Match( ls_columnTag, "Restrict[ ]*=[ ]*Last[ ]*Reported" ) THEN
		//get the location variable
		//Find restriction type in tag (id, locator)

			IF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Id" ) THEN
				ll_id = idw_requestor.getItemNumber( al_index, isa_computedObjects[ll_index] ) 
				IF gnv_cst_companies.of_get_info(ll_Id, lstr_company, false) = 1 THEN
					ls_locator = lstr_company.co_pcm
					
					//if null at this point and Quickmatch isValid , add to a list of siteIds
					IF isNull( ls_locator ) AND NOT isnULL(ll_Id) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
						idw_qm.of_addUnidentifiedId( ll_Id )
					END IF
				ELSE
					setnull( ls_pcm )
				END IF
			
			ELSEIF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Locator" ) THEN
				ls_locator = idw_requestor.getItemString( al_index, isa_computedObjects[ll_index] )
			END IF	
			IF NOT isNull(ls_Locator) AND Len(ls_Locator) > 0 THEN
				//enhancemnet
				IF lstr_company.co_city = anv_data.is_OutOfCity AND lstr_company.co_state = anv_data.is_OutOfState THEN
					RETURN TRUE
				ELSEIF ib_pcmilerconnected THEN
					IF inv_routing.of_locationcheck(ls_locator, ls_pcm, false) > 0 THEN					
								
						gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
			
						
						IF anv_data.il_withinDistance >= lc_miles OR ( lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState )THEN
							RETURN TRUE
						ELSE
							lb_return = FALSE
						END IF
					ELSE
					END IF 
				//if pcm not connected
//				ELSEIF lstr_company.co_city = anv_data.is_OutOfCity AND lstr_company.co_state = anv_data.is_OutOfState THEN
//					RETURN TRUE
				END IF
			END IF
		
		END IF
	NEXT
END IF
lb_return = FALSE

Return lb_return
end function

public function boolean of_checkfirstandlast (long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes);/****************************************************************************************
ACCESS:			public
		
ARGUMENTS: 		
							al_index:	the index of the row for idw_requestor we are looking at
							anv_data:	the criteria we are matching against
							ab_checkComputes:	true if we are checking computed fields as well as 
													columns.

RETURNS:			true if it meets the criteria
					false otherwise
	
DESCRIPTION:	The following logic works for a noncache drivers and equipment dataobjects and
					checks only the last confirmed, current, or last locations against the criteria.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	11-16-2005
	Enhanced 11-18-05 so that it checks for exact city state matches before it bothers to nake
				lookups in pcmiler.

***************************************************************************************/

Long 	ll_index
Long	ll_max	
Long	ll_id
Long	ll_minutes

String	ls_locator
String	ls_PCM
String	ls_columnTag

Boolean	lb_return
Boolean	lb_checkComputes

decimal {1} lc_miles
s_co_info lstr_company

ll_max = Long(idw_Requestor.Object.DataWindow.Column.Count)
	
lb_checkComputes = ab_checkComputes

FOR ll_index = 1 TO ll_max
	ls_columnTag = idw_requestor.Describe("#"+String(ll_Index)+".tag")
	IF Match( ls_columnTag, "Restrict[ ]*=[ ]*Current[ ]*Position" ) OR Match( ls_columnTag, "Restrict[ ]*=[ ]*Last[ ]*Reported" ) OR &
		Match( ls_columnTag, "Restrict[ ]*=[ ]*End[ ]*Route" ) OR Match( ls_columnTag, "Restrict[ ]*=[ ]*End[ ]*Trip" ) THEN
		//get the location variable
		//Find restriction type in tag (id, locator)
					
		IF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Id" ) THEN
			ll_id = idw_requestor.getItemNumber( al_index, ll_index ) 
			IF gnv_cst_companies.of_get_info(ll_Id, lstr_company, false) = 1 THEN
				ls_locator = lstr_company.co_pcm
				
				//if null at this point and Quickmatch isValid , add to a list of siteIds
				IF isNull( ls_locator ) AND NOT isnULL(ll_Id) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
					idw_qm.of_addUnidentifiedId( ll_Id )
				END IF
			ELSE
				setnull( ls_pcm )
			END IF
		ELSEIF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Locator" ) THEN
			ls_locator = idw_requestor.getItemString( al_index, ll_index )
		END IF
		
		IF NOT isNull(ls_Locator) AND Len(ls_Locator) > 0 THEN
			//enhanced
			IF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
				RETURN TRUE
			
			ELSEIF ib_PCMilerconnected THEN
				IF inv_routing.of_locationcheck(ls_locator, ls_pcm, false) > 0 THEN					
							
					gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)

					IF anv_data.il_withinDistance >= lc_miles/* OR ( lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState )*/THEN
						RETURN TRUE
					ELSE
						lb_return = FALSE
					END IF
		
				END IF
			//pcm not connected
//			ELSEIF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
//				RETURN TRUE
			END IF
		END IF	
	END IF
NEXT

IF lb_checkComputes THEN
	ll_max = upperBound( isa_computedObjects )
	
	FOR ll_index = 1 TO ll_max
		ls_columnTag = idw_requestor.Describe( isa_computedObjects[ll_index]+".tag")
		
		IF Match( ls_columnTag, "Restrict[ ]*=[ ]*Current[ ]*Position" ) OR Match( ls_columnTag, "Restrict[ ]*=[ ]*Last[ ]*Reported" ) OR &
			Match( ls_columnTag, "Restrict[ ]*=[ ]*End[ ]*Route" ) OR Match( ls_columnTag, "Restrict[ ]*=[ ]*End[ ]*Trip" ) THEN
			//get the location variable
			//Find restriction type in tag (id, locator)
						
			IF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Id" ) THEN
				ll_id = idw_requestor.getItemNumber( al_index, isa_computedObjects[ll_index] ) 
				IF gnv_cst_companies.of_get_info(ll_Id, lstr_company, false) = 1 THEN
					ls_locator = lstr_company.co_pcm
					
					//if null at this point and Quickmatch isValid , add to a list of siteIds
					IF isNull( ls_locator ) AND NOT isnULL(ll_Id) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
						idw_qm.of_addUnidentifiedId( ll_Id )
					END IF
				ELSE
					setnull( ls_pcm )
				END IF
			ELSEIF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Locator" ) THEN
				ls_locator = idw_requestor.getItemString( al_index, isa_computedObjects[ll_index] )
			END IF
			
			IF NOT isNull(ls_Locator) AND Len(ls_Locator) > 0 THEN
				//enhancemnt
				IF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN 
					RETURN TRUE
				ELSEIF ib_PCMilerconnected THEN
					
					IF inv_routing.of_locationcheck(ls_locator, ls_pcm, false) > 0 THEN					
								
						gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
						IF anv_data.il_withinDistance >= lc_miles /*OR ( lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState )*/THEN
							RETURN TRUE
						ELSE
							lb_return = FALSE
						END IF
			
					END IF
//				ELSEIF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState  THEN
//
//					RETURN TRUE
				ELSE
					//no match
				END IF
			END IF	
		END IF
	NEXT
	
END IF

lb_return = false

Return lb_return
end function

public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows);/***************************************************************************************
NAME: 		of_checkCriteria	

ACCESS:			public
		
ARGUMENTS: 		
							ai_mode: 1     Restrict based on Current location
										2		Restrict based on Current and Last location
										3		Restrict based on all locations

							anv_data:		An object containing information about the things we
												are restricting against.
												
							al_index:		The row in idw_requestor that we are checking the 
												other objects on.
							ab_checkComputes:	whether or not this function will check for computes
							
RETURNS:			TRUE if a location is found that meets the specified range in anv_data
					FALSE if no location found
	
DESCRIPTION:	This checks all of the computed objects and columns for specific tag values
					and depending on the mode, will test the values that go along with 
					the tag to see if it is within range of the restriction criteria.
					
	
					Tags: "Restrict = Current Position"
							"Restrict = Last Reported"
							"Restrict = End Route"
							"Restrict = End Trip"
							"Restrict = Stop"
							
							"RestrictColType = Id"
							"RestrictColType = Locator"

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan	11-10-2005
	

***************************************************************************************/
//;PCMiler
Long	ll_max
Long	ll_index	//columnb number
Long	ll_id
String	ls_columnTag
String	ls_locator
String	ls_pcm

Boolean	lb_return
Boolean	lb_checkComputes

decimal {1} lc_miles

Long		ll_minutes
s_co_info lstr_company

ll_max = Long(idw_Requestor.Object.DataWindow.Column.Count )
IF isValid( Idw_Requestor ) AND al_index > 0 /*AND ib_pcMilerConnected*/ THEN
	
	
	lb_checkComputes = ab_checkComputes
	
	IF ai_mode = 1 THEN								//RESTRICT on  current location
		IF this.of_checkCurrentLocation( al_index, anv_data, lb_checkComputes ) THEN
			RETURN TRUE
		ELSE
			lb_return = false
		END IF

	  
	ELSEIF  ai_mode = 2 THEN						//Restrict on first and last location
		
		IF	this.of_checkFirstAndLast( al_index, anv_data, lb_checkComputes ) THEN
			return TRUE
		ELSE
			lb_return = false
		END IF

	  
	ELSEIF ai_mode = 3 THEN							//RESTRICT on all locations
		
		IF this.of_checkAllLocations( al_index, anv_data, lb_checkComputes /* check computes */,ab_checkAllRows ) THEN
			
			RETURN TRUE
		ELSE
			lb_return = False
		END IF
	
	END IF
	lb_return = false			//nothing found to match criteria
	
END IF
RETURN lb_return			//objects were not valid
end function

public function boolean of_checkalllocations (long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows);/***************************************************************************************
NAME: 			of_checkAllLocations

ACCESS:			public
		
ARGUMENTS: 		
							al_index:	the index of the row for idw_requestor we are looking at
							anv_data:	the criteria we are matching against
							ab_checkComputes:	true if we are checking computed fields as well as 
													columns.

RETURNS:			true if it meets the criteria
					false otherwise
	
DESCRIPTION:	The following logic works for a noncache drivers and equipment dataobjects and
					checks all the locations the driver is scheduled to be at against the criteria.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	11-16-2005
				Enhanced 11-18-05 so that it checks for exact city state matches before it bothers to nake
				lookups in pcmiler.

***************************************************************************************/

Long 	ll_index
Long	ll_max	
Long	ll_id
Long	ll_minutes

String	ls_locator
String	ls_PCM
String	ls_columnTag

Boolean	lb_return
Boolean	lb_checkComputes

decimal {1} lc_miles
s_co_info lstr_company

ll_max = Long(idw_Requestor.Object.DataWindow.Column.Count)
	
lb_checkComputes = ab_checkComputes

FOR ll_index = 1 TO ll_max
	ls_columnTag = idw_requestor.Describe("#"+String(ll_Index)+".tag")
	
	IF Match( lower(ls_columnTag), lower(cs_checkrowstag) ) THEN
		ab_checkAllRows = TRUE
	END IF
	
	
	IF Match( ls_columnTag, "Restrict[ ]*=[ ]*Current[ ]*Position" ) OR Match( ls_columnTag, "Restrict[ ]*=[ ]*Last[ ]*Reported" ) OR &		
		Match( ls_columnTag, "Restrict[ ]*=[ ]*End[ ]*Route" ) OR Match( ls_columnTag, "Restrict[ ]*=[ ]*End[ ]*Trip" ) OR &		
		Match( ls_columnTag, "Restrict[ ]*=[ ]*Stop" ) THEN			
		//get the location variable
		//Find restriction type in tag (id, locator)
					
		IF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Id" ) THEN
			ll_id = idw_requestor.getItemNumber( al_index, ll_index ) 
			IF gnv_cst_companies.of_get_info(ll_Id, lstr_company, false) = 1 THEN
				ls_locator = lstr_company.co_pcm
				
				//if null at this point and Quickmatch isValid , add to a list of siteIds
				IF isNull( ls_locator ) AND NOT isnULL(ll_Id) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
					idw_qm.of_addUnidentifiedId( ll_Id )
				END IF
			ELSE
				setnull( ls_pcm )
			END IF
		ELSEIF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Locator" ) THEN
			ls_locator = idw_requestor.getItemString( al_index, ll_index )
		END IF	
		IF NOT isNull(ls_Locator) AND Len(ls_Locator) > 0 THEN
			IF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
				RETURN TRUE
			ELSEIF ib_PCMilerConnected THEN
				IF inv_routing.of_locationcheck(ls_locator, ls_pcm, false) > 0 THEN					
							
					gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
					
					IF anv_data.il_withinDistance >= lc_miles OR ( lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState )THEN
						RETURN TRUE
					ELSE
						lb_return = FALSE
					END IF
				ELSE

				END IF
//			ELSEIF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
//				RETURN TRUE
			END IF
		END IF
		
	END IF
NEXT

IF lb_checkComputes THEN
	ll_max = upperBound( isa_computedObjects )
	FOR ll_index = 1 TO ll_max
		ls_columnTag = idw_requestor.Describe( isa_computedObjects[ll_index]+".tag")
		
		IF Match( lower(ls_columnTag), lower(cs_checkrowstag) ) THEN
			ab_checkAllRows = TRUE
		END IF
		
		IF Match( ls_columnTag, "Restrict[ ]*=[ ]*Current[ ]*Position" ) OR Match( ls_columnTag, "Restrict[ ]*=[ ]*Last[ ]*Reported" ) OR &		
			Match( ls_columnTag, "Restrict[ ]*=[ ]*End[ ]*Route" ) OR Match( ls_columnTag, "Restrict[ ]*=[ ]*End[ ]*Trip" ) OR &		
			Match( ls_columnTag, "Restrict[ ]*=[ ]*Stop" ) THEN			
			//get the location variable
			//Find restriction type in tag (id, locator)
						
			IF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Id" ) THEN
				ll_id = idw_requestor.getItemNumber( al_index, isa_computedObjects[ll_index] ) 
				IF gnv_cst_companies.of_get_info(ll_Id, lstr_company, false) = 1 THEN
					ls_locator = lstr_company.co_pcm
					
					//if null at this point and Quickmatch isValid , add to a list of siteIds
					IF isNull( ls_locator ) AND NOT isnULL(ll_Id) AND isValid( idw_qm ) AND ib_PCMilerConnected THEN
						idw_qm.of_addUnidentifiedId( ll_Id )
					END IF
				ELSE
					setnull( ls_pcm )
				END IF
			ELSEIF Match( ls_columnTag, "RestrictColType[ ]*=[ ]*Locator" ) THEN
				ls_locator = idw_requestor.getItemString( al_index, isa_computedObjects[ll_index] )
			END IF	
			IF NOT isNull(ls_Locator) AND Len(ls_Locator) > 0 THEN
				IF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
					RETURN TRUE
				ELSEIF ib_pcmilerConnected THEN
					IF inv_routing.of_locationcheck(ls_locator, ls_pcm, false) > 0 THEN					
								 
						gf_calc_miles( anv_data.is_into_foundPCM , ls_pcm, lc_miles, ll_minutes, 0)
						
						IF anv_data.il_withinDistance >= lc_miles OR ( lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState )THEN
							RETURN TRUE
						ELSE
							lb_return = FALSE
						END IF
					ELSE
	
					END IF
//				ELSEIF lstr_company.co_city = anv_data.is_IntoCity AND lstr_company.co_state = anv_data.is_IntoState THEN
//					RETURN TRUE
				END IF
			END IF
			
		END IF
	NEXT
END IF  


lb_return = FALSE			//nothing found to match criteria
RETURN lb_return
end function

public function boolean of_checkcriteria (integer ai_mode, long al_index, n_cst_restrictioncriteria anv_data, boolean ab_checkcomputes, ref boolean ab_checkallrows, ref boolean ab_keepgroup);return true
end function

on n_cst_dwsrv_restrict_driverequip.create
call super::create
end on

on n_cst_dwsrv_restrict_driverequip.destroy
call super::destroy
end on

event ue_restrict;call super::ue_restrict;/***************************************************************************************
NAME: 			ue_restrict

ACCESS:			public
		
ARGUMENTS: 		
							anv_data:			describes what the object is being restricted on
							adw_quickMatch:	the quickmatch window from which the restriction
													was called.
RETURNS:			none
	
DESCRIPTION:  If a driver or equipment is suppose to be restricted, this will move
					rows into the filter that don't meet the criteria
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan	11-7-05
	

***************************************************************************************/

Long	ll_index
Long	ll_max
String	ls_className 
Boolean	lb_restrict
Boolean	lb_checkComputes
Boolean	lb_checkRows
String	lsa_resetarray[]
Long		ll_id
Long		ll_groupStart
Long		ll_groupEnd
Long		ll_idColumn 
Boolean	lb_keepGroup

String	ls_describe

//resets the quickmatch if it is valid
this.of_setquickmatch( adw_quickMatch )
ll_idColumn = this.of_getrequestoridcolumn( )

//this happens when the restrict call is made from the tab page of drivers/equipment
IF isValid( anv_data ) AND isValid( idw_requestor ) THEN
	ls_className = this.className( )
	IF anv_data.is_tab = "DRIVER_EQUIP"	 THEN	
		IF ls_className = "n_cst_dwsrv_restrict_drivers" OR ls_className = "n_cst_dwsrv_restrict_equipment" THEN
			lb_restrict = true
		END IF
	ELSEIF anv_data.is_tab = "DRIVERS" AND ls_className = "n_cst_dwsrv_restrict_drivers" THEN
		lb_restrict = true
	ELSEIF anv_data.is_tab = "EQUIPMENT" AND ls_className = "n_cst_dwsrv_restrict_equipment" THEN
		lb_restrict = true
	END IF
END IF

IF lb_restrict THEN
	idw_requestor.setredraw( FALSE )
	idw_requestor.rowsmove(1, idw_requestor.filteredcount(), filter!, idw_requestor, &
	idw_requestor.rowcount() + 1, primary!)
	idw_requestor.filter()
	idw_requestor.sort()
	idw_requestor.groupCalc( )
	
	ll_max = idw_requestor.rowCount( )
	
	isa_computedObjects = lsa_resetarray
	IF isValid( idw_requestor.inv_base ) THEN
		//get a list of computed field object names, in the detail, both visible and nonvisible
		idw_requestor.inv_base.of_getobjects( isa_computedObjects[], "compute", "*", FALSE)
		
	END IF
	
	IF upperBound( isa_computedObjects ) > 0 THEN
		//get a list of computed field object names, in the detail, both visible and nonvisible
		lb_checkComputes = true
	END IF
	
	IF anv_data.ib_Current THEN
		FOR ll_index = ll_max TO 1 Step -1
			IF NOT This.of_checkCriteria( 1, ll_index, anv_data, lb_checkComputes ) THEN		//mode 1: current
				ll_id = idw_requestor.getItemNumber( ll_index, ll_idColumn )
				idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
				
				DO WHILE ll_index - 1 > 0 
					IF ll_id = idw_requestor.getItemNumber( ll_index - 1 , ll_idColumn ) THEN
						ll_index --
						idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
					ELSE
						EXIT
					END IF
				LOOP		
			END IF
		NEXT
	//interested in first or last location
	ELSEIF anv_data.ib_firstLast THEN
		For ll_index = ll_max TO 1 Step -1
			
			IF NOT of_checkCriteria( 2, ll_index, anv_data, lb_checkComputes ) THEN 	//mode 2: first and last
				ll_id = idw_requestor.getItemNumber( ll_index, ll_idColumn )
				idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
				
				DO WHILE ll_index - 1 > 0 
					IF ll_id = idw_requestor.getItemNumber( ll_index - 1 , ll_idColumn ) THEN
						ll_index --
						idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)
					ELSE
						EXIT
					END IF
				LOOP		
			END IF	
		next
	// any location for driver/ equip
	ELSEIF anv_data.ib_allLocations THEN
		
		//added code
		
		
		IF isNumber(idw_requestor.describe("datawindow.header.1.height")) THEN
			
			IF ll_max > 0 THEN
				ll_groupStart = 1
				ll_groupEnd = 1
				
				DO WHILE ll_groupStart > 0 AND ll_groupENd >= ll_groupStart
					
					IF ll_groupStart +1 <= ll_max THEN
						ll_groupEnd = idw_requestor.FindGroupChange(ll_groupStart+1, 1) - 1
					ELSE
						ll_groupEnd = ll_max
					END IF
					//check the first row, this check will also return by reference, lb_checkRows if it finds a tag
					//that says that it should.
					IF NOT of_checkCriteria( 3, ll_groupStart, anv_data, lb_checkComputes, lb_checkRows  ) THEN
						IF lb_checkRows THEN
							lb_checkComputes = false
							
							//loop through all other rows, if we find a row that meets the criteria then keep the group 
							FOR ll_index = ll_groupStart + 1 TO ll_groupEnd
								IF this.of_checkCriteria( 3, ll_index, anv_data, lb_checkComputes) THEN
									lb_keepGroup = true
									exit
								END IF
							NEXT
						ELSE
							//filter the entire group
							lb_keepGroup = false
						END IF
					ELSE
						lb_keepGroup = true
						//keep the entire group, evaluate the rest of the groups
					END IF
					
					IF NOT lb_keepGroup THEN
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
			//not a grouping, do a row by row evaluation 
			lb_checkCOmputes = true
			For ll_index = ll_max TO 1 Step -1
				IF NOT of_checkCriteria( 3, ll_index, anv_data, lb_checkComputes ) THEN		//mode 3: all locations
					idw_requestor.rowsmove(ll_index, ll_index, primary!, idw_requestor, 9999, filter!)					
				END IF				
			next
		END IF
		

	END IF
	idw_requestor.setredraw( TRUE )
END IF
end event

