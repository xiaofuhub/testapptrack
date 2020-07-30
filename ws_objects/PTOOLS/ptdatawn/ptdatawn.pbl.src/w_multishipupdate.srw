$PBExportHeader$w_multishipupdate.srw
forward
global type w_multishipupdate from w_response
end type
type dw_psr2 from u_dw_shipinfo within w_multishipupdate
end type
type cb_undo from commandbutton within w_multishipupdate
end type
type rb_replace from radiobutton within w_multishipupdate
end type
type rb_append from radiobutton within w_multishipupdate
end type
type st_2 from statictext within w_multishipupdate
end type
type cb_save from commandbutton within w_multishipupdate
end type
type cb_apply from commandbutton within w_multishipupdate
end type
type st_1 from statictext within w_multishipupdate
end type
type dw_psr1 from u_dw within w_multishipupdate
end type
end forward

global type w_multishipupdate from w_response
integer width = 3442
integer height = 1776
string title = "Multi Shipment Update"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
long backcolor = 12632256
event ue_apply ( )
event ue_save ( )
event ue_undo ( )
event ue_recalcfuelcurcharge ( )
dw_psr2 dw_psr2
cb_undo cb_undo
rb_replace rb_replace
rb_append rb_append
st_2 st_2
cb_save cb_save
cb_apply cb_apply
st_1 st_1
dw_psr1 dw_psr1
end type
global w_multishipupdate w_multishipupdate

type variables
Long ila_ShipID[] 
String isa_ColArray[]
String isa_newColArray[]

PRIVATE:
n_cst_bso_Dispatch	inv_Dispatch
n_cst_beo_Shipment	inv_Shipment

Boolean	ib_Applied
end variables

forward prototypes
public function boolean wf_checkforappend ()
public function string wf_checkforshipnoteformat ()
public subroutine wf_parsecolarray (string asa_colarray[], ref string asa_newcolarray[])
public subroutine wf_processlayerforapply (boolean ab_append, string as_tagname, ref boolean ab_appendreplaceaction)
public function integer wf_processlayerforsave (string as_tagname, n_cst_beo_shipment anv_shipment, n_cst_bso_dispatch anv_dispatch, ref any aa_value)
public function boolean wf_undochangesprocesslayer (string as_tagname)
private function n_cst_bso_Dispatch wf_getdispatch ()
private function integer wf_preprocessdata (n_cst_beo_shipment anv_shipment, string as_tag, ref any aa_value, long al_row)
private function integer wf_checkforpreprocess (long al_row, dwobject adwo_value)
end prototypes

event ue_apply();//modified by Dan 12-1-2005 to fix the rowscopy problem where a new column was added to the cache but
//not to the PSR that the customer was using.  

//NOTE:  Validation of privileges on the multishipment update is expected to be done before this.
//       Added validation to f_processStandard, Dan, 5-8-2006
Int li_Ctr2
Int li_ReturnValue = 1

Any la_Value

Long	ll_Row
Long ll_Ctr1
Long ll_ShipmentID	
Long ll_RowCount
Long ll_ArrayCount

String ls_ColName
String ls_ColType
String ls_TagName
String ls_dw_psr2Value
Boolean	lb_ShowSyncError
Boolean lb_AppendChecked
Boolean lb_AppendReplaceAction

dwBuffer	le_Buffer
DataStore		lds_ShipmentCache

Long		ll_colCount
Long		ll_index
String	ls_columnName
String	ls_colExists

dw_psr1.AcceptText()
dw_psr2.AcceptText()

lb_AppendChecked = wf_CheckForAppend()

isa_NewcolArray = {""}

wf_parsecolarray(isa_ColArray,isa_NewColArray)

ll_RowCount 	= dw_psr2.RowCount()
ll_ArrayCount 	= UpperBound(isa_NewColArray)

lds_ShipmentCache = inv_dispatch.of_getshipmentcache( )
inv_Shipment.of_SetSource ( lds_ShipmentCache )


FOR ll_Ctr1 = 1 TO ll_RowCount
	
	ll_ShipmentID = dw_Psr2.GetItemnumber( ll_Ctr1 , "ds_id" )
	IF ll_ShipmentID > 0 THEN		
		inv_Dispatch.of_FilterShipment( ll_ShipmentID )
		inv_Shipment.of_SetSourceID ( ll_ShipmentID )
	ELSE
		CONTINUE
	END IF
	
	IF NOT inv_shipment.of_AllowEdit( ) THEN
		MessageBox ( "Modify Shipment" , "You are not allowed to modify shipment " + String ( ll_ShipmentID ) )
		CONTINUE
	END IF
	
	
	FOR li_Ctr2 = 1 TO ll_ArrayCount
		ls_ColName = isa_newColArray[li_Ctr2]
		ls_ColType = Upper(dw_psr1.Describe(ls_ColName + ".ColType")) 
		ls_TagName = Upper(dw_psr1.Describe(ls_ColName + ".tag")) 		
		
		wf_ProcessLayerForApply(lb_AppendChecked,ls_TagName,lb_AppendReplaceAction) // lb_AppendReplaceAction : True = Append, False = Replace

		CHOOSE CASE Left ( ls_ColType , 5 )
			CASE 'LONG'		
				la_Value = dw_psr1.GetItemNumber(1,ls_ColName)
			CASE 'CHAR(' // For string	
				IF lb_AppendReplaceAction THEN			 
					ls_dw_psr2Value = Trim(dw_psr2.GetItemString(ll_Ctr1,ls_ColName))
					IF IsNull(ls_dw_psr2Value) OR Len(ls_dw_psr2Value) = 0 THEN
						la_Value = dw_psr1.GetItemString(1,ls_ColName)
					ELSE
						la_Value = dw_psr2.GetItemString(ll_Ctr1,ls_ColName) + dw_psr1.GetItemString(1,ls_ColName)
					END IF	
				ELSE
					la_Value = dw_psr1.GetItemString(1,ls_ColName)
				END IF					
			CASE 'CHAR(1)' // For Character
				IF lb_AppendReplaceAction THEN
					ls_dw_psr2Value = Trim(dw_psr2.GetItemString(ll_Ctr1,ls_ColName))
					IF IsNull(ls_dw_psr2Value) OR Len(ls_dw_psr2Value) = 0 THEN
						la_Value = dw_psr1.GetItemString(1,ls_ColName)
					ELSE	
						la_Value = dw_psr2.GetItemString(ll_Ctr1,ls_ColName) + dw_psr1.GetItemString(1,ls_ColName)
					END IF	
				ELSE	
					la_Value = dw_psr1.GetItemString(1,ls_ColName)
				END IF					
			CASE 'DATE'
				la_Value = dw_psr1.GetItemDate(1,ls_ColName)
			CASE 'DATET' // dateTime
				la_Value = dw_psr1.GetItemDateTime(1,ls_ColName)
			CASE 'TIME'
				la_Value = dw_psr1.GetItemTime(1,ls_ColName)
			CASE 'DECIM'					
				la_Value = dw_psr1.GetItemDecimal(1,ls_ColName)
		END CHOOSE


//mod by dan - commented out the null check so that we can clear out dates and times
		//IF Not IsNull (la_Value) THEN
			
			THIS.wf_Preprocessdata( inv_Shipment , ls_TagName, la_Value , ll_Ctr1)
//			dw_psr2.SetItem(ll_Ctr1,ls_ColName,la_Value)
//			dw_psr2.SetColumn ( ls_ColName )
//			dw_psr2.event itemchanged( ll_Ctr1, dw_psr2.object  , String ( la_Value ))
		//END IF
		dw_Psr2.setItem( ll_ctr1, ls_ColName, la_value )
	NEXT	
	
	inv_Shipment.of_GetSourcerow( ll_row, le_Buffer, FALSE )
	
	IF ll_Row > 0 THEN
		dw_psr2.SetRedraw(FALSE)
//		--Modified By Dan----
		
