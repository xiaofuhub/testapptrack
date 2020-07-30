$PBExportHeader$n_cst_import_companies.sru
forward
global type n_cst_import_companies from n_cst_bso_import
end type
end forward

global type n_cst_import_companies from n_cst_bso_import
end type
global n_cst_import_companies n_cst_import_companies

type variables
//Private:
DataStore	ids_DisplayList
DataStore	ids_UpdateSource
n_cst_trip		inv_trip
n_cst_routing	inv_routing
end variables

forward prototypes
public function integer of_importcompanyfile (string as_filename)
protected function integer of_generatecrossrefs (ref datastore ads_source, ref long ala_badrows[])
private function integer of_createrequiredcolslist (ref string asa_cols[])
private function integer of_createupdateresult (ref datastore ads_source, long ala_badrows[])
protected function integer of_validaterequiredcolumns (datastore ads_source, string asa_requiredcols[], ref string as_errormessage)
protected function integer of_createlocators (ref datastore ads_source)
private function integer of_createstats (readonly datastore ads_source, ref n_cst_msg anv_msg)
public function integer of_importcompanyfile ()
private function integer of_verifyuniquecodenames (ref datastore ads_source, ref string asa_conames[])
protected function long of_removeredundantaccountingids (ref datastore ads_source, ref string asa_dups[])
protected function integer of_defaultbillingattn (ref datastore ads_source)
public function dataStore of_getdisplaydata ()
public function integer of_updatetable ()
private function integer of_settimezone (ref datastore ads_source)
public function boolean of_haspcmiler ()
public function integer of_updatecompanylocators ()
private function integer of_importindiagnosticmode (string as_filename, datastore ads_datastore)
private function integer of_createandimport (string as_dataobject, ref string as_filename, ref datastore ads_datastore)
end prototypes

public function integer of_importcompanyfile (string as_filename);Boolean		lb_Error = FALSE
Boolean		lb_UserCanceled = FALSE
Long			ll_ImportRowCount
Long			ll_Skipped
Long			lla_BadRows[]
Long			ll_BadRowsCount
Long			ll_CosAdded
Long			ll_AddedIDs[]
Int			li_updateRtn
Int			li_Return = 1
Int			i
String		lsa_RequiredCols[]
String		ls_ErrorMessage
String		lsa_BadCos[] // used for cos w/ duplicate code names
String		lsa_CoWithDupIds[]
String		ls_BaseMessage


S_Parm		lstr_Parm
n_cst_msg	lnv_msg
DataStore 	lds_CoImport
n_cst_privileges	lnv_Privs

ls_BaseMessage = "An error occurred while attempting to import the company file.~r~n"

IF Not lnv_Privs.of_HasSysAdminRights ( ) THEN
	MessageBox( "Import Company File" , "You are not authorized to perform this function." )
	li_Return = -1
END IF

IF li_Return = 1 THEN
	
	IF Not lb_Error THEN  // attempt to import the company file
		ll_ImportRowCount = this.of_CreateAndImport ( "d_company_info", as_filename ,lds_CoImport  )
	
		CHOOSE CASE ll_ImportRowCount
				
			CASE 0 
				lb_UserCanceled = TRUE
				lb_Error = TRUE
				
			CASE is < 0 
				lb_Error = TRUE
				
			CASE ELSE
				// success			
		END CHOOSE
	
	END IF

	IF lb_Error AND NOT lb_UserCanceled THEN
		
		// ask if they want to run in diagnostic mode
		li_Return = -1
		IF MessageBox ( "Import Company File" , "The specified file contains errors. Do you want to import the file in diagnostic mode? This process will indicate the rows that contain errors." , QUESTION! , YESNO!, 1 ) = 1 THEN
			THIS.of_ImportInDiagnosticMode ( as_filename ,lds_CoImport  )
		END IF
		
	END IF
	
END IF

