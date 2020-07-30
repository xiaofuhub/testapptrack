$PBExportHeader$w_amounttemplates.srw
forward
global type w_amounttemplates from w_sheet
end type
type dw_list from u_dw_amounttemplatelist within w_amounttemplates
end type
type st_amounttemplates from u_st_label within w_amounttemplates
end type
type mle_datalist from u_mle within w_amounttemplates
end type
type st_2 from u_st_label within w_amounttemplates
end type
type cb_import from u_cb within w_amounttemplates
end type
type rb_global from radiobutton within w_amounttemplates
end type
type rb_entity from radiobutton within w_amounttemplates
end type
type dw_entity from u_dw_entitylist within w_amounttemplates
end type
type mle_cover from multilineedit within w_amounttemplates
end type
type cb_copy from u_cb within w_amounttemplates
end type
type cb_paste from u_cb within w_amounttemplates
end type
type cb_employee from commandbutton within w_amounttemplates
end type
type cb_company from commandbutton within w_amounttemplates
end type
type gb_1 from groupbox within w_amounttemplates
end type
type st_1 from statictext within w_amounttemplates
end type
type mle_filterlist from multilineedit within w_amounttemplates
end type
end forward

global type w_amounttemplates from w_sheet
integer x = 59
integer y = 112
integer width = 3451
integer height = 2040
string title = "Payables Setup"
string menuname = "m_sheets"
event ue_showglobals ( )
event ue_retrieveentity ( )
event ue_retrieveglobal ( )
event ue_retrieveentitytemplates ( )
event ue_showentitytemplates ( )
event ue_changeentity ( )
event ue_choosecompany ( )
event ue_chooseemployee ( )
event ue_paste ( )
event ue_copy ( )
dw_list dw_list
st_amounttemplates st_amounttemplates
mle_datalist mle_datalist
st_2 st_2
cb_import cb_import
rb_global rb_global
rb_entity rb_entity
dw_entity dw_entity
mle_cover mle_cover
cb_copy cb_copy
cb_paste cb_paste
cb_employee cb_employee
cb_company cb_company
gb_1 gb_1
st_1 st_1
mle_filterlist mle_filterlist
end type
global w_amounttemplates w_amounttemplates

type variables
Private n_cst_beo_Entity	inv_Entity
Private n_cst_Bcm		inv_EntityBCM
Private Boolean  		ib_Changes

long	il_EntityID

n_ds	ids_ClipBoard
end variables

forward prototypes
public function integer wf_settitle ()
public function integer wf_resettitle ()
public function boolean wf_changes ()
end prototypes

event ue_showglobals;Int	li_Updates
String ls_SaveString 
Boolean	lb_Continue = TRUE

n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query
ls_SaveString = "Do you want to save the changes you made to the templates?"

//li_Updates = of_UpdateChecks()  //Use this version instead.
//If li_Updates <= 0 Then
//	
//	//	 0 = No pending changes found 
//	//	-1 = AcceptText error
//	//	-2 = UpdatesPending error was encountered
//	//	-3 = Validation error was encountered		
//ELSE
IF wf_Changes ( ) THEN
	CHOOSE CASE MessageBox ( "Save Changes" , ls_SaveString , QUESTION!, YESNOCANCEL! ) 
		CASE 1
			THIS.event pfc_save ( )
		CASE 2
			// don't save
		CASE 3
			lb_Continue = FALSE
	END CHOOSE

END IF

IF lb_Continue THEN
	// make visual changes to the window
	dw_entity.Visible = FALSE	
	dw_list.enabled = true
	cb_paste.enabled = true
	cb_copy.enabled = true
	cb_import.enabled = true
	mle_Cover.Visible = TRUE
	cb_company.Enabled = FALSE
	cb_employee.Enabled = FALSE
	st_amounttemplates.Text = "Global Amount Templates"
	THIS.wf_ResetTitle ( )
	
	// get the global templates
	lnv_database = gnv_bcmmgr.GetDatabase()
	If IsValid(lnv_database) Then
		lnv_query = lnv_database.GetQuery()
		lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_amounttemplate","","global")
	End If
	IF isValid ( lnv_Bcm ) THEN
		dw_List.inv_UILink.SetBCM ( lnv_Bcm )	
		Destroy( inv_entity ) 
	END IF
