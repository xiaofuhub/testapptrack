$PBExportHeader$u_tabpg_dupoptions.sru
forward
global type u_tabpg_dupoptions from u_tabpg
end type
type lb_options from u_lb within u_tabpg_dupoptions
end type
type st_status from statictext within u_tabpg_dupoptions
end type
type dw_status from u_dw_shipmentstatuslist_dd within u_tabpg_dupoptions
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//s_Parm	sstra_Options[]
//Boolean	sb_NonRoutedOnly = FALSE
////end modification Shared Variables by appeon  20070730
//
end variables

global type u_tabpg_dupoptions from u_tabpg
integer height = 964
string text = "Dup. Options"
event ue_nonroutedselected ( boolean ab_value )
event ue_getsourceshipments ( ref long ala_shipments[] )
event ue_initialize ( )
lb_options lb_options
st_status st_status
dw_status dw_status
end type
global u_tabpg_dupoptions u_tabpg_dupoptions

type variables
n_cst_msg	inv_Msg
//begin modification Shared Variables by appeon  20070730
s_Parm	sstra_Options[]
Boolean	sb_NonRoutedOnly = FALSE
//end modification Shared Variables by appeon  20070730

end variables

forward prototypes
public function n_cst_msg of_getoptionsmsg ()
public function integer of_selectsplitoptions ()
public function integer of_selecttemplateoptions ()
public function n_cst_msg of_getdefaultoptionsmsg ()
public function integer of_populatestatuslist ()
public function integer of_multipleshipments (boolean ab_value)
public function string of_getselectedstatus ()
public function integer of_highlightnonrouted ()
end prototypes

event ue_initialize();lb_options.Event ue_initializeOptions ( )
end event

public function n_cst_msg of_getoptionsmsg ();lb_options.Event ue_ProcessOptions ( )

RETURN inv_Msg
end function

public function integer of_selectsplitoptions ();Int	i

FOR i = 1 TO lb_options.TotalItems ( )
	
	IF lb_options.Text ( i ) = gc_Dispatch.cs_ShipDupOpt_Items OR lb_options.Text ( i ) = gc_Dispatch.cs_ShipDupOpt_Payables THEN
		lb_options.SetState ( i, FALSE )
	ELSE
		lb_options.SetState ( i, TRUE )
	END IF
	
	IF lb_options.Text ( i ) = gc_Dispatch.cs_ShipDupOpt_CopyChild THEN
		lb_options.SetState ( i, FALSE )
	END IF
	
NEXT

Return 1
end function

public function integer of_selecttemplateoptions ();Int	i

FOR i = 1 TO lb_options.TotalItems ( )
	
	IF lb_options.Text ( i ) = gc_Dispatch.cs_ShipDupOpt_NonRouted THEN
		lb_options.SetState ( i, FALSE )
	ELSE
		lb_options.SetState ( i, TRUE )
	END IF
	
NEXT

return 1
end function

public function n_cst_msg of_getdefaultoptionsmsg ();lb_options.Event ue_InitializeOptions ( )
RETURN inv_Msg
end function

public function integer of_populatestatuslist ();//String	ls_ValueList
//String	lsa_Items[]
//
//n_cst_ShipmentManager	lnv_ShipmentManager
//n_cst_String				lnv_String
//
//ls_ValueList = lnv_ShipmentManager.of_GetStatusValueList ( ) 

RETURN -1
end function

public function integer of_multipleshipments (boolean ab_value);
dw_status.Visible = ab_value
st_status.Visible = ab_value

RETURN 1
end function

public function string of_getselectedstatus ();String	ls_Status

ls_Status = gc_Dispatch.cs_ShipmentStatus_Open  // default

IF dw_status.RowCount ( ) > 0 THEN
	IF dw_status.object.ds_Status [ 1 ] <> "" THEN
		ls_Status = dw_status.object.ds_Status [ 1 ]
	END IF
END IF

RETURN ls_Status
end function

public function integer of_highlightnonrouted ();Int	li_Index

li_Index = lb_options.FindItem (gc_Dispatch.cs_ShipDupOpt_NonRouted, 0 )

IF li_Index > 0 THEN
	lb_options.SetState ( li_Index , TRUE ) 
END IF
		
THIS.event ue_nonroutedselected( TRUE )
RETURN li_Index
end function

on u_tabpg_dupoptions.create
int iCurrent
call super::create
this.lb_options=create lb_options
this.st_status=create st_status
this.dw_status=create dw_status
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lb_options
this.Control[iCurrent+2]=this.st_status
this.Control[iCurrent+3]=this.dw_status
end on

on u_tabpg_dupoptions.destroy
call super::destroy
destroy(this.lb_options)
destroy(this.st_status)
destroy(this.dw_status)
end on

type lb_options from u_lb within u_tabpg_dupoptions
event type integer ue_processoptions ( )
event ue_initializeoptions ( )
integer x = 55
integer y = 24
integer width = 709
integer height = 920
integer taborder = 10
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean sorted = false
boolean multiselect = true
boolean extendedselect = true
end type

