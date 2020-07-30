$PBExportHeader$n_cst_print.sru
forward
global type n_cst_print from nonvisualobject
end type
end forward

global type n_cst_print from nonvisualobject autoinstantiate
end type

forward prototypes
public function integer of_print_objects (readonly powerobject apoa_objects[], string as_message_header, string as_job_name, integer ai_copies)
end prototypes

public function integer of_print_objects (readonly powerobject apoa_objects[], string as_message_header, string as_job_name, integer ai_copies);long ll_pj
integer li_choice, li_result, li_copy_loop, li_object_loop
string ls_visible
datawindow ldw_target
datastore lds_target
window lw_target
n_cst_numerical lnv_numerical

if lnv_numerical.of_IsNullOrNotPos(len(as_message_header)) then as_message_header = "Print Request"
if lnv_numerical.of_IsNullOrNotPos(len(as_job_name)) then as_job_name = "Profit Tools Special Request"
if lnv_numerical.of_IsNullOrNotPos(ai_copies) then ai_copies = 1

if printsetup() = -1 then
	messagebox(as_message_header, "Error executing printer setup. Request cancelled.", &
		exclamation!)
	return -1
end if

setpointer(hourglass!)

do
	ll_pj = printopen(as_job_name)
	if ll_pj = -1 then
		li_choice = messagebox(as_message_header, "Could not open print job -- Retry?", &
			exclamation!, retrycancel!, 1)
	else

		for li_copy_loop = 1 to ai_copies
			for li_object_loop = 1 to upperbound(apoa_objects)
				choose case apoa_objects[li_object_loop].typeof()
				case datawindow!
					ldw_target = apoa_objects[li_object_loop]

					//If there is no r_hlt, these describe and modify statements will
					//fail harmlessly.

					ls_visible = ldw_target.describe("r_hlt.visible")
					ldw_target.modify("r_hlt.visible = '0'")

					li_result = printdatawindow(ll_pj, ldw_target)

					ldw_target.modify("r_hlt.visible = " + ls_visible)
					ldw_target.setredraw(true)

				case datastore!
					lds_target = apoa_objects[li_object_loop]

					ls_visible = lds_target.describe("r_hlt.visible")
					lds_target.modify("r_hlt.visible = '0'")

					li_result = printdatawindow(ll_pj, lds_target)
					lds_target.modify("r_hlt.visible = " + ls_visible)

				case window!
					lw_target = apoa_objects[li_object_loop]
					li_result = lw_target.print(ll_pj, 1, 1)
				end choose
				if li_result = -1 then exit
			next
			if li_result = -1 then exit
		next

		if li_result = -1 then
			printcancel(ll_pj)
			li_choice = messagebox(as_message_header, "Error attempting to print -- Retry?", &
				exclamation!, retrycancel!, 1)
		else
			li_result = printclose(ll_pj)
			if li_result = -1 then
				printcancel(ll_pj)
				li_choice = messagebox(as_message_header, "Error attempting to print -- Retry?", &
					exclamation!, retrycancel!, 1)
			end if
		end if
	end if
loop until li_result = 1 or li_choice = 2

if li_result = 1 then return 1 else return -1
end function

on n_cst_print.create
TriggerEvent( this, "constructor" )
end on

on n_cst_print.destroy
TriggerEvent( this, "destructor" )
end on

