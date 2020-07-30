$PBExportHeader$w_alertlist_byuser.srw
forward
global type w_alertlist_byuser from w_alertlist
end type
end forward

global type w_alertlist_byuser from w_alertlist
integer width = 3662
integer height = 1880
string title = "My Alerts"
end type
global w_alertlist_byuser w_alertlist_byuser

type variables
Boolean	ib_FilterIds
Long		ila_AlertIds[]
end variables

forward prototypes
public function integer wf_setcaption (string as_caption)
end prototypes

public function integer wf_setcaption (string as_caption);st_1.Text = as_Caption

return 1
end function

on w_alertlist_byuser.create
call super::create
end on

on w_alertlist_byuser.destroy
call super::destroy
end on

event pfc_postopen;//OverRide
SetPointer(HourGlass!)
Dw_1.SetRedraw(False)

dw_1.Retrieve( gnv_app.of_getnumericuserid( ) )
cb_delete.Visible = TRUE


IF ib_FilterIds THEN
	Long	ll_RowCount
	Long	ll_IdCount
	Long	ll_CurrentId
	Long	i, j
	Boolean lb_Found
	
	ll_IdCount = UpperBound(ila_AlertIds)
	
	//Discard alerts that are not passed in as ila_AlertIds
	ll_rowCount =	dw_1.RowCount()
	FOR i = ll_RowCount TO 1 STEP - 1
		lb_Found = FALSE
		ll_CurrentId = dw_1.GetItemNumber(i, "id")
		FOR j = 1 TO ll_IdCount
			IF ila_AlertIds[j] = ll_CurrentId THEN
				lb_Found = TRUE
			END IF
		NEXT
		IF NOT lb_Found THEN
			dw_1.RowsDiscard(i,i,Primary!)
		END IF
	NEXT
END IF

Dw_1.SetRedraw(True)
end event

event open;call super::open;n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm

lnv_Msg = Message.PowerObjectParm

IF isValid ( lnv_Msg ) THEN
	
	IF lnv_Msg.of_Get_Parm ( "ALERTIDS" , lstr_Parm)  <> 0 THEN
		ila_AlertIds = lstr_Parm.ia_Value
		ib_FilterIds = TRUE
	END IF
	
END IF
end event

type cb_save from w_alertlist`cb_save within w_alertlist_byuser
end type

type st_1 from w_alertlist`st_1 within w_alertlist_byuser
integer width = 1449
string text = "This is a list of the alerts you have not yet deactivated."
end type

type cb_1 from w_alertlist`cb_1 within w_alertlist_byuser
integer x = 1385
end type

type dw_1 from w_alertlist`dw_1 within w_alertlist_byuser
integer y = 140
integer width = 3557
string dataobject = "d_alerts_User"
end type

type cb_delete from w_alertlist`cb_delete within w_alertlist_byuser
integer width = 745
string text = "&Deactive Selected Alerts"
end type