ELSE
	rb_entity.SetFocus ( )
	rb_entity.Checked = TRUE
END IF
end event

event ue_retrieveentity;n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query

lnv_database = gnv_bcmmgr.GetDatabase()

If IsValid(lnv_database) Then

	dw_entity.Retrieve ( {il_EntityID} )
	COMMIT;
	
	THIS.wf_SetTitle ( )
	
   lnv_query = lnv_database.GetQuery()
   lnv_query.SetArgument(il_EntityID)
	lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_entity","","")

	IF IsValid ( lnv_Bcm ) THEN
		inv_Entity = lnv_Bcm.GetFirst ( )
		inv_EntityBCM = lnv_BCM
	END IF

End If
end event

event ue_retrieveentitytemplates;
n_cst_bcm	lnv_TemplateBcm

IF IsValid ( inv_Entity ) THEN

	//lnv_TemplateBcm = inv_Entity.of_GetAmountTemplate ( )

	//This is how Riverton task_retrieve code does it -- gnv_BcmMgr.CreateBcm --
	//so I figured I'd use that, too.
	lnv_TemplateBcm = gnv_bcmmgr.CreateBCM ( inv_Entity.of_GetAmountTemplate ( ) )

	IF IsValid ( lnv_TemplateBcm ) THEN
		dw_List.inv_UILink.SetBCM ( lnv_TemplateBcm )
	END IF

END IF

end event

event ue_showentitytemplates;String	ls_SaveString
Int		li_Updates
Boolean	lb_Continue = TRUE

ls_SaveString = "Do you want to save the changes you made to the templates?"

//li_Updates = of_UpdateChecks()  //Use this version instead.
//If li_Updates <= 0 Then
//	
//	//	 0 = No pending changes found 
//	//	-1 = AcceptText error
//	//	-2 = UpdatesPending error was encountered
//	//	-3 = Validation error was encountered
//	
//ELSE
IF wf_Changes ( ) THEN
	CHOOSE CASE MessageBox ( "Save Changes" , ls_SaveString , QUESTION!, YESNOCANCEL! ) 
		CASE 1
			THIS.event pfc_save ( )
		CASE 2
			// don't save
		CASE 3
			lb_Continue = FALSE
	END CHOOSE

END IF


IF lb_Continue THEN
	dw_entity.Visible = TRUE
	mle_Cover.Visible = FALSE
	cb_company.Enabled = TRUE
	cb_employee.Enabled = TRUE
	IF NOT IsValid ( inv_Entity ) THEN
		THIS.Event ue_RetrieveEntity ( )
	END IF
	if not isvalid ( inv_Entity ) then
		dw_entity.reset()
		dw_list.reset()
		dw_list.enabled = false
		cb_paste.enabled = false
		cb_copy.enabled = false
		cb_import.enabled = false
	else
		THIS.Event ue_RetrieveEntityTemplates ( )
		THIS.wf_SetTitle ( )
		dw_list.enabled = true
		cb_paste.enabled = true
		cb_copy.enabled = true
		cb_import.enabled = true

	end if
		st_amounttemplates.Text = "Amount Templates"
ELSE
	rb_global.SetFocus (  )
	rb_global.Checked = TRUE
END IF
end event

event ue_choosecompany();Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Long		ll_ValidateId = 0
Boolean	lb_Search = false
Boolean  lb_Employee 
Boolean	lb_Company
Boolean	lb_validate
String	ls_Search = ""
String	ls_type
Long		ll_EntityId
String	ls_MessageHeader
integer	li_Return

String 	ls_Entity
s_co_Info	lstr_Company

