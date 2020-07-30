$PBExportHeader$n_cst_bso_payable.sru
$PBExportComments$Payable
forward
global type n_cst_bso_payable from n_cst_bso
end type
end forward

global type n_cst_bso_payable from n_cst_bso
end type
global n_cst_bso_payable n_cst_bso_payable

type variables
private:
//for access amountas
date	id_Start, &
	id_End

dec	ic_amount, &
	ic_rate, &
	ic_quantity
		
integer ii_AmountType

long 	il_billtoId, &
	il_transactionid, &
	il_shipid,&
	il_itinid, &
	il_division

string	is_Description, &
	is_RateCodename, &
	is_Originzone, &
	is_Destinationzone
n_cst_beo_entity	inv_entity
end variables

forward prototypes
public function long of_constructdatesinmonth (date ad_begin, ref date ad_final, ref integer aia_nthday[], ref date ada_nthday[])
public function long of_calcmonthindex (date ad_start, date ad_end, integer ai_yearloop, integer ai_yearindex, ref integer ai_monthindex, boolean ab_lessthanyear)
private function long of_getfarthestpoint (n_cst_beo_itinerary2 anv_itinerary, long al_firstevent, long al_lastevent)
private function long of_processperiodic (ref n_cst_beo_transaction an_transaction, ref n_cst_beo_amounttemplate anva_periodictemplate[], ref n_cst_bso_transactionmanager anv_transactionmanager, date ad_start, date ad_end, ref long al_countao, ref n_ds ads_periodicupdates)
private function long of_intervaleveryndays (string as_interval, n_cst_beo_amounttemplate anv_periodictemplate, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, date ad_start, date ad_end, ref n_ds ads_periodicupdates)
private function long of_intervalonnthday (string as_interval, n_cst_beo_amounttemplate anv_periodictemplate, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, date ad_start, date ad_end, ref n_ds ads_periodicupdates)
public function long of_getamounttype (ref n_cst_beo_amounttype anv_amounttype, integer ai_amounttype)
public function integer of_getsurchargetypes (string as_value, ref n_cst_beo_amounttype anva_amounttype[])
public function integer of_getamounttag (string as_value, ref n_cst_beo_amounttype anva_amounttype[])
public function long of_inserterrormsg (string as_errmsg)
public function long of_processsurcharge (n_cst_beo_entity anva_entity[], ref n_cst_bso_transactionmanager anv_transactionmanager, decimal ac_surcharge, integer ai_id, ref n_cst_beo_transaction anva_transactions[])
public function long of_processshipmentpay (n_cst_beo_amounttemplate anva_template[], n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, date ad_start, date ad_end, ref n_cst_beo_transaction anv_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, ref long al_countao)
public function integer of_generateamountowed (ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, integer ai_amounttype, string as_description, ref n_cst_beo_amountowed anv_amountowed, decimal ac_amount, decimal ac_rate, decimal ac_quantity)
public function long of_getshipmentitems (n_cst_bso_dispatch anv_dispatch, n_cst_beo_shipment anv_shipbeo, string as_eventtype, string as_itemtype, ref n_cst_beo_item anva_item[])
public function long of_generateaccessamount (n_cst_bso_transactionmanager anv_transactionmanager, n_cst_beo_event anv_event)
public function long of_processaccessorial (n_cst_beo_amounttemplate anva_movetemplate[], ref n_cst_beo_transaction an_transaction, n_cst_beo_itinerary2 anv_itinerary, n_cst_beo_entity anv_entity, ref n_cst_bso_transactionmanager anv_transactionmanager, n_cst_bso_dispatch anv_dispatch, ref long al_countao, date ad_start, date ad_end)
private function long of_processmoverange (n_cst_beo_event anva_event[], ref n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, long al_firstevent, long al_lastevent, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, n_cst_beo_amounttemplate anva_movetemplate[], string as_eventtype)
private function long of_processmove (n_cst_beo_amounttemplate anva_movetemplate[], n_cst_beo_itinerary2 anv_itinerary, n_cst_beo_event anva_event[], n_cst_bso_dispatch anv_dispatch, long al_firstevent, ref long al_lastevent, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager)
public function long of_getdivision (n_cst_beo_shipment anv_ship)
public function string of_getpayfuelsurchargetype ()
public function long of_getfuelsurchargeamounttypeid (ref integer aia_id[])
protected function n_cst_beo_itinerary2 of_createitinerary (n_cst_beo_transaction an_transaction, n_cst_bso_dispatch anv_dispatch, long al_dateoffset)
protected function long of_processdayordaterange (n_cst_beo_amounttemplate anva_template[], n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, date ad_firstdate, date ad_lastdate, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, ref long al_countao)
public function long of_generate (ref n_cst_beo_transaction an_transaction, n_cst_beo_amounttemplate anva_amounttemplate[], n_cst_beo_itinerary2 anv_itinerary, n_cst_beo_entity anv_entity, ref n_cst_bso_transactionmanager anv_transactionmanager, n_cst_bso_dispatch anv_dispatch, ref long al_countao, ref n_ds ads_periodicupdates)
private function long of_addshipmentpaysplits (n_cst_beo_event anva_event[], n_cst_beo_amountowed anv_amountowed, ref n_ds ads_paysplitcache, string as_itemtype)
private function long of_processpartialmove (n_cst_beo_amounttemplate anva_movetemplate[], n_cst_beo_itinerary2 anv_itinerary, n_cst_beo_event anva_event[], n_cst_bso_dispatch anv_dispatch, long al_firstevent, ref long al_lastevent, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager)
private function long of_findstartofmove (n_cst_beo_event anv_event, ref n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, ref long al_firstrowofititinerary)
public function long of_processinteractivedayordaterange (n_cst_beo_amounttemplate anva_template[], n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, date ad_firstdate, date ad_lastdate, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, ref long al_countao)
public function long of_processleg (n_cst_beo_amounttemplate anva_legtemplate[], n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, long al_firstrow, long al_lastrow, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, ref long al_countao)
public function long of_subdividemove (ref n_cst_beo_itinerary2 anv_itinerary, n_cst_msg anv_msgoftemplates, n_cst_bso_dispatch anv_dispatch, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, n_cst_beo_entity anv_entity, ref long al_countao, boolean ab_searchprevious)
public function boolean of_excludenonintermodaltype ()
public function decimal of_getitemquantity (n_cst_beo_item anv_item, string as_ratetype)
public function long of_processpointtopoint (n_cst_beo_event anva_event[], n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, long al_origin, long al_destination, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, n_cst_beo_amounttemplate anva_template[])
protected function long of_addmoverangesplits (n_cst_beo_event anva_event[], long al_firstevent, long al_lastevent, ref n_cst_beo_amountowed anva_amountowed[], ref n_ds ads_paysplitcache)
public function any of_setratedata (n_cst_beo_amounttemplate anv_template, n_cst_beo_shipment anv_shipment, n_cst_beo_item anv_item, ref n_cst_ratedata anv_ratedata, long al_origin, long al_destination)
private subroutine of_getratedata (n_cst_beo_shipment anv_shipment, n_cst_beo_item anv_item, ref n_cst_ratedata anv_ratedata)
public function string of_getequipmentdescription (ref n_cst_beo_equipment2 anva_equipment[], string as_type)
private function integer of_separatespecialtemplates (n_cst_beo_amounttemplate anva_alltemplates[], ref n_cst_beo_amounttemplate anva_regulartemplates[], ref n_cst_beo_amounttemplate anva_specialtemplates[])
end prototypes

public function long of_constructdatesinmonth (date ad_begin, ref date ad_final, ref integer aia_nthday[], ref date ada_nthday[]);///////////////////////////////////////////////////////////////////////////////
//
//  No longer needed!!
//
//	Function:  of_ConstructDatesInMonth
//  
//	Access:  public
//
//	Arguments:
//			ad_begin by value, input
//			ad_final by reference, output
//			aia_NthDay[] by reference, input
//			ada_NthDay[] by reference, output
//
//
//	Return:		ll_Return    
//					Results are actually returned in the
//  ada_NthDay, an array of dates for this month
//  and in ada_final which is the last date of this month 
//      such as 9/30/02 or 10/31/03.
//
//	Description:
//			for n_cst_bso_payable

//
// Written by: J. Albert
// 		Date: 10.04.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
date	ld_FirstDateOfMonth, &
		ld_LastDateOfMonth, &
		lda_NthDay[]

integer	li_firstdayofMonth, &
			li_LastDayOfMonth
			
long ll_Return, &
		ll_DayCounter, &
		ll_DayCounterMax
		
n_cst_datetime lnv_date		

ll_Return = 0		
ll_DayCounterMax = upperbound(aia_NthDay)
IF IsNull(ll_DayCounterMax) OR IsNull(ad_begin) THEN ll_Return = -1
IF ll_Return = 0 THEN
	ll_DayCounter =1
	ld_FirstDateOfMonth = lnv_date.of_firstDayOfMonth(ad_begin)
	ld_LastDateOfMonth = lnv_date.of_LastDayOfMonth(ad_begin)
	li_lastdayofMonth = day(ld_lastdateofMonth)

	FOR ll_DayCounter = 1 TO ll_DayCounterMax
		IF aia_NthDay[ll_DayCounter] >= li_lastdayofMonth  THEN
			lda_NthDay[ll_DayCounter] = ld_LastDateOfMonth
		ELSE
			lda_NthDay[ll_DayCounter] = RelativeDate(ld_FirstDateOfMonth, (aia_NthDay[ll_Daycounter] -1))
		END IF		
	NEXT
	ad_final = ld_LastDateOfMonth
	ada_NthDay = lda_NthDay
END IF
Return ll_Return
end function

public function long of_calcmonthindex (date ad_start, date ad_end, integer ai_yearloop, integer ai_yearindex, ref integer ai_monthindex, boolean ab_lessthanyear);///////////////////////////////////////////////////////////////////////////////
//
//  No longer needed!!!!
//
//	Function:  of_CalcMonthIndex
//  
//	Access:  public
//
//	Arguments:
//			ad_start by value, input
//			ad_end by value, input
//			ai_yearloop by value, input
//			ai_yearindex by value, input
//			ai_monthindex by reference, output
//			ab_lessthanyear by value, input

//	Return:		ll_Return    
//					Results are actually returned in the
//  ai_monthindex loop terminator.
//  
//
//	Description:
//			for n_cst_bso_payable
//  Calculates number of months between start and end dates.  They might be
//    in the same year
//    in different years (spanning one or more years)
//
//     
//
// Written by: J. Albert
// 		Date: 10.04.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

integer li_MonthIndex

long ll_Return

If (ab_LessThanYear = TRUE) THEN
	li_MonthIndex = (month(ad_end) - month(ad_start) + 1)
	IF ( IsNull(li_MonthIndex)) OR (li_MonthIndex < 1) THEN
		ll_Return = -1
	END IF
ELSE  // the start and end dates span at least one year
	IF (ai_YearLoop = ai_YearIndex) THEN  // we've looped thru the full years
		// set up for the last partial year
		li_MonthIndex = month(ad_end)
	ELSE  // set up to loop thru a full year of 12 months
		li_MonthIndex = 12  
	END IF
END IF

IF ll_Return <> -1 THEN
	ai_MonthIndex = li_MonthIndex
END IF
Return ll_Return
end function

private function long of_getfarthestpoint (n_cst_beo_itinerary2 anv_itinerary, long al_firstevent, long al_lastevent);///////////////////////////////////////////////////////////////////////////////
//   
//  No longer needed! 11/27/02
//
//	Function:  of_GetFarthestPoint
//  
//	Access:  private
//
//	Arguments: 
//					
//					anv_itinerary
//					al_firstevent
//					al_lastevent
//
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for n_cst_bso_payable
//  Given an itinerary 
//  
//
// Written by: N. LeBlanc & J. Albert
// 		Date: 10.11.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

long	ll_Farthest, &
		ll_Row
		
decimal	lc_Miles, &
			lc_HoldMiles

n_cst_msg	lnv_Range
s_parm		lstr_Parm

FOR ll_Row = al_FirstEvent + 1 TO al_LastEvent
	
	lnv_Range.of_Reset ( )

	lstr_Parm.is_Label = "StartRow"
	lstr_Parm.ia_Value = al_FirstEvent
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "EndRow"
	lstr_Parm.ia_Value = ll_Row
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ItinType"
	lstr_Parm.ia_Value = anv_Itinerary.of_GetItinType()
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ItinId"
	lstr_Parm.ia_Value = il_ItinId
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	anv_Itinerary.of_SetRange ( lnv_Range )

	lc_Miles = anv_Itinerary.of_GetTotalMiles()
	if lc_Miles > lc_HoldMiles then
		lc_HoldMiles = lc_Miles
		ll_Farthest = ll_Row
	end if
	
NEXT

return ll_Farthest

end function

private function long of_processperiodic (ref n_cst_beo_transaction an_transaction, ref n_cst_beo_amounttemplate anva_periodictemplate[], ref n_cst_bso_transactionmanager anv_transactionmanager, date ad_start, date ad_end, ref long al_countao, ref n_ds ads_periodicupdates);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ProcessPeriodic
//  
//	Access:  public
//
//	Arguments: 
//					an_transaction by reference, output
//					anva_periodictemplate[] by reference, input
//					anv_transactionmanager by reference, input
//					ad_start, input
//					ad_end, input
//					al_CountAO by reference, output - count of amount oweds generated
//					ads_PeriodicUpdates, output by reference
//
//	Return:		ll_Return    
//					Results are actually stored in an_transaction. 
//						This is one row in the transaction table; 
//						one row for each truck driver
//						
//
//	Description:
//			for n_cst_bso_payable
// 
// Takes the arrary of periodic templates and loops thru them.
//	(initiate equivalent of the amount template loop processing)
//
//	Perform filtering of periodic amount templates passed in as arg.
//	Use only those that fall in the event range.  
//
// Separate into interval types: 1 or 2
// 1 means the value in interval is n, where this processing should occur 
//   every n days.  (7 days, 14 days, etc)
// 2 means the value in interval is potentially a list of days of the month
//   on which to process.  7th, 15th, 31st,  Processing should occur on the 7th,
//   15th, and 31th.  However, some months do not have 31 days, so we assume the
//   processing should occur on the last day of the month if the month has fewer than
//   31 days.
// Call generation for amount oweds based on interval type.
//	The results will be stored in the transaction object
//
//  This routine is designed to have error messages in the range of 400-499 for
//  information errors and 10400-10499 for severe errors.  Severe errors cause 
//  the transaction generation to fail for this entity.
//
// Written by: J. Albert
// 		Date: 09.25.02
//		Version:  1.0, initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
boolean lb_ContinueProcess  // If true, continue processing this periodic 
			// amount template. If false, do not generate a settlement for
			// this periodic amount template.

date	ld_activationdate
		
decimal lc_totalremaining, &  
		lc_tartotal, &    
		lc_runtotal      // running total

integer li_intervaltype

string ls_interval, &
		ls_ErrMsg, &
		ls_TemplateName
		 
long 	ll_Return, &
		ll_Counter, &
		ll_Index, &
		lla_TemplateId[], &
		lla_TemplateStatus[], & 
		ll_CountAO
		
n_cst_datetime		lnv_date
n_cst_string	lnv_string

n_cst_OFRError	lnva_Error[], &
				lnv_Error
				
ll_Counter = upperbound(anva_periodictemplate[])

FOR ll_Index = 1 TO ll_Counter
	lla_TemplateId[ll_Index] = anva_periodictemplate[ll_Index].of_GetId()
	lla_TemplateStatus[ll_Index] = 1
NEXT

//  Examine all templates and decide
//  if they meet the criteria which allows them to be 
//  generated.  Call generation routine once for each template
//  that meets these criteria.

FOR ll_Index = 1 TO ll_Counter
		ls_TemplateName =trim(anva_periodictemplate[ll_index].of_GetName())
		lb_ContinueProcess = TRUE	// reset for each template to allow processing

	   ld_activationdate = anva_periodictemplate[ll_Index].of_getactivationdate() 
		IF IsNull(ld_activationDate) THEN
			lb_ContinueProcess = FALSE
			ls_ErrMsg = "10403|This template, " + ls_templateName + ", is missing an activation date;" + &
			" therefore, it can not be processed in autogen."
			this.of_InsertErrorMsg(ls_ErrMsg)
			ll_Return = -1
		END IF		

	
	IF lb_ContinueProcess = TRUE THEN
		li_intervaltype = anva_periodictemplate[ll_Index].of_GetIntervalType()
		ls_interval = anva_periodictemplate[ll_Index].of_GetInterval()
		CHOOSE CASE li_intervaltype
			CASE 1  //  The periodic processing should occur every n days
				ll_Return = this.of_IntervalEveryNDays(ls_interval, anva_periodictemplate[ll_Index], &
					an_transaction, anv_transactionmanager, ad_start, ad_end, ads_PeriodicUpdates)
				IF ll_Return = -1 THEN 
					lb_ContinueProcess = FALSE
				ELSE
					ll_CountAO = ll_CountAO + ll_Return
				END IF
			CASE 2  // The periodic processing should occur on the nth day(s) 
				ll_Return = this.of_IntervalOnNthDay(ls_interval, anva_periodictemplate[ll_Index], &
						an_transaction, anv_transactionmanager, ad_start, ad_end, ads_PeriodicUpdates)
				IF ll_Return = -1 THEN 
					lb_ContinueProcess = FALSE
				ELSE
					ll_CountAO = ll_CountAO + ll_Return
				END IF
			CASE ELSE  
				lb_ContinueProcess = FALSE		
				ls_ErrMsg = "10433|The interval type for template " + ls_templateName +	" is not correct."
				this.of_InsertErrorMsg(ls_ErrMsg)
				ll_Return = -1
			END CHOOSE // periodic templates must have an interval type of 1 or 2 to be processed.
	END IF // get interval type and interval & did generate amount oweds
	IF lb_ContinueProcess = FALSE THEN
		EXIT
	END IF
NEXT	// end of major  loop
//IF ll_Return < 0 THEN
//	IF len(ls_ErrMsg) > 0 THEN
//		lnv_Error = This.AddOFRError()
//		IF IsValid(lnv_Error) THEN
//			lnv_Error.SetErrorMessage(ls_ErrMsg)
//		END IF
//	END IF
//END IF
al_CountAO = ll_CountAO  // pass back count of amount oweds generated
RETURN ll_Return
end function

private function long of_intervaleveryndays (string as_interval, n_cst_beo_amounttemplate anv_periodictemplate, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, date ad_start, date ad_end, ref n_ds ads_periodicupdates);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_IntervalEveryNDays
//  
//				Interval every 'N' days  
//
//	Access:  private
//
//	Arguments: 
//					as_interval				
//					anv_periodictemplate by value 
//					an_transaction by reference
//					anv_transactionmanager by reference
//					ad_start			
//					ad_end		
//					ads_periodicupdates by reference 
//
//	Return:		ll_Return    
//     Results are actually stored in an amount owed. 
//
//	Description:
//			for n_cst_bso_payable
//  Takes on periodic template and produces 0, 1, or more 
//  amount owed(s) on the transaction object for that periodic
//  template.
//  
//  amounttemplate.intervaltype = 1 and
//  amounttemplate.interval contains a string that will 
//  convert to an integer.  This interger specifies that
//  the periodic processing is to occur every n days
//  of the month. For example '7', this periodic processing
//  would occur every seven days, that is once per week.
//
//  Normally, the amounttemplate.activation date is the initial date on 
//  which to start.  However, this date may be changed to a date
//  in the future if the user wishes to suspend the amounttemplate
//  generation.  A suspended amount template has a valid date
//  amounttemplate.lastdate.  A new, never run periodic amount template
//  does not have a valid date in amounttemplate.lastdate.
//  
//  Suspended periodic deductions produce $0.00 amount oweds for 
//  the days a deduction would normally have been taken.
//
//  amounttemplate.interval causes processing to
//  cycle every 'n' days from the original activation date.
//
// At this time only one error messasge is returned.  If you wish
// to return more than one, change the logic.
// All errors should be created between  00500-00599 for informational errors
// or 10500-10599 for severe errors.
//
// Written by: J. Albert
// 		Date: 10.01.02
//		Version:  1.0, initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
// 	MFS 5/17/07 - Added start/end date (as lastdate) to amountowed.
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
boolean	lb_AimForTargetTotal, &
			lb_Suspended, &
			lb_NullLastDate, &
			lb_ContinueProcess // If true, continue processing; if false, don't

date		ld_ActivationDate, &
			ld_PossDate, &
			ld_LastDate, &
			ld_BaseDate, &
			ld_CheckDate, &
			lda_PotentialDate[]	, &
			ld_currentfirst
			
			
decimal	lc_totalremaining, &
			lc_runtotal, &
			lc_targettotal, &
			lc_excessamount, &
			lc_StoredAmount, &  
			lc_Amount, &
			lc_Quantity, &
			lc_Rate
			
integer	li_everynday
		

long 	ll_Return, &
		ll_AmountCounter, &
		ll_Counter, &
		ll_Index, &
		ll_IndexMax, &
		ll_RunCount, &
		ll_AmountTemplateId, &
		ll_Transactionid, &
		ll_Row
		
string ls_Amount, &
		ls_ErrMsg, &
		ls_TemplateName

n_ds	lds_PeriodicUpdates

n_cst_beo_AmountOwed	lnv_AmountOwed, &
							lnva_Amounts[], &
							lnv_NullAmountOwed
							
n_cst_beo_AmountTemplate lnv_periodictemplate

n_cst_beo_Transaction	lnv_NullTransaction
n_cst_OFRError	lnv_Error
lds_PeriodicUpdates = ads_PeriodicUpdates
IF NOT IsValid(lds_PeriodicUpdates) THEN
	lds_PeriodicUpdates = CREATE n_ds
	lds_PeriodicUpdates.DataObject = "d_PeriodicSubset"
END IF 
lnv_periodictemplate = anv_periodictemplate
IF IsValid(An_Transaction) THEN //  needed later when modifying the lnv_NullTransaction
	ll_Transactionid = an_Transaction.of_GetId()
END If
lb_ContinueProcess = TRUE
lb_AimForTargetTotal = FALSE
ls_TemplateName = trim(lnv_periodictemplate.of_GetName())
// get the amount string, put it into a decimal, 
ls_Amount = lnv_periodictemplate.of_GetAmount()
IF IsNull(ls_Amount) THEN  // you must have an amount to autogen
	lb_ContinueProcess = FALSE
	ls_ErrMsg = "10505|Template " + ls_TemplateName + ", is missing an amount." + &
		"  Periodic deductions must have an amount to autogen."
	this.of_InsertErrorMsg(ls_ErrMsg)		
	ll_Return = -1
ELSE
	lc_StoredAmount = round(Dec(ls_Amount),2)
END IF


IF (lb_ContinueProcess = TRUE) THEN
	// the quantity and rate value from the amount template
	// should ALWAYS be null or zero on a periodic template. 

	lc_Quantity = 0
	lc_Rate = 0
	li_everynday = integer(as_interval)

// Either get the last date the periodic was taken, or if it was never taken get 
//  the activation date.  amounttemplate.lastdate, amounttemplate.activationdate
	ld_lastdate = lnv_periodictemplate.of_GetLastDate()
	ld_ActivationDate = 	lnv_periodictemplate.of_GetActivationDate()

	lb_NullLastDAte = IsNull(ld_lastDate)
	IF lb_NullLastDate = TRUE THEN
		IF IsNull(ld_activationdate) THEN
			lb_ContinueProcess = FALSE	
			ls_ErrMsg = "10511|Template "+ls_templateName + &
			", is missing the activation date.  Periodic deductions " + &
			"must have an activation date to autogen."
			this.of_InsertErrorMsg(ls_ErrMsg)
			ll_Return = -1
		END IF
	END IF
END IF

IF (lb_ContinueProcess = TRUE) THEN

END IF
	
// Don't allow reprocessing of periodics; therefore, be sure this possible
// date is after the earlier date (earlier date = activation date or last date)
IF (lb_ContinueProcess = TRUE) THEN	
	If lb_NullLastDAte = TRUE THEN
		ld_checkdate = ld_ActivationDate
	ELSE
		ld_checkdate = ld_LastDate
	END IF
	// put us close just at or past the start date
	DO WHILE ld_Checkdate < ad_start
		ld_Checkdate = RelativeDate(ld_CheckDate, li_EveryNDay)
	LOOP
	// Calculate a base date for the date generation code: ll_possdate = .....
	CHOOSE CASE ld_Checkdate
		CASE   ld_LastDAte
			ld_baseDate = ld_LastDate
		CASE  ld_ActivationDate
			ld_BaseDate = ld_ActivationDate
		CASE ad_start
			ld_BaseDAte = ad_start
		CASE ELSE
			ld_BaseDate = RelativeDate(ld_CheckDate, - (li_EveryNDay))
	END CHOOSE
	
	ll_AmountTemplateId = lnv_periodictemplate.of_GetId()
	ld_PossDate = ld_BaseDate
	ll_Index = 1
	DO WHILE ld_PossDate <= ad_End
		IF (ld_PossDate >= ad_Start)  THEN
			IF (ld_PossDate > ld_LastDate) &
			OR ((ld_PossDate >= ld_ActivationDate) AND (lb_NullLastDate = TRUE)) THEN
					lda_PotentialDate[ll_Index] = ld_possdate
					ll_Index ++	
			END IF 		
		END IF
		ld_possDate = RelativeDate(ld_PossDate, li_EveryNDay)			
	LOOP

	ll_IndexMax = upperbound(lda_PotentialDate)
	IF ll_IndexMax < 1 THEN // empty date array - no dates to process
		lb_ContinueProcess = FALSE
	END IF 
END IF

IF (lb_ContinueProcess = TRUE) THEN	
	lc_targettotal = lnv_periodictemplate.of_GetTargetTotal()
// Some times we can't exceed a target total, other times we
// autogen the amount owed (such as an ongoing deduction)
// for the duration of the employment of the truck driver.
	IF NOT IsNull(lc_targettotal) THEN
		IF lc_targettotal <> 0 THEN
			lb_AimForTargetTotal = TRUE
		END IF
	END IF
END IF


IF (lb_ContinueProcess = TRUE) THEN				
	IF ((lda_PotentialDate[1] < ld_ActivationDate)  AND (lb_NullLastDate = FALSE)) THEN
		lb_Suspended = TRUE  // This flag is CRITICAL to processing! 
		// And we need if inside the following FOR LOOP on the first pass.
	END IF
	FOR ll_Index = 1 to ll_IndexMax	
	IF lb_ContinueProcess = TRUE THEN

	// what's the target total? Was it an actual target total? 
	// Have we exceeded or reached it?  Don't process if reached or exceeded.
	// We have to check the running total twice, the running total that we create during 
	// this pass and the running total that we created on the last pass.
		lc_runtotal = lnv_periodictemplate.of_GetRunningTotal ()
		IF IsNull(lc_runtotal) THEN  
			lc_runtotal = 0
		END IF
		ll_runcount = lnv_periodictemplate.of_GetRunningCount ()
		IF IsNull(ll_runcount) THEN 
			ll_runcount = 0
		END IF 
		
		IF ((lc_runtotal < lc_targettotal) AND (lb_AimForTargetTotal = TRUE)) &
			OR IsNull(lc_targettotal) OR (lc_targettotal = 0) &
			OR (lb_Suspended = TRUE) THEN // checking last pass running total.
		   // create amount owed and update running total
			IF ((lda_PotentialDate[ll_Index] < ld_ActivationDate) &
			AND (lb_NullLastDate = FALSE)) THEN
				lc_amount = 0  // this is for the suspended ones with an
							// activation date in the future
				lb_Suspended = TRUE
			ELSE
				lc_amount = lc_storedamount  // this is for those not suspended 
						// AND those that were suspended earlier in this run but 
						// will now be generated because they have now reached or
						// passed the activation date.
				lb_Suspended = FALSE
			END IF
 
			ll_Return = anv_transactionmanager.of_CreateAmountOwed(lnv_periodictemplate, lnv_NullTransaction, &
				lnv_AmountOwed, lc_amount, lc_quantity, lc_rate, lb_Suspended)

			IF ll_Return < 0 THEN
				ls_ErrMsg = "10531|Autogen is unable to create an amount owed for template " + &
					ls_TemplateName+ "."
				this.of_InsertErrorMsg(ls_ErrMsg)
				lb_ContinueProcess = FALSE
				CONTINUE
			END IF
			lc_amount = abs(lc_amount)
			lc_runtotal = lc_runtotal + lc_amount
			IF (lc_runtotal = lc_targettotal) AND (lb_AimForTargetTotal = TRUE) THEN
				// we hit the valid target 
				// total, don't process next time, don't do fix up this time,
				IF (lb_Suspended = TRUE) THEN  
					// if it's suspended keep going 
					// and create a zero amount owed!
				ELSE
					lb_ContinueProcess = FALSE
				END IF
			END IF  // new running total = valid target total
			
			IF (lb_Suspended = TRUE) THEN  // ok, if we hit or passed the activation date this
				// is no longer suspended; therefore, on the next pass we'll generate accurate 
				// nonzero, amount oweds.			
				IF (lda_PotentialDate[ll_Index] >= ld_ActivationDate) THEN
					lb_Suspended = FALSE  
				END IF
			END IF
 
			IF (lc_runtotal > lc_targettotal) AND (lb_AimForTargetTotal = TRUE) THEN // remove excess taken, 
			// don't process next time
				lc_excessamount = lc_runtotal - lc_targettotal
				lc_amount = lc_amount - lc_excessamount
				lnv_AmountOwed.of_SetAmount(lc_amount)			
				lc_runtotal = lc_targettotal
				lb_ContinueProcess = FALSE				
			END IF // new running total > valid target total
			
			If IsValid(lnv_AmountOwed) THEN
				IF NOT IsNull(ll_Transactionid) THEN
					lnv_AmountOwed.of_SetFKTransaction_Direct(ll_Transactionid)
				END IF
				
				//MFS 5/17/07 - record start/end date
				lnv_Amountowed.of_SetStartDate(lda_potentialdate[ll_Index])
				lnv_AmountOwed.of_SetEndDate(lda_potentialdate[ll_Index])
				
				ll_AmountCounter ++				
				lnva_Amounts[ll_AmountCounter] = lnv_AmountOwed	
				//nl
				destroy lnv_AmountOwed
//				lnv_AmountOwed = lnv_NullAmountOwed /* late addition */
			END IF	
			lnv_periodictemplate.of_SetLastDate(lda_potentialdate[ll_Index])
			ld_currentfirst = lnv_periodictemplate.of_GetFirstDate()
			IF IsNull(ld_currentfirst) THEN
				lnv_periodictemplate.of_SetFirstDate(lda_potentialdate[ll_Index])
			END IF
			lnv_periodictemplate.of_SetLastAmount(lc_amount)
			lnv_periodictemplate.of_SetRunningTotal(lc_runtotal)
			ll_runcount ++				
			lnv_periodictemplate.of_SetRunningCount(ll_runcount)						
		ELSE // examines last pass, we had a valid target total and running total  
			// is more than or equal to the maximum target total that was allowed, 
			// didn't do periodic processing this pass.
		lb_ContinueProcess = FALSE
		END IF

	END IF  // yes, it could be cleaner - but logic changed late in coding.
	NEXT
END IF // outer if (outside for loop)

IF IsValid(an_Transaction) THEN
	an_transaction.of_Calculate()
END IF

IF Upperbound(lnva_amounts) > 0 THEN
// Put values from amount template into the ads_PeriodicUpdates
// so that the wf_setuptoautogen can decide if the amount template
// should be updated or not - (we don't update the amount template
// if ANY of the amount oweds for this transaction count not
// be created.)

	ll_Row = lds_PeriodicUpdates.InsertRow(0)
////	Choose case messagebox("Interval Every N Days", "jma, Value in  ll_Row = "  + string(ll_row), &
////	Exclamation!, OK!)
////		CASE 1 
////		CASE 2
////	END CHOOSE
//
	IF ll_Row > 0 THEN
				lds_PeriodicUpdates.object.id[ll_row] = ll_AmounttemplateId
//	Choose case messagebox("Interval Every N Days", "jma, Value in  ll_Amounttemplateid = "  + &
//			 string(ll_AmounttemplateId ), &
//	Exclamation!, OK!)
//		CASE 1 
//		CASE 2
//	END CHOOSE
				IF ll_Index > ll_IndexMax THEN
					ll_Index = ll_IndexMax
				END IF
				lds_PeriodicUpdates.object.lastdate[ll_Row] = lda_potentialdate[ll_index]
				ld_currentfirst = lnv_periodictemplate.of_GetFirstDate()
				IF IsNull(ld_currentfirst) THEN
					lds_PeriodicUpdates.object.firstdate[ll_Row] = lda_potentialdate[ll_Index]
				else
					//nl
					lds_PeriodicUpdates.object.firstdate[ll_Row] = ld_currentfirst
				END IF
				lds_PeriodicUpdates.object.lastAmount[ll_Row] = lc_amount
				lds_PeriodicUpdates.object.RunningTotal[ll_Row] = lc_runtotal			
				lds_PeriodicUpdates.object.RunningCount[ll_Row] = ll_runcount 
	ELSE
		ls_ErrMsg = "10585|Autogen was not able to place the updated periodic" + &
		" information into PeriodicUpdates for template " + ls_templateName + "."
		this.of_InsertErrorMsg(ls_ErrMsg)
	END IF
END IF // we created at least one amount owed
	
// Pass back -1 if failed early 

ads_PeriodicUpdates = lds_PeriodicUpdates

If ll_Return < 0 THEN

ELSE
	ll_Return = ll_AmountCounter
END IF
ll_AmountCounter = upperbound(lnva_amounts)
FOR ll_index = 1 TO ll_AmountCounter
	IF IsValid(lnva_amounts[ll_index]) THEN
		//nl
		destroy lnva_amounts[ll_index]
//		 lnva_amounts[ll_index] = lnv_NullAmountOwed
	END IF
NEXT
RETURN ll_Return
///
end function

private function long of_intervalonnthday (string as_interval, n_cst_beo_amounttemplate anv_periodictemplate, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, date ad_start, date ad_end, ref n_ds ads_periodicupdates);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_IntervalOnNthDay
//  
//	Access:  private
//
//	Arguments: 
//					as_interval		by value, input
//					anv_periodictemplate by value 
//					an_transaction by reference
//					anv_transactionmanager by reference
//					ad_start			input
//					ad_end			input
//					ads_PeriodicUpdates output by reference
//
//					
//
//					
//
//	Return:		ll_Return    
//					Results are actually stored in an amount owed. 
//	
//						
//
//	Description:
//			for n_cst_bso_payable
//	of_IntervalOnNthDay - amounttemplate.intervaltype = 2 and
//	amounttemplate.interval contains a string that will 
// convert to an array of days.  This array specifies that
// the periodic processing is to occur on the nth day(s)
// of the month. For example '7,15, 31'. 
//       
//			
// Error messages added in this routine should be in the 600-699 range
// for informational messages and 10600-10699 range for severe 
// errors.
//
// Written by: J. Albert
// 		Date: 10.01.02
//		Version:  1.0, initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//		MFS 5/17/07 - Added start/end date to amountowed.
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

boolean  lb_AimForTargetTotal = FALSE, &
			lb_ContinueProcess = FALSE, &
			lb_Suspended = FALSE, &
			lb_keepChecking = TRUE, &
			lb_AtLastDayMonth = FALSE, &
			lb_NullLastDate = FALSE

date	ld_start, &
		ld_end, &
		ld_ActivationDate, &
		lda_DatesToGen[], &
		ld_PossDay, &
		ld_StartOfMonth, &
		ld_BaseDay, &
		ld_EndOfMonth, &
		ld_LastDate, &
		ld_currentfirst


decimal	lc_RunTotal, &
			lc_TargetTotal, &
			lc_StoredAmount, &
			lc_Amount, &
			lc_Quantity, &
			lc_Rate, &
			lc_ExcessAmount
		
		
integer lia_NthDay[], &
			li_MonthNbr


long 	ll_Return, &
		ll_numberofdays, &
		ll_DayCounter, &
		ll_TotalCounter, &
		ll_TotalDays, &
		ll_Counter, &
		ll_Index, &
		ll_RowNumber, &
		ll_RunCount, &
		ll_TransactionId, &
		ll_AmountCounter, &
		ll_MaxDayMonth, &
		ll_Row, &
		ll_AmounttemplateId
//		ll_DaysDiffEndAct


string	ls_amount, &
			lsa_NthDay[], &
			ls_ErrMsg, &
			ls_TemplateName

