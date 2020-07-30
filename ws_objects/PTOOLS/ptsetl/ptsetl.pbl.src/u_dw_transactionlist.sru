$PBExportHeader$u_dw_transactionlist.sru
$PBExportComments$TransactionList (Data Control from PBL map PTSetl) //@(*)[155174566|326]
forward
global type u_dw_transactionlist from u_dw
end type
end forward

global type u_dw_transactionlist from u_dw
int Width=2400
int Height=600
boolean BringToTop=true
string DataObject="d_transactionlist"
boolean HScrollBar=true
boolean HSplitScroll=true
event type long task_retrieve ( )
event type integer ue_closetransaction ( )
event type integer ue_printtransaction ( )
event type integer ue_autoassign ( )
event ue_itinerary ( )
event type integer ue_rowfocuschanged ( long al_row )
end type
global u_dw_transactionlist u_dw_transactionlist

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
protected n_cst_bso_transactionmanager in_transactionmanager //@(*)[155179842|327]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function n_cst_bso_transactionmanager GetTransactionmanager ()
public function Integer SetTransactionmanager (n_cst_bso_transactionmanager an_transactionmanager)
end prototypes

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

event ue_closetransaction;//Attempt to close the Transaction that currently has focus
//Returns : SUCCESS, NO_ACTION, FAILURE

/*
	8/3/00 - Printing call removed to allow for batch closing. The printing call is now made by 
				the calling script. <<*>> RPZ


*/

n_cst_beo_Transaction	lnv_Transaction
Long		ll_Row
Integer	li_Return
Constant String	ls_MessageHeader = "Close Transaction"

li_Return = FAILURE
ll_Row = This.GetRow ( )

lnv_Transaction = This.inv_UILink.GetBeo ( ll_Row )

IF IsValid ( lnv_Transaction ) THEN

	IF lnv_Transaction.of_GetOpen ( ) = FALSE THEN
		//Transaction is already closed
		li_Return = NO_ACTION

	ELSE
		CHOOSE CASE lnv_Transaction.of_SetOpen ( FALSE )
	
		CASE IS > 0  //Success (or no action)

			li_Return = SUCCESS

//			IF MessageBox ( ls_MessageHeader, "Do you want to print the transaction now?", &
//				Question!, YesNo!, 1 ) = 1 THEN
//
//				lnv_Transaction.of_Print ( )
//
//			END IF
//
			This.inv_UILink.UpdateRequestor ( ll_Row )

		CASE ELSE
			MessageBox ( ls_MessageHeader, "Could not close current transaction.  Please check the following:~n~n"+&
				"The transaction or one of its transaction amounts may have a non-closeable status. "+&
					"(Hold or Audit Req.)~n~n"+&
				"Amount Type or Division may not have been specified for one or more amounts.~n~n"+&
				"Your user privileges may be insufficient to perform this operation." )
	
		END CHOOSE
	END IF

END IF

RETURN li_Return
end event

event ue_printtransaction;//Attempt to close the Transaction that currently has focus
//Returns : SUCCESS, NO_ACTION, FAILURE   (NO_ACTION not currently possible)

n_cst_beo_Transaction	lnv_Transaction
Long		ll_Row
Integer	li_Return
Constant String	ls_MessageHeader = "Close Transaction"

li_Return = FAILURE
ll_Row = This.GetRow ( )

lnv_Transaction = This.inv_UILink.GetBeo ( ll_Row )

IF IsValid ( lnv_Transaction ) THEN

	IF lnv_Transaction.of_Print ( ) = 1 THEN
		li_Return = SUCCESS
	END IF

END IF

RETURN li_Return
end event

event ue_autoassign;n_cst_bso_TransactionManager	lnv_TransactionManager
n_cst_beo_Transaction	lnv_Transaction
Long		ll_Row
Integer	li_Return

ll_Row = This.GetRow ( )
li_Return = -1

lnv_TransactionManager = This.GetTransactionManager ( )
lnv_Transaction = This.inv_UILink.GetBeo ( ll_Row )

