$PBExportHeader$u_ratetable.sru
forward
global type u_ratetable from u_base
end type
type gb_rateoptions from groupbox within u_ratetable
end type
type gb_tableselection from groupbox within u_ratetable
end type
type gb_copybreaks from groupbox within u_ratetable
end type
type cb_destination from commandbutton within u_ratetable
end type
type cb_origin from commandbutton within u_ratetable
end type
type cb_newcompany from commandbutton within u_ratetable
end type
type uo_tablenames from u_tablenames within u_ratetable
end type
type dw_table from u_dw_rate within u_ratetable
end type
type uo_rateoptions from u_zonebilltofilter within u_ratetable
end type
type rb_bill from radiobutton within u_ratetable
end type
type rb_pay from radiobutton within u_ratetable
end type
type cb_addcustomer from commandbutton within u_ratetable
end type
type st_category from statictext within u_ratetable
end type
end forward

global type u_ratetable from u_base
integer width = 3561
integer height = 1752
long backcolor = 12632256
event type integer ue_savechanges ( string as_tablename,  string as_message )
gb_rateoptions gb_rateoptions
gb_tableselection gb_tableselection
gb_copybreaks gb_copybreaks
cb_destination cb_destination
cb_origin cb_origin
cb_newcompany cb_newcompany
uo_tablenames uo_tablenames
dw_table dw_table
uo_rateoptions uo_rateoptions
rb_bill rb_bill
rb_pay rb_pay
cb_addcustomer cb_addcustomer
st_category st_category
end type
global u_ratetable u_ratetable

type variables
datawindowchild	idwc_Rates
string		is_originalcodename

Private:
n_ds		ids_zoneless
decimal		ica_break[]
boolean		ib_secondpass
boolean		ib_deletetable	
boolean		ib_codenamechanged




end variables

forward prototypes
public function long of_cache (string asa_codename[], long al_billtoid)
public function long of_filtercache ()
public subroutine of_setvalues (long al_row)
public function long of_changecodename (string as_old, string as_new)
public subroutine of_flushcache (string as_codename)
public function long of_getmodifiedcount ()
public subroutine of_tablechanged ()
public function boolean of_deletetable ()
public subroutine of_setdelete (boolean ab_value)
public function boolean of_codenamechanged (ref string as_original)
private function integer of_rowssync (datastore ads_source, datawindow adw_target)
end prototypes

public function long of_cache (string asa_codename[], long al_billtoid);SetPointer(HourGlass!)

this.setredraw(false)

long			ll_Arraycount, &
				ll_index, &
				ll_CacheCount, &
				ll_include, &
				ll_return=0
				
string		lsa_retrieve[], &
				ls_originalfilter, &
				ls_sql, &
				ls_originalselect

datastore		lds_rate
n_cst_anyarraysrv lnv_anyarray

lds_rate = create datastore
lds_rate.dataobject = "d_rate"
lds_rate.SetTransObject(SQLCA)
ls_originalselect = lds_rate.Describe("DataWindow.Table.Select")

ll_Arraycount = lnv_anyarray.of_GetShrinked(asa_codename, TRUE, TRUE)

ll_CacheCount = dw_table.rowcount()
ll_CacheCount += dw_table.FilteredCount()


if ll_CacheCount > 0 then
	ls_originalfilter = dw_table.object.datawindow.table.filter
	if ls_originalfilter='?' then
		ls_originalfilter=''
	end if
	dw_table.setfilter('')
	dw_table.filter()
end if

ll_CacheCount = dw_table.rowcount()

if ll_return = 0 then
	if ll_CacheCount > 0 then
		// we'll exclude ids already in the cache from the retrieval list.
	
		for ll_index = 1 to ll_ArrayCount
			if len(trim(asa_codename[ll_index])) > 0 then
				if dw_table.find("codename = '" + asa_codename[ll_index] + "'", 1, ll_CacheCount) > 0 then
					continue
				else
					ll_include ++
					lsa_retrieve[ll_include] = asa_codename[ll_index]
				end if
			end if
		next
	
	else
		ll_include = ll_ArrayCount
		lsa_retrieve = asa_codename
	end if

	IF ll_include  > 0 THEN
		IF len ( trim ( lsa_retrieve[1]) ) > 0 THEN
			 ls_sql = "where rate.codename= '" + lsa_retrieve[1] + "'"
		END IF

		lds_rate.object.datawindow.table.select = ls_originalselect + ls_sql
	
		ll_return=lds_rate.Retrieve()
		commit;
	
	END IF
end if


if ll_return > 0 then
	//Some of the rows retrieved may already be in the cache, so we must avoid dupes
//MessageBox("ofcache ret, cache", string(lds_rate.RowCount() )+" "+ string(dw_table.rowCount()))
	//this call is crippling the program for 5 minutes
	//for some reason it does this before there is anything in the cache, and the retrieve gets all 28000 rows, necessary?

	//gf_rows_sync(lds_rate, null_dw , null_ds, dw_table, primary!, true, false)
	//gf_rows_sync(lds_rate, null_dw , null_ds, dw_table, primary!, true, false)
	this.of_rowssync( lds_rate, dw_table )
end if

destroy lds_rate

//turn filter back on
dw_table.setfilter(ls_originalfilter)

dw_table.filter()


this.setredraw(true)

return ll_return

end function

public function long of_filtercache ();SetPointer(HourGlass!)

dw_table.setredraw(false)

string	ls_filter, &
			ls_Origin, &
			ls_destination, &
			ls_CodeName

long		ll_company

//build filter string
ls_Origin = uo_rateoptions.of_GetOrigin ( )
ls_destination = uo_rateoptions.of_GetDestination ( )
ll_Company = uo_rateoptions.Of_GetCustomer ( ) 
ls_codeName = uo_tablenames.of_getcodename ( )	

IF len(trim(ls_CodeName)) > 0 then
	ls_Filter += "codename = '" + ls_codename + "'"
	if isnull(ll_company) then
		//don't add to filter
	else
		ls_Filter += " and billtoid = " + string(ll_company)
	end if
	
	if len(trim(ls_Origin)) > 0 then
		ls_filter += " and originzone = '" + ls_origin + "'"
	else
		ls_filter += " and (len( originzone ) = 0 or isNull( originzone ))"
	end if
	
	if len(trim(ls_destination)) > 0 then
		ls_filter += " and destzone = '" + ls_Destination + "'"
	end if

	if rb_bill.checked then
		ls_filter += " and category = " + string(n_cst_constants.ci_Category_Receivables)
	else
		ls_filter += " and category = " + string(n_cst_constants.ci_Category_Payables)
	end if
	

else
	//no rows will be shown in rates
	ls_filter='1=2'
end if

dw_table.Setfilter(ls_filter)
dw_table.filter()

dw_table.SetSort("destzone A, Ratebreak A")
dw_table.Sort()

dw_table.setredraw(true)

return dw_table.rowcount()

end function

public subroutine of_setvalues (long al_row);
end subroutine

public function long of_changecodename (string as_old, string as_new);long	ll_changed, &
		ll_cachecount, &
		ll_filtercount, &
		ll_index, &
		ll_foundrow
		
string	ls_savefilter		

ll_CacheCount = dw_table.rowcount()

if ll_CacheCount > 0 then
	for ll_index = 1 to ll_CacheCount
		if dw_table.object.codename[ll_index] = as_old then
			dw_table.object.codename[ll_index] = as_new
			ll_changed ++
		end if
	next
end if

ll_filtercount = dw_table.filteredcount()

if ll_filtercount > 0 then
	for ll_index = 1 to ll_filtercount
		if dw_table.object.codename.filter[ll_index] = as_old then
			dw_table.object.codename.filter[ll_index] = as_new
			ll_changed ++
		end if
	next
END IF

ib_codenamechanged = true
is_originalcodename = as_old

return ll_changed
end function

public subroutine of_flushcache (string as_codename);SetPointer(HourGlass!)
dw_table.Setredraw(false)

long	ll_rowcount, &
		ll_row, &
		ll_foundrow

string	ls_originalfilter

if len(trim(as_codename)) > 0 then
	
	if dw_table.rowcount() > 0 then
		ls_originalfilter = dw_table.object.datawindow.table.filter
		if ls_originalfilter='?' then
			ls_originalfilter=''
		end if
		dw_table.setfilter('')
		dw_table.filter()
	end if
	
	ll_rowcount = dw_table.rowcount()	
	ll_foundrow = 1
	
	DO WHILE ll_foundrow > 0
		IF ll_foundrow > ll_rowcount THEN EXIT
		ll_foundrow = dw_table.find("codename = '" + as_codename + "'", ll_foundrow, ll_rowcount)
		if ll_foundrow > 0 then
			dw_table.rowsdiscard(ll_foundrow, ll_foundrow, Primary!)
		end if	
	LOOP
	
	dw_table.setfilter(ls_originalfilter)
	dw_table.filter()
	
end if

dw_table.Setredraw(true)
end subroutine

public function long of_getmodifiedcount ();long	ll_count

ll_count = dw_table.modifiedcount()
ll_count += dw_table.deletedcount()
ll_count += uo_tablenames.of_getcachemodifiedcount()
ll_count += uo_rateoptions.dw_ratedefaults.modifiedcount()
ll_count += uo_rateoptions.dw_ratedefaults.deletedcount()

return ll_count


end function

public subroutine of_tablechanged ();decimal	lca_blank[]

ica_break = lca_blank
//let rate options know for resetting purposes
uo_rateoptions.Event ue_tablechanged()
//redo filter of rates
dw_Table.Event ue_Filter ( )


end subroutine

public function boolean of_deletetable ();return ib_deletetable
end function

public subroutine of_setdelete (boolean ab_value);ib_deletetable = ab_value
end subroutine

public function boolean of_codenamechanged (ref string as_original);if ib_codenamechanged then
	as_original = is_originalcodename
end if
return ib_codenamechanged
end function

