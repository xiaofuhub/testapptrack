$PBExportHeader$u_cst_syssettings_email_populate.sru
forward
global type u_cst_syssettings_email_populate from u_cst_syssettings_generic_populate
end type
end forward

global type u_cst_syssettings_email_populate from u_cst_syssettings_generic_populate
end type
global u_cst_syssettings_email_populate u_cst_syssettings_email_populate

on u_cst_syssettings_email_populate.create
int iCurrent
call super::create
end on

on u_cst_syssettings_email_populate.destroy
call super::destroy
end on

event ue_setproperty;call super::ue_setproperty;


uo_1.event ue_SetColumnHeader(inv_syssetting.of_getcolheader( ))


RETURN 1
end event

type uo_1 from u_cst_syssettings_generic_populate`uo_1 within u_cst_syssettings_email_populate
end type

event uo_1::ue_collectitems;call super::ue_collectitems;Int li_Ctr
Long ll_RowCount
String ls_Values
String ls_Item

dw_1.AcceptText()
ll_RowCount = dw_1.RowCount()

FOR li_Ctr = 1 TO ll_RowCount
	ls_Item = dw_1.Object.Values[li_Ctr] 
	IF IsNull(ls_Item) THEN
		Exit
	END IF
	ls_Values = ls_Values + ls_Item + ';'
NEXT 

ls_Values = Left(ls_Values,(Len(ls_Values) - 1))

Return ls_Values
end event

event uo_1::ue_savevalues;call super::ue_savevalues;String	lsa_Emails[]
String	ls_Temp
Long	ll_EmailCount
Long	i,li_Count
String	ls_value

li_Count = dw_1.RowCOunt ( )
FOR i = 1 TO li_Count
	ls_Temp= dw_1.GetItemString ( i,"values") 
	IF len(ls_temp) > 0 THEN
		ll_EmailCount ++
		lsa_emails[ll_emailCount] = ls_temp
	END IF
NEXT

li_Count = upperBound( lsa_emails )
FOR i = 1 TO li_count
	ls_value += lsa_emails[i]
	IF i < li_count THEN
		ls_value += ";"
	END IF
NEXT

inv_syssetting.of_Savevalue( ls_value )

end event

event uo_1::ue_rowadded;call super::ue_rowadded;String	ls_values

IF al_newRow > 0 THEN

	ls_Values = event ue_collectitems( ) 
	event ue_savevalues(ls_Values)
END IF
end event

