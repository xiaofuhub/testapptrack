$PBExportHeader$w_definitionmanager.srw
forward
global type w_definitionmanager from w_response
end type
type cb_close from commandbutton within w_definitionmanager
end type
type cb_delete from commandbutton within w_definitionmanager
end type
type dw_objectlist from u_dw within w_definitionmanager
end type
type cb_export from commandbutton within w_definitionmanager
end type
type cb_import from commandbutton within w_definitionmanager
end type
type cb_save from commandbutton within w_definitionmanager
end type
end forward

global type w_definitionmanager from w_response
integer x = 214
integer y = 221
integer width = 3671
integer height = 992
string title = "Definition Manager"
long backcolor = 12632256
event ue_exportdefinition ( )
event ue_importdefinition ( )
cb_close cb_close
cb_delete cb_delete
dw_objectlist dw_objectlist
cb_export cb_export
cb_import cb_import
cb_save cb_save
end type
global w_definitionmanager w_definitionmanager

type variables
n_cst_bso_dynamicobjectmanager  inv_MyPropManger
n_cst_dwsrv		inv_dwsrv
Datastore		ids_dataObjects

DataStore		ids_Linkages


private string	isa_oldnamestoupdate[]		//these two arrays are intended to be used in unison as mapping
private string	isa_newNamestoUpdate[]		//the old object name to the new object name on saves. They are
														//used so we can update the tab references to the object whos
														//name has changed, since it is not keyed out to the db and is
														//in the form DWNAME:instanceNumber
end variables

forward prototypes
public function integer of_discarddeletables ()
end prototypes

event ue_exportdefinition();n_cst_bso_dynamicObjectManager lnv_manager
String	ls_objectName
Long		ll_row 

lnv_manager = CREATE n_cst_bso_dynamicObjectManager

ll_row = dw_objectList.getRow()

IF ll_row > 0 THEN
	ls_objectName = this.dw_objectlist.getItemString( ll_row,"name")
	
	//lnv_manager.of_exportdynamicdefinitition( ls_objectName )
	lnv_manager.of_exportallfordefinition( ls_objectname )
END IF

DESTROY lnv_manager
end event

event ue_importdefinition();n_cst_bso_dynamicObjectManager lnv_manager
String	ls_objectName
Long		ll_row 
String	ls_error
int		li_Return
lnv_manager = CREATE n_cst_bso_dynamicObjectManager
	
//li_Return = lnv_manager.of_importDynamicDefinition( ls_error )
li_return = lnv_manager.of_importalldynamicdefinitions( ls_error )
//IF li_return = -1 THEN
	IF len( ls_error ) > 0 THEN
		MessageBox("Import Definition",ls_error+ " Import failed.")
	ELSE
//		Messagebox("Import Definition", "Import failed.")
	END IF
//END IF
DESTROY lnv_manager
end event

public function integer of_discarddeletables ();Long	ll_index
Long	ll_max
String	ls_objName

Ll_max = dw_objectlist.rowCount()

IF isValid( inv_MyPropManger ) THEN
	FOR ll_index = ll_max TO 1 step -1
		ls_objName = dw_objectlist.getItemString( ll_index, "name" )
		IF NOT inv_mypropmanger.of_isDeletableobject( ls_objName ) THEN
			dw_objectlist.Rowsdiscard( ll_index, ll_index, primary!)
			
		END IF
	NEXT
END IF
return 1
end function

on w_definitionmanager.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.dw_objectlist=create dw_objectlist
this.cb_export=create cb_export
this.cb_import=create cb_import
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.dw_objectlist
this.Control[iCurrent+4]=this.cb_export
this.Control[iCurrent+5]=this.cb_import
this.Control[iCurrent+6]=this.cb_save
end on

on w_definitionmanager.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.dw_objectlist)
destroy(this.cb_export)
destroy(this.cb_import)
destroy(this.cb_save)
end on

