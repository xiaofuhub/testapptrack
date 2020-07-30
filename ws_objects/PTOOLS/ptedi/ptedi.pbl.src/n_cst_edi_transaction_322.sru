$PBExportHeader$n_cst_edi_transaction_322.sru
forward
global type n_cst_edi_transaction_322 from n_cst_edi_transaction
end type
end forward

global type n_cst_edi_transaction_322 from n_cst_edi_transaction
end type
global n_cst_edi_transaction_322 n_cst_edi_transaction_322

type variables
Protected String	is_Newline = "~r~n"
Protected String	is_Delimiter = "*"

DataStore ids_Cache
end variables

forward prototypes
public subroutine of_loadtransactions (ref n_cst_msg anv_msg)
protected function integer of_buildtransaction (string as_recipient, datastore ads_list, long al_row, ref string as_transaction)
protected function integer of_buildrecord_q5 (string as_recipient, string as_delimiter, datastore ads_list, long al_row, ref string as_record)
protected function integer of_buildrecord_n7 (string as_recipient, string as_delimiter, datastore ads_list, long al_row, ref string as_record)
protected function integer of_buildrecord_se (string as_delimiter, long al_segmentcount, string as_controlnumber, ref string as_record)
protected function integer of_buildrecord_st (string as_recipient, string as_delimiter, string as_controlnumber, ref string as_record)
protected function integer of_buildrecord_isa (string as_recipient, string as_delimiter, long al_control, ref string as_record)
protected function integer of_buildrecord_gs (string as_recipient, string as_delimiter, long al_control, ref string as_record)
protected function string of_gettzcode (integer ai_timezone)
protected function string of_gettzcode ()
public function integer of_sendforcompany (long al_coid)
public function n_ds of_getedicache (boolean ab_retrieve)
public function integer of_loadevent (long al_eventid)
public function integer of_setcache (datastore ads_cache)
protected function string of_getoutboundmappingfile ()
protected function string of_getidcolname ()
public subroutine of_sendtransaction (long ala_id[])
public function string of_geterrorcontext (long ala_ids[])
end prototypes

public subroutine of_loadtransactions (ref n_cst_msg anv_msg);//Revised in 3.5.23 3-12-2003 BKW to allow messages to be created for events that are not part of a shipment.

String	ls_Path, &
			ls_HoldCode, &
			ls_CurrentFile, &
			ls_CurrentTransaction, &
			ls_CurrentRecord, &
			ls_HeaderRecord, &
			ls_TrailerRecord, &
			lsa_Transactions[], &
			lsa_Empty[], &
			ls_NextRecipient, &
			ls_StringFormat, &
			ls_GroupPrefix, &
			ls_TransactionControl, &
			ls_Record, &
			ls_FilePathName
s_parm	lstr_parm
n_ds		lds_ShipmentStatus
Long		ll_Row, &
			ll_RowCount, &
			ll_Event, &
			ll_HoldShip, &
			ll_Test, &
			ll_SegmentCount, &
			ll_TransactionCount, &
			ll_Transaction, &
			ll_GroupControl, &
			ll_Skipped
Boolean	lb_Skip
n_cst_String	lnv_String


n_cst_FileSrvWin32	lnv_FileSrv


if isvalid(anv_msg) then

	IF anv_msg.Of_Get_Parm ( "SHIPMENTSTATUS" , lstr_Parm ) <> 0 THEN
		ids_shipstatus= lstr_Parm.ia_Value
		ll_RowCount = ids_shipstatus.RowCount()
		//The default sort of the dataobject is RecipientCode, Shipment, Date, Time.
		//I'm going to stick with that, although it's possible that shipment should be omitted.
	END IF

end if

if this.of_CacheDatamapping() > 0 then
	this.of_FilterDatamappingCache("transfertype='EDI322'")
end if

this.of_SetDatamappingdirection('O')	//output


//Get the output file path.
ls_Path = ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI322", "Path", "" )

//If no path is specified, use the application folder, rather than failing.

IF Len ( ls_Path ) > 0 THEN
	//OK
ELSE
	ls_Path = gnv_App.of_GetApplicationFolder ( )
END IF

IF Right ( ls_Path, 1 ) = "\" THEN
	//OK
ELSE
	ls_Path += "\"
END IF


if ll_RowCount > 0 then
	
	for ll_Row = 1 to ll_rowcount

		//I'm using lb_Skip rather than CONTINUE because even if you skip this row, you may still need to 
		//write out the file due to a change in recipient after this row.

		lb_Skip = FALSE
	
		ll_test = ids_shipstatus.object.disp_events_de_shipment_id[ll_Row]
		ll_event = ids_shipstatus.object.disp_events_de_id[ll_Row]
		ls_HoldCode = ids_shipstatus.object.shipment_status_edi_214_code[ll_Row]

		if isnull(ll_test) then   //Changed the way this is being handled in 3.5.23, in order to handle non-shipment events.

			SetNull ( ll_HoldShip )

			IF This.of_LoadEvent ( ll_Event ) = 1 THEN
				//OK
	//			I'm going to stay away from this for the moment since of_SetEDICompany ID is coded to look at the EDI214Code.
	//			this.of_SetEDICompanyId(ls_HoldCode)
				this.li_EDICoId = 0		//This is an instance variable that was named backwards.
			ELSE
				lb_Skip = TRUE
			END IF

		elseif IsNull ( ll_HoldShip ) OR ll_holdship <> ll_Test then

			ll_holdship = ll_Test

			if this.of_loadshipment(ll_holdship) = -1 then      //!!  Another enforcement of No shipment - no message
				lb_Skip = TRUE
			end if

//			I'm going to stay away from this for the moment since of_SetEDICompany ID is coded to look at the EDI214Code.
//			this.of_SetEDICompanyId(ls_HoldCode)
			this.li_EDICoId = 0		//This is an instance variable that was named backwards.

		end if

		IF NOT lb_Skip THEN

			CHOOSE CASE This.of_BuildTransaction ( ls_HoldCode, ids_ShipStatus, ll_Row, ls_CurrentTransaction )

			CASE 1  //Transaction built succesfully.

				ll_TransactionCount ++
				lsa_Transactions [ ll_TransactionCount ] = ls_CurrentTransaction

				//mark row as processed so it will be deleted after file creation
				ids_shipstatus.object.shipment_status_processed[ll_Row] = "Y"

			CASE -1  //Transaction Failed

				//Do not add the transaction to the lsa_Transactions array.

			CASE ELSE  //Unexpected Return Value

				//Do not add the transaction to the lsa_Transactions array.

			END CHOOSE


		END IF

	
		//break on recipient, create a separate file for each recipient
	
		IF ll_Row = ll_RowCount THEN
			ls_NextRecipient = ""
		ELSE
			ls_NextRecipient = ids_shipstatus.object.shipment_status_edi_214_code[ll_Row + 1]
		END IF
	
		if ls_HoldCode = ls_NextRecipient then
	
			//Same recipient on next row
	
		ELSE
	
			IF ll_TransactionCount > 0 THEN

				//Try to get a control #

				CHOOSE CASE SQLCA.of_GetCustomSeriesValue ( "EDI322CONTROL", ls_HoldCode, ll_GroupControl, &
					ls_StringFormat, TRUE /*Auto Insert if not set up previously*/, TRUE /*Commit*/ )
				
				CASE 1  //Value determined successfully.  Convert number to string control # value.
			
					IF Len ( ls_StringFormat ) > 0 THEN
						//Use it
					ELSE
						ls_StringFormat = ""
					END IF
			
					ls_GroupPrefix = String ( ll_GroupControl, ls_StringFormat )
				
				CASE -1  //Could not determine value
			
					SetNull ( ll_GroupControl )
				
				CASE ELSE  //Unexpected return value.
			
					SetNull ( ll_GroupControl )
				
				END CHOOSE


			ELSE

				SetNull ( ll_GroupControl )

			END IF


			IF NOT IsNull ( ll_GroupControl ) THEN

				FOR ll_Transaction = 1 TO ll_TransactionCount

					//Note:  This assumes less than 1000 transactions per group
					ls_TransactionControl = ls_GroupPrefix + String ( ll_Transaction, "000" )

			
					ll_SegmentCount = lnv_String.of_CountOccurrences ( lsa_Transactions [ ll_Transaction ], is_Newline )
				
					IF ll_SegmentCount > 0 THEN
				
						ll_SegmentCount += 2  //Add 2 to account for the header and trailer records, about to be added.
				
					ELSE
				
						ll_SegmentCount = 0
				
					END IF


					IF ll_SegmentCount > 0 THEN

						//Get the transaction header record, which will determine the control number, passed out by reference.
					
						CHOOSE CASE This.of_BuildRecord_ST ( ls_HoldCode, is_Delimiter, ls_TransactionControl, ls_Record )
						
						CASE 1
						
							//Add the header record to the front of the existing transaction string.
							lsa_Transactions [ ll_Transaction ] = ls_Record + lsa_Transactions [ ll_Transaction ]
					
						CASE ELSE
					
							ll_SegmentCount = 0
					
						END CHOOSE

					END IF


					IF ll_SegmentCount > 0 THEN

						//Get the transaction trailer record, and append it to the existing transaction string, if successful.
					
						CHOOSE CASE This.of_BuildRecord_SE ( is_Delimiter, ll_SegmentCount, ls_TransactionControl, ls_Record )
						
						CASE 1
						
							lsa_Transactions [ ll_Transaction ] += ls_Record
					
						CASE ELSE
					
							ll_SegmentCount = 0
					
						END CHOOSE

					END IF

					
					IF ll_SegmentCount > 0 THEN

						ls_CurrentFile += lsa_Transactions [ ll_Transaction ]

					ELSE

						ll_Skipped ++

					END IF

				NEXT
				
			END IF


			//Append the group header and trailer records to the front and back ends of the file

			IF Len ( ls_CurrentFile ) > 0 THEN

				CHOOSE CASE This.of_BuildRecord_GS ( ls_HoldCode, is_Delimiter, ll_GroupControl, ls_Record )

				CASE 1

					ls_CurrentFile = ls_Record + ls_CurrentFile

					//Build the GE (Functional Group Trailer) Record.
					ls_Record = "GE" + is_Delimiter + String ( ll_TransactionCount - ll_Skipped ) +&
						is_Delimiter + String ( ll_GroupControl ) + is_Newline

					ls_CurrentFile += ls_Record

				CASE -1

					ls_CurrentFile = ""

				CASE ELSE

					ls_CurrentFile = ""

				END CHOOSE

			END IF


			//Append the interchange header and trailer records to the front and back ends of the file

			//Note that we're using the Group control number as the interchange control number, since there's only 1 group.

			IF Len ( ls_CurrentFile ) > 0 THEN

				CHOOSE CASE This.of_BuildRecord_ISA ( ls_HoldCode, is_Delimiter, ll_GroupControl, ls_Record )

				CASE 1

					ls_CurrentFile = ls_Record + ls_CurrentFile

					//Build the IEA (Interchange Control Trailer) Record.
					ls_Record = "IEA" + is_Delimiter + "1" /*Number of Groups in file*/ +&
						is_Delimiter + String ( ll_GroupControl, "000000000" ) /*9/9 min/max*/ + is_Newline

					ls_CurrentFile += ls_Record

				CASE -1

					ls_CurrentFile = ""

				CASE ELSE

					ls_CurrentFile = ""

				END CHOOSE

			END IF

			

			//write file 
	
			if Len ( ls_CurrentFile ) > 0 then


				//Determine name for the file.
	
				ls_FilePathName = ls_Path + "322-" + ls_HoldCode + "-" + String ( ll_GroupControl, "0000" ) + ".TXT"
	
	
				//Write File using FileSrv (will write any size string in stream mode, breaking it up if necessary)
	
				lnv_FileSrv = CREATE n_cst_FileSrvWin32
				lnv_FileSrv.of_FileWrite ( ls_FilePathName, ls_CurrentFile, FALSE /*Don't Append*/ )
				DESTROY lnv_FileSrv
				
			end if
	
			//reset for new recipient
			ls_FilePathName = ""
			ls_CurrentFile = ""
			ll_TransactionCount = 0
			ll_Skipped = 0
			lsa_Transactions = lsa_Empty
	
		end if

	next
	
	//delete rows from table 
	for ll_Row = ll_rowcount to 1 step -1
		if ids_shipstatus.object.shipment_status_processed[ll_Row] = "Y" then
			ids_shipstatus.RowsMove(ll_Row, ll_Row, Primary!, ids_shipstatus, 1, Delete!)
		end if
	next
	if ids_shipstatus.update() <> 1 then
		rollback;
	else
		commit;
	end if

