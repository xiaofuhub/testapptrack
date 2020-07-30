$PBExportHeader$u_dw_companyimages.sru
forward
global type u_dw_companyimages from u_dw
end type
end forward

global type u_dw_companyimages from u_dw
integer width = 1339
integer height = 776
string dataobject = "d_companyimages"
boolean border = false
borderstyle borderstyle = stylebox!
end type
global u_dw_companyimages u_dw_companyimages

forward prototypes
public function string of_getrequiredtypes ()
public function string of_getwarningtypes ()
public function string of_getprinttypes ()
public function integer of_setrequiredtypes (string asa_types[])
public function integer of_setwarningtypes (string asa_types[])
public function integer of_setprinttypes (string asa_types[])
end prototypes

public function string of_getrequiredtypes ();Long		ll_RowCount
Long		i
String	lsa_Types[]
String	ls_Return

n_cst_String lnv_String
ll_RowCount = THIS.RowCount ( )

FOR i = 1 TO ll_RowCount 
	
	IF THIS.Object.required[i] = 1 THEN
		lsa_Types[ UpperBound (lsa_Types) + 1 ] = THIS.Object.Type [ i ]
	END IF
	
NEXT

lnv_String.of_ArraytoString ( lsa_Types , ";" ,ls_Return)

RETURN ls_Return 
end function

public function string of_getwarningtypes ();Long		ll_RowCount
Long		i
String	lsa_Types[]
String	ls_Return

n_cst_String lnv_String
ll_RowCount = THIS.RowCount ( )

FOR i = 1 TO ll_RowCount 
	
	IF THIS.Object.warning[i] = 1 THEN
		lsa_Types[ UpperBound (lsa_Types) + 1 ] = THIS.Object.Type [ i ]
	END IF
	
NEXT

lnv_String.of_ArraytoString ( lsa_Types , ";" ,ls_Return)

RETURN ls_Return 
end function

public function string of_getprinttypes ();Long		ll_RowCount
Long		i
String	lsa_Types[]
String	ls_Return

n_cst_String lnv_String
ll_RowCount = THIS.RowCount ( )

FOR i = 1 TO ll_RowCount 
	
	IF THIS.Object.printwithbills[i] = 1 THEN
		lsa_Types[ UpperBound (lsa_Types) + 1 ] = THIS.Object.Type [ i ]
	END IF
	
NEXT

lnv_String.of_ArraytoString ( lsa_Types , ";" ,ls_Return)

RETURN ls_Return 
end function

public function integer of_setrequiredtypes (string asa_types[]);
//Long		ll_CurrentRow
//Long		i
//Long		ll_Count
//Long		ll_FindRow
//String	ls_Currenttype
//
//ll_Count = UpperBound ( asa_Types )
//FOR i = 1 To ll_Count
//	ls_CurrentType = asa_Types [ i ]
//	ll_FindRow = THIS.Find ( "type = '" + ls_CurrentType + "'" , 1 , 999 )
//	IF ll_FindRow > 0 THEN
//		THIS.SetItem ( ll_FindRow ,  "required", 1 )
//	END IF
//NEXT
//
RETURN -1


end function

public function integer of_setwarningtypes (string asa_types[]);//Long		ll_CurrentRow
//Long		i
//Long		ll_Count
//Long		ll_FindRow
//String	ls_Currenttype
//
//ll_Count = UpperBound ( asa_Types )
//FOR i = 1 To ll_Count
//	ls_CurrentType = asa_Types [ i ]
//	ll_FindRow = THIS.Find ( "type = '" + ls_CurrentType + "'" , 1 , 999 )
//	IF ll_FindRow > 0 THEN
//		THIS.SetItem ( ll_FindRow ,  "warning", 1 )
//	END IF
//NEXT
//
RETURN -1
end function

public function integer of_setprinttypes (string asa_types[]);//Long		ll_CurrentRow
//Long		i
//Long		ll_Count
//Long		ll_FindRow
//String	ls_Currenttype
//
//ll_Count = UpperBound ( asa_Types )
//FOR i = 1 To ll_Count
//	ls_CurrentType = asa_Types [ i ]
//	ll_FindRow = THIS.Find ( "type = '" + ls_CurrentType + "'" , 1 , 999 )
//	IF ll_FindRow > 0 THEN
//		THIS.SetItem ( ll_FindRow ,  "printwithbills", 1 )
//	END IF
//NEXT
//
RETURN -1
end function

event constructor;THIS.SetTransObject	( SQLCA )
THIS.Retrieve ( ) 

ib_rmbmenu = FALSE
end event

on u_dw_companyimages.create
end on

on u_dw_companyimages.destroy
end on

