$PBExportHeader$w_imagemodlog.srw
forward
global type w_imagemodlog from w_response
end type
type dw_log from u_dw within w_imagemodlog
end type
type cb_1 from commandbutton within w_imagemodlog
end type
type st_1 from statictext within w_imagemodlog
end type
type sle_image from singlelineedit within w_imagemodlog
end type
end forward

global type w_imagemodlog from w_response
integer x = 214
integer y = 221
integer width = 2048
integer height = 1512
string title = "Image Modification log"
long backcolor = 12632256
boolean ib_disableclosequery = true
dw_log dw_log
cb_1 cb_1
st_1 st_1
sle_image sle_image
end type
global w_imagemodlog w_imagemodlog

forward prototypes
public function integer wf_filter (long al_id)
end prototypes

public function integer wf_filter (long al_id);
/***************************************************************************************
NAME: 	wf_filter		

ACCESS:		public	
		
ARGUMENTS: 		
							al_id: 	the id of the image mods to be displayed, (Ship Tmp #)
RETURNS:			1 IF SUCCESSFULLY FILTERED 
					-1 OTHERWISE
DESCRIPTION: This filters the dw_modLog to only display images with al_id modifications.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created BY dan 1-10-2006
	

***************************************************************************************/
Int	li_result

IF al_id > 0 THEN
		dw_log.setFilter("")
		dw_log.retrieve( al_id )
		commit;
		dw_log.filter()
		dw_log.sort()
ELSE
	dw_log.setFilter("4=3")
	li_result = dw_log.filter()
	dw_log.sort()
END IF
RETURN li_result
end function

on w_imagemodlog.create
int iCurrent
call super::create
this.dw_log=create dw_log
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_image=create sle_image
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_log
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_image
end on

on w_imagemodlog.destroy
call super::destroy
destroy(this.dw_log)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_image)
end on

event open;call super::open;//Written by dan, if an id was passed to the window on the open call then it filters to that 
//image id.

n_cst_msg	lnv_Msg
s_Parm		lstr_Parm
u_dw 			ldw_Master
w_master		lw_Parent
Long			ll_id

IF isValid(Message.PowerObjectParm) THEN
	
	lnv_Msg = Message.PowerObjectParm 
	
	
	IF lnv_Msg.of_Get_parm("IMAGEID", lstr_Parm ) > 0 THEN
		ll_id = lstr_Parm.ia_value
		sle_image.text = String(ll_id)
		this.wf_filter( ll_id )
	END IF
END IF

this.center = true
end event

type cb_help from w_response`cb_help within w_imagemodlog
boolean visible = false
integer x = 2313
integer y = 1256
string text = ""
end type

type dw_log from u_dw within w_imagemodlog
integer x = 46
integer y = 144
integer width = 1934
integer height = 1240
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_imagemods"
end type

event constructor;call super::constructor;//retrieves all modlogs, and filters them down to nothing.
this.setTransObject( SQLCA )
this.of_setInsertable( false )
this.of_setdeleteable( false )


end event

type cb_1 from commandbutton within w_imagemodlog
integer x = 1705
integer y = 40
integer width = 270
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
boolean cancel = true
end type

event clicked;close( w_imageModLog )
end event

type st_1 from statictext within w_imagemodlog
integer x = 50
integer y = 52
integer width = 965
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
string text = "Image modification log for shipment:"
boolean focusrectangle = false
end type

type sle_image from singlelineedit within w_imagemodlog
integer x = 1015
integer y = 48
integer width = 352
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;//when this is changed, it calls filter on the data window.

IF isNumber( this.text ) THEN
	dw_log.retrieve( long(this.text) )
	parent.wf_filter( long(this.text) )
ELSE
	//this.text = "All Images"
	parent.wf_filter( 0 )
END IF
this.setFocus()
this.selecttext( 1, len(this.text))
end event

