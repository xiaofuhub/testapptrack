$PBExportHeader$n_cst_equipmentposting.sru
forward
global type n_cst_equipmentposting from n_base
end type
end forward

global type n_cst_equipmentposting from n_base
end type
global n_cst_equipmentposting n_cst_equipmentposting

type variables
Private:
Constant String	cs_Need = "N"
Constant String	cs_Have = "H"
Constant	String	cs_Inactive = "I"


DataStore	ids_PostingCache
DataStore	ids_EquipmentCache

CONSTANT	String	cs_FileDelimiter = '~t'

end variables

forward prototypes
public function integer of_addneed (n_cst_beo_equipment2 anv_equipment)
public function integer of_replacetempeqids (long ala_tempids[], long ala_permids[])
public function integer of_removeneed (n_cst_beo_equipment2 anv_equipment)
public function integer of_setequipmentcache (datastore ads_eqcache)
public function integer of_addhave (n_cst_beo_equipment2 anv_equipment)
public function integer of_removehave (n_cst_beo_equipment2 anv_equipment)
public function integer of_proposehavepostings (n_cst_beo_equipment2 anva_equipment[])
public function integer of_writefiles ()
private function string of_getequipmentisocode (long al_eqid)
private function string of_getequipmentref (long al_eqid)
private function string of_getequipmentscac (long al_eqid)
private function string of_getfiledelimiter ()
private function string of_gethaveaddress1 (long al_eqid)
private function string of_gethaveaddress2 (long al_eqid)
private function string of_gethavecity (long al_eqid)
private function long of_gethavelocation (long al_eqid)
private function integer of_gethaves (ref long ala_eqids[])
private function string of_gethavestate (long al_eqid)
private function string of_gethavezip (long al_eqid)
private function string of_getneedcity (long al_eqid)
private function long of_getneedlocation (long al_eqid)
private function integer of_getneeds (ref long ala_eqids[])
private function string of_getneedstate (long al_eqid)
private function string of_getneedzip (long al_eqid)
private function string of_getpostinglocation ()
private function string of_getshipment (long al_eqid)
private function string of_getyourscac (long al_eqid)
private function integer of_writehaves ()
private function integer of_writeneeds ()
public function integer of_update ()
private function string of_gethavesitename (long al_eqid)
private function date of_getpostingdate (string as_type, long al_eqid)
private function date of_getpostingexpirationdate (string as_type, long al_eqid)
private function integer of_getequipmentlength (long al_eqid)
public function integer of_getshipmenttype (long al_eqid)
public function string of_getscaccode ()
end prototypes

public function integer of_addneed (n_cst_beo_equipment2 anv_equipment);Long	ll_EqID
Long	ll_Row

ll_EqID = anv_equipment.of_GetID ( ) 

ll_Row = ids_postingcache.InsertRow ( 0 ) 
ids_postingcache.SetItem ( ll_Row , 'equipmentid' , ll_EqID ) 
ids_postingcache.SetItem ( ll_Row , 'postingstatus' , this.cs_need )

IF isValid ( ids_equipmentcache ) THEN
	ll_Row = ids_Equipmentcache.Find ( "eq_id = " + String (ll_EqID ) + " and eq_status = 'K'" , 1 , ids_equipmentcache.RowCount ( ) )
	IF ll_Row > 0 THEN
		ids_equipmentcache.SetItem ( ll_Row , "Equipment_Status_postingstatus" ,  this.cs_need )
	END IF
END IF


RETURN 1
end function

public function integer of_replacetempeqids (long ala_tempids[], long ala_permids[]);Int		li_Return = 1
Long		ll_RowCount	
Long		i
Long		ll_ReplaceCount
Long		ll_IDCount
String	ls_Filter



ll_IDCount = UpperBound ( ala_Tempids[] )
IF ll_IDCount > UpperBound ( ala_Permids[]) THEN
	// we have a problem 
	li_Return = -1
END IF

IF li_Return = 1 THEN
	
	FOR i = 1 TO ll_IDCount
		ls_Filter = "equipmentid = " + String ( ala_tempids[i] )
		ids_postingcache.SetFilter ( ls_Filter ) 
		ids_postingcache.Filter ( )
		
		ll_RowCount = ids_postingcache.RowCount ( )
		FOR ll_ReplaceCount = 1 TO ll_RowCount
			ids_postingcache.SetItem ( ll_ReplaceCount , "equipmentid" , ala_Permids[i] )
		NEXT
	
	NEXT
END IF

ids_postingcache.SetFilter ( "" ) 
ids_postingcache.Filter ( )

RETURN li_Return
end function

public function integer of_removeneed (n_cst_beo_equipment2 anv_equipment);String	ls_Find
Long		ll_FindRtn
Long		ll_Row
Long		ll_EqID

ll_EqID = anv_Equipment.of_GetID ( )

ls_Find = "equipmentid = " + String (ll_EqID  ) + " AND postingstatus = '" + cs_need + "'"

ll_FindRtn = ids_postingcache.find( ls_Find , 1 , ids_postingcache.RowCount ( ) )

IF ll_FindRtn > 0 THEN
//	ids_Postingcache.SetItem ( ll_FindRtn, "postingstatus" , THIS.cs_Inactive )
	ids_postingcache.DeleteRow( ll_FindRtn )
END IF

