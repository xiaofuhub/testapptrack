$PBExportHeader$n_cst_notemanager.sru
forward
global type n_cst_notemanager from n_base
end type
end forward

global type n_cst_notemanager from n_base
end type
global n_cst_notemanager n_cst_notemanager

type variables

CONSTANT String	cs_Delimiter = "/^\"

Private:
Boolean		ib_HasContext
pt_n_cst_beo	inv_Context
string		is_Attribute

end variables

forward prototypes
public function integer of_addnote (string as_note)
public function boolean of_hascontext ()
private function string of_getnotes ()
private function integer of_setnote (string as_note)
public function integer of_setcontext (pt_n_cst_beo anv_context, string as_attribute)
public function integer of_formatnotes (string as_rawnote, ref string as_formattednotes)
public function boolean of_havenotes ()
end prototypes

public function integer of_addnote (string as_note);Int		li_Return
String	ls_ExistingNotes
String	ls_NewNote
String	ls_User
Int		li_DelimiterLen
Date		ld_Today
Time		lt_Now

li_Return = -1

ld_Today = Date ( DateTime ( Today ( ) ) )
lt_Now = Now ( )
ls_User = gnv_app.of_getuserid ( )

li_DelimiterLen = Len ( THIS.cs_Delimiter )

IF THIS.of_HasContext ( ) THEN
	ls_ExistingNotes = Trim ( THIS.of_GetNotes ( ) )
	IF IsNull ( ls_ExistingNotes ) THEN
		ls_NewNote = THIS.cs_Delimiter 
	ELSE
		ls_NewNote = ls_ExistingNotes	
		IF RIGHT ( ls_NewNote , li_DelimiterLen ) <> THIS.cs_Delimiter THEN
			ls_NewNote += THIS.cs_Delimiter 
		END IF
	END IF
	
	ls_NewNote += "~r~n" +ls_User + ": " 
	ls_NewNote += String ( ld_Today )
	ls_NewNote += " " + String ( lt_Now , "HH:MM" ) 
	ls_NewNote += " - "
	ls_NewNote += as_Note 
	ls_NewNote += THIS.cs_Delimiter 
	
	IF THIS.of_SetNote ( ls_NewNote ) = 1 THEN
		li_Return = 1
	END IF
	
END IF


RETURN li_Return
end function

public function boolean of_hascontext ();RETURN ib_HasContext AND IsValid ( inv_context )
end function

private function string of_getnotes ();String	ls_Return
Any		la_NOte

IF THIS.of_HasContext ( ) THEN
	IF inv_Context.Dynamic TriggerEvent ( "ue_GetValueAny" ) = 1 THEN		
		IF inv_Context.Dynamic Event ue_GetValueAny ( is_attribute ,  la_Note )	= 1 THEN
			ls_Return = String ( la_Note ) 			
		END IF	
	END IF
END IF	

RETURN ls_Return
end function

private function integer of_setnote (string as_note);Int	li_Return = -1

IF THIS.of_HasContext ( ) THEN
	IF inv_Context.Dynamic TriggerEvent ( "ue_SetValueAny" ) = 1 THEN		
		IF inv_Context.Dynamic Event ue_SetValueAny ( is_attribute , as_note )	= 1 THEN
			li_Return = 1
		END IF	
	END IF
END IF	

RETURN li_Return
end function

public function integer of_setcontext (pt_n_cst_beo anv_context, string as_attribute);Int	li_Return = -1
IF IsValid ( anv_Context ) AND Len ( as_Attribute ) > 0 THEN
	inv_Context = anv_Context
	is_attribute = as_Attribute
	ib_HasContext = TRUE
	li_Return = 1
END IF

RETURN	li_Return
end function

public function integer of_formatnotes (string as_rawnote, ref string as_formattednotes);String	ls_Formatted
String	ls_Raw
Int		li_DelimiterLen
n_cst_string	lnv_String	

ls_Raw = as_RawNote
// pull out delimiter from the start so we don't add a new line at the begining
li_DelimiterLen = Len ( THIS.cs_Delimiter )
IF ( LEFT ( ls_Raw , li_DelimiterLen ) ) = THIS.cs_Delimiter THEN
	ls_Raw = Mid ( ls_Raw, li_DelimiterLen + 1 )
END IF
// do the same at the end
IF ( RIGHT ( ls_Raw , li_DelimiterLen ) ) = THIS.cs_Delimiter THEN
	ls_Raw = Mid ( ls_Raw,  1 , Len ( ls_Raw ) - li_DelimiterLen )
END IF

	
ls_Formatted = lnv_String.of_substitute ( ls_Raw, THIS.cs_Delimiter, "~r~n" )

as_FormattedNotes = ls_Formatted

RETURN 1


end function

public function boolean of_havenotes ();String	ls_Notes
ls_Notes = THIS.of_GetNotes ( )
RETURN (NOT ISNull (ls_Notes)) OR  (LEN ( ls_Notes  ) > 0 )
end function

on n_cst_notemanager.create
TriggerEvent( this, "constructor" )
end on

on n_cst_notemanager.destroy
TriggerEvent( this, "destructor" )
end on

