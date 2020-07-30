$PBExportHeader$n_cst_bso_fueltax.sru
$PBExportComments$FuelTax (Non-persistent Class from PBL map PTSetl) //@(*)[90929639|138]
forward
global type n_cst_bso_fueltax from n_cst_base
end type
end forward

shared variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
n_cst_bso_fueltax sn_n_cst_bso_fueltax_a[] //@(*)[90929639|138:n]<nosync>
Integer sn_n_cst_bso_fueltax_c //@(*)[90929639|138:c]<nosync>
//@(text)--

//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

global type n_cst_bso_fueltax from n_cst_base
end type
global n_cst_bso_fueltax n_cst_bso_fueltax

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.

//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

Public DataStore	ids_itin_quick
Public DataStore	ids_StateReport

Public CONSTANT String cs_Context_HistoryReport = "HISTORYREPORT"
Public CONSTANT String cs_Context_FuelTax = "FUELTAX"
Public CONSTANT String cs_Context_StateBreakdown = "PRETAX"

Private String	is_PreviousPCM
Private String	is_Context
Private:
n_cst_Trip	inv_Trip
end variables

forward prototypes
protected function boolean of_validatestate (string as_state)
public function integer of_getpreviousevent (readonly integer ai_category, readonly long al_id, readonly date ad_priorto, ref long al_event)
public function datastore of_getsource ()
public function datastore of_getstatesource ()
protected function long of_retrieve_itin (integer ai_category, long al_id, date ad_min, date ad_max)
public function integer of_retrieve_revcounts (ref long ala_ids[], ref integer aia_counts[], ref dec aca_revenues[])
public function integer of_retrieve_itin (string as_category, long al_id, date ad_min, date ad_max)
public function integer of_pretaxvalidation (ref n_cst_msg anv_msg)
protected function integer of_calcadjustments (ref n_cst_msg anv_msg)
protected function integer of_calcitinmileage ()
protected function integer of_calculaterevenue ()
protected function long of_checknullsites ()
protected function long of_checkpcmlocators (ref n_cst_msg anv_msgobj)
protected function integer of_checkpreviousevent (string as_category, long al_id, date ad_min, date ad_max)
protected function integer of_consolidateitin ()
protected function integer of_createheader (integer ai_category, long al_id, date ad_min, date ad_max, ref datastore ads_target, string as_reportname)
protected function integer of_displayhistory (ref n_cst_msg anv_msg)
protected function integer of_genstatereport ()
public function string of_getdestination ()
protected function integer of_geteventpcm (readonly long al_id, ref string as_pcm)
public function string of_getorigin ()
public function integer of_process_report (string as_category, long al_id, string as_context)
public function integer of_process_report (string as_category, long al_id, string as_context, date ad_min, date ad_max)
public function integer of_validatecategory (string as_category, string as_context, long al_id)
private function integer of_addstops (readonly long al_tripid, readonly string asa_stops[])
private function integer of_convertcategory (readonly long al_id, readonly string as_category)
private function integer of_getstopsarray (ref string asa_stops[])
private function integer of_processfueltax (string as_category, long al_id, date ad_min, date ad_max, string as_context)
private function integer of_shrinkdatearray (date ada_dates[], ref string as_dates)
end prototypes

protected function boolean of_validatestate (string as_state);//@(*)[91549664|151]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>



CHOOSE CASE as_State
		
CASE "AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL","IN","IA",&
	"KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM",&
	"NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA",&
	"WV","WI","WY"
	
	Return TRUE

CASE "YT","PQ","QC","PE","ON","BC","MB","MX","NF","NS","NT","NV","AB","NB"
	
	Return True

CASE ELSE
	
	Return False
	
END CHOOSE

//@(text)--













end function

public function integer of_getpreviousevent (readonly integer ai_category, readonly long al_id, readonly date ad_priorto, ref long al_event);//Returns:  1 = Event found, EventId passed out by reference, 
//0 = There is no previous event, -1 = Error

String	ls_Command
Long		ll_Event, &
			ll_Site
Char		lch_EventType
n_cst_Events	lnv_Events

Integer	li_Result, &
			li_Return = -1


SetNull ( al_Event )

CHOOSE CASE ai_Category

CASE n_cst_Constants.ci_EquipmentCategory_Drivers
//	Category not supported, because we can't have duplicate definitions
//	of cur_Events without doing dynamic cursors (which I'm not up for at present)

//	DECLARE cur_Events CURSOR FOR 
//	SELECT de_id FROM disp_events 
//	WHERE (disp_events.de_driver = :al_Id) AND 
//			(disp_events.de_arrdate < :ad_PriorTo)
//	ORDER BY de_arrdate DESC, de_driver_seq DESC ;

CASE n_cst_Constants.ci_EquipmentCategory_PowerUnits
	DECLARE cur_Events CURSOR FOR 
	SELECT de_id, de_site, de_event_type FROM disp_events 
	WHERE (disp_events.de_tractor = :al_Id) AND 
			(disp_events.de_arrdate < :ad_PriorTo)
	ORDER BY de_arrdate DESC, de_tractor_seq DESC ;

//CASE n_cst_Constants.ci_EquipmentCategory_TrailerChassis
//	Category not supported, due to processing complexity

//CASE n_cst_Constants.ci_EquipmentCategory_Containers
//	Category not supported, due to processing complexity

CASE ELSE
	GOTO RollItBack

END CHOOSE


IF SQLCA.SqlCode <> 0 THEN
	GOTO RollItBack
END IF


OPEN cur_Events ;

IF SQLCA.SqlCode <> 0 THEN
	GOTO RollItBack
END IF

DO

	SetNull ( ll_Event )
	SetNull ( ll_Site )
	SetNull ( lch_EventType )

	FETCH cur_Events INTO :ll_Event, :ll_Site, :lch_EventType ;
	li_Result = SQLCA.SqlCode

	CHOOSE CASE li_Result
	
	CASE 0

		//If the site is null, see if it's an event type we can disregard.
		//If it is, disregard the event and continue.  If it's not, use it.

		IF IsNull ( ll_Site ) THEN
			IF lnv_Events.of_IsTypeLocationOptional ( lch_EventType ) THEN
				CONTINUE
			END IF
		END IF

		al_Event = ll_Event
		li_Return = 1
	
	CASE 100
		li_Return = 0
		
	CASE ELSE  //-1
		//Error: Allow to fail
	
	END CHOOSE

LOOP WHILE li_Result = 0 AND li_Return = -1

CLOSE cur_Events ;
COMMIT ;

GOTO CleanUp

RollItBack:
Rollback ;

CleanUp:
Return li_Return

end function

public function datastore of_getsource ();IF Isvalid(ids_itin_quick) THEN
	
Else 
	ids_itin_quick = Create dataStore

End IF
 
Return ids_itin_quick


end function

public function datastore of_getstatesource ();if isValid (ids_statereport) THEN

	Return ids_statereport
Else 

	ids_StateReport = create DataStore
	ids_StateReport.dataObject = "d_StateReport"
	Return ids_statereport

END IF

end function

protected function long of_retrieve_itin (integer ai_category, long al_id, date ad_min, date ad_max);/* ===========================================================================
	Retrieve itinerary:
		
		This function retrieves the itinerary for the specified date range, equipment
		number, and equipment type.
		mileage calculations as well as consolidation of the itinerary need separate 
		function calls: of_CalcItinMileage() and of_consolidateItit() on an as needed basis
		This Function also creates the appropriate header for a report
		
			Return Values:
			
				# > 0 = Number of Rows Retrieved
					0 = No Rows Retrieved
				   -1 = Failure	

===============================================================================*/



long 	ll_result, ll_markloop, ll_site1, ll_site2, lla_companies[],  &
		ll_minutes,    ll_PreviousEvent

 
string 	ls_select, ls_sort, ls_pcm, ls_pcm_prev, ls_work, ls_Message
decimal {1} lc_miles
Boolean 	lb_PreviousEventFailure, &
			lb_PreviousEventMissingLocation
string 	ls_errorMessage 
string	ls_Report_Name

Long	ll_ReturnValue = 1

n_cst_numerical lnv_numerical
n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_Error
n_cst_OFRError lnv_ErrorArray[]

ls_ErrorMessage = "An unexpected error occurred while attempting to retrieve the itinerary."

n_cst_EquipmentManager lnv_EquipmentMgr
setpointer(hourglass!)
if not lnv_EquipmentMgr.of_valid_category(ai_category) then
	ll_ReturnValue= -1
END IF

IF ll_ReturnValue= 1 THEN
	if lnv_Numerical.of_IsNullOrNotPos(al_id) then 
		ll_ReturnValue= -1
	END IF
END IF

IF ll_ReturnValue= 1 THEN
		
	destroy ids_itin_quick
	destroy	ids_StateReport
	SetNull ( is_PreviousPCM )
	
	ids_itin_quick = create datastore
	ids_itin_quick.dataobject = "d_itin_quick"
	ids_itin_quick.settransobject(sqlca)
	
	
	ids_StateReport = create datastore
	ids_StateReport.dataobject = "d_stateReport"
	
	
	
	choose case ai_category
	case 1
		ls_report_name = "DRIVER HISTORY REPORT"
	
	case else
		ls_report_name = "EQUIP. HISTORY REPORT"
	
	end choose
	//create headers
	of_createHeader(ai_category,al_id,ad_min,ad_max,ids_itin_quick,ls_Report_Name)
	of_createHeader(ai_category,al_id,ad_min,ad_max,ids_StateReport,"State Summary Report")
	
	

