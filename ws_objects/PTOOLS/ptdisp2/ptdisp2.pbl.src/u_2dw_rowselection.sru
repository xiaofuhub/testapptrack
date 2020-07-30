$PBExportHeader$u_2dw_rowselection.sru
$PBExportComments$selects and moves rows between two datawindows
forward
global type u_2dw_rowselection from u_base
end type
type dw_left from u_dw within u_2dw_rowselection
end type
type dw_right from u_dw within u_2dw_rowselection
end type
type cb_move_left from u_cb within u_2dw_rowselection
end type
type cb_move_right from u_cb within u_2dw_rowselection
end type
type st_left from u_st within u_2dw_rowselection
end type
type st_right from u_st within u_2dw_rowselection
end type
end forward

global type u_2dw_rowselection from u_base
int Width=3296
int Height=672
long BackColor=80269524
event type integer ue_leftright ( long ala_id[] )
event type integer ue_rightleft ( long ala_id[] )
dw_left dw_left
dw_right dw_right
cb_move_left cb_move_left
cb_move_right cb_move_right
st_left st_left
st_right st_right
end type
global u_2dw_rowselection u_2dw_rowselection

type variables
n_ds        ids_master
String	is_KeyColumn
end variables

forward prototypes
public subroutine of_setlefttitle (string as_text)
public subroutine of_setrighttitle (string as_text)
private function integer of_moverows (string as_direction)
public function integer of_setdwblob (blob abl_data, string as_left_right)
public function integer of_setfilter (string as_filter, string as_left_right)
public subroutine of_setkeycolumn (string as_Column)
private function string of_getkeycolumn ()
public function integer of_setrowselect (long al_RowStyle, string as_Left_Right)
public function integer of_redraw (boolean ab_on, string as_leftright)
public function integer of_settaborderoff (string as_leftright)
public function integer of_leftrightenable (boolean ab_enabled)
public function integer of_rightleftenable (boolean ab_enabled)
public function string of_getrighttitle ()
public function string of_getlefttitle ()
public function datawindow of_getrightsource ()
public function datawindow of_getleftsource ()
public function integer of_setsource (datastore ads_datastore)
public function datastore of_getsource ()
public function integer of_duplicatemain (string as_left_right)
end prototypes

public subroutine of_setlefttitle (string as_text);//
/***************************************************************************************
NAME			: of_SetLeftTitle

ACCESS		: Public 

ARGUMENTS	: String		
RETURNS		: none
DESCRIPTION	: Sets the text of st_left to the argument

REVISION		: RDT 110702
***************************************************************************************/

st_left.Text = as_text

end subroutine

public subroutine of_setrighttitle (string as_text);//
/***************************************************************************************
NAME			: of_SetRightTitle

ACCESS		: Public 

ARGUMENTS	: String		
RETURNS		: none
DESCRIPTION	: Sets the text of st_Right to the argument

REVISION		: RDT 110702
***************************************************************************************/

st_Right.Text = as_text

end subroutine

private function integer of_moverows (string as_direction);//
/***************************************************************************************
NAME			: of_MoveRows
ACCESS		: Private 
ARGUMENTS	: String		(Direction of move "LEFT" or "RIGHT")
RETURNS		: Integer 	(Number of rows moved, or -1 if Failed)
DESCRIPTION	: Moves Selected rows from Left to Right, or Right to Left

REVISION		: RDT 110702
***************************************************************************************/

Integer	li_Return = 1


Long 	lla_Id[], &
		ll_array, &
		ll_SelectedRow, &
		ll_Count, &
		ll_Row, &
		lla_RowsSelected[], &
		ll_UpperBound

ll_array = 0 
		
as_Direction = UPPER( as_Direction )

