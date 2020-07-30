$PBExportHeader$n_cst_anyarraysrv.sru
forward
global type n_cst_anyarraysrv from n_base
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//
//constant int T_CHAR = 1
//constant int T_BOOL = 2
//constant int T_TIME = 3
//constant int T_DATE = 4
//constant int T_DATETIME = 5
//constant int T_INT = 6
//constant int T_UINT = 7
//constant int T_LONG = 8
//constant int T_ULONG = 9
//constant int T_DEC = 10
//constant int T_REAL = 11
//constant int T_DOUBLE = 12
//constant int T_NULL = 13
//constant int T_ANY = 14
////end modification Shared Variables by appeon  20070730
end variables

global type n_cst_anyarraysrv from n_base autoinstantiate
end type

type variables
//begin modification Shared Variables by appeon  20070730

constant int T_CHAR = 1
constant int T_BOOL = 2
constant int T_TIME = 3
constant int T_DATE = 4
constant int T_DATETIME = 5
constant int T_INT = 6
constant int T_UINT = 7
constant int T_LONG = 8
constant int T_ULONG = 9
constant int T_DEC = 10
constant int T_REAL = 11
constant int T_DOUBLE = 12
constant int T_NULL = 13
constant int T_ANY = 14
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public function long of_find (readonly any aaa_target[], any aa_search_value, long al_search_start, long al_search_end)
public function integer of_gettype (any aa_value)
public function boolean of_similar (integer ai_type1, integer ai_type2)
public function long of_summlong (ref long ala_target[])
public function long of_getunique (readonly any aaa_target[], ref any aaa_unique[])
public function long of_getshrinked (ref long shrink_array[], string instructions)
public function long of_findlong (readonly long aaa_target[], long aa_search_value, long al_search_start, long al_search_end)
public function long of_getshrinked (ref long ala_target[], boolean ab_shrinknulls, boolean ab_shrinkdupes)
public function long of_appendstring (ref string asa_target[], string asa_values[])
public function long of_appendany (ref any aaa_target[], any aaa_values[])
public function long of_appendlong (ref long ala_target[], long ala_values[])
public function long of_removelong (ref long ala_target[], long ala_remove[], boolean ab_shrinkremoved)
public function long of_getshrinked (ref string asa_target[], boolean ab_shrinknulls, boolean ab_shrinkdupes)
public function integer of_destroy (any aaa_objects[])
public function integer of_sortlong (ref long ala_values[])
public function long of_getshrinked (ref unsignedlong ala_target[], boolean ab_shrinknulls, boolean ab_shrinkdupes)
private function long of_getshrinked (ref unsignedlong shrink_array[], string instructions)
public function long of_appendlong (ref unsignedlong aula_target[], unsignedlong aula_values[])
public function long of_findlongfromsorted (readonly long al_source[], long al_value)
public function long of_insertlong (ref long ala_source[], long al_value)
end prototypes

public function long of_find (readonly any aaa_target[], any aa_search_value, long al_search_start, long al_search_end);//Return Values: The index in aaa_target where al_search_value is found (which can be 
//negative or 0 depending on the dimensions of aaa_target), or null if the value is not found

//NOTE: Even though the target is an array of anys, the types of the values in the array
//should not be mixed.  This causes a crash on the comparisons.  This restriction could
//be lifted by adding classname comparisons, but I would want to test that more thoroughly
//before including it.

//NOTE: Making the array argument pass by reference causes a type mismatch error when
//compiling the calling script (unless the array being passed is, in fact, an array of 
//anys, I would guess)
long ll_null
SetNull( ll_null )
integer li_valuetype

// Validate input values
if upperbound(aaa_target) = 0 and lowerbound(aaa_target) = 1 then return ll_null
if isnull(al_search_start) then al_search_start = lowerbound(aaa_target)
if isnull(al_search_end) then al_search_end = upperbound(aaa_target)

li_valuetype = of_GetType( aa_search_value )

// Do two version of search procesing
if al_search_start <= al_search_end then
	al_search_start = max(al_search_start, lowerbound(aaa_target))
	al_search_end = min(al_search_end, upperbound(aaa_target))
	do
		if isnull(aa_search_value) then
			if isnull(aaa_target[al_search_start]) then return al_search_start
		else
			// check types to compare ( you can remove one next line if need )
