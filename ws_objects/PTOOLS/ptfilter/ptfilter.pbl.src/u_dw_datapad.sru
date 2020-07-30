$PBExportHeader$u_dw_datapad.sru
forward
global type u_dw_datapad from u_dw
end type
end forward

global type u_dw_datapad from u_dw
int Width=745
int Height=368
event ue_changemode ( string as_mode )
event ue_filterchanged ( )
event ue_details ( dwobject dwo )
event ue_movetofront ( dwobject dwo )
event ue_movetoback ( dwobject dwo )
event ue_delete ( dwobject dwo )
event type long ue_save ( )
event ue_import ( )
event ue_new ( )
event ue_reset ( )
event type integer ue_copy ( integer ai_xpos,  integer ai_ypos )
event ue_paste ( )
end type
global u_dw_datapad u_dw_datapad

type variables
DataWindow	idw_Target
String		is_Filter
Int		ii_NextID

Private:
// mode 
Boolean	ib_Execute
end variables

forward prototypes
public function integer of_createdatavalue (n_cst_DataObject_Filter anv_DOF)
end prototypes

event ue_changemode;/**
*		Modes: "EDIT!"
*				 "EXECUTE!"
*
*
*/



CHOOSE CASE Upper ( as_mode )
		
	CASE "EDIT!"
		ib_Execute = FALSE
		
	CASE "EXECUTE!"
		ib_Execute = TRUE
		
		
END CHOOSE
end event

event ue_movetofront;THIS.SetPosition ( dwo.Name, "header", true )
end event

event ue_movetoback;THIS.SetPosition ( dwo.Name, "header", FALSE )
end event

event ue_delete;
THIS.Modify ( "destroy " + dwo.Name )
end event

public function integer of_createdatavalue (n_cst_DataObject_Filter anv_DOF);// create the now object in the header here!
string ls_modstring
String ls_ID
String	ls_Data

ls_Data = anv_DOF.of_GetFilter ( )

ls_ID = "New " + String ( ii_NextID )

ls_ModString = 'create text(band=header alignment="2" text=" ' + ls_ID + ' "  border="3" color="0" x="209" y="55" height="110" width="48"  tag=" ' + ls_Data + ' "  resizeable=1  moveable=1  font.face="Arial" font.height="-10" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16776960" )'
ii_NextID  ++ 
THIS.Modify(ls_modstring)

RETURN 1
end function

event clicked;//Overriding ancestor

String	lsa_Objects[]
String	ls_Filter
String	ls_Work
Long		ll_Count
Long		ll_Index
Boolean	lb_Ctrl
Boolean 	lb_Shift

n_cst_dws	lnv_Dws


IF ib_Execute THEN
	
	lb_Ctrl = KeyDown ( KeyControl! )
	lb_Shift = KeyDown ( KeyShift! )
	
	ll_Count = lnv_Dws.of_GetObjectsAtPosition ( This, xpos, ypos, "header", lsa_Objects )
	
	FOR ll_Index = 1 TO ll_Count
	
		ls_Work = This.Describe ( lsa_Objects [ ll_Index ] + ".Tag" )
	
		IF ls_Work <> "!"  THEN
			IF Len ( ls_Filter ) > 0 THEN
				ls_Filter += " AND "
			END IF
			ls_Filter += "(" + ls_Work + ")"
		END IF
	
	NEXT
	
	IF Len ( is_Filter ) > 0 THEN
		IF lb_Ctrl THEN
			ls_Filter = "(" + is_Filter + ") AND (" + ls_Filter + ")"
		ELSEIF lb_Shift THEN
			ls_Filter = "(" + is_Filter + ") OR (" + ls_Filter + ")"
		END IF
	END IF
	
	is_Filter = ls_Filter
	THIS.Event ue_FilterChanged ( )
	
ELSE  // edit mode 
	
	// put code here for clicked event while in edit mode
	
END IF



end event

event constructor;ib_rmbmenu = false
end event

event rbuttondown; 
// override Ancestor
Long	ll_ID

String 	ls_SelectedItem	
String	lsa_ItemList[]
boolean	lba_DisabledList[]
boolean 	lba_CheckedList[]
boolean	lba_invisibleList[]

n_cst_DataObject_Filter lnv_DOF
lsa_ItemList = { "Properties...","-","Bring to &Front" , "Send to &Back" ,"-",  "New" ,"Delete", "-" ,"Reset" }
IF IsValid ( dwo ) THEN
	IF dwo.name <> "datawindow" THEN
	//	lba_DisabledList [ 7 ]  = TRUE
		lba_DisabledList [ 6 ]  = TRUE
		lba_DisabledList [ 9 ]  = TRUE
		ls_selecteditem = f_popmenu(lsa_itemlist, lba_disabledlist, lba_checkedlist, &
		lba_invisiblelist ,0 ,0 )
		
		CHOOSE CASE  ls_SelectedItem
				
			CASE "Bring to &Front"
				EVENT ue_MoveToFront ( dwo )
			
			CASE "Send to &Back"
				EVENT ue_MoveToBack ( dwo )
			
			CASE "Properties..."
				Event ue_Details ( dwo )
				
			CASE "Delete"
				EVENT ue_Delete ( dwo )
		
				
			
		END CHOOSE
				
	ELSE
		
		lba_DisabledList = { TRUE , TRUE , TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, FALSE }
		ls_selecteditem = f_popmenu(lsa_itemlist, lba_disabledlist, lba_checkedlist, &
		lba_invisiblelist,0 ,0)
		
		CHOOSE CASE  ls_SelectedItem
		
			CASE "New"
				EVENT ue_New (  )
				
			CASE "Reset"
				Event ue_Reset ( )
				
		
				
		END CHOOSE
		
		
	END IF
END IF
end event