IF isValid ( ids_equipmentcache ) THEN
	ll_Row = ids_Equipmentcache.Find ( "eq_id = " + String (ll_EqID ) + " and eq_status = 'K'" , 1 , ids_equipmentcache.RowCount ( ) )
	IF ll_Row > 0 THEN
		ids_equipmentcache.SetItem ( ll_Row , "Equipment_Status_postingstatus" ,   THIS.cs_Inactive )
	END IF
END IF

RETURN 1

end function

public function integer of_setequipmentcache (datastore ads_eqcache);ids_EquipmentCache = ads_eqcache
RETURN 1
end function

public function integer of_addhave (n_cst_beo_equipment2 anv_equipment);Long	ll_EqID
Long	ll_Row

ll_EqID = anv_equipment.of_GetID ( ) 

ll_Row = ids_postingcache.InsertRow ( 0 ) 
ids_postingcache.SetItem ( ll_Row , 'equipmentid' , ll_EqID ) 
ids_postingcache.SetItem ( ll_Row , 'postingstatus' , this.cs_Have )

IF isValid ( ids_equipmentcache ) THEN
	ll_Row = ids_Equipmentcache.Find ( "eq_id = " + String (ll_EqID ) + " and eq_status = 'K'" , 1 , ids_equipmentcache.RowCount ( ) )
	IF ll_Row > 0 THEN
		ids_equipmentcache.SetItem ( ll_Row , "Equipment_Status_postingstatus" ,  this.cs_Have )
	END IF
END IF


RETURN 1
end function

public function integer of_removehave (n_cst_beo_equipment2 anv_equipment);String	ls_Find
Long		ll_FindRtn
Long		ll_Row
Long		ll_EqID

ll_EqID = anv_Equipment.of_GetID ( )

ls_Find = "equipmentid = " + String (ll_EqID  ) + " AND postingstatus = '" + cs_Have + "'"

ll_FindRtn = ids_postingcache.find( ls_Find , 1 , ids_postingcache.RowCount ( ) )

IF ll_FindRtn > 0 THEN
//	ids_Postingcache.SetItem ( ll_FindRtn, "postingstatus" , THIS.cs_Inactive )
	ids_postingcache.DeleteRow( ll_FindRtn )
END IF

IF isValid ( ids_equipmentcache ) THEN
	ll_Row = ids_Equipmentcache.Find ( "eq_id = " + String (ll_EqID ) + " and eq_status = 'K'" , 1 , ids_equipmentcache.RowCount ( ) )
	IF ll_Row > 0 THEN
		ids_equipmentcache.SetItem ( ll_Row , "Equipment_Status_postingstatus" ,   THIS.cs_Inactive )
	END IF
END IF

RETURN 1

end function

public function integer of_proposehavepostings (n_cst_beo_equipment2 anva_equipment[]);
Int	li_EquipmentCount
Int	i
n_cst_EquipmentManager	lnv_EqMan

li_EquipmentCount = UpperBound ( anva_equipment[] )

FOR i = 1 TO li_EquipmentCount
	IF anva_equipment[i].of_GetType ( ) = lnv_EqMan.cs_cntn THEN
		THIS.of_AddHave ( anva_equipment[i] )
	END IF
NEXT


RETURN 1
end function

public function integer of_writefiles ();int	li_HaveRtn
Int	li_NeedRtn
Int	li_Return = 1

li_HaveRtn = THIS.of_Writehaves( )
li_NeedRtn = THIS.of_Writeneeds( )

IF li_haveRtn <> 1 OR li_NeedRtn <> 1 THEN
	li_Return = -1
END IF	

RETURN li_Return


end function

private function string of_getequipmentisocode (long al_eqid);String	ls_Return 
String	ls_Code
Long		ll_EqId

ll_EqId = al_eqid

SELECT "equipment"."isocode"  
 INTO :ls_Code  
 FROM "equipment"  
WHERE "equipment"."eq_id" = :ll_EqId   ;

CHOOSE CASE SQLCA.Sqlcode
		
	CASE 0, 100 
		COMMIT;
		ls_Return = ls_Code
	CASE ELSE 
		ROLLBACK;
END CHOOSE

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return
			
end function

private function string of_getequipmentref (long al_eqid);Long	ll_EqID
String	ls_Ref
String	ls_Return
  
ll_EqID = al_eqid
  
SELECT "equipment"."eq_ref"  
 INTO :ls_Ref  
 FROM "equipment"  
WHERE "equipment"."eq_id" = :ll_EqID ;

CHOOSE CASE SQLCA.SQLcode
	CASE 0,100
		Commit;
		ls_Return = ls_Ref
	CASE ELSE
		Rollback;
END CHOOSE

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return
		
end function

private function string of_getequipmentscac (long al_eqid);String	ls_Return 
String	ls_Scac
Long		ll_EqId

ll_EqId = al_eqid

SELECT "equipmentleasetype"."scac"  
 INTO :ls_SCAC  
 FROM "outside_equip",   
		"equipmentleasetype"  
WHERE ( "equipmentleasetype"."id" = "outside_equip"."fkequipmentleasetype" ) and  
		( ( "outside_equip"."oe_id" = :ll_EqId ) )   ;

CHOOSE CASE SQLCA.Sqlcode
		
	CASE 0, 100 
		COMMIT;
		ls_Return = ls_Scac
	CASE ELSE 
		ROLLBACK;
END CHOOSE

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return
			
end function

private function string of_getfiledelimiter ();RETURN cs_FileDelimiter
end function

private function string of_gethaveaddress1 (long al_eqid);Long	ll_EqID
Long	ll_Site
String	ls_Address1
String	ls_Return