IF Len ( ls_Entity ) > 0 THEN

	lb_Search = TRUE
	ls_Search = ls_Entity

END IF

li_Return = gnv_cst_Companies.of_Select &
	( lstr_Company, ls_Type, lb_Search, ls_Search, lb_Validate, &
	  ll_ValidateId, lb_AllowHold, lb_Notify )
 
gnv_cst_Companies.of_GetEntity (lstr_Company.co_id, ll_EntityId, &
	TRUE /*AllowCreate*/, TRUE /*AskToCreate*/ , FALSE /*OpenSetup*/ )
 
 
IF ll_EntityID > 0 THEN
	il_EntityID = ll_EntityID
	DESTROY ( inv_Entity )
	EVENT ue_ShowEntityTemplates ( )
END IF
 

end event

event ue_chooseemployee;String 	ls_Empty = ""
long		ll_EntityID
Boolean	lb_AllowCreate = TRUE
Boolean	lb_createquery = TRUE

n_cst_EmployeeManager	lnv_EmpManager

lnv_EmpManager.of_getentitybyentry ( ls_Empty, ll_EntityID, lb_allowcreate, lb_createquery )

IF ll_EntityID > 0 THEN
	il_entityid = ll_EntityID
	DESTROY (inv_Entity )
	EVENT ue_ShowEntityTemplates ( )
END IF


end event

event ue_paste;Long	ll_RowCount
Long	ll_NewRow
Long	ll_Row
Int	li_ColCount
Int	li_Column
Any	la_Data
String	ls_ColumnName


ll_RowCount = ids_ClipBoard.rowCount ( )
li_ColCount = Integer ( ids_ClipBoard.Describe ( "datawindow.column.count") )

FOR ll_Row = 1 TO ll_RowCount 
	ll_newRow = dw_list.InsertRow (0)
	IF ll_NewRow > 0 THEN
		FOR li_Column = 2 TO li_ColCount
			
			ls_columnname = dw_list.Describe ( "#" + String( li_column ) + ".name" )
			la_Data = ids_ClipBoard.inv_BAse.of_getItemAny ( ll_Row , ls_ColumnName )
			dw_list.SetItem ( ll_newRow, "#"+String(li_column) , la_Data )		
			
			
		NEXT 
	ELSE
		//MessageBox ( "Template Import" , "An error occurred while attempting to import amounts template." )
		EXIT
	END IF
NEXT
end event

event ue_copy;Long	ll_Row
ids_Clipboard.Reset ( )
ll_Row = dw_list.GetSelectedRow ( 0 )
dw_list.RowsCopy (ll_Row, ll_Row, PRIMARY!, ids_ClipBoard, 999, PRIMARY!) 
end event

public function integer wf_settitle ();String	ls_Entity
n_cst_bso_TransactionManager	lnv_TransactionManager
lnv_TransactionManager = CREATE n_cst_bso_TransactionManager

IF IsValid (lnv_transactionmanager) THEN
	ls_Entity = lnv_transactionmanager.of_DescribeEntity ( il_EntityID , 0  ) // 0????
	THIS.Title ="Payables Setup" + " -- " + ls_Entity
END IF

IF isValid ( lnv_TransactionManager ) THEN
	DESTROY  (lnv_TransactionManager ) 
END IF

RETURN 1
end function

public function integer wf_resettitle ();THIS.Title = "Payables Setup"
RETURN 1
end function

public function boolean wf_changes ();Boolean	lb_Rtn

IF of_UpdateChecks ( ) > 0 OR ib_Changes THEN
	lb_Rtn = TRUE
END IF

RETURN lb_Rtn
end function

