$PBExportHeader$w_tirselection.srw
$PBExportComments$[w_response]
forward
global type w_tirselection from w_response
end type
type cb_ok from u_cb within w_tirselection
end type
type dw_companies from u_dw within w_tirselection
end type
type cb_cancel from u_cb within w_tirselection
end type
type st_start from u_st within w_tirselection
end type
type st_end from u_st within w_tirselection
end type
type cbx_check from u_cbx within w_tirselection
end type
type sle_start from u_sle_date within w_tirselection
end type
type sle_end from u_sle_date within w_tirselection
end type
end forward

global type w_tirselection from w_response
int X=1056
int Y=32
int Width=1888
int Height=2316
boolean TitleBar=true
string Title="TIR Report "
long BackColor=80269524
cb_ok cb_ok
dw_companies dw_companies
cb_cancel cb_cancel
st_start st_start
st_end st_end
cbx_check cbx_check
sle_start sle_start
sle_end sle_end
end type
global w_tirselection w_tirselection

type variables
private:
n_ds	ids_Equipment
end variables

forward prototypes
private function integer wf_mainprocess ()
private function integer wf_retrieveselectedids (ref long ala_co_id[])
private function integer wf_sendtir (long ala_company[])
private function integer wf_savedocument (ref long ala_shipmentid[], ref n_cst_emailmessage anv_emailmessage)
public function integer wf_setallrowschecked (string as_Y_N)
end prototypes

private function integer wf_mainprocess ();//
/***************************************************************************************
NAME			: wf_MainProcess
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: 					

lds_Results (d_tir_equipment) used to retrieve equipment for each company and it's facilities
A filter is set after the first retrieve to remove null sites to avoid duplication
the rows are copied from lds_results to ids_Equipment 
ids_equipment (d_tir_equipment) is used to hold equipment for review and confirm

Records older than 14 days will be disgarded
					
REVISION		: RDT 110702
***************************************************************************************/
String	lsa_ExcludeEquipmentType[], &
			ls_ErrorString

Integer	li_Return, &
			i

Long		ll_RowCount, &
			ll_EquipCount, &
			ll_Count, &
			lla_Company_IDs[]
			
blob 		lblob_dwstate

Date		ldt_OldestReportingDate, &
			ldt_RecordDate

// create objects 
n_cst_equipmentmanager lnv_EquipMan
n_cst_Msg lmsg
s_parm lstr_parm

n_ds lds_Results
lds_Results = Create n_ds
lds_Results.DataObject = "d_tir_equipment"
lds_Results.SetTransObject(SQLCA)

// set defaults
lsa_ExcludeEquipmentType[1] = lnv_EquipMan.cs_cntn      
lsa_ExcludeEquipmentType[2] = lnv_EquipMan.cs_chas		 

li_Return = 1

ldt_OldestReportingDate = RelativeDate(Today(), -14)   // records older than 14 days will be disgarded

ll_Count = This.wf_RetrieveSelectedIDs( lla_Company_IDs ) 
If ll_Count < 1 Then 
	MessageBox("TIR Report Error", "Please select at least 1 company.")
	li_Return = -1
	ll_EquipCount = 0
End IF

If li_Return = 1 then 
	// process each company individually
	For i = 1 to ll_Count
		ll_EquipCount = lds_Results.Retrieve(lla_Company_IDs[ i ] , Date(sle_start.text), Date(sle_end.text), lsa_ExcludeEquipmentType )  // retrieve equipment	
										 
		If ll_EquipCount > 0 Then 
			lds_Results.RowsCopy(1, lds_Results.RowCount(), Primary!, ids_Equipment, 1, Primary!)
			// set the filter to remove null sites for all subsequent retrieves
			String ls_Filter	= "Not isNull( " + "originationsite" + ")"
			lds_Results.SetFilter(ls_Filter)
			lds_Results.Filter()
		End If
		
	Next
	ll_EquipCount = ids_Equipment.RowCount()
End If

