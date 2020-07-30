$PBExportHeader$u_cst_syssettings_imagesettings.sru
forward
global type u_cst_syssettings_imagesettings from u_cst_syssettings
end type
type dw_imagesettings from u_dw_companyimages within u_cst_syssettings_imagesettings
end type
type st_1 from statictext within u_cst_syssettings_imagesettings
end type
end forward

global type u_cst_syssettings_imagesettings from u_cst_syssettings
integer width = 2373
integer height = 1152
long backcolor = 67108864
event ue_printtypeschanged ( )
event ue_warningtypeschanged ( )
event ue_requiredtypeschanged ( )
event type integer ue_setoverrideprinttypes ( boolean ab_value )
event type integer ue_setoverridewarningtypes ( boolean ab_value )
event type integer ue_setoverriderequiredtypes ( boolean ab_value )
event type integer ue_setcheckboxes ( string asa_imagetypes[],  string as_imagesetting )
dw_imagesettings dw_imagesettings
st_1 st_1
end type
global u_cst_syssettings_imagesettings u_cst_syssettings_imagesettings

type variables
boolean	ib_OverrideRequired
boolean	ib_OverrideWarning
boolean	ib_OverridePrinting

String is_RequiredType
String is_PrintingType
String is_WarningType

String isa_imagetypes[]

n_cst_syssettings inv_syssetting_required 
n_cst_syssettings inv_syssetting_printing
n_cst_syssettings inv_syssetting_warning

end variables

forward prototypes
public function integer of_setoverriderequired (boolean ab_value)
public function integer of_setoverridewarning (boolean ab_value)
public function integer of_setoverrideprinting (boolean ab_value)
public function integer of_setrequiredtypes (string asa_types[])
public function integer of_setwarningtypes (string asa_types[])
public function integer of_setprintingtypes (string asa_types[])
public function string of_getprinttypes ()
public function string of_getrequiredtypes ()
public function string of_getwarningtypes ()
public function integer of_populatesettings ()
public function integer of_clearprinting ()
public function integer of_clearrequired ()
public function integer of_clearwarning ()
public function integer of_setenabled (boolean ab_value)
end prototypes

event ue_printtypeschanged();String ls_PrintingType

ls_PrintingType = dw_imagesettings.of_Getprinttypes( )

is_printingtype = ls_PrintingType

inv_syssetting = inv_syssetting_Printing	
inv_syssetting.of_savevalue( is_printingtype )
inv_syssetting_Printing = inv_syssetting

end event

event ue_warningtypeschanged();String ls_WarningType

ls_WarningType = dw_imagesettings.of_GetWarningtypes( )

is_WarningType = ls_WarningType

inv_syssetting = inv_syssetting_warning	
inv_syssetting.of_savevalue( is_WarningType )
inv_syssetting_warning = inv_syssetting


end event

event ue_requiredtypeschanged();String ls_RequiredType

ls_RequiredType = dw_imagesettings.of_Getrequiredtypes( )

is_requiredtype = ls_RequiredType

inv_syssetting = inv_syssetting_Required
inv_syssetting.of_savevalue( is_requiredtype )
inv_syssetting_Required = inv_syssetting

end event

event type integer ue_setcheckboxes(string asa_imagetypes[], string as_imagesetting);Int li_ReturnValue = 1
Int li_Ctr
Int li_FoundRow
Int li_UpperBound

Long ll_RowCount 

String ls_ImageSetting
String ls_SearchStr
String ls_Image
String lsa_ImageTypes[]

lsa_ImageTypes 	= asa_ImageTypes
ls_ImageSetting 	= UPPER(as_ImageSetting)

li_UpperBound 	= UpperBound(lsa_ImageTypes)
ll_RowCount 	= dw_imagesettings.RowCount()  

