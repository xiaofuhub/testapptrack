$PBExportHeader$n_cst_dwsrv_rowselection.sru
$PBExportComments$Extension DataWindow Row Selection service
forward
global type n_cst_dwsrv_rowselection from pfc_n_cst_dwsrv_rowselection
end type
end forward

global type n_cst_dwsrv_rowselection from pfc_n_cst_dwsrv_rowselection
end type
global n_cst_dwsrv_rowselection n_cst_dwsrv_rowselection

forward prototypes
protected function integer of_rowselectext (long al_row, boolean ab_cntrlpressed, boolean ab_shiftpressed)
end prototypes

protected function integer of_rowselectext (long al_row, boolean ab_cntrlpressed, boolean ab_shiftpressed);/***************************************************************************************
NAME: 			of_rowSelectText

ACCESS:			Public
		
ARGUMENTS: 		
							same as PFC

RETURNS:			Same as PFC
	
DESCRIPTION:     *********modified from pfc at line  99 to set the anchor row when shift is
						held down and the anchor row has not already been set.  This makes it so
						that when holding shift and clicking on a row for the first time, the next
						click and shift will select everything from the anchor row to the next row
						clicked.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 	11-16-2005
	

***************************************************************************************/

integer	li_i
boolean	lb_waitforbuttonup=False
boolean	lb_takenoaction=False

// Check arguments.
If IsNull(al_row) or al_row <0 Then
	Return -1
End If

// @@
// n_cst_conversion lc
// gnv_app.inv_debug.of_Message(	'Row='+string(al_row)+ &
//										'* Ctrl='+lc.of_String(ab_cntrlpressed) + &
//										'* Shift='+lc.of_String(ab_shiftpressed) + &
//										'* lbutton = '+lc.of_String(ib_lbuttonpressed)+ &
//										'* rbutton = '+lc.of_String(ib_rbuttonpressed))

//////////////////////////////////////////////////////////////////////////////
// On the first part of the 'IF' statement:
// 	If the LEFTBUTTON is pressed, the CNTRL key down, and the SHIFT is up - Then
//		according to Win95 the processing will be performed (by this same function)
//		when the Button is released.	
//	On the second part of the 'IF' statement:
// 	If the BUTTON is pressed, the CNTRL key down, and the SHIFT is up - Then
//		according to Win95 the processing will be performed (by this same function)
//		when the Button is released.	
//////////////////////////////////////////////////////////////////////////////
If ((ib_lbuttonpressed or ib_rbuttonpressed) And ab_cntrlpressed And ab_shiftpressed=False) Or &
	(idw_requestor.IsSelected(al_row) And ib_lbuttonpressed And &
	ab_cntrlpressed=False And ab_shiftpressed=False)  Then
	// Wait for the button up to process click.
	lb_waitforbuttonup = True
ElseIf idw_requestor.IsSelected(al_row) And ib_rbuttonpressed And &
	ab_cntrlpressed=False And ab_shiftpressed=False  Then
	// Right Clicking on an already Highlighted row requires a No Action process.
	lb_takenoaction = True
End If

If lb_waitforbuttonup Then
	// Handle processing when the Button is released.
	il_prevclickedrow  = al_row
	ib_prevcntrl = ab_cntrlpressed
	ib_prevshift = ab_shiftpressed
	// gnv_app.inv_debug.of_Message(	'Wait for button up process.')	
	Return 1
End If

// There is no Previous row information.
il_prevclickedrow  = 0
ib_prevcntrl = False
ib_prevshift = False

If lb_takenoaction Then
	// Take the No Action Process.
	// @@
	// gnv_app.inv_debug.of_Message(	'No Action process.')
	Return 1
End If

//////////////////////////////////////////////////////////////////////////////
// Perform now.  This is either:
//		1) Processing that does not wait for the Left Button to be released.
//		or
//		2) Processing which waited for the Left Button to be released.
//			The lbuttonup event then called this function with the following
//			variables: (il_prevclickedrow, il_prevcntrl, il_prevshift)
//////////////////////////////////////////////////////////////////////////////

If ab_cntrlpressed And ab_shiftpressed=False Then
	// Select or De-Select (as appropriate) the current row.
	idw_requestor.SelectRow ( al_row, Not idw_requestor.IsSelected(al_row) ) 

	//-----------MOdification on 11-15-2005 By Dan
	// Store new Anchor Row.
	il_anchorrow = al_row
	//--------------------------------------------

ElseIf ab_cntrlpressed Or ab_shiftpressed Then

	/* Note: The valid combinations here are:											*/
	/*					ab_cntrlpressed=True  and ab_shiftpressed=True				*/
	/*					ab_cntrlpressed=False and ab_shiftpressed=True				*/
	/*					ab_cntrlpressed=True  and ab_shiftpressed=False	+++++++	*/	
	/*		+++++++ Because of the "If" prior to this "ElseIf", it is 			*/
	/* 	impossible for ab_cntrlpressed=True and ab_shiftpressed=False.		*/
	
	If ab_cntrlpressed=False Then
		//Clear all previously selected rows.	
		idw_requestor.SelectRow (0, false)	
	End If
	
	// If there is no anchor row, then only select the row that was clicked.
	If il_anchorrow	= 0 Then
		idw_requestor.SelectRow ( al_row, TRUE )
		il_anchorrow = al_row
	Else
		// Prevent flickering.  Improve performance.
		idw_requestor.SetReDraw ( FALSE ) 

		// Select all rows in between anchor row and current row */
		If il_anchorrow > al_row Then
			FOR li_i = il_anchorrow to al_row STEP -1
				idw_requestor.SelectRow ( li_i, TRUE )	
			NEXT
		Else
			FOR li_i = il_anchorrow to al_row
				idw_requestor.SelectRow ( li_i, TRUE )	
			NEXT 
		END If 

		// Prevent flickering.  Improve performance.
		idw_requestor.SetReDraw ( TRUE ) 
	END If
	
Else
	// Unselect all previous rows (if any) and select the current row.
	of_RowSelectSingle (al_row)

	// Store new Anchor Row.
	il_anchorrow = al_row
	
End If
	
// Make the row the current row.
If idw_Requestor.GetRow() <> al_row Then
	idw_Requestor.SetRow ( al_row ) 
End If	
		
Return 1
end function

on n_cst_dwsrv_rowselection.create
call super::create
end on

on n_cst_dwsrv_rowselection.destroy
call super::destroy
end on

