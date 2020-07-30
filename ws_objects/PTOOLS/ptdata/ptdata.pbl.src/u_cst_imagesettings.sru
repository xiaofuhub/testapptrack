$PBExportHeader$u_cst_imagesettings.sru
forward
global type u_cst_imagesettings from u_base
end type
type dw_imagesettings from u_dw_companyimages within u_cst_imagesettings
end type
type st_1 from statictext within u_cst_imagesettings
end type
type cbx_warning from checkbox within u_cst_imagesettings
end type
type cbx_printing from checkbox within u_cst_imagesettings
end type
type st_3 from statictext within u_cst_imagesettings
end type
type cbx_required from checkbox within u_cst_imagesettings
end type
end forward

global type u_cst_imagesettings from u_base
integer width = 2373
integer height = 1152
long backcolor = 12632256
event ue_printtypeschanged ( )
event ue_warningtypeschanged ( )
event ue_requiredtypeschanged ( )
event type integer ue_setoverrideprinttypes ( boolean ab_value )
event type integer ue_setoverridewarningtypes ( boolean ab_value )
event type integer ue_setoverriderequiredtypes ( boolean ab_value )
dw_imagesettings dw_imagesettings
st_1 st_1
cbx_warning cbx_warning
cbx_printing cbx_printing
st_3 st_3
cbx_required cbx_required
end type
global u_cst_imagesettings u_cst_imagesettings

type variables
boolean	ib_OverrideRequired
boolean	ib_OverrideWarning
boolean	ib_OverridePrinting

Private:
Boolean	ib_Enabled
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
public function integer of_resetupdate ()
end prototypes

public function integer of_setoverriderequired (boolean ab_value);n_cst_Settings	lnv_Settings
String	lsa_Types[] 
ib_OverrideRequired = ab_Value

THIS.of_ClearRequired ( ) 
IF ab_Value = TRUE THEN
	cbx_required.Checked = TRUE
	dw_imagesettings.object.required.protect = 0
ELSE
	cbx_required.Checked = FALSE
	dw_imagesettings.object.required.protect = 1
	lnv_Settings.of_GetRequiredImageTypes ( lsa_Types )
	THIS.of_SetRequiredTypes ( lsa_Types )
	
END IF

THIS.Event ue_SetOverrideRequiredTypes ( ab_value )
THIS.of_setenabled( ib_enabled )
RETURN 1
end function

public function integer of_setoverridewarning (boolean ab_value);n_cst_Settings	lnv_Settings
String	lsa_Types[] 
ib_OverrideWarning = ab_Value
THIS.of_ClearWarning ( ) 
IF ab_Value = TRUE THEN
	cbx_warning.Checked = TRUE
	dw_imagesettings.object.warning.protect = 0
ELSE
	cbx_warning.Checked = FALSE
	dw_imagesettings.object.warning.protect = 1
	lnv_Settings.of_GetWarningImageTypes ( lsa_Types )
	THIS.of_SetWarningTypes ( lsa_Types )
END IF

THIS.Event ue_SetOverrideWarningTypes ( ab_Value )
THIS.of_setenabled( ib_enabled )
RETURN 1
end function

public function integer of_setoverrideprinting (boolean ab_value);n_cst_Settings	lnv_Settings
String	lsa_Types[] 
ib_OverridePrinting = ab_Value
THIS.of_ClearPrinting ( )


IF ab_Value = TRUE THEN
	cbx_printing.Checked = TRUE
	dw_imagesettings.object.printwithbills.protect = 0	
ELSE
	cbx_printing.Checked = FALSE
	dw_imagesettings.object.printwithbills.protect = 1
	lnv_Settings.of_GetPrintingImageTypes ( lsa_Types )
	THIS.of_SetPrintingTypes ( lsa_Types )
	
END IF

THIS.Event ue_SetOverridePrintTypes ( ab_value )

THIS.of_setenabled( ib_enabled )

RETURN 1
end function

public function integer of_setrequiredtypes (string asa_types[]);Long		ll_RowCount
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

public function integer of_setwarningtypes (string asa_types[]);Long		ll_RowCount
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