ll_EqID = al_eqid
ll_Site = THIS.of_GetHavelocation( al_eqid )
  
IF ll_Site > 0 THEN
	
   SELECT "companies"."co_Addr1"  
    INTO :ls_Address1 
    FROM "companies"  
   WHERE "companies"."co_id" = :ll_Site  ;
	
	CHOOSE CASE SQLCA.sqlcode
		CASE 0, 100
			Commit;
			ls_Return = ls_Address1
		CASE ELSE
			Rollback;
	END CHOOSE
	
END IF

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return
end function

private function string of_gethaveaddress2 (long al_eqid);Long		ll_EqID
Long		ll_Site
String	ls_Address
String	ls_Return

ll_EqID = al_eqid
ll_Site = THIS.of_GetHavelocation( al_eqid )
  
IF ll_Site > 0 THEN
	
   SELECT "companies"."co_addr2"  
    INTO :ls_Address  
    FROM "companies"  
   WHERE "companies"."co_id" = :ll_Site  ;
	
	CHOOSE CASE SQLCA.sqlcode
		CASE 0, 100
			Commit;
			ls_Return = ls_Address
		CASE ELSE
			Rollback;
	END CHOOSE
	
END IF

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return
end function

private function string of_gethavecity (long al_eqid);Long		ll_EqID
Long		ll_Site
String	ls_City
String	ls_Return

ll_EqID = al_eqid
ll_Site = THIS.of_GetHavelocation( al_eqid )
  
IF ll_Site > 0 THEN
	
   SELECT "companies"."co_City"  
    INTO :ls_City  
    FROM "companies"  
   WHERE "companies"."co_id" = :ll_Site  ;
	
	CHOOSE CASE SQLCA.sqlcode
		CASE 0, 100
			Commit;
			ls_Return = ls_City
		CASE ELSE
			Rollback;
	END CHOOSE
	
END IF

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return
end function

private function long of_gethavelocation (long al_eqid);Long	ll_Return
Long	ll_SiteID
Long	ll_OverRide
Long	ll_EqID
Boolean	lb_Continue

ll_EqID = al_eqid 

//JBiron - changing from current event to final destination
//SELECT "companies"."co_id"  
// INTO :ll_SiteID  
// FROM "equipment",   
//		"disp_events",   
//		"companies"  
//WHERE ( "disp_events"."de_site" = "companies"."co_id" ) and  
//		( "equipment"."eq_cur_event" = "disp_events"."de_id" ) and  
//		( ( "equipment"."eq_id" = :ll_EqID ) )   ;

SELECT "disp_ship"."ds_findest_id"
	INTO :ll_SiteID
	FROM "disp_ship",
		"outside_equip"
	WHERE ( "outside_equip"."oe_id" = :ll_EqID ) and
		( "disp_ship"."ds_id" = "outside_equip"."shipment" ) ;

CHOOSE CASE SQLCA.SQLcode
	CASE 0, 100
		Commit;
		lb_Continue = TRUE
		ll_Return = ll_SiteID
	CASE ELSE
		Rollback;
END CHOOSE


// check for site override
IF lb_Continue THEN
	  SELECT "equipmentpostingrulescompany"."overridelocation"  
    INTO :ll_OverRide  
    FROM "equipmentpostingrulescompany"  
   WHERE "equipmentpostingrulescompany"."companyid" = :ll_SiteID   ;
	
	CHOOSE CASE SQLCA.SQLcode
		CASE 0, 100
			Commit;
		CASE ELSE
			Rollback;
	END CHOOSE
	
	IF ll_OverRide > 0 THEN
		ll_Return = ll_OverRide
	END IF
	
END IF
		
RETURN ll_Return
end function

private function integer of_gethaves (ref long ala_eqids[]);// this only pulls from the DB NOT the cache

Long		ll_RowCount
Long		i
Long		lla_IDS[]
Long		ll_EqID
Long		ll_KeepCount
Long		ll_OEShipment
String	ls_Status
Int		li_exclude

String	ls_Permit

DataStore	lds_Postings
lds_Postings = CREATE DataStore
lds_Postings.DataObject = "d_equipmentposting"
lds_Postings.SetTransobject( SQLCA )
lds_Postings.Retrieve( )

lds_Postings.SetFilter ( "postingstatus = '" + cs_Have + "'") 
lds_Postings.Filter ( )

ll_RowCount = lds_Postings.rowCount( )


FOR i = ll_RowCount TO 1 STEP -1
	
	ll_EqID = lds_Postings.GetItemNumber ( i , "equipmentid" )
															 
	// verify lease line permits posting
	SELECT "equipmentleasetype"."enableposting"  
   INTO :ls_permit  
   FROM "equipmentleasetype",   
         "outside_equip"  
   WHERE ( "outside_equip"."fkequipmentleasetype" = "equipmentleasetype"."id" ) and  
         ( ( "outside_equip"."oe_id" = :ll_EqID ) )   ;
	
	IF SQLCA.sqlcode = 0 THEN
		COMMIT;
	ELSE
		COMMIT;
		CONTINUE
	END IF
		
	IF Upper ( ls_permit ) <> 'T' THEN
		CONTINUE
	END IF
	
	// verify the billto on the shipment permits posting
	SELECT "equipmentpostingrulescompany"."excludeifbillto"  
   INTO :li_Exclude 
   FROM "disp_ship",   
         "equipmentpostingrulescompany",   
         "outside_equip"  
   WHERE ( "outside_equip"."shipment" = "disp_ship"."ds_id" ) and  
         ( "equipmentpostingrulescompany"."companyid" = "disp_ship"."ds_billto_id" ) and  
         ( ( "outside_equip"."oe_id" = :ll_EqID ) )   ;

	
	IF SQLCA.sqlcode = 0 OR SQLCA.sqlcode = 100 THEN
		COMMIT;
	ELSE
		COMMIT;
		CONTINUE
	END IF
		
	IF li_exclude = 1 THEN
		CONTINUE
	END IF

