$PBExportHeader$n_cst_importrating.sru
forward
global type n_cst_importrating from n_cst_base
end type
end forward

global type n_cst_importrating from n_cst_base
end type
global n_cst_importrating n_cst_importrating

type variables
PRIVATE:
	
	Datastore	ids_rate
	Datastore	ids_RateCache
	Datastore	ids_RateLinkOrigZone
	Datastore	ids_RateLinkDestZone
	Datastore	ids_rateLinkBillToId
	Datastore	ids_rateTableNames
	Datastore	ids_zonES
	
	
		

															
	Constant int	ci_verifyNewTableMode = 1
	Constant int	ci_verifyUpdateRatesMode = 2

end variables

forward prototypes
public function boolean of_verifyzone (string as_zone)
public function boolean of_verifybilltoid (long al_id)
public function boolean of_isvalidrateid (long al_id)
public function boolean of_codenameexists (string as_codename)
private function integer of_adderror (string as_error)
public function boolean of_consistantcodenames ()
public function boolean of_consistantbillids ()
public function boolean of_legalcategory (integer ai_category)
public function boolean of_consistantcategories ()
public function boolean of_consistantorigins ()
public function boolean of_verifyalldests (ref boolean ab_hasduplicates, ref string asa_invalidnames[], ref string asa_duplicatenames[])
public function boolean of_verifyimportdata ()
public function boolean of_existstable ()
public function integer of_geterrors (datawindow adw_target)
public function boolean of_verifyflat ()
public function integer of_save ()
public function integer of_importfile (ref string as_filename)
public function boolean of_billtoidexists (long al_id)
public function boolean of_companyoverride ()
public function integer of_reset ()
public function boolean of_verifyzonecombos (ref string asa_duplicatecombos[])
public function boolean of_verifyzones (string as_columnname, ref string asa_invalidzones[])
public function integer of_verifynewtable (ref boolean ab_codenameexists)
public function integer of_verifyfile (integer ai_verifymode, ref boolean ab_codenameexists)
public function integer of_importrateupdates (integer ai_verifymode)
private function integer of_discardexistingratesfromimport ()
private function integer of_importnewratetable (boolean ab_newrowsonly, ref string as_message)
public function integer of_importnewtableflat (ref string as_message)
public function integer of_verifyupdaterates ()
public function integer of_updateexistingrates (ref string as_message)
public function integer of_update ()
end prototypes

public function boolean of_verifyzone (string as_zone);//returns true if the zone entered is a valid zone
boolean 	lb_return
String 	ls_Name
String 	ls_ZoneName
Int 		li_count

ls_ZoneName = as_zone

  SELECT Count ( * ) 
    INTO :li_Count
    FROM "zone"  
   WHERE "zone"."name" = :ls_zoneName
           ;
COMMIT;

IF li_count > 0 THEN
	lb_return = true
	
ELSE
	lb_return = false
	this.of_addERror( "origin zone ERROR: "+ ls_zoneName+ " is not a valid zone name." )
END IF
	

RETURN lb_return
end function

public function boolean of_verifybilltoid (long al_id);//returns true if the id is a valid bill to Id
Boolean 	lb_return

String 	ls_Name
Long		ll_id
Int 		li_count

ll_id = al_id

  SELECT Count ( * ) 
    INTO :li_Count
    FROM "companies"  
   WHERE "companies"."co_id" = :ll_id
           ;
COMMIT;

IF li_count > 0 THEN
	lb_return = true
	
ELSE
	lb_return = false
END IF

RETURN lb_return
end function

public function boolean of_isvalidrateid (long al_id);//returns true if the rate id is valid, as in it exists in teh table "rate"
Boolean 	lb_return
String 	ls_Name
Long		ll_rateId
Int 		li_count

ll_rateId = al_id
IF not ISNULL( ll_rateID ) THEN
	  SELECT Count ( * ) 
		 INTO :li_Count
		 FROM "rate"  
		WHERE "rate"."id" = :ll_rateId
				  ;
	COMMIT;
	
	IF li_count > 0 THEN
		lb_return = true
		
	ELSE
		this.of_addError( "Rate ID ERROR: id "+string(ll_rateId)+" does not exist." )
		lb_return = false
	END IF
ELSE
	this.of_addError( "Rate ID ERROR: ids cannot be null." )
END IF
RETURN lb_return
end function

public function boolean of_codenameexists (string as_codename);/***************************************************************************************
NAME: 			of_codeNameExists

ACCESS:			public	
		
ARGUMENTS: 		
							as_codename

RETURNS:			true if codename exists, false otherwise
	
DESCRIPTION:	Checks the table "rateTable" for the table named as_codename
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	12-22-2005

	

***************************************************************************************/
Boolean lb_return
String 	ls_codeName
Int 		li_count

ls_codeName = as_codeName

  SELECT Count ( * ) 
    INTO :li_Count
    FROM "ratetable"  
   WHERE "ratetable"."codename" = :ls_codeName
           ;
COMMIT;

IF li_count > 0 THEN
	lb_return = true
	
ELSE
	lb_return = false
END IF

Return lb_return

end function

private function integer of_adderror (string as_error);//Adds an error message.
String				ls_ErrorMessage
n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

ls_ErrorMessage = as_error 

lnv_Error.SetErrorMessage( ls_ErrorMessage )
lnv_Error.SetMessageHeader ( "Rate" )


return 1
end function

public function boolean of_consistantcodenames ();/***************************************************************************************
NAME: 			of_consistantCodeNames

ACCESS:			public
		
ARGUMENTS: 		
							(Expected values)

RETURNS:			true if all the code names are the same for the imported file
	
DESCRIPTION:
	Returns true if all the codenames are the same for the imported file.


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :  Created By Dan 12-22-2005
	

***************************************************************************************/

//returns true if all the code names are the same, or if there are no codenames
Boolean 	lb_return
String	ls_codeName
String	ls_constantCodeName

Long	ll_index
Long	ll_codeNameRows


lb_return = true
ll_codeNameRows = ids_rate.RowCount( )
//check to see if the user made a new code name, and also check to see if all codeNames are consistant
FOR ll_index = 1 TO ll_codenameRows
	ls_codeName = ids_rate.getItemString( ll_index, "codename" )
	
	IF ll_index = 1 THEN
		ls_constantCodeName = ls_codeName
	END IF
	//check for codename consistancy
	IF ls_constantCodeName = ls_codeName THEN
		//good, values are the same	
	ELSE
		lb_return = false
		//this.of_adderror( "CodeName ERROR: All codenames must be the same." )
		EXIT			//as soon as i find inconsistant data I can quit looking
	END IF
NEXT

RETURN  lb_return
end function

public function boolean of_consistantbillids ();/***************************************************************************************
NAME: 	of_consistantbillIds		

ACCESS:		public	
		
ARGUMENTS: 		
							(Expected values)

RETURNS:			true if all imported Bill To Ids are the same, false otherwise
	
DESCRIPTION:  This checks to see if the imported file has all the same company ids.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 12-22-2005
	

***************************************************************************************/
Boolean lb_return

