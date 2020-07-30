$PBExportHeader$n_cst_dwsrv_mouseover.sru
forward
global type n_cst_dwsrv_mouseover from n_cst_dwsrv
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//Long	sl_XThreshHold = -1
//Long	sl_YThreshHold = -1
////end modification Shared Variables by appeon  20070730
end variables

global type n_cst_dwsrv_mouseover from n_cst_dwsrv
event ue_timer ( )
event ue_clicked ( )
end type
global n_cst_dwsrv_mouseover n_cst_dwsrv_mouseover

type variables
Private n_cst_Timer	inv_Timer 
Public n_cst_msg		inv_Msg
Private 	Integer		ii_Interval = 1
Constant String		cs_RowResponse = "[row]"
Constant String		cs_TextType = "text"
Constant String		cs_DwType = "dw"
Constant String		cs_Background = "background~t0" //GetObjectAtPoiner returns this string when there is no object

Private Window			iw_Parent
Private w_InfoFlag	iw_InfoFlag
Private u_dw			idw_DwPopup
Private String			is_LastObject
Private Boolean		ib_PointerInPopup = FALSE
Private Boolean		ib_PointerInInfoFlag = FALSE
Private Boolean		ib_TimerOn

n_cst_string 			inv_StringService

n_ds		ids_Temp

//begin modification Shared Variables by appeon  20070730
Long	sl_XThreshHold = -1
Long	sl_YThreshHold = -1
//end modification Shared Variables by appeon  20070730






end variables

forward prototypes
public function integer of_mouseoveron ()
public function integer of_mouseoveroff ()
public function integer of_setinterval (integer ai_interval)
public function integer of_getinterval ()
public function integer of_setdwresponse (string as_object, datawindow adw_target)
public function integer of_setdwresponse (datawindow adw_target)
public function integer of_setparentwindow (window aw_parent)
public function integer of_popdw (long al_xpos, long al_ypos, datawindow adw_dw)
public function integer of_settextresponse (string as_object, string as_expression)
public function integer of_settextresponse (string as_expression)
public function integer of_popinfoflag (long al_xpos, long al_ypos, string as_text)
public function boolean of_ispointerinpopup ()
public function string of_getcolumntagexpression (string as_column)
public function string of_getrowtagexpression ()
public function integer of_gettextresponse ()
public function long of_calculategrouprow ()
public function integer of_resetpopup (u_dw adw_popup)
public function boolean of_ispointerininfoflag ()
public function boolean of_ismouseoveron ()
public function boolean of_checktextthreshhold (long al_width, long al_height)
public function boolean of_checkdwthreshhold (long al_width, long al_height)
public function integer of_getdwresponse (datawindow adw_dw)
end prototypes

event ue_timer();/***************************************************************************************
NAME: 	ue_Timer

ACCESS:	Public
		
ARGUMENTS: 	(none)

RETURNS:		none	
	
DESCRIPTION:
				This Event is triggered at a sepcified interval of seconds by the 
				inv_Timer object. 
				
				First checks if the Pointer is over a currently open dw popup.
				IF Not, continues rest of popup logic, Otherwise do nothing while the pointer
				is over the dw popup
				
				Rest of popup logic: 
					Check to see if the current object at the pointer is equal to the object at pointer	
					the last time this event was triggered (interval seconds ago)
					-If current object is not equal to last object and popup is visible, then set it to invisible 
					-If current object is equal to last object then the pointer has not changed objects.
					  In this case, either a Dw or InfoFlag (text) is Poped up depending on the response type
					
						Outer For Loop:
						Checks if there is a row response or column response
						(column response overrides row response)
							Inner For Loop:
							Checks to see if ther is a dw or text response
							and popUP the correct datawindow/infoflag based on the response
							(datawindow response overrides text response)
							
							
			A response can Either be set Programically via of_SetDwResponse() and of_SetTextResponse()
								OR
			Manually Via a Tag expression for a Dw column or a Tag expression in a textbox called
			'mouseovertext' for a Dw row


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/5/05

***************************************************************************************/
String 	ls_CurrentObject
String	ls_CurrentBand
Long		ll_CurrentY
Long		ll_CurrentX
String 	ls_ErrorMessage = ""
Integer 	li_MsgReturn
String	la_CurrentObject[]
String	ls_CurrentColumn = ""
Long		ll_CurrentRow = 0
Integer	li_CurrentObjectSize
Boolean  lb_isPointerInPopup
Boolean	lb_isPointerInInfoFlag
Boolean	lb_Band = FALSE
String	ls_Expression
String	ls_PopupText = ""
Integer	li_Check = 1
String	ls_ParmLabel
Integer	li_RefreshReturn


Long		ll_Index
Long		ll_Index2
Boolean 	lb_Found
u_dw    	ldw_TempDw
u_dw		ldw_Master


s_parm			lstr_Parm
s_parm			lstr_ResponseType

IF NOT isValid(iw_InfoFlag) THEN
	Open(iw_InfoFlag, iw_Parent)
	iw_InfoFlag.visible = FALSE
END IF

lb_isPointerInPopup = This.of_IsPointerInPopup()
lb_isPointerInInfoFlag = This.of_IsPointerInInfoFlag()

