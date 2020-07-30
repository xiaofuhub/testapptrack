$PBExportHeader$w_billquickprint.srw
forward
global type w_billquickprint from window
end type
type dw_bills from u_bills within w_billquickprint
end type
end forward

global type w_billquickprint from window
integer x = 393
integer y = 336
integer width = 2880
integer height = 1720
boolean titlebar = true
string title = "Print Delivery Receipt"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 12632256
dw_bills dw_bills
end type
global w_billquickprint w_billquickprint

type variables
Private:
n_cst_Billing	inv_Billing
end variables

forward prototypes
private function integer wf_retrieve (long ala_ids[], string as_type)
private function integer wf_print ()
end prototypes

private function integer wf_retrieve (long ala_ids[], string as_type);Integer	li_Return = 1
String	ls_Sort
String	ls_IdList
String	ls_PosString

n_cst_String	lnv_String

dw_Bills.of_Set_Layout ( as_Type )

//Build Sort
lnv_String.of_arraytostring( ala_ids, ',', ls_IdList)
ls_PosString = "," + ls_IdList + ","
ls_Sort = "Pos ( '" + ls_PosString + "',  ',' + String ( ds_id ) + ',' ) A"
dw_Bills.of_SetSort(ls_Sort)

IF inv_Billing.of_Retrieve ( ala_Ids, as_Type) > 0 THEN

	wf_Print ( )

ELSE

	li_Return = -1

	MessageBox ( "Print Request", "Could not retrieve information from database.~n~n"+&
		"Request cancelled.", Exclamation! )

END IF

Post Close ( This )

RETURN li_Return
end function

private function integer wf_print ();s_Longs	lstr_Selected_Copies
Integer	li_Return = 1

IF dw_Bills.RowCount ( ) > 0 THEN
	lstr_Selected_Copies.longar [ 1 ] = 1
	inv_Billing.of_Print ( dw_Bills, lstr_Selected_Copies )
ELSE
	li_Return = 0
END IF

RETURN li_Return
end function

on w_billquickprint.create
this.dw_bills=create dw_bills
this.Control[]={this.dw_bills}
end on

on w_billquickprint.destroy
destroy(this.dw_bills)
end on

event open;//Note : The x position of this is set to display off the screen.

n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
Long			lla_Ids[]
String		ls_Type

lnv_Msg = Message.PowerObjectParm

IF lnv_Msg.of_Get_Parm ( "IDS", lstr_Parm ) > 0 THEN
	lla_Ids = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "TYPE", lstr_Parm ) > 0 THEN
	ls_Type = lstr_Parm.ia_Value
END IF

inv_Billing = CREATE n_cst_Billing
dw_Bills.of_Set_Manager ( inv_Billing )

Post wf_Retrieve ( lla_Ids, ls_Type )
end event

event close;DESTROY inv_Billing
end event

type dw_bills from u_bills within w_billquickprint
integer x = 27
integer y = 24
end type