IF li_Return = 1 THEN
	
	SetPointer ( HourGlass! )
	IF gnv_cst_companies.of_CacheAll ( ) <> 1 THEN
		lb_Error = TRUE
	END IF
	
	//used for pcmiler locator and tz	
	inv_trip = create n_cst_trip
	
	
	IF Not lb_Error THEN	 // validate required columns
	
		CHOOSE CASE THIS.of_VerifyUniqueCodeNames ( lds_CoImport, lsa_BadCos  ) 
			CASE 1
				// SUCCESS
			CASE 0 
				lb_UserCanceled = TRUE
				lb_Error = TRUE
			CASE -1
				lb_Error = TRUE
		END CHOOSE
	
	END IF	
	
// the use of lb_error in this script is to indicate that an internal error occurred

	IF Not lb_Error THEN	 // validate required columns
		THIS.of_CreateRequiredColsList ( lsa_RequiredCols )
		IF THIS.of_validateRequiredColumns ( lds_CoImport , lsa_RequiredCols, ls_ErrorMessage ) <> 1 THEN
			lb_Error = TRUE
		END IF
	END IF	
	
	IF Not lb_Error THEN	
		ll_Skipped = THIS.of_RemoveRedundantAccountingIDS ( lds_CoImport, lsa_CoWithDupIds ) 
		IF ll_Skipped = -1 THEN
			ls_ErrorMessage = "Process was: attempting to remove redundant accounting id."
			lb_Error = TRUE
		END IF
	END IF
	
	IF Not lb_Error THEN  // create the Xon1 and Xon2 fields
		ll_BadRowsCount = THIS.of_GenerateCrossRefs ( lds_CoImport , lla_BadRows )
		ls_ErrorMessage = "Process was: attempting to generate company cross refs."
		IF ll_BadRowsCount = -1 THEN 
			lb_Error = TRUE
		END IF
	END IF
			
			
	IF THIS.of_HasPCMiler ( ) THEN		
		
		IF Not lb_Error THEN
			IF THIS.of_CreateLocators ( lds_CoImport ) = -1 THEN
				ls_ErrorMessage = "Process was: attempting to create locators."
				lb_Error = TRUE
			END IF
		END IF
		
		IF Not lb_Error THEN
			IF THIS.of_SetTimeZone ( lds_CoImport ) = -1 THEN
				ls_ErrorMessage = "Process was: attempting to set the time zone."
				lb_Error = TRUE
			END IF
		END IF
		
	END IF
	
	IF Not lb_Error THEN
		IF THIS.of_DefaultBillingAttn	( lds_CoImport ) = -1 THEN
			ls_ErrorMessage = "Process was: attempting to set the default billing attention text."
			lb_Error = TRUE
		END IF
	END IF
	
	IF Not lb_Error THEN
		IF THIS.of_CreateUpdateResult	( lds_CoImport , lla_BadRows ) = -1 THEN
			ls_ErrorMessage = "Process was: attempting to create the update result."
			lb_Error = TRUE
		END IF
	END IF
			
	IF NOT lb_UserCanceled  THEN	
		IF lb_Error  THEN
			li_Return = -1
			MessageBox ("Company Import" , ls_BaseMessage + ls_ErrorMessage )			
		ELSE
		
			IF THIS.of_CreateStats ( lds_CoImport , lnv_Msg ) = 1 THEN
			
				ids_UpdateSource = lds_CoImport
			
				lstr_Parm.is_Label = "INITIAL"
				lstr_Parm.ia_Value = ll_ImportRowCount
				lnv_Msg.of_Add_Parm ( lstr_Parm )
			
				lstr_Parm.is_Label = "DUPS"
				lstr_Parm.ia_Value = lsa_CoWithDupIds
				lnv_Msg.of_Add_Parm ( lstr_Parm )
				
				lstr_Parm.is_Label = "NONUNIQUE"
				lstr_Parm.ia_Value = lsa_BadCos
				lnv_Msg.of_Add_Parm ( lstr_Parm )
				
				lstr_Parm.is_Label = "OBJECT"
				lstr_Parm.ia_Value = THIS
				lnv_Msg.of_Add_Parm ( lstr_Parm )
				
				openWithParm ( w_Company_Import_Result , lnv_msg )
				
			END IF
		END IF
	END IF
	
	if isvalid(inv_trip) then
		destroy inv_trip
	end if
	//DESTROY lds_CoImport