//		loops through the caches columbs and if the column exists in the psr and it was modified,
//		we replace the old value in the psr with the value from the cache.  This was used to replace
//		the rows copy problem where a column was added to the cache, so the rowscopy would fail for the
//		psr.
		ll_colCount = Long( lds_ShipmentCache.Object.DataWindow.Column.Count )

		
		
// This chunk of code was commenteed out. I uncommented it because of issue 2221

		FOR ll_index = 1 TO ll_colCount
			IF lds_shipmentCache.GetItemStatus ( ll_row, ll_index, le_buffer ) <> NotModified! THEN
				ls_columnName =  lds_shipmentCache.Describe("#"+String(ll_Index)+".name")
				ls_colExists = dw_Psr2.Describe( ls_columnName +".Tag")
				
				//If it returns an '!' that means the column exists indw_psr2
				IF ls_colExists <> "!" THEN
					

					//first get the value from the cache, then set the value in dw_psr2
					ls_ColType = Upper(lds_shipmentCache.Describe(ls_ColumnName + ".ColType")) 	
					
					CHOOSE CASE Left ( ls_ColType , 5 ) 
						CASE 'LONG'		
							la_Value = lds_shipmentCache.GetItemNumber(ll_row,ls_columnName)
						CASE 'CHAR(' // For string	
							la_Value = lds_shipmentCache.GetItemString(ll_row,ls_columnName)							
//						CASE 'CHAR(1)' // For Character
	//						la_Value = lds_shipmentCache.GetItemString(ll_row,ls_columnName)					
						CASE 'DATE'
							la_Value = lds_shipmentCache.GetItemDate(ll_row,ls_columnName)
						CASE 'DATET'
							la_Value = lds_shipmentCache.GetItemDateTime(ll_row,ls_columnName)
						CASE 'TIME'
							la_Value = lds_shipmentCache.GetItemTime(ll_row,ls_columnName)
						CASE 'DECIM'					
							la_Value = lds_shipmentCache.GetItemDecimal(ll_row,ls_columnName)
				
					END CHOOSE

					dw_Psr2.setItem( ll_ctr1, ls_columnName, la_value )
				END IF
				
			END IF
		NEXT
		
		//---------------------
//		IF lds_ShipmentCache.RowsCopy( ll_Row, ll_Row, le_Buffer , dw_Psr2, ll_Ctr1 , PRIMARY! ) = 1 THEN
//			dw_Psr2.DeleteRow( ll_Ctr1 + 1)
//		ELSE 
//			
//			lb_ShowSyncError = TRUE
//		END IF
		dw_psr2.SetRedraw(TRUE)
	END IF
	
NEXT
String	lsa_Empty[]
isa_colarray =  lsa_Empty
ib_Applied = TRUE
cb_undo.Enabled = TRUE

IF lb_ShowSyncError THEN
	MessageBox ( "Multi-Shipment update" , "A problem was encountered while attempting to update the shipments. Your Multi-Shipment template file may be corrupt. Please contact Profit Tools support." )	
END IF

end event

event ue_save();
IF NOT ib_Applied THEN
	THIS.event ue_Apply ( ) 
END IF

inv_Dispatch.event pt_save( )

return 






//IF dw_psr2.ModifiedCount() > 0 THEN 
//	Int li_Ctr1
//	Int li_Ctr2
//	Any la_Value
//	
//	Long ll_RowCount
//	Long ll_ArrayCount
//	Long ll_Value
//	
//	Char lc_Value
//	String ls_ColName
//	String ls_TagName
//	String ls_ColType
//	String ls_Value
//	
//	Date ld_Value
//	DateTime ldt_Value
//	Time lt_Value
//	
//	Dec ldec_Value
//	
//	// Will assure to accept all changes made to the bottom DW.
//	dw_psr1.AcceptText()
//	dw_psr2.AcceptText()
//	
//	isa_NewColArray = {""}
//	
//	wf_parsecolarray(isa_ColArray,isa_NewColArray)
//	
//	ll_RowCount 	= dw_psr2.RowCount()
//	ll_ArrayCount 	= UpperBound(isa_NewColArray)
//	
//	n_ds	lds_ShipCache
//	n_ds	lds_itemcache
//	n_ds	lds_eventcache
//	
//	n_cst_bso_dispatch	lnv_Dispatch
//	n_cst_beo_shipment	lnv_Shipment
//	
//	lnv_Dispatch = CREATE n_cst_bso_dispatch
//	lnv_Shipment = CREATE n_cst_beo_shipment
//	
//	lnv_shipment.of_SetContext(lnv_dispatch)
//	
//	lnv_dispatch.of_RetrieveShipments(ila_ShipID)
//	
//	lds_ShipCache = lnv_Dispatch.of_GetShipmentCache()
//	lds_ItemCache = lnv_Dispatch.of_GetItemCache()
//	lds_EventCache = lnv_Dispatch.of_GetEventCache()
//	
//	lnv_Shipment.of_SetSource(lds_ShipCache)
//	lnv_Shipment.of_SetItemSource(lds_ItemCache)
//	lnv_Shipment.of_SetEventSource(lds_EventCache)
//	
//	FOR li_Ctr1 = 1 TO ll_RowCount
//		lnv_Dispatch.of_FilterShipment	( ila_ShipID[li_Ctr1] )
//		lnv_Shipment.of_SetSourceid    	( ila_ShipID[li_Ctr1] ) 
//		
//		FOR li_Ctr2 = 1 TO ll_ArrayCount
//			ls_ColName = isa_newColArray[li_Ctr2]
//			ls_ColType = Upper(dw_psr1.Describe(ls_ColName + ".ColType")) 
//			ls_TagName = Upper(dw_psr1.Describe(ls_ColName + ".tag")) 			
//
//			CHOOSE CASE ls_ColType
//				CASE 'LONG'		
//					la_Value = dw_psr2.GetItemNumber(li_Ctr1,ls_ColName)
//				CASE 'CHAR(32766)' // For string	
//					la_Value = dw_psr2.GetItemString(li_Ctr1,ls_ColName)
//				CASE 'CHAR(1)' // For Character
//					la_Value = dw_psr2.GetItemString(li_Ctr1,ls_ColName)
//				CASE 'DATE'
//					la_Value = dw_psr2.GetItemDate(li_Ctr1,ls_ColName)
//				CASE 'DATETIME'
//					la_Value = dw_psr2.GetItemDateTime(li_Ctr1,ls_ColName)
//				CASE 'TIME'
//					la_Value = dw_psr2.GetItemTime(li_Ctr1,ls_ColName)
//				CASE 'DECIMAL(2)'					
//					la_Value = dw_psr2.GetItemDecimal(li_Ctr1,ls_ColName)
//			END CHOOSE
//			
//			IF wf_ProcessLayerForSave(ls_TagName , lnv_Shipment , lnv_Dispatch , la_Value ) <> 1 THEN 
//				CONTINUE
//			END IF	
//			
//			IF Not IsNull (la_Value) THEN
//				THIS.wf_Preprocessdata( lnv_Shipment, ls_Tagname , la_Value )
//				//lnv_Shipment.event ue_setvalueany(ls_TagName,la_Value)
//			END IF
//		NEXT	
//	NEXT	
//	
//	lnv_dispatch.event pt_save( )
//	
//	DESTROY(lnv_dispatch)
//	DESTROY(lnv_Shipment)
//END IF
end event

