$PBExportHeader$n_cst_cachemanager.sru
$PBExportComments$CacheManager (Non-persistent Class from PBL map PTApp) //@(*)[47591494|249]
forward
global type n_cst_cachemanager from n_cst_base
end type
end forward

shared variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
n_cst_cachemanager sn_n_cst_cachemanager_a[] //@(*)[47591494|249:n]<nosync>
Integer sn_n_cst_cachemanager_c //@(*)[47591494|249:c]<nosync>
//@(text)--

//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

global type n_cst_cachemanager from n_cst_base
event type integer pt_updatespending ( )
event type integer pt_save ( )
event type integer pt_reset ( )
end type
global n_cst_cachemanager n_cst_cachemanager

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private Boolean ib_autocache //@(*)[47698622|250]
private n_cst_collection in_cachelist[] //@(*)[50001429|253]
private n_cst_bso in_context //@(*)[143469908|273]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
public function Integer of_register (n_cst_collection an_collection)
public function Integer of_getcache (string as_dlk, ref n_cst_bcm an_bcm)
public function Boolean of_GetAutocache ()
public function Integer of_SetAutocache (Boolean ab_autocache)
protected function Integer of_GetCachelist (ref n_cst_collection an_cachelist[])
protected function Integer of_SetCachelist (ref n_cst_collection an_cachelist[])
public function Integer of_getbcmlist (ref n_cst_bcm an_bcmlist[])
public function n_cst_bso of_GetContext ()
public function Integer of_SetContext (n_cst_bso an_context)
public function Integer of_getcache (string as_dlk, ref n_cst_bcm an_bcm, boolean ab_createnew)
public function integer of_getcache (string as_dlk, ref n_cst_bcm an_bcm, boolean ab_createnew, boolean ab_retrievenew)
public function Boolean of_hascache (string as_dlk)
public function Integer of_cache (string as_dlk)
public function n_cst_bcm of_cache (ref n_cst_bcm anv_source, boolean ab_destroysource)
end prototypes

event pt_updatespending;//Indicates whether there are any updates pending for the cache list

//Returns :	 1 = Yes (Updates Pending)
//				 0 = No (No Updates Pending)
//				-1 = Error (Not implemented)

Integer	li_BcmCount, &
			li_Index
n_cst_Bcm	lnva_BcmList [ ]

Integer	li_Return = 0


//Get the BCMList

li_BcmCount = of_GetBcmList ( lnva_BcmList )


//Check if any of the bcm's have updates pending

FOR li_Index = 1 TO li_BcmCount

	IF lnva_BcmList [ li_Index ].UpdatesPending ( ) > 0 THEN

		li_Return = 1
		EXIT

	END IF

NEXT

RETURN li_Return
end event

event type integer pt_save();//Saves any changes in the cache list

//Returns :	 1 = Success (Changes -- if there were any -- are saved)
//				-1 = Failure


Integer	li_BcmCount, &
			li_Index
n_cst_Bcm	lnva_BcmList [ ]
n_cst_TxMgr	lnv_Txm

Integer	li_Return = 1


//Get the BCMList

li_BcmCount = This.of_GetBcmList ( lnva_BcmList )


IF li_BcmCount > 0 THEN

	lnv_Txm = CREATE n_cst_TxMgr

	FOR li_Index = 1 TO li_BcmCount
	
		IF lnv_Txm.Register ( lnva_BcmList [ li_Index ] ) <> 1 THEN
	
			li_Return = -1
			EXIT
	
		END IF
	
	NEXT

	IF li_Return = 1 THEN

		IF lnv_Txm.Save ( ) <> 1 THEN
			li_Return = -1
			THIS.Propagateerrors( lnv_Txm )
		END IF

	END IF

	DESTROY lnv_Txm

END IF


RETURN li_Return
end event

event pt_reset;//Resets (clears) any data (bcm's) under the cachemanager's management

//Returns :	 1 = Success (Data -- if there was any -- has been cleared)
//				 0 = No action taken  (not currently implemented)
//				-1 = Failure


Integer	li_BcmCount, &
			li_Index
n_cst_Bcm	lnva_BcmList [ ]

Integer	li_Return = 1


//Get the BCMList

li_BcmCount = of_GetBcmList ( lnva_BcmList )


//Reset all the BCM's in the list

FOR li_Index = 1 TO li_BcmCount

	IF lnva_BcmList [ li_Index ].Reset ( ) = -1 THEN

		li_Return = -1
		//EXIT ?? Keep on going

	END IF

NEXT

RETURN li_Return
end event

public function Integer of_register (n_cst_collection an_collection);//@(*)[50565721|254]//@(-)Do not edit, move or copy this line//

//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: 1 = Success (Collection is registered), -1 = Failure (Collection is not registered)

n_cst_Collection	lnva_CacheList[]
n_cst_Bcm	lnv_Bcm
Integer	li_CacheCount, &
			li_Index