If ll_EquipCount > 0 Then 
	// loop thru rows and record errors in comp_note column
	FOR ll_Count = 1 to ll_EquipCount

		// check for records that do not have dates and are too old to report on
		If IsNull( ids_Equipment.inv_Base.of_GetItem( ll_Count, "originationdate" ) ) OR &
			IsNull( ids_Equipment.inv_Base.of_GetItem( ll_Count, "terminationdate" ) )		  Then 
			ldt_RecordDate = Date(ids_Equipment.inv_Base.of_GetItem( ll_Count, "timestamp" ) )
			if ldt_RecordDate < ldt_OldestReportingDate Then 
				CONTINUE			/*skip this row*/
			end if 
		End If

		ls_ErrorString = ''
		// check Origin Site type
		if ids_Equipment.inv_Base.of_GetItem( ll_Count, "origintermloc" ) <> "T" Then 
			
			ls_ErrorString = ls_ErrorString +  " Origination site is not a Termination location."
		end if
		
		// check Termination Site type 
		if ids_Equipment.inv_Base.of_GetItem( ll_Count, "destintermloc" ) <> "T" Then 
			
			ls_ErrorString = ls_ErrorString +  " Termination Site is not a Termination Location."
		end if

		// check for Origin Date without an Origin Site 
		if IsNull( ids_Equipment.inv_Base.of_GetItem( ll_Count, "originationsite" ) )  AND & 
			NOT IsNull( ids_Equipment.inv_Base.of_GetItem( ll_Count, "originationdate" ) ) Then 
				
				ls_ErrorString = ls_ErrorString +  " Origination Date has no Site."
		end if

		// check for Origin Site without an Origin Date 
		if IsNull( ids_Equipment.inv_Base.of_GetItem( ll_Count, "originationdate" ) )  AND & 
			NOT IsNull( ids_Equipment.inv_Base.of_GetItem( ll_Count, "originationsite" ) ) Then 
				
				ls_ErrorString = ls_ErrorString +  " Origination Site has no Date."
		end if

		// check for Termination Date without a Termination Site
		if IsNull( ids_Equipment.inv_Base.of_GetItem( ll_Count, "terminationsite" ) )  AND & 
			NOT IsNull( ids_Equipment.inv_Base.of_GetItem( ll_Count, "terminationdate" ) ) Then 
				
				ls_ErrorString = ls_ErrorString + " Termination Date has no Site."
		end if

		// check for Termination Site without a Termination Date
		if IsNull( ids_Equipment.inv_Base.of_GetItem( ll_Count, "terminationdate" ) )  AND & 
			NOT IsNull( ids_Equipment.inv_Base.of_GetItem( ll_Count, "terminationsite" ) ) Then 
				
				ls_ErrorString = ls_ErrorString + " Termination Site has no Date."
		end if
		
		// populate notes column
		ids_Equipment.inv_Base.of_SetItem( ll_Count, "computed_note", ls_ErrorString )

	NEXT

	// Report to User results and ask for confirmation to send. 
	if ids_Equipment.getFullState(lblob_dwstate) = -1 then 
		messageBox("wf_MainProcess error","GetFullState failed")
	else
		lstr_Parm.is_Label = "dw"
		lstr_Parm.ia_Value = lblob_dwstate
		lmsg.of_add_parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "title"
		lstr_Parm.ia_Value = "TIR Review and Confirm"
		lmsg.of_add_parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "message1"
		lstr_Parm.ia_Value = "Please review and click OK to continue,"
		lmsg.of_add_parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "message2"
		lstr_Parm.ia_Value = "or click Cancel to stop the process."
		lmsg.of_add_parm ( lstr_Parm )
		
		OpenWithParm(w_Review_confirm, lmsg )
		if Message.StringParm = "OK" Then 
			wf_SendTIR( lla_Company_IDs )
		else 
			MessageBox("TIR Report","Process canceled by user. Notices were not sent.")	
		end if
	end if

Else
	MessageBox("TIR Report ","No equipment records exist for date range of " + sle_start.text + " to " + sle_end.text) 
	li_Return = 0 // no rows in array
End If



// Destroy objects
Destroy lds_Results 


Return li_Return 
end function

private function integer wf_retrieveselectedids (ref long ala_co_id[]);//
/***************************************************************************************
NAME			: wf_RetrieveSelectedIDs
ACCESS		: Private 
ARGUMENTS	: Long [] (ala_ID[] by reference)
RETURNS		: Integer (Number of Id's found or -1 if Failed)
DESCRIPTION	: Loops thru checked datawindow rows and gets company ids
				  The facilities are accounted for in d_tir_equipment.

REVISION		: RDT 110702
***************************************************************************************/