END IF

RETURN li_Return
		
end function

protected function integer of_generatecrossrefs (ref datastore ads_source, ref long ala_badrows[]);// 0 = success since this function returns the number of 'bad' rows
// -1 on error MID CODE

Long		i
Long		ll_RowCount
String	ls_CoName
String	ls_Xon1
String	ls_Xon2
Long		lla_BadRows []


//////////
IF NOT isValid ( ads_Source ) THEN RETURN -1
/////////

SetPointer ( HourGlass! )
ll_RowCount = ads_Source.RowCount ( )

For i = ll_RowCount TO 1 STEP -1
	
	ls_CoName = Upper ( ads_Source.object.co_Name [i] )

	IF Len ( ls_CoName ) > 0 THEN
		
		IF gf_coname_index ( ls_CoName , ls_Xon1 , ls_Xon2 ) > 0 THEN  // check this
			ads_Source.object.co_xon_1[i] = ls_Xon1
			ads_Source.object.co_xon_2[i] = ls_Xon2
		ELSE
			lla_BadRows [ UpperBound ( lla_BadRows ) + 1 ] = i
		END IF
		
	ELSE
		lla_BadRows [ UpperBound ( lla_BadRows ) + 1 ] = i		
	END IF
	
NEXT
ala_BadRows = lla_BadRows

RETURN upperBound ( lla_BadRows )
end function

private function integer of_createrequiredcolslist (ref string asa_cols[]);
asa_Cols = { "co_name"  }

Return 1
end function

private function integer of_createupdateresult (ref datastore ads_source, long ala_badrows[]);
Long	ll_CoId
Long	i
String	ls_Name
String	ls_State
String	ls_City
String	ls_Pcm
String	ls_AcctID
Long		ll_NewRow


IF IsValid ( ids_DisplayList ) THEN
	Destroy ( ids_DisplayList )
END IF

ids_DisplayList = CREATE DataStore
ids_DisplayList.dataobject = "d_companyrick"



//////////
IF Not IsValid ( ads_source ) THEN Return -1
//////////

select max(co_id) into :ll_COID from companies ;
commit;
SetPointer ( HourGlass! )		
FOR i = 1 TO ads_Source.RowCount ()
	
	ll_CoId ++
	ads_Source.object.co_id[i] = ll_CoId
	
	ls_Name = ads_Source.object.co_Name[i]
	ls_City = ads_Source.object.co_City[i]
	ls_State = ads_Source.object.co_State[i]
	ls_Pcm = ads_Source.object.co_pcm[i]
	ls_acctID= ads_Source.object.co_Bill_acctcode[i]
	
	ll_newRow = ids_DisplayList.InsertRow ( 0 )
	
	ids_DisplayList.object.co_name[ll_newRow] = ls_name
	ids_DisplayList.object.co_city[ll_newRow] = ls_City
	ids_DisplayList.object.co_State[ll_newRow] = ls_State
	ids_DisplayList.object.co_id[ll_newRow] = ll_CoId
	ids_DisplayList.object.co_Pcm[ll_newRow] = ls_Pcm
	ids_DisplayList.object.co_Bill_acctcode[ll_newRow] = ls_acctID
	
NEXT 

RETURN 1
end function

protected function integer of_validaterequiredcolumns (datastore ads_source, string asa_requiredcols[], ref string as_errormessage);
long	i 
long	ll_RequiredCount
Int		li_Return = 1

String	ls_CurrentColumn
String	ls_ErrorMessage
String	ls_Type
Any		laa_ColInfo[]
Any		laa_EmptyArray[]
Boolean	lb_Error = FALSE


SetPointer ( HourGlass! )
//////////
IF Not Isvalid ( ads_Source ) THEN Return -1
//////////
ls_ErrorMessage = "The import can not continue. Required fields are missing.~r~n"

ll_RequiredCount = UpperBound ( asa_RequiredCols[] )

