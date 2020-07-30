$PBExportHeader$u_dw_quickmatch.sru
forward
global type u_dw_quickmatch from u_dw
end type
end forward

global type u_dw_quickmatch from u_dw
integer width = 672
integer height = 712
boolean titlebar = true
string dataobject = "d_quickmatch_display"
boolean controlmenu = true
boolean minbox = true
boolean vscrollbar = false
string icon = "AppIcon!"
boolean livescroll = false
boolean ib_isupdateable = false
event ue_dwrestrict ( n_cst_restrictioncriteria anv_criteria )
event ue_undorestriction ( string as_dwtype )
end type
global u_dw_quickmatch u_dw_quickmatch

type variables
Datastore	ids_droppedRow
u_dw			idw_source
u_dw			idw_newSource
Window		iw_SourceParent
Long			ila_unidentifiedLocators[]
end variables

forward prototypes
public function integer of_qmicon (string as_path)
public function integer of_addunidentifiedid (long al_siteid)
end prototypes

event ue_dwrestrict(n_cst_restrictioncriteria anv_criteria);Long	lla_temp[]

//replace the old array with a new one
ila_unidentifiedlocators = lla_temp

If isValid( this.inv_myPropManager ) THEN
	inv_myPropManager.event ue_restrictdws( anv_criteria, this )
	IF isValid(w_QuickMatch) THEN
		w_QuickMatch.Event ue_DisplayFailedMatches( ila_unidentifiedLocators[] )
	END iF
END IF
end event

event ue_undorestriction(string as_dwtype);if isValid( inv_mypropmanager ) THEN
	IF as_dwType = "DRIVER_EQUIP" THEN
		inv_myPropManager.event ue_clearRestrictions( "DRIVERS" )
		inv_myPropManager.event ue_clearRestrictions( "EQUIPMENT" )
	ELSE
		inv_myPropManager.event ue_clearRestrictions( as_dwType )
	END IF
	
	//Reset newSource and icons
	IF isValid( idw_newSource )THEN
		IF isValid(iw_SourceParent) THEN
			iw_SourceParent.CloseUserObject( idw_newSource )
		END iF
		This.of_QmIcon("")
		This.Icon = "ptools.ico"
		This.SetItem( 1, "droppedItem", "" )
	END IF
END IF
end event

public function integer of_qmicon (string as_path);
CHOOSE CASE as_path
	CASE "tracter.ico"  //Tractor
		This.Object.P_Icon.FileName = "dyn_tracter.bmp"
	CASE "st.ico"  //Straight Truck
		This.Object.P_Icon.FileName = "dyn_st.bmp"
	CASE "van.ico"  //Van
		This.Object.P_Icon.FileName = "dyn_van.bmp"
	CASE "2u.ico"  //Container
		This.Object.P_Icon.FileName = "dyn_2u.bmp"
	CASE "4u.ico"  //Container
		This.Object.P_Icon.FileName = "dyn_4u.bmp"	
	CASE "2z.ico"  //Chassis
		This.Object.P_Icon.FileName = "dyn_2z.bmp"
	CASE "4z.ico"  //Chassis
		This.Object.P_Icon.FileName = "dyn_4z.bmp"
	CASE "2f.ico"  //Flatbed
		This.Object.P_Icon.FileName = "dyn_2f.bmp"
	CASE "4f.ico"  //Flatbed"V:\bitmaps\Temp\4f.ico"
		This.Object.P_Icon.FileName = "dyn_4f.bmp"
	CASE "pup.ico" //Use general trailer icon
		This.Object.P_Icon.FileName = "dyn_pup.bmp"
	CASE "trlr.ico" //Use general trailer icon
		This.Object.P_Icon.FileName = "dyn_trlr.bmp"
	Case "driv.ico" //Use the driver icon
		This.Object.P_Icon.FileName = "dyn_driv.bmp"
	CASE "shipment1.ico" //Use the Shipment Icon
		This.Object.P_Icon.FileName = "dyn_shipment1.bmp"
	CASE ELSE
		This.Object.P_Icon.FileName = "dyn_ptoolsicon.BMP"
END CHOOSE
	
return 1

end function

public function integer of_addunidentifiedid (long al_siteid);Long 	ll_index
LOng 	ll_max
Int 	li_Return

IF al_SiteId > 0 THEN
	ll_max = upperBound( ila_unidentifiedLocators )
	FOR ll_index = 1 TO ll_max
		IF al_siteid = ila_unidentifiedLocators[ ll_index ] THEN
			RETURN 0
		END IF
	NEXT
	
	ila_unidentifiedLocators[ll_Max + 1] = al_siteId
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

