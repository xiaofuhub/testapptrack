$PBExportHeader$n_cst_bso_import_fsi.sru
forward
global type n_cst_bso_import_fsi from n_cst_bso_import
end type
end forward

global type n_cst_bso_import_fsi from n_cst_bso_import
event type integer ue_fsi ( )
event type integer ue_errorlog ( string as_filename )
end type
global n_cst_bso_import_fsi n_cst_bso_import_fsi

type variables
integer ii_FileNo  //error log pointer
end variables

forward prototypes
private function integer of_replacecharacter (string as_oldchar, string as_newchar, ref datastore ads_import)
end prototypes

event ue_fsi;string ls_key

ls_key = String(Message.LongParm,"address")

SetPointer(HourGlass!)

Integer	li_Return, &
			li_Index, &
			li_RowCount, &
			li_ShipIndex, &
			li_ItemIndex, &
			li_Fileno, &
			li_Parms, &
			li_ParmIndex, &
			li_ShipmentCount, &
			li_ItemCount, &
			li_Result, &
			li_Errors, &
			li_Successes

Long		ll_ImportCount			
			
String	ls_HoldInvoice, &
			lsa_ParmLabels [], &
			lsa_ParmValues [], &
			lsa_empty [], &
			ls_LogFile, &
			ls_text, &
			ls_Filename, &
			ls_Origin, &
			ls_Dest, &
			ls_ErrorLabel, &
			ls_ErrorText, &
			ls_ShipMessage, &
			ls_PayableMessage, &
			ls_ErrorFile

DataStore	lds_import			
			
DateTime	ldt_system
			
n_cst_fsi_import_shipment	lnva_Shipments [], &
									lnv_ShipData
n_cst_FSI_Import_Item		lnv_ItemData


n_cst_ShipmentManager	lnv_ShipmentManager
DataStore	lds_Shipments, &
				lds_Items
n_cst_Msg	lnv_Msg
s_Parm	lstr_Parm, &
			lstr_StyleParm, &
			lstr_FreightCountParm
Long		ll_ShipmentId, &
			ll_ShipRow, &
			ll_ItemRow, &
			ll_BilltoId, &
			ll_CompanyRow, &
			ll_CarrierId, &
			ll_EntityId
			
Integer	li_PayAmtType, &
			li_PayRef1Type, &
			li_PayRef2Type, &
			li_ShipRef1Type = 4,  &
			li_ShipRef2Type = 13, &
			li_ShipRef3Type = 2  
			
n_cst_bso_TransactionManager	lnv_TransactionManager
n_cst_beo_AmountOwed				lnv_Amount

n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Item			lnv_Item

n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

lnv_Company.of_SetUseCache ( TRUE )

lnv_Item = CREATE n_cst_beo_Item
lnv_Shipment = CREATE n_cst_beo_Shipment


lstr_StyleParm.is_Label = "Style"
lstr_StyleParm.ia_Value = "NONROUTED!"

lstr_FreightCountParm.is_Label = "FreightItemCount"
lstr_FreightCountParm.ia_Value = 0

li_Return = 1
ls_ShipMessage = "  Shipment and Payable Information was not imported."
ls_PayableMessage = "  Shipment Information was imported but no Payables information was imported."

this.Of_GetParmLabels ( is_FileGroup, ls_Key, 0, lsa_ParmLabels )
this.Of_GetParms( is_FileGroup, ls_key, 0, lsa_ParmLabels, lsa_ParmValues )	
li_Parms = upperbound ( lsa_ParmLabels )
IF lsa_ParmValues = lsa_empty THEN
	//	Invalid Parameters
	messagebox ( "Importing Data", &
					"Invalid parameters in the [Import] section of " + cs_IniFile + " file.",  StopSign! )
	li_Return = -1
END IF

