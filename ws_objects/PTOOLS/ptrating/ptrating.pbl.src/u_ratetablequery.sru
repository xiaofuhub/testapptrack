$PBExportHeader$u_ratetablequery.sru
forward
global type u_ratetablequery from u_picktable
end type
end forward

global type u_ratetablequery from u_picktable
int Width=1714
int Height=236
end type
global u_ratetablequery u_ratetablequery

forward prototypes
public function string of_getcodename ()
public function string of_getitemtype ()
end prototypes

public function string of_getcodename ();return dw_tablenames.object.codename[dw_tablenames.getrow()]


end function

public function string of_getitemtype ();long	ll_row, &
		ll_rowcount, &
		ll_found

string	ls_table, &
			ls_return

ls_table = dw_tablenames.object.codename[dw_tablenames.getrow()]

if len(trim(ls_table)) > 0 then
	ll_rowcount = ids_RateTableNames.rowcount()
	if ll_rowcount > 0 then
		ll_found = ids_RateTableNames.find("codename = '" + ls_table + "'", 1, ll_rowcount)
		if ll_found > 0 then
			ls_return = ids_RateTableNames.object.amounttype_itemtype[ll_found]
		end if
	end if
end if

return ls_return
end function

on u_ratetablequery.create
call super::create
end on

on u_ratetablequery.destroy
call super::destroy
end on

event constructor;this.of_setratetablenamecache()

this.setredraw(false)

this.event post ue_postconstructor()

end event

event ue_postconstructor;call super::ue_postconstructor;ids_ratetablenames.insertrow(1)

idwc_codename.reset()
ids_RateTableNames.rowscopy(1, ids_RateTableNames.rowcount(), primary!, idwc_codename, 1, primary!)
idwc_codename.sort()

idwc_name.reset()
ids_RateTableNames.rowscopy(1, ids_RateTableNames.rowcount(), primary!, idwc_name, 1, primary!)
idwc_name.sort()

dw_tablenames.object.codename[1]=''
dw_tablenames.object.name[1]=''
dw_tablenames.setcolumn('codename')
dw_tablenames.setrow(1)
dw_tablenames.post setfocus()

this.setredraw(true)
end event

type dw_tablenames from u_picktable`dw_tablenames within u_ratetablequery
int X=9
int Y=12
int Height=228
boolean BringToTop=true
end type

event dw_tablenames::constructor;call super::constructor; 
this.object.name_t.x=737
this.object.codename.x=46
this.object.codename.y=96
this.object.name.x=750
this.object.name.y=96
this.Object.DataWindow.Detail.Height = 196
end event

event dw_tablenames::itemchanged;long	ll_found

CHOOSE CASE UPPER(dwo.name)
	CASE "NAME"
		if len(trim(data)) > 0 then
			ll_found = ids_RateTableNames.find("name = '" + data + "'", 1, ids_RateTableNames.rowcount())
			if ll_found > 0 then
				this.object.codename[row] = ids_RateTableNames.object.codename[ll_found]
			end if
		else
			this.object.codename[row] = ''
		end if
	CASE  "CODENAME"
		if len(trim(data)) > 0 then
			ll_found = ids_RateTableNames.find("codename = '" + data + "'", 1, ids_RateTableNames.rowcount())
			if ll_found > 0 then
				this.object.name[row] = ids_RateTableNames.object.name[ll_found]
			end if
		else
			this.object.name[row] = ''
		end if
END CHOOSE


end event

type dw_1 from u_picktable`dw_1 within u_ratetablequery
int X=0
int Y=572
boolean Visible=false
boolean BringToTop=true
end type

type cb_add from u_picktable`cb_add within u_ratetablequery
boolean Visible=false
boolean BringToTop=true
end type

type cb_delete from u_picktable`cb_delete within u_ratetablequery
boolean Visible=false
boolean BringToTop=true
end type

type st_1 from u_picktable`st_1 within u_ratetablequery
int Y=460
boolean Visible=false
boolean BringToTop=true
end type

