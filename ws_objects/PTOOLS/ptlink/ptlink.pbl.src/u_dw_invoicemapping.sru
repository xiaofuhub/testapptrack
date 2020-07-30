$PBExportHeader$u_dw_invoicemapping.sru
forward
global type u_dw_invoicemapping from u_dw
end type
end forward

global type u_dw_invoicemapping from u_dw
integer width = 1664
integer height = 240
string dataobject = "d_companyinvoicemapping"
boolean border = false
event ue_preupdate ( )
event ue_toggleemailinvoice ( boolean ab_switch )
event ue_postsave ( )
end type
global u_dw_invoicemapping u_dw_invoicemapping

type variables
Long	il_coid
end variables

forward prototypes
public function integer of_retrieve (long al_coid)
public function integer of_setschema (string as_schema)
end prototypes

event ue_toggleemailinvoice(boolean ab_switch);This.Enabled = ab_Switch
IF ab_Switch THEN
	This.Object.targetcompanydocument.background.color = RGB(255,255,255)
	This.Object.ptdocument.background.color = RGB(255,255,255)
ELSE
	This.Object.targetcompanydocument.background.color = 78682240
	This.Object.ptdocument.background.color = 78682240
END IF
end event

event ue_postsave();Integer li_Return

IF This.RowCount() = 0 THEN
	li_Return = THIS.event pfc_addrow( )
END IF
end event

public function integer of_retrieve (long al_coid);Int	li_Return
il_coid = al_coid
li_Return = THIS.Retrieve ( al_coid )
IF li_Return = 0 THEN
	li_Return = THIS.event pfc_addrow( )
END IF

RETURN li_Return
end function

public function integer of_setschema (string as_schema);Long		ll_Index
Long		ll_Max = 0
String	ls_CurrentSchema



ll_Max = This.RowCount()
FOR ll_Index = 1 TO ll_Max
	ls_CurrentSchema = This.GetItemString(ll_Index, "namingschema")
	IF ls_CurrentSchema <> as_Schema OR isNull(ls_CurrentSchema)THEN
		This.SetItem(ll_Index, "namingschema", as_Schema)
	END IF
NEXT


Return ll_Max
end function

on u_dw_invoicemapping.create
end on

on u_dw_invoicemapping.destroy
end on

event pfc_addrow;call super::pfc_addrow;Long	ll_Return
ll_Return = AncestorReturnValue
IF ll_Return > 0 THEN
	THIS.SetItem ( ll_Return , "targetcompanyid" , il_coid )
	THIS.SetRow ( ll_Return )
	THIS.SetColumn ( "targetcompanydocument" )
	THIS.SetFocus( )
	THIS.SetItemStatus (ll_Return , 0 , PRIMARY!,NotModified! )
END IF
RETURN ll_Return
end event

event pfc_accepttext;call super::pfc_accepttext;Int	li_Return = 1
Long	ll_RowCount
Long	i


//////  start the check for duplicates to remove
THIS.SetFilter ( "" )
THIS.Filter ( )
//Step 1: First sort the records in Datawindow 
THIS.SetSort('targetcompanydocument A, ptdocument A')
THIS.Sort()

DO 
	
	//Step 2: 
	THIS.SetFilter(' ( targetcompanydocument = targetcompanydocument[1] AND ptdocument = ptdocument[1] ) OR ( targetcompanydocument = targetcompanydocument[-1] AND ptdocument = ptdocument[-1] )')
	THIS.Filter()

	ll_RowCount = THIS.RowCount ( )
	IF ll_RowCount > 0 THEN
		THIS.DeleteRow ( 1 )
	END IF
	
LOOP UNTIL ll_RowCount = 0

THIS.SetFilter ( "" )
THIS.Filter ( )
//////// end of check for dups

/////Delete Empty Rows
ll_RowCount = This.RowCount()

FOR i = ll_RowCount TO 1 Step -1 
	IF isNull ( THIS.GetItemString ( i , "targetcompanydocument" ) )  AND isNull ( THIS.GetItemString ( i , "ptdocument" ) ) THEN
		This.RowsDiscard(i, i, Primary!)
	END IF
NEXT
//////END Delete Emtpy Rows

//// now check for missing entries
ll_RowCount = THIS.RowCount ( )

FOR i = 1 To ll_RowCount
	//Checking if one field has input and the other is null (force them to specify both)
	IF isNull ( THIS.GetItemString ( i , "targetcompanydocument" ) )  AND NOT isNull ( THIS.GetItemString ( i , "ptdocument" ) )THEN
		li_Return = -1
	ELSEIF NOT isNull (This.GetItemString(i, "targetcompanydocument")) AND isNull( This.GetItemString(i, "ptdocument"))THEN
		li_Return = -1
	END IF
	
NEXT

IF li_Return = -1 THEN
	MessageBox ( "Document Mapping" , "Both document types are required to save your data." )
END IF

RETURN li_Return
end event

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA )
ib_Rmbmenu = FALSE
end event