Long		ll_billId
Long		ll_constantBillId

Long	ll_index
Long	ll_billRows


lb_return = true
ll_billRows = ids_rate.RowCount( )
//check to see if the user made a new code name, and also check to see if all codeNames are consistant
FOR ll_index = 1 TO ll_billRows
	ll_billId = ids_rate.getItemNumber( ll_index, "billtoid" )
	
	IF ll_index = 1 THEN
		ll_constantBillId = ll_billId
	END IF
	//check for codename consistancy
	IF ll_constantBillId = ll_billId THEN
		//good, values are the same	
	ELSE
		//this.of_addError( "BILL TO ERROR: Company ids must all be the same.")
		lb_return = false
		EXIT			//as soon as i find inconsistant data I can quit looking
	END IF
NEXT


Return lb_return
end function

public function boolean of_legalcategory (integer ai_category);/***************************************************************************************
NAME: 			of_legalCategory

ACCESS:			public
		
ARGUMENTS: 		
							ai_category:	the category number being checked

RETURNS:			true if the category number makes sense, false otherwise
	
DESCRIPTION:  Returns true if the category number exists, false otherwise, for now only 
					categories 1 and 2 exist.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 12-22-2005
	

***************************************************************************************/
Boolean lb_return

lb_return = ( ai_category = 2 OR ai_category = 1 )

//IF NOT lb_return THEN
//	this.of_addError( "Category ERROR: Categories must be either 1 or 2")
//END IF
//
RETURN lb_return
end function

public function boolean of_consistantcategories ();/***************************************************************************************
NAME: 			of_consistantcategories

ACCESS:			public
		
ARGUMENTS: 		
							(Expected values)

RETURNS:			True if the imported file has all the same categories.
	
DESCRIPTION: Returns true if all the categories for the table imported are the same.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 12-22-2005
	

***************************************************************************************/

Boolean 	lb_return

Long		ll_category
Long		ll_constantBillId

Long	ll_index
Long	ll_billRows


lb_return = true
ll_billRows = ids_rate.RowCount( )
//check to see if the user made a new code name, and also check to see if all codeNames are consistant
FOR ll_index = 1 TO ll_billRows
	ll_category = ids_rate.getItemNumber( ll_index, "category" )
	
	IF ll_index = 1 THEN
		ll_constantBillId = ll_category
	END IF
	//check for codename consistancy
	IF ll_constantBillId = ll_category THEN
		//good, values are the same	
	ELSE
		lb_return = false
		//this.of_addError( "Category Error: All categories must be the same" )
		EXIT			//as soon as i find inconsistant data I can quit looking
	END IF
NEXT

return lb_return
end function

public function boolean of_consistantorigins ();/***************************************************************************************
NAME: 			of_consistantorigins

ACCESS:			public
		
ARGUMENTS: 		
							(Expected values)

RETURNS:			true if all the origin names are the same for the imported file.
	
DESCRIPTION:
	
	true if all the origin names are the same for the imported file.

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created By Dan 12-22-2005

***************************************************************************************/

Boolean 	lb_return

String	ls_origZone
String	ls_constantOrigName

Long	ll_index
Long	ll_codeNameRows


lb_return = true
ll_codeNameRows = ids_rate.RowCount( )
//check to see if the user made a new code name, and also check to see if all codeNames are consistant
FOR ll_index = 1 TO ll_codenameRows
	ls_origZone = ids_rate.getItemString( ll_index, "originzone" )
	
	IF ll_index = 1 THEN
		ls_constantOrigName = ls_origZone
	END IF
	//check for codename consistancy
	IF ls_constantOrigName = ls_origZone THEN
		//good, values are the same	
	ELSE
		lb_return = false
		this.of_addError( "Origin ERROR: All origin names must be the same" )
		EXIT			//as soon as i find inconsistant data I can quit looking
	END IF
NEXT

REturn lb_return
end function

public function boolean of_verifyalldests (ref boolean ab_hasduplicates, ref string asa_invalidnames[], ref string asa_duplicatenames[]);/***************************************************************************************
NAME: 			of_verifyAllDests

ACCESS:			public
		
ARGUMENTS: 		
							ab_hadDuplicates:	set to true if there are duplicate destinations
							asa_invalidNames:  array of invalid names returned
							asa_duplicateNames:  array of duplicate names

RETURNS:			true if all destinations are valid
	
DESCRIPTION:  Returns all the information about the destinations in the imported file.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 12-22-2005
	

***************************************************************************************/

//returns true if all destinations are valid
//returns true by reference if there is duplicate data
Boolean 	lb_AllDataValid 
Boolean	lb_hasDuplicates
Long	ll_rows
Long	ll_index
Long	ll_invalidCount
Long	ll_duplicateCount
String	ls_destZone
String	ls_searchZone
String	ls_previousZone

String	lsa_invalidNames[]				//list of invalid names found, could be doubles if there are dupes
String	lsa_duplicateNames[]				//list of duplicates,  there could be duplicates within this

Long	ll_first
Long	ll_last
Long	ll_mid


IF isValid( ids_rate ) THEN
	ll_rows = ids_rate.rowCount( )
	lb_allDataValid = true
	
	//assumes ids_rate is sorted by destzone in ascending order	
	FOR ll_index = 1 TO ll_rows
		ls_destZone = ids_rate.getItemString( ll_index, "destzone" )
			
		IF ll_index = 1 THEN
			ls_previousZone = ls_destZone
		END IF
		//make sure the zone is valid-------------------------------------------
		ll_first = 1
		ll_last = ids_zones.rowCount()
		
		//binary search through the target primary and filter buffers for the id
		DO WHILE ll_first <= ll_last
			ll_mid = ((ll_first + ll_last)/2)
	
			ls_searchZone = ids_zones.getItemString( ll_mid, "name" )
			IF ls_searchZone = ls_destZone THEN
				//ll_mid is the insertion point
				//current data is valid
				EXIT
			END IF
				
			IF ls_searchZone > ls_destZone THEN
				ll_last = ll_mid - 1
			ELSE
				ll_first = ll_mid + 1
			END IF
		LOOP
		
		//didn't find it, so we add it to our list of invalid names found
		IF ll_first > ll_last THEN
			lb_AllDataValid = false
			ll_invalidCount++
			this.of_addERror( "destination zone ERROR: "+ ls_destZone+ " is not a valid zone name." )
			lsa_invalidNames[ ll_invalidCount ] = ls_destZone
		END IF
	
		//make sure it is not a duplicate-----------------------------------------------
		IF ll_index > 1 THEN
			IF ls_previousZone < ls_destZone THEN
				//correct order and niether is null
				ls_previousZone = ls_destZone
			ELSE
				ll_duplicateCount++
				this.of_addError( "destination zone ERROR: duplicate destination zone '"+ls_previousZone+"'" )
				lsa_duplicateNames[ll_duplicateCount] = ls_destZone
				lb_hasDuplicates = true
			END IF
		END IF
		//MessageBox("", "Here")
	NEXT
