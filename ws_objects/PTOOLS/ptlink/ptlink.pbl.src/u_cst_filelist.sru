$PBExportHeader$u_cst_filelist.sru
forward
global type u_cst_filelist from userobject
end type
type lb_filelist from listbox within u_cst_filelist
end type
end forward

global type u_cst_filelist from userobject
integer width = 1362
integer height = 1160
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_selectionchanged ( long al_index )
event ue_doubleclicked ( )
lb_filelist lb_filelist
end type
global u_cst_filelist u_cst_filelist

forward prototypes
public function integer of_selectionchanged ()
public function string of_getselection ()
public function integer of_loadlistbox (string as_path, long ls_filetype)
public function long of_gettotalitems ()
end prototypes

public function integer of_selectionchanged ();long	ll_index

this.event ue_selectionchanged( ll_index )
return 1
end function

public function string of_getselection ();return lb_filelist.selectedItem( )
end function

public function integer of_loadlistbox (string as_path, long ls_filetype);IF lb_filelist.dirlist( as_path, ls_fileType ) THEN
	IF lb_fileList.totalitems( ) > 0 THEN
		return 1
	ELSE
		return -1
	END IF
ELSE
	return -1
END IF

end function

public function long of_gettotalitems ();return this.lb_filelist.totalitems( )
end function

on u_cst_filelist.create
this.lb_filelist=create lb_filelist
this.Control[]={this.lb_filelist}
end on

on u_cst_filelist.destroy
destroy(this.lb_filelist)
end on

type lb_filelist from listbox within u_cst_filelist
integer x = 18
integer y = 16
integer width = 1335
integer height = 1124
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;parent.event ue_selectionchanged( index )
end event

event doubleclicked;parent.event ue_doubleClicked()
end event

