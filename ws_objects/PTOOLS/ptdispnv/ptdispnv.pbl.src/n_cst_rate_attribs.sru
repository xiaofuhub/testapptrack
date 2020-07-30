$PBExportHeader$n_cst_rate_attribs.sru
forward
global type n_cst_rate_attribs from nonvisualobject
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//long	sla_ShipmentIds[]
//long	sla_BillToIDs[]
//long 	sla_ids[]
//long 	sl_currentRow
//long	sl_originID
//long	sl_DestinationID
//String	ss_IDType
//n_ds 	sds_selectedRows
////end modification Shared Variables by appeon  20070730
end variables

global type n_cst_rate_attribs from nonvisualobject autoinstantiate
end type

type variables
Private:
n_cst_beo_Item		inv_TargetItem
Long					il_ApplyID

//begin modification Shared Variables by appeon  20070730
long	sla_ShipmentIds[]
long	sla_BillToIDs[]
long 	sla_ids[]
long 	sl_currentRow
long	sl_originID
long	sl_DestinationID
String	ss_IDType
//n_ds 	sds_selectedRows
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public function integer of_setdatastore (datastore ads_datastore)
public function datastore of_getdatastore ()
public function integer of_reset ()
public function integer of_addrow (datastore ads_newrow)
public function integer of_setcurrentrow (long al_currentrow)
public function long of_getcurrentrow ()
public function integer of_deleterow (long al_itemindex)
public function long of_getoriginid ()
public function integer of_setoriginid (long al_originid)
public function integer of_setdestinationid (long al_destinationid)
public function long of_getdestinationid ()
public function integer of_getbilltoids (ref long ala_billtoids[])
public function integer of_setbilltoids (long ala_BilltoIDs[])
public function integer of_setshipmentids (long ala_ShipmentIDs[])
public function integer of_getshipmentids (ref long ala_ShipmentIDS[])
public function integer of_loaddatastorefromfile (string as_filepath)
public function string of_getsystemsettingsfile ()
public function long of_getrowcount ()
public function integer of_settargetitem (n_cst_beo_item anv_item)
public function n_cst_beo_Item of_gettargetitem ()
public function integer of_setapplyid (long al_id)
public function long of_getapplyid ()
end prototypes

public function integer of_setdatastore (datastore ads_datastore);sds_SelectedRows = ads_datastore
RETURN 1
end function

public function datastore of_getdatastore ();n_ds	lds_Temp

IF isValid( sds_SelectedRows ) THEN
	lds_Temp = sds_SelectedRows
ELSE
	sds_SelectedRows = CREATE n_ds
	sds_SelectedRows.dataobject = "d_itemselection"
	
	String	ls_Path
	ls_Path = THIS.of_GetSystemSettingsFile ( )
	IF Len ( ls_Path ) > 0 THEN
		THIS.of_LoadDatastoreFromFile ( ls_Path )
	END IF
	
	lds_Temp = sds_SelectedRows
END IF

RETURN lds_Temp
end function

public function integer of_reset ();RETURN sds_SelectedRows.RESET ( )

end function

public function integer of_addrow (datastore ads_newrow);
n_ds	lds_Temp

lds_Temp = THIS.of_GetDataStore( )

IF IsValid ( lds_Temp ) THEN

	ads_newrow.rowsCopy ( 1,1,PRIMARY!, lds_Temp,lds_Temp.RowCount ( ) + 1 , PRIMARY!  ) 
	THIS.of_SetDataStore ( lds_Temp ) 
	
END IF
Return 1

end function

public function integer of_setcurrentrow (long al_currentrow);

sl_CurrentRow = al_currentrow 

IF al_currentrow > 0 AND al_currentrow <= sds_selectedRows.RowCount () THEN
	
	sds_selectedRows.SetRow( al_currentrow ) 
	sds_selectedRows.SelectRow ( 0 , FALSE )
	sds_selectedRows.SelectRow ( al_currentrow , TRUE )
END IF

RETURN 1

end function

public function long of_getcurrentrow ();RETURN sl_CurrentRow
end function

public function integer of_deleterow (long al_itemindex);Long		ll_Row
String	ls_FindExpression
n_ds		lds_Temp

lds_Temp = THIS.of_GetDataStore ( )
ls_FindExpression = "di_item_id = '" +  String(al_itemindex) + "'"

IF lds_Temp.RowCount( ) > 0 THEN
	ll_Row = lds_Temp.Find ( ls_FindExpression, 1 ,lds_Temp.RowCount( ) )
END IF

IF ll_Row > 0 THEN
	IF lds_Temp.RowsDiscard( ll_Row , ll_Row , PRIMARY! ) = 1 THEN
		THIS.of_SetDataStore ( lds_Temp ) 
	END IF
END IF


Return 1
end function

public function long of_getoriginid ();RETURN sl_OriginID
end function

public function integer of_setoriginid (long al_originid);sl_OriginID = al_OriginID
RETURN 1
end function

public function integer of_setdestinationid (long al_destinationid);sl_DestinationID = al_DestinationID
RETURN 1
end function

public function long of_getdestinationid ();RETURN sl_DestinationID
end function

