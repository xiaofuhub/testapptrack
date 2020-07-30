$PBExportHeader$n_cst_billseq.sru
forward
global type n_cst_billseq from nonvisualobject
end type
end forward

global type n_cst_billseq from nonvisualobject autoinstantiate
end type

type variables
public:
datastore ids_billseq

protected:
boolean ib_retrieved
end variables

forward prototypes
public function integer of_refresh ()
public function integer of_find (long al_target_id, ref long al_foundrow)
public function boolean of_ready (boolean ab_force_refresh)
end prototypes

public function integer of_refresh ();boolean lb_failed
long ll_rowcount, ll_row
datastore lds_target, lds_back
string ls_dbstring, ls_work
n_cst_string lnv_string

setpointer(hourglass!)

//d_billseq_edit is used instead of d_billseq_list to give access to comp_next_invoice
//and update capabilities, which are used in the billing process

if not isvalid(ids_billseq) then
	ids_billseq = create datastore
	ids_billseq.dataobject = "d_billseq_edit"
	ids_billseq.settransobject(sqlca)
elseif ids_billseq.rowcount() > 0 then
	lds_back = create datastore
	lds_back.dataobject = "d_billseq_edit"
	lds_back.object.data.primary = ids_billseq.object.data.primary
end if

lds_target = ids_billseq

ll_rowcount = lds_target.retrieve()

if ll_rowcount = -1 then
	rollback ;
	lb_failed = true
	goto cleanup
else
	commit ;
end if

for ll_row = 1 to ll_rowcount
	ls_dbstring = lds_target.object.bs_dbstring[ll_row]
	lds_target.object.bs_name[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "NAME")
	lds_target.object.bs_definition[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "DEFINITION")
next

cleanup:

if lb_failed then
	lds_target.reset()
	if isvalid(lds_back) then
		if lds_back.rowcount() > 0 then &
			lds_target.object.data.primary = lds_back.object.data.primary
	end if
end if

lds_target.resetupdate()
destroy lds_back

if lb_failed then
	return -1
else
	ib_retrieved = true
	return 1
end if
end function

public function integer of_find (long al_target_id, ref long al_foundrow);long ll_row

al_foundrow = 0
if isnull(al_target_id) then return 1
if this.of_ready(false) = false then return -1

ll_row = ids_billseq.find("bs_id = " + string(al_target_id), 1, ids_billseq.rowcount())

choose case ll_row
case is > 0
	al_foundrow = ll_row
	return 1
case 0
	return 0
case else
	return -1
end choose
end function

public function boolean of_ready (boolean ab_force_refresh);if ib_retrieved = false or ab_force_refresh then
	if this.of_refresh() = -1 then return false
end if

return true
end function

on n_cst_billseq.create
TriggerEvent( this, "constructor" )
end on

on n_cst_billseq.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;destroy ids_billseq
end event

