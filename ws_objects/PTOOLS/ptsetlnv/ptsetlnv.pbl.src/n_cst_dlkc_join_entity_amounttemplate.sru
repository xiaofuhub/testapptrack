$PBExportHeader$n_cst_dlkc_join_entity_amounttemplate.sru
$PBExportComments$AmountTemplate (DataLink from PBL map PTSetl) //@(*)[57511999|1459:dlk]<nosync>
forward
global type n_cst_dlkc_join_entity_amounttemplate from n_cst_dlk
end type
end forward

global type n_cst_dlkc_join_entity_amounttemplate from n_cst_dlk
end type
global n_cst_dlkc_join_entity_amounttemplate n_cst_dlkc_join_entity_amounttemplate

forward prototypes
public function Integer ModifyWhereClause ()
end prototypes

public function Integer ModifyWhereClause ();//@(*)[23640230|1283:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"join_entity_amounttemplate~".~"fkentity~" = " + String(la_quotedargs[1])+ " AND ~"join_entity_amounttemplate~".~"fkamounttemplate~" = " + String(la_quotedargs[2])
   case "entity"
      ls_append = " WHERE ~"join_entity_amounttemplate~".~"fkentity~" = " + String(la_quotedargs[1])

   case "amounttemplate"
      ls_append = " WHERE ~"join_entity_amounttemplate~".~"fkamounttemplate~" = " + String(la_quotedargs[1])

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

on n_cst_dlkc_join_entity_amounttemplate.create
TriggerEvent(this, "constructor")
end on

on n_cst_dlkc_join_entity_amounttemplate.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_join_entity_amounttemplate")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_join_entity_amounttemplate", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("join_entity_amounttemplate_fkentity", "n_cst_beo_join_entity_amounttemplate", "fkentity")
this.MapAttribute("join_entity_amounttemplate_fkamounttem01", "n_cst_beo_join_entity_amounttemplate", "fkamounttemplate")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("Join_Entity_AmountTemplate")
this.MapDBColumn("join_entity_amounttemplate_fkentity", "Join_Entity_AmountTemplate", "fkEntity", 1)
this.MapDBColumn("join_entity_amounttemplate_fkamounttem01", "Join_Entity_AmountTemplate", "fkAmountTemplate", 1)
//@(data)--

end event

