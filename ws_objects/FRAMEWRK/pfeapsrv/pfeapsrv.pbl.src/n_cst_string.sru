$PBExportHeader$n_cst_string.sru
$PBExportComments$Extension String service
forward
global type n_cst_string from pfc_n_cst_string
end type
end forward

global type n_cst_string from pfc_n_cst_string
end type

forward prototypes
public function long of_parsetoarray (string as_source, string as_delimiter, ref long ala_parsed[])
public function long of_arraytostring (long ala_source[], string as_delimiter, ref string as_result)
public function date of_specialdate (string datestr)
public function decimal of_specialnumber (string numstr)
public function time of_specialtime (string timestr)
public function string of_substitute (string target, string oldval, string newval)
public function string of_extractdelimited (string as_source, string as_value_label)
public function long of_parsetoexpressions (readonly string as_source, readonly string as_delimiter, readonly string as_tagdelimiter, ref string asa_target[])
public function string of_getcodetabledisplayvalue (string as_datavalue, string as_codetable)
public function string of_getcodetabledatavalue (string as_displayvalue, string as_codetable)
public function string of_prepareforurl (string as_url)
public function long of_arraytostring (date ada_source[], string as_delimiter, ref string as_result)
public function string of_buildfilterstring (string as_columntype, string as_column, string as_value, string as_operator)
public function string of_removenonalphanumeric (string as_source)
public function date of_makedate (string as_value)
public function time of_maketime (string as_value)
public function long of_arraytostring (string as_source[], string as_delimiter, ref string as_ref_string, boolean ab_includeemptystrings)
public function long of_arraytostring (string as_source[], string as_delimiter, ref string as_ref_string)
end prototypes

public function long of_parsetoarray (string as_source, string as_delimiter, ref long ala_parsed[]);//Parses a string to an array of longs

String	lsa_Parsed[]
Long		lla_Parsed[], ll_Count, ll_Ndx

ll_Count = of_ParseToArray ( as_Source, as_Delimiter, lsa_Parsed )

FOR ll_Ndx = 1 TO ll_Count
	lla_Parsed [ ll_Ndx ] = Long ( lsa_Parsed [ ll_Ndx ] )
NEXT

ala_Parsed = lla_Parsed

RETURN ll_Count
end function

public function long of_arraytostring (long ala_source[], string as_delimiter, ref string as_result);String	lsa_Source[]
Integer	li_Index, &
			li_Count

li_Count = UpperBound ( ala_Source )

FOR li_Index = 1 TO li_Count

	lsa_Source [ li_Index ] = String ( ala_Source [ li_Index ] )

NEXT

RETURN of_ArrayToString ( lsa_Source, as_Delimiter, as_Result )
end function

public function date of_specialdate (string datestr);date l_null_date
SetNull( l_null_date )
if isdate(datestr) then return date(datestr)

date newdate
string teststr
integer charpos, numchars, daynum, seldaynum

if isnull(datestr) then return l_null_date

datestr = upper(trim(datestr))
if len(datestr) = 0 then return l_null_date

teststr = datestr + "/" + string(year(today()))
if isdate(teststr) then
	if month(today()) = 12 and month(date(teststr)) = 1 then
		return date(datestr + "/" + string(year(today()) + 1))
	else
		return date(teststr)
	end if
end if

if datestr = "X" or datestr = "TODAY" or datestr = "N" or datestr = "NOW" then &
	return date(datetime(today()))

if datestr = "TOM" or datestr = "TOMORROW" then &
	return relativedate(date(datetime(today())), 1)

if datestr = "Y" or datestr = "YE" or datestr = "YEST" or datestr = "YESTERDAY" &
	then return relativedate(date(datetime(today())), -1)

if match(datestr, "^\+\+*$") then
	if len(datestr) < 8 then return relativedate(date(datetime(today())), len(datestr)) else return l_null_date
elseif match(datestr, "^--*$") then
	if len(datestr) < 8 then return relativedate(date(datetime(today())), len(datestr) * -1) else return l_null_date
end if

choose case upper(dayname(today()))
	case "MONDAY"
		daynum = 1
	case "TUESDAY"
		daynum = 2
	case "WEDNESDAY"
		daynum = 3
	case "THURSDAY"
		daynum = 4
	case "FRIDAY"
		daynum = 5
	case "SATURDAY"
		daynum = 6
	case "SUNDAY"
		daynum = 7
	case else
		return l_null_date
