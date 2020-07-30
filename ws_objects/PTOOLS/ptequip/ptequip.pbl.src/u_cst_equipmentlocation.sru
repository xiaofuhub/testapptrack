$PBExportHeader$u_cst_equipmentlocation.sru
forward
global type u_cst_equipmentlocation from u_base
end type
type st_11 from statictext within u_cst_equipmentlocation
end type
type st_10 from statictext within u_cst_equipmentlocation
end type
type st_9 from statictext within u_cst_equipmentlocation
end type
type uo_chassispu from u_cst_sle_company within u_cst_equipmentlocation
end type
type uo_trailerpu from u_cst_sle_company within u_cst_equipmentlocation
end type
type uo_trailerrtn from u_cst_sle_company within u_cst_equipmentlocation
end type
type uo_chassisrtn from u_cst_sle_company within u_cst_equipmentlocation
end type
type st_12 from statictext within u_cst_equipmentlocation
end type
end forward

global type u_cst_equipmentlocation from u_base
integer width = 1157
integer height = 288
long backcolor = 12632256
event type integer ue_chassispuadded ( long al_companyid )
event type integer ue_chassisrtnadded ( long al_companyid )
event type integer ue_trailerpuchanged ( long al_siteid )
event type integer ue_trailerrtnchanged ( long al_siteid )
st_11 st_11
st_10 st_10
st_9 st_9
uo_chassispu uo_chassispu
uo_trailerpu uo_trailerpu
uo_trailerrtn uo_trailerrtn
uo_chassisrtn uo_chassisrtn
st_12 st_12
end type
global u_cst_equipmentlocation u_cst_equipmentlocation

forward prototypes
public function integer of_setchassispusite (long al_id)
public function integer of_setchassisrtnsite (long al_id)
public function integer of_settrailerpusite (long al_ID)
public function integer of_settrailerrtnsite (long al_id)
public function long of_getchassispusite ()
public function long of_getchassisrtnsite ()
public function integer of_setenable (boolean ab_value)
public function integer of_setfocus (string as_column)
end prototypes

public function integer of_setchassispusite (long al_id);uo_chassispu.of_SetID ( al_id )
RETURN 1
end function

public function integer of_setchassisrtnsite (long al_id);n_cst_beo_Company	lnv_Company
IF al_ID > 0 THEN
	lnv_Company = CREATE n_cst_beo_Company
	
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceID ( al_ID )
	
	IF lnv_Company.of_GetTerminationlocation( ) = 'T' THEN
		st_12.Textcolor = 0
	ELSE
		st_12.Textcolor = 255
	END IF
	
	DESTROY  (lnv_Company )

END IF

uo_chassisrtn.of_SetID ( al_ID )


RETURN 1
end function

public function integer of_settrailerpusite (long al_ID);uo_trailerpu.of_SetID ( al_ID )
RETURN 1
end function

public function integer of_settrailerrtnsite (long al_id);n_cst_beo_Company	lnv_Company
IF al_ID > 0 THEN
	lnv_Company = CREATE n_cst_beo_Company
	
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceID ( al_ID )
	
	IF lnv_Company.of_GetTerminationlocation( ) = 'T' THEN
		st_11.Textcolor = 0
	ELSE
		st_11.Textcolor = 255
	END IF

END IF

uo_trailerrtn.of_setID ( al_ID )


DESTROY  (lnv_Company )

RETURN 1
end function

public function long of_getchassispusite ();RETURN uo_chassispu.of_GetID( )
end function

public function long of_getchassisrtnsite ();RETURN uo_chassisrtn.of_GetID( )
end function

public function integer of_setenable (boolean ab_value);uo_chassispu.of_Enable ( ab_value )
uo_chassisrtn.of_Enable ( ab_value )
uo_trailerpu.of_Enable ( ab_value )
uo_trailerrtn.of_Enable ( ab_value )


RETURN 1
end function

public function integer of_setfocus (string as_column);CHOOSE CASE Upper ( as_Column )
		
	CASE "CHASSISPU"
		uo_chassispu.Event ue_SetFocus ( )
	CASE "CHASSISRTN"
		uo_chassisrtn.Event ue_SetFocus ( )
	CASE "TRAILERPU"
		uo_trailerpu.Event ue_SetFocus ( )
	CASE "TRAILERRTN"
		uo_trailerrtn.Event ue_SetFocus ( )
END CHOOSE 
RETURN 1
		
end function

