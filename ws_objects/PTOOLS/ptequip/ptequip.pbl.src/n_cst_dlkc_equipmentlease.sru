$PBExportHeader$n_cst_dlkc_equipmentlease.sru
$PBExportComments$EquipmentLease (DataLink from PBL map PTData) //@(*)[75782811|875:bdm]<nosync>
forward
global type n_cst_dlkc_equipmentlease from n_cst_dlk
end type
end forward

global type n_cst_dlkc_equipmentlease from n_cst_dlk
end type
global n_cst_dlkc_equipmentlease n_cst_dlkc_equipmentlease

forward prototypes
public function Integer ModifyWhereClause ()
end prototypes

public function Integer ModifyWhereClause ();//@(*)[75782811|875:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
      
string ls_syntax
string ls_append
integer li_loop,li_end
any la_quotedargs[]

ls_syntax = ids_view.GetSqlSelect()

li_end = UpperBound(iany_args)
for li_loop = 1 to li_end
   if not isNull(iany_args[li_loop]) then
      la_quotedargs[li_loop] = iany_args[li_loop]
   end if
next

this.SetQuotes(la_quotedargs[])

CHOOSE CASE is_dlk_relation
   case ""
      ls_append = " WHERE ~"outside_equip~".~"oe_id~" = " + String(la_quotedargs[1])
   case "equipment"
      ls_append = " WHERE ~"outside_equip~".~"oe_id~" = " + String(la_quotedargs[1])

   case "equipmentleasetype"
      ls_append = " WHERE ~"outside_equip~".~"fkequipmentleasetype~" = " + String(la_quotedargs[1])

END CHOOSE
if ls_append <> "" then
   ls_syntax = ls_syntax + ls_append
   if ids_view.SetSqlSelect(ls_syntax) < 0 then
      this.PushException("modifywhereclause")
      return -1
   end if
 end if
//@(text)--

//@(text)(recreate=yes)<Return status>
return 1
//@(text)--

end function

on n_cst_dlkc_equipmentlease.create
TriggerEvent(this, "constructor")
end on

on n_cst_dlkc_equipmentlease.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_equipmentlease")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_equipmentlease", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("equipmentlease_leasedfrom", "n_cst_beo_equipmentlease", "leasedfrom")
this.MapAttribute("equipmentlease_onbehalfof", "n_cst_beo_equipmentlease", "onbehalfof")
this.MapAttribute("equipmentlease_bookingnumber", "n_cst_beo_equipmentlease", "bookingnumber")
this.MapAttribute("equipmentlease_timeout", "n_cst_beo_equipmentlease", "timeout")
this.MapAttribute("equipmentlease_timein", "n_cst_beo_equipmentlease", "timein")
this.MapAttribute("equipmentlease_originationevent", "n_cst_beo_equipmentlease", "originationevent")
this.MapAttribute("equipmentlease_terminationevent", "n_cst_beo_equipmentlease", "terminationevent")
this.MapAttribute("equipmentlease_user1", "n_cst_beo_equipmentlease", "user1")
this.MapAttribute("equipmentlease_user2", "n_cst_beo_equipmentlease", "user2")
this.MapAttribute("equipmentlease_notes", "n_cst_beo_equipmentlease", "notes")
this.MapAttribute("equipmentlease_timestamp", "n_cst_beo_equipmentlease", "timestamp")
this.MapAttribute("equipmentlease_oe_id", "n_cst_beo_equipmentlease", "oe_id")
this.MapAttribute("equipmentlease_fkequipmentleasetype", "n_cst_beo_equipmentlease", "fkequipmentleasetype")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("outside_equip")
this.MapDBColumn("equipmentlease_leasedfrom", "outside_equip", "oe_from", 0)
this.MapDBColumn("equipmentlease_onbehalfof", "outside_equip", "oe_for", 0)
this.MapDBColumn("equipmentlease_bookingnumber", "outside_equip", "oe_booknum", 0)
this.MapDBColumn("equipmentlease_timeout", "outside_equip", "oe_out", 0)
this.MapDBColumn("equipmentlease_timein", "outside_equip", "oe_in", 0)
this.MapDBColumn("equipmentlease_originationevent", "outside_equip", "oe_orig_event", 0)
this.MapDBColumn("equipmentlease_terminationevent", "outside_equip", "oe_term_event", 0)
this.MapDBColumn("equipmentlease_user1", "outside_equip", "User1", 0)
this.MapDBColumn("equipmentlease_user2", "outside_equip", "User2", 0)
this.MapDBColumn("equipmentlease_notes", "outside_equip", "Notes", 0)
this.MapDBColumn("equipmentlease_timestamp", "outside_equip", "timestamp", 0)
this.MapDBColumn("equipmentlease_oe_id", "outside_equip", "oe_id", 1)
this.MapDBColumn("equipmentlease_fkequipmentleasetype", "outside_equip", "fkEquipmentLeaseType", 0)
//@(data)--

end event