Choose Case as_Direction 
		
	Case "LEFTTORIGHT", "L"
		
		dw_LEFT.inv_rowselect.of_selectedCount(lla_RowsSelected[]) // get array of selected rows
		ll_UpperBound = UpperBound( lla_RowsSelected[] ) 
		dw_LEFT.SelectRow(0, FALSE )

		For ll_Count = ll_UpperBound to 1 Step -1
				ll_array ++ 
				lla_id[ ll_array ] = dw_LEFT.GetItemNumber( lla_RowsSelected[ ll_Count ], is_KeyColumn )
				dw_LEFT.RowsMove ( lla_RowsSelected[ ll_Count ] , lla_RowsSelected[ ll_Count ] , Primary!, dw_RIGHT, dw_RIGHT.RowCount() + 1 , Primary! )
		Next

		If UpperBound( lla_id ) > 0 Then
			This.Event ue_LeftRight( lla_id[] )
		End If
		
		li_Return = ll_array 	
		
		
	Case "RIGHTTOLEFT","R"
		dw_RIGHT.inv_rowselect.of_selectedCount( lla_RowsSelected[] ) // get array of selected rows
		ll_UpperBound = UpperBound( lla_RowsSelected[] ) 
		dw_RIGHT.SelectRow(0, FALSE )

		For ll_Count = ll_UpperBound to 1 Step -1
				ll_array ++ 
				lla_id[ ll_array ] = dw_RIGHT.GetItemNumber( lla_RowsSelected[ ll_Count ], is_KeyColumn )
				dw_RIGHT.RowsMove ( lla_RowsSelected[ ll_Count ] , lla_RowsSelected[ ll_Count ] , Primary!, dw_LEFT, dw_LEFT.RowCount() + 1 , Primary! )
		Next

		If UpperBound( lla_id ) > 0 Then
			This.Event ue_RightLeft( lla_id[] )
		End If
		
		li_Return = ll_array 

	Case Else
		MessageBox("u_dw2_Rowselection.of_MoveRows","Case Statement not coded for :"+as_Direction )
		li_Return = -1
end Choose

Return li_Return 


end function

public function integer of_setdwblob (blob abl_data, string as_left_right);//
/***************************************************************************************
NAME			: of_SetDWBlob
ACCESS		: Public 
ARGUMENTS	: BLOB	  	(dw/ds getfull state blob)
				: String		( Left or right)
RETURNS		: Integer 	(1=Success, -1=Fail)
DESCRIPTION	: SetFullState on the datawindow to the blob argument 
				NOTE. There was an issue with the dwControl jumping up after the SetFullState.
				I have to reposition it relative to the single line edit.
				
REVISION		: RDT 110702
***************************************************************************************/

Integer	li_Return 

Choose Case Upper(as_left_right)

	Case "L", "LEFT"
		li_Return = dw_Left.SetFullState( abl_data )
		dw_Left.Y = st_Left.Y + 80
		dw_Left.X = st_Left.X
		This.of_SetTabOrderOff("LEFT")

	Case "R", "RIGHT"
		li_Return = dw_Right.SetFullState( abl_data )
		dw_Right.Y = st_Right.Y + 80
		dw_Right.X = st_Right.X
		This.of_SetTabOrderOff("RIGHT")
		
	Case Else
		MessageBox("Program Error u_2dw_rowselection.of_SetDwBlob"," Case statement not coded for: "+as_left_right)
		li_Return = -1

End Choose

Return li_Return 
end function

public function integer of_setfilter (string as_filter, string as_left_right);//
/***************************************************************************************
NAME			: of_SetFilter
ACCESS		: Public 
ARGUMENTS	: String		(filter string)
				: String		(L = Left dw, R = Right dw)
RETURNS		: Integer 	(1=Success, -1=Fail)
DESCRIPTION	: 

REVISION		: RDT 110702
***************************************************************************************/

Integer	li_Return 

Choose Case Upper( as_Left_Right )
		
	Case "LEFT", "L"
		dw_Left.SetFilter( as_filter )
		dw_left.Filter( )		
		
	Case "RIGHT", "R"
		dw_right.SetFilter( as_filter )
		dw_right.Filter( )
		
	Case Else
		MessageBox("Program Error u_2dw_rowselection.ofSetFilter ","Case statement not coded for: "+as_left_right)
		li_Return = -1
			
End Choose


Return li_Return 
end function

public subroutine of_setkeycolumn (string as_Column);//
/***************************************************************************************
NAME			: of_SetKeyColumn
ACCESS		: Public 
ARGUMENTS	: String	(Name of Key Column)
RETURNS		: none
DESCRIPTION	: Sets instance variable to name of key column. 

REVISION		: RDT 112102
***************************************************************************************/
is_keycolumn = as_Column
end subroutine

private function string of_getkeycolumn ();//
/***************************************************************************************
NAME			: of_GetKeyColumn
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: String	(Name of Key Column)
DESCRIPTION	: Gets instance variable is_keyColumn. 

REVISION		: RDT 112102
***************************************************************************************/
Return is_KeyColumn 
end function

public function integer of_setrowselect (long al_RowStyle, string as_Left_Right);//
/***************************************************************************************
NAME			: of_SetRowSelect
ACCESS		: Public 
ARGUMENTS	: Long		(SetStyle value)
				: String		(Left or Right datawindow to set the style on)
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Sets the Row select style of the datawindow

REVISION		: RDT 112102
***************************************************************************************/

Integer	li_Return = 1 

If ( al_RowStyle < 0 ) or ( al_RowStyle > 2 ) then 
		MessageBox("Program error u_2dw_RowSelection.of_SetRowSelect","al_RowStyle < 0 or > 2 ")
		li_Return = -1
