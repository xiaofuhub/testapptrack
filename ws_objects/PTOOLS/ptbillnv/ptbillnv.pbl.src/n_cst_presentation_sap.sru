$PBExportHeader$n_cst_presentation_sap.sru
forward
global type n_cst_presentation_sap from n_cst_presentation
end type
end forward

global type n_cst_presentation_sap from n_cst_presentation
end type

forward prototypes
public function integer of_setpresentation (powerobject apo_target, string as_objectname)
end prototypes

public function integer of_setpresentation (powerobject apo_target, string as_objectname);Integer		li_Return = 1
Integer		li_Count
Integer		i	
Long			ll_ProtectCount
String		ls_Protect
String		ls_Background
String		lsa_Settings[]

String	lsa_ProtectFields[] = {"RecordType" , "LineType", "LineCount", "Reserved", + &
										  "AmountCount", "LineNumber", "LineType", "PostingKey", + &
										  "GlIndicator", "TransactionType" &
										 }

Constant Long	ll_Grey = Rgb(192,192,192)
Constant Long	ll_White = Rgb(255,255,255)

as_ObjectName = Lower ( as_ObjectName )

CHOOSE CASE as_ObjectName

	CASE "field_name, field_width, field_number, line_type"
		lsa_Settings = { "Protect = 1"}
	CASE "value"
		ll_ProtectCount = UpperBound(lsa_ProtectFields)
		ls_Protect += "Protect = '0~tIF ("
		ls_Background = "Background.Color = '" + String(ll_White) + "~tIF (" 
		
		FOR i = 1 TO ll_ProtectCount
			ls_Protect += " field_name = ~~~'" + lsa_ProtectFields[i] + "~~~'"
			ls_Background += " field_name = ~~~'" + lsa_ProtectFields[i] + "~~~'"
			IF i <> ll_ProtectCount THEN
				ls_Background += " OR "
				ls_Protect += " OR "
			END IF
		NEXT
		ls_Protect +=  ", 1, 0 )'"
		ls_Background += "," + String(ll_Grey) + "," + String(ll_White) + ")'" 
		
		lsa_Settings = {ls_Protect, ls_Background}
	
END CHOOSE

IF li_Return = 1 THEN

	li_Count = UpperBound ( lsa_Settings )
	
	FOR i = 1 TO li_Count
	
		apo_Target.Dynamic Modify ( as_ObjectName + "." + lsa_Settings [i] )
	
	NEXT

END IF

Return li_Return
end function

on n_cst_presentation_sap.create
call super::create
end on

on n_cst_presentation_sap.destroy
call super::destroy
end on

