$PBExportHeader$n_cst_modlicenses.sru
forward
global type n_cst_modlicenses from nonvisualobject
end type
end forward

global type n_cst_modlicenses from nonvisualobject
end type
global n_cst_modlicenses n_cst_modlicenses

forward prototypes
public function long of_gettotalusercount (string asa_counts[])
public function long of_getmodcount (string asa_Counts[])
public function long of_getmax (string asa_counts[])
public function string of_convert (decimal adec_number)
public function integer of_getmodlist (integer ai_group, ref string asa_mods[])
public function integer of_parsestring (readonly string as_string, ref string asa_parts[])
public function string of_getkeyfromcounts (integer ai_group, integer ai_mod1count, integer ai_mod2count, integer ai_mod3count, integer ai_mod4count, integer ai_mod5count, integer ai_mod6count, integer ai_mod7count, integer ai_mod8count)
public function integer of_getcountsfromkey (string as_key, ref string asa_results[])
public function integer of_updatetable (integer ai_groupnum, string as_modcount)
public function integer of_convertback (readonly string as_parts, ref decimal ad_result)
public function integer of_formatparts (decimal ad_tobeformated, ref string asa_formated[], integer ai_format)
private function integer of_validatekey (string asa_parts[])
end prototypes

public function long of_gettotalusercount (string asa_counts[]);Long	ll_Test
Long	ll_TotalUserCount
Int	i


FOR i = 1 TO UpperBound (  asa_counts[]) 
	ll_Test = Long ( asa_counts[i] )
	ll_TotalUserCount += ll_Test
	
NEXT

Return ll_TotalUsercount
end function

public function long of_getmodcount (string asa_Counts[]);Long 	i	
Long	ll_Test
long	ll_ModCount 

FOR i = 1 TO UpperBound ( asa_Counts[] ) 
	ll_Test = INTEGER ( asa_Counts[i] )
	IF ll_Test > 0 THEN
		ll_ModCount ++
	END IF
NEXT

RETURN ll_ModCount 

end function

public function long of_getmax (string asa_counts[]);long		ll_Max
Int		li_Test
INT		i
STRING	lsa_Nums[]

lsa_Nums = asa_Counts[]
	IF UpperBound ( lsa_Nums ) > 0 THEN
	ll_Max =  Long (lsa_Nums[1])
	
	FOR i = 1 TO UpperBound (  lsa_Nums ) 
		li_Test = Long ( lsa_Nums[i] )
		IF li_Test > ll_Max THEN
			ll_Max = li_Test
		END IF
	NEXT
END IF

RETURN ll_Max
end function

public function string of_convert (decimal adec_number);/*
This function converts a base 10 decimal number to a base 36 number.
as in all the functions in this object variable data types are very important since 
some of the numbers passed around can be quite large and precision must be maintained.
The result will be returned in the form of a string as to accomadate the letters.

*/

DEC		ld_ToBeConverted
Int		li_Remainder
Int		li_Base 
Int		li_Count
String	ls_Char
String	ls_Result
String	lia_Units[]
String 	ls_Value
String	ls_String
String	lsa_Nums[100]
Int 		i = 1
Int 		j = 1

n_cst_String	lnv_String
ls_Value = String (adec_number)
ld_ToBeconverted = DEC (adec_number)
li_Base = 36

li_Count = UpperBound(  lsa_Nums)

DO 
	li_Remainder = MOD ( ld_Tobeconverted , li_Base )
	
	IF li_Remainder > 9 AND li_Remainder <= 35 THEN
		ls_Char = char (li_remainder + 55 ) 
		lsa_Nums[li_Count] = ls_Char
			
	ELSE
		
		lsa_Nums[li_Count] =  String (li_Remainder)
	END IF
	
	ld_TobeConverted =   ld_TobeConverted / li_Base
	ld_ToBeConverted = Truncate (ld_TobeConverted, 0 )
	
	li_Count --

Loop While ld_Tobeconverted >= 1

lnv_String.of_ArrayToString( lsa_Nums , "" , ls_Result )

RETURN ls_Result

end function

public function integer of_getmodlist (integer ai_group, ref string asa_mods[]);// each group can only have 8 mods if more modules are needed then an additional case 
// will be needed.

// NOTE: When new groups are added, be sure to add them starting at position 1 in the mod 
//       array as to provide a more cryptic key.
String	lsa_Mod[]
Int		li_ReturnValue = 1

