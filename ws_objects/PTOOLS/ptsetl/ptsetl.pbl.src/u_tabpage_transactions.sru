$PBExportHeader$u_tabpage_transactions.sru
$PBExportComments$Transactions (Tab Page from PBL map PTSetl) //@(*)[76579654|1551]
forward
global type u_tabpage_transactions from u_tabpg
end type
type dw_transactions from u_dw_transactionlist within u_tabpage_transactions
end type
type dw_transactiondetail from u_dw_transactiondetail within u_tabpage_transactions
end type
end forward

global type u_tabpage_transactions from u_tabpg
integer width = 2601
integer height = 800
long backcolor = 12632256
string text = "Transactions"
long picturemaskcolor = 536870912
event ue_checktransactionmanager ( )
event ue_transactionchanged ( ref n_cst_beo_transaction anv_beo_transaction )
event ue_refresh ( )
event ue_transactionmodified ( )
dw_transactions dw_transactions
dw_transactiondetail dw_transactiondetail
end type
global u_tabpage_transactions u_tabpage_transactions

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
protected n_cst_bso_transactionmanager in_transactionmanager //@(*)[76582645|1552]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function n_cst_bso_transactionmanager wf_GetTransactionmanager ()
public function integer wf_settransactionmanager (n_cst_bso_transactionmanager an_transactionmanager)
protected subroutine wf_displaydetail (datawindow adw_master)
end prototypes

event ue_checktransactionmanager;//Override this event on descendants.
end event

event ue_refresh;dw_Transactions.inv_UILink.RefreshFromBcm ( )
dw_transactiondetail.inv_UILink.RefreshFromBcm ( )

end event

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null

Choose Case Lower(as_name)
Case "transactionmanager"
     Return in_transactionmanager
End Choose

Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
any la_any
anv_parameters.GetParameterValue2(as_name, la_any)
Choose Case Lower(as_name)
   Case "transactionmanager"
     If IsNull(la_any) Or Not isValid(la_any) Then
           SetNull(in_transactionmanager)
     ElseIf ClassName(la_any) = "any" Then
           SetNull(in_transactionmanager)
     Else
           in_transactionmanager = la_any
     End If
End Choose

Return 1
//@(text)--

end function

public function n_cst_bso_transactionmanager wf_GetTransactionmanager ();//@(*)[76582645|1552:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_transactionmanager
//@(text)--

end function

public function integer wf_settransactionmanager (n_cst_bso_transactionmanager an_transactionmanager);//@(*)[76582645|1552:s]<nosync>//@(-)Do not edit, move or copy this line//
//Relay the change to the datawindow.
dw_Transactions.SetTransactionManager ( an_TransactionManager )
dw_transactiondetail.SetTransactionManager ( an_TransactionManager )

//@(text)(recreate=yes)<body>

in_transactionmanager = an_transactionmanager
return 1
//@(text)--

end function

protected subroutine wf_displaydetail (datawindow adw_master);dw_transactiondetail.inv_UILink.RefreshFromBcm ( )
dw_transactiondetail.setfilter ( "transaction_id = " + string ( adw_Master.object.transaction_id[adw_Master.GetRow()]) )
dw_transactiondetail.filter ( )
dw_transactiondetail.Show ( )
dw_transactiondetail.SetFocus ( )

end subroutine

on u_tabpage_transactions.create
int iCurrent
call super::create
this.dw_transactions=create dw_transactions
this.dw_transactiondetail=create dw_transactiondetail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_transactions
this.Control[iCurrent+2]=this.dw_transactiondetail
end on

on u_tabpage_transactions.destroy
call super::destroy
destroy(this.dw_transactions)
destroy(this.dw_transactiondetail)
end on

event constructor;call super::constructor;//Extending Ancestor


//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_Transactions
inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
	ldo_Reference.Y + ldo_Reference.Height + li_Border )

//Register resizable controls
This.inv_resize.of_Register ( dw_Transactions, 'ScaleToRight&Bottom' )

//Trigger resize event to perform initial resize of tabpage contents
This.TriggerEvent ( "Resize" )


RETURN AncestorReturnValue
end event

type dw_transactions from u_dw_transactionlist within u_tabpage_transactions
event type long task_retrieve ( )
string tag = ";objectid=[76614179|1553]"
integer x = 37
integer y = 32
integer width = 2491
integer height = 704
integer taborder = 10
end type

