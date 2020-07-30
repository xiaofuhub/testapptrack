$PBExportHeader$n_cst_dlkc_amountowed.sru
$PBExportComments$AmountOwed (DataLink from PBL map PTSetl) //@(*)[103978905|60:bdm]<nosync>
forward
global type n_cst_dlkc_amountowed from n_cst_dlk
end type
end forward

global type n_cst_dlkc_amountowed from n_cst_dlk
end type
global n_cst_dlkc_amountowed n_cst_dlkc_amountowed

forward prototypes
public function integer modifywhereclause ()
end prototypes

public function integer modifywhereclause ();//@(*)[103978905|60:cdwc]<nosync>//@(-)Do not edit, move or copy this line//
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
      ls_append = " WHERE ~"amountowed~".~"id~" = " + String(la_quotedargs[1])
   case "entity"
      ls_append = " WHERE ~"amountowed~".~"fkentity~" = " + String(la_quotedargs[1])

   case "transaction"
      ls_append = " WHERE ~"amountowed~".~"fktransaction~" = " + String(la_quotedargs[1])

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

CHOOSE CASE is_dlk_relation

//CASE "EntityAmountsOwedOpen"
//	lb_Custom = TRUE
//	ls_Append = " WHERE ~"amountowed~".~"fkentity~" = " + String(la_quotedargs[1]) +&
//		" AND ~"amountowed~".~"open~" = 1"

CASE "EntityUnassignedAmounts"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"amountowed~".~"fkentity~" = " + String(la_quotedargs[1]) +&
		" AND ~"amountowed~".~"fktransaction~" IS NULL"

CASE "TransactionAmounts"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"amountowed~".~"fktransaction~"" + lnv_Sql.of_MakeInClause ( la_QuotedArgs[1] )

CASE "IdInRef1"

	//la_QuotedArgs[1] is the id of a RefType.  This is optional.
	//la_QuotedArgs[2] is an array of Ids (Longs)

	lb_Custom = TRUE

	//Note:  The array contains ids as longs.  MakeStringInClause will give a list of the ids as strings.
	ls_Append = " WHERE ~"amountowed~".~"ref1text~"" + lnv_Sql.of_MakeStringInClause ( la_QuotedArgs[2] )

	IF NOT IsNull ( la_QuotedArgs [1] ) THEN
		ls_Append += " AND ~"amountowed~".~"ref1type~" = " + String ( la_QuotedArgs[1] )
	END IF

CASE "SameDistribution"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"amountowed~".~"division~" = " + String(la_quotedargs[1]) + " AND ~"amountowed~".~"type~" = " + String ( la_QuotedArgs[2] ) + " AND ~"amountowed~".~"fktransaction~" = " + String ( la_QuotedArgs[3] )

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

on n_cst_dlkc_amountowed.create
call super::create
end on

