$PBExportHeader$u_dw_amountoweddetail.sru
$PBExportComments$AmountOwedDetail (Data Control from PBL map PTSetl) //@(*)[83442956|349]
forward
global type u_dw_amountoweddetail from u_dw
end type
end forward

global type u_dw_amountoweddetail from u_dw
int Width=2400
int Height=600
boolean BringToTop=true
string DataObject="d_amountoweddetail"
boolean TitleBar=true
string Title="Amount Details"
BorderStyle BorderStyle=StyleBox!
boolean ControlMenu=true
boolean VScrollBar=false
event type long task_retrieve ( )
end type
global u_dw_amountoweddetail u_dw_amountoweddetail

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
protected n_cst_bso_transactionmanager in_transactionmanager //@(*)[83449213|350]
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

public function n_cst_bso_transactionmanager GetTransactionmanager ();//@(*)[83449213|350:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_transactionmanager
//@(text)--

end function

public function Integer SetTransactionmanager (n_cst_bso_transactionmanager an_transactionmanager);//@(*)[83449213|350:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_transactionmanager = an_transactionmanager
return 1
//@(text)--

end function

on u_dw_amountoweddetail.destroy
call u_dw::destroy
end on

event constructor;//@(data)(recreate=yes)<GenerationOptions>
SetUILink(TRUE)
inv_uilink.SetClass("")
of_SetTransObject(SQLCA)
this.SetUseTaskRetrieve(TRUE)
//@(data)--

ib_rmbmenu = FALSE

n_cst_Presentation_amountOwed	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

n_cst_presentation_amounttype lnv_presentationamounttype
lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_payables)
lnv_presentationamounttype.of_setpresentation(this)

n_cst_Presentation_ratetable	lnv_PresentationRate
lnv_Presentation.of_setpresentation(this)
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
	
		case "amountowed_startdate" , "amountowed_enddate"
		
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

