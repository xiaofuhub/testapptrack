$PBExportHeader$n_tr_railtrace.sru
forward
global type n_tr_railtrace from n_tr
end type
end forward

global type n_tr_railtrace from n_tr
end type
global n_tr_railtrace n_tr_railtrace

forward prototypes
public function integer of_init (string as_inifile, string as_inisection)
end prototypes

public function integer of_init (string as_inifile, string as_inisection);Integer	li_Rc

String	ls_Pwd
Decimal	lc_Work = .86343146733169
Date		ld_Work

IF Upper ( ProfileString ( as_IniFile, 'DBConnect', 'DefaultDB', '' ) ) = 'NO' THEN

	li_Rc = Super::of_Init ( as_IniFile, as_IniSection )

ELSE

	This.DBMS = "ODBC"
	This.DBParm = "Connectstring='DSN=Rail Trace Data'"
	li_Rc = 1

END IF

IF li_Rc = 1 THEN

	IF Upper ( ProfileString ( as_IniFile, 'DBConnect', 'DefaultUser', '' ) ) = 'NO' THEN

		//Use custom UID and PWD

	ELSE

		ls_Pwd = String ( 741824 +&
			Long ( String ( RelativeDate ( ld_Work, 295), "yyyymmdd" ) ) +&
			Exp ( lc_Work + 10 * Ceiling ( lc_Work ) ) * -1 )

		of_SetUser ( 'dba', ls_Pwd )

	END IF

END IF

RETURN li_Rc
end function

on n_tr_railtrace.create
call super::create
end on

on n_tr_railtrace.destroy
call super::destroy
end on

event constructor;call super::constructor;of_SetAutoRollback ( TRUE )
end event

