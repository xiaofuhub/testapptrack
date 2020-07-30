$PBExportHeader$n_cst_bso_email_manager_ptserver.sru
forward
global type n_cst_bso_email_manager_ptserver from n_cst_bso_email_manager
end type
end forward

global type n_cst_bso_email_manager_ptserver from n_cst_bso_email_manager
end type
global n_cst_bso_email_manager_ptserver n_cst_bso_email_manager_ptserver

forward prototypes
protected function integer of_establishsmtpconnection ()
end prototypes

protected function integer of_establishsmtpconnection ();Int				li_Return = 1

IF isValid ( inv_mailole ) THEN
	inv_mailole.Disconnect()
	inv_mailole.disconnectobject( )
	DESTROY inv_mailole
END IF

IF li_Return = 1 THEN
	// Create a mail session
	inv_mailole = CREATE OleObject
	IF inv_mailole.ConnectToNewObject( "LEADeMail.LEADSmtp.20" ) <> 0 THEN
		// we could not connect
		THIS.of_AddError ( "Could not connect to ole object" )
		li_Return = -1
		Destroy ( inv_mailole )
	END IF
END IF

IF li_Return = 1 THEN
	
	inv_mailole.ServerAddress = "mail.profittools.net" 
	inv_mailole.ServerPort = 25	// default
	inv_mailole.Timeout = 60   // standard. we may need to increase this or send a NOOP to
										// keep the connection active.
	IF inv_mailole.Connect ( ) <> ci_eml_success THEN
		THIS.of_AddError ( "Could not connect to mail server. The most probable cause is that your email server requires authentication. Additional settings will need to be specified in the System Settings." )
		li_Return = -1
	END IF
END IF

RETURN li_Return
end function

on n_cst_bso_email_manager_ptserver.create
call super::create
end on

on n_cst_bso_email_manager_ptserver.destroy
call super::destroy
end on