//			if not of_Similar( li_valuetype, of_GetType( aaa_target[al_search_start] ) ) then return ll_null
			// end check types to compare
			if aaa_target[al_search_start] = aa_search_value then return al_search_start
		end if
		al_search_start ++
	loop until al_search_start > al_search_end
	
else
	al_search_start = min(al_search_start, upperbound(aaa_target))
	al_search_end = max(al_search_end, lowerbound(aaa_target))

	do
		if isnull(aa_search_value) then
			if isnull(aaa_target[al_search_start]) then return al_search_start
		else
			// check types to compare ( you can remove one next line if need )
//			if not of_Similar( li_valuetype, of_GetType( aaa_target[al_search_start] ) ) then return ll_null
			// end check types to compare
			if aaa_target[al_search_start] = aa_search_value then return al_search_start
		end if
		al_search_start --
	loop until al_search_start < al_search_end

end if

return ll_null
end function

public function integer of_gettype (any aa_value);if IsNull( aa_value ) then return T_NULL
string ls_type
ls_type = lower( ClassName( aa_value ) )

choose case ls_type
	case "any"
		return T_ANY
	case "boolean"
		return T_BOOL
	case "char"
		return T_CHAR
	case "character"
		return T_CHAR
	case "date"
		return T_DATE
	case "datetime"
		return T_DATETIME
	case "time"
		return T_TIME
	case "dec"
		return T_DEC
	case "decimal"
		return T_DEC
	case "double"
		return T_DOUBLE
	case "integer"
		return T_INT
	case "int"
		return T_INT
	case "long"
		return T_LONG
	case "real"
		return T_REAL
	case "string"
		return T_CHAR
	case "unsignedinteger"
		return T_UINT
	case "unsignedint"
		return T_UINT
	case "uint"
		return T_UINT
	case "ulong"
		return T_ULONG
	case "unsignedlong"
		return T_ULONG
end choose
return T_NULL
end function

public function boolean of_similar (integer ai_type1, integer ai_type2);// Check if two different type can be compared in expression
if ( ai_type1 = T_ANY or ai_type2 = T_ANY ) then return false
if ( ai_type1 = ai_type2 ) then return true
if ( T_INT <= ai_type1 and ai_type1 <= T_DOUBLE ) and ( T_INT <= ai_type2 and ai_type2 <= T_DOUBLE ) then return true
return false
end function

public function long of_summlong (ref long ala_target[]);long ll_count, ll_index, ll_sum
ll_count = UpperBound ( ala_target )
for ll_index = 1 to ll_count
	if not IsNull ( ala_target[ ll_index ] ) then 
		ll_sum += ala_target[ ll_index ]
	end if
next
return ll_sum
end function

public function long of_getunique (readonly any aaa_target[], ref any aaa_unique[]);//This function lists the unique values contained in aaa_target and returns that list
//in the return structure.  The target array should contain values of the same type.
//I do not use f_array_find in the loop for performance reasons (f_array_find would 
//make another copy of the result list array each time it was called.)  I'm not sure
//how significant the performance hit would be -- this could potentially be changed.

//The choice of argument and return types is based on the fact that you can't hold an
//array in an any variable, and that you can't pass a non-any-array into an any-array
//by reference (it gives a type mismatch when compiling the calling script).

//Typical use of the function is as follows:
//any lxa_work[]
//long ll_count
//ll_count = f_array_unique(lxa_target,lxa_work)
//lxa_target = lxa_work

long ll_target_ndx, ll_result_ndx, ll_result_count
boolean lb_found

for ll_target_ndx = lowerbound(aaa_target) to upperbound(aaa_target)
	lb_found = false
	ll_result_count = upperbound(aaa_unique)
	for ll_result_ndx = 1 to ll_result_count
		if isnull(aaa_target[ll_target_ndx]) then
			if isnull(aaa_unique[ll_result_ndx]) then
				lb_found = true
				exit
			end if
		else
			// If cell value is noninitialized value the comparison will fail
			// I prefer to skeep this value
			if of_GetType( aaa_target[ll_target_ndx] ) = T_ANY then
				lb_found = true
				exit
			end if
			// If good value
			if aaa_unique[ll_result_ndx] = aaa_target[ll_target_ndx] then
				lb_found = true
				exit
			end if
		end if
	next
	if not lb_found then
		aaa_unique[ll_result_count + 1] = aaa_target[ll_target_ndx]
	end if
next

return upperbound(aaa_unique)

end function

