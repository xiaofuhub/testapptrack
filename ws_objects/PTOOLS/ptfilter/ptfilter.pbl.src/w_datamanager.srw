$PBExportHeader$w_datamanager.srw
forward
global type w_datamanager from w_popup
end type
type lb_1 from listbox within w_datamanager
end type
type st_name from statictext within w_datamanager
end type
type uo_1 from uo_executeoredit within w_datamanager
end type
type gb_1 from groupbox within w_datamanager
end type
type cb_1 from commandbutton within w_datamanager
end type
type cb_3 from commandbutton within w_datamanager
end type
type dw_1 from u_dw_datapad within w_datamanager
end type
type cb_2 from commandbutton within w_datamanager
end type
type st_1 from statictext within w_datamanager
end type
type p_uppin from picture within w_datamanager
end type
type p_downpin from picture within w_datamanager
end type
end forward

global type w_datamanager from w_popup
integer x = 50
integer y = 1112
integer width = 3433
integer height = 728
string title = "Data Manager"
boolean controlmenu = false
windowtype windowtype = child!
event ue_changemode ( string as_mode )
event ue_reset ( )
event ue_selectview ( )
event ue_key ( )
lb_1 lb_1
st_name st_name
uo_1 uo_1
gb_1 gb_1
cb_1 cb_1
cb_3 cb_3
dw_1 dw_1
cb_2 cb_2
st_1 st_1
p_uppin p_uppin
p_downpin p_downpin
end type
global w_datamanager w_datamanager

type variables
n_cst_Mediator_DataManager	inv_Mediator

Boolean	ib_PinDown

String 	is_Path
String	is_Buffer
Boolean   ib_Small
end variables

forward prototypes
private function long wf_getidfromname (string as_name)
public function integer wf_setnewview (string as_path)
public function integer wf_populateviewlist ()
public function integer wf_copy (String asa_Names[])
public function integer wf_pindown ()
public function integer wf_pinup ()
end prototypes

event ue_changemode;dw_1.Event ue_ChangeMode ( as_mode )
end event

event ue_reset;IF inv_Mediator.of_Reset ( ) = 1 THEN
	THIS.st_Name.Text = "Untitled"
END IF




end event

event ue_key;IF ib_Small THEN
	ib_Small = FALSE
	This.Height = 704
	THIS.y = 1112
ELSE
	ib_Small = TRUE
	This.Height = 0
	THIS.y = 1728
END IF
	
end event

private function long wf_getidfromname (string as_name);
Int		li_Pos
Long		ll_ID = -1
//String	ls_ID
//
//li_Pos = POS( as_Name , "do_" )
//
//IF li_Pos > 0 THEN
//	ls_ID = Right ( as_Name ,  len ( as_Name ) - 3 ) 	
//	IF isNumber ( ls_ID ) THEN
//		ll_ID = Long ( ls_id )
//	END IF
//	
//END IF

RETURN ll_ID
	
end function

public function integer wf_setnewview (string as_path);n_cst_string 	lnv_String


String ls_Name
String lsa_Result[]

lnv_String.of_ParseToArray ( as_Path , "\" , lsa_Result )

ls_name = lsa_Result [UpperBound ( lsa_Result ) ]

IF inv_Mediator.of_Import ( as_Path ) = 1 THEN
	THIS.st_Name.Text = ls_Name
END IF



Return 1
end function

public function integer wf_populateviewlist ();Int		li_Count
Int   	i
String	lsa_Items[]

n_cst_FileSrvWin32	lnv_File

lnv_File = CREATE n_cst_FileSrvWin32
lb_1.SetRedraw ( FALSE )

is_Path = inv_Mediator.of_GetPath ( )

IF NOT  lnv_File.of_DirectoryExists ( is_Path )THEN
	lnv_File.of_CreateDirectory ( is_Path )
END IF

lb_1.DirList(is_Path + "*.psr", 0)

li_Count = lb_1.TotalItems ( )

For i = 1 TO li_Count
	lb_1.SelectItem ( i )
	lsa_Items [ i ] = lb_1.SelectedItem ( )
NEXT

lb_1.Reset ( )
FOR i = 1 TO li_Count 
	lb_1.AddItem (  Left ( lsa_Items [ i ], Len ( lsa_Items [ i ] ) - 4 ) )	
NEXT

lb_1.SetRedraw ( TRUE )
DESTROY ( lnv_File )

return 1



end function

public function integer wf_copy (String asa_Names[]);
String	ls_Attributes
String	ls_Name
int		i

FOR i = 1 TO upperBound ( asa_Names )
	ls_Name = asa_names[i]

	ls_Attributes = dw_1.Describe ( "'"+ls_Name + ".Attributes'" )	
NEXT

RETURN 1
end function

public function integer wf_pindown ();THIS.ib_PinDown = TRUE
p_downpin.Visible = TRUE
p_uppin.Visible = FALSE

inv_Mediator.of_PinDown ( ) 
RETURN 1
end function

public function integer wf_pinup ();THIS.ib_PinDown = FALSE
p_downpin.Visible = FALSE
p_uppin.Visible = TRUE

inv_Mediator.of_PinUp ( )

RETURN 1
end function

on w_datamanager.create
int iCurrent
call super::create
this.lb_1=create lb_1
this.st_name=create st_name
this.uo_1=create uo_1
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_3=create cb_3
this.dw_1=create dw_1
this.cb_2=create cb_2
this.st_1=create st_1
this.p_uppin=create p_uppin
this.p_downpin=create p_downpin
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lb_1
this.Control[iCurrent+2]=this.st_name
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.p_uppin
this.Control[iCurrent+11]=this.p_downpin
end on

on w_datamanager.destroy
call super::destroy
destroy(this.lb_1)
destroy(this.st_name)
destroy(this.uo_1)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.p_uppin)
destroy(this.p_downpin)
end on

