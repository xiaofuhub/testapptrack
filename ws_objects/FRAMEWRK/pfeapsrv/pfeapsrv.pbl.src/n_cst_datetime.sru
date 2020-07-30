$PBExportHeader$n_cst_datetime.sru
$PBExportComments$Extension Date and/or Datetime service
forward
global type n_cst_datetime from pfc_n_cst_datetime
end type
end forward

global type n_cst_datetime from pfc_n_cst_datetime
end type

type variables
Private date idt_holidays[]
end variables

forward prototypes
public function time of_relativetime (time at_start, long al_offset)
public function long of_daysafter (date ad_start, date ad_end, boolean ab_excludeweekends)
public function date of_relativedate (date ad_start, integer ai_offset, boolean ab_excludeweekends)
public function integer of_daysafter (date ad_start, date ad_end, boolean ab_excludeweekends, boolean ab_pushstartback, boolean ab_pushendforward)
public function date of_getholiday (integer ai_holiday)
public function string of_getallholidays ()
public function integer of_getholidaycount (date adt_startdate, date adt_enddate, boolean ab_includeweekend)
public function boolean of_isholiday (date adt_date)
public function boolean of_setholidays (date adt_startdate, date adt_enddate)
public function boolean of_setholidays ()
public function date of_relativedate (date ad_start, integer ai_offset, boolean ab_excludeweekends, boolean ab_excludeholidays)
end prototypes

public function time of_relativetime (time at_start, long al_offset);datetime ldt_temp
ldt_temp = DateTime( Date( 2000, 1, 1 ), at_start )
return Time( of_RelativeDateTime( ldt_temp, al_offset ) )
end function

public function long of_daysafter (date ad_start, date ad_end, boolean ab_excludeweekends);
INT	li_DayCount
Boolean lb_PushStartBack
Boolean lb_PushEndForward

lb_PushStartBack = TRUE
lb_PushEndForward = FALSE

li_DayCount = of_DaysAfter( ad_start , ad_end , ab_excludeweekends , &
							lb_PushStartBack , lb_PushEndForward )
Return li_DayCount
end function

public function date of_relativedate (date ad_start, integer ai_offset, boolean ab_excludeweekends);RETURN THIS.of_relativedate( ad_start,  ai_offset, ab_excludeweekends, FALSE )


end function

public function integer of_daysafter (date ad_start, date ad_end, boolean ab_excludeweekends, boolean ab_pushstartback, boolean ab_pushendforward);DATE	 ld_NewStart
INT	 li_TempCount
INT	 li_Weekends
INT	li_StartBuffer
INT	li_DayCount
INT	 li_DayNum
LONG	 ll_NumDays

IF IsNull(ad_start) or IsNull(ad_end) or ISNull(ab_excludeweekends) THEN
	LONG	ll_Null
	setNull(ll_Null)
	Return ll_Null
END IF

IF ab_excludeweekends = FALSE THEN
	li_DayCount = DaysAfter(ad_start,ad_end)

ELSE	
		li_DayNum = DayNumber(ad_start)
		IF ab_pushstartback THEN
			IF li_DayNum = 1 Then
				ad_start = RelativeDate(ad_start,-2)
			ElseIf Li_DayNum = 7 Then
				ad_start = RelativeDate(ad_start,-1)
			End If
		ELSE		
			IF li_DayNum = 1 Then
				ad_start = RelativeDate(ad_start,1)
			ElseIf Li_DayNum = 7 Then
				ad_start = RelativeDate(ad_start,2)
			End If
		END IF

	li_DayNum = DayNumber(ad_end)

	IF ab_pushendforward THEN
		IF li_DayNum = 1 Then
			ad_End = RelativeDate(ad_End,1)
		ElseIf Li_DayNum = 7 Then
			ad_end = RelativeDate(ad_End,2)
		End If
	ELSE	
		IF  li_DayNum = 1 OR li_DayNum = 7  Then
			ad_end = RelativeDate(ad_end,-(Mod(li_DayNum,7) + 1))
		End If
	END IF

	li_startBuffer = 7 - (DayNumber(ad_start))
	ld_newStart = RelativeDate(ad_start, li_startBuffer + 2)
	li_TempCount = DaysAfter(ld_NewStart,ad_end)
	li_weekends = Int(li_TempCount/7) * 2

	li_DayCount = (li_TempCount + li_startBuffer - li_weekends )
End IF


Return li_DayCount








end function

public function date of_getholiday (integer ai_holiday);//
/*Arguments: integer 
//returns: holiday
//Description: returns date of the holiday for the int passed in.
//
//Revision History
*/

return idt_holidays[ai_holiday]
end function

