$PBExportHeader$w_routepicklist.srw
forward
global type w_routepicklist from w_response
end type
type dw_1 from u_dw within w_routepicklist
end type
type st_1 from statictext within w_routepicklist
end type
type st_2 from statictext within w_routepicklist
end type
type cb_select from u_cbok within w_routepicklist
end type
type cb_cancel from u_cbcancel within w_routepicklist
end type
end forward

global type w_routepicklist from w_response
int X=553
int Y=512
int Width=2555
int Height=1376
boolean TitleBar=true
string Title="Route Pick List"
dw_1 dw_1
st_1 st_1
st_2 st_2
cb_select cb_select
cb_cancel cb_cancel
end type
global w_routepicklist w_routepicklist

type variables
long il_EquipmentId
end variables

event open;call super::open;Blob			lblb_State
Boolean		lb_GotSource
n_cst_msg	lnv_Msg
S_Parm		lstr_parm

n_cst_Presentation_EquipmentSummary	lnv_Presentation

// nothing needs to be updated in this window
ib_DisableCloseQuery = TRUE

// check to ensure the messageParm is valid
IF isValid ( message.PowerObjectParm ) THEN
	// get the msg object
	lnv_Msg = message.PowerObjectParm
	IF lnv_Msg.of_Get_Parm ( "STATE" , lstr_Parm ) <> 0 THEN
		// get the blob of the full state
		lblb_State = lstr_Parm.ia_Value
		IF dw_1.SetFullState ( lblb_State ) <> -1 THEN
			// if the setting of the full state was successfull then flag that we have source
			lb_GotSource = TRUE
		END IF
	END IF
END IF

// If we successfully set the source, then set the presentation on the datawindow
IF lb_GotSource THEN
	lnv_Presentation.of_SetPresentation ( dw_1 )
ELSE // Display an error message and close the window
	MessageBox ( "Route Selection" , "An error occurred while attempting to display the route selection list." )
	Close ( THIS )
END IF


end event

event close;call super::close;CloseWithReturn ( this, il_equipmentid )
end event

event pfc_default;long 	ll_row
		
IF dw_1.IsSelected ( 1 ) THEN
	il_equipmentid = dw_1.Object.join_route_equipment_equipmentid.Selected[1]
	close (this)
ELSE
	ll_Row = dw_1.GetSelectedRow (1)
	IF ll_Row > 0 THEN
		il_equipmentid = dw_1.Object.join_route_equipment_equipmentid.Selected[ll_Row]
		close (this)
	else
		messagebox("Route Pick List", " Please highlight the row to be selected. ")
	end if
END IF

end event

on w_routepicklist.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
this.cb_select=create cb_select
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cb_select
this.Control[iCurrent+5]=this.cb_cancel
end on

on w_routepicklist.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_select)
destroy(this.cb_cancel)
end on

event pfc_cancel;call super::pfc_cancel;close ( this ) 
end event

type dw_1 from u_dw within w_routepicklist
int X=32
int Y=208
int Width=2469
int Height=1044
int TabOrder=10
boolean BringToTop=true
string DataObject="d_routepicklist"
end type

event constructor;

// enable multi-row-select-ability
THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (0) //0 = SINGLE row selectION

of_setinsertable ( false )
of_setDeleteable ( false )

of_SetAutoSort ( TRUE )

end event

event doubleclicked;cb_select.TriggerEvent(Clicked!)
end event

type st_1 from statictext within w_routepicklist
int X=46
int Y=24
int Width=1422
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Multiple routes exist for this company and route type."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_routepicklist
int X=46
int Y=108
int Width=1632
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Please highlight and select the route to be used for the event."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_select from u_cbok within w_routepicklist
int X=1966
int Y=96
int TabOrder=20
boolean BringToTop=true
string Text="Select"
end type

type cb_cancel from u_cbcancel within w_routepicklist
int X=2263
int Y=96
int TabOrder=30
boolean BringToTop=true
end type

