$PBExportHeader$n_cst_eventtask_nextelsync.sru
forward
global type n_cst_eventtask_nextelsync from n_cst_eventtask_mobilcomm
end type
end forward

global type n_cst_eventtask_nextelsync from n_cst_eventtask_mobilcomm
end type
global n_cst_eventtask_nextelsync n_cst_eventtask_nextelsync

forward prototypes
public function integer of_execute ()
end prototypes

public function integer of_execute ();//Will attempt to process messages in the Nextel/PTMobile MCMessage table.

DataStore	lds_Cache
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnva_Events[], &
							lnva_EmptyEvents[]
n_cst_String			lnv_String
n_cst_AnyArraySrv		lnv_ArraySrv
n_cst_LicenseManager	lnv_LicenseManager
n_cst_DateTime			lnv_DateTime

DWObject 	ldwo_DriverId, &
				ldwo_MessageType, &
				ldwo_EventIds, &
				ldwo_ProcessingStatus, &
				ldwo_ProcessingAttempts, &
				ldwo_ProcessingLog, &
				ldwo_Recorded, &
				ldwo_Updated

Long		ll_Row, &
			ll_RowCount, &
			ll_DriverId, &
			ll_PriorDriverId, &
			ll_ProcessingAttempts, &
			lla_EventIds[], &
			lla_Empty[]
Integer	li_ProcessingStatus, &
			li_NewProcessingStatus, &
			li_NewLogCount, &
			li_Index, &
			li_EventCount, &
			li_CachedEventCount, &
			li_TimeSetResult
String	ls_MessageType, &
			ls_EventIds, &
			ls_ProcessingLog, &
			lsa_NewLogEntries[], &
			lsa_Empty[], &
			ls_Now, &
			ls_ResultString
Boolean	lb_SkipDriver, &
			lb_ResetDriver, &
			lb_HasSource, &
			lb_Confirmed
			
DateTime	ldt_Recorded, &
			ldt_Updated
Date		ld_Recorded, &
			ld_RouteDate, &
			ld_Null
Time		lt_Recorded


Constant Integer	ci_MCStatus_Processed = 1
Constant Integer	ci_MCStatus_Pending = 0
Constant Integer	ci_MCStatus_Failed = -1
Constant Integer	ci_MCStatus_PermanentFailure = -99

Constant String	cs_MCMessageType_Arrive = "A"
Constant String	cs_MCMessageType_Depart = "D"

SetNull ( ld_Null )

Integer	li_Result = 1


//Check for the Nextel License

IF li_Result = 1 THEN
	
	IF lnv_LicenseManager.of_HasNextelLicense ( ) THEN
		//OK
	ELSE
		li_Result = -1
		ls_ResultString = "The Nextel/PT Mobile Data Service is not licensed."
		THIS.of_Disableevent( )
	END IF
	
END IF



//Create the message queue datastore, retrieve unprocessed messages, and create dwobjects for use later.

IF li_Result = 1 THEN

	lds_Cache = CREATE DataStore
	lds_Cache.DataObject = "d_mcmessage_queue"
	lds_Cache.SetTransObject ( SQLCA )

	ll_RowCount = lds_Cache.Retrieve ( )
	COMMIT ;
	
	IF ll_RowCount >= 0 THEN
		//Retrieve was successful
		
		IF ll_RowCount > 0 THEN
		
			ldwo_DriverId = lds_Cache.Object.EmpId
			ldwo_MessageType = lds_Cache.Object.MessageType
			ldwo_EventIds = lds_Cache.Object.EventIds
			ldwo_ProcessingStatus = lds_Cache.Object.ProcessingStatus
			ldwo_ProcessingAttempts = lds_Cache.Object.ProcessingAttempts
			ldwo_ProcessingLog = lds_Cache.Object.ProcessingLog
			ldwo_Recorded = lds_Cache.Object.Recorded
			ldwo_Updated = lds_Cache.Object.Updated

		END IF
		
	ELSE
		li_Result = -1
		ls_ResultString = "Error retrieving pending messages from database."
		
	END IF
	
END IF



//If we've succeeded in the setup steps so far, proceed with the primary processing loop.

