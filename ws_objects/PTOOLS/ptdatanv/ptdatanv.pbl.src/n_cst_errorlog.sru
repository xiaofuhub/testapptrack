$PBExportHeader$n_cst_errorlog.sru
forward
global type n_cst_errorlog from n_cst_base
end type
end forward

global type n_cst_errorlog from n_cst_base
end type
global n_cst_errorlog n_cst_errorlog

type variables
Private:
Integer	ii_Urgency

Long		ila_SourceIds[] //Ids used to rememdy the error

String	is_Category, &
			is_Context, &
			is_Message, &
			is_RemedyObject //Decendent of n_cst_remedy in string format
		


end variables

forward prototypes
public function integer of_setcategory (string as_category)
public function integer of_setcontext (string as_context)
public function integer of_setmessage (string as_message)
public function integer of_seturgency (integer ai_urgency)
public function string of_getcategory ()
public function string of_getcontext ()
public function string of_getmessage ()
public function integer of_geturgency ()
public function integer of_setsourceid (long al_sourceid)
public function integer of_setsourceids (long ala_sourceids[])
public function string of_getremedyobject ()
public function integer of_setremedyobject (string as_remedyobject)
public function integer of_getsourceids (ref long ala_sourceids[])
public function integer of_setlogdata (string as_category, string as_context, string as_message, integer ai_urgency, long ala_sourceids[], string as_remedyobject)
public function integer of_setlogdata (string as_category, string as_context, string as_message, integer ai_urgency)
end prototypes

public function integer of_setcategory (string as_category);is_Category = as_category

Return 1
end function

public function integer of_setcontext (string as_context);is_Context = as_Context

Return 1
end function

public function integer of_setmessage (string as_message);is_Message = as_Message

Return 1
end function

public function integer of_seturgency (integer ai_urgency);ii_Urgency = ai_Urgency

Return 1
	
end function

public function string of_getcategory ();Return is_Category
end function

public function string of_getcontext ();Return is_Context
end function

public function string of_getmessage ();Return is_Message
end function

public function integer of_geturgency ();Return ii_urgency
end function

public function integer of_setsourceid (long al_sourceid);ila_SourceIds[Upperbound(ila_Sourceids) + 1] = al_sourceId

Return 1
end function

public function integer of_setsourceids (long ala_sourceids[]);ila_SourceIds = ala_SourceIds

Return 1
end function

public function string of_getremedyobject ();Return is_RemedyObject
end function

public function integer of_setremedyobject (string as_remedyobject);is_RemedyObject = as_RemedyObject

Return 1
end function

public function integer of_getsourceids (ref long ala_sourceids[]);ala_SourceIds = ila_sourceIds 

Return 1
end function

public function integer of_setlogdata (string as_category, string as_context, string as_message, integer ai_urgency, long ala_sourceids[], string as_remedyobject);is_Category = as_Category
is_Context = as_Context
is_Message = as_Message
ii_Urgency = ai_Urgency
ila_SourceIds = ala_SourceIds
is_RemedyObject = as_remedyObject


Return 1
end function

public function integer of_setlogdata (string as_category, string as_context, string as_message, integer ai_urgency);Long		lla_SourceIds[]	
String	ls_RemedyObject

SetNull(ls_RemedyObject)

Return This.of_SetLogData(as_Category, as_Context, as_Message, ai_Urgency, lla_SourceIds, ls_RemedyObject)
end function

on n_cst_errorlog.create
call super::create
end on

on n_cst_errorlog.destroy
call super::destroy
end on

