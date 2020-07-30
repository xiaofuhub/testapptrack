$PBExportHeader$n_cst_bso_routemanager.sru
forward
global type n_cst_bso_routemanager from n_cst_bso
end type
end forward

global type n_cst_bso_routemanager from n_cst_bso autoinstantiate
end type

type variables
DataStore	ids_Siteresults
DataStore		ids_ZoneResults
end variables

forward prototypes
public function integer of_getequipmentrouteid (long ala_EquipmentId [], ref long ala_RouteId [])
public function integer of_getcompanyrouteid (long ala_CompanyId [], ref long ala_RouteId [])
public function integer of_getrouteequipmentlist (n_cst_beo_event anv_event[], ref long ala_equipmentid[])
public function long of_getrouteequipmentid (n_cst_beo_event anv_eventblock[], string as_routetype)
private function long of_getequipmentbyzones (n_cst_beo_event anva_eventblock[], string as_routetype)
private function long of_searchbysite (n_cst_beo_event anva_eventblock[], string as_routetype)
private function long of_searchbyzone (n_cst_beo_event anva_eventblock[], string as_routetype)
public function integer of_getautorouteparms (ref n_cst_msg anv_msg)
end prototypes

public function integer of_getequipmentrouteid (long ala_EquipmentId [], ref long ala_RouteId []);

Return -1

end function

public function integer of_getcompanyrouteid (long ala_CompanyId [], ref long ala_RouteId []);
Return -1
end function

public function integer of_getrouteequipmentlist (n_cst_beo_event anv_event[], ref long ala_equipmentid[]);Return -1
end function

public function long of_getrouteequipmentid (n_cst_beo_event anv_eventblock[], string as_routetype);/*
	this is the top level method to autoroute
	
	This method will attempt to identify a piece of equipment that has been defined for a route
	that includes the site(s) for the events passed in.
	First the method will look for all routes that match directly based on site. Next all routes
	that match based on zones ( Zip, State ). The results from both operations will be combined.
	If more than one route is found, the user will have to select the intended route/equiment.
	The window for selection will be opened with a blob of the full state of lds_Results.
	
	the id of the selected equipment will be returned, or set to null if none is selected
	

*/

Blob			lblb_State
Long			ll_SiteCount	
Long			ll_ZoneCount
Long			ll_RowCount
Long			ll_EquipmentID
Long			ll_Ndx
String		ls_HoldRouteId
Long			ll_CopyRtn
n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm
w_RoutePickList	lw_PickList
DataStore	lds_Results

SetPointer ( HOURGLASS! )

lds_Results = CREATE datastore
lds_Results.dataobject = "d_RoutePickList"

ll_SiteCount = THIS.of_SearchBySite ( anv_eventblock , as_routetype )
ll_ZoneCount = THIS.of_SearchByZone ( anv_eventblock , as_routetype )

// Copy the results for the site query into the Results dataStore
IF ll_SiteCount > 0 THEN
	ll_CopyRtn = ids_siteresults.RowsCopy (1, ll_SiteCount, PRIMARY! , lds_Results, 999 ,PRIMARY! ) 
END IF

// Copy the results for the Zone query into the Results dataStore
IF ll_ZoneCount > 0 THEN
	ll_CopyRtn = ids_Zoneresults.RowsCopy (1, ll_ZoneCount, PRIMARY! , lds_Results, 999 ,PRIMARY! ) 
END IF

ll_RowCount = lds_Results.RowCount ( )


IF ll_RowCount > 0 THEN
	IF ll_RowCount = 1 THEN
		ll_EquipmentId = lds_Results.Object.join_route_equipment_equipmentid[1]
	ELSE
		// sort so the removal of dups algorithm works
		lds_Results.SetSort ( "route_routenumber A" ) 
		lds_Results.Sort ( )
		
		//remove duplicate routes
		ll_Ndx = 1
		DO UNTIL ll_ndx > lds_Results.RowCount()
	
			IF isnull ( lds_Results.Object.route_routenumber[ll_ndx] ) THEN
				CONTINUE
			ELSE
				IF lds_Results.Object.route_routenumber[ll_Ndx] = ls_HoldRouteId THEN
					lds_Results.RowsMove ( ll_Ndx, ll_Ndx, Primary!, lds_Results, 1,	Filter! )
				ELSE
					ls_HoldRouteId = lds_Results.Object.route_routenumber[ll_Ndx]
					ll_Ndx ++
				END IF
			END IF

		LOOP
				
		ll_RowCount = lds_Results.RowCount()
		
		IF ll_RowCount = 1 THEN
			ll_EquipmentId = lds_Results.Object.join_route_equipment_equipmentid[1]
		ELSE
			//OPENPICKLIST
			lds_Results.GetFullState ( lblb_State )
			
			lstr_Parm.is_Label = "STATE"
			lstr_Parm.ia_Value = lblb_State
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			OpenWithParm (lw_PickList, lnv_Msg , gnv_App.of_GetFrame ( )  ) 
			ll_EquipmentId = message.doubleparm
			
			IF ll_EquipmentId = 0 THEN
				Setnull ( ll_EquipmentId )
			END IF
			
		END IF
	END IF
		
