$PBExportHeader$u_cst_syssettings_nextbreaktables.sru
forward
global type u_cst_syssettings_nextbreaktables from u_picktable
end type
end forward

global type u_cst_syssettings_nextbreaktables from u_picktable
integer width = 1792
integer height = 1252
long backcolor = 67108864
event ue_setproperty ( n_cst_syssettings anv_settings )
event type integer ue_validatecontrols ( )
end type
global u_cst_syssettings_nextbreaktables u_cst_syssettings_nextbreaktables

type variables
n_cst_syssettings	inv_syssetting
end variables

event ue_setproperty(n_cst_syssettings anv_settings);string	lsa_ratecode[]

anv_settings.of_GetValue ( lsa_ratecode )

//this.of_Setlist(lsa_Ratecode)
long	ll_arraycount, &
		ll_rowcount, &
		ll_index, &
		ll_row
		
string	ls_table		

dw_1.Reset()

ll_arraycount = upperbound(lsa_ratecode)
ll_rowcount = ids_RateTableNames.rowcount()

//copy rows in reverse order so priority won't change
for ll_index = 1 to ll_arraycount
	ls_table = lsa_ratecode[ll_index]
	ll_row = ids_RateTableNames.find("codename = '" + ls_table + "'", 1, ll_rowcount)
	if ll_row > 0 then
		ids_RateTableNames.RowsCopy (ll_row, ll_row, Primary!, dw_1, dw_1.rowcount() + 1, Primary! )
	end if
next

if dw_1.rowcount() > 0 then
	dw_1.post SelectRow(1,true)
end if
end event

event type integer ue_validatecontrols();return 1

end event

on u_cst_syssettings_nextbreaktables.create
call super::create
end on

on u_cst_syssettings_nextbreaktables.destroy
call super::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ratingnextbreak


//event ue_setvalue(inv_syssetting)
end event

event ue_postconstructor;event ue_setproperty(inv_syssetting)
end event

type dw_tablenames from u_picktable`dw_tablenames within u_cst_syssettings_nextbreaktables
integer x = 50
integer y = 180
integer width = 1682
integer height = 220
end type

event dw_tablenames::constructor;call super::constructor;this.object.name_t.x=737
this.object.name_t.background.color=67108864
this.object.codename.x=46
this.object.codename.y=96
this.object.codename_t.background.color=67108864
this.object.name.x=750
this.object.name.y=96
this.Object.DataWindow.Detail.Height = 196
this.Object.DataWindow.color = 67108864
end event

type dw_1 from u_picktable`dw_1 within u_cst_syssettings_nextbreaktables
integer x = 50
integer y = 636
integer width = 1682
integer height = 544
integer taborder = 40
end type

type cb_add from u_picktable`cb_add within u_cst_syssettings_nextbreaktables
integer x = 1504
integer y = 88
end type

event cb_add::clicked;call super::clicked;long		ll_ndx, &
			ll_count
			
string	lsa_List[], &
			ls_list, &
			ls_Value

of_GetList(lsa_List)


ll_count = upperbound(lsa_list)

FOR ll_ndx = 1 TO ll_count
	ls_value= lsa_list[ll_ndx] 
	IF IsNull(ls_value) THEN
		continue
	END IF
	ls_list = ls_list + ls_value + ','
NEXT 

ls_list = Left(ls_list,(Len(ls_list) - 1))

inv_syssetting.of_Savevalue(ls_list)
end event

type cb_delete from u_picktable`cb_delete within u_cst_syssettings_nextbreaktables
integer x = 1504
integer y = 516
integer taborder = 30
end type

event cb_delete::clicked;call super::clicked;long		ll_ndx, &
			ll_count
			
string	lsa_List[], &
			ls_list, &
			ls_Value

of_GetList(lsa_List)


ll_count = upperbound(lsa_list)

FOR ll_ndx = 1 TO ll_count
	ls_value= lsa_list[ll_ndx] 
	IF IsNull(ls_value) THEN
		continue
	END IF
	ls_list = ls_list + ls_value + ','
NEXT 

ls_list = Left(ls_list,(Len(ls_list) - 1))

inv_syssetting.of_Savevalue(ls_list)
end event

type gb_2 from u_picktable`gb_2 within u_cst_syssettings_nextbreaktables
integer x = 9
integer y = 452
integer width = 1765
integer height = 772
long backcolor = 67108864
end type

type gb_1 from u_picktable`gb_1 within u_cst_syssettings_nextbreaktables
integer x = 9
integer width = 1765
integer height = 404
long backcolor = 67108864
end type

type st_1 from u_picktable`st_1 within u_cst_syssettings_nextbreaktables
boolean visible = false
integer x = 448
integer y = 1456
end type

type cb_insert from u_picktable`cb_insert within u_cst_syssettings_nextbreaktables
boolean visible = false
integer x = 46
integer y = 1452
integer taborder = 0
end type

