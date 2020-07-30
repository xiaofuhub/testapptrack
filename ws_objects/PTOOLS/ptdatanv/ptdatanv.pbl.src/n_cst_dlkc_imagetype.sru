$PBExportHeader$n_cst_dlkc_imagetype.sru
$PBExportComments$ImageType (DataLink from PBL map PTData) //@(*)[10376478|987:bdm]<nosync>
forward
global type n_cst_dlkc_imagetype from n_cst_dlk
end type
end forward

global type n_cst_dlkc_imagetype from n_cst_dlk
end type
global n_cst_dlkc_imagetype n_cst_dlkc_imagetype

forward prototypes
public function Integer ModifyWhereClause ()
end prototypes

public function Integer ModifyWhereClause ();//@(*)[10376478|987:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"imagetype~".~"topic~" = " + String(la_quotedargs[1])+ " AND ~"imagetype~".~"category~" = " + String(la_quotedargs[2])+ " AND ~"imagetype~".~"type~" = " + String(la_quotedargs[3])
   case "image"
      ls_append = " WHERE ~"imagetype~".~"topic~" = " + String(la_quotedargs[1])+ " AND ~"imagetype~".~"category~" = " + String(la_quotedargs[2])+ " AND ~"imagetype~".~"type~" = " + String(la_quotedargs[3])

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

on n_cst_dlkc_imagetype.create
TriggerEvent(this, "constructor")
end on

on n_cst_dlkc_imagetype.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_imagetype")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_imagetype", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("imagetype_topic", "n_cst_beo_imagetype", "topic")
this.MapAttribute("imagetype_category", "n_cst_beo_imagetype", "category")
this.MapAttribute("imagetype_type", "n_cst_beo_imagetype", "type")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("ImageType")
this.MapDBColumn("imagetype_topic", "ImageType", "Topic", 1)
this.MapDBColumn("imagetype_category", "ImageType", "Category", 1)
this.MapDBColumn("imagetype_type", "ImageType", "Type", 1)
//@(data)--

end event

