$PBExportHeader$u_dw_companycontacts_list.sru
forward
global type u_dw_companycontacts_list from u_dw
end type
end forward

global type u_dw_companycontacts_list from u_dw
integer width = 2094
integer height = 808
string dataobject = "d_companycontacts_list"
boolean hscrollbar = true
event type integer ue_newcontact ( )
event type integer ue_deletecontact ( long al_row )
event type integer ue_details ( long al_row )
event ue_refresh ( )
event type integer ue_contactcomments ( long al_row )
end type
global u_dw_companycontacts_list u_dw_companycontacts_list

type variables
Long	il_CoID
Long	ila_CoIds[]
DataStore	ids_Cache
boolean ib_Destroycache
end variables

forward prototypes
public function integer of_setcompanyid (long al_CompanyID)
public function integer of_populate ()
public function integer of_filterlist ()
public function integer of_filterlist (string as_Filter)
public function integer of_retrieve (long ala_ids[])
public function integer of_refresh ()
public function integer of_refresh (long ala_ids[])
public function integer of_setcache (datastore ads_Cache)
public function integer of_sharecache ()
public function datastore of_getcache ()
public function integer of_setcompanylist (long ala_Ids[])
public function integer of_cache (long ala_companyids[])
public function integer of_getids (ref long ala_ids[], boolean ab_checkfilter)
public function integer of_getids (ref long ala_Ids[])
public function integer of_getselectedcontactids (ref long ala_contacts[])
end prototypes

event ue_newcontact;Int	li_Return = -1

n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

SetPointer ( HourGlass! )
IF il_CoID > 0 THEN
	lstr_Parm.is_Label = "COMPANYID"
	lstr_Parm.ia_Value = il_CoID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "CONTEXT"
	lstr_Parm.ia_Value = "NEW"
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "CACHE"
	lstr_Parm.ia_Value = ids_Cache
	lnv_Msg.of_Add_Parm ( lstr_Parm )

	OpenWithParm ( w_CompanyContact_Detail , lnv_Msg )
	li_Return = 1
END IF

RETURN li_Return


end event

event ue_deletecontact;// RDT 6-01-03 add a return code and set to -1 if user clicks "no" 
Integer	li_Return 										// RDT 6-01-03 
THIS.SelectRow ( 0 , FALSE )

IF al_Row > 0 THEN
	
	THIS.SelectRow ( al_Row , TRUE )
	
	IF Messagebox ( "Delete Contact" , "Are you sure you want to delete this contact?" , QUESTION! , YESNO! , 2 ) = 1 THEN
		THIS.RowsMove ( al_row, al_row, PRIMARY!, THIS, 999, DELETE! )
		li_Return = 1
		//THIS.Update ( )
	Else 															// RDT 6-01-03 
		li_Return = -1 										// RDT 6-01-03 
	END IF 														// RDT 6-01-03 
	
END IF

THIS.SelectRow ( 0 , FALSE )

// RETURN 1  										// RDT 6-01-03 
Return li_Return 									// RDT 6-01-03 
end event

event ue_details;long	ll_ID
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm


SetPointer ( HourGlass! )

IF al_Row > 0 THEN
			
	lstr_Parm.is_Label = "CONTEXT"
	lstr_Parm.ia_Value = "DETAILS"
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ID"
	lstr_Parm.ia_Value = THIS.GetItemNumber ( al_Row , "ct_id" )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ROW"
	lstr_Parm.ia_Value = al_Row
	lnv_Msg.of_Add_Parm ( lstr_Parm )
		
	lstr_Parm.is_Label = "CACHE"
	lstr_Parm.ia_Value = THIS.of_GetCache ( )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	OpenWithParm ( w_CompanyContact_Detail , lnv_Msg )
		
END IF

RETURN 1
end event

event ue_refresh;THIS.of_Populate ( )
end event

event ue_contactcomments;Long	ll_CoID

