$PBExportHeader$n_cst_beo_equipment2.sru
forward
global type n_cst_beo_equipment2 from pt_n_cst_beo
end type
end forward

global type n_cst_beo_equipment2 from pt_n_cst_beo
end type
global n_cst_beo_equipment2 n_cst_beo_equipment2

forward prototypes
public function string of_getair ()
public function integer of_setair (string as_value)
public function integer of_setid (long al_Value)
public function integer of_settype (string as_value)
public function integer of_setlength (decimal adec_value)
public function integer of_setstatus (string as_Value)
public function integer of_setcurevent (long al_Value)
public function integer of_setnextevent (long al_Value)
public function integer of_setnotes (string as_value)
public function integer of_setwidth (dec ad_Value)
public function integer of_setleased (String as_Value)
public function integer of_setnumber (string as_value)
public function string of_getnumber ()
public function string of_gettype ()
public function string of_getleased ()
public function long of_getid ()
public function string of_getstatus ()
public function boolean of_isfreightcarrying ()
public function integer of_delete ()
public function boolean of_isleased ()
public function integer of_getequipmentlease (ref n_cst_beo_equipmentlease2 anv_equipmentlease)
public function decimal of_getlength ()
public function decimal of_getwidth ()
public function long of_getreloadshipment ()
public function date of_getreloaddate ()
public function time of_getreloadtime ()
public function date of_getreloadfreetimeexpiredate ()
public function time of_getreloadfreetimeexpiretime ()
public function dec of_getamountbilled ()
public function integer of_setshipment (long al_Shipment)
public function int of_setreloadshipment (long al_ShipmentID)
public function long of_getshipment ()
public function string of_getnotes ()
public function String of_getinvoicenumber ()
public function string of_getftxstorageformated ()
public function string of_getftxperdiemformated ()
public function integer of_setleasetype (long al_value)
public function integer of_setreleasedate (date ad_Value)
public function integer of_setreleasetime (time at_Value)
public function integer of_getcategory ()
public function string of_getdescription ()
public function boolean of_ischassis ()
public function integer of_getitintype ()
public function integer of_setoeid (long al_value)
public function long of_getcurrentevent ()
public function string of_getisocode ()
public function integer of_setisocode (string as_value)
end prototypes

public function string of_getair ();RETURN This.of_GetValue ( "eq_air", TypeString! )
end function

public function integer of_setair (string as_value);RETURN This.of_SetAny ( "eq_air", as_Value )
end function

public function integer of_setid (long al_Value);RETURN THIS.of_SetAny ( "eq_id" , al_Value )
end function

public function integer of_settype (string as_value);Int	li_Return
String	lsa_Dupes[]
n_cst_equipmentmanager	lnv_EqMan
//IF lnv_EqMan.of_Existsequipment(  THIS.of_getnumber( ) ,as_Value , 'K', lsa_Dupes ) = 0 THEN //DNE
	li_Return = THIS.of_SetAny ( "eq_type" , as_Value )
//ELSE
//	li_Return = -1 //One or more exist
//END IF
RETURN li_Return
end function

public function integer of_setlength (decimal adec_value);RETURN THIS.of_SetAny ( "eq_length" , adec_Value )
end function

public function integer of_setstatus (string as_Value);RETURN THIS.of_SetAny ( "eq_status" , as_Value )
end function

public function integer of_setcurevent (long al_Value);RETURN THIS.of_SetAny ( "eq_cur_event" , al_Value )
end function

public function integer of_setnextevent (long al_Value);RETURN THIS.of_SetAny ( "eq_next_event" , al_Value )
end function

public function integer of_setnotes (string as_value);RETURN THIS.of_SetAny ( "equipment_notes" , as_Value )
// equipment_notes
end function

public function integer of_setwidth (dec ad_Value);RETURN THIS.of_SetAny ( "eq_height" , ad_Value )
end function

public function integer of_setleased (String as_Value);RETURN THIS.of_SetAny ( "eq_outside" , as_Value )
end function

public function integer of_setnumber (string as_value);// we are going to add the check in here to see if the change of this value
// would cause duplicate pieces of equipment.
Int	li_Return
n_cst_equipmentmanager	lnv_EqMan
String	lsa_Dupes[]
IF lnv_EqMan.of_Existsequipment( as_Value , lsa_Dupes ) = 0 THEN //DNE
	li_Return = THIS.of_SetAny ( "eq_ref" , as_Value )
ELSE
	li_Return = -1
END IF


RETURN li_Return
end function

public function string of_getnumber ();RETURN This.of_GetValue ( "eq_ref", TypeString! )
end function