public function long of_getshrinked (ref long shrink_array[], string instructions);//This function will strip nulls, duplicate values, or both, out of an array of longs.  
//The resulting array contains only the values kept, with no "holes."  The instructions
//parameter should specify which options to use: "NULLS", "DUPES", or "NULLS~tDUPES"

long shrink_elements, shrunk_elements, shrink_loop, shrunk_array[]
boolean strip_nulls, strip_dupes, null_in_shrunk
n_cst_numerical lnv_numerical


//---------Dan Code
//Datastore	lds_temp
//Long			ll_max
//Long			ll_index
//Long			ll_inserted
//Long			ll_newIndex
//Long			ll_value
//String		ls_filter
//Long			lla_newArray[]
//
//lds_temp = create Datastore
//
//lds_temp.dataobject = "d_onelongcolumn"
//
//lds_temp.settransobject( SQLCA )

//if pos(instructions, "NULLS") > 0 then strip_nulls = true
//if pos(instructions, "DUPES") > 0 then strip_dupes = true


//----from old code
		shrink_elements = upperbound(shrink_array)
		if lnv_numerical.of_IsNullOrNeg(shrink_elements) then return -1
		if shrink_elements = 0 then return 0
//-----------------


//ll_newIndex = 0

//IF strip_nulls THEN
//	//copy all the array contents into the datastore
//	ll_max = upperbound( shrink_array[] )
//	FOR ll_index = 1 to ll_max
//		//only add non null values
//		IF not isNULL( shrink_Array[ll_index] ) THEN
//			ll_inserted = lds_temp.insertRow( 0 )
//			lds_temp.setItem( ll_inserted,1, shrink_array[ll_index] )
//		END IF
//
//	NEXT
//ELSE
//lds_temp.object.nonduplicate.primary = shrink_array[]
////END IF
//lds_temp.sort()
//
//
//IF strip_nulls THEN
//	ls_filter = "isNull( nonduplicate )"
//	lds_temp.setFilter( ls_filter )
//	lds_temp.filter()
//
//	lds_temp.rowsDiscard(1, lds_temp.rowCount(), PRIMARY! )
//	
//	ls_filter = ""
//	lds_temp.setFilter( ls_filter ) 
//	lds_temp.filter( )
//END IF
//
//
//IF strip_dupes THEN
//	//get the first item, filter based on that item, remove all duplicates
//	
//	DO WHILE lds_temp.rowCount() > 0
//		ll_value = lds_temp.getItemNumber( 1,1 )
//		
//		IF Not isNULL( ll_value ) THEN
//			ls_filter = "nonduplicate = "+ string( ll_value )
//		ELSE
//			ls_filter = "isNull( nonduplicate )"
//		END IF
//		
//		lds_temp.setFilter( ls_filter )
//		lds_temp.filter()
//		
//		//lds_temp.rowsMove( 1, lds_temp.rowCount(), PRIMARY!, lds_temp, 1, DELETE! )
//		lds_temp.rowsDiscard(1, lds_temp.rowCount(), PRIMARY! )
//		
//		ll_newIndex++
//		lla_newArray[ll_newIndex] = ll_value
//		
//		
//		ls_filter = ""
//		
//		lds_temp.setFilter( ls_filter )
//		lds_temp.filter()
//		
//	LOOP
//END IF
//
//shrink_array[] = lla_newArray
//
//DESTROY lds_temp
//return ll_newIndex 
//-----------------


//---old code
if pos(instructions, "NULLS") > 0 then strip_nulls = true
if pos(instructions, "DUPES") > 0 then strip_dupes = true

//choose case classname(shrink_array)
//	case "long"
//		long shrink_longs[], shrunk_longs[]
//		shrink_longs = shrink_array
		shrink_elements = upperbound(shrink_array)
		if lnv_numerical.of_IsNullOrNeg(shrink_elements) then return -1
		if shrink_elements = 0 then return 0
		for shrink_loop = 1 to shrink_elements
			if isnull(shrink_array[shrink_loop]) then
				if strip_nulls then continue
				if strip_dupes and null_in_shrunk then continue
				null_in_shrunk = true
			elseif strip_dupes and shrunk_elements > 0 then
				if This.of_FindLong(shrunk_array, shrink_array[shrink_loop], &
					1, shrunk_elements) > 0 then continue
			end if
			shrunk_elements ++
			shrunk_array[shrunk_elements] = shrink_array[shrink_loop]
		next
		shrink_array = shrunk_array
		return shrunk_elements