event ue_undo();IF MessageBox('Multi Shipment Update','Are you sure you want to undo changes?',QUESTION!,YesNo!,2) = 1 THEN
	Any la_Value	
	Int li_Ctr1
	Int li_Ctr2
	
	Long ll_RowCount
	Long ll_ArrayCount
	
	String ls_ColName
	String ls_ColType
	String ls_Value
	String ls_TagName
	
	dw_psr1.AcceptText()
	dw_psr2.AcceptText()
	
	isa_NewColArray = {""}
	
	wf_parsecolarray(isa_ColArray,isa_NewColArray)
	
	ll_RowCount 	= dw_psr2.RowCount()
	ll_ArrayCount 	= UpperBound(isa_NewColArray)

	FOR li_Ctr1 = 1 TO ll_RowCount
		FOR li_Ctr2 = 1 TO ll_ArrayCount
			ls_ColName = isa_newColArray[li_Ctr2]
			ls_ColType = Upper(dw_psr1.Describe(ls_ColName + ".ColType"))
			ls_TagName = Upper(dw_psr1.Describe(ls_ColName + ".tag"))
			
			CHOOSE CASE ls_ColType
				CASE 'LONG'		
					la_Value	 = dw_psr2.GetItemNumber(li_Ctr1,ls_ColName,Primary!,TRUE)

				CASE 'CHAR(32766)' // For string	
					la_Value = dw_psr2.GetItemString(li_Ctr1,ls_ColName,Primary!,TRUE)
					
				CASE 'CHAR(1)' // For Character
					la_Value = dw_psr2.GetItemString(li_Ctr1,ls_ColName,Primary!,TRUE)
					
				CASE 'DATE'
					la_Value = dw_psr2.GetItemDate(li_Ctr1,ls_ColName,Primary!,TRUE)
					
				CASE 'DATETIME'
					la_Value = dw_psr2.GetItemDateTime(li_Ctr1,ls_ColName,Primary!,TRUE)
					
				CASE 'TIME'
					la_Value = dw_psr2.GetItemTime(li_Ctr1,ls_ColName,Primary!,TRUE)
					
				CASE 'DECIMAL(2)'										
					la_Value = dw_psr2.GetItemDecimal(li_Ctr1,ls_ColName,Primary!,TRUE)
					
			END CHOOSE	
			
			IF wf_undochangesprocesslayer(ls_TagName) THEN 
				la_Value = ""
			END IF	
			
			IF Not IsNull (la_Value) THEN
				dw_psr2.SetItem(li_Ctr1,ls_ColName,la_value)
			END IF
			
		NEXT	
	NEXT
	
	cb_undo.Enabled = FALSE
	
END IF
end event

event ue_recalcfuelcurcharge();Long	ll_rowCount
Long	i
Long	ll_ShipmentID

ll_rowCount = dw_psr2.RowCount () 

FOR i = 1 TO ll_RowCount
	
	ll_ShipmentID = dw_Psr2.GetItemnumber( i , "ds_id" )
	IF ll_ShipmentID > 0 THEN		
		
		inv_Dispatch.of_FilterShipment( ll_ShipmentID )
		inv_Shipment.of_SetSourceID ( ll_ShipmentID )
		inv_Shipment.of_SetitemSource ( inv_dispatch.of_getItemCache ( )) 
		dw_psr2.Setitem( i,"fuelsurcharge", String (  inv_Shipment.of_Recalcexistingsurcharges( FALSE ) ) )		
		
	ELSE
		CONTINUE
	END IF
	
NEXT
end event

public function boolean wf_checkforappend ();Boolean lb_AppendChecked


IF rb_append.Checked THEN 
	lb_AppendChecked = TRUE
ELSE
	lb_AppendChecked = FALSE
END IF

Return lb_AppendChecked
end function

public function string wf_checkforshipnoteformat ();String ls_ReturnValue

n_cst_setting_shipnoteformat	lnv_ShipnoteFormat
lnv_ShipnoteFormat = CREATE n_cst_setting_shipnoteformat
IF lnv_shipnoteFormat.of_GetValue ( ) = lnv_ShipnoteFormat.cs_individual THEN
	ls_ReturnValue = "INDIVIDUAL"
ELSE
	ls_ReturnValue = ""
END IF

DESTROY(lnv_ShipnoteFormat)
Return ls_ReturnValue
end function

public subroutine wf_parsecolarray (string asa_colarray[], ref string asa_newcolarray[]);Int li_Ctr1
Int li_Ctr2
Int li_NewCtr
Long ll_UpperBound1
Long ll_UpperBound2
String lsa_ColArray[]
String lsa_NewColArray[]
String ls_NewVal

Boolean lb_add

lsa_ColArray = asa_colarray

ll_UpperBound1 = UpperBound(lsa_ColArray)

IF ll_UpperBound1 > 0 THEN 
	FOR li_Ctr1 = 1 TO ll_UpperBound1
		ls_NewVal = lsa_ColArray[li_Ctr1]
		ll_UpperBound2 = UpperBound(lsa_NewColArray)
		IF ll_UpperBound2 > 0 THEN 
			FOR li_Ctr2 = 1 TO ll_UpperBound2
				IF ls_NewVal = lsa_NewColArray[li_Ctr2] THEN
					lb_add = FALSE
					EXIT
				ELSE
					lb_add = TRUE
				END IF	
				ll_UpperBound2 = UpperBound(lsa_NewColArray)
			NEXT	
		ELSE
			lb_add = TRUE
		END IF	
		IF lb_add THEN
			li_NewCtr++
			lsa_NewColArray[li_NewCtr] = ls_NewVal
		END IF	
	NEXT	
END IF

asa_Newcolarray = lsa_NewColArray
end subroutine

public subroutine wf_processlayerforapply (boolean ab_append, string as_tagname, ref boolean ab_appendreplaceaction);String ls_TagName
Boolean lb_AppendReplaceAction  // True = Append, False = Replace

ls_TagName = as_TagName

CHOOSE CASE ls_TagName
	CASE "SHIPNOTE"
		IF wf_CheckForShipNoteFormat( ) = "INDIVIDUAL" THEN
			lb_AppendReplaceAction = TRUE
			ab_appendreplaceAction = lb_AppendReplaceAction
		ELSE
			IF ab_append THEN
				lb_AppendReplaceAction = TRUE
				ab_appendreplaceAction = lb_AppendReplaceAction
			ELSE			
				lb_AppendReplaceAction = FALSE
				ab_appendreplaceAction = lb_AppendReplaceAction
			END IF	
		END IF
	
	CASE ELSE
		ab_appendreplaceAction = ab_append
END CHOOSE
end subroutine

public function integer wf_processlayerforsave (string as_tagname, n_cst_beo_shipment anv_shipment, n_cst_bso_dispatch anv_dispatch, ref any aa_value);/* ////////////////////////////////////////////////////////
 
   Function		: of_ProcessLayer
   Arguments 	: as_TagName
   Returns 		: 1 = Success -1 = Unsucess
   Description : Called to do any processing with the column before appying or saving it. 
   Author		: ZMC
   Created on 	: Add timestamp here
   Modified by : Add Author here	TimeStamp
				
///////////////////////////////////////////////////////// */

Int li_ReturnValue = 1
String ls_TagName 

ls_TagName = as_TagName

CHOOSE CASE ls_TagName
		
	CASE "SHIPMENTTYPE"
		// Do something
		
	CASE "SHIPNOTE"
		n_cst_setting_shipnoteformat	lnv_ShipnoteFormat
		lnv_ShipnoteFormat = CREATE n_cst_setting_shipnoteformat
		IF lnv_shipnoteFormat.of_GetValue ( ) = lnv_ShipnoteFormat.cs_individual THEN
			n_cst_NoteManager lnv_NoteManager
			lnv_NoteManager = CREATE n_cst_NoteManager
			lnv_NoteManager.of_Setcontext(anv_shipment,"SHIPNOTE")
			lnv_NoteManager.of_Addnote(aa_value)
			Destroy(lnv_NoteManager)			
			li_ReturnValue = 0
		ELSE
			anv_shipment.of_SetShipmentComments ( aa_value )
		END IF
		
		DESTROY(lnv_ShipnoteFormat)

	CASE "STATUS", "DISPATCHSTATUS"
		IF anv_Shipment.of_changeStatus ( String ( aa_Value ) , anv_Dispatch ) <> 1 THEN
			li_ReturnValue = -1
		END IF
			
END CHOOSE

Return li_ReturnValue
end function

public function boolean wf_undochangesprocesslayer (string as_tagname);Boolean lb_ReturnValue

Long ll_Found

