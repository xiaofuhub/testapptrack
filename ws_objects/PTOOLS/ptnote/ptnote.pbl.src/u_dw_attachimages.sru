$PBExportHeader$u_dw_attachimages.sru
forward
global type u_dw_attachimages from u_dw
end type
end forward

global type u_dw_attachimages from u_dw
integer width = 905
integer height = 300
string dataobject = "d_attachimages"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type
global u_dw_attachimages u_dw_attachimages

type variables
Constant String	cs_Color_Disabled = "78682240"
end variables

forward prototypes
public function string of_getattachtypes ()
public function integer of_setattachtypes (string asa_Types[])
public function integer of_setenable (boolean ab_enable)
end prototypes

public function string of_getattachtypes ();Long		ll_RowCount
Long		i
String	lsa_Types[]
String	ls_Return

n_cst_String lnv_String
ll_RowCount = THIS.RowCount ( )

FOR i = 1 TO ll_RowCount 
	
	IF THIS.Object.attach[i] = 1 THEN
		lsa_Types[ UpperBound (lsa_Types) + 1 ] = THIS.Object.Type [ i ]
	END IF
	
NEXT

lnv_String.of_ArraytoString ( lsa_Types , ";" ,ls_Return)

RETURN ls_Return 
end function

public function integer of_setattachtypes (string asa_Types[]);Long		ll_RowCount
Long		i
Long		ll_Count
Long		ll_FindRow
Int		li_SetValue
String	ls_Currenttype


li_SetValue = 1

ll_RowCount = THIS.RowCount ( )
ll_Count = UpperBound ( asa_Types )

IF ll_RowCount > 0 THEN
	FOR i = 1 To ll_Count
		ll_FindRow = 0
		ls_CurrentType = asa_Types [ i ]
		
		DO  
			ll_FindRow = THIS.Find ( "type = '" + ls_CurrentType + "'" , ll_FindRow + 1, 999 )
			IF ll_FindRow > 0 THEN
				THIS.SetItem ( ll_FindRow ,  "attach", li_SetValue )
			END IF
		LOOP WHILE ll_FindRow > 0 AND ll_FindRow < ll_RowCount 
		
	NEXT
END IF

RETURN 1

end function

public function integer of_setenable (boolean ab_enable);String	lsa_Objects[]
String	ls_Type
			
Long	ll_ObjectCount, &
			ll_Index
			
n_cst_dws	lnv_Dws

n_cst_Privileges					lnv_Privileges

IF NOT lnv_Privileges.of_HasEntryRights ( ) THEN
	This.of_SetBase ( TRUE )
	
	ll_ObjectCount = This.inv_Base.of_GetObjects ( lsa_Objects )
	
	FOR ll_Index = 1 TO ll_ObjectCount
	
		ls_Type =  This.Describe ( lsa_Objects [ ll_Index ] + ".type" )
		
		IF ls_Type = "column" THEN
			IF ab_Enable THEN
				This.Modify(lsa_Objects[ll_Index] + ".Protect = 0")
				This.Modify (lsa_Objects [ ll_Index ] + ".Background.Color = 00000000")				
			ELSE
				This.Modify(lsa_Objects[ll_Index] + ".Protect = 1")
				This.Modify (lsa_Objects [ ll_Index ] + ".Background.Color = " + cs_Color_Disabled )	
				//This.Enabled = FALSE	
		END IF
		END iF		

	NEXT

END IF

Return 1
end function

event constructor;THIS.SetTransObject	( SQLCA )
THIS.Retrieve ( ) 
ib_rmbmenu = FALSE
end event

on u_dw_attachimages.create
end on

on u_dw_attachimages.destroy
end on