//	case else
//		return -1
//end choose


end function

public function long of_findlong (readonly long aaa_target[], long aa_search_value, long al_search_start, long al_search_end);//Return Values: The index in aaa_target where al_search_value is found (which can be 
//negative or 0 depending on the dimensions of aaa_target), or null if the value is not found

//This is like of_Find, **EXCEPT** : It is optimized for Longs, and 
//IT DOES NOT FIND NULL VALUES  (WHEREAS of_Find does.)  Code to support
//finding nulls is included below, if we wanted to make that an option, 
//but MANY scripts (routing especially) assume that the function does 
//NOT find nulls, so we'd have to make that the default or extend all the calls.

long ll_null
SetNull( ll_null )


//---------Old code
// Validate input values

IF IsNull ( aa_Search_Value ) THEN RETURN ll_Null  //**SEE NOTE ABOVE**

if upperbound(aaa_target) = 0 and lowerbound(aaa_target) = 1 then return ll_null
if isnull(al_search_start) then al_search_start = lowerbound(aaa_target)
if isnull(al_search_end) then al_search_end = upperbound(aaa_target)

// Do two version of search procesing

if al_search_start <= al_search_end then
	al_search_start = max(al_search_start, lowerbound(aaa_target))
	al_search_end = min(al_search_end, upperbound(aaa_target))
	do
//		if isnull(aa_search_value) then  //**SEE NOTE ABOVE
//			if isnull(aaa_target[al_search_start]) then return al_search_start
//		else
			if aaa_target[al_search_start] = aa_search_value then return al_search_start
//		end if
		al_search_start ++
	loop until al_search_start > al_search_end
else
	al_search_start = min(al_search_start, upperbound(aaa_target))
	al_search_end = max(al_search_end, lowerbound(aaa_target))
	do
//		if isnull(aa_search_value) then  //**SEE NOTE ABOVE
//			if isnull(aaa_target[al_search_start]) then return al_search_start
//		else
			if aaa_target[al_search_start] = aa_search_value then return al_search_start
//		end if
		al_search_start --
	loop until al_search_start < al_search_end
end if

return ll_null
end function

public function long of_getshrinked (ref long ala_target[], boolean ab_shrinknulls, boolean ab_shrinkdupes);//Wrapper function to support the legacy string option format with a 
//more convenient boolean interface.

String	ls_ShrinkOptions

IF ab_ShrinkNulls AND ab_ShrinkDupes THEN
	ls_ShrinkOptions = "NULLS~tDUPES"
ELSEIF ab_ShrinkNulls THEN
	ls_ShrinkOptions = "NULLS"
ELSEIF ab_ShrinkDupes THEN
	ls_ShrinkOptions = "DUPES"
END IF

RETURN This.of_GetShrinked ( ala_Target, ls_ShrinkOptions )
end function

public function long of_appendstring (ref string asa_target[], string asa_values[]);//Appends the values in asa_Values to the target array, asa_Target
//Returns : The new number of elements in asa_Target

Long	ll_TargetCount, &
		ll_ValueCount, &
		ll_Index

ll_TargetCount = UpperBound ( asa_Target )
ll_ValueCount = UpperBound ( asa_Values )

FOR ll_Index = 1 TO ll_ValueCount

	ll_TargetCount ++
	asa_Target [ ll_TargetCount ] = asa_Values [ ll_Index ]

NEXT

RETURN ll_TargetCount
end function

public function long of_appendany (ref any aaa_target[], any aaa_values[]);//Appends the values in aaa_Values to the target array, aaa_Target
//Returns : The new number of elements in aaa_Target

Long	ll_TargetCount, &
		ll_ValueCount, &
		ll_Index

ll_TargetCount = UpperBound ( aaa_Target )
ll_ValueCount = UpperBound ( aaa_Values )

FOR ll_Index = 1 TO ll_ValueCount

	ll_TargetCount ++
	aaa_Target [ ll_TargetCount ] = aaa_Values [ ll_Index ]

NEXT

RETURN ll_TargetCount
end function

public function long of_appendlong (ref long ala_target[], long ala_values[]);//Appends the values in ala_Values to the target array, ala_Target
//Returns : The new number of elements in ala_Target

Long	ll_TargetCount, &
		ll_ValueCount, &
		ll_Index

