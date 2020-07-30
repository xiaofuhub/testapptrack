$PBExportHeader$n_cst_errorremedy_edi_importedshipments.sru
forward
global type n_cst_errorremedy_edi_importedshipments from n_cst_errorremedy_edi
end type
end forward

global type n_cst_errorremedy_edi_importedshipments from n_cst_errorremedy_edi
end type
global n_cst_errorremedy_edi_importedshipments n_cst_errorremedy_edi_importedshipments

forward prototypes
public function integer of_remedy ()
end prototypes

public function integer of_remedy ();Int	li_return = 1
Int	li_res
String	ls_context
String	ls_keyData
String	ls_message
String	ls_select
String	lsa_keyData[]
Long	ll_row
Long	ll_shipId
Long	lla_ids[]
n_cst_string	lnv_string
N_cst_shipmentManager lnv_shipmentManager
n_ds	lds_importedShipments

lds_importedShipments = create n_ds
lds_importedShipments.dataobject = "d_importedShipments"
lds_importedShipments.setTransobject( SQLCA )



inv_errorlog.of_getsourceids( lla_ids )
//I get the primary key in the imported shipments table from the context message.
//The context message should have 'Senderscode|groupcontrolnumber|transactioncontrolnumber' for this to work.
ls_context = inv_errorlog.of_GetContext( )

ls_keyData = right(ls_context, len(ls_context) - pos(ls_context, "'") )	//this will pull the key information out of the context
ls_keyData = Mid(ls_keyData, 1, len(ls_keyData)- 1)		//this will strip off the ''
lnv_string.of_parsetoarray( ls_keyData, "|", lsa_keyData)

IF upperBound(lsa_keyData) = 3 THEN
	//Senderscode at 1
	//Groupcontrol at 2
	//transaction at 3
	ls_select = "Select * From importedShipments where processed = -1 and sendersCode = '" + lsa_keyData[1] + "' AND groupcontrolnumber ="+ lsa_keyData[2]+" AND transactioncontrolnumber = "+lsa_keyData[3]
	lds_importedShipments.SetSqlselect( ls_select )
	ll_row = lds_importedShipments.retrieve()
	commit;
	
	IF UpperBound( lla_ids ) = 0 THEN
		 Messagebox("Remdey Imported Shipment", "The associated shipment couldn't be resolved. Cannot repair this error through troubleshoot.")
	ELSE
		
		IF ll_row > 0 THEN
			li_res = Messagebox("Remedy Imported Shipment", "The shipment "+ string(lla_ids[1]) + &
										" was missing required data at the time of EDI import and couldn't be processed. It is HIGHLY recommended that the shipment be reviewed and fixed before enabling it for accept/decline status. Do you want to enable the shipment now?~r~n~r~nClick 'YES' to enable shipment for accept/decline status.~r~nClick 'NO' to view the shipment.", exclamation!,yesno!, 2)
		ELSE
			Messagebox("Remedy Imported Shipment", "No results found when retrieving from Imported shipments table that meet the criteria of "+ ls_context)
		END IF
	END IF
ELSE
	ls_message = "Couldn't parse key data from "+ ls_context
	Messagebox("Remedy Imported Shipment", ls_message )
END IF

//we change the processed status to 1, and we update the shipment number.  The shipment will be available for accept/decline after this is completed.
IF li_res = 1 THEN
	lds_importedShipments.setitem( ll_row, "shipmentid", lla_ids[1] )
	lds_importedShipments.setitem( ll_row, "processed", 1 )
	
	IF lds_importedShipments.update( ) = 1 THEN
		commit;
	ELSE
		rollback;
		li_return = -1
		Messagebox("Remedy Imported Shipment", "There was an error updating the imported shipments table, could not save changes.")
	END IF
ELSEIF li_res = 2 THEN
	//open the shipmentwindow

	lnv_shipmentManager.of_openshipment( lla_ids[1])

END IF


destroy lds_importedShipments

RETURN li_return
end function

on n_cst_errorremedy_edi_importedshipments.create
call super::create
end on

on n_cst_errorremedy_edi_importedshipments.destroy
call super::destroy
end on

