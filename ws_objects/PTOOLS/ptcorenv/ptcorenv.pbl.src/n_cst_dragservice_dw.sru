$PBExportHeader$n_cst_dragservice_dw.sru
forward
global type n_cst_dragservice_dw from n_cst_dragservice
end type
end forward

global type n_cst_dragservice_dw from n_cst_dragservice
event ue_dragleave ( dragobject adrg_source )
event type integer ue_dragscroll ( dragobject adrg_source )
event ue_dragwithin ( dragobject adrg_source,  long al_row,  dwobject ado_dwo )
event ue_dragenter ( dragobject adrg_source )
end type
global n_cst_dragservice_dw n_cst_dragservice_dw

type variables
PUBLIC:

Boolean				ib_dragScroll
Boolean				ib_dragScrollMode
Constant String 	cs_focusIndicator_hand = "HAND"
Constant String 	cs_focusIndicator_rectangle = "RECTANGLE"
Constant String 	cs_focusIndicator_off = "OFF"
Constant String	cs_focusIndicator_bluebar = "BB"
RowFocusInd			irf_currentIndicatorMode
String				is_CurrentIndicatorMode
u_dw		 			idw_requester
end variables

forward prototypes
public function integer of_hideindicator ()
public function integer of_setrequester (datawindow adw_requester)
public function boolean of_setdragscroll (boolean ab_togglescroll)
public function integer of_dragdrop (dragobject adrg_source, long al_row, dwobject adwo_dwo)
public function boolean of_getdragscrollmode ()
public function string of_getindicatormode ()
public function integer of_setindicatormode (string as_indicatortype)
public function integer of_showindicator ()
end prototypes

event ue_dragleave(dragobject adrg_source);/***************************************************************************************
NAME: 	ue_dragleave	

ACCESS:	public
		
ARGUMENTS: 	
							(dragobject)

RETURNS:		nothing
	
DESCRIPTION:	turns the rowfocus indicator off and sets dragscroll to false so that
drag scrolling stops
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : 7/29/05 Maury and Dan
	

***************************************************************************************/


ib_dragScroll = FALSE

IF isValid(idw_Requester) THEN
	idw_Requester.SetRowFocusIndicator(OFF!)
END IF
end event

event type integer ue_dragscroll(dragobject adrg_source);/***************************************************************************************
NAME: 		ue_dragScroll 			

ACCESS:		Public	
		
ARGUMENTS: 		
				dragObject: any dragable object

RETURNS:		INTEGER(1)	
	
DESCRIPTION: Service allows an object to scroll through a u_dw by draggin over the 
	Top and Bottom of the requester. 
	
	If the pointery of the window is close to the to bottom of the
	window and still inside of the window (dragLeave has not been fired), then set the current row to 
	the last row on the page and scroll one row down. ue_dragscroll will call itselft until it reaches the	
	last possilbe row or the pointer leaves the window
	
	If the pointery of the window is close to the to top of the
	window and still inside of the window (dragLeave has not been fired), then set the current row to 
	the first row on the page and scroll one row up. ue_dragscroll will call itselft until it reaches the	
	first row or the pointer leaves the window.
	
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : 
	Created: 7/29/05	By Maury
	

***************************************************************************************/

String 	ls_idw_requesterValue
String 	ls_modResult
BOOLEAN 	lb_StopScroll = TRUE
String 	ls_rowHeight
time 		lt_timeBegin
time 		lt_timeEnd
Long 		ll_difference
Long		ll_upperScrollThreshold //the threshold of a pointer value in which the scrolling up begins
Long			ll_LowerScrollThreshold  //the threshold of a pointer value in which the scrolling up begins

Constant Int 		ci_heightOfTitleBar = 96 //assumes that the title bar is 96 power units
n_cst_datetime		lnv_time

ls_rowHeight = idw_requester.Describe("DataWindow.Detail.Height")


// Yields to allow DragLeave to Fire so that scrolling will stop when pointer is leaving the dw
Yield()

ll_lowerScrollThreshold = idw_requester.height -150//- Integer(ls_rowHeight)
ll_upperScrollThreshold = Integer(ls_rowHeight)