ll_TargetCount = UpperBound ( ala_Target )
ll_ValueCount = UpperBound ( ala_Values )

//Different handling below depending on whether there are existing elements in ala_Target
//is for performance reasons only.  It would work fine with just the loop, but there's no
//need for the loop processing if we can just make the target array the values array.

IF ll_TargetCount > 0 THEN

	FOR ll_Index = 1 TO ll_ValueCount
	
		ll_TargetCount ++
		ala_Target [ ll_TargetCount ] = ala_Values [ ll_Index ]
	
	NEXT

ELSE

	ala_Target = ala_Values
	ll_TargetCount = ll_ValueCount

END IF

RETURN ll_TargetCount
end function

public function long of_removelong (ref long ala_target[], long ala_remove[], boolean ab_shrinkremoved);//Removes the values specified in ala_Remove from ala_Target.
//If ab_ShrinkRemoved is TRUE, the target array will be collapsed as values are removed.
//If ab_ShrinkRemoved is FALSE, the target array will contain null entries in place of
//removed entries.  
//Including a null entry in ala_Remove WILL NOT remove null values from ala_Target.
//The return value is the number of entries in the resulting target array being passed
//out by reference, which may be the same or less than the number of entries passed in.

/*

Modified on June 29 2005:  Prior to change if ala_Remove was empty an empty array was returned
									Now, if ala_Remove is empty the original ala_Target is passed back


*/


Long	lla_Result[], &
		ll_ResultCount, &
		ll_TargetCount, &
		ll_RemoveCount, &
		ll_Index, &
		ll_ResultEntry

ll_TargetCount = UpperBound ( ala_Target )
ll_RemoveCount = UpperBound ( ala_Remove )

IF ll_RemoveCount = 0 THEN
	
	ll_ResultCount = ll_targetCount

ELSEIF ll_TargetCount > 0 AND ll_RemoveCount > 0 THEN

	FOR ll_Index = 1 TO ll_TargetCount

		IF This.of_FindLong ( ala_Remove, ala_Target [ ll_Index ], 1, ll_RemoveCount ) > 0 THEN

			//The target value is in the remove array.  Either skip it or make it null in the
			//result array depending on the value of ab_ShrinkRemoved.

			IF ab_ShrinkRemoved THEN
				//Skip over the value in the result array.
				CONTINUE
			ELSE
				SetNull ( ll_ResultEntry )
			END IF

		ELSE
			ll_ResultEntry = ala_Target [ ll_Index ]

		END IF

		ll_ResultCount ++
		lla_Result [ ll_ResultCount ] = ll_ResultEntry				

	NEXT
	
	ala_Target = lla_Result

END IF



RETURN ll_ResultCount
end function

public function long of_getshrinked (ref string asa_target[], boolean ab_shrinknulls, boolean ab_shrinkdupes);//This function will strip nulls, duplicate values, or both, out of an array of strings.  
//The resulting array contains only the values kept, with no "holes."  The instructions
//parameter should specify which options to use: "NULLS", "DUPES", or "NULLS~tDUPES"

long	ll_shrinkcount, &
		ll_shrunkcount, &
		ll_ndx
string	lsa_shrunk[]
		
boolean strip_nulls, strip_dupes, null_in_shrunk
n_cst_numerical lnv_numerical
boolean lb_skip

//---new code by Dan
//the following function takes the array passed in and then puts
//all of it contents into a datastore
//Then through a series of filters and sorts, it removes any duplicate values from
//itself, and then it replaces the old array with a new one with the values
//refilled by the datastore

