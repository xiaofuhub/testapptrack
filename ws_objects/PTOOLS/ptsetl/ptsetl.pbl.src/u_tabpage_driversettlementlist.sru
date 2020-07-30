$PBExportHeader$u_tabpage_driversettlementlist.sru
$PBExportComments$TransactionAmounts (Tab Page from PBL map PTSetl) //@(*)[84545728|1568]
forward
global type u_tabpage_driversettlementlist from u_tabpg
end type
type dw_1 from u_dw_driversettlementist within u_tabpage_driversettlementlist
end type
end forward

global type u_tabpage_driversettlementlist from u_tabpg
integer width = 3520
integer height = 1312
long backcolor = 12632256
event ue_statuschanged ( readonly long al_row )
event type integer ue_dwenabled ( readonly boolean ab_enable )
event type n_cst_bso_transactionmanager ue_gettransactionmanager ( )
event ue_divisionchanged ( long al_value )
event ue_entitychanged ( n_cst_beo_transaction lnv_transaction )
event ue_setfocus ( )
event ue_setunassigned ( )
dw_1 dw_1
end type
global u_tabpage_driversettlementlist u_tabpage_driversettlementlist

type variables
Boolean	ib_ColumnSort = FALSE
end variables

forward prototypes
public function integer of_getdrivertype ()
end prototypes

event type integer ue_dwenabled(readonly boolean ab_enable);// RDT 02-05-03
// disables the column in the datawindow control
//dw_1.Enabled = ab_enable
If ab_enable then 
	dw_1.SetTabOrder('transaction_id',10)
	dw_1.SetTabOrder('transaction_status',20)
Else
	dw_1.SetTabOrder('transaction_id',0)
	dw_1.SetTabOrder('transaction_status',0)
End If

return 1
end event

event ue_divisionchanged(long al_value);
string ls_filter

if al_value > 0 then
	ls_filter = "division = " + string(al_value)
else
	ls_filter = ''
end if

dw_1.setfilter(ls_filter)
dw_1.filter( )
end event

event ue_setfocus();dw_1.scrolltorow(1)
dw_1.selectrow(1,true)
dw_1.event ue_entitychanged(1)
dw_1.setfocus()
end event

event ue_setunassigned();dw_1.Event ue_SetUnassigned()
end event

public function integer of_getdrivertype ();Integer li_Drivertype
// get the driver type of the first row. (All rows should be the same )			
If dw_1.RowCount() > 0 Then 
	li_DriverType = dw_1.GetItemNumber( 1, "driverinfo_di_type_driver")

Else

	SetNull( li_DriverType )
End If

Return li_DriverType 
end function

on u_tabpage_driversettlementlist.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpage_driversettlementlist.destroy
call super::destroy
destroy(this.dw_1)
end on

event constructor;call super::constructor;//extend ancestor

//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_1
inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
	ldo_Reference.Y + ldo_Reference.Height + li_Border )

//Register resizable controls
This.inv_resize.of_Register ( dw_1, 'ScaleToRight&Bottom' )

//Trigger resize event to perform initial resize of tabpage contents
This.TriggerEvent ( "Resize" )


RETURN AncestorReturnValue
end event

type dw_1 from u_dw_driversettlementist within u_tabpage_driversettlementlist
integer x = 37
integer y = 28
integer width = 2409
integer height = 936
integer taborder = 10
end type

event ue_statuschanged;parent.event ue_statuschanged(this.getrow())
end event

event constructor;call super::constructor;
//RDT 02-06-03 Sets Protection on transaction status column if there is no transaction id

this.modify("transaction_status.protect='0~tif( isNull( transaction_id ), 1, 0 )' ")

//This.of_SetSort(TRUE)
end event

event ue_gettransactionmanager;return parent.event ue_gettransactionmanager()
end event

event clicked;call super::clicked;//// Ancestor override  
//// Ancestor override 
//// RDT 8-4-03 This will only sort if the click happens outside the margins  
// Ancestor override  
// Ancestor override 
// RDT 8-4-03 This will only sort if the click happens outside the margins  
// If the column width is less then ll_MinColWidth set the margin to 0 (none)

Long 	ll_Return = 0, &
		ll_min, &
		ll_max, &
		ll_ColXpos, &
		ll_ColWidth, &
		ll_Margin = 10, &
		ll_MinColWidth = 25
		
Integer 	li_ret, &
			li_units, &
			i

IF IsValid( this.inv_Sort) Then // only do this if the sort is on

	IF row = 0 AND ( dwo.Type = "text" ) Then 
		
		li_Units = Integer ( this.Object.DataWindow.Units)
		//0  PowerBuilder units	//1  Display pixels	//2  1/1000 of a logical inch	//3  1/1000 of a logical centimeter
	
		// get width
		ll_ColWidth = Long( dwo.Width )
	
		// get column xpos
		ll_ColXpos = Long( dwo.X )
	
		// if PBUnits convert to pixels 
		If li_Units = 0 Then 
			 ll_ColXpos  = UnitsToPixels( ll_ColXpos, XUnitsToPixels!) 
			 ll_ColWidth = UnitsToPixels( ll_ColWidth, XUnitsToPixels!) 
		End if
		
		// If column width is less then ll_MinColWidth set margin to 0
		If ll_ColWidth < ll_MinColWidth Then 
			ll_Margin = 0
		End If
		
		// add margin to xPos to get Min x
		ll_min = ll_ColXpos + ll_margin 
		
		// add width to col xpos and subtract margin to get max x
		ll_max = ( ll_ColXpos + ll_ColWidth ) - ll_Margin
			
		// if the cursor xpos is less than min or greater than max the its' too close to edge
		If xpos < ll_min OR xpos > ll_max then
			This.inv_sort.of_setColumnHeader(FALSE)
		ELSE
			This.inv_sort.of_setColumnHeader(TRUE)
		End If

	END IF

END IF

ll_Return = Super::EVENT Clicked(xpos, ypos, row, dwo)


Return ll_Return 


end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow > 0 and this.rowcount() > 0 then
	this.event ue_entitychanged(this.object.id[currentrow])
end if
end event

event ue_entitychanged;call super::ue_entitychanged;long	ll_return = 1, &
		ll_TransId

n_cst_bso_TransactionManager	lnv_TransactionManager
n_cst_beo_Transaction			lnv_Transaction

lnv_TransactionManager = this.event ue_GetTransactionManager()

if isvalid(lnv_TransactionManager) then
	ll_TransId = this.of_GetCurrentTransactionId()
	if ll_TransId > 0 then
		if lnv_TransactionManager.of_GetTransaction(ll_TransId, lnv_Transaction) = -1 then
			ll_return = -1
		end if
	else
		ll_return = -1
	end if
else
	ll_return = -1
end if

if isvalid(lnv_transaction) then
	
	parent.event ue_entitychanged(lnv_transaction)
	
end if
end event

