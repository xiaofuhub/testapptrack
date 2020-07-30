$PBExportHeader$n_cst_errorremedy_edi.sru
forward
global type n_cst_errorremedy_edi from n_cst_errorremedy
end type
end forward

global type n_cst_errorremedy_edi from n_cst_errorremedy
end type
global n_cst_errorremedy_edi n_cst_errorremedy_edi

forward prototypes
public function integer of_remedy ()
public function string of_getfilelinkstring (string as_file)
end prototypes

public function integer of_remedy ();//By Default, the edi remedy will look for a file in the message and then try to open the file using
//notepad. The file path must be the last part of the message and start with FILE:: to work.

Integer	li_Return
Integer	li_Continue
String	ls_message
String	ls_file
Int	 li_Pos

ls_message = inv_errorLog.of_getmessage( )

//after the word 'File::' there is a file path in the message
li_pos = pos( upper(ls_message), "FILE::" )
IF li_pos > 0 THEN 
	//gets the file path
	ls_file = RIGHT( ls_message, len(ls_message) - (li_pos + 5) )
	IF len(ls_file) > 0 THEN
		IF FILEEXISTS( ls_File ) THEN
			IF RUN("Notepad "+ ls_file) = 1 THEN
			ELSE
				Messagebox("EDI REMEDY", "Couldn't open "+ ls_file+ " in notepad.")
			END IF
		ELSE
			Messagebox("EDI REMEDY", "Couldn't open "+ ls_file+ " in notepad. The file doesn't exist.")
		END IF
	END IF
END IF
Return li_Return
end function

public function string of_getfilelinkstring (string as_file);//DEK 5-23-07 the idea behind this is to return a string that the remedy object
//will look for at the end of a message so that it can try opening the file in notepad.

return "~r~nFile::"+as_file
end function

on n_cst_errorremedy_edi.create
call super::create
end on

on n_cst_errorremedy_edi.destroy
call super::destroy
end on

event constructor;call super::constructor;is_InitialMessage = "Remedy Message Example:~r~nEDI transaction has failed.~r~nYou must resend the following shipment ids." + &
					 	  "~r~nGo to EDI window?"
end event