end choose

teststr = "nothing"
if left(datestr, 3) = "MON" then
	teststr = replace(datestr, 1, 3, "")
elseif left(datestr, 1) = "M" then
	teststr = replace(datestr, 1, 1, "")
end if
if not teststr = "nothing" then
	teststr = trim(teststr)
	seldaynum = 1
	if match(teststr, "^\.? *\+*$") or len(teststr) = 0 then
		charpos = pos(teststr, "+")
		if charpos = 0 then numchars = 0 else numchars = len(teststr) - charpos + 1
		goto daycomp
	elseif match(teststr, "^\.? *-*$") then
		charpos = pos(teststr, "-")
		if charpos = 0 then numchars = 0 else numchars = (len(teststr) - charpos + 1) * -1
		goto daycomp
	else
		return l_null_date
	end if
end if

seldaynum = 4

if left(datestr, 4) = "TUES" then
	teststr = replace(datestr, 1, 4, "")
	seldaynum = 2
elseif left(datestr, 3) = "TUE" then
	teststr = replace(datestr, 1, 3, "")
	seldaynum = 2
elseif left(datestr, 2) = "TU" then
	teststr = replace(datestr, 1, 2, "")
	seldaynum = 2
elseif left(datestr, 5) = "THURS" then
	teststr = replace(datestr, 1, 5, "")
elseif left(datestr, 4) = "THUR" then
	teststr = replace(datestr, 1, 4, "")
elseif left(datestr, 3) = "THU" then
	teststr = replace(datestr, 1, 3, "")
elseif left(datestr, 2) = "TH" then
	teststr = replace(datestr, 1, 2, "")
elseif left(datestr, 1) = "T" then
	teststr = replace(datestr, 1, 1, "")
	seldaynum = 2
end if
if not teststr = "nothing" then
	teststr = trim(teststr)
	if match(teststr, "^\.? *\+*$") or len(teststr) = 0 then
		charpos = pos(teststr, "+")
		if charpos = 0 then numchars = 0 else numchars = len(teststr) - charpos + 1
		goto daycomp
	elseif match(teststr, "^\.? *-*$") then
		charpos = pos(teststr, "-")
		if charpos = 0 then numchars = 0 else numchars = (len(teststr) - charpos + 1) * -1
		goto daycomp
	else
		return l_null_date
	end if
end if

if left(datestr, 3) = "WED" then
	teststr = replace(datestr, 1, 3, "")
elseif left(datestr, 1) = "W" then
	teststr = replace(datestr, 1, 1, "")
end if
if not teststr = "nothing" then
	teststr = trim(teststr)
	seldaynum = 3
	if match(teststr, "^\.? *\+*$") or len(teststr) = 0 then
		charpos = pos(teststr, "+")
		if charpos = 0 then numchars = 0 else numchars = len(teststr) - charpos + 1
		goto daycomp
	elseif match(teststr, "^\.? *-*$") then
		charpos = pos(teststr, "-")
		if charpos = 0 then numchars = 0 else numchars = (len(teststr) - charpos + 1) * -1
		goto daycomp
	else
		return l_null_date
	end if
end if

if left(datestr, 3) = "FRI" then
	teststr = replace(datestr, 1, 3, "")
elseif left(datestr, 1) = "F" then
	teststr = replace(datestr, 1, 1, "")
end if
if not teststr = "nothing" then
	teststr = trim(teststr)
	seldaynum = 5
	if match(teststr, "^\.? *\+*$") or len(teststr) = 0 then
		charpos = pos(teststr, "+")
		if charpos = 0 then numchars = 0 else numchars = len(teststr) - charpos + 1
		goto daycomp
	elseif match(teststr, "^\.? *-*$") then
		charpos = pos(teststr, "-")
		if charpos = 0 then numchars = 0 else numchars = (len(teststr) - charpos + 1) * -1
		goto daycomp
	else
		return l_null_date
	end if
end if

seldaynum = 7

if left(datestr, 3) = "SAT" then
	teststr = replace(datestr, 1, 3, "")
	seldaynum = 6