END IF
	
DESTROY lds_Results
Return ll_EquipmentID


end function

private function long of_getequipmentbyzones (n_cst_beo_event anva_eventblock[], string as_routetype);Long	ll_EquipmentID = -1

//SetNull ( ll_EquipmentID )
//
//ll_EquipmentID = THIS.of_SearchByZip ( anva_eventblock , as_routetype ) 
//IF IsNull ( ll_EquipmentID ) THEN
//	ll_EquipmentID = THIS.of_SearchByState (  anva_eventblock ,as_routetype )
//END IF

RETURN ll_EquipmentID




end function

private function long of_searchbysite (n_cst_beo_event anva_eventblock[], string as_routetype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetRouteEquipmentId
//
//	Access:  public
//
//	Arguments:  anv_eventblock[] value
//					as_routetype
//
// Returns:		long	equipment id
//					null value if no id found or if none returned from picklist
//
//
//	Description:	Loop through event block and look for event types that match
//						the routetype argument.  
//
// Written by: Norm LeBlanc
// 		Date: 10/11/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//			3.5 (01.07.02) removed code to remove duplicates and retrieved into an instance
//								datastore <<*>> RPZ
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
string	ls_OriginalSelect, &
			ls_SelectList, &
			lsa_Where[], &
			ls_WhereClause, &
			ls_HoldRouteId


long	ll_EventCount, &
		ll_WhereCount, &
		ll_Ndx, &
		lla_EventSite [], &
		ll_EventSite, &
		lla_EventId
	
long	ll_RowCount		
		
	
n_cst_beo_Event 	lnv_EventBeo

ll_EventCount = upperbound ( anva_eventblock ) 

//load array of company ids
FOR ll_ndx = 1 to ll_EventCount
	
	lnv_EventBeo = anva_eventblock [ ll_ndx ]
	
	IF isvalid ( lnv_EventBeo ) THEN
		
		IF isnull(lnv_EventBeo.of_GetSite ( )) THEN
			CONTINUE
		END IF
			
		lla_EventSite [ll_ndx] = lnv_EventBeo.of_GetSite ( )
		//check event type add to where clause
		CHOOSE CASE upper ( as_routetype )
			CASE gc_Dispatch.cs_RouteType_Pickup 
				IF lnv_EventBeo.of_IsType ( gc_Dispatch.cs_EventType_Pickup ) THEN
					
					lsa_Where[upperbound(lsa_Where) + 1] = '( ~~"join_route_company~~".~~"companyid~~" = ' + &
							string (lla_EventSite [ll_ndx]) + ' and ~~"route~~".~~"type~~" = ' + &
							"'" + gc_Dispatch.cs_RouteType_Pickup + "')" + ' OR ' + &
							'( ~~"join_route_company~~".~~"companyid~~" = ' + &
							string (lla_EventSite [ll_ndx]) + ' and ~~"route~~".~~"type~~" = ' + &
							"'" + gc_Dispatch.cs_RouteType_Any + "')" 							
				END IF
													
			CASE gc_Dispatch.cs_RouteType_Deliver
				IF lnv_EventBeo.of_IsType ( gc_Dispatch.cs_EventType_Deliver ) THEN
					lsa_Where[upperbound(lsa_Where) + 1] = '( ~~"join_route_company~~".~~"companyid~~" = ' + &
							string (lla_EventSite [ll_ndx]) + ' and ~~"route~~".~~"type~~" = ' + &
							"'" + gc_Dispatch.cs_RouteType_Deliver + "')" + ' OR ' + &
							'( ~~"join_route_company~~".~~"companyid~~" = ' + &
							string (lla_EventSite [ll_ndx]) + ' and ~~"route~~".~~"type~~" = ' + &
							"'" + gc_Dispatch.cs_RouteType_Any + "')" 							
				END IF
				
			CASE gc_Dispatch.cs_RouteType_Any
				lsa_Where[upperbound(lsa_Where) + 1] = '( ~~"join_route_company~~".~~"companyid~~" = ' + &
							string (lla_EventSite [ll_ndx]) + ')'
				
		END CHOOSE
		
	END IF 
	
NEXT
//build where clause
ll_WhereCount = upperbound ( lsa_Where )

IF ll_WhereCount > 0 THEN
	
	ls_WhereClause = 'and ('
	FOR ll_ndx = 1 to ll_WhereCount
		IF ll_ndx > 1 THEN
			ls_WhereClause += " or "
		END IF
		ls_WhereClause += lsa_Where [ ll_ndx ]
		
	NEXT
	ls_WhereClause += ')'

	ids_siteresults = CREATE datastore
	ids_siteresults.dataobject = "d_RoutePickList"
	ids_siteresults.SetTransObject(SQLCA)

	ls_OriginalSelect = ids_siteresults.Object.Datawindow.Table.Select
	ids_siteresults.Object.Datawindow.Table.Select = ls_OriginalSelect + ls_WhereClause

	ids_siteresults.SetTransObject (SQLCA)
	ll_RowCount = ids_siteresults.Retrieve()
	COMMIT ;

END IF

//DESTROY lds_JoinRouteCompany
Return ll_RowCount
end function

private function long of_searchbyzone (n_cst_beo_event anva_eventblock[], string as_routetype);/*	
	This method is used to look up a piece of equipment by searching for an entry in the 
	zone table that matches state or zip.
	The results are retrieved into an instance datastore and then later combined with any 
	results from other querys
	
*/

String	lsa_Zones[]
String	lsa_TempZones[]
String	ls_InClause
String	ls_WhereClause
String	ls_OriginalSelect
String	ls_State
String	ls_Zip
Long		ll_RowCount
Long		ll_ZoneCount
Long		ll_EventCount
Long		ll_Ndx,i

n_cst_Sql			lnv_Sql
n_cst_beo_company	lnv_Company
n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_String		lnv_String
n_cst_beo_Event 	lnv_EventBeo

n_cst_bso_ZoneManager	lnv_ZoneManager
lnv_ZoneManager = CREATE n_cst_bso_ZoneManager


//Setnull ( ll_EquipmentId )
ll_EventCount = upperbound ( anva_eventblock ) 
 
//loop through all the events and get the state and zip so they can be used to 
// search for matching zones

FOR ll_ndx = 1 to ll_EventCount
	SetNull ( ls_State )
	SetNull ( ls_Zip )
	
	lnv_EventBeo = anva_eventblock [ ll_ndx ]
	//check to insure that the current beo is valid
	IF isvalid ( lnv_EventBeo ) THEN
		
		lnv_EventBeo.of_GetSite ( lnv_Company )
		
		// if the site is valid then get the state and zip
		IF isValid ( lnv_Company ) THEN
			ls_State = TRIM ( lnv_Company.of_GEtState ( )  )
			ls_Zip = TRIM ( lnv_Company.of_GEtZip ( )  )
		END IF
		
		// if we don't have a state or a zip then continue to the next event
		IF isnull( ls_State ) AND isNull ( ls_Zip ) THEN
			CONTINUE
		END IF
		
		// switch on the route type selected 
		CHOOSE CASE upper ( as_routetype )
				
			CASE gc_Dispatch.cs_RouteType_Pickup 
				
				// if the current event matches the route type selected then use the 
				// zip and state to look for any matching zones
				
				IF lnv_EventBeo.of_IsType ( gc_Dispatch.cs_EventType_Pickup ) THEN
					
					ll_ZoneCount = lnv_ZoneManager.of_GetZonesForState ( {ls_State} , lsa_TempZones )
					FOR i = 1 TO ll_ZoneCount 
						lsa_Zones [ UpperBound ( lsa_Zones ) + 1 ] = lsa_TempZones[i]
					NEXT
					
					ll_ZoneCount = lnv_ZoneManager.of_GetZonesForZip ( {ls_Zip} , lsa_TempZones )
					FOR i = 1 TO ll_ZoneCount 
						lsa_Zones [ UpperBound ( lsa_Zones ) + 1 ] = lsa_TempZones[i]
					NEXT
										
				END IF
													
			CASE gc_Dispatch.cs_RouteType_Deliver
				
				IF lnv_EventBeo.of_IsType ( gc_Dispatch.cs_EventType_Deliver ) THEN
					
					ll_ZoneCount = lnv_ZoneManager.of_GetZonesForState ( {ls_State} , lsa_TempZones )
					FOR i = 1 TO ll_ZoneCount 
						lsa_Zones [ UpperBound ( lsa_Zones ) + 1 ] = lsa_TempZones[i]
					NEXT
					
					ll_ZoneCount = lnv_ZoneManager.of_GetZonesForZip ( {ls_Zip} , lsa_TempZones )
					FOR i = 1 TO ll_ZoneCount 
						lsa_Zones [ UpperBound ( lsa_Zones ) + 1 ] = lsa_TempZones[i]
					NEXT
					
				END IF
				
			CASE gc_Dispatch.cs_RouteType_Any
				
				ll_ZoneCount = lnv_ZoneManager.of_GetZonesForState ( {ls_State} , lsa_TempZones )
				FOR i = 1 TO ll_ZoneCount 
					lsa_Zones [ UpperBound ( lsa_Zones ) + 1 ] = lsa_TempZones[i]
				NEXT
				
				ll_ZoneCount = lnv_ZoneManager.of_GetZonesForZip ( {ls_Zip} , lsa_TempZones )
				FOR i = 1 TO ll_ZoneCount 
					lsa_Zones [ UpperBound ( lsa_Zones ) + 1 ] = lsa_TempZones[i]
				NEXT
			
		END CHOOSE
		
	END IF 
	
NEXT

// at this point we have an array of zones. We need to shrink it to remove 
// any duplictes and/or nulls
lnv_ArraySrv.of_GetShrinked ( lsa_Zones , TRUE , TRUE )

// If we have any zones then construct an 'in' clause to be used in the retrieval
IF UpperBound ( lsa_Zones ) > 0 THEN

	ls_InClause = lnv_Sql.of_MakeInClauseFromStrings ( lsa_Zones )
	// since we are modifying the where clause we need to chage the ' to ~~'
	ls_InClause = lnv_String.of_GlobalReplace ( ls_InClause , "'" , "~~'" )
	
	
	ls_WhereClause = ' AND  ~~"join_route_zones~~".~~"Zonename~~"' + ls_InClause
	// only specify the route type if the type is not 'any'
	IF as_RouteType <> gc_Dispatch.cs_RouteType_Any THEN
		ls_WhereClause +=  ' AND (  ~~"Route~~".~~"Type~~"= '+ &
									+ "'"  + as_routetype +"'"	 + &
									 ' OR ~~"Route~~".~~"Type~~"= '+ &
									+ "'"  + gc_Dispatch.cs_RouteType_Any +"' )"	
	END IF
							
	ids_zoneresults = CREATE datastore
	ids_zoneresults.dataobject = "d_RoutePickList_Zones"
	ids_zoneresults.SetTransObject(SQLCA)

	ls_OriginalSelect = ids_zoneresults.Object.Datawindow.Table.Select
	ids_zoneresults.Object.Datawindow.Table.Select = ls_OriginalSelect + ls_WhereClause

	ids_zoneresults.SetTransObject(SQLCA)
	ll_RowCount = ids_zoneresults.Retrieve()
	COMMIT ;

END IF

DESTROY lnv_ZoneManager
DESTROY lnv_Company

Return ll_RowCount

end function

public function integer of_getautorouteparms (ref n_cst_msg anv_msg);// THIS Method will return 
//									1 if the msg obj has parms
//									0 if the user cancels out of the dialog , no settings set
//									-1 Error

Int		li_Return = -1
Boolean	lb_UseSettings
String	ls_Type
Int		li_Leg
s_Parm	lstr_Parm
n_cst_settings	lnv_Settings

IF anv_Msg.of_Get_Parm ( "USESETTINGS" , lstr_Parm ) <> 0 THEN
	lb_UseSettings = lstr_Parm.ia_Value
END IF

// the message needs to be reset since the same object may be passed in twice
anv_Msg.of_Reset ( )

IF lb_UseSettings THEN
	ls_Type = lnv_Settings.of_GetAutoRouteStyle ( ) 
	li_Leg  = lnv_Settings.of_GetAutoRouteLeg ( )
	
	IF Len ( ls_Type ) = 0 OR li_Leg = -1 THEN
	//	lb_UseSettings = FALSE  // THIS will cause the window to open since the settings 
										// are either not specified or not adequate
										
		li_Return = 0								
	ELSE									
		lstr_Parm.is_Label = "LEG"
		lstr_Parm.ia_Value = li_Leg
		anv_Msg.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ROUTETYPE"
		lstr_Parm.ia_Value = ls_Type
		anv_Msg.of_Add_Parm ( lstr_Parm )
		
		li_Return = 1
		
	END IF
END IF		

IF NOT lb_useSettings THEN
	Open ( w_SelectAutoRouteStyle )

	IF IsValid ( Message.PowerObjectParm ) THEN
		anv_Msg = Message.PowerObjectParm
		li_Return = 1
	ELSE
		li_Return = 0  //User Cancelled in the dialog.
	END IF
END IF


RETURN li_Return


end function

on n_cst_bso_routemanager.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bso_routemanager.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;call super::destructor;IF isValid ( ids_siteresults ) THEN
	Destroy ids_siteresults
END IF

IF isValid ( ids_zoneresults ) THEN
	Destroy ids_siteresults
END IF
end event

