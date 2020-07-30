$PBExportHeader$n_cst_bso_liveload.sru
forward
global type n_cst_bso_liveload from n_cst_bso
end type
end forward

global type n_cst_bso_liveload from n_cst_bso
end type
global n_cst_bso_liveload n_cst_bso_liveload

type variables
Protected Constant String cs_IniFile = "liveload.ini"
Protected Constant String cs_StatusList = "Status"
Protected Constant String cs_BillingList = "Billing"
end variables

forward prototypes
public function integer of_generatefiles (string as_filegroup)
public function integer of_uploadfiles ()
public function string of_getrootpath ()
private function string of_facilities (string as_billtoids)
end prototypes

public function integer of_generatefiles (string as_filegroup);n_cst_IniFile	lnv_IniFile
String	lsa_Keys[], &
			ls_Command, &
			lsa_Parms[], &
			lsa_Blank[], &
			ls_ListType, &
			ls_DataObject, &
			ls_Select, &
			ls_RootPath, &
			ls_FileName, &
			ls_FilePath, &
			ls_CompanyAlias, &
			ls_Ids, &
			ls_facilities, &
			ls_CustomWhereClause
			
Integer	li_Keys, &
			li_Parms, &
			li_Index, &
			li_Days
Long		lla_Shipments[], &
			lla_Blank[], &
			ll_ShipmentCount, &
			ll_Count, &
			ll_ShipmentIndex  //, &
//			lla_BilltoIds[], &
//			lla_Blank[]
Date		ld_Cutoff
Boolean	lb_ValidCommand

Int 		i

n_cst_String	lnv_String
n_cst_Dws		lnv_Dws
DataStore		lds_Targets
n_ds				lds_ExportList, &
					lds_ShipmentCache, &
					lds_EventCache, &
					lds_ItemCache
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnva_Shipments[], &
							lnva_BlankShipments[]
							
Constant Integer ci_ParmsExpected = 5

Constant String cs_StatusSelectTemplate = "SELECT ds_id FROM disp_ship WHERE " + &
		"( ds_billto_id IN ([IDS]) OR ds_origin_id IN ([IDS]) OR ds_findest_id IN ([IDS]) ) " + &
		"AND ( EXISTS (SELECT cs_id FROM current_shipments WHERE cs_id = ds_id ) OR " + &
		"ds_ship_date >= '[CUTOFF]' )"

//Constant String cs_StatusSelectTemplate = "SELECT ds_id FROM disp_ship WHERE ds_billto_id IN ([IDS]) AND "+&
//	"( EXISTS (SELECT cs_id FROM current_shipments WHERE cs_id = ds_id ) OR "+&
//	"ds_ship_date >= '[CUTOFF]' )"

Constant String cs_BillingSelectTemplate = "SELECT ds_id FROM disp_ship WHERE ds_billto_id IN ([IDS]) AND "+&
	"ds_bill_date >= '[CUTOFF]'"

Constant String cs_CustomSelectTemplate = "SELECT ds_id FROM disp_ship "


String	ls_IniPath
Integer	li_Return = 1


//Get the export file root path, and make sure it's valid.

IF li_Return = 1 THEN

	ls_RootPath = This.of_GetRootPath ( )
	
	IF Len ( ls_RootPath ) > 0 THEN
		//Root path is valid.
	ELSE
		li_Return = -1
	END IF

END IF


//Derive the IniPath from the RootPath, and get a list of keys for as_FileGroup from 
//the ini file  (there is one key entry in the Group for each file to be generated.)

IF li_Return = 1 THEN

	ls_IniPath = ls_RootPath +"llapps\" + cs_IniFile
	
	//Get a list of keys (shipper ids) in the ini file for the requested file group.
	
	li_Keys = lnv_IniFile.of_GetKeys ( ls_IniPath , as_FileGroup, lsa_Keys )

END IF