FOR li_Ctr = 1 TO li_UpperBound
	ls_Image = Upper(lsa_ImageTypes[li_Ctr])
	ls_SearchStr = "Type = '" + ls_Image + "'"
	li_FoundRow = dw_imagesettings.Find(ls_SearchStr,1,ll_RowCount)

	IF li_FoundRow > 0 THEN 
		CHOOSE CASE ls_ImageSetting	
			CASE "REQUIRED"					
				dw_imagesettings.Object.Required[li_FoundRow] = 1
			CASE "PRINTING"
				dw_imagesettings.Object.PrintWithBills[li_FoundRow] = 1
			CASE "WARNING"
				dw_imagesettings.Object.Warning[li_FoundRow] = 1
		END CHOOSE		
	END IF
NEXT 

Return li_ReturnValue

end event

public function integer of_setoverriderequired (boolean ab_value);
n_cst_Settings	lnv_Settings
String	lsa_Types[] 
ib_OverrideRequired = ab_Value

THIS.of_ClearRequired ( ) 
IF ab_Value = TRUE THEN
	dw_imagesettings.object.required.protect = 0
ELSE
	dw_imagesettings.object.required.protect = 1
	lnv_Settings.of_GetRequiredImageTypes ( lsa_Types )
	THIS.of_SetRequiredTypes ( lsa_Types )
	
END IF

THIS.Event ue_SetOverrideRequiredTypes ( ab_value )

RETURN 1
end function

public function integer of_setoverridewarning (boolean ab_value);
n_cst_Settings	lnv_Settings
String	lsa_Types[] 
ib_OverrideWarning = ab_Value
THIS.of_ClearWarning ( ) 
IF ab_Value = TRUE THEN
	dw_imagesettings.object.warning.protect = 0
ELSE
	dw_imagesettings.object.warning.protect = 1
	lnv_Settings.of_GetWarningImageTypes ( lsa_Types )
	THIS.of_SetWarningTypes ( lsa_Types )
END IF

THIS.Event ue_SetOverrideWarningTypes ( ab_Value )

RETURN 1
end function

public function integer of_setoverrideprinting (boolean ab_value);
n_cst_Settings	lnv_Settings
String	lsa_Types[] 
ib_OverridePrinting = ab_Value
THIS.of_ClearPrinting ( )


IF ab_Value = TRUE THEN
	dw_imagesettings.object.printwithbills.protect = 0	
ELSE
	dw_imagesettings.object.printwithbills.protect = 1
	lnv_Settings.of_GetPrintingImageTypes ( lsa_Types )
	THIS.of_SetPrintingTypes ( lsa_Types )
	
END IF

THIS.Event ue_SetOverridePrintTypes ( ab_value ) 


RETURN 1
end function

public function integer of_setrequiredtypes (string asa_types[]);
Long		ll_RowCount
Long		i
Long		ll_Count
Long		ll_FindRow
Int		li_SetValue
String	ls_Currenttype

IF ib_OverrideRequired THEN
	li_SetValue = 1
ELSE
	li_SetValue = -1
END IF

ll_RowCount = dw_imagesettings.RowCount ( )
ll_Count = UpperBound ( asa_Types )
IF ll_RowCount > 0 THEN
	FOR i = 1 To ll_Count
		ll_FindRow = 0
		ls_CurrentType = asa_Types [ i ]
		
		DO 
			ll_FindRow = dw_imagesettings.Find ( "type = '" + ls_CurrentType + "'" , ll_FindRow + 1, 999 )
			IF ll_FindRow > 0 THEN
				dw_imagesettings.SetItem ( ll_FindRow ,  "required", li_SetValue )
			END IF
		LOOP While ll_FindRow > 0 AND ll_FindRow < ll_RowCount
	NEXT
END IF

RETURN 1

//RETURN dw_imagesettings.of_SetRequiredTypes ( asa_types )

end function

public function integer of_setwarningtypes (string asa_types[]);
Long		ll_RowCount
Long		i
Long		ll_Count
Long		ll_FindRow
Int		li_SetValue
String	ls_Currenttype

