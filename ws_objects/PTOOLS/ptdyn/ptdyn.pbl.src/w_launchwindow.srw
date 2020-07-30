$PBExportHeader$w_launchwindow.srw
forward
global type w_launchwindow from w_response
end type
type cb_open from commandbutton within w_launchwindow
end type
type dw_windows from u_dw within w_launchwindow
end type
end forward

global type w_launchwindow from w_response
integer width = 2336
integer height = 1092
string title = "Launch Window"
long backcolor = 12632256
cb_open cb_open
dw_windows dw_windows
end type
global w_launchwindow w_launchwindow

forward prototypes
public function integer of_resize ()
public function integer wf_selectwindow ()
public function integer wf_updatesystemobjects ()
private function integer wf_initializenewsystemobjects (datastore ads_systemobjects)
end prototypes

public function integer of_resize ();String	ls_DetailHeight
String	ls_HeaderHeight
Long		ll_NumRows
Long		ll_DwHeight
Long		ll_ButtonY
Long		ll_WinHeight

This.SetRedraw(FALSE)
ls_DetailHeight = dw_windows.Describe("DataWindow.Detail.Height")
ls_HeaderHeight = dw_windows.Describe("DataWindow.Header.Height")

ll_NumRows = dw_windows.RowCount() + 1 //One row added space

ll_DwHeight = (ll_Numrows * Long(ls_DetailHeight)) + Long(ls_HeaderHeight)
dw_windows.Height = ll_DwHeight

ll_ButtonY = dw_windows.Height + 150
cb_open.Y = ll_ButtonY

ll_WinHeight = ll_DwHeight + 400
This.Height = ll_WinHeight

//Resize everything if it exceeds the height of its parent
IF This.Height > This.ParentWindow( ).Height THEN
	This.Height = This.ParentWindow( ).Height
	dw_windows.Height = This.Height - 400
	ll_ButtonY = dw_windows.Height + 150
	cb_open.Y = ll_ButtonY
END IF


This.SetRedraw(TRUE)

Return 1
end function

public function integer wf_selectwindow ();Integer	li_Return
String 	ls_windowName

ls_windowName = dw_windows.GetItemString(dw_windows.GetRow(), "name")

IF NOT isNull(ls_windowName) THEN
	CloseWithReturn(w_launchwindow, ls_WindowName)
	li_return = 1
ELSE
	MessageBox("Select a Window", "No Window Selected.")
	li_Return = -1
END IF

Return li_Return
end function

public function integer wf_updatesystemobjects ();Int			li_Return = 1
Long			ll_sysMax
Long			ll_max
Long			ll_index
Long			ll_sysIndex
Long			ll_findRow

String		ls_objName
String		ls_find
n_ds			lds_systemObjects
n_ds			lds_CurrentObjects


n_cst_bso_dynamicObjectmanager lnv_manager
				
lnv_manager = create n_cst_bso_dynamicObjectmanager

//retrieve all the objects that are already in the database
lds_currentObjects = create n_ds
lds_CurrentObjects.dataobject = "d_dynamicobjects"
lds_currentObjects.setTransobject( SQLCA )
ll_max = lds_CurrentObjects.retrieve()
COMMIT;

//get the system dynamic objects
ll_sysmax =  lnv_manager.of_getSystemObjects(lds_systemObjects)

this.setRedraw( false )

IF isValid( lds_systemObjects ) THEN
	lds_systemObjects.rowCount()
	FOR ll_sysIndex = ll_sysmax TO 1 STEP -1
		ls_objName = lds_systemObjects.getItemString( ll_sysindex, "name" )
		
		ls_find = "name = '"+ls_objName+"'"
		
		ll_findRow = lds_CurrentObjects.find( ls_find, 1, ll_max )
		
		IF ll_findRow > 0 THEN
			//discard the row, cuz its already in the db.
			lds_systemObjects.rowsDiscard( ll_sysIndex, ll_sysIndex, PRIMARY! )
		ELSE
			//leave it in the datastore so that it can be updated
		END IF
	NEXT
	
	//put the objects in the db
	IF lds_systemObjects.rowCount() > 0 THEN
		
		IF lds_systemObjects.update( ) = 1 THEN
			commit;
		ELSE
			rollback;
			li_return = -1
		END IF

	END IF
END IF

//Now I have to instantiate all of the new objects so that they initialize the properties
//that they come with in the database.  The constructor of the new objects will recognize
//that they are a new object and put all the appropriate abstract properties in teh database.
IF li_return = 1 THEN
	this.wf_initializenewsystemobjects( lds_systemObjects )
END IF


this.setredraw( true )

IF isValid( lds_systemObjects ) THEN
	destroy lds_systemObjects
END IF

destroy lds_CurrentObjects
destroy lnv_manager

RETURN li_return


end function

private function integer wf_initializenewsystemobjects (datastore ads_systemobjects);//the following function opens up any new system objects.  They objects once opened...
//will do initialization of its properties in the database. This may include
//bringing in properties, links, and mouseovers.  The objects should only 
//this will open the object, and trigger an event on the object that will shoot
//alll of the properties for that object into the database.
Int	li_return = 1
Long	ll_index
Long	ll_max

String	ls_className
dragobject	ldrg_object

IF isValid( ads_systemobjects ) THEN
	ll_max = ads_systemobjects.rowCount()
	FOR ll_index = 1 TO ll_max
		ls_className = ads_systemobjects.getItemString( ll_index, "classname" )
		this.openuserobject( ldrg_object, ls_className )
		IF isValid( ldrg_object ) THEN
			//this will have to be implemented in order to initialize the properties
			//for creation
			ldrg_object.triggerevent("ue_initializeSystemObjectProperties")
			this.closeuserobject( ldrg_object )
		END IF
	NEXT
ELSE
	li_Return = -1
END IF
	
	
RETURN li_RETURN


end function

on w_launchwindow.create
int iCurrent
call super::create
this.cb_open=create cb_open
this.dw_windows=create dw_windows
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_open
this.Control[iCurrent+2]=this.dw_windows
end on

on w_launchwindow.destroy
call super::destroy
destroy(this.cb_open)
destroy(this.dw_windows)
end on

event open;call super::open;// Center window
This.of_SetBase(TRUE) 
This.inv_Base.Of_Center()

//Resize
This.of_resize()


this.wf_updatesystemobjects( )



end event

type cb_help from w_response`cb_help within w_launchwindow
boolean visible = false
end type

type cb_open from commandbutton within w_launchwindow
integer x = 1847
integer y = 852
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "open"
end type

event clicked;wf_SelectWindow()



end event

type dw_windows from u_dw within w_launchwindow
integer x = 69
integer y = 84
integer width = 2181
integer height = 700
integer taborder = 10
string dataobject = "d_dynamicobjectsmanage"
end type

event constructor;call super::constructor;String	ls_Filter

This.of_setinsertable( FALSE )
This.of_setdeleteable( FALSE )

This.SetTransObject(SQLCA)
This.Retrieve()
COMMIT; 

ls_Filter = "type = 'window'"

This.SetFilter(ls_Filter)
This.Filter()

This.modify("description.tabSequence = 0" )
This.Modify("name.TabSequence = 0")
end event

event rowfocuschanged;call super::rowfocuschanged;This.SetRow(currentRow)
This.ScrollToRow(currentRow)
end event

event doubleclicked;call super::doubleclicked;wf_SelectWindow()
end event

