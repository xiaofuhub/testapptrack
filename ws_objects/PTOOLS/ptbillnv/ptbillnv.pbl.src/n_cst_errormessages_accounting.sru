$PBExportHeader$n_cst_errormessages_accounting.sru
forward
global type n_cst_errormessages_accounting from n_base
end type
end forward

global type n_cst_errormessages_accounting from n_base
end type
global n_cst_errormessages_accounting n_cst_errormessages_accounting

type variables
Protected:
	String 	isa_errorMessages[]
end variables

forward prototypes
public function integer of_logerrormessage (string as_message)
public function integer of_reset ()
public function integer of_getlastmessage (ref string as_message)
public function integer of_getmessages (ref string asa_messages[])
end prototypes

public function integer of_logerrormessage (string as_message);Int	li_return = 1
Long	ll_index

ll_index = upperBound( isa_errorMessages )
ll_index ++
isa_errorMessages[ll_index] = as_message


RETURN li_return




end function

public function integer of_reset ();String	lsa_blank[]

isa_errormessages = lsa_blank

RETURN 1

end function

public function integer of_getlastmessage (ref string as_message);/*
	Returns the last logged error message by reference.
	
	Function returns 1 if there was a message -1 if there wasn't
	
	Created By Dan 2-19-07
*/

Int	li_return = 1
Long	ll_max

ll_max = upperBound( isa_errormessages )

IF ll_max = 0 THEN
	li_Return = -1
ELSE
	as_message = isa_errorMessages[ll_max]
END IF


RETURN li_Return
end function

public function integer of_getmessages (ref string asa_messages[]);/*
	Returns an array of error messages by reference.  The integer return value is the count of the messages.
	
	From index 1 to N, the newest message is recorded at the end.
	
	Created By Dan 2-19-07
*/

Int	li_return


li_return = upperBound( isa_errormessages )

asa_messages = isa_errorMessages

RETURN li_return
end function

on n_cst_errormessages_accounting.create
call super::create
end on

on n_cst_errormessages_accounting.destroy
call super::destroy
end on

