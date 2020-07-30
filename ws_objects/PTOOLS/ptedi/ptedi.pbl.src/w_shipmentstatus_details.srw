$PBExportHeader$w_shipmentstatus_details.srw
forward
global type w_shipmentstatus_details from w_response
end type
type st_2 from statictext within w_shipmentstatus_details
end type
type st_1 from statictext within w_shipmentstatus_details
end type
type sle_company from singlelineedit within w_shipmentstatus_details
end type
type sle_type from singlelineedit within w_shipmentstatus_details
end type
type dw_details from u_dw_shipmentstatus_details within w_shipmentstatus_details
end type
type cb_1 from u_cbok within w_shipmentstatus_details
end type
type cb_2 from u_cbcancel within w_shipmentstatus_details
end type
type dw_ediselect from datawindow within w_shipmentstatus_details
end type
type gb_1 from groupbox within w_shipmentstatus_details
end type
end forward

global type w_shipmentstatus_details from w_response
integer x = 800
integer y = 1040
integer width = 2007
integer height = 1252
string title = "Edi Message Detail"
long backcolor = 12632256
st_2 st_2
st_1 st_1
sle_company sle_company
sle_type sle_type
dw_details dw_details
cb_1 cb_1
cb_2 cb_2
dw_ediselect dw_ediselect
gb_1 gb_1
end type
global w_shipmentstatus_details w_shipmentstatus_details

type variables
PRIVATE:
Long		il_EventID
n_cst_msg	inv_msg
Long		il_SourceRow
boolean	ib_Cancel
n_cst_bso_edimanager	inv_ediManager
n_ds	ids_data
end variables

forward prototypes
public function integer wf_validatedata ()
end prototypes

public function integer wf_validatedata ();long		ll_ndx, &
			ll_count, &
			lla_coid[]
			
date		ld_Date
Time		lt_Time
Int		li_Return = 1
string	ls_Status

s_parm	lstr_parm

IF dw_Details.RowCount ( ) > 0 THEN

	ld_Date = dw_details.GetItemDate ( 1 , "statusdate" )
	lt_Time = dw_details.GetItemTime ( 1 , "statustime" )
	ls_Status = dw_details.GetItemString ( 1 , "status" )
	
	IF isNull ( ld_Date ) OR isNull ( lt_Time ) THEN
		MessageBox ( "Data Entered" , "Please make sure you enter both a date and a time." )
		li_Return = -1
	END IF
	
	IF len(trim(ls_Status)) = 0 THEN
		MessageBox ( "Data Entered" , "Please enter a status." )
		li_Return = -1
	END IF
ELSE
	li_Return = -1
	MessageBox ( "Data Entered	" , "An error occurred while attempting to vaidate the data entered." )
END IF

if li_return = 1 then
	//check for selected companies	
	ll_count = dw_ediselect.rowcount()
	for ll_ndx = 1 to ll_count
		if dw_ediselect.object.selected[ll_ndx] = 'Y' then
			lla_coid[upperbound(lla_coid) + 1] = dw_ediselect.object.id[ll_ndx]
		end if
	next
	
	if upperbound(lla_coid) > 0 then
		lstr_Parm.is_Label = "COMPANYSELECTED"
		lstr_Parm.ia_Value = lla_coid
		inv_Msg.of_Add_Parm ( lstr_Parm )	
	else
		li_return = -1
		if ll_count > 1 then
			Messagebox('Send Status', 'Please check the companies to notify.')
		else
			Messagebox('Send Status', 'Please check the company to notify.')
		end if
	end if
end if

RETURN li_Return
end function

event open;call super::open;Long		ll_NewRow, &
			ll_eventid, &
			lla_coid[], &
			ll_ndx, &
			ll_count
			
Boolean	lb_New

String	ls_EventType, &
			ls_displaytype, &
			ls_name
			
int		li_Return
Date		ld_Date
Time		lt_Time