elseif left(datestr, 2) = "SA" then
	teststr = replace(datestr, 1, 2, "")
	seldaynum = 6
elseif left(datestr, 3) = "SUN" then
	teststr = replace(datestr, 1, 3, "")
elseif left(datestr, 2) = "SU" then
	teststr = replace(datestr, 1, 2, "")
elseif left(datestr, 1) = "S" then
	teststr = replace(datestr, 1, 1, "")
end if
if not teststr = "nothing" then
	teststr = trim(teststr)
	if match(teststr, "^\.? *\+*$") or len(teststr) = 0 then
		charpos = pos(teststr, "+")
		if charpos = 0 then numchars = 0 else numchars = len(teststr) - charpos + 1
		goto daycomp
	elseif match(teststr, "^\.? *-*$") then
		charpos = pos(teststr, "-")
		if charpos = 0 then numchars = 0 else numchars = (len(teststr) - charpos + 1) * -1
		goto daycomp
	else
		return l_null_date
	end if
end if

return l_null_date

daycomp:

if abs(numchars) < 5 then
	return relativedate(date(datetime(today())), seldaynum - daynum + 7 * numchars)
else
	return l_null_date
end if
end function

public function decimal of_specialnumber (string numstr);decimal nulldec, newdec
setnull(nulldec)

if isnull(numstr) then return nulldec

numstr = trim(numstr)
if len(numstr) = 0 then return 0

if match(numstr, "^\$") then
	numstr = trim(right(numstr, len(numstr) - 1))
	if isnumber(numstr) then return dec(numstr)
elseif match(numstr, "%$") then
	numstr = trim(left(numstr, len(numstr) - 1))
	if isnumber(numstr) then return (dec(numstr) / 100) else return nulldec
elseif match(numstr, "[pP][cC][tT]\.?$") then
	if right(numstr, 1) = "." then
		numstr = trim(left(numstr, len(numstr) - 4))
	else
		numstr = trim(left(numstr, len(numstr) - 3))
	end if
	if isnumber(numstr) then return (dec(numstr) / 100) else return nulldec
end if

if match(numstr, "[kKmMgG]\.?$") then
	if right(numstr, 1) = "." then
		numstr = trim(left(numstr, len(numstr) - 2))
	else
		numstr = trim(left(numstr, len(numstr) - 1))
	end if
	if isnumber(numstr) then
		newdec = dec(numstr)
		if newdec >= 100000 or newdec <= -100000 then return nulldec &
			else return (newdec * 1000)
	else
		return nulldec
	end if
elseif match(numstr, "[mM][iI][lL]\.?$") then
	if right(numstr, 1) = "." then
		numstr = trim(left(numstr, len(numstr) - 4))
	else
		numstr = trim(left(numstr, len(numstr) - 3))
	end if
	if isnumber(numstr) then
		newdec = dec(numstr)
		if newdec >= 100 or newdec <= -100 then return nulldec &
			else return (newdec * 1000000)
	else
		return nulldec
	end if
end if

return nulldec
end function

public function time of_specialtime (string timestr);time curtime, testtime, l_null_time
string teststr
integer relhours, relmins
SetNull( l_null_time )

if isnull(timestr) then return l_null_time

timestr = upper(trim(timestr))
if len(timestr) = 0 then return l_null_time

curtime = time(string(now(), "h:mm"))

if timestr = "X" or timestr = "N" or timestr = "NOW" then return curtime

if right(timestr, 2) = "AM" or right(timestr, 2) = "PM" then &
	timestr = left(timestr, len(timestr) - 1)

if pos("AP+-", right(timestr, 1)) > 0 then
	teststr = trim(replace(timestr, len(timestr), 1, ""))
	if match(teststr, "^[0-9][0-9][0-9][0-9]?$") then &
		teststr = replace(teststr, len(teststr) - 1, 0, ":")
	if istime(teststr) then
		testtime = time(teststr)
		if pos("P+", right(timestr, 1)) > 0 then
			if testtime < 12:00:00 then relhours = 12
		else
			if testtime >= 13:00:00 then return l_null_time
			if testtime >= 12:00:00 then relhours = -12
		end if
		return relativetime(time(teststr), relhours * 3600)
	else
		return l_null_time
	end if
end if