FOR li_Index = 1 TO li_Keys

	lb_ValidCommand = TRUE

	setnull( ls_Command )
	setnull( ls_CompanyAlias )
	setnull( ls_ListType )
	setnull( li_Days )
	setnull( ls_DataObject )
	setnull( ld_Cutoff )
	setnull( ls_Ids )
	setnull( ls_FileName )
	setnull( ls_FilePath )

	ls_Command = ProfileString ( ls_IniPath, as_FileGroup, lsa_Keys [ li_Index ], "" )

	lsa_Parms = lsa_Blank
	li_Parms = lnv_String.of_ParseToArray ( ls_Command, ",", lsa_Parms )

	IF li_Parms = ci_ParmsExpected THEN
		//OK
	ELSE
		lb_ValidCommand = FALSE
	END IF

	IF lb_ValidCommand THEN

		ls_CompanyAlias = Trim ( lsa_Parms [ 1 ] )
		ls_ListType = Trim ( lsa_Parms [ 2 ] )
		li_Days = Integer ( lsa_Parms [ 3 ] )
		ls_DataObject = Trim ( lsa_Parms [ 4 ] )
		ld_Cutoff = RelativeDate ( Today ( ), li_Days * -1 )

		ls_Ids = ProfileString ( ls_IniPath, ls_CompanyAlias, "Id", "" )


		//Note: The following is commented because it was not checking out as intended, 
		//because of_ParseToArray just gives back zeroes as elements when it has bad values.