public function integer of_clearrequired ();Long	ll_RowCount
Long	i

ll_RowCount = dw_imagesettings.RowCount ( )

FOR i = 1 TO ll_RowCount 
	dw_imagesettings.object.required  [ i ] = 0
NEXT
	
RETURN 1
end function

public function integer of_clearwarning ();Long	ll_RowCount
Long	i

ll_RowCount = dw_imagesettings.RowCount ( )

FOR i = 1 TO ll_RowCount 
	dw_imagesettings.object.warning [ i ] = 0
NEXT
	
RETURN 1
end function

public function integer of_setenabled (boolean ab_value);cbx_printing.enabled = ab_Value
cbx_required.enabled = ab_Value
cbx_warning.enabled = ab_Value
//dw_imagesettings.enabled = ab_Value

ib_enabled = ab_value

Long	ll_ColCount
Long	i
Int	li_Value
IF ab_value THEN
	li_Value = 0
ELSE
	li_Value = 1 
END IF

ll_ColCount = Long ( dw_imagesettings.Object.DataWindow.Column.Count )


String	ls_ColName
FOR i = 1 TO ll_ColCount
	
	ls_ColName = dw_imagesettings.Describe( "#" + String ( i ) +".name" )
	
	dw_imagesettings.Modify( ls_ColName +".protect=" + String ( li_Value ) )
NEXT

//dw_imagesettings.Modify( "printwithbills.protect=" + String ( li_Value ) )
//dw_imagesettings.Modify( "warning.protect=" + String ( li_Value ) )
//dw_imagesettings.Modify( "required.protect=" + String ( li_Value ) )

RETURN 1
end function

public function integer of_resetupdate ();Return dw_imagesettings.ResetUpdate()


//Long	ll_RowCount
//Long	i
//
//ll_RowCount = dw_imagesettings.RowCount()
//
//FOR i = 1 TO ll_RowCount
//	MessageBox(dw_imagesettings.GetItemStatus (ll_RowCount, 0, PRIMARY!)
//	dw_imagesettings.SetItemStatus (ll_RowCount, 0, PRIMARY!, NotModified! ) 
//NEXT
//
//return 1


end function

on u_cst_imagesettings.create
int iCurrent
call super::create
this.dw_imagesettings=create dw_imagesettings
this.st_1=create st_1
this.cbx_warning=create cbx_warning
this.cbx_printing=create cbx_printing
this.st_3=create st_3
this.cbx_required=create cbx_required
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imagesettings
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cbx_warning
this.Control[iCurrent+4]=this.cbx_printing
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.cbx_required
end on

on u_cst_imagesettings.destroy
call super::destroy
destroy(this.dw_imagesettings)
destroy(this.st_1)
destroy(this.cbx_warning)
destroy(this.cbx_printing)
destroy(this.st_3)
destroy(this.cbx_required)
end on

type dw_imagesettings from u_dw_companyimages within u_cst_imagesettings
integer x = 55
integer y = 128
integer width = 2286
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

type st_1 from statictext within u_cst_imagesettings
integer x = 434
integer y = 28
integer width = 1307
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Indicate the image settings for the billing process"
boolean focusrectangle = false
end type

type cbx_warning from checkbox within u_cst_imagesettings
integer x = 224
integer y = 292
integer width = 64
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean lefttext = true
end type

event clicked;PARENT.of_SetOverrideWarning ( THIS.Checked )
end event

type cbx_printing from checkbox within u_cst_imagesettings
integer x = 343
integer y = 292
integer width = 64
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean lefttext = true
end type

event clicked;PARENT.of_SetOverridePrinting ( THIS.Checked )
end event

type st_3 from statictext within u_cst_imagesettings
integer x = 498
integer y = 292
integer width = 704
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "override system settings"
boolean focusrectangle = false
end type

type cbx_required from checkbox within u_cst_imagesettings
integer x = 105
integer y = 292
integer width = 64
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean lefttext = true
end type

event clicked;PARENT.of_SetOverrideRequired ( THIS.Checked )
end event