END IF

ab_hasDuplicates = lb_hasDuplicates
asa_invalidNames = lsa_invalidNames
asa_duplicatenames = lsa_duplicateNames

return lb_AllDataValid
end function

public function boolean of_verifyimportdata ();//returns true if logic for creating a new table is true, also sets the instance variable ii_importdatastatus 
Boolean	lb_return

Boolean  lb_codeNameExists					//if true then they can't create a new table
Boolean	lb_UniformCodeNames				//if true then data is consistant

Boolean	lb_billToIdExists					//if false then don't proceed with processing
Boolean	lb_UniformBillToIds				//if true data is consistant

Boolean	lb_legalCategory					//category numbers must be 1 or 2 currently
Boolean  lb_UniformCategories				//if true data is consistant

Boolean	lb_legalOrigin						//true if the origin name exists
Boolean	lb_UniformOrigins					//if true data is consistant

Boolean	lb_verifyDests						//if true then all destinations are valid, and unique
Boolean	lb_dupeDests						//true if there are duplicate destinations

String	lsa_invalidNames[]				//list of invalidDestinationNames Found
String	lsa_dupeNames[]					//list of duplicate destination names found


Long		ll_Rows
Long		ll_index

String	ls_codeName
String	ls_constantCodeName

Long		ll_billId
Long		ll_constantBillId

Int		li_category

String	ls_origin
String	ls_dest

//n_cst_numerical	inv_bitOps
UnsignedInt	li_status

String ls_test
IF isValid( ids_rate ) THEN
	ll_Rows = ids_rate.RowCount()
//MessageBox("begin", "begin")
	
	IF ll_Rows > 0 THEN
		ls_constantCodeName = ids_rate.getItemString( 1, "codename" )
		ll_constantBillId = ids_rate.getItemNumber( 1, "billtoid" )
		li_category = ids_rate.getItemNumber( 1, "category" )
		ls_origin = ids_rate.getItemString( 1, "originzone" )
		
		
		//checks to see if the first code name is the correct one
		lb_codeNameExists = this.of_codeNameExists( ls_constantCodeName ) 
		IF lb_codeNameExists THEN
			li_status+= 1			//sets bit 1 to 1
		END IF
		
		//ls_test += string( lb_codeNameExists )
		//checks consistancy of codeNames
		lb_UniformCodeNames =  ( this.of_consistantcodenames( ) )
		IF lb_uniformCodeNames THEN
			li_status+= 2			//sets bit 2 to 1
		END IF
		//ls_test += string( lb_UniformCodeNames)
		
		
		//check for valid billtoIds and consistancy
		lb_billToIdExists = this.of_billToIdExists( ll_constantBillId )
		IF lb_billToIdExists THEN
			li_status+= 4 			//sets bit 3 to 1
		END IF
		//ls_test += string(lb_billToIdExists )
		
		lb_UniformBillToIds =  ( this.of_consistantbillids( ) )
		IF lb_uniformBillToIds THEN
			li_status+= 8			//sets bit 4 to 1
		END IF
		//ls_test += string( lb_UniformBillToIds)
		
		//check for valid category numbers and consistancy
		lb_legalCateGory = this.of_legalCategory( li_category )
		IF lb_legalCategory THEN
			li_status+= 16			//sets bit 5 to 1 
		END IF
		//ls_test += string( lb_legalCateGory)
		
	   lb_UniformCategories =  ( this.of_consistantCategories( ) )
		IF lb_uniformCateGories  THEN
			li_status+= 32			//sets bit 6 to 1
		END IF
		//ls_test += string( lb_UniformCategories)
		
		//check to make sure the origin is valid, and that all origins are the same
		lb_legalOrigin = this.of_VerifyZone( ls_origin )
		IF lb_legalOrigin THEN
			li_status+= 64			//sets bit 7 to 1
		END IF
		//ls_test += string( lb_legalOrigin )
		
		lb_UniformOrigins =  ( this.of_consistantOrigins( ) )
		IF lb_legalOrigin THEN
			li_status+= 128		//sets bit 8 to 1
		END IF
		//ls_test += string(lb_UniformOrigins )
		
		//check for validation of destinations and uniquiness
		lb_verifyDests = this.of_verifyAllDests( lb_dupeDests, lsa_invalidNames, lsa_dupeNames )
		IF lb_verifyDests THEN
			li_status+= 256		//sets bit 9 To 1
		END IF
		
		IF lb_dupeDests THEN
			li_status+= 512		//sets bit 10 to 1
		END IF
		
		//ls_test += string( lb_verifyDests) + string(lb_dupeDests)
		
		
		lb_return = (lb_codeNameExists AND lb_UniformCodeNames AND lb_billToIdExists AND lb_UniformBillToIds &
						AND lb_legalCateGory AND lb_UniformCategories AND lb_legalOrigin AND lb_UniformOrigins &
						AND lb_verifyDests AND lb_dupeDests)
		
		
		
	END IF
END IF
//MessageBox("end", ls_test)
//resets the status of the instance variable


RETURN	lb_return

end function

public function boolean of_existstable ();/***************************************************************************************
NAME: 			of_existsTable

ACCESS:			public
		
ARGUMENTS: 		
							(Expected values)

RETURNS:			true if the table exists in the database already or not.. Falsoe otherwise.
	
DESCRIPTION:   It actually checks to see if the code name for the imported file exists in the
					database or not.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 12-22-2005
	

***************************************************************************************/

//the following returns true if there is a rate id with the same table name and
//company id as the imported file.
Boolean lb_return


Long		ll_Id
String	ls_codename
Int 		li_count

IF isValid( ids_rate ) THEN
	IF ids_rate.rowcount() > 0 THEN
		ll_Id = ids_rate.getItemNumber( 1, "billtoid" )
		ls_codeName = ids_rate.getItemString( 1,"codename" )
		IF ll_id > 0 THEN
			  SELECT Count ( * ) 
				 INTO :li_Count
				 FROM  {oj "ratelinkbillable" RIGHT OUTER JOIN "rate" ON "ratelinkbillable"."rateid" = "rate"."id"} 
				WHERE "ratelinkbillable"."billtoid" = :ll_Id AND  "rate"."codename" = :ls_codeName
						  ;
			COMMIT;
			
			IF li_count > 0  THEN
				lb_return = true
				
			ELSE
				lb_return = false
			END IF
		END IF
	END IF
END IF
RETURN lb_return
end function

public function integer of_geterrors (datawindow adw_target);/***************************************************************************************
NAME: 		of_getErrors	

ACCESS:			public
		
ARGUMENTS: 		
							adw_target:  teh datawindow that will be populated with the errors,
											it should have one column of strings.

RETURNS:			1
	
DESCRIPTION:  Populates the target datawindow with errors accumulated from the verification
			check functions.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :  Created By Dan 12-22-2005
	

***************************************************************************************/

