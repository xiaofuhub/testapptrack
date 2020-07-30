$PBExportHeader$u_tab_transactionmanager.sru
$PBExportComments$TransactionManager (Tab Control from PBL map PTSetl) //@(*)[78612670|1555]
forward
global type u_tab_transactionmanager from u_tab
end type
type tabpage_transactions from u_tabpage_transactions within u_tab_transactionmanager
end type
type tabpage_transactions from u_tabpage_transactions within u_tab_transactionmanager
end type
type tabpage_transactionamounts from u_tabpage_transactionamounts within u_tab_transactionmanager
end type
type tabpage_transactionamounts from u_tabpage_transactionamounts within u_tab_transactionmanager
end type
type tabpage_unassignedamounts from u_tabpage_unassignedamounts within u_tab_transactionmanager
end type
type tabpage_unassignedamounts from u_tabpage_unassignedamounts within u_tab_transactionmanager
end type
end forward

global type u_tab_transactionmanager from u_tab
integer width = 2601
integer height = 900
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 12632256
boolean boldselectedtext = true
boolean createondemand = true
tabpage_transactions tabpage_transactions
tabpage_transactionamounts tabpage_transactionamounts
tabpage_unassignedamounts tabpage_unassignedamounts
event ue_transactionchanged ( n_cst_beo_transaction anv_beo_transaction )
event ue_transactionmodified ( )
end type
global u_tab_transactionmanager u_tab_transactionmanager

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
protected n_cst_bso_transactionmanager in_transactionmanager //@(*)[78621405|1556]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function n_cst_bso_transactionmanager wf_GetTransactionmanager ()
public function integer wf_settransactionmanager (n_cst_bso_transactionmanager an_transactionmanager)
end prototypes

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

public function n_cst_bso_transactionmanager wf_GetTransactionmanager ();//@(*)[78621405|1556:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_transactionmanager
//@(text)--

end function

public function integer wf_settransactionmanager (n_cst_bso_transactionmanager an_transactionmanager);//@(*)[78621405|1556:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>

//@(text)--


UserObject	luo_Pages[]
Integer		li_Count, &
				li_Index

//If there's an existing TransactionManager, destroy it.

IF IsValid ( in_TransactionManager ) THEN

	IF an_TransactionManager = in_TransactionManager THEN
		//Existing and New TransactionManagers are the same.  Don't destroy.
	ELSE
		DESTROY in_TransactionManager
	END IF

END IF


//Change the instance variable
in_TransactionManager = an_TransactionManager


//Roll the change through the tab pages that care (those that have implemented the 
//CheckTransactionManager event).

luo_Pages = This.Control
li_Count = UpperBound ( luo_Pages )

FOR li_Index = 1 TO li_Count

	IF luo_Pages [ li_Index ].PageCreated ( ) THEN
		luo_Pages [ li_Index ].TriggerEvent ( "ue_CheckTransactionManager" )
	END IF

NEXT

RETURN 1
end function

on u_tab_transactionmanager.create
this.tabpage_transactions=create tabpage_transactions
this.tabpage_transactionamounts=create tabpage_transactionamounts
this.tabpage_unassignedamounts=create tabpage_unassignedamounts
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_transactions
this.Control[iCurrent+2]=this.tabpage_transactionamounts
this.Control[iCurrent+3]=this.tabpage_unassignedamounts
end on

on u_tab_transactionmanager.destroy
call super::destroy
destroy(this.tabpage_transactions)
destroy(this.tabpage_transactionamounts)
destroy(this.tabpage_unassignedamounts)
end on

type tabpage_transactions from u_tabpage_transactions within u_tab_transactionmanager
event ue_syskey pbm_syskeydown
string tag = ";objectid=[78680678|1557]"
integer x = 18
integer y = 112
integer width = 2565
integer height = 772
integer taborder = 1
long tabbackcolor = 12632256
end type

event ue_syskey;if keydown(keyalt!) and keydown(keyuparrow!) then
	parent.Setfocus()
	this.setfocus()
end if
end event

on tabpage_transactions.create
call u_tabpage_transactions::create
end on

on tabpage_transactions.destroy
call u_tabpage_transactions::destroy
end on

event ue_checktransactionmanager;//Overriding ancestor to get the TransactionManager from the parent.

This.wf_SetTransactionManager ( Parent.wf_GetTransactionManager ( ) )
end event

event ue_transactionchanged;parent.event ue_transactionchanged ( anv_beo_transaction )
end event

event ue_transactionmodified;parent.event ue_TransactionModified ( )
end event

type tabpage_transactionamounts from u_tabpage_transactionamounts within u_tab_transactionmanager
string tag = ";objectid=[84879702|1570]"
integer x = 18
integer y = 112
integer width = 2565
integer height = 772
integer taborder = 2
long tabbackcolor = 12632256
end type

on tabpage_transactionamounts.create
call u_tabpage_transactionamounts::create
end on

on tabpage_transactionamounts.destroy
call u_tabpage_transactionamounts::destroy
end on

event ue_checktransactionmanager;//Overriding ancestor to get the TransactionManager from the parent.

This.wf_SetTransactionManager ( Parent.wf_GetTransactionManager ( ) )
end event

event ue_getactivetransaction;n_cst_beo_transaction lnv_transaction
integer li_Return

li_Return = -1
lnv_Transaction = Parent.tabpage_transactions.dw_transactions.inv_UILink.GetBeo ( Parent.tabpage_transactions.dw_transactions.GetRow ( ) )

IF IsValid ( lnv_transaction ) THEN

	anv_beo_transaction = lnv_Transaction
	li_Return = 1

END IF

RETURN li_Return

end event

event ue_transactionmodified;parent.event ue_TransactionModified ( )
end event

type tabpage_unassignedamounts from u_tabpage_unassignedamounts within u_tab_transactionmanager
string tag = ";objectid=[84936476|1571]"
integer x = 18
integer y = 112
integer width = 2565
integer height = 772
integer taborder = 3
long tabbackcolor = 12632256
end type

on tabpage_unassignedamounts.create
call u_tabpage_unassignedamounts::create
end on

on tabpage_unassignedamounts.destroy
call u_tabpage_unassignedamounts::destroy
end on

event ue_checktransactionmanager;//Overriding ancestor to get the TransactionManager from the parent.

This.wf_SetTransactionManager ( Parent.wf_GetTransactionManager ( ) )
end event

event ue_getactivetransaction;call super::ue_getactivetransaction;n_cst_beo_transaction lnv_transaction
integer li_Return

li_Return = -1

lnv_Transaction = Parent.tabpage_transactions.dw_transactions.inv_UILink.GetBeo ( Parent.tabpage_transactions.dw_transactions.GetRow ( ) )

IF IsValid ( lnv_transaction ) THEN

	anv_beo_transaction = lnv_Transaction
	li_Return = 1

END IF

RETURN li_Return

end event