event task_retrieve;//@(text)(recreate=yes)<retrieve>
long ll_rc = -1
n_cst_bcm lnv_bcm
n_cst_beo lnv_beo
if NOT isValid(in_transactionmanager) then
    in_transactionmanager = create n_cst_bso_transactionmanager
end if
if isValid(in_transactionmanager)  then
    lnv_bcm = gnv_bcmmgr.CreateBCM(in_transactionmanager.of_gettransactions())
    if isValid(lnv_bcm) then
         if inv_uilink.SetBCM(lnv_bcm) = 1 then
            ll_rc = this.RowCount()
         end if
    end if
end if

return ll_rc
//@(text)--

end event

on dw_transactions.create
call u_dw_transactionlist::create
end on

on dw_transactions.destroy
call u_dw_transactionlist::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
this.SetUseTaskRetrieve(TRUE)
//@(data)--


end event

event itemchanged;call super::itemchanged;// If these columns change then we want the change 
// reflected in the total on the header dw on the top of the window
CHOOSE CASE DWO.NAME
CASE "transaction_startdate", "transaction_enddate"
	PARENT.Event ue_TransactionModified (  )
END CHOOSE

dw_transactiondetail.inv_UILink.UpdateRequestor ( dw_transactiondetail.GetRow ( ) )

RETURN AncestorReturnValue
end event

event pfc_addrow;IF dw_transactiondetail.AcceptText ( ) = -1 THEN
	RETURN -1
END IF

CALL Super::pfc_AddRow

n_cst_Beo_Transaction	lnv_beo_Transaction

IF AncestorReturnValue > 0 THEN  //rc = RowNumber

	IF IsValid ( dw_TransactionDetail.inv_UILink ) THEN
		dw_TransactionDetail.inv_UILink.RefreshFromBcm ( )
	END IF
	
	//dw_transactions.setrow( AncestorReturnValue )  //THIS ISN'T SETTING ROW

	IF AncestorReturnValue > 0 AND IsValid ( This.inv_UIlink ) THEN
		
		lnv_beo_Transaction = THIS.inv_UIlink.getBeo( AncestorReturnValue )
		
		IF isValid ( lnv_beo_Transaction ) THEN 
		
			PARENT.Event ue_transactionChanged ( lnv_Beo_Transaction )
			
		END IF
		
	END IF

	this.setrow(AncestorReturnValue)
	//dw_transactiondetail.inv_UILink.UpdateRequestor ( dw_transactiondetail.GetRow ( ) )
	dw_transactiondetail.setfilter ( "transaction_id = " + string ( this.object.transaction_id[AncestorReturnValue]) )
	dw_transactiondetail.filter ( )
	dw_transactiondetail.Show ( )
	dw_transactiondetail.SetFocus ( )
	
END IF

//Replaced by code above this.
// this should not stay here. it is a temp solution to the first row added bug.
//IF THIS.RowCount( ) = 1 THEN
//	THIS.Event RowFocusChanged ( 1 )
//END IF
//

RETURN AncestorReturnValue
end event

event pfc_deleterow;call super::pfc_deleterow;IF AncestorReturnValue = SUCCESS THEN
	PARENT.Event ue_TransactionModified (  )
END IF

RETURN AncestorReturnValue

end event

event pfc_insertrow;call super::pfc_insertrow;IF dw_TransactionDetail.AcceptText ( ) = -1 THEN

	RETURN -1

END IF

dw_TransactionDetail.Hide ( )

CALL Super::pfc_InsertRow

IF AncestorReturnValue > 0 THEN  //rc = RowNumber
	dw_TransactionDetail.inv_UILink.RefreshFromBcm ( )

		
		this.TriggerEvent ( "pfc_RowChanged" )
		dw_transactiondetail.inv_UILink.UpdateRequestor ( dw_transactiondetail.GetRow ( ) )
		dw_transactiondetail.Show ( )
		dw_transactiondetail.SetFocus ( )
		
END IF

RETURN AncestorReturnValue
end event

event pfc_predeleterow;call super::pfc_predeleterow;Integer li_Return

li_Return = AncestorReturnValue

IF li_Return = CONTINUE_ACTION THEN

	IF dw_transactiondetail.AcceptText ( ) = -1 THEN

		RETURN PREVENT_ACTION

	END IF

	dw_transactiondetail.Hide ( )

END IF

RETURN li_Return
end event

event ue_autoassign;//Override Ancestor (With call to Ancestor)

Integer	li_Return

