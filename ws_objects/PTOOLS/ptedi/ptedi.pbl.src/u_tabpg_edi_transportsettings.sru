$PBExportHeader$u_tabpg_edi_transportsettings.sru
forward
global type u_tabpg_edi_transportsettings from u_tabpg_edi_gen
end type
type dw_transportsettings from u_dw_ediprofile within u_tabpg_edi_transportsettings
end type
type sle_remotegetlocation from singlelineedit within u_tabpg_edi_transportsettings
end type
type sle_remoteputlocation from singlelineedit within u_tabpg_edi_transportsettings
end type
type st_1 from statictext within u_tabpg_edi_transportsettings
end type
type st_2 from statictext within u_tabpg_edi_transportsettings
end type
type cbx_1 from checkbox within u_tabpg_edi_transportsettings
end type
type st_3 from statictext within u_tabpg_edi_transportsettings
end type
end forward

global type u_tabpg_edi_transportsettings from u_tabpg_edi_gen
string text = "Transport Settings"
event type integer ue_multigetchanged ( string as_data )
event ue_multiputschanged ( string as_data )
dw_transportsettings dw_transportsettings
sle_remotegetlocation sle_remotegetlocation
sle_remoteputlocation sle_remoteputlocation
st_1 st_1
st_2 st_2
cbx_1 cbx_1
st_3 st_3
end type
global u_tabpg_edi_transportsettings u_tabpg_edi_transportsettings

type variables

end variables

forward prototypes
public function integer of_initializeremotepaths ()
public function integer of_setprofilefilter ()
end prototypes

event type integer ue_multigetchanged(string as_data);//here
Int	li_index
Int	li_return = 1
Int	li_max
IF as_data = "T" THEN
//	li_max = dw_profile.rowCount()
//	FOR li_index = 1 to li_max
//		Messagebox( string( dw_profile.getItemNumber(li_index,"companyid" ) ), /*dw_profile.getItemNumber(li_index,"transactionset" )*/"happy" ) 
//	NEXT
	IF dw_profile.rowCount( ) = 0 THEN
		dw_profile.retrieve( il_coid )
		commit;
	END IF
	
	IF dw_profile.rowCount( ) > 0 THEN
		sle_remotegetlocation.enabled = false
		Messagebox( "Get Locations", "Checking this box requires that a get location is specified for each inbound transaction." )
		dw_profile.visible = true
	ELSE
		MEssagebox( "Get Locations", "Transaction profiles must be saved before paths can be set.  Apply changes and retry.", exclamation!)
		li_return = -1
	END IF
ELSE
	sle_remotegetlocation.enabled = true
	IF sle_remoteputlocation.enabled THEN
		dw_profile.visible = false
	END IF
END IF

this.of_setprofilefilter( )

RETURN li_Return
end event

event ue_multiputschanged(string as_data);//here not used currently....may have to be revised...
String	ls_filter
IF as_data = "T" THEN
	sle_remoteputlocation.enabled = false
	Messagebox( "Get Locations", "Checking this box requires that a put location is specified for each outbound transaction." )
	dw_profile.visible = true
ELSE
	sle_remoteputlocation.enabled = true
	IF sle_remotegetlocation.enabled THEN
		dw_profile.visible = false
	END IF
END IF

this.of_setProfilefilter( )
end event

public function integer of_initializeremotepaths ();//Looks through the cached company transactions, if it finds 204, it
//initializes the put sle. If it finds anything else it initializes the
//get sle. 

Int li_return
Long	ll_index
Long	ll_max
Long	ll_transactionSet

String ls_get
String ls_put
int	li_deleteRemote
Long		j
String	ls_inout
String	lsa_gets[]
String	lsa_puts[]

