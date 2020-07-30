$PBExportHeader$n_cst_dlk.sru
forward
global type n_cst_dlk from ofr_n_cst_dlk
end type
end forward

global type n_cst_dlk from ofr_n_cst_dlk
event type integer pt_computecolumn ( readonly string as_columnname,  readonly long al_startrow,  readonly long al_endrow,  ref any aaa_values[] )
end type
global n_cst_dlk n_cst_dlk

forward prototypes
public function integer setquotes (ref any aa_argvalue[])
end prototypes

event pt_computecolumn;//Returns:  1 = Success.  Values returned by reference in aaa_Values[]
//				0 = No compute ability for the column requested.
//			  -1 = Error. 

//Extend this event in descendants if there are any computed columns
//that need to be computed outside of the beo.

//Clear any existing values in the array being passed in.
Any	laa_Empty[]
aaa_Values = laa_Empty[]

Long		ll_Row, &
			ll_Index, &
			ll_BeoIndex
Boolean	lb_NoValue
s_Any		lstr_Any, &
			lstr_Empty
n_cst_beo	lnv_Beo

Integer	li_Return = 1


FOR ll_Row = al_StartRow TO al_EndRow

	ll_Index ++

	ll_BeoIndex = ids_View.GetBeoIndex ( ll_Row )
	lnv_Beo = inv_Bcm.GetAt ( ll_BeoIndex )

	IF IsValid ( lnv_Beo ) THEN

		lstr_Any = lstr_Empty

		CHOOSE CASE lnv_Beo.Get ( as_ColumnName, lstr_Any.ia_Value )

		CASE 0
			li_Return = 0
			EXIT

		CASE 1
			aaa_Values [ ll_Index ] = lstr_Any

		CASE ELSE //-1
			aaa_Values = laa_Empty
			li_Return = -1
			EXIT

		END CHOOSE

	END IF

NEXT

RETURN li_Return
end event

public function integer setquotes (ref any aa_argvalue[]);//Override to format datetimes, dates, and times in a way that the db will understand

string ls_class
any la_newval
integer li_loop, li_end

li_end = UpperBound(aa_argvalue)

if li_end = 0 then
	aa_argvalue[1] = ""
	li_end = 1
end if

for li_loop = 1 to li_end
	ls_class = ClassName(aa_argvalue[li_loop])
	la_newval = aa_argvalue[li_loop]

//	HOW Version
//	Choose Case ls_class	
//		Case 'string','date', 'datetime', 'time', 'char'
//			aa_argvalue[li_loop] = "~'" + string(la_newval) + "~'"
//	End Choose

	Choose Case ls_class	
		Case 'string', 'char'
			aa_argvalue[li_loop] = "~'" + string(la_newval) + "~'"
		Case 'datetime'
			aa_argvalue[li_loop] = "~'" + string(la_newval, "yyyy-mm-dd hh:mm:ss.ffffff") + "~'"
		Case 'date'
			aa_argvalue[li_loop] = "~'" + string(la_newval, "yyyy-mm-dd") + "~'"
		Case 'time'
			aa_argvalue[li_loop] = "~'" + string(la_newval, "hh:mm:ss.ffffff") + "~'"
	End Choose
next

return 1
end function

on n_cst_dlk.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dlk.destroy
TriggerEvent( this, "destructor" )
end on