event open;call super::open;inv_Mediator = Message.PowerObjectParm

Long	ll_Width

THIS.of_SetResize ( TRUE )
inv_Resize.of_Register ( dw_1 , "ScaleToRight&Bottom") 
inv_Resize.of_Register ( uo_1 , "FixedToRight") 

IF isValid( inv_Mediator ) THEN
	inv_Mediator.of_SetDataManager ( dw_1 )
END IF

inv_Mediator.of_ShowDataManager ( )
ll_Width = inv_Mediator.idw_Target.Width - 10
THIS.x = inv_Mediator.idw_Target.x + 5
THIS.Width = ll_Width

THIS.wf_PopulateViewList ( )

DO
	THIS.height += 80
	THIS.y  = inv_Mediator.idw_Target.y + inv_Mediator.idw_Target.Height - THIS.height

loop while THIS.height < 728
end event

event pfc_save;call super::pfc_save;MessageBox ( "pfc_save" , String ( AncestorReturnValue  )  )


RETURN AncestorReturnValue
end event

event closequery;call super::closequery;Long	ll_Rtn
Boolean	lb_AskToSave = TRUE
ll_Rtn = AncestorReturnValue

IF ll_Rtn = 0 THEN
	IF inv_Mediator.ib_Change THEN
		IF inv_Mediator.of_Save  ( lb_AskToSave ) = 0 THEN  // user canceled
			ll_Rtn = 1 //		1  Prevent the window from closing
		ELSE
			THIS.Event ue_Reset ( )
		END IF
	ELSE
		THIS.Event ue_Reset ( )
	END IF
END IF

RETURN ll_Rtn
end event

event close;call super::close;THIS.wf_PinUp ( )
end event

type lb_1 from listbox within w_datamanager
event ue_delete ( )
integer x = 306
integer y = 128
integer width = 562
integer height = 444
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
integer accelerator = 118
borderstyle borderstyle = stylelowered!
end type

event ue_delete;String	ls_SelectedItem

ls_SelectedItem = THIS.SelectedItem ( )

IF len ( ls_SelectedItem  ) > 0 THEN
	IF MessageBox ("Delete File" , "Are you sure you want to permanently delete the view ~"" + ls_SelectedItem + "~"?", QUESTION! , YESNO! , 2 ) = 1 THEN
		IF NOT FileDelete ( is_Path + ls_SelectedItem + ".psr" )  THEN
			MessageBox( "Delete View" , "Could not delete the selected view." )
		ELSE
			IF ls_SelectedItem = inv_Mediator.is_Name THEN
				Parent.Event ue_Reset ( )
			END IF
			wf_PopulateViewList ( )
		END IF
	END IF
ELSE
	MessageBox ( "Delete View" , "Please select the view you wish to delete." )
END IF


end event

event doubleclicked;parent.wf_SetNewView ( is_path + THIS.SelectedItem ( )  )
end event

type st_name from statictext within w_datamanager
integer x = 914
integer y = 28
integer width = 686
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Untitled"
boolean focusrectangle = false
end type

type uo_1 from uo_executeoredit within w_datamanager
integer x = 2770
integer y = 24
integer height = 64
integer taborder = 60
boolean bringtotop = true
boolean border = false
end type

event ue_modechanged;Parent.Event ue_ChangeMode ( as_mode )
end event

on uo_1.destroy
call uo_executeoredit::destroy
end on

event constructor;CHOOSE CASE THIS.rb_Execute.Checked
	CASE TRUE
		THIS.Event ue_ModeChanged ( "EXECUTE!" )
	CASE FALSE
		THIS.Event ue_ModeChanged ( "EDIT!" )		
END CHOOSE

end event

type gb_1 from groupbox within w_datamanager
integer x = 9
integer y = 68
integer width = 887
integer height = 532
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Views"
end type

type cb_1 from commandbutton within w_datamanager
integer x = 37
integer y = 384
integer width = 256
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Delete"
end type

event clicked;lb_1.Event ue_Delete ( )
end event

