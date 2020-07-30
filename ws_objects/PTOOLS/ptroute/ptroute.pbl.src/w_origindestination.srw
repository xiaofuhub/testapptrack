$PBExportHeader$w_origindestination.srw
forward
global type w_origindestination from w_response
end type
type cbx_destination from checkbox within w_origindestination
end type
type ddlb_origin from dropdownlistbox within w_origindestination
end type
type ddlb_destination from dropdownlistbox within w_origindestination
end type
type cb_ok from u_cbok within w_origindestination
end type
type cb_2 from u_cbcancel within w_origindestination
end type
type st_1 from statictext within w_origindestination
end type
type st_2 from statictext within w_origindestination
end type
type cb_originlist from commandbutton within w_origindestination
end type
type cb_destination from commandbutton within w_origindestination
end type
type st_firstlocation from statictext within w_origindestination
end type
type st_used from statictext within w_origindestination
end type
type cbx_origin from checkbox within w_origindestination
end type
type gb_1 from groupbox within w_origindestination
end type
type gb_2 from groupbox within w_origindestination
end type
end forward

global type w_origindestination from w_response
integer x = 1861
integer y = 504
integer width = 859
integer height = 1172
string title = "Origin / Destination"
boolean controlmenu = false
cbx_destination cbx_destination
ddlb_origin ddlb_origin
ddlb_destination ddlb_destination
cb_ok cb_ok
cb_2 cb_2
st_1 st_1
st_2 st_2
cb_originlist cb_originlist
cb_destination cb_destination
st_firstlocation st_firstlocation
st_used st_used
cbx_origin cbx_origin
gb_1 gb_1
gb_2 gb_2
end type
global w_origindestination w_origindestination

type variables
n_cst_Msg	inv_Msg
Long	il_Origin
Long	il_Destination
Boolean	ib_LookUp

end variables

event open;call super::open;Long		lla_DockIds []
String	lsa_DockDescriptions[]
int		i
Int		li_DockCount

inv_Msg = Message.PowerObjectParm
n_cst_CrossDock lnv_CrossDock
lnv_CrossDock = CREATE n_cst_CrossDock

ib_LookUp = TRUE

li_DockCount = lnv_CrossDock.of_GetDockDescriptions ( lla_DockIds, lsa_DockDescriptions )

FOR i = 1 TO li_DockCount
	ddlb_origin.AddItem ( lsa_DockDescriptions [ i ] )
	ddlb_destination.AddItem ( lsa_DockDescriptions [ i ] )
NEXT

Destroy lnv_CrossDock
end event

event pfc_cancel;call super::pfc_cancel;S_Parm		lstr_Parm
n_cst_msg	lnv_Msg

lstr_Parm.is_Label = "CONTINUE" 
lstr_Parm.ia_Value = FALSE
lnv_Msg.of_Add_Parm ( lstr_Parm )

CLOSEWithReturn  ( THIS , lnv_Msg )
end event

on w_origindestination.create
int iCurrent
call super::create
this.cbx_destination=create cbx_destination
this.ddlb_origin=create ddlb_origin
this.ddlb_destination=create ddlb_destination
this.cb_ok=create cb_ok
this.cb_2=create cb_2
this.st_1=create st_1
this.st_2=create st_2
this.cb_originlist=create cb_originlist
this.cb_destination=create cb_destination
this.st_firstlocation=create st_firstlocation
this.st_used=create st_used
this.cbx_origin=create cbx_origin
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_destination
this.Control[iCurrent+2]=this.ddlb_origin
this.Control[iCurrent+3]=this.ddlb_destination
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.cb_originlist
this.Control[iCurrent+9]=this.cb_destination
this.Control[iCurrent+10]=this.st_firstlocation
this.Control[iCurrent+11]=this.st_used
this.Control[iCurrent+12]=this.cbx_origin
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
end on