Integer	li_Return 

Long		ll_RowCount, &
			ll_count, &
			ll_Companyid

ll_RowCount = dw_Companies.RowCount( )		
li_Return = -1

For ll_Count = 1 to ll_RowCount 
	If dw_Companies.GetItemString(ll_Count, "typechecked" ) = "Y" Then 
		ll_Companyid ++
		ala_Co_Id[ ll_Companyid ] = dw_Companies.GetItemNumber( ll_Count, "companies_co_id" )	
	End if
	li_Return = ll_Companyid 	
Next

Return li_Return 
end function

private function integer wf_sendtir (long ala_company[]);//
/***************************************************************************************
NAME			: of_sendtir

ACCESS		: Private 

ARGUMENTS	: Long[]	 (company id's to report on)
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: 
Get only one companies (originationsite) rows. (Filter by company id)
Set Column names on report datawindow 
Move data to report datawindow
Save the datawindow as text without headers. The headers are added as data to maintain alignment.

Read text file and send to contact id via notification manager

ll_Space = Long( lds_Report.object.{column name}.edit.limit ) is used to space and align the columns and
				is based on the edit limit of the column
	
NOTE: This will only work on Windows based systems. 
REVISION		: RDT 110702
				  RDT 6-11-03 Changed to write to a file in line mode. 
				  This will remove the tabs to keep data from wrapping.
***************************************************************************************/
String 	ls_Filter, &
			ls_FileName, &
			ls_EmailBody, &
			ls_FileContents, &
			ls_EmailAddress, &
			ls_temp

Integer	li_Return, &
			li_IDCount, &
			li_MaxIDCount, &
			li_RowCount, & 
			li_ColCount, & 
			li_MaxRowcount, &
			li_FileNumber, &
			li_ReportRow, &
			i, &
			c

Long		ll_FileLength, &
			ll_NumberofReads, &
			ll_ShipmentId[], &
			ll_Spaces, &
			ll_Characterlimit

SetPointer(HourGlass!)

// create objects
n_ds lds_report
lds_report = create n_ds
lds_report.Dataobject='d_ext_tirreport'
lds_report.of_SetBase(TRUE)

n_ds 	lds_TIRContact
lds_TIRContact	= create n_ds
lds_TIRContact.Dataobject='d_tir_contacts'
lds_TIRContact.OF_SetTransObject(SQLCA)
lds_TIRContact.of_SetBase(TRUE)

n_cst_EmailMessage lnv_EmailMessage 							// autoinstantiated

n_cst_bso_Email_Manager lnv_EmailManager
lnv_EmailManager = create n_cst_bso_Email_Manager 

// set defaults
ls_FileName = "c:\TIR.TXT"

// loop thru ids_equipment and filter by company and it's Facilities 
li_MaxIDCount = UpperBound( ala_company[] )