n_cst_beo_AmountOwed	lnv_AmountOwed, &
							lnva_Amounts[], &
							lnv_NullAmountOwed

n_cst_beo_AmountTemplate lnv_periodicTemplate

n_cst_beo_Transaction	lnv_NullTransaction

n_cst_datetime	lnv_date

n_cst_string	lnv_string

n_cst_OFRError	lnv_Error, &
				lnva_Errors[]
				
n_ds				lds_NthDay, &
				lds_PeriodicUpdates

lds_PeriodicUpdates = ads_PeriodicUpdates
IF NOT IsValid(lds_PeriodicUpdates) THEN
	lds_PeriodicUpdates = CREATE n_ds
	lds_PeriodicUpdates.DataObject = "d_PeriodicSubset"
END IF
lnv_PeriodicTemplate = anv_PeriodicTemplate
IF IsValid(An_Transaction) THEN
	ll_TransactionId = an_Transaction.of_GetId()
END IF
lb_ContinueProcess = TRUE
lb_AimForTargetTotal = FALSE
ls_TemplateName = trim(lnv_periodicTemplate.of_GetName())
ll_AmountTemplateId = lnv_periodicTemplate.of_GetID()
lds_NthDay = CREATE n_ds
lds_NthDay.DataObject = "d_Interval"
lds_NthDay.Reset()
// Take the interval string passed in. 
IF( IsNull(as_interval) = TRUE) THEN
	ls_ErrMSG = "10603|Template " + ls_TemplateName + ", is missing the list" + &
		" of dates needed to autogen a periodic deduction."
	this.of_InsertErrorMsg(ls_ErrMsg)		
	lb_ContinueProcess = FALSE
	ll_Return = -1
END IF
IF lb_ContinueProcess = TRUE THEN
	ll_NumberOfDays = lnv_string.of_ParseToArray(as_interval, ',', lsa_NthDay[])
	FOR ll_DayCounter = 1 TO ll_NumberOfDays
		IF IsNumber(lsa_NthDay[ll_DayCounter]) = TRUE THEN
			lia_NthDay[ll_DayCounter] = integer(lsa_NthDay[ll_DayCounter])
			ll_RowNumber = lds_NthDay.InsertRow(0)
			IF ll_RowNumber > 0 THEN
				lds_NthDay.object.interval[ll_RowNumber] = lia_NthDay[ll_DayCounter]
			ELSE
				ll_Return = -1
				ls_ErrMsg = "10607|Template " + ls_TemplateName + ", can not be converted" + &
				" and inserted into a structure needed to autogen a periodic deduction."
				this.of_InsertErrorMsg(ls_ErrMsg)				
				lb_ContinueProcess = FALSE	
			END IF
		ELSE
			ll_Return = -1
			ls_ErrMsg = "10609|Template " + ls_TemplateName + ", has values in the" + &
				" interval list that are not numbers. The interval list should have numbers" + &
				" that represent the dates in a month separated by a comma."
			this.of_InsertErrorMsg(ls_ErrMsg)				
			lb_ContinueProcess = FALSE				
		END IF
NEXT
END IF
IF lb_ContinueProcess = TRUE THEN
	ll_Return = lds_NthDay.Sort()
	IF ll_Return > 0 THEN
		FOR ll_DayCounter = 1 to ll_NumberOfDays  // take days out of datastore
			// and put them back into the array, but now they're sorted.
			lia_NthDay[ll_DayCounter] = lds_NthDay.object.interval[ll_DayCounter]
		NEXT 
	ELSE
		ll_Return = -1
		ls_ErrMsg = "10611|The list of dates for template " + ls_TemplateName + &
		", can not be sorted in ascending order."
		this.of_InsertErrorMsg(ls_ErrMsg)		
		lb_ContinueProcess = FALSE
	END IF
END IF

IF upperbound(lia_NthDay) = 0 THEN lb_ContinueProcess = FALSE

// Has an amount owed ever been generated using this periodic template?
// If so, it was recorded in amounttemplate.lastdate.???
IF lb_ContinueProcess = TRUE THEN
// Do we have an amount?
	ls_Amount = lnv_periodicTemplate.of_GetAmount()
	IF IsNull (ls_Amount) THEN
		ll_Return = -1
		ls_ErrMsg = "10613|Template " + ls_TemplateName + &
		", is missing an amount.  Periodic deductions need to " + &
		" have an amount to be settled in autogen."
		this.of_InsertErrorMsg(ls_ErrMsg)		
		lb_ContinueProcess = FALSE		
	ELSE  //keep amount; we might have to modify an amountowed if
		// it went over the target total
		lc_StoredAMount = Round(Dec(ls_Amount),2)
	END IF
END IF

IF (lb_ContinueProcess = TRUE) THEN  // we won't use quantity or rate

	lc_Quantity = 0
	lc_Rate =  0
	// Do we have a actual target total? 
	lc_TargetTotal = lnv_PeriodicTemplate.of_GetTargetTotal()
	IF NOT IsNull(lc_TargetTotal) OR (lc_TargetTotal <> 0) THEN
		lb_AimForTargetTotal = TRUE
	END IF
	lc_RunTotal = lnv_periodicTemplate.of_GetRunningTotal()
	IF IsNull(lc_RunTotal) THEN
		lc_RunTotal = 0
	END IF
	ll_RunCount = lnv_periodicTemplate.of_GetRunningCount()
	IF IsNUll(ll_RunCount) THEN
		ll_RunCount = 0
	END IF
END IF 
// 

// We must have a valid activation date.
// If the amounttemplate has not been autogenned previously, 
// the activation date must preceed the end date.
IF (lb_ContinueProcess = TRUE) THEN
	ld_lastdate =  lnv_PeriodicTemplate.of_GetLastDate()
	lb_NullLastDate = IsNull(ld_LastDate)
	ld_ActivationDate = lnv_PeriodicTemplate.of_GetActivationDate()
	IF lb_NullLastDate = TRUE THEN
		IF IsNull(ld_ActivationDate) THEN
			lb_ContinueProcess = FALSE
			ls_ErrMsg = "10615|Template "+ls_templateName + &
			", is missing the date of activation.  All periodic" + &
			" deductions must have an activation date to autogen."
			this.of_InsertErrorMsg(ls_ErrMsg)
			ll_Return = -1
//		ELSE
//			ld_CheckDate = ld_ActivationDate
		END IF
//	ELSE
//		ld_checkDate = ld_LastDate
	END IF

	
END IF
IF lb_ContinueProcess = TRUE THEN
// set up the array containing the dates to generate, lda_DatesToGen
	ll_TotalDays = upperbound(lia_NthDay)
	ll_Counter = 1
	ll_Index = 1
	ld_BaseDay = lnv_date.of_firstDayOfMonth(ad_start)
	ld_EndOfMonth = lnv_date.of_LastDayOfMonth(ld_BaseDay)
	ll_MaxDayMonth = Day(ld_EndOfMonth)
	Do While lb_KeepChecking
		IF lia_NthDay[ll_Counter] >= ll_MaxDayMonth THEN
			ld_PossDay =  ld_EndOfMonth
			lb_AtLastDayMonth = TRUE
		ELSE
			ld_PossDay = RelativeDate(ld_BaseDay, (lia_NthDay[ll_Counter] -1 ))		
		END IF		

		IF ld_PossDay >= ad_Start THEN
			IF ld_PossDay > ad_End THEN

				EXIT  // leave while loop
			ELSE
				IF ((ld_PossDay > ld_LastDate) AND (lb_NullLastDate = FALSE)) &
				OR ((ld_PossDay >= ld_ActivationDate) AND (lb_NullLASTDate = TRUE)) THEN		
					lda_DatesToGen[ll_Index] = ld_PossDay
					ll_Index ++
				END IF // ld_PossDay >= activation day or ld_PossDay > last run day.
			END IF // ld_PossDay > end date 
		END IF // ld_PossDay >= start date
		ll_Counter ++
	// Reset ll_Counter to start looping thru days again if we've reached end of month
		IF (ll_Counter > ll_TotalDays)  OR (lb_AtLastDayMonth = TRUE) THEN
			ld_PossDay = lnv_date.of_LastDayOfMonth(ld_PossDay) 
			ld_BaseDay = RelativeDate(ld_PossDay,1)  // create a base day in the next month
			ld_EndOfMonth = lnv_date.of_LastDayOfMonth(ld_BaseDay)
			ll_MaxDayMonth = Day(ld_EndOfMonth)		
			ll_Counter = 1
			lb_AtLastDayMonth = FALSE
		END IF 
	Loop
END IF 


IF lb_ContinueProcess = TRUE THEN
	ll_TotalDays = upperbound(lda_DatesToGen)
	IF ll_TotalDays > 0 THEN
		IF ((lda_DatesToGen[1]  < ld_ActivationDate) AND (lb_NullLastDate = FALSE)) THEN
			lb_Suspended = TRUE
		ELSE
			lb_Suspended = FALSE
		END IF
	END IF
	FOR ll_TotalCounter = 1 To ll_TotalDays
		IF lb_ContinueProcess = TRUE THEN // need a way to stop processing
		// what's the target total? Was it an actual target total? 
		// Have we exceeded or reached it if we are not suspended?  
			lc_runtotal = lnv_periodictemplate.of_GetRunningTotal ()
			IF IsNull(lc_runtotal) THEN  
				lc_runtotal = 0
			END IF
			ll_runcount = lnv_periodictemplate.of_GetRunningCount ()
			IF IsNull(ll_runcount) THEN 
				ll_runcount = 0
			END IF 
			IF ((lc_runtotal < lc_targettotal) AND (lb_AimForTargetTotal = TRUE)) &
				OR IsNull(lc_targettotal) OR (lc_targettotal = 0) &
				OR (lb_Suspended = TRUE) THEN // checking last pass running total.
				IF ((lda_DatesToGen[ll_TotalCounter]  < ld_ActivationDate) &
				 AND (lb_NullLastDate = FALSE)) THEN					
					lc_Amount = 0
					lb_Suspended = TRUE
				ELSE			
					lc_amount = lc_storedamount 
					lb_Suspended = FALSE
				END IF
				// create amount owed and update running total					
				ll_Return = anv_transactionmanager.of_CreateAmountOwed(lnv_periodictemplate, lnv_NullTransaction, &
					lnv_AmountOwed, lc_amount, lc_quantity, lc_rate, lb_Suspended)
				If ll_Return < 0 THEN
					ls_ErrMsg = "10631|Autogen can not create an amount owed for template " + &
					ls_TemplateName + "."
					this.of_InsertErrorMsg(ls_ErrMsg)
				
				END IF
				
				lc_amount = abs(lc_amount) //positive amount for totals
				
				lc_runtotal = lc_runtotal + lc_amount			

				IF (lc_runtotal = lc_targettotal) AND (lb_AimForTargetTotal = TRUE) THEN // we hit the valid target 
				// total, don't process next time, don't do fix up this time, 
					IF lb_Suspended = TRUE THEN
					ELSE
						lb_ContinueProcess = FALSE
					END IF
				END IF  // new running total = valid target total
				
 				IF (lb_Suspended = TRUE) THEN  //
					IF (lda_DatesToGen[ll_TotalCounter] >= ld_ActivationDAte) THEN
						lb_Suspended = FALSE
					END IF
				END IF	
				IF (lc_runtotal > lc_targettotal) AND (lb_AimForTargetTotal = TRUE) THEN // remove excess taken, 
				// don't process next time
					lc_excessamount = lc_runtotal - lc_targettotal
					lc_amount = lc_amount - lc_excessamount
					lnv_AmountOwed.of_SetAmount(lc_amount)			
					lc_runtotal = lc_targettotal
					lb_ContinueProcess = FALSE				
				END IF // new running total > valid target total
			
				If IsValid(lnv_AmountOwed) THEN
					IF NOT IsNull(ll_Transactionid) THEN
						lnv_AmountOwed.of_SetFKTransaction_Direct(ll_Transactionid)
					END IF
					
					//MFS 5/17/07 - record start/end date
					lnv_Amountowed.of_SetStartDate(lda_DatesToGen[ll_TotalCounter])
					lnv_AmountOwed.of_SetEndDate(lda_DatesToGen[ll_TotalCounter])
					
					ll_AmountCounter ++						
					lnva_Amounts[ll_AmountCounter] = lnv_AmountOwed	
					//nl
					IF IsValid(lnv_Amountowed) THEN  
						destroy lnv_amountowed
//						lnv_AmountOwed = lnv_NullAmountOwed
					end if
				END IF	
				lnv_periodictemplate.of_SetLastDate(lda_DatesToGen[ll_TotalCounter])
				ld_currentfirst = lnv_periodictemplate.of_GetFirstDate()
				IF IsNull(ld_currentfirst) THEN
					lnv_periodictemplate.of_SetFirstDate(lda_DatesToGen[ll_TotalCounter])
				END IF
				lnv_periodictemplate.of_SetLastAmount(lc_amount)
				lnv_periodictemplate.of_SetRunningTotal(lc_runtotal)
				ll_runcount ++				
				lnv_periodictemplate.of_SetRunningCount(ll_runcount)
	
					
			ELSE // examines last pass, we had a valid target total and running total  
				// is more than or equal to the maximum target total that was allowed, 
				// didn't do periodic processing this pass.
				lb_ContinueProcess = FALSE
			END IF //  testing target total
		END IF  // end if lb_continueprocess = true
	NEXT //    potential date is looping between start date and end date (dates to generate)
END IF
IF IsValid(an_Transaction) THEN
	an_transaction.of_Calculate()
END IF


IF upperbound(lnva_Amounts) > 0 THEN
	ll_Row = lds_PeriodicUpdates.InsertRow(0)
	IF ll_Row > 0 THEN
				lds_PeriodicUpdates.object.id[ll_row] = ll_AmounttemplateId
				IF (ll_TotalCounter > ll_TotalDays) AND (ll_TotalDays > 0 )THEN
					ll_TotalCounter = ll_TotalDays
				END IF
				
				lds_PeriodicUpdates.object.lastdate[ll_Row] = lda_datestoGen[ll_TotalCounter]
				ld_currentfirst = lnv_periodictemplate.of_GetFirstDate()
				IF IsNull(ld_currentfirst) THEN
					lds_PeriodicUpdates.object.firstdate[ll_Row] = lda_DatesToGen[ll_Counter]
				else
					//nl
					lds_PeriodicUpdates.object.firstdate[ll_Row] = ld_currentfirst
				END IF
				lds_PeriodicUpdates.object.lastAmount[ll_Row] = lc_amount
				lds_PeriodicUpdates.object.RunningTotal[ll_Row] = lc_runtotal			
				lds_PeriodicUpdates.object.RunningCount[ll_Row] = ll_runcount 
	ELSE
		ls_ErrMsg = "10685|Autogen was unable to place updated periodic" + &
		" information into PeriodicUpdates for template " + ls_templateName + "."
		this.of_InsertErrorMsg(ls_ErrMsg)		
	END IF
END IF // no amount owed created

IF ll_Return < 0 THEN

ELSE
	ll_Return = ll_AmountCounter
END IF

ads_PeriodicUpdates = lds_PeriodicUpdates
ll_AmountCounter = upperbound(lnva_Amounts)
FOR ll_Index = 1 TO ll_AmountCounter
	IF IsValid(lnva_Amounts[ll_index]) THEN
		//nl
		destroy lnva_Amounts[ll_index]
//		lnva_Amounts[ll_index] = lnv_NullAmountOwed
	END IF
NEXT
IF IsValid(lnv_AmountOwed) THEN
	//nl
	destroy lnv_AmountOwed
//	lnv_AmountOwed = lnv_NullAmountOwed
END IF
IF IsValid(lds_NthDay) THEN
	DESTROY lds_NthDay
END IF
RETURN ll_Return
///
end function

