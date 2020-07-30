$PBExportHeader$n_cst_windowstate.sru
forward
global type n_cst_windowstate from n_base
end type
end forward

global type n_cst_windowstate from n_base
end type
global n_cst_windowstate n_cst_windowstate

type variables
Protected:
w_Master	iw_requestor

Private:
String	is_WindowName
Int		ii_Instance
end variables

forward prototypes
public function integer of_restorestate ()
public function integer of_savestate ()
public function integer of_setrequestor (w_master aw_window)
public function integer of_setrequestor (w_master aw_window, boolean ab_restorestate)
public subroutine readme ()
end prototypes

public function integer of_restorestate ();Int		li_Return
String	ls_Name
Long		ll_UserId
Long		ll_RowCount

Int	li_X
Int	li_Y
Int	li_Width
Int	li_Height
Int	li_Instance
string	ls_WindowState


DataStore	lds_State

IF NOT isValid ( iw_requestor ) THEN
	RETURN 0
END IF

lds_State = CREATE dataStore
lds_State.DataObject = "d_windowState"
lds_State.SetTransObject ( SQLCA )
	
ls_name = is_windowname // not pulling it off of the requestor b.c. of the ship/itin - disp relationship... see of_setrequestor()
ll_UserId = gnv_app.of_Getnumericuserid( )
li_Instance = ii_instance

ll_RowCount = lds_State.Retrieve( ls_Name , ll_UserId )
Commit;

lds_State.SetFilter ( "active <> 1" )
lds_State.Filter ( )
ll_RowCount = lds_State.RowCount ( )

IF ll_RowCount > 0 THEN
	// take the first row and use the instance number from it
	ii_Instance = lds_State.object.Instance[1] // this variable is used when the window state is saved.
	
	li_X = lds_State.Object.xPosition[1]
	li_Y = lds_State.Object.YPosition[1]
	li_Width = lds_State.Object.Width[1]
	li_Height = lds_State.Object.Height[1]
	ls_WindowState = lds_State.Object.State[1]
	
	iw_requestor.x = li_X
	iw_requestor.y = li_Y
	iw_requestor.Width = li_Width
	iw_requestor.height = li_Height

	lds_State.object.active [1] = 1
	IF lds_State.Update( ) = 1 THEN
		Commit;
	ELSE
		RollBack;
	END IF
	
END IF
	
DESTROY ( lds_State )

RETURN li_Return
end function

public function integer of_savestate ();Int		li_Return
String	ls_Name
Long		ll_UserId
Long		ll_RowCount

Int	li_X
Int	li_Y
Int	li_Width
Int	li_Height
Int	li_Instance
string	ls_WindowState

DataStore	lds_State

IF NOT isValid ( iw_requestor ) THEN
	RETURN 0
END IF

lds_State = CREATE dataStore
lds_State.DataObject = "d_windowState"
lds_State.SetTransObject ( SQLCA )
	
ls_name = is_windowname // not pulling it off of the requestor b.c. of the ship, itin disp relationship... see of_setrequestor()
ll_UserId = gnv_app.of_Getnumericuserid( )
li_Instance = ii_instance

ll_RowCount = lds_State.Retrieve( ls_Name , ll_UserId )
Commit;

IF iw_requestor.Windowstate = MAXIMIZED! THEN
	long i
	FOR i = ll_RowCount TO 1 STEP -1
		
		lds_State.DeleteRow ( i )
		
	NEXT
ELSE
	
	lds_State.SetFilter ( "instance = " + String ( li_Instance ) )
	lds_State.Filter ( )
	ll_RowCount = lds_State.RowCount ()
	
	IF ll_RowCount = 0 THEN
		ll_RowCount = lds_State.Insertrow( 0 )	
	END IF
		
	IF ll_RowCount > 0 THEN
	
		li_X = iw_requestor.x
		li_Y = iw_requestor.y
		li_Width = iw_requestor.Width
		li_Height = iw_requestor.height
		
		lds_State.Object.WindowName[ll_RowCount] = ls_Name
		lds_State.Object.xPosition[ll_RowCount] = li_X
		lds_State.Object.YPosition[ll_RowCount] = li_Y
		lds_State.Object.Width[ll_RowCount] = li_Width
		lds_State.Object.Height[ll_RowCount] = li_Height
		lds_State.Object.State[ll_RowCount] = ls_WindowState
		lds_State.Object.UserID[ll_RowCount] = ll_UserId
		lds_State.Object.Instance[ll_RowCount] = li_Instance
		lds_State.Object.Active [ll_RowCount] = 0
			
	END IF

END IF

IF lds_State.Update ( ) = 1 THEN
	Commit;
ELSE
	//MessageBox ( "Window State" , "error saving state" )
	Rollback;
END IF

DESTROY ( lds_State )
 
RETURN li_Return
end function

public function integer of_setrequestor (w_master aw_window);RETURN THIS.of_Setrequestor( aw_window , TRUE )
end function

public function integer of_setrequestor (w_master aw_window, boolean ab_restorestate);String	ls_WindowName
w_Master	lw_Req

lw_Req = aw_window

ls_WindowName = lw_Req.ClassName ( )
ii_instance = lw_Req.wf_GetInstance ( )

IF ls_WindowName = "w_itin"  OR ls_WindowName = "w_ship" THEN
	lw_Req = lw_Req.Parentwindow( ) // because we really want the disp window 
END IF

is_windowname = ls_WindowName  // we want to be able to store different positions for ship and itin

iw_requestor = lw_Req

IF ab_restorestate THEN
	THIS.of_Restorestate( )
END IF

RETURN 1
end function

public subroutine readme ();
/*

					to use this service


1. declare a shared int for the instance number of the window (int	si_Instance)

2. Turn the service on in the open script of the window and increment the 
	shared variable
	
	
	si_Instance ++
	THIS.wf_SetWindowState ( TRUE )  

3.	In the close event, save the current state of the window, turn of the service and
	decrement the shared variable.


	IF IsValid ( inv_Windowstate ) THEN
		inv_windowstate.of_Savestate( )
		THIS.wf_setwindowstate( FALSE )
	END IF
	si_instance --

4.	Implement wf_GetInstance ( ) to return si_instance

violla...


NOTE: There may be a need for special processing if there is a "non-standard" relationship between
		the window you want to keep track of and its parent. i.e Dispatch window and the Ship/Itin Window.


		 you can look at w_ShipmentManager for an example

*/
end subroutine

on n_cst_windowstate.create
call super::create
end on

on n_cst_windowstate.destroy
call super::destroy
end on

