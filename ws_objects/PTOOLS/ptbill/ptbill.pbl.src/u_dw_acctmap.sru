$PBExportHeader$u_dw_acctmap.sru
forward
global type u_dw_acctmap from u_dw
end type
end forward

global type u_dw_acctmap from u_dw
int Width=2565
int Height=1120
string DataObject="d_acctmap"
event ue_filter ( )
event type integer ue_deleterow ( long al_row )
end type
global u_dw_acctmap u_dw_acctmap

type variables
Long  il_CurrentID

end variables

forward prototypes
public function integer of_setcurrentid (long al_ID)
public function long of_getcurrentid ()
public function integer of_getamounttype (integer ai_value, ref n_cst_beo_amounttype anv_amounttype)
end prototypes

event ue_filter;string	ls_filter 

ls_filter = "accountmap_division = " + String ( this.of_getcurrentid()) +  " and " +&
				"amounttype_category in (" + string(n_cst_constants.ci_Category_Payables) +&
				"," + string(n_cst_constants.ci_Category_Both) + ")"
//				"(len(trim( accountmap_apaccount )) > 0 or len(trim( accountmap_payrollexpenseaccount )) > 0)"
this.setfilter(ls_filter)
this.filter()

this.SetSort("accountmap_amounttypeid A")
this.Sort()
end event

public function integer of_setcurrentid (long al_ID);il_currentid = al_ID
Return 1
end function

public function long of_getcurrentid ();return il_CurrentID
end function

public function integer of_getamounttype (integer ai_value, ref n_cst_beo_amounttype anv_amounttype);n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
Integer		li_Return

IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_amounttype", lnv_Cache, TRUE, TRUE ) = 1 THEN

	lnv_Beo = lnv_Cache.GetBeo ( "amounttype_id = " + String ( ai_value ) )

	IF IsValid ( lnv_Beo ) THEN
		li_Return = 1
	ELSE
		li_Return = 0
	END IF

ELSE
	li_Return = -1

END IF

anv_amounttype = lnv_Beo
RETURN li_Return
end function

event constructor;THIS.settransobject(sqlca)

//this.retrieve ()
this.of_setfilter(false)
this.post event ue_filter()

n_cst_presentation_amountowed	lnv_presentation
lnv_Presentation.of_SetPresentation ( THIS )

n_cst_presentation_amounttype lnv_presentationamounttype

lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_payables)
lnv_presentationamounttype.of_setpresentation(this)



end event

event pfc_addrow;Int	li_rtn

//li_rtn = AncestorReturnValue
If this.Event pfc_preinsertrow() <= 0 Then
	li_rtn = 0
else
	li_rtn = this.insertrow(0)
End If

IF li_Rtn > 0 THEN
	this.object.accountmap_division[li_rtn] = il_currentid
	This.SetColumn ( "accountmap_amounttypeid" )
	This.SetRow ( li_Rtn )
	THIS.SetFocus ( )
	
END IF


return li_Rtn
end event

event itemchanged;call super::itemchanged;
//0  (Default) Accept the data value
//1  Reject the data value and don't allow focus to change
//2  Reject the data value but allow the focus to change
//

String	ls_ColName

String	ls_CurrentValue
Long		ll_RowCount
Long		i
Long		ll_ReturnRow
Int		li_Return 

ll_RowCount = THIS.RowCount ( )

ls_ColName = dwo.Name