if pos("+-", left(timestr, 1)) > 0 then
	teststr = trim(replace(timestr, 1, 1, ""))
	if match(teststr, "^[0-9][0-9][0-9][0-9]?$") then &
		teststr = replace(teststr, len(teststr) - 1, 0, ":")
	if match(teststr, "^[0-9][0-9]?$") then
		relhours = 0
		relmins = integer(teststr)
		if relmins < 1 then return l_null_time
	elseif istime(teststr) then
		relhours = hour(time(teststr))
		relmins = minute(time(teststr))
	else
		return l_null_time
	end if
	if left(timestr, 1) = "-" then
		relhours *= -1
		relmins *= -1
	end if
	return relativetime(curtime, 3600 * relhours + 60 * relmins)
end if

teststr = timestr
if match(teststr, "^[0-9][0-9][0-9][0-9]?$") then &
	teststr = replace(teststr, len(teststr) - 1, 0, ":")

if istime(teststr) then return time(teststr)

return l_null_time
end function

public function string of_substitute (string target, string oldval, string newval);integer oldlen, newlen, targpos = 1 //POS MALFUNCTIONS IF TARGPOS STARTS OFF AS 0

//The following two conditons allow the function to be used as a way of setting a default
//value if none exists.  For example, substitute(target, null_str, "F") will replace a
//null value with F.  Otherwise, it leaves the target string untouched.
if isnull(oldval) then
	if isnull(target) then return newval else return target
elseif oldval = "" then
	if target = "" then return newval else return target
end if

//The following condition means that substitue(target, "A", null_str) will return null
//only if target = "A", not if target merely contains "A".
if isnull(newval) then
	if target = oldval then return newval else return target
end if

if isnull(target) then return target

if oldval = newval then return target

oldlen = len(oldval)
newlen = len(newval)

do
	targpos = pos(target, oldval, targpos)
	if targpos > 0 then
		target = replace(target, targpos, oldlen, newval)
		targpos += newlen
	end if
loop while targpos > 0

return target
end function

public function string of_extractdelimited (string as_source, string as_value_label);integer li_work, li_start, li_end
string ls_null
SetNull( ls_null )

as_source = upper(as_source)
as_value_label = upper(as_value_label) + "~t"

li_work = pos(as_source, "~n" + as_value_label)

if li_work > 0 then
	li_start = li_work + len(as_value_label) + 1
else
	li_work = pos(as_source, as_value_label)
	if li_work = 1 then li_start = len(as_value_label) + 1
end if

if li_start > 0 then
	li_work = pos(as_source, "~n", li_start)
	if li_work > 0 then li_end = li_work - 1 else li_end = len(as_source)
	if li_end >= li_start then return mid(as_source, li_start, li_end - li_start + 1)
end if

return ls_null
end function

public function long of_parsetoexpressions (readonly string as_source, readonly string as_delimiter, readonly string as_tagdelimiter, ref string asa_target[]);// Function will split input 'as_Source' text into array 'asa_Target[]' of expressions
// Expressions in initial text must be separate from each other by 'as_Delimiter' symbol
// All 'as_Delimiter' will be ignored if it placed between 'asa_tagdelims' symbols
// For example: if delim symbol ';' is placed between '"' and '"' it's part of string
// constant and must be ignored and next expression will not extracted

//Returns:  Number of expressions in array ( >=0 ) if successful, -1 if Error

long ll_tagdelims, ll_index

// Clean up target
string lsa_array[]
asa_Target = lsa_array

// test input parameters
if Len(as_Source) < 1 or Len(as_Delimiter) <> 1 or Len(as_TagDelimiter) <> 1 then
	return -1
end if

// Main loop
boolean lb_inside = FALSE
long ll_srclength = 0, ll_prev = 1, ll_arrayindex = 1
ll_srclength = Len( as_Source )
for ll_index = 1 to ll_srclength
	// If tag delim symbol found
	if Mid( as_Source, ll_index, 1 ) = as_TagDelimiter then
		lb_inside = not lb_inside
		continue
	end if
	// If expression delim symbol found
	if Mid( as_Source, ll_index, 1 ) = as_Delimiter and not lb_inside then
		asa_Target[ll_arrayindex] = Mid( as_Source, ll_prev, ll_index - ll_prev )
		ll_prev = ll_index + 1
		ll_arrayindex++
	end if