END IF
IF ll_ReturnValue= 1 THEN
	//Compose select statement
	
	ls_select = ids_itin_quick.describe("datawindow.table.select") + " WHERE "
	
	if isnull(ad_min) and isnull(ad_max) then
		ls_Select += " (disp_events.de_arrdate is not null) and "
	elseif isnull(ad_max) then
		ls_select += " (disp_events.de_arrdate >= :ad_min) and "
	elseif isnull(ad_min) then
		ls_select += " (disp_events.de_arrdate <= :ad_max) and "
	else
		ls_select += " (disp_events.de_arrdate between :ad_min and :ad_max) and "
	end if
	
	choose case ai_category
	case 1
		ls_select += " (disp_events.de_driver = :al_id)"
	case 2
		ls_select += " (disp_events.de_tractor = :al_id)"
	case 3
		ls_select += " (:al_id in (disp_events.de_trailer1, " +&
			"disp_events.de_trailer2, disp_events.de_trailer3, disp_events.de_acteq))"
	case 4
		ls_select += " (:al_id in (disp_events.de_container1, " +&
			"disp_events.de_container2, disp_events.de_container3, "+&
			"disp_events.de_container4, disp_events.de_acteq))"
	case else
		ll_ReturnValue= -1
		
	end choose
	
	
	IF ll_ReturnValue= 1 THEN
		ids_itin_quick.modify("datawindow.table.select = '" + ls_select + "'")
		
		
		//Compose sort statement
		
		ls_sort = "datetime(de_arrdate) A, "
		
		//Datetime is used because arrdate by itself causes sorting errors due to the
		//unpredictable time component
		
		choose case ai_category
		case 1
			ls_sort += "de_driver_seq A"
		case 2
			ls_sort += "de_tractor_seq A"
		case 3
			ls_sort += "if(de_trailer1 = " + string(al_id) + ", de_trailer1_seq, " +&
				"if(de_trailer2 = " + string(al_id) + ", de_trailer2_seq, if(de_trailer3 = " +&
				string(al_id) + ", de_trailer3_seq, de_acteq_seq)))) A"
		case 4
			ls_sort += "if(de_container1 = " + string(al_id) + ", de_container1_seq, " +&
				"if(de_container2 = " + string(al_id) + ", de_container2_seq, " +&
				"if(de_container3 = " + string(al_id) + ", de_container3_seq, " +&
				"if(de_container4 = " + string(al_id) + ", de_container4_seq, de_acteq_seq))))) A"
		end choose
		
		ids_itin_quick.setsort(ls_sort)
		
		
		//Perform retrieval
		
		ll_result = ids_itin_quick.retrieve(al_id, ad_min, ad_max)
		
		if ll_result >= 0 then
			commit ;		
		
			if ll_result > 0 then
				lla_companies = ids_itin_quick.object.de_site.primary
				gnv_cst_companies.of_cache(lla_companies, false)
			end if
		
			for ll_markloop = 1 to ll_result
				ll_site1 = ids_itin_quick.object.de_site[ll_markloop]
				gnv_cst_companies.of_copy_by_column(ll_site1, ids_itin_quick, ll_markloop)
			next

		else
			rollback ;
		end if
	END IF
END IF


 //* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\

IF ll_ReturnValue= -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//

IF ll_ReturnValue < 1 THEN
	ll_Result = ll_ReturnValue
END IF

return ll_result

end function

public function integer of_retrieve_revcounts (ref long ala_ids[], ref integer aia_counts[], ref dec aca_revenues[]);long ll_ndx
integer lia_counts[]
decimal {2} lca_revenues[]

aia_counts = lia_counts
aca_revenues = lca_revenues

n_cst_anyarraysrv lnv_anyarray
lnv_anyarray.of_GetShrinked(ala_ids, "NULLS~tDUPES")

for ll_ndx = 1 to upperbound(ala_ids)
	lca_revenues[ll_ndx] = 0
	lia_counts[ll_ndx] = 0

	if ala_ids[ll_ndx] = 0 then continue

	select ds_bill_charge into :lca_revenues[ll_ndx] from disp_ship
	where ds_id = :ala_ids[ll_ndx] ;

	if sqlca.sqlcode <> 0 then
		rollback ;
		goto failure
	else
		commit ;
	end if

	select count(*) into :lia_counts[ll_ndx] from disp_events 
	where de_shipment_id = :ala_ids[ll_ndx] ;

	if sqlca.sqlcode <> 0 then
		rollback ;
		goto failure
	else
		commit ;
	end if
next

aia_counts = lia_counts
aca_revenues = lca_revenues

return 1

failure:
return -1
end function

public function integer of_retrieve_itin (string as_category, long al_id, date ad_min, date ad_max);integer li_result, li_category
s_eq_info lstr_eq_info
n_cst_EquipmentManager lnv_EquipmentMgr

choose case as_category
case "DRIVER!"
	li_category = 1
case "EQUIPMENT!"
	if lnv_EquipmentMgr.of_get_info(al_id, lstr_eq_info, false) = 1 then
		li_category = lnv_EquipmentMgr.of_type_to_category(lstr_eq_info.eq_type)
	else
		li_result = -1
	end if
case else
	li_result = -1
end choose

if li_result = 0 then li_result = of_retrieve_itin(li_category, al_id, ad_min, ad_max)

return li_result

end function

public function integer of_pretaxvalidation (ref n_cst_msg anv_msg);/*================================================================================
	Pre-Tax Validation:
	
		this procedure populates the message object with the info needed to open the window
		dataValidate in the correct context
		
		
		Return Values:
					-1 = Failure
					 1 = Success

*************					 
NOTE/WARNING:

		THIS FUNCTION ADDS AN EMPTY ROW TO IDS_ITIN_QUICK AND IDS_STATEREPORT
		IF ROW COUNT = 0 SO THAT GET/SET FULL STATE WILL DISPLAY AN EMPTY TRIP REPORT.
		THIS SHOULD BE INVESTIGATED LATER.

*************


================================================================================*/



String	ls_ErrorMessage
Int 	li_Result

INT		li_ReturnValue = 1

n_cst_msg 		lnv_msg
s_parm 			lstr_parm
w_DataValidate 	lw_DataValidate

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError	lnv_ErrorArray[]
n_cst_OFRError 	lnv_Error

ls_ErrorMessage = "An unexpected error occurred while evaluating the state breakdown report."

IF is_Context = cs_Context_StateBreakdown THEN	
		
	lstr_parm.is_label = "RESULT"
	lstr_parm.ia_Value = cs_Context_StateBreakdown
	lnv_msg.of_add_parm(lstr_parm)
	
	
	IF isValid(ids_statereport) THEN
		lstr_parm.is_label = "STATEREPORT"
		IF Rowcount( ids_StateReport ) = 0 THEN
			ids_StateReport.insertRow(0)
		END IF
		lstr_parm.ia_Value = ids_statereport
		lnv_msg.of_add_parm(lstr_parm)
	Else
		li_ReturnValue = -1
	END IF
	
//	IF li_ReturnValue <> -1 THEN
//		IF isValid (ids_itin_quick) THEN
//			lstr_parm.is_label = "ITINREPORT"
//			IF RowCount( ids_itin_quick ) = 0 THEN
//				ids_Itin_quick.InsertRow(0)
//			END IF
//			lstr_parm.ia_Value = ids_itin_quick
//			lnv_msg.of_add_parm(lstr_parm)
//		ELSE
//			li_ReturnValue = -1
//		END IF
//	END IF
	
	IF li_ReturnValue = 1 THEN
		anv_msg = lnv_msg
	END IF
	
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\//

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
	    

return li_ReturnValue
end function

protected function integer of_calcadjustments (ref n_cst_msg anv_msg);//@(*)[91035444|140]//@(-)Do not edit, move or copy this line//


//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

string 	ls_ErrorMessage, &
			ls_Message
Long 		ll_RowCount
Long 		i
Long		ll_CutOff
Boolean 	lb_Again = FALSE
Boolean 	lb_Round 

Dec {1} 	ldec_StartOD
Dec {1} 	ldec_EndOD
Dec {1}	ld_ODDiff			// the mileage calculated by (ad_endod - ad_startod)
Dec {1}	ld_TotalMiles 		// total mileage reported by PCM before any adjustments
Dec {1}	ld_TempProportionValue // used to proportionaly distribute mileage across all states
Dec {1}	ld_AdjustedMile 	// the individual state mileage after adjustment
Dec {1}	ld_AdjTot			// the sum of all the post adjustment mileage  
Dec {1}	ld_Shim				// this varialble is used to correct for hardware precision issues.
									//      the shim value will be evenly distrbuted across all states.
Dec {1}	ld_CalcToActualDiff  //Used to hold absolute value of calculated vs. actual differential

Dec 		ld_MileageMissingFlag	// value specified by user as a percent.
											// used to determine if too large of adjustment took place. 	

Int		li_continue		// used to determine if user wants to continue if a large adjustment took place.
								// Or if data was within specified acceptable range
Int		li_ReturnValue = 1	 //assumed success

DataStore lds_Source
DataStore lds_itin

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

n_cst_msg 			lnv_msg
s_parm 				lstr_parm
w_DataValidate 	lw_DataValidate
ls_ErrorMessage = "An unexpected error occurred while calculating mileage adjustments."


lds_Source = of_getStateSource()
	
If NOT isValid(lds_Source) THEN
	li_ReturnValue = -1
END IF


 
IF li_ReturnValue = 1 THEN

	DO		// this loop will allow user to re-enter ft data if mileage falls outside range 
		
		open (w_FuelTaxInfo)
		lnv_msg = message.powerobjectParm
		
		lb_Again = FALSE
		ld_TotalMiles = 0
		
		IF lnv_msg.of_get_parm("SUCCESS",lstr_parm) <> 0 THEN
			
			li_Continue = lstr_parm.ia_Value
			
		END IF	
	
	
	
		IF li_Continue = -1 THEN
			
			li_ReturnValue = 0   // user canceled -- no further action
			
		ELSE	// extract all info entered in the FT info window
			
			IF lnv_msg.of_get_Parm("STARTOD",lstr_parm) <> 0 THEN
				
				ldec_StartOD = dec(lstr_parm.ia_Value)		
				
			ELSE
				
				li_ReturnValue = -1
				
			END IF
				
			IF lnv_msg.of_get_Parm("ENDOD",lstr_parm) <> 0 THEN
				
				ldec_EndOD = dec(lstr_parm.ia_Value)	
				
			ELSE
				
				li_ReturnValue = -1	
				
			END IF
	
			IF lnv_msg.of_get_Parm("CUTOFF",lstr_parm) <> 0 THEN
				
				ll_CutOff = long(lstr_parm.ia_Value)		
				
			ELSE
				
				li_ReturnValue = -1
				
			END IF
			
		END IF				

			
			
		IF li_ReturnValue = 1 THEN 
			
			ll_RowCount = lds_Source.rowCount()	
				
			// users are required to enter an ending OD >= starting OD in the FT info window.
			ld_ODDiff = ldec_EndOD - ldec_StartOD
			
			For i = 1 TO ll_RowCount
				
				If lds_Source.object.total[i] > 0 THEN
					
					ld_TotalMiles = ld_TotalMiles + lds_Source.object.total[i]
					
				END IF
				
			Next
			
			ld_CalcToActualDiff = Abs ( ld_TotalMiles - ld_OdDiff )
			ld_MileageMissingFlag = (ll_CutOff / 100) * ld_TotalMiles

			IF ld_CalcToActualDiff > ld_MileageMissingFlag THEN

				ls_Message = "Starting Odometer: " + String ( ldec_StartOD ) +&
					"~rEnding Odometer: " + String ( ldec_EndOD ) +&
					"~r~rOdometer Mileage: " + String ( ld_ODDiff ) +&
					"~rCalculated Mileage: " + String ( ld_TotalMiles ) +&
					"~r~rThe differential of " + String ( ld_CalcToActualDiff ) +& 
					" miles is outside of the specified acceptable range of " +string( ll_cutoff ) + " %."+&
					"~r~rWould you like to re-enter the odometer readings?"

				CHOOSE CASE messageBox("Mileage Adjustments", ls_Message, QUESTION!, YESNOCANCEL!, 1 )

				CASE 1
					lb_Again = TRUE
					CONTINUE

				CASE 2
					//Proceed

				CASE ELSE //3
					li_ReturnValue = 0
					
				END CHOOSE
				
			END IF
			
		END IF	
		
	LOOP WHILE li_ReturnValue = 1 AND lb_Again		
	
