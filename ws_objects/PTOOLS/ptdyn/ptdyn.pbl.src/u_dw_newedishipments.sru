$PBExportHeader$u_dw_newedishipments.sru
forward
global type u_dw_newedishipments from u_dw
end type
end forward

global type u_dw_newedishipments from u_dw
integer width = 759
integer height = 232
string dataobject = "d_newedishipments"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
event ue_initializesystemobjectproperties ( )
end type
global u_dw_newedishipments u_dw_newedishipments

type variables
Long	il_MaxShipment
end variables

event ue_initializesystemobjectproperties();//this event is what is called on all newly created system objects the first time
//it is going to be put in the database.  It will put properties in the dynamicproperty table,
//and any mouseovers or links as well.
n_cst_bso_dynamicObjectManager	lnv_manager
datastore	lds_properties
datastore	lds_objProps
datastore	lds_mouseovers
long			ll_index
int			li_continue	 = 1
constant		string cs_objectName = "New EDI Shipments"

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
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"width", "786" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"title", "New EDI Shipments" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"resizable", "true" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"controlmenu", "false" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"dataobject", "d_newedishipments" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"sqlrefreshmintime", "0" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"state", "1" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"minposy", "-1" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"normalposleft", "67" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"prefilter", "" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"height", "340" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"border", "false" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"dragscroll", "false" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"borderstyle", "stylelowered" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"sort", "" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"normalpostop", "21" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"normalposright", "341" )
	lnv_manager.of_insertNewSystemObjectProperty( lds_properties, cs_objectName,"normalposbottom", "182" )
	
	IF lds_properties.update( ) = 1 THEN
		commit;
	ELSE
		rollback;
	END IF
	
	//-----------------------Insert MouseOvers-------------------------------------------
//	lds_mouseOVers = create datastore	
//	lds_mouseOvers.dataobject = "d_mouseoverresponses"
//	lds_mouseOvers.setTransobject( SQLCA )
//	
//	ll_index = lds_mouseOvers.insertRow( 0 )
//	lds_mouseOvers.setitem( ll_index, "objectname", cs_objectName )
//	lds_mouseOvers.setitem( ll_index, "response", "col")
//	lds_mouseOvers.setitem( ll_index, "columnname", "context")
//	lds_mouseOvers.setitem( ll_index, "responsetype", "text" )
//	lds_mouseOvers.setitem( ll_index, "textexpression", "message" )
//	
//	IF lds_mouseOvers.update( ) = 1 THEN
//		commit;
//	ELSE
//		rollback;
//	END IF
	
	DESTROY lds_properties
	DESTROY lds_mouseOVers
	DESTROY lnv_manager
END IF

DESTROY lds_objProps






end event

on u_dw_newedishipments.create
end on

on u_dw_newedishipments.destroy
end on

event constructor;call super::constructor;ib_isupdateable = FALSE 
This.SetTransObject(SQLCA)

end event

event buttonclicked;call super::buttonclicked;Long	ll_RowCount
long 	i
String	ls_Value

String	ls_Null
SetNull ( ls_Null )

IF dwo.Name = "cb_new" THEN
	
	OpenSheet ( w_EdiShipmentReview, gnv_App.of_GetFrame ( ), 0, Layered! )
	Long	ll_Handle
	Long	ll_State
	//w_master 	lw_parent
	s_WindowPlacement	lstr_WinPlacement

		ll_Handle = Handle(This)
		GetWindowPlacement( ll_Handle , lstr_WinPlacement )
		ll_State = lstr_WinPlacement.showCmd
		lstr_WinPlacement.showCmd = 2 //Minimized
		SetWindowPlacement(ll_Handle, lstr_WinPlacement)
	
END IF
end event

event retrievestart;call super::retrievestart;IF THIS.RowCount ( ) > 0 THEN
	il_maxshipment = THIS.GetItemNumber( 1, "MaxShipID")
END IF
end event

event retrieveend;call super::retrieveend;Long	ll_Handle
Long	ll_State
w_master 	lw_parent
s_WindowPlacement	lstr_WinPlacement

//Normalize window if there is a new error in the log
IF rowcount >0  THEN
	
	IF THIS.GetItemNumber( 1, "MaxShipID" ) <> il_maxshipment THEN
		ll_Handle = Handle(This)
		GetWindowPlacement( ll_Handle , lstr_WinPlacement )
		ll_State = lstr_WinPlacement.showCmd
		
		IF ll_State = 2 THEN //Minimized
			lstr_WinPlacement.showCmd = 1 //Normal
			SetWindowPlacement(ll_Handle, lstr_WinPlacement)
		END IF
	
	END IF	
END IF
end event