//get filename
ls_FileName = of_IsFileValid ( lsa_ParmLabels, lsa_ParmValues )
IF len ( ls_Filename ) = 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	//Get reference types and error file from ini file parameters
	FOR li_ParmIndex = 1 to li_Parms
		
		CHOOSE CASE upper ( lsa_parmlabels[li_ParmIndex] )
		CASE "PAYAMTTYPE" 
			IF LEN ( lsa_ParmValues [li_ParmIndex] ) > 0 THEN
				li_PayAmtType = integer ( lsa_ParmValues [li_ParmIndex] )
			END IF
		CASE "PAYREF1TYPE"
			IF LEN ( lsa_ParmValues [li_ParmIndex] ) > 0 THEN
				li_PayRef1Type = integer ( lsa_ParmValues [li_ParmIndex] )
			END IF
		CASE "PAYREF2TYPE"
			IF LEN ( lsa_ParmValues [li_ParmIndex] ) > 0 THEN
				li_PayRef2Type = integer (lsa_ParmValues [li_ParmIndex] )
			END IF
		CASE "ERRORFILE"
			ls_ErrorFile = lsa_ParmValues [li_ParmIndex] 
		END CHOOSE
		
	NEXT

	//create datastore  
	ll_ImportCount = this.of_CreateDataStore ( 'd_fsidata', ls_filename, lds_import )

	//create error log, if it already exists then a blank line will be appended
	li_FileNo = this.event ue_errorlog(ls_ErrorFile)


END IF

IF ll_Importcount > 0 THEN
	
	//remove character(s) fsi specific move to descendant
	this.of_replacecharacter ( '$', "", lds_import )

	li_RowCount = Integer (lds_import.RowCount ( ) )
	li_Return = 1
	
	FOR li_Index = 1 to li_RowCount
	
		//loop through shipments (invoices)
		IF ls_HoldInvoice <> lds_import.Object.Invoice[li_index] THEN
	
			ls_HoldInvoice = lds_import.Object.Invoice[li_index]

			li_ItemIndex = 0
			li_ShipIndex ++
			lnva_Shipments[li_ShipIndex] = Create n_cst_fsi_import_shipment
	
			//can only fit 15 characters for reference text and shipper id

			lnva_Shipments[li_ShipIndex].is_Pronum = & 
										left ( string (lds_import.Object.invoice[li_index] ), 15 )
			lnva_Shipments[li_ShipIndex].is_CarrierId = lds_import.Object.scac[li_index]
			lnva_Shipments[li_ShipIndex].idt_ShipDate = lds_import.Object.billing_date[li_index]
			lnva_Shipments[li_ShipIndex].ic_CarrierPayable = Dec ( lds_import.Object.net_amount_due[li_index] )
			lnva_Shipments[li_ShipIndex].is_CustomerRef = &
										left ( string ( lds_import.Object.shipment_id[li_index] ), 15 )
			lnva_Shipments[li_ShipIndex].is_QuoteNumber = &
										left ( string (lds_import.Object.quote[li_index] ), 15 )
			lnva_Shipments[li_ShipIndex].is_BilltoId = &
										left ( string (lds_import.Object.shipper_reference[li_index] ), 15 )
	

			ls_Origin = "<Origin>"
			IF len ( trim ( lds_import.Object.shipper_name[li_index] ) ) > 0 THEN
				ls_Origin = ls_Origin + &
										trim ( lds_import.Object.shipper_name[li_index] )
			END IF
//			IF len ( trim ( lds_import.Object.shipper_address_1[li_index] ) ) > 0 THEN
//				ls_Origin = ls_Origin + "~r" + "~N" + &
//										trim ( lds_import.Object.shipper_address_1[li_index] )
//			END IF
//			IF len ( trim ( lds_import.Object.shipper_address_2[li_index] ) ) > 0 THEN
//				ls_Origin = ls_Origin + "~r" + "~N" + &
//										trim ( lds_import.Object.shipper_address_2[li_index] )
//			END IF
			IF len ( trim ( lds_import.Object.shipper_city[li_index] ) ) > 0 THEN
				ls_Origin = ls_Origin + "~r~n" + &
										trim ( lds_import.Object.shipper_city[li_index] )
			END IF
			IF len ( trim ( lds_import.Object.shipper_state[li_index] ) ) > 0 THEN
				ls_Origin = ls_Origin + ", " + &
										trim ( lds_import.Object.shipper_state[li_index] )
			END IF
//			IF len ( trim ( lds_import.Object.shipper_zip[li_index] ) ) > 0 THEN
//				ls_Origin = ls_Origin + " " + &
//										trim ( lds_import.Object.shipper_zip[li_index] )
//			END IF
			IF trim ( ls_Origin ) = "<Origin>" THEN
				//No origin, strip out tag
				ls_Origin = ''
			ELSE
				ls_Origin = ls_Origin + "</Origin>"
			END IF
			
			ls_Dest = "<Dest>" 
			IF len ( trim ( lds_import.Object.consignee_name[li_index] ) ) > 0 THEN
				ls_Dest = ls_Dest + trim ( lds_import.Object.consignee_name[li_index] )
			END IF
