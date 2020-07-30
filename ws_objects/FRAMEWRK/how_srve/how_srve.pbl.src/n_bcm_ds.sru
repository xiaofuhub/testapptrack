$PBExportHeader$n_bcm_ds.sru
forward
global type n_bcm_ds from ofr_n_bcm_ds
end type
end forward

global type n_bcm_ds from ofr_n_bcm_ds
end type
global n_bcm_ds n_bcm_ds

forward prototypes
public function long append (readonly n_bcm_ds ads_view_new)
private function integer purgeduplicates (readonly long al_afterrow)
public function integer getkeycolumns (ref integer aia_keycolumns[])
private function integer preparemerge (readonly datastore ads_source, readonly datastore ads_target, readonly integer aia_keycolumns[])
public function long getdata (readonly string as_colname[], readonly string as_datatype[], readonly long al_beoindex, ref any aa_data[])
public function long getretrieveddata (readonly string as_colname[], readonly string as_datatype[], ref any aa_data[])
end prototypes

public function long append (readonly n_bcm_ds ads_view_new);//////////////////////////////////////////////////////////////////////////////
//
//   Function:      Append
//
//   Arguments:      ads_view_new  View to append to 'this' view
//
//   Returns:         Integer
//                  1      success
//                  -1      error
//
//   Description:   Appends view data to this view
//
//////////////////////////////////////////////////////////////////////////////
//   
//   Revision History
//
//   Version
//   2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
integer          li_rc
long            ll_RowsNew
long           ll_RowsOrig
long            ll_row
long           ll_beo_index
dwitemstatus   ldwis

//BEGIN EXTENSION CODE

//Extension Variables
Boolean	lb_PreventDuplicates, &
			lb_UsingLocalSource
n_bcm_ds	lds_Source
Integer	lia_KeyColumns[]

//Placeholder, in case we want to make this functionality optional
lb_PreventDuplicates = TRUE

IF lb_PreventDuplicates = FALSE OR & 
	Abs ( This.RowCount ( ) ) + Abs ( This.DeletedCount ( ) ) = 0 THEN
	//RowCount condition prevents endless loop.  There are no rows in 
	//this (the target), so screening is not necessary.  If we change to 
	//screening the source for duplicates within itself, this will need 
	//to be changed.

	//Bypass duplicate row screening -- append the datastore as is
	lds_Source = ads_View_New

ELSE

	lb_UsingLocalSource = TRUE  //Flag for DESTROY later
	lds_Source = CREATE n_bcm_ds
	lds_Source.DataObject = ads_View_New.DataObject

	//IF ads_View_New has the BEOIndex column added, add it to lds_Source also, so
	//the rows can be copied properly.
	IF ads_View_New.IsBOIndexAdded ( ) = TRUE THEN
		lds_Source.AddBEOIndex ( )
	END IF
		

	lds_Source.Append ( ads_View_New )  
	//This will just copy ads_View_New into lds_Source.  
	//It's not an infinite loop because lds_Source.RowCount() will be zero, as tested above.
	This.GetKeyColumns ( lia_KeyColumns )

	//MessageBox ( "PrepareMerge" + " " + String(UpperBound ( lia_KeyColumns )), String ( &
	This.PrepareMerge ( lds_Source, This, lia_KeyColumns )   //) )
	//*****NEED ERROR HANDLING HERE******

END IF

//END EXTENSION CODE  (except bug fixes, below)
//Note:  All references to lds_Source from here on were ads_View_New in HOW code


//BKW : It seems like the following should take RowCount or DeletedCount > 0, 
//since we merge deleted rows
    
ll_RowsNew = lds_Source.RowCount()

if ll_RowsNew = 0 then
   li_rc = 1

ELSE
    
	//   Set number of rows retrieved to totals rows in buffer
	this.il_retrieved = ll_RowsNew
		 
	ll_RowsOrig = this.RowCount()
		 
	li_rc = lds_Source.RowsCopy(1, ll_RowsNew, Primary!, this, ll_RowsOrig + 1, Primary!)
		 
	if li_rc = 1 then
		for ll_row = 1 to ll_RowsNew
			
			// Set up the beoindex for appended rows


			//**??Shouldn't this use nextindex instead??**	