public function long of_getamounttype (ref n_cst_beo_amounttype anv_amounttype, integer ai_amounttype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetAmountType
//  
//	Access:  public
//
//	Arguments: 
//					anv_amounttype by reference, output
//					ai_amounttype
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for n_cst_bso_payable
// 
// When creating an amount owed without access to an amount template
// we need info from the amount type.  Currently we only need the taxable
// default.  But, at some time we might need other info. So return a BEO
// amount type which can be used to obtain this info.
// 
// Written by: J. Albert
// 		Date: 11.19.02
//		Version:  1.0, initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//


long ll_Return

n_cst_bcm	lnv_Cache
n_cst_beo_amounttype	lnv_Beo


IF gnv_App.inv_CacheManager.of_getCache("n_cst_dlkc_amounttype", lnv_Cache, TRUE, TRUE) = 1 THEN
	lnv_Beo= lnv_Cache.GetBeo("amounttype_id = " + String(ai_amounttype))
	IF IsValid(lnv_Beo) THEN
		anv_AmountType = lnv_Beo
		ll_Return = 1
	ELSE
		ll_Return = -1
	END IF
END IF
RETURN ll_Return
end function

public function integer of_getsurchargetypes (string as_value, ref n_cst_beo_amounttype anva_amounttype[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetSurchargeTypes
//  
//	Access:  public
//
//	Arguments: 
//					as_value input
//					anva_amounttype[] by reference, output
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for n_cst_bso_payable
// 
//		Get an array of n_cst_beo_amounttypes that meet the 
//  amounttype.surcharge value that is passed in as as_value.
//  
//
//
// Written by: J. Albert
// 		Date: 11.25.02
//		Version:  1.0, initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

long ll_Return, &
		ll_Counter

n_cst_beo_amounttype lnv_amounttype, &
					lnva_amounttype[]
n_cst_bcm 	lnv_bcm
n_cst_database	lnv_database
n_cst_query	lnv_query



lnv_database = gnv_bcmmgr.GetDatabase()
IF IsValid(lnv_database) THEN
	lnv_query = lnv_database.GetQuery()
	lnv_query.SetArgument(as_value)
	lnv_BCM = lnv_query.ExecuteQuery("n_cst_dlkc_amounttype","","surcharge")
	
	IF IsValid(lnv_BCM) then
		lnv_AmountType = lnv_Bcm.GetFirst()
		DO WHILE IsValid(lnv_AmountType)
			ll_Counter++
			lnva_Amounttype[ll_Counter] = lnv_AmountType
			lnv_AmountType = lnv_Bcm.GetNext()	
		LOOP	
	ll_Return = 1
	ELSE
		ll_RETURN = -1
	END IF  // valid lnv_BCM
ELSE // valid database
	ll_Return = -1
END IF
anva_AmountType = lnva_AmountType


RETURN ll_Return
end function

public function integer of_getamounttag (string as_value, ref n_cst_beo_amounttype anva_amounttype[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetAmountTag
//  
//	Access:  public
//
//	Arguments: 
//					as_value input
//					anva_amounttype[] by reference, output
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for n_cst_bso_payable
// 
//		Get the  n_cst_beo_amounttype that meet the 
//  amounttype.tag value that is passed in as as_value.
//  
//
//
// Written by: J. Albert
// 		Date: 11.25.02
//		Version:  1.0, initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

long ll_Return, &
		ll_Counter

n_cst_beo_amounttype lnv_amounttype, &
					lnva_amounttype[]
n_cst_bcm 	lnv_bcm
n_cst_database	lnv_database
n_cst_query	lnv_query



lnv_database = gnv_bcmmgr.GetDatabase()
IF IsValid(lnv_database) THEN
	lnv_query = lnv_database.GetQuery()
	lnv_query.SetArgument(as_value)
	lnv_BCM = lnv_query.ExecuteQuery("n_cst_dlkc_amounttype","","tag")
	
	IF IsValid(lnv_BCM) then
		lnv_AmountType = lnv_Bcm.GetFirst()
		DO WHILE IsValid(lnv_amountType)
			ll_Counter ++
			lnva_amounttype[ll_Counter] = lnv_AmountType
			lnv_AmountType = lnv_BCM.GetNext()
		LOOP
		ll_Return = 1
	ELSE
		ll_RETURN = -1
	END IF  // valid lnv_BCM
ELSE // valid database
	ll_Return = -1
END IF

anva_amounttype = lnva_amounttype

RETURN ll_Return
end function

public function long of_inserterrormsg (string as_errmsg);///////////////////////////////////////////////////////////////////////////////
//
//  
//
//	Function: of_insertErrorMsg
//  
//	Access:  public
//
//	Arguments: 
//					as_ErrMsg
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for n_cst_bso_payable
//
//  	Places error messages into system array.
//
// Written by: J. Albert
// 		Date: 12.07.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
long ll_Return = 1

n_Cst_OFRError	lnv_Error
	
IF len(as_ErrMsg) > 0 THEN
		lnv_Error = This.AddOFRError()
		IF IsValid(lnv_Error) THEN
			lnv_Error.SetErrorMessage(as_ErrMsg)
		ELSE
			ll_Return = -1
		END IF
END IF

RETURN ll_Return
end function

public function long of_processsurcharge (n_cst_beo_entity anva_entity[], ref n_cst_bso_transactionmanager anv_transactionmanager, decimal ac_surcharge, integer ai_id, ref n_cst_beo_transaction anva_transactions[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ProcessSurcharge for n_cst_bso_payable
//  
//	Access:  public
//
//	Arguments: 
//					anva_entity[]
//					anv_transactionmanager by reference, input
//					ac_surcharge
//					ai_id  - value for amountowed.type for this new amount owed.
//					anva_transactions[] by value, input
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for n_cst_bso_payable
//
//  w_settelementbatchmanager calls this to calculate the fuel surcharge
//  Conceptually, we loop thru the entities (truck drivers only) one at 
//  a time. Actually, the transactions and entities are 1:1. So we use the 
//  transactions that are associated with the truck driver entity, obtain
//  all of the amount oweds.  For amount oweds that have a that have
//  an amounttype.Id with a amounttype.surcharge = 'F', sum these amount
//  oweds to create a basis amount.
//
//  Multiple sum of the appropriate amount oweds (basis amount) by the 
//  value from the payable fuel surcharge system setting.  Create a
//  new amount owed and place this new amount into this new amount owed.
//  Associate this new amount owed with the existing transaction.
//
// 
//  All errors for this code should be within 01500-01599 for informational
//  errors and 11500-11599 for severe errors.
//
// Written by: J. Albert
// 		Date: 11.16.02
//		Version:  1.0, initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//  April 3 2003 changed the way the surcharge amount types are gathered <<*>>
//	
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
//any	la_SysSettingValue

boolean 	lb_ContinueProcess = TRUE, &
		lb_Created, &
			lb_RouteTypeDefined, &
		lb_FuelSurchargeFound


dec	lc_surcharge, &
		lc_Amount, &
		lc_BasisAmount, &
		lc_Rate, &
		lc_Quantity

integer	lia_amounttypeids[], &
			li_amounttypeId, &
			li_Type, &
			li_Category, &
			li_routetype, &
			li_TransactionStatus

long 	ll_Return, &
		ll_Count, &
		ll_CountMax, &
		ll_Index, &
		ll_IndexMax, &
		ll_entitycount, &
		ll_entityindex, &
		ll_TransactionId, &
		ll_SurchargeMax, &
		ll_SurchargeCount, &
		ll_AmountTypeIdMax, &
		ll_CountId, &
		ll_dateoffset = 0, &
		ll_FkEntity, &
		ll_CountNotProcessed

string 	ls_Surcharge, &
			ls_SurchargeType, &
			ls_description = "FUEL SURCHARGE", &
			ls_ErrMsg, &
			ls_MessageHeader = "Fuel Surcharge"
			
s_parm		lstr_parm
n_cst_msg	lnv_Range
n_cst_OFRError	lnv_Error			

n_cst_BCM	lnv_TransactionBCM, &
				lnv_AmountOwedBCM

n_cst_Settings lnv_Settings
n_cst_beo_amountowed	lnva_amountowed[], &
			lnv_amountowed, &
			lnv_NullAmountOwed
			
n_cst_beo_amounttype lnv_amounttype

n_cst_beo_itinerary2	lnv_itinerary
n_cst_beo_transaction lnva_transaction[], &
				lnv_Transaction, &
				lnv_NullTransaction

n_cst_beo_shipment	lnv_null_ship
n_cst_bso_Dispatch 	lnv_Dispatch
n_cst_bso_transactionmanager	lnv_TransactionManager

ll_entitycount = upperbound(anva_entity)

ls_SurchargeType = THIS.of_Getpayfuelsurchargetype( )

IF lb_ContinueProcess = TRUE THEN
	IF IsValid(lnv_Dispatch) THEN
		// NOP - we shouldn't have a valid dispatch object
	ELSE
		lnv_Dispatch = CREATE n_cst_bso_Dispatch
		IF IsValid(lnv_Dispatch) THEN
			// continue processing
		ELSE
			lb_ContinueProcess= FALSE
//			ls_ErrMsg = "115231|Unable to create a dispatch object."
//			ll_Return = this.of_insertErrorMsg(ls_ErrMsg)
			ll_Return = -1
		END IF  
	END IF  
END IF  // continue process = true

choose case ls_SurchargeType
	case 'PERCENTAGE'
		ll_AmountTypeIDMax = this.of_Getfuelsurchargeamounttypeid ( lia_AmountTypeids )
		if ll_AmountTypeIDMax  = 0 then
			lb_ContinueProcess = false
		else
			lb_ContinueProcess = true
		end if
		ac_Surcharge = ac_surcharge/100

		CHOOSE CASE anv_transactionmanager.of_GetRouteTypeSettlements(li_RouteType)
			CASE 0 // 
				lb_RouteTypeDefined = FALSE
			CASE 1
				lb_RouteTypeDefined = TRUE
		END CHOOSE

	case 'PERMILE'
		lb_ContinueProcess = true
		
end choose

IF lb_ContinueProcess = TRUE AND IsValid(anv_TransactionManager) THEN
	// failed transactions are excluded from this transaction manager.  Not True on 12/10/02.
	lnv_TransactionManager = anv_TransactionManager
	// get all of the transactions from the window (w_settlementBatchManager) 
	lnva_transaction = anva_transactions
END IF  // Transaction Manager validity check

IF lb_ContinueProcess = TRUE THEN
	ll_CountMax = upperbound(lnva_transaction)
	FOR ll_Count =  1 TO ll_CountMax
		lb_FuelSurchargeFound = FALSE
		lc_basisAmount = 0		
		ll_TransactionID = lnva_Transaction[ll_Count].of_GetID()
		li_TransactionStatus = lnva_Transaction[ll_Count].of_GetStatus()
		IF li_TransactionStatus = appeon_constant.ci_status_audited THEN
		// only work on audited transactions for fuel surcharge.	
			lnv_Itinerary = this.of_Createitinerary(lnva_transaction[ll_count], &
			lnv_dispatch, ll_dateoffset)
			// set this itinerary to be the instance itinerary of the transactionmanager
			// because creating an amount owed requires this.
			ll_Return = lnv_transactionManager.of_SetItineraryObject(lnv_itinerary)
			choose case ls_SurchargeType
				case 'PERCENTAGE'
					// Get the amount and amounttype for each amount.
					// For each transaction, look at all of its amount oweds.
					ll_Return = lnv_TransactionManager.of_getTransactionamounts(ll_TransactionID, lnva_amountowed)
					IF ll_Return < 0 THEN 
						lb_ContinueProcess = FALSE
						EXIT
					END IF
					ll_IndexMax = upperbound(lnva_Amountowed)
					FOR ll_Index = 1 to ll_IndexMax
						lc_Amount = 0
						li_amounttypeId = lnva_Amountowed[ll_Index].of_GetType()

						FOR ll_CountID = 1 TO ll_AmountTypeIDMax
						// Compare this amount owed Id with those that are marked
						// fuel surcharge. If it is one of those, use it's amount
						// as a basis for calculation.

						IF li_AmounttypeID = lia_AmounttypeIDs[ll_CountID] THEN
							lc_Amount = lnva_AmountOwed[ll_Index].of_GetAmount()
							lc_BasisAmount += lc_Amount
							lb_FuelSurchargeFound = TRUE					
						END IF
						NEXT // end of matching to fuel surcharge amounttype.id
					
					NEXT // end of amount owed loop
					
				case 'PERMILE'
					
					lc_BasisAmount = lnv_Itinerary.of_GetTotalMiles()
					if lc_BasisAmount > 0 then
						lb_FuelSurchargeFound = TRUE
					else
						lb_FuelSurchargeFound = FALSE
					end if
					
			end choose
			
			IF lb_FuelSurchargeFound = TRUE THEN
			// we need category & entity when creating a new amount owed.
				li_Category = lnva_Transaction[ll_Count].of_GetCategory()
				ll_FKEntity = lnva_Transaction[ll_Count].of_GetFkEntity()
				ll_Return = lnv_TransactionManager.of_SetDefaultCategory(li_Category)
				ll_Return = lnv_TransactionManager.of_SetDefaultEntityID(ll_FkEntity)					
				// go create a new amount owed for this Transaction.
				// ai_id (the amounttype id for this amount owed; lc_Amount, lc_rate is null, lc_quantity is null
				if ls_surchargetype = 'PERMILE' then
					lc_rate = ac_surcharge
					lc_quantity = lc_BasisAmount
				else
					SetNull(lc_rate)
					SetNull(lc_quantity)
					lc_Amount = round(lc_BasisAmount * ac_surcharge, 2)
				end if
				IF IsValid(lnv_Amountowed) THEN  
					destroy lnv_AmountOwed
				END IF

				ll_Return = this.of_GenerateAmountOwed(lnv_Nulltransaction, lnv_TransactionManager, ai_id, &
								ls_Description, lnv_amountowed, lc_amount, lc_rate, lc_quantity)

				IF IsValid(lnv_AmountOwed) THEN
					
					for ll_entityindex = 1 to ll_entitycount
						if anva_entity[ll_entityindex].of_getid() = ll_FKEntity then
							inv_entity = anva_entity[ll_entityindex]
							lnv_AmountOwed.of_SetDivision(this.of_GetDivision(lnv_null_ship))
							exit
						end if
					next
					
					IF NOT IsNull(ll_TransactionId) THEN
						lnv_AmountOwed.of_SetFKTransaction_Direct(ll_TransactionID)
						lnva_AmountOwed[ll_indexMax + 1] = lnv_AmountOwed
					END IF
					IF IsValid(lnva_Transaction[ll_Count]) THEN
						lnva_Transaction[ll_Count].of_Calculate()
					END IF  // recalculate this transaction - fix up null transaction
				END IF // check on if valid amount Owed.			
			END IF // Check on if lb_FuelSurchargeFound is true
		ELSE
			ll_CountNotProcessed ++
		END IF // did this transaction have a status of audited?  Only do surcharge processing
		// on audited transactions.
	NEXT // end of transaction loop

END IF
anva_transactions = lnva_transaction

IF IsValid(lnv_Dispatch) THEN DESTROY lnv_Dispatch

IF ll_CountNotProcessed = ll_CountMax THEN
	messagebox(ls_MessageHeader, " Fuel surcharge processing was not performed on these" + &
	" transactions because none of these transactions had a status of 'AUDITED'", &
	information!, ok!)
END IF
RETURN ll_Return
end function

public function long of_processshipmentpay (n_cst_beo_amounttemplate anva_template[], n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, date ad_start, date ad_end, ref n_cst_beo_transaction anv_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, ref long al_countao);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_ProcessShipmentPay
//  
//	Access		:public
//
//	Arguments	:anva_amountTemplate[]
//					 anv_itinerary
//					 anv_dispatch
//					 ad_start
//					 ad_end 
//					 anv_transaction by reference
//					 anv_transactionManager by reference
//					 al_countAO by reference
//
//	Return		:long
//					 1 success
//					-1 failure
//						
//	Description	:Get all shipments for the itineray. Retrieve the shipments and loop through.
//					 Check the payable format on the shipment. If format equals item then get all the
//					 the items for the shipment (itemes for split bills are also included. They must 
//					 be a category of payable or both. See if the item is associated with any events 
//					 in the driver's itinerary.  If it is then check for a pay amount on the item.  If
//					 If there is one then use it else check for a rate code.  If there is one then look
//					 for pay in the rate tables.
//
//					 For Category format get the Freight pay and Accessorial pay and create two amounts.
//					 For Total format create one amount.
//
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

any		la_value

long		ll_return=1, &
			ll_EntityId, &
			lla_EventId[], &
			ll_TransactionId, &
			ll_EventCount, &
			ll_ShipCount, &
			ll_ItemCount, &
			ll_puevent, &
			ll_delevent, &
			lla_ShipId[], &
			lla_ShipEvent[], &
			ll_shipeventcount, &
			ll_splitcount, &
			ll_Index, &
			ll_Index2, &
			ll_SplitIndex, &
			ll_countaowed, &
			ll_PaySplitRow, &
			ll_nextid, &
			ll_listcount, &
			ll_max, &
			ll_count


integer	li_amounttype

decimal	lc_amount, &
			lc_rate, &
			lc_quantity, &
			lc_miles, &
			lc_null, &
			lc_percentage
			
string	ls_description, &
			ls_coinfo, &
			ls_value, &
			ls_errmsg, &
			ls_ratecodename, &
			ls_ShipMoveCode, &
			ls_powerunit, &
			ls_trailer, &
			ls_container, &
			lsa_List[], &
			lsa_blank[]


boolean	lb_StandardFreight, &
			lb_ratecode, &
			lb_RateIt

s_parm	lstr_Parm
n_cst_settings	lnv_settings
n_cst_msg	lnv_Range
n_ds			lds_ShipCache, &
				lds_ItemCache, &
				lds_EventCache,&
				lds_PaySplitCache
				
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_company		lnv_company
n_cst_beo_equipment2	lnva_equipment[], &
							lnva_BlankEquipment[]
n_cst_equipmentmanager	lnv_Equipmanager
n_cst_beo_Item			lnva_Item[], lnva_BlankItem[]
n_cst_beo_Event			lnv_Event, lnva_Event[], lnva_BlankEvent[], lnva_splitevent[]
n_cst_beo_amountowed	lnv_AmountOwed, &
							lnv_NullAmountOwed
n_cst_beo_transaction	lnv_NullTransaction
n_cst_AnyArraySrv			lnv_ArraySrv
n_cst_ratedata				lnv_ratedata

setnull(lc_null)

Long	ll_deletethis
/*
I commented this b.c. it was overwriting the range that was being sent in. this was causing 
interactive settlements to pay the entire date range even when a block was locked

MOVED TO of_generate( )


*/

//IF IsValid(anv_Itinerary) THEN
//	lstr_Parm.is_Label = "StartDate"
//	lstr_Parm.ia_Value = ad_Start
//	lnv_Range.of_Add_Parm(lstr_Parm)
//	
//	lstr_Parm.is_Label = "EndDate"
//	lstr_Parm.ia_Value = ad_End
//	lnv_Range.of_Add_Parm(lstr_Parm)
//	
//	lstr_Parm.is_Label = "ItinType"
//	lstr_Parm.ia_Value = gc_Dispatch.ci_itinType_Driver
//	lnv_Range.of_Add_Parm(lstr_Parm)
//
//	lstr_Parm.is_Label = "ItinId"
//	lstr_Parm.ia_Value = il_ItinId
//	lnv_Range.of_Add_Parm(lstr_Parm)
//		
//	anv_Itinerary.of_SetRange(lnv_Range)
//	
//ELSE
//	ll_Return = -1
//	ls_ErrMsg = "10813|Itineray object is not available"
//END IF




IF ll_Return = 1 THEN
	IF isvalid(anv_TransactionManager) THEN
		ll_EntityID= anv_TransactionManager.of_GetDefaultEntityId()
		IF ll_EntityId = 0 THEN	
			ll_Return = -1
			ls_ErrMsg = "10833|The entity identifier has been corrupted."
		END IF
	ELSE
		ll_Return = -1
	END IF
END IF

IF ll_Return = 1 THEN
	If IsValid(anv_Transaction) THEN
		ll_TransactionId = anv_Transaction.of_getId()
		If IsNull(anv_Transaction.of_GetStartDate()) OR IsNull(anv_Transaction.of_GetEndDate()) THEN
			anv_Transaction.of_SetStartDate(ad_Start)
			anv_Transaction.of_SetEndDate(ad_End)
		END IF
	ELSE // not valid transaction object
		ll_Return = -1
		ls_ErrMsg = "10843|This transaction object is corrupted."
	END IF
END IF

IF ll_Return = 1 THEN
	If IsValid(anv_Dispatch) THEN
		//ok
	ELSE
		ll_REturn = -1
		ls_ErrMsg = "10847|This dispatch object is corrupted."
	END IF
END IF

IF ll_Return = 1 THEN
	ll_eventcount = anv_itinerary.of_geteventIds(lla_eventId) 
	if ll_eventcount > 0 THEN
		//have events
	ELSE
		ll_Return = -1
		ls_ErrMsg = "10855|Could not obtain any event ids from the itinerary."
	END IF
END IF

IF ll_Return = 1 THEN
	ll_ShipCount = anv_itinerary.of_getShipmentIds(lla_ShipId, TRUE /*lb_ShrinkNulls */, &
		TRUE /*lb_ShrinkDupes */, TRUE /* Use Exclude */)
	IF ll_ShipCount > 0 THEN
		//have shipments associated with the events
	ELSE
		ll_Return = -1
		ls_ErrMsg = "00859|Could not obtain any shipment ids from the itinerary."
	END IF
END IF

IF ll_Return = 1 THEN
	
	IF anv_dispatch.of_RetrieveShipments(lla_ShipId) < 0 THEN
		ll_Return = -1
		ls_ErrMsg = "10871|Could not obtain any shipment ids from the dispatch."
	ELSE
		lds_ShipCache = anv_Dispatch.of_GetShipmentCache()
		lds_ItemCache = anv_Dispatch.of_GetItemCache()
		lds_EventCache = anv_Dispatch.of_GetEventCache()

		FOR ll_Index = 1 TO ll_ShipCount

			if isvalid(lnv_shipment) then
				destroy lnv_shipment
			end if
			
			lnv_Shipment = CREATE n_cst_beo_shipment
			lnv_Shipment.of_SetSource(lds_ShipCache)
			lnv_Shipment.of_SetItemSource(lds_ItemCache)
			lnv_Shipment.of_SetEventSource(lds_EventCache)
						
			lnv_Shipment.of_SetSourceid(lla_ShipId[ll_Index]) 

			ll_shipeventcount = lnv_Shipment.of_GetEventList(lnva_Event)
			lnv_Shipment.of_getEventIDs(lla_shipevent)

			//check shipment for pay type 
			choose case lnv_Shipment.of_GetPayableFormat ( )
					
				case appeon_constant.cs_PayableFormat_Item
		
					ll_ItemCount = this.of_getshipmentitems(anv_dispatch, lnv_shipment, '', 'SHIPMENTPAY', lnva_item )	

					//loop thru items for amounttypes
					
					FOR ll_Index2 = 1 to ll_ItemCount
		
						CHOOSE CASE lnva_Item[ll_Index2].of_GetAccountingType()
								
							CASE n_cst_constants.cs_AccountingType_Billable
							
							CASE n_cst_constants.cs_AccountingType_Payable, n_cst_constants.cs_AccountingType_Both 				
								
								//is this item associated with any events in the driver's itinerary
								ll_puevent = lnva_Item[ll_Index2].of_GetPickUpEvent()
								ll_delevent = lnva_Item[ll_Index2].of_GetDeliverEvent()
								if ll_puevent > 0 then
									if ll_delevent > 0 then
										//check range pu to del
									end if
									//check one event
									ll_delevent = ll_puevent
								else
									//check all events in shipment
									ll_puevent = 1
									ll_delevent = ll_shipeventcount
								end if
								
								lnva_splitevent = lnva_BlankEvent
								for ll_splitcount = ll_puevent to ll_delevent
									if lnv_ArraySrv.of_findlong(lla_Eventid, lla_shipevent[ll_splitcount], 1, ll_eventcount) > 0 then
										//found
										lnva_splitevent[upperbound(lnva_splitevent) + 1] = lnva_Event[ll_splitcount]
									end if										
								next
								ll_splitcount = upperbound(lnva_splitevent)
								if ll_splitcount > 0 then
									// Set up to create a valid amount owed
									ls_Description = trim(lnva_item[ll_Index2].of_GetDescription())
									lc_amount = lnva_item[ll_Index2].of_getPayableAmount()
									lc_rate = lnva_item[ll_Index2].of_getPayRate() 
									if lc_rate > 0 then
										lc_quantity = lc_amount / lc_rate 
									else
										lc_quantity = lnva_item[ll_Index2].of_getQuantity()
									end if

									lnv_AmountOwed = lnv_NullAmountOwed
//********** new rate logic
									lnv_ratedata = create n_cst_ratedata
									IF ll_index = 23 and ll_index2 = 5 THEN	//here for debuggin purposes only
										ll_deletethis = 0
									END IF
									if this.of_setratedata(anva_template[1], lnv_shipment, lnva_item[ll_Index2], &
													lnv_Ratedata, lnv_Shipment.of_getorigin( ), lnv_Shipment.of_getdestination( ) ) then
										//we have a ratadata object 
										if lnv_Ratedata.of_LookAtShipmentcode() then
											if lnva_Item[ll_Index2].of_IsAccessorial() and &
												lnv_ratedata.of_GetAccessPayablePercentage() > 0 then
												//	go on to rating section and get percentage of pay on item
												lb_RateIt = true
											else
												//is there pay on the item
												//if the item has a pay amount use it
												if lc_amount > 0 then
													lb_ratecode=false
													lb_RateIt = false
												else
													lb_RateIt = true
												end if
											end if
										else
											//we have a rate code but not looking at the shipment for pay
											lb_RateIt = true
										end if
									else
										lb_RateIt = false
									end if

									if lb_RateIt then
										
										ls_ShipMoveCode = lnv_shipment.of_GetMoveCode()	
										if lnva_item[ll_Index2].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_FrontChassisSplit or &
											lnva_item[ll_Index2].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_BackChassisSplit or &
											lnva_item[ll_Index2].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_StopOff then
											lb_StandardFreight = false
										else
											lb_StandardFreight = true
										end if
										//  try auto rating
										lc_miles = lnva_item[ll_Index2].of_getMiles()
										lnv_ratedata.of_settotalmiles(lc_miles)	
										lnv_ratedata.of_SetCategory(n_cst_constants.ci_Category_Payables)
										this.of_getratedata(lnv_shipment, lnva_item[ll_Index2],lnv_Ratedata)
										ls_ratecodename = lnv_ratedata.of_GetCodename()
										lb_ratecode=true

										if len(trim(ls_ratecodename)) > 0 then
											if ls_Ratecodename = 'CUSTOM' then
												//SKIP
											else
												//have amount replace 
												lc_rate = lnv_ratedata.of_Getrate()
												lc_amount = lnv_ratedata.of_GetTotalCharge()
												if lnv_ratedata.of_Getratetype() = appeon_constant.cs_RateUnit_Code_Flat then
													lc_quantity = 1
												else
													lc_Quantity = lnv_ratedata.of_GetTotalCount()
												end if
												li_amounttype = lnv_ratedata.of_GetAmounttype()
												if isnull(li_amounttype) or li_amounttype = 0 then
													li_amounttype = lnva_item[ll_Index2].of_getamounttype()
												end if
												if lnv_ratedata.of_usedSubstitution() or lnv_ratedata.of_usedfallback() then
													ls_description = lnv_ratedata.of_GetDescription()
												else
													ls_description = lnva_item[ll_Index2].of_getdescription()
												end if
											end if
										else
											
											lc_percentage=0
											li_amounttype = lnva_item[ll_Index2].of_getamounttype()
											ls_description = lnva_item[ll_Index2].of_getdescription()
											
											if lnva_Item[ll_Index2].of_IsAccessorial() then
												lc_amount = lnva_item[ll_Index2].of_GetAccessorialCharges()
												lc_percentage = lnv_ratedata.of_GetAccessPayablePercentage() / 100
											else
												lc_amount = lnva_item[ll_Index2].of_getFreightCharges()
												lc_percentage = lnv_ratedata.of_GetFreightPayablePercentage() / 100
											end if

											if lc_percentage > 0 then
												lc_quantity = lc_null
												lc_rate = lc_null
												lc_amount = lc_amount * lc_percentage											
											else										
												if lnva_item[ll_Index2].Of_GetRateCodeName() = 'CUSTOM' OR lnva_item[ll_Index2].Of_GetRateCodeName() = '' OR IsNull (lnva_item[ll_Index2].Of_GetRateCodeName() ) then
													//	If we didn't find a rate code and the item rate is 'custom' then ZERO AMOUNT OWED   
													lc_amount = 0
													li_amounttype = lnva_item[ll_Index2].of_getamounttype()
													ls_description = lnva_item[ll_Index2].of_getdescription()
												end if
											end if															
										end if
									end if

//**********end new rate logic
									
									// create a new amount owed
									IF lc_amount > 0 THEN
										li_AmountType = lnva_item[ll_Index2].of_GetAmountType()
										
										/*
											DEK 4-20-07
											Fixed issue with CWT calculating incorrectly when paying
											drivers.  It was over paying by 100 times.
											
											6-9-07 Undid the fix, the initial problem was in setup of the rate table.
											THe table break unit was pound, but the minimum was CWT.  So it was using pound
											for the calculation.  The only time it seems to use the unit in the rate is when the
											table break unit is flat.  Look at of_setTotalCharge and of_getbreakunit on appeon_constant.
										*/
										
//										IF lnva_Item[ll_index2].of_getRatetype( ) = appeon_constant.cs_RateUnit_Code_100Pound THEN
//											lc_quantity = lc_quantity / 100
//										END IF
										//////////////////
										IF of_GenerateAmountOwed(lnv_Nulltransaction, anv_transactionmanager, li_AmountType, &
														   ls_Description, lnv_amountowed, lc_amount, lc_rate, lc_quantity) < 0 THEN
											ll_return = -1 
											EXIT
										END IF
										IF IsValid(lnv_amountOwed) THEN
											IF ll_TransactionId > 0 THEN
												lnv_AmountOwed.of_SetFKTransaction_Direct(ll_TransactionID)
												ll_CountAOwed ++
											END IF 
											
											if lb_ratecode then
												lnv_AmountOwed.of_SetRateCodename(lnv_ratedata.of_Getcodename())
												lnv_AmountOwed.of_SetOriginzone(lnv_ratedata.of_GetOriginzone())
												lnv_AmountOwed.of_SetDestinationzone(lnv_ratedata.of_GetDestinationzone())
												lnv_AmountOwed.of_SetbilltoId(lnv_ratedata.of_GetbilltoId())
											end if

											lnv_AmountOwed.of_SetDescription ( ls_Description )
											lnv_AmountOwed.of_SetDivision(this.of_GetDivision(lnv_shipment))
											lnv_AmountOwed.of_SetStartDate (ad_start)
											lnv_AmountOwed.of_SetEndDate (ad_end)												
											lnv_AmountOwed.of_SetShipment ( string(lnv_Shipment.of_getid()) )	
			
											//put shipment origin and dest in public note
											if lnv_Shipment.of_getOrigin(lnv_company,TRUE) = 1 then
												ls_coinfo = lnv_company.of_getname()
												if len(trim(ls_coinfo)) > 0 then
													ls_Value = 'Ship Orig: '  +  ls_coinfo
												end if
												ls_coinfo = lnv_company.of_getlocation()
												if len(trim(ls_coinfo)) > 0 then
													ls_value += ' ' + ls_coinfo
												end if
											end if
											if lnv_Shipment.of_getDestination(lnv_company,TRUE) = 1 then
												ls_coinfo = lnv_company.of_getname()
												if len(trim(ls_coinfo)) > 0 then
													ls_value +=  ' Ship Dest: ' + ls_coinfo
												end if
												ls_coinfo = lnv_company.of_getlocation()
												if len(trim(ls_coinfo)) > 0 then
													ls_value += ' ' + ls_coinfo
												end if
											end if										
											IF len ( ls_Value ) > 0 THEN
												lnv_AmountOwed.of_SetPublicNote ( ls_Value )
											END IF	
											
											ls_Value = anv_Itinerary.of_GetDriverList ( )
											IF len ( ls_Value ) > 0 THEN
												lnv_AmountOwed.of_SetDriver ( ls_Value )	
											END IF

											ls_powerunit=''
											ls_trailer = ''
											ls_container = ''
//											lnv_Arraysrv.of_destroy(lnva_equipment)
//											lnva_equipment = lnva_BlankEquipment
//											if lnv_Shipment.of_getequipmentlist( lnva_equipment ) > 0 then
//												ls_powerunit = this.of_GetEquipmentdescription( lnva_equipment, 'POWERUNIT')
//												lnv_AmountOwed.of_SetTruck ( ls_powerunit )
//												ls_trailer = this.of_GetEquipmentdescription( lnva_equipment, 'TRAILER')
//												lnv_AmountOwed.of_SetTrailer ( ls_trailer )
//												ls_container = this.of_GetEquipmentdescription( lnva_equipment, 'CONTAINER')
//												lnv_AmountOwed.of_SetContainer ( ls_container )
//											end if

											//powerunit	
											lsa_List = lsa_blank
											ll_listcount = 0
											for ll_SplitIndex = 1 to ll_splitcount		
												ls_value = lnva_splitevent[ll_SplitIndex].of_GetPowerUnit ( )
												if len(trim(ls_value)) > 0 then
													ll_listcount ++
													lsa_list[ll_listcount] = ls_value
												end if
											next
											ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
											for ll_count = 1 to ll_max
												if len(trim(ls_powerunit)) > 0 then
													ls_powerunit += ', '
												end if
												ls_powerunit += lsa_List[ll_count]			
											next
											lnv_AmountOwed.of_SetTruck ( ls_powerunit )
							
											//trailer		
											lsa_List = lsa_blank
											ll_listcount = 0
											for ll_SplitIndex = 1 to ll_splitcount						
												ls_value = lnva_splitevent[ll_SplitIndex].of_GetTrailerList ( )
												if len(trim(ls_value)) > 0 then
													ll_listcount ++
													lsa_list[ll_listcount] = ls_value
												end if
											next
											ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
											for ll_count = 1 to ll_max
												if len(trim(ls_trailer)) > 0 then
													ls_trailer += ', '
												end if
												ls_trailer += lsa_List[ll_count]			
											next
											lnv_AmountOwed.of_SetTrailer ( ls_trailer )
							
											//container
											lsa_List = lsa_blank
											ll_listcount = 0
											for ll_SplitIndex = 1 to ll_splitcount		
												ls_value = lnva_splitevent[ll_SplitIndex].of_GetcontainerList ( )
												if len(trim(ls_value)) > 0 then
													ll_listcount ++
													lsa_list[ll_listcount] = ls_value
												end if
											next
											ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
											for ll_count = 1 to ll_max
												if len(trim(ls_container)) > 0 then
													ls_container += ', '
												end if
												ls_container += lsa_List[ll_count]			
											next
											lnv_AmountOwed.of_SetContainer ( ls_container )

										END IF 
										
										//the paysplits will be spread over shipment events that are in the drivers itinerary 
										lds_PaySplitCache = anv_transactionmanager.of_GetPaySplitCache(true)
										this.of_AddShipmentPaySplits(lnva_splitevent, lnv_AmountOwed, lds_PaySplitCache, lnva_Item[ll_Index2].of_GetType())
										anv_transactionmanager.of_SetPaySplitCache(lds_PaySplitCache)
									end if
									DESTROY lnv_ratedata	//dek 6-8-07  this could have been a memory leak.
								END IF
							CASE ELSE // error
								// NOP
						END CHOOSE	
						
						IF ll_Return = -1 THEN
							EXIT
						END IF
						
					NEXT	//item
					
				case appeon_constant.cs_PayableFormat_Category
					lc_amount = lnv_Shipment.of_getfreightpayable()
					//FREIGHT
					if lc_amount > 0 then
						//default freight amount type
						if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
							li_amounttype = integer(la_value)
						end if

						lnva_splitevent = lnva_BlankEvent
						for ll_splitcount = 1 to ll_shipeventcount
							if lnv_ArraySrv.of_findlong(lla_Eventid, lla_shipevent[ll_splitcount], 1, ll_eventcount) > 0 then
								//found
								lnva_splitevent[upperbound(lnva_splitevent) + 1] = lnva_Event[ll_splitcount]
							end if										
						next
						
						if upperbound(lnva_splitevent) > 0 then
							//create amount owed
							ls_Description = "Shipment Freight Pay"
							lc_rate = lc_amount
							lc_quantity = 1							
							lnv_AmountOwed = lnv_NullAmountOwed
							IF of_GenerateAmountOwed(lnv_Nulltransaction, anv_transactionmanager, li_AmountType, &
															ls_Description, lnv_amountowed, lc_amount, lc_rate, lc_quantity) < 0 THEN
								ll_return = -1 
								EXIT
							END IF
							IF IsValid(lnv_amountOwed) THEN
								IF ll_TransactionId > 0 THEN
									lnv_AmountOwed.of_SetFKTransaction_Direct(ll_TransactionID)
									ll_CountAOwed ++
								END IF 
								
								lnv_AmountOwed.of_SetStartDate (ad_start)
								lnv_AmountOwed.of_SetEndDate (ad_end)												
								lnv_AmountOwed.of_SetShipment ( string(lnv_Shipment.of_getid()) )	
								
								//put shipment origin and dest in public note
								if lnv_Shipment.of_getOrigin(lnv_company,TRUE) = 1 then
									ls_coinfo = lnv_company.of_getname()
									if len(trim(ls_coinfo)) > 0 then
										ls_Value = 'Ship Orig: '  +  ls_coinfo
									end if
									ls_coinfo = lnv_company.of_getlocation()
									if len(trim(ls_coinfo)) > 0 then
										ls_value += ' ' + ls_coinfo
									end if
								end if
								if lnv_Shipment.of_getDestination(lnv_company,TRUE) = 1 then
									ls_coinfo = lnv_company.of_getname()
									if len(trim(ls_coinfo)) > 0 then
										ls_value +=  ' Ship Dest: ' + ls_coinfo
									end if
									ls_coinfo = lnv_company.of_getlocation()
									if len(trim(ls_coinfo)) > 0 then
										ls_value += ' ' + ls_coinfo
									end if
								end if										
								IF len ( ls_Value ) > 0 THEN
									lnv_AmountOwed.of_SetPublicNote ( ls_Value )
								END IF	
								
								ls_Value = anv_Itinerary.of_GetDriverList ( )
								IF len ( ls_Value ) > 0 THEN
									lnv_AmountOwed.of_SetDriver ( ls_Value )	
								END IF
								
								ls_powerunit=''
								ls_trailer = ''
								ls_container = ''
								lnv_Arraysrv.of_destroy(lnva_equipment)
								lnva_equipment = lnva_BlankEquipment

								if lnv_Shipment.of_getequipmentlist( lnva_equipment ) > 0 then
									ls_powerunit = this.of_GetEquipmentdescription( lnva_equipment, 'POWERUNIT')
									lnv_AmountOwed.of_SetTruck ( ls_powerunit )
									ls_trailer = this.of_GetEquipmentdescription( lnva_equipment, 'TRAILER')
									lnv_AmountOwed.of_SetTrailer ( ls_trailer )
									ls_container = this.of_GetEquipmentdescription( lnva_equipment, 'CONTAINER')
									lnv_AmountOwed.of_SetContainer ( ls_container )
								end if

							END IF 
							
							//the paysplits will be spread over shipment events that are in the drivers
							// itinerary based on the following
							lds_PaySplitCache = anv_transactionmanager.of_GetPaySplitCache(true)
							this.of_AddShipmentPaySplits(lnva_splitevent, lnv_AmountOwed, lds_PaySplitCache, n_cst_constants.cs_itemtype_freight)
							anv_transactionmanager.of_SetPaySplitCache(lds_PaySplitCache)

						end if
						
					end if
					
					lc_amount = lnv_Shipment.of_getaccessorialpayable()		
					//ACCESS
					if lc_amount > 0 then
						//Default Accessorial Amount Type
						if lnv_Settings.of_GetSetting ( 99 , la_value ) > 0 then
							li_amounttype = integer(la_value)
						end if

						lnva_splitevent = lnva_BlankEvent
						for ll_splitcount = 1 to ll_shipeventcount
							if lnv_ArraySrv.of_findlong(lla_Eventid, lla_shipevent[ll_splitcount], 1, ll_eventcount) > 0 then
								//found
								lnva_splitevent[upperbound(lnva_splitevent) + 1] = lnva_Event[ll_splitcount]
							end if										
						next
						
						if upperbound(lnva_splitevent) > 0 then
							//create amount owed
							ls_Description = "Shipment Accessorial Pay"
							lc_rate = lc_amount
							lc_quantity = 1							
							lnv_AmountOwed = lnv_NullAmountOwed
							IF of_GenerateAmountOwed(lnv_Nulltransaction, anv_transactionmanager, li_AmountType, &
														ls_Description, lnv_amountowed, lc_amount, lc_rate, lc_quantity) < 0 THEN
								ll_return = -1 
								EXIT
							END IF
							IF IsValid(lnv_amountOwed) THEN
								IF ll_TransactionId > 0 THEN
									lnv_AmountOwed.of_SetFKTransaction_Direct(ll_TransactionID)
									ll_CountAOwed ++
								END IF 
								
								lnv_AmountOwed.of_SetDescription ( ls_Description )
								lnv_AmountOwed.of_SetDivision(this.of_GetDivision(lnv_shipment))
								lnv_AmountOwed.of_SetStartDate (ad_start)
								lnv_AmountOwed.of_SetEndDate (ad_end)												
								lnv_AmountOwed.of_SetShipment ( string(lnv_Shipment.of_getid()) )	
								
								//put shipment origin and dest in public note
								if lnv_Shipment.of_getOrigin(lnv_company,TRUE) = 1 then
									ls_coinfo = lnv_company.of_getname()
									if len(trim(ls_coinfo)) > 0 then
										ls_Value = 'Ship Orig: '  +  ls_coinfo
									end if
									ls_coinfo = lnv_company.of_getlocation()
									if len(trim(ls_coinfo)) > 0 then
										ls_value += ' ' + ls_coinfo
									end if
								end if
								if lnv_Shipment.of_getDestination(lnv_company,TRUE) = 1 then
									ls_coinfo = lnv_company.of_getname()
									if len(trim(ls_coinfo)) > 0 then
										ls_value +=  ' Ship Dest: ' + ls_coinfo
									end if
									ls_coinfo = lnv_company.of_getlocation()
									if len(trim(ls_coinfo)) > 0 then
										ls_value += ' ' + ls_coinfo
									end if
								end if										
								IF len ( ls_Value ) > 0 THEN
									lnv_AmountOwed.of_SetPublicNote ( ls_Value )
								END IF												
								
								ls_Value = anv_Itinerary.of_GetDriverList ( )
								IF len ( ls_Value ) > 0 THEN
									lnv_AmountOwed.of_SetDriver ( ls_Value )	
								END IF
								
								ls_powerunit=''
								ls_trailer = ''
								ls_container = ''
								lnv_Arraysrv.of_destroy(lnva_equipment)
								lnva_equipment = lnva_BlankEquipment

								if lnv_Shipment.of_getequipmentlist( lnva_equipment ) > 0 then
									ls_powerunit = this.of_GetEquipmentdescription( lnva_equipment, 'POWERUNIT')
									lnv_AmountOwed.of_SetTruck ( ls_powerunit )
									ls_trailer = this.of_GetEquipmentdescription( lnva_equipment, 'TRAILER')
									lnv_AmountOwed.of_SetTrailer ( ls_trailer )
									ls_container = this.of_GetEquipmentdescription( lnva_equipment, 'CONTAINER')
									lnv_AmountOwed.of_SetContainer ( ls_container )
								end if

							END IF 
							
							//the paysplits will be spread over shipment events that are in the drivers
							// itinerary based on the following
							lds_PaySplitCache = anv_transactionmanager.of_GetPaySplitCache(true)
							this.of_AddShipmentPaySplits(lnva_splitevent, lnv_AmountOwed, lds_PaySplitCache, n_cst_constants.cs_itemtype_accessorial)
							anv_transactionmanager.of_SetPaySplitCache(lds_PaySplitCache)
						end if
		
					end if		
					
				case appeon_constant.cs_PayableFormat_Total
					lc_amount = lnv_Shipment.of_Getpayabletotal()	
					IF lc_amount > 0 THEN
						//grand total goes to default freight account
						if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
							li_amounttype = integer(la_value)
						end if
						
						lnva_splitevent = lnva_BlankEvent
						for ll_splitcount = 1 to ll_shipeventcount
							if lnv_ArraySrv.of_findlong(lla_Eventid, lla_shipevent[ll_splitcount], 1, ll_eventcount) > 0 then
								//found
								lnva_splitevent[upperbound(lnva_splitevent) + 1] = lnva_Event[ll_splitcount]
							end if										
						next
						
						if upperbound(lnva_splitevent) > 0 then

							//create amount owed
							ls_Description = "Shipment Grand Total Pay"
							lc_rate = lc_amount
							lc_quantity = 1							
							lnv_AmountOwed = lnv_NullAmountOwed
							IF of_GenerateAmountOwed(lnv_Nulltransaction, anv_transactionmanager, li_AmountType, &
														ls_Description, lnv_amountowed, lc_amount, lc_rate, lc_quantity) < 0 THEN
								ll_return = -1 
								EXIT
							END IF
							IF IsValid(lnv_amountOwed) THEN
								IF ll_TransactionId > 0 THEN
									lnv_AmountOwed.of_SetFKTransaction_Direct(ll_TransactionID)
									ll_CountAOwed ++
								END IF 
								
								lnv_AmountOwed.of_SetDescription ( ls_Description )
								lnv_AmountOwed.of_SetDivision(this.of_GetDivision(lnv_shipment))
								lnv_AmountOwed.of_SetStartDate (ad_start)
								lnv_AmountOwed.of_SetEndDate (ad_end)												
								lnv_AmountOwed.of_SetShipment ( string(lnv_Shipment.of_getid()) )	
								
								//put shipment origin and dest in public note
								if lnv_Shipment.of_getOrigin(lnv_company,TRUE) = 1 then
									ls_coinfo = lnv_company.of_getname()
									if len(trim(ls_coinfo)) > 0 then
										ls_Value = 'Ship Orig: '  +  ls_coinfo
									end if
									ls_coinfo = lnv_company.of_getlocation()
									if len(trim(ls_coinfo)) > 0 then
										ls_value += ' ' + ls_coinfo
									end if
								end if
								if lnv_Shipment.of_getDestination(lnv_company,TRUE) = 1 then
									ls_coinfo = lnv_company.of_getname()
									if len(trim(ls_coinfo)) > 0 then
										ls_value +=  ' Ship Dest: ' + ls_coinfo
									end if
									ls_coinfo = lnv_company.of_getlocation()
									if len(trim(ls_coinfo)) > 0 then
										ls_value += ' ' + ls_coinfo
									end if
								end if										
								IF len ( ls_Value ) > 0 THEN
									lnv_AmountOwed.of_SetPublicNote ( ls_Value )
								END IF												
															
								ls_Value = anv_Itinerary.of_GetDriverList ( )
								IF len ( ls_Value ) > 0 THEN
									lnv_AmountOwed.of_SetDriver ( ls_Value )	
								END IF
								
								ls_powerunit=''
								ls_trailer = ''
								ls_container = ''
								lnv_Arraysrv.of_destroy(lnva_equipment)
								lnva_equipment = lnva_BlankEquipment

								if lnv_Shipment.of_getequipmentlist( lnva_equipment ) > 0 then
									ls_powerunit = this.of_GetEquipmentdescription( lnva_equipment, 'POWERUNIT')
									lnv_AmountOwed.of_SetTruck ( ls_powerunit )
									ls_trailer = this.of_GetEquipmentdescription( lnva_equipment, 'TRAILER')
									lnv_AmountOwed.of_SetTrailer ( ls_trailer )
									ls_container = this.of_GetEquipmentdescription( lnva_equipment, 'CONTAINER')
									lnv_AmountOwed.of_SetContainer ( ls_container )
								end if

							END IF 
							
							//the paysplits will be spread over shipment events that are in the drivers
							// itinerary based on the following
							lds_PaySplitCache = anv_transactionmanager.of_GetPaySplitCache(true)
							this.of_AddShipmentPaySplits(lnva_splitevent, lnv_AmountOwed, lds_PaySplitCache, n_cst_constants.cs_itemtype_freight)

							anv_transactionmanager.of_SetPaySplitCache(lds_PaySplitCache)
							
						end if		
					end if
											
			end choose
										
			IF ll_Return = -1 THEN
				EXIT
			END IF

		NEXT	// shipment
		
		DESTROY lnv_Shipment

	END IF
END IF

IF IsValid(anv_Transaction) THEN
	anv_Transaction.of_Calculate()
END IF

ll_ItemCount = upperbound(lnva_item)
//left over items
for ll_Index2 = 1 to ll_ItemCount
	if isvalid(lnva_item[ll_Index2]) then
		destroy lnva_item[ll_Index2]
	end if
next

if isvalid(lnv_company) then
	destroy lnv_company
end if

IF ll_Return = -1 THEN
	this.of_insertErrorMsg(ls_ErrMsg)		
else
	al_countao = ll_CountAOwed
END IF

return ll_return

end function

public function integer of_generateamountowed (ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, integer ai_amounttype, string as_description, ref n_cst_beo_amountowed anv_amountowed, decimal ac_amount, decimal ac_rate, decimal ac_quantity);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GenerateAmountOwed
//  
//	Access:  public
//
//	Arguments: 
//					an_transaction by reference, output
//					anv_transactionmanager by reference, input
//					ai_amounttype
//					as_description
//					anv_amountowed, by reference, output
//					ac_amount
//					ac_rate
//					ac_quantity
//					
//
//	Return:		ll_Return    
//					Results are actually stored in an_transaction. 
//						This is one row in the transaction table; 
//						one row for each truck driver
//						
//
//	Description:
//			for n_cst_bso_payable
//
//  This method creates amount owed for accessorial autogen processing.
//  Normal creation of amount oweds thru existing code requires an
//  amount template.  Accessorials are not attached to an amount template.
//
//  Needs to have a null transaction as incoming for performance reasons.
// 
// Written by: J. Albert
// 		Date: 11.18.02
//		Version:  1.0, initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

integer	li_Division, &
		li_Return

long	ll_Return=1, &
		ll_TransactionID
		
string	ls_ErrMsg		

n_cst_beo_AmountOwed	lnv_AmountOwed
n_Cst_beo_AmountType lnv_AmountType
n_cst_OFRError	lnv_Error

//lnv_AmountType = CREATE n_cst_beo_AmountType
//  Sets the id, the transaction Id to null, sets default entity, default category,
//  & division from the entity id
IF IsValid(an_Transaction) THEN
	lnv_AmountOwed = anv_Transactionmanager.of_NewAmountOwed(an_Transaction)
ELSE
	lnv_AmountOwed = anv_TransactionManager.of_NewAmountOwed()
END IF

// Now go set the other fields in the amount owed. 
// 
IF IsValid(lnv_AmountOwed) THEN
	// sets start date, end date, public note, driver, truck, trailer, container,
	// & shipment.
	//no itinerary data for these amounts
//	anv_TransactionManager.of_AmountowedItineraryData(lnv_AmountOwed)

	li_Return = lnv_AmountOwed.of_SetType(ai_AmountType)
	
	IF lnv_AmountOwed.getErrorcount( ) > 0 THEN
		THIS.Propagateerrors( lnv_AmountOwed )
	END IF
	
	IF li_Return >= 0 THEN
		li_Return = lnv_AmountOwed.of_setDescription(trim(as_Description))
	END IF
	// amount, rate, quantity
	IF li_Return >= 0 THEN
		li_Return = lnv_AmountOwed.of_SetAmount(ac_amount)
	END IF
	IF li_Return >= 0 THEN	
		li_Return = lnv_AmountOwed.of_SetRate(ac_Rate)
	END IF
	IF li_Return >= 0 THEN	
		li_Return = lnv_AmountOwed.of_SetQuantity(ac_Quantity)
	END IF
	// status, open
	IF li_Return >= 0 THEN	
		li_Return = lnv_AmountOwed.of_SetStatus(n_cst_beo_amountowed.ci_status_open)
	END IF
	IF li_Return >= 0 THEN	
		li_Return = lnv_AmountOwed.of_setOpen(TRUE)
	END IF
	//taxable
	IF li_Return >= 0 THEN	
	// taxable - 
		if this.of_getamounttype(lnv_AmountType, ai_Amounttype) < 0 THEN
			ll_Return = -1
		END IF
		IF ll_Return > 0 and IsValid(lnv_AmountType) THEN			
			li_Return= lnv_AmountOwed.of_SetTaxable(lnv_AmountType.of_getTaxableDefault())
		ELSE 
			li_Return = -1
		END IF	
	END IF
	
	lnv_AmountOwed.of_SetLastModifiedby(gnv_app.of_Getuserid())

ELSE  // invalid amount owed
	li_Return = -1	
END IF // valid amount owed??
	
IF li_Return < 0 or ll_Return < 0 THEN
	ls_ErrMsg = "10871|Could not create an amount owed for the autogen settlement."
	IF IsValid(lnv_Error) THEN
		lnv_Error.SetErrorMessage(ls_ErrMsg)
	ll_Return = -1
	END IF	
END IF

anv_amountowed = lnv_amountowed
Return ll_Return
end function

public function long of_getshipmentitems (n_cst_bso_dispatch anv_dispatch, n_cst_beo_shipment anv_shipbeo, string as_eventtype, string as_itemtype, ref n_cst_beo_item anva_item[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetShipmentItems
//  
//	Access		:public
//
//	Arguments	:anv_dispatch
//					 anv_shipbeo
//					 as_eventtype
//					 as_itemtype
//					 anva_item[] by reference
//
//	Return		:long
//					 numeber of items in array
//						
//	Description	:look for split bills, these items need to be included with parent items
//						
//
//
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
// -- added only if the child is Non-Routed <<*>> 7/15/05
//
//	
//////////////////////////////////////////////////////////////////////////////
//


long	ll_return, &
		ll_shipid, &
		lla_child[], &
		ll_index, &
		ll_max, &
		ll_beocount, &		
		ll_itemcount, &
		ll_childndx, &
		ll_childcount
		
n_cst_beo_item		lnva_shipitem[], &
						lnva_shipchilditem[], &
						lnva_blankitem[]
						
n_ds					lds_ItemCache, &
						lds_ShipmentCache
						
n_cst_beo_shipment	lnv_shipmentchild

lnv_shipmentchild = create n_cst_beo_shipment

ll_itemcount = upperbound(anva_item)

//clear out items
for ll_index = 1 to ll_itemcount
	if isvalid(anva_item[ll_index]) then
		destroy anva_item[ll_index]
	end if
next
anva_item = lnva_blankitem

//get new shipment items
ll_shipid = anv_shipbeo.of_Getid()
choose case as_itemtype
	case n_cst_constants.cs_ItemType_Freight, n_cst_constants.cs_ItemType_Accessorial
		ll_itemcount = anv_shipbeo.of_GetItemList(lnva_shipItem, as_itemtype) 
	case "SHIPMENTPAY"
		ll_itemcount = anv_shipbeo.of_GetItemList(lnva_shipItem)
	case else //itembyeventtype
		ll_itemcount = anv_shipbeo.of_GetItemsForEventType(as_eventtype, lnva_shipItem)
end choose

for ll_index = 1 to ll_itemcount
	ll_beocount ++
	anva_item[ll_beocount] = lnva_shipItem[ll_index]
next

//check for split bills ( child shipments )
if anv_Dispatch.of_getshipmentchild({ll_shipid}, lla_child) = 1 then
	ll_childcount = upperbound(lla_child) 
else
	ll_childcount = 0
end if

//if we have any then get their items
for ll_childndx = 1 to ll_childcount
		
	anv_Dispatch.of_RetrieveShipment ( lla_child[ll_childndx] )
	
	lds_ItemCache = anv_Dispatch.of_GetItemCache ( )				
	lds_ShipmentCache = anv_Dispatch.of_GetShipmentCache ( )
	
	lnv_shipmentchild.of_SetSourceid (lla_child[ll_childndx])
	lnv_shipmentchild.of_SetSource ( lds_shipmentCache )
	lnv_shipmentchild.of_SetItemSource ( lds_ItemCache )
	
	IF lnv_shipmentchild.of_IsNonrouted( ) THEN //<<*>> 7/15/05
	
		choose case as_itemtype
			case n_cst_constants.cs_ItemType_Freight, n_cst_constants.cs_ItemType_Accessorial
				ll_itemcount = lnv_shipmentchild.of_GetItemList(lnva_shipchildItem, as_itemtype)
			case "SHIPMENTPAY"
				ll_itemcount = lnv_shipmentchild.of_GetItemList(lnva_shipchildItem)
			case else//itembyeventtype
				ll_itemcount = lnv_shipmentchild.of_GetItemsForEventType(as_eventtype, lnva_shipchildItem)
		end choose
		
		for ll_index = 1 to ll_itemcount
			if isvalid(lnva_shipchildItem[ll_index]) then
				ll_beocount ++
				anva_item[ll_beocount] = lnva_shipchildItem[ll_index]
			end if
		next	
		
	END IF
	
next

destroy lnv_shipmentchild

return upperbound(anva_item)
end function

public function long of_generateaccessamount (n_cst_bso_transactionmanager anv_transactionmanager, n_cst_beo_event anv_event);long		ll_return, &
			ll_value, &
			ll_nextid, &
			ll_PaySplitRow
	
decimal	lc_Amount

string	ls_value

n_ds	lds_PaySplitCache

n_cst_beo_transaction	lnv_nulltransaction
n_cst_beo_amountowed		lnv_amountowed
n_cst_EmployeeManager	lnv_EmployeeManager

ll_Return = of_GenerateAmountOwed(lnv_Nulltransaction, anv_transactionmanager, &
						ii_AmountType, is_Description, lnv_amountowed, ic_amount, ic_rate, ic_quantity)
									
IF ll_Return > 0 THEN 
	IF IsValid(lnv_amountOwed) THEN
		IF NOT IsNull(il_TransactionId) THEN
			lnv_AmountOwed.of_SetFKTransaction_Direct(il_TransactionID)
		END IF 
		lnv_AmountOwed.of_SetDivision(il_division)
		lnv_AmountOwed.of_SetStartDate ( anv_Event.of_GetDateArrived() )
		lnv_AmountOwed.of_SetEndDate ( anv_Event.of_GetDateArrived() )
		lnv_AmountOwed.of_SetRateCodename(is_RateCodename)
		lnv_AmountOwed.of_SetOriginzone(is_Originzone)
		lnv_AmountOwed.of_SetDestinationzone(is_Destinationzone)
		lnv_AmountOwed.of_SetbilltoId(il_billtoId)
		
		lnv_AmountOwed.of_SetShipment ( string(il_shipid) ) //parent shipment

		if isvalid(anv_event) then
			ls_Value = anv_Event.of_GetLocation ( )
			IF len ( ls_Value ) > 0 THEN
				lnv_AmountOwed.of_SetPublicNote ( ls_Value )
			END IF
		
			ls_Value = anv_Event.of_GetPowerUnit ( )
			IF len ( ls_Value ) > 0 THEN
				lnv_AmountOwed.of_SetTruck ( ls_Value )
			END IF
			
			ls_Value = anv_Event.of_GetTrailerList ( )
			IF len ( ls_Value ) > 0 THEN
				lnv_AmountOwed.of_SetTrailer ( ls_Value )
			END IF
			
			ls_Value = anv_Event.of_GetcontainerList( )
			IF len ( ls_Value ) > 0 THEN
				lnv_AmountOwed.of_SetContainer ( ls_Value )
			END IF

			ll_Value = anv_Event.of_GetDriverid( )
			if ll_value > 0 then
				lnv_EmployeeManager.of_DescribeEmployee ( ll_value, ls_value, &
																appeon_constant.ci_DescribeType_LastFirst )
			end if

			IF len ( ls_Value ) > 0 THEN
				lnv_AmountOwed.of_SetDriver ( ls_Value )
			END IF
		end if
		
	END IF // valid amount owed
END IF

IF ic_Amount > 0 THEN  
	lds_PaySplitCache = anv_transactionmanager.of_GetPaySplitCache(TRUE)

	ll_PaySplitRow = lds_PaySplitCache.InsertRow(0)
	IF ll_PaySplitRow > 0 THEN
	  IF gnv_App.of_GetNextId("paysplit",ll_NextId, TRUE) = 1 THEN
		 lds_PaySplitCache.object.id[ll_PaySplitRow] = ll_NextId
		 lds_PaySplitCache.object.amountid[ll_PaySplitRow] =lnv_Amountowed.of_getId()
		 lds_PaySplitCache.object.eventid[ll_PaySplitRow] = anv_event.of_getid()
		 lds_PaySplitCache.object.shipmentid[ll_PaySplitRow] =il_shipid
		 //turned off
			lds_PaySplitCache.object.paysplit[ll_PaySplitRow] = ic_amount		
			lds_PaySplitCache.object.itemtype[ll_PaySplitRow] = n_cst_constants.cs_itemtype_accessorial
						
	  END IF
	END IF  
end if

return ll_return
end function

public function long of_processaccessorial (n_cst_beo_amounttemplate anva_movetemplate[], ref n_cst_beo_transaction an_transaction, n_cst_beo_itinerary2 anv_itinerary, n_cst_beo_entity anv_entity, ref n_cst_bso_transactionmanager anv_transactionmanager, n_cst_bso_dispatch anv_dispatch, ref long al_countao, date ad_start, date ad_end);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ProcessAccessorial
//  
//	Access:  public
//
//	Arguments: 
//					anva_amounttemplate
//					an_transaction by reference, output
//					anv_itinerary
//					anv_entity
//					anv_transactionmanager by reference, input
//					anv_dispatch
//					al_CountAO by reference, output - count of amount oweds generated
//					ad_start
//					ad_end
//
//	Return:		ll_Return    
//					Results are actually stored in an_transaction. 
//						This is one row in the transaction table; 
//						one row for each truck driver
//						
//
//	Description:
//			for n_cst_bso_payable
//
//  This process runs after the other pieces of autogen have run. 
//  The goal is to generate pay for accessorials. If the system
//  setting is "YES!" to generate accessorials, get all the events
//  for this entity (truck driver) for the date range selected by the 
//  user (start and end date).  Also using this itinerary, get all the 
//  shipment ids.  Taking the shipment ids go to the dispatch object to 
//  retrieve the shipments.  Filter the shipments. Get the item cache
//  from the dispatch object and create an array of item beo's from the
//  cache.  Look at each item in the array; keep the ones that have a
//  type of 'accessorial' and and accounting type of'payable' or 'both'.
//   For the item beo's that were kept, see if the event belonging to it
//  is in the collected list of events.  If yes, pay the driver for it 
//  based on the value in the amount; if no, go to next event; 
//  if null, create a zero amount owed. 
// 
//  All errors for this code should be within 00800-00899 for informational
//  errors and 10800-10899 for severe errors.
//
// Written by: J. Albert
// 		Date: 11.16.02
//		Version:  1.0, initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
any	la_SysSettingValue

boolean 	lb_Created, &
			lb_CreatedAOwedForItem, &
			lb_notemplate, &
			lb_rateit
			
decimal	lc_null, &
			lc_percentage, &
			lc_miles
			
long 	ll_Return=1, &
		ll_EntityId, &
		ll_CountAOwed, &
		ll_EventId, &
		lla_EventIds[], &
		lla_ShipmentIds[], &
		ll_Counter, &
		ll_ItemCounterMax, &
		ll_EventCounterMax, &
		ll_EventCounter, &
		ll_ShipCounterMax, &
		ll_Index, &
		ll_TransactionId, &
		ll_AmountCounter, &
		ll_Template, &
		ll_TemplateCount

string	ls_Accessorial, &
			ls_Errmsg, &
			ls_ratecode, &
			ls_shipmovecode
			
n_ds	lds_EventCopy

datastore lds_Cache, &
			lds_ItemCache, &
			lds_EventCache
			
s_parm	lstr_Parm
n_cst_msg	lnv_Range
n_cst_dws	lnv_dws
n_cst_beo_event	lnv_event			
n_cst_beo_shipment	lnv_shipment
n_cst_beo_item			lnva_Item[]
n_cst_beo_itinerary2	lnv_itinerary
n_cst_beo_amounttype	lnv_AmountType
n_cst_OFRError	lnv_Error, &
					lnva_Error[]
n_cst_Settings	lnv_Settings
n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_bso_rating	lnv_rating
n_cst_ratedata		lnva_ratedata[], &
						lnva_blankratedata[], &
						lnv_ratedata

setnull(lc_null)

CHOOSE CASE lnv_Settings.of_GetSetting(126,la_SysSettingValue)
	CASE 0
		lb_Created = FALSE
	CASE 1
		ls_Accessorial = string(la_SysSettingValue)
		CHOOSE CASE ls_Accessorial
			CASE "YES!"
				lb_Created = TRUE
			CASE "NO!"
				lb_Created = FALSE
			CASE ELSE				
				lb_Created = FALSE
		END CHOOSE
	CASE ELSE
		lb_Created = FALSE
END CHOOSE

IF lb_Created = TRUE THEN // Generate accessorial pay for this entity (truck driver).

	ll_TemplateCount= upperbound(anva_MoveTemplate)

	lnv_Event = CREATE n_cst_Beo_Event
	// No amount template is needed.
	// Validate itinerary.  If none, stop
	IF IsValid(anv_Itinerary) THEN
		lnv_itinerary = anv_itinerary
		//SetRange before getting in here	
	ELSE
		ll_Return = -1
		ls_ErrMsg = "10813|Itineray object is not available"
	END IF
	
	IF ll_Return = 1 THEN
		IF IsValid(anv_TransactionManager) THEN
		ELSE
			ll_Return = -1
			ls_ErrMsg = "10823|Transaction Manager is missing."
		END IF
	END IF
	
	IF ll_Return = 1 THEN
		ll_EntityID= anv_TransactionManager.of_GetDefaultEntityId()
		IF (IsNull(anv_Entity) or ll_EntityId = 0) THEN
			ll_Return = -1
			ls_ErrMsg = "10833|The entity identifier has been corrupted."
		END IF
	END IF
	IF ll_Return = 1 THEN
		If IsValid(an_Transaction) THEN
			il_TransactionId = an_Transaction.of_getId()
			If IsNull(an_transaction.of_GetStartDate()) &
			OR IsNull(an_transaction.of_GetEndDate()) THEN
				an_transaction.of_SetStartDate(id_Start)
				an_transaction.of_SetEndDate(id_End)
			END IF
		ELSE // not valid transaction object
			ll_REturn = -1
			ls_ErrMsg = "10843|This transaction object is corrupted."
		END IF
	END IF
	
	IF ll_Return = 1 THEN
		If IsValid(anv_Dispatch) THEN
			//ok
		ELSE
			ll_REturn = -1
			ls_ErrMsg = "10847|This dispatch object is corrupted."
		END IF
	END IF
	
	IF ll_Return = 1 THEN
		ll_EventCounterMax = lnv_itinerary.of_geteventIds(lla_eventIds)
		IF ll_EventCounterMax > 0 THEN
			//ok we have events
		ELSE
			ll_Return = -1
			ls_ErrMsg = "10855|Could not obtain any event ids from the itinerary."
		END IF
	END IF
	
	IF ll_Return = 1 THEN
		ll_ShipCounterMax = lnv_itinerary.of_getShipmentIds(lla_ShipmentIds, TRUE /*lb_ShrinkNulls */, &
			TRUE /*lb_ShrinkDupes */, false /* Use Exclude */)
		IF ll_ShipCounterMax > 0 THEN
			//we have shipments
		ELSE
			ll_Return = -1
//			ls_ErrMsg = "00859|Could not obtain any shipment ids from the itinerary."
		END IF
		
		
	END IF	
	IF ll_Return = 1 THEN
		IF anv_dispatch.of_RetrieveShipments(lla_ShipmentIds) < 0 THEN
			ll_Return = -1
			ls_ErrMsg = "10871|Could not obtain any shipment ids from the dispatch."
		ELSE
			
			lds_Cache = anv_Dispatch.of_GetShipmentCache()
			lds_ItemCache = anv_Dispatch.of_GetItemCache()
			lds_EventCache = anv_Dispatch.of_GetEventCache()
	
			lnv_Dws.of_CreateDataStoreByDataObject ( "d_itin", lds_eventcopy, TRUE )
			lds_eventcache.rowscopy(1, lds_eventcache.rowcount(), Primary!, lds_eventcopy, 1, Primary!)
			lds_eventcache.rowscopy(1, lds_eventcache.filteredcount(), Filter!, lds_eventcopy, 1, Filter!)
	
			lnv_shipment = CREATE n_cst_Beo_Shipment
			lnv_shipment.of_SetSource ( lds_Cache )
			lnv_shipment.of_SetItemSource ( lds_ItemCache )
			
			FOR ll_Index = 1 TO ll_ShipCounterMax
				lnv_Shipment.of_SetSourceid(lla_ShipmentIds[ll_Index]) 			
				il_shipid = lla_ShipmentIds[ll_Index]
				ls_ShipMoveCode = lnv_shipment.of_GetMoveCode()	
				IF isValid ( lds_eventcopy ) THEN
					lds_eventcopy.SetFilter ( "de_shipment_id = " + string(lla_ShipmentIds[ll_Index]) )
					lds_eventcopy.SetSort ( "de_ship_seq A" )
					lds_eventcopy.Filter ( )
					lds_eventcopy.Sort ( )
				END IF
					
				lnv_Shipment.of_SetEventSource(lds_eventcopy)
				
				ll_ItemCounterMax = this.of_getshipmentitems(anv_dispatch, lnv_shipment, '', n_cst_constants.cs_ItemType_Accessorial, lnva_item )
				
				FOR ll_Counter = 1 to ll_ItemCounterMaX
	
					is_Description = ''
					is_RateCodename = ''
					is_Originzone = ''
					is_Destinationzone = ''
					il_billtoId = 0
					ic_amount = 0
					ic_rate = 0
					ic_quantity = 0
					ii_AmountType = 0

					lb_CreatedAOwedForItem = FALSE 
					
					if lnva_Item[ll_Counter].of_GetEventTypeFlag () =  n_Cst_Constants.cs_ItemEventType_FuelSurcharge then
						continue
					end if
					
					ii_AmountType = lnva_item[ll_Counter].of_GetAmountType()
					if isnull(ii_AmountType) or ii_AmountType = 0 then
						CONTINUE
					else
						//is it a settlement type
						IF anv_transactionmanager.of_GetAmountType ( ii_AmountType , lnv_AmountType ) = 1 THEN
							choose case lnv_AmountType.of_GetCategory ( )
								case n_cst_constants.ci_category_receivables
									CONTINUE
								case n_cst_constants.ci_category_Payables, n_cst_constants.ci_category_both
									CHOOSE CASE lnva_item[ll_Counter].of_GetAccountingType()	
										CASE n_cst_constants.cs_AccountingType_Billable
											CONTINUE
										CASE n_cst_constants.cs_AccountingType_Payable, n_cst_constants.cs_AccountingType_Both
											//valid item
										CASE ELSE
											CONTINUE
									END CHOOSE
								case else
									CONTINUE
							end choose	
						ELSE
							CONTINUE
						END IF
					end if
							
					IF lnva_Item[ll_Counter].of_IsAccessorial() THEN
						//what about orig/dest
						lnva_Item[ll_Counter].of_SetEventSource(lds_EventCache)
						ll_Return = lnva_Item[ll_Counter].of_GetPickUpEvent()

						//check for autocreated item
//						if lnva_Item[ll_Counter].of_GetEventTypeFlag () =  n_Cst_Constants.cs_ItemEventType_MoveAccessorial then
//							if lnv_shipment.of_IsIntermodal( ) then
//								IF ll_Return < 1 OR IsNULL(ll_Return) then
//									//already paid as freight
//									continue	
//								else
//									//if linked to an event then pay as accessorial
//								end if
//							end if
//						end if
							
						il_division = this.of_GetDivision(lnv_shipment)
						IF ll_Return < 1 OR IsNULL(ll_Return) then
//							or	lnva_item[ll_Counter].Of_GetRateCodeName() = 'CUSTOM'THEN
							// create a zero amount owed because users want to see a zero amount owed if the
							// accessorial did not have a pickup event 
							ic_Amount = 0
							ic_Rate = 0
							ic_Quantity = 0
							is_Description = trim(lnva_item[ll_Counter].of_GetDescription())
							ll_return = this.of_GenerateAccessAmount(anv_transactionmanager, lnv_event)
							if ll_return > 0 then
								ll_CountAOwed += ll_return
							end if
						ELSE
							//getting event from shipment never from child
							if lnv_shipment.of_getevent(ll_return, lnv_event) = 1 then
								if isvalid(lnv_event) then
									ll_EventId = lnv_Event.of_getId()	
								end if
								FOR ll_EventCounter = 1 TO ll_EventCounterMAX
									if lb_CreatedAOwedForItem then
										exit
									end if
									 // check if this event is in our event array
									ic_Amount = 0
									IF ll_EventId = lla_EventIds[ll_EventCounter] THEN
										lb_CreatedAOwedForItem = TRUE
										
										if ll_templatecount = 0 then
											ll_templatecount = 1
											lb_notemplate = true
										end if
										for ll_template = 1 to ll_templatecount
											
											// Set up to create a valid amount owed
											ic_rate = lnva_item[ll_Counter].of_getPayRate() 
											ic_quantity = lnva_item[ll_Counter].of_getQuantity() 							
											ic_amount = lnva_item[ll_Counter].of_getPayableAmount()
											ii_AmountType = lnva_item[ll_Counter].of_GetAmountType()

											if lb_notemplate then
												if ic_amount > 0 then
													//use amount
												else
												// go to rate tables																			
													ls_ratecode = lnva_item[ll_Counter].of_getRatecodename()
													if len(ls_ratecode) > 0 then
														lnv_rating = create n_cst_bso_rating
														if lnv_rating.of_autorate(lnv_Shipment, {lnva_item[ll_Counter]} , &
																		lnva_ratedata, n_cst_constants.ci_category_payables) = 1 then
															IF UpperBound ( lnva_ratedata ) > 0 THEN																		
																if lnva_ratedata[1].of_Getcodename() = 'CUSTOM' then
																	//SKIP
																else
																	if lnva_ratedata[1].of_Getratetype() = appeon_constant.cs_RateUnit_Code_Flat then
																		ic_quantity = 1
																	else
																		ic_Quantity = lnva_ratedata[1].of_GetTotalCount()
																	end if
																	
																	if lnva_ratedata[1].of_usedSubstitution() or lnva_ratedata[1].of_usedfallback() then
																		is_description = lnva_ratedata[1].of_GetDescription()
																	else
																		is_Description = trim(lnva_item[ll_Counter].of_GetDescription())
																	end if
																	ic_rate = lnva_ratedata[1].of_Getrate()
																	ic_amount = lnva_ratedata[1].of_GetTotalCharge()
																	
																	is_RateCodename = lnva_ratedata[1].of_Getcodename()
																	is_Originzone = lnva_ratedata[1].of_GetOriginzone()
																	is_Destinationzone = lnva_ratedata[1].of_GetDestinationzone()
																	il_billtoId = lnva_ratedata[1].of_GetbilltoId()
																	ii_AmountType = lnva_ratedata[1].of_GetAmountType()
																	IF isnull(ii_AmountType) or ii_AmountType = 0 then
																		ii_AmountType = lnva_item[ll_Counter].of_GetAmountType()
																	end if
																end if
															END IF
														else
															IF lnva_item[ll_Counter].Of_GetRateCodeName() = 'CUSTOM'THEN
																//	If we didn't find a rate code and the item rate is 'custom' then ZERO AMOUNT OWED
																ic_Amount = 0
																ic_Rate = 0
																ic_Quantity = 0
																is_Description = trim(lnva_item[ll_Counter].of_GetDescription())
															ELSE
																ic_quantity = lnva_item[ll_Counter].of_getquantity()
																ic_rate = lnva_item[ll_Counter].of_getpayrate()
																ic_amount = lnva_item[ll_Counter].of_getpayableamount()
																ii_AmountType = lnva_item[ll_Counter].of_GetAmountType()
																is_Description = trim(lnva_item[ll_Counter].of_GetDescription())
																end if
														end if
														destroy lnv_rating
														lnv_ArraySrv.of_Destroy ( lnva_RateData )
														lnva_RateData = lnva_blankratedata
													end if	
												end if
											else
												lnv_ratedata = create n_cst_ratedata

												if this.of_setratedata(anva_movetemplate[ll_Template], lnv_shipment, lnva_Item[ll_Counter], &
																	lnv_Ratedata, lnv_event.of_Getsite ( ), lnv_event.of_Getsite ( )) then
													//we have a ratadata object 
													if lnv_Ratedata.of_LookAtShipmentcode() then
														if lnv_ratedata.of_GetAccessPayablePercentage() > 0 then
															//go on to rating section and get percentage of pay on item
															lb_RateIt = true
														else
															//is there pay on the item
															//if the item has a pay amount use it
															if ic_amount > 0 then
																lb_RateIt = false
															else
																lb_RateIt = true
															end if
														end if
													else
														//we have a rate code but not looking at the shipment for pay
														lb_RateIt = true
													end if
												else
													lb_RateIt = false
												end if
												
												if lb_RateIt then
													//  try auto rating with template information
													//set point to point miles
													lc_miles = lnv_itinerary.of_Gettotalmiles()
													if isnull(lc_miles) THEN
														lc_miles = 0
													end if
													lnv_ratedata.of_settotalmiles(lc_miles)	
													lnv_ratedata.of_SetCategory(n_cst_constants.ci_Category_Payables)
													this.of_getratedata(lnv_shipment, lnva_Item[ll_Counter], lnv_Ratedata)
													is_ratecodename = lnv_ratedata.of_GetCodename()
													if len(trim(is_ratecodename)) > 0 then
														//have amount replace 
														ic_rate = lnv_ratedata.of_Getrate()
														ic_amount = lnv_ratedata.of_GetTotalCharge()
														if lnv_ratedata.of_Getratetype() = appeon_constant.cs_RateUnit_Code_Flat then
															ic_quantity = 1
														else
															ic_Quantity = lnv_ratedata.of_GetTotalCount()
														end if
														if lnv_ratedata.of_usedSubstitution() or lnv_ratedata.of_usedfallback() then
															is_description = lnv_ratedata.of_GetDescription()
														else
															is_Description = trim(lnva_item[ll_Counter].of_GetDescription())
														end if
	
														ii_AmountType = lnv_ratedata.of_GetAmountType()
														IF isnull(ii_AmountType) or ii_AmountType = 0 then
															ii_AmountType = lnva_item[ll_Counter].of_GetAmountType()
														end if
														
													else
														//no rate code, use item amounts
														ii_AmountType = lnva_item[ll_Counter].of_GetAmountType()
														ic_amount = lnva_item[ll_Counter].of_GetAccessorialCharges()
														is_Description = trim(lnva_item[ll_Counter].of_GetDescription())
														lc_percentage = lnv_ratedata.of_GetAccessPayablePercentage() / 100
														if lc_percentage > 0 then
															ic_amount = ic_amount * lc_percentage
															ic_quantity = lc_null
															ic_rate = lc_null
														end if
													end if
												end if
											end if
											// create a new amount owed
											is_Description = trim(lnva_item[ll_Counter].of_GetDescription())
											if isnull(ii_AmountType) or ii_AmountType = 0 then
												CONTINUE
											else
												//is it a settlement type
												IF anv_transactionmanager.of_GetAmountType ( ii_AmountType , lnv_AmountType ) = 1 THEN
													choose case lnv_AmountType.of_GetCategory ( )
														case n_cst_constants.ci_category_receivables
															CONTINUE
														case n_cst_constants.ci_category_Payables, n_cst_constants.ci_category_both
															CHOOSE CASE lnva_item[ll_Counter].of_GetAccountingType()	
																CASE n_cst_constants.cs_AccountingType_Billable
																	//don't create amount
																	CONTINUE
																CASE n_cst_constants.cs_AccountingType_Payable, n_cst_constants.cs_AccountingType_Both 	
																	ll_return = this.of_GenerateAccessAmount(anv_transactionmanager, lnv_event)
																	if ll_return > 0 then
																		ll_CountAOwed += ll_return
																	end if
																CASE ELSE
																	//don't create amount
																	CONTINUE
															END CHOOSE
														case else
															//don't create amount
															CONTINUE
													end choose							
												END IF
											END IF
										next //template loop
									END IF
								NEXT  // looping thru events				
							end if							
						END IF
								
					ELSE
						// This item is not an accessorial.
					END IF	
					
				NEXT // looping thru items	

			NEXT // go to next shipment
	
		END IF // ll_Return < 0 - Couldn't retrieve the shipments
		
	 END IF  // Continue process was true.
	 
	an_Transaction.of_Calculate()
	// recalculated the transaction - fix up those null transactions

END IF  // generate accessorial

DESTROY lnv_Shipment
destroy 	lnv_Event

ll_ItemCounterMax = upperbound(lnva_item)
//left over items
for ll_Counter = 1 to ll_ItemCounterMax
	if isvalid(lnva_item[ll_Counter]) then
		destroy lnva_item[ll_Counter]
	end if
next

IF ll_Return = -1 THEN
	this.of_insertErrorMsg(ls_ErrMsg)
END IF
al_CountAO = ll_CountAOwed
Return ll_Return
end function

private function long of_processmoverange (n_cst_beo_event anva_event[], ref n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, long al_firstevent, long al_lastevent, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, n_cst_beo_amounttemplate anva_movetemplate[], string as_eventtype);///////////////////////////////////////////////////////////////////////////////
//
//	Function		:of_ProcessMoveRange
//  
//	Access		:private
//
//	Arguments	:anva_event[]
//					anv_itinerary
//					anv_dispatch
//					al_firstevent
//					al_lastevent
//					an_transaction by reference
//					anv_transactionmanager by reference
//					anva_movetemplates[]
//					as_eventtype
//
//	Return		:ll_Return    
//					 the number of amounts generated
//						
//
//	Description	:Look for shipments in the itinerary range.  Get the items in the
//					 shipment.  The item type must be freight.  If there is a payable 
//					 amount on the item then use it, else try finding it in the rate tables.
//					 If the freight type is standard and the move type is Import or Export 
//					 then divide the pay in half.
//
//
// Written by: N. LeBlanc & J. Albert
// 		Date: 10.11.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//
// 4.0.30  6/7/05  BKW  Added logic to respond to GenerateIfZero = No flag 
//   on move template generation.
//   This will suppress the line item when a rate lookup has been done and
//   the rate comes back zero.  It will NOT suppress the line item when 
//   the rate has not been definitively determined, such as in a "CUSTOM" 
//   rated line item.
//
// 4.0.33  7/5/05 BKW  Fixed memory leak by destroying lnv_RateData within the
//   looping process, as opposed to only once at the end.
//
// The following 2 changes were made to avoid potential double-pay situations:
//
// 4.0.33  7/5/05 BKW  Suppress paying off code substitution for 'CUSTOM' on 
//   secondary freight line items.  Pay will be zeroed out with an explanatory 
//   warning in the internal note field.
//
// 4.0.33  7/5/05 BKW  If pay using the same pay rate code is generated more than
//   once for the same move, zero the additional line items out if it's an intermodal
//   shipment and provide an explanatory warning in internal note, or if it's a 
//   non-intermodal shipment, just provide an explanatory warning in internal note.
//--
// 4.1.13 8/1/06 RPZ Added logic to allow the move processing to pay for chassis positioning when 
//    no chassis pu/rtn line item exists in the shipment. this move must be in the shipment.
//
//
//
//	
//////////////////////////////////////////////////////////////////////////////
//
boolean 	lb_shipfound, &
			lb_ratecode, &
			lb_IsIntermodalShipment  /*Added 4.0.33 7/5/05 BKW*/

integer	li_amounttype, &
			i, &
			j

long		ll_ShipCount, &
			ll_shipId, &
			lla_shipId[], &
			ll_index, &
			ll_Eventndx, &
			ll_Itemndx, &
			ll_ItemCount, &
			ll_Template, &
			ll_TemplateCount, &
			ll_TransactionId, &
			ll_amountcount, &
			lla_amountid[], &
			ll_Max, &
			ll_rowcount, &
			ll_count, &
			ll_value, &
			ll_firstevent, &
			ll_lastevent, &
			ll_listcount, &
			ll_Pickup
			
decimal	lc_Amount, &
			lc_Quantity, &
			lc_rate, &
			lc_payamount, &
			lc_percentage, &
			lc_null, &
			lc_miles

string	ls_ratecodename, &
			ls_ShipMoveCode, &
			ls_value, &
			ls_type, &
			ls_description, &
			ls_publicnote, &
			ls_InternalNote, /*Added 4.0.33 7/5/05 BKW*/ &
			ls_powerunit, &
			ls_container, &
			ls_trailer, &
			ls_driver, &
			lsa_list[], &
			lsa_blank[], &
			ls_RateCodeList,  /*Added 4.0.33 7/5/05 BKW*/ &
			ls_BillingRateCode  /*Added 4.0.33 7/5/05 BKW*/

boolean	lb_RateIt, &
			lb_StandardFreight	//ie. not specials

Long	ll_NewTempItemID


n_ds					lds_ShipmentCache, &
						lds_ItemCache, &
						lds_EventCache, &
						lds_eventcopy
n_ds					lds_paysplitcache
n_cst_dws	lnv_Dws
n_cst_anyarraysrv			lnv_Arraysrv
//n_cst_beo_Amountowed	lnv_Amountowed, &
n_cst_beo_Amountowed	lnva_Amountowed[], &
							lnv_NullAmountOwed
n_cst_beo_shipment	lnv_shipment
n_cst_beo_item			lnva_Item[], &
							lnva_MoveAccessorialItem[]
n_cst_ratedata			lnv_ratedata
n_cst_EmployeeManager	lnv_EmployeeManager
n_cst_beo_AmountType	lnv_AmountType

setnull(lc_null)

ll_firstevent = al_firstevent
ll_lastevent = al_lastevent
//if ll_firstevent = ll_lastevent 	and ll_firstevent > 1 then
if ll_firstevent > 1 then
	ll_firstevent --
end if

If IsValid(an_Transaction) THEN
	ll_TransactionID = an_Transaction.of_GetId()
ELSE
	SetNull(ll_Transactionid)
END IF


//get ship ids from event range
ll_shipcount = 0
for ll_Eventndx = ll_firstevent to ll_lastevent
	ll_ShipId = anva_event[ll_Eventndx].of_GetShipment()
	if isnull(ll_shipid) or ll_shipid = 0 then
		continue
	else
		ll_ShipCount ++
		lla_shipid[ll_ShipCount] = ll_ShipId
	end if	
next
ll_shipcount = lnv_Arraysrv.of_getshrinked(lla_shipid,true,true)

//get shipments and items
anv_Dispatch.of_RetrieveShipments ( lla_ShipId )

lds_ShipmentCache = anv_Dispatch.of_GetShipmentCache ( )
lds_ItemCache = anv_Dispatch.of_GetItemCache ( )				
lds_EventCache = anv_Dispatch.of_GetEventCache ( )		
/*
	using my own copy of the cache for filtering events to the shipment 
	and not including itinerary events for move processing
*/
lnv_Dws.of_CreateDataStoreByDataObject ( "d_itin", lds_eventcopy, TRUE )
lds_eventcache.rowscopy(1, lds_eventcache.rowcount(), Primary!, lds_eventcopy, 1, Primary!)
lds_eventcache.rowscopy(1, lds_eventcache.filteredcount(), Filter!, lds_eventcopy, 1, Filter!)

lnv_shipment = CREATE n_cst_Beo_Shipment
lnv_shipment.of_SetSource ( lds_shipmentCache )
lnv_shipment.of_SetItemSource ( lds_ItemCache )


n_cst_beo_AmountTemplate	lnva_RegularTemplates[]
n_cst_beo_AmountTemplate	lnva_SpecialMove[]
n_cst_beo_AmountTemplate	lnva_Templates[]

THIS.of_Separatespecialtemplates( anva_movetemplate[] , lnva_RegularTemplates, lnva_SpecialMove )

//look for shipments in range
FOR ll_Index = 1 to ll_Shipcount
	
	
	lnva_Templates = lnva_RegularTemplates
	
	lnv_shipment.of_SetSourceid ( lla_ShipId[ll_index] )
	
	IF isValid ( lds_eventcopy ) THEN
		lds_eventcopy.SetFilter ( "de_shipment_id = " + string(lla_ShipId[ll_index]) )
		lds_eventcopy.SetSort ( "de_ship_seq A" )
		lds_eventcopy.Filter ( )
		lds_eventcopy.Sort ( )
	END IF

	lnv_shipment.of_SetEventSource ( lds_eventcopy )
	ls_ShipMoveCode = lnv_shipment.of_GetMoveCode()	
	

	ll_ItemCount = this.of_getshipmentitems(anv_dispatch, lnv_shipment, as_eventtype, '', lnva_item )
	
	/*
		Special processing for paying chassis positions when the move is inside the 
		shipment without any special chassis position item existing.
		
		Even though the item DNE (not charging the customer) we will still want the opertunity to pay the driver 
		for the move. 
		
		SO... if we don't have an item for the front or back chassis split we will create a 'place holder to allow the 
		      proccssing to happen.
				
			notice that this is inside the shipment loop so the move needs to be in the shipment. it will not pay 
			moves in the itin. That will need to be changed later.
			
	*/

	
	IF  ( as_eventtype = n_cst_constants.cs_ItemEventType_FrontChassisSplit OR as_Eventtype = n_cst_constants.cs_ItemEventType_BackChassisSplit ) THEN 
		
		// check for special		
		IF UpperBound (lnva_SpecialMove)> 0   THEN
			
			// swap the templates so only the special are used.
			lnva_Templates = lnva_SpecialMove
			
			IF ll_ItemCount = 0 THEN
				ll_NewTempItemID = lnv_shipment.of_AddItem( "L", anv_dispatch, TRUE )
				IF ll_NewTempItemID > 0 THEN	
	
					lnva_Item[1] = CREATE n_cst_beo_Item
					lnva_Item[1].of_SetSource ( anv_dispatch.of_GetItemCache ( ) ) 
					lnva_Item[1].of_SetSourceID ( ll_NewTempItemID )
					lnva_Item[1].of_SetEventtypeflag( as_eventtype )
				
					ll_ItemCount = 1
				END IF
			END IF
		END IF
		
	END IF
	
	
	
	

//	//get autocreated items, these will be accessorial item type but are processed as freight in 
//	//intermodal shipments
//	j = this.of_getshipmentitems(anv_dispatch, lnv_shipment, n_cst_constants.cs_ItemEventType_MoveAccessorial, '', lnva_MoveAccessorialItem )
//	
//	for i = 1 to j
//		ll_ItemCount ++
//		lnva_Item[ll_ItemCount] = lnva_MoveAccessorialItem[i]	
//	next
	
	//Added 4.0.33 7/5/05 BKW
	//We will keep a running list of the Payable Rate Codes Generated, to block dupes on intermodal shipments.
	ls_RateCodeList = "~t"  //List will be tab delimited.  Supply starter tab.
	lb_IsIntermodalShipment = lnv_Shipment.of_IsIntermodal ( )
	//	
	
	ll_TemplateCount= upperbound(lnva_Templates)
	for ll_Itemndx = 1 to ll_ItemCount
	//	messagebox (as_eventtype  , ll_ItemCount ) 
		
		//must be a freight item type to be processed here, accessorial types will be
		//processed in the accessorial processing
		//exception - autocreated accessorial items
		if lnva_item[ll_Itemndx].of_gettype() = n_cst_constants.cs_ItemType_Freight then
			//ok to process			
		else
			CONTINUE
//			if lnva_item[ll_Itemndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_MoveAccessorial then
//				ll_Pickup = lnva_Item[ll_Itemndx].of_GetPickUpEvent()
//				IF ll_Pickup < 1 OR IsNULL(ll_Pickup) then
//					//ok to process	
//				else
//					//if linked to an event then pay as accessorial
//					CONTINUE
//				end if
//			ELSE
//				CONTINUE // <<*>> 3.21.05
//			end if
		end if
	
		if lnva_item[ll_Itemndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_FrontChassisSplit or &
			lnva_item[ll_Itemndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_BackChassisSplit or &
			lnva_item[ll_Itemndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_StopOff or &
			lnva_item[ll_Itemndx].of_getEventTypeFlag() = n_cst_constants.cs_ItemEventType_MoveAccessorial then
			lb_StandardFreight = false
		else
			lb_StandardFreight = true
		end if
		
		//Get the billing rate code.  Added 4.0.33 7/5/05 BKW
		ls_BillingRateCode = lnva_Item [ ll_ItemNdx ].of_GetRateCodeName ( )
		//
		
		
		for ll_Template = 1 to ll_TemplateCount
					
			lc_quantity = 0
			lc_rate = 0
			lc_payamount = 0
			ls_description = ''
			ls_InternalNote = ''  //Added 4.0.33 7/5/05 BKW
			//set point to point miles
			lc_miles = anv_itinerary.of_Gettotalmiles()
			if isnull(lc_miles) THEN
				lc_miles = 0
			end if

			//Added 4.0.33 7/5/05 BKW  to plug memory leak.
			IF IsValid ( lnv_RateData ) THEN
				DESTROY lnv_RateData
			END IF

//nwl commented to allow 'CUSTOM' to be substituted in the amount template
//			if lnva_item[ll_itemndx].Of_GetRateCodeName() = 'CUSTOM' then
//				//ZERO AMOUNT OWED
//				lc_payamount = 0
//				li_amounttype = lnva_item[ll_itemndx].of_getamounttype()
//				ls_description = lnva_item[ll_itemndx].of_getdescription()
//			else
				lnv_ratedata = create n_cst_ratedata
				if this.of_setratedata(lnva_Templates[ll_Template], lnv_shipment, lnva_item[ll_itemndx], &
							lnv_Ratedata, anva_event[ll_firstevent].of_Getsite ( ), anva_event[ll_lastevent].of_Getsite ( )) then
					//we have a ratadata object 
					if lnv_Ratedata.of_LookAtShipmentcode() then
						//is there pay on the item
						//if the item has a pay amount use it
						lc_payamount = lnva_item[ll_itemndx].of_getpayableamount()
						if lc_payamount > 0 then
							lc_quantity = this.of_GetItemQuantity(lnva_item[ll_itemndx], lnva_item[ll_itemndx].of_getpayratetype() )
							lc_rate = lnva_item[ll_itemndx].of_getpayrate()
							lb_ratecode=false
							li_amounttype = lnva_item[ll_itemndx].of_getamounttype()
							ls_description = lnva_item[ll_itemndx].of_getdescription()
							if lb_StandardFreight and (ls_ShipMoveCode = "I" or ls_ShipMoveCode = "E") then
								//IMPORT, EXPORT
								lc_rate = lc_rate * .5	
							end if
							lb_RateIt = false
						else
							lb_RateIt = true
						end if
					else
						//we have a rate code but not looking at the shipment for pay
						lb_RateIt = true
					end if
				else
					lb_RateIt = false
				end if
				
				
				if lb_RateIt then
					//set to item freight charges
					lc_quantity = this.of_GetItemQuantity(lnva_item[ll_itemndx], lnva_item[ll_itemndx].of_getratetype())
					lc_rate = lnva_item[ll_itemndx].of_getrate()
					lc_payamount = lnva_item[ll_itemndx].of_getFreightCharges()				

					//  try auto rating
					lnv_ratedata.of_settotalmiles(lc_miles)	
					lnv_ratedata.of_SetCategory(n_cst_constants.ci_Category_Payables)
					this.of_getratedata(lnv_shipment, lnva_item[ll_itemndx], lnv_Ratedata)
					lb_ratecode=true
					ls_ratecodename = lnv_ratedata.of_GetCodename()

					if len(trim(ls_ratecodename)) > 0 then
						if ls_Ratecodename = 'CUSTOM' then
							//SKIP
						else
							//have amount replace 
							lc_rate = lnv_ratedata.of_Getrate()
							lc_payamount = lnv_ratedata.of_GetTotalCharge()
							
							//4.0.30  6/7/05  BKW  If rate lookup came back zero and GenerateIfZero flag is "No",
							// suppress the line item generation.
																										
							IF lc_PayAmount = 0 OR IsNull ( lc_PayAmount ) THEN
								
								IF lnva_Templates [ ll_Template ].of_GetGenerateIfZero ( ) = FALSE THEN
		
									CONTINUE
									
								END IF
								
							END IF
							
							//
							
							if lnv_ratedata.of_Getratetype() = appeon_constant.cs_RateUnit_Code_Flat then
								lc_quantity = 1
							else
								lc_Quantity = lnv_ratedata.of_GetTotalCount()
							end if
							li_amounttype = lnv_ratedata.of_GetAmounttype()
							if isnull(li_amounttype) or li_amounttype = 0 then
								li_amounttype = lnva_item[ll_itemndx].of_getamounttype()
							end if
							if lnv_ratedata.of_usedSubstitution() or lnv_ratedata.of_usedfallback() then
								ls_description = lnv_ratedata.of_GetDescription()
							else
								ls_description = lnva_item[ll_itemndx].of_getdescription()
							end if
							
							
							//4.0.33  7/5/05  BKW  If item is rated as CUSTOM and it is not the first freight
							//item in the shipment, suppress the rating and put a message in the item.  We are
							//assuming that if they want to generate table pay for custom at all, that they only
							//want to do it for the first freight item, not for secondary freight items.  This 
							//is to avoid double-paying the move of a CUSTOM code substitution.
							
							//Check the rate code on the line item itself, NOT the pay rate code returned by rating in ls_RateCodeName
							
							IF ll_ItemNdx > 1 AND ls_BillingRateCode = 'CUSTOM' THEN
							
								//The returned values of lc_Rate and lc_PayAmount will be referenced in the InternalNote.  
								//Force these values to zero now if they're null to avoid nulling out the string.
								
								IF IsNull ( lc_Rate ) THEN
									lc_Rate = 0
								END IF
								
								IF IsNull ( lc_PayAmount ) THEN
									lc_PayAmount = 0
								END IF
								
								//If there's already text in the note, put a separator in so the user can distinguish.
								//The variable was initialized to the empty string at the start of the loop, so should not be null.
								IF Len ( ls_InternalNote ) > 0 THEN
									ls_InternalNote += " / "
								END IF
								
								ls_InternalNote += "WARNING:  a CUSTOM rated secondary freight line generated this pay item.  Pay has been zeroed to avoid potential double-pay.  "+&
									"Pay lookup was RATE: " + String ( lc_Rate, "$0.00###" ) + " PAY AMT: " + String ( lc_PayAmount, "$0.00" )
									
								IF ls_BillingRateCode > "" THEN  //Due to 'CUSTOM' condition above, in this case, should always be true.
									ls_InternalNote += " BILLING CODE: " + ls_BillingRateCode
								ELSE
									ls_InternalNote += " BILLING CODE: " + "[NONE]"
								END IF
								
								//Now that the InternalNote is built, zero the values to suppress line item pay.
								
								lc_Rate = 0
								lc_PayAmount = 0
								
								
							//4.0.33 7/5/05 BKW  Check if the pay code that has come back has already been used in this move
							//for this shipment (regardless of whether on the same template or not).  If it has, and the
							//shipment is intermodal, zero the line item and display a note.  If it has, and the shipment is
							//not intermodal, just display a note.
								
							ELSEIF Pos ( ls_RateCodeList, "~t" + Upper ( Trim ( ls_RateCodeName ) ) + "~t" ) > 0 THEN
							
								//The returned values of lc_Rate and lc_PayAmount will be referenced in the InternalNote.  
								//Force these values to zero now if they're null to avoid nulling out the string.
								
								IF IsNull ( lc_Rate ) THEN
									lc_Rate = 0
								END IF
								
								IF IsNull ( lc_PayAmount ) THEN
									lc_PayAmount = 0
								END IF
								
								//If there's already text in the note, put a separator in so the user can distinguish.
								//The variable was initialized to the empty string at the start of the loop, so should not be null.
								IF Len ( ls_InternalNote ) > 0 THEN
									ls_InternalNote += " / "
								END IF
								
								
								IF lb_IsIntermodalShipment THEN
								
									ls_InternalNote += "WARNING:  Another line item for this move already used the same PAYABLE rate code.  Pay has been zeroed to avoid potential double-pay.  "+&
										"Pay lookup was RATE: " + String ( lc_Rate, "$0.00###" ) + " PAY AMT: " + String ( lc_PayAmount, "$0.00" )
									
									//Now that the InternalNote is built, zero the values to suppress line item pay.
									
									lc_Rate = 0
									lc_PayAmount = 0
									
								ELSE
									
									ls_InternalNote += "WARNING: Another line item for this move already used the same PAYABLE rate code.  Please verify that this is not a double-pay."									
									
								END IF
								

								IF ls_BillingRateCode > "" THEN
									ls_InternalNote += " BILLING CODE: " + ls_BillingRateCode
								ELSE
									ls_InternalNote += " BILLING CODE: " + "[NONE]"
								END IF
								
							ELSE
								
								IF NOT IsNull ( ls_RateCodeName ) THEN
								
									ls_RateCodeList += Upper ( Trim ( ls_RateCodeName ) ) + "~t"  //tab delimited list
									
									//Note: Codes that had pay zeroed by the 'CUSTOM' section earlier are not included here.
									//This is intentional and ok, since it is unlikely they were intended to be paid by the
									//code that was returned by the pay lookup -- that is why they were zeroed.
									
								END IF
								
							END IF						
							
						end if
						
					else  // ( len(trim(ls_ratecodename)) = 0 )
						
						/*  Added this here during the changes to accomodate the paying of chassis pos
							without a billing line item. without this it would generate a zero line item */
						IF lc_PayAmount = 0 OR IsNull ( lc_PayAmount ) THEN
							
							IF lnva_Templates [ ll_Template ].of_GetGenerateIfZero ( ) = FALSE THEN								
								CONTINUE								
							END IF
							
						END IF
						
						
						
						li_amounttype = lnva_item[ll_itemndx].of_getamounttype()
						ls_description = lnva_item[ll_itemndx].of_getdescription()
						lc_percentage = lnv_ratedata.of_GetFreightPayablePercentage() / 100
						if lc_percentage > 0 then
							//percentage of freight calculation
							choose case ls_ShipMoveCode
								case "I", "E"
									lc_payamount = lc_payamount * lc_percentage
									lc_quantity = lc_null
									lc_rate = lc_null
									if lb_StandardFreight then
										//cut pay in half for move 
										lc_payamount = lc_payamount * .5
									end if
								case "O"
									lc_quantity = lc_null
									lc_rate = lc_null
									lc_payamount = lc_payamount * lc_percentage
								case else
									lc_quantity = lc_null
									lc_rate = lc_null
									lc_payamount = lc_payamount * lc_percentage											
							end choose
						else
							
							//4.0.33 7/5/05 BKW  In the following IF statement, replaced 3 fn lookups -- lnva_item[ll_itemndx].Of_GetRateCodeName() 
							//  -- with variable ls_BillingRateCode, which has the same value.
							
							if ls_BillingRateCode = 'CUSTOM' OR ls_BillingRateCode = '' OR IsNull ( ls_BillingRateCode ) then
								//	If we didn't find a rate code and the item rate is 'custom' then ZERO AMOUNT OWED
								lc_payamount = 0
								lc_quantity = lc_null
								lc_rate = lc_null
							end if
							
						end if					
					end if
				else  // ( lb_RateIt = FALSE )
					if lc_payamount > 0 then
						//ok
					else
						//no rate code, no percentage no pay
						continue
					end if
				end if
//			end if
			
			ll_AmountCount ++
			//nl
			destroy lnva_Amountowed[ll_AmountCount]

			//generate amount(s)
			lc_payamount = round(lc_payamount,2)
			lc_quantity = round(lc_quantity,3)
			lc_rate = round(lc_rate,4)
			
			if isnull(li_amounttype) or li_amounttype = 0 then
				CONTINUE
			else
				//is it a settlement type

				IF anv_transactionmanager.of_GetAmountType ( li_amounttype , lnv_AmountType ) = 1 THEN
					choose case lnv_AmountType.of_GetCategory ( )
						case n_cst_constants.ci_category_receivables
							CONTINUE
						case n_cst_constants.ci_category_Payables, n_cst_constants.ci_category_both
							CHOOSE CASE lnva_Item[ll_Itemndx].of_GetAccountingType()	
								CASE n_cst_constants.cs_AccountingType_Billable
									CONTINUE
								CASE n_cst_constants.cs_AccountingType_Payable, n_cst_constants.cs_AccountingType_Both 	
								
								 
									lc_amount = this.of_GenerateAmountowed(an_transaction, anv_transactionmanager, &
												 li_amounttype, ls_description, lnva_Amountowed[ll_AmountCount], &
												 lc_payamount, lc_Rate, lc_quantity )
												 															
								CASE ELSE
									CONTINUE
							END CHOOSE
						case else
							CONTINUE
					end choose							
				END IF
			END IF

			If IsValid(lnva_Amountowed[ll_AmountCount]) THEN  
				if lb_ratecode then
					lnva_Amountowed[ll_AmountCount].of_SetRateCodename(lnv_ratedata.of_Getcodename())
					lnva_Amountowed[ll_AmountCount].of_SetOriginzone(lnv_ratedata.of_GetOriginzone())
					lnva_Amountowed[ll_AmountCount].of_SetDestinationzone(lnv_ratedata.of_GetDestinationzone())
					lnva_Amountowed[ll_AmountCount].of_SetbilltoId(lnv_ratedata.of_GetbilltoId())
				end if
				lnva_Amountowed[ll_AmountCount].of_SetDivision(this.of_GetDivision(lnv_shipment))
				lnva_Amountowed[ll_AmountCount].of_SetStartDate ( anva_event[ll_firstevent].of_GetDateArrived() )
				lnva_Amountowed[ll_AmountCount].of_SetEndDate ( anva_event[ll_lastevent].of_GetDateArrived() )
				lnva_Amountowed[ll_AmountCount].of_SetShipment ( string(lnv_shipment.of_Getid()) ) //parent shipment
				
				ls_description = lnva_Amountowed[ll_AmountCount].of_GetDescription()
				if len(trim(ls_description)) > 0 then
					//already set
				else
					lnva_Amountowed[ll_AmountCount].of_SetDescription ( lnva_Templates[ll_Template].of_GetDescription ( ) )
				end if
				
				ls_publicnote=''
				ls_powerunit=''
				ls_trailer=''
				ls_container=''
				ls_driver=''
				
				//public note
				lsa_List = lsa_blank
				ll_listcount = 0
				for ll_Eventndx = ll_firstevent to ll_lastevent	
					ls_value = anva_event[ll_Eventndx].of_GetLocation ( )
					if len(trim(ls_value)) > 0 then
						ll_listcount ++
						lsa_list[ll_listcount] = ls_value
					end if
				next
				ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, false /*Shrink dupes */)
				for ll_count = 1 to ll_max
					if len(trim(lsa_List[ll_count])) > 0 then
						if len(trim(ls_publicnote)) > 0 then
							ls_publicnote += ', '
						end if
						ls_publicnote += lsa_List[ll_count]	
					end if
				next
				if lc_miles > 0 then
					ls_publicnote += ' MILES = ' + string(lc_miles,'#,##0.00')
				end if
				//powerunit	
				lsa_List = lsa_blank
				ll_listcount = 0
				for ll_Eventndx = ll_firstevent to ll_lastevent		
					ls_value = anva_event[ll_Eventndx].of_GetPowerUnit ( )
					if len(trim(ls_value)) > 0 then
						ll_listcount ++
						lsa_list[ll_listcount] = ls_value
					end if
				next
				ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
				for ll_count = 1 to ll_max
					if len(trim(ls_powerunit)) > 0 then
						ls_powerunit += ', '
					end if
					ls_powerunit += lsa_List[ll_count]			
				next
				//trailer		
				lsa_List = lsa_blank
				ll_listcount = 0
				for ll_Eventndx = ll_firstevent to ll_lastevent						
					ls_value = anva_event[ll_Eventndx].of_GetTrailerList ( )
					if len(trim(ls_value)) > 0 then
						ll_listcount ++
						lsa_list[ll_listcount] = ls_value
					end if
				next
				ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
				for ll_count = 1 to ll_max
					if len(trim(ls_trailer)) > 0 then
						ls_trailer += ', '
					end if
					ls_trailer += lsa_List[ll_count]			
				next
				//container
				lsa_List = lsa_blank
				ll_listcount = 0
				for ll_Eventndx = ll_firstevent to ll_lastevent		
					ls_value = anva_event[ll_Eventndx].of_GetcontainerList ( )
					if len(trim(ls_value)) > 0 then
						ll_listcount ++
						lsa_list[ll_listcount] = ls_value
					end if
				next
				ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
				for ll_count = 1 to ll_max
					if len(trim(ls_container)) > 0 then
						ls_container += ', '
					end if
					ls_container += lsa_List[ll_count]			
				next
				//driver
				lsa_List = lsa_blank
				ll_listcount = 0
				for ll_Eventndx = ll_firstevent to ll_lastevent		
					ll_value = anva_event[ll_Eventndx].of_GetDriverid ( )
					if ll_value > 0 then
						IF lnv_EmployeeManager.of_DescribeEmployee ( ll_value, ls_value, &
																					appeon_constant.ci_DescribeType_LastFirst ) = 1 THEN
							ll_listcount ++
							lsa_list[ll_listcount] = ls_value
						END IF
					end if
				next
				ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
				for ll_count = 1 to ll_max
					if len(trim(ls_Driver)) > 0 then
						ls_Driver += ', '
					end if
					ls_Driver += lsa_List[ll_count]			
				next

				lnva_Amountowed[ll_AmountCount].of_SetPublicNote ( ls_publicnote )
				lnva_Amountowed[ll_AmountCount].of_SetTruck ( ls_powerunit )
				lnva_Amountowed[ll_AmountCount].of_SetTrailer ( ls_trailer )
				lnva_Amountowed[ll_AmountCount].of_SetContainer ( ls_container )
				lnva_Amountowed[ll_AmountCount].of_SetDriver ( ls_driver )
				
				//Added 4.0.33 7/5/05 BKW
				IF ls_InternalNote > "" THEN
					lnva_AmountOwed [ ll_AmountCount ].of_SetInternalNote ( ls_InternalNote )
				END IF
				
			// if the amount owed was valid, put it into the amount oweds array. 
				IF NOT IsNull(ll_TransactionID) THEN
					lnva_Amountowed[ll_AmountCount].of_SetFkTransaction_Direct(ll_TransactionId)
				END IF

			END IF // amount owed validity check

		next // end of template loop
		
	next	//end of item loop
		
next	//end of ship loop

if isvalid(an_transaction) then
	an_transaction.of_calculate()
end if
IF ll_AmountCount > 0 THEN
	lds_PaySplitCache = anv_transactionmanager.of_GetPaySplitCache(true)
	this.of_addmoverangesplits(anva_event, ll_firstevent, ll_lastevent, lnva_amountowed, lds_PaySplitCache )
	anv_transactionmanager.of_SetPaySplitCache(lds_PaySplitCache)
END IF			

if isvalid(lnv_Ratedata) then
	destroy lnv_Ratedata
end if
if isvalid(lds_EventCopy) then
	destroy lds_EventCopy
end if
		
IF IsValid(lnv_shipment) THEN
	DESTROY lnv_shipment
END IF


ll_ItemCount = upperbound(lnva_item)
//left over items	
for ll_itemndx = 1 to ll_itemcount
	if isvalid(lnva_item[ll_itemndx]) then
		destroy lnva_item[ll_itemndx]
	end if
next

return ll_AmountCount
end function

private function long of_processmove (n_cst_beo_amounttemplate anva_movetemplate[], n_cst_beo_itinerary2 anv_itinerary, n_cst_beo_event anva_event[], n_cst_bso_dispatch anv_dispatch, long al_firstevent, ref long al_lastevent, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager);///////////////////////////////////////////////////////////////////////////////  
//
//	Function		:of_ProcessMove
//  
//	Access		:private
//
//	Arguments	:anva_movetemplate[]
//					anv_itinerary
//					anva_event[]
//					anv_dispatch
//					al_firstevent
//					al_lastevent by reference
//					an_transaction by reference
//					anv_transactionmanager by reference
//
//
//	Return		:ll_Return    
//					 the number of amounts generated
//						
//
//	Description	:Must have a move template for this process to happen. This
//					 will loop through the events looking for intermodal moves.
//					 The al_FirstEvent should already been identified as a hook or mount
//					 before calling this method.  If a move is identified then set the 
//					 itinerary range for those events and call of_processmoverange.
// 
//
// Written by: N. LeBlanc & J. Albert
// 		Date: 10.11.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

boolean	lb_MultipleMoves, &
			lb_move, &
			lb_locationoptional

long		ll_index, &
			ll_EventCount, &
			ll_Backward, &
			ll_shipmentid, &
			ll_gencount,&
			ll_AOCount, &
			ll_Max, &
			ll_stopoff, &
			ll_offset, &
			ll_return, &
			ll_startrow, &
			ll_endrow, &
			ll_e


Long	ll_HoldbackwardsIndex

string	ls_null

n_cst_msg		lnv_Range
s_Parm			lstr_Parm
n_cst_beo_Itinerary2		lnv_Itinerary
n_cst_beo_shipment		lnv_Shipment
n_cst_beo_event			lnva_eventjunk
datastore					lds_eventcache
setnull(ls_null)

lnv_itinerary = anv_itinerary
anv_transactionmanager.of_setItineraryObject(lnv_itinerary)

lds_eventcache=lnv_itinerary.of_Geteventcache()
ll_EventCount = upperbound(anva_event)	
	
if al_firstevent > ll_eventcount then
	ll_offset = 0
else
	ll_offset = anva_event[al_FirstEvent + 1].of_getsourcerow() - (al_FirstEvent + 1)
end if

if upperbound(anva_MoveTemplate) > 0 then
	//start with next event
	for ll_index = al_FirstEvent + 1 to ll_EventCount
		choose case anva_event[ll_index].of_GetType()
			
			CASE gc_Dispatch.cs_EventType_Mount
				if ll_index = al_FirstEvent + 1 then
					//if the event prior to this was a hook & this is the first event of the range 
					//then the range is complete. We have a front chassis split
					if anva_event[ll_Index - 1].of_ishook() then
						al_lastevent = ll_index
						ll_startrow = (al_FirstEvent + ll_offset) + 1
						ll_endrow = ll_startrow
						
						lnv_Range.of_Reset ( )
					
						lstr_Parm.is_Label = "StartRow"
						lstr_Parm.ia_Value = ll_startrow
						lnv_Range.of_Add_Parm ( lstr_Parm )	
						
						lstr_Parm.is_Label = "EndRow"
						lstr_Parm.ia_Value = ll_endrow
						lnv_Range.of_Add_Parm ( lstr_Parm )				
						
						lstr_Parm.is_Label = "ItinType"
						lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
						lnv_Range.of_Add_Parm ( lstr_Parm )
											
						lstr_Parm.is_Label = "ItinId"
						lstr_Parm.ia_Value = anva_event[al_FirstEvent + 1].of_gettractorid()
						lnv_Range.of_Add_Parm ( lstr_Parm )
											
						lstr_Parm.is_Label = "RetainExcludedShipments"
						lstr_Parm.ia_Value = TRUE
						lnv_Range.of_Add_Parm ( lstr_Parm )
						
						ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				
					
						ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, al_FirstEvent + 1, al_FirstEvent + 1, &
								an_transaction, anv_transactionmanager, anva_movetemplate, n_cst_constants.cs_ItemEventType_FrontChassisSplit)
						if ll_GenCount >= 1 then
							ll_AOCount +=ll_GenCount		
						end if
						EXIT
					end if
				end if
												
			CASE gc_Dispatch.cs_EventType_Drop,	gc_Dispatch.cs_EventType_Dismount
				//	If this is the first event and it is a dismount, then exit the loop and check for  
				// a back chassis split
				if ll_index = al_FirstEvent + 1 then
					if anva_event[ll_Index - 1].of_isdismount() then
						
						ll_startrow = (ll_index + ll_offset)
						ll_endrow = ll_startrow
			
						lnv_Range.of_Reset ( )
					
						lstr_Parm.is_Label = "StartRow"
						lstr_Parm.ia_Value = ll_startrow
						lnv_Range.of_Add_Parm ( lstr_Parm )		
						
						lstr_Parm.is_Label = "EndRow"
						lstr_Parm.ia_Value = ll_endrow
						lnv_Range.of_Add_Parm ( lstr_Parm )
						
						lstr_Parm.is_Label = "ItinType"
						lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
						lnv_Range.of_Add_Parm ( lstr_Parm )
											
						lstr_Parm.is_Label = "ItinId"
						lstr_Parm.ia_Value = anva_event[ll_index - 1].of_gettractorid()
						lnv_Range.of_Add_Parm ( lstr_Parm )
																							
						lstr_Parm.is_Label = "RetainExcludedShipments"
						lstr_Parm.ia_Value = TRUE
						lnv_Range.of_Add_Parm ( lstr_Parm )
						
						ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				
											
						ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, ll_index, ll_index, &
								an_transaction, anv_transactionmanager, anva_movetemplate, n_cst_constants.cs_ItemEventType_BackChassisSplit)
						if ll_GenCount >= 1 then 
							ll_AOCount +=ll_GenCount	
						end if
								
						EXIT
							
					end if
				end if
				/*
					If there are intervening (shipment) events, see if any of them are the origin or destination
					of the shipment. if so, you have 2 moves, if not you have one.
				*/
				//Look backwards.
//				if ll_index - al_FirstEvent > 1 then
//					//we have intervening events
//					//start 1 back
//					for ll_Backward = (ll_index - 1) to (al_FirstEvent + 1) step -1
//						if	anva_event[ll_Backward].of_HasShipment() then
//							ll_ShipmentID = anva_event[ll_Backward].of_GetShipment (  )
//							lnv_Shipment = CREATE n_cst_beo_Shipment
//							IF ll_ShipmentID > 0 THEN
//								anv_Dispatch.of_RetrieveShipment ( ll_ShipmentID ) 
//								lnv_Shipment.of_SetSource ( anv_Dispatch.of_GetShipmentCache ( )) 
//								lnv_Shipment.of_SetSourceID ( ll_ShipmentID ) 
//							END IF						
//							IF lnv_Shipment.of_HasSource ( ) THEN
//								if anva_event[ll_Backward].of_GetSite() = lnv_shipment.of_GetOrigin() or &
//									anva_event[ll_Backward].of_GetSite() =	lnv_shipment.of_GetDestination() then
//									lb_multiplemoves = TRUE
//									exit
//								end if							
//							END IF
//							// Powerbuilder blows up if I destroy the shipment, j. Albert, 12/12/02
//							DESTROY ( lnv_Shipment ) 
//						end if
//					NEXT  
//				end if
				
				
///////////////////////////////////////////////////////////////
/*  There is a problem determining the correct ll_backward if a deliver happens right behind the shipment event.

		I am replacing the above code with the code that follows in an attempt to handle this better.
		cross 'em if you got em!  <<*>>

*/



			if ll_index - al_FirstEvent > 1 then
				//we have intervening events
				//start 1 back

				for ll_Backward = (ll_index - 1) to (al_FirstEvent + 1) step -1
					if	anva_event[ll_Backward].of_HasShipment() then
						ll_ShipmentID = anva_event[ll_Backward].of_GetShipment (  )
						lnv_Shipment = CREATE n_cst_beo_Shipment
						IF ll_ShipmentID > 0 THEN
							anv_Dispatch.of_RetrieveShipment ( ll_ShipmentID ) 
							lnv_Shipment.of_SetSource ( anv_Dispatch.of_GetShipmentCache ( )) 
							lnv_Shipment.of_SetSourceID ( ll_ShipmentID ) 
						END IF						
						IF lnv_Shipment.of_HasSource ( ) THEN
							if anva_event[ll_Backward].of_GetSite() = lnv_shipment.of_GetOrigin() or &
								anva_event[ll_Backward].of_GetSite() =	lnv_shipment.of_GetDestination() then
								lb_multiplemoves = TRUE
								ll_HoldbackwardsIndex = ll_Backward
								
								// by not exiting i am trying to find the shipment event that belongs with the Hook
								
								
							//	exit
							end if							
						END IF
						// Powerbuilder blows up if I destroy the shipment, j. Albert, 12/12/02
						DESTROY ( lnv_Shipment ) 
					end if
				NEXT  
			end if
			
			IF lb_MultipleMoves  THEN // I don't think this guard really needs to be here b.c. ll_Backwards will only be used if lb_MultipleMove it true
				ll_Backward = ll_holdbackwardsIndex
			END IF


//// end of alterations.<<*>>
////////////////////////////////////////////////////////////////
				
				
				/*
						look for stopoffs - any non-locationoptional shipment events 
						inbetween leg points (al_FirstEvent,ll_Backward,ll_Index)
				*/
				
				
///////// <<*>>				
//lb_multiplemoves = FALSE




				IF (lb_multiplemoves = TRUE) THEN
					/* first move	*/	
					ll_startrow = (al_FirstEvent + ll_offset) + 1
					ll_endrow = ll_Backward + ll_offset

					lnv_Range.of_Reset ( )

					lstr_Parm.is_Label = "StartRow"
					lstr_Parm.ia_Value = ll_startrow
					lnv_Range.of_Add_Parm ( lstr_Parm )	
					
					lstr_Parm.is_Label = "EndRow"
					lstr_Parm.ia_Value = ll_endrow
					lnv_Range.of_Add_Parm ( lstr_Parm )				
					
					lstr_Parm.is_Label = "ItinType"
					lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
					lnv_Range.of_Add_Parm ( lstr_Parm )
										
					lstr_Parm.is_Label = "ItinId"
					lstr_Parm.ia_Value = anva_event[al_FirstEvent + 1].of_gettractorid()
					lnv_Range.of_Add_Parm ( lstr_Parm )
										
					lstr_Parm.is_Label = "RetainExcludedShipments"
					lstr_Parm.ia_Value = TRUE
					lnv_Range.of_Add_Parm ( lstr_Parm )
					
					ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				
					
					ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, al_FirstEvent + 1, ll_Backward, &
						  an_transaction, anv_transactionmanager, anva_movetemplate, ls_null)
					if ll_GenCount >= 1 then 
						ll_AOCount +=ll_GenCount	
					end if
					
					//any stopoffs in first move?
					if ll_Backward - al_FirstEvent > 1 then
						//we may have stopoffs
						for ll_stopoff = (al_FirstEvent + 1) to (ll_Backward - 1)
							if	anva_event[ll_stopoff].of_HasShipment() then
								if anva_event[ll_stopoff].of_GetShipment (  ) = ll_ShipmentID then
									//same shipment, is it locationoptional
									lb_locationoptional = anva_event[ll_stopoff].of_islocationoptional()
									if isnull(lb_locationoptional) or lb_locationoptional then
										continue
									else
										ll_startrow = ll_stopoff + ll_offset
										ll_endrow = ll_startrow
										
										lnv_Range.of_Reset ( )
									
										lstr_Parm.is_Label = "StartRow"
										lstr_Parm.ia_Value = ll_startrow
										lnv_Range.of_Add_Parm ( lstr_Parm )	
										
										lstr_Parm.is_Label = "EndRow"
										lstr_Parm.ia_Value = ll_endrow
										lnv_Range.of_Add_Parm ( lstr_Parm )
										
										lstr_Parm.is_Label = "ItinType"
										lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
										lnv_Range.of_Add_Parm ( lstr_Parm )
															
										lstr_Parm.is_Label = "ItinId"
										lstr_Parm.ia_Value = anva_event[ll_stopoff].of_gettractorid()
										lnv_Range.of_Add_Parm ( lstr_Parm )
															
										lstr_Parm.is_Label = "RetainExcludedShipments"
										lstr_Parm.ia_Value = TRUE
										lnv_Range.of_Add_Parm ( lstr_Parm )
										
										ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )
										
										ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, ll_stopoff, ll_stopoff, &
												an_transaction, anv_transactionmanager, anva_movetemplate, n_cst_constants.cs_ItemEventType_StopOff)	
										if ll_GenCount >= 1 then 
											ll_AOCount +=ll_GenCount	
										end if										
									end if							
								end if	
							end if						
						next						
					end if
					
					/*	second move */	
					ll_startrow = (ll_Backward + ll_offset) + 1
					ll_endrow = ll_Index + ll_offset

					lnv_Range.of_Reset ( )
				
					lstr_Parm.is_Label = "StartRow"
					lstr_Parm.ia_Value = ll_startrow
					lnv_Range.of_Add_Parm ( lstr_Parm )	
					
					lstr_Parm.is_Label = "EndRow"
					lstr_Parm.ia_Value = ll_endrow
					lnv_Range.of_Add_Parm ( lstr_Parm )
					
					lstr_Parm.is_Label = "ItinType"
					lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
					lnv_Range.of_Add_Parm ( lstr_Parm )
										
					lstr_Parm.is_Label = "ItinId"
					lstr_Parm.ia_Value = anva_event[ll_Backward + 1].of_gettractorid()				
					lnv_Range.of_Add_Parm ( lstr_Parm )
										
					lstr_Parm.is_Label = "RetainExcludedShipments"
					lstr_Parm.ia_Value = TRUE
					lnv_Range.of_Add_Parm ( lstr_Parm )
					
					ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				

					ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, ll_Backward + 1, ll_Index, &
							an_transaction, anv_transactionmanager, anva_movetemplate, ls_null)	
					if ll_GenCount >= 1 then 
						ll_AOCount +=ll_GenCount	
					end if
					
					//any stopoffs in second move?
					if ll_Index - ll_Backward > 1 then
						//we may have stopoffs
						for ll_stopoff = (ll_Backward + 1) to (ll_Index - 1)
							if	anva_event[ll_stopoff].of_HasShipment() then
								if anva_event[ll_stopoff].of_GetShipment (  ) = ll_ShipmentID then
									//same shipment, is it locationoptional
									lb_locationoptional = anva_event[ll_stopoff].of_islocationoptional()
									if isnull(lb_locationoptional) or lb_locationoptional then
										continue
									else
										ll_startrow = ll_stopoff + ll_offset
										ll_endrow = ll_startrow
										
										lnv_Range.of_Reset ( )
									
										lstr_Parm.is_Label = "StartRow"
										lstr_Parm.ia_Value = ll_startrow
										lnv_Range.of_Add_Parm ( lstr_Parm )	
										
										lstr_Parm.is_Label = "EndRow"
										lstr_Parm.ia_Value = ll_endrow
										lnv_Range.of_Add_Parm ( lstr_Parm )
										
										lstr_Parm.is_Label = "ItinType"
										lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
										lnv_Range.of_Add_Parm ( lstr_Parm )
															
										lstr_Parm.is_Label = "ItinId"
										lstr_Parm.ia_Value = anva_event[ll_stopoff].of_gettractorid()
										lnv_Range.of_Add_Parm ( lstr_Parm )
															
										lstr_Parm.is_Label = "RetainExcludedShipments"
										lstr_Parm.ia_Value = TRUE
										lnv_Range.of_Add_Parm ( lstr_Parm )
										
										ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				

										ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, ll_stopoff, ll_stopoff, &
												an_transaction, anv_transactionmanager, anva_movetemplate, n_cst_constants.cs_ItemEventType_StopOff)	
										if ll_GenCount >= 1 then 
											ll_AOCount +=ll_GenCount	
										end if										
									end if							
								end if	
							end if											
						next						
					end if
					
					EXIT			
				else
					//one move
					ll_startrow = (al_firstevent + ll_offset) + 1
					ll_endrow = ll_Index + ll_offset

					lnv_Range.of_Reset ( )
				
					lstr_Parm.is_Label = "StartRow"
					lstr_Parm.ia_Value = ll_startrow
					lnv_Range.of_Add_Parm ( lstr_Parm )		
					
					lstr_Parm.is_Label = "EndRow"
					lstr_Parm.ia_Value = ll_endrow
					lnv_Range.of_Add_Parm ( lstr_Parm )
					
					lstr_Parm.is_Label = "ItinType"
					lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
					lnv_Range.of_Add_Parm ( lstr_Parm )
										
					lstr_Parm.is_Label = "ItinId"
					lstr_Parm.ia_Value = anva_event[al_firstevent + 1].of_gettractorid()
					lnv_Range.of_Add_Parm ( lstr_Parm )
															
					lstr_Parm.is_Label = "RetainExcludedShipments"
					lstr_Parm.ia_Value = TRUE
					lnv_Range.of_Add_Parm ( lstr_Parm )
					
					ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				

					ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, al_firstevent + 1, ll_Index, &
							an_transaction, anv_transactionmanager, anva_movetemplate, ls_null)				
					if ll_GenCount >= 1 then 
						ll_AOCount +=ll_GenCount	
					end if
					
					//any stopoffs in this move?
					if ll_Index - al_firstevent > 1 then
						//we may have stopoffs
						for ll_stopoff = (al_firstevent + 1) to (ll_Index - 1)
							if	anva_event[ll_stopoff].of_HasShipment() then
								if anva_event[ll_stopoff].of_GetShipment (  ) = ll_ShipmentID then
									//same shipment, is it locationoptional
									lb_locationoptional = anva_event[ll_stopoff].of_islocationoptional()
									if isnull(lb_locationoptional) or lb_locationoptional then
										continue
									else
										ll_startrow = ll_stopoff + ll_offset
										ll_endrow = ll_startrow
										
										lnv_Range.of_Reset ( )
									
										lstr_Parm.is_Label = "StartRow"
										lstr_Parm.ia_Value = ll_startrow
										lnv_Range.of_Add_Parm ( lstr_Parm )	
										
										lstr_Parm.is_Label = "EndRow"
										lstr_Parm.ia_Value = ll_endrow
										lnv_Range.of_Add_Parm ( lstr_Parm )
										
										lstr_Parm.is_Label = "ItinType"
										lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
										lnv_Range.of_Add_Parm ( lstr_Parm )
															
										lstr_Parm.is_Label = "ItinId"
										lstr_Parm.ia_Value = anva_event[ll_stopoff].of_gettractorid()
										lnv_Range.of_Add_Parm ( lstr_Parm )
																				
										lstr_Parm.is_Label = "RetainExcludedShipments"
										lstr_Parm.ia_Value = TRUE
										lnv_Range.of_Add_Parm ( lstr_Parm )
										
										ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				

										ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, ll_stopoff, ll_stopoff, &
												an_transaction, anv_transactionmanager, anva_movetemplate, n_cst_constants.cs_ItemEventType_StopOff)	
										if ll_GenCount >= 1 then 
											ll_AOCount +=ll_GenCount	
										end if										
									end if							
								end if	
							end if											
						next						
					end if
									
					EXIT
							
				END IF
				
			CASE gc_Dispatch.cs_EventType_Pickup, gc_Dispatch.cs_EventType_Deliver
			
				if ll_index = ll_EventCount then
					//end of itinerary, partial move if this is an origin or destination point
					//did we start with a hook or mount
					if anva_event[al_firstevent].of_ishook() then
						if	anva_event[ll_Index].of_HasShipment() then
							ll_ShipmentID = anva_event[ll_Index].of_GetShipment (  )
							lnv_Shipment = CREATE n_cst_beo_Shipment
							IF ll_ShipmentID > 0 THEN
								anv_Dispatch.of_RetrieveShipment ( ll_ShipmentID ) 
								lnv_Shipment.of_SetSource ( anv_Dispatch.of_GetShipmentCache ( )) 
								lnv_Shipment.of_SetSourceID ( ll_ShipmentID ) 
							END IF						
							IF lnv_Shipment.of_HasSource ( ) THEN
								if anva_event[ll_Index].of_GetSite() = lnv_shipment.of_GetOrigin() or &
									anva_event[ll_Index].of_GetSite() =	lnv_shipment.of_GetDestination() then
									//pay it
									ll_startrow = (al_firstevent + ll_offset) + 1
									ll_endrow = ll_Index + ll_offset
				
									lnv_Range.of_Reset ( )
								
									lstr_Parm.is_Label = "StartRow"
									lstr_Parm.ia_Value = ll_startrow
									lnv_Range.of_Add_Parm ( lstr_Parm )		
									
									lstr_Parm.is_Label = "EndRow"
									lstr_Parm.ia_Value = ll_endrow
									lnv_Range.of_Add_Parm ( lstr_Parm )
									
									lstr_Parm.is_Label = "ItinType"
									lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
									lnv_Range.of_Add_Parm ( lstr_Parm )
														
									lstr_Parm.is_Label = "ItinId"
									lstr_Parm.ia_Value = anva_event[al_firstevent + 1].of_gettractorid()
									lnv_Range.of_Add_Parm ( lstr_Parm )
																			
									lstr_Parm.is_Label = "RetainExcludedShipments"
									lstr_Parm.ia_Value = TRUE
									lnv_Range.of_Add_Parm ( lstr_Parm )
									
									ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				
				
									ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, al_firstevent + 1, ll_Index, &
											an_transaction, anv_transactionmanager, anva_movetemplate, ls_null)				
									if ll_GenCount >= 1 then 
										ll_AOCount +=ll_GenCount	
									end if
									
									//any stopoffs in this move?
									if ll_Index - al_firstevent > 1 then
										//we may have stopoffs
										for ll_stopoff = (al_firstevent + 1) to (ll_Index - 1)
											if	anva_event[ll_stopoff].of_HasShipment() then
												if anva_event[ll_stopoff].of_GetShipment (  ) = ll_ShipmentID then
													//same shipment, is it locationoptional
													lb_locationoptional = anva_event[ll_stopoff].of_islocationoptional()
													if isnull(lb_locationoptional) or lb_locationoptional then
														continue
													else
														ll_startrow = ll_stopoff + ll_offset
														ll_endrow = ll_startrow
														
														lnv_Range.of_Reset ( )
													
														lstr_Parm.is_Label = "StartRow"
														lstr_Parm.ia_Value = ll_startrow
														lnv_Range.of_Add_Parm ( lstr_Parm )	
														
														lstr_Parm.is_Label = "EndRow"
														lstr_Parm.ia_Value = ll_endrow
														lnv_Range.of_Add_Parm ( lstr_Parm )
														
														lstr_Parm.is_Label = "ItinType"
														lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
														lnv_Range.of_Add_Parm ( lstr_Parm )
																			
														lstr_Parm.is_Label = "ItinId"
														lstr_Parm.ia_Value = anva_event[ll_stopoff].of_gettractorid()
														lnv_Range.of_Add_Parm ( lstr_Parm )
																								
														lstr_Parm.is_Label = "RetainExcludedShipments"
														lstr_Parm.ia_Value = TRUE
														lnv_Range.of_Add_Parm ( lstr_Parm )
														
														ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				
				
														ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, ll_stopoff, ll_stopoff, &
																an_transaction, anv_transactionmanager, anva_movetemplate, n_cst_constants.cs_ItemEventType_StopOff)	
														if ll_GenCount >= 1 then 
															ll_AOCount +=ll_GenCount	
														end if										
													end if							
												end if	
											end if											
										next						
									end if
									
									//end payit
