$PBExportHeader$w_missingimagetypeselection.srw
forward
global type w_missingimagetypeselection from w_response
end type
type gb_2 from u_gb within w_missingimagetypeselection
end type
type gb_1 from groupbox within w_missingimagetypeselection
end type
type cb_1 from u_cbok within w_missingimagetypeselection
end type
type cb_2 from u_cbcancel within w_missingimagetypeselection
end type
type ddlb_format from u_ddlb within w_missingimagetypeselection
end type
type st_1 from u_st within w_missingimagetypeselection
end type
type dw_filter from u_dw_documenttypelist within w_missingimagetypeselection
end type
type cbx_1 from checkbox within w_missingimagetypeselection
end type
type cbx_2 from checkbox within w_missingimagetypeselection
end type
end forward

global type w_missingimagetypeselection from w_response
integer x = 1170
integer y = 368
integer width = 1271
integer height = 1864
string title = "Missing Documents Report"
long backcolor = 12632256
gb_2 gb_2
gb_1 gb_1
cb_1 cb_1
cb_2 cb_2
ddlb_format ddlb_format
st_1 st_1
dw_filter dw_filter
cbx_1 cbx_1
cbx_2 cbx_2
end type
global w_missingimagetypeselection w_missingimagetypeselection

type variables
Private:

n_cst_msg    inv_Msg
end variables

on w_missingimagetypeselection.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.ddlb_format=create ddlb_format
this.st_1=create st_1
this.dw_filter=create dw_filter
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.ddlb_format
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_filter
this.Control[iCurrent+8]=this.cbx_1
this.Control[iCurrent+9]=this.cbx_2
end on

on w_missingimagetypeselection.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.ddlb_format)
destroy(this.st_1)
destroy(this.dw_filter)
destroy(this.cbx_1)
destroy(this.cbx_2)
end on

event open;call super::open;// RDT 102302 Added code to check for Licenses and Load other document types
ib_disableclosequery = TRUE

n_cst_LicenseManager	lnv_LicenseManager

n_cst_msg	lnv_msg
s_parm		lstr_Parm


dw_filter.setTransObject( sqlca )

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Imaging ) THEN
	dw_filter.Retrieve()
	Commit;
End If

String	ls_Topic
Int	i

lnv_msg = message.powerobjectparm
inv_msg = lnv_msg
IF isValid ( lnv_msg ) THEN

	IF lnv_Msg.of_Get_Parm ( "TOPIC" , lstr_Parm ) <> 0 THEN
		ls_Topic = lstr_Parm.ia_Value
	END IF

END IF

// RDT 102302 Load other document types
If lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Notification ) Then 
	dw_filter.of_retrievedocumenttypes ( )			
End If

For i = 1 To dw_filter.RowCount()
	 dw_filter.object.TypeChecked[i] = "y" 
NEXT

dw_filter.SetFilter("topic = '"+ls_Topic+" '")	
dw_filter.Filter ( )


ddlb_format.text = "Mark Missing Documents"

end event

event pfc_default;
S_parm 	lstr_Parm
String	lsa_Types[]
Int		i


For i = 1 To dw_filter.RowCount()
	IF dw_filter.object.TypeChecked[i] = "y" THEN
		lsa_Types[ upperBound ( lsa_Types ) + 1 ] = dw_filter.object.Type[i]
	END IF
NEXT

lstr_Parm.is_Label = "TYPES"
lstr_Parm.ia_Value = lsa_Types
inv_msg.of_Add_Parm( lstr_Parm ) 

lstr_Parm.is_Label = "CONTINUE"
lstr_Parm.ia_Value = TRUE
inv_msg.of_Add_Parm( lstr_Parm ) 

lstr_Parm.is_Label = "FORMAT"
lstr_Parm.ia_Value = ddlb_format.text
inv_msg.of_Add_Parm( lstr_Parm ) 

Close( THIS )

end event

event pfc_cancel;call super::pfc_cancel;S_Parm lstr_Parm


lstr_Parm.is_Label = "CONTINUE"
lstr_Parm.ia_Value = FALSE
inv_msg.of_Add_Parm( lstr_Parm ) 

Close ( THIS )
end event

event close;call super::close;
closeWithReturn ( THIS, inv_Msg )
end event

type cb_help from w_response`cb_help within w_missingimagetypeselection
integer y = 1520
end type

type gb_2 from u_gb within w_missingimagetypeselection
integer x = 14
integer y = 1452
integer width = 1221
integer height = 164
integer taborder = 20
long backcolor = 12632256
string text = ""
end type

type gb_1 from groupbox within w_missingimagetypeselection
integer x = 14
integer y = 24
integer width = 1221
integer height = 1428
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Document Types To Query"
end type

type cb_1 from u_cbok within w_missingimagetypeselection
integer x = 329
integer y = 1652
integer width = 233
integer taborder = 50
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_missingimagetypeselection
integer x = 667
integer y = 1652
integer width = 233
integer taborder = 40
boolean bringtotop = true
end type

type ddlb_format from u_ddlb within w_missingimagetypeselection
integer x = 553
integer y = 1504
integer width = 654
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 1090519039
string item[] = {"Mark Missing Documents","Mark Documents on File"}
end type

type st_1 from u_st within w_missingimagetypeselection
integer x = 73
integer y = 1512
integer width = 453
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 12632256
string text = "Display Format :"
end type

type dw_filter from u_dw_documenttypelist within w_missingimagetypeselection
integer x = 32
integer y = 200
integer width = 1175
integer height = 1232
integer taborder = 10
boolean bringtotop = true
end type

type cbx_1 from checkbox within w_missingimagetypeselection
integer x = 224
integer y = 100
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Images"
boolean checked = true
end type

event clicked;dw_filter.of_makeselections( "Image",THIS.Checked)
end event

type cbx_2 from checkbox within w_missingimagetypeselection
integer x = 603
integer y = 100
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&E-Mail"
boolean checked = true
end type

event clicked;dw_filter.of_makeselections( "email",THIS.Checked)
end event

