$PBExportHeader$w_savedefinitionas.srw
forward
global type w_savedefinitionas from w_response
end type
type cbx_saveaspous from checkbox within w_savedefinitionas
end type
type cb_cancel from commandbutton within w_savedefinitionas
end type
type cb_save from commandbutton within w_savedefinitionas
end type
type sle_description from singlelineedit within w_savedefinitionas
end type
type st_description from statictext within w_savedefinitionas
end type
type sle_defname from singlelineedit within w_savedefinitionas
end type
type st_defname from statictext within w_savedefinitionas
end type
type st_checked from statictext within w_savedefinitionas
end type
type cb_1 from commandbutton within w_savedefinitionas
end type
type st_unchecked from statictext within w_savedefinitionas
end type
type st_save from statictext within w_savedefinitionas
end type
type gb_note from groupbox within w_savedefinitionas
end type
end forward

global type w_savedefinitionas from w_response
integer width = 1810
integer height = 664
string title = "Save Definition As"
long backcolor = 12632256
cbx_saveaspous cbx_saveaspous
cb_cancel cb_cancel
cb_save cb_save
sle_description sle_description
st_description st_description
sle_defname sle_defname
st_defname st_defname
st_checked st_checked
cb_1 cb_1
st_unchecked st_unchecked
st_save st_save
gb_note gb_note
end type
global w_savedefinitionas w_savedefinitionas

type variables
PowerObject		ipo_CurrentObject

Constant String	cs_DwTemplate = "DataWindow Template"
Constant String	cs_WinTemplate = "Window Template"
end variables

forward prototypes
public function boolean of_isuniquename (string as_defname)
private function integer of_saveas ()
end prototypes

public function boolean of_isuniquename (string as_defname);/***************************************************************************************
NAME: 	of_isuniquename

ACCESS:	Public
		
ARGUMENTS: 	(string as_defname)

RETURNS:		long
	
DESCRIPTION:
			Compares the definition name that is being saved (as_defname) with all the	
			definition names that already exist, which are stored in lds_DynamicObjects
				
				Returns FALSE if the new object name (as_defname) matchs any names stored 	
				in lds_DynamicObjects
				
				Returns TRUE if the name is unique (does not match any existing object names)
			


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/15/05
	
***************************************************************************************/



Boolean		lb_Return
DataStore	lds_DynamicObjects
Long			ll_ObjCount
Long			ll_Index
String		ls_CurrentObjName

lds_DynamicObjects = CREATE DataStore
lds_DynamicObjects.DataObject = "d_dynamicobjects"
lds_DynamicObjects.SetTransObject(SQLCA)
lds_DynamicObjects.Retrieve()

ll_ObjCount = lds_DynamicObjects.RowCount()

lb_Return = TRUE
//Loop Through Objects, if an object name is equal to as_defname, return false
FOR ll_Index = 1 TO ll_ObjCount
	ls_CurrentObjName = lds_DynamicObjects.GetItemString(ll_Index, "name")
	IF ls_CurrentObjName = as_defname THEN
		lb_Return = FALSE
	END IF
NEXT


Return lb_Return

end function

private function integer of_saveas ();/***************************************************************************************
NAME: 	of_SaveAs

ACCESS:	Private
		
ARGUMENTS: 	(none)

RETURNS:		Integer
	
DESCRIPTION: 
		Saves the object (idw_CurrentDw) as abstract definition
		(the name must be unique to already existing objects)
		
		Returns 1 if the object was saved successfully
		Returns -1 if a save error occurred

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 9/15/05
	
***************************************************************************************/

Integer	li_Saved = 1
Integer	li_Return = 1
Integer	li_Result
String	ls_DefName
String	ls_DefDescription
Boolean	lb_IsUniqueName
Object	lobj_Type
String	ls_PrefilterError
String	ls_msg


u_dw			ldw_Dw
u_tab			ltab_Tab
w_master		lw_Window

n_cst_bso_dynamicobjectmanager	lnv_PropManager

ls_DefName = sle_defname.Text
ls_DefDescription	 = sle_description.Text

//Make sure object is valid
IF NOT isvalid(ipo_CurrentObject) THEN //Should never be invalid
	li_Return = -1
	ls_Msg = "Invalid object." 
END IF

//Validate Name
IF NOT isNull(ls_DefName) AND Len(ls_DefName) > 0 THEN
	IF POS( ls_defName, "'" ) <> 0 THEN
		ls_Msg = "The name cannot contain single quotes."
		li_Return = -1
	END IF
ELSE
	ls_Msg = "A name must be specified."
	li_Return = -1
END IF
IF li_Return = 1 THEN
	lb_IsUniqueName = This.of_IsUniqueName(ls_DefName)
	IF NOT lb_IsUniqueName THEN
		li_Return = -1
		ls_Msg = "Definition '" + ls_DefName + "' already exists.~r~n" &
					+"Please provide a unique name."
	END IF
