$PBExportHeader$w_noteshower.srw
$PBExportComments$[w_response]  Shows customer, shipment, event, item, and equipment notes for a shipment
forward
global type w_noteshower from w_response
end type
type mle_shipment from u_mle within w_noteshower
end type
type mle_items from u_mle within w_noteshower
end type
type mle_events from u_mle within w_noteshower
end type
type mle_equipment from u_mle within w_noteshower
end type
type st_items from u_st within w_noteshower
end type
type st_events from u_st within w_noteshower
end type
type st_equipment from u_st within w_noteshower
end type
type cb_2 from u_cb within w_noteshower
end type
type rb_shipnotes from u_rb within w_noteshower
end type
type rb_billnotes from u_rb within w_noteshower
end type
type cbx_fullscreen from u_cbx within w_noteshower
end type
type mle_billing from u_mle within w_noteshower
end type
type mle_company from u_mle within w_noteshower
end type
type rb_company from u_rb within w_noteshower
end type
end forward

global type w_noteshower from w_response
int X=14
int Y=16
int Width=3401
int Height=2364
long BackColor=80269524
mle_shipment mle_shipment
mle_items mle_items
mle_events mle_events
mle_equipment mle_equipment
st_items st_items
st_events st_events
st_equipment st_equipment
cb_2 cb_2
rb_shipnotes rb_shipnotes
rb_billnotes rb_billnotes
cbx_fullscreen cbx_fullscreen
mle_billing mle_billing
mle_company mle_company
rb_company rb_company
end type
global w_noteshower w_noteshower

type variables
n_cst_Msg	inv_Msg
Long		il_Width, &
		il_Height

end variables

forward prototypes
private function integer wf_retrievenotes (long ala_shipid[])
private function integer wf_displayship ()
private function integer wf_displaybill ()
private function integer wf_displaycompany ()
public subroutine wf_resizemle (boolean ab_fullscreen)
public subroutine wf_resizebilling (boolean ab_fullscreen)
public subroutine wf_resizeshipment (boolean ab_fullscreen)
public subroutine wf_resizecompany (boolean ab_fullscreen)
end prototypes

private function integer wf_retrievenotes (long ala_shipid[]);//
/***************************************************************************************
NAME			: of_RetrieveNotes
ACCESS		: Private 
ARGUMENTS	: Long Array	(Shipment Ids)
RETURNS		: Integer (Number of notes retrieved )
DESCRIPTION	: 
use the Dispatch object 
get the Shipment from the dispatch
get the Items from the shipment
get the events from the shipment
get the equipment for that shipment from the dispatch (of_GetEquipmentForshipment) returns n_ds

REVISION		: RDT 12-03-02
				  RDT 6-27-03 Seperated shipment, Billing and Company notes into different MLE's.
				  					Disable radio buttons if there are no notes.
				
***************************************************************************************/
Integer	li_Return, &
			li_Count

Long		lla_ShipID[], &
			lla_EquipmentID[] , &
			lla_EventID[] , &
			lla_ItemID[]
			
Boolean	lb_DestroyDispatch 
			
String	ls_Notes
String	ls_ShipmentNotes
s_Parm	lstr_Parm

lla_ShipId = ala_ShipId[]

n_cst_bso_Dispatch  lnv_Dispatch

Setpointer(HourGlass!)

n_cst_beo_Shipment  lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment

n_cst_beo_Equipment2  lnv_Equipment2 
lnv_Equipment2 = CREATE n_cst_beo_Equipment2

n_cst_beo_Company lnv_Company 
lnv_Company = Create n_cst_beo_Company 
lnv_Company.of_SetUseCache(TRUE)

n_cst_NoteManager					lnv_NoteManager
lnv_NoteManager = CREATE n_Cst_NoteManager

n_cst_beo_Equipment  			lnv_Equipment
n_cst_beo_equipmentlease2 		lnv_equipmentlease2 
n_cst_beo_EquipmentLeaseType 	lnv_EquipmentLeaseType
n_cst_beo_EquipmentLeaseType2 lnv_EquipmentLeaseType2

n_cst_beo_Item	 lnva_Items[]
n_cst_beo_Event lnva_Event[]

n_cst_Events lnv_EventService // autoinstantiated

n_ds 	lds_EquipmentCache2

IF inv_Msg.of_Get_Parm ( "DISPATCH" , lstr_Parm ) <> 0 THEN
	lnv_Dispatch = lstr_Parm.ia_Value
	lb_DestroyDispatch = FALSE	
ELSE
	lnv_Dispatch = CREATE n_cst_bso_Dispatch
	lb_DestroyDispatch = TRUE