//// We are going to remove the enteries if the equipment is deactivated
//// or it is not linked to a shipment.
  SELECT "equipment"."eq_status",   
         "outside_equip"."shipment"  
    INTO :ls_Status,   
         :ll_OEShipment  
    FROM "outside_equip",   
         "equipment"  
   WHERE ( "equipment"."eq_id" = "outside_equip"."oe_id" ) and  
         ( ( "outside_equip"."oe_id" = :ll_EqID ) )   ;

	IF SQLCA.sqlcode = 0 THEN
		COMMIT;		
		IF IsNull ( ll_OEShipment ) OR Upper ( ls_Status ) <> 'K' THEN
			lds_Postings.Deleterow( i )
			CONTINUE
		END IF	
	ELSE
		Commit;
		lds_Postings.Deleterow( i )
		CONTINUE
	END IF

	ll_KeepCount ++
	lla_IDS[ ll_KeepCount ] = ll_EqID

NEXT

IF lds_Postings.Update( ) = 1 THEN
	Commit;
ELSE
	Rollback;
END IF

DESTROY (lds_Postings )

ala_eqids[] = lla_IDS

RETURN ll_KeepCount
end function

private function string of_gethavestate (long al_eqid);Long		ll_EqID
Long		ll_Site
String	ls_State
String	ls_Return

ll_EqID = al_eqid
ll_Site = THIS.of_GetHavelocation( al_eqid )
  
IF ll_Site > 0 THEN
	
   SELECT "companies"."co_state"  
    INTO :ls_State  
    FROM "companies"  
   WHERE "companies"."co_id" = :ll_Site  ;
	
	CHOOSE CASE SQLCA.sqlcode
		CASE 0, 100
			Commit;
			ls_Return = ls_State
		CASE ELSE
			Rollback;
	END CHOOSE
	
END IF

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return
end function

private function string of_gethavezip (long al_eqid);Long		ll_EqID
Long		ll_Site
String	ls_Zip
String	ls_Return

ll_EqID = al_eqid
ll_Site = THIS.of_GetHavelocation( al_eqid )
  
IF ll_Site > 0 THEN
	
   SELECT "companies"."co_zip"  
    INTO :ls_Zip  
    FROM "companies"  
   WHERE "companies"."co_id" = :ll_Site  ;
	
	CHOOSE CASE SQLCA.sqlcode
		CASE 0, 100
			Commit;
			ls_Return = Trim ( ls_Zip )
		CASE ELSE
			Rollback;
	END CHOOSE
	
END IF

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return
end function

private function string of_getneedcity (long al_eqid);String	ls_Return
String	ls_City
Long		ll_NeedSite
Long		ll_EqID

ll_EqID = al_eqid

ll_NeedSite = THIS.of_getneedlocation( ll_EqID )

IF ll_NeedSite > 0 THEN

  SELECT "companies"."co_city"  
    INTO :ls_City  
    FROM "companies"  
   WHERE "companies"."co_id" = :ll_NeedSite  ;
	
	CHOOSE CASE SQLCA.SQLcode
		CASE 0, 100
			Commit;
			ls_Return = ls_City
		CASE ELSE
			Rollback;
	END CHOOSE
	
END IF

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return


end function

private function long of_getneedlocation (long al_eqid);Long	ll_Return
Long	ll_SiteID
Long	ll_EqID

ll_Eqid = al_eqid

  SELECT "companies"."co_id"  
    INTO :ll_SiteID  
    FROM "companies",   
         "disp_ship",   
         "outside_equip"  
   WHERE ( "outside_equip"."shipment" = "disp_ship"."ds_id" ) and  
         ( "disp_ship"."ds_origin_id" = "companies"."co_id" ) and  
         ( ( "outside_equip"."oe_id" = :ll_EqID ) )   ;


		
CHOOSE CASE SQLCA.SQLCode
	CASE 0, 100
		ll_Return = ll_SiteID
		Commit;
	CASE ELSE
		Rollback;
END CHOOSE

RETURN ll_Return
end function

private function integer of_getneeds (ref long ala_eqids[]);// this only pulls from the DB NOT the cache

Long		ll_RowCount
Long		i
Long		lla_IDS[]
Long		ll_EqID
Long		ll_KeepCount
Int		li_exclude
Long		ll_OEShipment
string	ls_Status
String	ls_Permit

DataStore	lds_Postings
lds_Postings = CREATE DataStore
lds_Postings.DataObject = "d_equipmentposting"
lds_Postings.SetTransobject( SQLCA )
lds_Postings.Retrieve( )

lds_Postings.SetFilter ( "postingstatus = '" + cs_need + "'") 
lds_Postings.Filter ( )

ll_RowCount = lds_Postings.rowCount( )


