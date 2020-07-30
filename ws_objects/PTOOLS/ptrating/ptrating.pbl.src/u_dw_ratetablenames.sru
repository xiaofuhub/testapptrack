$PBExportHeader$u_dw_ratetablenames.sru
forward
global type u_dw_ratetablenames from u_dw
end type
end forward

global type u_dw_ratetablenames from u_dw
integer width = 2313
integer height = 124
string dataobject = "d_ratetablenames_dddw"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type
global u_dw_ratetablenames u_dw_ratetablenames

type variables
DataWindowChild	idwc_Names, &
		idwc_CodeNames

end variables

forward prototypes
public function long of_getchildddws (ref datawindowchild adwca_value[])
public function datawindowchild of_getnamechild ()
public function datawindowchild of_getcodenamechild ()
public subroutine of_filterbyitemtype (string as_type)
end prototypes

public function long of_getchildddws (ref datawindowchild adwca_value[]);adwca_value[1]=idwc_Names
adwca_value[2]=idwc_CodeNames

return upperbound(adwca_value)
end function

public function datawindowchild of_getnamechild ();return idwc_Names


end function

public function datawindowchild of_getcodenamechild ();return idwc_CodeNames

end function

public subroutine of_filterbyitemtype (string as_type);string	ls_filterstring, &
			ls_value


if len(as_type) > 0 then
	
	ls_filterstring = "amounttype_itemtype = '" + as_type + "'"
	
ELSE 
	
	// this could be because the user has selected the auto add item type
	// in which case the item type will be defined by the amount type type. 
	// therefore we want all amount type types to be available
	ls_FilterString = ""
	
END IF


	
if isvalid(idwc_codenames) then
	idwc_codenames.setfilter( ls_filterstring )
	idwc_codenames.filter( )
	if idwc_codenames.rowcount() > 0 then
		ls_value = idwc_codenames.GetItemString(1,"codename")
		this.object.codename[1] = ls_value
	end if
end if

if isvalid(idwc_names) then
	idwc_names.setfilter( ls_filterstring )
	idwc_names.filter( )	
	if idwc_names.rowcount() > 0 then
		ls_value = idwc_names.getitemstring(1,"name")
		this.object.name[1] = ls_value
	end if
end if





end subroutine

event constructor;THIS.GetChild ( "name" , idwc_Names )
THIS.GetChild ( "codename" , idwc_CodeNames )
end event

event itemchanged;call super::itemchanged;integer	ll_return
long		ll_foundrow
string	ls_findstring, &
			ls_value

ll_return = AncestorReturnvalue
if ll_Return = 0 then
	CHOOSE CASE dwo.name
		case 'codename','name'
			if dwo.name = 'codename'then
				ls_findstring = "codename = '" + data + "'"
				ll_foundrow = idwc_names.find(ls_findstring,1,idwc_names.rowcount())
				if ll_foundrow > 0 then
					ls_value = idwc_names.getitemstring(ll_foundrow,"name")
					this.object.name[row] = ls_value
				else
					messagebox("Rate Table ","Rate table not found.")
					ll_return = 1
				end if
			end if
			if dwo.name = 'name' then
				ls_findstring = "name = '" + data + "'"
				ll_foundrow = idwc_Codenames.find(ls_findstring,1,idwc_Codenames.rowcount())
				if ll_foundrow > 0 then
					ls_value = idwc_codenames.GetItemString(ll_foundrow,"codename")
					this.object.codename[row] = ls_value
				else
					messagebox("Rate Table ","Rate table not found.")
					ll_return = 1
				end if
			end if
	
	END CHOOSE
end if

return ll_return
end event

event itemerror;call super::itemerror;long	ll_return, &
		ll_len

ll_return = AncestorReturnvalue
if ll_Return = 0 then
	CHOOSE CASE dwo.name
		case 'codename', 'name'
			ll_len = len(data)
			if ll_len > 0 then
				This.Post selecttext(1, ll_len)			
			end if
			ll_return = 1
	END CHOOSE
end if

return ll_return



end event

on u_dw_ratetablenames.create
end on

on u_dw_ratetablenames.destroy
end on

