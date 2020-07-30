$PBExportHeader$u_cst_carrierlanesearch.sru
forward
global type u_cst_carrierlanesearch from u_base
end type
type uo_zones from u_cst_lanelookup within u_cst_carrierlanesearch
end type
type dw_results from u_dw_lanesearch within u_cst_carrierlanesearch
end type
type cb_search from commandbutton within u_cst_carrierlanesearch
end type
type ln_1 from line within u_cst_carrierlanesearch
end type
end forward

global type u_cst_carrierlanesearch from u_base
integer width = 3195
integer height = 1924
event ue_search ( )
uo_zones uo_zones
dw_results dw_results
cb_search cb_search
ln_1 ln_1
end type
global u_cst_carrierlanesearch u_cst_carrierlanesearch

type variables
Protected:
String cs_MsgHdr = 'Carrier Lane Search'
end variables

event ue_search();Int li_result

Boolean 	lb_Retrieve = TRUE
Boolean 	lb_DispMsg
Boolean	lb_OriginEntered
Boolean	lb_DestinationEntered

Long ll_UpperOri
Long ll_UpperDest

String ls_MsgOri
String ls_MsgDest
String	lsa_Origin[]
String	lsa_Destination []

ls_MsgOri 	= 'No zones found for Origin Location. Do you wish to view zones for Destination Location?'
ls_MsgDest 	= 'No zones found for Destination Location. Do you wish to view zones for Origin Location?'

lb_OriginEntered = Len ( uo_zones.of_getoriginlocation( ) )  > 0 OR NOT isNull ( uo_zones.of_getoriginlocation( ) ) 
lb_DestinationEntered = Len ( uo_Zones.of_Getdestinationlocation( ) ) > 0 OR NOT isNull ( uo_zones.of_Getdestinationlocation( ) )

uo_zones.of_GetZones ( lsa_Origin , lsa_Destination )

ll_UpperOri 	= 	UpperBound(lsa_Origin)
ll_UpperDest 	= 	UpperBound(lsa_Destination)	 

dw_results.Reset()

IF ll_UpperOri > 0 OR ll_UpperDest > 0 THEN
	IF ll_UpperOri > 0 AND ll_UpperDest > 0 THEN
		lb_Retrieve = TRUE
	END IF	
	
	IF ll_UpperOri <= 0 AND lb_OriginEntered THEN
		li_result = MessageBox(cs_MsgHdr,ls_MsgOri,Question!,YesNo!)
		IF li_result = 1 THEN
			uo_zones.of_ResetOrigin()
			lb_Retrieve = TRUE
		ELSE
			lb_Retrieve = FALSE
			lb_DispMsg = TRUE
		END IF
	END IF
	
	IF ll_UpperDest <= 0 AND lb_DestinationEntered THEN
		li_result = MessageBox(cs_MsgHdr,ls_MsgDest,Question!,YesNo!)
		IF li_result = 1 THEN
			uo_zones.of_ResetDest()
			lb_Retrieve = TRUE
		ELSE
			lb_Retrieve = FALSE
			lb_DispMsg = TRUE
		END IF
	END IF
	
END IF	

IF lb_Retrieve THEN
	IF dw_results.of_Retrieve ( lsa_Origin , lsa_Destination ) <= 0 THEN
		MessageBox(cs_MsgHdr,"No zones found for Origin or Destination Location")
	END IF	
ELSEIF NOT lb_DispMsg THEN
	MessageBox(cs_MsgHdr,"No zones found for Origin or Destination Location")
END IF
end event

on u_cst_carrierlanesearch.create
int iCurrent
call super::create
this.uo_zones=create uo_zones
this.dw_results=create dw_results
this.cb_search=create cb_search
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_zones
this.Control[iCurrent+2]=this.dw_results
this.Control[iCurrent+3]=this.cb_search
this.Control[iCurrent+4]=this.ln_1
end on

on u_cst_carrierlanesearch.destroy
call super::destroy
destroy(this.uo_zones)
destroy(this.dw_results)
destroy(this.cb_search)
destroy(this.ln_1)
end on

event constructor;call super::constructor;THIS.of_SetResize ( TRUE ) 
inv_Resize.of_Register ( dw_results , appeon_constant.scalerightbottom )
end event

type uo_zones from u_cst_lanelookup within u_cst_carrierlanesearch
integer x = 55
integer y = 16
integer width = 2683
integer height = 232
integer taborder = 10
boolean bringtotop = true
long backcolor = 80269524
end type

on uo_zones.destroy
call u_cst_lanelookup::destroy
end on

type dw_results from u_dw_lanesearch within u_cst_carrierlanesearch
integer x = 50
integer y = 316
integer width = 3086
integer height = 1520
integer taborder = 30
boolean bringtotop = true
end type

type cb_search from commandbutton within u_cst_carrierlanesearch
integer x = 2793
integer y = 140
integer width = 343
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Search"
boolean default = true
end type

event clicked;Parent.Event ue_Search ( )
end event

type ln_1 from line within u_cst_carrierlanesearch
long linecolor = 33554432
integer linethickness = 8
integer beginx = 50
integer beginy = 288
integer endx = 3118
integer endy = 288
end type