FOR i = 1 TO ll_RequiredCount 

	ls_CurrentColumn = asa_RequiredCols[i]
	ls_Type = ads_Source.Describe(  ls_CurrentColumn +".ColType")
	//MessageBox( ls_Type , "Valid" )

	IF ls_Type <> "!" THEN
		IF ads_Source.Find (   "isnull( "+ls_CurrentColumn +") or  len ( String ( " + ls_CurrentColumn  + ") ) = 0 " , 1, ads_Source.RowCount ( ) ) > 0 THEN
			ls_ErrorMessage += ls_CurrentColumn+ "~r~n"
			lb_Error = TRUE
		END IF
	ELSE
		ls_ErrorMessage += ls_CurrentColumn+ "~r~n"
		lb_Error = TRUE
	END IF
	
NEXT

IF lb_Error THEN
	as_ErrorMessage = ls_ErrorMessage
	li_Return = -1
END IF

RETURN li_Return
	

end function

protected function integer of_createlocators (ref datastore ads_source);String	ls_City
String	ls_State
String	ls_Zip
String	ls_Locator, &
			ls_locatorcity
string	ls_street
Long		i, &
			ll_pos
Long		ll_RowCount

w_updateprogress	lw_progress

///////
IF Not IsValid ( ads_Source ) THEN RETURN -1
//////
if inv_trip.of_connect(inv_routing) then
	if inv_routing.of_isvalid() then
		//CONTINUE
	else
		//no pcmiler connection
		return -1
	end if
end if

open ( lw_progress )

ll_RowCount = ads_Source.RowCount ()

FOR i = 1 TO ll_RowCount
	SetPointer ( HourGlass! )
	SetNull ( ls_City )
	SetNull ( ls_State )
	SetNull (ls_Zip )
	
	ls_City = trim(ads_Source.object.co_City[i])
	ls_State = trim(ads_Source.object.co_State[i])
	ls_Zip = trim(ads_Source.object.co_Zip[i])

	if	inv_routing.of_isstreets () then
		ls_street = trim(ads_source.object.co_addr1[i])
		ls_Locator = inv_routing.of_makelocator(ls_city, ls_state, ls_zip, ls_street )
	else
		ls_Locator = inv_routing.of_makelocator(ls_city, ls_state, ls_zip)
	end if
	
	IF Not isNull ( ls_Locator ) THEN
		if	inv_routing.of_isstreets () then
			ads_Source.object.co_pcm[i] = ls_Locator
		else
			//city can't be longer than 15 because of the size of the co_pcm column(25)
			ls_locatorcity = inv_routing.of_getpartoflocater(ls_Locator,'CITY',TRUE)
			ll_pos = pos(upper(ls_Locator),ls_locatorcity,1)
			if ll_pos > 0 then
				ls_locator = replace(ls_Locator,ll_pos,len(ls_locatorcity),left(ls_locatorcity,15))
				ads_Source.object.co_pcm[i] = ls_Locator
			end if
		end if
	END IF

	lw_progress.wf_setstatus(string(i) + " of " + string(ll_rowcount) + " processed")
NEXT 

close ( lw_progress )

RETURN 1

end function

private function integer of_createstats (readonly datastore ads_source, ref n_cst_msg anv_msg);Long			lla_NoLocators[]
Long			ll_AddedIDs[]
Long			i

Long			lla_NoAcctID[]
S_Parm		lstr_parm

IF Not isValid  ( ads_Source ) THEN RETURN -1

SetPointer ( HourGlass! )
For i = 1 TO ads_Source.RowCount ( )
	ll_AddedIDs[i] = ads_Source.object.co_id [i]	
NEXT
lstr_Parm.is_Label = "TOTAL"
lstr_Parm.ia_Value = ll_AddedIDs
anv_msg.of_Add_Parm ( lstr_Parm )


For i = 1 TO ads_Source.RowCount ( )
	IF ISNull ( ads_Source.object.co_pcm [i] ) OR Len ( String (ads_Source.object.co_pcm [i]) ) = 0 THEN
		lla_NoLocators[ UpperBound ( lla_NoLocators ) + 1 ] = ads_Source.object.co_id [i]
	END IF
NEXT
lstr_Parm.is_Label = "MISSING"
lstr_Parm.ia_Value = lla_NoLocators
anv_msg.of_Add_Parm ( lstr_Parm )



