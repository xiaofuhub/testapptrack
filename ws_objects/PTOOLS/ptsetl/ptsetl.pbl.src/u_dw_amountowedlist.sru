$PBExportHeader$u_dw_amountowedlist.sru
$PBExportComments$AmountOwedList (Data Control from PBL map PTSetl) //@(*)[152771259|322]
forward
global type u_dw_amountowedlist from u_dw
end type
end forward

global type u_dw_amountowedlist from u_dw
integer width = 2400
integer height = 600
boolean bringtotop = true
string dataobject = "d_amountowedlist"
boolean hscrollbar = true
boolean hsplitscroll = true
event type long task_retrieve ( )
event type integer ue_prenew ( ref n_cst_beo_transaction anv_transaction )
event ue_itinerary ( )
end type
global u_dw_amountowedlist u_dw_amountowedlist

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
protected n_cst_bso_transactionmanager in_transactionmanager //@(*)[152817305|323]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function n_cst_bso_transactionmanager GetTransactionmanager ()
public function Integer SetTransactionmanager (n_cst_bso_transactionmanager an_transactionmanager)
public function integer of_getselectedshipmentids (ref long ala_shipids[])
public function integer of_getselectedrows (ref long ala_rows[])
public function long of_deleteselectedrows ()
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

event ue_prenew;//This script is called by pfc_AddRow.  It is a placeholder that allows you to specify
//a transaction that the new amount should be added to.  Override this event in the 
//descendant if you wish to specify a transaction.

//Return : 1 = Transaction Specified, 0 = Don't use a transaction, -1 = Error ( abort )

RETURN 0
end event

event ue_itinerary;Long	ll_SelectedRow, &
		ll_selectedId, &
		ll_EntityId
Date	ld_ItinDate
n_cst_beo_AmountOwed		lnv_Beo
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

public function n_cst_bso_transactionmanager GetTransactionmanager ();//@(*)[152817305|323:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return in_transactionmanager
//@(text)--

end function

public function Integer SetTransactionmanager (n_cst_bso_transactionmanager an_transactionmanager);//@(*)[152817305|323:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

in_transactionmanager = an_transactionmanager
return 1
//@(text)--

end function

public function integer of_getselectedshipmentids (ref long ala_shipids[]);Integer	li_Return = 1
Long		i, ll_Count
Long		lla_SelectedRows[]
Long		lla_ShipIds[]

n_cst_AnyArraySrv		lnv_ArraySrv

ll_Count = inv_RowSelect.of_SelectedCount( lla_SelectedRows )

FOR i = 1 TO ll_Count
	lla_ShipIds[i] = Long(THIS.getitemString(lla_SelectedRows[i], "amountowed_shipment"))
NEXT

lnv_ArraySrv.of_Getshrinked( lla_ShipIds, TRUE, TRUE)

ala_ShipIds = lla_ShipIds

Return li_Return
	
end function

public function integer of_getselectedrows (ref long ala_rows[]);Integer	li_Return = 1
Long		ll_Count
Long		lla_SelectedRows[]

ll_Count = inv_RowSelect.of_SelectedCount( lla_SelectedRows )

ala_rows[] = lla_SelectedRows

Return ll_Count
	
end function

public function long of_deleteselectedrows ();
Long	lla_SelectedRows[]
Long 	i
Long	ll_Count
ll_Count = THIS.of_Getselectedrows( lla_SelectedRows )

THIS.SetRedraw ( FALSE )

FOR i = ll_Count TO 1 STEP -1
	
	THIS.SetRow ( lla_SelectedRows[i] ) 
	THIS.event pfc_deleterow( )
	
NEXT


THIS.SetRedraw ( TRUE ) 

RETURN ll_Count
end function

on u_dw_amountowedlist.destroy
end on

event constructor;//@(data)(recreate=yes)<GenerationOptions>
SetUILink(TRUE)
inv_uilink.SetClass("")
of_SetTransObject(SQLCA)
this.SetUseTaskRetrieve(TRUE)
//@(data)--

n_cst_Presentation_amountOwed	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

n_cst_presentation_amounttype lnv_presentationamounttype
lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_payables)
lnv_presentationamounttype.of_setpresentation(this)

n_cst_presentation_ratetable	lnv_presentationrate
lnv_presentationrate.of_setpresentation(this)

of_SetAutoSort( TRUE )
of_SetAutoFind ( TRUE )


THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (inv_rowselect.extended )

end event

event pfc_addrow;//Note : This does not follow the normal return value scheme.
//It returns 0, not the number of a new row.

n_cst_bso_TransactionManager	lnv_TransactionManager
n_cst_beo_AmountOwed	lnv_AmountOwed
n_cst_beo_Transaction	lnv_Transaction
Long	ll_Row, &
		ll_Return