For li_IDCount = 1 to li_MaxIDCount 
	li_Return = 1
	lds_report.Reset()
	ls_EmailBody = ""

	ls_Filter = "origincompanyid = "+  String(ala_company[ li_IDCount ]) + " OR origincompanyfacilityid = " + String(ala_company[ li_IDCount ])	  
	ids_Equipment.SetFilter( ls_Filter )
	ids_Equipment.Filter()

	If ids_Equipment.RowCount() > 0 Then 
		// move data
		li_MaxRowCount = ids_Equipment.RowCount() 

		For li_RowCount = 1 to li_MaxRowCount 
			li_ReportRow = lds_Report.InsertRow(0)

			ll_Spaces = Long( lds_Report.object.equipment.edit.limit ) - Len( Trim( ids_Equipment.inv_base.of_GetItem( li_RowCount, "eq_ref" ) ) ) 
			lds_Report.inv_Base.of_SetItem(li_ReportRow, "equipment",   ids_Equipment.inv_base.of_GetItem( li_RowCount, "eq_ref" ) + Space(ll_Spaces) )

			ll_Spaces = Long( lds_Report.object.shipment.edit.limit ) - Len( Trim( ids_Equipment.inv_base.of_GetItem( li_RowCount, "shipment" ) ) )
			lds_Report.inv_Base.of_SetItem(li_ReportRow, "shipment",   	ids_Equipment.inv_base.of_GetItem( li_RowCount, "shipment" )+ Space(ll_Spaces) )

			ll_Characterlimit = Long( lds_Report.object.origin.edit.limit ) 
			ll_Spaces = Long( lds_Report.object.origin.edit.limit ) - Len( Trim( ids_Equipment.inv_base.of_GetItem( li_RowCount, "origincompany" ) ) ) 
			ls_Temp = ids_Equipment.inv_base.of_GetItem( li_RowCount, "origincompany" )+ Space(ll_Spaces) 
			//lds_Report.inv_Base.of_SetItem(li_ReportRow, "origin",  	   ids_Equipment.inv_base.of_GetItem( li_RowCount, "origincompany" )+ Space(ll_Spaces) )
			lds_Report.inv_Base.of_SetItem(li_ReportRow, "origin", Left( ls_Temp, ll_Characterlimit  ) )
			
			ll_Spaces = Long( lds_Report.object.origin_date.edit.limit ) - Len( Trim( ids_Equipment.inv_base.of_GetItem( li_RowCount, "originationdate" ) ) ) 
			lds_Report.inv_Base.of_SetItem(li_ReportRow, "origin_date",  	   ids_Equipment.inv_base.of_GetItem( li_RowCount, "originationdate" )+ Space(ll_Spaces) )

			// remove seconds 
			ls_temp = String( ids_Equipment.inv_base.of_GetItem( li_RowCount, "originationtime" ) )
			ls_temp = left( ls_Temp, Len ( ls_temp ) - 3 )
			ll_Spaces = Long( lds_Report.object.origin_time.edit.limit ) - Len( Trim( ls_temp ) )  
			lds_Report.inv_Base.of_SetItem(li_ReportRow, "origin_time",   ls_temp + Space(ll_Spaces) )

			ll_Characterlimit = Long( lds_Report.object.termination.edit.limit ) 
			ll_Spaces = Long( lds_Report.object.termination.edit.limit ) - Len( Trim( ids_Equipment.inv_base.of_GetItem( li_RowCount, "terminatecompany" ) ) )
			ls_Temp = ids_Equipment.inv_base.of_GetItem( li_RowCount, "terminatecompany" )+ Space(ll_Spaces) 
