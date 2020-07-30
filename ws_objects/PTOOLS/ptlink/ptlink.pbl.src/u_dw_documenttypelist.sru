$PBExportHeader$u_dw_documenttypelist.sru
$PBExportComments$[u_dw] Lists the document types (d_DocumentTypeSelect)
forward
global type u_dw_documenttypelist from u_dw
end type
end forward

global type u_dw_documenttypelist from u_dw
integer width = 1806
integer height = 432
string dataobject = "d_documenttypeselect"
end type
global u_dw_documenttypelist u_dw_documenttypelist

forward prototypes
public function integer of_retrievedocumenttypes ()
public function integer of_setallrowschecked ()
public function integer of_setallrowsUNchecked ()
public function integer of_makeselections (string as_classification, boolean ab_select)
end prototypes

public function integer of_retrievedocumenttypes ();// Populates the dw_docTypes datawindow with the available document types
String 	ls_Types[], &
			ls_Topic
	
Integer	li_Result, &
			li_Count
			
Long		ll_CurrRow

ls_Topic = "SHIPMENT"

//This.SetTransObject(SQLCA)		/// NOTE THIS is commented until ImageExpress is coded 
//This.Retrieve()						/// NOTE THIS is commented until ImageExpress is coded 

n_cst_bso_Document_Manager lnv_DocumentManager 
lnv_DocumentManager = Create n_cst_bso_Document_Manager 

li_Result = lnv_DocumentManager.of_GetTypeList( ls_Types[] )

For li_Count = 1 to li_Result 
	ll_CurrRow = This.InsertRow(0)
	This.SetItem(ll_CurrRow, "type", ls_Types[ li_Count ] )
	This.SetItem(ll_CurrRow, "topic", ls_Topic )
	This.SetItem(ll_CurrRow, "typechecked", "n" )
	this.setitem(ll_CurrRow, "classification", "Email" )
Next

Destroy ( lnv_DocumentManager )


Return 1



end function

public function integer of_setallrowschecked ();//
/***************************************************************************************
NAME			: of_SetAllRowsChecked
ACCESS		: public
ARGUMENTS	: none
RETURNS		: integer (number of rows checked)
DESCRIPTION	: marks all rows as Checked

REVISION		: RDT 092602
***************************************************************************************/
integer 	li_Counter, &
			li_RowCount

li_RowCount= This.RowCount()
For li_Counter = 1 to li_RowCount
	this.SetItem(li_Counter, "Typechecked", "y")
Next

Return li_Rowcount
end function

public function integer of_setallrowsUNchecked ();//
/***************************************************************************************
NAME			: of_SetAllRowsUNChecked
ACCESS		: public
ARGUMENTS	: none
RETURNS		: integer (number of rows UNchecked)
DESCRIPTION	: marks all rows as UNChecked

REVISION		: RDT 092602
***************************************************************************************/
integer 	li_Counter, &
			li_RowCount

li_RowCount= This.RowCount()
For li_Counter = 1 to li_RowCount
	this.SetItem(li_Counter, "Typechecked", "n")
Next

Return li_Rowcount
end function

public function integer of_makeselections (string as_classification, boolean ab_select);Long	ll_RowCount
Long	i
String	ls_CheckValue

IF ab_select THEN
	ls_CheckValue = "y"
ELSE
	ls_CheckValue = "n"
END IF
	
ll_RowCount = THIS.RowCount ( )



FOR i = 1 TO ll_RowCount 

	IF Upper ( THIS.GetItemString ( i , "Classification" ) ) = Upper (as_classification ) THEN
		THIS.SetItem ( i , "typechecked" , ls_CheckValue)
	END IF
	
NEXT

RETURN 1


end function

event constructor;ib_rmbMenu = FALSE
end event

on u_dw_documenttypelist.create
end on

on u_dw_documenttypelist.destroy
end on

event retrieveend;call super::retrieveend;Int	i
FOR i = 1 TO Rowcount
	
	THIS.Setitem ( i , "Classification" , "Image" )
	
NEXT

RETURN AncestorReturnValue
end event

