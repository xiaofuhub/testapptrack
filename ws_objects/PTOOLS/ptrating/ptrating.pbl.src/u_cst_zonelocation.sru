$PBExportHeader$u_cst_zonelocation.sru
forward
global type u_cst_zonelocation from u_base
end type
type cb_find from commandbutton within u_cst_zonelocation
end type
type dw_zones from u_dw_ratelinkzone within u_cst_zonelocation
end type
type dw_select from u_dw_zonelocation within u_cst_zonelocation
end type
type gb_1 from groupbox within u_cst_zonelocation
end type
type cb_1 from commandbutton within u_cst_zonelocation
end type
end forward

global type u_cst_zonelocation from u_base
integer width = 2354
integer height = 404
long backcolor = 12632256
event ue_findzone ( integer ai_type,  string as_location )
event ue_selectzone ( string as_zone )
cb_find cb_find
dw_zones dw_zones
dw_select dw_select
gb_1 gb_1
cb_1 cb_1
end type
global u_cst_zonelocation u_cst_zonelocation

type variables
datawindowchild	idwc_zones
end variables

forward prototypes
public function integer of_getzones (ref string asa_zones[])
public function integer of_setfocus (string as_where)
public subroutine of_reset ()
public subroutine of_resetlocation ()
public function string of_getlocation ()
end prototypes

event ue_selectzone;//
end event

public function integer of_getzones (ref string asa_zones[]);//get values from dw_select and filter dw_zones
integer	li_type
string	ls_location
string	lsa_zones[], &
			ls_zone

n_cst_bso_zonemanager lnv_zonemanager

n_Cst_bso_Rating	lnv_Rating
lnv_Rating = CREATE n_cst_bso_Rating
			
li_type = dw_select.object.type[1]
if dw_select.accepttext() = 1 then
	choose case li_type
	//	case 1 
	//		ls_location = dw_select.object.display[1]
		case 1, 2, 3, 4
			ls_location = dw_select.object.location[1]
	end choose
	
	if len(trim(ls_location)) > 0 then
		
	
		lnv_zonemanager = lnv_Rating.of_getzonemanager()
		lnv_zonemanager.of_findzoneforlocation(ls_location, li_type, lsa_zones)
		
		asa_zones[] = lsa_Zones
	
	end if
end if

DESTROY ( lnv_Rating ) 
RETURN UpperBound ( asa_zones )
end function

public function integer of_setfocus (string as_where);CHOOSE CASE Upper ( as_Where )
		
	CASE "TYPE" , "LOCATION" , "DISPLAY"
		
		dw_select.SetColumn ( as_Where )
		dw_select.SetFocus ( )
		
END CHOOSE

RETURN 1
end function

public subroutine of_reset ();This.of_ResetLocation( )
end subroutine

public subroutine of_resetlocation ();dw_select.Object.Display[dw_select.GetRow()] 	= ""
dw_select.Object.Location[dw_select.GetRow()] 	= ""

end subroutine

public function string of_getlocation ();String	ls_Return
IF dw_select.accepttext() = 1 then
	IF dw_select.RowCount ( ) > 0 THEN
		ls_Return = dw_select.object.location[1]
	END IF
END IF
RETURN ls_Return
end function

on u_cst_zonelocation.create
int iCurrent
call super::create
this.cb_find=create cb_find
this.dw_zones=create dw_zones
this.dw_select=create dw_select
this.gb_1=create gb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_find
this.Control[iCurrent+2]=this.dw_zones
this.Control[iCurrent+3]=this.dw_select
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_1
end on

on u_cst_zonelocation.destroy
call super::destroy
destroy(this.cb_find)
destroy(this.dw_zones)
destroy(this.dw_select)
destroy(this.gb_1)
destroy(this.cb_1)
end on

type cb_find from commandbutton within u_cst_zonelocation
integer x = 2094
integer y = 72
integer width = 224
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Find"
end type

event clicked;//get values from dw_select and filter dw_zones
integer	li_type
string	ls_location
			
li_type = dw_select.object.type[1]
if dw_select.accepttext() = 1 then
	choose case li_type
	//	case 1 
	//		ls_location = dw_select.object.display[1]
		case 1, 2, 3, 4
			ls_location = dw_select.object.location[1]
	end choose
	
	if len(trim(ls_location)) > 0 then
		parent.event ue_findzone(li_type, ls_location)
	end if
end if
end event

type dw_zones from u_dw_ratelinkzone within u_cst_zonelocation
event ue_filter ( string asa_zone[] )
integer x = 59
integer y = 260
integer height = 96
integer taborder = 30
boolean bringtotop = true
end type

