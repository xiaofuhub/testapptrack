$PBExportHeader$w_zoneselect.srw
forward
global type w_zoneselect from w_response
end type
type dw_zones from u_dw_zone within w_zoneselect
end type
type gb_1 from groupbox within w_zoneselect
end type
type cb_1 from u_cbok within w_zoneselect
end type
type cb_2 from u_cbcancel within w_zoneselect
end type
end forward

global type w_zoneselect from w_response
integer x = 306
integer y = 488
integer width = 2386
integer height = 1008
string title = "Select Zone"
long backcolor = 12632256
dw_zones dw_zones
gb_1 gb_1
cb_1 cb_1
cb_2 cb_2
end type
global w_zoneselect w_zoneselect

event pfc_default;String 	ls_ZoneName
String	ls_ZoneDescription

Long	ll_Row

n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

ll_Row = dw_zones.GEtRow ( )

IF ll_Row > 0 THEN
	ls_ZoneName = dw_zones.GetItemString ( ll_Row , "name" )
	ls_ZoneDescription = dw_zones.GetItemString ( ll_Row , "description" )
	
	IF Len ( ls_ZoneName ) > 0 THEN
		lstr_Parm.ia_Value = ls_ZoneName
		lstr_Parm.is_Label = "ZONE"
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.ia_Value = ls_ZoneDescription
		lstr_Parm.is_Label = "DESCRIPTION"
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
		CloseWithReturn ( THIS , lnv_Msg )
	END IF
END IF
end event

event pfc_cancel;call super::pfc_cancel;CLOSE ( THIS )
end event

on w_zoneselect.create
int iCurrent
call super::create
this.dw_zones=create dw_zones
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_zones
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on w_zoneselect.destroy
call super::destroy
destroy(this.dw_zones)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;ib_DisableCloseQuery = TRUE
end event

type dw_zones from u_dw_zone within w_zoneselect
integer x = 50
integer y = 128
integer width = 1952
integer height = 728
integer taborder = 10
boolean bringtotop = true
end type

event constructor;call super::constructor;n_cst_msg	lnv_Msg	
String 	ls_FindString
Long		ll_FindRow

S_Parm		lstr_parm

IF isValid ( Message.powerobjectParm ) THEN
	lnv_Msg = Message.powerobjectParm
END IF

THIS.Event ue_setFocusindicator ( TRUE )
THIS.of_Setinsertable ( FALSE )
THIS.of_Setdeleteable ( FALSE )
THIS.Retrieve ( )


//THIS.object.include.visible = TRUE

	
IF lnv_Msg.of_Get_Parm ( "FILTER" , lstr_Parm ) <> 0 THEN
	THIS.SetFilter( lstr_Parm.ia_Value )
	THIS.FIlter ( )
END IF

	
IF lnv_Msg.of_Get_Parm ( "NAME" , lstr_Parm ) <> 0 THEN
	ls_FindString = "name = '" + String ( lstr_Parm.ia_Value )  + "'"
END IF

IF Len ( ls_FindString ) > 0 THEN
	ll_FindRow = dw_zones.Find ( ls_FindString , 1 , 9999 ) 

	IF ll_FindRow > 0 THEN
		dw_zones.ScrollToRow ( ll_FindRow )
	END IF
END IF

		

end event

event doubleclicked;Parent.Event Pfc_Default ( )

//String ls_name
//IF Row > 0 THEN
//	ls_name = THIS.GetItemString ( row , "name" )
//	IF Len ( ls_Name ) > 0 THEN
//		CloseWithReturn ( Parent , ls_Name )
//	END IF
//END IF
end event

type gb_1 from groupbox within w_zoneselect
integer x = 27
integer y = 44
integer width = 2021
integer height = 848
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Select the zone from the list below"
end type

type cb_1 from u_cbok within w_zoneselect
integer x = 2103
integer y = 80
integer width = 233
integer taborder = 20
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_zoneselect
integer x = 2103
integer y = 196
integer width = 233
integer taborder = 11
boolean bringtotop = true
end type

