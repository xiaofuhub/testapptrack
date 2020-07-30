$PBExportHeader$n_cst_appservices.sru
forward
global type n_cst_appservices from nonvisualobject
end type
end forward

global type n_cst_appservices from nonvisualobject autoinstantiate
end type

forward prototypes
public function n_cst_appmanager of_getappmanager ()
public function w_frame of_getframe ()
public function integer of_getpointerposition (ref integer ai_x, ref integer ai_y)
public function long of_getframehandle ()
public function integer of_getframehandle (ref long al_handle)
public function integer of_setfocusframe ()
end prototypes

public function n_cst_appmanager of_getappmanager ();RETURN gnv_App
end function

public function w_frame of_getframe ();RETURN gnv_App.of_GetFrame ( )
end function

public function integer of_getpointerposition (ref integer ai_x, ref integer ai_y);//Returns : 1, -1

w_Frame	lw_Frame
Integer	li_Return

lw_Frame = of_GetFrame ( )
ai_X = lw_Frame.PointerX ( )
ai_Y = lw_Frame.PointerY ( )

IF ai_X >= 0 AND &
	ai_Y >= 0 THEN

	li_Return = 1

ELSE

	SetNull ( ai_X )
	SetNull ( ai_Y )
	li_Return = -1

END IF

RETURN li_Return
end function

public function long of_getframehandle ();RETURN Handle ( of_GetFrame ( ) )
end function

public function integer of_getframehandle (ref long al_handle);//Returns : 1 = Valid Handle, -1 = No Valid Handle

Integer	li_Return

al_Handle = of_GetFrameHandle ( )

IF al_Handle > 0 THEN

	li_Return = 1

ELSE

	li_Return = -1

END IF

RETURN li_Return
end function

public function integer of_setfocusframe ();w_Frame	lw_Frame

lw_Frame = of_GetFrame ( )

RETURN lw_Frame.SetFocus ( )
end function

on n_cst_appservices.create
TriggerEvent( this, "constructor" )
end on

on n_cst_appservices.destroy
TriggerEvent( this, "destructor" )
end on