//puts all the errors into the target datawindow
N_cst_ofrerror	lnv_temp[]
N_cst_ofrerror lnv_current
LONG		ll_index
Long		ll_max
Long		ll_first
Long		ll_last
Long		ll_mid
String	ls_errorMessage
String	ls_currentError

IF isValid( adw_target ) AND isValid( inv_ofrerrorcollection ) THEN
	
	inv_ofrerrorcollection.geterrorarray( lnv_temp )
	ll_max = upperBound( lnv_temp )
	
	FOR ll_index = 1 TO ll_max
 
		IF isValid( lnv_temp[ll_index] ) THEN
			ls_currentError = lnv_temp[ll_index].geterrormessage( )
			
			ll_first = 1
			ll_last = adw_target.rowCount()
			
			//binary search through the target primary and filter buffers for the id
			DO WHILE ll_first <= ll_last
				ll_mid = ((ll_first + ll_last)/2)
				
				ls_errorMessage = adw_target.getItemString( ll_mid, "nonduplicate" )
				IF ls_errorMessage = ls_currentError THEN
					//ll_mid is the insertion point
					//current data is valid
					EXIT
				END IF
					
				IF ls_errorMessage > ls_currentError THEN
					ll_last = ll_mid - 1
				ELSE
					ll_first = ll_mid + 1
				END IF
			LOOP
			
			//didn't find it, so we add it to our list 
			IF ll_first > ll_last THEN
				//MessageBox("", ls_currentError)
				IF ls_currentError > "" THEN
					adw_target.insertRow( ll_first )
					adw_target.setItem( ll_first, "nonduplicate", ls_currentError )
				END IF
			END IF
		END IF
	NEXT
END IF
return 1
end function

public function boolean of_verifyflat ();Boolean lb_return

//returns true if all the data matches required data for a flat rate. Including 0 as the value for breakpoints.

Long	ll_max
Long	ll_index

String	ls_rateunit
Long		ll_ratebreak

ll_max = ids_rate.rowCount()

lb_return = true
FOR ll_index = 1 TO ll_max
	ll_rateBreak = ids_rate.getItemNumber( ll_index, "ratebreak" )
	ls_rateunit = ids_rate.getItemString( ll_index, "rateunit" )
	
	IF ll_rateBreak = 0 THEN
		
	ELSE
		this.of_adderror( "RateBreak ERROR: All ratebreaks must equal 0 for Flat rates." )
		lb_return = false
	
	END IF
	
	IF ls_rateUnit = "F" THEN
		
	ELSE
		this.of_addERror( "Rate Unit ERROR: Only changes for Flat rates can be imported. ")	
		lb_return  = false
		
	END IF
	
	IF not lb_return THEN
		EXIT
	END IF
NEXT

RETURN lb_return
end function

public function integer of_save ();//  If the ii_updatemode was set, then it will attempt to do the correct update.
Int li_return

li_return  = this.of_update(  )


RETURN li_return
end function

public function integer of_importfile (ref string as_filename);//opens open dialogue if as_filename is an empty string or null

Int	 li_return
String	ls_null

SetNull( li_return )
SetNull( ls_null )

IF isValid( ids_rate ) THEN
	IF len( as_fileName ) >= 0 THEN
	ELSE
		as_fileName = ls_null
	END IF
	
	li_return  = ids_rate.importFile( as_fileName )
	
	IF li_return > 0 THEN
		ids_rate.setSort( "destzone A" )
		ids_rate.sort()
		
		IF this.of_verifyflat( ) THEN
			li_return = 1
		ELSE
			li_return = -1
		END IF
	END IF
END IF

RETURN li_return
end function

public function boolean of_billtoidexists (long al_id);/***************************************************************************************
NAME: 		of_billtoIdExists	

ACCESS:			public
		
ARGUMENTS: 		
							al_id:	company id that we are checking to see if it exists.

RETURNS:			True if it does exists false otherwise
	
DESCRIPTION:  Using embedded sequal this function checks to see if the id al_id exists as
					a company id or not.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	CreatedBy Dan	12-22-05

***************************************************************************************/
Boolean 	lb_return

Long		ll_Id
Int 		li_count

ll_Id = al_id
IF not IsNull( ll_id ) THEN
	  SELECT Count ( * ) 
		 INTO :li_Count
		 FROM "companies"  
		WHERE "companies"."co_id" = :ll_Id
				  ;
	COMMIT;
	
	IF li_count > 0 OR al_id = 0 THEN
		lb_return = true
		
	ELSE
		lb_return = false
		this.of_adderror( "Company Override ERROR: ID "+string( ll_id )+ " is not valid.")
	END IF
ELSE
	this.of_adderror( "Company Override ERROR: ID cannot be a null Value")
END IF
RETURN lb_return
end function

public function boolean of_companyoverride ();/***************************************************************************************
NAME: 			of_companyOverride

ACCESS:			public
		
ARGUMENTS: 		
							(Expected values)

RETURNS:			true if it is an override false otherwise
	
DESCRIPTION:	IF the imported file has a ll_coid other than 0 then it is considdered
					a company override, otherwsie its not.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 12-22-05
	

***************************************************************************************/
Boolean 	lb_return
Long		ll_rows
Long		ll_coId

IF isValid( ids_rate ) THEN
	ll_rows = ids_rate.rowCount()
	
	IF ll_rows > 0 THEN
			ll_coid = ids_rate.getItemNumber( 1, "billtoid" )
			
			IF ll_coid > 0 THEN
				lb_return = true
			END IF
	
	END IF
	
END IF

RETURN lb_return
end function

public function integer of_reset ();//resets all the caches so that another file can be opened.

ids_rate.reset()
ids_RateCache.reset()
ids_RateLinkOrigZone.reset()
ids_RateLinkDestZone.reset()
ids_rateLinkBillToId.reset()
ids_rateTableNames.reset()
ids_zones.reset()


this.clearOfRerrors( )
REturn 1
end function

public function boolean of_verifyzonecombos (ref string asa_duplicatecombos[]);//Dan 5-25-2006
//returns true if all destinations/origin pairs are unique. 
//returns by reference an array of duplicate combinations in string form
Boolean	lb_hasDuplicates
Long	ll_rows
Long	ll_index

String	ls_destZone
String	ls_origZone
String	ls_nextOrigZone
String	ls_nextDestZone

String	lsa_invalidNames[]				//list of invalid names found, could be doubles if there are dupes
String	lsa_duplicateNames[]				//list of duplicates,  there could be duplicates within this