//			if ii_beo_index_col > 0 then  //**Condition Added -- Bug Fix**
//				ll_beo_index = this.GetMaxIndex(1, ll_RowsOrig)
//			end if
	
			ll_RowsOrig ++
	
//			if ii_beo_index_col > 0 then  //**Condition Added -- Bug Fix**
//				this.SetItem(ll_RowsOrig, ii_beo_index_col, ll_beo_index + 1)
//				this.SetNextBEOIndex(ll_beo_index + 1)
//			end if

			//I think they're not using SetBeoIndexForRow because it has a SetItemStatus
			//in it, which they're trying to control below here.
			if ii_beo_index_col > 0 then  //**Condition Added -- Bug Fix**
				this.SetItem ( ll_RowsOrig, ii_beo_index_col, This.GetNextIndex ( ) )
			end if
	
			// Set the row status' for the newly appended rows
			ldwis = lds_Source.GetItemStatus(ll_row, 0, Primary!)
			if ldwis = NotModified! then
				this.SetItemStatus(ll_RowsOrig, 0, Primary!, DataModified!)
				this.SetItemStatus(ll_RowsOrig, 0, Primary!, NotModified!)
			else
				this.SetItemStatus(ll_RowsOrig, 0, Primary!, ldwis)
			end if
		next
	end if
		 

	//NOTE:  This doesn't set BEOIndexes for the deleted rows.  Also, this code doesn't check
	//the return value of RowsCopy, the way the code above does.  Not sure on both of these
	//whether that was done on purpose or not??

	ll_RowsNew = lds_Source.DeletedCount()
	ll_RowsOrig = this.DeletedCount()
		 
	if ll_RowsNew > 0 then
		li_rc = lds_Source.RowsCopy(1, ll_RowsNew, Delete!, this, ll_RowsOrig + 1, Delete!)
	end if
		 
	for ll_row = 1 to ll_RowsNew
		ldwis = lds_Source.GetItemStatus(ll_row, 0, Delete!)
		ll_RowsOrig ++
		choose case ldwis
			case NotModified!
				this.SetItemStatus(ll_RowsOrig, 0, Delete!, DataModified!)
				this.SetItemStatus(ll_RowsOrig, 0, Delete!, NotModified!)
			case DataModified!, NewModified!
				this.SetItemStatus(ll_RowsOrig, 0, Delete!, ldwis)
		end choose
	next
		 
	//svh - ia orgininal buffer will need to be appended.  gk says it should also change 
	//from an any to a string.  Unclear as to why....

END IF

//If we created a working datastore in addition to the one passed in, destroy the working copy.
IF lb_UsingLocalSource THEN
	DESTROY lds_Source
END IF
    
return li_rc

end function

private function integer purgeduplicates (readonly long al_afterrow);//Return Values
// 1 = No Conflicts Detected, Merge is approved  (*NOTE*: rows may have been removed from ads_View)
//-1 = Error.  Could not evaluate merge request.  Source & Target left unchanged.
//-2 = Conflict detected.  Merge rejected.  Source rows are cleared from ads_View.						

Long		ll_SourceRows, &
			ll_TargetRows[3], &
			ll_SourceRow, &
			ll_TargetRow
CONSTANT Integer	li_Buffers = 3
Integer	li_TargetBuffer, &
			li_KeyCount, &
			li_ColumnCount, &
			li_Index, &
			lia_KeyColumns[]
Any		laa_SourceData[], &
			laa_TargetData[], &
			laa_SourceRow[], &
			laa_TargetRow[]
Boolean	lb_KeyMatch

li_KeyCount = GetKeyColumns ( lia_KeyColumns )

IF li_KeyCount > 0 THEN
	//OK
ELSE
	//No keys to match with.
	RETURN -1
END IF

li_ColumnCount = Integer ( This.Describe ( "datawindow.column.count" ) )

ll_SourceRows = This.RowCount ( )

