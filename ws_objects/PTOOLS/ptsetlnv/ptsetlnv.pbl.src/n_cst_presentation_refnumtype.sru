$PBExportHeader$n_cst_presentation_refnumtype.sru
forward
global type n_cst_presentation_refnumtype from n_cst_presentation
end type
end forward

global type n_cst_presentation_refnumtype from n_cst_presentation
end type

forward prototypes
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
end prototypes

public function integer of_setpresentation (powerobject apo_target, string as_objectname);String	lsa_Settings[]
	
		
Integer	li_Return
Int		li_Count
Int		li_Index

li_Return = 1
as_ObjectName = Lower ( as_ObjectName )


CHOOSE CASE as_ObjectName

 
// ***RefnumType Table***

CASE  "refnumtype_id"
	lsa_Settings = { "Protect = 1", "Background.Color = 12648447" }

END CHOOSE

IF li_Return = 1 THEN

	li_Count = UpperBound ( lsa_Settings )
	
	FOR li_Index = 1 TO li_Count
	
		apo_Target.Dynamic Modify ( as_ObjectName + "." + lsa_Settings [ li_Index ] )
	
	NEXT

END IF
RETURN li_Return
end function

on n_cst_presentation_refnumtype.create
TriggerEvent( this, "constructor" )
end on

on n_cst_presentation_refnumtype.destroy
TriggerEvent( this, "destructor" )
end on

