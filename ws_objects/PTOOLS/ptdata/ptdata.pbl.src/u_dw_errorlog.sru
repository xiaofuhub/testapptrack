$PBExportHeader$u_dw_errorlog.sru
forward
global type u_dw_errorlog from u_dw
end type
end forward

global type u_dw_errorlog from u_dw
integer width = 1326
integer height = 392
string dragicon = "DataPipeline!"
string dataobject = "d_errorlog"
boolean minbox = true
boolean border = false
event ue_expanddetail ( long al_row,  long al_height )
event ue_collapsedetail ( long al_row )
event type integer ue_troubleshoot ( long al_row )
event ue_initializesystemobjectproperties ( )
event ue_deleteall ( )
end type
global u_dw_errorlog u_dw_errorlog

type variables
Constant Integer	ci_Expand = 350
Constant Integer  ci_Collapse = 76

Long	li_PreRetrieveRowCount
end variables

event ue_expanddetail(long al_row, long al_height);Long	ll_DummyRow
Long	ll_RowCount
Long	ll_ScrollPos, ll_ScrollMax

This.SetRedraw(FALSE)

//Bug: SetDetailHeight(lastrow,lastrow,x) does not work on last row
//Fix: Insert a dummy row at the end temporarirly
IF al_row = This.RowCount() THEN
	ll_DummyRow = This.InsertRow(0)
END IF

This.SetDetailHeight(al_row, al_row, al_Height)

//Delete Dummy Row
IF ll_DummyRow > 0 THEN
	This.DeleteRow(ll_DummyRow)
	This.RowsDiscard(1, This.DeletedCount(), Delete!)
END IF

This.SetRedraw(TRUE)

//Scroll Logic (ScrollToRow was not cooperating after detail was expanded)
ll_ScrollMax = Long(This.Object.DataWindow.VerticalScrollMaximum)
ll_RowCount = This.RowCount()
ll_ScrollPos =( al_row /ll_RowCount) * ll_ScrollMax
This.Object.DataWindow.VerticalScrollPosition = String(ll_ScrollPos)




end event

event ue_collapsedetail(long al_row);Long	ll_DummyRow
Long	ll_RowCount
Long	ll_ScrollPos, ll_ScrollMax

This.SetRedraw(FALSE)

//Bug: SetDetailHeight(lastrow,lastrow,x) does not work on last row
//Fix: Insert a dummy row at the end temporarirly
IF al_row = This.RowCount() THEN
	ll_DummyRow = This.InsertRow(0)
END IF

This.SetDetailHeight(al_row, al_row, ci_Collapse)


//Delete Dummy Row
IF ll_DummyRow > 0 THEN
	This.DeleteRow(ll_DummyRow)
	This.RowsDiscard(1, This.DeletedCount(), Delete!)
END IF

This.SetRedraw(TRUE)

//Scroll Logic (ScrollToRow was not cooperating after detail was expanded)
ll_ScrollMax = Long(This.Object.DataWindow.VerticalScrollMaximum)
ll_RowCount = This.RowCount()
ll_ScrollPos = ll_ScrollMax * ( al_row / ll_RowCount)
This.Object.DataWindow.VerticalScrollPosition = String(ll_ScrollPos) 
end event

event type integer ue_troubleshoot(long al_row);Integer	li_Return = 1
String	ls_Category
String	ls_Context
String	ls_Message
String	ls_RemedyObject
String	ls_Errors
Integer	li_Urgency
Long		ll_ErrorLogId
Long		ll_SourceIdcount
Long		lla_SourceIds[]

n_ds		lds_SourceIds

n_cst_ErrorLog				lnv_Error
n_cst_ErrorLog_Manager	lnv_ErrorManager

lds_SourceIds = Create n_ds
lnv_Error = Create	n_cst_ErrorLog
lnv_ErrorManager = Create n_cst_ErrorLog_Manager

//Log Info
ls_Category = This.Object.category[al_row]
ls_Context = This.Object.context[al_row]
ls_Message = This.Object.message[al_row]
li_Urgency = This.Object.urgency[al_row]
ls_RemedyObject = This.Object.remedyobject[al_row]
ll_ErrorLogId = This.Object.id[al_row]

//Retrieve SourceIds
lds_SourceIds.Create(SQLCA.syntaxfromsql("select sourceid from errorlogsourceids where errorlogid = " + String(ll_ErrorLogId), "",  ls_Errors ))
IF Len(ls_Errors) = 0 THEN
	lds_SourceIds.SetTransObject(SQLCA)
	lds_SourceIds.Retrieve()
	commit;
	ll_SourceIdCount = lds_SourceIds.RowCount()
	IF ll_SourceIdCount > 0 THEN
		lla_SourceIds[] = lds_SourceIds.Object.sourceid.primary
	END IF
ELSE
	li_Return = -1
END IF

//Populate error non visual
IF li_Return = 1 THEN
	lnv_Error.of_SetLogData( ls_Category, ls_Context, ls_Message, li_Urgency, lla_sourceIds, ls_RemedyObject)
END IF


//Troubleshoot error with manager
IF li_Return = 1 THEN
	lnv_ErrorManager.of_TroubleShoot(lnv_Error)
END IF
  
Destroy 	n_cst_ErrorLog
Destroy	n_cst_ErrorLog_Manager
Destroy	lds_SourceIds

Return li_Return
end event

event ue_initializesystemobjectproperties();//this event is what is called on all newly created system objects the first time
//it is going to be put in the database.  It will put properties in the dynamicproperty table,
//and any mouseovers or links as well.
n_cst_bso_dynamicObjectManager	lnv_manager
datastore	lds_properties
datastore	lds_objProps
datastore	lds_mouseovers
long			ll_index
int			li_continue	 = 1
constant		string cs_objectName = "Error Log"