FOR i = ll_RowCount TO 1 STEP -1
	
	ll_EqID = lds_Postings.GetItemNumber ( i , "equipmentid" )
															 
	// verify lease line permits posting
	SELECT "equipmentleasetype"."enableposting"  
   INTO :ls_permit  
   FROM "equipmentleasetype",   
         "outside_equip"  
   WHERE ( "outside_equip"."fkequipmentleasetype" = "equipmentleasetype"."id" ) and  
         ( ( "outside_equip"."oe_id" = :ll_EqID ) )   ;
	
	IF SQLCA.sqlcode = 0 THEN
		COMMIT;
	ELSE
		Commit;
		CONTINUE
	END IF
		
	IF Upper ( ls_permit ) <> 'T' THEN		
		CONTINUE
	END IF
	
	// verify the billto on the shipment permits posting
	SELECT "equipmentpostingrulescompany"."excludeifbillto"  
   INTO :li_Exclude 
   FROM "disp_ship",   
         "equipmentpostingrulescompany",   
         "outside_equip"  
   WHERE ( "outside_equip"."shipment" = "disp_ship"."ds_id" ) and  
         ( "equipmentpostingrulescompany"."companyid" = "disp_ship"."ds_billto_id" ) and  
         ( ( "outside_equip"."oe_id" = :ll_EqID ) )   ;
	
	IF SQLCA.sqlcode = 0 OR SQLCA.sqlcode = 100 THEN
		COMMIT;
	ELSE
		Commit;
		CONTINUE
	END IF
		
	IF li_exclude = 1 THEN
		CONTINUE
	END IF
	
	
//// We are going to remove the enteries if the equipment is deactivated
//// or it is not linked to a shipment.
	SELECT "equipment"."eq_status",   
         "outside_equip"."shipment"  
    INTO :ls_Status,   
         :ll_OEShipment  
    FROM "outside_equip",   
         "equipment"  
   WHERE ( "equipment"."eq_id" = "outside_equip"."oe_id" ) and  
         ( ( "outside_equip"."oe_id" = :ll_EqID ) )   ;

	IF SQLCA.sqlcode = 0 THEN
		COMMIT;		
		IF IsNull ( ll_OEShipment ) OR Upper ( ls_Status ) <> 'K' THEN
			lds_Postings.Deleterow( i )
			CONTINUE
		END IF	
	ELSE
		Commit;
		lds_Postings.Deleterow( i )
		CONTINUE
	END IF
	
	
	
	
	ll_KeepCount ++
	lla_IDS[ ll_KeepCount ] = ll_EqID

NEXT

IF lds_Postings.Update( ) = 1 THEN
	Commit;
ELSE
	Rollback;
END IF

DESTROY (lds_Postings )

ala_eqids[] = lla_IDS

RETURN ll_KeepCount
end function

private function string of_getneedstate (long al_eqid);String	ls_Return
String	ls_State
Long		ll_NeedSite
Long		ll_EqID

ll_EqID = al_eqid

ll_NeedSite = THIS.of_getneedlocation( ll_EqID )

IF ll_NeedSite > 0 THEN

  SELECT "companies"."co_State"  
    INTO :ls_State  
    FROM "companies"  
   WHERE "companies"."co_id" = :ll_NeedSite  ;
	
	CHOOSE CASE SQLCA.SQLcode
		CASE 0, 100
			Commit;
			ls_Return = ls_State
		CASE ELSE
			Rollback;
	END CHOOSE
	
END IF

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return


end function

private function string of_getneedzip (long al_eqid);String	ls_Return
String	ls_Zip
Long		ll_NeedSite
Long		ll_EqID

ll_EqID = al_eqid

ll_NeedSite = THIS.of_getneedlocation( ll_EqID )

IF ll_NeedSite > 0 THEN

  SELECT "companies"."co_Zip"  
    INTO :ls_Zip  
    FROM "companies"  
   WHERE "companies"."co_id" = :ll_NeedSite  ;
	
	CHOOSE CASE SQLCA.SQLcode
		CASE 0, 100
			Commit;
			ls_Return = Trim ( ls_Zip )
		CASE ELSE
			Rollback;
	END CHOOSE
	
END IF

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return


end function

private function string of_getpostinglocation ();String	ls_Folder

ls_Folder = gnv_app.of_getapplicationfolder( )
//If MessageBox ("Location " , "Use Devel path" , QUESTION! , YESNO! ,1 ) = 1 THEN
//	ls_Folder = "c:\eqpostings"
//ELSE
	ls_Folder += "..\eqpostings"
//END IF

IF NOT DirectoryExists ( ls_Folder ) THEN
	CreateDirectory ( ls_Folder ) 
END IF

RETURN ls_Folder
end function

private function string of_getshipment (long al_eqid);Long	ll_EqID
String	ls_Return
String	ls_ShipmentID

ll_EqID = al_eqid
 
 
SELECT "outside_equip"."shipment"  
 INTO :ls_ShipmentID  
 FROM "outside_equip"  
WHERE "outside_equip"."oe_id" = :ll_EqID  ;

CHOOSE CASE SQLCA.SQLcode
	CASE 0,100
		Commit;
		ls_Return = ls_ShipmentID
	CASE ELSE
		Rollback;
END CHOOSE

IF isNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return
		
		
end function

private function string of_getyourscac (long al_eqid);String	ls_Return 
String	ls_Scac
Long		ll_EqId

ll_EqId = al_eqid

SELECT "equipmentleasetype"."yourscac"  
 INTO :ls_SCAC  
 FROM "outside_equip",   
		"equipmentleasetype"  
WHERE ( "equipmentleasetype"."id" = "outside_equip"."fkequipmentleasetype" ) and  
		( ( "outside_equip"."oe_id" = :ll_EqId ) )   ;