//If the pointer is not in the DWPopup, then begin Popup logic
IF NOT lb_isPointerInPopup AND NOT lb_isPointerInInfoFlag THEN
	
	IF isValid(idw_Requestor) THEN
		ls_CurrentObject = idw_Requestor.GetObjectAtPointer()
		IF ls_CurrentObject = cs_Background  OR ls_CurrentObject = ""THEN
			ls_CurrentObject = idw_Requestor.GetBandAtPointer()
			lb_Band = TRUE
		ELSE
			lb_Band = FALSE
		END IF
	END IF
	
	//parse the ls_CurrentObject into an array that will hold the column in [1] and the row in [2]
	li_CurrentObjectSize = inv_StringService.of_parsetoarray( ls_CurrentObject,"~t", la_CurrentObject )
	IF li_CurrentObjectSize > 0 THEN
		ls_CurrentColumn = la_CurrentObject[1]
		//IF the current object came from the band, make sure it is the detail
		IF lb_Band AND ls_CurrentColumn <> "detail" THEN
			ls_CurrentObject = ""
		END IF
		ll_CurrentRow = Integer(la_CurrentObject[2])
		
		IF ll_CurrentRow = 0 THEN
			ll_CurrentRow = This.of_CalculateGroupRow() //Account for groups
		END IF
	END IF
	//the current position of the mouse
	ll_CurrentY = iw_Parent.PointerY()
	ll_CurrentX = iw_Parent.PointerX()

	//IF the Current object at the pointer is equal to the Last pointer at object
	//And the current object is not invalid - Check for a Column or Row response
	IF  ls_CurrentObject =  is_LastObject AND ls_CurrentObject <> "" THEN
		FOR li_Check = 1 TO 2 // 1 = Checking for a Column Response, 2 = Checking for a Row response
			
			IF li_Check = 1 THEN
				ls_ParmLabel = ls_CurrentColumn
				ls_Expression = This.of_GetColumnTagExpression( ls_CurrentColumn ) 
			ELSE
				ls_ParmLabel = cs_RowResponse
				ls_Expression = This.of_GetRowTagExpression()
			END IF
			///---------find correct response in inv_msg to pop up-------------
			lb_Found = FALSE
			FOR ll_Index = 1 TO 2 //1 = Checking for "dw", 2 = checking for "text"
				FOR ll_Index2 = 1 TO inv_Msg.of_get_count( )
					inv_Msg.of_get_parm( ll_Index2 , lstr_parm)
					//If the lstr_parm.is_label at current index = ls_ParmLabel, check if there are any
					//DW or Text Responses
					IF lstr_parm.is_label = ls_ParmLabel THEN
						lstr_ResponseType = lstr_Parm.ia_value
						IF ll_Index = 1 THEN
							//IF there is a datawindow response with a valid linkage, it should take precedence
							//so exit inner and outer loop
							IF lstr_ResponseType.is_label = "dw" THEN
								// IF linkage and master is valid, use this response
								ldw_TempDw = lstr_ResponseType.ia_value
								IF isValid(ldw_TempDw.inv_Linkage) THEN
									ldw_TempDw.inv_Linkage.of_getMaster(ldw_Master)
									IF isValid(ldw_Master)THEN
										lb_Found = TRUE
										EXIT	
									END IF
								END IF
							END IF
						ELSEIF ll_Index = 2 THEN
							//IF there is a text response found, exit the loop and use that response
							IF lstr_ResponseType.is_label = "text" THEN
								EXIT
							END IF
						END IF
					END IF
				NEXT

				IF lb_Found = TRUE THEN
					EXIT
				END IF
			NEXT
			
			//---------end find correct response in inv_msg to pop up -----------------------
			
			IF lstr_ResponseType.is_Label = cs_Dwtype THEN
				
				//lstr_ResponseType.ia_value holds the actual datawindow to be poped up
				idw_DwPopup = lstr_ResponseType.ia_value
				// Display pop-up if it is not already visible 
				IF IsValid ( idw_DwPopup ) THEN
					
					IF IsValid ( idw_DwPopup.inv_Linkage ) AND idw_DwPopup.visible = FALSE THEN
						
						//If idw_Popup.Visible = TRUE, the popup has already been displayed, and we don't
						//need to show it again.  When the user moves the pointer to a different row, the
						//popup is first hidden (ls_CurrentObject <> is_LastObject), and then redisplayed.
					
						//scrolls row of dw popup to the row corresponding to the pointer
						li_RefreshReturn = idw_DwPopup.inv_linkage.of_Refresh(ll_CurrentRow)
						IF li_RefreshReturn <> -1 THEN
							//Pop DataWindows that are within the area threshold of the system setting
							IF of_CheckDwThreshHold(idw_DwPopUp.Width, idw_DwPopUp.Height) THEN
								IF isValid(idw_Requestor) THEN
									IF idw_Requestor.Visible = TRUE THEN
										This.of_PopDw(ll_CurrentX, ll_CurrentY, idw_DwPopup)
									END IF
								END IF
							END IF
						END IF
					END IF
					
				END IF
				EXIT // There is a datawindow response, so all other expressions are not diplayed
				
			ELSE
				//If there is a text response in lstr_ResponseType.is_Label, then we want to display that
				//expression instead of the manual expression from the Tag
				IF lstr_ResponseType.is_Label = cs_TextType THEN
					ls_Expression = lstr_ResponseType.ia_value
				END IF
				
				
				//If An expression was found then evaluate the expression and Popup the correct Text
				IF NOT isNull(ls_Expression) AND Len(ls_Expression) > 0 THEN
					ids_Temp.DataObject = idw_Requestor.DataObject
					ids_Temp.Reset() //Copy Rows into temp ds to evaluate expression (with no "invalid expression" popup)
					idw_Requestor.RowsCopy(1, idw_Requestor.RowCount(), Primary!, ids_Temp, 1, Primary!)
					ls_Expression = inv_StringService.of_GlobalReplace ( ls_Expression, "'", "~~~'" )
					ls_PopupText = ids_Temp.Describe ( "Evaluate('" + ls_Expression + "'," + String(ll_CurrentRow) + ")")
					IF ls_PopupText > "" AND NOT isNull(ls_PopupText) AND iw_InfoFlag.visible = FALSE THEN
						//if the Describe is valid then pop infoflag
						IF ls_PopupText <> "?" AND ls_PopupText <> "!" THEN
							iw_InfoFlag.of_Resize(ls_PopupText)
							IF of_CheckTextThreshHold(iw_InfoFlag.Width, iw_InfoFlag.Height) THEN
								IF isValid(idw_Requestor) THEN
									IF idw_Requestor.Visible = TRUE THEN
										This.of_PopInfoFlag(ll_CurrentX, ll_CurrentY, ls_PopupText)
									END IF
								END IF
							END IF
						END IF
					END IF
					EXIT //InfoFlag has been displayed, so fall out
				END IF
			END IF
				
		NEXT
		//The Pointer has moved to another object or is outside the datawindow, and DW/InfoFlag should be set to invisible
	ELSE
		IF isValid(idw_DwPopup) THEN
			IF idw_DwPopUp.Visible THEN
				idw_DwPopup.Visible = FALSE
				SetNull(idw_DwPopup)
			END IF
		END IF
		IF isValid(iw_InfoFlag)THEN
			IF iw_InfoFlag.Visible THEN
				iw_InfoFlag.Visible = FALSE
			END IF
		END IF
	END IF 