on u_cst_equipmentlocation.create
int iCurrent
call super::create
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.uo_chassispu=create uo_chassispu
this.uo_trailerpu=create uo_trailerpu
this.uo_trailerrtn=create uo_trailerrtn
this.uo_chassisrtn=create uo_chassisrtn
this.st_12=create st_12
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_11
this.Control[iCurrent+2]=this.st_10
this.Control[iCurrent+3]=this.st_9
this.Control[iCurrent+4]=this.uo_chassispu
this.Control[iCurrent+5]=this.uo_trailerpu
this.Control[iCurrent+6]=this.uo_trailerrtn
this.Control[iCurrent+7]=this.uo_chassisrtn
this.Control[iCurrent+8]=this.st_12
end on

on u_cst_equipmentlocation.destroy
call super::destroy
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.uo_chassispu)
destroy(this.uo_trailerpu)
destroy(this.uo_trailerrtn)
destroy(this.uo_chassisrtn)
destroy(this.st_12)
end on

type st_11 from statictext within u_cst_equipmentlocation
integer x = 581
integer y = 136
integer width = 448
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Container Return:"
boolean focusrectangle = false
end type

type st_10 from statictext within u_cst_equipmentlocation
integer x = 18
integer y = 136
integer width = 475
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Container Pick Up:"
boolean focusrectangle = false
end type

type st_9 from statictext within u_cst_equipmentlocation
integer x = 18
integer width = 512
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Chassis Pick Up:"
boolean focusrectangle = false
end type

type uo_chassispu from u_cst_sle_company within u_cst_equipmentlocation
integer x = 9
integer y = 60
integer width = 553
integer taborder = 10
boolean bringtotop = true
long backcolor = 80269524
end type

event constructor;call super::constructor;THIS.of_SetWidth ( 550 )
THIS.of_SetAccelerator ( "C" )
end event

on uo_chassispu.destroy
call u_cst_sle_company::destroy
end on

event ue_companychanged;Long	ll_ID

ll_ID = THIS.of_GetID ( ) 
Parent.Event ue_ChassisPuAdded ( ll_ID ) 
//MessageBox ( "ue_CompnayChanged " , "a" )
RETURN 1


end event

type uo_trailerpu from u_cst_sle_company within u_cst_equipmentlocation
integer x = 9
integer y = 192
integer width = 553
integer taborder = 20
boolean bringtotop = true
long backcolor = 80269524
end type

event constructor;call super::constructor;THIS.of_SetWidth ( 550 )
end event

on uo_trailerpu.destroy
call u_cst_sle_company::destroy
end on

event ue_companychanged;Long	ll_ID

ll_ID = THIS.of_GetID ( ) 
Parent.Event ue_TrailerPuChanged ( ll_ID ) 
RETURN 1


end event

type uo_trailerrtn from u_cst_sle_company within u_cst_equipmentlocation
integer x = 576
integer y = 192
integer width = 553
integer taborder = 40
boolean bringtotop = true
long backcolor = 80269524
end type

event constructor;call super::constructor;THIS.of_SetWidth ( 550 )
end event

on uo_trailerrtn.destroy
call u_cst_sle_company::destroy
end on

event ue_companychanged;Long	ll_ID

ll_ID = THIS.of_GetID ( )

n_cst_beo_Company	lnv_Company
IF ll_ID > 0 THEN
	lnv_Company = CREATE n_cst_beo_Company
	
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceID ( ll_ID )
	
	IF lnv_Company.of_GetTerminationlocation( ) = 'T' THEN
		st_11.Textcolor = 0
	ELSE
		st_11.Textcolor = 255
	END IF
ELSE
	st_11.Textcolor = 0
END IF

DESTROY  (lnv_Company )

Parent.Event ue_TrailerRtnChanged ( ll_ID ) 

RETURN 1


end event

type uo_chassisrtn from u_cst_sle_company within u_cst_equipmentlocation
integer x = 576
integer y = 60
integer width = 553
integer taborder = 30
boolean bringtotop = true
long backcolor = 80269524
end type

event constructor;call super::constructor;THIS.of_SetWidth ( 550 )
end event

on uo_chassisrtn.destroy
call u_cst_sle_company::destroy
end on

event ue_companychanged;Long	ll_ID

ll_ID = THIS.of_GetID ( )

n_cst_beo_Company	lnv_Company
IF ll_ID > 0 THEN
	lnv_Company = CREATE n_cst_beo_Company
	
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceID ( ll_ID )
	
	IF lnv_Company.of_GetTerminationlocation( ) = 'T' THEN
		st_12.Textcolor = 0
	ELSE
		st_12.Textcolor = 255
	END IF
ELSE
	st_12.Textcolor = 0
END IF

DESTROY  (lnv_Company )

Parent.Event ue_ChassisRTNAdded ( ll_ID ) 

RETURN 1

end event

type st_12 from statictext within u_cst_equipmentlocation
integer x = 585
integer width = 421
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Chassis Return:"
boolean focusrectangle = false
end type