END IF

//Get the correct property manager
IF li_Return = 1 THEN
	lobj_type = TypeOf(ipo_CurrentObject)
	IF ipo_CurrentObject.TriggerEvent("ue_hasids") = 1 THEN
		IF lobj_type = Window! THEN
			lw_Window = ipo_CurrentObject
			lnv_PropManager = lw_Window.inv_Mypropmanager
		ELSEIF lobj_type = DataWindow! THEN
			ldw_Dw = ipo_CurrentObject
			lnv_PropManager = ldw_Dw.inv_MyPropManager
		ELSEIF lobj_type = TAB! THEN
			ltab_Tab = ipo_CurrentObject
			lnv_PropManager = ltab_Tab.inv_MyPropManager
		ELSE //Invalid type
			li_Return = -1
			ls_Msg = "Type of object being saved is unresolvable."
		END IF
	END IF
	
END IF

//Save the object
IF li_Return = 1 THEN
	
	//IF cbx_SaveAsPOUS is not checked, only save as abstract definition
	IF NOT cbx_SaveAsPOUS.Checked THEN
		li_Saved = lnv_PropManager.of_saveAbsDef(ipo_CurrentObject, 1 , ls_DefName, ls_DefDescription)
		IF li_Saved <> 1 THEN
			li_Return = -1
		END IF
	ELSE //IF cbx_SaveAsPOUS is checked, save as abstract and as an instance
		li_Saved = lnv_PropManager.of_saveAbsDef(ipo_CurrentObject, 3 , ls_DefName, ls_DefDescription)
		IF li_Saved <> 1 THEN
			li_Return = -1
		END IF
		
		IF li_Saved = 1 THEN
			//added by dan 4-7-06 to save linkages 						
			IF isValid( lw_window ) THEN
				lnv_PropManager.of_refreshlinkagecache( )
				lnv_PropManager.of_saveLinkages( lw_window )
			
				li_result = lnv_PropManager.ids_linkages.upDate()
	
				IF li_result = 1 THEN
					COMMIT;
					
				ELSE
					li_Return = -1
					ls_Msg = "Error saving linkages."
					ROLLBACK;
				END IF
				
				
			END IF
			//-----------------
		END IF
		
	END IF
	
	//Save any possible prefilters
	IF li_Saved = 1 THEN
		IF lobj_type = Window! OR lobj_type = DataWindow! THEN
			IF lnv_PropManager.of_SavePreFilter(ipo_currentobject, ls_DefName, ls_PreFilterError) <> 1 THEN
				ls_Msg = ls_PreFilterError
				li_Return = -1
			END IF
		END IF
	END IF
	
END IF

//Populate save error
IF li_Saved <> 1 THEN
	IF li_saved = lnv_PropManager.ci_failedupdateDynObjTable THEN
		ls_msg = "Error saving, Failed to update DynamicObject Table"
	ELSEIF li_saved = lnv_PropManager.ci_failedupdateDynPropTable THEN
		ls_msg = "Error saving, Failed to update DynamicProperty Table"
	ELSEIF li_saved = lnv_PropManager.ci_invalidMode THEN
		ls_msg = "Error saving, invalid mode of abstract save."
	ELSEIF li_saved = lnv_PropManager.ci_invalidObjName THEN
		ls_msg = "Error saving, object name is invalid"
	ELSEIF li_saved = lnv_PropManager.ci_nonDynamicObject THEN
		ls_msg = "Error saving, non-dynamic object cannot be saved."
	ELSE
		ls_msg = "Error saving '" + ls_defName + "'" 
	END IF
END IF

IF li_Return = 1  THEN
	//MessageBox("Saved", "Successfully saved '" + ls_DefName + "'")
ELSE
	MessageBox("Error Saving", ls_msg)
END IF

IF li_Return = 1 THEN
	Close(w_savedefinitionas)
END IF

Return li_Return
end function

on w_savedefinitionas.create
int iCurrent
call super::create
this.cbx_saveaspous=create cbx_saveaspous
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.sle_description=create sle_description
this.st_description=create st_description
this.sle_defname=create sle_defname
this.st_defname=create st_defname
this.st_checked=create st_checked
this.cb_1=create cb_1
this.st_unchecked=create st_unchecked
this.st_save=create st_save
this.gb_note=create gb_note
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_saveaspous
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.sle_description
this.Control[iCurrent+5]=this.st_description
this.Control[iCurrent+6]=this.sle_defname
this.Control[iCurrent+7]=this.st_defname
this.Control[iCurrent+8]=this.st_checked
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.st_unchecked
this.Control[iCurrent+11]=this.st_save
this.Control[iCurrent+12]=this.gb_note
end on