ELSE
	//Do nothing While the Pointer is within the DwPopup or InfoFlag
END IF


//set the last object to compare after the timer goes off
is_LastObject = idw_Requestor.GetObjectAtPointer()
IF is_LastObject = cs_Background OR is_LastObject = "" THEN
	is_LastObject = idw_Requestor.GetBandAtPointer()
END IF


end event

event ue_clicked();/***************************************************************************************
NAME: 	ue_Clicked

ACCESS:	Public
		
ARGUMENTS: 	(none)

RETURNS:		none	
	
DESCRIPTION:
				
				First checks if the Pointer is over a currently open dw popup.
				IF Not, continues rest of popup logic, Otherwise do nothing while the pointer
				is over the dw popup
				
				Rest of popup logic: 
					Check to see if the current object at the pointer is equal to the object at pointer	
					the last time this event was triggered (interval seconds ago)
					-If current object is not equal to last object and popup is visible, then set it to invisible 
					-If current object is equal to last object then the pointer has not changed objects.
					  In this case, either a Dw or InfoFlag (text) is Poped up depending on the response type
					
						Outer For Loop:
						Checks if there is a row response or column response
						(column response overrides row response)
							Inner For Loop:
							Checks to see if ther is a dw or text response
							and popUP the correct datawindow/infoflag based on the response
							(datawindow response overrides text response)
							
							
			A response can Either be set Programically via of_SetDwResponse() and of_SetTextResponse()
								OR
			Manually Via a Tag expression for a Dw column or a Tag expression in a textbox called
			'mouseovertext' for a Dw row


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 11/8/05

***************************************************************************************/



String 	ls_CurrentObject
String	ls_CurrentBand
Long		ll_CurrentY
Long		ll_CurrentX
String 	ls_ErrorMessage = ""
Integer 	li_MsgReturn
String	la_CurrentObject[]
String	ls_CurrentColumn = ""
Long		ll_CurrentRow = 0
Integer	li_CurrentObjectSize
Boolean	lb_Band = FALSE
String	ls_Expression
String	ls_PopupText = ""
Integer	li_Check = 1
String	ls_ParmLabel
Integer	li_RefreshReturn


Long		ll_Index
Long		ll_Index2
Boolean 	lb_Found
u_dw    	ldw_TempDw
u_dw		ldw_Master


s_parm			lstr_Parm
s_parm			lstr_ResponseType

IF NOT isValid(iw_InfoFlag) THEN
	Open(iw_InfoFlag, iw_Parent)
END IF

iw_InfoFlag.visible = FALSE

IF isValid(idw_DwPopup) THEN
	idw_DwPopup.Visible = FALSE // Hide Old Popup to prevent it from stying open
END IF

IF isValid(idw_Requestor) THEN
	ls_CurrentObject = idw_Requestor.GetObjectAtPointer()
	IF ls_CurrentObject = cs_Background  OR ls_CurrentObject = ""THEN
		ls_CurrentObject = idw_Requestor.GetBandAtPointer()
		lb_Band = TRUE
	ELSE
		lb_Band = FALSE
	END IF
