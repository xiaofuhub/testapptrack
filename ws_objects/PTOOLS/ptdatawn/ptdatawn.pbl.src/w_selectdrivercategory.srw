$PBExportHeader$w_selectdrivercategory.srw
forward
global type w_selectdrivercategory from w_response
end type
type gb_1 from groupbox within w_selectdrivercategory
end type
type rb_singles from u_rb within w_selectdrivercategory
end type
type rb_teams from u_rb within w_selectdrivercategory
end type
type rb_both from u_rb within w_selectdrivercategory
end type
type cb_1 from u_cbok within w_selectdrivercategory
end type
type cb_2 from u_cbcancel within w_selectdrivercategory
end type
end forward

global type w_selectdrivercategory from w_response
int X=1170
int Y=852
int Width=1125
int Height=588
boolean TitleBar=true
string Title="Select Driver Category"
gb_1 gb_1
rb_singles rb_singles
rb_teams rb_teams
rb_both rb_both
cb_1 cb_1
cb_2 cb_2
end type
global w_selectdrivercategory w_selectdrivercategory

on w_selectdrivercategory.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.rb_singles=create rb_singles
this.rb_teams=create rb_teams
this.rb_both=create rb_both
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.rb_singles
this.Control[iCurrent+3]=this.rb_teams
this.Control[iCurrent+4]=this.rb_both
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
end on

on w_selectdrivercategory.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.rb_singles)
destroy(this.rb_teams)
destroy(this.rb_both)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event pfc_default;Integer	li_Return

IF rb_Singles.Checked THEN
	li_Return = n_cst_Constants.ci_DriverCategory_Singles

ELSEIF rb_Teams.Checked THEN
	li_Return = n_cst_Constants.ci_DriverCategory_Teams

ELSE
	li_Return = n_cst_Constants.ci_DriverCategory_All

END IF

//The closequery processing for the window is intended to handle closing with the x,
//so we need to skip that processing.
ib_DisableCloseQuery = TRUE

CloseWithReturn ( This, li_Return )
end event

event pfc_cancel;call super::pfc_cancel;Integer	li_Return = -1

//The closequery processing for the window is intended to handle closing with the x,
//so we need to skip that processing.
ib_DisableCloseQuery = TRUE

CloseWithReturn ( This, li_Return )
end event

event closequery;call super::closequery;//Processing for pfc_Default and pfc_Cancel CloseWithReturn and set ib_DisableCloseQuery = TRUE
//If ib_DisableCloseQuery = FALSE here, the window has been closed with the x, and
//we need to set the window return value to null, just like cancel does.

Integer	li_Return = -1

IF ib_DisableCloseQuery = FALSE AND AncestorReturnValue = 0 /*ALLOW_CLOSE*/ THEN
	Message.DoubleParm = li_Return
END IF

RETURN AncestorReturnValue
end event

type gb_1 from groupbox within w_selectdrivercategory
int X=59
int Y=48
int Width=631
int Height=368
int TabOrder=10
string Text="Driver Category"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_singles from u_rb within w_selectdrivercategory
int X=101
int Y=140
int Width=530
boolean BringToTop=true
string Text="&Single Drivers "
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type rb_teams from u_rb within w_selectdrivercategory
int X=101
int Y=224
int Width=530
boolean BringToTop=true
string Text="&Teams "
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type rb_both from u_rb within w_selectdrivercategory
int X=101
int Y=308
int Width=530
boolean BringToTop=true
string Text="&Both "
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type cb_1 from u_cbok within w_selectdrivercategory
int X=782
int Y=88
int TabOrder=20
boolean BringToTop=true
end type

type cb_2 from u_cbcancel within w_selectdrivercategory
int X=782
int Y=220
int TabOrder=30
boolean BringToTop=true
end type

