$PBExportHeader$u_tabpage_route.sru
forward
global type u_tabpage_route from u_tabpg
end type
type dw_route from u_dw_route within u_tabpage_route
end type
end forward

global type u_tabpage_route from u_tabpg
int Width=2606
int Height=988
event type integer ue_routechanged ( long al_newrouteid )
dw_route dw_route
end type
global u_tabpage_route u_tabpage_route

on u_tabpage_route.create
int iCurrent
call super::create
this.dw_route=create dw_route
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_route
end on

on u_tabpage_route.destroy
call super::destroy
destroy(this.dw_route)
end on

event constructor;call super::constructor;//Extending Ancestor


//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_route
inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
	ldo_Reference.Y + ldo_Reference.Height + li_Border )

//Register resizable controls
This.inv_resize.of_Register ( dw_route, 'ScaleToRight&Bottom' )

//Trigger resize event to perform initial resize of tabpage contents
This.TriggerEvent ( "Resize" )


RETURN AncestorReturnValue
end event

type dw_route from u_dw_route within u_tabpage_route
int X=18
int Y=20
int Width=2560
int Height=944
int TabOrder=10
boolean BringToTop=true
end type

event constructor;THIS.settransObject ( sqlca )
THIS.Retrieve ( )

n_cst_Presentation_Route	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

of_SetAutoSort ( TRUE )

end event

event rowfocuschanged;call super::rowfocuschanged;Long	ll_RouteID

IF currentrow > 0 THEN
	
	ll_RouteID = THIS.Object.id[currentrow]
	Parent.Event ue_RouteChanged ( ll_RouteID )
	
END IF
end event

event pfc_addrow;call super::pfc_addrow;IF AncestorReturnValue > 0 THEN
	
	//Determine and set a value for Id

	Constant Boolean	cb_Commit = TRUE
	long	ll_NextId
	
	IF gnv_App.of_GetNextId ( "route", ll_NextId, cb_Commit ) = 1 THEN
	
		dw_route.Object.Id[AncestorReturnValue] = ll_NextId
		Parent.Event ue_RouteChanged ( ll_NextId )

	END IF

	this.ScrollToRow ( AncestorReturnValue ) 
	
END IF

Return AncestorReturnValue
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	
	//Determine and set a value for Id

	Constant Boolean	cb_Commit = TRUE
	long	ll_NextId
	
	IF gnv_App.of_GetNextId ( "route", ll_NextId, cb_Commit ) = 1 THEN
	
		dw_route.Object.Id[AncestorReturnValue] = ll_NextId
		Parent.Event ue_RouteChanged ( ll_NextId )

	END IF
	
	this.ScrollToRow ( AncestorReturnValue ) 
	
END IF

Return AncestorReturnValue
end event

