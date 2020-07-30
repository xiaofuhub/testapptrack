$PBExportHeader$n_cst_dlkc_amounttype.sru
$PBExportComments$AmountType (DataLink from PBL map PTSetl) //@(*)[209019889|543:bdm]<nosync>
forward
global type n_cst_dlkc_amounttype from n_cst_dlk
end type
end forward

global type n_cst_dlkc_amounttype from n_cst_dlk
end type
global n_cst_dlkc_amounttype n_cst_dlkc_amounttype

forward prototypes
public function integer modifywhereclause ()
end prototypes

public function integer modifywhereclause ();//@(*)[209019889|543:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"amounttype~".~"id~" = " + String(la_quotedargs[1])
   case "amounttemplate"
      ls_append = " WHERE ~"amounttype~".~"id~" = " + String(la_quotedargs[1])

   case "accountmap"
      ls_append = " WHERE ~"amounttype~".~"id~" = " + String(la_quotedargs[1])

END CHOOSE
if ls_append <> "" then
   ls_syntax = ls_syntax + ls_append
   if ids_view.SetSqlSelect(ls_syntax) < 0 then
      this.PushException("modifywhereclause")
      return -1
   end if
 end if
//@(text)--

//Custom Retrival Extensions

Boolean		lb_Custom
n_cst_Sql	lnv_Sql
Constant String	ls_AppendBase = "WHERE"

CHOOSE CASE is_dlk_relation
		
	case "surcharge"
		lb_Custom = TRUE
		ls_Append = " WHERE ~"amounttype~".~"surcharge~" = " + String(la_quotedargs[1])
	case "tag"
		lb_Custom = TRUE	
		ls_Append = " WHERE ~"amounttype~".~"tag~" = " + String(la_quotedargs[1])
END CHOOSE

IF lb_Custom = TRUE AND ls_Append <> "" THEN
	ls_syntax = ls_syntax + ls_append
	IF ids_view.SetSqlSelect(ls_syntax) < 0 THEN		
		this.pushException("modifywhereclause")
		return -1
	END IF
END IF
//@(text)(recreate=yes)<Return status>
return 1
//@(text)--

end function

on n_cst_dlkc_amounttype.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dlkc_amounttype.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_amounttype")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_amounttype", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("amounttype_id", "n_cst_beo_amounttype", "id")
this.MapAttribute("amounttype_name", "n_cst_beo_amounttype", "name")
this.MapAttribute("amounttype_category", "n_cst_beo_amounttype", "category")
this.MapAttribute("amounttype_typicalamount", "n_cst_beo_amounttype", "typicalamount")
this.MapAttribute("amounttype_taxabledefault", "n_cst_beo_amounttype", "taxabledefault")
this.MapAttribute("amounttype_tag", "n_cst_beo_amounttype", "tag")
this.MapAttribute("amounttype_itemtype", "n_cst_beo_amounttype", "itemtype")
this.MapAttribute("amounttype_surcharge", "n_cst_beo_amounttype", "surcharge")
this.MapAttribute("amounttype_sendnotification", "n_cst_beo_amounttype", "sendnotification")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("AmountType")
this.MapDBColumn("amounttype_id", "AmountType", "Id", 1)
this.MapDBColumn("amounttype_name", "AmountType", "Name", 0)
this.MapDBColumn("amounttype_category", "AmountType", "Category", 0)
this.MapDBColumn("amounttype_typicalamount", "AmountType", "TypicalAmount", 0)
this.MapDBColumn("amounttype_taxabledefault", "AmountType", "TaxableDefault", 0)
this.MapDBColumn("amounttype_tag", "AmountType", "Tag", 0)
this.MapDBColumn("amounttype_itemtype", "AmountType", "ItemType", 0)
this.MapDBColumn("amounttype_surcharge", "AmountType", "Surcharge", 0)
this.MapDBColumn("amounttype_sendnotification", "AmountType", "sendnotification", 0)
//@(data)--

end event