lds_objProps = Create datastore
lds_objProps.dataObject = "d_dynamiccreateproperties"
lds_objProps.setTransObject( SQLCA )

//see if there are any properties in the db for this object already
li_continue = lds_objProps.retrieve( cs_objectName ) 
commit;

IF li_continue = 0 THEN  
	
	// ---------------------Insert Properties--------------
	lnv_manager = create n_cst_bso_dynamicObjectManager
	lds_properties = create datastore
	lds_properties.DataObject = "d_dynamicpropertycache"
	lds_properties.SetTransObject( SQLCA )	
	
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"titleBar", "true" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"width", "1253" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"title", "Error Log" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"resizable", "true" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"controlmenu", "false" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"dataobject", "d_errorlog" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"sqlrefreshmintime", "0" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"state", "1" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"minposy", "-1" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"normalposleft", "67" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"prefilter", "" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"height", "644" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"border", "false" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"dragscroll", "false" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"borderstyle", "stylelowered" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"sort", "urgency A, category A" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"normalpostop", "21" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"normalposright", "341" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"normalposbottom", "182" )
	
	IF lds_properties.update( ) = 1 THEN
		commit;
	ELSE
		rollback;
	END IF
	
	//-----------------------Insert MouseOvers-------------------------------------------
	lds_mouseOVers = create datastore	
	lds_mouseOvers.dataobject = "d_mouseoverresponses"
	lds_mouseOvers.setTransobject( SQLCA )
	
	ll_index = lds_mouseOvers.insertRow( 0 )
	lds_mouseOvers.setitem( ll_index, "objectname", cs_objectName )
	lds_mouseOvers.setitem( ll_index, "response", "col")
	lds_mouseOvers.setitem( ll_index, "columnname", "context")
	lds_mouseOvers.setitem( ll_index, "responsetype", "text" )
	lds_mouseOvers.setitem( ll_index, "textexpression", "message" )
	
	IF lds_mouseOvers.update( ) = 1 THEN
		commit;
	ELSE
		rollback;
	END IF
	
	DESTROY lds_properties
	DESTROY lds_mouseOVers
	DESTROY lnv_manager
END IF

DESTROY lds_objProps






end event

event ue_deleteall();Long	ll_index
Long	ll_max
Int	li_res

li_Res = messagebox("Delete All", "All of the errors in this display will be deleted. Do you wish to continue?", question!,yesno!, 2)
IF li_res = 1 THEN
	ll_max = this.rowCOunt()
	
	li_res = This.rowsMove(1, ll_max, PRIMARY!, this, 1, delete!)
 	li_Res = this.update()
	
	IF li_res = 1 THEN
		commit;
	ELSE
		rollback;
		Messagebox("Delete All","Update failed, rows not deleted.")
	END IF
END IF
end event

on u_dw_errorlog.create
end on

on u_dw_errorlog.destroy
end on

event constructor;call super::constructor;string ls_mod
This.SetTransObject(SQLCA)
//This.SetRowfocusIndicator(FocusRect!)
//Set Detail band height to the collapse height
This.Object.DataWindow.Detail.Height = ci_Collapse
//This.Modify("DataWindow.Print.Preview='yes'")
//Set compute expression for +/- logic
//ls_mod = This.Modify("compute_expandcollapse.Expression='if(compute_rowheight < " + string(ci_expand) + ", +, -)'")


end event

event pfc_deleterow;call super::pfc_deleterow;This.Event pfc_Update(False, True)
Return AncestorReturnValue
end event

event buttonclicked;call super::buttonclicked;IF dwo.Name = "b_delete" THEN
	This.SetRow(row)
	This.Event PFC_DeleteRow()
ELSEIF dwo.Name = "b_troubleshoot" THEN
	This.Event ue_TroubleShoot( row )
ELSEIF lower(dwo.name) = "b_deleteall" THEN
	This.Event ue_deleteAll()
END IF
end event

event doubleclicked;call super::doubleclicked;Long	ll_Height

IF dwo.Name = "context"THEN
	ll_Height = This.Object.compute_rowheight[row]
	
	IF ll_Height = ci_Collapse THEN
		This.Event ue_ExpandDetail(row, ci_Expand)
	ELSE
		This.Event ue_CollapseDetail(row)
	END IF
	
END IF
end event

event retrieveend;call super::retrieveend;Long	ll_Handle
Long	ll_State
w_master 	lw_parent
s_WindowPlacement	lstr_WinPlacement

//Normalize window if there is a new error in the log
IF rowcount > li_PreRetrieveRowCount THEN
	ll_Handle = Handle(This)
	GetWindowPlacement( ll_Handle , lstr_WinPlacement )
	ll_State = lstr_WinPlacement.showCmd
	
	IF ll_State = 2 THEN //Minimized
		lstr_WinPlacement.showCmd = 1 //Normal
		SetWindowPlacement(ll_Handle, lstr_WinPlacement)
	END IF
	
END IF

end event

event retrievestart;call super::retrievestart;li_PreRetrieveRowCount = This.RowCount() + This.FilteredCount()
end event

event clicked;call super::clicked;Long	ll_Height
This.Setrow(row)
This.ScrollToRow(row)


IF dwo.Name = "compute_expandcollapse"THEN
	ll_Height = This.Object.compute_rowheight[row]
	
	IF ll_Height = ci_Collapse THEN
		This.Event ue_ExpandDetail(row, ci_Expand)
	ELSE
		This.Event ue_CollapseDetail(row)
	END IF
	
END IF

end event

