$PBExportHeader$w_companylist.srw
forward
global type w_companylist from w_popup
end type
type dw_1 from u_dw_co_list within w_companylist
end type
type cb_1 from commandbutton within w_companylist
end type
type cb_2 from commandbutton within w_companylist
end type
end forward

global type w_companylist from w_popup
int X=416
int Y=776
int Width=2944
int Height=868
boolean TitleBar=true
string Title="Company Selection"
boolean ControlMenu=false
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_companylist w_companylist

forward prototypes
public function integer wf_retrieve (ref long ala_CompanyIds[])
public function integer wf_display (long al_Row)
end prototypes

public function integer wf_retrieve (ref long ala_CompanyIds[]);RETURN -1
end function

public function integer wf_display (long al_Row);w_Company	lw_Co

long	ll_coId
IF al_Row > 0 THEN
	ll_CoID = dw_1.GetItemNumber ( al_Row , "co_id" ) 	
	
	IF ll_CoID > 0 THEN
		OpenSheetWithParm ( lw_Co , ll_CoID ,gnv_App.of_GetFrame ( ) ,0, Original! )
	END IF
END IF

RETURN 1
end function

event open;call super::open;n_cst_msg	lnv_Msg
S_Parm		lstr_Parm
n_cst_sql	lnv_sql
String		ls_Select
Long			lla_CompanyIds[]
Long			ll_WherePosition

lnv_Msg = Message.PowerObjectParm

dw_1.SetTransObject ( SQLCA )

ls_Select = dw_1.object.datawindow.table.Select 

ll_WherePosition = pos ( ls_Select , "where" )

IF lnv_Msg.of_Get_Parm ( "COMPANYIDS" , lstr_Parm ) <> 0 THEN
	lla_CompanyIds = lstr_Parm.ia_Value
	
	ls_Select += " Where co_id " + lnv_sql.of_makeinclause ( lla_CompanyIds )
	
	dw_1.object.datawindow.table.Select = ls_Select
dw_1.Retrieve ( )
	
END IF


end event

on w_companylist.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_companylist.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type dw_1 from u_dw_co_list within w_companylist
int X=27
int Y=140
int Width=2839
int Height=572
int TabOrder=10
boolean BringToTop=true
end type

event doubleclicked;
IF Row > 0 THEN
	wf_Display ( row )
	CLOSE (PARENT)

END IF
end event

type cb_1 from commandbutton within w_companylist
int X=2272
int Y=24
int Width=274
int Height=100
int TabOrder=20
boolean BringToTop=true
string Text="&Select"
boolean Default=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long	ll_Row
ll_Row = dw_1.GetRow ( )

IF ll_Row > 0 THEN
	wf_Display ( ll_row )
	CLOSE (PARENT)
END IF
end event

type cb_2 from commandbutton within w_companylist
int X=2592
int Y=24
int Width=274
int Height=100
int TabOrder=20
boolean BringToTop=true
string Text="Close"
boolean Cancel=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CLOSE ( PARENT )
end event

