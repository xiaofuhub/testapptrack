$PBExportHeader$u_dw_alertlist.sru
forward
global type u_dw_alertlist from u_dw
end type
end forward

global type u_dw_alertlist from u_dw
integer width = 1138
integer height = 564
string dataobject = "d_alerts"
event type integer ue_deleteinactivealerts ( )
event ue_itemchanged ( )
end type
global u_dw_alertlist u_dw_alertlist

forward prototypes
private function integer of_populatevalues ()
public function integer of_activateselected ()
public function integer of_getselectedrows (ref long ala_rows[])
public function integer of_deactivateselected ()
protected function integer of_showcountdetails (long al_msgid)
public function integer of_deleteselectedrows ()
end prototypes

event type integer ue_deleteinactivealerts();Int	li_Return

Long	ll_RowCount 
Long	i
ll_RowCount = THIS.RowCount ( )
For i = ll_RowCount TO 1 Step -1
	
	IF THIS.GetItemNumber( i, "status" ) = 0 THEN
		THIS.DeleteRow (i)
	END IF
	
NEXT

THIS.event ue_itemchanged( )
RETURN li_Return
end event

private function integer of_populatevalues ();Long		ll_Row 
Long		ll_RowCount
Long		ll_Return
String	ls_Class
Long		ll_ID
Long		i
String	ls_Desc
String	ls_Temp1
String	ls_Temp2

n_Cst_EquipmentManager	lnv_EqMan

ll_RowCount = THIS.RowCount( )

FOR i = 1 TO ll_RowCount
	ll_Row = i
	ls_Desc = ""
	ls_Temp1 = ""
	ls_Temp2 =  ""
	
	ls_Class = This.GetItemString	( ll_Row , "classname" )
	ll_ID = THIS.GetItemNumber ( ll_Row , "Sourceid" )
	
	CHOOSE CASE Upper (ls_Class)
			
		CASE "N_CST_BEO_COMPANY"
			Select co_Name into :ls_Desc FROM companies where co_id = :ll_id;
			Commit;
			
			THIS.SetITem ( ll_Row , "entity" , ls_Desc )
									
		CASE "N_CST_BEO_EMPLOYEE" , "N_CST_BEO_EMPLOYEE2"
			
			Select em_ln , em_fn  into :ls_Temp1 , :ls_Temp2 FROM Employees where em_id = :ll_ID;
			Commit;
			
			THIS.SetITem ( ll_Row , "entity" , ls_Temp1 + ", " + ls_Temp2 )
			
		CASE "N_CST_BEO_EQUIPMENT" , "N_CST_BEO_EQUIPMENT2"
			
			Select eq_type , eq_ref into :ls_temp1 , :ls_Temp2 FROM Equipment Where eq_id = :ll_id;
			Commit;
			
			THIS.SetITem ( ll_Row , "entity" , lnv_EqMan.of_GetDisplayValue (ls_Temp1) + " " + ls_Temp2 )
			
		CASE "N_CST_BEO_ITEM"
			
			Select di_shipment_id INTO :ls_temp1 FROM disp_items Where di_item_id = :ll_id;
			Commit;
			
			THIS.SetITem ( ll_Row , "entity" , String ( ll_ID ) + " (TMP:" + String ( ls_Temp1) + ")" )
			
		CASE "N_CST_BEO_EVENT"
			
			Select de_shipment_id INTO :ls_temp1 FROM disp_eVENTS Where de_id = :ll_id;
			Commit;
			IF Len ( ls_Temp1 ) > 0 THEN
				THIS.SetITem ( ll_Row , "entity" , String ( ll_ID ) + " (TMP:" + String ( ls_Temp1) + ")" )
			ELSE
				THIS.SetITem ( ll_Row , "entity" , String ( ll_ID ) )
			END IF
			
		CASE ELSE
			THIS.SetITem ( ll_Row , "entity" , String ( ll_ID ) )
			
	END CHOOSE
	THIS.SetItemStatus( ll_Row, 0, PRIMARY!, NotModified!)
		

NEXT
RETURN ll_Return


end function