event ue_filter;string	ls_filter, &
			ls_inclause

n_cst_sql	lnv_sql

ls_inclause = lnv_sql.of_makeinclausefromstrings(asa_zone)

ls_filter = 'name' + ls_inclause
if isnull(ls_filter) then
	ls_filter = "name in ('')"
end if

idwc_zones.SetFilter(ls_filter)
idwc_zones.Filter()

if idwc_zones.rowcount() > 0 then
	this.object.zone[1] = idwc_zones.Getitemstring(1,'name')
	this.setfocus()
else
	this.object.zone[1] = ''
end if
end event

event constructor;call super::constructor;//this.Object.zone.Accelerator='l'
this.Object.DataWindow.header.height=0

this.Getchild('zone',idwc_zones)
end event

type dw_select from u_dw_zonelocation within u_cst_zonelocation
integer x = 41
integer y = 72
integer width = 2011
integer height = 156
integer taborder = 10
boolean bringtotop = true
boolean vscrollbar = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(SQLCA)

n_cst_Presentation_zonelocation	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

this.Object.type.Accelerator='s'
this.event pfc_insertrow()
	

end event

event itemchanged;call super::itemchanged;n_cst_String	lnv_String
String	lsa_Result[]
Long	ll_Start
Long	ll_End
Long	ll_NewRow
Long	ll_CopyRow
Long	i

ll_CopyRow = Row

CHOOSE CASE dwo.Name 
		
	CASE "location"
		IF THIS.Object.type [ row ] = 2 THEN
			lnv_String.of_ParseToArray ( data, "-" , lsa_Result ) 
			IF UpperBound ( lsa_Result ) = 2 THEN
				IF Len (  lsa_Result[1] ) = 5 AND Len ( lsa_Result [2] ) = 5 THEN
				
					IF isNumber ( lsa_Result[1] ) AND isNumber ( lsa_Result [2] ) THEN
						
						CHOOSE CASE Long ( lsa_Result[1] )
								
							CASE IS < Long ( lsa_Result [2] )
								
								ll_Start = Long( lsa_Result[1] )
								ll_End = Long ( lsa_Result[2] ) 
		
							CASE IS > Long ( lsa_Result [2] )
								
								ll_Start = Long( lsa_Result[2] )
								ll_End = Long ( lsa_Result[1] ) 
								
								
							CASE Long ( lsa_Result [2] )
								
								ll_Start = Long( lsa_Result[1] )
								ll_End = Long ( lsa_Result[2] )
								
						END CHOOSE
						
						THIS.SetRedraw ( FALSE )
						FOR i = ll_Start To ll_End 
							THIS.RowsCopy ( Row, row, PRIMARY!, THIS,99999,PRIMARY! )
							ll_NewRow = THIS.RowCount ( )
							this.object.location[ ll_NewRow ] = String ( i , "00000" )									
						NEXT
						THIS.DeleteRow ( Row )
						THIS.SetRedraw ( TRUE )
					END IF
				END IF
			END IF
		END IF
								
		
		
END CHOOSE
end event

event pfc_insertrow;call super::pfc_insertrow;String	ls_name
Long		ll_Return

ll_Return = AncestorReturnValue 

IF ll_Return > 0 THEN
	
	if this.rowcount() > 1 then
		ls_name = this.object.zonename[1]
		this.object.zonename[ll_return] = ls_name		
	end if
	
	IF ll_Return > 1 THEN
		THIS.SetItem ( ll_Return ,"type" , THIS.GetItemNumber ( ll_Return - 1  , "type" ) )
	ELSE
		THIS.SetItem ( ll_Return , "type" , appeon_constant.ci_locationtype_zip )	
	END IF
	
	
	/*Remove this when supporting multiple types*/
	THIS.SetItem ( ll_Return , "type" , appeon_constant.ci_locationtype_zip )
	
	this.ScrollToRow ( ll_Return ) 
	THIS.SetRow ( ll_Return )
	THIS.SetColumn ( "location" )
	THIS.SetFocus ( )
	
END IF

RETURN ll_Return

end event

type gb_1 from groupbox within u_cst_zonelocation
integer x = 5
integer y = 4
integer width = 2341
integer height = 388
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Locate zone(s) for a &specific location"
end type

type cb_1 from commandbutton within u_cst_zonelocation
integer x = 1147
integer y = 260
integer width = 265
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Selec&t"
end type

event clicked;parent.event ue_SelectZone(dw_zones.object.zone[1])
end event

