$PBExportHeader$n_cst_dlkc_entity.sru
$PBExportComments$Entity (DataLink from PBL map PTSetl) //@(*)[104234622|62:bdm]<nosync>
forward
global type n_cst_dlkc_entity from n_cst_dlk
end type
end forward

global type n_cst_dlkc_entity from n_cst_dlk
end type
global n_cst_dlkc_entity n_cst_dlkc_entity

forward prototypes
public function Integer ModifyWhereClause ()
end prototypes

public function Integer ModifyWhereClause ();//@(*)[104234622|62:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"entity~".~"id~" = " + String(la_quotedargs[1])
   case "amountowed"
      ls_append = " WHERE ~"entity~".~"id~" = " + String(la_quotedargs[1])

   case "transaction"
      ls_append = " WHERE ~"entity~".~"id~" = " + String(la_quotedargs[1])

   case "employee"
      ls_append = " WHERE ~"entity~".~"fkemployee~" = " + String(la_quotedargs[1])

   case "amounttemplate"
      ls_append = " WHERE ~"join_entity_amounttemplate~".~"fkamounttemplate~" = " + String(la_quotedargs[1])+ " AND ~"entity~".~"id~" = ~"join_entity_amounttemplate~".~"fkentity~""
   ls_syntax = Replace(ls_syntax, Pos(ls_syntax, "FROM "), 5, "FROM ~"join_entity_amounttemplate~", ")
END CHOOSE
if ls_append <> "" then
   ls_syntax = ls_syntax + ls_append
   if ids_view.SetSqlSelect(ls_syntax) < 0 then
      this.PushException("modifywhereclause")
      return -1
   end if
 end if
//@(text)--


//Custom Retrieval Extensions

Boolean	lb_Custom
n_cst_Sql	lnv_Sql
Constant String		ls_AppendBase = " WHERE "

CHOOSE CASE is_dlk_relation

CASE "Ids"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"entity~".~"id~"" + lnv_Sql.of_MakeInClause ( la_QuotedArgs[1] )

END CHOOSE

IF lb_Custom = TRUE AND &
	ls_Append <> "" THEN

   ls_syntax = ls_syntax + ls_append
   if ids_view.SetSqlSelect(ls_syntax) < 0 then
      this.PushException("modifywhereclause")
      return -1
   end if

END IF

//@(text)(recreate=yes)<Return status>
return 1
//@(text)--

end function

on n_cst_dlkc_entity.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dlkc_entity.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_entity")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_entity", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("entity_id", "n_cst_beo_entity", "id")
this.MapAttribute("entity_companyid", "n_cst_beo_entity", "companyid")
this.MapAttribute("entity_receivablesid", "n_cst_beo_entity", "receivablesid")
this.MapAttribute("entity_payablesid", "n_cst_beo_entity", "payablesid")
this.MapAttribute("entity_payrollid", "n_cst_beo_entity", "payrollid")
this.MapAttribute("entity_division", "n_cst_beo_entity", "division")
this.MapAttribute("entity_fkemployee", "n_cst_beo_entity", "fkemployee")
this.MapAttribute("entity_fuelcardfeemarkup", "n_cst_beo_entity", "fuelcardfeemarkup")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("Entity")
this.MapDBColumn("entity_id", "Entity", "Id", 1)
this.MapDBColumn("entity_companyid", "Entity", "fkCompany", 0)
this.MapDBColumn("entity_receivablesid", "Entity", "ReceivablesId", 0)
this.MapDBColumn("entity_payablesid", "Entity", "PayablesId", 0)
this.MapDBColumn("entity_payrollid", "Entity", "PayrollId", 0)
this.MapDBColumn("entity_division", "Entity", "Division", 0)
this.MapDBColumn("entity_fkemployee", "Entity", "fkEmployee", 0)
this.MapDBColumn("entity_fuelcardfeemarkup", "Entity", "fuelcardfeemarkup", 0)
//@(data)--

end event

