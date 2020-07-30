$PBExportHeader$u_dw_amounttemplatelist.sru
forward
global type u_dw_amounttemplatelist from u_dw
end type
end forward

global type u_dw_amounttemplatelist from u_dw
int Width=2990
int Height=744
string DataObject="d_dlkc_amounttemplate"
boolean HScrollBar=true
boolean HSplitScroll=true
event ue_import ( )
end type
global u_dw_amounttemplatelist u_dw_amounttemplatelist

event ue_import;//  this is now in the desendent b/c it would not work being implemented here ???
//INT 	li_Column
//Int	li_ColCount
//Long	ll_Row
//Long	ll_NewRow
//Long	ll_RowCount
//Int	li_importReturn
//
//Any	la_Data
//String ls_ColumnName
//
//String	ls_Title = "Template File Location"
//String	ls_PathName = "C:\"
//String 	ls_FileName
//String	ls_Extension
//String	ls_Filter = "Text Files  (*.txt),*.txt, All Files (*.*),*.*"
//Int		li_OpenReturn
//Int		li_FileHandle
//Int		li_Start
//String 	ls_Result
//
//
//n_ds lds_Test
//lds_Test = CREATE n_ds
//
//lds_Test.dataObject = THIS.DataObject
//
//lds_Test.of_SetBase ( TRUE )
//
//li_OpenReturn = GetFileOpenName ( ls_title, ls_pathname, ls_filename  , ls_extension , ls_filter  )
//
//IF li_openReturn = 1 THEN
//	li_FileHandle = FileOpen ( ls_PathName, LineMode! )
//	
//	IF li_FileHandle <> -1 THEN
//	 	fileRead ( li_FileHandle, ls_Result )
//		IF UPPER (  MID ( ls_Result , 1 ,2 ) ) = "ID" THEN
//			li_Start = 2
//		ELSE
//			li_Start = 1
//		END IF
//		FileClose ( li_FileHandle )
//	END IF
//	
//	
//	li_ImportReturn = lds_Test.ImportFile (ls_PathName, li_Start, 9999, 2, 9999, 2 ) 
//	
//	ll_RowCount = lds_Test.rowCount ( )
//	li_ColCount = Integer (lds_Test.Object.DataWindow.Column.Count)
//	
//	FOR ll_Row = 1 TO ll_RowCount 
//		ll_newRow = THIS.InsertRow (0)
//		IF ll_NewRow > 0 THEN
//			FOR li_Column = 2 TO li_ColCount
//				
//				ls_columnname = THIS.Describe ( "#" + String( li_column ) + ".name" )
//				la_Data = lds_Test.inv_BAse.of_getItemAny ( ll_Row , ls_ColumnName )
//				THIS.SetItem ( ll_newRow, "#"+String(li_column) , la_Data )		
//				
//				
//			NEXT 
//		ELSE
//			MessageBox ( "Template Import" , "An error occurred while attempting to import amounts template." )
//			EXIT
//		END IF
//		
//		
//	NEXT
//
//END IF
//
//DESTROY lds_Test
//
end event

event constructor;This.SetUILink ( TRUE )
inv_UILink.SetClass ( "n_cst_beo_AmountTemplate" )
inv_UILink.SetDLK ( "n_cst_dlkc_AmountTemplate" )
This.of_SetTransObject ( SQLCA )
This.SetUseTaskRetrieve ( FALSE )

n_cst_Presentation_amountTemplate	lnv_Presentation
n_cst_presentation_amounttype lnv_presentationamounttype

lnv_Presentation.of_SetPresentation ( This )

lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_payables)
lnv_presentationamounttype.of_setpresentation(this)

This.of_SetAutoSort ( TRUE )
//This.of_SetAutoFind ( TRUE )
//
////Instantiate the default row focus indicator
//This.Event ue_SetFocusIndicator ( TRUE )
end event