IF isValid( ids_rate ) THEN
	ll_rows = ids_rate.rowCount( )

	
	//Sorting it like this allows me to look to see if the currentRow has the same combo as CurrentRow+1
	//if there are then this should fail.
	ids_rate.setSort("originzone A,destzone A")
	ids_rate.sort()
	
	IF ll_rows >0 THEN
		ls_destZone = ids_rate.getItemString( 1, "destzone" )
		ls_origZone = ids_rate.getItemString( 1, "originzone" )
	END IF
	
	FOR ll_index = 2 TO ll_rows
		ls_NextdestZone = ids_rate.getItemString( ll_index, "destzone" )
		ls_NExtorigZone = ids_rate.getItemString( ll_index, "originzone" )
		
		IF ls_nextDestZone = ls_destZone AND ls_nextOrigZone = ls_origZone THEN
			//failed validation.
			lb_hasduplicates = true
			lsa_duplicateNames[upperBound(lsa_duplicateNames)+1] = "Origin: "+ls_origZone+", Destination: "+ls_destZone
		END IF
	NEXT
END IF

asa_duplicateCombos = lsa_duplicateNames

return not lb_hasDuplicates
end function

public function boolean of_verifyzones (string as_columnname, ref string asa_invalidzones[]);//Dan 5-25-2006
//This function will search the specified column of ids_rate to see if the zones exist
//in the database for that column.
Boolean 	lb_AllDataValid 
Long	ll_rows
Long	ll_index
Long	ll_invalidCount
String	ls_Zone
String	ls_searchZone


Long	ll_first
Long	ll_last
Long	ll_mid

String	lsa_invalidNames[]


IF isValid( ids_rate ) THEN
	ll_rows = ids_rate.rowCount( )
	lb_allDataValid = true
	
	//for all the rows being imported, check to see if the specified columnname
	//is a valid zone or not.  //column names should be destzone or originzone
	FOR ll_index = 1 TO ll_rows
		ls_Zone = ids_rate.getItemString( ll_index, as_columnName )
			
		//make sure the zone is valid-------------------------------------------
		ll_first = 1
		ll_last = ids_zones.rowCount()
		
		//binary search through the target primary and filter buffers for the id
		DO WHILE ll_first <= ll_last
			ll_mid = ((ll_first + ll_last)/2)
	
			ls_searchZone = ids_zones.getItemString( ll_mid, "name" )
			IF ls_searchZone = ls_Zone THEN
				//ll_mid is the insertion point
				//current data is valid
				EXIT
			END IF
				
			IF ls_searchZone > ls_Zone THEN
				ll_last = ll_mid - 1
			ELSE
				ll_first = ll_mid + 1
			END IF
		LOOP
		
		//didn't find it, so we add it to our list of invalid names found
		IF ll_first > ll_last THEN
			lb_AllDataValid = false
			lsa_invalidNames[upperBOund(lsa_invalidNames)+1] = ls_zone
		END IF

	NEXT
END IF

asa_invalidZones = lsa_invalidNames

RETURN lb_allDataValid
end function

public function integer of_verifynewtable (ref boolean ab_codenameexists);/*Dan 5-24-2006  RETURNS 1 if the following conditions are true, -1 otherwise
  also sets the status flag.
		1. Codename must be uniform.		
		2. Billto must be uniform.
		3. Billto must exist.
		4. Categories must be consistant, 
		5. Categories must be billable or payable, must be uniform
		6. Must be flat rate
		7. All zones, orig and dest must exist
		8. Orig Dest combos must be unique.
				Since CodeName, Billto, and Category are uniform , this check is possible. Otherwise the combo of all 5
				must be unique.
*/
Int	li_return
Boolean	lb_return

Boolean  lb_codeNameExists					//this can be true or false, but if its false the calling runciton
													//may want to ask what they want to import.
													
Boolean	lb_UniformCodeNames				//Must be true as we only want to import one table at a time

Boolean	lb_billToIdExists					//Must be true 
Boolean	lb_UniformBillToIds				//Must be true

Boolean	lb_legalCategory					//category numbers must be 1 or 2 currently
Boolean  lb_UniformCategories				//Must be true

Boolean	lb_verifyOrigins						//Must be true

Boolean	lb_verifyDests						//if true then all destinations are valid//
Boolean	lb_UniqueOrigDestCombo		//must be false to be successful

String	lsa_invalidDestNames[]				//list of invalidDestinationNames Found
String	lsa_invalidOriginNames[]
String	lsa_dupeNames[]					//list of duplicate destination names found


Long		ll_Rows
Long		ll_index

Long		ll_errorIndex
Long		ll_errorMax


String	ls_codeName
String	ls_constantCodeName

Long		ll_billId
Long		ll_constantBillId

Int		li_category

String	ls_origin
String	ls_dest

//n_cst_numerical	inv_bitOps
UnsignedInt	li_status

String ls_test