type cb_3 from commandbutton within w_datamanager
integer x = 37
integer y = 484
integer width = 256
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Save"
end type

event clicked;Boolean	lb_AskToSave = FALSE
inv_Mediator.of_Save ( lb_AskToSave )

//dw_1.event ue_Save ( )
end event

type dw_1 from u_dw_datapad within w_datamanager
event ue_key pbm_dwnkey
integer x = 905
integer y = 100
integer width = 2464
integer height = 496
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_datapad"
end type

event ue_filterchanged;inv_Mediator.of_Filter ( THIS.is_Filter )
end event

event ue_details;inv_Mediator.of_DisplayDetails ( dwo )

end event

event ue_delete;
IF inv_Mediator.of_Delete ( dwo ) = 1 THEN
	THIS.Modify ( "destroy " + dwo.Name )
END IF
end event

event ue_save;String	ls_Name
Boolean  lb_Again 
Long		ll_Return = 1
n_cst_ReturnAttrib	lnv_RtnAttrib
DO 
	OpenWithParm  ( w_SaveDataView , inv_Mediator.is_Name)
	lnv_RtnAttrib = Message.PowerObjectParm
	
	IF lnv_RtnAttrib.ii_rc = 1 THEN
		ls_Name = Trim ( lnv_RtnAttrib.is_rs)
		IF Len ( ls_Name ) > 0 THEN
			
			IF FileExists ( is_Path + ls_Name + ".psr" ) THEN
				IF MessageBox ( "Save" , "The name " + ls_Name + " already exists. Do you want to overwrite it?" , QUESTION! , YESNO! ) = 2 THEN
					lb_Again = TRUE
				END IF
			ELSE
				lb_Again = FALSE
			END IF
			
		ELSE
			
			lb_Again = TRUE
		END IF
		
	ELSE  // user canceled
		lb_Again = FAlSE
	END IF

LOOP WHILE lb_Again
		
IF Len ( ls_Name ) > 0 THEN
	Parent.st_name.Text = ls_Name
	THIS.SaveAs ( is_Path + ls_Name + ".psr" , PSReport! , FALSE )
	inv_Mediator.is_Name = ls_Name
	wf_PopulateViewList ( )
	
	ll_Return = 1
ELSE
	ll_Return = 0
END IF

RETURN ll_Return
end event

event ue_new;inv_Mediator.of_CreateFilterObject ( )
end event

event ue_reset;Parent.Event ue_Reset ( )
end event

event ue_copy;String	ls_Describe
String	ls_Attributes
String	ls_Name
String	lsa_Objects[]
String	ls_CurrentAttrib 
String	ls_Buffer
Long		ll_Count
Long		li_AttribCount
String	lsa_Attributes[]
int		i, j
n_cst_String 	lnv_String
n_cst_dws		lnv_dws

ll_Count = lnv_Dws.of_GetObjectsAtPosition ( This, ai_xpos, ai_ypos, "header", lsa_Objects )
IF ll_Count > 0 THEN
	ls_Name = lsa_Objects[ ll_Count ]	
	ls_Describe =  ls_Name + ".Attributes" 
	ls_Attributes = dw_1.Describe ( ls_Describe  )	
	li_AttribCount = lnv_String.of_ParseToArray ( ls_Attributes ,"~t" , lsa_Attributes )
	
	FOR i = 1 TO ll_Count  // loop through all the objects
		ls_Name = lsa_Objects[i]		
		
		FOR j = 4 TO li_AttribCount // loop through all the attributes
			ls_CurrentAttrib = lsa_Attributes[j]
			ls_Describe = ls_Name + "." + ls_CurrentAttrib
			ls_Attributes = dw_1.Describe ( ls_Describe  )	
			ls_Buffer += ls_CurrentAttrib +"=" + ls_Attributes + " "
		NEXT
		
	NEXT
END IF
is_Buffer = ls_Buffer
messageBox( "BUFFER" , ls_Buffer )
//	MessageBox ("Arrtib" , ls_Attributes )

RETURN 1
end event

event ue_paste;
//String	ls_Mod
//ls_mod = "Create
//THIS.
end event

type cb_2 from commandbutton within w_datamanager
integer x = 37
integer y = 284
integer width = 256
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&New"
end type

event clicked;parent.Event ue_reset ( )
end event

type st_1 from statictext within w_datamanager
integer x = 1806
integer y = 32
integer width = 590
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Ctrl = AND     Shift = OR"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_uppin from picture within w_datamanager
integer x = 5
integer width = 73
integer height = 60
boolean originalsize = true
string picturename = "uppin.bmp"
boolean focusrectangle = false
end type

event clicked;wf_PinDown ( )
end event

type p_downpin from picture within w_datamanager
integer x = 5
integer width = 73
integer height = 60
boolean originalsize = true
string picturename = "downpin.bmp"
boolean focusrectangle = false
end type

event clicked;wf_pinUp ( )
end event