END IF

		
IF li_ReturnValue = 1 THEN
	
	// This is where the mileage adjustment happens
	IF ld_TotalMiles > 0 THEN
		
		For i = 1 To ll_RowCount
			
			ld_TempProportionValue = ld_ODDiff * lds_Source.object.Total[i]
			ld_AdjustedMile  =  (ld_TempProportionValue / ld_TotalMiles)     
			lds_Source.object.AdjustedMileage[i] = ld_AdjustedMile
			ld_AdjTot += ld_AdjustedMile  // this is used to determine if any rounding 
										 		  //  issues need to be resolved
		Next	    	
	
	
		//This is where the rounding issues are resolved, if necessary.
		//If there is a difference between the adjusted total and the odometer total, 
		//we will add or subtract tenths from as many rows as necessary until the 
		//adjusted total equal the odometer total (which it must, for reporting purposes.)

		IF ll_RowCount > 0 THEN
				
			if ld_ODDiff > ld_adjTot  THEN
				ld_Shim = 0.1
				lb_Round = TRUE
			ELSEIF ld_ODDiff < ld_adjTot THEN
				ld_Shim = -0.1
				lb_Round = TRUE
			ELSE 
				lb_Round = FALSE
			END IF


			IF lb_Round THEN
				
				i = 0
				do 
					i++
					IF i > ll_RowCount THEN i = 1
					
					lds_Source.object.AdjustedMileage[ i ] = lds_Source.object.AdjustedMileage[ i ] + ld_shim					
					ld_adjTot += ld_Shim
				loop until ld_AdjTot = ld_ODDiff
			
			END IF
		
		END IF

	END IF 


	lds_Source.Modify ("st_odometer.text ='Starting Odometer: " + string(ldec_startod) +  "    Ending Odometer: " +string(ldec_endod) + "'" )	
	
	IF ld_CalcToActualDiff > ld_MileageMissingFlag THEN
		
		lstr_parm.is_label = "MESSAGE"
		lstr_Parm.ia_Value = "Calculated Mileage is "+ string(ld_TotalMiles) + &
					" miles. This value is OUTSIDE The Specified Acceptable Range of "+string(ll_cutOff)+"%."&
					+ " Click EXPORT if you wish to export file anyway. "
		lnv_msg.of_add_parm(lstr_parm)
		
		lstr_parm.is_label = "RESULT"
		lstr_parm.ia_Value = "FAIL"
		lnv_msg.of_add_parm(lstr_parm)
		
	Else
		
		lstr_parm.is_label = "MESSAGE"
		lstr_parm.ia_Value = "Calculated Mileage is " +string(ld_TotalMiles) + &
			" miles. This is WITHIN the Specified Acceptable Range of "+ String(ll_cutOff)+ "%."
		lnv_msg.of_add_parm(lstr_parm)
	
		lstr_parm.is_label = "RESULT"
		lstr_parm.ia_Value = "PASS"
		lnv_msg.of_add_parm(lstr_parm)
	
	END IF
	
	
	lstr_parm.is_label = "TOTALMILES"
	lstr_parm.ia_Value = ld_TotalMiles
	lnv_msg.of_add_parm(lstr_parm)
	
	lstr_parm.is_label = "ODDIFF"
	lstr_parm.ia_Value = ld_ODDiff
	lnv_msg.of_add_parm(lstr_parm)
	
	lstr_parm.is_label = "STATEREPORT"
	
	
	
	IF isValid ( lds_Source )	THEN
		
	// an empty row is added here if rowcount = 0 so report will display properly
		IF lds_Source.RowCount() = 0 THEN
			
			lds_Source.insertRow(0)
			
		END IF
		
		lstr_parm.ia_Value = lds_Source	
		lnv_msg.of_add_parm(lstr_parm)
		
	ELSE 
		
		li_ReturnValue = -1
		
	END IF
	
	
	lstr_parm.is_label = "ITINREPORT"

	IF isValid ( ids_itin_quick ) THEN
		
		// an empty row is added here if rowcount = 0 so report will display properly
		IF ids_Itin_Quick.RowCount() = 0 THEN
			
			ids_Itin_Quick.insertRow(0)
			
		END IF
		
		lstr_parm.ia_Value = ids_itin_quick
		lnv_msg.of_add_parm(lstr_parm)
		
	ELSEIF Not is_context = cs_context_fuelTax THEN
		
		li_ReturnValue = -1
		
	END IF
	
	anv_msg = lnv_msg		
	
END IF
		

	

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

RETURN  li_ReturnValue

//@(text)--



end function

protected function integer of_calcitinmileage ();/*====================================================================================
	Calculate Itin Mileage:
					this function calculates the mileage for an itinerary 
					(ids_itin_quick) that has already been populated.
					this procedure does not check for a previous stop.
					however mileage occuring from the stop in is_previousPcm will
					be calculated.
					
					of_CheckPreviousEvent() can be called to populate is_PreviousPcm
					prior the call of this precedure.
					
					Return Values:
								 1 = success
								-1 = Failure
===================================================================================*/

String	ls_pcmPrev
String	ls_pcm
String	ls_ErrorMessage
Long		i
Long		ll_RowCount
Long		ll_Minutes
Dec		lc_miles

Int 		li_ReturnValue = 1


n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error
ls_ErrorMessage = "An error occurred while calculating mileage."



IF NOT isValid( ids_itin_quick ) THEN
	li_ReturnValue = -1 
END IF

IF li_ReturnValue = 1 THEN
	ls_pcmPrev = is_PreviousPCM
	ll_RowCount = ids_itin_quick.RowCount ( )
	
	for i = 1 to ll_RowCount 
		ls_pcm = ids_itin_quick.object.co_pcm[ i ]

		if len(ls_pcmPrev) > 0 and len(ls_pcm) > 0 then
			gf_calc_miles(ls_pcmPrev, ls_pcm, lc_miles, ll_minutes, 0)


		else  // unrecognized by pcm 
				setnull(lc_miles)
				setnull(ll_minutes)					
		end if

		ids_itin_quick.object.leg_miles[ i ] = lc_miles
		
		if len(ls_pcm) > 0 then ls_pcmPrev = ls_pcm
	next

	ids_itin_quick.groupcalc()
	
END IF


//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

RETURN li_ReturnValue
end function

protected function integer of_calculaterevenue ();/*===================================================================================
 calculate revenue:
 				This function calculates the revenue associated with a specific trip
				in the pre-populated itinerary ( ids_itin_quick). 
				
				Return Values:
							
							 1 = Success
							-1 = Failure

====================================================================================*/




Int		lia_Shipment_Counts[]
String	ls_ErrorMessage 
Long		lla_Shipment_ids[]
Long		ll_UpperBound
Long		ll_MarkLoop
Long		ll_id
Long		ll_ndx
Long		ll_RowCount
Dec{5}	lc_allocation
Dec{2}	lca_Shipment_Revenues[]

Int 		li_ReturnValue = 1

n_cst_anyarraysrv lnv_anyarray
n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

ls_ErrorMessage = "An unexpected error occurred while attempting to calculate revenues."

IF is_Context = cs_context_historyreport THEN

	IF Not isValid ( ids_itin_quick ) THEN
		li_ReturnValue = -1
	END IF
	
	IF li_ReturnValue = 1 THEN
		
		ll_RowCount = ids_itin_quick.RowCount ( )	
		IF ll_RowCount > 0 THEN
			lla_shipment_ids = ids_itin_quick.object.de_shipment_id.primary
			
			if of_retrieve_revcounts(lla_shipment_ids, lia_shipment_counts, lca_shipment_revenues) = -1 THEN
				li_ReturnValue =  -1
			END IF
		END IF
				
		IF li_ReturnValue = 1 THEN
			ll_upperbound = upperbound(lla_shipment_ids)
			if ll_upperbound > 0 then
				for ll_markloop = 1 to ll_RowCount
					ll_id = ids_itin_quick.object.de_shipment_id[ll_markloop]
					if ll_id > 0 then
						ll_ndx = lnv_AnyArray.of_FindLong(lla_shipment_ids, ll_id, 1, ll_upperbound)
						if ll_ndx > 0 then
							if lia_shipment_counts[ll_ndx] > 0 and lca_shipment_revenues[ll_ndx] > 0 then
								lc_allocation = lca_shipment_revenues[ll_ndx] / lia_shipment_counts[ll_ndx]
								ids_itin_quick.object.xx_revenue[ll_markloop] = lc_allocation
							end if
						end if
					end if
				next
			end if
		END IF
	END IF

ELSE	

	ids_itin_quick.Modify ( "comp_revenue_group.visible = 0 comp_revenue_all.visible = 0 " )

END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//



return li_ReturnValue

end function

protected function long of_checknullsites ();/*================================================================================
	Check Null Sites:
			this function check to see if any sites/locations in the pre-populated
			itinerary are null. 


		Return Values:
					-1 = Failure 
					 0 = No Null sites found
				 # > 0 = Number of null sites found  THIS WILL RESULT IN -1 IN FUEL
				 									 TAX CONTEXT
					
================================================================================*/


long 		i
long		ll_RowCount
long		ll_Site
long		ll_NullCount 
String	ls_MessageHeader = "Prepare Report"
String	ls_Message
String	ls_ErrorMessage = "An unexpected error occurred while evaluating stops"
n_cst_beo_Event	lnv_Event

long		ll_ReturnValue 


n_cst_OFRError_collection lnv_ErrorCollection
n_cst_OFRError lnv_Error
n_cst_OFRError lnv_ErrorArray[]

lnv_Event = CREATE n_cst_beo_Event

