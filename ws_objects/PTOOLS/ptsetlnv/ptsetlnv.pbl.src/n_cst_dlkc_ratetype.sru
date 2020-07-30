$PBExportHeader$n_cst_dlkc_ratetype.sru
$PBExportComments$RateType (DataLink from PBL map PTSetl) //@(*)[201691324|539:bdm]<nosync>
forward
global type n_cst_dlkc_ratetype from n_cst_dlk
end type
end forward

global type n_cst_dlkc_ratetype from n_cst_dlk
end type
global n_cst_dlkc_ratetype n_cst_dlkc_ratetype

forward prototypes
public function Integer ModifyWhereClause ()
end prototypes

public function Integer ModifyWhereClause ();//@(*)[201691324|539:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"ratetype~".~"id~" = " + String(la_quotedargs[1])
   case "amounttemplate"
      ls_append = " WHERE ~"ratetype~".~"id~" = " + String(la_quotedargs[1])

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

on n_cst_dlkc_ratetype.create
TriggerEvent(this, "constructor")
end on

on n_cst_dlkc_ratetype.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_ratetype")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_ratetype", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("ratetype_id", "n_cst_beo_ratetype", "id")
this.MapAttribute("ratetype_name", "n_cst_beo_ratetype", "name")
this.MapAttribute("ratetype_tag", "n_cst_beo_ratetype", "tag")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("RateType")
this.MapDBColumn("ratetype_id", "RateType", "Id", 1)
this.MapDBColumn("ratetype_name", "RateType", "Name", 0)
this.MapDBColumn("ratetype_tag", "RateType", "Tag", 0)
//@(data)--

end event

