$PBExportHeader$n_cst_dlkc_image.sru
$PBExportComments$Image (DataLink from PBL map PTData) //@(*)[49978537|1341:bdm]<nosync>
forward
global type n_cst_dlkc_image from n_cst_dlk
end type
end forward

global type n_cst_dlkc_image from n_cst_dlk
end type
global n_cst_dlkc_image n_cst_dlkc_image

forward prototypes
public function Integer ModifyWhereClause ()
end prototypes

public function Integer ModifyWhereClause ();//@(*)[49978537|1341:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
   case "imagetype"
      ls_append = " WHERE ~"image~".~"topic~" = " + String(la_quotedargs[1])+ " AND ~"image~".~"category~" = " + String(la_quotedargs[2])+ " AND ~"image~".~"type~" = " + String(la_quotedargs[3])

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

on n_cst_dlkc_image.create
TriggerEvent(this, "constructor")
end on

on n_cst_dlkc_image.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_image")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_image", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("image_filepath", "n_cst_beo_image", "filepath")
this.MapAttribute("image_id", "n_cst_beo_image", "id")
this.MapAttribute("image_topic", "n_cst_beo_image", "topic")
this.MapAttribute("image_category", "n_cst_beo_image", "category")
this.MapAttribute("image_type", "n_cst_beo_image", "type")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("Image")
this.MapDBColumn("image_filepath", "Image", "FilePath", 0)
this.MapDBColumn("image_id", "Image", "Id", 0)
this.MapDBColumn("image_topic", "Image", "Topic", 0)
this.MapDBColumn("image_category", "Image", "Category", 0)
this.MapDBColumn("image_type", "Image", "Type", 0)
//@(data)--

end event