END IF

//parse the ls_CurrentObject into an array that will hold the column in [1] and the row in [2]
li_CurrentObjectSize = inv_StringService.of_parsetoarray( ls_CurrentObject,"~t", la_CurrentObject )

IF li_CurrentObjectSize > 0 THEN
	ls_CurrentColumn = la_CurrentObject[1]
	//IF the current object came from the band, make sure it is the detail
	IF lb_Band AND ls_CurrentColumn <> "detail" THEN
		ls_CurrentObject = ""
	END IF
	ll_CurrentRow = Integer(la_CurrentObject[2])
	
	IF ll_CurrentRow = 0 THEN
		ll_CurrentRow = This.of_CalculateGroupRow() //Account for groups
	END IF
END IF

//the current position of the mouse
ll_CurrentY = iw_Parent.PointerY()
ll_CurrentX = iw_Parent.PointerX()

//IF the Current object at the pointer is not the background
IF ls_CurrentObject <> "" THEN
	FOR li_Check = 1 TO 2 // 1 = Checking for a Column Response, 2 = Checking for a Row response
		
		IF li_Check = 1 THEN
			ls_ParmLabel = ls_CurrentColumn
			ls_Expression = This.of_GetColumnTagExpression( ls_CurrentColumn ) 
		ELSE
			ls_ParmLabel = cs_RowResponse
			ls_Expression = This.of_GetRowTagExpression()
		END IF
		///---------find correct response in inv_msg to pop up-------------
		lb_Found = FALSE
		FOR ll_Index = 1 TO 2 //1 = Checking for "dw", 2 = checking for "text"
			FOR ll_Index2 = 1 TO inv_Msg.of_get_count( )
				inv_Msg.of_get_parm( ll_Index2 , lstr_parm)
				//If the lstr_parm.is_label at current index = ls_ParmLabel, check if there are any
				//DW or Text Responses
				IF lstr_parm.is_label = ls_ParmLabel THEN
					lstr_ResponseType = lstr_Parm.ia_value
					IF ll_Index = 1 THEN
						//IF there is a datawindow response with a valid linkage, it should take precedence
						//so exit inner and outer loop
						IF lstr_ResponseType.is_label = "dw" THEN
							// IF linkage and master is valid, use this response
							ldw_TempDw = lstr_ResponseType.ia_value
							IF isValid(ldw_TempDw.inv_Linkage) THEN
								ldw_TempDw.inv_Linkage.of_getMaster(ldw_Master)
								IF isValid(ldw_Master)THEN
									lb_Found = TRUE
									EXIT	
								END IF
							END IF
						END IF
					ELSEIF ll_Index = 2 THEN
						//IF there is a text response found, exit the loop and use that response
						IF lstr_ResponseType.is_label = "text" THEN
							EXIT
						END IF
					END IF
				END IF
			NEXT
			IF lb_Found = TRUE THEN
				EXIT
			END IF
		NEXT
		
		//---------end find correct response in inv_msg to pop up -----------------------
		
		IF lstr_ResponseType.is_Label = cs_Dwtype THEN
			
			//lstr_ResponseType.ia_value holds the actual datawindow to be poped up
			idw_DwPopup = lstr_ResponseType.ia_value
			
			// Display pop-up if it is not already visible 
			IF IsValid ( idw_DwPopup ) THEN
				IF IsValid ( idw_DwPopup.inv_Linkage ) AND NOT idw_DwPopup.visible THEN
					//If idw_Popup.Visible = TRUE, the popup has already been displayed, and we don't
					//need to show it again.  When the user clicks on a different row, the
					//popup is first hidden (ls_CurrentObject <> is_LastObject), and then redisplayed.
					
					 //If the row is not zero we can assume the linkage refreshed on the click
					IF ll_CurrentRow > 0 THEN
						This.of_PopDw(ll_CurrentX, ll_CurrentY, idw_DwPopup)
					END IF
				END IF
				
			END IF
			EXIT // There is a datawindow response, so all other expressions are not diplayed
			
		ELSE
			//If there is a text response in lstr_ResponseType.is_Label, then we want to display that
			//expression instead of the manual expression from the Tag
			IF lstr_ResponseType.is_Label = cs_TextType THEN
				ls_Expression = lstr_ResponseType.ia_value
			END IF
			
			
			//If An expression was found then evaluate the expression and Popup the correct Text
			IF NOT isNull(ls_Expression) AND Len(ls_Expression) > 0 THEN
				ids_Temp.DataObject = idw_Requestor.DataObject
				ids_Temp.Reset() //Copy Rows into temp ds to evaluate expression (with no "invalid expression" popup)
				idw_Requestor.RowsCopy(1, idw_Requestor.RowCount(), Primary!, ids_Temp, 1, Primary!)
				ls_Expression = inv_StringService.of_GlobalReplace ( ls_Expression, "'", "~~~'" )
				ls_PopupText = ids_Temp.Describe ( "Evaluate('" + ls_Expression + "'," + String(ll_CurrentRow) + ")")
				IF ls_PopupText > "" AND NOT isNull(ls_PopupText) AND iw_InfoFlag.visible = FALSE THEN
					//if the Describe was not invalid then pop infoflag
					IF ls_PopupText <> "?" AND ls_PopupText <> "!" THEN
						iw_InfoFlag.of_Resize(ls_PopupText)
						This.of_PopInfoFlag(ll_CurrentX, ll_CurrentY, ls_PopupText)
					END IF
				END IF
				EXIT //InfoFlag has been displayed, so fall out
			END IF
		END IF
		
	NEXT