IF isValid( ids_rateCache ) AND isValid(ids_rateLinkBillToId) AND isValid(ids_rateLinkDestZone) &
	AND isValid(ids_rateLinkOrigZone) AND isValid( ids_ratetablenames )  THEN

	//creating a new table doesn't require a retrieval of rate data
	ids_ratelinkbilltoid.retrieve( )				//required to validate bill to ids														//must be updated as well
	commit;
	
	ids_rateTablenames.retrieve( )				//list of names and code table names 
															//this datastore does the update
	commit;
	
	ids_zones.retrieve( )							//required to validate zones
	commit;
									
	

	IF isValid( ids_rate ) THEN
		ll_Rows = ids_rate.RowCount()
	//MessageBox("begin", "begin")
	
		IF ll_Rows > 0 THEN
			ls_constantCodeName = ids_rate.getItemString( 1, "codename" )
			ll_constantBillId = ids_rate.getItemNumber( 1, "billtoid" )
			li_category = ids_rate.getItemNumber( 1, "category" )
			ls_origin = ids_rate.getItemString( 1, "originzone" )
			
			
			//checks to see if the first code name is the correct one
			lb_codeNameExists = this.of_codeNameExists( ls_constantCodeName ) 
			IF lb_codeNameExists THEN
				li_status+= 1			//sets bit 1 to 1
			END IF
			
			//checks consistancy of codeNames
			lb_UniformCodeNames =  ( this.of_consistantcodenames( ) )
			IF lb_uniformCodeNames THEN
				li_status+= 2			//sets bit 2 to 1
			ELSE
				//adderror
				this.of_adderror( "CodeName ERROR: All codenames must be the same." )
			END IF
			
			//check for valid billtoIds and consistancy
			lb_billToIdExists = this.of_billToIdExists( ll_constantBillId )
			IF lb_billToIdExists THEN
				li_status+= 4 			//sets bit 3 to 1
			ELSE
				//adderror
				this.of_adderror( "Company Override ERROR: ID "+string( ll_constantBillId )+ " is not valid.")
			END IF
			
			lb_UniformBillToIds =  ( this.of_consistantbillids( ) )
			IF lb_uniformBillToIds THEN
				li_status+= 8			//sets bit 4 to 1
			ELSE
				//addError
				this.of_addError( "BILL TO ERROR: Company ids must all be the same.")
			END IF
			
			//check for valid category numbers and consistancy
			lb_legalCateGory = this.of_legalCategory( li_category )
			IF lb_legalCategory THEN
				li_status+= 16			//sets bit 5 to 1 
			ELSE
				//adderror
				this.of_addError( "Category ERROR: Categories must be either 1 or 2")
			END IF
			
			//make sure all categories are uniform
			lb_UniformCategories =  ( this.of_consistantCategories( ) )
			IF lb_uniformCateGories  THEN
				li_status+= 32			//sets bit 6 to 1
			ELSE
				//addError
				this.of_addError( "Category Error: All categories must be the same" )
			END IF
			
			//check to make sure the origin is valid, and that all origins are the same
			lb_VerifyOrigins = this.of_verifyzones( "originzone", lsa_invalidOriginNames )      //this.of_VerifyZone( ls_origin )
			IF lb_verifyOrigins THEN
				li_status+= 64			//sets bit 7 to 1
			ELSE
				//addErrors
				ll_errorMax = upperBound(lsa_invalidOriginNames)
				FOR ll_errorIndex = 1 To ll_errormax
					this.of_addERror( "Origin Zone ERROR: "+ lsa_invalidOriginNames[ll_errorIndex]+ " is not a valid zone name." )
				NEXT
			END IF
			
			//make sure all destination zones are valid
			lb_verifyDests = this.of_verifyzones( "destzone", lsa_invalidDestNames )
			IF lb_verifyDests THEN
				li_status+= 128		//sets bit 8 to 1
			ELSE
				//addErrors
				ll_errorMax = upperBound( lsa_invalidDestNames )
				FOR ll_errorIndex = 1 To ll_errormax
					this.of_addERror( "Destination Zone ERROR: "+ lsa_invalidDestNames[ll_errorIndex]+ " is not a valid zone name." )
				NEXT
			END IF
			
			//check for duplicate origin and destination combos within the file
			lb_UniqueOrigDestCombo = this.of_verifyzonecombos( lsa_dupeNames )
			IF lb_uniqueOrigDestCombo THEN
				li_status+= 256		//sets bit 9 to 1
			ELSE
				//addErrors
				ll_errorMax = upperBOund( lsa_dupeNames )
				FOR ll_errorIndex = 1 To ll_errormax
					this.of_addERror( "ERROR: Duplicate - "+ lsa_dupeNames[ll_errorIndex] )
				NEXT
			END IF
			
			//the reason why lb_codenameexists is not checked here is because they might be trying
			//to import only new rates for a table that exists.  If this is true then ab_codenameExists
			//can be checked in the calling function to find out if they want to import only the new rows.
			//They should only ask the question if this function returns true
			lb_return = ( lb_UniformCodeNames AND lb_billToIdExists AND lb_UniformBillToIds &
							AND lb_legalCateGory AND lb_UniformCategories AND lb_verifyOrigins &
							AND lb_verifyDests AND lb_uniqueOrigDestCombo )
			
		END IF
	END IF
		
END IF

IF lb_return THEN
	li_return = 1
ELSE
	li_return = -1
END IF

ab_codeNameExists = lb_codeNameExists

RETURN li_return

end function

public function integer of_verifyfile (integer ai_verifymode, ref boolean ab_codenameexists);//Dan	5-24-2006
Int	li_return

CHOOSE CASE ai_verifyMode
		
	CASE ci_verifyNewTableMode
		li_return = this.of_verifynewtable( ab_codeNameExists )
	CASE ci_verifyUpdateRatesMode
		li_return = this.of_verifyupdaterates()
	
END CHOOSE

RETURN li_return
end function

public function integer of_importrateupdates (integer ai_verifymode);//Dan 5-24-2006
Int	li_return
Int	li_checkMode
Boolean lb_dummy

li_Return = this.of_verifyFILE( ai_verifyMode, lb_dummy )

//returns 1 if it succesfully put in the rates , -1 if error occrured....invalid id in file
RETURN li_RETURN
end function

private function integer of_discardexistingratesfromimport ();//Dan 5-25-2006
/*
		This function will look at every row that is being imported to look
		and see if it already exists in the database.  It will discard all the rows
		that do exist from the import, ids_rate.  This is intended to be used
		for importing only new rows from the file.
			
		THIS SHOULD ONLY BE CALLED AFTER VERIFY
*/

Int	li_Return
Long	ll_importIndex
Long	ll_importMax

Long	ll_cacheIndex
Long	ll_cacheMax

Long		li_category
Long		ll_billTo

String	ls_codeName
String	ls_importOrigZone
String	ls_importDestZone

String	ls_cacheOrigZone
String	ls_cacheDestZone

String	ls_filter


ll_importMax = ids_rate.rowCount()


IF ll_importMax > 0 THEN
	ls_codeName = ids_rate.getItemString( 1, "codename" )
	li_category = ids_rate.getItemNumber( 1, "category" )
	ll_billTo = ids_rate.getItemNumber( 1, "billtoid" )
	
	//i filter it once because i garantee that the imported file has one code name in it.
	//and I also garantee that the import is only for a certain category.
	ids_ratecache.setFilter( "codename = '"+ls_codeName+"' AND category = "+string(li_category) +" AND billtoid = "+ string(ll_billto) )
	ids_rateCache.filter()

	//half the battle is done
	ids_rateCache.rowsDiscard( 1, ids_rateCache.filteredCount(), FILTER!)

	//since the cache is filtered down to the same billto, category, and codename, all I have
	//to look for is duplicate origin destzone combinations in the cache for each row in
	//the imported file.
	
	//at this point most of the stuff I would have had to search through is gone.
	ll_cacheMax = ids_ratecache.rowCount()
	FOR ll_importIndex = ll_importMax TO 1 STEP -1
		ls_importDestZone = ids_rate.getItemString( ll_importIndex, "destzone" )
		ls_importOrigZone = ids_rate.getItemString( ll_importIndex, "originzone" )
		
		ls_filter = "destzone = '"+ls_importDestZone+"' AND originzone = '"+ls_importOrigZone+"'"
		
		ids_ratecache.setFilter( ls_filter )
		ids_rateCache.filter()
		
		IF ids_rateCache.rowCount() > 0 THEN
			//the row exists so discard it from the import cache
			ids_rate.rowsDiscard( ll_importIndex, ll_importIndex, PRIMARY!)
		END IF
		
	NEXT
END IF

RETURN li_return


end function

private function integer of_importnewratetable (boolean ab_newrowsonly, ref string as_message);//Dan 5-25-2006
//This function puts new values in the appropriate caches to create  a new rate table.
/*				
		ab_newRowsONly: This flag should be set to true if the tables code name
							 already exists, and we are looking to add only the new rows
							 to the table. IF its false then we the tables codename should
							 already exist, and we want to import every row that there is to be imported.
							 This also keeps it from looking up all the rows to see if they exist or not
							 in the database, which could be highly processing intensive.
							 
							 

		Caches are  ids_rateCache: 	
						ids_rateTableNames:				
						ids_rateLinkdestzone:
						ids_rateLinkorigzone:
						ids_ratelinkbilltoid:
						
	 Returns 1 if ok
	 			-1 otherwise
*/
Int	li_Return
Long	ll_index
Long	ll_rows
Long	ll_newRow

