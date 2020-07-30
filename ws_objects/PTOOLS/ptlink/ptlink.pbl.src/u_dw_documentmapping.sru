$PBExportHeader$u_dw_documentmapping.sru
forward
global type u_dw_documentmapping from u_dw
end type
end forward

global type u_dw_documentmapping from u_dw
integer width = 2359
integer height = 420
string dataobject = "d_documentmapping"
boolean border = false
borderstyle borderstyle = stylebox!
end type
global u_dw_documentmapping u_dw_documentmapping

type variables
Private:
Long	il_CoID
end variables

forward prototypes
public function integer of_retrieve (long al_coid)
end prototypes

public function integer of_retrieve (long al_coid);Int	li_Return
il_coid = al_coid
li_Return = THIS.Retrieve ( al_coid )
IF li_Return = 0 THEN
	li_Return = THIS.event pfc_addrow( )
	IF li_Return = 1 THEN
		THIS.SetItemStatus ( 1 , 0 , PRIMARY!,NotModified! )
	END IF
END IF

RETURN li_Return
	
end function

on u_dw_documentmapping.create
end on

on u_dw_documentmapping.destroy
end on

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA )
ib_Rmbmenu = FALSE
end event

event pfc_addrow;call super::pfc_addrow;Long	ll_Return
ll_Return = AncestorReturnValue
IF ll_Return > 0 THEN
	THIS.SetItem ( ll_Return , "targetcompanyid" , il_coid )
	THIS.SetItem ( ll_Return , "Holdtransfer" , "0" )
	THIS.SetItem ( ll_Return , "send" , "1" )
	THIS.SetRow ( ll_Return )
	THIS.SetColumn ( "targetcompanydocument" )
	THIS.SetFocus( )
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

//// now check for missing entries
ll_RowCount = THIS.RowCount ( )

FOR i = 1 To ll_RowCount

	IF isNull ( THIS.GetItemString ( i , "targetcompanydocument" ) )  OR isNull ( THIS.GetItemString ( i , "ptdocument" ) )THEN
		li_Return = -1
	END IF
	
NEXT

IF li_Return = -1 THEN
	MessageBox ( "Document Mapping" , "Both document types are required to save your data." )
END IF

RETURN li_Return
end event