For i = 1 TO ads_Source.RowCount ( )
	IF ISNull ( ads_Source.object.co_Bill_acctcode [i] ) OR Len ( String (ads_Source.object.co_Bill_acctcode [i]) ) = 0 THEN
		lla_NoAcctID[ UpperBound ( lla_NoAcctID ) + 1 ] = ads_Source.object.co_id [i]
	END IF
NEXT
lstr_Parm.is_Label = "NOIDS"
lstr_Parm.ia_Value = lla_NoAcctID
anv_msg.of_Add_Parm ( lstr_Parm )


RETURN 1

end function

public function integer of_importcompanyfile ();String	ls_Null
SetNull ( ls_null )
RETURN THIS.of_ImportCompanyFile ( ls_Null )
end function

private function integer of_verifyuniquecodenames (ref datastore ads_source, ref string asa_conames[]);Long		i
String	ls_CodeName
Long		ll_ID
Int		li_MboxRtn
Int		li_Return = 1
String	ls_CoName
String	ls_Bad
String	lsa_CoNames[]

SetPointer ( HourGlass! )
For i = ads_Source.rowCount ( )  To 1 STEP -1
	ll_ID = 0
	
	ls_CodeName = ads_Source.object.co_Code_name[i]
	ls_CoName = ads_Source.object.co_name[i]
	
	IF NOT isNull ( ls_CodeName ) THEN
	
		SELECT co_id INTO :ll_ID FROM companies WHERE co_code_name = :ls_CodeName AND co_status = 'K';
		Commit;
		IF ll_ID > 0 THEN
			lsa_Conames [ UpperBound ( lsa_CoNames ) + 1 ] = ls_CoName
			ls_Bad += ls_CoName + "~r~n"
			ads_Source.DeleteRow ( i )
		END IF
		
	END IF
	
NEXT

//IF Len ( ls_Bad ) > 0 THEN
//	li_MboxRtn = MessageBox ( "Company Import" , "The import file contained company code names already in use." & 
//					+" This is not allowed. You can click OK to continue the import and not import the companies" &
//					+" with the duplicate code names or you can cancel the import.~r~n" +ls_Bad , Exclamation! ,OKCANCEL!, 2 )
//	CHOOSE CASE li_MboxRtn 
//		CASE 1 // continue
//			li_Return = 1
//		CASE 2 // cancel
//			li_Return = 0
//		CASE ELSE
//			li_Return = -1
//	END CHOOSE
//	
//END IF

asa_CoNames = lsa_Conames

RETURN li_Return
end function

protected function long of_removeredundantaccountingids (ref datastore ads_source, ref string asa_dups[]);Long		i
Long		ll_RowCount
String	ls_AcctID
Int		li_CopyRtn
Long		ll_Skipped
String	lsa_Cos[]

ll_RowCount = ads_source.RowCount ( )
SetPointer ( HourGlass! )
For i = ll_RowCount TO 1 STEP -1
	
	ls_AcctID = ads_source.object.Co_bill_acctCode[i]
				
	IF Len ( ls_AcctID ) > 0 THEN
		// if the import has an accounting id then see if it already exists in PT.
		IF gnv_cst_companies.of_doesAccountingIDExist ( ls_AcctID ) > 0 THEN
			ll_Skipped ++
			lsa_Cos[ upperBound ( lsa_Cos ) + 1 ] = ads_source.object.Co_Name[i]
			ads_source.DeleteRow ( i )
			//if it does then continue to the next row
		END IF
	END IF

NEXT

asa_Dups = lsa_Cos

return ll_Skipped
end function

protected function integer of_defaultbillingattn (ref datastore ads_source);
Long	i
Int	li_Return = 1

CONSTANT STRING ls_APTEXT = "F" 

FOR i = 1 TO ads_Source.RowCount ( )
	IF isNull ( ads_Source.object.co_Bill_Attn[i] ) OR &
		   Len ( STRING (ads_Source.object.co_Bill_Attn[i]) ) = 0  THEN
			
		ads_Source.object.co_Bill_Attn[i] = ls_APTEXT
		
	END IF