S_Parm 	lstr_Parm

n_cst_beo_event		lnv_event
n_cst_beo_company		lnv_Company
n_cst_bso_dispatch	lnv_dispatch
n_cst_events			lnv_events

inv_msg = Message.PowerobjectParm
ib_DisableCloseQuery = TRUE
dw_details.SetTransObject ( SQLCA )  // do I need this for the dwc  ????

IF inv_Msg.of_Get_Parm ( "DATA" , lstr_Parm ) <> 0 THEN
	ids_Data = lstr_Parm.ia_Value
END IF

IF inv_Msg.of_Get_Parm ( "NEW" , lstr_Parm ) <> 0 THEN
	lb_New = lstr_Parm.ia_Value
END IF

IF inv_Msg.of_Get_Parm ( "DISPATCH" , lstr_parm ) <> 0 THEN
	lnv_dispatch	= lstr_Parm.ia_Value
END IF

IF inv_Msg.of_Get_Parm ( "COMPANY" , lstr_parm ) <> 0 THEN
	lla_coid	= lstr_Parm.ia_Value
END IF

ids_Data.ShareData ( dw_details )

lnv_event = create n_cst_beo_event

if isvalid (ids_data) then
	if ids_data.rowcount( ) > 0 then
		ll_eventid = ids_data.object.sourceid[1]
		if isvalid(lnv_dispatch) then
			lnv_dispatch.of_retrieveevents({ll_eventid})
			lnv_Event.of_SetSource ( lnv_dispatch.of_GetEventCache ( ) )
			lnv_Event.of_SetSourceId ( ll_EventId )
			
			if lnv_Event.of_HasSource ( ) THEN
				ls_EventType = lnv_event.of_gettype( )
				ls_displaytype = lnv_events.of_gettypedisplayvalue(ls_EventType)
				sle_type.text = ls_displaytype
				lnv_event.of_GetSite(lnv_company)
				if lnv_company.of_hassource( ) then
					ls_name = lnv_Company.of_GetName( )
					sle_company.text = ls_name
				end if	
			end if
		end if
	end if
end if

// Determine what to protect   
IF lb_New THEN
	dw_Details.object.status.Background.Color = RGB ( 255,255,255 )
	dw_Details.object.Reason.Background.Color = RGB ( 255,255,255 )
ELSE
	dw_Details.object.status.Protect = 1
	dw_Details.object.Reason.Protect = 1
END IF

// this will get the children and retrieve so the display will be right
dw_Details.of_GetChildren ( )
dw_Details.of_FilterReason ( )

// if it is new then only a subset of statuses are available to pick from
IF lb_New THEN
	dw_Details.of_filterStatusForNew ( )
	dw_Details.of_InitializeReason()
ELSE
	dw_Details.of_filterStatus ( )
	dw_Details.object.cb_eta.visible = false
END IF

// the shipment status date and time will determine if the date and time can me modified
// if it is a confermation event the message can't be modified.
ld_Date = dw_details.GetItemDate ( 1 , "statusdate" )
lt_Time = dw_details.GetItemTime ( 1 , "statustime" )

IF isNull ( ld_Date ) AND NOT lb_New THEN
	dw_Details.object.statusdate.Protect = 1
ELSEIF lb_New THEN
	dw_Details.of_InitializeDate ( )
	dw_Details.object.statusdate.Background.Color = RGB ( 255,255,255 )
ELSE
	dw_details.SetItem ( 1 , "statusdate", ld_Date )
END IF
	
IF isNull ( lt_Time ) AND NOT lb_New  THEN
	dw_Details.object.statustime.Protect = 1
ELSEIF lb_New THEN
	dw_Details.of_InitializeTime ( )
	dw_Details.object.statustime.Background.Color = RGB ( 255,255,255 )
ELSE 
	 dw_details.SetItem ( 1 , "statustime", lt_Time )
END IF

dw_details.setcolumn ( 'status' )

