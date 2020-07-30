$PBExportHeader$u_tab_shipmentdetail.sru
forward
global type u_tab_shipmentdetail from u_tab_detail
end type
type tabpage_custom_a from userobject within u_tab_shipmentdetail
end type
type dw_custom_a from u_dw_shipmentdetail within tabpage_custom_a
end type
type tabpage_custom_a from userobject within u_tab_shipmentdetail
dw_custom_a dw_custom_a
end type
type tabpage_custom_b from userobject within u_tab_shipmentdetail
end type
type dw_custom_b from u_dw_shipmentdetail within tabpage_custom_b
end type
type tabpage_custom_b from userobject within u_tab_shipmentdetail
dw_custom_b dw_custom_b
end type
type tabpage_brokerage from userobject within u_tab_shipmentdetail
end type
type dw_brokerage from u_dw_shipmentdetail within tabpage_brokerage
end type
type tabpage_brokerage from userobject within u_tab_shipmentdetail
dw_brokerage dw_brokerage
end type
end forward

global type u_tab_shipmentdetail from u_tab_detail
long backcolor = 12632256
tabpage_custom_a tabpage_custom_a
tabpage_custom_b tabpage_custom_b
tabpage_brokerage tabpage_brokerage
event type n_cst_bso_dispatch ue_getdispatchobject ( )
end type
global u_tab_shipmentdetail u_tab_shipmentdetail

type variables
boolean	ib_companylookup
Long	il_ShipmentID
end variables

forward prototypes
public function integer of_seteditable (boolean ab_value)
public function integer of_setshipmentid (long al_shipmentid)
end prototypes

public function integer of_seteditable (boolean ab_value);
tabpage_custom_a.dw_custom_a.Enabled = ab_Value
tabpage_custom_b.dw_custom_b.Enabled = ab_Value



RETURN 1
end function

public function integer of_setshipmentid (long al_shipmentid);//il_Shipmentid = al_ShipmentID
//tabpage_notification.of_SetShipmentID ( il_ShipmentID ) 
RETURN -1
end function

event constructor;//Set the event name that will be used to Trigger the scrolling on tabpage datawindows.
is_TargetEvent = "ue_IsShipmentDetail"


n_cst_Presentation_Shipment	lnv_Presentation
String	ls_Label

IF lnv_Presentation.Event ue_GetCustomLabel ( "CustomA", ls_Label ) = 1 THEN
	tabpage_Custom_A.Text = ls_Label
END IF

IF lnv_Presentation.Event ue_GetCustomLabel ( "CustomB", ls_Label ) = 1 THEN
	tabpage_Custom_B.Text = ls_Label
END IF

//n_cst_licenseManager	lnv_Lic

//tabpage_notification.Enabled = lnv_lic.of_HasNotificationLicense ( )
end event

on u_tab_shipmentdetail.create
this.tabpage_custom_a=create tabpage_custom_a
this.tabpage_custom_b=create tabpage_custom_b
this.tabpage_brokerage=create tabpage_brokerage
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_custom_a
this.Control[iCurrent+2]=this.tabpage_custom_b
this.Control[iCurrent+3]=this.tabpage_brokerage
end on

on u_tab_shipmentdetail.destroy
call super::destroy
destroy(this.tabpage_custom_a)
destroy(this.tabpage_custom_b)
destroy(this.tabpage_brokerage)
end on

type tabpage_custom_a from userobject within u_tab_shipmentdetail
integer x = 18
integer y = 108
integer width = 2318
integer height = 1196
long backcolor = 12632256
string text = "Custom A"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 553648127
dw_custom_a dw_custom_a
end type

on tabpage_custom_a.create
this.dw_custom_a=create dw_custom_a
this.Control[]={this.dw_custom_a}
end on

on tabpage_custom_a.destroy
destroy(this.dw_custom_a)
end on

type dw_custom_a from u_dw_shipmentdetail within tabpage_custom_a
integer width = 2318
integer height = 1196
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_shipment_custom_a"
end type

event rowfocuschanging;call super::rowfocuschanging;//Extending Ancestor

//If the NewRow being set here is not the CurrentRow on the tab control, 
//notify the tab control of the change so it can synchronize other pages, etc.

IF CurrentRow = 0 OR NewRow = 0 THEN
	//DW is constucting.  Ignore.
ELSEIF of_GetCurrentRow ( ) <> NewRow THEN
	Post of_SetCurrentRow ( NewRow )
END IF
end event

event constructor;call super::constructor;//Extending ancestor

Event ue_ShareData ( This )

n_cst_Privileges	lnv_Privs
THIS.Enabled = lnv_Privs.of_Hasentryrights( )
end event

type tabpage_custom_b from userobject within u_tab_shipmentdetail
integer x = 18
integer y = 108
integer width = 2318
integer height = 1196
long backcolor = 12632256
string text = "Custom B"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_custom_b dw_custom_b
end type

on tabpage_custom_b.create
this.dw_custom_b=create dw_custom_b
this.Control[]={this.dw_custom_b}
end on

