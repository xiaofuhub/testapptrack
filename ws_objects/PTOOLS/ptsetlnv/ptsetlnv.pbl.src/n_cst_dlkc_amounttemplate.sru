$PBExportHeader$n_cst_dlkc_amounttemplate.sru
$PBExportComments$AmountTemplate (DataLink from PBL map PTSetl) //@(*)[23640230|1283:bdm]<nosync>
forward
global type n_cst_dlkc_amounttemplate from n_cst_dlk
end type
end forward

global type n_cst_dlkc_amounttemplate from n_cst_dlk
end type
global n_cst_dlkc_amounttemplate n_cst_dlkc_amounttemplate

forward prototypes
public function integer modifywhereclause ()
end prototypes

public function integer modifywhereclause ();//@(*)[23640230|1283:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"amounttemplate~".~"id~" = " + String(la_quotedargs[1])
   case "ref1type"
      ls_append = " WHERE ~"amounttemplate~".~"ref1typeid~" = " + String(la_quotedargs[1])

   case "ref2type"
      ls_append = " WHERE ~"amounttemplate~".~"ref2typeid~" = " + String(la_quotedargs[1])

   case "ref3type"
      ls_append = " WHERE ~"amounttemplate~".~"ref3typeid~" = " + String(la_quotedargs[1])

   case "ratetype"
      ls_append = " WHERE ~"amounttemplate~".~"ratetypeid~" = " + String(la_quotedargs[1])

   case "amounttype"
      ls_append = " WHERE ~"amounttemplate~".~"amounttypeid~" = " + String(la_quotedargs[1])

//   JMA 09.16.2002  removed existing 'entity' case; replace it with where clause that will
//      obtain both entity and global templates
//
//      old code below (commented out)
//   case "entity"
//      ls_append = " WHERE ~"join_entity_amounttemplate~".~"fkentity~" = " + String(la_quotedargs[1])+ " AND ~"amounttemplate~".~"id~" = ~"join_entity_amounttemplate~".~"fkamounttemplate~""
//   ls_syntax = Replace(ls_syntax, Pos(ls_syntax, "FROM "), 5, "FROM ~"join_entity_amounttemplate~", ")

   case "entity"
      ls_append = " WHERE (~"amounttemplate~".~"id~" in (select ~"join_entity_amounttemplate~".~"fkamounttemplate~" FROM ~"join_entity_amounttemplate~" WHERE ~"join_entity_amounttemplate~".~"fkentity~" = " + String(la_quotedargs[1]) + ")) OR  ~"amounttemplate~".~"fkentity~" = " + String(la_quotedargs[1])

	
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
	case "global"
	lb_Custom = TRUE
	ls_Append = " where id not in ( select fkamounttemplate from join_entity_amounttemplate )"
		
CASE "ids"
	lb_Custom = TRUE
	ls_Append = " WHERE id " + lnv_Sql.of_MakeInClause ( la_QuotedArgs[1] )


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

