$PBExportHeader$u_dw_amounttypelist.sru
$PBExportComments$AmountTypeList (Data Control from PBL map PTSetl) //@(*)[86245925|607]
forward
global type u_dw_amounttypelist from u_dw
end type
end forward

global type u_dw_amounttypelist from u_dw
integer width = 2400
integer height = 600
boolean bringtotop = true
string dataobject = "d_dlkc_amounttype"
boolean hscrollbar = true
boolean hsplitscroll = true
event type integer ue_namechanged ( long al_row )
event type integer ue_categorychanged ( long al_row )
event type integer ue_typicalamountchanged ( long al_row )
event type integer ue_taxabledefaultchanged ( long al_row )
event type integer ue_tagchanged ( long al_row )
event type integer ue_typechanged ( long al_row )
event type integer ue_fuelsurchargechanged ( long al_row )
event type integer ue_notifychanged ( long al_row )
event ue_recievedmsg ( n_cst_msg anv_msg )
end type
global u_dw_amounttypelist u_dw_amounttypelist

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function integer of_accepttext ()
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

public function integer of_accepttext ();long	ll_FindRtn
Int	li_Return = 1

ll_FindRtn = THIS.Find ( "IsNull ( amounttype_itemtype) OR Len (amounttype_itemtype) = 0 " , 1 , THIS.RowCount ( ) )

If ll_FindRtn > 0 THEN
	MessageBox ( "Item Type" , "Please select an item type for each Amount Type." )
	THIS.ScrolltoRow ( ll_FindRtn )
	THIS.SetColumn ( "amounttype_itemtype" )
	THIS.SetFocus ( ) 
	li_Return = -1
END IF

RETURN li_Return
end function

on u_dw_amounttypelist.destroy
end on

event constructor;/* I needed this in the amount type window but something in here was stomping
on it before i could get a handle to it. 
*/
IF isValid ( Message.powerobjectParm ) THEN
	IF Message.powerobjectParm.classname ( ) = "n_cst_msg" THEN
		THIS.Post Event ue_RecievedMsg ( Message.powerobjectParm )
	END IF
END IF


//@(data)(recreate=yes)<GenerationOptions>
SetUILink(TRUE)
inv_uilink.SetClass("n_cst_beo_amounttype")
inv_uilink.SetDLK("n_cst_dlkc_amounttype")
of_SetTransObject(SQLCA)
this.SetUseTaskRetrieve(FALSE)
//@(data)--

n_cst_Presentation_AmountType	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

of_SetAutoSort ( TRUE )
of_setsort(true)
inv_sort.of_setsort("amounttype_name")
inv_sort.of_sort()

//of_SetAutoFind ( TRUE )   Find hangs in response windows

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

IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_amounttype", lnv_Cache ) = 1 THEN
	gnv_BcmMgr.DestroyBcm ( lnv_Cache )
END IF

RETURN AncestorReturnValue
end event

event pfc_deleterow;any		la_value
integer	li_freightamountid, &
			li_accessamountid, &
			li_return
			
n_cst_settings lnv_Settings

if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
	li_freightamountid = integer(la_value)
end if
if lnv_Settings.of_GetSetting ( 99 , la_value ) > 0 then
	li_accessamountid = integer(la_value)
end if

choose case this.object.amounttype_id[this.getrow()]
		
	case li_freightamountid
		
		choose case messagebox('Delete Amount Type', &
					'You are about to delete the system default freight type. ' + &
					'Clicking OK will delete the system default.', Information!, OKCancel!)
				case 1
					if super::Event pfc_deleterow() > 0 then
						lnv_settings.of_deletesetting(li_freightamountid)
						li_return = 1
					else
						li_return = -1
					end if
				case 2
					li_return = -1
		end choose
		
	case li_accessamountid
		
		choose case messagebox('Delete Amount Type', &
					'You are about to delete the system default accessorial type.' + &
					'Clicking OK will delete the system default.', Information!, OKCancel!)
				case 1
					if super::Event pfc_deleterow() > 0 then
						lnv_settings.of_deletesetting(li_accessamountid)
						li_return = 1
					else
						li_return = -1
					end if
				case 2
					li_return = -1
		end choose
		
end choose

return li_return
end event

event itemerror;call super::itemerror;Long	ll_Return

ll_Return = AncestorReturnValue

CHOOSE CASE dwo.name
		
	CASE "amounttype_name"
		MessageBox ("Amount Type Name" , "Please select a unique name." )
		ll_Return = 1
			
END CHOOSE

RETURN ll_Return
end event

event itemchanged;call super::itemchanged;THIS.inv_UILink.UpdateRequestor ( row )
RETURN AncestorReturnValue
end event

on u_dw_amounttypelist.create
end on

