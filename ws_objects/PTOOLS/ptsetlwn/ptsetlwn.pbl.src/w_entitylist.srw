$PBExportHeader$w_entitylist.srw
forward
global type w_entitylist from w_sheet
end type
type dw_entity from u_dw_entitylist within w_entitylist
end type
type mle_message from u_mle within w_entitylist
end type
type cb_1 from u_cbok within w_entitylist
end type
end forward

global type w_entitylist from w_sheet
int Width=3077
int Height=1440
boolean TitleBar=true
string Title="Entity Validation"
dw_entity dw_entity
mle_message mle_message
cb_1 cb_1
end type
global w_entitylist w_entitylist

on w_entitylist.create
int iCurrent
call super::create
this.dw_entity=create dw_entity
this.mle_message=create mle_message
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_entity
this.Control[iCurrent+2]=this.mle_message
this.Control[iCurrent+3]=this.cb_1
end on

on w_entitylist.destroy
call super::destroy
destroy(this.dw_entity)
destroy(this.mle_message)
destroy(this.cb_1)
end on

event open;call super::open;n_cst_msg	lnv_Msg
S_parm		lstr_Parm
Long			ll_EntityIDs[]		

Boolean		lb_Continue = TRUE
lnv_Msg = Message.PowerObjectParm

IF isValid ( lnv_msg ) THEN
	
	IF lnv_msg.of_Get_parm ( "MESSAGE" , lstr_Parm ) <> 0 THEN
		mle_message.Text = lstr_Parm.ia_Value 
	END IF
	
	IF lnv_msg.of_Get_parm ( "IDS" , lstr_Parm ) <> 0 THEN
		ll_EntityIDs = lstr_Parm.ia_Value 
	END IF
	
	IF UpperBound ( ll_EntityIds ) > 0 THEN
		dw_Entity.Retrieve ( ll_EntityIds )
	ELSE
		Close (This)
		lb_Continue = FALSE
	END IF
	
ELSE
	MessageBox( "Entity Validation" , "An error occurred while attempting to load information for the Entity Validation window.")
	CLOSE (THIS)
	lb_Continue = FALSE
END IF

//Check whether user has authorization to perform entity setup.
IF lb_Continue THEN
	n_cst_Privileges	lnv_Privileges
	
	IF lnv_Privileges.of_Settlements_EntitySetup ( ) = TRUE THEN
		//User is authorized to save changes.
	ELSE
		//User is NOT authorized to save changes. so don't ask to save
		// and don't allow them to type
		dw_entity.object.entity_name.Protect = 1
		dw_entity.object.entity_division.Protect = 1
		dw_entity.object.entity_payablesid.Protect = 1
		dw_entity.object.entity_PayrollID.Protect = 1
	
	END IF
	
	//Enable the Resize Service
	This.of_SetResize ( TRUE )
	
	//Set size so that proper alignment will be kept when opening as layered (full screen)
	inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
	inv_Resize.of_SetMinSize ( 1300, 400 )
	
	//Register Resizable controls
	inv_Resize.of_Register ( mle_message, 'ScaleToRight' )
	inv_Resize.of_Register ( dw_entity, 'ScaleToright&Bottom' )
	inv_Resize.of_Register ( cb_1, 'FixedToRight' )
END IF
end event

type dw_entity from u_dw_entitylist within w_entitylist
int X=18
int Y=312
int Width=3003
int Height=996
int TabOrder=10
boolean BringToTop=true
boolean HScrollBar=false
boolean HSplitScroll=false
end type

type mle_message from u_mle within w_entitylist
int X=18
int Y=28
int Width=2181
int TabOrder=20
boolean BringToTop=true
boolean VScrollBar=true
boolean HideSelection=false
boolean DisplayOnly=true
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type cb_1 from u_cbok within w_entitylist
int X=2683
int Y=28
int Width=338
int TabOrder=11
boolean BringToTop=true
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;Close( PARENT )
end event