//									ll_GenCount = this.of_processpartialMove(anva_MoveTemplate, anv_itinerary, anva_Event, anv_dispatch, &
//									al_FirstEvent, ll_index, an_transaction, &
//									anv_transactionmanager)
//									if ll_GenCount > 0 then
//										ll_AOCount += ll_GenCount
//									end if
								end if							
							END IF
							DESTROY ( lnv_Shipment ) 
						end if
					end if
					
				end if			
				
	
		end choose

	next
	//if the last event was a dismount then Check for Back chassis split
	if ll_index < ll_eventcount then
		if anva_event[ll_index].of_isDismount() and anva_event[ll_index + 1].of_isDrop () then
			ll_startrow = (ll_index + ll_offset) + 1
			ll_endrow = ll_startrow

			lnv_Range.of_Reset ( )
		
			lstr_Parm.is_Label = "StartRow"
			lstr_Parm.ia_Value = ll_startrow
			lnv_Range.of_Add_Parm ( lstr_Parm )		
			
			lstr_Parm.is_Label = "EndRow"
			lstr_Parm.ia_Value = ll_endrow
			lnv_Range.of_Add_Parm ( lstr_Parm )
			
			lstr_Parm.is_Label = "ItinType"
			lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
			lnv_Range.of_Add_Parm ( lstr_Parm )
								
			lstr_Parm.is_Label = "ItinId"
			lstr_Parm.ia_Value = anva_event[ll_index + 1].of_gettractorid()
			lnv_Range.of_Add_Parm ( lstr_Parm )
																				
			lstr_Parm.is_Label = "RetainExcludedShipments"
			lstr_Parm.ia_Value = TRUE
			lnv_Range.of_Add_Parm ( lstr_Parm )
			
			ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				
								
			ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, ll_index + 1, ll_index + 1, &
					an_transaction, anv_transactionmanager, anva_movetemplate, n_cst_constants.cs_ItemEventType_BackChassisSplit)
			if ll_GenCount >= 1 then 
				ll_AOCount +=ll_GenCount	
			end if

			ll_index ++

		end if
		

	end if
	
	al_LastEvent = ll_Index
	
