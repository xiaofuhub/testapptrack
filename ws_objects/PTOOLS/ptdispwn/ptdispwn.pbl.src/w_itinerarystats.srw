$PBExportHeader$w_itinerarystats.srw
forward
global type w_itinerarystats from w_response
end type
type dw_1 from datawindow within w_itinerarystats
end type
type cb_1 from u_cbok within w_itinerarystats
end type
type mle_1 from multilineedit within w_itinerarystats
end type
type cb_2 from commandbutton within w_itinerarystats
end type
end forward

global type w_itinerarystats from w_response
int X=965
int Y=884
int Width=1733
int Height=912
boolean TitleBar=true
string Title="Statistics"
dw_1 dw_1
cb_1 cb_1
mle_1 mle_1
cb_2 cb_2
end type
global w_itinerarystats w_itinerarystats

type variables
n_cst_bso_dispatch		inv_Dispatch
date	id_Itinerary
long	il_ItineraryId
integer	ii_ItineraryType
end variables

forward prototypes
public subroutine wf_load ()
end prototypes

public subroutine wf_load ();long	ll_RowCount, &
		ll_row, &
		ll_NewRow
	
decimal	lc_FreightSplit, &
			lc_AccessSplit, &
			lc_TotalFreight, &
			lc_TotalAccess
n_cst_Msg	lnv_Range
s_Parm		lstr_Parm
			
n_ds	lds_EventCache
n_cst_beo_Itinerary2			lnv_Itinerary

lnv_Itinerary = CREATE n_cst_beo_itinerary2

lnv_Itinerary.of_SetDispatchManager ( inv_Dispatch )


lstr_Parm.is_Label = "StartDate"
lstr_Parm.ia_Value = id_itinerary
lnv_Range.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "EndDate"
lstr_Parm.ia_Value = id_itinerary
lnv_Range.of_Add_Parm ( lstr_Parm )
	
lstr_Parm.is_Label = "ItinType"
lstr_Parm.ia_Value = ii_itinerarytype //gc_Dispatch.ci_ItinType_Driver
lnv_Range.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "ItinId"
lstr_Parm.ia_Value = il_itineraryid
lnv_Range.of_Add_Parm ( lstr_Parm )

lnv_Itinerary.of_SetRange ( lnv_Range )



dw_1.InsertRow(0)
dw_1.Object.BobtailMiles[1] = lnv_itinerary.of_GetBobtailMiles()
dw_1.Object.DeadheadMiles[1] = lnv_itinerary.of_GetDeadheadMiles()
dw_1.Object.EmptyMiles[1] = lnv_itinerary.of_GetEmptyMiles()
dw_1.Object.LoadedMiles[1] = lnv_itinerary.of_GetLoadedMiles()
dw_1.Object.TotalMiles[1] = lnv_itinerary.of_GetTotalMiles()
IF lnv_itinerary.of_GetShipmentCount() > 0 THEN
	dw_1.Object.FreightRevenue[1] = lnv_itinerary.of_GetFreightRevenue()
ELSE
	mle_1.text = "None of the events in this itinerary are associated with a shipment.  " + &
	"No revenue information is available."
END IF
dw_1.Object.FreightRevenue[1] = lnv_itinerary.of_GetFreightRevenue()
dw_1.Object.Payable[1] = lnv_itinerary.of_GetPayables()

DESTROY lnv_Itinerary


end subroutine

on w_itinerarystats.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.mle_1=create mle_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.mle_1
this.Control[iCurrent+4]=this.cb_2
end on

on w_itinerarystats.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.mle_1)
destroy(this.cb_2)
end on

event open;call super::open;n_cst_msg	lnv_msg
s_parm		lstr_Parm

lnv_msg = message.powerobjectParm

ib_DisableCloseQuery = TRUE

IF isValid ( lnv_msg ) THEN
	//dispatch object should already be filtered by the correct shipmentid 
	IF lnv_Msg.of_Get_Parm ( "DISPATCHOBJECT" , lstr_Parm ) <> 0 THEN
		inv_Dispatch = lstr_Parm.ia_Value
	END IF

	IF lnv_Msg.of_Get_Parm ( "Date" , lstr_Parm ) <> 0 THEN
		id_Itinerary = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "ItinType" , lstr_Parm ) <> 0 THEN
		ii_ItineraryType = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "ItinId" , lstr_Parm ) <> 0 THEN
		il_ItineraryId = lstr_Parm.ia_Value
	END IF

	this.Event Post pfc_open( )
	
ELSE
	messageBox ( "Itinerary Statistics" , "An error occurred while attempting to open the window.~r~nRequest Cancelled.", EXCLAMATION! ) 
	ib_DisableCloseQuery = TRUE
	close ( THIS ) 
END IF
end event

event pfc_open;n_cst_Privileges	lnv_Privileges

IF lnv_Privileges.of_HasAdministrativeRights() THEN
	dw_1.Object.payable.visible = TRUE
	dw_1.Object.payable_t.visible = TRUE
	dw_1.Object.profitmargin.visible = TRUE
	dw_1.Object.profitmargin_t.visible = TRUE
ELSE
	DW_1.Object.payable.visible = FALSE
	dw_1.Object.payable_t.visible = FALSE
	dw_1.Object.profitmargin.visible = FALSE
	dw_1.Object.profitmargin_t.visible = FALSE
END IF

IF lnv_Privileges.of_HasAuditRights() THEN
	dw_1.Object.freightrevenue.visible = TRUE
	dw_1.Object.freightrevenue_t.visible = TRUE
ELSE
	DW_1.Object.freightrevenue.visible = FALSE
	DW_1.Object.freightrevenue_t.visible = FALSE
END IF
	
wf_load()
cb_1.setfocus()

end event

event pfc_default;close(this)
end event

type dw_1 from datawindow within w_itinerarystats
int X=23
int Y=28
int Width=1687
int Height=516
boolean BringToTop=true
string DataObject="d_itinerarystats"
boolean Border=false
boolean LiveScroll=true
end type

type cb_1 from u_cbok within w_itinerarystats
int X=576
int Y=696
int TabOrder=10
boolean BringToTop=true
end type

type mle_1 from multilineedit within w_itinerarystats
int X=110
int Y=540
int Width=1522
int Height=132
boolean BringToTop=true
boolean Border=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_itinerarystats
int X=891
int Y=696
int Width=233
int Height=88
int TabOrder=20
boolean BringToTop=true
string Text="Notes"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string	ls_Note1, &
			ls_Note2, &
			ls_Note3
			
ls_Note1 =	"Note 1: The payables value represents an allocation of amounts auto-generated "+&
				"in settlements using version 3.0.17 or higher.  Payables created manually or "+&
				"using an earlier version of the program will not be reflected in this figure."
				
ls_Note2 =	"Note 2: Mileage values do not reflect carry-over from the previous day.  "+&
				"Mileages that result from a trip in progress on the previous day are not "+&
				"reflected in these values."
				
ls_Note3 = 	"Note 3: Unsaved changes to shipment revenue may not be reflected in these values."
				
messagebox ( "Itinerary Stats", ls_Note1 + "~n~n" +ls_Note2 + "~n~n" + ls_Note3, Information!)

cb_1.SetFocus()
end event