event close;call super::close;Destroy 	inv_MyPropManger
Destroy	inv_dwsrv
Destroy	ids_dataObjects
Destroy	ids_Linkages
end event

event open;call super::open;String	ls_DetailHeight
String	ls_HeaderHeight
Long		ll_NumRows
Long		ll_DwHeight
Long		ll_ButtonY
Long		ll_Button2Y
Long		ll_WinHeight

This.SetRedraw(FALSE)
ls_DetailHeight = dw_objectlist.Describe("DataWindow.Detail.Height")
ls_HeaderHeight = dw_objectlist.Describe("DataWindow.Header.Height")

ll_NumRows = dw_objectlist.RowCount() + 1

ll_DwHeight = (ll_Numrows * Long(ls_DetailHeight) + Long(ls_HeaderHeight))
IF ll_DwHeight > 630 THEN //IF dw height exceeds the default height
	dw_objectlist.Height = ll_DwHeight
	
	ll_ButtonY = dw_objectlist.Height + 150
	cb_close.Y = ll_ButtonY
	
	ll_Button2Y = dw_objectlist.Height + 150
	cb_delete.Y = ll_Button2Y
	
	cb_export.Y = ll_Button2Y
	
	cb_import.Y = ll_Button2Y
	
	cb_save.Y= cb_close.y
	
	ll_WinHeight = ll_DwHeight + 400
	This.Height = ll_WinHeight
END IF
//Resize everything if it exceeds the height of its parent
IF This.Height >This.ParentWindow( ).Height THEN
	This.Height = This.ParentWindow( ).Height - 200
	dw_objectlist.Height = This.Height - 400
	ll_Button2Y = dw_objectlist.Height + 100
	cb_delete.Y = ll_Button2Y
	ll_ButtonY = dw_objectlist.Height + 150
	cb_close.Y = ll_ButtonY
	cb_export.Y = ll_Button2Y
	cb_import.Y = ll_Button2Y
	cb_save.Y= cb_close.y
END IF

// Center window
This.of_SetBase(TRUE) 
This.inv_Base.Of_Center()

This.SetRedraw(TRUE)
end event

event pfc_save;call super::pfc_save;Int	li_result
Long	ll_rowCount
Long	ll_DataObjectCount
Long	ll_index
Long	ll_index2
String	ls_DefName
String	ls_ObjName
String		ls_DO
n_ds			lds_tabProps
Long			ll_max
String		ls_label
String		ls_value
int			li_pos	
String		ls_cacheName
String		ls_instance
int		 	li_res
Long			ll_numtoUpdate
String	 	ls_oldName
String		ls_data
String	ls_clearArray[]
String	ls_clearArry2[]