public function string of_gettype ();RETURN This.of_GetValue ( "eq_type", TypeString! )
end function

public function string of_getleased ();RETURN This.of_GetValue ( "eq_outside", TypeString! )
end function

public function long of_getid ();RETURN This.of_GetValue ( "eq_id", TypeLong! )
end function

public function string of_getstatus ();RETURN This.of_GetValue ( "eq_status", TypeString! )
end function

public function boolean of_isfreightcarrying ();String	ls_Type

Boolean	lb_Return = FALSE


IF lb_Return = FALSE THEN

	ls_Type = This.of_GetType ( )
	
	IF IsNull ( ls_Type ) THEN
		SetNull ( lb_Return )
	END IF

END IF


IF lb_Return = FALSE THEN

	CHOOSE CASE ls_Type
	
	CASE	"S" /*STRT*/, &
			"N" /*VAN*/, &
			"V" /*TRLR*/, &
			"F" /*FLBD*/, &
			"R" /*REFR*/, &
			"K" /*TANK*/, &
			"B" /*RBOX*/, &
			"C" /*CNTN*/
	
		lb_Return = TRUE

	END CHOOSE

END IF


RETURN lb_Return
end function

public function integer of_delete ();//Returns : 1 (deleted), 0 (left active), -1 (Error)

String	ls_ErrorMessage = "Could not delete equipment."
n_cst_beo_EquipmentLease2	lnv_Lease
Date		ld_OriginationDate
Long		ll_OriginationEvent

Integer	li_Return = 1


lnv_Lease = CREATE n_cst_beo_EquipmentLease2


IF li_Return = 1 THEN

	CHOOSE CASE This.of_IsLeased ( )

	CASE TRUE
		//OK

	CASE FALSE
		//Operation is only supported for leased equipment, at present.
		ls_ErrorMessage += "~n(Operation is not supported for company equipment.)"
		li_Return = -1

	CASE ELSE
		//Could not determine.
		ls_ErrorMessage += "~n(Could not evaluate leased/owned information.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	lnv_Lease.of_SetSource ( This.of_GetSource ( ) )
	lnv_Lease.of_SetSourceId ( This.of_GetId ( ) )

	IF lnv_Lease.of_HasSource ( ) THEN
		//OK
	ELSE
		ls_ErrorMessage += "~n(Invalid source for lease object.)"
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	ld_OriginationDate = lnv_Lease.of_GetOriginationDate ( )
	ll_OriginationEvent = lnv_Lease.of_GetOriginationEvent ( )

	IF IsNull ( ld_OriginationDate ) THEN

		//OK -- we can delete it

	ELSE

		ls_ErrorMessage += "~n(The lease origination on " + String ( ld_OriginationDate )

		IF IsNull ( ll_OriginationEvent ) THEN
			ls_ErrorMessage += ", which was specified manually,"
		END IF

		ls_ErrorMessage += " has not been cleared.)"

		li_Return = 0

	END IF

END IF


IF li_Return = 1 THEN

	CHOOSE CASE This.of_SetStatus ( "X" )

	CASE 1
		//OK

	CASE ELSE
		//Failures of various kinds
		ls_ErrorMessage += "~n(Could not set status value.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return <= 0 AND Len ( ls_ErrorMessage ) > 0 THEN

	This.of_AddError ( ls_ErrorMessage )

END IF

DESTROY ( lnv_Lease ) 


RETURN li_Return
end function

public function boolean of_isleased ();Boolean	lb_Return


CHOOSE CASE This.of_GetLeased ( )

CASE "T"
	lb_Return = TRUE

CASE "F"
	lb_Return = FALSE

CASE ELSE
	SetNull ( lb_Return )

END CHOOSE


RETURN lb_Return
end function

public function integer of_getequipmentlease (ref n_cst_beo_equipmentlease2 anv_equipmentlease);Long	ll_LeaseID
Int	li_SetRtn
Int	li_Return = -1

n_cst_beo_equipmentlease2	lnv_Lease
n_cst_EquipmentManager		lnv_EquipmentManager

lnv_Lease = CREATE n_cst_beo_equipmentlease2

IF Upper ( THIS.of_GetLeased ( ) ) = "T" THEN
		
	//	lnv_EquipmentManager.of_Cache ( THIS.of_GetID ( ) , TRUE )
	li_SetRtn = lnv_Lease.of_SetSource ( THIS.of_GetSource( ) )
	//li_SetRtn = lnv_Lease.of_SetSource ( lnv_EquipmentManager.of_Get_ds_Equipment ( )  )
	li_SetRtn =	lnv_Lease.of_SetSourceID ( THIS.of_GetID ( ) )
	
	ll_LeaseID = lnv_Lease.of_GetfkequipmentLeaseType ( ) 
	

	