end if
end subroutine

protected function integer of_buildtransaction (string as_recipient, datastore ads_list, long al_row, ref string as_transaction);String	ls_Transaction, &
			ls_Recipient, &
			ls_Record

Integer	li_Return = 1

as_Transaction = ""

IF li_Return = 1 THEN

	CHOOSE CASE This.of_BuildRecord_Q5 ( as_Recipient, is_Delimiter, ads_List, al_Row, ls_Record )
	
	CASE 1
	
		ls_Transaction += ls_Record

	CASE ELSE

		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	CHOOSE CASE This.of_BuildRecord_N7 ( as_Recipient, is_Delimiter, ads_List, al_Row, ls_Record )
	
	CASE 1
	
		ls_Transaction += ls_Record

	CASE ELSE

		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	as_Transaction = ls_Transaction

END IF


RETURN li_Return
end function

protected function integer of_buildrecord_q5 (string as_recipient, string as_delimiter, datastore ads_list, long al_row, ref string as_record);Integer	li_Element
String	ls_Segment = "Q5", &
			ls_Element, &
			ls_Data, &
			ls_Record
Date		ld_Date
Time		lt_Time

n_cst_String	lnv_String

Integer	li_Return = 1


IF li_Return = 1 THEN

	ls_Record = ls_Segment

	FOR li_Element = 1 TO 4

		ls_Record += as_Delimiter

		ls_Element = ls_Segment + String ( li_Element, "00" )
		ls_Data = ""

		CHOOSE CASE li_Element

		CASE 01

			ls_Data = ads_List.Object.Edi_Status_a_Code [ al_Row ]

		CASE 02

			ld_Date = ads_List.Object.Shipment_Status_Status_Date [ al_Row ]

			ls_Data = String ( ld_Date, "yyyymmdd" )

		CASE 03

			lt_Time = ads_List.Object.Shipment_Status_Status_Time [ al_Row ]

			ls_Data = String ( lt_Time, "hhmm" )

		CASE 04

			ls_Data = This.of_GetTZCode ( )  //Get the Time Code for base time.


		END CHOOSE


		IF IsNull ( ls_Data ) THEN

			ls_Data = ""

		ELSEIF Len ( ls_Data ) > 0 THEN

			//If delimiter occurs in the data, need to replace it with empty string.
			ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )

		END IF

		ls_Record += ls_Data

	NEXT

END IF


IF li_Return = 1 THEN

	//Append Newline character(s) to the record.
	ls_Record += is_Newline

	as_Record = ls_Record

ELSE

	as_Record = ""

END IF

RETURN li_Return
end function

protected function integer of_buildrecord_n7 (string as_recipient, string as_delimiter, datastore ads_list, long al_row, ref string as_record);//Revised for 3.5.23 3-12-03 BKW to allow creation of message for non-shipment events.
//Revised for 3.5.25 4-04-03 BKW to handle special requirements for ZIM @ Marex -- no vessel info, 
// and no non-standard chassis info  (see notes in-code.)

//Revised for 3.9 6-15-04 Issue#794 BKW to allow entry of Booking #, Seal #, Vessel, Voyage, Port of Origin, Port of Dest,
// Gross Weight, Weight Indicator (LBS/KGS), and Remarks. This is accomplished by popping a dialog and prompting the user 
// for the information.  If the event is part of a shipment, the info from the shipment will be displayed in the dialog,
// and the user will have the opportunity to review / approve / edit it.  Note that this happens AFTER 
// the original selection of the Message Type during event confirmation -- this is happening during the actual 
// generation of the message itself, during SAVE.  This is done because we currently have no place to store the info 
// if we prompted for it earlier, so our only non-invasive choice in the time allotted is to prompt for the information 
// during the process that will use it, eliminating the need for saving it.  Some of this information is technically 
// required, but we left it out of the original implementation by agreement with Marex because their customer at the time
// (ZIM) said they did not require it.  However, Marex then started using 322 with Columbus Lines, and they initially 
// accepted it without this info but then later demanded it, forcing the change on a paid basis with Marex.  Even now, 
// the fields are not going to be required in the dialog, because Marex has said they simply will not always have the
// information, and they would rather send the message through without it (which will raise an error at the Line) rather 
// than fill in dummy information which could cause bigger problems at the line.
// Also, revised to strip any instances of delimiter character from all data records.  Previously, this had only been
// done for N7 and DTM  (two places where it is least needed.)  And even there, it would have had no effect, because 
// the call to of_GlobalReplace treated the as_Source parameter as if it was by reference, but it's not -- it's by value,
// and the of_GlobalReplace function returns the revised string.  This call has been corrected throughout this object --
// the same problem also was coded in of_buildrecord_q5, of_buildrecord_isa, and of_buildrecord_gs (although in _isa and 
// _gs, the call was commented.)


Integer	li_Element, &
			li_EquipmentCount, &
			li_ContainerCount, &
			li_ChassisCount, &
			li_ChassisIndex, &
			li_N7Count, &
			li_N7Loop, &
			li_DialogRow
String	ls_Segment, /*Several records are handled in a loop here, so several segment labels will be used.*/ & 
			ls_Element, &
			ls_Data, &
			ls_Record, &
			ls_RecordSet, &
			ls_UnitNumber, &
			ls_Prefix, &
			ls_Number, &
			ls_Check, &
			ls_Type, &
			ls_Booking, &
			ls_Seal, &
			ls_Vessel, &
			ls_Voyage, &
			ls_OriginPort, &
			ls_DestinationPort, &
			ls_WeightUnits, &
			ls_Remarks1, &
			ls_Remarks2, &
			ls_Shipment_Booking, &
			ls_Shipment_Seal, &
			ls_Shipment_Vessel, &
			ls_Shipment_Voyage, &
			ls_Shipment_OriginPort, &
			ls_Shipment_DestinationPort, &
			ls_Shipment_WeightUnits, &
			ls_ChassisUnitNumber, &
			ls_ChassisPrefix, &
			ls_ChassisNumber, &
			ls_ChassisCheck, &
			ls_EventDescription, &
			lsa_Value[], &
			ls_N102, &
			ls_N103, &
			ls_N104
Long		ll_Weight, &
			ll_Shipment_Weight, &
			lla_Drivers[],    /*Added 3.5.23*/ &
			lla_Equipment[],  /*Added 3.5.23*/ &
			ll_Index				/*Added 3.5.23*/ 
Date		ld_Date
Time		lt_Time
Boolean	lb_HasShipment, 	/*Added 3.5.23*/ &		
			lb_Dialog,			/*Added 3.9*/ &
			lb_DialogResults,	/*Added 3.9*/ &
			lb_Retry, &
			lb_UseShipmentValues

n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Event		lnv_Event	//Added 3.5.23

n_cst_beo_Equipment2	lnva_Equipment[], &
							lnva_Containers[], &
							lnva_Chassis[], &
							lnva_N7Equip[]

DataStore				lds_EquipmentCache,	/*Added 3.5.23*/ &
							lds_Dialog				/*Added 3.9  Passed to w_EDI322_Dialog  */
							
w_EDI322_Dialog		lw_Dialog				//Added 3.9

n_cst_String	lnv_String

Integer	li_Return = 1


IF li_Return = 1 THEN

	This.of_GetShipmentBeo ( lnv_Shipment )

	IF IsValid ( lnv_Shipment ) THEN

		IF lnv_Shipment.of_HasSource ( ) THEN

			//OK, get some general data fields for use later.

			lb_HasShipment = TRUE
	
			ls_Shipment_Booking = Left ( Trim ( lnv_Shipment.of_GetBooking ( ) ), 30 ) //30 Char field limit
			ls_Shipment_Seal = Left ( Trim ( lnv_Shipment.of_GetSeal ( ) ), 15 )  //15 Char field limit
			ls_Shipment_Vessel = Left ( Trim ( lnv_Shipment.of_GetVessel ( ) ), 28 )  //28 Char field limit
			ls_Shipment_Voyage = Left ( Trim ( lnv_Shipment.of_GetVoyage ( ) ), 10 )  //10 Char field limit
			ls_Shipment_OriginPort = Left ( Trim ( lnv_Shipment.of_GetOriginPort ( ) ), 24 ) //24 Char Field Limit
			ls_Shipment_DestinationPort = Left ( Trim ( lnv_Shipment.of_GetDestinationPort ( ) ), 24 )  //24 Char Field Limit
			ll_Shipment_Weight = lnv_Shipment.of_GetTotalWeight ( )
			ls_Shipment_WeightUnits = "L"  //Hardwire as "L" (Pounds), since that is the only weight type supported on shipment
			
		END IF

	END IF
	
	
//Originally, we were going to make it so we'd only show the dialog if the event wasn't in a shipment.
//But then, we decided to show the dialog anyway, with the data prepopulated.  I've coded it in such a way that
//we could backtrack and make this a configurable option, if we wanted to.

//	IF lb_HasShipment = FALSE THEN
		
		lb_Dialog = TRUE
		
		lds_Dialog = CREATE DataStore
		lds_Dialog.DataObject = "d_EDI322_Dialog"
		lds_Dialog.SetTransObject ( SQLCA )
		
//	END IF


END IF


//Section added 3.5.23

IF li_Return = 1 THEN

	IF IsValid ( This.inv_Event ) THEN

		//inv_Event is populated only for a non-shipment event.
		lnv_Event = inv_Event

	ELSE

		 IF This.of_GetEventBeo ( ads_List.Object.Shipment_Status_EventID [ al_Row ], lnv_Event ) = 1 THEN

			//OK

		ELSE

			li_Return = -1

		END IF

	END IF

END IF


IF li_Return = 1 THEN

	IF IsValid ( lnv_Event ) THEN
		IF lnv_Event.of_HasSource ( ) THEN
			//OK
		ELSE
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF NOT IsValid ( inv_Dispatch ) THEN
		li_Return = -1
	END IF