on u_dw_quickmatch.create
end on

on u_dw_quickmatch.destroy
end on

event dragdrop;call super::dragdrop;long	ll_sourceRow
String	ls_className


//if dropped item was a datawindow than we want to copy the row of it into our
//local datastore so it isn't lost.
IF typeOf(source) = dataWindow! AND source.triggerEvent("ue_hasIds") = 1 THEN
	idw_source = source
	ls_className = idw_source.ClassName()
	
	ll_sourceRow = idw_source.getRow()
	iw_Sourceparent = idw_source.getParent( )
	
	//destroys the last opened item
	IF isValid( idw_newSource ) AND idw_newSource <> source THEN
		iw_sourceparent.closeUserObject( idw_newSource )
	END IF
	
	//open the a new object of the thing that was dropped in the same spot as the tool

	iw_sourceparent.openUserObject( idw_newSource, ls_className, this.x, this.y )
	
	//if successful and the source row is valid for copying, copy the row
	//that was dropped into the newly created object, and hide the new object.
	IF isValid(idw_newSource) AND ll_sourceRow > 0 THEN
		idw_newSource.visible = false
		idw_newSource.dragicon = idw_source.dragIcon
		of_qmicon(idw_Source.DragIcon)
		idw_newSource.dataObject = idw_source.dataObject
		idw_newSource.setTransobject( SQLCA )
		idw_newSource.of_setupdateable( false )
		This.Icon = idw_source.dragIcon
		IF idw_newSource.rowCount() > 0 THEN
			idw_newSource.rowsMove( 1, idw_newSource.rowCount(), PRIMARY!, idw_newSource, 1, FILTER!)
		END IF
		idw_Source.rowsCopy( ll_sourceRow, ll_sourceRow, Primary!, idw_newSource, 1, primary! )
		idw_newSource.setRow( 1 )
		IF pos( ls_className, "ship" ) > 0 THEN
			this.setItem( 1, "droppedItem", "Shipment" )
		ELSEIF pos( ls_className, "equip" ) > 0 THEN
			this.setItem( 1, "droppedItem", "Equipment" )
		ELSEIF pos( ls_className, "driv" ) > 0 THEN
			this.setItem( 1, "droppedItem", "Driver" )
		ELSE
			this.setItem( 1, "droppedItem", "Unknown Type" )
		END IF
			
	END IF
ELSE
	this.setItem( 1, "droppedItem", "Empty" )
END IF

//Open Quickmatch dialog box and pass This as the parm to hold the Master
IF NOT IsValid ( w_quickmatch ) THEN
	//JUST CAUSE FOR DOING SOMETHING SO CRAZY:  described in a series of events that lead us to
	//conclusion.
	/*  We needed to open w_quickmatch with the frame as a parent because of the following:
				1. The outermost window is a sheet, so it cannot be the parent of a popup.
				2. W_quick match is a popup because it cannot be a w_child and function correctly.
						a.  Do to a Microsoft issue, a childs editable fields can not be edited when
								a child window has a title bar.
						b.  The editable fields are sle types, using datawindows instead of sles may
								have fixed the problem, but early on we opted to create a nonvisual- structure
								type of object to pass around instead of datawindows.
						c.  We don't want to change them to datawindows now, because we pass around
							 the sles by reference and reset them and such all over the code.
				3.  Attempting to give the sheet as the parent defaults the parent to the actual frame,
					 but for some reason, the w_quickmatch window gets stuck open if the sheet is closed
					 before the app, and then we can no longer close it.
	-----------------------------------------------------------------------------------------*/
	OpenWithParm(w_QuickMatch, source, GNV_app.of_getFrame())
ELSE
	w_quickMatch.SetFocus ( )

END IF

w_quickMatch.of_setQuickMatchDw( this )

end event

event constructor;call super::constructor;this.insertRow(0)
end event

event clicked;call super::clicked;String	ls_objInfo

IF isValid( idw_source ) THEN
	ls_objInfo = this.getObjectatpointer( )
	
	//if the button wasn't clicked to clear all, then send the thing dropped into dragmode
	IF pos( ls_objInfo, "b_clearall" ) <= 0 THEN
		IF isValid(idw_NewSource) THEN
			idw_newSource.post drag( begin! )
		END IF
	END IF
END IF
end event

event buttonclicked;call super::buttonclicked;IF dwo.name = "b_clearall" THEN
  	this.event ue_undoRestriction( "ALL" )

END IF
end event

event ue_setidentifiers;call super::ue_setidentifiers;this.hScrollBar = false
end event