ll_count = upperbound(lla_coid)
if ll_count > 0 then
	if isvalid(lnv_Company) then
		//k
	else
		lnv_Company = create n_cst_beo_company
	end if
	lnv_Company.of_SetUseCache ( TRUE )
	
	for ll_ndx = 1 to ll_count
		
		ll_NewRow = dw_ediselect.insertrow(0)
		if ll_newrow > 0 then
			lnv_Company.of_SetSourceId ( lla_coid[ll_ndx] )
			ls_name = lnv_Company.of_GetName( )
			dw_ediselect.object.company[ll_newrow] = ls_name
			dw_ediselect.object.id[ll_newrow] = lla_coid[ll_ndx]
		end if
		
	next
else
	dw_ediselect.visible = false
	gb_1.visible = false
end if

destroy lnv_event

IF li_Return = -1 THEN
	MessageBox ("EDI Detail" , "An error occurred while attempting to retrieve the detail. Processing will stop." )
	CLOSE ( THIS )
END IF


end event

on w_shipmentstatus_details.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.sle_company=create sle_company
this.sle_type=create sle_type
this.dw_details=create dw_details
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_ediselect=create dw_ediselect
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_company
this.Control[iCurrent+4]=this.sle_type
this.Control[iCurrent+5]=this.dw_details
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.dw_ediselect
this.Control[iCurrent+9]=this.gb_1
end on

on w_shipmentstatus_details.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_company)
destroy(this.sle_type)
destroy(this.dw_details)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_ediselect)
destroy(this.gb_1)
end on

event pfc_cancel;call super::pfc_cancel;ib_Cancel = TRUE

CLOSE ( THIS )
end event

event pfc_postopen;dw_details.SetItemStatus ( 1, 0, PRIMARY!, NewModified!	 )
dw_details.SetItemStatus ( 1, 0, PRIMARY!, NotModified! )
end event

event pfc_default;s_parm	lstr_parm

IF THIS.wf_ValidateData ( ) = 1 THEN
	
	ib_Cancel = FALSE
	
	IF inv_Msg.of_Get_Parm ( "DATA" , lstr_Parm ) <> 0 THEN
		lstr_Parm.ia_Value = ids_Data
	ELSE
		lstr_Parm.is_Label = "DATA"
		lstr_Parm.ia_Value = ids_Data
		inv_Msg.of_Add_Parm ( lstr_Parm )		
	END IF
	
	CLOSEWithReturn  ( THIS, inv_Msg )
	
END IF
end event

type cb_help from w_response`cb_help within w_shipmentstatus_details
end type

type st_2 from statictext within w_shipmentstatus_details
integer x = 709
integer y = 52
integer width = 151
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Site:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_shipmentstatus_details
integer x = 114
integer y = 52
integer width = 174
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_company from singlelineedit within w_shipmentstatus_details
integer x = 878
integer y = 56
integer width = 846
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
boolean border = false
end type

type sle_type from singlelineedit within w_shipmentstatus_details
integer x = 311
integer y = 56
integer width = 343
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
boolean border = false
end type

type dw_details from u_dw_shipmentstatus_details within w_shipmentstatus_details
integer x = 46
integer y = 124
integer width = 1847
integer height = 512
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;ib_rmbMenu = FALSE
end event

type cb_1 from u_cbok within w_shipmentstatus_details
integer x = 759
integer y = 1048
integer width = 233
integer taborder = 20
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_shipmentstatus_details
integer x = 1038
integer y = 1048
integer width = 233
integer taborder = 30
boolean bringtotop = true
end type

type dw_ediselect from datawindow within w_shipmentstatus_details
integer x = 251
integer y = 704
integer width = 1499
integer height = 280
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_ediselect"
boolean vscrollbar = true
boolean border = false
end type

type gb_1 from groupbox within w_shipmentstatus_details
integer x = 114
integer y = 636
integer width = 1737
integer height = 376
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Notify"
end type

