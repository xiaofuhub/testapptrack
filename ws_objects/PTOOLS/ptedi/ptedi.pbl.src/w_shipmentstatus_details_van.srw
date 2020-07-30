$PBExportHeader$w_shipmentstatus_details_van.srw
forward
global type w_shipmentstatus_details_van from w_response
end type
type dw_details from u_dw_shipmentstatus_details_van within w_shipmentstatus_details_van
end type
type cb_1 from u_cbok within w_shipmentstatus_details_van
end type
type cb_2 from u_cbcancel within w_shipmentstatus_details_van
end type
end forward

global type w_shipmentstatus_details_van from w_response
integer x = 800
integer y = 1040
integer width = 1531
integer height = 1024
string title = "Edi Message Detail"
long backcolor = 12632256
dw_details dw_details
cb_1 cb_1
cb_2 cb_2
end type
global w_shipmentstatus_details_van w_shipmentstatus_details_van

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

public function integer wf_validatedata ();date	ld_Date
Time	lt_Time
Int	li_Return = 1
Long	ll_Status

IF dw_Details.RowCount ( ) > 0 THEN

	ld_Date = dw_details.GetItemDate ( 1 , "shipment_status_status_date" )
	lt_Time = dw_details.GetItemTime ( 1 , "shipment_status_status_time" )
	ll_Status = dw_details.GetItemNumber ( 1 , "shipment_status_edi_status_id" )
	
	IF isNull ( ld_Date ) OR isNull ( lt_Time ) THEN
		MessageBox ( "Data Entered" , "Please make sure you enter both a date and a time." )
		li_Return = -1
	END IF
	
	IF isNull ( ll_Status ) THEN
		MessageBox ( "Data Entered" , "Please enter a status." )
		li_Return = -1
	END IF
ELSE
	li_Return = -1
	MessageBox ( "Data Entered	" , "An error occurred while attempting to vaidate the data entered." )
END IF

RETURN li_Return
end function

event open;call super::open;S_Parm 	lstr_Parm
Long		ll_NewRow
Boolean	lb_New
String	ls_EventType
int		li_Return
Date		ld_Date
Time		lt_Time

//n_ds	lds_Data

inv_msg = Message.PowerobjectParm
ib_DisableCloseQuery = TRUE
dw_details.SetTransObject ( SQLCA )  // do I need this for the dwc  ????

IF inv_Msg.of_Get_Parm ( "DATA" , lstr_Parm ) <> 0 THEN
	ids_Data = lstr_Parm.ia_Value
END IF

IF inv_Msg.of_Get_Parm ( "NEW" , lstr_Parm ) <> 0 THEN
	lb_New = lstr_Parm.ia_Value
END IF

//Blob	lblb_State
//lds_Data.GetFullState ( lblb_State )
//dw_details.SetFullState ( lblb_State )
ids_Data.ShareData ( dw_details )


// Determin what to protect   
IF lb_New THEN
	dw_Details.object.shipment_status_edi_status_id.Background.Color = RGB ( 255,255,255 )
	dw_Details.object.shipment_status_edi_Reason_id.Background.Color = RGB ( 255,255,255 )
ELSE
	dw_Details.object.shipment_status_edi_status_id.Protect = 1
	dw_Details.object.shipment_status_edi_Reason_id.Protect = 1
END IF

// this will get the children and retrieve so the display will be right
dw_Details.of_GetChildren ( )
dw_Details.of_FilterReason ( )

// if it is new then only a subset of statuses are available to pick from
IF lb_New THEN
	dw_Details.of_filterStatusForNew ( )
ELSE
	dw_Details.of_filterStatus ( )
	dw_Details.object.cb_eta.visible = false
END IF

// the shipment status date and time will determine if the date and time can me modified
// if it is a confermation event the message can't be modified.
ld_Date = dw_details.GetItemDate ( 1 , "shipment_status_status_date" )
lt_Time = dw_details.GetItemTime ( 1 , "shipment_status_status_time" )

IF isNull ( ld_Date ) AND NOT lb_New THEN
	dw_Details.object.shipment_status_status_date.Protect = 1
ELSEIF lb_New THEN
	dw_Details.of_InitializeDate ( )
	dw_Details.object.shipment_status_status_date.Background.Color = RGB ( 255,255,255 )
ELSE
	dw_details.SetItem ( 1 , "shipment_status_status_date", ld_Date )
END IF
	
IF isNull ( lt_Time ) AND NOT lb_New  THEN
	dw_Details.object.shipment_status_status_time.Protect = 1
ELSEIF lb_New THEN
	dw_Details.of_InitializeTime ( )
	dw_Details.object.shipment_status_status_time.Background.Color = RGB ( 255,255,255 )
ELSE 
	 dw_details.SetItem ( 1 , "shipment_status_status_time", lt_Time )
END IF

IF li_Return = -1 THEN
	MessageBox ("EDI Detail" , "An error occurred while attempting to retrieve the detail. Processing will stop." )
	CLOSE ( THIS )
END IF


end event

on w_shipmentstatus_details_van.create
int iCurrent
call super::create
this.dw_details=create dw_details
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_details
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_shipmentstatus_details_van.destroy
call super::destroy
destroy(this.dw_details)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event pfc_cancel;call super::pfc_cancel;ib_Cancel = TRUE

CLOSE ( THIS )
end event

event pfc_postopen;dw_details.SetItemStatus ( 1, 0, PRIMARY!, NewModified!	 )
dw_details.SetItemStatus ( 1, 0, PRIMARY!, NotModified! )
end event

event closequery;call super::closequery;//
//Long	ll_Rtn
//
//IF NOT ib_Cancel THEN
//	IF dw_details.ModifiedCount ( ) > 0 THEN
//			
//		IF inv_EdiManager.of_SearchAndReplaceDuplicates ( dw_Details , il_SourceRow) <> 1 THEN
//			MessageBox ( "Change of Message" , "An error occurred while attempting to verify the uniqueness of the message generated." )
//		END IF
//	END IF
//ELSE 
////	inv_EdiManager.of_CanceledEditOfRow ( il_SourceRow )
//END IF
//
//RETURN ll_Rtn
end event

event pfc_default;//Blob	lblb_State
//n_ds	lds_Data


IF THIS.wf_ValidateData ( ) = 1 THEN
	ib_Cancel = FALSE
//	dw_details.GetFullState ( lblb_State )
//	lds_Data.SetFullState ( lblb_State )
	
	CLOSEWithReturn  ( THIS, ids_Data )
END IF
end event

type cb_help from w_response`cb_help within w_shipmentstatus_details_van
end type

type dw_details from u_dw_shipmentstatus_details_van within w_shipmentstatus_details_van
integer x = 37
integer y = 32
integer width = 1440
integer height = 748
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;ib_rmbMenu = FALSE
end event

type cb_1 from u_cbok within w_shipmentstatus_details_van
integer x = 494
integer y = 796
integer width = 233
integer taborder = 20
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_shipmentstatus_details_van
integer x = 773
integer y = 796
integer width = 233
integer taborder = 30
boolean bringtotop = true
end type