NEXT

RETURN li_Return
	
end function

public function dataStore of_getdisplaydata ();Return ids_DisplayList
end function

public function integer of_updatetable ();Int	li_Return = -1
Int	li_UpdateRtn 
IF isValid ( ids_updatesource ) THEN
	// I commented this out to fix 2757. I don't know why it was saving it out. I could not find anything that was referencin it.
	// my guess it that it was left over from testing.
	//ids_updatesource.SaveAs("C:\TEMP\SAVEFILE.TXT", text!, FALSE)
	IF ids_updatesource.RowCount ( ) > 0 THEN
		li_UpdateRtn = ids_updatesource.Update ( )
		IF	li_UpdateRtn = 1 THEN				
			Commit ;
			li_Return = 1
		ELSE
			MessageBox ( "Error" , Sqlca.sqlerrtext )
			Rollback;
			li_Return = -1 		
		END IF
	ELSE 
		li_Return = 0 
	END IF
END IF

RETURN li_Return
end function

private function integer of_settimezone (ref datastore ads_source);Int	li_tz
Long	i 
Long	ll_RowCount
String	ls_Filter
Boolean	lb_Validator

///////////////
IF Not isValid( ads_Source ) THEN RETURN -1
///////////////

ls_Filter = "IsNull (co_tz) AND Len (co_pcm) > 0"

ads_Source.SetFilter ( ls_Filter )
ads_Source.Filter ( )

ll_rowCount = ads_Source.RowCount ( )

For i = 1 TO ll_RowCount 
	li_Tz = -1
	li_tz = inv_routing.of_timezonesearch(ads_Source.object.co_pcm[i])
//	li_tz = gf_tz_Search ( ads_Source.object.co_pcm[i] , li_tz , lb_Validator )
	IF li_Tz <> -1 THEN
		ads_Source.object.co_tz[i] = li_Tz
	END IF
	
NEXT

ads_Source.SetFilter ( "" )
ads_Source.Filter ( )

	
RETURN 1
end function

public function boolean of_haspcmiler ();Boolean	lb_Return = TRUE
n_cst_LicenseManager	lnv_LicenseManager

IF pcms_inst AND (lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_PCMiler ) or &
	lnv_LicenseManager.of_usepcmilerstreets()) THEN
	//ok to proceed
else
	lb_Return = FALSE
END IF

IF lb_Return = TRUE THEN
	if lnv_LicenseManager.of_getpcmilerserverid() > 0 then
		//connected
	else
		MessageBox ( "Company Locators", "PC*Miler connection has not been established. Companies imported will not have locators assigned to them.")
		lb_Return = FALSE
	end if
END IF

RETURN lb_return
end function

public function integer of_updatecompanylocators ();setpointer(hourglass!)

string	ls_whereclause, &
			ls_OriginalSelect, &
			ls_modstring, &
			ls_rc

long		ll_rows, &
			ll_Pos

integer	li_Return=1

n_cst_LicenseManager	lnv_LicenseManager

datastore	lds_companyinfo
n_cst_privileges	lnv_Privs

IF Not lnv_Privs.of_HasSysAdminRights ( ) THEN
	MessageBox( "Automatic Company Locator Update" , "You are not authorized to perform this function." )
	li_return = -1
