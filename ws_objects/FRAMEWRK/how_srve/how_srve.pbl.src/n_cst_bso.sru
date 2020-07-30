$PBExportHeader$n_cst_bso.sru
forward
global type n_cst_bso from ofr_n_cst_bso
end type
end forward

global type n_cst_bso from ofr_n_cst_bso
event type integer pt_updatespending ( )
event type integer pt_save ( )
event type integer pt_reset ( )
end type
global n_cst_bso n_cst_bso

type variables
n_cst_CacheManager	inv_CacheManager
end variables

forward prototypes
public function n_cst_bcm cache (ref n_cst_bcm anv_source, readonly boolean ab_destroysource)
public function n_cst_bcm cache (ref n_cst_bcm anv_source)
protected function integer setcachemanager (readonly n_cst_cachemanager anv_cachemanager)
protected function integer getcache (string as_dlk, ref n_cst_bcm anv_bcm)
public function n_cst_cachemanager getcachemanager ()
end prototypes

event pt_updatespending;//Indicates whether there are any updates pending under the bso's management
//Currently, this is a pass-through of whether there are any updates pending
//on the CacheManager

//Returns :	 1 = Yes (Updates Pending)
//				 0 = No (No Updates Pending)
//				-1 = Error (Not implemented)

n_cst_CacheManager	lnv_CacheManager

Integer	li_Return = 0

lnv_CacheManager = GetCacheManager ( )

IF IsValid ( lnv_CacheManager ) THEN

	li_Return = lnv_CacheManager.Event pt_UpdatesPending ( )

END IF

RETURN li_Return
end event

event type integer pt_save();//Saves any changes pending under the bso's management
//Currently, this is a pass-through of pt_Save on the CacheManager

//Returns :	 1 = Success (Changes -- if there were any -- are saved)
//				-1 = Failure

n_cst_CacheManager	lnv_CacheManager

Integer	li_Return = 1

lnv_CacheManager = GetCacheManager ( )

IF IsValid ( lnv_CacheManager ) THEN

	li_Return = lnv_CacheManager.Event pt_Save ( )

END IF

IF li_Return = -1 THEN
	THIS.Propagateerrors( lnv_CacheManager )
END IF

RETURN li_Return
end event

event pt_reset;//Resets (clears) any data (bcm's) under the bso's management
//Currently, this is a pass-through of pt_Reset on the CacheManager
//This event may be extended or overridden on descendants if different
//or more specific functionality is needed.

//Returns :	 1 = Success (Data -- if there was any -- has been cleared)
//				 0 = No action taken  (not currently implemented)
//				-1 = Failure

n_cst_CacheManager	lnv_CacheManager

Integer	li_Return = 1

lnv_CacheManager = GetCacheManager ( )

IF IsValid ( lnv_CacheManager ) THEN

	li_Return = lnv_CacheManager.Event pt_Reset ( )

END IF

RETURN li_Return
end event

public function n_cst_bcm cache (ref n_cst_bcm anv_source, readonly boolean ab_destroysource);RETURN GetCacheManager ( ).of_Cache ( anv_Source, ab_DestroySource )
end function

public function n_cst_bcm cache (ref n_cst_bcm anv_source);CONSTANT Boolean	lb_DestroySource = TRUE

RETURN Cache ( anv_Source, lb_DestroySource )
end function

protected function integer setcachemanager (readonly n_cst_cachemanager anv_cachemanager);anv_CacheManager.of_SetContext ( This )
inv_CacheManager = anv_CacheManager

RETURN 1
end function

protected function integer getcache (string as_dlk, ref n_cst_bcm anv_bcm);//Returns : 1 = Success (Match Found), 0 = No Match, -1 = Error

n_cst_Bcm	lnv_Bcm
n_cst_CacheManager	lnv_CacheManager
Integer	li_Return

lnv_CacheManager = GetCacheManager ( )

IF IsValid ( lnv_CacheManager ) THEN

	li_Return = lnv_CacheManager.of_GetCache ( as_Dlk, lnv_Bcm )

ELSE

	li_Return = -1

END IF

anv_Bcm = lnv_Bcm

RETURN li_Return
end function

public function n_cst_cachemanager getcachemanager ();RETURN inv_CacheManager
end function

on n_cst_bso.create
call super::create
end on

on n_cst_bso.destroy
call super::destroy
end on