on w_amounttemplates.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_list=create dw_list
this.st_amounttemplates=create st_amounttemplates
this.mle_datalist=create mle_datalist
this.st_2=create st_2
this.cb_import=create cb_import
this.rb_global=create rb_global
this.rb_entity=create rb_entity
this.dw_entity=create dw_entity
this.mle_cover=create mle_cover
this.cb_copy=create cb_copy
this.cb_paste=create cb_paste
this.cb_employee=create cb_employee
this.cb_company=create cb_company
this.gb_1=create gb_1
this.st_1=create st_1
this.mle_filterlist=create mle_filterlist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.st_amounttemplates
this.Control[iCurrent+3]=this.mle_datalist
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_import
this.Control[iCurrent+6]=this.rb_global
this.Control[iCurrent+7]=this.rb_entity
this.Control[iCurrent+8]=this.dw_entity
this.Control[iCurrent+9]=this.mle_cover
this.Control[iCurrent+10]=this.cb_copy
this.Control[iCurrent+11]=this.cb_paste
this.Control[iCurrent+12]=this.cb_employee
this.Control[iCurrent+13]=this.cb_company
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.mle_filterlist
end on

on w_amounttemplates.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.st_amounttemplates)
destroy(this.mle_datalist)
destroy(this.st_2)
destroy(this.cb_import)
destroy(this.rb_global)
destroy(this.rb_entity)
destroy(this.dw_entity)
destroy(this.mle_cover)
destroy(this.cb_copy)
destroy(this.cb_paste)
destroy(this.cb_employee)
destroy(this.cb_company)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.mle_filterlist)
end on

event open;call super::open;Long		ll_EntityId
String	ls_Entity


ll_EntityId = Message.DoubleParm

gf_Mask_Menu ( m_Sheets )


//Check whether user has authorization to perform entity setup.

n_cst_Privileges	lnv_Privileges

IF lnv_Privileges.of_Settlements_EntitySetup ( ) = TRUE THEN
	//User is authorized.
ELSE
	MessageBox ( "Entity Payables Setup", lnv_Privileges.of_GetRestrictMessage ( ) )
	Close ( This )
	RETURN
END IF
if ll_EntityId = 0 then
	//global setup
	rb_global.checked = true
	rb_global.triggerevent(clicked!)
else
	il_EntityID = ll_EntityId
	dw_Entity.Retrieve ( { il_EntityID } )
	COMMIT ;

	//Append Entity Name to title of window
	THIS.wf_SetTitle ( )

	//Retrieve the Entity BEO
	THIS.Event ue_RetrieveEntity ( ) 
	
	//Retrieve and populate the templates for the above entity
	THIS.Event ue_RetrieveEntityTemplates ( )
end if

//Enable the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize ( 1300, 400 )