IF al_row > 0 AND al_Row <= THIS.RowCount ( ) THEN
	
	ll_CoID = THIS.GetItemNumber ( al_row , "ct_id" )

	openwithparm(w_text_edit, ll_coid * 100 + 3)
	
END IF

RETURN 1
end event

public function integer of_setcompanyid (long al_CompanyID);il_CoID = al_CompanyID
RETURN 1
end function

public function integer of_populate ();IF il_CoID > 0 THEN
	THIS.setReDraw ( FALSE )
	THIS.SetTransObject ( SQLCA )
	THIS.Retrieve ( ) 
	THIS.of_FilterList (  )
	THIS.setReDraw ( TRUE )
END  IF

RETURN 1
end function

public function integer of_filterlist ();

IF il_CoId > 0 THEN
	THIS.SetFilter ( "IsNull (ct_co) OR  ct_co = " + String ( il_CoId ) )
	THIS.Filter ( )
END IF

RETURN 1
end function

public function integer of_filterlist (string as_Filter);String	ls_Filter

ls_Filter = as_Filter

IF NOT IsNull ( ls_Filter ) THEN
	THIS.SetFilter( ls_Filter )
	THIS.Filter ( )
END IF

RETURN 1
end function

public function integer of_retrieve (long ala_ids[]);String	ls_Filter
String	ls_InClause

n_cst_sql	lnv_Sql
IF UpperBound ( ala_Ids ) > 0 THEN
	ls_InClause = lnv_Sql.of_makeInClause ( ala_Ids[] )
	
	ls_Filter = "ct_co " + ls_InClause 
	
	THIS.SetTransObject ( SQLCA )
	THIS.SetRedraw ( FALSE )
	//THIS.Retrieve ( il_CoId ) 
	THIS.Retrieve ( ala_Ids[] ) 
	THIS.SetFilter ( ls_Filter )
	THIS.Filter ( )
	THIS.SetRedraw ( TRUE )

END IF
RETURN 1


end function

public function integer of_refresh ();Long	lla_Ids[]

THIS.of_GetIds ( lla_Ids ) 
//THIS.of_Refresh ( lla_IDs )

RETURN UpperBound ( lla_IDs )
end function

public function integer of_refresh (long ala_ids[]);Int	li_Return
IF UpperBound ( ala_Ids ) > 0 THEN
	li_Return = THIS.Retrieve ( ala_Ids[ ] )
END IF
RETURN li_Return 
end function

public function integer of_setcache (datastore ads_Cache);ids_Cache = ads_Cache
Return 1
end function

public function integer of_sharecache ();Int	li_Rtn

IF isValid ( ids_Cache ) THEN 
	li_Rtn = ids_Cache.ShareData ( THIS )
ELSE
	li_Rtn = -1
END IF

RETURN li_Rtn

end function

public function datastore of_getcache ();Long	ll_Count
IF Not isValid ( ids_Cache ) THEN
	
	ids_Cache = CREATE dataStore 
	ids_Cache.DataObject = "d_companyContacts_list" 
	ids_Cache.SetTransObject ( SQLCA )
	ll_Count = ids_Cache.Retrieve ( {il_CoID} )
	ib_DestroyCache = TRUE	
END IF

RETURN ids_Cache
end function

public function integer of_setcompanylist (long ala_Ids[]);ila_coids = ala_Ids[]
RETURN 1
end function

public function integer of_cache (long ala_companyids[]);Long	ll_Count
IF Not isValid ( ids_Cache ) THEN
	
	ids_Cache = CREATE dataStore 
	ids_Cache.DataObject = "d_companyContacts_list" 
	ids_Cache.SetTransObject ( SQLCA )
	
	ib_DestroyCache = TRUE	
END IF

ll_Count = ids_Cache.Retrieve ( ala_CompanyIds[] )

RETURN 1
end function

public function integer of_getids (ref long ala_ids[], boolean ab_checkfilter);Long	lla_IDs[]
Long	ll_Count
Long	i

ll_Count = THIS.RowCount ( )
FOR i = 1 To ll_Count 
	lla_Ids [ i ] = THIS.GetItemNumber ( i, "ct_id" )