END IF


// Retrieve shipments thru dispatch object
lnv_Dispatch.of_RetrieveShipments ( lla_ShipID[] )

// set the sources on the shipment to the dispatch caches
lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
lnv_Shipment.of_SetItemSource( lnv_Dispatch.of_GetItemCache ( ) ) 
lnv_Shipment.of_SetEventSource( lnv_Dispatch.of_GetEventCache ( ) ) 


// Shipment Loop
For li_Count = 1 to UpperBound( lla_ShipID[] )
	lnv_Shipment.of_SetSourceID( lla_ShipID[ li_Count ] )

	lnv_dispatch.of_GetEquipmentForShipment ( lla_shipid[ li_Count ] , lla_Equipmentid[] )
	lds_EquipmentCache2 = lnv_Dispatch.of_GetEquipmentCache ( )   // do not destroy

	// Get Company Notes
	ls_notes = ""
	lnv_Company.of_SetSourceID( lnv_Shipment.of_getbillto ( ) ) 
	If Len( Trim( lnv_Company.of_GetComments ( ) ) ) > 0 Then 
		//ls_notes = ls_notes + "COMPANY~r~n"+ lnv_Company.of_GetComments ( )+"~r~n"			//RDT 6-27-03
		mle_Company.Text = lnv_Company.of_GetComments ( )												//RDT 6-27-03
		This.wf_DisplayCompany()																				//RDT 6-27-03
		rb_company.Checked = TRUE 																				//RDT 6-27-03
	Else																												//RDT 6-27-03
		rb_company.Enabled = FALSE 																			//RDT 6-27-03
	End If

	// Get Billing notes
	ls_notes = ""
	If Len( Trim( lnv_Shipment.of_GetBillingComments(  ) ) ) > 0 Then 
		//ls_notes = ls_notes + "BILLING~r~n"+lnv_Shipment.of_GetBillingComments()+"~r~n" 	//RDT 6-27-03
		mle_Billing.Text =  lnv_Shipment.of_GetBillingComments()										//RDT 6-27-03
		li_Return ++
		This.wf_DisplayBill()																					//RDT 6-27-03
		rb_billnotes.Checked = TRUE 																			//RDT 6-27-03
	Else																												//RDT 6-27-03
		rb_billnotes.Enabled = FALSE 																			//RDT 6-27-03
	End If

	// Get shipment notes
	ls_notes = ""
	If Len( Trim( lnv_Shipment.of_GetShipmentComments( ) ) ) > 0 Then 
		ls_ShipmentNotes = lnv_Shipment.of_GetShipmentComments()
		lnv_NoteManager.of_FormatNotes ( ls_ShipmentNotes , ls_ShipmentNotes )
		//ls_notes = ls_notes + "SHIPMENT~r~n"+ls_ShipmentNotes+"~r~n"								//RDT 6-27-03
		mle_shipment.Text = ls_ShipmentNotes																//RDT 6-27-03
		li_Return ++
		This.wf_DisplayShip()																					//RDT 6-27-03
	Else																												//RDT 6-27-03
		rb_shipnotes.Enabled = FALSE 																			//RDT 6-27-03
	End If
	
	
	// Get Event Notes 
	ls_Notes = "" 
	lnv_shipment.of_GetEventList ( lnva_event[]  )
	For li_Count = 1 to UpperBound( lnva_event[] )
		If Len( Trim( lnva_Event[ li_Count ].of_GetNote ( ) ) ) > 0 Then 
			if ls_notes <> "" then 
				ls_notes = ls_Notes + "~r~n" 
			end if
			ls_notes = ls_Notes + lnv_EventService.of_GetTypeDisplayValue ( lnva_Event[ li_Count ].of_gettype ( ) ) &
			                    + "~r~n"+lnva_Event[ li_Count ].of_GetNote ( ) +"~r~n"
			li_Return ++
		End If
		
	Next
	mle_events.text = ls_Notes
	
	// Get Item Notes
	ls_Notes = "" 
	lnv_Shipment.of_GetItemList ( lnva_Items[] )
	For li_Count = 1 to UpperBound( lnva_Items[] )
		If Len( Trim( lnva_Items[ li_Count ].of_GetNote ( ) ) ) > 0 Then 
			if ls_notes <> "" then 
				ls_notes = ls_Notes + "~r~n" 
			end if
			ls_notes = ls_Notes + lnva_Items[li_Count].of_gettypedescription ( lnva_Items[li_Count].of_gettype() )+"~r~n"+lnva_Items[ li_Count ].of_GetNote ( )+"~r~n"
			li_Return ++
		End If
		
	Next
	mle_Items.text = ls_Notes

	// Get Equipment & lease Notes
	ls_Notes = "" 
	For li_Count = 1 to UpperBound( lla_Equipmentid[] )
		lnv_Equipment2.of_setsource ( lds_EquipmentCache2 )
		lnv_Equipment2.of_setsourceid ( lla_Equipmentid[li_Count] )
		lnv_Equipment2.of_getequipmentlease ( lnv_equipmentlease2 )
		lnv_EquipmentLeaseType2 = lnv_equipmentlease2.of_getequipmentleasetype ( )
		// equipment note
		If Len( Trim( lnv_Equipment2.of_GetNotes() ) ) > 0 Then 
			ls_Notes = ls_Notes + "EQUIP.~t "+lnv_equipment2.of_getnumber ( )+"~r~n"+lnv_Equipment2.of_GetNotes ( )+"~r~n"+"~r~n"
			li_Return ++
		Else
			ls_Notes = ls_Notes + "EQUIP.~t "+lnv_equipment2.of_getnumber ( )+"~r~n"+"~r~n"
		End If

		// equipment lease type note
		If Len( Trim( lnv_EquipmentLeaseType2.of_GetNotes() ) ) > 0 Then 
			ls_Notes = ls_Notes + "LEASE ~t "+lnv_EquipmentLeaseType2.of_getline ( )+" - "+lnv_EquipmentLeaseType2.of_gettype ( ) +"~r~n"
			ls_Notes = ls_Notes + +lnv_EquipmentLeaseType2.of_GetNotes()+"~r~n"+"~r~n"
			li_Return ++
		End If
		ls_Notes += "~r~n"

	Next
	mle_equipment.Text = ls_Notes 
	