ELSE
	li_Return = 0
END IF

anv_equipmentlease = lnv_Lease

IF anv_equipmentlease.of_HasSource ()  THEN
	li_Return = 1
END IF

RETURN li_Return
end function

public function decimal of_getlength ();Decimal	{2} ld_Return

ld_Return = This.of_GetValue ( "eq_length", TypeLong! )

RETURN ld_Return
end function

public function decimal of_getwidth ();//This field was created in the database as "eq_height" but is really used to store width.

Decimal	{2} lc_Return

lc_Return = This.of_GetValue ( "eq_height", TypeLong! )

RETURN lc_Return
end function

public function long of_getreloadshipment ();RETURN This.of_GetValue ( "reloadshipment", TypeLong! )

end function

public function date of_getreloaddate ();RETURN This.of_GetValue ( "reloaddate", TypeDate! )
end function

public function time of_getreloadtime ();RETURN This.of_GetValue ( "reloadtime", Typetime! )
end function

public function date of_getreloadfreetimeexpiredate ();RETURN This.of_GetValue ( "reloadfreetimeexpiredate", TypeDate! )
end function

public function time of_getreloadfreetimeexpiretime ();RETURN This.of_GetValue ( "reloadfreetimeexpiretime", Typetime! )
end function

public function dec of_getamountbilled ();RETURN This.of_GetValue ( "amountbilled", Typedecimal! )
end function

public function integer of_setshipment (long al_Shipment);RETURN THIS.of_SetAny ( "equipmentlease_shipment" , al_Shipment )
end function

public function int of_setreloadshipment (long al_ShipmentID);RETURN THIS.of_SetAny ( "reloadshipment" , al_ShipmentID )
end function

public function long of_getshipment ();RETURN THIS.of_GetValue ( "equipmentlease_shipment" , TypeLong! )
end function

public function string of_getnotes ();//
/***************************************************************************************
NAME			: of_GetNotes	
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: String (Notes for equipment)
REVISION		: RDT 12-03-02
***************************************************************************************/
RETURN This.of_GetValue ( "equipment_notes", TypeString! )
end function

public function String of_getinvoicenumber ();RETURN This.of_GetValue ( "invoicenumber", TypeString! )
end function

public function string of_getftxstorageformated ();
// Returns a SPACE if equipment has an event, or not expired, or going to expire today.

String	ls_Return = " "

Integer	li_SQLCode
Long		ll_CurrEventID
Long		ll_EqId, ll_ShipID 
			
Date 		ldt_expire

ll_EQID = this.of_GetID( )


SELECT eq_cur_event
 INTO :ll_CurrEventID 
 FROM equipment
 WHERE eq_id  = :ll_EqId   ;

li_SqlCode = SQLCA.SqlCode


COMMIT ;

//Evaluate retrieval result

If li_SqlCode = 0 THEN 
	// check for ID
	
	If IsNull( ll_CurrEventID ) Then  // no pickup check dates
		ll_ShipID = this.of_getshipment( )	 
		
	  	SELECT lastfreedate
	  	INTO   :ldt_expire
     	FROM 	 disp_ship
	  	WHERE  ds_id = :ll_ShipId;
		  
		li_SqlCode = SQLCA.SqlCode
		COMMIT ;
		
		If li_SqlCode = 0 Then 
			If ldt_Expire >= Date( DateTime( Today () ) ) Then 
				ls_Return = "Free Time (Storage) EXPIRES " + String ( ldt_Expire, "mm/dd/yyyy")
			End If
			
			If ldt_Expire < Date( DateTime( Today () ) ) Then 
				ls_Return = "Free Time (Storage) EXPIRED " + String( ldt_Expire , "mm/dd/yyyy" ) 
			End If
		Else
			ls_Return = "of_GetFTXStorageFormated Select from Disp_Ship SQL Error"
		End If
	Else
		
		ls_Return = " "
	End If
	
ELSE	
	ls_Return = "***"
End If
	 
	 
 

Return 	ls_Return 
end function

public function string of_getftxperdiemformated ();
// Returns a space if expire is not today  or expired.

String	ls_Return = " "

Date 	ldt_expire

n_cst_beo_EquipmentLease2 lnv_EquipmentLease2

this.of_getEquipmentLease( lnv_EquipmentLease2 ) 

ldt_Expire = Date ( lnv_EquipmentLease2.of_getfreetimeexpiration ( ) ) 