//			lds_Report.inv_Base.of_SetItem(li_ReportRow, "termination", ids_Equipment.inv_base.of_GetItem( li_RowCount, "terminatecompany" )+ Space(ll_Spaces) )
			lds_Report.inv_Base.of_SetItem(li_ReportRow, "termination", Left( ls_Temp, ll_Characterlimit  ) )
			
			ll_Spaces = Long( lds_Report.object.term_date.edit.limit ) - Len( Trim( ids_Equipment.inv_base.of_GetItem( li_RowCount, "terminationdate" ) ) ) 
			lds_Report.inv_Base.of_SetItem(li_ReportRow, "term_date",   ids_Equipment.inv_base.of_GetItem( li_RowCount, "terminationdate" )+ Space(ll_Spaces) )

			// remove seconds 
			ls_temp = String( ids_Equipment.inv_base.of_GetItem( li_RowCount, "terminationtime" ) )
			ls_temp = left( ls_Temp, Len ( ls_temp ) - 3 )
			ll_Spaces = Long( lds_Report.object.term_time.edit.limit ) - Len( Trim( ls_temp  ) ) 
			lds_Report.inv_Base.of_SetItem(li_ReportRow, "term_time",   ls_temp + Space(ll_Spaces) )


			ll_ShipmentID[li_RowCount] = long( ids_Equipment.inv_base.of_GetItem( li_RowCount, "shipment" ) )
		Next
		lds_Report.Sort()
		
		// The Headers are added as row 1 data to maintain column alignment
		li_ReportRow = lds_Report.InsertRow(1)
		//dw_1.Object.emp_name.Width
		ll_Spaces = Long( lds_Report.object.equipment.edit.limit ) - Len( "Equipment" ) 
		lds_Report.inv_Base.of_SetItem(li_ReportRow, "equipment",  "Equipment" + Space(ll_Spaces) )

		ll_Spaces = Long( lds_Report.object.shipment.edit.limit ) - Len( "Shipment" )
		lds_Report.inv_Base.of_SetItem(li_ReportRow, "shipment", "Shipment" + Space(ll_Spaces) )

		ll_Spaces = Long( lds_Report.object.origin.edit.limit ) - Len( "Origination" ) 
		lds_Report.inv_Base.of_SetItem(li_ReportRow, "origin", "Origination" + Space(ll_Spaces) )
		
		ll_Spaces = Long( lds_Report.object.origin_date.edit.limit ) - Len( "Date" ) 
		lds_Report.inv_Base.of_SetItem(li_ReportRow, "origin_date", "Date" + Space(ll_Spaces) )
		
		ll_Spaces = Long( lds_Report.object.origin_time.edit.limit ) - Len( "Time" ) 
		lds_Report.inv_Base.of_SetItem(li_ReportRow, "origin_time", "Time" + Space(ll_Spaces) )

		ll_Spaces = Long( lds_Report.object.termination.edit.limit ) - Len( "Termination" ) 
		lds_Report.inv_Base.of_SetItem(li_ReportRow, "termination", "Termination" + Space(ll_Spaces) )
		
		ll_Spaces = Long( lds_Report.object.term_date.edit.limit ) - Len( "Date" ) 
		lds_Report.inv_Base.of_SetItem(li_ReportRow, "term_date", "Date" + Space(ll_Spaces) )
		
		ll_Spaces = Long( lds_Report.object.term_time.edit.limit ) - Len( "Time" ) 
		lds_Report.inv_Base.of_SetItem(li_ReportRow, "term_time", "Time" + Space(ll_Spaces) )
		

		// save the dw as text
		// lds_Report.SaveAs(ls_FileName , TEXT!, FALSE) //RDT 6-11-03  

		//RDT 6-11-03  Write to file - Start
		/*		loop thru all rows and each column and copy to the string.
			write string to file */
		li_FileNumber = FileOpen(ls_FileName, LineMode!, Write!, LockWrite!, Replace!)
		li_RowCount   = lds_Report.RowCount() 
		li_ColCount	  = Integer( lds_Report.Describe("DataWindow.Column.Count" ) )
		
		For i = 1 to li_RowCount
			
			ls_FileContents = ""
			
			for c = 1 to li_ColCount	  
				ls_FileContents = ls_FileContents + lds_Report.inv_Base.of_GetItem( i , c )
			next 
			
			FileWrite(li_FileNumber, ls_FileContents )
			
		Next		
		FileClose( li_FileNumber )
		//RDT 6-11-03  - End 
		

		// set subject
		lnv_EmailMessage.of_SetSubject ( "TIR Report From " + sle_start.Text + " to " + sle_end.Text  )

		// get and set the company code 
		If Len( ids_Equipment.inv_base.of_GetItem( 1, "co_code_name" ) ) < 1 Then 
			lnv_EmailMessage.of_SetCompanyCode( Left( ids_Equipment.inv_base.of_GetItem( 1, "origincompany" ),5 ) )
		Else
			lnv_EmailMessage.of_SetCompanyCode( ids_Equipment.inv_base.of_GetItem( 1, "co_code_name" ) )
		End If
		
		// read file and insert into body of email.
		ll_FileLength = FileLength(ls_FileName )
		li_FileNumber = FileOpen( ls_FileName , StreamMode! )

		If ll_FileLength < 32767 Then 
			ll_NumberofReads = 1
		Else
			ll_NumberofReads = Ceiling ( ll_FileLength / 32767 )
		End If

		For i = 1 to ll_NumberofReads 		// files larger than 32767, require more than one read. 
			FileRead( li_FileNumber, ls_FileContents) 
			ls_EmailBody += ls_FileContents 
		Next
		lnv_EmailMessage.of_SetBody( ls_EmailBody )  

		// get & set the contact email address
		lds_TIRContact.Retrieve( ala_company[ li_IDCount ] )
		lnv_emailmessage.of_resettargetaddresses ( )		
		
		For i = 1 to lds_TIRContact.RowCount()
			ls_EmailAddress = lds_TIRContact.inv_base.of_GetItem( i, "ct_emailaddress" )
			If Len(ls_EmailAddress ) > 0 then 
				lnv_EmailMessage.of_addtargetaddress ( ls_EmailAddress )
			Else
				Messagebox("Send TIR ","No Contact Address for " + ids_Equipment.inv_base.of_GetItem( li_RowCount, "origincompany" ) +"~nEmail not sent" )
				li_Return = -1 
			End If
		Next
		
		lnv_EmailMessage.of_IsEmail ( True )
		
		// send it via email manager
		If li_Return = 1 then 
				
			li_Return = lnv_EmailManager.of_SendMail ( lnv_EmailMessage )    // send email
			If li_Return = 1 then 												
				This.wf_SaveDocument( ll_ShipmentID[], lnv_EmailMessage )	  // save document
			Else
				MessageBox("Program Error","Error Sending Email message.")
				li_Return = -1
			End If
		End if
			
		// Delete file
		FileClose( li_FileNumber )
	 	If NOT FileDelete(ls_FileName)  then 
			MessageBox("File Delete Error in w_tirSelection.wf_Sendtir","File "+ ls_FileName +" was not deleted.")
		End If

	End If
	
