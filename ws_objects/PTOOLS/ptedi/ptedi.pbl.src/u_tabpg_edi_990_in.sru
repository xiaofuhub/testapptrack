$PBExportHeader$u_tabpg_edi_990_in.sru
forward
global type u_tabpg_edi_990_in from u_tabpg_edi
end type
type dw_1 from u_dw within u_tabpg_edi_990_in
end type
end forward

global type u_tabpg_edi_990_in from u_tabpg_edi
string text = "Inbound"
dw_1 dw_1
end type
global u_tabpg_edi_990_in u_tabpg_edi_990_in

on u_tabpg_edi_990_in.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_edi_990_in.destroy
call super::destroy
destroy(this.dw_1)
end on

event constructor;call super::constructor;long	ll_coid, &
		ll_row

ll_coid = this.of_GetCompany()

if ll_coid > 0 then
	dw_profile.settransobject(sqlca)
	if dw_profile.retrieve(ll_coid, 990, "INBOUND") < 1 then
		ll_row = dw_profile.insertrow(0)
		if ll_row > 0 then
			dw_profile.object.companyid[ll_row] = ll_coid
			dw_profile.object.transactionset[ll_row] = 990
			dw_profile.object.in_out[ll_row] = "INBOUND"
		end if
	end if
//dw_1.post of_formatdisplay( )
end if
end event

type dw_profile from u_tabpg_edi`dw_profile within u_tabpg_edi_990_in
integer height = 188
string dataobject = "d_ediprofile_204"
end type

event dw_profile::constructor;call super::constructor;//the name of the dataobject d_ediprofile_204 is decieving, as this dataobject
//actually takes a retrieval argument of the transaction set, and only references
//the ediProfile table.

this.object.filenameschema.TabSequence = 0
this.Object.folder.background.color = RGB( 192,192,192 )
this.Object.folder.protect = 1
this.object.cb_browsefolder.enabled = false
this.object.filenameschema.background.color = RGB( 192,192,192 )//false
this.object.filenameschema.protect = 1
end event

type st_title from u_tabpg_edi`st_title within u_tabpg_edi_990_in
string text = "Load Tender Response"
end type

type dw_1 from u_dw within u_tabpg_edi_990_in
integer y = 316
integer width = 2048
integer height = 428
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_990companies_in"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;Long	ll_count
Long	ll_coid
Long	ll_index
String	ls_filter
ll_coid  =  parent.of_getcompany() 
this.settransobject(SQLCA)
ll_count = this.retrieve(  ) 
commit;


ls_filter = "edi990profile_companyid = "+ string(ll_coid)
this.setfilter(ls_filter)
this.filter()

ll_count = this.rowCount()
IF ll_count > 0 THEN
	
ELSE
	ll_index = this.insertrow( 0 )
	this.setItem( ll_index , "edi990profile_companyid", ll_coid)
END IF

end event

event buttonclicked;call super::buttonclicked;String	ls_Folder
CHOOSE CASE Lower ( dwo.name )
		
	CASE "b_browsepending"
	
		IF GetFolder("Select a Folder", ls_Folder ) > 0 THEN
			if row > 0 then
				this.object.edi990profile_pendingfiles[row] = ls_Folder
			end if
		END IF	
	
	
	CASE "b_browseprocessed"
		IF GetFolder("Select a Folder", ls_Folder ) > 0 THEN
			if row > 0 then
				this.object.edi990profile_processedfiles[row] = ls_Folder
			end if
		END IF
		
		
	CASE ELSE
		
END CHOOSE

end event

