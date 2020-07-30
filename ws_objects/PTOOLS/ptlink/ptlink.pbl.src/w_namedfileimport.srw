$PBExportHeader$w_namedfileimport.srw
forward
global type w_namedfileimport from w_response
end type
type dw_import from u_dw within w_namedfileimport
end type
type dw_choose from datawindow within w_namedfileimport
end type
type cb_import from commandbutton within w_namedfileimport
end type
type cb_close from commandbutton within w_namedfileimport
end type
type cb_retrieve from commandbutton within w_namedfileimport
end type
type cb_export from commandbutton within w_namedfileimport
end type
type cb_reset from commandbutton within w_namedfileimport
end type
type cb_1 from commandbutton within w_namedfileimport
end type
end forward

global type w_namedfileimport from w_response
int X=142
int Y=240
int Width=2985
int Height=1768
dw_import dw_import
dw_choose dw_choose
cb_import cb_import
cb_close cb_close
cb_retrieve cb_retrieve
cb_export cb_export
cb_reset cb_reset
cb_1 cb_1
end type
global w_namedfileimport w_namedfileimport

forward prototypes
public function string wf_gettablename ()
end prototypes

public function string wf_gettablename ();integer	li_return=1

string	ls_tablename
			
ls_tablename = dw_choose.object.tablename[1]

choose case ls_tablename
		
	case "d_importedistatus"
		
	case "d_importdatamapping"
		
	case "d_importnotificationsettings"
		
	case else
		ls_tablename = ''
		
end choose

return ls_tablename
end function

on w_namedfileimport.create
int iCurrent
call super::create
this.dw_import=create dw_import
this.dw_choose=create dw_choose
this.cb_import=create cb_import
this.cb_close=create cb_close
this.cb_retrieve=create cb_retrieve
this.cb_export=create cb_export
this.cb_reset=create cb_reset
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_import
this.Control[iCurrent+2]=this.dw_choose
this.Control[iCurrent+3]=this.cb_import
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_retrieve
this.Control[iCurrent+6]=this.cb_export
this.Control[iCurrent+7]=this.cb_reset
this.Control[iCurrent+8]=this.cb_1
end on

on w_namedfileimport.destroy
call super::destroy
destroy(this.dw_import)
destroy(this.dw_choose)
destroy(this.cb_import)
destroy(this.cb_close)
destroy(this.cb_retrieve)
destroy(this.cb_export)
destroy(this.cb_reset)
destroy(this.cb_1)
end on

event open;call super::open;dw_choose.insertrow(0)
end event

type dw_import from u_dw within w_namedfileimport
int X=41
int Y=340
int Width=2875
int Height=1132
int TabOrder=10
boolean BringToTop=true
boolean HScrollBar=true
boolean HSplitScroll=true
end type

type dw_choose from datawindow within w_namedfileimport
int X=5
int Y=60
int Width=2551
int Height=240
int TabOrder=20
boolean BringToTop=true
string DataObject="d_importfilelist"
boolean Border=false
boolean LiveScroll=true
end type

type cb_import from commandbutton within w_namedfileimport
int X=1079
int Y=1524
int Width=306
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="&Import"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer	li_return=1

string	ls_tablename, &
			ls_filename, &
			ls_pathname

ls_filename = dw_choose.object.filename[1]

//cb_retrieve.triggerevent(clicked!)

ls_tablename = parent.wf_gettablename()

if li_return = 1 then
	if fileexists(ls_filename) then
		//continue
	else
		setnull(ls_filename)
	end if
end if

if li_return = 1 then
	if dw_import.rowcount() = 0 then
		dw_import.DataObject = ls_tablename
		dw_import.SetTransObject(SQLCA)
	end if
	
	dw_import.ImportFile(ls_filename)

end if

end event

type cb_close from commandbutton within w_namedfileimport
int X=2158
int Y=1524
int Width=306
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="&Close"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_retrieve from commandbutton within w_namedfileimport
int X=357
int Y=1524
int Width=306
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="&Retrieve"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer	li_return=1

string	ls_tablename
			
ls_tablename = parent.wf_gettablename()

if len(trim(ls_tablename)) = 0 then
	li_return = -1
	messagebox("Retrieve File", "Please select a table to retrieve.")
end if		

if li_return = 1 then

	dw_import.DataObject = ls_tablename
	dw_import.SetTransObject(SQLCA)
	dw_import.retrieve()

end if

end event

type cb_export from commandbutton within w_namedfileimport
int X=1440
int Y=1524
int Width=306
int Height=108
int TabOrder=70
boolean BringToTop=true
string Text="&Export"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer	li_return=1

string	ls_pathname, &
			ls_filename

cb_retrieve.triggerevent(clicked!)

if dw_import.rowcount() = 0 then
	li_return = -1
end if

if li_return = 1 then
	if fileexists(ls_filename) then
		choose case messagebox("Export File", "Save the rows to " + ls_filename + " ?", Question!, YesNO!)
						
			case 1
				
			case 2
				li_return = -1
				
		end  choose
		
	else
		ls_filename=''
	end if
end if

dw_import.SaveAs(ls_filename, TEXT!, TRUE)


end event

type cb_reset from commandbutton within w_namedfileimport
int X=718
int Y=1524
int Width=306
int Height=108
int TabOrder=60
boolean BringToTop=true
string Text="Re&set"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer	li_return=1

string	ls_tablename

		
cb_retrieve.triggerevent(clicked!)

if dw_import.rowcount() = 0 then
	li_return = -1
end if

if li_return = 1 then

	choose case messagebox("Reset Table", "This will delete all of the rows in the table. " + &
									"Are you sure you want to do this ?", Question!, YesNo!)
		case 1
			//continue
		case 2
			li_return = -1
	end choose
	
end if

if li_return = 1 then
	
	dw_import.RowsMove(1, dw_import.RowCount(), Primary!, dw_import, 1, Delete!)	
	
	if dw_import.update() = 1 then
		COMMIT USING SQLCA;
	ELSE
		ROLLBACK USING SQLCA;
	END IF
	
end if
end event

type cb_1 from commandbutton within w_namedfileimport
int X=1801
int Y=1524
int Width=306
int Height=108
int TabOrder=70
boolean BringToTop=true
string Text="S&ave"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if dw_import.update() = 1 then
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
END IF

end event

