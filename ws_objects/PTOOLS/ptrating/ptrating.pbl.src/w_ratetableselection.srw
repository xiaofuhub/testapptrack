$PBExportHeader$w_ratetableselection.srw
forward
global type w_ratetableselection from w_response
end type
type dw_1 from u_dw within w_ratetableselection
end type
type cb_1 from u_cbok within w_ratetableselection
end type
type cb_2 from u_cbcancel within w_ratetableselection
end type
type cbx_1 from checkbox within w_ratetableselection
end type
type st_multiple from statictext within w_ratetableselection
end type
type st_shipment from statictext within w_ratetableselection
end type
type st_billto from statictext within w_ratetableselection
end type
type st_origin from statictext within w_ratetableselection
end type
type st_destination from statictext within w_ratetableselection
end type
end forward

global type w_ratetableselection from w_response
integer x = 1042
integer y = 512
integer width = 2944
integer height = 1652
string title = "Rate Table Selection"
long backcolor = 12632256
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
cbx_1 cbx_1
st_multiple st_multiple
st_shipment st_shipment
st_billto st_billto
st_origin st_origin
st_destination st_destination
end type
global w_ratetableselection w_ratetableselection

type variables
long	il_customerid
boolean	ib_pointselection
n_cst_RateData	inv_RateData
end variables

event open;call super::open;string	lsa_origin[], &
			lsa_destination[]
			
long		ll_ndx, &
			ll_max, &
			ll_row

integer  li_msgcount, &
			li_ndx
			
blob		lblb_state
n_ds		lds_ratenames
n_cst_msg	lnv_msg
s_parm	lstr_parm

lnv_Msg = message.powerobjectparm

li_MsgCount = 	lnv_msg.of_get_count()
FOR li_Ndx = 1 to li_MsgCount
	lnv_msg.of_get_parm(li_ndx, lstr_parm)
	
	CHOOSE CASE upper(lstr_parm.is_label)
				
		CASE "CUSTOMERID"
			if isnull(lstr_Parm.ia_Value ) then
				il_customerid = 0
			else
				il_customerid = lstr_Parm.ia_Value 
			end if
		CASE "DATASOURCE"
			if isvalid(lstr_Parm.ia_Value) then
				lds_ratenames = lstr_Parm.ia_Value 
			end if
		CASE "ORIGIN"
			lsa_origin = lstr_Parm.ia_Value 
			ib_pointselection = true
			st_multiple.visible=true
			cbx_1.visible=false

			
		CASE "DESTINATION"
			lsa_destination = lstr_Parm.ia_Value 
			
		CASE "RATEDATA"
			inv_ratedata = lstr_Parm.ia_value
			
			
	END CHOOSE
NEXT

//il_customerid = Message.DoubleParm
ll_max = upperbound(lsa_origin)
if ll_max > 0 then
	if isvalid ( lds_ratenames ) then
		lds_ratenames.GetFullState (lblb_State )
		dw_1.SetFullState ( lblb_State )
		dw_1.of_setinsertable ( false )
		dw_1.of_setDeleteable ( false )
	else
		dw_1.retrieve(il_customerid)
	end if
			
else
	st_multiple.visible = false
	cbx_1.visible = true
	
	if isvalid ( lds_ratenames ) then
		lds_ratenames.GetFullState (lblb_State )
		dw_1.SetFullState ( lblb_State )
		dw_1.of_setinsertable ( false )
		dw_1.of_setDeleteable ( false )
	else
		dw_1.retrieve(il_customerid)
	end if
	//filter out base tables
	if isnull(il_customerid) OR il_CustomerID = 0 then
		//no filter
		cbx_1.checked = true
		cbx_1.event clicked()
	else
		dw_1.setfilter('ratelinkbillable_billtoid = '  + string(il_customerid))
		dw_1.filter()
		if dw_1.rowcount( ) > 0 then
			//ok
		else
			//no filter
			cbx_1.checked = true
			cbx_1.event clicked()			
		end if
	end if
end if

IF isValid ( inv_ratedata ) THEN
	String	ls_Shipment
	String	ls_Billto
	String	ls_Origin
	String	ls_Destination
	Long		ll_Origin
	Long	ll_Dest
	Long ll_Shipment
	Long	ll_BilltoID
	
	ll_BilltoID = inv_Ratedata.of_Getbilltoid( )
	IF ll_billtoID > 0 THEN
		
		SELECT "companies"."co_name"  
		 INTO :ls_Billto  
		 FROM "companies"  
		WHERE "companies"."co_id" = :ll_Billtoid   ;
		Commit;
				
		IF not isNull ( ls_BillTo ) THEN
			ls_BillTo = "BillTo: " + ls_Billto 	
			st_billto.Text = ls_Billto
		END IF		
	END IF
	
	ll_Origin = inv_Ratedata.of_GetOriginid( )
	IF ll_Origin > 0 THEN
		SELECT "companies"."co_name"  
		 INTO :ls_Origin  
		 FROM "companies"  
		WHERE "companies"."co_id" = :ll_origin   ;
		Commit;

		IF Not IsNull ( ls_Origin ) THEN
			ls_Origin = "Origin: " + ls_origin
			st_origin.Text = ls_Origin
		END IF
	END IF
	
	ll_Dest = inv_ratedata.of_GetDestinationid( )
	IF ll_Dest > 0 THEN
			
		SELECT "companies"."co_name"  
		 INTO :ls_Destination  
		 FROM "companies"  
		WHERE "companies"."co_id" = :ll_Dest   ;
		Commit;
		IF Not IsNull ( ls_Destination ) THEN
			ls_Destination = "Destination: " + ls_Destination
			st_Destination.Text = ls_Destination
		END IF
	
	END IF
	
	


	ll_Shipment = inv_Ratedata.of_GetShipid( )
	IF ll_Shipment > 0 THEN
		ls_Shipment = "Shipment: " + String ( ll_Shipment )
		st_shipment.text = ls_Shipment			
	END IF	
