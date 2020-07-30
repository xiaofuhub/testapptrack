$PBExportHeader$u_dw_equipmentleasetypelist.sru
$PBExportComments$EquipmentLeaseTypeList (Data Control from PBL map PTData) //@(*)[49643370|980]
forward
global type u_dw_equipmentleasetypelist from u_dw
end type
end forward

global type u_dw_equipmentleasetypelist from u_dw
integer width = 2400
integer height = 592
boolean bringtotop = true
string dataobject = "d_equipmentleasetypelist"
boolean hscrollbar = true
boolean hsplitscroll = true
event type integer ue_calctestresults ( date ad_date,  time at_time,  date ad_datein,  time at_timein )
event type long task_retrieve ( )
end type
global u_dw_equipmentleasetypelist u_dw_equipmentleasetypelist

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
end prototypes

event ue_calctestresults;n_cst_beo_EquipmentLeaseType	lnv_EquipmentLeaseType

Long		ll_Row
Long		ll_RowCount
Integer	li_Return
Int		i
Date	ld_ExpirationDate
Time	lt_ExpirationTime
Dec		ldec_Charges


IF This.AcceptText ( ) = -1 THEN
	li_Return = 0
	RETURN li_Return
END IF

ll_RowCount = this.RowCount ( ) 
li_Return = 1

For i = 1 TO ll_RowCount

	lnv_EquipmentLeaseType = This.inv_UILink.GetBeo ( i )
	
	if IsValid(lnv_EquipmentLeasetype) THEN
		
		lnv_EquipmentLeaseType.of_GetFreeTimeExpiration(ad_date,at_time ,ld_ExpirationDate, lt_ExpirationTime ) 
		This.object.equipmentlease_freetimeexpiration[i] = & 
			DateTime( ld_ExpirationDate , lt_ExpirationTime)
	
		lnv_EquipmentLeaseType.of_GetCharges(ad_date , at_time ,ad_dateIn , at_timeIn, ldec_Charges ) 
		This.object.EquipmentLease_Charges[i] = ldec_Charges

	END IF
next


RETURN li_Return
end event

event task_retrieve;//Make a local copy of global cache, and use it as the data source.
//Note: This retrieval is only used if SetUseTaskRetrieve is set to TRUE on the instance.
//Database retrieval (not using task retrieve) is performed by default.

long ll_rc = -1
n_cst_bcm	lnv_Cache, &
				lnv_bcm

//Get the cache from the CacheManager

IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_EquipmentLeaseType", lnv_Cache, TRUE, TRUE ) = 1 THEN

	//Make a local copy of the cache
	lnv_Bcm = lnv_Cache.Copy ( )

	//If copy was successful, use the local copy as the data source
	IF IsValid ( lnv_Bcm ) THEN

		if inv_uilink.SetBCM(lnv_bcm) = 1 then
			ll_rc = this.RowCount()
		end if

	END IF

END IF

return ll_rc
end event

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

on u_dw_equipmentleasetypelist.destroy
end on

event constructor;//@(data)(recreate=yes)<GenerationOptions>
SetUILink(TRUE)
inv_uilink.SetClass("n_cst_beo_equipmentleasetype")
inv_uilink.SetDLK("n_cst_dlkc_equipmentleasetype")
of_SetTransObject(SQLCA)
this.SetUseTaskRetrieve(FALSE)
//@(data)--

//Note:  By default, database retrieval will be performed.  But decendant instances
//can SetUseTaskRetrieve = TRUE to use data from the global cache instead.

n_cst_Presentation_EquipmentLeaseType	lnv_Presentation_EquipmentLeaseType
n_cst_Presentation_EquipmentSummary  	lnv_Presentation_EquipmentSummary
lnv_Presentation_EquipmentLeaseType.of_SetPresentation ( This )
lnv_Presentation_EquipmentSummary.of_SetPresentation ( This )

of_SetAutoFind ( TRUE )
of_SetAutoSort ( TRUE )
of_setDeleteable( FALSE )
// rdt 08-05-02 changed sort & added filter
//This.SetSort ( "EquipmentLeaseType_Line A, EquipmentLeaseType_Type A" )
This.SetSort ( "EquipmentLeaseType_Line A, EquipmentLeaseType_LeaseStatus D, EquipmentLeaseType_Type A" )
This.of_SetAutoFilter ( TRUE )

//Instantiate the default row focus indicator
This.Event ue_SetFocusIndicator ( TRUE )
end event

event pfc_postupdate;call super::pfc_postupdate;//Since updates have been made, we want to discard the global cache (if any) to force
//a re-retrieval.

//Note : Putting this in pfc_Update, with a condition for update success, didn't work
//because pfc_Update isn't being called in the save sequence.

//Note : We may ultimately want to make cache destruction like this a function of n_cst_CacheManager.

n_cst_bcm	lnv_Cache

//Get a reference to the current cache, and destroy it in order to force refresh upon next access.

IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_EquipmentLeaseType", lnv_Cache ) = 1 THEN
	gnv_BcmMgr.DestroyBcm ( lnv_Cache )
END IF

RETURN AncestorReturnValue
end event

on u_dw_equipmentleasetypelist.create
end on