private function integer of_rowssync (datastore ads_source, datawindow adw_target);/***************************************************************************************
NAME: 	of_rowssync		

ACCESS:		public	
		
ARGUMENTS: 		
							ads_source-	the datasource that items are being copied from
							adw_target- the dw that is having rows copied to

RETURNS:			1 or -1
	
DESCRIPTION:  This function was written to speed up the process that the following call made
				  from of_cache.
						gf_rows_sync(lds_rate, null_dw , null_ds, dw_table, primary!, true, false)
					
					It uses the two parameters to accomplish the same logic that the call made, but
					it is specialized to the context in which it is called.  In order to get the desired
					functionality out of this function, The same conditions must be met for ads_source
					and adw_target when this call is made from of_cache.  Some of those conditions are
					ads_source was a fresh retrival with no modified data, and no intentions of using 
					ads_source after the rowssync call.  This function reduced the big daddy STD retrieval
					from 10 minutes to about 16 seconds.


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 12-8-2005
	

***************************************************************************************/



String	ls_oldSourceSort
String	ls_oldTargetSort

Int 		li_return

Long		ll_sourceRows
Int		li_colCount
Int		li_colIndex

Long		ll_PrimTarRows
Long		ll_DelTarRows
Long		ll_FilTarRows
Long		ll_testval
Long		ll_value
any		la_colData
Long	ll_startIndex


Long		lla_primIds[]
Long		lla_delIds[]
Long		lla_filIds[]
Long		ll_index
Long		ll_foundIndex
Long		ll_workRow
Long		ll_beforeCopy
Long		ll_afterCopy
dwitemstatus colstat, rowstat

n_cst_anyarraysrv lnv_anyarray

Long	ll_first
Long	ll_last
Long	ll_mid
Long	ll_id
Long	i
int	li_result
Long	ll_fromIndex
Boolean	lb_donotadd

//just incase there was a sort we fix it
If isValid( ads_source) AND isValid( adw_target )THEN
	li_return = 1
ELSE
	li_return = -1
END IF

IF li_return = 1 THEN
	ll_sourceRows = ads_source.RowCount()
	IF ll_sourceRows > 0 THEN
		ll_sourceRows = ads_source.rowCount()
		li_colcount = integer(ads_source.object.datawindow.column.count)
		
		ll_PrimTarRows = adw_target.rowcount()
		ll_FilTarRows = adw_target.filteredcount()
		ll_DelTarRows = adw_target.deletedcount()
		
		ls_oldSourceSort = ads_source.Describe("datawindow.table.sort")
		ls_oldTargetSort = adw_target.Describe("datawindow.table.sort")
	
		ll_testVal = ll_sourceRows + ll_DelTarRows + ll_FilTarRows + ll_PrimTarRows + li_colCount
		
		//early exit before big processing begins
		if isnull(ll_testval) or ll_sourceRows < 0 or ll_DelTarRows < 0 or ll_FilTarRows < 0 or &
		ll_PrimTarRows < 0 or li_colCount < 0 then return -1


	//------------------Real Code-----------------------------------
	
		adw_target.rowsMove( 1, ll_filtArRows, FILTER!, adw_target, 2147483647, PRIMARY! )
		adw_target.setSort( "#1 A" )
		li_result = adw_target.sort( )
		
		ads_source.setSort("#1 A")
		li_result = ads_source.sort()
		//ll_last = adw_target.rowCount()
		ll_first = 1
	//all I have to do is take the rows in the retrieve and put them in the cache if they aren't there already
		//MessageBox("or RowSync","BeforeSource rows "+ string(ll_sourceRows)+ " targetrows: "+string(adw_target.rowCOunt()))
		//for all source rows, look for the id in the target, if its not there, insert it where it should be
		FOR ll_index = 1 TO ll_sourceRows
			ll_value = ads_source.getitemnumber(ll_index, 1, PRIMARY!, false)
			
			ll_last = adw_target.rowCount()
			IF ll_first > 1 THEN
				ll_first --
			END IF	
			//binary search through the target primary and filter buffers for the id
			DO WHILE ll_first <= ll_last
				ll_mid = ((ll_first + ll_last)/2)
		
				ll_id = adw_target.object.data.primary[ll_mid, 1]
				IF ll_id = ll_value THEN
					//ll_mid is the insertion point
					EXIT
				END IF
					
				IF ll_id > ll_value THEN
					ll_last = ll_mid - 1
				ELSE
					ll_first = ll_mid + 1
				END IF
			LOOP
			
			
			//If i didn't find it I want to insert it at ll_first, but only if the row doesn't exist in the delete buffer
			IF ll_First > ll_last THEN
				//checking the delete buffer to see if the row exists there
				FOR i = 1 TO ll_DelTarRows
					ll_id = adw_target.object.data.delete[i, 1]
					IF ll_id = ll_value THEN
						lb_donotadd = true
						EXIT
					END IF
				NEXT
				
				//adding the row at the found spot and setting the statuses to not modified
				IF NOT lb_donotAdd THEN
					ll_fromIndex = ll_index
					
					//the idea here is that we can move all the rows from the source that have id's
					//less then the last ll_id we checked from teh target.
					DO WHILE  ads_source.getitemnumber(ll_index, 1, PRIMARY!, false) < ll_id
						ll_index ++
						IF ll_index > ll_sourceRows THEN
							EXIT
						END IF
					LOOP
					
					ll_beforeCopy = adw_target.rowCount()
					ads_source.rowsCopy( ll_fromIndex, ll_index, PRIMARY!, adw_target, (ll_last + 1), PRIMARY! )
					ll_afterCopy = adw_target.rowCount()
					//must do this to get status to not modified
					ll_fromIndex = ll_last + 1
					ll_startIndex = ll_fromIndex
					//set every row from the first inserted index to the last copied index to not modified
					DO WHILE  ll_fromIndex <= (ll_startIndex + (ll_afterCopy - ll_beforeCopy)-1) //( ll_index - ll_startIndex ))
						adw_target.SetItemStatus( ll_fromIndex, 0, Primary!, DataModified! )
						adw_target.SetItemStatus( ll_fromIndex, 0, Primary!, NotModified! )
						ll_fromIndex ++
					LOOP
				END IF
			END IF
		NEXT
	//MessageBox("or RowSync","after")

	//--------------------------------------------------------------
		//restore the old sort incase it is messed up.
		IF ls_oldTargetSort <> "?" AND ls_oldTargetSort <> "!" THEN
			adw_Target.setSort(ls_OldTargetSort)
			adw_Target.sort()
		END IF
		
		IF ls_oldSourceSort <> "?" AND ls_oldSourceSort <> "!" THEN
			ads_Source.setSort(ls_oldSourceSort)
			ads_Source.sort()
		END IF
	
		
	END IF // end source rows > 0

END IF
return li_return

end function

on u_ratetable.create
int iCurrent
call super::create
this.gb_rateoptions=create gb_rateoptions
this.gb_tableselection=create gb_tableselection
this.gb_copybreaks=create gb_copybreaks
this.cb_destination=create cb_destination
this.cb_origin=create cb_origin
this.cb_newcompany=create cb_newcompany
this.uo_tablenames=create uo_tablenames
this.dw_table=create dw_table
this.uo_rateoptions=create uo_rateoptions
this.rb_bill=create rb_bill
this.rb_pay=create rb_pay
this.cb_addcustomer=create cb_addcustomer
this.st_category=create st_category
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_rateoptions
this.Control[iCurrent+2]=this.gb_tableselection
this.Control[iCurrent+3]=this.gb_copybreaks
this.Control[iCurrent+4]=this.cb_destination
this.Control[iCurrent+5]=this.cb_origin
this.Control[iCurrent+6]=this.cb_newcompany
this.Control[iCurrent+7]=this.uo_tablenames
this.Control[iCurrent+8]=this.dw_table
this.Control[iCurrent+9]=this.uo_rateoptions
this.Control[iCurrent+10]=this.rb_bill
this.Control[iCurrent+11]=this.rb_pay
this.Control[iCurrent+12]=this.cb_addcustomer
this.Control[iCurrent+13]=this.st_category
end on

on u_ratetable.destroy
call super::destroy
destroy(this.gb_rateoptions)
destroy(this.gb_tableselection)
destroy(this.gb_copybreaks)
destroy(this.cb_destination)
destroy(this.cb_origin)
destroy(this.cb_newcompany)
destroy(this.uo_tablenames)
destroy(this.dw_table)
destroy(this.uo_rateoptions)
destroy(this.rb_bill)
destroy(this.rb_pay)
destroy(this.cb_addcustomer)
destroy(this.st_category)
end on

event constructor;call super::constructor;This.of_SetResize ( TRUE )