END IF

dw_1.setrow(1)
dw_1.selectrow(0,false)
dw_1.selectrow(1,true)



end event

on w_ratetableselection.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cbx_1=create cbx_1
this.st_multiple=create st_multiple
this.st_shipment=create st_shipment
this.st_billto=create st_billto
this.st_origin=create st_origin
this.st_destination=create st_destination
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cbx_1
this.Control[iCurrent+5]=this.st_multiple
this.Control[iCurrent+6]=this.st_shipment
this.Control[iCurrent+7]=this.st_billto
this.Control[iCurrent+8]=this.st_origin
this.Control[iCurrent+9]=this.st_destination
end on

on w_ratetableselection.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cbx_1)
destroy(this.st_multiple)
destroy(this.st_shipment)
destroy(this.st_billto)
destroy(this.st_origin)
destroy(this.st_destination)
end on

event pfc_default;
Long	ll_Row
String	ls_tablename, &
			ls_Codename


ll_Row = dw_1.GetRow ( )

n_cst_Msg	lnv_Msg
s_parm		lstr_Parm
	
IF ll_Row > 0 THEN
	if ib_pointselection then
		lstr_Parm.is_Label = "ORIGIN"
		lstr_Parm.ia_Value = dw_1.object.originzone[ll_row]
		lnv_Msg.of_Add_Parm (lstr_Parm)
		
		lstr_Parm.is_Label = "DESTINATION"
		lstr_Parm.ia_Value = dw_1.object.destzone[ll_row]
		lnv_Msg.of_Add_Parm (lstr_Parm)
		
	else
		
		ls_tablename = dw_1.object.ratetable_name[ll_row]
	
		lstr_Parm.is_Label = "NAME"
		if len(ls_tablename) > 0 then
			lstr_Parm.ia_Value = ls_tablename
		else
			lstr_Parm.ia_Value = ''
		end if
		lnv_Msg.of_Add_Parm (lstr_Parm)
			
		ls_Codename = dw_1.object.ratetable_codename[ll_row]
		
		lstr_Parm.is_Label = "CODENAME"
		if len(ls_Codename) > 0 then
			lstr_Parm.ia_Value = ls_Codename
		else
			lstr_Parm.ia_Value = ''
		end if
		lnv_Msg.of_Add_Parm (lstr_Parm)
		
		lstr_Parm.is_Label = "TYPE"
		if cbx_1.checked then	
			lstr_Parm.ia_Value = 'BASE'
		else
			lstr_Parm.ia_Value = 'CUSTOMER'
		end if
		lnv_Msg.of_Add_Parm (lstr_Parm)
		
	end if

	CloseWithReturn ( THIS, lnv_msg )
	
ELSE
	MessageBox ( "Rate Table Selection" , "Please select a rate table.")
END IF


end event

event pfc_cancel;call super::pfc_cancel;CLOSE ( THIS )
end event

type cb_help from w_response`cb_help within w_ratetableselection
integer x = 2821
integer y = 1364
integer height = 64
end type

type dw_1 from u_dw within w_ratetableselection
integer x = 50
integer y = 368
integer width = 2825
integer height = 1016
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ratenames"
boolean hscrollbar = true
end type

event constructor;n_cst_presentation_RateTable 	lnv_Presentation 
lnv_Presentation.of_SetPresentation ( this )
this.settransobject(sqlca)

This.of_SetRowManager ( TRUE )
This.of_SetRowSelect ( TRUE )
This.SetRowFocusIndicator ( FocusRect! )

ib_disableclosequery = true
ib_rmbmenu = FALSE


end event

event doubleclicked;parent.TriggerEvent("pfc_default")
end event

type cb_1 from u_cbok within w_ratetableselection
integer x = 1106
integer y = 1448
integer width = 347
integer taborder = 30
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_ratetableselection
integer x = 1481
integer y = 1448
integer width = 347
integer taborder = 20
boolean bringtotop = true
end type

type cbx_1 from checkbox within w_ratetableselection
integer x = 55
integer y = 104
integer width = 603
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Show &Base Tables"
end type

event clicked;if this.checked then
	dw_1.Setfilter('ratelinkbillable_billtoid = 0')
	dw_1.Filter()
else
	if isnull(il_customerid) or il_customerid = 0 then
		//can't filter
		messagebox("Rate Table Selection", "There are no customer specific rate tables.")
		this.checked=true
	else
		dw_1.Setfilter('ratelinkbillable_billtoid = ' + string(il_customerid))
		dw_1.filter()
	end if
end if
dw_1.setrow(1)
dw_1.selectrow(0,false)
dw_1.selectrow(1,true)
dw_1.setfocus()

end event

type st_multiple from statictext within w_ratetableselection
boolean visible = false
integer x = 55
integer y = 36
integer width = 1938
integer height = 148
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Multiple origin/destination pairs were found for the selected rate table.  Please select the origin/destination pair to be used for the calculation."
boolean focusrectangle = false
end type

type st_shipment from statictext within w_ratetableselection
integer x = 59
integer y = 192
integer width = 841
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type st_billto from statictext within w_ratetableselection
integer x = 1522
integer y = 192
integer width = 1344
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type st_origin from statictext within w_ratetableselection
integer x = 59
integer y = 252
integer width = 1344
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type st_destination from statictext within w_ratetableselection
integer x = 1522
integer y = 252
integer width = 1344
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