//		lla_BilltoIds = lla_Blank
//		IF lnv_String.of_ParseToArray ( ls_Ids, ",", lla_BilltoIds ) > 0 THEN
//			//One or more Billtos identified successfully.
//		ELSE
//			lb_ValidCommand = FALSE
//		END IF

	END IF

	IF lb_ValidCommand THEN

		//Initialize the Export datastore, using the dataobject the user has requested.
		lnv_Dws.of_CreateDataStoreByDataObject ( ls_DataObject, lds_ExportList, TRUE )


		//If a header row (or rows) has been included, it'll be in either the primary or filter 
		//buffer (if a filter expression has been specified, the header row(s) may be filtered out.)
		//Temporarily move the row(s) to the delete buffer, so they won't get lost during filter
		//and sort operations, and then can be moved back to the first position in primary for
		//export purposes.  Of course, if there's more than one row and a sort or filter has been
		//specified, they may be jumbled already.

		ll_Count = lds_ExportList.RowCount ( )
		IF ll_Count > 0 THEN
			lds_ExportList.RowsMove ( 1, ll_Count, Primary!, lds_ExportList, 9999, Delete! )
		END IF

		ll_Count = lds_ExportList.FilteredCount ( )
		IF ll_Count > 0 THEN
			lds_ExportList.RowsMove ( 1, ll_Count, Filter!, lds_ExportList, 9999, Delete! )
		END IF


		//Check if there's a custom where clause defined on the DataObject
		IF Lower ( lds_ExportList.Describe ( "st_where.name" ) ) = "st_where" THEN
			ls_CustomWhereClause = lds_ExportList.Describe ( "st_where.text" )
		ELSE
			SetNull ( ls_CustomWhereClause )
		END IF


		//Finalize the select statement based on the ini parameters and template or custom where clause.

		CHOOSE CASE Lower ( ls_ListType )

		CASE Lower ( cs_StatusList )

			//retrieve facilities of companies in the billtoids and add them to the list
			ls_facilities = this.Of_Facilities ( ls_Ids )
			IF len ( ls_Facilities ) > 0 THEN
				ls_Ids = ls_Ids + "," + ls_facilities
			END IF

			//Define the select statement that will determine which shipments will be exported.
			IF IsNull ( ls_CustomWhereClause ) THEN
				ls_Select = cs_StatusSelectTemplate
			ELSE
				ls_Select = cs_CustomSelectTemplate + ls_CustomWhereClause
			END IF

			ls_Select = lnv_String.of_GlobalReplace ( ls_Select, "[IDS]", ls_Ids )
			ls_Select = lnv_String.of_GlobalReplace ( ls_Select, "[CUTOFF]", String ( ld_Cutoff, "yyyy-mm-dd" ) )

		CASE Lower ( cs_BillingList )

			//Define the select statement that will determine which shipments will be exported.
			IF IsNull ( ls_CustomWhereClause ) THEN
				ls_Select = cs_BillingSelectTemplate
			ELSE
				ls_Select = cs_CustomSelectTemplate + ls_CustomWhereClause
			END IF

			ls_Select = lnv_String.of_GlobalReplace ( ls_Select, "[IDS]", ls_Ids )
			ls_Select = lnv_String.of_GlobalReplace ( ls_Select, "[CUTOFF]", String ( ld_Cutoff, "yyyy-mm-dd" ) )

		CASE ELSE
			lb_ValidCommand = FALSE

		END CHOOSE

	END IF


	IF lb_ValidCommand THEN

		//Set that select statement onto the datastore for retrieval.
	
		IF IsValid ( lds_Targets ) THEN
			lds_Targets.Object.DataWindow.Table.Select = ls_Select
			lds_Targets.Reset ( )
	
		ELSE

			//Note:  This can lead to a crash.  As it stands, lds_Targets will be valid
			//even if the SQL syntax was invalid.  So, the code above this can fail 
			//in setting DataWindow.Table.Select, because it isn't there.  Should we
			//revise of_CreateDataStore, or revise this here??

			lds_Targets = lnv_Dws.of_CreateDataStore ( ls_Select )
	
		END IF

		//Set sort so shipments will be listed in Tmp# order in the export.
		lds_Targets.SetSort ( "ds_id A" )
	
	
		//Retrieve the datastore.
		ll_ShipmentCount = lds_Targets.Retrieve ( )


		//If rows were retrieved, initialize the dispatch manager and have it load data for those shipments.
		//Then, use it to populate the export datastore.
	
		IF ll_ShipmentCount > 0 THEN
	
			//Clear the shipment array.
			
			FOR i = 1 TO UpperBound ( lnva_Shipments ) 
				DESTROY ( lnva_Shipments[i] )
			NEXT
			lnva_Shipments = lnva_BlankShipments
	
			//Pull the shipment ids from the target list, and retrieve those shipments in the dispatch manager.
			lla_Shipments = lds_Targets.Object.ds_id.Primary
			lnv_Dispatch = CREATE n_cst_bso_Dispatch
			lnv_Dispatch.of_RetrieveShipments ( lla_Shipments )

			//**Temporary Workaround -- See Notes in n_cst_bso_Dispatch.of_RetrieveShipments ( )
			//We need to unfilter all the retrieved items and events, so that PB will assign them
			//PBRowIds and so that they'll be visible to the GetEventList and GetShipmentList methods
			//on the shipment beo's.  Also, we need to sort the events in shipment sequence order so
			//that the GetEventList method will return the events in that order.

			lds_ShipmentCache = lnv_Dispatch.of_GetShipmentCache ( )
			lds_EventCache = lnv_Dispatch.of_GetEventCache ( )
			lds_ItemCache = lnv_Dispatch.of_GetItemCache ( )

			//FILTER SHIPMENT CACHE HERE????????  I THINK SO.

			IF IsValid ( lds_EventCache ) THEN
				lds_EventCache.SetFilter ( "" )
				lds_EventCache.SetSort ( "de_ship_seq A" )
				lds_EventCache.Filter ( )
				lds_EventCache.Sort ( )
			END IF

			IF IsValid ( lds_ItemCache ) THEN
				lds_ItemCache.SetFilter ( "" )
				lds_ItemCache.Filter ( )
			END IF
	
	
			//Create the array of shipment objects to be passed to of_PopulateShipmentData.
	
			FOR ll_ShipmentIndex = 1 TO ll_ShipmentCount
				
				lnva_Shipments [ ll_ShipmentIndex ] = CREATE n_cst_beo_Shipment
				
				lnva_Shipments [ ll_ShipmentIndex ].of_SetSource ( lds_ShipmentCache )
				lnva_Shipments [ ll_ShipmentIndex ].of_SetSourceId ( lla_Shipments [ ll_ShipmentIndex ] )
				lnva_Shipments [ ll_ShipmentIndex ].of_SetEventSource ( lds_EventCache )
				lnva_Shipments [ ll_ShipmentIndex ].of_SetItemSource ( lds_ItemCache )
	
			NEXT
	
	
			//Populate Data into the Export DataStore	
			lnv_Dispatch.of_PopulateShipmentData ( lnva_Shipments, lds_ExportList )

			//These were added in 3.0.09 to support custom filters and sorts on the PSRs.
			//If no filter or sort is specified on the PSR, these should have no effect.
			lds_ExportList.Filter ( )
			lds_ExportList.Sort ( )


			//If header row(s) were placed in the delete buffer earlier, move them back to the first
			//position in the primary buffer.

			ll_Count = lds_ExportList.DeletedCount ( )
			IF ll_Count > 0 THEN
				lds_ExportList.RowsMove ( 1, ll_Count, Delete!, lds_ExportList, 1, Primary! )
			END IF


			//Prepare to export.
	
			ls_FileName = ls_CompanyAlias + "_" + ls_ListType + ".xls"
			
			ls_FilePath = ls_RootPath + "lldata\"+ls_companyAlias +"\"+&
							  	ls_ListType + "\" + ls_FileName

	
			lds_ExportList.SaveAs ( ls_FilePath, Excel!, FALSE )
	
			DESTROY lnv_Dispatch
	
		END IF

	END IF
