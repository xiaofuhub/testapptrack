$PBExportHeader$w_amounttypeselection.srw
forward
global type w_amounttypeselection from w_response
end type
type mle_instructions from multilineedit within w_amounttypeselection
end type
type cb_1 from commandbutton within w_amounttypeselection
end type
type dw_selection from datawindow within w_amounttypeselection
end type
end forward

global type w_amounttypeselection from w_response
int Width=1143
int Height=396
boolean TitleBar=true
string Title="Amount Type Selection"
long BackColor=12632256
boolean ControlMenu=false
mle_instructions mle_instructions
cb_1 cb_1
dw_selection dw_selection
end type
global w_amounttypeselection w_amounttypeselection

type variables
Long	il_SelectedValue
Boolean	ib_NeedSelection
end variables

on w_amounttypeselection.create
int iCurrent
call super::create
this.mle_instructions=create mle_instructions
this.cb_1=create cb_1
this.dw_selection=create dw_selection
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_instructions
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_selection
end on

on w_amounttypeselection.destroy
call super::destroy
destroy(this.mle_instructions)
destroy(this.cb_1)
destroy(this.dw_selection)
end on

event open;call super::open;THIS.of_SetBase ( TRUE ) 
IF isValid ( inv_Base ) THEN
	inv_Base.of_Center ( )
END IF

n_cst_msg	lnv_Msg
S_Parm		lstr_Parm
n_cst_presentation_amountType 	lnv_Presentation

dw_selection.SetTransObject ( SQLCA )
dw_selection.InsertRow ( 0 ) 
dw_selection.SetFocus ( )
lnv_Presentation.of_SetCategory ( n_cst_constants.ci_category_receivables ) 
lnv_Presentation.of_SetAmountTypeFilter ( n_cst_constants.cs_ItemType_Accessorial )
lnv_Presentation.of_SetPresentation ( dw_selection )

/* if the list is empty we need a way for the user to get out of the response window w/o making a selection*/
ib_NeedSelection = Len ( lnv_Presentation.of_SetTypeList ( ) ) > 0

ib_DisableCloseQuery = TRUE 

mle_instructions.Text = "Select the Amount Type to be used for Fuel Surcharges. This value can be changed later."


end event

event closequery;call super::closequery;IF il_selectedvalue > 0 OR NOT ib_NeedSelection THEN	
	
ELSE
	messageBox ( "Select Amount Type" , "Please select an Amount Type." )
	RETURN 1
END IF

RETURN AncestorReturnValue
end event

type mle_instructions from multilineedit within w_amounttypeselection
int X=32
int Y=32
int Width=1038
int Height=120
int TabOrder=10
boolean BringToTop=true
boolean Border=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_amounttypeselection
int X=827
int Y=176
int Width=247
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Close"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn  ( Parent , il_selectedvalue ) 
end event

type dw_selection from datawindow within w_amounttypeselection
int X=27
int Y=172
int Width=786
int Height=84
int TabOrder=20
boolean BringToTop=true
string DataObject="d_amounttype"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;IF isNumber ( data ) THEN
	il_selectedvalue = Long ( data ) 
END IF

end event

