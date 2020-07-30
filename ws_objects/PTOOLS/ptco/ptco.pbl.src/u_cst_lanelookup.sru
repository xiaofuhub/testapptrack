$PBExportHeader$u_cst_lanelookup.sru
forward
global type u_cst_lanelookup from u_base
end type
type uo_origin from u_cst_zonelocation_basic within u_cst_lanelookup
end type
type uo_destination from u_cst_zonelocation_basic within u_cst_lanelookup
end type
type st_1 from statictext within u_cst_lanelookup
end type
type st_2 from statictext within u_cst_lanelookup
end type
end forward

global type u_cst_lanelookup from u_base
integer width = 2811
integer height = 292
uo_origin uo_origin
uo_destination uo_destination
st_1 st_1
st_2 st_2
end type
global u_cst_lanelookup u_cst_lanelookup

forward prototypes
public function integer of_getzones (ref string asa_originzones[], ref string asa_destinationzones[])
public subroutine of_resetorigin ()
public subroutine of_resetdest ()
public function string of_getoriginlocation ()
public function string of_getdestinationlocation ()
end prototypes

public function integer of_getzones (ref string asa_originzones[], ref string asa_destinationzones[]);uo_origin.of_GetZones ( asa_originzones[ ] )
uo_destination.of_GetZones ( asa_destinationzones[] )
RETURN 1
end function

public subroutine of_resetorigin ();uo_origin.of_reset( )
end subroutine

public subroutine of_resetdest ();uo_destination.of_Reset( )

end subroutine

public function string of_getoriginlocation ();RETURN uo_origin.of_GetLocation( )
end function

public function string of_getdestinationlocation ();RETURN uo_destination.of_GetLocation( )
end function

on u_cst_lanelookup.create
int iCurrent
call super::create
this.uo_origin=create uo_origin
this.uo_destination=create uo_destination
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_origin
this.Control[iCurrent+2]=this.uo_destination
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on u_cst_lanelookup.destroy
call super::destroy
destroy(this.uo_origin)
destroy(this.uo_destination)
destroy(this.st_1)
destroy(this.st_2)
end on

type uo_origin from u_cst_zonelocation_basic within u_cst_lanelookup
integer y = 64
integer width = 1312
integer taborder = 10
boolean bringtotop = true
long backcolor = 80269524
end type

on uo_origin.destroy
call u_cst_zonelocation_basic::destroy
end on

event constructor;call super::constructor;THIS.Post of_SetFocus ( "TYPE" )
end event

type uo_destination from u_cst_zonelocation_basic within u_cst_lanelookup
integer x = 1371
integer y = 64
integer width = 1326
integer taborder = 20
boolean bringtotop = true
long backcolor = 80269524
end type

on uo_destination.destroy
call u_cst_zonelocation_basic::destroy
end on

type st_1 from statictext within u_cst_lanelookup
integer width = 517
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Origin (Out bound)"
boolean focusrectangle = false
end type

type st_2 from statictext within u_cst_lanelookup
integer x = 1371
integer y = 4
integer width = 590
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Destination (In bound)"
boolean focusrectangle = false
end type

