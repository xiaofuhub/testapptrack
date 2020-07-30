$PBExportHeader$w_graphic_setup.srw
forward
global type w_graphic_setup from Window
end type
type uo_graphic_setup from u_graphic_setup within w_graphic_setup
end type
end forward

global type w_graphic_setup from Window
int X=833
int Y=361
int Width=2652
int Height=1417
boolean TitleBar=true
string Title="Logo Setup"
string MenuName="m_shiptype_edit"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
uo_graphic_setup uo_graphic_setup
end type
global w_graphic_setup w_graphic_setup

type variables
protected:
boolean ib_winisclosing
end variables

forward prototypes
public subroutine wf_save_request ()
public subroutine wf_new ()
end prototypes

public subroutine wf_save_request ();uo_graphic_setup.of_save_if_needed("SAVE_REQUEST!")
end subroutine

public subroutine wf_new ();uo_graphic_setup.of_new()
end subroutine

event open;this.x = 1
this.y = 1

gf_mask_menu(m_shiptype_edit)

uo_graphic_setup.of_set_parent(this)

if uo_graphic_setup.of_retrieve_list() = -1 then
	messagebox("Logo Setup", "Could not retrieve information from database.  "+&
		"Request cancelled.", exclamation!)
	ib_winisclosing = true
	close(this)
	return
end if
end event

event closequery;if ib_winisclosing then return 0

if uo_graphic_setup.of_save_if_needed("CLOSE_WINDOW!") = -1 then return 1
end event

on w_graphic_setup.create
if this.MenuName = "m_shiptype_edit" then this.MenuID = create m_shiptype_edit
this.uo_graphic_setup=create uo_graphic_setup
this.Control[]={ this.uo_graphic_setup}
end on

on w_graphic_setup.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_graphic_setup)
end on

type uo_graphic_setup from u_graphic_setup within w_graphic_setup
int X=23
int Y=9
int TabOrder=1
end type

on uo_graphic_setup.destroy
call u_graphic_setup::destroy
end on