String ls_TagName
String ls_SQL
String ls_Value

ls_TagName = as_Tagname

CHOOSE CASE ls_TagName
	CASE "SHIPNOTE"
		IF wf_CheckforShipnoteFormat() = "INDIVIDUAL" THEN
			ls_SQL = dw_psr1.GetSQLSelect( )
			ls_Value = '"ds_ship_comment"'
			ll_Found = Pos ( ls_SQL,ls_Value)
			IF ll_Found > 0 THEN
				lb_ReturnValue = TRUE
			END IF
		END IF
END CHOOSE	

Return lb_ReturnValue
end function

private function n_cst_bso_Dispatch wf_getdispatch ();IF NOT isValid ( inv_dispatch ) THEN
	inv_dispatch = CREATE n_cst_bso_Dispatch
END IF

RETURN inv_dispatch
end function

private function integer wf_preprocessdata (n_cst_beo_shipment anv_shipment, string as_tag, ref any aa_value, long al_row);int	li_Return = 1
n_cst_beo_Shipment	lnv_Shipment
n_cst_shipmentManager	lnv_ShipmentManager

lnv_Shipment = anv_shipment

CHOOSE CASE Upper ( as_tag )
	CASE "REF1TEXT"		
		lnv_Shipment.of_setref1text(  String( aa_value ) ) 
		lnv_SHipmentManager.of_ValidateRef1Text ( lnv_Shipment ) 
		
	// added this for issue 2514
	CASE "REF2TEXT"		
		lnv_Shipment.of_setref2text(  String( aa_value ) ) 
		
	// added this for issue 2514	
	CASE "REF3TEXT"		
		lnv_Shipment.of_setref3text(  String( aa_value ) ) 
		
	CASE "PICKUPNUMBER"
		lnv_Shipment.of_Setpickupnumber( String( aa_value ) )
		
	CASE "PICKUPBYDATE"
		lnv_Shipment.of_SetPickupByDATE ( Date ( aa_value ) ) 

	CASE "PICKUPBYTIME"
		lnv_Shipment.of_SetPICKUPBYTIME ( Time ( aa_value ) )
		
	CASE "DELBYTIME"
		lnv_Shipment.of_SetDELBYTIME ( Time ( aa_value ) )	
		
	CASE "DELBYDATE"
		lnv_Shipment.of_SetDELBYDATE ( Date ( aa_value ) )

	CASE "LASTFREEDATE"  
		lnv_Shipment.of_Setlastfreedate (Date(aa_value))
	
	CASE "BOOKING"
		lnv_Shipment.of_SetBookingNumber ( String ( aa_value ) ) 
		
	CASE "PRENOTEBY"
		lnv_Shipment.of_SetPreNoteBy ( String ( aa_value ) ) 
		
	CASE "ARRIVEDBY"
		lnv_Shipment.of_SetArrivedBy ( String ( aa_value ) )	
				
	CASE "GROUNDEDBY"
		lnv_Shipment.of_SetGroundedBy ( String ( aa_value ) ) 
		
	CASE "RELEASEBY"
		lnv_Shipment.of_SetRELEASEBY ( String ( aa_value ) )
		
	CASE "RELEASEDATE"
		lnv_Shipment.of_SetRELEASEDATE ( Date ( aa_value ) )

	CASE "RELEASETIME"
		lnv_Shipment.of_SetRELEASETIME ( Time ( aa_value ) ) 	
		
	CASE "DELBYBY"
		lnv_Shipment.of_SetDELBYBY ( String ( aa_value ) )

	CASE "EMPTYATCUSTOMERBY"
		lnv_Shipment.of_setemptyatcustomerby ( String ( aa_value ) ) 
		
	CASE "PICKUPBYBY"
		lnv_Shipment.of_SetPICKUPBYBY ( String ( aa_value ) )
		
	CASE "CUTOFFBY"
		lnv_Shipment.of_SetCUTOFFBY ( String ( aa_value ) )
		
	CASE "LFDBY"
		lnv_Shipment.of_SetLFDBY ( String ( aa_value ) )
		
	CASE "RAILBILLEDBY"
		lnv_Shipment.of_setRAILBILLEDBY ( String ( aa_value ) )
		
	CASE "BOOKINGNUMBERBY"
		lnv_Shipment.of_SetBOOKINGNUMBERBY ( String ( aa_value ) )
		
	CASE "ETABY"
		lnv_Shipment.of_SetETABY ( String ( aa_value ) )
		
	CASE "PICKUPNUMBERBY"
		lnv_Shipment.of_SetPickupNumberBy ( String ( aa_value ) )
		
	CASE "LOADEDATCUSTOMERBY"
		lnv_Shipment.of_setLoadedAtCustomerBy ( String ( aa_value ) )
		
	CASE "RAILBILLNUMBER"
		lnv_Shipment.of_setRAILBILLNUMBER( String ( aa_value ) )
		
	CASE "STATUS", "DISPATCHSTATUS"
		IF anv_Shipment.of_changeStatus ( String ( aa_Value ) , inv_Dispatch ) <> 1 THEN
			li_Return = -1
		END IF
		
	CASE "SHIPNOTE"
		THIS.wf_Processlayerforsave( as_tag , anv_shipment, inv_dispatch , aa_value )
		
//		dw_psr2.SetItem(al_Row,"ds_Ship_Comment",aa_value)
		
		
CASE ELSE 
		lnv_Shipment.event ue_setvalueany( as_tag , aa_value )
		
END CHOOSE


RETURN li_Return