end if

return ll_AOCount
end function

public function long of_getdivision (n_cst_beo_shipment anv_ship);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetDivision
//  
//	Access		:public
//
//	Arguments	:anv_ship
//
//	Return		:long  
//						
//	Description	:
//
//			This method will return a division.  Order of search. First check shipment
//			If the shipment doesn't have a division then check the entity. If the entity
//			does not have a division then get the default division for the shipment type.
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

n_cst_ship_Type	lnv_ShipTypeManager
n_cst_ShipType		lnv_ShipType

Long		ll_division, &
			ll_shiptype, &
			ll_foundrow
string	ls_category
boolean	lb_division

lnv_ShipTypeManager.of_Ready ( TRUE ) 

if isvalid(anv_ship) then
	ll_shiptype = anv_ship.of_gettype()
	ls_category = anv_ship.of_getCategory()
	if lnv_ShipTypeManager.of_get_object(ll_shiptype, lnv_shiptype) = 1 then 
		if lnv_ShipType.of_isdivision ( ) then
			ll_division = ll_shiptype
			lb_division = true
		end if
		if isvalid(lnv_shiptype) then
			destroy lnv_shiptype
		end if
	end if
end if

if not lb_division then
	//check entity
	if isvalid(inv_entity) then
		ll_shiptype = inv_entity.of_GetDivision()
		if lnv_ShipTypeManager.of_get_object(ll_shiptype, lnv_shiptype) = 1 then
			if lnv_ShipType.of_isdivision ( ) then
				ll_division = ll_shiptype
				lb_division = true
			end if
			if isvalid(lnv_shiptype) then
				destroy lnv_shiptype
			end if
		end if
	end if