IF ib_OverrideWarning THEN
	li_SetValue = 1
ELSE
	li_SetValue = -1
END IF

ll_RowCount = dw_imagesettings.RowCount ( )
ll_Count = UpperBound ( asa_Types )
IF ll_RowCount > 0 THEN
	FOR i = 1 To ll_Count
		ll_FindRow = 0
		ls_CurrentType = asa_Types [ i ]
		
		DO 
			ll_FindRow = dw_imagesettings.Find ( "type = '" + ls_CurrentType + "'" , ll_FindRow + 1, 999 )
			IF ll_FindRow > 0 THEN
				dw_imagesettings.SetItem ( ll_FindRow ,  "warning", li_SetValue )
			END IF
		LOOP While ll_FindRow > 0 AND ll_FindRow < ll_RowCount
	NEXT
END IF

RETURN 1

//return dw_imagesettings.of_SetWarningTypes ( asa_types )
end function

public function integer of_setprintingtypes (string asa_types[]);Long		ll_RowCount

Long		i
Long		ll_Count
Long		ll_FindRow
Int		li_SetValue
String	ls_Currenttype

IF ib_OverridePrinting THEN
	li_SetValue = 1
ELSE
	li_SetValue = -1
END IF

ll_RowCount = dw_imagesettings.RowCount ( )
ll_Count = UpperBound ( asa_Types )

IF ll_RowCount > 0 THEN
	FOR i = 1 To ll_Count
		ll_FindRow = 0
		ls_CurrentType = asa_Types [ i ]
		
		DO  
			ll_FindRow = dw_imagesettings.Find ( "type = '" + ls_CurrentType + "'" , ll_FindRow + 1, 999 )
			IF ll_FindRow > 0 THEN
				dw_imagesettings.SetItem ( ll_FindRow ,  "printwithbills", li_SetValue )
			END IF
		LOOP WHILE ll_FindRow > 0 AND ll_FindRow < ll_RowCount 
		
	NEXT
END IF

RETURN 1


//RETURN dw_imagesettings.of_SetPrintTypes ( asa_types )

end function

public function string of_getprinttypes ();// this method is used to get the string to write back to the db, therefore if the ss are not
// overridden the string will be null,

String	ls_Return

if ib_overridePrinting THEN
	ls_Return = dw_imagesettings.of_GetPrinttypes ( )
ELSE
	SetNull ( ls_Return )
END IF

RETURN ls_Return



end function

public function string of_getrequiredtypes ();// this method is used to get the string to write back to the db, therefore if the ss are not
// overridden the string will be null,

String	ls_Return

if ib_overrideRequired THEN
	ls_Return = dw_imagesettings.of_GetRequiredtypes ( )
ELSE
	SetNull ( ls_Return )
END IF

RETURN ls_Return
end function

public function string of_getwarningtypes ();// this method is used to get the string to write back to the db, therefore if the ss are not
// overridden the string will be null,

String	ls_Return

if ib_overrideWarning THEN
	ls_Return = dw_imagesettings.of_GetWarningtypes ( )
ELSE
	SetNull ( ls_Return )
END IF

RETURN ls_Return
end function

public function integer of_populatesettings ();return -1
end function

public function integer of_clearprinting ();Long	ll_RowCount
Long	i

ll_RowCount = dw_imagesettings.RowCount ( )

FOR i = 1 TO ll_RowCount 
	dw_imagesettings.object.printWithBills [ i ] = 0
NEXT

RETURN 1
end function

public function integer of_clearrequired ();
Long	ll_RowCount
Long	i

ll_RowCount = dw_imagesettings.RowCount ( )

FOR i = 1 TO ll_RowCount 
	dw_imagesettings.object.required  [ i ] = 0
NEXT

RETURN 1
end function

public function integer of_clearwarning ();
Long	ll_RowCount
Long	i