End If

If li_Return = 1 Then 

	Choose Case Upper(as_Left_Right)
		Case "L", "LEFT"
			// set row selection on List datawindow
			dw_left.of_SetRowSelect ( TRUE ) 
			dw_left.inv_rowselect.of_SetStyle ( al_RowStyle ) 
			
		Case "R", "RIGHT"
			dw_right.of_SetRowSelect ( TRUE ) 
			dw_right.inv_rowselect.of_SetStyle ( al_RowStyle ) 
			
		Case Else
			MessageBox("Program error u_2dw_RowSelection.of_SetRowSelect","Case Statement not coded for:"+as_Left_Right)
			li_Return = -1
	End Choose

End If


Return li_Return 

end function

public function integer of_redraw (boolean ab_on, string as_leftright);//
/***************************************************************************************
NAME			: of_redraw	
ACCESS		: Public 
ARGUMENTS	: Boolean		(sets redraw on or off)
				: String			(Left /  Right)
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: 

REVISION		: RDT 112102
***************************************************************************************/

Integer	li_Return  = 1
Choose Case Upper(as_LeftRight)
	Case "LEFT","L"
		dw_LEFT.SetRedraw( ab_on )
	Case "RIGHT","R"
		dw_RIGHT.SetRedraw( ab_on )
	Case Else
		MessageBox("u_dw2_Rowselection.of_Redraw","Case Statement not coded for :"+as_leftright)
		li_Return = -1

End Choose


Return li_Return 
end function

public function integer of_settaborderoff (string as_leftright);//
/***************************************************************************************
NAME			: of_SetTabOrderOff
ACCESS		: Private 
ARGUMENTS	: String		(Left / Right)
RETURNS		: Integer 	(1=Success, -1=Fail)
DESCRIPTION	: Turns tab order off on all columns of datawindow. 

REVISION		: RDT 112102
***************************************************************************************/

Integer	li_Return 
Long 	ll_ColCount, &
		ll_count

Choose Case Upper( as_LeftRight )
	Case "LEFT", "L"
		ll_colcount = long ( dw_LEFT.Object.DataWindow.Column.Count )
		For  ll_Count = 1 to ll_colcount
			dw_LEFT.SetTabOrder( ll_Count, 0 )
		Next
		
	Case "RIGHT", "R"
		ll_colcount = long ( dw_RIGHT.Object.DataWindow.Column.Count )
		For  ll_Count = 1 to ll_colcount
			dw_RIGHT.SetTabOrder( ll_Count, 0 )
		Next
		
	Case Else
		MessageBox("u_dw2_Rowselection.of_SetTabOrderOff","Case Statement not coded for :" + as_leftright )
		li_Return = -1

End Choose

Return li_Return 
end function

public function integer of_leftrightenable (boolean ab_enabled);//
/***************************************************************************************
NAME			: of_leftrightenable	
ACCESS		: Public 
ARGUMENTS	: Boolean (Enable or disable the button)
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: 

REVISION		: RDT 112102
***************************************************************************************/

Integer	li_Return 

cb_move_right.Enabled = ab_enabled

Return li_Return 
end function

public function integer of_rightleftenable (boolean ab_enabled);//
/***************************************************************************************
NAME			: of_RichgLeftEnable	
ACCESS		: Public 
ARGUMENTS	: Boolean (Enable or disable the button)
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: 

REVISION		: RDT 112102
***************************************************************************************/

Integer	li_Return 

cb_move_left.Enabled = ab_enabled

Return li_Return 
end function

public function string of_getrighttitle ();//
/***************************************************************************************
NAME			: of_SetRightTitle
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: String
DESCRIPTION	: Gets the text of st_Right 
REVISION		: RDT 110702
***************************************************************************************/

Return st_Right.Text 

end function

public function string of_getlefttitle ();//
/***************************************************************************************
NAME			: of_GetLeftTitle
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: String
DESCRIPTION	: Gets the text of st_Left
REVISION		: RDT 110702
***************************************************************************************/

Return st_left.Text 

end function

public function datawindow of_getrightsource ();Return dw_right
end function

public function datawindow of_getleftsource ();Return dw_left
end function

public function integer of_setsource (datastore ads_datastore);
Integer  li_Return 

If isValid( ads_DataStore ) Then 
	ids_Master = ads_datastore
	li_Return = 1
Else
	li_Return = -1
End If

Return li_Return 

end function

public function datastore of_getsource ();
Return ids_Master
end function

public function integer of_duplicatemain (string as_left_right);// makes a duplicate of main datastore in left or right datawindow
Integer 	li_Return