IF ancestorReturnValue >= 0 THEN
	ids_DataObjects.Retrieve("", "", "")
	ll_RowCount = dw_objectlist.RowCount()
	ll_DataObjectCount = ids_DataObjects.RowCount()
	
	FOR ll_Index = 1 TO ll_RowCount
		ls_DefName = dw_objectlist.GetItemString(ll_Index, "name")
		ls_DO = dw_objectlist.GetItemString(ll_Index, "dataobject")
		FOR ll_Index2 = 1 TO ll_DataObjectCount
			ls_ObjName = ids_dataObjects.GetItemString(ll_Index2, "dynamicproperty_objectname")
			IF ls_ObjName = ls_DefName THEN
				ids_dataObjects.SetItem(ll_Index2, "dynamicproperty_propertyvalue", ls_DO )
			END IF
		NEXT
	NEXT

	li_result = ids_dataObjects.update()
	IF li_result = 1 THEN
		COMMIT;
	ELSE
		MessageBox("Database Error", "Error Updating Dataobjects")
		ROLLBACK;
		
	END IF
	
	
	//the following is intended to update tab properties for any objects whos names have changed form
	//one value to another that could have effected the references of the tabs.
	IF li_result = 1 THEN
		lds_tabProps = create n_ds
		lds_tabProps.dataobject = "d_dynamictabpropertiesall"
		lds_tabProps.settransobject( SQLCA )
		ll_max = lds_tabProps.retrieve()
		commit;
		
		
		ll_numtoUpdate = upperBound( isa_newnamestoupdate )
		//loop through names to update
		FOR  ll_index2 = 1 TO ll_numToUpdate
			ls_oldName = isa_oldnamestoupdate[ll_index2]
			ls_data = isa_newnamestoupdate[ll_index2]
			FOR ll_index = 1 TO ll_max
				ls_label = lds_tabProps.getItemString( ll_index, "propertylabel" )
				IF isNumber( ls_label ) THEN
					ls_value = lds_tabProps.getItemString( ll_index, "propertyvalue" )
					li_pos = pos(ls_value, ":") 
					IF li_pos > 0 THEN
						ls_cacheName = left(ls_value, li_pos - 1)
						ls_instance = right(ls_value, len(ls_value) - li_pos)
						IF ls_cacheName = ls_oldName THEN
							lds_tabProps.setItem( ll_index, "propertyvalue", ls_data+":"+ls_instance )
						END IF
					END IF
				END IF
			NEXT
		NEXT
		
		
		li_res = lds_tabprops.update()
		IF li_res = 1 THEN
			commit;
			isa_oldnamestoupdate = ls_clearArray
			isa_newnamestoupdate =	ls_clearArry2
		ELSE
			rollback;
			MessageBox("Update Tabs", "The object created failed to update any tabs that were referencing it.")
		END IF
		
		
		DESTROY lds_tabProps
	END IF
END IF

return ancestorReturnValue
end event