//inv_Resize.of_SetMinSize ( 3561, 1824)
inv_Resize.of_SetMinSize ( 3561, 1752)
//Register Resizable controls
inv_Resize.of_Register ( uo_tablenames, 'ScaleToRight' )
inv_Resize.of_Register ( dw_table, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( cb_addcustomer, 'FixedToRight' )
inv_Resize.of_Register ( cb_destination, 'FixedToRight' )
inv_Resize.of_Register ( cb_newcompany, 'FixedToRight' )
inv_Resize.of_Register ( cb_origin, 'FixedToRight' )
inv_Resize.of_Register ( gb_copybreaks, 'FixedToRight' )
inv_Resize.of_Register ( gb_rateoptions, 'FixedToRight' )
inv_Resize.of_Register ( uo_rateoptions, 'FixedToRight' )
inv_Resize.of_Register ( st_category, 'FixedToRight' )
inv_Resize.of_Register ( rb_bill, 'FixedToRight' )
inv_Resize.of_Register ( rb_pay, 'FixedToRight' )

inv_Resize.of_Register ( gb_tableselection, 'ScaleToRight' )

n_cst_licensemanager	lnv_licensemanager
if lnv_LicenseManager.of_HasAutoRatingLicensed() then
	rb_bill.checked=true
	rb_pay.checked=false
else
	rb_bill.checked=false
	rb_pay.checked=true
end if

uo_tablenames.SetFocus ( )


end event

event destructor;call super::destructor;//if isvalid(ids_ratecache) then
//	destroy ids_ratecache
//end if

end event

type gb_rateoptions from groupbox within u_ratetable
integer x = 2405
integer y = 428
integer width = 1134
integer height = 1068
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Rate Options"
end type

type gb_tableselection from groupbox within u_ratetable
integer width = 3538
integer height = 408
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Table Selection"
end type

type gb_copybreaks from groupbox within u_ratetable
integer x = 2405
integer y = 1524
integer width = 1134
integer height = 196
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Copy breaks for another :"
end type

type cb_destination from commandbutton within u_ratetable
integer x = 2450
integer y = 1604
integer width = 370
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "De&stination"
end type

event clicked;Long			ll_RowCount
Long			ll_Null
Long			ll_return = 1
Long			i,j
Dec			lc_CurrentBreak
String		ls_Zone
String		ls_OldZone
Boolean		lb_Continue = TRUE
S_Parm		lstr_Parm
n_cst_Msg	lnv_Msg
DataStore	lds_Temp

lds_Temp = CREATE DataStore
lds_Temp.DataObject = "d_Rate"

SetNull 		( ll_Null )

dw_table.SetRedraw ( FALSE )

ls_OldZone = uo_rateoptions.of_GEtDestination ( )

if ll_return = 1 then
	if isnull(ls_oldzone) or len(trim(ls_oldzone)) = 0 then
		messagebox('Copy Destination', 'Please select a destination in the Rate Options.')
		uo_rateoptions.post setfocus()
		uo_rateoptions.post of_setfocus('DESTINATION')
		ll_return = -1
	end if
end if

if ll_return = 1 then
	lstr_Parm.is_Label = "NAME"
	lstr_Parm.ia_Value = ls_OldZone
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	OpenWithParm ( w_ZoneSelect, lnv_Msg ) 
	
	IF isValid ( Message.PowerObjectParm ) THEN
		lnv_Msg = Message.PowerObjectParm
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "ZONE" , lstr_Parm ) <> 0 THEN
		ls_Zone = lstr_Parm.ia_Value
	END IF
	
	IF Len ( ls_Zone ) > 0 AND ls_Zone <> ls_OldZone THEN
		ll_RowCount = dw_table.RowCount ( )
	
		dw_table.RowsCopy ( 1 , ll_RowCount , PRIMARY! , lds_Temp, 99999 , PRIMARY! )
		
		FOR i =  1 TO lds_Temp.RowCount ( )
			lds_Temp.SetItem ( i , "destzone" , ls_Zone ) 
			lds_Temp.SetItem ( i , "rate" , ll_Null ) 
			lds_Temp.SetItem ( i , "id" , ll_Null ) 
		NEXT
		
		uo_rateoptions.of_SetDestination ( ls_Zone )
		dw_Table.Event ue_Filter ( )
		
		dw_Table.Event ue_ClearBlankRows ( )
		
		IF dw_Table.RowCount ( ) > 0 THEN
			CHOOSE CASE MessageBox ( "Add Destination" , "The destination you have selected " +&
										"already has breaks associated. Do you still want to replace those breaks?" , QUESTION! , YESNO! , 2 )
				CASE 1 // replace
					
					FOR j =  dw_Table.RowCount ( ) TO 1 STEP -1
						dw_Table.DeleteRow ( j ) 
					NEXT
			
				CASE 2 // bail
					lb_Continue = FALSE
					uo_rateoptions.of_SetDestination ( ls_OldZone )
					dw_Table.Event ue_Filter ( )
			END CHOOSE
		else
			ll_return = -1 
		END IF
		
		IF lb_Continue THEN
			FOR i = 1 TO lds_Temp.RowCount ( ) 
				lds_Temp.RowsCopy ( i , i , PRIMARY! , dw_Table, 99999 , PRIMARY! )
			NEXT
		END IF
		
		dw_table.setrow(1)
		dw_table.setcolumn('rate')
		dw_table.SetFocus ( ) 
	
		//dw_table.Event ue_Filter ( dw_Header.of_GetFilter ( )  )
	END IF
end if

dw_table.Post SetRedraw (TRUE)
		
DESTROY ( lds_Temp )
end event

type cb_origin from commandbutton within u_ratetable
integer x = 2848
integer y = 1604
integer width = 311
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ori&gin"
end type

event clicked;Long			ll_RowCount
Long			ll_Null
Long			ll_return = 1
Long			i,j
String		ls_Zone
String		ls_OldZone
Boolean		lb_Continue = TRUE
S_Parm		lstr_Parm
n_cst_msg	lnv_Msg
SetNull ( ll_Null )
DataStore	lds_Temp
lds_Temp = CREATE DataStore
lds_Temp.DataObject = "d_Rate"

dw_table.SetRedraw ( FALSE )

ls_OldZone = uo_rateoptions.of_GEtOrigin ( )

if ll_return = 1 then
	if isnull(ls_oldzone) or len(trim(ls_oldzone)) = 0 then
		messagebox('Copy Destination', 'Please select an origin in the Rate Options.')
		uo_rateoptions.post setfocus()
		uo_rateoptions.post of_setfocus('ORIGIN')
		ll_return = -1
	end if
end if

if ll_return = 1 then
	lstr_Parm.is_Label = "NAME"
	lstr_Parm.ia_Value = ls_OldZone
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	OpenWithParm ( w_ZoneSelect , lnv_msg )
	
	IF isValid ( Message.PowerObjectParm ) THEN
		lnv_Msg = Message.PowerObjectParm
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "ZONE" , lstr_Parm ) <> 0 THEN
		ls_Zone = lstr_Parm.ia_Value
	END IF
	
	IF Len ( ls_Zone ) > 0  AND ls_Zone <> ls_OldZone THEN
		ll_RowCount = dw_table.RowCount ( )
	
		dw_table.RowsCopy ( 1 , ll_RowCount , PRIMARY! , lds_Temp, 99999 , PRIMARY! )
		
		FOR i =  1 TO lds_Temp.RowCount ( )
			lds_Temp.SetItem ( i , "originzone" , ls_Zone ) 
			lds_Temp.SetItem ( i , "rate" , ll_Null ) 
			lds_Temp.SetItem ( i , "id" , ll_Null ) 
		NEXT
		
		uo_rateoptions.of_SetOrigin ( ls_Zone )
		dw_Table.Event ue_Filter ( )
	
		dw_Table.Event ue_ClearBlankRows ( )
			
		IF dw_Table.RowCount ( ) > 0 THEN
			CHOOSE CASE MessageBox ( "Add Origin" , "The origin you have selected " +&
										"already has breaks associated. Do you still want to replace those breaks?" , QUESTION! , YESNO! , 2 )
				CASE 1 // replace
					
					FOR j =  dw_Table.RowCount ( ) TO 1 STEP -1
						dw_Table.DeleteRow ( j ) 
					NEXT
			
				CASE 2 // bail
					lb_Continue = FALSE
					uo_rateoptions.of_SetOrigin( ls_OldZone )
					dw_Table.Event ue_Filter ( )
			END CHOOSE
		else
			ll_return = -1 
		END IF
		
		IF lb_Continue THEN
			FOR i = 1 TO lds_Temp.RowCount ( ) 
				lds_Temp.RowsCopy ( i , i , PRIMARY! , dw_Table, 99999 , PRIMARY! )
			NEXT
			
			dw_table.setrow(1)
			dw_table.setcolumn('rate')
			dw_table.SetFocus ( ) 
			
		END IF
		
	END IF
end if

dw_table.Post SetRedraw (TRUE)

DESTROY ( lds_Temp )
end event

type cb_newcompany from commandbutton within u_ratetable
integer x = 3186
integer y = 1604
integer width = 325
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Compa&ny"
end type

event clicked;Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Long		ll_ValidateId = 0
Boolean	lb_Search = false
Boolean  lb_Employee 
Boolean	lb_Company
Boolean	lb_validate
String	ls_Search = ""
String	ls_type
Long		ll_EntityId
String	ls_MessageHeader
integer	li_Return
Long		ll_RowCount
Long		i,j
Long		ll_Null
Dec		lc_CurrentBreak
Long		ll_OldCustomer
String	ls_OldCustomerName
Boolean	lb_Continue = TRUE

dw_table.SetRedraw ( FALSE )

SetNull 	( ll_Null )
S_co_info	lstr_Company
DataStore	lds_Temp
lds_Temp = CREATE DataStore
lds_Temp.DataObject = "d_Rate"

li_Return = gnv_cst_Companies.of_Select &
	( lstr_company, ls_Type, lb_Search, ls_Search, lb_Validate, &
	  ll_ValidateId, lb_AllowHold, lb_Notify )
ll_OldCustomer =  uo_rateoptions.of_GetCustomer ( )
ls_OldCustomerName = uo_rateoptions.of_GetCustomerText ( )
IF lstr_Company.co_id > 0 AND  lstr_Company.co_id  <> ll_OldCustomer  THEN

	ll_RowCount = dw_table.RowCount ( )

	dw_table.RowsCopy ( 1 , ll_RowCount , PRIMARY! , lds_Temp, 99999 , PRIMARY! )
	
	FOR i =  1 TO lds_Temp.RowCount ( )
		lds_Temp.SetItem ( i , "billtoid" , lstr_Company.co_id ) 
		lds_Temp.SetItem ( i , "rate" , ll_Null ) 
		lds_Temp.SetItem ( i , "id" , ll_Null ) 
	NEXT
	
	uo_rateoptions.of_SetCustomer ( lstr_Company.Co_id)
	uo_rateoptions.of_SetCustomerText ( lstr_Company.Co_name )
	dw_Table.Event ue_Filter ( )
	dw_Table.Event ue_ClearBlankRows ( )

	IF dw_Table.RowCount ( ) > 0 THEN
		CHOOSE CASE MessageBox ( "Add Customer" , "The Customer you have selected " +&
										"already has breaks associated. Do you still want to replace those breaks?" , QUESTION! , YESNO! , 2 )
			CASE 1 // replace
				
				FOR j =  dw_Table.RowCount ( ) TO 1 STEP -1
					dw_Table.DeleteRow ( j ) 
				NEXT
		
			CASE 2 // bail
				lb_Continue = FALSE
				uo_rateoptions.of_SetCustomer( ll_OldCustomer )
				uo_rateoptions.of_SetCustomerText ( ls_OldCustomerName )
				dw_Table.Event ue_Filter ( )
		END CHOOSE
	END IF
	
	IF lb_Continue THEN
		FOR i = 1 TO lds_Temp.RowCount ( ) 
			lds_Temp.RowsCopy ( i , i , PRIMARY! , dw_Table, 99999 , PRIMARY! )
		NEXT
	END IF
	