ll_RowCount = dw_imagesettings.RowCount ( )

FOR i = 1 TO ll_RowCount 
	dw_imagesettings.object.warning [ i ] = 0
NEXT

RETURN 1
end function

public function integer of_setenabled (boolean ab_value);dw_imagesettings.enabled = ab_Value


RETURN 1 
end function

on u_cst_syssettings_imagesettings.create
int iCurrent
call super::create
this.dw_imagesettings=create dw_imagesettings
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imagesettings
this.Control[iCurrent+2]=this.st_1
end on

on u_cst_syssettings_imagesettings.destroy
call super::destroy
destroy(this.dw_imagesettings)
destroy(this.st_1)
end on

event ue_setproperty;call super::ue_setproperty;IF IsValid(inv_sysSetting) THEN 
END IF	

Return AncestorReturnValue
end event

event ue_setvalue;call super::ue_setvalue;Integer li_Return = 1 
String ls_value

n_cst_String lnv_String

IF IsValid(inv_syssetting) THEN
	ls_value = inv_syssetting.of_getvalue( )
	li_Return = 1 
ELSE
	li_Return = -1 	
END IF

IF li_Return = 1 THEN
	isa_imagetypes[] = {''}
	IF lnv_String.of_Parsetoarray( ls_Value,';',isa_imagetypes[]) <= 0 THEN
		li_Return = -1
	END IF
END IF

Return li_Return




end event

event constructor;call super::constructor;// Making the column "Topic" Invisible 
dw_imagesettings.Modify("Topic.visible = FALSE")

// Changing the X co-ordinate
dw_imagesettings.Modify("Category.X = 1220")

// Changing DataWindow width
dw_imagesettings.width = 1755

// Making the 3rd State("Other") for required column same as 1st state("On")
dw_imagesettings.Modify("required.CheckBox.On = '1'")
dw_imagesettings.Modify("required.CheckBox.Other = '1'")
dw_imagesettings.Modify("required.CheckBox.Off = '0'")


// Making the 3rd State("Other") for warning column same as 1st state("On")
dw_imagesettings.Modify("warning.CheckBox.On = '1'")
dw_imagesettings.Modify("warning.CheckBox.Other = '1'")
dw_imagesettings.Modify("warning.CheckBox.Off = '0'")


// Making the 3rd State("Other") for printwithbills column same as 1st state("On")
dw_imagesettings.Modify("printwithbills.CheckBox.On = '1'")
dw_imagesettings.Modify("printwithbills.CheckBox.Other = '1'")
dw_imagesettings.Modify("printwithbills.CheckBox.Off = '0'")



end event

type dw_imagesettings from u_dw_companyimages within u_cst_syssettings_imagesettings
integer x = 55
integer y = 128
integer width = 2217
integer height = 972
integer taborder = 10
boolean bringtotop = true
end type

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
		
	CASE "required"
		
		IF ib_OverrideRequired AND data = "-1" THEN
			THIS.Post SetItem ( row , String ( dwo.Name ) , 1 )
		END IF
		
		Parent.Event Post ue_requiredTypesChanged ( ) 
		
	CASE "warning"
		
		IF ib_OverrideWarning AND data = "-1" THEN
			THIS.Post SetItem ( row , String ( dwo.Name ) , 1 )
		END IF
		
		Parent.Event Post ue_WarningTypesChanged ( )
		
	CASE "printwithbills"
		
		IF ib_OverridePrinting AND data = "-1" THEN
			THIS.Post SetItem ( row , String ( dwo.Name ) , 1 )
		END IF
		Parent.Event Post ue_PrintTypesChanged ( )
		
END CHOOSE
end event

type st_1 from statictext within u_cst_syssettings_imagesettings
integer x = 434
integer y = 28
integer width = 1307
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Indicate the image settings for the billing process"
boolean focusrectangle = false
end type