type cb_help from w_response`cb_help within w_definitionmanager
boolean visible = false
end type

type cb_close from commandbutton within w_definitionmanager
integer x = 3273
integer y = 776
integer width = 306
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close(w_definitionmanager)
end event

type cb_delete from commandbutton within w_definitionmanager
integer x = 82
integer y = 772
integer width = 485
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete Definition"
end type

event clicked;Integer	li_Continue
Long		ll_CurrentRow
String	ls_DefName
String	ls_Type

ll_CurrentRow = dw_objectlist.GetRow()

IF ll_CurrentRow > 0 THEN
	ls_DefName = dw_objectlist.GetItemString(ll_CurrentRow, "name")
	ls_Type = dw_objectlist.GetItemstring(ll_CurrentRow, "type")
	
	li_Continue = Messagebox("Delete Definition", "Deleting the '" + ls_DefName &
						+ "' Definition will destroy all '"+ ls_DefName + "' " + ls_Type + "s" &
						+ "~nDelete this Definition?", Exclamation!, OKCANCEL!, 1)
	IF li_Continue = 1 THEN	
			dw_objectlist.DeleteRow( ll_CurrentRow )
	END IF
END IF


end event

type dw_objectlist from u_dw within w_definitionmanager
event type boolean ue_validatedataobject ( string as_path,  string as_olddo,  string as_objname )
integer x = 91
integer y = 72
integer width = 3488
integer height = 628
integer taborder = 10
string dataobject = "d_dynamicobjectsmanage"
boolean ib_rmbmenu = false
end type

event type boolean ue_validatedataobject(string as_path, string as_olddo, string as_objname);/***************************************************************************************
NAME: 					

ACCESS:			public
		
ARGUMENTS: 		
							String as_path

RETURNS:			Boolean
	
DESCRIPTION:  Compares the Column Names and Argument Names of the current lds_Current 
					dataobject, and the dataobject of the file (as_path)
					
					Returns TRUE If All Column Names AND Argument Names/Types are the same 
					Retruns FALSE if Any Col Names or Argument Names/Types don't match

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Maury 	9/14/2005
	

***************************************************************************************/

String	ls_error
Int		li_return
Int		li_res

 N_cst_bso_dynamicObjectManager lnv_manager
lnv_manager = create N_cst_bso_dynamicObjectManager

li_return = lnv_manager.of_validatedataobjectchange(as_objName, as_oldDo, as_path, ls_error )

IF li_return <> 1 THEN
	IF li_return = lnv_manager.ci_allertdopathnonvalid THEN
		li_res = MessageBox( "Dataobject Validation", "The preexisting dataobject path is not valid. Path: "+as_oldDo+".~r~nValidation of the dataobject change could not be completed. Do you want to change the dataobject without validation?~r~n(clicking yes could compromise linkages, mouseovers, filters, and sorts.)", EXCLAMATION!, yesno!, 1 )
		IF li_Res = 1 THEN
			li_return = 1
		ELSE
			li_return = -1
		END IF
	ELSEIF li_return = lnv_manager.ci_faileddolinkagetest THEN
		MessageBox("Dataobject Validation", ls_error + "~r~nDataobject could not be changed.")
	ELSEIF li_return < 0 THEN
		li_res = MessageBox("Dataobject Validation", ls_error+ "~r~n~r~nChanging to this dataobject may result in errors. Do you want to continue?", exclamation!, yesno!, 2 )
		
		IF li_res = 1 THEN
			li_return = 1
		END IF
	END IF
END IF

RETURN li_return = 1

end event

event constructor;call super::constructor;Long 		ll_rowCount
Long		ll_dataobjectcount
Long		ll_Index
Long		ll_Index2
String	ls_DefName
String	ls_ObjName
String	ls_DO
String	ls_Drive
String	ls_Dirpath
String	ls_FileName
String	ls_DataObjectCodeTable

n_cst_FileSrvWin32	lnv_FileSrv

lnv_FileSrv = Create n_cst_FileSrvWin32



inv_MyPropManger = CREATE n_cst_bso_dynamicobjectmanager

//This.of_SetRowSelect(TRUE)
//This.inv_RowSelect.of_SetRequestor(THIS)
//This.inv_RowSelect.of_SetStyle(0)
//This.SetRowFocusIndicator(FocusRect!)
This.of_setinsertable( FALSE)
This.of_setdeleteable( FALSE )



This.SetTransObject(SQLCA)
This.Retrieve()
commit;

parent.of_discarddeletables( )
IF not IsValid( ids_dataObjects ) THEN
	ids_dataObjects = Create datastore
	ids_dataObjects.dataObject = "d_dynamicpropertycache"
	ids_dataObjects.setTransObject( SQLCA )
END IF

//retrieves all abstract definitions for all objects
ids_dataObjects.retrieve("","","")
commit;

ids_dataObjects.setFilter("dynamicproperty_propertylabel = 'dataobject' AND isnull( dynamicproperty_containername )")
ids_dataObjects.filter()

//Loop through definition objects to set the dataobject computed field

ll_RowCount = This.RowCount()
ll_DataObjectCount = ids_DataObjects.RowCount()

FOR ll_Index = 1 TO ll_RowCount
	ls_DefName = This.GetItemString(ll_Index, "name")
	FOR ll_Index2 = 1 TO ll_DataObjectCount
		ls_ObjName = ids_dataObjects.GetItemString(ll_Index2, "dynamicproperty_objectname")
		IF ls_ObjName = ls_DefName THEN
			ls_DO = ids_dataObjects.GetItemString(ll_Index2, "dynamicproperty_propertyvalue") 
			This.SetItem(ll_Index, "dataobject", ls_DO)
//			lnv_FileSrv.of_ParsePath(ls_DO, ls_Drive, ls_DirPath, ls_FileName)
//			ls_DataObjectCodeTable =  ls_FileName + "~t" + ls_DO + "/"
//			This.Object.dataobject.Values = ls_DataObjectCodeTable
		END IF
	NEXT
NEXT

this.resetUpdate()

//Retrieve All Linkages
ids_Linkages = CREATE datastore
ids_Linkages.DataObject = "d_link_definitions"
ids_Linkages.SetTransObject(SQLCA)
ids_Linkages.Retrieve()
commit;

Destroy lnv_FileSrv

end event

event rowfocuschanged;call super::rowfocuschanged;String ls_ObjectName



This.ScrollToRow(CurrentRow)
This.SetRow(CurrentRow)

//Deleteable objects are not displayed anymore, so commented out..
//ls_ObjectName = This.GetItemString(currentrow, "name")
//
//IF inv_MyPropManger.of_isDeletableObject(ls_ObjectName) = FALSE THEN
//	Parent.cb_delete.Enabled = FALSE
//ELSE
//	Parent.cb_delete.Enabled = TRUE
//END IF
//..
end event

event buttonclicked;call super::buttonclicked;Integer	li_rtn
String	ls_Path
String	ls_DocPath
String	ls_DocName
String	ls_FileValues

Boolean	lb_ValidDo
String	ls_Name
String	ls_oldDo

n_cst_setting_templatespathfolder 	lnv_Root

lnv_Root = CREATE n_cst_setting_templatespathfolder

IF dwo.Name = "b_browse" THEN
	ls_Path = This.GetItemString(row,"dataobject")
	//If the current dataobject is not a psr, use default template path
	IF Pos(ls_Path, ".psr") <= 0 THEN
		ls_Path = lnv_Root.of_getValue()
	END IF

	IF NOT isNull(ls_Path) THEN
		 li_rtn = GetFileOpenName("DataObject", &
		 ls_docpath, ls_docname, "PSR", "PSR FILES (*.PSR),*.PSR,", ls_Path, 18)
	END IF
	
	ls_name = this.getItemString( row,"name")
	ls_oldDo = this.getItemString( row, "dataobject" )
	
	IF Len( ls_path ) > 0 AND li_rtn > 0 THEN
		lb_ValidDO = This.Event ue_ValidateDataObject(ls_DocPath, ls_oldDo, ls_name)
	END IF
	IF lb_ValidDO THEN
		//Update the code table with the new selected file
		ls_FileValues = ls_DocName + "~t" + ls_DocPath + "/"
		This.Object.dataobject.Values = ls_FileValues
		//Set the dataobjec to the selected file
		This.SetItem(row, "dataobject", ls_DocPath)
	END IF
END IF
end event

event itemchanged;call super::itemchanged;Long	ll_index
Long	ll_max
Long	ll_return
String	ls_name
String	ls_oldName
String	ls_type
String	ls_label
String	ls_value
String	ls_cacheName


int		li_res
int		li_pos
string		ls_instance
n_ds		lds_tabProps



//the following keeps it from changing to an object name that already exists
IF dwo.name = "name" AND row > 0 THEN
	ll_max = this.rowCount()
	ls_name = this.getItemString(row, "name")
	FOR ll_index = 1 To ll_max
		IF ll_index <> row and (this.getItemstring(ll_index, "name") = data) THEN
			return 1		//keep focus from changing
		END IF
	NEXT
END IF

//the following is to see if the object is a part of any tab control and to update that
//tab controls properities.
IF this.getItemString( row, "type" ) <> "tab" THEN
	ls_oldName = this.GetItemString ( row, "name", PRIMARY!, TRUE )
	isa_oldnamestoupdate[upperBound(isa_oldnamestoupdate)+1] = ls_oldName
	isa_newNamestoUpdate[upperBound(isa_newNamesToUpdate)+1] = data
//	lds_tabProps = create n_ds
//	lds_tabProps.dataobject = "d_dynamictabpropertiesall"
//	lds_tabProps.settransobject( SQLCA )
//	ll_max = lds_tabProps.retrieve()
//	commit;
//	
//	
//	FOR ll_index = 1 TO ll_max
//		ls_label = lds_tabProps.getItemString( ll_index, "propertylabel" )
//		IF isNumber( ls_label ) THEN
//			ls_value = lds_tabProps.getItemString( ll_index, "propertyvalue" )
//			li_pos = pos(ls_value, ":") 
//			IF li_pos > 0 THEN
//				ls_cacheName = left(ls_value, li_pos - 1)
//				ls_instance = right(ls_value, len(ls_value) - li_pos)
//				IF ls_cacheName = ls_oldName THEN
//					lds_tabProps.setItem( ll_index, "propertyvalue", data+":"+ls_instance )
//				END IF
//			END IF
//		END IF
//	NEXT
//	
//	li_res = lds_tabprops.update()
//	IF li_res = 1 THEN
//		commit;
//		
//	ELSE
//		rollback;
//		MessageBox("Update Tabs", "The object created failed to update any tabs that were referencing it.")
//	END IF
//	
//	
//	DESTROY lds_tabProps
END IF
end event

event clicked;call super::clicked;This.SetRow(row)
end event

type cb_export from commandbutton within w_definitionmanager
integer x = 608
integer y = 772
integer width = 489
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Export Definition"
end type

event clicked;parent.event ue_exportdefinition( )
end event

type cb_import from commandbutton within w_definitionmanager
integer x = 1138
integer y = 772
integer width = 489
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Import Definition"
end type

event clicked;Long	ll_rowCount
Long	ll_dataobjectCount
Long	ll_index
String	ls_defName
Long	ll_index2
String	ls_objName
String	ls_do

dw_objectlist.accepttext()

IF dw_objectlist.modifiedCount() =  0 AND dw_objectlist.deletedcount( ) = 0 THEN
	dw_objectlist.setRedraw( FALSE )
	parent.event ue_importdefinition( )
	
	//the following pretty much refreshes the window with the imported objects.
	dw_objectlist.retrieve( )
	commit;
	parent.of_discarddeletables( )
	
	IF not IsValid( ids_dataObjects ) THEN
		ids_dataObjects = Create datastore
		ids_dataObjects.dataObject = "d_dynamicpropertycache"
		ids_dataObjects.setTransObject( SQLCA )
	END IF

	//retrieves all abstract definitions for all objects
	ids_dataObjects.retrieve("","","")
	commit;
	
	ids_dataObjects.setFilter("dynamicproperty_propertylabel = 'dataobject' AND isnull( dynamicproperty_containername )")
	ids_dataObjects.filter()
	
	ll_RowCount = dw_objectlist.RowCount()
	ll_DataObjectCount = ids_DataObjects.RowCount()
	
	FOR ll_Index = 1 TO ll_RowCount
		ls_DefName = dw_objectlist.GetItemString(ll_Index, "name")
		FOR ll_Index2 = 1 TO ll_DataObjectCount
			ls_ObjName = ids_dataObjects.GetItemString(ll_Index2, "dynamicproperty_objectname")
			IF ls_ObjName = ls_DefName THEN
				ls_DO = ids_dataObjects.GetItemString(ll_Index2, "dynamicproperty_propertyvalue") 
				dw_objectlist.SetItem(ll_Index, "dataobject", ls_DO )
			END IF
		NEXT
	NEXT

	dw_objectlist.resetUpdate()
	
	ids_linkages.retrieve()
	commit;
	
	dw_objectlist.setRedraw( TRUE )
ELSE
	MessageBox("Import Definition", "Save changes before importing definitions.")
END IF
end event

type cb_save from commandbutton within w_definitionmanager
integer x = 2898
integer y = 776
integer width = 306
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;int li_result
li_result = dw_objectlist.update()
IF li_result = 1 THEN
	commit;
	parent.event pfc_save( )
ELSE
	rollback;
	Messagebox("Save", "Error saving changes.")
END IF
end event

