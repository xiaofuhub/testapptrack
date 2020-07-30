$PBExportHeader$w_billseq_edit.srw
forward
global type w_billseq_edit from Window
end type
type uo_billseq_edit from u_billseq_edit within w_billseq_edit
end type
end forward

global type w_billseq_edit from Window
int X=833
int Y=361
int Width=2451
int Height=1133
boolean TitleBar=true
string Title="Invoice Series Setup"
string MenuName="m_shiptype_edit"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
uo_billseq_edit uo_billseq_edit
end type
global w_billseq_edit w_billseq_edit

type variables
protected:
boolean ib_winisclosing
end variables

forward prototypes
public subroutine wf_save_request ()
public subroutine wf_new ()
end prototypes

public subroutine wf_save_request ();uo_billseq_edit.of_save_if_needed("SAVE_REQUEST!")
end subroutine

public subroutine wf_new ();uo_billseq_edit.of_new()
end subroutine

event open;this.x = 1
this.y = 1

gf_mask_menu(m_shiptype_edit)

uo_billseq_edit.of_set_parent(this)

if uo_billseq_edit.of_retrieve_list() = -1 then
	messagebox("Invoice Series Setup", "Could not retrieve information from database.  "+&
		"Request cancelled.", exclamation!)
	ib_winisclosing = true
	close(this)
	return
end if
end event

on w_billseq_edit.create
if this.MenuName = "m_shiptype_edit" then this.MenuID = create m_shiptype_edit
this.uo_billseq_edit=create uo_billseq_edit
this.Control[]={ this.uo_billseq_edit}
end on

on w_billseq_edit.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_billseq_edit)
end on

event closequery;if ib_winisclosing then return 0

if uo_billseq_edit.of_save_if_needed("CLOSE_WINDOW!") = -1 then return 1
end event

type uo_billseq_edit from u_billseq_edit within w_billseq_edit
int X=37
int Y=33
int TabOrder=1
end type

on uo_billseq_edit.destroy
call u_billseq_edit::destroy
end on