public function string of_getallholidays ();//
/*Arguments: integer 
//returns: holiday
//Description: returns all holidays in a string 
//
//Revision History
*/
String ls_Holidays
integer li_x
FOR li_x = 1 TO upperbound(idt_Holidays)
	ls_Holidays = ls_Holidays + String(idt_Holidays[li_x],"mm-dd-yy") +","
NEXT

return ls_Holidays

end function

public function integer of_getholidaycount (date adt_startdate, date adt_enddate, boolean ab_includeweekend);//
/*Arguments: Start Date range, End Date Range, Boolean to include weekends in count
//returns: number of holidays found
//Description: Looks for holidays in date range 
//
// create dateservice
// get holiday list
// find any holidays between the Start and End date. (useing julian dates)
// If ab_IncludeWeekEnd is true the holiday will be counted if it falls on a weekend. 
// If ab_IncludeWeekEnd is false the holiday will not be counted if it falls on a weekend.
//Revision History
// rdt 08-05-02 initial version
*/

String  ls_Holiday
Integer li_NumberHolidays, &
		  li_Counter
Long	  ll_Julian_Holiday, &
		  ll_Julian_StartDate, &
		  ll_Julian_EndDate

li_Counter = 1
li_NumberHolidays = 0

n_cst_datetime lnv_DateTime

ll_Julian_StartDate = lnv_DateTime.of_Julian(adt_StartDate)
ll_Julian_EndDate = lnv_DateTime.of_Julian(adt_EndDate)

// loop thru the holiday array
FOR li_counter = 1 TO UpperBound(idt_holidays[])
	ll_Julian_Holiday = lnv_DateTime.of_Julian(idt_Holidays[li_counter])
	// check for holiday in range
	If ll_Julian_Holiday >= ll_Julian_StartDate and ll_Julian_Holiday <= ll_Julian_EndDate Then 
		// check for weekend flag and if day lands on weekend
		// if weekend flag is true and the holiday is a weekend,     add 1 to counter 
		// if weekend flag is true and the holiday is NOT a weekend, add 1 to counter 
		// if weekend flag is false and holiday is not a weekend,    add 1 to counter 
		// if weekend flag is false and holiday IS a weekend,        do NOT add to counter 
		If ab_includeweekend then
			li_NumberHolidays = li_NumberHolidays + 1
		Else
			If lnv_DateTime.of_isWeekend(idt_Holidays[li_counter]) = false Then
				li_NumberHolidays = li_NumberHolidays + 1
			End If
		End If
	End If
NEXT

return li_NumberHolidays

end function

public function boolean of_isholiday (date adt_date);//
/*Arguments: Date
//returns: Boolean 
//Description: If date passed in is a holiday, Returns True else False
//
//Revision History
*/
Boolean	lb_return
Date		ldt_date
Integer	li_counter 

lb_Return = False
li_Counter = 1
n_cst_datetime lnv_DateTime
lnv_DateTime.of_SetHolidays()

FOR li_counter = 1 TO UpperBound(idt_holidays[])
	If adt_date = idt_Holidays[li_counter] Then
		lb_Return = TRUE
	End If
NEXT


return lb_Return
end function

public function boolean of_setholidays (date adt_startdate, date adt_enddate);//
/*Arguments: Start Date, End Date
//returns: boolean
//Description: Sets the standard holidays in a constant array
// New Years, Memorial Day, July 4, Labor Day, Turkey Day, XMas
//
//Revision History
// rdt 08-05-02
*/
boolean lb_Return 
String  ls_Year, &
		  ls_Month, &
		  ls_Day, &
		  ls_LastYear, &
		  ls_NextYear
Integer li_Day, & 
		  li_FirstYear, &
		  li_LastYear, &
		  li_Year
		  
date    ldt_Date

lb_return = true

n_cst_datetime lnv_datetime

//Set the Year Ranges 

ls_Year = Right(String(today(),"mm/dd/yyyy"),4)
li_FirstYear = Integer(Right(String(adt_StartDate,"mm/dd/yyyy"),4))

// Add one to last year to include the last years holidays
li_LastYear  = Integer(Right(String(adt_EndDate,"mm/dd/yyyy"),4)) + 1

li_Year = li_FirstYear