next
// If no expression delim symbol found or some rest exists
if ll_prev < ll_srclength + 1 then
	asa_Target[ll_arrayindex] = Mid( as_Source, ll_prev, ll_srclength - ll_prev )
end if
// That's ALL

RETURN UpperBound ( asa_Target )
end function

public function string of_getcodetabledisplayvalue (string as_datavalue, string as_codetable);//Returns : The display value if determined, Null if cannot be determined.
//Note:  This function is Case Sensitive with regard to the data value passed in.

String	ls_Display
Integer	li_EndPos, &
			li_StartPos


//Bug Fix BF0005 :  This padding was omitted here in 3.0.01 through 3.0.04
//It was fixed (added) in 3.0.05.  See bug fixes document for impact.

//Make the CodeTable string start and end with "/", for easier matching.
as_CodeTable = "/" + as_CodeTable

IF Right ( as_CodeTable, 1 ) = "/" THEN
	//No action needed.
ELSE
	as_CodeTable += "/"
END IF


//Look for the DataValue in the CodeTable, to find where the display value ends.
li_EndPos = Pos ( as_CodeTable, "~t" + as_DataValue + "/" ) - 1


//If we found the data value, work backwards through the string to find where
//the previous value pair ends, so we know where this display value starts.

IF li_EndPos > 0 THEN

	FOR li_StartPos = li_EndPos TO 1 STEP -1

		IF Mid ( as_CodeTable, li_StartPos, 1 ) = "/" THEN
			//StartPos is the position after the "/"
			li_StartPos ++
			EXIT
		END IF

	NEXT

END IF


//Pull the display value out of the string.

IF li_StartPos > 0 AND li_EndPos > 0 THEN

	ls_Display = Mid ( as_CodeTable, li_StartPos, li_EndPos - li_StartPos + 1 )

ELSE

	SetNull ( ls_Display )

END IF

RETURN ls_Display
end function

public function string of_getcodetabledatavalue (string as_displayvalue, string as_codetable);//Note:  This function is not case sensitive with regard to the display value passed in.
//It will, however, return the data value in whatever case is used in the code table.

String	ls_DataValue, &
			ls_CodeTableUpper
Integer	li_EndPos, &
			li_StartPos

//Convert the display value to upper, for use in comparisons.
as_DisplayValue = Upper ( as_DisplayValue )


//Make the CodeTable string start and end with "/", for easier matching.
as_CodeTable = "/" + as_CodeTable

IF Right ( as_CodeTable, 1 ) = "/" THEN
	//No action needed.
ELSE
	as_CodeTable += "/"
END IF

//Make an uppercase copy of the CodeTable, for use in comparisons.
ls_CodeTableUpper = Upper ( as_CodeTable )


//Look for the DisplayValue in the CodeTable, to find where it starts.
li_StartPos = Pos ( ls_CodeTableUpper, "/" + as_DisplayValue + "~t" )

//If we found it, find the separator character that precedes the data value.
//The start of the data value is the next position.
IF li_StartPos > 0 THEN
	li_StartPos = Pos ( ls_CodeTableUpper, "~t", li_StartPos ) + 1
END IF

//If we found that, find the pair termination character.
//The end of the data value is the previous position.
IF li_StartPos > 0 THEN
	li_EndPos = Pos ( ls_CodeTableUpper, "/", li_StartPos ) - 1
END IF


//Pull the data value out of the string.

IF li_StartPos > 0 AND li_EndPos > 0 THEN

	//Use the mixed case code table for determining the return.
	ls_DataValue = Mid ( as_CodeTable, li_StartPos, li_EndPos - li_StartPos + 1 )

ELSE

	SetNull ( ls_DataValue )

END IF

RETURN ls_DataValue
end function

public function string of_prepareforurl (string as_url);/*		ESCAPE SEQUENCES


	unsafe characters
     
	  SPACE      %20
     <          %3C
     >          %3E
     #          %23
     %          %25
     {          %7B
     }          %7D
     |          %7C
     \          %5C
     ^          %5E
     ~          %7E
     [          %5B
     ]          %5D
     `          %60

	reserved characters
	
	  ;          %3B          
	  /          %2F
     ?          %3F
     :          %3A
     @          %40
     =          %3D
     &          %26
	  
  additional characters (4/26/06 MFS)
  
  	  ~n		 	 %0A  //LINE FEED

*/

