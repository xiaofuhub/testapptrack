$PBExportHeader$w_importrateing.srw
forward
global type w_importrateing from w_response
end type
type rb_rates from radiobutton within w_importrateing
end type
type rb_newtable from radiobutton within w_importrateing
end type
type cb_save from commandbutton within w_importrateing
end type
type cb_close from commandbutton within w_importrateing
end type
type st_status from statictext within w_importrateing
end type
type dw_errors from u_dw within w_importrateing
end type
type cb_browse from commandbutton within w_importrateing
end type
type sle_path from singlelineedit within w_importrateing
end type
type st_1 from statictext within w_importrateing
end type
type st_2 from statictext within w_importrateing
end type
type cb_verify from commandbutton within w_importrateing
end type
type gb_1 from groupbox within w_importrateing
end type
end forward

global type w_importrateing from w_response
integer width = 2194
integer height = 728
string title = "Import Rates"
long backcolor = 12632256
rb_rates rb_rates
rb_newtable rb_newtable
cb_save cb_save
cb_close cb_close
st_status st_status
dw_errors dw_errors
cb_browse cb_browse
sle_path sle_path
st_1 st_1
st_2 st_2
cb_verify cb_verify
gb_1 gb_1
end type
global w_importrateing w_importrateing

type variables
protected:	
	n_cst_importRating	inv_importRating
	
	//decides which tables will be updated 
	Constant int	ci_NewTableMode = 1				//rate, ratetable, ratelinkbillable, ratelinkdestzone, ratelinkorigzone
	Constant int	ci_CompanyOverride = 2			//rate, ratelinkbillable, ratelinkdestzone, ratelinkorigzone
	Constant int	ci_RatesOnly = 3				
	
	boolean  ib_warned			//set to true once the user clicks update existing rates the first time.
										//this is only here to keep from telling them over and over.
end variables

forward prototypes
public function integer of_getchecked ()
end prototypes

public function integer of_getchecked ();IF isValid( inv_importrating ) THEN
//	inv_importRating.of_save()
END IF
Return 1
//IF rb_newtable.checked THEN
//	RETURN ci_newTableMode
//ELSEIF rb_rates.checked THEN
//	RETURN ci_RatesOnly
//END IF
end function

on w_importrateing.create
int iCurrent
call super::create
this.rb_rates=create rb_rates
this.rb_newtable=create rb_newtable
this.cb_save=create cb_save
this.cb_close=create cb_close
this.st_status=create st_status
this.dw_errors=create dw_errors
this.cb_browse=create cb_browse
this.sle_path=create sle_path
this.st_1=create st_1
this.st_2=create st_2
this.cb_verify=create cb_verify
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_rates
this.Control[iCurrent+2]=this.rb_newtable
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.st_status
this.Control[iCurrent+6]=this.dw_errors
this.Control[iCurrent+7]=this.cb_browse
this.Control[iCurrent+8]=this.sle_path
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.cb_verify
this.Control[iCurrent+12]=this.gb_1
end on

on w_importrateing.destroy
call super::destroy
destroy(this.rb_rates)
destroy(this.rb_newtable)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.st_status)
destroy(this.dw_errors)
destroy(this.cb_browse)
destroy(this.sle_path)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_verify)
destroy(this.gb_1)
end on

event open;call super::open;String	ls_null
Int		li_result
n_cst_setting_advancedprivs	lnv_setting
n_cst_privsManager				lnv_privsManager

lnv_setting = CREATE n_cst_setting_advancedprivs
SetNull( ls_null )

this.of_setBase( true )
inv_base.of_center( )

inv_importRating = create N_cst_importRating
//opens file import dialog selection