Choose Case Upper(as_left_right)

	Case "L", "LEFT"
		dw_Left.Reset()
		ids_master.RowsCopy (1, ids_master.RowCount()+1, Primary!, dw_Left, 1, 	Primary! ) 
		ids_master.RowsCopy (1, ids_master.RowCount()+1, Filter!, dw_Left, 1, 	Filter! )
		ids_master.RowsCopy (1, ids_master.RowCount()+1, Delete!, dw_Left, 1, 	Delete! )
		li_Return = 1

	Case "R", "RIGHT"
		dw_Right.Reset()
		ids_master.RowsCopy (1, ids_master.RowCount()+1, Primary!, dw_Right, 1, Primary! )
		ids_master.RowsCopy (1, ids_master.RowCount()+1, Filter!, dw_Right, 1, 	Filter! )
		ids_master.RowsCopy (1, ids_master.RowCount()+1, Delete!, dw_Right, 1, 	Delete! )
		li_Return = 1

	Case Else
		MessageBox("Program Error u_2dw_rowselection.of_DuplicateMain"," Case statement not coded for: "+as_left_right)
		li_Return = -1

End Choose


Return li_Return
end function

event constructor;call super::constructor;//Enable the Resize Service
This.of_SetResize ( TRUE )

////Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize ( 1300, 400 )

//Register Resizable controls
inv_Resize.of_Register ( dw_left, 		'FixedToRight&Bottom' )
inv_Resize.of_Register ( dw_right,		'FixedToRight&Bottom' )
inv_Resize.of_Register ( st_left,		'FixedToRight&Bottom' )
inv_Resize.of_Register ( st_right,		'FixedToRight&Bottom' )
inv_Resize.of_Register ( cb_move_left,	'FixedToRight&Bottom' )
inv_Resize.of_Register ( cb_move_right,'FixedToRight&Bottom' )

// set Default row selection on List datawindow
dw_left.of_SetRowSelect ( TRUE ) 
dw_left.inv_rowselect.of_SetStyle ( 0 ) 

dw_right.of_SetRowSelect ( TRUE ) 
dw_right.inv_rowselect.of_SetStyle ( 0 ) 

end event

on u_2dw_rowselection.create
int iCurrent
call super::create
this.dw_left=create dw_left
this.dw_right=create dw_right
this.cb_move_left=create cb_move_left
this.cb_move_right=create cb_move_right
this.st_left=create st_left
this.st_right=create st_right
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_left
this.Control[iCurrent+2]=this.dw_right
this.Control[iCurrent+3]=this.cb_move_left
this.Control[iCurrent+4]=this.cb_move_right
this.Control[iCurrent+5]=this.st_left
this.Control[iCurrent+6]=this.st_right
end on

on u_2dw_rowselection.destroy
call super::destroy
destroy(this.dw_left)
destroy(this.dw_right)
destroy(this.cb_move_left)
destroy(this.cb_move_right)
destroy(this.st_left)
destroy(this.st_right)
end on

type dw_left from u_dw within u_2dw_rowselection
int X=14
int Y=96
int Width=1467
int Height=536
int TabOrder=10
boolean BringToTop=true
boolean HScrollBar=true
end type

event doubleclicked;If cb_move_right.enabled = TRUE Then 
	parent.of_MoveRows("LEFTTORIGHT")
End If
end event

event constructor;this.ib_rmbMenu = FALSE
end event

type dw_right from u_dw within u_2dw_rowselection
int X=1778
int Y=96
int Width=1467
int Height=536
int TabOrder=40
boolean BringToTop=true
boolean HScrollBar=true
end type

event constructor;this.ib_rmbMenu = FALSE
end event

event doubleclicked;If cb_move_left.enabled = TRUE Then 
	parent.of_MoveRows("RIGHTTOLEFT")
End If


end event

type cb_move_left from u_cb within u_2dw_rowselection
int X=1522
int Y=100
int Width=224
int TabOrder=20
boolean BringToTop=true
string Text="<<"
int TextSize=-11
end type

event clicked;
// 
Parent.of_MoveRows("RIGHTtoLEFT")

end event

type cb_move_right from u_cb within u_2dw_rowselection
int X=1522
int Y=260
int Width=224
int TabOrder=30
boolean BringToTop=true
string Text=">>"
int TextSize=-11
end type

event clicked;parent.of_MoveRows("LEFTtoRIGHT")
end event

type st_left from u_st within u_2dw_rowselection
int X=14
int Y=16
int Width=1467
boolean BringToTop=true
string Text=""
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

type st_right from u_st within u_2dw_rowselection
int X=1778
int Y=16
int Width=1467
boolean BringToTop=true
string Text=""
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