on w_savedefinitionas.destroy
call super::destroy
destroy(this.cbx_saveaspous)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.sle_description)
destroy(this.st_description)
destroy(this.sle_defname)
destroy(this.st_defname)
destroy(this.st_checked)
destroy(this.cb_1)
destroy(this.st_unchecked)
destroy(this.st_save)
destroy(this.gb_note)
end on

event open;call super::open;String	ls_CurrentName
String	ls_ParentWindow
u_dw		ldw_CurrentDw
w_master	lw_CurrentWin
u_tab		ltb_tab

IF isValid(Message.PowerObjectParm) AND Message.PowerObjectParm.triggerEvent("ue_hasIds") = 1 THEN
	//Store the Current Dw  in instance variable
	ipo_CurrentObject = Message.PowerObjectParm 
	
	IF ipo_CurrentObject.TriggerEvent("ue_hasids") = 1 THEN //If the object is dynamic
		
		IF TypeOf(ipo_CurrentObject) = DataWindow! THEN
			ldw_CurrentDw = ipo_CurrentObject
			ls_CurrentName = ldw_CurrentDw.of_GetObjName() 
			ls_ParentWindow = ldw_CurrentDw.of_getParentName()

		ELSEIF TypeOf(ipo_CurrentObject) = Window! THEN
			lw_CurrentWin = ipo_CurrentObject
			ls_CurrentName = lw_CurrentWin.of_GetObjName() 
			ls_ParentWindow = lw_CurrentWin.of_getParentName()
			
		ELSEIF TypeOf(ipo_CurrentObject) = TAB! THEN
			ltb_tab = ipo_CurrentObject
			ls_CurrentName = ltb_tab.of_GetObjName() 
			ls_ParentWindow = ltb_tab.of_getParentName()
		END IF
		
		This.Title += "  (" + ls_CurrentName + ")"
		
	END IF
	
END IF


IF ls_ParentWindow = cs_WinTemplate THEN
	This.cbx_saveaspous.Checked = FALSE
	This.cbx_saveaspous.Enabled = FALSE
ELSEIF ls_ParentWindow = "" OR isNull(ls_ParentWindow) THEN
	This.cbx_saveaspous.Checked = TRUE
	This.cbx_saveaspous.Enabled = FALSE
ELSE
	This.cbx_saveaspous.Checked = TRUE
	This.cbx_saveaspous.Enabled = TRUE
END IF
end event

type cb_help from w_response`cb_help within w_savedefinitionas
boolean visible = false
integer x = 0
integer y = 520
integer width = 87
end type

type cbx_saveaspous from checkbox within w_savedefinitionas
integer x = 55
integer y = 336
integer width = 896
integer height = 72
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Save as part of window Definition"
boolean checked = true
end type

type cb_cancel from commandbutton within w_savedefinitionas
integer x = 1376
integer y = 324
integer width = 343
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;Close(w_savedefinitionas)
end event

type cb_save from commandbutton within w_savedefinitionas
integer x = 1001
integer y = 324
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;of_SaveAs()
end event

type sle_description from singlelineedit within w_savedefinitionas
integer x = 366
integer y = 192
integer width = 1353
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_description from statictext within w_savedefinitionas
integer x = 41
integer y = 204
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Description:"
boolean focusrectangle = false
end type

type sle_defname from singlelineedit within w_savedefinitionas
integer x = 366
integer y = 72
integer width = 1353
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_defname from statictext within w_savedefinitionas
integer x = 174
integer y = 80
integer width = 192
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Name:"
boolean focusrectangle = false
end type

type st_checked from statictext within w_savedefinitionas
integer x = 137
integer y = 728
integer width = 1586
integer height = 128
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Leave checked to save object with the window. The object will appear on the window the next time it is opened."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_savedefinitionas
integer x = 997
integer y = 464
integer width = 722
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Expand For Notes on Saving"
end type

event clicked;IF this.text = "Expand For Notes on Saving" THEN
	parent.height = 1172
	this.text = "Shrink"
ELSE
	parent.height = 664
	this.text = "Expand For Notes on Saving"
END IF
end event

type st_unchecked from statictext within w_savedefinitionas
integer x = 137
integer y = 868
integer width = 1582
integer height = 132
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Uncheck to save the object independently of the window. The object will not appear on the window the next time it is opened."
boolean focusrectangle = false
end type

type st_save from statictext within w_savedefinitionas
integer x = 87
integer y = 660
integer width = 850
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 12632256
string text = "Save as part of window Definition:"
boolean focusrectangle = false
end type

type gb_note from groupbox within w_savedefinitionas
integer x = 46
integer y = 596
integer width = 1691
integer height = 452
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Notes on saving new objects"
end type

