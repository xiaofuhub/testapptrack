$PBExportHeader$u_tabpg_filelistpage.sru
forward
global type u_tabpg_filelistpage from u_tabpg
end type
type uo_filelist from u_cst_filelist within u_tabpg_filelistpage
end type
end forward

global type u_tabpg_filelistpage from u_tabpg
integer width = 1440
integer height = 1188
long backcolor = 12632256
long tabbackcolor = 12632256
event ue_doubleclicked ( )
uo_filelist uo_filelist
end type
global u_tabpg_filelistpage u_tabpg_filelistpage

type variables
string	is_path
string	is_context
end variables

forward prototypes
public function string of_getfile ()
public function integer of_initialize (string as_path, string as_context, long ls_filetype)
public function integer of_gettotalitems ()
public function integer of_selectionchanged ()
end prototypes

event ue_doubleclicked();//the following code has to be here in the event that this page is created
//dynamically

IF isValid( parent ) THEN
		parent.triggerEvent("ue_doubleClicked")
	
END IF
end event

public function string of_getfile ();return is_path + uo_fileList.of_getSelection()
end function

public function integer of_initialize (string as_path, string as_context, long ls_filetype);is_path = as_path
is_context = as_context

//loads the listbox on the nonvisual with the files of the specified type
//into the listbox on the object.

IF this.uo_filelist.of_loadListBox( as_path+"*.PSR", ls_fileType ) = -1 THEN
	this.enabled = false
END IF

return 1
end function

public function integer of_gettotalitems ();return this.uo_filelist.of_getTotalitems( )
end function

public function integer of_selectionchanged ();//this code was put directly on this object so that the pages can be added
//dynamically to u_tab_reportlists, and still function properly

Int	li_return

IF parent.className() = "tab_report" THEN
	parent.triggerEvent( "ue_selectionchanged")
	li_return = 1
ELSE
	li_return = -1
END IF
return li_return


end function

on u_tabpg_filelistpage.create
int iCurrent
call super::create
this.uo_filelist=create uo_filelist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_filelist
end on

on u_tabpg_filelistpage.destroy
call super::destroy
destroy(this.uo_filelist)
end on

type uo_filelist from u_cst_filelist within u_tabpg_filelistpage
integer y = 16
integer width = 1376
integer taborder = 20
end type

on uo_filelist.destroy
call u_cst_filelist::destroy
end on

event ue_selectionchanged;call super::ue_selectionchanged;//MessageBox("tabpage/listbox", "calling of_select change on parent")
parent.of_selectionchanged(  )
end event

event ue_doubleclicked;call super::ue_doubleclicked;parent.event ue_doubleclicked(  )
end event