CHOOSE CASE SQLCA.Sqlcode
	CASE 0, 100 
		COMMIT;
	CASE ELSE 
		ROLLBACK;
END CHOOSE

IF Len ( ls_SCac ) = 0 OR IsNull ( ls_Scac ) THEN
	n_cst_setting_yourcompanyscac	lnv_COScac
	lnv_COScac = CREATE n_cst_setting_yourcompanyscac
	ls_Scac = lnv_CoScac.of_GetValue( )
	DESTROY lnv_COScac
END IF

ls_Return = ls_scac
IF isNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return
			
end function

private function integer of_writehaves ();//	
//	Company scac, line scac , iso code,  city, citycode, state, zip,  type, Qty, post date, expire date.
//
Int		li_Return = 1
Long		lla_haveIds[]
Long		ll_haveCount
Long		i
Long		ll_Eq
Int		li_Filehandle
Long		ll_WriteRtn
String	ls_Delimiter
String	ls_FileString
String	ls_FileName
String	ls_FolderLocation
String	ls_FullPath

String	ls_Shipment
String	ls_MotorCarrier
String	ls_ShippingLine
String	ls_ISOCode
String	ls_ContainerRef
String	ls_ChassisRef
String	ls_Address1
String	ls_Address2
String	ls_City
String	ls_CityCode // we are not populating this
String	ls_State
String	ls_zip
String	ls_Post = "Yes"
String	ls_Type = "Have"
String	ls_Qty = '1'
String	ls_PostDate	
String	ls_ExpireDate
String	ls_EqLength
String	ls_ShipType

ls_FolderLocation = THIS.of_GetPostinglocation( )
//JBiron - Updated name to make it a little more descriptive
ls_FileName = This.of_GetScacCode() + "-eqpost-" + String (today( ), "yymmdd" ) + "-" + String (now (), "HHMM" )

ls_Fullpath = ls_FolderLocation + '\' + ls_FileName
li_Filehandle = FileOpen ( ls_Fullpath ,LineMode! , Write!  )

IF li_Filehandle >= 0 THEN

	ll_haveCount = THIS.of_Gethaves( lla_haveIds )
	ls_Delimiter = THIS.of_getFiledelimiter( )
	
	FOR i = 1 TO ll_haveCount
		
		ll_Eq = lla_haveIds[i]
		
		ls_Shipment = THIS.of_Getshipment( ll_Eq )
		ls_MotorCarrier = THIS.of_GetYourscac( ll_Eq )
		ls_ShippingLine =  THIS.of_Getequipmentscac( ll_Eq )
		ls_ISOCode = THIS.of_Getequipmentisocode( ll_Eq )
		ls_ContainerRef = THIS.of_Getequipmentref( ll_Eq )
//		ls_Chassis
		ls_Address1 = THIS.of_gethavesitename ( ll_Eq )  // name 
		ls_Address2 = THIS.of_GetHaveaddress1( ll_Eq )  // line one of address
		ls_City = THIS.of_gethaveCity ( ll_Eq ) 
		ls_State = THIS.of_GethaveState ( ll_eq )
		ls_Zip = THIS.of_GetHavezip( ll_Eq )
		//JBiron - Added arguments to postingdate and exppostingdate
		ls_PostDate	=  String ( THIS.of_GetPostingDate (  cs_have , ll_Eq ) , "yyyy-mm-dd")
		ls_ExpireDate = String ( THIS.of_GetPostingexpirationdate(  cs_Have, ll_Eq ) , "yyyy-mm-dd" )
		//MFS - Added arguments to equipmentlength and shiptype
		ls_EqLength = String( This.of_GetEquipmentLength(ll_Eq) )
		ls_ShipType = String( This.of_GetShipmentType(ll_Eq) )
		
		IF Len ( Trim ( ls_Shipment ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_MotorCarrier ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_ShippingLine ) )= 0 THEN CONTINUE
		IF Len ( Trim ( ls_ISOCode ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_ContainerRef ) ) = 0 THEN CONTINUE
//		IF Len ( Trim ( ls_Address1 ) ) = 0 THEN CONTINUE
//		IF Len ( Trim ( ls_Address2 ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_City ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_State ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_Zip ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_PostDate ) ) = 0 THEN CONTINUE
		IF IsNull ( ls_PostDate ) THEN CONTINUE
		IF Len ( Trim ( ls_ExpireDate ) ) = 0 THEN CONTINUE
		IF isNull ( ls_expireDate ) THEN CONTINUE
		IF isNull( ls_EqLength ) THEN CONTINUE
		IF isNull( ls_ShipType ) THEN CONTINUE
				
		ls_FileString  = ls_Shipment + ls_Delimiter 
		ls_FileString += ls_MotorCarrier + ls_Delimiter
		ls_FileString += ls_ShippingLine + ls_Delimiter
		ls_FileString += ls_ISOCode + ls_Delimiter
		ls_FileString += ls_ContainerRef + ls_Delimiter
		ls_FileString += ls_ChassisRef + ls_Delimiter
		ls_FileString += ls_Address1 + ls_Delimiter
		ls_FileString += ls_Address2 + ls_Delimiter
		ls_FileString += ls_City + ls_Delimiter
		ls_FileString += ls_CityCode + ls_Delimiter
		ls_FileString += ls_State + ls_Delimiter
		ls_FileString += ls_zip + ls_Delimiter
		ls_FileString += ls_Post + ls_Delimiter
		ls_FileString += ls_Type + ls_Delimiter
		ls_FileString += ls_Qty + ls_Delimiter
		ls_FileString += ls_PostDate + ls_Delimiter
		ls_FileString += ls_ExpireDate + ls_Delimiter
		ls_FileString += ls_EqLength + ls_Delimiter
		ls_FileString += ls_ShipType
		
		ll_WriteRtn = FileWrite ( li_Filehandle, ls_FileString )
	
	NEXT