event ue_processoptions;//Validates the selections the user made, and stores them onto the shared list if valid.
//Returns : 1, -1 (Will notify user of problem if -1)


Integer	li_Index, &
			li_OptionCount, &
			li_Option
Boolean	lb_RefLabels, &
			lb_RefValues
String	ls_NewStatus

Integer	li_Return = 1

n_cst_msg	lnv_Msg
S_Parm		lstr_Parm


ls_NewStatus = PARENT.of_getSelectedStatus ( )

//Ref # Values can't be duplicated without Ref # Labels.  If Values is selected, 
//Labels must also be selected.  Check that this condition is met.

IF li_Return = 1 THEN

	li_Index = This.FindItem ( gc_Dispatch.cs_ShipDupOpt_RefLabels, 0 )
	lb_RefLabels = This.State ( li_Index ) = 1
	
	li_Index = This.FindItem ( gc_Dispatch.cs_ShipDupOpt_RefValues, 0 )
	lb_RefValues = This.State ( li_Index ) = 1
	
	IF lb_RefValues = TRUE AND lb_RefLabels = FALSE THEN

		//Values is selected and labels isn't.  Ask the user if they want to duplicate labels too.

		IF MessageBox ( "Duplication Options", "In order to duplicate Ref # Values, Ref # Labels "+&
			"will also be duplicated.  OK to proceed?", Question!, OKCancel! ) = 2 THEN

			//User cancelled.
			li_Return = -1

		ELSE

			//User said to go ahead.  Select the Labels option in the list.
			li_Index = This.FindItem ( gc_Dispatch.cs_ShipDupOpt_RefLabels, 0 )
			This.SetState ( li_Index, TRUE )

		END IF

	END IF

END IF


//Read the values out of the list into the shared array.
CHOOSE CASE ls_NewStatus
		
	CASE gc_Dispatch.cs_ShipmentStatus_Authorized, & 
		  gc_Dispatch.cs_ShipmentStatus_AuditRequired , &
		  gc_Dispatch.cs_ShipmentStatus_Audited


		lstr_Parm.is_Label = "CONFIRMEVENTS" 
		lstr_Parm.ia_Value = TRUE
		lnv_Msg.of_Add_Parm ( lstr_Parm )	
		
		Parent.of_HighlightNonRouted ( )
		
END CHOOSE




IF li_Return = 1 THEN

	li_OptionCount = inv_msg.of_Get_Count ( )

	FOR li_Option = 1 TO li_OptionCount
		inv_Msg.of_Get_Parm ( li_Option , lstr_Parm )
	
		li_Index = This.FindItem ( lstr_Parm.is_Label, 0 )

		IF li_Index > 0 THEN
			lstr_Parm.ia_Value = This.State ( li_Index ) = 1
		END IF
		
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
	NEXT

END IF

lstr_Parm.is_Label = "SHIPMENTSTATUS"
lstr_Parm.ia_Value = ls_NewStatus
lnv_Msg.of_Add_Parm ( lstr_Parm )	



inv_msg = lnv_msg

RETURN li_Return
end event

event ue_initializeoptions();Integer	li_OptionCount, &
			li_Item, &
			li_Index
Boolean	lb_NonRouted
n_cst_LicenseManager	lnv_LicenseManager

S_Parm	lstr_Parm
THIS.ExtendedSelect = TRUE

// Reset the msg object
inv_Msg.of_Reset ( )
THIS.Reset ( )

Long	lla_SourceShipments[]

Parent.Event ue_GetSourceSHipments ( lla_SourceShipments )


IF UpperBound ( lla_SourceShipments ) = 1 THEN
	
	String	ls_Dorb
	Long		ll_ShipmentID
	
	ll_ShipmentID = lla_SourceShipments[1]
	
	  SELECT "disp_ship"."ds_dorb"  
    INTO :ls_Dorb  
    FROM "disp_ship"  
   WHERE "disp_ship"."ds_id" = :ll_ShipmentID  ;
	Commit;
	
	IF ls_Dorb = appeon_constant.cs_category_nonrouted THEN
		lb_NonRouted = TRUE
	END IF
	
	
END IF
	
	

//See how many options are listed in the shared options list.
li_OptionCount = UpperBound ( sstra_Options )


//Initialize Options Array, if it hasn't been already

IF li_OptionCount = 0 THEN

