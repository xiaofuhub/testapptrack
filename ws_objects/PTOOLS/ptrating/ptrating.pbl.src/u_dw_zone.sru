$PBExportHeader$u_dw_zone.sru
forward
global type u_dw_zone from u_dw
end type
end forward

global type u_dw_zone from u_dw
int Width=1801
int Height=424
string DataObject="d_zone"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
event ue_addrow ( )
event ue_deleterow ( )
event type integer ue_clearname ( long al_row )
event ue_clearblankrows ( )
end type
global u_dw_zone u_dw_zone

forward prototypes
public function long of_retrieve ()
public function integer of_allowclose ()
end prototypes

event ue_addrow;THIS.InsertRow ( 0 ) 
end event

event ue_deleterow;long	ll_Row

ll_Row = THIS.GetRow ( )
IF ll_Row > 0 THEN
	THIS.DeleteRow ( ll_Row )
END IF
end event

event ue_clearname;THIS.Object.Name[al_Row] = ""
RETURN 1
end event

event ue_clearblankrows;this.setredraw(false)

Long	ll_RowCount
Long	i

ll_RowCount = THIS.RowCount ( )
FOR i = ll_RowCount TO 1 STEP -1
	IF IsNull (  THIS.GetItemString ( i , "name", Primary!, true  )  ) THEN
		THIS.RowsDiscard ( i, i, Primary! ) 
	END IF	
NEXT
	
ll_RowCount = THIS.FilteredCount ( )
FOR i = ll_RowCount TO 1 STEP -1
	IF IsNull (  THIS.GetItemString ( i , "name", Filter!, true  )  ) THEN
		THIS.RowsDiscard ( i, i, Filter! ) 
	END IF	
NEXT
	
this.setredraw(true)
end event

public function long of_retrieve ();long	ll_rowcount

ll_rowcount = THIS.retrieve()
commit;

THIS.setrow(1)
THIS.setcolumn(1)
THIS.SetFocus()

return ll_rowcount

end function

public function integer of_allowclose ();Long	ll_RowCount
Long	i
Int	li_Return = 1

//first clear any blank rows
this.event ue_clearblankrows()

IF THIS.AcceptText ( ) = 1 THEN

	ll_RowCount = THIS.RowCount ( )
	
	FOR i = 1 TO ll_RowCount
		IF IsNull ( THIS.object.name[i] )  OR Len ( String ( THIS.object.name[i] ) ) = 0  THEN
			li_Return = -1
		END IF
		
	NEXT
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

event constructor;THIS.SettransObject ( SQLCA )
end event

event itemchanged;call super::itemchanged;String	ls_Find 
Long		ll_FindRow
Long		ll_Return 

ll_Return = AncestorReturnValue


CHOOSE CASE dwo.name
		
	CASE "name" 
		ls_Find = "name = '" + data + "'"
		ll_FindRow = THIS.Find ( ls_Find , 1 , 9999 ) 
		
		IF ll_FindRow > 0 THEN
			MessageBox ( "Zone Name" , "The Zone Name entered already exists. Please change your entry." )
			THIS.Post Event ue_ClearName ( Row )
			ll_Return = 1
		END IF
		
		
END CHOOSE

RETURN ll_Return

		
		
		
		
		
end event

event itemerror;call super::itemerror;Long	ll_Return

ll_Return = AncestorReturnValue

CHOOSE CASE dwo.name
		
	CASE "name" 
		
			ll_Return = 1
		

END CHOOSE

RETURN ll_Return
end event

