$PBExportHeader$u_dw_tripdetail.sru
$PBExportComments$TripDetail (Data Control from PBL map PTDisp) //@(*)[158451346|1232]
forward
global type u_dw_tripdetail from u_dw
end type
end forward

global type u_dw_tripdetail from u_dw
integer width = 2446
integer height = 908
boolean bringtotop = true
string dataobject = "d_tripdetail"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
event type long task_retrieve ( )
event ue_makepopup ( )
event ue_checklocations ( )
event ue_trippayable ( )
end type
global u_dw_tripdetail u_dw_tripdetail

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
protected n_cst_bso_dispatch in_dispatchmanager //@(*)[158456043|1233]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.
datawindow idw_itin
s_rate_confirmation istr_rc

end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function n_cst_bso_dispatch GetDispatchmanager ()
public function Integer SetDispatchmanager (n_cst_bso_dispatch an_dispatchmanager)
public subroutine of_setitinerarydw (datawindow adw_itin)
private subroutine of_pickupdelivery ()
private function string of_gettemplate ()
end prototypes

event task_retrieve;//@(text)(recreate=yes)<retrieve>
long ll_rc = -1
n_cst_bcm lnv_bcm
n_cst_beo lnv_beo
if NOT isValid(in_dispatchmanager) then
    in_dispatchmanager = create n_cst_bso_dispatch
end if
if isValid(in_dispatchmanager)  then
    lnv_bcm = gnv_bcmmgr.CreateBCM(in_dispatchmanager.of_gettrips())
    if isValid(lnv_bcm) then
         if inv_uilink.SetBCM(lnv_bcm) = 1 then
            ll_rc = this.RowCount()
         end if
    end if
end if
return ll_rc
//@(text)--

end event

event ue_makepopup;This.Visible = FALSE
This.TitleBar = TRUE
This.Title = "Trip Details"
This.ControlMenu = TRUE
This.BorderStyle = StyleBox!
This.Height += n_cst_Constants.ci_TitleBarHeight
This.Y -= n_cst_Constants.ci_TitleBarHeight
end event

event ue_checklocations;//This event will be called when a recalculation of origin and destination
//is needed.

//Extend this event on the descendant if the capability is supported.
end event

event ue_trippayable;String	ls_Filter
String	ls_Label
Long		ll_Type
Long		ll_SetRtn
Long		ll_Filter
Long		ll_Count
Long		ll_EntityID
Long		ll_CarrierID
Long		ll_CurrentRow
Int		li_Return = 1
Boolean	lb_Continue = TRUE

n_cst_Beo_AmountType	lnv_AmountType
n_cst_bcm				lnv_Cache
n_cst_beo				lnv_Beo
n_cst_beo_Trip			lnv_Trip
n_cst_msg				lnv_Msg
S_Parm					lstr_parm
n_cst_Companies		lnv_Cos
dataStore 				lds_PreviousAdvances

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

ls_Label = "TRIP_PAYABLE"

IF IsValid ( THIS.inv_UILink ) THEN

	ll_CurrentRow = THIS.GetRow ( )
	lnv_Trip = THIS.inv_UILink.GetBeo ( ll_CurrentRow )

	IF IsValid ( lnv_Trip ) THEN
		lstr_Parm.is_Label = "TRIP"
		lstr_Parm.ia_Value = lnv_Trip
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		lb_Continue = TRUE
	END IF

END IF

IF lb_Continue THEN
	IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
		li_Return = 0
		lnv_AmountType = lnv_Cache.getBeo("pos(amounttype_tag, '" + ls_Label + "') > 0")
		IF NOT IsValid ( lnv_AmountType  ) THEN
			lb_Continue = FALSE
			// do I want to do this, or do I want to use the fact that a amount type was specified as an indication that they 
			// want to assign trip payables at this time?
			//messageBox( "" , "There is no AmountType specified with the tag 'TRIP_PAYABLE' for the payable. Processing stopped." )
		ELSE
			ll_Type = lnv_AmountType.of_getID ( ) 
		END IF
	END IF