If ldt_Expire >= Date( DateTime( Today () ) ) Then 
	ls_Return = "Free Time (Per Diem) EXPIRES " + String ( ldt_Expire, "mm/dd/yyyy")
End If

If ldt_Expire < Date( DateTime( Today () ) ) Then 
	ls_Return = "Free Time (Per Diem) EXPIRED " + String( ldt_Expire , "mm/dd/yyyy" ) 
End If


Return 	ls_Return 
end function

public function integer of_setleasetype (long al_value);Int	li_Return

n_cst_beo_equipmentlease2	lnv_Lease

li_Return = THIS.of_SetAny ( "equipmentlease_fkequipmentleasetype" , al_Value )

IF li_Return = 1 THEN
	THIS.of_getEquipmentLease ( lnv_Lease )
	lnv_Lease.of_CalculateFTX ( )
END IF

DESTROY( lnv_Lease ) 

RETURN li_Return
end function

public function integer of_setreleasedate (date ad_Value);RETURN THIS.of_SetAny ( "releasedate" , ad_Value )
end function

public function integer of_setreleasetime (time at_Value);RETURN THIS.of_SetAny ( "releasetime" , at_Value )
end function

public function integer of_getcategory ();//Returns : The appropriate type contant, or null if could not be determined.

n_cst_EquipmentManager	lnv_EquipmentManager

Integer	li_Return

li_Return = lnv_EquipmentManager.of_Type_To_Category ( This.of_GetType ( ) )

RETURN li_Return
end function

public function string of_getdescription ();//This is a partial transposition of functionality of N-cst_EquipmentManager, 
//enhanced to add notes to the description

Decimal	lc_Length, &
			lc_Width
String	ls_Work, &
			ls_Description, &
			ls_Note

lc_Length = This.of_GetLength ( )
lc_Width = This.of_GetWidth ( )
ls_Note = This.of_GetNotes ( )


IF lc_Length > 0 then
	ls_work += string(lc_Length, "0")
	choose case This.of_GetType ( )
	case "H", "C"
		//96 width gets confused with 9'6'' high-cube height
	case else
		if lc_Width > 0 then 
			ls_work += " - " + string(lc_Width, "0")
		end if
	end choose
end if

IF Len ( ls_Note ) > 0 THEN

	ls_Work += " - " + ls_Note

END IF

ls_description += ls_work

Return ls_Description

end function

public function boolean of_ischassis ();//Is the piece of equipment a chassis?
//Returns:  TRUE, FALSE, or Null if cannot be determined

Boolean	lb_Return = FALSE

String	ls_Type

ls_Type = This.of_GetType ( )

IF ls_Type = "H" THEN  //"H" = Chassis.  Should be replaced by a constant.

	lb_Return = TRUE

ELSEIF IsNull ( ls_Type ) THEN

	SetNull ( lb_Return )

END IF

RETURN lb_Return	
end function

public function integer of_getitintype ();//Returns : The ItinType for the equipment, or null if cannot be determined.

Integer	li_Category

Integer	li_Return


li_Category = This.of_GetCategory ( )

CHOOSE CASE li_Category

CASE 2  //PowerUnits
	li_Return = gc_Dispatch.ci_ItinType_PowerUnit

CASE 3  //TrailerChassis
	li_Return = gc_Dispatch.ci_ItinType_TrailerChassis

CASE 4  //Containers
	li_Return = gc_Dispatch.ci_ItinType_Container

CASE ELSE
	SetNull ( li_Return )

END CHOOSE

RETURN li_Return
end function

public function integer of_setoeid (long al_value);RETURN THIS.of_SetAny ( "oe_id" , al_Value )
end function

public function long of_getcurrentevent ();RETURN THIS.of_GetValue ( "eq_cur_event" , TypeLong! )
end function

public function string of_getisocode ();//  Added 4/14/2006 by SAT.  Want <tag> access to ISO CODE for equipment.
RETURN This.of_GetValue ( "equipment_isocode", TypeString! )
end function

public function integer of_setisocode (string as_value);//  Added 4/14/2006 by SAT.  Want access to ISO CODE for equipment.
RETURN THIS.of_SetAny ( "equipment_isocode" , as_Value )
end function

on n_cst_beo_equipment2.create
call super::create
end on

on n_cst_beo_equipment2.destroy
call super::destroy
end on

event constructor;call super::constructor;of_setKeyColumn ( "eq_id" )
end event

event ue_getobject;call super::ue_getobject;//Extending Ancestor to provide object support for this class.

//See ancestor script for explanation of return codes.