Next

// destroy objects
If IsValid( lds_report ) 		 Then Destroy lds_report 
If IsValid( lnv_EmailManager ) Then Destroy lnv_EmailManager 
If IsValid( lds_TIRContact) 	 Then Destroy lds_TIRContact

Return li_Return 
end function

private function integer wf_savedocument (ref long ala_shipmentid[], ref n_cst_emailmessage anv_emailmessage);//
/***************************************************************************************
NAME			: wf_Savedocument
ACCESS		: Private 
ARGUMENTS	: Long[]	 (Shipment IDs be reference)
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: sa

REVISION		: RDT 110702
***************************************************************************************/

Integer	li_Return , &
			li_Count
Long		ll_Blank[]

// create objects
n_cst_bso_document_manager lnv_Document_Man
lnv_Document_Man = Create n_cst_bso_document_manager 

// set defaults
anv_emailmessage.of_setdocumenttype ( lnv_Document_Man.cs_TIR  )

If UpperBound( ala_shipmentid[] ) > 0 then 
	For  li_Count = 1 to UpperBound( ala_shipmentid[] )
			lnv_Document_Man.of_SaveDocument ( anv_EmailMessage, ala_shipmentid[li_Count] )
	Next
End if

ala_shipmentid[] = ll_Blank[]  // reset shipment array to blank


// destroy ojbects
If IsValid( lnv_Document_Man ) Then Destroy lnv_Document_Man 

Return li_Return 
end function

public function integer wf_setallrowschecked (string as_Y_N);//
/***************************************************************************************
NAME			: of_SetAllRowsChecked
ACCESS		: public
ARGUMENTS	: String 	(Y or N)
RETURNS		: integer (number of rows checked)
DESCRIPTION	: marks all rows as Y or N 

REVISION		: RDT 092602
***************************************************************************************/
integer 	li_Counter, &
			li_RowCount

as_Y_N = Upper( as_Y_N )

li_RowCount = dw_companies.RowCount()

For li_Counter = 1 to li_RowCount
	dw_companies.SetItem(li_Counter, "Typechecked", as_Y_N)
Next

Return li_Rowcount
end function

on w_tirselection.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.dw_companies=create dw_companies
this.cb_cancel=create cb_cancel
this.st_start=create st_start
this.st_end=create st_end
this.cbx_check=create cbx_check
this.sle_start=create sle_start
this.sle_end=create sle_end
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.dw_companies
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.st_start
this.Control[iCurrent+5]=this.st_end
this.Control[iCurrent+6]=this.cbx_check
this.Control[iCurrent+7]=this.sle_start
this.Control[iCurrent+8]=this.sle_end
end on

on w_tirselection.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.dw_companies)
destroy(this.cb_cancel)
destroy(this.st_start)
destroy(this.st_end)
destroy(this.cbx_check)
destroy(this.sle_start)
destroy(this.sle_end)
end on

event open;call super::open;// do not allow add/edit/delete on dw
ib_disableclosequery = TRUE							// No Updates allowed in this window. 


// check User/Group privileges
n_cst_Privileges lnv_Privileges