/*  no special processing needed

CASE "SCHEDULEDDELIVERYDATE" 
		//li_Return = THIS.of_SetScheduledDeliveryDate ( Date ( aa_value ) ) 												
		
	CASE "DATEPICKEDUP"
		//li_Return = THIS.of_SetDatePickedUp ( Date ( aa_value ) ) 						

	CASE "DATEDELIVERED"
		//li_Return = THIS.of_SetDateDelivered ( Date ( aa_value ) )			
		
	CASE "CUTOFFDATE"
		//li_Return = THIS.of_SetCutOffDate (Date(aa_value))
		
	CASE "ARRIVALDATE" , "ARRIVEDDATE"
		//li_Return = THIS.of_Setarrivaldate (Date(aa_value)) 																								
		
																												

	 												

	CASE "FREIGHTCHARGES"
		//li_Return = This.of_SetFreightCharges(Dec(aa_value ))				
		
	CASE "DISCOUNTAMOUNT"
		//li_Return = This.of_setDiscountAmount(Dec(aa_value ))	
		
	CASE "DISCOUNTPERCENT"
		//li_Return = This.of_SetDiscountPercent(Dec(aa_value ))				
		
	CASE "ACCESSORIALCHARGES"
		//li_Return = This.of_SetAccessorialAmount(Dec(aa_value ))
		
	CASE "NETCHARGES"
		//li_Return = This.of_SetNetCharge(Dec(aa_value))

	CASE "PAYABLES" 
		//li_Return = THIS.of_SetPayableTotal ( Dec ( aa_value ) ) 								

	CASE "FREIGHTPAYABLES" 
		//li_Return = THIS.of_SetFreightPayable ( Dec ( aa_value ) ) 								

	CASE "ACCESSORIALPAYABLES" 
		//li_Return = THIS.of_SetAccessorialPayable ( Dec ( aa_value ) ) 											

	CASE "COMMISSIONS" 
		//li_Return = THIS.of_SetSalesCommission ( Dec ( aa_value ) ) 

/*------------------			String */			

	CASE "STATUS", "DISPATCHSTATUS"  // it is assumed that the change has been validated prior to making this call
		//li_Return = This.of_setStatus ( String ( aa_value ) )	

	CASE "PREPAIDCOLLECT"
		//li_Return = This.of_setPrePaidCollect ( String ( aa_value ) )	
		
	CASE "INVOICENUMBER"
		//li_Return = This.of_SetInvoiceNumber ( String ( aa_value ) )	
		
	CASE "HAZMAT"
		//li_Return = This.of_SetHazmat(String(aa_value ))	
		
	CASE "EXPEDITE"
		//li_Return = This.of_SetExpedite(String(aa_value ))	

	CASE "BILLINGSTATUS"
		//li_Return = THIS.of_SetStatus ( String ( aa_value ) ) 			

	CASE "BILLNOTE"
		//li_Return = THIS.of_SetBillingComments ( String ( aa_value ) ) 			
		
	CASE "SHIPNOTE"  
		//li_Return = THIS.of_SetShipmentComments ( String ( aa_value ) ) 			
		
	CASE "MODLOG"
		//li_Return = THIS.of_SetModLog ( String ( aa_value ) ) 			
		
	CASE "REF1TEXT"
		//li_Return = THIS.of_SetRef1Text ( String ( aa_value ) ) 
		
	CASE "REF2TEXT"
		//li_Return = THIS.of_SetRef2Text ( String ( aa_value ) ) 
		
	CASE "REF3TEXT"
		//li_Return = THIS.of_SetRef3Text ( String ( aa_value ) ) 
		
	CASE "POD" 
		//li_Return = THIS.of_SetPOD ( String ( aa_value ) )						

	CASE "REQUIREDEQUIPMENT"
		//li_Return = THIS.of_SetRequiredEquipment (String(aa_value))

	CASE "CUSTOM1"
		//li_Return = THIS.of_SetValue ("CUSTOM1",String(aa_value))
		
	CASE "CUSTOM2"
		//li_Return = THIS.of_SetValue ("CUSTOM2",String(aa_value))
		
	CASE "CUSTOM3"
		//li_Return = THIS.of_SetValue ("CUSTOM3",String(aa_value))			
		
	CASE "CUSTOM4"
		//li_Return = THIS.of_SetValue ("CUSTOM4",String(aa_value))
		
	CASE "CUSTOM5"
		//li_Return = THIS.of_SetValue ("CUSTOM5",String(aa_value))
		
	CASE "CUSTOM6"
		//li_Return = THIS.of_SetValue ("CUSTOM6",String(aa_value))
		
	CASE "CUSTOM7"
		//li_Return = THIS.of_SetValue ("CUSTOM7",String(aa_value))			
		
	CASE "CUSTOM8"
		//li_Return = THIS.of_SetValue ("CUSTOM8",String(aa_value))
		
	CASE "CUSTOM9"
		//li_Return = THIS.of_SetValue ("CUSTOM9",String(aa_value))
		
	CASE "CUSTOM10"
		//li_Return = THIS.of_SetValue ("CUSTOM10",String(aa_value))
		
	CASE "MOVETYPE"
		//li_Return = THIS.of_Setmovetype (String(aa_value))
		
	CASE "ORIGINPORT"
		//li_Return = THIS.of_SetOriginPort (String(aa_value))
		
	CASE "DESTINATIONPORT"
		//li_Return = THIS.of_SetDestinationPort (String(aa_value))
		
	CASE "LINE"
		//li_Return = THIS.of_Setline (String(aa_value))
		
	CASE "VESSEL"
		//li_Return = THIS.of_SetVessel (String(aa_value))
		
	CASE "VOYAGE", "FLIGHT"
		//li_Return = THIS.of_SetVoyage (String(aa_value))			
		
	CASE "BOOKING"
		//li_Return = THIS.of_SetBookingNumber ( String ( aa_value ) ) 
		
	CASE "SEAL"
		//li_Return = THIS.of_SetSeal ( String ( aa_value ) ) 

	CASE "MASTERBL", "MAWB"
		//li_Return = THIS.of_Setmasterbl ( String ( aa_value ) ) 			
		
	CASE "HOUSEBL", "HAWB"
		//li_Return = THIS.of_Sethousebl ( String ( aa_value ) ) 			
		
	CASE "FORWARDERREF"
		//li_Return = THIS.of_Setforwarderref ( String ( aa_value ) ) 			
		
	CASE "AGENTREF"
		//li_Return = THIS.of_Setagentref ( String ( aa_value ) ) 			
		
	CASE "DISPATCHEDBY"
		//li_Return = THIS.of_SetDispatchedBy ( String ( aa_value ) ) 						
		
	CASE "IMPORTREFERENCE"
		//li_Return = THIS.of_SetImportReference ( String ( aa_value ) ) 
		
	CASE "BILLTOBYREF"
		//li_Return = THIS.of_SetBillTobyref( String ( aa_value ) )
		
/*------------------			Integer */

	CASE "ORIGINID"
		//li_Return = This.of_SetOrigin ( Integer ( aa_value ) )	
		//use this id to get company info
		
	CASE "TOTALMILES"
		//li_Return = This.of_SetTotalMiles ( Integer ( aa_value ) )	
		
	CASE "REF1TYPE"   //This is the raw column value
		//li_Return = THIS.of_SetRef1Type ( Integer ( aa_value ) ) 

	CASE "REF2TYPE"   //This is the raw column value
		//li_Return = THIS.of_SetRef2Type ( Integer ( aa_value ) ) 
		
	CASE "REF3TYPE"   //This is the raw column value
		//li_Return = THIS.of_SetRef3Type ( Integer ( aa_value ) ) 

/*------------------			Long */			

	CASE "SHIPMENTTYPE"  
		//li_Return = This.of_setType ( Long ( aa_value ) )				

	CASE "DESTINATIONID"
		//li_Return = This.of_SetFinalDestination ( Long ( aa_value ) )	
		//use this id to get company info
		
	CASE "BILLTOID"
		//li_Return = This.of_SetBillTo ( Long ( aa_value ) )	
		//use this id to get company info
		
	CASE "CARRIERID"
		//li_Return = This.of_SetCarrier ( Long ( aa_value ) )	
		
	CASE "TOTALWEIGHT"
		//li_Return = This.of_SetTotalWeight ( Long ( aa_value ) )	

	CASE "SHIPTYPEID"
		//li_Return = THIS.of_SetType ( Long ( aa_value ) ) 			
		
	CASE "PARENTID" //(Split Billing Parent)
		//li_Return = THIS.of_SetParentId (Long(aa_value))

	CASE "FORWARDERID"
		//li_Return = THIS.of_Setforwarder ( Long ( aa_value ) ) 			

	CASE "AGENTID"
		//li_Return = THIS.of_Setagent ( Long ( aa_value ) ) 			

/*------------------			Time */						

	CASE "SCHEDULEDPICKUPTIME" 
		//li_Return = THIS.of_SetScheduledPickupTime ( Time ( aa_value ) ) 									

	CASE "SCHEDULEDDELIVERYTIME" 
		//li_Return = THIS.of_SetScheduledDeliveryTime ( Time ( aa_value ) ) 															

	CASE "TIMEPICKEDUP"
		//li_Return = THIS.of_SetTimePickedUp ( Time ( aa_value ) )
		
	CASE "TIMEDELIVERED"
		//li_Return = THIS.of_SetTimeDelivered ( Time ( aa_value ) )			

	CASE "CUTOFFTIME"
		//li_Return = THIS.of_SetCutOffTime (Time(aa_value)) 																					

	CASE "ARRIVALTIME" , "ARRIVEDTIME"
		//li_Return = THIS.of_Setarrivaltime (Time(aa_value)) 																								

	CASE "LASTFREETIME"
		//li_Return = THIS.of_Setlastfreetime (Time(aa_value)) 																											
		
		
	// added for intermodal shipment