END IF

// End section added 3.5.23



IF li_Return = 1 THEN

	//If it's an assignment event, just get the equipment that's "actively" involved in the event, 
	//ie, being hooked, dropped, mounted, dismounted, etc.  If it's not an assignment event, just
	//get a list of everything.

	IF lnv_Event.of_IsAssignment ( ) THEN

		lnv_Event.of_GetActiveAssignments ( lla_Drivers, lla_Equipment )

	ELSE

		lnv_Event.of_GetAssignments ( lla_Drivers, lla_Equipment )

	END IF


	li_EquipmentCount = UpperBound ( lla_Equipment )

	IF li_EquipmentCount > 0 THEN

		inv_Dispatch.of_RetrieveEquipment ( lla_Equipment )
		lds_EquipmentCache = inv_Dispatch.of_GetEquipmentCache ( )

	END IF


	FOR ll_Index = 1 TO li_EquipmentCount

		lnva_Equipment [ ll_Index ] = CREATE n_cst_beo_Equipment2
		lnva_Equipment [ ll_Index ].of_SetSource ( lds_EquipmentCache )
		lnva_Equipment [ ll_Index ].of_SetSourceId ( lla_Equipment [ ll_Index ] )

		CHOOSE CASE lnva_Equipment [ ll_Index ].of_GetType ( )

		CASE "H", "F"  //Chassis, Flatbed

			li_ChassisCount ++
			lnva_Chassis [ li_ChassisCount ] = lnva_Equipment [ ll_Index ]

		CASE "V", "R", "K", "B", "C"  //Trailer, Reefer, Tank, Railbox, Container

			li_ContainerCount ++
			lnva_Containers [ li_ContainerCount ] = lnva_Equipment [ ll_Index ]

		END CHOOSE

	NEXT				


	IF li_ContainerCount > 0 THEN

		li_N7Count = li_ContainerCount
		lnva_N7Equip = lnva_Containers

	ELSEIF li_ChassisCount > 0 THEN

		li_N7Count = li_ChassisCount
		lnva_N7Equip = lnva_Chassis

//	ELSE		//This had been here prior to 3.5.23, when we were getting linked equipment
//
//		li_N7Count = li_EquipmentCount
//		lnva_N7Equip = lnva_Equipment

	END IF
	
	//Get the event description for use in the dialog.  Currently, this is just the event type.
	ls_EventDescription = ""
	lnv_Event.of_GetValueString ( "TYPE", ls_EventDescription )


END IF

/////////////////////////////////////////////////////////////////////////////////////



IF li_Return = 1 THEN

	FOR li_N7Loop = 1 TO li_N7Count

		ls_Prefix = ""
		ls_Number = ""
		ls_Check = ""
		ls_Type = ""
		
		ls_Booking = ""
		ls_Seal = ""
		ls_Vessel = ""
		ls_Voyage = ""
		ls_OriginPort = ""
		ls_DestinationPort = ""
		ls_WeightUnits = "L"   //Default to "L" (Pounds)
		ll_Weight = 0
		ls_Remarks1 = ""
		ls_Remarks2 = ""
		

		ls_UnitNumber = Upper ( Trim ( lnva_N7Equip [ li_N7Loop ].of_GetNumber ( ) ) )
		ls_Type = lnva_N7Equip [ li_N7Loop ].of_GetType ( )

		IF Match ( ls_UnitNumber, "^[A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]" ) THEN

			ls_Prefix = Left ( ls_UnitNumber, 4 )
			ls_Number = Mid ( ls_UnitNumber, 5, 6 )

			IF Len ( ls_UnitNumber ) > 10 THEN

				ls_Check = Right ( ls_UnitNumber, 1 )

			END IF

		ELSE

			ls_Number = Left ( ls_UnitNumber, 10 )  //10 Character field limit

		END IF
		
		
		IF IsNull ( ls_UnitNumber ) THEN
			
			ls_UnitNumber = ""
			
		END IF
		
		
		//IF we are supposed to prompt the user for information, do so.
		
		lb_DialogResults = FALSE	//Set the flag to false for this pass.  If everything succeeds, set to true.
		lb_UseShipmentValues = FALSE		//Set the flag to false for this pass.  If we determine that we should use
													//the unmodified shipment values, then this will be set to true.
		
		IF lb_Dialog THEN
			
			DO
				
				lb_Retry = FALSE  //If we run into a problem and the user wants to retry, will be flagged to true
										//which is checked in WHILE condition at the end of the loop.
			
				lds_Dialog.Reset ( )
				li_DialogRow = lds_Dialog.InsertRow ( 0 )   //Should come back 1
				
				IF li_DialogRow = 1 THEN
				
					lds_Dialog.Object.Recipient [ li_DialogRow ] = as_Recipient
					lds_Dialog.Object.UnitNumber [ li_DialogRow ] = ls_Unitnumber
					lds_Dialog.Object.EventDescription [ li_DialogRow ] = ls_EventDescription
					
					IF lb_HasShipment THEN
						
						//Set the shipment values into the dialog dataobject, so the user can see & approve / edit them.
						
						lds_Dialog.Object.Seal [ li_DialogRow ] = ls_Shipment_Seal
						lds_Dialog.Object.Vessel [ li_DialogRow ] = ls_Shipment_Vessel
						lds_Dialog.Object.Voyage [ li_DialogRow ] = ls_Shipment_Voyage
						lds_Dialog.Object.Booking [ li_DialogRow ] = ls_Shipment_Booking
						lds_Dialog.Object.OriginPort [ li_DialogRow ] = ls_Shipment_OriginPort
						lds_Dialog.Object.DestinationPort [ li_DialogRow ] = ls_Shipment_DestinationPort
						lds_Dialog.Object.WeightUnits [ li_DialogRow ] = ls_Shipment_WeightUnits
						lds_Dialog.Object.Weight [ li_DialogRow ] = ll_Shipment_Weight
						//Currently there is no shipment source of Remarks1 and Remarks2
						
					END IF
					
					OpenWithParm ( lw_Dialog, lds_Dialog )
					
					IF IsValid ( lds_Dialog ) THEN
						
						IF lds_Dialog.RowCount ( ) = 1 THEN
							
							//Populate the same string variable list that is otherwise populated from the shipment.
							//Values will not be trimmed in the dialog
							
							ls_Seal = Trim ( lds_Dialog.Object.Seal [ li_DialogRow ] )
							ls_Vessel = Trim ( lds_Dialog.Object.Vessel [ li_DialogRow ] )
							ls_Voyage = Trim ( lds_Dialog.Object.Voyage [ li_DialogRow ] )
							ls_Booking =  Trim ( lds_Dialog.Object.Booking [ li_DialogRow ] )
							ls_OriginPort = Trim ( lds_Dialog.Object.OriginPort [ li_DialogRow ] )
							ls_DestinationPort = Trim ( lds_Dialog.Object.DestinationPort [ li_DialogRow ] )
							ls_WeightUnits = Trim ( lds_Dialog.Object.WeightUnits [ li_DialogRow ] )
							ll_Weight = lds_Dialog.Object.Weight [ li_DialogRow ]
							ls_Remarks1 = Trim ( lds_Dialog.Object.Remarks1 [ li_DialogRow ] )
							ls_Remarks2 = Trim ( lds_Dialog.Object.Remarks2 [ li_DialogRow ] )
							
							lb_DialogResults = TRUE
							
						END IF
						
					END IF
					
				END IF
				
				//If we attempted a dialog, but did not get results, clear the values that may have been carried
				//forward from a previous pass through the loop.
				
				IF lb_DialogResults = FALSE THEN
					
					CHOOSE CASE MessageBox ( "EDI 322 Data", "There was a processing error related to the data dialog for "+&
							ls_UnitNumber + ".  You have the option to retry the processing.", Exclamation!, RetryCancel!, 1 )
							
						CASE 1
							
							lb_Retry = TRUE
							
						CASE 2
							
							lb_Retry = FALSE
							
						CASE ELSE  //Unexpected return
							
							lb_Retry = TRUE
							
					END CHOOSE
					
					
					IF lb_Retry = FALSE AND lb_HasShipment = TRUE THEN
						
						CHOOSE CASE MessageBox ( "EDI 322 Data", "Do you want to use the unedited values from the shipment?~n" +&
							"(If you say no, the blank data values will be sent for this equipment, so you should normally say Yes.)", &
							Question!, YesNo!, 1 )
							
						CASE 1
							
							lb_UseShipmentValues = TRUE
							
						CASE ELSE
							
							lb_UseShipmentValues = FALSE
							
						END CHOOSE
						
					END IF
					
				END IF
				
			LOOP WHILE lb_Retry = TRUE
			
		ELSEIF lb_HasShipment THEN

			//Since we're set to not use a dialog, but we have a shipment, use those values.
			lb_UseShipmentValues = TRUE
			
		END IF
		
		
		IF lb_UseShipmentValues = TRUE THEN
			
			ls_Booking = ls_Shipment_Booking
			ls_Seal = ls_Shipment_Seal
			ls_Vessel = ls_Shipment_Vessel
			ls_Voyage = ls_Shipment_Voyage
			ls_OriginPort = ls_OriginPort
			ls_DestinationPort = ls_Shipment_DestinationPort
			ls_WeightUnits = ls_Shipment_WeightUnits
			ll_Weight = ll_Shipment_Weight
			
		END IF
		


		//Begin building N7 record for this pass through the loop.

		ls_Segment = "N7"
		ls_Record = ls_Segment
	
		FOR li_Element = 1 TO 24
	
			ls_Record += as_Delimiter
	
			ls_Element = ls_Segment + String ( li_Element, "00" )
			ls_Data = ""
	
			CHOOSE CASE li_Element
	
			CASE 01  //Equipment Initial
	
				ls_Data = ls_Prefix
	
			CASE 02  //Equipment Number
	
				ls_Data = ls_Number
	
			CASE 03  //Weight

				IF ll_Weight > 0 THEN
					
					ls_Data = String ( ll_Weight )
					
				END IF
	
			CASE 04  //Weight Qualifier
				
				//Note:  I left this logic here rather than moving it earlier like the rest of the value 
				//roundup because I wasn't sure whether of_MapDataOut could be called earlier w.o. a problem.
				//I don't have any reason to believe it wouldn't be ok, but I did not want to risk a disruption.

				IF ll_Weight > 0 THEN   //ll_Weight still populated from previous element read
												//"N" = "Net", "G" = "Gross"
												
					IF lb_DialogResults THEN  //Added 3.9
						
						ls_Data = lds_Dialog.Object.WeightQualifier [ li_DialogRow ]
						
					ELSE

						IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
							ls_Data = lsa_Value[1]
						ELSE
							ls_Data = "G"
						END IF
						
					END IF

				END IF
	
	
			CASE 05  //Tare Weight
	
	
			CASE 06  //Weight Allowance
	
	
			CASE 07  //Dunnage
	
	
			CASE 08  //Volume
	
	
			CASE 09  //Volume Unit Qualifier
	
	
			CASE 10  //Ownership Code
	
	
			CASE 11  //Equipment Description Code

				IF li_ContainerCount > 0 THEN

					ls_Data = "CN"  //CN=Container

				ELSEIF li_ChassisCount > 0 THEN

					ls_Data = "CH"  //CH=Chassis (Bare Chassis)

				ELSE

					//Field is requied, and "CN" and "CH" are the only values in the definition I've seen.
					//So, we'll use the "container" label.
					ls_Data = "CN"

				END IF
	
	
			CASE 12  //SCAC  (of equipment owner)
	
	
			CASE 13  //Temperature Control
	
	
			CASE 14  //Position
	
	
			CASE 15  //Equipment Length  (for non-ISO equipment)
	
	
			CASE 16  //Tare Qualifier Code
	
	
			CASE 17  //Weight Unit Code
				
				IF Len ( ls_WeightUnits ) = 1 THEN  //Verify we have a legitimate value
					ls_Data = ls_WeightUnits
				END IF
	
			CASE 18  //Equipment Number Check Digit

				IF Len ( ls_Check ) = 1 THEN
					ls_Data = ls_Check
				END IF
	
	
			CASE 19  //Type of Service Code
	
	
			CASE 20  //Height (if non-standard)
	
	
			CASE 21  //Width
	
	
			CASE 22  //Equipment Type
	
	
			CASE 23  //SCAC  (of equipment operator responsible for moving the cargo)
	
	
			CASE 24  //Car Type Code  (rail car or intermodal equipment type)
	
		
			END CHOOSE
	
	
			IF IsNull ( ls_Data ) THEN
	
				ls_Data = ""
	
			ELSEIF Len ( ls_Data ) > 0 THEN
	
				//If delimiter occurs in the data, need to replace it with empty string.
				ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )
	
			END IF
	
			ls_Record += ls_Data
	
		NEXT  //li_Element  (N7)


		//Append Newline character(s) to the record.
		ls_Record += is_Newline

		//Append the record to the recordset
		ls_RecordSet += ls_Record


		//Build the DTM (Date/Time Reference) Record

		ls_Segment = "DTM"
		ls_Record = ls_Segment

		FOR li_Element = 1 TO 4

			ls_Record += as_Delimiter
	
			ls_Element = ls_Segment + String ( li_Element, "00" )
			ls_Data = ""


			CHOOSE CASE li_Element

			CASE 01  //Date/Time Qualifier

				ls_Data = "152"  //152=Effective Date of Change  -- From the 4010 doc, this is "standard"

			CASE 02  //Date

				ld_Date = ads_List.Object.Shipment_Status_Status_Date [ al_Row ]
				ls_Data = String ( ld_Date, "yyyymmdd" )

			CASE 03  //Time

				lt_Time = ads_List.Object.Shipment_Status_Status_Time [ al_Row ]
				ls_Data = String ( lt_Time, "hhmm" )

			CASE 04  //Time Code

				ls_Data = This.of_GetTZCode ( )  //Get the Time Code for base time.

			END CHOOSE


			IF IsNull ( ls_Data ) THEN
	
				ls_Data = ""
	
			ELSEIF Len ( ls_Data ) > 0 THEN
	
				//If delimiter occurs in the data, need to replace it with empty string.
				ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )
	
			END IF
	
			ls_Record += ls_Data
		
		NEXT  //li_Element (DTM)

		//Append Newline character(s) to the record.
		ls_Record += is_Newline

		//Append the record to the recordset
		ls_RecordSet += ls_Record



		//If a Seal # is specified, Build the M7 (Seal #) Record
		//(Note: If there are multiple containers and we're using the unedited shipment values, this will end up sending 
		//the same field contents attached to each piece of equipment.)

		IF Len ( ls_Seal ) > 0 THEN

			ls_Segment = "M7"
			ls_Record = ls_Segment
	
			FOR li_Element = 1 TO 1
	
				ls_Record += as_Delimiter
		
				ls_Element = ls_Segment + String ( li_Element, "00" )
				ls_Data = ""
	
	
				CHOOSE CASE li_Element
	
				CASE 01  //Seal Number  (15 char max)

					ls_Data = Left ( ls_Seal, 15 )

				END CHOOSE


				IF IsNull ( ls_Data ) THEN
		
					ls_Data = ""
		
				ELSEIF Len ( ls_Data ) > 0 THEN
		
					//If delimiter occurs in the data, need to replace it with empty string.
					ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )
		
				END IF

				ls_Record += ls_Data
		
			NEXT  //li_Element (M7)
	
			//Append Newline character(s) to the record.
			ls_Record += is_Newline
	
			//Append the record to the recordset
			ls_RecordSet += ls_Record

		END IF  //M7 (Seal # Present?)

		
		//If we're dealing with a bare chassis, this record is not used.

		IF li_ChassisCount > 0 AND li_ContainerCount = 0 THEN

			//Bare Chassis -- Skip this record.

		ELSE

			//Clear any chassis data from previous pass.

			ls_ChassisUnitNumber = ""
			ls_ChassisPrefix = ""
			ls_ChassisNumber = ""
			ls_ChassisCheck = ""

			//Determine if we're reporting a chassis for this equipment and if so get the data on it.
			//Only do this if our main equipment for this pass is a container, and we have a chassis.

			IF ls_Type = "C" AND li_ChassisCount > 0 THEN  

				//Increment the chassis index, provided we're not already pointing at the last chassis.
				//If we are pointing at the last chassis, use it again for this loop.

				IF li_ChassisIndex < li_ChassisCount THEN
					li_ChassisIndex ++
				END IF
		
				ls_ChassisUnitNumber = Upper ( Trim ( lnva_Chassis [ li_ChassisIndex ].of_GetNumber ( ) ) )
		
				IF Match ( ls_ChassisUnitNumber, "^[A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]" ) THEN
		
					ls_ChassisPrefix = Left ( ls_ChassisUnitNumber, 4 )
					ls_ChassisNumber = Mid ( ls_ChassisUnitNumber, 5, 6 )
		
					IF Len ( ls_ChassisUnitNumber ) > 10 THEN
		
						ls_ChassisCheck = Right ( ls_ChassisUnitNumber, 1 )
		
					END IF
		
				ELSE

					//ZIM condition added 4-4-03 3.5.25 BKW.  ZIM does not want "dummy" or non-standard chassis info.

					IF as_Recipient <> "ZIM" THEN
		
						ls_ChassisNumber = Left ( ls_ChassisUnitNumber, 10 )  //10 Character field limit
						ls_ChassisPrefix = "NONZ"  //ISA specification.   *This was ls_Prefix, fixed in 3.5.23 BKW*

					END IF
		
				END IF

			END IF


			ls_Segment = "W2"
			ls_Record = ls_Segment
	
			FOR li_Element = 1 TO 15
	
				ls_Record += as_Delimiter
		
				ls_Element = ls_Segment + String ( li_Element, "00" )
				ls_Data = ""
	
	
				CHOOSE CASE li_Element
	
				CASE 01  //Equipment Initial (Container Prefix)

					ls_Data = ls_Prefix

				CASE 02  //Equipment Number  (Container Number)

					ls_Data = ls_Number

				CASE 03  //Commodity Code


				CASE 04  //Equipment Description Code
							//The 4010 Docs on this that I have suggest that "CN" is the value to use,
							//but the corresponding examples, and other cross-references refer to "CC"
							//Another doc I have says "CC" = "Container on Chassis"
							//So, I'm going to use "CC" if I have a chassis, and "CN" if I don't.