end if

if not lb_division then 
	if len(trim(ls_category)) > 0 then
		if upper(ls_category) = 'T' then
			ls_category = 'DISPATCH'
		else
			ls_category = 'BROKERAGE'
		end if
		//let's find the default shiptype based on the category of the ship passed in
		if lnv_ShipTypeManager.of_find_default(ls_category, ll_foundrow ) = 1 then
			ll_ShipType = gds_ShipType.Object.st_Id [ ll_foundrow ]
			if lnv_ShipTypeManager.of_get_object(ll_ShipType, lnv_shiptype) = 1 then
				if lnv_ShipType.of_isdivision ( ) then
					ll_division = ll_shiptype
					lb_division = true
				end if			
				if isvalid(lnv_shiptype) then
					destroy lnv_shiptype
				end if
			end if
		end if
	end if
end if

if isvalid(lnv_shiptype) then
	destroy lnv_shiptype
end if
	
return ll_division
end function

public function string of_getpayfuelsurchargetype ();Integer	li_SqlCode
Integer	li_Return = 1
String	ls_SurchargeType

n_cst_setting_PayFuelSurchargeType	lnv_SurchargeType

lnv_SurchargeType = create n_cst_setting_PayFuelSurchargeType
if isvalid(lnv_SurchargeType) then
	ls_SurchargeType = upper(lnv_SurchargeType.of_GetValue())
else
	li_Return = -1
end if

IF li_Return = 1 THEN
	//have value
ELSE
	SetNull ( ls_SurchargeType )
END IF

destroy lnv_Surchargetype

RETURN ls_SurchargeType
end function

public function long of_getfuelsurchargeamounttypeid (ref integer aia_id[]);long	ll_return, &
		ll_surchargemax, &
		ll_SurchargeCount, &
		ll_amounttypeidmax
		
n_cst_beo_amounttype		lnva_amounttype[]

// We need the list of all amounttype ids that have a  surcharge  type of pay
// any amount owed with one of these amount types will be added into our basis amount
// for calculation.  
ll_Return = of_GetSurchargeTypes(n_cst_constants.cs_FuelSurcharge_Pay, lnva_amounttype) //<<*>>
ll_SurchargeMax = upperbound(lnva_amounttype)

FOR ll_SurchargeCount = 1 TO ll_SurchargeMax
	aia_id[ll_SurchargeCount] = lnva_amounttype[ll_Surchargecount].of_GetId()
NEXT
//ll_AmounttypeidMax = upperbound(lia_AmountTypeIds)

IF ll_Return < 0 THEN
	//skip
ELSE
	// We need the list of all amounttype ids that have a  surcharge of type both
	// any amount owed with one of these amount types will be added into our basis amount
	// for calculation.  
	ll_Return = of_GetSurchargeTypes(n_cst_constants.cs_FuelSurcharge_Both, lnva_amounttype)
	ll_SurchargeMax = upperbound(lnva_amounttype)
	FOR ll_SurchargeCount = 1 TO ll_SurchargeMax
		aia_id[ UpperBound ( aia_id[] ) + 1] = lnva_amounttype[ll_Surchargecount].of_GetId()
	NEXT
	
END IF

return  upperbound(aia_id[])
end function

protected function n_cst_beo_itinerary2 of_createitinerary (n_cst_beo_transaction an_transaction, n_cst_bso_dispatch anv_dispatch, long al_dateoffset);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_CreateItinerary for n_cst_bso_payable
//  
//	Access:  public
//
//	Arguments: 
//					anv_transaction, input
//					anv_dispatch, input
//					al_dateoffset, input, - usually we want to go back 7 days to 
//						obtain the itinerary - this will let those who wish to do 
//						so use this method.
//
//	Return:		lnv_itinerary object     
//					
//						
//
//	Description:
//			for n_cst_bso_payable
//
//  
// 
//  All errors for this code should be within 01500-01599 for informational
//  errors and 11500-11599 for severe errors.
//
// Written by: J. Albert
// 		Date: 11.16.02
//		Version:  1.0, initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

date	ld_start, &
		ld_end, &
		ld_nulldate

long	ll_employeeId	, &
		ll_entityid, &
		ll_i

s_parm	lstr_Parm

n_cst_beo_itinerary2	lnv_itinerary
n_cst_beo_transaction lnv_transaction
n_cst_msg	lnv_Range


lnv_transaction = an_transaction

setnull(ld_nulldate)
ld_start = lnv_transaction.of_getStartDate()
ld_end = lnv_transaction.of_getEndDate()
ll_entityid = lnv_transaction.of_getfkentity()

	SELECT fkEmployee INTO :ll_employeeid FROM Entity WHERE Id = :ll_entityid ;
	
	COMMIT ;
	

lnv_itinerary = anv_Dispatch.of_GetItinerary(gc_Dispatch.ci_ItinType_Driver, &
				ll_EmployeeId, RelativeDate(ld_start , al_dateoffset), ld_End)  

IF  IsValid(lnv_itinerary) THEN

		lnv_Range.of_Reset ( )
	
		// Do this set range for the special case of unassigned amounts with a 0 
		//  transaction - this guarantees that the dates show up correctly
		//  on the w_transaction window in the transaction tab.
		lstr_Parm.is_Label = "StartDate"
		lstr_Parm.ia_Value = ld_start
		lnv_Range.of_Add_Parm(lstr_Parm)

		lstr_Parm.is_Label = "EndDate"
		lstr_Parm.ia_Value = ld_end
		lnv_Range.of_Add_Parm(lstr_Parm)
	
		lstr_Parm.is_Label = "ItinType"
		lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_Driver
		lnv_Range.of_Add_Parm(lstr_Parm)
	
		lstr_Parm.is_Label = "ItinId"
		lstr_Parm.ia_Value = lnv_itinerary.of_GetItinId()
		lnv_Range.of_Add_Parm(lstr_Parm)

		lnv_itinerary.of_SetRange(lnv_Range)
			
END IF

RETURN lnv_itinerary
end function

protected function long of_processdayordaterange (n_cst_beo_amounttemplate anva_template[], n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, date ad_firstdate, date ad_lastdate, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, ref long al_countao);///////////////////////////////////////////////////////////////////////////////
//
//  
//
//	Function:  of_ProcessDayOrDaterange
//  
//	Access:  private
//
//	Arguments: 
//					anva_template[]
//					anv_itinerary
//					anv_dispatch
//					ad_FirstDate
//					ad_LastDate
//					anva_amountowed[] by value
//					an_transaction by reference
//					anv_transactionmanager by reference
//					al_CountAO output by reference - Count Amount Oweds
//
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for n_cst_bso_payable
//
//  	Loop through all the day or daterange templates and process.
//   Copied code logic from of_TemplateLoop.  I tried not to modify
//   it unless absolutely necessary.
//
//    All errors should be created between 00700-00799 for informational
//  errors and 10700-10799 for severe errors.
//
// Written by: J. Albert
// 		Date: 10.29.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
Constant Integer CI_TYPE_DATERANGE = 4

boolean lb_aggregatecalc

date	ld_StartDate, &		
		ld_EndDate

dec	lc_amount, &
		lc_totalSplit

integer li_TemplateType

long ll_Return, &
		ll_TemplateCountMax, &
		ll_TemplateCount, &
		ll_TransactionId, &
		ll_ExpressionMax, &
		ll_Index, &
		ll_DaysAfter, &
		ll_Amountowedcount, &
		ll_Counter

string	lsa_Expression[], &
			lsa_Blank[], &
			lsa_DataPoint[], &
			ls_SplitsByExpression, &
			ls_ErrMsg, &
			ls_TemplateName, &
			ls_typeinfo
			
s_parm	lstr_Parm
n_ds		lds_Calculation

n_cst_msg	lnv_Range		
n_cst_beo_amountowed	lnv_amountowed, &
					lnv_NullAmountOwed							
n_Cst_beo_AmountTemplate lnv_AmountTemplate							
							
n_cst_beo_itinerary2	lnv_itinerary
n_cst_beo_Transaction	lnv_NullTransaction
n_cst_OFRError	lnv_Error

lnv_itinerary = anv_itinerary
ll_TemplateCountMax = upperbound(anva_Template)
IF IsValid(an_Transaction) THEN
	ll_TransactionID = an_Transaction.of_GetId()
ELSE
	SetNull (ll_TransactionID)
END IF

// Find out if we have day or date range templates
//  If these templates are date range, is aggregate calc True or False?
//  These two pieces of data will determine how processing is to occur.
//  For date range with aggregate calc of True, process this template
//     once for the date range.
//  For day or date range with aggregate calc of False, process this 
//     template once for each day between the start and end dates.

FOR ll_TemplateCount = 1 to ll_TemplateCountMAX
	lb_Aggregatecalc = FALSE
	If IsValid(anva_Template[ll_TemplateCount]) THEN
		lnv_AmountTemplate = anva_Template[ll_TemplateCount]
		li_TemplateType = lnv_AmountTemplate.of_gettype()
		IF li_TemplateType = CI_TYPE_DATERANGE THEN  
			lb_Aggregatecalc = lnv_AmountTemplate.of_getaggregatecalc()
		END IF
		ls_TemplateName = trim(lnv_AmountTemplate.of_GetName())
	ELSE 
		IF ad_FirstDate = ad_LastDate then
			ls_typeinfo = "day"
		ELSE
			ls_typeinfo = "date range"
		END IF
		ls_ErrMsg = "10715|A " +ls_typeinfo+ " template for this employee can not" + &
			" be settled in autogen.  Please fix or delete the template for this" + &
			" employee to settle it in autogen."
		this.of_insertErrorMsg(ls_ErrMsg)	
		ll_Return = -1
		EXIT
	END IF
	// Get info from amounttemplate describing how to calculate various activities
	//  on the itinerary.
	lsa_Expression = lsa_Blank
	anv_TransactionManager.of_LoadExpression(lnv_AmountTemplate, lsa_Expression)
	ll_ExpressionMax = upperbound(lsa_Expression)
	lsa_DataPoint = lsa_Blank
	FOR ll_Index = 1 to ll_ExpressionMax
		anv_Transactionmanager.of_GetDataPoint(lsa_Expression[ll_index], lsa_DataPoint)
	NEXT 
	ll_DaysAfter = daysafter(ad_FirstDate, ad_LastDate)
	IF lb_Aggregatecalc = TRUE THEN
		// here's set up for the one pass for the entire date range
		ll_DaysAFter = 0
	END IF	

	FOR ll_Index = 0 to ll_DaysAfter
		lnv_Range.of_Reset ( )
		
		lstr_Parm.is_Label = "StartDate"
		ld_StartDate = relativedate(ad_FirstDate,ll_Index)
		lstr_Parm.ia_Value = ld_StartDate
		lnv_Range.of_Add_Parm ( lstr_Parm )
			
		lstr_Parm.is_Label = "EndDate"
		IF lb_Aggregatecalc = TRUE THEN
			lstr_Parm.ia_Value = ad_LastDate			
		ELSE
			lstr_Parm.ia_Value = ld_StartDate			
		END IF
				
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ItinType"
		lstr_Parm.ia_Value = gc_Dispatch.ci_itinType_Driver
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ItinId"
		lstr_Parm.ia_Value = il_ItinId
		lnv_Range.of_Add_Parm ( lstr_Parm )
	
		lnv_Itinerary.of_SetRange ( lnv_Range )	
		
		lds_Calculation = CREATE n_ds
		lds_Calculation.DataObject = "d_ItineraryData"
		lds_Calculation.InsertRow(0)
		// Set the instance itinerary in the transaction manager
		anv_TransactionManager.of_SetItineraryObject(lnv_itinerary)
		IF IsValid(lnv_AmountOwed) THEN  // of_GenerateAmount will return a new one
			// if one was created - we don't want the old one from the last
			// time thru this loop hanging around being re-counted into ll_AmountOwedCount
			lnv_AmountOwed = lnv_NullAmountOwed
		END IF
		anv_TransactionManager.of_LoadCalculationDAtastore(lsa_DataPoint, lds_Calculation)
		lc_Amount = anv_transactionmanager.of_GenerateAmount(lds_Calculation,  &
				lnv_AmountTemplate, lnv_NullTransaction, lnv_Amountowed)
		// if lc_Amount is 0 the of_generateAmount failed; but, existing code
		//  keeps going so this one does too.
		IF IsValid ( lnv_AmountOwed ) THEN
			ll_AmountOwedCount ++
			IF NOT IsNull(ll_TransactionId) THEN
				lnv_AmountOwed.of_SetFKTransaction_Direct(ll_TransactionId)
			END IF	 //		

		END IF
		IF lc_Amount <> 0 THEN
	
			ls_SplitsByExpression = lnv_AmountTemplate.of_GetSplitsby ( )
		
			IF Len (Trim(ls_SplitsByExpression)) > 0 THEN
			//run splitsby against total itinerary, this number will be used
			//when determining percentages of participating legs
				lds_Calculation.Object.cf_Numeric.Expression = ls_SplitsByExpression
				lc_TotalSplit = lds_Calculation.GetItemNumber ( 1, "cf_Numeric" )		
			ELSE
				lc_TotalSplit = 0		
			END IF			
			anv_transactionmanager.of_GeneratePaySplits(lnv_AmountTemplate, &
			lsa_datapoint, lnv_AmountOwed, lc_TotalSplit)		
		END IF
		IF IsValid(lds_Calculation) THEN
			DESTROY lds_Calculation
		END IF
	NEXT  // End of DaysAfter loop 
	IF ll_Return = -1 THEN
		EXIT
	END IF
NEXT // template loop


IF IsValid(an_Transaction) THEN
	an_Transaction.of_Calculate()
END IF
al_CountAO = ll_AmountOwedCount
Return ll_Return 

end function

public function long of_generate (ref n_cst_beo_transaction an_transaction, n_cst_beo_amounttemplate anva_amounttemplate[], n_cst_beo_itinerary2 anv_itinerary, n_cst_beo_entity anv_entity, ref n_cst_bso_transactionmanager anv_transactionmanager, n_cst_bso_dispatch anv_dispatch, ref long al_countao, ref n_ds ads_periodicupdates);///////////////////////////////////////////////////////////////////////////////
//
//	Function		:of_Generate
//  
//	Access		:public
//
//	Arguments	:an_transaction by reference, output
//					anva_amounttemplate[] 
//					anv_itinerary
//					anv_entity 
//					anv_transactionmanager by reference
//					anv_dispatch
//					al_CountAO output, by reference
//					ads_PeriodicUpdates, output, by reference
//
//	Return		:long
//					 Be careful ll_return is being used for the successful insert of an error
//					 message and for the number of amountoweds created. A return of 1 may not
//					mean what you think it means. NWL
//						
//
//	Description	:Given an entity use the itinerary object to obtain the start and end dates for the event.
// 				 Sort the amounttemplates into types such as periodic, move, accessorial, etc.
//					 Determine the types passed in and call the appropriate processing routine to generate the
//					 amount owed(s) for each amounttemplate type.
//
//					 All errors should be created between 00300-00399 for informational errors
//					 and 10300-10399 for severe errors.
//
// Written by: J. Albert
// 		Date: 09.18.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//


boolean	lb_DayFound, &
			lb_PeriodicFound, &
			lb_RangeFound, &
			lb_ShipmentFound, &
			lb_SurchFound, &
			lb_MoveFound, &
			lb_LegFound, &			
			lb_ContinueProcess, &
			lb_DoAccessorial = TRUE, &
			lb_ErrorFound = FALSE, &
			lb_TemplatesPassedIn

			
date	ld_Start, &
		ld_End
		
long	ll_Return = 0, &
 		ll_Counter, &
		ll_TemplateIndex, &		 
		lla_AmountTemplateId[], &
		lla_AmountTemplateType[], &
		ll_EntityID, &
		ll_FirstRow, &
		ll_LastRow, &
		ll_CountAO, &
		ll_totalCountAO, &
		ll_Results, &
		ll_debugcounter		
string	ls_ErrMsg

n_cst_beo_amounttemplate	lnva_Amounttemplate[], &
									lnva_DayTemplate[], &
									lnva_LegTemplate[], &
									lnva_MoveTemplate[], &									
									lnva_PeriodicTemplate[], &									
									lnva_RangeTemplate[],&
									lnva_ShipmentTemplate[],&
									lnva_SurchTemplate[], &
									lnva_NullAmountTemplate[]
									
n_cst_beo_transaction		lnv_Transaction
n_cst_beo_amountowed			lnva_AmountOwed[]
n_cst_OFRError					lnv_Error
						
n_cst_Msg	lnv_MsgOfTemplates, &
				lnv_range
s_Parm		lstr_Parm

//n_cst_bso_Dispatch			lnv_Dispatch
//n_cst_bso_transactionmanager lnv_TransactionManager


lb_ContinueProcess = TRUE
IF isvalid(anv_Itinerary) THEN
	
	//save itinid it will get stomped on by tractor id in move process
	il_itinid = anv_itinerary.of_getitinid()
	
	ld_Start = anv_Itinerary.of_getstartdate()
	ld_End = anv_Itinerary.of_getenddate()
ELSE	// don't try to recover if an itinerary was not passed in
	lb_ErrorFound = TRUE
	ls_ErrMsg = "10301|Itinerary object is missing."
	ll_Return = this.of_inserterrorMsg(ls_ErrMsg)	
	lb_ContinueProcess = FALSE
END IF
IF lb_ContinueProcess = TRUE THEN
	IF isvalid(anv_TransactionManager) THEN	
	ELSE	// don't try to recover if a transaction
		// manager was not passed in
	lb_ErrorFound = TRUE
		ls_ErrMsg = "10303|Transaction Manager is not available."
		ll_Return = this.of_inserterrorMsg(ls_ErrMsg)		
		lb_ContinueProcess = FALSE		
	END IF
END IF
// Do we have a valid truckdriver entity?
IF lb_ContinueProcess = TRUE THEN
	ll_EntityID = anv_TransactionManager.of_GetDefaultEntityId()
	IF IsNull(anv_Entity) OR ll_EntityId = 0  THEN
		lb_ContinueProcess = FALSE
		ls_ErrMsg = "10305|Entity identifier has been corrupted."
		ll_Return = this.of_inserterrorMsg(ls_ErrMsg)

	ELSE	
		// entity is ok
		inv_entity = anv_entity
	END IF
END IF

// Do we have one or more amount rows for this truckdriver?
IF lb_ContinueProcess = TRUE THEN
	if upperbound(anva_amounttemplate) > 0 then
		lnva_AmountTemplate = anva_amounttemplate
		lb_TemplatesPassedIn = true
	else
//	try to get amount(s) from the amounttemplates that will be used in calcs 
//	(during the of_processxxx ) if none were passed in
		lnva_AmountTemplate = lnva_NullAmountTemplate
		ll_Results = anv_TransactionManager.of_GetAmountTemplate(lnva_AmountTemplate)
		IF ll_Results < 0 THEN
			 	lb_ContinueProcess = FALSE
				ls_ErrMsg = "10307|Unable to retrieve the amount templates for this transaction."
				ll_Return = this.of_inserterrorMsg(ls_ErrMsg)
		END IF
	end if
END IF // continue processing

IF lb_ContinueProcess = TRUE THEN
	IF isvalid(an_Transaction) THEN	
		lnv_Transaction = an_Transaction
	// does the transaction have the start and end dates? if not, fill in
		IF IsNull(lnv_Transaction.of_GetStartDate()) AND &
			IsNull(lnv_Transaction.of_GetEndDate()) THEN
			lnv_Transaction.of_SetStartDate(ld_Start)
			lnv_Transaction.of_SetEndDate(ld_End)
			an_Transaction = lnv_Transaction
		END IF // if we had a transaction the start & end dates are now set
	ELSE	
		 	lb_ContinueProcess = FALSE
			ls_ErrMsg = "10309|Transaction object is corrupted."
			ll_Return = this.of_inserterrorMsg(ls_ErrMsg)
	END IF  // do we have a valid transaction?

END IF // continue processing


IF lb_ContinueProcess = TRUE THEN
	ll_Counter = upperbound(lnva_AmountTemplate)
	IF ll_Counter = 0 THEN	 /* informational message only */	
		ls_ErrMsg = "00306|No amount templates found for this transaction." 
		ll_Return = this.of_inserterrorMsg(ls_ErrMsg)		
	END IF
	
// get the id and type for each amount template
// Do we have an existing object in which to store the result set?
	FOR ll_TemplateIndex = 1 to ll_Counter 
		lla_AmountTemplateId[ll_TemplateIndex] = lnva_AmountTemplate[ll_TemplateIndex].of_getid()
		lla_AmountTemplateType[ll_TemplateIndex] = lnva_AmountTemplate[ll_TemplateIndex].of_gettype()
		CHOOSE CASE lla_AmountTemplateType[ll_TemplateIndex]
			// yes, we are resetting the booleans repeatedly, otherwise we'd have to add additional 
			// conditional logic.
		CASE 1	//point to point
			//ignore
		CASE 2	//shipment
			lb_ShipmentFound = TRUE
			lnva_ShipmentTemplate[Upperbound(lnva_RangeTemplate) + 1] = lnva_AmountTemplate[ll_TemplateIndex]	
			//accessorial done in shipment pay logic
			lb_DoAccessorial = FALSE
		CASE 3 //Move
			lb_MoveFound = TRUE
			lnva_MoveTemplate[Upperbound(lnva_MoveTemplate) + 1] = lnva_AmountTemplate[ll_TemplateIndex]				
		CASE 4
			lb_RangeFound = TRUE
			lnva_RangeTemplate[Upperbound(lnva_RangeTemplate) + 1] = lnva_AmountTemplate[ll_TemplateIndex]	
		CASE 5
			lb_DayFound = TRUE
			lnva_DayTemplate[Upperbound(lnva_DayTemplate) + 1] = lnva_AmountTemplate[ll_TemplateIndex]
		CASE 6
			lb_LegFound = TRUE
			lnva_LegTemplate[Upperbound(lnva_LegTemplate) + 1] = lnva_AmountTemplate[ll_TemplateIndex]
		CASE 7
			if lb_TemplatesPassedIn then
				lb_PeriodicFound = TRUE
				lnva_PeriodicTemplate[Upperbound(lnva_PeriodicTemplate) + 1] = lnva_AmountTemplate[ll_TemplateIndex]			
			else
				//don't allow periodics with autogen
			end if
		CASE ELSE
			lb_ContinueProcess = FALSE
			ls_ErrMsg = "10325|Amount template type, " + string(lla_AmountTemplateType[ll_TemplateIndex]) + &
			 ", is invalid for autogen process."
			 ll_Return = this.of_inserterrorMsg(ls_ErrMsg)
//	lb_ErrorFound = TRUE
		END CHOOSE		
	NEXT  // end of loop that places each amount template into the correct template array.
END IF // end of if continue processing


// If we need to process ANY move templates we will do the day, leg, and range processing
//  within the move processing loop. So bundle up the day, leg, range, and move templates into
// the message obj.  

IF ((lb_ContinueProcess = TRUE) AND  (lb_MoveFound = TRUE)) THEN
	
	lnv_MsgOfTemplates.of_Reset()
	IF lb_DayFound = TRUE THEN
		lstr_Parm.is_Label = "DAY"
		lstr_Parm.ia_Value = lnva_DayTemplate
		lnv_MsgOfTemplates.of_Add_Parm(lstr_Parm)
	lb_DayFound = FALSE
	END IF
	IF lb_RangeFound = TRUE THEN
		lstr_Parm.is_Label = "DATERANGE"
		lstr_Parm.ia_Value = lnva_RangeTemplate
		lnv_MsgOfTemplates.of_Add_Parm(lstr_Parm)
		lb_RangeFound = FALSE
	END IF
	IF lb_ShipmentFound = TRUE THEN
		lstr_Parm.is_Label = "SHIPMENT"
		lstr_Parm.ia_Value = lnva_ShipmentTemplate
		lnv_MsgOfTemplates.of_Add_Parm(lstr_Parm)
		lb_ShipmentFound = FALSE
	END IF
	IF lb_LegFound = TRUE THEN
		lstr_Parm.is_Label = "LEG"
		lstr_Parm.ia_Value = lnva_LegTemplate
		lnv_MsgOfTemplates.of_Add_Parm(lstr_Parm)
		lb_LegFound = FALSE
	END IF
	IF lb_DoAccessorial = TRUE THEN
		// When doing a Move template, call the accessorial processing
		// within the move code; do not call the accessorial processing
		// from within of_generate.
		lb_DoAccessorial = FALSE
	END IF
	lstr_Parm.is_Label = "MOVE"
	lstr_Parm.ia_Value = lnva_MoveTemplate
	lnv_MsgOfTemplates.of_Add_Parm(lstr_Parm)
	
	ll_CountAO = 0	
	ll_Return = this.of_SubdivideMove(anv_itinerary, lnv_MsgOfTemplates, anv_dispatch, &
	         lnv_transaction, anv_transactionmanager, anv_entity, ll_CountAO, true/* search previous */)
		ll_TotalCountAO += ll_CountAO 
END IF
// Group of If statements 'cause we want periodic to process next to last .
// And accessorial will be last.  Move has to be first!
IF (lb_ContinueProcess = TRUE) AND (lb_LegFound = TRUE) THEN
	ll_CountAO = 0		
	ll_Return = anv_Itinerary.of_GetFirstLastEventRow(ll_FirstRow, ll_LastRow)
	ll_Return = this.of_ProcessLeg(lnva_LegTemplate, anv_itinerary, anv_dispatch, &
						ll_FirstRow, ll_LastRow, an_transaction, anv_transactionmanager, ll_CountAO)
		ll_TotalCountAO = ll_CountAO + ll_TotalCountAO
END IF

IF (lb_ContinueProcess = TRUE) AND (lb_DayFound = TRUE) THEN
	ll_CountAO = 0		
	ll_Return = this.of_ProcessDayorDateRange(lnva_DayTemplate, anv_itinerary, &
				anv_dispatch, ld_Start, ld_End, an_transaction, anv_transactionmanager,ll_CountAO)
		ll_TotalCountAO = ll_CountAO + ll_TotalCountAO
END IF


IF (lb_ContinueProcess = TRUE) AND (lb_ShipmentFound = TRUE) THEN
	
	
//////////  transplant from of_processshipmentPay
IF IsValid(anv_Itinerary) THEN
	lstr_Parm.is_Label = "StartDate"
	lstr_Parm.ia_Value = ld_Start
	lnv_Range.of_Add_Parm(lstr_Parm)
	
	lstr_Parm.is_Label = "EndDate"
	lstr_Parm.ia_Value = ld_End
	lnv_Range.of_Add_Parm(lstr_Parm)
	
	lstr_Parm.is_Label = "ItinType"
	lstr_Parm.ia_Value = gc_Dispatch.ci_itinType_Driver
	lnv_Range.of_Add_Parm(lstr_Parm)

	lstr_Parm.is_Label = "ItinId"
	lstr_Parm.ia_Value = il_ItinId
	lnv_Range.of_Add_Parm(lstr_Parm)
		
	anv_Itinerary.of_SetRange(lnv_Range)
	
ELSE
	ll_Return = -1
	ls_ErrMsg = "10813|Itineray object is not available"
END IF
////////////  end of transplant
	
	
	
	
	
	
	
	ll_Return = anv_transactionmanager.of_SetItineraryObject(anv_Itinerary)
	IF ll_Return < 0 THEN
		// we can't do create an amountowed if we don't have a valid itinerary, so quit.
		lb_ErrorFound = TRUE
		ls_ErrMsg = "10375|Autogen is missing an itinerary and therefore can not settle" + &
		" shipment pay for this employee."
		ll_Return = this.of_inserterrorMsg(ls_ErrMsg)		
	ELSE
		ll_CountAO = 0	
		ll_Return = this.of_ProcessShipmentPay(lnva_ShipmentTemplate, anv_itinerary, anv_dispatch, &
										ld_Start, ld_End, an_transaction, anv_transactionmanager, ll_CountAO)
		ll_TotalCountAO = ll_CountAO + ll_TotalCountAO
	end if