IF ib_dragScroll THEN
		
		//If the Pointery exceeeds the desired lower scrolling threshold then start scrolling down
		IF idw_requester.Pointery() >= ll_lowerScrollThreshold THEN
			
			//sets the row to the last visible row and scrolls down from there
			idw_requester.SetRow ( Long ( idw_requester.Describe ( "DataWindow.LastRowOnPage" ) ) )
			idw_requester.ScrollNextRow()
			
			//wait some time
			lt_timeBegin = Now()
			ll_difference = 0
			do while ll_difference < 200
				lt_timeEnd = Now()
				ll_difference = lnv_time.of_millisecsafter( lt_timeBegin, lt_timeEnd)
			loop
			
			lb_StopScroll = FALSE
			
			//If getrow() = the last row possible then you have reached the last row so lb_stopscroll is set to true
			//If the pointer is below the height of the window - ci_heightOfTitleBar then set lb_stopscroll to true
			IF  idw_requester.Getrow() = idw_requester.rowCount() OR idw_requester.pointery() >= idw_requester.height - ci_heightOfTitleBar THEN 
				lb_StopScroll = TRUE
			END IF
		
		//If the Pointery exceeeds the desired upper scrolling threshold, then start scrolling up
		ELSEIF idw_requester.Pointery() <= ll_upperScrollThreshold THEN
			
			//sets the row to the first visible row and scrolls up from there
			idw_requester.SetRow ( Long ( idw_requester.Describe ( "DataWindow.FirstRowOnPage" ) ) )
			idw_requester.ScrollPriorRow()
			
			//wait some time
			lt_timeBegin = Now()
			ll_difference = 0
			do while ll_difference < 200
				lt_timeEnd = Now()
				ll_difference = lnv_time.of_millisecsafter( lt_timeBegin, lt_timeEnd)
			loop

			lb_StopScroll = FALSE
			
			//If getrow() = 1 then you have reached the max scrolling so lb_stopscroll is set to true
			//If the pointer is above the ci_heightOfTitleBar then set lb_stopscroll to true
			IF  idw_requester.Getrow() = 1 OR idw_requester.pointery() <= ( 0 - ci_heightOfTitleBar ) THEN
				lb_StopScroll = TRUE
			END IF
			
		END IF
END IF
	
/*ls_modResult = "DataWindow.Detail.Color='255 ~t If(currentRow() = getRow(), rgb(225,225,225), rgb(255,255,255))'"
idw_requester.Modify(ls_modResult)*/

IF NOT lb_StopScroll THEN
	//Uncertain why this yield is necessary, but it provides better performance
	Yield()
	this.Event Post ue_DragScroll (adrg_source )
END IF

RETURN 1


end event

event ue_dragwithin(dragobject adrg_source, long al_row, dwobject ado_dwo);/***************************************************************************************
NAME: ue_dragwithin			

ACCESS:	Public
		
ARGUMENTS: 	(dragobject, long, dwo)

RETURNS:			Nothing
	
DESCRIPTION:	Checks to see if the source is the same as the window that this service object 
belongs to and calls	of_showIndicator() if it is not.  forwards the argument toue_dragscroll to
handle scrolling.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury and Dan
	

***************************************************************************************/


IF adrg_source <> idw_requester THEN
	
	idw_Requester.SetRow(al_Row)

	
	IF ib_dragScrollMode = TRUE THEN
		ib_dragScroll = TRUE
		this.EVENT ue_dragscroll(adrg_source)
	END IF
	
END IF

end event

event ue_dragenter(dragobject adrg_source);u_dw	temp

IF isValid(idw_Requester) THEN
	IF adrg_source <> idw_requester THEN
		This.of_ShowIndicator()
	END IF
END IF
end event

public function integer of_hideindicator ();/***************************************************************************************
NAME: 		of_hideIndicator()		

ACCESS:		Public	
		
ARGUMENTS: 		
							none

RETURNS:		Integer	
				
DESCRIPTION:	Hides the indicator of the u_dw that this service is a part of.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created 7-29-05  By Maury and Dan
	

***************************************************************************************/


int 	li_return

IF isValid(idw_Requester) THEN
	li_return = idw_Requester.setRowFocusIndicator(OFF!)
ELSE
	li_Return = -1
END IF

return li_return
end function

