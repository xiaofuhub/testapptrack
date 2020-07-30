$PBExportHeader$u_cst_mle.sru
$PBExportComments$[u_base] Multiline edit used to display text documents
forward
global type u_cst_mle from u_base
end type
type mle_1 from u_mle within u_cst_mle
end type
end forward

global type u_cst_mle from u_base
int Width=1655
int Height=2084
mle_1 mle_1
end type
global u_cst_mle u_cst_mle

forward prototypes
public function integer of_settext (string as_text)
public function integer of_settext (string as_text[])
end prototypes

public function integer of_settext (string as_text);//
/***************************************************************************************
NAME			: of_SetText
ACCESS		: public
ARGUMENTS	: String
RETURNS		: integer
DESCRIPTION	: Sets the text in the mle object

REVISION		: RDT 092602
***************************************************************************************/

mle_1.Text = as_text

Return 1
end function

public function integer of_settext (string as_text[]);//
/***************************************************************************************
NAME			: of_SetText
ACCESS		: public
ARGUMENTS	: String Array 
RETURNS		: integer (1 , -1)
DESCRIPTION	: Parses the array and populates the text of the mle.

REVISION		: RDT 092602
***************************************************************************************/
Long 		ll_Counter, &
			ll_Bound
Integer	li_Return 
mle_1.Text = ""								// clear current file 
ll_Bound = UpperBound( as_Text[]) 
If ll_Bound > 0 Then 
	For ll_Counter = 1 to ll_Bound 
		mle_1.Text = mle_1.Text + as_Text[ ll_Counter ]
	Next
	li_Return = 1
Else
	li_Return = -1
End If


return li_Return 
end function

on u_cst_mle.create
int iCurrent
call super::create
this.mle_1=create mle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_1
end on

on u_cst_mle.destroy
call super::destroy
destroy(this.mle_1)
end on

event constructor;call super::constructor;
//Enable the Resize Service
This.of_SetResize ( TRUE )
////Register Resizable controls
inv_Resize.of_Register ( mle_1, 'ScaleToRight&Bottom' )



end event

type mle_1 from u_mle within u_cst_mle
int X=23
int Y=28
int Width=1609
int Height=1984
int TabOrder=10
boolean BringToTop=true
end type