ll_TargetRows[1] = al_AfterRow
ll_TargetRows[2] = This.FilteredCount ( )
ll_TargetRows[3] = This.DeletedCount ( )


IF ll_SourceRows > 0 THEN

	laa_SourceData = This.Object.Data.Primary.Original

	FOR li_TargetBuffer = 1 TO li_Buffers
	
		IF ll_TargetRows [ li_TargetBuffer ] > 0 THEN
	
			CHOOSE CASE li_TargetBuffer
			CASE 1 //Primary
				laa_TargetData = This.Object.Data.Primary.Original
			CASE 2 //Filter
				laa_TargetData = This.Object.Data.Filter.Original
			CASE 3 //Delete
				laa_TargetData = This.Object.Data.Delete.Original
			END CHOOSE
	
		ELSE
			CONTINUE  //li_TargetBuffer
	
		END IF
	
		FOR ll_SourceRow = ll_SourceRows TO ( al_AfterRow + 1 ) STEP -1
	
			laa_SourceRow = laa_SourceData [ ll_SourceRow ]
	
			FOR ll_TargetRow = 1 TO ll_TargetRows [ li_TargetBuffer ]
	
				laa_TargetRow = laa_TargetData [ ll_TargetRow ]
	
				lb_KeyMatch = TRUE  //Will be set to false if non-match detected
	
				FOR li_Index = 1 TO li_KeyCount
	
					IF laa_SourceRow [ lia_KeyColumns [ li_Index ] ] = &
						laa_TargetRow [ lia_KeyColumns [ li_Index ] ] THEN
	
						//Column Value Matches -- Continue
	
					ELSE
	
						//Column Value Does not match -- set flag and exit
						lb_KeyMatch = FALSE
						EXIT
	
					END IF
	
				NEXT  //Key Index
	
				IF lb_KeyMatch = TRUE THEN
	
					//Keys match.  Check original values for conflicts.
	
					FOR li_Index = 1 TO li_ColumnCount
	
						IF laa_SourceRow [ li_Index ] = laa_TargetRow [ li_Index ] THEN
	
							//Original Column Values Match.  Proceed to next column.
	
						ELSEIF IsNull ( laa_SourceRow [ li_Index ] ) AND IsNull ( laa_TargetRow [ li_Index ] ) THEN
		
							//Original Column Values Match.  Proceed to next column.
		
						ELSE
		
							//Original Column Values do not match.  The data has changed in the database since the
							//target was originally retrieved.  Clear the source, return conflict indicator.
		
							This.RowsDiscard ( al_AfterRow + 1, ll_SourceRows, Primary! )
							RETURN -2
		
						END IF
	
					NEXT  //Column Index
	
					//The original values for the matching rows are the same.  The source row is a duplicate.
					//Discard it and proceed to the next source row (exit the target row loop).
	
					This.RowsDiscard ( ll_SourceRow, ll_SourceRow, Primary! )
					EXIT
	
				END IF
	
			NEXT  //ll_TargetRow
	
		NEXT  //ll_SourceRow
	
	NEXT  //li_TargetBuffer

END IF


//No conflicts detected -- Return Approval
RETURN 1
end function

public function integer getkeycolumns (ref integer aia_keycolumns[]);//Returns: The number of key columns, the indexes of which are returned by reference

//NOTE: It's not clear to me whether there should be some further restrictions on this
//logic to limit findings to one class.  This is a potential source of problems.

Integer	lia_KeyColumns[], &
			li_ColumnCount, &
			li_KeyCount, &
			li_Column
ofr_s_bcm_ds_DataCol	lstra_Columns[]

This.GetCols ( lstra_Columns )
li_ColumnCount = UpperBound ( lstra_Columns )

FOR li_Column = 1 TO li_ColumnCount

	IF UpperBound ( lstra_Columns [ li_Column ].ColMap ) > 0 THEN
		//Things like computed columns will not have any ColMap array entries,
		//so this check is necessary to prevent crash

		IF lstra_Columns [ li_Column ].ColMap [ 1 ].i_Key = 1 THEN
	
			li_KeyCount ++
			lia_KeyColumns [ li_KeyCount ] = li_Column
	
		END IF

	END IF