END IF








IF (lb_ContinueProcess = TRUE) AND (lb_RangeFound = TRUE) THEN
	ll_CountAO = 0	
	ll_Return = this.of_ProcessDayorDateRange(lnva_RangeTemplate, anv_itinerary, &
		 			anv_dispatch, ld_Start, ld_End, an_transaction, anv_transactionmanager, ll_CountAO)
	ll_TotalCountAO = ll_CountAO + ll_TotalCountAO
END IF

IF (lb_ContinueProcess = TRUE) AND (lb_PeriodicFound = TRUE) THEN
	// n_cst_bso_transactionmanager must have the correct instance itinerary object to
	// create the amount owed(s).  
	ll_Return = anv_transactionmanager.of_SetItineraryObject(anv_Itinerary)
	IF ll_Return < 0 THEN
		// we can't do create an amountowed if we don't have a valid itinerary, so quit.
		lb_ErrorFound = TRUE
		ls_ErrMsg = "10375|Autogen is missing an itinerary and therefore can not settle" + &
		" periodic deductions for this employee."
		ll_Return = this.of_inserterrorMsg(ls_ErrMsg)		
	ELSE
		ll_CountAO = 0
		ll_Return = this.of_ProcessPeriodic(an_transaction, lnva_periodictemplate, &
		  anv_transactionmanager, ld_Start, ld_End, ll_CountAO, ads_PeriodicUpdates)
		ll_TotalCountAO = ll_CountAO + ll_TotalCountAO
	END IF	
END IF


//Accessorials are processed with autogeneration
IF (lb_ContinueProcess = TRUE) AND (lb_DoAccessorial = TRUE) and lb_TemplatesPassedIn = FALSE THEN
		lnv_Range.of_Reset ( )

		lstr_Parm.is_Label = "StartDate"
		lstr_Parm.ia_Value = ld_Start
		lnv_Range.of_Add_Parm(lstr_Parm)
		
		lstr_Parm.is_Label = "EndDate"
		lstr_Parm.ia_Value = ld_End
		lnv_Range.of_Add_Parm(lstr_Parm)
		
		lstr_Parm.is_Label = "ItinType"
		lstr_Parm.ia_Value = gc_Dispatch.ci_itinType_Driver
		lnv_Range.of_Add_Parm(lstr_Parm)
	
		lstr_Parm.is_Label = "ItinId"
		lstr_Parm.ia_Value = il_ItinId
		lnv_Range.of_Add_Parm(lstr_Parm)

		lstr_Parm.is_Label = "RetainExcludedShipments"
		lstr_Parm.ia_Value = TRUE
		lnv_Range.of_Add_Parm ( lstr_Parm )				
			
		anv_Itinerary.of_SetRange(lnv_Range)	

		ll_CountAO = 0
		ll_Return = this.of_ProcessAccessorial(lnva_NullAmountTemplate, an_Transaction, anv_Itinerary, &
			anv_Entity, anv_TransactionManager, anv_Dispatch, ll_CountAO, &
			ld_Start, ld_End)
		ll_TotalCountAO = ll_CountAO + ll_TotalCountAO			
END IF
al_CountAO = ll_TotalCountAO
if lb_TemplatesPassedIn then
	//don't destroy
else
	ll_Counter = upperbound(lnva_AmountTemplate)
	FOR ll_TemplateIndex = 1 to ll_Counter 
		if isvalid(lnva_AmountTemplate[ll_TemplateIndex]) then
			destroy lnva_AmountTemplate[ll_TemplateIndex]
		end if
	next
end if

Return ll_Return


end function

private function long of_addshipmentpaysplits (n_cst_beo_event anva_event[], n_cst_beo_amountowed anv_amountowed, ref n_ds ads_paysplitcache, string as_itemtype);long		ll_return, &
			ll_index, &
			ll_nextid, &
			ll_Eventndx, &
			ll_eventcount, &
			ll_locationcount, &
			ll_AmountCount, &
			ll_paysplitrow
decimal	lc_Amount, &
			lc_runningtotal, &
			lc_amounttosplit

string	ls_type

constant boolean	cb_commit = true
			
n_cst_events			lnv_events

ll_locationcount = 0
ll_eventcount = upperbound(anva_event)

for ll_Eventndx = 1 to ll_eventcount
	ls_type = anva_event[ll_Eventndx].of_GetType()
	IF lnv_events.of_isTypeLocationOptional(ls_type) THEN
		//don't count
	else
		ll_locationcount ++
	end if
next

lc_amounttosplit = anv_amountowed.of_Getamount()
if ll_locationcount = 0 then
	lc_amount = lc_amounttosplit
else
	lc_Amount = round(lc_amounttosplit / ll_locationcount, 2)
end if
	
for ll_Eventndx = 1 to ll_eventcount
	ls_type = anva_event[ll_Eventndx].of_GetType()
	IF lnv_events.of_isTypeLocationOptional(ls_type) THEN
	//  don't include it.
	ELSE
		IF ll_Eventndx = ll_eventcount THEN
			lc_Amount = lc_amounttosplit - lc_RunningTotal
		ELSE
			IF Abs ( lc_RunningTotal + lc_Amount ) > Abs ( lc_amounttosplit ) THEN
				lc_Amount = lc_amounttosplit - lc_RunningTotal
			END IF
		END IF

	END IF
	
	IF lc_Amount <> 0 	THEN
		ll_PaySplitRow = ads_PaySplitCache.InsertRow(0)
		
		IF gnv_App.of_GetNextId ( "paysplit", ll_NextId, cb_Commit ) = 1 THEN
			ads_PaySplitCache.object.id[ll_PaySplitRow] = ll_NextId
		
			ads_PaySplitCache.object.amountid[ll_PaySplitRow] = anv_AmountOwed.of_GetId( )
			ads_PaySplitCache.object.eventid[ll_PaySplitRow] = anva_event[ll_Eventndx].of_GetId()
			ads_PaySplitCache.object.shipmentid[ll_PaySplitRow] = anva_event[ll_Eventndx].of_GetShipment()
			//turned off
			ads_PaySplitCache.object.paysplit[ll_PaySplitRow] = lc_Amount
			ads_PaySplitCache.object.itemtype[ll_PaySplitRow] = as_itemtype
			
		END IF			
		
		lc_RunningTotal += lc_Amount

	END IF // type optional
//don't forget remainder
next

return ll_return
end function

private function long of_processpartialmove (n_cst_beo_amounttemplate anva_movetemplate[], n_cst_beo_itinerary2 anv_itinerary, n_cst_beo_event anva_event[], n_cst_bso_dispatch anv_dispatch, long al_firstevent, ref long al_lastevent, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager);///////////////////////////////////////////////////////////////////////////////  
//
//	Function		:of_ProcessPartialMove
//  
//	Access		:private
//
//	Arguments	:anva_movetemplate[]
//					anv_itinerary
//					anva_event[]
//					anv_dispatch
//					al_firstevent
//					al_lastevent by reference
//					an_transaction by reference
//					anv_transactionmanager by reference
//
//
//	Return		:ll_Return    
//					 the number of amounts generated
//						
//
//	Description	:Must have a move template for this process to happen. This
//					 will loop through the events looking for intermodal moves.
//					 The al_FirstEvent should already been identified as a hook or mount
//					 before calling this method.  If a move is identified then set the 
//					 itinerary range for those events and call of_processmoverange.
// 
//
// Written by: N. LeBlanc & J. Albert
// 		Date: 10.11.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

boolean	lb_MultipleMoves, &
			lb_move, &
			lb_locationoptional

long		ll_EventCount, &
			ll_Backward, &
			ll_shipmentid, &
			ll_gencount,&
			ll_AOCount, &
			ll_Max, &
			ll_stopoff, &
			ll_offset, &
			ll_return, &
			ll_startrow, &
			ll_endrow, &
			ll_e
			
string	ls_null

n_cst_msg		lnv_Range
s_Parm			lstr_Parm
n_cst_beo_Itinerary2		lnv_Itinerary
n_cst_beo_shipment		lnv_Shipment
datastore					lds_eventcache
setnull(ls_null)

lnv_itinerary = anv_itinerary
anv_transactionmanager.of_setItineraryObject(lnv_itinerary)

lds_eventcache=lnv_itinerary.of_Geteventcache()
ll_EventCount = upperbound(anva_event)	
	
if al_firstevent > ll_eventcount then
	ll_offset = 0
else
	ll_offset = anva_event[al_FirstEvent].of_getsourcerow() - (al_FirstEvent)
end if

ll_startrow = al_firstevent + ll_offset
ll_endrow = al_lastevent + ll_offset

lnv_Range.of_Reset ( )

lstr_Parm.is_Label = "StartRow"
lstr_Parm.ia_Value = ll_startrow
lnv_Range.of_Add_Parm ( lstr_Parm )		

lstr_Parm.is_Label = "EndRow"
lstr_Parm.ia_Value = ll_endrow
lnv_Range.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "ItinType"
lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
lnv_Range.of_Add_Parm ( lstr_Parm )
					
lstr_Parm.is_Label = "ItinId"
lstr_Parm.ia_Value = anva_event[al_firstevent + 1].of_gettractorid()
lnv_Range.of_Add_Parm ( lstr_Parm )
										
lstr_Parm.is_Label = "RetainExcludedShipments"
lstr_Parm.ia_Value = TRUE
lnv_Range.of_Add_Parm ( lstr_Parm )

ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				

ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, al_firstevent, al_lastevent, &
		an_transaction, anv_transactionmanager, anva_movetemplate, ls_null)				
if ll_GenCount >= 1 then 
	ll_AOCount +=ll_GenCount	
end if

//any stopoffs in this move?
if al_lastevent - al_firstevent > 1 then
	//we may have stopoffs
	for ll_stopoff = (al_firstevent + 1) to (al_lastevent - 1)
		if	anva_event[ll_stopoff].of_HasShipment() then
			if anva_event[ll_stopoff].of_GetShipment (  ) = ll_ShipmentID then
				//same shipment, is it locationoptional
				lb_locationoptional = anva_event[ll_stopoff].of_islocationoptional()
				if isnull(lb_locationoptional) or lb_locationoptional then
					continue
				else
					ll_startrow = ll_stopoff + ll_offset
					ll_endrow = ll_startrow
					
					lnv_Range.of_Reset ( )
				
					lstr_Parm.is_Label = "StartRow"
					lstr_Parm.ia_Value = ll_startrow
					lnv_Range.of_Add_Parm ( lstr_Parm )	
					
					lstr_Parm.is_Label = "EndRow"
					lstr_Parm.ia_Value = ll_endrow
					lnv_Range.of_Add_Parm ( lstr_Parm )
					
					lstr_Parm.is_Label = "ItinType"
					lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
					lnv_Range.of_Add_Parm ( lstr_Parm )
										
					lstr_Parm.is_Label = "ItinId"
					lstr_Parm.ia_Value = anva_event[ll_stopoff].of_gettractorid()
					lnv_Range.of_Add_Parm ( lstr_Parm )
															
					lstr_Parm.is_Label = "RetainExcludedShipments"
					lstr_Parm.ia_Value = TRUE
					lnv_Range.of_Add_Parm ( lstr_Parm )
					
					ll_return = lnv_Itinerary.of_SetRange ( lnv_Range )				

					ll_gencount = this.of_ProcessMoveRange(anva_event, lnv_Itinerary, anv_dispatch, ll_stopoff, ll_stopoff, &
							an_transaction, anv_transactionmanager, anva_movetemplate, n_cst_constants.cs_ItemEventType_StopOff)	
					if ll_GenCount >= 1 then 
						ll_AOCount +=ll_GenCount	
					end if										
				end if							
			end if	
		end if											
	next						
end if

return ll_AOCount
end function

private function long of_findstartofmove (n_cst_beo_event anv_event, ref n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, ref long al_firstrowofititinerary);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_FindStartOfMove
//  
//	Access		:private
//
//	Arguments	:anv_event
//					 anv_itineray
//					 anv_Dispatch
//
//	Return		:long  - starting row, 0 if none found
//						
//	Description	:
//
//			This method will reset the itinerary to start 7 days ealier and try
//			to find the start of a move.
//
//			The order of the search is important. We want to look for a pickup or deliver
//			before a hook or mount. This will prevent paying a move twice.
//
// Written by	:Norm LeBlanc
// 		Date	:07/21/2004
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

long	ll_return = 0, &
		ll_Eventid, &
		ll_index, &
		ll_eventcount, &
		ll_StartRow, &
		ll_Backward, &
		ll_ShipmentId

date	ld_Start, &
		ld_end
		
string	ls_type

n_cst_msg		lnv_Range
s_Parm			lstr_Parm

n_cst_beo_event		lnva_Event[]
n_cst_beo_shipment	lnv_Shipment

ld_Start = anv_itinerary.of_getStartDate()

ld_End = anv_itinerary.of_GetEndDate()

ld_Start = Relativedate(ld_Start, -7)

lnv_Range.of_Reset ( )

lstr_Parm.is_Label = "StartDate"
lstr_Parm.ia_Value = ld_Start
lnv_Range.of_Add_Parm ( lstr_Parm )	

lstr_Parm.is_Label = "EndDate"
lstr_Parm.ia_Value = ld_End
lnv_Range.of_Add_Parm ( lstr_Parm )				

lstr_Parm.is_Label = "ItinType"
lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
lnv_Range.of_Add_Parm ( lstr_Parm )
					
lstr_Parm.is_Label = "ItinId"
lstr_Parm.ia_Value = anv_event.of_gettractorid()
lnv_Range.of_Add_Parm ( lstr_Parm )
					
lstr_Parm.is_Label = "RetainExcludedShipments"
lstr_Parm.ia_Value = TRUE
lnv_Range.of_Add_Parm ( lstr_Parm )

anv_Itinerary.of_SetRange ( lnv_Range )
					
//need the id of the real first row of the itinerary so we know where
//to start the search from.
ll_eventId = anv_Event.of_GetId()

ll_EventCount = anv_itinerary.of_GetEventList(lnva_Event, true)
for ll_index = 1 to ll_EventCount
	if ll_EventId = lnva_Event[ll_index].of_GetId() then
		ll_startrow = ll_index
		exit
	end if
next


CHOOSE CASE anv_event.of_GetType()
	CASE gc_Dispatch.cs_EventType_Hook
		//OK, no partial maove for prior period
		ll_return = 0
//		ll_return = ll_startrow
		
	CASE gc_Dispatch.cs_EventType_Mount
		//Go back 1 event to see if it was a hook
		IF UpperBound ( lnva_Event ) >= ll_StartRow -1 AND ll_StartRow - 1 >= LowerBound ( lnva_Event )  THEN
			if lnva_event[ll_startrow - 1].of_GetType( ) = gc_Dispatch.cs_EventType_Hook then
				ll_return = ll_startrow - 1
			end if
		END IF
		
	CASE gc_Dispatch.cs_EventType_Dismount
		//Search backwards for Pickup/Deliver, Hook or Mount
		for ll_Backward = (ll_startrow - 1) to 1 step -1
			choose case lnva_event[ll_Backward].of_GetType( )
				case gc_Dispatch.cs_EventType_Pickup, gc_Dispatch.cs_EventType_Deliver
					//is it origin or destination?
					if	lnva_event[ll_Backward].of_HasShipment() then
						ll_ShipmentID = lnva_event[ll_Backward].of_GetShipment (  )
						lnv_Shipment = CREATE n_cst_beo_Shipment
						IF ll_ShipmentID > 0 THEN
							anv_Dispatch.of_RetrieveShipment ( ll_ShipmentID ) 
							lnv_Shipment.of_SetSource ( anv_Dispatch.of_GetShipmentCache ( )) 
							lnv_Shipment.of_SetSourceID ( ll_ShipmentID ) 
						END IF						
						IF lnv_Shipment.of_HasSource ( ) THEN
							if lnva_event[ll_Backward].of_GetSite() = lnv_shipment.of_GetOrigin() or &
								lnva_event[ll_Backward].of_GetSite() =	lnv_shipment.of_GetDestination() then
								ll_return = ll_Backward
								exit
							end if							
						END IF
						DESTROY ( lnv_Shipment ) 
					end if
					
				case gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Mount
					
					ll_return = ll_Backward
					exit
					
			end choose
		NEXT  
		
	CASE gc_Dispatch.cs_EventType_Drop
		//Search backwards for Pickup/Deliver, Mount, Hook or Dismount
		for ll_Backward = (ll_startrow - 1) to 1 step -1
			ls_type = lnva_event[ll_Backward].of_GetType( )
			choose case ls_type
				case gc_Dispatch.cs_EventType_Pickup, gc_Dispatch.cs_EventType_Deliver
					//is it origin or destination?
					if	lnva_event[ll_Backward].of_HasShipment() then
						ll_ShipmentID = lnva_event[ll_Backward].of_GetShipment (  )
						lnv_Shipment = CREATE n_cst_beo_Shipment
						IF ll_ShipmentID > 0 THEN
							anv_Dispatch.of_RetrieveShipment ( ll_ShipmentID ) 
							lnv_Shipment.of_SetSource ( anv_Dispatch.of_GetShipmentCache ( )) 
							lnv_Shipment.of_SetSourceID ( ll_ShipmentID ) 
						END IF						
						IF lnv_Shipment.of_HasSource ( ) THEN
							if lnva_event[ll_Backward].of_GetSite() = lnv_shipment.of_GetOrigin() or &
								lnva_event[ll_Backward].of_GetSite() =	lnv_shipment.of_GetDestination() then
								ll_return = ll_Backward
								exit
							end if							
						END IF
						DESTROY ( lnv_Shipment ) 
					end if
					
				case gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Mount, gc_Dispatch.cs_EventType_Dismount
					
					ll_return = ll_Backward
					exit
					
			end choose
		NEXT  
	
	CASE gc_Dispatch.cs_EventType_Pickup, gc_Dispatch.cs_EventType_Deliver
		//Search backwards for a Hook or Mount
		for ll_Backward = (ll_startrow - 1) to 1 step -1
			choose case lnva_event[ll_Backward].of_GetType( )
			
				case gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Mount
					
					ll_return = ll_Backward
					exit
					
			end choose
		NEXT  
		
	CASE ELSE
		ll_return = 0
		
END CHOOSE

al_firstrowofititinerary = ll_startrow

return ll_return
end function

public function long of_processinteractivedayordaterange (n_cst_beo_amounttemplate anva_template[], n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, date ad_firstdate, date ad_lastdate, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, ref long al_countao);///////////////////////////////////////////////////////////////////////////////
//
//  
//
//	Function:  of_ProcessInteractiveDayOrDaterange
//  
//	Access:  private
//
//	Arguments: 
//					anva_template[]
//					anv_itinerary
//					anv_dispatch
//					ad_FirstDate
//					ad_LastDate
//					an_transaction by reference
//					anv_transactionmanager by reference
//					al_CountAO output by reference - Count Amount Oweds
//
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for n_cst_bso_payable
//
//
// Written by: n. leblanc
// 		Date: 07/26/2004
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
Constant Integer CI_TYPE_DATERANGE = 4

boolean lb_aggregatecalc

dec	lc_amount, &
		lc_totalSplit

integer li_TemplateType

long ll_Return, &
		ll_TemplateCountMax, &
		ll_TemplateCount, &
		ll_TransactionId, &
		ll_ExpressionMax, &
		ll_Index, &
		ll_DaysAfter, &
		ll_Amountowedcount, &
		ll_Counter

string	lsa_Expression[], &
			lsa_Blank[], &
			lsa_DataPoint[], &
			ls_SplitsByExpression, &
			ls_ErrMsg, &
			ls_TemplateName, &
			ls_typeinfo
			
n_ds		lds_Calculation

n_cst_beo_amountowed	lnv_amountowed, &
					lnv_NullAmountOwed							
n_Cst_beo_AmountTemplate lnv_AmountTemplate							
							
n_cst_beo_itinerary2	lnv_itinerary
n_cst_beo_Transaction	lnv_NullTransaction
n_cst_OFRError	lnv_Error

lnv_itinerary = anv_itinerary
ll_TemplateCountMax = upperbound(anva_Template)
IF IsValid(an_Transaction) THEN
	ll_TransactionID = an_Transaction.of_GetId()
ELSE
	SetNull (ll_TransactionID)
END IF

// Find out if we have day or date range templates
//  If these templates are date range, is aggregate calc True or False?
//  These two pieces of data will determine how processing is to occur.
//  For date range with aggregate calc of True, process this template
//     once for the date range.
//  For day or date range with aggregate calc of False, process this 
//     template once for each day between the start and end dates.

FOR ll_TemplateCount = 1 to ll_TemplateCountMAX
	lb_Aggregatecalc = FALSE
	If IsValid(anva_Template[ll_TemplateCount]) THEN
		lnv_AmountTemplate = anva_Template[ll_TemplateCount]
		li_TemplateType = lnv_AmountTemplate.of_gettype()
		IF li_TemplateType = CI_TYPE_DATERANGE THEN  
			lb_Aggregatecalc = lnv_AmountTemplate.of_getaggregatecalc()
		END IF
		ls_TemplateName = trim(lnv_AmountTemplate.of_GetName())
	END IF
	// Get info from amounttemplate describing how to calculate various activities
	//  on the itinerary.
	lsa_Expression = lsa_Blank
	anv_TransactionManager.of_LoadExpression(lnv_AmountTemplate, lsa_Expression)
	ll_ExpressionMax = upperbound(lsa_Expression)
	lsa_DataPoint = lsa_Blank
	FOR ll_Index = 1 to ll_ExpressionMax
		anv_Transactionmanager.of_GetDataPoint(lsa_Expression[ll_index], lsa_DataPoint)
	NEXT 
	ll_DaysAfter = daysafter(ad_FirstDate, ad_LastDate)
	IF lb_Aggregatecalc = TRUE THEN
		// here's set up for the one pass for the entire date range
		ll_DaysAFter = 0
	END IF	

	FOR ll_Index = 0 to ll_DaysAfter
		//initerary range must be set before calling this method
		
		lds_Calculation = CREATE n_ds
		lds_Calculation.DataObject = "d_ItineraryData"
		lds_Calculation.InsertRow(0)
		// Set the instance itinerary in the transaction manager
		anv_TransactionManager.of_SetItineraryObject(lnv_itinerary)
		IF IsValid(lnv_AmountOwed) THEN  // of_GenerateAmount will return a new one
			// if one was created - we don't want the old one from the last
			// time thru this loop hanging around being re-counted into ll_AmountOwedCount
			lnv_AmountOwed = lnv_NullAmountOwed
		END IF
		anv_TransactionManager.of_LoadCalculationDAtastore(lsa_DataPoint, lds_Calculation)
		lc_Amount = anv_transactionmanager.of_GenerateAmount(lds_Calculation,  &
				lnv_AmountTemplate, lnv_NullTransaction, lnv_Amountowed)
		// if lc_Amount is 0 the of_generateAmount failed; but, existing code
		//  keeps going so this one does too.
		IF IsValid ( lnv_AmountOwed ) THEN
			ll_AmountOwedCount ++
			IF NOT IsNull(ll_TransactionId) THEN
				lnv_AmountOwed.of_SetFKTransaction_Direct(ll_TransactionId)
			END IF	 //		

		END IF
		IF lc_Amount <> 0 THEN
	
			ls_SplitsByExpression = lnv_AmountTemplate.of_GetSplitsby ( )
		
			IF Len (Trim(ls_SplitsByExpression)) > 0 THEN
			//run splitsby against total itinerary, this number will be used
			//when determining percentages of participating legs
				lds_Calculation.Object.cf_Numeric.Expression = ls_SplitsByExpression
				lc_TotalSplit = lds_Calculation.GetItemNumber ( 1, "cf_Numeric" )		
			ELSE
				lc_TotalSplit = 0		
			END IF			
			anv_transactionmanager.of_GeneratePaySplits(lnv_AmountTemplate, &
			lsa_datapoint, lnv_AmountOwed, lc_TotalSplit)		
		END IF
		IF IsValid(lds_Calculation) THEN
			DESTROY lds_Calculation
		END IF
	NEXT  // End of DaysAfter loop 
	IF ll_Return = -1 THEN
		EXIT
	END IF
NEXT // template loop


IF IsValid(an_Transaction) THEN
	an_Transaction.of_Calculate()
END IF
al_CountAO = ll_AmountOwedCount
Return ll_Return

end function

public function long of_processleg (n_cst_beo_amounttemplate anva_legtemplate[], n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, long al_firstrow, long al_lastrow, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, ref long al_countao);///////////////////////////////////////////////////////////////////////////////
//
//  
//
//	Function:  of_ProcessLeg
//  
//	Access:  public
//	Arguments: 
//					anva_legtemplate[]
//					anv_itinerary
//					anv_dispatch
//					al_FirstRow
//					al_LastRow
//					anva_amountowed[] 
//					an_transaction by reference
//					anv_transactionmanager by reference
//					al_CountA0 by reference, output, Count Amount Oweds
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for n_cst_bso_payable
//
//  	Loop through all the leg templates and process against leg. 
// This code logic is based upon existing behavior in of_templateloop.
//
//  All errors should be created between 00900-00999 for informational
// errors and 10900-10999 for severe errors.
//
// Written by: N. LeBlanc & J. Albert
// 		Date: 10.11.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
decimal	lc_Amount

long		ll_Template, &
			ll_TemplateCount, &
			ll_return, &
			ll_ExprCount, &
			ll_Counter, &
			ll_TransactionID, &
			ll_FirstRow, &
			ll_LastRow, &
			ll_Row, &
			ll_AmountCount

string	lsa_Expression[], &
			lsa_DataPoint[], &
			lsa_Blank[], &
			ls_type, &
			ls_TemplateName, &
			ls_ErrMsg
			
dwobject		ldwo_EventType

n_cst_events	lnv_events
n_cst_msg	lnv_Range
s_parm		lstr_Parm
n_ds			lds_LegData, &
				lds_EventCache
				
n_cst_Beo_AmountOwed			lnv_amountowed, &
									lnva_AmountOwed[], &
									lnv_NullAmountOwed
n_cst_beo_itinerary2			lnv_itinerary
n_cst_beo_Transaction		lnv_NullTransaction
n_cst_OFRError					lnv_Error

lnv_itinerary = anv_itinerary


lds_LegData = CREATE n_ds
lds_LegData.DataObject = "d_ItineraryData"

ll_FirstRow = al_FirstRow
ll_LastRow = al_LastRow

If IsValid(an_Transaction) THEN
	ll_TransactionID = an_Transaction.of_GetId()
ELSE
	SetNull(ll_Transactionid)
END IF

ll_TemplateCount = upperbound(anva_legtemplate)
lds_EventCache = lnv_Itinerary.of_GetEventCache( )

FOR ll_Row = ll_FirstRow TO ll_LastRow
					
	lnv_Range.of_Reset ( )
					
	lstr_Parm.is_Label = "StartRow"
	lstr_Parm.ia_Value = ll_Row
	lnv_Range.of_Add_Parm ( lstr_Parm )
						
	lstr_Parm.is_Label = "EndRow"
	lstr_Parm.ia_Value = ll_Row
	lnv_Range.of_Add_Parm ( lstr_Parm )
						
	lstr_Parm.is_Label = "ItinType"
	lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_Driver //  -- driver only
	lnv_Range.of_Add_Parm ( lstr_Parm )
						
	lstr_Parm.is_Label = "ItinId"
	lstr_Parm.ia_Value = il_ItinId
	lnv_Range.of_Add_Parm ( lstr_Parm )
						
	lstr_Parm.is_Label = "RetainExcludedShipments"
	lstr_Parm.ia_Value = TRUE
	lnv_Range.of_Add_Parm ( lstr_Parm )
			
	lnv_Itinerary.of_SetRange ( lnv_Range )
		
// after we have the true itinerary, check if it is a bobtail or
// bare chassis event.  If so, don't process leg.  Go to next event.
// jma *****

	lds_LegData.Reset()
	lds_LegData.InsertRow(0)
	anv_transactionmanager.of_setItineraryObject(lnv_itinerary)
	
	FOR ll_Template = 1 to ll_TemplateCount
		IF IsValid(anva_LegTemplate[ll_Template]) THEN
			// create the list of datapoints for this itinerary
			lsa_Expression = lsa_Blank
			anv_transactionmanager.of_LoadExpression(anva_legtemplate[ll_Template], lsa_Expression)
			ll_ExprCount = upperbound(lsa_Expression)
			lsa_DataPoint = lsa_Blank
			ls_TemplateName = trim(anva_LegTemplate[ll_Template].of_GetName())	
			FOR ll_Counter = 1 TO ll_ExprCount			
				anv_transactionmanager.of_GetDataPoint(lsa_Expression[ll_Counter], lsa_DataPoint)
			NEXT	
		
			lc_amount = 0		
			anv_transactionmanager.of_LoadCalculationDatastore(lsa_DataPoint, lds_LegData)			

			//For performance reasons, instead of passing the transaction to of_GenerateAmount and
			//letting it make the link normally, we're going to pass a null transaction and get an
			//unassigned amount back.  Then, we'll use of_SetFkTransaction_Direct to set the foreign
			//key, but avoid recalculating the transaction.  Then, at the end of the script, we'll
			//call of_Calculate on the transaction, so it will recognize the amounts we've assigned
			//to it.	
			IF IsValid(lnv_AmountOwed) THEN
				//nl
				destroy lnv_AmountOwed
//				lnv_AmountOwed = lnv_NullAmountOwed
			END IF
			//generate amount(s)
			//pass out in anva_AmountOwed[] and return # of amounts		
			lc_amount = anv_transactionmanager.of_GenerateAmount(lds_LegData, &
			 	anva_LegTemplate[ll_Template], lnv_Nulltransaction, lnv_AmountOwed)
			// If lc_amount is 0 of_generateamount failed. But, we keep going.  This
			// is the existing behavior.
			If IsValid(lnv_AmountOwed) THEN  // solve issue with anva_amountowed vs anv_amountowed.
			// if the amount owed was valid, put it into the amount oweds array. 
				IF NOT IsNull(ll_TransactionID) THEN
					lnv_AmountOwed.of_SetFkTransaction_Direct(ll_TransactionId)
				END IF
				ll_AmountCount ++
				lnva_AmountOwed[ll_AmountCount] = lnv_amountowed
				
			END IF // amount owed validity check

		// now do splits stuff		
			ldwo_EventType = lds_EventCache.Object.de_event_type
			ls_type = ldwo_EventType.Primary[ll_row]
			IF lnv_events.of_isTypeLocationOptional(ls_type) THEN
			// NOP - don't include it.
			ELSE
				lc_Amount = round(lc_Amount,2)
				IF lc_Amount <> 0 THEN  
					anv_transactionmanager.of_AddPaySplit(ll_Row, lc_Amount, lnv_Amountowed)
				END IF
			END IF // type optional
			lnv_itinerary.of_AppendExcludedShipmentsForRange()
		ELSE  // all of these leg templates should have been valid.
		// this is trouble
			ls_ErrMsg= "10975|A leg template for this employee can not be" + &
			" settled in autogen.  Please fix or delete this employee's template" + &
			" to settle in autogen."
			this.of_InsertErrorMsg(ls_ErrMsg)
			ll_Return = -1
			EXIT
		END IF  // valid leg template
		IF ll_Return < 0 THEN EXIT  // if problem found, stop processing
	NEXT // loop to next template
	IF ll_Return < 0 THEN EXIT  // if problem found, stop processing	
NEXT // loop to next ll_row	

IF IsValid(an_Transaction) THEN
	an_Transaction.of_Calculate()
END IF
DESTROY lds_LegData
// anva_amountowed = lnva_amountowed
al_CountAO = upperbound(lnva_amountowed)

return ll_return
end function

public function long of_subdividemove (ref n_cst_beo_itinerary2 anv_itinerary, n_cst_msg anv_msgoftemplates, n_cst_bso_dispatch anv_dispatch, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, n_cst_beo_entity anv_entity, ref long al_countao, boolean ab_searchprevious);///////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SubdivideMove
//  
//	Access:  publice
//
//	Arguments: 
//					anv_itinerary
//					anv_OfMsgTemplates
//					anv_dispatch
//					an_transaction by reference
//					anv_transactionmanager by reference
//					anv_entity					
//					al_CountAO by reference
//
//	Return:		ll_Return    
//					
//						
//
//	Description:
//			for n_cst_bso_payable
//
//  process move, leg, day, daterange
//  Leg processing is the main loop.  Before processing a leg template, we need to look 
//  ahead to see if we have a move range. If we do then process any move templates before the
//  leg templates. Check the arrive date for crossing into another day. If we do cross into
//  another day, process any day templates. At the end, process any daterange templates and
//  any accessorial charges.
//  	
//
// Written by: N. LeBlanc & J. Albert
// 		Date: 10.11.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
long	ll_EventCount, &
		ll_index, &
		ll_forward, &
		ll_AOCount, &
		ll_GenCount, &
		ll_MoveCount, &
		ll_DayCount, &
		ll_LegCount, &
		ll_DateRangeCount, &
		ll_FirstEvent, &
		ll_FirstDayEvent = 1, &
		ll_LastRangeEvent, &
		ll_MsgCountMax, &
		ll_Return = 1, &
		ll_PartialAOCount, &
		ll_offset, &
		ll_startrow, &
		ll_FirstRowofItinerary, &
		ll_itinid, &
		ll_shipcount, &
		lla_NonIntermodal[]

integer	ret

date	ld_Arrived, &
		ld_hold, &
		ld_Start, &
		ld_End

string	ls_EventType

n_cst_beo_shipment	lnva_ship[]
n_cst_beo_event	lnva_Event[], &
						lnva_blankevent[]
n_cst_beo_amounttemplate	lnva_MoveTemplate[], &
								lnva_LegTemplate[], &
								lnva_DayTemplate[], &
								lnva_DateRangeTemplate[]

n_cst_msg		lnv_MsgOfTemplates, &
					lnv_range
s_Parm			lstr_Parm
n_cst_AnyArraySrv	lnv_ArraySrv
datastore		lds_eventcache

IF IsValid(anv_MsgOfTemplates) THEN
	ll_MsgCountMax = anv_MsgOfTemplates.of_get_count()
	FOR ll_Index = 1 TO ll_MsgCountMax
		anv_MsgOfTemplates.of_Get_Parm(ll_Index, lstr_Parm)
		CHOOSE CASE upper(lstr_Parm.is_Label)
			CASE "DAY"
				lnva_DayTemplate = lstr_Parm.ia_Value
			CASE "DATERANGE"
				lnva_DateRangeTemplate = lstr_Parm.ia_Value
			CASE "LEG"
				lnva_LegTemplate = lstr_Parm.ia_Value
			CASE "MOVE"
				lnva_MoveTemplate = lstr_Parm.ia_Value
		END CHOOSE
	NEXT  
END IF

if this.of_ExcludeNonIntermodalType() then
	//get list
	ll_shipcount = anv_Itinerary.of_GetShipment(lnva_ship)
	for ll_index = 1 to ll_shipcount
		if lnva_ship[ll_index].of_isIntermodal( ) then
			//ok
		else
			lla_NonIntermodal[upperbound(lla_NonIntermodal) + 1] = lnva_ship[ll_index].of_getid()
		end if
	next
	if upperbound(lla_NonIntermodal) > 0 then
		anv_itinerary.of_SetExcludedShipments(lla_NonIntermodal)
	end if
	
end if
ll_EventCount = anv_itinerary.of_GetEventList(lnva_Event, true)
ll_LastRangeEvent = 1

ll_MoveCount = upperbound(lnva_MoveTemplate[])
ll_LegCount = upperbound(lnva_LegTemplate)
ll_DayCount = upperbound(lnva_DayTemplate)
ll_DateRangeCount = upperbound(lnva_DateRangeTemplate)
ld_Start = anv_itinerary.of_getStartDate()
ld_End = anv_itinerary.of_GetEndDate()

//keep track of date for day templates
if ll_eventcount > 0 then
	ld_hold = lnva_Event[1].of_GetDateArrived()
	ll_itinid = lnva_Event[1].of_gettractorid()
end if

lds_EventCache = anv_Itinerary.of_GetEventCache( )

/*
	We need to look at the first event to determine if we need to look to the 
	previous period to get a complete move. Preserve lnva_event[1].
*/
if ab_SearchPrevious then
	if ll_eventcount > 0 then
		anv_itinerary.of_ResetEventList()
		ll_startrow = this.of_FindStartofMove ( lnva_Event[1], anv_itinerary, anv_Dispatch, ll_FirstRowofItinerary ) 
	end if