IF Not isvalid ( ids_itin_quick ) THEN
	ll_ReturnValue = -1
END IF

IF ll_ReturnValue <> -1 THEN

	ll_RowCount = ids_itin_quick.RowCount ( )
	lnv_Event.of_SetSource ( ids_Itin_Quick )
	
	FOR i = ll_RowCount TO 1 STEP -1

		ll_site = ids_itin_quick.getitemnumber( i , "de_site")

		IF isNull( ll_site )   THEN

			lnv_Event.of_SetSourceRow ( i )

			IF lnv_Event.of_IsLocationOptional ( ) THEN
				ids_Itin_Quick.RowsDiscard ( i, i, Primary! )
			ELSE
				ll_NullCount ++
			END IF

		END IF
		
	NEXT
	
	
	
END IF

IF ll_NullCount > 0 THEN
	
	CHOOSE CASE is_context
			
	CASE cs_context_historyreport , cs_context_statebreakdown
		ls_Message = "Profit Tools encountered "+string(ll_NullCount) + " unspecified event site(s). Itinerary may not reflect actual travel."
		messageBox(ls_messageHeader , ls_Message , EXCLAMATION! )
		ll_ReturnValue = ll_NullCount
		
	CASE cs_context_fueltax
		ll_ReturnValue = -1
		ls_Errormessage = "Profit Tools encountered "+string(ll_NullCount) + " unspecified event site(s). Fuel Tax reports can't be generated with unspecified event locations."
	END CHOOSE		
	
	
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\

IF ll_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//

DESTROY ( lnv_Event ) 

return ll_ReturnValue
			
		
end function

protected function long of_checkpcmlocators (ref n_cst_msg anv_msgobj); /*===================================================================================
Check PCM Locators:
		This Function checks the pre-populated itinerary to validate the provided 
		PC*miler locators. If and are found a message object is populated with 
		the coresponding site name for display purposes.
		
		Return Values:
			    -1 = Failure
				 0 = User Cancel
			 	 1 = Success


====================================================================================*/

Long	i
Long	j
Long 	ll_RowCount
Long	ll_upperBound
Long	ll_site
Long	lla_Ids[]
String	ls_pcm
String	ls_Site
String	lsa_siteArray[]
String	ls_Message
String	ls_ErrorMessage
Boolean lb_Repeat  = FALSE
n_cst_beo_Event	lnv_Event

Long	ll_ReturnValue = 1

n_cst_msg	lnv_msg
s_parm 		lstr_parm

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError	lnv_ErrorArray[]
n_cst_OFRError	lnv_Error

lnv_Event = CREATE n_cst_beo_Event

ls_ErrorMessage = "An unexpected error occurred while attempting to check validity of PC*Miler locators."

IF Not IsValid ( ids_itin_quick ) THEN
	ll_ReturnValue = -1
END IF

IF ll_ReturnValue <> -1 THEN

	//Do a first pass to discard rows for LocationOptional events with bad locators.

	ll_RowCount = ids_Itin_Quick.RowCount ( )
	lnv_Event.of_SetSource ( ids_Itin_Quick )
	
	FOR i = ll_RowCount TO 1 STEP -1

		ls_pcm = ids_itin_quick.object.co_pcm[ i ]

		IF isNull(ls_Pcm) OR len(ls_Pcm) = 0 THEN

			lnv_Event.of_SetSourceRow ( i )

			IF lnv_Event.of_IsLocationOptional ( ) THEN
				ids_Itin_Quick.RowsDiscard ( i, i, Primary! )
			ELSE
				//Leave the row alone.  It needs to be flagged as a problem.
			END IF

		END IF
		
	NEXT


	//Do a second pass to check the locators of rows remaining.

	ll_RowCount = ids_itin_quick.rowCount ( ) 
	
	for i = 1 to ll_RowCount 
		ll_site = ids_itin_quick.getitemnumber( i , "de_site")
		IF isNull ( ll_Site ) THEN
			continue
		END IF
		
		//comments on what is going on here would be nice!
		ls_pcm = ids_itin_quick.object.co_pcm[ i ]

		IF isNull(ls_Pcm) OR len(ls_Pcm) = 0 THEN

			ls_Site = string(ids_itin_quick.object.de_Site[ i ])
			lb_Repeat = FALSE
			ll_upperBound = upperBound( lsa_SiteArray )
			for j = 1 to ll_upperbound
				IF lsa_siteArray[j] = ls_site THEN
					lb_Repeat = TRUE
					EXIT
				END IF
			NEXT
			
			IF NOT lb_Repeat THEN
				ll_UpperBound ++
				lsa_SiteArray[ ll_UpperBound ] = ls_Site
				
				lstr_parm.is_Label = "id"
				lstr_parm.ia_Value = ls_Site
				lnv_msg.of_add_Parm(lstr_Parm)	
				
			END IF
		END IF	
	next
END IF

For i = 1 TO UpperBound ( lsa_SiteArray )
	lla_Ids[i] = Long (lsa_SiteArray[i])
NEXT
lstr_parm.is_Label = "IDS"
lstr_parm.ia_Value = lla_Ids
lnv_msg.of_add_Parm(lstr_Parm)	

IF ll_UpperBound > 0 THEN
	
	openWithParm(w_colist, lnv_msg )
	
	CHOOSE CASE is_Context
	
	CASE cs_context_historyreport , cs_context_statebreakdown
		
			ls_Message = "The following "+string(ll_upperBound )+ " companies do not have PC*Miler locators assigned to them. ~r~n" &
					+ "This will affect the mileage reported in the equipment report.~r~n" &	 
					+ "Visit the company info screen if you wish to assign a locator."
					
			IF MessageBox( "Equipment Report" , ls_Message + "~r~n~r~nClick OK to generate report or Cancel to Quit." , EXCLAMATION! , OKCANCEL! ) = 2 THEN
				ll_ReturnValue = 0
			END IF
		
	CASE cs_context_fueltax
		
			ll_ReturnValue = -1
			ls_ErrorMessage	="The following "+string (ll_upperBound )+ " companies do not have PC*Miler locators assigned to them. ~r~n" &
					+ "All compaines must have locators in order to prepare the fuel tax data.~r~n" &
					+ "Please verify the PC*Miler locator for each company in the company info screen."
			
		
		
	END CHOOSE
	
	
END IF
		
	

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\

IF ll_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//

anv_msgobj = lnv_msg
DESTROY ( lnv_Event )


return ll_ReturnValue
end function

protected function integer of_checkpreviousevent (string as_category, long al_id, date ad_min, date ad_max);/*====================================================================================
Check Previous Event: 
		This function checks the event prior the first one in the date range specified.
		If one is found the locator is used to populate <is_previouspcm>.
	
	
	Return Values: 
				 1 : no error locating previous events/locators ok (Success)
				 	(Note: This capability has so far only been implemented for
					 ci_EquipmentCategory_PowerUnits.  Requests made for other
					 categories will return 1, without setting is_PreviousPCM.) 
					   OR
					 User wishes to continue after being warned (Context Dependent)
					 
				 0 : user initiated cancel
				 
				-1 : Previous-Event Missing Location (Context Dependent) OR FUNCTION FAILURE
				
====================================================================================*/


Boolean	lb_PreviousEventMissingLocation
Boolean 	lb_PreviousEventFailure
Integer 	li_result, li_category
Long		ll_PreviousEvent
String	ls_message
String 	ls_ErrorMessage

Int		li_returnValue = 1

s_eq_info lstr_eq_info
n_cst_EquipmentManager lnv_EquipmentMgr


n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error
ls_ErrorMessage = "An error occurred while checking previous event."



choose case as_category
case "DRIVER!"
	li_category = 1
case "EQUIPMENT!"
	if lnv_EquipmentMgr.of_get_info(al_id, lstr_eq_info, false) = 1 then
		li_category = lnv_EquipmentMgr.of_type_to_category(lstr_eq_info.eq_type)
	else
		li_ReturnValue  = -1
	end if
case else
	li_ReturnValue  = -1
end choose

IF li_ReturnValue = 1 THEN
	
	CHOOSE CASE li_Category
	
	CASE n_cst_Constants.ci_EquipmentCategory_PowerUnits
		//Only category for which PreviousEvent information is currently available
	
		IF NOT IsNull ( ad_Min ) THEN
		
			//If there is no min date, we are retrieving from the beginning of the equipment's
			//history, so there cannot be a previous event.
		
			CHOOSE CASE This.of_GetPreviousEvent ( li_Category, al_Id, ad_Min, ll_PreviousEvent )
		
			CASE 1
		
				CHOOSE CASE This.of_GetEventPcm ( ll_PreviousEvent, is_PreviousPcm )
		
				CASE 1
					//Previous event PCM determined successfully.  Proceed.
		
				CASE 0  //No company, or no pcm.
					lb_PreviousEventMissingLocation = TRUE
					
		
				CASE ELSE
					lb_PreviousEventFailure = TRUE
					
				END CHOOSE
		
			CASE 0
				//There is no previous event.  Proceed.
		
			CASE ELSE
				lb_PreviousEventFailure = TRUE
		
			END CHOOSE
	
		END IF
	
	END CHOOSE
	
	IF lb_PreviousEventFailure THEN
	
			ls_ErrorMessage = "Error attempting to identify the last event prior to the report period requested."

			li_returnValue = -1
		
	ELSEIF lb_PreviousEventMissingLocation THEN

		CHOOSE CASE is_context
				
		CASE cs_context_historyreport , cs_context_statebreakdown
			
			ls_Message = "The last event prior to the report period requested does not "+&
								"have a location specified, or the company does not have a PC*Miler locator." + &
								"  Mileage calculations will not reflect any travel that may have taken place "+&
								"between these two locations.~n~nDo you want to proceed with this procedure?"
			IF MessageBox ( "State Report", ls_Message, Exclamation!, YesNo!, 2 ) = 2 THEN 
				li_ReturnValue = 0
			END IF
			
		CASE cs_context_fueltax
			
			ls_ErrorMessage = "The last event prior to the report period requested does not "+&
								"have a location specified, or the company does not have a PC*Miler locator." + &
								"All compaines must have locators in order to prepare the fuel tax data.~r~n" &
								+ "Please verify the PC*Miler locator for each company in the company info screen. "
			li_ReturnValue = -1								


		END CHOOSE


	END IF
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

return li_returnValue
end function

protected function integer of_consolidateitin ();//Note: This function has been slated for deletion.  It is now not called, as of 2.4.00
//The code was in working order before being commented.

//RETURN -1