/*------------------			String */						

																			

	CASE "PRENOTEUSER"
		//li_Return = THIS.of_SetPRENOTEUSER ( String ( aa_value ) ) 																		
		
	 																		
		
	CASE "ETAUSER"
		//li_Return = THIS.of_SetETAuser ( String ( aa_value ) ) 																					
		
	 																								
		
	CASE "ARRIVEDUSER"
		//li_Return = THIS.of_SetArrivedUser ( String ( aa_value ) ) 																											
		
																															
		
	CASE "GROUNDEDUSER"
		//li_Return = THIS.of_SetGROUNDEDUSER ( String ( aa_value ) ) 																																	
																																
		
																																		
		
	CASE "PICKUPNUMBERUSER"
		//li_Return = THIS.of_SetPICKUPNUMBERUSER ( String ( aa_value ) ) 																																				
		
	 																																							
		
	CASE "BOOKINGNUMBERUSER"
		//li_Return = THIS.of_SetBOOKINGNUMBERUSER ( String ( aa_value ) ) 

	 																																													
		
	CASE "RELEASEUSER"
		//li_Return = THIS.of_SetRELEASEUSER ( String ( aa_value ) ) 																																																
		
	 																																																			
		
	CASE "LFDUSER"
		//li_Return = THIS.of_SetLFDUser ( String ( aa_value ) ) 																																																						

	 																																																															
		
	CASE "PICKUPBYUSER"
		//li_Return = THIS.of_SetPICKUPBYUSER ( String ( aa_value ) ) 																																																																		

	 																																																																											
		
	CASE "DELBYUSER"
		//li_Return = THIS.of_SetDELBYUSER ( String ( aa_value ) ) 																																																																														
		
	 																																																																																	
		
	CASE "CUTOFFUSER"
		//li_Return = THIS.of_SetCUTOFFUSER ( String ( aa_value ) ) 																																																																																				

																																																																																											
		
	CASE "EMPTYATCUSTOMERUSER"
		//li_Return = THIS.of_setEMPTYATCUSTOMERUSER ( String ( aa_value ) ) 																																																																																													

	 																																																																																																						

	CASE "LOADEDATCUSTOMERUSER"
		//li_Return = THIS.of_setLOADEDATCUSTOMERUSER( String ( aa_value ) ) 																																																																																																									
		
	 																																																																																																												
		
	CASE "RAILBILLNUMBERUSER"
		//li_Return = THIS.of_setRAILBILLNUMBERUSER ( String ( aa_value ) ) 																																																																																																															

	 																																																																																																																					
		
	CASE "RAILBILLEDUSER"
		//li_Return = THIS.of_setRAILBILLEDUSER ( String ( aa_value ) ) 																																																																																																																					
		
	CASE "MOVECODE"
		//li_Return = This.of_SetMoveCode ( String ( aa_value ) ) 
		
/*------------------			Date */									

	CASE "PRENOTEDATE"
		//li_Return = THIS.of_SetPreNoteDate  ( Date ( aa_value ) ) 															
		
	CASE "ETADATE"
		//li_Return = THIS.of_SetETADate  ( Date ( aa_value ) ) 																		
		
	CASE "GROUNDEDDATE"
		//li_Return = THIS.of_SetGROUNDEDDATE ( Date ( aa_value ) ) 																														
		
	 																																													

																																																										

	 																																																																					

	CASE "EMPTYATCUSTOMERDATE"
		//li_Return = THIS.of_setemptyatcustomerdate ( Date ( aa_value ) ) 																																																																																				

	CASE "LOADEDATCUSTOMERDATE"
		//li_Return = THIS.of_setLOADEDATCUSTOMERDATE( Date ( aa_value ) ) 																																																																																																

	CASE "RAILBILLEDDATE"
		//li_Return = THIS.of_setRAILBILLEDDATE ( Date ( aa_value ) ) 																																																																																																																		
		
/*------------------			Time */												

	CASE "PRENOTETIME"
		//li_Return = THIS.of_SetPrenoteTime  ( Time ( aa_value ) ) 																		

	CASE "ETATIME"
		//li_Return = THIS.of_SetETATime  ( Time ( aa_value ) ) 																					

	CASE "GROUNDEDTIME"
		//li_Return = THIS.of_SetGROUNDEDTIME ( Time ( aa_value ) ) 																																	
		
																																															
		
	 																																																												
		
	 																																																																								

	CASE "EMPTYATCUSTOMERTIME"
		//li_Return = THIS.of_setemptyatcustomerTime ( Time ( aa_value ) ) 																																																																																							
		
	CASE "LOADEDATCUSTOMERTIME"
		//li_Return = THIS.of_setLOADEDATCUSTOMERTIME( Time ( aa_value ) ) 																																																																																																			
		

// 	Will not be called as per RZ.		
//		CASE "ADJUSTEDNETCHARGES" 
//			aa_Value = This.of_GetAdjustedNetCharges ( )

// 	Will not be called as per RZ.		
//		CASE "SETTLEMENTPAY" 
//			aa_Value = This.of_GetSettlementPay ( )
			
// 	Will not be called as per RZ.		
//		CASE "REF1LABEL"  //This is the display value
//			//li_Return = THIS.of_SetRef1Label( String ( aa_value ) ) 																																																																																																			

// 	Will not be called as per RZ.					
//		CASE "REF2LABEL"  //This is the display value
//			//li_Return = THIS.of_SetRef2Label( String ( aa_value ) ) 																																																																																																			

// 	Will not be called as per RZ.					
//		CASE "REF3LABEL"  //This is the display value
//			//li_Return = THIS.of_SetRef3Label( String ( aa_value ) ) 																																																																																																			

// 	Will not be called as per RZ.		
//		CASE "BLNUMBERS"
//		//li_Return = This.of_SetBLNumbers ( String ( aa_value ) )	


// Will not be called as per RZ
//		CASE "EVENTCOUNT" 
//			aa_Value = This.of_GetEventCount ( )

//		CASE "CONFIRMEDEVENTCOUNT" 
//			aa_Value = This.of_GetConfirmedEventCount ( )

//		CASE "UNCONFIRMEDEVENTCOUNT" 
//			//li_Return = THIS.of_UnconfirmEvent () 			

//		CASE "ITEMCOUNT" 
//			aa_Value = This.of_GetItemCount ( )


////////


CASE "INVOICEDATE"
		//li_Return = THIS.of_SetInvoiceDate ( Date ( aa_value ) ) 
		
CASE "SHIPDATE"
		//li_Return = THIS.of_SetShipdate ( Date ( aa_value ) ) 		
		
CASE "AVAILABLEON"
		//li_Return = THIS.of_SetAvailableOn ( Date ( aa_value ) ) 									
	
CASE "AVAILABLEUNTIL"
		//li_Return = THIS.of_SetAvailableUntil ( Date ( aa_value ) )		
		
		
*/		
end function

private function integer wf_checkforpreprocess (long al_row, dwobject adwo_value);Int	li_Return


RETURN li_Return
end function

on w_multishipupdate.create
int iCurrent
call super::create
this.dw_psr2=create dw_psr2
this.cb_undo=create cb_undo
this.rb_replace=create rb_replace
this.rb_append=create rb_append
this.st_2=create st_2
this.cb_save=create cb_save
this.cb_apply=create cb_apply
this.st_1=create st_1
this.dw_psr1=create dw_psr1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_psr2
this.Control[iCurrent+2]=this.cb_undo
this.Control[iCurrent+3]=this.rb_replace
this.Control[iCurrent+4]=this.rb_append
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_apply
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.dw_psr1
end on

on w_multishipupdate.destroy
call super::destroy
destroy(this.dw_psr2)
destroy(this.cb_undo)
destroy(this.rb_replace)
destroy(this.rb_append)
destroy(this.st_2)
destroy(this.cb_save)
destroy(this.cb_apply)
destroy(this.st_1)
destroy(this.dw_psr1)
end on

event open;call super::open;cb_Help.visible = FALSE
ib_Isupdateable = False

//// Display the window on top left
This.X = 1
This.Y = 1

THIS.SetRedraw ( FALSE )
Any la_value
Long ll_return = 1
String ls_PsrFile
String		ls_test
String		ls_coltype
Datawindow	ldw_source

Long			ll_index
Long			ll_max
Long			ll_maxRows
Long			ll_findIndex

s_Parm	 lstr_parm

n_cst_Msg 							lnv_Msg
n_cst_settings						lnv_settings
n_cst_ShipmentManager			lnv_ShipmentManager
n_cst_Presentation_Shipment	lnv_Presentation