//display message if they won't beable to save imports
IF lnv_setting.of_getValue() = "Yes" THEN
	lnv_privsManager = gnv_app.of_getprivsmanager( ) //create n_cst_privsManager
	
	//currently logged in user
	IF	lnv_privsManager.of_getuserpermissionFromFn( lnv_privsManager.cs_modifyRateTable ) = 1 THEN 
		//leave it as is
	ELSE
		MessageBox( "Import Rates", "You do not have sufficient rights to save imported rates." )
	END IF
	
END IF
DESTROY lnv_setting

end event

event close;call super::close;
if IsValid( inv_importRating ) THEN
	DESTROY inv_importRating
END IF
end event

type cb_help from w_response`cb_help within w_importrateing
boolean visible = false
end type

type rb_rates from radiobutton within w_importrateing
integer x = 142
integer y = 328
integer width = 677
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Update Existing Rates"
end type

event clicked;IF not ib_warned THEN
	ib_warned = true
	
	MessageBox( "Update Rates", "Updating existing rates will only update the numeric rate value for the corresponding rate id in the file.  Updating existing rates should only be done with files that were exported through the Profit Tools rate window.", exclamation!)
END IF
end event

type rb_newtable from radiobutton within w_importrateing
integer x = 142
integer y = 424
integer width = 553
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Import New Rates"
boolean checked = true
end type

type cb_save from commandbutton within w_importrateing
integer x = 1760
integer y = 372
integer width = 366
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Save"
boolean default = true
end type

event clicked;//This should only be done after verification has taken place.  This is where
//the correct database update should take place.
Long	li_return

IF isValid( inv_importrating ) THEN
	li_return = inv_importRating.of_save( )
END IF

IF li_return > 0 THEN
	MessageBox( "Import Rating", "Saved changes successfully." )
ELSE
	MessageBox( "Import Rating",  "Error Saving Changes" )
END IF
cb_close.setFocus()
this.enabled = false
end event

type cb_close from commandbutton within w_importrateing
event ue_clicked ( string as_objectname )
integer x = 1760
integer y = 476
integer width = 366
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
boolean cancel = true
end type

event ue_clicked(string as_objectname);

// CHOOSE CASE as_objectName
//	CASE "cb_errors"
//		
//	CASE "cb_save"
//		
//END CHOOSE
end event

event clicked;Int	li_result
li_result = parent.event closeQuery()

IF li_result = 0 THEN
	close( w_importRateing )
END IF
end event

type st_status from statictext within w_importrateing
integer x = 64
integer y = 576
integer width = 2066
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 12632256
boolean focusrectangle = false
end type

type dw_errors from u_dw within w_importrateing
integer x = 55
integer y = 676
integer width = 2075
integer height = 956
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_onestringcolumn"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event destructor;call super::destructor;//overides ancestor
end event

type cb_browse from commandbutton within w_importrateing
integer x = 1760
integer y = 136
integer width = 366
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Br&owse"
end type

event clicked;//Opens up a File Open dialogue and does some preprocessing to see if the file
//is for Flat rates.  If it isn't a flat rate file then it doesn't let the import proceed.

String	ls_null
Int		li_result
String	ls_path
Int		li_rtn
String	ls_docPath
String	ls_docName
n_cst_setting_templatespathfolder 	lnv_Root
//SetNull( ls_null )


IF isValid( inv_importRating ) THEN 
	//opens file import dialog selection

	dw_errors.reset()
	inv_importRating.of_reset()

	lnv_Root = CREATE n_cst_setting_templatespathfolder

	ls_Path = lnv_Root.of_getValue()

	IF NOT isNull( ls_Path ) THEN
		 li_rtn = GetFileOpenName("Import File", ls_docpath, ls_docname, "CSV","Comma Seperated Values (*.CSV),*.CSV, All Files (*.*), *.*",ls_Path)
		// MessageBox(ls_docName, ls_docPath)
		sle_path.text = ls_docPath
	END IF
	
	IF li_rtn > 0 THEN
		li_result = inv_importRating.of_importfile( ls_docPath )
	END IF
	IF li_result > 0 THEN	
		cb_verify.enabled = true
		cb_verify.SetFocus()
		//if there is a number other then 0 in the billtoid of the imported file
		IF inv_importRating.of_companyoverride( ) THEN
			st_status.text = "Company Override: "
			//find out if there is a preexisting override for the company of the imported file
//			IF inv_importRating.of_existsTable() THEN
//				rb_rates.checked = true
//				rb_rates.enabled = true
//				rb_newTable.enabled = false
//				st_status.text+= "Overwrite table."
//			ELSE
//				rb_rates.enabled = false
//				rb_newTable.enabled = true
//				rb_newtable.checked = true
//				st_status.text+= "Create New Table"
//			END IF
			//if it does than choose update existing table, otherwise choose new table
			
			
		ELSE
			st_status.text = "Ready..."
		END IF
		
	ELSE
		IF li_rtn <> 0 THEN
			MessageBox("Import Rates", "Error Opening File" , EXCLAMATION! )
			
			St_status.text = "ERROR: importing file"
			cb_save.enabled = false
			cb_close.setFocus()
			IF inv_importrating.getErrorcount( ) > 0 THEN
				inv_importRating.of_geterrors( dw_errors )
				st_status.text = string( inv_importRating.getErrorCount() )+ " Total Error(s)" 
				cb_save.enabled = false
				cb_close.setFocus()
				parent.height = 1756
			END IF
		END IF
	END IF
END IF


end event

type sle_path from singlelineedit within w_importrateing
integer x = 64
integer y = 132
integer width = 1664
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217739
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_importrateing
integer x = 64
integer y = 48
integer width = 402
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
string text = "Import File:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_importrateing
integer x = 983
integer y = 32
integer width = 1143
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Only tables with flat rates can be imported"
boolean focusrectangle = false
end type

type cb_verify from commandbutton within w_importrateing
integer x = 1755
integer y = 264
integer width = 366
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Verify"
end type

event clicked;n_cst_privsmanager lnv_privsManager

int	li_result
String		ls_file
String		ls_message

st_status.text = "Checking data dependencies...This may a few minutes."

IF isValid( inv_importRating ) THEN
	IF rb_newtable.checked THEN
		li_result = inv_importrating.of_importnewtableflat( ls_message )
	ELSEIF rb_rates.checked THEN
		li_result = inv_importRating.of_updateExistingRates( ls_message )
	END IF
END IF

st_status.text = ""
IF li_result = -1 THEN
	MessageBox("Verify", "The file imported has errors in it, please make appropriate changes.", EXCLAMATION!)
	cb_save.enabled = false
	cb_close.setFocus()
ELSE
	MessageBox("Verify", "There were no errors found.~r~n"+ ls_message)
	ST_status.text = "0 Errors Found"
	cb_save.setFocus( )
	cb_save.enabled = true
END IF


//populates the error window
IF inv_importrating.getErrorcount( ) > 0 THEN
	inv_importRating.of_geterrors( dw_errors )
	st_status.text = string( inv_importRating.getErrorCount() )+ " Total Error(s)" 
	cb_save.enabled = false
	
	cb_close.setFocus()
	parent.height = 1756
END IF
this.enabled = false


lnv_privsManager = gnv_app.of_getprivsmanager( ) //create n_cst_privsManager
//added by dan to prevent modification of rate tables if the user doesn't have permission.
IF lnv_privsManager.of_useadvancedprivs( ) THEN
	
	//currently logged in user
	IF	lnv_privsManager.of_getuserpermissionFromFn( lnv_privsManager.cs_modifyRateTable ) = 1 THEN 
		//leave it as is
	ELSE
		//disable save
		cb_save.enabled = false
	END IF
	
	
END IF

SetPointer( arrow! )
end event

type gb_1 from groupbox within w_importrateing
integer x = 64
integer y = 248
integer width = 850
integer height = 300
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Modification Type"
end type

