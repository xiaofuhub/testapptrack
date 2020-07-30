$PBExportHeader$u_dw_rate.sru
forward
global type u_dw_rate from u_dw
end type
end forward

global type u_dw_rate from u_dw
integer width = 1870
integer height = 664
string dataobject = "d_rate"
boolean border = false
borderstyle borderstyle = stylebox!
event itemchanging pbm_dwnchanging
event type string ue_getbreakunit ( )
end type
global u_dw_rate u_dw_rate

type prototypes

end prototypes

type variables
string	is_TableName
Long	il_Customerid
end variables

forward prototypes
public function integer of_validatechange (long al_Row)
public function integer of_filterexistingzones ()
public function integer of_shrinkarray (ref string asa_ids[])
public function integer of_getzonenames (ref string asa_names[])
end prototypes

event itemchanging;String	ls_temp
String	ls_current

CHOOSE CASE dwo.name 
			
	CASE "destzone"
		If IsValid(inv_dropdownsearch) Then
			IF inv_dropdownsearch.event ue_editchanged(row, dwo, data, ls_temp) THEN
//				ls_current = this.getItemString( row, "destzone" )
//				IF len( data ) = 1 THEN
//				//	this.post setfocus()
//					this.post selectText( 2, len( ls_current )  )
//				END IF
				//nothing
			ELSE
				//beep
				beep(1)
			END IF
			IF len(data) >0 THEN
				//nothing
			ELSE
				//prevents a blank row
				//arrow down
//				inv_dropDownSearch.keybd_event( 40, 1, 0, 0)
//				ls_current = this.getItemString( row, "destzone" )
//				IF len( ls_current ) > 1 THEN
//					this.post selectText( 2, len( ls_current )  )
//				END IF
			END IF
		End If	
END CHOOSE
end event

event type string ue_getbreakunit();//meant to be overridden
return ""
end event

public function integer of_validatechange (long al_Row);RETURN -1


end function

public function integer of_filterexistingzones ();Int	li_Return = 1

// this woks as is... just waiting for QA to pass it before it is released.
Long	ll_RowCount
Long	ll_Index
DataWindowChild	ldwc_zone
this.Getchild("destzone",ldwc_zone)
String	lsa_Names[]
String	ls_InClause
String	ls_breakunit
Int		li_proceed
Int	li_Temp
ll_RowCount = THIS.RowCount ( )


//-------Modified by dan---12-7-2005-------------

ls_breakUnit = this.event ue_getbreakunit( )

li_proceed = 1   //I commented out the following code
					  //because we want to filter out names that have already
					  //been tabbed out of with all the breaks entered for that
					  //destination zone already.
//IF ls_breakUnit <> "F" THEN
//	//we don't want to filter if its anything else
//	li_proceed = 1
//ELSE
//	li_proceed = 1
//END IF

IF li_proceed = 1 THEN
	this.of_getzonenames( lsa_names )
	//--------------This code was slower then death taking 8 minutes to deal with NJ piers for big daddy
	//FOR ll_index = 1 TO ll_RowCount
		
	//	lsa_Names[ll_index] = THIS.GetITemString( ll_index ,"destzone")
		
	//NEXT
	////Messagebox("of_filterExistingZonges, u_dw+rate", "b")
	//n_Cst_AnyArraySrv	lnv_Array
	//lnv_Array.of_GetShrinked( lsa_Names, TRUE, TRUE )
	
	//Messagebox("of_filterExistingZonges, u_dw+rate", upperBound(lsa_names))
	//this.of_shrinkarray( lsa_names )
	//------------------------------------------------------------------------
	//n_cst_filesrvwin32 temp
	//temp = create n_cst_Filesrvwin32
	n_Cst_String	lnv_String
	n_cst_Sql	lnv_Sql
	IF Upperbound ( lsa_Names ) > 0 THEN
		ls_InClause	= lnv_Sql.of_Makeinclausefromstrings( lsa_Names )
		li_Temp = ldwc_zone.SetFilter ( "name not " + ls_InClause )
		li_Temp = ldwc_zone.Filter()
	END IF