END IF

//set the last object for ue_timer comparison purposes
is_LastObject = idw_Requestor.GetObjectAtPointer()
IF is_LastObject = cs_Background OR is_LastObject = "" THEN
	is_LastObject = idw_Requestor.GetBandAtPointer()
END IF

end event

public function integer of_mouseoveron ();Integer li_Return

IF isValid(inv_Timer) THEN
	inv_Timer.start(ii_Interval)
	ib_TimerOn = TRUE
	li_Return = 1
ELSE
	li_Return = -1
END IF
RETURN li_Return
end function

public function integer of_mouseoveroff ();Integer li_Return

IF isValid(inv_Timer) THEN
	inv_Timer.Stop()
	ib_TimerOn = FALSE
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_setinterval (integer ai_interval);Integer li_Return = 1

IF ai_interval > 0 THEN
	ii_Interval =	ai_interval
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_getinterval ();RETURN ii_Interval
end function

public function integer of_setdwresponse (string as_object, datawindow adw_target);/***************************************************************************************
NAME: 	of_SetDWResponse

ACCESS:	Public
		
ARGUMENTS: 	(String as_Object, DW adw_target)

RETURNS:		Integer
	
DESCRIPTION:   
				lstr_parm.isLabel is set to the parameter object string (either cs_RowResponse or a column name)
				
				lstr_parm.ia_value is set to lstr_ValueParm which holds the type of response ("dw") and
					the acual datawindow that will be displayed.
					
				Example: 
						lstr_ValueParm	
								is_Label = "em_id"
								ia_value =  lstr_ValueParm 
														is_Label = "dw" (cs_DwType)
														ia_Value = dw_1
				
				lstr_Parm is then added to inv_msg for later access
			

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/9/05
	

***************************************************************************************/


s_parm	lstr_Parm, &
			lstr_ValueParm

Integer 	li_Return = 1

as_Object = Trim(as_Object)

IF isValid(adw_Target) AND as_Object > "" THEN

	lstr_Parm.is_Label = as_Object
	
	lstr_ValueParm.is_Label = cs_DwType
	lstr_ValueParm.ia_Value = adw_Target
	
	lstr_Parm.ia_Value = lstr_ValueParm
	
	IF inv_msg.of_Add_Parm(lstr_Parm) = 1 THEN
		//OK
	ELSE
		li_Return = -1
	END IF
	
ELSE 
	li_Return = -1
	
END IF

RETURN li_Return
end function

public function integer of_setdwresponse (datawindow adw_target);/***************************************************************************************
NAME: 	of_SetDWResponse

ACCESS:	Public
		
ARGUMENTS: 	(datawindow adw_Target)

RETURNS:		Integer
	
DESCRIPTION:
			When setting a dw response for a row, only the target dw is necessary
			
			This function calls the overloaded setDwResponse() function with the constant "[row]" 
			as the string


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/9/05
	

***************************************************************************************/

Integer li_Return

li_Return = this.of_setDwResponse(cs_RowResponse, adw_Target)

RETURN li_Return
end function

public function integer of_setparentwindow (window aw_parent);Integer	li_Return = 1

IF IsValid ( aw_Parent ) THEN
	iw_Parent = aw_Parent
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_popdw (long al_xpos, long al_ypos, datawindow adw_dw);/***************************************************************************************
NAME: of_PopDw	

ACCESS:	Public
		
ARGUMENTS: (al_xpos, al_ypos, adw_dw)

RETURNS:	Integer
	
DESCRIPTION:	Sets the X and Y coordinates of a PopUp Dw and sets its visible property
					to True.  
					Also Checks if the Popup Dw x and y coordinates exceeds the parent window
					
					If Sucessful, return 1, otherwise return -1
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/5/05
	

***************************************************************************************/


Integer	li_Return = -1
Long		ll_DwYMax
Long		ll_DwXMax
Long		ll_ExceededDistance
Long		ll_ParentWidth
Long		ll_ParentHeight

ll_ParentWidth = iw_Parent.Width
ll_ParentHeight = iw_Parent.Height