CHOOSE CASE ls_ColName 
		
	CASE	"accountmap_amounttypeid"
		
		ll_ReturnRow = THIS.Find ( "accountmap_amounttypeid =  " + String (data ), 1, ll_RowCount )						
		IF ll_ReturnRow = row THEN
			ll_ReturnRow = 0
			ll_ReturnRow = THIS.Find ( "accountmap_amounttypeid = "+ String (data ), ll_ReturnRow , ll_RowCount ) 
		END IF

		IF ll_ReturnRow > 0 THEN 
			MessageBox ( "Account Map" , "Duplicate Amount Types are not allowed for a single Shipment Type. Please alter your selection." )
			ls_CurrentValue = string(this.object.accountmap_amounttypeid.primary.original[row])
			if isnull(ls_currentvalue) then
				ls_currentvalue = ''
			end if
			this.settext(ls_CurrentValue)
			li_Return = 1
		END IF
		
		if li_return = 0 then
			n_cst_beo_amounttype	lnv_amounttype
			
			this.of_getamounttype(integer(data),lnv_amounttype)
			if isvalid(lnv_amounttype) then		
				if lnv_amounttype.of_getcategory() = n_cst_constants.ci_Category_Payables then
					//check original value
					if this.object.amounttype_category.primary.original[row] = n_cst_constants.ci_Category_Both then
						//need to warn
						choose case messagebox("Accounts Payable",'You are changing an amount type with a category of Both ' + &
										'to a category of Settlement.  This will remove it from the AR Account tab. ' + &
										'Do you want to change it?', Question!,YesNo!)
							case 1
								li_Return = 0
							case 2
								this.settext(string(this.object.accountmap_amounttypeid.primary.original[row]))
								li_Return = 1
						end choose
					end if
				end if
				this.object.amounttype_category[row] = lnv_amounttype.of_getcategory()
			end if
			
		end if
		
END CHOOSE

RETURN li_Return 
end event

event itemerror;call super::itemerror;//0  (Default) Reject the data value and show an error message box
//1  Reject the data value with no message box
//2  Accept the data value
//3  Reject the data value but allow focus to change

Long	ll_Rtn	

ll_Rtn = AncestorReturnValue

IF ll_Rtn = 0 THEN 
	CHOOSE CASE dwo.name
			
		CASE "accountmap_amounttypeid"
			THIS.SetFocus ( )			
			ll_Rtn = 1
			
	END CHOOSE
END IF

Return ll_Rtn
	
end event

event pfc_validation;call super::pfc_validation;String 	ls_Work
Int		li_Rtn
Int		li_FindRtn

li_Rtn = AncestorReturnValue

IF li_Rtn = 1 THEN
	
	ls_work = "isnull(accountmap_amounttypeid)"
	li_FindRtn = THIS.find(ls_work, 1, THIS.rowcount())
	IF  li_FindRtn > 0 then
		messagebox("Validation", "You must provide a unique Amount Type for each Account Map before "+&
			"processing can continue.")
		THIS.SetRow ( li_FindRtn ) 
		THIS.SetColumn ( "accountmap_amounttypeid" )
		THIS.SetFocus ( )
		li_Rtn = -1
	END IF

END IF

Return li_Rtn
end event

event pfc_preinsertrow;Int	li_Rtn = 1

//li_Rtn = AncestorReturnValue
//
//IF li_Rtn = 1 THEN
	IF THIS.AcceptText ( ) <> 1 THEN
		li_Rtn = 0 // prevent insertion
	ELSEIF THIS.Event Pfc_Validation ( ) <> 1 THEN
		 li_Rtn = 0 // prevent insertion	
	END IF
//END IF

Return li_Rtn
end event

event pfc_update;return 1
end event

event pfc_insertrow;Int	li_rtn

//li_rtn = AncestorReturnValue
If this.Event pfc_preinsertrow() <= 0 Then
	li_rtn = 0
else
	li_rtn = this.insertrow(0)
End If


IF li_Rtn > 0 THEN
	this.object.accountmap_division[li_rtn] = il_currentid
	This.SetColumn ( "accountmap_amounttypeid" )
	This.SetRow ( li_Rtn )
	THIS.SetFocus ( )
	
END IF


return li_Rtn
end event

event pfc_deleterow;//overriding ancestor

return this.event	ue_deleterow(this.getrow())
//return this.deleterow(0)	

end event