IF IsValid ( an_Collection ) THEN

	li_CacheCount = of_GetCacheList ( lnva_CacheList )


	//Verify whether this collection is already registered

	FOR li_Index = 1 TO li_CacheCount
		IF lnva_CacheList [ li_Index ] = an_Collection THEN
			RETURN 1
		END IF
	NEXT


	//If the collection is a BCM, verify whether a BCM of that type is already registered

	IF an_Collection.IsBcm ( ) = TRUE THEN

		lnv_Bcm = an_Collection
		IF of_GetCache ( lnv_Bcm.GetDlkName ( ), lnv_Bcm ) = 1 THEN
			RETURN -1
		END IF

	END IF


	//Add the collection to the CacheList

	an_Collection.SetContext ( This.of_GetContext ( ) )

	li_CacheCount ++
	lnva_CacheList [ li_CacheCount ] = an_Collection
	of_SetCacheList ( lnva_CacheList )

	RETURN 1

ELSE

	RETURN -1

END IF
end function

public function Integer of_getcache (string as_dlk, ref n_cst_bcm an_bcm);//@(*)[52834735|262]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

Constant Boolean	lb_CreateNew = FALSE
Constant Boolean	lb_RetrieveNew = FALSE

RETURN of_GetCache ( as_Dlk, an_Bcm, lb_CreateNew, lb_RetrieveNew )
end function

public function Boolean of_GetAutocache ();//@(*)[47698622|250:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return ib_autocache
//@(text)--

end function

public function Integer of_SetAutocache (Boolean ab_autocache);//@(*)[47698622|250:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

ib_autocache = ab_autocache
return 1
//@(text)--

end function

protected function Integer of_GetCachelist (ref n_cst_collection an_cachelist[]);//@(*)[50001429|253:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>

//@(text)--

n_cst_Collection	lnva_CacheList[]
Integer	li_CacheCount, &
			li_ValidCount, &
			li_Index

li_CacheCount = UpperBound ( in_CacheList )

FOR li_Index = 1 TO li_CacheCount

	IF IsValid ( in_CacheList [ li_Index ] ) THEN

		li_ValidCount ++
		lnva_CacheList [ li_ValidCount ] = in_CacheList [ li_Index ]

	END IF

NEXT

an_CacheList = lnva_CacheList
RETURN li_ValidCount
end function

protected function Integer of_SetCachelist (ref n_cst_collection an_cachelist[]);//@(*)[50001429|253:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_cachelist = an_cachelist
return 1
//@(text)--

end function

public function Integer of_getbcmlist (ref n_cst_bcm an_bcmlist[]);//@(*)[53469123|266]//@(-)Do not edit, move or copy this line//

//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_Collection	lnva_CacheList[]
n_cst_Bcm	lnva_BcmList[]
Integer	li_CacheCount, &
			li_BcmCount, &
			li_Index

li_CacheCount = of_GetCacheList ( lnva_CacheList )

FOR li_Index = 1 TO li_CacheCount

	IF lnva_CacheList [ li_Index ].IsBcm ( ) = TRUE THEN

		li_BcmCount ++
		lnva_BcmList [ li_BcmCount ] = lnva_CacheList [ li_Index ]

	END IF

NEXT

an_BcmList = lnva_BcmList
RETURN li_BcmCount
end function

public function n_cst_bso of_GetContext ();//@(*)[143469908|273:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_context
//@(text)--

end function

public function Integer of_SetContext (n_cst_bso an_context);//@(*)[143469908|273:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_context = an_context
return 1
//@(text)--

end function

public function Integer of_getcache (string as_dlk, ref n_cst_bcm an_bcm, boolean ab_createnew);//@(*)[88800776|644]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

Constant Boolean	lb_RetrieveNew = FALSE

RETURN of_GetCache ( as_Dlk, an_Bcm, ab_CreateNew, lb_RetrieveNew )
end function

public function integer of_getcache (string as_dlk, ref n_cst_bcm an_bcm, boolean ab_createnew, boolean ab_retrievenew);//@(*)[89300004|649]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns : 1 = Success (Match Found), 0 = No Match, -1 = Error

//**Note** : as_Dlk should be of the form n_cst_dlkc_xxx, NOT d_dlkc_xxx.
//Entries of the second type will cause registration problems (they retrieve
//but do not set dlkname instance variable, which causes lookup to not match.)

//**NOTE** : If you call create, no retrieve you need to do an add class.


Integer	li_BcmCount, &
			li_Index, &
			li_Return
n_cst_Bcm	lnva_BcmList [ ], &
				lnv_Match

n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query

n_cst_String	lnv_String
String			ls_ClassDlkPrefix, &
					ls_BeoPrefix


//Get the BCMList, and try to find an existing match.

li_BcmCount = of_GetBcmList ( lnva_BcmList )

FOR li_Index = 1 TO li_BcmCount

	IF Lower ( lnva_BcmList [ li_Index ].GetDlkName ( ) ) = Lower ( as_Dlk ) THEN

		lnv_Match = lnva_BcmList [ li_Index ]
		li_Return = 1

	END IF

NEXT


//If an existing match was not found, see if we should create a new one.