END IF


RETURN li_Return
end function

public function integer of_shrinkarray (ref string asa_ids[]);//the following function takes the array passed in and then puts
//all of it contents into a datastore
//Then through a series of filters and sorts, it removes any duplicate values from
//itself, and then it replaces the old array with a new one with the values
//refilled by the datastore

Datastore	lds_temp
Long			ll_max
Long			ll_index
Long			ll_inserted
Long			ll_newIndex
String		ls_value
String		ls_filter
String		lsa_newArray[]

lds_temp = create Datastore

lds_temp.dataobject = "d_onestringcolumn"

lds_temp.settransobject( SQLCA )


ll_newIndex = 1
//copy all the array non null contents into the datastore
ll_max = upperbound( asa_ids )
FOR ll_index = 1 to ll_max
	IF not isNULL( asa_ids[ll_index] ) THEN
		ll_inserted = lds_temp.insertRow( 0 )
		
		lds_temp.setItem( ll_inserted,1, asa_ids[ll_index] )
	END IF
NEXT


lds_temp.sort()

//get the first item, filter based on that item, remove all duplicates

DO WHILE lds_temp.rowCount() > 0
	ls_value = lds_temp.getItemString( 1,1 )
	ls_filter = "nonduplicate = '"+ ls_value +"'"
	
	lds_temp.setFilter( ls_filter )
	lds_temp.filter()
	
	lds_temp.rowsMove( 1, lds_temp.rowCount(), PRIMARY!, lds_temp, 1, DELETE! )
	
	lsa_newArray[ll_newIndex] = ls_value
	ll_newIndex++
	
	ls_filter = ""
	
	lds_temp.setFilter( ls_filter )
	lds_temp.filter()
	
LOOP

asa_ids = lsa_newArray

DESTROY lds_temp
return 1
end function

public function integer of_getzonenames (ref string asa_names[]);/***************************************************************************************
NAME: 			of_getZoneNames

ACCESS:			public
		
ARGUMENTS: 		
							asa_names[] :		reference to an array that the destzone names will be stored

RETURNS:			1
	
DESCRIPTION: This function was written to efficiently get an ordered array of of destzone values
				 found in this object. No duplicates or nulls are in the result array. The function
				 was written to have the effect of of_shrinkarray on the array of destzone values
				 found in column "destzone", but to do it in an efficient way. The building is of 
				 the order NLog(N).
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 12-8-2005
	

***************************************************************************************/

Long	ll_index
Long	ll_RowCount
Long	ll_first
Long	ll_last
Long	ll_mid
String	ls_id

String	ls_value
Datastore	lds_temp
Boolean		lb_found

lds_temp = Create Datastore
lds_temp.dataobject = "d_onestringcolumn"


ll_rowCount = this.rowCount()
//gets all the values and inserts them into a datastore in ascending order.
FOR ll_index = 1 TO ll_RowCount
	lb_found = false
	ls_value = this.getItemString( ll_index, "destzone")
	//we want to exclude null values
	IF not isNULL( ls_value ) THEN
		ll_first = 1
		ll_last = lds_temp.rowCount()
		
		//finding where to insert
		DO WHILE ll_first <= ll_last
			ll_mid = ((ll_first + ll_last)/2)
			
			ls_id = lds_temp.getItemString( ll_mid, "nonduplicate" )
			IF ls_id = ls_value THEN 
				//we found it so we don't want to add it
				EXIT
			END IF
			
			IF ls_id > ls_value THEN
				ll_last = ll_mid - 1
			ELSE
				ll_first = ll_mid + 1
			END IF
		LOOP
		
		//if this is true then we didn't find it, so we want to insert it into the datastore at ll_first
		IF ll_first > ll_last THEN
			//add the item to the datastore
			
			lds_temp.insertRow( ll_first )
			lds_temp.setItem( ll_first, "nonduplicate", ls_value )
		END IF
	END IF
NEXT

