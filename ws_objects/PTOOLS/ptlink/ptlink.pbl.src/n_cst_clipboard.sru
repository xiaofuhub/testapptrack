$PBExportHeader$n_cst_clipboard.sru
$PBExportComments$[n_base]
forward
global type n_cst_clipboard from n_base
end type
end forward

global type n_cst_clipboard from n_base autoinstantiate
end type

type variables
Public:
Constant	String  cs_Beo = "BEO"	// rdt 3-12-03
Constant	String  cs_Text = "TEXT"	// rdt 3-12-03
Constant	String  cs_Image = "IMAGE"	// rdt 3-12-03

Private:

Any  		iaa_content[]

String		is_Type		// rdt 3-12-03


end variables

forward prototypes
public function integer of_getcontents (ref string as_contents)
public function integer of_setcontents (readonly string as_Contents)
public function integer of_settype (readonly string as_type)
public function string of_gettype ()
public function integer of_setcontents (readonly any aaa_contents[], readonly string as_type)
public function integer of_setcontents (readonly any aaa_contents[])
public function integer of_getcontents (ref any aaa_contents[], ref string as_type)
end prototypes

public function integer of_getcontents (ref string as_contents);String	ls_Contents

ls_contents = Clipboard()
as_contents = ls_Contents

Return 1


end function

public function integer of_setcontents (readonly string as_Contents);String	ls_Contents

ls_Contents = Trim ( as_Contents )

IF Len ( ls_Contents ) > 0 THEN
	Clipboard ( ls_Contents )
END IF

RETURN 1
end function

public function integer of_settype (readonly string as_type);//
/***************************************************************************************
NAME			: of_SetType
ACCESS		: Public 
ARGUMENTS	: String
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: 

REVISION		: RDT 3-12-03
***************************************************************************************/

Integer	li_Return 

is_type = as_type

Return li_Return 
end function

public function string of_gettype ();//
/***************************************************************************************
NAME			: of_GetType
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: String
DESCRIPTION	: 

REVISION		: RDT 
***************************************************************************************/

Return is_type

 
end function

public function integer of_setcontents (readonly any aaa_contents[], readonly string as_type);//
/***************************************************************************************
NAME			: of_SetContents
ACCESS		: Public 
ARGUMENTS	: Any
				: Type (constants) 
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Loads arguments into instance variables

REVISION		: RDT 
***************************************************************************************/

Integer	li_Return = 1  , &
			li_Count		   , &
			li_Upper

Any		la_blank[]


li_Upper = Upperbound( aaa_contents[] )

If li_Upper > 0 Then 

	iaa_content[]  = la_Blank[]										// clear instance array 
	iaa_content[]  = aaa_contents[]
	is_type 			= as_type
	
Else

	li_Return = -1

End If

Return li_Return 
end function

public function integer of_setcontents (readonly any aaa_contents[]);Any		laa_Contents[]
String	ls_Working
Int		i
Int		li_UpperBound

laa_Contents = aaa_Contents[]

li_UpperBound = UpperBound ( laa_Contents )

FOR i = 1 TO li_UpperBound 
	ls_Working += Trim ( String ( laa_Contents[i] ) )
	IF i <> li_UpperBound THEN
		ls_Working += "~r~n"	//Changed delimiter from " " to "~r~n" 2/18/05 BKW  
									//Function was only called in one place (MobileComm clipboard) at the time, and this was preferred.
	END IF
NEXT 

THIS.of_SetContents ( ls_Working )

RETURN 1

end function

public function integer of_getcontents (ref any aaa_contents[], ref string as_type);
	
aaa_contents[] = iaa_content[]
	

Return 1

end function

on n_cst_clipboard.create
call super::create
end on

on n_cst_clipboard.destroy
call super::destroy
end on