NEXT

aia_KeyColumns = lia_KeyColumns

RETURN li_KeyCount
end function

private function integer preparemerge (readonly datastore ads_source, readonly datastore ads_target, readonly integer aia_keycolumns[]);//Return Values
// 1 = No Conflicts Detected, Merge is approved  (*NOTE*: rows may have been removed from source)
//-1 = Error.  Could not evaluate merge request.  Source & Target left unchanged.
//-2 = Conflict detected.  Merge rejected.  Source datastore is cleared.						

Long		ll_SourceRows[3], &
			ll_TargetRows[3], &
			ll_SourceRow, &
			ll_TargetRow
CONSTANT Integer	li_Buffers = 3
Integer	li_SourceBuffer, &
			li_TargetBuffer, &
			li_KeyCount, &
			li_ColumnCount, &
			li_Index
DWBuffer	le_SourceBuffer
Any		laa_SourceData[], &
			laa_TargetData[], &
			laa_SourceRow[], &
			laa_TargetRow[]
Boolean	lb_KeyMatch
//Commented pending testing
//n_cst_OFRError	lnv_Error

li_KeyCount = UpperBound ( aia_KeyColumns )

IF li_KeyCount > 0 THEN
	//OK
ELSE
	//No keys to match with.
//Commented pending testing
//	lnv_Error = This.AddOFRError ( )
//	lnv_Error.SetErrorMessage( "Could not process request." )
	RETURN -1
END IF

li_ColumnCount = Integer ( ads_Source.Describe ( "datawindow.column.count" ) )

ll_SourceRows[1] = ads_Source.RowCount ( )
ll_SourceRows[2] = ads_Source.FilteredCount ( )
ll_SourceRows[3] = ads_Source.DeletedCount ( )

ll_TargetRows[1] = ads_Target.RowCount ( )
ll_TargetRows[2] = ads_Target.FilteredCount ( )
ll_TargetRows[3] = ads_Target.DeletedCount ( )


IF Abs ( ll_TargetRows [ 1 ] ) + Abs ( ll_TargetRows [ 2 ] ) + Abs ( ll_TargetRows [ 3 ] ) = 0 THEN
	//No data in target to conflict with.  Merge is ok.
	//(Not performing this check would not cause a problem, just extra processing below.)
	RETURN 1
END IF


FOR li_SourceBuffer = 1 TO li_Buffers

	IF ll_SourceRows [ li_SourceBuffer ] > 0 THEN

		CHOOSE CASE li_SourceBuffer
		CASE 1 //Primary
			le_SourceBuffer = Primary!
			laa_SourceData = ads_Source.Object.Data.Primary.Original
		CASE 2 //Filter
			le_SourceBuffer = Filter!
			laa_SourceData = ads_Source.Object.Data.Filter.Original
		CASE 3 //Delete
			le_SourceBuffer = Delete!
			laa_SourceData = ads_Source.Object.Data.Delete.Original
		END CHOOSE

	ELSE
		CONTINUE  //li_SourceBuffer

	END IF

	FOR li_TargetBuffer = 1 TO li_Buffers

		IF ll_TargetRows [ li_TargetBuffer ] > 0 THEN

			CHOOSE CASE li_TargetBuffer
			CASE 1 //Primary
				laa_TargetData = ads_Target.Object.Data.Primary.Original
			CASE 2 //Filter
				laa_TargetData = ads_Target.Object.Data.Filter.Original
			CASE 3 //Delete
				laa_TargetData = ads_Target.Object.Data.Delete.Original
			END CHOOSE

		ELSE
			CONTINUE  //li_TargetBuffer

		END IF

		FOR ll_SourceRow = ll_SourceRows [ li_SourceBuffer ] TO 1 STEP -1

			laa_SourceRow = laa_SourceData [ ll_SourceRow ]

			FOR ll_TargetRow = 1 TO ll_TargetRows [ li_TargetBuffer ]

				laa_TargetRow = laa_TargetData [ ll_TargetRow ]

				lb_KeyMatch = TRUE  //Will be set to false if non-match detected

				FOR li_Index = 1 TO li_KeyCount

					IF laa_SourceRow [ aia_KeyColumns [ li_Index ] ] = &
						laa_TargetRow [ aia_KeyColumns [ li_Index ] ] THEN

						//Column Value Matches -- Continue

					ELSE

						//Column Value Does not match -- set flag and exit
						lb_KeyMatch = FALSE
						EXIT

					END IF

				NEXT  //Key Index

				IF lb_KeyMatch = TRUE THEN

					//Keys match.  Check original values for conflicts.
	
					FOR li_Index = 1 TO li_ColumnCount
	
						IF laa_SourceRow [ li_Index ] = laa_TargetRow [ li_Index ] THEN
	
							//Original Column Values Match.  Proceed to next column.
	
						ELSEIF IsNull ( laa_SourceRow [ li_Index ] ) AND IsNull ( laa_TargetRow [ li_Index ] ) THEN
		
							//Original Column Values Match.  Proceed to next column.
		
						ELSE
		
							//Original Column Values do not match.  The data has changed in the database since the
							//target was originally retrieved.  Clear the source, return conflict indicator.
		
							ads_Source.Reset ( )