//					IF ls_Type = "C" AND li_ChassisCount > 0 THEN		Changed condition 4-4-03 3.5.25 BKW
					IF ls_Type = "C" AND Len ( ls_ChassisNumber ) > 0 THEN

						ls_Data = "CC"

					ELSE

						ls_Data = "CN"

					END IF
					

				CASE 05  //Equipment Status Code

					ls_Data = ads_List.Object.Edi_Reason_Code [ al_Row ]


				CASE 06  //Net Tons


				CASE 07  //Intermodal Service Code


				CASE 08  //Car Service Order Code


				CASE 09  //Date  -- *This is paired with #10, not sure why*


				CASE 10  //Type of Locomotive Maintenance Code


				CASE 11  //Equipment Initial  (Chassis Prefix)

					ls_Data = ls_ChassisPrefix   //This value will be empty string if not determined above.

				CASE 12  //Equipment Number  (Chassis Number)

					ls_Data = ls_ChassisNumber   //This value will be empty string if not determined above.

				CASE 13  //Equipment Number Check Digit  (Chassis Check Digit)

					IF Len ( ls_ChassisCheck ) = 1 THEN
						ls_Data = ls_ChassisCheck
					END IF

				CASE 14  //Position


				CASE 15  //Car Type Code


				END CHOOSE
				
				
				IF IsNull ( ls_Data ) THEN
		
					ls_Data = ""
		
				ELSEIF Len ( ls_Data ) > 0 THEN
		
					//If delimiter occurs in the data, need to replace it with empty string.
					ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )
		
				END IF

				ls_Record += ls_Data
		
			NEXT  //li_Element (W2)
	
			//Append Newline character(s) to the record.
			ls_Record += is_Newline
	
			//Append the record to the recordset
			ls_RecordSet += ls_Record

		END IF  //W2 (If not bare chassis)


		//If a Vessel is specified, Build the V1 (Vessel Identification) Record
		//(Vessel is required in V1 record, so can't send voyage without vessel.)

		//3.5.25 : Added condition to not build this record if as_Recipient = "ZIM"
		//ZIM only wants vessel information if it has V101 vessel code (which must 
		//be the Lloyd's register code or the radio call sign, according to the EDI
		//specs, which the carrier is not likely to have, and does not have in Marex's
		//case.)  So, the current solution is just to turn this off for ZIM.

		IF Len ( ls_Vessel ) > 0 AND as_Recipient <> "ZIM" THEN  //Vessel, not voyage -- see note above.

			ls_Segment = "V1"
			ls_Record = ls_Segment
	
			FOR li_Element = 1 TO 4
	
				ls_Record += as_Delimiter
		
				ls_Element = ls_Segment + String ( li_Element, "00" )
				ls_Data = ""
	
	
				CHOOSE CASE li_Element
	
				CASE 01  //Vessel Code
					//Note : If 01 were specified, 08 would need to be provided, and is not currently

				CASE 02  //Vessel Name  (28 char max)

					ls_Data = Left ( ls_Vessel, 28 )

				CASE 03  //Country Code

				CASE 04  //Flight/Voyage Number  (10 char max)

					IF Len ( ls_Voyage ) > 0 THEN
						ls_Data = Left ( ls_Voyage, 10 )
					END IF

				END CHOOSE
				

				IF IsNull ( ls_Data ) THEN
		
					ls_Data = ""
		
				ELSEIF Len ( ls_Data ) > 0 THEN
		
					//If delimiter occurs in the data, need to replace it with empty string.
					ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )
		
				END IF

				ls_Record += ls_Data
		
			NEXT  //li_Element (V1)
	
			//Append Newline character(s) to the record.
			ls_Record += is_Newline
	
			//Append the record to the recordset
			ls_RecordSet += ls_Record

		END IF  //V1 (Vessel Info Present?)



		//Port of Origin and Destination are mandatory records  (R4)
		//If one of these entries is not specified, we will create the record anyway, with "NOT SPECIFIED"

		//BUT -- Zim told Marex they prefer them not to be included rather than sending NOT SPECIFIED, 
		//so I'm going to switch to that approach, beginning in 3.5.23  BKW

		IF Len ( ls_OriginPort ) > 0 THEN

			//R4 Loop 1 - Origin Terminal
	
			ls_Segment = "R4"
			ls_Record = ls_Segment
	
			FOR li_Element = 1 TO 4
	
				ls_Record += as_Delimiter
		
				ls_Element = ls_Segment + String ( li_Element, "00" )
				ls_Data = ""
	
	
				CHOOSE CASE li_Element
	
				CASE 01  //Port or Terminal Function Code
	
					ls_Data = "O"   //Origin Terminal  (not in my 4010 ISA list, but in Zim's and CN's list)
	
				CASE 02  //Location Qualifier
	
				CASE 03  //Location Identifier
	
				CASE 04  //Port Name
	
					//Note : 24 char field limit
	
					IF Len ( ls_OriginPort ) > 0 THEN
						ls_Data = Left ( ls_OriginPort, 24 )   //The Left function was not called here prior to 3.9
					ELSE
						ls_Data = "NOT SPECIFIED"
					END IF
	
				END CHOOSE
	
	
				IF IsNull ( ls_Data ) THEN
		
					ls_Data = ""
		
				ELSEIF Len ( ls_Data ) > 0 THEN
		
					//If delimiter occurs in the data, need to replace it with empty string.
					ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )
		
				END IF
	
				ls_Record += ls_Data
		
			NEXT  //li_Element (R4 Loop 1 - Origin)
	
			//Append Newline character(s) to the record.
			ls_Record += is_Newline
	
			//Append the record to the recordset
			ls_RecordSet += ls_Record

		END IF  //R4 Loop 1  (OriginPort present?)


		IF Len ( ls_DestinationPort ) > 0 THEN

			//R4 Loop 2 - Destination Terminal
	
			ls_Segment = "R4"
			ls_Record = ls_Segment
	
			FOR li_Element = 1 TO 4
	
				ls_Record += as_Delimiter
		
				ls_Element = ls_Segment + String ( li_Element, "00" )
				ls_Data = ""
	
	
				CHOOSE CASE li_Element
	
				CASE 01  //Port or Terminal Function Code
	
					ls_Data = "E"   //Destination Terminal
	
				CASE 02  //Location Qualifier
	
				CASE 03  //Location Identifier
	
				CASE 04  //Port Name
	
					//Note : 24 char field limit
	
					IF Len ( ls_DestinationPort ) > 0 THEN
						ls_Data = Left ( ls_DestinationPort, 24 )   //The Left function was not called here prior to 3.9
					ELSE
						ls_Data = "NOT SPECIFIED"
					END IF
	
				END CHOOSE
	
	
				IF IsNull ( ls_Data ) THEN
		
					ls_Data = ""
		
				ELSEIF Len ( ls_Data ) > 0 THEN
		
					//If delimiter occurs in the data, need to replace it with empty string.
					ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )
		
				END IF
	
				ls_Record += ls_Data
		
			NEXT  //li_Element (R4 Loop 1 - Origin)
	
			//Append Newline character(s) to the record.
			ls_Record += is_Newline
	
			//Append the record to the recordset
			ls_RecordSet += ls_Record

		END IF  //R4 Loop 2 (DesinationPort Present?)


		//The N1 Loop is used to provide identifying information about parties involved.
		//For now, we will only concern ourselves with N1*MC  (Motor Carrier)

		IF This.of_MapDataOut ( "N102*MC", lsa_Value ) > 0 THEN
			ls_N102 = lsa_Value[1]
		ELSE
			ls_N102 = ""
		END IF

		//N103 and N104 are a pair -- both values must be present in order to use them, 
		//so don't bother getting N104 if we don't have N103

		IF This.of_MapDataOut ( "N103*MC", lsa_Value ) > 0 THEN

			ls_N103 = lsa_Value[1]

			IF This.of_MapDataOut ( "N104*MC", lsa_Value ) > 0 THEN
				ls_N104 = lsa_Value[1]
			ELSE
				ls_N104 = ""
			END IF

		ELSE
			ls_N103 = ""
			ls_N104 = ""
		END IF
		

		IF Len ( ls_N102 ) > 0 OR ( Len ( ls_N103 ) > 0 AND Len ( ls_N104 ) > 0 ) THEN

			ls_Segment = "N1"
			ls_Record = ls_Segment
	
			FOR li_Element = 1 TO 4
	
				ls_Record += as_Delimiter
		
				ls_Element = ls_Segment + String ( li_Element, "00" )
				ls_Data = ""
	
	
				CHOOSE CASE li_Element
	
				CASE 01  //Entity Identifier Code

					ls_Data = "MC"

				CASE 02  //Name (Free-form name) (60 char max)

					IF Len ( ls_N102 ) > 0 THEN
						ls_Data = Left ( ls_N102, 60 )
					END IF

				CASE 03  //Identification Code Qualifier
							//"2" = SCAC, "93" = Sender defined, "94" = Receiver Defined, "ZZ" = Mutually Defined

					IF Len ( ls_N103 ) > 0 AND Len ( ls_N104 ) > 0 THEN
						ls_Data = ls_N103
					END IF

				CASE 04  //Identification Code

					IF Len ( ls_N103 ) > 0 AND Len ( ls_N104 ) > 0 THEN
						ls_Data = ls_N104
					END IF

				END CHOOSE


				IF IsNull ( ls_Data ) THEN
		
					ls_Data = ""
		
				ELSEIF Len ( ls_Data ) > 0 THEN
		
					//If delimiter occurs in the data, need to replace it with empty string.
					ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )
		
				END IF

				ls_Record += ls_Data
		
			NEXT  //li_Element (N1*MC - Motor Carrier Name)
	
			//Append Newline character(s) to the record.
			ls_Record += is_Newline
	
			//Append the record to the recordset
			ls_RecordSet += ls_Record

		END IF  //N1*MC (Motor carrier info present?)
		
		
		
		//If Remarks1 or Remarks2 is specified, Build the K1 (Remarks) Record
		
		IF Len ( ls_Remarks1 ) > 0 OR Len ( ls_Remarks2 ) > 0 THEN
			
			ls_Segment = "K1"
			ls_Record = ls_Segment
	
			FOR li_Element = 1 TO 2
				
				//Second element is optional.  If it's not there, we'll exit early.
				
				IF li_Element = 2 THEN
					
					IF Len ( ls_Remarks2 ) > 0 THEN
						//Ok, there's a 2nd value
					ELSE
						//There's no 2nd value, so don't write the delimiter or the 2nd element
						EXIT
					END IF
					
				END IF
				
	
				ls_Record += as_Delimiter
		
				ls_Element = ls_Segment + String ( li_Element, "00" )
				ls_Data = ""
	
	
				CHOOSE CASE li_Element
	
				CASE 01  //Free-Form Message 1  (30 char max)

					IF Len ( ls_Remarks1 ) > 0 THEN
						ls_Data = Left ( ls_Remarks1, 30 )
					END IF

				CASE 02  //Free-Form Message 2  (30 char max)

					IF Len ( ls_Remarks2 ) > 0 THEN
						ls_Data = Left ( ls_Remarks2, 30 )
					END IF

				END CHOOSE


				IF IsNull ( ls_Data ) THEN
		
					ls_Data = ""
		
				ELSEIF Len ( ls_Data ) > 0 THEN
		
					//If delimiter occurs in the data, need to replace it with empty string.
					ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )
		
				END IF

				ls_Record += ls_Data
		
			NEXT  //li_Element (K1 - Remarks)
	
			//Append Newline character(s) to the record.
			ls_Record += is_Newline
	
			//Append the record to the recordset
			ls_RecordSet += ls_Record

		END IF  //K1 (Remarks Present?)
		


		//If a Booking # is specified, Build the N9 (Reference #) Record for Booking#

		IF Len ( ls_Booking ) > 0 THEN

			ls_Segment = "N9"
			ls_Record = ls_Segment
	
			FOR li_Element = 1 TO 2
	
				ls_Record += as_Delimiter
		
				ls_Element = ls_Segment + String ( li_Element, "00" )
				ls_Data = ""
	
	
				CHOOSE CASE li_Element
	
				CASE 01  //Reference Identification Qualifier

					ls_Data = "BN"

				CASE 02  //Reference Identification  (30 char max)

					ls_Data = Left ( ls_Booking, 30 )

				END CHOOSE


				IF IsNull ( ls_Data ) THEN
		
					ls_Data = ""
		
				ELSEIF Len ( ls_Data ) > 0 THEN
		
					//If delimiter occurs in the data, need to replace it with empty string.
					ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )
		
				END IF

				ls_Record += ls_Data
		
			NEXT  //li_Element (N9 - Booking)
	
			//Append Newline character(s) to the record.
			ls_Record += is_Newline
	
			//Append the record to the recordset
			ls_RecordSet += ls_Record

		END IF  //N9 (Booking # Present?)



		//If this is an Ingate or Outgate (Q501="I" or "OA", respectively), Build the N9 (Reference #) Record for TIR#

		CHOOSE CASE ads_List.Object.Edi_Status_a_Code [ al_Row ]

		CASE "I", "OA"  //"I"=Ingate, "OA"=Outgate

			ls_Segment = "N9"
			ls_Record = ls_Segment
	
			FOR li_Element = 1 TO 2
	
				ls_Record += as_Delimiter
		
				ls_Element = ls_Segment + String ( li_Element, "00" )
				ls_Data = ""
	
	
				CHOOSE CASE li_Element
	
				CASE 01  //Reference Identification Qualifier

					ls_Data = "TI"

				CASE 02  //Reference Identification  (30 char max)

					//We're going to use the event id as the TIR #
					ls_Data = String ( ads_List.Object.Shipment_Status_EventID [ al_Row ] )

				END CHOOSE


				IF IsNull ( ls_Data ) THEN
		
					ls_Data = ""
		
				ELSEIF Len ( ls_Data ) > 0 THEN
		
					//If delimiter occurs in the data, need to replace it with empty string.
					ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )
		
				END IF

				ls_Record += ls_Data
		
			NEXT  //li_Element (N9 - TIR #)
	
			//Append Newline character(s) to the record.
			ls_Record += is_Newline
	
			//Append the record to the recordset
			ls_RecordSet += ls_Record

		END CHOOSE  //N9 (Ingate or Outage: needs TIR?)


	NEXT  //li_N7Loop