Long		ll_totalIMported

Long		ll_nextId
Long		ll_billToId

String	ls_tableName
String	ls_zone

String	ls_importType
String	ls_category
String	ls_company

IF ab_newRowsOnly THEN
	//retrieve ids_ratecache so that we can look to see which rows already exist
	ids_rateCache.retrieve()
	commit;
	//discard existing rows from ids_rate that exist in ids_rateCache, this function also
	//discards the rows that don't have to be looked at from ids_ratecache.
	this.of_discardexistingratesfromimport( )
	ls_importType = "Added new rates for table: "
ELSE
	ls_importType = "Created new table: "
END IF

ll_rows = ids_rate.rowCount()

IF ll_rows > 0 THEN
	//find category name for display message
	CHOOSE CASE ids_rate.getitemnumber( 1, "category")	
		CASE 1
			ls_category = "Payable"		//1-24-07 Dan fixed, messages were backwards
		CASE 2
			ls_category = "Billable"
	END CHOOSE
ELSE
	as_message = "0 Rates imported. All of them either have matching entries or the file is empty. To update existing rates, export the rates to be updated from the rating window, modify the rates, and reimport the rates selecting 'Update Rates'."
END IF

li_return = ids_rate.rowsCopy( 1, ll_rows, primary!, ids_rateCache, 1, primary! )
IF li_return = 1 THEN
	FOR ll_index = ll_rows TO 1 STEP -1
		
		//discard any rows with null as a rate value
		IF isNULL(ids_rateCache.getItemNumber( ll_index, "rate")) THEN
			ids_rateCache.rowsdiscard( ll_index, ll_index, primary!)
		ELSE
			ll_totalImported++
			
			ls_tableName = ids_rate.getItemString( ll_index, "codename" )
			ls_zone = ids_rate.getitemString( ll_index, "destzone" )
			ll_billtoid = ids_rate.getItemNumber( ll_index, "billtoid" )
			
			//update "rate" table
			gnv_app.of_getnextId( "rateid", ll_nextId, true)
			ids_rateCache.setitem( ll_index,"id", ll_nextId )
			
			//update "rateTable" table, only inserted one time
			//This only happens if we are inserting all the rows. Otherwise
			//we know the table codename already exists and they are just trying to
			//add more rows to the table.
			IF ll_index = 1  THEN
				IF NOT ab_newRowsOnly THEN
					ll_newRow = ids_rateTablenames.insertRow( 0 )
					ids_rateTableNames.SetItem( ll_newRow, "codename", ls_tableName )
					ids_rateTableNames.SetItem( ll_newRow, "breakunit", "F")
				END IF
				ls_importType += ls_tableName //append table name to message
				
				//get billto company name for message.
				IF ll_billtoId > 0 THEN
					SELECT "co_name"
						INTO :ls_company
						FROM "companies"
					WHERE "companies"."co_id" =:ll_billToId;
					commit;
				ELSE
					ls_company = "Base Table"
				END IF
			END IF
			
			//update "ratelinkdestZone" table
			ll_newRow = ids_ratelinkdestzone.insertRow( 0 )
			ids_rateLinkdestzone.setItem( ll_newRow, "rateid", ll_nextId )
			ids_rateLinkDestZone.setItem( ll_newRow, "zone", ls_zone )
			

			//update "ratelinkorigzone" table
			ls_zone = ids_rate.getitemString( ll_index, "originzone" )
			ll_newRow = ids_ratelinkorigzone.insertRow( 0 )
			ids_rateLinkorigzone.setItem( ll_newRow, "rateid", ll_nextId )
			ids_rateLinkorigZone.setItem( ll_newRow, "zone", ls_zone )
			
			//update "ratelinkBillToid" table
			ll_newRow = ids_rateLinkbilltoid.insertRow( 0 )
			
			ids_rateLinkBillToId.setItem( ll_newRow, "rateid", ll_nextId )
			ids_ratelinkbilltoid.setItem( ll_newRow, "billtoid", ll_billtoid )
	
		END IF
	NEXT
	as_message = ls_importType + "~r~nCategory: "+ls_category + "~r~n"+ls_company+ "~r~nTotal new rates to be saved: "+string( ll_totalIMported )
END IF


RETURN li_return
end function

public function integer of_importnewtableflat (ref string as_message);//Dan 5-24-2006
//returns 1 if succeeds at verifying
//			-1 otherwise
Int	li_return
Int	li_continue

Boolean	lb_companyOverride
Boolean 	lb_codeNameExists



li_return =  this.of_verifyFILE( ci_verifynewtablemode, lb_codeNameExists )
IF li_return = 1 THEN
	//find out if the code name already exists
	
	IF lb_codeNameExists THEN
		li_continue = MessageBox( "Import Rates", "The table code name already exists, do you want to import rates that don't exist for that rate table? ~r~n~r~nTo overwrite rates select 'Update Rates' and click 'verify'.", QUESTION!, yesNO! )
		
		IF li_continue = 1 THEN
			//need to import only the new Rates into the cache.
			//of_importNewRows
			//this has to look and see if there is already a rate for each billto, category, origin, destination, combo for the codename
			//if not than i import it to all the rows regardless of billto or not.
			this.of_importNewRateTable( TRUE, as_message )	//import only the new rows.
		END IF
	ELSE
		//codename doesn't exist and file verified, so import the rates into the cache	
		//of_importNewTableAll
		//Find out if companyOverride
		//this should add rows to all the tables, it doesn't matter if there is a billtoId Or not
		this.of_importnewratetable( FALSE /*ab_newRows only*/, as_message ) //This setting imports all rows
	END IF
	
	
END IF

RETURN li_Return
end function

public function integer of_verifyupdaterates ();/*Dan 5-24-2006
	1. rate ids must exist
	
	This function will only check to see that the two things above exist in the DB.
*/
Int	li_return
Long	ll_importMax
Long	ll_index
Long	ll_importedid
Dec	lc_rate
Long	ll_first
Long	ll_last
Long	ll_mid
Long	ll_cacheId

