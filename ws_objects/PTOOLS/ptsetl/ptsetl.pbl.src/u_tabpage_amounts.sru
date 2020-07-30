$PBExportHeader$u_tabpage_amounts.sru
$PBExportComments$Amounts (Tab Page from PBL map PTSetl) //@(*)[80256744|1564]
forward
global type u_tabpage_amounts from u_tabpg
end type
type dw_amounts from u_dw_amountowedlist within u_tabpage_amounts
end type
type dw_amountdetail from u_dw_amountoweddetail within u_tabpage_amounts
end type
end forward

global type u_tabpage_amounts from u_tabpg
int Width=2601
int Height=800
long PictureMaskColor=536870912
string Text="Amounts"
event ue_checktransactionmanager ( )
event type integer ue_getactivetransaction ( ref n_cst_beo_transaction anv_beo_transaction )
event ue_refresh ( )
event ue_transactionmodified ( )
dw_amounts dw_amounts
dw_amountdetail dw_amountdetail
end type
global u_tabpage_amounts u_tabpage_amounts

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
protected n_cst_bso_transactionmanager in_transactionmanager //@(*)[80256783|1565]
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

event ue_getactivetransaction;//This script is called by pfc_AddRow.  It is a placeholder that allows you to specify
//a transaction that the new amount should be added to.  Override this event in the 
//descendant if you wish to specify a transaction.

//Return : 1 = Transaction Specified, 0 = Don't use a transaction, -1 = Error ( abort )

RETURN 0
end event

event ue_refresh;dw_Amounts.inv_UILink.RefreshFromBcm ( )
IF dw_amounts.RowCount() > 0 THEN
	dw_amountdetail.inv_UILink.RefreshFromBcm ( )
ELSE
	IF dw_amountdetail.visible THEN
		dw_amountdetail.Hide ()
	END IF
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

public function n_cst_bso_transactionmanager wf_GetTransactionmanager ();//@(*)[80256783|1565:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_transactionmanager
//@(text)--

end function

public function integer wf_settransactionmanager (n_cst_bso_transactionmanager an_transactionmanager);//@(*)[80256783|1565:s]<nosync>//@(-)Do not edit, move or copy this line//
//Relay the change to the datawindow.
dw_Amounts.SetTransactionManager ( an_TransactionManager )
dw_amountdetail.SetTransactionManager ( an_TransactionManager )

//@(text)(recreate=yes)<body>

in_transactionmanager = an_transactionmanager
return 1
//@(text)--

end function

protected subroutine wf_displaydetail (datawindow adw_master);dw_amountdetail.inv_UILink.RefreshFromBcm ( )

adw_Master.TriggerEvent ( "pfc_RowChanged" )
dw_amountdetail.inv_UILink.UpdateRequestor ( dw_amountdetail.GetRow ( ) )
dw_amountdetail.setfilter ( "amountowed_id = " + string ( adw_Master.object.amountowed_id[adw_Master.GetRow()]) )
dw_amountdetail.filter ( )
dw_amountdetail.Show ( )
dw_amountdetail.SetFocus ( )

end subroutine

on u_tabpage_amounts.create
int iCurrent
call super::create
this.dw_amounts=create dw_amounts
this.dw_amountdetail=create dw_amountdetail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_amounts
this.Control[iCurrent+2]=this.dw_amountdetail
end on

on u_tabpage_amounts.destroy
call super::destroy
destroy(this.dw_amounts)
destroy(this.dw_amountdetail)
end on

event constructor;call super::constructor;//Extending Ancestor


//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_Amounts
inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
	ldo_Reference.Y + ldo_Reference.Height + li_Border )

//Register resizable controls
This.inv_resize.of_Register ( dw_Amounts, 'ScaleToRight&Bottom' )

//Trigger resize event to perform initial resize of tabpage contents
This.TriggerEvent ( "Resize" )


RETURN AncestorReturnValue
end event

type dw_amounts from u_dw_amountowedlist within u_tabpage_amounts
int X=37
int Y=32
int Width=2491
int Height=704
string Tag=";objectid=[80285266|1567]"
boolean BringToTop=true
end type

on dw_amounts.create
call u_dw_amountowedlist::create
end on

on dw_amounts.destroy
call u_dw_amountowedlist::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
this.SetUseTaskRetrieve(TRUE)
//@(data)--

end event

event task_retrieve;//@(text)(recreate=yes)<retrieve>
long ll_rc = -1
n_cst_bcm lnv_bcm
n_cst_beo lnv_beo
if NOT isValid(in_transactionmanager) then
    in_transactionmanager = create n_cst_bso_transactionmanager
end if
if isValid(in_transactionmanager)  then
    lnv_bcm = gnv_bcmmgr.CreateBCM(in_transactionmanager.of_getamountsowed())
    if isValid(lnv_bcm) then
         if inv_uilink.SetBCM(lnv_bcm) = 1 then
            ll_rc = this.RowCount()
         end if
    end if
end if
return ll_rc
//@(text)--

end event

type dw_amountdetail from u_dw_amountoweddetail within u_tabpage_amounts
event type long task_retrieve ( )
int X=352
int Y=32
int Width=489
int Height=380
int TabOrder=2
string Tag=";objectid=[77100582|1643]"
boolean BringToTop=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

event task_retrieve;//@(text)(recreate=yes)<retrieve>
long ll_rc = -1
n_cst_bcm lnv_bcm
n_cst_beo lnv_beo
if NOT isValid(in_transactionmanager) then
    in_transactionmanager = create n_cst_bso_transactionmanager
end if
if isValid(in_transactionmanager)  then
    lnv_bcm = gnv_bcmmgr.CreateBCM(in_transactionmanager.of_getamountsowed())
    if isValid(lnv_bcm) then
         if inv_uilink.SetBCM(lnv_bcm) = 1 then
            ll_rc = this.RowCount()
         end if
    end if
end if
return ll_rc
//@(text)--

end event

on dw_amountdetail.create
call u_dw_amountoweddetail::create
end on

on dw_amountdetail.destroy
call u_dw_amountoweddetail::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
this.SetUseTaskRetrieve(TRUE)
//@(data)--

end event

