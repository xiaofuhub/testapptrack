$PBExportHeader$u_cst_syssettings_sle_company.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings_sle_company from u_cst_syssettings_sle
end type
end forward

global type u_cst_syssettings_sle_company from u_cst_syssettings_sle
end type
global u_cst_syssettings_sle_company u_cst_syssettings_sle_company

on u_cst_syssettings_sle_company.create
call super::create
end on

on u_cst_syssettings_sle_company.destroy
call super::destroy
end on

event ue_valuechanged;/// override
Long	ll_CoID
n_Cst_beo_Company	lnv_Co


IF Len ( TRIM ( as_value )) > 0 THEN

	lnv_Co = gnv_cst_companies.of_select( as_Value )
	IF isValid ( lnv_Co ) THEN
		ll_CoID = lnv_Co.of_GetID ( )
		sle_1.text = lnv_Co.of_getName( )
	ELSE
		sle_1.text = ""
	END IF
ELSE
	SetNull ( ll_CoID )
END IF

inv_syssetting.of_savevalue( ll_CoID )
end event

type st_1 from u_cst_syssettings_sle`st_1 within u_cst_syssettings_sle_company
end type

type sle_1 from u_cst_syssettings_sle`sle_1 within u_cst_syssettings_sle_company
textcase textcase = upper!
end type

event sle_1::getfocus;call super::getfocus;THIS.SelectText( 1 , Len ( THIS.Text ) )
end event

type st_2 from u_cst_syssettings_sle`st_2 within u_cst_syssettings_sle_company
end type