END  IF

dw_table.Post SetRedraw (TRUE)
	
DESTROY ( lds_Temp )
return li_Return


end event

type uo_tablenames from u_tablenames within u_ratetable
integer x = 14
integer y = 72
integer taborder = 10
boolean bringtotop = true
end type

on uo_tablenames.destroy
call u_tablenames::destroy
end on

event ue_itemchanged;//update cache and the filter
String	ls_breakunit

parent.setredraw(false)
dw_table.setRedraw(false)

string	lsa_codename[]

lsa_codename[1] = this.of_getcodename()
parent.of_cache(lsa_codename,0) //base rates for selected table
//MessageBox("ue_itemchanged uratetable", "after of_cache" + as_what)
CHOOSE CASE as_what
		
	CASE	"BREAKUNIT"
		ls_breakUnit = parent.uo_tableNames.of_getbreakunit( )
		CHOOSE CASE ls_breakUnit
			CASE "F"
				dw_table.object.ratebreak.protect = 0
			CASE ELSE
				dw_table.object.ratebreak.protect = 1
		END CHOOSE
		
END CHOOSE

parent.of_tablechanged()

dw_table.setRedraw(true)
parent.setredraw(true)

end event

event ue_codenamechanged;parent.of_changecodename(as_old, as_new )
end event

event ue_savechanges;parent.of_setdelete(ab_delete)
return parent.event ue_savechanges(as_table, as_message)
end event

type dw_table from u_dw_rate within u_ratetable
event ue_filter ( )
event ue_clearblankrows ( )
event type integer ue_allowchangefocus ( )
integer x = 18
integer y = 464
integer width = 2322
integer height = 1276
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event ue_filter();this.SetRedraw(FALSE)

long	ll_row, &
		ll_Company
string	ls_origin

//initialize column widths
This.Object.DestZone.Width = 0
This.Object.ratebreak.Width = 0
This.Object.rate.Width = 480
This.Object.rateunit.Width = 443
//MessageBox("dw_table from u_ratetable, ue_filter", "a")


choose case uo_tablenames.of_Getbreakunit ( )
	case appeon_constant.cs_RateUnit_Code_Flat, appeon_constant.cs_RateUnit_Code_Minimum, &
		  appeon_constant.cs_RateUnit_Code_Maximum, appeon_constant.cs_RateUnit_Code_None
		//only allow one row and only enter rate
	case else
		This.Object.ratebreak.Width = 361
		this.object.ratebreak.protect = 0 
end choose

if len(trim(uo_rateoptions.of_getorigin())) > 0 THEN
	THIS.Object.DestZone.Width = 901
end if

if len(trim(uo_rateoptions.of_getdestination())) > 0 THEN
	THIS.Object.DestZone.protect = 1
else
	THIS.Object.DestZone.protect = 0
end if

ll_row = parent.of_filtercache()

//last row should be a new row, need blank row at end

this.event ue_clearblankrows()

if len(trim(uo_rateoptions.of_getdestination())) > 0 THEN
	//don't add a blank row
else
	choose case this.rowcount()
		case 1  
			IF IsNull (THIS.GetItemNumber (1 , "ratebreak") ) and &
				IsNull (THIS.GetItemNumber (1 , "rate") ) THEN
				 //don't add row
				
			else
			
				this.event pfc_addrow()
		
			END IF	
	
		case 0 
			
			this.event pfc_addrow()
	
		case is > 1 
			IF IsNull (THIS.GetItemNumber (this.rowcount() , "ratebreak") ) and &
				IsNull (THIS.GetItemNumber (this.rowcount() , "rate") ) THEN
				 //don't add row
				
			else
				
				this.event pfc_addrow()
		
			END IF	
			
	end choose
	
end if

if rb_bill.checked then
	THIS.Object.ratelinkdestzone_zone_t.color=rgb(0, 128, 0)
	THIS.Object.rate_ratebreak_t.color=rgb(0, 128, 0)
	THIS.Object.rate_rate_t.color=rgb(0, 128, 0)
	THIS.Object.rate_rateunit_t.color=rgb(0, 128, 0)
else
	THIS.Object.ratelinkdestzone_zone_t.color=rgb(255,0, 0)
	THIS.Object.rate_ratebreak_t.color=rgb(255,0, 0)
	THIS.Object.rate_rate_t.color=rgb(255,0, 0)
	THIS.Object.rate_rateunit_t.color=rgb(255,0, 0)
end if

THIS.of_Filterexistingzones( )


this.SetRedraw(TRUE)
//MessageBox("dw_table from u_ratetable, ue_filter", "b")
end event

event ue_clearblankrows();this.setredraw(false)

Long	ll_RowCount
Long	i

ll_RowCount = THIS.RowCount ( )
FOR i = ll_RowCount TO 1 STEP -1
	IF IsNull (  THIS.GetItemNumber ( i , "ratebreak", Primary!, true  )  ) THEN
		THIS.RowsDiscard ( i, i, Primary! ) 
	END IF	
NEXT
	
ll_RowCount = THIS.FilteredCount ( )
FOR i = ll_RowCount TO 1 STEP -1
	IF IsNull (  THIS.GetItemNumber ( i , "ratebreak", Filter!, true  )  ) THEN
		THIS.RowsDiscard ( i, i, Filter! ) 
	END IF	
NEXT
	
this.setredraw(true)
end event

event ue_allowchangefocus;Long	ll_Return = 1
THIS.Event ue_ClearBlankRows ( )
ll_Return = THIS.AcceptText ( )
RETURN ll_Return
	
end event

event constructor;call super::constructor;string	lsa_keycols[], &
			lsa_updatecols[], &
			lsa_blank[]
			
datawindowchild	ldwc_zone

of_SetTransObject(sqlca) 

// Start the Multi-Table Update Service.
of_SetMultiTable(true)

// Register the "ratelinkbillable" table and its key columns.
lsa_updatecols = lsa_blank
lsa_keycols = lsa_blank

lsa_keycols[1] = "ratelinkbillable_rateid"
lsa_keycols[2] = "billtoid"
lsa_updatecols[1] = "ratelinkbillable_rateid"
lsa_updatecols[2] = "billtoid"
inv_multitable.of_AddToUpdate("ratelinkbillable", lsa_keycols, lsa_updatecols) 


// Register the "ratelinkorigzone" table and its key columns.
lsa_updatecols = lsa_blank
lsa_keycols = lsa_blank

lsa_keycols[1] = "ratelinkorigzone_rateid"
lsa_keycols[2] = "originzone"
lsa_updatecols[1] = "ratelinkorigzone_rateid"
lsa_updatecols[2] = "originzone"
inv_multitable.of_AddToUpdate("ratelinkorigzone", lsa_keycols, lsa_updatecols) 

// Register the "ratelinkdestzone" table and its key columns.
lsa_updatecols = lsa_blank
lsa_keycols = lsa_blank

lsa_keycols[1] = "ratelinkdestzone_rateid"
lsa_keycols[2] = "destzone"
lsa_updatecols[1] = "ratelinkdestzone_rateid"
lsa_updatecols[2] = "destzone"
inv_multitable.of_AddToUpdate("ratelinkdestzone", lsa_keycols, lsa_updatecols) 

// Register the "rate" table and its key columns.
lsa_updatecols = lsa_blank
lsa_keycols = lsa_blank

lsa_keycols[1] = "id"
lsa_updatecols[1] = "id"
lsa_updatecols[2] = "codename"
lsa_updatecols[3] = "ratebreak"
lsa_updatecols[4] = "rate"
lsa_updatecols[5] = "rateunit"
lsa_updatecols[6] = "lastuseddate"
lsa_updatecols[7] = "category"
inv_multitable.of_AddToUpdate("rate", lsa_keycols, lsa_updatecols) 

this.Getchild("destzone",ldwc_zone)
ldwc_zone.settransobject(SQLCA)
ldwc_zone.retrieve()
//added by dan
this.of_SetDropDownSearch( TRUE )
inv_dropdownsearch.of_Register()
inv_dropdownsearch.of_AddColumn ("destzone") 
//-----------
commit;

end event

event editchanged;if dwo.name = 'rate' then
	decimal	lc_rate
	long ll_rowcount

	if len(trim(uo_rateoptions.of_getdestination())) > 0 THEN
		//don't add row
	else
		ll_rowcount = this.rowcount()
		if ll_rowcount = row then
			//set next break if pattern has been saved		
			if row > 1 and upperbound(ica_break) > 0 then
				if this.object.ratebreak[row] = ica_break[1] then
					//let's set up the next destzone and breaks
					long		ll_index, &
								ll_arraycount, &
								ll_zonecount, &
								ll_foundrow
					string 	ls_destzone, &
								ls_findstring
					datawindowchild	ldwc_zones
	
					if this.GetChild('destzone', ldwc_zones) = 1 then	
						ll_ZoneCount = ldwc_zones.RowCount()
						//get previous zone name
						ls_destzone = this.object.destzone[row]
						ls_findstring = "name = '" + ls_destzone + "'"
						ll_foundrow = ldwc_zones.find(ls_findstring, 1, ll_zonecount)
						if ll_foundrow > 0 and ll_ZoneCount > 0 then
							ls_destzone = ldwc_zones.GetItemString(ll_foundrow + 1, 'name')
							ll_arraycount = upperbound(ica_break)
							if ll_arraycount > 0 then
								//load the array backwards
								for ll_index = ll_arraycount to 1 step -1
									this.event pfc_addrow()
									this.object.destzone[this.rowcount()] = ls_destzone
									this.object.ratebreak[this.rowcount()] = ica_break[ll_index]	
								next
							end if
						end if
					end if
				end if
			else
				this.Event PFC_AddRow()
			end if
			
	//		this.Event PFC_AddRow()
	
		else
			lc_rate = this.object.rate[ll_rowcount]
			if isnull(lc_rate) or lc_rate = 0 then 
				//no row
			else
				this.Event PFC_AddRow()
			end if
		end if
	end if
	