IF li_Result = 1 THEN
	
	//Set the lb_SkipDriver flag to FALSE to start off.  The flag will be set to true if an error is encountered in attempting to
	//process one message that would mean we should skip all the messages for that driver (such as failure to retrieve that driver's
	//itinerary.)
	
	lb_SkipDriver = FALSE
	

	FOR ll_Row = 1 TO ll_RowCount
		
		li_ProcessingStatus = ldwo_ProcessingStatus.Primary [ ll_Row ]
		
		IF li_ProcessingStatus = ci_MCStatus_Processed THEN
			//This message was already handled earlier in the loop, by a look-ahead process.
			CONTINUE
		END IF


		ll_DriverId = ldwo_DriverId.Primary [ ll_Row ]
		ls_MessageType = ldwo_MessageType.Primary [ ll_Row ]
		ls_EventIds = ldwo_EventIds.Primary [ ll_Row ]
		ll_ProcessingAttempts = ldwo_ProcessingAttempts.Primary [ ll_Row ]
		ls_ProcessingLog = ldwo_ProcessingLog.Primary [ ll_Row ]
		ldt_Recorded = ldwo_Recorded.Primary [ ll_Row ]
		ldt_Updated = ldwo_Updated.Primary [ ll_Row ]
		
		ld_Recorded = Date ( ldt_Recorded )
		ld_Recorded = Date ( DateTime ( ld_Recorded ) )  //Trim the hidden time component that may have been left over
		lt_Recorded = Time ( ldt_Recorded )
		
		li_EventCount = 0
		lla_EventIds = lla_Empty
		lnva_Events = lnva_EmptyEvents	//The beo's themselves should have been destroyed already
		
		
		//Flag the NewProcessingStatus as Processed.  This will be referenced along the way to
		//see if we are successful so far and should continue processing.  If it fails at any
		//point, the flag will be changed to one of the failure statuses.
		li_NewProcessingStatus = ci_MCStatus_Processed
		
		lsa_NewLogEntries = lsa_Empty
		li_NewLogCount = 0


		//Check that a driver id has been specified on the message, and if so, check whether we have flagged to skip it.
		
		IF ll_DriverId > 0 THEN
			
			//Check whether the lb_SkipDriver flag has been set due to a prior error.  If so, see if this is the same driver
			
			IF lb_SkipDriver = TRUE THEN
				
				IF ll_DriverId = ll_PriorDriverId THEN
					CONTINUE  //And leave lb_SkipDriver = TRUE in case the next event is ALSO for this driver.
					//We could possibly flag this message as failed for processing.  This approach just jumps over it.
				ELSE
					//We've hit a different driver.  Reset the flag.
					lb_SkipDriver = FALSE
				END IF
				
			END IF
			
		ELSE
			li_NewProcessingStatus = ci_MCStatus_PermanentFailure
			li_NewLogCount ++
			lsa_NewLogEntries [ li_NewLogCount ] = "No driver id specified."
		END IF
		

		//Check that the Message Type is recognized.

		CHOOSE CASE ls_MessageType
				
			CASE cs_MCMessageType_Arrive, cs_MCMessageType_Depart
				//OK
				
			CASE ELSE
				li_NewProcessingStatus = ci_MCStatus_PermanentFailure
				li_NewLogCount ++
				lsa_NewLogEntries [ li_NewLogCount ] = "Unrecognized message type."
				
		END CHOOSE

		
		//Check that EventIds have been specified.
		
		IF Len ( ls_EventIds ) > 0 THEN
			li_EventCount = lnv_String.of_ParseToArray ( ls_EventIds, ",", lla_EventIds )
		END IF
		
		IF li_EventCount > 0 THEN
			//OK
		ELSE
			li_NewProcessingStatus = ci_MCStatus_PermanentFailure
			li_NewLogCount ++
			lsa_NewLogEntries [ li_NewLogCount ] = "No event ids specified."
		END IF
			

		//If the message has already failed before, see how many times and how recent the last attempt was.
		//If the prior failures are too recent, we will skip over the event here.
		
		IF li_ProcessingStatus = ci_MCStatus_Failed THEN
			
			CHOOSE CASE ll_ProcessingAttempts
					
				CASE IS >= 19	//Applies to attempts 20+  Skip over this message if time since last attempt is less than 12 hrs.
					
					IF DaysAfter ( Date ( ldt_Recorded ), Today ( ) ) > 7 THEN
						
						li_NewProcessingStatus = ci_MCStatus_PermanentFailure
						li_NewLogCount ++
						lsa_NewLogEntries [ li_NewLogCount ] = "Event has failed to process for 7 days.  No further attempts will be made."
						
					ELSEIF lnv_DateTime.of_SecondsAfter ( ldt_Updated, DateTime ( Today (), Now () ) ) < 24 * 3600 THEN
						
						CONTINUE
						
					END IF
					
				CASE IS >= 9	//Applies to attempts 10-19.  Skip over this message if time since last attempt is less than 1 hr.
					
					IF lnv_DateTime.of_SecondsAfter ( ldt_Updated, DateTime ( Today (), Now () ) ) < 1 * 3600 THEN
						CONTINUE
					END IF
					
				CASE IS >= 2	//Applies to attempts 3-9.  Skip over this message if time since last attempt is less than 1/4 hr.
					
					IF lnv_DateTime.of_SecondsAfter ( ldt_Updated, DateTime ( Today (), Now () ) ) < .25 * 3600 THEN
						CONTINUE
					END IF
					
			END CHOOSE
				
		END IF
		
		
		//Retrieve the driver's itinerary (if it has not been already on a previous message for this same driver)
		
		IF li_NewProcessingStatus = ci_MCStatus_Processed THEN  //Only continue with this processing if we've succeeded so far.
		
			IF ll_DriverId = ll_PriorDriverId AND lb_ResetDriver = FALSE THEN
				//OK, already worked with this driver on the last message, we've already set up the dispatch object
				
			ELSE
				
				//Clear the lb_ResetDriver flag (in case that's why were here, this is the reset that's been requested)
				lb_ResetDriver = FALSE
				
				//Destroy the dispatch object, so we can start fresh with this driver.
				DESTROY lnv_Dispatch
				
				lnv_Dispatch = CREATE n_cst_bso_Dispatch
				
				CHOOSE CASE lnv_Dispatch.of_RetrieveItinerary ( gc_Dispatch.ci_ItinType_Driver, ll_DriverId, RelativeDate ( Today(), -1 ), Today (), FALSE /*Do not need prior itin rows*/ )
						
					CASE 1		//Success
						//Bring all the events retrieved for the driver into the primary buffer in the event cache
						lnv_Dispatch.of_FilterItinerary ( gc_Dispatch.ci_ItinType_Driver, ll_DriverId, ld_Null, ld_Null )
						
					CASE -1		//Failure
						li_NewProcessingStatus = ci_MCStatus_Failed
						li_NewLogCount ++
						lsa_NewLogEntries [ li_NewLogCount ] = "Could not retrieve driver itinerary (retrieve failed)."
						
					CASE -2		//Original value conflict (shouldn't happen because we are retrieving into a clean cache)
						li_NewProcessingStatus = ci_MCStatus_Failed
						li_NewLogCount ++
						lsa_NewLogEntries [ li_NewLogCount ] = "Could not retrieve driver itinerary (original value conflict error)."
						
					CASE ELSE	//Unexpected return value
						li_NewProcessingStatus = ci_MCStatus_Failed
						li_NewLogCount ++
						lsa_NewLogEntries [ li_NewLogCount ] = "Could not retrieve driver itinerary (unexpected return value error)."
						
				END CHOOSE
				
			END IF
			
		END IF
		

		
		//Set up an array of event beo's for the events
		

		IF li_NewProcessingStatus = ci_MCStatus_Processed THEN  //Only continue with this processing if we've succeeded so far.
		
			//Have the dispatch object set up an array of events based on the ids we have.
			//Note: The RetrieveIfNeeded option on this function has NOT been implemented, so if the
			//count comes back less than the count we asked for, we'll have to retrieve the events
			//and try again.  Since 95% of the time the events we're looking for will already have
			//been retrieved, it's more efficient to do this than to retrieve all the time first.
			
			li_CachedEventCount = lnv_Dispatch.of_GetEventList ( lla_EventIds, lnva_Events, TRUE /*RetrieveIfNeeded -- However, this option is NOT implemented*/ )
			
			
			IF li_CachedEventCount = li_EventCount THEN
				//OK
			ELSE
				//Not all the events are there.  We'll have to retrieve and try again.
				
				lnv_ArraySrv.of_Destroy ( lnva_Events )
				lnva_Events = lnva_EmptyEvents  //We destroyed the objects, but we also have to flush the array
				
				CHOOSE CASE lnv_Dispatch.of_RetrieveEvents ( lla_EventIds )
						
					CASE 1		//Success
						
						//Bring all the events retrieved for the driver into the primary buffer in the event cache.
						//If any events requested by id have be reassigned or unassigned, these will remain in the filter buffer, which is ok,
						//these will only be read from, since once the reassignment/unassignment has been identified, no sets will be attempted.
						//(Being in the filter would actually not technically cause a problem even with sets, because the beo's are programmed to handle that, too.)
						lnv_Dispatch.of_FilterItinerary ( gc_Dispatch.ci_ItinType_Driver, ll_DriverId, ld_Null, ld_Null )
						
						//Try to build the event array again.
						li_CachedEventCount = lnv_Dispatch.of_GetEventList ( lla_EventIds, lnva_Events, TRUE /*RetrieveIfNeeded -- However, this option is NOT implemented*/ )
						
						IF li_CachedEventCount = li_EventCount THEN
							//OK
							
						ELSEIF li_CachedEventCount > 0 THEN
							//There's still event(s) missing, but at least some are valid.  Don't fail, and go ahead and perform processing for events that are there.
							//These will be messaged individually into the processing log when they are encountered, later, so no log entry is needed here.
							
						ELSEIF li_ProcessingStatus = ci_MCStatus_Failed THEN
							//This message has already failed on a previous attempt.  Fail it permanently now.
							li_NewProcessingStatus = ci_MCStatus_PermanentFailure
							li_NewLogCount ++
							lsa_NewLogEntries [ li_NewLogCount ] = "Events referenced cannot be retrieved (Final attempt.)"
							
						ELSE
							//Fail.  The message will be retried at next process run, and if it fails again, will be permanently failed (above).
							li_NewProcessingStatus = ci_MCStatus_PermanentFailure
							li_NewLogCount ++
							lsa_NewLogEntries [ li_NewLogCount ] = "Events referenced cannot be retrieved (another attempt will be made on next process run.)"

						END IF
						
					CASE -1		//Failure
						li_NewProcessingStatus = ci_MCStatus_Failed
						li_NewLogCount ++
						lsa_NewLogEntries [ li_NewLogCount ] = "Could not retrieve events (retrieve failed)."						
						
					CASE -2		//Original value conflict
						li_NewProcessingStatus = ci_MCStatus_Failed
						li_NewLogCount ++
						lsa_NewLogEntries [ li_NewLogCount ] = "Could not retrieve events (original value conflict error)."
						
					CASE ELSE	//Unexpected return value
						li_NewProcessingStatus = ci_MCStatus_Failed
						li_NewLogCount ++
						lsa_NewLogEntries [ li_NewLogCount ] = "Could not retrieve events (unexpected return value error)."
						
				END CHOOSE
				
			END IF
			
		END IF
		
		
		
		//Attempt to apply the message to the event(s).
		
		IF li_NewProcessingStatus = ci_MCStatus_Processed THEN  //Only continue with this processing if we've succeeded so far.
		
			//In the processing that follows, we need to be careful to check whether we've got a valid beo object,
			//and if so, if it's got a valid source, before performing other operations on it.

			//Reset li_EventCount based on the upperbound of the event array  (this SHOULD match the current value of li_EventCount)
			li_EventCount = UpperBound ( lnva_Events )
			
		
			FOR li_Index = 1 TO li_EventCount
				
				lb_HasSource = FALSE  //Will be set to true in the statement that follows if it does
				
				IF IsValid ( lnva_Events [ li_Index ] ) THEN
					IF lnva_Events [ li_Index ].of_HasSource ( ) THEN
						lb_HasSource = TRUE
					END IF
				END IF
						
				IF lb_HasSource = FALSE THEN
					//No status change, just list the warning
					li_NewLogCount ++
					lsa_NewLogEntries [ li_NewLogCount ] = "Event id " + String ( lla_EventIds [ li_Index ] ) + " could not be retrieved for update, and was skipped."
					CONTINUE
				END IF					

				
				IF lnva_Events [ li_Index ].of_GetDriverId ( ) = ll_DriverId THEN
					//OK
				ELSE
					li_NewLogCount ++
					lsa_NewLogEntries [ li_NewLogCount ] = "Event id " + String ( lla_EventIds [ li_Index ] ) + " is no longer assigned to the driver who submitted the message."
					CONTINUE
				END IF
				
				
				lb_Confirmed = lnva_Events [ li_Index ].of_IsConfirmed ( )
				
				IF lb_Confirmed THEN
					li_NewLogCount ++
					lsa_NewLogEntries [ li_NewLogCount ] = "Event id " + String ( lla_EventIds [ li_Index ] ) + " has already been confirmed complete in the system."
					CONTINUE
				END IF

				
				ld_RouteDate = lnva_Events [ li_Index ].of_GetDateArrived ( )
				
				IF DaysAfter ( ld_RouteDate, ld_Recorded ) = 0 THEN
					//OK
				ELSEIF DaysAfter ( ld_RouteDate, ld_Recorded ) = 1 AND ls_MessageType = cs_MCMessageType_Depart AND NOT IsNull ( lnva_Events [ li_Index ].of_GetTimeArrived ( ) ) THEN
					//OK -- Arrived on route date, departing the next day (at least, that's how this will be interpreted)
				ELSE
					li_NewLogCount ++
					lsa_NewLogEntries [ li_NewLogCount ] = "Event id " + String ( lla_EventIds [ li_Index ] ) + " is routed to a different day than the driver submitted in the message."
					CONTINUE
				END IF
			
				
				
				CHOOSE CASE ls_MessageType
						
					CASE cs_MCMessageType_Arrive
						
						IF IsNull ( lnva_Events [ li_Index ].of_GetTimeArrived ( ) ) THEN
							
							li_TimeSetResult = lnva_Events [ li_Index ].of_SetTimeArrived ( lt_Recorded )
							
							IF li_TimeSetResult = 1 THEN
								//OK
							ELSE
								li_NewLogCount ++
								lsa_NewLogEntries [ li_NewLogCount ] = "The arrive time could not be set for event id " + String ( lla_EventIds [ li_Index ] ) + "."
								CONTINUE
							END IF
							
						ELSE
							li_NewLogCount ++
							lsa_NewLogEntries [ li_NewLogCount ] = "Event id " + String ( lla_EventIds [ li_Index ] ) + " already has an arrive time recorded in the system."
							CONTINUE
							
						END IF
						
					CASE cs_MCMessageType_Depart
						
						li_TimeSetResult = 0  //Will be referenced below in building error message, so initial value is important.
						
						IF IsNull ( lnva_Events [ li_Index ].of_GetTimeDeparted ( ) ) THEN
							
							li_TimeSetResult = lnva_Events [ li_Index ].of_SetTimeDeparted ( lt_Recorded )
							//Note: If the ARRIVE time has not been set, it will be set to the same as the depart time by the beo.
							
							IF li_TimeSetResult = 1 THEN
								//OK
							ELSE
								//Unlike failure to set arrive time, which we let go through as processed, we want to flag this 
								//as a failure so it will be reattempted.  The confirmation of the event depends on the depart message.
								li_NewProcessingStatus = ci_MCStatus_Failed  
								li_NewLogCount ++
								lsa_NewLogEntries [ li_NewLogCount ] = "The depart time could not be set for event id " + String ( lla_EventIds [ li_Index ] ) + "."
								CONTINUE
							END IF
							
						ELSE
							//We DO NOT want to CONTINUE -- based on previous checks, the event is not confirmed, and we need 
							//to proceed to attempt confirmation.
							//Message will be set based on outcome of Confirmation attempt, below.
						END IF
						
						
						lnv_Dispatch.ClearOFRErrors ( )
					
						IF lnv_Dispatch.of_ConfirmEvent ( lla_EventIds [ li_Index ], FALSE /*Non-Interactive*/ ) >= 0 THEN
							//OK
							lnva_Events [ li_Index ].of_SetConfirmedBy ( "DRIVER" )

							//If the time was already set above (and did not get set off the message processing here), make an explanatory note.
							CHOOSE CASE li_TimeSetResult
								CASE 1  //Time was set above.
									//No message needed.
								CASE ELSE //0 -- depart time was already set  ...  If it were -1, we would have CONTINUED, and not be here attempting confirmation.
									li_NewLogCount ++
									lsa_NewLogEntries [ li_NewLogCount ] = "Event id " + String ( lla_EventIds [ li_Index ] ) + " already had a depart time recorded in the system, and was confirmed complete by this message."
							END CHOOSE
							
						ELSE
							li_NewProcessingStatus = ci_MCStatus_Failed  //We want to flag this as a failure so it will be reattempted.  Probably not all equipment is assigned.
							li_NewLogCount ++
							
							CHOOSE CASE li_TimeSetResult
								CASE 1
									lsa_NewLogEntries [ li_NewLogCount ] = "The depart time was set for event id " + String ( lla_EventIds [ li_Index ] ) + " but the event could not be confirmed complete."
								CASE ELSE //0 -- depart time was already set  ...  If it were -1, we would have CONTINUED, and not be here attempting confirmation.
									lsa_NewLogEntries [ li_NewLogCount ] = "Event id " + String ( lla_EventIds [ li_Index ] ) + " already had a depart time recorded in the system, but could not be confirmed complete."
							END CHOOSE

							CONTINUE							
							
						END IF
						
						
				END CHOOSE
				
			NEXT
			
			
			//Destroy the event beos
			
			lnv_ArraySrv.of_Destroy ( lnva_Events )
			lnva_Events = lnva_EmptyEvents  //The previous line destroys the objects, but we still need to flush the array as well.


			//Attempt to save the changes recorded on bso_Dispatch
			
			CHOOSE CASE lnv_Dispatch.Event pt_Save ( )
					
				CASE 1		//Success
					
				CASE -1		//Failure

					li_NewProcessingStatus = ci_MCStatus_Failed
					li_NewLogCount ++
					lsa_NewLogEntries [ li_NewLogCount ] = "Could not save changes to event data (save failed)."
					
					lb_ResetDriver = TRUE  //Set flag to throw away the dispatch cache and do a fresh retrieve on the next pass, to avoid this problem spilling over.
					
				CASE ELSE	//Unexpected return.
					
					li_NewProcessingStatus = ci_MCStatus_Failed
					li_NewLogCount ++
					lsa_NewLogEntries [ li_NewLogCount ] = "Could not save changes to event data (unexpected return error)."
					
					lb_ResetDriver = TRUE  //Set flag to throw away the dispatch cache and do a fresh retrieve on the next pass, to avoid this problem spilling over.
					
			END CHOOSE

		END IF
		
		
		
		//Set the updated processing values into the cache.
		
		IF IsNull ( ll_ProcessingAttempts ) THEN
			ll_ProcessingAttempts = 1
		ELSE
			ll_ProcessingAttempts ++
		END IF
		
		IF IsNull ( ls_ProcessingLog ) THEN
			ls_ProcessingLog = ""
		END IF

		ls_Now = String ( Today(), "yyyy-mm-dd hh:mm:ss.ff" )

		FOR li_Index = 1 TO li_NewLogCount
			
			ls_ProcessingLog += ls_Now + " : " + lsa_NewLogEntries [ li_Index ] + "~r~n"
			
		NEXT
		
		
		ldwo_ProcessingAttempts.Primary [ ll_Row ] = ll_ProcessingAttempts
		ldwo_ProcessingStatus.Primary [ ll_Row ] = li_NewProcessingStatus
		ldwo_ProcessingLog.Primary [ ll_Row ] = ls_ProcessingLog
		

		CHOOSE CASE lds_Cache.Update ( )
				
			CASE 1
				COMMIT ;
				
			CASE ELSE
				ROLLBACK ;
				li_Result = -1
				ls_ResultString = "Save error encountered at message " + String ( ll_Row ) + " of " + String ( ll_RowCount ) + ".  Processing stopped."
				EXIT
				
		END CHOOSE
		
		
		//Set the driver flag for the next pass through the loop, so we know if we're continuing to work on the same driver or not.
		ll_PriorDriverId = ll_DriverId
		
	NEXT