on n_cst_dlkc_amounttemplate.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dlkc_amounttemplate.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_amounttemplate")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_amounttemplate", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("amounttemplate_id", "n_cst_beo_amounttemplate", "id")
this.MapAttribute("amounttemplate_name", "n_cst_beo_amounttemplate", "name")
this.MapAttribute("amounttemplate_category", "n_cst_beo_amounttemplate", "category")
this.MapAttribute("amounttemplate_division", "n_cst_beo_amounttemplate", "division")
this.MapAttribute("amounttemplate_generationcondition", "n_cst_beo_amounttemplate", "generationcondition")
this.MapAttribute("amounttemplate_generateifzero", "n_cst_beo_amounttemplate", "generateifzero")
this.MapAttribute("amounttemplate_description", "n_cst_beo_amounttemplate", "description")
this.MapAttribute("amounttemplate_quantity", "n_cst_beo_amounttemplate", "quantity")
this.MapAttribute("amounttemplate_rate", "n_cst_beo_amounttemplate", "rate")
this.MapAttribute("amounttemplate_amount", "n_cst_beo_amounttemplate", "amount")
this.MapAttribute("amounttemplate_ref1text", "n_cst_beo_amounttemplate", "ref1text")
this.MapAttribute("amounttemplate_ref2text", "n_cst_beo_amounttemplate", "ref2text")
this.MapAttribute("amounttemplate_ref3text", "n_cst_beo_amounttemplate", "ref3text")
this.MapAttribute("amounttemplate_ref1typeid", "n_cst_beo_amounttemplate", "ref1typeid")
this.MapAttribute("amounttemplate_ref2typeid", "n_cst_beo_amounttemplate", "ref2typeid")
this.MapAttribute("amounttemplate_ref3typeid", "n_cst_beo_amounttemplate", "ref3typeid")
this.MapAttribute("amounttemplate_ratetypeid", "n_cst_beo_amounttemplate", "ratetypeid")
this.MapAttribute("amounttemplate_amounttypeid", "n_cst_beo_amounttemplate", "amounttypeid")
this.MapAttribute("amounttemplate_aggregatecalc", "n_cst_beo_amounttemplate", "aggregatecalc")
this.MapAttribute("amounttemplate_splitsby", "n_cst_beo_amounttemplate", "splitsby")
this.MapAttribute("amounttemplate_type", "n_cst_beo_amounttemplate", "type")
this.MapAttribute("amounttemplate_selectionfilter", "n_cst_beo_amounttemplate", "selectionfilter")
this.MapAttribute("amounttemplate_fkentity", "n_cst_beo_amounttemplate", "fkentity")
this.MapAttribute("amounttemplate_intervaltype", "n_cst_beo_amounttemplate", "intervaltype")
this.MapAttribute("amounttemplate_interval", "n_cst_beo_amounttemplate", "interval")
this.MapAttribute("amounttemplate_activationdate", "n_cst_beo_amounttemplate", "activationdate")
this.MapAttribute("amounttemplate_targettotal", "n_cst_beo_amounttemplate", "targettotal")
this.MapAttribute("amounttemplate_runningtotal", "n_cst_beo_amounttemplate", "runningtotal")
this.MapAttribute("amounttemplate_runningcount", "n_cst_beo_amounttemplate", "runningcount")
this.MapAttribute("amounttemplate_lastamount", "n_cst_beo_amounttemplate", "lastamount")
this.MapAttribute("amounttemplate_lastdate", "n_cst_beo_amounttemplate", "lastdate")
this.MapAttribute("amounttemplate_firstdate", "n_cst_beo_amounttemplate", "firstdate")
this.MapAttribute("amounttemplate_custom1", "n_cst_beo_amounttemplate", "custom1")
this.MapAttribute("amounttemplate_custom2", "n_cst_beo_amounttemplate", "custom2")
this.MapAttribute("amounttemplate_custom3", "n_cst_beo_amounttemplate", "custom3")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("AmountTemplate")
this.MapDBColumn("amounttemplate_id", "AmountTemplate", "Id", 1)
this.MapDBColumn("amounttemplate_name", "AmountTemplate", "Name", 0)
this.MapDBColumn("amounttemplate_category", "AmountTemplate", "Category", 0)
this.MapDBColumn("amounttemplate_division", "AmountTemplate", "Division", 0)
this.MapDBColumn("amounttemplate_generationcondition", "AmountTemplate", "GenerationCondition", 0)
this.MapDBColumn("amounttemplate_generateifzero", "AmountTemplate", "GenerateIfZero", 0)
this.MapDBColumn("amounttemplate_description", "AmountTemplate", "Description", 0)
this.MapDBColumn("amounttemplate_quantity", "AmountTemplate", "Quantity", 0)
this.MapDBColumn("amounttemplate_rate", "AmountTemplate", "Rate", 0)
this.MapDBColumn("amounttemplate_amount", "AmountTemplate", "Amount", 0)
this.MapDBColumn("amounttemplate_ref1text", "AmountTemplate", "Ref1Text", 0)
this.MapDBColumn("amounttemplate_ref2text", "AmountTemplate", "Ref2Text", 0)
this.MapDBColumn("amounttemplate_ref3text", "AmountTemplate", "Ref3Text", 0)
this.MapDBColumn("amounttemplate_ref1typeid", "AmountTemplate", "Ref1TypeId", 0)
this.MapDBColumn("amounttemplate_ref2typeid", "AmountTemplate", "Ref2TypeId", 0)
this.MapDBColumn("amounttemplate_ref3typeid", "AmountTemplate", "Ref3TypeId", 0)
this.MapDBColumn("amounttemplate_ratetypeid", "AmountTemplate", "RateTypeId", 0)
this.MapDBColumn("amounttemplate_amounttypeid", "AmountTemplate", "AmountTypeId", 0)
this.MapDBColumn("amounttemplate_aggregatecalc", "AmountTemplate", "AggregateCalc", 0)
this.MapDBColumn("amounttemplate_splitsby", "AmountTemplate", "SplitsBy", 0)
this.MapDBColumn("amounttemplate_type", "AmountTemplate", "Type", 0)
this.MapDBColumn("amounttemplate_selectionfilter", "AmountTemplate", "SelectionFilter", 0)
this.MapDBColumn("amounttemplate_fkentity", "AmountTemplate", "fkentity", 0)
this.MapDBColumn("amounttemplate_intervaltype", "AmountTemplate", "IntervalType", 0)
this.MapDBColumn("amounttemplate_interval", "AmountTemplate", "Interval", 0)
this.MapDBColumn("amounttemplate_activationdate", "AmountTemplate", "ActivationDate", 0)
this.MapDBColumn("amounttemplate_targettotal", "AmountTemplate", "TargetTotal", 0)
this.MapDBColumn("amounttemplate_runningtotal", "AmountTemplate", "RunningTotal", 0)
this.MapDBColumn("amounttemplate_runningcount", "AmountTemplate", "RunningCount", 0)
this.MapDBColumn("amounttemplate_lastamount", "AmountTemplate", "LastAmount", 0)
this.MapDBColumn("amounttemplate_lastdate", "AmountTemplate", "LastDate", 0)
this.MapDBColumn("amounttemplate_firstdate", "AmountTemplate", "FirstDate", 0)
this.MapDBColumn("amounttemplate_custom1", "AmountTemplate", "Custom1", 0)
this.MapDBColumn("amounttemplate_custom2", "AmountTemplate", "Custom2", 0)
this.MapDBColumn("amounttemplate_custom3", "AmountTemplate", "Custom3", 0)
//@(data)--

end event