IF li_Return = 0 THEN

	IF ab_CreateNew THEN

		IF ab_RetrieveNew THEN

			lnv_database = gnv_bcmmgr.GetDatabase()
			If IsValid(lnv_database) Then
				lnv_query = lnv_database.GetQuery()
				//Assume there are no parameters needed.
				lnv_query.cleararguments( )  // and clear any that may be there... and most likely are.
				// When asking for a Query, the DB returns the same instance. It does not create a new, fresh, 
				// clean Query for each 'GetQuery()' request. This instance returned still will have any 
				// previously set arguments on it. Therfore on subsequent retrievals within one processing 
				// sequence, the args will still be there and need to be cleared.
				// At the end of the ExecuteQuery call chain Riverton seems to clear the args. Therefore it is only a problem 
				// when executing multiple Queries in one call chain. 
				
				
				lnv_Bcm = lnv_query.ExecuteQuery(as_Dlk,"","")
			End If

		ELSE
			lnv_Bcm = gnv_BcmMgr.CreateBCM ( )

			IF IsValid ( lnv_Bcm ) THEN
				lnv_Bcm.SetTransObject ( SQLCA )
				//This SQLCA reference should probably not be hardwired, but I'm not sure where
				//to get the value from in riverton.
				lnv_Bcm.SetDlk ( as_Dlk )

				ls_ClassDlkPrefix = gnv_BcmMgr.GetClassDlkPrefix ( )
				ls_BeoPrefix = gnv_BcmMgr.GetBeoPrefix ( )

				IF Pos ( as_Dlk, ls_ClassDlkPrefix ) = 1 THEN
					lnv_Bcm.AddClass ( lnv_String.of_GlobalReplace ( as_Dlk, ls_ClassDlkPrefix, ls_BeoPrefix ) )
				END IF

			END IF

		END IF


		//Attempt to register the new bcm  (if it's not valid, it will fail)

		IF of_Register ( lnv_Bcm ) = 1 THEN

			lnv_Match = lnv_Bcm
			li_Return = 1

		ELSE
			li_Return = -1

		END IF

	ELSEIF ab_RetrieveNew THEN

		//CreateNew = FALSE, RetrieveNew = TRUE is contradictory
		li_Return = -1

	END IF

END IF


//Set the reference parameter and return.

an_Bcm = lnv_Match
RETURN li_Return
end function

public function Boolean of_hascache (string as_dlk);//@(*)[71988060|998]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

//Returns:  TRUE if requested dlk is cached, FALSE if not, NULL if error occurs
//THIS DOES NOT FORCE RETRIEVAL OF THE REQUESTED DLK.

Boolean		lb_HasCache
n_cst_bcm	lnv_Bcm

CHOOSE CASE This.of_GetCache ( as_Dlk, lnv_Bcm )

CASE 1
	lb_HasCache = TRUE

CASE 0
	lb_HasCache = FALSE

CASE ELSE //-1
	SetNull ( lb_HasCache )

END CHOOSE

RETURN lb_HasCache
end function

public function Integer of_cache (string as_dlk);//@(*)[71988115|999]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

//Returns: 1, -1

Integer		li_Return
n_cst_Bcm	lnv_Bcm

IF This.of_GetCache ( as_Dlk, lnv_Bcm, TRUE, TRUE ) = 1 THEN
	li_Return = 1

ELSE
	li_Return = -1

END IF

RETURN li_Return
end function

public function n_cst_bcm of_cache (ref n_cst_bcm anv_source, boolean ab_destroysource);//@(*)[61980778|1590]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


n_cst_Bcm	lnv_Cache, &
				lnv_Return

Integer		li_Return = 1

IF NOT IsValid ( anv_Source ) THEN
	//Source is not valid.  Fail.
	li_Return = -1

ELSEIF This.of_GetCache ( anv_Source.GetDlkName ( ), lnv_Cache ) = 1 THEN

	IF lnv_Cache.Append ( anv_Source ) = 1 THEN
		//Append successful
	ELSE
		//***Forward explanation of error***
		li_Return = -1
	END IF

ELSE

	IF This.of_GetAutoCache ( ) = TRUE THEN

		IF This.of_Register ( anv_Source ) = 1 THEN
			lnv_Cache = anv_Source
		ELSE
			//Registration of source as a cache failed
			li_Return = -1
		END IF

	ELSE
		//Not allowed to register source as a cache
		li_Return = -1

	END IF

END IF	


//Destroy the source, if requested, and it makes sense to.

IF ab_DestroySource THEN

	IF lnv_Cache = anv_Source THEN
		//Don't destroy the source -- it's now the cache
	ELSE
		GetBcmMgr ( ).DestroyBcm ( anv_Source )
	END IF

END IF


//If caching was successful, pass the cache out as the return value

IF li_Return = 1 THEN
	lnv_Return = lnv_Cache
END IF


RETURN lnv_Return
end function

on n_cst_cachemanager.create
call super::create
end on

on n_cst_cachemanager.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(text)(recreate=yes)<init>

//@(text)--

end event

