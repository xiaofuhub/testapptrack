$PBExportHeader$u_dw_triplist.sru
forward
global type u_dw_triplist from u_dw
end type
end forward

global type u_dw_triplist from u_dw
int Width=3319
int Height=432
string DataObject="d_trip_list"
event ue_details ( )
end type
global u_dw_triplist u_dw_triplist

type variables
n_cst_Mediator_DataManager	inv_Mediator

end variables

event constructor;n_cst_Presentation_trip	lnv_Presentation

lnv_Presentation.of_SetPresentation ( This )


//Instantiate the Mediator Object
inv_Mediator = CREATE n_cst_Mediator_DataManager
inv_Mediator.of_RegisterTarget ( THIS , "trip" )

This.of_SetAutoFind ( TRUE )
This.of_SetAutoSort ( TRUE )
This.of_SetAutoFilter ( TRUE )
THIS.of_SetInsertable ( FALSE )
THIS.of_SetDeleteable ( FALSE )
end event

event clicked;// OVERRIDE ANCESTOR SCRIPT 

IF Keydown ( KeyAlt! ) THEN
	
	inv_Mediator.of_CreateFilterObject ( dwo , Row ) 
	
ELSE
	Super::Event clicked ( xpos,ypos,row,dwo )
	this.selectrow(0, false)
	if row > 0 then this.selectrow(row, true)
END IF
	
	


end event

event scrollvertical;parent.postevent("reset_range")
end event

event doubleclicked;if this.getselectedrow(0) > 0 then
	THIS.Event ue_Details ( )
END IF	
end event

event destructor;call super::destructor;Destroy inv_Mediator
end event