//							Commented pending testing
//							lnv_Error = This.AddOFRError ( )
//							lnv_Error.SetErrorMessage( "Data has been modified in the database that conflicts with "+&
//								"information already retrieved." )
							RETURN -2
		
						END IF
	
					NEXT  //Column Index
	
					//The original values for the matching rows are the same.  The source row is a duplicate.
					//Discard it and proceed to the next source row (exit the target row loop).
	
					ads_Source.RowsDiscard ( ll_SourceRow, ll_SourceRow, le_SourceBuffer )
					EXIT

				END IF

			NEXT  //ll_TargetRow

		NEXT  //ll_SourceRow

	NEXT  //li_TargetBuffer

NEXT  //li_SourceBuffer


//No conflicts detected -- Return Approval
RETURN 1
end function

public function long getdata (readonly string as_colname[], readonly string as_datatype[], readonly long al_beoindex, ref any aa_data[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetData  (OVERRIDE)
//
// NOTE: This function is being overridden in order to provide the capability
// of returning computed values in the requested result set.  This computed
// column capability is implemented in conjuction with the dlk.
//
//	Arguments:		as_colname[]		column names
//						as_datatype[]		column datatypes
//						al_beoindex			beoindex of row to copy (0 for all rows)
//						aa_data[]			reference: returned data
//
//	Returns:			long
//						>= 0		Number of rows returned
//						-1			Error
//
//	Description:	Returns column data for the specified columns
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_startrow, ll_endrow, ll_rows
int li_cols, li_col, li_sourcecol
string ls_syntax, ls_error
datastore lds_buffer


//Begin Extension

Any	laa_ComputedValues[]
Boolean	lb_DlkValid

lb_DlkValid = IsValid ( inv_Dlk )

//End Extension


lds_buffer = create datastore
if this.CreateSyntax(as_colname, as_datatype, ls_syntax) = 1 then
	if lds_buffer.Create(ls_syntax, ls_error) <> 1 then
		if isValid(inv_dlk) then
			inv_dlk.SetException("ofr_n_bcm_ds::GetData", "27991", {ls_error})
		end if
		return -1
	end if
else
	return -1
end if

li_cols = UpperBound(as_colname)
if al_beoindex = 0 then
	ll_startrow = 1
	ll_rows = this.RowCount()
	ll_endrow = ll_rows
else
	ll_startrow = this.GetBEORow(al_beoindex)
	if ll_startrow > 0 then
		ll_endrow = ll_startrow
		ll_rows = 1
	end if
end if

if ll_rows > 0 then
	//		Prevent GPF
	lds_buffer.insertrow(0)
	for li_col = 1 to li_cols
		li_sourcecol = integer(this.describe(as_colname[li_col] + ".id"))
		if li_sourcecol > 0 then
			lds_buffer.Object.Data[1, li_col, ll_rows, li_col] = &
					this.Object.Data[ll_startrow, li_sourcecol, ll_endrow, li_sourcecol]

		//Begin Extension

		ELSEIF lb_DlkValid THEN

			IF inv_Dlk.Event pt_ComputeColumn ( as_Colname [ li_Col ], ll_StartRow, ll_EndRow, &
				laa_ComputedValues ) = 1 THEN

				lds_Buffer.Object.Data.Primary [ 1, li_Col, ll_Rows, li_Col ] = laa_ComputedValues

			END IF

		//End Extension

		end if
	next
	if al_beoindex = 0 then
		aa_data = lds_buffer.object.data
	else
		aa_data = lds_buffer.object.data[1]
	end if
end if

destroy lds_buffer

return ll_rows

end function

public function long getretrieveddata (readonly string as_colname[], readonly string as_datatype[], ref any aa_data[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetRetrievedData  (OVERRIDE)
//
// NOTE: This function is being overridden in order to provide the capability
// of returning computed values in the requested result set.  This computed
// column capability is implemented in conjuction with the dlk.
//
//	Arguments:		as_colname[]		column names
//						as_datatype[]		column datatypes
//						aa_data[]			reference: returned data
//
//	Returns:			long
//						>= 0		Number of rows returned
//						-1			Error
//
//	Description:	Returns last retrieved data for the specified columns
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_startrow, ll_endrow
int li_cols, li_col, li_sourcecol
string ls_syntax, ls_error
datastore lds_buffer


//Begin Extension

Any	laa_ComputedValues[]
Boolean	lb_DlkValid

lb_DlkValid = IsValid ( inv_Dlk )

//End Extension


lds_buffer = create datastore
if this.CreateSyntax(as_colname, as_datatype, ls_syntax) = 1 then
	if lds_buffer.Create(ls_syntax, ls_error) <> 1 then
		if isValid(inv_dlk) then
			inv_dlk.SetException("ofr_n_bcm_ds::GetRetrievedData", "27991", {ls_error})
		end if
		return -1
	end if
else
	return -1
end if

li_cols = UpperBound(as_colname)
ll_endrow = this.RowCount()
ll_startrow = ll_endrow - il_retrieved + 1
if il_retrieved > 0 then
	//		Prevent GPF
	lds_buffer.insertrow(0)
	for li_col = 1 to li_cols
		li_sourcecol = integer(this.describe(as_colname[li_col] + ".id"))
		if li_sourcecol > 0 then
			lds_buffer.Object.Data[1, li_col, il_retrieved, li_col] = &
					this.Object.Data[ll_startrow, li_sourcecol, ll_endrow, li_sourcecol]

		//Begin Extension

		ELSEIF lb_DlkValid THEN

			IF inv_Dlk.Event pt_ComputeColumn ( as_Colname [ li_Col ], ll_StartRow, ll_EndRow, &
				laa_ComputedValues ) = 1 THEN

				lds_Buffer.Object.Data.Primary [ 1, li_Col, il_Retrieved, li_Col ] = laa_ComputedValues

			END IF

		//End Extension

		end if
	next
	aa_data = lds_buffer.object.data
end if

destroy lds_buffer

return il_retrieved

end function

on n_bcm_ds.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on n_bcm_ds.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event retrieveend;//////////////////////////////////////////////////////////////////////////////
//
//   Event:         retrieveend
//
//   Description:   Occurs when the retrieval has finished.
//
//////////////////////////////////////////////////////////////////////////////
//   
//   Revision History
//
//   Version
//   1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//   Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//   Any distribution of the HOW OpenFrame (OFR)
//   source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
any la_buffer[]
long ll_retrieved
    
    
if ib_append then

	//**BEGIN EXTENSION**
//	This.PurgeDuplicates ( il_StartingRowcount )
//	RowCount = This.RowCount ( )
	//**END EXTENSION

   ll_retrieved = rowcount - il_startingrowcount
else
   ll_retrieved = rowcount
end if

if this.InitBEOIndex(ll_retrieved) < 0 then
   return -1
else
   this.SetOriginalBuffer()
   return 0
end if
    

end event