ll_max = dw_profile.rowCount()
FOR ll_index = 1 TO ll_max
	ll_transactionSet = dw_profile.getItemNumber( ll_index, "transactionset")
	
	ls_inout = dw_profile.getItemString( ll_index, "in_out" )
	
	CHOOSE CASE ls_inout
		CASE appeon_constant.cs_transaction_INBOUND
			j = upperBound(lsa_gets)+ 1
			lsa_gets[j] = dw_profile.getItemString( ll_index, "remotepaths")
			IF len(lsa_gets[ j ]) > 0 THEN
				sle_remotegetlocation.text = lsa_gets[j]
			END IF
		CASE appeon_constant.cs_transaction_OUTBOUND
			j = upperBound(lsa_puts)+ 1
			lsa_puts[j] = dw_profile.getItemString( ll_index, "remotepaths")
			IF len( lsa_puts[j] ) > 0 THEN
				sle_remoteputlocation.text = lsa_puts[j]
			END IF
	END CHOOSE

	IF len(sle_remoteputlocation.text) > 0 AND len(sle_remotegetlocation.text) > 0 THEN
		EXIT
	END IF
NEXT

//i need to initialize any new rows to not be null the first time they are inserted,
//if there is a get and put location already set up. THIS WILL HAPPEN THE FIRST TIME
//A CUSTOMER WHO HAD EDI BEFORE WE DID THE OUT BOUND 204s sets up another transaction.
IF len(sle_remoteputlocation.text) > 0 AND len(sle_remotegetlocation.text) > 0 THEN
	FOR ll_index = 1 TO ll_max
		IF isNULL( dw_profile.getitemstring( ll_index,"remotepaths") )THEN
			ls_inout = dw_profile.getItemString( ll_index, "in_out" )
		
			CHOOSE CASE ls_inout
				CASE appeon_constant.cs_transaction_INBOUND
					dw_profile.setItem( ll_index ,"remotepaths", sle_remotegetlocation.text )
				
				CASE appeon_constant.cs_transaction_OUTBOUND
					dw_profile.setItem( ll_index ,"remotepaths", sle_remoteputlocation.text )
			END CHOOSE
		END IF
	NEXT
END IF

IF sle_remotegetlocation.enabled AND sle_remoteputlocation.enabled THEN
	dw_profile.visible = false
ELSE
	this.of_setprofilefilter( )
END IF

Return li_return
end function

public function integer of_setprofilefilter ();Int	li_Return 
IF NOT sle_remotegetlocation.enabled AND NOT sle_remoteputlocation.enabled THEN
	dw_profile.setfilter( "in_out = 'INBOUND' OR in_out = 'OUTBOUND'")
	dw_profile.filter()

ELSEIF NOT sle_remotegetlocation.enabled THEN
	dw_profile.setfilter( "in_out = 'INBOUND'")
ELSEIF NOT sle_remoteputlocation.enabled THEN
	dw_profile.setfilter( "in_out = 'OUTBOUND'")
ELSE
	dw_profile.setFilter("")
END IF
dw_profile.filter()
dw_profile.sort()

return li_return
end function

on u_tabpg_edi_transportsettings.create
int iCurrent
call super::create
this.dw_transportsettings=create dw_transportsettings
this.sle_remotegetlocation=create sle_remotegetlocation
this.sle_remoteputlocation=create sle_remoteputlocation
this.st_1=create st_1
this.st_2=create st_2
this.cbx_1=create cbx_1
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_transportsettings
this.Control[iCurrent+2]=this.sle_remotegetlocation
this.Control[iCurrent+3]=this.sle_remoteputlocation
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cbx_1
this.Control[iCurrent+7]=this.st_3
end on

on u_tabpg_edi_transportsettings.destroy
call super::destroy
destroy(this.dw_transportsettings)
destroy(this.sle_remotegetlocation)
destroy(this.sle_remoteputlocation)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cbx_1)
destroy(this.st_3)
end on

event constructor;call super::constructor;this.post of_initializeRemotePaths()
end event