NEXT

IF ab_CheckFilter THEN
	ll_count = THIS.FilteredCount ( )
	FOR i = 1 To ll_Count 
		lla_Ids [ UpperBound ( lla_Ids ) + 1 ] = THIS.GetItemNumber ( i , "ct_id" , FILTER! ,FALSE )
	NEXT
END IF

ala_ids[] = lla_Ids

RETURN UpperBound ( ala_ids[] )
end function

public function integer of_getids (ref long ala_Ids[]);RETURN THIS.of_GetIDs ( ala_Ids , FALSE ) 
end function

public function integer of_getselectedcontactids (ref long ala_contacts[]);Long	ll_i
Long	ll_Count
Long	lla_SelectedContacts[]
Long	lla_SelectedRows []


ll_Count = THIS.inv_RowSelect.of_SelectedCount ( lla_SelectedRows )

FOR ll_i = 1 TO ll_Count
	
	lla_SelectedContacts [ ll_i ] = THIS.GetItemNumber ( lla_SelectedRows[ ll_i ] , "ct_id" )
	
NEXT
ala_Contacts = lla_SelectedContacts

RETURN UpperBound ( ala_Contacts[ ] )
end function

event doubleclicked;this.Event ue_Details ( row )

end event

event constructor;ib_rmbmenu = FALSE
this.of_SetAutoSort ( TRUE )
THIS.of_SetRowSelect ( TRUE )
//begin modification by appeon 20070727
//inv_RowSelect.of_SetStyle ( appeon_constant.single )
pfc_n_cst_dwsrv_rowselection l_cst_dwsrv_rowselection
l_cst_dwsrv_rowselection = create pfc_n_cst_dwsrv_rowselection
inv_RowSelect.of_SetStyle ( l_cst_dwsrv_rowselection.single )
destroy l_cst_dwsrv_rowselection
//end modification by appeon 20070727

end event

event rbuttonup;call super::rbuttonup;String	ls_PopRtn
String	lsa_parm_labels[]
Any		laa_parm_values[]

lsa_parm_labels [1] = "ADD_ITEM"
laa_parm_values [1] = "&New Contact"

lsa_parm_labels [2] = "XPOS"
laa_parm_values [2] = THIS.X + PointerX ( ) + 105

lsa_parm_labels [3] = "YPOS"
laa_parm_values [3] = THIS.Y + PointerY ( ) + 165

IF row > 0 THEN
	
	lsa_parm_labels[4] = "ADD_ITEM"
	laa_parm_values[4] = "&Details"	
	
	lsa_parm_labels [5] = "ADD_ITEM"
	laa_parm_values [5] = "&Comments"
	
	lsa_parm_labels [6] = "ADD_ITEM"
	laa_parm_values [6] = "-"
	
	lsa_parm_labels [7] = "ADD_ITEM"
	laa_parm_values [7] = "Dele&te Contact"
	
	
END IF



ls_PopRtn = f_pop_standard(lsa_parm_labels, laa_parm_values)

CHOOSE CASE ls_PopRtn
				
	CASE "DETAILS"
		THIS.Event ue_Details ( row )
		
	CASE "DELETE CONTACT"
		THIS.Event ue_DeleteContact ( row )	
	
	CASE "NEW CONTACT"
		THIS.Event ue_NewContact ( )
		
	case "COMMENTS"
		THIS.Event ue_ContactComments ( row )
		
	
		
END CHOOSE





end event

event rbuttondown;call super::rbuttondown;IF Row > 0 THEN
	THIS.SetRow ( row )

	THIS.SelectRow  ( 0 , FALSE )
	THIS.SelectRow  ( Row , TRUE )

END IF
end event

event destructor;call super::destructor;IF ib_DestroyCache THEN
	DESTROY ( ids_cache )
END IF
end event

on u_dw_companycontacts_list.create
call super::create
end on

on u_dw_companycontacts_list.destroy
call super::destroy
end on