//	li_OptionCount ++
//
//	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_Items
//	lstr_Parm.ia_Value = TRUE
//	inv_Msg.of_Add_Parm ( lstr_Parm )
		
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_FreightItems
	lstr_Parm.ia_Value = TRUE
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_AccItems
	lstr_Parm.ia_Value = TRUE
	inv_Msg.of_Add_Parm ( lstr_Parm )
		
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_Payables
	lstr_Parm.ia_Value = TRUE
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_RefLabels
	lstr_Parm.ia_Value = TRUE
	inv_Msg.of_Add_Parm ( lstr_Parm )

	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_RefValues
	lstr_Parm.ia_Value = FALSE
	inv_Msg.of_Add_Parm ( lstr_Parm )

	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_ShipNote
	lstr_Parm.ia_Value = FALSE
	inv_Msg.of_Add_Parm ( lstr_Parm )

	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_BillNote
	lstr_Parm.ia_Value = FALSE
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_EventNotes
	lstr_Parm.ia_Value = FALSE
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_CustomFields
	lstr_Parm.ia_Value = FALSE
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_BLNum
	lstr_Parm.ia_Value = FALSE
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_Intermodal
	lstr_Parm.ia_Value = FALSE
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_EventDates
	lstr_Parm.ia_Value = lb_NonRouted
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_EventTimes
	lstr_Parm.ia_Value = lb_NonRouted
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_CopyChild
	lstr_Parm.ia_Value = FALSE
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	li_OptionCount ++
	lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_NonRouted
	//If neither dispatch nor brokerage is licensed, duplicate shipments have to be non-routed, 
	//so we have to force the value for this option.

	IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch ) OR &
		lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) THEN

		lstr_Parm.ia_Value = lb_NonRouted
		Parent.Event ue_NonRoutedSelected ( lb_NonRouted )
	ELSE

		lstr_Parm.ia_Value = TRUE
		sb_NonRoutedOnly = TRUE

	END IF
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
END IF


//Populate List from options array

FOR li_Index = 1 TO li_OptionCount
	inv_msg.of_Get_Parm ( li_Index , lstr_Parm )
	//If we can't create routed shipments and we've hit the Non-Routed option, skip it.
	IF sb_NonRoutedOnly = TRUE THEN
		 
		
		IF lstr_Parm.is_Label = gc_Dispatch.cs_ShipDupOpt_NonRouted THEN
			CONTINUE
		END IF
	END IF

	//Add the option to the list box.
	li_Item = This.AddItem ( lstr_Parm.is_Label )

	//Set the selection state of the item.
	This.SetState ( li_Item, lstr_Parm.ia_Value )

NEXT
end event

event selectionchanged;call super::selectionchanged;Int	li_Index
Int	li_DateIndex
Int	li_TimeIndex


li_Index = This.FindItem ( gc_Dispatch.cs_ShipDupOpt_NonRouted, 0 )
//IF THIS.text( index ) = gc_dispatch.cs_ShipDupOpt_NonRouted THEN
	IF THIS.state( li_Index ) = 1 THEN
		Parent.Event ue_NonRoutedSelected ( TRUE )
	ELSE
		Parent.Event ue_NonRoutedSelected ( FALSE )	
	END IF
//END IF


li_TimeIndex = This.FindItem ( gc_Dispatch.cs_ShipDupOpt_EventTimes, 0 )
li_DateIndex = This.FindItem ( gc_Dispatch.cs_ShipDupOpt_EventDates, 0 )

IF index = li_DateIndex AND  THIS.State ( li_DateIndex ) = 0 THEN
	This.SetState ( li_TimeIndex, FALSE )
END IF

IF THIS.State(li_TimeIndex) = 1 THEN
	This.SetState ( li_DateIndex, TRUE )
END IF





end event

type st_status from statictext within u_tabpg_dupoptions
integer x = 791
integer y = 12
integer width = 494
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "New Shipment Status"
boolean focusrectangle = false
end type

type dw_status from u_dw_shipmentstatuslist_dd within u_tabpg_dupoptions
integer x = 786
integer y = 76
integer width = 690
integer height = 116
integer taborder = 20
boolean bringtotop = true
end type

event itemchanged;call super::itemchanged;
CHOOSE CASE String ( Data )
		
	CASE gc_Dispatch.cs_ShipmentStatus_Authorized, & 
		  gc_Dispatch.cs_ShipmentStatus_AuditRequired , &
		  gc_Dispatch.cs_ShipmentStatus_Audited
		
		MessageBox ( "New Shipment Status" , "By selecting this status all copies will be Non-Routed." )
		//sb_NonRoutedOnly = TRUE		
		PARENT.of_HighlightNonRouted () 
		
	CASE ELSE
		sb_NonRoutedOnly = FALSE
		
END CHOOSE

RETURN AncestorReturnValue
//		
//"TEMPLATE~t" + gc_Dispatch.cs_ShipmentStatus_Template + "/"+&
//	"QUOTE~t" + gc_Dispatch.cs_ShipmentStatus_Quoted + "/"+&
//	"OPEN~t" + gc_Dispatch.cs_ShipmentStatus_Open + "/"+&
//	"AUTHORIZED~t" + gc_Dispatch.cs_ShipmentStatus_Authorized + "/"+&
//	"AUDIT REQ.~t" + gc_Dispatch.cs_ShipmentStatus_AuditRequired + "/"+&
//	"AUDITED~t" + gc_Dispatch.cs_ShipmentStatus_Audited + "/"
end event