END IF
//
IF lb_Continue THEN
	ll_CarrierID = lnv_Trip.of_GetCarrierID ( )
	IF gnv_cst_companies.of_GetEntity ( ll_CarrierID , ll_EntityID, TRUE , TRUE  )  <> 1 THEN
		MessageBox ( "Trip Payable" , "The entity selected has not been setup to handle transactions. Request cancelled.")
		li_Return = -1	
		lb_Continue = FALSE
	END IF
END IF


IF lb_Continue THEN
	If Not IsValid ( lds_PreviousAdvances ) THEN
		lds_PreviousAdvances = CREATE DataStore
		lds_PreviousAdvances.DataObject = "d_amountowedlist"
		lds_PreviousAdvances.SetTransObject( SQLCA )	
	END IF

	IF lds_PreviousAdvances.Retrieve ( ) < 0 THEN
		li_Return = -1
	ELSE
	
		ls_Filter = "amountowed_fkentity = " + String ( ll_entityid )+"  AND amountowed_type = " + String ( ll_Type ) +" AND amountowed_trip = '" + String ( lnv_Trip.of_GetID ( ) ) + "'"
	
		ll_SetRtn = lds_PreviousAdvances.SetFilter ( ls_Filter )
		ll_Filter = lds_PreviousAdvances.Filter ( )
		
		IF ll_SetRtn <> 1 OR ll_Filter <> 1 THEN
			li_Return = -1
		ELSE
			ll_Count = lds_PreviousAdvances.RowCount( ) 
			IF ll_Count > 0 THEN
				IF MessageBox ( "Trip Payable" , "There has already been a trip payable assigned to this trip. Do you want to view it now?", QUESTION! , YESNO! , 1 ) <> 1 THEN
					lb_Continue = FALSE
				END IF
			END IF
			
		END IF
	END IF
END IF
IF lb_Continue THEN
	
	OpenWithParm ( w_CashAdvance , lnv_Msg )
END IF

Destroy ( lds_PreviousAdvances )
//RETURN li_Return

end event

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null

Choose Case Lower(as_name)
Case "dispatchmanager"
     Return in_dispatchmanager
End Choose

Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
any la_any
anv_parameters.GetParameterValue2(as_name, la_any)
Choose Case Lower(as_name)
   Case "dispatchmanager"
     If IsNull(la_any) Or Not isValid(la_any) Then
           SetNull(in_dispatchmanager)
     ElseIf ClassName(la_any) = "any" Then
           SetNull(in_dispatchmanager)
     Else
           in_dispatchmanager = la_any
     End If
End Choose

Return 1
//@(text)--

end function

public function n_cst_bso_dispatch GetDispatchmanager ();//@(*)[158456043|1233:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_dispatchmanager
//@(text)--

end function

public function Integer SetDispatchmanager (n_cst_bso_dispatch an_dispatchmanager);//@(*)[158456043|1233:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_dispatchmanager = an_dispatchmanager
return 1
//@(text)--

end function

public subroutine of_setitinerarydw (datawindow adw_itin);idw_itin = adw_itin
end subroutine

private subroutine of_pickupdelivery ();/*
	 Loop thru pickup and delivery and build one block of text to be
	 added to rtf detail
	 
*/SetPointer(HourGlass!)

integer	li_Row, &
			li_Index, &
			li_CacheRtn
			
string 	ls_pickups, &
			ls_Field, &
			ls_source

n_cst_Beo_Company	lnv_Company
n_cst_string	lnv_String

lnv_Company = CREATE n_cst_beo_Company

li_CacheRtn = lnv_Company.of_SetUseCache ( TRUE ) 

IF IsValid ( idw_Itin ) THEN
	li_Row = idw_itin.RowCount()
END IF

FOR li_Index = 1 to li_Row
	