//begin modifing by appeon 20070726
//n_cst_Constants	lnv_consts
n_cst_Constant	lnv_consts
//end modifing by appeon 20070726
CHOOSE CASE ai_Group
		
	CASE 1
		lsa_Mod[1] = lnv_Consts.cs_Module_Dispatch
		lsa_Mod[2] = lnv_Consts.cs_Module_Brokerage
		lsa_Mod[3] = lnv_Consts.cs_Module_Billing
		lsa_Mod[4] = lnv_Consts.cs_Module_LogAudit
		lsa_Mod[5] = lnv_Consts.cs_Module_settlements
		lsa_Mod[6] = lnv_Consts.cs_Module_Scanning
		lsa_Mod[7] = lnv_Consts.cs_Module_Imaging
		lsa_Mod[8] = lnv_Consts.cs_Module_FuelTax

		asa_Mods[] = lsa_Mod
		
	CASE 2
		lsa_Mod[1] = lnv_Consts.cs_Module_AutoRating
		lsa_Mod[2] = lnv_Consts.cs_Module_RouteOptimizer
		asa_Mods[] = lsa_Mod
		
	CASE ELSE
		messageBox ( "group number", "The specified group has not yet been defined.")
		li_ReturnValue = -1
END CHOOSE

Return li_ReturnValue
end function

public function integer of_parsestring (readonly string as_string, ref string asa_parts[]);String	lsa_Parts[]
INT		li_Return = 1

n_cst_string	lnv_String

lnv_String.of_ParseToArray ( as_string , "-" , lsa_Parts )

IF upperbound (lsa_Parts ) <> 4 THEN
	li_Return = -1
ELSE
	asa_Parts = lsa_Parts
END IF

RETURN li_Return
end function

public function string of_getkeyfromcounts (integer ai_group, integer ai_mod1count, integer ai_mod2count, integer ai_mod3count, integer ai_mod4count, integer ai_mod5count, integer ai_mod6count, integer ai_mod7count, integer ai_mod8count);/*
This function is used to generate a coded key to be used to set module license limits.
the ModxCount variables rely on fixed position. meaning that for the specified group Mod1Count 
will always refer to a specific predefined moudle. Modules and their posion in the mod Count 
are defined in this object.
for example :
		for group 1,
			Mod1Count = "dispatch"
			
			See of_getModList
			
this code will generate a code in the form X-X-X-X 
More specificaly:
		Group# - Encrypted mod counts - Check # 1 - Check # 2
*/

String	ls_Result
String	lsa_Units[]
String	ls_TempResult
String 	ls_Value
Long		ll_Max
Long		ll_ModCount
Long		ll_TotalUserCount
Int 		li_Group
Int 		i = 1
Int		li_CheckTwo 
Int		li_CheckOne 
DEC		ldec_Nums[]


SetPointer ( hourGlass! )

li_Group = ai_Group
lsa_Units [1] = String (ai_Mod1Count, "00")
lsa_Units [2] = String (ai_Mod2Count, "00")
lsa_Units [3] = String (ai_Mod3Count, "00")
lsa_Units [4] = String (ai_Mod4Count, "00")
lsa_Units [5] = String (ai_Mod5Count, "00")
lsa_Units [6] = String (ai_Mod6Count, "00")
lsa_Units [7] = String (ai_Mod7Count, "00")
lsa_Units [8] = String (ai_Mod8Count, "00")

For i = 1 To 8 
	ls_Value += lsa_Units[i]
NEXT

ll_TotalUserCount = THIS.of_getTotalUserCount ( lsa_Units )
ll_ModCount = THIS.of_GetModCount ( lsa_Units )
ll_max = THIS.of_getMax( lsa_Units )

li_CheckOne = ll_TotalUserCount - ll_Max

li_CheckTwo = li_Group + ll_ModCount

ldec_Nums [1] = li_Group
ldec_Nums [2] = Dec(ls_Value)
ldec_Nums [3] = li_CheckOne
ldec_Nums [4] = li_CheckTwo

For i = 1 TO 4
	
	ls_TempResult = THIS.of_Convert (  Dec (ldec_Nums[i]) )
	
	CHOOSE CASE i
			CASE 1
				ls_Result = String( ls_TempResult  ) +"-"
			CASE 2
				ls_Result += String( ls_TempResult ) +"-"
			CASE 3
				ls_Result += String( ls_TempResult ) +"-"
			CASE 4
				ls_Result += String( ls_TempResult ) 
	END CHOOSE
	