//			IF len ( trim ( lds_import.Object.consignee_address_1[li_index] ) ) > 0 THEN
//				ls_Dest = ls_Dest + "~r" + "~N" + &
//										trim ( lds_import.Object.consignee_address_1[li_index] )
//			END IF
//			IF len ( trim ( lds_import.Object.consignee_address_2[li_index] ) ) > 0 THEN
//				ls_Dest = ls_Dest + "~r" + "~N" + &
//										trim ( lds_import.Object.consignee_address_2[li_index] )
//			END IF
			IF len ( trim ( lds_import.Object.consignee_city[li_index] ) ) > 0 THEN
				ls_Dest = ls_Dest + "~r~n" + &
										trim ( lds_import.Object.consignee_city[li_index] )
			END IF
			IF len ( trim ( lds_import.Object.consignee_state[li_index] ) ) > 0 THEN
				ls_Dest = ls_Dest + ", " + &
										trim ( lds_import.Object.consignee_state[li_index] )
			END IF
//			IF len ( trim ( lds_import.Object.consignee_zip[li_index] ) ) > 0 THEN
//				ls_Dest = ls_Dest + " " + &
//										trim ( lds_import.Object.consignee_zip[li_index] )
//			END IF
			IF trim ( ls_Dest ) = "<Dest>" THEN
				//No dest, strip out tag
				ls_Dest = ''
			ELSE
				ls_Dest = ls_Dest +	"</Dest>"
			END IF
	
			//	Ship Note
			IF len ( string ( lds_import.Object.delivery_date[li_index] ) ) > 0 THEN
				lnva_Shipments[li_ShipIndex].is_ShipNote = "Del Date: " + &
										string ( lds_import.Object.delivery_date[li_index], "MM/DD/YY" ) 
			ELSE
				lnva_Shipments[li_ShipIndex].is_ShipNote = ""
			END IF
			IF len ( string ( lds_import.Object.pickup_date[li_index] ) ) > 0 THEN
				IF len ( string ( lds_import.Object.delivery_date[li_index] ) ) > 0 THEN
					//ADD A CRLF BETWEEN DELIVERY AND PICKUP DATES
					lnva_Shipments[li_ShipIndex].is_ShipNote = &
										lnva_Shipments[li_ShipIndex].is_ShipNote + " " 
				END IF
				lnva_Shipments[li_ShipIndex].is_ShipNote = &
										lnva_Shipments[li_ShipIndex].is_ShipNote + &
										"PU Date: " + &
										string ( lds_import.Object.pickup_date[li_index], "MM/DD/YY" )
			END IF
			//add origin and destination to shipnote
			IF len ( ls_origin ) > 0 THEN
				IF len ( lnva_Shipments[li_ShipIndex].is_ShipNote ) > 0 THEN
					lnva_Shipments[li_ShipIndex].is_ShipNote = &
										lnva_Shipments[li_ShipIndex].is_ShipNote + &
										"~r~n" + ls_origin
				ELSE
					lnva_Shipments[li_ShipIndex].is_ShipNote = ls_origin
				END IF
			END IF
										
			IF len ( ls_Dest ) > 0 THEN
				IF len ( lnva_Shipments[li_ShipIndex].is_ShipNote ) > 0 THEN
					lnva_Shipments[li_ShipIndex].is_ShipNote = &
										lnva_Shipments[li_ShipIndex].is_ShipNote + &
										"~r~n" + ls_Dest
				ELSE
					lnva_Shipments[li_ShipIndex].is_ShipNote = ls_Dest
				END IF
			END IF	
	
			lnva_Shipments[li_ShipIndex].is_ShipNote = Upper ( lnva_Shipments[li_ShipIndex].is_ShipNote )
	
			//	Bill Note
			IF len ( trim ( lds_import.Object.other_reference_number[li_index] ) ) > 0 THEN
				lnva_Shipments[li_ShipIndex].is_BillNote = &
										trim ( lds_import.Object.other_reference_number[li_index] )
			ELSE
				lnva_Shipments[li_ShipIndex].is_BillNote = ""
			END IF
			IF len ( trim ( lds_import.Object.other_info[li_index] ) ) > 0 THEN
				lnva_Shipments[li_ShipIndex].is_BillNote = &
										lnva_Shipments[li_ShipIndex].is_BillNote + " " + &
										trim ( lds_import.Object.other_info[li_index] )
			END IF
		
			lnva_Shipments[li_ShipIndex].is_BillNote = Upper ( lnva_Shipments[li_ShipIndex].is_BillNote )
		
		END IF
	
		/***************** 	 Line Item     ****************************/
		li_ItemIndex ++
		lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex] = Create n_cst_fsi_import_item
		
		//	Description
		IF len ( trim ( lds_import.Object.description[li_index] ) ) > 0 THEN
			lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].is_Description = &
										trim ( lds_import.Object.description[li_index] )
		ELSE
			lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].is_Description = ""
		END IF
		IF len ( trim ( lds_import.Object.class[li_index] ) ) > 0 THEN
			lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].is_Description = &
										lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].is_Description + " (" + &
										lds_import.Object.class[li_index] 
		END IF
		IF len ( trim ( lds_import.Object.commodity_code[li_index] ) ) > 0 THEN
			lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].is_Description = &
										lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].is_Description + " " + &
										lds_import.Object.commodity_code[li_index] + ")"
		ELSE
			IF len ( trim ( lds_import.Object.class[li_index] ) ) > 0 THEN
				lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].is_Description = &
										lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].is_Description + ")"
			END IF
		END IF
	
		lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].is_Description = &
								Upper ( lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].is_Description )
	
		lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].ic_Weight = lds_import.Object.weight[li_index]
		lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].ic_Quantity = lds_import.Object.quantity[li_index]
		lnva_Shipments[li_ShipIndex].inva_Items[li_ItemIndex].ic_Charge = Dec ( lds_import.Object.charge[li_index] )
	
	NEXT


	///////////////////////////////////////////////////////
	//Generate shipment entries

	li_ShipmentCount = UpperBound ( lnva_Shipments )

	FOR li_ShipIndex = 1 TO li_ShipmentCount

		//Reset the Result flag for this pass through the loop
		li_Result = 1
		ls_ErrorLabel = " Invoice: " + &
							String ( lnva_Shipments[li_ShipIndex].is_Pronum) + &
							" SCAC: " + &
							String ( lnva_Shipments[li_ShipIndex].is_CarrierId ) + &
							" Shipper Reference: " + &
							String (lnva_Shipments[li_ShipIndex].is_BilltoId ) + &
							" Error: "


		//Get a reference to the shipment for this pass
		lnv_ShipData = lnva_Shipments [ li_ShipIndex ]

		//Get the item count on this shipment
		li_ItemCount = UpperBound ( lnv_ShipData.inva_Items )



		//Check the Billto

		IF li_Result = 1 THEN

			ll_CompanyRow = gnv_cst_Companies.of_Find ( lnv_ShipData.is_BilltoId )
	
			IF ll_CompanyRow > 0 THEN
				lnv_Company.of_SetSourceRow ( ll_CompanyRow )
	
				//More company checks??  Allow Billing, etc.?
	
				ll_BilltoId = lnv_Company.of_GetSourceId ( )
			ELSE
				//Company does not exist.
				ls_ErrorText = "Company (Shipper Reference) does not exist." + ls_ShipMessage
				li_Result = -1
			END IF

		END IF


		//Check the Carrier

		IF li_Result = 1 THEN

			ll_CompanyRow = gnv_cst_Companies.of_Find ( lnv_ShipData.is_CarrierId )
	
			IF ll_CompanyRow > 0 THEN
				lnv_Company.of_SetSourceRow ( ll_CompanyRow )
	
				//More company checks??  Allow Billing, etc.?
	
				ll_CarrierId = lnv_Company.of_GetSourceId ( )
			ELSE
				//Company does not exist.
				ls_ErrorText = "Company (SCAC) does not exist." + ls_ShipMessage
				li_Result = -1
			END IF

		END IF


		//Verify that the carrier company is an entity

		IF li_Result = 1 THEN

			IF gnv_cst_Companies.of_MakeEntity ( ll_CarrierId, ll_EntityId ) >= 0 THEN
				//Carrier is an entity  (0=Already was, no change; 1=Made new entity)
			ELSE
				//Could not make company an entity.
				ls_ErrorText = "Could not make company (SCAC) an entity." + ls_ShipMessage
				li_Result = -1
			END IF

		END IF


		//////////////////////////


		//Create the basic shipment entries, using the ShipmentManager.

		IF li_Result = 1 THEN

			SetNull ( ll_ShipmentId )
	
			lnv_Msg.of_Reset ( )
			lnv_Msg.of_Add_Parm ( lstr_StyleParm )
	
			lstr_FreightCountParm.ia_Value = li_ItemCount
			lnv_Msg.of_Add_Parm ( lstr_FreightCountParm )
	
			lds_Shipments = lnv_ShipmentManager.of_CreateShipmentEntries ( lnv_Msg )
	
			IF IsValid ( lds_Shipments ) THEN
				IF lnv_Msg.of_Get_Parm ( "ShipmentId", lstr_Parm ) > 0 THEN
					ll_ShipmentId = lstr_Parm.ia_Value
				ELSE
					//Unexpected error.
					ls_ErrorText = "Unexpected error. Invalid Shipment Id." + ls_ShipMessage
					li_Result = -1
				END IF
			ELSE
				//Error creating shipment entries.
				ls_ErrorText = "Error creating shipment entries." + ls_ShipMessage
				li_Result = -1
			END IF

		END IF


		//Add detail information to the shipment.  I'm using direct column access rather than
		//a beo because the beo doesn't have all the necessary sets defined.

		IF li_Result = 1 THEN

			ll_ShipRow = 1  //Placeholder, in case it's not constant at some point

			lnv_Shipment.of_SetSource ( lds_Shipments )
			lnv_Shipment.of_SetSourceRow ( ll_ShipRow )

			lds_Shipments.Object.ds_Ref1_Type [ ll_ShipRow ] = li_ShipRef1Type
			lds_Shipments.Object.ds_Ref1_Text [ ll_ShipRow ] = lnv_ShipData.is_ProNum

			lds_Shipments.Object.ds_Ref2_Type [ ll_ShipRow ] = li_ShipRef2Type
			lds_Shipments.Object.ds_Ref2_Text [ ll_ShipRow ] = lnv_ShipData.is_CarrierId

			lds_Shipments.Object.ds_Ref3_Type [ ll_ShipRow ] = li_ShipRef3Type
			lds_Shipments.Object.ds_Ref3_Text [ ll_ShipRow ] = lnv_ShipData.is_CustomerRef

			lds_Shipments.Object.ds_Ship_Date [ ll_ShipRow ] = Date ( lnv_ShipData.idt_ShipDate )

			lds_Shipments.Object.ds_Billto_Id [ ll_ShipRow ] = ll_BilltoId

			lds_Shipments.Object.ds_Ship_Comment [ ll_ShipRow ] = lnv_ShipData.is_ShipNote
			lds_Shipments.Object.ds_Bill_Comment [ ll_ShipRow ] = lnv_ShipData.is_BillNote

			lds_Shipments.Object.ds_Pay_LH_Totamt [ ll_ShipRow ] = lnv_ShipData.ic_CarrierPayable
			lds_Shipments.Object.ds_Pay_Totamt [ ll_ShipRow ] = lnv_ShipData.ic_CarrierPayable
			
			lds_Shipments.Object.ds_Status [ ll_ShipRow ] = gc_Dispatch.cs_ShipmentStatus_Authorized

		END IF


		//Create the basic item entries, using the ShipmentManager.

		IF li_Result = 1 THEN

			lds_Items = lnv_ShipmentManager.of_CreateItemEntries ( lnv_Msg )

			IF IsValid ( lds_Items ) THEN
				//Success
			ELSE
				//Error creating item entries.
				ls_ErrorText = "Error creating item entries." + ls_ShipMessage
				li_Result = -1
			END IF

		END IF


		//Add detail information to the items (using an item beo.)

		IF li_Result = 1 THEN

			//Set the beo source to the item datastore.
			lnv_Shipment.of_SetItemSource ( lds_Items )
			lnv_Item.of_SetSource ( lds_Items )
			lnv_Item.of_SetShipment ( lnv_Shipment )

			FOR ll_ItemRow = 1 TO li_ItemCount

				//Get a reference to the item we're working on this pass.
				lnv_ItemData = lnv_ShipData.inva_Items [ ll_ItemRow ]

				//Point the beo at that item.
				lnv_Item.of_SetSourceRow ( ll_ItemRow )

				//Set the values.
				lnv_Item.of_SetRateType ( "F" )
				IF lnv_ItemData.ic_Quantity > 0 THEN
					lnv_Item.of_SetQuantity ( lnv_ItemData.ic_Quantity )
				END IF
				lnv_Item.of_SetAmount ( lnv_ItemData.ic_Charge )
				lnv_Item.of_SetTotalWeight ( lnv_ItemData.ic_Weight )
				lnv_Item.of_SetDescription ( lnv_ItemData.is_Description )

			NEXT

		END IF


		//Save the shipment information.
		IF li_Result = 1 THEN
			IF lds_Shipments.Update ( ) = -1 THEN
				ROLLBACK ;
				ls_ErrorText = "Error while saving shipment information." + ls_ShipMessage
				li_Result = -1
			END IF
		END IF
		
		//Save the item information.
		IF li_Result = 1 THEN
			IF lds_Items.Update ( ) = -1 THEN
				ROLLBACK ;
				ls_ErrorText = "Error while saving item information." + ls_ShipMessage
				li_Result = -1
			END IF
		END IF
		
		//Commit
		IF li_Result = 1 THEN
			COMMIT ;
			
			IF SQLCA.SqlCode <> 0 THEN
				ROLLBACK ;
				ls_ErrorText = "Error during commit." + ls_ShipMessage
				li_Result = -1
			END IF
		END IF


		//Create the Carrier payable

		IF li_Result = 1 THEN

			//Instantiate the transaction manager.
			lnv_TransactionManager = CREATE n_cst_bso_TransactionManager

			//Tell the transaction manager we'll be creating payables, and who they'll be for.
			lnv_TransactionManager.of_SetDefaultCategory ( n_cst_Constants.ci_Category_Payables )
			lnv_TransactionManager.of_SetDefaultEntityId ( ll_EntityId )
	
			//Create a new payable amount.
			lnv_Amount = lnv_TransactionManager.of_NewAmountOwed ( )
	
			IF NOT IsValid ( lnv_Amount ) THEN
				//Unexpected error.
				ls_ErrorText = "Unexpected error while creating payables." + ls_PayableMessage
				li_Result = -1
			END IF

		END IF


		//Set the values on the payable amount.

		IF li_Result = 1 THEN

			lnv_Amount.of_SetType ( li_PayAmtType )

			//This call is necessary because the TransactionManager doesn't have the type cache
			//intitialized, so it can't set the taxable default itself.
			lnv_Amount.of_SetTaxable ( FALSE )

			lnv_Amount.of_SetStartDate ( Date ( lnv_ShipData.idt_ShipDate ) )
			lnv_Amount.of_SetAmount ( lnv_ShipData.ic_CarrierPayable )
			lnv_Amount.of_SetDescription ( "CARRIER PAY" )
			lnv_Amount.of_SetRef1Type ( li_PayRef1Type )
			lnv_Amount.of_SetRef1Text ( lnv_ShipData.is_ProNum )
			lnv_Amount.of_SetRef2Type ( li_PayRef2Type )
			lnv_Amount.of_SetRef2Text ( String ( ll_ShipmentId, "0000" ) )
