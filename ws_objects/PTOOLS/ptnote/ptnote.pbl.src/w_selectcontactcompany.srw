$PBExportHeader$w_selectcontactcompany.srw
forward
global type w_selectcontactcompany from w_response
end type
type cb_1 from commandbutton within w_selectcontactcompany
end type
type gb_1 from groupbox within w_selectcontactcompany
end type
type cb_2 from commandbutton within w_selectcontactcompany
end type
type dw_companies from u_dw_co_list within w_selectcontactcompany
end type
type st_1 from statictext within w_selectcontactcompany
end type
type cb_close from u_cbok within w_selectcontactcompany
end type
end forward

global type w_selectcontactcompany from w_response
int X=425
int Y=592
int Width=2839
int Height=944
boolean TitleBar=true
string Title="Select Company to Notify"
long BackColor=12632256
event ue_addreferenced ( )
event ue_addnonreferenced ( )
cb_1 cb_1
gb_1 gb_1
cb_2 cb_2
dw_companies dw_companies
st_1 st_1
cb_close cb_close
end type
global w_selectcontactcompany w_selectcontactcompany

type variables
n_cst_beo_Shipment inv_Shipment
end variables

forward prototypes
private function integer wf_loadcompanies ()
private function n_cst_beo_company wf_getcompanyfromrow (long al_row)
private function string wf_determinecompanyrole (long al_Row)
end prototypes

event ue_addreferenced;Long	ll_Row 
n_cst_beo_Company	lnva_Cos[]
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

ll_Row = dw_companies.GetRow ( )

IF dw_companies.of_GetSelectedCompanies ( lnva_Cos ) > 0 THEN
	
	lstr_Parm.ia_Value = lnva_Cos
	lstr_PArm.is_Label = "COMPANY"
	lnv_Msg.of_Add_Parm  ( lstr_Parm ) 
	CloseWithReturn ( THIS , lnv_Msg ) 

ELSE
	MessageBox ( "Add Contact Company" , "Please select the company to add." )
	
END IF
end event

event ue_addnonreferenced;n_cst_msg	lnv_msg
s_Parm		lstr_Parm

n_cst_Beo_Company	lnva_Co[]

lnva_Co[1] = gnv_cst_companies.of_Select ( "" ) 

IF isValid ( lnva_Co[1] ) THEN
	
	lstr_Parm.ia_Value = lnva_Co
	lstr_PArm.is_Label = "COMPANY"
	lnv_Msg.of_Add_Parm  ( lstr_Parm ) 
	CloseWithReturn ( THIS , lnv_Msg ) 
	
END IF


end event

private function integer wf_loadcompanies ();Long	lla_CoIds[]
Long	ll_RowCount
Long	ll_i
String	ls_Role


IF IsValid ( inv_Shipment ) THEN
	inv_Shipment.of_GetReferencedCompanies ( lla_CoIds )	
END IF

If UpperBound ( lla_CoIds ) > 0 THEN
	ll_RowCount = dw_companies.Retrieve ( lla_CoIds )
END IF	

FOR ll_i = 1 TO ll_RowCount 
	ls_Role = THIS.wf_DetermineCompanyRole ( ll_i ) 
	dw_companies.SetItem ( ll_i , "Role" , ls_Role )	
NEXT 

RETURN 1
end function

private function n_cst_beo_company wf_getcompanyfromrow (long al_row);Long	ll_Row
Long	ll_CoID 

n_cst_beo_Company	lnv_Company
lnv_Company = CREATE n_cst_beo_Company

ll_Row = al_Row

IF ll_Row > 0 AND ll_Row <= dw_companies.RowCount ( ) THEN
	ll_CoID = dw_companies.GetItemNumber ( ll_Row, "co_id" )
END IF

IF ll_CoID > 0 THEN
	gnv_cst_companies.of_Cache ( ll_CoID , TRUE ) 
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceID ( ll_CoID )
END IF


RETURN lnv_Company 



end function

private function string wf_determinecompanyrole (long al_Row);Int		li_Return = 1
String	ls_Role

n_cst_ShipmentManager lnv_ShipmentManager
n_cst_beo_Company	lnv_Company
n_cst_beo_Shipment	lnv_Shipment

lnv_Company = THIS.wf_GetCompanyFromRow ( al_row )
lnv_Shipment = inv_Shipment

IF Not IsValid ( lnv_Shipment ) THEN
	li_Return = -1
END IF

IF Not IsValid ( lnv_Company ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	ls_Role = lnv_ShipmentManager.of_GetCompanyRoleInShipment ( lnv_Shipment, lnv_Company ) 
END IF

DESTROY ( lnv_Company )

RETURN ls_Role


	
end function

on w_selectcontactcompany.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.gb_1=create gb_1
this.cb_2=create cb_2
this.dw_companies=create dw_companies
this.st_1=create st_1
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_companies
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_close
end on

on w_selectcontactcompany.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.cb_2)
destroy(this.dw_companies)
destroy(this.st_1)
destroy(this.cb_close)
end on

event open;call super::open;n_cst_msg	lnv_msg
S_Parm		lstr_Parm

ib_DisableCloseQuery = TRUE
lnv_Msg = Message.PowerObjectParm 

IF lnv_Msg.of_Get_Parm	( "SHIPMENT" , lstr_Parm ) <> 0 THEN
	inv_Shipment = lstr_Parm.ia_Value	
END IF

THIS.wf_LoadCompanies ( )
end event

event pfc_default;Close ( THIS )
end event

type cb_1 from commandbutton within w_selectcontactcompany
int X=1289
int Y=32
int Width=247
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="Add..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Event ue_AddNonReferenced ( ) 
end event

type gb_1 from groupbox within w_selectcontactcompany
int X=27
int Y=148
int Width=2766
int Height=552
string Text="Add the selected company already referenced on the shipment"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_selectcontactcompany
int X=2519
int Y=228
int Width=247
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Add"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Event ue_AddReferenced ( ) 
end event

type dw_companies from u_dw_co_list within w_selectcontactcompany
int X=50
int Y=228
int Width=2446
int Height=436
int TabOrder=10
boolean BringToTop=true
string DataObject="d_companiesonshipment"
end type

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA )
ib_RmbMenu = FALSE
IF IsValid ( inv_RowSelect ) THEN
	inv_RowSelect.of_SetStyle ( appeon_constant.appeon_EXTENDED )
END IF

end event

event doubleclicked;Parent.Event ue_AddReferenced ( ) 
end event

type st_1 from statictext within w_selectcontactcompany
int X=78
int Y=44
int Width=1207
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="Add a company not referenced on the shipment"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from u_cbok within w_selectcontactcompany
int X=1207
int Y=736
int Width=407
int TabOrder=30
boolean BringToTop=true
string Text="Close"
boolean Default=false
boolean Cancel=true
end type