NEXT
	
Return ls_Result

end function

public function integer of_getcountsfromkey (string as_key, ref string asa_results[]);/*	Pass this function a string in the form X-X-X-X ( X being of varialble length ) and the 
	result will be an array of upper bound = 4 with the group, module count ( separated by "," )
	the first validity check and the second validity check respectivly.

*/
String	ls_Result
String	lsa_Parts[]
String	lsa_Units[]
String	lsa_Formated[]
Int		i
Int		li_ReturnValue
DEC		ld_Results


ls_Result = as_Key

IF THIS.of_ParseString ( ls_Result , lsa_Parts ) = 1 THEN
	
	FOR i = 1 TO 4 
		IF THIS.of_ConvertBack ( lsa_Parts[i] , ld_Results ) = 1 THEN		
			THIS.of_FormatParts ( ld_Results , lsa_Formated , i )
		END IF	
	
	NEXT
END IF

IF THIS.of_ValidateKey ( lsa_Formated ) = 1 THEN
	asa_results[] = lsa_Formated[]
	li_ReturnValue = 1
END IF
	
RETURN li_ReturnValue 


end function

public function integer of_updatetable (integer ai_groupnum, string as_modcount);// each group can only have 8 mods
/*
	This is the funtion which will update or initalize the magical module count table. 
	after a key has been decoded and validated it will be sent over here where any changes 
	to the DB will be made.
	
	as you can see it takes it the group as well as a string which contains the module counts
	separated by a "," .
*/
String	lsa_Mod[]
String	ls_Module
String	lsa_Result[]
Int		i =1
Int		li_Return = 1
Int		li_Count
Long		ll_NewRow
long		ll_Row
long		ll_FoundRow

DataStore	lds_Update
DataStore	lds_Temp

lds_upDate = Create DataStore
lds_Temp = Create DataStore

lds_Update.dataObject = "d_licenseupdate"
lds_UpDate.settransObject ( sqlca )
lds_Update.Retrieve ()

lds_Temp.Dataobject = "d_modulelicenses"
lds_Temp.settransObject ( sqlca )

commit;

N_cst_String	lnv_String	

lnv_String.of_ParseToArray ( as_ModCount , ",", lsa_Result )
	
THIS.of_GetModList ( ai_GroupNum , lsa_Mod )
		
// this populates a temporary ds with the counts per module
FOR i = 1 TO UpperBound ( lsa_Mod )
	
	ll_NewRow =	lds_Temp.InsertRow (0 )
	lds_Temp.SetItem( ll_NewRow , "module" , lsa_Mod[i] )
	lds_Temp.SetItem( ll_NewRow , "licensed" , Integer ( lsa_Result [i] ) )
	
NEXT

ll_NewRow = 0

// after retreiving the existing counts and regestered modules the rows of the above
// temp ds looped through and if a module from lds_Temp is found in the retreived table
// then the count is updated to the new value. if no existing module is found then
// it is added to the table
For ll_Row = 1 TO lds_Temp.RowCount ( )

	IF ll_Row > 0 THEN
		ls_Module = lds_Temp.GetItemString( ll_Row , "module" )
		IF Len ( Trim ( ls_Module ) ) > 0 THEN
			li_Count  = lds_Temp.GetItemNumber( ll_Row , "licensed" )
			ll_FoundRow = lds_Update.Find ( "module = '" + ls_module +"'", 0, lds_Update.RowCount() + 1 )
			IF ll_FoundRow > 0 THEN
				
				IF li_Count > 0 THEN
					lds_Update.SetItem( ll_FoundRow , "module", ls_Module )
					lds_Update.SetItem( ll_FoundRow , "licensed", li_Count )
					lds_Update.SetItem( ll_FoundRow , "inuse", 0 )
				ELSEIF li_Count = 0 THEN
					lds_Update.DeleteRow( ll_FoundRow )
				END IF
				
			ELSEIF ll_FoundRow = 0 THEN
				IF li_Count > 0 THEN
					ll_NewRow = lds_Update.InsertRow( 0 ) 
					IF ll_NewRow > 0 THEN
				
						lds_Update.SetItem( ll_NewRow , "module", ls_Module )
						lds_Update.SetItem( ll_NewRow , "licensed", li_Count )
						lds_Update.SetItem( ll_newRow , "inuse", 0 )
					END IF
				END IF
			END IF
		END IF
	END IF