string	lsa_CharacterList [], &
			lsa_EscapeSequences [], &
			ls_URL
			
integer	li_EscapeCount, &
			li_Ndx

lsa_CharacterList [1] = '%'
lsa_EscapeSequences [1] = '%25'

lsa_CharacterList [2] = ' '
lsa_EscapeSequences [2] = '%20'

lsa_CharacterList [3] = '<'
lsa_EscapeSequences [3] = '%3C'

lsa_CharacterList [4] = '>'
lsa_EscapeSequences [4] = '%3E'

lsa_CharacterList [5] = '#'
lsa_EscapeSequences [5] = '%23'

lsa_CharacterList [6] = '{'
lsa_EscapeSequences [6] = '%7B'

lsa_CharacterList [7] = '}'
lsa_EscapeSequences [7] = '%7D'

lsa_CharacterList [8] = '|'
lsa_EscapeSequences [8] = '%7C'

lsa_CharacterList [9] = '\'
lsa_EscapeSequences [9] = '%5C'

lsa_CharacterList [10] = '^'
lsa_EscapeSequences [10] = '%5E'

lsa_CharacterList [11] = '~~'
lsa_EscapeSequences [11] = '%7E'

lsa_CharacterList [12] = '['
lsa_EscapeSequences [12] = '%5B'

lsa_CharacterList [13] = ']'
lsa_EscapeSequences [13] = '%5D'

lsa_CharacterList [14] = '`'
lsa_EscapeSequences [14] = '%60'

lsa_CharacterList [15] = ';'
lsa_EscapeSequences [15] = '%3B'

lsa_CharacterList [16] = '/'
lsa_EscapeSequences [16] = '%2F'

lsa_CharacterList [17] = '?'
lsa_EscapeSequences [17] = '%3F'

lsa_CharacterList [18] = ':'
lsa_EscapeSequences [18] = '%3A'

lsa_CharacterList [19] = '@'
lsa_EscapeSequences [19] = '%40'

lsa_CharacterList [20] = '='
lsa_EscapeSequences [20] = '%3D'

lsa_CharacterList [21] = '&'
//substituting space because the ampersand is not translating correctly in the url
//lsa_EscapeSequences [21] = '%26'
lsa_EscapeSequences [21] = '%20'

lsa_CharacterList [22] = '~n'
lsa_EscapeSequences [22] = '%0A'

li_EscapeCount = upperbound ( lsa_EscapeSequences ) 

ls_URL = as_URL

FOR li_Ndx = 1 to li_EscapeCount
	
	ls_URL = this.of_GlobalReplace ( ls_URL, lsa_CharacterList [li_Ndx] , lsa_EscapeSequences [li_Ndx] )
	
NEXT

return ls_URL
end function

public function long of_arraytostring (date ada_source[], string as_delimiter, ref string as_result);String	lsa_Source[]
Integer	li_Index, &
			li_Count

li_Count = UpperBound ( ada_Source )

FOR li_Index = 1 TO li_Count

	lsa_Source [ li_Index ] = String ( ada_Source [ li_Index ] )

NEXT

RETURN of_ArrayToString ( lsa_Source, as_Delimiter, as_Result )
end function

public function string of_buildfilterstring (string as_columntype, string as_column, string as_value, string as_operator);String	ls_RtnFilter
String	ls_Value 
String	ls_Expression

ls_Value = as_Value

// Determine the correct expression.
Choose Case Left ( as_ColumnType , 5 )
		
	// CHARACTER DATATYPE		
	Case "char("	, "char"
		If Pos(ls_value, '~~~"') =0 And Pos(ls_value, "~~~'") =0 Then
			// No special characters found.
			If Pos(ls_value, "'") >0 Then
				// Replace single quotes with special chars single quotes.
				ls_value = THIS.of_GlobalReplace(ls_value, "'", "~~~'")				
			End If
		End If
		ls_expression = "'" + ls_value + "'"			

	// DATE DATATYPE	
	Case "date"
		ls_expression = "Date('" + ls_value + "')"

	// DATETIME DATATYPE
	Case "datet"				
		ls_expression = "DateTime('" + ls_value + "')" 

	// TIME DATATYPE
	Case "time", "times"		
		ls_expression = "Time('" + ls_value + "')" 

	// NUMBER
	Case 	Else
		ls_expression = ls_value