Next

// destroy objects 
IF lb_DestroyDispatch THEN
	Destroy lnv_Dispatch
END IF

If IsValid(lnv_Equipment2) Then Destroy lnv_Equipment2
If IsValid(lnv_Shipment) 	Then Destroy lnv_Shipment
If IsValid(lnv_Equipment) 	Then Destroy lnv_Equipment
If IsValid(lnv_Company ) 	Then Destroy lnv_Company 

DESTROY ( lnv_NoteManager )

If IsValid(lnv_equipmentlease2) 		Then Destroy lnv_equipmentlease2 
If IsValid(lnv_EquipmentLeaseType) 	Then Destroy lnv_EquipmentLeaseType
If IsValid(lnv_EquipmentLeaseType2) Then Destroy lnv_EquipmentLeaseType2

Return li_Return 


end function

private function integer wf_displayship ();//
/***************************************************************************************
NAME			: wf_DisplayShip
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer (1 = success, -1=Failed) 
DESCRIPTION	: Displays the shipment MLE. Hides Billing MLE and Company MLE.

REVISION		: RDT 6-27-03
***************************************************************************************/

Integer li_Return = 1

mle_billing.HIDE()
mle_company.HIDE()

mle_shipment.SHOW()

Return li_Return 
end function

private function integer wf_displaybill ();//
/***************************************************************************************
NAME			: wf_DisplayBill
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer (1 = success, -1=Failed) 
DESCRIPTION	: Displays the Billing MLE. Hides shipment MLE and Company MLE.

REVISION		: RDT 6-27-03
***************************************************************************************/

Integer li_Return = 1

mle_company.HIDE() 
mle_shipment.HIDE()

mle_billing.SHOW() 

Return li_Return 
end function

private function integer wf_displaycompany ();//
/***************************************************************************************
NAME			: wf_DisplayBill
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer (1 = success, -1=Failed) 
DESCRIPTION	: Displays the Company MLE. Hides shipment MLE and  Billing MLE.

REVISION		: RDT 6-27-03
***************************************************************************************/

Integer li_Return = 1

mle_billing.HIDE()
mle_shipment.HIDE()

mle_company.SHOW()

Return li_Return 
end function

public subroutine wf_resizemle (boolean ab_fullscreen);//
/***************************************************************************************
NAME			: wf_ResizeMLE
ACCESS		: Private 
ARGUMENTS	: boolean	(ab_Fullscreen)
RETURNS		: none
DESCRIPTION	: Makes the top visible MLE full screen or original size.

REVISION		: RDT 6-27-03
***************************************************************************************/

IF mle_Billing.Visible = True Then 
	This.wf_ResizeBilling( ab_fullscreen )
END IF 

IF mle_Shipment.Visible = True Then 
	This.wf_ResizeShipment( ab_fullscreen )
