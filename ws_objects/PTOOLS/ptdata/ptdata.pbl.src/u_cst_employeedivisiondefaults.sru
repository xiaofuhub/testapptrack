$PBExportHeader$u_cst_employeedivisiondefaults.sru
forward
global type u_cst_employeedivisiondefaults from u_base
end type
type dw_employeedefaults from u_dw within u_cst_employeedivisiondefaults
end type
end forward

global type u_cst_employeedivisiondefaults from u_base
integer width = 1586
integer height = 852
long backcolor = 12632256
string text = "none"
long picturemaskcolor = 536870912
event ue_retrieve ( long al_empid )
dw_employeedefaults dw_employeedefaults
end type
global u_cst_employeedivisiondefaults u_cst_employeedivisiondefaults

type variables
PRIVATE:
	n_ds	ids_saveddefaults
	
	constant string	cs_unSavedDefaultDivision = "NONE DEFINED"
	constant long		cl_unSavedDefaultDivisionID = -1
	
	Long	ila_AllDivisions[]
	Long	ila_Intermodal[]
	Long	ila_Brokerage[]
	Long	ila_Dispatch[]
end variables

forward prototypes
public function integer of_getsaveddivision (string as_shiptype, ref long al_divisionid)
end prototypes

event ue_retrieve(long al_empid);Long			ll_index
Long			ll_max
Long			ll_divId
Long			ll_newRow

String		ls_divisions

Int			li_continue = 1

Boolean					lb_hasBrokerageLicense
Boolean					lb_Intermodal
Boolean					lb_Brokerage
String					lsa_shipTypes[]
DatawindowChild		ldwc_divisions

n_ds						lds_defaultDivsCache
n_cst_Ship_Type		lnv_ShipType
n_cst_licensemanager	lnv_licensemanager
n_cst_setting_defaultnewshipbutton	lnv_setting

//Needed to find get the possible shipmentTypes
lnv_setting = CREATE n_cst_setting_defaultnewshipbutton

lnv_setting.of_getarray( lsa_shipTypes )

//get the listing of defaults that have already been set up and saved for
//a particular user, and copy it into our instance of the cache.  Changes to the
//actual cache will be made when the save happens for this userobject.
ll_max = lnv_shipType.of_getdefaultdivisionscache( lds_defaultDivsCache )
IF ll_max > 0 AND isValid( lds_defaultDivsCache ) THEN
	lds_defaultDivsCache.setFilter( "em_id = " + string(al_empId) )	//dataobject is d_employeedivisiondefaults
	lds_defaultDivsCache.filter()
	ll_max = lds_defaultDivsCache.rowCount()
	
	ids_saveddefaults.reset()
	lds_defaultDivsCache.rowsCopy( 1, ll_max, PRIMARY!, ids_saveddefaults, 1, PRIMARY!)
	
END IF

//gets a listing of defaults that have already been set up and saved
//for a particular user
//ids_savedDefaults.retrieve( {al_empId} )
//commit;

//needed to know whether or not to prepopulate the display with shiptypes 
//that would apply only to those who have brokerage liscenses.
lb_hasBrokerageLicense = lnv_licensemanager.of_getlicensed( n_cst_Constants.cs_Module_Brokerage )


//populate the datawindow child with the divisions
dw_employeedefaults.getChild( "division", ldwc_divisions )
IF lnv_Shiptype.of_Ready(True) AND isValid( ldwc_divisions )  THEN
	li_continue = 1 
	
	ll_max = gds_shiptype.rowCount()	
	IF ldwc_divisions.Rowcount( ) = 0 THEN
		ll_newRow = ldwc_divisions.insertRow( 0 )
			
		ldwc_divisions.setItem( ll_newRow, "hidden_values", cl_unsaveddefaultdivisionid )
		ldwc_divisions.setItem( ll_newRow, "values", cs_unsaveddefaultdivision )
		
		FOR ll_index = 1 TO ll_max
			ls_divisions = gds_shiptype.getItemString( ll_index, "st_name" )
			ll_divId = gds_shipType.GetItemNumber( ll_index, "st_id" )
			IF gds_shipType.GetItemString( ll_index, "st_status") = "K" THEN
				ll_newRow = ldwc_divisions.insertRow( 0 )
				
				ldwc_divisions.setItem( ll_newRow, "hidden_values", ll_divId )
				ldwc_divisions.setItem( ll_newRow, "values", ls_divisions )
				
				//Populate division id arrays
				ila_AllDivisions[UpperBound(ila_AllDivisions) + 1] = ll_DivId
				
				lb_intermodal = gds_shiptype.Object.intermodal[ll_Index]  = "T"
				lb_brokerage = gds_shiptype.Object.st_brokerage[ll_Index] = "T"
				
				IF lb_intermodal THEN
					ila_Intermodal[UpperBound(ila_Intermodal) + 1] = ll_divId
				ELSEIF lb_Brokerage THEN
					ila_Brokerage[UpperBound(ila_Brokerage) + 1] = ll_divId
				ELSE
					ila_Dispatch[UpperBound(ila_Dispatch) + 1] = ll_divId
				END IF
			END IF
		NEXT
	END IF