//	IF li_Index > 1 THEN 
//		//If I don't do this then the first character gets chopped off
//		ls_Pickups = ls_Pickups + " "
//	END IF
	//LINE LABEL
	CHOOSE CASE idw_itin.Object.de_event_type[li_index] 
	CASE "P"
		ls_Pickups = ls_Pickups + "PICK-UP FROM:" + '~n'
	CASE "D"
		ls_Pickups = ls_Pickups + "DELIVER TO:" + '~n'
	END CHOOSE
	
	//company name
	long ll_coid
	ll_coid =  idw_itin.Object.de_site[li_Index] 
	lnv_Company.of_SetSourceid (ll_coid )
	ls_Source = lnv_Company.of_GetCodeName ( )

	IF isnull ( idw_itin.Object.co_name[li_index]  ) THEN
		ls_Field = " " 
	ELSE
		ls_Field = trim ( idw_itin.Object.co_name[li_index] )
	END IF
	
	ls_Pickups = ls_Pickups +  fill (  " " , 3 ) + ls_Field+ &
					fill ( " " , 2 + ( 45 - len (ls_Field) ) ) 
	
	//apptnum

	IF isnull ( idw_itin.Object.de_apptnum[li_Index] ) THEN
		ls_Field = " " 
	ELSE
		ls_Field =  trim ( idw_itin.Object.de_apptnum[li_Index] )
	END IF
	
	ls_Pickups = ls_Pickups + "APPT #: " + fill (  " " , 8 ) + &
						ls_Field + '~n'

	//address1
	IF isnull ( lnv_Company.of_GetAddress1 ( ) ) THEN
		ls_Field = " " 
	ELSE
		ls_Field = trim ( lnv_Company.of_GetAddress1 ( ) )
	END IF
						
	ls_Pickups = ls_Pickups + fill (  " " , 3 ) + ls_Field + &
					fill (  " " , 2 + ( 45 - len (ls_Field) ) ) 
	
	//apptdate
	IF isnull ( idw_itin.Object.de_apptdate[li_Index] ) THEN
		ls_Field = " " 
	ELSE
		ls_Field =  trim ( string ( idw_itin.Object.de_apptdate[li_Index], 'mm/dd/yy') )
	END IF

	ls_Pickups = ls_Pickups + "APPT DATE/TIME: " + ls_Field 

	//appttime
	IF isnull ( idw_itin.Object.de_appttime[li_Index] ) THEN
		ls_Field = ' '
	ELSE
		ls_Field = " " + trim ( string ( idw_itin.Object.de_appttime[li_Index], "hh:mm:ss am/pm") ) 
	END IF

	ls_Pickups = ls_Pickups + ls_Field + '~n'

	//address 2
	IF isnull ( lnv_Company.of_GetAddress2 ( ) ) THEN
		ls_Field = trim ( idw_itin.Object.comp_loc[li_index] ) 
	ELSE
		ls_Field = trim ( lnv_Company.of_GetAddress2 ( ) )
	END IF
						
	ls_Pickups = ls_Pickups + fill (  " " , 3 ) + ls_Field + &
					fill (  " " , 2 + ( 45 - len (ls_Field) ) ) 
	
	//phone											
	IF isnull ( lnv_Company.of_FormatPhone1 ( ) ) THEN
		ls_Field = " " 
	ELSE
		ls_Field = trim ( lnv_Company.of_FormatPhone1 ( ) )
	END IF
						
	ls_Pickups = ls_Pickups + "PHONE: " + fill (  " " , 9 ) + &
						lnv_Company.of_FormatPhone1 ( ) + '~n'

	
	//city state
	IF isnull ( lnv_Company.of_GetAddress2 ( ) ) THEN
		//already added to previous line
	ELSE
		ls_Pickups = ls_pickups + fill (  " " , 3 ) + trim ( idw_itin.Object.comp_loc[li_index] )  + '~n'
	END IF
	
	//detail notes
	IF isnull ( idw_itin.Object.de_note[li_Index] ) THEN
		ls_Field = " " 
	ELSE
		ls_Field =  trim ( idw_itin.Object.de_note[li_Index] )
	END IF
	
	ls_Pickups = ls_Pickups + fill (  " " , 3 ) + "NOTES:  " + ls_field + '~n' 

	ls_Pickups = ls_Pickups +  '~n'

NEXT

istr_rc.rc_pickupdelivery = ls_pickups

DESTROY lnv_Company

return 


end subroutine

private function string of_gettemplate ();/*
		Get the custom rate confirmation template (if any) from the database (id=44).
		
		Returns:	template (string) 
		
		
*/
String	ls_template

select ss_string into :ls_template from system_settings where ss_id = 44 ;

choose case sqlca.sqlcode
case 0, 100
	commit ;
case else
	rollback ;
	ls_template = ""
end choose

return trim ( ls_template )
end function

on u_dw_tripdetail.destroy
end on