ELSE
	li_Return = -1
END IF

FileClose ( li_Filehandle )

n_cst_FileSrvwin32	lnv_File
lnv_File = CREATE n_cst_FileSrvwin32
IF lnv_File.of_getfilesize( ls_Fullpath ) = 0 THEN
	FileDelete ( ls_FullPath )
END IF
DESTROY ( lnv_File )


RETURN li_Return
end function

private function integer of_writeneeds ();//	
//	Company scac, line scac , iso code,  city, citycode, state, zip,  type, Qty, post date, expire date.
//
Int		li_Return = 1
Long		lla_NeedIds[]
Long		ll_NeedCount
Long		i
Long		ll_Eq
Int		li_Filehandle
Long		ll_WriteRtn
String	ls_Delimiter
String	ls_FileString
String	ls_FileName
String	ls_FolderLocation
String	ls_FullPath

String	ls_Shipment
String	ls_MotorCarrier
String	ls_ShippingLine
String	ls_ISOCode
String	ls_ContainerRef
String	ls_ChassisRef
String	ls_Address1
String	ls_Address2
String	ls_City
String	ls_CityCode // we are not populating this
String	ls_State
String	ls_zip
String	ls_Post
String	ls_Type = "Need"
String	ls_Qty = '1'
String	ls_PostDate	
String	ls_ExpireDate
String	ls_EqLength
String	ls_ShipType

ls_FolderLocation = THIS.of_GetPostinglocation( )
//JBiron - Updated name to make it a little more descriptive
ls_FileName = This.of_GetScacCode() + "-eqpost-" + String (today( ), "yymmdd" ) + "-" + String (now (), "HHMM" )

ls_Fullpath = ls_FolderLocation + '\' + ls_FileName
li_Filehandle = FileOpen ( ls_Fullpath ,LineMode! , Write!  )

IF li_Filehandle >= 0 THEN

	ll_NeedCount = THIS.of_GetNeeds( lla_NeedIds )
	ls_Delimiter = THIS.of_getFiledelimiter( )
	
	FOR i = 1 TO ll_NeedCount
		
		ll_Eq = lla_NeedIds[i]
		
		ls_Shipment = THIS.of_GetShipment( ll_Eq )
		ls_MotorCarrier = THIS.of_GetYourscac( ll_Eq )
		ls_ShippingLine =  THIS.of_Getequipmentscac( ll_Eq )
		ls_ISOCode = THIS.of_Getequipmentisocode( ll_Eq )
		ls_City = THIS.of_getNeedCity ( ll_Eq ) 
		ls_State = THIS.of_GetNeedState ( ll_eq )
		//JBiron - Added arguments to postingdate and exppostingdate
		ls_PostDate	=  String ( THIS.of_GetPostingDate (  cs_need , ll_eq ) , "yyyy-mm-dd")
		ls_ExpireDate = String ( THIS.of_GetPostingexpirationdate( cs_Need, ll_Eq ) , "yyyy-mm-dd" )
		//MFS - Added arguments to equipmentlength and shiptype
		ls_EqLength = String( This.of_GetEquipmentLength(ll_Eq) )
		ls_ShipType = String( This.of_GetShipmentType(ll_Eq) )
		
		IF Len ( Trim ( ls_Shipment ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_MotorCarrier ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_ShippingLine ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_ISOCode ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_City ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_State ) ) = 0 THEN CONTINUE
		IF Len ( Trim ( ls_PostDate ) ) = 0 THEN CONTINUE
		IF IsNull ( ls_postDate ) THEN CONTINUE
		IF Len ( Trim ( ls_ExpireDate ) ) = 0 THEN CONTINUE
		IF IsNull ( ls_ExpireDate ) THEN CONTINUE
		IF isNull( ls_EqLength ) THEN CONTINUE
		IF isNull( ls_ShipType ) THEN CONTINUE
		
		
		ls_FileString  = ls_Shipment + ls_Delimiter 
		ls_FileString += ls_MotorCarrier + ls_Delimiter
		ls_FileString += ls_ShippingLine + ls_Delimiter
		ls_FileString += ls_ISOCode + ls_Delimiter
		ls_FileString += ls_ContainerRef + ls_Delimiter
		ls_FileString += ls_ChassisRef + ls_Delimiter
		ls_FileString += ls_Address1 + ls_Delimiter
		ls_FileString += ls_Address2 + ls_Delimiter
		ls_FileString += ls_City + ls_Delimiter
		ls_FileString += ls_CityCode + ls_Delimiter
		ls_FileString += ls_State + ls_Delimiter
		ls_FileString += ls_zip + ls_Delimiter
		ls_FileString += ls_Post + ls_Delimiter
		ls_FileString += ls_Type + ls_Delimiter
		ls_FileString += ls_Qty + ls_Delimiter
		ls_FileString += ls_PostDate + ls_Delimiter
		ls_FileString += ls_ExpireDate + ls_Delimiter
		ls_FileString += ls_EqLength + ls_Delimiter
		ls_FileString += ls_ShipType
			
		ll_WriteRtn = FileWrite ( li_Filehandle, ls_FileString )
	
	NEXT