END IF 

IF mle_Company.Visible = True Then 
	This.wf_ResizeCompany( ab_fullscreen )
END IF 
end subroutine

public subroutine wf_resizebilling (boolean ab_fullscreen);//
/***************************************************************************************
NAME			: wf_ResizeBilling
ACCESS		: Private 
ARGUMENTS	: boolean	(ab_Fullscreen)
RETURNS		: none
DESCRIPTION	: Makes the Billing MLE full screen or original size.

REVISION		: RDT 6-27-03
***************************************************************************************/

If ab_fullscreen Then 
	// make it full screen
	mle_billing.Height = 2008

Else
	mle_billing.Height = il_height
	// il_Height is set in Open event
End If

This.wf_DisplayBill()
end subroutine

public subroutine wf_resizeshipment (boolean ab_fullscreen);//
/***************************************************************************************
NAME			: wf_ResizeShipment
ACCESS		: Private 
ARGUMENTS	: boolean	(ab_Fullscreen)
RETURNS		: none
DESCRIPTION	: Makes the Shipment MLE full screen or original size.

REVISION		: RDT 6-27-03
***************************************************************************************/

If ab_fullscreen Then 
	mle_Shipment.Height = 2008

Else
	mle_Shipment.Height = il_height
	// il_Height is set in Open event
End If

This.wf_DisplayShip()
end subroutine

public subroutine wf_resizecompany (boolean ab_fullscreen);//
/***************************************************************************************
NAME			: wf_ResizeCompany
ACCESS		: Private 
ARGUMENTS	: boolean	(ab_Fullscreen)
RETURNS		: none
DESCRIPTION	: Makes the Company MLE full screen or original size.

REVISION		: RDT 6-27-03
***************************************************************************************/

If ab_fullscreen Then 
	// make it full screen
	mle_Company.Height = 2008

Else
	mle_Company.Height = il_height
	// il_Height is set in Open event
End If

This.wf_DisplayCompany()
end subroutine

on w_noteshower.create
int iCurrent
call super::create
this.mle_shipment=create mle_shipment
this.mle_items=create mle_items
this.mle_events=create mle_events
this.mle_equipment=create mle_equipment
this.st_items=create st_items
this.st_events=create st_events
this.st_equipment=create st_equipment
this.cb_2=create cb_2
this.rb_shipnotes=create rb_shipnotes
this.rb_billnotes=create rb_billnotes
this.cbx_fullscreen=create cbx_fullscreen
this.mle_billing=create mle_billing
this.mle_company=create mle_company
this.rb_company=create rb_company
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_shipment
this.Control[iCurrent+2]=this.mle_items
this.Control[iCurrent+3]=this.mle_events
this.Control[iCurrent+4]=this.mle_equipment
this.Control[iCurrent+5]=this.st_items
this.Control[iCurrent+6]=this.st_events
this.Control[iCurrent+7]=this.st_equipment
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.rb_shipnotes
this.Control[iCurrent+10]=this.rb_billnotes
this.Control[iCurrent+11]=this.cbx_fullscreen
this.Control[iCurrent+12]=this.mle_billing
this.Control[iCurrent+13]=this.mle_company
this.Control[iCurrent+14]=this.rb_company
end on

on w_noteshower.destroy
call super::destroy
destroy(this.mle_shipment)
destroy(this.mle_items)
destroy(this.mle_events)
destroy(this.mle_equipment)
destroy(this.st_items)
destroy(this.st_events)
destroy(this.st_equipment)
destroy(this.cb_2)
destroy(this.rb_shipnotes)
destroy(this.rb_billnotes)
destroy(this.cbx_fullscreen)
destroy(this.mle_billing)
destroy(this.mle_company)
destroy(this.rb_company)
end on

event open;call super::open;/***************************************************************************************
DESCRIPTION	: Accepts the message object and gets the array of shipment ids from it. 
					Message Parm Name: SHIPMENTID
					wf_retrieveNotes is called with array passed as value.
REVISION		: RDT 102602

CAUTION : This accepts an array of shipment id's, but the wf_retrieveNotes will only 
			 display one message at a time. It was decided to delay the implementation 
			 of multiple shipments. 

***************************************************************************************/
String 	ls_shipids

Long 		lla_ShipID[], &
			ll_return

Integer 	li_counter 

s_Parm	lstr_parm

inv_msg = Message.PowerObjectParm					

IF inv_msg.of_Get_parm ( "TARGET_IDS", lstr_Parm) <> 0 THEN
	lla_ShipID[] = lstr_Parm.ia_Value 
	ll_return = 1
