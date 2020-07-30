$PBExportHeader$n_cst_template.sru
forward
global type n_cst_template from n_base
end type
end forward

global type n_cst_template from n_base
end type
global n_cst_template n_cst_template

forward prototypes
public function string of_gettag (string as_Text)
public function integer of_replacetags (string asa_tag[], string asa_data[])
public function integer of_replacetags (string asa_Tags[], datastore ads_data)
protected subroutine of_striptagbrackets (string asa_tags[], ref string asa_strippedtags[])
public function long of_gettags (string as_rangetext, ref string asa_tags[])
end prototypes

public function string of_gettag (string as_Text);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTag
//
//	Access:  private
//
//	Arguments:  as_text
//					
//
// Returns:		 tag
//
//
//	Description:	find tag and pass back. 
//
//
//
// Written by: Norm LeBlanc
// 		Date: 9/12/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
string	ls_Tag
			
long	ll_TagStartPos, &
		ll_TagEndPos
		
boolean	lb_GetTag = TRUE

ll_TagStartPos = 1 

ll_TagStartPos = pos( as_Text, "<", ll_TagStartPos )
IF ll_TagStartPos > 0 THEN
	
	ll_TagendPos = pos( as_Text, ">", ll_TagStartPos )
	
	IF ll_TagendPos > 0 THEN
		ls_Tag = mid ( as_Text, ll_TagStartPos, ( ll_TagendPos - ll_TagStartPos ) + 1 )
	ELSE
		ls_Tag = ''
	END IF
	
ELSE
	
	ls_Tag = ''
	
END IF

return ls_Tag
end function

public function integer of_replacetags (string asa_tag[], string asa_data[]);return -1
end function

public function integer of_replacetags (string asa_Tags[], datastore ads_data);return -1
end function

protected subroutine of_striptagbrackets (string asa_tags[], ref string asa_strippedtags[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_StripTagBrackets
//
//	Access:  private
//
//	Arguments:  asa_tags[]
//					asa_strippedtags[] by reference
//
// Returns:		
//
//
//	Description:	Loop tags and remove brackets. Pass back in other array.
//
//
//
// Written by: Norm LeBlanc
// 		Date: 9/12/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
////////////////////////////////////////////////////////////////////////////
long	ll_TagStartPos, &
		ll_TagEndPos, &
		ll_TagCount, &
		ll_Count
		
ll_TagCount = upperbound ( asa_tags )

FOR ll_Count = 1 TO ll_TagCount

	asa_strippedtags[ll_Count] = mid ( asa_tags[ll_Count], 2, len ( asa_tags[ll_Count] ) - 2  )
	
NEXT


end subroutine

public function long of_gettags (string as_rangetext, ref string asa_tags[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTags
//
//	Access:  private
//
//	Arguments:  anv_rangetext
//					asa_tags[] by reference
//
// Returns:		long  -	number of tags
//
//
//	Description:	Loop through range argument for tags and add to tag array. 
//
//
//
// Written by: Norm LeBlanc
// 		Date: 9/12/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
string	ls_RangeText, &
			lsa_Blank[]
			
long	ll_TagStartPos, &
		ll_TagEndPos, &
		ll_TagCount
		
boolean	lb_GetTag = TRUE

ll_TagStartPos = 1 
asa_tags[] = lsa_Blank

DO WHILE lb_GetTag
	ll_TagStartPos = pos( as_RangeText, "<", ll_TagStartPos )
	IF ll_TagStartPos > 0 THEN
		ll_TagendPos = pos( as_RangeText, ">", ll_TagStartPos )
		IF ll_TagendPos > 0 THEN
			ll_TagCount ++
			asa_Tags [ ll_TagCount ] = mid ( as_RangeText, ll_TagStartPos, ( ll_TagendPos - ll_TagStartPos ) + 1 )
			ll_TagStartPos = ll_TagendPos
		END IF
	ELSE
		lb_GetTag = FALSE
	END IF
LOOP

return ll_TagCount
end function

on n_cst_template.create
TriggerEvent( this, "constructor" )
end on

on n_cst_template.destroy
TriggerEvent( this, "destructor" )
end on

