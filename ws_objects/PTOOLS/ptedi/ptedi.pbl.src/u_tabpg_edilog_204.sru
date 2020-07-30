$PBExportHeader$u_tabpg_edilog_204.sru
forward
global type u_tabpg_edilog_204 from u_tabpg_edilog
end type
type st_1 from statictext within u_tabpg_edilog_204
end type
end forward

global type u_tabpg_edilog_204 from u_tabpg_edilog
string text = "204"
st_1 st_1
end type
global u_tabpg_edilog_204 u_tabpg_edilog_204

forward prototypes
public subroutine of_send ()
end prototypes

public subroutine of_send ();// override ancestor
end subroutine

on u_tabpg_edilog_204.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on u_tabpg_edilog_204.destroy
call super::destroy
destroy(this.st_1)
end on

event constructor;call super::constructor;//Extending Ancestor
long	ll_Company
Long	lla_Shipments[]
String	ls_Select

dw_1.SetTransObject(SQLCA)

ll_Company = this.of_getCompany( )
THIS.of_Getshipment( lla_Shipments )
IF ll_Company > 0 THEN
	dw_1.retrieve(ll_Company)
ELSEIF UpperBound ( lla_Shipments ) > 0 THEN
	ls_Select = "Select * from edi where sourceid = " + String (lla_Shipments[1] ) + " and transactionset = 204"
	dw_1.Modify ( "DataWindow.Table.Select ='" + ls_Select +"'" )
	dw_1.retrieve(lla_Shipments[1])	
END IF

//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_1
inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
	ldo_Reference.Y + ldo_Reference.Height + li_Border )

//Register resizable controls
This.inv_resize.of_Register ( dw_1, 'ScaleToRight&Bottom' )

//Trigger resize event to perform initial resize of tabpage contents
This.TriggerEvent ( "Resize" )


RETURN AncestorReturnValue
end event

type dw_1 from u_tabpg_edilog`dw_1 within u_tabpg_edilog_204
integer x = 37
integer y = 84
integer width = 1714
integer height = 844
string dataobject = "d_edilog_204"
end type

event dw_1::doubleclicked;call super::doubleclicked;String	ls_Data
Long		ll_Source
s_Parm	lstr_parm
n_cst_msg	lnv_Msg

IF Row > 0 THEN
	ls_Data = THIS.GetItemString ( row , "edi_source" )
	lstr_parm.ia_value = ls_Data
	lstr_parm.is_label = "TEXT"
	lnv_Msg.of_Add_parm( lstr_parm)
	
	lstr_parm.ia_value = "EDI 204 Data"
	lstr_parm.is_label = "TITLE"
	lnv_Msg.of_Add_parm( lstr_parm)
	
	OpenWithParm ( W_mle , lnv_Msg )
END IF

end event

type st_1 from statictext within u_tabpg_edilog_204
integer x = 37
integer y = 12
integer width = 503
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Double click for details"
boolean focusrectangle = false
end type

