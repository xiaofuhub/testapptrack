$PBExportHeader$u_dw_edistatus_dddw.sru
forward
global type u_dw_edistatus_dddw from u_dw
end type
end forward

global type u_dw_edistatus_dddw from u_dw
integer width = 923
integer height = 100
string dataobject = "d_edistatus_dddw"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type
global u_dw_edistatus_dddw u_dw_edistatus_dddw

type variables
DataWindowChild idwc_List

end variables

forward prototypes
public function integer of_retrieve (string as_segment)
public function string of_getstatus ()
end prototypes

public function integer of_retrieve (string as_segment);Long	ll_Return = -1
IF isValid ( idwc_list ) THEN
	idwc_list.Setsqlselect( "Select * From edi_status where segmentid = '" + as_segment +"'" )
	ll_Return = idwc_list.Retrieve( )
	IF ll_Return > 0 THEN
		THIS.SetItem ( 1 , "id" , idwc_list.GetItemnumber( 1, "ID") )
	END IF
END IF

RETURN ll_Return

end function

public function string of_getstatus ();String	ls_Return
IF THIS.RowCount ( ) > 0 THEN
	IF idwc_list.rowCount( ) > 0 THEN
		ls_Return = idwc_list.GetItemString( idwc_list.GetRow ( ),"Code")
	END IF
END IF

RETURN ls_Return
end function

on u_dw_edistatus_dddw.create
end on

on u_dw_edistatus_dddw.destroy
end on

event constructor;call super::constructor;THIS.Settransobject( SQLCA )
THIS.InsertRow ( 0 )
IF THIS.GetChild('ID', idwc_List) = 1 THEN
	idwc_list.SetTransObject ( sqlca ) 
END IF





end event

