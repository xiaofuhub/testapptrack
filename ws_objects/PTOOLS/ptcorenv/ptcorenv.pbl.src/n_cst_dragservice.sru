$PBExportHeader$n_cst_dragservice.sru
forward
global type n_cst_dragservice from nonvisualobject
end type
end forward

global type n_cst_dragservice from nonvisualobject
event type integer ue_notifysource ( dragobject adrg_requester )
event type integer ue_begindrag ( )
end type
global n_cst_dragservice n_cst_dragservice

type variables
DragObject 	idrg_requester				//the object the service belongs to
end variables

forward prototypes
public function integer of_setdragicon ()
public function integer of_clicked (integer ai_xpos, integer ai_ypos)
public subroutine of_clicked (integer ai_xpos, integer ai_ypow, long al_row, dwobject adwo_dwo)
public function integer of_dragdrop (dragobject adrg_source)
public function integer of_dragdrop (dragobject adrg_source, long al_row, dwobject adwo_dwo)
public function integer of_setrequester (dragobject adrg_requester)
end prototypes

event type integer ue_notifysource(dragobject adrg_requester);//
return 1
end event

event type integer ue_begindrag();/***************************************************************************************
NAME: 	ue_beginDrag		

ACCESS:			public				
		
ARGUMENTS: 		
							(none)

RETURNS:		Integer
	
DESCRIPTION:   puts the window into dragmode after the clicked processing takes place.
Also sets the drag icon if requester has the events
Returns 1 if sucess, otherwise returns -1
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury and Dan 7/29/05
	

***************************************************************************************/


int		li_returnValue
 

IF isValid(idrg_requester) THEN 
	this.of_setDragIcon()
	idrg_Requester.post drag(Begin!)
	li_returnValue = 1
ELSE
	li_returnValue = -1
END IF


return li_returnValue
end event

public function integer of_setdragicon ();/***************************************************************************************
NAME: 		of_setdragIcon	

ACCESS:		public	
		
ARGUMENTS: 		
							(none)

RETURNS:			integer
	
DESCRIPTION:	if the idrg_requester has an event to set its drag icon
	then this will return true and allow the logic in 
	ue_setDragIcon to execute.
	
	Returns 1 if success -1 if fails
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : 7-29-05 Dan and Maury
	

***************************************************************************************/


IF idrg_requester.triggerEvent("ue_setDragIcon") = 1 THEN
	return 1
ELSE
	return -1
END IF
end function

public function integer of_clicked (integer ai_xpos, integer ai_ypos);//no definition for general clicking functionality on generic dragobject
return 1
end function

public subroutine of_clicked (integer ai_xpos, integer ai_ypow, long al_row, dwobject adwo_dwo);this.Event ue_beginDrag()


end subroutine

public function integer of_dragdrop (dragobject adrg_source);/***************************************************************************************
NAME: 		of_dragdrop	

ACCESS:		public	
		
ARGUMENTS: 		
							(dragobject)

RETURNS:			Integer
	
DESCRIPTION:	underloaded dragdrop function that passes null to the overloaded dragdrop
			for ease of use on generic dragable objects.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan and Maury	7-29-05
	

***************************************************************************************/
long 		ll_null
dwObject ldwo_null

setNull(ll_null)
setNull(ldwo_null)
this.of_DragDrop(adrg_source, ll_null, ldwo_null)

return 1
end function

public function integer of_dragdrop (dragobject adrg_source, long al_row, dwobject adwo_dwo);/***************************************************************************************
NAME: 	of_dragdrop		

ACCESS:	public		
		
ARGUMENTS: 		
							(dragobject, long, dwobject)

RETURNS:		Integer	
	
DESCRIPTION:	attempts to trigger dropnotify with no arguments to test if the source dragobject
	has it implemented.  If it does, it calls the event, passing all the knowledge about this object
	to it.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :Dan and Maury	7-29-05
	

***************************************************************************************/

int 	li_return

IF adrg_source.triggerEvent("ue_dropnotify") = 1 THEN
	adrg_source.dynamic EVENT ue_dropNotify(idrg_requester, al_row, adwo_dwo, this)
	li_return = 1
ELSE
	li_return =-1
END IF

return li_return
end function

public function integer of_setrequester (dragobject adrg_requester);/***************************************************************************************
NAME: 		of_setRequester	

ACCESS:		public	
		
ARGUMENTS: 		
							(dragobject)

RETURNS:			Integer
	
DESCRIPTION:	if the requester is not valid then it sets the idrg_requester to the adrg_requester
	Returns 1 if successful request made, -1 otherwise
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :	Dan and Maury	7-29-05
	

***************************************************************************************/

IF NOT isValid(idrg_requester) THEN
	idrg_requester = adrg_requester
   return 1
ELSE
	return -1
END IF

end function

on n_cst_dragservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dragservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