end if

if ll_startrow > 0 then
	//we found a partial that needs to be processed
	//get a new list
	lnv_ArraySrv.of_destroy(lnva_Event)
	lnva_Event = lnva_blankevent
	ll_EventCount = anv_itinerary.of_GetEventList(lnva_Event, true)

	//process from the start row
	ll_GenCount = this.of_processMove(lnva_MoveTemplate, anv_itinerary, lnva_Event, anv_dispatch, &
	ll_startrow, ll_LastRangeEvent, an_transaction, &
	anv_transactionmanager)
	
	//reset last event
	ll_LastRangeEvent = 0
	
	if ll_GenCount > 0 then
		ll_AOCount += ll_GenCount
	end if

	//reset itinerary to current period
	//this is because we need the other types of templates in the loop to 
	//process against the current period and not double pay last period
	//
	
	anv_itinerary.of_ResetEventList()
	
	lnv_Range.of_Reset ( )
	
	lstr_Parm.is_Label = "StartDate"
	lstr_Parm.ia_Value = ld_Start
	lnv_Range.of_Add_Parm ( lstr_Parm )	
	
	lstr_Parm.is_Label = "EndDate"
	lstr_Parm.ia_Value = ld_End
	lnv_Range.of_Add_Parm ( lstr_Parm )				
	
	lstr_Parm.is_Label = "ItinType"
	lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_PowerUnit
	lnv_Range.of_Add_Parm ( lstr_Parm )
						
	lstr_Parm.is_Label = "ItinId"
	lstr_Parm.ia_Value = ll_itinid
	lnv_Range.of_Add_Parm ( lstr_Parm )
						
	lstr_Parm.is_Label = "RetainExcludedShipments"
	lstr_Parm.ia_Value = TRUE
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	anv_Itinerary.of_SetRange ( lnv_Range )
	
	lnv_ArraySrv.of_destroy(lnva_Event)
	lnva_Event = lnva_blankevent
	ll_EventCount = anv_itinerary.of_GetEventList(lnva_Event, true)

end if

for ll_index = 1 to ll_EventCount
	
	//check event after last move range processed
	if ll_index >= ll_LastRangeEvent then
		CHOOSE CASE lnva_Event[ll_Index].of_GetType()
			CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Mount
				if ll_index = ll_eventcount then 
					//no move to look for
				else
					ll_FirstEvent=ll_Index
					//ll_LastRangeEvent will be passed back
					ll_GenCount = this.of_processMove(lnva_MoveTemplate, anv_itinerary, lnva_Event, anv_dispatch, &
					ll_FirstEvent, ll_LastRangeEvent, an_transaction, &
					anv_transactionmanager)
					if ll_GenCount > 0 then
						ll_AOCount += ll_GenCount
					end if
				end if
					
		END CHOOSE
	end if

	ld_Arrived = lnva_Event[ll_index].of_GetDateArrived()
	IF IsNull(ld_Arrived) THEN
		ld_Arrived = ld_Hold  
	ELSE
		if ld_Arrived <> ld_hold AND ll_DayCount > 0 then
		//process day templates before new leg

			ll_PartialAOCount = 0
			// process day templates
			this.of_ProcessDayOrDateRange(lnva_DayTemplate, anv_Itinerary, anv_dispatch, &
							ld_hold, ld_hold, an_transaction, anv_transactionmanager, ll_PartialAOCount)
			ll_AOCount += ll_PartialAOCount
			ll_FirstDayEvent = ll_index
			ld_hold = ld_Arrived

		end if
	END IF
	
	//process accessorials

	ll_offset = lnva_Event[ll_index].of_getsourcerow() - ll_index


	lnv_Range.of_Reset ( )
					
	lstr_Parm.is_Label = "StartRow"
	lstr_Parm.ia_Value = ll_index + ll_offset
	lnv_Range.of_Add_Parm ( lstr_Parm )	
	
	lstr_Parm.is_Label = "EndRow"
	lstr_Parm.ia_Value = ll_index + ll_offset
	lnv_Range.of_Add_Parm ( lstr_Parm )							
	
	lstr_Parm.is_Label = "ItinType"
	lstr_Parm.ia_Value = gc_Dispatch.ci_itinType_Driver
	lnv_Range.of_Add_Parm(lstr_Parm)

	lstr_Parm.is_Label = "ItinId"
	lstr_Parm.ia_Value = il_ItinId
	lnv_Range.of_Add_Parm(lstr_Parm)

	lstr_Parm.is_Label = "RetainExcludedShipments"
	lstr_Parm.ia_Value = TRUE
	lnv_Range.of_Add_Parm ( lstr_Parm )							

	anv_Itinerary.of_SetRange(lnv_Range)
	
	ll_PartialAOCount = 0
	//process accessorials
	this.of_ProcessAccessorial(lnva_MoveTemplate, an_transaction, anv_Itinerary, &
						anv_entity, anv_transactionmanager, anv_dispatch, ll_PartialAOCount, ld_Start, ld_End )
	ll_AOCount += ll_PartialAOCount

	// only do leg processing if you have leg template(s)
	// and if you haven't processed this range already.
		ll_offset = lnva_Event[ll_index].of_getsourcerow() - ll_index


	IF ll_LegCount > 0 THEN
		ll_PartialAOCount = 0
		this.of_ProcessLeg(lnva_LegTemplate, anv_itinerary, anv_dispatch, ll_index + ll_offset, ll_index + ll_offset, &
								an_transaction, anv_transactionmanager, ll_partialAOCount)
		ll_AOCount += ll_PartialAOCount	
	END IF
NEXT

IF ll_EventCount > 0 AND ll_DayCount > 0 THEN
	//process the day templates for the last day.
	ll_PartialAOCount = 0
	this.of_ProcessDayOrDateRange(lnva_DayTemplate, anv_Itinerary, anv_dispatch, &
							ld_hold, ld_hold, an_transaction, anv_transactionmanager, ll_PartialAOCount)
	ll_AOCount += ll_PartialAOCount	
END IF

IF ll_DateRangeCount > 0 THEN
	//process daterange	
	ll_PartialAOCount = 0
	this.of_ProcessDayOrDateRange(lnva_DateRangeTemplate, anv_Itinerary, anv_dispatch, &
							ld_Start, ld_End, an_transaction, anv_transactionmanager, ll_PartialAOCount)
	ll_AOCount += ll_PartialAOCount		
END IF

al_CountAO = ll_AOCount
Return ll_return

end function

public function boolean of_excludenonintermodaltype ();boolean	lb_exclude

n_cst_setting_ExcludeNonIntermodalType	lnv_Setting

lnv_Setting = create n_cst_setting_ExcludeNonIntermodalType

IF lnv_Setting.of_Getvalue( ) = lnv_Setting.cs_Yes THEN
	//filter events belonging to non-intermodal shipments
	lb_exclude = TRUE
ELSE
	lb_exclude = FALSE
END IF

destroy lnv_setting

return lb_exclude
end function

public function decimal of_getitemquantity (n_cst_beo_item anv_item, string as_ratetype);decimal lc_quantity


CHOOSE CASE as_ratetype
		
CASE appeon_constant.cs_RateUnit_Code_Flat, appeon_constant.cs_RateUnit_Code_Minimum, &
	  appeon_constant.cs_RateUnit_Code_Maximum
	  lc_quantity = anv_item.of_getQuantity() 

CASE appeon_constant.cs_RateUnit_Code_PerUnit, appeon_constant.cs_RateUnit_Code_Piece, &
	  appeon_constant.cs_RateUnit_Code_Gallon
	  lc_quantity = anv_item.of_getQuantity() 

CASE appeon_constant.cs_RateUnit_Code_PerMile
	lc_quantity = anv_item.of_getMiles()
	
CASE appeon_constant.cs_RateUnit_Code_Pound
	lc_quantity = anv_item.of_getTotalWeight()
	
CASE appeon_constant.cs_RateUnit_Code_100Pound, appeon_constant.cs_RateUnit_Code_Class
	lc_quantity = anv_item.of_getTotalWeight() / 100 
	
CASE appeon_constant.cs_RateUnit_Code_Ton
	lc_quantity = anv_item.of_getTotalWeight() / 2000
	
CASE ELSE  //cs_RateType_None
	lc_quantity = anv_item.of_getQuantity()

END CHOOSE

return lc_quantity
end function

public function long of_processpointtopoint (n_cst_beo_event anva_event[], n_cst_beo_itinerary2 anv_itinerary, n_cst_bso_dispatch anv_dispatch, long al_origin, long al_destination, ref n_cst_beo_transaction an_transaction, ref n_cst_bso_transactionmanager anv_transactionmanager, n_cst_beo_amounttemplate anva_template[]);///////////////////////////////////////////////////////////////////////////////
//
//	Function		:of_ProcessPointtoPoint
//  
//	Access		:private
//
//	Arguments	:anva_event[]
//					anv_itinerary
//					anv_dispatch
//					al_firstevent
//					al_lastevent
//					an_transaction by reference
//					anv_transactionmanager by reference
//					anva_movetemplates[]
//
//	Return		:ll_Return    
//					 the number of amounts generated
//						
//
//	Description	:Look for shipments in the itinerary range.  Get the items in the
//					 shipment.  The item type must be freight.  If there is a payable 
//					 amount on the item then use it, else try finding it in the rate tables.
//					 If the freight type is standard and the move type is Import or Export 
//					 then divide the pay in half.
//
//
// Written by: N. LeBlanc 
// 		Date: 07/26/2004
//		Version: 4.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
boolean 	lb_shipfound, &
			lb_ratecode

integer	li_amounttype

long		ll_ShipCount, &
			ll_shipId, &
			lla_shipId[], &
			ll_index, &
			ll_Eventndx, &
			ll_Itemndx, &
			ll_ItemCount, &
			ll_Template, &
			ll_TemplateCount, &
			ll_TransactionId, &
			ll_amountcount, &
			lla_amountid[], &
			ll_Max, &
			ll_rowcount, &
			ll_count, &
			ll_value, &
			ll_firstevent, &
			ll_lastevent, &
			ll_listcount
			
decimal	lc_Amount, &
			lc_Quantity, &
			lc_rate, &
			lc_payamount, &
			lc_percentage, &
			lc_null, &
			lc_miles

string	ls_ratecodename, &
			ls_ShipMoveCode, &
			ls_value, &
			ls_null, &
			ls_type, &
			ls_description, &
			ls_publicnote, &
			ls_powerunit, &
			ls_container, &
			ls_trailer, &
			ls_driver, &
			lsa_list[], &
			lsa_blank[]

boolean	lb_RateIt

n_ds					lds_ShipmentCache, &
						lds_ItemCache, &
						lds_EventCache, &
						lds_eventcopy
n_ds					lds_paysplitcache
n_cst_dws	lnv_Dws
n_cst_anyarraysrv			lnv_Arraysrv
n_cst_beo_Amountowed	lnva_Amountowed[], &
							lnv_NullAmountOwed
n_cst_beo_shipment	lnv_shipment
n_cst_beo_item			lnva_Item[]
n_cst_ratedata			lnv_ratedata
n_cst_EmployeeManager	lnv_EmployeeManager
n_cst_beo_AmountType	lnv_AmountType

setnull(lc_null)
setnull(ls_null)

ll_firstevent = 1
ll_lastevent = upperbound(anva_event)

If IsValid(an_Transaction) THEN
	ll_TransactionID = an_Transaction.of_GetId()
ELSE
	SetNull(ll_Transactionid)
END IF

ll_TemplateCount= upperbound(anva_Template)
//get ship ids from event range
ll_shipcount = 0
for ll_Eventndx = ll_firstevent to ll_lastevent
	ll_ShipId = anva_event[ll_Eventndx].of_GetShipment()
	if isnull(ll_shipid) or ll_shipid = 0 then
		continue
	else
		ll_ShipCount ++
		lla_shipid[ll_ShipCount] = ll_ShipId
	end if	
next
ll_shipcount = lnv_Arraysrv.of_getshrinked(lla_shipid,true,true)

//get shipments and items
anv_Dispatch.of_RetrieveShipments ( lla_ShipId )

lds_ShipmentCache = anv_Dispatch.of_GetShipmentCache ( )
lds_ItemCache = anv_Dispatch.of_GetItemCache ( )				
lds_EventCache = anv_Dispatch.of_GetEventCache ( )		
/*
	using my own copy of the cache for filtering events to the shipment 
	and not including itinerary events for move processing
*/
lnv_Dws.of_CreateDataStoreByDataObject ( "d_itin", lds_eventcopy, TRUE )
lds_eventcache.rowscopy(1, lds_eventcache.rowcount(), Primary!, lds_eventcopy, 1, Primary!)
lds_eventcache.rowscopy(1, lds_eventcache.filteredcount(), Filter!, lds_eventcopy, 1, Filter!)

lnv_shipment = CREATE n_cst_Beo_Shipment
lnv_shipment.of_SetSource ( lds_shipmentCache )
lnv_shipment.of_SetItemSource ( lds_ItemCache )

//look for shipments in range
FOR ll_Index = 1 to ll_Shipcount
	lnv_shipment.of_SetSourceid ( lla_ShipId[ll_index] )
	
	IF isValid ( lds_eventcopy ) THEN
		lds_eventcopy.SetFilter ( "de_shipment_id = " + string(lla_ShipId[ll_index]) )
		lds_eventcopy.SetSort ( "de_ship_seq A" )
		lds_eventcopy.Filter ( )
		lds_eventcopy.Sort ( )
	END IF

	lnv_shipment.of_SetEventSource ( lds_eventcopy )
	ls_ShipMoveCode = lnv_shipment.of_GetMoveCode()	
	
	ll_ItemCount = this.of_getshipmentitems(anv_dispatch, lnv_shipment, ls_null, '', lnva_item )
	
	for ll_Itemndx = 1 to ll_ItemCount
		
		//must be a freight item type to be processed here, accessorial types will be
		//processed in the accessorial processing
		if lnva_item[ll_Itemndx].of_gettype() = n_cst_constants.cs_ItemType_Freight then
			//ok to process
		else
			CONTINUE
		end if
	
		for ll_Template = 1 to ll_TemplateCount
			lc_quantity = 0
			lc_rate = 0
			lc_payamount = 0
			ls_description = ''
			//set point to point miles
			lc_miles = anv_itinerary.of_Gettotalmiles()
			if isnull(lc_miles) THEN
				lc_miles = 0
			end if

//***

			lnv_ratedata = create n_cst_ratedata
			if this.of_setratedata(anva_template[ll_Template], lnv_shipment, lnva_item[ll_itemndx], &
								lnv_Ratedata, al_origin, al_destination) then
				//we have a ratadata object 
				if lnv_Ratedata.of_LookAtShipmentcode() then
					//is there pay on the itenm
					//if the item has a pay amount use it
					lc_payamount = lnva_item[ll_itemndx].of_getpayableamount()
					if lc_payamount > 0 then
						lc_quantity = this.of_GetItemQuantity(lnva_item[ll_itemndx], lnva_item[ll_itemndx].of_getpayratetype() )
						lc_rate = lnva_item[ll_itemndx].of_getpayrate()
						lb_ratecode=false
						li_amounttype = lnva_item[ll_itemndx].of_getamounttype()
						ls_description = lnva_item[ll_itemndx].of_getdescription()
						lb_RateIt = false
					else
						lb_RateIt = true
					end if
				else
					//we have a rate code but not looking at the shipment for pay
					lb_RateIt = true
				end if
			else
				lb_RateIt = false
			end if
			
			if lb_RateIt then
				//set to item freight charges
				lc_quantity = this.of_GetItemQuantity(lnva_item[ll_itemndx], lnva_item[ll_itemndx].of_getratetype())
				lc_rate = lnva_item[ll_itemndx].of_getrate()
				lc_payamount = lnva_item[ll_itemndx].of_getFreightCharges()				

				//  try auto rating
				lnv_ratedata.of_settotalmiles(lc_miles)	
				lnv_ratedata.of_SetCategory(n_cst_constants.ci_Category_Payables)
				this.of_getratedata(lnv_shipment, lnva_item[ll_itemndx], lnv_Ratedata)
				lb_ratecode=true
				ls_ratecodename = lnv_ratedata.of_GetCodename()
				if len(trim(ls_ratecodename)) > 0 then
					if ls_Ratecodename = 'CUSTOM' then
						//SKIP
					else
						//have amount replace 
						lc_rate = lnv_ratedata.of_Getrate()
						lc_payamount = lnv_ratedata.of_GetTotalCharge()
						if lnv_ratedata.of_Getratetype() = appeon_constant.cs_RateUnit_Code_Flat then
							lc_quantity = 1
						else
							lc_Quantity = lnv_ratedata.of_GetTotalCount()
						end if
						li_amounttype = lnv_ratedata.of_GetAmounttype()
						if isnull(li_amounttype) or li_amounttype = 0 then
							li_amounttype = lnva_item[ll_itemndx].of_getamounttype()
						end if
						if lnv_ratedata.of_usedSubstitution() or lnv_ratedata.of_usedfallback() then
							ls_description = lnv_ratedata.of_GetDescription()
						else
							ls_description = lnva_item[ll_itemndx].of_getdescription()
						end if
					end if
				else
					if lnva_item[ll_itemndx].Of_GetRateCodeName() = 'CUSTOM'  OR lnva_item[ll_itemndx].Of_GetRateCodeName() = '' OR IsNull (lnva_item[ll_itemndx].Of_GetRateCodeName() ) then
						//	If we didn't find a rate code and the item rate is 'custom' then ZERO AMOUNT OWED
						lc_payamount = 0
						li_amounttype = lnva_item[ll_itemndx].of_getamounttype()
						ls_description = lnva_item[ll_itemndx].of_getdescription()
					else
						li_amounttype = lnva_item[ll_itemndx].of_getamounttype()
						ls_description = lnva_item[ll_itemndx].of_getdescription()
						lc_percentage = lnv_ratedata.of_GetFreightPayablePercentage() / 100
						if lc_percentage > 0 then
							lc_quantity = lc_null
							lc_rate = lc_null
							lc_payamount = lc_payamount * lc_percentage											
						end if
					end if
				end if
			end if
			
			if lc_payamount = 0 or isnull(lc_payamount) then
				//no rate code, no percentage, no pay
				continue
			end if
		
			ll_AmountCount ++
			destroy lnva_Amountowed[ll_AmountCount]

			//generate amount(s)
			lc_payamount = round(lc_payamount,2)
			lc_quantity = round(lc_quantity,3)
			lc_rate = round(lc_rate,4)
			
			if isnull(li_amounttype) or li_amounttype = 0 then
				CONTINUE
			else
				//is it a settlement type
				IF anv_transactionmanager.of_GetAmountType ( li_amounttype , lnv_AmountType ) = 1 THEN
					choose case lnv_AmountType.of_GetCategory ( )
						case n_cst_constants.ci_category_receivables
							CONTINUE
						case n_cst_constants.ci_category_Payables, n_cst_constants.ci_category_both
							CHOOSE CASE lnva_Item[ll_Itemndx].of_GetAccountingType()	
								CASE n_cst_constants.cs_AccountingType_Billable
									CONTINUE
								CASE n_cst_constants.cs_AccountingType_Payable, n_cst_constants.cs_AccountingType_Both 	
									lc_amount = this.of_GenerateAmountowed(an_transaction, anv_transactionmanager, &
												 li_amounttype, ls_description, lnva_Amountowed[ll_AmountCount], &
												 lc_payamount, lc_Rate, lc_quantity )
								CASE ELSE
									CONTINUE
							END CHOOSE
						case else
							CONTINUE
					end choose							
				END IF
			END IF

			If IsValid(lnva_Amountowed[ll_AmountCount]) THEN  
				if lb_ratecode then
					lnva_Amountowed[ll_AmountCount].of_SetRateCodename(lnv_ratedata.of_Getcodename())
					lnva_Amountowed[ll_AmountCount].of_SetOriginzone(lnv_ratedata.of_GetOriginzone())
					lnva_Amountowed[ll_AmountCount].of_SetDestinationzone(lnv_ratedata.of_GetDestinationzone())
					lnva_Amountowed[ll_AmountCount].of_SetbilltoId(lnv_ratedata.of_GetbilltoId())
				end if
				lnva_Amountowed[ll_AmountCount].of_SetDivision(this.of_GetDivision(lnv_shipment))
				lnva_Amountowed[ll_AmountCount].of_SetStartDate ( anva_event[ll_firstevent].of_GetDateArrived() )
				lnva_Amountowed[ll_AmountCount].of_SetEndDate ( anva_event[ll_lastevent].of_GetDateArrived() )
				lnva_Amountowed[ll_AmountCount].of_SetShipment ( string(lnv_shipment.of_Getid()) ) //parent shipment
				
				ls_description = lnva_Amountowed[ll_AmountCount].of_GetDescription()
				if len(trim(ls_description)) > 0 then
					//already set
				else
					lnva_Amountowed[ll_AmountCount].of_SetDescription ( anva_template[ll_Template].of_GetDescription ( ) )
				end if
				
				ls_publicnote=''
				ls_powerunit=''
				ls_trailer=''
				ls_container=''
				ls_driver=''
				
				//public note
				lsa_List = lsa_blank
				ll_listcount = 0
				for ll_Eventndx = ll_firstevent to ll_lastevent	
					ls_value = anva_event[ll_Eventndx].of_GetLocation ( )
					if len(trim(ls_value)) > 0 then
						ll_listcount ++
						lsa_list[ll_listcount] = ls_value
					end if
				next
				ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, false /*Shrink dupes */)
				for ll_count = 1 to ll_max
					if len(trim(lsa_List[ll_count])) > 0 then
						if len(trim(ls_publicnote)) > 0 then
							ls_publicnote += ', '
						end if
						ls_publicnote += lsa_List[ll_count]	
					end if
				next
				if lc_miles > 0 then
					ls_publicnote += ' MILES = ' + string(lc_miles,'#,##0.00')
				end if
				//powerunit	
				lsa_List = lsa_blank
				ll_listcount = 0
				for ll_Eventndx = ll_firstevent to ll_lastevent		
					ls_value = anva_event[ll_Eventndx].of_GetPowerUnit ( )
					if len(trim(ls_value)) > 0 then
						ll_listcount ++
						lsa_list[ll_listcount] = ls_value
					end if
				next
				ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
				for ll_count = 1 to ll_max
					if len(trim(ls_powerunit)) > 0 then
						ls_powerunit += ', '
					end if
					ls_powerunit += lsa_List[ll_count]			
				next
				//trailer		
				lsa_List = lsa_blank
				ll_listcount = 0
				for ll_Eventndx = ll_firstevent to ll_lastevent						
					ls_value = anva_event[ll_Eventndx].of_GetTrailerList ( )
					if len(trim(ls_value)) > 0 then
						ll_listcount ++
						lsa_list[ll_listcount] = ls_value
					end if
				next
				ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
				for ll_count = 1 to ll_max
					if len(trim(ls_trailer)) > 0 then
						ls_trailer += ', '
					end if
					ls_trailer += lsa_List[ll_count]			
				next
				//container
				lsa_List = lsa_blank
				ll_listcount = 0
				for ll_Eventndx = ll_firstevent to ll_lastevent		
					ls_value = anva_event[ll_Eventndx].of_GetcontainerList ( )
					if len(trim(ls_value)) > 0 then
						ll_listcount ++
						lsa_list[ll_listcount] = ls_value
					end if
				next
				ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
				for ll_count = 1 to ll_max
					if len(trim(ls_container)) > 0 then
						ls_container += ', '
					end if
					ls_container += lsa_List[ll_count]			
				next
				//driver
				lsa_List = lsa_blank
				ll_listcount = 0
				for ll_Eventndx = ll_firstevent to ll_lastevent		
					ll_value = anva_event[ll_Eventndx].of_GetDriverid ( )
					if ll_value > 0 then
						IF lnv_EmployeeManager.of_DescribeEmployee ( ll_value, ls_value, &
																					appeon_constant.ci_DescribeType_LastFirst ) = 1 THEN
							ll_listcount ++
							lsa_list[ll_listcount] = ls_value
						END IF
					end if
				next
				ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)
				for ll_count = 1 to ll_max
					if len(trim(ls_Driver)) > 0 then
						ls_Driver += ', '
					end if
					ls_Driver += lsa_List[ll_count]			
				next

				lnva_Amountowed[ll_AmountCount].of_SetPublicNote ( ls_publicnote )
				lnva_Amountowed[ll_AmountCount].of_SetTruck ( ls_powerunit )
				lnva_Amountowed[ll_AmountCount].of_SetTrailer ( ls_trailer )
				lnva_Amountowed[ll_AmountCount].of_SetContainer ( ls_container )
				lnva_Amountowed[ll_AmountCount].of_SetDriver ( ls_driver )
				
			// if the amount owed was valid, put it into the amount oweds array. 
				IF NOT IsNull(ll_TransactionID) THEN
					lnva_Amountowed[ll_AmountCount].of_SetFkTransaction_Direct(ll_TransactionId)
				END IF
			END IF // amount owed validity check

		// now do splits stuff		

		next // end of template loop
		
	next	//end of item loop
		
next	//end of ship loop

if isvalid(an_transaction) then
	an_transaction.of_calculate()
end if
IF ll_AmountCount > 0 THEN
	lds_PaySplitCache = anv_transactionmanager.of_GetPaySplitCache(true)
	this.of_addmoverangesplits(anva_event, ll_firstevent, ll_lastevent, lnva_amountowed, lds_PaySplitCache )
	anv_transactionmanager.of_SetPaySplitCache(lds_PaySplitCache)
END IF			

if isvalid(lnv_Ratedata) then
	destroy lnv_Ratedata
end if
if isvalid(lds_EventCopy) then
	destroy lds_EventCopy
end if
		
IF IsValid(lnv_shipment) THEN
	DESTROY lnv_shipment
END IF


ll_ItemCount = upperbound(lnva_item)
//left over items	
for ll_itemndx = 1 to ll_itemcount
	if isvalid(lnva_item[ll_itemndx]) then
		destroy lnva_item[ll_itemndx]
	end if
next

return ll_AmountCount
end function

protected function long of_addmoverangesplits (n_cst_beo_event anva_event[], long al_firstevent, long al_lastevent, ref n_cst_beo_amountowed anva_amountowed[], ref n_ds ads_paysplitcache);//must be a freight item type to be processed here
long		ll_return, &
			ll_index, &
			ll_nextid, &
			ll_Eventndx, &
			ll_locationcount, &
			ll_AmountCount, &
			ll_paysplitrow
decimal	lc_Amount, &
			lc_runningtotal, &
			lc_amounttosplit

string	ls_type

constant boolean	cb_commit = true
			
n_cst_events			lnv_events

ll_locationcount = 0
ll_amountcount = upperbound(anva_amountowed)
for ll_index = 1 to ll_AmountCount
	if isvalid(anva_amountowed[ll_index]) then
		//ok
	else
		CONTINUE
	end if
	
	for ll_Eventndx = al_FirstEvent to al_lastevent
		if isvalid(anva_event[ll_Eventndx]) then
			//ok
		else
			CONTINUE
		end if
		
		ls_type = anva_event[ll_Eventndx].of_GetType()
		IF lnv_events.of_isTypeLocationOptional(ls_type) THEN
			//don't count
		else
			ll_locationcount ++
		end if
	next
	
	lc_amounttosplit = anva_amountowed[ll_index].of_Getamount()
	if ll_locationcount = 0 then
		lc_amount = lc_amounttosplit
	else
		lc_Amount = round(lc_amounttosplit / ll_locationcount, 2)
	end if
	
	for ll_Eventndx = al_FirstEvent to al_lastevent
		if isvalid(anva_event[ll_Eventndx]) then
			//ok
		else
			CONTINUE
		end if
		
		ls_type = anva_event[ll_Eventndx].of_GetType()
		IF lnv_events.of_isTypeLocationOptional(ls_type) THEN
			//  don't include it.
			continue
		ELSE
			IF ll_Eventndx = al_lastevent THEN
				lc_Amount = lc_amounttosplit - lc_RunningTotal
			ELSE
				IF Abs ( lc_RunningTotal + lc_Amount ) > Abs ( lc_amounttosplit ) THEN
					lc_Amount = lc_amounttosplit - lc_RunningTotal
				END IF
			END IF
	
		END IF
		
		IF lc_Amount <> 0 	THEN
			ll_PaySplitRow = ads_PaySplitCache.InsertRow(0)
			
			IF gnv_App.of_GetNextId ( "paysplit", ll_NextId, cb_Commit ) = 1 THEN
				ads_PaySplitCache.object.id[ll_PaySplitRow] = ll_NextId
			
				ads_PaySplitCache.object.amountid[ll_PaySplitRow] = anva_AmountOwed[ll_index].of_GetId( )
				ads_PaySplitCache.object.eventid[ll_PaySplitRow] = anva_event[ll_Eventndx].of_GetId()
				ads_PaySplitCache.object.shipmentid[ll_PaySplitRow] = anva_event[ll_Eventndx].of_GetShipment()
				//turned off
				ads_PaySplitCache.object.paysplit[ll_PaySplitRow] = lc_Amount
				ads_PaySplitCache.object.itemtype[ll_PaySplitRow] = n_cst_constants.cs_itemtype_freight
					
			END IF			
			
			lc_RunningTotal += lc_Amount
	
		END IF // type optional
	//don't forget remainder
	next
next

return ll_return
end function

public function any of_setratedata (n_cst_beo_amounttemplate anv_template, n_cst_beo_shipment anv_shipment, n_cst_beo_item anv_item, ref n_cst_ratedata anv_ratedata, long al_origin, long al_destination);/*
//		arguments:		anv_template
//							anv_shipment
//							anv_item
//							anv_ratedata by reference
//							al_origin
//							al_destination
*/
//create a ratedata object with the ratecode substitutions and fallbacks
//
//	Modification History
//
//	3-18-07 BKW  Set the category to Payables.  This was done so n_cst_RateData.of_SetCodeName could tell when it was 
//						being used in payables processing.

string	ls_amount, &
			ls_rate, &
			ls_ratecode
			
boolean	lb_ratecode, &
			lb_rate

n_cst_ratedata	lnva_ratedata[]
n_cst_bso_rating	lnv_rating

if isvalid(anv_template) then
	ls_amount = anv_template.of_GetAmount()
	ls_rate = anv_template.of_GetRate()
end if

if len(trim(ls_amount)) > 0 then
	if left(ls_amount,1) = ':' then
		ls_ratecode = ls_amount
	end if
else
	if len(trim(ls_rate)) > 0 then
		if left(ls_rate,1) = ':' then
			ls_ratecode = ls_rate
		end if
	end if
end if

if len(ls_ratecode) > 0 then
	lb_ratecode=true
	lnv_rating = create n_cst_bso_rating
	
	lnv_rating.of_setorigin(al_origin, anv_ratedata)
	lnv_rating.of_setdestination(al_destination, anv_ratedata)
	anv_ratedata.of_Setitemtype(anv_item.of_gettype())
	anv_ratedata.of_SetItemEventType(anv_item.of_getEventTypeFlag())
	//of_SetCategory was added 3-18-07 BKW
	anv_ratedata.of_SetCategory ( n_cst_Constants.ci_Category_Payables )
	anv_ratedata.of_SetCodename(ls_ratecode)
	
	destroy lnv_rating

end if

return lb_ratecode

end function

private subroutine of_getratedata (n_cst_beo_shipment anv_shipment, n_cst_beo_item anv_item, ref n_cst_ratedata anv_ratedata);/*
//		arguments:		anv_template
//							anv_shipment
//							anv_item
//							anv_ratedata by reference
*/
//send item, shipment and ratedata object to rating

boolean	lb_rate

n_cst_ratedata	lnva_ratedata[]
n_cst_bso_rating	lnv_rating

lnv_rating = create n_cst_bso_rating
lnva_ratedata[1] = anv_ratedata

//MessageBox ("Shipment" , STRING ( anv_shipment.of_GetId ( ) ) )
lnva_ratedata[1].of_SetShipID (  anv_shipment.of_GetId ( ) )
choose case anv_item.of_gettype()
	case  n_cst_constants.cs_ItemType_Freight 
		if anv_ratedata.of_GetFreightPayablePercentage() > 0 then
			//dont go into rating object rate just using percentage
			lb_rate = false
		else
			lb_rate = true 
		end if

	case n_cst_constants.cs_ItemType_Accessorial
		if anv_ratedata.of_GetAccessPayablePercentage() > 0 then
			//dont go into rating object rate just using percentage
			lb_rate = false
		else
			lb_rate = true 
		end if
		
	case else
		lb_rate = true
		
end choose

if lb_rate then
	anv_ratedata.of_Setcodename(anv_item.of_getratecodename())
	lnv_rating.of_SetCodeOverride(anv_ratedata.of_Getcodename())
	lnv_rating.of_autorate(anv_shipment, {anv_item} , lnva_ratedata, n_cst_constants.ci_category_payables)
end if

destroy lnv_rating

anv_ratedata = lnva_ratedata[1]


end subroutine

public function string of_getequipmentdescription (ref n_cst_beo_equipment2 anva_equipment[], string as_type);long	ll_ndx, &
		ll_count,&
		ll_eqid, &
		ll_listcount, &
		ll_max
		

string	ls_type, &
			ls_refnum, &
			ls_description, &
			lsa_list[]

n_cst_equipmentmanager	lnv_Equipmanager
n_cst_AnyArraysrv			lnv_Arraysrv

ll_count = upperbound(anva_equipment)

for ll_ndx = 1 to ll_count
	
	
	ls_type = anva_equipment[ll_ndx].of_gettype()

	choose case ls_type
			
		case lnv_Equipmanager.cs_TRAC, lnv_Equipmanager.cs_STRT, lnv_Equipmanager.cs_VAN
			if as_type = 'POWERUNIT' then
				//powerunit
				ll_eqid = anva_equipment[ll_ndx].of_getid()
				lnv_Equipmanager.of_get_description( ll_eqid, 'SHORT_REF!', ls_description)

			end if
			
		case lnv_Equipmanager.cs_TRLR, lnv_Equipmanager.cs_FLBD, lnv_Equipmanager.cs_REFR, &
				lnv_Equipmanager.cs_TANK , lnv_Equipmanager.cs_RBOX, lnv_Equipmanager.cs_CHAS 
			if as_type = 'TRAILER' then
				//chassis
				ll_eqid = anva_equipment[ll_ndx].of_getid()
				lnv_Equipmanager.of_get_description( ll_eqid, 'SHORT_REF!', ls_description)
			end if
			
		case lnv_Equipmanager.cs_CNTN 
			if as_type = 'CONTAINER' then
				//container	
				ll_eqid = anva_equipment[ll_ndx].of_getid()
				lnv_Equipmanager.of_get_description( ll_eqid, 'SHORT_REF!', ls_description)
			end if
			
	end choose
	
	if len(trim(ls_description)) > 0 then
		ll_listcount ++
		lsa_list[ll_listcount] = ls_description
	end if

	ls_description = ''

next

ll_Max = lnv_Arraysrv.of_GetShrinked ( lsa_List, TRUE /*Shrink Nulls */, true /*Shrink dupes */)

for ll_count = 1 to ll_max
	if len(trim(ls_description)) > 0 then
		ls_description += ', '
	end if
	ls_description += lsa_List[ll_count]			
next
		
return ls_description
end function

private function integer of_separatespecialtemplates (n_cst_beo_amounttemplate anva_alltemplates[], ref n_cst_beo_amounttemplate anva_regulartemplates[], ref n_cst_beo_amounttemplate anva_specialtemplates[]);Int	li_TotalCount
Int	i
Int	li_SpecialCount
Int	li_RegCount

n_Cst_beo_amountTemplate	lnva_Special[]
n_Cst_beo_amountTemplate	lnva_Regular[]

li_TotalCount = UpperBound ( anva_Alltemplates[] )
FOR i = 1 TO li_TotalCount
	IF Trim ( anva_alltemplates[i].of_GetCustom3 ( ) ) = "[HM|NR]" THEN
		li_SpecialCount ++
		lnva_Special [ li_SpecialCount ] = anva_alltemplates[i]
	ELSE
		li_RegCount ++
		lnva_Regular[li_RegCount] = anva_alltemplates[i]
	END IF
	
NEXT

anva_regulartemplates[] = lnva_Regular
anva_specialtemplates[] = lnva_special

RETURN li_SpecialCount

end function

on n_cst_bso_payable.create
call super::create
end on

on n_cst_bso_payable.destroy
call super::destroy
end on