///*==============================================================================
//	Consolidate itinerary:
//	
//
//	The purpose of the following loop is to eliminate duplicate and null sites from each
//	daily listing, and to reassign the revenue involved so it is still included in the
//	daily totals (there is no event-by-event revenue listing.)  Incidences that span
//	more than one day must be left alone, since it would give an inaccurate picture
//	of where the vehicle had been on those days or of the daily revenue total.
//
//		Return Values:
//					-1 = Failure
//					 1 = Success
//				 
//==============================================================================*/
Long	ll_RowCount
Long	ll_MarkLoop
Long	ll_Site1
Long	ll_Site2

DateTime	ldt_arrDate1
Datetime	ldt_arrDate2 
Dec		lc_work1
Dec		lc_Work2
Int		li_Consolidation
String	ls_ErrorMessage

Int		li_ReturnValue = 1


ls_ErrorMessage = "An unexpected error occurred while attemping to consolidate itinerary."

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

IF is_Context = cs_context_historyreport THEN
	
	IF Not isvalid ( ids_itin_quick ) THEN
		li_ReturnValue = -1
	END IF
	
	IF li_ReturnValue <> -1 THEN
	
		ll_RowCount = ids_itin_quick.RowCount ( )
		
		for ll_markloop = ll_RowCount to 2 step -1
				ll_site1 = ids_itin_quick.getitemnumber(ll_markloop, "de_site")
				ll_site2 = ids_itin_quick.getitemnumber(ll_markloop - 1, "de_site")
				
			
			if ll_site1 = ll_site2 or isnull(ll_site1) then
				ldt_arrdate1 = datetime(ids_itin_quick.getitemdate(ll_markloop, "de_arrdate"))
				ldt_arrdate2 = datetime(ids_itin_quick.getitemdate(ll_markloop - 1, "de_arrdate"))
	
				li_consolidation = 0
	
				if ldt_arrdate1 = ldt_arrdate2 then
					li_consolidation = -1
				elseif isnull(ll_site1) then
				
					//A site match consolidation will always roll up, so there's no point checking
					//down if up isn't available (a potential downward match would already have
					//been rolled up on the previous pass).  A null site, on the other hand, is 
					//not affected by the prevoious pass and can therefore potentially be rolled
					//in either direction.
	
					if ids_itin_quick.rowcount() > ll_markloop then
						if ldt_arrdate1 = datetime(ids_itin_quick.getitemdate(ll_markloop + 1, &
							"de_arrdate")) then li_consolidation = 1
					end if
				end if
	
				if li_consolidation <> 0 then
	
					
					lc_work1 = ids_itin_quick.getitemdecimal(ll_markloop, "xx_revenue")
					if lc_work1 > 0 then
						lc_work2 = ids_itin_quick.getitemdecimal(ll_markloop + li_consolidation, "xx_revenue")
						if lc_work2 > 0 then lc_work1 += lc_work2
						ids_itin_quick.setitem(ll_markloop + li_consolidation, "xx_revenue", lc_work1)
					end if
					
	
					ids_itin_quick.rowsdiscard(ll_markloop, ll_markloop, primary!)
					
				end if
			end if
		next
	END IF
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
	


Return li_ReturnValue	
end function

protected function integer of_createheader (integer ai_category, long al_id, date ad_min, date ad_max, ref datastore ads_target, string as_reportname);String	ls_Range_01
String	ls_Report_name
String 	ls_Range_02
String	lsa_labels[]
Any		laa_Values[] 

s_emp_info	lstr_emp
n_cst_dws 	lnv_dws
n_cst_EquipmentManager lnv_EquipmentMgr

if isnull(ad_min) and isnull(ad_max) then
	ls_range_01 = "Complete History"
elseif isnull(ad_max) then
	ls_range_01 = "History from " + string(ad_min, "m/d/yy")
elseif isnull(ad_min) then
	ls_range_01 = "History to " + string(ad_max, "m/d/yy")
else
	ls_range_01 = string(ad_min, "m/d/yy") + " to " + string(ad_max, "m/d/yy")
end if

choose case ai_category
case 1
//	ls_report_name = "DRIVER HISTORY REPORT"
	lstr_emp.em_id = al_id
	if gf_emp_info(null_ds, null_str, null_str, lstr_emp) > 0 then
		ls_range_02 = lstr_emp.em_fn + " " + lstr_emp.em_ln
	end if
case else
//	ls_report_name = "EQUIP. HISTORY REPORT"
	if lnv_EquipmentMgr.of_get_description(al_id, "LONG_REF!", ls_range_02) = 1 then
		if isnull(ls_range_02) then ls_range_02 = ""
	end if
end choose

lsa_labels[upperbound(lsa_labels) + 1] = "TARGET!"
laa_values[upperbound(laa_values) + 1] = ads_target

lsa_labels[upperbound(lsa_labels) + 1] = "REPORT_NAME!"
laa_values[upperbound(laa_values) + 1] = as_ReportName

lsa_labels[upperbound(lsa_labels) + 1] = "REPORT_LABEL!"
laa_values[upperbound(laa_values) + 1] = "OFFICIAL COPY"

lsa_labels[upperbound(lsa_labels) + 1] = "RANGE_01!"
laa_values[upperbound(laa_values) + 1] = "'" + ls_range_01 + "'"

lsa_labels[upperbound(lsa_labels) + 1] = "RANGE_02!"
laa_values[upperbound(laa_values) + 1] = "'" + ls_range_02 + "'"

lnv_dws.of_create_header(lsa_labels, laa_values)


return 1

end function

protected function integer of_displayhistory (ref n_cst_msg anv_msg);/*================================================================================
	Display History:
	
		this procedure populates the message object with the info needed to open the window
		dataValidate in the correct context
		
		Return Values:
					-1 = Failure
					 1 = Success
*************					 
NOTE/WARNING:

		THIS FUNCTION ADDS AN EMPTY ROW TO IDS_ITIN_QUICK IF ROW COUNT = 0 SO THAT
		GET/SET FULL STATE WILL DISPLAY AN EMPTY TRIP REPORT.
		THIS SHOULD BE INVESTIGATED LATER.

*************
================================================================================*/

string	ls_ErrorMessage
int 		li_Result


INT		li_ReturnValue = 1

n_cst_msg 			lnv_msg
s_parm 				lstr_parm
w_DataValidate 	lw_DataValidate

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError	lnv_ErrorArray[]
n_cst_OFRError 	lnv_Error


ls_ErrorMessage = "An unexpected error occurred while evaluating the state breakdown report."
	
IF is_Context = cs_context_historyreport THEN
		
	lstr_parm.is_label = "RESULT"
	lstr_parm.ia_Value = cs_Context_HistoryReport
	lnv_msg.of_add_parm(lstr_parm)
	
	
	
	IF li_ReturnValue = 1 THEN
		lstr_parm.is_label = "ITINREPORT"
		IF isValid (ids_itin_quick) THEN
	
			IF ids_itin_quick.RowCount ( ) = 0 THEN
				ids_itin_quick.insertRow(0) // trip Report will not display w/o any rows. this should be investigated later.
			END IF
			
			lstr_parm.ia_Value = ids_itin_quick
			lnv_msg.of_add_parm(lstr_parm)
		ELSE
			li_ReturnValue = -1
		END IF
	END IF
	
	IF li_ReturnValue = 1 THEN
		anv_msg = lnv_msg
	END IF
	
END IF


//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\//

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
	    

return li_ReturnValue
end function

protected function integer of_genstatereport ();/*================================================================================
	Generate state report:
	
		This function generates a state breakdown of all the states for a pre-populated
		itinerary. 
		results are put in <ids_statereport>.
		mileage from previous stop is calculated IF <of_CheckPreviousEvent> is Called 
		successfully prior to this call.
			
			
		Return Values:
				-1 = Failure
				 0 = No Rows Retrieved for itin (success but processing stoped)
				 1 = Success
			
================================================================================*/
setpointer(Hourglass!)
Long		i, &
			ll_reportlines, &
			ll_return, &
			ll_FindResult
			
String	ls_ErrorMessage, &
	 		lsa_stringarr[], &
	  		ls_tempbuffer,&
		 	lsa_stops[], &
		  	ls_State, &
			ls_Test1, &
		 	lsa_UnknownStops[], &	
			ls_report, &
			lsa_report[]
			
n_cst_String	lnv_String
n_cst_routing	lnv_routing
n_cst_licensemanager	lnv_licensemanager
s_mapping		lstr_tripinfo
Int 	li_ReturnValue = 1    //assumed result, success 

ls_ErrorMessage = "An unexpected error occurred while attempting to calculate "+&
					"state breakdown information."

s_parm		lstr_Parm
n_cst_msg 	lnv_msg

DataStore 	lds_Source

w_Colist 	lw_Colist

n_cst_OFRError_collection lnv_ErrorCollection
n_cst_OFRError lnv_Error
n_cst_OFRError lnv_ErrorArray[]

ls_tempbuffer = Space(100)

IF is_Context = cs_context_fueltax OR is_Context = cs_context_statebreakdown THEN
	
	lds_Source = of_getStateSource()
	
	IF Not IsValid(lds_Source) THEN
		li_ReturnValue = -1
	END IF
	
	IF li_ReturnValue = 1 THEN 
		
		if inv_trip.of_connect(lnv_routing) then
			if lnv_routing.of_isvalid() then
				//continue
			else
				li_ReturnValue = -1
			end if
		else
			li_ReturnValue = -1
		end if
		
		if li_ReturnValue = -1 then
			ls_ErrorMessage = "You are not connected to PC*MILER. You may establish a connection from the System menu."
		end if
		
	end if
	
	IF li_ReturnValue = 1 THEN 
	
	