end if

end event

event itemchanged;call super::itemchanged;long	ll_rowcount, &
		ll_foundrow, &
		ll_arraycount, &
		ll_index, &		
		ll_return = 0
		
decimal lca_break[]

string	ls_destzone, &
			ls_findstring

Dec lc_Rate 
String	ls_RateUnit
Long	ll_startRow

STRING	lsa_units[]
Long		ll_childRowCount
Long		ll_childIndex
String	ls_breakUnit
DataWindowChild	ldwc_child
DataWindowChild	ldwc_newChild

Long		ll_i
String	ls_lastDestination
String	ls_nextDestination


this.setredraw(false)

choose case dwo.name
	case "destzone"
		//if last row then search prior rows for 
		//all breaks of previous zone and replicate
		choose case uo_tablenames.of_Getbreakunit ( )
			case appeon_constant.cs_RateUnit_Code_Flat, appeon_constant.cs_RateUnit_Code_Minimum, &
				  appeon_constant.cs_RateUnit_Code_Maximum, appeon_constant.cs_RateUnit_Code_None
				//next destination
			case else
				choose case row
					case this.rowcount()
						if row > 1 then
							//get the previous destzone and find all breaks for that zone
							//search backwards
							ls_destzone = this.object.destzone[row - 1]
							if ls_destzone <> data then
								ll_rowcount = this.rowcount() - 1
								for ll_index = ll_rowcount to 1 step -1
									if this.object.destzone[ll_index] = ls_destzone then
										lca_break[upperbound(lca_break) + 1] = this.object.ratebreak[ll_index] 
										//added by dan to copy units as well
										lsa_units[upperBound(lca_break)] = this.object.rateUnit[ll_index]
										//--------------
									else
										exit		
									end if
								next
								ll_arraycount = upperbound(lca_break)
								if ll_arraycount > 0 then
									ica_break = lca_break
									ls_breakUnit = this.event ue_getbreakunit( )
									//load the array of breaks backwards (no rates)
									//the first row is already there, add the rest in the loop
									this.object.ratebreak[row] = lca_break[ll_arraycount]
									for ll_index = ll_arraycount -1 to 1 step -1
										this.event pfc_addrow()
										this.object.ratebreak[this.rowcount()] = lca_break[ll_index]
										//added by dan
										this.object.rateunit[this.rowCount()] = lsa_units[ll_index]
										//------------
									next
									this.setcolumn('rate')
								end if
							end if
						end if
					case else
						//if multiple rows of same destzone then change those as well
						ll_rowcount = this.rowcount()
						if ll_rowcount > 0 then
							IF isValid( this.Object.destzone.Primary.Original ) THEN	//condition added by Dan
								ls_findstring = "destzone = '" + this.Object.destzone.Primary.Original[row] + "'"
								for ll_index = 1 to ll_rowcount
									ll_foundrow = this.find(ls_findstring,ll_index,ll_index)
									if ll_foundrow > 0 then
										this.object.destzone[ll_foundrow] = data
									end if
								next
							END IF	
						end if
				end choose
		end choose
		//added by dan to prevent empty row
		IF len( data ) > 0 THEN
		ELSE
			beep(1)
			ll_return = 1
		END IF
		//--------------------
	case "ratebreak"
		
		ls_Destzone = this.Object.destzone [row]
		
		ls_findstring = "destzone = '" + ls_Destzone + "' and ratebreak = " + data 
		
		ll_foundrow = THIS.FInd ( ls_findstring , 1 , this.rowcount() )
		if ll_foundrow > 0 then
			if ll_foundrow = row then
				ll_foundrow = THIS.FInd ( ls_findstring , ll_foundrow + 1 , this.rowcount() )
				if ll_foundrow > 0 then
					ll_Return = 1
					MessageBox ( "Rate" , "The rate break you have entered already exists." )
				end if
			else
				ll_Return = 1
				MessageBox ( "Rate" , "The rate break you have entered already exists." )
			end if
		END IF
		
	case "rate"
		choose case uo_tablenames.of_Getbreakunit ( )
		
			case appeon_constant.cs_RateUnit_Code_Flat, appeon_constant.cs_RateUnit_Code_Minimum, &
				  appeon_constant.cs_RateUnit_Code_Maximum, appeon_constant.cs_RateUnit_Code_None
				THIS.Object.ratebreak[ row ] = 0
			case else
				
		end choose
		
		//Depending on the break unit being used, we can try to predict what
		//it is that the user is trying to enter for data.  All we do is insert
		//a row and set the predicted focus
		//---------Added by Dan
		ls_breakUnit = parent.uo_tableNames.of_getbreakunit( )
		if row = this.rowcount() THEN 
			this.event pfc_addrow( )
			
			//IF the break unit is flat then they are most likely entering
			//rates. 
			IF ls_breakUnit = "F" then
				//MessageBox("itemchanged", "code to add row should go here")
				
				
				this.getChild( "destzone", ldwc_child )
				IF isValid( ldwc_child ) THEN
					ll_childRowCount = ldwc_child.rowCount()
					//MessageBox("item changed uratetable",ldwc_Child.getItemString(ldwc_child.getRow(),1))
					ll_childIndex = ldwc_child.getRow() 
					
					//Modified by Dan 1-18-2006 logic to get the next destination instead of the first available destination.
					IF (this.getRow() ) > 0 THEN
						ls_lastDestination = this.object.destzone[this.getRow()]
					
						FOR ll_i = 1 TO ll_childRowCount
							ls_nextDestination = ldwc_Child.getItemString(ll_i,1)
							IF ls_nextDestination > ls_lastDestination THEN
								exit
							END IF
								
						NEXT
					ELSE
						IF ll_childIndex > 0 AND ll_childIndex <= ll_childRowCount THEN
							ls_nextDestination = ldwc_Child.getItemString(ll_childIndex,1)
						END IF
					END IF
					//IF ll_childIndex > 0 AND ll_childIndex <= ll_childRowCount THEN
						//this.event pfc_addrow( )
						this.object.destzone[row + 1] = ls_nextDestination //ldwc_Child.getItemString(ll_childIndex,1)
						this.post setRow( row + 1)
						this.post setColumn("rate")
					//END IF
				END IF
				//otherwise they are probably going to be entering a break unit
			ELSE
				this.post setRow( row + 1)
				this.post setColumn("ratebreak")
			END IF
		//----------------------
			
			//don't check for duplicate. We got here because of edit change
		else
			// check to see if the rate already exists.
			
			ls_Destzone = this.Object.destzone [row]
			lc_Rate = dec(data)
			ls_RateUnit = this.Object.rateunit [row]
			
			ls_findstring = "destzone = '" + ls_Destzone + "' and rate = " + string(lc_Rate) + " and rateunit = '" + ls_RateUnit +"'"
			
			ll_foundrow = THIS.FInd ( ls_findstring , 1 , this.rowcount() )
			if ll_foundrow > 0 then
				if ll_foundrow = row then
					ll_foundrow = THIS.FInd ( ls_findstring , ll_foundrow + 1 , this.rowcount() )
					if ll_foundrow > 0 then
						ll_Return = 1
						MessageBox ( "Rate" , "The rate you have entered already exists." )
					end if
				else
					ll_Return = 1
					MessageBox ( "Rate" , "The rate you have entered already exists." )
				end if
			END IF
		end if		
		
	case "rateunit"				
		//change all rows after this to same rate unit
		ll_rowcount = this.rowcount()
		//changed by Dan to ask before changing all subsequent rows
		IF ll_rowCount > (row ) THEN
			//
			IF MessageBox("Rate", "Do you want to change ALL subsequent units as well?", QUESTION!, yesno!) = 1 THEN
				for ll_index = row + 1 to ll_rowcount
					this.object.rateunit[ll_index] = data
				next
			END IF
		END IF
		//----------------------------------------------------------

end choose

if ll_return = 1 then
	this.post selecttext(1, Len(this.GetText()))
end if


this.setredraw(true)

return ll_return


end event

event pfc_addrow;this.setredraw(false)

long	ll_row, &
		ll_ZoneCount, &
		ll_return, &
		ll_foundrow, &
		ll_company
		
string	ls_findstring, &
			ls_destzone, &
			ls_breakunits, &
			ls_origin, &
			ls_codename
			
String	ls_breakunit
Long		ll_childRowCount
Long		ll_childIndex
Long		ll_index
Long		ll_max

Boolean	lb_found
DatawindowChild	ldwc_child

datawindowchild	ldwc_zones
choose case uo_tablenames.of_Getbreakunit ( )

	case appeon_constant.cs_RateUnit_Code_Flat, appeon_constant.cs_RateUnit_Code_Minimum, &
		  appeon_constant.cs_RateUnit_Code_Maximum, appeon_constant.cs_RateUnit_Code_None
		//only allow one row and only enter rate
		
		if this.rowcount() = 0 or len(trim(uo_rateoptions.of_GetOrigin())) > 0 then
			ll_return = Super::Event pfc_addrow()
		else
			ll_return = 0
		end if
		
	case else
		
//		if len(trim(uo_rateoptions.Of_GetOrigin())) > 0 then
			ll_return = Super::Event pfc_addrow()
		