//Register Resizable controls
inv_Resize.of_Register ( dw_Entity, 'ScaleToRight' )
inv_Resize.of_Register ( mle_cover, 'ScaleToRight' )
inv_Resize.of_Register ( dw_List, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( mle_DataList, 'ScaleToRight' )
inv_Resize.of_Register ( mle_FilterList, 'ScaleToRight' )
inv_Resize.of_Register ( cb_import, 'FixedToRight' )
inv_Resize.of_Register ( rb_entity, 'FixedToRight' )
inv_Resize.of_Register ( rb_global, 'FixedToRight' )
inv_Resize.of_Register ( cb_copy, 'FixedToRight' )
inv_Resize.of_Register ( cb_paste, 'FixedToRight' )

dw_List.SetFocus ( )

ids_ClipBoard = CREATE n_ds
ids_ClipBoard.dataObject = dw_List.DataObject
ids_ClipBoard.of_SetBase ( True )

end event

event close;call super::close;gnv_BcmMgr.DestroyBCM ( inv_EntityBCM )
DESTROY ( ids_Clipboard )
end event

type dw_list from u_dw_amounttemplatelist within w_amounttemplates
event ue_import ( )
integer x = 27
integer y = 1084
integer width = 3346
integer taborder = 80
boolean bringtotop = true
end type

event ue_import;call super::ue_import;
INT 	li_Column
Int	li_ColCount
Long	ll_Row
Long	ll_NewRow
Long	ll_RowCount
Int	li_importReturn

Any	la_Data
String ls_ColumnName

String	ls_Title = "Template File Location"
String	ls_PathName = "C:\"
String 	ls_FileName
String	ls_Extension
String	ls_Filter = "Text Files  (*.txt),*.txt, All Files (*.*),*.*"
Int		li_OpenReturn
Int		li_FileHandle
Int		li_Start
String 	ls_Result


n_ds lds_Test
lds_Test = CREATE n_ds

lds_Test.dataObject = THIS.DataObject

lds_Test.of_SetBase ( TRUE )

li_OpenReturn = GetFileOpenName ( ls_title, ls_pathname, ls_filename  , ls_extension , ls_filter  )

IF li_openReturn = 1 THEN
	li_FileHandle = FileOpen ( ls_PathName, LineMode! )
	
	IF li_FileHandle <> -1 THEN
	 	fileRead ( li_FileHandle, ls_Result )
		IF UPPER (  MID ( ls_Result , 1 ,2 ) ) = "ID" THEN
			li_Start = 2
		ELSE
			li_Start = 1
		END IF
		FileClose ( li_FileHandle )
	END IF
	
	
	li_ImportReturn = lds_Test.ImportFile (ls_PathName, li_Start, 9999, 2, 9999, 2 ) 
	
	ll_RowCount = lds_Test.rowCount ( )
	li_ColCount = Integer (lds_Test.Object.DataWindow.Column.Count)
	
	FOR ll_Row = 1 TO ll_RowCount 
		ll_newRow = THIS.InsertRow (0)
		IF ll_NewRow > 0 THEN
			FOR li_Column = 2 TO li_ColCount
				
				ls_columnname = THIS.Describe ( "#" + String( li_column ) + ".name" )
				la_Data = lds_Test.inv_BAse.of_getItemAny ( ll_Row , ls_ColumnName )
				THIS.SetItem ( ll_newRow, "#"+String(li_column) , la_Data )		
				
				
			NEXT 
		ELSE
			MessageBox ( "Template Import" , "An error occurred while attempting to import amounts template." )
			EXIT
		END IF
		
		
	NEXT

END IF

DESTROY lds_Test

end event

event pfc_postupdate;//NOTE:  This is a major KLUGE!!! I can't figure out how to make riverton
//update the join table, and I've got to build this thing!!


Long	ll_RowCount, &
		ll_DeletedCount, &
		ll_Row
Long	ll_EntityId, &
		ll_AmountTemplateId

IF IsValid ( inv_Entity ) THEN

	ll_EntityId = inv_Entity.of_GetId ( )

	ll_RowCount = This.RowCount ( )
	
	FOR ll_Row = 1 TO ll_RowCount
	
		ll_AmountTemplateId = This.GetItemNumber ( ll_Row, "amounttemplate_id" )

		INSERT INTO Join_Entity_AmountTemplate ( fkEntity, fkAmountTemplate )
		VALUES ( :ll_EntityId, :ll_AmountTemplateId ) ;

		COMMIT ;

	NEXT

END IF

RETURN Super::Event pfc_PostUpdate ( )
end event

event pfc_addrow;call super::pfc_addrow;// extending
Long		ll_ReturnValue 
Int		li_Division

ll_ReturnValue = AncestorReturnValue

IF ll_ReturnValue > 0 THEN

	IF dw_entity.RowCount( ) = 1 THEN
		li_Division = dw_entity.GetItemNumber( 1 , "entity_division" )
		IF NOT isNull ( li_Division ) THEN
			THIS.SetItem( ll_ReturnValue , "amounttemplate_division"  , li_Division )
		END IF
	END IF
	
	IF isValid ( inv_Entity ) THEN // entry was made for an entity
		THIS.SetITem ( ll_ReturnValue , "amounttemplate_type" , appeon_constant.ci_Type_DateRange)
	END IF
	
	
END IF
	
RETURN ll_ReturnValue
end event

event constructor;call super::constructor;n_cst_presentation_amounttype lnv_presentationamounttype

lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_payables)
lnv_presentationamounttype.of_setpresentation(this)