//Datastore	lds_temp
//Long			ll_max
//Long			ll_index
//Long			ll_inserted
//Long			ll_newIndex
//Long			ll_total
//Long			ll_dec
//String		ls_value
//String		ls_filter
//String		lsa_newArray[]
//
//lds_temp = create Datastore
//
//lds_temp.dataobject = "d_onestringcolumn"
//
//
//
////----from old code
//ll_shrinkcount = upperbound(asa_target)
//if lnv_numerical.of_IsNullOrNeg(ll_shrinkcount) then return -1
//if ll_shrinkcount = 0 then return 0
////-----------------
//
//
//ll_newIndex = 0
//
////IF ab_shrinkNulls THEN
////	//copy all the array contents into the datastore adding nulls only if necessary
////	ll_max = upperbound( asa_target )
////	FOR ll_index = 1 to ll_max
////		//only add non null values
////		IF not isNULL( asa_target[ll_index] ) THEN
////			ll_inserted = lds_temp.insertRow( 0 )
////			lds_temp.setItem( ll_inserted,1, asa_target[ll_index] )
////		END IF
////	NEXT
////ELSE
//lds_temp.object.nonduplicate.primary = asa_target[]
////END IF
//lds_temp.sort()
//
//IF ab_shrinkNulls THEN
//	ls_filter = "isNull( nonduplicate )"
//	lds_temp.setFilter( ls_filter )
//	lds_temp.filter()
//
//	lds_temp.rowsDiscard(1, lds_temp.rowCount(), PRIMARY! )
//	
//	ls_filter = ""
//	lds_temp.setFilter( ls_filter ) 
//	lds_temp.filter( )
//	
//	IF not ab_shrinkdupes THEN
//		lsa_newArray = lds_temp.object.nonduplicate.primary
//	END IF
//END IF
//
//
//
//IF ab_shrinkdupes THEN
//	//get the first item, filter based on that item, remove all duplicates
//	//mEssagebox("array service, of_getShrinked","before loop")
//	
//	ll_total = lds_temp.rowCount()
//	DO WHILE ll_total > 0
//		ls_value = lds_temp.getItemString( 1,1 )
//		
//		IF Not isNULL( ls_value ) THEN
//			ls_filter = "nonduplicate = '"+ ls_value +"'"
//		ELSE
//			ls_filter = "isNull( nonduplicate )"
//		END IF
//		
//		lds_temp.setFilter( ls_filter )
//		lds_temp.filter()
//		
//		ll_dec = lds_temp.rowCount()
//		//lds_temp.rowsMove( 1, lds_temp.rowCount(), PRIMARY!, lds_temp, 1, DELETE! )
//		lds_temp.rowsDiscard(1, ll_dec, PRIMARY! )
//		
//		ll_newIndex++
//		lsa_newArray[ll_newIndex] = ls_value
//		
//		
//		ls_filter = ""
//		
//		lds_temp.setFilter( ls_filter )
//		lds_temp.filter()
//		ll_total -= ll_dec
//	LOOP
//END IF
//
//asa_target = lsa_newArray
//
//DESTROY lds_temp
//return ll_newIndex 

//---------------------
// old working code, but it was slow and did poorly with memory
ll_shrinkcount = upperbound(asa_target)

if lnv_numerical.of_IsNullOrNeg(ll_shrinkcount) then return -1
if ll_shrinkcount = 0 then return 0
for ll_ndx = 1 to ll_shrinkcount
	
	if isnull(asa_target[ll_ndx]) then
		if ab_shrinknulls then continue
		if ab_shrinkdupes and null_in_shrunk then continue
		null_in_shrunk = true
	elseif ab_shrinkdupes and ll_shrunkcount > 0 then
		if This.of_Find(lsa_shrunk, asa_target[ll_ndx], &
			1, ll_shrunkcount) > 0 then continue
	end if
	
	ll_shrunkcount ++
	lsa_shrunk[ll_shrunkcount] = asa_target[ll_ndx]
next
asa_target = lsa_shrunk

return ll_shrunkcount

end function

public function integer of_destroy (any aaa_objects[]);Long	ll_Count
Long	ll_I

ll_Count = UpperBound ( aaa_Objects[ ] )

FOR ll_i = 1 TO ll_Count
	DESTROY (  aaa_Objects[ ll_i ] )
NEXT

RETURN 1
end function

public function integer of_sortlong (ref long ala_values[]);//Ascending Sort //

Int	i
Int	j
Long	lla_Values[]
Long	ll_Temp
Int	li_Count


lla_Values = ala_Values[]
li_Count=upperbound(lla_Values)

For i=1 to li_Count  
	For j=i+1 to li_Count  
   	if lla_Values[i] > lla_Values[j] then 
			ll_Temp = lla_Values[i] 
		 	lla_Values[i] = lla_Values[j] 
		 	lla_Values[j] = ll_Temp 
     end if 
   next  
next  

ala_Values[] = lla_Values

RETURN 1
end function

public function long of_getshrinked (ref unsignedlong ala_target[], boolean ab_shrinknulls, boolean ab_shrinkdupes);//Wrapper function to support the legacy string option format with a 
//more convenient boolean interface.

String	ls_ShrinkOptions

IF ab_ShrinkNulls AND ab_ShrinkDupes THEN
	ls_ShrinkOptions = "NULLS~tDUPES"