END IF



IF li_Return = 1 THEN

	as_Record = ls_RecordSet

ELSE

	as_Record = ""

END IF


//Clean up the equipment array we created  (lnva_Equipment).
//This will take lnva_Containers[], lnva_Chassis[], lnva_N7Equip[] with it, 
//since those are references to the same objects.

FOR ll_Index = 1 TO li_EquipmentCount

	DESTROY lnva_Equipment [ ll_Index ]

NEXT

DESTROY lds_Dialog

RETURN li_Return
end function

protected function integer of_buildrecord_se (string as_delimiter, long al_segmentcount, string as_controlnumber, ref string as_record);//Build the SE (Transaction Set Trailer) Record

String	ls_Record

Integer	li_Return = 1


IF li_Return = 1 THEN

	ls_Record = "SE" + as_Delimiter + String ( al_SegmentCount ) + as_Delimiter + as_ControlNumber + is_Newline

END IF


IF li_Return = 1 THEN

	as_Record = ls_Record

ELSE

	as_Record = ""

END IF

RETURN li_Return
end function

protected function integer of_buildrecord_st (string as_recipient, string as_delimiter, string as_controlnumber, ref string as_record);//Build the ST (Transaction Set Header) Record

String	ls_Record

Integer	li_Return = 1


IF li_Return = 1 THEN

	ls_Record = "ST" + as_Delimiter + "322" + as_Delimiter + as_ControlNumber + is_Newline