on w_origindestination.destroy
call super::destroy
destroy(this.cbx_destination)
destroy(this.ddlb_origin)
destroy(this.ddlb_destination)
destroy(this.cb_ok)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_originlist)
destroy(this.cb_destination)
destroy(this.st_firstlocation)
destroy(this.st_used)
destroy(this.cbx_origin)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event pfc_default;String	ls_Origin
Long		ll_OriginID
String 	ls_Destination
Long		ll_DestinationID
Int		li_Index
Long		lla_DockIds []
String	lsa_DockDescriptions[]
String	ls_OriginPCM
String	ls_DestinationPCM
Long		ll_Find

Int	li_DockCount

inv_Msg = Message.PowerObjectParm

n_csT_Msg	lnv_Msg
S_Parm 		lstr_parm
n_cst_CrossDock lnv_CrossDock
lnv_CrossDock = CREATE n_cst_CrossDock

li_DockCount = lnv_CrossDock.of_GetDockDescriptions ( lla_DockIds, lsa_DockDescriptions )

IF cbx_origin.Checked THEN
	
	IF il_Origin > 0 THEN
		ll_Originid = il_Origin
	ELSE
		li_Index = ddlb_origin.FindItem ( ddlb_origin.Text , 0 )
		IF li_Index > 0 THEN
			ll_OriginID = lla_DockIDs [ li_Index ]	
		END IF
	END IF
		
END IF
	

n_cst_beo_company	lnv_Company
lnv_Company = CREATE n_cst_beo_company
lnv_Company.of_SetUseCache ( TRUE )



IF cbx_destination.Checked THEN
	IF il_Destination > 0 THEN
		ll_DestinationID = il_Destination
	ELSE
		li_Index = ddlb_destination.FindItem ( ddlb_destination.Text , 0 )
		
		IF li_Index > 0 THEN
			ll_DestinationID = lla_DockIDs [ li_Index ]	
		END IF
	END IF
END IF

IF ll_OriginID > 0 THEN
	gnv_cst_companies.of_Cache ( ll_OriginID , TRUE )
	ll_Find = gnv_cst_companies.of_Find ( ll_OriginID ) 
	
	IF ll_Find > 0 THEN
		lnv_Company.of_SetSourceRow ( ll_Find ) 
		
		IF lnv_Company.of_HasSource ( ) THEN
			ls_OriginPCM = lnv_Company.of_GetLocator ( )
		END IF
	END IF
	
END IF

IF ll_DestinationID > 0 THEN
	gnv_cst_companies.of_Cache ( ll_DestinationID , TRUE )
	ll_Find = gnv_cst_companies.of_Find ( ll_DestinationID ) 

	IF ll_Find > 0 THEN
		lnv_Company.of_SetSourceRow ( ll_Find ) 
		
		IF lnv_Company.of_HasSource ( ) THEN
			ls_DestinationPCM = lnv_Company.of_GetLocator ( )
		END IF
	END IF
	
END IF

IF Len ( ls_OriginPCM ) > 0 THEN
	lstr_Parm.ia_Value = ls_OriginPCM
	lstr_Parm.is_Label = "ORIGIN"
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

IF Len ( ls_DestinationPCM ) > 0 THEN
	lstr_Parm.ia_Value = ls_DestinationPCM
	lstr_Parm.is_Label = "DESTINATION"
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

DESTROY lnv_Company

CLOSEWithReturn ( THIS , lnv_Msg )

end event