IF isValid(adw_dw) THEN
	adw_Dw.X = al_Xpos
	adw_Dw.Y = al_Ypos + 50 //Set window below the mouse pointer (but close enough so that it's easy to move pointer into)
	
	
	ll_DwXMax = adw_Dw.X + adw_dw.Width
	//IF the Xmax Coord exceeds the width of the Parent window, move it to the left
	IF ll_DwXMax > ll_ParentWidth THEN
		ll_ExceededDistance = ll_DwXMax - ll_ParentWidth
		adw_Dw.X -= ll_ExceededDistance
	END IF
	
	ll_DwYMax = adw_Dw.Y + adw_dw.Height
	//IF the Ymax Coord exceeds the height of the Parent window, move it above the Pointer
	IF ll_DwYMax > ll_ParentHeight THEN
		adw_Dw.Y = al_Ypos - adw_Dw.Height
	END IF

	adw_dw.Visible = true				
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer of_settextresponse (string as_object, string as_expression);/***************************************************************************************
NAME: 	of_SetTextResponse

ACCESS:	Public
		
ARGUMENTS: 	(String as_Object, String as_Expression)

RETURNS:		Integer
	
DESCRIPTION:   
				lstr_parm.isLabel is set to the parameter object string (either cs_RowResponse or a column name)
				
				lstr_parm.ia_value is set to lstr_ValueParm which holds the type of response ("text") and
					the acual expression that will be evaluated.
					
				Example: 
						lstr_ValueParm	
								is_Label = "em_id"
								ia_value =  lstr_ValueParm 
														is_Label = "text" (cs_TextType)
														ia_Value = "em_ln + space(1) + em_fn"
				
				lstr_Parm is then added to inv_msg for later access
			

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/9/05

***************************************************************************************/




s_parm	lstr_Parm, &
			lstr_ValueParm

Integer 	li_Return = 1

as_Object = Trim(as_Object)

IF as_expression > "" AND as_Object > "" THEN

	lstr_Parm.is_Label = as_Object
	
	lstr_ValueParm.is_Label = cs_TextType
	lstr_ValueParm.ia_Value = as_expression
	
	lstr_Parm.ia_Value = lstr_ValueParm
	IF inv_msg.of_Add_Parm(lstr_Parm) = 1 THEN
		//OK 
	ELSE
		li_Return = -1
	END IF
	
ELSE 
	li_Return = -1
	
END IF

RETURN li_Return
end function

public function integer of_settextresponse (string as_expression);/***************************************************************************************
NAME: 	of_SetDWResponse

ACCESS:	Public
		
ARGUMENTS: 	(datawindow adw_Target)

RETURNS:		Integer
	
DESCRIPTION:
			When setting a text response for a row, only the text expression is necessary
			
			This function calls the overloaded setDwResponse() function with the constant "[row]" 
			as the string parameter


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/9/05
	

***************************************************************************************/

Integer li_Return

li_Return = this.of_setTextResponse(cs_RowResponse, as_Expression)

RETURN li_Return
end function

public function integer of_popinfoflag (long al_xpos, long al_ypos, string as_text);/***************************************************************************************
NAME: 	of_PopInfoFlag

ACCESS:	Public
		
ARGUMENTS: 	(Long al_Xpos, Long al_Ypos, String as_Text)

RETURNS:		Integer
	
DESCRIPTION:
			Sets the X and Y coordinates of an InfoFlag and sets its visible property to True.  
					Also Checks if the InfoFlag x and y coordinates exceeds the parent window
					and moves
					
					If Sucessful, return 1, otherwise return -1


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/9/05
	

***************************************************************************************/



Integer	li_Return = -1
Long		ll_InfoFlagYMax
Long		ll_InfoFlagXMax
Long		ll_ExceededDistance
Long		ll_ParentWidth
Long		ll_ParentHeight

ll_ParentWidth = iw_Parent.Width
ll_ParentHeight = iw_Parent.Height

IF isValid(iw_InfoFlag) THEN
	iw_InfoFlag.X = al_Xpos
	iw_InfoFlag.Y = al_Ypos + 100  //set infoflag below mouse
	
	
	ll_InfoFlagXMax = iw_InfoFlag.X + iw_InfoFlag.Width
	//IF the Xmax Coord exceeds the width of the Parent window, move it to the left
	IF ll_InfoFlagXMax > ll_ParentWidth THEN
		ll_ExceededDistance = ll_InfoFlagXMax - ll_ParentWidth
		iw_InfoFlag.X -= ll_ExceededDistance + 40 //Unkwon reason for extra 40 PB units - But seems necessary
	END IF
	
	ll_InfoFlagYMax = iw_InfoFlag.Y + iw_InfoFlag.Height
	//IF the Ymax Coord exceeds the height of the Parent window, move it above the Pointer
	IF ll_InfoFlagYMax > ll_ParentHeight THEN
	iw_InfoFlag.Y = al_Ypos - iw_InfoFlag.Height
	END IF
	
	iw_InfoFlag.of_SetText(as_text)
	iw_InfoFlag.Visible = TRUE				
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function boolean of_ispointerinpopup ();/***************************************************************************************
NAME: 	of_isPointerInPopup

ACCESS:	Public
		
ARGUMENTS: 	(None)

RETURNS:		Boolean	
	
DESCRIPTION:	Checks if the current mouse poisition is within a visible DwPopup
					Sets the instance ib_PointerInPopup
					If the Pointer is within the DwPopup, Returns True, otherwise False
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/5/05
	

***************************************************************************************/

Boolean lb_Return = FALSE