If lnv_Privileges.of_HasTIRLFDRights() Then 

	//Enable the Resize Service
	This.of_SetResize ( TRUE )
	
	//Set size so that proper alignment will be kept when opening as layered (full screen)
	inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
	inv_Resize.of_SetMinSize ( 1300, 400 )
	
	//Register Resizable controls
	inv_Resize.of_Register ( dw_Companies, 'FixedtoRight&Bottom' )
	inv_Resize.of_Register ( sle_start,		'FixedtoRight&Bottom' )
	inv_Resize.of_Register ( sle_end,		'FixedtoRight&Bottom' )
	inv_Resize.of_Register ( cb_cancel, 	'FixedtoRight&Bottom' )
	inv_Resize.of_Register ( cb_ok, 			'FixedtoRight&Bottom' )
	inv_Resize.of_Register ( st_end, 		'FixedtoRight&Bottom' )
	inv_Resize.of_Register ( st_start,		'FixedtoRight&Bottom' )
	inv_Resize.of_Register ( cbx_check, 	'FixedtoRight&Bottom' )
	// set sort service on datawindow
	dw_Companies.of_SetSort(FALSE)
	
	// set row selection on List datawindow
	//dw_Companies.of_SetRowSelect ( TRUE ) 
	//dw_Companies.inv_rowselect.of_SetStyle ( 0 ) 
	
	// set the default dates
	sle_start.text = String(RelativeDate(today(), - 2),"mm/dd/yy")
	sle_end.text = String(today(),"mm/dd/yy")
	
	ids_equipment = Create n_ds
	ids_equipment.DataObject = 'd_tir_equipment'
	ids_equipment.of_SetBase(TRUE)
Else	
	MessageBox("TIR Report ",lnv_Privileges.of_getrestrictmessage ( ) )
	Close (This)
End If

end event

event close;call super::close;If IsValid( ids_equipment ) Then 
	Destroy ( ids_equipment )
End If
end event

event pfc_default;If dw_companies.RowCount() > 0 Then 
	if This.wf_MainProcess() <> 0 then
		Close(This)
	end if
End If

end event

event pfc_cancel;call super::pfc_cancel;Close(This)
end event

type cb_ok from u_cb within w_tirselection
int X=347
int Y=2056
int TabOrder=40
boolean BringToTop=true
string Text="&OK"
boolean Default=true
end type

event clicked;
Parent.TriggerEvent('pfc_Default')
end event

type dw_companies from u_dw within w_tirselection
int X=78
int Y=152
int Width=1737
int Height=1856
int TabOrder=30
boolean BringToTop=true
string DataObject="d_companycontactstir"
boolean HScrollBar=true
end type

event constructor;/*
This datawindow shows Companies with Status = "K" and have contacts.ct_notifyontir rows.
*/

ib_rmbMenu = FALSE

This.SetTransObject(SQLCA)

If This.Retrieve() < 1 then 
	MessageBox("TIR Report","There are no Companies with TIR contacts.")
Else
	Parent.wf_SetAllRowsChecked ("Y")
End IF





end event

type cb_cancel from u_cb within w_tirselection
int X=1083
int Y=2060
int TabOrder=50
boolean BringToTop=true
string Text="&Cancel"
boolean Cancel=true
end type

event clicked;
Parent.TriggerEvent('pfc_Cancel')
end event

type st_start from u_st within w_tirselection
int X=443
int Y=68
int Width=261
int Height=60
boolean BringToTop=true
string Text="Start Date:"
end type

type st_end from u_st within w_tirselection
int X=1115
int Y=68
int Width=242
int Height=60
boolean BringToTop=true
string Text="End Date:"
end type

type cbx_check from u_cbx within w_tirselection
int X=96
int Y=60
int Width=311
boolean BringToTop=true
string Text="Check All"
boolean Checked=true
boolean RightToLeft=true
end type

event clicked;
If this.checked = TRUE Then 
	wf_SetAllRowsChecked ("Y")
Else
	wf_SetAllRowsChecked ("N")
End If

end event

type sle_start from u_sle_date within w_tirselection
int X=681
int Y=52
int Width=375
int TabOrder=10
boolean BringToTop=true
end type

type sle_end from u_sle_date within w_tirselection
int X=1349
int Y=52
int Width=375
int TabOrder=20
boolean BringToTop=true
FontCharSet FontCharSet=Ansi!
end type

