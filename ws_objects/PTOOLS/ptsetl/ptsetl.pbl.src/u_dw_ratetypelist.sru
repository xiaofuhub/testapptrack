$PBExportHeader$u_dw_ratetypelist.sru
$PBExportComments$RateTypeList (Data Control from PBL map PTSetl) //@(*)[59449942|572]
forward
global type u_dw_ratetypelist from u_dw
end type
end forward

global type u_dw_ratetypelist from u_dw
int Width=841
int Height=600
boolean BringToTop=true
string DataObject="d_dlkc_ratetype"
boolean HScrollBar=true
boolean HSplitScroll=true
end type
global u_dw_ratetypelist u_dw_ratetypelist

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

on u_dw_ratetypelist.destroy
call u_dw::destroy
end on

event constructor;//@(data)(recreate=yes)<GenerationOptions>
SetUILink(TRUE)
inv_uilink.SetClass("n_cst_beo_ratetype")
inv_uilink.SetDLK("n_cst_dlkc_ratetype")
of_SetTransObject(SQLCA)
this.SetUseTaskRetrieve(FALSE)
//@(data)--


n_cst_Presentation_RateType	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

of_SetAutoSort ( TRUE )
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

IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_ratetype", lnv_Cache ) = 1 THEN
	gnv_BcmMgr.DestroyBcm ( lnv_Cache )
END IF

RETURN AncestorReturnValue
end event