END IF


IF li_Return = 1 THEN

	as_Record = ls_Record

ELSE

	as_Record = ""

END IF

RETURN li_Return
end function

protected function integer of_buildrecord_isa (string as_recipient, string as_delimiter, long al_control, ref string as_record);//Build the ISA header record.

String	ls_Record, &
			ls_Segment = "ISA", &
			ls_Element, &
			ls_Data, &
			lsa_Value[]
Integer	li_Element

n_cst_String	lnv_String


Integer	li_Return = 1



IF li_Return = 1 THEN

	ls_Record = ls_Segment

	FOR li_Element = 1 TO 16

		ls_Record += as_Delimiter

		ls_Element = ls_Segment + String ( li_Element, "00" )
		ls_Data = ""

		CHOOSE CASE li_Element

		CASE 01  //Authorization Information Qualifier

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = lsa_Value[1]
			ELSE
				ls_Data = "00"
			END IF

		CASE 02	//Authorization Information  (10 char min/max)

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = lnv_String.of_PadRight ( Left ( lsa_Value [ 1 ], 10 ), 10 )
			ELSE
				ls_Data = Space ( 10 )
			END IF

		CASE 03	//Security Information Qualifier

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = lsa_Value[1]
			ELSE
				ls_Data = "00"
			END IF

		CASE 04	//Security Information  (10 char min/max)

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = lnv_String.of_PadRight ( Left ( lsa_Value [ 1 ], 10 ), 10 )
			ELSE
				ls_Data = Space ( 10 )
			END IF

		CASE 05	//Interchange ID Qualifier (Sender)  (2 char min/max)

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = lsa_Value[1]
			ELSE
				ls_Data = "00"  //This value should be specified for real, however.
			END IF

		CASE 06	//Interchange Sender ID  (15 char min/max)

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = lnv_String.of_PadRight ( Left ( lsa_Value [ 1 ], 15 ), 15 )
			ELSE
				ls_Data = Space ( 15 )
			END IF

		CASE 07	//Interchange ID Qualifier (Receiver)

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = lsa_Value[1]
			ELSE
				ls_Data = "00"  //This value should be specified for real, however.
			END IF

		CASE 08	//Interchange Receiver ID  (15 char min/max)

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = lnv_String.of_PadRight ( Left ( lsa_Value [ 1 ], 15 ), 15 )
			ELSE
				ls_Data = lnv_String.of_PadRight ( Left ( as_Recipient, 15 ), 15 )
			END IF

		CASE 09	//Interchange Date

			ls_Data = String ( Today ( ), "yymmdd" )

		CASE 10	//Interchange Time

			ls_Data = String ( Now ( ), "hhmm" )

		CASE 11	//Interchange Control Standards Identifier

			ls_Data = "U"

		CASE 12	//Interchange Control Version Number

			ls_Data = "00401"

		CASE 13	//Interchange Control Number  (9 char min/max)

			ls_Data = String ( al_Control, "000000000" )

		CASE 14	//Acknowledgement Requested  ("0" = No)

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = lsa_Value[1]
			ELSE
				ls_Data = "0"
			END IF

		CASE 15	//Test Indicator  ("P" for Production, "T" for Test)

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = lsa_Value[1]
			ELSE
				ls_Data = "P"  //Default to "Production" unless specified as "Test"
			END IF

		CASE 16	//Subelement Separator

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = lsa_Value[1]
			ELSE
				ls_Data = ">"  //Standard Default
			END IF

		END CHOOSE


		IF IsNull ( ls_Data ) THEN

			ls_Data = ""

//		For most records, we check that the delimiter is not in the data, but that shouldn't happen here.
//
//		ELSEIF Len ( ls_Data ) > 0 THEN
//
//			//If delimiter occurs in the data, need to replace it with empty string.
//			ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )

		END IF

		ls_Record += ls_Data

	NEXT

END IF


IF li_Return = 1 THEN

	//Append Newline character(s) to the record.
	ls_Record += is_Newline

	as_Record = ls_Record

ELSE

	as_Record = ""

END IF


RETURN li_Return
end function

protected function integer of_buildrecord_gs (string as_recipient, string as_delimiter, long al_control, ref string as_record);//Build the GS group header record.

String	ls_Record, &
			ls_Segment = "GS", &
			ls_Element, &
			ls_Data, &
			lsa_Value[]
Integer	li_Element


Integer	li_Return = 1



IF li_Return = 1 THEN

	ls_Record = ls_Segment

	FOR li_Element = 1 TO 8

		ls_Record += as_Delimiter

		ls_Element = ls_Segment + String ( li_Element, "00" )
		ls_Data = ""

		CHOOSE CASE li_Element

		CASE 01  //Functional Id (for this transaction set)

			ls_Data = "SO"  //"SO" Defined in ISA guide.

		CASE 02	//Sender Code  (2/15 min/max)

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = Left ( lsa_Value[1], 15 )
			END IF

		CASE 03	//Receiver Code  (2/15 min/max)

			IF This.of_MapDataOut ( ls_Element, lsa_Value ) > 0 THEN
				ls_Data = Left ( lsa_Value[1], 15 )
			ELSE
				ls_Data = Left ( as_Recipient, 15 )
			END IF

		CASE 04	//Transmission Date (Group)  (8/8 min/max)

			ls_Data = String ( Today ( ), "yyyymmdd" )

		CASE 05	//Transmission Time (Group)  (4/4 min/max)

			ls_Data = String ( Now ( ), "hhmm" )

		CASE 06	//Control Number (1/9 min/max)

			ls_Data = String ( al_Control )

		CASE 07	//Standard Type

			ls_Data = "X"  //"X" = "ANSI Standard"

		CASE 08	//Version / Release

			ls_Data = "004010"

		END CHOOSE


		IF IsNull ( ls_Data ) THEN

			ls_Data = ""

//		For most records, we check that the delimiter is not in the data, but that shouldn't happen here.
//
//		ELSEIF Len ( ls_Data ) > 0 THEN
//
//			//If delimiter occurs in the data, need to replace it with empty string.
//			ls_Data = lnv_String.of_GlobalReplace ( ls_Data, as_Delimiter, "" )

		END IF

		ls_Record += ls_Data

	NEXT

END IF


IF li_Return = 1 THEN

	//Append Newline character(s) to the record.
	ls_Record += is_Newline

	as_Record = ls_Record

ELSE

	as_Record = ""

END IF


RETURN li_Return
end function

protected function string of_gettzcode (integer ai_timezone);//Convert the Profit Tools time zone to a Time Code

//For Profit Tools, Pacific is 2 and Eastern is 5.

String	ls_Return

CHOOSE CASE ai_TimeZone

CASE 0  //Hawaii
	ls_Return = "HT"

CASE 1  //Alaska
	ls_Return = "AT"

CASE 2  //Pacific
	ls_Return = "PT"

CASE 3  //Mountain
	ls_Return = "MT"

CASE 4  //Central
	ls_Return = "CT"

CASE 5  //Eastern
	ls_Return = "ET"

CASE 6  //Atlantic
	ls_Return = "TT"

CASE ELSE
	ls_Return = "LT"  //Local time

END CHOOSE


RETURN ls_Return
end function

protected function string of_gettzcode ();//Returns the Time Code identifier for the home time zone

n_cst_LicenseManager	lnv_LicenseManager

String ls_Return

ls_Return = This.of_GetTZCode ( lnv_LicenseManager.of_GetBaseTimeZone ( ) )

RETURN ls_Return
end function

public function integer of_sendforcompany (long al_coid);//changed by dan 5-16-06

Integer	li_InputFile

long		ll_row, &
			ll_rowcount, &
			ll_ediid, &
			lla_Coid[], &
			ll_CompanyCount, &
			ll_Index, &
			ll_Count
			
Long	ll_EventID
string	ls_filter, &
			ls_outputfolder, &
			ls_outputfile, &
			ls_templatefile, &
			ls_value, &
			ls_error, &
			ls_ControlNumber, &
			lsa_Transaction[], &
			lsa_Blank[], &
			lsa_Results[], &
			lsa_TemplateArray[], &
			lsa_TemplateHeader[], &
			lsa_TemplateFooter[]

Long	   lla_ids[]
boolean	lb_error

n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_sql			lnv_Sql
n_ds					lds_edistatus
s_parm 				lstr_parm	
n_cst_msg			lnv_tagmessage, &
						lnv_BlankMessage
				
Int	li_Test
lds_edistatus = this.of_GetEDICache(true)


ls_controlnumber = this.of_GetControlNumber()

ls_Filter = "sourceCo = " + String ( al_coid ) + " AND messagestatus = " + String (n_cst_bso_edimanager_322.ci_MessageStatus_Pending )

li_Test = lds_edistatus.setfilter(ls_filter)
li_Test = lds_edistatus.filter()

ll_rowcount = lds_edistatus.rowcount()

IF ll_Rowcount <= 0 THEN
	RETURN 0
END IF

THIS.of_Setedicompanyid( al_coid )
	
		
ls_outputfolder = this.of_GetOutputFolder( appeon_constant.cl_transaction_set_322, al_coid, "OUTBOUND" )

if len(trim(ls_outputfolder)) > 0 then
	//ok
else
	if this.of_getsystemfilepath("EDI322", ls_outputfolder) = 1 then
		//ok
	else
		lb_error = true
		ls_error = "No output folder in company profile or system settings. Message not sent"
	end if
end if
		

//get the file	
ls_templatefile = this.of_GetTemplateFile( appeon_constant.cl_transaction_set_322, al_coid, "OUTBOUND" )
	
//Read template file and load into array
if FileExists ( ls_templatefile ) then	
	//input file, read
	li_InputFile = FileOpen(ls_templatefile, LineMode!, Read!, Shared!)
	THIS.of_loadtemplateintoarray( li_InputFile , lsa_TemplateArray, lsa_TemplateHeader, lsa_TemplateFooter )
	Fileclose(li_InputFile)
END IF


	
//get all the events that we will try to send the first time
FOR ll_index = 1 TO ll_rowcount
	lla_ids[ll_index] = lds_edistatus.GetItemNumber  ( ll_index , "eventid" )
NEXT
	
this.of_sendtransaction( lla_ids )


return 1