ll_Return = -1
lnv_TransactionManager = GetTransactionManager ( )

IF IsValid ( lnv_TransactionManager ) THEN

	CHOOSE CASE This.Event ue_PreNew ( lnv_Transaction )

	CASE 1
		//Add the new amount to the specified transaction.
		lnv_AmountOwed = lnv_TransactionManager.of_NewAmountOwed ( lnv_Transaction )

	CASE 0
		//Make a new unassigned amount.
		lnv_AmountOwed = lnv_TransactionManager.of_NewAmountOwed ( )

	CASE ELSE //-1
		//Could not determine transaction.  Allow to fail.

	END CHOOSE


	IF IsValid ( lnv_AmountOwed ) THEN

		inv_UILink.RefreshFromBcm ( )

//	Replaced:
//		ll_Row = inv_UILink.GetBeoRow ( lnv_Beo.GetBeoIndex ( ) )
// With:
		long	ll_id
		string ls_find
		
		ll_id = lnv_AmountOwed.Of_GetId ( )
		IF ll_id > 0 THEN
			ls_find = "amountowed_id = " + string(ll_id)
			ll_row = this.Find ( ls_find,	1, this.RowCount () )
		END IF
// Because the beoindex is no longer valid because PB is internally			
// changing the rowid

		IF ll_Row > 0 THEN
			This.ScrollToRow ( ll_Row )
			ll_Return = ll_Row
		ELSE
			ll_Return = 0
		END IF

	END IF
END IF

RETURN ll_Return
end event

event pfc_insertrow;RETURN This.Event pfc_AddRow ( )
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

on u_dw_amountowedlist.create
end on

event rbuttonup;//Overriding Ancestor
long		ll_Return
Long		lla_ShipmentIds[]
String	lsa_Parm_labels[]
Any		laa_Parm_Values[]

String	 ls_res

n_cst_Msg	lnv_Msg
s_Parm	lstr_Parm

IF dwo.Name = "amountowed_shipment" THEN
	
	This.of_GetSelectedShipmentIds(lla_ShipmentIds)
	
	lsa_parm_labels[2] = "ADD_ITEM"
	laa_parm_values[2] = "&Imaging"

	lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
	laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "&Missing Documents"

	lsa_parm_labels[UpperBound ( lsa_parm_labels ) + 1] = "ADD_ITEM"
	laa_parm_values[ UpperBound ( laa_parm_values ) + 1 ] = "&View Documents"
	ls_res = f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
	CHOOSE CASE ls_res

		CASE "IMAGING"
		
			lstr_parm.is_label = "TOPIC"
			lstr_parm.ia_value = "SHIPMENT!"
			lnv_Msg.of_add_parm(lstr_parm)
		
			lstr_parm.is_label = "REQUEST"
			lstr_parm.ia_value = "IMAGES!"
			lnv_Msg.of_add_parm(lstr_parm)
		
			lstr_parm.is_label = "TARGET_IDS"
			lstr_parm.ia_value = lla_ShipmentIds
			lnv_Msg.of_add_parm(lstr_parm)
		
			f_process_standard(lnv_Msg)
			ll_Return = 1
		
		CASE "MISSING DOCUMENTS"
		
			lstr_parm.is_label = "TOPIC"
			lstr_parm.ia_value = "SHIPMENT!"
			lnv_Msg.of_add_parm(lstr_parm)
		
			lstr_parm.is_label = "REQUEST"
			lstr_parm.ia_value = "MISSINGDOCUMENTS!"
			lnv_Msg.of_add_parm(lstr_parm)
		
			lstr_parm.is_label = "TARGET_IDS"
			lstr_parm.ia_value = lla_ShipmentIds
			lnv_Msg.of_add_parm(lstr_parm)
		
			f_process_standard(lnv_Msg)
			ll_Return = 1
	
		CASE "VIEW DOCUMENTS"
		
			lstr_parm.is_label = "TOPIC"
			lstr_parm.ia_value = "SHIPMENT!"
			lnv_Msg.of_add_parm(lstr_parm)
		
			lstr_parm.is_label = "REQUEST"
			lstr_parm.ia_value = "VIEWDOCUMENTS!"
			lnv_Msg.of_add_parm(lstr_parm)
		
			lstr_parm.is_label = "TARGET_IDS"
			lstr_parm.ia_value = lla_ShipmentIds
			lnv_Msg.of_add_parm(lstr_parm)
		
			f_process_standard(lnv_Msg)
			ll_Return = 1
	END CHOOSE

ELSE
	ll_Return = Super::Event rbuttonup(xpos, ypos, row, dwo)
END IF

Return ll_Return
end event