//			lnv_Amount.of_SetRef3Type ( ??? )
//			lnv_Amount.of_SetRef3Text ( ??? )
//			lnv_Amount.of_SetInternalNote ( ??? )
//			lnv_Amount.of_SetPublicNote ( ??? )
			lnv_Amount.of_SetStatus ( n_cst_beo_AmountOwed.ci_Status_Authorized )


			//Save the payable amount.

			CHOOSE CASE lnv_TransactionManager.Event pt_Save ( )

			CASE 1  //Success
				//No processing needed
		
			CASE -1  //Failure
				ls_ErrorText = "Failure (-1) while trying to save payable amount." + &
									ls_PayableMessage
				li_Result = -1
		
			CASE ELSE  //Unexpected result
				ls_ErrorText = "Unexpected result while trying to save payable amount." + &
									ls_PayableMessage
				li_Result = -1
		
			END CHOOSE

		END IF


		//CleanUp the datastores and objects used in this pass.
		
		DESTROY lds_Shipments
		DESTROY lds_Items
		DESTROY lnv_TransactionManager
		
		///////////////////////////
		IF li_Result = -1 THEN
			//Write to error log
			FileWrite ( li_FileNo, ls_ErrorLabel + ls_ErrorText )
			li_Errors += li_ItemCount
		ELSE
			li_Successes += li_ItemCount
		END IF
	
	NEXT

	li_Return = li_Result

	//DESTROY shipment array!!!!  And, on destructor of shipment, destroy items.
	
	FOR li_ShipIndex = 1 TO li_ShipmentCount
	
		IF isvalid ( lnva_Shipments[li_ShipIndex] ) THEN
			destroy lnva_Shipments[li_ShipIndex]
		END IF
		
	NEXT

	IF li_Errors > 0 THEN
		messagebox ( "Importing Data", string ( li_Successes ) + &
						" row(s) successfully imported." + "~r~n" + &
						string ( li_Errors ) + " error(s) encountered during the import.  " + "~r~n" + &
						" Please see your error file for details",Information!)							
	ELSE
		messagebox ( "Importing Data", string ( li_Successes ) + &
					" row(s) successfully imported.",Information!)
	END IF

	FileWrite ( li_FileNo, "  -- " + string ( li_Successes )  + " row(s) successfully imported." )
	FileWrite ( li_FileNo, "  -- " + string ( li_Errors )  + " error(s) encountered during the import.  " )
	
	DESTROY lds_import


	//If the shipment cache is loaded, refresh it.

	IF lnv_ShipmentManager.of_Get_Retrieved_Ships ( ) THEN
		lnv_ShipmentManager.of_RefreshShipments ( FALSE )
	END IF