/*old working code
Integer	li_InputFile

long		ll_row, &
			ll_rowcount, &
			ll_ediid, &
			lla_Coid[], &
			ll_CompanyCount, &
			ll_Index, &
			ll_Count
			
Long	ll_EventID
string	ls_filter, &
			ls_outputfolder, &
			ls_outputfile, &
			ls_templatefile, &
			ls_value, &
			ls_error, &
			ls_ControlNumber, &
			lsa_Transaction[], &
			lsa_Blank[], &
			lsa_Results[], &
			lsa_TemplateArray[], &
			lsa_TemplateHeader[], &
			lsa_TemplateFooter[]

boolean	lb_error

n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_sql			lnv_Sql
n_ds					lds_edistatus
s_parm 				lstr_parm	
n_cst_msg			lnv_tagmessage, &
						lnv_BlankMessage
				
Int	li_Test
lds_edistatus = this.of_GetEDICache(true)


ls_controlnumber = this.of_GetControlNumber()

ls_Filter = "sourceCo = " + String ( al_coid ) + " AND messagestatus = " + String (n_cst_bso_edimanager_322.ci_MessageStatus_Pending )

li_Test = lds_edistatus.setfilter(ls_filter)
li_Test = lds_edistatus.filter()

ll_rowcount = lds_edistatus.rowcount()

IF ll_Rowcount <= 0 THEN
	RETURN 0
END IF

THIS.of_Setedicompanyid( al_coid )
	
		
ls_outputfolder = this.of_GetOutputFolder( appeon_constant.cl_transaction_set_322, al_coid )

if len(trim(ls_outputfolder)) > 0 then
	//ok
else
	if this.of_getsystemfilepath("EDI322", ls_outputfolder) = 1 then
		//ok
	else
		lb_error = true
		ls_error = "No output folder in company profile or system settings. Message not sent"
	end if
end if
		

//get the file	
ls_templatefile = this.of_GetTemplateFile( appeon_constant.cl_transaction_set_322, al_coid )
	
//Read template file and load into array
if FileExists ( ls_templatefile ) then	
	//input file, read
	li_InputFile = FileOpen(ls_templatefile, LineMode!, Read!, Shared!)
	THIS.of_loadtemplateintoarray( li_InputFile , lsa_TemplateArray, lsa_TemplateHeader, lsa_TemplateFooter )
	Fileclose(li_InputFile)
END IF

	
	
//loop thru all rows for this company
for ll_row = 1 to ll_rowcount
	
	lb_error = false
	ls_error = ''
	lsa_transaction = lsa_blank
	lnv_tagmessage = lnv_BlankMessage			

	
	ll_EventID = lds_edistatus.GetItemNumber  ( ll_row , "eventid" ) 
	THIS.of_Loadevent( ll_EventID )
	
	//THIS.li_edicoid = al_coid // li_EDICode is a misnamed instance var.
	THIS.of_SetEDIcompanyid( al_coid )			
		

	inv_Shipment.of_Setcontextcompany( al_coid ) // this is used to resolve aliases (i thought I had put this in once before but I Guess not)
	inv_Event.of_Setcontextcompany( ) // this is used to resolve aliases (i thought I had put this in once before but I Guess not)
		
	lstr_parm.is_Label = "STATUS"
	ls_value = lds_edistatus.GetItemString ( ll_row , "status" )
	if isnull(ls_value) then
		ls_value = ''
	end if
	lstr_Parm.ia_Value = ls_value
	lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
	
	lstr_parm.is_Label = "OWNERSSCAC"
//	ls_value = lds_edistatus.GetItemString ( ll_row , "status" )
	if isnull(ls_value) then
		ls_value = ''
	end if
	lstr_Parm.ia_Value = ls_value
	lnv_TagMessage.of_Add_Parm ( lstr_Parm )


	lstr_parm.is_Label = "ISOCODE"
//	ls_value = lds_edistatus.GetItemString ( ll_row , "status" )
	if isnull(ls_value) then
		ls_value = ''
	end if
	lstr_Parm.ia_Value = ls_value
	lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
	lstr_parm.is_Label = "ISOCODE"
//	ls_value = lds_edistatus.GetItemString ( ll_row , "status" )
	if isnull(ls_value) then
		ls_value = ''
	end if
	lstr_Parm.ia_Value = ls_value
	lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	


	//Set additional tag values 
	this.of_GetHeaderFooterTags(lnv_TagMessage)

	lstr_parm.is_Label = "CONTROLNUMBER"
	lstr_Parm.ia_Value = ls_controlnumber
	lnv_TagMessage.of_Add_Parm ( lstr_Parm )	

	lstr_parm.is_Label = "TRANSACTIONCONTROLNUMBER"
	lstr_Parm.ia_Value = string(ll_row, '0000')
	lnv_TagMessage.of_Add_Parm ( lstr_Parm )	

		
	if ll_row = 1 then 
		//start with header
		THIS.of_Processloop( lsa_TemplateHeader , lsa_transaction , lnv_TagMessage , inv_Event )
		ll_count = upperbound(lsa_transaction)
		for ll_index = 1 to ll_count
			lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
		next			
	end if
	
	THIS.of_Processloop( lsa_TemplateArray , lsa_transaction , lnv_TagMessage , inv_Event )
	//move to the results array
	ll_count = upperbound(lsa_transaction)
	for ll_index = 1 to ll_count
		lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
	next
	
	lds_edistatus.SetItem ( ll_Row , "MessageStatus" , n_cst_bso_edimanager_322.ci_MessageStatus_Processed )
			
next
//end of rows for this company
	
	
//processloopelements
THIS.of_Processloop( lsa_TemplateFooter , lsa_transaction , lnv_TagMessage , inv_Event )
ll_count = upperbound(lsa_transaction)
for ll_index = 1 to ll_count
	lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
next			

//create results file
if len(trim(ls_outputfile)) = 0 then
	if isvalid(lnv_TagMessage) then
		IF lnv_TagMessage.Of_Get_Parm ( "CONTROLNUMBER" , lstr_Parm ) <> 0 THEN
			ls_controlnumber = string(lstr_Parm.ia_Value)
		END IF
	
	end if
	ls_outputfile = ls_controlnumber + THIS.of_getOutboundfileextension( )
end if

ls_outputfile = ls_outputfolder + "\" + ls_outputfile

THIS.of_Writeresultstofile( lsa_Results , ls_outputfile )



//this.of_updateedicache( )  // update done by calling function


return 1

*/
end function

public function n_ds of_getedicache (boolean ab_retrieve);// ids_Cache is set by of_SetCache. Which is called by n_cst_bso_edimanager_322.of_ProcessPending()

RETURN ids_Cache
end function

public function integer of_loadevent (long al_eventid);n_cst_beo_Event	lnva_EmptyEvents[], &
						lnv_Event
n_cst_beo_Item		lnva_EmptyItems[]

integer	li_Return = 1

if isvalid(inv_dispatch) then
	//already created, will be destroyed in tbe destructor
else
	inv_dispatch = create n_cst_bso_dispatch
end if

if li_return = 1 then

	DESTROY ( inv_Shipment )
	
	inva_Event = lnva_EmptyEvents
	inva_Item = lnva_EmptyItems
	
	IF NOT IsNull ( al_EventId ) THEN

		IF inv_Dispatch.of_RetrieveEvents ( { al_EventId } ) = 1 THEN
			
			ids_EventCache = inv_Dispatch.of_GetEventCache ( )		
			lnv_Event = CREATE n_cst_beo_Event
			lnv_Event.of_SetSource ( ids_EventCache )
			lnv_Event.of_SetSourceId ( al_EventId )
			if inv_Dispatch.of_RetrieveShipment( lnv_Event.of_GetShipment() ) = 1 then
				ids_Shipment = inv_Dispatch.of_GetShipmentCache ( )
				ids_ItemCache = inv_Dispatch.of_GetItemCache ( )
				inv_Shipment = CREATE n_cst_beo_Shipment
				inv_Shipment.of_SetSource ( ids_Shipment )
				inv_Shipment.of_SetSourceId ( lnv_Event.of_GetShipment() )

				//nwl added 11/02/04
				inv_Shipment.of_SetEventSource ( ids_EventCache )
				inv_Shipment.of_SetItemSource ( ids_ItemCache )
				//
				
				lnv_Event.of_SetShipment(inv_Shipment)
			end if
			
			inva_Event [ 1 ] = lnv_Event
			inv_Event = lnv_Event	//Note: This variable existed prior to 3.5.23, but nothing 
											//prior to 3.5.23 that I could see was populating it.
		
		ELSE
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF

end if

return li_return

end function

public function integer of_setcache (datastore ads_cache);ids_cache = ads_cache
RETURN 1
end function

protected function string of_getoutboundmappingfile ();Long	ll_RowCount
String	ls_File
Long	ll_CoID

DataStore	lds_Mappings
lds_Mappings = CREATE DataStore
lds_Mappings.DataObject = "d_mappingfiles"
lds_Mappings.SetTransobject ( SQLCA )


ll_CoID = THIS.of_Getedicompanyid( )

IF ll_CoID > 0 THEN

	ll_RowCount = lds_Mappings.Retrieve ( ll_CoID , 322 )
	
	IF ll_RowCount> 0 THEN
		
		ls_File = lds_Mappings.GetItemString ( 1 , "MappingFile" )
		
	END IF

END IF

DESTROY ( lds_Mappings )

RETURN ls_File
end function

protected function string of_getidcolname ();return "eventid"
end function

public subroutine of_sendtransaction (long ala_id[]);//implemented by dan 5-16-06 

Integer	li_InputFile
Int		li_continue = 1

long		ll_row, &
			ll_rowcount, &
			ll_ediid, &
			lla_Coid[], &
			ll_CompanyCount, &
			ll_Index, &
			ll_Count
Long		ll_subsetindex2			//added 10-6-06
			
Long	ll_EventID
string	ls_filter, &
			ls_outputfolder, &
			ls_outputfile, &
			ls_templatefile, &
			ls_value, &
			ls_error, &
			ls_ControlNumber, &
			lsa_Transaction[], &
			lsa_Blank[], &
			lsa_Results[], &
			lsa_TemplateArray[], &
			lsa_TemplateHeader[], &
			lsa_TemplateFooter[]

Long	   lla_ids[]
boolean	lb_error

Long	ll_subSize
Long	ll_subIndex
Long	lla_idSubset1[]
Long	lla_idSubset2[]

n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_sql			lnv_Sql
n_ds					lds_edistatus
s_parm 				lstr_parm	
n_cst_msg			lnv_tagmessage, &
						lnv_BlankMessage
				
Long					ll_coId

lds_edistatus = this.of_GetEDICache(true)

ll_coId = this.of_getEdicompanyid( )
ls_controlnumber = this.of_GetControlNumber()

//filter the cache down to just the event ids that are being sent.
ls_Filter = "sourceCo = " + String ( ll_coid ) + " AND messagestatus = " + String (n_cst_bso_edimanager_322.ci_MessageStatus_Pending )+ " AND eventid "+lnv_sql.of_makeinclause( ala_id )

lds_edistatus.setfilter(ls_filter)
lds_edistatus.filter()

ll_rowcount = lds_edistatus.rowcount()

IF ll_Rowcount <= 0 THEN
	li_continue = 0
END IF

