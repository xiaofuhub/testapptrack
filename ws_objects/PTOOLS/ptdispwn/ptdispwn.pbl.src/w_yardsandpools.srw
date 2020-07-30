$PBExportHeader$w_yardsandpools.srw
forward
global type w_yardsandpools from w_response
end type
type dw_1 from u_dw within w_yardsandpools
end type
type cb_1 from u_cbok within w_yardsandpools
end type
type cb_2 from u_cbcancel within w_yardsandpools
end type
end forward

global type w_yardsandpools from w_response
integer x = 1170
integer y = 672
integer width = 896
integer height = 976
string title = "Yards and Pools"
long backcolor = 12632256
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_yardsandpools w_yardsandpools

type variables

end variables

forward prototypes
public function long wf_getidfromcodename (string as_CodeName)
end prototypes

public function long wf_getidfromcodename (string as_CodeName);Long	ll_FoundRow
Long	ll_CompanyID = -1
n_cst_Beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

ll_FoundRow = gnv_cst_companies.of_Find ( as_CodeName ) 

IF ll_FoundRow > 0 THEN
	
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceRow ( ll_FoundRow )
	
	ll_CompanyID = lnv_Company.of_getID ( ) 
	
END IF

DESTROY lnv_Company

RETURN ll_CompanyID
end function

on w_yardsandpools.create
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

on w_yardsandpools.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event pfc_default;
String	ls_Co
Long		ll_CoID
n_cst_msg	lnv_Msg
s_Parm		lstr_Parm

//ls_Co = lb_yardmoves.Selecteditem ( ) // ZMC
ls_Co = dw_1.Object.values[dw_1.GetRow()] // ZMC


IF Len ( ls_Co ) > 0 THEN
	ll_CoID = THIS.wf_GetIdFromCodeName ( ls_Co )
	
	IF ll_CoID > 0 THEN
		lstr_Parm.ia_Value = ll_CoID
		lstr_Parm.is_Label = "COID"
		lnv_Msg.of_Add_Parm ( lstr_Parm ) 
		CloseWithReturn ( THIS , lnv_Msg ) 
	ELSE
		MessageBox ( "Yards and Pools" , "The company selected could not be resolved." )
	END IF
END IF
end event

event pfc_cancel;call super::pfc_cancel;CLOSEWithReturn ( THIS , 0 )
end event

type cb_help from w_response`cb_help within w_yardsandpools
end type

type dw_1 from u_dw within w_yardsandpools
integer x = 18
integer y = 20
integer width = 841
integer height = 708
integer taborder = 10
string dataobject = "d_generic_populate"
end type

event constructor;call super::constructor;any	la_Value
n_cst_Settings		lnv_Settings
n_cst_String		lnv_String
Long					lla_Values[] // ZMC
Long					ll_TypeCount
Long					ll_Index

ib_disableclosequery = True

// Changing the Width of Values Column
dw_1.Modify("values.Width = 800")

// Making the header invisible
dw_1.Object.DataWindow.Header.Height = 0

// Disabling right clik button
ib_rmbmenu = False

IF lnv_Settings.of_GEtSetting ( 85 , la_Value ) = 1 THEN
	ll_TypeCount = lnv_String.of_ParseToArray ( String ( la_Value ) , "," , lla_Values )
END IF

gnv_cst_companies.of_cache(  lla_Values , TRUE )
 
n_cst_beo_Company	lnv_Company
lnv_Company = Create n_cst_beo_Company 
lnv_Company.of_SetUseCache ( TRUE )
	
This.SetRedraw ( FALSE )

FOR ll_Index = 1 TO ll_TypeCount	
	lnv_Company.of_SetSourceID ( lla_Values[ll_Index] ) 
	This.Object.values[ll_Index] 			= lnv_Company.of_GetCodeName( ) 
	This.Object.hidden_values[ll_Index] = String(lla_Values[ll_Index])
NEXT
This.SetRedraw ( TRUE )

DESTROY ( lnv_Company )
end event

event doubleclicked;call super::doubleclicked;PARENT.Event pfc_Default ( )
end event

type cb_1 from u_cbok within w_yardsandpools
integer x = 160
integer y = 752
integer width = 233
integer taborder = 20
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
end type

type cb_2 from u_cbcancel within w_yardsandpools
integer x = 453
integer y = 752
integer width = 233
integer taborder = 21
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
end type