//				IF Len ( is_PreviousPcm ) > 0 THEN
//					ll_NumStops ++
//					lsa_Stops [ ll_NumStops ] = is_PreviousPcm
//				END IF
					
		ls_report=space(32768)
	
		ll_return = inv_trip.of_getreport(1, '', ls_report)
		if ll_return > 0 then
			if len(ls_report) > 0 then
				lnv_string.of_parsetoarray(ls_report, "~n", lsa_report)
				ll_reportlines=upperbound(lsa_report)
			end if
		else
			messagebox("Programmer's Warning", "No lines in the report.")
			li_ReturnValue = -1
		end if

		IF li_ReturnValue = 1 THEN 
			
			IF ll_ReportLines < 0 THEN  // posible error here with c-style indexing [0]
				li_ReturnValue = -1
				ls_ErrorMessage = "No report lines could be retrieved from PC*Miler."
			ELSE
				
				For i = 1 to ll_ReportLines
					ls_tempbuffer = lsa_report[i]
					lnv_string.of_parseToArray(ls_tempBuffer  , "~t" ,lsa_stringarr )
					
					// lsa_stringArr[2] is where the state will be if the line in the report is for a
					// specific state ( which is what we want) 
					
					if of_ValidateState( lsa_stringarr[ 2 ] ) = True THEN
						lds_Source.importString(ls_tempBuffer +"~r~n")
					END IF
				next
				
			END IF
			
			IF li_ReturnValue = 1 THEN 
			
				// here is where all total state mileage for each trip is combined
				i = lds_Source.RowCount()
				Do While i > 0
					
					ls_Test1 = lds_Source.object.State[i]
					ll_FindResult = lds_Source.Find ("State = '" + ls_Test1 + "'", 1, lds_Source.RowCount() + 1 )
					
					IF ll_FindResult > 0 AND i <> ll_FindResult THEN
						lds_Source.object.total[i] = (lds_Source.object.total[i] + lds_Source.object.total[ll_FindResult])
						lds_Source.object.Toll[i] = (lds_Source.object.Toll[i] + lds_Source.object.Toll[ll_FindResult])
						lds_Source.object.Free[i] = (lds_Source.object.Free[i] + lds_Source.object.Free[ll_FindResult])
						lds_Source.object.Ferry[i] = (lds_Source.object.Ferry[i] + lds_Source.object.Ferry[ll_FindResult])
						lds_Source.object.Loaded[i] = (lds_Source.object.Loaded[i] + lds_Source.object.Loaded[ll_FindResult])
						lds_Source.object.Empty[i] = (lds_Source.object.Empty[i]  + lds_Source.object.Empty[ll_FindResult])
						lds_Source.RowsDiscard(ll_FindResult, ll_FindResult, Primary!)
					Else 
						i --
					END IF
					
				loop
				
			END IF	
			
		END IF
		
	END IF
					
END IF // context

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\

IF li_ReturnValue = -1 AND Len ( ls_ErrorMessage ) > 0 THEN  // length check added 1/23/01
 	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//

Return li_ReturnValue



end function

public function string of_getdestination ();String 	ls_dest, &
			ls_ErrorMessage, &
			ls_locater

Int		li_ReturnValue = 1

dataStore 		lds_TaxDetails

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError	lnv_ErrorArray[]
n_cst_OFRError	lnv_Error

ls_ErrorMessage = "An error occurred while retrieving the destination."

lds_TaxDetails = ids_itin_quick

Long	ll_RowCount
Long	i


ll_RowCount = lds_TaxDetails.RowCount ( )

IF isValid ( lds_TaxDetails ) THEN
	FOR i = ll_RowCount TO 1 STEP -1
		IF ll_RowCount > 0 THEN
			ls_locater = lds_TaxDetails.object.co_pcm[ i ] 
			IF isnumber ( left ( ls_locater, 5 ) ) THEN
				ls_dest = trim ( right ( ls_locater, len ( ls_locater )  - 6 ) )
			ELSE
				ls_dest = trim ( ls_locater )
			END IF
			
			IF len ( ls_Dest ) > 0 THEN
				EXIT
			END IF
			
	//		ls_Dest = left( trim ( string ( lds_TaxDetails.object.co_City[ lds_TaxDetails.rowCount ( ) ] ) ) , 20 ) + &
	//						" "+string ( lds_TaxDetails.object.co_State[ lds_TaxDetails.rowCount ( ) ] )
		ELSE
			li_ReturnValue = -1
			
		End IF
	NEXT
	
Else	
	
	li_ReturnValue = -1
	
END IF


IF isNull(ls_Dest) AND li_ReturnValue = 1 THEN
	
	ls_Dest = "No Destination"
	
ELSEIF li_ReturnValue = -1 THEN
	
	ls_ErrorMessage = "A destination could not be retrieved from the itinerary."
	
END IF


//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\//

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//


return ls_dest
end function

protected function integer of_geteventpcm (readonly long al_id, ref string as_pcm);//Returns:  1 = Success (PCM Locator for the event returned by reference), 
//0 = Event has no PCM  (no company, or company without PCM), 
//-1 = Error  (no event with specified ID, or other problem)

Long	ll_Company
String	ls_PCM

Integer	li_Return = -1
SetNull ( as_Pcm )


SELECT de_Site INTO :ll_Company FROM disp_events WHERE de_id = :al_Id ;

CHOOSE CASE SQLCA.SqlCode

CASE 0

	IF ll_Company > 0 THEN
	
		SELECT co_Pcm INTO :ls_PCM FROM Companies WHERE co_id = :ll_Company ;

		CHOOSE CASE SQLCA.SqlCode

		CASE 0
	
			IF Len ( ls_PCM ) > 0 THEN
		
				as_Pcm = ls_PCM
				li_Return = 1

			ELSE
				li_Return = 0

			END IF

		CASE ELSE
			//Fail

		END CHOOSE

	ELSE
		li_Return = 0

	END IF

CASE ELSE
	//Fail

END CHOOSE


//Commit transaction.  We're just doing selects, so even if they've failed, it's harmless.
COMMIT ;


//If a PCM Locator has been determined, pass it out.

IF li_Return = 1 THEN
	as_Pcm = ls_Pcm
END IF

RETURN li_Return
end function

public function string of_getorigin ();String	ls_origin, &
			ls_ErrorMessage, &
			ls_test, &
			ls_locater

Int			li_ReturnValue = 1

dataStore 	lds_TaxDetails

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError	lnv_ErrorArray[]
n_cst_OFRError	lnv_Error

ls_ErrorMessage = "An error occurred while retrieving the origin."


lds_TaxDetails = ids_itin_quick
IF isValid(lds_TaxDetails) THEN
	IF lds_TaxDetails.RowCount() > 0 THEN
		ls_locater = lds_TaxDetails.object.co_pcm[1]
		IF isnumber ( left ( ls_locater, 5 ) ) THEN
			ls_Origin = trim ( right ( ls_locater, len ( ls_locater )  - 6 ) )
		ELSE
			ls_Origin = trim ( ls_locater )
		END IF
//		ls_Origin = left( trim ( string(lds_TaxDetails.object.co_City[1] ) ) , 20) + &
//						" " +String(lds_TaxDetails.object.co_State[1])
	ELSE
		li_ReturnValue = -1
		
	END IF
Else	
	
	li_ReturnValue = -1
	
END IF

IF isNull(ls_Origin) AND li_ReturnValue = 1 THEN

	ls_Origin = "No Origin"
	
ELSEIF li_ReturnValue = -1 THEN
	
	ls_ErrorMessage = "An origin could not be retrieved from the itinerary."
	
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\//

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//



return ls_origin
end function

public function integer of_process_report (string as_category, long al_id, string as_context);/*============================================================================== 
Process Reports (overloaded):

	This function resolves the context of the report to be produced and open
	w_date_range to aquire dates.
		
	
	is_Context = cs_context_historyreport  
					 cs_context_statebreakdown
				 	 cs_context_fueltax
				 
	
		
	Return Values:
				-1 = Failure
				 1 = Success
				 0 = user canceled
=============================================================================*/

choose case as_Context
	case cs_context_statebreakdown,  cs_context_fueltax 
		//	Request a lock for user
		integer li_RetVal
		n_cst_LicenseManager lnv_LicenseManager 
		li_RetVal = lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_FuelTax, "E" )
		IF li_Retval < 0 THEN
			return -1
		END IF
end choose

Date 	ld_min
Date	ld_max
Int 	li_validationReturn

Int 	li_result = 1

s_anys 		lstr_result
n_cst_msg	lnv_msg
s_Parm		lstr_parm
n_cst_OFRError_Collection lnv_ErrorCollection

li_ValidationReturn  = THIS.of_ValidateCategory ( as_category , as_context , al_id )

IF li_ValidationReturn = -1 THEN

	MessageBox( "Generate Report" , "A report could not be generated for the type of equipment specified.", EXCLAMATION! )
	li_Result = -1

ELSE

	// determines if date range is optional or not default is = optional
	IF as_Context <> cs_context_historyreport THEN
		lstr_parm.is_label = "OPTIONAL"
		lstr_Parm.ia_Value = "FALSE"
		lnv_msg.of_add_Parm ( lstr_Parm )
		
		openWithParm(w_date_range , lnv_msg)
		
	ELSE
	
		open (w_date_range )
		
	END IF
	
	
	lstr_result = message.powerobjectparm
	li_result = lstr_result.anys[1]
	
	if li_result = 1 then
		ld_min = lstr_result.anys[2]
		ld_max = lstr_result.anys[3]
		li_result = of_process_report(as_category, al_id, as_context , ld_min, ld_max)
	else
		li_result = 0
	end if
	
END IF


RETURN li_result
end function

public function integer of_process_report (string as_category, long al_id, string as_context, date ad_min, date ad_max);/*============================================================================
	Process Reports (overloaded):
			This Function calls all the necessary functions/procedures to 
			produce the appropriate report.

	>> This is where any accumulated/propagated errors will be displayed.  <<		
			
			Return Values:
							 1 = success
							 0 = no action (user cancel)
							-1 = failure 
							
============================================================================*/							

choose case as_Context
	case cs_context_statebreakdown,  cs_context_fueltax 
		//	Request a lock for user
		integer li_RetVal
		n_cst_LicenseManager lnv_LicenseManager 
		li_RetVal = lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_FuelTax, "E" )
		IF li_Retval < 0 THEN
			return -1
		END IF
end choose

String 	ls_pages
String	ls_Message
String	ls_PrevEventMessage
String 	ls_ErrorMessage
String	ls_MessageHeader
String	ls_ReportName
Int		li_DisplayHistoryReturn
Int		li_CalcItinMileageReturn 
Int		li_PreviousEventReturn 
Int 		li_AdjustmentReturn 
Int		li_RevenueReturn 
Int		li_ConsolidationReturn 
Int		li_Continue
Int		li_ValidationReturn
Int		li_Category
Long 		ll_RetrieveReturn 
Long		ll_CutOff
Long		ll_pcmCheck 
Long		ll_NullSiteCount 
Long		ll_consolidatedRows 
Long		ll_CopyReturn
Dec		ldec_EndOD
Dec		ldec_StartOD
Boolean	lb_NeedPrevious = TRUE


Int		li_ReturnValue = 1

w_dataValidate lw_dataValidate
//w_FuelTaxInfo	lw_FuelTaxInfo

n_cst_string	lnv_string

s_Parm			lstr_Parm
n_cst_msg		lnv_msg


