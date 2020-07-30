$PBExportHeader$w_reportviewer_itinerary.srw
forward
global type w_reportviewer_itinerary from w_psr_viewer
end type
end forward

global type w_reportviewer_itinerary from w_psr_viewer
integer width = 3534
integer height = 2200
string title = "Itineray Report"
end type
global w_reportviewer_itinerary w_reportviewer_itinerary

type variables
Int	ii_Type
Long	il_ID
Date	id_Start
Date	id_End
end variables

forward prototypes
public function integer wf_retrieve ()
end prototypes

public function integer wf_retrieve ();RETURN  dw_psr.Retrieve ( ii_type, il_id , id_start, id_end ) 
end function

on w_reportviewer_itinerary.create
call super::create
end on

on w_reportviewer_itinerary.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;// override ancestor

s_Parm	lstr_Parm


IF isValid ( inv_msg ) THEN
	
	IF inv_msg.of_Get_Parm ( "FILE" , lstr_Parm ) <> 0 THEN
		is_psrfilename = lstr_Parm.ia_value
	END IF
	
	IF inv_msg.of_Get_Parm ( "TYPE" , lstr_Parm ) <> 0 THEN
		ii_type = lstr_Parm.ia_value
	END IF
	
	IF inv_msg.of_Get_Parm ( "ID" , lstr_Parm ) <> 0 THEN
		il_id = lstr_Parm.ia_value
	END IF
	
	IF inv_msg.of_Get_Parm ( "STARTDATE" , lstr_Parm ) <> 0 THEN
		id_start = lstr_Parm.ia_value
	END IF
	
	IF inv_msg.of_Get_Parm ( "ENDDATE" , lstr_Parm ) <> 0 THEN
		id_end = lstr_Parm.ia_value
	END IF
	
	
END IF

IF Len ( is_psrfilename ) > 0 THEN 
	dw_psr.Dataobject = is_psrfilename
	dw_psr.SetTransObject ( SQLCA )
	dw_psr.Retrieve ( ii_type, il_id , id_start, id_end ) 
	THIS.wf_settitlewithfilename( )
END IF
end event

type dw_psr from w_psr_viewer`dw_psr within w_reportviewer_itinerary
integer x = 18
integer width = 3461
integer height = 1668
end type

type cb_openfile from w_psr_viewer`cb_openfile within w_reportviewer_itinerary
end type

event cb_openfile::constructor;call super::constructor;THIS.Enabled = FALSE
end event

type cb_2 from w_psr_viewer`cb_2 within w_reportviewer_itinerary
end type

type cb_3 from w_psr_viewer`cb_3 within w_reportviewer_itinerary
end type

event cb_3::clicked;// override
dw_psr.Event pfc_Print ( )
end event

type cb_email from w_psr_viewer`cb_email within w_reportviewer_itinerary
end type

type cb_save from w_psr_viewer`cb_save within w_reportviewer_itinerary
end type

type cb_images from w_psr_viewer`cb_images within w_reportviewer_itinerary
end type

type dw_rules from w_psr_viewer`dw_rules within w_reportviewer_itinerary
end type

type mle_taglist1 from w_psr_viewer`mle_taglist1 within w_reportviewer_itinerary
end type

type mle_taglist2 from w_psr_viewer`mle_taglist2 within w_reportviewer_itinerary
end type

type cb_image_list from w_psr_viewer`cb_image_list within w_reportviewer_itinerary
end type

type st_emails from w_psr_viewer`st_emails within w_reportviewer_itinerary
end type

