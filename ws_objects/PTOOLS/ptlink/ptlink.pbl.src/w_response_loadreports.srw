$PBExportHeader$w_response_loadreports.srw
forward
global type w_response_loadreports from w_response
end type
type cb_browse from commandbutton within w_response_loadreports
end type
type sle_selected from singlelineedit within w_response_loadreports
end type
type cb_open from commandbutton within w_response_loadreports
end type
type cb_cancel from commandbutton within w_response_loadreports
end type
type tab_report from u_tab_reportlists within w_response_loadreports
end type
type tab_report from u_tab_reportlists within w_response_loadreports
end type
end forward

global type w_response_loadreports from w_response
integer x = 214
integer y = 221
integer width = 1490
integer height = 1664
string title = "Report Selection"
long backcolor = 12632256
event ue_doubleclicked ( )
cb_browse cb_browse
sle_selected sle_selected
cb_open cb_open
cb_cancel cb_cancel
tab_report tab_report
end type
global w_response_loadreports w_response_loadreports

type variables
w_sheet	iw_current
String		isa_reportContexts[]
end variables

forward prototypes
public function integer wf_processdispatchrequest (w_dispatch aw_dispatch)
public function integer of_populatereports (ref string asa_contexts[])
public function boolean of_isincontext (string as_path)
public function integer of_selectionchanged ()
public function integer of_openselected ()
end prototypes

event ue_doubleclicked();String	ls_path

ls_path = this.tab_report.of_getfilenname( )
//messageBox("filename", ls_path)
if ls_path > "" THEN
	cb_open.event clicked( )
END IF
end event

public function integer wf_processdispatchrequest (w_dispatch aw_dispatch);/***************************************************************************************
NAME: 	wf_processdispatchRequest()		

ACCESS:			public
		
ARGUMENTS: 		
							w_dispatch
							
RETURNS:		1 if the window passed in is valid
				-1 otherwise
	
DESCRIPTION:  The following logic is forwards the information to be handled by
					either the w_ship or w_itin windows depending on which one was visible
					when they requested reports.  The windows know what args they have, so
					this way it can do the appropriate retrieval.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 11-22-2005
	

***************************************************************************************/

//Processes the report for the w_dispatch context.

String	ls_request
IF isValid( aw_dispatch ) THEN
	
	//if the window is that is making the request is an itin window, then
	//we forward the call to it.  The Itin win expects the path name to be in the
	//form:  "REPORT%C:\Profit Tools\Reports\Itinerary\ItinReport.psr!"
	IF isValid( aw_dispatch.itinwin ) THEN
		IF aw_dispatch.itinwin.visible THEN
			//puthing it in the correct form for itinerary windows
			ls_request = "REPORT%"+ sle_selected.text+"!"
			aw_dispatch.itinwin.wf_process_request( ls_request )
		END IF
	END IF
	
	
	//we forward the call to the shipment window if it is visible,
	//right now the shipmentwindow has no reports, so this won't do anything.
	IF isValid( aw_dispatch.shipwin ) THEN
		IF aw_dispatch.shipWin.visible THEN
			aw_dispatch.shipWin.wf_process_Request( ls_request )
		END IF
	END IF
	return 1
END IF

return -1

end function

public function integer of_populatereports (ref string asa_contexts[]);/***************************************************************************************
NAME: 			of_populateReports

ACCESS:		public	
		
ARGUMENTS: 		
							none

RETURNS:			1
	
DESCRIPTION:  The following code first looks to see what the context is in which
					the window was opened, and tries to open "C:\Dev\Reports\ *is_context* \*.psr"
					If this folder exists, it tries to open psrs from  "C:\Dev\Reports\*is_context*\*userlogin*\*.psr"
					Lastly it tries to open up psrs from  "C:\Dev\Reports\*.psr" and "C:\Dev\Reports\*userlogin*\*.psr"


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	11-22-2005
	

***************************************************************************************/

String	ls_path
String	ls_root
String	ls_fileType
String	ls_user

long		ll_index
long		ll_max

n_cst_setting_templatespathfolder	lnv_TemplatePath
lnv_TemplatePath = CREATE n_cst_setting_templatespathfolder

ls_Root = lnv_TemplatePath.of_GetValue ( ) + "Reports\"
//ls_root = "C:\Dev\Reports\"
ls_fileType = "\*.PSR"
ls_user = gnv_app.of_getUserId( ) 

ll_max = upperBound( asa_contexts[] )
FOR ll_index = 1 TO ll_max
	IF asa_contexts[ll_index] > "" THEN
		ls_path = ls_root + asa_contexts[ll_index] +"\"
		//ls_path in the form "C:\Dev\Reports\context\"
		tab_report.of_initTab( ls_path, asa_contexts[ll_index] )
	END IF
NEXT


DESTROY ( lnv_TemplatePath )
RETURN 1
end function

public function boolean of_isincontext (string as_path);long	ll_index
long	ll_max

ll_max = upperBound(  isa_reportContexts )

//returns true if the path sent in is one that is a part of one of the contexts
//in which this window was opened
FOR ll_index = 1 TO ll_max
	IF isa_reportContexts[ll_index] > "" THEN
		
		IF Pos( as_path, isa_reportContexts[ll_index] ) > 0 THEN
			return true
		END IF
			
	END IF
NEXT
RETURN FALSE
end function

public function integer of_selectionchanged ();Int		li_return
String	ls_filePath
ls_filePath = this.tab_report.of_getfilenname( )