public function integer of_setrequester (datawindow adw_requester);/***************************************************************************************
NAME: of_setRequester			

ACCESS:			
		
ARGUMENTS: (datawindow)		
							

RETURNS: Integer
	
DESCRIPTION: Sets idw_requester to the object in which the service belongs.  Return
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	

***************************************************************************************/
IF NOT isValid(idrg_requester) THEN
	idrg_requester = adw_requester
	idw_requester = adw_requester
   return 1
ELSE
	return -1
END IF




end function

public function boolean of_setdragscroll (boolean ab_togglescroll);/***************************************************************************************
NAME: 		of_setDragScroll()	

ACCESS:		Public
		
ARGUMENTS: 	Boolean Value True or False
							

RETURNS:		Boolean	
	
DESCRIPTION: 	Sets  dragscroll ability to whatever the user wants, and
	Returns whatever it was before the user changed it.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created 7-29-05 		By Maury and Dan
	

***************************************************************************************/
Boolean 	lb_previous

lb_previous = ib_dragScrollMode
ib_dragScrollMode = ab_toggleScroll
return lb_previous
end function

public function integer of_dragdrop (dragobject adrg_source, long al_row, dwobject adwo_dwo);/***************************************************************************************
NAME: 		of_dragdrop	

ACCESS:		public	
		
ARGUMENTS: 		
							(dragobject, long, dwobject)

RETURNS:			integer
	
DESCRIPTION:	For any datawindows, all scrolling should stop after the drop has occured.
		Setting ib_dragScroll to false fixes the problem of continued dragscrolling after an
		object is dropped while the mouse still hasn't moved.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan and Maury	7-29-05
	

***************************************************************************************/

ib_dragScroll = false

int 	li_return

IF adrg_source.triggerEvent("ue_dropnotify") = 1 THEN
	adrg_source.dynamic EVENT ue_dropNotify(idrg_requester, al_row, adwo_dwo, this)
	li_return = 1
ELSE
	li_return =-1
END IF

return li_return


end function

public function boolean of_getdragscrollmode ();return ib_dragScrollMode
end function

public function string of_getindicatormode ();//returns the value of the current indicator mode selected for the u_dw
Return  is_CurrentIndicatorMode
end function

public function integer of_setindicatormode (string as_indicatortype);/***************************************************************************************
NAME: 		of_setIndicatorMode		

ACCESS:		Public
		
ARGUMENTS: 	sting as_type

RETURNS:		Integer
	
DESCRIPTION:	Sets the indicator mode to whatever the user specifies.

	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created 7-29-05  	By Maury and Dan
	

***************************************************************************************/

Int li_return

IF as_indicatortype = cs_focusindicator_hand THEN
	is_CurrentIndicatorMode = cs_focusindicator_hand
	irf_currentIndicatorMode = Hand!
ELSEIF as_IndicatorType = cs_focusindicator_rectangle THEN
	irf_currentIndicatorMode = FocusRect!
	is_CurrentIndicatorMode = cs_focusindicator_rectangle
ELSEIF as_IndicatorType = cs_focusindicator_bluebar THEN
	is_CurrentIndicatorMode = cs_focusindicator_bluebar
	SetNull(irf_currentIndicatorMode)
ELSE
	is_CurrentIndicatorMode = cs_focusindicator_off
	irf_currentIndicatorMode = Off!
END IF

return 1
end function

public function integer of_showindicator ();/***************************************************************************************
NAME: 		of_showindicator

ACCESS:		public
		
ARGUMENTS: 		
							(none)

RETURNS:		Integer	
	
DESCRIPTION: Sets focus indicator on requestor
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : 7/29/05 Maury and Dan
	

***************************************************************************************/
Int 		li_return

IF isValid(idw_Requester) THEN
	IF NOT isNull(irf_CurrentIndicatorMode) THEN
		li_Return = idw_requester.SetRowFocusIndicator(irf_currentindicatormode )
	ELSE
		IF is_CurrentIndicatorMode = cs_focusindicator_bluebar THEN
			idw_Requester.of_FocusIndicatorOn()
		END IF
	END IF
ELSE
	li_Return = -1
END IF

Return li_Return




end function

on n_cst_dragservice_dw.create
call super::create
end on

on n_cst_dragservice_dw.destroy
call super::destroy
end on

