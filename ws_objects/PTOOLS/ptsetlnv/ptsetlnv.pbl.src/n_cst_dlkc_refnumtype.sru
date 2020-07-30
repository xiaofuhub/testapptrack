$PBExportHeader$n_cst_dlkc_refnumtype.sru
$PBExportComments$RefnumType (DataLink from PBL map PTSetl) //@(*)[70821555|660:bdm]<nosync>
forward
global type n_cst_dlkc_refnumtype from n_cst_dlk
end type
end forward

global type n_cst_dlkc_refnumtype from n_cst_dlk
end type
global n_cst_dlkc_refnumtype n_cst_dlkc_refnumtype

forward prototypes
public function Integer ModifyWhereClause ()
end prototypes

public function Integer ModifyWhereClause ();//@(*)[70821555|660:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"refnumtype~".~"id~" = " + String(la_quotedargs[1])
   case "amounttemplate"
      ls_append = " WHERE ~"refnumtype~".~"id~" = " + String(la_quotedargs[1])

   case "amounttemplate_2"
      ls_append = " WHERE ~"refnumtype~".~"id~" = " + String(la_quotedargs[1])

   case "amounttemplate_3"
      ls_append = " WHERE ~"refnumtype~".~"id~" = " + String(la_quotedargs[1])

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

on n_cst_dlkc_refnumtype.create
TriggerEvent(this, "constructor")
end on

on n_cst_dlkc_refnumtype.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_refnumtype")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_refnumtype", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("refnumtype_id", "n_cst_beo_refnumtype", "id")
this.MapAttribute("refnumtype_name", "n_cst_beo_refnumtype", "name")
this.MapAttribute("refnumtype_tag", "n_cst_beo_refnumtype", "tag")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("RefnumType")
this.MapDBColumn("refnumtype_id", "RefnumType", "Id", 1)
this.MapDBColumn("refnumtype_name", "RefnumType", "Name", 0)
this.MapDBColumn("refnumtype_tag", "RefnumType", "Tag", 0)
//@(data)--

end event

