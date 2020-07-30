$PBExportHeader$n_cst_dlkc_equipment.sru
$PBExportComments$Equipment (DataLink from PBL map PTData) //@(*)[75782057|857:bdm]<nosync>
forward
global type n_cst_dlkc_equipment from n_cst_dlk
end type
end forward

global type n_cst_dlkc_equipment from n_cst_dlk
end type
global n_cst_dlkc_equipment n_cst_dlkc_equipment

forward prototypes
public function Integer ModifyWhereClause ()
end prototypes

public function Integer ModifyWhereClause ();//@(*)[75782057|857:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"equipment~".~"eq_id~" = " + String(la_quotedargs[1])
   case "equipmentlease"
      ls_append = " WHERE ~"equipment~".~"eq_id~" = " + String(la_quotedargs[1])

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

on n_cst_dlkc_equipment.create
TriggerEvent(this, "constructor")
end on

on n_cst_dlkc_equipment.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_equipment")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_equipment", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("equipment_id", "n_cst_beo_equipment", "id")
this.MapAttribute("equipment_type", "n_cst_beo_equipment", "type")
this.MapAttribute("equipment_number", "n_cst_beo_equipment", "number")
this.MapAttribute("equipment_leased", "n_cst_beo_equipment", "leased")
this.MapAttribute("equipment_status", "n_cst_beo_equipment", "status")
this.MapAttribute("equipment_length", "n_cst_beo_equipment", "length")
this.MapAttribute("equipment_width", "n_cst_beo_equipment", "width")
this.MapAttribute("equipment_volume", "n_cst_beo_equipment", "volume")
this.MapAttribute("equipment_axles", "n_cst_beo_equipment", "axles")
this.MapAttribute("equipment_air", "n_cst_beo_equipment", "air")
this.MapAttribute("equipment_spec1", "n_cst_beo_equipment", "spec1")
this.MapAttribute("equipment_spec2", "n_cst_beo_equipment", "spec2")
this.MapAttribute("equipment_spec3", "n_cst_beo_equipment", "spec3")
this.MapAttribute("equipment_spec4", "n_cst_beo_equipment", "spec4")
this.MapAttribute("equipment_spec5", "n_cst_beo_equipment", "spec5")
this.MapAttribute("equipment_user1", "n_cst_beo_equipment", "user1")
this.MapAttribute("equipment_user2", "n_cst_beo_equipment", "user2")
this.MapAttribute("equipment_user3", "n_cst_beo_equipment", "user3")
this.MapAttribute("equipment_user4", "n_cst_beo_equipment", "user4")
this.MapAttribute("equipment_user5", "n_cst_beo_equipment", "user5")
this.MapAttribute("equipment_notes", "n_cst_beo_equipment", "notes")
this.MapAttribute("equipment_currentevent", "n_cst_beo_equipment", "currentevent")
this.MapAttribute("equipment_nextevent", "n_cst_beo_equipment", "nextevent")
this.MapAttribute("equipment_timestamp", "n_cst_beo_equipment", "timestamp")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("equipment")
this.MapDBColumn("equipment_id", "equipment", "eq_id", 1)
this.MapDBColumn("equipment_type", "equipment", "eq_type", 0)
this.MapDBColumn("equipment_number", "equipment", "eq_ref", 0)
this.MapDBColumn("equipment_leased", "equipment", "eq_outside", 0)
this.MapDBColumn("equipment_status", "equipment", "eq_status", 0)
this.MapDBColumn("equipment_length", "equipment", "eq_length", 0)
this.MapDBColumn("equipment_width", "equipment", "eq_height", 0)
this.MapDBColumn("equipment_volume", "equipment", "eq_volume", 0)
this.MapDBColumn("equipment_axles", "equipment", "eq_axles", 0)
this.MapDBColumn("equipment_air", "equipment", "eq_air", 0)
this.MapDBColumn("equipment_spec1", "equipment", "eq_spec1", 0)
this.MapDBColumn("equipment_spec2", "equipment", "eq_spec2", 0)
this.MapDBColumn("equipment_spec3", "equipment", "eq_spec3", 0)
this.MapDBColumn("equipment_spec4", "equipment", "eq_spec4", 0)
this.MapDBColumn("equipment_spec5", "equipment", "eq_spec5", 0)
this.MapDBColumn("equipment_user1", "equipment", "User1", 0)
this.MapDBColumn("equipment_user2", "equipment", "User2", 0)
this.MapDBColumn("equipment_user3", "equipment", "User3", 0)
this.MapDBColumn("equipment_user4", "equipment", "User4", 0)
this.MapDBColumn("equipment_user5", "equipment", "User5", 0)
this.MapDBColumn("equipment_notes", "equipment", "Notes", 0)
this.MapDBColumn("equipment_currentevent", "equipment", "eq_cur_event", 0)
this.MapDBColumn("equipment_nextevent", "equipment", "eq_next_event", 0)
this.MapDBColumn("equipment_timestamp", "equipment", "timestamp", 0)
//@(data)--

end event