//		end if
end choose

ll_row = ll_return

if ll_row > 0  then
	
	if len(trim(uo_rateoptions.Of_GetOrigin())) > 0 then
		/*	
			Set value for destination. Look at previous row and this one s/b next one alphabetically		
		*/
		if this.GetChild('destzone', ldwc_zones) = 1 then	
			ll_ZoneCount = ldwc_zones.RowCount()
			ls_breakunits = uo_tablenames.of_getbreakunit()
			if ll_Row = 1 then
				ll_foundRow = 1 
				
			else
				//added by dan to not copy the name if break unit is flat
				ls_breakUnit = this.event ue_getbreakunit( )
				IF ls_breakUnit <> "F" THEN
					//get previous zone name
					ls_destzone = this.object.destzone[ll_row - 1]
				ELSE
					this.getChild( "destzone", ldwc_child )
					IF isValid( ldwc_child ) THEN
						ll_childRowCount = ldwc_child.rowCount()
						ll_childIndex = ldwc_child.getRow() + 1
						
						ll_max = this.rowcount( )
						IF ll_childIndex > 0 AND ll_childIndex <= ll_childRowCount THEN
							//this.event pfc_addrow( )
							//ls_destZone =  ldwc_Child.getItemString(ll_childIndex,1)
							
							//looks for a dest name that doesn't exist because  we don't
							//want duplicate destination names in the flat rate tables.
							For ll_childIndex = 1 TO ll_childRowCount
								ls_destZone =  ldwc_Child.getItemString(ll_childIndex,1)
								FOR ll_index = 1 TO ll_max
									IF ls_destZone = this.getItemString(ll_index,"destzone") THEN
										lb_found = true
										EXIT
									END IF
								NEXT
								
								IF NOT lb_found THEN
									EXIT
								ELSE
									lb_found = false
								END IF
							NEXT
							
						END IF
					END IF
				END IF
				//--------------------------------------------------
				ls_findstring = "name = '" + ls_destzone + "'"
				ll_foundrow = ldwc_zones.find(ls_findstring, 1, ll_zonecount)
				choose case ls_breakunits
						
					case appeon_constant.cs_RateUnit_Code_Flat, appeon_constant.cs_RateUnit_Code_Minimum, &
						  appeon_constant.cs_RateUnit_Code_Maximum, appeon_constant.cs_RateUnit_Code_None
	
						if ll_foundrow > 0 then
							ll_foundrow +=1
						end if
						
					case else		
						//same value as previous
	
				end choose		
				
			end if
			
			choose case ll_foundrow
				case 1
					
					ls_destzone = uo_rateoptions.of_GetDestination ( )
					if len(trim(ls_destzone)) > 0 then
						//ok
					else
						if ll_ZoneCount > 0 and ll_foundrow <= ll_zonecount then
							ls_destzone = ldwc_zones.GetItemString(ll_foundrow, 'name')
						end if
					end if
				case is > 1
					
					if ll_foundrow > 0 then
						if ll_ZoneCount > 0 and ll_foundrow <= ll_zonecount then
							ls_destzone = ldwc_zones.GetItemString(ll_foundrow, 'name')
							this.object.destzone[ll_row] = ls_destzone
						end if
					end if					
			end choose
//			if ll_foundrow > 0 then
//				if ll_ZoneCount > 0 and ll_foundrow <= ll_zonecount then
//					ls_destzone = ldwc_zones.GetItemString(ll_foundrow, 'name')
//					this.object.destzone[ll_row] = ls_destzone
//				end if
//			end if
		end if


		ls_Origin = uo_rateoptions.of_GetOrigin ( )
		this.object.originzone[ll_row] = ls_origin
		this.object.destzone[ll_row] = ls_destzone
		if len(trim(ls_origin)) = 0 or isnull(ls_origin) then
			ls_destzone = ''
		end if
		
	end if
	
	ll_Company = uo_rateoptions.Of_GetCustomer ( ) 	
	ls_codeName = uo_tablenames.of_getcodename( )	
	this.object.codename[ll_row] = ls_codename
	this.object.billtoid[ll_row] = ll_company

	if ll_row > 1 then
		this.object.rateunit[ll_row] =this.object.rateunit[ll_row - 1]
	else
		this.object.rateunit[ll_row] = ls_breakunits
	end if

	//n_cst_constants.ci_Category_Both = 3
	if rb_bill.checked then
		this.object.category[ll_row] = n_cst_constants.ci_Category_Receivables // = 2 
	else
		this.object.category[ll_row] = n_cst_constants.ci_Category_Payables //=1
	end if
	
end if


THIS.of_Filterexistingzones( )


this.setredraw(true)

return ll_return




end event

event pfc_preupdate;call super::pfc_preupdate;//loop through rows and add unique rate ids
long	ll_nextid, &
		ll_rowcount, &
		ll_row, &
		ll_count
string	ls_orig, &
			ls_dest
			
CONSTANT Boolean cb_Commit	= TRUE	

if isvalid(ids_zoneless) then
	//already created
else
	ids_zoneless = create n_ds
	ids_zoneless.dataobject = 'd_rate'
	ids_zoneless.settransobject(sqlca)
end if

if AncestorReturnValue = 1 then
	
	this.setfilter('')
	this.filter()
	
	ll_rowcount = this.rowcount()
	
	for ll_row = 1 to ll_rowcount

		if isnull(this.getitemnumber(ll_row,"id")) then
			IF gnv_App.of_GetNextId ( "rateid", ll_NextId, cb_Commit ) = 1 THEN
				
				this.object.id[ll_row] = ll_nextid
				this.object.ratelinkbillable_rateid[ll_row] = ll_nextid

				ls_orig = this.object.originzone[ll_row]
				ls_dest = this.object.destzone[ll_row] 
				if isnull(ls_orig) or len(trim(ls_orig)) = 0 then
					//zoneless 
					this.RowsMove(ll_row, ll_row, Primary!, ids_zoneless, 1, Primary!)
				else
					this.object.ratelinkorigzone_rateid[ll_row] = ll_nextid
				end if
				
				if isnull(ls_dest) or len(trim(ls_dest)) = 0 then
					//zoneless 
				else
					this.object.ratelinkdestzone_rateid[ll_row] = ll_nextid
				end if
				
				if isnull(ls_orig) or len(trim(ls_orig)) = 0 then
					//row was moved adjust for loop 
					ll_row --
					ll_rowcount --
				end if
				
			ELSE
				messagebox("Save Rates", "There was a problem saving the rates.  " + &
								"Another user may also be saving rates. Try again.")
			END IF
		end if
	next
	
//need to check the deleted buffer and move zoneless out 
//update on second pass
	ll_rowcount = this.deletedcount()
	if ib_secondpass then
		ib_secondpass = false
	else
		for ll_row = 1 to ll_rowcount
			ls_orig = this.object.originzone.delete[ll_row]
			if isnull(ls_orig) or len(trim(ls_orig)) = 0 then
				this.RowsMove(ll_row, ll_row, delete!, ids_zoneless, 1, delete!)
				ll_row --
				ll_rowcount --
			end if
	
		next
	end if	
	
end if

return AncestorReturnValue
end event

event pfc_postupdate;call super::pfc_postupdate;string	lsa_blank[], &
			lsa_updatecols[], &
			lsa_keycols[]
if AncestorReturnValue = 1 then
	/*
		Some tables might have been unregistered.
		Unregister all and reregister
	*/
	
	inv_multitable.of_unregister('ratelinkbillable')
	inv_multitable.of_unregister("ratelinkorigzone")
	inv_multitable.of_unregister("ratelinkdestzone")
	inv_multitable.of_unregister("rate")
	
	// Register the "ratelinkbillable" table and its key columns.
	lsa_updatecols = lsa_blank
	lsa_keycols = lsa_blank
	
	lsa_keycols[1] = "ratelinkbillable_rateid"
	lsa_keycols[2] = "billtoid"
	lsa_updatecols[1] = "ratelinkbillable_rateid"
	lsa_updatecols[2] = "billtoid"
	inv_multitable.of_AddToUpdate("ratelinkbillable", lsa_keycols, lsa_updatecols) 
	
	
	// Register the "ratelinkorigzone" table and its key columns.
	lsa_updatecols = lsa_blank
	lsa_keycols = lsa_blank
	
	lsa_keycols[1] = "ratelinkorigzone_rateid"
	lsa_keycols[2] = "originzone"
	lsa_updatecols[1] = "ratelinkorigzone_rateid"
	lsa_updatecols[2] = "originzone"
	inv_multitable.of_AddToUpdate("ratelinkorigzone", lsa_keycols, lsa_updatecols) 
	
	// Register the "ratelinkdestzone" table and its key columns.
	lsa_updatecols = lsa_blank
	lsa_keycols = lsa_blank
	
	lsa_keycols[1] = "ratelinkdestzone_rateid"
	lsa_keycols[2] = "destzone"
	lsa_updatecols[1] = "ratelinkdestzone_rateid"
	lsa_updatecols[2] = "destzone"
	inv_multitable.of_AddToUpdate("ratelinkdestzone", lsa_keycols, lsa_updatecols) 
	
	// Register the "rate" table and its key columns.
	lsa_updatecols = lsa_blank
	lsa_keycols = lsa_blank
	
	lsa_keycols[1] = "id"
	lsa_updatecols[1] = "id"
	lsa_updatecols[2] = "codename"
	lsa_updatecols[3] = "ratebreak"
	lsa_updatecols[4] = "rate"
	lsa_updatecols[5] = "rateunit"
	lsa_updatecols[6] = "lastuseddate"
	lsa_updatecols[7] = "category"
	inv_multitable.of_AddToUpdate("rate", lsa_keycols, lsa_updatecols) 
end if
return AncestorReturnValue
end event

event pfc_insertrow;this.setredraw(false)

long	ll_row, &
		ll_ZoneCount, &
		ll_return, &
		ll_company
		
