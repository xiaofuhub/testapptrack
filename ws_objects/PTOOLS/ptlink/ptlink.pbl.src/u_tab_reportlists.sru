$PBExportHeader$u_tab_reportlists.sru
forward
global type u_tab_reportlists from u_tab
end type
type tabpage_general from u_tabpg_filelistpage within u_tab_reportlists
end type
type tabpage_general from u_tabpg_filelistpage within u_tab_reportlists
end type
type tabpage_user from u_tabpg_filelistpage within u_tab_reportlists
end type
type tabpage_user from u_tabpg_filelistpage within u_tab_reportlists
end type
end forward

global type u_tab_reportlists from u_tab
integer width = 1225
integer height = 1292
long backcolor = 12632256
tabpage_general tabpage_general
tabpage_user tabpage_user
event ue_selectionchanged ( )
event ue_doubleclicked ( long al_index )
end type
global u_tab_reportlists u_tab_reportlists

forward prototypes
public function integer of_selectionchanged (long al_index)
public function string of_getfilenname ()
public function integer of_inittab (string as_path, string as_context)
public function integer of_setselectedtab ()
end prototypes

public function integer of_selectionchanged (long al_index);this.event ue_selectionChanged(  )
return 1
end function

public function string of_getfilenname ();String	ls_path

IF this.selectedTab > 0 THEN
	ls_path = this.control[this.selectedTab].dynamic of_getFile( )
END IF

return ls_path
end function

public function integer of_inittab (string as_path, string as_context);//create a tab
String	ls_user	

u_tabpg_fileListPage		ltpg_context
u_tabpg_fileListPage 	ltpg_contextUser

this.opentab( ltpg_context, upperBound( this.control )+1)
this.opentab( ltpg_contextUser, upperBound( this.control )+1)

ls_user = gnv_app.of_getuserid( )

IF isValid( ltpg_context ) THEN
	ltpg_context.text = as_context
	ltpg_context.of_initialize( as_path, as_context, 0 )
END IF

IF isValid( ltpg_contextUser ) THEN
	ltpg_contextUser.text = "User/" + as_context
	ltpg_contextUser.of_initialize( as_path + ls_user + "\", as_context, 0 )
END IF

return 1
end function

public function integer of_setselectedtab ();Long	ll_index
Long	ll_max

Long	ll_total
Int 	li_return

ll_max = upperBound( this.control )
IF ll_max > 2 THEN	
	FOR ll_index = 3 TO ll_max
		ll_total = this.Control[ll_index].dynamic of_getTotalItems( )
		
		IF ll_total > 0 THEN
			this.selecttab( ll_index )
			RETURN ll_index
		END IF
	NEXT
	
END IF
	
IF this.selectedTab = 1 THEN
	IF this.tabpage_general.enabled THEN
		li_return = 1
	ELSEIF this.tabpage_user.enabled THEN
		this.selecttab( 2 )
		li_return = 2
	END IF
END IF
RETURN li_return
end function

on u_tab_reportlists.create
this.tabpage_general=create tabpage_general
this.tabpage_user=create tabpage_user
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_general
this.Control[iCurrent+2]=this.tabpage_user
end on

on u_tab_reportlists.destroy
call super::destroy
destroy(this.tabpage_general)
destroy(this.tabpage_user)
end on

type tabpage_general from u_tabpg_filelistpage within u_tab_reportlists
integer x = 18
integer y = 100
integer width = 1189
integer height = 1176
string text = "General"
end type

event constructor;call super::constructor;String	ls_root

n_cst_setting_templatespathfolder	lnv_TemplatePath
lnv_TemplatePath = CREATE n_cst_setting_templatespathfolder

ls_Root = lnv_TemplatePath.of_GetValue ( ) + "Reports\"

this.of_initialize( ls_root, "General", 0 )

DESTROY ( lnv_TemplatePath )
end event

type tabpage_user from u_tabpg_filelistpage within u_tab_reportlists
integer x = 18
integer y = 100
integer width = 1189
integer height = 1176
string text = "User"
end type

event constructor;call super::constructor;String	ls_root
String	ls_user

n_cst_setting_templatespathfolder	lnv_TemplatePath
lnv_TemplatePath = CREATE n_cst_setting_templatespathfolder

ls_Root = lnv_TemplatePath.of_GetValue ( ) + "Reports\"

ls_user = gnv_app.of_getUserId( )

//populate the list box with user properties that are of psr type all read and write
this.of_initialize( ls_root + ls_user + "\", "general/user", 0)
end event