ELSE
	li_Return = -1
END IF

FileClose ( li_Filehandle )

n_cst_FileSrvwin32	lnv_File
lnv_File = CREATE n_cst_FileSrvwin32
IF lnv_File.of_getfilesize( ls_Fullpath ) = 0 THEN
	FileDelete ( ls_FullPath )
END IF
DESTROY ( lnv_File )
RETURN li_Return




end function

public function integer of_update ();ids_postingcache.Update ( )
Commit;

RETURN 1
end function

private function string of_gethavesitename (long al_eqid);// returns the site name
Long	ll_EqID
Long	ll_Site
String	ls_Name
String	ls_Return

ll_EqID = al_eqid
ll_Site = THIS.of_GetHavelocation( al_eqid )
  
IF ll_Site > 0 THEN
	
   SELECT "companies"."co_Name"  
    INTO :ls_Name 
    FROM "companies"  
   WHERE "companies"."co_id" = :ll_Site  ;
	
	CHOOSE CASE SQLCA.sqlcode
		CASE 0, 100
			Commit;
			ls_Return = ls_Name
		CASE ELSE
			Rollback;
	END CHOOSE
	
END IF

IF IsNull ( ls_Return ) THEN
	ls_Return = ""
END IF

RETURN ls_Return
end function

private function date of_getpostingdate (string as_type, long al_eqid);Date	ld_Return

//JBiron - Changing eq post date from "today" 
//to deliver by date for imports and today for exports
//ld_Return = Date ( String (  Today ( ) , "yyyy-mm-dd" ) )
IF as_Type = cs_have THEN
	SELECT "disp_ship"."delbydate"
	INTO :ld_Return
	FROM "outside_equip",
			"disp_ship"
	WHERE ("outside_equip"."oe_id" = :al_EqID ) and
			( "outside_Equip"."shipment" = "disp_ship"."ds_id" ) ;
				
	CHOOSE CASE SQLCA.Sqlcode
		CASE 0, 100
			COMMIT;
		CASE ELSE
			ROLLBACK;
	END CHOOSE
				
ELSE
	ld_Return = Date ( String (  Today ( ) , "yyyy-mm-dd" ) )
END IF

RETURN ld_Return
end function

private function date of_getpostingexpirationdate (string as_type, long al_eqid);Date	ld_Return

//JBiron - Changing exp date from today+3 to deliver by + 3 for imports
//and pickup date for exports
//ld_Return = Date ( String (  RelativeDate (  Today ( ), 3 ) , "yyyy-mm-dd" ) )

IF as_Type = cs_have THEN
	SELECT DATEADD(day,3,"disp_ship"."delbydate")
		INTO :ld_Return
		FROM "outside_equip",
				"disp_ship"
		WHERE ("outside_equip"."oe_id" = :al_EqID ) and
				( "outside_Equip"."shipment" = "disp_ship"."ds_id" ) ;
ELSE
	
	SELECT "disp_ship"."pickupbydate"
		INTO :ld_Return
		FROM "outside_equip",
				"disp_ship"
		WHERE ("outside_equip"."oe_id" = :al_EqID ) and
				( "outside_Equip"."shipment" = "disp_ship"."ds_id" ) ;
				
		IF isnull(ld_Return) THEN
			ld_Return = Date ( String (  RelativeDate (  Today ( ), 3 ) , "yyyy-mm-dd" ) )
		END IF

				
END IF

CHOOSE CASE SQLCA.Sqlcode 
	CASE 0, 100
		Commit;
	CASE ELSE
		RollBack;
END CHOOSE

RETURN ld_Return
end function

private function integer of_getequipmentlength (long al_eqid);Integer	li_Return
Integer	li_Length

SELECT "equipment"."eq_length"  
 INTO :li_Length  
 FROM "equipment"  
WHERE "equipment"."eq_id" = :al_EqId   ;

CHOOSE CASE SQLCA.Sqlcode
		
	CASE 0, 100 
		COMMIT;
		li_Return = li_Length
	CASE ELSE 
		ROLLBACK;
END CHOOSE

Return li_Return
end function

public function integer of_getshipmenttype (long al_eqid);Integer	li_Return


SELECT "disp_ship"."ds_ship_type"
INTO :li_Return
FROM "outside_equip",
		"disp_ship"
WHERE ("outside_equip"."oe_id" = :al_EqID ) AND
		( "outside_Equip"."shipment" = "disp_ship"."ds_id" ) ;
			
CHOOSE CASE SQLCA.Sqlcode
	CASE 0, 100
		COMMIT;
	CASE ELSE
		ROLLBACK;
END CHOOSE
				
Return li_Return
end function

public function string of_getscaccode ();String	ls_Return

n_cst_setting_yourcompanyscac	lnv_COScac
lnv_COScac = Create n_cst_setting_yourcompanyscac
ls_Return = lnv_CoScac.of_GetValue( )
Destroy (lnv_COScac)

Return ls_Return
end function

on n_cst_equipmentposting.create
call super::create
end on

on n_cst_equipmentposting.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_postingcache = CREATE DataStore
ids_postingcache.DataObject = "d_equipmentPosting"
ids_postingcache.SetTransObject ( SQLCA )
ids_postingcache.Retrieve ( )
Commit;


end event

event destructor;call super::destructor;DESTROY ( ids_postingcache )
end event

