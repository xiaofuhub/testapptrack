$PBExportHeader$w_useralert.srw
forward
global type w_useralert from w_popup
end type
type sle_context from singlelineedit within w_useralert
end type
type cbx_status from checkbox within w_useralert
end type
type cb_1 from commandbutton within w_useralert
end type
type mle_1 from multilineedit within w_useralert
end type
type ln_1 from line within w_useralert
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//
//Long	sl_last_Y
//Long	sl_last_X
//
//int	si_Count
////end modification Shared Variables by appeon  20070730
end variables

global type w_useralert from w_popup
integer width = 1280
integer height = 800
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 134217752
toolbaralignment toolbaralignment = alignatbottom!
boolean ib_isupdateable = false
event ue_deletealert ( )
sle_context sle_context
cbx_status cbx_status
cb_1 cb_1
mle_1 mle_1
ln_1 ln_1
end type
global w_useralert w_useralert

type variables
Private:
Long		il_MessageID
Int		ii_Status

//begin modification Shared Variables by appeon  20070730

Long	sl_last_Y
Long	sl_last_X

int	si_Count
//end modification Shared Variables by appeon  20070730

end variables

forward prototypes
private function integer wf_populate ()
private function string wf_getcontextdescription (string as_class, long al_id)
end prototypes

event ue_deletealert();IF il_messageid > 0 THEN
  
  DELETE FROM "useralerts"  
   WHERE "useralerts"."id" = :il_MessageID ;
		IF Sqlca.sqlcode = 0 THEN
			Commit;
		ELSE
			Rollback;
		END IF
		
END IF

CLOSE ( THIS ) 
		
end event

private function integer wf_populate ();String	ls_Message
String	ls_Title
String	ls_Context
Date		ld_Created
time		lt_Created
String	ls_UserID
String	ls_Classname
Long		ll_SourceID
Int		li_Return = 1
 

SELECT "useralerts"."alertmessage",   
		"useralerts"."createdby",   
		"useralerts"."createddate",   
		"useralerts"."createdtime" ,
		"useralerts"."classname",   
      "useralerts"."sourceid"  
 INTO :ls_Message,   
		:ls_UserID,   
		:ld_Created,   
		:lt_Created ,
		:ls_ClassName,
		:ll_SourceID
 FROM "useralerts"  
WHERE "useralerts"."id" = :il_messageid ;

Commit;


Long	ll_User
String	ls_Ref 
Int	li_Count
ls_Ref =  gnv_App.of_GetUserID()

SELECT "employees"."em_id"  
 INTO :ll_User 
 FROM "employees"  
WHERE "employees"."em_ref" = :ls_Ref   ;

IF SQLCA.Sqlcode <> 0 THEN
	li_Return = -1
	ROLLBACK;
ELSE
	Commit;
END IF

IF li_Return = 1 THEN
	
	Select Count ( "AlertID" ) 
	INTO :li_Count
	FROM joinUserAlert 
	Where alertid = :il_messageid 
			and employeeid = :ll_User;
	Commit;
	
	IF li_Count > 0 THEN
		ii_Status = appeon_constant.ci_status_active
	ELSE
		ii_status = appeon_constant.ci_status_inactive
	END IF
	
END IF

mle_1.Text = ls_Message
cbx_status.Checked = ii_Status = 1 
ls_Context = THIS.wf_getcontextdescription( ls_Classname , ll_SourceID )
ls_Title = "Created by " + ls_UserID + " on " + String ( ld_Created , "mm/dd/yy" ) + " " + String ( lt_Created , "HH:MM" )
THIS.Title = ls_title
THIS.sle_context.Text = ls_Context


IF ls_Classname = "DATABASE ALERT" THEN
	cbx_status.Checked = FALSE
	cbx_status.Visible = FALSE
END IF

RETURN 1

end function

private function string wf_getcontextdescription (string as_class, long al_id);String	ls_Return 
String	ls_name
String	ls_LN
String	ls_type