END IF

if li_fileno > 0 then
	fileclose ( li_fileno )
end if

DESTROY ( lnv_Shipment )
DESTROY ( lnv_Item )
DESTROY lnv_Company

return li_Return

end event

event ue_errorlog;Integer	li_Return = 1

String	ls_text			
DateTime	ldt_system
			
//Create log file in current directory, if it already exists then a blank line will be appended


IF FileExists ( as_filename ) THEN

	ii_FileNo = FileOpen(as_filename, LineMode!, Write!, LockReadWrite!, Append!)
	//write blank lines
	IF ii_FileNo < 0 THEN 
		
		li_Return = -1
		
	ELSE
		
		ls_text = " "
		FileWrite ( ii_FileNo, ls_text )
		FileWrite ( ii_FileNo, ls_text )
		
	END IF

ELSE

	ii_FileNo = FileOpen(as_filename, LineMode!, Write!, LockReadWrite!, Append!)
	
	IF ii_FileNo < 0 THEN li_Return = -1

END IF

IF li_Return = 1 THEN

	ldt_system = DateTime(Today(), Now())
	ls_text = "Log for import on " + string ( ldt_System )
	FileWrite ( ii_FileNo, ls_text )
	li_Return = ii_FileNo

END IF

return li_Return
end event

private function integer of_replacecharacter (string as_oldchar, string as_newchar, ref datastore ads_import);/*
	Function:  		of_ReplaceCharacter
	Access:  		public
 
	Arguments:		as_oldchar
						as_newchar
						ads_import (by reference)
						
	Returns:  		integer	
						1 	= success
						-1 = failure
	
	Description:	Replace $ in the currency field with ''
		
		
*/
SetPointer(HourGlass!)
Integer	li_Return, &
			li_index, &
			li_column, &
			li_index2
			
long		ll_pos, &
			ll_ImportCount
			
string	ls_temp, &
			ls_replace, &
			ls_ColumnName
			
ll_ImportCount = ads_import.RowCount()	
li_column = Integer ( ads_import.Object.DataWindow.Column.Count )

FOR li_index = 1 to ll_ImportCount

	FOR li_index2 = 1 to li_column
		
		CHOOSE CASE li_index2
				
		CASE 5 , 31 	//"NET_AMOUNT_DUE", "CHARGE"
			ls_temp = string ( ads_import.Object.Data[li_index, li_index2] )
			ll_pos = pos ( ls_temp, as_oldchar )
			
			IF ll_pos > 0 then
				
				ls_replace=replace ( ls_temp, ll_pos, 1, as_newchar )
				ads_import.Object.Data[li_index, li_index2] = ls_replace
			
			END IF
			
		END CHOOSE
		
	
	NEXT
	
NEXT


return li_Return
end function

on n_cst_bso_import_fsi.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bso_import_fsi.destroy
TriggerEvent( this, "destructor" )
end on