string	ls_findstring, &
			ls_destzone, &
			ls_breakunits, &
			ls_origin, &
			ls_codename

Long		ll_childRowCount
Long		ll_childIndex
datawindowChild	ldwc_child
datawindowchild	ldwc_zones

choose case uo_tablenames.of_Getbreakunit ( )
	case appeon_constant.cs_RateUnit_Code_Flat, appeon_constant.cs_RateUnit_Code_Minimum, &
		  appeon_constant.cs_RateUnit_Code_Maximum, appeon_constant.cs_RateUnit_Code_None
		//only allow one row and only enter rate
		if this.rowcount() = 0 or len(trim(uo_rateoptions.of_GetOrigin())) > 0 then
			ll_return = Super::Event pfc_insertrow()
		else
			ll_return = 0
		end if
	case else
			ll_return = Super::Event pfc_insertrow()
end choose

ll_row = ll_return

if ll_row > 0  then
	
	if len(trim(uo_rateoptions.Of_GetOrigin())) > 0 then
		/*	
			Set value for destination. Look at previous row		
		*/
		if this.GetChild('destzone', ldwc_zones) = 1 then	
			ll_ZoneCount = ldwc_zones.RowCount()
			ls_breakunits = uo_tablenames.of_getbreakunit()
		
			if ll_Row = 1 then
				//added by dan to not copy the name if break unit is flat
				
				IF ls_breakUnits <> "F" THEN
					//get previous zone name
					ls_destzone = uo_rateoptions.of_GetDestination ( )
				ELSE
					this.getChild( "destzone", ldwc_child )
					IF isValid( ldwc_child ) THEN
						ll_childRowCount = ldwc_child.rowCount()
						ll_childIndex = ldwc_child.getRow() + 1
						IF ll_childIndex > 0 AND ll_childIndex <= ll_childRowCount THEN
							ls_destZone =  ldwc_Child.getItemString(ll_childIndex,1)
						END IF
					END IF
				END IF
				//--------------------------------------------------
				
				if len(trim(ls_destzone)) > 0 then
					//ok
				else
					if ll_ZoneCount > 0  then
						ls_destzone = ldwc_zones.GetItemString(1, 'name')
					end if
				end if
			else
				//get previous zone name
				if ll_ZoneCount > 0 then
					//added by dan to not copy the name if break unit is flat
					IF ls_breakUnits <> "F" THEN
						//get previous zone name
						ls_destzone = this.object.destzone[ll_row - 1]
					ELSE
						this.getChild( "destzone", ldwc_child )
						IF isValid( ldwc_child ) THEN
							ll_childRowCount = ldwc_child.rowCount()
							ll_childIndex = ldwc_child.getRow() + 1
							IF ll_childIndex > 0 AND ll_childIndex <= ll_childRowCount THEN
								ls_destZone =  ldwc_Child.getItemString(ll_childIndex,1)
							END IF
						END IF
					END IF
					//--------------------------------------------------
				end if
			end if
			
		end if

		ls_Origin = uo_rateoptions.of_GetOrigin ( )
		this.object.originzone[ll_row] = ls_origin
		this.object.destzone[ll_row] = ls_destzone
		if len(trim(ls_origin)) = 0 or isnull(ls_origin) then
			ls_destzone = ''
		end if
		
	end if
	
	ll_Company = uo_rateoptions.Of_GetCustomer ( ) 
	ls_codeName = uo_tablenames.of_getcodename( )	
	this.object.codename[ll_row] = ls_codename
	this.object.billtoid[ll_row] = ll_company

	if ll_row > 1 then
		this.object.rateunit[ll_row] =this.object.rateunit[ll_row - 1]
	else
		this.object.rateunit[ll_row] = ls_breakunits
	end if

	//n_cst_constants.ci_Category_Both = 3
	if rb_bill.checked then
		this.object.category[ll_row] = n_cst_constants.ci_Category_Receivables // = 2 
	else
		this.object.category[ll_row] = n_cst_constants.ci_Category_Payables //=1
	end if
	
end if

this.setredraw(true)

return ll_return




end event

event pfc_update;long	ll_return, &
		ll_count, &
		ll_ndx, &
		ll_id, &
		ll_ratecount, &
		ll_ndx2
		
boolean	lb_update	
n_ds		lds_ratecopy

//first update will remove new zoneless rates
ll_return = Super::Event pfc_update(true,false)
	
if ll_return = 1 then
	
	ll_count = ids_zoneless.rowcount()
	/*
		if there are any zoneless rates then we need to move rows out of the primary
		and deleted buffers to a copy in case of a failed update on zoneless.
		the zone tables will be unregistered for a successful update of the zoneless
		and then rows will be moved back in from the copy.
	*/
	if ll_count > 0 then
		//move new rows out
		lds_ratecopy = create n_ds
		lds_ratecopy.dataobject = 'd_rate'
		lds_ratecopy.settransobject(sqlca)
		ll_ratecount = this.rowcount()
		for ll_ndx2 = ll_ratecount to 1 step -1
			choose case this.getitemstatus(ll_ndx2,0,Primary!)
				case new!, newmodified! 
					this.rowsmove(ll_ndx2, ll_ndx2, Primary!, lds_ratecopy, 1, primary!)				
				case datamodified!
					this.rowsmove(ll_ndx2, ll_ndx2, Primary!, lds_ratecopy, 1, filter!)
			end choose
		next
		//and deleted rows
		ll_ratecount = this.deletedcount()
		for ll_ndx2 = ll_ratecount to 1 step -1
			if this.getitemstatus(ll_ndx2,0,Delete!) = new! or &
				this.getitemstatus(ll_ndx2,0,Delete!) = newmodified! then
				//no need to move it
			else
				this.rowsmove(ll_ndx2, ll_ndx2, Delete!, lds_ratecopy, 1, Delete!)				
			end if
		next
		
		//move zoneless back
		for ll_ndx = ll_count to 1 step -1 
			ids_zoneless.RowsMove(ll_ndx, ll_ndx, Primary!, this, 1, Primary!)
		next
		lb_update = true

	end if
	
	ll_count = ids_zoneless.deletedcount()
	
	if ll_count > 0 then
		
		for ll_ndx = 1 to ll_count
			ids_zoneless.setitemstatus(ll_ndx, 0, delete!, datamodified!)
			ids_zoneless.setitemstatus(ll_ndx, 0, delete!, notmodified!)
		next
		
		if ids_zoneless.update(true,false) = 1 then
			ll_return = 1 
		else
			ll_return = -1
		end if

	end if
	
	if lb_update then
		if ll_return = 1 then
			inv_multitable.of_unregister('ratelinkorigzone')
			inv_multitable.of_unregister('ratelinkdestzone')	
			ll_return = Super::Event pfc_update(true,false)
		end if
		
		ll_ratecount = lds_ratecopy.rowcount()
		//rows were manipulated, we need to clean up after updating zoneless
		//move new rows back
		if ll_ratecount > 0 then
			lds_ratecopy.rowsmove(1, ll_ratecount, Primary!, this, 1, primary!)				
		end if
		
		//move modified rows back
		ll_ratecount = lds_ratecopy.filteredcount()
		if ll_ratecount > 0 then
			lds_ratecopy.rowsmove(1, ll_ratecount, Filter!, this, 1, primary!)
			for ll_ndx = 1 to ll_ratecount
				this.setitemstatus(ll_ndx, 0, primary!, datamodified!)
			next
		end if
		if ll_return = 1 then
			//no need to move deleted rows back
		else
			ll_ratecount = this.deletedcount()
			for ll_ndx2 = 1 to ll_ratecount
				//only concerned with non new deleted rows
				lds_ratecopy.rowsmove(1, ll_ratecount, Delete!, this, 1, Delete!)				
				this.setitemstatus(1, 0, delete!, datamodified!)
				this.setitemstatus(1, 0, delete!, notmodified!)
			next
		end if
	end if
	
end if
		
if isvalid(ids_zoneless) then
	destroy ids_zoneless
end if

if isvalid(lds_ratecopy) then
	destroy lds_ratecopy
end if

if ll_return = 1 then
	this.resetupdate()
	commit;
end if
	
return ll_return
end event

event itemerror;call super::itemerror;integer	li_return

li_return = AncestorReturnValue

if AncestorReturnValue = 0 then
	
	choose case dwo.name
		case "ratebreak"
			li_return = 1
	end choose

end if

return li_Return
end event

event rowfocuschanging;call super::rowfocuschanging;string	ls_destzone, &
			ls_rateunit, &
			ls_findstring
			
decimal	lc_rate			
			
long		ll_foundrow, &
			ll_return

if currentrow > 0 and this.rowcount() > 0 then
	if currentrow > this.rowcount() then
		//skip
	else
		ls_Destzone = this.Object.destzone [currentrow]
		lc_Rate = this.Object.rate [currentrow]
		ls_RateUnit = this.Object.rateunit [currentrow]
		
		//Added by dan so that empty rates are deleted, because of insert row was not working right.
		IF isNULL( lc_rate ) THEN
//			IF currentRow > 0 THEN
//		//		this.post rowsdiscard( currentRow, currentRow, PRIMARY!)
//			END IF
		ELSE
		//----------------------------------------------
			ls_findstring = "destzone = '" + ls_Destzone + "' and rate = " + string(lc_Rate) + " and rateunit = '" + ls_RateUnit +"'"
			
			ll_foundrow = THIS.FInd ( ls_findstring , 1 , this.rowcount() )
			if ll_foundrow > 0 then
				if ll_foundrow = currentrow then
					ll_foundrow = THIS.FInd ( ls_findstring , ll_foundrow + 1 , this.rowcount() )
					if ll_foundrow > 0 AND ll_foundRow <> currentRow then
						ll_Return = 1
						//hereis proglem
						MessageBox ( "Rate" , "The rate you have entered already exists." )
						Setcolumn( "rate")
					end if
				else
					ll_Return = 1
					MessageBox ( "Rate" , "The rate you have entered already exists." )
					Setcolumn( "rate")
				end if
			END IF
		END IF
	end if
	