NEXT

IF li_Return = 1 THEN
	
	IF	lds_Update.Update ( ) = 1 THEN
		Commit ;
	ELSE
		li_Return = -1 
		MessageBox ( "Profit Tools CD key" , "An error occurred while attempting to process your serial number. If the problem persists please contact Profit Tools." )
	END IF
END IF


DESTROY lds_Temp
DESTROY lds_Update

RETURN li_Return



end function

public function integer of_convertback (readonly string as_parts, ref decimal ad_result);String	lsa_Nums[]
String	ls_Result
String	ls_Working
Int		i
Int		li_Number
DEC		ld_Sum
DEC		ld_Power
DEC		ld_Base = 36

n_cst_String	lnv_String

ls_Result = as_Parts

For i = 1 TO Len ( ls_Result ) 
	lsa_Nums[i] = MID ( ls_Result, i ,1) 
NEXT

IF Upperbound (lsa_Nums) > 0 THEN
	Do 
		
		ls_Working = lsa_Nums[ Upperbound (lsa_Nums) - ld_Power ]
		IF IsNumber ( ls_Working )THEN
			li_Number = Integer ( ls_Working )
		ELSE
			li_number = ASC ( UPPER (ls_Working) ) - 55
		END IF
		
		ld_Sum += (ld_Base ^ ld_Power ) * li_number
		ld_Power ++ 
		
	LOOP while ld_Power < Upperbound (lsa_Nums)

END IF

ld_Sum = Truncate (ld_Sum, 0 )

ad_Result = ld_Sum 
	
RETURN 1
end function

public function integer of_formatparts (decimal ad_tobeformated, ref string asa_formated[], integer ai_format);/*
The module count must have a resulting length of 16, the other counts can vary.
*/
String	ls_Temp
String	ls_Temp2
Int 		i
String 	ls_Count

Choose Case ai_Format
	CASE 1 , 3 , 4
		asa_Formated[ai_Format] = String ( ad_ToBeFormated ) 
	CASE 2
		ls_Count = String( ad_ToBeFormated , "0000000000000000" )
		i = 1
		IF Len ( ls_Count ) = 16 THEN
			FOR i = 1 TO 15 Step 2
				ls_Temp = (MID ( ls_Count , i, 2 ))
				IF i = 15 THEN
					ls_Temp2 += ls_Temp
				ELSE
					ls_Temp2 += ls_Temp + ","
				END IF
			NEXT
		END IF
		asa_Formated[ai_Format] = ls_Temp2

END CHOOSE

RETURN 1
end function

private function integer of_validatekey (string asa_parts[]);/* this function is responsible for validating the integrity of the key.
2 checks are used as can be seen below.

*/
String	lsa_Units[]
String	lsa_Formated[]
Long		ll_TotalUserCount 

Int		li_CheckOne 
Int		li_ModCount
Int		li_max
Int		li_Group
Int		li_CheckTwo 
Int		li_ReturnValue
Boolean	lb_Valid


lsa_Formated = asa_parts

IF upperBound  ( lsa_Formated ) = 4 THEN
	n_cst_String	lnv_String
	lnv_String.of_ParseToArray ( lsa_Formated[2] , "," , lsa_Units )
	
	ll_TotalUserCount = THIS.of_getTotalUserCount ( lsa_Units )
	li_ModCount = THIS.of_GetModCount ( lsa_Units )
	li_max = THIS.of_getMax( lsa_Units )
			
	li_Group = Integer ( lsa_Formated[1] )
	li_CheckOne = ll_TotalUserCount - li_Max
	
	li_CheckTwo = li_Group + li_ModCount
	
	IF li_checkOne = INTEGER (lsa_Formated[3]) THEN
		lb_Valid = TRUE
	ELSE
		lb_Valid = FALSE
	END IF
	
	IF lb_Valid THEN
		IF li_checktwo = INTEGER (lsa_Formated[4]) THEN
			
		ELSE
			lb_Valid = FALSE
		END IF
	END IF
	
	IF lb_Valid THEN
		li_ReturnValue = 1
	ELSE
		li_ReturnValue = 0
	END IF
	
END IF

RETURN li_ReturnValue
end function

on n_cst_modlicenses.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_modlicenses.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