END IF


//for all shiptypes, if they have they have the license then insert a row into the display.
IF li_continue = 1 THEN
	
	ll_max = upperBOund( lsa_shipTypes )
	FOR ll_index = 1 TO ll_max
		//do not list template or brokerage shiptypes if they don't have license for it
		IF NOT lb_hasBrokerageLicense AND (Pos( UPPER(lsa_shipTypes[ll_index]), "BROKERAGE" ) > 0 OR UPPER(lsa_shipTypes[ll_index]) = "3RDPARTYTRIP" ) OR UPPER(lsa_shipTypes[ll_index]) = "TEMPLATE" THEN
			//don't add it to the display
		ELSE
			IF UPPER(lsa_shipTypes[ll_index]) <> "3RDPARTYTRIP" THEN
				ll_newRow = dw_employeedefaults.insertRow( 0 )
				dw_employeedefaults.setItem( ll_newRow, "em_id", al_empId )
				dw_employeedefaults.setItem( ll_newRow, "shiptype", lsa_shipTypes[ll_index] )
				
				//if there is a saved id then set the item and change the row status to not modified.
				//Otherwise, set it to undefined
				IF this.of_getsaveddivision( lsa_shipTypes[ll_index], ll_divId ) <> -1 THEN
					dw_employeedefaults.setItem( ll_newRow, "division", ll_divid )
					//must do these two steps to set it to notmodified
					dw_employeedefaults.setItemStatus( ll_newRow, 0, PRIMARY!, Datamodified!)
					dw_employeedefaults.setItemStatus( ll_newRow, 0, PRIMARY!, NOTmodified!)
				ELSE
					//DW_employeedefaults.SETiTEMsTATus( LL_NEWrOW, 0, PRIMARY!, NEW!)
					dw_employeedefaults.setItem( ll_newRow, "division", cl_unsaveddefaultdivisionid )
				END IF
				
				//meant to trigger rowfocuschanging so that inappropriate 
				//shipment types get hidden on ldwc_divisions
				IF ll_NewRow > 0 THEN
					dw_employeedefaults.SetRow(ll_NewRow)
				END IF
			END IF
		END IF
	NEXT
END IF



DESTROY lnv_setting
end event

public function integer of_getsaveddivision (string as_shiptype, ref long al_divisionid);//returns -1 if there isn't a defined shipment for the value
//return by reference the defaulted division  id if it does exist
//returns
Int	li_return
Long	ll_found
Long	ll_index
Long	ll_max
String ls_find


ll_max = ids_saveddefaults.rowCOunt()

ls_find = "shiptype = '"+as_shipType+"'"

ll_found = ids_saveddefaults.find( ls_find, 1, ll_max)

IF ll_found > 0 THEN
	al_divisionId = ids_saveddefaults.getItemNumber( ll_found, "division" )
ELSE
	li_return = -1
END IF
	

RETURN li_return

end function

on u_cst_employeedivisiondefaults.create
int iCurrent
call super::create
this.dw_employeedefaults=create dw_employeedefaults
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_employeedefaults
end on

on u_cst_employeedivisiondefaults.destroy
call super::destroy
destroy(this.dw_employeedefaults)
end on

event constructor;//gets a listing of defaults that have already been set up and saved
//for a particular user

ids_savedDefaults = create n_ds
ids_savedDefaults.dataobject = "d_employeedivisiondefaults"
ids_savedDefaults.setTransobject( SQLCA )


end event

event destructor;DESTROY ids_savedDefaults
end event

type dw_employeedefaults from u_dw within u_cst_employeedivisiondefaults
integer x = 37
integer y = 32
integer width = 1509
integer height = 776
integer taborder = 10
string dataobject = "d_employeedivisiondefaults"
end type

event constructor;call super::constructor;this.setTransobject( SQLCA )
end event

event pfc_validation;Long	ll_index
Long	ll_max
Int	li_return

li_Return = 1
ll_max = this.rowcount( )
FOR ll_index = 1 TO ll_max
	IF this.getItemNumber(ll_index, "division") = parent.cl_unSavedDefaultDivisionID THEN
		//li_return = -1

		EXIT
	END IF
NEXT

RETURN li_return


end event

event pfc_accepttext;call super::pfc_accepttext;Long	ll_index
Long	ll_max
Int	li_return

li_Return = 1
ll_max = this.rowcount( )
FOR ll_index = ll_max TO 1 step - 1
	IF this.getItemNumber(ll_index, "division") = parent.cl_unSavedDefaultDivisionID THEN
		//li_return = -1
		
		//changed it from failing validation to discarding rows that i don't actually want to 
		//save
		this.rowsdiscard( ll_index, ll_index, primary!)
		//EXIT
	END IF
NEXT

RETURN li_return
end event

event rowfocuschanging;call super::rowfocuschanging;String	ls_ShipType
String	ls_Filter
String	ls_InterModalFilter
String	ls_BrokerageFilter
String	ls_OtherFilter
Boolean	lb_show
Long		lla_showIds[]
Long		ll_rowcount,ll_typecount
Long		i, j
Long		ll_DummyRow
Long		ll_Division
Long		ll_DetailHeight