lnv_msg = Message.PowerObjectParm

// Resizing the window
THIS.of_SetResize ( TRUE ) 
inv_Resize.of_Register (dw_psr1 		,pfc_n_cst_resize.SCALERIGHT)
inv_Resize.of_Register (dw_psr2 		,pfc_n_cst_resize.SCALERIGHTBOTTOM)
inv_Resize.of_Register (rb_append 	,pfc_n_cst_resize.FIXEDRIGHT)		
inv_Resize.of_Register (rb_replace 	,pfc_n_cst_resize.FIXEDRIGHT)		
inv_Resize.of_Register (cb_apply		,pfc_n_cst_resize.FIXEDRIGHT)		
inv_Resize.of_Register (cb_save		,pfc_n_cst_resize.FIXEDRIGHT)		
inv_Resize.of_Register (cb_undo		,pfc_n_cst_resize.FIXEDRIGHT)		
//inv_Resize.of_setminsize( 3442, 1948)

IF lnv_msg.of_Get_parm ( "TARGET_IDS", lstr_Parm) <> 0 THEN
	ila_ShipID[] = lstr_Parm.ia_Value
ElseIF lnv_msg.of_Get_parm ( "TARGET_ID", lstr_Parm) <> 0 THEN
	ila_ShipID[1] = lstr_Parm.ia_Value 
ELSE
	MessageBox("Multi Shipment Update", "Open Failed. No Shipment ID in message")
	ll_return = -1
End If



THIS.wf_GetDispatch( ).of_RetrieveShipments( ila_ShipID )
inv_Shipment = CREATE n_cst_beo_Shipment
inv_Shipment.of_SetSource  ( inv_dispatch.of_GetShipmentcache( ) )
inv_Shipment.of_SetEventSource( inv_dispatch.of_geteventcache( ) )
inv_Shipment.of_SetItemSource( inv_dispatch.of_getItemcache( ) )
inv_Shipment.of_SetContext ( inv_Dispatch )
inv_Shipment.of_SetAllowFilterSet ( TRUE ) 

lnv_settings.of_GetSetting(159,la_value)
ls_PsrFile = String(la_value)

if fileexists(ls_PsrFile) then
	//For DW - 1
	dw_Psr1.DataObject = ls_PsrFile
	dw_Psr1.SetTransObject(SQLCA)
	dw_Psr1.InsertRow(0)
	lnv_ShipmentManager.of_PopulateReferenceLists (dw_Psr1)
	lnv_Presentation.of_SetPresentation (dw_Psr1)
	
	//For DW - 2
	IF UpperBound(ila_ShipID) > 0 THEN
		dw_Psr2.DataObject = ls_PsrFile
		dw_Psr2.SetTransObject(SQLCA)
		dw_Psr2.Retrieve(ila_ShipID)
		lnv_ShipmentManager.of_PopulateReferenceLists (dw_Psr2)
		lnv_Presentation.of_SetPresentation (dw_Psr2)
	END IF
	
	//added by dan to maintain the sort of the object that we selected items from--------
	ll_max = upperbound( ila_shipID )
	ll_maxRows = dw_psr2.rowCount()
	ls_test = dw_psr2.describe("#1.tag")
	ls_colType = dw_psr2.describe("#1.coltype")
	IF ls_test <> "!" AND ll_maxRows >  0 AND ls_colType = "long" THEN
		FOR ll_index = 1 TO ll_max
			ll_findIndex = dw_psr2.find( "ds_id = "+string(ila_shipID[ll_index]), 1, ll_maxRows )
			IF ll_findIndex > 0 THEN
				dw_psr2.rowsMove( ll_findIndex, ll_findIndex, PRIMARY!,dw_psr2, ll_index, PRIMARY!)
				//MessageBox("Moving", string(ll_findIndex)+" To "+string(ll_index)+ " id:"+string(ila_shipID[ll_index]))
			END IF
		NEXT
	END IF
	//---------------------------------------------
	THIS.SetRedraw ( TRUE )
else
	messagebox("Multi Shipment Update", "The file psr file '" + ls_psrfile + "' was not found.  " +&
					"Please create the file or change the system setting if the file is in a new location.")
	close(this)	
end if


end event

event pfc_close;call super::pfc_close;DESTROY inv_Dispatch
DESTROY inv_Shipment
end event

event closequery;call super::closequery;//functionality added by Dan 1-6-2006
Int	li_result
N_cst_privileges inv_privs
IF isValid ( inv_dispatch ) THEN
	IF inv_privs.of_hasentryrights( ) AND inv_Dispatch.event pt_updatespending( ) = 1 THEN
		li_result = MessageBox("Save", "Do you want to save modifications?", Question!, yesno!)
		IF li_result = 1 THEN
			dw_psr1.accepttext()
			dw_psr2.accepttext()
			event ue_save( )
		END IF
	END IF
END IF
end event