li_Return = 1
IF isValid( ids_rate ) THEN
	
	ids_rateCache.retrieve( )					//cache to update first for rate ids and other updatable data
	commit;

	ids_rateCache.setSort("Id A")
	ids_rateCache.sort()

	//for all import indexes, I must look for the rate id in the cache, and 
	//when I find it, I must set the rate value to the imported value.
	//If i don't find at one or more, then I must set the error and not
	//allow saving.
		
	ll_importMax = ids_rate.rowCount()
	FOR ll_index = 1 TO ll_importMax
		ll_importedId = ids_rate.getItemNumber( ll_index, "id" )
		lc_rate  = ids_rate.getItemNumber( ll_index, "rate" )
		
		ll_first = 1
		ll_last = ids_rateCache.rowCount()
		
		//binary search through the target primary and filter buffers for the id
		DO WHILE ll_first <= ll_last
			ll_mid = ((ll_first + ll_last)/2)
	
			ll_cacheId = ids_RateCache.getItemNumber( ll_mid, "id" )
			IF ll_cacheId = ll_importedId THEN
				//ll_mid is the insertion point
				//found it, now set it
				ids_RateCache.setItem( ll_mid, "rate", lc_rate )
				EXIT
			END IF
				
			IF ll_cacheId > ll_importedId THEN
				ll_last = ll_mid - 1
			ELSE
				ll_first = ll_mid + 1
			END IF
		LOOP
	
		//didn't find it, so we add it to our list of Invalid Ids, prevent save
		IF ll_first > ll_last THEN
			IF NOT isNULL( ll_importedId ) THEN
				this.of_addError("ID ERROR: The Rate Id "+string( ll_importedId )+ "  does not exist and cannot be updated.")
			ELSE
				this.of_addError("ID ERROR: Null id found.")
			END IF
			li_return = -1			//do not save
		END IF
	NEXT
	
//	IF li_return <> -1 THEN
//		ii_updatemode = ci_ratesOnly
////			MessageBox("Verify","Verification Successful")
//		//li_return = this.of_update( ci_RatesOnly )
//	END IF	
//
END IF
RETURN li_return
end function

public function integer of_updateexistingrates (ref string as_message);/*Dan 5-26-2006
	Verification for updating existing rates is as follows.
	
	The file must match the format of table that was exported from the profit tools rate window.
	The check for this, luckily for me, is the same check as importing a brand new table, except
	the codename must also exist.  
	
	In addition to that verification, all of the id's in the imported file must exist in the database.
*/
Int		li_return
String	ls_importType
String	ls_category
String	ls_company
String	ls_codename
Long		ll_totalImported
Long		ll_billtoID
Boolean	lb_codenameExists

//this check makes sure the file looks like it was exported from profit tools.
li_return  = this.of_verifyfile( ci_verifynewtablemode , lb_codenameExists )

//If the file looks like it was exported from Profit tools and the codename exists then
//i want to check to make sure all the ids in the file exist.  This check is second because
//it is quicker to search through the file once and make the assignments rather than search 
//through to make sure they exist, then search through again to make the update.
IF li_return = 1 AND lb_codenameExists THEN
	li_return =  this.of_verifyFILE( ci_verifyUpdateRatesMode , lb_codeNameExists )
	IF li_return <> 1 THEN
		as_message = "At least one or more rate ids in the file is not valid.  Remove the invalid rows for the corresponding ids from the file and try again."
	ELSE
		//display information about the file for as_message
		ll_totalImported = ids_Rate.rowCOunt()
		
		IF ll_totalImported > 0 THEN		
			CHOOSE CASE ids_rate.getItemNumber( 1, "category" )
				CASE 1
					ls_category = "Payable"
				CASE 2
					ls_category = "Billable"
			END CHOOSE
			
			ll_billtoId = ids_rate.getItemNumber( 1, "billtoid" )
			
			IF ll_billtoId > 0 THEN
				SELECT "co_name"
					INTO :ls_company
					FROM "companies"
				WHERE "companies"."co_id" =:ll_billToId;
				commit;
			ELSE
				ls_company = "Base Table"
			END IF
			
			
			ls_codename = ids_rate.getItemString( 1, "codename" )
			
			ls_importType = "Update existing rates for table: "+ ls_codename
			
			as_message = ls_importType + "~r~nCategory: "+ls_category + "~r~n"+ls_company+ "~r~nTotal new rates to be saved: "+string( ll_totalIMported )
		ELSE
			as_message = "The file had no rates to update."
		END IF
	END IF
ELSE
	//cannot update existing rates.
	as_message = "The imported file does not have a uniform codename, category, and company combination.  Fix errors and try again."
END IF



RETURN li_Return
end function

public function integer of_update ();/***************************************************************************************
NAME: 		of_update	

ACCESS:			
		public
ARGUMENTS: 		
							ai_type:		if the type is one of the valid types, then it updates the appropriate
											tables in the database.

RETURNS:			1 if all updates are successful, -1 otherwise.
	
DESCRIPTION: if the type is one of the valid types, then it updates the appropriate
											tables in the database.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 12-23-2005
	

***************************************************************************************/

int	li_return


li_return = ids_ratetablenames.update( )

IF li_return = 1 THEN
	li_return = ids_ratecache.update()
END IF

IF li_return = 1 THEN
	li_return = ids_ratelinkbilltoid.update()
END IF

IF li_return = 1 THEN
	li_return = ids_ratelinkdestzone.update()
END IF


IF li_return = 1 THEN
	li_return = ids_ratelinkorigzone.update()
END IF

IF li_return = 1 THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF

return li_return
end function

on n_cst_importrating.create
call super::create
end on

on n_cst_importrating.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_rate = create Datastore						//this is the datastore being imported to
ids_rate.dataObject = "d_rate_ds"

ids_ratelinkbilltoid = create Datastore
ids_ratelinkbilltoid.dataobject = "d_ratelinkbillable"
ids_ratelinkbilltoid.setTransObject( SQLCA )

ids_ratelinkdestzone = create Datastore
ids_ratelinkdestzone.dataObject = "d_ratelinkdestzone"
ids_ratelinkdestzone.setTransObject( SQLCA )

ids_ratelinkorigzone = create Datastore
ids_ratelinkorigzone.dataObject = "d_ratelinkorigzone"
ids_ratelinkorigzone.setTransObject( SQLCA )

ids_rateCache = create Datastore
ids_rateCache.dataobject = "d_rate_ds"
ids_rateCache.setTransObject( SQLCA )

ids_ratetablenames = create Datastore
ids_rateTableNames.dataobject = "d_ratetablenames"
ids_rateTableNames.setTransobject( SQLCA )

ids_zones = create Datastore
ids_zones.dataObject = "d_zone"
ids_zones.setTransObject( SQLCA )




end event

event destructor;call super::destructor;IF isValid( ids_rate ) THEN
	Destroy ids_rate 
END IF

IF isValid(ids_ratelinkbilltoid  ) THEN
	Destroy ids_ratelinkbilltoid 
END IF

IF isValid( ids_ratelinkdestzone ) THEN	
	Destroy ids_ratelinkdestzone 
END IF

IF isValid(ids_ratelinkorigzone ) THEN
	Destroy ids_ratelinkorigzone
END IF

IF isValid(ids_rateTableNames ) THEN
	Destroy ids_rateTableNames
END IF

IF isValid(ids_rateCache) THEN
	DESTROY ids_rateCache
END IF

IF isValid(ids_zones) THEN
	Destroy ids_zones 
END IF



end event