Integer	li_Return
Long		ll_Count, &
			ll_Index
Any		laa_Beo[]

n_cst_beo_EquipmentLease2	lnv_Lease

li_Return = AncestorReturnValue
aaa_Beo = laa_Beo


IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_ObjectName ) )

	CASE "LEASE"
		
		CHOOSE CASE THIS.of_GetEquipmentLease ( lnv_Lease )
				
			CASE 1  //Request resolved successfully.
				aaa_Beo [ 1 ] = lnv_Lease
			CASE 0  // not a leased piece of equipment
				//Leave the array empty, but return 0
				li_Return = 0
			CASE ELSE
				li_Return = -1
				
		END CHOOSE

		
	CASE ELSE
		li_Return = 0
			
	END CHOOSE

END IF

RETURN li_Return
end event

event ue_getvalueany;call super::ue_getvalueany;//Extending Ancestor to provide attribute support for this class.

Integer	li_Return

n_cst_EquipmentManager	lnv_Manager

li_Return = AncestorReturnValue

IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_Attribute ) )

		CASE "ID"
			aa_Value = This.of_GetID ( )

		CASE "LENGTH" 
			aa_Value = THIS.of_GetLength ( )
			
		CASE "WIDTH" 
			aa_Value = THIS.of_GetWidth ( )
			
		CASE "NUMBER"
			aa_Value = THIS.of_GetNumber ( )
			
		CASE "TYPE"
			aa_Value = lnv_manager.of_GetDisplayValue ( THIS.of_GetType ( ) )
			
		CASE "RELOADSHIPMENT"
			aa_Value = THIS.of_GetReloadShipment ( )
			
		CASE "RELOADDATE"
			aa_Value = THIS.of_GetReloadDate ( )
			
		CASE "RELOADTIME"
			aa_Value = THIS.of_GetReloadTime ( )
			
		CASE "RELOADFTXDATE" , "RELOADFREETIMEEXPIRATIONDATE"
			aa_Value = THIS.of_GetReloadFreeTimeExpireDate ( )
			
		CASE "RELOADFTXTIME" , "RELOADFREETIMEEXPIRATIONTIME"
			aa_Value = THIS.of_GetReloadFreeTimeExpireTime ( )
			
//		CASE "NOTIFYDATE"
//			aa_Value = THIS.of_GetNotifyDate ( )
//			
//		CASE "NOTIFYTIME"
//			aa_Value = THIS.of_GetNotifyTime ( )
			
		CASE "AMOUNTBILLED"
			aa_Value = THIS.of_GetAmountBilled ( )
			
		CASE "INVOICENUMBER"
			aa_Value = THIS.of_GetInvoiceNumber ( )
			
		CASE "FTXPERDIEMFORMATED"
			aa_Value = THIS.of_GetftxPerDiemFormated( )

		Case "FTXSTORAGEFORMATED"
			aa_Value = THIS.of_GetFTXStorageFormated()
		
		//**  Added 4/14/2006  S.A.T.  Need access to equipment notes and ISO code.
		CASE "NOTE", "NOTES"		
			aa_Value = THIS.of_getnotes ( )
		
		CASE "ISOCODE"
			aa_Value = THIS.of_getisocode ( )
		//**  End of Addition 4/14/2006
			
		CASE ELSE
			
			li_Return = 0
	END CHOOSE

END IF

RETURN li_Return
end event

event ue_setvalueany;call super::ue_setvalueany;Int	li_Return

IF Len ( as_attribute ) = 0 AND  Len ( String ( aa_value ) ) = 0 THEN
	RETURN 1 // so we can check that the event exists w. a 'triggerevent' call
END IF


CHOOSE CASE Upper ( as_attribute )
		
	CASE "NUMBER"
		li_Return = THIS.of_setnumber(   String ( aa_value ) ) 

	CASE "TYPE"
		li_Return = THIS.of_settype(  String ( aa_value ) ) 
		
	CASE "NOTES" 
		li_Return = THIS.of_SetNotes ( String ( aa_Value ))
		
	CASE "LENGTH"
		li_Return = THIS.of_SetLength ( Dec ( aa_Value ))
	
	//** Added 4/14/2006 by SAT.  Need access to ISO CODE		
	CASE "ISOCODE"
		li_Return = This.of_setisocode ( String (aa_Value ))
		
	//**  End of addition 4/14/2006	
	//** Added 4/20/2006 by SAT.
	
	CASE "LINE"
		li_Return = THIS.of_setleasetype ( Long (aa_Value ))
	//** End of addition 4/20/2006
	
END CHOOSE

RETURN li_Return
		
end event