public function integer of_activateselected ();Long	lla_Rows[]
long	ll_Count
Long	i

ll_Count = THIS.of_Getselectedrows( lla_Rows )

FOR i = 1 TO ll_Count
	
	THIS.SetItem ( lla_Rows[i] , "status" , 1 ) 
	
NEXT 



RETURN 1
end function

public function integer of_getselectedrows (ref long ala_rows[]);Long	ll_Selected = 0
long	ll_Counter = 0
Long	lla_SelectedRows[]

//Loop and count the number of selected rows.
DO
	ll_selected = THIS.GetSelectedRow ( ll_selected )
	IF ll_selected > 0 THEN
		ll_counter++
		lla_SelectedRows[ll_counter] = ll_selected
	END IF
LOOP WHILE ll_selected > 0

ala_Rows[] = lla_SelectedRows

RETURN UpperBound ( ala_Rows )

end function

public function integer of_deactivateselected ();Long	lla_Rows[]
long	ll_Count
Long	i


ll_Count = THIS.of_Getselectedrows( lla_Rows )

FOR i = 1 TO ll_Count
	
	THIS.SetItem ( lla_Rows[i] , "status" , 0 ) 
	
NEXT 



RETURN 1
end function

protected function integer of_showcountdetails (long al_msgid);OpenWithParm ( w_ActiveAlertCount , al_msgID )
RETURN 1
end function

public function integer of_deleteselectedrows ();Long	lla_Rows[]
Long	i
Long	ll_Count

ll_Count = THIS.of_Getselectedrows( lla_Rows )
FOR i = ll_Count TO 1 STEP -1
	
	THIS.Deleterow( lla_Rows[i] )
	
NEXT

RETURN 1
end function

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA ) 

THIS.of_SetInsertable( FALSE )
THIS.of_setdeleteable( FALSE ) 

THIS.of_Setautofilter( TRUE )
THIS.of_Setautosort( TRUE )
THIS.of_Setautofind( TRUE )

THIS.of_setrowselect ( TRUE )
inv_Rowselect.of_Setstyle( inv_rowselect.extended )




end event

on u_dw_alertlist.create
end on

on u_dw_alertlist.destroy
end on

event rbuttonup;Long	ll_Return = 1
String	ls_Selection
n_cst_Privileges	lnv_privs

CHOOSE CASE	dwo.name
		
	CASE "status"
		string lsa_parm_labels[]
		any laa_parm_values[]
		
		lsa_parm_labels[1] = "ADD_ITEM"
		laa_parm_values[1] = "Activate Alert"
		
		lsa_parm_labels[2] = "ADD_ITEM"
		laa_parm_values[2] = "Deactivate Alert"
		
		lsa_parm_labels[3] = "XPOS"
		laa_parm_values[3] = Pointerx( )
		
		lsa_parm_labels[4] = "YPOS"
		laa_parm_values[4] = PointerY( )
		
		ls_Selection = f_pop_standard(lsa_parm_labels, laa_parm_values)
		
		IF Len ( ls_Selection ) > 0 THEN
			
			IF lnv_Privs.of_HasSysadminrights( ) THEN
				THIS.event ue_itemchanged( )
				CHOOSE CASE  ls_Selection
						
					CASE "ACTIVATE ALERT"
						THIS.of_Activateselected( )
					CASE "DEACTIVATE ALERT"
						THIS.of_Deactivateselected( )
				END CHOOSE
			ELSE
				
				MessageBox ( "Change Alert Status" , lnv_privs.of_Getsysadminmessage( ) )
				
			END IF
			
		END IF
	CASE ELSE
		
		ll_Return = super::event rbuttonup(  xpos, ypos,  row , dwo )
		
END CHOOSE

RETURN ll_Return
end event

event doubleclicked;call super::doubleclicked;IF row > 0 AND row <= THIS.RowCount ( ) THEN
	
	Long ll_ID
	THIS.of_showcountdetails( THIS.GetItemNumber( row , "id" ) )
	
	
END IF

	
	
end event

event retrieveend;call super::retrieveend;THIS.of_Populatevalues(  )
end event