ElseIF inv_msg.of_Get_parm ( "TARGET_ID", lstr_Parm) <> 0 THEN
	lla_ShipID[1] = lstr_Parm.ia_Value 
	ll_return = 1
ELSE
	MessageBox("Note Shower", "Open Failed. No Shipment ID in message")
	ll_return = -1
End If

If ll_Return = 1 Then 
	This.Title = "Notes for Shipment " + String( lla_ShipID[1] )
	//For li_counter = 1 to UpperBound( lla_ShipID[] )
	//	ls_shipids += String( lla_ShipID[li_counter] ) + " "
	//Next
	//This.Title = "Notes for Shipment " + ls_Shipids )

	//RDT 6-27-03 save original height of Shipment MLE
	il_Height = mle_shipment.Height	

	This.wf_RetrieveNotes( {lla_ShipID[1]} ) 	// pass only the first id
	
End If

Return ll_return




end event

type mle_shipment from u_mle within w_noteshower
int X=87
int Y=128
int Width=3173
int Height=432
int TabOrder=50
boolean BringToTop=true
boolean VScrollBar=true
boolean DisplayOnly=true
long BackColor=1090519039
end type

type mle_items from u_mle within w_noteshower
int X=87
int Y=640
int Width=3173
int Height=432
int TabOrder=80
boolean BringToTop=true
boolean VScrollBar=true
boolean DisplayOnly=true
long BackColor=1090519039
end type

type mle_events from u_mle within w_noteshower
int X=87
int Y=1164
int Width=3173
int Height=432
int TabOrder=90
boolean BringToTop=true
boolean VScrollBar=true
boolean DisplayOnly=true
long BackColor=1090519039
end type

type mle_equipment from u_mle within w_noteshower
int X=87
int Y=1696
int Width=3173
int Height=432
int TabOrder=100
boolean BringToTop=true
boolean VScrollBar=true
boolean DisplayOnly=true
long BackColor=1090519039
end type

type st_items from u_st within w_noteshower
int X=87
int Y=584
int Width=480
int Height=56
boolean BringToTop=true
string Text="Item Notes"
end type

type st_events from u_st within w_noteshower
int X=87
int Y=1108
int Width=480
int Height=56
boolean BringToTop=true
string Text="Event Notes"
end type

type st_equipment from u_st within w_noteshower
int X=87
int Y=1636
int Width=480
int Height=56
boolean BringToTop=true
string Text="Equipment Notes"
end type

type cb_2 from u_cb within w_noteshower
int X=1499
int Y=2160
int TabOrder=110
boolean BringToTop=true
string Text="&Close"
boolean Default=true
boolean Cancel=true
end type

event clicked;Close(Parent)
end event

type rb_shipnotes from u_rb within w_noteshower
int X=87
int Y=36
int Width=443
int Height=64
int TabOrder=10
boolean BringToTop=true
string Text="&Shipment Notes"
boolean Checked=true
end type

event clicked;
Parent.wf_ResizeShipment( cbx_fullscreen.Checked )

Parent.wf_displayShip()
end event

type rb_billnotes from u_rb within w_noteshower
int X=608
int Y=36
int Width=366
int Height=64
int TabOrder=20
boolean BringToTop=true
string Text="&Billing Notes"
end type

event clicked;
Parent.wf_ResizeBilling( cbx_fullscreen.Checked )

Parent.wf_displayBill()
end event

type cbx_fullscreen from u_cbx within w_noteshower
int X=2907
int Y=36
int Width=352
int Height=64
int TabOrder=40
boolean BringToTop=true
string Text="&Full Screen"
end type

event clicked;//

Parent.wf_ResizeMLE( This.Checked )
end event

type mle_billing from u_mle within w_noteshower
int X=87
int Y=128
int Width=3173
int Height=432
int TabOrder=60
boolean BringToTop=true
boolean VScrollBar=true
boolean DisplayOnly=true
long BackColor=1090519039
end type

type mle_company from u_mle within w_noteshower
int X=87
int Y=128
int Width=3173
int Height=432
int TabOrder=70
boolean BringToTop=true
boolean VScrollBar=true
boolean DisplayOnly=true
long BackColor=1090519039
end type

type rb_company from u_rb within w_noteshower
int X=1051
int Y=36
int Width=466
int Height=64
int TabOrder=30
boolean BringToTop=true
string Text="C&ompany Notes"
end type

event clicked;
Parent.wf_ResizeCompany( cbx_fullscreen.Checked )

Parent.wf_displayCompany()
end event