NEXT

DESTROY lds_Targets
DESTROY lds_ExportList

FOR i = 1 TO UpperBound ( lnva_Shipments )
	DESTROY ( lnva_Shipments[i] )
NEXT


RETURN 1
end function

public function integer of_uploadfiles ();/*
		Get files from c:\Liveload.net\billing report and c:\Liveload.net\status report
		connect to SIOFTCli.Transmitter and transmit files
	
*/

String	ls_RootPath, &
			ls_fullpath, &
			ls_report_desc, &
			ls_truckingco, &
			ls_shippingco, &
			ls_filetype, &   
			ls_filename, &
			ls_filedescription, &
			ls_server, &
			lsa_shippingname[], &
			ls_parsestring, &
			ls_logfile, &
			ls_text, &
			ls_msg_label, &
			ls_newname, &
			ls_return, &
			ls_subfolder   //history files
			
boolean	lb_append=true

DateTime ldt_system
Date		ld_FileMod
Time		lt_FileMod

Integer	li_Keys, &
			li_Index, &
			li_FileType, &
			li_filecnt, &
			li_errorcnt, &
			li_FileNo
			
n_cst_filesrvwin32	lnv_filesrvwin32
n_cst_dirattrib		lnv_dirattrib[]
n_cst_string			lnv_string
oleObject lnv_ole1

Integer	li_Return = 1

//Get the export file root path, and make sure it's valid.

IF li_Return = 1 THEN

	ls_RootPath = This.of_GetRootPath ( )
	
	IF Len ( ls_RootPath ) > 0 THEN		//Root path is valid.
		
		/*	Make sure directory exists	*/

		lnv_filesrvwin32 = Create n_cst_filesrvwin32

		IF not lnv_filesrvwin32.of_directoryexists ( ls_RootPath ) then
			
			ls_text = "The file Path in the ini file does not exist."
			li_Return = -1
		
		END IF

	ELSE

		ls_text = "No file Path in the ini file."
		li_Return = -1

	END IF

	IF li_Return = -1 THEN

		li_FileNo = FileOpen("transmit.txt", LineMode!, Write!, LockReadWrite!, Append!)
		FileWrite ( li_FileNo, ls_text )
		
	END IF
	
END IF


//Create log file in current directory, if it already exists then a blank line will be appended

IF li_Return = 1 THEN

	ls_logfile = ls_RootPath + "transmit.txt"

	IF FileExists ( ls_logfile ) THEN

		li_FileNo = FileOpen(ls_logfile, LineMode!, Write!, LockReadWrite!, Append!)
		//write blank lines
		IF li_FileNo < 0 THEN 
			
			li_Return = -1
			
		ELSE
			
			ls_text = " "
			FileWrite ( li_FileNo, ls_text )
			FileWrite ( li_FileNo, ls_text )
			
		END IF

	ELSE

		li_FileNo = FileOpen(ls_logfile, LineMode!, Write!, LockReadWrite!, Append!)
		
		IF li_FileNo < 0 THEN li_Return = -1

	END IF
	
	IF li_Return = 1 THEN

		ldt_system = DateTime(Today(), Now())
		ls_subfolder = String(ldt_system,"mmddhhmm")
		ls_text = "Log for upload. " + ls_subfolder
		FileWrite ( li_FileNo, ls_text )
	
	END IF
		