THIS.of_setrowSelect ( TRUE )
end event

type st_amounttemplates from u_st_label within w_amounttemplates
integer x = 32
integer y = 1004
integer width = 882
boolean bringtotop = true
string text = "Amount Templates"
end type

type mle_datalist from u_mle within w_amounttemplates
integer x = 27
integer y = 584
integer width = 3346
integer height = 140
integer taborder = 60
boolean bringtotop = true
string text = "TotalMiles , LoadedMiles , EmptyMiles , BobtailMiles , DeadheadMiles , TotalWeight , Shipments , Events , Hooks , Drops , Mounts , Dismounts , Pickups , Deliveries , Stops , WorkingStops , FreightRevenue , StartDate , EndDate , ItineraryHours"
boolean vscrollbar = true
end type

type st_2 from u_st_label within w_amounttemplates
integer x = 41
integer y = 512
integer width = 1499
boolean bringtotop = true
string text = "Available Data for Amount Template Expressions"
end type

type cb_import from u_cb within w_amounttemplates
integer x = 3017
integer y = 996
integer height = 80
integer taborder = 70
boolean bringtotop = true
string text = "&Import"
end type

event clicked;dw_list.Event ue_Import ( )
end event

type rb_global from radiobutton within w_amounttemplates
integer x = 2793
integer y = 60
integer width = 558
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Global Templates"
boolean lefttext = true
end type

event clicked;IF THIS.Checked THEN
	Parent.Event ue_ShowGlobals ( )
END IF
end event

type rb_entity from radiobutton within w_amounttemplates
integer x = 2821
integer y = 128
integer width = 530
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Entity Templates"
boolean lefttext = true
end type

event clicked;IF THIS.Checked THEN

	parent.event ue_showEntityTemplates ( )
END IF
end event

event constructor;THIS.Checked = TRUE
end event

type dw_entity from u_dw_entitylist within w_amounttemplates
integer x = 27
integer y = 224
integer width = 3346
integer taborder = 10
end type

type mle_cover from multilineedit within w_amounttemplates
integer x = 27
integer y = 224
integer width = 2990
integer height = 260
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_copy from u_cb within w_amounttemplates
integer x = 2633
integer y = 996
integer height = 80
integer taborder = 90
boolean bringtotop = true
string text = "&Copy"
end type

event clicked;Event ue_Copy ( )
end event

type cb_paste from u_cb within w_amounttemplates
integer x = 2249
integer y = 996
integer height = 80
integer taborder = 100
boolean bringtotop = true
string text = "&Paste"
end type

event clicked;Event ue_Paste ( )
end event

type cb_employee from commandbutton within w_amounttemplates
integer x = 55
integer y = 100
integer width = 389
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Emplo&yee"
end type

event clicked;Event ue_ChooseEmployee ( )
end event

type cb_company from commandbutton within w_amounttemplates
integer x = 471
integer y = 100
integer width = 389
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Co&mpany"
end type

event clicked;Event ue_ChooseCompany ( )
end event

type gb_1 from groupbox within w_amounttemplates
integer x = 27
integer y = 20
integer width = 864
integer height = 180
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Entity Setup"
end type

type st_1 from statictext within w_amounttemplates
integer x = 41
integer y = 760
integer width = 1330
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Available Data for Selection Filter Expression"
boolean focusrectangle = false
end type

type mle_filterlist from multilineedit within w_amounttemplates
integer x = 27
integer y = 836
integer width = 3346
integer height = 140
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "OriginId , OriginRef , OriginCity , OriginState , DestinationId , DestinationRef , DestinationCity, DestinationState , EventSequence , ShipmentType , Pickup  Deliver , NewTrip , EndTrip , Hook , Drop , Mount , Dismount , Bobtail , DeadHead"
borderstyle borderstyle = stylelowered!
end type