CHOOSE CASE as_Class
		
	CASE "n_cst_beo_shipment"
		  ls_Return = "Shipment: " + String ( al_id )

	CASE "n_cst_beo_company"
		
		SELECT "companies"."co_name"  
		 INTO :ls_Name  
		 FROM "companies"  
		WHERE "companies"."co_id" = :al_ID;
		
		IF SQLCA.Sqlcode = 0 THEN
			COmmit;
		ELSE
			Rollback;
		END IF 
		
		ls_Return = "Company: " + ls_Name
           
		
	CASE "n_cst_beo_event"
		ls_Return = "Event: " + String ( al_id )
		
		
	CASE "n_cst_beo_equipment2"

		n_cst_EquipmentManager	lnv_EqMan
		lnv_EqMan.of_Get_Description( al_ID , "SHORT_REF!" , ls_Name )
			  
	  	ls_Return = "Equipment: " + ls_Name

			
	CASE "n_cst_beo_employee2"
				
		SELECT "employees"."em_fn",   
             "employees"."em_ln"  
   	 INTO :ls_Name,   
            :ls_LN  
    	 FROM "employees"  
   	WHERE "employees"."em_id" = :al_ID ;
		
		IF SQLCA.Sqlcode = 0 THEN
			COmmit;
		ELSE
			Rollback;
		END IF 
		
      ls_Return = "Employee: " + ls_Name + " " + ls_LN

	CASE "system"
		
		ls_Return = "System Alert"
		
END CHOOSE

RETURN ls_Return 
end function

on w_useralert.create
int iCurrent
call super::create
this.sle_context=create sle_context
this.cbx_status=create cbx_status
this.cb_1=create cb_1
this.mle_1=create mle_1
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_context
this.Control[iCurrent+2]=this.cbx_status
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.mle_1
this.Control[iCurrent+5]=this.ln_1
end on

on w_useralert.destroy
call super::destroy
destroy(this.sle_context)
destroy(this.cbx_status)
destroy(this.cb_1)
destroy(this.mle_1)
destroy(this.ln_1)
end on

event open;call super::open;String	ls_Message
n_CsT_msg	lnv_Msg
s_Parm		lstr_Parm	

IF isValid ( Message.Powerobjectparm ) THEN
	lnv_Msg = Message.Powerobjectparm
END IF

IF lnv_Msg.of_Get_Parm ( "messageID" , lstr_Parm ) > 0 THEN
	il_messageid = lstr_Parm.ia_value
	THIS.wf_populate( )
END IF

THIS.x = sl_last_x + 100
THIS.y = sl_last_y + 100

sl_last_x = THIS.x
sl_Last_Y = THIS.y

si_Count ++

THIS.Post Show ( )
end event

event close;call super::close;si_count --
sl_last_x -= 100
sl_last_y -= 100 
IF si_Count = 0 THEN
	sl_last_x = 0
	sl_last_y = 0 
END IF
end event

type sle_context from singlelineedit within w_useralert
integer x = 59
integer y = 24
integer width = 1125
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 134217752
boolean border = false
boolean displayonly = true
boolean righttoleft = true
end type

type cbx_status from checkbox within w_useralert
integer x = 37
integer y = 640
integer width = 731
integer height = 68
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Show me this alert again"
end type

type cb_1 from commandbutton within w_useralert
integer x = 421
integer y = 508
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
boolean cancel = true
boolean default = true
end type

event clicked;Int	li_NewStatus

n_cst_AlertManager	lnv_AlertManager
lnv_AlertManager = CREATE n_Cst_AlertManager

IF cbx_status.Checked THEN
	li_NewStatus = appeon_constant.ci_status_active
ELSE
	li_NewStatus = appeon_constant.ci_status_inactive
END IF

IF li_NewStatus <> ii_status THEN

	CHOOSE CASE li_NewStatus
			
		CASE appeon_constant.ci_status_inactive 
			IF lnv_AlertManager.of_deletealertforCurrentUser( il_messageid ) <> 1 THEN
				MessageBox ( "Alert Status" , "An error occurred while attempting to delete the alert." )
			END IF	
		CASE appeon_constant.ci_status_active
			
			IF lnv_AlertManager.of_AddAlertForCurrentUser( il_messageid ) <> 1 THEN
				MessageBox ( "Alert Status" , "An error occurred while attempting to add the alert." )
			END IF	
			
			
	END CHOOSE
	
END IF

DESTROY ( lnv_AlertManager )
Close ( Parent )
end event

type mle_1 from multilineedit within w_useralert
integer x = 23
integer y = 128
integer width = 1211
integer height = 364
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
boolean border = false
boolean autovscroll = true
boolean displayonly = true
end type

type ln_1 from line within w_useralert
integer linethickness = 4
integer beginx = 37
integer beginy = 96
integer endx = 1230
integer endy = 96
end type