IF dw_transactiondetail.AcceptText ( ) = -1 THEN

	RETURN FAILURE

else

	dw_transactiondetail.Hide ( )
	
	CALL Super::ue_AutoAssign
	
	CHOOSE CASE AncestorReturnValue
	
	CASE Is > 0
		dw_TransactionDetail.inv_UILink.RefreshFromBcm ( )
	
	END CHOOSE

	li_Return = AncestorReturnValue

END IF

RETURN li_Return
end event

event ue_closetransaction;//Override Ancestor (With call to Ancestor)
//Returns : SUCCESS, NO_ACTION, FAILURE

Integer	li_Return
IF dw_transactiondetail.AcceptText ( ) = -1 THEN

	RETURN FAILURE

else


	CALL Super::ue_CloseTransaction
	
	CHOOSE CASE AncestorReturnValue
	
	CASE NO_ACTION
		//No action was taken.  No need to update display.
	
	CASE ELSE
		//Even if the request fails, some changes may have been made (to amounts)
		dw_TransactionDetail.inv_UILink.RefreshFromBcm ( )
	
	END CHOOSE

	li_Return = AncestorReturnValue

END IF

RETURN li_Return
end event

event doubleclicked;wf_displaydetail ( this )
end event

event rowfocuschanged;call super::rowfocuschanged;n_cst_Beo_Transaction	lnv_beo_Transaction
Long	ll_CR

ll_CR = This.GetRow ( )  //Use CurrentRow???

IF ll_CR > 0 AND IsValid ( inv_UIlink ) THEN
	
	lnv_beo_Transaction = THIS.inv_UIlink.getBeo( ll_CR )
	
	IF isValid ( lnv_beo_Transaction ) THEN 
	
		PARENT.Event ue_transactionChanged ( lnv_Beo_Transaction )
		
	END IF
	
	IF dw_transactiondetail.visible=true THEN
		dw_transactiondetail.setfilter ( "transaction_id = " + string ( this.object.transaction_id[ll_CR]) )
		dw_transactiondetail.filter ( )
	END IF
	
END IF
end event

event itemerror;call super::itemerror;IF AncestorReturnValue = 3 THEN
	
	dw_transactiondetail.inv_UILink.UpdateRequestor ( dw_transactiondetail.GetRow ( ) )	
	PARENT.Event ue_TransactionModified (  )

END IF

RETURN AncestorReturnValue
end event

type dw_transactiondetail from u_dw_transactiondetail within u_tabpage_transactions
event type long task_retrieve ( )
string tag = ";objectid=[62582792|1641]"
boolean visible = false
integer x = 338
integer y = 32
integer width = 2761
integer height = 1396
integer taborder = 20
end type

event task_retrieve;//@(text)(recreate=yes)<retrieve>
long ll_rc = -1
n_cst_bcm lnv_bcm
n_cst_beo lnv_beo
if NOT isValid(in_transactionmanager) then
    in_transactionmanager = create n_cst_bso_transactionmanager
end if
if isValid(in_transactionmanager)  then
    lnv_bcm = gnv_bcmmgr.CreateBCM(in_transactionmanager.of_gettransactions())
    if isValid(lnv_bcm) then
         if inv_uilink.SetBCM(lnv_bcm) = 1 then
            ll_rc = this.RowCount()
         end if
    end if
end if
return ll_rc
//@(text)--

end event

on dw_transactiondetail.create
call u_dw_transactiondetail::create
end on

on dw_transactiondetail.destroy
call u_dw_transactiondetail::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
this.SetUseTaskRetrieve(TRUE)
//@(data)--


end event

event itemchanged;call super::itemchanged;//Extending Ancestor

IF AncestorReturnValue <> 1 THEN
	
	IF this.Visible THEN
		// If these columns change then we want the change 
		// reflected in the total on the header dw on the top of the window
		CHOOSE CASE DWO.NAME
		CASE "transaction_startdate", "transaction_enddate"
			PARENT.Event ue_TransactionModified (  )
		END CHOOSE
		
		dw_transactions.inv_UILink.UpdateRequestor ( dw_transactions.GetRow ( ) )	
		
	END IF

END IF

RETURN AncestorReturnValue
end event

event itemerror;call super::itemerror;IF AncestorReturnValue = 3 THEN
	
	dw_transactions.inv_UILink.UpdateRequestor ( dw_transactions.GetRow ( ) )	
	PARENT.Event ue_TransactionModified (  )

END IF

RETURN AncestorReturnValue
end event