on n_cst_dlkc_amountowed.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_dlkc_amountowed")
this.SetIsClassDLK(TRUE)
inv_bcm.AddClass("n_cst_beo_amountowed", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("amountowed_id", "n_cst_beo_amountowed", "id")
this.MapAttribute("amountowed_category", "n_cst_beo_amountowed", "category")
this.MapAttribute("amountowed_type", "n_cst_beo_amountowed", "type")
this.MapAttribute("amountowed_division", "n_cst_beo_amountowed", "division")
this.MapAttribute("amountowed_startdate", "n_cst_beo_amountowed", "startdate")
this.MapAttribute("amountowed_enddate", "n_cst_beo_amountowed", "enddate")
this.MapAttribute("amountowed_amount", "n_cst_beo_amountowed", "amount")
this.MapAttribute("amountowed_status", "n_cst_beo_amountowed", "status")
this.MapAttribute("amountowed_open", "n_cst_beo_amountowed", "open")
this.MapAttribute("amountowed_description", "n_cst_beo_amountowed", "description")
this.MapAttribute("amountowed_internalnote", "n_cst_beo_amountowed", "internalnote")
this.MapAttribute("amountowed_publicnote", "n_cst_beo_amountowed", "publicnote")
this.MapAttribute("amountowed_ref1type", "n_cst_beo_amountowed", "ref1type")
this.MapAttribute("amountowed_ref1text", "n_cst_beo_amountowed", "ref1text")
this.MapAttribute("amountowed_ref2type", "n_cst_beo_amountowed", "ref2type")
this.MapAttribute("amountowed_ref2text", "n_cst_beo_amountowed", "ref2text")
this.MapAttribute("amountowed_ref3type", "n_cst_beo_amountowed", "ref3type")
this.MapAttribute("amountowed_ref3text", "n_cst_beo_amountowed", "ref3text")
this.MapAttribute("amountowed_ratetype", "n_cst_beo_amountowed", "ratetype")
this.MapAttribute("amountowed_quantity", "n_cst_beo_amountowed", "quantity")
this.MapAttribute("amountowed_rate", "n_cst_beo_amountowed", "rate")
this.MapAttribute("amountowed_taxable", "n_cst_beo_amountowed", "taxable")
this.MapAttribute("amountowed_modlog", "n_cst_beo_amountowed", "modlog")
this.MapAttribute("amountowed_fktransaction", "n_cst_beo_amountowed", "fktransaction")
this.MapAttribute("amountowed_fkentity", "n_cst_beo_amountowed", "fkentity")
this.MapAttribute("amountowed_driver", "n_cst_beo_amountowed", "driver")
this.MapAttribute("amountowed_truck", "n_cst_beo_amountowed", "truck")
this.MapAttribute("amountowed_trailer", "n_cst_beo_amountowed", "trailer")
this.MapAttribute("amountowed_container", "n_cst_beo_amountowed", "container")
this.MapAttribute("amountowed_shipment", "n_cst_beo_amountowed", "shipment")
this.MapAttribute("amountowed_trip", "n_cst_beo_amountowed", "trip")
this.MapAttribute("ratecodename", "n_cst_beo_amountowed", "ratecodename")
this.MapAttribute("lastmodifiedby", "n_cst_beo_amountowed", "lastmodifiedby")
this.MapAttribute("originzone", "n_cst_beo_amountowed", "originzone")
this.MapAttribute("destinationzone", "n_cst_beo_amountowed", "destinationzone")
this.MapAttribute("billtoid", "n_cst_beo_amountowed", "billtoid")
//@(data)--


//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("AmountOwed")
this.MapDBColumn("amountowed_id", "AmountOwed", "Id", 1)
this.MapDBColumn("amountowed_category", "AmountOwed", "Category", 0)
this.MapDBColumn("amountowed_type", "AmountOwed", "Type", 0)
this.MapDBColumn("amountowed_division", "AmountOwed", "Division", 0)
this.MapDBColumn("amountowed_startdate", "AmountOwed", "StartDate", 0)
this.MapDBColumn("amountowed_enddate", "AmountOwed", "EndDate", 0)
this.MapDBColumn("amountowed_amount", "AmountOwed", "Amount", 0)
this.MapDBColumn("amountowed_status", "AmountOwed", "Status", 0)
this.MapDBColumn("amountowed_open", "AmountOwed", "Open", 0)
this.MapDBColumn("amountowed_description", "AmountOwed", "Description", 0)
this.MapDBColumn("amountowed_internalnote", "AmountOwed", "InternalNote", 0)
this.MapDBColumn("amountowed_publicnote", "AmountOwed", "PublicNote", 0)
this.MapDBColumn("amountowed_ref1type", "AmountOwed", "Ref1Type", 0)
this.MapDBColumn("amountowed_ref1text", "AmountOwed", "Ref1Text", 0)
this.MapDBColumn("amountowed_ref2type", "AmountOwed", "Ref2Type", 0)
this.MapDBColumn("amountowed_ref2text", "AmountOwed", "Ref2Text", 0)
this.MapDBColumn("amountowed_ref3type", "AmountOwed", "Ref3Type", 0)
this.MapDBColumn("amountowed_ref3text", "AmountOwed", "Ref3Text", 0)
this.MapDBColumn("amountowed_ratetype", "AmountOwed", "RateType", 0)
this.MapDBColumn("amountowed_quantity", "AmountOwed", "Quantity", 0)
this.MapDBColumn("amountowed_rate", "AmountOwed", "Rate", 0)
this.MapDBColumn("amountowed_taxable", "AmountOwed", "Taxable", 0)
this.MapDBColumn("amountowed_modlog", "AmountOwed", "ModLog", 0)
this.MapDBColumn("amountowed_fktransaction", "AmountOwed", "fkTransaction", 0)
this.MapDBColumn("amountowed_fkentity", "AmountOwed", "fkEntity", 0)
this.MapDBColumn("amountowed_driver", "AmountOwed", "Driver", 0)
this.MapDBColumn("amountowed_truck", "AmountOwed", "Truck", 0)
this.MapDBColumn("amountowed_trailer", "AmountOwed", "Trailer", 0)
this.MapDBColumn("amountowed_container", "AmountOwed", "Container", 0)
this.MapDBColumn("amountowed_shipment", "AmountOwed", "Shipment", 0)
this.MapDBColumn("amountowed_trip", "AmountOwed", "Trip", 0)
this.MapDBColumn("ratecodename", "AmountOwed", "ratecodename", 0)
this.MapDBColumn("lastmodifiedby", "AmountOwed", "lastmodifiedby", 0)
this.MapDBColumn("originzone", "AmountOwed", "originzone", 0)
this.MapDBColumn("destinationzone", "AmountOwed", "destinationzone", 0)
this.MapDBColumn("billtoid", "AmountOwed", "billtoid", 0)
//@(data)--

end event