END IF


IF li_Return = 1 THEN

	lnv_ole1 = Create oleObject

	ls_msg_label = "Couldn't connect to the transmit object. Error: " 
	
	choose case lnv_ole1.ConnectToNewObject("SIOFTCli.Transmitter")
			
	case 0 		//  connnection made
		//	continue
		
	case -1		
		ls_text = ls_msg_label + "-1. Error msg - Invalid Call: the argument is the Object property of a control"
		li_Return = -1
		
	case -2  	//	 
		ls_text = ls_msg_label + "-2. Error msg - Class name not found"
		li_Return = -1
		
	case -3  	//	 
		ls_text = ls_msg_label + "-3. Error msg - Object could not be created"
		li_Return = -1
		
	case -4  	//	 
		ls_text = ls_msg_label + "-4. Error msg - Could not connect to object"
		li_Return = -1
		
	case -9  	//	 
		ls_text = ls_msg_label + "-9. Error msg - Other error"
		li_Return = -1

	CASE ELSE	//  
		ls_text = ls_msg_label + "Unexpected return"
		li_Return = -1
			
	end choose
	
	IF li_Return = -1 THEN
		
		FileWrite ( li_FileNo, ls_text )

	END IF

END IF


IF li_Return = 1 THEN

	/* company name and servername from LiveLoad.ini 	*/
	ls_truckingco=ProfileString ( cs_IniFile, "Trucking Company", "Name", "No Trucking name" )
	ls_server=ProfileString ( cs_IniFile, "Server", "Name", "No Server name" )
	

	FOR li_FileType = 0 TO 1

		CHOOSE CASE li_FileType

		CASE 0
			ls_report_desc = cs_StatusList
			ls_filetype = "0"

		CASE 1
			ls_report_desc = cs_BillingList
			ls_filetype = "1"

		END CHOOSE


		ls_fullpath=ls_RootPath + ls_report_desc +"\*.*"
		li_filecnt=lnv_filesrvwin32.of_dirlist ( ls_fullpath, 39, lnv_dirattrib )  //DirList clears the array
			//39 Represents the bitwise sum of all desired file types (all files, no folders)  See PB DirList()

		IF li_filecnt > 0 then
			
			/*	Create subfolder for history	*/
			choose case lnv_filesrvwin32.of_createdirectory ( ls_RootPath + ls_report_desc + "\" + ls_subfolder)
					
			case 1 	//successful
			
			case -1	//unsuccessful
				
				//how should we handle? 
				
			end choose				

			FOR li_Index = 1 to li_filecnt

				/*	Strip Shipping Co name from filename 	*/
				lnv_string.of_parsetoarray(lnv_dirattrib[li_Index].is_filename,"_", lsa_shippingname[])
				ls_shippingco=lsa_shippingname[1]
	
				/*	For now, file description is the same as the report description(directory name)	*/
				ls_filedescription=ls_report_desc
			
				ls_filename = ls_RootPath + ls_report_desc +"\" + lnv_dirattrib[li_Index].is_filename

				IF lnv_FileSrvWin32.of_GetLastWriteDateTime ( ls_FileName, ld_FileMod, lt_FileMod ) = 1 THEN

					ls_FileDescription += " ( Last Updated " + String ( ld_FileMod, "m/d/yy" ) + " at " +&
						String ( lt_FileMod, "h:mm AM/PM" ) + " )"

				END IF

		//		Example of what the Parameters of Transmit look like:
		//		lnv_ole1.Transmit("TruckCoA", "ShipperY", "1", "c:\test.xls", "Billing Report", "www.standardio.com")

				ls_return=lnv_ole1.Transmit(ls_truckingco, ls_shippingco, ls_filetype, ls_filename, ls_filedescription, ls_server)
		
				choose case ls_return
						
				case ' ', ''// File was successfully uploaded to server
					ls_text = "File: " + ls_filename + " was successfully uploaded."
					FileWrite ( li_FileNo, ls_text )
					
					//	move file so that it won't be uploaded again
					ls_newname = ls_RootPath + ls_report_desc + "\" + ls_subfolder + "\" + lnv_dirattrib[li_Index].is_filename
					lnv_filesrvwin32.of_filerename ( ls_filename, ls_newname )
										
				case else	// File was not uploaded to server
					ls_text = "File: " + ls_filename + " could not be uploaded."
					FileWrite ( li_FileNo, ls_text )
					ls_text = "There was a problem with the transmit object."
					FileWrite ( li_FileNo, ls_text )
					ls_text = ls_return
					FileWrite ( li_FileNo, ls_text )

					li_errorcnt ++

				end choose
				
			NEXT
			
		END IF
	
	NEXT

	li_return = li_errorcnt
	
	Choose case li_errorcnt
			
	case 0 		//	All files successfully loaded
		ls_text = "All files were successfully uploaded."
		FileWrite ( li_FileNo, ls_text )
		
	case else	//	Not all files loaded
		ls_text = "Not all of the files were successfully uploaded. " + &
					 string(li_errorcnt) + "  errors occurred. " + &
					 "Check previous lines for files that did not upload."
		FileWrite ( li_FileNo, ls_text )
		
	end choose

END IF

//	Close transmit error log
FileClose ( li_FileNo )

IF isvalid(lnv_filesrvwin32) then
	DESTROY lnv_filesrvwin32
END IF

IF isvalid(lnv_ole1) THEN
	DESTROY lnv_ole1
END IF

RETURN li_return


end function

public function string of_getrootpath ();String	ls_RootPath
String	ls_Path

gnv_App.of_GetLiveLoadPath ( ls_Path ) 
ls_Path += "llapps\" + cs_IniFile

ls_RootPath = ProfileString ( ls_Path, "FilePath", "Path", "" )

IF Len ( ls_RootPath ) > 0 THEN

	//If the path does not end in a "\", add one.

	IF Right ( ls_RootPath, 1 ) = "\" THEN
		//No processing necessary.
	ELSE
		ls_RootPath += "\"
	END IF

END IF

RETURN ls_RootPath
end function

private function string of_facilities (string as_billtoids);/*
	This method will get all the facilities for the list
	of companies passed in the argument. 
	
	Return comma seperated list of facilities,
			 empty string if no facilities are found
	
*/

string	ls_Facilities, &
			ls_WhereClause, &
			ls_OriginalSelect, &
			ls_rc, &
			ls_ModString
			
long		lla_Facilities [], &
			ll_Count, &
			ll_FacilityCount, &
			ll_Row
			
			
datastore	lds_Companies
//retrieve facilities of companies in the billtoids and add them to the list
lds_Companies = Create datastore
lds_Companies.dataobject = "d_company_list"
lds_Companies.SetTransObject(SQLCA)
ls_WhereClause = "WHERE co_facility_of in ( " + as_BilltoIds + ") AND co_status <> ~~'D~~' "
ls_OriginalSelect = lds_Companies.Describe("DataWindow.Table.Select")
ls_ModString = "DataWindow.Table.Select='" + ls_OriginalSelect + ls_WhereClause + "'"
ls_rc = lds_Companies.Modify(ls_ModString)
IF ls_rc = "" THEN
	ll_Row = lds_Companies.Retrieve()
ELSE
	ls_Facilities = ""
END IF

IF ll_Row > 0 THEN
	lla_Facilities = lds_Companies.Object.co_id.primary
	ll_FacilityCount = UpperBound ( lla_Facilities )
END IF

IF ll_FacilityCount = 0 THEN
	ls_Facilities = ""
END IF

FOR  ll_Count = 1 to ll_FacilityCount
	If ll_Count > 1 THEN ls_Facilities = ls_Facilities +  ","
	ls_Facilities = ls_Facilities + string ( lla_Facilities [ll_Count] )
	
NEXT

DESTROY lds_Companies
return ls_Facilities


end function

on n_cst_bso_liveload.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bso_liveload.destroy
TriggerEvent( this, "destructor" )
end on

