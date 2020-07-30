$PBExportHeader$u_mle.sru
$PBExportComments$Extension MultiLineEdit class
forward
global type u_mle from pfc_u_mle
end type
end forward

global type u_mle from pfc_u_mle
event ue_key pbm_keydown
end type
global u_mle u_mle

event ue_key;IF keyflags = 2 THEN
	IF key = KeyControl! THEN
		THIS.COPY ( )
		RETURN 0
	END IF
END IF
		
end event

