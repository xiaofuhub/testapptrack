$PBExportHeader$w_paysplitmanager.srw
forward
global type w_paysplitmanager from w_response
end type
type dw_1 from u_dw within w_paysplitmanager
end type
type cb_1 from commandbutton within w_paysplitmanager
end type
type cb_2 from commandbutton within w_paysplitmanager
end type
type ln_1 from line within w_paysplitmanager
end type
end forward

global type w_paysplitmanager from w_response
int X=233
int Y=192
int Width=3342
int Height=1256
boolean TitleBar=true
string Title="Pay Split Manager"
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
ln_1 ln_1
end type
global w_paysplitmanager w_paysplitmanager

type variables
Private:
long	il_EventId
long	il_AmountID
string	is_Context
end variables

forward prototypes
public function integer wf_retrieve ()
end prototypes

public function integer wf_retrieve ();dw_1.Retrieve(il_EventId) 
Return 1
end function

on w_paysplitmanager.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.ln_1
end on

on w_paysplitmanager.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.ln_1)
end on

event open;call super::open;n_cst_msg	lnv_msg
s_parm		lstr_Parm

lnv_msg = message.powerobjectParm

ib_DisableCloseQuery = TRUE

IF isValid ( lnv_msg ) THEN
	//dispatch object should already be filtered by the correct shipmentid 
	IF lnv_Msg.of_Get_Parm ( "EVENTID" , lstr_Parm ) <> 0 THEN
		il_EventId = lstr_Parm.ia_Value
	END IF

	IF lnv_Msg.of_Get_Parm ( "CONTEXT" , lstr_Parm ) <> 0 THEN
		is_Context = lstr_Parm.ia_Value
	END IF

	//Enable the Resize Service
	This.of_SetResize ( TRUE )
	
	//Set size so that proper alignment will be kept when opening as layered (full screen)
	inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
	inv_Resize.of_SetMinSize ( 1300, 400 )
	
	//Register Resizable controls
	inv_Resize.of_Register ( dw_1, 'ScaleToRight' )

	wf_Retrieve ( ) 
	
	
ELSE
	messageBox ( "Pay splits manager" , "An error occurred while attempting to open the window.~r~nRequest Cancelled.", EXCLAMATION! ) 
	ib_DisableCloseQuery = TRUE
	close ( THIS ) 
END IF

end event

type dw_1 from u_dw within w_paysplitmanager
int X=37
int Y=28
int Width=3278
int Height=952
int TabOrder=10
boolean BringToTop=true
string DataObject="d_eventamountlist"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;// enable multi-row-select-ability
THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (2) //2 = extended row select service

of_setinsertable ( FALSE )
of_setDeleteable ( FALSE )

of_SetAutoSort ( FALSE )


this.SetTransObject(SQLCA)

n_cst_presentation_AmountOwed	lnv_Presentation

lnv_Presentation.of_SetPresentation ( THIS )
end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_AmountId, &
		ll_FoundRow

IF currentrow > 0 THEN
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
	il_AmountId = dw_1.object.amountowed_id[currentrow]

END IF
end event

type cb_1 from commandbutton within w_paysplitmanager
int X=2373
int Y=1060
int Width=805
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="Show &Amount-Owed Splits"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;n_cst_Msg	lnv_Msg
S_Parm 		lstr_Parm

lstr_Parm.is_Label = "EVENTID"
lstr_Parm.ia_Value = il_EventID
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "AMOUNTID"
lstr_Parm.ia_Value = il_AmountID
lnv_Msg.of_Add_Parm ( lstr_Parm )

OpenWithParm ( w_AmountPaySplitList , lnv_msg )

wf_Retrieve ( )
end event

type cb_2 from commandbutton within w_paysplitmanager
int X=50
int Y=1060
int Width=475
int Height=88
int TabOrder=20
boolean BringToTop=true
string Text="Close"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close ( Parent )
end event

type ln_1 from line within w_paysplitmanager
boolean Enabled=false
int BeginX=32
int BeginY=1024
int EndX=3301
int EndY=1024
int LineThickness=4
long LineColor=33554432
end type