DatawindowChild		ldwc_divisions
n_cst_Ship_Type 	 lnv_ShipType

// hide/show division dddw rows based on new shipment type
this.setredraw(false)
dw_EmployeeDefaults.getChild( "division", ldwc_divisions )
IF isValid( ldwc_divisions )  THEN
	IF newRow > 0 THEN
		ls_shiptype = This.GetItemString(newrow, "shiptype")
		CHOOSE CASE ls_ShipType
			CASE "INTERMODAL"
				lla_showIds[] = ila_intermodal[]   //only display intermodal
			CASE "BROKERAGE", "NONROUTEDBROKERAGE"
				lla_showIds[] = ila_brokerage[]    //only display brokerage
			CASE "DISPATCH", "CROSSDOCK", "NONROUTED"
				lla_showIds[] = ila_dispatch[]     //only display not intermodal and not brokerage
			CASE ELSE
				lla_ShowIds[] = ila_allDivisions[] //display all
		END CHOOSE
		
		ll_RowCount = ldwc_divisions.Rowcount()
		FOR i = 1 TO ll_RowCount
			lb_show = false
			
			ll_typecount = upperbound(lla_showIds[])
			FOR j = 1 TO ll_typecount
				
				ll_Division = ldwc_divisions.GetItemNumber(i, "hidden_values")
				IF ll_Division = lla_showIds[j] THEN
					lb_show = TRUE
					EXIT
				END IF
				
			NEXT
			
			//PB Bug: SetDetailHeight(lastrow,lastrow,x) does not work on last row
			//Fix: Insert a dummy row at the end temporarily
			ll_DummyRow = 0
			IF i = ll_RowCount THEN
				ll_DummyRow = ldwc_divisions.InsertRow(0)
			END IF
			
			IF lb_show THEN
				ll_DetailHeight = Long(This.Describe("DataWindow.Detail.Height"))
				ldwc_divisions.SetDetailHeight(i, i, ll_DetailHeight) //show
			ELSE
				ldwc_divisions.SetDetailHeight(i, i, 0) //hide
			END IF
			
			//Delete Dummy Row
			IF ll_DummyRow > 0 THEN
				ldwc_divisions.DeleteRow(ll_DummyRow)
				ldwc_divisions.RowsDiscard(1, ldwc_divisions.DeletedCount(), Delete!)
			END IF		
			
		NEXT
	END IF
END IF

this.setredraw(true)


end event

event pfc_update;//make this override ancestor,  any changes made to this datawindow must be made to the
//actual cache at this point. That means that I must insert a row for every 
//newModified row, and find and edit a row for datamodified rows.

n_cst_ship_type	lnv_shipType
n_ds					lds_defaultDivsCache
Long					ll_cachemax
Long					ll_dwMax
Long					ll_cacheIndex
Long					ll_dwIndex

String				ls_find
String				ls_shipType
Long					ll_division
Long					ll_emId

int					li_return


IF this.modifiedcount( ) > 0 THEN
	li_return = 1
ELSE
	li_return = 0			//no changes
END IF

IF li_return = 1 THEN
	ll_cachemax = lnv_shipType.of_getdefaultdivisionscache( lds_defaultDivsCache )

	IF isValid( lds_defaultDivsCache ) THEN
		
		ll_dwMax = this.rowCount()
		FOR ll_dwIndex = 1 TO ll_dwMax
			CHOOSE CASE	this.getItemStatus( ll_dwIndex, "division", PRIMARY!)
				CASE DataModified!	
					//find the matching value in the cache and change it to the new value
					ls_shipType = this.getItemString( ll_dwIndex, "shiptype" )
					ll_emId = this.getiTemNumber( ll_dwIndex, "em_id" )
					ll_division = this.getItemNumber( ll_dwIndex, "division" )
					
					ls_find = "em_id = "+string( ll_emId )+ " AND shiptype = '"+ls_shipType+"'"
					
					ll_cacheIndex = lds_defaultDivsCache.find( ls_find, 1, ll_cacheMax )
					
					IF ll_cacheIndex > 0 THEN
						IF ll_division <> cl_unSavedDefaultDivisionID THEN
							lds_defaultDivsCache.setItem( ll_cacheIndex, "division", ll_division )
						END IF
					ELSE
						//need to insert a new row in the cache
						IF ll_division <> cl_unsaveddefaultdivisionid THEN
							ll_cacheIndex = lds_defaultDivsCache.insertRow(0)
							
							lds_defaultDivsCache.setItem( ll_cacheIndex, "em_id", ll_emId )
							lds_defaultDivsCache.setItem( ll_cacheIndex, "shiptype", ls_shipType )
							lds_defaultDivsCache.setItem( ll_cacheIndex, "division", ll_division )
						END IF
					END IF
					
			END CHOOSE
		NEXT
		
	END IF
END IF

li_return = lnv_shipType.of_savedivisiondefaults( )

RETURN li_Return
end event

