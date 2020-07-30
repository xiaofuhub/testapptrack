$PBExportHeader$u_dw_companydocumenttransfersettings.sru
forward
global type u_dw_companydocumenttransfersettings from u_dw
end type
end forward

global type u_dw_companydocumenttransfersettings from u_dw
integer width = 2240
integer height = 928
string dataobject = "d_companydocumentsettings"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type
global u_dw_companydocumenttransfersettings u_dw_companydocumenttransfersettings

type variables
Private:
Long	il_CoID
end variables

forward prototypes
public function integer of_retrieve (long al_coid)
private subroutine of_formatforemail ()
private subroutine of_formatforftp ()
end prototypes

public function integer of_retrieve (long al_coid);Int	li_Return
il_coid = al_coid
li_Return = THIS.Retrieve ( al_coid )
IF li_Return <= 0 THEN
	li_Return = THIS.event pfc_addrow( )
	IF li_Return = 1 THEN
		THIS.SetItemStatus ( 1 , 0 , PRIMARY!,NotModified! )
	END IF
ELSE
	IF THIS.GetItemString ( 1 , "Transfermode" ) = "FTP" THEN
		THIS.of_Formatforftp( )
	ELSE
		THIS.of_Formatforemail( )
	END IF
END IF

RETURN li_Return
	
end function

private subroutine of_formatforemail ();THIS.object.t_target.text = "Target Address"
THIS.object.b_browse.visible = FALSE
THIS.object.t_subjectline.visible = true
this.object.subjectline.visible = TRUE
end subroutine

private subroutine of_formatforftp ();THIS.object.t_target.text = "Target Folder"
THIS.object.b_browse.visible = TRUE
THIS.object.t_subjectline.visible = FALSE
this.object.subjectline.visible = FALSE
end subroutine

on u_dw_companydocumenttransfersettings.create
end on

on u_dw_companydocumenttransfersettings.destroy
end on

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA ) 
ib_Rmbmenu = FALSE
end event

event pfc_addrow;call super::pfc_addrow;Long	ll_Return
ll_Return = AncestorReturnValue
IF ll_Return > 0 THEN
	THIS.SetItem ( ll_Return , "coid" , il_coid )
	THIS.SetITem ( ll_Return , "transfermode" , "FTP" )
	THIS.of_FormatforFtp( )
END IF
RETURN ll_Return
end event

event itemchanged;call super::itemchanged;IF Upper ( dwo.name ) = "TRANSFERMODE" THEN
	IF data = appeon_constant.cs_TransferMethod_EMAIL THEN
		THIS.of_Formatforemail( )		
	ELSE
		THIS.of_FormatForFTP()
	END IF
ELSEIF Upper (dwo.name ) = "TARGETADDRESS" THEN
	String	ls_Value
	ls_Value = Data
	n_cst_string	lnv_String
	ls_Value = lnv_String.of_Globalreplace( ls_Value , ",",';',TRUE )
	THIS.Post setItem( row, dwo.name , ls_Value )	
	RETURN 2
	
	
	
END IF

//appeon_constant.cs_TransferMethod_FTP
end event

event buttonclicked;call super::buttonclicked;IF dwo.name = "b_browse" THEN
	String	ls_Path
	IF GetFolder("FTP Folder",ls_Path) > 0 THEN 
		THIS.SetItem ( 1 , "targetaddress" , ls_Path )
	END IF	
END IF
end event