ls_ErrorMessage = "Processing of report failed."

n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection

ls_MessageHeader = "Prepare Report"


is_context = as_context

IF  len(as_category) = 0 OR isNull (as_category) OR isNull (al_id) THEN	
	li_ReturnValue = -1
END IF

IF is_context = cs_context_fuelTax AND ( isNull( ad_min ) OR isNull( ad_max ) ) THEN
	li_ReturnValue = -1 
END IF

IF li_ReturnValue = 1 THEN 
	li_ValidationReturn  = THIS.of_ValidateCategory ( as_category , as_context , al_id ) 
	IF li_ValidationReturn = -1 THEN
		MessageBox( "Generate Report" , "A report could not be generated for the type of equipment specified.", EXCLAMATION! )
		li_ReturnValue = -1		
	END IF
END IF

IF is_Context = cs_context_fuelTax OR is_Context = cs_Context_StateBreakdown THEN
	
	IF li_ReturnValue = 1 THEN
		THIS.of_ProcessFuelTax ( as_category, al_id, ad_min, ad_max, as_context ) 
	END IF
ELSE



	IF li_ReturnValue = 1 THEN
		
		ll_RetrieveReturn = of_retrieve_itin(as_category, al_id, ad_min, ad_max)
		
		IF ll_RetrieveReturn = -1 THEN
			
			ls_ErrorMessage = "An unexpected error occurred while attempting to retrieve an itinerary from the database."
			
			li_ReturnValue = -1
		END IF
		
	END IF
	
	
	IF li_ReturnValue = 1 THEN
		
		li_PreviousEventReturn = This.of_CheckPreviousEvent ( as_category, al_id, ad_min, ad_max)
		
		IF li_PreviousEventReturn = -1 THEN
			
			li_ReturnValue = -1
			
		ELSEIF li_PreviousEventReturn = 0 THEN
			
			li_ReturnValue = 0
			
		END IF
		
	END IF
	
	
	// sites will be checked for validity. if any null sites or bad locators are encountered 
	// user is warned note: checkPCMLocators() does not report null sites.
		
	IF li_ReturnValue = 1 THEN
		
		ll_NullSiteCount = THIS.of_CheckNullSites ( )
		
		IF ll_NullSiteCount = -1 THEN
			
			li_ReturnValue = -1			
			
		END IF
		
	END IF
	
	IF li_ReturnValue = 1 THEN
		
		ll_pcmCheck = THIS.of_CheckPCMLocators ( lnv_msg )
	
		IF ll_pcmCheck = -1 THEN
			
			li_ReturnValue = -1
			
		ELSEIF ll_PCMCheck = 0 THEN
			
			li_ReturnValue = 0
			
		END IF
			
	END IF
	
	IF li_ReturnValue = 1 THEN
		
		IF  THIS.of_CalculateRevenue ( ) = -1 THEN
			
			li_ReturnValue = -1 
			
		END IF
		
	END IF
	
//	IF li_ReturnValue = 1 THEN
//		
//		IF  THIS.of_ConsolidateItin ( ) = -1 THEN
//			
//			li_ReturnValue = -1
//			
//		END IF
//		
//	END IF
	
	
	
	IF li_ReturnValue = 1 THEN
		
		li_CalcItinMileageReturn = THIS.of_CalcItinMileage( )
		
		IF li_CalcItinMileageReturn <> 1 THEN
			
			li_ReturnValue = -1
			
		END IF
		
	END IF
	
	
	IF li_ReturnValue = 1 THEN
		
		IF of_genStateReport ( ) = -1 THEN
			
			li_ReturnValue = -1
			ls_ErrorMessage = "An unexpected error occurred while attempting to generate a state breakdown report."
			
		END IF
		
	END IF
	
	IF li_ReturnValue = 1 THEN
		
		CHOOSE CASE is_Context   // message objects will be populated with the proper info depending 
										 // on the context. the message object will flow back out and be used to 
										 // open the window with the proper data
										 // None of the three procedures below will actually open a window
										 // dispite the name.
				
		CASE cs_context_HistoryReport
			
			li_ReturnValue  =  THIS.of_DisplayHistory ( lnv_msg )
			
		CASE cs_context_statebreakdown
			
			li_ReturnValue  =  THIS.of_preTaxValidation ( lnv_msg )
			
		CASE cs_context_FuelTax
			
			li_ReturnValue  =  THIS.of_CalcAdjustments( lnv_msg )
			
		END CHOOSE
		
	END IF
	
	
	
	IF li_ReturnValue  = 1 THEN
		
		lstr_Parm.is_Label = "ID"
		lstr_Parm.ia_Value = al_id
		lnv_msg.of_Add_Parm ( lstr_parm )
		
		lstr_Parm.is_Label = "STARTDATE"
		lstr_Parm.ia_Value = ad_min
		lnv_msg.of_Add_Parm ( lstr_parm )
		
		
		lstr_Parm.is_Label = "ENDDATE"
		lstr_Parm.ia_Value = ad_max
		lnv_msg.of_Add_Parm ( lstr_parm )
		
	
		lstr_Parm.is_Label = "ITIN"
		lstr_Parm.ia_Value = ids_itin_quick
		lnv_msg.of_Add_Parm ( lstr_parm )
		
		lstr_Parm.is_Label = "STATEREPORT"
		lstr_Parm.ia_Value = ids_statereport
		lnv_msg.of_Add_Parm ( lstr_parm )
		
		
		lstr_Parm.is_Label = "ORIG"
		lstr_Parm.ia_Value = of_GetOrigin( )
		lnv_msg.of_Add_Parm ( lstr_parm )
		
		lstr_Parm.is_Label = "DESTINATION"
		lstr_Parm.ia_Value = of_GetDestination ( ) 
		lnv_msg.of_Add_Parm ( lstr_parm )
		
		
		openwithparm(lw_dataValidate , lnv_msg )     // window is opened with the proper data here
		
	END IF
		
END IF
//* Error Reporting *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
int 	li_errorCount
int	i

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = upperBound(lnva_Error)


For i = 1 TO li_ErrorCount

	MessageBox("Prepare Report" , string( lnva_Error[i].getErrorMessage() ), EXCLAMATION! )

next

IF li_ErrorCount > 0 THEN
	
	li_ReturnValue = 0
	
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//

//DESTROY lnv_Dispatch
RETURN li_ReturnValue




end function

public function integer of_validatecategory (string as_category, string as_context, long al_id);s_eq_info lstr_eq_info
n_cst_EquipmentManager lnv_EquipmentMgr
int 	li_category
int	li_ReturnValue = 1

CHOOSE CASE as_context

CASE cs_context_fueltax

	//Currently, fuel tax is the only restricted context, so do all validation here

	choose case as_category
	case "DRIVER!"
		li_category = 1
	case "EQUIPMENT!"
		if lnv_EquipmentMgr.of_get_info(al_id, lstr_eq_info, false) = 1 then
			li_category = lnv_EquipmentMgr.of_type_to_category(lstr_eq_info.eq_type)
		else
			li_ReturnValue  = -1
		end if
	case else
		li_ReturnValue  = -1
	end choose

	IF li_ReturnValue = 1 THEN
		IF li_Category <>  n_cst_Constants.ci_EquipmentCategory_PowerUnits THEN
			li_ReturnValue = -1   // can't do fuel tax for anything but powerunits
		END IF
	END IF

END CHOOSE


return li_ReturnValue

end function

private function integer of_addstops (readonly long al_tripid, readonly string asa_stops[]);// returns 1, -1
//
//
//
//
//  Added by Rick Zacher on 01/23/2001
////////////////////////////////////////

String	ls_BadStop
String	ls_ErrorMessage
Long	ll_NumStops
Long	i
Int	li_AddRtn
Int	li_ReturnValue = 1

ll_NumStops = UpperBound ( asa_stops )

FOR i = 1 TO ll_numStops  
	
	IF isNull ( asa_Stops[ i ] ) THEN

	ELSE

//		li_AddRtn = pcmsAddStop ( al_tripID, asa_stops[ i ] )//returns # of matching cities, -1 on error
		IF li_AddRtn < 1 THEN
			ls_BadStop = asa_Stops[i]
			CHOOSE CASE li_AddRtn 
				CASE 0 
					ls_ErrorMessage = "No matching cities were found for the stop ' " + ls_BadStop + " '"
				CASE ELSE
					ls_ErrorMessage = "An error occurred while attempting to add '" + ls_BadStop + "' to the trip."
			END CHOOSE
			
			IF is_Context = cs_Context_FuelTax THEN
				ls_ErrorMessage += " All sites must be resolved to perform the fuel tax processing. Processing stopped."
				li_ReturnValue = -1
			ELSE
				ls_ErrorMessage += " Mileage produced may not reflect actual mileage traveled. Do you want to continue with the processing?"
			END IF
		
			IF is_Context = cs_Context_FuelTax THEN
				MessageBox ( "Adding Stops" ,ls_ErrorMessage, INFORMATION! )
				li_ReturnValue = -1
				EXIT
			ELSE
				IF MessageBox ( "Adding Stops" ,ls_ErrorMessage+ "The mileage calculated may not be accurate. Do you want to continue with the processing?", QUESTION!, YESNO! , 2 ) = 2 THEN
					li_ReturnValue = -1 
					EXIT
				END IF
			END IF
			
		END IF
	END IF
NEXT

return li_ReturnValue 
end function

private function integer of_convertcategory (readonly long al_id, readonly string as_category);// Returns integer value for the string category -1 on error

integer li_category
s_eq_info lstr_eq_info
n_cst_EquipmentManager lnv_EquipmentMgr

int	li_ReturnValue = 1
int	li_type = -1

choose case as_category
case "DRIVER!"
	li_category = 1
case "EQUIPMENT!"
	if lnv_EquipmentMgr.of_get_info(al_id, lstr_eq_info, false) = 1 then
		li_category = lnv_EquipmentMgr.of_type_to_category(lstr_eq_info.eq_type)
	else
		li_ReturnValue = -1
	end if
case else
	li_ReturnValue = -1
end choose

IF li_ReturnValue = 1 THEN

	CHOOSE CASE li_Category

	CASE 1
		li_Type = gc_Dispatch.ci_ItinType_Driver

	CASE 2
		li_Type = gc_Dispatch.ci_ItinType_PowerUnit

	CASE 3
		li_Type = gc_Dispatch.ci_ItinType_TrailerChassis

	CASE 4
		li_Type = gc_Dispatch.ci_ItinType_Container

	END CHOOSE

END IF

Return li_Type
end function

