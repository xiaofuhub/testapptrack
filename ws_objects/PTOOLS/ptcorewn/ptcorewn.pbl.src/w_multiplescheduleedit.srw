$PBExportHeader$w_multiplescheduleedit.srw
forward
global type w_multiplescheduleedit from w_response
end type
type cb_1 from commandbutton within w_multiplescheduleedit
end type
type cb_2 from commandbutton within w_multiplescheduleedit
end type
type tab_schedules from u_tab within w_multiplescheduleedit
end type
type tab_schedules from u_tab within w_multiplescheduleedit
end type
end forward

global type w_multiplescheduleedit from w_response
integer x = 214
integer y = 221
integer width = 1746
integer height = 1800
string title = "Edit Schedule"
long backcolor = 12632256
cb_1 cb_1
cb_2 cb_2
tab_schedules tab_schedules
end type
global w_multiplescheduleedit w_multiplescheduleedit

type variables
n_Cst_scheduleData	inv_Data

end variables

on w_multiplescheduleedit.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.tab_schedules=create tab_schedules
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.tab_schedules
end on

on w_multiplescheduleedit.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.tab_schedules)
end on

event open;call super::open;int	li_Count
Int	i

PowerObject	lpoa_UpdateObjects[]
n_Cst_scheduleData	lnva_Schedules[]
n_cst_Eventmanager	lnv_EventManager

THIS.of_Setbase( TRUE )
THIS.inv_base.of_center( )

lnv_EventManager	= CREATE n_cst_Eventmanager

li_Count = lnv_EventManager.of_GetSchedulelist( lnva_Schedules )
FOR i = 1 TO li_Count
	
	tab_schedules.OpenTabWithParm( u_tabpg_scheduledata ,lnva_Schedules[i],0)
	lpoa_UpdateObjects[i] = u_tabpg_scheduledata
	
NEXT

DESTROY (lnv_EventManager )

THIS.of_Setupdateobjects( lpoa_UpdateObjects )


end event

event pfc_save;Int	li_Count
Int	i
Int	li_Return = 1

PowerObject lpo_update[]
of_getupdateobjects(lpo_update )

li_Count = UpperBound ( lpo_update )
FOR i = 1 TO li_Count
	IF lpo_update[i].Dynamic of_update ( ) <> 1 THEN
		MessageBox ( "Save Changes" , "An error occurred while attempting to save your changes." ) 		
		li_Return = -1
	END IF
NEXT

RETURN li_Return
end event

type cb_help from w_response`cb_help within w_multiplescheduleedit
integer x = 1307
integer y = 1372
end type

type cb_1 from commandbutton within w_multiplescheduleedit
integer x = 471
integer y = 1544
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;//MessageBox ("Pending" , Parent.of_Updatespending( ) )
//
//Int	li_Count
//Int	i
//Int	li_Return = 1
//
//PowerObject lpo_update[]
//of_getupdateobjects(lpo_update )
//
//li_Count = UpperBound ( lpo_update )
//FOR i = 1 TO li_Count
//	IF lpo_update[i].Dynamic of_update ( ) <> 1 THEN
//		MessageBox ( "Save Changes" , "An error occurred while attempting to save your changes." ) 		
//		li_Return = -1
//	END IF
//NEXT
//
//
//IF li_Return = 1 THEN
	CLOSE ( PARENT )
//END IF
end event

type cb_2 from commandbutton within w_multiplescheduleedit
integer x = 869
integer y = 1544
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;//ib_Disableclosequery = TRUE
//Close ( parent )
PARENT.event pfc_cancel( )
PARENT.event pfc_close ( )
end event

type tab_schedules from u_tab within w_multiplescheduleedit
integer x = 46
integer y = 24
integer width = 1637
integer height = 1492
integer taborder = 10
boolean bringtotop = true
long backcolor = 12632256
boolean multiline = true
boolean raggedright = false
boolean boldselectedtext = true
end type