end if

if ll_return = 1 then
	this.post selecttext(1, Len(this.GetText()))
end if

return ll_return
end event

event itemfocuschanged;call super::itemfocuschanged;//for type ahead
////added by Dan---
//IF IsValid(this.inv_dropdownsearch) THEN
//   this.inv_dropdownsearch.Event pfc_ItemFocusChanged (row, dwo)
//END IF

DatawindowChild	ldwc_child
Long		ll_childRowCount
Long		ll_childIndex
long		ll_length
String	ls_breakUnit
string	ls_value

choose case dwo.name
	case "destzone"
		ls_value = this.object.destzone[row]
		
end choose

if isnull(ls_value) then
	ll_length = 30
else
	ll_length = len ( ls_value)
end if

post SelectText ( 1, ll_length )

//----------------
end event

event ue_getbreakunit;call super::ue_getbreakunit;//written by dan
String ls_breakUnit
ls_breakUnit = parent.uo_tableNames.of_getbreakunit( )
return ls_breakUnit
end event

type uo_rateoptions from u_zonebilltofilter within u_ratetable
event destroy ( )
integer x = 2459
integer y = 504
integer taborder = 20
boolean bringtotop = true
end type

on uo_rateoptions.destroy
call u_zonebilltofilter::destroy
end on

event constructor;call super::constructor;THIS.of_SetDefaultBase (TRUE)


end event

event ue_itemchanged;long	ll_row
long		ll_customer
string	ls_codename, &
			ls_findstring
DataWindowChild	ldwc_zone
dw_table.Getchild("destzone",ldwc_zone)
		
this.setredraw(false)

choose case upper(as_value)
		
	case 'CUSTOMER'
		//send other customer defaults to the filter

		//first
		this.dw_ratedefaults.event ue_clearblankrow()

		this.dw_ratedefaults.SetFilter('')
		this.dw_ratedefaults.Filter()
	
		ll_customer = this.of_getcustomer()

		ls_codename = parent.uo_tablenames.of_getcodename()
		
		ls_findstring = "codename = '" + ls_codename + "' and billtoid = " + string(ll_customer)
		
		if this.dw_ratedefaults.find(ls_findstring, 1, this.dw_ratedefaults.Rowcount()) = 0 then
			ll_row = this.dw_ratedefaults.event PFC_AddRow()
			this.dw_ratedefaults.object.codename[ll_row]=parent.uo_tablenames.of_getcodename()
			this.dw_ratedefaults.object.billtoid[ll_row]=this.of_getcustomer()
		end if
		
		this.dw_ratedefaults.setfilter(ls_findstring)
		this.dw_ratedefaults.filter()	
		
		this.dw_ratedefaults.scrolltorow(1)
				
end choose


//Added by Dan 1-18-2006, this fixes the problem of inputing an origin zone, and hitting 
//arrow down. Becuase the first setting could have been filtered out, it would add a row 
//to dw_rate and cause the destination to be the second destination rather than the first.
IF as_value = "ORIGIN" THEN
	IF isValid( ldwc_zone ) THEN
		ldwc_zone.setFilter("")
		ldwc_zone.filter( )
	END IF
END IF
//------------------
dw_Table.Post Event ue_Filter ( )

this.setredraw(true)
end event

event ue_tablechanged;long		ll_customer, &
			ll_row, &
			ll_rowcount
			
string	ls_codename

this.of_resetoptions()

ll_rowcount = dw_ratedefaults.rowcount()
if ll_rowcount = 0 then

	ll_rowcount = this.dw_ratedefaults.retrieve()
	
	commit;
else
	//first
	
	this.dw_ratedefaults.event ue_clearblankrow()
	
end if

ll_customer = this.of_getcustomer()

ls_codename = parent.uo_tablenames.of_getcodename()


if ll_rowcount = 0 then
	
	ll_row = this.dw_ratedefaults.event PFC_AddRow()
	
	this.dw_ratedefaults.object.codename[ll_row]=ls_codename
	this.dw_ratedefaults.object.billtoid[ll_row]=ll_customer
end if

this.dw_ratedefaults.setfilter("codename = '" + ls_codename + "' and billtoid = " + string(ll_customer))
this.dw_ratedefaults.filter()

this.dw_ratedefaults.scrolltorow(1)
end event

type rb_bill from radiobutton within u_ratetable
integer x = 2779
integer y = 1388
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12632256
string text = "Bil&l"
boolean checked = true
end type

event clicked;if this.checked then
	dw_Table.Post Event ue_Filter ( )
end if
end event

type rb_pay from radiobutton within u_ratetable
integer x = 3035
integer y = 1388
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "&Pay"
end type

event clicked;if this.checked then
	dw_Table.Post Event ue_Filter ( )
end if
end event

type cb_addcustomer from commandbutton within u_ratetable
integer x = 3241
integer y = 108
integer width = 256
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cop&y ..."
end type

event clicked;integer	li_Return = 1
Long		ll_RowCount
Long		ll_Null
Long		i,j,k
Long		ll_OldCustomer
String	ls_OldCustomerName
String	lsa_Destinations[]
String	ls_Origin
Long		ll_NumberDest
Boolean	lb_Continue = TRUE

S_co_info	lstr_Company
DataStore	lds_Temp
S_Parm		lstr_Parm
n_cst_msg	lnv_Msg
setnull(ll_null)
lds_Temp = CREATE DataStore
lds_Temp.DataObject = "d_Rate"

ls_Origin = uo_rateoptions.of_GetOrigin ( )
ls_OldCustomerName = uo_rateoptions.of_GEtCustomerText ( )
ll_OldCustomer = uo_rateoptions.of_GetCustomer ( )

IF Len ( ls_Origin ) > 0 And Not isNull ( ll_OldCustomer ) THEN
	
	lstr_Parm.is_Label = "ORIGIN" 
	lstr_Parm.ia_Value = ls_Origin
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
	OpenWithParm ( w_MultipleZones , lnv_Msg)
	
	lnv_msg = Message.PowerObjectParm
	
	IF isValid ( lnv_Msg ) THEN
		IF lnv_Msg.of_Get_Parm ( "COMPANY" , lstr_Parm ) <> 0 THEN
			lstr_Company = lstr_Parm.ia_Value
		END IF
		
		IF lnv_Msg.of_Get_Parm ( "DESTINATIONS" , lstr_Parm ) <> 0 THEN
			lsa_Destinations = lstr_Parm.ia_Value
		END IF
	
			// make sure the company is new
			IF lstr_Company.co_id > 0 AND  lstr_Company.co_id  <> ll_OldCustomer  THEN
		
			dw_table.SetRedraw ( FALSE )
			
			ll_NumberDest = UpperBound ( lsa_Destinations )
			IF ll_NumberDest > 0  THEN
				
				// for every destination that came from the window set it with the old company
				// and then copy those rows to a temp ds and change the company and destination 
				// of thoes to later copt to the main dw
				FOR k = 1 TO ll_NumberDest
					
					lb_Continue = TRUE
					lds_Temp.Reset ( )
					
					uo_rateoptions.of_SetCustomer ( ll_OldCustomer )
					uo_rateoptions.of_SetCustomerText ( ls_OldCustomerName )
					uo_rateoptions.of_SetDestination ( lsa_Destinations [ k ] )
					dw_Table.Event ue_Filter ( )
					
					ll_RowCount = dw_table.RowCount ( )
					dw_table.RowsCopy ( 1 , ll_RowCount , PRIMARY! , lds_Temp, 99999 , PRIMARY! )
					
					FOR i =  1 TO lds_Temp.RowCount ( )
						lds_Temp.SetItem ( i , "billtoid" , lstr_Company.co_id ) 
						lds_Temp.SetItem ( i , "destzone" , lsa_Destinations[k] ) 
						lds_Temp.SetItem ( i , "id" , ll_Null ) 
					NEXT
					
					
					// set the new company as the current company
					uo_rateoptions.of_SetCustomer ( lstr_Company.Co_id)
					uo_rateoptions.of_SetCustomerText ( lstr_Company.Co_name )
					uo_rateoptions.of_SetDestination ( lsa_Destinations [ k ] )
					dw_Table.Event ue_Filter ( )
			
					dw_Table.Event ue_ClearBlankRows ( )
				
					// see if the company already has rows and see if the user wants to replace them
					IF dw_Table.RowCount ( ) > 0 THEN
						CHOOSE CASE MessageBox ( "Add Customer" , "The Customer you have selected already has rates associated with the destination " + lsa_Destinations[k] +". Do you want to replace those rates?" , QUESTION! , YESNO! , 2 )
							CASE 1 // replace								
								FOR j =  dw_Table.RowCount ( ) TO 1 STEP -1
									dw_Table.DeleteRow ( j ) 
								NEXT
							CASE 2 // bail
								lb_Continue = FALSE
						END CHOOSE
					END IF
					
					// copy the rows from the temp ds
					IF lb_Continue THEN
						lds_Temp.RowsCopy ( 1 , lds_Temp.RowCount ( )  , PRIMARY! , dw_Table, 99999 , PRIMARY! )
					END IF
					
				NEXT
				
				// set the filter to show what was done
				uo_rateoptions.of_SetCustomer ( lstr_Company.Co_id)
				uo_rateoptions.of_SetCustomerText ( lstr_Company.Co_name )
				uo_rateoptions.of_SetDestination ( '' )
//				uo_rateoptions.of_SetDestination ( lsa_Destinations [ ll_NumberDest ] )
				dw_Table.Event ue_Filter ( )
			END IF
			dw_table.Post SetRedraw (TRUE)
			
		END  IF
		
	END IF
	
ELSE
	MessageBox  ("Copy Table" , "An origin and company must be specified for this operation." ) 
END IF

DESTROY ( lds_Temp )
return li_Return


end event

type st_category from statictext within u_ratetable
integer x = 2482
integer y = 1388
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Category"
boolean focusrectangle = false
end type