event constructor;//@(data)(recreate=yes)<GenerationOptions>
SetUILink(TRUE)
inv_uilink.SetClass("")
of_SetTransObject(SQLCA)
this.SetUseTaskRetrieve(TRUE)
//@(data)--

n_cst_Presentation_trip	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )
//_trip
This.of_SetInsertable ( FALSE )
end event

event itemchanged;il_rtnval = 0
Integer	li_Result
Boolean	lb_Processed
n_cst_beo_Trip	lnv_Trip
n_cst_OFRError	lnv_OFRError[]
n_cst_licenseManager	lnv_LicenseManager


IF IsValid ( inv_UILink ) THEN

	CHOOSE CASE Lower ( dwo.Name )
	
	CASE Lower ( "Trip_CarrierName" )

		lnv_Trip = inv_uilink.getBeo( Row )

		IF IsValid ( lnv_Trip ) THEN

			s_co_info lstr_company
		
			li_result = gnv_cst_companies.of_select(lstr_company, "CARRIER_WITH_WARNINGS!", true, data, &
				false, 0, false, true)
		
			if li_result = 1 then

				lnv_Trip.SetActionSource ( n_cst_beo.ci_ActionSource_System )
				//CarrierId is a System Field

				IF lnv_Trip.of_SetCarrierId ( lstr_Company.co_Id ) > 0 THEN

					inv_UILink.UpdateRequestor ( Row )
					il_RtnVal = 2
					lb_Processed = TRUE

				ELSE

					//Relay the errors recorded in the beo to the uilink, so that
					//the itemerror event handling can get at them and display them.
					This.inv_UILink.PropagateErrors ( lnv_Trip )

					il_RtnVal = 1  //Will fire itemerror
					ib_OfrItemChangedError = TRUE  //Flags where the error came from
					lb_Processed = TRUE

				END IF

				lnv_Trip.RestoreActionSource ( )

			else
				il_RtnVal = 2
				lb_Processed = TRUE

			end if

		END IF
		
		CASE "trip_status"
			IF data = "W" AND il_RtnVal = 0 THEN //history
				IF lnv_LicenseManager.of_GetLicensed ( n_cst_constants.cs_Module_Settlements ) THEN
					THIS.Event ue_TripPayable ( )
				END IF
			END IF
	
	END CHOOSE

END IF

IF NOT lb_Processed THEN
	il_rtnval = Super::Event ItemChanged ( row, dwo, data )
END IF

RETURN il_rtnval
end event

event buttonclicked;CHOOSE CASE dwo.Name

CASE "rate_confirmation"
	IF IsValid ( idw_Itin ) THEN
		IF idw_itin.RowCount ( ) > 0 THEN
			istr_rc.rc_tripdetail = this
			istr_rc.rc_tempnumber = string ( idw_itin.Object.de_shipment_id[1], '0000' )
			this.of_pickupdelivery ( )
			istr_rc.rc_template = this.of_GetTemplate ( )
			openwithparm(w_rte,istr_rc)
		ELSE
			MessageBox ( "Rate Confirmation", "You must route a shipment to this trip "+&
				"before printing the rate confirmation sheet." )
		END IF
	ELSE
		MessageBox ( "Rate Confirmation", "Could not process request.  Request cancelled." )
	END IF
END CHOOSE

end event

event itemerror;call super::itemerror;
Boolean	lb_Processed
string 	ls_errcol
Long		ll_Return
date 		ld_compdate

n_cst_string lnv_string

ls_errcol = dwo.name
ll_Return = ancestorReturnValue
IF ll_Return = 0 THEN

	choose case ls_errcol
	
		case "trip_tripdate"
		
			//Attempt to convert the text typed to a date
			ld_compdate = lnv_string.of_SpecialDate(data)
		
			if isnull(ld_compdate) then
				//Value is really invalid
				ll_return = 0 //  Reject the data value and show an error message box
				
			ELSE
				IF this.setitem(row, ls_errcol, ld_compdate) = 1 THEN
					ll_Return = 3  //Reject the data value but allow focus to change
				ELSE
					ll_return = 1 
				END IF
		
			END IF
		
	end choose
	
END IF

return ll_Return
end event

on u_dw_tripdetail.create
end on