type dw_profile from u_tabpg_edi_gen`dw_profile within u_tabpg_edi_transportsettings
boolean visible = true
integer x = 78
integer y = 1152
integer width = 2286
integer height = 396
integer taborder = 60
string dataobject = "d_transactionpaths"
boolean vscrollbar = true
boolean border = true
boolean ib_isupdateable = true
end type

event dw_profile::buttonclicked;call super::buttonclicked;//String	ls_path
//Int		li_rtn
//Long		ll_index
//Long		ll_max
//IF row > 0 THEN 
//	
//	li_rtn = 1
//	
//END IF
//
//IF li_rtn = 1 THEN
//	IF dwo.name = "b_browse" THEN
//		li_rtn = GetFolder ( "SEF File Path", ls_path )
//		IF li_rtn = 1 THEN
//			ll_max = this.rowCount()
//			//right now all sef files will be in one place for all transactions.
//			FOR ll_index = 1 TO ll_max
//				this.setItem( ll_index, "seffilepath", ls_path)
//			NEXT
//		END IF
//	END IF
//END IF
end event

event dw_profile::constructor;call super::constructor;Long	ll_rows
Long	ll_index
Long	ll_max
Long	ll_row
N_cst_licenseManager	lnv_manager
this.setTransobject( SQLCA )
ll_rows = this.retrieve( il_coid )	

IF ll_rows = 0 THEN
	//MEssagebox("FTP Locations","There are no currently saved transactions to set up get and put locations for.  Apply your changes, and revisit EDI transport to specify FTP get and put locations.")
	sle_remotegetlocation.text = "Changes must be saved before specifying a get location."
	sle_remoteputlocation.text = "Changes must be saved before specifying a put location."
END IF
//
//
//
//IF ll_rows <= 0 THEN
//
//	
//	//i need to insert an inbound and outbound row for 204, 990, and 997.
//	IF lnv_manager.of_hasedi204license( ) THEN
////		ll_row = this.insertRow( 0 )
////		this.setItem( ll_row, "companyId", il_coid )
////		this.setItem( ll_row, "transactionset", 204 )
////		this.setItem( ll_row, "in_out", "INBOUND" )
////		this.setItemStatus( ll_row, 0, Primary!, Datamodified!)
////		this.setItemStatus( ll_row, 0, Primary!, NOTmodified!)
//		
//		ll_row = this.insertRow( 0 )
//		this.setItem( ll_row, "companyId", il_coid )
//		this.setItem( ll_row, "transactionset", 204 )
//		this.setItem( ll_row, "in_out", "OUTBOUND" )
////		this.setItemStatus( ll_row, 0, Primary!, Datamodified!)
////		this.setItemStatus( ll_row, 0, Primary!, NOTmodified!)
//		
//		ll_row = this.insertRow( 0 )
//		this.setItem( ll_row, "companyId", il_coid )
//		this.setItem( ll_row, "transactionset", 990 )
//		this.setItem( ll_row, "in_out", "INBOUND" )
////		this.setItemStatus( ll_row, 0, Primary!, Datamodified!)
////		this.setItemStatus( ll_row, 0, Primary!, NOTmodified!)
//		
////		ll_row = this.insertRow( 0 )
////		this.setItem( ll_row, "companyId", il_coid )
////		this.setItem( ll_row, "transactionset", 990 )
////		this.setItem( ll_row, "in_out", "OUTBOUND" )
////		this.setItemStatus( ll_row, 0, Primary!, Datamodified!)
////		this.setItemStatus( ll_row, 0, Primary!, NOTmodified!)
//		
//		ll_row = this.insertRow( 0 )
//		this.setItem( ll_row, "companyId", il_coid )
//		this.setItem( ll_row, "transactionset", 997 )
//		this.setItem( ll_row, "in_out", "INBOUND" )
////		this.setItemStatus( ll_row, 0, Primary!, Datamodified!)
////		this.setItemStatus( ll_row, 0, Primary!, NOTmodified!)
//		
////		ll_row = this.insertRow( 0 )
////		this.setItem( ll_row, "companyId", il_coid )
////		this.setItem( ll_row, "transactionset", 997 )
////		this.setItem( ll_row, "in_out", "OUTBOUND" )
//	END IF
//	
//	//insert inbound and outbound row for 214
//	IF lnv_manager.of_hasedi214license( ) THEN
//		ll_row = this.insertRow( 0 )
//		this.setItem( ll_row, "companyId", il_coid )
//		this.setItem( ll_row, "transactionset", 214 )
//		this.setItem( ll_row, "in_out", "INBOUND" )
////		this.setItemStatus( ll_row, 0, Primary!, Datamodified!)
////		this.setItemStatus( ll_row, 0, Primary!, NOTmodified!)
//		
////		ll_row = this.insertRow( 0 )
////		this.setItem( ll_row, "companyId", il_coid )
////		this.setItem( ll_row, "transactionset", 214 )
////		this.setItem( ll_row, "in_out", "OUTBOUND" )
//	END IF
//	
//END IF
//
//this.setSort( "transaction A" )
//this.sort()
//
//

Long	ll_deleteRemotely

ll_max = dw_profile.RowCount()
//if we find one remote delete then they will be deleted.
FOR ll_index = 1 TO ll_max
    ll_deleteRemotely = dw_profile.getItemNumber( ll_index, "deleteremotely")
	 IF ll_deleteRemotely = 1 THEN
			cbx_1.checked = true
	 END IF
NEXT


end event

event dw_profile::itemchanged;call super::itemchanged;//Long	ll_index
//Long	ll_max
//
//IF dwo.name = "ftpdestpath" THEN
//	ll_max = this.rowCount()
//	FOR ll_index = 1 TO ll_max
//		this.setItem( ll_index, "ftpdestpath", data )
//	NEXT
//END IF
end event

type st_title from u_tabpg_edi_gen`st_title within u_tabpg_edi_transportsettings
boolean visible = true
integer x = 146
integer y = 36
integer width = 928
string text = "Profit Tools Edi Transport Settings  "
end type