on tabpage_custom_b.destroy
destroy(this.dw_custom_b)
end on

type dw_custom_b from u_dw_shipmentdetail within tabpage_custom_b
integer width = 2327
integer height = 1200
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_shipment_custom_b"
end type

event rowfocuschanging;call super::rowfocuschanging;//Extending Ancestor

//If the NewRow being set here is not the CurrentRow on the tab control, 
//notify the tab control of the change so it can synchronize other pages, etc.

IF CurrentRow = 0 OR NewRow = 0 THEN
	//DW is constucting.  Ignore.
ELSEIF of_GetCurrentRow ( ) <> NewRow THEN
	Post of_SetCurrentRow ( NewRow )
END IF
end event

event constructor;call super::constructor;//Extending ancestor

Event ue_ShareData ( This )

n_cst_Privileges	lnv_Privs
THIS.Enabled = lnv_Privs.of_Hasentryrights( )
end event

type tabpage_brokerage from userobject within u_tab_shipmentdetail
integer x = 18
integer y = 108
integer width = 2318
integer height = 1196
long backcolor = 12632256
string text = "Brokerage"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_brokerage dw_brokerage
end type

on tabpage_brokerage.create
this.dw_brokerage=create dw_brokerage
this.Control[]={this.dw_brokerage}
end on

on tabpage_brokerage.destroy
destroy(this.dw_brokerage)
end on

type dw_brokerage from u_dw_shipmentdetail within tabpage_brokerage
event ue_postdatetimeedit ( readonly long al_row )
integer width = 2318
integer height = 1152
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_shipment_brokerage"
end type

event ue_postdatetimeedit;//This event is called by ItemChanged and ItemError after the user has
//edited a date or time value.  It may be extended in the descendant in
//order to implement further response to these changes.

Time	lt_Null

SetNull ( lt_Null )

IF al_Row > 0 THEN

	IF IsNull ( This.Object.cutoffdate [ al_Row ] ) THEN

		IF NOT IsNull ( This.Object.cutofftime [ al_Row ] ) THEN
			This.Object.cutofftime [ al_Row ] = lt_Null
		END IF

	END IF

	IF IsNull ( This.Object.arrivaldate [ al_Row ] ) THEN

		IF NOT IsNull ( This.Object.arrivaltime [ al_Row ] ) THEN
			This.Object.arrivaltime [ al_Row ] = lt_Null
		END IF

	END IF

	IF IsNull ( This.Object.lastfreedate [ al_Row ] ) THEN

		IF NOT IsNull ( This.Object.lastfreetime [ al_Row ] ) THEN
			This.Object.lastfreetime [ al_Row ] = lt_Null
		END IF

	END IF

END IF

end event

event itemerror;call super::itemerror;date	compdate
string	ls_colname
boolean	lb_Processed
n_cst_string	lnv_string

ls_colname = dwo.name

choose case ls_colname
		
	case 'availableon', 'availableuntil'
		
		//Attempt to convert the text typed to a date
		compdate = lnv_string.of_SpecialDate(data)
	
		if isnull(compdate) then
			//Value is really invalid
	
		ELSE
			this.setitem(row, ls_colname, compdate)
		
			//The following event may be extended in the descendant to provide special handling
//			This.Event Post ue_PostDateTimeEdit ( Row )
		
			lb_Processed = TRUE
	
		END IF
	
end choose


IF NOT lb_Processed THEN
	messagebox("Edit Value", "The value you have entered is invalid.  It will be "+&
		"replaced by the previous value.")
END IF

return 3
end event

event itemchanged;call super::itemchanged;Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Boolean	lb_Search = false, &
			lb_validate
String	ls_type
integer	li_return
Long		ll_null, &
			ll_ValidateId = 0
			
S_co_info	lstr_Company

setnull(ll_null)

choose case dwo.name
	case "pay1_name"
		if len(trim(data)) > 0 then
			lb_Search = TRUE
			gnv_cst_Companies.of_Select ( lstr_company, ls_Type, lb_Search, data, lb_Validate, &
				  									ll_ValidateId, lb_AllowHold, lb_Notify )
			IF lstr_Company.co_id > 0 THEN
				this.setitem(row, 'ds_pay1_id', lstr_Company.co_id)
				this.setitem(row, 'pay1_name', lstr_Company.Co_Name)
				li_return = 2
//				this.object.ds_pay1_id[row] = lstr_Company.co_id
//				THIS.object.pay1_name[row] = lstr_Company.Co_Name
			ELSE 
				this.setitem(row, 'ds_pay1_id', ll_null)
				this.setitem(row, 'pay1_name', '')
//				THIS.object.pay1_name[row] = ""
//				this.object.ds_pay1_id[row] = ll_null
			END  IF
		end if
				
end choose

return  li_return
end event

event constructor;call super::constructor;//Extending ancestor

Event ue_ShareData ( This )


n_cst_Privileges	lnv_Privs
THIS.Enabled = lnv_Privs.of_Hasentryrights( )
end event