IF	lds_temp.rowCount() > 0 THEN
	//MessageBox("ofgetzonenames", lds_temp.rowCount())
	asa_names = lds_temp.object.nonduplicate.primary
END IF
DESTROY lds_temp
return 1



end function

event constructor;//THIS.InsertRow ( 0 ) 
n_cst_presentation_RateTable 	lnv_Presentation 
lnv_Presentation.of_SetPresentation ( THIS )
THIS.SetTransObject ( SQLCA )

end event

event itemchanged;call super::itemchanged;Long	ll_Return
Dec	lc_Null
SetNull ( lc_Null )

String	ls_old
String	ls_new
String	ls_breakUnit

ll_Return = AncestorReturnValue

IF ll_Return = 0 THEN
	CHOOSE CASE dwo.name 
			
		CASE "break"
			IF THIS.FInd ( "break = " +  data  , 1 , 9999 ) > 0 THEN
				ll_Return = 1
				MessageBox ( "Rate Break" , "The break entered already exists." )
				THIS.object.break[row] = lc_Null
				
			END IF
		CASE "destzone"
			// Dan added to make the destination not editably and supply type ahead
			ls_old = data
			IF isValid(inv_dropdownsearch) THEN
				inv_dropdownsearch.EVENT ue_editChanged( row, dwo, data, ls_new ) 
			
				IF len( data ) <= 0 THEN
					inv_dropDownSearch.keybd_event( 40, 1, 0, 0)
					//this.rowSMove( row, row, PRIMARY!, this, 0, DELETE! )
					//ll_return = 1
				ELSEIF ls_old <> ls_new AND ls_new > "" THEN
					this.post setItem( row, "destzone", ls_new)
				END IF
				
//				IF ls_new > "" THEN
//				ELSE
//					ls_breakUnit = this.event ue_getbreakunit( )
//					//Only if BREAKUNIT is flat, delete the row when the destinateion becomes blank
////					IF ls_breakUnit = "F" THEN
////					//	this.event pfc_deleterow( )
////					ELSE
////						//clearing it may means they want it to become the same destination name
////						//as the prior row
////					END IF
//				END IF
			END IF
			//---------------------------------
	END CHOOSE 
END IF


Return ll_Return
end event

event itemerror;call super::itemerror;long ll_return

ll_Return = ancestorReturnValue

IF ll_Return = 0 THEN

	choose case upper(dwo.name)
			
		case "RATEBREAK"
			choose case data
				case 'N', 'MIN'
					this.setitem(row,'ratebreak',-2.00)
					ll_Return = 3
				case 'X', 'MAX'
					this.setitem(row,'ratebreak',-1.00)
					ll_Return = 3
			end choose
			
		case "RATE"
			this.object.rate[row] = 0
			ll_Return = 2
			
	end choose
end  if

return ll_return

end event

on u_dw_rate.create
end on

on u_dw_rate.destroy
end on

event itemfocuschanged;call super::itemfocuschanged;//added by Dan---needed for typeahead
CHOOSE CASE dwo.name 
			
	CASE "destzone"
		IF IsValid(this.inv_dropdownsearch) THEN
			this.inv_dropdownsearch.Event pfc_ItemFocusChanged (row, dwo)
		END IF
		
END CHOOSE
end event

event ue_export;//Modified to override ancestor By Dan to prevent exports if changes are pending on the datawindow
Long	ll_RowCount
Long	i


//since there is always a blank row at the bottom, i have to get rid of it
//before I do the test of modifiedcount.
ll_RowCount = THIS.RowCount ( )
FOR i = ll_RowCount TO 1 STEP -1
	IF IsNull (  THIS.GetItemNumber ( i , "ratebreak", Primary!, true  )  ) THEN
		THIS.RowsDiscard ( i, i, Primary! ) 
	END IF	
NEXT

IF this.modifiedcount( ) > 0 THEN
	//MessageBox("mod count", this.modifiedcount())
	MessageBox("Export", "Error, could not export because changes are pending, try saving and exporting again.", Exclamation!)
ELSE	
	super::event ue_export()
END IF
end event