type tab_1 from u_tabpg_edi_gen`tab_1 within u_tabpg_edi_transportsettings
integer x = 0
integer y = 8
integer width = 3433
end type

type dw_transportsettings from u_dw_ediprofile within u_tabpg_edi_transportsettings
integer x = 27
integer y = 260
integer width = 2542
integer height = 584
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_transportsettings"
end type

event constructor;call super::constructor;Long	ll_dwtransRows
Long	ll_rows
Int	li_rtn
String	ls_multiGets
String	ls_multiputs
this.setTransobject( SQLCA )
ll_rows = this.retrieve( il_coid )

IF ll_rows <= 0 THEN
	li_rtn = this.insertRow( 0 )
	li_rtn = this.setItem( 1, "co_id", il_coid )
	this.setitem(1, "multigets", "F")
	this.setitem(1, "multiputs", "F")
ELSE
	ls_multiGets = this.getItemstring( 1, "multigets")
	IF ls_multiGets = "T" THEN
		dw_profile.visible = true
		sle_remotegetlocation.enabled = false
	END IF
	
	IF isNUll(ls_multiGets ) THEN
		this.setItem(1, "multigets", "F")
	END IF
	
	ls_multiputs = this.getItemstring( 1, "multiputs")
	IF isNULL( ls_multiputs ) THEN
		this.setItem(1, "multiputs", "F")
	END IF
END IF


end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE "multigets"
		IF parent.event ue_multigetchanged( data ) = -1 THEN
			RETURN  2
		END IF
	CASE "multiputs"
		parent.event ue_multiputschanged( data )
		
END CHOOSE
		
end event

event buttonclicked;call super::buttonclicked;Int	li_rtn
String ls_filePath
IF dwo.name = "b_browse" THEN
	li_Rtn = GetFolder("Select a Folder", ls_filepath )
	IF li_rtn > 0 THEN  	 
		this.setItem( 1, "downloadlocation", ls_filePath )
	END IF	
END IF
end event

type sle_remotegetlocation from singlelineedit within u_tabpg_edi_transportsettings
integer x = 640
integer y = 864
integer width = 1595
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;Long	ll_index
Long	ll_max
Long	ll_transactionSet
String	ls_inout

ll_max = dw_profile.RowCount()



IF ll_max = 0 THEN
	ll_max = dw_profile.retrieve(il_coid)
	commit;
	IF ll_max = 0 THEN
		Messagebox( "Remote Get", "There are no transaction profiles saved for this company.  Apply changes, and try again." )
		this.text = ""
	END IF
END IF

FOR ll_index = 1 TO ll_max
	ls_inout = dw_profile.getItemString( ll_index, "in_out" )
	CHOOSE CASE ls_inout
		CASE appeon_constant.cs_transaction_INBOUND
			dw_profile.setItem( ll_index ,"remotepaths", this.text )
		CASE appeon_constant.cs_transaction_OUTBOUND
			//nothing to do here.
	END CHOOSE
NEXT


end event

type sle_remoteputlocation from singlelineedit within u_tabpg_edi_transportsettings
integer x = 640
integer y = 968
integer width = 1595
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;Long	ll_index
Long	ll_max
Long	ll_transactionSet
String	ls_inout
ll_max = dw_profile.RowCount()


IF ll_max = 0 THEN
	ll_max = dw_profile.retrieve(il_coid)
	commit;
	IF ll_max = 0 THEN
		Messagebox( "Remote Put", "There are no transaction profiles saved for this company.  Apply changes, and try again." )
		this.text = ""
	END IF
END IF

String	ls_oldFilter

ls_oldFilter = dw_profile.describe("datawindow.table.filter")
dw_profile.setredraw( false)
dw_profile.setFilter("")
dw_profile.filter()
ll_max = dw_profile.rowCount()
FOR ll_index = 1 TO ll_max
	ls_inout = dw_profile.getItemString( ll_index, "in_out" )
	CHOOSE CASE ls_inout
		CASE appeon_constant.cs_transaction_INBOUND
			//nothing to do here.
		CASE appeon_constant.cs_transaction_OUTBOUND			
			dw_profile.setItem( ll_index ,"remotepaths", this.text )
	END CHOOSE
NEXT
IF ls_oldFilter <>"?" THEN
	dw_profile.setfilter( ls_oldfilter )
	dw_profile.filter()
END IF
dw_profile.sort()
dw_profile.setredraw( true)

end event

type st_1 from statictext within u_tabpg_edi_transportsettings
integer x = 32
integer y = 868
integer width = 594
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Remote Get Location:"
boolean focusrectangle = false
end type

type st_2 from statictext within u_tabpg_edi_transportsettings
integer x = 32
integer y = 980
integer width = 594
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Remote Put Location:"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within u_tabpg_edi_transportsettings
integer x = 1358
integer y = 1072
integer width = 878
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Delete Remote Files After Get"
end type

event clicked;Long	ll_index
Long	ll_max
Long	ll_transactionSet
String	ls_inout

ll_max = dw_profile.RowCount()
//put only applies to the 204 transaction set, so we only want to change everything else for get
FOR ll_index = 1 TO ll_max
    ll_transactionSet = dw_profile.getItemNumber( ll_index, "transactionset")
	
	 IF ll_transactionSet = 204 THEN
			IF this.checked THEN
				dw_profile.setItem( ll_index ,"deleteremotely", 1 )	//1 = yes delete
			ELSE
				dw_profile.setItem( ll_index ,"deleteremotely", 0 )	//0 = no don't delete
			END IF
	 END IF
NEXT
end event

type st_3 from statictext within u_tabpg_edi_transportsettings
integer x = 517
integer y = 104
integer width = 1326
integer height = 144
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Note:  All SEF file paths must be specified when Profit Tools is handling the transport."
boolean focusrectangle = false
end type

event constructor;n_cst_Setting_ediTransport lnv_transport
String	ls_value

lnv_transport = CREATE n_cst_Setting_ediTransport

ls_value = lnv_transport.of_getValue()

this.visible = (ls_value = "Yes")

DESTROY lnv_transport
end event