IF li_continue = 1 THEN
			
	ls_outputfolder = this.of_GetOutputFolder( appeon_constant.cl_transaction_set_322, ll_coid, "OUTBOUND" )
	
	if len(trim(ls_outputfolder)) > 0 then
		//ok
	else
		if this.of_getsystemfilepath("EDI322", ls_outputfolder) = 1 then
			//ok
		else
			lb_error = true
			ls_error = "No output folder in company profile or system settings. Message not sent"
		end if
	end if
			
	
	//get the file	
	ls_templatefile = this.of_GetTemplateFile( appeon_constant.cl_transaction_set_322, ll_coid, "OUTBOUND" )
		
	//Read template file and load into array
	if FileExists ( ls_templatefile ) then	
		//input file, read
		li_InputFile = FileOpen(ls_templatefile, LineMode!, Read!, Shared!)
		THIS.of_loadtemplateintoarray( li_InputFile , lsa_TemplateArray, lsa_TemplateHeader, lsa_TemplateFooter )
		Fileclose(li_InputFile)
	END IF
	
	
	ll_rowCount = upperBound( ala_id )
	
	//loop thru all rows for this company
	for ll_row = 1 to ll_rowcount
		
		lb_error = false
		ls_error = ''
		lsa_transaction = lsa_blank
		lnv_tagmessage = lnv_BlankMessage			
	
		
		ll_EventID = lds_edistatus.GetItemNumber  ( ll_row , "eventid" ) 
		THIS.of_Loadevent( ll_EventID )
		
		//THIS.li_edicoid = al_coid // li_EDICode is a misnamed instance var.
		//THIS.of_SetEDIcompanyid( al_coid )		called above	
		
		inv_Shipment.of_Setcontextcompany( ll_coid ) // this is used to resolve aliases (i thought I had put this in once before but I Guess not)
		inv_Event.of_Setcontextcompany( ll_coid ) // this is used to resolve aliases (i thought I had put this in once before but I Guess not)
		
		lstr_parm.is_Label = "STATUS"
		ls_value = lds_edistatus.GetItemString ( ll_row , "status" )
		if isnull(ls_value) then
			ls_value = ''
		end if
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
		
		
		lstr_parm.is_Label = "OWNERSSCAC"
	//	ls_value = lds_edistatus.GetItemString ( ll_row , "status" )
		if isnull(ls_value) then
			ls_value = ''
		end if
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
	
		lstr_parm.is_Label = "ISOCODE"
	//	ls_value = lds_edistatus.GetItemString ( ll_row , "status" )
		if isnull(ls_value) then
			ls_value = ''
		end if
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
		
		lstr_parm.is_Label = "ISOCODE"
	//	ls_value = lds_edistatus.GetItemString ( ll_row , "status" )
		if isnull(ls_value) then
			ls_value = ''
		end if
		lstr_Parm.ia_Value = ls_value
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )
		
	
	
		//Set additional tag values 
		this.of_GetHeaderFooterTags(lnv_TagMessage)
	
		lstr_parm.is_Label = "CONTROLNUMBER"
		lstr_Parm.ia_Value = ls_controlnumber
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
		
		//DEK 5-23-07 NEW TAG
		lstr_parm.is_Label = "CONTROLNUMBERNOLEADINGZEROS"
		lstr_Parm.ia_Value = STRING(LONG(ls_controlnumber))
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
	
		lstr_parm.is_Label = "TRANSACTIONCONTROLNUMBER"
		lstr_Parm.ia_Value = string(ll_row, '0000')
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )	
	
			
		if ll_row = 1 then 
			//start with header
			THIS.of_Processloop( lsa_TemplateHeader , lsa_transaction , lnv_TagMessage , inv_Event )
			ll_count = upperbound(lsa_transaction)
			for ll_index = 1 to ll_count
				lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
			next			
		end if
		
		THIS.of_Processloop( lsa_TemplateArray , lsa_transaction , lnv_TagMessage , inv_Event )
		//move to the results array
		ll_count = upperbound(lsa_transaction)
		for ll_index = 1 to ll_count
			lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
		next
		
		lds_edistatus.SetItem ( ll_Row , "MessageStatus" , n_cst_bso_edimanager_322.ci_MessageStatus_Processed )
			
	next
	//end of rows for this company
		

	//processloopelements
	THIS.of_Processloop( lsa_TemplateFooter , lsa_transaction , lnv_TagMessage , inv_Event )
	ll_count = upperbound(lsa_transaction)
	for ll_index = 1 to ll_count
		lsa_Results[upperbound(lsa_results) + 1] = lsa_Transaction[ll_index]
	next			
	
	//create results file
	if len(trim(ls_outputfile)) = 0 then
		if isvalid(lnv_TagMessage) then
			IF lnv_TagMessage.Of_Get_Parm ( "CONTROLNUMBER" , lstr_Parm ) <> 0 THEN
				ls_controlnumber = string(lstr_Parm.ia_Value)
			END IF
		
		end if
		//gets the edi file name from the schema if it has one otherwise does the old way
		ls_outputFile = this.of_getEditransactionfilename( inv_event, ls_controlNumber )
		IF isNull( ls_outputFile ) OR ls_outputfile = "" THEN
			ls_outputfile = ls_controlnumber + this.of_GetOutboundfileextension( )
		END IF
	end if
	
	ls_outputfile = ls_outputfolder + "\" + ls_outputfile
	
	IF THIS.of_Writeresultstofile( lsa_Results , ls_outputfile ) = -2 THEN
	
		//have to reset to pending
		IF ll_rowCount > 1 THEN
			//if more then one event left, i must set it to pending so i can try to split the ids and send them again.
			FOR ll_row = 1 TO ll_rowCount
				lds_edistatus.SetItem ( ll_Row , "MessageStatus" , n_cst_bso_edimanager_322.ci_MessageStatus_Pending )
			NEXT
		END IF
	
		ll_subSize = upperBound( ala_id ) 
		
		IF ll_subSize = 1 THEN
			//then we exit because we found a bad event
			//if there is only 1 left and it failed validation, then i want to set the status to failed for that event id.
			IF ll_rowCount = 1 THEN
				lds_edistatus.SetItem ( 1 , "MessageStatus" , -1 ) //failed?
			END IF
		ELSE
			//split the ids and resend for each.
			FOR ll_subIndex = 1 TO ll_subSize		
				IF ll_subIndex <= (ll_subSize/2) THEN
					lla_idSubset1[ll_subIndex] = ala_id[ll_subIndex]
				ELSE
					ll_subsetindex2 = ll_subSize/2		//changed because of index error on 10-6-06, thought i did this once long ago
					lla_idSubset2[ll_subIndex - ll_subsetindex2] = ala_id[ll_subIndex]
				END IF
			NEXT
		END IF
		
		IF upperBound( lla_idSubset1 )  > 0 THEN
			this.of_sendTransaction( lla_idSubset1 )
		END IF
		
		IF upperBound( lla_idSubset2 ) > 0 THEN
			this.of_sendTransaction( lla_idSubset2 )
		END IF
	
	END IF
	//this.of_updateedicache( )  // update done by calling function
	
END IF
end subroutine

public function string of_geterrorcontext (long ala_ids[]);//Dan 5-17-06 Only returns an error if there is one  id.  Returns null otherwise.
//...Uses d_322Status
String	ls_null
String	ls_return
SetNull( ls_null )
n_ds		lds_cache
Long		ll_max
Long		ll_index

Long		ll_coId				//to resolve company name
Long		ll_eventId		//to resolve shipment
String	ls_Status		//to resolve the definition from edi_status table.

Long		ll_shipId

String	ls_companyName

String	ls_find

String	ls_ship
String	ls_companyError
String	ls_event
String	ls_statusMessage


ls_return = String(Today(), "m/d/yy hh:mm")+"~r~n322 could not be sent. Problem Related to: ~r~n"

//Since the 322 tries to keep sending events by splitting the ids in half over and over,
//until only one event doesn't go, we don't want an error message to be logged if there
//is more then one id.  
IF upperBound( ala_ids ) = 1 THEN
	lds_cache = this.of_getEdicache( FALSE )
	
	IF isValid( lds_cache ) THEN
		ll_max = lds_cache.rowCount()
		
		ls_find = "eventid = "+ string( ala_ids[1] )
		
		ll_index = lds_cache.find( ls_find, 1, ll_max )
		
		IF ll_index > 0 THEN
			ll_shipId = inv_shipment.of_getid( )		//not sure if this is right
			ll_eventId = lds_cache.getItemNumber( ll_index, "eventid" )
			ls_status = lds_cache.getItemString( ll_index, "status" )
			ll_coId = lds_cache.getItemNumber( ll_index, "sourceco" )
			
			IF not Isnull( ll_shipId ) THEN
				ls_ship = "Shipment: "+ string( ll_shipId )
			ELSE
				ls_ship = "Shipment: null"
			END IF
			
			
			//get the company name.
			SELECT co_name
				 	INTO :ls_companyName
				 	FROM "companies"  
					WHERE "companies"."co_id" = :ll_coid;
			COMMIT;
			
			
			CHOOSE CASE SQLCA.sqlcode
				CASE 100
					//not found
					ls_companyError ="Company Name: not found"
				CASE -1
					//error
					ls_companyError ="Company Name: error retrieving company name."
				CASE 0
					//success
					ls_companyError ="Company Name: "+ ls_companyName
			END CHOOSE
				
			if NOT iSnULL( ll_eventId ) then
				ls_event = "Event Id: "+ string( ll_eventId )
			ELSE
				ls_event = "Event Id: Null"
			end if
			
			IF not Isnull( ls_Status ) THEN
				
				IF ls_status = n_cst_bso_edimanager_322.cs_FlagStatus_Rail THEN
					//Terminated at Rail/Pier
					ls_statusMessage = "Event Status: Terminated at Rail/Pier"
				ELSEIF ls_status = n_cst_bso_edimanager_322.cs_FlagStatus_TerminatedImc THEN
					//Terminated at Other
					ls_statusMessage = "Event Status: Terminated at Other"
				ELSEIF ls_status = n_cst_bso_edimanager_322.cs_FlagStatus_BillToYard THEN
					//Drop at Bill to yard
					ls_statusMessage = "Event Status: Drop at Bill to Yard"
				ELSEIF ls_status = n_cst_bso_edimanager_322.cs_FlagStatus_BadOrder THEN
					//Bad Order
					ls_statusMessage = "Event Status: Bad Order"
				ELSEIF ls_status = n_cst_bso_edimanager_322.cs_FlagStatus_EmptyAvailable THEN
					//Drop Empty Available
					ls_statusMessage = "Event Status: Drop Empty Available"
				ELSEIF ls_status = n_cst_bso_edimanager_322.cs_FlagStatus_DropEmptyAtShipper THEN
					//Drop Empty at shipper
					ls_statusMessage = "Event Status: Drop Empty at Shipper"
				ELSE
					ls_statusMessage = "Event Status: unknown status '"+ ls_status+ "'"
				END IF
			ELSE
				ls_statusMessage = "Event Status: null"
			END IF
			
		END IF
	END IF
	
	ls_return += ls_event + "~r~n" + ls_ship + "~r~n" + ls_companyError + "~r~n" + ls_statusMessage
	ls_return += "~r~nTry opening the shipment and check the event data.  The original steps to confirm the event~r~n should be recompleted, ie: uncheck confirm event, change time/date, and check confirm."
ELSE
	ls_return = ls_null
END IF

RETURN 	ls_return
end function

on n_cst_edi_transaction_322.create
call super::create
end on

on n_cst_edi_transaction_322.destroy
call super::destroy
end on

event constructor;call super::constructor;ii_transactionset = 322
end event