type cb_help from w_response`cb_help within w_multishipupdate
integer x = 3287
integer y = 1592
end type

type dw_psr2 from u_dw_shipinfo within w_multishipupdate
integer x = 41
integer y = 468
integer width = 3314
integer taborder = 70
string dataobject = ""
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;call super::retrieveend;Int li_Ctr
String ls_SQL
String ls_Value
Long ll_Found

IF wf_CheckforShipnoteFormat() = "INDIVIDUAL" THEN
	ls_SQL = This.GetSQLSelect( )
	ls_Value = '"ds_ship_comment"'
	ll_Found = Pos ( ls_SQL,ls_Value)
	
	IF ll_Found > 0 THEN
		For li_Ctr = 1 TO RowCount
			This.SetItem(li_Ctr,"ds_Ship_Comment","")
		NEXT
	END IF
	
END IF
	
	
end event

event constructor;call super::constructor;ib_RmbMenu = FALSE
end event

event itemchanged;///////////////////OverRiding ancestor script

//isa_ColArray[UpperBound(isa_ColArray) + 1] = dwo.name

Int li_ReturnValue = 1

Any la_Value

Long ll_ShipmentID	
Long	ll_CacheRow

//String ls_ColName
//String ls_ColType
String ls_TagName
String ls_dw_psr2Value
Boolean lb_Continue = TRUE
Boolean lb_AppendChecked
Boolean lb_AppendReplaceAction

dwBuffer	le_Buffer
DataStore		lds_ShipmentCache

dw_psr2.AcceptText()

lb_AppendChecked = wf_CheckForAppend()

lds_ShipmentCache = inv_dispatch.of_getshipmentcache( )
inv_Shipment.of_SetSource ( lds_ShipmentCache )
la_Value = Data

ll_ShipmentID = dw_Psr2.GetItemnumber( Row , "ds_id" )
IF ll_ShipmentID > 0 THEN		
	inv_Shipment.of_SetSourceID ( ll_ShipmentID )
ELSE
	lb_continue = FALSE
END IF	
	
IF lb_Continue THEN
	//ls_ColName = dwo.name
	//ls_ColType = dwo.ColType
	ls_TagName = dwo.tag		
			
	wf_ProcessLayerForApply(lb_AppendChecked,ls_TagName,lb_AppendReplaceAction) // lb_AppendReplaceAction : True = Append, False = Replace
	
	//mod by dan 1-7-2006, commented out condition so that you can clear a single rows data
	//IF Not IsNull (Data ) THEN
		Parent.wf_Preprocessdata( inv_Shipment , ls_TagName, la_Value , row )
	//END IF

END IF

IF lb_Continue THEN
	inv_Shipment.of_GetSourcerow( ll_CacheRow, le_Buffer, FALSE )
	
	IF ll_CacheRow > 0 THEN
		dw_psr2.SetRedraw(FALSE)
		IF lds_ShipmentCache.RowsCopy( ll_CacheRow, ll_CacheRow, le_Buffer , dw_Psr2, row , PRIMARY! ) = 1 THEN
			dw_Psr2.DeleteRow( row + 1)
		END IF
		dw_psr2.SetRedraw(TRUE)
	END IF
END IF 

IF NOT lb_Continue THEN
	MessageBox ( "Update Shipment" , "An error occurred while attempting to alter the shipment data." )
END IF



end event

event ue_getdispatchmanager;call super::ue_getdispatchmanager;RETURN Parent.wf_GetDispatch ( )
end event

event ue_getshipment;call super::ue_getshipment;Long	ll_Row

ll_Row = THIS.GetRow ( )

IF ll_Row > 0 THEN
	inv_Shipment.of_SetSourceRow ( ll_Row )
END IF

RETURN inv_Shipment

end event

event wheel_vcroll;Message.Processed = FALSE
end event

event scrollhorizontal;call super::scrollhorizontal;dw_psr1.Object.DataWindow.HorizontalScrollPosition  =  scrollPos
end event

event itemfocuschanged;call super::itemfocuschanged;String	ls_Tag
String	ls_Target
Int		li_Pos
String	ls_Value
String	ls_Companyname
Long		ll_CoID

ls_Tag =  dwo.Tag

n_Cst_beo_Company	lnv_Company

IF left ( ls_Tag , 1 ) = "#" THEN
	
	li_Pos = Pos ( ls_Tag , ';' )
	IF li_Pos > 0 THEN
		ls_Target = Mid ( ls_Tag , li_pos + 1 , len ( Trim ( ls_tag ) )  )
		ls_Tag = Mid ( ls_Tag , 2 , li_Pos - 2 )
	END IF
	
		
	CHOOSE CASE Upper ( ls_Tag )
			
		CASE "COMPANYLOOKUP"
									
			lnv_Company = gnv_cst_companies.of_select( "" )
			IF isValid ( lnv_Company ) THEN // should be
				ls_Companyname	= lnv_Company.of_Getname ( )
				ll_CoID = lnv_Company.of_GetId( )
				
				THIS.SetItem ( row , ls_Target , ll_CoID )
				isa_ColArray[UpperBound(isa_ColArray) + 1] = dwo.name
				ib_Applied = FALSE
				cb_apply.Enabled = TRUE
				THIS.AcceptText ( )
							
			END IF
							
			
	END CHOOSE
	
	
END IF

RETURN AncestorReturnValue


end event

type cb_undo from commandbutton within w_multishipupdate
boolean visible = false
integer x = 2336
integer y = 28
integer width = 466
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Undo Changes"
end type

event clicked;event ue_undo( )
end event

type rb_replace from radiobutton within w_multishipupdate
integer x = 2935
integer y = 384
integer width = 416
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Replace Text"
boolean checked = true
end type

type rb_append from radiobutton within w_multishipupdate
integer x = 2437
integer y = 384
integer width = 471
integer height = 76
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Append &Text"
end type

type st_2 from statictext within w_multishipupdate
integer x = 41
integer y = 400
integer width = 741
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "S&hipment(s) to be modified."
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_multishipupdate
integer x = 3090
integer y = 28
integer width = 261
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Save"
end type

event clicked;N_cst_privileges inv_privs

IF inv_privs.of_hasentryrights( ) THEN
	dw_psr1.accepttext()
	dw_psr2.accepttext()
	event ue_save( )
ELSE
	MEssageBox("Save", "You do not have sufficient rights, save unsuccessful", EXCLAMATION!)
END IF

end event

type cb_apply from commandbutton within w_multishipupdate
integer x = 2816
integer y = 28
integer width = 261
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Apply"
end type

event clicked;event ue_apply()
THIS.Enabled = FALSE

end event

type st_1 from statictext within w_multishipupdate
integer x = 46
integer y = 64
integer width = 1783
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Enter new values. The values will be applied to all shipments in the list."
boolean focusrectangle = false
end type

type dw_psr1 from u_dw within w_multishipupdate
integer x = 41
integer y = 132
integer width = 3314
integer height = 232
integer taborder = 40
boolean hscrollbar = true
boolean vscrollbar = false
end type

event constructor;call super::constructor;ib_RmbMenu = FALSE

end event

event itemchanged;call super::itemchanged;isa_ColArray[UpperBound(isa_ColArray) + 1] = dwo.name
ib_Applied = FALSE
cb_apply.Enabled = TRUE

IF data = "" THEN
	return 0
END IF

end event

event itemerror;call super::itemerror;Long ll_Return
String ls_ColumnType
Date ld_Test
Time lt_Test

n_cst_String lnv_String 

ll_Return = AncestorReturnValue 

IF Upper ( String ( dwo.type ) )  = "COLUMN" THEN
	ls_ColumnType = dwo.colType
	
	CHOOSE CASE UPPER ( ls_ColumnType )
			
		CASE  "DATE" 
			ld_test = lnv_string.of_SpecialDate(data)
					
			if not isnull(ld_test) then
				this.setitem(row, String ( dwo.name ), ld_test)
				ll_Return = 3
			end if
			
			IF len(trim(data)) = 0 THEN
				
				setNull(data)
			END IF
			
			IF isNull( data ) THEN
				this.setItem(row, String( dwo.name ), ld_test )
				ll_return = 2
			END IF
			
		CASE "TIME"
			lt_Test = lnv_string.of_SpecialTime(data)
			if not isnull(lt_Test) then
				this.setitem(row, String ( dwo.name ), lt_Test)
				ll_Return = 3
			end if		
			
			IF len(trim(data)) = 0 THEN
				setNull(data)
			END IF
			
			IF isNull( data ) THEN
				this.setItem(row, String( dwo.name ), lt_test)
				ll_return = 2
			END IF
	END CHOOSE
END IF
isa_ColArray[UpperBound(isa_ColArray) + 1] = dwo.name

IF ll_Return = 3 THEN
	ib_Applied = FALSE
	cb_apply.Enabled = TRUE
END IF

Return ll_Return

end event

event scrollhorizontal;call super::scrollhorizontal;dw_psr2.Object.DataWindow.HorizontalScrollPosition  =  scrollPos
end event

event buttonclicked;call super::buttonclicked;CHOOSE CASE Upper ( dwo.name )
		
	CASE "CB_FUELSURCHARGE" 
		IF MessageBox ( "Recalculate FSC" , "Are you sure you want to recalculate the FSC for all of the shipments listed?" , QUESTION!, YESNO!, 1 ) = 1 THEN
			event ue_recalcfuelcurcharge( )
		END IF
END CHOOSE


end event

event itemfocuschanged;call super::itemfocuschanged;String	ls_Tag
String	ls_Target
Int		li_Pos
String	ls_Value
String	ls_Companyname
Long		ll_CoID

ls_Tag =  dwo.Tag

n_Cst_beo_Company	lnv_Company

IF left ( ls_Tag , 1 ) = "#" THEN
	
	li_Pos = Pos ( ls_Tag , ';' )
	IF li_Pos > 0 THEN
		ls_Target = Mid ( ls_Tag , li_pos + 1 , len ( Trim ( ls_tag ) )  )
		ls_Tag = Mid ( ls_Tag , 2 , li_Pos - 2 )
	END IF
	
		
	CHOOSE CASE Upper ( ls_Tag )
			
		CASE "COMPANYLOOKUP"
									
			lnv_Company = gnv_cst_companies.of_select( "" )
			IF isValid ( lnv_Company ) THEN // should be
				ls_Companyname	= lnv_Company.of_Getname ( )
				ll_CoID = lnv_Company.of_GetId( )
				
				
				THIS.SetItem ( row , dwo.name , ls_Companyname )
				THIS.SetItem ( row , ls_Target , ll_CoID )
				
				isa_ColArray[UpperBound(isa_ColArray) + 1] = ls_Target
				isa_ColArray[UpperBound(isa_ColArray) + 1] = dwo.name
				ib_Applied = FALSE
				cb_apply.Enabled = TRUE
				
				THIS.Accepttext( )
					
			END IF
							
			
	END CHOOSE
	
	
END IF

RETURN AncestorReturnValue
end event