//Check If Pointer is within an open datawindow
IF isValid(idw_DwPopup) THEN
	IF idw_DwPopup.visible = TRUE THEN
		//IF Pointer is within the current DwPopup, then set ib_PointerInPopup to True
		IF iw_Parent.PointerY() >= idw_DwPopup.Y AND  iw_Parent.PointerY() <= idw_DwPopup.Y + idw_DwPopup.Height &
		AND iw_Parent.PointerX() >= idw_DwPopup.X AND  iw_Parent.PointerX() <= idw_DwPopup.X + idw_DwPopup.Width THEN
			ib_PointerInPopup = TRUE
			lb_Return = TRUE
		ELSE
			ib_PointerInPopup = FALSE
			lb_Return = FALSE
		END IF
	END IF
ELSE
	ib_PointerInPopup = FALSE
	lb_Return = FALSE
END IF

RETURN lb_Return
end function

public function string of_getcolumntagexpression (string as_column);/***************************************************************************************
NAME: 	of_GetColumnTagExpression

ACCESS:	Public
		
ARGUMENTS: 	(String as_Column)

RETURNS:		String
	
DESCRIPTION:
			Gets the Tag from the current column (as_Column) and parses it for a mouseover expression
			Mouseover expression is stored in ls_Expression

			 RETURN Null string IF the expression is null or length = 0 or describe returns "?" or "!"
			 RETURN ls_Expression Otherwise
			


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/9/05
	
***************************************************************************************/


String ls_Return
String ls_Tag
String ls_Expression
String ls_Null

setNull(ls_Null)

//Check for a column tag response
ls_Tag = idw_Requestor.Describe ( as_Column + ".Tag" )
// Check the tag for any "mouseover" information.
IF ls_Tag <> "?" AND ls_Tag <> "!" THEN
	ls_Expression = inv_stringService.of_GetKeyValue (ls_Tag, "MouseOverText", ";")  //Tag lookup is not case senstive
END IF

ls_Expression = Trim(ls_Expression)
IF IsNull (ls_Expression) OR Len(Trim(ls_Expression)) < 1 THEN
	ls_Return = ls_Null
ELSE
	ls_Return = ls_Expression
END IF

Return ls_Return
end function

public function string of_getrowtagexpression ();/***************************************************************************************
NAME: 	of_GetRowTagExpression

ACCESS:	Public
		
ARGUMENTS: 	(none)

RETURNS:		String
	
DESCRIPTION:
			Gets the Tag from the mouseovertext textbox and parses it for a mouseover expression
			Mouseover expression is stored in ls_Expression
			
			IF the Tag textbox tag does not contain the label 'mouseovertext',
			Then store the entire tag in ls_Expression  (User can either specify a 'mouseovertext' label or not)

			 Returns ls_Null IF the expression is null or length = 0 
			 Returns ls_Expression Otherwise
			


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/9/05
	
***************************************************************************************/




String 	ls_Return 
String 	ls_Tag
String 	ls_Expression
String	ls_Null
SetNull(ls_Null)

ls_Tag = idw_Requestor.Describe ( "mouseovertext.Tag" )
// Check the tag for any "mouseover" information.
ls_Expression = inv_stringService.of_GetKeyValue (ls_Tag, "MouseOverText", ";")  //Tag lookup is not case senstive
	
//Expression without the label (MouseOverText) is allowed
IF IsNull (ls_Expression) OR Len(Trim(ls_Expression)) = 0 THEN
	IF ls_Tag <> "?" AND ls_Tag <> "!" THEN
		ls_Expression = ls_Tag	
	END IF
END IF

ls_Expression = Trim(ls_Expression)

IF IsNull (ls_Expression) OR Len(Trim(ls_Expression)) < 1 THEN
	ls_Return = ls_Null
ELSE
	ls_Return = ls_Expression
END IF

Return ls_Return
end function

public function integer of_gettextresponse ();/***************************************************************************************
NAME: 	of_GetTextResponse

ACCESS:	Public
		
ARGUMENTS: 	(none)

RETURNS:		Integer
	
DESCRIPTION:   
				
			

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/15/05

***************************************************************************************/




return 1
end function

public function long of_calculategrouprow ();//returns 1 if it sets the row, -1 otherwise
//should only be called if row = 0

String	ls_BandInfo
String	ls_temp
Long		ll_firstGroupRow
Int		li_tabPosition
Int		li_return

//This logic is for dealing with groups.
//It calculates the first row of the group and sets the current row 
//of the dw to that row.

	
ls_BandInfo = idw_Requestor.GetBandAtPointer ( )


//we only need to do this if it is not the regular header or trailer of the dw
IF POS( ls_bandInfo, "header.") > 0 OR POS( ls_bandInfo, "trailer." ) > 0 THEN
	
	li_tabPosition = POS( ls_bandInfo, "~t" )
	ls_temp = right( ls_BandInfo, (len( ls_bandInfo ) - li_tabPosition) )
	ll_firstGroupRow = long( ls_temp )		

ELSE
	ll_FirstGroupRow = 0
END IF
	
	
Return ll_FirstGroupRow
end function

public function integer of_resetpopup (u_dw adw_popup);//Sets the current idw_DwpopUp to null (usually called when a link is unapplied)

Integer 	li_Return

IF isValid (adw_Popup) AND isValid(idw_DwPopup)THEN
	
	IF adw_PopUp = idw_DwPopup THEN
		SetNull(idw_DwPopup) 
		li_Return = 1
	ELSE
		li_Return = -1
	ENd IF
	