public function integer of_getbilltoids (ref long ala_billtoids[]);ala_BillToIDs = sla_BilltoIDs[]
Return 1
end function

public function integer of_setbilltoids (long ala_BilltoIDs[]);sla_BilltoIDs = ala_BilltoIDs
Return 1
end function

public function integer of_setshipmentids (long ala_ShipmentIDs[]);sla_ShipmentIDs = ala_ShipmentIDs
Return 1
end function

public function integer of_getshipmentids (ref long ala_ShipmentIDS[]);ala_ShipmentIDs = sla_ShipmentIDs
Return 1
end function

public function integer of_loaddatastorefromfile (string as_filepath);Long	ll_Row
Int	li_importReturn
Int	li_returnValue = 1

String	ls_Title = "Rate File Location"
String	ls_PathName 
String 	ls_FileName
String	ls_Extension
String	ls_Filter = "Text Files  (*.txt),*.txt, All Files (*.*),*.*"
Int		li_OpenReturn = -1
Int		li_FileHandle
Int		li_Start
Long		ll_RowCount
String 	ls_Result
Boolean 	lb_GetFileName = TRUE


Datastore	lds_Temp
lds_Temp = CREATE DataStore

lds_Temp.dataObject = "d_itemselection"
n_ds lds_Test


lds_Test = CREATE n_ds
lds_Test.dataObject = "d_itemselection"

lds_Test.of_SetBase ( TRUE )

IF Len ( TRIM ( as_filepath ) )> 0 THEN
	li_FileHandle = FileOpen ( as_filepath, LineMode! )
	IF li_FileHandle = -1 THEN
		MessageBox( "Rate File Location" ,"The file '"+as_filepath+"' could not be accessed. Please locate the file manually.")
	ELSE
		lb_GetFileName = FALSE
		ls_PathName = as_FilePath
	END IF
END IF


IF lb_GetFileName THEN
	n_cst_FileSrvWin32	lnv_FileSrv
	lnv_FileSrv = CREATE n_cst_filesrvwin32
	String	ls_path
	String	ls_Drive
	String	ls_DirPath
	ls_Path = THIS.of_Getsystemsettingsfile( )
	lnv_FileSrv.of_Parsepath( ls_Path, ls_Drive, ls_DirPath, ls_FileName)
	DESTROY ( lnv_FileSrv )
	li_OpenReturn = GetFileOpenName ( ls_title, ls_pathname, ls_filename  , ls_extension , ls_filter ,ls_DirPath  )
	IF li_openReturn = 1 THEN	
		li_FileHandle = FileOpen ( ls_PathName, LineMode! )
	END IF
END IF

	
IF li_FileHandle <> -1 THEN
	fileRead ( li_FileHandle, ls_Result )
	IF UPPER (  MID ( ls_Result , 1 ,10 ) ) = "DI_ITEM_ID" THEN
		li_Start = 2
	ELSE
		li_Start = 1
	END IF
	
	FileClose ( li_FileHandle )
	
	IF Len ( Trim ( ls_PathName ) ) > 0 THEN
		li_ImportReturn = lds_Test.ImportFile (ls_PathName, li_Start, 9999, 1, 9999, 1 ) 
		IF li_ImportReturn > 0 THEN
			FOR ll_Row = 1 TO li_ImportReturn
				lds_Test.RowsCopy ( ll_Row, ll_Row ,  Primary! , lds_Temp , 1,Primary!)
				THIS.of_AddRow( lds_Temp )
				lds_Temp.Reset ( )
			NEXT
			
			ll_RowCount = THIS.of_GetRowCount ( )
			IF ll_RowCount > 0 THEN
				THIS.of_SetCurrentRow ( 1 )				
			END IF
			
		ELSE
			MessageBox ( "File Import" , "An error occurred while attempting to import the selected file.")		
			li_ReturnValue = -1			
		END IF
	END IF
	
ELSE
	IF li_OpenReturn <> 0 THEN
		MessageBox( "Rate File Location" , "An error occurred while attempting to open the specified file.")
		li_ReturnValue = -1
	END IF	
END IF

Destroy lds_Temp
DESTROY lds_Test

Return li_ReturnValue

end function

public function string of_getsystemsettingsfile ();String	ls_Path
Any		la_Path


n_cst_Settings	lnv_Settings

IF lnv_Settings.of_GetSetting ( 62, la_Path ) =  1 THEN
	ls_Path = la_Path
END IF

RETURN ls_Path
end function

public function long of_getrowcount ();Long	ll_RowCount


IF IsValid ( sds_selectedRows ) THEN
	ll_RowCount = sds_selectedRows.RowCount ( )
END IF

RETURN ll_RowCount
end function

public function integer of_settargetitem (n_cst_beo_item anv_item);inv_targetitem = anv_item
RETURN 1
end function

public function n_cst_beo_Item of_gettargetitem ();Return inv_targetitem
end function

public function integer of_setapplyid (long al_id);il_applyid = al_id
RETURN 1
end function

public function long of_getapplyid ();RETURN il_applyid
end function

on n_cst_rate_attribs.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_rate_attribs.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//sds_selectedRows = Create n_ds
//sds_selectedRows.DataObject = "d_itemselection"
//sla_ids = {0}
//sl_CurrentRow = 0
//



end event