IF IsValid ( lnv_TransactionManager ) AND &
	IsValid ( lnv_Transaction ) THEN

	li_Return = lnv_TransactionManager.of_AutoAssign ( lnv_Transaction )

	IF li_Return > 0 THEN
		This.inv_UILink.UpdateRequestor ( ll_Row )
	END IF

END IF

RETURN li_Return
end event

event ue_itinerary;Long	ll_SelectedRow, &
		ll_selectedId, &
		ll_EntityId
Date	ld_ItinDate
n_cst_beo_transaction		lnv_Beo
n_cst_EquipmentManager	lnv_Equip

ll_SelectedRow = This.GetRow ( )

IF ll_SelectedRow > 0 AND IsValid ( inv_UILink ) THEN

	lnv_Beo = inv_UILink.GetBeo ( ll_SelectedRow )

	IF IsValid ( lnv_Beo ) THEN

		ll_EntityId = lnv_Beo.of_GetfkEntity ( )

		ld_ItinDate = lnv_Beo.of_GetStartDate ( )

		IF IsNull ( ld_ItinDate ) THEN
			ld_ItinDate = lnv_Beo.of_GetEndDate ( )
		END IF

	END IF


//	IF NOT IsNull ( ld_ItinDate ) THEN

		SELECT fkEmployee INTO :ll_SelectedId 
		FROM Entity WHERE Id = :ll_EntityId ;

		COMMIT ;

//	END IF


END IF


IF ll_SelectedId > 0 /*AND NOT IsNull ( ld_ItinDate )*/ THEN
	lnv_Equip.of_OpenDriverItinerary ( ll_SelectedId , ld_ItinDate )
ELSE
	MessageBox( "Display Itinerary", "Cannot determine which itinerary to display." )
END IF

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

public function n_cst_bso_transactionmanager GetTransactionmanager ();//@(*)[155179842|327:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_transactionmanager
//@(text)--

end function

public function Integer SetTransactionmanager (n_cst_bso_transactionmanager an_transactionmanager);//@(*)[155179842|327:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_transactionmanager = an_transactionmanager
return 1
//@(text)--

end function

on u_dw_transactionlist.destroy
call u_dw::destroy
end on

event constructor;//@(data)(recreate=yes)<GenerationOptions>
SetUILink(TRUE)
inv_uilink.SetClass("")
of_SetTransObject(SQLCA)
this.SetUseTaskRetrieve(TRUE)
//@(data)--

n_cst_Presentation_transaction	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )


of_SetAutoFind ( TRUE )
of_SetAutoSort ( TRUE )

// enable multi-row-select-ability
THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (2) //2 = extended row select service


end event

event itemerror;call super::itemerror;
Boolean	lb_Processed
string 	ls_errcol
Long		ll_Return
date 		ld_compdate
Int		li_SetItemRtn

n_cst_string lnv_string

ls_errcol = dwo.name
ll_Return = ancestorReturnValue
IF ll_Return = 0 THEN

	choose case ls_errcol
	
		case "transaction_startdate" , "transaction_enddate"
		
			//Attempt to convert the text typed to a date
			ld_compdate = lnv_string.of_SpecialDate(data)
		
			if isnull(ld_compdate) then
				//Value is really invalid
				ll_return = 0 //  Reject the data value and show an error message box
				
				
			ELSE
				li_SetItemRtn = this.setitem(row, ls_errcol, ld_compdate)
				IF li_SetItemRtn > 0 THEN // HOW's extention retruns -1, maybe 0 , 1, 2 
					ll_Return = 3  //Reject the data value but allow focus to change
				ELSE
					ll_return = 1 
				END IF
		
			END IF
		
	end choose
	
END IF

return ll_Return
end event

event ue_autosort;call super::ue_autosort;Int	li_Return

li_Return = AncestorReturnValue

IF li_Return = 1 AND isValid (inv_sort) THEN
	inv_sort.of_SetExclude ( {"cf_pretaxnettotal","cf_nontaxablegrosstotal","cf_taxablegrosstotal","cf_count"})
END IF

RETURN li_Return 
end event