ELSE
	li_Return = -1
END IF

Return li_Return
end function

public function boolean of_ispointerininfoflag ();/***************************************************************************************
NAME: 	of_isPointerInPopup

ACCESS:	Public
		
ARGUMENTS: 	(None)

RETURNS:		Boolean	
	
DESCRIPTION:	Checks if the current mouse poisition is within a visible InfoFlag
					Sets the instance ib_PointerInInfoFlag
					If the Pointer is within the Infoflag, Returns True, otherwise False
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/11/05
	

***************************************************************************************/

Boolean lb_Return = FALSE


//Check If Pointer is within a text response
IF isValid(iw_InfoFlag) THEN
	IF iw_InfoFlag.visible = TRUE THEN
		//IF Pointer is within the InfoFlag, then set ib_PointerInInfoFlag to True
		IF iw_Parent.PointerY() >= iw_InfoFlag.Y AND  iw_Parent.PointerY() <= iw_InfoFlag.Y + iw_InfoFlag.Height &
		AND iw_Parent.PointerX() >= iw_InfoFlag.X AND  iw_Parent.PointerX() <= iw_InfoFlag.X + iw_InfoFlag.Width THEN
			ib_PointerInInfoFlag = TRUE
			lb_Return = TRUE
		ELSE
			ib_PointerInInfoFlag = FALSE
			lb_Return = FALSE
		END IF
	END IF
ELSE
	ib_PointerInInfoFlag = FALSE
	lb_Return = FALSE
END IF

RETURN lb_Return
end function

public function boolean of_ismouseoveron ();IF ib_TimerOn THEN
	Return TRUE
ELSE
	Return FALSE
END IF
end function

public function boolean of_checktextthreshhold (long al_width, long al_height);//Returns true if the text window PB area is less than the
//text threshold system setting (sl_textThreshHold)
//Returns false if the text window PB area  is greater than 
//the threshhold system setting 

Return al_width < sl_XThreshHold AND al_height <= sl_YThreshHold

end function

public function boolean of_checkdwthreshhold (long al_width, long al_height);//Returns true if the dw PB area is less than the
//text threshold system setting (sl_dwThreshHold)
//Returns false if the dw PB area  is greater than 
//the threshhold system setting 

Return al_width < sl_XThreshHold AND al_height <= sl_YThreshHold
end function

public function integer of_getdwresponse (datawindow adw_dw);/***************************************************************************************
NAME: 	of_GetDwResponse

ACCESS:	Public
		
ARGUMENTS: 	(adw_Dw)

RETURNS:		Integer
	
DESCRIPTION:   
				Compares adw_Dw with all possible dw responses.  
				Returns 1 If adw_Dw is defined as a DW response
				Returns -1 if adw_Dw is not defined as a DW response
				
			

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 8/15/05

***************************************************************************************/
Long			ll_Index2
Integer		li_Return

DataWindow	ldw_TempDw
s_parm			lstr_Parm
s_parm			lstr_ResponseType

IF isValid(inv_Msg) THEN
	FOR ll_Index2 = 1 TO inv_Msg.of_get_count( )
		inv_Msg.of_get_parm( ll_Index2 , lstr_parm)
		
		lstr_ResponseType = lstr_Parm.ia_value
		IF lstr_ResponseType.is_label = "dw" THEN
			ldw_TempDw = lstr_ResponseType.ia_value
			IF adw_Dw = ldw_TempDw THEN
				li_Return = 1
			END IF
		END IF
	
	NEXT
ELSE
	li_Return = -1
END IF

Return li_Return
end function

on n_cst_dwsrv_mouseover.create
call super::create
end on

on n_cst_dwsrv_mouseover.destroy
call super::destroy
end on

event constructor;call super::constructor;//the following initializes the mouseover threshhold for all windows that have the 
//mouse over service on, the first time a mouseOver service is instantiated.
Integer  li_return
String	ls_dimensions
String 	ls_width
String	ls_height

ids_temp = CREATE n_ds //temp ds to test evaluate expressions with

n_cst_setting_dynamicObject_mousthresh	inv_mouseThreshold

inv_mouseThreshold = CREATE n_cst_setting_dynamicObject_mousthresh

ls_dimensions = inv_mouseThreshold.of_getValue( )

inv_Timer = CREATE n_cst_Timer
inv_Timer.of_SetRequester(this)

IF POS( ls_dimensions, "," ) > 0 THEN
	//gets everything left of the comma
	ls_width = trim( left( ls_dimensions, pos( ls_dimensions, "," )-1 ) )
	
	//gets everything to the right of the comma
	ls_height = trim( RIGHT( ls_dimensions,( len(ls_dimensions) - pos( ls_dimensions, ","))) )

	IF isNumber( ls_width ) AND isNumber( ls_height ) THEN
		IF sl_xThreshHold = -1 THEN
			sl_xThreshhold = long( ls_width )
			
		END IF
		
		IF sl_yThreshHold = -1 THEN
			sl_yThreshhold = long( ls_height )
		END IF
		
	END IF
END IF

Destroy(inv_mouseThreshold)

end event

event destructor;call super::destructor;Destroy inv_Timer

Destroy ids_temp
end event