ELSEIF ab_ShrinkNulls THEN
	ls_ShrinkOptions = "NULLS"
ELSEIF ab_ShrinkDupes THEN
	ls_ShrinkOptions = "DUPES"
END IF

RETURN This.of_GetShrinked ( ala_Target, ls_ShrinkOptions )
end function

private function long of_getshrinked (ref unsignedlong shrink_array[], string instructions);//This function will strip nulls, duplicate values, or both, out of an array of longs.  
//The resulting array contains only the values kept, with no "holes."  The instructions
//parameter should specify which options to use: "NULLS", "DUPES", or "NULLS~tDUPES"

long shrink_elements, shrunk_elements, shrink_loop, shrunk_array[]
boolean strip_nulls, strip_dupes, null_in_shrunk
n_cst_numerical lnv_numerical


//---------Dan Code
//Datastore	lds_temp
//Long			ll_max
//Long			ll_index
//Long			ll_inserted
//Long			ll_newIndex
//Long			ll_value
//String		ls_filter
//unsignedLong			lla_newArray[]
//
//lds_temp = create Datastore
//
//lds_temp.dataobject = "d_onelongcolumn"
//
//lds_temp.settransobject( SQLCA )
//
//if pos(instructions, "NULLS") > 0 then strip_nulls = true
//if pos(instructions, "DUPES") > 0 then strip_dupes = true
//
//
////----from old code
//		shrink_elements = upperbound(shrink_array)
//		if lnv_numerical.of_IsNullOrNeg(shrink_elements) then return -1
//		if shrink_elements = 0 then return 0
////-----------------
//
//
//ll_newIndex = 0
//
////IF strip_nulls THEN
////	//copy all the array contents into the datastore adding nulls only if necessary
////	ll_max = upperbound( shrink_array[] )
////	FOR ll_index = 1 to ll_max
////		//only add non null values
////		IF not isNULL( shrink_Array[ll_index] ) THEN
////			ll_inserted = lds_temp.insertRow( 0 )
////			lds_temp.setItem( ll_inserted,1, shrink_array[ll_index] )
////		END IF
////
////	NEXT
////ELSE
//lds_temp.object.nonduplicate.primary = shrink_array[]
////END IF
//lds_temp.sort()
//
//IF strip_nulls THEN
//	ls_filter = "isNull( nonduplicate )"
//	lds_temp.setFilter( ls_filter )
//	lds_temp.filter()
//
//	lds_temp.rowsDiscard(1, lds_temp.rowCount(), PRIMARY! )
//	
//	ls_filter = ""
//	lds_temp.setFilter( ls_filter ) 
//	lds_temp.filter( )
//END IF
//
//IF strip_dupes THEN
//	//get the first item, filter based on that item, remove all duplicates
//	
//	DO WHILE lds_temp.rowCount() > 0
//		ll_value = lds_temp.getItemNumber( 1,1 )
//		
//		IF Not isNULL( ll_value ) THEN
//			ls_filter = "nonduplicate = "+ string( ll_value )
//		ELSE
//			ls_filter = "isNull( nonduplicate )"
//		END IF
//		
//		lds_temp.setFilter( ls_filter )
//		lds_temp.filter()
//		
//		//lds_temp.rowsMove( 1, lds_temp.rowCount(), PRIMARY!, lds_temp, 1, DELETE! )
//		lds_temp.rowsDiscard(1, lds_temp.rowCount(), PRIMARY! )
//		
//		ll_newIndex++
//		lla_newArray[ll_newIndex] = ll_value
//		
//		
//		ls_filter = ""
//		
//		lds_temp.setFilter( ls_filter )
//		lds_temp.filter()
//		
//	LOOP
//END IF
//shrink_array[] = lla_newArray
//
//DESTROY lds_temp
//return ll_newIndex 
//-----------------


// old working code
if pos(instructions, "NULLS") > 0 then strip_nulls = true
if pos(instructions, "DUPES") > 0 then strip_dupes = true