private function integer of_getstopsarray (ref string asa_stops[]);Int			li_Return = 1
Long			ll_RowCount
Long 			i
dataStore	lds_Working

IF isValid ( inv_trip ) THEN
	lds_Working = inv_trip.ids_data
	
	IF Not IsValid ( lds_Working ) THEN
		li_Return = -1
	END IF
ELSE
	li_Return = -1
END IF

IF li_Return = 1 THEN
	ll_RowCount = lds_Working.RowCount ( )
	
	For i = 1 TO ll_RowCount 
		asa_stops[ upperbound ( asa_stops ) + 1] = lds_Working.object.stop[i]
	NEXT
	
END IF

Return li_Return
end function

private function integer of_processfueltax (string as_category, long al_id, date ad_min, date ad_max, string as_context);Int						li_ReturnValue = 1
String					ls_Destination
String					ls_Origin
String					ls_DateString
Date      				lda_Dates[]
String					ls_ErrorMessage
Int						li_NumDates
Long						ll_UpperBound
Date						ld_Null

Integer					li_Type
n_cst_bso_Dispatch	lnv_Dispatch
w_dataValidate 		lw_dataValidate

n_cst_beo_Itinerary2	lnv_Itinerary

n_cst_OFRError_collection lnv_ErrorCollection
n_cst_OFRError lnv_Error
n_cst_OFRError lnv_ErrorArray[]

s_Parm			lstr_Parm
n_cst_msg		lnv_msg
n_cst_msg		lnv_Range
lstr_Parm.is_Label = "DISCARDOPTIONAL"
lstr_Parm.ia_Value = FALSE
lnv_Msg.of_Add_Parm ( lstr_Parm )

Setpointer ( HOURGLASS! )
SetNull ( ld_Null )

lnv_Dispatch = create n_cst_bso_Dispatch


IF li_ReturnValue = 1 THEN
	li_Type = THIS.of_ConvertCategory ( al_id, as_category )
	IF li_Type = -1 THEN
		li_ReturnValue = -1
		ls_ErrorMessage = "An error occurred while attempting to resolve the equipment category. Processing stopped."
	END IF
END IF

IF li_ReturnValue = 1 THEN

	//Retrieve with 7 days prior to the requested start date, in addn to NeedsPrior, so that we have
	//a week's worth of prior events, in case the absolute first prior event is LocationOptional
	//and therefore can't be used as the prior event in populating the itinerary object.
	
	IF lnv_Dispatch.of_RetrieveItinerary ( li_Type, al_Id, RelativeDate ( ad_Min, -7 ), ad_Max, TRUE /*NeedsPrior*/ ) = 1 THEN
	
		//Retrieved OK
		//Filter the itinerary into the primary buffer.  Use null limits -- we want all the events retrieved.
		lnv_Dispatch.of_FilterItinerary ( li_Type, al_Id, ld_Null, ld_Null )
	
	ELSE
		li_ReturnValue = -1
		ls_ErrorMessage = "An error occured while attempting to retrieve the itinerary."
	END IF

END IF

IF li_ReturnValue = 1 THEN

	lstr_Parm.is_Label = "StartDate"
	lstr_Parm.ia_Value = ad_Min
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "EndDate"
	lstr_Parm.ia_Value = ad_Max
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ItinType"
	lstr_Parm.ia_Value = li_Type
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ItinId"
	lstr_Parm.ia_Value = al_Id
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lnv_Itinerary = CREATE n_cst_beo_Itinerary2
	
	lnv_Itinerary.of_SetDispatchManager ( lnv_Dispatch )
	lnv_Itinerary.of_SetRange ( lnv_Range )
	
	CHOOSE CASE lnv_Itinerary.of_InitTrip ( lnv_Msg )

	CASE 1  //Success
		IF lnv_Itinerary.of_GetTrip ( inv_Trip ) = 1 THEN
			//OK -- (Should be, based on InitTrip success)
		ELSE
			li_ReturnValue = -1
		END IF

	CASE ELSE   //0 = Known bad stops, -1 = Error
		li_ReturnValue = -1
		ls_ErrorMessage = "An error occured while attempting to process the trip. Processing stopped."

	END CHOOSE

END IF

lnv_itinerary.of_setDestroyTripOnDestroy ( FALSE ) 

// inform of any companies w/ bad locators
IF lnv_Msg.of_Get_Parm ( "IDS" , lstr_Parm ) <> 0 THEN
	openWithParm(w_colist, lnv_msg )
	ll_UpperBound = UpperBound ( lstr_Parm.ia_Value  )
	
	ls_ErrorMessage	="The following "+string (ll_upperBound )+ " companies do not have PC*Miler locators assigned to them. ~r~n" &
			+ "All compaines must have locators in order to prepare the report data.~r~n" &
			+ "Please verify the PC*Miler locator for each company in the company info screen."
	li_ReturnValue = -1
END IF


// if events were found w/o sites then the dates are provided to the user as means of id
IF lnv_msg.of_Get_parm ( "DATES" ,lstr_Parm ) <> 0 THEN
	
	lda_Dates = lstr_Parm.ia_Value
	li_NumDates = THIS.of_ShrinkDateArray ( lda_Dates , ls_DateString )
	ls_Errormessage = "Unspecified sites were encountered on dates:" + ls_DateString + "~r~nReports can't be generated with unspecified event locations."
	li_ReturnValue = -1
END IF

// get and format the origin
IF lnv_Msg.of_Get_Parm ( "ORIGIN" , lstr_Parm ) <> 0 THEN
	ls_Origin = lstr_Parm.ia_Value
END IF
IF isnumber ( left ( ls_Origin, 5 ) ) THEN
	ls_Origin = trim ( right ( ls_Origin, len ( ls_Origin )  - 6 ) )
ELSE
	ls_Origin = trim ( ls_Origin )
END IF
// <<*>> 8/16/05 Added the check for 'Len ( ls_Origin ) = 0'
IF isNull ( ls_Origin ) OR Len ( ls_Origin ) = 0 THEN
	ls_Origin = "NO ORIGIN"
END IF

// get and format the destination
IF lnv_Msg.of_Get_Parm ( "DESTINATION" , lstr_Parm ) <> 0 THEN
	ls_Destination = lstr_Parm.ia_Value
END IF
IF isnumber ( left ( ls_Destination, 5 ) ) THEN
	ls_Destination = trim ( right ( ls_Destination, len ( ls_Destination )  - 6 ) )
ELSE
	ls_Destination = trim ( ls_Destination )
END IF
// <<*>> 8/16/05 Added the check for 'Len ( ls_Destination ) = 0'
IF isNull ( ls_Destination ) OR Len ( ls_Destination ) = 0 THEN
	ls_Destination = "NO DESTINATION"
END IF


IF li_ReturnValue = 1 THEN
	IF of_genStateReport ( ) <> 1 THEN
		li_ReturnValue = -1
		ls_ErrorMessage = "An error occured while attempting to generate the state report. Processing stopped."
	END IF
END IF


IF li_ReturnValue = 1 THEN

	CHOOSE CASE is_Context   // message objects will be populated with the proper info depending 
											 // on the context. the message object will flow back out and be used to 
											 // open the window with the proper data
	CASE cs_context_statebreakdown
		li_ReturnValue  =  THIS.of_preTaxValidation ( lnv_msg )
	CASE cs_context_FuelTax
		li_ReturnValue  =  THIS.of_CalcAdjustments( lnv_msg )
	END CHOOSE
	
END IF


IF li_ReturnValue = 1 THEN
	of_createHeader(2,al_id,ad_min,ad_max,ids_StateReport,"State Summary Report")
	
	lstr_Parm.is_Label = "ID"
	lstr_Parm.ia_Value = al_id
	lnv_msg.of_Add_Parm ( lstr_parm )
			
	lstr_Parm.is_Label = "STARTDATE"
	lstr_Parm.ia_Value = ad_min
	lnv_msg.of_Add_Parm ( lstr_parm )
	
	lstr_Parm.is_Label = "ENDDATE"
	lstr_Parm.ia_Value = ad_max
	lnv_msg.of_Add_Parm ( lstr_parm )
	
	lstr_Parm.is_Label = "STATEREPORT"
	lstr_Parm.ia_Value = ids_statereport
	lnv_msg.of_Add_Parm ( lstr_parm )
	
	lstr_Parm.is_Label = "ORIG"
	lstr_Parm.ia_Value = ls_Origin
	lnv_msg.of_Add_Parm ( lstr_parm )
	
	lstr_Parm.is_Label = "DESTINATION"
	lstr_Parm.ia_Value = ls_Destination
	lnv_msg.of_Add_Parm ( lstr_parm )
	
	
	openwithparm(lw_dataValidate , lnv_msg )     // window is opened with the proper data here
		
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\/\\//\\//\\//

IF li_ReturnValue = -1 AND len ( ls_ErrorMessage ) > 0 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//

DESTROY lnv_Dispatch
DESTROY lnv_Itinerary

return li_ReturnValue
end function

private function integer of_shrinkdatearray (date ada_dates[], ref string as_dates);//THIS will generate a string of dates with tabs and nl. the 'elements' of the string
// will be unique . it will return -1 on error and # of ORIGINAL elements upon success

Int		i
int		j
int		li_TotalCount = -1
Boolean	lb_Found 
String	ls_DateString
date		ld_CurrentDate
date		lda_InsertedDates[]

li_TotalCount = UpperBound ( ada_dates )
FOR i = 1 to li_TotalCount
	lb_Found = FALSE
	ld_CurrentDate = ada_dates[i]
	FOR j = 1 TO upperBound ( lda_InsertedDates ) 
		IF ld_CurrentDate = lda_InsertedDates [j]	THEN
			lb_Found = TRUE
			EXIT
		END IF
	NEXT
	
	IF Not lb_Found THEN
		lda_InsertedDates [upperbound ( lda_InsertedDates ) + 1] = ld_CurrentDate
		ls_DateString += "~r~n~t" + String (  ld_CurrentDate ) 
	END IF
	
NEXT

as_dates = ls_DateString

return li_TotalCount

end function

on n_cst_bso_fueltax.create
call super::create
end on

on n_cst_bso_fueltax.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(text)(recreate=yes)<init>

//@(text)--

end event

event destructor;call super::destructor;//messageBox( "IN" , "Destroy" )

IF isValid( ids_itin_quick ) THEN
	DESTROY ids_itin_quick
//	messageBox( "1" , "Destroy" )
END IF

IF isValid ( ids_statereport ) THEN
	DESTROY ids_statereport
//	messageBox( "2" , "Destroy" )
END IF

end event

