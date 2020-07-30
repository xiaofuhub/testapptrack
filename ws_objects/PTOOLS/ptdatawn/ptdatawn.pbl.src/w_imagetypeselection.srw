$PBExportHeader$w_imagetypeselection.srw
forward
global type w_imagetypeselection from w_response
end type
type gb_1 from groupbox within w_imagetypeselection
end type
type cb_1 from u_cbok within w_imagetypeselection
end type
type cb_2 from u_cbcancel within w_imagetypeselection
end type
type dw_documents from u_dw_documenttypelist within w_imagetypeselection
end type
end forward

global type w_imagetypeselection from w_response
int X=1170
int Y=368
int Width=1312
int Height=1576
boolean TitleBar=true
string Title="Image Selection"
long BackColor=80269524
gb_1 gb_1
cb_1 cb_1
cb_2 cb_2
dw_documents dw_documents
end type
global w_imagetypeselection w_imagetypeselection

type variables
Private:

n_cst_msg    inv_Msg
end variables

on w_imagetypeselection.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_documents=create dw_documents
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_documents
end on

on w_imagetypeselection.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_documents)
end on

event open;call super::open;
ib_disableclosequery = TRUE

s_parm		lstr_Parm

String	ls_Images[], &
			ls_Find
Int		i
Long 		ll_Row, &
			ll_MaxRow


inv_msg = message.powerobjectparm

dw_documents.SetTransObject( SQLCA ) 
ll_MaxRow = dw_documents.Retrieve( ) 

IF isValid ( inv_msg ) THEN

	If inv_Msg.of_Get_Parm ( "IMAGES" , lstr_Parm ) <> 0 THEN
		ls_Images[] = lstr_Parm.ia_Value
	End If

	// find images in datawidow and mark found ones as checked
	
	For i =  1 to Upperbound( ls_Images[] ) 
		ls_Find = "type = '" + ls_Images[i] + "'"
		ll_Row = dw_Documents.Find( ls_find, 1 , ll_MaxRow)
		If ll_row > 0 then 
			dw_Documents.SetItem( ll_Row, 'typechecked', 'y' )
		End If
	Next

END IF



end event

event pfc_default;
S_parm 	lstr_Parm
String	lsa_Images[]
Int		i

// reset message
inv_Msg.of_Reset()

For i = 1 To dw_documents.RowCount()
	IF dw_documents.object.TypeChecked[i] = "y" THEN
		lsa_Images[ upperBound ( lsa_Images ) + 1 ] = dw_documents.object.Type[i]
	END IF
NEXT

lstr_Parm.is_Label = "IMAGES"
lstr_Parm.ia_Value = lsa_Images[]
inv_msg.of_Add_Parm( lstr_Parm ) 

Close( THIS )

end event

event pfc_cancel;call super::pfc_cancel;
S_Parm lstr_Parm

lstr_Parm.is_Label = "CANCEL"
lstr_Parm.ia_Value = TRUE
inv_msg.of_Add_Parm( lstr_Parm ) 

Close ( THIS )
end event

event close;call super::close;
CloseWithReturn ( THIS, inv_Msg )
end event

type gb_1 from groupbox within w_imagetypeselection
int X=32
int Y=24
int Width=1189
int Height=1264
int TabOrder=40
string Text="Images / Documents"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from u_cbok within w_imagetypeselection
int X=320
int Y=1348
int TabOrder=30
boolean BringToTop=true
end type

type cb_2 from u_cbcancel within w_imagetypeselection
int X=658
int Y=1348
int TabOrder=20
boolean BringToTop=true
end type

type dw_documents from u_dw_documenttypelist within w_imagetypeselection
int X=41
int Y=112
int Width=1161
int Height=1132
int TabOrder=10
boolean BringToTop=true
end type