type cb_help from w_response`cb_help within w_origindestination
end type

type cbx_destination from checkbox within w_origindestination
integer x = 55
integer y = 508
integer width = 608
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Specify Destination"
end type

event clicked;ddlb_destination.Enabled = THIS.Checked
cb_destination.Enabled = THIS.Checked
cb_ok.default = Not This.Checked 
IF Not THIS.Checked THEN
	ddlb_destination.Text = ""
	il_Destination = 0
END IF

end event

type ddlb_origin from dropdownlistbox within w_origindestination
event ue_lookuporigin ( )
integer x = 55
integer y = 200
integer width = 731
integer height = 404
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_lookuporigin;il_origin = 0
Long		lla_DockIds []
String	lsa_DockDescriptions[]
int		i
Int		li_DockCount
Boolean	lb_Found
//MessageBox ( " a " , "SELECTION " )
inv_Msg = Message.PowerObjectParm
n_cst_CrossDock lnv_CrossDock
lnv_CrossDock = CREATE n_cst_CrossDock

li_DockCount = lnv_CrossDock.of_GetDockDescriptions ( lla_DockIds, lsa_DockDescriptions )

For i = 1 TO li_DockCount
	IF lsa_DockDescriptions [i] = THIS.Text THEN
		lb_Found = TRUE
		EXIT
	END IF
NEXT

IF lb_Found THEN
	il_Origin = lla_DockIds [ i ]
END IF
	

Destroy lnv_CrossDock

end event

event selectionchanged;//il_origin = 0
//Long		lla_DockIds []
//String	lsa_DockDescriptions[]
//int		i
//Int		li_DockCount
//Boolean	lb_Found
//MessageBox ( " a " , "SELECTION " )
//inv_Msg = Message.PowerObjectParm
//n_cst_CrossDock lnv_CrossDock
//lnv_CrossDock = CREATE n_cst_CrossDock
//
//li_DockCount = lnv_CrossDock.of_GetDockDescriptions ( lla_DockIds, lsa_DockDescriptions )
//
//For i = 1 TO li_DockCount
//	IF lsa_DockDescriptions [i] = THIS.Text THEN
//		lb_Found = TRUE
//		EXIT
//	END IF
//NEXT
//
//IF lb_Found THEN
//	il_Origin = lla_DockIds [ i ]
//END IF
//	
//
//Destroy lnv_CrossDock
//
ib_LookUp = FALSE
this.Post Event ue_LookupOrigin ( )
end event

event modified;IF ib_LookUp THEN
	Constant Boolean	lb_AllowHold = TRUE
	Constant Boolean	lb_Notify = FALSE
	Long		ll_ValidateId = 0
	
	Boolean	lb_Search = false
	Boolean  lb_Employee 
	Boolean	lb_Company
	Boolean	lb_validate
	String	ls_Search = ""
	String	ls_type
	Long		ll_EntityId
	String	ls_MessageHeader
	integer	li_Return
	S_co_info	lstr_Company
	
	
	IF Len ( THIS.Text ) > 0 THEN
		lb_Search = TRUE
		ls_Search =  THIS.Text
	END IF
	
	li_Return = gnv_cst_Companies.of_Select &
		( lstr_company, ls_Type, lb_Search, ls_Search, lb_Validate, &
		  ll_ValidateId, lb_AllowHold, lb_Notify )
	 
	THIS.Text = lstr_Company.Co_Name
	il_Origin = lstr_Company.co_id
	
	 
	return li_Return
END IF

ib_Lookup = TRUE
end event

type ddlb_destination from dropdownlistbox within w_origindestination
event ue_lookupdestination ( )
integer x = 55
integer y = 688
integer width = 731
integer height = 392
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_lookupdestination;il_origin = 0
Long		lla_DockIds []
String	lsa_DockDescriptions[]
int		i
Int		li_DockCount
Boolean	lb_Found
//MessageBox ( " a " , "SELECTION " )
inv_Msg = Message.PowerObjectParm
n_cst_CrossDock lnv_CrossDock
lnv_CrossDock = CREATE n_cst_CrossDock

li_DockCount = lnv_CrossDock.of_GetDockDescriptions ( lla_DockIds, lsa_DockDescriptions )

For i = 1 TO li_DockCount
	IF lsa_DockDescriptions [i] = THIS.Text THEN
		lb_Found = TRUE
		EXIT
	END IF
NEXT

IF lb_Found THEN
	il_Destination = lla_DockIds [ i ]
END IF
	

Destroy lnv_CrossDock

end event

event selectionchanged;il_Destination = 0
ib_LookUp = FALSE
THIS.Post Event ue_LookUpDestination ( )
end event

event modified;IF ib_LookUp THEN
	Constant Boolean	lb_AllowHold = TRUE
	Constant Boolean	lb_Notify = FALSE
	Long		ll_ValidateId = 0
	
	Boolean	lb_Search = false
	Boolean  lb_Employee 
	Boolean	lb_Company
	Boolean	lb_validate
	String	ls_Search = ""
	String	ls_type
	Long		ll_EntityId
	String	ls_MessageHeader
	integer	li_Return
	S_co_info	lstr_Company
	IF Len ( THIS.Text ) > 0 THEN
	
		lb_Search = TRUE
		ls_Search =  THIS.Text
	
	END IF
	
	li_Return = gnv_cst_Companies.of_Select &
		( lstr_company, ls_Type, lb_Search, ls_Search, lb_Validate, &
		  ll_ValidateId, lb_AllowHold, lb_Notify )
	 
	ddlb_destination.Text = lstr_Company.Co_Name
	il_destination = lstr_Company.co_id
	
	 
	return li_Return
END IF
ib_Lookup = TRUE
end event

type cb_ok from u_cbok within w_origindestination
integer x = 133
integer y = 952
integer width = 233
integer taborder = 70
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_origindestination
integer x = 453
integer y = 952
integer width = 233
integer taborder = 80
boolean bringtotop = true
end type

type st_1 from statictext within w_origindestination
integer x = 59
integer y = 144
integer width = 398
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Location / docks"
boolean focusrectangle = false
end type

type st_2 from statictext within w_origindestination
integer x = 64
integer y = 624
integer width = 407
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Location / docks"
boolean focusrectangle = false
end type

type cb_originlist from commandbutton within w_origindestination
integer x = 530
integer y = 100
integer width = 247
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "List"
end type

event clicked;Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Long		ll_ValidateId = 0
Boolean	lb_Search = false
Boolean  lb_Employee 
Boolean	lb_Company
Boolean	lb_validate
String	ls_Search = ""
String	ls_type
Long		ll_EntityId
String	ls_MessageHeader
integer	li_Return
S_co_info	lstr_Company
//IF Len ( as_Entity ) > 0 THEN
//
//	lb_Search = TRUE
//	ls_Search = as_Entity
//
//END IF
//
li_Return = gnv_cst_Companies.of_Select &
	( lstr_company, ls_Type, lb_Search, ls_Search, lb_Validate, &
	  ll_ValidateId, lb_AllowHold, lb_Notify )
 
ddlb_origin.Text = lstr_Company.Co_Name
il_Origin = lstr_Company.co_id

 
return li_Return
end event

type cb_destination from commandbutton within w_origindestination
integer x = 530
integer y = 596
integer width = 247
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "List"
end type

event clicked;Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Long		ll_ValidateId = 0

Boolean	lb_Search = false
Boolean  lb_Employee 
Boolean	lb_Company
Boolean	lb_validate
String	ls_Search = ""
String	ls_type
Long		ll_EntityId
String	ls_MessageHeader
integer	li_Return
S_co_info	lstr_Company
//IF Len ( as_Entity ) > 0 THEN
//
//	lb_Search = TRUE
//	ls_Search = as_Entity
//
//END IF
//
li_Return = gnv_cst_Companies.of_Select &
	( lstr_company, ls_Type, lb_Search, ls_Search, lb_Validate, &
	  ll_ValidateId, lb_AllowHold, lb_Notify )
 
ddlb_destination.Text = lstr_Company.Co_Name
il_destination = lstr_Company.co_id

 
return li_Return
end event

type st_firstlocation from statictext within w_origindestination
integer x = 78
integer y = 292
integer width = 622
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
string text = "First specified location"
boolean focusrectangle = false
end type

type st_used from statictext within w_origindestination
integer x = 82
integer y = 360
integer width = 343
integer height = 56
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
string text = "will be used."
boolean focusrectangle = false
end type

type cbx_origin from checkbox within w_origindestination
integer x = 55
integer y = 28
integer width = 462
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Specify Origin "
end type

event clicked;ddlb_origin.Enabled = THIS.Checked
cb_originlist.Enabled = THIS.Checked
st_firstlocation.Visible = Not This.Checked 
st_used.Visible = Not This.Checked 
cb_ok.default = Not This.Checked 

IF Not THIS.Checked THEN
	ddlb_origin.Text = ""
	il_origin = 0
END IF

THIS.Post SetPosition ( toTop! ) 

end event

type gb_1 from groupbox within w_origindestination
integer x = 32
integer y = 40
integer width = 777
integer height = 416
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_origindestination
integer x = 32
integer y = 516
integer width = 777
integer height = 360
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

