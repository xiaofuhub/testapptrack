$PBExportHeader$n_cst_dde.sru
forward
global type n_cst_dde from nonvisualobject
end type
end forward

global type n_cst_dde from nonvisualobject
end type
global n_cst_dde n_cst_dde

type variables
protected:
long il_window_handle
long il_channel_handle
end variables

forward prototypes
public function boolean of_openchannel (string as_application, string as_topic, long al_window_handle)
public function boolean of_closechannel ()
public function boolean of_getremote (string as_location, ref string as_target)
public function boolean of_setremote (string as_location, string as_value)
public function boolean of_openchannel (string as_application, string as_topic)
public function boolean of_execremote (string as_action)
public function boolean of_isconnected ()
end prototypes

public function boolean of_openchannel (string as_application, string as_topic, long al_window_handle);long ll_result

if il_channel_handle > 0 then return false  //A channel is already open

ll_result = openchannel(as_application, as_topic, al_window_handle)

if ll_result > 0 then
	il_channel_handle = ll_result
	il_window_handle = al_window_handle
	return true
else
	return false
end if
end function

public function boolean of_closechannel ();if il_channel_handle > 0 then
	if closechannel(il_channel_handle, il_window_handle) = 1 then
		il_channel_handle = 0
		il_window_handle = 0
		return true
	else
		return false
	end if
else
	return true
end if
end function

public function boolean of_getremote (string as_location, ref string as_target);integer li_result

if il_channel_handle > 0 then
	as_target = ""
	li_result = getremote(as_location, as_target, il_channel_handle, il_window_handle)
end if

if li_result = 1 then
	return true
else
	setnull(as_target)
	return false
end if	
end function

public function boolean of_setremote (string as_location, string as_value);integer li_result

if il_channel_handle > 0 then
	li_result = setremote(as_location, as_value, il_channel_handle, il_window_handle)
end if

if li_result = 1 then
	return true
else
	return false
end if	
end function

public function boolean of_openchannel (string as_application, string as_topic);n_cst_AppServices	lnv_AppServices
Long	ll_WindowHandle
Boolean	lb_Return

IF lnv_AppServices.of_GetFrameHandle ( ll_WindowHandle ) = 1 THEN

	lb_Return = This.of_OpenChannel ( as_Application, as_Topic, ll_WindowHandle )

END IF

RETURN lb_Return
end function

public function boolean of_execremote (string as_action);int 	li_Result
Boolean lb_ReturnValue = FALSE

pfc_n_cst_DateTime lnv_DateTime

li_Result = ExecRemote("["+as_action+"]",il_Channel_Handle,il_Window_Handle)

IF li_Result > 0 THEN
	lb_ReturnValue = TRUE
END IF

Return lb_ReturnValue

end function

public function boolean of_isconnected ();BOOLEAN		lb_ReturnValue = FALSE

If il_channel_handle > 0 THEN
	lb_ReturnValue = TRUE
END IF

Return lb_ReturnValue


end function

on n_cst_dde.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dde.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;this.of_closechannel()
end event