FOR li_Year = li_FirstYear TO li_LastYear
	ls_Year = String(li_Year)
	//New Years  
	idt_holidays[UpperBound(idt_holidays) + 1] = date("01/01/"+ls_Year)
	//Memorial day - last monday of may
	// find the last day of the month and work backward to monday.
	ldt_date = lnv_datetime.of_lastdayofmonth ( date("05/01/"+ls_year))
	li_day = lnv_datetime.of_dayofweek (ldt_date)
	DO Until li_day = 2
		ldt_date = lnv_datetime.of_relativedate (ldt_date, -1, False)
		li_day = lnv_datetime.of_dayofweek (ldt_date)
	Loop
	idt_holidays[UpperBound(idt_holidays) + 1] = ldt_date
	
	//July 4
	idt_holidays[UpperBound(idt_holidays) + 1] = date("07/04/"+ls_year)
	
	//Labor day - first monday of sept
	ldt_date = lnv_datetime.of_firstdayofmonth ( date("09/01/"+ls_year))
	li_day = lnv_datetime.of_dayofweek (ldt_date)
	DO Until li_day = 2
		ldt_date = lnv_datetime.of_relativedate (ldt_date, 1, False)
		li_day = lnv_datetime.of_dayofweek (ldt_date)
	Loop
	idt_holidays[UpperBound(idt_holidays) + 1] = ldt_date
	
	//Thanksgiving day - Fourth Thursday of November
	// find the first thursday then skip ahead 21 days
	ldt_date = lnv_datetime.of_firstdayofmonth ( date("11/01/"+ls_year))
	li_day = lnv_datetime.of_dayofweek (ldt_date)
	DO Until li_day = 5
		ldt_date = lnv_datetime.of_relativedate (ldt_date, 1, False)
		li_day = lnv_datetime.of_dayofweek (ldt_date)
	Loop
	ldt_date = lnv_datetime.of_RelativeDate (ldt_date, 21, false)
	idt_holidays[UpperBound(idt_holidays) + 1] = ldt_date
	
	// Xmas - dec 25
	idt_holidays[UpperBound(idt_holidays) + 1] = date("12/25/"+ls_year)

NEXT

return lb_return
end function

public function boolean of_setholidays ();//
//Arguments: none
//returns: boolean
//Description: Sets the standard holidays for the current year
//
//Revision History
// rdt 08-05-02


Return this.of_SetHolidays(Today(),Today())
end function

public function date of_relativedate (date ad_start, integer ai_offset, boolean ab_excludeweekends, boolean ab_excludeholidays);Date  ld_NewStart
Date	ld_Null
Date	 ld_ReturnDate
Int	li_EndDayBuffer
Int	 li_Run

IF isNull(ad_start) or IsNull(ai_offset) or IsNull(ab_excludeweekends) Then
	SetNull(ld_Null)
	return ld_Null
End If

IF ab_excludeweekends = False AND ab_excludeholidays = FALSE Then
	ld_ReturnDate =  RelativeDate(ad_start, ai_offset )

Else

//	IF DayNumber(ad_start) = 1 Then
//		ad_start = RelativeDate(ad_start,1)
//	Elseif DayNumber(ad_start) = 7 Then
//		ad_start = RelativeDate(ad_start,2)
//	End if
//
	// <<*>> calc fix
	// implemented a new approach to calculating relative date
	// if we are not counting weekends then we will loop through each day and 
	// determine if it is a weekend day
	
	Date ld_CurrentDate
	ld_CurrentDate = ad_start
	Int	li_CurrentDayNumber
	Int	li_DaysCounted
	
	DO WHILE li_DaysCounted < ai_Offset
	
		ld_CurrentDate = RelativeDate ( ld_CurrentDate , 1 )
		li_CurrentDayNumber = DayNumber ( ld_CurrentDate )
		IF (( li_CurrentDayNumber  = 1 OR li_CurrentDayNumber = 7 ) AND ab_excludeweekends ) OR &
			( THIS.of_isholiday( ld_CurrentDate ) AND ab_ExcludeHolidays ) THEN
			// it is a weekend so don't count it or Holiday
		ELSE
			li_DaysCounted ++
		END IF
		
	LOOP

//	The Old version, before <<*>> calc fix
//
//	li_EndDayBuffer = 7 - DayNumber(ad_start)
//   li_Run = Abs(ai_offset - li_EndDayBuffer + 2)
//	ld_NewStart = RelativeDate(ad_start,li_EndDayBuffer)
//
//	ld_ReturnDate = RelativeDate(ld_NewStart,ai_offset - li_Run+((Int(li_Run/5))*7) &
//							+ Mod(li_Run,5))
//
//	IF DayNumber(ld_returnDate) = 1 OR DayNumber(ld_returnDate) = 7 Then
//		ld_ReturnDate = RelativeDate(ld_ReturnDate,2)
//	End IF

//	IF DayNumber(ld_CurrentDate) = 1 THEN
//		ld_CurrentDate = RelativeDate(ld_CurrentDate,1)
//	ELSEIF DayNumber(ld_CurrentDate) = 7 Then
//		ld_CurrentDate = RelativeDate(ld_CurrentDate,2)
//	End IF
		
	ld_ReturnDate = ld_CurrentDate

End if

Return ld_ReturnDate
end function

on n_cst_datetime.create
call super::create
end on

on n_cst_datetime.destroy
call super::destroy
end on