ELSE
	if pcms_inst AND (lnv_LicenseManager.of_usepcmilerstreets() or &
		lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_PCMiler ) ) then

		choose case MessageBox( "Automatic Company Locator Update", &
					"This will update all companies that do not have a PCMiler Locator. Ok to proceed ?", Question!,YesNo!)
			case 1
	
				inv_trip = create n_cst_trip
	
				lds_companyinfo = create n_ds
				lds_companyinfo.dataobject="d_company_info"
				lds_companyinfo.settransobject(sqlca)
				
				//update
				ls_OriginalSelect = lds_companyinfo.Describe("DataWindow.Table.Select")
				ll_pos = pos(UPPER(ls_originalselect),'WHERE', 1 )
				IF ll_pos > 0 then 
					ls_originalselect = left(ls_originalselect, ll_pos - 1)
				end if 
				
				ls_whereclause  = ls_OriginalSelect + " where companies.co_pcm is null or length(companies.co_pcm) = 0 order by co_id"
				
				ls_ModString = "DataWindow.Table.Select='" + ls_whereclause + "'"
				ls_rc = lds_companyinfo.Modify(ls_ModString)
	
				IF ls_rc = "" THEN
					// Retrieve result data
					ll_rows = lds_companyinfo.Retrieve(1)
					if ll_rows > 0 then
						if THIS.of_CreateLocators ( lds_companyinfo ) = -1 THEN
							li_return = -1
						else
							//update
							IF	lds_companyinfo.Update ( ) = 1 THEN				
								Commit ;
								li_Return = 1
							ELSE
								Rollback;
								li_Return = -1 		
							END IF
						end if
						
					end if
				ELSE
					MessageBox("Status", "Modify Failed" + ls_rc)
					li_return = -1
				END IF
				
				if isvalid(inv_trip) then
					destroy inv_trip
				end if
				
				destroy lds_companyinfo
				
			case else
				li_return = -1
				
		end choose
	else
		MessageBox( "Automatic Company Locator Update", "You are not connected to PC*Miler. Locators cannot be updated.")
	end if
end if

return li_Return

end function

private function integer of_importindiagnosticmode (string as_filename, datastore ads_datastore);
Int	li_Rtn = 1
Long	ll_CurrentRow
Long	ll_ImportRtn
Long	lla_BadRows[]
String	ls_BadRows
Boolean	lb_Continue = TRUE


DO 
	ll_CurrentRow ++
	
	ll_ImportRtn = ads_DataStore.ImportFile ( as_FileName , ll_CurrentRow , ll_CurrentRow ) 
		
	CHOOSE CASE ll_ImportRtn 
			
		CASE -1 
 
			// EOF
			li_Rtn = 0
			lb_Continue = FALSE
			
		CASE is < 0 
			ls_BadRows += String ( ll_CurrentRow ) + "~r~n"
			lla_badRows[ UpperBound ( lla_BadRows ) + 1 ] = ll_CurrentRow
			
		CASE 1 
			// imported ok	
			
	END CHOOSE

LOOP WHILE lb_Continue

MessageBox ( "Diagnostics Results" , "The rows that prevented import are:~r~n" + ls_BadRows + &
												"~r~nPlease correct the data format and re-try the import." )


RETURN li_Rtn
end function

private function integer of_createandimport (string as_dataobject, ref string as_filename, ref datastore ads_datastore);Long	ll_ImportRtn
Boolean	lb_Continue = TRUE
Int	li_Rtn = -1


IF IsValid ( ads_DataStore ) THEN DESTROY ads_DataStore

ads_DataStore = CREATE dataStore
ads_DataStore.DataObject = as_Dataobject
ads_DataStore.settransObject ( SQLCA )


IF isNull ( as_FileName ) THEN
	String	ls_PathName
	String	ls_Extension
	String	ls_Filter
	
	ls_Filter = "Text (*.txt),*.txt"
	ls_Extension = "txt"
	
	IF GetFileOpenName ( "Import File" , ls_pathname, as_FileName , ls_extension , ls_filter  ) <> 1 THEN
		lb_Continue = FALSE	
		li_Rtn = 0
	END IF
	
END IF


IF isValid ( ads_DataStore ) AND lb_Continue THEN
	SetPointer ( HourGlass! )
	ll_ImportRtn = ads_DataStore.ImportFile ( as_FileName ) 
	
	CHOOSE CASE ll_ImportRtn 
			
		CASE 0 // USER CANCELED --- DESPITE WHAT THE USELESS HELP SAYS
			li_Rtn = 0
			
		CASE is < 0 
			li_Rtn = -1
			
		CASE is > 0 
			li_Rtn = ll_ImportRtn
	END CHOOSE
	
END IF
 
RETURN li_Rtn
			
		
			
	
end function

on n_cst_import_companies.create
call super::create
end on

on n_cst_import_companies.destroy
call super::destroy
end on

