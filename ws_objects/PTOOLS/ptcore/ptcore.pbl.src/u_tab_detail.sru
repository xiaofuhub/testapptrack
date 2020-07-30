$PBExportHeader$u_tab_detail.sru
forward
global type u_tab_detail from u_tab
end type
end forward

shared variables

end variables

global type u_tab_detail from u_tab
int Width=2354
int Height=1320
boolean CreateOnDemand=true
boolean BoldSelectedText=true
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
event ue_selectionchanged ( )
event type integer ue_sharedata ( datawindow adw_target )
end type
global u_tab_detail u_tab_detail

type variables
PowerObject	ipo_Source
Long		il_CurrentRow
String		is_TargetEvent
end variables

forward prototypes
public function integer of_setsource (powerobject apo_source)
public function integer of_setcurrentrow (long al_row)
public function long of_getcurrentrow ()
public function powerobject of_getsource ()
end prototypes

event ue_sharedata;n_cst_dws	lnv_Dws
DataWindow	ldw_Source
DataStore	lds_Source
Long			ll_CurrentRow

Integer		li_Return = 1


IF NOT IsValid ( adw_Target ) THEN
	li_Return = -1
END IF


IF li_Return = 1 THEN

	CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( of_GetSource ( ), ldw_Source, lds_Source )
	
	CASE DataWindow!
		ldw_Source.ShareData ( adw_Target )
	
	CASE DataStore!
		lds_Source.ShareData ( adw_Target )

	CASE ELSE
		li_Return = -1
	
	END CHOOSE

END IF


IF li_Return = 1 THEN

	ll_CurrentRow = of_GetCurrentRow ( )
	IF ll_CurrentRow > 0 THEN
		adw_Target.ScrollToRow ( ll_CurrentRow )
	END IF

END IF


RETURN li_Return
end event

public function integer of_setsource (powerobject apo_source);n_cst_dws	lnv_Dws
DataWindow	ldw_Source
DataStore	lds_Source
Long			ll_CurrentRow

Integer		li_Return = 1

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( apo_Source, ldw_Source, lds_Source )

CASE DataWindow!
	ll_CurrentRow = ldw_Source.GetRow ( )

CASE DataStore!
	ll_CurrentRow = lds_Source.GetRow ( )

CASE ELSE
	li_Return = -1

END CHOOSE


IF li_Return = 1 THEN

	ipo_Source = apo_Source

	IF ll_CurrentRow > 0 THEN
		This.Post of_SetCurrentRow ( ll_CurrentRow )
	END IF

END IF

RETURN li_Return
end function

public function integer of_setcurrentrow (long al_row);WindowObject	lwoa_Controls[], &
					lwo_Control
DataWindow		ldw_Target
Long	ll_TabCount, &
		ll_TabIndex, &
		ll_ControlCount, &
		ll_ControlIndex


//Set the CurrentRow flag first, so that scrolling the dw's will not cause a re-notification
//(calling this function again)
il_CurrentRow = al_Row


ll_TabCount = UpperBound ( This.Control )

FOR ll_TabIndex = 1 TO ll_TabCount

	lwoa_Controls = This.Control[ll_TabIndex].Control
	ll_ControlCount = UpperBound ( lwoa_Controls )

	FOR ll_ControlIndex = 1 TO ll_ControlCount

		lwo_Control = lwoa_Controls [ ll_ControlIndex ]

		IF lwo_Control.TriggerEvent ( is_TargetEvent ) = 1 THEN

			ldw_Target = lwo_Control
	
			IF ldw_Target.GetRow ( ) <> al_Row THEN
				ldw_Target.ScrollToRow ( al_Row )
			END IF

		END IF

	NEXT

NEXT


This.Post Event ue_SelectionChanged ( )

RETURN 1
end function

public function long of_getcurrentrow ();RETURN il_CurrentRow
end function

public function powerobject of_getsource ();RETURN ipo_Source
end function

event selectionchanging;//IF this is not the initial constructor (where OldIndex would be 0), 
//perform a pfc_AcceptText to be sure that data entered on the current page is valid.

Long	ll_Return = 0

IF OldIndex > 0 THEN

	IF This.Event pfc_AcceptText ( This.Control, TRUE ) = -1 THEN
		//AcceptText failed.  Prevent selection change by returning 1.
		ll_Return = 1
	END IF

END IF

RETURN ll_Return
		
end event

