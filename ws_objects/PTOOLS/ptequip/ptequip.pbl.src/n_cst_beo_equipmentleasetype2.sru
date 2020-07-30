$PBExportHeader$n_cst_beo_equipmentleasetype2.sru
forward
global type n_cst_beo_equipmentleasetype2 from pt_n_cst_beo
end type
end forward

global type n_cst_beo_equipmentleasetype2 from pt_n_cst_beo
end type
global n_cst_beo_equipmentleasetype2 n_cst_beo_equipmentleasetype2

type variables
n_cst_beo_EquipmentLeaseType	inv_LeaseType
end variables

forward prototypes
public function integer of_getcharges (date ad_out, time at_out, date ad_in, time at_in, ref decimal ac_charges)
public function integer of_getrivertonbeo (long al_fkid)
public function boolean of_hassource ()
public function integer of_getfreetimeexpiration (date ad_OutDate, time at_OutTime, ref date ad_ExpirationDate, ref time at_ExpirationTime)
public function String of_getline ()
public function String of_gettype ()
public function string of_getnotes ()
public function integer of_getcharges (date ad_out, time at_out, date ad_in, time at_in, ref n_cst_leaseCharges anv_LeaseCharges)
public function string of_getscac ()
end prototypes

public function integer of_getcharges (date ad_out, time at_out, date ad_in, time at_in, ref decimal ac_charges);Int	li_Return = -1

IF Not isValid ( inv_leasetype ) THEN
//	THIS.of_GetRivertonBeo ( ) 
END IF

IF isValid ( inv_leasetype ) THEN
	IF inv_leasetype.of_GetCharges ( ad_out , at_out , ad_in , at_in , ac_charges ) = 1 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return
end function

public function integer of_getrivertonbeo (long al_fkid);n_cst_bcm	lnv_Cache

IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_EquipmentLeaseType", lnv_Cache, TRUE, TRUE ) = 1 THEN

	inv_leasetype = lnv_Cache.GetBeo ( "EquipmentLeaseType_Id = " + String ( al_fkid ) )

END IF

RETURN 1
end function

public function boolean of_hassource ();// this method will return true if the riverton beo has been set on the insstance

RETURN isValid ( inv_leasetype )
end function

public function integer of_getfreetimeexpiration (date ad_OutDate, time at_OutTime, ref date ad_ExpirationDate, ref time at_ExpirationTime);//RETURNS 1, Success
//			-1, inv_LeaseType not valid
//			 0 , out date/time is null

Int	li_Return = -1


IF IsValid ( inv_leasetype ) THEN
	li_Return = inv_leasetype.of_GetFreeTimeExpiration ( ad_OutDate , at_OutTime , ad_ExpirationDate , at_ExpirationTime )
END IF

RETURN li_Return 
end function

public function String of_getline ();String	ls_Return

IF isValid ( inv_leasetype ) THEN
	ls_Return = inv_leasetype.of_GetLine ( )
END IF

RETURN ls_Return
end function

public function String of_gettype ();String	ls_Return

IF isValid ( inv_leasetype ) THEN
	ls_Return = inv_leasetype.of_GetType ( )
END IF

RETURN ls_Return
end function

public function string of_getnotes ();//
/***************************************************************************************
NAME			: of_GetNotes
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: String		(string of notes)
REVISION		: RDT 12-03-02
***************************************************************************************/
String	ls_Return

IF isValid ( inv_leasetype ) THEN
	ls_Return = inv_leasetype.of_GetNotes( )
END IF

RETURN ls_Return

end function

public function integer of_getcharges (date ad_out, time at_out, date ad_in, time at_in, ref n_cst_leaseCharges anv_LeaseCharges);Int	li_Return = -1

IF Not isValid ( inv_leasetype ) THEN
//	THIS.of_GetRivertonBeo ( ) 
END IF

IF isValid ( inv_leasetype ) THEN
	IF inv_leasetype.of_GetCharges ( ad_out , at_out , ad_in , at_in , anv_LeaseCharges ) = 1 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return
end function

public function string of_getscac ();String	ls_Return

IF isValid ( inv_leasetype ) THEN
	ls_Return = inv_leasetype.of_GetSCAC( )
END IF


Return ls_Return
end function

on n_cst_beo_equipmentleasetype2.create
call super::create
end on

on n_cst_beo_equipmentleasetype2.destroy
call super::destroy
end on

event ue_getvalueany;call super::ue_getvalueany;//Extending Ancestor to provide attribute support for this class.

Integer	li_Return

li_Return = AncestorReturnValue

IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_Attribute ) )

		CASE "SCAC"
			aa_Value = String ( THIS.of_GetSCAC ( ) )
					
		CASE ELSE
			
			li_Return = 0
	END CHOOSE

END IF

RETURN li_Return
end event