IF ls_filePath > "" THEN
	this.sle_selected.text = ls_filePath
	cb_open.enabled = true
	li_return = 1
ELSE
	cb_open.enabled = false
	li_return = -1
END IF

return li_return
end function

public function integer of_openselected ();/***************************************************************************************
NAME: 	of_openSelected		

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			
	
DESCRIPTION:	The button tries to open the file selected in sle_selected.text.  
					If file selected was selected in context, then it tries to 
					open the psr by forwarding it to the appropriate window to open.
					Otherwise it sends it to the report manager to open it.
	
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan 11-22-2005
					  : Copied the code from the "Open" button to here by Dan 1-12-06	
						
***************************************************************************************/
Int	li_Return
W_dispatch	lw_temp
String		ls_request
n_cst_bso_reportManager	inv_reportmanager

//if the requested path has the context info in it, then we want to forward
//the open to the correct kind of window. (For some windows, their may be some
//preprocessing of the path name in order to get it to recognize it the way it should.)
IF  this.of_isInContext( sle_selected.text )  THEN

	//IF the context is "Itinerary" or "Shipment", then the window should be dispatch type.
	IF iw_current.className( ) = "w_dispatch" THEN
		//we know that iw_current is a w_dispatch window which is what the function takes
		this.wf_processdispatchrequest( iw_current )
		
	ELSE 		//END current window = w_dispatch context
		
		//extend to other contexts here
	END IF	
	
ELSE 					
	//opening isn't in the context of anything, so we should just open the window.
	inv_reportManager.of_process_report_request( sle_selected.text )
END IF

close( w_response_loadReports )

RETURN li_Return
end function

on w_response_loadreports.create
int iCurrent
call super::create
this.cb_browse=create cb_browse
this.sle_selected=create sle_selected
this.cb_open=create cb_open
this.cb_cancel=create cb_cancel
this.tab_report=create tab_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_browse
this.Control[iCurrent+2]=this.sle_selected
this.Control[iCurrent+3]=this.cb_open
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.tab_report
end on

on w_response_loadreports.destroy
call super::destroy
destroy(this.cb_browse)
destroy(this.sle_selected)
destroy(this.cb_open)
destroy(this.cb_cancel)
destroy(this.tab_report)
end on

event open;call super::open;n_cst_msg	lnv_Msg
s_Parm		lstr_Parm
window		lw_temp

IF isValid(Message.PowerObjectParm) THEN
	
	lnv_Msg = Message.PowerObjectParm 
	
	IF lnv_Msg.of_Get_parm("CURRENTWIN", lstr_Parm ) > 0 THEN
		lw_temp = lstr_Parm.ia_value
		IF isValid( lw_temp ) THEN
			IF lw_temp.triggerEvent("ue_hasReportContext") =  1 THEN
				iw_current = lw_temp
				
				IF isValid( iw_current ) THEN
					//gets an array of contexts that need to be populated
					iw_current.wf_getReportContexts( isa_reportContexts )
				END IF
			END IF
		END IF
	END IF
	this.of_populateReports( isa_reportContexts )
	
	this.tab_report.post of_setSelectedTab( )
	
END IF

THIS.x = Pointerx( ) - THIS.Width/2
THIS.y = Pointery( ) + 345


//THIS.of_SetBase( TRUE )
//inv_Base.of_center( )
end event

type cb_help from w_response`cb_help within w_response_loadreports
boolean visible = false
end type

type cb_browse from commandbutton within w_response_loadreports
integer x = 1184
integer y = 1352
integer width = 256
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Browse"
end type

event clicked;Int	li_rtn
String		ls_path
String		ls_docName
String		ls_docPath
n_cst_setting_templatespathfolder 	lnv_Root

lnv_Root = CREATE n_cst_setting_templatespathfolder

//Browse data object dialog box
ls_Path = lnv_Root.of_getValue()
ls_Path = Mid( ls_path, 1, len(ls_path) -1 )	//strips off the "\" at the end
IF NOT isNull( ls_Path ) THEN
	 li_rtn = GetFileOpenName("Select Report File", sle_selected.text , ls_docname, "PSR", "PSR FILES (*.PSR),*.PSR", ls_Path, 18)
	 cb_open.enabled = true
	 
	 //ADDED 1-12-07 By dan, Rick had a pet peve about selecting a file and still having to click the open button. This line was added.
	 IF li_rtn = 1 THEN
		 Parent.of_openselected( )		
	END IF
	/////////////////end add
END IF

DESTROY	lnv_root
end event

type sle_selected from singlelineedit within w_response_loadreports
integer x = 27
integer y = 1352
integer width = 1134
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_open from commandbutton within w_response_loadreports
integer x = 905
integer y = 1468
integer width = 256
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Open"
boolean default = true
end type

event clicked;//moved code into a function on 1-13-07 by Dan
parent.of_openselected( )
end event

type cb_cancel from commandbutton within w_response_loadreports
integer x = 1189
integer y = 1468
integer width = 256
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;close( w_response_loadReports )
end event

type tab_report from u_tab_reportlists within w_response_loadreports
integer x = 27
integer y = 32
integer width = 1417
integer height = 1300
integer taborder = 10
boolean bringtotop = true
end type

event ue_selectionchanged;call super::ue_selectionchanged;parent.of_selectionchanged(  )
end event

event ue_doubleclicked;call super::ue_doubleclicked;parent.event ue_doubleclicked(  )
end event

