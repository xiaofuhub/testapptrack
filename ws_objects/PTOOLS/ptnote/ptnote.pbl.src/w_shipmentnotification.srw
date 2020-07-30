$PBExportHeader$w_shipmentnotification.srw
forward
global type w_shipmentnotification from w_response
end type
type uo_contacts from u_cst_shipment_notification within w_shipmentnotification
end type
type cb_close from u_cbok within w_shipmentnotification
end type
end forward

global type w_shipmentnotification from w_response
int X=59
int Y=16
int Width=2341
int Height=2364
boolean TitleBar=true
string Title="Notification Targets"
long BackColor=12632256
uo_contacts uo_contacts
cb_close cb_close
end type
global w_shipmentnotification w_shipmentnotification

type variables
Private:
boolean  ib_Return_Emails = False
Long	il_Eventid
end variables

forward prototypes
public function integer wf_visible ()
end prototypes

public function integer wf_visible ();
This.Visible = TRUE
uo_contacts.Visible = TRUE

Return 1
end function

event open;call super::open;
// RDT 3-12-03 Added code for SHIPMENTARRAY parm
// RDT 6-01-03 Added processing for EVENTID in message object
// RDT 8-27-03 Centered window

String					lsa_Email[]

Integer 					li_count, &
							li_Upper
s_Parm					lstr_Parm
n_cst_msg				lnv_msg
n_cst_Beo_Shipment	lnva_Shipment[]
n_cst_Beo_Shipment	lnv_Shipment

ib_DisableCloseQuery = TRUE

lnv_Msg = Message.PowerobjectParm

IF lnv_msg.of_Get_Parm ( "SHIPMENT" , lstr_Parm ) <> 0 THEN
	lnv_Shipment = lstr_Parm.ia_Value 
	uo_contacts.of_SetShipment ( lnv_Shipment )
	uo_contacts.dw_recipients.of_ShowEmailCheckBox ( FALSE )	
	uo_Contacts.of_SetReturnEmail( FALSE ) 

END IF


// RDT 3-12-03 Added code Start 
IF lnv_msg.of_Get_Parm ( "SHIPMENTARRAY" , lstr_Parm ) <> 0 THEN

	ib_Return_Emails = TRUE	// flag for window to close and return email array
	lnva_Shipment[] = lstr_Parm.ia_Value 
	uo_contacts.of_SetShipment( lnva_Shipment[] )
	uo_contacts.dw_recipients.of_ShowEmailCheckBox ( True ) 
	uo_Contacts.of_ShowShipStatus( FALSE ) 
	uo_Contacts.of_SetReturnEmail( TRUE ) 

END IF

IF lnv_msg.of_Get_Parm ( "EMAILARRAY" , lstr_Parm ) <> 0 THEN

	ib_Return_Emails = TRUE	// flag for window to close and return email array
	
	lsa_Email[] = lstr_Parm.ia_Value 
	
	If UpperBound( lsa_Email ) > 0 Then 
		uo_contacts.Post of_AdhocAddress ( lsa_Email[ ] )
		uo_contacts.dw_recipients.of_ShowEmailCheckBox ( True )
		uo_Contacts.of_ShowShipStatus( FALSE ) 
		uo_Contacts.of_SetReturnEmail( TRUE ) 
		
	End If

END IF

// RDT 3-12-03 Added code END 

// RDT 6-01-03 -Start-
IF lnv_msg.of_Get_Parm ( "EVENTID" , lstr_Parm ) <> 0 THEN
	// get id for uo_contacts to process.
	il_EventId = lstr_Parm.ia_Value  
END IF
// RDT 6-01-03 -End-

this.of_SetBase( TRUE )			// RDT 8-27-03 
this.inv_base.of_Center( )		// RDT 8-27-03 

end event

on w_shipmentnotification.create
int iCurrent
call super::create
this.uo_contacts=create uo_contacts
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_contacts
this.Control[iCurrent+2]=this.cb_close
end on

on w_shipmentnotification.destroy
call super::destroy
destroy(this.uo_contacts)
destroy(this.cb_close)
end on

event pfc_default;
CLOSE ( THIS ) 
end event

event pfc_postopen;//
uo_contacts.of_initialize()
uo_contacts.of_LoadEvents()

If il_EventId > 0 Then 
	uo_Contacts.Post of_SetEventId ( il_EventId )
End If

This.Post wf_Visible()
end event

event pfc_preopen;
This.Visible = FALSE 
uo_contacts.Visible = FALSE 

end event

type uo_contacts from u_cst_shipment_notification within w_shipmentnotification
int X=18
int Y=20
int Width=2313
int Height=2092
int TabOrder=10
boolean BringToTop=true
end type

on uo_contacts.destroy
call u_cst_shipment_notification::destroy
end on

event ue_sendnow;// RDT 4-1-03 Used to send emails from the psr window
// populate the message object and close the window.
String	ls_Address[]

If ib_return_emails Then 
	s_parm lstr_parm
	n_cst_msg lnv_Msg

	If uo_contacts.of_GetAllAddresses( ls_Address[] ) > 0 Then 
		
		lstr_parm.is_label = "ADDRESSARRAY"
		lstr_parm.ia_value = ls_Address[]
		lnv_Msg.of_add_parm(lstr_parm)
		
	Else

		lstr_parm.is_label = "NONE"
		lstr_parm.ia_value = "NONE"

	End IF
	
	CloseWithReturn( Parent, lnv_msg ) 

End IF


end event

event ue_resize;
// RDT 6-01-03 Resizes the window and moves the button based on the offsets of the uo_contacts
Long ll_Return 

ll_Return = Parent.Resize( Parent.Width + uo_contacts.of_GetXoffset(), Parent.Height + uo_contacts.of_GetYoffset() )

If ll_Return =1 then 
	
	cb_close.Move(cb_close.X + uo_contacts.of_GetXoffset(),  cb_close.Y + uo_contacts.of_GetYoffset()) 
	
End if

Return ll_Return 
end event

type cb_close from u_cbok within w_shipmentnotification
int X=987
int Y=2120
int Width=393
int Height=96
int TabOrder=20
boolean BringToTop=true
string Text="Close"
boolean Cancel=true
end type