End Choose

ls_RtnFilter = as_Column + as_Operator + ls_expression

return ls_RtnFilter
end function

public function string of_removenonalphanumeric (string as_source);char		lch_char
long		ll_pos = 1
long		ll_loop
string	ls_source
long		ll_len
Int		li_ascii

//Check parameters
If IsNull(as_source) Then
	SetNull(ls_source)
	Return ls_source				/// EARLY RETURN 
End If

ls_source = as_source
ll_len = Len(ls_source)

//	set up a loop to visit each char
FOR ll_loop = 1 TO ll_len
	lch_char = Mid(ls_source, ll_pos, 1)
	
	IF THIS.of_IsAlphaNum ( lch_Char ) THEN
		ll_pos ++
	ELSE
		ls_source = Replace(ls_source, ll_pos, 1, "")
	END IF
	
NEXT

Return ls_source

////Get ASC code of character.
//	li_ascii = Asc (lch_char)
//	
//	CHOOSE CASE li_Ascii
//		//    A - Z		 a - z      0 - 1
//		CASE 65 - 90 , 97 - 122 , 48 - 57
//			// The char is alphanumeric, shift the position we are evaluating
//			ll_pos ++
//		CASE ELSE
//			ls_source = Replace(ls_source, ll_pos, 1, "")
//			// the source will be shifted down from the replace function so we will be
//			// evaluating the nex char in the next pass through the loop
//	END CHOOSE
//
end function

public function date of_makedate (string as_value);Date	ld_Return 
String	ls_Temp 

SetNull ( ld_Return ) 

IF Len ( as_Value ) > 0 THEN

					//MONTH											DAY 												
	ls_Temp = Mid ( as_Value , 5 , 2 ) + "/" + Right ( as_Value , 2 ) +"/" + Left ( as_Value , 4 )
	
	IF isDate ( ls_Temp ) THEN
		ld_Return = Date ( ls_Temp ) 
	END IF


//	// we are going to try to see if it is 12022004 (12/02/2004)
//	IF isNull ( ld_Return ) THEN
//		ls_Temp = Left ( as_value, 2 ) + "/" + Mid ( as_Value , 3 , 2 ) + "/" + Right ( as_Value , 4 ) 
//	END IF
//	IF isDate ( ls_Temp ) THEN
//		ld_Return = Date ( ls_Temp ) 
//	END IF


END IF

RETURN ld_Return
end function

public function time of_maketime (string as_value);// MUST be in HHMMSS

Time	lt_Return 
String	ls_Value

ls_Value = as_value
lt_Return =Time ( Left ( ls_Value , 2 ) + ":" + Mid ( ls_Value , 3 , 2 ) + ":" + Mid ( ls_Value, 5, 2 ) )

RETURN lt_Return

end function

public function long of_arraytostring (string as_source[], string as_delimiter, ref string as_ref_string, boolean ab_includeemptystrings);long		ll_Count, ll_ArrayUpBound
String	ls_Temp

//Get the array size
ll_ArrayUpBound = UpperBound(as_source[])

//Check parameters
IF IsNull(as_delimiter) or (Not ll_ArrayUpBound>0) Then
	Return -1
End If

//Reset the Reference string
as_ref_string = ''

For ll_Count = 1 to ll_ArrayUpBound
	
	ls_Temp = as_source[ll_Count]
	IF isNull ( ls_Temp ) THEN
		ls_Temp = ''
	END IF
	
	If ls_Temp = '' AND NOT ab_IncludeEmptyStrings Then
		CONTINUE
	END IF
	
	If Len(as_ref_string) = 0 Then
		//Initialize string
		as_ref_string = ls_Temp
	else
		//Concatenate to string
		as_ref_string = as_ref_string + as_delimiter + ls_Temp
	End If
		
Next 

return 1

end function

public function long of_arraytostring (string as_source[], string as_delimiter, ref string as_ref_string);RETURN THIS.of_Arraytostring( as_source[] , as_delimiter, as_ref_string , FALSE )
end function

on n_cst_string.create
call super::create
end on

on n_cst_string.destroy
call super::destroy
end on

