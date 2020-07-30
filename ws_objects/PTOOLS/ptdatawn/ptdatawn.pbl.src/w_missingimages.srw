$PBExportHeader$w_missingimages.srw
forward
global type w_missingimages from w_response
end type
type dw_list from u_dw_billingimages within w_missingimages
end type
type dw_filter from datawindow within w_missingimages
end type
type gb_1 from groupbox within w_missingimages
end type
type cb_apply from u_cb within w_missingimages
end type
type cb_remove from u_cb within w_missingimages
end type
end forward

global type w_missingimages from w_response
int Width=2729
int Height=1468
boolean TitleBar=true
string Title="Missing Image Report"
dw_list dw_list
dw_filter dw_filter
gb_1 gb_1
cb_apply cb_apply
cb_remove cb_remove
end type
global w_missingimages w_missingimages

type variables
Private:

n_cst_msg    inv_Msg
end variables

on w_missingimages.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_filter=create dw_filter
this.gb_1=create gb_1
this.cb_apply=create cb_apply
this.cb_remove=create cb_remove
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_filter
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_apply
this.Control[iCurrent+5]=this.cb_remove
end on

on w_missingimages.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_filter)
destroy(this.gb_1)
destroy(this.cb_apply)
destroy(this.cb_remove)
end on

event open;call super::open;ib_disableclosequery = TRUE

n_cst_msg	lnv_msg
s_parm		lstr_Parm

dw_filter.setTransObject( sqlca )

dw_filter.Retrieve()
String	ls_Topic
Int	i

blob	lblb_dw

lnv_msg = message.powerobjectparm
inv_msg = lnv_msg
IF isValid ( lnv_msg ) THEN
	
	IF lnv_msg.of_Get_Parm ( "DATASTORE" , lstr_Parm)  <> 0 THEN
		lblb_dw = lstr_Parm.ia_Value 
		dw_list.SetFullState (lblb_dw)
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "TOPIC" , lstr_Parm ) <> 0 THEN
	ls_Topic = lstr_Parm.ia_Value
		
	END IF

END IF

For i = 1 To dw_filter.RowCount()
	
	dw_filter.object.TypeChecked[i] = "y"
		
NEXT



dw_filter.SetFilter("topic = '"+ls_Topic+" '")	
dw_filter.Filter ( )

cb_apply.triggerevent( clicked! )

end event

type dw_list from u_dw_billingimages within w_missingimages
int X=69
int Y=32
int Height=1312
int TabOrder=10
boolean BringToTop=true
string DataObject="d_missingimages"
end type

event itemchanged;call super::itemchanged;THIS.of_SetInsertable ( FALSE )
THIS.of_SetDeleteable ( FALSE )
end event

type dw_filter from datawindow within w_missingimages
int X=1531
int Y=96
int Width=1106
int Height=732
int TabOrder=30
boolean BringToTop=true
string DataObject="d_imagetypeselect"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;dw_filter.object.topic.width = 0
end event

type gb_1 from groupbox within w_missingimages
int X=1490
int Y=28
int Width=1189
int Height=984
int TabOrder=40
string Text="Show missing..."
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

type cb_apply from u_cb within w_missingimages
int X=1691
int Y=872
int TabOrder=20
boolean BringToTop=true
string Text="Apply Filter"
end type

event clicked;Int	i
Int	j
Int	li_RowCount
String	ls_Type
string 	ls_FilterText
String	lsa_Types[]
Boolean	lb_Match
blob		lblb_dw

s_parm	lstr_Parm

// get a fresh copy of missing images and load it into dw_List
IF inv_msg.of_Get_Parm ( "DATASTORE" , lstr_Parm)  <> 0 THEN
	lblb_dw = lstr_Parm.ia_Value
	dw_list.SetFullState ( lblb_dw )
END IF


For i = 1 To dw_filter.RowCount()
	
	IF dw_filter.object.TypeChecked[i] = "y" THEN
		lsa_Types[ upperBound ( lsa_Types) + 1 ] = dw_filter.object.Type [i] 
	END IF
	
NEXT

li_RowCount = dw_list.RowCount ( )



FOR i = li_RowCount TO 1 Step -1
	ls_Type = dw_list.object.type[i]
	
	lb_Match = False
	For j = 1 TO upperBound ( lsa_Types)
		
		 
		IF lsa_Types[j] = ls_Type THEN
			lb_Match = TRUE
		END IF
	NEXT
	
	IF NOT lb_Match THEN
		dw_list.RowsDiscard (i, i, PRIMARY! )
	END IF
		
	
NEXT

ls_FilterText = "Filter Applied: " 
For j = 1 TO upperBound ( lsa_Types)
	IF j = upperBound ( lsa_Types) THEN
		ls_FilterText += lsa_Types[j] + "."
	ELSE
		ls_FilterText += lsa_Types[j] + ", "
	END IF
NEXT

dw_list.object.Filter.text = ls_FilterText

end event

type cb_remove from u_cb within w_missingimages
int X=2089
int Y=872
int Width=421
int TabOrder=11
boolean BringToTop=true
string Text="Remove Filter"
end type

event clicked;s_Parm	lstr_Parm
String	ls_FilterText
Int 	i
Int	j
String	lsa_Types[]
blob		lblb_dw

IF inv_msg.of_Get_Parm ( "DATASTORE" , lstr_Parm)  <> 0 THEN
	lblb_dw = lstr_Parm.ia_Value
	dw_list.SetFullState (lblb_dw)
END IF

For i = 1 To dw_filter.RowCount()
	
	dw_filter.object.TypeChecked[i] = "y"
		
NEXT
For i = 1 To dw_filter.RowCount()
	
	IF dw_filter.object.TypeChecked[i] = "y" THEN
		lsa_Types[ upperBound ( lsa_Types) + 1 ] = dw_filter.object.Type [i] 
	END IF
	
NEXT

ls_FilterText = "Filter Applied: " 
For j = 1 TO upperBound ( lsa_Types)
	IF j = upperBound ( lsa_Types) THEN
		ls_FilterText += lsa_Types[j] + "."
	ELSE
		ls_FilterText += lsa_Types[j] + ", "
	END IF
NEXT

dw_list.object.Filter.text = ls_FilterText
end event