END IF

IF li_Result = 1 THEN
	THIS.of_setprocessingresult( ci_result_success )
	THIS.of_Setresultstring( "PT Mobile Direct synchronization was successful" /* being written to a file*/ )
ELSE
	THIS.of_setprocessingresult( ci_result_error )
	THIS.of_Setresultstring( ls_ResultString /* being written to a file*/ )
END IF


//Destroy the dwObjects and other objects

DESTROY ldwo_DriverId
DESTROY ldwo_MessageType
DESTROY ldwo_EventIds
DESTROY ldwo_ProcessingStatus
DESTROY ldwo_ProcessingAttempts
DESTROY ldwo_ProcessingLog
DESTROY ldwo_Recorded
DESTROY ldwo_Updated

DESTROY lds_Cache

DESTROY lnv_Dispatch

RETURN 1   //Should this be a forced return of 1 or should it be the same as the ProcessingResult??
end function

on n_cst_eventtask_nextelsync.create
call super::create
end on

on n_cst_eventtask_nextelsync.destroy
call super::destroy
end on

event constructor;call super::constructor;is_taskdescription =   "This is the process that will synchronize information submitted via mobile devices."
is_Tabpagelabel = "PT Mobile Direct"
is_eventname = "ptev_nextel_sync"
is_schedulename = "ptsch_nextelsync" 
is_Procedurename = "ptsp_nextelsync"
end event