//choose case classname(shrink_array)
//	case "long"
//		long shrink_longs[], shrunk_longs[]
//		shrink_longs = shrink_array
		shrink_elements = upperbound(shrink_array)
		if lnv_numerical.of_IsNullOrNeg(shrink_elements) then return -1
		if shrink_elements = 0 then return 0
		for shrink_loop = 1 to shrink_elements
			if isnull(shrink_array[shrink_loop]) then
				if strip_nulls then continue
				if strip_dupes and null_in_shrunk then continue
				null_in_shrunk = true
			elseif strip_dupes and shrunk_elements > 0 then
				if This.of_FindLong(shrunk_array, shrink_array[shrink_loop], &
					1, shrunk_elements) > 0 then continue
			end if
			shrunk_elements ++
			shrunk_array[shrunk_elements] = shrink_array[shrink_loop]
		next
		shrink_array = shrunk_array
		return shrunk_elements
//	case else
//		return -1
//end choose


end function

public function long of_appendlong (ref unsignedlong aula_target[], unsignedlong aula_values[]);//Appends the values in ala_Values to the target array, ala_Target
//Returns : The new number of elements in ala_Target

Long	ll_TargetCount, &
		ll_ValueCount, &
		ll_Index

ll_TargetCount = UpperBound ( aula_target[] )
ll_ValueCount = UpperBound ( aula_values[] )

//Different handling below depending on whether there are existing elements in ala_Target
//is for performance reasons only.  It would work fine with just the loop, but there's no
//need for the loop processing if we can just make the target array the values array.

IF ll_TargetCount > 0 THEN

	FOR ll_Index = 1 TO ll_ValueCount
	
		ll_TargetCount ++
		aula_Target [ ll_TargetCount ] = aula_Values [ ll_Index ]
	
	NEXT

ELSE

	aula_Target = aula_Values
	ll_TargetCount = ll_ValueCount

END IF

RETURN ll_TargetCount
end function

public function long of_findlongfromsorted (readonly long al_source[], long al_value);// 		Created By dan
//Return Values: The index in aaa_target where al_search_value is found (which can be 
//The following searches an entire array for a value and returns the index when it finds it.
//It returns null if it doesn't find it.  The function requires a sorted array in order to work.

//negative or 0 depending on the dimensions of aaa_target), or null if the value is not found

//This is like of_Find, **EXCEPT** : It is optimized for Longs, and 
//IT DOES NOT FIND NULL VALUES  (WHEREAS of_Find does.)  Code to support
//finding nulls is included below, if we wanted to make that an option, 
//but MANY scripts (routing especially) assume that the function does 
//NOT find nulls, so we'd have to make that the default or extend all the calls.

Long	ll_return
long ll_null
SetNull( ll_null )

Long	ll_first
Long	ll_mid
Long	ll_last


ll_last = upperBound( al_source )

//---------Old code
// Validate input values

IF IsNull ( al_value ) THEN RETURN ll_Null  //**SEE NOTE ABOVE**

if ll_last = 0 and lowerbound(al_source) = 1 then return ll_null


ll_first = 1

DO WHILE  ll_first <= ll_last
	ll_mid = ((ll_first + ll_last)/2)
	
	IF al_source[ll_mid] = al_value THEN
		RETURN ll_mid
	END IF
		
	IF al_source[ll_mid] > al_value THEN
		ll_last = ll_mid - 1
	ELSE
		ll_first = ll_mid + 1
	END IF
LOOP
	

RETURN ll_null

end function

public function long of_insertlong (ref long ala_source[], long al_value);/*written by Dan
	The following is meant to insert al_value into an already sorted array of longs(ascending)
	and returnt the index it inserted the item at.
*/

Long	i
Long	ll_max

Long	ll_index
Long	lla_new[]
Boolean lb_inserted

i = 0
ll_max = upperBound(ala_source) + 1
DO WHILE  i < ll_max AND ll_index = 0
	i++
	IF i < ll_max THEN
		//we found where we want to insert the item, right before i
		IF ala_source[i] > al_value THEN
			ll_index = i 
		ELSE
			lla_new[i] = ala_source[i]
		END IF
	END IF
LOOP

//if we didn't find it we insert it at the end
IF ll_index = 0 THEN 
	lla_new[ll_max] = al_value
	ll_index = ll_max
ELSE						//we found an index
	
	//insert the new value and copy the rest of the array
	lla_new[ll_index] = al_value
	DO WHILE  i <= ll_max
		i++
		lla_new[i] = ala_source[i - 1]
	LOOP
END IF
//MessageBox(string(al_value)+"value", ll_index)
ala_source = lla_new
RETURN ll_index
end function

on n_cst_anyarraysrv.create
call super::create
end on

on n_cst_anyarraysrv.destroy
call super::destroy
end on

