$PBExportHeader$u_cst_activeemployeealerts.sru
forward
global type u_cst_activeemployeealerts from u_base
end type
type cb_changestatus from commandbutton within u_cst_activeemployeealerts
end type
type rb_inactive from radiobutton within u_cst_activeemployeealerts
end type
type rb_active from radiobutton within u_cst_activeemployeealerts
end type
type dw_withalerts from u_dw_alertdetails_users within u_cst_activeemployeealerts
end type
type dw_withoutalerts from u_dw_alertdetails_users within u_cst_activeemployeealerts
end type
end forward

global type u_cst_activeemployeealerts from u_base
integer width = 2514
integer height = 1712
long backcolor = 12632256
cb_changestatus cb_changestatus
rb_inactive rb_inactive
rb_active rb_active
dw_withalerts dw_withalerts
dw_withoutalerts dw_withoutalerts
end type
global u_cst_activeemployeealerts u_cst_activeemployeealerts

type variables
PRIVATE:
Long	il_AlertID
Boolean	ib_AllowMods = TRUE
end variables

forward prototypes
public function integer of_retrieve (long al_alertid)
private subroutine of_showemployeeswithalert ()
private subroutine of_showemployeeswithoutalert ()
private subroutine of_viewdatawindow ()
private function integer of_deactivatealert (long al_activerow)
private function integer of_activatealert (long al_deactiverow)
public function integer of_allowmodifications (boolean ab_value)
end prototypes

public function integer of_retrieve (long al_alertid);Long	ll_With
Long	ll_Wo
Int	li_Return = 1

il_alertid = al_alertid

ll_With = dw_withalerts.Retrieve( al_alertid )
ll_WO = dw_withoutalerts.Retrieve( al_alertid )

IF ll_With < 0 OR ll_Wo < 0 THEN
	li_Return = -1
END IF

RETURN li_Return
end function

private subroutine of_showemployeeswithalert ();dw_withalerts.Visible = TRUE
dw_withoutalerts.Visible = FALSE
cb_changestatus.Text = "Deactivate Alerts"
end subroutine

private subroutine of_showemployeeswithoutalert ();dw_withalerts.Visible = FALSE
dw_withoutalerts.Visible = TRUE
cb_changestatus.Text = "Activate Alerts"
end subroutine

private subroutine of_viewdatawindow ();IF rb_active.Checked THEN
	THIS.of_Showemployeeswithalert( )
ELSE
	THIS.of_Showemployeeswithoutalert( )
END IF
end subroutine

private function integer of_deactivatealert (long al_activerow);Long	ll_Row
ll_Row = al_ActiveRow
IF ll_Row > 0 AND ll_Row <= dw_withalerts.RowCount () THEN
	dw_withalerts.RowsCopy( ll_Row, ll_Row , PRIMARY!, dw_withoutalerts , dw_withoutalerts.RowCount() + 1, PRIMARY! )	
	dw_Withalerts.Deleterow( ll_Row )
	dw_withoutalerts.Sort( )
END IF

RETURN 1

end function

private function integer of_activatealert (long al_deactiverow);Long	ll_Row
ll_Row = al_DeactiveRow
IF ll_Row > 0 AND ll_Row <= dw_withoutalerts.RowCount () THEN
	dw_withoutalerts.Rowsmove( ll_Row, ll_Row , PRIMARY!, dw_withalerts , dw_withalerts.RowCount() + 1, PRIMARY! )	
	dw_withalerts.object.joinuseralert_alertid [dw_withalerts.RowCount()] = il_alertid	
	dw_withalerts.Sort( )
END IF

RETURN 1

end function

public function integer of_allowmodifications (boolean ab_value);ib_allowmods = ab_value
cb_changestatus.Visible = ib_allowmods
RETURN 1
end function

on u_cst_activeemployeealerts.create
int iCurrent
call super::create
this.cb_changestatus=create cb_changestatus
this.rb_inactive=create rb_inactive
this.rb_active=create rb_active
this.dw_withalerts=create dw_withalerts
this.dw_withoutalerts=create dw_withoutalerts
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_changestatus
this.Control[iCurrent+2]=this.rb_inactive
this.Control[iCurrent+3]=this.rb_active
this.Control[iCurrent+4]=this.dw_withalerts
this.Control[iCurrent+5]=this.dw_withoutalerts
end on

on u_cst_activeemployeealerts.destroy
call super::destroy
destroy(this.cb_changestatus)
destroy(this.rb_inactive)
destroy(this.rb_active)
destroy(this.dw_withalerts)
destroy(this.dw_withoutalerts)
end on

event constructor;call super::constructor;dw_withalerts.SetTransobject( SQLCA )
dw_withoutalerts.SetTransobject( SQLCA )
end event

type cb_changestatus from commandbutton within u_cst_activeemployeealerts
integer x = 1938
integer y = 176
integer width = 498
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deactivate Alerts"
end type

event clicked;Long	lla_Rows[]
Long	ll_Count
Long	i
IF dw_withalerts.Visible THEN
	ll_Count = dw_Withalerts.of_Getselectedrows( lla_Rows )
	FOR i = ll_Count TO 1 STEP -1 
		PARENT.of_deactivatealert( lla_Rows[i] )		
	NEXT
ELSE
	ll_Count = dw_withoutalerts.of_Getselectedrows( lla_Rows )
	FOR i = ll_Count TO 1 STEP -1 
		PARENT.of_activatealert( lla_Rows[i] )		
	NEXT
END IF
end event

type rb_inactive from radiobutton within u_cst_activeemployeealerts
integer x = 73
integer y = 96
integer width = 1198
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Employees who have &deativated the alert"
end type

event clicked;Parent.of_viewDataWindow ( )
end event

type rb_active from radiobutton within u_cst_activeemployeealerts
integer x = 73
integer y = 16
integer width = 914
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Employees with alert still &active"
boolean checked = true
end type

event clicked;Parent.of_viewDataWindow ( )
end event

type dw_withalerts from u_dw_alertdetails_users within u_cst_activeemployeealerts
integer x = 73
integer y = 292
integer width = 2363
integer height = 1336
integer taborder = 30
string dataobject = "d_employeealertcount"
end type

event doubleclicked;call super::doubleclicked;IF ib_allowmods THEN
	of_Deactivatealert( ROW )
END IF

end event

type dw_withoutalerts from u_dw_alertdetails_users within u_cst_activeemployeealerts
integer x = 73
integer y = 292
integer width = 2363
integer height = 1336
integer taborder = 40
string dataobject = "d_employeeswithoutalert"
end type

event doubleclicked;call super::doubleclicked;IF ib_allowmods THEN
	of_activatealert( ROW )
END IF

end event

