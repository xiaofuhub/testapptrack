$PBExportHeader$w_tripsummary.srw
$PBExportComments$TripSummary (Window from PBL map PTDisp) //@(*)[73247808|1238]
forward
global type w_tripsummary from w_sheet
end type
type uo_triplist from u_trip_list within w_tripsummary
end type
type uo_refresh from u_refresh within w_tripsummary
end type
type uo_statusfilter from u_cst_statusfilter within w_tripsummary
end type
end forward

global type w_tripsummary from w_sheet
int Width=3643
int Height=2052
boolean TitleBar=true
string Title="Trip Summary"
string MenuName="m_sheets"
uo_triplist uo_triplist
uo_refresh uo_refresh
uo_statusfilter uo_statusfilter
end type
global w_tripsummary w_tripsummary

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
end prototypes

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null


Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>

Return 1
//@(text)--

end function

on w_tripsummary.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.uo_triplist=create uo_triplist
this.uo_refresh=create uo_refresh
this.uo_statusfilter=create uo_statusfilter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_triplist
this.Control[iCurrent+2]=this.uo_refresh
this.Control[iCurrent+3]=this.uo_statusfilter
end on

on w_tripsummary.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_triplist)
destroy(this.uo_refresh)
destroy(this.uo_statusfilter)
end on

event open;call super::open;//@(data)(recreate=yes)<Parameters>
//@(data)--

//@(data)(recreate=yes)<Links>
Setlinkage(TRUE)
//@(data)--

//@(data)(recreate=yes)<GenerationOptions>
of_SetResize(TRUE)
SetTransactionManagement(TRUE)
//@(data)--

//@(text)(recreate=yes)<RetrieveNoArgs>

//@(text)--

//@(text)(recreate=yes)<resizevalues>
inv_resize.of_SetMinSize(1300, 400)
//@(text)--


n_cst_ShipmentManager lnv_ShipmentMgr
n_cst_LicenseManager	lnv_LicenseManager

This.X = 1
This.Y = 1

gf_Mask_Menu ( m_Sheets )

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_Brokerage ) = FALSE THEN

	lnv_LicenseManager.of_DisplayModuleNotice ( "Trip Summary" )
	ib_DisableCloseQuery = TRUE
	Close ( This )
	RETURN

END IF


IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Brokerage, "E" ) < 0 THEN
	ib_DisableCloseQuery = TRUE
	Close ( This )
	RETURN

END IF


if lnv_ShipmentMgr.of_Get_Retrieved_Trips( ) = false then
	if lnv_ShipmentMgr.of_RefreshShipments ( TRUE ) = -1 then
		messagebox("Trip Summary", "Could not retrieve trip list from "+&
			"database.~n~nRequest cancelled.", exclamation!)
		ib_DisableCloseQuery = TRUE
		Close ( This )
		RETURN
	end if
END IF

uo_refresh.list_type = "TRIP~tSHIP"
uo_refresh.setup()

uo_TripList.uo_refresh = uo_refresh
//uo_TripList.dw_trip_list.setfilter("bt_pmtstatus = 'K'")
if uo_TripList.setup() = -1 then
	MessageBox ( "Trip Summary", "Could not load trip summary.  Request cancelled.", Exclamation! )
	ib_DisableCloseQuery = TRUE
	Close ( This )
	RETURN
END IF

uo_TripList.load_from_cache()
end event

type uo_triplist from u_trip_list within w_tripsummary
int X=0
int Y=200
int Height=1660
int TabOrder=20
boolean BringToTop=true
end type

on uo_triplist.destroy
call u_trip_list::destroy
end on

type uo_refresh from u_refresh within w_tripsummary
int X=2683
int Y=24
int TabOrder=30
boolean BringToTop=true
end type

on uo_refresh.destroy
call u_refresh::destroy
end on

event ue_refresh;call super::ue_refresh;//If refresh processing was a success, update the display with the results.

IF AncestorReturnValue = 1 THEN
	
	//	Request a lock for user
	n_cst_LicenseManager lnv_LicenseManager 
	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Brokerage, "E" ) < 0 THEN
		//do nothing
	else
		uo_TripList.Load_From_Cache ( )
	end if


END IF

RETURN AncestorReturnValue
end event

type uo_statusfilter from u_cst_statusfilter within w_tripsummary
int X=0
int Y=0
int TabOrder=10
boolean BringToTop=true
end type

on uo_statusfilter.destroy
call u_cst_statusfilter::destroy
end on

event ue_postselection;//Process Filter Selection

String	ls_Filter
Boolean	lb_Unknown

CHOOSE CASE ai_Selection

CASE ci_Selection_Open
	ls_Filter = "bt_pmtstatus = 'K'"

CASE ci_Selection_Restricted
	ls_Filter = "Pos ( 'NQT', bt_pmtstatus ) > 0"

CASE ci_Selection_All
	ls_Filter = "bt_pmtstatus <> 'W'"

CASE ELSE  //Unexpected value
	lb_Unknown = TRUE	

END CHOOSE

IF NOT lb_Unknown THEN

	uo_TripList.dw_trip_list.setfilter( ls_Filter )
	uo_TripList.dw_Trip_List.Filter ( )

END IF
end event

