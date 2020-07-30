$PBExportHeader$n_cst_eventtask_mobilcomm.sru
forward
global type n_cst_eventtask_mobilcomm from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_mobilcomm from n_cst_eventtask
end type
global n_cst_eventtask_mobilcomm n_cst_eventtask_mobilcomm

type variables
Protected:

String	is_Device
end variables

forward prototypes
public function integer of_execute ()
end prototypes

public function integer of_execute ();
integer	li_Return = 1
long		ll_errorcount
string	ls_Device, &
			ls_CommunicationObject, &
			ls_TemplatePath, &
			ls_errormessage

int		li_ProcessReturn
String	ls_Result

li_ProcessReturn = ci_result_success

			
datastore	lds_InboundMessage

n_cst_licensemanager				  lnv_LicenseManager
n_cst_bso_Communication_Manager lnv_Communication
n_cst_OFRError	lnva_Errors[]

ls_Device = is_device
ls_Result = "Synchronization of " + ls_Device + " data successful."

//need to check table for device, if more than one type
//then display response window ot pick one


CHOOSE CASE UPPER (ls_Device)
	
	CASE "QUALCOMM" , n_cst_constants.cs_CommunicationDevice_Qualcomm 
		ls_CommunicationObject = "n_cst_bso_Communication_QualComm"
		
			
	CASE "NEXTEL" , n_cst_constants.cs_CommunicationDevice_Nextel
		ls_CommunicationObject = "n_cst_bso_Communication_Nextel"

	CASE "INTOUCH", n_cst_constants.cs_CommunicationDevice_InTouch
		ls_CommunicationObject = "n_cst_bso_Communication_Intouch"
	
	CASE "ATROAD", n_cst_constants.cs_CommunicationDevice_AtRoad
		ls_CommunicationObject = "n_cst_bso_Communication_AtRoad"
		
	CASE "CADEC", n_cst_constants.cs_CommunicationDevice_Cadec
		ls_CommunicationObject = "n_cst_bso_Communication_Cadec"


END CHOOSE

IF NOT lnv_LicenseManager.of_getlicensed( ls_Device ) THEN  // EARLY RETURN HERE //\\//\\//\\//\\
	THIS.of_Setprocessingresult( ci_result_error )
	THIS.of_Setresultstring( ls_device + " is not licensed." )
	THIS.of_Disableevent( )
	RETURN 0	
END IF


IF len ( ls_CommunicationObject ) > 0 THEN
	
	lnv_Communication = CREATE USING ls_CommunicationObject
	
END IF


IF isValid ( lnv_Communication ) THEN
	lds_InboundMessage = 	CREATE datastore
	lds_InboundMessage.DataObject = "d_communicationlog"
	lds_InboundMessage.SetTransObject ( SQLCA ) 
	
	lnv_Communication.of_GetinboundPath ( ls_TemplatePath )
	// build path from system templatepath + "\message\" + device + "\intouch\inbound\message.txt"
	//ls_TemplatePath += "message.txt"
	ls_TemplatePath += String (Today ( ) , "mmddyy" ) + ".txt"

	lds_InboundMessage.ImportFile ( ls_TemplatePath )

	lnv_Communication.ClearOFRErrors ( )
	lnv_Communication.of_GetInBound(lds_InboundMessage)
	ll_ErrorCount = lnv_Communication.GetErrorCount ( )

	if ll_errorcount > 0 then
		lnv_Communication.GetOFRErrors ( lnva_Errors )
		ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )

		if Len ( ls_errormessage ) > 0 then
			//OK
		else
			ls_errormessage = "Unspecified error on inbound processing."
		end if
	
		if len(ls_errormessage) > 0 then
			li_ProcessReturn = ci_result_error
			ls_Result = ls_Errormessage			
		end if
	end if	

	//should we check return code for message if running visible
	//			messagebox("Process Inbound Message", "No messages to process.")
	
	IF isValid ( lds_InboundMessage ) THEN 
		
		lds_InboundMessage.SaveAs ( ls_TemplatePath , TEXT!, FALSE )
		
	END IF

	IF IsValid ( lnv_Communication ) THEN
		DESTROY lnv_Communication
	END IF
	
	IF isValid ( lds_InBoundMessage  ) THEN
		DESTROY lds_InBoundMessage
	END IF
	
END IF

n_Cst_EquipmentManager	lnv_EqMan
lnv_EqMan.of_Refreshactive( )

THIS.of_setprocessingresult( li_ProcessReturn )
THIS.of_Setresultstring( ls_Result )

//
return li_return

end function

on n_cst_eventtask_mobilcomm.create
call super::create
end on

on n_cst_eventtask_mobilcomm.destroy
call super::destroy
end on

